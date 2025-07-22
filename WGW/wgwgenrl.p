/*=================================================================*/
/* Program Name : wgwgenrl  Gen. Data vat To DB Premium            */
/* Assign  No   : A59-0312                                         */
/* CREATE  By   : Chaiyong W. A59-0312 07/07/2016                  */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/* Modify By : Jiraphon P. A62-0286  Date : 17/06/2019 
             : แก้ไข Program ID (uwm100.prog)  ให้กำหนด program id 
               ตามงานที่ผ่าน On-web , Web-service , Outsource      */
/*=================================================================*/
DEF SHARED VAR n_User   AS CHAR.        
DEF INPUT PARAMETER nv_bchyr  AS INT.   
DEF INPUT PARAMETER nv_bchno  AS CHAR.  
DEF INPUT PARAMETER nv_bchcnt AS INT.   
DEF INPUT PARAMETER nv_policy AS CHAR.  
DEF INPUT PARAMETER nv_rencnt AS INT.   
DEF INPUT PARAMETER nv_endcnt AS INT.  
DEF VAR nv_batdt AS CHAR INIT "".
/*nv_batdt =  "wgwgen01" + "|" + STRING(nv_bchyr,"9999") + STRING(nv_bchno) + STRING(nv_bchcnt,"99") . comment Jiraphon P.*/
FIND sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
     sic_bran.uwm100.policy = nv_policy AND
     sic_bran.uwm100.rencnt = nv_rencnt AND
     sic_bran.uwm100.endcnt = nv_endcnt AND
     sic_bran.uwm100.bchyr  = nv_bchyr  AND
     sic_bran.uwm100.bchno  = nv_bchno  AND
     sic_bran.uwm100.bchcnt = nv_bchcnt NO-ERROR.
IF AVAIL sic_bran.uwm100 THEN DO:
    nv_batdt =  sic_bran.uwm100.prog + "|" + STRING(nv_bchyr,"9999") + STRING(nv_bchno) + STRING(nv_bchcnt,"99") . /*Jiraphon P. A62-0286*/
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
         sicuw.uwm100.policy = sic_bran.uwm100.Policy AND
         sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt AND
         sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF sicuw.uwm100.prog   = nv_batdt THEN DO:                                              
            FIND FIRST sicuw.uwm120 USE-INDEX uwm12001 WHERE sicuw.uwm120.policy = sicuw.uwm100.policy NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm120 THEN DO:
                FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE sicuw.uwm130.policy = sicuw.uwm120.policy NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm130 THEN DO:
                    sic_bran.uwm100.releas = YES.
                END.
            END.
        END.
    END.
END.
RELEASE sic_bran.uwm100 NO-ERROR.
