
/* Program name : wgwtnchk.p                                         
   Program name : �礢����Ţͧ��� confirm ����� Expiry             
   Sub program  : wgwimtnc.w                                           
   Create by : Ranu I. A60-0383 05/09/2017 �礢����Ũҡ���Ѻ���͹ */
/* modify by : Ranu I. A60-0545 ��Ѻ���͹䢡���� loss Ratio */
/* Modify by : Ranu I. a63-0174 ���������� Temp-table   */
/*----------------------------------------------------------------------------------*/
def var nv_polnew  AS CHAR FORMAT "x(13)".
def var nv_adjust  AS CHAR FORMAT "x(15)".
def var nv_pol     AS CHAR FORMAT "x(13)".
DEF VAR nv_tncprm  AS DECI INIT 0.
DEF VAR nv_stamp   AS DECI INIT 0.
DEF VAR nv_vat     AS DECI INIT 0.
DEF VAR nv_gapprm  as deci init 0.
def var nv_compprm as deci init 0.
DEF VAR nv_netprm  AS DECI INIT 0.
DEF VAR nv_prm     AS DECI INIT 0.
DEF VAR nv_res  AS DECI .
DEF VAR nv_paid AS DECI.
DEF VAR nv_loss AS DECI INIT 0.
DEF VAR nv_os   AS DECI INIT 0.
def var nv_LR1  as deci init 0.
DEF VAR nv_LR2  AS DECI INIT 0.
DEF VAR nv_ratio AS CHAR FORMAT "x(50)" .
DEF VAR nv_process AS CHAR FORMAT "x(150)" INIT "" .

/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD Pro_off       AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����Ѻ������Ң�  */           
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*�Ţ����Ѻ��         */           
    FIELD branch        AS CHAR FORMAT "X(4)"   INIT ""   /*�Ң�                  */           
    FIELD Account_no    AS CHAR FORMAT "X(12)"  INIT ""   /*�Ţ����ѭ��           */           
    FIELD prev_pol      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ�������������    */           
    FIELD company       AS CHAR FORMAT "X(50)"  INIT ""   /*����ѷ��Сѹ���      */           
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""   /*���ͼ����һ�Сѹ���   */           
    FIELD ben_name      AS CHAR FORMAT "X(50)"  INIT ""   /*����Ѻ�Ż���ª��      */           
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ��������������ͧ   */           
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ�������ش������ͧ */           
    FIELD comdat72      AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ�������������ͧ�ú */           
    FIELD expdat72      AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ�������ش������ͧ�ú*/         
    FIELD licence       AS CHAR FORMAT "X(11)"  INIT ""   /*�Ţ����¹            */           
    FIELD province      AS CHAR FORMAT "X(30)"  INIT ""   /*�ѧ��Ѵ               */           
    FIELD ins_amt       AS CHAR FORMAT "X(15)"  INIT ""   /*�ع��Сѹ             */           
    FIELD prem1         AS CHAR FORMAT "X(15)"  INIT ""   /*���»�Сѹ���        */           
    FIELD comp_prm      AS CHAR FORMAT "X(15)"  INIT ""   /*���¾ú���           */           
    FIELD gross_prm     AS CHAR FORMAT "X(15)"  INIT ""   /*�������              */           
    FIELD compno        AS CHAR FORMAT "X(13)"  INIT ""   /*�Ţ��������ú        */           
    FIELD sckno         AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���ʵ������      */           
    FIELD not_code      AS CHAR FORMAT "X(75)"  INIT ""   /*���ʼ����           */           
    FIELD remark        AS CHAR FORMAT "X(225)" INIT ""   /*�����˵�              */           
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ����Ѻ��         */           
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""   /*���ͻ�Сѹ���         */           
    FIELD not_name      AS CHAR FORMAT "X(50)"  INIT ""   /*�����               */           
    FIELD brand         AS CHAR FORMAT "X(15)"  INIT ""   /*������                */           
    FIELD Brand_Model   AS CHAR FORMAT "X(35)"  INIT ""   /*���                  */           
    FIELD yrmanu        AS CHAR FORMAT "X(10)"  INIT ""   /*��                    */           
    FIELD weight        AS CHAR FORMAT "X(10)"  INIT ""   /*��Ҵ����ͧ           */           
    FIELD engine        AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����ͧ            */           
    FIELD chassis       AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ�ѧ                */           
    FIELD pattern       AS CHAR FORMAT "X(75)"  INIT ""   /*Pattern Rate          */           
    FIELD covcod        AS CHAR FORMAT "X(3)"   INIT ""   /*��������Сѹ          */           
    FIELD vehuse        AS CHAR FORMAT "X(50)"  INIT ""   /*������ö              */           
    FIELD garage        AS CHAR FORMAT "X(30)"  INIT ""   /*ʶҹ������           */           
    FIELD drivename1    AS CHAR FORMAT "X(50)"  INIT ""   /*�кؼ��Ѻ���1        */           
    FIELD driveid1      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���㺢Ѻ���1       */           
    FIELD driveic1      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���ѵû�ЪҪ�1    */           
    FIELD drivedate1    AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ��͹���Դ1       */           
    FIELD drivname2     AS CHAR FORMAT "X(50)"  INIT ""   /*�кؼ��Ѻ���2        */           
    FIELD driveid2      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���㺢Ѻ���2       */           
    FIELD driveic2      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���ѵû�ЪҪ�2    */           
    FIELD drivedate2    AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ��͹���Դ2       */           
    FIELD cl            AS CHAR FORMAT "X(15)"  INIT ""   /*��ǹŴ����ѵ�����     */           
    FIELD fleetper      AS CHAR FORMAT "X(15)"  INIT ""   /*��ǹŴ�����           */           
    FIELD ncbper        AS CHAR FORMAT "X(15)"  INIT ""   /*����ѵԴ�             */           
    FIELD othper        AS CHAR FORMAT "x(15)"  INIT ""   /*��� �                */           
    FIELD pol_addr1     as char format "x(150)" init ""   /*��������١���         */           
    FIELD icno          as char format "x(13)"  init ""   /*IDCARD                */           
    FIELD icno_st       as char format "x(15)"  init ""   /*DateCARD_S            */           
    FIELD icno_ex       as char format "x(15)"  init ""   /*DateCARD_E            */           
    FIELD paid          as char format "x(50)"  init ""   /*Type_Paid_1           */           
    FIELD addr1         as char format "x(35)"  init ""                                        
    FIELD addr2         as char format "x(35)"  init ""
    FIELD addr3         as char format "x(35)"  init ""
    FIELD addr4         as char format "x(35)"  init ""
    FIELD pol_title     as char format "x(15)"  init ""
    FIELD pol_fname     as char format "x(50)"  init ""
    FIELD pol_lname     as char format "x(50)"  init ""
    FIELD not_time      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD remark2       AS CHAR FORMAT "x(150)"  INIT ""
     /* A63-0174 */
    field mkBR          as char format "x(15)" init "" 
    field lgroup         as char format "x(50)" init "" 
    field notiname      as char format "x(50)" init "" 
    field pol_addr2     as char format "x(100)" init "" 
    field tel           as char format "x(20)" init "" 
    field pol_send1     as char format "x(100)" init "" 
    field pol_send2     as char format "x(100)" init "" 
    field telsend       as char format "x(20)" init "" 
    field netprem       as char format "x(15)" init "" 
    field comprem       as char format "x(15)" init "" 
    field ncolor        as char format "x(15)" init "" 
    field comment       as char format "x(255)" init "" 
    field pol_promo     as char format "x(50)" init "" 
    field comp_promo    as char format "x(50)" init "" 
    field price         as char format "x(15)" init "" 
    field price1        as char format "x(15)" init "" 
    field dealer        as char format "x(50)" init "" 
    field drive         as char format "x(15)" init "" 
    field cartype       as char format "x(30)" init "" 
    field notitype      as char format "x(25)" init "" 
    field vehuse1       as char format "x(50)" init "" 
    field CodeRe        as char format "x(5)" init "" 
    field seat          as char format "x(3)" init "" 
    field taxno         as char format "x(15)" init "" 
    field name2         as char format "x(100)" init "" 
    field typeic        as char format "x(25)" init "" 
    field typetax       as char format "x(50)" init "" 
    field taxbr         as char format "x(5)" init "" .
    /* end A63-0174 */

FOR EACH wdetail WHERE wdetail.chassis <> "" .
    DISP " Check Data Expiry ......." WITH COLOR BLACK/WHITE NO-LABEL FRAME frStat VIEW-AS DIALOG-BOX.     
    IF deci(wdetail.prem1) <> 0 THEN DO:
        ASSIGN nv_polnew  = ""      nv_adjust  = ""     nv_pol     = ""      nv_gapprm  = 0
               nv_compprm = 0       nv_tncprm  = 0      nv_prm     = 0       nv_res     = 0      
               nv_os      = 0       nv_paid    = 0      nv_loss    = 0       nv_LR1     = 0
               nv_LR2     = 0       nv_netprm  = 0 .
        DISP " Check Data Expiry Chassicno. " wdetail.chassis " ..........." 
        WITH COLOR BLACK/WHITE NO-LABEL FRAME frStat1 VIEW-AS DIALOG-BOX.
        nv_tncprm = TRUNCATE(DECI(wdetail.prem1),0).
        FIND LAST sic_exp.uwm301 USE-INDEX uwm30121  WHERE sic_exp.uwm301.cha_no = trim(wdetail.chassis) AND 
                                                           sic_exp.uwm301.tariff = "X" NO-LOCK NO-ERROR NO-WAIT.
                 IF AVAIL sic_exp.uwm301 THEN DO:
                     ASSIGN  nv_pol    = sic_exp.uwm301.policy
                             nv_adjust = string(sic_exp.uwm301.itmdel).
                      
                       FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE sic_exp.uwm100.policy = sic_exp.uwm301.policy AND
                                                                         sic_exp.uwm100.rencnt = sic_exp.uwm301.rencnt AND
                                                                         sic_exp.uwm100.endcnt = sic_exp.uwm301.endcnt NO-LOCK NO-ERROR.
                           IF AVAIL sic_exp.uwm100 THEN 
                               ASSIGN nv_polnew = sic_exp.uwm100.renpol.
                      
                           FOR EACH sic_exp.uwd132  USE-INDEX uwd13290  WHERE
                               sic_exp.uwd132.policy   = sic_exp.uwm100.policy  AND
                               sic_exp.uwd132.rencnt   = sic_exp.uwm100.rencnt  AND
                               sic_exp.uwd132.endcnt   = sic_exp.uwm100.endcnt  NO-LOCK.
                               ASSIGN nv_gapprm = nv_gapprm + sic_exp.uwd132.gap_c.
                               IF sic_exp.uwd132.bencod   = "COMP" THEN ASSIGN nv_compprm = sic_exp.uwd132.gap_c.
                            END.   
                            
                       ASSIGN nv_gapprm = nv_gapprm - nv_compprm
                              /*nv_netprm = nv_gapprm */ /*A60-0545*/
                              nv_stamp  = TRUNCATE(((nv_gapprm * 0.4 ) / 100 ),0 ) + 1 
                              nv_vat    = (((nv_gapprm + nv_stamp ) * 7 ) / 100 ).
                              nv_gapprm = ((nv_gapprm  + nv_stamp ) + nv_vat ) .

                       FOR EACH siccl.clm100 USE-INDEX clm10007  NO-LOCK      WHERE
                                siccl.clm100.vehves  =  sic_exp.uwm301.vehreg AND
                                siccl.clm100.policy  =  sic_exp.uwm301.policy BREAK BY siccl.clm100.claim :

                           FOR EACH siccl.clm120  USE-INDEX clm12001 WHERE  siccl.clm120.claim = siccl.clm100.claim NO-LOCK:
                               
                               FOR EACH siccl.clm131 USE-INDEX clm13101      WHERE
                                        siccl.clm131.claim  = siccl.clm120.claim   AND
                                        siccl.clm131.clmant = siccl.clm120.clmant  AND
                                        siccl.clm131.clitem = siccl.clm120.clitem  AND  
                                        siccl.clm131.cpc_cd = "EPD"                NO-LOCK:
                                        
                                  IF siccl.clm131.res <> ? THEN
                                  nv_res = nv_res + siccl.clm131.res.
                               END.
                               
                               FOR EACH siccl.clm130 USE-INDEX clm13002      WHERE
                                        siccl.clm130.claim  = siccl.clm120.claim   AND
                                        siccl.clm130.clmant = siccl.clm120.clmant  AND
                                        siccl.clm130.clitem = siccl.clm120.clitem  AND
                                        siccl.clm130.cpc_cd = "EPD"            NO-LOCK:
                               
                                  IF clm130.netl_d <> ? THEN
                                  nv_paid  = nv_paid + siccl.clm130.netl_d.
                               END. 
                               /*IF clm100.padsts = "X" OR clm100.padsts = "F" OR clm100.padsts = "R" THEN nv_os = 0.
                               ELSE nv_os =  nv_res - nv_paid .*/ /*A60-0545*/
                           END. /* end clm120*/

                           IF clm100.padsts = "X" OR clm100.padsts = "F" OR clm100.padsts = "R" THEN nv_os = 0.
                           ELSE nv_os =  nv_res - nv_paid . /*A60-0545*/

                           IF siccl.clm100.defau <> "TP" THEN DO:
                                 /*IF nv_os <> 0 OR nv_paid <> 0 THEN nv_loss = nv_loss + nv_os + nv_paid .*/
                               IF nv_os <> 0 OR nv_paid <> 0 THEN nv_loss = (nv_os + nv_paid). /*A60-0545*/
                           END.
                       END. /* end clm100 */
                       /* create by  : A60-0545*/
                       FOR EACH sicuw.uwd132  USE-INDEX uwd13290  WHERE
                                sicuw.uwd132.policy   = sic_exp.uwm301.policy AND
                                sicuw.uwd132.riskno   = sic_exp.uwm301.riskno AND
                                sicuw.uwd132.itemno   = sic_exp.uwm301.itemno NO-LOCK.
                                nv_netprm = nv_netprm + sicuw.uwd132.prem_c.
                       END.  
                       /* end A60-0545 */
                       ASSIGN  nv_LR1  = ( nv_loss / nv_netprm ) * 100  
                               nv_LR2  = TRUNC(nv_LR1,0) .
                       IF (nv_LR1 - nv_LR2) > 0 THEN nv_LR2 = nv_LR2 + 1 .
                 END. /* end uwm301 */
          ASSIGN wdetail.loss = string(nv_LR2).
          DISP " Update Data Expiry to Temp-tabel " wdetail.chassis " ..........." 
          WITH COLOR BLACK/WHITE NO-LABEL FRAME frStat2 VIEW-AS DIALOG-BOX.
          IF nv_pol <> ""  THEN DO:
              IF LENGTH(wdetail.prev_pol) = 12 AND wdetail.prev_pol <> nv_pol THEN ASSIGN wdetail.remark2 = wdetail.remark2 + " |�����������������ç�ѹ " + nv_pol .
              IF wdetail.PREV_pol = "" OR LENGTH(wdetail.PREV_pol) <> 12 THEN  ASSIGN wdetail.prev_pol = nv_pol .
              IF nv_polnew <> "" THEN ASSIGN wdetail.remark2 = wdetail.remark2 + " |���������ա�õ���������� " + nv_polnew.
              IF nv_gapprm <> 0 THEN DO:
                  ASSIGN nv_prm =  nv_gapprm - nv_tncprm .
                  IF nv_prm >= (-5) AND nv_prm <= 5 THEN ASSIGN wdetail.remark2 = wdetail.remark2 + "|���������µç�ѹ ".
                  ELSE ASSIGN wdetail.remark2 = wdetail.remark2 + " |������������ҡѺ���͹ " + STRING(nv_gapprm).
              END.
              IF nv_adjust <> "YES" THEN ASSIGN wdetail.remark2 = wdetail.remark2 + " |Ajust = NO" .
              ELSE ASSIGN wdetail.remark2 = wdetail.remark2 + " |Ajust = YES " .
          END.
          ELSE DO:
              ASSIGN wdetail.remark2 = "��辺�������������к� Expiry " 
                     wdetail.loss    = string(nv_LR2).
          END.
    END. /* end wdetail.prem1 <> 0 */
    ELSE ASSIGN wdetail.remark2 = " �������� 72 "
                wdetail.loss    = string(nv_LR2).

    release sic_exp.uwm301.
    release sic_exp.uwm100.
    release sic_exp.uwd132.
    RELEASE sicuw.uwd132.
    release siccl.clm100. 
    release siccl.clm120. 
    release siccl.clm131. 
    release siccl.clm130. 
END.
