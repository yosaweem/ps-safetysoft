/* wgwexchkay.P  : เก็บข้อมูล producer agent dealer branch ของ AY           */
/* Copyright    : Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* Create by    : Ranu I. A65-0115  date : 19/04/2022                       */             
/* ------------------------------------------------------------------------ */
DEFINE INPUT   PARAMETER np_prepol    AS CHAR FORMAT "x(16)".
DEFINE OUTPUT  PARAMETER np_branch    AS CHAR FORMAT "x(2)"  init "" .
define output  parameter np_producer  as char format "x(12)" init "" .  /**/
/*define output  parameter np_agent     as char format "x(12)" init "" . */ /**/
define output  parameter np_delercode as char format "x(12)" init "" .  /**/ 

IF np_prepol <> ""  THEN DO:
  FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
            sic_exp.uwm100.policy = np_prepol   NO-LOCK NO-ERROR NO-WAIT.
  IF AVAILABLE sic_exp.uwm100 THEN DO:
      ASSIGN 
              np_branch    = TRIM(sic_exp.uwm100.branch)
              /*np_agent     = trim(sic_exp.uwm100.agent)*/
              np_producer  = trim(sic_exp.uwm100.acno1)
              np_delercode = trim(sic_exp.uwm100.finint).
  END.
  
END.

                                                                                 
