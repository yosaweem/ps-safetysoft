/* WGWTB200.P */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
   Modify by : Narin  15/09/2009    A52-0242  
   DEFINE INPUT-OUTPUT PARAMETER  sh_policy  , sh_rencnt  , sh_endcnt , 
                                  nv_batchyr , nv_batchno , nv_batcnt
   ค่าดังกล่าวมาจากโปรแกรม Main wgw\wgwtrn72.w >>>> tm\tmcount.p  
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  --->  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
*/

DEFINE INPUT-OUTPUT PARAMETER  sh_policy    AS CHAR FORMAT "X(16)" INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_rencnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  sh_endcnt    AS INT  FORMAT "999"   INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.

DEF VAR nv_int  AS INT.
DEF VAR nv_fptr AS RECID.
DEF VAR nv_bptr AS RECID.
DEF STREAM str_inf.
DEF BUFFER wf_uwd200 FOR sic_bran.uwd200.
DEF BUFFER wf_uwd201 FOR sic_bran.uwd201.
DEF BUFFER wf_uwd202 FOR sic_bran.uwd202.

DEF SHARED STREAM ns1.    /*sombat*/
DEF VAR putchr AS CHAR FORMAT "x(100)" INIT "" NO-UNDO.

HIDE MESSAGE NO-PAUSE.
/*message "Update uwm200 and Delete uwd200/201/202".*/
/*
loop_uwm200:
    
FOR EACH brsic_bran.uwm200 WHERE
         brsic_bran.uwm200.policy = sh_policy AND
         brsic_bran.uwm200.rencnt = sh_rencnt AND
         brsic_bran.uwm200.endcnt = sh_endcnt
NO-LOCK:
*/
FIND FIRST brsic_bran.uwm200 WHERE
           brsic_bran.uwm200.policy = sh_policy AND
           brsic_bran.uwm200.rencnt = sh_rencnt AND
           brsic_bran.uwm200.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.
           
IF AVAILABLE brsic_bran.uwm200 THEN DO:

  FIND sic_bran.uwm200 WHERE 
       sic_bran.uwm200.policy = brsic_bran.uwm200.policy AND
       sic_bran.uwm200.rencnt = brsic_bran.uwm200.rencnt AND
       sic_bran.uwm200.endcnt = brsic_bran.uwm200.endcnt AND
       sic_bran.uwm200.csftq  = brsic_bran.uwm200.csftq  AND
       sic_bran.uwm200.rico   = brsic_bran.uwm200.rico   AND
       sic_bran.uwm200.c_enct = brsic_bran.uwm200.c_enct AND
       sic_bran.uwm200.bchyr  = nv_batchyr               AND
       sic_bran.uwm200.bchno  = nv_batchno               AND
       sic_bran.uwm200.bchcnt = nv_batcnt 
  NO-ERROR.

  /* IF AVAILABLE sic_bran.uwm200 THEN NEXT loop_uwm200.  */
  IF NOT AVAILABLE sic_bran.uwm200
  THEN DO:
     CREATE sic_bran.uwm200.
  END.

  /*delete uwd200 */
  nv_fptr = sic_bran.uwm200.fptr01.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm200.fptr01 <> ? :
     FIND sic_bran.uwd200 WHERE RECID(sic_bran.uwd200) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd200 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd200.fptr.
        IF sic_bran.uwd200.policy = brsic_bran.uwm200.policy AND
           sic_bran.uwd200.rencnt = brsic_bran.uwm200.rencnt AND
           sic_bran.uwd200.endcnt = brsic_bran.uwm200.endcnt 
        THEN DO:
           DELETE sic_bran.uwd200.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd201 */
  nv_fptr = sic_bran.uwm200.fptr02.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm200.fptr02 <> ? :
     FIND sic_bran.uwd201 WHERE RECID(sic_bran.uwd201) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd201 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd201.fptr.
        IF sic_bran.uwd201.policy = brsic_bran.uwm200.policy and
           sic_bran.uwd201.rencnt = brsic_bran.uwm200.rencnt and
           sic_bran.uwd201.endcnt = brsic_bran.uwm200.endcnt 
        THEN DO:
           DELETE sic_bran.uwd201.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd202 */
  nv_fptr = sic_bran.uwm200.fptr03.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm200.fptr03 <> ? :
     FIND sic_bran.uwd202 WHERE RECID(sic_bran.uwd202) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd202 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd202.fptr.
        IF sic_bran.uwd202.policy = brsic_bran.uwm200.policy AND
           sic_bran.uwd202.rencnt = brsic_bran.uwm200.rencnt AND
           sic_bran.uwd202.endcnt = brsic_bran.uwm200.endcnt 
        THEN DO:
           DELETE sic_bran.uwd202.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*Update Data*/
  ASSIGN
    sic_bran.uwm200.fptr01 = 0  sic_bran.uwm200.bptr01 = 0
    sic_bran.uwm200.fptr02 = 0  sic_bran.uwm200.bptr02 = 0
    sic_bran.uwm200.fptr03 = 0  sic_bran.uwm200.bptr03 = 0
    sic_bran.uwm200.bordno        = brsic_bran.uwm200.bordno
    sic_bran.uwm200.com2gn        = brsic_bran.uwm200.com2gn
    sic_bran.uwm200.csftq         = brsic_bran.uwm200.csftq
    sic_bran.uwm200.curbil        = brsic_bran.uwm200.curbil
    sic_bran.uwm200.c_enct        = brsic_bran.uwm200.c_enct
    sic_bran.uwm200.c_enno        = brsic_bran.uwm200.c_enno
    sic_bran.uwm200.c_no          = brsic_bran.uwm200.c_no
    sic_bran.uwm200.c_year        = brsic_bran.uwm200.c_year
    sic_bran.uwm200.dept          = brsic_bran.uwm200.dept
    sic_bran.uwm200.docri         = brsic_bran.uwm200.docri
    sic_bran.uwm200.dreg_p        = brsic_bran.uwm200.dreg_p
    sic_bran.uwm200.endcnt        = brsic_bran.uwm200.endcnt
    sic_bran.uwm200.panel         = brsic_bran.uwm200.panel
    sic_bran.uwm200.policy        = brsic_bran.uwm200.policy
    sic_bran.uwm200.prntri        = brsic_bran.uwm200.prntri
    sic_bran.uwm200.recip         = brsic_bran.uwm200.recip
    sic_bran.uwm200.reg_no        = brsic_bran.uwm200.reg_no
    sic_bran.uwm200.rencnt        = brsic_bran.uwm200.rencnt
    sic_bran.uwm200.rico          = brsic_bran.uwm200.rico
    sic_bran.uwm200.ricomm        = brsic_bran.uwm200.ricomm
    sic_bran.uwm200.riexp         = brsic_bran.uwm200.riexp
    sic_bran.uwm200.rip1          = brsic_bran.uwm200.rip1
    sic_bran.uwm200.rip1ae        = brsic_bran.uwm200.rip1ae
    sic_bran.uwm200.rip2          = brsic_bran.uwm200.rip2
    sic_bran.uwm200.rip2ae        = brsic_bran.uwm200.rip2ae
    sic_bran.uwm200.ristmp        = brsic_bran.uwm200.ristmp
    sic_bran.uwm200.thpol         = brsic_bran.uwm200.thpol
    sic_bran.uwm200.trndat        = brsic_bran.uwm200.trndat
    sic_bran.uwm200.trtyri        = brsic_bran.uwm200.trtyri
    sic_bran.uwm200.bchyr         = nv_batchyr          
    sic_bran.uwm200.bchno         = nv_batchno          
    sic_bran.uwm200.bchcnt        = nv_batcnt.

  /* End Update uwm200 */

  /* RI Out Premium */
  nv_fptr = brsic_bran.uwm200.fptr01.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm200.fptr01 <> ? :
     FIND brsic_bran.uwd200 WHERE RECID(brsic_bran.uwd200) = nv_fptr
     NO-LOCK NO-ERROR.
     IF NOT AVAILABLE brsic_bran.uwd200 THEN DO: /*sombat */
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd200.policy brsic_bran.uwd200.rencnt "/"
                brsic_bran.uwd200.endcnt "on file uwd200".

       putchr = "".
       putchr = "not found " + brsic_bran.uwd200.policy +
                " R/E " + STRING(brsic_bran.uwd200.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd200.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd200.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd200.riskno,"999") +
                " on file uwd200 RI Out Premium".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.

     nv_fptr = brsic_bran.uwd200.fptr.
     CREATE sic_bran.uwd200.

     ASSIGN
       sic_bran.uwd200.bptr          = nv_bptr
       sic_bran.uwd200.fptr          = 0
       sic_bran.uwd200.csftq         = brsic_bran.uwd200.csftq
       sic_bran.uwd200.c_enct        = brsic_bran.uwd200.c_enct
       sic_bran.uwd200.endcnt        = brsic_bran.uwd200.endcnt
       sic_bran.uwd200.policy        = brsic_bran.uwd200.policy
       sic_bran.uwd200.rencnt        = brsic_bran.uwd200.rencnt
       sic_bran.uwd200.ric1          = brsic_bran.uwd200.ric1
       sic_bran.uwd200.ric1ae        = brsic_bran.uwd200.ric1ae
       sic_bran.uwd200.ric2          = brsic_bran.uwd200.ric2
       sic_bran.uwd200.ric2ae        = brsic_bran.uwd200.ric2ae
       sic_bran.uwd200.rico          = brsic_bran.uwd200.rico
       sic_bran.uwd200.ripr          = brsic_bran.uwd200.ripr
       sic_bran.uwd200.ripsae        = brsic_bran.uwd200.ripsae
       sic_bran.uwd200.risi          = brsic_bran.uwd200.risi
       sic_bran.uwd200.risiae        = brsic_bran.uwd200.risiae
       sic_bran.uwd200.risiid        = brsic_bran.uwd200.risiid
       sic_bran.uwd200.risi_p        = brsic_bran.uwd200.risi_p
       sic_bran.uwd200.riskgp        = brsic_bran.uwd200.riskgp
       sic_bran.uwd200.riskno        = brsic_bran.uwd200.riskno
       sic_bran.uwd200.sicurr        = brsic_bran.uwd200.sicurr
       sic_bran.uwd200.bchyr         = nv_batchyr          
       sic_bran.uwd200.bchno         = nv_batchno          
       sic_bran.uwd200.bchcnt        = nv_batcnt.

     IF nv_bptr <> 0 THEN DO:
        FIND wf_uwd200 WHERE RECID(wf_uwd200) = nv_bptr.
        wf_uwd200.fptr = RECID(sic_bran.uwd200).
     END.
     IF nv_bptr = 0 THEN  sic_bran.uwm200.fptr01 = RECID(sic_bran.uwd200).
     nv_bptr = RECID(sic_bran.uwd200).
  END. /* End do nv_fptr */
  sic_bran.uwm200.bptr01 = nv_bptr.

  /* RI Application Text */
  nv_fptr = brsic_bran.uwm200.fptr02.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm200.fptr02 <> ? :
     FIND brsic_bran.uwd201 WHERE RECID(brsic_bran.uwd201) = nv_fptr
     NO-LOCK NO-ERROR.
     IF NOT AVAILABLE brsic_bran.uwd201 THEN DO: /*sombat */
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd201.policy brsic_bran.uwd201.rencnt "/"
                brsic_bran.uwd201.endcnt "on file uwd201".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd201.policy +
                " R/E " + STRING(brsic_bran.uwd201.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd201.endcnt,"999") +
                " on file uwd201 RI Appl, Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
     nv_fptr = brsic_bran.uwd201.fptr.
     CREATE sic_bran.uwd201.

     ASSIGN
         sic_bran.uwd201.bptr          = nv_bptr
         sic_bran.uwd201.fptr          = 0
         sic_bran.uwd201.csftq         = brsic_bran.uwd201.csftq
         sic_bran.uwd201.c_enct        = brsic_bran.uwd201.c_enct
         sic_bran.uwd201.endcnt        = brsic_bran.uwd201.endcnt
         sic_bran.uwd201.ltext         = brsic_bran.uwd201.ltext
         sic_bran.uwd201.policy        = brsic_bran.uwd201.policy
         sic_bran.uwd201.rencnt        = brsic_bran.uwd201.rencnt
         sic_bran.uwd201.rico          = brsic_bran.uwd201.rico.

     IF nv_bptr <> 0 THEN DO:
       FIND wf_uwd201 WHERE RECID(wf_uwd201) = nv_bptr.
       wf_uwd201.fptr = RECID(sic_bran.uwd201).
     END.
     IF nv_bptr = 0 THEN  sic_bran.uwm200.fptr02 = RECID(sic_bran.uwd201).
     nv_bptr = RECID(sic_bran.uwd201).
  END. /* End do nv_fptr */
  sic_bran.uwm200.bptr02 = nv_bptr.

  /* RI Application Endorsement Text */
  nv_fptr = brsic_bran.uwm200.fptr03.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm200.fptr03 <> ? :
     FIND brsic_bran.uwd202 WHERE RECID(brsic_bran.uwd202) = nv_fptr
     NO-LOCK NO-ERROR.
     IF NOT AVAILABLE brsic_bran.uwd202 THEN DO: /*sombat */
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd202.policy brsic_bran.uwd202.rencnt "/"
                brsic_bran.uwd202.endcnt "on file uwd202".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd202.policy +
                " R/E " + STRING(brsic_bran.uwd202.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd202.endcnt,"999") +
                " on file uwd202 RI Appl, End. Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
     nv_fptr = brsic_bran.uwd202.fptr.
     CREATE sic_bran.uwd202.

     ASSIGN
         sic_bran.uwd202.bptr          = nv_bptr
         sic_bran.uwd202.fptr          = 0
         sic_bran.uwd202.csftq         = brsic_bran.uwd202.csftq
         sic_bran.uwd202.c_enct        = brsic_bran.uwd202.c_enct
         sic_bran.uwd202.endcnt        = brsic_bran.uwd202.endcnt
         sic_bran.uwd202.ltext         = brsic_bran.uwd202.ltext
         sic_bran.uwd202.policy        = brsic_bran.uwd202.policy
         sic_bran.uwd202.rencnt        = brsic_bran.uwd202.rencnt
         sic_bran.uwd202.rico          = brsic_bran.uwd202.rico.
     IF nv_bptr <> 0 THEN DO:
        FIND wf_uwd202 WHERE RECID(wf_uwd202) = nv_bptr.
        wf_uwd202.fptr = RECID(sic_bran.uwd202).
     END.
     IF nv_bptr = 0  THEN  sic_bran.uwm200.fptr03 = RECID(sic_bran.uwd202).
     nv_bptr = RECID(sic_bran.uwd202).
  END. /* End do nv_fptr */
  sic_bran.uwm200.bptr03 = nv_bptr.


END. /* IF AVAILABLE brsic_bran.uwm200 THEN DO: */

/* END OF : WGWTB200.P */
