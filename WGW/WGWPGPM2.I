/************************************************************************/
/* WUWPGPM2.I   Program Generate Benefit Attach.Coverate                */
/* Copyright Tokio Marine Safety Insurance (Thailand) PCL.              */
/* Create By : Porntiwa T. 20/06/2023  A65-0149                         */
/************************************************************************/

IF nv_addatt = "ATDG" THEN DO:  /* Add A67-0029 */
    /*-- Attach.Coverage (ÃÂµ.) --*/
    IF nv_attgap <> 0 THEN DO:      /*"RSI"*/
    
        IF nv_siatt <> 0 THEN DO:
            ASSIGN
                nv_gap    = 0
                nv_prem_c = 0
                nv_gap    = nv_attgap
                nv_prem_c = nv_attprm.
    
            ASSIGN
                nv_bencod  = "RSI"
                nv_benvar  = ""
                nv_benvar1 = "     Sum Attach = "
                nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
                nv_benvar2 = STRING(nv_siatt)
                nv_benvar  = nv_benvar1 + nv_benvar2. 
    
            nv_itemno = nv_itemno + 1.
            RUN PdWkUwd132A.
        END.
    
        IF nv_fltatt <> 0 THEN DO:
            ASSIGN
                nv_gap    = 0
                nv_prem_c = 0
                nv_gap    = nv_atfltgap
                nv_prem_c = nv_atfltprm.
    
            ASSIGN
                nv_bencod  = "RFET"
                nv_benvar  = ""
                nv_benvar1 = "     Fleet Attach % = "
                nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
                nv_benvar2 = STRING(nv_fltatt)
                nv_benvar  = nv_benvar1 + nv_benvar2.
    
            nv_itemno = nv_itemno + 1.
            RUN PdWkUwd132A.
        END.
    
        IF nv_ncbatt <> 0 THEN DO:
            ASSIGN
                nv_gap    = 0
                nv_prem_c = 0
                nv_gap    = nv_atncbgap
                nv_prem_c = nv_atncbprm.
    
            ASSIGN
                nv_bencod  = "RNCB"
                nv_benvar  = ""
                nv_benvar1 = "     NCB Attach % = "
                nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
                nv_benvar2 = STRING(nv_ncbatt)
                nv_benvar  = nv_benvar1 + nv_benvar2.
    
            nv_itemno = nv_itemno + 1.
            RUN PdWkUwd132A.
        END.
    
        IF nv_dscatt <> 0 THEN DO:
            ASSIGN
                nv_gap    = 0
                nv_prem_c = 0
                nv_gap    = nv_atdscgap
                nv_prem_c = nv_atdscprm.
    
            ASSIGN
                nv_bencod  = "RDST"
                nv_benvar  = ""
                nv_benvar1 = "     Discount Attach % = "
                nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
                nv_benvar2 = STRING(nv_dscatt)
                nv_benvar  = nv_benvar1 + nv_benvar2.
    
            nv_itemno = nv_itemno + 1.
            RUN PdWkUwd132A.
        END.
    
        IF nv_packatt <> "" THEN DO:
            ASSIGN
                nv_gap    = 0
                nv_prem_c = 0.
        
            ASSIGN
                nv_bencod  = nv_packatt
                nv_benvar  = ""
                nv_benvar1 = "     RATE Attach % = "
                nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
                nv_benvar2 = STRING(nv_ratatt)
                nv_benvar  = nv_benvar1 + nv_benvar2.
    
            nv_itemno = nv_itemno + 1.
            RUN PdWkUwd132A.
        END.
    END.
END.
ELSE IF nv_addatt = "ATEV" THEN DO:
    IF nv_chgflg = YES THEN DO:
        IF nv_chgrate <> 0 AND nv_chgpdprm <> 0 THEN DO:
            ASSIGN
                nv_gap    = nv_chggapprm  
                nv_prem_c = nv_chgpdprm.
    
            ASSIGN
                nv_bencod  = "EVCG"
                nv_benvar  = ""
                nv_benvar1 = "     CHARGER RATE % = "
                nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
                nv_benvar2 = STRING(nv_chgrate)
                nv_benvar  = nv_benvar1 + nv_benvar2.
        
            nv_itemno = nv_itemno + 1.
            RUN PdWkUwd132A.
        END.
    END.

    IF nv_battflg = YES THEN DO:
        IF nv_battrate <> 0 AND nv_battpdprm <> 0 THEN DO:
            ASSIGN
                nv_gap    = nv_battgapprm 
                nv_prem_c = nv_battpdprm.
    
            ASSIGN
                nv_bencod  = "EVBT"
                nv_benvar  = ""
                nv_benvar1 = "     BATTERY RATE % = "
                nv_benvar1 = nv_benvar1 + FILL(" ",30 - LENGTH(nv_benvar1))
                nv_benvar2 = STRING(nv_battrate)
                nv_benvar  = nv_benvar1 + nv_benvar2.
        
            nv_itemno = nv_itemno + 1.
            RUN PdWkUwd132A.
        END.
    END.
END.


