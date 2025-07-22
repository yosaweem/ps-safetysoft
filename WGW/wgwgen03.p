/*=================================================================*/
/* Program Name : wGwGen03.P   Gen. Data Uwm130 To DB Premium      */
/* Assign  No   : A54-0005                                         */
/* CREATE  By   : Amparat C.           (Date 23/12/2010)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/*Modify   by   : kridtiya i. A57-0107 date 26/03/2014
                  comment "end" program and add "end" program*/
/* Modify By : Porntiwa P.  A57-0096  23/05/2014
             : ปรับการนำเข้า Mailtxt_fil ของศรีกรุง                */  
/* Modify By : Narin L.  A58-0123   (Date 11-05-2015)
               ปรับการ Transfer uwd103 , uwd104 , uwd105 , uwd106  */                              
/*-----------------------------------------------------------------*/
/* Modify By : TANTAWAN CH.   A61-0205  @ 4/5/2018                 */
/*             - เพิ่ม field   uwm130.prem_item  เบี้ยลดหย่อนภาษี  */
/* Modify By : Kridtiya i. A65-0145 เพิ่มการให้ค่า uom8_u - uom20_u*/
/* Modify by : Songkran P. A65-0141 Add field                      */
/* Modify by : Naphasint C. A67-0029 09/05/2024                    */                              
/*             Add Filed uwm130 & mailtxt_fil & uwm301             */
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

DEFINE VAR nv_policy1 AS CHAR FORMAT "X(30)". /*A57-0096*/

/*---Begin by Narin L. A58-0123 11/05/2015*/
def buffer wf_uwd130 for sicuw.uwd130.
def buffer wf_uwd131 for sicuw.uwd131.
def buffer wf_uwd134 for sicuw.uwd134.
def buffer wf_uwd136 for sicuw.uwd136.
/*End by Narin L. A58-0123 11/05/2015-----*/


/*----
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
comment by Chaiyong W. A58-0123 16/06/2015*/


/*---Begin by Chaiyong W. A58-0123 16/06/2015*/
FOR EACH sic_bran.uwm130 USE-INDEX uwm13001  WHERE 
         sic_bran.uwm130.policy  = nv_Policy AND
         sic_bran.uwm130.rencnt  = nv_RenCnt AND
         sic_bran.uwm130.endcnt  = nv_EndCnt AND
         sic_bran.uwm130.bchyr   = nv_bchyr  AND
         sic_bran.uwm130.bchno   = nv_bchno  AND
         sic_bran.uwm130.bchcnt  = nv_bchcnt  NO-LOCK:
/*End by Chaiyong W. A58-0123 16/06/2015-----*/

  FIND sicuw.uwm130 WHERE
       sicuw.uwm130.policy = sic_bran.uwm130.policy AND
       sicuw.uwm130.rencnt = sic_bran.uwm130.rencnt AND
       sicuw.uwm130.endcnt = sic_bran.uwm130.endcnt AND
       sicuw.uwm130.riskgp = sic_bran.uwm130.riskgp AND 
       sicuw.uwm130.riskno = sic_bran.uwm130.riskno AND 
       sicuw.uwm130.itemno = sic_bran.uwm130.itemno NO-ERROR.
  IF NOT AVAILABLE sicuw.uwm130 THEN DO:
     CREATE sicuw.uwm130.
  /*END. *//*A57-0119 Kridtiya i.*/
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
    sicuw.uwm130.uom9_v     = sic_bran.uwm130.uom9_v
    /* ADD A65-0145 ...........*/       
    sicuw.uwm130.uom8_u     = sic_bran.uwm130.uom8_u
    sicuw.uwm130.uom9_u     = sic_bran.uwm130.uom9_u
    sicuw.uwm130.uom10_c    = sic_bran.uwm130.uom10_c 
    sicuw.uwm130.uom10_u    = sic_bran.uwm130.uom10_u 
    sicuw.uwm130.uom10_v    = sic_bran.uwm130.uom10_v 
    sicuw.uwm130.uom11_c    = sic_bran.uwm130.uom11_c 
    sicuw.uwm130.uom11_u    = sic_bran.uwm130.uom11_u 
    sicuw.uwm130.uom11_v    = sic_bran.uwm130.uom11_v 
    sicuw.uwm130.uom12_c    = sic_bran.uwm130.uom12_c 
    sicuw.uwm130.uom12_u    = sic_bran.uwm130.uom12_u 
    sicuw.uwm130.uom12_v    = sic_bran.uwm130.uom12_v
    sicuw.uwm130.uom13_c    = sic_bran.uwm130.uom13_c 
    sicuw.uwm130.uom13_u    = sic_bran.uwm130.uom13_u 
    sicuw.uwm130.uom13_v    = sic_bran.uwm130.uom13_v
    sicuw.uwm130.uom14_c    = sic_bran.uwm130.uom14_c 
    sicuw.uwm130.uom14_u    = sic_bran.uwm130.uom14_u 
    sicuw.uwm130.uom14_v    = sic_bran.uwm130.uom14_v
    sicuw.uwm130.uom15_c    = sic_bran.uwm130.uom15_c 
    sicuw.uwm130.uom15_u    = sic_bran.uwm130.uom15_u 
    sicuw.uwm130.uom15_v    = sic_bran.uwm130.uom15_v
    sicuw.uwm130.uom16_c    = sic_bran.uwm130.uom16_c 
    sicuw.uwm130.uom16_u    = sic_bran.uwm130.uom16_u 
    sicuw.uwm130.uom16_v    = sic_bran.uwm130.uom16_v 
    sicuw.uwm130.uom17_c    = sic_bran.uwm130.uom17_c 
    sicuw.uwm130.uom17_u    = sic_bran.uwm130.uom17_u 
    sicuw.uwm130.uom17_v    = sic_bran.uwm130.uom17_v 
    sicuw.uwm130.uom18_c    = sic_bran.uwm130.uom18_c 
    sicuw.uwm130.uom18_u    = sic_bran.uwm130.uom18_u 
    sicuw.uwm130.uom18_v    = sic_bran.uwm130.uom18_v 
    sicuw.uwm130.uom19_c    = sic_bran.uwm130.uom19_c 
    sicuw.uwm130.uom19_u    = sic_bran.uwm130.uom19_u 
    sicuw.uwm130.uom19_v    = sic_bran.uwm130.uom19_v
    sicuw.uwm130.uom20_c    = sic_bran.uwm130.uom20_c 
    sicuw.uwm130.uom20_u    = sic_bran.uwm130.uom20_u 
    sicuw.uwm130.uom20_v    = sic_bran.uwm130.uom20_v 
    /*END ADD A65-0145*/
    sicuw.uwm130.prem_item  = sic_bran.uwm130.prem_item .   /* A61-0205 */  
  /*----Begin A65-0141 28/11/2022*/
  ASSIGN
    sicuw.uwm130.acctxt        = sic_bran.uwm130.acctxt  
    sicuw.uwm130.accsi         = sic_bran.uwm130.accsi  
    sicuw.uwm130.uom1_a        = sic_bran.uwm130.uom1_a  
    sicuw.uwm130.uom2_a        = sic_bran.uwm130.uom2_a  
    sicuw.uwm130.uom3_a        = sic_bran.uwm130.uom3_a  
    sicuw.uwm130.uom4_a        = sic_bran.uwm130.uom4_a  
    sicuw.uwm130.uom5_a        = sic_bran.uwm130.uom5_a  
    sicuw.uwm130.uom6_a        = sic_bran.uwm130.uom6_a  
    sicuw.uwm130.uom7_a        = sic_bran.uwm130.uom7_a  
    sicuw.uwm130.uom8_a        = sic_bran.uwm130.uom8_a  
    sicuw.uwm130.uom9_a        = sic_bran.uwm130.uom9_a  
    sicuw.uwm130.uom10_a       = sic_bran.uwm130.uom10_a 
    sicuw.uwm130.uom11_a       = sic_bran.uwm130.uom11_a 
    sicuw.uwm130.uom12_a       = sic_bran.uwm130.uom12_a 
    sicuw.uwm130.uom13_a       = sic_bran.uwm130.uom13_a 
    sicuw.uwm130.uom14_a       = sic_bran.uwm130.uom14_a 
    sicuw.uwm130.uom15_a       = sic_bran.uwm130.uom15_a 
    sicuw.uwm130.dl1amt        = sic_bran.uwm130.dl1amt  
    sicuw.uwm130.dl2amt        = sic_bran.uwm130.dl2amt  
    sicuw.uwm130.dl3amt        = sic_bran.uwm130.dl3amt  
    sicuw.uwm130.dl1cod        = sic_bran.uwm130.dl1cod  
    sicuw.uwm130.dl2cod        = sic_bran.uwm130.dl2cod  
    sicuw.uwm130.dl3cod        = sic_bran.uwm130.dl3cod  
    sicuw.uwm130.uom16_a       = sic_bran.uwm130.uom16_a 
    sicuw.uwm130.uom17_a       = sic_bran.uwm130.uom17_a 
    sicuw.uwm130.uom18_a       = sic_bran.uwm130.uom18_a 
    sicuw.uwm130.uom19_a       = sic_bran.uwm130.uom19_a 
    sicuw.uwm130.uom20_a       = sic_bran.uwm130.uom20_a 
    sicuw.uwm130.uom21_c       = sic_bran.uwm130.uom21_c 
    sicuw.uwm130.uom22_c       = sic_bran.uwm130.uom22_c 
    sicuw.uwm130.uom23_c       = sic_bran.uwm130.uom23_c 
    sicuw.uwm130.uom24_c       = sic_bran.uwm130.uom24_c 
    sicuw.uwm130.uom25_c       = sic_bran.uwm130.uom25_c 
    sicuw.uwm130.uom21_u       = sic_bran.uwm130.uom21_u 
    sicuw.uwm130.uom22_u       = sic_bran.uwm130.uom22_u 
    sicuw.uwm130.uom23_u       = sic_bran.uwm130.uom23_u 
    sicuw.uwm130.uom24_u       = sic_bran.uwm130.uom24_u 
    sicuw.uwm130.uom25_u       = sic_bran.uwm130.uom25_u 
    sicuw.uwm130.uom21_v       = sic_bran.uwm130.uom21_v 
    sicuw.uwm130.uom22_v       = sic_bran.uwm130.uom22_v 
    sicuw.uwm130.uom23_v       = sic_bran.uwm130.uom23_v 
    sicuw.uwm130.uom24_v       = sic_bran.uwm130.uom24_v 
    sicuw.uwm130.uom25_v       = sic_bran.uwm130.uom25_v 
    sicuw.uwm130.uom21_a       = sic_bran.uwm130.uom21_a 
    sicuw.uwm130.uom22_a       = sic_bran.uwm130.uom22_a 
    sicuw.uwm130.uom23_a       = sic_bran.uwm130.uom23_a 
    sicuw.uwm130.uom24_a       = sic_bran.uwm130.uom24_a 
    sicuw.uwm130.uom25_a       = sic_bran.uwm130.uom25_a 
    sicuw.uwm130.chr1          = sic_bran.uwm130.chr1    
    sicuw.uwm130.chr2          = sic_bran.uwm130.chr2    
    sicuw.uwm130.chr3          = sic_bran.uwm130.chr3    
    sicuw.uwm130.chr4          = sic_bran.uwm130.chr4    
    sicuw.uwm130.chr5          = sic_bran.uwm130.chr5    
    sicuw.uwm130.date1         = sic_bran.uwm130.date1   
    sicuw.uwm130.date2         = sic_bran.uwm130.date2   
    sicuw.uwm130.dec1          = sic_bran.uwm130.dec1    
    sicuw.uwm130.dec2          = sic_bran.uwm130.dec2    
    sicuw.uwm130.int1          = sic_bran.uwm130.int1    
    sicuw.uwm130.int2          = sic_bran.uwm130.int2    
    sicuw.uwm130.lossrtp       = sic_bran.uwm130.lossrtp 
    sicuw.uwm130.lossamt       = sic_bran.uwm130.lossamt 
    sicuw.uwm130.osamt         = sic_bran.uwm130.osamt   
    sicuw.uwm130.resamt        = sic_bran.uwm130.resamt  
    sicuw.uwm130.paidamt       = sic_bran.uwm130.paidamt 
    sicuw.uwm130.stuexp        = sic_bran.uwm130.stuexp  
    sicuw.uwm130.actcod        = sic_bran.uwm130.actcod  
    sicuw.uwm130.package       = sic_bran.uwm130.package 
    /*End A65-0141 28/11/2022------*/

    /*-- Add by Naphasint C. A67-0029 09/05/2024 --*/
    sicuw.uwm130.refer         = sic_bran.uwm130.refer .
    /*-- End by Naphasint C. A67-0029 09/05/2024 --*/

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

      /*----Begin by Narin L. A58-0123 11/05/2015*/
      /* Insured Item Upper Text */
      nv_fptr = sic_bran.uwm130.fptr01.
      nv_bptr = 0.
      do while nv_fptr <> 0 and sic_bran.uwm130.fptr01 <> ? :
         find sic_bran.uwd130 where recid(sic_bran.uwd130) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd130 then do: /*sombat */
           nv_fptr = sic_bran.uwd130.fptr.
           create sicuw.uwd130.
    
           assign
             sicuw.uwd130.bptr          = nv_bptr
             sicuw.uwd130.endcnt        = sic_bran.uwd130.endcnt
             sicuw.uwd130.fptr          = 0
             sicuw.uwd130.itemno        = sic_bran.uwd130.itemno
             sicuw.uwd130.ltext         = sic_bran.uwd130.ltext
             sicuw.uwd130.policy        = sic_bran.uwd130.policy
             sicuw.uwd130.rencnt        = sic_bran.uwd130.rencnt
             sicuw.uwd130.riskgp        = sic_bran.uwd130.riskgp
             sicuw.uwd130.riskno        = sic_bran.uwd130.riskno.
           if nv_bptr <> 0 then do:
             find wf_uwd130 where recid(wf_uwd130) = nv_bptr.
             wf_uwd130.fptr = recid(sicuw.uwd130).
           end.
           if nv_bptr = 0 then  sicuw.uwm130.fptr01 = recid(sicuw.uwd130).
           nv_bptr = recid(sicuw.uwd130).
         end.
      end. /* End do nv_fptr */
      sicuw.uwm130.bptr01 = nv_bptr.
    
      /* Insured Item Lower Text */
      nv_fptr = sic_bran.uwm130.fptr02.
      nv_bptr = 0.
      do while nv_fptr <> 0 and sic_bran.uwm130.fptr02 <> ? :
         find sic_bran.uwd131 where recid(sic_bran.uwd131) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd131 then do: /*sombat */
           nv_fptr = sic_bran.uwd131.fptr.
           create sicuw.uwd131.
    
           assign
             sicuw.uwd131.bptr          = nv_bptr
             sicuw.uwd131.endcnt        = sic_bran.uwd131.endcnt
             sicuw.uwd131.fptr          = 0
             sicuw.uwd131.itemno        = sic_bran.uwd131.itemno
             sicuw.uwd131.ltext         = sic_bran.uwd131.ltext
             sicuw.uwd131.policy        = sic_bran.uwd131.policy
             sicuw.uwd131.rencnt        = sic_bran.uwd131.rencnt
             sicuw.uwd131.riskgp        = sic_bran.uwd131.riskgp
             sicuw.uwd131.riskno        = sic_bran.uwd131.riskno.
    
           if nv_bptr <> 0 then do:
             find wf_uwd131 where recid(wf_uwd131) = nv_bptr.
             wf_uwd131.fptr = recid(sicuw.uwd131).
           end.
           if nv_bptr = 0 then  sicuw.uwm130.fptr02 = recid(sicuw.uwd131).
           nv_bptr = recid(sicuw.uwd131).
         end.
      end. /* End do nv_fptr */
      sicuw.uwm130.bptr02 = nv_bptr.
    
    
      /* Insured Item Endorsement Text */
      nv_fptr = sic_bran.uwm130.fptr04.
      nv_bptr = 0.
      /* loop_134: */
      do while nv_fptr <> 0 and sic_bran.uwm130.fptr04 <> ? :
         find sic_bran.uwd134 where recid(sic_bran.uwd134) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd134 then do: /*sombat */
           nv_fptr = sic_bran.uwd134.fptr.
           create sicuw.uwd134.
    
           assign
           sicuw.uwd134.bptr          = nv_bptr
           sicuw.uwd134.endcnt        = sic_bran.uwd134.endcnt
           sicuw.uwd134.fptr          = 0
           sicuw.uwd134.itemno        = sic_bran.uwd134.itemno
           sicuw.uwd134.ltext         = sic_bran.uwd134.ltext
           sicuw.uwd134.policy        = sic_bran.uwd134.policy
           sicuw.uwd134.rencnt        = sic_bran.uwd134.rencnt
           sicuw.uwd134.riskgp        = sic_bran.uwd134.riskgp
           sicuw.uwd134.riskno        = sic_bran.uwd134.riskno.
    
           if nv_bptr <> 0 then do:
             find wf_uwd134 where recid(wf_uwd134) = nv_bptr.
             if not available sic_bran.uwd134 then leave. /*sombat */
             wf_uwd134.fptr = recid(sicuw.uwd134).
           end.
           /*-- Comment by Narin A56-0225
           if nv_bptr = 0 then  sicuw.uwm130.fptr03 = recid(sicuw.uwd134).
           --*/
           /*--    Add by Narin A56-0225--*/
           if nv_bptr = 0 then  sicuw.uwm130.fptr04 = recid(sicuw.uwd134).
           /*--End Add by Narin A56-0225--*/
           nv_bptr = recid(sicuw.uwd134).
    
         end.
      end. /* End do nv_fptr */
      sicuw.uwm130.bptr04 = nv_bptr.
    
      /* Insured Item Endorsement Clauses */
      nv_fptr = sic_bran.uwm130.fptr05.
      nv_bptr = 0.
      do while nv_fptr <> 0 and sic_bran.uwm130.fptr05 <> ? :
         find sic_bran.uwd136 where recid(sic_bran.uwd136) = nv_fptr
         no-lock no-error.
         if available sic_bran.uwd136 then do: /*sombat */
           nv_fptr = sic_bran.uwd136.fptr.
           create sicuw.uwd136.
    
           assign
           sicuw.uwd136.bptr          = nv_bptr
           sicuw.uwd136.endcls        = sic_bran.uwd136.endcls
           sicuw.uwd136.endcnt        = sic_bran.uwd136.endcnt
           sicuw.uwd136.fptr          = 0
           sicuw.uwd136.itemno        = sic_bran.uwd136.itemno
           sicuw.uwd136.policy        = sic_bran.uwd136.policy
           sicuw.uwd136.rencnt        = sic_bran.uwd136.rencnt
           sicuw.uwd136.riskgp        = sic_bran.uwd136.riskgp
           sicuw.uwd136.riskno        = sic_bran.uwd136.riskno.
    
           if nv_bptr <> 0 then do:
             find wf_uwd136 where recid(wf_uwd136) = nv_bptr.
             wf_uwd136.fptr = recid(sicuw.uwd136).
           end.
           if nv_bptr = 0 then  sicuw.uwm130.fptr05 = recid(sicuw.uwd136).
           nv_bptr = recid(sicuw.uwd136).
         end.
      end. /* End do nv_fptr */
      sicuw.uwm130.bptr05 = nv_bptr.
      /*End by Narin L. A58-0123 11/05/2015------*/



      END.   /*kridtiya i. A57-0119 เนื่องจากมีการ Assign uwd132 ซ้ำตามครั้งที่กด*/

      /*-- Create Mailtxt_fil A57-0096 --*/
      nv_policy1 = TRIM(nv_policy) + 
                   STRING(nv_rencnt,"99") + STRING(nv_endcnt,"999") + 
                   STRING(sic_bran.uwm130 .riskno,"999") + STRING(sic_bran.uwm130.itemno,"999").
      
      FIND FIRST brstat.Mailtxt_fil USE-INDEX mailtxt01
           WHERE brstat.Mailtxt_fil.policy  = nv_policy1 AND  
                 brstat.Mailtxt_fil.bchyr   = nv_bchyr   AND
                 brstat.Mailtxt_fil.bchno   = nv_bchno   AND
                 brstat.Mailtxt_fil.bchcnt  = nv_bchcnt  AND
                 brstat.Mailtxt_fil.lnumber = 1          NO-LOCK NO-ERROR.
      IF AVAILABLE brstat.Mailtxt_fil THEN DO:
      
          FIND FIRST stat.Mailtxt_fil USE-INDEX mailtxt01  
               WHERE stat.Mailtxt_fil.policy  = nv_policy1 AND
                     stat.Mailtxt_fil.lnumber = 1          NO-LOCK NO-ERROR.
          IF AVAILABLE stat.Mailtxt_fil THEN DO:
      
              FOR EACH stat.Mailtxt_fil USE-INDEX mailtxt01 
                 WHERE stat.Mailtxt_fil.policy = nv_policy1 :
      
                  DELETE stat.Mailtxt_fil.
      
              END.
          END.
      
          FOR EACH brstat.Mailtxt_fil USE-INDEX mailtxt01
             WHERE brstat.Mailtxt_fil.policy  = nv_policy1  AND
                   brstat.Mailtxt_fil.bchyr   = nv_bchyr    AND
                   brstat.Mailtxt_fil.bchno   = nv_bchno    AND
                   brstat.Mailtxt_fil.bchcnt  = nv_bchcnt   :
      
              CREATE stat.Mailtxt_fil.
              ASSIGN
                  stat.mailtxt_fil.policy  =  nv_policy1          
                  stat.mailtxt_fil.lnumber =  brstat.mailtxt_fil.lnumber
                  stat.mailtxt_fil.ltext   =  brstat.mailtxt_fil.ltext
                  stat.mailtxt_fil.ltext2  =  brstat.mailtxt_fil.ltext2.

              /*-- Add by Naphasint C. A67-0029 09/05/2024 --*/
              ASSIGN
                  stat.mailtxt_fil.drivbirth =  brstat.mailtxt_fil.drivbirth
                  stat.mailtxt_fil.drivage   =  brstat.mailtxt_fil.drivage
                  stat.mailtxt_fil.occupcod  =  brstat.mailtxt_fil.occupcod
                  stat.mailtxt_fil.occupdes  =  brstat.mailtxt_fil.occupdes
                  stat.mailtxt_fil.cardflg   =  brstat.mailtxt_fil.cardflg
                  stat.mailtxt_fil.drividno  =  brstat.mailtxt_fil.drividno
                  stat.mailtxt_fil.licenno   =  brstat.mailtxt_fil.licenno
                  stat.mailtxt_fil.gender    =  brstat.mailtxt_fil.gender
                  stat.mailtxt_fil.drivlevel =  brstat.mailtxt_fil.drivlevel
                  stat.mailtxt_fil.levelper  =  brstat.mailtxt_fil.levelper
                  stat.mailtxt_fil.titlenam  =  brstat.mailtxt_fil.titlenam
                  stat.mailtxt_fil.licenexp  =  brstat.mailtxt_fil.licenexp
                  stat.mailtxt_fil.firstnam  =  brstat.mailtxt_fil.firstnam
                  stat.mailtxt_fil.lastnam   =  brstat.mailtxt_fil.lastnam
                  stat.mailtxt_fil.dconsen   =  brstat.mailtxt_fil.dconsen
                  stat.mailtxt_fil.drivtxt1  =  brstat.mailtxt_fil.drivtxt1
                  stat.mailtxt_fil.drivtxt2  =  brstat.mailtxt_fil.drivtxt2.
              /*-- End by Naphasint C. A67-0029 09/05/2024 --*/
      
          END.  
      END.
      /*-- End A57-0096 --*/

END.



