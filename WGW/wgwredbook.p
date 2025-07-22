/*------------------------------------------------------------------------------
  Program id: wgwredbook.p   
  Parameters:  <none>
  Notes: find Redbook   
------------------------------------------------------------------------------*/
/* Modify by : Ranu I. A64-0369 เพิ่มการค้นหาข้อมูลรุ่นรถที่ตรงกับไฟล์ */
/*-------------------------------------------------------------------*/
DEFINE INPUT PARAMETER nv_makdes  as char format "x(25)" .
DEFINE INPUT PARAMETER nv_moddes  as char format "x(25)" .
DEFINE INPUT PARAMETER nv_si      as INT  format ">>>,>>>,>>9" .
DEFINE INPUT PARAMETER nv_tariff  AS CHAR FORMAT "x(1)" .
DEFINE INPUT PARAMETER nv_class   AS CHAR FORMAT "x(4)" .
DEFINE INPUT PARAMETER nv_caryear AS INT FORMAT "9999" .
DEFINE INPUT PARAMETER nv_engcc      AS INT FORMAT "9999" .
DEFINE INPUT PARAMETER nv_ton    AS DECI FORMAT ">>.99" .
DEFINE INPUT-OUTPUT PARAMETER nv_redbook AS CHAR FORMAT "x(10)" .

/*DEFINE var  nv_makdes  as char format "x(25)" .
DEFINE var  nv_moddes  as char format "x(25)" .
DEFINE var  nv_si      as INT  format ">>>,>>>,>>9" .
DEFINE var  nv_tariff  AS CHAR FORMAT "x(1)" . 
DEFINE var  nv_class   AS CHAR FORMAT "x(4)" .
DEFINE var  nv_caryear AS INT FORMAT "9999" .
DEFINE var  nv_engcc   AS INT FORMAT "9999" .
DEFINE VAR  nv_ton     AS DECI FORMAT ">>.99" .
DEFINE VAR  nv_redbook AS CHAR FORMAT "x(10)" .*/

DEFINE VAR nv_redbookmin AS CHAR FORMAT "x(10)" .       /*A64-0369*/
DEFINE VAR nv_simin   AS DECI FORMAT ">>>,>>>,>>>,>>9". /*A64-0369*/
DEFINE VAR nv_rsimin  AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_rsimax  AS INTE FORMAT ">>>,>>>,>>>,>>9".
DEFINE VAR nv_simaxp  AS DECI FORMAT ">>9.99-" INIT 20.
DEFINE VAR nv_siminp  AS DECI FORMAT ">>9.99-" INIT 20.
DEFINE VAR nv_moddes1 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes2 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes3 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes4 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes5 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_moddes6 AS CHAR FORMAT "X(20)".
DEFINE VAR nv_count   AS INTE INIT 0.
DEFINE VAR rm_modcod  AS CHAR.
DEFINE VAR rm_moddes  AS CHAR FORMAT "X(60)".
DEFINE VAR nv_supe    AS LOGICAL .
DEFINE VAR nv_spcflg  AS CHAR.
DO:
    rm_modcod = "".
    nv_redbookmin = "" .

    /* nv_tariff  = "X" .             nv_tariff  = "X" .      */    
    /* nv_class   = "110" .           nv_class   = "320" .    */    
    /* nv_caryear = 2018 .            nv_caryear = 2004 .     */    
    /* nv_engcc   = 2200 .            nv_engcc   = 0 .        */    
    /* nv_ton     = 0 .               nv_ton     = 2.5 .      */    
    /* nv_makdes = "ford " .          nv_makdes  = "ISUZU" .  */    
    /*  nv_moddes = "ranger dcap 4x2 hi-rider" .    nv_moddes  = "D-Max" .  */   
    /* nv_si     = 380000.           nv_si      = 0.         */   
    
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
           makdes31.makdes = nv_tariff AND 
           makdes31.moddes = nv_class 
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE makdes31 THEN DO: 
    ASSIGN
        nv_simaxp = makdes31.si_theft_p 
        nv_siminp = makdes31.load_p.
    END.
    IF INDEX(nv_moddes," ")  <> 0 THEN nv_moddes1 = TRIM(SUBSTR(nv_moddes,1,R-INDEX(nv_moddes," ") - 1)).
    IF INDEX(nv_moddes1," ") <> 0 THEN nv_moddes2 = TRIM(SUBSTR(nv_moddes1,1,R-INDEX(nv_moddes1," ") - 1)).
    IF INDEX(nv_moddes2," ") <> 0 THEN nv_moddes3 = TRIM(SUBSTR(nv_moddes2,1,R-INDEX(nv_moddes2," ") - 1)).
    IF INDEX(nv_moddes3," ") <> 0 THEN nv_moddes4 = TRIM(SUBSTR(nv_moddes3,1,R-INDEX(nv_moddes3," ") - 1)).
    IF INDEX(nv_moddes4," ") <> 0 THEN nv_moddes5 = TRIM(SUBSTR(nv_moddes4,1,R-INDEX(nv_moddes4," ") - 1)).
    IF INDEX(nv_moddes5," ") <> 0 THEN nv_moddes6 = TRIM(SUBSTR(nv_moddes5,1,R-INDEX(nv_moddes5," ") - 1)).
    
    rm_modcod = "".
    nv_count  = 0.
    rm_moddes = nv_moddes.
    
    loop_modcod:
    REPEAT:
        nv_count = nv_count + 1.
    
        IF nv_count  = 1 THEN DO: 
            IF nv_moddes <> "" THEN rm_moddes = TRIM(nv_moddes). 
        END.
        ELSE IF nv_count  = 2 THEN DO: 
            IF nv_moddes1 <> "" THEN rm_moddes = TRIM(nv_moddes1).
        END.
        ELSE IF nv_count  = 3 THEN DO: 
            IF nv_moddes2 <> "" THEN rm_moddes = TRIM(nv_moddes2).
        END.
        ELSE IF nv_count  = 4 THEN DO: 
            IF nv_moddes3 <> "" THEN rm_moddes = TRIM(nv_moddes3).
        END.
        ELSE IF nv_count  = 5 THEN DO: 
            IF nv_moddes4 <> "" THEN rm_moddes = TRIM(nv_moddes4).
        END.
        ELSE IF nv_count  = 6 THEN DO: 
            IF nv_moddes5 <> "" THEN rm_moddes = TRIM(nv_moddes5).
        END.
        ELSE IF nv_count  = 7 THEN DO: 
            IF nv_moddes6 <> "" THEN rm_moddes = TRIM(nv_moddes6).
        END.
        ELSE IF nv_count >= 8 THEN LEAVE loop_modcod.
    
        IF nv_ton <> 0 AND nv_ton < 100  THEN nv_ton = nv_ton * 1000 .
        FOR EACH stat.maktab_fil USE-INDEX maktab02 WHERE
                maktab_fil.sclass  = nv_class    AND
                maktab_fil.makdes  = nv_makdes            AND
                (INDEX(maktab_fil.moddes,rm_moddes) <> 0   OR
                 INDEX(rm_moddes,maktab_fil.moddes) <> 0 ) AND /*A64-0369*/
                maktab_fil.makyea  = nv_caryear AND
                (maktab_fil.engine = INT(nv_engcc)   OR 
                maktab_fil.tons    = deci(nv_ton))   NO-LOCK BY maktab_fil.si :

           /* DISP  maktab_fil.modcod FORMAT "x(10)"  maktab_fil.engine maktab_fil.si .*/

           IF nv_si < maktab_fil.si AND nv_redbookmin = "" THEN ASSIGN nv_redbookmin = maktab_fil.modcod nv_simin = maktab_fil.si .
           
           nv_rsimax = maktab_fil.si + ((maktab_fil.si * nv_simaxp) / 100).
           nv_rsimin = maktab_fil.si - ((maktab_fil.si * nv_siminp) / 100).

          
           /* add : A64-0369 */ 
           IF nv_si = 0  THEN DO:
              rm_modcod = maktab_fil.modcod.
              nv_supe   = maktab_fil.impchg.

              IF nv_supe   = YES THEN nv_spcflg = "YES". ELSE nv_spcflg = "NO".
           END.
           /* end : A64-0369 */
           ELSE IF nv_rsimin <= nv_si AND nv_rsimax >= nv_si THEN DO:
               IF (maktab_fil.si - nv_si ) > 0 THEN DO:
                  IF (maktab_fil.si) >= nv_si THEN DO:
                       rm_modcod = maktab_fil.modcod.
                       nv_supe   = maktab_fil.impchg.
   
                       IF nv_supe   = YES THEN nv_spcflg = "YES". ELSE nv_spcflg = "NO".
                   END.
               END.
               ELSE DO:
                   IF (maktab_fil.si) <= nv_si THEN DO:
                      rm_modcod = maktab_fil.modcod.
                      nv_supe   = maktab_fil.impchg.
                      IF nv_supe   = YES THEN nv_spcflg = "YES". ELSE nv_spcflg = "NO".
                   END.
               
               END.
           END.
           IF rm_modcod <> "" THEN LEAVE loop_modcod.
        END. /* end for */
        IF rm_modcod <> "" THEN LEAVE loop_modcod.
    END. /* end repeat */
    nv_redbook  = rm_modcod .
    IF nv_redbook = "" THEN nv_redbook = nv_redbookmin .

    /*DISP nv_redbook nv_redbookmin nv_simin .*/

    IF nv_tariff = "9" AND nv_redbook = ""   THEN DO:
         FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE 
             TRIM(xmm102.moddes) = trim(nv_makdes) + " " + trim(rm_moddes)  NO-LOCK NO-ERROR .
         IF AVAIL sicsyac.xmm102 THEN  rm_modcod = xmm102.modcod.
         ELSE DO:
             FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE 
                  INDEX(xmm102.moddes,nv_makdes) <> 0     NO-LOCK NO-ERROR .
             IF AVAIL sicsyac.xmm102 THEN  rm_modcod = xmm102.modcod.
         END.
        nv_redbook  = rm_modcod .
    END.
  
END.


