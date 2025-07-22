/**-- WGWTBVAT.p --**/
/*-----
    Modify by   : Narin  15/09/2010    A52-0242 
    DEFINE INPUT-OUTPUT PARAMETER  nv_policy , nv_trty11, nv_docno1
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
-----*/
             
DEFINE INPUT-OUTPUT PARAMETER  nv_policy  AS CHARACTER FORMAT "X(16)" NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_trty11  AS CHARACTER FORMAT "X"     NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_docno1  AS CHARACTER FORMAT "X(16)" NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchyr AS INT  FORMAT "9999"  INIT 0.
DEFINE INPUT-OUTPUT PARAMETER  nv_batchno AS CHAR FORMAT "X(13)" INIT ""  NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_batcnt  AS INT  FORMAT "99"    INIT 0.


DEF VAR nv_line AS INTEGER INITIAL 0.
DEF VAR nv_dup  AS INTEGER INITIAL 0.

DEF STREAM ns1.
DEF STREAM ns2.

OUTPUT STREAM ns1 TO trnvat10.txt.
OUTPUT STREAM ns2 TO found100.txt.

FIND FIRST brstat.vat100 USE-INDEX vat10002 WHERE
           brstat.vat100.policy  = nv_policy AND
           brstat.vat100.trnty1  = nv_trty11 AND
           brstat.vat100.refno   = nv_docno1 NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE brstat.vat100 THEN DO:
    
        FIND gw_stat.vat100 USE-INDEX vat10002 WHERE 
             gw_stat.vat100.policy = brstat.vat100.policy AND
             gw_stat.vat100.trnty1 = brstat.vat100.trnty1 AND
             gw_stat.vat100.refno  = brstat.vat100.refno  AND
             gw_stat.vat100.bchyr  = nv_batchyr           AND
             gw_stat.vat100.bchno  = nv_batchno           AND
             gw_stat.vat100.bchcnt = nv_batcnt  
        NO-ERROR .
            IF  NOT AVAILABLE gw_stat.vat100 THEN DO:
                nv_line = nv_line + 1.
                HIDE MESSAGE NO-PAUSE.
/*                   MESSAGE nv_line                                         */
/*                           "CREATE NEW Invtyp :"  brstat.vat100.invtyp     */
/*                           "Invoice :"            brstat.vat100.invoice    */
/*                           "Time :"               STRING(TIME,"HH:MM:SS"). */
                
                  PUT STREAM ns1
                      nv_line
                      "CREATE NEW Invtyp : " brstat.vat100.invtyp
                      " Invoice : "          brstat.vat100.invoice
                      " Policy : "           brstat.vat100.policy FORMAT "X(12)"
                      " R/E "                brstat.vat100.rencnt "/"
                                             brstat.vat100.endcnt
                      " Entdat : "           brstat.vat100.entdat FORMAT "99/99/9999" SKIP.

                CREATE gw_stat.vat100.
                ASSIGN
                    gw_stat.VAT100.invtyp   = brstat.VAT100.invtyp    /*ประเภทใบกำกับภาษี S/B/D/C*/
                    gw_stat.VAT100.buytyp   = brstat.VAT100.buytyp    /*ประเภทภาษีซื้อ Y/N/E */
                    gw_stat.VAT100.invoice  = brstat.VAT100.invoice   /*เลขที่ใบกำกับภาษี */
                    gw_stat.VAT100.invdat   = brstat.VAT100.invdat    /*วันที่ในใบกำกับภาษี*/
                    gw_stat.VAT100.poltyp   = brstat.VAT100.poltyp    /*ประเภทกรมธรรม์ */
                    gw_stat.VAT100.policy   = brstat.VAT100.policy    /*เลขที่กรมธรรม์ */
                    gw_stat.VAT100.rencnt   = brstat.VAT100.rencnt    /*ลำดับที่ต่ออายุ*/
                    gw_stat.VAT100.endcnt   = brstat.VAT100.endcnt    /*ลำดับที่ทำสลักหลัง*/
                    gw_stat.VAT100.branch   = brstat.VAT100.branch    /*รหัสสาขาเจ้าของรายการ*/
                    gw_stat.VAT100.invbrn   = brstat.VAT100.invbrn    /*รหัสสาขาที่ทำรายการ*/
                    gw_stat.VAT100.acno     = brstat.VAT100.acno      /*รหัสตัวแทนนายหน้า */
                    gw_stat.VAT100.agent    = brstat.VAT100.agent     /*รหัสผู้หางาน*/
                    gw_stat.VAT100.pvrvjv   = brstat.VAT100.pvrvjv    /*เลขที่ Pv Rv Jv*/
                    gw_stat.VAT100.trnty1   = brstat.VAT100.trnty1    /*ประเภทการตัดบัญชี */
                    gw_stat.VAT100.refno    = brstat.VAT100.refno     /*เลขที่อ้างอิง*/
                    gw_stat.VAT100.ratevat  = brstat.VAT100.ratevat   /*อัตราภาษี*/
                    gw_stat.VAT100.oldamt   = brstat.VAT100.oldamt    /*มูลค่าสินค้าเดิม*/
                    gw_stat.VAT100.amount   = brstat.VAT100.amount    /*มูลค่าสินค้าก่อนส่วนลด*/
                    gw_stat.VAT100.discamt  = brstat.VAT100.discamt   /*ส่วนลด*/
                    gw_stat.VAT100.totamt   = brstat.VAT100.totamt    /*มูลค่าสินค้าก่อนคิดภาษี*/
                    gw_stat.VAT100.vatamt   = brstat.VAT100.vatamt    /*ภาษีมูลค่าเพิ่ม*/
                    gw_stat.VAT100.grandamt = brstat.VAT100.grandamt  /*จำนวนเงินรวม*/
                    gw_stat.VAT100.insref   = brstat.VAT100.insref    /*รหัสลูกค้า*/
                    gw_stat.VAT100.name     = brstat.VAT100.name      /*ชื่อลูกค้า*/
                    gw_stat.VAT100.add1     = brstat.VAT100.add1      /*ที่อยู่บรรทัด 1*/
                    gw_stat.VAT100.add2     = brstat.VAT100.add2      /*ที่อยู่บรรทัด 2*/
                    gw_stat.VAT100.taxno    = brstat.VAT100.taxno     /*เลขประจำตัวผู้เสียภาษี*/
                    gw_stat.VAT100.desci    = brstat.VAT100.desci     /*รายละเอียดสินค้า*/
                    gw_stat.VAT100.descdis  = brstat.VAT100.descdis   /*รายละเอียดส่วนลด*/
                    gw_stat.VAT100.entdat   = brstat.VAT100.entdat    /*วันที่ทำรายการ */
                    gw_stat.VAT100.enttime  = brstat.VAT100.enttime   /*เวลาที่ทำรายการ*/
                    gw_stat.VAT100.usrid    = brstat.VAT100.usrid     /*ผู้ทำรายการ */
                    gw_stat.VAT100.remark1  = brstat.VAT100.remark1   /*หมายเหตุ 1*/
                    gw_stat.VAT100.remark2  = brstat.VAT100.remark2   /*หมายเหตุ 2*/
                    gw_stat.VAT100.cancel   = brstat.VAT100.cancel    /*ยกเลิกรายการ*/
                    gw_stat.VAT100.print    = brstat.VAT100.print     /*พิมพ์รายการ */
                    gw_stat.VAT100.program  = brstat.VAT100.program   /*ชื่อโปรแกรมที่ทำรายการ*/
                    gw_stat.VAT100.remcan   = brstat.VAT100.remcan    /*เหตุผลการยกเลิก*/
                    gw_stat.VAT100.INVOLD   = brstat.VAT100.INVOLD    /*Old Invoice */
                    gw_stat.VAT100.olddat   = brstat.VAT100.olddat .  /*Old Date */
                
                  ASSIGN
                    gw_stat.VAT100.taxmont  = brstat.VAT100.taxmont   /*เดือนที่ออกใบกับกับภาษี*/
                    gw_stat.VAT100.taxyear  = brstat.VAT100.taxyear   /*ปีที่ออกใบกำกับภาษี*/
                    gw_stat.VAT100.taxrepm  = brstat.VAT100.taxrepm   /*ยื่นเพิ่ม*/
                    gw_stat.VAT100.crevat   = brstat.VAT100.crevat    /*Credit Vat*/
                    gw_stat.VAT100.crevat_p = brstat.VAT100.crevat_p  /*Credit Vat Per.*/

                    gw_stat.vat100.bchyr    = nv_batchyr
                    gw_stat.vat100.bchno    = nv_batchno
                    gw_stat.vat100.bchcnt   = nv_batcnt .

            END.  /* IF  NOT AVAILABLE gw_stat.vat100 THEN DO: */
            ELSE DO:
                nv_dup = nv_dup + 1.
                HIDE MESSAGE NO-PAUSE.
/*                 MESSAGE nv_dup                                         */
/*                         "DUPLICATE Invtyp :"  brstat.vat100.invtyp     */
/*                         "Invoice :"           brstat.vat100.invoice    */
/*                         "Time :"              STRING(TIME,"HH:MM:SS"). */
                PUT STREAM ns2
                    nv_dup
                    "DUPLICATE Invtyp : "  brstat.vat100.invtyp
                    " Invoice : "          brstat.vat100.invoice
                    " Policy : "           brstat.vat100.policy FORMAT "X(12)"
                    " R/E "                brstat.vat100.rencnt "/"
                                           brstat.vat100.endcnt
                    " Entdat : "           brstat.vat100.entdat FORMAT "99/99/9999" SKIP.
                NEXT.
            END.   /* IF AVAILABLE gw_stat.vat100 THEN DO: */

END. /*IF AVAILABLE brstat.vat100 THEN DO:*/

   
