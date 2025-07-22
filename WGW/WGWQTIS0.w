&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-wins 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:
     <none>
Output Parameters:
     <none>
Author: 
Created: 
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/*++++++++++++++++++++++++++++++++++++++++++++++
  wgwqtis0.w :  Import text file from  Tisco  to create  new policy   
                         Add in table  tlt  
                         Query & Update flag detail
  Create  by   :  Kridtiya i. [A53-0207]   On   28/05/2010
  Connect      :  sic_test, stat   
  modify by    :  kridtiya i. A54-0216 ปรับการแสดงกรมธรรม์ให้เร็วยิ่งขึ้น 
  modify by    :  kridtiya i. A55-0184 22/05/2012 ปรับการแสดงกรมธรรม์ให้เร็วยิ่งขึ้น 
  modify by    :  Kridtiya i. A55-0365 เพิ่มส่วนการเรียกรายงานแสดงงานค้างระบบ
  modify by    :  Kridtiya i. A56-0146 เพิ่ม การ update status yes/no/cancel ในข้อมูลแรกได้
  modify by    :  Kridtiya i. A56-0323 เพิ่ม การ ให้ค่า record แรก
/*modify by    : Kridtiya i. A57-0262 add new format idno and id br name 
  modify BY    : MANOP G,  A59-0178    เพิ่มช่อง วันคุ้มครองของ พรบ.  -*/
  modify by    : Ranu I. A60-0118 14/03/2017 เพิ่มช่องการแมทหาเลขที่ตรวจสภาพ 
  modify by    : Sarinya C. A63-0210 26/05/2020 เปลี่ยนแปลง Layout Text โดยเพิ่ม field  ต่อท้ายจากเดิม 
  Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 เพิ่ม ช่อง susspect Yes/no 
  modify by   : Kridtiya i. A65-0364 Date. 05/12/2022 แมทไฟล์กรมธรรม์
  modify by   : Kridtiya i. A66-0046 Date. 07/03/2023 add search by 
  modify by   : Kridtiya i. A67-0035 Date. 02/02/2024 add branch display
  Modify by   : Ranu I. A67-0087  เพิ่มข้อมูลรถไฟฟ้า 
  /*Modify by  : Ranu I. A67-0114  เพิ่มข้อมูลรถไฟฟ้า และแก้ไขรายงาน     */
+++++++++++++++++++++++++++++++++++++++++++++++*/

 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR. /*A55-0365 */
 DEFINE VAR  vAcProc_fil1 AS CHAR. /*A55-0365 */
 DEF    VAR  nv_72Reciept AS CHAR INIT "" .
 DEFINE stream  ns2.
 DEF VAR nv_row AS INT INIT 0.  /*A60-0118*/
/*------- create by A60-0118------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
     FIELD RecordID     AS CHAR FORMAT "X(02)"  INIT ""   /*1  Detail Record "D"*/
     FIELD Pro_off      AS CHAR FORMAT "X(10)"  INIT ""   /*2  รหัสสาขาที่ผู้เอาประกันเปิดบัญชี    */
     FIELD cmr_code     AS CHAR FORMAT "X(03)"  INIT ""   /*3  รหัสเจ้าหน้าที่การตลาด    */
     FIELD comp_code    AS CHAR FORMAT "X(03)"  INIT ""   /*4  รหัส บ.ประกันภัย(TLT.COMMENT)   */
     FIELD Notify_no    AS CHAR FORMAT "X(25)"  INIT ""   /*5  เลขที่รับแจ้งประกัน   */
     FIELD yrmanu       AS CHAR FORMAT "X(4)"   INIT ""   /*6  Year of car  */
     FIELD engine       AS CHAR FORMAT "X(50)"  INIT ""   /*7  หมายเลขเครื่องยนต์*/
     FIELD chassis      AS CHAR FORMAT "X(50)"  INIT ""   /*8  หมายเลขตัวถังรถ*/
     FIELD weight       AS CHAR FORMAT "X(05)"  INIT ""   /*9  WEIGHT KG/TON*/
     FIELD Power        AS CHAR FORMAT "X(07)"  INIT ""   /*10 WEIGHT KG/TON*/
     FIELD colorcode    AS CHAR FORMAT "X(10)"  INIT ""   /*11 Color Code*/
     FIELD licence      AS CHAR FORMAT "X(10)"  INIT ""   /*12 หมายเลขทะเบียนรถ */
     FIELD garage       AS CHAR FORMAT "X(01)"  INIT ""   /*13 Claim condition /การซ่อม */
     FIELD fleetper     AS CHAR FORMAT "X(05)"  INIT ""   /*14 Fleet Discount     */
     FIELD ncbper       AS CHAR FORMAT "X(05)"  INIT ""   /*15 Experience Discount /ส่วนลดประวัติดี  */
     FIELD othper       AS CHAR FORMAT "X(05)"  INIT ""   /*16 Other Discount /ส่วนลดอื่น ๆ  */
     FIELD ISP          AS CHAR FORMAT "X(50)"  INIT ""   /*17 เลขที่ตรวจสภาพ */
     FIELD comdat       AS CHAR FORMAT "X(08)"  INIT ""   /*18 วันทีเริ่มคุ้มครอง */
     FIELD ins_amt      AS CHAR FORMAT "X(11)"  INIT ""   /*19 ทุนประกัน */
     FIELD name_insur   AS CHAR FORMAT "X(15)"  INIT ""   /*20 ชื่อเจ้าหน้าที่ประกัน */
     FIELD Not_office   AS CHAR FORMAT "X(75)"  INIT ""   /*21 รหัสเจ้าหน้าทีแจ้งประกัน(Tisco)  */
     FIELD Not_date     AS CHAR FORMAT "X(08)"  INIT ""   /*22 วันที่แจ้งประกัน */
     FIELD Not_time     AS CHAR FORMAT "X(06)"  INIT ""   /*23 เวลาที่แจ้งประกัน */
     FIELD Not_code     AS CHAR FORMAT "X(04)"  INIT ""   /*24 รหัสแจ้งงาน เช่น TF01 */
     FIELD Prem1        AS CHAR FORMAT "X(11)"  INIT ""   /*25 เบี้ยประกันรวม(ค่าเบี้ยป.1 + ภาษี + อากร) */
     FIELD comp_prm     AS CHAR FORMAT "X(09)"  INIT ""   /*26 เบี้ยพรบ.รวม */
     FIELD sckno        AS CHAR FORMAT "X(25)"  INIT ""   /*27 เลขท ี Sticker. */
     FIELD brand        AS CHAR FORMAT "X(50)"  INIT ""   /*28 ยี่ห้อรถ */
     FIELD pol_addr1    AS CHAR FORMAT "X(50)"  INIT ""   /*29 ที่อยู่ผู้เอาประกัน1  */
     FIELD pol_addr2    AS CHAR FORMAT "X(60)"  INIT ""   /*30 ที่อยู่ผู้เอาประกัน2 รวมรหัสไปรษณีย์*/
     FIELD pol_title    AS CHAR FORMAT "X(30)"  INIT ""   /*31 คำนำหน้าชื่อผู้เอาประกัน  */
     FIELD pol_fname    AS CHAR FORMAT "X(75)"  INIT ""   /*32 ชื่อผู้เอาประกัน/นิติบุคคล */
     FIELD pol_Lname    AS CHAR FORMAT "X(45)"  INIT ""   /*33 นามสกุลผู้เอาประกัน  */
     FIELD Ben_name     AS CHAR FORMAT "X(65)"  INIT ""   /*34 ชื่อผู้รับประโยชน์  */
     FIELD Remark       AS CHAR FORMAT "X(150)" INIT ""   /*35 หมายเหตุ  */
     FIELD Account_no   AS CHAR FORMAT "X(10)"  INIT ""   /*36 เลขที่สัญญาของผู้เอาประกัน(Tisco)  */
     FIELD Client_no    AS CHAR FORMAT "X(07)"  INIT ""   /*37 รหัสของผู้เอาประกัน  */
     FIELD expdat       AS CHAR FORMAT "X(08)"  INIT ""   /*38 วันทีสิ้นสุดความคุ้มครอง */
     FIELD Gross_prm    AS CHAR FORMAT "X(11)"  INIT ""   /*39 เบี้ย.รวมพรบ. (ทั้งหมด) */
     FIELD Province     AS CHAR FORMAT "X(18)"  INIT ""   /*40 จังหวัดที่จดทะเบียนรถ */
     FIELD Receipt_name AS CHAR FORMAT "X(50)"  INIT ""   /*41 ชื่อที่ใช้ในการพิมพ์ใบเสร็จ */
     FIELD Agent        AS CHAR FORMAT "X(15)"  INIT ""   /*42 Code บริษัท เช่น Tisco,Tisco-pf. */
     FIELD Prev_insur   AS CHAR FORMAT "X(50)"  INIT ""   /*43 ชื่อบริษัทประกันภัยเดิม */
     FIELD Prev_pol     AS CHAR FORMAT "X(25)"  INIT ""   /*44 เลขที่กรมธรรม์เดิม */
     FIELD deduct       AS CHAR FORMAT "X(09)"  INIT ""   /*45 ความเสียหายส่วนแรก */
     FIELD addr1_70     AS CHAR FORMAT "X(50)"  INIT ""  
     FIELD seatenew     AS CHAR FORMAT "x(10)"  INIT ""   /*A57-0017*/
     FIELD addr2_70     AS CHAR FORMAT "X(60)"  INIT ""  
     FIELD nsub_dist70  AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD ndirection70 AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD nprovin70    AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD zipcode70    AS CHAR FORMAT "X(5)"   INIT ""  
     FIELD addr1_72     AS CHAR FORMAT "X(50)"  INIT ""  
     FIELD addr2_72     AS CHAR FORMAT "X(60)"  INIT ""  
     FIELD nsub_dist72  AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD ndirection72 AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD nprovin72    AS CHAR FORMAT "X(30)"  INIT ""  
     FIELD zipcode72    AS CHAR FORMAT "X(5)"   INIT ""  
     FIELD apptyp       AS CHAR FORMAT "X(10)"  INIT ""  
     FIELD appcode      AS CHAR FORMAT "X(2)"   INIT ""  
     FIELD nBLANK1      AS CHAR FORMAT "X(250)"   INIT ""    /*A63-0210*/
     FIELD nBLANK2      AS CHAR FORMAT "X(9)"   INIT ""    /*A63-0210*/
     FIELD pack         AS CHAR FORMAT "X(10)"  INIT ""    /*A55-0184*/
     FIELD tp1          AS CHAR FORMAT "X(20)"  INIT ""   
     FIELD tp2          AS CHAR FORMAT "X(20)"  INIT ""   
     FIELD tp3          AS CHAR FORMAT "X(20)"  INIT ""
     FIELD covcod       AS CHAR FORMAT "X(5)"   INIT ""  
     FIELD producer     AS CHAR FORMAT "X(10)"  INIT ""     
     FIELD agent2       AS CHAR FORMAT "X(10)"  INIT "" 
     FIELD branch       AS CHAR FORMAT "X(2)"   INIT ""
     FIELD new_re       AS CHAR FORMAT "x(20)"  INIT ""
     FIELD Redbook      AS CHAR FORMAT "X(10)"   INIT ""
     FIELD Price_Ford   AS CHAR FORMAT "X(20)"   INIT ""
     FIELD Year_fd      AS CHAR FORMAT "X(10)"   INIT ""
     FIELD Brand_Model  AS CHAR FORMAT "X(60)"   INIT ""
     FIELD id_no70      AS CHAR FORMAT "x(13)"  INIT "" 
     FIELD id_nobr70    AS CHAR FORMAT "x(20)"  INIT ""
     FIELD id_no72      AS CHAR FORMAT "x(13)"  INIT ""
     FIELD id_nobr72    AS CHAR FORMAT "x(20)"  INIT ""
     FIELD comp_comdat   AS CHAR FORMAT "X(8)"  INIT ""       
     FIELD comp_expdat   AS CHAR FORMAT "X(8)"  INIT ""       
     FIELD fi            AS CHAR FORMAT "X(11)" INIT ""       
     FIELD class         AS CHAR FORMAT "X(3)"  INIT ""       
     FIELD usedtype      AS CHAR FORMAT "x(1)"  INIT ""       
     FIELD driveno1      AS CHAR FORMAT "x(2)"  INIT ""       
     FIELD drivename1    AS CHAR FORMAT "x(40)" INIT ""       
     FIELD bdatedriv1    AS CHAR FORMAT "x(8)"  INIT ""       
     FIELD occupdriv1    AS CHAR FORMAT "x(75)" INIT ""       
     FIELD positdriv1    AS CHAR FORMAT "X(40)" INIT ""       
     FIELD driveno2      AS CHAR FORMAT "x(2)"  INIT ""       
     FIELD drivename2    AS CHAR FORMAT "x(40)" INIT ""       
     FIELD bdatedriv2    AS CHAR FORMAT "x(8)"  INIT ""       
     FIELD occupdriv2    AS CHAR FORMAT "x(75)" INIT ""       
     FIELD positdriv2    AS CHAR FORMAT "X(40)" INIT ""       
     FIELD driveno3      AS CHAR FORMAT "x(2)"  INIT ""       
     FIELD drivename3    AS CHAR FORMAT "x(40)" INIT ""       
     FIELD bdatedriv3    AS CHAR FORMAT "x(8)"  INIT ""       
     FIELD occupdriv3    AS CHAR FORMAT "x(75)" INIT ""       
     FIELD positdriv3    AS CHAR FORMAT "X(40)" INIT ""
     FIELD receipt72     AS CHAR FORMAT "x(50)" INIT "" 
     FIELD caracc        AS CHAR FORMAT "x(250)" INIT ""    /*A63-0210*/
     FIELD Rec_name72    AS CHAR FORMAT "x(150)" INIT ""    /*A63-0210*/
     FIELD Rec_add1      AS CHAR FORMAT "x(60)"  INIT ""    /*A63-0210*/
     FIELD Rec_add2      AS CHAR FORMAT "x(60)"  INIT ""    /*A63-0210*/
     FIELD remakuppol    AS CHAR FORMAT "x(150)" INIT ""    /*Add A65-0364 */
     FIELD policyno      AS CHAR FORMAT "X(20)"  INIT ""    /*Add A65-0364 */
    /* A67-0087 */
     FIELD acctyp        AS CHAR FORMAT "x(1)"    INIT ""   
     FIELD acccovins     AS CHAR FORMAT "x(20)"   INIT ""   
     FIELD accpremt      AS CHAR FORMAT "x(20)"   INIT ""   
     FIELD inspecttyp    AS CHAR FORMAT "x(1)"    INIT ""   
     FIELD quotation     AS CHAR FORMAT "x(20)"   INIT ""   
     FIELD covcodtype    AS CHAR FORMAT "x(1)"    INIT ""
     FIELD Schanel       AS Char FORMAT "X(1)"   init "" 
     FIELD bev           AS Char FORMAT "X(1)"   init "" 
     FIELD driveno4      AS CHAR FORMAT "x(2)"   INIT "" 
     FIELD drivename4    AS Char FORMAT "X(40)"  init "" 
     FIELD bdatedriv4    AS CHAR FORMAT "x(8)"   INIT "" 
     FIELD occupdriv4    AS Char FORMAT "X(75)"  init "" 
     FIELD positdriv4    AS Char FORMAT "X(40)"  init "" 
     FIELD driveno5      AS CHAR FORMAT "x(2)"   INIT ""  
     FIELD drivename5    AS Char FORMAT "X(40)"  init "" 
     FIELD bdatedriv5    AS CHAR FORMAT "x(8)"   INIT "" 
     FIELD occupdriv5    AS Char FORMAT "X(75)"  init "" 
     FIELD positdriv5    AS Char FORMAT "X(40)"  init "" 
     FIELD campagin      AS Char FORMAT "X(20)"  init "" 
     FIELD inspic        AS Char FORMAT "X(1)"   init "" 
     FIELD engcount      AS Char FORMAT "X(2)"   init "" 
     FIELD engno2        AS Char FORMAT "X(35)"  init "" 
     FIELD engno3        AS Char FORMAT "X(35)"  init "" 
     FIELD engno4        AS Char FORMAT "X(35)"  init "" 
     FIELD engno5        AS Char FORMAT "X(35)"  init "" 
     FIELD classcomp     AS Char FORMAT "X(5)"   init ""  
     FIELD carbrand      AS CHAR FORMAT "X(50)"  INIT "" .
    /* end : A67-0087 */
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO                 
     FIELD TISCO_CODE        AS CHAR FORMAT "X(10)"  INIT ""   /* TISCO_CODE    HN*/
     FIELD contract          AS CHAR FORMAT "X(30)"  INIT ""   /* เลขที่สัญญา   78688981*/
     FIELD notidate          AS CHAR FORMAT "X(20)"  INIT ""   /* วันที่แจ้งงาน 44670*/
     FIELD comdate           AS CHAR FORMAT "X(20)"  INIT ""   /* วันเริ่มคุ้มครอง      44679*/
     FIELD comname           AS CHAR FORMAT "X(150)" INIT ""   /* บริษัทประกันภัย       คุ้มภัยโตเกียวมารีนประกันภัย*/
     FIELD insname           AS CHAR FORMAT "X(150)" INIT ""   /* ชื่อผู้เอาประกัน      นายดิสทัต โรจนสุนทร*/
     FIELD vehreg            AS CHAR FORMAT "X(30)"  INIT ""   /* หมายเลขทะเบียน        7กบ 9383*/
     FIELD province          AS CHAR FORMAT "X(30)"  INIT ""   /* จังหวัดจดทะเบียน      กรุงเทพมหานคร*/
     FIELD remark            AS CHAR FORMAT "X(250)" INIT ""   /* หมายเหตุ      NPP/0892345353/คุณภารุจ/อ.เมือง จ.นนทบุรี*/
     FIELD status_detail     AS CHAR FORMAT "X(250)" INIT ""   /* สถานะความคืบหน้า               */
     FIELD comcode           AS CHAR FORMAT "X(10)"  INIT ""   /* รหัสบริษัทประกันภัย   410  */
     FIELD ncb               AS CHAR FORMAT "X(10)"  INIT ""   /* NCB   0                    */
     FIELD yearproduct       AS CHAR FORMAT "X(10)"  INIT ""   /* YEAR_PRODUCT  2018         */
     FIELD InspectionNo      AS CHAR FORMAT "X(20)"  INIT ""                                  
     FIELD InspectionResult  AS CHAR FORMAT "X(250)"  INIT "" 
     FIELD InspectionDamage  AS CHAR FORMAT "X(500)"  INIT "" 
     FIELD InspectionResult2 AS CHAR FORMAT "X(250)"  INIT "" 
     FIELD InspectionDamage2 AS CHAR FORMAT "X(500)"  INIT "" 
     FIELD nvpolicy          AS CHAR FORMAT "X(20)"  INIT "" 
     FIELD nvchassis         AS CHAR FORMAT "X(50)"  INIT "" 
     FIELD resulte           AS CHAR FORMAT "X(250)"  INIT "" 
     FIELD receivedate       AS CHAR FORMAT "X(20)"  INIT "" 
     FIELD insurceacc        AS CHAR FORMAT "X(250)"  INIT "" 
     FIELD accessories       AS CHAR FORMAT "X(500)"  INIT "" 
     FIELD antitheftdevice   AS CHAR FORMAT "X(250)"  INIT "" 
     FIELD anotherdevice     AS CHAR FORMAT "X(500)"  INIT "" 
     FIELD branchdespinsp    AS CHAR FORMAT "x(100)" INIT ""   /*A67-0035*/
    .
DEF VAR nv_vehreg AS CHAR INIT "".
DEF VAR nv_cha_no AS CHAR INIT "".
DEF VAR nv_provi  AS CHAR INIT "".
DEF VAR nv_expdat AS DATE INIT ?.
DEF VAR nv_year       AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno      AS CHAR FORMAT "x(25)".
DEF VAR nv_survey     AS CHAR FORMAT "x(25)".
DEF VAR nv_detail     AS CHAR FORMAT "x(250)".
DEF VAR nv_detail2     AS CHAR FORMAT "x(250)".
DEF VAR n_list        AS INT init 0.
DEF VAR n_count       AS INT init 0.
DEF VAR n_repair      AS CHAR FORMAT "x(10)" init "".
DEF VAR n_repair2      AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam         AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil      AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag      AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair     AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair2     AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_damdetail   AS LONGCHAR  INIT "". 
DEF VAR nv_damdetail2  AS LONGCHAR  INIT "". 
DEF VAR n_agent       AS CHAR FORMAT "x(12)" INIT "".
DEF VAR nv_remark1    AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2    AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist    AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage     AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam   AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile    AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device     AS CHAR FORMAT "x(500)" INIT "".
DEF VAR nv_device2     AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1       as char format "x(50)".   
Def var nv_acc2       as char format "x(50)".   
Def var nv_acc3       as char format "x(50)".   
Def var nv_acc4       as char format "x(50)".   
Def var nv_acc5       as char format "x(50)".   
Def var nv_acc6       as char format "x(50)".   
Def var nv_acc7       as char format "x(50)".   
Def var nv_acc8       as char format "x(50)".   
Def var nv_acc9       as char format "x(50)".   
Def var nv_acc10      as char format "x(50)".   
Def var nv_acc11      as char format "x(50)".   
Def var nv_acc12      as char format "x(50)".  
Def var nv_acc1amt       as  deci init 0.
Def var nv_acc2amt       as  deci init 0.
Def var nv_acc3amt       as  deci init 0.
Def var nv_acc4amt       as  deci init 0.
Def var nv_acc5amt       as  deci init 0.
Def var nv_acc6amt       as  deci init 0.
Def var nv_acc7amt       as  deci init 0.
Def var nv_acc8amt       as  deci init 0.
Def var nv_acc9amt       as  deci init 0.
Def var nv_acc10amt      as  deci init 0.
Def var nv_acc11amt      as  deci init 0.
Def var nv_acc12amt      as  deci init 0.
Def var nv_acctotal   as char format "x(250)".   
DEF VAR nv_surdata    AS CHAR FORMAT "x(250)".
DEF VAR nv_date       AS CHAR FORMAT "x(15)".
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As CHAR. 
DEF  VAR nv_statuspol    AS CHAR.
DEF BUFFER   buwm100 FOR   sicuw.uwm100.
DEF VAR nv_surveydata AS CHAR.
DEF VAR nv_branchdesp AS CHAR FORMAT "x(100)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_tlt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.usrsent ~
If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew" Else  " " ~
tlt.exp IF index(tlt.mode,"Detail") <> 0 THEN ("YES") ELSE ("NO") ~
tlt.filler1 tlt.nor_noti_ins tlt.ins_name tlt.cha_no tlt.gendat tlt.expodat ~
tlt.comp_sck tlt.nor_coamt tlt.nor_grprm tlt.comp_grprm tlt.comp_coamt ~
substr(tlt.model,1,50) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_insp bu_match2 fi_importisp2 fi_output2 ~
fi_yearisp bu_match fi_output ra_status fi_trndatfr fi_trndatto bu_ok ~
cb_search bu_oksch br_tlt fi_search bu_update cb_report fi_br fi_outfile ~
bu_report bu_exit bu_upyesno fi_filename bu_file bu_file-2 RECT-333 ~
RECT-338 RECT-339 RECT-340 RECT-381 RECT-383 RECT-334 RECT-335 RECT-336 
&Scoped-Define DISPLAYED-OBJECTS ra_insp fi_importisp2 fi_output2 ~
fi_yearisp fi_output ra_status fi_trndatfr fi_trndatto cb_search fi_search ~
fi_name cb_report fi_br fi_outfile fi_filename 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_file-2 
     LABEL "..." 
     SIZE 4 BY .91.

DEFINE BUTTON bu_match 
     LABEL "Match" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_match2 
     LABEL "Match" 
     SIZE 6.5 BY .91.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "OK" 
     SIZE 5 BY .95
     FONT 6.

DEFINE BUTTON bu_report 
     LABEL "OK" 
     SIZE 7 BY .95
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 14 BY 1.05
     FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 14 BY 1.05
     FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชื่อผู้เอาประกัน" 
     DROP-DOWN-LIST
     SIZE 40 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_importisp2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 39 BY .95
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40.67 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY .95 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_yearisp AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     LABEL "Year ISP" 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91 NO-UNDO.

DEFINE VARIABLE ra_insp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "insp", 1,
"follow", 2
     SIZE 16.5 BY .91
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"Cancel", 3,
"All", 4
     SIZE 31 BY 1
     BGCOLOR 2 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.76
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-334
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.76
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.76
     BGCOLOR 11 .

DEFINE RECTANGLE RECT-336
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 1.76
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 58.5 BY 3
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.91
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130.17 BY 2.14.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.52
     BGCOLOR 22 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 12
     BGCOLOR 3 FGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Cancle/Confirm" FORMAT "x(20)":U
            WIDTH 12.83
      tlt.usrsent COLUMN-LABEL "Sussp." FORMAT "x(7)":U
      If  tlt.flag  =  "N"  Then  "New"  Else If  tlt.flag = "R" Then  "Renew"
Else  " " COLUMN-LABEL "New/Renew" FORMAT "x(8)":U
            WIDTH 11.83 LABEL-FGCOLOR 1 LABEL-FONT 6
      tlt.exp COLUMN-LABEL "br." FORMAT "XX":U WIDTH 2.5
      IF index(tlt.mode,"Detail") <> 0 THEN ("YES") ELSE ("NO") COLUMN-LABEL "ISP" FORMAT "X(5)":U
            WIDTH 4.17
      tlt.filler1 COLUMN-LABEL "กรมธรรม์เดิม" FORMAT "x(20)":U
            WIDTH 15
      tlt.nor_noti_ins COLUMN-LABEL "เลขกรมธรรม์ใหม่" FORMAT "x(20)":U
            WIDTH 15
      tlt.ins_name FORMAT "x(30)":U WIDTH 26.33
      tlt.cha_no FORMAT "x(20)":U WIDTH 21.83
      tlt.gendat COLUMN-LABEL "Comdate" FORMAT "99/99/9999":U
      tlt.expodat FORMAT "99/99/9999":U WIDTH 9.5
      tlt.comp_sck FORMAT "x(15)":U WIDTH 14.17
      tlt.nor_coamt FORMAT "->,>>>,>>>,>>9.99":U
      tlt.nor_grprm FORMAT ">>,>>>,>>9.99":U WIDTH 11.5
      tlt.comp_grprm FORMAT ">>>,>>9.99":U WIDTH 9.33
      tlt.comp_coamt FORMAT "->>,>>>,>>9.99":U
      substr(tlt.model,1,50) COLUMN-LABEL "ข้อมูลการตรวจสภาพ" FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 11.24
         BGCOLOR 15  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_insp AT ROW 11 COL 3 NO-LABEL WIDGET-ID 26
     bu_match2 AT ROW 10.95 COL 109 WIDGET-ID 10
     fi_importisp2 AT ROW 10.95 COL 40 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_output2 AT ROW 11.95 COL 40 COLON-ALIGNED NO-LABEL WIDGET-ID 8
     fi_yearisp AT ROW 10.95 COL 122.17 COLON-ALIGNED WIDGET-ID 14
     bu_match AT ROW 9.14 COL 73.67
     fi_output AT ROW 9.19 COL 88.67 COLON-ALIGNED NO-LABEL
     ra_status AT ROW 6.67 COL 58.17 NO-LABEL
     fi_trndatfr AT ROW 1.71 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.71 COL 60.67 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.81 COL 96
     cb_search AT ROW 3.71 COL 16 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 5.05 COL 53
     br_tlt AT ROW 13.48 COL 1.33
     fi_search AT ROW 4.95 COL 2.83 NO-LABEL
     fi_name AT ROW 4.81 COL 60.17 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 4.86 COL 102
     cb_report AT ROW 6.67 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_br AT ROW 7.81 COL 15.5 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.81 COL 39.17 NO-LABEL
     bu_report AT ROW 7.19 COL 92.67
     bu_exit AT ROW 1.81 COL 120.83
     bu_upyesno AT ROW 4.86 COL 117.17
     fi_filename AT ROW 9.14 COL 20 NO-LABEL
     bu_file AT ROW 9.14 COL 69.33
     bu_file-2 AT ROW 10.95 COL 104.83 WIDGET-ID 6
     "Click for update Flag Cancel":40 VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 3.76 COL 62.5
          BGCOLOR 19 FONT 6
     "Match Field ISP :":40 VIEW-AS TEXT
          SIZE 16.5 BY 1 AT ROW 9.14 COL 2.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "output :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 9.14 COL 82.83
          BGCOLOR 8 FGCOLOR 15 FONT 6
     "br" VIEW-AS TEXT
          SIZE 14.17 BY .95 AT ROW 7.81 COL 2.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.71 COL 54.17
          BGCOLOR 18 FONT 6
     "Output file name :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 7.81 COL 21.67
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "RESULTผลตรวจ ISP:" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 10.95 COL 20 WIDGET-ID 2
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "OUTPUTผลตรวจ ISP:" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 11.95 COL 20 WIDGET-ID 12
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "วันที่ไฟล์แจ้งงาน  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.71 COL 4
          BGCOLOR 18 FONT 6
     "   Search  By :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.71 COL 2.83
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Report BY" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 6.71 COL 2.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-333 AT ROW 1.38 COL 94.67
     RECT-338 AT ROW 3.48 COL 1.67
     RECT-339 AT ROW 3.52 COL 61
     RECT-340 AT ROW 1.24 COL 1.83
     RECT-381 AT ROW 4.76 COL 51.67
     RECT-383 AT ROW 1.1 COL 1.5 WIDGET-ID 16
     RECT-334 AT ROW 1.48 COL 119.67 WIDGET-ID 18
     RECT-335 AT ROW 6.71 COL 90.67 WIDGET-ID 20
     RECT-336 AT ROW 8.81 COL 2.17 WIDGET-ID 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.24
         SIZE 133 BY 23.76
         BGCOLOR 8 .


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [Tisco]"
         HEIGHT             = 24.19
         WIDTH              = 133.17
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         FONT               = 6
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-wins:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-wins
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_tlt bu_oksch fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       bu_file-2:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_filename IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outfile IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "Cancle/Confirm" "x(20)" "character" ? ? ? ? ? ? no ? no no "12.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.usrsent
"tlt.usrsent" "Sussp." "x(7)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"If  tlt.flag  =  ""N""  Then  ""New""  Else If  tlt.flag = ""R"" Then  ""Renew""
Else  "" """ "New/Renew" "x(8)" ? ? ? ? ? 1 6 no ? no no "11.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.exp
"tlt.exp" "br." ? "character" ? ? ? ? ? ? no ? no no "2.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"IF index(tlt.mode,""Detail"") <> 0 THEN (""YES"") ELSE (""NO"")" "ISP" "X(5)" ? ? ? ? ? ? ? no ? no no "4.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.filler1
"tlt.filler1" "กรมธรรม์เดิม" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "เลขกรมธรรม์ใหม่" "x(20)" "character" ? ? ? ? ? ? no ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.ins_name
"tlt.ins_name" ? "x(30)" "character" ? ? ? ? ? ? no ? no no "26.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.cha_no
"tlt.cha_no" ? ? "character" ? ? ? ? ? ? no ? no no "21.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.gendat
"tlt.gendat" "Comdate" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.expodat
"tlt.expodat" ? "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.comp_sck
"tlt.comp_sck" ? "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   = brstat.tlt.nor_coamt
     _FldNameList[14]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" ? ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "11.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" ? ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "9.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   = brstat.tlt.comp_coamt
     _FldNameList[17]   > "_<CALC>"
"substr(tlt.model,1,50)" "ข้อมูลการตรวจสภาพ" "X(50)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [Tisco] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [Tisco] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_tlt
&Scoped-define SELF-NAME br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    Get Current br_tlt.
          nv_recidtlt  =  Recid(tlt).

    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\wgwqtis2(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-CLICK OF br_tlt IN FRAME fr_main
DO:
    Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-wins
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   
   Apply "Close" to This-procedure.
   Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-wins
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        /*      FILTERS    "Text Documents" "*.txt"    */
        FILTERS    /* "Text Documents"   "*.txt",
        "Data Files (*.*)"     "*.*"*/
        "Text Documents" "*.csv"
        
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_filename  = cvData.
        fi_output    = REPLACE(fi_filename,".CSV","").
        fi_output    = fi_output + "_ISP" + ".SLK". 
        DISP fi_filename fi_output WITH FRAME fr_main.     
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-2 c-wins
ON CHOOSE OF bu_file-2 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        /*      FILTERS    "Text Documents" "*.txt"    */
        FILTERS    /* "Text Documents"   "*.txt",
        "Data Files (*.*)"     "*.*"*/
        "Text Documents" "*.csv"
        
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_importisp2  = cvData.
        fi_output2    = REPLACE(fi_importisp2,".CSV","").
        fi_output2    = fi_output2 + "_ISP" + ".SLK". 
        DISP fi_importisp2  fi_output2 WITH FRAME fr_main.     
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_match c-wins
ON CHOOSE OF bu_match IN FRAME fr_main /* Match */
DO:
    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"        
            wdetail.Pro_off      
            wdetail.cmr_code     
            wdetail.comp_code    
            wdetail.Notify_no    
            wdetail.yrmanu       
            wdetail.engine       
            wdetail.chassis      
            wdetail.weight       
            wdetail.power        
            wdetail.colorcode    
            wdetail.licence      
            wdetail.garage       
            wdetail.fleetper     
            wdetail.ncbper       
            wdetail.othper       
            wdetail.isp       
            wdetail.comdat       
            wdetail.ins_amt      
            wdetail.name_insur   
            wdetail.not_office   
            wdetail.not_date     
            wdetail.not_time     
            wdetail.not_code     
            wdetail.prem1       
            wdetail.comp_prm    
            wdetail.sckno       
            wdetail.brand       
            wdetail.pol_addr1   
            wdetail.pol_addr2   
            wdetail.pol_title   
            wdetail.pol_fname   
            wdetail.pol_lname   
            wdetail.ben_name    
            wdetail.remark      
            wdetail.Account_no  
            wdetail.client_no   
            wdetail.expdat      
            wdetail.gross_prm   
            wdetail.province    
            wdetail.receipt_name
            wdetail.agent2       
            wdetail.prev_insur  
            wdetail.prev_pol    
            wdetail.deduct 
    /*46*/  wdetail.addr1_70     
    /*47*/  wdetail.addr2_70     
    /*48*/  wdetail.nsub_dist70  
    /*49*/  wdetail.ndirection70 
    /*50*/  wdetail.nprovin70    
    /*51*/  wdetail.zipcode70    
    /*52*/  wdetail.addr1_72     
    /*53*/  wdetail.addr2_72     
    /*54*/  wdetail.nsub_dist72  
    /*55*/  wdetail.ndirection72 
    /*56*/  wdetail.nprovin72    
    /*57*/  wdetail.zipcode72    
    /*58*/  wdetail.apptyp       
    /*59*/  wdetail.appcode      
    /*60*/  wdetail.nBLANK1
            wdetail.pack 
            wdetail.seatenew    /*A57-0017*/
            wdetail.tp1     
            wdetail.tp2     
            wdetail.tp3 
            wdetail.covcod
            wdetail.producer
            wdetail.agent   
            wdetail.branch   
            wdetail.new_re        
            wdetail.Redbook      
            wdetail.Price_Ford   
            wdetail.Year_fd      
            wdetail.Brand_Model  
            wdetail.id_no70      
            wdetail.id_nobr70    
            wdetail.id_no72      
            wdetail.id_nobr72 
            wdetail.comp_comdat         /*- A59-0178 -*/
            wdetail.comp_expdat 
            wdetail.fi          
            wdetail.class       
            wdetail.usedtype    
            wdetail.driveno1    
            wdetail.drivename1  
            wdetail.bdatedriv1  
            wdetail.occupdriv1  
            wdetail.positdriv1  
            wdetail.driveno2    
            wdetail.drivename2  
            wdetail.bdatedriv2  
            wdetail.occupdriv2  
            wdetail.positdriv2  
            wdetail.driveno3    
            wdetail.drivename3  
            wdetail.bdatedriv3  
            wdetail.occupdriv3  
            wdetail.positdriv3  
            wdetail.nBLANK2 
            wdetail.receipt72
            wdetail.caracc          /*- start A63-0210 -*/
            wdetail.Rec_name72
            wdetail.Rec_add1  
            wdetail.Rec_add2        /*- End A63-0210 -*/
            /* add by : A67-0087 */
            wdetail.acctyp     
            wdetail.acccovins  
            wdetail.accpremt   
            wdetail.inspecttyp 
            wdetail.quotation  
            wdetail.covcodtype 
            wdetail.Schanel    
            wdetail.bev        
            wdetail.driveno4   
            wdetail.drivename4 
            wdetail.bdatedriv4 
            wdetail.occupdriv4 
            wdetail.positdriv4 
            wdetail.driveno5   
            wdetail.drivename5 
            wdetail.bdatedriv5 
            wdetail.occupdriv5 
            wdetail.positdriv5 
            wdetail.campagin   
            wdetail.inspic     
            wdetail.engcount   
            wdetail.engno2     
            wdetail.engno3     
            wdetail.engno4     
            wdetail.engno5     
            wdetail.classcomp  
            wdetail.carbrand .
        /* end : A67-0087 */
            
    END.  /* repeat  */
    FOR EACH wdetail .
        IF      INDEX(wdetail.Pro_off,"pro")    <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.Pro_off,"total")  <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.Pro_off,"บริษัท") <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.Pro_off    = "" THEN  DELETE wdetail.
        ELSE DO:
            ASSIGN nv_statuspol = "no".
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                        brstat.tlt.cha_no    = trim(wdetail.chassis)  AND
                        brstat.tlt.eng_no    = TRIM(wdetail.engine)   AND  
                        brstat.tlt.genusr    = "TISCO"                NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN DO:
                /*IF AVAIL brstat.tlt THEN */ /*A65-0364*/  
                /*Add A65-0364 */
                ASSIGN wdetail.isp = substr(brstat.tlt.model,1,50).

                IF wdetail.Notify_no <> "" THEN DO:
                    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                        sicuw.uwm100.policy = TRIM(wdetail.Notify_no) NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        /*found*/
                        ASSIGN nv_statuspol = "yes"   /*found*/
                            tlt.nor_noti_ins = TRIM(wdetail.Notify_no)
                            tlt.releas       = "yes"
                            wdetail.remakuppol = "Up Policy: " + TRIM(wdetail.Notify_no) + " Status :YES" .
                    END.
                END. /*not found*/
                IF  nv_statuspol = "no" THEN DO:
                    IF wdetail.chassis <> ""  THEN DO:
                        FOR EACH sicuw.uwm301 USE-INDEX uwm30121 WHERE 
                            sicuw.uwm301.cha_no  = TRIM(wdetail.chassis)   NO-LOCK.
                            
                            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                                sicuw.uwm100.policy = sicuw.uwm301.policy 
                                NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uwm100 THEN DO:
                    
                                IF nv_expdat = ? THEN
                                    ASSIGN  
                                    nv_expdat          = sicuw.uwm100.expdat 
                                    wdetail.policyno   = sicuw.uwm301.policy .
                                ELSE IF sicuw.uwm100.expdat > nv_expdat THEN
                                    ASSIGN 
                                    nv_expdat          = sicuw.uwm100.expdat 
                                    wdetail.policyno   = sicuw.uwm301.policy .
                            END.
                        END.
                    END.
                END.
                /*Add A65-0364 */
            END.
            /*2 Year */
            IF INDEX(wdetail.remark,"_2Y") <> 0 THEN DO:
                FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
                    sicuw.uwm100.cedpol =  wdetail.Account_no AND
                    sicuw.uwm100.rencnt =  0                  AND
                    sicuw.uwm100.poltyp =  "V70"              NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    FIND LAST buwm100 USE-INDEX uwm10002     WHERE
                        buwm100.cedpol =  wdetail.Account_no AND
                        buwm100.rencnt =  1                  AND
                        buwm100.poltyp =  "V70"              NO-ERROR NO-WAIT.
                    IF AVAIL buwm100 THEN  
                        ASSIGN 
                        buwm100.prvpol      =  sicuw.uwm100.policy  /*กรมก่อนหน้า*/
                        sicuw.uwm100.renpol =  buwm100.policy.      /*กรมปีหน้า*/
                END.
                FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
                    sicuw.uwm100.cedpol =  wdetail.Account_no AND
                    sicuw.uwm100.rencnt =  0                  AND
                    sicuw.uwm100.poltyp =  "V72"              NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    FIND LAST buwm100 USE-INDEX uwm10002     WHERE
                        buwm100.cedpol =  wdetail.Account_no AND
                        buwm100.rencnt =  1                  AND
                        buwm100.poltyp =  "V72"              NO-ERROR NO-WAIT.
                    IF AVAIL buwm100 THEN  
                        ASSIGN 
                        buwm100.prvpol      =  sicuw.uwm100.policy  /*กรมก่อนหน้า*/
                        sicuw.uwm100.renpol =  buwm100.policy.      /*กรมปีหน้า*/
                END.
            END.
            /*2 Year */
        END.
    END.
    RUN pd_reportnew.
    Message "Load  Data Complete"  View-as alert-box.  
  RELEASE brstat.tlt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_match2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_match2 c-wins
ON CHOOSE OF bu_match2 IN FRAME fr_main /* Match */
DO:
    /* Kridtiya i. A65-0364*/
    FOR EACH  wdetail2 :
        DELETE  wdetail2.
    END.
    IF ra_insp = 1 THEN DO:    /* follow */
        INPUT FROM VALUE(fi_importisp2).
        REPEAT:
            CREATE wdetail2.
            IMPORT DELIMITER "|"        
                wdetail2.TISCO_CODE        
                wdetail2.contract          
                wdetail2.notidate          
                wdetail2.comdate           
                wdetail2.comname           
                wdetail2.insname           
                wdetail2.vehreg            
                wdetail2.province          
                wdetail2.remark            
                wdetail2.status_detail     
                wdetail2.comcode           
                wdetail2.ncb               
                wdetail2.yearproduct  
                wdetail2.nvchassis
                wdetail2.nvpolicy 
                /*wdetail2.nvchassis  
                wdetail2.nvchassis     /*เลขตัวถัง        */
                wdetail2.resulte       /*ผลการประสานงาน   */
                wdetail2.receivedate   /*วันที่รับเงิน    */
                wdetail2.status_detail /*สถานะการติดตาม   */
                wdetail2.insurceacc    /*ประกันแจ้งผลกลับ */
                wdetail2.nvpolicy*/
                .
        END.  /* repeat  */
    END.
    ELSE DO:
        INPUT FROM VALUE(fi_importisp2).
        REPEAT:
            CREATE wdetail2.
            IMPORT DELIMITER "|"        
                wdetail2.TISCO_CODE   /*TISCO            */                  
                wdetail2.contract     /*เลขที่สัญญา      */                 
                wdetail2.notidate     /*วันที่แจ้งงาน    */               
                wdetail2.comdate      /*วันเริ่มคุ้มครอง */                   
                wdetail2.comname      /*บริษัทประกันภัย  */               
                wdetail2.insname      /*ชื่อผู้เอาประกัน */                
                wdetail2.vehreg       /*หมายเลขทะเบียน   */       
                wdetail2.province     /*จังหวัดจดทะเบียน */ 
                wdetail2.nvchassis    /*เลขถัง           */ 
                wdetail2.resulte      /*ผลการประสานงาน   */  
                wdetail2.receivedate  /*  วันที่รับเงิน  */
                wdetail2.remark       /*สถานะการติดตาม   */   
                wdetail2.insurceacc   /*ประกันแจ้งผลกลับ */ 
                wdetail2.nvpolicy
                .                                                   
        END.  /* repeat  */
    END.
       
    FOR EACH wdetail2 .
        IF INDEX(wdetail2.TISCO_CODE,"TISCO")    <> 0 THEN  DELETE wdetail2.
        ELSE IF  wdetail2.TISCO_CODE   = ""           THEN  DELETE wdetail2.
        ELSE IF  wdetail2.TISCO_CODE   = "TISCO_CODE" THEN  DELETE wdetail2.
        ELSE DO:
            nv_expdat  = ? .
            nv_cha_no  = "".
            nv_provi   = "".
            nv_vehreg  = "".
            
            IF wdetail2.nvchassis <> "" THEN DO:
               ASSIGN nv_cha_no = trim(wdetail2.nvchassis).
               RUN proc_addinsp.
            END.
            ELSE IF wdetail2.nvpolicy <> "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                    sicuw.uwm100.policy = TRIM(wdetail2.nvpolicy) 
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                        sicuw.uwm301.policy =  sicuw.uwm100.policy
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm301 THEN DO:
                        ASSIGN nv_cha_no = trim(sicuw.uwm301.cha_no).
                    END.
                END.
                IF nv_cha_no <> "" THEN RUN proc_addinsp.
            END.
            ELSE IF wdetail2.vehreg <> "" AND wdetail2.province <> "" THEN DO:

                nv_provi = trim(wdetail2.province).
                RUN proc_matchvehreg.
                nv_vehreg = TRIM(wdetail2.vehreg) + " " + nv_provi.
                
                FOR EACH sicuw.uwm301 USE-INDEX uwm30102 WHERE 
                    sicuw.uwm301.vehreg = nv_vehreg NO-LOCK.
                    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                        sicuw.uwm100.policy = sicuw.uwm301.policy 
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        IF nv_expdat = ? THEN
                            ASSIGN  
                            nv_expdat          = sicuw.uwm100.expdat 
                            nv_cha_no          = sicuw.uwm301.cha_no 
                            wdetail2.nvpolicy  = sicuw.uwm301.policy
                            wdetail2.nvchassis = nv_cha_no .
                        ELSE IF sicuw.uwm100.expdat > nv_expdat THEN
                            ASSIGN 
                            nv_expdat          = sicuw.uwm100.expdat 
                            nv_cha_no          = trim(sicuw.uwm301.cha_no)
                            wdetail2.nvpolicy  = sicuw.uwm301.policy
                            wdetail2.nvchassis = nv_cha_no
                            .

                    END.
                END.
                RUN proc_addinsp.
            END.
        END.
    END.
    RELEASE brstat.tlt.
    IF ra_insp = 1 THEN RUN pd_reportisp.
    ELSE RUN pd_reportisp1.
    Message "Load  Data Complete"  View-as alert-box.  
    
  /* Kridtiya i. A65-0364*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    /*If  fi_polfr  =  "0"   Then  fi_polfr  =  "0"  .
    If  fi_polto  =  "Z"   Then  fi_polto  =  "Z".*/
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        /*tlt.policy  >=   fi_polfr     And
        tlt.policy  <=   fi_polto     And*/
        /*tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "Tisco"        no-lock.  
            nv_rectlt =  recid(tlt).   /*A55-0184*/
            Apply "Entry"  to br_tlt.
            Return no-apply.                             
            /*------------------------ 
            {&WINDOW-NAME}:hidden  =  Yes. 
            Run  wuw\wuwqtis1(Input  fi_trndatfr,
            fi_trndatto,
            fi_polfr,
            fi_polto,
            fi_producer).
            {&WINDOW-NAME}:hidden  =  No.                                               
            --------------------------*/
        END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* OK */
DO:
    Disp fi_search  with frame fr_main.
    /* A65-0035*/
    IF  cb_search = "เลขรับแจ้ง"  THEN DO:
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "Tisco"            And
            INDEX(tlt.nor_noti_tlt,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.  
    END.
    /* end : A65-0035 */
    IF  cb_search = "เลขที่สัญญา"  THEN DO:   /*---------A66-0046*/
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "Tisco"            And
            INDEX(tlt.safe2,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.  
    END.  /*---------------------------------------------A66-0046*/
    ELSE If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "Tisco"            And
            index(tlt.ins_name,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ต่ออายุ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            tlt.flag      =  "R"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "Tisco"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  = "ทะเบียนรถ"  Then do:   /*- add Kridtiya i. A66-0046*/
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "Tisco"       And
            INDEX(tlt.lince1,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.  /*------------------------------------------add Kridtiya i. A66-0046*/
    ELSE If  cb_search  =  "Confirm_yes"  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "Tisco"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Confirm_no"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            tlt.genusr   =  "Tisco"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Tisco"        And
            index(tlt.releas,"cancel") > 0     no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Tisco"        And
            tlt.EXP      = fi_search       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "รถไฟฟ้า(EV)"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Tisco"        And
            tlt.note8    = "Y"  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* OK */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "กรุณาใสชื่อไฟล์!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE DO:
        RUN pd_reportfiel. 
        Message "Export data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* CANCEL */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt .
    If  avail tlt Then do:
        If  index(tlt.releas,"Cancel")  =  0  Then do:
            message "ยกเลิกข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Cancel" .
            ELSE tlt.releas  =  "Cancel/" + tlt.releas .
        END.
        Else do:
            message "เรียกข้อมูลกลับมาใช้งาน "  View-as alert-box.
            IF index(tlt.releas,"Cancel/")  =  0 THEN
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"Cancel") + 6 ) .
            ELSE 
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"Cancel") + 7 ) .
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply.  
END.

      /*  If  index(tlt.releas,"cancel") = 0 THEN DO: 
        ASSIGN tlt.releas =  "cancel" + tlt.releas .
            message "ยกเลิกข้อมูลรายการนี้  " tlt.releas  /*FORMAT "x(20)" */
                View-as alert-box.
            

    END.
    ELSE IF index(tlt.releas,"cancel") <> 0   THEN DO:
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
        tlt.releas =  substr(tlt.releas,INDEX(tlt.releas,"cancel") + 6 ) + "/YES".
        DISP tlt.releas  FORMAT "x(20)"  index(tlt.releas,"cancel").
    END.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"No")  =  0  Then do:  /* yes */
            message "Update No ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/no" .
            ELSE ASSIGN tlt.releas  =  "no" .
        END.
        Else do:    /* no */
            If  index(tlt.releas,"Yes")  =  0  Then do:  /* yes */
            message "Update Yes ข้อมูลรายการนี้  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "Yes" .
            ELSE IF index(tlt.releas,"Cancel/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "Cancel/Yes" .
            ELSE ASSIGN tlt.releas  =  "Yes" .
        END.
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1  = INPUT cb_report.

    IF n_asdat1 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON return OF cb_report IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON VALUE-CHANGED OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1 =  (INPUT cb_report).

    IF n_asdat1 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล การค้น" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON LEAVE OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat = INPUT cb_search.

    IF n_asdat = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    /*APPLY "ENTRY" TO fi_comdatF.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON return OF cb_search IN FRAME fr_main
DO:
  APPLY "LEAVE" TO cb_search.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON VALUE-CHANGED OF cb_search IN FRAME fr_main
DO:
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat =  (INPUT cb_search).

    IF n_asdat = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล การค้น" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_br c-wins
ON LEAVE OF fi_br IN FRAME fr_main
DO:
  fi_br = INPUT fi_br .
  DISP fi_br WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename c-wins
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename = INPUT fi_filename.
  DISP fi_filename WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_importisp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_importisp2 c-wins
ON LEAVE OF fi_importisp2 IN FRAME fr_main
DO:
    fi_importisp2 = INPUT  fi_importisp2 .
    DISP fi_importisp2 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name c-wins
ON LEAVE OF fi_name IN FRAME fr_main
DO:
  /*fi_polfr  =  Input  fi_polfr.
  Disp  fi_polfr  with frame  fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile c-wins
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output c-wins
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.
  DISP fi_output WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output2 c-wins
ON LEAVE OF fi_output2 IN FRAME fr_main
DO:
  fi_output2 = INPUT fi_output2.
  DISP fi_output2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    DEF VAR  nv_sort   as  int  init 0.
    ASSIGN
        fi_search     =  Input  fi_search.
    /*comment by Kridtiya i. A55-0184...
    Disp fi_search  with frame fr_main.
    /*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*//*kridtiya i. A54-0216 ...*/
    If  ra_choice =  1  Then do:              /* name  */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat  >=  fi_trndatfr And
            tlt.trndat  <=  fi_trndatto And
           /* tlt.policy  >=  fi_polfr    And
            tlt.policy  <=  fi_polto    And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "Tisco"     And
            index(tlt.ins_name,fi_search) <> 0   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  2  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto And
            /*/*kridtiya i. A54-0216 ...*/
            tlt.policy   >=  fi_polfr     And
            tlt.policy   <=  fi_polto     And /*kridtiya i. A54-0216 ...*/*/
            /*tlt.policy   >=  fi_polfr     AND  /*kridtiya i. A54-0216 ...*/
            tlt.policy   <=  fi_polto     AND  /*kridtiya i. A54-0216 ...*/*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr    =  "Tisco"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  ra_choice  =  3  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr  And
            tlt.trndat <=  fi_trndatto And
            /*tlt.policy >=  fi_polfr      And
            tlt.policy <=  fi_polto     And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "Tisco"   And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0 
            /*tlt.cha_no  >=  fi_search ) */   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  4  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            /*tlt.policy >=  fi_polfr      And
            tlt.policy <=  fi_polto        And*/
            /*tlt.comp_sub  =  fi_producer And*/
            tlt.genusr   =  "Tisco"        And
            INDEX(tlt.releas,"yes") <> 0   no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  5  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01   Where
            tlt.trndat >=  fi_trndatfr      And
            tlt.trndat <=  fi_trndatto      And
            /*tlt.policy >=  fi_polfr       And
            tlt.policy <=  fi_polto         And*/
            /*tlt.comp_sub  =  fi_producer  And*/
            tlt.genusr   =  "Tisco"         And
            INDEX(tlt.releas,"no") <> 0     no-lock.
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  ra_choice  =  6  Then do:    /* cancel */
      /*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
      Open Query br_tlt 
          For each tlt Use-index  tlt01 Where
          tlt.trndat  >=  fi_trndatfr   And
          tlt.trndat  <=  fi_trndatto   And
          /*tlt.policy  >=  fi_polfr      And
          tlt.policy  <=  fi_polto      And*/
          /*   tlt.comp_sub  =  fi_producer  And*/
          tlt.genusr   =  "Tisco"      And
          index(tlt.releas,"cancel") > 0     no-lock.
              Apply "Entry"  to br_tlt.
              Return no-apply.                             
      END.
      Else  do:
          Apply "Entry"  to  fi_search.
          Return no-apply.
      END. 
      end.......comment by Kridtiya i. A55-0184*/
    /*add A55-0184 */
    Disp fi_search  with frame fr_main.
    /* A65-0035*/
    IF  cb_search = "เลขรับแจ้ง"  THEN DO:
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "Tisco"            And
            INDEX(tlt.nor_noti_tlt,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.  
    END.
    /* end : A65-0035 */
    IF  cb_search = "เลขที่สัญญา"  THEN DO:   /*---------A66-0046*/
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01      Where                                     
            tlt.trndat  >=  fi_trndatfr        And                                            
            tlt.trndat  <=  fi_trndatto        And  
            tlt.genusr   =  "Tisco"            And
            INDEX(tlt.safe2,fi_search) <> 0 no-lock.  
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.  
    END.  /*---------------------------------------------A66-0046*/
    ELSE If  cb_search = "ชื่อลูกค้า"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr         And                                            
            tlt.trndat  <=  fi_trndatto         And  
            tlt.genusr   =  "Tisco"             And
            index(tlt.ins_name,fi_search) <> 0  no-lock.      
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "กรมธรรม์ใหม่"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "กรมธรรม์เก่า"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ป้ายแดง"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "Tisco"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "ต่ออายุ"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr            And 
            tlt.trndat   <=  fi_trndatto            And 
            tlt.genusr    =  "Tisco"                And 
            tlt.flag      =  "R"                    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  = "เลขตัวถัง"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat >=  fi_trndatfr              And 
            tlt.trndat <=  fi_trndatto              AND 
            tlt.genusr   =  "Tisco"                 And 
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.
    ELSE If  cb_search  = "ทะเบียนรถ"  Then do:   /*- add Kridtiya i. A66-0046*/
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "Tisco"       And
            INDEX(tlt.lince1,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.  /*------------------------------------------add Kridtiya i. A66-0046*/
    ELSE If  cb_search  =  "Confirm_yes"  Then do:  /* Confirm yes..*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01  Where    
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "Tisco"                 And 
            INDEX(tlt.releas,"yes") <> 0            no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.            
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_no"  Then do:    /* confirm no...*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01   Where   
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "Tisco"                 And 
            INDEX(tlt.releas,"no") <> 0             no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .       /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Tisco"        And
            index(tlt.releas,"cancel") > 0 no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "สาขา"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "Tisco"        And
            tlt.EXP      =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .             /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.
    /*A55-0184*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr c-wins
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
  fi_trndatfr  =  Input  fi_trndatfr.
  If  fi_trndatto  =  ?  Then  fi_trndatto  =  fi_trndatfr.
  Disp fi_trndatfr  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto c-wins
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
  If  Input  fi_trndatto  <  fi_trndatfr  Then  fi_trndatto  =  fi_trndatfr.
  Else  fi_trndatto =  Input  fi_trndatto  .
  Disp  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_yearisp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_yearisp c-wins
ON LEAVE OF fi_yearisp IN FRAME fr_main /* Year ISP */
DO:
  fi_yearisp = INPUT fi_yearisp.
  DISP fi_yearisp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_insp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_insp c-wins
ON VALUE-CHANGED OF ra_insp IN FRAME fr_main
DO:

  ra_insp = INPUT ra_insp.
  DISP ra_insp WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status c-wins
ON VALUE-CHANGED OF ra_status IN FRAME fr_main
DO:
  ra_status = INPUT ra_status.
  DISP ra_status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-wins 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  
  
     /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  gv_prgid = "wgwqtis0".
  gv_prog  = "Query & Update  Detail  (Tisco  co.,ltd.) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
     /*ra_choice   =  1 */ /*A55-0184*/
      /*fi_polfr    = "0"
      fi_polto    = "Z" */   
      vAcProc_fil = vAcProc_fil   + "เลขรับแจ้ง"    + ","     /*A65-0035*/
                                  + "เลขที่สัญญา"   + ","   /*A66-0046*/
                                  + "ชื่อลูกค้า"    + "," 
                                  + "กรมธรรม์ใหม่"  + "," 
                                  + "กรมธรรม์เก่า"  + "," 
                                  + "ป้ายแดง"       + ","
                                  + "ต่ออายุ"       + "," 
                                  + "เลขตัวถัง"     + "," 
                                  + "ทะเบียนรถ"     + ","   /*A66-0046*/
                                  + "Confirm_yes"   + "," 
                                  + "Confirm_No"    + "," 
                                  + "Status_cancel" + ","
                                  + "สาขา"          + ","
                                  + "รถไฟฟ้า(EV)"   + ","  
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil1 = vAcProc_fil1 
                                  + "All"  + ","
                                  + "New" + "," 
                                  + "Renew" + "," 
                                  + "สาขา" + "," 
                                  + "Confirm_yes"     + "," 
                                  + "Confirm_No" + "," 
                                  + "Status_cancel"  + ","
        cb_report:LIST-ITEMS = vAcProc_fil1
        cb_report = ENTRY(1,vAcProc_fil1)
      ra_status = 4  
      ra_insp   = 1
      fi_outfile = "c:\tisco" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" .
  fi_yearisp = string(YEAR(TODAY),"9999").
  /* add by: kridtiya i. A54-0061.. *//*
  FOR EACH brstat.tlt WHERE 
      brstat.tlt.genusr    = "tisco" AND
      brstat.tlt.rec_addr5 = ""      AND 
      brstat.tlt.ins_name  = "" .
      DELETE brstat.tlt.
  END. */   /* add by: kridtiya i. A54-0061.. */
  Disp fi_trndatfr  fi_trndatto cb_search cb_report ra_status fi_outfile fi_yearisp ra_insp
      /*fi_polfr 
      fi_polto*/  with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  
  Rect-333:Move-to-top().
  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_reportfiel c-wins 
PROCEDURE 00-pd_reportfiel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A67-0114...
DEF VAR n_addr1     AS CHAR FORMAT "x(150)" INIT "".
DEF VAR n_addr2     AS CHAR FORMAT "x(50)" INIT "".
DEF VAR n_addr3     AS CHAR FORMAT "x(50)" INIT "".
DEF VAR n_addr4     AS CHAR FORMAT "x(50)" INIT "".
DEF VAR n_remak3    AS CHAR FORMAT "x(255)" INIT "".
DEF VAR nnidbr72    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid72      AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nnidbr70    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid70      AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nv_chaidrep AS CHAR FORMAT "x(100)" INIT "".  
/**/
DEF VAR nv_Rec          AS CHAR FORMAT "x(300)" INIT "".   /* start A63-0210 */
DEF VAR nv_remark       AS CHAR FORMAT "x(300)" INIT "".  
DEF VAR nv_Rec_name72   AS CHAR FORMAT "x(150)" INIT "".
DEF VAR nv_Rec_add1     AS CHAR FORMAT "x(60)"  INIT "".   /* end A63-0210 */

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
/*ASSIGN nv_cnt =  0
    nv_row  =  1.*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ." 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "Processing Office "         
    "CMR  code"                  
    "Insur.comp "                
    "notify number"              
    "Caryear "                   
    "Engine "                    
    "Chassis  "                  
    "Weight"                     
    "Power"                      
    "Color "                     
    "licence no"                 
    "garage "                    
    "fleet disc. "               
    "ncb disc. "                 
    "other disc. "               
    /*"vehuse " */ /*A60-0118*/ 
    "inspection no. "  /*A60-0118*/ 
    "comdat  "                   
    "sum si "                    
    "รหัสเจ้าหน้าที่แจ้งประกัน " 
    "ชื่อเจ้าหน้าที่ประกัน  "    
    "วันที่แจ้งประกัน  "         
    "เวลาแจ้งประกัน "            
    "รหัสแจ้งงาน"                
    "prem.1"                     
    "comp.prm "                  
    "sticker "                   
    "brand "                     
    "address1"             
    "address2"             
    /*"address3" */  /*A60-0118*/            
    /*"address4" */  /*A60-0118*/            
    "title name  "         
    "first name "          
    "beneficiary "         
    "remark. "             
    "account no. "         
    "client No. "          
    "expiry date "         
    "insurance amt.  "     
    "province "            
    "receipt name  "        
    "agent code "                   
    "บริษัทประกันภัยเดิม "          
    "กรมธรรม์ต่ออายุ"            
    "ชื่อผู้ขับขี่1"                                  
    "วันเกิด1"                                        
    "ชื่อผู้ขับขี่2"                                  
    "วันเกิด2"                                        
    "deduct disc.  "               
    "สาขา"                         
    "แพคเกจ"
    "จำนวนที่นั่ง"
    "ความเสียหายต่อคน"             
    "ความเสียหายต่อครั้ง"          
    "ความเสียหายต่อทรัพย์สิน"   
    "ประเภทความคุ้มครอง" 
    "Producer"  
    "Agent"     
    "ประเภทกรมธรรม์"
    "Confirm"
    "Receipt ID. Number"        
    "Receipt Branch NAME"
    "Receipt Comp ID. Number"   
    "Receipt Comp Branch Name"
    "วันที่คุ้มครอง พรบ. "
    "วันที่สิ้นสุดความคุ้มครอง พรบ."
    "ทุนสูญหายและไฟไหม้"
    "รหัสรถ"
    "การใช้รถ"
    "Receipt72"           /*- A59-0178 -*/  
    ""                                  /* start A63-0210*/
    ""
    "Remark"                     
    "ชื่อที่ใช้บนใบเสร็จ(พรบ.)" 
    "ที่อยู่ที่ใช้บนใบเสร็จ(พรบ.)1"     /* end A63-0210*/
    . 

loop_tlt:
For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat   >=  fi_trndatfr   And
            brstat.tlt.trndat   <=  fi_trndatto   And
            brstat.tlt.genusr    =  "Tisco"       no-lock. 
    IF cb_report = "New" THEN DO:                                              
        IF brstat.tlt.flag      =  "R"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "Renew"  THEN DO:
        IF brstat.tlt.flag      =  "N"  THEN NEXT.
    END.
    ELSE IF cb_report = "สาขา" THEN DO:
        IF brstat.tlt.EXP    <> fi_br  THEN NEXT.
    END.
    ELSE IF cb_report = "Confirm_yes" THEN DO:
        IF INDEX(brstat.tlt.releas,"yes") = 0 THEN NEXT.
    END.
    ELSE IF cb_report = "Confirm_No" THEN DO:
        IF INDEX(brstat.tlt.releas,"no") = 0 THEN NEXT.
    END.
    ELSE IF cb_report =   "Status_cancel"   THEN DO:
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    IF (fi_br <> "") THEN DO:
        IF fi_br <> brstat.tlt.EXP THEN NEXT loop_tlt.
    END.
    IF      ra_status = 1 THEN DO: 
        IF INDEX(brstat.tlt.releas,"yes") = 0    THEN NEXT.
    END.
    ELSE IF ra_status = 2 THEN DO: 
        IF INDEX(brstat.tlt.releas,"no") = 0     THEN NEXT.
    END.
    ELSE IF ra_status = 3 THEN DO: 
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    ASSIGN n_addr1       = ""
           n_addr2       = ""
           n_addr3       = ""
           n_addr4       = ""
           nnidbr72      = "" 
           nnid72        = ""
           nnidbr70      = ""
           nnid70        = ""
           nv_chaidrep   = tlt.comp_usr_tlt 
           nv_remark     = trim(brstat.tlt.filler2)
           nv_Rec        = brstat.tlt.comp_usr_ins
        .
    ASSIGN 
        nnidbr72       = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72br:") + 7 ))   /*A57-0262*/
        nv_chaidrep    = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72br:") - 1 ))  /*A57-0262*/ 
        nnid72         = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                                                           /*A57-0262*/  
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72:") + 5 ))      /*A57-0262*/
        nv_chaidrep    = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                 /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72:") - 1 ))    /*A57-0262*/
        nnidbr70       = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE 
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70br:") + 7 ))    /*A57-0262*/ 
        nv_chaidrep    = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE               /*A57-0262*/
                         trim( SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID70br:") - 1 )) /*A57-0262*/
        nnid70         = IF index(nv_chaidrep,"ID70:") = 0 THEN "" ELSE                 
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70:") + 5 ))      /*A57-0262*/ 

        nv_remark      = IF index(nv_remark,"//") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_remark,index(nv_remark,"//") + 2 ))   /*A57-0262*/
        nv_remark      = REPLACE(nv_remark,"//","")                                  /* start A63-0210*/  
        nv_remark      = REPLACE(nv_remark,"r2:","")                                  /* start A63-0210*/  
        nv_remark      = REPLACE(nv_remark,"r3:","")                                  
        nv_remark      = REPLACE(nv_remark,"r4:","")                                
        nv_Rec_name72  = SUBSTR(nv_Rec,1,INDEX(nv_Rec,"a1:") - 1 )                               
        nv_Rec_add1    = SUBSTR(nv_Rec,INDEX(nv_Rec,"a1:") + 3 )                                 
        nv_Rec_add1    = REPLACE(nv_Rec_add1,"a2:","")                                /* end A63-0210*/                       
        .                                                                               
    /*- A59-0178  Receipt Name v72 -*/
    IF INDEX(n_remak3,"ดีลเลอร์แถมพ") <> 0 THEN                           /* ดีลเลอร์ */
       nv_72Reciept =  SUBSTR(n_remak3,R-INDEX(n_remak3,"/") + 1 ,R-Index(n_remak3,"/")).

    ELSE IF INDEX(n_remak3,"ประกันแถมพ") <> 0 THEN                        /* ประกัน */
       nv_72Reciept =  "บริษัทประกันคุ้มภัย จำกัด (มหาชน)".

    ELSE IF INDEX(n_remak3,"พ.ร.บ.ลูกค้าจ่าย") <> 0 THEN                       /* ลูกค้า */
       nv_72Reciept =  tlt.ins_name .

    ELSE IF INDEX(n_remak3,"ทิสโก้แถมเบี้ยและพ") <> 0 THEN                /* ทิสโก้ เบี้ย/พ.ร.บ.  */
       nv_72Reciept =  "ธนาคารทิสโก้ จำกัด (มหาชน) ".

    ELSE IF INDEX(n_remak3,"ลูกค้าจ่ายเบี้ยและพ") <> 0 THEN               /* ลูกค้า เบี้ย/พ.ร.บ. */
       nv_72Reciept =  tlt.ins_name .

    ELSE IF INDEX(n_remak3,"ดีลเลอร์แถมเบี้ยและพ") <> 0 THEN               /* ดีลเลอร์ เบี้ย/พ.ร.บ. */
       nv_72Reciept =  tlt.ins_name .

    ELSE nv_72Reciept = " ".
    /*--- end : A59-0178--*/
    
    IF tlt.ins_addr3 = "" THEN ASSIGN  n_addr1 = trim(tlt.ins_addr1) + " " + trim(tlt.ins_addr2).
    ELSE ASSIGN n_addr1 = trim(tlt.ins_addr3). 
    IF INDEX(n_addr1,"จ.") <> 0 THEN 
        ASSIGN  n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"จ."))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"จ.") - 1 ).
    ELSE IF  INDEX(n_addr1,"จังหวัด") <> 0 THEN 
        ASSIGN n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"จังหวัด"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"จังหวัด") - 1 ).
    ELSE IF INDEX(n_addr1,"กรุงเทพ") <> 0 THEN 
        ASSIGN n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"กรุงเทพ"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"กรุงเทพ") - 1 ).
    ELSE IF INDEX(n_addr1,"กทม") <> 0 THEN 
        ASSIGN n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"กทม"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"กทม") - 1 ).
    ELSE n_addr4 = "".
    IF INDEX(n_addr1,"เขต") <> 0 THEN 
        ASSIGN n_addr3 = SUBSTR(n_addr1,INDEX(n_addr1,"เขต"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"เขต") - 1 ).
    ELSE IF INDEX(n_addr1,"อ.") <> 0 THEN 
        ASSIGN n_addr3 = SUBSTR(n_addr1,INDEX(n_addr1,"อ."))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"อ.") - 1 ).
    ELSE IF INDEX(n_addr1,"อำเภอ") <> 0 THEN 
        ASSIGN n_addr3 = SUBSTR(n_addr1,INDEX(n_addr1,"อำเภอ"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"อำเภอ") - 1 ).
    IF INDEX(n_addr1,"แขวง") <> 0 THEN 
        ASSIGN n_addr2 = SUBSTR(n_addr1,INDEX(n_addr1,"แขวง"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"แขวง") - 1 ). 
    ELSE IF INDEX(n_addr1,"ต.") <> 0 THEN 
        ASSIGN n_addr2 = SUBSTR(n_addr1,INDEX(n_addr1,"ต."))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"ต.") - 1 ).
    ELSE IF INDEX(n_addr1,"ตำบล") <> 0 THEN 
        ASSIGN n_addr2 = SUBSTR(n_addr1,INDEX(n_addr1,"ตำบล"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"ตำบล") - 1 ).


    
    EXPORT DELIMITER "|" 
            trim(tlt.rec_addr3)    
            trim(tlt.rec_addr4)    
            trim(tlt.subins)       
            TRIM(tlt.nor_noti_tlt)
            trim(tlt.lince2)           
            trim(tlt.eng_no)           
            trim(tlt.cha_no)                   
            trim(string(tlt.cc_weight))                
            trim(string(tlt.rencnt))                   
            trim(tlt.colorcod)                         
            trim(tlt.lince1)           
            trim(tlt.stat)                              
            trim(string(tlt.lotno))                     
            trim(string(tlt.seqno))                     
            trim(string(tlt.endcnt))                    
            /*trim(substr(tlt.model,1,3)) */ /*A60-0118*/  
            trim(substr(tlt.model,1,50))  /*A60-0118*/  
            trim(string(tlt.gendat))                     
            trim(string(tlt.nor_coamt))                 
            trim(tlt.nor_usr_ins)                     
            trim(tlt.nor_usr_tlt)                     
            trim(string(tlt.entdat))                 
            trim(string(tlt.enttim))                  
            trim(string(tlt.comp_usr_tlt))            
            trim(string(tlt.nor_grprm))               
            trim(string(tlt.comp_grprm))              
            trim(tlt.comp_sck)                      
            trim(tlt.brand)                           
            n_addr1
            n_addr2
            n_addr3
            n_addr4
            IF index(trim(tlt.ins_name)," ") <> 0 THEN SUBSTR(tlt.ins_name,1,INDEX(TRIM(tlt.ins_name)," ")) ELSE tlt.ins_name             
            IF R-INDEX(trim(tlt.ins_name)," ") <> 0 THEN SUBSTR(tlt.ins_name,R-INDEX(TRIM(tlt.ins_name)," ")) ELSE tlt.ins_name            
            trim(tlt.safe1)                             
            /*trim(tlt.filler2)*//*add A56-0323*/
            TRIM(n_remak3)    /*add A56-0323*/
            trim(tlt.safe2)                              
            trim(tlt.safe3)                              
            trim(string(tlt.expodat))                     
            trim(string(tlt.comp_coamt))  
            tlt.lince3
            tlt.rec_addr1
            trim(tlt.recac)                          
            trim(tlt.rec_addr2)                
            replace(trim(tlt.rec_addr5),"*","")
            tlt.dri_name1                      
            Substr(dri_no1,1,Index(dri_no1," ") - 1)    /*- วันเดือนปีเกิด */                       
            tlt.dri_name2                      
            Substr(dri_no2,1,Index(dri_no2," ") - 1)    /*- วันเดือนปีเกิด */                       
            trim(tlt.endno)                    
            trim(tlt.EXP)                      
            TRIM(Substr(tlt.expotim,1,Index(tlt.expotim," ") - 1))   
            tlt.sentcnt
            trim(tlt.old_eng)                  
            trim(tlt.old_cha)                  
            trim(tlt.comp_pol)                 
            trim(substr(tlt.expousr,1,3))                  
            trim(tlt.comp_sub)                 
            trim(tlt.comp_noti_ins)           
            IF tlt.flag = "n" THEN "NEW" ELSE "RENEW"   
            tlt.releas   /*A57-0242*/                               
            nnid70       /*A57-0242*/                                     
            nnidbr70     /*A57-0242*/                                   
            nnid72       /*A57-0242*/                                  
            nnidbr72     /*A57-0242*/     
            IF STRING(tlt.nor_effdat) = ? THEN "" ELSE STRING(tlt.nor_effdat) /*- "วันที่คุ้มครอง พรบ. " -*/
            IF STRING(tlt.comp_effdat) = ? THEN "" ELSE STRING(tlt.comp_effdat)             /*- "วันที่สิ้นสุดความคุ้มครอง พรบ."    -*/                  
            /*TRIM(SUBSTR(tlt.model,51,10))*/              /*-"ทุนสูญหายและไฟไหม้" -*/ /*A60-0118*/
            TRIM(SUBSTR(tlt.model,51,15))              /*-"ทุนสูญหายและไฟไหม้" -*/ /*A60-0118*/
            TRIM(SUBSTR(tlt.expotim,6,3))              /*-"รหัสรถ"-*/
            TRIM(SUBSTR(tlt.expousr ,7,3))             /*-"การใช้รถ"-*/                             
            nv_72Reciept                     /* start A63-0210*/  
            nv_remark    
            nv_Rec_name72
            nv_Rec_add1  .                   /* end A63-0210*/              
END.         /*- A59-0178 -*/                              
                                             
OUTPUT   CLOSE.                            
 ...end A67-0114...*/                                          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-wins  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
  THEN DELETE WIDGET c-wins.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-wins  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY ra_insp fi_importisp2 fi_output2 fi_yearisp fi_output ra_status 
          fi_trndatfr fi_trndatto cb_search fi_search fi_name cb_report fi_br 
          fi_outfile fi_filename 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE ra_insp bu_match2 fi_importisp2 fi_output2 fi_yearisp bu_match 
         fi_output ra_status fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch 
         br_tlt fi_search bu_update cb_report fi_br fi_outfile bu_report 
         bu_exit bu_upyesno fi_filename bu_file bu_file-2 RECT-333 RECT-338 
         RECT-339 RECT-340 RECT-381 RECT-383 RECT-334 RECT-335 RECT-336 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_data_reportnew c-wins 
PROCEDURE pd_data_reportnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail NO-LOCK.
    IF length(trim(wdetail.province)) <> 2 AND trim(wdetail.province) <> "" THEN RUN proc_province.
    nv_row  =  nv_row + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' wdetail.pro_off   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail.cmr_code  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail.comp_code '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail.notify_no '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail.yrmanu    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail.engine    FORMAT "x(50)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail.chassis   FORMAT "x(50)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail.weight    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail.power     FORMAT "x(5)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.colorcode '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.licence   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.garage    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.fleetper    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.ncbper      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.othper      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.isp    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail.comdat FORMAT "x(15)"     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail.ins_amt         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.name_insur '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.not_office '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail.not_date FORMAT "x(15)"   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail.not_time FORMAT "x(15)"   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.not_code   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail.prem1                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' wdetail.comp_prm             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.sckno      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.brand      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.pol_addr1  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.pol_addr2  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' wdetail.pol_title  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' wdetail.pol_fname  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' wdetail.pol_lname  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' wdetail.ben_name   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' wdetail.remark     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' wdetail.account_no FORMAT "x(10)"  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' wdetail.client_no  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' wdetail.expdat FORMAT "x(15)"         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' wdetail.gross_prm               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' wdetail.province   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' wdetail.receipt_name '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' wdetail.agent        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' wdetail.prev_insur   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' wdetail.prev_pol     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' wdetail.deduct       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' wdetail.addr1_70     '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' wdetail.addr2_70     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' wdetail.nsub_dist70  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' wdetail.ndirection70 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' wdetail.nprovin70    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' wdetail.zipcode70    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' wdetail.addr1_72     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' wdetail.addr2_72     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' wdetail.nsub_dist72  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' wdetail.ndirection72 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' wdetail.nprovin72    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' wdetail.zipcode72    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' wdetail.apptyp       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' wdetail.appcode      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' wdetail.nBLANK1       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' wdetail.pack       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' wdetail.seatenew   '"' SKIP.   /*Add A57-0017*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' wdetail.tp1  '"' skip. /*a60-0095*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' wdetail.tp2  '"' skip. /*a60-0095*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' wdetail.tp3  '"' skip. /*a60-0095*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' wdetail.covcod     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' wdetail.producer    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' wdetail.agent       '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' wdetail.branch     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' wdetail.NEW_re     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x70;K"  '"' wdetail.redbook      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x71;K"  '"' wdetail.price_ford   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x72;K"  '"' wdetail.yrmanu       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x73;K"  '"' wdetail.brand_model        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x74;K"  '"' wdetail.id_no70  '"' SKIP.  /*A57-0262*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x75;K"  '"' wdetail.id_nobr70  '"' SKIP.  /*A57-0262*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x76;K"  '"' wdetail.id_no72  '"' SKIP.  /*A57-0262*/   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x77;K"  '"' wdetail.id_nobr72  '"' SKIP.  /*A57-0262*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' wdetail.comp_comdat  format "x(15)"     '"' SKIP.    /* A59-0178*/             
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' wdetail.comp_expdat  format "x(15)"     '"' SKIP.    /* A59-0178*/                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' wdetail.fi                     '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' wdetail.class         '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' wdetail.usedtype      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' wdetail.driveno1      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' wdetail.drivename1    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' wdetail.bdatedriv1 FORMAT "x(15)"    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' wdetail.occupdriv1    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' wdetail.positdriv1    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' wdetail.driveno2      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' wdetail.drivename2    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' wdetail.bdatedriv2 FORMAT "x(15)"    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' wdetail.occupdriv2    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' wdetail.positdriv2    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' wdetail.driveno3      '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' wdetail.drivename3    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' wdetail.bdatedriv3 FORMAT "x(15)"    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' wdetail.occupdriv3    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' wdetail.positdriv3    '"' SKIP.    /* A59-0178*/                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x98;K"  '"' wdetail.nBLANK2       '"' SKIP.  /*  84  Blank */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K"  '"' wdetail.receipt72     '"' SKIP.  /*  85  72Reciept */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x100;K" '"' wdetail.caracc        '"' SKIP.  /*Car Accessories*/                 /* start : A63-0210*/    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x101;K" '"' wdetail.Rec_name72    '"' SKIP.  /*Accidential Receipt name*/                                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x102;K" '"' wdetail.Rec_add1      '"' SKIP.  /*Accidential Receipt Address 1*/                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x103;K" '"' wdetail.Rec_add2      '"' SKIP.  /*Accidential Receipt Address 2*/   /* end : A63-0210*/      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x104;K" '"' wdetail.remakuppol    '"' SKIP.  /*Add A65-0364 */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x105;K" '"' wdetail.policyno      '"' SKIP.  /*Add A65-0364 */
    /* A67-0087 */                                        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x106;K" '"' wdetail.Schanel       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x107;K" '"' wdetail.bev           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x108;K" '"' wdetail.driveno4      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x109;K" '"' wdetail.drivename4    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x110;K" '"' wdetail.bdatedriv4 FORMAT "x(15)"    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";x111;K" '"' wdetail.occupdriv4    '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x112;K" '"' wdetail.positdriv4    '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x113;K" '"' wdetail.driveno5      '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x114;K" '"' wdetail.drivename5    '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x115;K" '"' wdetail.bdatedriv5 FORMAT "x(15)"   '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x116;K" '"' wdetail.occupdriv5    '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x117;K" '"' wdetail.positdriv5    '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x118;K" '"' wdetail.campagin      '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x119;K" '"' wdetail.inspic        '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x120;K" '"' wdetail.engcount      '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x121;K" '"' wdetail.engno2        '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x122;K" '"' wdetail.engno3        '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x123;K" '"' wdetail.engno4        '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x124;K" '"' wdetail.engno5        '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x125;K" '"' wdetail.classcomp     '"' SKIP.
    PUT STREAM ns2 "C;Y" string(nv_row) ";x126;K" '"' wdetail.carbrand      '"' SKIP.
End. /* end : A67-0087 */                                 /*  end  wdetail  */
PUT STREAM ns2 "E".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfiel c-wins 
PROCEDURE pd_reportfiel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_addr1     AS CHAR FORMAT "x(150)" INIT "".
DEF VAR n_addr2     AS CHAR FORMAT "x(50)" INIT "".
DEF VAR n_addr3     AS CHAR FORMAT "x(50)" INIT "".
DEF VAR n_addr4     AS CHAR FORMAT "x(50)" INIT "".
DEF VAR n_remak3    AS CHAR FORMAT "x(255)" INIT "".
DEF VAR nnidbr72    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid72      AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nnidbr70    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid70      AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nv_chaidrep AS CHAR FORMAT "x(100)" INIT "".  
DEF VAR nv_Rec          AS CHAR FORMAT "x(300)" INIT "".   /* start A63-0210 */
DEF VAR nv_remark       AS CHAR FORMAT "x(500)" INIT "".  
DEF VAR nv_Rec_name72   AS CHAR FORMAT "x(150)" INIT "".
DEF VAR nv_Rec_add1     AS CHAR FORMAT "x(60)"  INIT "".   /* end A63-0210 */

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ." 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "Processing Office "
    "CMR  code    "
    "Insur.comp   "
    "notify number"
    "Caryear      "
    "Engine       "
    "Chassis      "
    "Weight       "
    "Power        "
    "Color        "
    "licence no   "
    "garage       "
    "fleet disc.  "
    "ncb disc.    "
    "other disc.  "
    "inspection no. "
    "comdat " 
    "sum si "
    "รหัสเจ้าหน้าที่แจ้งประกัน "
    "ชื่อเจ้าหน้าที่ประกัน     "
    "วันที่แจ้งประกัน"  
    "เวลาแจ้งประกัน  "
    "รหัสแจ้งงาน "
    "prem.1      "
    "comp.prm    "
    "sticker     "
    "brand       "
    "address1    "
    "address2    "
    "address3    "
    "address4    "
    "title name  "
    "first name  "
    "beneficiary "
    "remark.     "
    "account no. "
    "client No.  "
    "expiry date "
    "insurance amt."  
    "province     "
    "receipt name " 
    "agent code   "
    "บริษัทประกันภัยเดิม" 
    "กรมธรรม์ต่ออายุ    "
    "ชื่อผู้ขับขี่1     "
    "วันเกิด1           "
    "อาชีพ1             "
    "เลขใบขับขี่/เลขบัตรประชาชน1"
    "ชื่อผู้ขับขี่2"
    "วันเกิด2      "
    "อาชีพ2        "
    "เลขใบขับขี่/เลขบัตรประชาชน2"
    "ชื่อผู้ขับขี่3"
    "วันเกิด3      "
    "อาชีพ3        "
    "เลขใบขับขี่/เลขบัตรประชาชน3"
    "deduct disc. " 
    "สาขา         "
    "แพคเกจ       "
    "จำนวนที่นั่ง "
    "ความเสียหายต่อคน        "
    "ความเสียหายต่อครั้ง     "
    "ความเสียหายต่อทรัพย์สิน "
    "ประเภทความคุ้มครอง      "
    "Producer"
    "Agent   "
    "ประเภทกรมธรรม์ "
    "Confirm        "
    "Receipt ID. Number      "
    "Receipt Branch NAME     "
    "Receipt Comp ID. Number "
    "Receipt Comp Branch Name"
    "วันที่คุ้มครอง พรบ.     "
    "วันที่สิ้นสุดความคุ้มครอง พรบ."
    "ทุนสูญหายและไฟไหม้"
    "รหัสรถ            "
    "การใช้รถ          "
    "Receipt72         "
    "Remark            "
    "ชื่อที่ใช้บนใบเสร็จ(พรบ.)      "
    "ที่อยู่ที่ใช้บนใบเสร็จ(พรบ.)1  "
    "accessories Y/N      "     
    "accessories coverage "     
    "accessories premium  "     
    "ตรวจสภาพรถ(Y/N)      "     
    "เลขที่อ้างอิงการเช็คเบี้ย  "   
    "TYPE OF INSURANCE    "     
    "ช่องทางการขาย        "     
    "รถยนต์ไฟฟ้า Y/N      "     
    "ชื่อผู้ขับขี่4       "     
    "วันเกิด4             "     
    "อาชีพ4               "     
    "เลขใบขับขี่/เลขบัตรประชาชน4"   
    "ชื่อผู้ขับขี่5       "     
    "วันเกิด5             "     
    "อาชีพ5               "     
    "เลขใบขับขี่/เลขบัตรประชาชน5"   
    "แคมเปญ               "     
    "ส่งรูปแทนการตรวจสภาพรถ Y/N "   
    "จำนวนเลขเครื่อง      "     
    "หมายเลขเครื่องยนต์ 2 " 
    "หมายเลขเครื่องยนต์ 3 " 
    "หมายเลขเครื่องยนต์ 4 " 
    "หมายเลขเครื่องยนต์ 5 " 
    "รหัส พ.ร.บ.          " 
    "ยี่ห้อรถ             " .

loop_tlt:
For each brstat.tlt Use-index  tlt01 Where
            brstat.tlt.trndat   >=  fi_trndatfr   And
            brstat.tlt.trndat   <=  fi_trndatto   And
            brstat.tlt.genusr    =  "Tisco"       no-lock. 
    IF cb_report = "New" THEN DO:                                              
        IF brstat.tlt.flag      =  "R"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "Renew"  THEN DO:
        IF brstat.tlt.flag      =  "N"  THEN NEXT.
    END.
    ELSE IF cb_report = "สาขา" THEN DO:
        IF brstat.tlt.EXP    <> fi_br  THEN NEXT.
    END.
    ELSE IF cb_report = "Confirm_yes" THEN DO:
        IF INDEX(brstat.tlt.releas,"yes") = 0 THEN NEXT.
    END.
    ELSE IF cb_report = "Confirm_No" THEN DO:
        IF INDEX(brstat.tlt.releas,"no") = 0 THEN NEXT.
    END.
    ELSE IF cb_report =   "Status_cancel"   THEN DO:
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    IF (fi_br <> "") THEN DO:
        IF fi_br <> brstat.tlt.EXP THEN NEXT loop_tlt.
    END.
    IF      ra_status = 1 THEN DO: 
        IF INDEX(brstat.tlt.releas,"yes") = 0    THEN NEXT.
    END.
    ELSE IF ra_status = 2 THEN DO: 
        IF INDEX(brstat.tlt.releas,"no") = 0     THEN NEXT.
    END.
    ELSE IF ra_status = 3 THEN DO: 
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    ASSIGN n_addr1       = ""
           n_addr2       = ""
           n_addr3       = ""
           n_addr4       = ""
           nnidbr72      = "" 
           nnid72        = ""
           nnidbr70      = ""
           nnid70        = ""
           nv_chaidrep   = tlt.comp_usr_tlt 
           nv_remark     = trim(brstat.tlt.filler2)
           nv_Rec        = brstat.tlt.comp_usr_ins
        .
    ASSIGN 
        nnidbr72       = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72br:") + 7 ))   /*A57-0262*/
        nv_chaidrep    = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72br:") - 1 ))  /*A57-0262*/ 
        nnid72         = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                                                           /*A57-0262*/  
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72:") + 5 ))      /*A57-0262*/
        nv_chaidrep    = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                 /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72:") - 1 ))    /*A57-0262*/
        nnidbr70       = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE 
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70br:") + 7 ))    /*A57-0262*/ 
        nv_chaidrep    = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE               /*A57-0262*/
                         trim( SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID70br:") - 1 )) /*A57-0262*/
        nnid70         = IF index(nv_chaidrep,"ID70:") = 0 THEN "" ELSE                 
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70:") + 5 ))      /*A57-0262*/ 

        nv_remark      = IF index(nv_remark,"//") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_remark,index(nv_remark,"//") + 2 ))   /*A57-0262*/
        nv_remark      = REPLACE(nv_remark,"//","")                                  /* start A63-0210*/  
        nv_remark      = REPLACE(nv_remark,"r2:","")                                  /* start A63-0210*/  
        nv_remark      = REPLACE(nv_remark,"r3:","")                                  
        nv_remark      = REPLACE(nv_remark,"r4:","")                                
        nv_Rec_name72  = SUBSTR(nv_Rec,1,INDEX(nv_Rec,"a1:") - 1 )                               
        nv_Rec_add1    = SUBSTR(nv_Rec,INDEX(nv_Rec,"a1:") + 3 )                                 
        nv_Rec_add1    = REPLACE(nv_Rec_add1,"a2:","")                                /* end A63-0210*/                       
        .                                                                               
    /*- A59-0178  Receipt Name v72 -*/
    IF INDEX(n_remak3,"ดีลเลอร์แถมพ") <> 0 THEN                           /* ดีลเลอร์ */
       nv_72Reciept =  SUBSTR(n_remak3,R-INDEX(n_remak3,"/") + 1 ,R-Index(n_remak3,"/")).

    ELSE IF INDEX(n_remak3,"ประกันแถมพ") <> 0 THEN                        /* ประกัน */
       nv_72Reciept =  "บริษัทประกันคุ้มภัย จำกัด (มหาชน)".

    ELSE IF INDEX(n_remak3,"พ.ร.บ.ลูกค้าจ่าย") <> 0 THEN                       /* ลูกค้า */
       nv_72Reciept =  tlt.ins_name .

    ELSE IF INDEX(n_remak3,"ทิสโก้แถมเบี้ยและพ") <> 0 THEN                /* ทิสโก้ เบี้ย/พ.ร.บ.  */
       nv_72Reciept =  "ธนาคารทิสโก้ จำกัด (มหาชน) ".

    ELSE IF INDEX(n_remak3,"ลูกค้าจ่ายเบี้ยและพ") <> 0 THEN               /* ลูกค้า เบี้ย/พ.ร.บ. */
       nv_72Reciept =  tlt.ins_name .

    ELSE IF INDEX(n_remak3,"ดีลเลอร์แถมเบี้ยและพ") <> 0 THEN               /* ดีลเลอร์ เบี้ย/พ.ร.บ. */
       nv_72Reciept =  tlt.ins_name .

    ELSE nv_72Reciept = " ".
    /*--- end : A59-0178--*/
    
    IF tlt.ins_addr3 = "" THEN ASSIGN  n_addr1 = trim(tlt.ins_addr1) + " " + trim(tlt.ins_addr2).
    ELSE ASSIGN n_addr1 = trim(tlt.ins_addr3). 
    IF INDEX(n_addr1,"จ.") <> 0 THEN 
        ASSIGN  n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"จ."))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"จ.") - 1 ).
    ELSE IF  INDEX(n_addr1,"จังหวัด") <> 0 THEN 
        ASSIGN n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"จังหวัด"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"จังหวัด") - 1 ).
    ELSE IF INDEX(n_addr1,"กรุงเทพ") <> 0 THEN 
        ASSIGN n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"กรุงเทพ"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"กรุงเทพ") - 1 ).
    ELSE IF INDEX(n_addr1,"กทม") <> 0 THEN 
        ASSIGN n_addr4 = SUBSTR(n_addr1,INDEX(n_addr1,"กทม"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"กทม") - 1 ).
    ELSE n_addr4 = "".
    IF INDEX(n_addr1,"เขต") <> 0 THEN 
        ASSIGN n_addr3 = SUBSTR(n_addr1,INDEX(n_addr1,"เขต"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"เขต") - 1 ).
    ELSE IF INDEX(n_addr1,"อ.") <> 0 THEN 
        ASSIGN n_addr3 = SUBSTR(n_addr1,INDEX(n_addr1,"อ."))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"อ.") - 1 ).
    ELSE IF INDEX(n_addr1,"อำเภอ") <> 0 THEN 
        ASSIGN n_addr3 = SUBSTR(n_addr1,INDEX(n_addr1,"อำเภอ"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"อำเภอ") - 1 ).
    IF INDEX(n_addr1,"แขวง") <> 0 THEN 
        ASSIGN n_addr2 = SUBSTR(n_addr1,INDEX(n_addr1,"แขวง"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"แขวง") - 1 ). 
    ELSE IF INDEX(n_addr1,"ต.") <> 0 THEN 
        ASSIGN n_addr2 = SUBSTR(n_addr1,INDEX(n_addr1,"ต."))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"ต.") - 1 ).
    ELSE IF INDEX(n_addr1,"ตำบล") <> 0 THEN 
        ASSIGN n_addr2 = SUBSTR(n_addr1,INDEX(n_addr1,"ตำบล"))
        n_addr1 = SUBSTR(n_addr1,1,INDEX(n_addr1,"ตำบล") - 1 ).
    
    EXPORT DELIMITER "|" 
       trim(tlt.rec_addr3)                          
       trim(tlt.rec_addr4)                          
       trim(tlt.subins)                             
       TRIM(tlt.nor_noti_tlt)                       
       trim(tlt.lince2)                             
       trim(tlt.eng_no)                             
       trim(tlt.cha_no)                             
       trim(string(tlt.cc_weight))                  
       trim(string(tlt.rencnt))                     
       trim(tlt.colorcod)                           
       trim(tlt.lince1)                             
       trim(tlt.stat)                               
       trim(string(tlt.lotno))                      
       trim(string(tlt.seqno))                      
       trim(string(tlt.endcnt))                     
       trim(substr(tlt.model,1,50))  
       trim(string(tlt.gendat,"99/99/9999"))                     
       trim(string(tlt.nor_coamt))                  
       trim(tlt.nor_usr_ins)                        
       trim(tlt.nor_usr_tlt)                        
       trim(string(tlt.entdat,"99/99/9999"))                     
       trim(string(tlt.enttim))                     
       trim(string(tlt.comp_usr_tlt))               
       trim(string(tlt.nor_grprm))                  
       trim(string(tlt.comp_grprm))                 
       trim(tlt.comp_sck)                           
       trim(tlt.brand)                              
       n_addr1                                      
       n_addr2                                      
       n_addr3                                      
       n_addr4                                      
       TRIM(tlt.rec_name)                           
       trim(tlt.ins_name)                           
       trim(tlt.safe1)                              
       IF brstat.tlt.filler2 <> "" AND index(brstat.tlt.filler2,"acc:") <> 0 THEN  trim(SUBSTR(brstat.tlt.filler2,1,index(brstat.tlt.filler2,"acc:") - 1))  ELSE TRIM(brstat.tlt.filler2)     
       trim(tlt.safe2)                              
       trim(tlt.safe3)                              
       trim(string(tlt.expodat,"99/99/9999"))                                         
       trim(string(tlt.comp_coamt))                                      
       tlt.lince3                                                        
       tlt.rec_addr1                                                     
       trim(tlt.recac)                                                   
       trim(tlt.rec_addr2)                                               
       replace(trim(tlt.rec_addr5),"*","")                               
       tlt.dri_name1                                                     
       Substr(dri_no1,1,Index(dri_no1," ") - 1)    
       TRIM(dir_occ1)                                                  
       IF trim(brstat.tlt.dri_lic1) <> "" OR trim(brstat.tlt.dri_ic1) <> "" THEN  trim(brstat.tlt.dri_lic1) + "/" + trim(brstat.tlt.dri_ic1) ELSE ""       
       tlt.dri_name2                                                     
       Substr(dri_no2,1,Index(dri_no2," ") - 1)    
       TRIM(dri_occ2)                                                  
       IF trim(brstat.tlt.dri_lic2) <> "" OR trim(brstat.tlt.dri_ic2) <> "" THEN trim(brstat.tlt.dri_lic2) + "/" + trim(brstat.tlt.dri_ic2)  ELSE ""      
       tlt.dri_name3                                                     
       Substr(dri_no3,1,Index(dri_no3," ") - 1)    
       TRIM(dir_occ3)                                                  
       IF trim(brstat.tlt.dri_lic3) <> "" OR trim(brstat.tlt.dri_ic3) <> "" THEN trim(brstat.tlt.dri_lic3) + "/" + trim(brstat.tlt.dri_ic3)  ELSE ""       
       trim(tlt.endno)                    
       trim(tlt.EXP)                      
       TRIM(Substr(tlt.expotim,1,Index(tlt.expotim," ") - 1))   
       tlt.sentcnt
       trim(tlt.old_eng)                  
       trim(tlt.old_cha)                  
       trim(tlt.comp_pol)                 
       trim(substr(tlt.expousr,1,3))                  
       trim(tlt.comp_sub)                 
       trim(tlt.comp_noti_ins)           
       IF tlt.flag = "n" THEN "NEW" ELSE "RENEW"   
       tlt.releas                           
       nnid70                                     
       nnidbr70                                 
       nnid72                                  
       nnidbr72    
       IF STRING(tlt.nor_effdat) = ? THEN "" ELSE STRING(tlt.nor_effdat,"99/99/9999") 
       IF STRING(tlt.comp_effdat) = ? THEN "" ELSE STRING(tlt.comp_effdat,"99/99/9999")                          
       TRIM(SUBSTR(tlt.model,51,15))      
       TRIM(SUBSTR(tlt.expotim,6,3))      
       TRIM(SUBSTR(tlt.expousr ,7,3))       
       nv_72Reciept                       
       IF brstat.tlt.filler2 <> "" AND index(brstat.tlt.filler2,"acc:") <> 0 THEN  trim(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"acc:") + 4 ))  ELSE "" 
       nv_Rec_name72
       nv_Rec_add1
       trim(tlt.note1)
       trim(tlt.note2) 
       trim(tlt.note3) 
       trim(tlt.note4) 
       trim(tlt.note5) 
       trim(tlt.covcod)
       trim(tlt.note7)
       trim(tlt.note8)  
       tlt.dri_name4                                                     
       Substr(dri_no4,1,Index(dri_no4," ") - 1)   
       TRIM(dri_occ4)                                                  
       IF trim(brstat.tlt.dri_lic4) <> "" OR trim(brstat.tlt.dri_ic4) <> "" THEN trim(brstat.tlt.dri_lic4) + "/" + trim(brstat.tlt.dri_ic4) ELSE ""
       tlt.dri_name5                                                     
       Substr(dri_no5,1,Index(dri_no5," ") - 1)  
       TRIM(dri_occ5)                                                  
       IF trim(brstat.tlt.dri_lic5) <> "" OR trim(brstat.tlt.dri_ic5) <> "" THEN trim(brstat.tlt.dri_lic5) + "/" + trim(brstat.tlt.dri_ic5) ELSE ""
       trim(tlt.campaign)
       trim(tlt.ispflg)
       INTE(tlt.ndeci1)    
       trim(tlt.eng_no2)   
       trim(tlt.note9 )    
       trim(tlt.note10)    
       trim(tlt.note11)    
       trim(tlt.subclass)  
       trim(tlt.car_type)  .

END.                               
                                             
OUTPUT   CLOSE.                            
                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportisp c-wins 
PROCEDURE pd_reportisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_row  =  0.
nv_row  =  nv_row + 1.
If  substr(fi_output2,length(fi_output2) - 3,4) <>  ".slk"  THEN fi_output2  =  Trim(fi_output2) + ".slk"  .
OUTPUT STREAM ns2 TO VALUE(fi_output2).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' STRING(TODAY,"99/99/9999")  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "TISCO_CODE"               '"' SKIP.          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "เลขที่สัญญา"         '"' SKIP.           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่แจ้งงาน"       '"' SKIP.      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "วันเริ่มคุ้มครอง"    '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "บริษัทประกันภัย"     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "ชื่อผู้เอาประกัน"    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "หมายเลขทะเบียน"      '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "จังหวัดจดทะเบียน"    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "หมายเหตุ"            '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "สถานะความคืบหน้า"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "รหัสบริษัทประกันภัย" '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "NCB"                 '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "YEAR_PRODUCT"        '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "เลขถัง"              '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "เลขกรมธรรม์"         '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "InspectionNo"        '"' SKIP.                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "InspectionResult"    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "InspectionDamage"    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "InspectionResult2"   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "InspectionDamage2"   '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "อุปกรณ์เสริม"        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "อุปกรณ์กันขโมย"      '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "อุปกรณ์อื่นๆ"        '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "สาขา"                '"' SKIP.  

FOR EACH wdetail2 NO-LOCK.
    nv_row  =  nv_row + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' wdetail2.TISCO_CODE         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail2.contract           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail2.notidate           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail2.comdate            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail2.comname            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail2.insname            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail2.vehreg             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail2.province           '"' SKIP. 
    /*
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail2.remark             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail2.status_detail      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail2.comcode            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail2.ncb                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail2.yearproduct        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail2.nvpolicy           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail2.nvchassis          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail2.InspectionNo       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail2.InspectionResult   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail2.InspectionDamage   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail2.InspectionResult2  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail2.InspectionDamage2  '"' SKIP.
    
    */
    /*
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail2.nvchassis         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail2.resulte           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail2.receivedate       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail2.status_detail     '"' SKIP.*/

    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail2.remark            '"' SKIP.           
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail2.status_detail     '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail2.comcode           '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail2.ncb               '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail2.yearproduct       '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail2.nvchassis         '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail2.nvpolicy          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail2.InspectionNo      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail2.InspectionResult  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail2.InspectionDamage  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail2.InspectionResult2 '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail2.InspectionDamage2 '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail2.accessories       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail2.antitheftdevice   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail2.anotherdevice     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail2.branchdespinsp    '"' SKIP.    /*A67-0035*/
     
End.   /*  end  wdetail  */

nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "หมายเหตุ  :  ระดับความเสียหาย"           '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     A - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวไม่เกิน 6 นิ้ว หรือเสียหายไม่เกิน 10% ของเนื้อที่ทั้งหมด"            '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     B - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวไม่เกิน 18 นิ้ว หรือเสียหายไม่เกิน 30% ของเนื้อที่ทั้งหมด"            '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     C - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวเกิน 18 นิ้ว หรือเสียหายเกิน 30% ของเนื้อที่ทั้งหมด"           '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     D - ต้องประกอบ เคาะ พ่นสี หรือเปลี่ยนอะไหล่ไปเลย (ไม่สามารถซ่อมได้)"           '"' SKIP.


PUT STREAM ns2 "E".

OUTPUT STREAM ns2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportisp1 c-wins 
PROCEDURE pd_reportisp1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

nv_row  =  0.
nv_row  =  nv_row + 1.
If  substr(fi_output2,length(fi_output2) - 3,4) <>  ".slk"  THEN fi_output2  =  Trim(fi_output2) + ".slk"  .
OUTPUT STREAM ns2 TO VALUE(fi_output2).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' STRING(TODAY,"99/99/9999")  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "TISCO"               '"' SKIP.  /*TISCO_CODE           */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "เลขที่สัญญา"         '"' SKIP.  /*เลขที่สัญญา          */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "วันที่แจ้งงาน"       '"' SKIP.  /*วันที่แจ้งงาน        */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "วันเริ่มคุ้มครอง"    '"' SKIP.  /*วันเริ่มคุ้มครอง     */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "บริษัทประกันภัย"     '"' SKIP.  /*บริษัทประกันภัย      */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "ชื่อผู้เอาประกัน"    '"' SKIP.  /*ชื่อผู้เอาประกัน     */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "หมายเลขทะเบียน"      '"' SKIP.  /*หมายเลขทะเบียน       */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "จังหวัดจดทะเบียน"    '"' SKIP.  /*จังหวัดจดทะเบียน     */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "เลขถัง"              '"' SKIP.  /*หมายเหตุ            */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "ผลการประสานงาน"      '"' SKIP.  /*สถานะความคืบหน้า    */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "วันที่รับเงิน "      '"' SKIP.  /*รหัสบริษัทประกันภัย */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "สถานะการติดตาม"      '"' SKIP.  /*NCB                 */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ประกันแจ้งผลกลับ"    '"' SKIP.  /*YEAR_PRODUCT        */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "เลขกรมธรรม์"         '"' SKIP.  /*เลขถัง  */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "InspectionNo"        '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "InspectionResult"    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "InspectionDamage"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "InspectionResult2"   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "InspectionDamage2"   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "อุปกรณ์เสริม"        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "อุปกรณ์กันขโมย"      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "อุปกรณ์อื่นๆ"        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "สาขา"                '"' SKIP. 

FOR EACH wdetail2 NO-LOCK.
    nv_row  =  nv_row + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' wdetail2.TISCO_CODE        '"' SKIP.  /*"TISCO"              */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail2.contract          '"' SKIP.  /*"เลขที่สัญญา"        */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail2.notidate          '"' SKIP.  /*"วันที่แจ้งงาน"      */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail2.comdate           '"' SKIP.  /*"วันเริ่มคุ้มครอง"   */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail2.comname           '"' SKIP.  /*"บริษัทประกันภัย"    */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail2.insname           '"' SKIP.  /*"ชื่อผู้เอาประกัน"   */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail2.vehreg            '"' SKIP.  /*"หมายเลขทะเบียน"     */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail2.province          '"' SKIP.  /*"จังหวัดจดทะเบียน"   */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail2.nvchassis         '"' SKIP.  /*"เลขถัง"            */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail2.resulte           '"' SKIP.  /*"ผลการประสานงาน"    */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail2.receivedate       '"' SKIP.  /*"วันที่รับเงิน "    */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail2.remark            '"' SKIP.  /*"สถานะการติดตาม"    */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail2.insurceacc        '"' SKIP.  /*"ประกันแจ้งผลกลับ"  */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail2.nvpolicy          '"' SKIP.  /*"เลขกรมธรรม์"         */  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail2.InspectionNo      '"' SKIP.   /* "InspectionNo"      */                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail2.InspectionResult  '"' SKIP.   /* "InspectionResult"  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail2.InspectionDamage  '"' SKIP.   /* "InspectionDamage"  */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail2.InspectionResult2 '"' SKIP.   /* "InspectionResult2" */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail2.InspectionDamage2 '"' SKIP.   /* "InspectionDamage2" */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail2.accessories       '"' SKIP.   /* "อุปกรณ์เสริม"      */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail2.antitheftdevice   '"' SKIP.   /* "อุปกรณ์กันขโมย"    */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail2.anotherdevice     '"' SKIP.   /* "อุปกรณ์อื่นๆ"      */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail2.branchdespinsp    '"' SKIP.   /* "สาขา"  A67-0035            */
End.   /*  end  wdetail  */

nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "หมายเหตุ  :  ระดับความเสียหาย"           '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     A - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวไม่เกิน 6 นิ้ว หรือเสียหายไม่เกิน 10% ของเนื้อที่ทั้งหมด"            '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     B - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวไม่เกิน 18 นิ้ว หรือเสียหายไม่เกิน 30% ของเนื้อที่ทั้งหมด"            '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     C - ขีดข่วน ถลอก คลูด บุบ โดยมีความกว้าง+ยาวเกิน 18 นิ้ว หรือเสียหายเกิน 30% ของเนื้อที่ทั้งหมด"           '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "                     D - ต้องประกอบ เคาะ พ่นสี หรือเปลี่ยนอะไหล่ไปเลย (ไม่สามารถซ่อมได้)"           '"' SKIP.


PUT STREAM ns2 "E".

OUTPUT STREAM ns2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportnew c-wins 
PROCEDURE pd_reportnew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_row  =  0.
nv_row  =  nv_row + 1.
If  substr(fi_output,length(fi_output) - 3,4) <>  ".slk"  THEN fi_output  =  Trim(fi_output) + ".slk"  .
OUTPUT STREAM ns2 TO VALUE(fi_output).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' STRING(TODAY,"99/99/9999")  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Processing Office"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "CMR  code"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "Insur.comp"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "notify number"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Car year"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "engine"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "chassis"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "weight"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "power"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "color"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "licence no"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Garage"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "fleet disc."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ncb disc."                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "other disc."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "เลขที่ตรวจสภาพ"            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Comdat"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "ทุนประกัน"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "รหัสเจ้าหน้าที่แจ้งประกัน" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "ชื่อเจ้าหน้าที่ประกัน "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "วันที่แจ้งประกัน  "        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "เวลาแจ้งประกัน "           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "รหัสแจ้งงาน"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "prem.1"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "comp.prm"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "sticker"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "brand"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "address1"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "address2"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "title name"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "first name"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "last name"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "beneficiary"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "remark."                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "account no."               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "client No."                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "expiry date "              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "insurance amt."            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "province"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "receipt name"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "agent code"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "บริษัทประกันภัยเดิม"       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "old policy"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "deduct disc."              '"' SKIP.   /*Add kridtiya i. A54-0062 ...*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "ที่อยู่หน้าตาราง70"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "ตำบล"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "อำเภอ"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "จังหวัด"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "รหัสไปรษณีย์"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "ที่อยู่หน้าตาราง72"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "ตำบล"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "อำเภอ"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "จังหวัด"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "รหัสไปรษณีย์"              '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "Applicationtype"           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "Applicationcode"           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "Blank"                     '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "package"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "Seat/จำนวนที่นั่ง"         '"' SKIP.   /*add A57-0017 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "TPBI/Person"               '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "TPBI/Per Acciden"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "TPPD/Per Acciden"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "covcod"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "Producer"                  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "Agent"                     '"' SKIP.  /*Add kridtiya i. A54-0062 ...*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "Branch"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "NEW/RENEW"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "Redbook"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "Price_Ford"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "Year"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "Brand_Model"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x74;K"  '"' "Receipt ID. Number "         '"' SKIP.             /*  60  Receipt ID. Number   */                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x75;K"  '"' "Receipt Branch NAME"         '"' SKIP.             /*  61  Receipt Branch NAME  */                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x76;K"  '"' "Receipt Compulsory ID. Number"  '"' SKIP.  /*  62  Receipt Compulsory ID. Number  */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x77;K"  '"' "Receipt Compulsory Branch Name" '"' SKIP.  /*  63  Receipt Compulsory Branch Name */  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "วันที่คุ้มครอง พรบ. "            '"' SKIP.   /*64*/   /*Effective Date Accidential*/ /* A59-0178*/             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "วันที่สิ้นสุดความคุ้มครอง พรบ."  '"' SKIP.   /*65*/   /*Expiry Date Accidential*/    /* A59-0178*/                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "ทุนสูญหายและไฟไหม้"              '"' SKIP.   /*66*/   /*Coverage Amount Theft*/      /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "รหัสรถ"                          '"' SKIP.   /*67*/   /*Car code*/                   /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"  '"' "ลักษณะการใช้รถ"                  '"' SKIP.   /*68*/   /*Per Used*/                   /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"  '"' "ลำดับผู้ขับขี่คนที่ 1"           '"' SKIP.   /*69*/   /*Driver Seq1*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"  '"' "ชื่อผู้ขับขี่คนที่ 1"            '"' SKIP.   /*70*/   /*Driver Name1*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"  '"' "วันเดือนปีเกิดผู้ขับขี่คนที่ 1"  '"' SKIP.   /*71*/   /*Birthdate Driver1*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"  '"' "อาชีพผู้ขับขี่คนที่ 1"           '"' SKIP.   /*72*/   /*Occupation Driver1*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"  '"' "ตำแหน่งงานผู้ขับขี่คนที่ 1 "     '"' SKIP.   /*73*/   /*Position Driver1 */          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"  '"' "ลำดับผู้ขับขี่คนที่ 2"           '"' SKIP.   /*74*/   /*Driver Seq2*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"  '"' "ชื่อผู้ขับขี่คนที่ 2"            '"' SKIP.   /*75*/   /*Driver Name2*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"  '"' "วันเดือนปีเกิดผู้ขับขี่คนที่ 2"  '"' SKIP.   /*76*/   /*Birthdate Driver2*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"  '"' "อาชีพผู้ขับขี่คนที่ 2"           '"' SKIP.   /*77*/   /*Occupation Driver2*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"  '"' "ตำแหน่งงานผู้ขับขี่คนที่ 2 "     '"' SKIP.   /*78*/   /*Position Driver2*/           /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"  '"' "ลำดับผู้ขับขี่คนที่ 3"           '"' SKIP.   /*79*/   /*Driver Seq3*/                /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"  '"' "ชื่อผู้ขับขี่คนที่ 3"            '"' SKIP.   /*80*/   /*Driver Name3*/               /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"  '"' "วันเดือนปีเกิดผู้ขับขี่คนที่ 3"  '"' SKIP.   /*81*/   /*Birthdate Driver3*/          /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"  '"' "อาชีพผู้ขับขี่คนที่ 3"           '"' SKIP.   /*82*/   /*Occupation Driver3*/         /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"  '"' "ตำแหน่งงานผู้ขับขี่คนที่ 3 "     '"' SKIP.   /*83*/   /*Position Driver3*/           /* A59-0178*/                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x98;K"  '"' "BLANK" '"' SKIP.  /*  84  Blank */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x99;K"  '"' "72Receipt Name" '"' SKIP.  /*  85  72Rec */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x100;K" '"' "อุปกรณ์ตกแต่ง"                 '"' SKIP.  /*Car Accessories*/                 /* start : A63-0210*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x101;K" '"' "ชื่อที่ใช้บนใบเสร็จ(พรบ.)"     '"' SKIP.  /*Accidential Receipt name*/                              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x102;K" '"' "ที่อยู่ที่ใช้บนใบเสร็จ(พรบ.)1" '"' SKIP.  /*Accidential Receipt Address 1*/                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x103;K" '"' "ที่อยู่ที่ใช้บนใบเสร็จ(พรบ.)2" '"' SKIP.  /*Accidential Receipt Address 2*/   /* end : A63-0210*/   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x104;K" '"' "UP_Policy_Status" '"' SKIP.   /*Add A65-0364 */
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x105;K" '"' "Policy_no" '"' SKIP.         /*Add A65-0364 */
/* A67-0087 */ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x106;K" '"' "ช่องทางการขาย    "              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x107;K" '"' "รถยนต์ไฟฟ้า Y/N  "              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x108;K" '"' "ลำดับผู้ขับขี่คนที่ 4"          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x109;K" '"' "ชื่อผู้ขับขี่คนที่ 4 "          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x110;K" '"' "วันเดือนปีเกิดผู้ขับขี่คนที่4 " '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";x111;K" '"' "อาชีพผู้ขับขี่คนที่ 4  "        '"' SKIP.
PUT STREAM ns2 "C;Y" string(nv_row) ";x112;K" '"' "ตำแหน่งงานผู้ขับขี่คนที่ 4 "    '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x113;K" '"' "ลำดับผู้ขับขี่คนที่ 5  "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x114;K" '"' "ชื่อผู้ขับขี่คนที่ 5   "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x115;K" '"' "วันเดือนปีเกิดผู้ขับขี่คนที่5 " '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x116;K" '"' "อาชีพผู้ขับขี่คนที่ 5  "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x117;K" '"' "ตำแหน่งงานผู้ขับขี่คนที่ 5 "    '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x118;K" '"' "แคมเปญ                 "        '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x119;K" '"' "ส่งรูปแทนการตรวจสภาพรถ Y/N "    '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x120;K" '"' "จำนวนเลขเครื่อง      "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x121;K" '"' "หมายเลขเครื่องยนต์ 2 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x122;K" '"' "หมายเลขเครื่องยนต์ 3 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x123;K" '"' "หมายเลขเครื่องยนต์ 4 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x124;K" '"' "หมายเลขเครื่องยนต์ 5 "          '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x125;K" '"' "รหัส พ.ร.บ. "                   '"' skip.  
PUT STREAM ns2 "C;Y" string(nv_row) ";x126;K" '"' "ยี่ห้อรถ "                      '"' skip.   
/* end : A67-0087 */                                                         

RUN pd_data_reportnew.
OUTPUT STREAM ns2 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addinsp c-wins 
PROCEDURE proc_addinsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF VAR nv_year       AS CHAR FORMAT "x(5)" .
DEF VAR nv_docno      AS CHAR FORMAT "x(25)".
DEF VAR nv_survey     AS CHAR FORMAT "x(25)".
DEF VAR nv_detail     AS CHAR FORMAT "x(30)".
DEF VAR n_list        AS INT init 0.
DEF VAR n_count       AS INT init 0.
DEF VAR n_repair      AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam         AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil      AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag      AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair     AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_damdetail  AS LONGCHAR  INIT "". 
DEF VAR n_agent       AS CHAR FORMAT "x(12)" INIT "".
DEF VAR nv_remark1    AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2    AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist    AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage     AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam   AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile    AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device     AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1       as char format "x(50)".   
Def var nv_acc2       as char format "x(50)".   
Def var nv_acc3       as char format "x(50)".   
Def var nv_acc4       as char format "x(50)".   
Def var nv_acc5       as char format "x(50)".   
Def var nv_acc6       as char format "x(50)".   
Def var nv_acc7       as char format "x(50)".   
Def var nv_acc8       as char format "x(50)".   
Def var nv_acc9       as char format "x(50)".   
Def var nv_acc10      as char format "x(50)".   
Def var nv_acc11      as char format "x(50)".   
Def var nv_acc12      as char format "x(50)".   
Def var nv_acctotal   as char format "x(250)".   
DEF VAR nv_surdata    AS CHAR FORMAT "x(250)".
DEF VAR nv_date       AS CHAR FORMAT "x(15)".
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .  */
ASSIGN   
    nv_year     = ""   
    nv_docno    = ""   nv_survey = ""   nv_detail   = ""  nv_remark1 = ""   nv_remark2 = ""      n_repair2   = ""         nv_acc1amt = 0  nv_acc7amt = 0  
    nv_damlist  = ""   nv_damage = ""   nv_totaldam = ""  nv_attfile = ""   nv_device  = ""      nv_acc1     = ""         nv_acc2amt = 0  nv_acc8amt = 0  
    nv_acc2     = ""   nv_acc3   = ""   nv_acc4     = ""  nv_acc5    = ""   nv_acc6    = ""      nv_acc7     = ""         nv_acc3amt = 0  nv_acc9amt = 0  
    nv_acc8     = ""   nv_acc9   = ""   nv_acc10    = ""  nv_acc11   = ""   nv_acc12   = ""      nv_acctotal = ""         nv_acc4amt = 0  nv_acc10amt = 0 
    nv_surdata  = ""   nv_tmp    = ""   nv_date     = ""  n_agent    = ""   nv_damdetail2 = ""   nv_repair2 = ""          nv_acc5amt = 0  nv_acc11amt = 0 
    nv_year     = trim(fi_yearisp)      nv_detail2  = ""  nv_damdetail = ""  nv_branchdesp = ""                           nv_acc6amt = 0  nv_acc12amt = 0 
    nv_device   = ""   
    nv_device2  = ""    
    nv_surveydata = "" 
    nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".                                                             
                                                                                                                          
IF nv_cha_no <> "" THEN DO: 
  /*--------- Server Real ---------- */
  nv_server = "Safety_NotesServer/Safety".
  nv_tmp    = "safety\uw\" + nv_tmp .
  /*-------------------------------*/
  /*---------- Server test local ------- 
  nv_server = "".
  nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp .
  ----   Server test local     -----*/
  CREATE "Notes.NotesSession"  chNotesSession.
  chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
  IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
      MESSAGE "Can not open database" SKIP  
          "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
  END.
  chNotesView   = chNotesDatabase:GetView("เลขตัวถัง").
  /* chNavView  = chNotesView:CreateViewNav.
  chDocument    = chNotesView:GetDocumentByKey(brstat.tlt.cha_no).*/
  IF VALID-HANDLE(chNotesView) = YES THEN DO: 
    chNavView     = chNotesView:CreateViewNavFromCategory(nv_cha_no).
    IF VALID-HANDLE(chNavView) = YES THEN DO: 
      chViewEntry   = chNavView:GetLastDocument.   
      IF VALID-HANDLE(chViewEntry) = YES THEN DO: 
        chDocument    = chViewEntry:Document. 
        IF VALID-HANDLE(chDocument) = YES THEN DO:
          chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
          IF chitem <> 0 THEN nv_date = chitem:TEXT. 
          ELSE nv_date = "".
          chitem       = chDocument:Getfirstitem("docno").           /*เลขตรวจสภาพ*/
          IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
          ELSE nv_docno = "".
          chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
          IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
          ELSE nv_survey = "".
          chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
          IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
          ELSE nv_detail = "".
          IF nv_detail = "ติดปัญหา" THEN DO:
              chitem       = chDocument:Getfirstitem("DamageC").        /*ข้อมูลการติดปัญหา */
              IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
              ELSE nv_damage = "".
          END.
          IF nv_detail = "มีความเสียหาย"  THEN DO:
              chitem       = chDocument:Getfirstitem("DamageList").     /* รายการความเสียหาย */
              IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
              ELSE nv_damlist = "".
              chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
              IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
              ELSE nv_totaldam = "".
              IF nv_damlist <> "" THEN DO: 
                  ASSIGN n_list     = INT(nv_damlist)
                      nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
              END.
              IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .
              IF n_list > 0  THEN DO:
                  ASSIGN  n_count = 1 .
                  loop_damage:
                  REPEAT:
                      IF n_count <= n_list THEN DO:
                          ASSIGN  n_dam     = "List"   + STRING(n_count) 
                              n_repair  = "Repair" + STRING(n_count) 
                              n_repair2 = "Damage" + STRING(n_count) .
                          chitem       = chDocument:Getfirstitem(n_dam).
                          IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                          ELSE nv_damag = "".  
                          chitem       = chDocument:Getfirstitem(n_repair).
                          IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                          ELSE nv_repair = "".
                          chitem       = chDocument:Getfirstitem(n_repair2).
                          IF chitem <> 0 THEN  nv_repair2 = chitem:TEXT. 
                          ELSE nv_repair2 = "".
                          IF nv_damag <> "" THEN  
                              ASSIGN nv_damdetail  = nv_damdetail  + string(n_count) + "." + nv_damag + " "     + nv_repair + " , "  
                              nv_damdetail2 = nv_damdetail2 + string(n_count) + "." + nv_damag + " แผล " + nv_repair2 + " , " .
                          n_count = n_count + 1.
                      END.
                      ELSE LEAVE loop_damage.
                  END.
              END.
          END.    /* end ความเสียหาย */
          /*-- ข้อมูลอื่น ๆ ---*/
          chitem       = chDocument:Getfirstitem("SurveyData").
          IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
          ELSE nv_surdata = "".
          IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata.
          /*agentCode*/
          chitem       = chDocument:Getfirstitem("agentCode").      
          IF chitem <> 0 THEN n_agent = chitem:TEXT. 
          ELSE n_agent = "".
          /*Branch insp.*/
          chitem       = chDocument:Getfirstitem("BranchReq"). 
          IF chitem <> 0 THEN nv_branchdesp = chitem:TEXT. 
          ELSE nv_branchdesp = "".
        
          IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.
          /*-- อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".
          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
              IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
              ELSE nv_acctotal = "".
              chitem       = chDocument:Getfirstitem("DType1").
              IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
              ELSE nv_acc1 = "".
              chitem       = chDocument:Getfirstitem("DType2").
              IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
              ELSE nv_acc2 = "".
              chitem       = chDocument:Getfirstitem("DType3").
              IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
              ELSE nv_acc3 = "".
              chitem       = chDocument:Getfirstitem("DType4").
              IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
              ELSE nv_acc4 = "".
              chitem       = chDocument:Getfirstitem("DType5").
              IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
              ELSE nv_acc5 = "".
              chitem       = chDocument:Getfirstitem("DType6").
              IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
              ELSE nv_acc6 = "".
              chitem       = chDocument:Getfirstitem("DType7").
              IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
              ELSE nv_acc7 = "".
              chitem       = chDocument:Getfirstitem("DType8").
              IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
              ELSE nv_acc8 = "".
              chitem       = chDocument:Getfirstitem("DType9").
              IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
              ELSE nv_acc9 = "".
              chitem       = chDocument:Getfirstitem("DType10").
              IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
              ELSE nv_acc10 = "".
              chitem       = chDocument:Getfirstitem("DType11").
              IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
              ELSE nv_acc11 = "".
              chitem       = chDocument:Getfirstitem("DType12").
              IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
              ELSE nv_acc12 = "".
              ASSIGN nv_device = "อุปกรณ์เสริม : " .
              chitem       = chDocument:Getfirstitem("pricesD_1"). IF chitem <> 0 THEN  nv_acc1amt  = chitem:TEXT. ELSE nv_acc1amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_2"). IF chitem <> 0 THEN  nv_acc2amt  = chitem:TEXT. ELSE nv_acc2amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_3"). IF chitem <> 0 THEN  nv_acc3amt  = chitem:TEXT. ELSE nv_acc3amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_4"). IF chitem <> 0 THEN  nv_acc4amt  = chitem:TEXT. ELSE nv_acc4amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_5"). IF chitem <> 0 THEN  nv_acc5amt  = chitem:TEXT. ELSE nv_acc5amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_6"). IF chitem <> 0 THEN  nv_acc6amt  = chitem:TEXT. ELSE nv_acc6amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_7"). IF chitem <> 0 THEN  nv_acc7amt  = chitem:TEXT. ELSE nv_acc7amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_8"). IF chitem <> 0 THEN  nv_acc8amt  = chitem:TEXT. ELSE nv_acc8amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_9"). IF chitem <> 0 THEN  nv_acc9amt  = chitem:TEXT. ELSE nv_acc9amt  = 0.
              chitem       = chDocument:Getfirstitem("pricesD_10"). IF chitem <> 0 THEN nv_acc10amt = chitem:TEXT. ELSE nv_acc10amt = 0.
              chitem       = chDocument:Getfirstitem("pricesD_11"). IF chitem <> 0 THEN nv_acc11amt = chitem:TEXT. ELSE nv_acc11amt = 0.
              chitem       = chDocument:Getfirstitem("pricesD_12"). IF chitem <> 0 THEN nv_acc12amt = chitem:TEXT. ELSE nv_acc12amt = 0.
              chitem       = chDocument:Getfirstitem("device2").    IF chitem <> 0 THEN  nv_device2 = chitem:TEXT.  ELSE nv_device2 = "".
              IF nv_device2 <> "" THEN DO:
                  chitem       = chDocument:Getfirstitem("device2_T").  IF chitem <> 0 THEN  nv_device2 = nv_device2 +  chitem:TEXT.   
                  chitem       = chDocument:Getfirstitem("etcD").       IF chitem <> 0 THEN  nv_device2 = nv_device2 +  chitem:TEXT.  
              END.
              chitem       = chDocument:Getfirstitem("SurveyData").  IF chitem <> 0 THEN  nv_surveydata   = chitem:TEXT.  ELSE nv_surveydata   = "".
              IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device +         TRIM(nv_acc1)   + " " +  string(nv_acc1amt)  .
              IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2)   + " " +  string(nv_acc2amt)  .
              IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3)   + " " +  string(nv_acc3amt)  .
              IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4)   + " " +  string(nv_acc4amt)  .
              IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5)   + " " +  string(nv_acc5amt)  .
              IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6)   + " " +  string(nv_acc6amt)  .
              IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7)   + " " +  string(nv_acc7amt)  .
              IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8)   + " " +  string(nv_acc8amt)  .
              IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9)   + " " +  string(nv_acc9amt)  .
              IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10)  + " " +  string(nv_acc10amt) .
              IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11)  + " " +  string(nv_acc11amt) .
              IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12)  + " " +  string(nv_acc12amt) .
              nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
              ASSIGN 
              wdetail2.accessories      = nv_device .
              wdetail2.antitheftdevice  = nv_device2.
              wdetail2.anotherdevice    = nv_surveydata .
          END.
          IF nv_docno <> ""  THEN DO:
              IF nv_survey <> "" THEN DO:
                  IF nv_detail = "ติดปัญหา" THEN DO:
                      ASSIGN   
                      wdetail2.InspectionNo       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                      wdetail2.InspectionResult   = nv_detail + " : " + nv_damage /* ความเสียหาย */ 
                      wdetail2.InspectionDamage   = nv_damdetail                  /*รายการความเสียหาย */       
                      wdetail2.InspectionResult2  = nv_detail + " : " + nv_damage /* ความเสียหาย */ 
                      wdetail2.InspectionDamage2  = nv_damdetail  .                /*รายการความเสียหาย */     
                  END.
                  ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                      ASSIGN  
                      wdetail2.InspectionNo       = nv_docno                                      /*เลขที่ตรวจสภาพ */              
                      wdetail2.InspectionResult   = nv_detail + " : " + nv_damlist + nv_totaldam  /* ความเสียหาย */ 
                      wdetail2.InspectionDamage   = nv_damdetail                                  /*รายการความเสียหาย */  
                      wdetail2.InspectionResult2  = nv_detail + " : " + nv_damlist 
                      wdetail2.InspectionDamage2  = nv_damdetail2  .                               
                  END.
                  ELSE DO: 
                      ASSIGN   
                      wdetail2.InspectionNo       = nv_docno              /*เลขที่ตรวจสภาพ */              
                      wdetail2.InspectionResult   = nv_detail
                      wdetail2.InspectionDamage   = ""                    /*รายการความเสียหาย */   
                      wdetail2.InspectionResult2  = nv_detail
                      wdetail2.InspectionDamage2  = "" .
                  END.
              END.
              ELSE DO:
                  ASSIGN  
                  wdetail2.InspectionNo      = nv_docno  
                  wdetail2.InspectionResult  = ""
                  wdetail2.InspectionDamage  = ""   
                  wdetail2.InspectionResult2 = "" 
                  wdetail2.InspectionDamage2 = "" .
                    
              END.
          END.
        END. /*VALID-HANDLE(chDocument) = YES*/
        ELSE ASSIGN  
                        wdetail2.InspectionNo      = nv_docno  
                        wdetail2.InspectionResult  = ""
                        wdetail2.InspectionDamage  = ""   
                        wdetail2.InspectionResult2 = "" 
                        wdetail2.InspectionDamage2 = "" .
      END.   /*VALID-HANDLE(chViewEntry) = YES*/
      ELSE ASSIGN  
                        wdetail2.InspectionNo      = nv_docno  
                        wdetail2.InspectionResult  = ""
                        wdetail2.InspectionDamage  = ""   
                        wdetail2.InspectionResult2 = "" 
                        wdetail2.InspectionDamage2 = "" .
    END.  /*VALID-HANDLE(chNavView) */
    ELSE ASSIGN  
                        wdetail2.InspectionNo      = nv_docno  
                        wdetail2.InspectionResult  = ""
                        wdetail2.InspectionDamage  = ""   
                        wdetail2.InspectionResult2 = "" 
                        wdetail2.InspectionDamage2 = "" .

    
  END. /*(chNotesView)*/
END. /*nv_cha_no = "" */
ASSIGN wdetail2.branchdespinsp = nv_branchdesp.   /*A67-0035*/

RELEASE  OBJECT chitem          NO-ERROR.
RELEASE  OBJECT chDocument      NO-ERROR.          
RELEASE  OBJECT chNotesDataBase NO-ERROR.     
RELEASE  OBJECT chNotesSession  NO-ERROR.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchvehreg c-wins 
PROCEDURE proc_matchvehreg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


        IF INDEX(nv_provi,".") <> 0 THEN REPLACE(nv_provi,".","").

/*1*/        IF nv_provi = "ANG THONG"          THEN nv_provi = "อท".
        ELSE IF nv_provi = "ANGTHONG"           THEN nv_provi = "อท".
        ELSE IF nv_provi = "ANG-THONG"          THEN nv_provi = "อท".
/*2*/   ELSE IF nv_provi = "AYUTTHAYA"          THEN nv_provi = "อย".
/*3*/   ELSE IF nv_provi = "BKK"                THEN nv_provi = "กท". /*-A59-0503-*/ /* open A60-0095*/
/*3*/   ELSE IF nv_provi = "BANGKOK"            THEN nv_provi = "กท".
/*4*/   ELSE IF nv_provi = "BURIRAM"            THEN nv_provi = "บร".
/*5*/   ELSE IF nv_provi = "CHAI NAT"           THEN nv_provi = "ชน".
        ELSE IF nv_provi = "CHAI-NAT"           THEN nv_provi = "ชน".
/*6*/   ELSE IF nv_provi = "CHANTHABURI"        THEN nv_provi = "จบ".
/*7*/   ELSE IF nv_provi = "CHIANG MAI"         THEN nv_provi = "ชม".
        ELSE IF nv_provi = "CHIANGMAI"          THEN nv_provi = "ชม".
/*8*/   ELSE IF nv_provi = "CHONBURI"           THEN nv_provi = "ชบ".
/*9*/   ELSE IF nv_provi = "KALASIN"            THEN nv_provi = "กส".
/*10*/  ELSE IF nv_provi = "KANCHANABURI"       THEN nv_provi = "กจ".
/*11*/  ELSE IF nv_provi = "KHON KAEN"          THEN nv_provi = "ขก".
        ELSE IF nv_provi = "KHONKAEN"           THEN nv_provi = "ขก".
/*12*/  ELSE IF nv_provi = "KRABI"              THEN nv_provi = "กบ".
/*13*/  ELSE IF nv_provi = "LOPBURI"            THEN nv_provi = "ลบ".
/*14*/  ELSE IF nv_provi = "NAKHON NAYOK"       THEN nv_provi = "นย".
        ELSE IF nv_provi = "NAKHONNAYOK"        THEN nv_provi = "นย".
/*15*/  ELSE IF nv_provi = "NAKHON PATHOM"      THEN nv_provi = "นฐ".
        ELSE IF nv_provi = "NAKHONPATHOM"       THEN nv_provi = "นฐ".
/*16*/  ELSE IF nv_provi = "NAKHON RATCHASIMA"  THEN nv_provi = "นม".
        ELSE IF nv_provi = "NAKHONRATCHASIMA"   THEN nv_provi = "นม".
/*17*/  ELSE IF nv_provi = "NAKHON SITHAMMARAT" THEN nv_provi = "นศ".
        ELSE IF nv_provi = "NAKHONSITHAMMARAT"  THEN nv_provi = "นศ".
/*18*/  ELSE IF nv_provi = "NONTHABURI"         THEN nv_provi = "นบ".
/*19*/  ELSE IF nv_provi = "PHETCHABURI"        THEN nv_provi = "พบ".
/*20*/  ELSE IF nv_provi = "PHUKET"             THEN nv_provi = "ภก".
/*21*/  ELSE IF nv_provi = "PHITSANULOK"        THEN nv_provi = "พล".
/*22*/  ELSE IF nv_provi = "PRACHINBURI"        THEN nv_provi = "ปจ".
/*23*/  ELSE IF nv_provi = "RATCHABURI"         THEN nv_provi = "รบ".
/*24*/  ELSE IF nv_provi = "RAYONG"             THEN nv_provi = "รย".
/*25*/  ELSE IF nv_provi = "ROI ET"             THEN nv_provi = "รอ".
        ELSE IF nv_provi = "ROI-ET"             THEN nv_provi = "รอ".
        ELSE IF nv_provi = "ROIET"              THEN nv_provi = "รอ".
/*26*/  ELSE IF nv_provi = "SARABURI"           THEN nv_provi = "สบ".
/*27*/  ELSE IF nv_provi = "SRISAKET"           THEN nv_provi = "ศก".
/*28*/  ELSE IF nv_provi = "SONGKHLA"           THEN nv_provi = "สข".
/*29*/  ELSE IF nv_provi = "SA KAEO"            THEN nv_provi = "สก".
        ELSE IF nv_provi = "SAKAEO"             THEN nv_provi = "สก".
/*30*/  ELSE IF nv_provi = "SUPHANBURI"         THEN nv_provi = "สพ".
/*/*31*/  ELSE IF nv_provi = "SURAT THANI"        THEN nv_provi = "สฏ".
        ELSE IF nv_provi = "SURATTHANI"         THEN nv_provi = "สฏ". A63-0210 */
/*31*/  ELSE IF nv_provi = "SURAT THANI"        THEN nv_provi = "สฎ".
        ELSE IF nv_provi = "SURATTHANI"         THEN nv_provi = "สฎ". /*A63-0210 */
/*32*/  ELSE IF nv_provi = "TRANG"              THEN nv_provi = "ตง".
/*33*/  ELSE IF nv_provi = "UBON RATCHATHANI"   THEN nv_provi = "อบ".
        ELSE IF nv_provi = "UBONRATCHATHANI"    THEN nv_provi = "อบ".
/*34*/  ELSE IF nv_provi = "UDON THANI"         THEN nv_provi = "อด".
        ELSE IF nv_provi = "UDONTHANI"          THEN nv_provi = "อด".
/*35*/  ELSE IF nv_provi = "AMNAT CHAROEN"      THEN nv_provi = "อจ".
        ELSE IF nv_provi = "AMNATCHAROEN"       THEN nv_provi = "อจ".
/*36*/  ELSE IF nv_provi = "CHAIYAPHUM"         THEN nv_provi = "ชย".
/*37*/  ELSE IF nv_provi = "CHIANG RAI"         THEN nv_provi = "ชร".
        ELSE IF nv_provi = "CHIANGRAI"          THEN nv_provi = "ชร".
/*38*/  ELSE IF nv_provi = "CHUMPHON"           THEN nv_provi = "ชพ".
/*39*/  ELSE IF nv_provi = "KAMPHAENG PHET"     THEN nv_provi = "กพ".
        ELSE IF nv_provi = "KAMPHAENGPHET"      THEN nv_provi = "กพ".
/*40*/  ELSE IF nv_provi = "LAMPANG"            THEN nv_provi = "ลป".
/*41*/  ELSE IF nv_provi = "LAMPHUN"            THEN nv_provi = "ลพ".
/*42*/  ELSE IF nv_provi = "NAKHON SAWAN"       THEN nv_provi = "นว".
        ELSE IF nv_provi = "NAKHONSAWAN"        THEN nv_provi = "นว".
/*43*/  ELSE IF nv_provi = "NONG KHAI"          THEN nv_provi = "นค".
        ELSE IF nv_provi = "NONGKHAI"           THEN nv_provi = "นค".
/*44*/  ELSE IF nv_provi = "PATHUM THANI"       THEN nv_provi = "ปท".
        ELSE IF nv_provi = "PATHUMTHANI"        THEN nv_provi = "ปท".
/*45*/  ELSE IF nv_provi = "PATTANI"            THEN nv_provi = "ปน".
/*46*/  ELSE IF nv_provi = "PHATTHALUNG"        THEN nv_provi = "พท".
/*47*/  ELSE IF nv_provi = "PHETCHABUN"         THEN nv_provi = "พช".
/*48*/  ELSE IF nv_provi = "SAKON NAKHON"       THEN nv_provi = "สน".
/*49*/  ELSE IF nv_provi = "SING BURI"          THEN nv_provi = "สห".
        ELSE IF nv_provi = "SINGBURI"           THEN nv_provi = "สห".
/*50*/  ELSE IF nv_provi = "SURIN"              THEN nv_provi = "สร".
/*51*/  ELSE IF nv_provi = "YASOTHON"           THEN nv_provi = "ยส".
/*52*/  ELSE IF nv_provi = "YALA"               THEN nv_provi = "ยล".
/*53*/  ELSE IF nv_provi = "BAYTONG"            THEN nv_provi = "บต".
/*54*/  ELSE IF nv_provi = "CHACHOENGSAO"       THEN nv_provi = "ฉช".
/*55*/  ELSE IF nv_provi = "LOEI"               THEN nv_provi = "ลย".
/*56*/  ELSE IF nv_provi = "MAE HONG SON"       THEN nv_provi = "มส".
        ELSE IF nv_provi = "MAEHONGSON"         THEN nv_provi = "มส".
/*57*/  ELSE IF nv_provi = "MAHA SARAKHAM"      THEN nv_provi = "มค".
        ELSE IF nv_provi = "MAHASARAKHAM"       THEN nv_provi = "มค".
/*58*/  ELSE IF nv_provi = "MUKDAHAN"           THEN nv_provi = "มห".
/*59*/  ELSE IF nv_provi = "NAN"                THEN nv_provi = "นน".
/*60*/  ELSE IF nv_provi = "NARATHIWAT"         THEN nv_provi = "นธ".
/*61*/  ELSE IF nv_provi = "NONG BUA LAMPHU"    THEN nv_provi = "นภ".
        ELSE IF nv_provi = "NONGBUALAMPHU"      THEN nv_provi = "นภ".
/*62*/  ELSE IF nv_provi = "PHAYAO"             THEN nv_provi = "พย".  
/*63*/  ELSE IF nv_provi = "PHANG NGA"          THEN nv_provi = "พง".
        ELSE IF nv_provi = "PHANGNGA"           THEN nv_provi = "พง".
/*64*/  ELSE IF nv_provi = "PHRAE"              THEN nv_provi = "พร".
/*65*/  ELSE IF nv_provi = "PHICHIT"            THEN nv_provi = "พจ".
/*66*/  ELSE IF nv_provi = "PRACHUAP KHIRIKHAN" THEN nv_provi = "ปข".
        ELSE IF nv_provi = "PRACHUAPKHIRIKHAN"  THEN nv_provi = "ปข".
/*67*/  ELSE IF nv_provi = "RANONG"             THEN nv_provi = "รน".
/*68*/  ELSE IF nv_provi = "SAMUT PRAKAN"       THEN nv_provi = "สป".
/*69*/  ELSE IF nv_provi = "SAMUT SAKHON"       THEN nv_provi = "สค". 
/*70*/  ELSE IF nv_provi = "SAMUT SONGKHRAM"    THEN nv_provi = "สส".
        ELSE IF nv_provi = "SAMUTPRAKAN"        THEN nv_provi = "สป".  
        ELSE IF nv_provi = "SAMUTSAKHON"        THEN nv_provi = "สค".  
        ELSE IF nv_provi = "SAMUTSONGKHRAM"     THEN nv_provi = "สส".  
/*71*/  ELSE IF nv_provi = "SATUN"              THEN nv_provi = "สต".
/*72*/  ELSE IF nv_provi = "SUKHOTHAI"          THEN nv_provi = "สท".
/*73*/  ELSE IF nv_provi = "TAK"                THEN nv_provi = "ตก".
/*74*/  ELSE IF nv_provi = "TRAT"               THEN nv_provi = "ตร".
/*75*/  ELSE IF nv_provi = "UTHAI THANI"        THEN nv_provi = "อน".
        ELSE IF nv_provi = "UTHAITHANI"         THEN nv_provi = "อน".
/*76*/  ELSE IF nv_provi = "UTTARADIT"          THEN nv_provi = "อต".
/*77*/  ELSE IF nv_provi = "NAKHON PHANOM"      THEN nv_provi = "นพ". 
        ELSE IF nv_provi = "NAKHONPHANOM"       THEN nv_provi = "นพ". 
/*78*/  ELSE IF nv_provi = "BUENG KAN"          THEN nv_provi = "บก".
        ELSE IF nv_provi = "BUENGKAN"           THEN nv_provi = "บก". 
        ELSE IF nv_provi = "กทม"                THEN nv_provi = "กท".  /*a60-0095*/
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(nv_provi) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN   
                ASSIGN nv_provi = Insure.LName.
       END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province c-wins 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
       IF INDEX(wdetail.province,".") <> 0 THEN REPLACE(wdetail.province,".","").
/*1*/        IF wdetail.province = "ANG THONG"          THEN wdetail.province = "อท".
        ELSE IF wdetail.province = "ANGTHONG"           THEN wdetail.province = "อท".
        ELSE IF wdetail.province = "ANG-THONG"          THEN wdetail.province = "อท".
/*2*/   ELSE IF wdetail.province = "AYUTTHAYA"          THEN wdetail.province = "อย".
/*3*/   ELSE IF wdetail.province = "BKK"                THEN wdetail.province = "กท". /*-A59-0503-*/ /* open A60-0095*/
/*3*/   ELSE IF wdetail.province = "BANGKOK"            THEN wdetail.province = "กท".
/*4*/   ELSE IF wdetail.province = "BURIRAM"            THEN wdetail.province = "บร".
/*5*/   ELSE IF wdetail.province = "CHAI NAT"           THEN wdetail.province = "ชน".
        ELSE IF wdetail.province = "CHAI-NAT"           THEN wdetail.province = "ชน".
/*6*/   ELSE IF wdetail.province = "CHANTHABURI"        THEN wdetail.province = "จบ".
/*7*/   ELSE IF wdetail.province = "CHIANG MAI"         THEN wdetail.province = "ชม".
        ELSE IF wdetail.province = "CHIANGMAI"          THEN wdetail.province = "ชม".
/*8*/   ELSE IF wdetail.province = "CHONBURI"           THEN wdetail.province = "ชบ".
/*9*/   ELSE IF wdetail.province = "KALASIN"            THEN wdetail.province = "กส".
/*10*/  ELSE IF wdetail.province = "KANCHANABURI"       THEN wdetail.province = "กจ".
/*11*/  ELSE IF wdetail.province = "KHON KAEN"          THEN wdetail.province = "ขก".
        ELSE IF wdetail.province = "KHONKAEN"           THEN wdetail.province = "ขก".
/*12*/  ELSE IF wdetail.province = "KRABI"              THEN wdetail.province = "กบ".
/*13*/  ELSE IF wdetail.province = "LOPBURI"            THEN wdetail.province = "ลบ".
/*14*/  ELSE IF wdetail.province = "NAKHON NAYOK"       THEN wdetail.province = "นย".
        ELSE IF wdetail.province = "NAKHONNAYOK"        THEN wdetail.province = "นย".
/*15*/  ELSE IF wdetail.province = "NAKHON PATHOM"      THEN wdetail.province = "นฐ".
        ELSE IF wdetail.province = "NAKHONPATHOM"       THEN wdetail.province = "นฐ".
/*16*/  ELSE IF wdetail.province = "NAKHON RATCHASIMA"  THEN wdetail.province = "นม".
        ELSE IF wdetail.province = "NAKHONRATCHASIMA"   THEN wdetail.province = "นม".
/*17*/  ELSE IF wdetail.province = "NAKHON SITHAMMARAT" THEN wdetail.province = "นศ".
        ELSE IF wdetail.province = "NAKHONSITHAMMARAT"  THEN wdetail.province = "นศ".
/*18*/  ELSE IF wdetail.province = "NONTHABURI"         THEN wdetail.province = "นบ".
/*19*/  ELSE IF wdetail.province = "PHETCHABURI"        THEN wdetail.province = "พบ".
/*20*/  ELSE IF wdetail.province = "PHUKET"             THEN wdetail.province = "ภก".
/*21*/  ELSE IF wdetail.province = "PHITSANULOK"        THEN wdetail.province = "พล".
/*22*/  ELSE IF wdetail.province = "PRACHINBURI"        THEN wdetail.province = "ปจ".
/*23*/  ELSE IF wdetail.province = "RATCHABURI"         THEN wdetail.province = "รบ".
/*24*/  ELSE IF wdetail.province = "RAYONG"             THEN wdetail.province = "รย".
/*25*/  ELSE IF wdetail.province = "ROI ET"             THEN wdetail.province = "รอ".
        ELSE IF wdetail.province = "ROI-ET"             THEN wdetail.province = "รอ".
        ELSE IF wdetail.province = "ROIET"              THEN wdetail.province = "รอ".
/*26*/  ELSE IF wdetail.province = "SARABURI"           THEN wdetail.province = "สบ".
/*27*/  ELSE IF wdetail.province = "SRISAKET"           THEN wdetail.province = "ศก".
/*28*/  ELSE IF wdetail.province = "SONGKHLA"           THEN wdetail.province = "สข".
/*29*/  ELSE IF wdetail.province = "SA KAEO"            THEN wdetail.province = "สก".
        ELSE IF wdetail.province = "SAKAEO"             THEN wdetail.province = "สก".
/*30*/  ELSE IF wdetail.province = "SUPHANBURI"         THEN wdetail.province = "สพ".
/*/*31*/  ELSE IF wdetail.province = "SURAT THANI"        THEN wdetail.province = "สฏ".
        ELSE IF wdetail.province = "SURATTHANI"         THEN wdetail.province = "สฏ". A63-0210 */
/*31*/  ELSE IF wdetail.province = "SURAT THANI"        THEN wdetail.province = "สฎ".
        ELSE IF wdetail.province = "SURATTHANI"         THEN wdetail.province = "สฎ". /*A63-0210 */
/*32*/  ELSE IF wdetail.province = "TRANG"              THEN wdetail.province = "ตง".
/*33*/  ELSE IF wdetail.province = "UBON RATCHATHANI"   THEN wdetail.province = "อบ".
        ELSE IF wdetail.province = "UBONRATCHATHANI"    THEN wdetail.province = "อบ".
/*34*/  ELSE IF wdetail.province = "UDON THANI"         THEN wdetail.province = "อด".
        ELSE IF wdetail.province = "UDONTHANI"          THEN wdetail.province = "อด".
/*35*/  ELSE IF wdetail.province = "AMNAT CHAROEN"      THEN wdetail.province = "อจ".
        ELSE IF wdetail.province = "AMNATCHAROEN"       THEN wdetail.province = "อจ".
/*36*/  ELSE IF wdetail.province = "CHAIYAPHUM"         THEN wdetail.province = "ชย".
/*37*/  ELSE IF wdetail.province = "CHIANG RAI"         THEN wdetail.province = "ชร".
        ELSE IF wdetail.province = "CHIANGRAI"          THEN wdetail.province = "ชร".
/*38*/  ELSE IF wdetail.province = "CHUMPHON"           THEN wdetail.province = "ชพ".
/*39*/  ELSE IF wdetail.province = "KAMPHAENG PHET"     THEN wdetail.province = "กพ".
        ELSE IF wdetail.province = "KAMPHAENGPHET"      THEN wdetail.province = "กพ".
/*40*/  ELSE IF wdetail.province = "LAMPANG"            THEN wdetail.province = "ลป".
/*41*/  ELSE IF wdetail.province = "LAMPHUN"            THEN wdetail.province = "ลพ".
/*42*/  ELSE IF wdetail.province = "NAKHON SAWAN"       THEN wdetail.province = "นว".
        ELSE IF wdetail.province = "NAKHONSAWAN"        THEN wdetail.province = "นว".
/*43*/  ELSE IF wdetail.province = "NONG KHAI"          THEN wdetail.province = "นค".
        ELSE IF wdetail.province = "NONGKHAI"           THEN wdetail.province = "นค".
/*44*/  ELSE IF wdetail.province = "PATHUM THANI"       THEN wdetail.province = "ปท".
        ELSE IF wdetail.province = "PATHUMTHANI"        THEN wdetail.province = "ปท".
/*45*/  ELSE IF wdetail.province = "PATTANI"            THEN wdetail.province = "ปน".
/*46*/  ELSE IF wdetail.province = "PHATTHALUNG"        THEN wdetail.province = "พท".
/*47*/  ELSE IF wdetail.province = "PHETCHABUN"         THEN wdetail.province = "พช".
/*48*/  ELSE IF wdetail.province = "SAKON NAKHON"       THEN wdetail.province = "สน".
/*49*/  ELSE IF wdetail.province = "SING BURI"          THEN wdetail.province = "สห".
        ELSE IF wdetail.province = "SINGBURI"           THEN wdetail.province = "สห".
/*50*/  ELSE IF wdetail.province = "SURIN"              THEN wdetail.province = "สร".
/*51*/  ELSE IF wdetail.province = "YASOTHON"           THEN wdetail.province = "ยส".
/*52*/  ELSE IF wdetail.province = "YALA"               THEN wdetail.province = "ยล".
/*53*/  ELSE IF wdetail.province = "BAYTONG"            THEN wdetail.province = "บต".
/*54*/  ELSE IF wdetail.province = "CHACHOENGSAO"       THEN wdetail.province = "ฉช".
/*55*/  ELSE IF wdetail.province = "LOEI"               THEN wdetail.province = "ลย".
/*56*/  ELSE IF wdetail.province = "MAE HONG SON"       THEN wdetail.province = "มส".
        ELSE IF wdetail.province = "MAEHONGSON"         THEN wdetail.province = "มส".
/*57*/  ELSE IF wdetail.province = "MAHA SARAKHAM"      THEN wdetail.province = "มค".
        ELSE IF wdetail.province = "MAHASARAKHAM"       THEN wdetail.province = "มค".
/*58*/  ELSE IF wdetail.province = "MUKDAHAN"           THEN wdetail.province = "มห".
/*59*/  ELSE IF wdetail.province = "NAN"                THEN wdetail.province = "นน".
/*60*/  ELSE IF wdetail.province = "NARATHIWAT"         THEN wdetail.province = "นธ".
/*61*/  ELSE IF wdetail.province = "NONG BUA LAMPHU"    THEN wdetail.province = "นภ".
        ELSE IF wdetail.province = "NONGBUALAMPHU"      THEN wdetail.province = "นภ".
/*62*/  ELSE IF wdetail.province = "PHAYAO"             THEN wdetail.province = "พย".  
/*63*/  ELSE IF wdetail.province = "PHANG NGA"          THEN wdetail.province = "พง".
        ELSE IF wdetail.province = "PHANGNGA"           THEN wdetail.province = "พง".
/*64*/  ELSE IF wdetail.province = "PHRAE"              THEN wdetail.province = "พร".
/*65*/  ELSE IF wdetail.province = "PHICHIT"            THEN wdetail.province = "พจ".
/*66*/  ELSE IF wdetail.province = "PRACHUAP KHIRIKHAN" THEN wdetail.province = "ปข".
        ELSE IF wdetail.province = "PRACHUAPKHIRIKHAN"  THEN wdetail.province = "ปข".
/*67*/  ELSE IF wdetail.province = "RANONG"             THEN wdetail.province = "รน".
/*68*/  ELSE IF wdetail.province = "SAMUT PRAKAN"       THEN wdetail.province = "สป".
/*69*/  ELSE IF wdetail.province = "SAMUT SAKHON"       THEN wdetail.province = "สค". 
/*70*/  ELSE IF wdetail.province = "SAMUT SONGKHRAM"    THEN wdetail.province = "สส".
        ELSE IF wdetail.province = "SAMUTPRAKAN"        THEN wdetail.province = "สป".  
        ELSE IF wdetail.province = "SAMUTSAKHON"        THEN wdetail.province = "สค".  
        ELSE IF wdetail.province = "SAMUTSONGKHRAM"     THEN wdetail.province = "สส".  
/*71*/  ELSE IF wdetail.province = "SATUN"              THEN wdetail.province = "สต".
/*72*/  ELSE IF wdetail.province = "SUKHOTHAI"          THEN wdetail.province = "สท".
/*73*/  ELSE IF wdetail.province = "TAK"                THEN wdetail.province = "ตก".
/*74*/  ELSE IF wdetail.province = "TRAT"               THEN wdetail.province = "ตร".
/*75*/  ELSE IF wdetail.province = "UTHAI THANI"        THEN wdetail.province = "อน".
        ELSE IF wdetail.province = "UTHAITHANI"         THEN wdetail.province = "อน".
/*76*/  ELSE IF wdetail.province = "UTTARADIT"          THEN wdetail.province = "อต".
/*77*/  ELSE IF wdetail.province = "NAKHON PHANOM"      THEN wdetail.province = "นพ". 
        ELSE IF wdetail.province = "NAKHONPHANOM"       THEN wdetail.province = "นพ". 
/*78*/  ELSE IF wdetail.province = "BUENG KAN"          THEN wdetail.province = "บก".
        ELSE IF wdetail.province = "BUENGKAN"           THEN wdetail.province = "บก". 
        ELSE IF wdetail.province = "กทม"                THEN wdetail.province = "กท".  /*a60-0095*/
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(wdetail.province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN   
                ASSIGN wdetail.province = Insure.LName.
       END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery c-wins 
PROCEDURE Pro_openQuery :
/*------------------------------------------------------------------------------
  Purpose:
       
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*If  fi_polfr  =   "0"  Then  fi_polfr  =  " "  .*/
Open Query br_tlt 
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        /*tlt.policy >=  fi_polfr      And
        tlt.policy <=  fi_polto     And*/
        /*  tlt.comp_sub  =  fi_producer  And*/
        tlt.genusr   =  "Tisco"      no-lock.
        ASSIGN
            nv_rectlt =  recid(tlt).   /*A55-0184*/
                             

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery2 c-wins 
PROCEDURE Pro_openQuery2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_tlt 
    /*For each tlt Use-index  tlt01 Where
                             tlt.trndat  >=  fi_trndatfr  And
                             tlt.trndat  <=  fi_trndatto  And
                             /*tlt.policy >=  fi_polfr      And
                             tlt.policy <=  fi_polto     And*/
                           /*  tlt.comp_sub  =  fi_producer  And*/
                             recid(tlt) = nv_rectlt        AND 
                             tlt.genusr   =  "Tisco"      no-lock.*/
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   /*A57-0017*/
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

