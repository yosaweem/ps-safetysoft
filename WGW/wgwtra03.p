/*=================================================================*/
/* Program Name : wgwtra03.P   Gen. Data Uwm130 To DB Premium     */
/* Assign  No   : A56-0299                                        */
/* CREATE  By   : Watsana K.          (Date 18/09/2013)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium          */
/*Modify   by   : kridtiya i. A57-0119 date 26/03/2014            
                  comment "end" program and add "end" program     */
/* modify by   : Kridtiya i. A57-0391 date. 27/11/2014 เพิ่มการเช็คเลขกรมธรรม์ ที่พบในระบบ */
/*=================================================================*/

DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.
DEF BUFFER wf_uwd132 FOR sicuw.uwd132.
DEF VAR putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR nv_fptr AS RECID.
DEF VAR nv_bptr AS RECID.
DEF SHARED STREAM ns1.
FIND FIRST sic_bran.uwm130 USE-INDEX uwm13001  WHERE 
    sic_bran.uwm130.policy  = nv_Policy AND
    sic_bran.uwm130.rencnt  = nv_RenCnt AND
    sic_bran.uwm130.endcnt  = nv_EndCnt AND
    sic_bran.uwm130.riskgp  = 0         AND
    sic_bran.uwm130.riskno  = 1         AND
    sic_bran.uwm130.itemno  = 1         AND
    sic_bran.uwm130.bchyr   = nv_bchyr  AND
    sic_bran.uwm130.bchno   = nv_bchno  AND
    sic_bran.uwm130.bchcnt  = nv_bchcnt  NO-LOCK NO-ERROR.
IF AVAIL sic_bran.uwm130 THEN DO:
    FIND sicuw.uwm130 WHERE
        sicuw.uwm130.policy = sic_bran.uwm130.policy AND
        sicuw.uwm130.rencnt = sic_bran.uwm130.rencnt AND
        sicuw.uwm130.endcnt = sic_bran.uwm130.endcnt AND
        sicuw.uwm130.riskgp = sic_bran.uwm130.riskgp AND 
        sicuw.uwm130.riskno = sic_bran.uwm130.riskno AND 
        sicuw.uwm130.itemno = sic_bran.uwm130.itemno NO-ERROR.
    IF NOT AVAILABLE sicuw.uwm130 THEN DO:
        CREATE sicuw.uwm130.
        /*END. *//*kridtiya i. A57-0119*/
        ASSIGN
            sicuw.uwm130.policy     = sic_bran.uwm130.policy 
            sicuw.uwm130.rencnt     = sic_bran.uwm130.rencnt 
            sicuw.uwm130.endcnt     = sic_bran.uwm130.endcnt 
            sicuw.uwm130.bptr01     = 0
            sicuw.uwm130.bptr02     = 0
            sicuw.uwm130.bptr03     = 0
            sicuw.uwm130.bptr04     = 0
            sicuw.uwm130.bptr05     = 0
            sicuw.uwm130.dl1per     = sic_bran.uwm130.dl1per
            sicuw.uwm130.dl2per     = sic_bran.uwm130.dl2per
            sicuw.uwm130.dl3per     = sic_bran.uwm130.dl3per
            sicuw.uwm130.fptr01     = 0
            sicuw.uwm130.fptr02     = 0
            sicuw.uwm130.fptr03     = 0
            sicuw.uwm130.fptr04     = 0
            sicuw.uwm130.fptr05     = 0
            sicuw.uwm130.itemno     = sic_bran.uwm130.itemno
            sicuw.uwm130.itmdel     = sic_bran.uwm130.itmdel
            sicuw.uwm130.i_text     = sic_bran.uwm130.i_text
            sicuw.uwm130.riskgp     = sic_bran.uwm130.riskgp
            sicuw.uwm130.riskno     = sic_bran.uwm130.riskno
            sicuw.uwm130.styp20     = sic_bran.uwm130.styp20
            sicuw.uwm130.sval20     = sic_bran.uwm130.sval20
            sicuw.uwm130.uom1_c     = sic_bran.uwm130.uom1_c
            sicuw.uwm130.uom1_u     = sic_bran.uwm130.uom1_u
            sicuw.uwm130.uom1_v     = sic_bran.uwm130.uom1_v
            sicuw.uwm130.uom2_c     = sic_bran.uwm130.uom2_c
            sicuw.uwm130.uom2_u     = sic_bran.uwm130.uom2_u
            sicuw.uwm130.uom2_v     = sic_bran.uwm130.uom2_v
            sicuw.uwm130.uom3_c     = sic_bran.uwm130.uom3_c
            sicuw.uwm130.uom3_u     = sic_bran.uwm130.uom3_u
            sicuw.uwm130.uom3_v     = sic_bran.uwm130.uom3_v
            sicuw.uwm130.uom4_c     = sic_bran.uwm130.uom4_c
            sicuw.uwm130.uom4_u     = sic_bran.uwm130.uom4_u
            sicuw.uwm130.uom4_v     = sic_bran.uwm130.uom4_v
            sicuw.uwm130.uom5_c     = sic_bran.uwm130.uom5_c
            sicuw.uwm130.uom5_u     = sic_bran.uwm130.uom5_u
            sicuw.uwm130.uom5_v     = sic_bran.uwm130.uom5_v
            sicuw.uwm130.uom6_c     = sic_bran.uwm130.uom6_c
            sicuw.uwm130.uom6_u     = sic_bran.uwm130.uom6_u
            sicuw.uwm130.uom6_v     = sic_bran.uwm130.uom6_v
            sicuw.uwm130.uom7_c     = sic_bran.uwm130.uom7_c
            sicuw.uwm130.uom7_u     = sic_bran.uwm130.uom7_u
            sicuw.uwm130.uom7_v     = sic_bran.uwm130.uom7_v
            sicuw.uwm130.uom8_c     = sic_bran.uwm130.uom8_c
            sicuw.uwm130.uom8_v     = sic_bran.uwm130.uom8_v
            sicuw.uwm130.uom9_c     = sic_bran.uwm130.uom9_c
            sicuw.uwm130.uom9_v     = sic_bran.uwm130.uom9_v.
        /* Insured Item Benefit & Premium */
        nv_fptr = sic_bran.uwm130.fptr03.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr03 <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd132 THEN DO:
                nv_fptr = sic_bran.uwd132.fptr.
                CREATE sicuw.uwd132.
                ASSIGN
                    sicuw.uwd132.policy        = sic_bran.uwm130.policy 
                    sicuw.uwd132.rencnt        = sic_bran.uwm130.rencnt 
                    sicuw.uwd132.endcnt        = sic_bran.uwm130.endcnt 
                    sicuw.uwd132.bencod        = sic_bran.uwd132.bencod
                    sicuw.uwd132.benvar        = sic_bran.uwd132.benvar
                    sicuw.uwd132.bptr          = nv_bptr
                    sicuw.uwd132.dl1_c         = sic_bran.uwd132.dl1_c
                    sicuw.uwd132.dl2_c         = sic_bran.uwd132.dl2_c
                    sicuw.uwd132.dl3_c         = sic_bran.uwd132.dl3_c
                    sicuw.uwd132.fptr          = 0
                    sicuw.uwd132.gap_ae        = sic_bran.uwd132.gap_ae
                    sicuw.uwd132.gap_c         = sic_bran.uwd132.gap_c
                    sicuw.uwd132.itemno        = sic_bran.uwd132.itemno
                    sicuw.uwd132.pd_aep        = sic_bran.uwd132.pd_aep
                    sicuw.uwd132.prem_c        = sic_bran.uwd132.prem_c
                    sicuw.uwd132.rate          = sic_bran.uwd132.rate
                    sicuw.uwd132.rateae        = sic_bran.uwd132.rateae
                    sicuw.uwd132.riskgp        = sic_bran.uwd132.riskgp
                    sicuw.uwd132.riskno        = sic_bran.uwd132.riskno.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                    wf_uwd132.fptr = RECID(sicuw.uwd132).
                END.
                IF nv_bptr = 0 THEN  sicuw.uwm130.fptr03 = RECID(sicuw.uwd132).
                nv_bptr = RECID(sicuw.uwd132).
            END.
            ELSE DO:
                ASSIGN
                    putchr  = ""
                    putchr1 = ""
                    putchr1 = "Not found on file uwd132 Ins. Item Benefit & Premium"   +
                              " Riskgp/Riskno " + STRING(sic_bran.uwd132.riskgp,"99")  +
                              "/"               + STRING(sic_bran.uwd132.riskno,"999") +
                              " on file uwd132 Ins. Item Benefit & Premium".
                putchr  = STRING(sic_bran.uwd132.policy,"x(16)") + " "  +
                          STRING(sic_bran.uwd132.rencnt,"99")    + "/"  +
                          STRING(sic_bran.uwd132.endcnt,"999")   + "  " +
                          putchr1.
                PUT STREAM ns1 putchr FORMAT "x(256)" SKIP.       
                LEAVE.
            END.
        END.
        sicuw.uwm130.bptr03 = nv_bptr.
    END.   /*kridtiya i. A57-0119 เนื่องจากมีการ Assign uwd132 ซ้ำตามครั้งที่กด*/
    ELSE DO:
        /*add by kridtiya i. A57-0391 */
        ASSIGN   
            sicuw.uwm130.policy     = sic_bran.uwm130.policy 
            sicuw.uwm130.rencnt     = sic_bran.uwm130.rencnt 
            sicuw.uwm130.endcnt     = sic_bran.uwm130.endcnt 
            sicuw.uwm130.bptr01     = 0
            sicuw.uwm130.bptr02     = 0
            sicuw.uwm130.bptr03     = 0
            sicuw.uwm130.bptr04     = 0
            sicuw.uwm130.bptr05     = 0
            sicuw.uwm130.dl1per     = sic_bran.uwm130.dl1per
            sicuw.uwm130.dl2per     = sic_bran.uwm130.dl2per
            sicuw.uwm130.dl3per     = sic_bran.uwm130.dl3per
            sicuw.uwm130.fptr01     = 0
            sicuw.uwm130.fptr02     = 0
            sicuw.uwm130.fptr03     = 0
            sicuw.uwm130.fptr04     = 0
            sicuw.uwm130.fptr05     = 0
            sicuw.uwm130.itemno     = sic_bran.uwm130.itemno
            sicuw.uwm130.itmdel     = sic_bran.uwm130.itmdel
            sicuw.uwm130.i_text     = sic_bran.uwm130.i_text
            sicuw.uwm130.riskgp     = sic_bran.uwm130.riskgp
            sicuw.uwm130.riskno     = sic_bran.uwm130.riskno
            sicuw.uwm130.styp20     = sic_bran.uwm130.styp20
            sicuw.uwm130.sval20     = sic_bran.uwm130.sval20
            sicuw.uwm130.uom1_c     = sic_bran.uwm130.uom1_c
            sicuw.uwm130.uom1_u     = sic_bran.uwm130.uom1_u
            sicuw.uwm130.uom1_v     = sic_bran.uwm130.uom1_v
            sicuw.uwm130.uom2_c     = sic_bran.uwm130.uom2_c
            sicuw.uwm130.uom2_u     = sic_bran.uwm130.uom2_u
            sicuw.uwm130.uom2_v     = sic_bran.uwm130.uom2_v
            sicuw.uwm130.uom3_c     = sic_bran.uwm130.uom3_c
            sicuw.uwm130.uom3_u     = sic_bran.uwm130.uom3_u
            sicuw.uwm130.uom3_v     = sic_bran.uwm130.uom3_v
            sicuw.uwm130.uom4_c     = sic_bran.uwm130.uom4_c
            sicuw.uwm130.uom4_u     = sic_bran.uwm130.uom4_u
            sicuw.uwm130.uom4_v     = sic_bran.uwm130.uom4_v
            sicuw.uwm130.uom5_c     = sic_bran.uwm130.uom5_c
            sicuw.uwm130.uom5_u     = sic_bran.uwm130.uom5_u
            sicuw.uwm130.uom5_v     = sic_bran.uwm130.uom5_v
            sicuw.uwm130.uom6_c     = sic_bran.uwm130.uom6_c
            sicuw.uwm130.uom6_u     = sic_bran.uwm130.uom6_u
            sicuw.uwm130.uom6_v     = sic_bran.uwm130.uom6_v
            sicuw.uwm130.uom7_c     = sic_bran.uwm130.uom7_c
            sicuw.uwm130.uom7_u     = sic_bran.uwm130.uom7_u
            sicuw.uwm130.uom7_v     = sic_bran.uwm130.uom7_v
            sicuw.uwm130.uom8_c     = sic_bran.uwm130.uom8_c
            sicuw.uwm130.uom8_v     = sic_bran.uwm130.uom8_v
            sicuw.uwm130.uom9_c     = sic_bran.uwm130.uom9_c
            sicuw.uwm130.uom9_v     = sic_bran.uwm130.uom9_v.
        /* Insured Item Benefit & Premium */
        nv_fptr = sic_bran.uwm130.fptr03.
        nv_bptr = 0.
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr03 <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAILABLE sic_bran.uwd132 THEN DO:
                nv_fptr = sic_bran.uwd132.fptr.
                FIND LAST sicuw.uwd132 WHERE 
                    sicuw.uwd132.policy        = sic_bran.uwm130.policy AND
                    sicuw.uwd132.rencnt        = sic_bran.uwm130.rencnt AND
                    sicuw.uwd132.endcnt        = sic_bran.uwm130.endcnt AND
                    sicuw.uwd132.bencod        = sic_bran.uwd132.bencod AND
                    sicuw.uwd132.benvar        = sic_bran.uwd132.benvar NO-ERROR NO-WAIT.
                IF NOT AVAIL sicuw.uwd132 THEN DO:
                    CREATE sicuw.uwd132.
                    ASSIGN
                        sicuw.uwd132.policy        = sic_bran.uwm130.policy 
                        sicuw.uwd132.rencnt        = sic_bran.uwm130.rencnt 
                        sicuw.uwd132.endcnt        = sic_bran.uwm130.endcnt 
                        sicuw.uwd132.bencod        = sic_bran.uwd132.bencod
                        sicuw.uwd132.benvar        = sic_bran.uwd132.benvar
                        sicuw.uwd132.bptr          = nv_bptr
                        sicuw.uwd132.dl1_c         = sic_bran.uwd132.dl1_c
                        sicuw.uwd132.dl2_c         = sic_bran.uwd132.dl2_c
                        sicuw.uwd132.dl3_c         = sic_bran.uwd132.dl3_c
                        sicuw.uwd132.fptr          = 0
                        sicuw.uwd132.gap_ae        = sic_bran.uwd132.gap_ae
                        sicuw.uwd132.gap_c         = sic_bran.uwd132.gap_c
                        sicuw.uwd132.itemno        = sic_bran.uwd132.itemno
                        sicuw.uwd132.pd_aep        = sic_bran.uwd132.pd_aep
                        sicuw.uwd132.prem_c        = sic_bran.uwd132.prem_c
                        sicuw.uwd132.rate          = sic_bran.uwd132.rate
                        sicuw.uwd132.rateae        = sic_bran.uwd132.rateae
                        sicuw.uwd132.riskgp        = sic_bran.uwd132.riskgp
                        sicuw.uwd132.riskno        = sic_bran.uwd132.riskno.
                END.
                IF nv_bptr <> 0 THEN DO:
                        FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                        wf_uwd132.fptr = RECID(sicuw.uwd132).
                    END.
                    IF nv_bptr = 0 THEN  sicuw.uwm130.fptr03 = RECID(sicuw.uwd132).
                    nv_bptr = RECID(sicuw.uwd132).
                
                 
            END.
            ELSE DO:
                ASSIGN
                    putchr  = ""
                    putchr1 = ""
                    putchr1 = "Not found on file uwd132 Ins. Item Benefit & Premium"   +
                    " Riskgp/Riskno " + STRING(sic_bran.uwd132.riskgp,"99")  +
                    "/"               + STRING(sic_bran.uwd132.riskno,"999") +
                    " on file uwd132 Ins. Item Benefit & Premium".
                putchr  = STRING(sic_bran.uwd132.policy,"x(16)") + " "  +
                    STRING(sic_bran.uwd132.rencnt,"99")    + "/"  +
                    STRING(sic_bran.uwd132.endcnt,"999")   + "  " +
                    putchr1.
                PUT STREAM ns1 putchr FORMAT "x(256)" SKIP.       
                LEAVE.
            END.
        END.
        sicuw.uwm130.bptr03 = nv_bptr.
        /*add by kridtiya i. A57-0391 */ 
    END. 
END.
RELEASE sicuw.uwm130.
RELEASE sicuw.uwd132.



