
/*Program name     : Import Text File SS STANDARD BROKER to Excel               */  
/*Program id       : wgwtexs1.p                                                 */
/*create by        : Kridtiya i. A58-0103                                       */  
/*                   แปลงเทคเป็นไฟล์excel                                       */  
/*DataBase connect : GW_STAT -LD BRSTAT */                                  
/********************************************************************************/

DEFINE INPUT        PARAMETER  nv_inputfile  AS CHAR      FORMAT "x(150)"     .
DEFINE INPUT        PARAMETER  nv_outputfile AS CHAR      FORMAT "x(150)"     .
/*
DEF  VAR nv_inputfile  AS CHAR      FORMAT "x(150)"      INIT "U:\testfile_02.txt" .
DEF  VAR nv_outputfile AS CHAR      FORMAT "x(150)"      INIT "U:\testfile_0205191016.csv" .*/
DEFINE VARIABLE nv_makeyr       AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_MinYear      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_MaxYear      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Fmakesi      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Tmakesi      AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Fcst         AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_Tcst         AS INTEGER   NO-UNDO.

DEFINE VARIABLE nv_Dedod        AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_AdDod        AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_DedPD        AS INTEGER   NO-UNDO.

DEFINE VARIABLE nv_fleet_per    AS DECIMAL   NO-UNDO.
DEFINE VARIABLE nv_ncbyrs       AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_ncb_per      AS DECIMAL   NO-UNDO.
DEFINE VARIABLE nv_loadclm_per  AS DECIMAL   NO-UNDO.
DEFINE VARIABLE nv_dspc_per     AS DECIMAL   NO-UNDO.

DEFINE VARIABLE nv_CST_C        AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_DriverName   AS LOGICAL   NO-UNDO.

DEFINE VARIABLE nv_Remark       AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_char         AS CHARACTER NO-UNDO.

DEFINE VARIABLE nv_count        AS INTEGER   NO-UNDO.

DEFINE STREAM nfile.
/* ----------------------------------------------------------------------- */
/************************************************************************************/
DEFINE NEW SHARED TEMP-TABLE  TEMPFile   NO-UNDO
/* */
FIELD CompanyCode             AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD CampaignCode            AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PrmCode                 AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PromotionNumber         AS CHARACTER FORMAT "x(15)"      INITIAL ""
/**/
FIELD covcod                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Class                   AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD SClass                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD GarageCd                AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Vehgrp                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
/**/
FIELD Make                    AS CHARACTER FORMAT "x(20)"      INITIAL ""
FIELD Model                   AS CHARACTER FORMAT "x(30)"      INITIAL ""
/**/
FIELD minyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD maxyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD Yrar_C                  AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD MaxCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD CST_C                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinSI                   AS INTEGER   FORMAT ">>,>>>,>>9" INITIAL 0
FIELD MaxSI                   AS INTEGER   FORMAT ">>,>>>,>>9" INITIAL 0
FIELD SI_C                    AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
/*ระบุชื่อ Y,N*/
FIELD DriverName              AS CHARACTER FORMAT "x"
/*อุปกรณ์เสริมพิเศษ*/
FIELD uom6_u                  AS CHARACTER FORMAT "x"          INITIAL ""
/*ชุด deduct*/
FIELD Dedod                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD AdDod                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD DedPD                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD fleet                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD ncb                     AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD dspc                    AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD loadclaim               AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD baseprm1                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0 
FIELD baseprm3                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0 
FIELD prm_t                   AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD prm_gap                 AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_t                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_gap              AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD Remark                  AS CHARACTER FORMAT "x(20)"       INITIAL ""

FIELD vehuse                  AS CHARACTER FORMAT "x(2)"        INITIAL ""
.
/************************************************************************************/
/* 
INDEX LoadFile01  IS PRIMARY  ProcessDate      ASCENDING 
                              ProcessTime      ASCENDING
INDEX LoadFile02              PolicyNumber     ASCENDING
INDEX LoadFile03              Registration     ASCENDING
INDEX LoadFile04              PolicyTypeCd     ASCENDING
                              RateGroup        ASCENDING
                              PolicyNumber     ASCENDING
INDEX LoadFile05              ConfirmBy        ASCENDING
                              PolicyNumber     ASCENDING
.
*/
/*DESCENDING.*/
DEFINE NEW SHARED TEMP-TABLE  TLoadFile   NO-UNDO
/* */
FIELD CompanyCode             AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD CampaignCode            AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PrmCode                 AS CHARACTER FORMAT "x(15)"      INITIAL ""
FIELD PromotionNumber         AS CHARACTER FORMAT "x(15)"      INITIAL ""
/**/
FIELD covcod                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Class                   AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD SClass                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD GarageCd                AS CHARACTER FORMAT "x(5)"       INITIAL ""
FIELD Vehgrp                  AS CHARACTER FORMAT "x(5)"       INITIAL ""
/**/
FIELD Make                    AS CHARACTER FORMAT "x(20)"      INITIAL ""
FIELD Model                   AS CHARACTER FORMAT "x(30)"      INITIAL ""
/**/
FIELD minyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD maxyrs                  AS INTEGER   FORMAT ">9"         INITIAL 0
FIELD Yrar_C                  AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD MaxCST                  AS INTEGER   FORMAT ">>>>9"      INITIAL 0
FIELD CST_C                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD MinSI                   AS INTEGER   FORMAT ">>,>>>,>>9"  INITIAL 0
FIELD MaxSI                   AS INTEGER   FORMAT ">>>,>>>,>>9" INITIAL 0
FIELD SI_C                    AS CHARACTER FORMAT "x(10)"       INITIAL ""
/**/
/*ระบุชื่อ Y,N*/
FIELD DriverName              AS LOGICAL   INITIAL NO
/*อุปกรณ์เสริมพิเศษ*/
FIELD uom6_u                  AS CHARACTER FORMAT "x"          INITIAL ""
/*ชุด deduct*/
FIELD Dedod                   AS DECIMAL   FORMAT ">>,>>9.99"  INITIAL 0
FIELD AdDod                   AS DECIMAL   FORMAT ">>,>>9.99"  INITIAL 0
FIELD DedPD                   AS DECIMAL   FORMAT ">>,>>9.99"  INITIAL 0
/**/
FIELD fleet_per               AS DECIMAL   FORMAT ">>9.99"     INITIAL 0
FIELD ncbyrs                  AS INTEGER   FORMAT "9"          INITIAL 0
FIELD ncb_per                 AS DECIMAL   FORMAT ">>9.99"     INITIAL 0
FIELD Dspc_per                AS DECIMAL   FORMAT ">>9.99"     INITIAL 0
FIELD loadclm_per             AS DECIMAL   FORMAT ">>>9.99"    INITIAL 0
/**/
FIELD fleet_c                 AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD ncb_c                   AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD Dspc_c                  AS CHARACTER FORMAT "x(10)"      INITIAL ""
FIELD loadclaim_c             AS CHARACTER FORMAT "x(10)"      INITIAL ""
/**/
FIELD baseprm1                AS INTEGER   FORMAT ">>>,>>9"    INITIAL 0
FIELD baseprm3                AS INTEGER   FORMAT ">>>,>>9"    INITIAL 0
FIELD MatchBase1              AS LOGICAL   
/**/
FIELD prm_t                   AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD prm_gap                 AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_t                AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD CMIprm_gap              AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0
FIELD MatchPrm_t              AS LOGICAL   INITIAL NO
FIELD MatchPrm_gp             AS LOGICAL   INITIAL NO
FIELD HasCalculateStep        AS LOGICAL   INITIAL NO
/**/
FIELD Remark                  AS CHARACTER FORMAT "x(20)"       INITIAL ""
FIELD vehuse                  AS CHARACTER FORMAT "x(2)"        INITIAL ""
.


DEFINE NEW SHARED TEMP-TABLE  LTestFile   NO-UNDO
/* */
FIELD TestText1  AS CHARACTER FORMAT "x(250)"       INITIAL ""
.

/* ----------------------------------------------------------------------- */
DEFINE VARIABLE nv_QNONumber  AS CHARACTER INITIAL "" NO-UNDO.

DEFINE VARIABLE nv_LQNO      AS LOGICAL   INITIAL NO NO-UNDO.
DEFINE VARIABLE nv_RecLQNO   AS RECID     INITIAL ?  NO-UNDO.

DEFINE VARIABLE nv_column    AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_rcolumn   AS INTEGER   NO-UNDO.
DEFINE VARIABLE nv_lcolumn   AS INTEGER   NO-UNDO.

DEFINE VARIABLE nv_text1     AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_text2     AS CHARACTER INITIAL "" NO-UNDO.
DEFINE VARIABLE nv_text3     AS CHARACTER INITIAL "" NO-UNDO.
/* ----------------------------------------------------------------------- */
DEFINE NEW SHARED TEMP-TABLE  LQNO   NO-UNDO /*ใบแจ้งคุ้มครองรถยนต์*/
/* */
FIELD QNODesc   AS CHARACTER FORMAT "x(50)"       INITIAL ""  /*ใบแจ้งคุ้มครองรถยนต์*/
FIELD QNOText   AS CHARACTER FORMAT "x(50)"       INITIAL ""  /*No. 58-70840*/
FIELD QNOno     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*No.*/
FIELD QNONumber AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
.

DEFINE NEW SHARED TEMP-TABLE  LCompany   NO-UNDO /*บริษัทประกันภัย*/
/* */
FIELD QNONumber   AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBCompany  AS CHARACTER FORMAT "x(50)"       INITIAL "" /*บริษัทประกันภัย*/
FIELD CompanyDesc AS CHARACTER FORMAT "x(50)"       INITIAL "" /*บริษัท ประกันคุ้มภัย จำกัด (มหาชน) (สนญ)*/
.

DEFINE VARIABLE nv_L1Insured      AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL1Insured   AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L1Insured   NO-UNDO  /*ชื่อผู้เอาประกัน*/
/* */
FIELD QNONumber AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBName   AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD FName     AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD SName     AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD FLBICno   AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD Icno      AS CHARACTER FORMAT "x(50)"       INITIAL "" 
.

DEFINE VARIABLE nv_L1AddrC      AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL1AddrC   AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L1AddrC   NO-UNDO  /*ที่อยู่ปัจจุบัน*/
/* */
FIELD QNONumber AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBAddr   AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD Addr      AS CHARACTER FORMAT "x(150)"      INITIAL "" 
FIELD FLBP      AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD Pdesc     AS CHARACTER FORMAT "x(50)"       INITIAL "" 
.

DEFINE VARIABLE nv_L1AddrDC      AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL1AddrDC   AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L1AddrDC   NO-UNDO /*ที่อยู่ส่งเอกสาร*/
/* */
FIELD QNONumber AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBAddr   AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD Addr      AS CHARACTER FORMAT "x(150)"      INITIAL "" 
FIELD FLBP      AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD Pdesc     AS CHARACTER FORMAT "x(50)"       INITIAL "" 
.

DEFINE VARIABLE nv_L2DrvNameType    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL2DrvNameType AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L2DrvNameType   NO-UNDO /*ระบุผู้ขับขี่*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBDrvNm      AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD DrvNmNot      AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD DrvNmNotCd    AS CHARACTER FORMAT "x(02)"       INITIAL ""
FIELD DrvNmSelect   AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD DrvNmSelectCd AS CHARACTER FORMAT "x(02)"       INITIAL "" 
.

DEFINE VARIABLE nv_L2DrvName1    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL2DrvName1 AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L2DrvName1   NO-UNDO /*ผู้ขับขี่1*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBDrvNm      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBNm         AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD DrvNm         AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD FLBBrtDt      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD BrtDt         AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBIcno       AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD Icno          AS CHARACTER FORMAT "x(20)"       INITIAL "" 
FIELD FLBExt        AS CHARACTER FORMAT "x(10)"       INITIAL "" 
FIELD Ext           AS CHARACTER FORMAT "x(20)"       INITIAL ""
FIELD FLBFirstDt    AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FirstDt       AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBExtDt      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD ExtDt         AS CHARACTER FORMAT "x(15)"       INITIAL ""
.


DEFINE VARIABLE nv_L2DrvName2    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL2DrvName2 AS RECID   INITIAL ?   NO-UNDO.


DEFINE NEW SHARED TEMP-TABLE  L2DrvName2   NO-UNDO /*ผู้ขับขี่2*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBDrvNm      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBNm         AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD DrvNm         AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD FLBBrtDt      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD BrtDt         AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBIcno       AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD Icno          AS CHARACTER FORMAT "x(20)"       INITIAL "" 
FIELD FLBExt        AS CHARACTER FORMAT "x(10)"       INITIAL "" 
FIELD Ext           AS CHARACTER FORMAT "x(20)"       INITIAL ""
FIELD FLBFirstDt    AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FirstDt       AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBExtDt      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD ExtDt         AS CHARACTER FORMAT "x(15)"       INITIAL ""
.


DEFINE VARIABLE nv_L3Benc    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL3Benc AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L3Benc   NO-UNDO /*ผู้รับผลประโยชน์*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBBenc       AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD BencNm1       AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD BencNm2       AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD BencFin       AS CHARACTER FORMAT "x(50)"       INITIAL ""
.

DEFINE VARIABLE nv_L4Garage     AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL4Garage AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L4Garage   NO-UNDO /*รายละเอียดความคุ้มครอง*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBGarage     AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD GarageNm1     AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD GNm1Cd        AS CHARACTER FORMAT "x(10)"       INITIAL ""
FIELD GarageNm2     AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD GNm2Cd        AS CHARACTER FORMAT "x(10)"       INITIAL ""
.

DEFINE VARIABLE nv_L4Make         AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL4Make      AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L4Make   NO-UNDO /*ชื่อรถยนต์/รุ่น */
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBclass      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBmoddes     AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBvehreg     AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBeng_no     AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLByrmanu     AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBbody       AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBseats      AS CHARACTER FORMAT "x(15)"       INITIAL "" /*จำนวนที่นั่ง/ขนาด/น้ำหนัก*/
/**/
FIELD class         AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD moddes        AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD vehreg        AS CHARACTER FORMAT "x(30)"       INITIAL ""
FIELD eng_no        AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD yrmanu        AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD body          AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD sct           AS CHARACTER FORMAT "x(25)"       INITIAL ""
FIELD seats         AS CHARACTER FORMAT "x(10)"       INITIAL ""
FIELD cc            AS CHARACTER FORMAT "x(10)"       INITIAL ""
FIELD ton           AS CHARACTER FORMAT "x(10)"       INITIAL ""
.

DEFINE VARIABLE nv_L5SI    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL5SI AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L5SI   NO-UNDO /*ประเภททุน*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBsi         AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD covcod70      AS CHARACTER FORMAT "x(5)"        INITIAL ""
FIELD covcod72      AS CHARACTER FORMAT "x(5)"        INITIAL ""
FIELD si            AS CHARACTER FORMAT "x(10)"       INITIAL ""
FIELD FLBcomdat     AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD comdat        AS CHARACTER FORMAT "x(12)"       INITIAL ""  /*พศ.เปลี่ยนเป็นคศ.*/
FIELD FLBextdat     AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD extdat        AS CHARACTER FORMAT "x(12)"       INITIAL ""  /*พศ.เปลี่ยนเป็นคศ.*/
.

DEFINE VARIABLE nv_L6Ref     AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL6Ref  AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L6Ref   NO-UNDO /*อ้างถึง บริษัทประกันเดิม */
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBRef        AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD RefNm         AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD FLBRefno      AS CHARACTER FORMAT "x(40)"       INITIAL ""
FIELD Refno         AS CHARACTER FORMAT "x(20)"       INITIAL ""
.

DEFINE VARIABLE nv_L7Prm70    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL7Prm70 AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L7Prm70   NO-UNDO /*เบี้ยรวมภาษีอากร*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBgrp        AS CHARACTER FORMAT "x(30)"       INITIAL "" 
FIELD gr_p70        AS CHARACTER FORMAT "x(12)"       INITIAL ""
FIELD cur1          AS CHARACTER FORMAT "x(10)"       INITIAL ""
FIELD FLBprem_t     AS CHARACTER FORMAT "x(30)"       INITIAL "" 
FIELD prem_t70      AS CHARACTER FORMAT "x(12)"       INITIAL ""
FIELD cur2          AS CHARACTER FORMAT "x(10)"       INITIAL ""
.

DEFINE VARIABLE nv_L8Prm72    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL8Prm72 AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L8Prm72   NO-UNDO /*พ.ร.บ.*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBcomp       AS CHARACTER FORMAT "x(10)"       INITIAL "" 
FIELD FLBcompdo     AS CHARACTER FORMAT "x(20)"       INITIAL "" 
FIELD compdo        AS CHARACTER FORMAT "x(2)"        INITIAL "" 
FIELD FLBcompnot    AS CHARACTER FORMAT "x(20)"       INITIAL "" 
FIELD compnot       AS CHARACTER FORMAT "x(2)"        INITIAL "" 
/**/
FIELD FLBcomp72     AS CHARACTER FORMAT "x(20)"       INITIAL "" /*พ.ร.บ. รวมภาษีอากร*/
FIELD gr_p72        AS CHARACTER FORMAT "x(12)"       INITIAL ""
FIELD cur1          AS CHARACTER FORMAT "x(10)"       INITIAL ""
.


DEFINE VARIABLE nv_L9comdat     AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL9comdat  AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L9comdat   NO-UNDO /*พ.ร.บ เริ่มคุ้มครอง */
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBcomdat     AS CHARACTER FORMAT "x(20)"       INITIAL "" 
FIELD comdat72      AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBexpdat     AS CHARACTER FORMAT "x(20)"       INITIAL "" /*พ.ร.บ. สิ้นสุดความคุ้มครอง*/
FIELD expdat72      AS CHARACTER FORMAT "x(15)"       INITIAL ""
.

DEFINE VARIABLE nv_L10Insp    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL10Insp AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L10Insp   NO-UNDO /*นัดตรวจสภาพรถยนต์ ติดต่อ*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBInsp       AS CHARACTER FORMAT "x(30)"       INITIAL "" 
FIELD InspNm        AS CHARACTER FORMAT "x(50)"       INITIAL "" 
FIELD FLBmobile     AS CHARACTER FORMAT "x(30)"       INITIAL "" /*เบอร์มือถือ*/
FIELD Inspmobile    AS CHARACTER FORMAT "x(30)"       INITIAL "" 
FIELD FLBphone      AS CHARACTER FORMAT "x(20)"       INITIAL "" /*เบอร์ที่บ้าน / ทำงาน*/
FIELD Inspphone     AS CHARACTER FORMAT "x(30)"       INITIAL "" 
.

DEFINE VARIABLE nv_L11Cur    AS LOGICAL INITIAL NO  NO-UNDO.
DEFINE VARIABLE nv_RecL11Cur AS RECID   INITIAL ?   NO-UNDO.

DEFINE NEW SHARED TEMP-TABLE  L11Cur   NO-UNDO /*วิธีชำระเงิน*/
/* */
FIELD QNONumber     AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*58-70840*/
FIELD FLBCur        AS CHARACTER FORMAT "x(20)"       INITIAL ""  /*วิธีชำระเงิน*/
FIELD Curpay        AS CHARACTER FORMAT "x(150)"      INITIAL ""
FIELD Curunit       AS CHARACTER FORMAT "x(30)"       INITIAL ""
FIELD remark        AS CHARACTER FORMAT "x(150)"      INITIAL ""
FIELD FLBAgentReq   AS CHARACTER FORMAT "x(20)"       INITIAL "" /*ผู้แจ้งงาน*/
FIELD AgentReq      AS CHARACTER FORMAT "x(50)"       INITIAL ""
FIELD FLBAgentCd    AS CHARACTER FORMAT "x(10)"       INITIAL ""
FIELD AgentCd       AS CHARACTER FORMAT "x(10)"       INITIAL ""
FIELD FLBReqDate    AS CHARACTER FORMAT "x(15)"       INITIAL "" /*วันที่แจ้งงาน*/
FIELD ReqDate       AS CHARACTER FORMAT "x(15)"       INITIAL ""
FIELD FLBMemo       AS CHARACTER FORMAT "x(12)"       INITIAL ""
FIELD Memoby        AS CHARACTER FORMAT "x(40)"       INITIAL ""
.
DEFINE NEW SHARED TEMP-TABLE  workf_out   NO-UNDO
    FIELD QNONumber     AS CHARACTER FORMAT "x(20)"    INITIAL ""  
    FIELD ntitle        AS CHARACTER FORMAT "x(30)"    INITIAL ""  
    FIELD insname       AS CHARACTER FORMAT "x(100)"   INITIAL ""
    FIELD icno          AS CHARACTER FORMAT "x(15)"    INITIAL ""
    FIELD addr1         AS CHARACTER FORMAT "x(50)"    INITIAL ""
    FIELD addr2         AS CHARACTER FORMAT "x(40)"    INITIAL ""
    FIELD addr3         AS CHARACTER FORMAT "x(40)"    INITIAL ""
    FIELD addr4         AS CHARACTER FORMAT "x(40)"    INITIAL ""
    FIELD subclass      AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD brand         AS CHARACTER FORMAT "x(30)"    INITIAL "" 
    FIELD model         AS CHARACTER FORMAT "x(50)"    INITIAL ""
    FIELD eng_cc        AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD tons          AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD Seat          AS CHARACTER FORMAT "x(5)"     INITIAL "" 
    FIELD body          AS CHARACTER FORMAT "x(20)"    INITIAL ""
    FIELD vehreg        AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD engno         AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD cha_no        AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD caryear       AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD vehuse        AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD garage        AS CHARACTER FORMAT "x(1)"    INITIAL ""
    FIELD covcod        AS CHARACTER FORMAT "x(5)"     INITIAL ""
    FIELD sumins        AS CHARACTER FORMAT "x(30)"    INITIAL ""
    FIELD volprem       AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD netprem       AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD comprem       AS CHARACTER FORMAT "x(35)"    INITIAL ""
    FIELD bennames      AS CHARACTER FORMAT "x(60)"    INITIAL ""
    FIELD drino         AS CHARACTER FORMAT "x(15)"    INITIAL ""
    FIELD driver1       AS CHARACTER FORMAT "x(80)"    INITIAL ""
    FIELD dribirth1     AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD driver2       AS CHARACTER FORMAT "x(80)"    INITIAL ""
    FIELD dribirth2     AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD comdat        AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD expdat        AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD companyold    AS CHARACTER FORMAT "x(60)"    INITIAL ""
    FIELD prevpol       AS CHARACTER FORMAT "x(20)"    INITIAL ""
    FIELD comdat72      AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD expdat72      AS CHARACTER FORMAT "x(10)"    INITIAL ""
    FIELD InspNm        AS CHARACTER FORMAT "x(60)"    INITIAL "" 
    FIELD Inspmobile    AS CHARACTER FORMAT "x(60)"    INITIAL "" 
    FIELD remark        AS CHARACTER FORMAT "x(100)"    INITIAL ""  
    FIELD AgentReq      AS CHARACTER FORMAT "x(50)"    INITIAL ""  /*ผู้แจ้ง*/      
    FIELD AgentCd       AS CHARACTER FORMAT "x(10)"    INITIAL ""  /*รหัส*/         
    FIELD ReqDate       AS CHARACTER FORMAT "x(10)"    INITIAL ""  /*วันที่แจ้ง*/   
    FIELD Memoby        AS CHARACTER FORMAT "x(30)"    INITIAL ""  /*ผู้ตรวจ*/ 
    FIELD addr_rep      AS CHARACTER FORMAT "x(150)"   INITIAL ""
    .

/* ----------------------------------------------------------------------- */

nv_Remark = "".

/*INPUT STREAM nfile FROM "D:\WebBU\RATCHANEE_SaeLoo\testfile.TXT".*/
/*INPUT STREAM nfile FROM "U:\testfile_01.TXT".*/
/*INPUT STREAM nfile FROM "U:\testfile_01.TXT" .*/


INPUT STREAM nfile FROM VALUE(nv_inputfile)  .  /*รับค่าจากโปรแกรม */

/* ************************************************************************************************ */
/* ************************************************************************************************ */

DEFINE VAR nv_daily     AS CHARACTER FORMAT "X(770)"      INITIAL ""  NO-UNDO.
DEFINE VAR nv_chr       AS CHARACTER FORMAT "X(01)"       INITIAL ""  NO-UNDO.

FOR EACH workf_out .
    DELETE workf_out.
END.

nv_daily = "".
loop_source:

DO WHILE LASTKEY <> -2:

  READKEY STREAM nfile.

  nv_chr = chr(LASTKEY).

  IF LASTKEY = 13 THEN DO:
    /*
    IF SUBSTR(nv_daily,  1,  2) = "01" OR /*1  RECORID "02"*/
       SUBSTR(nv_daily,  1,  2) = "09"
    THEN DO:
      nv_daily = "".
      NEXT loop_source.
    END.
    -*/

    /*DISPLAY nv_daily FORMAT "X(50)".

    PAUSE 0.*/


    /* วิธีชำระเงิน --------------------------------------------------- */
    /*11*/
    IF nv_L11Cur = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L11Cur WHERE RECID(L11Cur) = nv_RecL11Cur NO-ERROR.
        IF AVAILABLE L11Cur THEN DO:

          IF    INDEX(TRIM(nv_daily),"เงินสด")     <> 0
             OR INDEX(TRIM(nv_daily),"เช็ค")       <> 0
             OR INDEX(TRIM(nv_daily),"บัตรเครดิต") <> 0
             OR INDEX(TRIM(nv_daily),"ออมทรัพย์")  <> 0
          THEN DO:

            L11Cur.Curpay = TRIM(nv_daily).
          END.
          IF INDEX(TRIM(nv_daily),"แบ่งชำระ") <> 0 THEN DO:

            L11Cur.Curunit = TRIM(nv_daily).
          END.
          IF INDEX(TRIM(nv_daily),"หมายเหตุ") <> 0 THEN DO:

            L11Cur.remark = TRIM(nv_daily).
          END.
          /**/
          IF INDEX(TRIM(nv_daily),"ผู้แจ้งงาน") <> 0 THEN DO:

            L11Cur.FLBAgentReq = TRIM(nv_daily).
            nv_column = 100.
          END.

          IF nv_column = 101 THEN DO: 
            L11Cur.AgentReq   = TRIM(nv_daily).

            IF SUBSTR(L11Cur.AgentReq,1,1) = " " THEN
              L11Cur.AgentReq   = SUBSTR(L11Cur.AgentReq,2,100).
            IF SUBSTR(L11Cur.AgentReq,1,1) = " " THEN
              L11Cur.AgentReq   = SUBSTR(L11Cur.AgentReq,2,100).
            IF SUBSTR(L11Cur.AgentReq,1,1) = " " THEN
              L11Cur.AgentReq   = SUBSTR(L11Cur.AgentReq,2,100).
            IF SUBSTR(L11Cur.AgentReq,1,1) = " " THEN
              L11Cur.AgentReq   = SUBSTR(L11Cur.AgentReq,2,100).
          END.
          IF nv_column = 102 THEN L11Cur.FLBAgentCd = TRIM(nv_daily).
          IF nv_column = 103 THEN L11Cur.AgentCd    = TRIM(nv_daily).
          /**/
          IF nv_column = 104 THEN L11Cur.FLBReqDate = TRIM(nv_daily).
          IF nv_column = 105 THEN DO: 
            L11Cur.ReqDate    = TRIM(nv_daily).
            L11Cur.ReqDate    = TRIM(L11Cur.ReqDate).
          END.
          IF nv_column = 106 THEN L11Cur.FLBMemo    = TRIM(nv_daily).
          IF nv_column = 107 THEN DO:

            nv_daily = TRIM(REPLACE(nv_daily,"_","")).
            L11Cur.Memoby     = TRIM(nv_daily).

            /* ****************** *

            LEAVE.
            * ****************** */
          END.
        END.
      END.
    END.

    IF TRIM(nv_daily) = "วิธีชำระเงิน" THEN DO:
  
      CREATE L11Cur.
      L11Cur.FLBCur    = TRIM(nv_daily). 
      L11Cur.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10. */

      nv_L10Insp     = NO.
      nv_RecL10Insp  = ?.

      nv_L11Cur    = YES.
      nv_RecL11Cur = RECID(L11Cur).
      nv_column    = 1.
    END.

    /* นัดตรวจสภาพรถยนต์ ติดต่อ -------------------------------------------------- */
    /*10*/
    IF nv_L10Insp = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L10Insp WHERE RECID(L10Insp) = nv_RecL10Insp NO-ERROR.
        IF AVAILABLE L10Insp THEN DO:

          IF nv_column = 2   THEN L10Insp.InspNm     = TRIM(nv_daily).
          IF nv_column = 4   THEN L10Insp.Inspmobile = TRIM(nv_daily).
          IF nv_column = 109 THEN L10Insp.Inspphone  = TRIM(nv_daily).


          IF INDEX(TRIM(nv_daily),"เบอร์มือถือ") <> 0 THEN DO:

            L10Insp.FLBmobile = TRIM(nv_daily).
          END.
          IF INDEX(TRIM(nv_daily),"เบอร์ที่บ้าน") <> 0 THEN DO:

            L10Insp.FLBphone = TRIM(nv_daily).
            nv_column = 108.
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"นัดตรวจสภาพรถยนต์ ติดต่อ") <> 0 THEN DO:
  
      CREATE L10Insp.
      L10Insp.FLBInsp   = TRIM(nv_daily). 
      L10Insp.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10.*/

      nv_L9comdat    = NO.
      nv_RecL9comdat = ?.

      nv_L10Insp    = YES.
      nv_RecL10Insp = RECID(L10Insp).
      nv_column     = 1.
    END.

    /* พ.ร.บ เริ่มคุ้มครอง ------------------------------------------------- */
    /*9*/
    IF nv_L9comdat = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L9comdat WHERE RECID(L9comdat) = nv_RecL9comdat NO-ERROR.
        IF AVAILABLE L9comdat THEN DO:

               IF nv_column = 2 THEN L9comdat.comdat72 = TRIM(nv_daily).
          ELSE IF nv_column = 5 THEN L9comdat.expdat72 = TRIM(nv_daily).

          IF INDEX(TRIM(nv_daily),"พ.ร.บ. สิ้นสุดความคุ้มครอง") <> 0 THEN DO:

            L9comdat.FLBexpdat = TRIM(nv_daily).
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"พ.ร.บ เริ่มคุ้มครอง") <> 0 THEN DO:
  
      CREATE L9comdat.
      L9comdat.FLBcomdat = TRIM(nv_daily). 
      L9comdat.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10. */

      nv_L8Prm72    = NO.
      nv_RecL8Prm72 = ?.

      nv_L9comdat    = YES.
      nv_RecL9comdat = RECID(L9comdat).
      nv_column      = 1.
    END.

    /* "พ.ร.บ. ------------------------------------------------------------- */
    /*8*/
    IF nv_L8Prm72 = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L8Prm72 WHERE RECID(L8Prm72) = nv_RecL8Prm72 NO-ERROR.
        IF AVAILABLE L8Prm72 THEN DO:
               IF nv_column = 2 THEN DO: 
                   L8Prm72.FLBcompdo = TRIM(nv_daily).

                   IF INDEX(TRIM(nv_daily),"X") <> 0 THEN L8Prm72.compdo = "X".
               END.
          ELSE IF nv_column = 3 THEN DO:
                   L8Prm72.FLBcompnot = TRIM(nv_daily).

                   IF INDEX(TRIM(nv_daily),"X") <> 0 THEN L8Prm72.compnot = "X".
          END.
          ELSE IF nv_column = 4 THEN L8Prm72.FLBcomp72 = TRIM(nv_daily).
          ELSE IF nv_column = 5 THEN L8Prm72.gr_p72    = TRIM(nv_daily).
          ELSE IF nv_column = 6 THEN L8Prm72.cur1      = TRIM(nv_daily).
        END.
      END.
    END.

    IF TRIM(nv_daily) = "พ.ร.บ." THEN DO:
  
      CREATE L8Prm72.
      L8Prm72.FLBcomp = TRIM(nv_daily). 
      L8Prm72.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10.*/

      nv_L7Prm70    = NO.
      nv_RecL7Prm70 = ?.

      nv_L8Prm72    = YES.
      nv_RecL8Prm72 = RECID(L8Prm72).
      nv_column     = 1.
    END.

    /* เบี้ยรวมภาษีอากร -------------------------------------------------- */
    /*7*/
    IF nv_L7Prm70 = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L7Prm70 WHERE RECID(L7Prm70) = nv_RecL7Prm70 NO-ERROR.
        IF AVAILABLE L7Prm70 THEN DO:

               IF nv_column = 2  THEN L7Prm70.gr_p70    = TRIM(nv_daily).
          ELSE IF nv_column = 3  THEN L7Prm70.cur1      = TRIM(nv_daily).
          ELSE IF nv_column = 4  THEN L7Prm70.FLBprem_t = TRIM(nv_daily).
          ELSE IF nv_column = 5  THEN L7Prm70.prem_t70  = TRIM(nv_daily).
          ELSE IF nv_column = 6  THEN L7Prm70.cur2      = TRIM(nv_daily).
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"เบี้ยรวมภาษีอากร") <> 0 THEN DO:
  
      CREATE L7Prm70.
      L7Prm70.FLBgrp    = TRIM(nv_daily). 
      L7Prm70.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10.*/

      nv_L6Ref    = NO.
      nv_RecL6Ref = ?.

      nv_L7Prm70    = YES.
      nv_RecL7Prm70 = RECID(L7Prm70).
      nv_column     = 1.
    END.

    /* อ้างถึง บริษัทประกันเดิม ---------------------------------------------------- */
    /*6*/
    IF nv_L6Ref = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L6Ref WHERE RECID(L6Ref) = nv_RecL6Ref NO-ERROR.
        IF AVAILABLE L6Ref THEN DO:
               IF nv_column = 2  THEN L6Ref.RefNm     = TRIM(nv_daily).
          ELSE IF nv_column = 3  THEN DO:
              L6Ref.FLBRefno  = TRIM(nv_daily).
              L6Ref.Refno     = TRIM(REPLACE(L6Ref.FLBRefno,"เลขที่","")).
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"อ้างถึง บริษัทประกันเดิม") <> 0 THEN DO:
  
      CREATE L6Ref.
      L6Ref.FLBRef = TRIM(nv_daily). 
      L6Ref.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10. */

      nv_L5SI    = NO.
      nv_RecL5SI = ?.

      nv_L6Ref    = YES.
      nv_RecL6Ref = RECID(L6Ref).
      nv_column   = 1.
    END.

    /* ประเภททุน --------------------------------------------------------- */
    /*5*/
    IF nv_L5SI = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L5SI WHERE RECID(L5SI) = nv_RecL5SI NO-ERROR.
        IF AVAILABLE L5SI THEN DO:
          IF INDEX(TRIM(nv_daily),"เริ่มคุ้มครอง") <> 0 THEN DO:

            L5SI.FLBcomdat = TRIM(nv_daily).
            L5SI.comdat    = TRIM(REPLACE(L5SI.FLBcomdat,"เริ่มคุ้มครอง","")).
          END.
          IF INDEX(TRIM(nv_daily),"สิ้นสุดความคุ้มครอง") <> 0 THEN DO:

            L5SI.FLBextdat = TRIM(nv_daily).
            L5SI.extdat    = TRIM(REPLACE(L5SI.FLBextdat,"สิ้นสุดความคุ้มครอง","")).
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"ประเภททุน") <> 0 THEN DO:
  
      CREATE L5SI.
      L5SI.FLBsi = TRIM(nv_daily). 
      L5SI.QNONumber = nv_QNONumber.

      nv_text1   = TRIM(nv_daily). 
      nv_text2   = "".
      nv_text3   = "".
      nv_lcolumn = 0.
      nv_rcolumn = 0.

      IF R-INDEX(TRIM(nv_text1),"ประเภท") <> 0 THEN DO:

        nv_text2 = TRIM(SUBSTR(TRIM(nv_text1),R-INDEX(TRIM(nv_text1),"ประเภท") ,30)).

        nv_text2 = TRIM(SUBSTR(TRIM(nv_text2),1,R-INDEX(TRIM(nv_text2),"ทุน") - 1 )).

        nv_text2 = TRIM(REPLACE(nv_text2,"ประเภท","")).

        IF INDEX(TRIM(nv_text2),"+") <> 0 THEN DO:

          L5SI.covcod70 = TRIM(SUBSTR(nv_text2,1,INDEX(TRIM(nv_text2),"+") - 1)).
          L5SI.covcod72 = TRIM(SUBSTR(nv_text2,INDEX(TRIM(nv_text2),"+") + 1,10)).
        END.
        ELSE DO:
          L5SI.covcod70 = TRIM(nv_text2).
        END.
      END.

      IF R-INDEX(TRIM(nv_text1),"ทุน") <> 0 THEN DO:

        nv_text3 = TRIM(SUBSTR(TRIM(nv_text1),R-INDEX(TRIM(nv_text1),"ทุน") ,30)).
        nv_text3 = TRIM(REPLACE(nv_text3,"ทุน","")).
        /*
        nv_text3 = REPLACE(nv_text3,".00",""). */
        L5SI.si = TRIM(nv_text3).
      END.

      /*
      DISPLAY "aaa" nv_text1 FORMAT "x(30)"
                    nv_text2 FORMAT "x(30)"
                    nv_text3 FORMAT "x(30)" 
      WITH FRAME aabb. PAUSE . */

      nv_L4Make    = NO.
      nv_RecL4Make = ?.

      nv_L5SI    = YES.
      nv_RecL5SI = RECID(L5SI).
      nv_column  = 1.
    END.

    /* ชื่อรถยนต์/รุ่น --------------------------------------------------- */
    /*4.1*/
    IF nv_L4Make = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L4Make WHERE RECID(L4Make) = nv_RecL4Make NO-ERROR.
        IF AVAILABLE L4Make THEN DO:

          IF INDEX(TRIM(nv_daily),"เลขทะเบียน") <> 0 THEN
             L4Make.FLBvehreg = TRIM(nv_daily).

          IF INDEX(TRIM(nv_daily),"เลขตัวถัง") <> 0 OR
             INDEX(TRIM(nv_daily),"เลขเครื่องยนต์") <> 0
          THEN DO:
            IF L4Make.FLBeng_no = "" THEN L4Make.FLBeng_no = TRIM(nv_daily).
          END.

          IF INDEX(TRIM(nv_daily),"ปีรุ่น") <> 0 THEN
             L4Make.FLByrmanu = TRIM(nv_daily).

          IF INDEX(TRIM(nv_daily),"แบบตัวถัง") <> 0 THEN
             L4Make.FLBbody   = TRIM(nv_daily).

          IF INDEX(TRIM(nv_daily),"จำนวนที่นั่ง/ขนาด/น้ำหนัก") <> 0 THEN DO:

            L4Make.FLBseats  = TRIM(nv_daily).

            nv_column = 100.
          END.

               IF nv_column = 101  THEN L4Make.class     = TRIM(nv_daily).
          ELSE IF nv_column = 102  THEN L4Make.moddes    = TRIM(nv_daily).
          ELSE IF nv_column = 103  THEN DO:

             L4Make.vehreg    = TRIM(nv_daily).   /*ต้องให้ จังหวัดอยู่บรรทัดเดียวกัน*/
          END.
          ELSE IF nv_column = 104  THEN L4Make.eng_no    = TRIM(nv_daily).
          ELSE IF nv_column = 105  THEN L4Make.yrmanu    = TRIM(nv_daily).
          ELSE IF nv_column = 106  THEN L4Make.body      = TRIM(nv_daily).
          ELSE IF nv_column = 107  THEN DO:

            L4Make.sct   = TRIM(nv_daily).
            nv_lcolumn   = 0.
            nv_rcolumn   = 0.
            nv_lcolumn   = INDEX(L4Make.sct,"/").
            nv_rcolumn   = R-INDEX(L4Make.sct,"/").

            L4Make.seats = SUBSTR(L4Make.sct,1,nv_lcolumn - 1).
            L4Make.seats = TRIM(REPLACE(L4Make.seats,"-","")).

            L4Make.cc    = SUBSTR(L4Make.sct,nv_lcolumn + 1,nv_rcolumn - 1).
            L4Make.cc    = TRIM(REPLACE(L4Make.cc,"-","")).
            L4Make.cc    = TRIM(REPLACE(L4Make.cc,"/","")).

            L4Make.ton   = SUBSTR(L4Make.sct,nv_rcolumn + 1,15).
            L4Make.ton   = TRIM(REPLACE(L4Make.ton,"-","")).
            L4Make.ton   = TRIM(REPLACE(L4Make.ton,"-","")).
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"ชื่อรถยนต์/รุ่น") <> 0 THEN DO:
  
      CREATE L4Make.
      L4Make.FLBmoddes = TRIM(nv_daily). 
      L4Make.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10.*/

      nv_L4Garage    = NO.
      nv_RecL4Garage = ?.

      nv_L4Make    = YES.
      nv_RecL4Make = RECID(L4Make).
      nv_column    = 1.
    END.

    /* รายละเอียดความคุ้มครอง ------------------------------------------------- */
    /*4*/
    IF nv_L4Garage = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L4Garage WHERE RECID(L4Garage) = nv_RecL4Garage NO-ERROR.
        IF AVAILABLE L4Garage THEN DO:
               IF nv_column = 2 THEN DO: 
                   L4Garage.GarageNm1 = TRIM(nv_daily).

                   IF INDEX(TRIM(nv_daily),"X") <> 0 THEN L4Garage.GNm1Cd = "X".
               END.
          ELSE IF nv_column = 3 THEN DO:
                   L4Garage.GarageNm2 = TRIM(nv_daily).

                   IF INDEX(TRIM(nv_daily),"X") <> 0 THEN L4Garage.GNm2Cd = "X".
          END.
          /*
          ELSE IF nv_column = 4 THEN L4Garage. = TRIM(nv_daily).
          */
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"รายละเอียดความคุ้มครอง") <> 0 THEN DO:
 
      CREATE L4Garage.
      L4Garage.FLBGarage = TRIM(nv_daily). 
      L4Garage.QNONumber = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10.*/

      nv_L3Benc    = NO.
      nv_RecL3Benc = ?.

      nv_L4Garage    = YES.
      nv_RecL4Garage = RECID(L4Garage).
      nv_column    = 1.
    END.

    /* ผู้รับผลประโยชน์ --------------------------------------------------- */
    /*3*/
    IF nv_L3Benc = YES THEN DO:

      nv_column = nv_column + 1.

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L3Benc WHERE RECID(L3Benc) = nv_RecL3Benc NO-ERROR.
        IF AVAILABLE L3Benc THEN DO:
               IF nv_column = 2 THEN L3Benc.BencNm1 = TRIM(nv_daily).
          ELSE IF nv_column = 3 THEN L3Benc.BencNm2 = TRIM(nv_daily).
          ELSE IF nv_column = 4 THEN L3Benc.BencFin = TRIM(nv_daily).
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"ผู้รับผลประโยชน์") <> 0 THEN DO:

      CREATE L3Benc.
      L3Benc.FLBBenc = TRIM(nv_daily). 
      L3Benc.QNONumber = nv_QNONumber.
      
      nv_L2DrvName2    = NO.
      nv_RecL2DrvName2 = ?.

      nv_L3Benc    = YES.
      nv_RecL3Benc = RECID(L3Benc).
      nv_column    = 1.
    END.

    /* ผู้ขับขี่ 2 ----------------------------------------------- */
    /*2.2*/
    IF nv_L2DrvName2 = YES THEN DO:

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L2DrvName2 WHERE RECID(L2DrvName2) = nv_RecL2DrvName2 NO-ERROR.
        IF AVAILABLE L2DrvName2 THEN DO:

          IF INDEX(TRIM(nv_daily),"ชื่อ") <> 0 THEN DO:
            L2DrvName2.FLBNm = TRIM(nv_daily).
            L2DrvName2.DrvNm = TRIM(REPLACE(nv_daily,"ชื่อ","")). 
          END.
          IF INDEX(TRIM(nv_daily),"เกิดวันที่") <> 0 THEN DO:
            L2DrvName2.FLBBrtDt = TRIM(nv_daily).
            L2DrvName2.BrtDt    = TRIM(REPLACE(nv_daily,"เกิดวันที่","")). 
          END.
          IF INDEX(TRIM(nv_daily),"เลขที่ ใบขับขี่") <> 0 THEN DO:
            L2DrvName2.FLBIcno = TRIM(nv_daily).
            L2DrvName2.Icno    = TRIM(REPLACE(nv_daily,"เลขที่ ใบขับขี่","")). 
          END.
          IF INDEX(TRIM(nv_daily),"ออก ณ") <> 0 THEN DO:
            L2DrvName2.FLBExt = TRIM(nv_daily).
            L2DrvName2.Ext    = TRIM(REPLACE(nv_daily,"ออก ณ","")). 
          END.
          IF INDEX(TRIM(nv_daily),"วันที่ออกบัตร") <> 0 THEN DO:
            L2DrvName2.FLBFirstDt = TRIM(nv_daily).
            L2DrvName2.FirstDt    = TRIM(REPLACE(nv_daily,"วันที่ออกบัตร","")). 
          END.
          IF INDEX(TRIM(nv_daily),"วันหมดอายุ") <> 0 THEN DO:
            L2DrvName2.FLBExtDt = TRIM(nv_daily).
            L2DrvName2.ExtDt    = TRIM(REPLACE(nv_daily,"วันหมดอายุ","")). 
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"ผู้ขับขี่ 2") <> 0 THEN DO:

      CREATE L2DrvName2.
      L2DrvName2.FLBDrvNm = TRIM(nv_daily). 
      L2DrvName2.QNONumber = nv_QNONumber.

      nv_L2DrvName1    = NO.
      nv_RecL2DrvName1 = ?.

      nv_L2DrvName2    = YES.
      nv_RecL2DrvName2 = RECID(L2DrvName2).
    END.

    /* ผู้ขับขี่ 1 ----------------------------------------------- */
    /*2.1*/
    IF nv_L2DrvName1 = YES THEN DO:

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L2DrvName1 WHERE RECID(L2DrvName1) = nv_RecL2DrvName1 NO-ERROR.
        IF AVAILABLE L2DrvName1 THEN DO:

          IF INDEX(TRIM(nv_daily),"ชื่อ") <> 0 THEN DO:
            L2DrvName1.FLBNm = TRIM(nv_daily).
            L2DrvName1.DrvNm = TRIM(REPLACE(nv_daily,"ชื่อ","")). 
          END.
          IF INDEX(TRIM(nv_daily),"เกิดวันที่") <> 0 THEN DO:
            L2DrvName1.FLBBrtDt = TRIM(nv_daily).
            L2DrvName1.BrtDt    = TRIM(REPLACE(nv_daily,"เกิดวันที่","")). 
          END.
          IF INDEX(TRIM(nv_daily),"เลขที่ ใบขับขี่") <> 0 THEN DO:
            L2DrvName1.FLBIcno = TRIM(nv_daily).
            L2DrvName1.Icno    = TRIM(REPLACE(nv_daily,"เลขที่ ใบขับขี่","")). 
          END.
          IF INDEX(TRIM(nv_daily),"ออก ณ") <> 0 THEN DO:
            L2DrvName1.FLBExt = TRIM(nv_daily).
            L2DrvName1.Ext    = TRIM(REPLACE(nv_daily,"ออก ณ","")). 
          END.
          IF INDEX(TRIM(nv_daily),"วันที่ออกบัตร") <> 0 THEN DO:
            L2DrvName1.FLBFirstDt = TRIM(nv_daily).
            L2DrvName1.FirstDt    = TRIM(REPLACE(nv_daily,"วันที่ออกบัตร","")). 
          END.
          IF INDEX(TRIM(nv_daily),"วันหมดอายุ") <> 0 THEN DO:
            L2DrvName1.FLBExtDt = TRIM(nv_daily).
            L2DrvName1.ExtDt    = TRIM(REPLACE(nv_daily,"วันหมดอายุ","")). 
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"ผู้ขับขี่ 1") <> 0 THEN DO:

      CREATE L2DrvName1.
      L2DrvName1.FLBDrvNm  = TRIM(nv_daily). 
      L2DrvName1.QNONumber = nv_QNONumber.

      nv_L2DrvNameType    = NO.
      nv_RecL2DrvNameType = ?.

      nv_L2DrvName1    = YES.
      nv_RecL2DrvName1 = RECID(L2DrvName1).
    END.

    /* ประเภทประกันภัยที่ต้องการ -------------------------------------------- */
    /*2*/
    IF nv_L2DrvNameType = YES THEN DO:

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L2DrvNameType WHERE RECID(L2DrvNameType) = nv_RecL2DrvNameType NO-ERROR.
        IF AVAILABLE L2DrvNameType THEN DO:

          IF L2DrvNameType.DrvNmNot = "" THEN DO:

            L2DrvNameType.DrvNmNot = TRIM(nv_daily).

            IF INDEX(TRIM(nv_daily),"X") <> 0 THEN
               L2DrvNameType.DrvNmNotCd = "X".
          END.
          ELSE DO:

            IF L2DrvNameType.DrvNmSelect = "" THEN DO:

               L2DrvNameType.DrvNmSelect = TRIM(nv_daily).

              IF INDEX(TRIM(nv_daily),"X") <> 0 THEN
                 L2DrvNameType.DrvNmSelectCd = "X".
            END.
          END.
        END.
      END.
    END.

    IF INDEX(TRIM(nv_daily),"ประเภทประกันภัยที่ต้องการ") <> 0 THEN DO:

      CREATE L2DrvNameType.
      L2DrvNameType.FLBDrvNm  = TRIM(nv_daily). 
      L2DrvNameType.QNONumber = nv_QNONumber.

      nv_L1AddrDC   = NO.
      nv_RecL1AddrDC = ? .

      nv_L2DrvNameType   = YES.
      nv_RecL2DrvNameType = RECID(L2DrvNameType).
    END.

    /* ที่อยู่จัดส่งเอกสาร ------------------------------------------------- */
    /*1.2*/
    IF nv_L1AddrDC = YES THEN DO:

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L1AddrDC WHERE RECID(L1AddrDC) = nv_RecL1AddrDC NO-ERROR.
        IF AVAILABLE L1AddrDC THEN DO:

          IF L1AddrDC.Addr = "" THEN DO:

            L1AddrDC.Addr = TRIM(nv_daily).
          END.
          ELSE DO: 

            IF L1AddrDC.Pdesc = "" THEN 
               L1AddrDC.Pdesc = TRIM(nv_daily).
          END.
        END.
      END.
    END.

    IF TRIM(nv_daily) = "ที่อยู่จัดส่งเอกสาร" THEN DO:

      CREATE L1AddrDC.
      L1AddrDC.FLBAddr    = TRIM(nv_daily). 
      L1AddrDC.QNONumber  = nv_QNONumber.
      
      nv_L1AddrC    = NO.
      nv_RecL1AddrC  = ?.

      nv_L1AddrDC   = YES.
      nv_RecL1AddrDC = RECID(L1AddrDC).
    END.

    /* ที่อยู่ปัจจุบัน -------------------------------------------------- */
    /*1.1*/
    IF nv_L1AddrC = YES THEN DO:

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L1AddrC WHERE RECID(L1AddrC) = nv_RecL1AddrC NO-ERROR.
        IF AVAILABLE L1AddrC THEN DO:

          IF L1AddrC.Addr = "" THEN DO:

            L1AddrC.Addr = TRIM(nv_daily).
          END.
          ELSE DO: 

            IF L1AddrC.Pdesc = "" THEN 
               L1AddrC.Pdesc = TRIM(nv_daily).
          END.
        END.
      END.
    END.

    IF TRIM(nv_daily) = "ที่อยู่ปัจจุบัน" THEN DO:

      CREATE L1AddrC.
      L1AddrC.FLBAddr   = TRIM(nv_daily). 
      L1AddrC.QNONumber = nv_QNONumber.

      nv_L1Insured   = NO.
      nv_RecL1Insured = ?.

      nv_L1AddrC    = YES.
      nv_RecL1AddrC  = RECID(L1AddrC).
    END.

    /* ชื่อผู้เอาประกัน ------------------------------------------------ */
    /*1*/
    IF nv_L1Insured = YES THEN DO:

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND L1Insured WHERE RECID(L1Insured) = nv_RecL1Insured NO-ERROR.
        IF AVAILABLE L1Insured THEN DO:

          IF INDEX(TRIM(nv_daily),"หมายเลขบัตรประชาชน") = 0 THEN DO:
            /*
            DISPLAY "aaa" nv_daily FORMAT "x(50)"  WITH FRAME CCaabb. PAUSE 10.
            */
            IF L1Insured.FName = "" AND L1Insured.Icno = "" THEN DO:

              IF INDEX(TRIM(nv_daily)," ") <> 0 THEN DO:
                ASSIGN
                L1Insured.FName = TRIM(SUBSTR(TRIM(nv_daily),1, INDEX(TRIM(nv_daily)," ") ))
                L1Insured.SName = TRIM(SUBSTR(TRIM(nv_daily),INDEX(TRIM(nv_daily)," ") + 1, 50 )).
              END.
            END.
            ELSE DO:
              IF L1Insured.Icno = "" THEN
                 L1Insured.Icno = TRIM(nv_daily).
            END.
          END.
          ELSE DO:

            L1Insured.FLBICno = TRIM(nv_daily).
          END.
        END.
      END.
    END.

    IF TRIM(nv_daily) = "ชื่อผู้เอาประกัน" THEN DO:

      CREATE L1Insured.
      L1Insured.FLBName   = TRIM(nv_daily).
      L1Insured.QNONumber = nv_QNONumber.

      nv_L1Insured   = YES.
      nv_RecL1Insured = RECID(L1Insured).
    END.

    /* ------------------------------------------------------------------ */
    /*H1.1*/
    IF INDEX(TRIM(nv_daily),"ประกันคุ้มภัย") <> 0 THEN DO:

      CREATE LCompany.
      LCompany.FLBCompany = TRIM(nv_daily).
      LCompany.QNONumber  = nv_QNONumber.
      /*
      DISPLAY "aaa" WITH FRAME aabb. PAUSE 10. */

      nv_LQNO    = NO.
      nv_RecLQNO = ?.
    END.

    /* ใบแจ้งคุ้มครองรถยนต์----------------------------------------------- */
    /*H1*/
    IF nv_LQNO    = YES THEN DO:

      IF TRIM(nv_daily) <> "" THEN DO:

        FIND LQNO WHERE RECID(LQNO) = nv_RecLQNO NO-ERROR.
        IF AVAILABLE LQNO THEN DO:

          LQNO.QNOText = TRIM(nv_daily).

          IF INDEX(TRIM(nv_daily),".") <> 0 THEN DO:
            ASSIGN
            LQNO.QNOno     = TRIM(SUBSTR(TRIM(nv_daily),1, INDEX(TRIM(nv_daily),".") ))
            LQNO.QNONumber = TRIM(SUBSTR(TRIM(nv_daily),INDEX(TRIM(nv_daily),".") + 1, 20 )).

            nv_QNONumber    = LQNO.QNONumber.
          END.
        END.
      END.
    END.

    IF TRIM(nv_daily) = "ใบแจ้งคุ้มครองรถยนต์" THEN DO:

      CREATE LQNO.
      LQNO.QNODesc = TRIM(nv_daily).

      nv_L11Cur    = NO.
      nv_RecL11Cur = ?.

      nv_LQNO    = YES.
      nv_RecLQNO = RECID(LQNO).

      nv_QNONumber = "".
    END.
    /* ------------------------------------------------------------------ */






    nv_daily = "".
    NEXT loop_source.
  END.

  nv_daily = nv_daily + nv_chr.
END.

INPUT STREAM nfile CLOSE.
/* ------------------------------------------------------------------- */


/*---------------------------------------------------------------------*/
/* */

/*FOR EACH LQNO NO-LOCK:           /*1. Q.no */

  DISPLAY LQNO WITH 1 COLUMN.
END.*/
/*
FOR EACH LCompany NO-LOCK:        /*2.company sty */

  DISPLAY LCompany WITH 1 COLUMN.
END.*/ 
/*
FOR EACH L1Insured NO-LOCK:      /*3.customer icno */   

  DISPLAY L1Insured WITH 1 COLUMN.
END.*/
 
/*
FOR EACH L1AddrC NO-LOCK:        /*4. Address */

  DISPLAY L1AddrC.QNONumber
          L1AddrC.FLBAddr  
          L1AddrC.Addr     FORMAT "X(50)"
          L1AddrC.Pdesc 
  WITH 1 COLUMN.
END.*/
/*
FOR EACH L1AddrDC NO-LOCK:      /*5. Address Receipt */

  DISPLAY L1AddrDC.QNONumber
          L1AddrDC.FLBAddr  
          L1AddrDC.Addr     FORMAT "X(50)"
          L1AddrDC.Pdesc 
  WITH 1 COLUMN.
END.*/
/*
FOR EACH L2DrvNameType NO-LOCK:        /*6. driver yes/ no */

  DISPLAY L2DrvNameType WITH 1 COLUMN.
END.*/
/*
FOR EACH L2DrvName1 NO-LOCK:           /*7. driver name 1 */

  DISPLAY L2DrvName1 WITH 1 COLUMN.
END.*/
/*
FOR EACH L2DrvName2 NO-LOCK:           /*8. driver name 2  */

  DISPLAY L2DrvName2 WITH 1 COLUMN.
END.*/
/*
FOR EACH L3Benc NO-LOCK:              /*9. bennam */

  DISPLAY L3Benc WITH 1 COLUMN.
END.*/
/*
FOR EACH L4Garage NO-LOCK:           /*10. garage */

  DISPLAY L4Garage WITH 1 COLUMN.   
END.*/
/*
FOR EACH  L4Make NO-LOCK:           /*11.class brand model ...*/

  DISPLAY  L4Make WITH 2 COLUMN.
END.*/
/*
FOR EACH L5SI NO-LOCK:             /*12.cover  comdat expdat */

  DISPLAY L5SI WITH 1 COLUMN.
END.*/
/*
FOR EACH  L6Ref NO-LOCK:           /*13.old policy company old */

  DISPLAY  L6Ref WITH 1 COLUMN.
END.*/
/*
FOR EACH L7Prm70  NO-LOCK:         /*14. premium */

  DISPLAY L7Prm70  WITH 1 COLUMN.
END.*/
/*
FOR EACH L8Prm72 NO-LOCK:         /*15. comp*/

  DISPLAY L8Prm72 WITH 1 COLUMN.
END.*/
/*
FOR EACH L9comdat NO-LOCK:       /*16. comp comdat expdat */

  DISPLAY L9comdat WITH 1 COLUMN.
END.*/
/*
FOR EACH L10Insp NO-LOCK:         /*17. inspcetion */

  DISPLAY L10Insp WITH 1 COLUMN.
END.*/
/**/
/*
FOR EACH L11Cur NO-LOCK:         /*18 . cash */

  DISPLAY  L11Cur.QNONumber   
           FLBCur      
           Curpay      FORMAT "x(50)"
           Curunit     
           remark      FORMAT "x(50)"
           FLBAgentReq 
           AgentReq    
           FLBAgentCd  
           AgentCd     
           FLBReqDate  
           ReqDate     
           FLBMemo     
           Memoby      
  WITH 1 COLUMN.
END.*/
/*output to file  */
FOR EACH LQNO  NO-LOCK:   /*LQNO.QNONumber*/                     /*1. Q.no */
    /*FOR EACH LCompany WHERE 
    LCompany.QNONumber = LQNO.QNONumber NO-LOCK:                 /*2.company sty */
    DISPLAY LCompany WITH 1 COLUMN.                                     
    END.*/
    CREATE workf_out.
    ASSIGN workf_out.QNONumber = TRIM(LQNO.QNONumber) .

    FIND LAST L1Insured WHERE 
        L1Insured.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR.  /*3.customer icno */ 
    IF AVAIL L1Insured THEN DO:
        FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno = "999" AND
            index(trim(L1Insured.FName),brstat.msgcode.MsgDesc) > 0    NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.msgcode THEN  
            ASSIGN  
            workf_out.insname  = trim(SUBSTR(L1Insured.FName,LENGTH(brstat.msgcode.MsgDesc) + 1)) + " " +
                                 TRIM(L1Insured.SName) /*sname*/ 
            workf_out.ntitle   = trim(brstat.msgcode.branch)  
            workf_out.icno     = trim(L1Insured.Icno) .  
        ELSE ASSIGN 
            workf_out.insname  = trim(L1Insured.FName) + " " + TRIM(L1Insured.SName) /*sname*/ 
            workf_out.ntitle   = "คุณ"
            workf_out.icno     = trim(L1Insured.Icno) .                              /*icno */  
    END.
    FIND LAST L1AddrC WHERE 
        L1AddrC.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR.                         /*4. Address */
    IF AVAIL L1AddrC  THEN DO: 
        ASSIGN workf_out.addr1 = trim(L1AddrC.Addr)     .  

        DEF VAR nv_addressum AS CHAR FORMAT "x(250)".
        DEF VAR nv_soy       AS CHAR FORMAT "x(50)".
        DEF VAR nv_road      AS CHAR FORMAT "x(50)".
        DEF VAR ns_addr1     AS CHAR FORMAT "x(150)".
        DEF VAR ns_addr2     AS CHAR FORMAT "x(50)".
        DEF VAR ns_addr3     AS CHAR FORMAT "x(50)".
        DEF VAR ns_addr4     AS CHAR FORMAT "x(50)".
        DEF VAR ns_vehreg    AS CHAR FORMAT "x(30)".
        DEF VAR ns_vehreg2   AS CHAR FORMAT "x(30)".
        ASSIGN 
            nv_addressum = ""   
            nv_soy       = ""   
            nv_road      = ""   
            ns_addr1     = ""   
            ns_addr2     = ""   
            ns_addr3     = ""   
            ns_addr4     = ""   
            ns_vehreg    = ""   
            ns_vehreg2   = ""  
            ns_addr1  = trim(L1AddrC.Addr) 
            ns_addr2  = ""  
            ns_addr3  = ""     
            ns_addr4  = "".
        /* จังหวัด /จ./กทม/กรุงเทพ */
        IF r-index(ns_addr1,"จ.") <> 0 THEN
            ASSIGN 
            ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"จ.")))                 /*จ. */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"จ.") - 1 )).        /*จ.*/
        ELSE IF r-index(ns_addr1,"จังหวัด") <> 0 THEN                                       
            ASSIGN                                                                          
            ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"จังหวัด")))            /*จ. */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"จังหวัด") - 1 )).   /*จ.*/
        ELSE IF r-index(ns_addr1,"กรุง") <> 0 THEN                                          
            ASSIGN                                                                          
            ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"กรุง")))               /*กรุง */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"กรุง") - 1 )).      /*กรุง*/
        ELSE IF r-index(ns_addr1,"กทม") <> 0 THEN                                           
            ASSIGN                                                                          
            ns_addr4        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"กทม")))                /*กทม */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"กทม") - 1 )).       /*กทม*/
        IF r-index(ns_addr4,"จ.") <> 0 THEN ASSIGN  ns_addr4 = "จังหวัด" + trim(SUBSTR(ns_addr4,INDEX(ns_addr4,"จ.") + 2)) .
        /* อำเภอ /อ./เขต */
        IF r-index(ns_addr1,"เขต/อำเภอ") <> 0 THEN
            ASSIGN 
            ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"เขต/อำเภอ")))            /*อำเภอ /อ./เขต */
            ns_addr3        = "อำเภอ" + trim(REPLACE(ns_addr3,"เขต/อำเภอ"," "))
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"เขต/อำเภอ") - 1 )).   /*ตำบล  /ต. /แขวง*/
        ELSE IF r-index(ns_addr1,"เขต") <> 0 THEN
            ASSIGN 
            ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"เขต")))            /*อำเภอ /อ./เขต */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"เขต") - 1 )).   /*ตำบล  /ต. /แขวง*/
        ELSE IF r-index(ns_addr1,"อำเภอ") <> 0 THEN                                     
            ASSIGN                                                                      
            ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"อำเภอ")))          /*อำเภอ /อ./เขต */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"อำเภอ") - 1 )). /*ตำบล  /ต. /แขวง*/
        ELSE IF r-index(ns_addr1,"อ.") <> 0 THEN                                        
            ASSIGN                                                                      
            ns_addr3        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"อ.")))             /*อำเภอ /อ./เขต */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"อ.") - 1 )).    /*ตำบล  /ต. /แขวง*/
        /* แขวง/ตำบล/ต./แขวง */
        IF r-index(ns_addr1,"แขวง/ตำบล") <> 0 THEN
            ASSIGN 
            ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"แขวง/ตำบล")))            /*อำเภอ /อ./เขต */
            ns_addr2        = "ตำบล" + trim(REPLACE(ns_addr2,"แขวง/ตำบล"," "))
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"แขวง/ตำบล") - 1 )).   /*ตำบล  /ต. /แขวง*/
        ELSE IF r-index(ns_addr1,"แขวง") <> 0 THEN
            ASSIGN 
            ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"แขวง")))            /*อำเภอ /อ./เขต */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"แขวง") - 1 )).   /*ตำบล  /ต. /แขวง*/
        ELSE IF r-index(ns_addr1,"ตำบล") <> 0 THEN                                     
            ASSIGN                                                                      
            ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"ตำบล")))          /*อำเภอ /อ./เขต */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"ตำบล") - 1 )). /*ตำบล  /ต. /แขวง*/
        ELSE IF r-index(ns_addr1,"ต.") <> 0 THEN                                        
            ASSIGN                                                                      
            ns_addr2        = trim(SUBSTR(ns_addr1,r-index(ns_addr1,"ต.")))             /*อำเภอ /อ./เขต */
            ns_addr1        = trim(SUBSTR(ns_addr1,1, r-index(ns_addr1,"ต.") - 1 )).    /*ตำบล  /ต. /แขวง*/
        DO WHILE INDEX(ns_addr1,"  ") <> 0 :
            ASSIGN ns_addr1 = REPLACE(ns_addr1,"  "," ").
        END.
        IF LENGTH(ns_addr1) > 35 THEN DO:
            loop_add01:
            DO WHILE LENGTH(ns_addr1) > 35 :
                IF R-INDEX(ns_addr1," ") <> 0 THEN DO:
                    ASSIGN 
                        ns_addr2  = trim(SUBSTR(ns_addr1,r-INDEX(ns_addr1," "))) + " " + ns_addr2
                        ns_addr1  = trim(SUBSTR(ns_addr1,1,r-INDEX(ns_addr1," "))).
                END.
                ELSE LEAVE loop_add01.
            END.
            IF LENGTH(ns_addr2) > 35 THEN DO:
                loop_add02:
                DO WHILE LENGTH(ns_addr2) > 35 :
                    IF R-INDEX(ns_addr2," ") <> 0 THEN DO:
                        ASSIGN 
                            ns_addr3   = trim(SUBSTR(ns_addr2,r-INDEX(ns_addr2," "))) + " " + ns_addr3
                            ns_addr2   = trim(SUBSTR(ns_addr2,1,r-INDEX(ns_addr2," "))).
                    END.
                    ELSE LEAVE loop_add02.
                END.
            END.
            IF LENGTH(ns_addr2 + " " + ns_addr3) <= 35 THEN
                ASSIGN 
                ns_addr2  = ns_addr2 + " " + ns_addr3
                ns_addr3  = ns_addr4 
                ns_addr4  = "".
            ELSE IF LENGTH(ns_addr3 + " " + ns_addr4 ) <= 35 THEN
                ASSIGN 
                ns_addr3  = ns_addr3 + " " + ns_addr4
                ns_addr4  = "".
        END.
        ELSE DO:
            IF LENGTH(ns_addr2 + " " + ns_addr3) <= 35 THEN
                ASSIGN 
                ns_addr2  = ns_addr2 + " " + ns_addr3
                ns_addr3  = ns_addr4 
                ns_addr4  = "".
            ELSE IF LENGTH(ns_addr3 + " " + ns_addr4 ) <= 35 THEN
                ASSIGN 
                ns_addr3  = ns_addr3 + " " + ns_addr4 
                ns_addr4  = "".
        END.
        IF INDEX(ns_addr3 + " " + ns_addr4,"กรุง") <> 0 OR INDEX(ns_addr3 + " " + ns_addr4,"กทม") <> 0  THEN DO:
            IF INDEX(ns_addr2,"ตำบล")    <> 0 THEN ns_addr2 = REPLACE(ns_addr2,"ตำบล","แขวง").
            IF INDEX(ns_addr2,"อำเภอ")   <> 0 THEN ns_addr2 = REPLACE(ns_addr2,"อำเภอ","เขต").  
            IF INDEX(ns_addr3,"ตำบล")    <> 0 THEN ns_addr3 = REPLACE(ns_addr3,"ตำบล","แขวง").
            IF INDEX(ns_addr3,"อำเภอ")   <> 0 THEN ns_addr3 = REPLACE(ns_addr3,"อำเภอ","เขต"). 
            IF INDEX(ns_addr3,"จังหวัด") <> 0 THEN ns_addr3 = trim(REPLACE(ns_addr3,"จังหวัด","")).
            IF INDEX(ns_addr4,"จังหวัด") <> 0 THEN ns_addr4 = trim(REPLACE(ns_addr4,"จังหวัด","")).
            ASSIGN  
            workf_out.addr1 = ns_addr1
            workf_out.addr2 = ns_addr2
            workf_out.addr3 = ns_addr3 + " " + ns_addr4 
            workf_out.addr4 = "" .
        END.
        ELSE ASSIGN  
            workf_out.addr1 = ns_addr1
            workf_out.addr2 = ns_addr2 
            workf_out.addr3 = ns_addr3 + " " + ns_addr4 
            workf_out.addr4 = "" .
        /**end. of address */
    END.
    FIND LAST L1AddrDC WHERE 
        L1AddrDC.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR.                       /*5. Address Receipt */
    IF AVAIL L1AddrDC  THEN  ASSIGN workf_out.addr_rep = trim(L1AddrDC.Addr)    .
    
    FIND LAST  L2DrvNameType WHERE  
        L2DrvNameType.QNONumber = LQNO.QNONumber  NO-LOCK NO-ERROR .       /*6. driver yes/ no */
    IF AVAIL L2DrvNameType THEN DO:
        IF L2DrvNameType.DrvNmNotCd  <> "" THEN 
            ASSIGN workf_out.drino = "n"     /* no driv*/
            workf_out.driver1      = ""
            workf_out.dribirth1    = ""
            workf_out.driver2      = ""
            workf_out.dribirth2    = "".
        ELSE IF L2DrvNameType.DrvNmSelectCd <> ""  THEN DO:  /* yes driv*/
            ASSIGN workf_out.drino = "y" .
            FIND LAST  L2DrvName1 WHERE L2DrvName1.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR.  /*7. driver name 1 */
            IF AVAIL L2DrvName1 THEN
                ASSIGN     
                workf_out.driver1      = L2DrvName1.DrvNm                                                
                workf_out.dribirth1    = L2DrvName1.BrtDt .     
            ELSE ASSIGN 
                workf_out.driver1      = ""
                workf_out.dribirth1    = "".
            FIND LAST  L2DrvName2 WHERE L2DrvName2.QNONumber = LQNO.QNONumber  NO-LOCK NO-ERROR .    /*8. driver name 2  */
            IF AVAIL L2DrvName2 THEN
                ASSIGN     
                workf_out.driver2      =  L2DrvName2.DrvNm     
                workf_out.dribirth2    =  L2DrvName2.BrtDt     .
            ELSE 
                ASSIGN workf_out.driver2   = ""
                    workf_out.dribirth2    = "".
        END. /* L2DrvNameType.DrvNmSelectCd <> ""*/
    END. /* AVAIL L2DrvNameType */
    FIND LAST L3Benc WHERE 
        L3Benc.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR.            /*9. bennam */
    IF AVAIL L3Benc  THEN DO:
        IF L3Benc.BencNm1 = "" THEN DO:  
            IF L3Benc.BencNm2 = "" THEN 
                 ASSIGN workf_out.bennames = "".
            ELSE ASSIGN workf_out.bennames = L3Benc.BencNm2.
        END.
        ELSE ASSIGN workf_out.bennames = L3Benc.BencNm1.
    END.
    FIND LAST  L4Garage WHERE L4Garage.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR .          /*10. garage */
    IF AVAIL L4Garage  THEN DO:
        IF      L4Garage.GNm1Cd <> "" THEN  ASSIGN workf_out.garage = "G".  /*ซ่อมห้าง*/
        ELSE IF L4Garage.GNm2Cd <> "" THEN  ASSIGN workf_out.garage = "".   /*ซ่อมอู่*/ 
        ELSE ASSIGN workf_out.garage = "". 
    END.
    FIND LAST  L4Make WHERE L4Make.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR .           /*11.class brand model ...*/
    IF AVAIL L4Make THEN DO:
        IF r-INDEX(L4Make.vehreg,"จ.") <> 0 THEN
            ASSIGN 
            ns_vehreg   = trim(SUBSTR(L4Make.vehreg,1,R-INDEX(L4Make.vehreg,"จ.") - 1))
            ns_vehreg   = REPLACE(ns_vehreg," ","")
            ns_vehreg2  = trim(SUBSTR(L4Make.vehreg,R-INDEX(L4Make.vehreg,"จ.") + 2 ))  .
        /*ตัวที่1 ป็นตัวเลข*/
        IF ns_vehreg <> "ป้ายแดง" THEN DO:
            IF (substr(ns_vehreg,1,1)) > "0" AND  (substr(ns_vehreg,1,1)) <= "9"  THEN DO:
                IF  (substr(ns_vehreg,2,1)) > "9" AND  (substr(ns_vehreg,3,1)) > "9" THEN /*ext 1กท 1234*/
                    ASSIGN ns_vehreg = trim(SUBSTR(ns_vehreg,1,3)) + " " + trim(SUBSTR(ns_vehreg,4)).
            END.
            ELSE IF  (substr(ns_vehreg,1,1)) > "9" AND  (substr(ns_vehreg,2,1)) > "9" THEN /*ext 1กท 1234*/
                    ASSIGN ns_vehreg = trim(SUBSTR(ns_vehreg,1,2)) + " " + trim(SUBSTR(ns_vehreg,3)).
            ELSE IF  (substr(ns_vehreg,1,1)) > "9" THEN 
                ASSIGN ns_vehreg = trim(SUBSTR(ns_vehreg,1,1)) + " " + trim(SUBSTR(ns_vehreg,2)).
        END.
        ASSIGN ns_vehreg  = trim(ns_vehreg) + " " + trim(ns_vehreg2).
        /**/
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*licence  */
            brstat.insure.compno = "999" AND
            index(ns_vehreg,brstat.Insure.fName) <> 0 NO-LOCK NO-WAIT NO-ERROR.
        IF AVAIL brstat.insure THEN  
            ASSIGN workf_out.vehreg = trim(REPLACE(substr(ns_vehreg,1,INDEX(ns_vehreg,brstat.insure.fName) - 1 ),"-","")) 
                               + " " + TRIM(brstat.insure.LName) .
        ELSE ASSIGN workf_out.vehreg  = ns_vehreg .
        ASSIGN 
            workf_out.subclass =  L4Make.class     
            workf_out.brand    =  IF      index(L4Make.moddes,"/") <> 0 THEN trim(SUBSTR(L4Make.moddes,1,INDEX(L4Make.moddes,"/") - 1))     /*brand model*/
                                  ELSE IF index(L4Make.moddes," ") <> 0 THEN trim(SUBSTR(L4Make.moddes,1,INDEX(L4Make.moddes," ") - 1))
                                  ELSE    TRIM(L4Make.moddes)
            workf_out.model    =  IF      index(L4Make.moddes,"/") <> 0 THEN trim(SUBSTR(L4Make.moddes,INDEX(L4Make.moddes,"/") + 1))     /*brand model*/
                                  ELSE IF index(L4Make.moddes," ") <> 0 THEN trim(SUBSTR(L4Make.moddes,INDEX(L4Make.moddes," ") + 1))
                                  ELSE    TRIM(L4Make.moddes)
            /*workf_out.vehreg  = L4Make.vehreg    */
            workf_out.cha_no  = L4Make.eng_no   /*cha_no*/ 
            workf_out.caryear = L4Make.yrmanu    
            workf_out.body    = L4Make.body  
            workf_out.Seat    = L4Make.seats     
            workf_out.eng_cc  = L4Make.cc        
            workf_out.tons    = L4Make.ton  .
    END.
    FIND LAST L5SI WHERE L5SI.QNONumber  = LQNO.QNONumber NO-LOCK NO-ERROR .    /*12.cover  comdat expdat */
    IF AVAIL L5SI THEN DO:
        ASSIGN workf_out.covcod = L5SI.covcod70 
            workf_out.sumins    = L5SI.si    
            workf_out.comdat    = substr(L5SI.comdat,1,6) +  string(deci(substr(L5SI.comdat,7,4)) - 543)    
            workf_out.expdat    = substr(L5SI.extdat,1,6) +  string(deci(substr(L5SI.extdat,7,4)) - 543)   .
    END.
    FIND LAST  L6Ref WHERE L6Ref.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR.   /*13.old policy company old */
    IF AVAIL L6Ref THEN DO:
        ASSIGN 
            workf_out.companyold   =    L6Ref.RefNm    /*old company*/
            workf_out.prevpol      =    trim(replace(L6Ref.Refno,"-",""))
            workf_out.prevpol      =    trim(replace(workf_out.prevpol,"/","")) .  /*old policy*/ 
    END.
    FIND LAST L7Prm70 WHERE L7Prm70.QNONumber = LQNO.QNONumber   NO-LOCK NO-ERROR .
    IF AVAIL L7Prm70 THEN DO:      
        ASSIGN                                                          /*14. premium */
            workf_out.volprem   =  L7Prm70.gr_p70  
            workf_out.netprem   =  L7Prm70.prem_t70  .
    END.
    FIND LAST L8Prm72 WHERE  L8Prm72.QNONumber  = LQNO.QNONumber NO-LOCK NO-ERROR.          /*15. comp*/
    IF AVAIL L8Prm72 THEN DO:
        IF L8Prm72.compdo <> "" THEN DO: 
            ASSIGN workf_out.comprem =    L8Prm72.gr_p72 . /* add comp */  
            FIND LAST L9comdat WHERE L9comdat.QNONumber = LQNO.QNONumber  NO-LOCK NO-ERROR.      /*16. comp comdat expdat */
            IF AVAIL L9comdat THEN DO:
                ASSIGN        
                    workf_out.comdat72  =   L9comdat.comdat72 
                    workf_out.expdat72  =   L9comdat.expdat72    .
            END.
            ELSE ASSIGN        
                    workf_out.comdat72  =  ""
                    workf_out.expdat72  =  ""   .
        END.
        /*L8Prm72.compnot    /* no  comp*/*/
        ELSE ASSIGN workf_out.comprem = "0"    .
    END.
    FIND LAST L10Insp WHERE L10Insp.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR .      /*17. inspcetion */
    IF AVAIL L10Insp THEN DO:
        ASSIGN 
            workf_out.InspNm     = L10Insp.InspNm              /*name*/ 
            workf_out.Inspmobile = L10Insp.Inspmobile + " " +  /*mobile phone*/
                                   L10Insp.Inspphone.          /*phone*/  
    END.
    /**/
    FIND LAST L11Cur WHERE L11Cur.QNONumber = LQNO.QNONumber NO-LOCK NO-ERROR.         /*18 . cash */
    IF AVAIL L11Cur THEN DO:
        ASSIGN        
            workf_out.remark      =    L11Cur.remark      
            workf_out.AgentReq    =    L11Cur.AgentReq   /*ผู้แจ้ง*/
            workf_out.AgentCd     =    L11Cur.AgentCd    /*รหัส*/
            workf_out.ReqDate     =    L11Cur.ReqDate    /*วันที่แจ้ง*/
            workf_out.Memoby      =    L11Cur.Memoby.    /*ผู้ตรวจ*/    
    END.
END.

DEFINE STREAM  ns2.
DEF VAR  nv_output AS CHAR FORMAT "x(60)".
ASSIGN 
nv_output = nv_outputfile .
OUTPUT TO VALUE(nv_output).   /*out put file full policy */
EXPORT DELIMITER "|"  
    "Entry date	"
"Entry time	"
"Trans Date	"
"Trans Time	"
"Policy Type	"
"Policy	"
"Renew Policy	"
"Comm Date	"
"Expiry date	"
"Compulsory	"
"Title name	"
"Insured name	"
"Ins addr1	"
"Ins addr2	"
"Ins addr3	"
"Ins addr4	"
"Premium Package	"
"Sub Class	"
"Brand	"
"Mode	"
"Cc	"
"Weight	"
"Seat	"
"Body	"
"Vehicle registration	"
"Engine no	"
"Chassis no	"
"Car Year	"
"Car Province	"
"Vehicle Use	"
"Garage	"
"Sticker no	"
"Accessories	"
"Cover Type	"
"Sum Insured	"
"Voluntory Premium	"
"Compulsory Prem	"
"Fleet %	"
"NCB %	"
"Load Claim	"
"Deduct DA	"
"Deduct PD	"
"Benificiary	"
"User id	"
"Import	"
"Export	"
"Drive name	"
"Driver name1	"
"Driver name2	"
"Driver Birthdate1	"
"Driver Birthdate2	"
"Driver age1	"
"Driver age2	"
"Cancel	"
"Producer	"
"Agent	"
"Code Red Book	"
"Note	"
"ATTACH_NOTE	"
"IDENT_CARD	"
"BUSINESS REGISTRATION	"
"base 	"
"campaign 	"
    "QNONumber"
    "Address_rep	"
    "Company_Old	"
    "Insp_name	"
    "Insp_Tel	"
    "remark"
    "AgentReq/ผู้แจ้ง 	"
    "AgentCd_รหัส     	"
    "ReqDate_วันที่แจ้ง	"
    "Memoby_ผู้ตรวจ 	" .
FOR EACH workf_out NO-LOCK  
     BREAK BY  workf_out.QNONumber .
    EXPORT DELIMITER "|" 
        ""
        ""
        ""
        ""
        "70"
        ""
        workf_out.prevpol
        workf_out.comdat 
        workf_out.expdat 
        "n"
        workf_out.ntitle  
        workf_out.insname 
        workf_out.addr1   
        workf_out.addr2   
        workf_out.addr3   
        workf_out.addr4   
        ""
        workf_out.subclass
        workf_out.brand   
        workf_out.model   
        workf_out.eng_cc  
        workf_out.tons    
        workf_out.Seat    
        workf_out.body    
        workf_out.vehreg  
        ""
        workf_out.cha_no 
        workf_out.caryear
        ""
        workf_out.vehuse 
        workf_out.garage 
        ""
        ""
        workf_out.covcod 
        workf_out.sumins 
        workf_out.netprem
        workf_out.comprem
        ""
        ""
        ""
        ""
        ""
        workf_out.bennames
        ""
        ""
        ""
        workf_out.drino     
        workf_out.driver1   
        workf_out.dribirth1 
        workf_out.driver2   
        workf_out.dribirth2 
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        ""
        workf_out.icno
        ""
        ""
        ""
        workf_out.QNONumber
        workf_out.addr_rep  
        workf_out.companyold
        workf_out.InspNm    
        workf_out.Inspmobile
        workf_out.remark  
        workf_out.AgentReq
        workf_out.AgentCd 
        workf_out.ReqDate 
        workf_out.Memoby  .
END.
MESSAGE "Export data complete " VIEW-AS ALERT-BOX.  

/*---------------------------------------------------------------------*/
