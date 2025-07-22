/*programid   : wgwklgen.i                                            */
/*programname : load text file K-Lissing  to GW                       */
/* Copyright  : Safety Insurance Public Company Limited 			  */
/*			    บริษัท ประกันคุ้มภัย จำกัด (มหาชน)				      */
/*create by   : Kridtiya i. A52-0172   date . 08/07/2009              
                ปรับโปรแกรมให้สามารถนำเข้า text file HCT to GW system */ 
/*copy write  : wgwargen.i                                            */
/**********************************************************************
MOdify By  : Suthida T. A52-0275  Date 27-09-10
             ->  Error Sticker 
             -> ** Value too large for integer. (78)
**********************************************************************/
/*Modify by : Kridtiya i. A57-0244 เพิ่มตัวแปร การสร้างรหัสลูกค้า    */
/*Modify by : Ranu i. A59-0029  เพิ่มตัวแปรเก็บค่าอุปกรณ์เสริม Acc. text */
/*Modify by : Ranu i. A59-0182  เพิ่มตัวแปรเก็บค่าเพิ่มเติม              */
/*Modify by : Ranu i. A61-0269  ขยาย format nv_pwd                        */
/*Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by : Kridtiya i. A66-0108 Date. 12/06/2023 add color*/
/*----------------------------------------------------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD applino     AS CHAR FORMAT "x(20)" INIT ""        /*กรมธรรม์*/
    FIELD policy      AS CHAR FORMAT "x(20)" INIT ""        /*กรมธรรม์*/
    FIELD recnt       AS INT                                /*renew count*/
    FIELD endcnt      AS INT                                /* Endores count*/
    FIELD branch      AS CHAR FORMAT "x(2)"  INIT ""        /*สาขา*/
    FIELD Insd        AS CHAR FORMAT "x(32)" INIT ""        /*เลขที่รับแจ้ง*/
    FIELD ntitle      AS CHAR FORMAT "x(10)" INIT ""        /*เลขที่รับแจ้ง*/
    FIELD name1       AS CHAR FORMAT "x(50)" INIT ""        /*ชื่อผู้เอาประกันภัย*/
    FIELD name2       AS CHAR FORMAT "x(65)" INIT ""        /*ชื่อที่ออกใบกำกับภาษี*/
    FIELD addrss1     AS CHAR FORMAT "x(50)" INIT ""        /*ที่อยู่1*/
    FIELD addrss2     AS CHAR FORMAT "x(50)" INIT ""        /*รหัสบริษัทประกันภัย*/  
    FIELD addrss3     AS CHAR FORMAT "x(50)" INIT ""        /*ประเภทรถ*/ 
    FIELD addrss4     AS CHAR FORMAT "x(50)" INIT ""        /*ประเภทการขาย*/
    FIELD billac      AS CHAR FORMAT "x(16)" INIT ""        /*ประเภทแคมเปญ*/
    FIELD comdat      AS DATE                               /*จำนวนเงินให้ฟรี*/
    FIELD expdat      AS DATE                               /*ประเภทความคุ้มครอง*/
    FIELD trandat     AS DATE                               /*ประเภทประกัน*/
    FIELD pass        AS CHAR FORMAT "x"     INIT "n"       
    FIELD cancel      AS CHAR FORMAT "x(2)"  INIT ""        /*cancel*/
    /*       FIELD stk         AS CHAR FORMAT "X(20)" INIT ""   /*เลขที่สติ๊กเกอร์*/ */
    FIELD stk         AS CHAR FORMAT "X(13)" INIT ""        /*เลขที่สติ๊กเกอร์*//* ----- suthida T. A52-0075 27-09-10 ------ */
    FIELD PACKAGE     AS CHAR FORMAT "x"     INIT ""        /*PACKAGE*/          
    FIELD class       AS CHAR FORMAT "X(5)"  INIT ""        /*class */
    FIELD si          AS DECI FORMAT "->>,>>>,>>>,>>9.99"   INIT 0  /*วงเงินทุนประกัน*/
    FIELD access      AS CHAR FORMAT "X"  INIT ""                   /*อุปกรเสริม*/
    FIELD accessd     AS CHAR FORMAT "X(60)" INIT ""                /*รายละเอียดอุปกรเสริม*/
    FIELD covcod      AS CHAR FORMAT "X"     INIT ""                /*ประเภทความคุ้มครอง*/
    FIELD garage      AS CHAR FORMAT "x(6)"  INIT ""                /*ประเภทการซ่อม*/
    FIELD NO_41       AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT ""   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่*/ 
    FIELD NO_42       AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT ""   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง*/
    FIELD NO_43       AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT ""   /*การประกันตัวผู้ขับขี่*/
    FIELD uom1_v      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT ""   /*a57-0244*/
    FIELD uom2_v      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT ""   /*a57-0244*/
    FIELD uom5_v      AS DECI FORMAT "->>,>>>,>>>,>>9.99" INIT ""   /*a57-0244*/
    /*FIELD ac2         AS CHAR FORMAT "x(2)"  INIT ""  /*อุบัติเหตุส่วนบุคคลเสียชีวิตจน.ผู้โดยสาร*/
    FIELD ac4         AS CHAR FORMAT "x(14)" INIT ""    /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้ขับขี่ */
    FIELD ac5         AS CHAR FORMAT "x(2)"  INIT ""    /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวจน.ผู้โดยสาร*/
    FIELD ac6         AS CHAR FORMAT "x(14)" INIT ""    /*อุบัติเหตุส่วนบุคคลทุพพลภาพชั่วคราวผู้โดยสารต่อครั้ง*/
    FIELD ac7         AS CHAR FORMAT "x(14)" INIT ""    /*ค่ารักษาพยาบาล*/*/
    FIELD comper      AS CHAR FORMAT "x(14)" INIT ""    /*ความเสียหายต่อชีวิต(บาท/คน)*/      
    FIELD comacc      AS CHAR FORMAT "x(14)" INIT ""    /*ความเสียหายต่อชีวิต(บาท/ครั้ง)*/      
    FIELD seat41      AS INTE FORMAT "99"    INIT 0     
    FIELD brand       AS CHAR FORMAT "x(10)" INIT ""    /*ยี่ห้อรถ*/
    FIELD model       AS CHAR FORMAT "x(40)" INIT ""    /*ชื่อรุ่นรถ*/
    FIELD chasno      AS CHAR FORMAT "x(25)" INIT ""    /*หมายเลขตัวถัง*/
    FIELD eng         AS CHAR FORMAT "x(20)" INIT ""    /*หมายเลขเครื่อง*/
    FIELD engcc       AS CHAR FORMAT "x(4)"  INIT ""    /*ปริมาตรกระบอกสูบ*/
    FIELD caryear     AS CHAR FORMAT "x(4)"  INIT ""    /*รุ่นปี*/
    FIELD body        AS CHAR FORMAT "x(40)" INIT ""    /*แบบตัวถัง*/
    FIELD benname     AS CHAR FORMAT "x(80)" INIT ""    /*ผู้รับผลประโยชน์*/
    FIELD vehreg      AS CHAR FORMAT "x(10)" INIT ""    /*เลขทะเบียนรถ*/
    FIELD vehuse      AS CHAR FORMAT "x(2)"  INIT ""    /*รหัสลักษณะการใช้งาน*/
    FIELD tariff      AS CHAR FORMAT "x(2)"  INIT "9"   
    FIELD compul      AS CHAR FORMAT "x"     INIT ""    
    FIELD drivername1 AS CHAR FORMAT "x(80)" INIT ""    /*ชื่อผู้ขับขี่คนที่1 */
    FIELD age1        AS INT     /**/                   
    FIELD drivername2 AS CHAR FORMAT "x(80)" INIT ""    /*ชื่อผู้ขับขี่คนที่2 */
    FIELD age2        AS INT  /**/
    FIELD drivnam     AS CHAR FORMAT "x"     INIT "n" 
    FIELD dbirth1      AS CHAR FORMAT "x(10)" INIT ""       /*วันเกิด*/
    FIELD dbirth2     AS CHAR FORMAT "x(10)" INIT ""       /*วันเกิด2*/              
    FIELD weight      AS CHAR FORMAT "x(5)"  INIT ""  
    FIELD prepol      AS CHAR FORMAT "x(32)" INIT ""  /*เลขที่กรมธรรม์เดิม*/
    FIELD cargrp      AS CHAR FORMAT "x"     INIT ""  /*กลุ่มรถยนต์*/
    FIELD redbook     AS CHAR FORMAT "X(8)"  INIT ""  
    FIELD ncb         AS CHAR FORMAT "X(14)" INIT ""  /*อัตราส่วนลดประวัติดี*/
    FIELD comment     AS CHAR FORMAT "x(512)"INIT ""  
    FIELD premt       AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99"   INIT 0  /*เบี้ยประกัน*/
    FIELD WARNING     AS CHAR FORMAT "X(30)" INIT ""  
    /*FIELD deductpd    AS CHAR FORMAT "X(14)" INIT ""  /*ความเสียหายต่อทรัพย์สิน*/      */
    FIELD fleet       AS CHAR FORMAT "x(10)" INIT ""  /*fleet*/
    FIELD prem_r      AS CHAR FORMAT "x(14)" INIT ""  /*เบี้ยประกันรวม*/
    FIELD agent       AS CHAR FORMAT "x(10)" INIT ""  
    FIELD producer    AS CHAR FORMAT "x(10)" INIT ""  
    FIELD entdat      AS CHAR FORMAT "x(10)" INIT ""  /*entry date*/
    FIELD enttim      AS CHAR FORMAT "x(8)"  INIT ""  /*entry time*/    
    FIELD trantim     AS CHAR FORMAT "x(8)"  INIT ""  /*tran time*/     
    FIELD OK_GEN      AS CHAR FORMAT "X"     INIT "Y" 
    /*FIELD typrequest  AS CHAR FORMAT "x(10)" INIT ""   /*ประเภทผู้แจ้งประกัน*/*/
    /*FIELD comrequest  AS CHAR FORMAT "x(10)" INIT ""   /*รหัสบริษัทผู้แจ้งประกัน*/*/
    /*FIELD n_branch    AS CHAR FORMAT "x(5)"  INIT "" */  
    /*FIELD n_delercode AS CHAR FORMAT "x(15)" INIT ""*/   
    FIELD nmember     AS CHAR FORMAT "x(255)" INIT ""  /*หมายเหตุ*/
    FIELD cr_2        AS CHAR FORMAT "x(32)"  INIT ""  
    FIELD docno       AS CHAR FORMAT "x(10)"  INIT ""  
    FIELD accdat      AS CHAR FORMAT "x(10)"  INIT ""  /*Account Date For 72*/
    FIELD datwork     AS CHAR FORMAT "x(20)"  INIT ""  /*วันที่คำขอ*/
    FIELD uswork      AS CHAR FORMAT "x(30)"  INIT ""  /*คนแจ้งงาน */
    FIELD poltyp      AS CHAR FORMAT "x(3)"   INIT ""
    FIELD tel         AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD occoup      AS CHAR FORMAT "x(35)"  INIT ""     /*A57-0244 */  
    FIELD idno        AS CHAR FORMAT "x(15)"  INIT ""     /*A57-0244 */ 
    FIELD vatcode     AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD w_type      AS CHAR FORMAT "x(30)"  INIT ""     /*A59-0029*/
    FIELD payment     AS CHAR FORMAT "X(20)" INIT ""    /*A59-0182*/
    FIELD track       AS CHAR FORMAT "x(60)" INIT ""    /*A59-0182*/
    FIELD promo       AS CHAR FORMAT "x(15)" INIT ""    /*A59-0182*/
    FIELD ispno       AS CHAR FORMAT "x(50)" INIT ""    /*A59-0182*/ 
    FIELD camp        AS CHAR FORMAT "x(50)" INIT ""    /*A59-0182*/ 
    FIELD financecd   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD delercode   AS CHAR FORMAT "x(30)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD nCOLOR      AS CHAR FORMAT "x(100)" INIT "" .  /*A66-0108*/

DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE VAR nv_line1   AS INTEGER   INITIAL 0        NO-UNDO.
DEFINE VAR nv_txt1    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8    AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_fptr    AS RECID.
DEFINE VAR nv_bptr    AS RECID.
DEFINE VAR nv_undyr   AS CHAR      FORMAT  "X(4)"INIT  ""    .
DEFINE            VAR nv_accdat  AS DATE  FORMAT "99/99/9999" INIT ?  .
DEF    NEW SHARED VAR nv_message AS CHAR.
/*a490166*/
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.
DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0.            /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO.  /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "".           /*Temp Policy*/
DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
DEF VAR Eapplino    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2text14    AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR E2sticker   AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR E2oldpol    AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR E2instype   AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR ENnam       AS CHAR FORMAT "x(4)"   INIT "". 
DEF VAR THnam       AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR E2text15    AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR E2occup     AS CHAR FORMAT "x(35)"  INIT "".  /*A57-0244*/
DEF VAR E2idno      AS CHAR FORMAT "x(15)"  INIT "".  /*A57-0244*/
DEF VAR EAddress1   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR EAddress2   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR EAddress3   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR EAddress4   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2text16    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2drinam1   AS CHAR FORMAT "x(30)"  INIT "". 
DEF VAR E2dribht1   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2driage1   AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR E2dricr1    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2driid1    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2drinam2   AS CHAR FORMAT "x(30)"  INIT "". 
DEF VAR E2dribht2   AS CHAR FORMAT "x(15)"  INIT "". 
DEF VAR E2driage2   AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR E2dricr2    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2driid2    AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR Eeffecdat   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR Eexpirdat   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2make      AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR E2model     AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR E2YEAR      AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR E22lisen    AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR E2chassis   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2engine    AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR E2cc        AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR E2tonnage   AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR E2seat      AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR E2CVMI      AS CHAR FORMAT "x(4)"   INIT "". 
DEF VAR Esumins     AS CHAR FORMAT "x(20)"  INIT "".  
DEF VAR Enetprm     AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR Egrossprm   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2prmp      AS CHAR FORMAT "x(20)"  INIT "".
DEF VAR E2totalp    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR E2Garage    AS CHAR FORMAT "x(20)" INIT "". 
DEF VAR E2access    AS CHAR FORMAT "X"     INIT "". 
DEF VAR E2aecsdes   AS CHAR FORMAT "x(50)" INIT "". 
DEF VAR E2text18    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR E2text17    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR E2textco    AS CHAR FORMAT "x(100)" INIT "".  /*A57-0244 */
DEF VAR E2poltype   AS CHAR FORMAT "x(7)"  INIT "".
DEF VAR nv_count    AS INTE .              
DEF VAR nv_datwork  AS CHAR FORMAT "x(20)" INIT "".
DEF VAR E2brach     AS CHAR FORMAT "x(3)"  INIT "".
DEF VAR ETel        AS CHAR FORMAT "x(15)" INIT "".
DEF VAR E2CV_perbi  AS CHAR FORMAT "x(25)" INIT "". 
DEF VAR E2CV_perac  AS CHAR FORMAT "x(25)" INIT "". 
DEF VAR E2CV_perpd  AS CHAR FORMAT "x(25)" INIT "". 
DEF VAR E2CV_41     AS CHAR FORMAT "x(25)" INIT "". 
DEF VAR E2CV_42     AS CHAR FORMAT "x(25)" INIT "". 
DEF VAR E2CV_43     AS CHAR FORMAT "x(25)" INIT "". 
DEF VAR E2CV_vatcode   AS CHAR FORMAT "x(10)" INIT "". 
DEF VAR E2CV_ispno     AS CHAR FORMAT "x(30)" INIT "". 
DEF VAR E2CV_campaign  AS CHAR FORMAT "x(35)" INIT "". 
DEF VAR E2CV_poltyp    AS CHAR FORMAT "x(10)" INIT "". /*Add poltype ......*/
DEF VAR benefic        AS CHAR FORMAT "x(60)" INIT "". /*A59-0182*/
DEF VAR n_producer     AS CHAR FORMAT "x(10)" INIT "". /*A59-0182*/
DEF VAR n_agent        AS CHAR FORMAT "x(10)" INIT "". /*A59-0182*/
DEF VAR n_payment      AS CHAR FORMAT "x(20)" INIT "". /*A59-0182*/
DEF VAR n_track        AS CHAR FORMAT "x(50)" INIT "". /*A59-0182*/   
DEF VAR n_campaign_ov  AS CHAR FORMAT "x(30)" INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_postcd       AS CHAR FORMAT "x(20)"  INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_codeocc      AS CHAR FORMAT "x(4)"  INIT "".   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_codeaddr1    AS CHAR FORMAT "x(2)"  INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_codeaddr2    AS CHAR FORMAT "x(2)"  INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_codeaddr3    AS CHAR FORMAT "x(2)"  INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_insnamtyp    AS CHAR FORMAT "x(100)"  INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_firstName    AS CHAR FORMAT "x(100)"  INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEF VAR n_lastName     AS CHAR FORMAT "x(100)"  INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 



DEF VAR nv_recid100 AS RECID.
DEF TEMP-TABLE  temp-item
    FIELD LineNo  As      Int
    FIELD Ltext   As      Char
    INDEX LineNo  IS PRIMARY   LineNo    ASCENDING.
/* ---- suthida T. A54-0010 20-01-11 ---- */
DEFINE VAR n_ben83     AS CHAR FORMAT "X(50)"  EXTENT 2. 
DEFINE VAR gv_id       AS CHAR FORMAT "X(8)" NO-UNDO.    
/*DEFINE VAR nv_pwd      AS CHAR NO-UNDO.  */            /*A61-0269*/
DEF VAR nv_pwd         AS CHAR FORMAT "x(15)" NO-UNDO.   /*A61-0269*/
DEFINE VAR nv_uswork   AS CHAR FORMAT "X(50)".
DEFINE VAR n_firstdat  AS DATE INIT ?.
DEFINE VAR nv_prov     AS CHAR.
DEF VAR dod1           AS DECI.
DEF VAR dod2           AS DECI.
DEF VAR dod0           AS DECI.
DEFINE VAR n_uom1_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0. 
DEFINE VAR n_uom2_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.  
DEFINE VAR n_uom5_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE VAR n_uom7_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE VAR nv_renew     AS LOGICAL.
DEFINE VAR n_prepol     AS CHAR FORMAT "x(15)" .
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.
DEFINE VAR nv_modelred AS CHAR FORMAT "x(45)".
DEFINE WORKFILE wacctext
    FIELD n_policytxt  AS CHAR  INIT "" FORMAT "x(100)"            /*Add kridtiya i. A57-0244*/
    FIELD n_textacc1   AS CHAR  INIT "" FORMAT "x(100)"            /*Add kridtiya i. A57-0244*/
    FIELD n_textacc2   AS CHAR  INIT "" FORMAT "x(100)"           /*Add kridtiya i. A57-0244*/ 
    FIELD n_textacc3   AS CHAR  INIT "" FORMAT "x(100)"   /*A59-0182*/      
    FIELD n_textacc4   AS CHAR  INIT "" FORMAT "x(100)".  /*A59-0182*/
DEFINE VAR n_insref     AS CHARACTER FORMAT "X(10)".               /*Add kridtiya i. A57-0244*/    
DEFINE VAR nv_messagein AS CHAR FORMAT "X(200)".                   /*Add kridtiya i. A57-0244*/    
DEFINE VAR nv_usrid     AS CHARACTER FORMAT "X(08)".               /*Add kridtiya i. A57-0244*/    
DEFINE VAR nv_transfer  AS LOGICAL   .                             /*Add kridtiya i. A57-0244*/    
DEFINE VAR n_check      AS CHARACTER .                             /*Add kridtiya i. A57-0244*/    
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(10)".               /*Add kridtiya i. A57-0244*/    
DEFINE VAR putchr       AS CHAR FORMAT "X(200)" INIT "" NO-UNDO.   /*Add kridtiya i. A57-0244*/    
DEFINE VAR putchr1      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.   /*Add kridtiya i. A57-0244*/    
DEFINE VAR nv_typ       AS CHAR FORMAT "X(2)".                     /*Add kridtiya i. A57-0244*/   
/*--- A59-0029------*/
DEF VAR nv_acc6 AS CHAR FORMAT "x(60)" INIT "".     
DEF VAR nv_acc1 AS CHAR FORMAT "x(60)" INIT "".     
DEF VAR nv_acc2 AS CHAR FORMAT "x(60)" INIT "".     
DEF VAR nv_acc3 AS CHAR FORMAT "x(60)" INIT "".     
DEF VAR nv_acc4 AS CHAR FORMAT "x(60)" INIT "".     
DEF VAR nv_acc5 AS CHAR FORMAT "x(60)" INIT "".     
/*--- A59-0029------*/
DEF VAR np_comdat AS DATE .
DEF VAR np_vehuse AS CHAR FORMAT "x(11)".
DEF VAR n_promo AS CHAR FORMAT "x(20)".
DEF var n_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   .
DEF var n_prmtxt    AS CHAR FORMAT "x(100)" INIT "".   
DEF var n_driver    AS CHAR FORMAT "X(50)" INITIAL "" .
DEFINE VAR np_driver AS CHAR FORMAT "x(50)" INIT "".   /*driver policynew */
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO                       
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""               
/*2*/  FIELD lnumber    AS INTEGER                               
       FIELD ltext      AS CHARACTER    INITIAL ""               
       FIELD ltext2     AS CHARACTER    INITIAL "" .             
/*--- A59-0029------*/
/*-- Add ranu A61-0269 --*/
DEF NEW  SHARED VAR nv_pdprm0   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0  . 
DEFINE new  SHARED VAR nv_totlcod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR nv_totlprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_totlvar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_totlvar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_totlvar  AS CHAR  FORMAT "X(60)".
DEFINE new  SHARED VAR nv_44prm    AS INTEGER   FORMAT ">,>>>,>>9"  INITIAL 0 NO-UNDO.
DEFINE new  SHARED VAR nv_supecod  AS CHAR  FORMAT "X(4)".
DEFINE new  SHARED VAR nv_supeprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_supevar1 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar2 AS CHAR  FORMAT "X(30)".
DEFINE new  SHARED VAR nv_supevar  AS CHAR  FORMAT "X(60)".
DEFINE new  SHARED VAR nv_supe00   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_baseprm3 AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_sicod3   AS CHARACTER FORMAT "X(4)".
DEFINE new  SHARED VAR  nv_prem3    AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE new  SHARED VAR  nv_usecod3  AS CHARACTER FORMAT "X(4)".
DEFINE new  SHARED VAR  nv_prvprm3  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_useprm3  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR  nv_siprm3   AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE new  SHARED VAR nv_44cod1      AS CHAR    FORMAT "X(4)".
DEFINE new  SHARED VAR nv_44cod2      AS CHAR    FORMAT "X(4)".
DEFINE new  SHARED VAR nv_44          AS INTE    FORMAT ">>>,>>>,>>9".
DEFINE new  SHARED VAR nv_413prm      AS DECI    FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR nv_413var1     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_413var2     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_413var      AS CHAR    FORMAT "X(60)".
DEFINE new  SHARED VAR nv_414prm      AS DECI    FORMAT ">,>>>,>>9.99".
DEFINE new  SHARED VAR nv_414var1     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_414var2     AS CHAR    FORMAT "X(30)".
DEFINE new  SHARED VAR nv_414var      AS CHAR    FORMAT "X(60)".
def var nv_usevar4   as char format "x(60)" init "".
def var nv_usevar5   as char format "x(60)" init "".
DEF VAR nv_usevar3   AS CHAR FORMAT "x(60)" INIT "" .
DEF VAR nv_basecod3  AS CHAR FORMAT "x(60)" INIT "" .
def var nv_basevar3  as char format "x(60)" init "" .
def var nv_basevar4  as char format "x(60)" init "" .
def var nv_basevar5  as char format "x(60)" init "" .
def var nv_sivar4    as char format "x(60)" init "" .             
def var nv_sivar5    as char format "x(60)" init "" . 
DEF VAR nv_sivar3    as char format "x(60)" init "" . 
def var nv_clmvar1   as char format "x(60)" init "" . 
def var nv_clmvar2   as char format "x(60)" init "" . 
/*-- End ranu A61-0269--*/
DEF VAR nv_chkerror  AS CHAR FORMAT "x(150)" INIT "".  /*Add by Kridtiya i. A63-0472*/ 


/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEFINE VAR nv_yrmanu  AS INTE FORMAT "9999".

DEFINE VAR nv_vehgrp  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_access  AS CHAR FORMAT "X(3)".
DEFINE VAR nv_supe    AS LOGICAL.
DEFINE VAR nv_totfi   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi1si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tpbi2si AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_tppdsi  AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_411si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_412si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_413si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_414si   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_42si    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_43si    AS DECI FORMAT ">>>,>>>,>>9.99-".

DEFINE VAR nv_ncbp    AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_fletp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dspcp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_dstfp   AS DECI FORMAT ">,>>9.99-".
DEFINE VAR nv_clmp    AS DECI FORMAT ">,>>9.99-".

DEFINE VAR nv_netprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_gapprem AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_flagprm AS CHAR FORMAT "X(2)". /* N=Net,G=Gross */

DEFINE VAR nv_effdat  AS DATE FORMAT "99/99/9999".

DEFINE VAR nv_ratatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_siatt     AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_netatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fltatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_ncbatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_dscatt    AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fcctv     AS LOGICAL . 
define var nv_uom1_c    as char .
define var nv_uom2_c    as char .
define var nv_uom5_c    as char .
DEFINE VAR nv_41prmt    AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt    AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt    AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem    AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status    AS CHAR .     /*fleet YES=Complete , NO=Not Complete */
DEFINE VAR nv_color     AS CHAR .
/* end A64-0138 */

