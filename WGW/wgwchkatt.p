
Def    Input parameter  s_recid3   As Recid.
Def    Input parameter  s_recid4   As Recid.
DEFINE INPUT PARAMETER nv_tariff   LIKE sic_bran.uwm301.tariff.
define input parameter nv_dgpackge as char .
define input parameter nv_danger1  as char .
define input parameter nv_danger2  as char .
define input parameter nv_dgsi     as char .
define input parameter nv_dgrate   as char .
define input parameter nv_dgfeet   as char .
define input parameter nv_dgncb    as char .
define input parameter nv_dgdisc   as char .
define input parameter nv_comdat   LIKE sic_bran.uwm100.comdat.
DEFINE INPUT PARAMETER nv_expdat   LIKE sic_bran.uwm100.expdat.

DEFINE  VAR nv_ratatt AS DECI FORMAT ">>9-".
DEFINE  VAR nv_netatt AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_disatt AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_gapatt AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_siattcod   AS CHARACTER FORMAT "X(4)" .
DEFINE  VAR nv_siatt      AS INTE FORMAT ">>>,>>>,>>9-".
DEFINE  VAR nv_attprm     AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_attgap     AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_siattvar   AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_siattvar1  AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_siattvar2  AS CHAR      FORMAT "X(60)".
    
DEFINE  VAR nv_fltattcod  AS CHARACTER FORMAT "X(4)".
DEFINE  VAR nv_fltatt     AS DECI      FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_fltprm     AS DECI      FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_fltgap    AS DECI      FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_fltattvar  AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_fltattvar1 AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_fltattvar2 AS CHAR      FORMAT "X(60)".
 
DEFINE  VAR nv_ncbattcod   AS CHARACTER FORMAT "X(4)".
DEFINE  VAR nv_ncbatt      AS DECI      FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_ncbprm      AS DECI      FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_ncbgap      AS DECI      FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_ncbattvar   AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_ncbattvar1  AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_ncbattvar2  AS CHAR      FORMAT "X(60)".

DEFINE  VAR nv_dscattcod   AS CHARACTER FORMAT "X(4)".
DEFINE  VAR nv_dscatt      AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_dscprm      AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_dscgap      AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_dscattvar   AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_dscattvar1  AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_dscattvar2  AS CHAR      FORMAT "X(60)".

DEFINE  VAR nv_packatt  AS CHARACTER FORMAT "X(4)".
DEFINE  VAR nv_package AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_packprm AS DECI FORMAT ">>,>>>,>>9-".
DEFINE  VAR nv_packattvar  AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_packattvar1  AS CHAR      FORMAT "X(60)".
DEFINE  VAR nv_packattvar2  AS CHAR      FORMAT "X(60)".

DEFINE VAR  nv_line       AS INTEGER   INITIAL 0  NO-UNDO.

/*DEFINE SHARED VAR nv_tariff LIKE sic_bran.uwm301.tariff.*/
DEFINE  VAR nv_polday AS INTE FORMAT ">>9".
DEFINE  VAR nv_hztext AS CHAR FORMAT "X(200)".
DEFINE  VAR nv_hztext1 AS CHAR FORMAT "X(200)".

DEFINE NEW SHARED WORKFILE  wk_uwd132 LIKE brstat.wkuwd132.
DEFINE VAR nv_bptr      AS RECID.
DEFINE BUFFER wf_uwd132 FOR sic_bran.uwd132.

/*DEFINE SHARED VAR nvw_rptr     LIKE sic_bran.uwd100.fptr.
DEFINE SHARED VAR nvw_bptr     LIKE sic_bran.uwd100.bptr.
DEFINE SHARED VAR nvw_fptr     LIKE sic_bran.uwd100.fptr.
DEFINE SHARED VAR nvw_index    AS INTEGER INIT 0.
DEFINE SHARED VAR nvw_index1   AS INTEGER INIT 0.*/
DEFINE BUFFER buwd100 FOR sic_bran.uwd100.
DEFINE BUFFER buwm100 FOR sic_bran.uwm100.
DEFINE VAR nv_short   AS DECI.

DEFINE SHARED VAR nv_batchyr    AS INT       FORMAT   "9999"  INIT 0.
DEFINE SHARED VAR nv_batcnt     AS INT       FORMAT   "99"    INIT 0.
DEFINE SHARED VAR nv_batchno    AS CHARACTER FORMAT   "X(13)" INIT ""  NO-UNDO.
DEFINE VAR        n_policy      AS CHARACTER NO-UNDO.
DEFINE VAR        n_rencnt      AS INTEGER   NO-UNDO.
DEFINE VAR        n_endcnt      AS INTEGER   NO-UNDO.
DEFINE VAR        nv_riskno     AS INTEGER   NO-UNDO.
DEFINE VAR        nv_itemno     AS INTEGER   NO-UNDO.
DEFINE VAR        nv_message    AS CHARACTER NO-UNDO.

DEFINE SHARED VAR        nv_gapprm     AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEFINE SHARED VAR        nv_pdprm      AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEFINE        VAR        nt_gapprm     AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE        VAR        nt_pdprm      AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE        VAR        nv_adjgap     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE        VAR        nv_adjpd      AS DECI      FORMAT ">>,>>>,>>9.99-".


FIND FIRST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-ERROR.
FIND FIRST sic_bran.uwm130 WHERE RECID(uwm130) = s_recid3          NO-ERROR.
ASSIGN  nv_bptr = 0  
    n_policy    = sic_bran.uwm130.policy
    n_rencnt    = sic_bran.uwm130.rencnt
    n_endcnt    = sic_bran.uwm130.endcnt
    nv_riskno   = sic_bran.uwm130.riskno
    nv_itemno   = sic_bran.uwm130.itemno
    nv_bptr     = sic_bran.uwm130.bptr03.

/*FIND FIRST sic_bran.uwd132 USE-INDEX uwd13201    WHERE   
    sic_bran.uwd132.policy = sic_bran.uwm130.policy AND
    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt AND
    sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt AND
    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp AND
    sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
    sic_bran.uwd132.bchyr  = nv_batchyr             AND 
    sic_bran.uwd132.bchno  = nv_batchno             AND 
    sic_bran.uwd132.bchcnt = nv_batcnt              NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwd132 THEN DO:
    FOR EACH sic_bran.uwd132 USE-INDEX uwd13201     WHERE 
        sic_bran.uwd132.policy = sic_bran.uwm130.policy AND
        sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt AND
        sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt AND
        sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp AND
        sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
        sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
        sic_bran.uwd132.bchyr  = nv_batchyr             AND   
        sic_bran.uwd132.bchno  = nv_batchno             AND   
        sic_bran.uwd132.bchcnt = nv_batcnt              :
        DELETE sic_bran.uwd132.
    END.
    sic_bran.uwm130.fptr03 = 0.
    sic_bran.uwm130.bptr03 = 0.
END.*/

IF ( DAY(nv_comdat)     = DAY(nv_expdat)    AND 
   MONTH(nv_comdat)     = MONTH(nv_expdat)  AND 
    YEAR(nv_comdat) + 1 = YEAR(nv_expdat) ) OR  
   ( DAY(nv_comdat)     =  29               AND 
   MONTH(nv_comdat)     =  02               AND 
     DAY(nv_expdat)     =  01               AND 
   MONTH(nv_expdat)     =  03               AND 
    YEAR(nv_comdat) + 1 = YEAR(nv_expdat) )
THEN DO:
  nv_polday = 365.
END.
ELSE DO:
  nv_polday = (nv_expdat  - nv_comdat ) + 1 .     /*    =  366  วัน */
END.

ASSIGN 
    nv_line    =  0
    nv_packatt = nv_dgpackge   
    nv_hztext  = nv_danger1    
    nv_hztext1 = nv_danger2    
    nv_siatt   = deci(nv_dgsi)       
    nv_ratatt  = deci(nv_dgrate)     
    nv_fltatt  = deci(nv_dgfeet)     
    nv_ncbatt  = deci(nv_dgncb)     
    nv_dscatt  = deci(nv_dgdisc)  .

IF nv_packatt <> ""  THEN DO:
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff  = nv_tariff  AND
               sicsyac.xmm106.bencod  = nv_packatt AND
               sicsyac.xmm106.CLASS   = "AR01"     AND
               sicsyac.xmm106.key_a   = 0          AND
               sicsyac.xmm106.key_b   = 0          AND
               sicsyac.xmm106.effdat <= nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xmm106 THEN DO:
        nv_ratatt = sicsyac.xmm106.appinc.
    END.
    ELSE DO:
        ASSIGN 
            nv_packatt = ""
            nv_ratatt  = 0.
    END.
   
    RUN PDCaculate.
    nv_netatt = nv_disatt. 

    nv_packattvar = "".
    IF nv_packatt <> "" THEN DO:
        ASSIGN
            nv_packattvar1 = "     RATE Attach % = "
            nv_packattvar2 = STRING(nv_ratatt)
            SUBSTRING(nv_packattvar,1,30)    = nv_packattvar1
            SUBSTRING(nv_packattvar,31,30)   = nv_packattvar2.

        RUN WGS/WGSTK132 (INPUT n_policy,
                          n_rencnt,
                          n_endcnt,
                          nv_riskno,
                          nv_itemno,
                          sic_bran.uwm301.tariff,                /* nv_tariff */
                          nv_packatt,
                          nv_packattvar,
                          0,
                          0,
                          INPUT-OUTPUT nv_line).
    END.


END.


nv_siattvar = "".
IF nv_siatt <> 0 THEN DO:

    RUN PDCaculate.
    nv_netatt = nv_disatt.

    ASSIGN 
        nv_siattvar1 = "     Sum Attach = "
        nv_siattcod  = "RSI"
        nv_siattvar2 = STRING(nv_siatt)
        SUBSTRING(nv_siattvar,1,30)    = nv_siattvar1
        SUBSTRING(nv_siattvar,31,30)   = nv_siattvar2.

     RUN WGS/WGSTK132 (INPUT n_policy,
                          n_rencnt,
                          n_endcnt,
                          nv_riskno,
                          nv_itemno,
                          sic_bran.uwm301.tariff,                /* nv_tariff */
                          nv_siattcod,
                          nv_siattvar,
                          nv_attgap,
                          nv_attprm,
                          INPUT-OUTPUT nv_line).
END.

nv_fltattvar = "".
IF nv_fltatt <> 0 THEN DO:
    RUN PDCaculate.
    nv_netatt = nv_disatt.
    ASSIGN 
        nv_fltattvar1 = "     Fleet Attach % = "
        nv_fltattcod  = "RFET"
        nv_fltattvar2 = STRING(nv_fltatt)
        SUBSTRING(nv_fltattvar,1,30)    = nv_fltattvar1
        SUBSTRING(nv_fltattvar,31,30)   = nv_fltattvar2.

    RUN WGS/WGSTK132 (INPUT n_policy,
                          n_rencnt,
                          n_endcnt,
                          nv_riskno,
                          nv_itemno,
                          sic_bran.uwm301.tariff,                /* nv_tariff */
                          nv_fltattcod,
                          nv_fltattvar,
                          nv_fltgap,
                          nv_fltprm,
                          INPUT-OUTPUT nv_line).
END.

nv_ncbattvar = "".
IF nv_ncbatt <> 0 THEN DO:

    RUN PDCaculate.
    nv_netatt = nv_disatt. 

    ASSIGN 
        nv_ncbattvar1 = "     NCB Attach % = "
        nv_ncbattcod  = "RNCB"
        nv_ncbattvar2 = STRING(nv_ncbatt)
        SUBSTRING(nv_ncbattvar,1,30)    = nv_ncbattvar1
        SUBSTRING(nv_ncbattvar,31,30)   = nv_ncbattvar2.

     RUN WGS/WGSTK132 (INPUT n_policy,
                          n_rencnt,
                          n_endcnt,
                          nv_riskno,
                          nv_itemno,
                          sic_bran.uwm301.tariff,                /* nv_tariff */
                          nv_ncbattcod,
                          nv_ncbattvar,
                          nv_ncbgap,
                          nv_ncbprm,
                          INPUT-OUTPUT nv_line).
END.

nv_dscattvar = "". 
IF nv_dscatt <> 0 THEN DO:
    RUN PDCaculate.
    nv_netatt = nv_disatt.
    ASSIGN
        nv_dscattvar1 = "     Discount Attach % = "
        nv_dscattcod  = "RDST"
        nv_dscattvar2 = STRING(nv_dscatt)
        SUBSTRING(nv_dscattvar,1,30)    = nv_dscattvar1
        SUBSTRING(nv_dscattvar,31,30)   = nv_dscattvar2.

    RUN WGS/WGSTK132 (INPUT n_policy,
                          n_rencnt,
                          n_endcnt,
                          nv_riskno,
                          nv_itemno,
                          sic_bran.uwm301.tariff,                /* nv_tariff */
                          nv_dscattcod,
                          nv_dscattvar,
                          nv_dscgap,
                          nv_dscprm,
                          INPUT-OUTPUT nv_line).
END.
PROCEDURE PDCaculate:
    IF nv_polday <> 365 OR nv_polday <> 366 THEN DO:
        FIND FIRST sicsyac.xmm127 WHERE 
            xmm127.poltyp  = "V70"      AND
            xmm127.daymth  = YES        AND
            xmm127.nodays >= nv_polday  NO-LOCK NO-ERROR.
        IF AVAIL xmm127 THEN DO:
            nv_short = xmm127.short.

            nv_attgap  = ((nv_siatt * nv_ratatt) / 100).
            nv_attprm = ((nv_siatt * nv_ratatt) / 100) * (nv_short / 100).

        END.
        ELSE DO: 
            nv_attgap = (nv_siatt * nv_ratatt) / 100.
            nv_attprm = (nv_siatt * nv_ratatt) / 100.
        END.
    END.
    ELSE DO:
        nv_attgap = (nv_siatt * nv_ratatt) / 100.
        nv_attprm = (nv_siatt * nv_ratatt) / 100.
    END.

    nv_disatt = nv_attprm.
    nv_gapatt = nv_attgap.

    
    nv_fltgap = TRUNCATE((nv_gapatt * nv_fltatt) / 100,0) * (-1).
    nv_gapatt = nv_gapatt + nv_fltgap.
    nv_ncbgap = TRUNCATE((nv_gapatt * nv_ncbatt) / 100,0) * (-1).
    nv_gapatt = nv_gapatt + nv_ncbgap.
    nv_dscgap = TRUNCATE((nv_gapatt * nv_dscatt) / 100,0) * (-1).
    nv_gapatt = nv_gapatt + nv_dscgap.

    nv_fltprm = TRUNCATE((nv_disatt * nv_fltatt) / 100,0) * (-1).
    nv_disatt = nv_disatt + nv_fltprm.
    nv_ncbprm = TRUNCATE((nv_disatt * nv_ncbatt) / 100,0) * (-1).
    nv_disatt = nv_disatt + nv_ncbprm.
    nv_dscprm = TRUNCATE((nv_disatt * nv_dscatt) / 100,0) * (-1).
    nv_disatt = nv_disatt + nv_dscprm.

    nv_disatt = nv_attprm + nv_fltprm + nv_ncbprm + nv_dscprm.

    nv_netatt = nv_attprm + nv_fltprm + nv_ncbprm + nv_dscprm.  /* เบี้ยรวมของ รย.*/
    nv_gapatt = nv_attgap + nv_fltgap + nv_ncbgap + nv_dscgap . /* เบี้ยรวมของ รย.*/

END.

IF nv_line <> 0 THEN DO:
    FOR EACH wk_uwd132 NO-LOCK BREAK BY wk_uwd132.LINE   :
        CREATE sic_bran.uwd132.
        ASSIGN  sic_bran.uwd132.policy    = wk_uwd132.policy
            sic_bran.uwd132.rencnt        = wk_uwd132.rencnt
            sic_bran.uwd132.endcnt        = wk_uwd132.endcnt
            sic_bran.uwd132.riskgp        = wk_uwd132.riskgp
            sic_bran.uwd132.riskno        = wk_uwd132.riskno
            sic_bran.uwd132.itemno        = wk_uwd132.itemno
            sic_bran.uwd132.rateae        = wk_uwd132.rateae
            sic_bran.uwd132.bencod        = wk_uwd132.bencod
            sic_bran.uwd132.benvar        = wk_uwd132.benvar
            sic_bran.uwd132.rate          = wk_uwd132.rate
            sic_bran.uwd132.gap_ae        = wk_uwd132.gap_ae
            sic_bran.uwd132.gap_c         = wk_uwd132.gap_c
            sic_bran.uwd132.pd_aep        = wk_uwd132.pd_aep
            sic_bran.uwd132.prem_c        = wk_uwd132.prem_c
            sic_bran.uwd132.bptr          = nv_bptr
            sic_bran.uwd132.dl1_c         = 0
            sic_bran.uwd132.dl2_c         = 0
            sic_bran.uwd132.dl3_c         = 0
            sic_bran.uwd132.fptr          = 0  .
        ASSIGN /*a490166*/
            sic_bran.uwd132.bchyr       = nv_batchyr         /* batch Year */
            sic_bran.uwd132.bchno       = nv_batchno         /* batchno    */
            sic_bran.uwd132.bchcnt      = nv_batcnt .        /* batcnt     */
        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
            wf_uwd132.fptr = RECID(sic_bran.uwd132).
        END.
        IF nv_bptr = 0 THEN  uwm130.fptr03 = RECID(sic_bran.uwd132).
        nv_bptr = RECID(sic_bran.uwd132).
    END.                 /* End FOR EACH wk_uwd132 */
    uwm130.bptr03 = nv_bptr.
    
    /*---------Adjust premium ---------*/
    nt_gapprm   = 0.
    nt_pdprm    = 0.
    FOR EACH sic_bran.uwd132   WHERE
        sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
        sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
        sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
        sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
        sic_bran.uwd132.bchyr = nv_batchyr                AND   
        sic_bran.uwd132.bchno = nv_batchno                AND   
        sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
        ASSIGN 
            nt_gapprm   = nt_gapprm + sic_bran.uwd132.gap_c
            nt_pdprm    = nt_pdprm  + sic_bran.uwd132.prem_c.
    END.
    IF      nv_gapprm    <> nt_gapprm   THEN DO:
        nv_adjgap    = nv_gapprm - nt_gapprm.
        FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE 
            sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
            sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
            sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
            sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
            sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
            sic_bran.uwd132.bencod  = "PD"                    AND
            sic_bran.uwd132.bchyr = nv_batchyr                AND
            sic_bran.uwd132.bchno = nv_batchno                AND
            sic_bran.uwd132.bchcnt  = nv_batcnt               NO-ERROR.
        IF  AVAIL   sic_bran.uwd132  THEN  DO:
            ASSIGN  sic_bran.uwd132.gap_c   = sic_bran.uwd132.gap_c + nv_adjgap.
        END.
    END.
    IF      nv_pdprm     <> nt_pdprm    THEN DO:
        nv_adjpd     = nv_pdprm - nt_pdprm.
        FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE 
            sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
            sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
            sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
            sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
            sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
            sic_bran.uwd132.bencod  = "PD"                    AND
            sic_bran.uwd132.bchyr = nv_batchyr                AND
            sic_bran.uwd132.bchno = nv_batchno                AND
            sic_bran.uwd132.bchcnt  = nv_batcnt               NO-ERROR.
        IF  AVAIL   sic_bran.uwd132  THEN
            ASSIGN  sic_bran.uwd132.prem_c  = sic_bran.uwd132.prem_c + nv_adjpd.
    END.
    /*-------------------end adjust premium-----------*/
END.                                                      /* END nv_line <> 0 */
