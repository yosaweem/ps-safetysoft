/*Create by : Ranu I. A59-0029  Date 04/02/2016 */
/*Modify by : Ranu i. A59-0182 Date 01/06/2016 เพิ่มตัวแปรรับค่าเพิ่ม */
/*Modify by : Ranu I. A61-0269 เพิ่มตัวแปร producer ,Agent */
/*ประกาศตัวแปร*/
DEF VAR im_no         AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR im_thname     AS CHAR FORMAT "x(60)"  INIT "".   
DEF VAR im_applino    AS CHAR FORMAT "x(15)"  INIT "".   
DEF VAR im_contractno AS CHAR FORMAT "x(12)"  INIT "".   
DEF VAR im_effecdat   AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im_expirdat   AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im_cusname    AS CHAR FORMAT "x(100)" INIT "".  
DEF VAR im_custype    AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_icno       AS CHAR FORMAT "x(13)"  INIT "".   
DEF VAR im_moobr      AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_room       AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_home       AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_moo        AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_soi        AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_road       AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_tumb       AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_amph       AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_prov       AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_post       AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im_benefi     AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_drinam1    AS CHAR FORMAT "x(100)" INIT "".   
DEF VAR im_dribht1    AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im_driid1     AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im_dricr1     AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_drinam2    AS CHAR FORMAT "x(100)" INIT "".   
DEF VAR im_dribht2    AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im_driid2     AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im_dricr2     AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im_package    AS CHAR FORMAT "x(60)"  INIT "". 
DEF VAR im_packname   AS CHAR FORMAT "x(60)"  INIT "". 
DEF VAR im_garage     AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im_cvmi       AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR im_make       AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im_model      AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im_chass      AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im_engno      AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im_licen      AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im_regis      AS CHAR FORMAT "x(30)"  INIT "". 
DEF VAR im_year       AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR im_color      AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im_class      AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR im_seat       AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR im_cc         AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR im_weight     AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR im_sumins     AS CHAR FORMAT "x(15)"  INIT "". 
DEF VAR im_access     AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR im_accdetail  AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR im_vnetprem   AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im_vstamp     AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im_vvat       AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im_vtprem     AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im_vwht       AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR im_cnetprem   AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR im_cstamp     AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR im_cvat       AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR im_ctprem     AS CHAR FORMAT "x(10)"  INIT "".
DEF VAR im_cwht       AS CHAR FORMAT "X(10)"  INIT "".
DEF VAR im_remark     AS CHAR FORMAT "x(150)" INIT "". 
DEF VAR im_charge     AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im_cperson    AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im_workdate   AS CHAR FORMAT "x(30)"  INIT "". 
DEF VAR im_srt_pol_no AS CHAR FORMAT "x(15)"  INIT "". 
DEF VAR im_payment    AS CHAR FORMAT "x(100)"  INIT "". 
DEF VAR im_track      AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im_post_no    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im_volu_no    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im_comp_no    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR im_status     AS CHAR FORMAT "x(25)"  INIT "".
DEF VAR im_ispno      AS CHAR FORMAT "x(25)" INIT "". 
DEFINE VAR nv_poltyp    AS CHAR FORMAT "x(3)"  INIT "".  /*A59-0182*/
DEFINE VAR nv_producer  AS CHAR FORMAT "x(10)" INIT "".  /*A59-0182*/
DEFINE VAR nv_agent     AS CHAR FORMAT "x(10)" INIT "".  /*A59-0182*/
DEFINE VAR nv_payment   AS CHAR FORMAT "x(20)" INIT "".  /*A59-0182*/
DEFINE VAR nv_Track     AS CHAR FORMAT "x(100)" INIT "".  /*A59-0182*/
DEFINE VAR nv_pack   AS CHAR    FORMAT "x(5)" INIT "".  /*A59-0182*/
/* cut from defination A61-0269 */
DEFINE   WORKFILE WCREATE NO-UNDO
    FIELD Ebatchdat     AS CHAR FORMAT "x(20)"  INIT ""  /*1*/
    FIELD Eapplino      AS CHAR FORMAT "x(20)"  INIT ""  /*2*/
    FIELD Epolclass     AS CHAR FORMAT "x(20)"  INIT ""  /*3*/
    FIELD Esumins       AS CHAR FORMAT "x(20)"  INIT ""  /*4*/
    FIELD Enetprm       AS CHAR FORMAT "x(20)"  INIT ""  /*5*/
    FIELD Egrossprm     AS CHAR FORMAT "x(20)"  INIT ""  /*1*/ 
    FIELD Eeffecdat     AS CHAR FORMAT "x(20)"  INIT ""  /*2*/ 
    FIELD Eexpirdat     AS CHAR FORMAT "x(20)"  INIT ""  /*3*/ 
    FIELD Etrantyp      AS CHAR FORMAT "x(5)"   INIT ""  /*4*/     
    FIELD ETinsnam      AS CHAR FORMAT "x(40)"  INIT ""  /*5*/ 
    FIELD ETintinam     AS CHAR FORMAT "x(40)"  INIT ""  /*1*/ 
    FIELD Einsname      AS CHAR FORMAT "x(60)"  INIT ""  /*2*/ 
    FIELD Eintinam      AS CHAR FORMAT "x(100)" INIT ""  /*3*/ 
    FIELD ETlasnam      AS CHAR FORMAT "x(65)"  INIT ""  /*4*/ 
    FIELD Elasnam       AS CHAR FORMAT "x(100)" INIT ""  /*5*/ 
    FIELD EAddress1     AS ChAR FORMAT "X(50)"  INIT ""  /*1*/ 
    FIELD EAddress2     AS ChAR FORMAT "X(256)" INIT ""  /*1*/
    FIELD EAddress3     AS ChAR FORMAT "X(256)" INIT ""  /*1*/
    FIELD EAddress4     AS ChAR FORMAT "X(256)" INIT ""  /*1*/
    FIELD THnam         AS CHAR FORMAT "x(100)" INIT ""  /*5*/
    FIELD ENnam         AS CHAR FORMAT "x(20)"  INIT ""  /*5*/
    FIELD occoup        AS CHAR FORMAT "x(10)"  INIT ""  /*5*/
    FIELD idno          AS CHAR FORMAT "x(15)"  INIT ""  /*5*/
    FIELD im1tal        AS CHAR FORMAT "x(65)"  INIT ""  /*5*/
    FIELD im1fax        AS CHAR FORMAT "x(20)"  INIT ""  /*5*/
    FIELD Enetprm2      AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0   /*5*/ 
    FIELD Egrossprm2    AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.  /*1*/ 
DEFINE WORKFILE WCREATE2 NO-UNDO   
    FIELD E2applino     AS CHAR FORMAT "x(20)"  INIT ""  /*2*/
    FIELD E2typins      AS CHAR FORMAT "x(3)"   INIT ""  /*2*/  
    FIELD E2CVMI        AS CHAR FORMAT "x(10)"  INIT ""  /*3*/  
    FIELD E2package     AS CHAR FORMAT "x(50)"  INIT ""  /*4*/  
    FIELD E2pattern     AS CHAR FORMAT "x(10)"  INIT ""  /*5*/  
    FIELD E2YEAR        AS CHAR FORMAT "x(4)"   INIT ""  /*1*/  
    FIELD E2make        AS CHAR FORMAT "x(50)"  INIT ""  /*2*/  
    FIELD E2model       AS CHAR FORMAT "x(50)"  INIT ""  /*3*/  
    FIELD E2engine      AS CHAR FORMAT "x(20)"  INIT ""  /*4*/  
    FIELD E2cc          AS CHAR FORMAT "x(20)"  INIT ""  /*5*/  
    FIELD E2seat        AS CHAR FORMAT "x(20)"  INIT ""  /*1*/  
    FIELD E2tonnage     AS CHAR FORMAT "x(20)"  INIT ""  /*2*/  
    FIELD E2chassis     AS CHAR FORMAT "x(20)"  INIT ""  /*3*/  
    FIELD E2access      AS CHAR FORMAT "x(20)"  INIT ""  /*4*/  
    FIELD E2sticker     AS CHAR FORMAT "x(20)"  INIT ""  /*5*/  
    FIELD E2instype     AS CHAR FORMAT "x(20)"  INIT ""  /*1*/  
    FIELD E2driver      AS CHAR FORMAT "x(1)"   INIT ""  /*2*/  
    FIELD E2drinam1     AS CHAR FORMAT "x(50)"  INIT ""  /*3*/  
    FIELD E2dribht1     AS CHAR FORMAT "x(20)"  INIT ""  /*4*/  
    FIELD E2driocc1     AS CHAR FORMAT "x(50)"  INIT ""  /*5*/  
    FIELD E2driid1      AS CHAR FORMAT "x(20)"  INIT ""  /*1*/  
    FIELD E2dricr1      AS CHAR FORMAT "x(20)"  INIT ""  /*2*/  
    FIELD E2dridat1     AS CHAR FORMAT "x(10)"  INIT ""  /*3*/  
    FIELD E2drimth1     AS CHAR FORMAT "x(10)"  INIT ""  /*4*/      
    FIELD E2driyer1     AS CHAR FORMAT "x(10)"  INIT "" /*5*/  
    FIELD E2driage1     AS CHAR FORMAT "x(10)"  INIT "" /*5*/
    FIELD E2drinam2     AS CHAR FORMAT "x(50)"  INIT ""  /*3*/  
    FIELD E2dribht2     AS CHAR FORMAT "x(20)"  INIT ""  /*4*/  
    FIELD E2driocc2     AS CHAR FORMAT "x(50)"  INIT ""  /*5*/  
    FIELD E2driid2      AS CHAR FORMAT "x(20)"  INIT ""  /*1*/  
    FIELD E2dricr2      AS CHAR FORMAT "x(20)"  INIT ""  /*2*/  
    FIELD E2dridat2     AS CHAR FORMAT "x(10)"  INIT ""  /*3*/  
    FIELD E2drimth2     AS CHAR FORMAT "x(10)"  INIT ""  /*4*/      
    FIELD E2driyer2     AS CHAR FORMAT "x(10)"  INIT "" /*5*/  
    FIELD E2driage2     AS CHAR FORMAT "x(10)"  INIT "" /*5*/  
    FIELD E2aecsdes     AS CHAR FORMAT "x(10)"  INIT "" /*5*/  
    FIELD E22lisen      AS CHAR FORMAT "x(10)"  INIT "" /*5*/  
    FIELD E2text14      AS CHAR FORMAT "x(20)"  INIT ""  /*4*/
    FIELD E2text15      AS CHAR FORMAT "x(20)"  INIT "" /*5*/  
    FIELD E2text16      AS CHAR FORMAT "x(20)"  INIT "" /*5*/  
    FIELD E2text17      AS CHAR FORMAT "x(20)"  INIT "" /*5*/  
    FIELD E2text18      AS CHAR FORMAT "x(255)"  INIT "" /*5*/ 
    FIELD E2prmp        AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD E2totalp      AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD Enetprm       AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0 
    FIELD Egrossprm     AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD E2oldpol      AS CHAR FORMAT "x(20)" INIT ""
    FIELD EAddress1     AS ChAR FORMAT "X(50)" INIT "" /*1*/ 
    FIELD EAddress2     AS ChAR FORMAT "X(50)" INIT "" /*1*/ 
    FIELD EAddress3     AS ChAR FORMAT "X(50)" INIT "" /*1*/ 
    FIELD EAddress4     AS ChAR FORMAT "X(50)" INIT "" /*1*/ 
    FIELD im2tmoobr     AS CHAR FORMAT "x(20)" INIT ""
    FIELD im2troom      AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2thome      AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2tmoo       AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2tsoi       AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2troad      AS CHAR FORMAT "x(20)" INIT ""
    FIELD im2ttumb      AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2tamph      AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2tprov      AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2tpost      AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2tetel      AS ChAR FORMAT "X(50)" INIT ""
    FIELD im2bran       AS CHAR FORMAT "X(2)"  INIT ""
    FIELD im2garage     AS CHAR FORMAT "X(2)"  INIT ""
    FIELD TPBI_Person   AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD TPBI_Accident AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD TPPD_Accident AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD no41          AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD no42          AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0
    FIELD no43          AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0 
    FIELD benefic       AS CHAR FORMAT "x(60)" INIT "" 
    FIELD payment       AS CHAR FORMAT "x(20)" INIT "" 
    FIELD track         AS CHAR FORMAT "x(50)" INIT "" 
    FIELD Promo         AS CHAR FORMAT "x(20)" INIT "" 
    FIELD campaign      AS CHAR FORMAT "x(20)" INIT "" 
    FIELD agent         AS CHAR FORMAT "x(10)" INIT ""   /*A61-0269*/
    FIELD producer      AS CHAR FORMAT "x(10)" INIT "".  /*A61-0269*/

