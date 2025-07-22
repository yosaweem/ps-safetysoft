&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: 
Description: 
Input Parameters:<none>
Output Parameters:<none>
Author: 
Created: ------------------------------------------------------------------------*/
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
wgwimtis.w :  Import text file from  Tisco  to create  new policy Add in table tlt( brstat)  
Program Import Text File    - File detail insured 
                            -  File detail Driver
Create  by   : Kridtiya i.  [A53-0207]  date. 13/09/2010
copy program : wuwimtis.w  
Connect    : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)
modify by  : Kridtiya i. A54-0061 เพิ่มที่อยู่ลูกค้าตาม layout new
modify by  : Kridtiya i. A54-0216 date 23/08/2011 ปรับไม่เช็คเลขถังการเข้าข้อมูล
modify by  : kridtiya i. A55-0184 ปรับแก้ไขการนำเข้าไฟล์ป้ายแดงให้โหลดข้อมูลพัก
modify by  : kridtiya i. A55-0267 ปรับแก้ไขการupdate ข้อมูลล่าสุด 
modify by  : kridtiya i. A56-0146 ปรับการนำเข้าไฟล์ผู้ขับขี่
modify by  : kridtiya i. A56-0399 เพิ่มการแบ่งข้อมูลช่อง remark ให้เป็น 3 บรรทัด
modify by  : Kridtiya i. A57-0017 add column seat , first date       
modify by  : Kridtiya i. A57-0262 add new format idno and id br name 
modify by  : Manop G, A59-0178   Add new column Driver Name1-2    
modify by  : Ranu I. A59-0618  งานต่ออายุดึงข้อมูลผู้ขับขี่จากไฟล์แจ้งงาน-*/
/*modify by : Ranu I. A60-0095  เพิ่มเงื่อนไขการเช็คข้อมูล พรบ. งานต่ออายุ */
/*modify by : Ranu I. A60-0118  เพิ่มการ Create data ที่กล่องตรวจสภาพ */
/*modify by : Ranu I. A60-0225  แก้ไขการ Update Data  */
/*modify by : Ranu I. A61-0045  แก้ไขการเคลียร์ข้อมูลงานต่ออายุ  */
/*modify by : Sarinya C. A63-0210 เปลี่ยนแปลง Layout Text โดยเพิ่ม field  ต่อท้ายจากเดิม  */
/*Modify by : Ranu I. A64-0092 แก้ไขการเก็บ อุปกรณ์เสริม */
/*Modify by : kridtiya i. A65-0361 date. 29/11/2022 CODE B3DM000007 / B3M0035 กล่องตรวจสภาพรถ ต้องเข้า BRANCH    Dealer Business 1 */
/*Modify by : kridtiya i. A65-0356 date. 07/01/2023 lay out new ขยายขนาด และเพิ่ม ฟิล์ด*/
/*Modify by : kridtiya i. A66-0160 date. 15/08/2023 ปรับการแสดงชื่อสาขาจากพารามิเตอร์  */
/*Modify by : Ranu I. A67-0087 เพิ่มการเก็บข้อมูลรถไฟฟ้า */
/*Modify by : Ranu I. A67-0114 เพิ่มการเก็บข้อมูลเลขใบขับขี่ เลขบัตรในถังพัก และเพิ่มการเคลียร์ค่าวันที่ออกงานกรณีมีการแจ้งงานปีต่ออายุ*/
/*+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF     SHARED VAR n_User    AS CHAR.  /*A60-0118*/
DEF     SHARED VAR n_Passwd  AS CHAR.  /*A60-0118*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
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
    FIELD colorcode    AS CHAR FORMAT "X(25)"  INIT ""   /*11 Color Code*/
    FIELD licence      AS CHAR FORMAT "X(20)"  INIT ""   /*12 หมายเลขทะเบียนรถ */
    FIELD garage       AS CHAR FORMAT "X(01)"  INIT ""   /*13 Claim condition /การซ่อม */
    FIELD fleetper     AS CHAR FORMAT "X(05)"  INIT ""   /*14 Fleet Discount     */
    FIELD ncbper       AS CHAR FORMAT "X(05)"  INIT ""   /*15 Experience Discount /ส่วนลดประวัติดี  */
    FIELD othper       AS CHAR FORMAT "X(05)"  INIT ""   /*16 Other Discount /ส่วนลดอื่น ๆ  */
    FIELD vehuse       AS CHAR FORMAT "X(01)"  INIT ""   /*17 การใช้งานรถ */
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
    /*add kridtiya i. A54-0061..*/
/*47*/ FIELD addr2_70     AS CHAR FORMAT "X(60)"  INIT ""  
/*48*/ FIELD nsub_dist70  AS CHAR FORMAT "X(30)"  INIT ""  
/*49*/ FIELD ndirection70 AS CHAR FORMAT "X(30)"  INIT ""  
/*50*/ FIELD nprovin70    AS CHAR FORMAT "X(30)"  INIT ""  
/*51*/ FIELD zipcode70    AS CHAR FORMAT "X(5)"   INIT ""  
/*52*/ FIELD addr1_72     AS CHAR FORMAT "X(50)"  INIT ""  
/*53*/ FIELD addr2_72     AS CHAR FORMAT "X(60)"  INIT ""  
/*54*/ FIELD nsub_dist72  AS CHAR FORMAT "X(30)"  INIT ""  
/*55*/ FIELD ndirection72 AS CHAR FORMAT "X(30)"  INIT ""  
/*56*/ FIELD nprovin72    AS CHAR FORMAT "X(30)"  INIT ""  
/*57*/ FIELD zipcode72    AS CHAR FORMAT "X(5)"   INIT ""  
/*58*/ FIELD apptyp       AS CHAR FORMAT "X(10)"  INIT ""  
/*59*/ FIELD appcode      AS CHAR FORMAT "X(2)"   INIT ""  
/*60*/ FIELD nBLANK1      AS CHAR FORMAT "X(9)"   INIT ""   
/*61*/ FIELD nBLANK2      AS CHAR FORMAT "X(9)"   INIT ""   /*a63-0210*/
    /*add kridtiya i. A54-0061..*/
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
        /*--- A59-0178------*/
    FIELD comp_comdat   AS CHAR FORMAT "X(8)"  INIT ""     /*Effective Date Accidential*/           
    FIELD comp_expdat   AS CHAR FORMAT "X(8)"  INIT ""     /*Expiry Date Accidential*/              
    FIELD fi            AS CHAR FORMAT "X(11)" INIT ""     /*Coverage Amount Theft*/                
    FIELD class         AS CHAR FORMAT "X(3)"  INIT ""     /*Car code*/                             
    FIELD usedtype      AS CHAR FORMAT "x(1)"  INIT ""     /*Per Used*/                             
    FIELD driveno1      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq1*/                          
    FIELD drivename1    AS CHAR FORMAT "x(40)" INIT ""     /*Driver Name1*/                         
    FIELD bdatedriv1    AS CHAR FORMAT "x(8)"  INIT ""     /*Birthdate Driver1*/                    
    FIELD occupdriv1    AS CHAR FORMAT "x(75)" INIT ""     /*Occupation Driver1*/                   
    FIELD positdriv1    AS CHAR FORMAT "X(40)" INIT ""     /*Position Driver1 */                    
    FIELD driveno2      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq2*/                          
    FIELD drivename2    AS CHAR FORMAT "x(40)" INIT ""     /*Driver Name2*/                         
    FIELD bdatedriv2    AS CHAR FORMAT "x(8)"  INIT ""     /*Birthdate Driver2*/                    
    FIELD occupdriv2    AS CHAR FORMAT "x(75)" INIT ""     /*Occupation Driver2*/                   
    FIELD positdriv2    AS CHAR FORMAT "X(40)" INIT ""     /*Position Driver2*/                     
    FIELD driveno3      AS CHAR FORMAT "x(2)"  INIT ""     /*Driver Seq3*/                          
    FIELD drivename3    AS CHAR FORMAT "x(40)" INIT ""     /*Driver Name3*/                         
    FIELD bdatedriv3    AS CHAR FORMAT "x(8)"  INIT ""     /*Birthdate Driver3*/                    
    FIELD occupdriv3    AS CHAR FORMAT "x(75)" INIT ""     /*Occupation Driver3*/                   
    FIELD positdriv3    AS CHAR FORMAT "X(40)"   INIT ""   /*Position Driver3*/        
    FIELD caracc        AS CHAR FORMAT "x(1750)" INIT ""   /*A63-0210*/
    FIELD Rec_name72    AS CHAR FORMAT "x(150)"  INIT ""   /*A63-0210*/
    FIELD Rec_add1      AS CHAR FORMAT "x(60)"   INIT ""   /*A63-0210*/
    FIELD Rec_add2      AS CHAR FORMAT "x(60)"   INIT ""   /*A63-0210*/
    FIELD Reciept72     AS CHAR FORMAT "x(60)"   INIT ""   /*A63-0210*/
    FIELD acctyp        AS CHAR FORMAT "x(1)"    INIT ""   /*A65-0356*/
    FIELD acccovins     AS CHAR FORMAT "x(20)"   INIT ""   /*A65-0356*/
    FIELD accpremt      AS CHAR FORMAT "x(20)"   INIT ""   /*A65-0356*/
    FIELD inspecttyp    AS CHAR FORMAT "x(1)"    INIT ""   /*A65-0356*/
    FIELD quotation     AS CHAR FORMAT "x(20)"   INIT ""   /*A65-0356*/
    FIELD covcodtype    AS CHAR FORMAT "x(1)"    INIT ""   /*A65-0356*/
    /* A67-0087 */
    FIELD Schanel    AS Char FORMAT "X(1)"   init "" 
    FIELD bev        AS Char FORMAT "X(1)"   init "" 
    FIELD driveno4   AS CHAR FORMAT "x(2)"   INIT "" 
    FIELD drivename4 AS Char FORMAT "X(40)"  init "" 
    FIELD bdatedriv4 AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD occupdriv4 AS Char FORMAT "X(75)"  init "" 
    FIELD positdriv4 AS Char FORMAT "X(40)"  init "" 
    FIELD driveno5   AS CHAR FORMAT "x(2)"   INIT ""  
    FIELD drivename5 AS Char FORMAT "X(40)"  init "" 
    FIELD bdatedriv5 AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD occupdriv5 AS Char FORMAT "X(75)"  init "" 
    FIELD positdriv5 AS Char FORMAT "X(40)"  init "" 
    FIELD campagin   AS Char FORMAT "X(20)"  init "" 
    FIELD inspic     AS Char FORMAT "X(1)"   init "" 
    FIELD engcount   AS Char FORMAT "X(2)"   init "" 
    FIELD engno2     AS Char FORMAT "X(35)"  init "" 
    FIELD engno3     AS Char FORMAT "X(35)"  init "" 
    FIELD engno4     AS Char FORMAT "X(35)"  init "" 
    FIELD engno5     AS Char FORMAT "X(35)"  init "" 
    FIELD classcomp  AS Char FORMAT "X(5)"   init ""  
    FIELD carbrand   AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD polnissan  AS CHAR FORMAT "x(15)"  INIT "" .
   /* end : A67-0087 */
/*------------------------------ข้อมูลผู้ขับขี่ -------------------------*/
DEFINE WORKFILE  wdriver NO-UNDO
    FIELD RecordID     AS CHAR FORMAT "X(02)"   INIT ""     /*1 Detail Record "D"*/
    FIELD Pro_off      AS CHAR FORMAT "X(20)"   INIT ""     /*2 รหัสสาขาที่ผู้เอาประกันเปิดบัญชี    */
    FIELD chassis      AS CHAR FORMAT "X(25)"   INIT ""     /*3 หมายเลขตัวถัง    */
    FIELD dri_no       AS CHAR FORMAT "X(02)"   INIT ""     /*4 ลำดับที่คนขับ  */
    FIELD dri_name     AS CHAR FORMAT "X(40)"   INIT ""     /*5 ชื่อคนขับ   */
    FIELD Birthdate    AS CHAR FORMAT "X(10)"   INIT ""     /*6 วันเดือนปีเกิด  */
    FIELD occupn       AS CHAR FORMAT "X(75)"   INIT ""     /*7 อาชีพ*/
    FIELD position     AS CHAR FORMAT "X(40)"   INIT ""  .  /*8 ตำแหน่งงาน */
DEF  STREAM nfile.  
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_notdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_nottim   AS Char   Format "X(8)"         no-undo.
DEF VAR nv_comchr   AS CHAR   . 
DEF VAR nv_dd       AS INT    FORMAT "99".
DEF VAR nv_mm       AS INT    FORMAT "99".
DEF VAR nv_yy       AS INT    FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI   INIT 0.
DEF VAR nv_cpamt2   AS DECI   INIT 0.
DEF VAR nv_cpamt3   AS DECI   INIT 0   format  ">,>>>,>>9.99".
DEF VAR nv_coamt1   AS DECI   INIT 0.  
DEF VAR nv_coamt2   AS DECI   INIT 0.  
DEF VAR nv_coamt3   AS DECI   INIT 0   format ">,>>>,>>9.99".
DEF VAR nv_insamt1  AS DECI   INIT 0.  
DEF VAR nv_insamt2  AS DECI   INIT 0.  
DEF VAR nv_insamt3  AS DECI   INIT 0   Format  ">>,>>>,>>9.99".
DEF VAR nv_premt1   AS DECI   INIT 0.  
DEF VAR nv_premt2   AS DECI   INIT 0.  
DEF VAR nv_premt3   AS DECI   INIT 0   Format ">,>>>,>>9.99".
DEF VAR nv_fleet1   AS DECI   INIT 0.  
DEF VAR nv_fleet2   AS DECI   INIT 0.  
DEF VAR nv_fleet3   AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_ncb1     AS DECI   INIT 0.  
DEF VAR nv_ncb2     AS DECI   INIT 0.  
DEF VAR nv_ncb3     AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_oth1     AS DECI   INIT 0.  
DEF VAR nv_oth2     AS DECI   INIT 0.  
DEF VAR nv_oth3     AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_deduct1  AS DECI   INIT 0.  
DEF VAR nv_deduct2  AS DECI   INIT 0.  
DEF VAR nv_deduct3  AS DECI   INIT 0   Format ">>9.99".
DEF VAR nv_power1   AS DECI   INIT 0.  
DEF VAR nv_power2   AS DECI   INIT 0.  
DEF VAR nv_power3   AS DECI   INIT 0   Format ">,>>9.99".
DEF VAR nv_name1    AS CHAR   INIT  ""  Format "X(50)".
DEF VAR nv_ntitle   AS CHAR   INIT  ""  Format  "X(10)". 
DEF VAR nv_titleno  AS INT    INIT  0   .  
DEF VAR nv_policy   AS CHAR   INIT  ""  Format  "X(12)".
DEF VAR nv_oldpol   AS CHAR   INIT  ""  .
def var nv_source   as char   FORMAT  "X(35)".
def var nv_indexno  as int    init  0.
def var nv_indexno1 as int    init  0.
def var nv_cnt      as int    init  1.
def var nv_addr     as char   extent 4  format "X(35)".
def var nv_pol      as char   init  "".
def var nv_newpol   as char   init  "".
DEF VAR nn_remark1  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark2  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark3  AS CHAR INIT "".   /*A56-0399*/
DEF VAR nn_remark4  AS CHAR INIT "".   /*A63-0210*/
DEF VAR nv_len      AS INTE INIT 0.    /*A56-0399*/
DEF VAR nv_72comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.      /*- A59-0178-*/
DEF VAR nv_72expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.      /*- A59-0178-*/
DEF VAR nv_fi       AS CHAR FORMAT "x(15)" INIT "". /*A60-0225*/
/* Ranu i. inspection A60-0118           */
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
def  var nv_extref       as char.
DEF VAR nv_msgstatus  as char.  
DEF VAR nv_idnolist   as char.
DEF VAR nv_CheckLog   as CHAR.   
DEF VAR nv_idnolist2  AS CHAR.
DEF VAR nv_hobr  AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_imptxt

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt tlt.policy tlt.ins_name tlt.lince1 ~
tlt.cha_no tlt.expodat ~
IF index(tlt.model,"Detail")  <> 0 THEN ("YES") ELSE ("NO") ~
substr(brstat.tlt.model,1,50) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt 
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_compa ra_txttyp fi_producer ~
fi_filename bu_ok br_imptxt bu_exit bu_file bu_hpacno1 ra_txttyp2 fi_insp ~
RECT-1 RECT-79 RECT-80 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compa ra_txttyp fi_producer ~
fi_filename fi_proname fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet ~
ra_txttyp2 fi_insp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dir_cnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dri_complet AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 58.17 BY 1
     BGCOLOR 18 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_txttyp AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Detail Notification", 1,
"Detail Driver", 2
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_txttyp2 AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "ป้ายแดง     ", 1,
"ต่ออายุ ", 2
     SIZE 50 BY .95
     BGCOLOR 18 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 127 BY 8.

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-80
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.91
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      tlt.policy FORMAT "x(16)":U WIDTH 13.17
      tlt.ins_name FORMAT "x(50)":U WIDTH 31.67
      tlt.lince1 FORMAT "x(12)":U WIDTH 14.17
      tlt.cha_no FORMAT "x(25)":U WIDTH 26
      tlt.expodat FORMAT "99/99/99":U WIDTH 12.5
      IF index(tlt.model,"Detail")  <> 0 THEN ("YES") ELSE ("NO") COLUMN-LABEL "ตรวจสภาพ" FORMAT "X(10)":U
            WIDTH 8.83
      substr(brstat.tlt.model,1,50) COLUMN-LABEL "เลขที่ตรวจสภาพ" FORMAT "X(30)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 127.83 BY 15
         BGCOLOR 15  ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 1.52 COL 38 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.52 COL 72 COLON-ALIGNED NO-LABEL
     ra_txttyp AT ROW 2.57 COL 40.5 NO-LABEL
     fi_producer AT ROW 4.71 COL 38 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 5.81 COL 38 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.62 COL 99.5
     br_imptxt AT ROW 9.48 COL 2.67
     bu_exit AT ROW 7.67 COL 110.83
     fi_proname AT ROW 4.71 COL 60.33 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 5.81 COL 116.33
     fi_impcnt AT ROW 6.95 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 6.95 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 8.05 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 8.05 COL 75.17 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 4.71 COL 57.83
     ra_txttyp2 AT ROW 3.62 COL 40.5 NO-LABEL
     fi_insp AT ROW 3.52 COL 90.5 COLON-ALIGNED NO-LABEL
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.95 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 8.05 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.52 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.95 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 6.95 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.81 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6.95 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "ปีที่ค้นหาและเพิ่มข้อมูลของกล่อง Inspection" VIEW-AS TEXT
          SIZE 34 BY .62 AT ROW 2.86 COL 92.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "                   เลือกข้อมูลนำเข้า  :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 2.57 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "               ประเภทข้อมูลนำเข้า  :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 3.62 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Day:20/02/2023" VIEW-AS TEXT
          SIZE 21 BY .95 AT ROW 1.48 COL 107.5 WIDGET-ID 2
          BGCOLOR 8 
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.52 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "        ข้อมูลผู้ขับขี่นำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 8.05 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                    รหัส Producer  :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.71 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 8.05 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 8.05 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.05 COL 1.5
     RECT-79 AT ROW 7.14 COL 98
     RECT-80 AT ROW 7.19 COL 109.83
     RECT-380 AT ROW 1.29 COL 3.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.19
         BGCOLOR 3 .


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
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Import text file TISCO(ป้ายแดง/งานต่ออายุ)"
         HEIGHT             = 24.19
         WIDTH              = 133
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
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("WIMAGE/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_imptxt bu_ok fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dir_cnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_complet IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.policy
"tlt.policy" ? ? "character" ? ? ? ? ? ? no ? no no "13.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "31.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.lince1
"tlt.lince1" ? "x(12)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.cha_no
"tlt.cha_no" ? "x(25)" "character" ? ? ? ? ? ? no ? no no "26" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.expodat
"tlt.expodat" ? ? "date" ? ? ? ? ? ? no ? no no "12.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"IF index(tlt.model,""Detail"")  <> 0 THEN (""YES"") ELSE (""NO"")" "ตรวจสภาพ" "X(10)" ? ? ? ? ? ? ? no ? no no "8.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > "_<CALC>"
"substr(brstat.tlt.model,1,50)" "เลขที่ตรวจสภาพ" "X(30)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import text file TISCO(ป้ายแดง/งานต่ออายุ) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import text file TISCO(ป้ายแดง/งานต่ออายุ) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close" To  This-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
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
        DISP fi_filename WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    ASSIGN 
        nv_daily   =  ""
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    FOR EACH wdriver.
        DELETE wdriver.
    END.
    IF  ra_txttyp  =   1  Then 
          Run  Import_notification.    /*ไฟล์แจ้งงาน กรมธรรม์*/
    Else  Run  Import_driver.        /*ไฟล์แจ้งงานชื่อผู้ขับขี่ */
    RELEASE brstat.tlt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa C-Win
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa =  INPUT  fi_compa.
    Disp  fi_compa   WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insp C-Win
ON LEAVE OF fi_insp IN FRAME fr_main
DO:
    fi_insp = INPUT fi_insp.
    IF fi_insp > STRING(YEAR(TODAY),"9999")  THEN DO:
        MESSAGE "ปีที่ระบุมากกว่าปีปัจจุบัน !! " VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_insp.
        RETURN NO-APPLY.
    END.
    DISP fi_insp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp fi_loaddat  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    /*
    If  Input  fi_producer  =  ""  Then do:
       Message "กรุณาระบุรหัสผู้หางาน "  View-as alert-box.
       Apply "Entry" to fi_producer.
       End.
    */
    If Input  fi_producer  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_producer    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "Entry" To  fi_producer.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_proname =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
    fi_producer =  INPUT  fi_producer.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_txttyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON ENTER OF ra_txttyp IN FRAME fr_main
DO:
  Apply "Entry" to fi_producer.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON VALUE-CHANGED OF ra_txttyp IN FRAME fr_main
DO:
  ra_txttyp  =  Input  ra_txttyp.
  Disp  ra_txttyp  with  frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_txttyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp2 C-Win
ON ENTER OF ra_txttyp2 IN FRAME fr_main
DO:
  Apply "Entry" to fi_producer.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp2 C-Win
ON VALUE-CHANGED OF ra_txttyp2 IN FRAME fr_main
DO:
  ra_txttyp2  =  Input  ra_txttyp2.
  Disp  ra_txttyp2  with  frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_imptxt
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


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
  
  gv_prgid = "wgwimtis".
  gv_prog  = "Import Text File to open policy (บริษัท เงินทุน ทิสโก้ จำกัด (มหาชน) ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "TISCO"
      fi_producer = "B3M0003"
      ra_txttyp   = 1 
      ra_txttyp2  = 1 
      fi_insp     = STRING(YEAR(TODAY),"9999"). /* ranu insp */
  disp  fi_loaddat  fi_producer ra_txttyp fi_compa fi_insp with  frame  fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Create_tlt C-Win 
PROCEDURE 00-Create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  comment by A67-0087     
------------------------------------------------------------------------------*/
/*LOOP_wdetail:
FOR EACH wdetail .
  ASSIGN   
  nv_policy  = ""     nv_oldpol  = ""
  nv_comdat  = ?      nv_expdat  = ?   nv_accdat  =  ?      
  nv_comchr  = ""     nv_addr    = ""  nv_name1   =  ""
  nv_ntitle  = ""     nv_titleno = 0   nv_policy  =  ""
  nv_dd      = 0      nv_mm      = 0   nv_yy      =  0
  nv_cpamt1  = 0      nv_cpamt2  = 0   nv_cpamt3  =  0
  nv_coamt1  = 0      nv_coamt2  = 0   nv_coamt3  =  0         
  nv_insamt1 = 0      nv_insamt2 = 0   nv_insamt3 =  0
  nv_premt1  = 0      nv_premt2  = 0   nv_premt3  =  0
  nv_ncb1    = 0      nv_ncb2    = 0   nv_ncb3    =  0
  nv_fleet1  = 0      nv_fleet2  = 0   nv_fleet3  =  0
  nv_oth1    = 0      nv_oth2    = 0   nv_oth3    =  0
  nv_deduct1 = 0      nv_deduct2 = 0   nv_deduct3 =  0
  nv_power1  = 0      nv_power2  = 0   nv_power3  =  0
  nv_newpol  = ""     nv_72comdat  = ?   nv_72expdat  =  ?        
  nv_reccnt  = nv_reccnt + 1
  wdetail.engine = REPLACE(wdetail.engine,"*","").
  wdetail.nBLANK1 = REPLACE(wdetail.nBLANK1," ",""). 
  IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    
  ELSE ASSIGN nn_remark1  = trim(wdetail.remark)          
       nn_remark2  = ""           
       nn_remark3  = ""     .  
  IF trim(wdetail.nBLANK1) <> "" THEN nn_remark4 = TRIM(wdetail.nblank1).
  ELSE nn_remark4 = "" .
  IF ( wdetail.Notify_no = "" ) AND (ra_txttyp2 = 1 ) THEN MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
  ELSE DO:
      IF wdetail.prev_pol <> "" THEN RUN pol_cutchar.
      nv_oldpol  =  wdetail.prev_pol.
      nv_policy  =  nv_oldpol.         
      IF (wdetail.not_date <> "" ) AND (wdetail.not_date <> "00000000") THEN ASSIGN nv_notdat  = DATE(wdetail.not_date).                       
      IF (wdetail.comdat   <> "" ) AND (wdetail.comdat   <> "00000000") THEN ASSIGN nv_comdat  = DATE(wdetail.comdat). 
      IF (wdetail.expdat   <> "" ) AND (wdetail.expdat   <> "00000000") THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
      If (wdetail.not_time <> "" ) AND (wdetail.not_time <> "000000")   Then   
            ASSIGN nv_nottim   =  substr(wdetail.not_time,1,2) + ":" + substr(wdetail.not_time,4,2) + ":" + substr(wdetail.not_time,7,2).  
      IF (wdetail.comp_expdat <>  "" ) AND  (wdetail.comp_expdat   <> "00000000")  THEN ASSIGN nv_72expdat  = DATE(wdetail.comp_expdat).
      IF (wdetail.comp_comdat <>  "" ) AND  (wdetail.comp_comdat   <> "00000000")  THEN ASSIGN nv_72comdat  = DATE(wdetail.comp_comdat).
      nv_insamt3 = DECIMAL(wdetail.ins_amt). 
      nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
      IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
      ELSE nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
      nv_premt3 = nv_premt1 + nv_premt2.
      nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
      nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
      IF nv_coamt1 < 0 THEN nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
      ELSE nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
      nv_coamt3 = nv_coamt1 + nv_coamt2.
      nv_fleet1 = DECIMAL(SUBSTRING(wdetail.fleetper,1,3)).
      IF nv_fleet1 < 0 THEN nv_fleet2 = (DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) * -1) / 100.
      ELSE nv_fleet2 = DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) / 100.
      nv_fleet3 = nv_fleet1 + nv_fleet2.
      nv_ncb1 = DECIMAL(SUBSTRING(wdetail.ncbper,1,3)).
      IF nv_ncb1 < 0 THEN nv_ncb2 = (DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) * -1) / 100.
      ELSE nv_ncb2 = DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) / 100.
      nv_ncb3 = nv_ncb1 + nv_ncb2.
      nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
      IF nv_oth1 < 0 THEN nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
      ELSE nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
      nv_oth3 = nv_oth1 + nv_oth2.
      nv_deduct1 = DECIMAL(SUBSTRING(wdetail.othper,1,7)).
      IF nv_deduct1 < 0 THEN nv_deduct2 = (DECIMAL(SUBSTRING(wdetail.deduct,8,2)) * -1) / 100.
      ELSE nv_deduct2 = DECIMAL(SUBSTRING(wdetail.deduct,8,2)) / 100.
      nv_deduct3 = nv_deduct1 + nv_deduct2.         
      nv_power1 = DECIMAL(SUBSTRING(wdetail.power,1,5)).
      IF nv_power1 < 0 THEN nv_power2 = (DECIMAL(SUBSTRING(wdetail.power,6,2)) * -1) / 100.
      ELSE nv_power2 = DECIMAL(SUBSTRING(wdetail.power,6,2)) / 100.
      nv_power3 = nv_power1 + nv_power2. 
      ASSIGN nv_CheckLog  = "no".        /*Check susspect no ไม่ติด yes ติด*/
      RUN proc_susspect (INPUT trim(wdetail.pol_fname)
                        ,INPUT trim(wdetail.pol_lname) 
                        ,INPUT trim(wdetail.licence) + " " + trim(wdetail.province)   
                        ,INPUT trim(wdetail.chassis)).  
      FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   
          brstat.tlt.cha_no    = trim(wdetail.chassis)  AND
          brstat.tlt.eng_no    = TRIM(wdetail.engine)   AND   
          brstat.tlt.genusr    = fi_compa               NO-ERROR NO-WAIT .
      IF NOT AVAIL brstat.tlt THEN DO:    
          CREATE brstat.tlt.
          nv_completecnt  =  nv_completecnt + 1.
          ASSIGN                                                 
          brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
          brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
          brstat.tlt.trndat        = fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */    /*date   99/99/9999*/
          brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")         /* char   x(8)       */
          brstat.tlt.policy        = nv_newpol                       /* กรมธรรม์ใหม่แต่จะแปลงเป็น format ของ safety */
          brstat.tlt.filler1       = nv_oldpol                       /* กรมธรรม์เก่าที่จะต่ออายุ  */
          brstat.tlt.rec_addr5     = nv_policy                       /* เบอร์กรมธรรม์เก่าที่แปลงเป็น format safety */
          brstat.tlt.nor_noti_ins  = ""                              /* เบอร์กรมธรรม์ใหม่ */ /*A61-0045*/
          brstat.tlt.rec_addr3     = trim(wdetail.pro_off)           /*01..รหัสสาขาที่ผู้เอาประกันเปิดบัญชี  char   x(2)*/
          brstat.tlt.rec_addr4     = trim(wdetail.cmr_code)          /*02..รหัสเจ้าหน้าที่การตลาด  char  x(3) */
          brstat.tlt.subins        = trim(wdetail.comp_code)         /*03..char  x(5)      รหัสยอ่ยบิรษัท */
          brstat.tlt.nor_noti_tlt  = trim(wdetail.notify_no)         /* char  25   เบอร์กรมธรรมุใหม่  */
          brstat.tlt.lince2        = trim(wdetail.yrmanu)            /*04..char x(4)         ปีรถ  */
          brstat.tlt.eng_no        = trim(wdetail.engine)             /* char   x(20)      Engine no.             */
          brstat.tlt.cha_no        = TRIM(wdetail.chassis)           /*char   x(20)      Chassis no.            */
          brstat.tlt.cc_weight     = INTEGER(wdetail.weight)         /* inte   >>,>>9     CC./weight(นน.กิโล)    */
          brstat.tlt.rencnt        = nv_power3                       /*  inte   tons    */
          brstat.tlt.colorcod      = trim(wdetail.colorcode)         
          brstat.tlt.lince1        = trim(wdetail.licence)           
          brstat.tlt.stat          = trim(wdetail.garage)            
          brstat.tlt.lotno         = String(nv_fleet3)               /*char         */
          brstat.tlt.seqno         = nv_ncb3                         
          brstat.tlt.endcnt        = nv_oth3                         
          /*brstat.tlt.model         = trim(wdetail.vehuse) */           /*  ลักษณะการใช้รถ    */      /*A60-0118*/                
          brstat.tlt.gendat        = nv_comdat                       
          brstat.tlt.nor_coamt     = nv_insamt3                      /*  ทุนประกันรถ  */      
          brstat.tlt.nor_usr_ins   = trim(wdetail.name_insur)        /*  ชื่อเจ้าหน้าที่ประกันของบริษัทรับประกัน  */
          brstat.tlt.nor_usr_tlt   = trim(wdetail.not_office)        /*  รหัสเจ้าหน้าที่แจ้งประกันของ Tisco */       
          brstat.tlt.datesent      = nv_notdat                       /*  วันที่แจ้งประกัน */ 
          brstat.tlt.gentim        = nv_nottim                       /* เวลาที่แจ้งประกัน */ 
          brstat.tlt.comp_usr_tlt  = trim(wdetail.not_code)          /*  รหัสแจ้งงาน      */ 
          brstat.tlt.nor_grprm     = nv_premt3                       /* deci-2 9(13)     เบี้ยป.1+ภาษี+อากร     */
          brstat.tlt.comp_grprm    = nv_cpamt3                       /* deci-2 9(13)   เบี้ยพรบ.       */               
          brstat.tlt.comp_sck      = trim(wdetail.sckno)             /* char x(26)     เลขที่  Sticker     */
          brstat.tlt.brand         = trim(wdetail.brand)             /* char   x(3)       Car Brand Code         */
          brstat.tlt.ins_addr1     = trim(wdetail.pol_addr1)         /* char   x(35)    Ins.Address1 /ที่อยู่ผู้เอาประกัน 1*/
          brstat.tlt.ins_addr2     = trim(wdetail.pol_addr2)         /* char   x(35)   Ins.Address1 /ที่อยู่ผู้เอาประกัน 2*/
          brstat.tlt.rec_name      = trim(wdetail.pol_title)               
          brstat.tlt.ins_name      = Trim(wdetail.pol_fname) + " "  +  Trim(wdetail.pol_lname)
          brstat.tlt.safe1         = trim(wdetail.ben_name)
          brstat.tlt.filler2       = trim(nn_remark1) + " r2:" + trim(nn_remark2) + " r3:" + trim(nn_remark3) + " acc:" + trim(nn_remark4) /*A64-0092*/
          brstat.tlt.safe2         = trim(wdetail.account_no)
          brstat.tlt.safe3         = trim(wdetail.client_no)                 
          brstat.tlt.expodat       = nv_expdat                         
          brstat.tlt.comp_coamt    = nv_coamt3                       /*  เบี้ยรวมป. 1 + เบี้ยรวมพรบ. */
          brstat.tlt.lince3        = trim(wdetail.province)          /*char   x(2)       จว.จดทะเบียน           */
          brstat.tlt.rec_addr1     = trim(wdetail.receipt_name)              
          brstat.tlt.recac         = trim(wdetail.agent2)
          brstat.tlt.rec_addr2     = trim(wdetail.prev_insur)
          brstat.tlt.ins_addr3     = TRIM(wdetail.addr1_70)     + " " + 
                                     TRIM(wdetail.addr2_70)     + " " + 
                                     TRIM(wdetail.nsub_dist70)  + " " + 
                                     TRIM(wdetail.ndirection70) + " " + 
                                     TRIM(wdetail.nprovin70)    + " " + 
                                     TRIM(wdetail.zipcode70)          
          brstat.tlt.ins_addr4     = TRIM(wdetail.addr1_72)     + " " + 
                                     TRIM(wdetail.addr2_72)     + " " + 
                                     TRIM(wdetail.nsub_dist72)  + " " + 
                                     TRIM(wdetail.ndirection72) + " " +
                                     TRIM(wdetail.nprovin72)    + " " + 
                                     TRIM(wdetail.zipcode72)           
          brstat.tlt.ins_addr5     = trim(wdetail.apptyp)
          brstat.tlt.comp_noti_tlt = trim(wdetail.appcode) 
          /*brstat.tlt.usrsent       = trim(wdetail.nBLANK) */
          brstat.tlt.usrsent       = nv_CheckLog   /*เก็บค่า Susspect */
          brstat.tlt.expotim       = caps(trim(wdetail.pack)) + " " + TRIM(wdetail.class)              
          brstat.tlt.old_eng       = trim(wdetail.tp1)              
          brstat.tlt.old_cha       = trim(wdetail.tp2)              
          brstat.tlt.comp_pol      = trim(wdetail.tp3)              
          brstat.tlt.expousr       = trim(wdetail.covcod)           
          brstat.tlt.comp_sub      = trim(wdetail.producer)          
          brstat.tlt.comp_noti_ins = trim(wdetail.agent)            
          brstat.tlt.exp           = caps(trim(wdetail.branch)) 
          brstat.tlt.flag          = IF ra_txttyp2 = 2 THEN "R"  ELSE "N"                              
          brstat.tlt.endno         = String(nv_deduct3)   
          brstat.tlt.sentcnt       = int(trim(wdetail.seatenew))      /*A57-0017*/
          brstat.tlt.comp_usr_tlt  = "ID70:"    + trim(wdetail.id_no70)   + /*A57-0262*/ 
                                     "ID70br:"  + trim(wdetail.id_nobr70) + /*A57-0262*/
                                     "ID72:"    + trim(wdetail.id_no72)   + /*A57-0262*/  
                                     "ID72br:"  + trim(wdetail.id_nobr72)   /*A57-0262*/
          brstat.tlt.genusr        = "TISCO"                           
          brstat.tlt.usrid         = USERID(LDBNAME(1))                 /*User Load Data */
          brstat.tlt.imp           = "IM"                              /*Import Data*/
          brstat.tlt.releas        = "No" 
          brstat.tlt.nor_effdat    = nv_72comdat            /* วันคุ้มครอง พรบ. */ 
          brstat.tlt.comp_effdat   = nv_72expdat            /* วันสิ้นสุดคุ้มครอง พรบ. */ 
          SUBSTR(brstat.tlt.expousr,6,3)     = "|" + TRIM(wdetail.usedtype).
          IF brstat.tlt.flag = "N" AND wdetail.covcod = "1" AND trim(wdetail.yrmanu) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection.    
          IF brstat.tlt.flag = "R" AND wdetail.covcod = "1" AND index(brstat.tlt.rec_addr2,"SAFETY") = 0 THEN RUN proc_inspection.  
          ASSIGN SUBSTR(brstat.tlt.model,51,15)     = TRIM(wdetail.fi)     
          brstat.tlt.comp_usr_ins  = trim(wdetail.Rec_name72) + "a1:"  + trim(wdetail.Rec_add1) + "a2:"  + trim(wdetail.Rec_add2)   
          brstat.tlt.note1   = wdetail.acctyp       /*A65-0356*/ 
          brstat.tlt.note2   = wdetail.acccovins    /*A65-0356*/
          brstat.tlt.note3   = wdetail.accpremt     /*A65-0356*/
          brstat.tlt.note4   = wdetail.inspecttyp   /*A65-0356*/
          brstat.tlt.note5   = wdetail.quotation    /*A65-0356*/
          brstat.tlt.covcod  = wdetail.covcodtype . /*A65-0356*/

        END.
        ELSE DO: 
            nv_completecnt  =  nv_completecnt + 1.
            RUN Create_tlt2.
        END.
    END.  /*wdetail.Notify_no <> "" */
END.   /* FOR EACH wdetail NO-LOCK: */
Run Open_tlt.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Create_tlt2 C-Win 
PROCEDURE 00-Create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  comment by A67-0087     
------------------------------------------------------------------------------*/
/*ASSIGN                                                 
         brstat.tlt.entdat        = TODAY                          /* date  99/99/9999  */
         brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")        /* char  x(8)        */
         brstat.tlt.trndat        = fi_loaddat                     /* วันที่ไฟล์แจ้งงาน */    /*date   99/99/9999*/
         brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")        /* char   x(8)       */
         brstat.tlt.nor_noti_tlt  = trim(wdetail.notify_no)        /* char  25   เบอร์กรมธรรมุใหม่  */
         brstat.tlt.policy        = nv_newpol                      /* กรมธรรม์ใหม่แต่จะแปลงเป็น format ของ safety */
         brstat.tlt.filler1       = nv_oldpol                      /* กรมธรรม์เก่าที่จะต่ออายุ  */
         brstat.tlt.rec_addr5     = nv_policy                      /* เบอร์กรมธรรม์เก่าที่แปลงเป็น format safety */
         brstat.tlt.rec_addr3     = trim(wdetail.pro_off)          /* รหัสสาขาที่ผู้เอาประกันเปิดบัญชี  char   x(2)       */
         brstat.tlt.rec_addr4     = trim(wdetail.cmr_code)         /* รหัสเจ้าหน้าที่การตลาด  char  x(3)    */
         brstat.tlt.subins        = trim(wdetail.comp_code)        /* char  x(5)      รหัสยอ่ยบิรษัท     */
         brstat.tlt.lince2        = trim(wdetail.yrmanu)           /* char x(4)         ปีรถ  */
         brstat.tlt.eng_no        = trim(wdetail.engine)           /* char   x(20)      Engine no.             */
         brstat.tlt.cha_no        = TRIM(wdetail.chassis)          /*char   x(20)      Chassis no.            */
         brstat.tlt.cc_weight     = INTEGER(wdetail.weight)        /* inte   >>,>>9     CC./weight(นน.กิโล)    */
         brstat.tlt.rencnt        = nv_power3                      /*  inte   tons    */
         brstat.tlt.colorcod      = trim(wdetail.colorcode)        
         brstat.tlt.lince1        = trim(wdetail.licence)          
         brstat.tlt.stat          = trim(wdetail.garage)           
         brstat.tlt.lotno         = String(nv_fleet3)              /*char         */
         brstat.tlt.seqno         = nv_ncb3                        
         brstat.tlt.endcnt        = nv_oth3                        
         /*brstat.tlt.model         = trim(wdetail.vehuse)   */        /*  ลักษณะการใช้รถ    */  /*A60-0225*/
         /*brstat.tlt.gendat        = nv_comdat */ /*A60-0095*/                     
         /*brstat.tlt.nor_coamt     = nv_insamt3  */ /*A60-0225*/                   /*  ทุนประกันรถ  */      
         brstat.tlt.nor_usr_ins   = trim(wdetail.name_insur)       /*  ชื่อเจ้าหน้าที่ประกันของบริษัทรับประกัน  */
         brstat.tlt.nor_usr_tlt   = trim(wdetail.not_office)       /*  รหัสเจ้าหน้าที่แจ้งประกันของ Tisco */       
         /*brstat.tlt.datesent      = nv_notdat  */ /*A60-095*/                    /*  วันที่แจ้งประกัน */ 
         brstat.tlt.gentim        = nv_nottim                      /* เวลาที่แจ้งประกัน */ 
         brstat.tlt.comp_usr_tlt  = trim(wdetail.not_code)         /*  รหัสแจ้งงาน      */ 
         /*brstat.tlt.comp_sck      = trim(wdetail.sckno) */ /*A60-0095 */
         brstat.tlt.brand         = trim(wdetail.brand)            /* char   x(3)       Car Brand Code         */
         brstat.tlt.ins_addr1     = trim(wdetail.pol_addr1)        /* char   x(35)    Ins.Address1 /ที่อยู่ผู้เอาประกัน 1*/
         brstat.tlt.ins_addr2     = trim(wdetail.pol_addr2)        /* char   x(35)   Ins.Address1 /ที่อยู่ผู้เอาประกัน 2*/
         brstat.tlt.rec_name      = trim(wdetail.pol_title)        
         brstat.tlt.ins_name      = Trim(wdetail.pol_fname) + " "  +  Trim(wdetail.pol_lname)
         brstat.tlt.safe1         = trim(wdetail.ben_name)
         /*tlt.filler2            = trim(wdetail.remark)*/
         /*tlt.filler2            = trim(wdetail.remark)*/                                                /*kridtiya i. A56-0399*/
         /* comment by : A64-0092 ...
         brstat.tlt.filler2       = trim(nn_remark1) +                                                    /*kridtiya i. A56-0399*/
                                  ( IF trim(nn_remark2) <> "" THEN " r2:" + trim(nn_remark2) ELSE "" )  + /*kridtiya i. A56-0399*/
                                  ( IF trim(nn_remark3) <> "" THEN " r3:" + trim(nn_remark3) ELSE "" )  + /*kridtiya i. A56-0399*/
                                  ( IF trim(nn_remark4) <> "" THEN " r4:" + trim(nn_remark4) ELSE "" )    /*Sarinya C. A63-0210*/
         ... end A64-0092..*/
         brstat.tlt.filler2      = trim(nn_remark1) + " r2:" + trim(nn_remark2) + " r3:" + trim(nn_remark3) + " acc:" + trim(nn_remark4) /*A64-0092*/
         brstat.tlt.safe2         = trim(wdetail.account_no)                                              
         brstat.tlt.safe3         = trim(wdetail.client_no)                 
         /*brstat.tlt.expodat       = nv_expdat   */ /*A60-0095*/                  
         /*brstat.tlt.comp_coamt    = nv_coamt3   */ /*A60-0225*/               /*  เบี้ยรวมป. 1 + เบี้ยรวมพรบ. */
         brstat.tlt.lince3        = trim(wdetail.province)                /*char   x(2)       จว.จดทะเบียน           */
         brstat.tlt.rec_addr1     = trim(wdetail.receipt_name)              
         brstat.tlt.recac         = trim(wdetail.agent2)
         brstat.tlt.rec_addr2     = trim(wdetail.prev_insur)
         brstat.tlt.ins_addr3     = TRIM(wdetail.addr1_70)     + " " + 
                                    TRIM(wdetail.addr2_70)     + " " + 
                                    TRIM(wdetail.nsub_dist70)  + " " + 
                                    TRIM(wdetail.ndirection70) + " " + 
                                    TRIM(wdetail.nprovin70)    + " " + 
                                    TRIM(wdetail.zipcode70)          
         brstat.tlt.ins_addr4     = TRIM(wdetail.addr1_72)     + " " + 
                                    TRIM(wdetail.addr2_72)     + " " + 
                                    TRIM(wdetail.nsub_dist72)  + " " + 
                                    TRIM(wdetail.ndirection72) + " " +
                                    TRIM(wdetail.nprovin72)    + " " + 
                                    TRIM(wdetail.zipcode72)           
         brstat.tlt.ins_addr5     = trim(wdetail.apptyp)
         brstat.tlt.comp_noti_tlt = trim(wdetail.appcode) 
         /*brstat.tlt.usrsent       = trim(wdetail.nBLANK) */
         brstat.tlt.usrsent       = nv_CheckLog   /*เก็บค่า Susspect  A64-0092*/
         brstat.tlt.expotim       = caps(trim(wdetail.pack)) + " " + TRIM(wdetail.class)            
         brstat.tlt.old_eng       = trim(wdetail.tp1)              
         brstat.tlt.old_cha       = trim(wdetail.tp2)              
         brstat.tlt.comp_pol      = trim(wdetail.tp3)              
         brstat.tlt.expousr       = trim(wdetail.covcod)          
         brstat.tlt.comp_sub      = trim(wdetail.producer)          
         brstat.tlt.comp_noti_ins = trim(wdetail.agent)            
         brstat.tlt.exp           = caps(trim(wdetail.branch)) 
         brstat.tlt.flag          = IF ra_txttyp2 = 2 THEN "R"  ELSE "N"                              
         brstat.tlt.endno         = String(nv_deduct3)   
         brstat.tlt.sentcnt       = int(trim(wdetail.seatenew))      /*A57-0017*/
         brstat.tlt.comp_usr_tlt  = "ID70:"    + trim(wdetail.id_no70)   + /*A57-0262*/ 
                                    "ID70br:"  + trim(wdetail.id_nobr70) + /*A57-0262*/
                                    "ID72:"    + trim(wdetail.id_no72)   + /*A57-0262*/  
                                    "ID72br:"  + trim(wdetail.id_nobr72)   /*A57-0262*/
         brstat.tlt.genusr        = "TISCO"                           
         brstat.tlt.usrid         = USERID(LDBNAME(1))                 /*User Load Data */
         brstat.tlt.imp           = "IM"                              /*Import Data*/
         brstat.tlt.releas        = "No"
         /*brstat.tlt.nor_effdat    = DATE(wdetail.comp_comdat) */   /*A60-0095*/        /* วันคุ้มครอง พรบ. */ 
         /*brstat.tlt.comp_effdat   = DATE(wdetail.comp_expdat) */   /*A60-0095*/        /* วันสิ้นสุดคุ้มครอง พรบ. */ 
         /*SUBSTR(brstat.tlt.model,51,10) =   TRIM(wdetail.fi)  */  /*A60-0118*/
         SUBSTR(brstat.tlt.expousr,6,3) = "|" + TRIM(wdetail.usedtype)
         /*--- create by A59-0618 ---*/
         brstat.tlt.dri_name1  =   trim(wdetail.drivename1)
         brstat.tlt.dri_no1    =   STRING(wdetail.bdatedriv1)
         brstat.tlt.dri_name2  =   TRIM(wdetail.drivename2)
         brstat.tlt.dri_no2    =   STRING(wdetail.bdatedriv2) .
         /*--- end A59-0618 ---*/
         brstat.tlt.comp_usr_ins  = trim(wdetail.Rec_name72) +              /*A63-0210*/
                                    "a1:"  + trim(wdetail.Rec_add1)   +     /*A63-0210*/
                                    "a2:"  + trim(wdetail.Rec_add2)   .     /*A63-0210*/
         /*---- A61-0045 ------
         IF brstat.tlt.flag = "N" AND wdetail.covcod = "1" AND trim(wdetail.yrmanu) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection. /* A60-0118 */
         IF brstat.tlt.flag = "R" AND wdetail.covcod = "1" AND index(brstat.tlt.rec_addr2,"SAFETY") = 0 THEN RUN proc_inspection. /* A60-0118 */  
         ---- end A61-00045---*/
         /*ASSIGN SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi).  /*A60-0118*/  A60-0225*/

/*  IF nv_premt3 > 0  THEN  brstat.tlt.nor_grprm   = nv_premt3 .*/ /*A60-0095*/                       /* deci-2 9(13)     เบี้ยป.1+ภาษี+อากร     */
/*  IF nv_cpamt3 > 0  THEN  brstat.tlt.comp_grprm  = nv_cpamt3 .*/ /*A60-0095*/

/*---- Create by : Ranu I. A60-0085 -----*/
/*---------------- V70-------------------*/
 IF nv_premt3 > 0  THEN DO:
     IF YEAR(brstat.tlt.datesent) = YEAR(TODAY) THEN DO: /* A61-0045*/
        ASSIGN 
            brstat.tlt.nor_grprm = nv_premt3 
            brstat.tlt.expodat   = nv_expdat 
            brstat.tlt.gendat    = nv_comdat 
            brstat.tlt.nor_coamt = nv_insamt3                   /*A60-0225*/
            SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). /*A60-0225*/ 
     END.
     /* create by :  A61-0045*/
     ELSE DO:
         ASSIGN  brstat.tlt.nor_grprm           = nv_premt3 
                 brstat.tlt.expodat             = nv_expdat 
                 brstat.tlt.gendat              = nv_comdat         
                 brstat.tlt.nor_coamt           = nv_insamt3        
                 brstat.tlt.model               = ""
                 brstat.tlt.nor_noti_ins        = ""          
                 SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). 
     END.
     /*-- end A61-00045--*/
 END.
 ELSE DO:
     IF (brstat.tlt.nor_grprm <> 0 AND brstat.tlt.expodat <> ? ) AND YEAR(brstat.tlt.expodat) > YEAR(TODAY)  THEN DO:
         IF YEAR(brstat.tlt.datesent) = YEAR(TODAY) THEN DO:
             ASSIGN brstat.tlt.nor_grprm  = brstat.tlt.nor_grprm   
                    brstat.tlt.expodat    = brstat.tlt.expodat                                  /*A60-0225*/  
                    brstat.tlt.gendat     = brstat.tlt.gendat                                   /*A60-0225*/ 
                    brstat.tlt.nor_coamt  = brstat.tlt.nor_coamt                                /*A60-0225*/ 
                    SUBSTR(brstat.tlt.model,51,15) =  SUBSTR(brstat.tlt.model,51,15)  .         /*A60-0225*/ 
                     /*brstat.tlt.expodat   = nv_expdat   */ /*A60-0225*/
                     /*brstat.tlt.gendat    = nv_comdat . */ /*A60-0225*/
         END.
         ELSE DO:
             ASSIGN  brstat.tlt.nor_grprm           = nv_premt3 
                     brstat.tlt.expodat             = nv_expdat 
                     brstat.tlt.gendat              = nv_comdat         
                     brstat.tlt.nor_coamt           = nv_insamt3        /*A60-0225*/
                     brstat.tlt.model               = ""                /*A61-0045*/
                     brstat.tlt.nor_noti_ins        = ""               /* เบอร์กรมธรรม์ใหม่ */  /*A61-0045*/
                     SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). /*A60-0225*/ 
         END.
                        
     END.
     ELSE DO:
         ASSIGN  brstat.tlt.nor_grprm           = nv_premt3 
                 brstat.tlt.expodat             = nv_expdat 
                 brstat.tlt.gendat              = nv_comdat
                 brstat.tlt.nor_coamt           = nv_insamt3        /*A60-0225*/
                 brstat.tlt.model               = ""                /*A61-0045*/
                 brstat.tlt.nor_noti_ins        = ""                /* เบอร์กรมธรรม์ใหม่ */  /*A61-0045*/
                 SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). /*A60-0225*/
     END.
 END.
 /*---- A61-0045 ------*/
 
 IF brstat.tlt.flag = "N" AND wdetail.covcod = "1" AND trim(wdetail.yrmanu) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection. 
 IF brstat.tlt.flag = "R" AND wdetail.covcod = "1" AND index(brstat.tlt.rec_addr2,"SAFETY") = 0 THEN RUN proc_inspection. 
 /*---- end A61-00045---*/

 /*------------- V72 -----------------*/
 IF nv_cpamt3 > 0  THEN DO:  
     ASSIGN 
         brstat.tlt.comp_grprm  = nv_cpamt3 
         brstat.tlt.nor_effdat  = nv_72comdat   
         brstat.tlt.comp_effdat = nv_72expdat
         brstat.tlt.comp_sck    = IF LENGTH(trim(wdetail.sckno)) <> 13 THEN "0"+ TRIM(wdetail.sckno) ELSE trim(wdetail.sckno)   .
 END.
 ELSE DO:
     IF (brstat.tlt.comp_grprm <> 0 AND brstat.tlt.comp_effdat <> ? ) AND YEAR(brstat.tlt.comp_effdat) > YEAR(TODAY) THEN DO:
         IF YEAR(brstat.tlt.datesent) = YEAR(TODAY) THEN
             ASSIGN  brstat.tlt.comp_grprm  = brstat.tlt.comp_grprm    
                     brstat.tlt.nor_effdat  = brstat.tlt.nor_effdat   /*A60-0225*/ 
                     brstat.tlt.comp_effdat = brstat.tlt.comp_effdat  /*A60-0225*/ 
                     brstat.tlt.comp_sck    = brstat.tlt.comp_sck .   /*A60-0225*/ 
                     /*---comment by A60-0225-----------              
                     brstat.tlt.nor_effdat  = IF nv_72comdat <> ? THEN nv_72comdat ELSE brstat.tlt.nor_effdat
                     brstat.tlt.comp_effdat = IF nv_72expdat <> ? THEN nv_72expdat ELSE brstat.tlt.comp_effdat
                     brstat.tlt.comp_sck    = IF trim(wdetail.sckno) <> "" AND trim(wdetail.sckno) <> "0"  THEN TRIM(wdetail.sckno) 
                                              ELSE brstat.tlt.comp_sck .
                    ----------end A60-0225------------*/
         ELSE
             ASSIGN 
                 brstat.tlt.comp_grprm  = nv_cpamt3 
                 brstat.tlt.nor_effdat  = nv_72comdat   
                 brstat.tlt.comp_effdat = nv_72expdat
                 brstat.tlt.comp_sck    = trim(wdetail.sckno).
     END.
     ELSE
         ASSIGN 
         brstat.tlt.comp_grprm  = nv_cpamt3 
         brstat.tlt.nor_effdat  = nv_72comdat   
         brstat.tlt.comp_effdat = nv_72expdat
         brstat.tlt.comp_sck    = trim(wdetail.sckno).
 END.
 
 ASSIGN brstat.tlt.datesent   = nv_notdat
        brstat.tlt.comp_coamt = DECI(brstat.tlt.nor_grprm + brstat.tlt.comp_grprm)   /*A60-0225*/
        brstat.tlt.note1   = wdetail.acctyp       /*A65-0356*/ 
        brstat.tlt.note2   = wdetail.acccovins    /*A65-0356*/
        brstat.tlt.note3   = wdetail.accpremt     /*A65-0356*/
        brstat.tlt.note4   = wdetail.inspecttyp   /*A65-0356*/
        brstat.tlt.note5   = wdetail.quotation    /*A65-0356*/
        brstat.tlt.covcod  = wdetail.covcodtype . /*A65-0356*/
 /*----- end : A60-0095 -----------*/ */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Create_tlt_bk20230107 C-Win 
PROCEDURE 00-Create_tlt_bk20230107 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*LOOP_wdetail:
FOR EACH wdetail .
    ASSIGN   
        nv_policy  = ""     nv_oldpol  = ""
        nv_comdat  = ?      nv_expdat  = ?   nv_accdat  =  ?      
        nv_comchr  = ""     nv_addr    = ""  nv_name1   =  ""
        nv_ntitle  = ""     nv_titleno = 0   nv_policy  =  ""
        nv_dd      = 0      nv_mm      = 0   nv_yy      =  0
        nv_cpamt1  = 0      nv_cpamt2  = 0   nv_cpamt3  =  0
        nv_coamt1  = 0      nv_coamt2  = 0   nv_coamt3  =  0         
        nv_insamt1 = 0      nv_insamt2 = 0   nv_insamt3 =  0
        nv_premt1  = 0      nv_premt2  = 0   nv_premt3  =  0
        nv_ncb1    = 0      nv_ncb2    = 0   nv_ncb3    =  0
        nv_fleet1  = 0      nv_fleet2  = 0   nv_fleet3  =  0
        nv_oth1    = 0      nv_oth2    = 0   nv_oth3    =  0
        nv_deduct1 = 0      nv_deduct2 = 0   nv_deduct3 =  0
        nv_power1  = 0      nv_power2  = 0   nv_power3  =  0
        nv_newpol  = ""     nv_72comdat  = ?   nv_72expdat  =  ?        /*-A59-0178-*/
        nv_reccnt  = nv_reccnt + 1
        wdetail.engine = REPLACE(wdetail.engine,"*","").
        wdetail.nBLANK1 = REPLACE(wdetail.nBLANK1," ","").                             /*A63-0210*/
        /* comment by : Ranu I. A64-0090 ....
    IF wdetail.nBLANK1 <> "" THEN DO:
        /*wdetail.remark = trim(wdetail.remark) + " " + "|| " + trim(wdetail.nBLANK1).  /*A63-0210*/*//*A63-00472*/
        wdetail.remark = trim(trim(wdetail.remark) + " "  + trim(wdetail.nBLANK1)).                   /*A63-00472*/
    END.
    ELSE wdetail.remark = trim(wdetail.remark).
    ... end A64-0092 */
    IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
    ELSE ASSIGN nn_remark1  = trim(wdetail.remark)          nn_remark2  = ""           
                nn_remark3  = ""     .                       /*nn_remark4 = "".*//*A64-0092*/
    /* add by A64-0092*/
    IF trim(wdetail.nBLANK1) <> "" THEN nn_remark4 = TRIM(wdetail.nblank1).
    ELSE nn_remark4 = "" .
    /* end A64-0092*/
    IF ( wdetail.Notify_no = "" ) AND (ra_txttyp2 = 1 ) THEN 
        MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
    ELSE DO:
        /* ------------------------check policy  Duplicate--------------------------------------*/ 
        IF wdetail.prev_pol <> "" THEN RUN pol_cutchar.
        nv_oldpol  =  wdetail.prev_pol.
        nv_policy  =  nv_oldpol.         
        IF (wdetail.not_date  <> "" ) AND (wdetail.not_date <> "00000000") THEN  
            ASSIGN                                                         
            /*nv_yy = INT(SUBSTR(wdetail.not_date,7,2))                    
            nv_mm = INT(SUBSTR(wdetail.not_date,4,2))                  
            nv_dd = INT(SUBSTR(wdetail.not_date,1,2))                  
            nv_notdat  = DATE(nv_mm,nv_dd,nv_yy).*/                    
            nv_notdat  = DATE(wdetail.not_date).                       
        IF (wdetail.comdat <>  "" ) AND ( wdetail.comdat <> "00000000" )   THEN 
            ASSIGN
            /*nv_yy = INT(SUBSTR(wdetail.comdat,7,2)) 
            nv_mm = INT(SUBSTR(wdetail.comdat,4,2)) 
            nv_dd = INT(SUBSTR(wdetail.comdat,1,2)) 
            nv_comdat  = DATE(nv_mm,nv_dd,nv_yy).*/   
            nv_comdat  = DATE(wdetail.comdat). 
        IF (wdetail.expdat <>  "" ) AND  (wdetail.expdat   <> "00000000")  THEN 
            ASSIGN
            /*nv_yy = INT(SUBSTR(wdetail.expdat,7,2)) 
            nv_mm = INT(SUBSTR(wdetail.expdat,4,2)) 
            nv_dd = INT(SUBSTR(wdetail.expdat,1,2)) 
            nv_expdat  = DATE(nv_mm,nv_dd,nv_yy).*/
            nv_expdat  = DATE(wdetail.expdat).
        If  (wdetail.not_time  <>   "" ) AND ( wdetail.not_time  <>  "000000") Then   
            ASSIGN nv_nottim   =  substr(wdetail.not_time,1,2) + ":"  
            + substr(wdetail.not_time,4,2) + ":"
            + substr(wdetail.not_time,7,2).  
        /*-A59-0178-*/
        IF (wdetail.comp_expdat <>  "" ) AND  (wdetail.comp_expdat   <> "00000000")  THEN 
            ASSIGN
            nv_72expdat  = DATE(wdetail.comp_expdat).
        IF (wdetail.comp_comdat <>  "" ) AND  (wdetail.comp_comdat   <> "00000000")  THEN 
            ASSIGN
            nv_72comdat  = DATE(wdetail.comp_comdat).
        /*-A59-0178-*/
        /* --------------------------------------------- INS_AMT  CHR(11) ทุนประกันรถยนต์ --- */
        /*comment by: kridtiya i. A54-0061.. 
        nv_insamt1 = DECIMAL(SUBSTRING(wdetail.ins_amt,1,9)).*/
        /*nv_insamt1 = DECIMAL(wdetail.ins_amt).
        IF nv_insamt1 < 0 THEN
            /*nv_insamt2 = (DECIMAL(SUBSTRING(wdetail.ins_amt,10,2)) * -1) / 100.*/
            nv_insamt2 = (DECIMAL(wdetail.ins_amt) * -1) / 100.
        ELSE
            /*nv_insamt2 = DECIMAL(SUBSTRING(wdetail.ins_amt,10,2)) / 100.*/
            nv_insamt2 = DECIMAL(wdetail.ins_amt) / 100.
        nv_insamt3 = nv_insamt1 + nv_insamt2. comment by: kridtiya i. A54-0061.. */
        nv_insamt3 = DECIMAL(wdetail.ins_amt).   /* by: kridtiya i. A54-0061.. */
        /* -------------------------- PREM1 CHR(11)   เบี้ยภาคสมัครใจบวกภาษีบวกอากร --- */
        nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
        IF nv_premt1 < 0 THEN
            nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
        ELSE
            nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
        nv_premt3 = nv_premt1 + nv_premt2.
        /* --------------------------------------------- COMP_PEM CHR(09)  เบี้ยพรบ.รวม --- */
            /*comment by: kridtiya i. A54-0061.. 
            nv_cpamt1 = DECIMAL(SUBSTRING(wdetail.comp_prm,1,7)).
    IF nv_cpamt1 < 0 THEN
        nv_cpamt2 = (DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) * -1) / 100.
    ELSE
        nv_cpamt2 = DECIMAL(SUBSTRING(wdetail.comp_prm,8,2)) / 100.
    nv_cpamt3 = nv_cpamt1 + nv_cpamt2. comment by: kridtiya i. A54-0061.. */ 
        nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  /*add kridtiya i. A54-0061..*/
        /* -------------------------- GROSS_PRM CHR(11)   เบี้ยรวมภาคสมัครใจบวกเบี้ยรวม พรบ. --- */
        nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
        IF nv_coamt1 < 0 THEN
            nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
        ELSE
            nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
        nv_coamt3 = nv_coamt1 + nv_coamt2.
        /* ----------------------FLEET_DISC. ส่วนลดกลุ่ม  / เปอร์เซ็นต์ --- */
        nv_fleet1 = DECIMAL(SUBSTRING(wdetail.fleetper,1,3)).
        IF nv_fleet1 < 0 THEN
            nv_fleet2 = (DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) * -1) / 100.
        ELSE
            nv_fleet2 = DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) / 100.
        nv_fleet3 = nv_fleet1 + nv_fleet2.
        /*Message "fleet"  wdetail.fleetper   nv_fleet3.*/
        /* ----------------------NCB_DISC. ส่วนลดประวัติดี  / เปอร์เซ็นต์ --- */
        nv_ncb1 = DECIMAL(SUBSTRING(wdetail.ncbper,1,3)).
        IF nv_ncb1 < 0 THEN
            nv_ncb2 = (DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) * -1) / 100.
        ELSE
            nv_ncb2 = DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) / 100.
        nv_ncb3 = nv_ncb1 + nv_ncb2.
        /*Message "ncb"   wdetail.ncbper   nv_ncb3.*/
        /* ----------------------OTH_DISC. ส่วนลดอื่น ๆ  / เปอร์เซ็นต์ --- */
        nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
        IF nv_oth1 < 0 THEN
            nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
        ELSE
            nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
        nv_oth3 = nv_oth1 + nv_oth2.
        /*Message "oth_dis"  wdetail.othper  nv_oth3.*/
        /* ----------------------Deduct  ความเสียหายส่วนแรก  --------------- */
        nv_deduct1 = DECIMAL(SUBSTRING(wdetail.othper,1,7)).
        IF nv_deduct1 < 0 THEN
            nv_deduct2 = (DECIMAL(SUBSTRING(wdetail.deduct,8,2)) * -1) / 100.
        ELSE
            nv_deduct2 = DECIMAL(SUBSTRING(wdetail.deduct,8,2)) / 100.
        nv_deduct3 = nv_deduct1 + nv_deduct2.         
        /* ----------------Power  กำลังเครื่องยนต์------------------------ */
        nv_power1 = DECIMAL(SUBSTRING(wdetail.power,1,5)).
        IF nv_power1 < 0 THEN
            nv_power2 = (DECIMAL(SUBSTRING(wdetail.power,6,2)) * -1) / 100.
        ELSE
            nv_power2 = DECIMAL(SUBSTRING(wdetail.power,6,2)) / 100.
        nv_power3 = nv_power1 + nv_power2. 
        ASSIGN nv_CheckLog  = "no".   /*Check susspect no ไม่ติด yes ติด*/
        RUN proc_susspect (INPUT trim(wdetail.pol_fname)
                      ,INPUT trim(wdetail.pol_lname) 
                      ,INPUT trim(wdetail.licence) + " " + trim(wdetail.province)   
                      ,INPUT trim(wdetail.chassis)).  
        /*add  kridtiya i. A54-0216 .............*/
        /*FIND FIRST brstat.tlt USE-INDEX brstat.tlt06 WHERE */    /*    A55-0267*/
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
            brstat.tlt.cha_no    = trim(wdetail.chassis)  AND
            brstat.tlt.eng_no    = TRIM(wdetail.engine)   AND  /*A59-0178 */
            /*brstat.tlt.datesent  = nv_notdat              AND   A59-0178 */
            brstat.tlt.genusr    = fi_compa               NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO:    /*  kridtiya i. A54-0216 ....*/
            CREATE brstat.tlt.
            nv_completecnt  =  nv_completecnt + 1.
            

            ASSIGN                                                 
                brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
                brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
                brstat.tlt.trndat        = fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */    /*date   99/99/9999*/
                brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")         /* char   x(8)       */
                brstat.tlt.policy        = nv_newpol                       /* กรมธรรม์ใหม่แต่จะแปลงเป็น format ของ safety */
                brstat.tlt.filler1       = nv_oldpol                       /* กรมธรรม์เก่าที่จะต่ออายุ  */
                brstat.tlt.rec_addr5     = nv_policy                       /* เบอร์กรมธรรม์เก่าที่แปลงเป็น format safety */
                brstat.tlt.nor_noti_ins  = ""                              /* เบอร์กรมธรรม์ใหม่ */ /*A61-0045*/
                brstat.tlt.rec_addr3     = trim(wdetail.pro_off)           /*01..รหัสสาขาที่ผู้เอาประกันเปิดบัญชี  char   x(2)*/
                brstat.tlt.rec_addr4     = trim(wdetail.cmr_code)          /*02..รหัสเจ้าหน้าที่การตลาด  char  x(3) */
                brstat.tlt.subins        = trim(wdetail.comp_code)         /*03..char  x(5)      รหัสยอ่ยบิรษัท */
                brstat.tlt.nor_noti_tlt  = trim(wdetail.notify_no)         /* char  25   เบอร์กรมธรรมุใหม่  */
                brstat.tlt.lince2        = trim(wdetail.yrmanu)            /*04..char x(4)         ปีรถ  */
                brstat.tlt.eng_no        = trim(wdetail.engine)             /* char   x(20)      Engine no.             */
                brstat.tlt.cha_no        = TRIM(wdetail.chassis)           /*char   x(20)      Chassis no.            */
                brstat.tlt.cc_weight     = INTEGER(wdetail.weight)         /* inte   >>,>>9     CC./weight(นน.กิโล)    */
                brstat.tlt.rencnt        = nv_power3                       /*  inte   tons    */
                brstat.tlt.colorcod      = trim(wdetail.colorcode)         
                brstat.tlt.lince1        = trim(wdetail.licence)           
                brstat.tlt.stat          = trim(wdetail.garage)            
                brstat.tlt.lotno         = String(nv_fleet3)               /*char         */
                brstat.tlt.seqno         = nv_ncb3                         
                brstat.tlt.endcnt        = nv_oth3                         
                /*brstat.tlt.model         = trim(wdetail.vehuse) */           /*  ลักษณะการใช้รถ    */      /*A60-0118*/                
                brstat.tlt.gendat        = nv_comdat                       
                brstat.tlt.nor_coamt     = nv_insamt3                      /*  ทุนประกันรถ  */      
                brstat.tlt.nor_usr_ins   = trim(wdetail.name_insur)        /*  ชื่อเจ้าหน้าที่ประกันของบริษัทรับประกัน  */
                brstat.tlt.nor_usr_tlt   = trim(wdetail.not_office)        /*  รหัสเจ้าหน้าที่แจ้งประกันของ Tisco */       
                brstat.tlt.datesent      = nv_notdat                       /*  วันที่แจ้งประกัน */ 
                brstat.tlt.gentim        = nv_nottim                       /* เวลาที่แจ้งประกัน */ 
                brstat.tlt.comp_usr_tlt  = trim(wdetail.not_code)          /*  รหัสแจ้งงาน      */ 
                brstat.tlt.nor_grprm     = nv_premt3                       /* deci-2 9(13)     เบี้ยป.1+ภาษี+อากร     */
                brstat.tlt.comp_grprm    = nv_cpamt3                       /* deci-2 9(13)   เบี้ยพรบ.       */               
                brstat.tlt.comp_sck      = trim(wdetail.sckno)             /* char x(26)     เลขที่  Sticker     */
                brstat.tlt.brand         = trim(wdetail.brand)             /* char   x(3)       Car Brand Code         */
                brstat.tlt.ins_addr1     = trim(wdetail.pol_addr1)         /* char   x(35)    Ins.Address1 /ที่อยู่ผู้เอาประกัน 1*/
                brstat.tlt.ins_addr2     = trim(wdetail.pol_addr2)         /* char   x(35)   Ins.Address1 /ที่อยู่ผู้เอาประกัน 2*/
                brstat.tlt.rec_name      = trim(wdetail.pol_title)               
                brstat.tlt.ins_name      = Trim(wdetail.pol_fname) + " "  +  Trim(wdetail.pol_lname)
                brstat.tlt.safe1         = trim(wdetail.ben_name)
                /* comment by A64-0092...
                brstat.tlt.filler2      = trim(nn_remark1) +                                                       /*kridtiya i. A56-0399*/
                                          ( IF trim(nn_remark2) <> "" THEN " r2:" + trim(nn_remark2) ELSE "" )  +  /*kridtiya i. A56-0399*/
                                          ( IF trim(nn_remark3) <> "" THEN " r3:" + trim(nn_remark3) ELSE "" )  +  /*kridtiya i. A56-0399*/
                                          ( IF trim(nn_remark4) <> "" THEN " r4:" + trim(nn_remark4) ELSE "" )     /*Sarinya C. A63-0210*/
                ... end A64-0092..*/
                brstat.tlt.filler2       = trim(nn_remark1) + " r2:" + trim(nn_remark2) + " r3:" + trim(nn_remark3) + " acc:" + trim(nn_remark4) /*A64-0092*/
                brstat.tlt.safe2         = trim(wdetail.account_no)
                brstat.tlt.safe3         = trim(wdetail.client_no)                 
                brstat.tlt.expodat       = nv_expdat                         
                brstat.tlt.comp_coamt    = nv_coamt3                       /*  เบี้ยรวมป. 1 + เบี้ยรวมพรบ. */
                brstat.tlt.lince3        = trim(wdetail.province)          /*char   x(2)       จว.จดทะเบียน           */
                brstat.tlt.rec_addr1     = trim(wdetail.receipt_name)              
                brstat.tlt.recac         = trim(wdetail.agent2)
                brstat.tlt.rec_addr2     = trim(wdetail.prev_insur)
                brstat.tlt.ins_addr3     = TRIM(wdetail.addr1_70)     + " " + 
                                           TRIM(wdetail.addr2_70)     + " " + 
                                           TRIM(wdetail.nsub_dist70)  + " " + 
                                           TRIM(wdetail.ndirection70) + " " + 
                                           TRIM(wdetail.nprovin70)    + " " + 
                                           TRIM(wdetail.zipcode70)          
                brstat.tlt.ins_addr4     = TRIM(wdetail.addr1_72)     + " " + 
                                           TRIM(wdetail.addr2_72)     + " " + 
                                           TRIM(wdetail.nsub_dist72)  + " " + 
                                           TRIM(wdetail.ndirection72) + " " +
                                           TRIM(wdetail.nprovin72)    + " " + 
                                           TRIM(wdetail.zipcode72)           
                brstat.tlt.ins_addr5     = trim(wdetail.apptyp)
                brstat.tlt.comp_noti_tlt = trim(wdetail.appcode) 
                /*brstat.tlt.usrsent       = trim(wdetail.nBLANK) */
                brstat.tlt.usrsent       = nv_CheckLog   /*เก็บค่า Susspect */
                brstat.tlt.expotim       = caps(trim(wdetail.pack)) + " " + TRIM(wdetail.class)              
                brstat.tlt.old_eng       = trim(wdetail.tp1)              
                brstat.tlt.old_cha       = trim(wdetail.tp2)              
                brstat.tlt.comp_pol      = trim(wdetail.tp3)              
                brstat.tlt.expousr       = trim(wdetail.covcod)           
                brstat.tlt.comp_sub      = trim(wdetail.producer)          
                brstat.tlt.comp_noti_ins = trim(wdetail.agent)            
                brstat.tlt.exp           = caps(trim(wdetail.branch)) 
                brstat.tlt.flag          = IF ra_txttyp2 = 2 THEN "R"  ELSE "N"                              
                brstat.tlt.endno         = String(nv_deduct3)   
                brstat.tlt.sentcnt       = int(trim(wdetail.seatenew))      /*A57-0017*/
                brstat.tlt.comp_usr_tlt  = "ID70:"    + trim(wdetail.id_no70)   + /*A57-0262*/ 
                                           "ID70br:"  + trim(wdetail.id_nobr70) + /*A57-0262*/
                                           "ID72:"    + trim(wdetail.id_no72)   + /*A57-0262*/  
                                           "ID72br:"  + trim(wdetail.id_nobr72)   /*A57-0262*/
                brstat.tlt.genusr        = "TISCO"                           
                brstat.tlt.usrid         = USERID(LDBNAME(1))                 /*User Load Data */
                brstat.tlt.imp           = "IM"                              /*Import Data*/
                brstat.tlt.releas        = "No" 
                /*-A59-0178-*/
                brstat.tlt.nor_effdat    = nv_72comdat            /* วันคุ้มครอง พรบ. */ 
                brstat.tlt.comp_effdat   = nv_72expdat            /* วันสิ้นสุดคุ้มครอง พรบ. */ 
                /*SUBSTR(brstat.tlt.model,51,10)     = TRIM(wdetail.fi) */ /*A60-0118*/
                SUBSTR(brstat.tlt.expousr,6,3)     = "|" + TRIM(wdetail.usedtype).
                /*SUBSTR(brstat.tlt.expotim,6,3) = TRIM(wdetail.class)*/
                IF brstat.tlt.flag = "N" AND wdetail.covcod = "1" AND trim(wdetail.yrmanu) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection. /* A60-0118 */  
                IF brstat.tlt.flag = "R" AND wdetail.covcod = "1" AND index(brstat.tlt.rec_addr2,"SAFETY") = 0 THEN RUN proc_inspection. /* A60-0118 */  
                
                ASSIGN SUBSTR(brstat.tlt.model,51,15)     = TRIM(wdetail.fi)        /*A60-0118*/
                    brstat.tlt.comp_usr_ins  = trim(wdetail.Rec_name72) +           /*A63-0210*/
                                               "a1:"  + trim(wdetail.Rec_add1)   +  /*A63-0210*/
                                               "a2:"  + trim(wdetail.Rec_add2)   .  /*A63-0210*/

        END.
        ELSE DO: 
            nv_completecnt  =  nv_completecnt + 1.
            RUN Create_tlt2.
        END.
    END.  /*wdetail.Notify_no <> "" */
END.   /* FOR EACH wdetail NO-LOCK: */
Run Open_tlt.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt C-Win 
PROCEDURE create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
LOOP_wdetail:
FOR EACH wdetail .
  ASSIGN   
  nv_policy  = ""     nv_oldpol  = ""
  nv_comdat  = ?      nv_expdat  = ?   nv_accdat  =  ?      
  nv_comchr  = ""     nv_addr    = ""  nv_name1   =  ""
  nv_ntitle  = ""     nv_titleno = 0   nv_policy  =  ""
  nv_dd      = 0      nv_mm      = 0   nv_yy      =  0
  nv_cpamt1  = 0      nv_cpamt2  = 0   nv_cpamt3  =  0
  nv_coamt1  = 0      nv_coamt2  = 0   nv_coamt3  =  0         
  nv_insamt1 = 0      nv_insamt2 = 0   nv_insamt3 =  0
  nv_premt1  = 0      nv_premt2  = 0   nv_premt3  =  0
  nv_ncb1    = 0      nv_ncb2    = 0   nv_ncb3    =  0
  nv_fleet1  = 0      nv_fleet2  = 0   nv_fleet3  =  0
  nv_oth1    = 0      nv_oth2    = 0   nv_oth3    =  0
  nv_deduct1 = 0      nv_deduct2 = 0   nv_deduct3 =  0
  nv_power1  = 0      nv_power2  = 0   nv_power3  =  0
  nv_newpol  = ""     nv_72comdat  = ?   nv_72expdat  =  ?        
  nv_reccnt  = nv_reccnt + 1
  wdetail.engine = REPLACE(wdetail.engine,"*","").
  wdetail.nBLANK1 = REPLACE(wdetail.nBLANK1," ",""). 
  IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    
  ELSE ASSIGN nn_remark1  = trim(wdetail.remark)          
       nn_remark2  = ""           
       nn_remark3  = ""     .  
  IF trim(wdetail.nBLANK1) <> "" THEN nn_remark4 = TRIM(wdetail.nblank1).
  ELSE nn_remark4 = "" .
  IF ( wdetail.Notify_no = "" ) AND (ra_txttyp2 = 1 ) THEN MESSAGE "พบเลขรับแจ้งเป็นค่าว่าง..." VIEW-AS ALERT-BOX.
  ELSE DO:
      IF wdetail.prev_pol <> "" THEN RUN pol_cutchar.
      nv_oldpol  =  wdetail.prev_pol.
      nv_policy  =  nv_oldpol.         
      IF (wdetail.not_date <> "" ) AND (wdetail.not_date <> "00000000") THEN ASSIGN nv_notdat  = DATE(wdetail.not_date).                       
      IF (wdetail.comdat   <> "" ) AND (wdetail.comdat   <> "00000000") THEN ASSIGN nv_comdat  = DATE(wdetail.comdat). 
      IF (wdetail.expdat   <> "" ) AND (wdetail.expdat   <> "00000000") THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
      If (wdetail.not_time <> "" ) AND (wdetail.not_time <> "000000")   Then   
            ASSIGN nv_nottim   =  substr(wdetail.not_time,1,2) + ":" + substr(wdetail.not_time,4,2) + ":" + substr(wdetail.not_time,7,2).  
      IF (wdetail.comp_expdat <>  "" ) AND  (wdetail.comp_expdat   <> "00000000")  THEN ASSIGN nv_72expdat  = DATE(wdetail.comp_expdat).
      IF (wdetail.comp_comdat <>  "" ) AND  (wdetail.comp_comdat   <> "00000000")  THEN ASSIGN nv_72comdat  = DATE(wdetail.comp_comdat).
      nv_insamt3 = DECIMAL(wdetail.ins_amt). 
      nv_premt1 = DECIMAL(SUBSTRING(wdetail.prem1,1,9)).
      IF nv_premt1 < 0 THEN nv_premt2 = (DECIMAL(SUBSTRING(wdetail.prem1,10,2)) * -1) / 100.
      ELSE nv_premt2 = DECIMAL(SUBSTRING(wdetail.prem1,10,2)) / 100.
      nv_premt3 = nv_premt1 + nv_premt2.
      nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
      nv_coamt1 = DECIMAL(SUBSTRING(wdetail.gross_prm,1,9)).
      IF nv_coamt1 < 0 THEN nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) * -1) / 100.
      ELSE nv_coamt2 = DECIMAL(SUBSTRING(wdetail.gross_prm,10,2)) / 100.
      nv_coamt3 = nv_coamt1 + nv_coamt2.
      nv_fleet1 = DECIMAL(SUBSTRING(wdetail.fleetper,1,3)).
      IF nv_fleet1 < 0 THEN nv_fleet2 = (DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) * -1) / 100.
      ELSE nv_fleet2 = DECIMAL(SUBSTRING(wdetail.fleetper,4,2)) / 100.
      nv_fleet3 = nv_fleet1 + nv_fleet2.
      nv_ncb1 = DECIMAL(SUBSTRING(wdetail.ncbper,1,3)).
      IF nv_ncb1 < 0 THEN nv_ncb2 = (DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) * -1) / 100.
      ELSE nv_ncb2 = DECIMAL(SUBSTRING(wdetail.ncbper,4,2)) / 100.
      nv_ncb3 = nv_ncb1 + nv_ncb2.
      nv_oth1 = DECIMAL(SUBSTRING(wdetail.othper,1,3)).
      IF nv_oth1 < 0 THEN nv_oth2 = (DECIMAL(SUBSTRING(wdetail.othper,4,2)) * -1) / 100.
      ELSE nv_oth2 = DECIMAL(SUBSTRING(wdetail.othper,4,2)) / 100.
      nv_oth3 = nv_oth1 + nv_oth2.
      nv_deduct1 = DECIMAL(SUBSTRING(wdetail.othper,1,7)).
      IF nv_deduct1 < 0 THEN nv_deduct2 = (DECIMAL(SUBSTRING(wdetail.deduct,8,2)) * -1) / 100.
      ELSE nv_deduct2 = DECIMAL(SUBSTRING(wdetail.deduct,8,2)) / 100.
      nv_deduct3 = nv_deduct1 + nv_deduct2.         
      nv_power1 = DECIMAL(SUBSTRING(wdetail.power,1,5)).
      IF nv_power1 < 0 THEN nv_power2 = (DECIMAL(SUBSTRING(wdetail.power,6,2)) * -1) / 100.
      ELSE nv_power2 = DECIMAL(SUBSTRING(wdetail.power,6,2)) / 100.
      nv_power3 = nv_power1 + nv_power2. 
      ASSIGN nv_CheckLog  = "no".        /*Check susspect no ไม่ติด yes ติด*/
      RUN proc_susspect (INPUT trim(wdetail.pol_fname)
                        ,INPUT trim(wdetail.pol_lname) 
                        ,INPUT trim(wdetail.licence) + " " + trim(wdetail.province)   
                        ,INPUT trim(wdetail.chassis)).  
      FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   
          brstat.tlt.cha_no    = trim(wdetail.chassis)  AND
          brstat.tlt.eng_no    = TRIM(wdetail.engine)   AND   
          brstat.tlt.genusr    = fi_compa               NO-ERROR NO-WAIT .
      IF NOT AVAIL brstat.tlt THEN DO:    
          CREATE brstat.tlt.
          nv_completecnt  =  nv_completecnt + 1.
          ASSIGN                                                 
          brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
          brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
          brstat.tlt.trndat        = fi_loaddat                      /* วันที่ไฟล์แจ้งงาน */    /*date   99/99/9999*/
          brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")         /* char   x(8)       */
          brstat.tlt.policy        = nv_newpol                       /* กรมธรรม์ใหม่แต่จะแปลงเป็น format ของ safety */
          brstat.tlt.filler1       = nv_oldpol                       /* กรมธรรม์เก่าที่จะต่ออายุ  */
          brstat.tlt.rec_addr5     = nv_policy                       /* เบอร์กรมธรรม์เก่าที่แปลงเป็น format safety */
          brstat.tlt.nor_noti_ins  = ""                              /* เบอร์กรมธรรม์ใหม่ */ /*A61-0045*/
          brstat.tlt.rec_addr3     = trim(wdetail.pro_off)           /*01..รหัสสาขาที่ผู้เอาประกันเปิดบัญชี  char   x(2)*/
          brstat.tlt.rec_addr4     = trim(wdetail.cmr_code)          /*02..รหัสเจ้าหน้าที่การตลาด  char  x(3) */
          brstat.tlt.subins        = trim(wdetail.comp_code)         /*03..char  x(5)      รหัสยอ่ยบิรษัท */
          brstat.tlt.nor_noti_tlt  = trim(wdetail.notify_no)         /* char  25   เบอร์กรมธรรมุใหม่  */
          brstat.tlt.lince2        = trim(wdetail.yrmanu)            /*04..char x(4)         ปีรถ  */
          brstat.tlt.eng_no        = trim(wdetail.engine)             /* char   x(20)      Engine no.             */
          brstat.tlt.cha_no        = TRIM(wdetail.chassis)           /*char   x(20)      Chassis no.            */
          brstat.tlt.cc_weight     = INTEGER(wdetail.weight)         /* inte   >>,>>9     CC./weight(นน.กิโล)    */
          brstat.tlt.rencnt        = nv_power3                       /*  inte   tons    */
          brstat.tlt.colorcod      = trim(wdetail.colorcode)         
          brstat.tlt.lince1        = trim(wdetail.licence)           
          brstat.tlt.stat          = trim(wdetail.garage)            
          brstat.tlt.lotno         = String(nv_fleet3)               /*char         */
          brstat.tlt.seqno         = nv_ncb3                         
          brstat.tlt.endcnt        = nv_oth3                         
          /*brstat.tlt.model         = trim(wdetail.vehuse) */           /*  ลักษณะการใช้รถ    */      /*A60-0118*/                
          brstat.tlt.gendat        = nv_comdat                       
          brstat.tlt.nor_coamt     = nv_insamt3                      /*  ทุนประกันรถ  */      
          brstat.tlt.nor_usr_ins   = trim(wdetail.name_insur)        /*  ชื่อเจ้าหน้าที่ประกันของบริษัทรับประกัน  */
          brstat.tlt.nor_usr_tlt   = trim(wdetail.not_office)        /*  รหัสเจ้าหน้าที่แจ้งประกันของ Tisco */       
          brstat.tlt.datesent      = nv_notdat                       /*  วันที่แจ้งประกัน */ 
          brstat.tlt.gentim        = nv_nottim                       /* เวลาที่แจ้งประกัน */ 
          brstat.tlt.comp_usr_tlt  = trim(wdetail.not_code)          /*  รหัสแจ้งงาน      */ 
          brstat.tlt.nor_grprm     = nv_premt3                       /* deci-2 9(13)     เบี้ยป.1+ภาษี+อากร     */
          brstat.tlt.comp_grprm    = nv_cpamt3                       /* deci-2 9(13)   เบี้ยพรบ.       */               
          brstat.tlt.comp_sck      = trim(wdetail.sckno)             /* char x(26)     เลขที่  Sticker     */
          brstat.tlt.brand         = trim(wdetail.brand)             /* char   x(3)       Car Brand Code         */
          brstat.tlt.ins_addr1     = trim(wdetail.pol_addr1)         /* char   x(35)    Ins.Address1 /ที่อยู่ผู้เอาประกัน 1*/
          brstat.tlt.ins_addr2     = trim(wdetail.pol_addr2)         /* char   x(35)   Ins.Address1 /ที่อยู่ผู้เอาประกัน 2*/
          brstat.tlt.rec_name      = trim(wdetail.pol_title)               
          brstat.tlt.ins_name      = Trim(wdetail.pol_fname) + " "  +  Trim(wdetail.pol_lname)
          brstat.tlt.safe1         = trim(wdetail.ben_name)
          brstat.tlt.filler2       = trim(nn_remark1) + " r2:" + trim(nn_remark2) + " r3:" + trim(nn_remark3) + " acc:" + trim(nn_remark4) /*A64-0092*/
          brstat.tlt.safe2         = trim(wdetail.account_no)
          brstat.tlt.safe3         = trim(wdetail.client_no)                 
          brstat.tlt.expodat       = nv_expdat                         
          brstat.tlt.comp_coamt    = nv_coamt3                       /*  เบี้ยรวมป. 1 + เบี้ยรวมพรบ. */
          brstat.tlt.lince3        = trim(wdetail.province)          /*char   x(2)       จว.จดทะเบียน           */
          brstat.tlt.rec_addr1     = trim(wdetail.receipt_name)              
          brstat.tlt.recac         = trim(wdetail.agent2)
          brstat.tlt.rec_addr2     = trim(wdetail.prev_insur)
          brstat.tlt.ins_addr3     = TRIM(wdetail.addr1_70)     + " " + 
                                     TRIM(wdetail.addr2_70)     + " " + 
                                     TRIM(wdetail.nsub_dist70)  + " " + 
                                     TRIM(wdetail.ndirection70) + " " + 
                                     TRIM(wdetail.nprovin70)    + " " + 
                                     TRIM(wdetail.zipcode70)          
          brstat.tlt.ins_addr4     = TRIM(wdetail.addr1_72)     + " " + 
                                     TRIM(wdetail.addr2_72)     + " " + 
                                     TRIM(wdetail.nsub_dist72)  + " " + 
                                     TRIM(wdetail.ndirection72) + " " +
                                     TRIM(wdetail.nprovin72)    + " " + 
                                     TRIM(wdetail.zipcode72)           
          brstat.tlt.ins_addr5     = trim(wdetail.apptyp)
          brstat.tlt.comp_noti_tlt = trim(wdetail.appcode) 
          brstat.tlt.usrsent       = nv_CheckLog   /*เก็บค่า Susspect */
          brstat.tlt.expotim       = caps(trim(wdetail.pack)) + " " + TRIM(wdetail.class)              
          brstat.tlt.old_eng       = trim(wdetail.tp1)              
          brstat.tlt.old_cha       = trim(wdetail.tp2)              
          brstat.tlt.comp_pol      = trim(wdetail.tp3)              
          brstat.tlt.expousr       = trim(wdetail.covcod)           
          brstat.tlt.comp_sub      = trim(wdetail.producer)          
          brstat.tlt.comp_noti_ins = trim(wdetail.agent)            
          brstat.tlt.exp           = caps(trim(wdetail.branch)) 
          brstat.tlt.flag          = IF ra_txttyp2 = 2 THEN "R"  ELSE "N"                              
          brstat.tlt.endno         = String(nv_deduct3)   
          brstat.tlt.sentcnt       = int(trim(wdetail.seatenew))      /*A57-0017*/
          brstat.tlt.comp_usr_tlt  = "ID70:"    + trim(wdetail.id_no70)   + /*A57-0262*/ 
                                     "ID70br:"  + trim(wdetail.id_nobr70) + /*A57-0262*/
                                     "ID72:"    + trim(wdetail.id_no72)   + /*A57-0262*/  
                                     "ID72br:"  + trim(wdetail.id_nobr72)   /*A57-0262*/
          brstat.tlt.genusr        = "TISCO"                           
          brstat.tlt.usrid         = USERID(LDBNAME(1))                 /*User Load Data */
          brstat.tlt.imp           = "IM"                              /*Import Data*/
          brstat.tlt.releas        = "No" 
          brstat.tlt.nor_effdat    = nv_72comdat            /* วันคุ้มครอง พรบ. */ 
          brstat.tlt.comp_effdat   = nv_72expdat            /* วันสิ้นสุดคุ้มครอง พรบ. */ 
          SUBSTR(brstat.tlt.expousr,6,3)     = "|" + TRIM(wdetail.usedtype).
          IF brstat.tlt.flag = "N" AND wdetail.covcod = "1" AND trim(wdetail.yrmanu) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection.    
          IF brstat.tlt.flag = "R" AND wdetail.covcod = "1" AND index(brstat.tlt.rec_addr2,"SAFETY") = 0 THEN RUN proc_inspection.  
          ASSIGN SUBSTR(brstat.tlt.model,51,15)     = TRIM(wdetail.fi)     
          brstat.tlt.comp_usr_ins  = trim(wdetail.Rec_name72) + "a1:"  + trim(wdetail.Rec_add1) + "a2:"  + trim(wdetail.Rec_add2)   
          brstat.tlt.note1   = wdetail.acctyp       /*A65-0356*/ 
          brstat.tlt.note2   = wdetail.acccovins    /*A65-0356*/
          brstat.tlt.note3   = wdetail.accpremt     /*A65-0356*/
          brstat.tlt.note4   = wdetail.inspecttyp   /*A65-0356*/
          brstat.tlt.note5   = wdetail.quotation    /*A65-0356*/
          brstat.tlt.covcod  = wdetail.covcodtype .  /*A65-0356*/
          RUN proc_driver. /* A67-0087 */
        END.
        ELSE DO: 
            nv_completecnt  =  nv_completecnt + 1.
            RUN Create_tlt2.
        END.
    END.  /*wdetail.Notify_no <> "" */
END.   /* FOR EACH wdetail NO-LOCK: */
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt2 C-Win 
PROCEDURE create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN                                                 
         brstat.tlt.entdat        = TODAY                          /* date  99/99/9999  */
         brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")        /* char  x(8)        */
         brstat.tlt.trndat        = fi_loaddat                     /* วันที่ไฟล์แจ้งงาน */    /*date   99/99/9999*/
         brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")        /* char   x(8)       */
         brstat.tlt.nor_noti_tlt  = trim(wdetail.notify_no)        /* char  25   เบอร์กรมธรรมุใหม่  */
         brstat.tlt.policy        = nv_newpol                      /* กรมธรรม์ใหม่แต่จะแปลงเป็น format ของ safety */
         brstat.tlt.filler1       = nv_oldpol                      /* กรมธรรม์เก่าที่จะต่ออายุ  */
         brstat.tlt.rec_addr5     = nv_policy                      /* เบอร์กรมธรรม์เก่าที่แปลงเป็น format safety */
         brstat.tlt.rec_addr3     = trim(wdetail.pro_off)          /* รหัสสาขาที่ผู้เอาประกันเปิดบัญชี  char   x(2)       */
         brstat.tlt.rec_addr4     = trim(wdetail.cmr_code)         /* รหัสเจ้าหน้าที่การตลาด  char  x(3)    */
         brstat.tlt.subins        = trim(wdetail.comp_code)        /* char  x(5)      รหัสยอ่ยบิรษัท     */
         brstat.tlt.lince2        = trim(wdetail.yrmanu)           /* char x(4)         ปีรถ  */
         brstat.tlt.eng_no        = trim(wdetail.engine)           /* char   x(20)      Engine no.             */
         brstat.tlt.cha_no        = TRIM(wdetail.chassis)          /*char   x(20)      Chassis no.            */
         brstat.tlt.cc_weight     = INTEGER(wdetail.weight)        /* inte   >>,>>9     CC./weight(นน.กิโล)    */
         brstat.tlt.rencnt        = nv_power3                      /*  inte   tons    */
         brstat.tlt.colorcod      = trim(wdetail.colorcode)        
         brstat.tlt.lince1        = trim(wdetail.licence)          
         brstat.tlt.stat          = trim(wdetail.garage)           
         brstat.tlt.lotno         = String(nv_fleet3)              /*char         */
         brstat.tlt.seqno         = nv_ncb3                        
         brstat.tlt.endcnt        = nv_oth3                        
         brstat.tlt.nor_usr_ins   = trim(wdetail.name_insur)       /*  ชื่อเจ้าหน้าที่ประกันของบริษัทรับประกัน  */
         brstat.tlt.nor_usr_tlt   = trim(wdetail.not_office)       /*  รหัสเจ้าหน้าที่แจ้งประกันของ Tisco */       
         brstat.tlt.gentim        = nv_nottim                      /* เวลาที่แจ้งประกัน */ 
         brstat.tlt.comp_usr_tlt  = trim(wdetail.not_code)         /*  รหัสแจ้งงาน      */ 
         brstat.tlt.brand         = trim(wdetail.brand)            /* char   x(3)       Car Brand Code         */
         brstat.tlt.ins_addr1     = trim(wdetail.pol_addr1)        /* char   x(35)    Ins.Address1 /ที่อยู่ผู้เอาประกัน 1*/
         brstat.tlt.ins_addr2     = trim(wdetail.pol_addr2)        /* char   x(35)   Ins.Address1 /ที่อยู่ผู้เอาประกัน 2*/
         brstat.tlt.rec_name      = trim(wdetail.pol_title)        
         brstat.tlt.ins_name      = Trim(wdetail.pol_fname) + " "  +  Trim(wdetail.pol_lname)
         brstat.tlt.safe1         = trim(wdetail.ben_name)
         brstat.tlt.filler2      = trim(nn_remark1) + " r2:" + trim(nn_remark2) + " r3:" + trim(nn_remark3) + " acc:" + trim(nn_remark4) /*A64-0092*/
         brstat.tlt.safe2         = trim(wdetail.account_no)                                              
         brstat.tlt.safe3         = trim(wdetail.client_no)                 
         brstat.tlt.lince3        = trim(wdetail.province)                /*char   x(2)       จว.จดทะเบียน           */
         brstat.tlt.rec_addr1     = trim(wdetail.receipt_name)              
         brstat.tlt.recac         = trim(wdetail.agent2)
         brstat.tlt.rec_addr2     = trim(wdetail.prev_insur)
         brstat.tlt.ins_addr3     = TRIM(wdetail.addr1_70)     + " " + 
                                    TRIM(wdetail.addr2_70)     + " " + 
                                    TRIM(wdetail.nsub_dist70)  + " " + 
                                    TRIM(wdetail.ndirection70) + " " + 
                                    TRIM(wdetail.nprovin70)    + " " + 
                                    TRIM(wdetail.zipcode70)          
         brstat.tlt.ins_addr4     = TRIM(wdetail.addr1_72)     + " " + 
                                    TRIM(wdetail.addr2_72)     + " " + 
                                    TRIM(wdetail.nsub_dist72)  + " " + 
                                    TRIM(wdetail.ndirection72) + " " +
                                    TRIM(wdetail.nprovin72)    + " " + 
                                    TRIM(wdetail.zipcode72)           
         brstat.tlt.ins_addr5     = trim(wdetail.apptyp)
         brstat.tlt.comp_noti_tlt = trim(wdetail.appcode) 
         brstat.tlt.usrsent       = nv_CheckLog   /*เก็บค่า Susspect  A64-0092*/
         brstat.tlt.expotim       = caps(trim(wdetail.pack)) + " " + TRIM(wdetail.class)            
         brstat.tlt.old_eng       = trim(wdetail.tp1)              
         brstat.tlt.old_cha       = trim(wdetail.tp2)              
         brstat.tlt.comp_pol      = trim(wdetail.tp3)              
         brstat.tlt.expousr       = trim(wdetail.covcod)          
         brstat.tlt.comp_sub      = trim(wdetail.producer)          
         brstat.tlt.comp_noti_ins = trim(wdetail.agent)            
         brstat.tlt.exp           = caps(trim(wdetail.branch)) 
         brstat.tlt.flag          = IF ra_txttyp2 = 2 THEN "R"  ELSE "N"                              
         brstat.tlt.endno         = String(nv_deduct3)   
         brstat.tlt.sentcnt       = int(trim(wdetail.seatenew))      /*A57-0017*/
         brstat.tlt.comp_usr_tlt  = "ID70:"    + trim(wdetail.id_no70)   + /*A57-0262*/ 
                                    "ID70br:"  + trim(wdetail.id_nobr70) + /*A57-0262*/
                                    "ID72:"    + trim(wdetail.id_no72)   + /*A57-0262*/  
                                    "ID72br:"  + trim(wdetail.id_nobr72)   /*A57-0262*/
         brstat.tlt.genusr        = "TISCO"                           
         brstat.tlt.usrid         = USERID(LDBNAME(1))                 /*User Load Data */
         brstat.tlt.imp           = "IM"                              /*Import Data*/
         brstat.tlt.releas        = "No"
         SUBSTR(brstat.tlt.expousr,6,3) = "|" + TRIM(wdetail.usedtype)
         /* comment by : A67-0087 ...
         /*--- create by A59-0618 ---*/
         brstat.tlt.dri_name1  =   trim(wdetail.drivename1)
         brstat.tlt.dri_no1    =   STRING(wdetail.bdatedriv1)
         brstat.tlt.dri_name2  =   TRIM(wdetail.drivename2)
         brstat.tlt.dri_no2    =   STRING(wdetail.bdatedriv2) .
         /*--- end A59-0618 ---*/
         ...end A67-0087...*/
         brstat.tlt.comp_usr_ins  = trim(wdetail.Rec_name72) +              /*A63-0210*/
                                    "a1:"  + trim(wdetail.Rec_add1)   +     /*A63-0210*/
                                    "a2:"  + trim(wdetail.Rec_add2)   .     /*A63-0210*/
        
/*---- Create by : Ranu I. A60-0085 -----*/
/*---------------- V70-------------------*/
 IF nv_premt3 > 0  THEN DO:
     IF YEAR(brstat.tlt.datesent) = YEAR(TODAY) THEN DO: /* A61-0045*/
        ASSIGN 
            brstat.tlt.nor_grprm = nv_premt3 
            brstat.tlt.expodat   = nv_expdat 
            brstat.tlt.gendat    = nv_comdat 
            brstat.tlt.nor_coamt = nv_insamt3                   /*A60-0225*/
            SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). /*A60-0225*/ 
     END.
     /* create by :  A61-0045*/
     ELSE DO:
         ASSIGN  brstat.tlt.nor_grprm           = nv_premt3 
                 brstat.tlt.expodat             = nv_expdat 
                 brstat.tlt.gendat              = nv_comdat         
                 brstat.tlt.nor_coamt           = nv_insamt3        
                 brstat.tlt.model               = ""
                 brstat.tlt.nor_noti_ins        = ""          
                 SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). 
     END.
     /*-- end A61-00045--*/
 END.
 ELSE DO:
     IF (brstat.tlt.nor_grprm <> 0 AND brstat.tlt.expodat <> ? ) AND YEAR(brstat.tlt.expodat) > YEAR(TODAY)  THEN DO:
         IF YEAR(brstat.tlt.datesent) = YEAR(TODAY) THEN DO:
             ASSIGN brstat.tlt.nor_grprm  = brstat.tlt.nor_grprm   
                    brstat.tlt.expodat    = brstat.tlt.expodat                                  /*A60-0225*/  
                    brstat.tlt.gendat     = brstat.tlt.gendat                                   /*A60-0225*/ 
                    brstat.tlt.nor_coamt  = brstat.tlt.nor_coamt                                /*A60-0225*/ 
                    SUBSTR(brstat.tlt.model,51,15) =  SUBSTR(brstat.tlt.model,51,15)  .         /*A60-0225*/ 
         END.
         ELSE DO:
             ASSIGN  brstat.tlt.nor_grprm           = nv_premt3 
                     brstat.tlt.expodat             = nv_expdat 
                     brstat.tlt.gendat              = nv_comdat         
                     brstat.tlt.nor_coamt           = nv_insamt3        /*A60-0225*/
                     brstat.tlt.model               = ""                /*A61-0045*/
                     brstat.tlt.nor_noti_ins        = ""               /* เบอร์กรมธรรม์ใหม่ */  /*A61-0045*/
                     SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). /*A60-0225*/ 
         END.
     END.
     ELSE DO:
         ASSIGN  brstat.tlt.nor_grprm           = nv_premt3 
                 brstat.tlt.expodat             = nv_expdat 
                 brstat.tlt.gendat              = nv_comdat
                 brstat.tlt.nor_coamt           = nv_insamt3        /*A60-0225*/
                 brstat.tlt.model               = ""                /*A61-0045*/
                 brstat.tlt.nor_noti_ins        = ""                /* เบอร์กรมธรรม์ใหม่ */  /*A61-0045*/
                 SUBSTR(brstat.tlt.model,51,15) = TRIM(wdetail.fi). /*A60-0225*/
     END.
 END.
 /*---- A61-0045 ------*/
 IF brstat.tlt.flag = "N" AND wdetail.covcod = "1" AND trim(wdetail.yrmanu) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection. 
 IF brstat.tlt.flag = "R" AND wdetail.covcod = "1" AND index(brstat.tlt.rec_addr2,"SAFETY") = 0 THEN RUN proc_inspection. 
 /*---- end A61-00045---*/
 /*------------- V72 -----------------*/
 IF nv_cpamt3 > 0  THEN DO:  
     ASSIGN 
         brstat.tlt.comp_grprm  = nv_cpamt3 
         brstat.tlt.nor_effdat  = nv_72comdat   
         brstat.tlt.comp_effdat = nv_72expdat
         brstat.tlt.comp_sck    = IF LENGTH(trim(wdetail.sckno)) <> 13 THEN "0"+ TRIM(wdetail.sckno) ELSE trim(wdetail.sckno)   .
 END.
 ELSE DO:
     IF (brstat.tlt.comp_grprm <> 0 AND brstat.tlt.comp_effdat <> ? ) AND YEAR(brstat.tlt.comp_effdat) > YEAR(TODAY) THEN DO:
         IF YEAR(brstat.tlt.datesent) = YEAR(TODAY) THEN
             ASSIGN  brstat.tlt.comp_grprm  = brstat.tlt.comp_grprm    
                     brstat.tlt.nor_effdat  = brstat.tlt.nor_effdat   /*A60-0225*/ 
                     brstat.tlt.comp_effdat = brstat.tlt.comp_effdat  /*A60-0225*/ 
                     brstat.tlt.comp_sck    = brstat.tlt.comp_sck .   /*A60-0225*/
         ELSE
             ASSIGN 
                 brstat.tlt.comp_grprm  = nv_cpamt3 
                 brstat.tlt.nor_effdat  = nv_72comdat   
                 brstat.tlt.comp_effdat = nv_72expdat
                 brstat.tlt.comp_sck    = trim(wdetail.sckno).
     END.
     ELSE
         ASSIGN 
         brstat.tlt.comp_grprm  = nv_cpamt3 
         brstat.tlt.nor_effdat  = nv_72comdat   
         brstat.tlt.comp_effdat = nv_72expdat
         brstat.tlt.comp_sck    = trim(wdetail.sckno).
 END.
 ASSIGN brstat.tlt.datesent   = nv_notdat
        brstat.tlt.comp_coamt = DECI(brstat.tlt.nor_grprm + brstat.tlt.comp_grprm)   /*A60-0225*/
        brstat.tlt.note1   = wdetail.acctyp       /*A65-0356*/ 
        brstat.tlt.note2   = wdetail.acccovins    /*A65-0356*/
        brstat.tlt.note3   = wdetail.accpremt     /*A65-0356*/
        brstat.tlt.note4   = wdetail.inspecttyp   /*A65-0356*/
        brstat.tlt.note5   = wdetail.quotation    /*A65-0356*/
        brstat.tlt.covcod  = wdetail.covcodtype . /*A65-0356*/
 /*----- end : A60-0095 -----------*/ 
 RUN proc_driver . /*A67-0087 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
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
  DISPLAY fi_loaddat fi_compa ra_txttyp fi_producer fi_filename fi_proname 
          fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet ra_txttyp2 fi_insp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_compa ra_txttyp fi_producer fi_filename bu_ok br_imptxt 
         bu_exit bu_file bu_hpacno1 ra_txttyp2 fi_insp RECT-1 RECT-79 RECT-80 
         RECT-380 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_driver C-Win 
PROCEDURE Import_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*A55-0184*/
FOR EACH  wdriver :
    DELETE  wdriver.
END.
/*A55-0184*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdriver.
    IMPORT DELIMITER "|" 
        /*comment by Kridtiya i. A55-0184....
        wdriver.recordID    = TRIM(SUBSTR(nv_daily,1,2))         
        wdriver.Pro_off     = TRIM(SUBSTR(nv_daily,3,2))  
        wdriver.chassis     = TRIM(SUBSTR(nv_daily,5,25))
        wdriver.dri_no      = TRIM(SUBSTR(nv_daily,30,2))
        wdriver.dri_name    = TRIM(SUBSTR(nv_daily,32,40))
        wdriver.birthdate   = TRIM(SUBSTR(nv_daily,72,8))                  
        wdriver.occupn      = TRIM(SUBSTR(nv_daily,80,75))                  
        wdriver.position    = TRIM(SUBSTR(nv_daily,155,40)).  
        end...comment by Kridtiya i. A55-0184....*/  
        wdriver.Pro_off     
        wdriver.chassis     
        wdriver.dri_no      
        wdriver.dri_name    
        wdriver.birthdate   
        wdriver.occupn      
        wdriver.position  . 
END.    /* repeat  */
/*A55-0184*/
FOR EACH wdriver.
    IF            wdriver.Pro_off = ""           THEN DELETE wdriver.
    ELSE IF index(wdriver.Pro_off,"บริษัท") <> 0 THEN DELETE wdriver.  
    ELSE IF index(wdriver.Pro_off,"Pro") <> 0    THEN DELETE wdriver.
    ELSE IF index(wdriver.Pro_off,"tot") <> 0    THEN DELETE wdriver.
END.
/*A55-0184*/
ASSIGN nv_dri_cnt    = 0
    nv_dri_complet   = 0.
Run  Update_tlt.  
If  nv_load  =  No    Then  do:
    For each wdriver  .
        Delete  wdriver.
    END.
    fi_dri_complet   =  0.
    fi_dir_cnt       =  0.
    Disp fi_dri_complet   fi_dir_cnt with frame  fr_main.      
END.
Else do:  
    If  nv_dri_complet  <>  0  Then do:
        Enable br_imptxt       With frame fr_main.
    END.
    fi_dri_complet  =  nv_dri_complet.
    fi_dir_cnt      =  nv_dri_cnt.
    Disp fi_dri_complet   fi_dir_cnt with frame  fr_main.
    Message "Load  Data Drivername Complete"  View-as alert-box.  
    Run Open_tlt.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification C-Win 
PROCEDURE Import_notification :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR   nv_ncb  as  char  init  "" format "X(5)".*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
IF ra_txttyp2 = 1  THEN DO:
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
          wdetail.vehuse       
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
          wdetail.seatenew              /*A57-0017*/
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
          wdetail.nBLANK2          /*- A59-0178 -*/
          wdetail.Reciept72       /*- start A63-0210 -*/
          wdetail.caracc          
          wdetail.Rec_name72
          wdetail.Rec_add1  
          wdetail.Rec_add2     /*- End A63-0210 -*/
          wdetail.acctyp       /*A65-0356*/ 
          wdetail.acccovins    /*A65-0356*/
          wdetail.accpremt     /*A65-0356*/
          wdetail.inspecttyp   /*A65-0356*/
          wdetail.quotation    /*A65-0356*/
          wdetail.covcodtype   /*A65-0356*/
          /* A67-0087 */
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
          wdetail.carbrand.
          /* end : A67-0087 */
  END.  /* repeat  */
END.
ELSE DO:
    RUN IMPORT_notification2.
END.

FOR EACH wdetail .
    IF      INDEX(wdetail.Pro_off,"pro")    <> 0 THEN  DELETE wdetail.
    ELSE IF INDEX(wdetail.Pro_off,"total")  <> 0 THEN  DELETE wdetail.
    ELSE IF INDEX(wdetail.Pro_off,"บริษัท") <> 0 THEN  DELETE wdetail.
    ELSE IF  wdetail.Pro_off    = "" THEN  DELETE wdetail.
END.

ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
Run  Create_tlt.   
RUN  UPDATE_Driv.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.

End. 
fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Complete"  View-as alert-box.  
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_notification2 C-Win 
PROCEDURE import_notification2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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
      wdetail.vehuse       
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
      wdetail.seatenew              /*A57-0017*/
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
      wdetail.nBLANK2          /*- A59-0178 -*/
      wdetail.Reciept72       /*- start A63-0210 -*/
      wdetail.caracc          
      wdetail.Rec_name72
      wdetail.Rec_add1  
      wdetail.Rec_add2     /*- End A63-0210 -*/
      wdetail.polnissan
      wdetail.acctyp       /*A65-0356*/ 
      wdetail.acccovins    /*A65-0356*/
      wdetail.accpremt     /*A65-0356*/
      wdetail.inspecttyp   /*A65-0356*/
      wdetail.quotation    /*A65-0356*/
      wdetail.covcodtype   /*A65-0356*/
      /* A67-0087 */
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
      wdetail.carbrand.
      /* end : A67-0087 */
END.  /* repeat  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt C-Win 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_imptxt  For each tlt  Use-index tlt01  where
           tlt.trndat     =  fi_loaddat   and
           /*tlt.comp_sub   =  fi_producer  and*/
           tlt.genusr     =  fi_compa     NO-LOCK .
         

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pol_cutchar C-Win 
PROCEDURE pol_cutchar :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
nv_c = wdetail.prev_pol.
nv_i = 0.
nv_l = LENGTH(nv_c).
DO WHILE nv_i <= nv_l:
    ind = 0.
    ind = INDEX(nv_c,"/").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"\").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"-").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"*").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,"#").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c," ").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN
    wdetail.prev_pol = nv_c .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutremak C-Win 
PROCEDURE proc_cutremak :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*wdetail.remark*/ 
ASSIGN  nn_remark1 = ""
        nn_remark2 = ""
        nn_remark3 = "".
IF      R-INDEX(wdetail.remark,"/บริษัท") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/บริษัท"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/บริษัท") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 85 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,86 )) 
            nn_remark2 = trim(substr(nn_remark2,1,85)).
    END.

END.
ELSE IF      R-INDEX(wdetail.remark,"/บจก") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/บจก"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/บจก") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE IF      R-INDEX(wdetail.remark,"/ห้าง") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/ห้าง"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/ห้าง") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE DO:
    IF INDEX(wdetail.remark," ") <> 0 THEN DO:  /*A64-0092*/
        ASSIGN 
            nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark," "))) 
            nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark," ") - 1 )) .
    /* add : A64-0092 */
    END.
    ELSE DO:
        ASSIGN nn_remark1 = trim(wdetail.remark) .
    END.
    /* end A64-0092 */
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".  
    loop_chk0:
    REPEAT:
        IF LENGTH(nn_remark1) > 110 THEN DO:
            IF R-INDEX(nn_remark1," ") <> 0  THEN
                ASSIGN  
                nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
            ELSE ASSIGN 
                nn_remark2 = trim(substr(nn_remark1,111)) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,110)) .
        END.
        ELSE IF LENGTH(nn_remark2) > 85 THEN DO:
            IF R-INDEX(nn_remark2," ") <> 0  THEN
                ASSIGN  
                nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," "))) 
                nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
            ELSE ASSIGN 
                nn_remark3 = trim(substr(nn_remark2,86)) 
                nn_remark2 = trim(substr(nn_remark2,1,85)).
        END.
        ELSE LEAVE loop_chk0.
    END.
END.
loop_chk1:
REPEAT:
    IF INDEX(nn_remark1,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark1).
        nn_remark1 = SUBSTRING(nn_remark1,1,INDEX(nn_remark1,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark1,INDEX(nn_remark1,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nn_remark2,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark2).
        nn_remark2 = SUBSTRING(nn_remark2,1,INDEX(nn_remark2,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark2,INDEX(nn_remark2,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nn_remark3,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark3).
        nn_remark3 = SUBSTRING(nn_remark3,1,INDEX(nn_remark3,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark3,INDEX(nn_remark3,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk3.
END.
IF LENGTH(nn_remark2 + " " + nn_remark3 ) <= 85 THEN 
    ASSIGN nn_remark2 = nn_remark2 + " " + nn_remark3  
           nn_remark3 = "".
IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
    ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
           nn_remark2 = "".
/*
DISP LENGTH(nn_remark1)
     nn_remark1 FORMAT "x(65)"
     nn_remark2 FORMAT "x(65)"  
     nn_remark3 FORMAT "x(65)" .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutremak_bp C-Win 
PROCEDURE proc_cutremak_bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*wdetail.remark*/ 
/* comment by A64-0092 ...
ASSIGN  nn_remark1 = ""
        nn_remark2 = ""
        nn_remark3 = ""
        nn_remark4 = "".
IF      R-INDEX(wdetail.remark,"/บริษัท") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/บริษัท"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/บริษัท") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    /* Comment by Sarinya C A63-0210
      IF LENGTH(nn_remark2) > 85 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN Comment by Sarinya C A63-0210 */
    /*add by Sarinya C A63-0210 */
    IF LENGTH(nn_remark2) > 110 THEN DO: 
        ASSIGN
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
    IF LENGTH(nn_remark3) > 110 THEN DO: 
        ASSIGN
            nn_remark4 = trim(substr(nn_remark3,111 )) 
            nn_remark3 = trim(substr(nn_remark3,1,110)).
    END.

END.
ELSE IF      R-INDEX(wdetail.remark,"/บจก") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/บจก"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/บจก") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        /* Comment by Sarinya C A63-0210
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN  Comment by Sarinya C A63-0210*/
        ASSIGN
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
    IF LENGTH(nn_remark3) > 110 THEN DO: 
        ASSIGN
            nn_remark4 = trim(substr(nn_remark3,111 )) 
            nn_remark3 = trim(substr(nn_remark3,1,110)).
    END.
END.
ELSE IF      R-INDEX(wdetail.remark,"/ห้าง") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/ห้าง"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/ห้าง") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        /* Comment by Sarinya C A63-0210
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN Comment by Sarinya C A63-0210*/
        ASSIGN
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
    IF LENGTH(nn_remark3) > 110 THEN DO: 
        ASSIGN
            nn_remark4 = trim(substr(nn_remark3,111 )) 
            nn_remark3 = trim(substr(nn_remark3,1,110)).
    END.
END.
ELSE DO:
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark," "))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark," ") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".  
    loop_chk0:
    REPEAT:
        IF LENGTH(nn_remark1) > 110 THEN DO:
            IF R-INDEX(nn_remark1," ") <> 0  THEN
                ASSIGN  
                nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
            ELSE ASSIGN 
                nn_remark2 = trim(substr(nn_remark1,111)) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,110)) .
        END.
        /* Comment by Sarinya C A63-0210
        ELSE IF LENGTH(nn_remark2) > 85 THEN DO:
            IF R-INDEX(nn_remark2," ") <> 0  THEN
                ASSIGN  
                nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," "))) 
                nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
            ELSE ASSIGN 
                nn_remark3 = trim(substr(nn_remark2,86)) 
                nn_remark2 = trim(substr(nn_remark2,1,85)). Comment by Sarinya C A63-0210*/
        /*add by Sarinya C A63-0210 */
        ELSE IF LENGTH(nn_remark2) > 110 THEN DO:
            ASSIGN 
                nn_remark3 = trim(substr(nn_remark2,111)) 
                nn_remark2 = trim(substr(nn_remark2,1,110)).
        
        END.
        IF LENGTH(nn_remark3) > 110 THEN DO: 
        ASSIGN
            nn_remark4 = trim(substr(nn_remark3,111 )) 
            nn_remark3 = trim(substr(nn_remark3,1,110)).
        END.
        ELSE LEAVE loop_chk0.
    END.
END.
loop_chk1:
REPEAT:
    IF INDEX(nn_remark1,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark1).
        nn_remark1 = SUBSTRING(nn_remark1,1,INDEX(nn_remark1,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark1,INDEX(nn_remark1,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nn_remark2,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark2).
        nn_remark2 = SUBSTRING(nn_remark2,1,INDEX(nn_remark2,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark2,INDEX(nn_remark2,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nn_remark3,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark3).
        nn_remark3 = SUBSTRING(nn_remark3,1,INDEX(nn_remark3,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark3,INDEX(nn_remark3,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk3.
END.
IF LENGTH(nn_remark2 + " " + nn_remark3 ) <= 85 THEN 
    ASSIGN nn_remark2 = nn_remark2 + " " + nn_remark3  
           nn_remark3 = "".
IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
    ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
           nn_remark2 = "".
/*
DISP LENGTH(nn_remark1)
     nn_remark1 FORMAT "x(65)"
     nn_remark2 FORMAT "x(65)"  
     nn_remark3 FORMAT "x(65)" .*/
     ... end A64-0092 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_driver C-Win 
PROCEDURE proc_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by ranui A67-0087      
------------------------------------------------------------------------------*/
ASSIGN 
    brstat.tlt.dri_name1  = trim(wdetail.drivename1)
    brstat.tlt.dri_no1    = STRING(wdetail.bdatedriv1)
    brstat.tlt.dir_occ1   = TRIM(wdetail.occupdriv1)
    brstat.tlt.dri_name2  = TRIM(wdetail.drivename2)
    brstat.tlt.dri_no2    = STRING(wdetail.bdatedriv2)
    brstat.tlt.dri_occ2   = TRIM(wdetail.occupdriv2) 
    brstat.tlt.dri_name3 =  TRIM(wdetail.drivename3)  
    brstat.tlt.dri_no3    = STRING(wdetail.bdatedriv3)
    brstat.tlt.dir_occ3   = TRIM(wdetail.occupdriv3) 
    brstat.tlt.dri_name4  = TRIM(wdetail.drivename4)  
    brstat.tlt.dri_no4    = STRING(wdetail.bdatedriv4)
    brstat.tlt.dri_occ4   = TRIM(wdetail.occupdriv4)
    brstat.tlt.dri_name5  = TRIM(wdetail.drivename5)  
    brstat.tlt.dri_no5    = STRING(wdetail.bdatedriv5)
    brstat.tlt.dri_occ5   = TRIM(wdetail.occupdriv5) 
    brstat.tlt.acces1     = TRIM(wdetail.caracc)
    brstat.tlt.note7      = trim(wdetail.Schanel)   
    brstat.tlt.note8      = trim(wdetail.bev)   
    brstat.tlt.campaign   = trim(wdetail.campagin) 
    brstat.tlt.ispflg     = trim(wdetail.inspic)   
    brstat.tlt.ndeci1     = DECI(wdetail.engcount) 
    brstat.tlt.eng_no2    = trim(wdetail.engno2)   
    brstat.tlt.note9      = trim(wdetail.engno3)   
    brstat.tlt.note10     = trim(wdetail.engno4)   
    brstat.tlt.note11     = trim(wdetail.engno5)   
    brstat.tlt.subclass   = trim(wdetail.classcomp)
    brstat.tlt.car_type   = trim(wdetail.carbran)
    brstat.tlt.note12     = TRIM(wdetail.polnissan) 
    /*  Add by : A67-0114 */
    brstat.tlt.dri_lic1   = IF index(wdetail.positdriv1,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv1,1,INDEX(wdetail.positdriv1,"/") - 1)) ELSE trim(wdetail.positdriv1)
    brstat.tlt.dri_ic1    = IF index(wdetail.positdriv1,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv1,R-INDEX(wdetail.positdriv1,"/") + 1)) ELSE "" 
    brstat.tlt.dri_lic2   = IF index(wdetail.positdriv2,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv2,1,INDEX(wdetail.positdriv2,"/") - 1)) ELSE trim(wdetail.positdriv2)
    brstat.tlt.dri_ic2    = IF index(wdetail.positdriv2,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv2,R-INDEX(wdetail.positdriv2,"/") + 1)) ELSE "" 
    brstat.tlt.dri_lic3   = IF index(wdetail.positdriv3,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv3,1,INDEX(wdetail.positdriv3,"/") - 1)) ELSE trim(wdetail.positdriv3)
    brstat.tlt.dri_ic3    = IF index(wdetail.positdriv3,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv3,R-INDEX(wdetail.positdriv3,"/") + 1)) ELSE "" 
    brstat.tlt.dri_lic4   = IF index(wdetail.positdriv4,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv4,1,INDEX(wdetail.positdriv4,"/") - 1)) ELSE trim(wdetail.positdriv4)
    brstat.tlt.dri_ic4    = IF index(wdetail.positdriv4,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv4,R-INDEX(wdetail.positdriv4,"/") + 1)) ELSE "" 
    brstat.tlt.dri_lic5   = IF index(wdetail.positdriv5,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv5,1,INDEX(wdetail.positdriv5,"/") - 1)) ELSE trim(wdetail.positdriv5)
    brstat.tlt.dri_ic5    = IF index(wdetail.positdriv5,"/") <> 0 THEN trim(SUBSTR(wdetail.positdriv5,R-INDEX(wdetail.positdriv5,"/") + 1)) ELSE "" .
    /* end A67-0114 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_inspection C-Win 
PROCEDURE proc_inspection :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A60-0118      
------------------------------------------------------------------------------*/
DEF VAR nv_nameT AS CHAR FORMAT "X(50)".
DEF VAR nv_agentname AS CHAR FORMAT "X(60)".
DEF VAR nv_brand AS CHAR FORMAT "X(50)". 
DEF VAR nv_model AS CHAR FORMAT "X(50)". 
DEF VAR nv_licentyp AS CHAR FORMAT "X(50)".
DEF VAR nv_licen    AS CHAR FORMAT "X(20)". 
DEF VAR nv_pattern1 AS CHAR FORMAT "X(20)".  
DEF VAR nv_pattern4 AS CHAR FORMAT "X(20)".  
DEF VAR nv_today  AS CHAR init "" .
DEF VAR nv_time   AS CHAR init "" .
DEF VAR nv_docno AS CHAR FORMAT "x(25)".
DEF VAR nv_survey AS CHAR FORMAT "x(25)".
DEF VAR nv_detail AS CHAR FORMAT "x(30)".
DEF VAR nv_branchdesp AS CHAR FORMAT "x(100)".
ASSIGN  nv_docno    = ""    nv_nameT     = ""       nv_brand    = ""        nv_model     = ""
  nv_licentyp = ""    nv_tmp       = ""       nv_pattern1 = ""        nv_pattern4  = ""
  nv_licen    = ""    nv_agentname = ""       nv_survey   = ""        nv_detail    = ""
  nv_tmp      = "Inspect" + SUBSTR(fi_insp,3,2) + ".nsf" 
  nv_today    = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY),"9999")
  nv_time     = STRING(TIME,"HH:MM:SS")
  nv_branchdesp = "" .  /*A63-00472 */
/*A63-00472 */
IF wdetail.branch <> "" THEN DO:
    /*comment by Kridtiya i. A66-0160 
  IF      TRIM(wdetail.branch) = "C"  THEN ASSIGN nv_branchdesp = "Krabi".
  ELSE IF TRIM(wdetail.branch) = "31" THEN ASSIGN nv_branchdesp = "Kanchanaburi".
  ELSE IF TRIM(wdetail.branch) = "76" THEN ASSIGN nv_branchdesp = "Kalasin".
  ELSE IF TRIM(wdetail.branch) = "65" THEN ASSIGN nv_branchdesp = "Kamphaengphet".
  ELSE IF TRIM(wdetail.branch) = "3"  THEN ASSIGN nv_branchdesp = "Khonkaen".
  ELSE IF TRIM(wdetail.branch) = "39" THEN ASSIGN nv_branchdesp = "Chanthaburi".
  ELSE IF TRIM(wdetail.branch) = "35" THEN ASSIGN nv_branchdesp = "Chachoengsao".
  ELSE IF TRIM(wdetail.branch) = "77" THEN ASSIGN nv_branchdesp = "Chaiyaphum".
  ELSE IF TRIM(wdetail.branch) = "B"  THEN ASSIGN nv_branchdesp = "Chumporn".
  ELSE IF TRIM(wdetail.branch) = "G"  THEN ASSIGN nv_branchdesp = "Chiangrai".
  ELSE IF TRIM(wdetail.branch) = "2"  THEN ASSIGN nv_branchdesp = "Chiangmai".
  ELSE IF TRIM(wdetail.branch) = "E"  THEN ASSIGN nv_branchdesp = "Trang".
  ELSE IF TRIM(wdetail.branch) = "84" THEN ASSIGN nv_branchdesp = "Takuapa".
  ELSE IF TRIM(wdetail.branch) = "82" THEN ASSIGN nv_branchdesp = "Thungsong".
  ELSE IF TRIM(wdetail.branch) = "U"  THEN ASSIGN nv_branchdesp = "Nakhonprathom".
  ELSE IF TRIM(wdetail.branch) = "53" THEN ASSIGN nv_branchdesp = "Nakhonpanom".
  ELSE IF TRIM(wdetail.branch) = "6"  THEN ASSIGN nv_branchdesp = "Nakhon Ratchasima".
  ELSE IF TRIM(wdetail.branch) = "N"  THEN ASSIGN nv_branchdesp = "Nakhon Si Thammarat".
  ELSE IF TRIM(wdetail.branch) = "1"  THEN ASSIGN nv_branchdesp = "Nakornsawan".
  ELSE IF TRIM(wdetail.branch) = "44" THEN ASSIGN nv_branchdesp = "Bangsaphan".
  ELSE IF TRIM(wdetail.branch) = "52" THEN ASSIGN nv_branchdesp = "Buriram".
  ELSE IF TRIM(wdetail.branch) = "A"  THEN ASSIGN nv_branchdesp = "Prajaub".
  ELSE IF TRIM(wdetail.branch) = "38" THEN ASSIGN nv_branchdesp = "Prachinburi".
  ELSE IF TRIM(wdetail.branch) = "D"  THEN ASSIGN nv_branchdesp = "Pattani".
  ELSE IF TRIM(wdetail.branch) = "5"  THEN ASSIGN nv_branchdesp = "Pattaya".
  ELSE IF TRIM(wdetail.branch) = "85" THEN ASSIGN nv_branchdesp = "Phattalung".
  ELSE IF TRIM(wdetail.branch) = "DH" THEN ASSIGN nv_branchdesp = "Phisanulok".
  ELSE IF TRIM(wdetail.branch) = "I"  THEN ASSIGN nv_branchdesp = "Phetchaburi".
  ELSE IF TRIM(wdetail.branch) = "64" THEN ASSIGN nv_branchdesp = "Phrae".
  ELSE IF TRIM(wdetail.branch) = "8"  THEN ASSIGN nv_branchdesp = "Phuket".
  ELSE IF TRIM(wdetail.branch) = "78" THEN ASSIGN nv_branchdesp = "Mahasarakham".
  ELSE IF TRIM(wdetail.branch) = "75" THEN ASSIGN nv_branchdesp = "Mukdahan".
  ELSE IF TRIM(wdetail.branch) = "71" THEN ASSIGN nv_branchdesp = "Roiet".
  ELSE IF TRIM(wdetail.branch) = "83" THEN ASSIGN nv_branchdesp = "Ranong".
  ELSE IF TRIM(wdetail.branch) = "36" THEN ASSIGN nv_branchdesp = "Rayong".
  ELSE IF TRIM(wdetail.branch) = "33" THEN ASSIGN nv_branchdesp = "Ratchaburi".
  ELSE IF TRIM(wdetail.branch) = "37" THEN ASSIGN nv_branchdesp = "Lopburi".
  ELSE IF TRIM(wdetail.branch) = "61" THEN ASSIGN nv_branchdesp = "Lampang".
  ELSE IF TRIM(wdetail.branch) = "51" THEN ASSIGN nv_branchdesp = "Loei".
  ELSE IF TRIM(wdetail.branch) = "81" THEN ASSIGN nv_branchdesp = "Wiang Sa".
  ELSE IF TRIM(wdetail.branch) = "45" THEN ASSIGN nv_branchdesp = "Sriracha".
  ELSE IF TRIM(wdetail.branch) = "74" THEN ASSIGN nv_branchdesp = "Srisaket".
  ELSE IF TRIM(wdetail.branch) = "73" THEN ASSIGN nv_branchdesp = "Sakon Nakhon".
  ELSE IF TRIM(wdetail.branch) = "89" THEN ASSIGN nv_branchdesp = "Songkhla".
  ELSE IF TRIM(wdetail.branch) = "86" THEN ASSIGN nv_branchdesp = "Satun".
  ELSE IF TRIM(wdetail.branch) = "42" THEN ASSIGN nv_branchdesp = "Samut Songkhram".
  ELSE IF TRIM(wdetail.branch) = "F"  THEN ASSIGN nv_branchdesp = "Samutsakhon".
  ELSE IF TRIM(wdetail.branch) = "9"  THEN ASSIGN nv_branchdesp = "Samui".
  ELSE IF TRIM(wdetail.branch) = "J"  THEN ASSIGN nv_branchdesp = "Saraburi".
  ELSE IF TRIM(wdetail.branch) = "32" THEN ASSIGN nv_branchdesp = "Suphanburi".
  ELSE IF TRIM(wdetail.branch) = "7"  THEN ASSIGN nv_branchdesp = "Surathani".
  ELSE IF TRIM(wdetail.branch) = "72" THEN ASSIGN nv_branchdesp = "Surin".
  ELSE IF TRIM(wdetail.branch) = "79" THEN ASSIGN nv_branchdesp = "Nongkhai".
  ELSE IF TRIM(wdetail.branch) = "88" THEN ASSIGN nv_branchdesp = "Langsuan".
  ELSE IF TRIM(wdetail.branch) = "41" THEN ASSIGN nv_branchdesp = "Hua Hin".
  ELSE IF TRIM(wdetail.branch) = "4"  THEN ASSIGN nv_branchdesp = "Hat Yai".
  ELSE IF TRIM(wdetail.branch) = "34" THEN ASSIGN nv_branchdesp = "Ayutthaya".
  ELSE IF TRIM(wdetail.branch) = "S"  THEN ASSIGN nv_branchdesp = "Udorn".
  ELSE IF TRIM(wdetail.branch) = "K"  THEN ASSIGN nv_branchdesp = "Ubon". 
  end comment by Kridtiya i. A66-0160*/
       IF TRIM(wdetail.branch) = "M"  THEN ASSIGN nv_branchdesp = "Dealer Business 1". 
  ELSE IF TRIM(wdetail.branch) = "W"  THEN ASSIGN nv_branchdesp = "Dealer Business 1".
  ELSE IF TRIM(wdetail.branch) = "MF" AND INDEX(wdetail.brand,"NISSAN") <> 0 THEN ASSIGN nv_branchdesp = "Dealer Business 1". 
  ELSE IF TRIM(wdetail.branch) = "MF" THEN ASSIGN nv_branchdesp = "ML (Bank & Finance)". 
  ELSE IF TRIM(wdetail.branch) = "ML" THEN ASSIGN nv_branchdesp = "ML (Bank & Finance)". 
  /*ELSE ASSIGN nv_branchdesp = "ML (Bank & Finance)".  /*งาน Tisco   */*/
  ELSE DO:
      RUN wuw\wuwqbanc (INPUT  TRIM(wdetail.branch)  /*Add by Kridtiya i. A66-0160*/
                       ,OUTPUT nv_branchdesp         /*Add by Kridtiya i. A66-0160*/
                       ,OUTPUT nv_hobr ).            /*Add by Kridtiya i. A66-0160*/
      nv_branchdesp = trim(REPLACE(nv_branchdesp,"- 1","")).  /*add by Kridtiya i. A66-0160  */ 
      nv_branchdesp = trim(REPLACE(nv_branchdesp,"-1","")).   /*add by Kridtiya i. A66-0160  */ 
  END.
END.
/*
IF      wdetail.producer = "B3M0033"    AND wdetail.agent = "B3M0035" THEN ASSIGN nv_branchdesp = "Dealer Business 1".    /*งาน OEM-FORD*/
ELSE IF wdetail.producer = "B3DM000007" AND wdetail.agent = "B3M0035" THEN ASSIGN nv_branchdesp = "Dealer Business 1".  /*A65-0361 B3DM000007 / B3M0035*/
ELSE IF wdetail.producer = "B3DM000003" AND wdetail.agent = "B3M0035" THEN ASSIGN nv_branchdesp = "Dealer Business 1".  /*A65-0361 B3DM000007 / B3M0035*/
ELSE ASSIGN nv_branchdesp = "ML (Bank & Finance)".  /*งาน Tisco   */*/
/*A63-00472 */
IF INDEX(wdetail.pol_title,"คุณ")               <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.pol_title,"นาย")          <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.pol_title,"นาง")          <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.pol_title,"น.ส.")         <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.pol_title,"นางสาว")       <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.pol_title,"ห้างหุ้นส่วน") <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
ELSE IF INDEX(wdetail.pol_title,"หจก")          <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
ELSE IF INDEX(wdetail.pol_title,"บริษัท")       <> 0 THEN ASSIGN nv_nameT = "บริษัท".
ELSE IF INDEX(wdetail.pol_title,"บจก")          <> 0 THEN ASSIGN nv_nameT = "บริษัท".
ELSE IF INDEX(wdetail.pol_title,"มูลนิธิ")      <> 0 THEN ASSIGN nv_nameT = "มูลนิธิ".
ELSE IF INDEX(wdetail.pol_title,"โรงแรม")       <> 0 THEN ASSIGN nv_nameT = "โรงแรม".
ELSE IF INDEX(wdetail.pol_title,"โรงเรียน")     <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
ELSE IF INDEX(wdetail.pol_title,"ร.ร.")         <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
ELSE IF INDEX(wdetail.pol_title,"โรงพยาบาล")    <> 0 THEN ASSIGN nv_nameT = "โรงพยาบาล".
ELSE IF INDEX(wdetail.pol_title,"นิติบุคคลอาคารชุด") <> 0 THEN ASSIGN nv_nameT = "นิติบุคคลอาคารชุด".
ELSE ASSIGN nv_nameT = "อื่นๆ".


ASSIGN nv_brand = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,1,INDEX(wdetail.brand," ") - 1 )) ELSE trim(wdetail.brand)
       nv_model = IF INDEX(wdetail.brand," ") <> 0 THEN trim(SUBSTR(wdetail.brand,LENGTH(nv_brand) + 1,LENGTH(wdetail.brand))) ELSE "".

IF trim(wdetail.licence) <> "" AND trim(wdetail.province) <> "" THEN DO:
    ASSIGN nv_licentyp = "รถเก๋ง/กระบะ/บรรทุก".
    RUN proc_province.
END.
ELSE DO: 
    ASSIGN nv_licentyp = "รถที่ยังไม่มีทะเบียน"
           nv_pattern4 = "/ZZZZZZZZZ" 
           wdetail.licence = trim(wdetail.chassis) /* add A63-0210*/
           wdetail.licence = "/" + SUBSTR(wdetail.licence,LENGTH(wdetail.licence) - 8,LENGTH(wdetail.licence)) 
           wdetail.province = "".
END.

IF trim(wdetail.producer) <> "" THEN DO:
 FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
      xmm600.acno  =  trim(wdetail.producer) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        FIND sicsyac.xtm600 USE-INDEX xtm60001  WHERE xtm600.acno  =  trim(wdetail.producer) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600 THEN 
            ASSIGN nv_agentname = TRIM(sicsyac.xtm600.ntitle) + "  "  + TRIM(sicsyac.xtm600.name) .
        ELSE 
            ASSIGN nv_agentname = "".
    END.
    ELSE 
        ASSIGN nv_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
END.

IF wdetail.licence <> "" THEN DO:
   ASSIGN nv_licen = REPLACE(wdetail.licence," ","").
  /*
   IF INDEX("0123456789",SUBSTR(wdetail.licence,1,1)) <> 0 THEN DO:
       IF LENGTH(nv_licen) = 4 THEN 
          ASSIGN nv_Pattern1 = "y-xx-y-xx"
                 nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,1).
       ELSE IF LENGTH(nv_licen) = 5 THEN
           ASSIGN nv_Pattern1 = "y-xx-yy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,2).
       ELSE IF LENGTH(nv_licen) = 6 THEN DO:
           IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yy-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yx-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE 
               ASSIGN nv_Pattern1 = "y-xx-yyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,3). 
       END.
       ELSE 
           ASSIGN nv_Pattern1 = "y-xx-yyyy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,4).
    END.
    ELSE DO:
        IF LENGTH(nv_licen) = 3 THEN 
          ASSIGN nv_Pattern1 = "xx-y-xx"
                 nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
        ELSE IF LENGTH(nv_licen) = 4 THEN
           ASSIGN nv_Pattern1 = "xx-yy-xx"
                  nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
        ELSE IF LENGTH(nv_licen) = 6 THEN
           ASSIGN nv_Pattern1 = "xx-yyyy-xx" 
                  nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
        ELSE IF LENGTH(nv_licen) = 5 THEN DO:
            IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "x-yyyy-xx"
                      nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
            ELSE 
               ASSIGN nv_Pattern1 = "xx-yyy-xx" 
                      nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
        END.
    END.*/
      IF INDEX("0123456789",SUBSTR(wdetail.licence,1,1)) <> 0 THEN DO:
          IF LENGTH(nv_licen) = 4 THEN 
             ASSIGN nv_Pattern1 = "yxx-y-xx"
                    nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,1).
          ELSE IF LENGTH(nv_licen) = 5 THEN
              ASSIGN nv_Pattern1 = "yxx-yy-xx"
                     nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,2).
          ELSE IF LENGTH(nv_licen) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern1 = "yy-yyyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
              ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
                  ASSIGN nv_Pattern1 = "yx-yyyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
              ELSE 
                  ASSIGN nv_Pattern1 = "yxx-yyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). 
          END.
          ELSE 
              ASSIGN nv_Pattern1 = "yxx-yyyy-xx"
                     nv_licen    = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,4).
       END.
       ELSE DO:
           IF LENGTH(nv_licen) = 3 THEN 
             ASSIGN nv_Pattern1 = "xx-y-xx"
                    nv_licen    = SUBSTR(nv_licen,1,2) + " "  + SUBSTR(nv_licen,3,1) .
           ELSE IF LENGTH(nv_licen) = 4 THEN
              ASSIGN nv_Pattern1 = "xx-yy-xx"
                     nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
           ELSE IF LENGTH(nv_licen) = 6 THEN
              IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
              ASSIGN nv_Pattern1 = "xx-yyyy-xx" 
                     nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
              ELSE ASSIGN nv_Pattern1 = "xxx-yyy-xx" 
                     nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
           ELSE IF LENGTH(nv_licen) = 5 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern1 = "x-yyyy-xx"
                         nv_licen    = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
               ELSE 
                  ASSIGN nv_Pattern1 = "xx-yyy-xx" 
                         nv_licen    = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
           END.
       END.
END.
/* ปิดเทส*/
/*--------- Server Real ----------*/
nv_server = "Safety_NotesServer/Safety".
nv_tmp   = "safety\uw\" + nv_tmp .
/*-------------------------------*/
/*---------- Server test local -------
nv_server = "".
nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp .
-----------------------------*/
CREATE "Notes.NotesSession"  chNotesSession.
chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
  IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
     MESSAGE "Can not open database" SKIP  
             "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
  END.
  ELSE DO:
    chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
    chNavView      = chNotesView:CreateViewNav.
    chDocument     = chNotesView:GetDocumentByKey(trim(wdetail.chassis)).
    IF VALID-HANDLE(chDocument) = YES THEN DO:
        chitem       = chDocument:Getfirstitem("docno"). 
        IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
        ELSE nv_docno = "".
        chitem       = chDocument:Getfirstitem("SurveyClose").
        IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
        ELSE nv_survey = "".
        chitem       = chDocument:Getfirstitem("SurveyResult").
        IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
        ELSE nv_detail = "".
        IF nv_docno <> ""  THEN DO:
            IF nv_survey <> "" THEN ASSIGN  brstat.tlt.model = "ISP:" + nv_docno + " Detail:" + nv_detail .
            ELSE ASSIGN  brstat.tlt.model = "ISP:" + nv_docno.
        END.
        ELSE 
            ASSIGN  brstat.tlt.model = "ISP:" .
        RELEASE  OBJECT chitem          NO-ERROR.
        RELEASE  OBJECT chDocument      NO-ERROR.          
        RELEASE  OBJECT chNotesDataBase NO-ERROR.     
        RELEASE  OBJECT chNotesSession  NO-ERROR.
    END.
    ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO:
        chDocument = chNotesDatabase:CreateDocument.
        chDocument:AppendItemValue( "Form", "Inspection").
        chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
        chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
        chDocument:AppendItemValue( "App", "0").
        chDocument:AppendItemValue( "Chk", "0").
        chDocument:AppendItemValue( "dateS", brstat.tlt.gendat).
        chDocument:AppendItemValue( "dateE", brstat.tlt.expodat).
        chDocument:AppendItemValue( "ReqType_sub", "ตรวจสภาพใหม่").
        chDocument:AppendItemValue( "BranchReq", nv_branchdesp).     
        chDocument:AppendItemValue( "Tname", nv_nameT).
        chDocument:AppendItemValue( "Fname", trim(wdetail.pol_fname)).    
        chDocument:AppendItemValue( "Lname", trim(wdetail.pol_lname)).    
        chDocument:AppendItemValue( "PolicyNo", ""). 
        chDocument:AppendItemValue( "agentCode",trim(wdetail.producer)).  
        chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
        chDocument:AppendItemValue( "model", nv_brand).
        chDocument:AppendItemValue( "modelCode", nv_model).
        chDocument:AppendItemValue( "carCC", trim(wdetail.chassis)).
        chDocument:AppendItemValue( "Year", trim(brstat.tlt.lince2)).           
        chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
        chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
        chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
        chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
        chDocument:AppendItemValue( "LicenseNo_2", trim(wdetail.province)).
        chDocument:AppendItemValue( "commentMK", trim(wdetail.remark)).
        chDocument:SAVE(TRUE,TRUE).
      RELEASE  OBJECT chitem          NO-ERROR.
      RELEASE  OBJECT chDocument      NO-ERROR.          
      RELEASE  OBJECT chNotesDataBase NO-ERROR.     
      RELEASE  OBJECT chNotesSession  NO-ERROR.
      ASSIGN brstat.tlt.model = "ISP:".
    END.
  END.
 /*comment by Kridtiya i. A63-00472
    chDocument:AppendItemValue( "BranchReq", "Business Unit 3").  ปรับแก้ไข จาก "Business Unit 3" เป็น nv_branchdesp
    chDocument:AppendItemValue( "BranchReq", nv_branchdesp ).
  comment by Kridtiya i. A63-00472  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province C-Win 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
        IF INDEX(wdetail.province,".") <> 0 THEN REPLACE(wdetail.province,".","").
/*1*/        IF wdetail.province = "ANG THONG"          THEN wdetail.province = "อท".
/*2*/   ELSE IF wdetail.province = "AYUTTHAYA"          THEN wdetail.province = "อย".
/*3*/   ELSE IF wdetail.province = "BKK"                THEN wdetail.province = "กท". 
/*3*/   ELSE IF wdetail.province = "BANGKOK"            THEN wdetail.province = "กท".
/*4*/   ELSE IF wdetail.province = "BURIRAM"            THEN wdetail.province = "บร".
/*5*/   ELSE IF wdetail.province = "CHAI NAT"           THEN wdetail.province = "ชน".
/*6*/   ELSE IF wdetail.province = "CHANTHABURI"        THEN wdetail.province = "จบ".
/*7*/   ELSE IF wdetail.province = "CHIANG MAI"         THEN wdetail.province = "ชม".
/*8*/   ELSE IF wdetail.province = "CHONBURI"           THEN wdetail.province = "ชบ".
/*9*/   ELSE IF wdetail.province = "KALASIN"            THEN wdetail.province = "กส".
/*10*/  ELSE IF wdetail.province = "KANCHANABURI"       THEN wdetail.province = "กจ".
/*11*/  ELSE IF wdetail.province = "KHON KAEN"          THEN wdetail.province = "ขก".
/*12*/  ELSE IF wdetail.province = "KRABI"              THEN wdetail.province = "กบ".
/*13*/  ELSE IF wdetail.province = "LOPBURI"            THEN wdetail.province = "ลบ".
/*14*/  ELSE IF wdetail.province = "NAKHON NAYOK"       THEN wdetail.province = "นย".
/*15*/  ELSE IF wdetail.province = "NAKHON PATHOM"      THEN wdetail.province = "นฐ".
/*16*/  ELSE IF wdetail.province = "NAKHON RATCHASIMA"  THEN wdetail.province = "นม".
/*17*/  ELSE IF wdetail.province = "NAKHON SITHAMMARAT" THEN wdetail.province = "นศ".
/*18*/  ELSE IF wdetail.province = "NONTHABURI"         THEN wdetail.province = "นบ".
/*19*/  ELSE IF wdetail.province = "PHETCHABURI"        THEN wdetail.province = "พบ".
/*20*/  ELSE IF wdetail.province = "PHUKET"             THEN wdetail.province = "ภก".
/*21*/  ELSE IF wdetail.province = "PHITSANULOK"        THEN wdetail.province = "พล".
/*22*/  ELSE IF wdetail.province = "PRACHINBURI"        THEN wdetail.province = "ปจ".
/*23*/  ELSE IF wdetail.province = "RATCHABURI"         THEN wdetail.province = "รบ".
/*24*/  ELSE IF wdetail.province = "RAYONG"             THEN wdetail.province = "รย".
/*25*/  ELSE IF wdetail.province = "ROI ET"             THEN wdetail.province = "รอ".
/*26*/  ELSE IF wdetail.province = "SARABURI"           THEN wdetail.province = "สบ".
/*27*/  ELSE IF wdetail.province = "SRISAKET"           THEN wdetail.province = "ศก".
/*28*/  ELSE IF wdetail.province = "SONGKHLA"           THEN wdetail.province = "สข".
/*29*/  ELSE IF wdetail.province = "SA KAEO"            THEN wdetail.province = "สก".
/*30*/  ELSE IF wdetail.province = "SUPHANBURI"         THEN wdetail.province = "สพ".
/*31*/  ELSE IF wdetail.province = "SURAT THANI"        THEN wdetail.province = "สฏ".
/*32*/  ELSE IF wdetail.province = "TRANG"              THEN wdetail.province = "ตง".
/*33*/  ELSE IF wdetail.province = "UBON RATCHATHANI"   THEN wdetail.province = "อบ".
/*34*/  ELSE IF wdetail.province = "UDON THANI"         THEN wdetail.province = "อด".
/*35*/  ELSE IF wdetail.province = "AMNAT CHAROEN"      THEN wdetail.province = "อจ".
/*36*/  ELSE IF wdetail.province = "CHAIYAPHUM"         THEN wdetail.province = "ชย".
/*37*/  ELSE IF wdetail.province = "CHIANG RAI"         THEN wdetail.province = "ชร".
/*38*/  ELSE IF wdetail.province = "CHUMPHON"           THEN wdetail.province = "ชพ".
/*39*/  ELSE IF wdetail.province = "KAMPHAENG PHET"     THEN wdetail.province = "กพ".
/*40*/  ELSE IF wdetail.province = "LAMPANG"            THEN wdetail.province = "ลป".
/*41*/  ELSE IF wdetail.province = "LAMPHUN"            THEN wdetail.province = "ลพ".
/*42*/  ELSE IF wdetail.province = "NAKHON SAWAN"       THEN wdetail.province = "นว".
/*43*/  ELSE IF wdetail.province = "NONG KHAI"          THEN wdetail.province = "นค".
/*44*/  ELSE IF wdetail.province = "PATHUM THANI"       THEN wdetail.province = "ปท".
/*45*/  ELSE IF wdetail.province = "PATTANI"            THEN wdetail.province = "ปน".
/*46*/  ELSE IF wdetail.province = "PHATTHALUNG"        THEN wdetail.province = "พท".
/*47*/  ELSE IF wdetail.province = "PHETCHABUN"         THEN wdetail.province = "พช".
/*48*/  ELSE IF wdetail.province = "SAKON NAKHON"       THEN wdetail.province = "สน".
/*49*/  ELSE IF wdetail.province = "SING BURI"          THEN wdetail.province = "สห".
/*50*/  ELSE IF wdetail.province = "SURIN"              THEN wdetail.province = "สร".
/*51*/  ELSE IF wdetail.province = "YASOTHON"           THEN wdetail.province = "ยส".
/*52*/  ELSE IF wdetail.province = "YALA"               THEN wdetail.province = "ยล".
/*53*/  ELSE IF wdetail.province = "BAYTONG"            THEN wdetail.province = "บต".
/*54*/  ELSE IF wdetail.province = "CHACHOENGSAO"       THEN wdetail.province = "ฉช".
/*55*/  ELSE IF wdetail.province = "LOEI"               THEN wdetail.province = "ลย".
/*56*/  ELSE IF wdetail.province = "MAE HONG SON"       THEN wdetail.province = "มส".
/*57*/  ELSE IF wdetail.province = "MAHA SARAKHAM"      THEN wdetail.province = "มค".
/*58*/  ELSE IF wdetail.province = "MUKDAHAN"           THEN wdetail.province = "มห".
/*59*/  ELSE IF wdetail.province = "NAN"                THEN wdetail.province = "นน".
/*60*/  ELSE IF wdetail.province = "NARATHIWAT"         THEN wdetail.province = "นธ".
/*61*/  ELSE IF wdetail.province = "NONG BUA LAMPHU"    THEN wdetail.province = "นภ".
/*62*/  ELSE IF wdetail.province = "PHAYAO"             THEN wdetail.province = "พย".  
/*63*/  ELSE IF wdetail.province = "PHANG NGA"          THEN wdetail.province = "พง".
/*64*/  ELSE IF wdetail.province = "PHRAE"              THEN wdetail.province = "พร".
/*65*/  ELSE IF wdetail.province = "PHICHIT"            THEN wdetail.province = "พจ".
/*66*/  ELSE IF wdetail.province = "PRACHUAP KHIRIKHAN" THEN wdetail.province = "ปข".
/*67*/  ELSE IF wdetail.province = "RANONG"             THEN wdetail.province = "รน".
/*68*/  ELSE IF wdetail.province = "SAMUT PRAKAN"       THEN wdetail.province = "สป".
/*69*/  ELSE IF wdetail.province = "SAMUT SAKHON"       THEN wdetail.province = "สค". 
/*70*/  ELSE IF wdetail.province = "SAMUT SONGKHRAM"    THEN wdetail.province = "สส".
/*71*/  ELSE IF wdetail.province = "SATUN"              THEN wdetail.province = "สต".
/*72*/  ELSE IF wdetail.province = "SUKHOTHAI"          THEN wdetail.province = "สท".
/*73*/  ELSE IF wdetail.province = "TAK"                THEN wdetail.province = "ตก".
/*74*/  ELSE IF wdetail.province = "TRAT"               THEN wdetail.province = "ตร".
/*75*/  ELSE IF wdetail.province = "UTHAI THANI"        THEN wdetail.province = "อน".
/*76*/  ELSE IF wdetail.province = "UTTARADIT"          THEN wdetail.province = "อต".
/*77*/  ELSE IF wdetail.province = "NAKHON PHANOM"      THEN wdetail.province = "นพ". 
/*78*/  ELSE IF wdetail.province = "BUENG KAN"          THEN wdetail.province = "บก". 
        ELSE IF wdetail.province = "กทม"                THEN wdetail.province = "กท".  /*a60-0095*/
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(wdetail.province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN wdetail.province = brstat.Insure.LName.
        END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_susspect C-Win 
PROCEDURE proc_susspect :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF input parameter nn_namelist   as char.    
DEF input parameter nn_namelist2  as char.    
DEF input parameter nn_vehreglist as char. 
DEF input parameter nv_chanolist  as char.
ASSIGN nv_msgstatus = "" .  /*A64-0092*/
IF nn_vehreglist <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            nv_CheckLog  = "YES"
            nv_msgstatus = nv_msgstatus + "|รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน"  .
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN nv_CheckLog  = "YES"
            nv_msgstatus = nv_msgstatus + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN nv_CheckLog  = "YES"
                nv_msgstatus = nv_msgstatus + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
        END.
    END.
END.
IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN nv_CheckLog  = "YES"
            nv_msgstatus = nv_msgstatus + "|รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
END.
/*
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:
    
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN nv_msgstatus = nv_msgstatus + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
    IF nv_msgstatus = "" THEN DO:
        ASSIGN 
            nv_idnolist2 = ""
            nv_idnolist  = REPLACE(nv_idnolist,"-","")
            nv_idnolist  = REPLACE(nv_idnolist," ","")
            nv_idnolist2 = substr(nv_idnolist,1,1)  + "-" +
                           substr(nv_idnolist,2,4)  + "-" +
                           substr(nv_idnolist,6,5)  + "-" +
                           substr(nv_idnolist,11,2) + "-" +
                           substr(nv_idnolist,13)   .

        FIND LAST sicuw.uzsusp USE-INDEX uzsusp08  WHERE 
            sicuw.uzsusp.notes = nv_idnolist2         NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                nv_msgstatus = nv_msgstatus + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
        END.
    END.
END.*/
IF nv_msgstatus <> "" THEN MESSAGE nv_msgstatus VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE update_Driv C-Win 
PROCEDURE update_Driv :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Loop_driver:
For each wdetail  NO-LOCK .
    ASSIGN nv_dri_cnt = nv_dri_cnt + 1.
    IF       index(wdetail.drivename1,"ป.") <> 0      THEN NEXT.
    ELSE IF  index(wdetail.drivename1,"ประกัน") <> 0  THEN NEXT.
    ELSE IF  index(wdetail.drivename1,"ประเภท") <> 0  THEN NEXT.
    ELSE IF   wdetail.drivename1  = ""  THEN NEXT.
    /*comment kridtiya i. A55-0184...
        ASSIGN  nv_yy   = INT(SUBSTR(wdriver.birthdate,1,4)) + 543
        nv_mm       = INT(SUBSTR(wdriver.birthdate,5,2))
        nv_dd       = INT(SUBSTR(wdriver.birthdate,7,2))
        nv_birthdat = DATE(nv_mm,nv_dd,nv_yy).
        end...comment kridtiya i. A55-0184...*/
    FIND LAST tlt USE-INDEX tlt06  WHERE           /*add A55-0267*/
        /*tlt.cha_no    = trim(wdetail.chassis)    AND*//*add A56-0146*/
        tlt.cha_no  = TRIM(wdetail.chassis)    AND      /*add A56-0146*/
        tlt.genusr  = "TISCO"                  No-error  no-wait.
    If  not  avail  tlt  Then do:
        Message  TRIM(wdetail.chassis)  "ยังไม่มีการ Load ข้อมูลการแจ้งรับประกัน " skip
            "กรุณา load ข้อมูลการแจ้งรับประกันก่อนข้อมูล ผู้ขับขี่  "  View-as alert-box.
        nv_load   =  No.                  
        Leave Loop_driver.    
    END.
    Else do:  
        ASSIGN  nv_dri_complet  =   nv_dri_complet + 1
                nv_load  =  Yes.
        If  wdetail.driveno1    <> ""  Then 
            ASSIGN  tlt.dri_name1  =   wdetail.drivename1
                    tlt.dri_no1    =   STRING(wdetail.bdatedriv1).
            /*String(nv_birthdat,"99/99/9999") + String(wdriver.occupn,"X(40)")
            +   String(wdriver.position,"X(40)")*/  
        If  wdetail.driveno2     <> ""  Then
            Assign
                    tlt.dri_name2  =   wdetail.drivename2
                    tlt.dri_no2    =   STRING(wdetail.bdatedriv2) .
            /*String(nv_birthdat,"99/99/9999") + String(wdriver.occupn,"X(40)")
            +   String(wdriver.position,"X(40)")*/   . 
    END.

End.       /* for each wdriver  */  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Update_tlt C-Win 
PROCEDURE Update_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment kridtiya i. A55-0184...
DEF VAR nv_dd        AS INT    FORMAT "99".
DEF VAR nv_mm        AS INT    FORMAT "99".
DEF VAR nv_yy        AS INT    FORMAT "9999".
DEF VAR nv_birthdat  AS DATE   FORMAT "99/99/9999"  NO-UNDO.
end...comment kridtiya i. A55-0184... */

Loop_driver:
For each wdriver  NO-LOCK .
    ASSIGN nv_dri_cnt = nv_dri_cnt + 1.
    IF       index(wdriver.dri_name,"ป.") <> 0      THEN NEXT.
    ELSE IF  index(wdriver.dri_name,"ประกัน") <> 0  THEN NEXT.
    ELSE IF  index(wdriver.dri_name,"ประเภท") <> 0  THEN NEXT.
    ELSE IF   wdriver.dri_name  = ""  THEN NEXT.
    /*comment kridtiya i. A55-0184...
        ASSIGN  nv_yy   = INT(SUBSTR(wdriver.birthdate,1,4)) + 543
        nv_mm       = INT(SUBSTR(wdriver.birthdate,5,2))
        nv_dd       = INT(SUBSTR(wdriver.birthdate,7,2))
        nv_birthdat = DATE(nv_mm,nv_dd,nv_yy).
        end...comment kridtiya i. A55-0184...*/
    FIND LAST tlt USE-INDEX tlt06  WHERE           /*add A55-0267*/
        /*tlt.cha_no    = trim(wdetail.chassis)    AND*//*add A56-0146*/
        tlt.cha_no  = TRIM(wdriver.chassis)    AND      /*add A56-0146*/
        tlt.genusr  = "TISCO"                  No-error  no-wait.
    If  not  avail  tlt  Then do:
        Message  "ยังไม่มีการ Load ข้อมูลการแจ้งรับประกัน " skip
            "กรุณา load ข้อมูลการแจ้งรับประกันก่อนข้อมูล ผู้ขับขี่  "  View-as alert-box.
        nv_load   =  No.                  
        Leave Loop_driver.    
    END.
    Else do:  
        ASSIGN  nv_dri_complet  =   nv_dri_complet + 1
                nv_load  =  Yes.
        If  wdriver.dri_no  =  "01"  Then 
            ASSIGN  tlt.dri_name1  =   wdetail.drivename1        
            tlt.dri_no1            =   STRING(wdetail.bdatedriv1)
            /*String(nv_birthdat,"99/99/9999") + String(wdriver.occupn,"X(40)")
            +   String(wdriver.position,"X(40)")*/   .
        Else If  wdriver.dri_no  =  "02"  Then
            Assign
            tlt.dri_name2  =   wdetail.drivename2        
            tlt.dri_no2    =   STRING(wdetail.bdatedriv2)
            /*String(nv_birthdat,"99/99/9999") + String(wdriver.occupn,"X(40)")
            +   String(wdriver.position,"X(40)")*/   .
    END.
End.       /* for each wdriver  */      

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

