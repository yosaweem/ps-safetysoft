/*++++++++++++++++++++++++++++++++++++++++++++++
program id   : wgwpolay.p
program name : Running Notify no. policy AYCAL
Create  by   : Kridtiya i. [A58-0301]   On   21/08/2015
Connect DB   :  Stat
+++++++++++++++++++++++++++++++++++++++++++++++*/

DEFINE INPUT        PARAMETER nv_dir_ri   AS LOGICAL                  NO-UNDO.
DEFINE INPUT        PARAMETER nv_poltyp   AS CHARACTER FORMAT "X(3)"  NO-UNDO.
DEFINE INPUT        PARAMETER nv_branch   AS CHARACTER FORMAT "X(2)"  NO-UNDO.
DEFINE INPUT        PARAMETER nv_undyr    AS CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE INPUT        PARAMETER nv_acno1    AS CHARACTER FORMAT "X(7)"  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER n_policy    AS CHARACTER FORMAT "X(12)" NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER nv_message  AS CHARACTER                NO-UNDO.

DEFINE VAR  nv_polno     AS   INTEGER              NO-UNDO.
DEFINE VAR  nv_brnpol    AS   CHARACTER INITIAL "" NO-UNDO.
DEFINE VAR  nv_startno   AS   CHARACTER INITIAL "" NO-UNDO.
DEFINE VAR  nv_runsafuw  AS   LOGICAL   INITIAL NO NO-UNDO.
DEFINE VAR  nv_undyr2543 AS   CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE VAR  nv_polno2543 AS   INTEGER              NO-UNDO.
ASSIGN 
    n_policy     = ""
    nv_message   = ""
    nv_undyr2543 = nv_undyr 
    nv_brnpol    = SUBSTR(nv_branch,1,1)
    nv_startno   = SUBSTR(nv_branch,2,2).

FIND FIRST stat.polno_fil USE-INDEX polno01   WHERE
    stat.polno_fil.dir_ri   = nv_dir_ri       AND
    stat.polno_fil.poltyp   = nv_poltyp       AND
    stat.polno_fil.branch   = nv_branch       AND
    stat.polno_fil.undyr    = nv_undyr2543    AND
    stat.polno_fil.brn_pol  = nv_brnpol       AND  
    stat.polno_fil.start_no = nv_startno           
    EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE stat.polno_fil THEN DO:
    IF LOCKED stat.polno_fil THEN DO:
        nv_message = "LOCK stat.polno_fil ".
        RETURN.
    END.
END.
ELSE DO:
    ASSIGN 
        nv_polno              = stat.polno_fil.nextno  
        stat.polno_fil.nextno = stat.polno_fil.nextno + 1.
    IF stat.polno_fil.nextno >= 999999  THEN DO:
        ASSIGN nv_message = "เบอร์กรมธรรม์ Running เกินกว่าที่กำหนด".
    END.
    ELSE ASSIGN n_policy = "STY" + SUBstr(nv_undyr2543,3,2) + string(nv_polno,"999999") .
END.
RELEASE stat.polno_fil.
