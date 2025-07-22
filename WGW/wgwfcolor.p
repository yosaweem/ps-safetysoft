/*---------------------------------------------------------------------------------------------------------------*/
/* Program ID : wgwfcolor.p                                                                                     */
/* Program Desc : Find code Car Color                                                                           */
/* Create by : Ranu I. A65-0288 20/10/2022                                                                      */
/*--------------------------------------------------------------------------------------------------------------*/
def INPUT        parameter  nv_color AS CHAR .
def input-output parameter  nv_code  AS CHAR .

FIND FIRST sicsyac.sym100 WHERE sym100.tabcod = "U118" AND sym100.itmdes = trim(nv_color) NO-LOCK NO-ERROR . /* ไทย */
IF AVAIL sicsyac.sym100 THEN DO:
    ASSIGN nv_code  = trim(sym100.itmcod) .
END.
ELSE DO:
    FIND FIRST sicsyac.sym100 WHERE sym100.tabcod = "U119" AND sym100.itmdes = trim(nv_color) NO-LOCK NO-ERROR . /* อังกฤษ */
        IF AVAIL sicsyac.sym100 THEN DO:
            ASSIGN nv_code  = trim(sym100.itmcod) .
        END.
        ELSE do: 
            FIND LAST sicsyac.sym100 WHERE sym100.tabcod = "U119" AND sym100.itmdes = "Multicolor" NO-LOCK NO-ERROR . /* อังกฤษ */
                IF AVAIL sicsyac.sym100 THEN ASSIGN nv_code  = trim(sym100.itmcod) .
        END.
END.


