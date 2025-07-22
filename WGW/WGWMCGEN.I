/*------------------------------------------------
SubProgram : WGWMCGEN.I
Modify By : Porntiwa P. A56-0345  11/09/2010    
Duplicate Program : WGWTAGEN.I   
--------------------------------------------------
Modify By : Porntiwa P.  A57-0228  15/08/2014
- ขยาย Format Field "Vehreg" จาก 10 --> 12
- เพิ่ม Field color1; Text5; Text7; comp; prem_t
- ปรับ Field class1 --> moddes
- ปรับ Field Class เก็บค่า Class [110;210;220;....]

/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
--------------------------------------------------*/  
/*DEFINE NEW SHARED WORKFILE wexcel NO-UNDO*/ /*Comment by Kridtiya i. A63-0472 Date. 09/11/2020*/  
DEFINE NEW SHARED TEMP-TABLE wexcel NO-UNDO   /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/  
FIELD seqno1     AS CHAR FORMAT ">>>>>9"                 INIT ""  /*0 */
FIELD policy     AS CHAR FORMAT "X(16)"                  INIT ""  /*1 */
FIELD cr_2       AS CHAR FORMAT "X(16)"                  INIT ""
FIELD sticker    AS CHAR FORMAT "X(15)"                  INIT ""  /*16 Sticker no.*/ /*---a51-0253--*/
FIELD comdat     AS CHAR FORMAT "99/99/9999"                      /*7  วันที่เริ่มต้น*/
FIELD expdat     AS CHAR FORMAT "99/99/9999"                      /*8  วันที่สิ้นสุด*/
FIELD comdatcomp AS CHAR FORMAT "99/99/9999"                      /*7  วันที่เริ่มต้น พรบ*/
FIELD expdatcomp AS CHAR FORMAT "99/99/9999"                      /*8  วันที่สิ้นสุด พรบ*/
FIELD insref     AS CHAR FORMAT "X(10)"                  INIT ""  /*Insured Code*/
FIELD tiname     AS CHAR FORMAT "X(15)"                  INIT ""  /*   Title name*/
FIELD name1      AS CHAR FORMAT "X(50)"                  INIT ""  /*2  Name1*/
FIELD addr1      AS CHAR FORMAT "X(40)"                  INIT ""  /*3  Address 1*/
FIELD addr2      AS CHAR FORMAT "X(40)"                  INIT ""  /*   Address 2*/
FIELD addr3      AS CHAR FORMAT "X(40)"                  INIT ""  /*   Address 3*/
FIELD addr4      AS CHAR FORMAT "X(40)"                  INIT ""  /*   Address 4*/
FIELD icno       AS CHAR FORMAT "X(14)"                  INIT ""
FIELD vehreg     AS CHAR FORMAT "X(12)"                  INIT ""  /*11 ทะเบียนรถ*/
FIELD provin     AS CHAR FORMAT "X(2)"                   INIT ""  /*   จังหวัด*/
FIELD yrmanuf    AS INTE FORMAT "9999"                   INIT ""  /*   ปีจดทะเบียน*/
FIELD makdes     AS CHAR FORMAT "X(18)"                  INIT ""  /*10 ยี่ห้อรถ*/
FIELD moddes     AS CHAR FORMAT "X(30)"                  INIT ""  /*1  รุ่นรถ */ /*A57-0228*/
FIELD engine     AS CHAR FORMAT "X(05)"                  INIT ""  /*14 จำนวน CC.*/
FIELD body       AS CHAR FORMAT "X(15)"                  INIT ""  /*13 ชนิดของตัวรถ SEDAN ; PIKUP*/
FIELD access     AS CHAR FORMAT "X(30)"                  INIT ""  /*Accessorise*/
FIELD engno      AS CHAR FORMAT "X(20)"                  INIT ""  /*12 เลขที่เครื่องยนต์*/
FIELD cha_no     AS CHAR FORMAT "X(20)"                  INIT ""  /*12 เลขที่ตัวรถ*/
FIELD orderno    AS CHAR FORMAT "X(10)"                  INIT ""  /* Order No.*/
FIELD finance    AS CHAR FORMAT "X(50)"                  INIT ""  /*Finance*/
FIELD dealer     AS CHAR FORMAT "X(30)"                  INIT ""  /*Dealer*/
FIELD si         AS DECI FORMAT ">>>,>>>,>>>,>>>9.99"    INIT 0  /*Cost / si*/
FIELD CLASS      AS CHAR FORMAT "X(4)"                   INIT ""  /*Class*/  /*A57-0228*/
FIELD remark     AS CHAR FORMAT "X(60)"                  INIT ""  /*หมายเหตุ*/
FIELD prem70     AS DECI FORMAT ">,>>>,>99.99"           INIT 0  /*Premium 70*/
FIELD premtot70  AS DECI FORMAT ">,>>>,>99.99"           INIT 0  /*Premium Total 70*/
FIELD prem       AS CHAR FORMAT ">>>>>9.99"              INIT 0   /*17 เบี้ยประกันสุทธิ*/
FIELD stamp      AS CHAR FORMAT ">>>9.99"                INIT 0   /*18 Stamp*/
FIELD tax        AS CHAR FORMAT ">>>>9.99"               INIT 0   /*19 VAT  */
FIELD sumtotal   AS CHAR FORMAT ">>>>>9.99"              INIT 0   /*17 เบี้ยประกันสุทธิ*/
FIELD covcod     AS CHAR FORMAT "X(1)"                   INIT ""  /*Cover Type*/
FIELD vehusg     AS CHAR FORMAT "X(1)"                   INIT ""  /*15 ลักษณะการใช้รถ(1=รถส่วนบุคคล 2=รับจ้าง/ให้เช่า */
FIELD ncb        AS CHAR FORMAT "X(5)"                   INIT ""   /*NCB %*/
FIELD fleet      AS CHAR FORMAT "X(5)"                   INIT ""   /*Fleet %*/
FIELD baseprm    AS CHAR FORMAT "X(15)"                  INIT ""  /*Base Premium*/
FIELD bip        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*TP BI/Person*/
FIELD bia        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*TP BI/Accident*/
FIELD pda        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*TP PD/Accident*/
FIELD m411       AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*411*/
FIELD m412       AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*412*/
FIELD m42        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*42*/
FIELD m43        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*43*/
FIELD seats      AS CHAR FORMAT "X(2)"                   INIT ""
FIELD modcod     AS CHAR FORMAT "X(8)"                   INIT ""
FIELD tran72     AS CHAR FORMAT "X(2)"                   INIT ""
FIELD tran70     AS CHAR FORMAT "X(2)"                   INIT ""
FIELD rec_status  AS CHAR FORMAT "X(01)"                 INIT ""  /*20 Record Pass Status Y/N */
FIELD rec_comment AS CHAR FORMAT "X(100)"                INIT ""
FIELD COLOR1      AS CHAR FORMAT "X(30)"                 INIT "" /*Phorn*//*A57-0228*/
FIELD comp        AS DECI FORMAT ">>>>9.99"              INIT 0  /*Phorn*//*A57-0228*/
FIELD prem_t      AS DECI FORMAT ">,>>>,>99.99"          INIT 0  /*Phorn*//*A57-0228*/
FIELD Text5       AS CHAR                                INIT "" /*Phorn*//*A57-0228*/
FIELD Text7       AS CHAR                                INIT "" /*Phorn*//*A57-0228*/
FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT "" . /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/


/*DEFINE NEW SHARED WORKFILE wgenerage NO-UNDO*//*comment by Kridtiya i. A63-0472 Date. 09/11/2020*/   
DEFINE NEW SHARED TEMP-TABLE wgenerage NO-UNDO  /*Add     by Kridtiya i. A63-0472 Date. 09/11/2020*/   
FIELD seqno1     AS CHAR FORMAT ">>>>>9"                 INIT ""  /*0 */
FIELD policy     AS CHAR FORMAT "X(16)"                  INIT ""  /*1 */
FIELD cr_2       AS CHAR FORMAT "X(16)"                  INIT ""
FIELD Poltyp     AS CHAR FORMAT "X(3)"                   INIT ""  /*Policy Type*/
FIELD sticker    AS CHAR FORMAT "X(15)"                  INIT ""  /*16 Sticker no.*/ /*---a51-0253--*/
FIELD comdat     AS DATE FORMAT "99/99/9999"                      /*7  วันที่เริ่มต้น*/
FIELD expdat     AS DATE FORMAT "99/99/9999"                      /*8  วันที่สิ้นสุด*/
FIELD accdat     AS DATE FORMAT "99/99/9999"                      /*9  วันที่ใบกำกับภาษี*/
FIELD insref     AS CHAR FORMAT "X(10)"                  INIT ""  /*Insured Code*/
FIELD tiname     AS CHAR FORMAT "X(15)"                  INIT ""  /*   Title name*/
FIELD name1      AS CHAR FORMAT "X(50)"                  INIT ""  /*2  Name1*/
FIELD addr1      AS CHAR FORMAT "X(40)"                  INIT ""  /*3  Address 1*/
FIELD addr2      AS CHAR FORMAT "X(40)"                  INIT ""  /*   Address 2*/
FIELD addr3      AS CHAR FORMAT "X(40)"                  INIT ""  /*   Address 3*/
FIELD addr4      AS CHAR FORMAT "X(40)"                  INIT ""  /*   Address 4*/
FIELD icno       AS CHAR FORMAT "X(14)"                  INIT ""
FIELD vehreg     AS CHAR FORMAT "X(12)"                  INIT ""  /*11 ทะเบียนรถ*/
FIELD provin     AS CHAR FORMAT "X(2)"                   INIT ""  /*   จังหวัด*/
FIELD yrmanuf    AS INTE FORMAT "9999"                   INIT ""  /*   ปีจดทะเบียน*/
FIELD modcod     AS CHAR FORMAT "X(8)"                   INIT ""
FIELD makdes     AS CHAR FORMAT "X(18)"                  INIT ""  /*10 ยี่ห้อรถ*/
FIELD moddes     AS CHAR FORMAT "X(30)"                  INIT ""  /*1  รุ่นรถ *//*A57-0228*/
FIELD engine     AS CHAR FORMAT "X(05)"                  INIT ""  /*14 จำนวน CC.*/
FIELD body       AS CHAR FORMAT "X(15)"                  INIT ""  /*13 ชนิดของตัวรถ SEDAN ; PIKUP*/
FIELD access     AS CHAR FORMAT "X(30)"                  INIT ""  /*Accessorise*/
FIELD engno      AS CHAR FORMAT "X(20)"                  INIT ""  /*12 เลขที่เครื่องยนต์*/
FIELD cha_no     AS CHAR FORMAT "X(20)"                  INIT ""  /*12 เลขที่ตัวรถ*/
FIELD seats      AS CHAR FORMAT "X(2)"                   INIT ""  /*จำนวนที่นั่ง*/
FIELD orderno    AS CHAR FORMAT "X(10)"                  INIT ""  /* Order No.*/
FIELD finance    AS CHAR FORMAT "X(50)"                  INIT ""  /*Finance*/
FIELD dealer     AS CHAR FORMAT "X(30)"                  INIT ""  /*Dealer*/
FIELD si         AS DECI FORMAT ">>>,>>>,>>>,>>>9.99"    INIT 0  /*Cost / si*/
FIELD CLASS      AS CHAR FORMAT "X(4)"                   INIT ""  /*Class*//*A57-0228*/
FIELD remark     AS CHAR FORMAT "X(60)"                  INIT ""  /*หมายเหตุ*/
FIELD prem70     AS DECI FORMAT ">,>>>,>99.99"           INIT 0  /*Premium 70*/
FIELD premtot70  AS DECI FORMAT ">,>>>,>99.99"           INIT 0  /*Premium Total 70*/
FIELD prem       AS DECI FORMAT ">>>>>9.99"              INIT 0   /*17 เบี้ยประกันสุทธิ*/
FIELD stamp      AS DECI FORMAT ">>>9.99"                INIT 0   /*18 Stamp*/
FIELD tax        AS DECI FORMAT ">>>>9.99"               INIT 0   /*19 VAT  */
FIELD sumtotal   AS CHAR FORMAT ">>>>>9.99"              INIT 0   /*17 เบี้ยประกันสุทธิ*/
FIELD covcod     AS CHAR FORMAT "X(1)"                   INIT ""  /*Cover Type*/
FIELD vehusg     AS CHAR FORMAT "X(1)"                   INIT ""  /*15 ลักษณะการใช้รถ(1=รถส่วนบุคคล 2=รับจ้าง/ให้เช่า */
FIELD ncb        AS DECI FORMAT ">>9.99"                 INIT 0   /*NCB %*/
FIELD fleet      AS DECI FORMAT ">>9.99"                 INIT 0   /*Fleet %*/
FIELD baseprm    AS DECI FORMAT ">,>>>,>>9.99"           INIT 0  /*Base Premium*/
FIELD bip        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*TP BI/Person*/
FIELD bia        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*TP BI/Accident*/
FIELD pda        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*TP PD/Accident*/
FIELD m411       AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*411*/
FIELD m412       AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*412*/
FIELD m42        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*42*/
FIELD m43        AS DECI FORMAT ">>>,>>>,>>9.99"         INIT 0   /*43*/
FIELD rec_status  AS CHAR FORMAT "X(01)"                 INIT "Y"  /*20 Record Pass Status Y/N */
FIELD rec_comment AS CHAR FORMAT "X(100)"                INIT ""  /*21 Record Comment Must be Complete or comment */
FIELD COLOR1      AS CHAR FORMAT "X(30)"                 INIT ""  /*Phorn*//*A57-0228*/
FIELD comp        AS DECI FORMAT ">>>>9.99"              INIT 0   /*Phorn*//*A57-0228*/
FIELD prem_t      AS DECI FORMAT ">,>>>,>99.99"          INIT 0   /*Phorn*//*A57-0228*/
FIELD Text5       AS CHAR                                INIT "" /*Phorn*//*A57-0228*/
FIELD Text7       AS CHAR                                INIT "" /*Phorn*//*A57-0228*/
FIELD insnamtyp   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD firstName   AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD lastName    AS CHAR FORMAT "x(60)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD postcd      AS CHAR FORMAT "x(15)" INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeocc     AS CHAR FORMAT "x(4)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeaddr1   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeaddr2   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD codeaddr3   AS CHAR FORMAT "x(2)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD br_insured  AS CHAR FORMAT "x(5)"  INIT ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
FIELD campaign_ov AS CHAR FORMAT "x(30)" INIT "" . /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
.

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
DEFINE VAR nv_chkerror      AS CHAR INIT "".             /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

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
DEFINE VAR nv_totsi   AS DECI FORMAT ">>>,>>>,>>9.99-".
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
DEF VAR nv_fptr        AS RECID.
DEF VAR nv_bptr        AS RECID.
DEFINE VAR nv_41prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_42prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_43prmt   AS DECI FORMAT ">>>,>>>,>>9.99-".  /* fleet */
DEFINE VAR nv_pdprem   AS DECI FORMAT ">>>,>>>,>>9.99-".
DEFINE VAR nv_status   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
DEFINE VAR nv_baseprm3 AS DECI FORMAT ">>,>>>,>>9.99-".
DEFINE VAR nv_message   AS CHAR .   /*fleet YES=Complete , NO=Not Complete */
/* end A64-0138 */

