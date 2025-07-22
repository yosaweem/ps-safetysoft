/*=================================================================*/
/* Program Name : wGwGen05.P   Gen. Data Uwd132 To DB Premium      */
/* Assign  No   : A54-0005                                         */
/* CREATE  By   : Amparat C.           (Date 23/12/2010)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/* MOdify  By   : Amparat C.   A56-0141        (Date 15/07/2013)   */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/*                ค้นหา Insure จาก xmm600  ถ้าเจอ Create ตาม xmm600*/
/*                ถ้าไม่เจอ Create ตาม uwm100                      */
/* MOdify  By   : Lukkana M.   A56-0298        Date : 08/10/2013   */
/*                แก้ฟิลด์ที่เก็บ icno เนื่องจากดึงผิดฟิลด์ จากที่ */
/*                ระบุไว้เป็น anam2 มาเป็น anam1                   */ 
/* Modify  By   : Lukkana M.   A56-0357        Date : 26/11/2013   */
/*                ขยายformat icno จาก 13 เป็น 14 หลัก และเพิ่มช่อง */
/*                รหัสสาขา                                         */
/* Modify By : Porntiwa P.  A57-0096-1  (Date 20-06-2014) 
               ปรับนำเข้าตาม renew and endorse count               */
/* Modify BY : Porntiwa P.  A58-0064   Date : 16/02/2015           
               เพิ่มเติมการ Update Tel. เข้า sicsyac               */  
/*Modify By        : Kridtiya i. A60-0157 เพิ่มรหัสไปรษณีย์             */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Kridtiya i. A65-0141 Date. 09/08/2022 add field firstname ,lastname.....*/
/*Modify by   : Chaiyong W. A65-0185 28/09/2022 Change loop add vat code */
/*Modify by  : Chaiyong W. A66-0048 21/03/2023 Cut postcode addr4        */
/*Modify by  : Chaiyong W. A65-0253 25/04/2023 Add time check Error      */
/*Modify by  : Chaiyong W. A66-0221 16/11/2023 Add Check Log             */
/*Modify by  : Chaiyong W. A67-0066 16/01/2025 Add Check Log             */
/*Database connect : SICSYAC; SICUW; SICCL; STAT ;GW_SAFE - LD SIC_BRAN ; GW_STAT -LD BRSTAT*/
/*=================================================================*/

DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

/*--- Comment A57-0096-01 --
FIND sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
     sic_bran.uwm100.policy = nv_policy AND
     sic_bran.uwm100.rencnt = 0         AND
     sic_bran.uwm100.endcnt = 0         AND
     sic_bran.uwm100.bchyr  = nv_bchyr  AND
     sic_bran.uwm100.bchno  = nv_bchno  AND
     sic_bran.uwm100.bchcnt = nv_bchcnt NO-LOCK NO-ERROR.
--- End Comment A57-0096-01 ---*/
FIND sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
     sic_bran.uwm100.policy = nv_policy AND
     sic_bran.uwm100.rencnt = nv_rencnt AND
     sic_bran.uwm100.endcnt = nv_endcnt AND
     sic_bran.uwm100.bchyr  = nv_bchyr  AND
     sic_bran.uwm100.bchno  = nv_bchno  AND
     sic_bran.uwm100.bchcnt = nv_bchcnt NO-LOCK NO-ERROR.
IF AVAIL sic_bran.uwm100 THEN DO:


    /*---Begin by Chaiyong W. A65-0185 08/09/2022*/
    IF sic_bran.uwm100.insref <> "COMP" THEN RUN pd_xmm600(INPUT sic_bran.uwm100.insref).
    IF sic_bran.uwm100.bs_cd  <> "" AND sic_bran.uwm100.bs_cd <> "COMP" THEN RUN pd_xmm600(INPUT sic_bran.uwm100.bs_cd).
    /*End by Chaiyong W. A65-0185 08/09/2022-----*/
   /*--
   IF sic_bran.uwm100.insref <> "COMP" THEN DO:   

      /*---STR Amparat C. A56-0141 ---*/
      FIND FIRST sic_bran.xmm600 USE-INDEX xmm60001 WHERE
                 sic_bran.xmm600.acno = sic_bran.uwm100.insref NO-LOCK NO-ERROR.
      IF AVAIL sic_bran.xmm600 THEN DO:
         FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                    sicsyac.xmm600.acno = sic_bran.xmm600.acno  NO-ERROR NO-WAIT.
         IF NOT AVAIL sicsyac.xmm600 THEN DO:
            CREATE sicsyac.xmm600.   /*---Create ใหม่เท่านั้น--*/     
            ASSIGN
                sicsyac.xmm600.acno     = sic_bran.xmm600.acno       /*Account no*/                                            
                sicsyac.xmm600.gpstcs   = sic_bran.xmm600.gpstcs     /*Group A/C for statistics*/                           
                sicsyac.xmm600.gpage    = sic_bran.xmm600.gpage      /*Group A/C for ageing*/                                
                sicsyac.xmm600.gpstmt   = sic_bran.xmm600.gpstmt     /*Group A/C for Statement*/                             
                sicsyac.xmm600.or1ref   = sic_bran.xmm600.or1ref     /*OR Agent 1 Ref. No.*/                                 
                sicsyac.xmm600.or2ref   = sic_bran.xmm600.or2ref     /*OR Agent 2 Ref. No.*/                                 
                sicsyac.xmm600.or1com   = sic_bran.xmm600.or1com     /*OR Agent 1 Comm. %*/                                  
                sicsyac.xmm600.or2com   = sic_bran.xmm600.or2com     /*OR Agent 2 Comm. %*/                                  
                sicsyac.xmm600.or1gn    = sic_bran.xmm600.or1gn      /*OR Agent 1 Gross/Net*/                                
                sicsyac.xmm600.or2gn    = sic_bran.xmm600.or2gn      /*OR Agent 2 Gross/Net*/                                
                sicsyac.xmm600.ntitle   = sic_bran.xmm600.ntitle     /*Title for Name Mr/Mrs/etc*/                           
                sicsyac.xmm600.fname    = sic_bran.xmm600.fname      /*First Name*/                                          
                sicsyac.xmm600.name     = sic_bran.xmm600.name       /*Name Line 1*/                                         
                sicsyac.xmm600.abname   = sic_bran.xmm600.abname     /*Abbreviated Name*/                                    
                sicsyac.xmm600.icno     = sic_bran.xmm600.icno       /*IC No.*/         
                sicsyac.xmm600.addr1    = sic_bran.xmm600.addr1      /*Address line 1*/                                      
                sicsyac.xmm600.addr2    = sic_bran.xmm600.addr2      /*Address line 2*/                                      
                sicsyac.xmm600.addr3    = sic_bran.xmm600.addr3      /*Address line 3*/                                      
                sicsyac.xmm600.addr4    = sic_bran.xmm600.addr4      /*Address line 4*/                                      
                sicsyac.xmm600.postcd   = sic_bran.xmm600.postcd     /*Postal Code*/                                         
                sicsyac.xmm600.clicod   = sic_bran.xmm600.clicod     /*Client Type Code*/                                    
                sicsyac.xmm600.acccod   = sic_bran.xmm600.acccod     /*Account type code*/                                   
                sicsyac.xmm600.relate   = sic_bran.xmm600.relate     /*Related A/C for RI Claims*/                           
                sicsyac.xmm600.notes1   = sic_bran.xmm600.notes1     /*Notes line 1*/                                        
                sicsyac.xmm600.notes2   = sic_bran.xmm600.notes2     /*Notes line 2*/                                        
                sicsyac.xmm600.homebr   = sic_bran.xmm600.homebr     /*Home branch*/                                         
                sicsyac.xmm600.opened   = sic_bran.xmm600.opened     /*Date A/C opened*/                                     
                sicsyac.xmm600.prindr   = sic_bran.xmm600.prindr.    /*No. to print Dr/Cr N., default*/                      
            ASSIGN                                                                    
                sicsyac.xmm600.langug   = sic_bran.xmm600.langug     /*Language Code*/                                         
                sicsyac.xmm600.cshdat   = sic_bran.xmm600.cshdat     /*Cash terms wef date*/                                   
                sicsyac.xmm600.legal    = sic_bran.xmm600.legal      /*Legal action pending/closed*/                           
                sicsyac.xmm600.stattp   = sic_bran.xmm600.stattp     /*Statement type I/B/N*/                                  
                sicsyac.xmm600.autoap   = sic_bran.xmm600.autoap     /*Automatic cash matching*/                               
                sicsyac.xmm600.ltcurr   = sic_bran.xmm600.ltcurr     /*Credit limit currency*/                                 
                sicsyac.xmm600.ltamt    = sic_bran.xmm600.ltamt      /*Credit limit amount*/                                   
                sicsyac.xmm600.exec     = sic_bran.xmm600.exec       /*Executive responsible*/                                 
                sicsyac.xmm600.cntry    = sic_bran.xmm600.cntry      /*Country code*/                                          
                sicsyac.xmm600.phone    = sic_bran.xmm600.phone      /*Phone no.*/                                             
                sicsyac.xmm600.closed   = sic_bran.xmm600.closed     /*Date A/C closed*/                                       
                sicsyac.xmm600.crper    = sic_bran.xmm600.crper      /*Credit period*/                                         
                sicsyac.xmm600.pvfeq    = sic_bran.xmm600.pvfeq      /*PV frequency/Type code*/                                
                sicsyac.xmm600.comtab   = sic_bran.xmm600.comtab     /*Commission table no*/                                   
                sicsyac.xmm600.chgpol   = sic_bran.xmm600.chgpol     /*Allow N & A change on pol.Y/N*/                         
                sicsyac.xmm600.entdat   = sic_bran.xmm600.entdat     /*Entry date*/                                            
                sicsyac.xmm600.enttim   = sic_bran.xmm600.enttim     /*Entry time*/                                            
                sicsyac.xmm600.usrid    = sic_bran.xmm600.usrid      /*Userid*/                              
                sicsyac.xmm600.regagt   = sic_bran.xmm600.regagt     /*Registered agent code*/                                
                sicsyac.xmm600.agtreg   = sic_bran.xmm600.agtreg     /*Agents Registration/Licence No*/                       
                sicsyac.xmm600.debtyn   = sic_bran.xmm600.debtyn     /*Permit debtor trans Y/N*/                              
                sicsyac.xmm600.crcon    = sic_bran.xmm600.crcon      /*Credit Control Report*/                                
                sicsyac.xmm600.muldeb   = sic_bran.xmm600.muldeb     /*Multiple Debtors Acc.*/                                
                sicsyac.xmm600.styp20   = sic_bran.xmm600.styp20     /*Statistic Type Codes (4 x 20)*/                        
                sicsyac.xmm600.sval20   = sic_bran.xmm600.sval20     /*Statistic Value Codes (4 x 20)*/                       
                sicsyac.xmm600.dtyp20   = sic_bran.xmm600.dtyp20     /*Type of Date Codes (2 X 20)*/                          
                sicsyac.xmm600.dval20   = sic_bran.xmm600.dval20     /*Date Values (8 X 20)*/                                 
                sicsyac.xmm600.iblack   = sic_bran.xmm600.iblack     /*Insured Black List Code*/                              
                sicsyac.xmm600.oldic    = sic_bran.xmm600.oldic      /*Old IC No.*/                                           
                sicsyac.xmm600.cardno   = sic_bran.xmm600.cardno     /*Credit Card Account No.*/                              
                sicsyac.xmm600.cshcrd   = sic_bran.xmm600.cshcrd     /*Cash(C)/Credit(R) Agent*/                              
                sicsyac.xmm600.naddr1   = sic_bran.xmm600.naddr1     /*New address line 1*/                                   
                sicsyac.xmm600.gstreg   = sic_bran.xmm600.gstreg     /*GST Registration No.*/                                 
                sicsyac.xmm600.naddr2   = sic_bran.xmm600.naddr2     /*New address line 2*/                                   
                sicsyac.xmm600.fax      = sic_bran.xmm600.fax        /*Fax No.*/                                              
                sicsyac.xmm600.naddr3   = sic_bran.xmm600.naddr3     /*New address line 3*/                                   
                sicsyac.xmm600.telex    = sic_bran.xmm600.telex      /*Telex No.*/                                            
                sicsyac.xmm600.naddr4   = sic_bran.xmm600.naddr4     /*New address line 4*/                                   
                sicsyac.xmm600.name2    = sic_bran.xmm600.name2      /*Name Line 2*/                                          
                sicsyac.xmm600.npostcd  = sic_bran.xmm600.npostcd    /*New postal code*/                                      
                sicsyac.xmm600.name3    = sic_bran.xmm600.name3      /*Name Line 3*/                                          
                sicsyac.xmm600.nphone   = sic_bran.xmm600.nphone     /*New phone no.*/                                        
                sicsyac.xmm600.nachg    = sic_bran.xmm600.nachg      /*Change N&A on Renewal/Endt*/                           
                sicsyac.xmm600.regdate  = sic_bran.xmm600.regdate    /*Agents registration Date*/                             
                sicsyac.xmm600.alevel   = sic_bran.xmm600.alevel     /*Agency Level*/                                         
                sicsyac.xmm600.taxno    = sic_bran.xmm600.taxno      /*Agent tax no.*/                                        
                /*sicsyac.xmm600.anlyc1   = sic_bran.xmm600.anlyc1     /*Analysis Code 1*/   Lukkana M. A56-0357 26/11/2013*/
                SUBSTR(sicsyac.xmm600.anlyc1,1,14)   = trim(SUBSTR(sic_bran.xmm600.anlyc1,1,14)) /*Analysis Code 1*/    /*Lukkana M. A56-0357 26/11/2013 icno*/
                SUBSTR(sicsyac.xmm600.anlyc1,20,5)   = trim(SUBSTR(sic_bran.xmm600.anlyc1,20,5)) /*Analysis Code 1*/    /*Lukkana M. A56-0357 26/11/2013 รหัสสาขา*/
                sicsyac.xmm600.taxdate  = sic_bran.xmm600.taxdate    /*Agent tax date*/                                       
                sicsyac.xmm600.anlyc5   = sic_bran.xmm600.anlyc5 .   /*Analysis Code 5*/   
            ASSIGN  
                /* xmm600 *//*Add by Kridtiya i. A63-0472*/
                sicsyac.xmm600.acno_typ  = sic_bran.xmm600.acno_typ     
                sicsyac.xmm600.firstname = sic_bran.xmm600.firstname 
                sicsyac.xmm600.lastName  = sic_bran.xmm600.lastName  
                sicsyac.xmm600.postcd    = sic_bran.xmm600.postcd    
                sicsyac.xmm600.icno      = sic_bran.xmm600.icno      
                sicsyac.xmm600.codeocc   = sic_bran.xmm600.codeocc   
                sicsyac.xmm600.codeaddr1 = sic_bran.xmm600.codeaddr1 
                sicsyac.xmm600.codeaddr2 = sic_bran.xmm600.codeaddr2 
                sicsyac.xmm600.codeaddr3 = sic_bran.xmm600.codeaddr3 
                sicsyac.xmm600.anlyc5    = sic_bran.xmm600.anlyc5  
                sicsyac.xmm600.sex         = sic_bran.xmm600.sex            /*Add A65-0141 */
                sicsyac.xmm600.nationality = sic_bran.xmm600.nationality    /*Add A65-0141 */
                sicsyac.xmm600.race        = sic_bran.xmm600.race           /*Add A65-0141 */
                
                .  
                /*Add by Kridtiya i. A63-0472*/
          
                FIND FIRST sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = sic_bran.xmm600.acno NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE sicsyac.xtm600 THEN DO:  /*-- Create ใหม่เท่านั้น --*/
                   CREATE sicsyac.xtm600.                         
                   ASSIGN
                        sicsyac.xtm600.acno      = sic_bran.xmm600.acno   /*Account no.*/
                        sicsyac.xtm600.name      = sic_bran.xmm600.NAME   /*Name of Insured Line 1*/
                        sicsyac.xtm600.abname    = sic_bran.xmm600.NAME   /*Abbreviated Name*/
                        sicsyac.xtm600.addr1     = sic_bran.xmm600.addr1  /*address line 1*/
                        sicsyac.xtm600.addr2     = sic_bran.xmm600.addr2  /*address line 2*/
                        sicsyac.xtm600.addr3     = sic_bran.xmm600.addr3  /*address line 3*/
                        sicsyac.xtm600.addr4     = sic_bran.xmm600.addr4  /*address line 4*/
                        sicsyac.xtm600.name2     = sic_bran.xmm600.name2  /*Name of Insured Line 2*/
                        sicsyac.xtm600.ntitle    = sic_bran.xmm600.ntitle /*Title*/
                        sicsyac.xtm600.name3     = sic_bran.xmm600.name3  /*Name of Insured Line 3*/
                        sicsyac.xtm600.fname     = sic_bran.xmm600.fname  /*First Name*/
                        sicsyac.xtm600.postcd    = sic_bran.xmm600.postcd       /*Add by Kridtiya i. A63-0472*/
                        sicsyac.xtm600.firstname = sic_bran.xmm600.firstname    /*Add by Kridtiya i. A63-0472*/
                        sicsyac.xtm600.lastname  = sic_bran.xmm600.lastname .   /*Add by Kridtiya i. A63-0472*/
                END.
         END. /*-- NOT Avail SicSyac.Xmm600 --*/
         ELSE DO:   /* Add A58-0064 */
             IF sicsyac.xmm600.phone   <> sic_bran.xmm600.phone  THEN sicsyac.xmm600.phone  = sic_bran.xmm600.phone.    /*Phone no.*/ 
             IF sicsyac.xmm600.entdat  <> sic_bran.xmm600.entdat THEN sicsyac.xmm600.entdat = sic_bran.xmm600.entdat.   /*Entry date*/                                            
             IF sicsyac.xmm600.enttim  <> sic_bran.xmm600.enttim THEN sicsyac.xmm600.enttim = sic_bran.xmm600.enttim.   /*Entry time*/                                            
             IF sicsyac.xmm600.usrid   <> sic_bran.xmm600.usrid  THEN sicsyac.xmm600.usrid  = sic_bran.xmm600.usrid.    /*Userid*/
         END. /*-- Avail SicSyac.Xmm600 --*/ /* End Add A58-0064 */
       END. /*--AVAIL Sic_bran.Xmm600 --*/  /*---END Amparat C. A56-0141 ---*/
       /*--- ไม่พบข้อมุลใน Sic_bran.xmm600 ใช้เงื่อนไขเดิมคือดึงค่าจาก UWM100 ---*/           
       ELSE DO:
            FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                 sicsyac.xmm600.acno = CAPS(sic_bran.uwm100.insref)  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
               CREATE sicsyac.xmm600.
               ASSIGN
                  sicsyac.xmm600.acno     = sic_bran.uwm100.insref    /*Account no*/
                  sicsyac.xmm600.gpstcs   = sic_bran.uwm100.insref     /*Group A/C for statistics*/
                  sicsyac.xmm600.gpage    = ""                        /*Group A/C for ageing*/
                  sicsyac.xmm600.gpstmt   = ""                        /*Group A/C for Statement*/
                  sicsyac.xmm600.or1ref   = ""                        /*OR Agent 1 Ref. No.*/
                  sicsyac.xmm600.or2ref   = ""                        /*OR Agent 2 Ref. No.*/
                  sicsyac.xmm600.or1com   = 0                         /*OR Agent 1 Comm. %*/
                  sicsyac.xmm600.or2com   = 0                         /*OR Agent 2 Comm. %*/
                  sicsyac.xmm600.or1gn    = "G"                       /*OR Agent 1 Gross/Net*/
                  sicsyac.xmm600.or2gn    = "G"                       /*OR Agent 2 Gross/Net*/
                  sicsyac.xmm600.ntitle   = sic_bran.uwm100.ntitle    /*Title for Name Mr/Mrs/etc*/
                  sicsyac.xmm600.fname    = ""                        /*First Name*/
                  sicsyac.xmm600.name     = sic_bran.uwm100.name1     /*Name Line 1*/
                  sicsyac.xmm600.abname   = sic_bran.uwm100.name1     /*Abbreviated Name*/
                  /*--
                  sicsyac.xmm600.icno     = sic_bran.uwm100.anam2     /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/ 
                  Lukkana M. A56-0298 08/10/2013--*/
                  sicsyac.xmm600.icno     = sic_bran.uwm100.anam1     /*IC NO. Lukkana M. A56-0298 08/10/2013*/
                  sicsyac.xmm600.addr1    = sic_bran.uwm100.addr1     /*Address line 1*/
                  sicsyac.xmm600.addr2    = sic_bran.uwm100.addr2     /*Address line 2*/
                  sicsyac.xmm600.addr3    = sic_bran.uwm100.addr3     /*Address line 3*/
                  sicsyac.xmm600.addr4    = sic_bran.uwm100.addr4     /*Address line 4*/
                  /*sicsyac.xmm600.postcd   = ""                        /*Postal Code*/*//*comment by kridtiya i. A60-0157 */
                  sicsyac.xmm600.postcd   = sic_bran.uwm100.postcd     /*Postal Code*/   /*Add kridtiya i. A60-0157*/     
                  sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
                  sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
                  sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
                  sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
                  sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
                  sicsyac.xmm600.homebr   = sic_bran.uwm100.branch    /*Home branch*/
                  sicsyac.xmm600.opened   = sic_bran.uwm100.trndat    /*Date A/C opened*/
                  sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
                  sicsyac.xmm600.langug   = ""                        /*Language Code*/
                  sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
                  sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
                  sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
                  sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
                  sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
                  sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
                  sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
                  sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
                  sicsyac.xmm600.phone    = ""                        /*Phone no.*/
                  sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
                  sicsyac.xmm600.crper    = 0                         /*Credit period*/
                  sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
                  sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
                  sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
                  sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
                  sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
                  sicsyac.xmm600.usrid    = TRIM(USERID(LDBNAME(1)))                    /*Userid*/
                  sicsyac.xmm600.regagt   = ""                       /*Registered agent code*/
                  sicsyac.xmm600.agtreg   = ""                       /*Agents Registration/Licence No*/
                  sicsyac.xmm600.debtyn   = YES                      /*Permit debtor trans Y/N*/
                  sicsyac.xmm600.crcon    = NO                       /*Credit Control Report*/
                  sicsyac.xmm600.muldeb   = NO                       /*Multiple Debtors Acc.*/
                  sicsyac.xmm600.styp20   = ""                       /*Statistic Type Codes (4 x 20)*/
                  sicsyac.xmm600.sval20   = ""                       /*Statistic Value Codes (4 x 20)*/
                  sicsyac.xmm600.dtyp20   = ""                       /*Type of Date Codes (2 X 20)*/
                  sicsyac.xmm600.dval20   = ""                       /*Date Values (8 X 20)*/
                  sicsyac.xmm600.iblack   = ""                       /*Insured Black List Code*/
                  sicsyac.xmm600.oldic    = ""                       /*Old IC No.*/
                  sicsyac.xmm600.cardno   = ""                       /*Credit Card Account No.*/
                  sicsyac.xmm600.cshcrd   = ""                       /*Cash(C)/Credit(R) Agent*/
                  sicsyac.xmm600.naddr1   = ""                       /*New address line 1*/
                  sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
                  sicsyac.xmm600.naddr2   = ""                       /*New address line 2*/
                  sicsyac.xmm600.fax      = ""                       /*Fax No.*/
                  sicsyac.xmm600.naddr3   = ""                       /*New address line 3*/
                  sicsyac.xmm600.telex    = ""                       /*Telex No.*/
                  sicsyac.xmm600.naddr4   = ""                       /*New address line 4*/
                  sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
                  sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
                  sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
                  sicsyac.xmm600.nphone   = ""                       /*New phone no.*/    
                  sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
                  sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
                  sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
                  sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
                  sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
                  sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
                  sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
                  /* xmm600 *//*Add by Kridtiya i. A63-0472*/
                  sicsyac.xmm600.acno_typ  = sic_bran.xmm600.acno_typ    
                  sicsyac.xmm600.firstname = sic_bran.xmm600.firstname 
                  sicsyac.xmm600.lastName  = sic_bran.xmm600.lastName  
                  sicsyac.xmm600.postcd    = sic_bran.xmm600.postcd    
                  sicsyac.xmm600.icno      = sic_bran.xmm600.icno      
                  sicsyac.xmm600.codeocc   = sic_bran.xmm600.codeocc   
                  sicsyac.xmm600.codeaddr1 = sic_bran.xmm600.codeaddr1 
                  sicsyac.xmm600.codeaddr2 = sic_bran.xmm600.codeaddr2 
                  sicsyac.xmm600.codeaddr3 = sic_bran.xmm600.codeaddr3 
                  sicsyac.xmm600.anlyc5    = sic_bran.xmm600.anlyc5  . 
                  /*Add by Kridtiya i. A63-0472*/

                
                  FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = sic_bran.uwm100.insref NO-LOCK NO-ERROR NO-WAIT.
                  IF NOT AVAILABLE sicsyac.xtm600 THEN DO:                               
                     CREATE sicsyac.xtm600.          
                     ASSIGN                                           
                       sicsyac.xtm600.acno    = sic_bran.uwm100.insref  /*Account no.*/
                       sicsyac.xtm600.name    = sic_bran.uwm100.name1   /*Name of Insured Line 1*/
                       sicsyac.xtm600.abname  = sic_bran.uwm100.name1   /*Abbreviated Name*/
                       sicsyac.xtm600.addr1   = sic_bran.uwm100.addr1   /*address line 1*/
                       sicsyac.xtm600.addr2   = sic_bran.uwm100.addr2   /*address line 2*/
                       sicsyac.xtm600.addr3   = sic_bran.uwm100.addr3   /*address line 3*/
                       sicsyac.xtm600.addr4   = trim(sic_bran.uwm100.addr4 + " " +  sic_bran.uwm100.postcd)  /*address line 4*/
                       sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
                       sicsyac.xtm600.ntitle  = sic_bran.uwm100.ntitle  /*Title*/
                       sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
                       sicsyac.xtm600.fname   = ""                     /*First Name*/          
                       sicsyac.xtm600.postcd    = sic_bran.uwm100.postcd       /*Add by Kridtiya i. A63-0472*/
                       sicsyac.xtm600.firstname = sic_bran.uwm100.firstname    /*Add by Kridtiya i. A63-0472*/
                       sicsyac.xtm600.lastname  = sic_bran.uwm100.lastname .   /*Add by Kridtiya i. A63-0472*/
                  END. /*-- sicsyac.xtm600--*/
            END. /*-- Create sicsyac.xmm600 --*/
       END. /* ELSE DO:*/
       RELEASE sicsyac.xmm600.
   END. /*-- uwm100.insref <> "COMP" */
   comment BY Chaiyong W. A65-0185 08/09/2022*/
END. /*--AVAIL Sic_bran.Uwm100*/

/*---Begin by Chaiyong W. A65-0180 26/07/2022*/
PROCEDURE pd_xmm600:
    DEF INPUT PARAMETER nv_acno AS CHAR INIT "".
    /*---begin by Chaiyong W. A66-0048 30/03/2023*/
    DEF VAR nv_lxmm600 AS CHAR INIT "".
    DEF VAR nv_ctlock  AS INT  INIT 0.
    /*end by Chaiyong W. A66-0048 30/03/2023-----*/
    /*---Begin by Chaiyong W. A65-0253 25/04/2023*/
    DEF VAR nv_time  AS DECI INIT 0.
    DEF VAR nv_wtime AS DECI INIT 5.
    /*End by Chaiyong W. A65-0253 25/04/2023-----*/
    FIND FIRST sic_bran.xmm600 USE-INDEX xmm60001 WHERE
        sic_bran.xmm600.acno = nv_acno NO-LOCK NO-ERROR.
    IF AVAIL sic_bran.xmm600 THEN DO:


         /* 
         FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                    sicsyac.xmm600.acno = sic_bran.xmm600.acno  NO-ERROR NO-WAIT.
         IF NOT AVAIL sicsyac.xmm600 THEN DO:
         comment by Chaiyong W. A66-0048 30/03/2023*/
         /*---begin by Chaiyong W. A66-0048 30/03/2023*/
        loop_xmm600:
         REPEAT:
         FIND  sicsyac.xmm600 USE-INDEX xmm60001 WHERE
               sicsyac.xmm600.acno = sic_bran.xmm600.acno  EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
         IF NOT AVAIL sicsyac.xmm600 THEN DO:
             IF LOCKED(sicsyac.xmm600) THEN DO:
                 nv_lxmm600 = "Lock".
                 /*---Begin by Chaiyong W. A65-0253 25/04/2023*/
                 IF nv_time = 0 THEN nv_time = TIME .
                 IF (nv_time + nv_wtime) < TIME OR nv_time > TIME THEN DO:
                     nv_time = 0.
                     FIND sicsyac.xmm600 WHERE sicsyac.xmm600.acno = sic_bran.xmm600.acno  EXCLUSIVE-LOCK NO-ERROR.
                 END.
                 
                 /*End by Chaiyong W. A65-0253 25/04/2023-----*/
                 NEXT loop_xmm600.
             END.
             nv_lxmm600 = "".

         /*end by Chaiyong W. A66-0048 30/03/2023-----*/
            CREATE sicsyac.xmm600.   /*---Create ใหม่เท่านั้น--*/     
            ASSIGN
                sicsyac.xmm600.acno           = sic_bran.xmm600.acno                         
                sicsyac.xmm600.gpstcs         = sic_bran.xmm600.gpstcs                       
                sicsyac.xmm600.gpage          = sic_bran.xmm600.gpage                        
                sicsyac.xmm600.gpstmt         = sic_bran.xmm600.gpstmt                       
                sicsyac.xmm600.or1ref         = sic_bran.xmm600.or1ref                       
                sicsyac.xmm600.or2ref         = sic_bran.xmm600.or2ref                       
                sicsyac.xmm600.or1com         = sic_bran.xmm600.or1com                       
                sicsyac.xmm600.or2com         = sic_bran.xmm600.or2com                       
                sicsyac.xmm600.or1gn          = sic_bran.xmm600.or1gn                        
                sicsyac.xmm600.or2gn          = sic_bran.xmm600.or2gn                        
                sicsyac.xmm600.ntitle         = sic_bran.xmm600.ntitle                       
                sicsyac.xmm600.fname          = sic_bran.xmm600.fname                        
                sicsyac.xmm600.name           = sic_bran.xmm600.name                         
                sicsyac.xmm600.abname         = sic_bran.xmm600.abname                       
                sicsyac.xmm600.icno           = sic_bran.xmm600.icno                         
                sicsyac.xmm600.addr1          = sic_bran.xmm600.addr1                        
                sicsyac.xmm600.addr2          = sic_bran.xmm600.addr2                        
                sicsyac.xmm600.addr3          = sic_bran.xmm600.addr3                        
                sicsyac.xmm600.addr4          = sic_bran.xmm600.addr4                        
                sicsyac.xmm600.postcd         = sic_bran.xmm600.postcd                       
                sicsyac.xmm600.clicod         = sic_bran.xmm600.clicod                       
                sicsyac.xmm600.acccod         = sic_bran.xmm600.acccod                       
                sicsyac.xmm600.relate         = sic_bran.xmm600.relate                       
                sicsyac.xmm600.notes1         = sic_bran.xmm600.notes1                       
                sicsyac.xmm600.notes2         = sic_bran.xmm600.notes2                       
                sicsyac.xmm600.homebr         = sic_bran.xmm600.homebr                       
                sicsyac.xmm600.opened         = sic_bran.xmm600.opened                       
                sicsyac.xmm600.prindr         = sic_bran.xmm600.prindr                       
                sicsyac.xmm600.langug         = sic_bran.xmm600.langug                       
                sicsyac.xmm600.cshdat         = sic_bran.xmm600.cshdat                       
                sicsyac.xmm600.legal          = sic_bran.xmm600.legal                        
                sicsyac.xmm600.stattp         = sic_bran.xmm600.stattp                       
                sicsyac.xmm600.autoap         = sic_bran.xmm600.autoap                       
                sicsyac.xmm600.ltcurr         = sic_bran.xmm600.ltcurr                       
                sicsyac.xmm600.ltamt          = sic_bran.xmm600.ltamt                        
                sicsyac.xmm600.exec           = sic_bran.xmm600.exec                         
                sicsyac.xmm600.cntry          = sic_bran.xmm600.cntry                        
                sicsyac.xmm600.phone          = sic_bran.xmm600.phone                        
                sicsyac.xmm600.closed         = sic_bran.xmm600.closed                       
                sicsyac.xmm600.crper          = sic_bran.xmm600.crper                        
                sicsyac.xmm600.pvfeq          = sic_bran.xmm600.pvfeq                        
                sicsyac.xmm600.comtab         = sic_bran.xmm600.comtab                       
                sicsyac.xmm600.chgpol         = sic_bran.xmm600.chgpol                       
                sicsyac.xmm600.entdat         = sic_bran.xmm600.entdat                       
                sicsyac.xmm600.enttim         = sic_bran.xmm600.enttim                       
                sicsyac.xmm600.usrid          = sic_bran.xmm600.usrid                        
                sicsyac.xmm600.regagt         = sic_bran.xmm600.regagt                       
                sicsyac.xmm600.agtreg         = sic_bran.xmm600.agtreg                       
                sicsyac.xmm600.debtyn         = sic_bran.xmm600.debtyn                       
                sicsyac.xmm600.crcon          = sic_bran.xmm600.crcon                        
                sicsyac.xmm600.muldeb         = sic_bran.xmm600.muldeb                       
                sicsyac.xmm600.styp20         = sic_bran.xmm600.styp20                       
                sicsyac.xmm600.sval20         = sic_bran.xmm600.sval20                       
                sicsyac.xmm600.dtyp20         = sic_bran.xmm600.dtyp20                       
                sicsyac.xmm600.dval20         = sic_bran.xmm600.dval20                       
                sicsyac.xmm600.iblack         = sic_bran.xmm600.iblack                       
                sicsyac.xmm600.oldic          = sic_bran.xmm600.oldic                        
                sicsyac.xmm600.cardno         = sic_bran.xmm600.cardno                       
                sicsyac.xmm600.cshcrd         = sic_bran.xmm600.cshcrd                       
                sicsyac.xmm600.naddr1         = sic_bran.xmm600.naddr1                       
                sicsyac.xmm600.gstreg         = sic_bran.xmm600.gstreg                       
                sicsyac.xmm600.naddr2         = sic_bran.xmm600.naddr2                       
                sicsyac.xmm600.fax            = sic_bran.xmm600.fax                          
                sicsyac.xmm600.naddr3         = sic_bran.xmm600.naddr3                       
                sicsyac.xmm600.telex          = sic_bran.xmm600.telex                        
                sicsyac.xmm600.naddr4         = sic_bran.xmm600.naddr4                       
                sicsyac.xmm600.name2          = sic_bran.xmm600.name2                        
                sicsyac.xmm600.npostcd        = sic_bran.xmm600.npostcd                      
                sicsyac.xmm600.name3          = sic_bran.xmm600.name3                        
                sicsyac.xmm600.nphone         = sic_bran.xmm600.nphone                       
                sicsyac.xmm600.nachg          = sic_bran.xmm600.nachg                        
                sicsyac.xmm600.regdate        = sic_bran.xmm600.regdate                      
                sicsyac.xmm600.alevel         = sic_bran.xmm600.alevel                       
                sicsyac.xmm600.taxno          = sic_bran.xmm600.taxno                        
                sicsyac.xmm600.anlyc1         = sic_bran.xmm600.anlyc1                       
                sicsyac.xmm600.taxdate        = sic_bran.xmm600.taxdate                      
                sicsyac.xmm600.anlyc5         = sic_bran.xmm600.anlyc5                       
                /*
                sicsyac.xmm600.bchyr          = sic_bran.xmm600.bchyr                        
                sicsyac.xmm600.bchno          = sic_bran.xmm600.bchno                        
                sicsyac.xmm600.bchcnt         = sic_bran.xmm600.bchcnt       */
                sicsyac.xmm600.br_insure      = sic_bran.xmm600.br_insure                    
                sicsyac.xmm600.birthdate      = sic_bran.xmm600.birthdate                    
                sicsyac.xmm600.lasercode      = sic_bran.xmm600.lasercode                    
                sicsyac.xmm600.expdat_id      = sic_bran.xmm600.expdat_id                    
                sicsyac.xmm600.crper1         = sic_bran.xmm600.crper1                       
                sicsyac.xmm600.bankcard       = sic_bran.xmm600.bankcard                     
                sicsyac.xmm600.acno_typ       = sic_bran.xmm600.acno_typ                     
                sicsyac.xmm600.id_typ         = sic_bran.xmm600.id_typ                       
                sicsyac.xmm600.sex            = sic_bran.xmm600.sex                          
                sicsyac.xmm600.maritalsts     = sic_bran.xmm600.maritalsts                   
                sicsyac.xmm600.addr           = sic_bran.xmm600.addr                         
                sicsyac.xmm600.unitNo         = sic_bran.xmm600.unitNo                       
                sicsyac.xmm600.roomNo         = sic_bran.xmm600.roomNo                       
                sicsyac.xmm600.building       = sic_bran.xmm600.building                     
                sicsyac.xmm600.village        = sic_bran.xmm600.village                      
                sicsyac.xmm600.alley          = sic_bran.xmm600.alley                        
                sicsyac.xmm600.lane           = sic_bran.xmm600.lane                         
                sicsyac.xmm600.street         = sic_bran.xmm600.street                       
                sicsyac.xmm600.subdistrict    = sic_bran.xmm600.subdistrict                  
                sicsyac.xmm600.district       = sic_bran.xmm600.district                     
                sicsyac.xmm600.province       = sic_bran.xmm600.province                     
                sicsyac.xmm600.occupation     = sic_bran.xmm600.occupation                   
                sicsyac.xmm600.firstName      = sic_bran.xmm600.firstName                    
                sicsyac.xmm600.midName        = sic_bran.xmm600.midName                      
                sicsyac.xmm600.lastName       = sic_bran.xmm600.lastName                     
                sicsyac.xmm600.nbr_insure     = sic_bran.xmm600.nbr_insure                   
                sicsyac.xmm600.nlasercode     = sic_bran.xmm600.nlasercode                   
                sicsyac.xmm600.nexpdat_id     = sic_bran.xmm600.nexpdat_id                   
                sicsyac.xmm600.nid_typ        = sic_bran.xmm600.nid_typ                      
                sicsyac.xmm600.naddr          = sic_bran.xmm600.naddr                        
                sicsyac.xmm600.nunitNo        = sic_bran.xmm600.nunitNo                      
                sicsyac.xmm600.nroomNo        = sic_bran.xmm600.nroomNo                      
                sicsyac.xmm600.nbuilding      = sic_bran.xmm600.nbuilding                    
                sicsyac.xmm600.nvillage       = sic_bran.xmm600.nvillage                     
                sicsyac.xmm600.nalley         = sic_bran.xmm600.nalley                       
                sicsyac.xmm600.nlane          = sic_bran.xmm600.nlane                        
                sicsyac.xmm600.nstreet        = sic_bran.xmm600.nstreet                      
                sicsyac.xmm600.nsubdistrict   = sic_bran.xmm600.nsubdistrict                 
                sicsyac.xmm600.ndistrict      = sic_bran.xmm600.ndistrict                    
                sicsyac.xmm600.nprovince      = sic_bran.xmm600.nprovince                    
                sicsyac.xmm600.nfirstName     = sic_bran.xmm600.nfirstName                   
                sicsyac.xmm600.nmidName       = sic_bran.xmm600.nmidName                     
                sicsyac.xmm600.nlastName      = sic_bran.xmm600.nlastName                    
                sicsyac.xmm600.mcode          = sic_bran.xmm600.mcode                        
                sicsyac.xmm600.mcdes          = sic_bran.xmm600.mcdes                        
                sicsyac.xmm600.winscd         = sic_bran.xmm600.winscd                       
                sicsyac.xmm600.coderef1       = sic_bran.xmm600.coderef1                     
                sicsyac.xmm600.coderef2       = sic_bran.xmm600.coderef2                     
                sicsyac.xmm600.coderef3       = sic_bran.xmm600.coderef3                     
                sicsyac.xmm600.codeocc        = sic_bran.xmm600.codeocc                      
                sicsyac.xmm600.codeaddr1      = sic_bran.xmm600.codeaddr1                    
                sicsyac.xmm600.codeaddr2      = sic_bran.xmm600.codeaddr2                    
                sicsyac.xmm600.codeaddr3      = sic_bran.xmm600.codeaddr3                    
                sicsyac.xmm600.bankcode       = sic_bran.xmm600.bankcode                     
                sicsyac.xmm600.passport       = sic_bran.xmm600.passport                     
                sicsyac.xmm600.race           = sic_bran.xmm600.race                         
                sicsyac.xmm600.phone1         = sic_bran.xmm600.phone1                       
                sicsyac.xmm600.issuedat_id    = sic_bran.xmm600.issuedat_id                  
                sicsyac.xmm600.nationality    = sic_bran.xmm600.nationality                  
                sicsyac.xmm600.nissuedat_id   = sic_bran.xmm600.nissuedat_id                 
                sicsyac.xmm600.nnationality   = sic_bran.xmm600.nnationality                 
                sicsyac.xmm600.lineid         = sic_bran.xmm600.lineid                       
                sicsyac.xmm600.cros           = sic_bran.xmm600.cros                         
                sicsyac.xmm600.nname2         = sic_bran.xmm600.nname2                       
                sicsyac.xmm600.nicno          = sic_bran.xmm600.nicno                        
                sicsyac.xmm600.m_addr1        = sic_bran.xmm600.m_addr1                      
                sicsyac.xmm600.m_addr2        = sic_bran.xmm600.m_addr2                      
                sicsyac.xmm600.m_addr3        = sic_bran.xmm600.m_addr3                      
                sicsyac.xmm600.m_addr4        = sic_bran.xmm600.m_addr4                      
                sicsyac.xmm600.m_postcd       = sic_bran.xmm600.m_postcd                     
                sicsyac.xmm600.nntitle        = sic_bran.xmm600.nntitle                      
                sicsyac.xmm600.email          = sic_bran.xmm600.email                        
                sicsyac.xmm600.tel            = sic_bran.xmm600.tel                          
                sicsyac.xmm600.chr1           = sic_bran.xmm600.chr1                         
                sicsyac.xmm600.chr2           = sic_bran.xmm600.chr2                         
                sicsyac.xmm600.chr3           = sic_bran.xmm600.chr3                         
                sicsyac.xmm600.chr4           = sic_bran.xmm600.chr4                         
                sicsyac.xmm600.chr5           = sic_bran.xmm600.chr5                         
                sicsyac.xmm600.date1          = sic_bran.xmm600.date1                        
                sicsyac.xmm600.date2          = sic_bran.xmm600.date2                        
                sicsyac.xmm600.dec1           = sic_bran.xmm600.dec1                         
                sicsyac.xmm600.dec2           = sic_bran.xmm600.dec2                         
                sicsyac.xmm600.int1           = sic_bran.xmm600.int1                         
                sicsyac.xmm600.int2           = sic_bran.xmm600.int2                         
                sicsyac.xmm600.consent1       = sic_bran.xmm600.consent1                     
                sicsyac.xmm600.consdat1       = sic_bran.xmm600.consdat1                     
                sicsyac.xmm600.constim1       = sic_bran.xmm600.constim1                     
                sicsyac.xmm600.consnot1       = sic_bran.xmm600.consnot1                     
                sicsyac.xmm600.consent2       = sic_bran.xmm600.consent2                     
                sicsyac.xmm600.consdat2       = sic_bran.xmm600.consdat2                     
                sicsyac.xmm600.constim2       = sic_bran.xmm600.constim2                     
                sicsyac.xmm600.consnot2       = sic_bran.xmm600.consnot2                     
                sicsyac.xmm600.delicod        = sic_bran.xmm600.delicod                      
                sicsyac.xmm600.dtitle         = sic_bran.xmm600.dtitle                       
                sicsyac.xmm600.dfirstname     = sic_bran.xmm600.dfirstname                   
                sicsyac.xmm600.dlastname      = sic_bran.xmm600.dlastname                    
                sicsyac.xmm600.daddr1         = sic_bran.xmm600.daddr1                       
                sicsyac.xmm600.daddr2         = sic_bran.xmm600.daddr2                       
                sicsyac.xmm600.daddr3         = sic_bran.xmm600.daddr3                       
                sicsyac.xmm600.daddr4         = sic_bran.xmm600.daddr4                       
                sicsyac.xmm600.dpostcd        = sic_bran.xmm600.dpostcd                      
                sicsyac.xmm600.dcodeaddr1     = sic_bran.xmm600.dcodeaddr1                   
                sicsyac.xmm600.dcodeaddr2     = sic_bran.xmm600.dcodeaddr2                   
                sicsyac.xmm600.dcodeaddr3     = sic_bran.xmm600.dcodeaddr3                   
                sicsyac.xmm600.demail1        = sic_bran.xmm600.demail1                      
                sicsyac.xmm600.demail2        = sic_bran.xmm600.demail2                      
                sicsyac.xmm600.dphone1        = sic_bran.xmm600.dphone1                      
                sicsyac.xmm600.dphone2        = sic_bran.xmm600.dphone2                      
                sicsyac.xmm600.dcontact1      = sic_bran.xmm600.dcontact1                    
                sicsyac.xmm600.dcontact2      = sic_bran.xmm600.dcontact2                    
                sicsyac.xmm600.interco        = sic_bran.xmm600.interco        .    

            



                
                /*
                FIND FIRST sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = sic_bran.xmm600.acno NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAILABLE sicsyac.xtm600 THEN DO:  /*-- Create ใหม่เท่านั้น --*/
                comment by Chaiyong W. A66-004830/03/2023*/
                /*---begin by Chaiyong W. A66-0048 30/03/2023*/
                loop_xtm600:
                 REPEAT:
                     FIND  sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = sic_bran.xmm600.acno EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                     IF NOT AVAILABLE sicsyac.xtm600 THEN DO:  /*-- Create ใหม่เท่านั้น --*/
                         IF LOCKED(sicsyac.xtm600) THEN DO:
    
                             /*---Begin by Chaiyong W. A65-0253 25/04/2023*/
                             IF nv_time = 0 THEN nv_time = TIME .
                             IF (nv_time + nv_wtime) < TIME OR nv_time > TIME THEN DO:
                                 nv_time = 0.
                                 FIND  sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = sic_bran.xmm600.acno EXCLUSIVE-LOCK NO-ERROR.
                             END.
                             
                             /*End by Chaiyong W. A65-0253 25/04/2023-----*/
                             NEXT loop_xtm600.
                         END.
                         
            
                         /*end by Chaiyong W. A66-0048 30/03/2023-----*/
                           CREATE sicsyac.xtm600.                         
                           ASSIGN
                                sicsyac.xtm600.acno      = sic_bran.xmm600.acno   /*Account no.*/
                                sicsyac.xtm600.name      = sic_bran.xmm600.NAME   /*Name of Insured Line 1*/
                                sicsyac.xtm600.abname    = sic_bran.xmm600.NAME   /*Abbreviated Name*/
                                sicsyac.xtm600.addr1     = sic_bran.xmm600.addr1  /*address line 1*/
                                sicsyac.xtm600.addr2     = sic_bran.xmm600.addr2  /*address line 2*/
                                sicsyac.xtm600.addr3     = sic_bran.xmm600.addr3  /*address line 3*/
                                sicsyac.xtm600.addr4     = sic_bran.xmm600.addr4  /*address line 4*/
                                sicsyac.xtm600.name2     = sic_bran.xmm600.name2  /*Name of Insured Line 2*/
                                sicsyac.xtm600.ntitle    = sic_bran.xmm600.ntitle /*Title*/
                                sicsyac.xtm600.name3     = sic_bran.xmm600.name3  /*Name of Insured Line 3*/
                                sicsyac.xtm600.fname     = sic_bran.xmm600.fname  /*First Name*/
                                sicsyac.xtm600.postcd    = sic_bran.xmm600.postcd       /*Add by Kridtiya i. A63-0472*/
                                sicsyac.xtm600.firstname = sic_bran.xmm600.firstname    /*Add by Kridtiya i. A63-0472*/
                                sicsyac.xtm600.lastname  = sic_bran.xmm600.lastname .   /*Add by Kridtiya i. A63-0472*/
                        END.
                             /*---begin by Chaiyong W. A66-0048 30/03/2023*/
                         LEAVE loop_xtm600.
                     END.
                     /*end by Chaiyong W. A66-0048 30/03/2023-----*/

                    IF sic_bran.xmm600.entdat <> TODAY THEN /*---add by Chaiyong W. A66-0221 16/11/2023*/
                        RUN pd_upxmm601. /* Transfer xmm600 to xmm601 save log history create xmm600 on web*/
                    ASSIGN   /*Update Date Time Create in Premium*/
                        sicsyac.xmm600.entdat = TODAY   /*Entry date*/  
                        sicsyac.xmm600.enttim = STRING(TIME,"HH:MM:SS").  /*Entry time*/  
             END. /*-- NOT Avail SicSyac.Xmm600 --*/
             ELSE DO:   /* Add A58-0064 */
    
    
                 IF sicsyac.xmm600.phone   <> sic_bran.xmm600.phone  THEN DO:
                     RUN pd_upxmm601.
                     ASSIGN
                      sicsyac.xmm600.phone  = sic_bran.xmm600.phone    /*Phone no.*/ 
                      sicsyac.xmm600.entdat = TODAY   /*Entry date*/  
                      sicsyac.xmm600.enttim = STRING(TIME,"HH:MM:SS")  /*Entry time*/  
                      sicsyac.xmm600.usrid  = sic_bran.xmm600.usrid.   /*Userid*/      
    
                 END.
                 
                 /*--
                 IF sicsyac.xmm600.addr1       <>      sic_bran.xmm600.addr1      or
                    sicsyac.xmm600.addr2       <>      sic_bran.xmm600.addr2      or
                    sicsyac.xmm600.addr3       <>      sic_bran.xmm600.addr3      or
                    sicsyac.xmm600.addr4       <>      sic_bran.xmm600.addr4      or
                    sicsyac.xmm600.postcd      <>      sic_bran.xmm600.postcd     OR
                    sicsyac.xmm600.phone       <>      sic_bran.xmm600.phone      or
                    sicsyac.xmm600.entdat      <>      sic_bran.xmm600.entdat     or
                    sicsyac.xmm600.enttim      <>      sic_bran.xmm600.enttim     or
                    sicsyac.xmm600.usrid       <>      sic_bran.xmm600.usrid          or
                    sicsyac.xmm600.anlyc1      <>      sic_bran.xmm600.anlyc1        or     
                    sicsyac.xmm600.nfirstname  <>      sic_bran.xmm600.nfirstname    or     
                    sicsyac.xmm600.nlastname   <>      sic_bran.xmm600.nlastname     or     
                    sicsyac.xmm600.npostcd     <>      sic_bran.xmm600.npostcd       or     
                    sicsyac.xmm600.nntitle     <>      sic_bran.xmm600.nntitle       or     
                    sicsyac.xmm600.nphone      <>      sic_bran.xmm600.nphone        or     
                    sicsyac.xmm600.nicno       <>      sic_bran.xmm600.nicno         or     
                    sicsyac.xmm600.nbr_insure  <>      sic_bran.xmm600.nbr_insure    THEN DO:
    
                      RUN pd_upxmm601.
    
    
                     ASSIGN
    
                        sicsyac.xmm600.phone          = sic_bran.xmm600.phone 
                        sicsyac.xmm600.entdat         = sic_bran.xmm600.entdat
                        sicsyac.xmm600.enttim         = sic_bran.xmm600.enttim
                        sicsyac.xmm600.usrid          = sic_bran.xmm600.usrid
    
                        /*sicsyac.xmm600.icno           = sic_bran.xmm600.icno    */  /*
                        sicsyac.xmm600.addr1          = sic_bran.xmm600.addr1                        
                        sicsyac.xmm600.addr2          = sic_bran.xmm600.addr2                        
                        sicsyac.xmm600.addr3          = sic_bran.xmm600.addr3                        
                        sicsyac.xmm600.addr4          = sic_bran.xmm600.addr4       
                        sicsyac.xmm600.postcd         = sic_bran.xmm600.postcd 
                        sicsyac.xmm600.naddr1         = sic_bran.xmm600.naddr1             
                        sicsyac.xmm600.naddr2         = sic_bran.xmm600.naddr2             
                        sicsyac.xmm600.naddr3         = sic_bran.xmm600.naddr3             
                        sicsyac.xmm600.naddr4         = sic_bran.xmm600.naddr4             
                        sicsyac.xmm600.anlyc1         = sic_bran.xmm600.anlyc1             
                        sicsyac.xmm600.nfirstname     = sic_bran.xmm600.nfirstname         
                        sicsyac.xmm600.nlastname      = sic_bran.xmm600.nlastname          
                        sicsyac.xmm600.npostcd        = sic_bran.xmm600.npostcd            
                        sicsyac.xmm600.nntitle        = sic_bran.xmm600.nntitle            
                        sicsyac.xmm600.nphone         = sic_bran.xmm600.nphone             
                        sicsyac.xmm600.nicno          = sic_bran.xmm600.nicno              
                        sicsyac.xmm600.nbr_insure     = sic_bran.xmm600.nbr_insure    */    .
    
    
    
    
    
                    FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = sic_bran.xmm600.acno NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE sicsyac.xtm600 THEN DO:  
                        IF sicsyac.xtm600.postcd =  THEN
    
    
                        ASSIGN
                            sicsyac.xtm600.addr1     = sic_bran.xmm600.addr1
                            sicsyac.xtm600.addr2     = sic_bran.xmm600.addr2
                            sicsyac.xtm600.addr3     = sic_bran.xmm600.addr3
                            sicsyac.xtm600.addr4     = sic_bran.xmm600.addr4
                            sicsyac.xtm600.postcd    = sic_bran.xmm600.postcd  .
                    END.
    
                 END. */
                 
    
                 
    
    
             END. /*-- Avail SicSyac.Xmm600 --*/ /* End Add A58-0064 */
         /*---begin by Chaiyong W. A66-0048 30/03/2023*/
             LEAVE loop_xmm600.
         END.
         /*end by Chaiyong W. A66-0048 30/03/2023-----*/
       END. /*--AVAIL Sic_bran.Xmm600 --*/  /*---END Amparat C. A56-0141 ---*/
       /*--- ไม่พบข้อมุลใน Sic_bran.xmm600 ใช้เงื่อนไขเดิมคือดึงค่าจาก UWM100 ---*/           
       ELSE IF sic_bran.uwm100.insref = nv_acno THEN DO:
           /*
            FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                 sicsyac.xmm600.acno = CAPS(sic_bran.uwm100.insref)  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
            comment by Chaiyong W. A66-004830/03/2023*/
            /*---begin by Chaiyong W. A66-0048 30/03/2023*/
            loop_xmm600U:
             REPEAT:
             FIND  sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                   sicsyac.xmm600.acno = CAPS(sic_bran.uwm100.insref)  EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
             IF NOT AVAIL sicsyac.xmm600 THEN DO:
                 IF LOCKED(sicsyac.xmm600) THEN DO:
                     /*---Begin by Chaiyong W. A65-0253 25/04/2023*/
                     IF nv_time = 0 THEN nv_time = TIME .
                     IF (nv_time + nv_wtime) < TIME OR nv_time > TIME THEN DO:
                         nv_time = 0.
                         FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE  sicsyac.xmm600.acno = CAPS(sic_bran.uwm100.insref) EXCLUSIVE-LOCK NO-ERROR.
                     END.
                     
                     /*End by Chaiyong W. A65-0253 25/04/2023-----*/



                     NEXT loop_xmm600U.
                 END.
    
             /*end by Chaiyong W. A66-0048 30/03/2023-----*/

                   CREATE sicsyac.xmm600.
                   ASSIGN
                      /*--
                      sicsyac.xmm600.acno     = sic_bran.uwm100.insref    /*Account no*/
                      sicsyac.xmm600.gpstcs   = sic_bran.uwm100.insref     /*Group A/C for statistics*/
                      comment by Chaiyong W. A65-0253 25/04/2023*/
                      /*---Begin by Chaiyong W. A65-0253 25/04/2023*/
                      sicsyac.xmm600.acno     = caps(sic_bran.uwm100.insref)    /*Account no*/
                      sicsyac.xmm600.gpstcs   = caps(sic_bran.uwm100.insref)     /*Group A/C for statistics*/
                      /*End by Chaiyong W. A65-0253 25/04/2023-----*/



                      sicsyac.xmm600.gpage    = ""                        /*Group A/C for ageing*/
                      sicsyac.xmm600.gpstmt   = ""                        /*Group A/C for Statement*/
                      sicsyac.xmm600.or1ref   = ""                        /*OR Agent 1 Ref. No.*/
                      sicsyac.xmm600.or2ref   = ""                        /*OR Agent 2 Ref. No.*/
                      sicsyac.xmm600.or1com   = 0                         /*OR Agent 1 Comm. %*/
                      sicsyac.xmm600.or2com   = 0                         /*OR Agent 2 Comm. %*/
                      sicsyac.xmm600.or1gn    = "G"                       /*OR Agent 1 Gross/Net*/
                      sicsyac.xmm600.or2gn    = "G"                       /*OR Agent 2 Gross/Net*/
                      sicsyac.xmm600.ntitle   = sic_bran.uwm100.ntitle    /*Title for Name Mr/Mrs/etc*/
                      sicsyac.xmm600.fname    = ""                        /*First Name*/
                      sicsyac.xmm600.name     = sic_bran.uwm100.name1     /*Name Line 1*/
                      sicsyac.xmm600.abname   = sic_bran.uwm100.name1     /*Abbreviated Name*/
                      /*--
                      sicsyac.xmm600.icno     = sic_bran.uwm100.anam2     /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/ 
                      Lukkana M. A56-0298 08/10/2013--*/
                      sicsyac.xmm600.icno     = sic_bran.uwm100.anam1     /*IC NO. Lukkana M. A56-0298 08/10/2013*/
                      sicsyac.xmm600.addr1    = sic_bran.uwm100.addr1     /*Address line 1*/
                      sicsyac.xmm600.addr2    = sic_bran.uwm100.addr2     /*Address line 2*/
                      sicsyac.xmm600.addr3    = sic_bran.uwm100.addr3     /*Address line 3*/
                      sicsyac.xmm600.addr4    = sic_bran.uwm100.addr4     /*Address line 4*/
                      /*sicsyac.xmm600.postcd   = ""                        /*Postal Code*/*//*comment by kridtiya i. A60-0157 */
                      sicsyac.xmm600.postcd   = sic_bran.uwm100.postcd     /*Postal Code*/   /*Add kridtiya i. A60-0157*/     
                      sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
                      sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
                      sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
                      sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
                      sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
                      sicsyac.xmm600.homebr   = sic_bran.uwm100.branch    /*Home branch*/
                      sicsyac.xmm600.opened   = sic_bran.uwm100.trndat    /*Date A/C opened*/
                      sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
                      sicsyac.xmm600.langug   = ""                        /*Language Code*/
                      sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
                      sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
                      sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
                      sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
                      sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
                      sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
                      sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
                      sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
                      sicsyac.xmm600.phone    = ""                        /*Phone no.*/
                      sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
                      sicsyac.xmm600.crper    = 0                         /*Credit period*/
                      sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
                      sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
                      sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
                      sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
                      sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
                      sicsyac.xmm600.usrid    = TRIM(USERID(LDBNAME(1)))                    /*Userid*/
                      sicsyac.xmm600.regagt   = ""                       /*Registered agent code*/
                      sicsyac.xmm600.agtreg   = ""                       /*Agents Registration/Licence No*/
                      sicsyac.xmm600.debtyn   = YES                      /*Permit debtor trans Y/N*/
                      sicsyac.xmm600.crcon    = NO                       /*Credit Control Report*/
                      sicsyac.xmm600.muldeb   = NO                       /*Multiple Debtors Acc.*/
                      sicsyac.xmm600.styp20   = ""                       /*Statistic Type Codes (4 x 20)*/
                      sicsyac.xmm600.sval20   = ""                       /*Statistic Value Codes (4 x 20)*/
                      sicsyac.xmm600.dtyp20   = ""                       /*Type of Date Codes (2 X 20)*/
                      sicsyac.xmm600.dval20   = ""                       /*Date Values (8 X 20)*/
                      sicsyac.xmm600.iblack   = ""                       /*Insured Black List Code*/
                      sicsyac.xmm600.oldic    = ""                       /*Old IC No.*/
                      sicsyac.xmm600.cardno   = ""                       /*Credit Card Account No.*/
                      sicsyac.xmm600.cshcrd   = ""                       /*Cash(C)/Credit(R) Agent*/
                      sicsyac.xmm600.naddr1   = ""                       /*New address line 1*/
                      sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
                      sicsyac.xmm600.naddr2   = ""                       /*New address line 2*/
                      sicsyac.xmm600.fax      = ""                       /*Fax No.*/
                      sicsyac.xmm600.naddr3   = ""                       /*New address line 3*/
                      sicsyac.xmm600.telex    = ""                       /*Telex No.*/
                      sicsyac.xmm600.naddr4   = ""                       /*New address line 4*/
                      sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
                      sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
                      sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
                      sicsyac.xmm600.nphone   = ""                       /*New phone no.*/    
                      sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
                      sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
                      sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
                      sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
                      sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
                      sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
                      sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
                       /*---
                      /* xmm600 *//*Add by Kridtiya i. A63-0472*/
                      sicsyac.xmm600.acno_typ  = sic_bran.xmm600.acno_typ    
                      sicsyac.xmm600.firstname = sic_bran.xmm600.firstname 
                      sicsyac.xmm600.lastName  = sic_bran.xmm600.lastName  
                      sicsyac.xmm600.postcd    = sic_bran.xmm600.postcd    
                      sicsyac.xmm600.icno      = sic_bran.xmm600.icno      
                      sicsyac.xmm600.codeocc   = sic_bran.xmm600.codeocc   
                      sicsyac.xmm600.codeaddr1 = sic_bran.xmm600.codeaddr1 
                      sicsyac.xmm600.codeaddr2 = sic_bran.xmm600.codeaddr2 
                      sicsyac.xmm600.codeaddr3 = sic_bran.xmm600.codeaddr3 
                      sicsyac.xmm600.anlyc5    = sic_bran.xmm600.anlyc5  . 
                      /*Add by Kridtiya i. A63-0472*/
                      comment BY Chaiyong W. A65-0253 25/04/2023*/

                      /*---Begin by Chaiyong W. A65-0253 25/04/2023*/
                      sicsyac.xmm600.firstname = sic_bran.uwm100.firstname 
                      sicsyac.xmm600.lastName  = sic_bran.uwm100.lastName  
                      sicsyac.xmm600.postcd    = sic_bran.uwm100.postcd    
                      sicsyac.xmm600.icno      = sic_bran.uwm100.icno      
                      sicsyac.xmm600.codeocc   = sic_bran.uwm100.codeocc   
                      sicsyac.xmm600.codeaddr1 = sic_bran.uwm100.codeaddr1 
                      sicsyac.xmm600.codeaddr2 = sic_bran.uwm100.codeaddr2 
                      sicsyac.xmm600.codeaddr3 = sic_bran.uwm100.codeaddr3 
                      sicsyac.xmm600.anlyc5    = sic_bran.uwm100.br_insured    .
                      /*End by Chaiyong W. A65-0253 25/04/2023-----*/

                      
    
                      /*
                      FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = sic_bran.uwm100.insref NO-LOCK NO-ERROR NO-WAIT.
                      IF NOT AVAILABLE sicsyac.xtm600 THEN DO:    
                      comment by Chaiyong W. A66-004830/03/2023*/
                      /*---begin by Chaiyong W. A66-0048 30/03/2023*/
                      loop_xtm600U:
                      REPEAT:
                          FIND  sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = CAPS(sic_bran.uwm100.insref) EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                          IF NOT AVAILABLE sicsyac.xtm600 THEN DO:  /*-- Create ใหม่เท่านั้น --*/
                              IF LOCKED(sicsyac.xtm600) THEN DO:
                                  /*---Begin by Chaiyong W. A65-0253 25/04/2023*/
                                  IF nv_time = 0 THEN nv_time = TIME .
                                  IF (nv_time + nv_wtime) < TIME OR nv_time > TIME THEN DO:
                                      nv_time = 0.
                                      FIND   sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = CAPS(sic_bran.uwm100.insref)   EXCLUSIVE-LOCK NO-ERROR.
                                  END.
                                  /*End by Chaiyong W. A65-0253 25/04/2023-----*/
                    
                                  NEXT loop_xtm600U.
                              END.
                             
            
                         /*end by Chaiyong W. A66-0048 30/03/2023-----*/
                             CREATE sicsyac.xtm600.          
                             ASSIGN                                           
                               sicsyac.xtm600.acno    = sic_bran.uwm100.insref  /*Account no.*/
                               sicsyac.xtm600.name    = sic_bran.uwm100.name1   /*Name of Insured Line 1*/
                               sicsyac.xtm600.abname  = sic_bran.uwm100.name1   /*Abbreviated Name*/
                               sicsyac.xtm600.addr1   = sic_bran.uwm100.addr1   /*address line 1*/
                               sicsyac.xtm600.addr2   = sic_bran.uwm100.addr2   /*address line 2*/
                               sicsyac.xtm600.addr3   = sic_bran.uwm100.addr3   /*address line 3*/
                               /*--
                               sicsyac.xtm600.addr4   = trim(sic_bran.uwm100.addr4 + " " +  sic_bran.uwm100.postcd)  /*address line 4*/
                               comment by Chaiyong W. A66-0048 21/03/2023*/
                               sicsyac.xtm600.addr4   = trim(sic_bran.uwm100.addr4)  /*--add by Chaiyong W. A66-0048 21/03/2023*/
                               sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
                               sicsyac.xtm600.ntitle  = sic_bran.uwm100.ntitle  /*Title*/
                               sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
                               sicsyac.xtm600.fname   = ""                     /*First Name*/          
                               sicsyac.xtm600.postcd    = sic_bran.uwm100.postcd       /*Add by Kridtiya i. A63-0472*/
                               sicsyac.xtm600.firstname = sic_bran.uwm100.firstname    /*Add by Kridtiya i. A63-0472*/
                               sicsyac.xtm600.lastname  = sic_bran.uwm100.lastname .   /*Add by Kridtiya i. A63-0472*/
                          END. /*-- sicsyac.xtm600--*/
                          /*---begin by Chaiyong W. A66-0048 30/03/2023*/
                         LEAVE loop_xtm600U.
                     END.
                     /*end by Chaiyong W. A66-0048 30/03/2023-----*/
                END. /*-- Create sicsyac.xmm600 --*/
                /*---begin by Chaiyong W. A66-0048 30/03/2023*/
                LEAVE loop_xmm600U.
             END.
             /*end by Chaiyong W. A66-0048 30/03/2023-----*/
       END. /* ELSE DO:*/
       /*
       RELEASE sicsyac.xmm600.
       comment by Chaiyong W. A66-0048 30/03/2023*/
       /*---begin by Chaiyong W. A66-0048 30/03/2023*/
       RELEASE sicsyac.xmm600 NO-ERROR.
       RELEASE sicsyac.xtm600 NO-ERROR.
    
       
       /*end by Chaiyong W. A66-0048 30/03/2023-----*/
END PROCEDURE.

PROCEDURE pd_upxmm601 :
    


    /*--
    CREATE sicsyac.xmm601.
    ASSIGN
        sicsyac.xmm601.acno   =  sicsyac.xmm600.acno      sicsyac.xmm601.gpstcs =  sicsyac.xmm600.gpstcs
        sicsyac.xmm601.gpage  =  sicsyac.xmm600.gpage     sicsyac.xmm601.gpstmt =  sicsyac.xmm600.gpstmt
        sicsyac.xmm601.or1ref =  sicsyac.xmm600.or1ref    sicsyac.xmm601.or2ref =  sicsyac.xmm600.or2ref
        sicsyac.xmm601.or1com =  sicsyac.xmm600.or1com    sicsyac.xmm601.or2com =  sicsyac.xmm600.or2com
        sicsyac.xmm601.or1gn  =  sicsyac.xmm600.or1gn     sicsyac.xmm601.or2gn  =  sicsyac.xmm600.or2gn
        sicsyac.xmm601.ntitle =  sicsyac.xmm600.ntitle    sicsyac.xmm601.fname  =  sicsyac.xmm600.fname
        sicsyac.xmm601.name   =  sicsyac.xmm600.name      sicsyac.xmm601.abname =  sicsyac.xmm600.abname
        sicsyac.xmm601.icno   =  sicsyac.xmm600.icno      sicsyac.xmm601.addr1  =  sicsyac.xmm600.addr1
        sicsyac.xmm601.addr2  =  sicsyac.xmm600.addr2     sicsyac.xmm601.addr3  =  sicsyac.xmm600.addr3
        sicsyac.xmm601.addr4  =  sicsyac.xmm600.addr4     sicsyac.xmm601.frclcd =  sicsyac.xmm600.clicod
        sicsyac.xmm601.fraccd =  sicsyac.xmm600.acccod    sicsyac.xmm601.frclos =  sicsyac.xmm600.closed
        sicsyac.xmm601.amdcod =  sicsyac.xmm601.amdcod    sicsyac.xmm601.relate =  sicsyac.xmm600.relate
        sicsyac.xmm601.notes1 =  sicsyac.xmm600.notes1    sicsyac.xmm601.notes2 =  sicsyac.xmm600.notes2
        sicsyac.xmm601.homebr =  sicsyac.xmm600.homebr    sicsyac.xmm601.opened =  sicsyac.xmm600.opened
        sicsyac.xmm601.prindr =  sicsyac.xmm600.prindr    sicsyac.xmm601.langug =  sicsyac.xmm600.langug
        sicsyac.xmm601.cshdat =  sicsyac.xmm600.cshdat    sicsyac.xmm601.legal  =  sicsyac.xmm600.legal
        sicsyac.xmm601.stattp =  sicsyac.xmm600.stattp    sicsyac.xmm601.autoap =  sicsyac.xmm600.autoap
        sicsyac.xmm601.ltcurr =  sicsyac.xmm600.ltcurr    sicsyac.xmm601.ltamt  =  sicsyac.xmm600.ltamt
        sicsyac.xmm601.exec   =  sicsyac.xmm600.exec      sicsyac.xmm601.cntry  =  sicsyac.xmm600.cntry
        sicsyac.xmm601.postcd =  sicsyac.xmm600.postcd    sicsyac.xmm601.phone  =  sicsyac.xmm600.phone
        sicsyac.xmm601.telex  =  sicsyac.xmm600.telex     sicsyac.xmm601.fax    = sicsyac.xmm600.fax
        sicsyac.xmm601.crper  =  sicsyac.xmm600.crper     sicsyac.xmm601.pvfeq  =  sicsyac.xmm600.pvfeq
        sicsyac.xmm601.comtab =  sicsyac.xmm600.comtab    sicsyac.xmm601.chgpol =  sicsyac.xmm600.chgpol
        sicsyac.xmm601.regagt =  sicsyac.xmm600.regagt    sicsyac.xmm601.agtreg =  sicsyac.xmm600.agtreg
        sicsyac.xmm601.debtyn =  sicsyac.xmm600.debtyn    sicsyac.xmm601.crcon  =  sicsyac.xmm600.crcon
        sicsyac.xmm601.muldeb =  sicsyac.xmm600.muldeb    sicsyac.xmm601.styp20 =  sicsyac.xmm600.styp20
        sicsyac.xmm601.sval20 =  sicsyac.xmm600.sval20    sicsyac.xmm601.dtyp20 =  sicsyac.xmm600.dtyp20
        sicsyac.xmm601.dval20 =  sicsyac.xmm600.dval20    sicsyac.xmm601.iblack =  sicsyac.xmm600.iblack
        sicsyac.xmm601.closed =  sicsyac.xmm600.closed    sicsyac.xmm601.oldic  =  sicsyac.xmm600.oldic
        sicsyac.xmm600.regdate = sicsyac.xmm600.regdate.
    
    ASSIGN
        sicsyac.xmm601.toclcd = sicsyac.xmm600.clicod     sicsyac.xmm601.toaccd = sicsyac.xmm600.acccod
        sicsyac.xmm601.toclos = sicsyac.xmm600.closed     sicsyac.xmm601.entdat = sicsyac.xmm600.entdat
        sicsyac.xmm601.enttim = sicsyac.xmm600.enttim     sicsyac.xmm601.usrid  = sicsyac.xmm600.usrid.
    ASSIGN
        sicsyac.xmm601.br_insure      =   sicsyac.xmm600.br_insure          
        sicsyac.xmm601.birthdate      =   sicsyac.xmm600.birthdate          
        sicsyac.xmm601.lasercode      =   sicsyac.xmm600.lasercode          
        sicsyac.xmm601.expdat_id      =   sicsyac.xmm600.expdat_id          
        sicsyac.xmm601.phone1         =   sicsyac.xmm600.phone1             
        sicsyac.xmm601.crper1         =   sicsyac.xmm600.crper1             
        sicsyac.xmm601.bankcard       =   sicsyac.xmm600.bankcard           
        sicsyac.xmm601.acno_typ       =   sicsyac.xmm600.acno_typ           
        sicsyac.xmm601.id_typ         =   sicsyac.xmm600.id_typ             
        sicsyac.xmm601.sex            =   sicsyac.xmm600.sex                
        sicsyac.xmm601.maritalsts     =   sicsyac.xmm600.maritalsts         
        sicsyac.xmm601.addr           =   sicsyac.xmm600.addr               
        sicsyac.xmm601.unitNo         =   sicsyac.xmm600.unitNo             
        sicsyac.xmm601.roomNo         =   sicsyac.xmm600.roomNo             
        sicsyac.xmm601.building       =   sicsyac.xmm600.building           
        sicsyac.xmm601.village        =   sicsyac.xmm600.village            
        sicsyac.xmm601.alley          =   sicsyac.xmm600.alley              
        sicsyac.xmm601.lane           =   sicsyac.xmm600.lane               
        sicsyac.xmm601.street         =   sicsyac.xmm600.street             
        sicsyac.xmm601.subdistrict    =   sicsyac.xmm600.subdistrict        
        sicsyac.xmm601.district       =   sicsyac.xmm600.district           
        sicsyac.xmm601.province       =   sicsyac.xmm600.province           
        sicsyac.xmm601.firstName      =   sicsyac.xmm600.firstName          
        sicsyac.xmm601.midName        =   sicsyac.xmm600.midName            
        sicsyac.xmm601.lastName       =   sicsyac.xmm600.lastName           
        sicsyac.xmm601.nbr_insure     =   sicsyac.xmm600.nbr_insure         
        sicsyac.xmm601.nlasercode     =   sicsyac.xmm600.nlasercode         
        sicsyac.xmm601.nexpdat_id     =   sicsyac.xmm600.nexpdat_id         
        sicsyac.xmm601.nid_typ        =   sicsyac.xmm600.nid_typ            
        sicsyac.xmm601.naddr          =   sicsyac.xmm600.naddr              
        sicsyac.xmm601.nunitNo        =   sicsyac.xmm600.nunitNo            
        sicsyac.xmm601.nroomNo        =   sicsyac.xmm600.nroomNo            
        sicsyac.xmm601.nbuilding      =   sicsyac.xmm600.nbuilding          
        sicsyac.xmm601.nvillage       =   sicsyac.xmm600.nvillage           
        sicsyac.xmm601.nalley         =   sicsyac.xmm600.nalley             
        sicsyac.xmm601.nlane          =   sicsyac.xmm600.nlane              
        sicsyac.xmm601.nstreet        =   sicsyac.xmm600.nstreet            
        sicsyac.xmm601.nsubdistrict   =   sicsyac.xmm600.nsubdistrict       
        sicsyac.xmm601.ndistrict      =   sicsyac.xmm600.ndistrict          
        sicsyac.xmm601.nprovince      =   sicsyac.xmm600.nprovince          
        sicsyac.xmm601.nfirstName     =   sicsyac.xmm600.nfirstName         
        sicsyac.xmm601.nmidName       =   sicsyac.xmm600.nmidName           
        sicsyac.xmm601.nlastName      =   sicsyac.xmm600.nlastName          
        sicsyac.xmm601.issuedat_id    =   sicsyac.xmm600.issuedat_id        
        sicsyac.xmm601.nationality    =   sicsyac.xmm600.nationality        
        sicsyac.xmm601.nissuedat_id   =   sicsyac.xmm600.nissuedat_id       
        sicsyac.xmm601.nnationality   =   sicsyac.xmm600.nnationality     .  
    ASSIGN
        sicsyac.xmm601.ccupation      = sicsyac.xmm600.occupation  
        sicsyac.xmm601.naddr1         = sicsyac.xmm600.naddr1           
        sicsyac.xmm601.naddr2         = sicsyac.xmm600.naddr2           
        sicsyac.xmm601.naddr3         = sicsyac.xmm600.naddr3           
        sicsyac.xmm601.naddr4         = sicsyac.xmm600.naddr4           
        sicsyac.xmm601.npostcd        = sicsyac.xmm600.npostcd          
        sicsyac.xmm601.nphone         = sicsyac.xmm600.nphone           
        sicsyac.xmm601.nachg          = sicsyac.xmm600.nachg            
        sicsyac.xmm601.regdate        = sicsyac.xmm600.regdate          
        sicsyac.xmm601.alevel         = sicsyac.xmm600.alevel           
        sicsyac.xmm601.taxno          = sicsyac.xmm600.taxno            
        sicsyac.xmm601.anlyc1         = sicsyac.xmm600.anlyc1           
        sicsyac.xmm601.taxdate        = sicsyac.xmm600.taxdate          
        sicsyac.xmm601.anlyc5         = sicsyac.xmm600.anlyc5           
        sicsyac.xmm601.mcode          = sicsyac.xmm600.mcode            
        sicsyac.xmm601.mcdes          = sicsyac.xmm600.mcdes            
        sicsyac.xmm601.winscd         = sicsyac.xmm600.winscd           
        sicsyac.xmm601.coderef1       = sicsyac.xmm600.coderef1         
        sicsyac.xmm601.coderef2       = sicsyac.xmm600.coderef2         
        sicsyac.xmm601.coderef3       = sicsyac.xmm600.coderef3         
        sicsyac.xmm601.codeocc        = sicsyac.xmm600.codeocc          
        sicsyac.xmm601.codeaddr1      = sicsyac.xmm600.codeaddr1        
        sicsyac.xmm601.codeaddr2      = sicsyac.xmm600.codeaddr2        
        sicsyac.xmm601.codeaddr3      = sicsyac.xmm600.codeaddr3        
        sicsyac.xmm601.bankcode       = sicsyac.xmm600.bankcode         
        sicsyac.xmm601.passport       = sicsyac.xmm600.passport         
        sicsyac.xmm601.race           = sicsyac.xmm600.race    
        sicsyac.xmm601.email          = sicsyac.xmm600.email
        sicsyac.xmm601.tel            = sicsyac.xmm600.tel
        sicsyac.xmm601.lineid         = sicsyac.xmm600.lineid           
        sicsyac.xmm601.cros           = sicsyac.xmm600.cros             
        sicsyac.xmm601.nname2         = sicsyac.xmm600.nname2           
        sicsyac.xmm601.nicno          = sicsyac.xmm600.nicno  
        sicsyac.xmm601.nntitle        = sicsyac.xmm600.nntitle    .   
    ASSIGN
        sicsyac.xmm601.consent1       = sicsyac.xmm600.consent1
        sicsyac.xmm601.consdat1       = sicsyac.xmm600.consdat1
        sicsyac.xmm601.constim1       = sicsyac.xmm600.constim1
        sicsyac.xmm601.consnot1       = sicsyac.xmm600.consnot1
        sicsyac.xmm601.consent2       = sicsyac.xmm600.consent2
        sicsyac.xmm601.consdat2       = sicsyac.xmm600.consdat2
        sicsyac.xmm601.constim2       = sicsyac.xmm600.constim2
        sicsyac.xmm601.consnot2       = sicsyac.xmm600.consnot2. 
    comment by Chaiyong W. A67-0066 16/01/2025*/
    /*---Begin by Chaiyong W. A67-0066 16/01/2025*/
    DEF VAR nv_recxmm601 AS RECID INIT ?.
    RUN wxm\wxmm02900(INPUT sicsyac.xmm600.acno,OUTPUT nv_recxmm601).
    /*End by Chaiyong W. A67-0066 16/01/2025-----*/
END PROCEDURE.

/*End by Chaiyong W. A65-0180 26/07/2022-----*/
