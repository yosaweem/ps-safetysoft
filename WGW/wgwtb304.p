/* Transfer data from test to premium */
/* WGWTB304                             */
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
DEF VAR nv_sts  AS CHAR FORMAT "x(01)".
DEF STREAM str_inf.
DEF BUFFER wf_uwd140 FOR sic_bran.uwd140.
DEF BUFFER wf_uwd141 FOR sic_bran.uwd141.

DEF SHARED STREAM ns1.    /*sombat*/
DEF VAR putchr AS CHAR FORMAT "x(100)" INIT "" NO-UNDO.

HIDE MESSAGE NO-PAUSE.
/*message "Update uwm304 and Delete uwd140/141".*/
   /*
loop_for: 
    
FOR EACH brsic_bran.uwm304 WHERE
         brsic_bran.uwm304.policy = sh_policy AND
         brsic_bran.uwm304.rencnt = sh_rencnt AND
         brsic_bran.uwm304.endcnt = sh_endcnt
NO-LOCK:
    */

FIND FIRST brsic_bran.uwm304 WHERE
           brsic_bran.uwm304.policy = sh_policy AND
           brsic_bran.uwm304.rencnt = sh_rencnt AND
           brsic_bran.uwm304.endcnt = sh_endcnt NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE brsic_bran.uwm304 THEN DO:

  FIND sic_bran.uwm304 WHERE 
       sic_bran.uwm304.policy = brsic_bran.uwm304.policy and
       sic_bran.uwm304.rencnt = brsic_bran.uwm304.rencnt and
       sic_bran.uwm304.endcnt = brsic_bran.uwm304.endcnt and
       sic_bran.uwm304.riskgp = brsic_bran.uwm304.riskgp and
       sic_bran.uwm304.riskno = brsic_bran.uwm304.riskno AND
       sic_bran.uwm304.bchyr  = nv_batchyr               AND
       sic_bran.uwm304.bchno  = nv_batchno               AND
       sic_bran.uwm304.bchcnt = nv_batcnt 
  NO-ERROR.
  nv_sts = "N".
  /*IF AVAILABLE sic_bran.uwm304 THEN NEXT loop_for. */
  IF NOT AVAILABLE sic_bran.uwm304
  THEN DO:
      CREATE sic_bran.uwm304.
  END.

/*delete uwd140 */
  nv_fptr = sic_bran.uwm304.fptr01.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm304.fptr01 <> ? :
     FIND sic_bran.uwd140 WHERE RECID(sic_bran.uwd140) = nv_fptr
         NO-ERROR.
     IF AVAILABLE sic_bran.uwd140 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd140.fptr.
        IF sic_bran.uwd140.policy = brsic_bran.uwm304.policy AND
           sic_bran.uwd140.rencnt = brsic_bran.uwm304.rencnt AND
           sic_bran.uwd140.endcnt = brsic_bran.uwm304.endcnt THEN DO:
           DELETE sic_bran.uwd140.
         END.
         ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

/*delete uwd141 */
  nv_fptr = sic_bran.uwm304.fptr02.
  DO WHILE nv_fptr <> 0 AND sic_bran.uwm304.fptr02 <> ? :
     FIND sic_bran.uwd141 WHERE RECID(sic_bran.uwd141) = nv_fptr
         NO-ERROR.
     IF AVAILABLE sic_bran.uwd141 THEN DO: /*sombat */
        nv_fptr = sic_bran.uwd141.fptr.
        IF sic_bran.uwd141.policy = brsic_bran.uwm304.policy AND
           sic_bran.uwd141.rencnt = brsic_bran.uwm304.rencnt AND
           sic_bran.uwd141.endcnt = brsic_bran.uwm304.endcnt THEN DO:
           DELETE sic_bran.uwd141.
         END.
         ELSE  nv_fptr = 0.
     END.
     ELSE      nv_fptr = 0.
  END.

/*Update Data*/
  ASSIGN
     sic_bran.uwm304.area          = brsic_bran.uwm304.area
     sic_bran.uwm304.beam          = brsic_bran.uwm304.beam
     sic_bran.uwm304.bptr01        = 0
     sic_bran.uwm304.bptr02        = 0
     sic_bran.uwm304.clatch        = brsic_bran.uwm304.clatch
     sic_bran.uwm304.constr        = brsic_bran.uwm304.constr
     sic_bran.uwm304.distct        = brsic_bran.uwm304.distct
     sic_bran.uwm304.endcnt        = brsic_bran.uwm304.endcnt
     sic_bran.uwm304.floor         = brsic_bran.uwm304.floor
     sic_bran.uwm304.fptr01        = 0
     sic_bran.uwm304.fptr02        = 0
     sic_bran.uwm304.front         = brsic_bran.uwm304.front
     sic_bran.uwm304.left          = brsic_bran.uwm304.left
     sic_bran.uwm304.locn1         = brsic_bran.uwm304.locn1
     sic_bran.uwm304.locn2         = brsic_bran.uwm304.locn2
     sic_bran.uwm304.locn3         = brsic_bran.uwm304.locn3
     sic_bran.uwm304.nohong        = brsic_bran.uwm304.nohong
     sic_bran.uwm304.occlim        = brsic_bran.uwm304.occlim
     sic_bran.uwm304.occupn        = brsic_bran.uwm304.occupn
     sic_bran.uwm304.occupy        = brsic_bran.uwm304.occupy
     sic_bran.uwm304.ownten        = brsic_bran.uwm304.ownten
     sic_bran.uwm304.planno        = brsic_bran.uwm304.planno
     sic_bran.uwm304.policy        = brsic_bran.uwm304.policy
     sic_bran.uwm304.prevloc       = brsic_bran.uwm304.prevloc
     sic_bran.uwm304.rear          = brsic_bran.uwm304.rear
     sic_bran.uwm304.rencnt        = brsic_bran.uwm304.rencnt
     sic_bran.uwm304.right         = brsic_bran.uwm304.right
     sic_bran.uwm304.riskgp        = brsic_bran.uwm304.riskgp
     sic_bran.uwm304.riskno        = brsic_bran.uwm304.riskno
     sic_bran.uwm304.roof          = brsic_bran.uwm304.roof
     sic_bran.uwm304.storey        = brsic_bran.uwm304.storey
     sic_bran.uwm304.wall          = brsic_bran.uwm304.wall
     sic_bran.uwm304.bchyr         = nv_batchyr 
     sic_bran.uwm304.bchno         = nv_batchno       
     sic_bran.uwm304.bchcnt        = nv_batcnt.
/* End Update uwm304 */

/* Fire Risk Location Text */
  nv_fptr = brsic_bran.uwm304.fptr01.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND nv_sts = "N" AND brsic_bran.uwm304.fptr01 <> ?:
     FIND brsic_bran.uwd140 WHERE RECID(brsic_bran.uwd140) = nv_fptr
     NO-LOCK NO-ERROR.
     IF NOT AVAILABLE brsic_bran.uwd140 THEN DO: /*sombat */
        HIDE MESSAGE NO-PAUSE.
        MESSAGE "not found " brsic_bran.uwd140.policy brsic_bran.uwd140.rencnt "/"
                brsic_bran.uwd140.endcnt "on file uwd140".
        putchr = "".
        putchr = "not found " + brsic_bran.uwd140.policy +
                " R/E " + STRING(brsic_bran.uwd140.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd140.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd140.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd140.riskno,"999") +
                " on file uwd140 Fire Risk Location Text".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.

     nv_fptr = brsic_bran.uwd140.fptr.
     CREATE sic_bran.uwd140.

     ASSIGN
     sic_bran.uwd140.bptr          = nv_bptr
     sic_bran.uwd140.endcnt        = brsic_bran.uwd140.endcnt
     sic_bran.uwd140.fptr          = 0
     sic_bran.uwd140.ltext         = brsic_bran.uwd140.ltext
     sic_bran.uwd140.policy        = brsic_bran.uwd140.policy
     sic_bran.uwd140.rencnt        = brsic_bran.uwd140.rencnt
     sic_bran.uwd140.riskgp        = brsic_bran.uwd140.riskgp
     sic_bran.uwd140.riskno        = brsic_bran.uwd140.riskno.
     IF nv_bptr <> 0 THEN DO:
        FIND wf_uwd140 WHERE RECID(wf_uwd140) = nv_bptr.
        wf_uwd140.fptr = RECID(sic_bran.uwd140).
     END.
     IF nv_bptr = 0 THEN  sic_bran.uwm304.fptr01 = RECID(sic_bran.uwd140).
     nv_bptr = RECID(sic_bran.uwd140).
  END. /* End do nv_fptr */
  sic_bran.uwm304.bptr01 = nv_bptr.

/* Fire Risk Block Numbers */
  nv_fptr = brsic_bran.uwm304.fptr02.
  nv_bptr = 0.
  DO WHILE nv_fptr <> 0 AND nv_sts = "N" AND brsic_bran.uwm304.fptr02 <> ?:
     FIND brsic_bran.uwd141 WHERE RECID(brsic_bran.uwd141) = nv_fptr
     NO-LOCK NO-ERROR.
     IF NOT AVAILABLE brsic_bran.uwd141 THEN DO: /*sombat */
        HIDE MESSAGE NO-PAUSE.
        MESSAGE "not found " brsic_bran.uwd141.policy brsic_bran.uwd141.rencnt "/"
                brsic_bran.uwd141.endcnt "on file uwd141".
        putchr = "".
        putchr = "not found " + brsic_bran.uwd141.policy +
                " R/E " + STRING(brsic_bran.uwd141.rencnt,"99")  +
                "/"     + STRING(brsic_bran.uwd141.endcnt,"999") +
                " Riskgp/Riskno " + STRING(brsic_bran.uwd141.riskgp,"99") +
                "/"               + STRING(brsic_bran.uwd141.riskno,"999") +
                " on file uwd141 Fire Risk Block Numbers".
       PUT STREAM ns1 putchr FORMAT "x(100)" SKIP.
       LEAVE.
     END.
     nv_fptr = brsic_bran.uwd141.fptr.
     CREATE sic_bran.uwd141.

     ASSIGN
     sic_bran.uwd141.blok_n        = brsic_bran.uwd141.blok_n
     sic_bran.uwd141.bptr          = nv_bptr
     sic_bran.uwd141.dist_n        = brsic_bran.uwd141.dist_n
     sic_bran.uwd141.endcnt        = brsic_bran.uwd141.endcnt
     sic_bran.uwd141.fptr          = 0
     sic_bran.uwd141.policy        = brsic_bran.uwd141.policy
     sic_bran.uwd141.prov_n        = brsic_bran.uwd141.prov_n
     sic_bran.uwd141.rencnt        = brsic_bran.uwd141.rencnt
     sic_bran.uwd141.riskgp        = brsic_bran.uwd141.riskgp
     sic_bran.uwd141.riskno        = brsic_bran.uwd141.riskno
     sic_bran.uwd141.sblok_n       = brsic_bran.uwd141.sblok_n
     sic_bran.uwd141.bchyr         = nv_batchyr   
     sic_bran.uwd141.bchno         = nv_batchno 
     sic_bran.uwd141.bchcnt        = nv_batcnt.

     IF nv_bptr <> 0 THEN DO:
        FIND wf_uwd141 WHERE RECID(wf_uwd141) = nv_bptr.
        wf_uwd141.fptr = RECID(sic_bran.uwd141).
     END.
     IF nv_bptr = 0 THEN  sic_bran.uwm304.fptr02 = RECID(sic_bran.uwd141).
     nv_bptr = RECID(sic_bran.uwd141).

     IF brsic_bran.uwd141.prov_n <> "" THEN DO:
       FIND FIRST sic_bran.uwm500 WHERE
                  sic_bran.uwm500.prov_n = brsic_bran.uwd141.prov_n
       NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sic_bran.uwm500 THEN DO:
         HIDE MESSAGE NO-PAUSE.

         FIND FIRST brsic_bran.uwm500 WHERE
                    brsic_bran.uwm500.prov_n = brsic_bran.uwd141.prov_n
         NO-LOCK NO-ERROR.
         IF AVAILABLE brsic_bran.uwm500 THEN DO:
           MESSAGE "CREATE : Province No." brsic_bran.uwd141.prov_n.

           CREATE sic_bran.uwm500.

           ASSIGN
           sic_bran.uwm500.prov_n = brsic_bran.uwm500.prov_n  /* Province No.  */
           sic_bran.uwm500.prov_d = brsic_bran.uwm500.prov_d. /* Province Name */
         END.
       END.
     END.

     IF brsic_bran.uwd141.dist_n <> "" THEN DO:
       FIND FIRST sic_bran.uwm501 WHERE
                  sic_bran.uwm501.prov_n = brsic_bran.uwd141.prov_n AND
                  sic_bran.uwm501.dist_n = brsic_bran.uwd141.dist_n
       NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sic_bran.uwm501 THEN DO:
         HIDE MESSAGE NO-PAUSE.

         FIND FIRST brsic_bran.uwm501 WHERE
                    brsic_bran.uwm501.prov_n = brsic_bran.uwd141.prov_n AND
                    brsic_bran.uwm501.dist_n = brsic_bran.uwd141.dist_n
         NO-LOCK NO-ERROR.
         IF NOT AVAILABLE brsic_bran.uwm501 THEN DO:
           MESSAGE "CREATE :" brsic_bran.uwd141.prov_n
                              brsic_bran.uwd141.dist_n.

           CREATE sic_bran.uwm501.

           ASSIGN
           sic_bran.uwm501.prov_n = brsic_bran.uwm501.prov_n  /*Province No. */
           sic_bran.uwm501.dist_n = brsic_bran.uwm501.dist_n  /*District No. */
           sic_bran.uwm501.dist_d = brsic_bran.uwm501.dist_d. /*District Name*/
         END.
       END.
     END.

     IF brsic_bran.uwd141.blok_n <> "" THEN DO:
       FIND FIRST sic_bran.uwm502 WHERE
                  sic_bran.uwm502.prov_n  = brsic_bran.uwd141.prov_n  AND
                  sic_bran.uwm502.dist_n  = brsic_bran.uwd141.dist_n  AND
                  sic_bran.uwm502.blok_n  = brsic_bran.uwd141.blok_n  AND
                  sic_bran.uwm502.sblok_n = brsic_bran.uwd141.sblok_n
       NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sic_bran.uwm502 THEN DO:
         HIDE MESSAGE NO-PAUSE.
         FIND FIRST brsic_bran.uwm502 WHERE
                    brsic_bran.uwm502.prov_n  = brsic_bran.uwd141.prov_n  AND
                    brsic_bran.uwm502.dist_n  = brsic_bran.uwd141.dist_n  AND
                    brsic_bran.uwm502.blok_n  = brsic_bran.uwd141.blok_n  AND
                    brsic_bran.uwm502.sblok_n = brsic_bran.uwd141.sblok_n
         NO-LOCK NO-ERROR.
         IF NOT AVAILABLE sic_bran.uwm502 THEN DO:
           MESSAGE "CREATE :" brsic_bran.uwd141.prov_n
                              brsic_bran.uwd141.dist_n
                              brsic_bran.uwd141.blok_n
                              brsic_bran.uwd141.sblok_n.

           CREATE sic_bran.uwm502.

           ASSIGN
           sic_bran.uwm502.prov_n    = brsic_bran.uwm502.prov_n   /*  Province No.              */
           sic_bran.uwm502.dist_n    = brsic_bran.uwm502.dist_n   /*  District No.              */
           sic_bran.uwm502.blok_n    = brsic_bran.uwm502.blok_n   /*  Block No.                 */
           sic_bran.uwm502.blok_s    = brsic_bran.uwm502.blok_s   /*  Block Situation           */
           sic_bran.uwm502.blok_d    = brsic_bran.uwm502.blok_d   /*  Block Details             */
           sic_bran.uwm502.occlim    = brsic_bran.uwm502.occlim   /*  Occupation Class Limit Cod*/
           sic_bran.uwm502.constr    = brsic_bran.uwm502.constr   /*  Construction Class Code   */
           sic_bran.uwm502.distct    = brsic_bran.uwm502.distct   /*  District Class Code       */
           sic_bran.uwm502.sblok_n   = brsic_bran.uwm502.sblok_n  /*  Sub Block                 */
           sic_bran.uwm502.sigr      = brsic_bran.uwm502.sigr     /*  Sum Insured Gross         */
           sic_bran.uwm502.siret     = brsic_bran.uwm502.siret    /*  SI Retention              */
           sic_bran.uwm502.sibret    = brsic_bran.uwm502.sibret   /*  SI Retention, Balance     */
           sic_bran.uwm502.sistat    = brsic_bran.uwm502.sistat   /*  SI Statutory              */
           sic_bran.uwm502.sitty1    = brsic_bran.uwm502.sitty1   /*  SI Treaty, 1st surplus    */
           sic_bran.uwm502.sitty2    = brsic_bran.uwm502.sitty2   /*  SI Treaty, 2nd surplus    */
           sic_bran.uwm502.sifacl    = brsic_bran.uwm502.sifacl   /*  SI Facultative, Local     */
           sic_bran.uwm502.sifacf    = brsic_bran.uwm502.sifacf   /*  SI Facultative, Foreign   */
           sic_bran.uwm502.siquota   = brsic_bran.uwm502.siquota  /*  SI Quota share (T.F.P.)   */
           sic_bran.uwm502.sioth     = brsic_bran.uwm502.sioth    /*  SI Other                  */
           sic_bran.uwm502.simax     = brsic_bran.uwm502.simax .  /*  SI Max/Block              */
         /*sic_bran.uwm502.blkdat    = brsic_bran.uwm502.blkdat . /*  Blockdate                 */
         */
         END.
       END.
     END.
  END. /* End do nv_fptr */
  sic_bran.uwm304.bptr02 = nv_bptr.

END. /* IF AVAILABLE brsic_bran.uwm304 THEN DO: */

/* END OF : WGWTB304.P */
