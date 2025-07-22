/* wgwimhct1.P  -- Load Text file .............           */
/* Copyright   # Safety Insurance Public Company Limited  */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)       */
/* WRITE  BY   : Kridtiya i.A64-0414  27/11/2021          */
/*             : ส่วนการค้นหาค่า สาขา                     */
/* connect stat.*/                                        
/* ------------------------------------------------------ */
DEFINE INPUT   PARAMETER np_br1    AS CHAR FORMAT "x(30)".
DEFINE OUTPUT  PARAMETER np_br2    AS CHAR FORMAT "x(2)" .   
IF np_br1 <> "" THEN DO:
        FIND FIRST insure USE-INDEX insure01 WHERE 
            insure.compno = "HCT" AND
            insure.lname  = TRIM(np_br1) NO-LOCK  NO-ERROR NO-WAIT.
        IF AVAIL insure THEN ASSIGN np_br2    = insure.branch.
        ELSE np_br2 = "".
END.                                                                             
                                                                                 
