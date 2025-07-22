/************************************************************************/
/* wgwqpexp.p   Call Data Expiry  									*/
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.           */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)						      */
/* CREATE BY	: Chaiyong W. A64-0135 13/09/2021				*/
/* Connect sic_exp                                              */
/************************************************************************/


DEF input parameter  nv_kkst    AS CHAR INIT "".
DEF input parameter  nv_poltyp  AS CHAR INIT "".
DEF input parameter  nv_comdat  AS DATE INIT ?.
DEF input parameter  nv_cha_no  AS CHAR INIT "".
DEF input parameter  nv_trareg  AS CHAR INIT "".
DEF input parameter  nv_prvpol  AS CHAR INIT "".
DEF input-output  parameter  nv_branch  AS CHAR INIT "".
DEF input-output  parameter  nv_dealer  AS CHAR INIT "".
DEF input-output  parameter  nv_f       AS CHAR INIT "".    
DEF input-output  parameter  nv_policy  AS CHAR INIT "".



IF index(nv_kkst,"RENEW") <> 0 THEN DO:
    IF nv_trareg <> "" THEN DO:
        FIND LAST sic_exp.uwm301 WHERE uwm301.trareg             = nv_trareg NO-LOCK NO-ERROR.
        IF AVAIL sic_exp.uwm301 THEN DO:
            loop_veh:
            FOR EACH sic_exp.uwm301 WHERE uwm301.trareg             = nv_trareg  /*AND
                                  SUBSTR(uwm301.policy,3,2) = nv_poltyp     */  NO-LOCK BY uwm301.policy DESC
                                                                                 BY uwm301.policy:
                FIND LAST sic_exp.uwm100 WHERE uwm100.policy = uwm301.policy AND
                                       uwm100.rencnt = uwm301.rencnt AND
                                       uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR.
                IF AVAIL uwm100 THEN DO:
                    IF  uwm100.renpol = "" AND uwm100.poltyp = nv_poltyp  THEN DO:
                        IF year(nv_comdat) = YEAR(uwm100.expdat) OR year(nv_comdat) = (YEAR(uwm100.expdat) + 1)  THEN DO:
                            ASSIGN
                            nv_policy = uwm100.policy
                            nv_f   = "Y".
                            IF nv_branch = "" THEN DO:
                                nv_branch = uwm100.branch.
                                IF uwm100.branch = "ML" THEN nv_branch = "สำนักงานใหญ่".
                                ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_branch).
                            END.
                            IF nv_dealer = "" THEN DO:
                                nv_dealer = uwm100.finint.
                            END.
                            LEAVE loop_veh.
                        END.
        
                    END.
                END.
            END.
        END.
        IF nv_f = "" THEN DO:
            FIND LAST sic_exp.uwm301 WHERE uwm301.cha_no            = nv_trareg NO-LOCK NO-ERROR.
            IF AVAIL sic_exp.uwm301 THEN DO:
                loop_veh2:
                FOR EACH sic_exp.uwm301 WHERE uwm301.cha_no            = nv_trareg  /*AND
                                      SUBSTR(uwm301.policy,3,2) = nv_poltyp    */   NO-LOCK BY uwm301.policy DESC
                                                                                     BY uwm301.policy:
                    FIND LAST sic_exp.uwm100 WHERE uwm100.policy = uwm301.policy AND
                                           uwm100.rencnt = uwm301.rencnt AND
                                           uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL uwm100 THEN DO:
                        IF  uwm100.renpol = ""  AND uwm100.poltyp = nv_poltyp THEN DO:
                            IF year(nv_comdat) = YEAR(uwm100.expdat) OR year(nv_comdat) = (YEAR(uwm100.expdat) + 1)  THEN DO:
                                ASSIGN
                                nv_policy = uwm100.policy
                                nv_f   = "Y".
                                IF nv_branch = "" THEN DO:
                                    nv_branch = uwm100.branch.
                                    IF uwm100.branch = "ML" THEN nv_branch = "สำนักงานใหญ่".
                                    ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_branch).
                                END.
                                IF nv_dealer = "" THEN DO:
                                    nv_dealer = uwm100.finint.
                                END.
                                LEAVE loop_veh2.
                            END.
            
                        END.
                    END.
                END.
            END.

        END.
        IF nv_f = "" THEN DO:
            FIND LAST sic_exp.uwm301 WHERE uwm301.cha_no            = nv_cha_no NO-LOCK NO-ERROR.
            IF AVAIL sic_exp.uwm301 THEN DO:
                loop_veh3:
                FOR EACH sic_exp.uwm301 WHERE uwm301.cha_no            = nv_cha_no /*  AND
                                      SUBSTR(uwm301.policy,3,2) = nv_poltyp  */     NO-LOCK BY uwm301.policy DESC
                                                                                     BY uwm301.policy:
                    FIND LAST sic_exp.uwm100 WHERE uwm100.policy = uwm301.policy AND
                                           uwm100.rencnt = uwm301.rencnt AND
                                           uwm100.endcnt = uwm301.endcnt NO-LOCK NO-ERROR.
                    IF AVAIL uwm100 THEN DO:
                        IF  uwm100.renpol = "" AND uwm100.poltyp = nv_poltyp  THEN DO:
                            IF year(nv_comdat) = YEAR(uwm100.expdat) OR year(nv_comdat) = (YEAR(uwm100.expdat) + 1)  THEN DO:
                                ASSIGN
                                nv_policy = uwm100.policy
                                nv_f   = "Y".
                                IF nv_branch = "" THEN DO:
                                    nv_branch = uwm100.branch.
                                    IF uwm100.branch = "ML" THEN nv_branch = "สำนักงานใหญ่".
                                    ELSE RUN wgw\wgwqbrkk(INPUT-OUTPUT nv_branch).
                                END.
                                IF nv_dealer = "" THEN DO:
                                    nv_dealer = uwm100.finint.
                                END.
                                LEAVE loop_veh3.
                            END.
            
                        END.
                    END.
                END.
            END.

        END.
    END.
END.  
IF nv_prvpol <> "" AND nv_f = "" THEN DO:
     nv_policy = nv_prvpol .
     
     FIND LAST sic_exp.uwm100 WHERE uwm100.policy = nv_policy NO-LOCK NO-ERROR.
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
