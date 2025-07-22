/************************************************************************/
/* wgwkkfbri.p   Program Check Branch Ho/BR       				       */
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.         */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)			*/
/* CREATE BY	: Chaiyong W.  ASSIGN A65-0288  DATE 21/12/2022 		*/
/************************************************************************/
DEF INPUT  parameter nv_brnameo AS CHAR INIT "".
DEF output parameter nv_brcode  AS CHAR INIT "".
DEF output parameter nv_brname2 AS CHAR INIT "".
DEF output parameter nv_hobr    AS CHAR INIT "".

FIND FIRST stat.insure USE-INDEX insure03 WHERE                                        
    stat.insure.compno = "kk"                              AND                         
    index(trim(nv_brnameo),trim(stat.insure.fname)) <> 0 NO-LOCK NO-ERROR NO-WAIT. 
IF AVAIL stat.insure THEN DO: 
    nv_brcode  = CAPS(stat.insure.branch) . 
    RUN wuw\wuwqbanc (INPUT nv_brcode ,OUTPUT nv_brname2, OUTPUT nv_hobr). 
    /*----Special---*/
    nv_brname2 = TRIM(nv_brnameo) .
END.
ELSE nv_brname2 = TRIM(nv_brnameo) .
