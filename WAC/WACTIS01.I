/* create by  Kanchana  :  16/10/2002 */
/* หา  ntitle name  ใน xmm600, xtm600 */
/*  nv_insref   = ""  nv_institle = ""     nv_insnam   = ""*/

    FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
               xmm600.acno  = uwm100.insref  NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT.
    ELSE DO:    
        FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
                  xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
        IF AVAIL xtm600  THEN 
            ASSIGN
                nv_insref  = xtm600.acno
                nv_institle = xtm600.ntitle
                nv_insnam  = xtm600.name.
        ELSE 
            ASSIGN
                nv_insref  = xmm600.acno
                nv_institle = xmm600.ntitle
                nv_insnam  = xmm600.name.
              
    END.
