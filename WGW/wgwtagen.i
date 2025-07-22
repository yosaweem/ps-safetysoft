/*------------------------------------------------
SubProgram : WGWTAGEN.I
Modify By : Porntiwa P. A53-0111  16/09/2010
---------------------------------------------------
Modify By : Porntiwa P.  A55-0235  04/10/2012
          : เพิ่ม Field Code Rebate
---------------------------------------------------
Modify By : Porntiwa P.  A54-0112  06/01/2013
          : ปรับ เลลขทะเบียนจาก 10 เป็น 11 หลัก          
--------------------------------------------------
Modify by : Ranu I. A60-0327  27/07/2017  
          : เพิ่มตัวแปรเก็บค่างาน 2+ 3+          
--------------------------------------------------
Modify by : Ranu I. A60-0083  09/09/2017  
          : เพิ่มตัวแปรเก็บ campaing , ความคุ้มครอง 2+ 3+ 
---------------------------------------------------
Modify by : Ranu I. A60-0545 Date: 20/12/2017
            : เปลี่ยน format File แจ้งงานป้ายแดง   
---------------------------------------------------                                                                     
Modify by : Ranu I. A61-0512 Date 05/11/2018 
             เพิ่มการเก็บข้อมูลใน Memo (F8)                                                         
--------------------------------------------------*/
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/* Modify by : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*Modify by   : Kridtiya i. A66-0160 add color and campaign = Producer  */
/*-------------------------------------------------------------------------------------------*/
/*DEFINE NEW SHARED WORKFILE WIMPORT NO-UNDO*/   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
DEFINE NEW SHARED TEMP-TABLE WIMPORT NO-UNDO     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD idno          AS CHAR FORMAT "X(10)"               INIT ""
    FIELD tltdat        AS CHAR FORMAT "99/99/9999"          INIT ""
    FIELD comcod        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD sckno         AS CHAR FORMAT "X(15)"               INIT ""
    FIELD sckno1        AS CHAR FORMAT "X(10)"               INIT ""
    FIELD yrcomp        AS CHAR FORMAT "9999"                INIT ""
    FIELD polcomp       AS CHAR FORMAT "X(15)"               INIT ""
    FIELD comnam        AS CHAR FORMAT "X(50)"               INIT ""
    FIELD cedpol        AS CHAR FORMAT "X(17)"               INIT ""
    FIELD bandet        AS CHAR FORMAT "X(20)"               INIT ""
    FIELD bancode       AS CHAR FORMAT "X(2)"                INIT ""
    FIELD opnpol        AS CHAR FORMAT "X(16)"               INIT ""
    FIELD codgrp        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD tiname        AS CHAR FORMAT "X(60)"               INIT ""
    FIELD insnam        AS CHAR FORMAT "X(60)"               INIT ""
    FIELD nfadd         AS CHAR FORMAT "X(5)"                INIT ""
    FIELD inadd         AS CHAR FORMAT "X(5)"                INIT ""
    FIELD deadd         AS CHAR FORMAT "X(5)"                INIT ""
    FIELD iadd1         AS CHAR FORMAT "X(100)"              INIT ""
    FIELD iadd2         AS CHAR FORMAT "X(100)"              INIT ""
    FIELD iadd3         AS CHAR FORMAT "X(10)"               INIT ""
    FIELD madd1         AS CHAR FORMAT "X(50)"               INIT ""
    FIELD madd2         AS CHAR FORMAT "X(50)"               INIT ""
    FIELD madd3         AS CHAR FORMAT "X(10)"               INIT ""
    FIELD si            AS CHAR FORMAT "x(25)"               INIT "" 
    FIELD grossi        AS INTE FORMAT ">>>,>>>,>>>,>>>,>>9" INIT 0
    FIELD prem          AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0
    FIELD netprem       AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0
    FIELD comp          AS DECI FORMAT ">>>,>>9.99-"         INIT 0
    FIELD netcomp       AS DECI FORMAT ">>>,>>9.99-"         INIT 0
    FIELD premtot       AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0
    FIELD model         AS CHAR FORMAT "X(50)"               INIT ""
    FIELD brand         AS CHAR FORMAT "X(150)"              INIT ""
    FIELD yrmanu        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD carcol        AS CHAR FORMAT "X(20)"               INIT ""
    FIELD vehreg        AS CHAR FORMAT "X(30)"               INIT ""
    FIELD cc            AS CHAR FORMAT "X(5)"                INIT ""
    FIELD engno         AS CHAR FORMAT "X(30)"               INIT ""
    FIELD chasno        AS CHAR FORMAT "X(30)"               INIT ""
    FIELD other1        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD other2        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD other3        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD andor1        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD other4        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD andor2        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD other5        AS CHAR FORMAT "X(5)"                INIT ""
    FIELD attrate       AS CHAR FORMAT "X(45)"               INIT ""
    FIELD carpri        AS INTE FORMAT ">>>,>>>,>>>,>>>,>>9" INIT 0
    FIELD dealernam     AS CHAR FORMAT "X(60)"               INIT ""
    FIELD salenam       AS CHAR FORMAT "X(60)"               INIT ""
    FIELD covcod        AS CHAR FORMAT "X(3)"                INIT ""
    FIELD vghgrp1       AS CHAR FORMAT "X(5)"                INIT ""
    FIELD vghgrp2       AS CHAR FORMAT "X(5)"                INIT ""
    FIELD drivnam1      AS CHAR FORMAT "X(60)"               INIT ""
    FIELD drivbir1      AS CHAR FORMAT "X(10)"               INIT ""
    FIELD idno1         AS CHAR FORMAT "X(13)"               INIT ""
    FIELD licen1        AS CHAR FORMAT "X(15)"               INIT ""
    FIELD drivnam2      AS CHAR FORMAT "X(60)"               INIT ""
    FIELD drivbir2      AS CHAR FORMAT "X(10)"               INIT "" 
    FIELD idno2         AS CHAR FORMAT "X(13)"               INIT ""
    FIELD licen2        AS CHAR FORMAT "X(15)"               INIT ""
    FIELD comdate       AS CHAR FORMAT "X(10)"               INIT ""
    FIELD expdate       AS CHAR FORMAT "X(10)"               INIT ""
    FIELD vehuse1       AS CHAR                              INIT ""
    FIELD vehuse2       AS CHAR                              INIT ""
    FIELD vehuse3       AS CHAR                              INIT ""
    FIELD vehuse4       AS CHAR                              INIT ""
    FIELD vehuse5       AS CHAR                              INIT ""
    FIELD othvehuse     AS CHAR FORMAT "X(20)"               INIT ""
    FIELD codecar       AS CHAR FORMAT "X(4)"                INIT ""
    FIELD detrge1       AS CHAR                              INIT ""
    FIELD detrge2       AS CHAR                              INIT ""
    FIELD body1         AS CHAR                              INIT ""
    FIELD body2         AS CHAR                              INIT ""
    FIELD body3         AS CHAR                              INIT ""
    FIELD body4         AS CHAR                              INIT ""
    FIELD othbody       AS CHAR FORMAT "X(20)"               INIT ""
    FIELD garage1       AS CHAR                              INIT ""
    FIELD garage2       AS CHAR                              INIT ""
    FIELD codereb       AS CHAR FORMAT "X(10)"               INIT ""
    FIELD policy        AS CHAR FORMAT "X(16)"               INIT "" .
DEFINE NEW SHARED TEMP-TABLE wdetail
      FIELD entdat        AS CHAR FORMAT "x(10)"             INIT ""     /*entry date*/
      FIELD enttim        AS CHAR FORMAT "x(8)"              INIT ""     /*entry time*/
      FIELD trandat       AS CHAR FORMAT "x(10)"             INIT ""     /*tran date*/
      FIELD trantim       AS CHAR FORMAT "x(8)"              INIT ""     /*tran time*/
      FIELD poltyp        AS CHAR FORMAT "x(3)"              INIT ""     /*policy type*/
      FIELD policy        AS CHAR FORMAT "x(16)"             INIT ""     /*policy*/       /*a40166 chg format from 12 to 16*/
      FIELD cr_2          AS CHAR FORMAT "x(16)"             INIT ""     /*cr_2*/
      FIELD renpol        AS CHAR FORMAT "x(16)"             INIT ""     /*renew policy*/ /*a40166 chg format from 12 to 16*/
      FIELD comdat        AS CHAR FORMAT "x(10)"             INIT ""     /*comm date*/
      FIELD expdat        AS CHAR FORMAT "x(10)"             INIT ""     /*expiry date*/
      FIELD compul        AS CHAR FORMAT "x"                 INIT ""     /*compulsory*/
      FIELD tiname        AS CHAR FORMAT "x(15)"             INIT ""     /*title*/
      FIELD insnam        AS CHAR FORMAT "x(60)"             INIT ""     /*name*/
      FIELD name2         AS CHAR FORMAT "X(60)"             INIT ""     /*และ/หรือ*/
      FIELD name3         AS CHAR FORMAT "x(60)"             INIT ""     /*ชื่อกรรมการ */ /*A60-0545*/
      FIELD iadd1         AS CHAR FORMAT "x(35)"             INIT ""
      FIELD iadd2         AS CHAR FORMAT "x(35)"             INIT ""
      FIELD iadd3         AS CHAR FORMAT "x(34)"             INIT ""
      FIELD iadd4         AS CHAR FORMAT "x(20)"             INIT ""
      FIELD prempa        AS CHAR FORMAT "x"                 INIT ""     /*premium package*/
      FIELD subclass      AS CHAR FORMAT "x(3)"              INIT ""     /*sub class*/
      FIELD brand         AS CHAR FORMAT "x(30)"             INIT ""
      FIELD model         AS CHAR FORMAT "x(50)"             INIT ""
      FIELD cc            AS CHAR FORMAT "x(10)"             INIT ""
      FIELD weight        AS CHAR FORMAT "x(10)"             INIT ""
      FIELD seat          AS CHAR FORMAT "x(2)"              INIT ""
      FIELD body          AS CHAR FORMAT "x(20)"             INIT ""
      /*FIELD vehreg        AS CHAR FORMAT "x(10)"             INIT "" /*vehicl registration*/*//*Comment A54-0112*/
      FIELD vehreg        AS CHAR FORMAT "x(11)"             INIT "" /*vehicl registration*/ /*A54-0112*/
      FIELD engno         AS CHAR FORMAT "x(20)"             INIT "" /*engine no*/
      FIELD chasno        AS CHAR FORMAT "x(20)"             INIT "" /*chasis no*/
      FIELD caryear       AS CHAR FORMAT "x(4)"              INIT ""
      FIELD carprovi      AS CHAR FORMAT "x(2)"              INIT ""
      FIELD vehuse        AS CHAR FORMAT "x"                 INIT "" /*vehicle use*/
      FIELD garage        AS CHAR FORMAT "x"                 INIT ""
      FIELD stk           AS CHAR FORMAT "x(15)"             INIT ""  /*--A51-0253---Amparat*/
      FIELD access        AS CHAR FORMAT "x"                 INIT "" /*accessories*/
      FIELD covcod        AS CHAR FORMAT "x(3)"                 INIT "" /*cover type*/
      FIELD si            AS CHAR FORMAT "x(25)"             INIT "" /*sum insure*/
      FIELD volprem       AS CHAR FORMAT "x(20)"             INIT "" /*voluntory premium*/
      FIELD Compprem      AS CHAR FORMAT "x(20)"             INIT "" /*compulsory prem*/
      FIELD Netprem       AS CHAR FORMAT "x(20)"             INIT "" /*เบี้ยรวมภาษี + อากร */
      FIELD benname       AS CHAR FORMAT "x(50)"             INIT "" /*benificiary*/
      FIELD n_user        AS CHAR FORMAT "x(10)"             INIT "" /*user id*/
      FIELD n_IMPORT      AS CHAR FORMAT "x(2)"              INIT "" 
      FIELD n_export      AS CHAR FORMAT "x(2)"              INIT "" 
      FIELD drivnam       AS CHAR FORMAT "x"                 INIT "" 
      FIELD drivnam1      AS CHAR FORMAT "x(50)"             INIT "" /*driver name1*/
      FIELD drivnam2      AS CHAR FORMAT "x(50)"             INIT "" /*driver name2*/
      FIELD drivbir1      AS CHAR FORMAT "X(10)"             INIT ""  /*driver birth date*/
      FIELD drivbir2      AS CHAR FORMAT "X(10)"             INIT ""  /*driver birth date*/
      FIELD drivic1       AS CHAR FORMAT "X(13)"             INIT ""  /*driver icno 1*/     /*A60-0545*/
      FIELD drivic2       AS CHAR FORMAT "X(13)"             INIT ""  /*driver icno 2*/     /*A60-0545*/
      FIELD drivlic1      AS CHAR FORMAT "X(13)"             INIT ""  /*driver licen 1*/    /*A60-0545*/
      FIELD drivlic2      AS CHAR FORMAT "X(13)"             INIT ""  /*driver licen 2*/    /*A60-0545*/
      FIELD drivage1      AS CHAR FORMAT "X(2)"              INIT ""  /*driver age1*/
      FIELD drivage2      AS CHAR FORMAT "x(2)"              INIT ""  /*driver age2*/
      FIELD cancel        AS CHAR FORMAT "x(2)"              INIT ""  /*cancel*/
      FIELD WARNING       AS CHAR FORMAT "X(30)"             INIT ""
      FIELD comment       AS CHAR FORMAT "x(512)"            INIT ""  /*a490166 add format from 100 to 512*/
      FIELD seat41        AS INTE FORMAT "99"                INIT 0
      FIELD pass          AS CHAR FORMAT "x"                 INIT "n"
      FIELD OK_GEN        AS CHAR FORMAT "X"                 INIT "Y" 
      FIELD comper        AS INTE                            INIT 0
      FIELD comacc        AS INTE                            INIT 0
      FIELD NO_41         AS INTE                            INIT 0
      FIELD NO_42         AS INTE                            INIT 0
      FIELD NO_43         AS INTE                            INIT 0
      Field uom1_v        AS INTE                            INIT 0   /*A60-0383*/        
      Field uom2_v        AS INTE                            INIT 0   /*A60-0383*/        
      Field uom5_v        AS INTE                            INIT 0   /*A60-0383*/        
      FIELD tariff        AS CHAR FORMAT "x(2)"              INIT ""
      FIELD baseprem      AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0
      FIELD cargrp        AS CHAR FORMAT "x(2)"              INIT ""
      FIELD producer      AS CHAR FORMAT "x(7)"              INIT ""
      FIELD agent         AS CHAR FORMAT "x(7)"              INIT ""  
      FIELD inscod        AS CHAR                            INIT ""
      FIELD redbook       AS CHAR FORMAT "X(8)"              INIT ""  /*note add*/
      FIELD base          AS CHAR FORMAT "x(8)"              INIT ""  /*Note add Base Premium 25/09/2006*/
      FIELD accdat        AS CHAR FORMAT "x(10)"             INIT ""   /*Account Date For 72*/
      FIELD docno         AS CHAR FORMAT "x(10)"             INIT ""   /*Docno For 72*/
      FIELD prem_t        AS CHAR FORMAT "x(20)"             INIT ""   /*Premium Total*/
      FIELD CoverNote     AS CHAR FORMAT "x(13)"             INIT ""  /* ระบุว่าเป็นงาน COVER NOTE A51-0071 amparat*/
      FIELD opnpol        AS CHAR /*FORMAT "X(16)"*/
      FIELD cedpol        AS CHAR FORMAT "X(16)"  /*A53-0111*/
      FIELD bandet        AS CHAR /*FORMAT "X(20)"*/  /*A53-0111*/
      FIELD tltdat        AS CHAR /*FORMAT "99/99/9999" */   INIT ""  /*A53-0111*/
      FIELD attrate       AS CHAR /*FORMAT "X(45)"*/  /*A53-0111*/
      FIELD branch        AS CHAR FORMAT "X(2)"  /*A53-0111*/
      FIELD rencnt        AS INTE FORMAT "99"
      FIELD endcnt        AS INTE FORMAT "999"
      FIELD typreq        AS CHAR FORMAT "X(10)"
      FIELD Text1         AS CHAR /*FORMAT "X(85)"*/
      FIELD Text2         AS CHAR /*FORMAT "X(85)"*/
      FIELD icno          AS CHAR FORMAT "X(15)"
      FIELD finit         AS CHAR FORMAT "X(10)"
      FIELD Rebate        AS CHAR  /*A55-0235*/
      FIELD base3         AS INTE FORMAT ">,>>>,>>>,>>>,>>9" INIT  0  /*a60-0327*/
      FIELD camp          AS CHAR FORMAT "x(20)"  /*a60-0383*/
      FIELD ispno         AS CHAR FORMAT "x(20)" INIT ""    /*A61-0512*/
      FIELD paidtyp       as char format "x(25)" init ""    /*A61-0512*/
      FIELD paiddat       as char format "x(15)" init ""    /*A61-0512*/
      FIELD confdat       as char format "x(15)" init ""    /*A61-0512*/
      /*FIELD prem          AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0
      FIELD netprem       AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0
      FIELD comp          AS DECI FORMAT ">>>,>>9.99-"         INIT 0
      FIELD netcomp       AS DECI FORMAT ">>>,>>9.99-"         INIT 0
      FIELD premtot       AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0.*/
    FIELD financecd     AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD insnamtyp     AS CHAR FORMAT "x(60)" INIT ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD firstName     AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD lastName      AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD postcd        AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD occup         AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeocc       AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr1     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr2     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD codeaddr3     AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD br_insured    AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    FIELD campaign_ov   AS CHAR FORMAT "x(30)" INIT ""     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    FIELD nCOLOR        AS CHAR FORMAT "x(100)" INIT ""  
    FIELD ACCESSORYtxt        AS CHAR FORMAT "x(500)" INIT "" .
    

DEFINE NEW SHARED VAR nv_message  AS CHAR.
DEFINE NEW SHARED VAR no_baseprm  AS DECI FORMAT ">>,>>>,>>9.99-". 
DEFINE NEW SHARED VAR NO_basemsg  AS CHAR FORMAT "x(50)" .         
DEFINE NEW SHARED VAR nv_batchyr  AS INTE FORMAT "9999"          INIT 0.
DEFINE NEW SHARED VAR nv_batcnt   AS INTE FORMAT "99"            INIT 0.
DEFINE NEW SHARED VAR nv_batchno  AS CHAR FORMAT "X(13)"         INIT ""  NO-UNDO.
DEFINE NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "". 
DEFINE NEW SHARED VAR nv_modulo   AS INTE FORMAT "9".
DEFINE NEW SHARED VAR nv_branch   LIKE sicsyac.XMM023.BRANCH.  
DEFINE NEW SHARED VAR nv_makdes   AS CHAR    .
DEFINE NEW SHARED VAR nv_moddes   AS CHAR.

DEFINE  WORKFILE wuppertxt NO-UNDO
/*1*/  FIELD line        AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt         AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE  WORKFILE wuppertxt2 NO-UNDO
/*1*/  FIELD line        AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt         AS CHARACTER FORMAT "X(78)"   INITIAL "".
DEFINE VAR nv_riskgp        LIKE sicuw.uwm120.riskgp   NO-UNDO.
DEFINE VAR nv_accdat        AS DATE FORMAT "99/99/9999"        INIT ?  .     
DEFINE VAR nv_docno         AS CHAR FORMAT "9999999"           INIT " ".
DEFINE VAR  nv_batrunno     AS INTE FORMAT  ">,>>9"            INIT 0.
DEFINE VAR  nv_imppol       AS INTE FORMAT ">>,>>9"            INIT 0.
DEFINE VAR  nv_impprem      AS DECI FORMAT "->,>>>,>>9.99"     INIT 0.
DEFINE VAR  nv_batprev      AS CHAR FORMAT "X(13)"             INIT ""    NO-UNDO.
DEFINE VAR  nv_tmppolrun    AS INTE FORMAT "999"               INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn       AS CHAR FORMAT "x(2)"              INIT ""    NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol       AS CHAR FORMAT "x(16)"             INIT "". /*Temp Policy*/
DEFINE VAR  nv_rectot       AS INTE FORMAT ">>,>>9"            INIT 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc       AS INTE FORMAT ">>,>>9"            INIT 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t     AS DECI FORMAT "->,>>>,>>9.99"     INIT 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s     AS DECI FORMAT "->,>>>,>>9.99"     INIT 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */
DEFINE VAR  nv_batflg       AS LOGI                            INIT NO.
DEFINE VAR  nv_txtmsg       AS CHAR FORMAT "x(50)"             INIT "".   /* Parameter คู่กับ nv_check */
DEFINE VAR nv_name2         AS CHAR FORMAT "X(50)"             INIT " ".
DEFINE VAR n_body           AS CHAR FORMAT "X(1)"              INIT "".
DEFINE VAR n_vehuse         AS CHAR FORMAT "X(2)"              INIT "".
DEFINE VAR nv_simax         AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_simin         AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_address       AS CHAR FORMAT "X(100)".
DEFINE VAR nv_address1      AS CHAR FORMAT "X(100)".
DEFINE VAR nv_address2      AS CHAR FORMAT "X(100)".
DEFINE VAR nv_address3      AS CHAR FORMAT "X(35)".
DEFINE VAR i                AS INTE.
DEFINE VAR nv_ncbyrs        AS INTE.
DEFINE VAR nv_basere        AS DECI FORMAT ">>,>>>,>>9.99-"    INIT 0. 
DEFINE VAR n_sclass72       AS CHAR FORMAT "x(4)".
DEFINE VAR nv_simat         AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_simat1        AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_uwm301trareg  LIKE sic_bran.uwm301.cha_no        INIT "".
DEFINE VAR n_41             AS DECI FORMAT ">,>>>,>>9.99"      INIT 0.
DEFINE VAR n_42             AS DECI FORMAT ">,>>>,>>9.99"      INIT 0.
DEFINE VAR n_43             AS DECI FORMAT ">,>>>,>>9.99"      INIT 0.
/*DEFINE VAR nv_vehreg        AS CHAR FORMAT "X(2)".*//*Comment A54-0112*/
DEFINE VAR nv_vehreg        AS CHAR FORMAT "X(11)". /*A54-0112*/
DEFINE VAR nv_fleet         AS CHAR FORMAT "x(10)"             INIT "" .
DEFINE VAR nv_deductda      AS CHAR FORMAT "x(10)"             INIT "" .  
DEFINE VAR nv_loadclm       AS CHAR FORMAT "x(10)"             INIT "" .
DEFINE VAR nv_deductpd      AS CHAR FORMAT "x(10)"             INIT "" .
DEFINE VAR nv_maxdes        AS CHAR.
DEFINE VAR nv_mindes        AS CHAR.
DEFINE VAR nv_si            AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_maxSI         AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE VAR nv_minSI         AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEFINE VAR nv_newsck        AS CHAR FORMAT "x(15)"        INIT " ".

DEFINE VAR nv_line1         AS INTEGER                    INITIAL 0   NO-UNDO.
DEFINE VAR nv_txt1          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt2          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt3          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt4          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt5          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt6          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt7          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt8          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.
DEFINE VAR nv_txt9          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO.  /*A61-0512*/
DEFINE VAR nv_txt10          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO. /*A61-0512*/
DEFINE VAR nv_txt11          AS CHARACTER FORMAT "X(78)"   INITIAL ""  NO-UNDO. /*A61-0512*/


DEFINE VAR nv_logbok        AS CHAR FORMAT "X(2)" INITIAL "".
DEFINE VAR per              AS DECI.
DEFINE VAR f                AS DECI.
DEFINE VAR chk              AS LOGICAL.
DEFINE VAR model            AS CHAR .
DEFINE VAR aa               AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE VAR n_firstdat       AS DATE INIT ?.
DEFINE VAR nv_text          AS CHAR.
DEFINE VAR nv_insref        AS CHARACTER FORMAT "X(10)".
DEFINE VAR n_check          AS CHARACTER .
DEFINE VAR nv_typ           AS CHAR FORMAT "X(2)".
DEFINE VAR nv_showntext     AS CHAR.
DEFINE VAR nv_lnumber       AS INTE INIT 0.
DEFINE VAR nv_provi         AS CHAR INIT "".
DEFINE VAR n_rencnt         LIKE sicuw.uwm100.rencnt .
DEFINE VAR nv_index         AS INT  INIT  0. 
DEFINE VAR n_endcnt         LIKE sicuw.uwm100.endcnt.
DEFINE VAR n_comdat         LIKE sicuw.uwm100.comdat  NO-UNDO.
DEFINE VAR n_policy         LIKE sicuw.uwm100.policy  INITIAL "" .
DEFINE VAR nv_daily         AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt        AS INT  INIT  0.        /*all load record*/
DEFINE VAR nv_completecnt   AS INT  INIT  0.  /*complete record */
DEFINE VAR s_riskgp         AS INTE FORMAT ">9".
DEFINE VAR s_riskno         AS INTE FORMAT "999".
DEFINE VAR s_itemno         AS INTE FORMAT "999". 
DEFINE VAR nv_drivage1      AS INTE INIT 0.
DEFINE VAR nv_drivage2      AS INTE INIT 0.
DEFINE VAR nv_drivbir1      AS CHAR INIT "".
DEFINE VAR nv_drivbir2      AS CHAR INIT "".
DEFINE VAR nv_dept          AS CHAR FORMAT  "X(1)".
DEFINE VAR nv_undyr         AS CHAR  INIT  ""    FORMAT   "X(4)".
DEFINE VAR n_newpol         LIKE  sicuw.uwm100.policy      INITIAL "".
DEFINE VAR n_curbil         LIKE  sicuw.uwm100.curbil                 NO-UNDO.
DEFINE VAR nv_lastno        AS INTE.
DEFINE VAR nv_seqno         AS INTE.
DEFINE VAR sv_xmm600        AS RECID.
/*--------- 722 --------*/
DEFINE VAR nv_stm_per       AS DECIMAL FORMAT ">9.99"      INITIAL 0  NO-UNDO.
DEFINE VAR nv_tax_per       AS DECIMAL FORMAT ">9.99"      INITIAL 0  NO-UNDO.
DEFINE VAR nv_com1_per      AS DECIMAL FORMAT ">9.99"      INITIAL 0  NO-UNDO.
DEFINE VAR nv_com1_prm      AS DECIMAL FORMAT ">>>>>9.99-"            NO-UNDO.
DEFINE VAR s_130bp1         AS RECID                                  NO-UNDO.
DEFINE VAR s_130fp1         AS RECID                                  NO-UNDO.
DEFINE VAR nvffptr          AS RECID                                  NO-UNDO.
DEFINE VAR n_rd132          AS RECID                                  NO-UNDO.
DEFINE VAR nv_gap           AS DECIMAL                                NO-UNDO.
DEFINE VAR nv_fptr          AS RECID.
DEFINE VAR nv_bptr          AS RECID.
DEFINE VAR nv_gap2          AS DECIMAL                                NO-UNDO.
DEFINE VAR nv_prem2         AS DECIMAL                                NO-UNDO.
DEFINE VAR nv_rstp          AS DECIMAL                                NO-UNDO.
DEFINE VAR nv_rtax          AS DECIMAL                                NO-UNDO.
DEFINE VAR nv_key_a         AS DECIMAL                     INITIAL 0  NO-UNDO.
DEFINE VAR nv_rec100        AS RECID .
DEFINE VAR nv_rec120        AS RECID .
DEFINE VAR nv_rec130        AS RECID .
DEFINE VAR nv_rec301        AS RECID .
/* a60-0327*/
DEFINE NEW  SHARED VAR   nv_addr1   AS CHAR FORMAT "x(45)".               
DEFINE NEW  SHARED VAR   nv_addr2   AS CHAR FORMAT "x(45)".               
DEFINE NEW  SHARED VAR   nv_addr3   AS CHAR FORMAT "x(45)".               
DEFINE NEW  SHARED VAR   nv_addr4   AS CHAR FORMAT "x(20)". 
DEFINE NEW  SHARED VAR   nv_prem3       AS DECIMAL  FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEFINE NEW  SHARED VAR   nv_sicod3      AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_usecod3     AS CHAR     FORMAT "X(4)".
DEFINE NEW  SHARED VAR   nv_siprm3      AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_prvprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_baseprm3    AS DECI     FORMAT ">>,>>>,>>9.99-".
DEFINE NEW  SHARED VAR   nv_useprm3     AS DECI     FORMAT ">>,>>>,>>9.99-".
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
DEFINE NEW  SHARED VAR   nv_vehgr       AS CHAR     FORMAT "x(2)".
/* end : a60-0327*/
DEF NEW SHARED TEMP-TABLE wcampaign NO-UNDO 
    FIELD  campno  AS CHAR FORMAT "x(20)"    INIT ""
    FIELD  nclass  AS CHAR FORMAT "x(5)"    INIT ""  
    FIELD  cover   AS CHAR FORMAT "x(3)"    INIT ""  
    FIELD  pack    AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD  bi      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd1     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd2     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n41     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n42     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  n43     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  camp   AS CHAR FORMAT "x(25)"    INIT "" .
DEF VAR  nv_chkerror AS CHAR FORMAT "x(250)"    INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
DEF VAR  nv_postcd   AS CHAR FORMAT "x(25)"    INIT "" .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/


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

DEFINE VAR nv_effdat  AS DATE FORMAT "99/99/9999".

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

DEF VAR dod0 AS INTEGER.
DEF VAR dod1 AS INTEGER.
DEF VAR dod2 AS INTEGER.
DEF VAR dpd0 AS INTEGER.
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */


/* end A64-0138 */



