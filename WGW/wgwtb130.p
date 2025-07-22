/* WGWTB130.P */
/* Transfer data from test to premium */
/* uwm130                             */
/*
   Sombat Phu. : 26/04/2003
   Description : Transfer data from Brach to Branch
                 brsic_bran ->  sic_bran
                 brstat     ->  stat
   Modify  by  : sombat 04/03/1998
                 Transfer data path frame realay
                 change name host to sicuw
   Modify by   : Narin  15/09/2010    A52-0242 
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

DEF BUFFER wf_uwd130 FOR sic_bran.uwd130.
DEF BUFFER wf_uwd131 FOR sic_bran.uwd131.
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DEF BUFFER wf_uwd134 FOR sic_bran.uwd134.
DEF BUFFER wf_uwd136 FOR sic_bran.uwd136.


DEF SHARED STREAM ns1.    /*sombat*/
DEF VAR putchr AS CHAR FORMAT "x(100)" INIT "" NO-UNDO.

HIDE MESSAGE no-pause.
/*message "Update uwm130 and Delete uwd130/131/132/134/136".*/

DEF    VAR nv_brsic_bran AS INTE INIT 0  NO-UNDO.
DEF    VAR nv_host       AS INTE INIT 0  NO-UNDO.
/*----
FOR EACH brsic_bran.uwm130 WHERE           
    brsic_bran.uwm130.policy = sh_policy AND
    brsic_bran.uwm130.rencnt = sh_rencnt AND
    brsic_bran.uwm130.endcnt = sh_endcnt
NO-LOCK:
    nv_brsic_bran = nv_brsic_bran + 1.
END.

FOR EACH sic_bran.uwm130 WHERE
    sic_bran.uwm130.policy = sh_policy AND
    sic_bran.uwm130.rencnt = sh_rencnt AND
    sic_bran.uwm130.endcnt = sh_endcnt
NO-LOCK:
    nv_host = nv_host + 1.
END.

/* Delete host file uwm130 */
IF nv_host <> nv_brsic_bran THEN DO:
  FOR EACH sic_bran.uwm130 WHERE
      sic_bran.uwm130.policy = sh_policy AND
      sic_bran.uwm130.rencnt = sh_rencnt AND
      sic_bran.uwm130.endcnt = sh_endcnt
  :

  /*delete uwd130 */
    nv_fptr = sic_bran.uwm130.fptr01.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr01 <> ? :
       FIND sic_bran.uwd130 WHERE RECID(sic_bran.uwd130) = nv_fptr
           NO-ERROR.
       IF AVAILABLE sic_bran.uwd130 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd130.fptr.
          IF sic_bran.uwd130.policy = sh_policy AND
             sic_bran.uwd130.rencnt = sh_rencnt AND
             sic_bran.uwd130.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd130.
           END.
           ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.


  /*delete uwd131 */
    nv_fptr = sic_bran.uwm130.fptr02.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr02 <> ? :
       FIND sic_bran.uwd131 WHERE RECID(sic_bran.uwd131) = nv_fptr
           NO-ERROR.
       IF AVAILABLE sic_bran.uwd131 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd131.fptr.
          IF sic_bran.uwd131.policy = sh_policy AND
             sic_bran.uwd131.rencnt = sh_rencnt AND
             sic_bran.uwd131.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd131.
           END.
           ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.

  /*delete uwd132 */
    nv_fptr = sic_bran.uwm130.fptr03.
    DO WHILE nv_fptr <> 0 and sic_bran.uwm130.fptr03 <> ? :
       FIND sic_bran.uwd132 where recid(sic_bran.uwd132) = nv_fptr
           NO-ERROR.
       IF AVAILABLE sic_bran.uwd132 then do: /*sombat */
          nv_fptr = sic_bran.uwd132.fptr.
          IF sic_bran.uwd132.policy = sh_policy AND
             sic_bran.uwd132.rencnt = sh_rencnt AND
             sic_bran.uwd132.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd132.
          END.
          ELSE  nv_fptr = 0.
       END.
       ELSE     nv_fptr = 0.
    END.

  /*delete uwd134 */
    nv_fptr = sic_bran.uwm130.fptr04.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr04 <> ? :
       FIND sic_bran.uwd134 WHERE RECID(sic_bran.uwd134) = nv_fptr
           NO-ERROR.
       IF AVAILABLE sic_bran.uwd134 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd134.fptr.
          IF sic_bran.uwd134.policy = sh_policy AND
             sic_bran.uwd134.rencnt = sh_rencnt AND
             sic_bran.uwd134.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd134.
          END.
          ELSE  nv_fptr = 0.
       END.
       ELSE     nv_fptr = 0.
    END.

  /*delete uwd136 */
    nv_fptr = sic_bran.uwm130.fptr05.
    DO WHILE nv_fptr <> 0 and sic_bran.uwm130.fptr05 <> ? :
       FIND sic_bran.uwd136 where recid(sic_bran.uwd136) = nv_fptr
           NO-ERROR.
       IF AVAILABLE sic_bran.uwd136 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd136.fptr.
          IF sic_bran.uwd136.policy = sh_policy AND
             sic_bran.uwd136.rencnt = sh_rencnt AND
             sic_bran.uwd136.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd136.
           END.
           ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.
    DELETE sic_bran.uwm130.
  END.

END.
-------------------*/
    
FOR EACH brsic_bran.uwm130 WHERE
         brsic_bran.uwm130.policy = sh_policy AND
         brsic_bran.uwm130.rencnt = sh_rencnt AND
         brsic_bran.uwm130.endcnt = sh_endcnt
NO-LOCK:
    
FIND sic_bran.uwm130 WHERE 
       sic_bran.uwm130.policy = brsic_bran.uwm130.policy AND
       sic_bran.uwm130.rencnt = brsic_bran.uwm130.rencnt AND
       sic_bran.uwm130.endcnt = brsic_bran.uwm130.endcnt AND
       sic_bran.uwm130.riskgp = brsic_bran.uwm130.riskgp AND
       sic_bran.uwm130.riskno = brsic_bran.uwm130.riskno AND
       sic_bran.uwm130.itemno = brsic_bran.uwm130.itemno AND
       sic_bran.uwm130.bchyr  = nv_batchyr               AND
       sic_bran.uwm130.bchno  = nv_batchno               AND
       sic_bran.uwm130.bchcnt = nv_batcnt                      

  NO-ERROR .
  IF NOT AVAILABLE sic_bran.uwm130
  THEN DO:
     CREATE sic_bran.uwm130.
  END.

  /*delete uwd130 */
  nv_fptr = sic_bran.uwm130.fptr01.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr01 <> ? :
     FIND sic_bran.uwd130 WHERE RECID(sic_bran.uwd130) = nv_fptr
         NO-ERROR.
     IF AVAILABLE sic_bran.uwd130 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd130.fptr.
        IF sic_bran.uwd130.policy = brsic_bran.uwm130.policy AND
           sic_bran.uwd130.rencnt = brsic_bran.uwm130.rencnt AND
           sic_bran.uwd130.endcnt = brsic_bran.uwm130.endcnt THEN DO:
           DELETE sic_bran.uwd130.
         END.
         ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd131 */
  nv_fptr = sic_bran.uwm130.fptr02.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr02 <> ? :
     FIND sic_bran.uwd131 WHERE RECID(sic_bran.uwd131) = nv_fptr
         NO-ERROR.
     IF AVAILABLE sic_bran.uwd131 then do: /*sombat */
        nv_fptr = sic_bran.uwd131.fptr.
        IF sic_bran.uwd131.policy = brsic_bran.uwm130.policy AND
           sic_bran.uwd131.rencnt = brsic_bran.uwm130.rencnt AND
           sic_bran.uwd131.endcnt = brsic_bran.uwm130.endcnt THEN DO:
           DELETE sic_bran.uwd131.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE     nv_fptr = 0.
  END.

  /*delete uwd132 */
  nv_fptr = sic_bran.uwm130.fptr03.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr03 <> ? :
     FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
          NO-ERROR.
     IF AVAILABLE sic_bran.uwd132 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd132.fptr.
        IF sic_bran.uwd132.policy = brsic_bran.uwm130.policy and
           sic_bran.uwd132.rencnt = brsic_bran.uwm130.rencnt and
           sic_bran.uwd132.endcnt = brsic_bran.uwm130.endcnt then do:
           DELETE sic_bran.uwd132.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE     nv_fptr = 0.
  END.

  /*delete uwd134 */
  nv_fptr = sic_bran.uwm130.fptr04.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr04 <> ? :
     FIND sic_bran.uwd134 WHERE RECID(sic_bran.uwd134) = nv_fptr
          NO-ERROR.
     IF AVAILABLE sic_bran.uwd134 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd134.fptr.
        IF sic_bran.uwd134.policy = brsic_bran.uwm130.policy AND
           sic_bran.uwd134.rencnt = brsic_bran.uwm130.rencnt AND
           sic_bran.uwd134.endcnt = brsic_bran.uwm130.endcnt THEN DO:
           DELETE sic_bran.uwd134.
         END.
         ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd136 */
  nv_fptr = sic_bran.uwm130.fptr05.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm130.fptr05 <> ? :
     FIND sic_bran.uwd136 WHERE RECID(sic_bran.uwd136) = nv_fptr
          NO-ERROR.
     IF AVAILABLE sic_bran.uwd136 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd136.fptr.
        IF sic_bran.uwd136.policy = brsic_bran.uwm130.policy AND
           sic_bran.uwd136.rencnt = brsic_bran.uwm130.rencnt AND
           sic_bran.uwd136.endcnt = brsic_bran.uwm130.endcnt THEN DO:
           DELETE sic_bran.uwd136.
         END.
         ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*Update Data */
  ASSIGN
    sic_bran.uwm130.bptr01     = 0
    sic_bran.uwm130.bptr02     = 0
    sic_bran.uwm130.bptr03     = 0
    sic_bran.uwm130.bptr04     = 0
    sic_bran.uwm130.bptr05     = 0
    sic_bran.uwm130.dl1per     = brsic_bran.uwm130.dl1per
    sic_bran.uwm130.dl2per     = brsic_bran.uwm130.dl2per
    sic_bran.uwm130.dl3per     = brsic_bran.uwm130.dl3per
    sic_bran.uwm130.endcnt     = brsic_bran.uwm130.endcnt
    sic_bran.uwm130.fptr01     = 0
    sic_bran.uwm130.fptr02     = 0
    sic_bran.uwm130.fptr03     = 0
    sic_bran.uwm130.fptr04     = 0
    sic_bran.uwm130.fptr05     = 0
    sic_bran.uwm130.itemno     = brsic_bran.uwm130.itemno
    sic_bran.uwm130.itmdel     = brsic_bran.uwm130.itmdel
    sic_bran.uwm130.i_text     = brsic_bran.uwm130.i_text
    sic_bran.uwm130.policy     = brsic_bran.uwm130.policy
    sic_bran.uwm130.rencnt     = brsic_bran.uwm130.rencnt
    sic_bran.uwm130.riskgp     = brsic_bran.uwm130.riskgp
    sic_bran.uwm130.riskno     = brsic_bran.uwm130.riskno
    sic_bran.uwm130.styp20     = brsic_bran.uwm130.styp20
    sic_bran.uwm130.sval20     = brsic_bran.uwm130.sval20
    sic_bran.uwm130.uom1_c     = brsic_bran.uwm130.uom1_c
    sic_bran.uwm130.uom1_u     = brsic_bran.uwm130.uom1_u
    sic_bran.uwm130.uom1_v     = brsic_bran.uwm130.uom1_v
    sic_bran.uwm130.uom2_c     = brsic_bran.uwm130.uom2_c
    sic_bran.uwm130.uom2_u     = brsic_bran.uwm130.uom2_u
    sic_bran.uwm130.uom2_v     = brsic_bran.uwm130.uom2_v
    sic_bran.uwm130.uom3_c     = brsic_bran.uwm130.uom3_c
    sic_bran.uwm130.uom3_u     = brsic_bran.uwm130.uom3_u
    sic_bran.uwm130.uom3_v     = brsic_bran.uwm130.uom3_v
    sic_bran.uwm130.uom4_c     = brsic_bran.uwm130.uom4_c
    sic_bran.uwm130.uom4_u     = brsic_bran.uwm130.uom4_u
    sic_bran.uwm130.uom4_v     = brsic_bran.uwm130.uom4_v
    sic_bran.uwm130.uom5_c     = brsic_bran.uwm130.uom5_c
    sic_bran.uwm130.uom5_u     = brsic_bran.uwm130.uom5_u
    sic_bran.uwm130.uom5_v     = brsic_bran.uwm130.uom5_v
    sic_bran.uwm130.uom6_c     = brsic_bran.uwm130.uom6_c
    sic_bran.uwm130.uom6_u     = brsic_bran.uwm130.uom6_u
    sic_bran.uwm130.uom6_v     = brsic_bran.uwm130.uom6_v
    sic_bran.uwm130.uom7_c     = brsic_bran.uwm130.uom7_c
    sic_bran.uwm130.uom7_u     = brsic_bran.uwm130.uom7_u
    sic_bran.uwm130.uom7_v     = brsic_bran.uwm130.uom7_v
    sic_bran.uwm130.uom8_c     = brsic_bran.uwm130.uom8_c
    sic_bran.uwm130.uom8_v     = brsic_bran.uwm130.uom8_v
    sic_bran.uwm130.uom9_c     = brsic_bran.uwm130.uom9_c
    sic_bran.uwm130.uom9_v     = brsic_bran.uwm130.uom9_v
    sic_bran.uwm130.bchyr      = nv_batchyr   
    sic_bran.uwm130.bchno      = nv_batchno   
    sic_bran.uwm130.bchcnt     = nv_batcnt.

  /* End Update uwm130. */

  /* Insured Item Upper Text */
  nv_fptr = brsic_bran.uwm130.fptr01.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm130.fptr01 <> ? :
     FIND brsic_bran.uwd130 WHERE RECID(brsic_bran.uwd130) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd130 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd130.fptr.
       CREATE sic_bran.uwd130.

       ASSIGN
         sic_bran.uwd130.bptr          = nv_bptr
         sic_bran.uwd130.endcnt        = brsic_bran.uwd130.endcnt
         sic_bran.uwd130.fptr          = 0
         sic_bran.uwd130.itemno        = brsic_bran.uwd130.itemno
         sic_bran.uwd130.ltext         = brsic_bran.uwd130.ltext
         sic_bran.uwd130.policy        = brsic_bran.uwd130.policy
         sic_bran.uwd130.rencnt        = brsic_bran.uwd130.rencnt
         sic_bran.uwd130.riskgp        = brsic_bran.uwd130.riskgp
         sic_bran.uwd130.riskno        = brsic_bran.uwd130.riskno.
       IF nv_bptr <> 0 THEN DO:
          FIND wf_uwd130 WHERE RECID(wf_uwd130) = nv_bptr.
          wf_uwd130.fptr = RECID(sic_bran.uwd130).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm130.fptr01 = RECID(sic_bran.uwd130).
       nv_bptr = RECID(sic_bran.uwd130).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd130.policy brsic_bran.uwd130.rencnt "/"
                brsic_bran.uwd130.endcnt "on file uwd130".
       putchr = "".
       putchr = "not found "   + brsic_bran.uwd130.policy +
                " R/E " + STRING(brsic_bran.uwd130.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd130.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd130.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd130.riskno,"999") +
                " on file uwd130 Ins. Item Upper Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.

  END. /* End do nv_fptr */
  sic_bran.uwm130.bptr01 = nv_bptr.

  /* Insured Item Lower Text */
  nv_fptr = brsic_bran.uwm130.fptr02.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm130.fptr02 <> ? :
     FIND brsic_bran.uwd131 WHERE RECID(brsic_bran.uwd131) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd131 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd131.fptr.
       CREATE sic_bran.uwd131.

       ASSIGN
         sic_bran.uwd131.bptr          = nv_bptr
         sic_bran.uwd131.endcnt        = brsic_bran.uwd131.endcnt
         sic_bran.uwd131.fptr          = 0
         sic_bran.uwd131.itemno        = brsic_bran.uwd131.itemno
         sic_bran.uwd131.ltext         = brsic_bran.uwd131.ltext
         sic_bran.uwd131.policy        = brsic_bran.uwd131.policy
         sic_bran.uwd131.rencnt        = brsic_bran.uwd131.rencnt
         sic_bran.uwd131.riskgp        = brsic_bran.uwd131.riskgp
         sic_bran.uwd131.riskno        = brsic_bran.uwd131.riskno.

       IF nv_bptr <> 0 THEN DO:
          FIND wf_uwd131 WHERE RECID(wf_uwd131) = nv_bptr.
          wf_uwd131.fptr = RECID(sic_bran.uwd131).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm130.fptr02 = RECID(sic_bran.uwd131).
       nv_bptr = RECID(sic_bran.uwd131).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd131.policy brsic_bran.uwd131.rencnt "/"
                brsic_bran.uwd131.endcnt "on file uwd131".
       putchr = "".
       putchr = "not found "   + brsic_bran.uwd131.policy +
                " R/E " + STRING(brsic_bran.uwd131.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd131.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd131.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd131.riskno,"999") +
                " on file uwd131 Ins. Item Lower Text".
       PUT STREAM ns1 putchr format "x(100)" SKIP.
       LEAVE.
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm130.bptr02 = nv_bptr.

  /* Insured Item Benefit & Premium */
  nv_fptr = brsic_bran.uwm130.fptr03.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm130.fptr03 <> ? :
     FIND brsic_bran.uwd132 WHERE RECID(brsic_bran.uwd132) = nv_fptr
     NO-LOCK NO-ERROR.
         
     IF AVAILABLE brsic_bran.uwd132 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd132.fptr.
       CREATE sic_bran.uwd132.

       ASSIGN
         sic_bran.uwd132.bencod        = brsic_bran.uwd132.bencod
         sic_bran.uwd132.benvar        = brsic_bran.uwd132.benvar
         sic_bran.uwd132.bptr          = nv_bptr
         sic_bran.uwd132.dl1_c         = brsic_bran.uwd132.dl1_c
         sic_bran.uwd132.dl2_c         = brsic_bran.uwd132.dl2_c
         sic_bran.uwd132.dl3_c         = brsic_bran.uwd132.dl3_c
         sic_bran.uwd132.endcnt        = brsic_bran.uwd132.endcnt
         sic_bran.uwd132.fptr          = 0
         sic_bran.uwd132.gap_ae        = brsic_bran.uwd132.gap_ae
         sic_bran.uwd132.gap_c         = brsic_bran.uwd132.gap_c
         sic_bran.uwd132.itemno        = brsic_bran.uwd132.itemno
         sic_bran.uwd132.pd_aep        = brsic_bran.uwd132.pd_aep
         sic_bran.uwd132.policy        = brsic_bran.uwd132.policy
         sic_bran.uwd132.prem_c        = brsic_bran.uwd132.prem_c
         sic_bran.uwd132.rate          = brsic_bran.uwd132.rate
         sic_bran.uwd132.rateae        = brsic_bran.uwd132.rateae
         sic_bran.uwd132.rencnt        = brsic_bran.uwd132.rencnt
         sic_bran.uwd132.riskgp        = brsic_bran.uwd132.riskgp
         sic_bran.uwd132.riskno        = brsic_bran.uwd132.riskno
         sic_bran.uwd132.bchyr         = nv_batchyr   
         sic_bran.uwd132.bchno         = nv_batchno   
         sic_bran.uwd132.bchcnt        = nv_batcnt .

          IF nv_bptr <> 0 THEN DO:
          
            FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                 wf_uwd132.fptr = RECID(sic_bran.uwd132).
          END.
          IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03 = RECID(sic_bran.uwd132).
             nv_bptr = RECID(sic_bran.uwd132).

     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd132.policy brsic_bran.uwd132.rencnt "/"
                brsic_bran.uwd132.endcnt "on file uwd132".
       putchr = "".
       putchr = "not found "   + brsic_bran.uwd132.policy +
                " R/E " + STRING(brsic_bran.uwd132.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd132.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd132.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd132.riskno,"999") +
                " on file uwd132 Ins. Item Benefit & Premium".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm130.bptr03 = nv_bptr.

  /* Insured Item Endorsement Text */
  nv_fptr = brsic_bran.uwm130.fptr04.
  nv_bptr = 0.
  /* loop_134: */
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm130.fptr04 <> ? :
     FIND brsic_bran.uwd134 WHERE RECID(brsic_bran.uwd134) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd134 THEN DO: /*sombat */
          nv_fptr = brsic_bran.uwd134.fptr.
       CREATE sic_bran.uwd134.

       ASSIGN
       sic_bran.uwd134.bptr          = nv_bptr
       sic_bran.uwd134.endcnt        = brsic_bran.uwd134.endcnt
       sic_bran.uwd134.fptr          = 0
       sic_bran.uwd134.itemno        = brsic_bran.uwd134.itemno
       sic_bran.uwd134.ltext         = brsic_bran.uwd134.ltext
       sic_bran.uwd134.policy        = brsic_bran.uwd134.policy
       sic_bran.uwd134.rencnt        = brsic_bran.uwd134.rencnt
       sic_bran.uwd134.riskgp        = brsic_bran.uwd134.riskgp
       sic_bran.uwd134.riskno        = brsic_bran.uwd134.riskno.

       IF nv_bptr <> 0 THEN DO:
         FIND wf_uwd134 WHERE RECID(wf_uwd134) = nv_bptr.
         IF NOT AVAILABLE brsic_bran.uwd134 THEN LEAVE. /*sombat */
         wf_uwd134.fptr = RECID(sic_bran.uwd134).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm130.fptr03 = RECID(sic_bran.uwd134).
       nv_bptr = RECID(sic_bran.uwd134).

     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd134.policy brsic_bran.uwd134.rencnt "/"
                brsic_bran.uwd134.endcnt "on file uwd134".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd134.policy +
                " R/E " + STRING(brsic_bran.uwd134.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd134.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd134.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd134.riskno,"999") +
                " on file uwd134 Ins. Item End. Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       nv_fptr = 0.
       LEAVE.   /* loop_134. */
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm130.bptr04 = nv_bptr.

  /* Insured Item Endorsement Clauses */
  nv_fptr = brsic_bran.uwm130.fptr05.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm130.fptr05 <> ? :
     FIND brsic_bran.uwd136 WHERE RECID(brsic_bran.uwd136) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd136 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd136.fptr.
       CREATE sic_bran.uwd136.

       ASSIGN
       sic_bran.uwd136.bptr          = nv_bptr
       sic_bran.uwd136.endcls        = brsic_bran.uwd136.endcls
       sic_bran.uwd136.endcnt        = brsic_bran.uwd136.endcnt
       sic_bran.uwd136.fptr          = 0
       sic_bran.uwd136.itemno        = brsic_bran.uwd136.itemno
       sic_bran.uwd136.policy        = brsic_bran.uwd136.policy
       sic_bran.uwd136.rencnt        = brsic_bran.uwd136.rencnt
       sic_bran.uwd136.riskgp        = brsic_bran.uwd136.riskgp
       sic_bran.uwd136.riskno        = brsic_bran.uwd136.riskno.

       IF nv_bptr <> 0 THEN DO:
         FIND wf_uwd136 WHERE RECID(wf_uwd136) = nv_bptr.
         wf_uwd136.fptr = RECID(sic_bran.uwd136).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm130.fptr05 = RECID(sic_bran.uwd136).
       nv_bptr = RECID(sic_bran.uwd136).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd136.policy brsic_bran.uwd136.rencnt "/"
                brsic_bran.uwd136.endcnt "on file uwd136".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd136.policy +
                " R/E " + STRING(brsic_bran.uwd136.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd136.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd136.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd136.riskno,"999") +
                " on file uwd136 Ins. Item End. Clauses".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.

  END. /* End do nv_fptr */
  sic_bran.uwm130.bptr05 = nv_bptr.

END. /* IF AVAILABLE brsic_bran.uwm130 THEN DO: */

/* END OF : WGWTB130.P */
