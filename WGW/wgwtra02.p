/*=================================================================*/
/* Program Name : wGwtra02.P   Gen. Data Uwm120 To DB Premium      */
/* Assign  No   : A56-0299                                         */
/* CREATE  By   : Watsana K.          (Date 18/09/2013)            */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/* modify by    : Kridtiya i. A57-0391 date. 27/11/2014 เพิ่มการเช็คเลขกรมธรรม์ ที่พบในระบบ */
/*=================================================================*/
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.
FIND sic_bran.uwm120 USE-INDEX uwm12001 WHERE
    sic_bran.uwm120.policy  = nv_Policy AND
    sic_bran.uwm120.rencnt  = nv_RenCnt AND
    sic_bran.uwm120.endcnt  = nv_EndCnt AND
    sic_bran.uwm120.bchyr   = nv_bchyr  AND
    sic_bran.uwm120.bchno   = nv_bchno  AND
    sic_bran.uwm120.bchcnt  = nv_bchcnt NO-LOCK NO-ERROR.
IF AVAIL sic_bran.uwm120  THEN DO:
    FIND sicuw.uwm120 WHERE
        sicuw.uwm120.policy = sic_bran.uwm120.policy AND
        sicuw.uwm120.rencnt = sic_bran.uwm120.rencnt AND
        sicuw.uwm120.endcnt = sic_bran.uwm120.endcnt AND
        sicuw.uwm120.riskgp = sic_bran.uwm120.riskgp AND
        sicuw.uwm120.riskno = sic_bran.uwm120.riskno NO-ERROR.
    IF NOT AVAILABLE sicuw.uwm120 THEN DO:
        CREATE sicuw.uwm120.   
        ASSIGN
            sicuw.uwm120.policy      = sic_bran.uwm120.policy
            sicuw.uwm120.rencnt      = sic_bran.uwm120.rencnt
            sicuw.uwm120.endcnt      = sic_bran.uwm120.endcnt
            sicuw.uwm120.bptr01      = 0
            sicuw.uwm120.bptr02      = 0
            sicuw.uwm120.bptr03      = 0
            sicuw.uwm120.bptr04      = 0
            sicuw.uwm120.bptr08      = 0
            sicuw.uwm120.bptr09      = 0
            sicuw.uwm120.class       = sic_bran.uwm120.class
            sicuw.uwm120.com1ae      = sic_bran.uwm120.com1ae
            sicuw.uwm120.com1p       = sic_bran.uwm120.com1p
            sicuw.uwm120.com1_r      = sic_bran.uwm120.com1_r
            sicuw.uwm120.com2ae      = sic_bran.uwm120.com2ae
            sicuw.uwm120.com2p       = sic_bran.uwm120.com2p
            sicuw.uwm120.com2_r      = sic_bran.uwm120.com2_r
            sicuw.uwm120.com3ae      = sic_bran.uwm120.com3ae
            sicuw.uwm120.com3p       = sic_bran.uwm120.com3p
            sicuw.uwm120.com3_r      = sic_bran.uwm120.com3_r
            sicuw.uwm120.com4ae      = sic_bran.uwm120.com4ae
            sicuw.uwm120.com4p       = sic_bran.uwm120.com4p
            sicuw.uwm120.com4_r      = sic_bran.uwm120.com4_r
            sicuw.uwm120.comco       = sic_bran.uwm120.comco
            sicuw.uwm120.comfac      = sic_bran.uwm120.comfac
            sicuw.uwm120.comqs       = sic_bran.uwm120.comqs
            sicuw.uwm120.comst       = sic_bran.uwm120.comst
            sicuw.uwm120.comtty      = sic_bran.uwm120.comtty
            sicuw.uwm120.dl1_r       = sic_bran.uwm120.dl1_r
            sicuw.uwm120.dl2_r       = sic_bran.uwm120.dl2_r
            sicuw.uwm120.dl3_r       = sic_bran.uwm120.dl3_r
            sicuw.uwm120.feeae       = sic_bran.uwm120.feeae
            sicuw.uwm120.fptr01      = 0
            sicuw.uwm120.fptr02      = 0
            sicuw.uwm120.fptr03      = 0
            sicuw.uwm120.fptr04      = 0
            sicuw.uwm120.fptr08      = 0
            sicuw.uwm120.fptr09      = 0
            sicuw.uwm120.gap_r       = sic_bran.uwm120.gap_r
            sicuw.uwm120.pdco        = sic_bran.uwm120.pdco
            sicuw.uwm120.pdfac       = sic_bran.uwm120.pdfac
            sicuw.uwm120.pdqs        = sic_bran.uwm120.pdqs
            sicuw.uwm120.pdst        = sic_bran.uwm120.pdst
            sicuw.uwm120.pdtty       = sic_bran.uwm120.pdtty
            sicuw.uwm120.prem_r      = sic_bran.uwm120.prem_r
            sicuw.uwm120.rfee_r      = sic_bran.uwm120.rfee_r
            sicuw.uwm120.rilate      = sic_bran.uwm120.rilate
            sicuw.uwm120.riskgp      = sic_bran.uwm120.riskgp
            sicuw.uwm120.riskno      = sic_bran.uwm120.riskno
            sicuw.uwm120.rskdel      = sic_bran.uwm120.rskdel
            sicuw.uwm120.rstp_r      = sic_bran.uwm120.rstp_r
            sicuw.uwm120.rtax_r      = sic_bran.uwm120.rtax_r
            sicuw.uwm120.r_text      = sic_bran.uwm120.r_text
            sicuw.uwm120.sico        = sic_bran.uwm120.sico
            sicuw.uwm120.sicurr      = sic_bran.uwm120.sicurr
            sicuw.uwm120.siexch      = sic_bran.uwm120.siexch
            sicuw.uwm120.sifac       = sic_bran.uwm120.sifac
            sicuw.uwm120.sigr        = sic_bran.uwm120.sigr
            sicuw.uwm120.siqs        = sic_bran.uwm120.siqs
            sicuw.uwm120.sist        = sic_bran.uwm120.sist
            sicuw.uwm120.sitty       = sic_bran.uwm120.sitty
            sicuw.uwm120.stmpae      = sic_bran.uwm120.stmpae
            sicuw.uwm120.styp20      = sic_bran.uwm120.styp20
            sicuw.uwm120.sval20      = sic_bran.uwm120.sval20
            sicuw.uwm120.taxae       = sic_bran.uwm120.taxae.
    END.
    ELSE 
        ASSIGN    /*add by kridtiya i. A57-0391 */
            sicuw.uwm120.policy      = sic_bran.uwm120.policy
            sicuw.uwm120.rencnt      = sic_bran.uwm120.rencnt
            sicuw.uwm120.endcnt      = sic_bran.uwm120.endcnt
            sicuw.uwm120.bptr01      = 0
            sicuw.uwm120.bptr02      = 0
            sicuw.uwm120.bptr03      = 0
            sicuw.uwm120.bptr04      = 0
            sicuw.uwm120.bptr08      = 0
            sicuw.uwm120.bptr09      = 0
            sicuw.uwm120.class       = sic_bran.uwm120.class
            sicuw.uwm120.com1ae      = sic_bran.uwm120.com1ae
            sicuw.uwm120.com1p       = sic_bran.uwm120.com1p
            sicuw.uwm120.com1_r      = sic_bran.uwm120.com1_r
            sicuw.uwm120.com2ae      = sic_bran.uwm120.com2ae
            sicuw.uwm120.com2p       = sic_bran.uwm120.com2p
            sicuw.uwm120.com2_r      = sic_bran.uwm120.com2_r
            sicuw.uwm120.com3ae      = sic_bran.uwm120.com3ae
            sicuw.uwm120.com3p       = sic_bran.uwm120.com3p
            sicuw.uwm120.com3_r      = sic_bran.uwm120.com3_r
            sicuw.uwm120.com4ae      = sic_bran.uwm120.com4ae
            sicuw.uwm120.com4p       = sic_bran.uwm120.com4p
            sicuw.uwm120.com4_r      = sic_bran.uwm120.com4_r
            sicuw.uwm120.comco       = sic_bran.uwm120.comco
            sicuw.uwm120.comfac      = sic_bran.uwm120.comfac
            sicuw.uwm120.comqs       = sic_bran.uwm120.comqs
            sicuw.uwm120.comst       = sic_bran.uwm120.comst
            sicuw.uwm120.comtty      = sic_bran.uwm120.comtty
            sicuw.uwm120.dl1_r       = sic_bran.uwm120.dl1_r
            sicuw.uwm120.dl2_r       = sic_bran.uwm120.dl2_r
            sicuw.uwm120.dl3_r       = sic_bran.uwm120.dl3_r
            sicuw.uwm120.feeae       = sic_bran.uwm120.feeae
            sicuw.uwm120.fptr01      = 0
            sicuw.uwm120.fptr02      = 0
            sicuw.uwm120.fptr03      = 0
            sicuw.uwm120.fptr04      = 0
            sicuw.uwm120.fptr08      = 0
            sicuw.uwm120.fptr09      = 0
            sicuw.uwm120.gap_r       = sic_bran.uwm120.gap_r
            sicuw.uwm120.pdco        = sic_bran.uwm120.pdco
            sicuw.uwm120.pdfac       = sic_bran.uwm120.pdfac
            sicuw.uwm120.pdqs        = sic_bran.uwm120.pdqs
            sicuw.uwm120.pdst        = sic_bran.uwm120.pdst
            sicuw.uwm120.pdtty       = sic_bran.uwm120.pdtty
            sicuw.uwm120.prem_r      = sic_bran.uwm120.prem_r
            sicuw.uwm120.rfee_r      = sic_bran.uwm120.rfee_r
            sicuw.uwm120.rilate      = sic_bran.uwm120.rilate
            sicuw.uwm120.riskgp      = sic_bran.uwm120.riskgp
            sicuw.uwm120.riskno      = sic_bran.uwm120.riskno
            sicuw.uwm120.rskdel      = sic_bran.uwm120.rskdel
            sicuw.uwm120.rstp_r      = sic_bran.uwm120.rstp_r
            sicuw.uwm120.rtax_r      = sic_bran.uwm120.rtax_r
            sicuw.uwm120.r_text      = sic_bran.uwm120.r_text
            sicuw.uwm120.sico        = sic_bran.uwm120.sico
            sicuw.uwm120.sicurr      = sic_bran.uwm120.sicurr
            sicuw.uwm120.siexch      = sic_bran.uwm120.siexch
            sicuw.uwm120.sifac       = sic_bran.uwm120.sifac
            sicuw.uwm120.sigr        = sic_bran.uwm120.sigr
            sicuw.uwm120.siqs        = sic_bran.uwm120.siqs
            sicuw.uwm120.sist        = sic_bran.uwm120.sist
            sicuw.uwm120.sitty       = sic_bran.uwm120.sitty
            sicuw.uwm120.stmpae      = sic_bran.uwm120.stmpae
            sicuw.uwm120.styp20      = sic_bran.uwm120.styp20
            sicuw.uwm120.sval20      = sic_bran.uwm120.sval20
            sicuw.uwm120.taxae       = sic_bran.uwm120.taxae.
         /*add by kridtiya i. A57-0391 */
END.
RELEASE sicuw.uwm120.





