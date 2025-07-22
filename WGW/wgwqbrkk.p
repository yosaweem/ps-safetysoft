/************************************************************************/
/* wgwqbrkk.p   Call Data branch Name 									*/
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.           */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)						      */
/* CREATE BY	: Chaiyong W. A64-0135 13/09/2021				*/
/* Connect stat                                             */
/************************************************************************/

DEF INPUT-OUTPUT PARAMETER nv_branch AS CHAR INIT "".
FIND FIRST stat.insure USE-INDEX insure03 WHERE 
        stat.insure.compno = "kk" AND
        stat.insure.branch = nv_branch NO-LOCK NO-ERROR.
IF AVAIL stat.insure THEN DO:
    ASSIGN
        nv_branch = trim(stat.insure.fname).
END.
