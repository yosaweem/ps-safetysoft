/* WGWTB120.P */
/* Transfer data from test to premium */
/* UWM120                             */
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
                                  nv_com1p   , nv_com1_t  ,
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
DEFINE INPUT-OUTPUT PARAMETER  nv_com1p     AS DECIMAL.
DEFINE INPUT-OUTPUT PARAMETER  nv_com1_t    AS DECIMAL.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr   AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno   AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt    AS INT  FORMAT "99"    INIT 0.

DEF SHARED STREAM ns1.    /*sombat*/

DEF VAR nv_confirm AS LOGICAL.
DEF VAR nv_int     AS INT.
DEF VAR nv_fptr    AS RECID.
DEF VAR nv_bptr    AS RECID.
DEF STREAM str_inf.

DEF BUFFER wf_uwd120 FOR sic_bran.uwd120.
DEF BUFFER wf_uwd121 FOR sic_bran.uwd121.
DEF BUFFER wf_uwd123 FOR sic_bran.uwd123.
DEF BUFFER wf_uwd124 FOR sic_bran.uwd124.
DEF BUFFER wf_uwd125 FOR sic_bran.uwd125.
DEF BUFFER wf_uwd126 FOR sic_bran.uwd126.

DEF VAR putchr AS CHAR FORMAT "x(100)" INIT "" NO-UNDO.
/**----
DEF VAR nv_com1p   AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
DEF VAR nv_com1_t  AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
----**/

HIDE MESSAGE NO-PAUSE.
/*message " Move uwm120 and Delete file uwd120/121/123/124/125/126".*/

DEF            VAR nv_sicuw     AS INTE INIT 0  NO-UNDO.
DEF            VAR nv_host      AS INTE INIT 0  NO-UNDO.
/*-----------------
FOR EACH brsic_bran.uwm120 WHERE
    brsic_bran.uwm120.policy = sh_policy AND
    brsic_bran.uwm120.rencnt = sh_rencnt AND
    brsic_bran.uwm120.endcnt = sh_endcnt
NO-LOCK:
    nv_sicuw = nv_sicuw + 1.
END.

FOR EACH sic_bran.uwm120 WHERE 
    sic_bran.uwm120.policy = sh_policy AND
    sic_bran.uwm120.rencnt = sh_rencnt AND
    sic_bran.uwm120.endcnt = sh_endcnt
NO-LOCK:
    nv_host = nv_host + 1.
END.

/* Delete host file uwm120 */
IF nv_host <> nv_sicuw THEN DO:
  FOR EACH sic_bran.uwm120 WHERE
      sic_bran.uwm120.policy = sh_policy AND
      sic_bran.uwm120.rencnt = sh_rencnt AND
      sic_bran.uwm120.endcnt = sh_endcnt
  :

  /*delete uwd120 */
    nv_fptr = sic_bran.uwm120.fptr01.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr01 <> ? :
       FIND sic_bran.uwd120 WHERE RECID(sic_bran.uwd120) = nv_fptr
       NO-ERROR.
       IF AVAILABLE sic_bran.uwd120 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd120.fptr.
          IF sic_bran.uwd120.policy = sh_policy AND
             sic_bran.uwd120.rencnt = sh_rencnt AND
             sic_bran.uwd120.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd120.
          END.
          ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.

  /*delete uwd121 */
    nv_fptr = sic_bran.uwm120.fptr02.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr02 <> ? :
       FIND sic_bran.uwd121 WHERE RECID(sic_bran.uwd121) = nv_fptr
       NO-ERROR.
       IF AVAILABLE sic_bran.uwd121 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd121.fptr.
          IF sic_bran.uwd121.policy = sh_policy AND
             sic_bran.uwd121.rencnt = sh_rencnt AND
             sic_bran.uwd121.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd121.
          END.
          ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.

  /*delete uwd123 */
    nv_fptr = sic_bran.uwm120.fptr03.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr03 <> ? :
       FIND sic_bran.uwd123 WHERE RECID(sic_bran.uwd123) = nv_fptr
       NO-ERROR.
       IF AVAILABLE sic_bran.uwd123 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd123.fptr.
          IF sic_bran.uwd123.policy = sh_policy AND
             sic_bran.uwd123.rencnt = sh_rencnt AND
             sic_bran.uwd123.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd123.
           END.
           ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.

  /*delete uwd125 */
    nv_fptr = sic_bran.uwm120.fptr04.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr04 <> ? :
       FIND sic_bran.uwd125 WHERE RECID(sic_bran.uwd125) = nv_fptr
       NO-ERROR.
       IF AVAILABLE sic_bran.uwd125 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd125.fptr.
          IF sic_bran.uwd125.policy = sh_policy AND
             sic_bran.uwd125.rencnt = sh_rencnt AND
             sic_bran.uwd125.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd125.
           END.
           ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.

  /*delete uwd124 */
    nv_fptr = sic_bran.uwm120.fptr08.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr08 <> ? :
       FIND sic_bran.uwd124 WHERE RECID(sic_bran.uwd124) = nv_fptr
       NO-ERROR.
       IF AVAILABLE sic_bran.uwd124 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd124.fptr.
          IF sic_bran.uwd124.policy = sh_policy AND
             sic_bran.uwd124.rencnt = sh_rencnt AND
             sic_bran.uwd124.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd124.
           END.
           ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.

  /*delete uwd126 */
    nv_fptr = sic_bran.uwm120.fptr09.
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr09 <> ? :
       FIND sic_bran.uwd126 WHERE RECID(sic_bran.uwd126) = nv_fptr
       NO-ERROR.
       IF AVAILABLE sic_bran.uwd126 THEN DO: /*sombat */
          nv_fptr = sic_bran.uwd126.fptr.
          IF sic_bran.uwd126.policy = sh_policy AND
             sic_bran.uwd126.rencnt = sh_rencnt AND
             sic_bran.uwd126.endcnt = sh_endcnt THEN DO:
             DELETE sic_bran.uwd126.
          END.
          ELSE  nv_fptr = 0.
       END.
       ELSE      nv_fptr = 0.
    END.
    DELETE sic_bran.uwm120.
  END.

END.
--------------------------*/
    /*
FOR EACH brsic_bran.uwm120 WHERE
         brsic_bran.uwm120.policy = sh_policy AND
         brsic_bran.uwm120.rencnt = sh_rencnt AND
         brsic_bran.uwm120.endcnt = sh_endcnt
NO-LOCK:
  */ 

FIND FIRST brsic_bran.uwm120 WHERE
           brsic_bran.uwm120.policy = sh_policy AND
           brsic_bran.uwm120.rencnt = sh_rencnt AND
           brsic_bran.uwm120.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.

IF AVAILABLE brsic_bran.uwm120 THEN DO:

  FIND sic_bran.uwm120 WHERE 
       sic_bran.uwm120.policy = brsic_bran.uwm120.policy AND
       sic_bran.uwm120.rencnt = brsic_bran.uwm120.rencnt AND
       sic_bran.uwm120.endcnt = brsic_bran.uwm120.endcnt AND
       sic_bran.uwm120.riskgp = brsic_bran.uwm120.riskgp AND
       sic_bran.uwm120.riskno = brsic_bran.uwm120.riskno AND
       sic_bran.uwm120.bchyr  = nv_batchyr               AND
       sic_bran.uwm120.bchno  = nv_batchno               AND
       sic_bran.uwm120.bchcnt = nv_batcnt 
  NO-ERROR .
  IF NOT AVAILABLE sic_bran.uwm120
  THEN DO:
    CREATE sic_bran.uwm120.
  END.

  /*delete uwd120 */
  nv_fptr = sic_bran.uwm120.fptr01.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr01 <> ? :
     FIND sic_bran.uwd120 WHERE RECID(sic_bran.uwd120) = nv_fptr
     NO-ERROR.
     if available sic_bran.uwd120 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd120.fptr.
        IF sic_bran.uwd120.policy = brsic_bran.uwm120.policy AND
           sic_bran.uwd120.rencnt = brsic_bran.uwm120.rencnt AND
           sic_bran.uwd120.endcnt = brsic_bran.uwm120.endcnt THEN DO:
           DELETE sic_bran.uwd120.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd121 */
  nv_fptr = sic_bran.uwm120.fptr02.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr02 <> ? :
     FIND sic_bran.uwd121 WHERE RECID(sic_bran.uwd121) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd121 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd121.fptr.
        IF sic_bran.uwd121.policy = brsic_bran.uwm120.policy AND
           sic_bran.uwd121.rencnt = brsic_bran.uwm120.rencnt AND
           sic_bran.uwd121.endcnt = brsic_bran.uwm120.endcnt THEN DO:
           DELETE sic_bran.uwd121.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd123 */
  nv_fptr = sic_bran.uwm120.fptr03.
  DO WHILE nv_fptr <> 0 and sic_bran.uwm120.fptr03 <> ? :
     FIND sic_bran.uwd123 where recid(sic_bran.uwd123) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd123 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd123.fptr.
        IF sic_bran.uwd123.policy = brsic_bran.uwm120.policy AND
           sic_bran.uwd123.rencnt = brsic_bran.uwm120.rencnt AND
           sic_bran.uwd123.endcnt = brsic_bran.uwm120.endcnt THEN DO:
           DELETE sic_bran.uwd123.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd125 */
  nv_fptr = sic_bran.uwm120.fptr04.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr04 <> ? :
     FIND sic_bran.uwd125 WHERE RECID(sic_bran.uwd125) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd125 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd125.fptr.
        IF sic_bran.uwd125.policy = brsic_bran.uwm120.policy AND
           sic_bran.uwd125.rencnt = brsic_bran.uwm120.rencnt AND
           sic_bran.uwd125.endcnt = brsic_bran.uwm120.endcnt THEN DO:
           DELETE sic_bran.uwd125.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd124 */
  nv_fptr = sic_bran.uwm120.fptr08.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr08 <> ? :
     FIND sic_bran.uwd124 WHERE RECID(sic_bran.uwd124) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd124 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd124.fptr.
        IF sic_bran.uwd124.policy = brsic_bran.uwm120.policy AND
           sic_bran.uwd124.rencnt = brsic_bran.uwm120.rencnt AND
           sic_bran.uwd124.endcnt = brsic_bran.uwm120.endcnt THEN DO:
           DELETE sic_bran.uwd124.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*delete uwd126 */
  nv_fptr = sic_bran.uwm120.fptr09.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm120.fptr09 <> ? :
     FIND sic_bran.uwd126 WHERE RECID(sic_bran.uwd126) = nv_fptr
     NO-ERROR.
     IF AVAILABLE sic_bran.uwd126 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd126.fptr.
        IF sic_bran.uwd126.policy = brsic_bran.uwm120.policy AND
           sic_bran.uwd126.rencnt = brsic_bran.uwm120.rencnt AND
           sic_bran.uwd126.endcnt = brsic_bran.uwm120.endcnt THEN DO:
           DELETE sic_bran.uwd126.
        END.
        ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

  /*Update uwm120*/
  ASSIGN
    sic_bran.uwm120.bptr01      = 0
    sic_bran.uwm120.bptr02      = 0
    sic_bran.uwm120.bptr03      = 0
    sic_bran.uwm120.bptr04      = 0
    sic_bran.uwm120.bptr08      = 0
    sic_bran.uwm120.bptr09      = 0
    sic_bran.uwm120.class       = brsic_bran.uwm120.class
    sic_bran.uwm120.com1ae      = brsic_bran.uwm120.com1ae
    sic_bran.uwm120.com1p       = brsic_bran.uwm120.com1p
    sic_bran.uwm120.com1_r      = brsic_bran.uwm120.com1_r
    sic_bran.uwm120.com2ae      = brsic_bran.uwm120.com2ae
    sic_bran.uwm120.com2p       = brsic_bran.uwm120.com2p
    sic_bran.uwm120.com2_r      = brsic_bran.uwm120.com2_r
    sic_bran.uwm120.com3ae      = brsic_bran.uwm120.com3ae
    sic_bran.uwm120.com3p       = brsic_bran.uwm120.com3p
    sic_bran.uwm120.com3_r      = brsic_bran.uwm120.com3_r
    sic_bran.uwm120.com4ae      = brsic_bran.uwm120.com4ae
    sic_bran.uwm120.com4p       = brsic_bran.uwm120.com4p
    sic_bran.uwm120.com4_r      = brsic_bran.uwm120.com4_r
    sic_bran.uwm120.comco       = brsic_bran.uwm120.comco
    sic_bran.uwm120.comfac      = brsic_bran.uwm120.comfac
    sic_bran.uwm120.comqs       = brsic_bran.uwm120.comqs
    sic_bran.uwm120.comst       = brsic_bran.uwm120.comst
    sic_bran.uwm120.comtty      = brsic_bran.uwm120.comtty
    sic_bran.uwm120.dl1_r       = brsic_bran.uwm120.dl1_r
    sic_bran.uwm120.dl2_r       = brsic_bran.uwm120.dl2_r
    sic_bran.uwm120.dl3_r       = brsic_bran.uwm120.dl3_r
    sic_bran.uwm120.endcnt      = brsic_bran.uwm120.endcnt
    sic_bran.uwm120.feeae       = brsic_bran.uwm120.feeae
    sic_bran.uwm120.fptr01      = 0
    sic_bran.uwm120.fptr02      = 0
    sic_bran.uwm120.fptr03      = 0
    sic_bran.uwm120.fptr04      = 0
    sic_bran.uwm120.fptr08      = 0
    sic_bran.uwm120.fptr09      = 0
    sic_bran.uwm120.gap_r       = brsic_bran.uwm120.gap_r
    sic_bran.uwm120.pdco        = brsic_bran.uwm120.pdco
    sic_bran.uwm120.pdfac       = brsic_bran.uwm120.pdfac
    sic_bran.uwm120.pdqs        = brsic_bran.uwm120.pdqs
    sic_bran.uwm120.pdst        = brsic_bran.uwm120.pdst
    sic_bran.uwm120.pdtty       = brsic_bran.uwm120.pdtty
    sic_bran.uwm120.policy      = brsic_bran.uwm120.policy
    sic_bran.uwm120.prem_r      = brsic_bran.uwm120.prem_r
    sic_bran.uwm120.rencnt      = brsic_bran.uwm120.rencnt
    sic_bran.uwm120.rfee_r      = brsic_bran.uwm120.rfee_r
    sic_bran.uwm120.rilate      = brsic_bran.uwm120.rilate
    sic_bran.uwm120.riskgp      = brsic_bran.uwm120.riskgp
    sic_bran.uwm120.riskno      = brsic_bran.uwm120.riskno
    sic_bran.uwm120.rskdel      = brsic_bran.uwm120.rskdel
    sic_bran.uwm120.rstp_r      = brsic_bran.uwm120.rstp_r
    sic_bran.uwm120.rtax_r      = brsic_bran.uwm120.rtax_r
    sic_bran.uwm120.r_text      = brsic_bran.uwm120.r_text
    sic_bran.uwm120.sico        = brsic_bran.uwm120.sico
    sic_bran.uwm120.sicurr      = brsic_bran.uwm120.sicurr
    sic_bran.uwm120.siexch      = brsic_bran.uwm120.siexch
    sic_bran.uwm120.sifac       = brsic_bran.uwm120.sifac
    sic_bran.uwm120.sigr        = brsic_bran.uwm120.sigr
    sic_bran.uwm120.siqs        = brsic_bran.uwm120.siqs
    sic_bran.uwm120.sist        = brsic_bran.uwm120.sist
    sic_bran.uwm120.sitty       = brsic_bran.uwm120.sitty
    sic_bran.uwm120.stmpae      = brsic_bran.uwm120.stmpae
    sic_bran.uwm120.styp20      = brsic_bran.uwm120.styp20
    sic_bran.uwm120.sval20      = brsic_bran.uwm120.sval20
    sic_bran.uwm120.taxae       = brsic_bran.uwm120.taxae
    sic_bran.uwm120.bchyr       = nv_batchyr   
    sic_bran.uwm120.bchno       = nv_batchno   
    sic_bran.uwm120.bchcnt      = nv_batcnt .

  ASSIGN
    nv_com1p  = brsic_bran.uwm120.com1p
    nv_com1_t = brsic_bran.uwm120.com1_r.

  /* Risk Level Upper Text  uwd120*/
  nv_fptr = brsic_bran.uwm120.fptr01.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm120.fptr01 <> ? :
     FIND brsic_bran.uwd120 WHERE RECID(brsic_bran.uwd120) = nv_fptr
     NO-LOCK NO-ERROR.

     IF AVAILABLE brsic_bran.uwd120 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd120.fptr.
       CREATE sic_bran.uwd120.

       ASSIGN
         sic_bran.uwd120.bptr          = nv_bptr
         sic_bran.uwd120.endcnt        = brsic_bran.uwd120.endcnt
         sic_bran.uwd120.fptr          = 0
         sic_bran.uwd120.ltext         = brsic_bran.uwd120.ltext
         sic_bran.uwd120.policy        = brsic_bran.uwd120.policy
         sic_bran.uwd120.rencnt        = brsic_bran.uwd120.rencnt
         sic_bran.uwd120.riskgp        = brsic_bran.uwd120.riskgp
         sic_bran.uwd120.riskno        = brsic_bran.uwd120.riskno.
       IF nv_bptr <> 0 THEN DO:
          FIND wf_uwd120 WHERE RECID(wf_uwd120) = nv_bptr.
          wf_uwd120.fptr = RECID(sic_bran.uwd120).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr01 = RECID(sic_bran.uwd120).
       nv_bptr = RECID(sic_bran.uwd120).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd120.policy brsic_bran.uwd120.rencnt "/"
                brsic_bran.uwd120.endcnt "on file uwd120".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd120.policy +
                " R/E " + STRING(brsic_bran.uwd120.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd120.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd120.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd120.riskno,"999") +
                " on file uwd120 Risk Upper Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.

  END. /* End do nv_fptr */
  sic_bran.uwm120.bptr01 = nv_bptr.

  /* Risk Level Lower Text */
  nv_fptr = brsic_bran.uwm120.fptr02.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm120.fptr02 <> ? :
     FIND brsic_bran.uwd121 WHERE RECID(brsic_bran.uwd121) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd121 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd121.fptr.
       CREATE sic_bran.uwd121.

       ASSIGN
         sic_bran.uwd121.bptr          = nv_bptr
         sic_bran.uwd121.endcnt        = brsic_bran.uwd121.endcnt
         sic_bran.uwd121.fptr          = 0
         sic_bran.uwd121.ltext         = brsic_bran.uwd121.ltext
         sic_bran.uwd121.policy        = brsic_bran.uwd121.policy
         sic_bran.uwd121.rencnt        = brsic_bran.uwd121.rencnt
         sic_bran.uwd121.riskgp        = brsic_bran.uwd121.riskgp
         sic_bran.uwd121.riskno        = brsic_bran.uwd121.riskno.
       IF nv_bptr <> 0 THEN DO:
          FIND wf_uwd121 WHERE RECID(wf_uwd121) = nv_bptr.
          wf_uwd121.fptr = RECID(sic_bran.uwd121).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr02 = RECID(sic_bran.uwd121).
       nv_bptr = RECID(sic_bran.uwd121).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd121.policy brsic_bran.uwd121.rencnt "/"
                brsic_bran.uwd121.endcnt "on file uwd121".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd121.policy +
                " R/E " + STRING(brsic_bran.uwd121.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd121.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd121.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd121.riskno,"999") +
                " on file uwd121 Risk Lower Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm120.bptr02 = nv_bptr.

  /* Risk Level Bordereau Text */
  nv_fptr = brsic_bran.uwm120.fptr03.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm120.fptr03 <> ? :
     find brsic_bran.uwd123 WHERE RECID(brsic_bran.uwd123) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd123 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd123.fptr.
       CREATE sic_bran.uwd123.
          
       ASSIGN
         sic_bran.uwd123.bptr          = nv_bptr
         sic_bran.uwd123.endcnt        = brsic_bran.uwd123.endcnt
         sic_bran.uwd123.fptr          = 0
         sic_bran.uwd123.ltext         = brsic_bran.uwd123.ltext
         sic_bran.uwd123.policy        = brsic_bran.uwd123.policy
         sic_bran.uwd123.rencnt        = brsic_bran.uwd123.rencnt
         sic_bran.uwd123.riskgp        = brsic_bran.uwd123.riskgp
         sic_bran.uwd123.riskno        = brsic_bran.uwd123.riskno.
       IF nv_bptr <> 0 THEN DO:
         FIND wf_uwd123 WHERE RECID(wf_uwd123) = nv_bptr.
         wf_uwd123.fptr = RECID(sic_bran.uwd123).
       end.
       IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr03 = RECID(sic_bran.uwd123).
       nv_bptr = RECID(sic_bran.uwd123).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd123.policy brsic_bran.uwd123.rencnt "/"
                brsic_bran.uwd123.endcnt "on file uwd123".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd123.policy +
                " R/E " + STRING(brsic_bran.uwd123.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd123.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd123.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd123.riskno,"999") +
                " on file uwd123 Risk Bordereau Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm120.bptr03 = nv_bptr.

  /* Risk Level Clauses */
  nv_fptr = brsic_bran.uwm120.fptr04.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm120.fptr04 <> ? :
     FIND brsic_bran.uwd125 WHERE RECID(brsic_bran.uwd125) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd125 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd125.fptr.
       CREATE sic_bran.uwd125.

       ASSIGN
         sic_bran.uwd125.bptr          = nv_bptr
         sic_bran.uwd125.clause        = brsic_bran.uwd125.clause
         sic_bran.uwd125.endcnt        = brsic_bran.uwd125.endcnt
         sic_bran.uwd125.fptr          = 0
         sic_bran.uwd125.policy        = brsic_bran.uwd125.policy
         sic_bran.uwd125.rencnt        = brsic_bran.uwd125.rencnt
         sic_bran.uwd125.riskgp        = brsic_bran.uwd125.riskgp
         sic_bran.uwd125.riskno        = brsic_bran.uwd125.riskno.

       IF nv_bptr <> 0 THEN DO:
          FIND wf_uwd125 WHERE RECID(wf_uwd125) = nv_bptr.
          wf_uwd125.fptr = RECID(sic_bran.uwd125).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr03 = RECID(sic_bran.uwd125).
       nv_bptr = RECID(sic_bran.uwd125).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd125.policy brsic_bran.uwd125.rencnt "/"
                brsic_bran.uwd125.endcnt "on file uwd125".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd125.policy +
                " R/E " + STRING(brsic_bran.uwd125.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd125.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd125.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd125.riskno,"999") +
                " on file uwd125 Risk Clause".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm120.bptr04 = nv_bptr.

  /* Risk Level Endorsement Text */
  nv_fptr = brsic_bran.uwm120.fptr08.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm120.fptr08 <> ? :
     FIND brsic_bran.uwd124 WHERE RECID(brsic_bran.uwd124) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd124 THEN DO: /*sombat */
        nv_fptr = brsic_bran.uwd124.fptr.
        CREATE sic_bran.uwd124.

        ASSIGN
         sic_bran.uwd124.bptr          = nv_bptr
         sic_bran.uwd124.endcnt        = brsic_bran.uwd124.endcnt
         sic_bran.uwd124.fptr          = 0
         sic_bran.uwd124.ltext         = brsic_bran.uwd124.ltext
         sic_bran.uwd124.policy        = brsic_bran.uwd124.policy
         sic_bran.uwd124.rencnt        = brsic_bran.uwd124.rencnt
         sic_bran.uwd124.riskgp        = brsic_bran.uwd124.riskgp
         sic_bran.uwd124.riskno        = brsic_bran.uwd124.riskno.

       IF nv_bptr <> 0 THEN DO:
          FIND wf_uwd124 WHERE RECID(wf_uwd124) = nv_bptr.
          wf_uwd124.fptr = RECID(sic_bran.uwd124).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr08 = RECID(sic_bran.uwd124).
       nv_bptr = RECID(sic_bran.uwd124).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd124.policy brsic_bran.uwd124.rencnt "/"
                brsic_bran.uwd124.endcnt "on file uwd124".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd124.policy +
                " R/E " + STRING(brsic_bran.uwd124.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd124.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd124.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd124.riskno,"999") +
                " on file uwd124 Risk End. Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm120.bptr08 = nv_bptr.

  /* Risk level Endorsement Clauses */
  nv_fptr = brsic_bran.uwm120.fptr09.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND brsic_bran.uwm120.fptr09 <> ? :
     FIND brsic_bran.uwd126 WHERE RECID(brsic_bran.uwd126) = nv_fptr
     NO-LOCK NO-ERROR.
     IF AVAILABLE brsic_bran.uwd126 THEN DO: /*sombat */
       nv_fptr = brsic_bran.uwd126.fptr.
       CREATE sic_bran.uwd126.

       ASSIGN
         sic_bran.uwd126.bptr          = nv_bptr
         sic_bran.uwd126.endcls        = brsic_bran.uwd126.endcls
         sic_bran.uwd126.endcnt        = brsic_bran.uwd126.endcnt
         sic_bran.uwd126.fptr          = 0
         sic_bran.uwd126.policy        = brsic_bran.uwd126.policy
         sic_bran.uwd126.rencnt        = brsic_bran.uwd126.rencnt
         sic_bran.uwd126.riskgp        = brsic_bran.uwd126.riskgp
         sic_bran.uwd126.riskno        = brsic_bran.uwd126.riskno.

       IF nv_bptr <> 0 THEN DO:
         FIND wf_uwd126 WHERE RECID(wf_uwd126) = nv_bptr.
         wf_uwd126.fptr = RECID(sic_bran.uwd126).
       END.
       IF nv_bptr = 0 THEN  sic_bran.uwm120.fptr09 = RECID(sic_bran.uwd126).
       nv_bptr = RECID(sic_bran.uwd126).
     END.
     ELSE DO:    /*sombat*/
       HIDE MESSAGE NO-PAUSE.
       MESSAGE "not found " brsic_bran.uwd126.policy brsic_bran.uwd126.rencnt "/"
                brsic_bran.uwd126.endcnt "on file uwd126".
       putchr = "".
       putchr = "not found " + brsic_bran.uwd126.policy +
                " R/E " + STRING(brsic_bran.uwd126.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd126.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd126.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd126.riskno,"999") +
                " on file uwd126 Risk End. Clauses".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.

  END. /* End do nv_fptr */
  sic_bran.uwm120.bptr09 = nv_bptr.

END. /* IF AVAILABLE brsic_bran.uwm120 THEN DO: */

/* END OF : WGWTB120.P */
