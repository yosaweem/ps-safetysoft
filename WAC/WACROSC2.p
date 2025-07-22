/* WRITE BY   : Kridtiya i.   DATE :                        
  program id : wacrosc2.p */
/*--------------------------------------------------------------------------
OUTSTANDING CLAIM NON-MOTOR          
---------------------------------------------------------------------------- */
/*Modify By : Nattanicah,Natee,Benjaporn [A59-0007] date 11/02/2016 
            : ºÑ¹·Ö¡ O/S Claim áºº Auto Post to G/L System¢Í§STYáÅÐNZI   
---------------------------------------------------------------------------- */
/* Modify By : Benjaporn J. A59-0613 [14/12/2016]                    
             : Add column Gross BH QS , Fac BH QS , TTY BH QS , Other BH QS  */
/* Modify By : Saowapa U. A61-0460 [30/10/2018]                    
             : Add column Agent Code                                         */
/* ------------------------------------------------------------------------- */
/*{s0\s0sgbvar.i}
{s0\s0sf0.i}*/
{wac/wacros1.i}
DEF        SHARED VAR n_output    AS CHAR FORMAT "X(35)"  INIT "" . 
DEF        SHARED VAR n_output2   AS CHAR FORMAT "X(35)"  INIT "" .
DEF        SHARED VAR non_poltyp  AS INT  INIT 0.
DEF        SHARED VAR n_asdat     AS DATE FORMAT 99/99/9999.
DEF        SHARED VAR n_trndat    AS DATE FORMAT 99/99/9999. /*--A59-0613--*/
DEF        SHARED VAR nv_branfr   AS CHAR FORMAT "x(2)"  . 
DEF        SHARED VAR nv_branto   AS CHAR FORMAT "x(2)"  . 
DEFINE     SHARED VAR n_ostyp     AS INT  INIT 0.
DEFINE            VAR nv_poltyp   AS INT  FORMAT "9"     INIT   2.
DEFINE    VAR nv_checkin      AS  LOGICAL INIT NO. 
DEFINE    VAR nv_checkex      AS  LOGICAL INIT NO. 
DEFINE    VAR nvw_intref      AS  CHAR FORMAT "X(10)". 
DEFINE    VAR nvw_begin       AS  CHAR FORMAT "X(01)"    INIT "Y".
DEFINE    VAR nvw_oldtyp      AS  CHAR FORMAT "X(04)"    INIT "".
DEFINE    VAR nvw_chk_br      AS  CHAR FORMAT "X(01)"    INIT "".
DEFINE    VAR nvw_nbran       AS  CHAR FORMAT "X(20)"    INIT "".
DEFINE    VAR nvw_ntype       AS  CHAR FORMAT "X(35)"    INIT "".
DEFINE    VAR nvw_ptsoft      AS  CHAR FORMAT "X(5)"     INIT "".
DEFINE    VAR nvw_gpline      AS  CHAR FORMAT "X(20)"    INIT "".
DEFINE    VAR nvw_gplinedes   AS  CHAR FORMAT "X(35)"    INIT "".
DEFINE    VAR nvw_insure      AS  CHAR FORMAT "X(22)".
DEFINE    VAR nvw_adjust      AS  CHAR FORMAT "X(45)". 
DEFINE    VAR nvw_policy      AS  CHAR FORMAT "X(09)".
DEFINE    VAR nvw_res         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_netl_d      AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.                              
DEFINE    VAR nvw_resfe       AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_netl_dfe    AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_gross       AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_facri       AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_1st         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_2nd         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_qs5         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_tfp         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_eng         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_mar         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_xol         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_rq          AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.                                         
DEFINE    VAR nvw_mps         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_btr         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_otr         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.                           
DEFINE    VAR nvw_fo1         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_fo2         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_fo3         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.                                          
DEFINE    VAR nvw_fo4         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_ftr         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_net         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.                                           
DEFINE    VAR nvw_ced         AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_fe          AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR nvw_totgross    AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE    VAR n_claim2        AS  CHAR FORMAT "X(16)".
DEFINE    VAR nv_coper        AS DECI FORMAT "->>>,>>>,>>>,>>9.99".
DEFINE    VAR nv_sico         AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEFINE    VAR nv_sigr         AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99".
DEFINE    VAR nv_write1       AS CHAR .
DEFINE    VAR nv_acno1        AS CHAR FORMAT "X(10)". 
DEFINE    VAR nv_prodnam      AS CHAR FORMAT "X(50)".
DEFINE    VAR nvw_produc      AS CHAR FORMAT "X(45)".
DEFINE    VAR nv_agent        AS CHAR FORMAT "X(10)".       /*Saowapa U. 10/07/61*/
DEFINE    VAR nv_adjusna      AS CHAR FORMAT "X(50)".
DEFINE    VAR nv_wextref      AS CHAR FORMAT "X(50)".
DEFINE    VAR nv_wintref      AS CHAR FORMAT "x(50)".
DEFINE    VAR nv_extnam       AS CHAR FORMAT "X(50)".
DEFINE    VAR nvw_exter       AS CHAR FORMAT "X(45)".
DEFINE    VAR nvw_losdat      AS DATE FORMAT "99/99/99".
DEFINE    VAR nvw_notdat      AS DATE FORMAT "99/99/99".
DEFINE    VAR nvw_group       AS CHAR FORMAT "X(7)".  
DEFINE    VAR nv_pacod        AS CHAR FORMAT "X(02)".
DEFINE    VAR nv_pades        AS CHAR FORMAT "X(20)".
DEFINE    VAR nv_write        AS CHAR INIT "".
DEFINE    VAR nv_write2       AS CHAR INIT "".
DEFINE    VAR nv_cedclm       AS CHAR FORMAT "X(16)".
DEF       VAR nv_docst        AS CHAR FORMAT "X(4)".
DEF VAR nvw_tty  AS CHAR FORMAT "X(2)" INIT "".
/*DEFINE STREAM ns1. */
DEFINE STREAM ns2. 
DEFINE WORKFILE W016
    FIELD wfpoltyp     AS CHAR FORMAT "X(2)"
    FIELD wfDI         AS CHAR FORMAT "X"
    FIELD wfpoldes     AS CHAR FORMAT "X(35)"
    FIELD wfptsoft     AS CHAR FORMAT "X(5)"
    FIELD wfgroupline  AS CHAR FORMAT "X(20)"
    FIELD wfgroupdes   AS CHAR FORMAT "X(35)"
    FIELD wfgross      AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wf1st        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wf2nd        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wffacri      AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfqs5        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wftfp        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfeng        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfmar        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfrq         AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wffo1        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wffo2        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfret        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfxol        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfmps        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfbtr        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfotr        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wffo3        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wffo4        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wfftr        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9" 
    FIELD wffe         AS DECI FORMAT "->>,>>>,>>>,>>>,>>9"
    FIELD wftotgross   AS DECI FORMAT "->>,>>>,>>>,>>>,>>9" 
    FIELD wfced        AS DECI FORMAT "->>,>>>,>>>,>>>,>>9" 
    /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
    FIELD wfosbh       AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99" 
    FIELD wfttybh      AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99" 
    FIELD wffacbh      AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99" 
    FIELD wfothbh      AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99"  .
    /* ------ End [A59-0613] ------ */

DEFINE VAR nv_loss     AS CHAR FORMAT "X(99)".
DEFINE WORKFILE wclm120
    FIELD wclaim       AS CHAR FORMAT "X(12)"
    FIELD wloss        AS CHAR FORMAT "X(99)"
    FIELD wlossfe      AS CHAR FORMAT "X(99)".   
DEFINE  VAR  nvw_compres      AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE  VAR  nvw_compnetl     AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE  VAR  nvw_compgross    AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.
DEFINE  WORKFILE  w_brncomp   
    FIELD bran    AS  CHAR FORMAT "X(2)"
    FIELD cres    AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0  
    FIELD cpaid   AS  DECI FORMAT "->>>,>>>,>>>,>>9.99" INIT 0.  
DEF VAR nv_br1       AS CHAR FORMAT "X(2)".  
DEF VAR nv_claimno   AS CHAR FORMAT "X(12)". 
DEF VAR nv_direct    AS CHAR FORMAT "X(13)". 
DEF VAR nv_trndat    AS DATE FORMAT "99/99/99".
DEF VAR nv_comdat    AS DATE FORMAT "99/99/99".
DEFINE WORKFILE wfszr016
    FIELD wclaim  AS CHAR FORMAT "X(16)"
    FIELD wfe     AS DECI FORMAT "->>,>>>,>>>,>>>,>>9" INIT 0
    FIELD wgross  AS DECI FORMAT "->>,>>>,>>>,>>>,>>9" INIT 0
    FIELD wced    AS DECI FORMAT "->>,>>>,>>>,>>>,>>9" INIT 0.

DEFINE WORKFILE wdetail016
    FIELD poltyp  AS CHAR FORMAT "X(5)"
    FIELD branch  AS CHAR FORMAT "X(2)"
    FIELD claim   AS CHAR FORMAT "X(20)"
    FIELD policy  AS CHAR FORMAT "X(20)"
    FIELD losdat  AS DATE FORMAT "99/99/99"
    FIELD intref  AS CHAR FORMAT "X(20)"
    FIELD nname   AS CHAR FORMAT "X(60)"
    FIELD gross   AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99" 
    FIELD tgross  AS DECI FORMAT "->>,>>>,>>>,>>>,>>9.99" .  /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/

DEF        VAR i           AS INT  INIT 0.
DEF        VAR ntype       AS CHAR FORMAT "X".
DEF SHARED VAR n_trndatfr  AS DATE FORMAT 99/99/9999.  /* = fiProcessdate  = acproc_fil.entdat*/  
DEF SHARED VAR nv_datfr    AS DATE FORMAT "99/99/9999". 
DEF SHARED VAR nv_datto    AS DATE FORMAT "99/99/9999".

DEF VAR nvw_osbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nvw_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nvw_facbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR nvw_othbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
/* total type */
DEF VAR ntt_osbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntt_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntt_facbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntt_othbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
/* total branch */
DEF VAR ntb_osbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntb_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntb_facbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntb_othbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
/* total line */
DEF VAR ntl_osbh    AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntl_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntl_facbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".  
DEF VAR ntl_othbh   AS DECI  FORMAT ">,>>>,>>>,>>9.99-".
/* grand banch */
DEF VAR ngb_osbh    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".
DEF VAR ngb_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".
DEF VAR ngb_facbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".
DEF VAR ngb_othbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".
/* grand line */
DEF VAR ngl_osbh    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".  
DEF VAR ngl_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".  
DEF VAR ngl_facbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".  
DEF VAR ngl_othbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".
/* sum type */                                             
DEF VAR nti_osbh    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-". 
DEF VAR nti_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-". 
DEF VAR nti_facbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-". 
DEF VAR nti_othbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".

DEF VAR ntd_osbh    AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".  
DEF VAR ntd_ttybh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".  
DEF VAR ntd_facbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-".  
DEF VAR ntd_othbh   AS DECI  FORMAT ">,>>>,>>>,>>>,>>9.99-". 
/* ------ End [A59-0613] ------ */

/*------------ A58-0144 ------------*/
DEF VAR nv_length  AS INT     INIT 0.  
DEF VAR nv_dec     AS DECIMAL INIT 0.
DEF VAR nv_trun    AS DECIMAL INIT 0.

PROCEDURE pd_cal:
IF nv_dec <> 0 THEN DO:
    ASSIGN
        nv_length = 0
        nv_trun   = nv_dec - TRUNCATE(nv_dec,0).
     IF nv_trun   > 0 THEN DO:
        nv_length = LENGTH(STRING(nv_trun)) - 1. 

        IF nv_length > 2 THEN DO:
            loop_round:
            REPEAT: 
                nv_length = nv_length - 1.
                nv_dec    = ROUND(nv_dec,nv_length).
                IF nv_length = 2 THEN LEAVE loop_round.
            END.                
        END.
    END.
END.
END PROCEDURE.
/*------------ end A58-0144 -------------*/

ASSIGN 
       n_output2 = (n_output) + "sum_non.slk"
       n_output  = (n_output) + ".slk". 
       
OUTPUT STREAM ns2 TO VALUE (n_output).  /* For Summary Text Output */
DO TRANSACTION :
    FOR EACH Szr016: DELETE Szr016. END.
    FOR EACH W016  : DELETE W016.   END.
    FOR EACH wdetail016 : DELETE wdetail016. END.
    FOR EACH wfsum : DELETE wfsum.  END.
     
END.

/*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
ASSIGN ntl_osbh  = 0 
       ntl_ttybh = 0
       ntl_facbh = 0
       ntl_othbh = 0.
/* ---------End [A59-0613] --------- */

Loop_clm100:
FOR EACH czm100  USE-INDEX czm10002 WHERE 
    czm100.ASDAT     = n_asdat   AND 
    czm100.BRANCH   >= nv_branfr AND
    czm100.BRANCH   <= nv_branto  

    BREAK BY CZM100.BRANCH 
          BY SUBSTR(CZM100.POLTYP,2,2)
          BY SUBSTR(CZM100.CLAIM,1,1)
          BY CZM100.CLAIM:       

    IF non_poltyp = 1 THEN DO:    /*Non-Motor All But Not 30,01,04*/
        IF (SUBSTR(czm100.POLTYP,2,1) = "7"  OR 
            czm100.POLTYP  = "M30"  OR    /*CMIP*/
            czm100.POLTYP  = "M01"  OR    /*CMIP*/
            czm100.POLTYP  = "M04"  OR    /*CMIP*/
            czm100.POLTYP  = "  ") THEN NEXT Loop_clm100.
    END.
    ELSE IF non_poltyp = 2 THEN DO:             /*30,01,04 Only*/
        IF (czm100.POLTYP  <>  "M01"  AND
            czm100.POLTYP  <>  "M04"  AND
            czm100.POLTYP  <>  "M30") THEN NEXT Loop_clm100.
    END.
    ELSE IF non_poltyp = 3 THEN DO:
        IF (SUBSTR(czm100.POLTYP,2,1) = "7" OR  /*Non-motor all*/
            czm100.POLTYP  = " ") THEN NEXT Loop_clm100.
    END.
    ELSE DO:
        IF czm100.POLTYP  = "" THEN NEXT Loop_clm100.
    END.
    DISP czm100.claim WITH NO-LABEL TITLE "Output data:...."  WIDTH 45  FRAME b VIEW-AS DIALOG-BOX. 
    
    FOR EACH  czd101 USE-INDEX czd10101 NO-LOCK WHERE
        czd101.asdat  = n_asdat  AND
        czd101.claim  = czm100.claim 
        BREAK BY czd101.clmant 
              BY czd101.clitem  .
        /*FOR EACH Clm102 USE-INDEX clm10201 WHERE Clm102.claim = czm100.claim  NO-LOCK .*/
        DISP czm100.claim WITH NO-LABEL TITLE "Output Report..."  FRAME b VIEW-AS DIALOG-BOX. 

        FIND FIRST Clm100 USE-INDEX Clm10001 WHERE Clm100.claim = czd101.claim NO-LOCK NO-ERROR.
        IF AVAIL clm100 THEN DO:
            IF (SUBSTR(clm100.claim,1,1) <> "D"  AND SUBSTR(clm100.claim,1,1) <> "I"     AND 
                LENGTH(clm100.claim)     <> 12)  OR (SUBSTR(clm100.claim,1,2) < "10"     AND  
                                                     SUBSTR(clm100.claim,1,2) > "99"  ) THEN DO: NEXT loop_clm100.
            END.
            
            ASSIGN
                nvw_res      = 0
                nvw_netl_d   = 0
                nvw_gross    = 0
                nvw_resfe    = 0
                nvw_netl_dfe = 0
                nvw_fe       = 0
                nvw_totgross = 0
                nvw_ced      = 0
                nv_pacod     = ""
                nv_pades     = "" 
                n_claim2     = clm100.claim
                nvw_compres  = 0
                nvw_compnetl = 0.

           
            FIND LAST clm120 USE-INDEX clm12001  WHERE 
                clm120.claim  = czm100.CLAIM     AND
                clm120.clmant = czd101.clmant    AND
                clm120.clitem = czd101.clitem    NO-LOCK NO-ERROR.
            IF AVAIL clm120 THEN DO:
                ASSIGN
                nvw_compnetl = deci(czd101.paidamt)
                nv_docst     = czm100.DOCST.

                FIND FIRST Wclm120 WHERE   Wclm120.wclaim  = Clm120.claim  NO-ERROR.
                IF NOT AVAILABLE Wclm120 THEN DO:
                    CREATE Wclm120.
                    ASSIGN 
                        Wclm120.wclaim = Clm120.claim
                        Wclm120.wloss  = "".
                END.
                IF Wclm120.wloss = "" THEN DO:
                    IF Clm120.loss <> "" THEN
                       Wclm120.wloss = CAPS(Clm120.loss) + "/" + nv_docst .
                END.
                ELSE DO:
                    IF Clm120.loss <> "" THEN
                       Wclm120.wloss = TRIM(Wclm120.wloss) + "," + CAPS(Clm120.loss) + "/" + nv_docst.
                END.
            END.
            ASSIGN 
              nvw_fe          = 0
              nvw_gross       = czm100.OS 
              nvw_totgross    = nvw_gross + nvw_fe
              nvw_res         = 0 
              nvw_netl_d      = 0 
              nvw_resfe       = 0
              nvw_netl_dfe    = 0.
                
            IF (n_ostyp = 1 ) AND ( nvw_gross = 0 ) THEN NEXT loop_clm100.
            IF (n_ostyp = 1 ) AND ( nvw_totgross = 0 ) THEN NEXT loop_clm100.
            IF nvw_gross < 0    THEN NEXT loop_clm100.   
            IF nvw_totgross < 0 THEN NEXT loop_clm100.    
            nv_br1    = "".
            
            IF (SUBSTR(clm100.policy,1,1) = "D"   OR SUBSTR(clm100.policy,1,1) = "I"   OR SUBSTR(clm100.policy,1,1) = "C")  THEN 
                nv_br1 = SUBSTR(clm100.policy,2,1).      /* Branch */
            ELSE nv_br1 = SUBSTR(clm100.policy,1,2).     /* Branch */ 
            IF (SUBSTRING(clm100.policy,1,1) = "I" AND (SUBSTR(clm100.policy,2,1) >= "1" AND SUBSTR(clm100.policy,2,1) <= "9")) THEN DO:
                nv_br1 = "9" + SUBSTRING(clm100.policy,2,1).
            END.  
                ASSIGN
                   nv_direct  = "" 
                   nvw_intref = "".

            IF      SUBSTRING(clm100.claim,1,1) = "D" THEN ASSIGN nv_direct = "D" + clm100.claim.
            ELSE IF SUBSTRING(clm100.claim,1,1) = "I" THEN ASSIGN nv_direct = "I" + clm100.claim.
                
            ELSE nv_direct = "D" + clm100.claim.
            ASSIGN nvw_intref  =  clm100.police.

            FIND FIRST wdetail016  WHERE  wdetail016.claim = nv_direct    NO-ERROR.   
            IF NOT AVAIL wdetail016 THEN DO:                                                          
                CREATE wdetail016.                                                                    
                ASSIGN                                                                            
                    wdetail016.poltyp = Clm100.poltyp                                                 
                    wdetail016.branch = nv_br1                                                        
                    wdetail016.claim  = nv_direct                                                     
                    wdetail016.policy = Clm100.policy                                                 
                    wdetail016.losdat = Clm100.losdat                                                 
                    wdetail016.intref = nvw_intref                                                    
                    wdetail016.nname  = TRIM (Clm100.ntitle) + TRIM (Clm100.name1)                    
                    wdetail016.tgross = nvw_totgross
                    wdetail016.gross  = czm100.amt[20] .     /*kridtiya i. */ 

                FIND FIRST wfszr016 WHERE wfszr016.wclaim = nv_direct NO-ERROR.    
                IF NOT AVAIL wfszr016 THEN DO:                                                    
                    CREATE wfszr016.                                                              
                    ASSIGN 
                     /* wfszr016.wfe       = nvw_fe                                                  
                        wfszr016.wgross    = nvw_gross*/         /*kridtiya i. */ 
                        wfszr016.wclaim    = nv_direct   
                        wfszr016.wfe       = czm100.amt[19]      /*kridtiya i. */                                               
                        wfszr016.wgross    = czm100.OS    .      /*kridtiya i. */  
                END.
               
                FIND FIRST w_brncomp  WHERE w_brncomp.bran = nv_br1   NO-LOCK NO-ERROR NO-WAIT.   
                IF NOT AVAIL w_brncomp  THEN CREATE w_brncomp.                                    
                ASSIGN                                                                         
                 /* w_brncomp.cres    = w_brncomp.cres  + nvw_compres*/ 
                    w_brncomp.bran    = nv_br1   
                    w_brncomp.cres    = w_brncomp.cres  + czm100.OS
                    w_brncomp.cpaid   = w_brncomp.cpaid + nvw_compnetl.                       
                
            END.    /* szr016 */
        END. /* end if avail clm100 */
      /*END.    /* end for each clm102 */*/
    END. /*czd101 */
END.  /*czm100 */

/*HIDE FRAME nf2 NO-PAUSE.  */
LOOP_szr016:
FOR EACH wdetail016   NO-LOCK  
    BREAK BY wdetail016.branch
    BY SUBSTR (wdetail016.poltyp,2,2)
    BY SUBSTR (wdetail016.claim,1,1)
    BY wdetail016.claim :
    ASSIGN 
        nvw_facri  = 0        nvw_fo1    = 0 
        nvw_1st    = 0        nvw_fo2    = 0 
        nvw_2nd    = 0        nvw_fo3    = 0 
        nvw_qs5    = 0        nvw_fo4    = 0 
        nvw_tfp    = 0        nvw_ftr    = 0 
        nvw_eng    = 0        nvw_mps    = 0 
        nvw_mar    = 0        nvw_btr    = 0 
        nvw_xol    = 0        nvw_otr    = 0 
        nvw_rq     = 0        nvw_net    = 0                                                         
        n_treaty   = 0        nvw_ced    = 0 
        /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
        nvw_osbh   = 0        nvw_ttybh  = 0     
        nvw_facbh  = 0        nvw_othbh  = 0 .   
        /*---  A59-0613 ---*/

    FIND FIRST s0m005 USE-INDEX s0m00501    WHERE s0m005.key2 = wdetail016.poltyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL s0m005 THEN nvw_group = s0m005.key1.
    ASSIGN
        nv_coper   = 0
        nv_sico    = 0
        nv_sigr    = 0
        nv_acno1   = ""
        nv_cedclm  = ""
        nv_claimno = ""
        nv_claimno = SUBSTRING(wdetail016.claim,2,LENGTH(wdetail016.claim) - 1).

    FIND FIRST clm100 USE-INDEX clm10001 WHERE clm100.claim = nv_claimno   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm100 THEN DO:
        FIND LAST uwm100 USE-INDEX uwm10001     WHERE uwm100.policy = clm100.policy NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN DO:
            IF uwm100.coins = Yes THEN DO:
                nv_coper = 100 - uwm100.co_per.
                FOR EACH uwm120 USE-INDEX uwm12001 WHERE
                    uwm120.policy = uwm100.policy  AND
                    uwm120.rencnt = uwm100.rencnt  AND
                    uwm120.endcnt = uwm100.endcnt  NO-LOCK:
                    nv_sico       = nv_sico + uwm120.sico.
                    nv_sigr       = nv_sigr + uwm120.sigr.
                END.
                    nv_sico = nv_sigr - nv_sico.
            END.
        END.
        ASSIGN
        nv_acno1    = clm100.acno1       
        nvw_notdat  = Clm100.notdat      
        nv_cedclm   = clm100.cedclm.
    END.
    ASSIGN  
        nv_prodnam  = ""
        nvw_produc  = ""
        nv_extnam   = ""
        nvw_exter   = ""
        nv_wextref  = ""
        nv_wintref  = "" .  /*add kridtiya i. int.sur*/
    FIND FIRST xmm600 USE-INDEX xmm60001  WHERE xmm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xmm600 THEN DO:
        nvw_produc  = xmm600.acno.
        nv_prodnam  = xmm600.name.
    END.
    ELSE DO:
        FIND FIRST xtm600 USE-INDEX xtm60001  WHERE xtm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600 THEN DO:
            nvw_produc = xtm600.acno.
            nv_prodnam = xtm600.name.
        END.
    END.
    /*--Saowapa U. A61-0460 --*/
    FIND FIRST xmm600 USE-INDEX xmm60001  WHERE xmm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xmm600 THEN DO:
        nv_agent  = uwm100.agent.
    END.
    ELSE DO:
        FIND FIRST xtm600 USE-INDEX xtm60001  WHERE xtm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600 THEN DO:
            nv_agent  = uwm100.agent.
        END.
    END.
    /*--end Saowapa U. A61-0460 --*/
    FIND FIRST clm120 USE-INDEX clm12001    WHERE clm120.claim = nv_claimno   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm120 THEN DO:
        ASSIGN 
            nv_wintref = trim(clm120.intref)   /*add Kridtiya i. Int.surveyor ref*/
            nv_wextref = trim(clm120.extref).
        FIND FIRST xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = nv_wextref  NO-LOCK NO-ERROR.
        IF AVAIL xtm600 THEN DO:
            nv_extnam  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)). 
            nvw_exter  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).
        END.
        ELSE DO:
            FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_wextref  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xmm600 THEN DO:
                nv_extnam  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
                nvw_exter  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
            END.
            ELSE DO:
                ASSIGN
                nv_extnam  = ""
                nvw_exter  = "".
            END.
        END.
        
        FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_wintref  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm600 THEN 
            ASSIGN nv_wintref  = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
        ELSE DO:
            FIND FIRST xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = nv_wintref  NO-LOCK NO-ERROR.
            IF AVAIL xtm600 THEN 
                ASSIGN nv_wintref  = TRIM(TRIM(xtm600.ntitle) + " " + TRIM(xtm600.name)).
            ELSE nv_wintref  = "".
        END.
    END.

    nv_loss = "".

    FIND FIRST Wclm120 WHERE wclm120.wclaim = nv_claimno   NO-LOCK NO-ERROR.
    IF NOT AVAIL Wclm120 THEN nv_loss = "".
    ELSE nv_loss = TRIM(Wclm120.wloss).

   
    FIND LAST czm100  USE-INDEX czm10001 WHERE 
              czm100.ASDAT  = n_asdat    AND 
              CZM100.CLAIM  = nv_claimno NO-LOCK NO-ERROR.
    IF AVAIL czm100 THEN DO:
        ASSIGN 
            nv_coper  = czm100.COPER
            nv_sico   = czm100.SICO  .
    END.  /*--- FOR EACH Clm300 ---*/


    FOR EACH Clm300 USE-INDEX Clm30001  WHERE Clm300.claim = nv_claimno  NO-LOCK:
        IF Clm300.csftq = "F" THEN nvw_facri = nvw_facri + (Clm300.risi_p * wdetail016.gross) / 100.
        IF SUBSTRING (Clm300.rico,1,2) = "0T" AND SUBSTRING (Clm300.rico,6,2) = "01" THEN
            nvw_1st = (Clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING (Clm300.rico,1,2) = "0T" AND 
                SUBSTRING (Clm300.rico,6,2) = "02" AND
                NOT (CLM100.POLTYP = "M80"  OR CLM100.POLTYP = "M81" OR
                     CLM100.POLTYP = "M82"  OR CLM100.POLTYP = "M83" OR
                     CLM100.POLTYP = "M84"  OR CLM100.POLTYP = "M85" OR
                     CLM100.POLTYP = "C90") THEN DO:
            nvw_2nd = (Clm300.risi_p * wdetail016.gross) / 100.
        END.
        ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
                SUBSTR(CLM300.RICO,6,2) = "02" AND
                CLM100.poltyp           = "C90"  THEN 
                nvw_mar = (Clm300.risi_p * wdetail016.gross) / 100.

        ELSE IF SUBSTRING(Clm300.rico,1,4) = "STAT" THEN nvw_qs5 = (Clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(Clm300.rico,1,3) = "0QA"  THEN nvw_tfp = (Clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(Clm300.rico,1,3) = "0RQ"  THEN nvw_rq  = (Clm300.risi_p * wdetail016.gross) / 100.    
        ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2) = "F1" THEN 
            nvw_fo1 = (Clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2) = "F2" THEN
            nvw_fo2 = (Clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2) = "F3" THEN DO:
            IF LOOKUP (wdetail016.poltyp,"M80,M81,M82,M83,M84,M85") <> 0 THEN
                nvw_eng = nvw_eng + (Clm300.risi_p * wdetail016.gross) / 100.
            ELSE
                nvw_fo3 = (Clm300.risi_p * wdetail016.gross) / 100.
        END.
        ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2)  = "F4" THEN
            nvw_fo4 = (Clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(Clm300.rico,1,2) = "0T" AND SUBSTRING(Clm300.rico,6,2)  = "FT" THEN
            nvw_ftr = (Clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(clm300.rico,1,3) = "0PS" AND SUBSTRING(clm300.rico,6,2) = "01" THEN
            nvw_mps = (clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(clm300.rico,1,2) = "0T" AND SUBSTRING(clm300.rico,6,2)  = "FB" THEN
            nvw_btr = (clm300.risi_p * wdetail016.gross) / 100.
        ELSE IF SUBSTRING(clm300.rico,1,2) = "0T" AND SUBSTRING(clm300.rico,6,2)  = "FO" THEN
            nvw_otr = (clm300.risi_p * wdetail016.gross) / 100.
    END.  /*--- FOR EACH Clm300 ---*/ 
    ASSIGN nvw_adjust = ""
           nv_adjusna = "".
   
 ASSIGN
    n_fac     =   nvw_facri
    n_treaty  =   nvw_1st 
                + nvw_2nd + nvw_eng
                + nvw_mar + nvw_rq
                + nvw_fo1 + nvw_fo2
                + nvw_fo3 + nvw_fo4  
                + nvw_ftr + nvw_mps
                + nvw_btr + nvw_otr 

    nvw_totgross = wdetail016.gross
    nvw_ced   =   nvw_facri + n_treaty + nvw_qs5 + nvw_tfp
    
    n_comp    =   nvw_qs5 + nvw_tfp
    nvw_net   =   nvw_totgross - n_fac - n_treaty - n_comp .

   /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
       IF SUBSTR(wdetail016.claim,1,1) = "D" OR 
          SUBSTR(wdetail016.claim,1,1) = "I" THEN DO:
          ASSIGN ntype = SUBSTR(wdetail016.claim,1,1).
       END.
       ELSE DO:
           ASSIGN ntype = "D" .
       END.
   /*------ end A59-0613 -------*/

    FIND FIRST wfszr016 WHERE SUBSTR(wfszr016.wclaim,2,LENGTH(wfszr016.wclaim) - 1) = nv_claimno NO-ERROR.
    IF AVAIL wfszr016 THEN DO:
        ASSIGN 
            nvw_fe       = wfszr016.wfe
            nvw_totgross = wfszr016.wgross.                               
    END.
    /*------------------- A58-0144 ---------------------*/
    nv_dec  =  nvw_facri.   RUN pd_cal. nvw_facri  = nv_dec.
    nv_dec  =  nvw_2nd  .   RUN pd_cal. nvw_2nd    = nv_dec.
    nv_dec  =  nvw_tfp  .   RUN pd_cal. nvw_tfp    = nv_dec.
    nv_dec  =  nvw_mar  .   RUN pd_cal. nvw_mar    = nv_dec.
    nv_dec  =  nvw_fo1  .   RUN pd_cal. nvw_fo1    = nv_dec.
    nv_dec  =  nvw_fo3  .   RUN pd_cal. nvw_fo3    = nv_dec.
    nv_dec  =  nvw_ftr  .   RUN pd_cal. nvw_ftr    = nv_dec.
    nv_dec  =  nvw_btr  .   RUN pd_cal. nvw_btr    = nv_dec.
    nv_dec  =  nvw_1st  .   RUN pd_cal. nvw_1st    = nv_dec. 
    nv_dec  =  nvw_qs5  .   RUN pd_cal. nvw_qs5    = nv_dec. 
    nv_dec  =  nvw_eng  .   RUN pd_cal. nvw_eng    = nv_dec. 
    nv_dec  =  nvw_rq   .   RUN pd_cal. nvw_rq     = nv_dec. 
    nv_dec  =  nvw_fo2  .   RUN pd_cal. nvw_fo2    = nv_dec. 
    nv_dec  =  nvw_fo4  .   RUN pd_cal. nvw_fo4    = nv_dec. 
    nv_dec  =  nvw_mps  .   RUN pd_cal. nvw_mps    = nv_dec. 
    nv_dec  =  nvw_otr  .   RUN pd_cal. nvw_otr    = nv_dec. 
    /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
    nv_dec  =  nvw_osbh  .  RUN pd_cal. nvw_osbh   = nv_dec. 
    nv_dec  =  nvw_ttybh .  RUN pd_cal. nvw_ttybh  = nv_dec. 
    nv_dec  =  nvw_facbh .  RUN pd_cal. nvw_facbh  = nv_dec. 
    nv_dec  =  nvw_othbh .  RUN pd_cal. nvw_othbh  = nv_dec.
     /* ---------------- End [A59-0613] ---------------- */

    ACCUMULATE 
        1 (COUNT BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                 BY SUBSTRING (wdetail016.claim,1,1))
        wfszr016.wgross  (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                                BY SUBSTRING (wdetail016.claim,1,1))
        wfszr016.wfe     (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                                BY SUBSTRING (wdetail016.claim,1,1))
        wdetail016.gross (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                                BY SUBSTRING (wdetail016.claim,1,1))
        nvw_ced   (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_facri (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_1st   (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_2nd   (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_qs5   (TOTAL BY wdetail016.branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_tfp   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_eng   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_mar   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_xol   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_rq    (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_fo1   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_fo2   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_fo3   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_fo4   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_ftr   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_mps   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        nvw_btr   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2)   
                         BY SUBSTRING (wdetail016.claim,1,1))                        
        nvw_otr   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2)   
                         BY SUBSTRING (wdetail016.claim,1,1))                        
        nvw_net   (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2) 
                         BY SUBSTRING (wdetail016.claim,1,1))
        /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
        nvw_osbh  (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2)
                         BY SUBSTRING (wdetail016.claim,1,1))           
        nvw_ttybh (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2)    
                         BY SUBSTRING (wdetail016.claim,1,1))                        
        nvw_facbh (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2)    
                         BY SUBSTRING (wdetail016.claim,1,1))                         
        nvw_othbh (TOTAL BY wdetail016.Branch BY SUBSTRING (wdetail016.poltyp,2,2)
                         BY SUBSTRING (wdetail016.claim,1,1)).   
        /* ------ End [A59-0613] ------ */

    IF FIRST-OF (SUBSTRING (wdetail016.poltyp,2,2)) THEN DO:
        FIND Xmm031 USE-INDEX Xmm03101 WHERE Xmm031.poltyp = wdetail016.poltyp  NO-LOCK NO-ERROR.
        IF AVAIL xmm031 THEN DO:
            ASSIGN nvw_ntype  = Xmm031.poldes .
                /*nvw_ptsoft  = trim(xmm031.ptsoft) 
                 nvw_ptsoft  = substr(trim(wdetail016.poltyp),2,2)   .*/
            IF       substr(trim(wdetail016.poltyp),2,2) = "70"  THEN ASSIGN nvw_ptsoft = "70" nvw_gpline = "MOTOR" nvw_gplinedes = "70".
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "72"  THEN ASSIGN nvw_ptsoft = "72" nvw_gpline = "MOTOR" nvw_gplinedes = "72".
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "73"  THEN ASSIGN nvw_ptsoft = "73" nvw_gpline = "MOTOR" nvw_gplinedes = "73".
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "74"  THEN ASSIGN nvw_ptsoft = "74" nvw_gpline = "MOTOR" nvw_gplinedes = "74".
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "10") OR                                                 
                    (substr(trim(wdetail016.poltyp),2,2) = "17") THEN ASSIGN nvw_ptsoft = "10" nvw_gpline = "FIRE"  nvw_gplinedes = "10,17".
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "18"  THEN ASSIGN nvw_ptsoft = "18" nvw_gpline = "FIRE"  nvw_gplinedes = "18"   .
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "11") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "12") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "13") THEN ASSIGN nvw_ptsoft = "11" nvw_gpline = "MISC" nvw_gplinedes  = "11,12,13".
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "14") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "19") THEN ASSIGN nvw_ptsoft = "14" nvw_gpline = "MISC" nvw_gplinedes  = "14,19".
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "15"  THEN ASSIGN nvw_ptsoft = "15" nvw_gpline = "MISC" nvw_gplinedes  = "15". 
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "16"  THEN ASSIGN nvw_ptsoft = "16" nvw_gpline = "MISC" nvw_gplinedes  = "16". 
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "20") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "32") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "33") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "34") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "35") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "36") OR
                     substr(trim(wdetail016.poltyp),2,2) = "39"  THEN ASSIGN nvw_ptsoft = "20" nvw_gpline = "MISC"  nvw_gplinedes = "20,32,33,34,35,36,39" .
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "30"  THEN ASSIGN nvw_ptsoft = "30" nvw_gpline = "INNO." nvw_gplinedes = "30" .
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "40") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "41") OR
                     substr(trim(wdetail016.poltyp),2,2) = "43"  THEN ASSIGN nvw_ptsoft = "40" nvw_gpline = "MISC"  nvw_gplinedes = "40,41,43".
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "21") OR     
                    (substr(trim(wdetail016.poltyp),2,2) = "22") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "23") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "24") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "37") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "38") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "02") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "03") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "05") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "06") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "07") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "08") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "09") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "50") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "51") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "52") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "53") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "54") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "55") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "56") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "57") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "58") OR    
                    (substr(trim(wdetail016.poltyp),2,2) = "59") THEN ASSIGN nvw_ptsoft = "50" nvw_gpline = "MISC"   nvw_gplinedes = "21,22,23,24,37,38,02-03,05-09,50-59" . 
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "01"  THEN ASSIGN nvw_ptsoft = "01" nvw_gpline = "INNO."  nvw_gplinedes = "01".
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "04"  THEN ASSIGN nvw_ptsoft = "04" nvw_gpline = "INNO."  nvw_gplinedes = "04".
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "80") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "81") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "82") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "83") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "84") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "85") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "86") THEN ASSIGN nvw_ptsoft = "80" nvw_gpline = "MISC" nvw_gplinedes = "80,81,82,83,84,85,86" .   
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "65") OR 
                     substr(trim(wdetail016.poltyp),2,2) = "66"  THEN ASSIGN nvw_ptsoft = "65" nvw_gpline = "MISC" nvw_gplinedes = "65,66" .
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "61"  THEN ASSIGN nvw_ptsoft = "61" nvw_gpline = "MISC" nvw_gplinedes = "61"  . 
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "60") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "62") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "63") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "64") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "67") THEN ASSIGN nvw_ptsoft = "60" nvw_gpline = "PA	 " nvw_gplinedes = "60,62,63,64,67" .
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "68") OR 
                     substr(trim(wdetail016.poltyp),2,2) = "69"  THEN ASSIGN nvw_ptsoft = "68" nvw_gpline = "PA	 " nvw_gplinedes = "68,69"  .
            ELSE IF (substr(trim(wdetail016.poltyp),2,2) = "31") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "90") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "92") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "93") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "94") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "95") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "96") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "97") OR
                    (substr(trim(wdetail016.poltyp),2,2) = "98") OR 
                    (substr(trim(wdetail016.poltyp),2,2) = "99") THEN ASSIGN nvw_ptsoft = "90" nvw_gpline = "MARI" nvw_gplinedes = "31  90  92  93-99". 
            ELSE IF  substr(trim(wdetail016.poltyp),2,2) = "91"  THEN ASSIGN nvw_ptsoft = "91" nvw_gpline = "MARI" nvw_gplinedes = "91".
            
        END.
        ELSE "!!! Not found (" + TRIM (wdetail016.poltyp) + ")".
    END.  /*--- FIRST-OF (Szr016.poltyp) ---*/
    IF FIRST-OF (SUBSTRING (wdetail016.claim,1,1)) THEN DO:
        FIND FIRST W016 WHERE
             W016.wfpoltyp = SUBSTR (wdetail016.poltyp,2,2)   AND  
             W016.wfDI     = SUBSTR (wdetail016.claim,1,1)  NO-LOCK NO-ERROR.
        IF NOT AVAIL W016 THEN DO:
            CREATE W016.
            ASSIGN
                W016.wfpoltyp    = SUBSTR (wdetail016.poltyp,2,2)
                W016.wfpoldes    = nvw_ntype
                w016.wfptsoft    = nvw_ptsoft
                W016.wfgroupline = nvw_gpline
                w016.wfgroupdes  = nvw_gplinedes
                W016.wfDI        = SUBSTR (wdetail016.claim,1,1).
        END. /* NOT AVAIL */                                                 
    END.  /* FIRST-OF (SUBSTRING (Szr016.claim,1,1)) */
    IF FIRST-OF (wdetail016.branch) THEN DO:
        FIND Xmm023 USE-INDEX Xmm02301 WHERE Xmm023.branch = wdetail016.branch NO-LOCK NO-ERROR.
        nvw_nbran = IF AVAILABLE Xmm023 THEN Xmm023.bdes ELSE "". 
    END.  /* FIRST-OF (Szr016.branch) */
    IF FIRST (wdetail016.branch) THEN DO:
        /*DISP STREAM ns1 WITH FRAME fhdr1. */
        PUT STREAM ns2 
            "AS AT  " 
            STRING (TODAY,"99/99/9999") FORMAT "X(10)" " "
            STRING(TIME,"HH:MM:SS")   
            SKIP
            "LIST OF OUTSTANDING CLAIM (NON-MOTOR) (NEW) SYS : WACROSC2"  
            SKIP
            "RUNNING OF ENTRY DATE FROM : " n_asdat   
            SKIP
            "YEAR"                 "|"
            "TYPE"                 "|"
            "BRANCH"               "|"
            "Poicy Type"           "|" 
            "Policy Desc."         "|"
            "Policy Desc.LINE "    "|"
            "Group Line"           "|" 
            "Group AC"             "|" 
            "Group"                "|"    
            "Claim No."            "|"
            "Trans.Date R/E CNT."  "|"   
            "Com Date"             "|"         
            "Entry Date"           "|"     
            "Notify Date"          "|"     
            "Loss Date"            "|"     
            "Open Date"            "|"     
            "Policy No."           "|"
            "Insure Name"          "|"
            "Nature of Loss/Doc.Status" "|"  
            "Cause of Loss"        "|"   
            "GROSS"                "|"
            "SURVEY FEE"           "|"           
            "TOTAL GROSS"          "|"
            "CEDED"                "|"
            "1st.TREATY"           "|"
            "2nd.TREATY"           "|"      
            "FAC.RI."              "|"
            "Q.S.5%"               "|"
            "TFP"                  "|"
            "MPS"                  "|"
            "ENG.FAC."             "|"
            "MARINE O/P"           "|"
            "R.Q."                 "|"
            "BTR"                  "|"
            "OTR"                  "|"
            "FTR"                  "|"
            "F/O I"                "|" 
            "F/O II"               "|"
            "F/O III"              "|"
            "F/O IV"               "|"
            "GROSS RET."           "|"
            "XOL"                  "|"
            /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
            "Gross QS BH"          "|"
            "TTY QS BH"            "|"
            "Fac QS BH"            "|"
            "Other QS BH"          "|"
             /* --------- A59-0613 ----------- */
            "CO%"                  "|"      
            "CO SI"                "|"      
            "Adjustor"             "|"  
            "Int. Surveyor Name"   "|"
            "Ext. Surveyor Name"   "|"
            "Producer Code "       "|"
            "Agent Code"           "|"    /*Saowapa U. A61-0460 30/10/2018*/
            "Ceding Claim no."     "|"
            "Text code Claim"      "|"
            "Claim comment "       SKIP. 

    END.  /* IF FIRST (Szr016.branch) */
    nvw_policy = wdetail016.policy.
    IF clm100.busreg <> "" THEN DO:
        FIND FIRST sym100 USE-INDEX sym10001 WHERE
            sym100.tabcod = "U070"    AND
            sym100.itmcod = clm100.busreg NO-LOCK NO-ERROR.
        IF AVAIL sym100 THEN  DO:
            nv_pacod      = sym100.itmcod.
            nv_pades      = sym100.itmdes.
        END.
    END.
    ELSE ASSIGN nv_pacod   = ""
                nv_pades   = ""
                nv_trndat  = ?
                nv_comdat  = ?.
    FIND FIRST uwm100 USE-INDEX uwm10001 WHERE 
        uwm100.policy = nvw_policy       AND
        uwm100.endcnt = 000              NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN ASSIGN nv_trndat = uwm100.trndat.
    ELSE ASSIGN nv_trndat = ?.
    FIND FIRST uwm100 USE-INDEX uwm10001  WHERE 
        uwm100.policy = nvw_policy        AND        
        uwm100.rencnt = clm100.rencnt     AND        
        uwm100.endcnt = clm100.endcnt     NO-LOCK NO-ERROR.  
    IF AVAIL uwm100 THEN ASSIGN nv_comdat = uwm100.comdat.
    ELSE ASSIGN nv_comdat = ?.
    
    /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
    IF czm100.losdat >= 07/01/2015 THEN DO:
        ASSIGN
        nvw_osbh   = wdetail016.gross * 0.2
        nvw_facbh  = nvw_facri * 0.2 .
        
       IF uwm100.trndat >= 07/01/2012 THEN
          ASSIGN
          nvw_ttybh = (nvw_1st + nvw_2nd + nvw_rq  + nvw_btr) * 0.2
          nvw_othbh = (nvw_qs5 + nvw_tfp + nvw_mps + nvw_eng 
                     + nvw_mar + nvw_otr + nvw_ftr + nvw_fo1 
                     + nvw_fo2 + nvw_fo3 + nvw_fo4) * 0.2.
       ELSE                                                   
           ASSIGN 
           nvw_ttybh = 0   
           nvw_othbh = (nvw_1st + nvw_2nd + nvw_rq  + nvw_btr
                      + nvw_qs5 + nvw_tfp + nvw_mps + nvw_eng 
                      + nvw_mar + nvw_otr + nvw_ftr + nvw_fo1 
                      + nvw_fo2 + nvw_fo3 + nvw_fo4) * 0.2.
    END.
        
    ELSE DO: 
        ASSIGN                                 
        nvw_osbh  = 0
        nvw_ttybh = 0
        nvw_facbh = 0
        nvw_othbh = 0.
    END.
    /*------------ End A59-0613 -------------*/ 
    nvw_tty = "".
    nvw_tty = IF SUBSTR(TRIM(nvw_policy),1,1) = "I" THEN "I" ELSE "D"  .


    PUT STREAM ns2
        SUBSTR(TRIM(nvw_policy),5,2) "|"   /*Year */
        nvw_tty                      "|"   /*Type */
        wdetail016.branch            "|" 
        wdetail016.poltyp            "|" 
        nvw_ntype                    "|" 
        nvw_gplinedes                "|"  /*Policy Desc. */
        nvw_ptsoft                   "|"  /*Group        */
        nvw_gpline                   "|"  /*Group AC     */
        nvw_group                    "|"    
        nv_claimno          FORMAT "XX-XX-XX/XXXXXXXXXX"    "|"  
        nv_trndat           FORMAT "99/99/99"               "|" 
        nv_comdat           FORMAT "99/99/99"               "|" 
        clm100.entdat       FORMAT "99/99/99"               "|" 
        nvw_notdat                                          "|"    
        wdetail016.losdat                                   "|"    
        clm100.entdat       FORMAT "99/99/99"               "|"   
        nvw_policy          FORMAT "XX-XX-XX/XXXXXXXXXX"    "|" 
        wdetail016.nname                                    "|"
        nv_loss             FORMAT "X(99)"                  "|"   
        clm100.loss1                                        "|"  
        wfszr016.wgross     FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        wfszr016.wfe        FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        wdetail016.gross    FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_ced             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_1st             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_2nd             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_facri           FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_qs5             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_tfp             FORMAT "->>>,>>>,>>>,>>9.99"    "|"       
        nvw_mps             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_eng             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_mar             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_rq              FORMAT "->>>,>>>,>>>,>>9.99"    "|"       
        nvw_btr             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_otr             FORMAT "->>>,>>>,>>>,>>9.99"    "|"       
        nvw_ftr             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_fo1             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_fo2             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_fo3             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_fo4             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_net             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        nvw_xol             FORMAT "->>>,>>>,>>>,>>9.99"    "|"
        /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
        nvw_osbh            FORMAT "->,>>>,>>>,>>9.99"      "|"
        nvw_ttybh           FORMAT "->,>>>,>>>,>>9.99"      "|"
        nvw_facbh           FORMAT "->,>>>,>>>,>>9.99"      "|"
        nvw_othbh           FORMAT "->,>>>,>>>,>>9.99"      "|"
        /* ---------- End [A59-0613] ----------- */
        nv_coper            FORMAT "->>>,>>>,>>>,>>9.99"    "|"     
        nv_sico             FORMAT "->,>>>,>>>,>>>,>>9.99"  "|" 
        clm100.police       FORMAT "X(10)"                  "|"  
        nv_wintref           "|"
        nv_extnam            "|"
        nvw_produc           "|" 
        nv_agent             "|"     /*Saowapa U. A61-0460 30/10/2018*/
        nv_cedclm            "|"
        nv_pacod             "|"
        nv_pades             SKIP.

       /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
       FIND FIRST wfsum WHERE wfsum.n_type = nvw_tty   AND
                              wfsum.n_bran = wdetail016.branch  AND
                              wfsum.n_line = SUBSTR(wdetail016.poltyp,2,2) NO-LOCK NO-ERROR.
       IF NOT AVAIL wfsum THEN DO:
           CREATE wfsum.
           ASSIGN 
               wfsum.n_type     = nvw_tty                 
               wfsum.n_bran     = wdetail016.branch        
               wfsum.n_line     = SUBSTR(wdetail016.poltyp,2,2)
               wfsum.n_year     = YEAR(nv_datto) 
               wfsum.n_month    = MONTH(nv_datto)
               wfsum.n_gross    = wfszr016.wgross 
               wfsum.n_fee      = wfszr016.wfe
               wfsum.nt_gross   = wfszr016.wgross  + wfszr016.wfe
               wfsum.n_ced      = nvw_ced   
               wfsum.n_1st      = nvw_1st    
               wfsum.n_2nd      = nvw_2nd  
               wfsum.n_fac      = nvw_facri 
               wfsum.n_qs5      = nvw_qs5    
               wfsum.n_tfp      = nvw_tfp    
               wfsum.n_mps      = nvw_mps    
               wfsum.n_eng      = nvw_eng    
               wfsum.n_mar      = nvw_mar    
               wfsum.n_rq       = nvw_rq     
               wfsum.n_btr      = nvw_btr    
               wfsum.n_otr      = nvw_otr    
               wfsum.n_ftr      = nvw_ftr    
               wfsum.n_fo1      = nvw_fo1    
               wfsum.n_fo2      = nvw_fo2    
               wfsum.n_fo3      = nvw_fo3    
               wfsum.n_fo4      = nvw_fo4 
               wfsum.n_ret      = nvw_net   .
               
       END.
       ELSE DO:
           ASSIGN wfsum.n_gross    = wfsum.n_gross + wfszr016.wgross      
                  wfsum.n_fee      = wfsum.n_fee + wfszr016.wfe
                  wfsum.nt_gross   = wfsum.nt_gross + (wfszr016.wgross  + wfszr016.wfe)
                  wfsum.n_ced      = wfsum.n_ced    +  nvw_ced    
                  wfsum.n_1st      = wfsum.n_1st    +  nvw_1st    
                  wfsum.n_2nd      = wfsum.n_2nd    +  nvw_2nd  
                  wfsum.n_fac      = wfsum.n_fac    +  nvw_facri 
                  wfsum.n_qs5      = wfsum.n_qs5    +  nvw_qs5    
                  wfsum.n_tfp      = wfsum.n_tfp    +  nvw_tfp    
                  wfsum.n_mps      = wfsum.n_mps    +  nvw_mps    
                  wfsum.n_eng      = wfsum.n_eng    +  nvw_eng    
                  wfsum.n_mar      = wfsum.n_mar    +  nvw_mar    
                  wfsum.n_rq       = wfsum.n_rq     +  nvw_rq     
                  wfsum.n_btr      = wfsum.n_btr    +  nvw_btr    
                  wfsum.n_otr      = wfsum.n_otr    +  nvw_otr    
                  wfsum.n_ftr      = wfsum.n_ftr    +  nvw_ftr    
                  wfsum.n_fo1      = wfsum.n_fo1    +  nvw_fo1    
                  wfsum.n_fo2      = wfsum.n_fo2    +  nvw_fo2    
                  wfsum.n_fo3      = wfsum.n_fo3    +  nvw_fo3    
                  wfsum.n_fo4      = wfsum.n_fo4    +  nvw_fo4 
                  wfsum.n_comp     = wfsum.n_comp   +  n_comp    
                  wfsum.n_ret      = wfsum.n_ret    +  nvw_net .  
       END.
          
         ASSIGN                               
             ntt_osbh  = ntt_osbh  + nvw_osbh 
             ntt_ttybh = ntt_ttybh + nvw_ttybh
             ntt_facbh = ntt_facbh + nvw_facbh
             ntt_othbh = ntt_othbh + nvw_othbh
                                              
             ntl_osbh  = ntl_osbh  + nvw_osbh   
             ntl_ttybh = ntl_ttybh + nvw_ttybh  
             ntl_facbh = ntl_facbh + nvw_facbh  
             ntl_othbh = ntl_othbh + nvw_othbh  

             ntb_osbh  = ntb_osbh  + nvw_osbh 
             ntb_ttybh = ntb_ttybh + nvw_ttybh
             ntb_facbh = ntb_facbh + nvw_facbh
             ntb_othbh = ntb_othbh + nvw_othbh
                                              
             ngb_osbh  = ngb_osbh  + nvw_osbh    
             ngb_ttybh = ngb_ttybh + nvw_ttybh   
             ngb_facbh = ngb_facbh + nvw_facbh   
             ngb_othbh = ngb_othbh + nvw_othbh   
                                                 
             ngl_osbh  = ngl_osbh  + nvw_osbh    
             ngl_ttybh = ngl_ttybh + nvw_ttybh   
             ngl_facbh = ngl_facbh + nvw_facbh   
             ngl_othbh = ngl_othbh + nvw_othbh .
                                              
             IF SUBSTR(wdetail016.claim,1,1) <> "I" THEN DO:
                ASSIGN ntd_osbh  = ntd_osbh  + nvw_osbh  
                       ntd_ttybh = ntd_ttybh + nvw_ttybh 
                       ntd_facbh = ntd_facbh + nvw_facbh 
                       ntd_othbh = ntd_othbh + nvw_othbh. 
             END.
 
             ASSIGN
             wfosbh     = wfosbh   + nvw_osbh  
             wfttybh    = wfttybh  + nvw_ttybh 
             wffacbh    = wffacbh  + nvw_facbh    
             wfothbh    = wfothbh  + nvw_othbh . 

             /* --------- End [A59-0613] ---------- */
        
    IF LAST-OF (SUBSTRING (wdetail016.claim,1,1)) THEN DO:  /* I,D */
        PUT STREAM ns2
            'Total Claim : ' FORMAT "X(15)" + '"' +
            SUBSTRING (wdetail016.claim,1,1) '"' 
            "|" "|" "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"  
            "|" "|" "|" "|" "|" "|" "|" "|"  
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) wfszr016.wgross)   FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) wfszr016.wfe)      FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) wdetail016.gross)  FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_ced)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_1st)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_2nd)           FORMAT "->>>,>>>,>>>,>>9.99" "|"    
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_facri)         FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_qs5)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_tfp)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_mps)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_eng)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_mar)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_rq)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_btr)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_otr)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_ftr)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo1)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo2)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo3)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo4)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_net)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
            (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_xol)           FORMAT "->>>,>>>,>>>,>>9.99" "|"  
              /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
             ntt_osbh                                                        FORMAT "->>>,>>>,>>>,>>9.99" "|" 
             ntt_ttybh                                                       FORMAT "->>>,>>>,>>>,>>9.99" "|"
             ntt_facbh                                                       FORMAT "->>>,>>>,>>>,>>9.99" "|"
             ntt_othbh                                                       FORMAT "->>>,>>>,>>>,>>9.99" "|"   SKIP.

             ASSIGN
             ntt_osbh   = 0           ntt_facbh  = 0   
             ntt_ttybh  = 0           ntt_othbh  = 0 .  
            /* -------- End [A59-0613] -------- */

        FIND FIRST W016 WHERE 
            W016.wfpoltyp = SUBSTR (wdetail016.poltyp,2,2)   AND   
            W016.wfDI     = SUBSTR (wdetail016.claim,1,1)    NO-LOCK NO-ERROR.
        IF AVAIL w016 THEN
            ASSIGN
            wfgross    = wfgross    + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) wfszr016.wgross) 
            wffe       = wffe       + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) wfszr016.wfe)  
            wftotgross = wftotgross + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) wdetail016.gross)
            wfced      = wfced      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_ced)
            wf1st      = wf1st      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_1st)
            wf2nd      = wf2nd      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_2nd)
            wffacri    = wffacri    + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_facri)
            wfqs5      = wfqs5      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_qs5)
            wftfp      = wftfp      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_tfp)
            wfeng      = wfeng      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_eng)
            wfmar      = wfmar      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_mar)
            wfrq       = wfrq       + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_rq)
            wffo1      = wffo1      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo1)
            wffo2      = wffo2      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo2)
            wffo3      = wffo3      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo3)
            wffo4      = wffo4      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_fo4)
            wfftr      = wfftr      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_ftr)
            wfret      = wfret      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_net)
            wfxol      = wfxol      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_xol)
            wfmps      = wfmps      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_mps)
            wfbtr      = wfbtr      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_btr)
            wfotr      = wfotr      + (ACCUM TOTAL BY SUBSTR (wdetail016.claim,1,1) nvw_otr).

        IF LAST-OF (SUBSTR (wdetail016.poltyp,2,2)) THEN DO:
            PUT STREAM ns2
                "|" "|" 
                nvw_nbran "|"
                SUBSTR (wdetail016.poltyp,2,2) "|"
                nvw_ntype      "|" 
                nvw_gplinedes  "|" 
                nvw_ptsoft     "|"
                nvw_gpline     "|" 
                "|" "|" "|" "|" "|" "|"
                "|" "|" "|" "|" "|" "|" 
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) wfszr016.wgross)    FORMAT "->>>,>>>,>>>,>>9.99" "|"                             
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) wfszr016.wfe)       FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) wdetail016.gross)   FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_ced)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_1st)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_2nd)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_facri)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_qs5)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_tfp)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_mps)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_eng)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_mar)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_rq)             FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_btr)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_otr)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_ftr)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_fo1)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_fo2)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_fo3)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_fo4)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_net)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                (ACCUM TOTAL BY SUBSTR (wdetail016.poltyp,2,2) nvw_xol)            FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
                 ntl_osbh                                                          FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                 ntl_ttybh                                                         FORMAT "->>>,>>>,>>>,>>9.99" "|"
                 ntl_facbh                                                         FORMAT "->>>,>>>,>>>,>>9.99" "|"
                 ntl_othbh                                                         FORMAT "->>>,>>>,>>>,>>9.99" "|"   SKIP.

                 ASSIGN 
                 ntl_osbh   = 0          ntl_facbh  = 0  
                 ntl_ttybh  = 0          ntl_othbh  = 0 .
                 
                /* -------- End [A59-0613] -------- */
               
            IF LAST-OF (wdetail016.branch) THEN DO:
                PUT STREAM ns2
                    "Total : " nvw_nbran "|" "|" "|" "|"
                    "|" "|" "|" "|" "|" "|" "|" "|" "|"
                    "|" "|" "|" "|" "|" "|" "|" 
                    (ACCUM TOTAL BY wdetail016.branch wfszr016.wgross)  FORMAT "->>>,>>>,>>>,>>9.99" "|"                
                    (ACCUM TOTAL BY wdetail016.branch wfszr016.wfe)     FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch wdetail016.gross) FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_ced)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_1st)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_2nd)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_facri)        FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_qs5)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_tfp)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_mps)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_eng)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_mar)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_rq)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_btr)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_otr)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_ftr)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_fo1)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_fo2)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_fo3)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_fo4)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_net)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL BY wdetail016.branch nvw_xol)          FORMAT "->>>,>>>,>>>,>>9.99" "|"
                     /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
                    ntb_osbh                                            FORMAT "->,>>>,>>>,>>9.99" "|"
                    ntb_ttybh                                           FORMAT "->,>>>,>>>,>>9.99" "|"
                    ntb_facbh                                           FORMAT "->,>>>,>>>,>>9.99" "|"
                    ntb_othbh                                           FORMAT "->,>>>,>>>,>>9.99" "|"  SKIP.
                    
                    ASSIGN 
                    ntb_osbh   = 0            ntb_facbh  = 0  
                    ntb_ttybh  = 0            ntb_othbh  = 0 .
                     /* -------- End [A59-0613] -------- */

                IF LAST (wdetail016.branch) THEN DO:  
                    PUT STREAM ns2  SKIP
                    "Grand Total All Branch" 
                    "|" "|" "|" "|" 
                    "|" "|" "|" "|" 
                    "|" "|" "|" "|"  
                    "|" "|" "|" "|" 
                    "|" "|" "|" "|" 
                    (ACCUM TOTAL wfszr016.wgross)   FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL wfszr016.wfe)      FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL wdetail016.gross)  FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_ced)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_1st)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_2nd)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_facri)         FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_qs5)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_tfp)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_mps)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_eng)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_mar)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_rq)            FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_btr)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_otr)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_ftr)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_fo1)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_fo2)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_fo3)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_fo4)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_net)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    (ACCUM TOTAL nvw_xol)           FORMAT "->>>,>>>,>>>,>>9.99" "|"
                    /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
                    ngb_osbh                        FORMAT "->,>>>,>>>,>>9.99" "|"
                    ngb_ttybh                       FORMAT "->,>>>,>>>,>>9.99" "|" 
                    ngb_facbh                       FORMAT "->,>>>,>>>,>>9.99" "|"
                    ngb_othbh                       FORMAT "->,>>>,>>>,>>9.99" "|"  SKIP(2)
                
                    "Grand Total by Policy Line"  SKIP.
            
                    ASSIGN  
                    ngb_osbh    = 0         ngb_facbh   = 0 
                    ngb_ttybh   = 0         ngb_othbh   = 0  
                    /* -------- End [A59-0613] -------- */

                    nvw_nbran   = ""        nvw_ntype   = "".
                       
                    /*PAGE STREAM ns1.*/
                    FOR EACH W016 BREAK BY W016.wfDI BY W016.wfpoltyp
                        WITH WIDTH 258 NO-BOX NO-LABEL DOWN FRAME ftl : 
                        ACCUMULATE 
                            wffe       (TOTAL BY W016.wfDI)
                            wfced      (TOTAL BY W016.wfDI)
                            wftotgross (TOTAL BY W016.wfDI)
                            wfgross    (TOTAL BY W016.wfDI)
                            wf1st      (TOTAL BY W016.wfDI)
                            wf2nd      (TOTAL BY W016.wfDI)
                            wffacri    (TOTAL BY W016.wfDI)
                            wfqs5      (TOTAL BY W016.wfDI)
                            wftfp      (TOTAL BY W016.wfDI)
                            wfeng      (TOTAL BY W016.wfDI)
                            wfmar      (TOTAL BY W016.wfDI)
                            wfrq       (TOTAL BY W016.wfDI)
                            wffo1      (TOTAL BY W016.wfDI)
                            wffo2      (TOTAL BY W016.wfDI)
                            wffo3      (TOTAL BY W016.wfDI)
                            wffo4      (TOTAL BY W016.wfDI)
                            wfftr      (TOTAL BY W016.wfDI)
                            wfret      (TOTAL BY W016.wfDI)
                            wfxol      (TOTAL BY W016.wfDI)
                            wfmps      (TOTAL BY W016.wfDI)
                            wfbtr      (TOTAL BY W016.wfDI)
                            wfotr      (TOTAL BY W016.wfDI)
                           /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
                            ngl_osbh         FORMAT "->>>,>>>,>>>,>>9.99"
                            ngl_ttybh        FORMAT "->>>,>>>,>>>,>>9.99"
                            ngl_facbh        FORMAT "->>>,>>>,>>>,>>9.99"
                            ngl_othbh        FORMAT "->>>,>>>,>>>,>>9.99".
                           
                            ASSIGN
                            ngl_osbh    = 0          ngl_facbh   = 0  
                            ngl_ttybh   = 0          ngl_othbh   = 0 .  
                           /* ------ End [A59-0613] ------ */

                        IF FIRST-OF (W016.wfDI) THEN DO:
                          
                            PUT STREAM ns2 
                                "Summary of " CAPS (W016.wfDI)  SKIP.
                        END.  /* DI */
                        PUT STREAM ns2
                            " " "|"
                            W016.wfpoltyp      "|"
                            W016.wfpoldes      "|"
                            w016.wfgroupdes    "|" 
                            w016.wfptsoft      "|" 
                            W016.wfgroupline   "|" 
                            "|" "|" "|" "|" "|" "|" "|" 
                            "|" "|" "|" "|" "|" "|" "|"  
                            wfgross     FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wffe        FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wftotgross  FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfced       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wf1st       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wf2nd       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wffacri     FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfqs5       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wftfp       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfmps       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfeng       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfmar       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfrq        FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfbtr       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfotr       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfftr       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wffo1       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wffo2       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wffo3       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wffo4       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfret       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            wfxol       FORMAT "->>>,>>>,>>>,>>9.99" "|"  
                            /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
                            wfosbh      FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                            wfttybh     FORMAT "->>>,>>>,>>>,>>9.99" "|"
                            wffacbh     FORMAT "->>>,>>>,>>>,>>9.99" "|"
                            wfothbh     FORMAT "->>>,>>>,>>>,>>9.99" "|" SKIP.
                             
                            IF W016.wfDI = "I" THEN DO:
                               ASSIGN nti_osbh  = nti_osbh  + W016.wfosbh  
                                      nti_ttybh = nti_ttybh + W016.wfttybh 
                                      nti_facbh = nti_facbh + W016.wffacbh 
                                      nti_othbh = nti_othbh + W016.wfothbh.
                            END.

                            ASSIGN
                            wfosbh     = 0        wffacbh    = 0  
                            wfttybh    = 0        wfothbh    = 0 . 
                            
                            /* ------ End [A59-0613] ------ */

                        IF LAST-OF (W016.wfDI) THEN DO:
                            PUT STREAM ns2
                                "All " W016.wfDI "|" "|" 
                                "|"
                                "|"
                                "|" "|" "|" "|" "|" "|" "|" "|" "|" 
                                "|" "|" "|" "|" "|" "|" "|"   
                                ACCUM TOTAL BY W016.wfDI wfgross     FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wffe        FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wftotgross  FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfced       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wf1st       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wf2nd       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wffacri     FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfqs5       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wftfp       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfmps       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfeng       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfmar       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfrq        FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfbtr       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfotr       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfftr       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wffo1       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wffo2       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wffo3       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wffo4       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfret       FORMAT "->>>,>>>,>>>,>>9.99" "|" 
                                ACCUM TOTAL BY W016.wfDI wfxol       FORMAT "->>>,>>>,>>>,>>9.99" "|" .
                                /*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
                                IF W016.wfDI = "D" THEN DO:
                                   PUT STREAM ns2
                                       ntd_osbh                      FORMAT "->>>,>>>,>>>,>>9.99" "|"         
                                       ntd_ttybh                     FORMAT "->>>,>>>,>>>,>>9.99" "|"         
                                       ntd_facbh                     FORMAT "->>>,>>>,>>>,>>9.99" "|"         
                                       ntd_othbh                     FORMAT "->>>,>>>,>>>,>>9.99" "|"  SKIP(2).
                                END.
                                ELSE DO:
                                    PUT STREAM ns2
                                       nti_osbh                      FORMAT "->>>,>>>,>>>,>>9.99" "|"         
                                       nti_ttybh                     FORMAT "->>>,>>>,>>>,>>9.99" "|"         
                                       nti_facbh                     FORMAT "->>>,>>>,>>>,>>9.99" "|"         
                                       nti_othbh                     FORMAT "->>>,>>>,>>>,>>9.99" "|"  SKIP(2).
                                END.
                                                                   
                                ASSIGN
                                ntd_osbh   = 0      nti_osbh   = 0 
                                ntd_ttybh  = 0      nti_ttybh  = 0 
                                ntd_facbh  = 0      nti_facbh  = 0 
                                ntd_othbh  = 0      nti_othbh  = 0.  
                               /* ------ End [A59-0613] ------ */    
                        END.
                    END.
                    LEAVE. 
                END.   /* LAST (Szr016.branch) */
                    /*PAGE STREAM ns1.*/
            END.  /*--- LAST-OF (Branch) ---*/
        END.   /*--- LAST-OF (poltyp) ---*/
    END.   /***--- LAST-OF (SUBSTRING (Szr016.claim,1,1)) ---***/
END.    /***--------------- LOOP_Szr016 ---------------------***/


PUT STREAM ns2
    "Total Complusory By Branch: " "|" 
    "|" 
    "|"
    "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
    "|" "|"   
    "Reserve" "|"
    "Paid"    "|"
    "OS "     "|" SKIP.
FOR EACH w_brncomp  NO-LOCK.
    PUT STREAM ns2
        w_brncomp.bran  "|"
        "|"
        "|"
        "|" "|" "|" "|" "|" "|" "|" "|" "|" "|"
        "|" "|"  
        w_brncomp.cres   FORMAT "->>>,>>>,>>>,>>9.99" "|" 
        w_brncomp.cpaid  FORMAT "->>>,>>>,>>>,>>9.99" "|" 
        (w_brncomp.cres - w_brncomp.cpaid)  FORMAT "->>>,>>>,>>>,>>9.99" "|" 
        SKIP.
END.

/*---  Benjaporn J. A59-0613 [14/12/2016] ---*/
OUTPUT STREAM ns2 TO VALUE (n_output2).  /* For Summary Text Output */
PUT STREAM ns2
    "TOTAL LIST OF OUTSTANDING CLAIM (NON-MOTOR)" SKIP
    "AS AT  " 
    STRING (TODAY,"99/99/9999") FORMAT "X(10)" " "
    STRING(TIME,"HH:MM:SS")    SKIP 
    "RUNNING OF ENTRY DATE FROM : " n_asdat   SKIP .

PUT STREAM ns2  
    "Type"            "|"
    "BRANCH"          "|"
    "LINE"            "|"
    "YEAR"            "|"
    "MONTH"           "|"
    "TRANDATE FROM"   "|"
    "TRANDATE TO"     "|"
    "ENTRYDATE"       "|"
    "GROSS"           "|"
    "SURVEY FEE"      "|" 
    "TOTAL GROSS"     "|"
    "CEDED"           "|"
    "1st.TREATY"      "|"
    "2nd.TREATY"      "|"   
    "FAC"             "|"
    "Q.S.5%"          "|"
    "TFP"             "|"
    "MPS"             "|"
    "ENG.FAC."        "|"
    "MARINE O/P"      "|"
    "R.Q."            "|"
    "BTR"             "|"
    "OTR"             "|"
    "FTR"             "|"
    "F/O I"           "|" 
    "F/O II"          "|"
    "F/O III"         "|"
    "F/O IV"          "|"
    "GROSS RET"       SKIP.

FOR EACH wfsum NO-LOCK
    BREAK BY wfsum.n_type 
          BY wfsum.n_bran 
          BY wfsum.n_line .

    FIND FIRST fnm002 USE-INDEX fnm00201 WHERE
        fnm002.TYPE   = wfsum.n_type     AND 
        fnm002.branch = wfsum.n_bran     AND
        fnm002.poltyp = wfsum.n_line     AND
        fnm002.osyr   = YEAR(nv_datto)   AND
        fnm002.osmth  = MONTH(nv_datto)  NO-ERROR.

    IF AVAIL fnm002 THEN DO :

        ASSIGN 
            fnm002.gross     =  0     
            fnm002.trtamt    =  0    
            fnm002.facamt    =  0    
            fnm002.amt1      =  0 . 

        ASSIGN  
           /* fnm002.TYPE      =  wfsum.n_type 
            fnm002.branch    =  wfsum.n_bran 
            fnm002.poltyp    =  STRING(wfsum.n_line) 
            fnm002.osmth     =  INT(MONTH(nv_datto))
            fnm002.osyr      =  INT(YEAR(nv_datto))
            fnm002.trndatfr  =  nv_datfr 
            fnm002.trndatto  =  nv_datto */
            fnm002.gross     =  wfsum.nt_gross 
            fnm002.trtamt    =  wfsum.n_treaty
            fnm002.facamt    =  wfsum.n_fac
            fnm002.amt1      =  wfsum.n_comp
            fnm002.entdat    =  TODAY .
                                       
    END.

    IF NOT AVAIL fnm002 THEN DO :

    CREATE  fnm002.
    ASSIGN  fnm002.TYPE      =  wfsum.n_type 
            fnm002.branch    =  wfsum.n_bran 
            fnm002.poltyp    =  wfsum.n_line  /*STRING(wfsum.n_line) */
            fnm002.osmth     =  INT(MONTH(nv_datto))
            fnm002.osyr      =  INT(YEAR(nv_datto))
            fnm002.trndatfr  =  nv_datfr 
            fnm002.trndatto  =  nv_datto 
            fnm002.gross     =  wfsum.nt_gross 
            fnm002.trtamt    =  wfsum.n_treaty
            fnm002.facamt    =  wfsum.n_fac
            fnm002.amt1      =  wfsum.n_comp
            fnm002.entdat    =  TODAY .
    END.

    PUT STREAM ns2
         wfsum.n_type                         "|" 
         wfsum.n_bran                         "|" 
         wfsum.n_line                         "|" 
         YEAR(nv_datto)   FORMAT "9999"       "|"
         MONTH(nv_datto)  FORMAT "99"         "|" 
         nv_datfr         FORMAT "99/99/9999" "|"
         nv_datto         FORMAT "99/99/9999" "|"
         TODAY            FORMAT "99/99/9999" "|"
         wfsum.n_gross                        "|"
         wfsum.n_fee                          "|"
         wfsum.nt_gross                       "|" 
         wfsum.n_ced                          "|"
         wfsum.n_1st                          "|"
         wfsum.n_2nd                          "|"
         wfsum.n_fac                          "|"
         wfsum.n_qs5                          "|"
         wfsum.n_tfp                          "|"
         wfsum.n_mps                          "|"
         wfsum.n_eng                          "|"
         wfsum.n_mar                          "|"
         wfsum.n_rq                           "|"
         wfsum.n_btr                          "|"
         wfsum.n_otr                          "|"
         wfsum.n_ftr                          "|"
         wfsum.n_fo1                          "|"
         wfsum.n_fo2                          "|"
         wfsum.n_fo3                          "|"
         wfsum.n_fo4                          "|"
         wfsum.n_ret                          SKIP.
        
END.                                     

OUTPUT STREAM ns2 CLOSE.
RELEASE fnm002.

/*
ASSIGN
   wfsum.n_gross    = 0               wfsum.n_mps  = 0
   wfsum.n_fee      = 0               wfsum.n_eng  = 0
   wfsum.nt_gross   = 0               wfsum.n_mar  = 0
   wfsum.n_fac      = 0               wfsum.n_rq   = 0
   wfsum.n_comp     = 0               wfsum.n_btr  = 0
   wfsum.n_ret      = 0               wfsum.n_otr  = 0
   wfsum.n_ced      = 0               wfsum.n_ftr  = 0
   wfsum.n_1st      = 0               wfsum.n_fo1  = 0
   wfsum.n_2nd      = 0               wfsum.n_fo2  = 0
   wfsum.n_qs5      = 0               wfsum.n_fo3  = 0
   wfsum.n_tfp      = 0               wfsum.n_fo4  = 0  .  */
      
 /*---End Benjaporn J. A59-0613 [14/12/2016] ---*/
