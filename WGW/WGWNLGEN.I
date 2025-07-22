/*------------------------------------------------
SubProgram : WGWNLGEN.I
Modify By : Porntiwa T. A59-0423  28/09/2016  
Duplicate Program : WGWMCGEN.I   
Modify By : Chaiyong W. A59-0614  15/12/2016  
add pay code
Modify By : Chaiyong W. A61-0016  15/11/2018  
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by  : Ranu I. A64-0247 เพิ่มตัวแปรเก็บข้อมูลผลตรวจสภาพ */
/*Modify by  : Ranu I. A64-0138 เพิ่มตัวแปรการคำนวณเบี้ย */
/*Modify by  : Kridtiya i. A65-0125 Date 01/05/2022 add Claimdi to Product */
/*Modify by : Ranu I. A65-0203 เพิ่มตัวแปรเก็บค่าจากพารามิเตอร์ */
/*Modify By : Porntiwa T.  A67-0029  14/05/2024
           : Edit Program for Support EV New Tariff*/
--------------------------------------------------*/  
/*-- Add A67-0029 --*/
DEFINE NEW SHARED WORKFILE wexcel NO-UNDO
    FIELD newpol    AS CHAR INIT ""
    FIELD trndat    AS CHAR
    FIELD comins    AS CHAR
    FIELD cedpol    AS CHAR
    FIELD ntitle    AS CHAR
    FIELD fname     AS CHAR
    FIELD lname     AS CHAR
    FIELD icno      AS CHAR
    FIELD bridat    AS CHAR FORMAT "X(10)"
    FIELD modcod    AS CHAR
    FIELD makdes    AS CHAR
    FIELD moddes    AS CHAR
    FIELD sclass    AS CHAR
    FIELD garage    AS CHAR
    FIELD vehreg    AS CHAR
    FIELD provin    AS CHAR
    FIELD cha_no    AS CHAR
    FIELD eng_no    AS CHAR
    FIELD engine    AS CHAR
    FIELD gwv       AS CHAR
    FIELD body      AS CHAR
    FIELD yrmanu    AS CHAR
    FIELD addr1     AS CHAR
    FIELD addr2     AS CHAR
    FIELD addr3     AS CHAR
    FIELD addr4     AS CHAR
    FIELD postcod   AS CHAR
    FIELD driname   AS CHAR
    FIELD drinam1   AS CHAR
    FIELD drino1    AS CHAR
    FIELD dribir1   AS CHAR
    FIELD drinam2   AS CHAR
    FIELD drino2    AS CHAR
    FIELD dribir2   AS CHAR
    FIELD drinam3   AS CHAR
    FIELD drino3    AS CHAR
    FIELD dribir3   AS CHAR
    FIELD drinam4   AS CHAR
    FIELD drino4    AS CHAR
    FIELD dribir4   AS CHAR
    FIELD drinam5   AS CHAR
    FIELD drino5    AS CHAR
    FIELD dribir5   AS CHAR
    FIELD si        AS CHAR
    FIELD dedpd     AS INTE FORMAT "->>>>>>9"
    FIELD dedtp     AS INTE FORMAT "->>>>>>9"
    FIELD covcod    AS CHAR
    FIELD comdat    AS CHAR
    FIELD expdat    AS CHAR
    FIELD netprm    AS CHAR
    FIELD tax       AS CHAR
    FIELD vat       AS CHAR
    FIELD totprm    AS CHAR
    FIELD bennam    AS CHAR
    FIELD brncod    AS CHAR
    FIELD brnnam    AS CHAR
    FIELD btitle    AS CHAR FORMAT "X(50)"
    FIELD bfname    AS CHAR FORMAT "X(60)"
    FIELD blname    AS CHAR FORMAT "X(60)"
    FIELD baddr1    AS CHAR
    FIELD baddr2    AS CHAR
    FIELD baddr3    AS CHAR
    FIELD baddr4    AS CHAR
    FIELD bpostcod  AS CHAR
    FIELD instyp    AS CHAR
    FIELD custyp    AS CHAR
    FIELD prmtyp    AS CHAR
    FIELD quotyp    AS CHAR
    FIELD paycod    AS CHAR INIT ""
    FIELD campaign  AS CHAR
    FIELD budcmi    AS CHAR
    FIELD cmicdat   AS DATE FORMAT 99/99/9999
    FIELD cmiedat   AS DATE FORMAT 99/99/9999
    FIELD cmiprm    AS DECI
    FIELD carcol    AS CHAR FORMAT "X(50)"
    FIELD pacref    AS CHAR FORMAT "X(20)"
    FIELD isp       AS CHAR INIT ""
    FIELD f7        AS CHAR INIT "" 
    FIELD f8        AS CHAR INIT "" 
    FIELD prvpol    AS CHAR INIT ""
    FIELD oldexpdat AS CHAR INIT ""
    FIELD oldname   AS CHAR INIT ""
    FIELD oldacno   AS CHAR INIT ""
    FIELD acnocode  AS CHAR INIT ""
    FIELD tacc1     AS CHAR INIT ""
    FIELD tacc2     AS CHAR INIT ""
    FIELD tacc3     AS CHAR INIT ""
    FIELD tacc4     AS CHAR INIT ""
    FIELD tacc5     AS CHAR INIT ""

    FIELD werror      AS CHAR               
    FIELD wmark       AS LOGICAL INIT YES   
    FIELD trareg      AS CHAR               
    FIELD policy      AS CHAR                             
    FIELD driage1     AS INTE               
    FIELD driage2     AS INTE
    FIELD driage3     AS INTE
    FIELD driage4     AS INTE
    FIELD driage5     AS INTE
    FIELD brnsty      AS CHAR  
    FIELD vehuse      AS CHAR                
    FIELD seat        AS CHAR                
    FIELD vehgrp      AS CHAR                
    FIELD inspec      AS CHAR                
    FIELD agent       AS CHAR FORMAT "X(10)" 
    FIELD broker      AS CHAR FORMAT "X(10)" 
    FIELD pack        AS CHAR 
    FIELD modelRB     AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD prmexp      AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD cha_old     AS CHAR FORMAT "x(25)"  INIT "" 
    FIELD remark      AS CHAR FORMAT "x(225)" INIT ""
    FIELD financecd   AS CHAR FORMAT "x(60)"  INIT ""
    FIELD firstName   AS CHAR FORMAT "x(60)"  INIT ""
    FIELD lastName    AS CHAR FORMAT "x(60)"  INIT ""
    FIELD postcd      AS CHAR FORMAT "x(15)"  INIT ""
    FIELD codeocc     AS CHAR FORMAT "x(4)"   INIT ""
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"   INIT ""
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"   INIT ""
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"   INIT ""
    FIELD br_insured  AS CHAR FORMAT "x(5)"   INIT ""
    FIELD campaign_ov AS CHAR FORMAT "x(30)"  INIT ""
    FIELD insnamtyp   AS CHAR FORMAT "x(60)"  INIT ""
    FIELD product     AS CHAR FORMAT "x(30)"  INIT ""
    FIELD txttmp1     AS CHAR FORMAT "X(80)"  INIT ""
    FIELD txttmp2     AS CHAR FORMAT "X(80)"  INIT ""
    FIELD txttmp3     AS CHAR FORMAT "X(80)"  INIT ""
    FIELD txttmp4     AS CHAR FORMAT "X(80)"  INIT ""
    FIELD txttmp5     AS CHAR FORMAT "X(80)"  INIT ""
    FIELD txttmp6     AS CHAR FORMAT "X(80)"  INIT ""
    FIELD txttmp7     AS CHAR FORMAT "X(80)"  INIT ""
    FIELD evflg       AS LOGICAL
    FIELD cstw        AS DECI
    FIELD fcst        AS CHAR
    .
/*-- End Add A67-0029 --*/

/*-- Comment A67-0029 --
DEFINE NEW SHARED WORKFILE wexcel NO-UNDO
    FIELD trndat    AS CHAR
    FIELD comins    AS CHAR
    FIELD cedpol    AS CHAR
    FIELD ntitle    AS CHAR
    FIELD fname     AS CHAR
    FIELD lname     AS CHAR
    FIELD icno      AS CHAR
    FIELD makdes    AS CHAR
    FIELD moddes    AS CHAR
    FIELD sclass    AS CHAR
    FIELD garage    AS CHAR
    FIELD vehreg    AS CHAR
    FIELD provin    AS CHAR
    FIELD cha_no    AS CHAR
    FIELD eng_no    AS CHAR
    FIELD engine    AS CHAR
    FIELD gwv       AS CHAR
    FIELD body      AS CHAR
    FIELD yrmanu    AS CHAR
    FIELD addr1     AS CHAR
    FIELD addr2     AS CHAR
    FIELD addr3     AS CHAR
    FIELD addr4     AS CHAR
    FIELD postcod   AS CHAR
    FIELD driname   AS CHAR
    FIELD drinam1   AS CHAR
    FIELD drino1    AS CHAR
    FIELD dribir1   AS CHAR
    FIELD drinam2   AS CHAR
    FIELD drino2    AS CHAR
    FIELD dribir2   AS CHAR
    FIELD si        AS CHAR
    FIELD covcod    AS CHAR
    FIELD comdat    AS CHAR
    FIELD expdat    AS CHAR
    FIELD netprm    AS CHAR
    FIELD tax       AS CHAR
    FIELD vat       AS CHAR
    FIELD totprm    AS CHAR
    FIELD bennam    AS CHAR
    FIELD brncod    AS CHAR
    FIELD brnnam    AS CHAR
    FIELD baddr1    AS CHAR
    FIELD baddr2    AS CHAR
    FIELD baddr3    AS CHAR
    FIELD baddr4    AS CHAR
    FIELD bpostcod  AS CHAR
    FIELD instyp    AS CHAR
    FIELD custyp    AS CHAR
    FIELD quotyp    AS CHAR
    FIELD werror    AS CHAR
    FIELD wmark     AS LOGICAL INIT YES
    FIELD trareg    AS CHAR
    FIELD policy    AS CHAR
    FIELD modcod    AS CHAR
    FIELD driage1   AS INTE
    FIELD driage2   AS INTE
    FIELD brnsty    AS CHAR
    FIELD campaign  AS CHAR
    FIELD vehuse    AS CHAR
    FIELD seat      AS CHAR
    FIELD vehgrp    AS CHAR
    FIELD inspec    AS CHAR
    FIELD agent     AS CHAR FORMAT "X(10)"
    FIELD broker    AS CHAR FORMAT "X(10)"
    FIELD paycod    AS CHAR INIT ""   /*---add by Chaiyong W. A59-0614 27/12/2016*/
    /*---Begin by Chaiyong W. A59-0614 19/04/2017*/
    FIELD prvpol    AS CHAR INIT ""
    FIELD oldname   AS CHAR INIT ""
    FIELD oldexpdat AS CHAR INIT ""
    FIELD oldacno   AS CHAR INIT ""
    FIELD acnocode  AS CHAR INIT ""
    FIELD newpol    AS CHAR INIT ""
    FIELD tacc1     AS CHAR INIT ""
    FIELD tacc2     AS CHAR INIT ""
    FIELD tacc3     AS CHAR INIT ""
    FIELD tacc4     AS CHAR INIT ""
    FIELD tacc5     AS CHAR INIT ""
    FIELD isp       AS CHAR INIT ""
    /*End by Chaiyong W. A59-0614 19/04/2017-----*/
    FIELD f7        AS CHAR INIT ""   /*---add by Chaiyong W. A61-0016 15/01/2018*/
    FIELD f8        AS CHAR INIT ""   /*---add by Chaiyong W. A61-0016 15/01/2018*/
    /*FIELD fleet     AS CHAR
    FIELD base1     AS CHAR
    FIELD base3     AS CHAR
    FIELD dspc      AS CHAR
    FIELD ncb       AS CHAR*/
    FIELD pack    AS CHAR  /* A65-0203*/
    field modelRB  as char format "x(25)" init ""  /*A64-0247*/
    field prmexp   as char format "x(10)" init ""  /*A64-0247*/
    FIELD cha_old  AS CHAR FORMAT "x(25)" INIT "" /*A64-0247*/
    FIELD remark   AS CHAR FORMAT "x(225)" INIT "" /*A64-0247*/
    FIELD financecd   AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD product     AS CHAR FORMAT "x(30)" INIT "".   /*Add by Kridtiya i. A65-0125 Date. 01/05/2022*/
-- End Comment A67-0029 --*/

DEF VAR nv_chkerror   AS CHAR FORMAT "x(250)" INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR nv_postcd     AS CHAR FORMAT "x(15)"  INIT "".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
     
/*---begin by Chaiyong W. A61-0015 15/01/2018*/
DEF VAR nv_stds AS LOGICAL INIT NO.
DEF VAR nv_deci AS DECI INIT 0.
DEF VAR nv_dncb AS DECI INIT 0.
DEF VAR nv_c132 AS INT  INIT 0.
/*end  by Chaiyong W. A61-0015 15/01/2018----*/
DEFINE WORKFILE wexcamp 
    FIELD policy AS CHAR
    FIELD campaign AS CHAR     /* A65-0203 */
    FIELD polmaster AS CHAR    /* A65-0203*/
    FIELD tp_bi1 AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD tp_bi2 AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD tp_pd  AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD sumins AS CHAR FORMAT "X(20)"
    FIELD sumfit AS CHAR FORMAT "X(20)"
    FIELD Prem_t AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD base1  AS CHAR FORMAT "X(20)"
    FIELD pa411  AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa412  AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa42   AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa43   AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD base3  AS CHAR FORMAT "X(20)"
    FIELD dedod  AS CHAR FORMAT "X(20)"
    FIELD deaod  AS CHAR FORMAT "X(20)"
    FIELD dedpd  AS CHAR FORMAT "X(20)"
    FIELD fleet  AS CHAR FORMAT "X(5)"
    FIELD ncbper AS CHAR FORMAT "X(5)"
    FIELD dspc   AS CHAR FORMAT "X(5)"
    FIELD staff  AS CHAR FORMAT "X(5)"
    FIELD loadcl AS CHAR FORMAT "X(10)"
    FIELD base2  AS CHAR FORMAT "X(20)"  /*---add Chaiyong W. A61-0015 15/02/2018----*/
    FIELD acc    AS CHAR . /* A65-0203 */

/*--
    FIELD mdat      AS CHAR FORMAT "X(8)"   /*เดือน*/
    FIELD ddat      AS CHAR FORMAT "X(4)"   /*วันที่*/
    FIELD brndel    AS CHAR FORMAT "X(8)"   /*สาขา*/
    FIELD brnare    AS CHAR FORMAT "X(8)"   /*Area*/
    FIELD covcod    AS CHAR FORMAT "X(5)"   /*ชั้น*/
    FIELD makdes    AS CHAR FORMAT "X(50)"  /*ยี่ห้อ*/
    FIELD moddes    AS CHAR FORMAT "X(50)"  /*รุ่น*/
    FIELD engine    AS CHAR FORMAT "X(10)"  /*CC.*/
    FIELD cha_no    AS CHAR FORMAT "X(40)"  /*เลขตัวถัง*/
    FIELD gwv       AS CHAR FORMAT "X(8)"   /*น้ำหนัก*/
    FIELD seat      AS CHAR FORMAT "X(5)"   /*Seat*/
    FIELD inspec    AS CHAR FORMAT "X(50)"  /*อุปกรณ์*/
    FIELD vehtyp    AS CHAR FORMAT "X(50)"  /*ประเภท*/
    FIELD vehuse    AS CHAR FORMAT "X(5)"   /*ลักษระการใช้รถ*/
    FIELD CLASS     AS CHAR FORMAT "X(5)"   /*Class*/
    FIELD yr        AS CHAR FORMAT "X(8)"   /*พ.ศ.*/
    FIELD yrmanu    AS CHAR FORMAT "X(8)"   /*ปีรถ*/
    FIELD vehreg    AS CHAR FORMAT "X(15)"  /*ทะเบียนรถ*/
    FIELD provin    AS CHAR FORMAT "X(40)"  /*จังหวัด*/
    FIELD sitot     AS CHAR FORMAT "X(20)"  /*ยอกจัด*/
    FIELD si        AS CHAR FORMAT "X(20)"  /*ทุนประกัน*/
    FIELD prem      AS CHAR FORMAT "X(20)"  /*ค่าเบี้ย(ไม่ พ.ร.บ.)*/
    FIELD garage    AS CHAR FORMAT "X(5)"   /*ซ่อม*/
    FIELD insure    AS CHAR FORMAT "X(10)"  /*บ.ประกัน*/
    FIELD broker    AS CHAR FORMAT "X(10)"  /*Broker*/
    FIELD confirm   AS CHAR FORMAT "X(5)"   /*ตกลง*/
    FIELD staff     AS CHAR FORMAT "X(10)"  /*Staff*/
    FIELD comdat    AS CHAR FORMAT "X(15)"  /*Comdat*/
    FIELD datto     AS CHAR FORMAT "X(5)"   /*to*/
    FIELD expdat    AS CHAR FORMAT "X(15)"  /*Expdat*/
    FIELD name1     AS CHAR FORMAT "X(100)" /*ผู้เอาประกัน*/
    FIELD addr1     AS CHAR FORMAT "X(60)"  /*Addr1*/
    FIELD addr2     AS CHAR FORMAT "X(60)"  /*Addr2*/
    FIELD addr3     AS CHAR FORMAT "X(60)"  /*Addr3*/
    FIELD addr4     AS CHAR FORMAT "X(60)"  /*Addr4*/
    FIELD postcod   AS CHAR FORMAT "X(10)"  /*รหัสไปรษณีย์*/
    FIELD icno      AS CHAR FORMAT "X(15)"  /*IDNO.*/
    FIELD bennam    AS CHAR FORMAT "X(80)"  /*ผุ้รับผลประโยนช์*/
    FIELD chknam    AS CHAR FORMAT "X(10)"  /*ผู้เซ็ค*/
    FIELD chkq      AS CHAR FORMAT "X(5)"   /*Q*/
    FIELD cedpol    AS CHAR FORMAT "X(16)"  /*เลขรับแจ้ง*/
    FIELD recnam    AS CHAR FORMAT "X(5)"   /*ผู้รับ*/
    FIELD campaign  AS CHAR FORMAT "X(20)"  /*Campaign Code*/
    FIELD titlemail AS CHAR FORMAT "X(60)"  /*หวัเมล์*/
    FIELD datrec    AS CHAR FORMAT "X(10)"  /*วันที่แจ้ง*/
    FIELD timrec    AS CHAR FORMAT "X(10)"  /*เวลาที่แจ้ง*/
    FIELD docnote   AS CHAR FORMAT "X(15)"  /*ISP*/
    .
--*/    
/*--
DEFINE NEW SHARED WORKFILE wuwm100 NO-UNDO
    FIELD poltyp    AS CHAR FORMAT "X(3)"
    FIELD brnno     AS CHAR FORMAT "X(2)"
    FIELD policy    AS CHAR FORMAT "X(16)"
    FIELD opnpol    AS CHAR FORMAT "X(20)"
    FIELD cr_1      AS CHAR FORMAT "X(20)"
    FIELD acno      AS CHAR FORMAT "X(10)"
    FIELD agent     AS CHAR FORMAT "X(10)"
    FIELD insref    AS CHAR FORMAT "X(10)"
    FIELD ntitle    AS CHAR FORMAT "X(25)"
    FIELD name1     AS CHAR FORMAT "X(100)"
    FIELD name2     AS CHAR FORMAT "X(100)"
    FIELD icno      AS CHAR FORMAT "X(20)"
    FIELD addr1     AS CHAR FORMAT "X(50)"
    FIELD addr2     AS CHAR FORMAT "X(50)"
    FIELD addr3     AS CHAR FORMAT "X(50)"
    FIELD addr4     AS CHAR FORMAT "X(50)"
    FIELD comdat    AS DATE FORMAT "99/99/9999"
    FIELD expdat    AS DATE FORMAT "99/99/9999"
    FIELD cedpol    AS CHAR FORMAT "X(20)"
    FIELD msg       AS CHAR
    FIELD mark      AS LOGICAL INIT NO
    FIELD campaign  AS CHAR FORMAT "X(20)"  /*Campaign Code*/
    FIELD titlemail AS CHAR FORMAT "X(60)"  /*หวัเมล์*/
    FIELD datrec    AS CHAR FORMAT "X(10)"  /*วันที่แจ้ง*/
    FIELD timrec    AS CHAR FORMAT "X(10)"  /*เวลาที่แจ้ง*/
    FIELD docnote   AS CHAR FORMAT "X(15)"  /*ISP*/
    FIELD staff     AS CHAR FORMAT "X(30)"
    FIELD brnntl    AS CHAR FORMAT "X(30)"  /*Branch NTL*/
    .

DEFINE NEW SHARED WORKFILE wuwm301 NO-UNDO
    FIELD policy AS CHAR FORMAT "X(16)"
    FIELD modcod AS CHAR FORMAT "X(8)"
    FIELD sclass AS CHAR FORMAT "X(5)"
    FIELD makdes AS CHAR FORMAT "X(20)"
    FIELD moddes AS CHAR FORMAT "X(100)"
    FIELD manuyr AS CHAR FORMAT "X(4)"
    FIELD vehgrp AS CHAR FORMAT "X(2)"
    FIELD body   AS CHAR FORMAT "X(30)"
    FIELD engine AS CHAR FORMAT "X(8)"
    FIELD tons   AS CHAR FORMAT "X(8)"
    FIELD seat   AS CHAR FORMAT "X(3)"
    FIELD vehuse AS CHAR FORMAT "X(5)"
    FIELD covcod AS CHAR FORMAT "X(5)"
    FIELD garage AS CHAR FORMAT "X(1)"
    FIELD vehreg AS CHAR FORMAT "X(12)"
    FIELD cha_no AS CHAR FORMAT "X(30)"
    FIELD eng_no AS CHAR FORMAT "X(30)"
    FIELD tp_bi1 AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD tp_bi2 AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD tp_pd  AS INTE FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD sumins AS CHAR FORMAT "X(20)"
    FIELD sumfit AS CHAR FORMAT "X(20)"
    FIELD Prem_t AS DECI FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD base1  AS CHAR FORMAT "X(20)"
    FIELD pa411  AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa412  AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa42   AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD pa43   AS INTE FORMAT ">>,>>>,>>>,>>9-"
    FIELD base3  AS CHAR FORMAT "X(20)"
    FIELD dedod  AS CHAR FORMAT "X(20)"
    FIELD deaod  AS CHAR FORMAT "X(20)"
    FIELD dedpd  AS CHAR FORMAT "X(20)"
    FIELD fleet  AS CHAR FORMAT "X(3)"
    FIELD ncbper AS CHAR FORMAT "X(3)"
    FIELD dspc   AS CHAR FORMAT "X(3)"
    FIELD staff  AS CHAR FORMAT "X(3)"
    FIELD loadcl AS CHAR FORMAT "X(10)"
    FIELD benanm AS CHAR FORMAT "X(50)"
    FIELD inspec AS CHAR FORMAT "X(60)"
    .
--*/

DEF NEW SHARED WORKFILE wk_uwd132 NO-UNDO     
  FIELD policy   LIKE sic_bran.uwd132.policy
  FIELD rencnt   LIKE sic_bran.uwd132.rencnt  
  FIELD endcnt   LIKE sic_bran.uwd132.endcnt  
  FIELD riskgp   LIKE sic_bran.uwd132.riskgp  
  FIELD riskno   LIKE sic_bran.uwd132.riskno  
  FIELD itemno   LIKE sic_bran.uwd132.itemno  
  FIELD bchyr    LIKE sic_bran.uwd132.bchyr
  FIELD bchno    LIKE sic_bran.uwd132.bchno
  FIELD bchcnt   LIKE sic_bran.uwd132.bchcnt
  FIELD rateae   LIKE sic_bran.uwd132.rateae  
  FIELD bencod   LIKE sic_bran.uwd132.bencod  
  FIELD gap_ae   LIKE sic_bran.uwd132.gap_ae  
  FIELD gap_c    LIKE sic_bran.uwd132.gap_c   
  FIELD pd_aep   LIKE sic_bran.uwd132.pd_aep  
  FIELD prem_c   LIKE sic_bran.uwd132.prem_c      
  FIELD benvar   LIKE sic_bran.uwd132.benvar
  FIELD rate     LIKE sic_bran.uwd132.rate
  FIELD line     AS INTEGER FORMAT "999"  .

DEFINE BUFFER wf_uwd132 FOR sic_bran.uwd132.

DEF NEW SHARED VAR   nv_drivno   AS INT       .
DEF NEW SHARED VAR   nv_drivcod  AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_drivprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_drivvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_drivvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_drivvar  AS CHAR  FORMAT "X(60)".
/*------usecod--------------------*/
DEF NEW SHARED VAR   nv_usecod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_useprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_usevar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_usevar   AS CHAR  FORMAT "X(60)".
/*----------nv_sicod--------------*/
DEF NEW SHARED VAR   nv_sicod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_siprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_sivar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_sivar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_sivar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR   nv_uom6_c  AS CHAR.      /* Sum  si*/
DEF NEW SHARED VAR   nv_uom7_c  AS CHAR.      /* Fire/Theft*/
/*------------nv_bipcod-------------*/
DEF NEW SHARED VAR   nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_bipprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_bipvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_bipvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_bipvar  AS CHAR  FORMAT "X(60)".
/*------------nv_biacod----------*/
DEF NEW SHARED VAR   nv_biacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_biaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_biavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_biavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_biavar   AS CHAR  FORMAT "X(60)".
/*------------nv_pdacod------------*/
DEF NEW SHARED VAR   nv_pdacod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_pdaprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR   nv_pdavar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_pdavar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR   nv_pdavar   AS CHAR  FORMAT "X(60)".
/*---------- usoper ------------*/
DEF NEW SHARED VAR nv_engine LIKE sicsyac.xmm102.engine.
DEF NEW SHARED VAR nv_tons   LIKE sicsyac.xmm102.tons.
DEF NEW SHARED VAR nv_seats  LIKE sicsyac.xmm102.seats.
DEF NEW SHARED VAR nv_sclass  AS CHAR FORMAT "x(3)".
DEF NEW SHARED VAR nv_engcod  AS CHAR FORMAT "x(4)".
DEF NEW SHARED VAR nv_engprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_engvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_engvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_engvar  AS CHAR  FORMAT "X(60)".

DEF NEW  SHARED VAR  nv_gapprm  AS DECI    FORMAT ">>>,>>>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_gapprm1 AS DECI    FORMAT ">>>,>>>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_pdprm   AS DECI    FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_prvprm  AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR  nv_41prm   AS INTEGER FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.

DEF NEW  SHARED VAR  nv_ded1prm  AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_aded1prm AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_ded2prm  AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_dedod    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_addod    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_dedpd    AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_prem1    AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_addprm   AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_totded   AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR  nv_totdis   AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.

DEF NEW  SHARED VAR   nv_41       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_41cod1   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_41cod2   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_411      AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_411prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_412prm   AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_411var1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_411var2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_411var   AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_412      AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_412var1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_412var2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_412var   AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_42cod    AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_42       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_42prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_42var1   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_42var2   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_42var    AS CHAR      FORMAT "X(60)".
DEF NEW  SHARED VAR   nv_43cod    AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_43       AS INTEGER   FORMAT ">>>,>>>,>>9".
DEF NEW  SHARED VAR   nv_43prm    AS DECI      FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR   nv_43var1   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_43var2   AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_43var    AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_campcod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_camprem   AS DECI      FORMAT ">>>9".
DEF NEW  SHARED VAR   nv_campvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_campvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_campvar   AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_compcod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_compprm   AS DECI      FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_compvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_compvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_compvar   AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_basecod   AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_baseprm   AS DECI      FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF NEW  SHARED VAR   nv_basevar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_basevar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_basevar   AS CHAR      FORMAT "X(60)".
/******** load ***********/
DEF NEW  SHARED VAR   nv_cl_cod   AS CHAR       FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_cl_per   AS DECIMAL    FORMAT ">9.99".
DEF NEW  SHARED VAR   nv_lodclm   AS INTEGER    FORMAT ">>>,>>9.99-".
DEF             VAR   nv_lodclm1  AS INTEGER    FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_clmvar1  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_clmvar   AS CHAR       FORMAT "X(60)".
/*********** staff ***********/
DEF NEW  SHARED VAR   nv_stf_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_stf_per  AS DECIMAL   FORMAT ">9.99".
DEF NEW  SHARED VAR   nv_stf_amt  AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_stfvar1  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar2  AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_stfvar   AS CHAR      FORMAT "X(60)".
/*********** dsic ***********/
DEF NEW  SHARED VAR   nv_dss_cod  AS CHAR      FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_dss_per  AS DECIMAL   FORMAT ">9.99".
DEF NEW  SHARED VAR   nv_dsspc    AS INTEGER   FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR   nv_dsspcvar1 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_dsspcvar2 AS CHAR     FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_dsspcvar  AS CHAR     FORMAT "X(60)".
/*********** NCB ***********/
DEF NEW  SHARED VAR   nv_ncb_cod  AS CHAR  FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_ncbper   LIKE sicuw.uwm301.ncbper.
DEF NEW  SHARED VAR   nv_ncb      AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_ncb1     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_ncbvar1  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_ncbvar2  AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_ncbvar   AS CHAR  FORMAT "X(60)".
/***********fleet***********/
DEF NEW  SHARED VAR   nv_flet_cod AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_flet_per AS DECIMAL FORMAT ">>9".
DEF NEW  SHARED VAR   nv_flet     AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_fletvar1 AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_fletvar2 AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_fletvar  AS CHAR    FORMAT "X(60)".
/***********nv_comp***********/
DEF NEW  SHARED VAR  nv_vehuse LIKE sicuw.uwm301.vehuse.                 
DEF NEW  SHARED VAR  nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR  nv_grprm   AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR  nv_grpvar1 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR  nv_grpvar2 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR  nv_grpvar  AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_othcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR   nv_othprm  AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR   nv_othvar1 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar2 AS CHAR      FORMAT "X(30)".
DEF NEW  SHARED VAR   nv_othvar  AS CHAR      FORMAT "X(60)".

DEF NEW  SHARED VAR   nv_dedod1_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod1_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod1var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod1var  AS CHAR   FORMAT "X(60)".            
                                                                        
DEF NEW  SHARED VAR   nv_dedod2_cod AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedod2_prm AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedod2var1 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var2 AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedod2var  AS CHAR   FORMAT "X(60)".            
                                                                     
DEF NEW  SHARED VAR   nv_dedpd_cod  AS CHAR   FORMAT "X(4)".             
DEF NEW  SHARED VAR   nv_dedpd_prm  AS DECI   FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR   nv_dedpdvar1  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar2  AS CHAR   FORMAT "X(30)".            
DEF NEW  SHARED VAR   nv_dedpdvar   AS CHAR   FORMAT "X(60)".   

/*********usfbas************/
DEF NEW SHARED VAR nv_tariff  LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_covcod  LIKE sicuw.uwm301.covcod.
DEF NEW SHARED VAR nv_key_b   AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
/*--- Year ----*/
DEF NEW SHARED VAR nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_yrvar1  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar2  AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_yrvar   AS CHAR  FORMAT "X(60)".
DEF NEW SHARED VAR nv_caryr   AS INTE  FORMAT ">>>9" .

DEF NEW SHARED VAR nv_seat41  AS INTEGER FORMAT ">>9".
DEF NEW SHARED VAR nv_moddes  AS CHAR.
DEF NEW SHARED VAR nv_moddes1 AS CHAR.
DEF NEW SHARED VAR nv_cargrp  AS CHAR.

DEFINE VAR nv_bipp00     AS DECI FORMAT ">>,>>>,>>9.99-". 
DEFINE VAR nv_bipa00     AS DECI FORMAT ">>,>>>,>>9.99-". 
DEFINE VAR nv_bipd00     AS DECI FORMAT ">>,>>>,>>9.99-". 
DEFINE VAR nv_ncbyrs     AS INTE.
DEFINE VAR nv_simat      AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_simat1     AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_maxdes     AS CHAR.
DEFINE VAR nv_mindes     AS CHAR.
DEFINE VAR nv_si         AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI      AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI      AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */

DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line        AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt         AS CHARACTER FORMAT "X(78)"   INITIAL "".

DEFINE VAR nv_line1         AS INTEGER                    INITIAL 0   NO-UNDO.
DEFINE VAR nv_txt1          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt9          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt10         AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt11         AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt12         AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR n_rencnt         LIKE sicuw.uwm100.rencnt .
DEFINE VAR nv_index         AS INT  INIT  0. 
DEFINE VAR n_endcnt         LIKE sicuw.uwm100.endcnt.

DEFINE NEW SHARED VAR nv_line          AS INTE                              INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_delimiter     AS LOGI                                          NO-UNDO.
DEFINE NEW SHARED VAR nv_delimitxt     AS CHAR      FORMAT "X(25)"          INIT ""     NO-UNDO.
                                                    
DEFINE NEW SHARED VAR nv_chr           AS CHAR      FORMAT "X(01)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR sh_policy2       AS CHAR      FORMAT "X(16)"          INIT ""     NO-UNDO.
                                       
DEFINE NEW SHARED VAR nv_text1         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text2         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text3         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text4         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text5         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text6         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_vehreg        AS CHAR      FORMAT "X(12)"          INIT ""     NO-UNDO.

DEFINE NEW SHARED VAR sh_policy        AS CHAR      FORMAT "X(16)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_tiname        AS CHAR      FORMAT "X(70)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_name          AS CHAR      FORMAT "X(70)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR1         AS CHAR      FORMAT "X(35)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR2         AS CHAR      FORMAT "X(35)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR3         AS CHAR      FORMAT "X(35)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR4         AS CHAR      FORMAT "X(20)"          INIT ""     NO-UNDO.
                                       
DEFINE NEW SHARED VAR nv_trndat        AS DATE      FORMAT "99/99/9999"     INIT TODAY  NO-UNDO.
DEFINE NEW SHARED VAR nv_comdat        AS DATE      FORMAT "99/99/9999"                 NO-UNDO.
DEFINE NEW SHARED VAR nv_expdat        AS DATE      FORMAT "99/99/9999"                 NO-UNDO.
                                       
DEFINE NEW SHARED VAR nv_total         AS DECI      FORMAT ">>>,>>>,>>9.99" INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_count         AS INTE                              INIT 0      NO-UNDO.


DEFINE NEW SHARED VAR nv_data          AS CHAR      FORMAT "X(40)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_notdata       AS CHAR      FORMAT "X(40)"          INIT ""     NO-UNDO.
                                                                                        
DEFINE NEW SHARED VAR nv_rencnt        AS INTE      FORMAT "99"             INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_endcnt        AS INTE      FORMAT "999"            INIT 0      NO-UNDO.
                                                                                        
DEFINE NEW SHARED VAR nv_branch        AS CHAR      FORMAT "X(02)"          INIT ""     NO-UNDO.

DEFINE NEW SHARED VAR nv_com1p         AS DECI                              INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_com1_t        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_prem_t        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_stamp         AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_tax           AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.

DEFINE NEW SHARED VAR nv_undyr         AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_poltyp        AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_sticker       AS INTE      FORMAT "9999999999999".  /*a51-0253*/
DEFINE NEW SHARED VAR nv_sticker1      AS CHAR      FORMAT "X(15)"          INIT ""     NO-UNDO. /*Note Ad on A50-0097 11/05/2007*/ /*a51-0253*/
                                                                                        
DEFINE NEW SHARED VAR nv_insname1      AS CHAR      FORMAT "X(70)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_title         AS CHAR      FORMAT "X(15)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_insref        AS CHAR      FORMAT "X(7)"           INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_acno1         AS CHAR      FORMAT "X(07)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_agent         AS CHAR      FORMAT "X(07)"          INIT ""     NO-UNDO.
                                                                                        
DEFINE NEW SHARED VAR nv_class         AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_modcod        AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.

DEFINE NEW SHARED VAR nv_sity_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_pdst_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_pdty_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_cost_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.

DEFINE NEW SHARED VAR nv_uom8_c        AS CHAR      FORMAT "X(2)"           INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_uom9_c        AS CHAR      FORMAT "X(2)"           INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_uom8_v        AS DECI      FORMAT ">>>,>>>,>>9.99" INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_uom9_v        AS DECI      FORMAT ">>>,>>>,>>9.99" INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_opnpol        LIKE sicuw.uwm100.opnpol INIT "".
DEFINE NEW SHARED VAR nv_seqno         AS INT.
DEFINE NEW SHARED VAR nv_seqno2        AS INT.
DEFINE NEW SHARED VAR nv_makdes        AS CHAR    FORMAT "X(50)".
DEFINE NEW SHARED VAR n_check          AS CHAR.
DEFINE NEW SHARED VAR nv_typ           AS CHAR.
DEFINE NEW SHARED VAR nv_dept          AS CHAR    FORMAT  "X(1)".
DEFINE NEW SHARED VAR nv_polday        AS INTE    FORMAT ">>9".
DEFINE NEW SHARED VAR nv_subclass      AS CHAR    FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_uwm301trareg  LIKE sic_bran.uwm301.cha_no        INIT "".

DEFINE NEW SHARED VAR s_recid1         AS RECID .     /* uwm100  */
DEFINE NEW SHARED VAR s_recid2         AS RECID .     /* uwm120  */
DEFINE NEW SHARED VAR s_recid3         AS RECID .     /* uwm130  */  
DEFINE NEW SHARED VAR s_recid4         AS RECID .     /* uwm301  */

DEFINE NEW SHARED VAR n_recid301       AS RECID.
DEFINE NEW SHARED VAR n_recid130       AS RECID.
DEFINE VAR nv_body   AS CHAR FORMAT "X(20)".

DEFINE VAR nv_pol1    AS INTE.
DEFINE VAR nv_pol2    AS CHAR FORMAT "X(15)".
DEFINE VAR nv_pol3    AS INTE.
DEFINE VAR n_classtxt AS CHAR FORMAT "X(50)".

DEFINE VAR nv_pol70 AS INTE.
DEFINE VAR nv_pol72 AS INTE.

DEFINE VAR nv_si_max AS DECI FORMAT ">>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_si_min AS DECI FORMAT ">>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_devide AS INTEGER                     NO-UNDO.
DEFINE VAR nv_trareg AS CHAR.

DEFINE VAR nv_base_max AS INTE.
DEFINE VAR nv_base_min AS INTE.
DEFINE VAR nv_base_max_p AS INTE.
DEFINE VAR nv_base_min_p AS INTE.
DEFINE VAR nv_baseprm1 AS DECI FORMAT ">>>,>>>,>>>,>>9.99-". 
DEFINE VAR nv_baseprm2 AS DECI FORMAT ">>>,>>>,>>>,>>9.99-". 

DEFINE VAR nv_chkpa AS INTE INIT 0.
DEF NEW  SHARED VAR  nv_prem AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE VAR nv_bencod AS CHAR FORMAT "X(4)" INITIAL "".
DEFINE VAR nv_effdat AS DATE FORMAT "99/99/9999" .
DEFINE VAR nv_rate AS DECIMAL FORMAT ">>>9.99" INITIAL 0 NO-UNDO.
DEF NEW  SHARED VAR  nv_prvprm3  AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR  nv_prem3    AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE VAR nv_yr   AS INTEGER FORMAT ">9" INITIAL 0 NO-UNDO. /*
DEFINE VAR nv_usecod3   AS CHARACTER FORMAT "X(4)". comment A61-0015*/
DEFINE NEW SHARED VAR nv_usecod3   AS CHARACTER FORMAT "X(4)". /*--add a61-0015*/


DEFINE VAR nv_useprm3   AS DECI      FORMAT ">>,>>>,>>9.99-".

DEFINE VAR nv_si00   AS INTEGER FORMAT ">,>>>,>>>,>>9".
DEFINE VAR nv_si01   AS INTEGER FORMAT ">,>>>,>>>,>>9".
DEFINE VAR nv_bip00  AS INTEGER FORMAT ">,>>>,>>>,>>9". 
DEFINE VAR nv_bia00  AS INTEGER FORMAT ">,>>>,>>>,>>9".
DEFINE VAR nv_pd00   AS INTEGER FORMAT ">,>>>,>>>,>>9".

DEF NEW SHARED VAR   nv_sicod3   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR   nv_siprm3   AS DECI  FORMAT ">>,>>>,>>9.99-".

DEFINE VAR nv_supecod  AS CHAR  FORMAT "X(4)".
DEFINE VAR nv_supe00   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_supeprm  AS DECI  FORMAT ">>,>>>,>>9.99-".

DEFINE VAR nv_drivnam  AS INTE.

DEFINE NEW  SHARED VAR   nv_baseprm3    AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_basecod3    AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_basevar3    AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_basevar4    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_basevar5    AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar3     AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_usevar4     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_usevar5     AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar3      AS CHAR     FORMAT "X(60)".
DEFINE NEW  SHARED VAR   nv_sivar4      AS CHAR     FORMAT "X(30)".
DEFINE NEW  SHARED VAR   nv_sivar5      AS CHAR     FORMAT "X(30)".

DEFINE VAR nt_gapprm   AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE VAR nt_pdprm    AS DECI FORMAT ">>,>>>,>>9.99-"  INITIAL 0.
DEFINE VAR nv_adjgap   AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_adjpd    AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_adjvar   AS CHAR FORMAT "X(60)".
DEFINE VAR nv_gap      AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR nv_prem_c   AS INTEGER   INITIAL 0  NO-UNDO.
DEFINE VAR nv_benvar   AS CHARACTER         NO-UNDO.

DEFINE VAR n_policy    AS CHARACTER         NO-UNDO.
DEFINE VAR n_riskno   AS INTEGER           NO-UNDO.
DEFINE VAR n_itemno   AS INTEGER           NO-UNDO.
DEFINE VAR nv_bptr   AS RECID.

DEFINE           VAR  n_gap_r    LIKE  sic_bran.uwm120.gap_r.
DEFINE           VAR  n_prem_r   LIKE  sic_bran.uwm120.prem_r.
DEFINE           VAR  n_sigr_r   LIKE  sic_bran.uwm120.sigr.
DEFINE           VAR  n_gap_t    LIKE  sic_bran.uwm100.gap_p.
DEFINE           VAR  n_prem_t   LIKE  sic_bran.uwm100.prem_t.
DEFINE           VAR  n_sigr_t   LIKE  sic_bran.uwm100.sigr_p.
/*DEFINE           VAR  nv_com1p   LIKE  sic_bran.uwm120.com1p.*/
DEFINE           VAR  nt_compprm LIKE  sic_bran.uwm100.prem_t.

DEFINE VAR nv_acdes     AS   CHARACTER FORMAT "X(34)"         INITIAL "" NO-UNDO.
DEFINE VAR nv_com1_per  AS   DECIMAL   FORMAT ">9.99%"        INITIAL 0  NO-UNDO.
DEFINE VAR nv_com2_per  AS   DECIMAL   FORMAT ">9.99%"        INITIAL 0  NO-UNDO.

DEF VAR n_comm1  AS DECIMAL INIT 0.    /*default parameter*/
DEF VAR n_comm2  AS DECIMAL INIT 0.    /*default parameter*/
DEF VAR n_com1t  AS DECIMAL INIT 0.    /*Callculate comm*/
DEF VAR n_com2t  AS DECIMAL INIT 0.    /*Callculate comm*/
DEFINE VAR nv_tax_per   AS   DECIMAL   FORMAT ">9.99%"        INITIAL 0  NO-UNDO.
DEFINE VAR nv_stamp_per AS   DECIMAL   FORMAT ">9.99%"        INITIAL 0  NO-UNDO.
DEFINE VAR nv_duptrip   AS   CHARACTER                        INITIAL "" NO-UNDO.
DEFINE VAR nv_dup_trip  AS   CHARACTER FORMAT "X"             INITIAL "" NO-UNDO.
DEFINE VAR nv_com12_t   LIKE sic_bran.uwm100.com1_t.
DEFINE VAR nv_netprm    LIKE stat.polmst_fil.prem_t.
DEFINE VAR nv_age1     AS INTEGER   FORMAT ">9"            INITIAL 0  NO-UNDO.
DEFINE VAR nv_age2     AS INTEGER   FORMAT ">9"            INITIAL 0  NO-UNDO.
DEFINE VAR nv_drivcod1 AS CHAR      FORMAT "X(4)".
DEFINE VAR nv_drivcod2 AS CHAR      FORMAT "X(4)".
DEFINE VAR nv_age1rate AS DECI      FORMAT ">>9.99".
DEFINE VAR nv_age2rate AS DECI      FORMAT ">>9.99".
DEFINE             VAR nv_chkmail  AS CHARACTER FORMAT "X(30)" INITIAL "".

DEFINE VAR nt_count_pol AS INTE.
DEFINE VAR nv_msg AS CHAR.
DEFINE VAR nv_running AS INTE INIT 0.
DEFINE VAR nv_lencod AS INTE INIT 0.
DEFINE VAR nv_dripol1 AS CHAR.
DEFINE VAR nv_dripol2 AS CHAR.
DEFINE VAR nv_dribir1 AS CHAR.
DEFINE VAR nv_dribir2 AS CHAR.
DEFINE VAR nv_lnumber AS INTE.
DEFINE VAR nv_cc      AS CHAR.
DEFINE VAR  np_rencnt    AS INT  INIT   0.
DEFINE VAR  np_prepol    AS CHAR FORMAT "x(16)".
DEFINE VAR  np_branch    AS CHAR FORMAT "x(2)" .
DEFINE VAR  np_insref    AS CHAR FORMAT "x(10)".
DEFINE VAR  np_title     AS CHAR FORMAT "x(20)" .  
DEFINE VAR  np_name1     AS CHAR FORMAT "x(60)" .  
DEFINE VAR  np_name2     AS CHAR FORMAT "x(60)" .  
DEFINE VAR  np_name3     AS CHAR FORMAT "x(60)" .  
DEFINE VAR  np_addr1     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE VAR  np_addr2     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE VAR  np_addr3     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE VAR  np_addr4     AS CHAR FORMAT "x(35)" INIT "" .
DEFINE VAR  np_firstdat  AS CHAR FORMAT "x(10)" INIT "" .
DEFINE VAR  np_comdat    AS CHAR FORMAT "x(10)" INIT "" . 
DEFINE VAR  np_expdat    AS CHAR FORMAT "x(10)" INIT "" .
DEFINE VAR  np_class     AS CHAR FORMAT "x(4)"      .
DEFINE VAR  np_redbook   AS CHAR FORMAT "x(10)".
DEFINE VAR  np_moddes    AS CHAR FORMAT "x(65)".
DEFINE VAR  np_yrmanu    AS CHAR FORMAT "x(5)".   
DEFINE VAR  np_vehgrp    AS CHAR FORMAT "x"  .
DEFINE VAR  np_body      AS CHAR FORMAT "x(20)".  
DEFINE VAR  np_engine    AS CHAR FORMAT "x(30)".  
DEFINE VAR  np_tons      AS DECI FORMAT ">>,>>9.99-"  .  
DEFINE VAR  np_seats     AS CHAR FORMAT "x(2)"   INIT "" .  
DEFINE VAR  np_vehuse    AS CHAR FORMAT "x"      INIT "" .  
DEFINE VAR  np_covcod    AS CHAR FORMAT "x"      INIT "" .  
DEFINE VAR  np_garage    AS CHAR FORMAT "x"      INIT "" .
DEFINE VAR  np_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .
DEFINE VAR  np_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE VAR  np_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE VAR  np_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE VAR  np_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE VAR  np_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE VAR  np_si        AS CHAR FORMAT "x(30)"  INIT "" .
DEFINE VAR  np_baseprm   AS DECI FORMAT ">>>,>>>,>>9.99-"  .  
DEFINE VAR  np_41        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_42        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_43        AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_seat41    AS DECI FORMAT ">>,>>9.99-"   .
DEFINE VAR  np_dedod     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_addod     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_dedpd     AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_flet_per  AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE VAR  np_ncbper    AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE VAR  np_dss_per   AS CHAR FORMAT "x(30)"  INIT "" . 
DEFINE VAR  np_stf_per   AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_cl_per    AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  np_bennam1   AS CHAR FORMAT "x(60)"  INIT ""   . 
DEFINE NEW SHARED WORKFILE wuwd132
    FIELD prepol  AS CHAR FORMAT "x(20)" INIT ""
    FIELD bencod  AS CHAR FORMAT "x(30)" INIT "" 
    FIELD benvar  AS CHAR FORMAT "x(40)" INIT "" 
    FIELD gap_c   AS DECI FORMAT ">>>,>>>,>>9.99-"    
    FIELD prem_c  AS DECI FORMAT ">>>,>>>,>>9.99-"  . 

DEFINE VAR  gv_id         AS CHAR format "x(10)" INIT "".
DEFINE VAR  nv_pwd        AS CHAR format "x(20)" INIT "".
/*add by : A64-0247 */
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
DEF VAR nv_year          AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(250)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".
DEF VAR nv_date          AS CHAR FORMAT "x(15)".
/* end : A64-0247 */

/* add by : A64-0138 */
DEFINE NEW SHARED TEMP-TABLE wkuwd132 LIKE stat.pmuwd132.
DEF    VAR nv_cstflg  AS CHAR FORMAT "X(2)".     /*C=CC ; S=Seat ; T=Tons ; W=Watts*/  
DEFINE VAR nv_engcst  AS DECI FORMAT ">>>>>9.99".

DEFINE VAR nv_driage1 AS INTE FORMAT ">>9".
DEFINE VAR nv_driage2 AS INTE FORMAT ">>9".
DEF    VAR nv_pdprm0  AS DECI FORMAT ">>>,>>>,>>9.99-". /*เบี้ยผู้ขับขี่*/
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

DEFINE VAR nv_ratatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_siatt        AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_netatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fltatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_ncbatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_dscatt       AS DECI FORMAT ">>,>>>,>>9-".
DEFINE VAR nv_fcctv        AS LOGICAL . 
define var nv_uom1_c       as char .
define var nv_uom2_c       as char .
define var nv_uom5_c       as char .
/* end A64-0138 */
/* A65-0203 */
DEF VAR nv_status AS CHAR .
DEF VAR nv_message AS CHAR .
DEFINE VAR nv_totsi   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_mv411 AS DECIMAL.
DEFINE VAR nv_mv412 AS DECIMAL.
DEFINE VAR nv_mv42  AS DECIMAL.
DEFINE VAR nv_mv43  AS DECIMAL.
DEF    VAR nv_411t  AS DECIMAL.    
DEF    VAR nv_412t  AS DECIMAL.    
DEF    VAR nv_42t   AS DECIMAL.    
DEF    VAR nv_43t   AS DECIMAL.

DEFINE VAR nv_41prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */ 
DEFINE VAR nv_412prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */ 
DEFINE VAR nv_413prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_414prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_42prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */
DEFINE VAR nv_43prmt AS DECI FORMAT ">>>,>>>,>>9.99-".    /*add  26/01/2022 */

DEFINE var nv_ncbprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_fletprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dspcprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_dstfprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/
DEFINE var nv_clmprm   AS DECI FORMAT ">>>,>>>,>>9.99-".   /*add 28/01/2022*/

DEFINE VAR nv_pdprem  AS DECI FORMAT ">>>,>>>,>>9.99-". 
DEFINE VAR nv_flgsht  AS CHAR.  /* Short rate = "S" , Pro rate = "P" */ 

DEFINE VAR nv_attgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_fltgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_ncbgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_dscgap  AS DECI FORMAT ">>,>>>,>>9.99-".   /*add  26/01/2022 */ 
DEFINE VAR nv_packatt AS CHAR FORMAT "X(4)".             /*add  26/01/2022 */ 

DEFINE VAR  nv_campcd  AS CHAR FORMAT "X(40)".

DEFINE VAR nv_dodamt  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*New*/  /* DOD PREMIUM */
DEFINE VAR nv_dadamt  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*New*/  /* DOD1 PREMIUM */
DEFINE VAR nv_dpdamt  AS DECI FORMAT ">>>,>>>,>>9.99-".  /*New*/  /* DPD PREMIUM */

DEFINE VAR  nv_ncbamt  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* NCB PREMIUM */
DEFINE VAR  nv_fletamt AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* FLEET PREMIUM */
DEFINE VAR  nv_dspcamt AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* DSPC PREMIUM */
DEFINE VAR  nv_dstfamt AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* DSTF PREMIUM */
DEFINE VAR  nv_clmamt  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/  /* LOAD CLAIM PREMIUM */

DEFINE VAR nv_mainprm  AS DECI FORMAT ">>>,>>>,>>9.99-".   /*New*/ /* Main Premium หรือเบี้ยหลัก ช่อง Name/Unname Premium (HG) */

DEFINE VAR  nv_atfltgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* รยต.NCB Premium */
DEFINE VAR  nv_atncbgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* รยต.DSPC Premium */
DEFINE VAR  nv_atdscgap  AS DECI FORMAT ">>,>>>,>>9.99-".    /*New*/ /* Package DG00 */
/* end : A65-0203 */
/*-- Add A67-0029 --*/
DEFINE NEW SHARED VAR nv_battflg  AS CHAR FORMAT "X".
DEFINE NEW SHARED VAR nv_chargflg AS CHAR FORMAT "X".
DEFINE NEW SHARED VAR nv_engtxt   AS CHAR FORMAT "X(3)" INIT "HP:".
DEFINE NEW SHARED VAR nv_battper  AS DECI FORMAT ">>9.99".
DEFINE NEW SHARED VAR nv_battyr   AS INTE FORMAT "9999".
DEFINE NEW SHARED VAR nv_eng_no2  AS CHAR FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_evflg    AS LOGICAL.
DEFINE NEW SHARED VAR nv_msgr     AS CHAR.
DEFINE NEW SHARED VAR nv_levcod   AS INTE FORMAT ">9".
DEFINE NEW SHARED VAR nv_levper   AS DECI FORMAT ">>9.99-".
DEFINE NEW SHARED VAR nv_ckbatyr  AS DECI.
DEFINE NEW SHARED VAR nv_covcharg AS LOGICAL INIT NO.
DEFINE NEW SHARED VAR nv_chargno  AS CHAR FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_chargsi  AS INTE FORMAT ">>>,>>>,>>9".
DEFINE NEW SHARED VAR nv_ratcharg AS DECI FORMAT ">>9.9999-".
DEFINE NEW SHARED VAR nv_prmcharg AS DECI FORMAT ">>>>>>9.99-".
DEFINE NEW SHARED VAR nv_covbatt  AS LOGICAL INIT NO.
DEFINE NEW SHARED VAR nv_battno   AS CHAR FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_battsi   AS INTE FORMAT ">>>,>>>,>>9".
DEFINE NEW SHARED VAR nv_ratbatt  AS DECI FORMAT ">>9.9999-".
DEFINE NEW SHARED VAR nv_prmbatt  AS DECI FORMAT ">>>>>>9.99-".
DEFINE NEW SHARED VAR nv_battprice AS INTE FORMAT ">>>,>>>,>>9".

DEFINE NEW SHARED VAR nv_gapchargprm AS DECI FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_pdchargprm  AS DECI FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_gapbattgprm AS DECI FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_pdbattgprm  AS DECI FORMAT ">>>,>>9.99-".

DEFINE NEW SHARED VAR nv_ngprmcharg  AS DECI FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_npprmcharg  AS DECI FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_chkfr       AS LOGICAL INIT NO.

DEFINE NEW SHARED VAR nv_chagvar     AS CHAR FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_chagvar1    AS CHAR FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_chagvar2    AS CHAR FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_battvar     AS CHAR FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_battvar1    AS CHAR FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_battvar2    AS CHAR FORMAT "X(30)".

DEFINE NEW SHARED VAR nv_adjpa       AS LOGICAL.
DEFINE NEW SHARED VAR mv_411prm      AS DECI  FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR mv_412prm      AS DECI  FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR mv_413prm      AS DECI  FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR mv_414prm      AS DECI  FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR mv_42prm       AS DECI  FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR mv_43prm       AS DECI  FORMAT ">,>>>,>>9.99".

DEFINE VAR nv_si_mv AS INTE FORMAT ">>>,>>>,>>9".
DEFINE VAR n_text2  AS CHAR FORMAT "x(11)"         INITIAL["F26 EV Att."].
DEFINE VAR n_txtev  AS CHAR FORMAT "X(30)".

DEFINE VAR nv_age3    AS INTEGER FORMAT ">9" INITIAL 0 NO-UNDO.
DEFINE VAR nv_age4    AS INTEGER FORMAT ">9" INITIAL 0 NO-UNDO.
DEFINE VAR nv_age5    AS INTEGER FORMAT ">9" INITIAL 0 NO-UNDO.
DEFINE VAR nv_dribir3 AS CHAR.
DEFINE VAR nv_dribir4 AS CHAR.
DEFINE VAR nv_dribir5 AS CHAR.
DEFINE VAR nv_mailpol AS CHAR FORMAT "X(30)".

DEFINE VAR nv_riskgp     AS INTE.
DEFINE VAR nv_riskno     AS INTE.
DEFINE VAR nv_itemno     AS INTE.
DEFINE VAR nv_diffprm    AS INTE.
DEFINE VAR nv_newpdprm   AS DECI FORMAT ">>>,>>>,>>9.99-".  /*เบี้ยไม่เต็มปี*/
DEFINE VAR nv_newgpprm   AS DECI FORMAT ">>>,>>>,>>9.99-".  /*เบี้ยเต็มปี*/
DEFINE VAR nv_adjpaprm   AS LOGICAL.  /*Adjust PA Premium : Yes/No*/
DEFINE VAR nv_adjprem    AS LOGICAL.  /*Adjust Premium : Yes/No*/
DEFINE VAR nv_flgpol     AS CHAR.     /*NR=New RedPlate, NU=New Used Car, RN=Renew*/
DEFINE VAR nv_flgclm     AS CHAR.     /*NC=NO CLAIM , WC=With Claim*/
                         
DEFINE VAR cv_lfletper   AS DECI FORMAT ">,>>9.99-".  /*Limit Fleet %*/
DEFINE VAR cv_lncbper    AS DECI FORMAT ">,>>9.99-".  /*Limit NCB %*/
DEFINE VAR cv_ldssper    AS DECI FORMAT ">,>>9.99-".  /*Limit DSPC % กรณีป้ายแดง 110  ส่ง 45%  นอกนั้นส่ง 30% */
DEFINE VAR cv_lclmper    AS DECI FORMAT ">,>>9.99-".  /*Limit Claim % กรณีให้ Load Claim ได้ New 0% or 50% , Renew 0% or 20 - 50%*/
DEFINE VAR cv_ldstfper   AS DECI FORMAT ">,>>9.99-".  /*Limit DSTF %*/
DEFINE VAR nv_reflag     AS LOGICAL INIT NO.          /*กรณีไม่ต้องการ Re-Calculate ใส่ Yes*/

DEFINE VAR nv_attgapt    AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_packatt1   AS CHARACTER FORMAT "X(4)".

DEFINE VAR nv_chgflg     AS LOGICAL.                      /* Charger Flag : Yes/No*/  
DEFINE VAR nv_chgrate    AS DECI FORMAT ">>>9.9999-".     /* Charger Rate */
DEFINE VAR nv_chgsi      AS INTE FORMAT ">>>,>>>,>>9-".   /* Charger Coverage/SumInsured */
DEFINE VAR nv_chgpdprm   AS DECI FORMAT ">>,>>>,>>9.99-". /* Charger PD Premium */
DEFINE VAR nv_chggapprm  AS DECI FORMAT ">>,>>>,>>9.99-". /* Charger GAP Premium */
      
DEFINE VAR nv_battflag   AS LOGICAL.
DEFINE VAR nv_battrate   AS DECI FORMAT ">>>9.9999-".     /* Battery Rate */                                       
DEFINE VAR nv_battpdprm  AS DECI FORMAT ">>,>>>,>>9.99-". /* Battery PD Premium */                               
DEFINE VAR nv_battgapprm AS DECI FORMAT ">>,>>>,>>9.99-". /* Battery GAP Premium */                               
/*-- End Add A67-0029 --*/








