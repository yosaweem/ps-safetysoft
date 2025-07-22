/* WGWGE307   : Program Generage Risk (Gwtransfer uwm307)  */
/* Copyright   # Safety Insurance Public Company Limited   */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)        */
/* WRITE      : Wantanee.  29/09/2006                      */
/* Copy From  : wtmge307.p                                 */
/* Wgwimpt1   : Program ที่เรียกใช้มาก่อน                  */


/*---Wantanee 29/09/2006 A49-0165 ---*/
DEF INPUT        PARAMETER nv_batchyr   AS INTEGER   FORMAT "9999".
DEF INPUT        PARAMETER nv_batchno   AS CHARACTER FORMAT "X(13)".
DEF INPUT        PARAMETER nv_batcnt    AS INTEGER   FORMAT "99".
/*------*/

DEF INPUT        PARAMETER nv_policy   AS CHARACTER FORMAT "X(12)".
DEF INPUT        PARAMETER nv_rencnt   AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_endcnt   AS INTEGER   FORMAT "999".
DEF INPUT        PARAMETER nv_name1    AS CHARACTER FORMAT "X(50)".
DEF INPUT        PARAMETER nv_si       AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF INPUT        PARAMETER nv_prem     AS DECIMAL   FORMAT ">,>>>,>>9.99-".
DEF OUTPUT       PARAMETER n_recid307  AS RECID.
DEF INPUT-OUTPUT PARAMETER nv_check    AS CHARACTER .

/*--------Wantanee 29/09/2006-------
FIND sic_bran.uwm307 USE-INDEX uwm30701 WHERE
     sic_bran.uwm307.policy = nv_policy AND
     sic_bran.uwm307.rencnt = nv_rencnt AND
     sic_bran.uwm307.endcnt = nv_endcnt AND
     sic_bran.uwm307.riskgp = 0         AND
     sic_bran.uwm307.riskno = 1         AND
     sic_bran.uwm307.itemno = 1
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm307 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
IF LOCKED sic_bran.uwm307 THEN DO:
  nv_check = "ERROR".
  RETURN.
END.
--------Wantanee 29/09/2006-------*/

CREATE sic_bran.uwm307.
ASSIGN
   sic_bran.uwm307.policy    = nv_policy  /*Policy No.*/
   sic_bran.uwm307.rencnt    = nv_rencnt  /*Renewal Count*/
   sic_bran.uwm307.endcnt    = nv_endcnt  /*Endorsement Count*/
   sic_bran.uwm307.riskgp    = 0          /*Risk Group*/
   sic_bran.uwm307.riskno    = 1          /*Risk No.*/
   sic_bran.uwm307.itemno    = 1          /*Item No.*/
   sic_bran.uwm307.iref      = ""         /*Insured Person Ref. No.*/
   sic_bran.uwm307.ifirst    = ""         /*Insured Person First Name*/
   sic_bran.uwm307.iname     = nv_name1   /*Insured Person Name*/
   sic_bran.uwm307.iyob      = 0          /*Insured Person Year of Birth*/
   sic_bran.uwm307.idob      = ?          /*Insd.Person Date of Birth*/
   sic_bran.uwm307.iocc      = "-"        /*Insured Person Occupation*/
   sic_bran.uwm307.iocct     = 1          /*PA Occupation Code,Tariff*/
   sic_bran.uwm307.ioccs     = "1"        /*PA Occupation Code,Stats.*/
   sic_bran.uwm307.bname1    = nv_name1   /*Beneficiary Name(1)*/
   sic_bran.uwm307.bname2    = ""         /*Beneficiary Name(2)*/
   sic_bran.uwm307.badd1     = ""         /*Beneficiary Address (1)*/
   sic_bran.uwm307.badd2     = ""         /*Beneficiary Address(2)*/
   sic_bran.uwm307.reship    = "-"        /*Relationship*/
   sic_bran.uwm307.endatt    = ""         /*Endorsements Attached*/
   sic_bran.uwm307.ldcd[1]   = ""         /*Load/Disc Code*/
   sic_bran.uwm307.ldcd[2]   = ""         
   sic_bran.uwm307.ldcd[3]   = ""         
   sic_bran.uwm307.ldae[1]   = YES        /*Load/Disc Rate A/E Code*/
   sic_bran.uwm307.ldae[2]   = YES        
   sic_bran.uwm307.ldae[3]   = YES        
   sic_bran.uwm307.ldrate[1] = 0          /*Load/Disc Rate*/
   sic_bran.uwm307.ldrate[2] = 0          
   sic_bran.uwm307.ldrate[3] = 0          
   sic_bran.uwm307.mbsi[1]   = nv_si      /*Main Benefit SI*/
   sic_bran.uwm307.mbsi[2]   = 0          
   sic_bran.uwm307.mbsi[3]   = 0          
   sic_bran.uwm307.mbsi[4]   = 0          
   sic_bran.uwm307.mbsi[5]   = 0          
   sic_bran.uwm307.mbsi[6]   = 0          
   sic_bran.uwm307.mbr_ae[1] = NO         /*Main Benefit Rate A/E Code*/
   sic_bran.uwm307.mbr_ae[2] = NO         
   sic_bran.uwm307.mbr_ae[3] = NO         
   sic_bran.uwm307.mbr_ae[4] = NO         
   sic_bran.uwm307.mbr_ae[5] = NO         
   sic_bran.uwm307.mbr_ae[6] = NO         
   sic_bran.uwm307.mbrate[1] = 0          /*Main Benefit Rate*/
   sic_bran.uwm307.mbrate[2] = 0          
   sic_bran.uwm307.mbrate[3] = 0          
   sic_bran.uwm307.mbrate[4] = 0          
   sic_bran.uwm307.mbrate[5] = 0          
   sic_bran.uwm307.mbrate[6] = 0  .       

ASSIGN                           
   sic_bran.uwm307.mbapae[1] = NO         /*Main Benefit AP A/E Code*/
   sic_bran.uwm307.mbapae[2] = YES        
   sic_bran.uwm307.mbapae[3] = YES        
   sic_bran.uwm307.mbapae[4] = YES        
   sic_bran.uwm307.mbapae[5] = YES        
   sic_bran.uwm307.mbapae[6] = YES        
   sic_bran.uwm307.mbap[1]   = nv_prem    /*Main Benefit AP*/
   sic_bran.uwm307.mbap[2]   = 0          
   sic_bran.uwm307.mbap[3]   = 0          
   sic_bran.uwm307.mbap[4]   = 0          
   sic_bran.uwm307.mbap[5]   = 0          
   sic_bran.uwm307.mbap[6]   = 0          
   sic_bran.uwm307.mbpdae[1] = NO         /*Main Benefit PD A/E Code*/
   sic_bran.uwm307.mbpdae[2] = YES        
   sic_bran.uwm307.mbpdae[3] = YES        
   sic_bran.uwm307.mbpdae[4] = YES        
   sic_bran.uwm307.mbpdae[5] = YES        
   sic_bran.uwm307.mbpdae[6] = YES        
   sic_bran.uwm307.mbpd[1]   = nv_prem    /*Main Benefit PD*/
   sic_bran.uwm307.mbpd[2]   = 0          
   sic_bran.uwm307.mbpd[3]   = 0          
   sic_bran.uwm307.mbpd[4]   = 0          
   sic_bran.uwm307.mbpd[5]   = 0          
   sic_bran.uwm307.mbpd[6]   = 0          
   sic_bran.uwm307.mb4wks    = 0          /*Main Benefit 4 Weeks*/
   sic_bran.uwm307.mb5wks    = 0          /*Main Benefit 5 Weeks*/
   sic_bran.uwm307.mb4ded    = 0          /*Main Benefit 4 Deductible*/
   sic_bran.uwm307.mb5ded    = 0          /*Main Benefit 5 Deductible*/
   sic_bran.uwm307.mb6ded    = 0          /*Main Benefit 6 Deductible*/
   sic_bran.uwm307.abcd[1]   = ""         /* Motor cycle = Addnl. Benefit Code*/
   sic_bran.uwm307.abcd[2]   = ""         /* Murder */
   sic_bran.uwm307.abcd[3]   = ""         
   sic_bran.uwm307.abcd[4]   = ""         
   sic_bran.uwm307.abrtae[1] = YES        /*Addnl. Benefit Rate A/E Code*/
   sic_bran.uwm307.abrtae[2] = YES        
   sic_bran.uwm307.abrtae[3] = YES        
   sic_bran.uwm307.abrtae[4] = YES        
   sic_bran.uwm307.abrt[1]   = 0          /*Addnl. Benefit Rate*/
   sic_bran.uwm307.abrt[2]   = 0          
   sic_bran.uwm307.abrt[3]   = 0          
   sic_bran.uwm307.abrt[4]   = 0          
   sic_bran.uwm307.abapae[1] = YES        /*Addnl. Benefit AP A/E Code*/
   sic_bran.uwm307.abapae[2] = YES        
   sic_bran.uwm307.abapae[3] = YES        
   sic_bran.uwm307.abapae[4] = YES        
   sic_bran.uwm307.abap[1]   = 0          /*Addnl. Benefit AP*/
   sic_bran.uwm307.abap[2]   = 0          
   sic_bran.uwm307.abap[3]   = 0          
   sic_bran.uwm307.abap[4]   = 0          
   sic_bran.uwm307.abpdae[1] = YES        /*Addnl. Benefit PD A/E Code*/
   sic_bran.uwm307.abpdae[2] = YES        
   sic_bran.uwm307.abpdae[3] = YES        
   sic_bran.uwm307.abpdae[4] = YES        
   sic_bran.uwm307.abpd[1]   = 0          /*Addnl. Benefit PD*/
   sic_bran.uwm307.abpd[2]   = 0          
   sic_bran.uwm307.abpd[3]   = 0          
   sic_bran.uwm307.abpd[4]   = 0          
   sic_bran.uwm307.tariff    = ""         /*Tariff */
   sic_bran.uwm307.icno      = ""         /*Insured Person IC No.*/
   sic_bran.uwm307.bname3    = ""         /*Beneficiary Name(3)*/
   sic_bran.uwm307.mb1day    =  0         /*Room & Board days*/
   sic_bran.uwm307.mb6day    =  0         /*Physician care days*/
   sic_bran.uwm307.mb7day    =  0         /*Special Nursing days*/
   sic_bran.uwm307.mb8day    =  0 .       /*Medical Care days*/

/*-----Wantanee 29/09/2006 A49-0165 -----*/
ASSIGN
  sic_bran.uwm307.bchyr   = nv_batchyr    /* batch Year */  
  sic_bran.uwm307.bchno   = nv_batchno    /* batchno    */  
  sic_bran.uwm307.bchcnt  = nv_batcnt.    /* batcnt     */  

n_recid307   = RECID(sic_bran.uwm307).
/* END OF FILE : TMGEN307.P */
