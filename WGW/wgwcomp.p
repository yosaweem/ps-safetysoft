/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A67-0185 
         เช็ค Class พรบ.      
------------------------------------------------------------------------------*/
DEF INPUT  PARAMETER n_comp      AS INTE .
DEF INPUT  PARAMETER n_vehues    AS CHAR .
DEF INPUT  PARAMETER n_prempa    AS CHAR .
DEF INPUT  PARAMETER n_class     AS CHAR .
DEF INPUT  PARAMETER n_bev       AS CHAR .
DEF INPUT  PARAMETER n_garage    AS CHAR .
DEF OUTPUT PARAMETER n_comp72    AS CHAR FORMAT "x(5)" .
DEF OUTPUT PARAMETER nv_chkerror AS CHAR FORMAT "x(150)" .


DEF VAR n_classcomp72 AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR n_comp_1 AS DECI. 
DEF VAR n_comp_2 AS DECI.

ASSIGN  n_comp_1 = 0
        n_comp72 = ""
        n_classcomp72 = ""
        n_comp_1 = TRUNCATE(((deci(n_comp) * 100 ) / 107.43 ),0) .
      
IF n_bev = "Y" THEN DO:
    FIND LAST sicsyac.xmm106 WHERE 
              sicsyac.xmm106.tariff  = "9"      AND
              sicsyac.xmm106.bencod  = "comp"   AND         
              SUBSTR(sicsyac.xmm106.CLASS,1,3) = trim(n_class)  AND 
              sicsyac.xmm106.covcod  = "T"                  AND 
              sicsyac.xmm106.KEY_b   = INTE(n_vehues) AND 
              sicsyac.xmm106.baseap  = n_comp_1   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN DO:
        ASSIGN n_comp72 = sicsyac.xmm106.class .
    END.
    ELSE DO:
        FIND LAST sicsyac.xmm106 WHERE 
                  sicsyac.xmm106.tariff  = "9"      AND 
                  sicsyac.xmm106.bencod  = "comp"   AND 
                  SUBSTR(sicsyac.xmm106.CLASS,1,3)  = substr(n_class,1,3)   AND
                  sicsyac.xmm106.covcod  = "T"      AND 
                  sicsyac.xmm106.baseap = n_comp_1  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN ASSIGN n_comp72 = sicsyac.xmm106.class .
        ELSE DO:
          FIND FIRST sicsyac.xzmcom WHERE
              sicsyac.xzmcom.class    = n_prempa + n_class  AND
              sicsyac.xzmcom.garage   = n_garage     AND
              sicsyac.xzmcom.vehuse   = n_vehues     NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE sicsyac.xzmcom THEN DO:
              ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
                     n_classcomp72  = replace(n_classcomp72," ","").
          END.
          ELSE DO:
              FIND FIRST sicsyac.xzmcom WHERE
                  sicsyac.xzmcom.class    = n_prempa + n_class  AND 
                  sicsyac.xzmcom.vehuse   = n_vehues      NO-LOCK NO-ERROR NO-WAIT.
              IF AVAILABLE sicsyac.xzmcom THEN 
                  ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
                  n_classcomp72  = replace(n_classcomp72," ","").
              ELSE ASSIGN nv_chkerror = "| ไม่พบ Class " + n_prempa + n_class + "และ Veh. Use" + n_vehues + 
                      "ที่แฟ้มตารางเปรียบเทียบ (sicsyac.xzmcom)" .
          END. 

          FIND LAST sicsyac.xmm106 WHERE 
                   sicsyac.xmm106.tariff  = "9"      AND
                   sicsyac.xmm106.bencod  = "comp"   AND
                   substr(sicsyac.xmm106.CLASS,1,3)   = trim(n_classcomp72)  AND
                   sicsyac.xmm106.covcod  = "t"                 AND 
                   sicsyac.xmm106.baseap  = n_comp_1  NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
            ELSE DO:
                FIND LAST sicsyac.xmm106 WHERE 
                          sicsyac.xmm106.tariff  = "9"      AND
                          sicsyac.xmm106.bencod  = "comp"   AND
                          substr(sicsyac.xmm106.CLASS,1,3)  = substr(n_classcomp72,1,3)    AND
                          sicsyac.xmm106.covcod  = "t"      AND 
                          sicsyac.xmm106.baseap  = n_comp_1 NO-LOCK NO-ERROR.
                 IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
            END.  
        END.
    END.
END.
ELSE DO:
    FIND FIRST sicsyac.xzmcom WHERE
        sicsyac.xzmcom.class    = n_prempa + n_class  AND
        sicsyac.xzmcom.garage   = n_garage     AND
        sicsyac.xzmcom.vehuse   = n_vehues     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xzmcom THEN 
        ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
               n_classcomp72  = replace(n_classcomp72," ","").
    ELSE DO:
        FIND FIRST sicsyac.xzmcom WHERE
            sicsyac.xzmcom.class    = n_prempa + n_class  AND 
            sicsyac.xzmcom.vehuse   = n_vehues      NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xzmcom THEN 
            ASSIGN n_classcomp72  = replace(sicsyac.xzmcom.comp_cod,".","")
                   n_classcomp72  = replace(n_classcomp72," ","").
        ELSE ASSIGN nv_chkerror = "| ไม่พบ Class " + n_prempa + n_class + "และ Veh. Use" + n_vehues + 
                      "ที่แฟ้มตารางเปรียบเทียบ (sicsyac.xzmcom)" .
    END.
    FIND LAST sicsyac.xmm106 WHERE 
            sicsyac.xmm106.tariff  = "9"      AND
            sicsyac.xmm106.bencod  = "comp"   AND
            sicsyac.xmm106.CLASS   = trim(n_classcomp72) AND
            sicsyac.xmm106.covcod  = "t"                 AND 
            sicsyac.xmm106.baseap  = n_comp_1  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
        ELSE DO:
            FIND LAST sicsyac.xmm106 WHERE 
            sicsyac.xmm106.tariff  = "9"      AND
            sicsyac.xmm106.bencod  = "comp"   AND
            substr(sicsyac.xmm106.CLASS,1,3)  = substr(n_classcomp72,1,3)    AND
            sicsyac.xmm106.covcod  = "t"      AND 
            sicsyac.xmm106.baseap  = n_comp_1 NO-LOCK NO-ERROR.
             IF AVAIL sicsyac.xmm106 THEN  ASSIGN n_comp72 = sicsyac.xmm106.class .
             ELSE DO:
                n_comp72 = "" .
                FOR EACH sicsyac.xmm106 WHERE 
                    sicsyac.xmm106.tariff  = "9"      AND
                    sicsyac.xmm106.bencod  = "comp"   AND
                    /*substr(sicsyac.xmm106.CLASS,1,3)  = substr(n_class,1,3)    AND*/ 
                    sicsyac.xmm106.covcod  = "T"      AND 
                    sicsyac.xmm106.baseap  = n_comp_1 NO-LOCK .
                    ASSIGN n_classcomp72 = TRIM(SUBSTR(sicsyac.xmm106.class,1,1) + "." + SUBSTR(sicsyac.xmm106.class,2,LENGTH(sicsyac.xmm106.class))) .
                
                    IF n_comp72 <> ""  THEN NEXT.
                    ELSE DO:
                        FIND FIRST sicsyac.xzmcom WHERE
                            sicsyac.xzmcom.class    = n_prempa + n_class  AND
                            /*sicsyac.xzmcom.vehuse   = n_vehues      AND*/
                            sicsyac.xzmcom.comp_cod = n_classcomp72     NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAILABLE sicsyac.xzmcom THEN DO:
                                ASSIGN n_comp72  = sicsyac.xzmcom.comp_cod
                                       n_comp72  = trim(replace(n_comp72,".","")).
                            END.
                    END.
                END.
                IF n_comp72 = "" THEN DO: 
                     ASSIGN nv_chkerror = nv_chkerror + "| ไม่พบข้อมูล Class " + n_prempa + n_class + 
                            " Match กับ Class พรบ. " + n_classcomp72 + " ที่ sicsyac.xzmcom " .
                END.
             END.
        END.
END.



