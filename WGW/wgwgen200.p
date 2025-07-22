/*=================================================================*/
/* Program Name : wGwGen03.P   Gen. Data Uwm130 To DB Premium      */
/* Assign  No   : A54-0005                                         */
/* CREATE  By   : Amparat C.           (Date 23/12/2010)           */
/*                โอนข้อมูลจาก DB Gw Transfer To Premium           */
/*Modify   by   : kridtiya i. A57-0107 date 26/03/2014
                  comment "end" program and add "end" program*/
/* Modify By : Porntiwa P.  A57-0096  23/05/2014
             : ปรับการนำเข้า Mailtxt_fil ของศรีกรุง                */ 
/* Modify by : Songkran P. &  A65-0141 28/11/2022 - Add field      */                              
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

def buffer wf_uwd200 for sicuw.uwd200.
def buffer wf_uwd201 for sicuw.uwd201.
def buffer wf_uwd202 for sicuw.uwd202.

DEF SHARED STREAM ns1.

DEFINE VAR nv_policy1 AS CHAR FORMAT "X(30)". /*A57-0096*/

    
loop_uwm200:
for each sic_bran.uwm200 where
                     sic_bran.uwm200.policy = nv_policy and
                     sic_bran.uwm200.rencnt = nv_rencnt and
                     sic_bran.uwm200.endcnt = nv_endcnt  AND
                     sic_bran.uwm200.bchyr   = nv_bchyr  AND
                     sic_bran.uwm200.bchno   = nv_bchno  AND
                     sic_bran.uwm200.bchcnt  = nv_bchcnt  
no-lock:
  find sicuw.uwm200 where sicuw.uwm200.policy = sic_bran.uwm200.policy and
                          sicuw.uwm200.rencnt = sic_bran.uwm200.rencnt and
                          sicuw.uwm200.endcnt = sic_bran.uwm200.endcnt and
                          sicuw.uwm200.csftq  = sic_bran.uwm200.csftq  and
                          sicuw.uwm200.rico   = sic_bran.uwm200.rico   and
                          sicuw.uwm200.c_enct = sic_bran.uwm200.c_enct
  no-error.

  if available sicuw.uwm200 then next loop_uwm200.
  if not available sicuw.uwm200
  then do:
     create sicuw.uwm200.
  end.

  /*delete uwd200 */
  nv_fptr = sicuw.uwm200.fptr01.
  do while nv_fptr <> 0 and sicuw.uwm200.fptr01 <> ? :
     find sicuw.uwd200 where recid(sicuw.uwd200) = nv_fptr
     no-error.
     if available sicuw.uwd200 then do: /*sombat */
        nv_fptr = sicuw.uwd200.fptr.
        if sicuw.uwd200.policy = sic_bran.uwm200.policy and
           sicuw.uwd200.rencnt = sic_bran.uwm200.rencnt and
           sicuw.uwd200.endcnt = sic_bran.uwm200.endcnt 
        then do:
           delete sicuw.uwd200.
        end.
        else  nv_fptr = 0.
     end.
     else      nv_fptr = 0.
  end.

  /*delete uwd201 */
  nv_fptr = sicuw.uwm200.fptr02.
  do while nv_fptr <> 0 and sicuw.uwm200.fptr02 <> ? :
     find sicuw.uwd201 where recid(sicuw.uwd201) = nv_fptr
     no-error.
     if available sicuw.uwd201 then do: /*sombat */
        nv_fptr = sicuw.uwd201.fptr.
        if sicuw.uwd201.policy = sic_bran.uwm200.policy and
           sicuw.uwd201.rencnt = sic_bran.uwm200.rencnt and
           sicuw.uwd201.endcnt = sic_bran.uwm200.endcnt 
        then do:
           delete sicuw.uwd201.
        end.
        else  nv_fptr = 0.
     end.
     else      nv_fptr = 0.
  end.

  /*delete uwd202 */
  nv_fptr = sicuw.uwm200.fptr03.
  do while nv_fptr <> 0 and sicuw.uwm200.fptr03 <> ? :
     find sicuw.uwd202 where recid(sicuw.uwd202) = nv_fptr
     no-error.
     if available sicuw.uwd202 then do: /*sombat */
        nv_fptr = sicuw.uwd202.fptr.
        if sicuw.uwd202.policy = sic_bran.uwm200.policy and
           sicuw.uwd202.rencnt = sic_bran.uwm200.rencnt and
           sicuw.uwd202.endcnt = sic_bran.uwm200.endcnt 
        then do:
           delete sicuw.uwd202.
        end.
        else  nv_fptr = 0.
     end.
     else      nv_fptr = 0.
  end.

  /*Update Data*/
  assign
    sicuw.uwm200.fptr01 = 0  sicuw.uwm200.bptr01 = 0
    sicuw.uwm200.fptr02 = 0  sicuw.uwm200.bptr02 = 0
    sicuw.uwm200.fptr03 = 0  sicuw.uwm200.bptr03 = 0
    sicuw.uwm200.bordno        = sic_bran.uwm200.bordno
    sicuw.uwm200.com2gn        = sic_bran.uwm200.com2gn
    sicuw.uwm200.csftq         = sic_bran.uwm200.csftq
    sicuw.uwm200.curbil        = sic_bran.uwm200.curbil
    sicuw.uwm200.c_enct        = sic_bran.uwm200.c_enct
    sicuw.uwm200.c_enno        = sic_bran.uwm200.c_enno
    sicuw.uwm200.c_no          = sic_bran.uwm200.c_no
    sicuw.uwm200.c_year        = sic_bran.uwm200.c_year
    sicuw.uwm200.dept          = sic_bran.uwm200.dept
    sicuw.uwm200.docri         = sic_bran.uwm200.docri
    sicuw.uwm200.dreg_p        = sic_bran.uwm200.dreg_p
    sicuw.uwm200.endcnt        = sic_bran.uwm200.endcnt
    sicuw.uwm200.panel         = sic_bran.uwm200.panel
    sicuw.uwm200.policy        = sic_bran.uwm200.policy
    sicuw.uwm200.prntri        = sic_bran.uwm200.prntri
    sicuw.uwm200.recip         = sic_bran.uwm200.recip
    sicuw.uwm200.reg_no        = sic_bran.uwm200.reg_no
    sicuw.uwm200.rencnt        = sic_bran.uwm200.rencnt
    sicuw.uwm200.rico          = sic_bran.uwm200.rico
    sicuw.uwm200.ricomm        = sic_bran.uwm200.ricomm
    sicuw.uwm200.riexp         = sic_bran.uwm200.riexp
    sicuw.uwm200.rip1          = sic_bran.uwm200.rip1
    sicuw.uwm200.rip1ae        = sic_bran.uwm200.rip1ae
    sicuw.uwm200.rip2          = sic_bran.uwm200.rip2
    sicuw.uwm200.rip2ae        = sic_bran.uwm200.rip2ae
    sicuw.uwm200.ristmp        = sic_bran.uwm200.ristmp
    sicuw.uwm200.thpol         = sic_bran.uwm200.thpol
    sicuw.uwm200.trndat        = sic_bran.uwm200.trndat
    sicuw.uwm200.trtyri        = sic_bran.uwm200.trtyri.
  /*--Begin A65-0141 28/11/2022*/
  ASSIGN
      sicuw.uwm200.riendt      = sic_bran.uwm200.riendt
      sicuw.uwm200.chr1        = sic_bran.uwm200.chr1  
      sicuw.uwm200.chr2        = sic_bran.uwm200.chr2  
      sicuw.uwm200.chr3        = sic_bran.uwm200.chr3  
      sicuw.uwm200.chr4        = sic_bran.uwm200.chr4  
      sicuw.uwm200.chr5        = sic_bran.uwm200.chr5  
      sicuw.uwm200.date1       = sic_bran.uwm200.date1 
      sicuw.uwm200.date2       = sic_bran.uwm200.date2 
      sicuw.uwm200.dec1        = sic_bran.uwm200.dec1  
      sicuw.uwm200.dec2        = sic_bran.uwm200.dec2  
      sicuw.uwm200.int1        = sic_bran.uwm200.int1  
      sicuw.uwm200.int2        = sic_bran.uwm200.int2
      sicuw.uwm200.treaty_yr   = sic_bran.uwm200.treaty_yr.
  /*End A65-0141 28/11/2022----*/

  /* End Update uwm200 */

  /* RI Out Premium */
  nv_fptr = sic_bran.uwm200.fptr01.
  nv_bptr = 0.
  do while nv_fptr <> 0 and sic_bran.uwm200.fptr01 <> ? :
     find sic_bran.uwd200 where recid(sic_bran.uwd200) = nv_fptr
     no-lock no-error.
     if not available sic_bran.uwd200 then do: /*sombat */
         leave.
     end.

     nv_fptr = sic_bran.uwd200.fptr.
     create sicuw.uwd200.

     assign
       sicuw.uwd200.bptr          = nv_bptr
       sicuw.uwd200.fptr          = 0
     sicuw.uwd200.csftq         = sic_bran.uwd200.csftq
     sicuw.uwd200.c_enct        = sic_bran.uwd200.c_enct
     sicuw.uwd200.endcnt        = sic_bran.uwd200.endcnt
     sicuw.uwd200.policy        = sic_bran.uwd200.policy
     sicuw.uwd200.rencnt        = sic_bran.uwd200.rencnt
     sicuw.uwd200.ric1          = sic_bran.uwd200.ric1
     sicuw.uwd200.ric1ae        = sic_bran.uwd200.ric1ae
     sicuw.uwd200.ric2          = sic_bran.uwd200.ric2
     sicuw.uwd200.ric2ae        = sic_bran.uwd200.ric2ae
     sicuw.uwd200.rico          = sic_bran.uwd200.rico
     sicuw.uwd200.ripr          = sic_bran.uwd200.ripr
     sicuw.uwd200.ripsae        = sic_bran.uwd200.ripsae
     sicuw.uwd200.risi          = sic_bran.uwd200.risi
     sicuw.uwd200.risiae        = sic_bran.uwd200.risiae
     sicuw.uwd200.risiid        = sic_bran.uwd200.risiid
     sicuw.uwd200.risi_p        = sic_bran.uwd200.risi_p
     sicuw.uwd200.riskgp        = sic_bran.uwd200.riskgp
     sicuw.uwd200.riskno        = sic_bran.uwd200.riskno
     sicuw.uwd200.sicurr        = sic_bran.uwd200.sicurr.

     if nv_bptr <> 0 then do:
       find wf_uwd200 where recid(wf_uwd200) = nv_bptr.
       wf_uwd200.fptr = recid(sicuw.uwd200).
     end.
     if nv_bptr = 0 then  sicuw.uwm200.fptr01 = recid(sicuw.uwd200).
     nv_bptr = recid(sicuw.uwd200).
  end. /* End do nv_fptr */
  sicuw.uwm200.bptr01 = nv_bptr.

  /* RI Application Text */
  nv_fptr = sic_bran.uwm200.fptr02.
  nv_bptr = 0.
  do while nv_fptr <> 0 and sic_bran.uwm200.fptr02 <> ? :
     find sic_bran.uwd201 where recid(sic_bran.uwd201) = nv_fptr
     no-lock no-error.
     if not available sic_bran.uwd201 then do: /*sombat */
       leave.
     end.
     nv_fptr = sic_bran.uwd201.fptr.
     create sicuw.uwd201.

     assign
         sicuw.uwd201.bptr          = nv_bptr
         sicuw.uwd201.fptr          = 0
     sicuw.uwd201.csftq         = sic_bran.uwd201.csftq
     sicuw.uwd201.c_enct        = sic_bran.uwd201.c_enct
     sicuw.uwd201.endcnt        = sic_bran.uwd201.endcnt
     sicuw.uwd201.ltext         = sic_bran.uwd201.ltext
     sicuw.uwd201.policy        = sic_bran.uwd201.policy
     sicuw.uwd201.rencnt        = sic_bran.uwd201.rencnt
     sicuw.uwd201.rico          = sic_bran.uwd201.rico.


     if nv_bptr <> 0 then do:
       find wf_uwd201 where recid(wf_uwd201) = nv_bptr.
       wf_uwd201.fptr = recid(sicuw.uwd201).
     end.
     if nv_bptr = 0 then  sicuw.uwm200.fptr02 = recid(sicuw.uwd201).
     nv_bptr = recid(sicuw.uwd201).
  end. /* End do nv_fptr */
  sicuw.uwm200.bptr02 = nv_bptr.

  /* RI Application Endorsement Text */
  nv_fptr = sic_bran.uwm200.fptr03.
  nv_bptr = 0.
  do while nv_fptr <> 0 and sic_bran.uwm200.fptr03 <> ? :
     find sic_bran.uwd202 where recid(sic_bran.uwd202) = nv_fptr
     no-lock no-error.
     if not available sic_bran.uwd202 then do: /*sombat */
       leave.
     end.
     nv_fptr = sic_bran.uwd202.fptr.
     create sicuw.uwd202.

     assign
         sicuw.uwd202.bptr          = nv_bptr
         sicuw.uwd202.fptr          = 0
     sicuw.uwd202.csftq         = sic_bran.uwd202.csftq
     sicuw.uwd202.c_enct        = sic_bran.uwd202.c_enct
     sicuw.uwd202.endcnt        = sic_bran.uwd202.endcnt
     sicuw.uwd202.ltext         = sic_bran.uwd202.ltext
     sicuw.uwd202.policy        = sic_bran.uwd202.policy
     sicuw.uwd202.rencnt        = sic_bran.uwd202.rencnt
     sicuw.uwd202.rico          = sic_bran.uwd202.rico.
     if nv_bptr <> 0 then do:
       find wf_uwd202 where recid(wf_uwd202) = nv_bptr.
       wf_uwd202.fptr = recid(sicuw.uwd202).
     end.
     if nv_bptr = 0 then  sicuw.uwm200.fptr03 = recid(sicuw.uwd202).
     nv_bptr = recid(sicuw.uwd202).
  end. /* End do nv_fptr */
  sicuw.uwm200.bptr03 = nv_bptr.


end. /* End for sic_bran uwm200 */





