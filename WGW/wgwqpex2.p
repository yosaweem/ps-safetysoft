/************************************************************************/
/* wgwqpexp.p   Call Data Expiry  									*/
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.           */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)						      */
/* CREATE BY	: Chaiyong W. A64-0135 13/09/2021				*/
/* Connect sic_exp                                              */
/************************************************************************/
DEF input parameter  nv_prvpol  AS CHAR INIT "".
DEF input-output  parameter  nv_branch  AS CHAR INIT "".
DEF input-output  parameter  nv_dealer  AS CHAR INIT "".
DEF input-output  parameter  nv_f       AS CHAR INIT "".  
IF nv_prvpol <> ""  THEN DO:
     FIND LAST sic_exp.uwm100 WHERE uwm100.policy = nv_prvpol NO-LOCK NO-ERROR.
     IF AVAIL sic_exp.uwm100 THEN DO:
         nv_f = "Y".
         IF nv_branch = "" THEN DO:
             nv_branch = uwm100.branch.
             IF uwm100.branch = "ML" THEN nv_branch = "สำนักงานใหญ่".
             ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_branch).
         END.
         IF nv_dealer = "" THEN DO:
             nv_dealer = uwm100.finint.
         END.
     END.
END.
