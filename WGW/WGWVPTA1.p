/************************************************************************/
/* wgwvpta1.p   Program Check Data Release          				    */
/* Copyright	: Tokio Marine Safety Insurance (Thailand) PCL.         */
/*			  บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)			*/
/* CREATE BY	: Chaiyong W.  ASSIGN A64-0189  DATE 21/04/2021 		*/
/************************************************************************/
/*Modify By : Kridtiya i. A64-0199 Date: 16/10/2021 เพิ่มการเช็คทะเบียนรถ */ 
/* Modifiy BY  : Songkran P.  ASSIGN A64-0405  DATE 25/11/2021 		*/
/*               Check เบี้ยรวม uwm100 กับ เบี้ยรวม uwd132 		*/
/* Modify by : Chaiyong W. A65-0185 21/07/2022
            : Add Check Code1 On web                            */
/*Modify by : Krittapoj S. A65-0248 21/09/2022*/
/*            add chk fac : c_no =0           */ 
/*Modify By  : Chaiyong W. A66-0011 19/01/2023*/
/*             Add check date                 */ 
/*Modify by : Jiraphon P. A64-0380 13/03/2023
              Check  Treaty code ที่ xmm225 งาน marine ก่อนโอน*/
/*Modify by : Chaiyong W. A65-0253 30/03/2023*/
/*            Add check Release              */    
/*Modify by : Chaiying w. A66-0255 07/12/2023            */
/*          : add check idno compulsory                  */  
/*Modify by : Jiraphon P. A67-0025 Date: 01/03/2024
            : Check Installment Endorsement ให้โอน VAT ได้*/ 
/*Modify by : Chaiyong W. A67-0068 08/08/2024            */
/*            Add check endcode 72                       */  
/*Modify by : Jiraphon P. A67-0181 
              เช็ครหัส พรบ ไฟฟ้าเก่าห้ามโอน              */            
/* Modify by  : Chaiyong W. A67-0202 17/12/2024          */
/*              Check Cession No.                        */ 
/* Modify by  : Chaiyong W. A68-0034 12/03/2025          */
/*              Add check flprn                          */
              
DEF input  parameter  nv_recid    AS RECID INIT ?.
DEF input  parameter  nv_progid   AS CHAR  INIT "". /*---add by Chaiyong W. A65-0185 21/07/2022*/
DEF OUTPUT parameter  nv_error    AS CHAR  INIT "".    
DEF OUTPUT parameter  nv_transfer AS CHAR  INIT "".  


DEF VAR n_mesag     AS CHAR  INIT "".
DEF VAR nv_user     AS CHAR  INIT "".
DEF VAR nv_ins100 AS CHAR INIT "". /*Add67-0025*/ 
DEFINE VAR nv_vehreg AS CHAR.                             /*Add Kridtiya i. A64-0199 Date. 16/10/2021*/
nv_user = USERID(LDBNAME(1)).
DEF VAR nv_deci  AS DECI INIT 0.
/*Add A64-0380*/
DEFINE VAR nv_date      AS DATE INIT ?.  
DEFINE VAR nv_rip1      AS INT INIT 0.
DEFINE VAR nv_rip2      AS INT INIT 0.
DEFINE VAR nv_rip1ae    AS LOGICAL INIT NO.
DEFINE VAR nv_rip2ae    AS LOGICAL INIT NO.
DEFINE VAR nv_treaty_yr AS CHAR INIT "".
/*End A64-0380*/
/*Add A67-0025*/
DEF VAR n_trty1i    AS CHAR INIT "". 
DEF VAR n_prvamt    AS DECI.
DEF VAR n_prvamt2   AS DECI.
DEF VAR n_tot       AS DECI.
DEF VAR n_tot_vat   AS DECI.
DEF VAR n_prem100   AS DECI.
DEF BUFFER bvat100 FOR stat.vat100.
/*End A67-0025*/

/*---Begin by Chaiyong W. A67-0202 19/12/2024*/
DEF VAR nv_sces_no AS INT INIT 0.
DEF BUFFER buwm120 FOR sic_bran.uwm120.
/*End by Chaiyong W. A67-0202 19/12/2024-----*/

//FIND FIRST sic_bran.uwm100 WHERE RECID(uwm100) = nv_Recid NO-LOCK NO-ERROR. comment by Chaiyong W. A67-0202 19/12/2024*/
FIND sic_bran.uwm100 WHERE RECID(uwm100) = nv_Recid NO-LOCK NO-ERROR. /*--add by Chaiyong W. A67-0202 19/12/2024*/

IF AVAIL uwm100 THEN DO:

    /*--
    /*---Begin by Chaiyong W. A65-0253 30/03/2023*/
    
    IF sic_bran.uwm100.releas THEN DO:
        nv_error = "This Policy is Release".
        RETURN.
    END.

    /*End by Chaiyong W. A65-0253 30/03/2023-----*/
    Data GW
    */
    RUN pd_cuwm100  . /*Check Screen1  uwm100 + Docno*/
    IF nv_error  = "" THEN DO:
        //FIND FIRST sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = uwm100.poltyp NO-LOCK NO-ERROR.  comment by Chaiyong W. A67-0202 19/12/2024*/
        FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE xmm031.poltyp = uwm100.poltyp NO-LOCK NO-ERROR. /*--add by Chaiyong W. A67-0202 19/12/2024*/
        IF AVAIL xmm031 THEN DO:
            RUN pd_c120 . /*Check 120*/
            IF nv_error = "" THEN RUN pd_cuwm130 . /*Check 130 - 132*/
            IF nv_error = "" THEN RUN pd_cuwm304 . /*304*/
            IF nv_error = "" THEN RUN pd_cuwm200 . /*uwm200 -  uwd200*/
            IF nv_error = "" THEN RUN pd_cxmm026 . /*xmm026*/
            IF nv_error = "" THEN RUN pd_cuwm601 . /*uwm601*/
            IF nv_error = "" THEN RUN pd_cacm001 . /*Acm001*/  
            IF nv_error = "" THEN RUN pd_cvat100 . /*Vat100*/
            /*not check tomsec*/
            /** open comment by chaiyong W. A65-0185 21/07/2022*/


            /*----check allocate---*/
            /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
            IF nv_sces_no = 1 AND nv_error = ""  THEN DO:
                RUN pd_cesno.
            END.               
            /*End by Chaiyong W. A67-0202 19/12/2024-----*/

            

        END.                             
        ELSE DO:
            nv_error = "Policy " + uwm100.policy + "Not Found Policy Type".
        END.
    END.
END.
/*---Begin by Chaiyong W. A67-0202 19/12/2024*/
PROCEDURE pd_cesno:
    def var n_appno    as INT  INIT 0.
    def var n_rino     as char init "".
    def var n_message  as char init "".
    loop_cesno:
    FOR EACH sic_bran.uwm200 USE-INDEX uwm20001 WHERE
        uwm200.policy = sic_bran.uwm100.policy AND
        uwm200.rencnt = sic_bran.uwm100.rencnt AND
        uwm200.endcnt = sic_bran.uwm100.endcnt AND
        uwm200.bchno  = sic_bran.uwm100.bchno  AND
        uwm200.bchcnt = sic_bran.uwm100.bchcnt AND
        uwm200.bchyr  = sic_bran.uwm100.bchyr  AND
        uwm200.csftq  = "F"                    AND 
        uwm200.c_no   = 0                      :
        ASSIGN
            n_appno  = 0
            n_rino   = "".


        /*Running Webservice*/
        RUN wuw\wuweapno  (INPUT        uwm200.policy , 
                           INPUT        uwm200.c_year ,
                           INPUT        uwm100.poltyp ,
                           INPUT-OUTPUT n_appno       ,
                           INPUT-OUTPUT n_rino        ,
                           INPUT-OUTPUT nv_error     ).
        IF nv_error <> "" THEN DO:
            LEAVE loop_cesno.
        END.
        IF n_rino <> "" THEN DO:
            ASSIGN
                uwm200.c_no   = n_appno 
                SUBSTR(uwm200.recip,2,30) = "|" + n_rino.
        END.
    END.
    RELEASE uwm200 NO-ERROR.
END PROCEDURE.
/*End by Chaiyong W. A67-0202 19/12/2024-----*/

PROCEDURE pd_cvat100:
    DEF VAR nv_code1  AS CHAR INIT "".
    DEF VAR nv_chkprg AS CHAR INIT "". /*Program Print Vat*/
    DEF VAR nv_stprt  AS LOGICAL INIT NO.
    DEF VAR nv_vtype  AS CHAR INIT "".
    DEF VAR nv_prog   AS CHAR INIT "".
    DEF VAR nv_vtype2 AS CHAR INIT "".
    DEF VAR nv_bs_Cd  AS CHAR INIT "". /*Add A67-0025*/
    /*--Begin by Chaiyong W. A65-0011 19/01/2022*/
    DEF VAR nv_typfile AS CHAR INIT "". 
    DEF VAR nv_provt   AS CHAR INIT "". 
    DEF VAR nv_typf2   AS CHAR INIT "".
    DEF VAR nv_typn2   AS CHAR INIT "".
    /*End by Chaiyong W. A65-0011 19/01/2022----*/
    /*------Begin by Chaiyong W. A65-0185 21/07/2022*/
    
    
    IF LOOKUP(sic_bran.uwm100.poltyp,"M60,M61,M62,M63,M64,M67") <> 0 THEN DO: 
        RETURN.
    END.

    
    nv_code1 = TRIM(SUBSTR(sic_bran.uwm100.code1,100,50)) NO-ERROR.
    IF nv_code1 <> "" THEN DO:
        /*
        FIND FIRST stat.symprog WHERE symprog.grpcod  = "Onweb"  AND
                                 (symprog.prog = nv_code1 OR
                                  symprog.prog = nv_code1 + ".P") NO-LOCK NO-ERROR.
        IF AVAIL symprog THEN DO: */
        IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "S" THEN DO:
            nv_vtype2  = TRIM(sic_bran.uwm100.trty13).  
        END.
        ELSE IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "N" THEN  /*LOckton by kridtiya i.*/
            nv_vtype2  = TRIM(sic_bran.uwm100.trty13).                              /*LOckton by kridtiya i. type = N */ 
        ELSE nv_vtype2  = "T".
        /*END.*/

    END.
    ELSE IF nv_code1 = "" THEN DO:
        /*
        FIND FIRST stat.symprog WHERE symprog.grpcod  = "Onweb"  AND
                                 (symprog.prog = sic_bran.uwm100.prog OR
                                  symprog.prog = sic_bran.uwm100.prog + ".P") NO-LOCK NO-ERROR.
        IF AVAIL symprog THEN DO:
         */
            nv_code1  =  sic_bran.uwm100.prog.
             IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "S" THEN DO:
                nv_vtype2  = TRIM(sic_bran.uwm100.trty13).  
            END.
            ELSE IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "N" THEN  /*LOckton by kridtiya i.*/
                nv_vtype2  = TRIM(sic_bran.uwm100.trty13).                              /*LOckton by kridtiya i. type = N */ 
            ELSE nv_vtype2  = "T".
            nv_chkprg = sic_bran.uwm100.prog.
        /*END.*/
    END.
    ELSE DO:
         nv_code1 = TRIM(SUBSTR(sic_bran.uwm100.code1,1,10)) NO-ERROR.
    END.
    IF nv_vtype2 = "N" THEN RETURN.
    /*END BY chaiyong W. A65-0185 21/07/2022--------*/

     /*--
     nv_code1 = TRIM(SUBSTR(sic_bran.uwm100.code1,1,10)) NO-ERROR.
     comment by Chaiyong W. A65-0185 21/07/2022*/

    IF nv_code1 <> "" AND nv_code1 <> ? THEN DO:
        /*--
       RUN wuw\wuwppics3(INPUT TODAY,INPUT "chk_trvat",OUTPUT nv_chkprg ).
       comment by Chaiyong W. A65-0185 05/08/2022*/
        /*---
        /*---Begin by Chaiyong W. A65-0185 05/08/2022*/
        IF nv_chkprg = "" THEN RUN wuw\wuwppics3(INPUT TODAY,INPUT "chk_trvat",OUTPUT nv_chkprg ).
        /*End by Chaiyong W. A65-0185 05/08/2022-----*/
        comment by Chaiyong W. A66-0011 19/01/2023*/
        /*----Begin by Chaiyong W. A66-0011 19/01/2023*/
        IF nv_chkprg = "" THEN DO:
            nv_provt = nv_code1   .
            IF INDEX(nv_provt,".") <> 0 THEN nv_provt = trim(SUBSTR(nv_provt,1,INDEX(nv_provt,".")  - 1)).
            RUN wuw\wuwpuzpdt(INPUT TODAY ,
                              INPUT "Form_Print",
                              INPUT ""          ,
                              INPUT "TRNVAT"    ,
                              INPUT  nv_code1   ,
                              OUTPUT nv_chkprg  ,
                              OUTPUT nv_typfile ). 
        END.
        ELSE nv_chkprg = "TRANSFER".  /*WEB*/
        /*End by Chaiyong W. A66-0011 19/01/2023------*/


  
       nv_stprt = NO.
       IF LOOKUP(sic_bran.uwm100.poltyp,"M60,M61,M62,M63,M64,M67") <> 0 THEN DO:
           nv_stprt = YES.        
       END.
       ELSE DO:
           FIND LAST sic_bran.uwd132 WHERE uwd132.policy = uwm100.policy AND
               uwd132.rencnt = uwm100.rencnt AND
               uwd132.endcnt = uwm100.endcnt AND
               /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
               uwd132.bchyr  = uwm100.bchyr  AND
               uwd132.bchno  = uwm100.bchno  AND
               uwd132.bchcnt = uwm100.bchcnt AND              
               /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 



               uwd132.bencod = "NPRM"        NO-LOCK  NO-ERROR NO-WAIT.
           IF AVAIL uwd132 THEN DO:
               nv_stprt = YES.     
           END.
       END. 
       IF  uwm100.poltyp  =  "M30"     AND
           uwm100.cr_1    =  "JINV001" AND     
           uwm100.cr_2    <> ""        THEN DO:
           nv_stprt  = YES.
       END.

       /*----Begin by Chaiyong W. A65-0011 19/01/2023*/

       /*--
       FIND FIRST sic_bran.uwm120 WHERE uwm120.policy = uwm100.policy AND
                               uwm120.rencnt = uwm100.rencnt AND
                               uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
       comment by Chaiyong W. A67-0202 19/12/2024*/
       /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
       FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
                   uwm120.policy = uwm100.policy AND
                   uwm120.rencnt = uwm100.rencnt AND
                   uwm120.endcnt = uwm100.endcnt AND 
                   uwm120.bchyr  = uwm100.bchyr  AND
                   uwm120.bchno  = uwm100.bchno  AND
                   uwm120.bchcnt = uwm100.bchcnt NO-LOCK NO-ERROR.

       /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                               
                               
       IF AVAIL sic_bran.uwm120 THEN DO:
           RUN wuw\wuwpuzpdt(INPUT TODAY ,
                                  INPUT "Form_Print",
                                  INPUT ""          ,
                                  INPUT "RLTRVT"    ,
                                  INPUT  TRIM(sic_bran.uwm100.poltyp) + TRIM(sic_bran.uwm120.CLASS),
                                  OUTPUT nv_typn2   ,
                                  OUTPUT nv_typf2 ). 
       END.
       IF nv_typn2 <> "" THEN DO:
           IF nv_typn2 = "Transfer" THEN  nv_stprt  = NO.
           ELSE  nv_stprt  = YES.
       END.
       /*End by Chaiyong W. A65-0011 19/01/2023------*/
       IF INDEX("wa4pmvtuw,wa4pahon,wa4phon2,wa4pamnf,wa4paum",nv_code1) <> 0 THEN nv_vtype = "S".
       ELSE nv_vtype  = trim(SUBSTR(sic_bran.uwm100.code1,40,5)).


       IF TRIM(nv_vtype2) <> "" THEN nv_vtype = nv_vtype2. /*---add by Chaiyong W. A65-0185 21/07/2022*/
       /*--
       IF sic_bran.uwm100.code1 <> "" AND INDEX(nv_chkprg,nv_code1) <> 0 AND uwm100.instot = 1 AND nv_stprt = NO AND nv_vtype <> "" THEN DO: /*-- Add A63-0264 --*/
       comment by Chaiyong W. A65-0185 21/07/2022*/
       /*--
        IF nv_code1 <> "" AND INDEX(nv_chkprg,nv_code1) <> 0 AND uwm100.instot = 1 AND nv_stprt = NO AND nv_vtype <> "" THEN DO: /*-- Add by Chaiyong W. A65-0185 21/07/2022*/
                     comment by Chaiyong W.  A66-0011 19/01/2023*/
        /*IF nv_code1 <> "" AND nv_chkprg = "TRANSFER" AND uwm100.instot = 1 AND nv_stprt = NO AND nv_vtype <> "" THEN DO:  /*---add by Chaiyong W.  A66-0011 19/01/2023*/ Comment A67-0025*/
        IF nv_code1 <> "" AND nv_chkprg = "TRANSFER" AND nv_stprt = NO AND nv_vtype <> "" THEN DO: /*Add A67-0025*/
           FIND FIRST stat.vat100 WHERE 
                      vat100.policy   = uwm100.policy and
                      vat100.rencnt   = uwm100.rencnt and
                      vat100.endcnt   = uwm100.endcnt AND
                      vat100.cancel   = NO            NO-LOCK NO-ERROR.
           IF AVAIL vat100 THEN DO:
               nv_error = "พบเลขกรมธรรม์ : " + uwm100.policy + " นี้ที่ฝั่ง Vat แล้วกรุณา ตรวจสอบข้อมูล".
           END.
           ELSE DO:
               FIND FIRST stat.vat102 USE-INDEX vat10204 WHERE
                   vat102.policy   = uwm100.policy and
                   vat102.rencnt   = uwm100.rencnt and
                   vat102.endcnt   = uwm100.endcnt AND 
                   vat102.cancel   = NO         NO-LOCK NO-ERROR.
               IF AVAIL vat102 THEN DO:
                   nv_error = "พบเลขกรมธรรม์ : " + uwm100.policy + " นี้ที่ฝั่ง Vat (102) แล้วกรุณา ตรวจสอบข้อมูล".
               END.
               ELSE DO:
                   IF uwm100.instot = 1 THEN DO: /*Add Jiraphon P. A67-0025*/
                       FIND FIRST stat.vat100 USE-INDEX vat10001 WHERE
                             vat100.invtyp  =  nv_vtype            AND
                             vat100.invoice =  uwm100.docno1 NO-LOCK NO-ERROR.
                       IF AVAIL vat100 THEN DO:
                            nv_error = "เลข Docno " + uwm100.docno1  + " นี้มีอยู่ในระบบ Vat (VAT100) แล้วที่กรม : " + vat100.policy.
                       END.
                       ELSE DO:
                           FIND FIRST stat.vat102 USE-INDEX vat10205  WHERE
                                vat102.invtyp  =  nv_vtype        AND
                                vat102.invoice =  uwm100.docno1 NO-LOCK NO-ERROR.
                           IF AVAIL vat102 THEN DO:
                               nv_error = "เลข Docno " + uwm100.docno1  + " นี้มีอยู่ในระบบ Vat (VAT102) แล้วที่กรม : " + vat102.policy.
                           END.
                           ELSE DO:
                               /*Add A67-0025*/
                               ASSIGN
                                   nv_ins100  = uwm100.insref
                                   nv_bs_cd   = uwm100.bs_Cd.
                               IF SUBSTRING(uwm100.poltyp,1,2) <> "V7" AND uwm100.dir_ri = NO THEN nv_ins100  = uwm100.cedco.

                               
                               IF SUBSTRING(uwm100.poltyp,1,2) <> "V7" AND nv_bs_cd <> "" THEN DO:
                                   ASSIGN
                                       nv_ins100  = nv_bs_cd 
                                       nv_bs_cd   = "".
                               END.
                               /*End A67-0025*/

                               RUN pd_uzot0983(INPUT uwm100.insref,
                                               INPUT uwm100.bs_cd,
                                               INPUT uwm100.name1,
                                               INPUT uwm100.name2,
                                               INPUT uwm100.name3,
                                               OUTPUT nv_error).
                               IF nv_error = "" THEN nv_transfer = "transfer".

                               /*Add A67-0025*/
                               IF nv_vtype = "C" THEN DO:
                                   n_trty1i = "".
                                   IF uwm100.DIR_ri = NO THEN n_trty1i = "O". ELSE n_trty1i = "M".
                                   IF uwm100.chr2 <> "" THEN DO:
                                       IF uwm100.chr2 = "0000000000" THEN DO:
                                           n_prvamt2 = 0. n_prvamt = 0. n_tot = 0. n_tot_vat = 0.
                                           FIND LAST stat.vat100 USE-INDEX vat10002 WHERE 
                                               vat100.policy = uwm100.policy AND
                                               vat100.cancel = NO NO-LOCK NO-ERROR.
                                           IF NOT AVAIL vat100 THEN DO: 
                                               nv_error = "ไม่มีข้อมูลใบเสร็จใบกำกับภาษีที่บัญชี".
                                           END.
                                           ELSE DO:
                                               loop_vat100:
                                               FOR EACH stat.vat100 USE-INDEX vat10002 WHERE 
                                                   vat100.policy = uwm100.policy  AND
                                                   vat100.cancel = NO         NO-LOCK.
                                                       
                                                   IF vat100.invtyp = "B"  THEN NEXT loop_vat100. 
                                                   IF vat100.invtyp = "C" THEN  n_prvamt2 = (vat100.totamt * (-1)) + (vat100.vatamt * (-1)).
                                                   ELSE                         n_prvamt2 = vat100.totamt + vat100.vatamt.
                                                   n_prvamt  = n_prvamt + n_prvamt2. 
                                                   n_tot = n_prvamt.
                                               END.
                                               IF n_tot + (uwm100.prem_t + uwm100.ptax + uwm100.rtax_t + uwm100.pstp + uwm100.rstp_t + uwm100.pfee + uwm100.rfee_t) < 0 THEN DO:
                                                   nv_error = "RefDocNo." + uwm100.chr2 + " สลักหลังเบี้ยลบยอดเงินเกินใบเสร็จใบกำกับภาษีที่บัญชี".
                                               END.
                                           END. 
                                       END.
                                       ELSE DO:
                                           n_prvamt2 = 0. n_prvamt = 0. n_tot = 0. n_tot_vat = 0.
                                           FIND LAST stat.vat100 USE-INDEX vat10002 WHERE 
                                               vat100.policy = uwm100.policy AND
                                               vat100.trnty1 = n_trty1i      AND
                                               vat100.refno  = uwm100.chr2   AND 
                                               vat100.cancel = NO NO-LOCK NO-ERROR.
                                           IF NOT AVAIL vat100 THEN DO: 
                                               nv_error = "RefDocNo." + uwm100.chr2 + " ไม่มีข้อมูลใบเสร็จใบกำกับภาษีที่บัญชี".
                                           END.
                                           ELSE DO:
                                               loop_vat100:
                                               FOR EACH stat.vat100 USE-INDEX vat10002 WHERE 
                                                   vat100.policy = uwm100.policy  AND
                                                   vat100.cancel = NO         NO-LOCK.
                                                       
                                                   IF vat100.invtyp = "B"  THEN NEXT loop_vat100. 
                                                   IF vat100.invtyp = "C" THEN  n_prvamt2 = (vat100.totamt * (-1)) + (vat100.vatamt * (-1)).
                                                   ELSE                         n_prvamt2 = vat100.totamt + vat100.vatamt.
                                                   n_prvamt  = n_prvamt + n_prvamt2. 
                                                   n_tot_vat = n_prvamt.
                                               END.
                                               IF n_tot_vat + (uwm100.prem_t + uwm100.ptax + uwm100.rtax_t + uwm100.pstp + uwm100.rstp_t + uwm100.pfee + uwm100.rfee_t) < 0 THEN DO:
                                                   nv_error = "RefDocNo." + uwm100.chr2 + " สลักหลังเบี้ยลบยอดเงินเกินใบเสร็จใบกำกับภาษีที่บัญชี".
                                               END.
                                               ELSE DO:
                                                   n_prvamt2 = 0. n_prvamt = 0. n_tot = 0. n_tot_vat = 0.
                                                   FIND FIRST stat.vat100 USE-INDEX vat10002 WHERE 
                                                       vat100.policy = uwm100.policy AND
                                                       vat100.trnty1 = n_trty1i      AND
                                                       vat100.refno  = uwm100.chr2   AND 
                                                       vat100.cancel = NO NO-LOCK NO-ERROR.
                                                   IF AVAIL stat.vat100 THEN DO:  
                                                       n_tot = vat100.totamt + vat100.vatamt.
                                                       loop_vat100:
                                                       FOR EACH bvat100 USE-INDEX vat10002
                                                            WHERE bvat100.policy  = vat100.policy
                                                            AND   bvat100.invold  = vat100.invoice
                                                            AND   bvat100.cancel  = NO    NO-LOCK.
                                           
                                                           IF bvat100.invtyp = "B"  THEN NEXT loop_vat100. 
                                                           IF bvat100.invtyp = "C" THEN  n_prvamt2 = (bvat100.totamt * (-1)) + (bvat100.vatamt * (-1)).
                                                           ELSE                         n_prvamt2 = bvat100.totamt + bvat100.vatamt.
                                                           n_prvamt  = n_prvamt + n_prvamt2. 
                                                           n_tot = (vat100.totamt + vat100.vatamt) + n_prvamt.
                                                       END.
                                                   END.
                                                   IF n_tot + (uwm100.prem_t + uwm100.ptax + uwm100.rtax_t + uwm100.pstp + uwm100.rstp_t + uwm100.pfee + uwm100.rfee_t) < 0 THEN DO:
                                                       nv_error = "RefDocNo." + uwm100.chr2 + " สลักหลังเบี้ยลบยอดเงินเกินใบเสร็จใบกำกับภาษีที่บัญชี".
                                                   END.
                                               END.
                                           END.
                                       END.
                                   END.
                               END.
                               IF nv_error = "" THEN nv_transfer = "transfer".
                               /*End A67-025*/
                           END.
                       END.
                   END. /*Add A67-0025*/
                   /*--Begin Add Jiraphon P. A65-0123*/
                   ELSE DO:
                        IF //uwm100.endcnt = 0 AND  Comment A67-0025
                            /*SUBSTRING(uwm100.poltyp,1,2) = "V7" AND nv_vtype = "S" comment by Chaiyong W. A65-0150 / A65-0185 05/08/2022*/
                            (nv_vtype = "S" OR nv_vtype = "T") /*--add by Chaiyong W. A65-0185 05/08/2022*/ THEN DO:
                           FIND FIRST sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                             uwm101.policy   = uwm100.policy and
                             uwm101.rencnt   = uwm100.rencnt and
                             uwm101.endcnt   = uwm100.endcnt AND

                             /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                             uwm101.bchyr    = uwm100.bchyr  AND
                             uwm101.bchno    = uwm100.bchno  AND
                             uwm101.bchcnt   = uwm100.bchcnt AND
                             /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 

                          /*---
                             uwm101.flgprn   <> ""
                          comment by Chaiyogn W. A68-0034 17/03/2025*/
                           
                           /*---Begin by Chaiyong W. A68-0034 12/03/2025*/
                          ((uwm101.flgprn <> "" AND uwm100.ltstatus <> "Y") OR
                            (uwm101.flgprn = "Y" AND uwm100.ltstatus = "Y"))
                          /*End by  Chaiyong W. A68-0034 12/03/2025----*/    
                               
                           NO-LOCK NO-ERROR.
                           IF AVAIL sic_bran.uwm101 THEN DO:
                               loop_c101:
                               FOR EACH sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                                     uwm101.policy   = uwm100.policy and
                                     uwm101.rencnt   = uwm100.rencnt and
                                     uwm101.endcnt   = uwm100.endcnt 
                                     /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                     AND
                                     uwm101.bchyr    = uwm100.bchyr  AND
                                     uwm101.bchno    = uwm100.bchno  AND
                                     uwm101.bchcnt   = uwm100.bchcnt
                                     /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                                      /*---Begin by Chaiyong W. A68-0034 12/03/2025*/
                                   AND
                                    ((uwm100.ltstatus <> "Y") OR
                                      (uwm101.flgprn = "Y" AND uwm100.ltstatus = "Y"))
                                    /*End by  Chaiyong W. A68-0034 12/03/2025----*/   
                                   NO-LOCK:
                                     IF uwm101.trty1i = "M" OR uwm101.trty1i = "O" THEN DO:
                                     END.
                                     ELSE DO: 
                                         /*nv_error = "กรมธรรม์: " + uwm100.policy + " Trn. Type Installment Only M". Comment A67-0025*/
                                         nv_error = "กรมธรรม์: " + uwm100.policy + " VAT type " + nv_vtype + " Trn.type Installment ต้องเป็น Type M". /*Add A67-0025*/
                                         LEAVE loop_c101.
        
                                     END.
                                     IF ((uwm101.prem_i + uwm101.rstp_i + uwm101.rtax_i + uwm101.pstp_i + uwm101.ptax_i + uwm101.pfee_i + uwm101.rfee_i) > 0) OR
                                      ((uwm101.prem_i + uwm101.rstp_i + uwm101.rtax_i + uwm101.pstp_i + uwm101.ptax_i + uwm101.pfee_i + uwm101.rfee_i) = 0 AND 
                                      (uwm101.com1_i + uwm101.com2_i) < 0 ) THEN DO:
        
                                     END.
                                     ELSE DO: 
                                         nv_error = "กรมธรรม์: " + uwm100.policy + " Prem. Inst. > 0".
                                         LEAVE loop_c101.
        
                                     END.
                                     /*--
                                     /*---Begin by Chaiyong W. A65-0253 24/04/2023*/
                                     IF  uwm101.prem_i <> 0 OR uwm101.com1_i <> 0 OR uwm101.com2_i <> 0 OR
                                         uwm101.pstp_i <> 0 OR uwm101.pfee_i <> 0 OR uwm101.ptax_i <> 0 OR
                                         uwm101.rstp_i <> 0 OR uwm101.rfee_i <> 0 OR uwm101.rtax_i <> 0 THEN DO:
                                         ASSIGN
                                             nv_deci = 0
                                             nv_deci = DECI(uwm101.docnoi) NO-ERROR.
                                         IF nv_deci = 0 THEN DO: 
                                             NEXT loop_c101.
                                         END.
                                     END.
                                     /*End by Chaiyong W. A65-0253 24/04/2023-----*/
                                     comment by Chaiyong W. A68-0034 13/05/2025*/
                                     IF  uwm101.flgprn   <> "" THEN DO:
                                         nv_error = "".


                                         //FIND FIRST vat100 USE-INDEX vat10001 WHERE         Comment by Chaiyong W. A67-0202 19/12/2024*/
                                         //FIND FIRST stat.vat100 USE-INDEX vat10001 WHERE /*---add by Chaiyong W. A67-0202 19/12/2024*/ comment by Chaiyong W. A68-0034 13/05/2025
                                         FIND  stat.vat100 USE-INDEX vat10001 WHERE  /*----add by Chaiyong W. A68-0034 13/05/2025*/
                                               vat100.invtyp  =  nv_vtype            AND
                                               vat100.invoice =  uwm101.docnoi NO-LOCK NO-ERROR.
                                         IF AVAIL vat100 THEN DO:
                                              nv_error = "เลข Docno " + uwm101.docnoi  + " นี้มีอยู่ในระบบ Vat (VAT100) แล้วที่กรม : " + vat100.policy.
                                         END.
                                         ELSE DO:
                                             //FIND FIRST vat102 USE-INDEX vat10205  WHERE  Comment by Chaiyong W. A67-0202 19/12/2024*/
                                             FIND FIRST stat.vat102 USE-INDEX vat10205 WHERE /*---add by Chaiyong W. A67-0202 19/12/2024*/
                                                  vat102.invtyp  =  nv_vtype        AND
                                                  vat102.invoice =  uwm101.docnoi NO-LOCK NO-ERROR.
                                             IF AVAIL vat102 THEN DO:
                                                 nv_error = "เลข Docno " + uwm101.docnoi  + " นี้มีอยู่ในระบบ Vat (VAT102) แล้วที่กรม : " + vat102.policy.
                                             END.
                                             ELSE DO:
                                                 nv_bs_cd  = "".
                                                 IF uwm101.desc_i <> "" THEN DO:
                                                     nv_bs_cd = TRIM(SUBSTRING(uwm101.desc_i, 1, INDEX(uwm101.desc_i, " ") - 1)) NO-ERROR .
                                                     //FIND sicsyac.xmm600 WHERE xmm600.acno = nv_bs_cd NO-LOCK NO-ERROR. Comment by Chaiyong W. A67-0202 19/12/2024*/
                                                     FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_bs_cd NO-LOCK NO-ERROR. /*---add by Chaiyong W. A67-0202 19/12/2024*/
                                                     IF NOT AVAIL sicsyac.xmm600 THEN DO:
                                                         nv_error = "กรมธรรม์: " + uwm100.policy + " Code ที่ออก Vat " + nv_bs_cd  + " ไม่พบในฐานข้อมูล".
                
                                                     END.
                                                    
                                                 END.
                                                 ELSE nv_bs_cd = uwm100.bs_cd.
                                                 /*--
                                                 IF nv_error = "" THEN
                                                     RUN pd_uzot0983(INPUT uwm100.insref,
                                                                     INPUT nv_bs_cd ,
                                                                     INPUT uwm100.name1,
                                                                     INPUT uwm100.name2,
                                                                     INPUT uwm100.name3,
                                                                     OUTPUT nv_error).
                                                 comment by Chaiyong W. A65-0150 09/06/2022*/
                                                 /*---Begin by Chaiyong W. A65-0150 09/06/2022*/
                                                 
                                                 nv_ins100  = uwm100.insref.
                                                 IF SUBSTRING(uwm100.poltyp,1,2) <> "V7" AND uwm100.dir_ri = NO THEN nv_ins100  = uwm100.cedco.
        
                                                 
                                                 IF SUBSTRING(uwm100.poltyp,1,2) <> "V7" AND nv_bs_cd <> "" THEN DO:
                                                     ASSIGN
                                                         nv_ins100  = nv_bs_cd 
                                                         nv_bs_cd   = "".
                                                 END.
                                                 IF nv_error = "" THEN
                                                     RUN pd_uzot0983(INPUT nv_ins100,
                                                                     INPUT nv_bs_cd ,
                                                                     INPUT uwm100.name1,
                                                                     INPUT uwm100.name2,
                                                                     INPUT uwm100.name3,
                                                                     OUTPUT nv_error).
                                                 /*End by Chaiyong W. A65-0150 09/06/2022-----*/
                                                 
                                             END.
                                         END.
                                         IF nv_error <> "" THEN LEAVE loop_c101.
                                     END.
                               END. 
                               IF nv_error = "" THEN nv_transfer = "transfer".
                           END.
                           ELSE DO:
                               nv_error = "กรมธรรม์: " + uwm100.policy +  " Mark flag งาน installment ไม่ถูกต้อง ".
                           END.
                        END.
                        /*Add A67-0025 vat = C*/
                        ELSE DO:
                            IF uwm100.DIR_ri = NO THEN n_trty1i = "O". ELSE n_trty1i = "M".
                            n_prem100 = 0.
                            n_prvamt2 = 0. n_prvamt = 0. n_tot = 0. n_tot_vat = 0.
                            /*เช็ค "0000000000"*/
                            FIND FIRST sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                               uwm101.policy   = uwm100.policy and
                               uwm101.rencnt   = uwm100.rencnt and
                               uwm101.endcnt   = uwm100.endcnt AND
                               /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                               uwm101.bchyr    = uwm100.bchyr  AND
                               uwm101.bchno    = uwm100.bchno  AND
                               uwm101.bchcnt   = uwm100.bchcnt AND
                               /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 


                               uwm101.flgprn   <> ""           AND 
                               uwm101.chr2     = "0000000000" NO-LOCK NO-ERROR.
                            IF AVAIL sic_bran.uwm101 THEN DO:
                                loop_vat100:
                                FOR EACH stat.vat100 USE-INDEX vat10002 WHERE 
                                    vat100.policy = uwm100.policy  AND
                                    vat100.cancel = NO         NO-LOCK.
                                        
                                    IF vat100.invtyp = "B"  THEN NEXT loop_vat100. 
                                    IF vat100.invtyp = "C" THEN  n_prvamt2 = (vat100.totamt * (-1)) + (vat100.vatamt * (-1)).
                                    ELSE                         n_prvamt2 = vat100.totamt + vat100.vatamt.
                                    n_prvamt  = n_prvamt + n_prvamt2. 
                                    n_tot_vat = n_prvamt.
                                END.
                                IF uwm101.chr2 = "0000000000" THEN DO:
                                    IF n_tot_vat + (uwm101.prem_i + uwm101.rstp_i + uwm101.rtax_i + uwm101.pstp_i + uwm101.ptax_i + uwm101.pfee_i + uwm101.rfee_i) < 0 THEN DO:
                                        nv_error = "สลักหลังเบี้ยลบ " + string(n_prem100) + " ยอดเงินเกินใบกำกับภาษีที่บัญชี " + string(n_tot_vat) .
                                    END.
                                END.
                            END.
                            ELSE DO:
                                FIND FIRST sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                                  uwm101.policy   = uwm100.policy and
                                  uwm101.rencnt   = uwm100.rencnt and
                                  uwm101.endcnt   = uwm100.endcnt AND
                                  /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                  uwm101.bchyr    = uwm100.bchyr  AND
                                  uwm101.bchno    = uwm100.bchno  AND
                                  uwm101.bchcnt   = uwm100.bchcnt AND
                                  /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                                  /*--
                                  uwm101.flgprn   <> ""
                                  comment by Chaiyong W. A68-0034 12/03/2025*/
                                    /*---Begin by Chaiyong W. A68-0034 12/03/2025*/
                                   ((uwm101.flgprn   <> "" AND uwm100.ltstatus <> "Y") OR
                                    ( uwm101.flgprn = "Y" AND uwm100.ltstatus = "Y"))
                                  /*End by  Chaiyong W. A68-0034 12/03/2025----*/    
                                     
                                    
                                    NO-LOCK NO-ERROR.
                                IF AVAIL sic_bran.uwm101 THEN DO:
            
                                    loop_c101:
                                    FOR EACH sic_bran.uwm101 USE-INDEX uwm10101 WHERE 
                                          uwm101.policy   = uwm100.policy and
                                          uwm101.rencnt   = uwm100.rencnt and
                                          uwm101.endcnt   = uwm100.endcnt
                                          /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                          AND
                                          uwm101.bchyr    = uwm100.bchyr  AND
                                          uwm101.bchno    = uwm100.bchno  AND
                                          uwm101.bchcnt   = uwm100.bchcnt 
                                          /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                                          /*---Begin by Chaiyong W. A68-0034 12/03/2025*/
                                           AND
                                           ((uwm100.ltstatus <> "Y") OR
                                             (uwm101.flgprn = "Y" AND uwm100.ltstatus = "Y"))
                                           /*End by  Chaiyong W. A68-0034 12/03/2025----*/  
                                     


                                          NO-LOCK:
                                          IF uwm101.trty1i = "R" OR uwm101.trty1i = "T" THEN DO:
                                          END.
                                          ELSE DO: 
                                              nv_error = "กรมธรรม์: " + uwm100.policy + " VAT type " + nv_vtype + " Trn.type Installment ต้องเป็น Type R".
                                              LEAVE loop_c101.
                                          END.
                                          IF ((uwm101.prem_i + uwm101.rstp_i + uwm101.rtax_i + uwm101.pstp_i + uwm101.ptax_i + uwm101.pfee_i + uwm101.rfee_i) < 0) OR
                                           ((uwm101.prem_i + uwm101.rstp_i + uwm101.rtax_i + uwm101.pstp_i + uwm101.ptax_i + uwm101.pfee_i + uwm101.rfee_i) = 0 AND 
                                           (uwm101.com1_i + uwm101.com2_i) < 0 ) THEN DO:
                                          
                                          END.
                                          ELSE DO: 
                                              nv_error = "กรมธรรม์: " + uwm100.policy + " Prem. Inst. < 0".
                                              LEAVE loop_c101.
                                          END.
                                          IF  uwm101.flgprn   <> "" THEN DO:
                                              n_prem100 = n_prem100 + uwm101.prem_i + uwm101.rstp_i + uwm101.rtax_i + uwm101.pstp_i + uwm101.ptax_i + uwm101.pfee_i + uwm101.rfee_i.
                                              nv_error = "".
                                              FIND FIRST stat.vat100 USE-INDEX vat10001 WHERE
                                                    vat100.invtyp  =  nv_vtype            AND
                                                    vat100.invoice =  uwm101.docnoi NO-LOCK NO-ERROR.
                                              IF AVAIL stat.vat100 THEN DO:
                                                   nv_error = "เลข Docno " + uwm101.docnoi  + " นี้มีอยู่ในระบบ Vat (VAT100) แล้วที่กรม : " + vat100.policy.
                                              END.
                                              ELSE DO:
                                                  FIND FIRST stat.vat102 USE-INDEX vat10205  WHERE
                                                       vat102.invtyp  =  nv_vtype        AND
                                                       vat102.invoice =  uwm101.docnoi NO-LOCK NO-ERROR.
                                                  IF AVAIL vat102 THEN DO:
                                                      nv_error = "เลข Docno " + uwm101.docnoi  + " นี้มีอยู่ในระบบ Vat (VAT102) แล้วที่กรม : " + vat102.policy.
                                                  END.
                                                  ELSE DO:
                                                      nv_bs_cd  = "".
                                                      IF uwm100.ltstatus = "Y" AND uwm101.insref_i <> "" THEN nv_bs_cd = TRIM(uwm101.insref_i).  /*---Add by Chaiyong W. A68-0034 21/04/2025*/ 
                                                      ELSE IF uwm101.desc_i <> "" AND uwm100.ltstatus <> "Y"  /*---Add by Chaiyong W. A68-0034 21/04/2025*/ 
                                                      THEN DO:
                                                          nv_bs_cd = TRIM(SUBSTRING(uwm101.desc_i, 1, INDEX(uwm101.desc_i, " ") - 1)) NO-ERROR .
                                                          //FIND sicsyac.xmm600 WHERE xmm600.acno = nv_bs_cd NO-LOCK NO-ERROR. comment by Chaiyong W. A67-0202 19/12/2024*/
                                                          FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_bs_cd NO-LOCK NO-ERROR. /*---add by Chaiyong W. A67-0202 19/12/2024*/
                                                          IF NOT AVAIL sicsyac.xmm600 THEN DO:
                                                              nv_error = "กรมธรรม์: " + uwm100.policy + " Code ที่ออก Vat " + nv_bs_cd  + " ไม่พบในฐานข้อมูล".
                                             
                                                          END.
                                                      END.
                                                      ELSE nv_bs_cd = uwm100.bs_cd.
                                                      
                                                      nv_ins100  = uwm100.insref.
                                                      IF SUBSTRING(uwm100.poltyp,1,2) <> "V7" AND uwm100.dir_ri = NO THEN nv_ins100  = uwm100.cedco.
                                             
                                                      
                                                      IF SUBSTRING(uwm100.poltyp,1,2) <> "V7" AND nv_bs_cd <> "" THEN DO:
                                                          ASSIGN
                                                              nv_ins100  = nv_bs_cd 
                                                              nv_bs_cd   = "".
                                                      END.
                                                      IF nv_error = "" THEN
                                                          RUN pd_uzot0983(INPUT nv_ins100,
                                                                          INPUT nv_bs_cd ,
                                                                          INPUT uwm100.name1,
                                                                          INPUT uwm100.name2,
                                                                          INPUT uwm100.name3,
                                                                          OUTPUT nv_error).
                                                      /*End by Chaiyong W. A65-0150 09/06/2022-----*/
                                                  END.
                                              END.
                                              IF nv_error <> "" THEN LEAVE loop_c101.
                                              IF uwm101.chr2 <> "0000000000"
                                                   /*---Begin by Chaiyong W. A68-0034 12/03/2025*/
                                                  AND uwm100.ltstatus <> "Y"
                                                   /*End by  Chaiyong W. A68-0034 12/03/2025----*/ 
                                                    THEN DO:
                                                 FIND FIRST stat.vat100 USE-INDEX vat10002 WHERE 
                                                    vat100.policy = uwm100.policy AND
                                                    vat100.trnty1 = n_trty1i      AND
                                                    vat100.refno  = uwm101.chr2   AND 
                                                    vat100.cancel = NO NO-LOCK NO-ERROR.
                                                 IF NOT AVAIL stat.vat100 THEN DO:
                                                     nv_error = "RefDocNo." + uwm101.chr2 + " ไม่มีข้อมูลใบเสร็จใบกำกับภาษีที่บัญชี".
                                                 END.
                                                 ELSE DO: 
                                                     n_tot = vat100.totamt + vat100.vatamt.
                                                     loop_vat100:
                                                     FOR EACH bvat100 USE-INDEX vat10002
                                                          WHERE bvat100.policy  = vat100.policy
                                                          AND   bvat100.invold  = vat100.invoice
                                                          AND   bvat100.cancel  = NO    NO-LOCK.
                                               
                                                         IF bvat100.invtyp = "B"  THEN NEXT loop_vat100. 
                                                         IF bvat100.invtyp = "C" THEN n_prvamt2 = (bvat100.totamt * (-1)) + (bvat100.vatamt * (-1)).
                                                         ELSE                         n_prvamt2 = bvat100.totamt + bvat100.vatamt.
                                                         n_prvamt  = n_prvamt + n_prvamt2. 
                                                         n_tot = (vat100.totamt + vat100.vatamt) + n_prvamt.
                                                     END.
                                                     IF n_tot + (uwm101.prem_i + uwm101.pstp_i + uwm101.pfee_i + uwm101.ptax_i + uwm101.rstp_i + uwm101.rfee_i + uwm101.rtax_i) < 0 THEN DO:
                                                         nv_error = "RefDocNo." + uwm101.chr2 + " สลักหลังเบี้ยลบยอดเงินเกินใบเสร็จใบกำกับภาษีที่บัญชี".
                                                     END.
                                                 END.  
                                              END.
                                              IF nv_error <> "" THEN LEAVE loop_c101.
                                          END.
                                    END.
                                    IF nv_error = "" THEN nv_transfer = "transfer".
                                END.
                                ELSE DO:
                                   nv_error = "กรมธรรม์: " + uwm100.policy +  " Mark flag งาน Installment ไม่ถูกต้อง ".
            
                               END.
                            END.
                        END.
                        /*End A67-0025*/
                   END.
                   /*End Add Jiraphon P. A65-0123*/

               END.
           END.
       END.
       /*----Begin by Chaiyong W. A65-0185 05/08/2022*/
       IF nv_code1 <> "" AND nv_error = "" AND  nv_transfer <> "transfer" THEN DO:
           nv_error = "Error Not Transfer Vat!!!".
       END.
       /*End by Chaiyong W. A65-0185 05/08/2022------*/

       /*ELSE nv_transfer = "Complete".*/
    END.
END PROCEDURE.

PROCEDURE pd_cacm001:
    DEF VAR nv_trnty1 AS CHAR INIT "".
    def var nv_prem   as deci init 0.
    def var nv_comm   as deci init 0.
    def var nv_stamp  as deci init 0.
    def var nv_fee    as deci init 0.
    def var nv_tax    AS deci init 0.
    DEF VAR nv_netamt AS DECI INIT 0.

    IF sic_bran.uwm100.docno1 <> "" THEN DO:
       
        ASSIGN
            nv_prem     =  uwm100.prem_t                 
            nv_comm     =  uwm100.com1_t + uwm100.com2_t 
           /*nv_comm     =  uwm100.com1_t + uwm100.com2_t */                             /*comment by Kridtiya i. A64-0199 Date. 16/10/2021*/  
            nv_comm     =  uwm100.com1_t + uwm100.com2_t + uwm100.com3_t + uwm100.com4_t  /*Add by Kridtiya i. A64-0199 Date. 16/10/2021*/ 
            nv_stamp    =  uwm100.pstp   + uwm100.rstp_t 
            nv_fee      =  uwm100.pfee   + uwm100.rfee_t 
            nv_tax      =  uwm100.ptax   + uwm100.rtax_t 
            nv_netamt   =  nv_prem       + nv_comm        +  nv_stamp    + nv_fee  + nv_tax     .
        nv_trnty1 = IF nv_netamt >= 0 THEN
                      IF uwm100.dir_ri THEN "M"
                      ELSE "O"
                    ELSE IF uwm100.dir_ri THEN "R"
                    ELSE "T".   
        IF (nv_prem <= 0 AND nv_stamp <= 0 AND nv_tax <= 0)  AND nv_comm > 0 THEN  nv_trnty1  =  IF uwm100.dir_ri THEN "R"  ELSE "T".

        FIND sicsyac.acm001 USE-INDEX acm00101 WHERE 
             acm001.trnty1 = nv_trnty1    AND
             acm001.docno  = uwm100.docno1 NO-LOCK NO-ERROR .
        IF AVAIL acm001 THEN DO:
            nv_error = "Policy " + uwm100.policy + " Document No. already on Account Master file acm001: " + acm001.docno.
        END.
        ELSE DO:
            FIND sicsyac.acm002 USE-INDEX acm00201 WHERE 
                 acm002.trnty1 = nv_trnty1    AND
                 acm002.docno  = uwm100.docno1 NO-LOCK NO-ERROR .
            IF AVAIL acm002 THEN DO:
                nv_error = "Policy " + uwm100.policy + " Document No. already on Account Master file acm002: " + acm002.docno.
            END.
            /*--
            ELSE DO:
        comment by Chaiyong W. A68-0034 18/04/2025*/
        /*---Begin by Chaiyong W. A68-0034 18/04/2025*/
        END.
    END. // End uwm100.docno1 <> ""
    IF nv_error = "" THEN DO:
        /*End by Chaiyong W. A68-0034 18/04/2025-----*/
            IF uwm100.instot > 1 THEN DO:
                loop_uwm101:
                FOR EACH sic_bran.uwm101 WHERE uwm101.policy = uwm100.policy AND
                                      uwm101.rencnt = uwm100.rencnt AND
                                      uwm101.endcnt = uwm100.endcnt 
                    
                                      /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                      AND
                                      uwm101.bchyr  = uwm100.bchyr  AND
                                      uwm101.bchno  = uwm100.bchno  AND
                                      uwm101.bchcnt = uwm100.bchcnt 
                                      /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                    
                    NO-LOCK BY uwm101.instno:
                    /*---Begin by Chaiyong W. A65-0253 24/04/2023*/
                    IF  sic_bran.uwm101.prem_i <> 0 OR sic_bran.uwm101.com1_i <> 0 OR sic_bran.uwm101.com2_i <> 0 OR
                        sic_bran.uwm101.pstp_i <> 0 OR sic_bran.uwm101.pfee_i <> 0 OR sic_bran.uwm101.ptax_i <> 0 OR
                        sic_bran.uwm101.rstp_i <> 0 OR sic_bran.uwm101.rfee_i <> 0 OR sic_bran.uwm101.rtax_i <> 0 THEN DO:
                        ASSIGN
                            nv_deci = 0
                            nv_deci = DECI(uwm101.docnoi) NO-ERROR.
                        IF nv_deci = 0 THEN DO:
                            nv_error = "Please Reprint Debit or Vat Again" + STRING(uwm101.instno).
                            LEAVE loop_uwm101.
                        END.
                    END.
                    ELSE NEXT loop_uwm101.
                    /*End by Chaiyong W. A65-0253 24/04/2023-----*/
                    ASSIGN
                        nv_trnty1   =  ""
                        nv_prem     =  0
                        nv_comm     =  0
                        nv_stamp    =  0
                        nv_fee      =  0
                        nv_tax      =  0
                        nv_netamt   =  0
                        nv_prem     =  uwm101.prem_i                   
                        nv_comm     =  uwm101.com1_i + uwm101.com2_i   
                        /*nv_comm     =  uwm101.com1_i + uwm101.com2_i   */                          /*comment by Kridtiya i. A64-0199 Date. 16/10/2021*/
                        nv_comm     =  uwm101.com1_i + uwm101.com2_i + uwm101.com3_i + uwm101.com4_i /*Add by Kridtiya i. A64-0199 Date. 16/10/2021*/  
                        nv_stamp    =  uwm101.pstp_i + uwm101.rstp_i   
                        nv_fee      =  uwm101.pfee_i + uwm101.rfee_i   
                        nv_tax      =  uwm101.ptax_i + uwm101.rtax_i   
                        nv_netamt   =  nv_prem       + nv_comm        +  nv_stamp    + nv_fee  + nv_tax     .
                    nv_trnty1 = IF nv_netamt >= 0 THEN
                                  IF uwm100.dir_ri THEN "M"
                                  ELSE "O"
                                ELSE IF uwm100.dir_ri THEN "R"
                                ELSE "T".   
                    IF (nv_prem <= 0 AND nv_stamp <= 0 AND nv_tax <= 0)  AND nv_comm > 0 THEN  nv_trnty1  =  IF uwm100.dir_ri THEN "R"  ELSE "T".
                    FIND sicsyac.acm001 USE-INDEX acm00101 WHERE 
                         acm001.trnty1 = nv_trnty1      AND
                         acm001.docno  = uwm101.docnoi NO-LOCK NO-ERROR .
                    IF AVAIL acm001 THEN DO:
                        nv_error = "Policy " + uwm100.policy + " Document No. already on Account Master file acm001: " + acm001.docno.
                        LEAVE loop_uwm101.
                    END.
                    ELSE DO:
                        FIND sicsyac.acm002 USE-INDEX acm00201 WHERE 
                             acm002.trnty1 = nv_trnty1     AND
                             acm002.docno  = uwm101.docnoi NO-LOCK NO-ERROR .
                        IF AVAIL acm002 THEN DO:
                            nv_error = "Policy " + uwm100.policy + " Document No. already on Account Master file acm002: " +  acm002.docno.
                            LEAVE loop_uwm101.
                        END.
                    END.


                END.
            END.
          
        END.
     /*--
    END.
    END.  comment end by Chaiyong W. A68-0034 18/04/2025*/
END PROCEDURE.
PROCEDURE pd_cuwm601:
    IF sic_bran.uwm100.cn_no <> 0 THEN DO:
        FIND sicuw.uwm601 USE-INDEX uwm60101 WHERE uwm601.cn_no = uwm100.cn_no NO-LOCK NO-ERROR.
        IF AVAIL uwm601 THEN DO:
            if TRIM(uwm601.policy) <> "" AND uwm601.policy <> uwm100.policy THEN DO:
                nv_error = 
                    "Cannot update Cover Note " +  string(uwm100.cn_no,"99999999") + " details to Cover Notes file uwm601" + CHR(13) +
                    "from Policy " + uwm100.policy  + " Ren./Endt. count " + string(uwm100.rencnt,">9/")  + string(uwm100.endcnt,"999") + CHR(13) + 
                    "because Policy " + uwm601.policy + "already present. Underwriting dept." + chr(13) + "please investigate.".
            END.
        END.
    END.
END PROCEDURE.
PROCEDURE pd_cxmm026:
    DEF VAR t_sigr AS DECI INIT 0.
    FIND FIRST  sicsyac.xmm026 use-index xmm02601 where 
                xmm026.usrtyp = substring(nv_user,1,2) AND
                xmm026.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR.
    IF AVAIL xmm026 THEN DO:
        IF uwm100.prem_t * uwm100.curate < 0  THEN DO:
            if uwm100.prem_t * uwm100.curate * ( -1 ) > xmm026.ref_lt THEN DO:
                nv_error = "Over Premium Refund Limit on Policy Limits per User Type xmm026".
            END.
        END.
        ELSE IF uwm100.prem_t * uwm100.curate > xmm026.pr_lt THEN DO:
            nv_error = "Over your Premium Limit on Policy Limits per User Type xmm026".
        END.
        IF nv_error = "" THEN DO:
            t_sigr = 0.
            FOR EACH sic_bran.uwm120  use-index uwm12002 where uwm120.policy = uwm100.policy and
                                                      uwm120.rencnt = uwm100.rencnt AND
                                                      /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                                       
                                                      uwm120.bchyr  = uwm100.bchyr  AND
                                                      uwm120.bchno  = uwm100.bchno  AND
                                                      uwm120.bchcnt = uwm100.bchcnt AND              
                                                      /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                                                      uwm120.rskdel = no NO-LOCK:
                t_sigr = t_sigr + uwm120.sigr.
            END.                              
            IF  t_sigr > xmm026.si_lt THEN 
                nv_error = "Exceeds your SI Limit on Policy Limits Per User Type xmm026".
        END.
    END.
END PROCEDURE.
PROCEDURE pd_cuwm200:
    DEF VAR nv_per AS DECI INIT 0.

    /* 11/03/2568 เพิ่มเช็ค FIND FIRST uwm200 สำหรับงานที่ไม่มี allocate by sombat*/
    FIND FIRST sic_bran.uwm200 USE-INDEX uwm20001 WHERE
               sic_bran.uwm200.policy = sic_bran.uwm100.policy AND
               sic_bran.uwm200.rencnt = sic_bran.uwm100.rencnt AND
               sic_bran.uwm200.endcnt = sic_bran.uwm100.endcnt 
    NO-LOCK NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm200 THEN RETURN.
    /* 11/03/2568 สิ้นสุด FIND FIRST uwm200 สำหรับงานที่ไม่มี allocate by sombat*/

    loop_for200:
    FOR EACH sic_bran.uwm200 USE-INDEX uwm20001 WHERE
        uwm200.policy = sic_bran.uwm100.policy AND
        uwm200.rencnt = sic_bran.uwm100.rencnt AND
        uwm200.endcnt = sic_bran.uwm100.endcnt 
        /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
        AND    
        uwm200.bchyr  = uwm100.bchyr  AND
        uwm200.bchno  = uwm100.bchno  AND
        uwm200.bchcnt = uwm100.bchcnt           
        /*End by Chaiyong W. A67-0202 19/12/2024-----*/  
        
        NO-LOCK:
        IF trim(uwm200.rico) = "OVER" OR TRIM(uwm200.rico) = "" THEN DO:
            nv_error = "Policy No : " +  uwm100.policy + " พบ allocate Code Over กรุณาตรวจสอบข้อมูลอีกครั้ง".
            IF nv_error <> "" THEN LEAVE loop_for200.
        END.

        /*---
              /*Add by krittapoj S. A65-0248 21/09/2022 */
        ELSE IF (uwm200.csftq = "F" AND uwm200.c_no = 0) THEN DO:
            nv_error = "Policy No : " + uwm100.policy + " โอนงานไม่ได้Allocate Fac: cession No = 0 ".
            LEAVE loop_for200.
        END.
        
        
        /*End by krittapoj S. A65-0248 21/09/2022*/
        comment by Chaiyong W. A67-0202 19/12/2024*/
        
        /*Add A64-0380*/
        ELSE IF uwm200.csftq = "T" THEN DO:
            IF substring(uwm100.poltyp,1,2) = "C9" THEN DO:
                nv_date = ?.
                nv_date = IF uwm100.poltyp = "C90" THEN uwm100.accdat ELSE uwm100.comdat.
                RUN wuw\wuwetr225(INPUT  uwm100.policy , 
                                  INPUT  uwm100.rencnt , 
                                  INPUT  uwm100.endcnt ,
                                  INPUT  YEAR(nv_date) ,
                                  INPUT  nv_date ,
                                  INPUT  uwm200.rico   ,    
                                  OUTPUT nv_rip1  ,                
                                  OUTPUT nv_rip2  ,                
                                  OUTPUT nv_rip1ae,                
                                  OUTPUT nv_rip2ae,             
                                  OUTPUT nv_error  , /*Message Error*/
                                  OUTPUT nv_treaty_yr).

                IF nv_error <> "" THEN DO:
                    nv_error = "Policy No : " + uwm100.policy + " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูล " + " " + uwm200.rico + " " + nv_error.
                    LEAVE loop_for200.
                END.
                IF nv_rip1 <> uwm200.rip1 THEN DO:
                    nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ %Commission1 RI Treaty ไม่ตรงกับพารามิเตอร์ : " + uwm200.rico + " " + STRING(nv_rip1) + "<>" + STRING(uwm200.rip1).
                END.
                IF nv_error <> "" THEN LEAVE loop_for200.
                IF nv_rip2 <> uwm200.rip2 THEN DO:
                    nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ %Commission2 RI Treaty ไม่ตรงกับพารามิเตอร์ : " + uwm200.rico + " " + STRING(nv_rip2) + "<>" + STRING(uwm200.rip2).
                END.
                IF nv_error <> "" THEN LEAVE loop_for200. 
            END.
        END.
        /*End A64-0380*/
        /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
        IF nv_sces_no = 0 AND (uwm200.csftq = "F" AND uwm200.c_no = 0) THEN DO:
            nv_sces_no = 1.
        END.               
        /*End by Chaiyong W. A67-0202 19/12/2024-----*/








        //FIND FIRST sic_bran.uwd200 WHERE RECID(uwd200) = uwm200.fptr01 NO-LOCK NO-ERROR. comment by Chaiyong W. A67-0202 19/12/2024*/
        FIND  sic_bran.uwd200 WHERE RECID(uwd200) = uwm200.fptr01 NO-LOCK NO-ERROR. /*--add by Chaiyong W. A67-0202 19/12/2024*/


        IF AVAIL uwd200 THEN DO:
            IF uwd200.policy <> uwm100.policy  THEN nv_error = "Policy No : " + uwm100.policy + " โอนงานไม่ได้ ติดต่อ Helpdesk (Policy Allocate)".
            ELSE IF uwd200.rencnt <> uwm100.rencnt  THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง rencnt Allo : " +  string(uwd200.rencnt,"999") + " <> " + string(uwm100.rencnt,"999").
            ELSE IF uwd200.endcnt <> uwm100.endcnt  THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง endcnt Allo : " +  string(uwd200.endcnt,"999") + " <> " + string(uwm100.endcnt,"999").
            ELSE IF uwd200.rico   <> uwm200.rico    THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง code   Allo : " +  string(uwd200.rico  ,"999") + " <> " + string(uwm200.rico  ,"999").
                                                                                                                                                                   
            /*IF nv_crisk2 < uwd200.riskno THEN nv_crisk2   = uwd200.riskno .*/
        END.                                                                                                                                                       
        ELSE DO:
            IF nv_error <> "" THEN LEAVE loop_for200.
            IF uwm200.fptr01 <> 0 THEN nv_error = "Policy No : " +  uwm100.policy + " Rico " + uwm200.rico + " โอนงานไม่ได้ ให้วนงานอีกครั้งนึง".
            IF nv_error <> "" THEN LEAVE loop_for200.
        END.
    END.
    IF nv_error = "" THEN DO:
        /*--new*/

        /*---
        loop_120s:
        FOR EACH  sic_bran.uwm120  WHERE  uwm120.policy  = uwm100.policy  AND
                                 uwm120.rencnt  = uwm100.rencnt  AND
                                 uwm120.endcnt  = uwm100.endcnt  NO-LOCK:
            nv_per = 0.
            FOR EACH sic_bran.uwd200 USE-INDEX uwd20001 WHERE
                     uwd200.policy = uwm120.policy AND
                     uwd200.rencnt = uwm120.rencnt AND
                     uwd200.endcnt = uwm120.endcnt AND
                     uwd200.riskno = uwm120.riskno NO-LOCK:
                nv_per = nv_per + uwd200.risi_p.
            END.
        comment by Chaiyong W. A67-0202 19/12/2024*/
        /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
        loop_120s:
        FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
                   uwm120.policy = uwm100.policy AND
                   uwm120.rencnt = uwm100.rencnt AND
                   uwm120.endcnt = uwm100.endcnt AND 
                   uwm120.bchyr  = uwm100.bchyr  AND
                   uwm120.bchno  = uwm100.bchno  AND
                   uwm120.bchcnt = uwm100.bchcnt NO-LOCK :


            nv_per = 0.
            FOR EACH sic_bran.uwd200 USE-INDEX uwd20001 WHERE
                     uwd200.policy = uwm120.policy AND
                     uwd200.rencnt = uwm120.rencnt AND
                     uwd200.endcnt = uwm120.endcnt AND
                     uwd200.riskno = uwm120.riskno AND 
                     uwd200.bchyr  = uwm100.bchyr  AND
                     uwd200.bchno  = uwm100.bchno  AND
                     uwd200.bchcnt = uwm100.bchcnt NO-LOCK:
                nv_per = nv_per + uwd200.risi_p.
            END.
       /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
           
            IF nv_per <> 0 AND nv_per <> 100 THEN DO:
                 nv_error = "Policy No : " +  uwm100.policy  + " โอนงานไม่ได้ Allocate ติดปัญหา ให้วนงานอีกครั้งนึง".
                 LEAVE loop_120s.
            END.
        END.
    END.
END PROCEDURE.
PROCEDURE pd_cuwm304:  
    DEF VAR  nv_cfptr AS RECID INIT ?.

    /*11/03/2568 เพิ่มเช็ค Find first uwm304 ที่ไม่ใช่งาน fire, all risk by sombat */
    FIND FIRST sic_bran.uwm304 USE-INDEX  uwm30401 WHERE
               sic_bran.uwm304.policy  =  sic_bran.uwm100.policy and
               sic_bran.uwm304.rencnt  =  sic_bran.uwm100.rencnt and
               sic_bran.uwm304.endcnt  =  sic_bran.uwm100.endcnt 
    NO-LOCK NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm304 THEN RETURN.
    /*11/03/2568 end Find first uwm304 ที่ไม่ใช่งาน fire by sombat */

    loop_304:
    FOR EACH sic_bran.uwm304 USE-INDEX  uwm30401 WHERE
       uwm304.policy  =  sic_bran.uwm100.policy and
       uwm304.rencnt  =  sic_bran.uwm100.rencnt and
       uwm304.endcnt  =  sic_bran.uwm100.endcnt 
       
        /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
        AND
        uwm304.bchyr  = uwm100.bchyr  AND
        uwm304.bchno  = uwm100.bchno  AND
        uwm304.bchcnt = uwm100.bchcnt 
       /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
        
        NO-LOCK BY uwm304.riskgp BY uwm304.riskno:
        nv_cfptr = uwm304.fptr02.
        IF  nv_cfptr <> 0 AND nv_cfptr <> ? THEN DO:
            DO while nv_cfptr <> 0 and uwm304.fptr02 <> ? :
                FIND sic_bran.uwd141 where recid(uwd141) = nv_cfptr NO-LOCK NO-ERROR.
                if available uwd141 then do: 
                    IF uwm304.rencnt <> uwd141.rencnt OR uwm304.endcnt <> uwd141.endcnt THEN
                        nv_error = "Policy No. " + uwm100.policy + " Cannot Release Pointer Block Not Available" + 
                                  " Please Contact Helpdesk (1)".
                    ELSE IF uwm304.riskgp  <> uwd141.riskgp OR uwm304.riskno <> uwd141.riskno THEN
                        nv_error = "Policy No. " + uwm100.policy + " Cannot Release Pointer Block Not Available" + 
                                  " Please Contact Helpdesk (2)" .
                    IF nv_error <> "" THEN LEAVE loop_304.
                    nv_cfptr = uwd141.fptr.
                END.
                ELSE nv_cfptr = 0.
            END.
        END.
        ELSE nv_cfptr = 0.
    END.
END PROCEDURE.
PROCEDURE pd_cuwm130:
    DEF VAR nv_found  AS LOGICAL INIT NO.
    DEF VAR nv_iprem  AS DECI    INIT 0.

    loop_for130:
    FOR EACH sic_bran.uwm130 USE-INDEX uwm13001 WHERE 
             uwm130.policy  = sic_bran.uwm100.policy  AND
             uwm130.rencnt  = sic_bran.uwm100.rencnt  AND
             uwm130.endcnt  = sic_bran.uwm100.endcnt  
             /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
             AND
             uwm130.bchyr  = uwm100.bchyr  AND
             uwm130.bchno  = uwm100.bchno  AND
             uwm130.bchcnt = uwm100.bchcnt 
             /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
        
        
        
        NO-LOCK:
        nv_found  = YES.
        IF uwm130.riskgp  <> 0 OR uwm130.riskno = 0 OR uwm130.itemno = 0 THEN DO:
            nv_error =  "Not Release " + uwm100.policy + "(uwm130) Risk Group " + string(uwm130.riskgp) + " Risk No. " + string(uwm130.riskno) + " Item No. " + string(uwm130.itemno) .
            LEAVE loop_for130.
        END.
        
        //FIND FIRST sic_bran.uwd132 WHERE RECID(uwd132) = uwm130.fptr03 NO-LOCK NO-ERROR. comment by Chaiyong W. A67-0202 19/12/2024*/

        FIND sic_bran.uwd132 WHERE RECID(uwd132) = uwm130.fptr03 NO-LOCK NO-ERROR. /*--add by Chaiyong W. A67-0202 19/12/2024*/
        IF AVAIL uwd132 THEN DO:                  
            IF uwd132.policy <> uwm130.policy  THEN nv_error = "Policy No : "  + uwm100.policy  +  " โอนงานไม่ได้ ติดต่อ Helpdesk (Policy)".
            ELSE IF uwd132.rencnt <> uwm130.rencnt  THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง rencnt : " + string(uwd132.rencnt,"999") + " <> " +  string(uwm130.rencnt,"999").
            ELSE IF uwd132.endcnt <> uwm130.endcnt  THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง endcnt : " + string(uwd132.endcnt,"999") + " <> " +  string(uwm130.endcnt,"999").
            ELSE IF uwd132.riskgp <> uwm130.riskgp  THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง riskgp : " + string(uwd132.riskgp,"999") + " <> " +  string(uwm130.riskgp,"999").
            ELSE IF uwd132.riskno <> uwm130.riskno  THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง riskno : " + string(uwd132.riskno,"999") + " <> " +  string(uwm130.riskno,"999").
            ELSE IF uwd132.itemno <> uwm130.itemno  THEN nv_error = "Policy No : " +  uwm100.policy +  " โอนงานไม่ได้ กรุณาตรวจสอบข้อมูลอีกครั้ง itemno : " + string(uwd132.itemno,"999") + " <> " +  string(uwm130.itemno,"999").
            IF nv_error <> "" THEN LEAVE loop_for130.
        END.
        ELSE DO:                                  
            nv_error = "Policy No : " +  uwm100.policy + " R/I " + STRING(uwm130.riskno,"999") + "/" + STRING(uwm130.itemno,"999") + " โอนงานไม่ได้ ให้วนงานอีกครั้งนึง".
            LEAVE loop_for130.
        END. 
        IF (sicsyac.xmm031.dept = "G" OR sicsyac.xmm031.dept = "M") AND (sic_bran.uwm130.uom8_v <> 0 OR sic_bran.uwm130.uom9_v <> 0)  THEN DO:
            IF (uwm130.uom8_v <> 0 AND uwm130.uom9_v = 0) OR
               ( uwm130.uom8_v = 0 AND uwm130.uom9_v <> 0) THEN DO:
                nv_error = "Policy " + uwm100.policy + " " + STRING(uwm100.rencnt,"999") + "/" + string(uwm100.endcnt,"999") + "ใส่ความคุ้มครอง พรบ. ไม่ครบ โปรดตรวจเช็คก่อน Release to Account".
                LEAVE loop_for130.
            END.
            FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE
                       uwm301.policy = uwm130.policy  AND
                       uwm301.rencnt = uwm130.rencnt  AND
                       uwm301.endcnt = uwm130.endcnt  AND 
                       uwm301.riskno = uwm130.riskno  AND
                       uwm301.itemno = uwm130.itemno 
                       /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                       AND
                       uwm301.bchyr  = uwm100.bchyr  AND
                       uwm301.bchno  = uwm100.bchno  AND
                       uwm301.bchcnt = uwm100.bchcnt 
                       /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                NO-LOCK NO-ERROR.
            IF AVAIL uwm301 THEN DO:
                /*--
                 FIND FIRST stat.Detaitem USE-INDEX detaitem01 WHERE
                 comment by Chaiyong W. A65-0185 26/08/2022*/
                FIND FIRST brstat.Detaitem USE-INDEX detaitem01 WHERE /*--add by Chaiyong W. A65-0185 26/08/2022*/
                          Detaitem.Policy = uwm301.Policy AND
                          Detaitem.RenCnt = uwm301.RenCnt AND
                          Detaitem.EndCnt = uwm301.Endcnt AND
                          Detaitem.RiskNo = uwm301.RiskNo AND
                          Detaitem.ItemNo = uwm301.ItemNo NO-LOCK NO-ERROR.
                 IF NOT AVAIL Detaitem THEN DO:
                     nv_error = "Policy " + uwm100.policy + " " + STRING(uwm100.rencnt,"999") + "/" + string(uwm100.endcnt,"999") +
                         " R/I " +  STRING(uwm301.riskno,"999") +  "/" + STRING(uwm301.itemno) + CHR(13) +  
                         "มีความคุ้มครอง พรบ. แต่เบอร์ sticker ไม่มี" + CHR(13) + 
                         "โปรดตรวจเช็คก่อน Release to Account".
                     LEAVE loop_for130.
                 END.
                 ELSE DO: 
                     IF Detaitem.serailno = "" THEN DO:
                         nv_error = "Policy " + uwm100.policy + " " + STRING(uwm100.rencnt,"999") + "/" + string(uwm100.endcnt,"999") +
                         " R/I " +  STRING(uwm301.riskno,"999") +  "/" + STRING(uwm301.itemno) + CHR(13) +  
                         "มีความคุ้มครอง พรบ. แต่เบอร์ sticker ไม่มี" + CHR(13) + 
                         "โปรดตรวจเช็คก่อน Release to Account".
                         LEAVE loop_for130.
                     END.
                 END.
                 /*Add Kridtiya i. A64-0199 Date. 16/10/2021 check vehreg */
                 IF sic_bran.uwm301.vehreg <> "" THEN DO:
                     nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                     IF substring(nv_vehreg,1,1) = "/" OR substring(nv_vehreg,1,1) = "\" THEN DO:
                     END.
                     ELSE IF LENGTH(nv_vehreg) > 3 THEN DO:
                         nv_vehreg = TRIM(SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 1)). /*2 Position*/
                         IF SUBSTR(nv_vehreg,1,1) >= "ก" AND  SUBSTR(nv_vehreg,1,1) <= "ฮ" AND
                             SUBSTR(nv_vehreg,2,1) >= "ก" AND  SUBSTR(nv_vehreg,2,1) <= "ฮ" THEN DO:
                             nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                             nv_vehreg = SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 2,1).
                             IF nv_vehreg = " " THEN DO:
                                 nv_vehreg = TRIM(sic_bran.uwm301.vehreg).
                                 nv_vehreg = TRIM(SUBSTR(nv_vehreg,LENGTH(nv_vehreg) - 2)).
                                 FIND FIRST sicuw.uwm500 USE-INDEX uwm50001 WHERE             
                                     sicuw.uwm500.prov_n = nv_vehreg NO-LOCK NO-ERROR.
                                 IF NOT AVAIL sicuw.uwm500 THEN DO: 
                                     nv_error = "กรุณาตรวจสอบทะเบียนรถ เช่น รหัสย่อจังหวัด !!! " + sic_bran.uwm301.vehreg  + CHR(13) + 
                                         "โปรดตรวจเช็คก่อน Release to Account".
                                     LEAVE loop_for130.
                                 END.
                             END.
                             ELSE DO:
                                 nv_error = "กรุณาตรวจสอบทะเบียนรถ เช่น รหัสย่อจังหวัด !!! " + sic_bran.uwm301.vehreg  + CHR(13) + 
                                     "โปรดตรวจเช็คก่อน Release to Account".
                                 LEAVE loop_for130.
                             END.
                         END.
                     END. /*substring(nv_vehreg,1,1) = "/"*/
                 END.  /* Add Kridtiya i. A64-0199 Date. 16/10/2021 vehreg */
            END.  
            ELSE DO:
                nv_error = "Policy "  + uwm100.policy + " " + STRING(uwm100.rencnt,"999") + "/" + string(uwm100.endcnt,"999") + CHR(13) + 
                     STRING(uwm130.riskno,"999") + "/" + STRING(uwm130.itemno,"999")  + CHR(13) + 
                     "ไม่พบข้อมูล หน้าเบี้ย(uwm301) ติดต่อComputer".
                LEAVE loop_for130.
            END.
        END.         
    END.
    IF nv_found  = NO THEN DO:
         nv_error = "Policy "  + uwm100.policy + " " + STRING(uwm100.rencnt,"999") + "/" + string(uwm100.endcnt,"999") + CHR(13) + 
                     "ไม่พบข้อมูล หน้าเบี้ย(uwm130) ติดต่อComputer".
    END.
    ELSE IF nv_error = "" THEN DO:
        ASSIGN
            nv_found = NO
            nv_iprem = 0.
        loop_132:
        FOR EACH  sic_bran.uwd132  WHERE  uwd132.policy  = uwm100.policy  AND
                                 uwd132.rencnt  = uwm100.rencnt  AND
                                 uwd132.endcnt  = uwm100.endcnt
                                 /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                AND
                                uwd132.bchyr  = uwm100.bchyr  AND
                                uwd132.bchno  = uwm100.bchno  AND
                                uwd132.bchcnt = uwm100.bchcnt 
                                /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
        
            
            NO-LOCK:
            nv_found = YES.
            nv_iprem  = nv_iprem  + uwd132.prem_c.
            IF uwd132.riskgp <> 0 OR uwd132.riskno = 0 OR uwd132.itemno = 0 THEN DO:
                nv_error = "Not Release " + uwm100.policy                              + CHR(13) +
                                        "(uwd132) Risk Group " + string(uwd132.riskgp) + CHR(13) +
                                        " Risk No. " + string(uwd132.riskno)           + CHR(13) +
                                        " Item No. " + string(uwd132.itemno) .
                LEAVE loop_132.
            END.

        END.
        IF nv_found  = NO THEN DO:                                   
             nv_error = "Policy "  + uwm100.policy + " " + STRING(uwm100.rencnt,"999") + "/" + string(uwm100.endcnt,"999") + CHR(13) + 
                     "ไม่พบข้อมูล หน้าเบี้ย(uwmd132) ติดต่อComputer".
        END.
        /*-- Str Add A64-0405 --*/
        ELSE IF uwm100.prem_t <> nv_iprem THEN DO:
             nv_error = "Policy " + uwm100.policy + " Premium " + STRING(uwm100.prem_t) + 
                 " (uwm100) not equal Insured Item " + STRING(nv_iprem) + " (uwd132)".
        END.
        /*-- End Add A64-0405 --*/
    END.

END PROCEDURE.

PROCEDURE pd_c120:
    def var nv_rprem  as deci    init 0 .
    def var nv_rstp   as deci    init 0 .
    def var nv_rtax   as deci    init 0 .
    def var nv_rcom   as deci    init 0 .
    DEF VAR nv_found  AS LOGICAL INIT NO.
    ASSIGN
        nv_rprem   = 0
        nv_rstp    = 0
        nv_rtax    = 0
        nv_rcom    = 0
        nv_found   = NO.
    loop_for120:
    FOR EACH  sic_bran.uwm120  WHERE  uwm120.policy  = sic_bran.uwm100.policy  AND
                             uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                             uwm120.endcnt  = sic_bran.uwm100.endcnt
                              /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                             AND
                             uwm120.bchyr  = sic_bran.uwm100.bchyr  AND
                             uwm120.bchno  = sic_bran.uwm100.bchno  AND
                             uwm120.bchcnt = sic_bran.uwm100.bchcnt 
                             /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
        NO-LOCK:
        nv_found  = YES.
        ASSIGN
            nv_rprem  = nv_rprem  + uwm120.prem_r
            nv_rstp   = nv_rstp   + uwm120.rstp_r
            nv_rtax   = nv_rtax   + uwm120.rtax_r
            /*nv_rcom   = nv_rcom   + uwm120.com1_r + uwm120.com2_r.*/                              /*comment by Kridtiya i. A64-0199 Date. 16/10/2021*/
            nv_rcom   = nv_rcom   + uwm120.com1_r + uwm120.com2_r  + uwm120.com3_r + uwm120.com4_r. /*Add by Kridtiya i. A64-0199 Date. 16/10/2021*/ 
        IF uwm120.riskgp <> 0  OR uwm120.riskno = 0    THEN DO:
            nv_error = "Not Release " + uwm100.policy  + " (uwm120) Risk Group " + string(uwm120.riskgp) + " Risk No. " + string(uwm120.riskno).
            LEAVE loop_for120.
        END.
    END.
    IF nv_found = NO THEN DO:
        nv_error = "Policy "  + uwm100.policy + " " + STRING(uwm100.rencnt,"999") + "/" + string(uwm100.endcnt,"999") + CHR(13) + 
                     "ไม่พบข้อมูล หน้าเบี้ย(uwm120) ติดต่อComputer".
    END.
    ELSE IF nv_error = "" THEN DO:
        IF uwm100.prem_t  <> nv_rprem  THEN 
            nv_error  = "Premium Policy (uwm100) not equal Risk (uwm120) "  + uwm100.policy + " " + STRING(uwm100.prem_t) + " " + STRING(nv_rprem).  
        ELSE IF uwm100.rstp_t  <> nv_rstp  THEN
            nv_error  = "Stamp  Policy (uwm100) not equal Risk (uwm120) "  + uwm100.policy + " " + STRING(uwm100.rstp_t) + " " + STRING(nv_rstp). 
        ELSE IF uwm100.rtax_t  <> nv_rtax THEN
            nv_error  = "Tax Policy (uwm100) not equal Risk (uwm120) "  + uwm100.policy + " " + STRING(uwm100.rtax_t) + " " + STRING(nv_rtax).
        /*ELSE IF (uwm100.com1_t + uwm100.com2_t)  <> nv_rcom  THEN*/ /*comment by Kridtiya i. A64-0199 Date. 16/10/2021*/
        ELSE IF (uwm100.com1_t + uwm100.com2_t + uwm100.com3_t + uwm100.com4_t)  <> nv_rcom  THEN  /*Add Kridtiya i. A64-0199 Date. 16/10/2021*/
            nv_error  = "Commission Policy (uwm100) not equal Risk (uwm120) "  
                        + uwm100.policy + " " + STRING((uwm100.com1_t + uwm100.com2_t + uwm100.com3_t + uwm100.com4_t)) + " " + STRING(nv_rcom).
    END.
END PROCEDURE.     

PROCEDURE pd_cuwm100:


    def var  n_branch  as char init "".   
    def var  n_dept    as char init "".   
    def var  n_poltyp  as char init "".   
    def var  n_domoff  as char init "".   
    def var  n_io      as char init "".   
    def var  n_region  as char init "".   
    DEF VAR  nv_icno   AS CHAR INIT "". /*---add by Chaiyong W. A66-0255 19/01/2024*/
    DEF VAR  n_mesag   AS CHAR INIT "". /*---add by Chaiyong W. A66-0255 19/01/2024*/

    DEF VAR n_classchk AS CHAR.    /*--add by Chaiyong W. A67-0202 23/12/2024*/
    DEF VAR n_classtyp AS CHAR.    /*--add by Chaiyong W. A67-0202 23/12/2024*/


    IF sic_bran.uwm100.trndat > TODAY THEN nv_error = "Transaction Date Over System Date "  + uwm100.policy + " " +  string(uwm100.trndat,"99/99/9999").
    ELSE IF uwm100.sigr_p < 0 THEN nv_error = "Si Total >= 0". /*---add by Chaiyong W. A66-0255 19/01/2024*/
    ELSE IF uwm100.insref = "" OR uwm100.insref = "." THEN DO:
        nv_error = "Policy " +  uwm100.policy +  " Code Insurance is Blank or point." + CHR(13) + "Can't Releas to Account".
    END.
    ELSE IF uwm100.drn_p = NO OR (uwm100.sch_p = NO AND SUBSTR(uwm100.policy,1,2) <> "IW") THEN DO:
        IF  uwm100.sch_p = NO THEN nv_error = "Policy is not print ("  + TRIM(uwm100.policy) + ")" + CHR(13) +  "Can't Releas to Account".
        ELSE nv_error = "Debit Note is not print (" + TRIM(uwm100.policy) + ")" + CHR(13) + "Can't Releas to Account".

        IF nv_progid = "WGWGEQ70" THEN nv_error = "". /*---add by Chaiyong W. A65-0185 21/07/2022*/
    END.
    ELSE IF uwm100.agent  = "" OR uwm100.agent = "." OR
            uwm100.acno1  = "" OR uwm100.acno1 = "." THEN DO:
        nv_error =  "Policy " + uwm100.policy + " Code Agent,Producer is Blank or Point" + CHR(13) + "Can't Releas to Account".
    END.
    ELSE IF  (uwm100.acno1  = "B300100" OR
              uwm100.acno1  = "B3V0100" OR
              uwm100.acno1  = "B3K0100" OR
              uwm100.acno1  = "B3C0100" OR
              uwm100.acno1  = "B3V2100") AND uwm100.endcnt = 0 THEN DO:
         nv_error = "Policy " + uwm100.policy + " Code Producer is Sriprathom." + CHR(13) + "Can't Releas to Account".
    END.
    ELSE IF  (uwm100.agent  = "B300100" OR
              uwm100.agent  = "B3V0100" OR
              uwm100.agent  = "B3K0100" OR
              uwm100.agent  = "B3C0100" OR
              uwm100.agent  = "B3V2100") AND uwm100.endcnt = 0 THEN DO:
         nv_error = "Policy " + uwm100.policy + " Code Agent is Sriprathom." + CHR(13) + "Can't Releas to Account".
    END.
    ELSE IF uwm100.poltyp = "" THEN DO:
        nv_error = "Policy " + uwm100.policy + " Poltyp. is Blank or Point" + CHR(13) + "Can't Releas to Account".
    END.
    ELSE IF uwm100.prem_t <> 0 OR uwm100.com1_t <> 0 OR uwm100.com2_t <> 0 OR
            uwm100.pstp   <> 0 OR uwm100.pfee   <> 0 OR uwm100.ptax   <> 0 OR
            uwm100.rstp_t <> 0 OR uwm100.rfee_t <> 0 OR uwm100.rtax_t <> 0 
            OR uwm100.com3_t <> 0 OR uwm100.com4_t <> 0 /*---add by Chaiyong W. A68-0034 04/03/2025*/
        
        THEN DO:
        IF uwm100.instot = 1 THEN DO: /*--add end by Chaiyong W. A68-0034 17/03/2025*/
            nv_deci = 0. /*--add by Chaiyong W. 19/01/2024*/
            nv_deci = DECI(uwm100.docno1) NO-ERROR.
            IF nv_deci = 0 THEN nv_error = "Dr/Cr not print  " + uwm100.policy + " " + uwm100.docno1.
            ELSE IF LENGTH(uwm100.docno1) <> 7 AND LENGTH(uwm100.docno1) <> 10 THEN DO:
                nv_error = "Policy: " +  TRIM(uwm100.policy) + " เลขที่ใบแจ้งหนี้ต้องเป็น 7 หรือ 10 ตัวอักษร".
            END.
        END. /*--add end by Chaiyong W. A68-0034 17/03/2025*/
        /*---Begin by Chaiyong W. A68-0034 13/05/2025*/
         IF sic_bran.uwm100.instot > 1 THEN DO:
            loop_docno101:
            FOR EACH sic_bran.uwm101 USE-INDEX uwm10101 /*--add index by Chaiyong W. A65-0253 30/06/2023*/
                WHERE 
                     uwm101.policy   = uwm100.policy and
                     uwm101.rencnt   = uwm100.rencnt and
                     uwm101.endcnt   = uwm100.endcnt AND    
                     uwm101.bchyr    = uwm100.bchyr  AND
                     uwm101.bchno    = uwm100.bchno  AND
                     uwm101.bchcnt   = uwm100.bchcnt NO-LOCK BY uwm101.instno:
                IF  uwm101.prem_i <> 0 OR uwm101.com1_i <> 0 OR uwm101.com2_i <> 0 OR
                    uwm101.pstp_i <> 0 OR uwm101.pfee_i <> 0 OR uwm101.ptax_i <> 0 OR
                    uwm101.rstp_i <> 0 OR uwm101.rfee_i <> 0 OR uwm101.rtax_i <> 0 
                    OR uwm101.com3_i <> 0 OR uwm101.com4_i <> 0  
                    
                    THEN DO:
                    ASSIGN
                        nv_deci = 0
                        nv_deci = DECI(uwm101.docnoi) NO-ERROR.
           
                    IF nv_deci = 0 THEN DO: 
                        nv_error = "Dr/Cr not print  " + uwm101.policy + " " + uwm101.docnoi. 
                        LEAVE loop_docno101.
                    END.
                    ELSE IF LENGTH(uwm101.docnoi) <> 7 AND LENGTH(uwm101.docnoi) <> 10 THEN DO:
                        nv_error = "Policy: " +  TRIM(uwm100.policy) + " เลขที่ใบแจ้งหนี้ต้องเป็น 7 หรือ 10 ตัวอักษร".
                        LEAVE loop_docno101.
                    END.

                END.
            END.    
        END.
        /*End by Chaiyong W. A68-0034 13/05/2025-----*/



    END.

     /*----Begin by Chaiyong W. A67-0068 07/08/2024*/
     /*nv_error = "". 
     IF uwm100.endcnt > 0 THEN DO:      commnet by krittapoj S. A67-0068 31/10/2024*/
     IF uwm100.endcnt > 0 AND nv_error = "" THEN DO: /*--add by krittapoj S. A67-0068 31/10/2024*/
         RUN wuw\wuwvecdck(INPUT   "CGW"          , //nv_type
                           input   ?              , //nv_rec100 
                           input   ?              , //nv_rec120 
                           input   uwm100.poltyp  ,
                           input   uwm100.endcod  ,
                           INPUT   ""             , //nv_langug
                           input   ""             , //nv_class
                           input   ""             , //nv_oth1
                           input   ""             , //nv_oth2
                           output  nv_error       , //nv_des 
                           output  nv_error       , //nv_out  
                           output  nv_error       ).
         nv_error = TRIM(nv_error).
         IF nv_error <> "" THEN DO:
              nv_error = "Policy No : " +  uwm100.policy + " โอนงานไม่ได้ เนื่องจาก " +  nv_error.
         END.
     END.
    
     /*End by Chaiyong W. A67-0068 07/08/2024------*/









    /*Add A67-0025*/
    IF nv_error = "" AND (uwm100.prem_t = 0 AND ((uwm100.ptax + uwm100.rtax_t <> 0) OR (uwm100.pstp + uwm100.rstp_t <> 0))) THEN DO:
        nv_error =  "ไม่สามารถโอนกรมธรรม์ได้ Premium = 0 " + "Stamp = " + STRING(uwm100.pstp + uwm100.rstp_t) + " VAT = " + STRING(uwm100.ptax + uwm100.rtax_t).
    END.
    /*End A67-0025*/
    /*--
    IF uwm100.expdat < uwm100.comdat THEN
         nv_error =  "Policy " + uwm100.policy + " Expiry Date < Com Date " + CHR(13) + "Can't Releas to Account". /*Add Kridtiya i. A64-0199 Date. 16/10/2021*/
    comment by Chaiyong W. A66-0011 09/02/2023*/

    /*---Begin by Chaiyong W. A66-0011 19/01/2023*/
    IF nv_error = "" THEN DO:
        IF uwm100.prem_t <> 0 OR uwm100.com1_t <> 0 OR uwm100.com2_t <> 0 OR
          uwm100.pstp    <> 0 OR uwm100.pfee   <> 0 OR uwm100.ptax   <> 0 OR
          uwm100.rstp_t  <> 0 OR uwm100.rfee_t <> 0 OR uwm100.rtax_t <> 0 THEN DO:
          
        END.
        ELSE IF uwm100.code1 <> "" THEN DO:
            nv_error = "Policy No : " +  uwm100.policy + "Status Print Vat: Y แต่จำนวนเงิน = 0".
        END.
        IF uwm100.poltyp <> "C90" AND nv_error = "" THEN DO:
            IF uwm100.comdat = ? OR uwm100.expdat = ? THEN nv_error = "Policy No : " +  uwm100.policy + " วันที่คุ้มครองต้องไม่เป็นค่าว่าง".
            ELSE IF uwm100.comdat > uwm100.expdat THEN nv_error = "Policy No : " +  uwm100.policy + " วันที่สิ้นสุดน้อยกว่าวันที่เริ่มต้นคุ้มครอง".
        END.
        ELSE IF nv_error = "" THEN DO:
            IF uwm100.accdat = ? THEN nv_error = "Policy No : " +  uwm100.policy + " กรุณาตรวจสอบวันที่".
                /*
            ELSE IF uwm100.endcnt = 0 THEN DO:
                IF year(uwm100.accdat) > (YEAR(uwm100.entdat) + 1) OR
                   year(uwm100.accdat) < (YEAR(uwm100.entdat) - 1)  THEN nv_error = "Policy No : " +  uwm100.policy + " กรุณาตรวจสอบวันที่".
            END.
            ELSE DO:*/
                IF year(uwm100.accdat) > (YEAR(TODAY) + 1) OR
                   year(uwm100.accdat) < (YEAR(TODAY) - 1)  THEN nv_error = "Policy No : " +  uwm100.policy + " กรุณาตรวจสอบวันที่".
                    /*
            END.  */
        END.



        IF nv_error = "" THEN DO:
            IF trim(uwm100.name1) = "" OR trim(uwm100.insref) = "" THEN nv_error = "Policy No : " +  uwm100.policy + " กรมฯ ต้องมีชื่อเจ้าของกรมธรรม์".
            //ELSE IF trim(uwm100.addr1) + trim(uwm100.addr2) + trim(uwm100.addr3) + trim(uwm100.addr4) = "" THEN nv_error = "Policy No : " +  uwm100.policy + " กรมฯ ต้องมีที่อยู่ของเจ้าของกรมธรรม์". /*--16/02/2024 A66-0255*/
            /*--
            IF nv_Error = "" THEN DO:
                FIND sic_bran.xmm600 WHERE xmm600.acno = uwm100.insref NO-LOCK NO-ERROR.
                IF NOT AVAIL xmm600 THEN nv_error = "Policy No : " +  uwm100.policy + " ไม่พบ Insure Code " + uwm100.insref +  " ในฐานข้อมูลกรุณาครวจสอบ".
            END.
            
            
            Because Job Web if xmm600 or not xmm600 but when transfer to premium uwm100 create xmm600
            
            comment by Chaiyong W. A65-0253 30/03/2023*/

            /*----Begin by Chaiyong W. A66-0255 07/12/2023*/
            //FIND sic_bran.xmm600 WHERE sic_bran.xmm600.acno = sic_bran.uwm100.insref NO-LOCK NO-ERROR. comment by Chaiyong W. A67-0202 19/12/2024*/ 
            FIND FIRST sic_bran.xmm600 USE-INDEX xmm60001  WHERE sic_bran.xmm600.acno = sic_bran.uwm100.insref NO-LOCK NO-ERROR. /*--add by Chaiyong W. A67-0202 19/12/2024*/ 
            IF  AVAIL sic_bran.xmm600 THEN nv_icno = xmm600.icno.
            nv_icno = TRIM(nv_icno).
            IF nv_icno = "" OR nv_icno = ? THEN nv_icno = sic_bran.uwm100.icno .
            nv_error = "".
            RUN whp\whpcicno3(INPUT  nv_icno ,
                             INPUT   sic_bran.uwm100.insref,
                             INPUT  nv_progid  ,
                             INPUT  RECID(sic_bran.uwm100)   ,
                             INPUT  sic_bran.uwm100.poltyp   ,
                             INPUT  sic_bran.uwm100.policy, 
                             INPUT  "GW",
                             INPUT  "",
                             INPUT  "",
                             OUTPUT n_mesag ,
                             OUTPUT nv_error)     .

            /*End by Chaiyong W. A66-0255 07/12/2023------*/

        END.
        IF uwm100.endcnt = 0 AND nv_error = "" THEN DO:
            IF uwm100.prem_t < 0 THEN nv_error  = "Policy No : " +  uwm100.policy + " ต้นกรมฯ เบี้ยต้องไม่ติดลบ".
            ELSE DO:
                FIND FIRST sic_bran.uwm120 WHERE uwm120.policy = uwm100.policy AND
                                        uwm120.rencnt = uwm100.rencnt AND
                                        uwm120.endcnt = uwm100.endcnt AND
                                        uwm120.riskno = 1 
                                        /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                        AND
                                        uwm120.bchyr  = uwm100.bchyr  AND
                                        uwm120.bchno  = uwm100.bchno  AND
                                        uwm120.bchcnt = uwm100.bchcnt 
                                        /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                    
                    NO-LOCK NO-ERROR.
                IF AVAIL uwm120 THEN DO:
                    IF trim(uwm120.CLASS) = "" THEN nv_error = "Policy No : " +  uwm100.policy +  " Not Found Class".
                    ELSE DO:
                        FIND FIRST sic_bran.uwm130 WHERE uwm130.policy = uwm120.policy AND 
                                                uwm130.rencnt = uwm120.rencnt AND
                                                uwm130.endcnt = uwm120.endcnt AND
                                                uwm130.riskno = uwm120.riskno AND
                                                uwm130.itemno = 1 
                                                /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                                AND
                                                uwm130.bchyr  = uwm100.bchyr  AND
                                                uwm130.bchno  = uwm100.bchno  AND
                                                uwm130.bchcnt = uwm100.bchcnt 
                                                /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                            
                            NO-LOCK NO-ERROR.
                        IF AVAIL uwm130 THEN DO:
            
                        END.
                        ELSE  nv_error = "Policy No : " +  uwm100.policy +  " ไม่พบ ทุนประกันของ Item ที่ 1".
                    END.
                END.
                ELSE nv_error = "Policy No : " +  uwm100.policy +  " ไม่พบ Business Class Risk ที่ 1".
            END.
        END.
        ELSE IF nv_Error = "" THEN DO:
             FIND FIRST sic_bran.uwm120 WHERE uwm120.policy = uwm100.policy AND
                                     uwm120.rencnt = uwm100.rencnt AND
                                     uwm120.endcnt = uwm100.endcnt 
                                     /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                     AND
                                     uwm120.bchyr  = uwm100.bchyr  AND
                                     uwm120.bchno  = uwm100.bchno  AND
                                     uwm120.bchcnt = uwm100.bchcnt 
                                     /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
                 
                 
                 NO-LOCK NO-ERROR.
             IF AVAIL uwm120 THEN DO:
                 IF trim(uwm120.CLASS) = "" THEN nv_error = "Policy No : " +  uwm100.policy +  " Not Found Class".
                 ELSE DO:
                     /*--
                     FIND FIRST uwm130 WHERE uwm130.policy = uwm120.policy AND 
                                             uwm130.rencnt = uwm120.rencnt AND
                                             uwm130.endcnt = uwm120.endcnt NO-LOCK NO-ERROR.
                     IF AVAIL uwm130 THEN DO:
                         IF uwm120.riskno <> uwm130.riskno THEN nv_error = "Policy No : " +  uwm100.policy +  "First Riskno <> First Itemno ".
                     END.
                     ELSE nv_error = "Policy No : " +  uwm100.policy +  "Not Found uwm130".
                          */
                 END.
             END.
              ELSE nv_error = "Policy No : " +  uwm100.policy +  " ไม่พบ Business Class".
        
        END.
    END.
    /*End by Chaiyong W. A66-0011 19/01/2023-----*/
    /*---Begin by Chaiyong W. A66-0255 19/01/2024*/
    IF sic_bran.uwm100.poltyp >= "V70" AND sic_bran.uwm100.poltyp <= "V74" AND nv_error = "" THEN DO:
         FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
                                                             sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
                                                             sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt 
                                                             /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                                             AND
                                                             uwm301.bchyr  = uwm100.bchyr  AND
                                                             uwm301.bchno  = uwm100.bchno  AND
                                                             uwm301.bchcnt = uwm100.bchcnt 
                                                             /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
             
             NO-LOCK NO-ERROR.
         IF NOT AVAIL sic_bran.uwm301 THEN nv_error = "Policy No : " +  sic_bran.uwm100.policy + " ไม่พบข้อมูลรถยนต์".
     END.
    /*End by Chaiyong W. A66-0255 19/01/2024-----*/
    /*---
    /*Add A67-0181*/
    IF sic_bran.uwm100.poltyp >= "V72" AND sic_bran.uwm100.poltyp <= "V74" AND nv_error = "" THEN DO:
        FOR EACH sic_bran.uwm120 WHERE sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
                                       sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
                                       sic_bran.uwm120.endcnt = 0
                                       /*---Begin by Chaiyong W. A67-0202 19/12/2024*/
                                       AND
                                       uwm120.bchyr  = uwm100.bchyr  AND
                                       uwm120.bchno  = uwm100.bchno  AND
                                       uwm120.bchcnt = uwm100.bchcnt 
                                       /*End by Chaiyong W. A67-0202 19/12/2024-----*/ 
             
            
            NO-LOCK.
    
            IF SUBSTRING(sic_bran.uwm120.class,1,1) >= "0" AND SUBSTRING(sic_bran.uwm120.class,1,1) <= "9" THEN DO:
                IF SUBSTRING(sic_bran.uwm120.class,LENGTH(sic_bran.uwm120.class)) = "E" THEN DO:
                    nv_error = "โปรดตรวจสอบรหัสรถ " + sic_bran.uwm120.CLASS + " " + string(sic_bran.uwm120.riskno).
                END.
            END.
        END.
    END.
    /*End A67-0181*/
    comment by Chaiyong W. A67-0202 20/12/2024*/
    /*---Begin by Chaiyong W. A67-0202 20/12/2024*/
    IF sic_Bran.uwm100.poltyp >= "V72" AND sic_Bran.uwm100.poltyp <= "V74" AND nv_error = "" THEN DO:
        IF sic_Bran.uwm100.polsta <> "CA" THEN DO: 
            IF sic_Bran.uwm100.endcnt = 0 THEN DO:
                FIND LAST sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
                    uwm120.policy = uwm100.policy AND 
                    uwm120.rencnt = uwm100.rencnt AND
                    uwm120.endcnt = uwm100.endcnt AND
                    uwm120.bchyr  = uwm100.bchyr  AND
                    uwm120.bchno  = uwm100.bchno  AND
                    uwm120.bchcnt = uwm100.bchcnt NO-LOCK NO-ERROR.
                IF AVAIL uwm120 THEN DO:
                    IF SUBSTRING(uwm120.class,1,1) >= "0" AND SUBSTRING(uwm120.class,1,1) <= "9" THEN DO:
                        IF SUBSTRING(uwm120.class,LENGTH(uwm120.class)) = "E" THEN DO:
                            RUN WUW\wuwpuzpdt(INPUT  TODAY     ,
                                                          INPUT  "Form_Print"  ,
                                                          INPUT  ""            ,
                                                          INPUT  "COMPULSORY"  ,
                                                          INPUT  sic_bran.uwm120.class  ,
                                                          OUTPUT n_classchk    ,
                                                          OUTPUT n_classtyp    ).
                            IF  n_classchk  <> "Y" THEN nv_error = "โปรดตรวจสอบรหัสรถ " + uwm120.CLASS + " risk " + string(uwm120.riskno).
                        END.
                    END.
                END.
            END.
            ELSE DO:
                FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
                    uwm120.policy = uwm100.policy AND 
                    uwm120.rencnt = uwm100.rencnt AND
                    uwm120.endcnt = uwm100.endcnt AND
                    uwm120.bchyr  = uwm100.bchyr  AND
                    uwm120.bchno  = uwm100.bchno  AND
                    uwm120.bchcnt = uwm100.bchcnt NO-LOCK NO-ERROR.
                IF AVAIL uwm120 THEN DO:
    
                    FIND LAST buwm120 USE-INDEX uwm12001 WHERE 
                        buwm120.policy = uwm100.policy AND 
                        buwm120.rencnt = uwm100.rencnt AND
                        buwm120.endcnt = uwm100.endcnt AND
                        buwm120.bchyr  = uwm100.bchyr  AND
                        buwm120.bchno  = uwm100.bchno  AND
                        buwm120.bchcnt = uwm100.bchcnt NO-LOCK NO-ERROR.
                    IF AVAIL buwm120 THEN DO:
                        IF uwm120.riskno <> buwm120.riskno THEN DO:
                            IF uwm120.CLASS <> buwm120.CLASS THEN DO:
                                IF SUBSTRING(buwm120.class,1,1) >= "0" AND SUBSTRING(buwm120.class,1,1) <= "9" THEN DO:
                                    IF SUBSTRING(buwm120.class,LENGTH(buwm120.class)) = "E" THEN DO:
                                        RUN WUW\wuwpuzpdt(INPUT  TODAY     ,
                                                          INPUT  "Form_Print"  ,
                                                          INPUT  ""            ,
                                                          INPUT  "COMPULSORY"  ,
                                                          INPUT  buwm120.class  ,
                                                          OUTPUT n_classchk    ,
                                                          OUTPUT n_classtyp    ).
                                        IF  n_classchk  <> "Y" THEN nv_error = "โปรดตรวจสอบรหัสรถ " + buwm120.CLASS + " risk " + string(buwm120.riskno).
                                    END.
                                END.
                            END.
                        END.
                    END.
                END.
            END.
        END.
    END.
    /*End by Chaiyong W. A67-0202 20/12/2024-----*/


    IF nv_error = "" THEN DO:
        /*---
        RUN wuw\wuwcpapl1(INPUT RECID(uwm100) ,
                         INPUT uwm100.acno1  , 
                         INPUT uwm100.agent  , 
                         INPUT uwm100.dealer , /*- finance -*/
                         INPUT uwm100.finint , /*- dealer -*/ 
                         INPUT "all"         , /*- FIELD  Chk -*/
                         INPUT "1"           ,  
                         OUTPUT n_mesag      ,
                         OUTPUT nv_error    ).*/
    END.
    IF nv_error = "" THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = uwm100.acno1 NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN DO:
            FIND sicsyac.xmm022 USE-INDEX xmm02201 WHERE xmm022.acccod = sicsyac.xmm600.acccod NO-LOCK NO-WAIT NO-ERROR.
            IF NOT AVAIL xmm022 THEN DO:
                FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL xmm090 THEN DO:
                    IF xmm090.glref <> "0" THEN DO:
                        nv_error = "Policy Release cannot find GL Debtor Control A/C No. xmm022".
                    END.
                END.
            END.
            IF nv_error <> "" THEN DO:
                FIND FIRST sicsyac.xmm090 NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL xmm090 THEN DO:
                    n_branch  = IF xmm090.brsep  THEN  uwm100.branch ELSE "".
                    n_dept    = IF xmm090.depsep THEN  uwm100.dept   ELSE "".
                    n_poltyp  = IF xmm090.polsep THEN  uwm100.poltyp ELSE "".
                    n_io      = "I". 
                    IF NOT xmm090.dosep  THEN n_domoff = "" .
                    ELSE DO:
                      find first sicsyac.xmm024 no-lock no-error.
                      n_domoff = if uwm100.cntry = xmm024.bascty then "D" else "O".
                    END. 
    
                    FIND sicsyac.xmm011 USE-INDEX xmm01101 WHERE xmm011.cntry = sicsyac.xmm600.cntry NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL xmm011 THEN n_region = xmm011.region.
                    ELSE n_region = "".
                    FIND   sicsyac.xmm202 USE-INDEX xmm20201 WHERE
                      xmm202.branch = n_branch      AND
                      xmm202.dept   = n_dept        AND
                      xmm202.poltyp = n_poltyp      AND
                      xmm202.domoff = n_domoff      AND
                      xmm202.in_out = n_io          AND
                      xmm202.dir_ri = uwm100.dir_ri AND
                      xmm202.region = n_region      NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAIL xmm202 THEN DO:
                        IF xmm090.glref <> "0" THEN DO:
                            nv_error = "Policy Release cannot find GL Debtor Control A/C No. xmm022_2".
                        END.
                    END.
                    
                END.
            END.
        END.
       

        

    END.
    
END PROCEDURE.
PROCEDURE pd_uzot0983:
    DEF INPUT PARAMETER nv_insref AS CHAR  INIT "".
    DEF INPUT PARAMETER nv_bs_cd  AS CHAR  INIT "".
    DEF INPUT PARAMETER nv_name1  AS CHAR  INIT "".
    DEF INPUT PARAMETER nv_name2  AS CHAR  INIT "".
    DEF INPUT PARAMETER nv_name3  AS CHAR  INIT "".
    DEF OUTPUT PARAMETER nv_err AS CHAR INIT "".
    DEF VAR nv_xmm600 AS CHAR INIT "".
    DEF VAR nv_brins  AS CHAR INIT "".
    DEF VAR nv_taxno  AS CHAR INIT "".
    nv_err = "".
    IF SUBSTRING(nv_insref,1,4) <> "COMP"    AND
                  nv_insref      <> "WMC0001" THEN DO:
         IF nv_bs_cd <> "" THEN DO:
             nv_xmm600 = nv_bs_cd.
             RUN pd_xmm600(INPUT nv_xmm600,INPUT nv_bs_cd,OUTPUT nv_taxno,OUTPUT nv_brins).
             IF  nv_brins = "" OR nv_taxno = "" THEN DO: 
                 IF (LENGTH(nv_xmm600) = 7  AND  SUBSTR(nv_xmm600,2,1) = "C") OR
                     (LENGTH(nv_xmm600) = 10 AND  SUBSTR(nv_xmm600,3,1) = "C") THEN DO: 
                     nv_err = "Code Insure/Code Vat not brins / taxno".
                 END.
             END.
         END.
         ELSE DO:
             nv_xmm600 = nv_insref.
             RUN pd_xmm600(INPUT nv_xmm600,INPUT nv_bs_cd,OUTPUT nv_taxno,OUTPUT nv_brins).
             IF  nv_brins = "" OR nv_taxno = "" THEN DO: 
                 IF (LENGTH(nv_xmm600) = 7  AND  SUBSTR(nv_xmm600,2,1) = "C") OR
                     (LENGTH(nv_xmm600) = 10 AND  SUBSTR(nv_xmm600,3,1) = "C") THEN DO: 
                     IF  INDEX(nv_name1,"และ/หรือ") <> 0 OR  
                         INDEX(nv_name2,"และ/หรือ") <> 0 OR 
                         INDEX(nv_name3,"และ/หรือ") <> 0   THEN DO:
                         nv_err = " Branch No. or Tax ID. Not Blank(และ/หรือ)...".
                     END. /*
                     ELSE nv_err = "Policy No : " +  sic_bran.uwm100.policy +  " Branch No. or Tax ID. Not Blank...". /*--add by Chaiyong W. A66-0011 19/01/2023*/*/
                 END.
                 /*
                 IF nv_taxno = "" AND nv_err = "" THEN nv_err = "Policy No : " +  sic_bran.uwm100.policy +  " Tax ID. Not Blank...". /*--add by Chaiyong W. A66-0011 19/01/2023*/
                 */
             END.
         END.
     END.
     ELSE DO:
         IF nv_insref = "COMP"    OR
            nv_insref = "WMC0001" THEN DO:
            
         END.
         IF nv_bs_cd <> "WMC0001" AND
            nv_bs_cd <> "COMP"    AND
            nv_bs_cd <> ""        THEN DO: 
              nv_xmm600 = nv_bs_cd.
              RUN pd_xmm600(INPUT nv_xmm600,INPUT nv_bs_cd,OUTPUT nv_taxno,OUTPUT nv_brins).
         END.
         IF  nv_brins = "" OR nv_taxno = "" THEN DO: 
             IF (LENGTH(nv_xmm600) = 7  AND  SUBSTR(nv_xmm600,2,1) = "C") OR
                 (LENGTH(nv_xmm600) = 10 AND  SUBSTR(nv_xmm600,3,1) = "C") THEN DO: 
                 nv_err = "Code Insure/Code Vat not brins / taxno".
             END.
         END.
     END.
END PROCEDURE.
PROCEDURE pd_xmm600:
    DEF INPUT  parameter nv_xmm600 AS CHAR INIT "".
    DEF INPUT  parameter nv_bs_cd  AS CHAR INIT "".
    DEF output parameter nv_brnins AS CHAR INIT "".
    DEF output parameter nv_taxno  AS CHAR INIT "".



    FIND FIRST sic_bran.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno  = nv_xmm600 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xmm600 THEN DO:
        IF (xmm600.naddr1 = "" AND xmm600.naddr2 = "" AND
            xmm600.naddr3 = "" AND xmm600.naddr4 = "") OR 
            nv_xmm600     = nv_bs_cd              THEN DO :
            ASSIGN                                         
                nv_brnins = xmm600.anlyc5 
                nv_taxno  = xmm600.icno.                   
        END.
        ELSE DO:
            ASSIGN
                nv_brnins = TRIM(SUBSTRING(xmm600.anlyc1,20,5))
                nv_taxno  = TRIM(SUBSTRING(xmm600.anlyc1,1,14)) NO-ERROR . 
        END.
    END.
END PROCEDURE.
