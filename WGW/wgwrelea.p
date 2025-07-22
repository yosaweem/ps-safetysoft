/*=================================================================*/
/* Program Name : WGWRelea.P   Update UWM100 for Release           */
/* Assign  No   : A57-0361                                         */
/* CREATE  By   : Tantawan Ch. 14/10/2014                          */
/*=================================================================*/

DEF SHARED VAR n_User   AS CHAR.
DEF SHARED STREAM ns5 .
DEF SHARED STREAM ns6 .

DEF VAR putchr AS CHAR.
DEF VAR putchr1 AS CHAR.
DEF VAR textchr AS CHAR FORMAT "x(100)".

DEF INPUT        PARAMETER nv_bchyr   AS INT.
DEF INPUT        PARAMETER nv_bchno   AS CHAR.
DEF INPUT        PARAMETER nv_bchcnt  AS INT.
DEF INPUT        PARAMETER nv_policy  AS CHAR.
DEF INPUT        PARAMETER nv_rencnt  AS INT.
DEF INPUT        PARAMETER nv_endcnt  AS INT.
DEF INPUT-OUTPUT PARAMETER nv_relok   AS INT.
DEF INPUT-OUTPUT PARAMETER nv_relerr  AS INT.
DEF       OUTPUT PARAMETER nv_relyet  AS LOG.

nv_relyet = NO.

ASSIGN putchr  = ""
       putchr1 = ""
       textchr = STRING(TRIM(nv_policy),"x(16)") + " " +
                 STRING(nv_rencnt,"99") + "/" + STRING(nv_endcnt,"999").

FIND sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
     sic_bran.uwm100.policy = nv_policy AND
     sic_bran.uwm100.rencnt = nv_rencnt AND
     sic_bran.uwm100.endcnt = nv_endcnt AND
     sic_bran.uwm100.bchyr  = nv_bchyr  AND
     sic_bran.uwm100.bchno  = nv_bchno  AND
     sic_bran.uwm100.bchcnt = nv_bchcnt NO-LOCK NO-ERROR .
IF AVAIL sic_bran.uwm100 THEN DO:    

    FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE 
         sicuw.uwm100.policy = sic_bran.uwm100.Policy AND
         sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt AND
         sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:
    
        ASSIGN
         sicuw.uwm100.releas = YES
         sicuw.uwm100.usridr = SUBSTRING(n_user,3,6)
         sicuw.uwm100.reldat = TODAY
         sicuw.uwm100.reltim = STRING(TIME,"hh:mm:ss")

         sicuw.uwm100.trndat = TODAY
         
         nv_relok  = nv_relok + 1
         nv_relyet = YES.
        . 

        PUT STREAM ns6
           nv_policy FORMAT "X(16)" " "
           nv_rencnt "/" nv_endcnt "  "
           sicuw.uwm100.trty11 " "
           sicuw.uwm100.docno1 " "
           sicuw.uwm100.reldat "  "
           sicuw.uwm100.usrid "  " 
           TRIM(TRIM(sicuw.uwm100.ntitle) + " " + 
           TRIM(sicuw.uwm100.name1)) FORMAT "x(60)" SKIP.


    END.
    ELSE DO : 

       ASSIGN
         putchr1 = "Policy No. is Not Found On Policy Master File sicuw.uwm100".
         putchr  = textchr  + "  " + TRIM(putchr1).

       PUT STREAM ns5 putchr FORMAT "x(200)" SKIP.
       nv_relerr = nv_relerr + 1.

       LEAVE.
    END.

END.



