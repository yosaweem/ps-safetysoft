/*=================================================================*/
/* Program Name :  Transfer Data   GW to Premium                   */
/* CREATE  By   : Chaiyong W. A58-0123 24/04/2015                  */
/*                Transfer Data   GW to Premium                    */
/* Dup Program Transfer                                            */ 
/* Modify by Sarinya c. A60-0295  ปรับ Loopเพื่อนำงาน Motor Add On เข้าระบบ */  
/*Modify by  : Kridtiya i. A65-00145 Date.29/05/2022 เพิ่ม ฟิล์  sdist_n    */     
/* Modify by : Songkran P. & Tontawan S. A65-0141 28/11/2022 add field      */                                           
/*=================================================================*/
DEF INPUT PARAMETER nv_bchyr  AS INT.
DEF INPUT PARAMETER nv_bchno  AS CHAR.
DEF INPUT PARAMETER nv_bchcnt AS INT.
DEF INPUT PARAMETER nv_policy AS CHAR.
DEF INPUT PARAMETER nv_rencnt AS INT.
DEF INPUT PARAMETER nv_endcnt AS INT.

def var nv_int as int.
def var nv_fptr as recid.
def var nv_bptr as recid.
def var nv_sts as char format "x(01)".
def stream str_inf.
def buffer wf_uwd140 for sicuw.uwd140.
def buffer wf_uwd141 for sicuw.uwd141.

def shared stream ns1.    /*sombat*/
def var putchr as char format "x(100)" init "" no-undo.


loop_for:
for each sic_bran.uwm304 where
                     sic_bran.uwm304.policy =  nv_policy and
                     sic_bran.uwm304.rencnt =  nv_rencnt and
                     sic_bran.uwm304.endcnt =  nv_endcnt AND
                     sic_bran.uwm304.bchyr   = nv_bchyr  AND
                     sic_bran.uwm304.bchno   = nv_bchno  AND
                     sic_bran.uwm304.bchcnt  = nv_bchcnt no-lock:
  find sicuw.uwm304 where sicuw.uwm304.policy = sic_bran.uwm304.policy and
                         sicuw.uwm304.rencnt = sic_bran.uwm304.rencnt and
                         sicuw.uwm304.endcnt = sic_bran.uwm304.endcnt and
                         sicuw.uwm304.riskgp = sic_bran.uwm304.riskgp and
                         sicuw.uwm304.riskno = sic_bran.uwm304.riskno
                         no-error.
  nv_sts = "N".
  if available sicuw.uwm304 then next loop_for.
  if not available sicuw.uwm304
  then do:
     create sicuw.uwm304.
  end.

/*delete uwd140 */
  nv_fptr = sicuw.uwm304.fptr01.
  do while nv_fptr <> 0 and sicuw.uwm304.fptr01 <> ? :
     find sicuw.uwd140 where recid(sicuw.uwd140) = nv_fptr
         no-error.
     if available sicuw.uwd140 then do: /*sombat */
        nv_fptr = sicuw.uwd140.fptr.
        if sicuw.uwd140.policy = sic_bran.uwm304.policy and
           sicuw.uwd140.rencnt = sic_bran.uwm304.rencnt and
           sicuw.uwd140.endcnt = sic_bran.uwm304.endcnt then do:
           delete sicuw.uwd140.
         end.
         else  nv_fptr = 0.
     end.
     else      nv_fptr = 0.
  end.

/*delete uwd141 */
  nv_fptr = sicuw.uwm304.fptr02.
  do while nv_fptr <> 0 and sicuw.uwm304.fptr02 <> ? :
     find sicuw.uwd141 where recid(sicuw.uwd141) = nv_fptr
         no-error.
     if available sicuw.uwd141 then do: /*sombat */
        nv_fptr = sicuw.uwd141.fptr.
        if sicuw.uwd141.policy = sic_bran.uwm304.policy and
           sicuw.uwd141.rencnt = sic_bran.uwm304.rencnt and
           sicuw.uwd141.endcnt = sic_bran.uwm304.endcnt then do:
           delete sicuw.uwd141.
         end.
         else  nv_fptr = 0.
     end.
     else      nv_fptr = 0.
  end.

/*Update Data*/
  assign
     sicuw.uwm304.area          = sic_bran.uwm304.area
     sicuw.uwm304.beam          = sic_bran.uwm304.beam
     sicuw.uwm304.bptr01        = 0
     sicuw.uwm304.bptr02        = 0
     sicuw.uwm304.clatch        = sic_bran.uwm304.clatch
     sicuw.uwm304.constr        = sic_bran.uwm304.constr
     sicuw.uwm304.distct        = sic_bran.uwm304.distct
     sicuw.uwm304.endcnt        = sic_bran.uwm304.endcnt
     sicuw.uwm304.floor         = sic_bran.uwm304.floor
     sicuw.uwm304.fptr01        = 0
     sicuw.uwm304.fptr02        = 0
     sicuw.uwm304.front         = sic_bran.uwm304.front
     sicuw.uwm304.left          = sic_bran.uwm304.left
     sicuw.uwm304.locn1         = sic_bran.uwm304.locn1
     sicuw.uwm304.locn2         = sic_bran.uwm304.locn2
     sicuw.uwm304.locn3         = sic_bran.uwm304.locn3
     sicuw.uwm304.nohong        = sic_bran.uwm304.nohong
     sicuw.uwm304.occlim        = sic_bran.uwm304.occlim
     sicuw.uwm304.occupn        = sic_bran.uwm304.occupn
     sicuw.uwm304.occupy        = sic_bran.uwm304.occupy
     sicuw.uwm304.ownten        = sic_bran.uwm304.ownten
     sicuw.uwm304.planno        = sic_bran.uwm304.planno
     sicuw.uwm304.policy        = sic_bran.uwm304.policy
     sicuw.uwm304.prevloc       = sic_bran.uwm304.prevloc
     sicuw.uwm304.rear          = sic_bran.uwm304.rear
     sicuw.uwm304.rencnt        = sic_bran.uwm304.rencnt
     sicuw.uwm304.right         = sic_bran.uwm304.right
     sicuw.uwm304.riskgp        = sic_bran.uwm304.riskgp
     sicuw.uwm304.riskno        = sic_bran.uwm304.riskno
     sicuw.uwm304.roof          = sic_bran.uwm304.roof
     sicuw.uwm304.storey        = sic_bran.uwm304.storey
     sicuw.uwm304.wall          = sic_bran.uwm304.wall.
/* End Update uwm304 */
  /*--Begin A65-0141 28/11/2022*/
  ASSIGN
    sicuw.uwm304.pcrisk          = sic_bran.uwm304.pcrisk         
    sicuw.uwm304.postcd          = sic_bran.uwm304.postcd             
    sicuw.uwm304.lattitude       = sic_bran.uwm304.lattitude          
    sicuw.uwm304.longitude       = sic_bran.uwm304.longitude          
    sicuw.uwm304.precode         = sic_bran.uwm304.precode            
    sicuw.uwm304.estcode         = sic_bran.uwm304.estcode            
    sicuw.uwm304.note1           = sic_bran.uwm304.note1              
    sicuw.uwm304.note2           = sic_bran.uwm304.note2              
    sicuw.uwm304.note3           = sic_bran.uwm304.note3              
    sicuw.uwm304.certified       = sic_bran.uwm304.certified          
    sicuw.uwm304.memcode         = sic_bran.uwm304.memcode            
    sicuw.uwm304.chr1            = sic_bran.uwm304.chr1               
    sicuw.uwm304.chr2            = sic_bran.uwm304.chr2               
    sicuw.uwm304.chr3            = sic_bran.uwm304.chr3               
    sicuw.uwm304.chr4            = sic_bran.uwm304.chr4               
    sicuw.uwm304.chr5            = sic_bran.uwm304.chr5               
    sicuw.uwm304.date1           = sic_bran.uwm304.date1              
    sicuw.uwm304.date2           = sic_bran.uwm304.date2              
    sicuw.uwm304.dec1            = sic_bran.uwm304.dec1               
    sicuw.uwm304.dec2            = sic_bran.uwm304.dec2               
    sicuw.uwm304.int1            = sic_bran.uwm304.int1               
    sicuw.uwm304.int2            = sic_bran.uwm304.int2               
    sicuw.uwm304.covcod          = sic_bran.uwm304.covcod             
    sicuw.uwm304.modcod          = sic_bran.uwm304.modcod             
    sicuw.uwm304.makdes          = sic_bran.uwm304.makdes             
    sicuw.uwm304.moddes          = sic_bran.uwm304.moddes             
    sicuw.uwm304.body            = sic_bran.uwm304.body               
    sicuw.uwm304.engine          = sic_bran.uwm304.engine             
    sicuw.uwm304.tons            = sic_bran.uwm304.tons               
    sicuw.uwm304.seats           = sic_bran.uwm304.seats              
    sicuw.uwm304.watts           = sic_bran.uwm304.watts              
    sicuw.uwm304.yrmanu          = sic_bran.uwm304.yrmanu             
    sicuw.uwm304.vehgrp          = sic_bran.uwm304.vehgrp             
    sicuw.uwm304.vehreg          = sic_bran.uwm304.vehreg             
    sicuw.uwm304.vehuse          = sic_bran.uwm304.vehuse             
    sicuw.uwm304.eng_no          = sic_bran.uwm304.eng_no             
    sicuw.uwm304.cha_no          = sic_bran.uwm304.cha_no             
    sicuw.uwm304.trareg          = sic_bran.uwm304.trareg             
    sicuw.uwm304.garage          = sic_bran.uwm304.garage             
    sicuw.uwm304.car_reg         = sic_bran.uwm304.car_reg            
    sicuw.uwm304.province_reg    = sic_bran.uwm304.province_reg       
    sicuw.uwm304.car_year        = sic_bran.uwm304.car_year           
    sicuw.uwm304.car_color       = sic_bran.uwm304.car_color          
    sicuw.uwm304.sclass          = sic_bran.uwm304.sclass             
    sicuw.uwm304.packcd          = sic_bran.uwm304.packcd             
    sicuw.uwm304.polmot          = sic_bran.uwm304.polmot             
    sicuw.uwm304.cdate           = sic_bran.uwm304.cdate              
    sicuw.uwm304.edate           = sic_bran.uwm304.edate              
    sicuw.uwm304.sumins          = sic_bran.uwm304.sumins             
    sicuw.uwm304.mktvalue        = sic_bran.uwm304.mktvalue           
    sicuw.uwm304.tertor          = sic_bran.uwm304.tertor             
    sicuw.uwm304.grade           = sic_bran.uwm304.grade              
    sicuw.uwm304.manfwat         = sic_bran.uwm304.manfwat            
    sicuw.uwm304.indemprd        = sic_bran.uwm304.indemprd           
    sicuw.uwm304.serialno        = sic_bran.uwm304.serialno           
    sicuw.uwm304.typeapp         = sic_bran.uwm304.typeapp            
    sicuw.uwm304.perdwarr        = sic_bran.uwm304.perdwarr    .      
  /*End A65-0141 28/11/2022----*/

/* Fire Risk Location Text */
  nv_fptr = sic_bran.uwm304.fptr01.
  nv_bptr = 0.
  do while nv_fptr <> 0 and nv_sts = "N" and sic_bran.uwm304.fptr01 <> ?:
     find sic_bran.uwd140 where recid(sic_bran.uwd140) = nv_fptr
     no-lock no-error.
     if not available sic_bran.uwd140 then do: /*sombat */
        leave.
     end.

     nv_fptr = sic_bran.uwd140.fptr.
     create sicuw.uwd140.

     assign
     sicuw.uwd140.bptr          = nv_bptr
     sicuw.uwd140.endcnt        = sic_bran.uwd140.endcnt
     sicuw.uwd140.fptr          = 0
     sicuw.uwd140.ltext         = sic_bran.uwd140.ltext
     sicuw.uwd140.policy        = sic_bran.uwd140.policy
     sicuw.uwd140.rencnt        = sic_bran.uwd140.rencnt
     sicuw.uwd140.riskgp        = sic_bran.uwd140.riskgp
     sicuw.uwd140.riskno        = sic_bran.uwd140.riskno.
     if nv_bptr <> 0 then do:
       find wf_uwd140 where recid(wf_uwd140) = nv_bptr.
       wf_uwd140.fptr = recid(sicuw.uwd140).
     end.
     if nv_bptr = 0 then  sicuw.uwm304.fptr01 = recid(sicuw.uwd140).
     nv_bptr = recid(sicuw.uwd140).
  end. /* End do nv_fptr */
  sicuw.uwm304.bptr01 = nv_bptr.

/* Fire Risk Block Numbers */
  nv_fptr = sic_bran.uwm304.fptr02.
  nv_bptr = 0.
  do while nv_fptr <> 0 and nv_sts = "N" and sic_bran.uwm304.fptr02 <> ?:
     find sic_bran.uwd141 where recid(sic_bran.uwd141) = nv_fptr
     no-lock no-error.
     if not available sic_bran.uwd141 then do: /*sombat */
        leave.
     end.
     nv_fptr = sic_bran.uwd141.fptr.
     create sicuw.uwd141.

     assign
     sicuw.uwd141.blok_n        = sic_bran.uwd141.blok_n
     sicuw.uwd141.bptr          = nv_bptr
     sicuw.uwd141.dist_n        = sic_bran.uwd141.dist_n
     sicuw.uwd141.endcnt        = sic_bran.uwd141.endcnt
     sicuw.uwd141.fptr          = 0
     sicuw.uwd141.policy        = sic_bran.uwd141.policy
     sicuw.uwd141.prov_n        = sic_bran.uwd141.prov_n
     sicuw.uwd141.rencnt        = sic_bran.uwd141.rencnt
     sicuw.uwd141.riskgp        = sic_bran.uwd141.riskgp
     sicuw.uwd141.riskno        = sic_bran.uwd141.riskno
     sicuw.uwd141.sblok_n       = sic_bran.uwd141.sblok_n
     sicuw.uwd141.sdist_n       = sic_bran.uwd141.sdist_n .  /*A65-00145*/

     if nv_bptr <> 0 then do:
       find wf_uwd141 where recid(wf_uwd141) = nv_bptr.
       wf_uwd141.fptr = recid(sicuw.uwd141).
     end.
     if nv_bptr = 0 then  sicuw.uwm304.fptr02 = recid(sicuw.uwd141).
     nv_bptr = recid(sicuw.uwd141).

     IF sic_bran.uwd141.prov_n <> "" THEN DO:
       FIND FIRST sicuw.uwm500 WHERE
                  sicuw.uwm500.prov_n = sic_bran.uwd141.prov_n
       NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sicuw.uwm500 THEN DO:
         HIDE MESSAGE NO-PAUSE.

         FIND FIRST sic_bran.uwm500 WHERE
                    sic_bran.uwm500.prov_n = sic_bran.uwd141.prov_n
         NO-LOCK NO-ERROR.
         IF AVAILABLE sic_bran.uwm500 THEN DO:
           
           CREATE sicuw.uwm500.

           ASSIGN
           sicuw.uwm500.prov_n = sic_bran.uwm500.prov_n  /* Province No.  */
           sicuw.uwm500.prov_d = sic_bran.uwm500.prov_d. /* Province Name */
         END.
       END.
     END.

     IF sic_bran.uwd141.dist_n <> "" THEN DO:
       FIND FIRST sicuw.uwm501 WHERE
                  sicuw.uwm501.prov_n = sic_bran.uwd141.prov_n AND
                  sicuw.uwm501.dist_n = sic_bran.uwd141.dist_n
       NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sicuw.uwm501 THEN DO:
         HIDE MESSAGE NO-PAUSE.

         FIND FIRST sic_bran.uwm501 WHERE
                    sic_bran.uwm501.prov_n = sic_bran.uwd141.prov_n AND
                    sic_bran.uwm501.dist_n = sic_bran.uwd141.dist_n
         NO-LOCK NO-ERROR.
         /*IF NOT AVAILABLE sic_bran.uwm501 THEN DO:*/  /*Comment By Sarinya C. A60-0295   */
         IF AVAILABLE sic_bran.uwm501 THEN DO:          /*Add By Sarinya C. A60-0295 ปรับ Loopเพื่อนำงาน Motor Add On เข้าระบบ  */
           CREATE sicuw.uwm501.

           ASSIGN
           sicuw.uwm501.prov_n = sic_bran.uwm501.prov_n  /*Province No. */
           sicuw.uwm501.dist_n = sic_bran.uwm501.dist_n  /*District No. */
           sicuw.uwm501.dist_d = sic_bran.uwm501.dist_d. /*District Name*/
         END.
       END.
     END.

     IF sic_bran.uwd141.blok_n <> "" THEN DO:
       FIND FIRST sicuw.uwm502 WHERE
                  sicuw.uwm502.prov_n  = sic_bran.uwd141.prov_n  AND
                  sicuw.uwm502.dist_n  = sic_bran.uwd141.dist_n  AND
                  sicuw.uwm502.blok_n  = sic_bran.uwd141.blok_n  AND
                  sicuw.uwm502.sblok_n = sic_bran.uwd141.sblok_n
       NO-LOCK NO-ERROR.
       IF NOT AVAILABLE sicuw.uwm502 THEN DO:
         HIDE MESSAGE NO-PAUSE.
         FIND FIRST sic_bran.uwm502 WHERE
                    sic_bran.uwm502.prov_n  = sic_bran.uwd141.prov_n  AND
                    sic_bran.uwm502.dist_n  = sic_bran.uwd141.dist_n  AND
                    sic_bran.uwm502.blok_n  = sic_bran.uwd141.blok_n  AND
                    sic_bran.uwm502.sblok_n = sic_bran.uwd141.sblok_n
         NO-LOCK NO-ERROR.
         IF NOT AVAILABLE sicuw.uwm502 THEN DO:

           CREATE sicuw.uwm502.

           ASSIGN
           sicuw.uwm502.prov_n    = sic_bran.uwm502.prov_n   /*  Province No.              */
           sicuw.uwm502.dist_n    = sic_bran.uwm502.dist_n   /*  District No.              */
           sicuw.uwm502.blok_n    = sic_bran.uwm502.blok_n   /*  Block No.                 */
           sicuw.uwm502.blok_s    = sic_bran.uwm502.blok_s   /*  Block Situation           */
           sicuw.uwm502.blok_d    = sic_bran.uwm502.blok_d   /*  Block Details             */
           sicuw.uwm502.occlim    = sic_bran.uwm502.occlim   /*  Occupation Class Limit Cod*/
           sicuw.uwm502.constr    = sic_bran.uwm502.constr   /*  Construction Class Code   */
           sicuw.uwm502.distct    = sic_bran.uwm502.distct   /*  District Class Code       */
           sicuw.uwm502.sblok_n   = sic_bran.uwm502.sblok_n  /*  Sub Block                 */
           sicuw.uwm502.sigr      = sic_bran.uwm502.sigr     /*  Sum Insured Gross         */
           sicuw.uwm502.siret     = sic_bran.uwm502.siret    /*  SI Retention              */
           sicuw.uwm502.sibret    = sic_bran.uwm502.sibret   /*  SI Retention, Balance     */
           sicuw.uwm502.sistat    = sic_bran.uwm502.sistat   /*  SI Statutory              */
           sicuw.uwm502.sitty1    = sic_bran.uwm502.sitty1   /*  SI Treaty, 1st surplus    */
           sicuw.uwm502.sitty2    = sic_bran.uwm502.sitty2   /*  SI Treaty, 2nd surplus    */
           sicuw.uwm502.sifacl    = sic_bran.uwm502.sifacl   /*  SI Facultative, Local     */
           sicuw.uwm502.sifacf    = sic_bran.uwm502.sifacf   /*  SI Facultative, Foreign   */
           sicuw.uwm502.siquota   = sic_bran.uwm502.siquota  /*  SI Quota share (T.F.P.)   */
           sicuw.uwm502.sioth     = sic_bran.uwm502.sioth    /*  SI Other                  */
           sicuw.uwm502.simax     = sic_bran.uwm502.simax .  /*  SI Max/Block              */
         /*sicuw.uwm502.blkdat    = sic_bran.uwm502.blkdat . /*  Blockdate                 */
         */
         END.
       END.
     END.
  end. /* End do nv_fptr */
  sicuw.uwm304.bptr02 = nv_bptr.

end. /* End for sic_bran uwm304 */

HIDE MESSAGE NO-PAUSE.
