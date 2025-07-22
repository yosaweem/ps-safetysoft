/*=================================================================*/
/* Program Name : wgwtim01.p   Gen. Data Uwm100 To DB Premium      */
/* Assign  No   : A57-0096                                         */
/* CREATE  By   : Porntiwa P.           (Date 20/06/2014)          */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/* Duplicatie Program : wgwgen01.p                                 */   
/* Modify by : Chaiyong W. A59-0312 07/07/2016 correct status rel  */ 
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

DEF VAR nv_invtyp        AS CHAR.  /*A57-0096*/
DEF VAR nv_i AS INT.
DEFINE VAR nv_fptr       AS RECID.
DEFINE VAR nv_bptr       AS RECID.
DEFINE BUFFER wf_uwd100 FOR sicuw.uwd100.
DEFINE VAR nv_fptr1      AS RECID.
DEFINE VAR nv_bptr2      AS RECID.
DEFINE BUFFER wf_uwd102 FOR sicuw.uwd102.

DEFINE VAR nv_insref     AS CHAR FORMAT "X(10)" INIT "".
DEFINE VAR nv_ntitle     AS CHAR FORMAT "X(20)" INIT "".
DEFINE VAR nv_name1      AS CHAR FORMAT "X(60)" INIT "".

nv_i = nv_i + 1.
FIND sic_bran.uwm100 USE-INDEX uwm10001 WHERE 
     sic_bran.uwm100.policy = nv_policy AND
     sic_bran.uwm100.rencnt = nv_rencnt AND
     sic_bran.uwm100.endcnt = nv_endcnt AND
     sic_bran.uwm100.bchyr  = nv_bchyr  AND
     sic_bran.uwm100.bchno  = nv_bchno  AND
     sic_bran.uwm100.bchcnt = nv_bchcnt NO-ERROR.
IF AVAIL sic_bran.uwm100 THEN DO: 

    FIND FIRST sicsyac.xmm600 USE-INDEX xmm60002 WHERE
               sicsyac.xmm600.NAME = sic_bran.uwm100.name1 NO-ERROR.
    IF AVAIL sicsyac.xmm600 THEN DO:
        ASSIGN
            sicsyac.xmm600.addr1 = sic_bran.uwm100.addr1
            sicsyac.xmm600.addr2 = sic_bran.uwm100.addr2
            sicsyac.xmm600.addr3 = sic_bran.uwm100.addr3
            sicsyac.xmm600.addr4 = sic_bran.uwm100.addr4
            nv_insref            = sicsyac.xmm600.acno
            nv_ntitle            = sicsyac.xmm600.ntitle
            nv_name1             = sicsyac.xmm600.NAME.

        FIND FIRST sicsyac.xtm600 USE-INDEX xtm60002 WHERE
                   sicsyac.xtm600.acno = sicsyac.xmm600.acno NO-ERROR.
        IF AVAIL sicsyac.xtm600 THEN DO:
            ASSIGN
                sicsyac.xtm600.addr1 = sicsyac.xmm600.addr1
                sicsyac.xtm600.addr2 = sicsyac.xmm600.addr2
                sicsyac.xtm600.addr3 = sicsyac.xmm600.addr3
                sicsyac.xtm600.addr4 = sicsyac.xmm600.addr4.
        END.
    END.
    ELSE DO:
        FIND LAST sic_bran.xmm600 USE-INDEX xmm60001 WHERE
                  sic_bran.xmm600.acno = sic_bran.uwm100.insref NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.xmm600 THEN DO:
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
                sicsyac.xmm600.anlyc1   = sic_bran.xmm600.anlyc1     /*Analysis Code 1*/                                      
                sicsyac.xmm600.taxdate  = sic_bran.xmm600.taxdate    /*Agent tax date*/                                       
                sicsyac.xmm600.anlyc5   = sic_bran.xmm600.anlyc5 .   /*Analysis Code 5*/      

            FIND FIRST sicsyac.xtm600 USE-INDEX xtm60002
                 WHERE sicsyac.xtm600.NAME  = sic_bran.xmm600.NAME NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE sicsyac.xtm600 THEN DO:  /*-- Create ใหม่เท่านั้น --*/
               CREATE sicsyac.xtm600.                         
               ASSIGN
                    sicsyac.xtm600.acno    = sic_bran.xmm600.acno   /*Account no.*/
                    sicsyac.xtm600.name    = sic_bran.xmm600.NAME   /*Name of Insured Line 1*/
                    sicsyac.xtm600.abname  = sic_bran.xmm600.NAME   /*Abbreviated Name*/
                    sicsyac.xtm600.addr1   = sic_bran.xmm600.addr1  /*address line 1*/
                    sicsyac.xtm600.addr2   = sic_bran.xmm600.addr2  /*address line 2*/
                    sicsyac.xtm600.addr3   = sic_bran.xmm600.addr3  /*address line 3*/
                    sicsyac.xtm600.addr4   = sic_bran.xmm600.addr4  /*address line 4*/
                    sicsyac.xtm600.name2   = sic_bran.xmm600.name2  /*Name of Insured Line 2*/
                    sicsyac.xtm600.ntitle  = sic_bran.xmm600.ntitle /*Title*/
                    sicsyac.xtm600.name3   = sic_bran.xmm600.name3  /*Name of Insured Line 3*/
                    sicsyac.xtm600.fname   = sic_bran.xmm600.fname. /*First Name*/
            END.
        END.
        ELSE DO:
            CREATE sicsyac.xmm600.
            ASSIGN
               sicsyac.xmm600.acno     = sic_bran.uwm100.insref    /*Account no*/
               sicsyac.xmm600.gpstcs   = sic_bran.uwm100.insref    /*Group A/C for statistics*/
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
               sicsyac.xmm600.icno     = sic_bran.uwm100.anam2     /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
               sicsyac.xmm600.addr1    = sic_bran.uwm100.addr1     /*Address line 1*/
               sicsyac.xmm600.addr2    = sic_bran.uwm100.addr2     /*Address line 2*/
               sicsyac.xmm600.addr3    = sic_bran.uwm100.addr3     /*Address line 3*/
               sicsyac.xmm600.addr4    = sic_bran.uwm100.addr4     /*Address line 4*/
               sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
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
               sicsyac.xmm600.anlyc5   =  "" .                    /*Analysis Code 5*/
    
            FIND sicsyac.xtm600 USE-INDEX xtm60002
               WHERE sicsyac.xtm600.NAME  = sic_bran.uwm100.NAME1 NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE sicsyac.xtm600 THEN DO:                               
               CREATE sicsyac.xtm600.          
               ASSIGN                                           
                   sicsyac.xtm600.acno    = sic_bran.uwm100.insref  /*Account no.*/
                   sicsyac.xtm600.name    = sic_bran.uwm100.name1   /*Name of Insured Line 1*/
                   sicsyac.xtm600.abname  = sic_bran.uwm100.name1   /*Abbreviated Name*/
                   sicsyac.xtm600.addr1   = sic_bran.uwm100.addr1   /*address line 1*/
                   sicsyac.xtm600.addr2   = sic_bran.uwm100.addr2   /*address line 2*/
                   sicsyac.xtm600.addr3   = sic_bran.uwm100.addr3   /*address line 3*/
                   sicsyac.xtm600.addr4   = sic_bran.uwm100.addr4   /*address line 4*/
                   sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
                   sicsyac.xtm600.ntitle  = sic_bran.uwm100.ntitle  /*Title*/
                   sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
                   sicsyac.xtm600.fname   = "" .                    /*First Name*/          
            END. /*-- sicsyac.xtm600--*/
        END.
    END.

    FIND sicuw.uwm100 USE-INDEX uwm10001 WHERE 
         sicuw.uwm100.policy = sic_bran.uwm100.Policy AND
         sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt AND
         sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt NO-ERROR.
    IF NOT AVAIL sicuw.uwm100 THEN DO:    

            CREATE sicuw.uwm100.  
            ASSIGN
                sicuw.uwm100.fptr01 = 0                          /*First uwd100 Policy Up reci  */
                sicuw.uwm100.bptr01 = 0                          /*Last  uwd100 Policy Up reci  */
                sicuw.uwm100.fptr02 = 0                          /*First uwd102 Policy Me reci  */
                sicuw.uwm100.bptr02 = 0                          /*Last  uwd102 Policy Me reci  */
                sicuw.uwm100.fptr03 = 0                          /*First uwd105 Policy Cl reci  */
                sicuw.uwm100.bptr03 = 0                          /*Last  uwd105 Policy Cl reci  */
                sicuw.uwm100.fptr04 = 0                          /*First uwd103 Policy Re reci  */
                sicuw.uwm100.bptr04 = 0                          /*Last  uwd103 Policy Ren reci  */
                sicuw.uwm100.fptr05 = 0                          /*First uwd104 Policy En reci  */
                sicuw.uwm100.bptr05 = 0                          /*Last  uwd104 Policy End reci  */
                sicuw.uwm100.fptr06 = 0                          /*First uwd106 Pol.Endt. reci  */
                sicuw.uwm100.bptr06 = 0                          /*Last  uwd106 Pol. Endt. reci  */
                /* ----------------------------------- */          
                sicuw.uwm100.policy = sic_bran.uwm100.Policy     /*Policy No.             char  */
                sicuw.uwm100.rencnt = sic_bran.uwm100.rencnt     /*Renewal Count          inte  */
                sicuw.uwm100.endcnt = sic_bran.uwm100.endcnt     /*Endorsement Count      inte  */
                sicuw.uwm100.renno  = sic_bran.uwm100.renno      /*Renewal No.            char  */
                sicuw.uwm100.endno  = sic_bran.uwm100.endno      /*Endorsement No.        char  */
                sicuw.uwm100.curbil = sic_bran.uwm100.curbil     /*Currency of Billing    char  */
                sicuw.uwm100.curate = sic_bran.uwm100.curate     /*Currency rate for Bill deci-7*/
                sicuw.uwm100.branch = sic_bran.uwm100.branch     /*Branch Code (of Transa char  */ 
                sicuw.uwm100.dir_ri = sic_bran.uwm100.dir_ri     /*Direct/RI Code (D/R)   logi  */ 
                sicuw.uwm100.dept   = sic_bran.uwm100.dept       /*Department code        char  */ 
                sicuw.uwm100.cntry  = sic_bran.uwm100.cntry      /*Country where risk is  char  */ 
                sicuw.uwm100.agent  = sic_bran.uwm100.agent      /*Agent's Ref. No.       char  */   
                sicuw.uwm100.poltyp = sic_bran.uwm100.Poltyp     /*Policy Type            char  */
                /*sicuw.uwm100.insref = sic_bran.uwm100.insref   /*Insured's Ref. No.     char  */*/
                sicuw.uwm100.insref = IF nv_insref = "" THEN sic_bran.uwm100.insref ELSE nv_insref                
                sicuw.uwm100.opnpol = sic_bran.uwm100.opnpol     /*Open Cover/Master Poli char  */
                sicuw.uwm100.prvpol = sic_bran.uwm100.prvpol     /*Previous Policy No.    char  */
                /*sicuw.uwm100.ntitle = sic_bran.uwm100.ntitle   /*Title for Name Mr/Mrs/ char  */*/
                sicuw.uwm100.ntitle = IF nv_ntitle = "" THEN sic_bran.uwm100.ntitle ELSE nv_ntitle
                sicuw.uwm100.fname  = sic_bran.uwm100.fname      /*First Name             char  */
                /*sicuw.uwm100.name1  = sic_bran.uwm100.name1    /*Name of Insured Line 1 char  */*/
                sicuw.uwm100.name1  = IF nv_name1 = "" THEN sic_bran.uwm100.name1 ELSE nv_name1
                sicuw.uwm100.name2  = sic_bran.uwm100.name2      /*Name of Insured Line 2 char  */
                sicuw.uwm100.name3  = sic_bran.uwm100.name3.     /*Name of Insured Line 3 char  */
                
            ASSIGN                                               
                sicuw.uwm100.addr1  = sic_bran.uwm100.addr1      /*Address 1              char  */
                sicuw.uwm100.addr2  = sic_bran.uwm100.addr2      /*Address 2              char  */
                sicuw.uwm100.addr3  = sic_bran.uwm100.addr3      /*Address 3              char  */
                sicuw.uwm100.addr4  = sic_bran.uwm100.addr4      /*Address 4              char  */
                sicuw.uwm100.postcd = sic_bran.uwm100.postcd     /*Postal Code            char  */
                sicuw.uwm100.occupn = sic_bran.uwm100.occupn     /*Occupation Description char  */
                sicuw.uwm100.comdat = sic_bran.uwm100.comdat     /*Cover Commencement Dat date  */
                sicuw.uwm100.expdat = sic_bran.uwm100.expdat     /*Expiry Date            date  */
                sicuw.uwm100.enddat = sic_bran.uwm100.enddat     /*Endorsement Date       date  */
                sicuw.uwm100.accdat = sic_bran.uwm100.accdat     /*Acceptance Date        date  */
                sicuw.uwm100.trndat = sic_bran.uwm100.trndat     /*Transaction Date       date  */
                sicuw.uwm100.rendat = sic_bran.uwm100.rendat     /*Date Renewal Notice Pr date  */
                sicuw.uwm100.terdat = sic_bran.uwm100.terdat     /*Termination Date       date  */
                sicuw.uwm100.fstdat = sic_bran.uwm100.fstdat     /*First Issue Date of Po date  */
                sicuw.uwm100.cn_dat = sic_bran.uwm100.cn_dat     /*Cover Note Date        date  */
                sicuw.uwm100.cn_no  = sic_bran.uwm100.cn_no      /*Cover Note No.         inte  */
                sicuw.uwm100.tranty = sic_bran.uwm100.tranty     /*Transaction Type (N/R/ char  */
                sicuw.uwm100.undyr  = sic_bran.uwm100.undyr      /*Underwriting Year      char  */
                sicuw.uwm100.acno1  = sic_bran.uwm100.acno1      /*Account no. 1          char  */
                sicuw.uwm100.acno2  = sic_bran.uwm100.acno2      /*Account no. 2          char  */
                sicuw.uwm100.acno3  = sic_bran.uwm100.acno3      /*Account no. 3          char  */
                sicuw.uwm100.instot = sic_bran.uwm100.instot     /*Total No. of Instalmen deci-0*/
                sicuw.uwm100.pstp   = sic_bran.uwm100.pstp       /*Policy Level Stamp     deci-2*/
                sicuw.uwm100.pfee   = sic_bran.uwm100.pfee       /*Policy Level Fee       deci-2*/
                sicuw.uwm100.ptax   = sic_bran.uwm100.ptax       /*Policy Level Tax       deci-2*/
                sicuw.uwm100.rstp_t = sic_bran.uwm100.rstp_t     /*Risk Level Stamp, Tran deci-2*/
                sicuw.uwm100.rfee_t = sic_bran.uwm100.rfee_t     /*Risk Level Fee, Tran.  deci-2*/
                sicuw.uwm100.rtax_t = sic_bran.uwm100.rtax_t     /*Risk Level Tax, Tran.  deci-2*/
                sicuw.uwm100.prem_t = sic_bran.uwm100.prem_t     /*Premium Due, Tran. Tot deci-2*/
                sicuw.uwm100.pdco_t = sic_bran.uwm100.pdco_t     /*PD Coinsurance, Tran.  deci-2*/
                sicuw.uwm100.pdst_t = sic_bran.uwm100.pdst_t     /*PD Statutory, Tran. to deci-2*/
                sicuw.uwm100.pdfa_t = sic_bran.uwm100.pdfa_t     /*PD Facultative, Tran.  deci-2*/
                sicuw.uwm100.pdty_t = sic_bran.uwm100.pdty_t     /*PD Treaty, Tran. Total deci-2*/
                sicuw.uwm100.pdqs_t = sic_bran.uwm100.pdqs_t.    /*PD Quota Share, Tran.  deci-2*/
        
            ASSIGN                                               
                sicuw.uwm100.com1_t = sic_bran.uwm100.com1_t     /*Commission 1, Tran. To deci-2*/
                sicuw.uwm100.com2_t = sic_bran.uwm100.com2_t     /*Commission 2, Tran. To deci-2*/
                sicuw.uwm100.com3_t = sic_bran.uwm100.com3_t     /*Commission 3, Tran. To deci-2*/
                sicuw.uwm100.com4_t = sic_bran.uwm100.com4_t     /*Commission 4, Tran. To deci-2*/
                sicuw.uwm100.coco_t = sic_bran.uwm100.coco_t     /*Comm. Coinsurance, Tra deci-2*/
                sicuw.uwm100.cost_t = sic_bran.uwm100.cost_t     /*Comm. Statutory, Tran. deci-2*/
                sicuw.uwm100.cofa_t = sic_bran.uwm100.cofa_t     /*Comm. Facultative, Tra deci-2*/
                sicuw.uwm100.coty_t = sic_bran.uwm100.coty_t     /*Comm. Treaty, Tran. To deci-2*/
                sicuw.uwm100.coqs_t = sic_bran.uwm100.coqs_t     /*Comm. Quota Share, Tra deci-2*/
                sicuw.uwm100.reduc1 = sic_bran.uwm100.reduc1     /*Reducing Balance 1 (Y/ logi  */
                sicuw.uwm100.reduc2 = sic_bran.uwm100.reduc2     /*Reducing Balance 2 (Y/ logi  */
                sicuw.uwm100.reduc3 = sic_bran.uwm100.reduc3     /*Reducing Balance 3 (Y/ logi  */
                sicuw.uwm100.gap_p  = sic_bran.uwm100.gap_p      /*Gross Annual Prem, Pol deci-2*/
                sicuw.uwm100.dl1_p  = sic_bran.uwm100.dl1_p      /*Discount/Loading 1, Po deci-2*/
                sicuw.uwm100.dl2_p  = sic_bran.uwm100.dl2_p      /*Discount/Loading 2, Po deci-2*/
                sicuw.uwm100.dl3_p  = sic_bran.uwm100.dl3_p      /*Discount/Loading 3, Po deci-2*/
                sicuw.uwm100.dl2red = sic_bran.uwm100.dl2red     /*Disc./Load 2 Red. Bala logi  */
                sicuw.uwm100.dl3red = sic_bran.uwm100.dl3red     /*Disc./Load 3 Red. Bala logi  */
                sicuw.uwm100.dl1sch = sic_bran.uwm100.dl1sch     /*Disc./Load 1 Prt on Sc logi  */
                sicuw.uwm100.dl2sch = sic_bran.uwm100.dl2sch     /*Disc./Load 2 Prt on Sc logi  */
                sicuw.uwm100.dl3sch = sic_bran.uwm100.dl3sch     /*Disc./Load 3 Prt on Sc logi  */
                sicuw.uwm100.drnoae = sic_bran.uwm100.drnoae     /*Dr/Cr Note No. (A/E)   logi  */
                sicuw.uwm100.insddr = sic_bran.uwm100.insddr     /*Print Insd. Name on Dr logi  */
                sicuw.uwm100.trty11 = sic_bran.uwm100.trty11     /*Tran. Type (1), A/C No char  */
                sicuw.uwm100.trty12 = sic_bran.uwm100.trty12     /*Tran. Type (1), A/C No char  */
                /*sicuw.uwm100.trty13 = sic_bran.uwm100.trty13   /*Tran. Type (1), A/C No char  */*//*Comment A57-0096*/
                sicuw.uwm100.trty13 = ""                         /*Tran. Type (1), A/C No char  *//*A57-0096*/
                sicuw.uwm100.docno1 = sic_bran.uwm100.docno1     /*Document No., A/C No.  char  */
                sicuw.uwm100.docno2 = sic_bran.uwm100.docno2     /*Document No., A/C No.  char  */
                sicuw.uwm100.docno3 = sic_bran.uwm100.docno3     /*Document No., A/C No.  char  */
                sicuw.uwm100.no_sch = sic_bran.uwm100.no_sch     /*No. to print, Schedule inte  */
                sicuw.uwm100.no_dr  = sic_bran.uwm100.no_dr      /*No. to print, Dr/Cr No inte  */
                sicuw.uwm100.no_ri  = sic_bran.uwm100.no_ri      /*No. to print, RI Appln inte  */
                sicuw.uwm100.no_cer = sic_bran.uwm100.no_cer.    /*No. to print, Certific inte  */
        
            ASSIGN                                               
                sicuw.uwm100.li_sch = sic_bran.uwm100.li_sch     /*Print Later/Imm., Sche logi  */
                sicuw.uwm100.li_dr  = sic_bran.uwm100.li_dr      /*Print Later/Imm., Dr/C logi  */
                sicuw.uwm100.li_ri  = sic_bran.uwm100.li_ri      /*Print Later/Imm., RI A logi  */
                sicuw.uwm100.li_cer = sic_bran.uwm100.li_cer     /*Print Later/Imm., Cert logi  */
                sicuw.uwm100.scform = sic_bran.uwm100.scform     /*Schedule Format        char  */
                sicuw.uwm100.enform = sic_bran.uwm100.enform     /*Endt. Format (Full/Abb char  */
                sicuw.uwm100.apptax = sic_bran.uwm100.apptax     /*Apply risk level tax ( logi  */
                sicuw.uwm100.dl1cod = sic_bran.uwm100.dl1cod     /*Discount/Loading Type  char  */
                sicuw.uwm100.dl2cod = sic_bran.uwm100.dl2cod     /*Discount/Loading Type  char  */
                sicuw.uwm100.dl3cod = sic_bran.uwm100.dl3cod     /*Discount/Loading Type  char  */
                sicuw.uwm100.styp20 = sic_bran.uwm100.styp20     /*Statistic Type Codes ( char  */
                sicuw.uwm100.sval20 = sic_bran.uwm100.sval20     /*Statistic Value Codes  char  */
                sicuw.uwm100.finint = sic_bran.uwm100.finint     /*Financial Interest Ref char  */
                sicuw.uwm100.cedco  = sic_bran.uwm100.cedco      /*Ceding Co. No.         char  */
                sicuw.uwm100.cedsi  = sic_bran.uwm100.cedsi      /*Ceding Co. Sum Insured deci-2*/
                sicuw.uwm100.cedpol = sic_bran.uwm100.cedpol     /*Ceding Co. Policy No.  char  */
                sicuw.uwm100.cedces = sic_bran.uwm100.cedces     /*Ceding Co. Cession No. char  */
                sicuw.uwm100.recip  = sic_bran.uwm100.recip      /*Reciprocal (Y/N/C)     char  */
                sicuw.uwm100.short  = sic_bran.uwm100.short      /*Short Term Rates       logi  */
                sicuw.uwm100.receit = sic_bran.uwm100.receit     /*Receipt No.            char  */
                sicuw.uwm100.coins  = sic_bran.uwm100.coins      /*Is this Coinsurance (Y logi  */
                sicuw.uwm100.billco = sic_bran.uwm100.billco     /*Bill Coinsurer's Share char  */
                sicuw.uwm100.pmhead = sic_bran.uwm100.pmhead     /*Premium Headings on Sc char  */
                sicuw.uwm100.usrid  = n_User /*sic_bran.uwm100.usrid      /*User Id                char  */*/
                sicuw.uwm100.entdat = sic_bran.uwm100.entdat     /*Entered Date           date  */
                sicuw.uwm100.enttim = sic_bran.uwm100.enttim     /*Entered Time           char  */
                /*---
                sicuw.uwm100.prog   = "wgwgen01" + "|" + STRING(nv_bchyr,"9999") +
                                      STRING(nv_bchno) +
                                      STRING(nv_bchcnt,"99")     /*Program Id that input  char  */
                ----comment Jiraphon P. A62-0286*/
                /*Add Jiraphon P. A62-0286*/
                sicuw.uwm100.prog   = sic_bran.uwm100.prog + "|" + STRING(nv_bchyr,"9999") +
                                      STRING(nv_bchno) +
                                      STRING(nv_bchcnt,"99")     /*Program Id that input  char  */
                /*End Add jiraphon P. A62-0286*/
                                                        
                /*sicuw.uwm100.usridr = ""                        /*Release User Id        char  */
                sicuw.uwm100.reldat = TODAY                      /*Release Date           date  */
                sicuw.uwm100.reltim = STRING(TIME,"HH:MM:SS")    /*Release Time           char  */
                sicuw.uwm100.releas = sic_bran.uwm100.releas     /*Transaction Released   logi  */
                */
        
                sicuw.uwm100.polsta = sic_bran.uwm100.polsta     /*Policy Status          char  */
                sicuw.uwm100.rilate = sic_bran.uwm100.rilate     /*RI to Enter Later      logi  */
                
                sicuw.uwm100.sch_p  = sic_bran.uwm100.sch_p      /*Schedule Printed       logi  */
                sicuw.uwm100.drn_p  = sic_bran.uwm100.drn_p      /*Dr/Cr Note Printed     logi  */
                sicuw.uwm100.ri_p   = sic_bran.uwm100.ri_p       /*RI Application Printed logi  */
                sicuw.uwm100.cert_p = sic_bran.uwm100.cert_p     /*Certificate Printed    logi  */
                sicuw.uwm100.dreg_p = sic_bran.uwm100.dreg_p.    /*Daily Prem. Reg. Print logi  */
                    
            ASSIGN                                               
                sicuw.uwm100.langug = sic_bran.uwm100.langug     /*Language               char  */
                sicuw.uwm100.sigr_p = sic_bran.uwm100.sigr_p     /*SI Gross Pol. Total    deci-2*/
                sicuw.uwm100.sico_p = sic_bran.uwm100.sico_p     /*SI Coinsurance Pol. To deci-2*/
                sicuw.uwm100.sist_p = sic_bran.uwm100.sist_p     /*SI Statutory Pol. Tota deci-2*/
                sicuw.uwm100.sifa_p = sic_bran.uwm100.sifa_p     /*SI Facultative Pol. To deci-2*/
                sicuw.uwm100.sity_p = sic_bran.uwm100.sity_p     /*SI Treaty Pol. Total   deci-2*/
                sicuw.uwm100.siqs_p = sic_bran.uwm100.siqs_p     /*SI Quota Share Pol. To deci-2*/
                sicuw.uwm100.renpol = sic_bran.uwm100.renpol     /*Renewal Policy No.     char  */
                sicuw.uwm100.co_per = sic_bran.uwm100.co_per     /*Coinsurance %          deci-2*/
                sicuw.uwm100.acctim = sic_bran.uwm100.acctim     /*Acceptance Time        char  */
                sicuw.uwm100.agtref = sic_bran.uwm100.agtref     /*Agents Closing Referen char  */
                sicuw.uwm100.sckno  = sic_bran.uwm100.sckno      /*sticker no.            inte  */
                sicuw.uwm100.anam1  = sic_bran.uwm100.anam1      /*Alternative Insured Na char  */
                sicuw.uwm100.sirt_p = sic_bran.uwm100.sirt_p     /*SI RETENTION Pol. tota deci-2*/
                sicuw.uwm100.anam2  = sic_bran.uwm100.anam2      /*Alternative Insured Na char  */
                sicuw.uwm100.gstrat = sic_bran.uwm100.gstrat     /*GST Rate %             deci-2*/
                sicuw.uwm100.prem_g = sic_bran.uwm100.prem_g     /*Premium GST            deci-2*/
                sicuw.uwm100.com1_g = sic_bran.uwm100.com1_g     /*Commission 1 GST       deci-2*/
                sicuw.uwm100.com3_g = sic_bran.uwm100.com3_g     /*Commission 3 GST       deci-2*/
                sicuw.uwm100.com4_g = sic_bran.uwm100.com4_g     /*Commission 4 GST       deci-2*/
                sicuw.uwm100.gstae  = sic_bran.uwm100.gstae      /*GST A/E                logi  */
                sicuw.uwm100.nr_pol = sic_bran.uwm100.nr_pol     /*New Policy No. (Y/N)   logi  */
                sicuw.uwm100.issdat = sic_bran.uwm100.issdat     /*Issue date             date  */
                /* --------- */                                    
                sicuw.uwm100.cr_1   = sic_bran.uwm100.cr_1       /*PRODUCT TYPE                 */
                sicuw.uwm100.cr_2   = sic_bran.uwm100.cr_2       /*APPEND POLICY                */
                sicuw.uwm100.cr_3   = sic_bran.uwm100.cr_3       /*                             */
                sicuw.uwm100.bs_cd  = sic_bran.uwm100.bs_cd      /*VAT CODE                     */
                /* --------- */                                    
                sicuw.uwm100.rt_er  = sic_bran.uwm100.rt_er      /*Batch Release          logi  */
                sicuw.uwm100.endern = sic_bran.uwm100.endern.     /*End Date of Earned Pre date  */ 

              /*-- Add,Update uwd100 --*/
              nv_fptr = sic_bran.uwm100.fptr01.
              nv_bptr = 0.
              DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr01 <> ? :
                  FIND sic_bran.uwd100 WHERE RECID(sic_bran.uwd100) = nv_fptr
                  NO-LOCK NO-ERROR.
                  IF AVAIL sic_bran.uwd100 THEN DO:
                      nv_fptr = sic_bran.uwd100.fptr.
                      CREATE sicuw.uwd100.
                      ASSIGN
                          sicuw.uwd100.bptr      = nv_bptr
                          sicuw.uwd100.endcnt    = sic_bran.uwm100.endcnt
                          sicuw.uwd100.fptr      = 0
                          sicuw.uwd100.ltext     = sic_bran.uwd100.ltext
                          sicuw.uwd100.policy    = sic_bran.uwm100.Policy
                          sicuw.uwd100.rencnt    = sic_bran.uwm100.rencnt.

                      IF nv_bptr <> 0 THEN DO:
                          FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                          wf_uwd100.fptr = RECID(sicuw.uwd100).
                      END.
                      IF nv_bptr = 0 THEN sicuw.uwm100.fptr01 = RECID(sicuw.uwd100).
                      nv_bptr = RECID(sicuw.uwd100).
                  END.
              END.
              sicuw.uwm100.bptr01 = nv_bptr.

              /*-- Add, Update uwd102 --*/
              nv_fptr = sic_bran.uwm100.fptr02.
              nv_bptr = 0.
              DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
                  FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr
                  NO-LOCK NO-ERROR.
                  IF AVAILABLE sic_bran.uwd102 THEN DO: 
                      nv_fptr = sic_bran.uwd102.fptr.
                       
                      CREATE sicuw.uwd102.
                      ASSIGN
                        sicuw.uwd102.bptr          = nv_bptr
                        sicuw.uwd102.endcnt        = sic_bran.uwm100.endcnt
                        sicuw.uwd102.fptr          = 0
                        sicuw.uwd102.ltext         = sic_bran.uwd102.ltext
                        sicuw.uwd102.policy        = sic_bran.uwm100.Policy
                        sicuw.uwd102.rencnt        = sic_bran.uwm100.rencnt.
                       
                      IF nv_bptr <> 0 THEN DO:
                        FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
                        wf_uwd102.fptr = RECID(sicuw.uwd102).
                      END.
                      IF nv_bptr = 0 THEN  sicuw.uwm100.fptr02 = RECID(sicuw.uwd102).
                      nv_bptr = RECID(sicuw.uwd102).
                  END.
              END.
              sicuw.uwm100.bptr02 = nv_bptr.

           
           /*--
           ASSIGN sic_bran.uwm100.releas = YES.  /*--Update Status Releas--*/
           ---comment by Chaiyong W. A59-0312 07/07/2016*/

          /*-- Add A57-0096 --*/
          IF sic_bran.uwm100.trty13 <> "" AND sic_bran.uwm100.trty13 = "S" THEN DO:
                nv_invtyp = TRIM(sic_bran.uwm100.trty13).  
          END.
          ELSE nv_invtyp = "T".
          /*-- End A57-0096 --*/

          /*--- STR Amparat c. A56-0240---*/
          FIND FIRST stat.vat100 USE-INDEX vat10001
               WHERE stat.vat100.invtyp  = nv_invtyp  /*"T"*/  /*A57-0096*/
                 AND stat.vat100.invoice = sic_bran.uwm100.docno1 NO-LOCK NO-ERROR.
          IF NOT AVAILABLE vat100 THEN DO:
                CREATE stat.VAT100.
                ASSIGN
                   stat.vat100.invtyp   = TRIM(nv_invtyp) /*"T"*//*A57-0096*/
                   stat.vat100.invoice  = STRING(sic_bran.uwm100.docno1,"9999999")
                   stat.vat100.invdat   = sic_bran.uwm100.fstdat
                   stat.vat100.poltyp   = sic_bran.uwm100.poltyp
                   stat.vat100.policy   = sic_bran.uwm100.policy
                   stat.vat100.rencnt   = sic_bran.uwm100.rencnt
                   stat.vat100.endcnt   = sic_bran.uwm100.endcnt
                   stat.vat100.branch   = sic_bran.uwm100.branch
                   stat.vat100.invbrn   = sic_bran.uwm100.branch
                   stat.vat100.acno     = sic_bran.uwm100.acno1
                   stat.vat100.agent    = sic_bran.uwm100.agent
                   stat.vat100.trnty1   = "M"
                   stat.vat100.refno    = STRING(sic_bran.uwm100.docno1,"9999999")
                   stat.vat100.ratevat  = sic_bran.uwm100.gstrat
                                     
                   /*stat.vat100.amount   = sic_bran.uwm100.prem_t + sicuw.uwm100.rstp_t  comment A62-0286*/
                   stat.vat100.amount   = sic_bran.uwm100.prem_t + sic_bran.uwm100.pstp + sic_bran.uwm100.rstp_t /*Add Jiraphon P. A62-0286*/
                   stat.vat100.discamt  = 0 
                   /*stat.vat100.totamt   = sic_bran.uwm100.prem_t + sicuw.uwm100.rstp_t Comment A62-0286*/
                   stat.vat100.totamt   = sic_bran.uwm100.prem_t + sic_bran.uwm100.pstp + sic_bran.uwm100.rstp_t /*Add Jiraphon P. A62-0286*/
                   /*stat.vat100.vatamt   = sic_bran.uwm100.rtax_t  Comment A62-0286*/
                   stat.vat100.vatamt   = sic_bran.uwm100.rtax_t + sic_bran.uwm100.ptax  /*Add Jiraphon P. A62-0286 editตามโปรแกรม trnvat*/
                   /*stat.vat100.grandamt = sic_bran.uwm100.prem_t + sicuw.uwm100.rstp_t  + sicuw.uwm100.rtax_t  Comment A62-0286*/
                   stat.vat100.grandamt = sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t  + sic_bran.uwm100.rtax_t  /*Add Jiraphon P. A62-0286*/
                                    
                   stat.vat100.pvrvjv   = ""
                   stat.vat100.insref   = sic_bran.uwm100.insref
                   stat.vat100.NAME     = TRIM(sic_bran.uwm100.ntitle) + TRIM(sic_bran.uwm100.name1) + 
                                          TRIM(sic_bran.uwm100.name2)  + TRIM(sic_bran.uwm100.name3)    
                   stat.vat100.add1     = TRIM(sic_bran.uwm100.addr1)  + TRIM(sic_bran.uwm100.addr2)
                   stat.vat100.add2     = TRIM(sic_bran.uwm100.addr3) + TRIM(sic_bran.uwm100.addr4)  
                   stat.vat100.desci    = "ค่าเบี้ยประกันตามกรมธรรม์เลขที่ " + sic_bran.uwm100.policy
                   stat.vat100.descdis  = "หักส่วนลด"
                   stat.vat100.entdat   = TODAY
                   stat.vat100.enttime  = STRING(TIME,"hh:mm:ss")
                   stat.vat100.usrid    = n_User
                   stat.vat100.remark1  = ""
                   stat.vat100.remark2  = ""
                   stat.vat100.print    = YES
                   stat.vat100.program  = "wgwgen01.p"
                   stat.vat100.taxmont  = MONTH(sic_bran.uwm100.fstdat)
                   stat.vat100.taxyear  = YEAR(sic_bran.uwm100.fstdat)
                   stat.vat100.taxrepm  = NO.   
          END.
          /*--- STR Amparat c. A56-0240---*/
        
    END. /*-NOT AVAIL sicuw.uwm100 -*/

END.



