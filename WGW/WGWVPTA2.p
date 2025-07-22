/************************************************************************/
/* wgwvpta2.p   Transfer Gw to Premium   Release     				    */
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.         */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)			*/
/* CREATE BY	: Chaiyong W.  ASSIGN A64-0189  DATE 21/04/2021 		*/
/* Modify BY	: Chaiyong W.  ASSIGN A65-0185  DATE 27/09/2022 		*/
/*                Add condition Check transfer                          */
/* Modify BY	: Chaiyong W.  ASSIGN A66-0116  DATE 08/09/2023 		*/
/*                Add condition Check transfer                          */
/* Modify by  : Chaiyong W. A67-0202 17/12/2024                         */
/*              Check Cession No.                                       */  
/************************************************************************/
DEF INPUT  PARAMETER nv_Recid   AS RECID INIT ?.
DEF INPUT  PARAMETER nv_trnvt   AS CHAR NO-UNDO INIT "".
DEF INPUT  PARAMETER nv_tprog   AS CHAR NO-UNDO INIT "".
DEF OUTPUT PARAMETER nv_error   AS CHAR NO-UNDO INIT "".
DEF VAR nv_progid AS CHAR INIT "".
DEF VAR nv_vtweb  AS CHAR INIT "". /*---add by Chaiyong W. A65-0185 27/09/2023*/
loop_rmain:
REPEAT TRANSACTION:
    FIND uwm100  WHERE RECID(uwm100) = nv_recid NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:

        /*---Begin by Chaiyong W. A67-0202 20/12/2024*/
        FIND FIRST uwm200 USE-INDEX uwm20001 WHERE
                   uwm200.policy = uwm100.policy AND
                   uwm200.rencnt = uwm100.rencnt AND
                   uwm200.endcnt = uwm100.endcnt AND
                   uwm200.csftq  = "F"           AND
                   uwm200.c_no   = 0             NO-LOCK NO-ERROR.
        IF AVAIL uwm200 THEN DO:
            nv_error = "Policy No : " + uwm100.policy + " โอนงานไม่ได้Allocate Fac: cession No = 0 ".
            IF nv_error <> "" THEN UNDO loop_rmain,LEAVE loop_rmain.
            
        END.
        /*End by Chaiyong W. A67-0202 20/12/2024-----*/





        IF nv_tprog <> "" THEN nv_progid = nv_tprog.
        ELSE nv_progid = "UWO10091".                           
    
        RUN WUZ\WUZVPTA2(INPUT RECID(uwm100),
                         INPUT nv_progid ,
                         OUTPUT nv_error).
        
        IF nv_error <> "" THEN UNDO loop_rmain,LEAVE loop_rmain.
        RUN WUZ\WUZVPTA3(INPUT RECID(uwm100),OUTPUT nv_error).
        IF nv_error <> "" THEN UNDO loop_rmain,LEAVE loop_rmain.
              /*
        IF nv_trnvt = "Transfer"   
            THEN DO: /*Transfer Vat*/ 
            
            RUN WUZ\WUZVPTV1(INPUT RECID(uwm100),OUTPUT nv_error).
            IF nv_error <> "" THEN UNDO loop_rmain,LEAVE loop_rmain.
        END. comment by Chaiyong W. A65-0185 27/09/2022*/



        /*---Begin by Chaiyong W. A65-0185 27/09/2023*/
        /*nv_vtweb  = trim(SUBSTR(uwm100.code1,101)) NO-ERROR.
        IF nv_vtweb = ? THEN nv_vtweb = "".
        IF nv_vtweb <> "" THEN DO:

        END. */
        IF nv_trnvt = "Transfer" THEN DO: /*Transfer Vat*/ 
            
            RUN WUZ\WUZVPTV1(INPUT RECID(uwm100),OUTPUT nv_error).
            IF nv_error <> "" THEN UNDO loop_rmain,LEAVE loop_rmain.
        END.
        /*End by Chaiyong W. A65-0185 27/09/2023-----*/


        /*---Begin by Chaiyong W. A67-0202 06/01/2025*/
        FIND FIRST  tomagmat_fill USE-INDEX tomagmat_fill001
             WHERE  tomagmat_fill.Agent = uwm100.acno1 NO-LOCK NO-ERROR.  /* Loop งาน TOMSECปกติและ Co-Borker ที่เป็น Lead */
        IF  AVAIL tomagmat_fill THEN DO: 

            RUN WUZ\WUZTMSEC (INPUT uwm100.policy,
                                    uwm100.rencnt,
                                    uwm100.endcnt,
                                    "POLTOMSEC",
                                    nv_progid  ,
                             OUTPUT  nv_error).

            IF nv_error <> "" THEN DO:
                RUN pd_log(INPUT uwm100.policy,nv_error).
                /*--
                DISPLAY nv_error FONT 6 WITH FRAME msgbox2.
                /*--
                PAUSE 5 NO-MESSAGE.
                comment by Chaiyong W. A65-0253 16/01/2023*/
                RUN wuw\wuwewait(INPUT 5). /*---add by Chaiyong W. A65-0253 13/01/2023*/
                HIDE  FRAME msgerbox2 NO-PAUSE.
                comment by Chaiyong W. A65-0253 20/04/2023*/
            END.

        END.
        ELSE DO:
            FIND FIRST  tomagmat_fill USE-INDEX tomagmat_fill001
                 WHERE  tomagmat_fill.Agent = uwm100.acno2 NO-LOCK NO-ERROR. /* งาน TOMSEC ที่ Co-Borker ที่เป็น Follower */
            IF  AVAIL tomagmat_fill THEN  DO:

                RUN WUZ\WUZTMSEC (INPUT uwm100.policy,
                                       uwm100.rencnt,
                                       uwm100.endcnt,
                                       "POLTOMSEC",
                                        nv_progid,
                                 OUTPUT  nv_error).  

                IF nv_error <> "" THEN DO:
                    RUN pd_log(INPUT uwm100.policy,nv_error).
                    /*--
                    DISPLAY nv_error FONT 6 WITH FRAME msgbox2.
                    /*--
                    PAUSE 5 NO-MESSAGE.
                    comment by Chaiyong W. A65-0253 16/01/2023*/
                    RUN wuw\wuwewait(INPUT 5). /*---add by Chaiyong W. A65-0253 13/01/2023*/
                    HIDE  FRAME msgerbox2 NO-PAUSE.
                    comment by Chaiyong W. A65-0253 20/04/2023*/
                END.
            END.
        END.
        /*End by Chaiyong W. A67-0202 06/01/2025----*/




        IF  uwm100.poltyp  = "V72" OR  
            uwm100.poltyp  = "V73" OR
            uwm100.poltyp  = "V74" OR
            uwm100.poltyp  = "V70" THEN DO:
            
            IF uwm100.poltyp  = "V70" THEN DO:
               FIND FIRST uwd132  WHERE
                        uwd132.policy  = uwm100.policy  AND
                        uwd132.rencnt  = uwm100.rencnt  AND
                        uwd132.endcnt  = uwm100.endcnt  AND
                        uwd132.bencod  = "COMP"         NO-LOCK NO-ERROR NO-WAIT.
               IF NOT AVAILABLE uwd132 THEN LEAVE loop_rmain.
            END. 

            IF nv_tprog <> "" THEN nv_progid = nv_tprog.
            ELSE nv_progid = "UZO098".
            RUN WUZ\WUZVPTO1(INPUT uwm100.policy,   /*OIC*/
                                   uwm100.rencnt,
                                   uwm100.endcnt,
                                   "COMOICINT"  ,
                                   nv_progid    ,
                             OUTPUT nv_error ).     
            IF nv_error <> "" THEN RUN pd_log(INPUT uwm100.policy,nv_error).  /*---add by Chaiyong W. A67-0202 06/01/2025*/
        END.


    END.
    LEAVE loop_rmain.
END.
/*---Begin by Chaiyong W. A67-0202 06/01/2025*/
PROCEDURE pd_log:
    DEF INPUT PARAMETER n_policy AS CHAR INIT "".
    DEF INPUT PARAMETER n_error  AS CHAR INIT "".
    OUTPUT TO VALUE("WGWVPTA2_" + STRING(MONTH(TODAY),"99") + STRING(YEAR(TODAY),"9999") + ".txt") APPEND.
    EXPORT DELIMITER "|"
        n_policy
        n_error
        STRING(DATE(TODAY),"99/99/9999")
        STRING(TIME,"HH:MM:SS") SKIP.
    OUTPUT  CLOSE.
    OUTPUT TO VALUE("WGWVPTA2_" + STRING(MONTH(TODAY),"99") + STRING(YEAR(TODAY),"9999") + ".txt") APPEND.
    EXPORT DELIMITER "|"
        "---------------------------" SKIP.
    OUTPUT  CLOSE.
END PROCEDURE .       
/*End by Chaiyong W. A67-0202 06/01/2025----*/

