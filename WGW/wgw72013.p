/* UZO72013.P  -- calculate premium due (PD)              */
/* uw/uwxmin39 -- calculate premium due (PD)              */
/* Copyright   # Safety Insurance Public Company Limited  */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)       */
/* WRITE  BY   : sombat , 19/08/1999                      */
/*             : แก้ไขคำนวณเบี้ยทศนิยม 2 ตำแหน่ง          */
/* ------------------------------------------------------ */


DEFINE INPUT        PARAMETER  nv_rec100  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nv_red132  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nvtariff   AS CHARACTER NO-UNDO.

DEF            VAR n_dcover   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_dyear    AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR nvyear     AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_day1     AS   INT FORMAT "99"    INITIAL[31].
DEF            VAR n_mon1     AS   INT FORMAT "99"    INITIAL[12].
DEF            VAR n_ddyr     AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_ddyr1    AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_dmonth   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_orgnap   LIKE sic_bran.uwd132.gap_c  NO-UNDO.
DEF            VAR s_curbil   LIKE sic_bran.uwm100.curbil NO-UNDO.

def              var  n_total   as deci  no-undo.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) EQ nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ nv_red132 NO-WAIT NO-ERROR.

s_curbil = sic_bran.uwm100.curbil.
n_orgnap = sic_bran.uwd132.gap_c.

IF sic_bran.uwm100.expdat EQ ? OR  sic_bran.uwm100.comdat EQ ? THEN sic_bran.uwd132.prem_c = n_orgnap.

IF nvtariff = "Z" OR nvtariff = "X" THEN DO:
   sic_bran.uwd132.prem_c = n_orgnap.
END.
ELSE DO:
  IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
    ASSIGN n_dcover = 0
           n_dyear  = 0
           nvyear   = 0
           n_dmonth = 0.
    /*
    n_dcover = uwm100.expdat - uwm100.comdat + 1.
    */

    /* --- ปรับการคำนวณวันที่ --- */

                IF ( DAY(sic_bran.uwm100.comdat)     =   DAY(sic_bran.uwm100.expdat)    AND
                   MONTH(sic_bran.uwm100.comdat)     = MONTH(sic_bran.uwm100.expdat)    AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
                   ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
                   MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                     DAY(sic_bran.uwm100.expdat)     =   01                             AND
                   MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
                THEN DO:
                  /*
                  IF (uwm100.expdat - uwm100.comdat) + 1 = 365  OR
                     (uwm100.expdat - uwm100.comdat) + 1 = 366  OR
                     (uwm100.expdat - uwm100.comdat) + 1 = 367
                  THEN wv_polday = 365.
                  ELSE wv_polday = (uwm100.expdat - uwm100.comdat) + 1.
                  */
                  n_dcover = 365.
                END.
                ELSE DO:
                  /*
                  IF (uwm100.expdat - uwm100.comdat) + 1 = 365  OR
                     (uwm100.expdat - uwm100.comdat) + 1 = 366  /* OR
                     (uwm100.expdat - uwm100.comdat) + 1 = 367  */
                  THEN wv_polday = 365.
                  ELSE wv_polday = (uwm100.expdat - uwm100.comdat) + 1.
                  */
                  
                   /********   Narin  *********                  
                                /* n_dcover = (uwm100.expdat - uwm100.comdat)    + 1 .     /*   =  367  วัน*/*/
                   ********END Narin*******/
                   
                  n_dcover = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ).     /*    =  366  วัน */
                                 
                END.
    /* ------------------- */


    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.poltyp EQ sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR.
    IF AVAILABLE sicsyac.xmm031 THEN DO:
      /* ไม่ต้องเช็ค 24.00 น.
      IF xmm031.exptim NE 2400 THEN n_dcover = n_dcover - 1.
      */

     /* IF n_dcover = 366 THEN n_dcover = 365.*/   /****** Narin mark******/
       IF n_dcover = 365  THEN        /*******add *********/

      n_ddyr   = YEAR(TODAY).
      n_ddyr1  = n_ddyr + 1.
      n_dyear  = 365.   
     
      FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
           sicsyac.xmm105.tariff EQ nvtariff      AND
           sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod
      NO-LOCK NO-ERROR.
      IF  sic_bran.uwm100.short = NO OR sicsyac.xmm105.shorta = NO THEN DO:
       
         /*    uwd132.prem_c = TRUNCATE( (n_orgnap * n_dcover) / n_dyear , 2).*/   /** Narin mark ทศนิยม  ***/
          sic_bran.uwd132.prem_c = (n_orgnap * n_dcover) / n_dyear .        
         

      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701     WHERE
                   sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                   sicsyac.xmm127.daymth =  YES                    AND
                   sicsyac.xmm127.nodays GE n_dcover
        NO-LOCK NO-ERROR.
        IF AVAILABLE sicsyac.xmm127 THEN DO:
       /*   uwd132.prem_c = TRUNCATE( (n_orgnap * xmm127.short) / 100 , 2).*/   /*** Narin mark ทศนิยม ***/
           sic_bran.uwd132.prem_c =  (n_orgnap * sicsyac.xmm127.short) / 100 .
        END.
        ELSE DO:
          IF YEAR(sic_bran.uwm100.expdat) <> YEAR(sic_bran.uwm100.comdat) THEN DO:
            nvyear = YEAR(sic_bran.uwm100.expdat) - YEAR(sic_bran.uwm100.comdat).
            IF nvyear > 1 THEN
               n_dmonth = (12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1) + ((nvyear - 1) * 12).
            ELSE
               n_dmonth =  12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1.
          END.
          ELSE n_dmonth = MONTH(sic_bran.uwm100.expdat) - MONTH(sic_bran.uwm100.comdat) + 1.


          FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701      WHERE
                     sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                     sicsyac.xmm127.daymth =  NO            AND
                     sicsyac.xmm127.nodays GE n_dmonth
          NO-LOCK NO-ERROR.
          IF AVAILABLE xmm127 THEN DO:

/*             uwd132.prem_c = TRUNCATE( (n_orgnap * xmm127.short) / 100, 2).*/     /*** Narin mark ทศนิยม ***/
             sic_bran.uwd132.prem_c = (n_orgnap * sicsyac.xmm127.short) / 100.
             HIDE MESSAGE NO-PAUSE.
             MESSAGE "AA".
             PAUSE.
          END.
          ELSE DO:
 /*            uwd132.prem_c = TRUNCATE( (n_orgnap * n_dcover) / n_dyear, 2).*/   /****** Narin mark******/
 
             sic_bran.uwd132.prem_c =  (n_orgnap * n_dcover) / n_dyear.
          END.

        END.
      END.

      IF s_curbil = "BHT" THEN   /*   uwd132.prem_c = TRUNCATE(uwd132.prem_c, 2). */
                                 sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.
    END.
  END.
END.


/**** Narin 
message n_orgnap  skip   /*เบี้ยสุทธิ*/
                    n_dcover  skip   /*จำนวนวันที่คุ้มครอง*/
                    n_dyear    skip   /*จำนวนวันทีแท้จริงในการหาร = 365 */
                    n_total = (n_orgnap * n_dcover) / n_dyear   view-as alert-box.
 ****/                  
                    

/* END OF : UWXMIN39.P */
