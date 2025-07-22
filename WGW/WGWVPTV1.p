/***********************************************************
Copyright  # Tokiomarin Insurance Public Company Limited 
Dup Program: WGWVPTV1.P
Create by  : Chaiying w. A65-0185 28/09/2022
           : Tranfer เข้า VAT เมื่อมีการออกใบกำกับภาษีแล้ว
Modify by  : Chaiyong W. A66-0048 21/03/2023 add vat code thai  
Modify BY	: Chaiyong W.  ASSIGN A66-0116  DATE 08/09/2023 	 
              Change stat.Vat100 to brstat.Vat100  
              Transfer brstat.vat100 to stat.vat104       
/*Modify by : Chaiyong W. A67-0068 16/05/2024            */
/*          : Add check driver ev                        */       
/*Modify By : Chaiyong W. F67-0001 08/10/2024            */
/*            Correct Speed Program                      */  

/*--------------------------------------------------------------------
Modify By : Nopparuj P. A67-0192 [14/02/2025]
            - check risk กับ item ปกติถ้า risk หรือ item มากกว่า 1 report จะไม่ออกข้อมูลรถ
            เปลี่ยนเป็น ถ้ามี risk หรือ item ที่มีการยกเลิก กรณีที่มี risk หรือ item เท่ากับ 2 ปกติจะไม่ออกข้อมูลรถ
            แต่ถ้ามีการยกเลิก risk หรือ item จะต้องออกข้อมูลรถ แม้จะมี 2 risk หรือ item ก็ตาม
/* Modify by:Chaiyong W. A68-0034 16/04/2025             */
/*           Add check name & Address                    */
--------------------------------------------------------------------*/                                   
***********************************************************/         
DEF INPUT   PARAMETER  nv_recid     AS RECID   INIT ?.
DEF OUTPUT  PARAMETER  nv_err       AS CHAR INIT "".
DEF VAR gv_id         AS CHAR INIT "".  /*user id*/
DEF VAR n_policy      AS CHAR INIT "" .   
DEF VAR n_trnty1      AS CHAR INIT "" .  
DEF VAR n_vatno       AS CHAR INIT "" . 
DEF VAR n_docno       AS CHAR INIT "" FORMAT "x(15)".     /*--*/
DEF VAR n_trnty2      AS CHAR INIT "" .
DEF VAR n_trndat      AS DATE    FORMAT "99/99/9999".            /*-*//*--*/
DEF VAR n_bprm        AS DEC     FORMAT ">,>>>,>>>,>>9.99".      /*-*/
DEF VAR n_disc        AS DEC     FORMAT ">>>,>>>,>>9.99".        /*-*/
DEF VAR n_prem        AS DEC     FORMAT ">,>>>,>>>,>>9.99".      /*-*/
DEF VAR n_vat         AS DEC     FORMAT ">>>,>>>,>>9.99".        /*-*/
DEF VAR n_tot         AS DEC     FORMAT ">>,>>>,>>>,>>9.99".     /*-*/
DEF VAR n_grd         AS DEC     FORMAT ">>,>>>,>>>,>>9.99".     /*-*/
DEF VAR n_stamp       AS DEC     FORMAT ">>>,>>9.99".            /*-*/
DEF VAR n_poltyp      AS CHAR    FORMAT "x(5)".
DEF VAR nv_amt        AS DEC     FORMAT ">>,>>>,>>>,>>9.99".     /**/
DEF VAR n_taxmont     AS INT     FORMAT "99".
DEF VAR n_taxyear     AS INT     FORMAT "9999".
DEF VAR n_taxrepm     AS LOGICAL.
DEF VAR n_name        AS CHAR FORMAT "x(70)".
DEF VAR n_name1       AS CHAR FORMAT "x(100)".    /**/
DEF VAR n_name2       AS CHAR FORMAT "x(70)".    
DEF VAR n_addr1       AS CHAR FORMAT "x(70)".    
DEF VAR n_addr2       AS CHAR FORMAT "x(70)".    
DEF VAR n_addr3       AS CHAR FORMAT "x(70)".    
DEF VAR n_addr4       AS CHAR FORMAT "x(70)".    
DEF VAR n_paddr       AS CHAR FORMAT "X(150)".   
DEF VAR n_paddr1      AS CHAR FORMAT "X(60)".        /**/
DEF VAR n_paddr2      AS CHAR FORMAT "X(60)".        /**/
DEF VAR n_paddr3      AS CHAR FORMAT "X(60)".        /**/
DEF VAR n_paddr4      AS CHAR FORMAT "X(60)".        /**/  /*Add*/
DEF VAR n_rem1        AS CHAR FORMAT "X(70)".        /**/
DEF VAR n_rem2        AS CHAR FORMAT "X(70)".        /**/                                                           
DEF VAR n_acno        AS CHAR FORMAT "X(10)".        /**/
DEF VAR n_agent       AS CHAR FORMAT "X(10)".        /**/                                                            
DEF VAR n_acnam       AS CHAR FORMAT "X(70)".        /**/
DEF VAR n_ratevat     AS DEC  FORMAT ">9.99".        
DEF VAR n_rencnt      AS INT.                        /*--*/
DEF VAR n_endcnt      AS INT.                        /*--*/   
DEF VAR n_printbr     AS CHAR   FORMAT "X(50)".      /*--*/
DEF VAR n_agname      AS CHAR INIT ""  FORMAT "x(70)".       /*--*/
DEF VAR nv_brnins     AS CHAR INIT ""  FORMAT "X(5)".            /*--*/
DEF VAR nv_taxno      AS CHAR INIT ""  FORMAT "X(15)".           /*--*/
DEF VAR nV_Dtaxno     AS CHAR INIT ""  FORMAT "x(30)".           /*--*/
DEF VAR nV_Dbrnin     AS CHAR INIT ""  FORMAT "x(30)".           /*--*/
DEF VAR n_userid      AS CHAR INIT ""  FORMAT "X(6)".  
DEF VAR n_add1        AS CHAR INIT "" .                  /* */
DEF VAR n_add2        AS CHAR INIT "" .                  /* */
DEF VAR nv_langug     AS CHAR INIT "".
DEF VAR nv_insref     AS CHAR INIT "".
DEF VAR n_displa      AS CHAR INIT "".
DEF VAR n_branch      AS CHAR INIT "".
DEF VAR n_pvrvjv      AS CHAR INIT "".
DEF VAR n_app2        AS CHAR INIT "".
DEF VAR n_insref      AS CHAR INIT "".
DEF VAR nv_xmm600     AS CHAR INIT "".
DEF BUFFER buwm301 FOR sic_bran.uwm301.
/*---new s*/
DEF VAR  nv_agdes AS CHAR INIT "".
DEF VAR nv_dcode  AS CHAR INIT "".
DEF VAR nv_dprint AS DATE INIT TODAY.
DEF VAR nv_dday   AS INT  INIT 0.
DEF VAR nv_time   AS CHAR INIT "".
/*-- Add A63-0264 --*/
DEF VAR nv_code1 AS CHAR INIT "".
DEF VAR nv_chkprg AS CHAR INIT "".
/*-- End Add A63-0264 --*/
DEF VAR nv_vtype AS CHAR INIT "".

DEF VAR nv_seat  AS CHAR INIT "".
DEF VAR nv_sit   AS CHAR INIT "".
DEF VAR nv_tons  AS CHAR INIT "".
DEF VAR nv_kw    AS CHAR INIT "".
DEF VAR nv_classE   AS INT .
DEF VAR nv_garage   AS CHAR INIT "".
DEF VAR nv_licen    AS CHAR INIT "".
/*---A63-0377 ---*/
DEF VAR n_title         AS CHAR INIT "".
DEF VAR n_postcd        AS CHAR INIT "".
DEF VAR n_recno         AS CHAR INIT "".
DEF VAR n_comdat        AS DATE INIT ?.
DEF VAR n_expdat        AS DATE INIT ?.
DEF VAR n_accdat        AS DATE INIT ?.
DEF VAR nv_class        AS CHAR INIT "".
DEF VAR n_code          AS CHAR INIT "".
DEF VAR n_occupn        AS CHAR INIT "".
DEF VAR n_vehtyp        AS CHAR INIT "".
DEF VAR n_veh2          AS CHAR INIT "".
DEF VAR nv_make         AS CHAR INIT "".
DEF VAR nv_make2        AS CHAR INIT "".
DEF VAR n_License       AS CHAR INIT "".
DEF VAR n_chassis       AS CHAR INIT "".
DEF VAR n_chassis1      AS CHAR INIT "".
DEF VAR n_chassis2      AS CHAR INIT "".
DEF VAR n_engine1       AS CHAR INIT "".
DEF VAR n_seatv         AS CHAR INIT "".
DEF VAR n_gvw           AS CHAR INIT "".
DEF VAR n_uom6_v        AS INT  INIT 0.
DEF VAR nv_prm1         AS CHAR INIT "".
DEF VAR nv_stdri        AS CHAR INIT "".
DEF VAR nv_name1        AS CHAR INIT "".
DEF VAR nv_name2        AS CHAR INIT "".
DEF VAR nv_birdat1      AS CHAR INIT "".
DEF VAR nv_birdat2      AS CHAR INIT "".
DEF VAR nv_occup1       AS CHAR INIT "".
DEF VAR nv_occup2       AS CHAR INIT "".
DEF VAR nv_icno1        AS CHAR INIT "".  
DEF VAR nv_icno2        AS CHAR INIT "". 
DEF VAR n_type          AS CHAR INIT "". 
DEF VAR nv_coms         AS CHAR INIT "".
DEF VAR nv_chastxt      AS CHAR INIT "".

/*--- Add By Nopparuj P. A67-0192 [01/04/2025] ---*/
DEF VAR nv_riskno130    AS INT INIT 0.
DEF VAR nv_itemno130    AS INT INIT 0.
DEF VAR nv_multi        AS LOG INIT NO.
DEF BUFFER buwm120 FOR sic_bran.uwm120.
DEF BUFFER buwm130 FOR sic_bran.uwm130.
/*--- End By Nopparuj P. A67-0192 [01/04/2025] ---*/
/*---A63-0377---*/
DEFINE VAR nv_vehreg AS CHAR.                               /*Add Kridtiya i. A64-0199 Date. 16/10/2021*/ 
DEF VAR nv_bs_Cd  AS CHAR INIT "". /*--Add Jiraphon P. A65-0123  26/04/2022*/ 
DEF VAR nv_invbrn AS CHAR INIT "". /*--Add by Chaiyong W. A65-0185 21/07/2022*/ 
/*--Begin by Chaiyong W. A68-0034 16/04/2025*/
DEF VAR nv_putcode AS CHAR INIT "".
def var nv_codeocc as char init "".
def var nv_occup   as char init "".
def var nv_ooth1   as char init "".
def var nv_ooth2   as char init "".
def var nv_ooth3   as char init "".
def var nv_ooth4   as char init "".
/*End by Chaiyong W. A68-0034 16/04/2025*/


//FIND FIRST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_recid NO-LOCK NO-ERROR. Comment by Chaiyong W. F67-0001 08/10/2024
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_recid NO-LOCK NO-ERROR. /*--Add by Chaiyong W. F67-0001 08/10/2024*/

IF AVAIL sic_bran.uwm100 THEN DO:
    /*
    IF sic_bran.uwm100.instot = 1 THEN DO: Comment by Jiraphon P. A65-0123  26/04/2022*/
    /*--Begin by Jiraphon P. A65-0123  26/04/2022*/
    IF sic_bran.uwm100.instot = 1 OR 
        (sic_bran.uwm100.instot > 1 AND sic_bran.uwm100.endcnt = 0  
          /* AND substr(sic_bran.uwm100.poltyp,1,2) = "V7"comment by Chaiyong W. A65-0150 09/06/2022*/ 
          ) THEN DO:
    /*end by Jiraphon P. A65-0123  26/04/2022----*/

        ASSIGN
             /*--Begin by Jiraphon P. A65-0123  26/04/2022*/
            nv_insref  = sic_bran.uwm100.insref   /*AZRVT701*/
            nv_bs_Cd   = sic_bran.uwm100.bs_Cd   
            /*end by Jiraphon P. A65-0123  26/04/2022----*/
            gv_id      = USERID(LDBNAME(1))
            n_policy   = sic_bran.uwm100.policy
            n_trnty1   = sic_bran.uwm100.trty11
            n_docno    = sic_bran.uwm100.docno1
            n_vatno    = sic_bran.uwm100.docno1
            n_trnty2   = ""
            n_trndat   = TODAY
            n_poltyp   = sic_bran.uwm100.poltyp
            n_branch   = sic_bran.uwm100.branch
            
            n_taxmont  = MONTH(TODAY)
            n_taxyear  = YEAR(TODAY) 

            n_taxrepm  = NO
            /*--
            n_name     = TRIM(TRIM(sic_bran.uwm100.ntitle) + " " + TRIM(sic_bran.uwm100.name1)) 
            n_paddr1   = TRIM(sic_bran.uwm100.addr1)
            n_paddr2   = TRIM(sic_bran.uwm100.addr2)
            n_paddr3   = TRIM(TRIM(sic_bran.uwm100.addr3) + " " + TRIM(sic_bran.uwm100.addr4) + " " +
                         TRIM(sic_bran.uwm100.postcd))
            -*/
            n_title    = TRIM(sic_bran.uwm100.ntitle)
            n_name     = TRIM(sic_bran.uwm100.name1) 
            nv_langug  = sic_bran.uwm100.langug
            nv_insref  = sic_bran.uwm100.insref
            n_rencnt   = sic_bran.uwm100.rencnt
            n_endcnt   = sic_bran.uwm100.endcnt
            n_agent    = sic_bran.uwm100.agent
            n_insref   = sic_bran.uwm100.insref
            nv_langug  = sic_bran.uwm100.langug
            nv_insref  = sic_bran.uwm100.insref
            n_agent    = sic_bran.uwm100.agent
            /*-A63-0377-*/
            n_comdat   = sic_bran.uwm100.comdat
            n_expdat   = sic_bran.uwm100.expdat
            n_Accdat   = sic_bran.uwm100.accdat.
            /*-A63-0377-*/

        nv_vtype  = trim(SUBSTR(uwm100.code1,40,5)) NO-ERROR. 
        IF nv_vtype = "" THEN DO:
            IF  sic_bran.uwm100.trty13 = "S"  THEN nv_vtype = TRIM(sic_bran.uwm100.trty13).  /*S or N*/
            ELSE DO:
                IF SUBSTRING(sic_bran.uwm100.poltyp,1,2) = "V7" AND sic_bran.uwm100.poltyp <> "V70"  THEN nv_vtype = "T".
                ELSE nv_vtype = "S". 
                     /*
                IF uwm100.trty11 <> "M" AND uwm100.trty11 <> "O" THEN nv_vtype = "C". /*Trtype <> Debit*/*/
            END.
        END.
          
       
       
  
        //FIND FIRST sicsyac.sym100 Comment by Chaiyong W. F67-0001 08/10/2024
        FIND  sicsyac.sym100  USE-INDEX sym10001  /*--Add by Chaiyong W. F67-0001 08/10/2024*/
            WHERE sicsyac.sym100.tabcod = "U083" AND 
                  sicsyac.sym100.itmcod = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR.   
        IF AVAIL sym100 THEN nv_invbrn = TRIM(sicsyac.sym100.itmdes). 
        ELSE DO: 
            //FIND FIRST sicsyac.sym100 Comment by Chaiyong W. F67-0001 08/10/2024
            FIND  sicsyac.sym100  USE-INDEX sym10001  /*--Add by Chaiyong W. F67-0001 08/10/2024*/
                WHERE sicsyac.sym100.tabcod = "U083" AND 
                      sicsyac.sym100.itmcod = "ALL"  NO-LOCK NO-ERROR.   
            IF AVAIL sym100 THEN nv_invbrn = TRIM(sicsyac.sym100.itmdes). 
            ELSE DO:
                nv_invbrn = IF sic_bran.uwm100.branch <> "" THEN sic_bran.uwm100.branch ELSE "0". /* อิงตาม Policy Branch */
            END.
        END.
        nv_invbrn = TRIM(nv_invbrn).
        
        
            

        
            
        ASSIGN
            nv_code1   = sic_bran.uwm100.prog
            n_taxyear  = 0
            n_taxmont  = 0.
        nv_dcode  = trim(SUBSTR(uwm100.code1,11,10)) NO-ERROR.
        IF nv_dcode = "" THEN nv_dcode  = string(sic_bran.uwm100.trndat,"99/99/9999") NO-ERROR.
        n_trndat   = DATE(nv_dcode) NO-ERROR.
        IF n_trndat = ? THEN n_trndat = TODAY.
        IF sic_bran.uwm100.expdat < sic_bran.uwm100.comdat THEN nv_err = "Policy " + sic_bran.uwm100.policy + " Expiry Date < Com Date " . /*Add Kridtiya i. A64-0199 Date. 16/10/2021*/


        ASSIGN
            n_taxmont   = MONTH(n_trndat) 
            n_taxyear   = YEAR(n_trndat) .
        nv_time    = trim(SUBSTR(uwm100.code1,21,10)) no-error.
        IF nv_time = "" THEN nv_time    = sic_bran.uwm100.enttim.
        
        /*gv_id      = trim(SUBSTR(uwm100.code1,31,10)) no-error.*/
        IF nv_time = "" THEN nv_time = STRING(TIME,"HH:MM:SS").
        IF gv_id   = "" THEN gv_id   = USERID(LDBNAME(1)).
        nv_dcode   = sic_bran.uwm100.prog.
        
        IF nv_vtype = "" THEN nv_vtype = "S".
        nv_dcode   = nv_code1 .
        IF nv_vtype = "S"  AND SUBSTRING(sic_bran.uwm100.poltyp,1,2) <> "V7" THEN DO:  /* Non-Motor*/
             RUN WGW\WGWVPTV2(INPUT nv_recid,OUTPUT nv_err).
             IF nv_err <> "" THEN RETURN.
        END. 
        ELSE IF nv_vtype = "C"  THEN DO:   /*vat type C*/
             RUN WGW\WGWVPTV3(INPUT nv_recid,OUTPUT nv_err).
             IF nv_err <> "" THEN RETURN.
        END. 
        ELSE IF SUBSTRING(sic_bran.uwm100.poltyp,1,2) = "V7"  THEN DO: 
            IF sic_bran.uwm100.instot = 1 THEN DO: /*--Add Jiraphon P. A65-0123  26/04/2022*/ 
                /*---
                IF SUBSTRING(sic_bran.uwm100.insref,1,4) <> "COMP"    AND
                             sic_bran.uwm100.insref      <> "WMC0001" THEN DO:
                    IF sic_bran.uwm100.bs_cd <> "" THEN DO:
                        nv_xmm600 = sic_bran.uwm100.bs_cd.
                        RUN pd_xmm600.
                    END.
                    ELSE DO:
                        nv_xmm600 = nv_insref.
                        RUN pd_xmm600.
                    END.
                END.
                ELSE DO:
                    IF nv_insref     = "COMP"    OR
                       sic_bran.uwm100.insref = "WMC0001" THEN DO:
                        
                        ASSIGN
                            n_title  = TRIM(sic_bran.uwm100.ntitle)
                            n_name   = TRIM(sic_bran.uwm100.name1) 
                            n_name2  = TRIM(sic_bran.uwm100.name2) + " " + TRIM(sic_bran.uwm100.name3)
                            n_paddr1 = TRIM(sic_bran.uwm100.addr1)
                            n_paddr2 = TRIM(sic_bran.uwm100.addr2)
                            n_paddr3 = TRIM(sic_bran.uwm100.addr3)
                            n_paddr4 = TRIM(sic_bran.uwm100.addr4)
                            n_postcd = TRIM(sic_bran.uwm100.postcd).
    
    
                    END.
                    IF sic_bran.uwm100.bs_cd <> "WMC0001" AND
                       sic_bran.uwm100.bs_cd <> "COMP"    AND
                       sic_bran.uwm100.bs_cd <> ""        THEN DO: 
                         nv_xmm600 = sic_bran.uwm100.bs_cd.
                         RUN pd_xmm600.
                    END.
                    
                END. 
                comemnt by Chaiyong W. A68-0034 16/04/2025*/
                RUN pd_newaddr. /*--add by Chaiyong W. A68-0034 16/04/2025*/
            END. /*--Add Jiraphon P. A65-0123  26/04/2022*/ 
            
            IF  (n_poltyp  = "V70"   OR  n_poltyp  = "V72"  OR
                 n_poltyp  = "V73"   OR  n_poltyp  = "V74") THEN DO:
              FOR EACH sic_Bran.uwd132  USE-INDEX uwd13201  WHERE
                       uwd132.policy  =  sic_bran.uwm100.policy AND
                       uwd132.rencnt  =  sic_bran.uwm100.rencnt AND
                       uwd132.endcnt  =  sic_bran.uwm100.endcnt AND 
                       uwd132.bchyr   =  sic_bran.uwm100.bchyr  AND 
                       uwd132.bchno   =  sic_Bran.uwm100.bchno  and
                       uwd132.bchcnt  =  sic_Bran.uwm100.bchcnt NO-LOCK:
                   IF uwd132.prem_c < 0 THEN n_disc  = n_disc + uwd132.prem_c.
              END.   /* end for each uwd132 */
            END.  /*if poltyp */
            
            ASSIGN
                n_bprm     = (sic_bran.uwm100.prem_t + sic_bran.uwm100.pstp   + sic_bran.uwm100.rstp_t)  - n_disc
                n_prem     = sic_bran.uwm100.prem_t 
                n_vat      = sic_bran.uwm100.ptax   + sic_bran.uwm100.rtax_t 
                n_tot      = sic_bran.uwm100.prem_t + sic_bran.uwm100.pstp   + sic_bran.uwm100.rstp_t 
                n_grd      = n_tot + n_vat
                n_stamp    = sic_bran.uwm100.pstp   + sic_bran.uwm100.rstp_t 
                nv_amt     = n_grd.
            
            
            
            //FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE Comment by Chaiyong W. F67-0001 08/10/2024
            FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE  /*--Add by Chaiyong W. F67-0001 08/10/2024*/
               xmm600.acno    = n_agent                  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xmm600 THEN DO:
                n_agname = xmm600.abname.
            END.
            
            ASSIGN
                n_rem1 = ""
                n_rem2 = ""
                n_acno = sic_bran.uwm100.acno1.
            
            //FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE Comment by Chaiyong W. F67-0001 08/10/2024
            FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE  /*--Add by Chaiyong W. F67-0001 08/10/2024*/     
                xmm600.acno  = n_acno  NO-LOCK NO-ERROR.
            IF AVAIL xmm600  THEN DO:
                n_acnam  = xmm600.name.
            END.
            IF n_ratevat = 0 THEN n_ratevat  = sic_bran.uwm100.gstrat. /*อัตราภาษี*/
            n_printbr = TRIM(SUBSTR(gv_id,6,2)).
            IF nv_invbrn <> "" THEN n_printbr = nv_invbrn. /*---add by Chaiyong W. A65-0185 22/07/2022*/
            /*-- Add A63-0035 ---*/
            RUN wuw\wuwpbrns1 (INPUT  TODAY         ,  /*Branch User*/
                             INPUT  n_printbr     ,
                             INPUT  sic_bran.uwm100.langug , 
                             OUTPUT n_printbr     ,
                             OUTPUT n_addr1       , 
                             OUTPUT n_addr2       , 
                             OUTPUT n_addr3       , 
                             OUTPUT n_addr4       ).
            /*--- End Add A63-0035 ----*/
    
            RUN pd_veh .    /*Car Detail*/

            n_name1 =  n_name.
            
            IF n_acno = "A0l0038"  OR
               n_acno = "a000795"  THEN DO:
               n_acnam = "".
            END.

            IF DATE(nv_birdat1) = ? THEN nv_birdat1 = "".
            IF DATE(nv_birdat2) = ? THEN nv_birdat2 = "".
            
            IF sic_bran.uwm100.instot = 1 THEN DO: 
                RUN pd_Vat. 
            END. 
            ELSE IF sic_bran.uwm100.endcnt = 0 THEN DO:
                FOR EACH sic_bran.uwm101 USE-INDEX uwm10101  /*--Add by Chaiyong W. F67-0001 08/10/2024*/
                   WHERE sic_bran.uwm101.policy   = sic_bran.uwm100.policy and
                         sic_bran.uwm101.rencnt   = sic_bran.uwm100.rencnt and
                         sic_bran.uwm101.endcnt   = sic_bran.uwm100.endcnt AND
                         sic_bran.uwm101.bchyr   =  sic_bran.uwm100.bchyr  AND 
                         sic_bran.uwm101.bchno   =  sic_Bran.uwm100.bchno  and
                         sic_bran.uwm101.bchcnt  =  sic_Bran.uwm100.bchcnt  AND
                    /*--
                         sic_bran.uwm101.flgprn   = "Y" 
                    comment by Chaiyong W. A68-0034 15/05/2025*/
                    /*---Begin by Chaiyong W. A68-0034 15/05/2025*/
                    ((sic_bran.uwm101.flgprn   <> ""  AND sic_bran.uwm100.ltstatus <> "Y" ) OR
                    (sic_bran.uwm101.flgprn  = "Y"  AND sic_bran.uwm100.ltstatus = "Y" ))
                    /*End by Chaiyong W. A68-0034 15/05/2025-----*/

                    
                    
                    
                    NO-LOCK  BY sic_bran.uwm101.instno:

                    /*---
                    nv_bs_cd  = "".
                    IF sic_bran.uwm101.desc_i <> "" THEN  
                        nv_bs_cd = TRIM(SUBSTRING(sic_bran.uwm101.desc_i, 1, INDEX(sic_bran.uwm101.desc_i, " ") - 1)) NO-ERROR .
                    ELSE nv_bs_cd = sic_bran.uwm100.bs_cd.
                    IF SUBSTRING(sic_bran.uwm100.insref,1,4) <> "COMP"    AND
                                 sic_bran.uwm100.insref      <> "WMC0001" THEN DO:
                        IF  nv_bs_cd <> "" THEN DO:
                            nv_xmm600 = nv_bs_cd.
                            RUN pd_xmm600.
                        END.
                        ELSE DO:
                            nv_xmm600 = nv_insref.
                            RUN pd_xmm600.
                        END.
                    END.
                    ELSE DO:
                        IF nv_insref     = "COMP"    OR
                           sic_bran.uwm100.insref = "WMC0001" THEN DO:
                            
                            ASSIGN
                                n_title  = TRIM(sic_bran.uwm100.ntitle)
                                n_name   = TRIM(sic_bran.uwm100.name1) 
                                n_name2  = TRIM(sic_bran.uwm100.name2) + " " + TRIM(sic_bran.uwm100.name3)
                                n_paddr1 = TRIM(sic_bran.uwm100.addr1)
                                n_paddr2 = TRIM(sic_bran.uwm100.addr2)
                                n_paddr3 = TRIM(sic_bran.uwm100.addr3)
                                n_paddr4 = TRIM(sic_bran.uwm100.addr4)
                                n_postcd = TRIM(sic_bran.uwm100.postcd).
        
        
                        END.
                        IF sic_bran.uwm100.bs_cd <> "WMC0001" AND
                           sic_bran.uwm100.bs_cd <> "COMP"    AND
                           sic_bran.uwm100.bs_cd <> ""        THEN DO: 
                             nv_xmm600 = nv_bs_cd.
                             RUN pd_xmm600.
                        END.
                        
                    END. 
                    comemnt by Chaiyong W. A68-0034 16/04/2025*/
                    RUN pd_newaddr. /*--add by Chaiyong W. A68-0034 16/04/2025*/

                    ASSIGN
                        n_docno    = sic_bran.uwm101.docnoi
                        n_bprm     = (sic_bran.uwm101.prem_i + sic_bran.uwm101.pstp_i   + sic_bran.uwm101.rstp_i )  - n_disc
                        n_prem     = sic_bran.uwm101.prem_i 
                        n_vat      = sic_bran.uwm101.ptax_i   + sic_bran.uwm101.rtax_i 
                        n_tot      = sic_bran.uwm101.prem_i + sic_bran.uwm101.pstp_i   + sic_bran.uwm101.rstp_i 
                        n_grd      = n_tot + n_vat
                        n_stamp    = sic_bran.uwm101.pstp_i   + sic_bran.uwm101.rstp_i 
                        nv_amt     = n_grd.
                    nv_insref  = sic_bran.uwm100.insref.   /*AZRVTIN1*/
                    IF nv_bs_Cd <> ""  THEN nv_insref  = nv_bs_Cd. /*AZRVTIN1*/
                    RUN pd_vat.
                END. 
            END.   /*End by  Jiraphon P. A65-0123  26/04/2022---*/
        END.  /*-- A63-0035 vat type S Motor --*/
     END.



END.



PROCEDURE pd_xmm600:
    FIND FIRST sic_bran.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno  = nv_xmm600 NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL xmm600 THEN DO:
        IF (xmm600.naddr1 = "" AND xmm600.naddr2 = "" AND
            xmm600.naddr3 = "" AND xmm600.naddr4 = "") AND nv_bs_cd = "" AND nv_xmm600 = sic_bran.uwm100.insref THEN DO :
            IF sic_bran.uwm100.firstname <> ""  THEN DO:
                ASSIGN 
                    n_title     =   TRIM(sic_bran.uwm100.ntitle)
                    n_name      =   TRIM(sic_bran.uwm100.firstname)
                    n_name2     =   TRIM(sic_bran.uwm100.lastname)    .
            END.
            ELSE DO:
                n_title     =   TRIM(sic_bran.uwm100.ntitle).
                n_name      =   TRIM(sic_bran.uwm100.name1).
                n_name2     =   "".
            END.

            n_paddr1    =   TRIM(uwm100.addr1).
            n_paddr2    =   TRIM(uwm100.addr2).
            n_paddr3    =   TRIM(uwm100.addr3).
            n_paddr4    =   TRIM(uwm100.addr4).
            n_postcd    =   TRIM(uwm100.postcd).

            
            /*--- A63-0377 ---*/
            nv_brnins = xmm600.anlyc5 .
            nv_taxno  = xmm600.icno.  
            /*
            ASSIGN
            nv_brins  = uwm100.br_insured 
            nv_taxno  = uwm100.icno .*/

        END.
        ELSE IF (xmm600.naddr1 = "" AND xmm600.naddr2 = "" AND xmm600.naddr3 = "" AND xmm600.naddr4 = "") 
            OR nv_xmm600     = nv_bs_cd   THEN DO :
            
            IF xmm600.firstname <> "" OR xmm600.lastname <> ""  THEN DO:
                ASSIGN 
                n_title     =   TRIM(xmm600.ntitle)
                n_name      =   TRIM(xmm600.firstname)
                n_name2     =   TRIM(xmm600.lastname)    .
            END.
            ELSE DO:
                n_title     =   TRIM(xmm600.ntitle).
                n_name      =   TRIM(xmm600.name).
                n_name2     =   "".
            END.
            n_paddr1    =   TRIM(xmm600.addr1).
            n_paddr2    =   TRIM(xmm600.addr2).
            n_paddr3    =   TRIM(xmm600.addr3).
            n_paddr4    =   TRIM(xmm600.addr4).
            n_postcd    =   TRIM(xmm600.postcd).
            /*--- A63-0377 ---*/
            nv_brnins = xmm600.anlyc5 .
            nv_taxno  = xmm600.icno. 
            /*----Special Vat Code*/  /*---Begin by Chaiyong W. A66-0048 21/03/2023*/
            IF  nv_xmm600     = nv_bs_cd AND sic_bran.uwm100.langug  = "T"   THEN DO:
                //FIND sic_bran.xtm600 WHERE sic_bran.xtm600.acno = nv_bs_cd NO-LOCK NO-ERROR. Comment by Chaiyong W. F67-0001 08/10/2024
                FIND FIRST sic_bran.xtm600 USE-INDEX xtm60001 WHERE sic_bran.xtm600.acno = nv_bs_cd NO-LOCK NO-ERROR. /*--Add by Chaiyong W. F67-0001 08/10/2024*/
                IF AVAIL sic_bran.xtm600 THEN DO:
                    IF sic_bran.xtm600.firstname <> "" OR xtm600.lastname <> ""  THEN DO:
                        ASSIGN 
                        n_title     =   TRIM(xtm600.ntitle)
                        n_name      =   TRIM(xtm600.firstname)
                        n_name2     =   TRIM(xtm600.lastname)    .
                    END.
                    ELSE DO:
                        n_title     =   TRIM(xtm600.ntitle).
                        n_name      =   TRIM(xtm600.name).
                        n_name2     =   "".
                    END.
                    ASSIGN
                        n_paddr1    =   TRIM(xtm600.addr1)
                        n_paddr2    =   TRIM(xtm600.addr2)
                        n_paddr3    =   TRIM(xtm600.addr3)
                        n_paddr4    =   TRIM(xtm600.addr4)
                        n_postcd    =   TRIM(xtm600.postcd).

                END.
            END.
            /*End Special Vat Code*/ /*End by Chaiyong W. A66-0048 21/03/2023----*/



        END.
        ELSE DO:
            IF xmm600.nphone = "" THEN DO:
               
                IF sic_bran.uwm100.insref <> nv_xmm600 THEN DO:
                    IF xmm600.firstname <> "" OR xmm600.lastname <> ""  THEN DO:
                         ASSIGN 
                         n_title     =   TRIM(xmm600.ntitle)
                         n_name      =   TRIM(xmm600.firstname)
                         n_name2     =   TRIM(xmm600.lastname)    .
                     END.
                     ELSE DO:
                         n_title     =   TRIM(xmm600.ntitle).
                         n_name      =   TRIM(xmm600.name).
                         n_name2     =   "".
                     END.
                             
                    
                END.
                ELSE DO:
                    IF sic_bran.uwm100.firstname <> ""  THEN DO:
                        ASSIGN 
                            n_title     =   TRIM(sic_bran.uwm100.ntitle)
                            n_name      =   TRIM(sic_bran.uwm100.firstname)
                            n_name2     =   TRIM(sic_bran.uwm100.lastname)    .
                    END.
                    ELSE DO:
                        n_title     =   TRIM(sic_bran.uwm100.ntitle).
                        n_name      =   TRIM(sic_bran.uwm100.name1).
                        n_name2     =   "".
                    END.

                END.

            END.
            ELSE DO:    
                        IF xmm600.nfirstname <> ""  THEN  DO:
                            ASSIGN
                                n_title     =   xmm600.nntitle
                                n_name      =   xmm600.nfirstname
                                n_name2     =   xmm600.nlastname .
                        END.
                        ELSE DO:
                            n_title     =       "".
                            n_name      =       SUBSTRING(xmm600.nphone,1,60).
                            n_name2     =       SUBSTRING(xmm600.nphone,61,60).
                        END.
                        
            END.

            ASSIGN
                n_paddr1    =   TRIM(xmm600.naddr1)
                n_paddr2    =   TRIM(xmm600.naddr2)
                n_paddr3    =   TRIM(xmm600.naddr3)
                n_paddr4    =   TRIM(xmm600.naddr4)
                n_postcd    =   TRIM(xmm600.npostcd)
                nv_brnins = TRIM(SUBSTRING(xmm600.anlyc1,20,5))
                nv_taxno  = TRIM(SUBSTRING(xmm600.anlyc1,1,14)) NO-ERROR . 
        END.
    END.
    ELSE DO: /*Special*/

        IF sic_bran.uwm100.firstname <> ""  THEN DO:
            ASSIGN 
                n_title     =   TRIM(sic_bran.uwm100.ntitle)
                n_name      =   TRIM(sic_bran.uwm100.firstname)
                n_name2     =   TRIM(sic_bran.uwm100.lastname)    .
        END.
        ELSE DO:
            n_title     =   TRIM(sic_bran.uwm100.ntitle).
            n_name      =   TRIM(sic_bran.uwm100.name1).
            n_name2     =   "".
        END.
        ASSIGN

        n_paddr1    =   TRIM(uwm100.addr1)
        n_paddr2    =   TRIM(uwm100.addr2)
        n_paddr3    =   TRIM(uwm100.addr3)
        n_paddr4    =   TRIM(uwm100.addr4)
        n_postcd    =   TRIM(uwm100.postcd)
        nv_brnins   =    sic_bran.uwm100.br_insured  
        nv_taxno    =    sic_bran.uwm100.icno.  

    END.
END PROCEDURE.


PROCEDURE pd_veh:
    DEF VAR nv_chkpol AS CHAR INIT "".
    /*--- Add By Nopparuj P. A67-0192 [01/04/2025] ---*/
    ASSIGN
        nv_riskno130 = 0
        nv_itemno130 = 0
        nv_multi     = NO.

    nv_multi = NO.
    FIND FIRST sic_bran.uwm130 USE-INDEX uwm13001     WHERE
               sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
               sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
               sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
               sic_bran.uwm130.itmdel = NO            NO-LOCK NO-ERROR.
    IF AVAIL uwm130 THEN DO:
        FIND LAST buwm130 USE-INDEX uwm13001     WHERE
                  buwm130.policy = sic_bran.uwm100.policy AND
                  buwm130.rencnt = sic_bran.uwm100.rencnt AND
                  buwm130.endcnt = sic_bran.uwm100.endcnt AND
                  buwm130.itmdel = NO            NO-LOCK NO-ERROR.
        IF AVAIL buwm130 THEN DO:
            IF buwm130.riskno <> sic_bran.uwm130.riskno OR
               buwm130.itemno <> sic_bran.uwm130.itemno THEN DO:
                nv_multi = YES.
            END.
            ELSE DO:
                ASSIGN
                    nv_riskno130 = sic_bran.uwm130.riskno
                    nv_itemno130 = sic_bran.uwm130.itemno
                    .
            END.
        END.
    END.

    IF nv_multi = NO AND nv_riskno130 <> 0 AND nv_itemno130 <> 0 THEN DO:
        RUN pd_uwm301.
    END.
    ELSE IF nv_multi = YES THEN DO:
    END.
    ELSE DO:
        FIND LAST sic_bran.uwm301 USE-INDEX uwm30101      WHERE
                  sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
                  sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
                  sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  NO-LOCK NO-ERROR.
        IF AVAIL uwm301 THEN DO:
            FIND FIRST buwm130 USE-INDEX uwm13001        WHERE
                       buwm130.policy = sic_bran.uwm100.policy    AND
                       buwm130.rencnt = sic_bran.uwm100.rencnt    AND
                       buwm130.endcnt = sic_bran.uwm100.endcnt    NO-LOCK NO-ERROR.
            IF AVAIL uwm130 THEN DO:
                IF uwm301.riskno <> buwm130.riskno OR
                   uwm301.itemno <> buwm130.itemno THEN DO:
                    nv_multi = YES.
                END.
                ELSE DO:
                    RUN pd_uwm301.
                END.
            END.
        END.
    END.
    /*--- End By Nopparuj P. A67-0192 [01/04/2025] ---*/
    
    IF nv_multi = YES THEN DO:  
        IF sic_bran.uwm100.langug = "T" THEN
            ASSIGN
                nv_chastxt = " ตามกรมธรรม์ประกันภัย/สลักหลังซึ่งบริษัทฯได้ออกให้ไว้เป็นหลักฐาน " 
                nv_chastxt = FILL("-",4) + nv_chastxt + FILL("-",4).
        ELSE
            ASSIGN
                nv_chastxt = " As per original policy/endorsement which is attached as an evidence " 
                nv_chastxt = FILL("-",2) + nv_chastxt + FILL("-",2).
    END.

END PROCEDURE.

/*--- Add By Nopparuj P. A67-0192 [01/04/2025] ---*/
PROCEDURE pd_uwm301:
    DEF VAR nv_varamt AS DECI INIT 0.
    DEF VAR nv_chkpol AS CHAR INIT "".
    DEF VAR nv_int    AS INT  INIT 0.


    FIND FIRST sic_bran.uwm120   USE-INDEX uwm12001 WHERE 
               sic_bran.uwm120.policy  = sic_bran.uwm100.policy     AND
               sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt     AND
               sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt     AND 
               sic_bran.uwm120.bchyr   = sic_bran.uwm100.bchyr      AND 
               sic_bran.uwm120.bchno   = sic_Bran.uwm100.bchno      AND
               sic_bran.uwm120.bchcnt  = sic_Bran.uwm100.bchcnt     NO-LOCK NO-ERROR.
    IF AVAIL sic_bran.uwm120 THEN DO:
        /*FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101   WHERE         A67-0192 */
        FIND LAST sic_bran.uwm301 USE-INDEX uwm30101   WHERE 
           sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
           sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
           sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND 
           sic_bran.uwm301.bchyr  = sic_bran.uwm100.bchyr   AND 
           sic_bran.uwm301.bchno  = sic_Bran.uwm100.bchno   AND
           sic_bran.uwm301.bchcnt = sic_Bran.uwm100.bchcnt  NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm301 THEN DO:
            /*FIND LAST buwm301 USE-INDEX uwm30101   WHERE 
                      buwm301.policy = sic_bran.uwm100.policy   AND
                      buwm301.rencnt = sic_bran.uwm100.rencnt   AND
                      buwm301.endcnt = 0    AND 
                      buwm301.bchyr   =  sic_bran.uwm100.bchyr  AND 
                      buwm301.bchno   =  sic_Bran.uwm100.bchno  and
                      buwm301.bchcnt  =  sic_Bran.uwm100.bchcnt NO-LOCK NO-ERROR.
            IF AVAIL buwm301 THEN DO:
                IF buwm301.riskno <> sic_bran.uwm301.riskno OR
                   buwm301.itemno <> sic_bran.uwm301.itemno THEN nv_multi  = YES.
            END.*/      /*--- Comment By A67-0192 [21/01/2025] ---*/
        
            IF sic_bran.uwm100.com1_t <> 0 AND sic_bran.uwm120.com1p <> 0 THEN nv_coms   = trim(STRING(sic_bran.uwm120.com1p,">9.999")) + "%".
            IF SUBSTR(sic_bran.uwm100.poltyp,1,2) = "V7"  AND nv_multi = NO THEN DO:
                nv_stdri = "N".
                nv_class = trim(sic_bran.uwm120.class). /*ADD Saharat S. A63-0126*/
                IF sic_bran.uwm100.poltyp <> "V70" THEN DO: /*Compulsory*/
                    IF SUBSTRING(sic_bran.uwm120.class,2,3) = "110" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "120" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "730" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "801" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "802" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "803" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "804" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "805" OR
                       SUBSTRING(sic_bran.uwm120.class,2,3) = "806"
                    THEN   nv_varamt = 0.
        
                    ELSE IF SUBSTRING(sic_bran.uwm120.class,2,3) = "210" OR
                            SUBSTRING(sic_bran.uwm120.class,2,3) = "220" OR
                            SUBSTRING(sic_bran.uwm120.class,2,3) = "230"
                         THEN  nv_varamt = sic_bran.uwm301.seats.
                    ELSE IF SUBSTRING(sic_bran.uwm120.class,2,3) = "320" OR
                            SUBSTRING(sic_bran.uwm120.class,2,3) = "340" OR
                            SUBSTRING(sic_bran.uwm120.class,2,3) = "420" OR
                            SUBSTRING(sic_bran.uwm120.class,2,3) = "520"
                         THEN nv_varamt = sic_bran.uwm301.tons.
        
                    ELSE IF SUBSTRING(sic_bran.uwm120.class,2,3) = "520"
                         THEN nv_varamt = sic_bran.uwm301.engine.
        
                    FIND FIRST sicsyac.xzmcom USE-INDEX xzmcom01       WHERE
                        xzmcom.class    = sic_bran.uwm120.class   AND
                        xzmcom.vehuse   = sic_bran.uwm301.vehuse  AND
                        xzmcom.var_amt >= nv_varamt       NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL xzmcom THEN
                        n_code     = xzmcom.comp_cod.
        
                    //FIND FIRST sicsyac.xtu001 USE-INDEX xtu00101 WHERE Comment by Chaiyong W. F67-0001 08/10/2024
                     FIND sicsyac.xtu001 USE-INDEX xtu00101 WHERE /*--Add by Chaiyong W. F67-0001 08/10/2024*/
                        xtu001.uset = sic_bran.uwm301.vehuse   NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL xtu001 THEN DO:
                        n_veh2 = IF sic_bran.uwm100.langug = " " THEN xtu001.usete1 ELSE xtu001.usett1.
                    END.
                END.
                ELSE DO:
        
                    /*--
                    n_code = SUBSTRING(sic_bran.uwm120.class,2,3) . 
                    comment by Chaiyong W. A66-0048 21/03/2023*/

                    /*--
                    n_code = SUBSTRING(sic_bran.uwm120.class,2,4) . /*--add by Chaiyong W. A66-0048 21/03/2023*/
                    comment by Chaiyong W. A66-0116 08/09/2023*/
                    n_code = SUBSTRING(sic_bran.uwm120.class,2,3) . /*--add by Chaiyong W. A66-0116 08/09/2023*/
                    //FIND FIRST sicsyac.xtu001 USE-INDEX xtu00101 WHERE xtu.uset = n_code NO-LOCK NO-ERROR NO-WAIT.  Comment by Chaiyong W. F67-0001 08/10/2024
                    FIND sicsyac.xtu001 USE-INDEX xtu00101 WHERE xtu.uset = n_code NO-LOCK NO-ERROR NO-WAIT. /*--Add by Chaiyong W. F67-0001 08/10/2024*/
                    IF AVAIL xtu001 THEN DO:
                        n_veh2  = IF sic_bran.uwm100.langug = "" THEN xtu001.usete1 + xtu001.usete2
                                  ELSE xtu001.usett1 + xtu001.usett2.
                    END.
                    n_code = SUBSTRING(sic_bran.uwm120.class,2,4) . /*--add by Chaiyong W. A66-0116 08/09/2023*/
                    nv_chkpol  = TRIM(sic_bran.uwm301.policy) + STRING(sic_bran.uwm301.rencnt,"99") + STRING(sic_bran.uwm301.endcnt,"999") + 
                                  STRING(sic_bran.uwm301.riskno,"999") + STRING(sic_bran.uwm301.itemno,"999").


                    /*---Begin by Chaiyong W. A67-0068 10/05/2024*/
                    RUN pd_cdriverev(INPUT  nv_chkpol).
                    IF nv_name1 = "" THEN DO:
                    /*End by Chaiyong W. A67-0068 10/05/2024*/

                        /*--
                        FIND FIRST brstat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                                   mailtxt_fil.policy  = nv_chkpol  AND
                                   mailtxt_fil.lnumber = 1          NO-LOCK NO-ERROR NO-WAIT. Comment by Chaiyong W. F67-0001 08/10/2024*/
                        /*--Begin by Chaiyong W. F67-0001 08/10/2024*/
                        FIND  brstat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                                     mailtxt_fil.policy  = nv_chkpol              AND  
                                     mailtxt_fil.lnumber = 1                      AND
                                     mailtxt_fil.bchyr   = sic_bran.uwm100.bchyr  AND 
                                     mailtxt_fil.bchno   = sic_Bran.uwm100.bchno  and
                                     mailtxt_fil.bchcnt  = sic_Bran.uwm100.bchcnt NO-LOCK NO-ERROR NO-WAIT.
                        /*End by Chaiyong W. F67-0001 08/10/2024----*/
                                   
                                   
                        IF AVAIL  mailtxt_fil THEN DO:
                            nv_stdri   = "Y". 
                            nv_birdat1 = SUBSTRING(mailtxt_fil.ltext2,1,2) + "/" +
                                         SUBSTRING(mailtxt_fil.ltext2,4,2) + "/" +
                                         SUBSTRING(mailtxt_fil.ltext2,7,4).
                            
                            nv_occup1  = SUBSTRING(mailtxt_fil.ltext2,16,40).
                            nv_icno1   = SUBSTRING(mailtxt_fil.ltext2,101,50).
                            nv_int     = 0.
                            nv_int     = int(SUBSTRING(mailtxt_fil.ltext2,7,4)) NO-ERROR.
                            /*--begin by Chaiyong W. A68-0034  16/04/2025*/
                            IF brstat.mailtxt_fil.drivbirth <> ? THEN DO:
                                nv_birdat1 = STRING(mailtxt_fil.drivbirth,"99/99/9999").
                            END.
                            ELSE
                            /*End by Chaiyong W. A68-0034 16/04/2025----*/
                            IF nv_int <> 0 AND nv_int > 543 THEN DO:
                                nv_int = nv_int - 543 .
                                nv_birdat1 = SUBSTRING(mailtxt_fil.ltext2,1,2) + "/" +
                                             SUBSTRING(mailtxt_fil.ltext2,4,2) + "/" +
                                             STRING(nv_int,"9999").
                            END.
                            
    
                            IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) <> "" THEN DO:
                                IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "MALE"   OR 
                                   TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "FEMALE" THEN DO:
                                    nv_name1  = SUBSTRING(mailtxt_fil.ltext,1,30).
                                END.
                                ELSE DO:
                                    nv_name1  = SUBSTRING(mailtxt_fil.ltext,1,50).
                                END.
                            END.
                            ELSE DO:
                                    nv_name1  = SUBSTRING(mailtxt_fil.ltext,1,50).
                            END.
                            /*--
                            FIND FIRST brstat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                                       mailtxt_fil.policy  = nv_chkpol  AND
                                       mailtxt_fil.lnumber = 2          NO-LOCK NO-ERROR NO-WAIT. Comment by Chaiyong W. F67-0001 08/10/2024*/
                            /*--Begin by Chaiyong W. F67-0001 08/10/2024*/
                            FIND  brstat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                                         mailtxt_fil.policy  = nv_chkpol              AND  
                                         mailtxt_fil.lnumber = 2                      AND
                                         mailtxt_fil.bchyr   = sic_bran.uwm100.bchyr  AND 
                                         mailtxt_fil.bchno   = sic_Bran.uwm100.bchno  and
                                         mailtxt_fil.bchcnt  = sic_Bran.uwm100.bchcnt NO-LOCK NO-ERROR NO-WAIT.
                            /*End by Chaiyong W. F67-0001 08/10/2024----*/
                            IF AVAIL  mailtxt_fil THEN DO:
                                ASSIGN
                                 nv_birdat2 = SUBSTRING(mailtxt_fil.ltext2,1,2) + "/" +
                                              SUBSTRING(mailtxt_fil.ltext2,4,2) + "/" +
                                              SUBSTRING(mailtxt_fil.ltext2,7,4).
    
                                 nv_occup2  = SUBSTRING(mailtxt_fil.ltext2,16,40).
                                 nv_icno2   = SUBSTRING(mailtxt_fil.ltext2,101,50).
    
                                 nv_int     = 0.
                                 nv_int     = int(SUBSTRING(mailtxt_fil.ltext2,7,4)) NO-ERROR.

                                 /*--begin by Chaiyong W. A68-0034 02/04/2025*/
                                 IF brstat.mailtxt_fil.drivbirth <> ? THEN DO:
                                     nv_birdat2 = STRING(mailtxt_fil.drivbirth,"99/99/9999").
                                 END.
                                 ELSE
                                 /*End by Chaiyong W. A68-0034 02/04/2025----*/

                                 IF nv_int <> 0 AND nv_int > 543 THEN DO:
                                     nv_int = nv_int - 543 .
                                     nv_birdat2 =  SUBSTRING(mailtxt_fil.ltext2,1,2) + "/" +
                                                   SUBSTRING(mailtxt_fil.ltext2,4,2) + "/" +
                                                   STRING(nv_int,"9999").
                                 END.
    
                                 IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) <> "" THEN DO:
                                     IF TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "MALE"   OR 
                                        TRIM(SUBSTRING(mailtxt_fil.ltext,31,6)) = "FEMALE" THEN DO:
                                         nv_name2  = SUBSTRING(mailtxt_fil.ltext,1,30).
                                     END.
                                     ELSE DO:
                                         nv_name2  = SUBSTRING(mailtxt_fil.ltext,1,50).
                                         
                                     END.
                                 END.
                                 ELSE DO:
                                         nv_name2  = SUBSTRING(mailtxt_fil.ltext,1,50).
                                 END.
                            END.
                        END.
                        IF nv_name1 <> "" OR nv_name2 <> ""  THEN DO:
                            DATE(nv_birdat1) NO-ERROR .
                            IF ERROR-STATUS:ERROR  THEN DO:
                                nv_err =  "ข้อมูลวัน/เดือน/ปี ผู้ขับขี่ไม่ถูกต้อง..!".
                            END.
                            DATE(nv_birdat2) NO-ERROR .
                            IF ERROR-STATUS:ERROR  THEN DO:
                                nv_err =  "ข้อมูลวัน/เดือน/ปี ผู้ขับขี่ไม่ถูกต้อง..!".
                            END.
                        END.
                    END. /*---add end by Chaiyong W. A66-0068 16/05/2024*/
                END.
                ASSIGN
                    n_engine1       = TRIM(sic_bran.uwm301.eng_no)
                    n_License       = TRIM(sic_bran.uwm301.vehreg)
                    /*nv_chassi      = TRIM(sic_bran.uwm301.cha_no)*/
                    n_chassis2     = TRIM(sic_bran.uwm301.cha_no) 
                    /*nv_garage      = TRIM(sic_bran.uwm301.garage)*/
                    nv_make        = TRIM(sic_bran.uwm301.moddes)
                    /*nv_cotyp       = TRIM(sic_bran.uwm301.covcod)*/
                    /*n_covcod       = TRIM(sic_bran.uwm301.covcod)*/
                    n_type         = TRIM(sic_bran.uwm301.covcod)
                    nv_make2       = "".

                /*--
                /*Add Kridtiya i. A64-0199 Date. 16/10/2021*/ 
                IF sic_bran.uwm301.vehreg <> "" THEN DO:
                    nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                    IF substring(nv_vehreg,1,1) = "/" OR substring(nv_vehreg,1,1) = "\" THEN DO:
                    END.
                    ELSE IF LENGTH(nv_vehreg) > 3 THEN DO:
                        nv_vehreg = TRIM(SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 1)). /*2 Position*/
                        IF  SUBSTR(nv_vehreg,1,1) >= "ก" AND  SUBSTR(nv_vehreg,1,1) <= "ฮ" AND
                            SUBSTR(nv_vehreg,2,1) >= "ก" AND  SUBSTR(nv_vehreg,2,1) <= "ฮ" THEN DO:
                            nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                            nv_vehreg = SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 2,1).
                            IF nv_vehreg = " " THEN DO:
                                nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                                nv_vehreg = TRIM(SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 2)).
                                FIND FIRST sic_bran.uwm500 USE-INDEX uwm50001 WHERE             
                                    sic_bran.uwm500.prov_n = nv_vehreg NO-LOCK NO-ERROR.
                                IF NOT AVAIL sic_bran.uwm500 THEN DO: 
                                    nv_err = sic_bran.uwm100.policy + " " + "กรุณาตรวจสอบทะเบียนรถ เช่น รหัสย่อจังหวัด !!! " + sic_bran.uwm301.vehreg.
                                END.
                            END.
                            ELSE DO:
                                nv_err = sic_bran.uwm100.policy + " " + "กรุณาตรวจสอบทะเบียนรถ เช่น รหัสย่อจังหวัด !!! " + sic_bran.uwm301.vehreg.
                            END.
                        END.
                    END. /*substring(nv_vehreg,1,1) = "/"*/ 
                END.   /*sic_bran.uwm301.vehreg <> ""*/       
                /*Add Kridtiya i. A64-0199 Date. 16/10/2021*/ 
                comment by Chaiyong W. F67-0001 08/10/2024*/

                //FIND FIRST sicsyac.sym100 USE-INDEX sym10001 WHERE Comment by Chaiyong W. F67-0001 08/10/2024
                FIND sicsyac.sym100 USE-INDEX sym10001 WHERE /*--Add by Chaiyong W. F67-0001 08/10/2024*/
                     sym100.tabcod = "U013"  AND /*sic_bran.uwm301.covcod = */
                     sym100.itmcod  = sic_bran.uwm301.covcod  NO-LOCK NO-ERROR .
                IF AVAIL sym100 THEN DO:
                     n_type     =  sym100.itmcod . 
                END.
                
                //FIND FIRST sicsyac.sym100 USE-INDEX sym10001 WHERE Comment by Chaiyong W. F67-0001 08/10/2024
                FIND sicsyac.sym100 USE-INDEX sym10001 WHERE /*--Add by Chaiyong W. F67-0001 08/10/2024*/
                     sym100.tabcod = "U014"  AND /*sic_bran.uwm301.vehuse = */
                     sym100.itmcod  = sic_bran.uwm301.vehuse  NO-LOCK NO-ERROR .
                IF AVAIL sym100 THEN DO:
                      n_vehtyp  =  sym100.itmcod . 
                END.
                ASSIGN      /* Save stat.vat100 */
                    n_Seatv    = ""
                    n_gvw      = ""
                    n_displa   = ""
                    n_Seatv    = STRING(sic_bran.uwm301.seat)
                    n_gvw      = STRING(sic_bran.uwm301.tons)
                    n_displa   = STRING(sic_bran.uwm301.engine).

                nv_classE = LENGTH(nv_class) .
                
                /*END Saharat S.A63-0126*/
        
            END.
        END.
    END.
END.
/*--- End By Nopparuj P. A67-0192 [01/04/2025] ---*/


/*--
PROCEDURE pd_vat:
       FIND FIRST stat.vat100 USE-INDEX vat10001
       WHERE stat.vat100.invtyp  = nv_vtype  
         AND stat.vat100.invoice = n_docno NO-LOCK NO-ERROR.
    IF NOT AVAIL stat.vat100 THEN DO:
      
        CREATE stat.vat100.
        ASSIGN
          stat.vat100.invtyp   = nv_vtype
          stat.vat100.invbrn   = IF nv_invbrn <> "" THEN nv_invbrn ELSE trim(SUBSTRING(gv_id,6,2))
          stat.vat100.brncod   = IF nv_invbrn <> "" THEN nv_invbrn ELSE trim(SUBSTRING(gv_id,6,2))

    /*End by Chaiyong W. A65-0185 21/07/2022-----*/
          stat.vat100.invoice  = n_docno          /*n_vatno*/
          stat.vat100.invdat   = n_trndat
          stat.vat100.poltyp   = sic_bran.uwm100.poltyp   /*n_poltyp*/
          stat.vat100.policy   = sic_bran.uwm100.policy   /*n_policy*/
          stat.vat100.rencnt   = sic_bran.uwm100.rencnt   /*n_rencnt*/
          stat.vat100.endcnt   = sic_bran.uwm100.endcnt   /*n_endcnt*/
          stat.vat100.branch   = sic_bran.uwm100.branch   /*n_branch*/
          /*--
          stat.vat100.invbrn   = SUBSTRING(gv_id,6,2)
          comment by Chaiyong W. A65-0185 21/07/2022*/
          stat.vat100.acno     = sic_bran.uwm100.acno1    /*n_acno*/
          stat.vat100.agent    = sic_bran.uwm100.agent    /*n_agent*/
          stat.vat100.trnty1   = sic_bran.uwm100.trty11   /*n_trnty1*/
          stat.vat100.refno    = n_docno         /*n_docno*/
          stat.vat100.ratevat  = sic_bran.uwm100.gstrat   /*n_ratevat*/
          stat.vat100.amount   = n_bprm
          stat.vat100.discamt  = n_disc
          stat.vat100.totamt   = n_tot
          stat.vat100.vatamt   = n_vat
          stat.vat100.grandamt = n_grd
          stat.vat100.pvrvjv   = n_pvrvjv
          stat.vat100.insref   = nv_insref    /*n_insref*/
          /*stat.vat100.name     =   n_name      Comment A63-0377    */
          stat.vat100.name     = TRIM(TRIM(n_title) + " " + TRIM(n_name) + " " + TRIM(n_name2))      /*A63-0377*/
          stat.vat100.add1     = n_paddr1 
          stat.vat100.add2     = n_paddr2        /*(n_paddr2 + n_paddr3) + n_app2*/
          stat.vat100.desci    = "ค่าเบี้ยประกันตามกรมธรรม์เลขที่ " + n_policy
          stat.vat100.descdis  = "หักส่วนลด"
          stat.vat100.entdat   = TODAY
          stat.vat100.enttime  = STRING(TIME,"HH:MM:SS")
          stat.vat100.usrid    = gv_id
          stat.vat100.remark1  = ""   /* n_rem1  */
          stat.vat100.remark2  = ""   /* n_rem2  */
          stat.vat100.print    = YES
          stat.vat100.program  = nv_dcode  
          stat.vat100.taxmont  = n_taxmont
          stat.vat100.taxyear  = n_taxyear
          stat.vat100.taxrepm  = n_taxrepm
          nv_taxno        = TRIM(nv_taxno)
          nv_brnins       = TRIM(nv_brnins)
          stat.vat100.taxno    = nv_taxno + FILL(" ",19 - LENGTH(nv_taxno)) + nv_brnins. 
          ASSIGN    /* Create Detail A63-0377 */  
          stat.vat100.endno       =    sic_bran.uwm100.endno 
          stat.vat100.comdat      =    sic_bran.uwm100.comdat                      
          stat.vat100.expdat      =    sic_bran.uwm100.expdat                       
          stat.vat100.accdat      =    sic_bran.uwm100.accdat
          stat.vat100.brnins      =    nv_brnins                
          stat.vat100.ag_name     =    n_agname                       
          stat.vat100.ac_name     =    n_acnam                        
          stat.vat100.class       =    n_code                         
          stat.vat100.occupn      =    sic_bran.uwm100.occupn     /*n_occupn*/
          stat.vat100.addr3       =    n_paddr3           /*- A63-0377 -*/
          stat.vat100.addr4       =    n_paddr4           /*- A63-0377 -*/
          stat.vat100.postcode    =    n_postcd           /*- A63-0377 -*/
          stat.vat100.vehuse      =    n_vehtyp          /*การใช้รถ*/                      
          stat.vat100.model       =    nv_make           /*n_model*/
          stat.vat100.vehreg      =    n_License                      
          stat.vat100.chas_no     =    n_Chassis2                     
          stat.vat100.eng_no      =    n_engine1                      
          stat.vat100.seat        =    INT(n_Seatv)
          stat.vat100.tons        =    DECI(n_GVW)
          stat.vat100.engine      =    DECI(n_DISPla)
          stat.vat100.Siprem      =    sic_bran.uwm100.sigr_p                       
          stat.vat100.acctext     =    nv_prm1                        
          stat.vat100.accdeci     =    0                              
          stat.vat100.drivnam1    =    nv_name1                       
          stat.vat100.drivnam2    =    nv_name2                       
          stat.vat100.drivdate1   =    DATE(nv_birdat1)                     
          stat.vat100.drivdate2   =    DATE(nv_birdat2)                     
          stat.vat100.Occdriv1    =    nv_occup1                      
          stat.vat100.Occdriv2    =    nv_occup2                      
          stat.vat100.IDNo_driv1  =    nv_icno1                       
          stat.vat100.IDNo_driv2  =    nv_icno2  
          stat.vat100.vatchar1    =    nv_chastxt    /*n_chassis*/
          stat.vat100.vatchar2    =    n_type 
          stat.vat100.vdeci1      =    n_Prem 
          stat.vat100.vdeci2      =    n_stamp 
          stat.vat100.brncod      =    n_printbr
          stat.vat100.brnadd1     =    n_add1
          stat.vat100.brnadd2     =    n_add2
          stat.vat100.prndat      =    TODAY 
          stat.vat100.ntitle      =    n_title       /*- A63-0377 -*/
          stat.vat100.firstname   =    n_name        /*- A63-0377 -*/
          stat.vat100.lastname    =    n_name2  .    /*- A63-0377 -*/
          /* Create Detail A63-0377 */  
          
          
          
    END.
    RELEASE stat.vat100 NO-ERROR.
END PROCEDURE.
/*End by  Jiraphon P. A65-0123  26/04/2022---*/
comment by Chaiyong W. A66-0116 08/09/2023*/

/*---Begin by Chaiyong W. A66-0116 08/09/2023*/
PROCEDURE pd_vat:
    //FIND FIRST brstat.vat100 USE-INDEX vat10001 Comment by Chaiyong W. F67-0001 08/10/2024
    FIND brstat.vat100 USE-INDEX vat10001  /*--Add by Chaiyong W. F67-0001 08/10/2024*/
       WHERE brstat.vat100.invtyp  = nv_vtype  
         AND brstat.vat100.invoice = n_docno NO-LOCK NO-ERROR.
    IF NOT AVAIL brstat.vat100 THEN DO:
      
        CREATE brstat.vat100.
        ASSIGN
          brstat.vat100.invtyp   = nv_vtype
          brstat.vat100.invbrn   = IF nv_invbrn <> "" THEN nv_invbrn ELSE trim(SUBSTRING(gv_id,6,2))
          brstat.vat100.brncod   = IF nv_invbrn <> "" THEN nv_invbrn ELSE trim(SUBSTRING(gv_id,6,2))
          brstat.vat100.invoice  = n_docno          /*n_vatno*/
          brstat.vat100.invdat   = n_trndat
          brstat.vat100.poltyp   = sic_bran.uwm100.poltyp   /*n_poltyp*/
          brstat.vat100.policy   = sic_bran.uwm100.policy   /*n_policy*/
          brstat.vat100.rencnt   = sic_bran.uwm100.rencnt   /*n_rencnt*/
          brstat.vat100.endcnt   = sic_bran.uwm100.endcnt   /*n_endcnt*/
          brstat.vat100.branch   = sic_bran.uwm100.branch   /*n_branch*/
          brstat.vat100.acno     = sic_bran.uwm100.acno1    /*n_acno*/
          brstat.vat100.agent    = sic_bran.uwm100.agent    /*n_agent*/
          brstat.vat100.trnty1   = sic_bran.uwm100.trty11   /*n_trnty1*/
          brstat.vat100.refno    = n_docno         /*n_docno*/
          brstat.vat100.ratevat  = sic_bran.uwm100.gstrat   /*n_ratevat*/
          brstat.vat100.amount   = n_bprm
          brstat.vat100.discamt  = n_disc
          brstat.vat100.totamt   = n_tot
          brstat.vat100.vatamt   = n_vat
          brstat.vat100.grandamt = n_grd
          brstat.vat100.pvrvjv   = n_pvrvjv
          brstat.vat100.insref   = nv_insref    /*n_insref*/
          brstat.vat100.name     = TRIM(TRIM(n_title) + " " + TRIM(n_name) + " " + TRIM(n_name2))      /*A63-0377*/
          brstat.vat100.add1     = n_paddr1 
          brstat.vat100.add2     = n_paddr2        /*(n_paddr2 + n_paddr3) + n_app2*/
          brstat.vat100.desci    = "ค่าเบี้ยประกันตามกรมธรรม์เลขที่ " + n_policy
          brstat.vat100.descdis  = "หักส่วนลด"
          brstat.vat100.entdat   = TODAY
          brstat.vat100.enttime  = STRING(TIME,"HH:MM:SS")
          brstat.vat100.usrid    = gv_id
          brstat.vat100.remark1  = ""   /* n_rem1  */
          brstat.vat100.remark2  = ""   /* n_rem2  */
          brstat.vat100.print    = YES
          brstat.vat100.program  = nv_dcode  
          brstat.vat100.taxmont  = n_taxmont
          brstat.vat100.taxyear  = n_taxyear
          brstat.vat100.taxrepm  = n_taxrepm
          nv_taxno        = TRIM(nv_taxno)
          nv_brnins       = TRIM(nv_brnins)
          brstat.vat100.taxno    = nv_taxno + FILL(" ",19 - LENGTH(nv_taxno)) + nv_brnins. 
          ASSIGN    /* Create Detail A63-0377 */  
          brstat.vat100.endno       =    sic_bran.uwm100.endno 
          brstat.vat100.comdat      =    sic_bran.uwm100.comdat                      
          brstat.vat100.expdat      =    sic_bran.uwm100.expdat                       
          brstat.vat100.accdat      =    sic_bran.uwm100.accdat
          brstat.vat100.brnins      =    nv_brnins                
          brstat.vat100.ag_name     =    n_agname                       
          brstat.vat100.ac_name     =    n_acnam                        
          brstat.vat100.class       =    n_code                         
         //brstat.vat100.occupn      =    sic_bran.uwm100.occupn     /*n_occupn*/ comment by Chaiyong W. A68-0034 16/04/2025
          brstat.vat100.occupn      =    nv_occup  /*--add by Chaiyong W. A68-0034 16/04/2025*/
          brstat.vat100.addr3       =    n_paddr3           /*- A63-0377 -*/
          brstat.vat100.addr4       =    n_paddr4           /*- A63-0377 -*/
          brstat.vat100.postcode    =    n_postcd           /*- A63-0377 -*/
          brstat.vat100.vehuse      =    n_vehtyp          /*การใช้รถ*/                      
          brstat.vat100.model       =    nv_make           /*n_model*/
          brstat.vat100.vehreg      =    n_License                      
          brstat.vat100.chas_no     =    n_Chassis2                     
          brstat.vat100.eng_no      =    n_engine1                      
          brstat.vat100.seat        =    INT(n_Seatv)
          brstat.vat100.tons        =    DECI(n_GVW)
          brstat.vat100.engine      =    DECI(n_DISPla)
          brstat.vat100.Siprem      =    sic_bran.uwm100.sigr_p                       
          brstat.vat100.acctext     =    nv_prm1                        
          brstat.vat100.accdeci     =    0                              
          brstat.vat100.drivnam1    =    nv_name1                       
          brstat.vat100.drivnam2    =    nv_name2     
              /*--
          brstat.vat100.drivdate1   =    DATE(nv_birdat1)                     
          brstat.vat100.drivdate2   =    DATE(nv_birdat2)         
          comment by Chaiyong W. A67-0068 16/05/2024*/
          brstat.vat100.Occdriv1    =    nv_occup1                      
          brstat.vat100.Occdriv2    =    nv_occup2                      
          brstat.vat100.IDNo_driv1  =    nv_icno1                       
          brstat.vat100.IDNo_driv2  =    nv_icno2  
          brstat.vat100.vatchar1    =    nv_chastxt    /*n_chassis*/
          brstat.vat100.vatchar2    =    n_type 
          brstat.vat100.vdeci1      =    n_Prem 
          brstat.vat100.vdeci2      =    n_stamp 
          brstat.vat100.brncod      =    n_printbr
          brstat.vat100.brnadd1     =    n_add1
          brstat.vat100.brnadd2     =    n_add2
          brstat.vat100.prndat      =    TODAY 
          brstat.vat100.ntitle      =    n_title       /*- A63-0377 -*/
          brstat.vat100.firstname   =    n_name        /*- A63-0377 -*/
          brstat.vat100.lastname    =    n_name2  .    /*- A63-0377 -*/
          
          
          /*---Begin by Chaiyong W. A67-0068 16/05/2024*/
          ASSIGN
              brstat.vat100.drivdate1   =    DATE(nv_birdat1)                     
              brstat.vat100.drivdate2   =    DATE(nv_birdat2) NO-ERROR.
          /*End by Chaiyong W. A67-0068 16/05/2024----*/
          
          {wgw\wgwvptv1.i}.
    END.
    RELEASE brstat.vat100 NO-ERROR.
    RELEASE stat.vat104   NO-ERROR.
END PROCEDURE.
/*End by Chaiyong W. A66-0116 08/09/2023-----*/ 
/*---Begin by Chaiyong W. A67-0068 16/05/2024*/
PROCEDURE pd_cdriverev:
    
    DEF INPUT PARAMETER nv_ichkpol AS CHAR INIT "".
DEF VAR nv_multxt AS CHAR INIT "".

//FIND FIRST sicsyac.xmm016 USE-INDEX xmm01601 WHERE xmm016.CLASS = sic_bran.uwm120.CLASS NO-LOCK NO-ERROR. Comment by Chaiyong W. F67-0001 08/10/2024*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE xmm016.CLASS = sic_bran.uwm120.CLASS NO-LOCK NO-ERROR. /*--Add by Chaiyong W. F67-0001 08/10/2024*/
IF AVAIL sicsyac.xmm016 THEN DO:
    IF sicsyac.xmm016.evflg THEN DO:
        
        IF sic_bran.uwm100.langug = "T" THEN nv_multxt = "ตามเอกสารแนบ".
        ELSE nv_multxt = "ATTACHED".

        /*
        FIND LAST brstat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                  brstat.mailtxt_fil.policy  = nv_ichkpol AND
                  brstat.mailtxt_fil.lnumber = 3          NO-LOCK NO-ERROR NO-WAIT. Comment by Chaiyong W. F67-0001 08/10/2024*/
        /*--Begin by Chaiyong W. F67-0001 08/10/2024*/
        FIND  brstat.mailtxt_fil USE-INDEX mailtxt01  WHERE
                     mailtxt_fil.policy  = nv_ichkpol             AND  
                     mailtxt_fil.lnumber = 3                      AND
                     mailtxt_fil.bchyr   = sic_bran.uwm100.bchyr  AND 
                     mailtxt_fil.bchno   = sic_Bran.uwm100.bchno  and
                     mailtxt_fil.bchcnt  = sic_Bran.uwm100.bchcnt NO-LOCK NO-ERROR NO-WAIT.
        /*End by Chaiyong W. F67-0001 08/10/2024----*/
        IF AVAIL mailtxt_fil THEN DO:
            ASSIGN
                nv_name1      = nv_multxt
                nv_birdat1    = "?"
                nv_occup1     = nv_multxt
                nv_icno1      = nv_multxt
                nv_name2      = nv_multxt
                nv_birdat2    = "?"
                nv_occup2     = nv_multxt
                nv_icno2      = nv_multxt.
        END.
    END.
END.
END PROCEDURE.
/*End by Chaiyong W. A67-0068 16/05/2024-----*/
/*---Begin by Chaiyong W. A68-0034 16/04/2025*/
PROCEDURE pd_newaddr:
    DEF VAR nv_rec101 AS RECID INIT ?.
    
    IF AVAIL sic_bran.uwm101 THEN nv_rec101 = RECID(sic_bran.uwm101).


    RUN wgw\wgwpvtcm1(input  "trn_vat"    ,
                      input  "vat_" + nv_vtype ,
                      input  "wgwvptv1"   ,
                      input  nv_recid     ,
                      input  nv_rec101    ,
                      output nv_putcode   ,
                      OUTPUT n_title      ,
                      output n_name       ,
                      output n_name2      ,
                      output n_paddr1     ,
                      output n_paddr2     ,
                      output n_paddr3     ,
                      output n_paddr4     ,
                      OUTPUT n_postcd     ,
                      output nv_taxno     ,
                      output nv_brnins    ,
                      output nv_codeocc   ,
                      output nv_occup     ,
                      output nv_ooth1     ,
                      output nv_ooth2     ,
                      output nv_ooth3     ,
                      output nv_ooth4     ).
END PROCEDURE.
/*End by Chaiyong W. A68-0034 16/04/2025-----*/
