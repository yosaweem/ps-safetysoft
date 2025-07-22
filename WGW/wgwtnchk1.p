/* Program : wgwtnchk1.p  
   Program name : เช็คข้อมูลของไฟล์ confirm ที่ผั่ง Expiry 
   Sub program  : wgwtnce2.w 
   Create by : Ranu I. A60-0383 date 19/09/2017   */
/* modify by : Ranu I. A60-0545 ปรับเงื่อนไขการเช็ค loss Ratio */
/* Modify By : Ranu I. A61-0512 เพิ่มตัวแปร Temp-Table  */  
/*Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 Add color */  
/*-----------------------------------------------------------------------------------*/ 
def var nv_polnew  AS CHAR FORMAT "x(13)" init "" .
def var nv_adjust  AS CHAR FORMAT "x(15)" init "" .
def var nv_pol     AS CHAR FORMAT "x(13)" init "" .
DEF VAR nv_tncprm  AS DECI INIT 0.
DEF VAR nv_stamp   AS DECI INIT 0.
DEF VAR nv_vat     AS DECI INIT 0.
DEF VAR nv_gapprm  as deci init 0.
def var nv_compprm as deci init 0.
DEF VAR nv_prm     AS DECI INIT 0.
DEF VAR nv_netprm  AS DECI INIT 0.
DEF VAR nv_res  AS DECI .
DEF VAR nv_paid AS DECI.
DEF VAR nv_loss AS DECI INIT 0.
DEF VAR nv_os   AS DECI INIT 0.
def var nv_LR1  as deci init 0.
DEF VAR nv_LR2  AS DECI INIT 0.
DEF VAR nv_ratio AS CHAR FORMAT "x(50)" .
DEF VAR nv_process AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_comdatck  AS CHAR INIT "".  /*A66-0160*/
DEF VAR nv_notdatck  AS CHAR INIT "".  /*A66-0160*/
DEF VAR nv_prm01  as deci init 0.      /*A66-0160*/

DEFINE SHARED TEMP-TABLE wrec NO-UNDO
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่รับแจ้ง           */
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""    /*เลขที่รับแจ้ง           */
    FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""    /*สาขา – เลขที่สัญญา */  
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""    /*ชื่อประกันภัย         *//*ชื่อผู้เอาประกันภัย*/    
    FIELD ctype         AS CHAR FORMAT "X(15)"  INIT ""    /*สมัครใจ/พรบ.            */
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่เริ่มคุ้มครอง*/      
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่สิ้นสุด           */
    FIELD prem          AS CHAR FORMAT "X(15)"  INIT ""    /*ค่าเบี้ยประกันภัยรวม*/     
    FIELD paydate       AS CHAR FORMAT "X(15)"  INIT ""    /*วันที่ลูกค้าชำระเบี้ยครั้งสุดท้าย*/
    FIELD prevpol       AS CHAR FORMAT "x(15)"  INIT ""    /*A60-0383*/
    FIELD loss          AS CHAR FORMAT "X(15)"  INIT ""
    FIELD remark        AS CHAR FORMAT "X(15)"  INIT ""
    /*--- create by A61-0512 */
    field company       as char format "x(100)" INIT ""     /*บริษัทประกันเก่า        */       
    field ben_name      as char format "x(60)"  INIT ""            /*ผู้รับผลประโยชน์        */       
    field licence       as char format "x(13)"  init ""      /*เลขทะเบียน              */       
    field province      as char format "x(25)"  init ""      /*จังหวัด                 */       
    field ins_amt       as char format "x(15)"  init ""      /*ทุนประกัน               */       
    field prem1         as char format "x(15)"  init ""      /*เบี้ยประกันสุทธิ        */       
    field not_name      as char format "x(75)"  init ""      /*ชื่อประกันภัย           */       
    field brand         as char format "x(35)"  init ""      /*ยี่ห้อ                  */       
    field Brand_Model   as char format "x(60)"  init ""      /*รุ่น                    */       
    field yrmanu        as char format "x(4)"  init ""      /*ปี                      */       
    field weight        as char format "x(6)"  init ""      /*ขนาดเครื่อง             */       
    field engine        as char format "x(50)"  init ""      /*เลขเครื่อง              */       
    field chassis       as char format "x(50)"  init ""      /*เลขถัง                  */       
    field pattern       as char format "x(100)"  init ""      /*Pattern Rate            */       
    field covcod        as char format "x(3)"  init ""      /*ประเภทประกัน            */       
    field vehuse        as char format "x(50)"  init ""      /*ประเภทรถ                */       
    field sclass        as char format "x(5)"  init ""      /*รหัสรถ                  */       
    field garage        as char format "x(10)"  init ""      /*สถานที่ซ่อม             */       
    field drivename1    as char format "x(100)"  init ""      /*ระบุผู้ขับขี่1          */       
    field driveid1      as char format "x(13)"  init ""      /*เลขที่ใบขับขี่1         */       
    field driveic1      as char format "x(13)"  init ""      /*เลขที่บัตรประชาชน1      */       
    field drivedate1    as char format "x(15)"  init ""      /*วันเดือนปีเกิด1         */       
    field drivname2     as char format "x(100)"  init ""      /*ระบุผู้ขับขี่2          */       
    field driveid2      as char format "x(13)"  init ""      /*เลขที่ใบขับขี่2         */       
    field driveic2      as char format "x(13)"  init ""      /*เลขที่บัตรประชาชน2      */       
    field drivedate2    as char format "x(15)"  init ""      /*วันเดือนปีเกิด2         */       
    field cl            as char format "x(10)"  init ""      /*ส่วนลดประวัติเสีย       */       
    field fleetper      as char format "x(10)"  init ""      /*ส่วนลดกลุ่ม             */       
    field ncbper        as char format "x(10)"  init ""      /*ประวัติดี               */       
    field othper        as char format "x(10)"  init ""      /*อื่น ๆ                  */       
    field pol_addr1     as char format "x(150)"  init ""      /*ที่อยู่ลูกค้า           */       
    field icno          as char format "x(13)"  init ""      /*IDCARD                  */       
    field icno_st       as char format "x(15)"  init ""      /*DateCARD_S              */       
    field icno_ex       as char format "x(15)"  init ""      /*DateCARD_E              */       
    field bdate         as char format "x(15)"  init ""      /*Birth Date              */       
    field paidtyp       as char format "x(25)"  init ""      /*Type_Paid_1             */       
    field paid          as char format "x(15)"  init ""      /*Paid_Amount             */       
    field prndate       as char format "x(15)"  init ""      /*วันที่พิมพ์ พรบ.        */       
    field sckno         as char format "x(35)"  init ""     /*เลขสติกเกอร์ / เลข กธ.  */
    field nCOLOR        as char format "x(50)"   init ""    /*A66-0160*/
    field mobile        as char format "x(50)"   init ""    /*A66-0160*/
    field receipaddr    as char format "x(150)"  init ""    /*A66-0160*/
    field sendaddr      as char format "x(150)"  init ""    /*A66-0160*/
    field notifycode    as char format "x(50)"   init ""    /*A66-0160*/
    field salenotify    as char format "x(150)"  init ""    /*A66-0160*/
    field ACCESSORY     as char format "x(250)"  init "".   /*A66-0160*/
    /*-- end A61-0512 --*/
FOR EACH wrec.
    IF index(wrec.ctype,"พรบ") <> 0 THEN NEXT .
    IF wrec.prevpol <> "" THEN DO:
        FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE sic_exp.uwm100.policy = trim(wrec.prevpol) NO-LOCK NO-ERROR.
            IF AVAIL sic_exp.uwm100 THEN  DO:
                ASSIGN nv_polnew    = ""        nv_adjust    = ""       nv_pol       = ""        nv_tncprm    = 0 
                       nv_stamp     = 0         nv_vat       = 0        nv_gapprm    = 0         nv_compprm   = 0 
                       nv_prm       = 0         nv_res       = 0        nv_paid      = 0         nv_os        = 0         
                       nv_loss      = 0         nv_LR1       = 0        nv_LR2       = 0         nv_netprm    = 0 
                       nv_prm01   =  0.

                ASSIGN nv_polnew = sic_exp.uwm100.renpol.
                
                FIND LAST sic_exp.uwm301 USE-INDEX uwm30101  WHERE 
                      sic_exp.uwm301.policy = sic_exp.uwm100.policy NO-LOCK NO-ERROR NO-WAIT.
                     IF AVAIL sic_exp.uwm301 THEN ASSIGN  nv_adjust = string(sic_exp.uwm301.itmdel).

                DISP " Check Data Expiry Policy. " sic_exp.uwm100.policy  WITH COLOR BLACK/WHITE NO-LABEL FRAME frStat1 VIEW-AS DIALOG-BOX.  

                FOR EACH sic_exp.uwd132  USE-INDEX uwd13290  WHERE
                         sic_exp.uwd132.policy   = sic_exp.uwm100.policy  AND
                         sic_exp.uwd132.rencnt   = sic_exp.uwm100.rencnt  AND
                         sic_exp.uwd132.endcnt   = sic_exp.uwm100.endcnt  NO-LOCK.
                         ASSIGN nv_gapprm = nv_gapprm + sic_exp.uwd132.gap_c.
                         
                         IF sic_exp.uwd132.bencod   = "COMP" THEN ASSIGN nv_compprm = sic_exp.uwd132.gap_c.
                END.                                                  
                ASSIGN nv_gapprm = nv_gapprm - nv_compprm
                       nv_prm01  = nv_gapprm         /*A66-0160*/
                       /*nv_netprm = nv_gapprm */ /*A60-0545*/
                       nv_stamp  = TRUNCATE(((nv_gapprm * 0.4 ) / 100 ),0 ) + 1 
                       nv_vat    = (((nv_gapprm + nv_stamp ) * 7 ) / 100 ).
                       nv_gapprm = ((nv_gapprm  + nv_stamp ) + nv_vat ) .

                FOR EACH siccl.clm100 USE-INDEX clm10007  NO-LOCK      WHERE
                         siccl.clm100.vehves  =  sic_exp.uwm301.vehreg AND
                         siccl.clm100.policy  =  sic_exp.uwm301.policy BREAK BY siccl.clm100.claim :

                   FOR EACH siccl.clm120  USE-INDEX clm12001 WHERE siccl.clm120.claim = siccl.clm100.claim NO-LOCK:
                       
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
                       ELSE nv_os =  nv_res - nv_paid . */ /*A60-0545*/
                   END. /* end clm120*/

                   IF clm100.padsts = "X" OR clm100.padsts = "F" OR clm100.padsts = "R" THEN nv_os = 0.
                   ELSE nv_os =  nv_res - nv_paid .  /*a60-0545*/

                   IF siccl.clm100.defau <> "TP" THEN DO:
                       /*IF nv_os <> 0 OR nv_paid <> 0 THEN nv_loss = nv_loss + nv_os + nv_paid  .*/ /*A60-0545*/
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

                IF nv_gapprm <> 0  THEN DO:
                    ASSIGN nv_prm =  nv_gapprm - DECI(wrec.prem).
                    IF  nv_prm >= (-5) AND nv_prm <= 5 THEN wrec.remark = wrec.remark + "|เบี้ยเท่ากัน adjust = " + nv_adjust.
                    ELSE wrec.remark = wrec.remark + "|เบี้ยในไฟล์ " + wrec.prem + " กับใบเตือน " + 
                                       STRING(nv_gapprm) + " ไม่ตรงกัน  adjust = " + STRING(nv_adjust) .
                    IF deci(wrec.loss) <> nv_LR2 THEN wrec.remark = wrec.remark + " |Loss Ratio ในระบบ " + wrec.loss + 
                                                                    " และใบเตือน " + STRING(nv_LR2) + " ไม่เท่ากัน " .
                    ELSE ASSIGN  wrec.remark = wrec.remark + " |Loss Ratio ในระบบ และใบเตือน " + STRING(nv_LR2) + " เท่ากัน " .
                END.
                IF nv_polnew <> ""  THEN ASSIGN wrec.remark = wrec.remark + "|มีต่ออายุกรมธรรม์แล้ว  " + nv_polnew.
                IF sic_exp.uwm100.firstName <> "" AND sic_exp.uwm100.lastName <> "" THEN DO:
                    IF      index(wrec.not_office,sic_exp.uwm100.firstName) = 0 THEN  ASSIGN wrec.remark = wrec.remark + "|ชื่อผู้เอาประกันไม่ตรงใน EXP:" + sic_exp.uwm100.firstName .
                    ELSE IF index(wrec.not_office,sic_exp.uwm100.lastName)  = 0 THEN  ASSIGN wrec.remark = wrec.remark + "|ชื่อผู้เอาประกันไม่ตรงใน EXP:" + sic_exp.uwm100.lastName . 
                END.
                ELSE IF index(wrec.not_office,sic_exp.uwm100.name1) = 0 THEN  ASSIGN wrec.remark = wrec.remark + "|ชื่อผู้เอาประกันไม่ตรงใน EXP:" + sic_exp.uwm100.name1 .  
                /* Add A66-0160*/
                IF wrec.comdat <> "" THEN DO:
                    ASSIGN 
                        nv_comdatck = trim(replace(wrec.comdat,"'",""))        /*15/07/2566*/
                        nv_comdatck = SUBSTR(nv_comdatck,1,6) + string(inte(SUBSTR(nv_comdatck,7,4)) - 543 ).
                    IF DATE(nv_comdatck) <> sic_exp.uwm100.expdat THEN ASSIGN wrec.remark = wrec.remark + "|วันที่คุ้มครองไม่ตรง EXP:" + wrec.comdat .        
                    FIND LAST sic_exp.uwm130 USE-INDEX uwm13001 WHERE
                        sic_exp.uwm130.policy   = sic_exp.uwm100.policy  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sic_exp.uwm130  THEN DO:
                        IF sic_exp.uwm130.uom6_v <> deci(wrec.ins_amt) THEN ASSIGN wrec.remark = wrec.remark + "|ทุนไม่ตรง EXP:" + wrec.ins_amt.      
                    END.
                    IF nv_prm01 <> DECI(wrec.prem1) THEN ASSIGN wrec.remark = wrec.remark + "|เบี้ยสุทธิไม่ตรง EXP/File:" + string(nv_prm01) + "/" + wrec.prem1.  
                    IF wrec.not_date <> "" THEN DO:
                        ASSIGN 
                            nv_notdatck = trim(replace(wrec.not_date,"'",""))        /*15/07/2566*/
                            nv_notdatck = SUBSTR(nv_notdatck,1,6) + string(inte(SUBSTR(nv_notdatck,7,4)) - 543 ).
                        IF DATE(nv_comdatck) < DATE(nv_notdatck) THEN ASSIGN wrec.remark = wrec.remark + "|วันที่คุ้มครองน้อยกว่าวันที่แจ้งงาน :" +  nv_comdatck + "-" + nv_notdatck.
                         
                    END.
                    /*Add A66-0160*/
                END.
            END.
            ELSE ASSIGN wrec.remark = wrec.remark + "|ไม่พบข้อมูลกรมธรรม์ในระบบ Expiry ".
            /*sic_exp.uwm100*/
    END.
    release sic_exp.uwm301.
    release sic_exp.uwm100.
    release sic_exp.uwd132.
    RELEASE sicuw.uwd132.
    release siccl.clm100. 
    release siccl.clm120. 
    release siccl.clm131. 
    release siccl.clm130. 
END.



