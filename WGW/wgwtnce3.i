/* create by : Ranu I. A63-0174 เก็บค่าตัวแปร */
/*Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 Add color accessory */ 
DEFINE TEMP-TABLE wImport NO-UNDO
    FIELD Poltyp     AS CHAR FORMAT "X(3)"                INIT ""
    FIELD Policy     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD CedPol     AS CHAR FORMAT "X(20)"               INIT ""
    FIELD Renpol     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Compol     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Comdat     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD Expdat     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD Tiname     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD Insnam     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD name2      AS CHAR FORMAT "X(50)"               INIT ""
    FIELD dealer     AS CHAR FORMAT "x(70)"               INIT "" /*A60-0545*/
    FIELD name70     AS CHAR FORMAT "X(50)"               INIT ""
    FIELD name72     AS CHAR FORMAT "X(50)"               INIT ""
    FIELD iaddr1     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD iaddr2     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD iaddr3     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD iaddr4     AS CHAR FORMAT "X(20)"               INIT ""
    FIELD Prempa     AS CHAR FORMAT "X"                   INIT ""
    FIELD class      AS CHAR FORMAT "X(3)"                INIT ""
    FIELD Brand      AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Model      AS CHAR FORMAT "X(15)"               INIT ""
    FIELD CC         AS CHAR FORMAT "X(5)"                INIT ""
    FIELD Weight     AS CHAR FORMAT "X(5)"                INIT ""
    FIELD Seat       AS CHAR FORMAT "X(2)"                INIT ""
    FIELD Body       AS CHAR FORMAT "X(25)"               INIT "" 
    /*FIELD Vehreg     AS CHAR FORMAT "X(10)"               INIT ""*//*Comment A54-0112*/
    FIELD Vehreg     AS CHAR FORMAT "X(11)"               INIT "" /*A54-0112*/
    FIELD CarPro     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Engno      AS CHAR FORMAT "X(20)"               INIT ""
    FIELD Chano      AS CHAR FORMAT "X(20)"               INIT ""
    FIELD yrmanu     AS CHAR FORMAT "X(2)"                INIT ""
    FIELD Vehuse     AS CHAR FORMAT "X"                   INIT ""
    FIELD garage     AS CHAR FORMAT "X(2)"                INIT ""
    FIELD stkno      AS CHAR FORMAT "X(15)"               INIT ""
    FIELD covcod     AS CHAR FORMAT "X"                   INIT ""
    FIELD si         AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Prem_t     AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0 
    FIELD Prem_c     AS DECI FORMAT ">>>,>>9.99-"         INIT 0 
    FIELD Prem_r     AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0 
    FIELD Bennam     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD drivnam    AS CHAR FORMAT "X"                   INIT ""
    FIELD drivnam1   AS CHAR FORMAT "X(35)"               INIT ""
    FIELD drivbir1   AS CHAR FORMAT "X(10)"               INIT ""
    FIELD drivic1    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/
    FIELD drivid1    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/
    FIELD drivage1   AS CHAR FORMAT "X(3)"                INIT ""
    FIELD drivnam2   AS CHAR FORMAT "X(35)"               INIT ""
    FIELD drivbir2   AS CHAR FORMAT "X(10)"               INIT ""
    FIELD drivic2    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/  
    FIELD drivid2    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/ 
    FIELD drivage2   AS CHAR FORMAT "X(3)"                INIT ""
    FIELD Redbook    AS CHAR FORMAT "X(10)"               INIT ""
    FIELD opnpol     AS CHAR FORMAT "X(20)"               INIT ""
    FIELD bandet     AS CHAR /*FORMAT "X(20)" */          INIT ""
    FIELD tltdat     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD attrate    AS CHAR FORMAT "X(25)"               INIT ""
    FIELD branch     AS CHAR FORMAT "X(2)"                INIT ""
    FIELD fleet      AS CHAR FORMAT "x(10)"               INIT ""   /*fleet*/
    FIELD ncb        AS CHAR FORMAT "x(10)"               INIT "" 
    FIELD loadclm    AS CHAR FORMAT "x(10)"               INIT "" /*load claim*/
    FIELD deductda   AS CHAR FORMAT "x(10)"               INIT "" /*deduct da*/
    FIELD deductpd   AS CHAR FORMAT "x(10)"               INIT ""
    FIELD ICNO       AS CHAR FORMAT "X(13)"               INIT ""
    FIELD vatcode    AS CHAR FORMAT "X(10)"               INIT "" 
    FIELD text1      AS CHAR /*FORMAT "X(85)"*/           INIT ""
    FIELD text2      AS CHAR /*FORMAT "X(85)"*/           INIT ""
    FIELD text3      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD text4      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD text5      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD text6      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD finit      AS CHAR FORMAT "X(10)"               INIT ""
    FIELD comment    AS CHAR
    FIELD pass       AS CHAR INIT "Y"
    FIELD Rebate     AS CHAR INIT ""   /*A55-0235*/
    FIELD name3      AS CHAR FORMAT "X(75)"                INIT ""    /*A60-0545*/
    FIELD ncolor     AS CHAR FORMAT "X(50)"   
    FIELD acctxt     AS CHAR FORMAT "X(500)"               INIT "" .  /*A60-0545*/
 
DEFINE VAR Imidno      AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imtltdat    AS CHAR FORMAT "99/99/9999"          INIT "". 
DEFINE VAR Imcomcod    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imstkno     AS CHAR FORMAT "X(15)"               INIT "". 
DEFINE VAR Imstkno1    AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imyrcomp    AS CHAR FORMAT "9999"                INIT "". 
DEFINE VAR Impolcomp   AS CHAR FORMAT "X(15)"               INIT "".
DEFINE VAR Imcomnam    AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Imcedpol    AS CHAR FORMAT "X(17)"               INIT "". 
DEFINE VAR Imbandet    AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imbancode   AS CHAR FORMAT "X(2)"                INIT "". 
DEFINE VAR Imopnpol    AS CHAR FORMAT "X(16)"               INIT "". 
DEFINE VAR Imcodgrp    AS CHAR FORMAT "X(5)"                INIT "".
DEFINE VAR Imtiname    AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Iminsnam    AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imnfadd     AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Iminadd     AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imdeadd     AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imiadd1     AS CHAR FORMAT "X(100)"              INIT "". 
DEFINE VAR Imiadd2     AS CHAR FORMAT "X(100)"              INIT "". 
DEFINE VAR Imiadd3     AS CHAR FORMAT "X(100)"               INIT "". 
DEFINE VAR Imiadd4     AS CHAR FORMAT "X(100)"               INIT "".
DEFINE VAR Immadd1     AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Immadd2     AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Immadd3     AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imsi        AS CHAR FORMAT "x(25)"               INIT "". 
DEFINE VAR Imgrossi    AS Char FORMAT ">>>,>>>,>>>,>>>,>>9" INIT "" .  /*A60-0545*/
DEFINE VAR Imprem      AS Char FORMAT ">>>,>>>,>>9.99-"     INIT "" .  /*A60-0545*/
DEFINE VAR Imnetprem   AS Char FORMAT ">>>,>>>,>>9.99-"     INIT "" .  /*A60-0545*/
DEFINE VAR Imcomp      AS Char FORMAT ">>>,>>9.99-"         INIT "" .  /*A60-0545*/
DEFINE VAR Imnetcomp   AS Char FORMAT ">>>,>>9.99-"         INIT "" .  /*A60-0545*/
DEFINE VAR Impremtot   AS Char FORMAT ">>>,>>>,>>9.99-"     INIT "" .  /*A60-0545*/
DEFINE VAR Immodel     AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Imbrand     AS CHAR FORMAT "X(150)"              INIT "". 
DEFINE VAR Imyrmanu    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imcarcol    AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imvehreg    AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imcc        AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imengno     AS CHAR FORMAT "X(30)"               INIT "". 
DEFINE VAR Imchasno    AS CHAR FORMAT "X(30)"               INIT "". 
DEFINE VAR Imother1    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother2    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother3    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imandor1    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother4    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imandor2    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imandor3    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother5    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imattrate   AS CHAR FORMAT "X(45)"               INIT "".
/*DEFINE VAR Imcarpri    AS INTE FORMAT ">>>,>>>,>>>,>>>,>>9" INIT 0 . */ /*A60-0545*/
DEFINE VAR Imcarpri    AS CHAR FORMAT ">>>,>>>,>>>,>>>,>>9" INIT "" .  /*A60-0545*/
DEFINE VAR Imdealernam AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imsalenam   AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imcovcod    AS CHAR FORMAT "X"                   INIT "". 
DEFINE VAR Imvghgrp1   AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imvghgrp2   AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imdrivnam1  AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imdrivbir1  AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imidno1     AS CHAR FORMAT "X(13)"               INIT "". 
DEFINE VAR Imlicen1    AS CHAR FORMAT "X(15)"               INIT "". 
DEFINE VAR Imdrivnam2  AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imdrivbir2  AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imidno2     AS CHAR FORMAT "X(13)"               INIT "". 
DEFINE VAR Imlicen2    AS CHAR FORMAT "X(15)"               INIT "". 
DEFINE VAR Imcomdate   AS CHAR FORMAT "X(10)"               INIT "".
DEFINE VAR Imexpdate   AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imvehuse1   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse2   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse3   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse4   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse5   AS CHAR                              INIT "". 
DEFINE VAR Imothvehuse AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imcodecar   AS CHAR FORMAT "X(4)"                INIT "". 
DEFINE VAR Imdetrge1   AS CHAR                              INIT "". 
DEFINE VAR Imdetrge2   AS CHAR                              INIT "". 
DEFINE VAR Imbody1     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imbody2     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imbody3     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imbody4     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imothbody   AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imgarage1   AS CHAR                              INIT "". 
DEFINE VAR Imgarage2   AS CHAR                              INIT "". 
DEFINE VAR Imcodereb   AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Impolicy    AS CHAR FORMAT "X(16)"               INIT "".
DEFINE VAR Imbranch    AS CHAR FORMAT "X(2)"                INIT "".

DEFINE VAR Imtltno     AS CHAR FORMAT "X(17)" .
DEFINE VAR Imtltno1    AS CHAR FORMAT "X(17)" .
DEFINE VAR Imrenpol    AS CHAR FORMAT "X(20)".
DEFINE VAR Imcomdat1   AS CHAR FORMAT "X(10)".
DEFINE VAR Imexpdat1   AS CHAR FORMAT "X(10)".
DEFINE VAR Imvehreg1   AS CHAR FORMAT "X(30)". 
DEFINE VAR Imdetail    AS CHAR FORMAT "X(100)".
DEFINE VAR Imcomnam1   AS CHAR FORMAT "X(35)".
DEFINE VAR Imdeductda  AS CHAR FORMAT "X(30)".
DEFINE VAR Imncb       AS CHAR FORMAT "X(30)".
DEFINE VAR Imdeductpd  AS CHAR FORMAT "X(30)".
DEFINE VAR Imother     AS CHAR FORMAT "X(100)".
DEFINE VAR Imaddr      AS CHAR FORMAT "X(150)".
DEFINE VAR Imicno      AS CHAR FORMAT "X(15)".
DEFINE VAR Imiccomdat  AS CHAR FORMAT "X(10)".
DEFINE VAR Imicexpdat  AS CHAR FORMAT "X(10)".
DEFINE VAR Imtypaid    AS CHAR FORMAT "X(20)".
DEFINE VAR Imbennam    AS CHAR FORMAT "X(60)".
DEFINE VAR Imcomment1  AS CHAR FORMAT "X(10)".
DEFINE VAR Imcomment2  AS CHAR FORMAT "X(10)".
DEFINE VAR Imcomment   AS CHAR FORMAT "X(10)".
DEFINE VAR Imvatcode   AS CHAR FORMAT "X(10)".
DEFINE VAR Imseat      AS CHAR FORMAT "X(2)".
DEFINE VAR ImFinint    AS CHAR FORMAT "X(10)".   /*A56-0250*/
DEFINE VAR ImRemark1   AS CHAR FORMAT "X(100)".  /*A56-0250*/
DEFINE VAR ImRemark2   AS CHAR FORMAT "X(100)".  /*A56-0250*/
DEFINE VAR Imdoctyp    AS CHAR FORMAT "X(50)".   /*A59-0070*/
DEFINE VAR Imdocdetail AS CHAR FORMAT "X(50)".   /*A59-0070*/
DEFINE VAR Imbranins   AS CHAR.                  /*A59-0070*/
DEFINE VAR Imicno1     AS CHAR FORMAT "X(15)".   /*A59-0070*/
define var imnotino    as char format "x(20)".   /*A60-0545*/
define var imname2     as char format "x(70)".   /*A60-0545*/

DEFINE VAR nv_name2    AS CHAR FORMAT "X(50)"               INIT "".
DEFINE VAR nv_name70   AS CHAR FORMAT "X(50)"               INIT "".
DEFINE VAR nv_name72   AS CHAR FORMAT "X(50)"               INIT "".
DEFINE VAR nv_vehreg   AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR nv_vehreg1  AS CHAR FORMAT "X(15)"               INIT "".
DEFINE VAR nv_vehreg2  AS CHAR FORMAT "X(15)"               INIT "".
DEFINE VAR n_vehuse    AS CHAR FORMAT "X(2)"                INIT "".
DEFINE VAR n_body      AS CHAR FORMAT "X(5)"                INIT "".
DEFINE VAR nv_poltyp   AS CHAR FORMAT "X(3)"                INIT "".
DEFINE VAR nv_tinam    AS CHAR FORMAT "X(10)"               INIT "".
DEFINE VAR nv_policy   AS CHAR FORMAT "X(16)"               INIT "".
DEFINE VAR nv_carpro   AS CHAR FORMAT "X(35)"               INIT "".
DEFINE VAR nv_body     AS CHAR FORMAT "X(35)"               INIT "".
DEFINE VAR nv_drivnam  AS CHAR FORMAT "X(3)"                INIT "".
DEFINE VAR nv_ExpName  AS CHAR FORMAT "X(150)".
DEFINE VAR nv_Message  AS CHAR FORMAT "X(512)"              INIT "".
DEFINE VAR nv_cancel   AS CHAR FORMAT "X(2)"                INIT "N".
DEFINE VAR nv_pass     AS CHAR FORMAT "X(2)"                INIT "Y".
DEFINE VAR nv_tltdat   AS CHAR FORMAT "99/99/9999"          INIT "".
DEFINE VAR nv_len      AS INTE.
DEFINE VAR nv_cedpol   AS CHAR.
DEFINE VAR nv_prempa   AS CHAR.
DEFINE VAR nv_title1   AS CHAR.
DEFINE VAR nv_title2   AS CHAR.
DEFINE VAR nv_i        AS INTE.

