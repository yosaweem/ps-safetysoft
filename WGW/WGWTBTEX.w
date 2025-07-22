&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
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
/************************************************************************
program id   : wgwtbtex.w
program name : Load text file TIB to excel file     
create by    : Kridtiya i. A55-0197  12/06/2012 โปรแกรมแปลงไฟล์ text file เป็น excel file  
copy write   : wuwtbtex.w
modify by    : Kridtiya i. A63-0259 Date. 03/08/2020 เพิ่ม งาน Hino
Modify by    : Kridtiya i. A67-0184 .Date. 21/10/2024 เพิ่มข้อมูลใหม่
************************************************************************/
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */

DEF  stream ns1.
DEF  stream ns2.
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT   INIT  0.
DEFINE VAR nv_completecnt AS INT   INIT  0.
DEFINE VAR nv_enttim      AS CHAR  INIT  "".
DEFINE VAR nv_export      AS CHAR  init  ""  FORMAT "X(8)".
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD head          AS CHAR FORMAT "x(1)"   INIT ""      
    FIELD comcode       AS CHAR FORMAT "x(4)"   INIT ""      
    FIELD senddat       AS CHAR FORMAT "x(8)"   INIT ""      
    FIELD contractno    AS CHAR FORMAT "x(10)"  INIT ""     
    FIELD lotno         AS CHAR FORMAT "x(9)"   INIT ""      
    FIELD seqno         AS CHAR FORMAT "x(6)"   INIT ""      
    FIELD recact        AS CHAR FORMAT "x(1)"   INIT ""     
    FIELD STATUSno      AS CHAR FORMAT "x(1)"   INIT ""     
    FIELD flag          AS CHAR FORMAT "x(1)"   INIT ""  
    FIELD ntitle        AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD insname       AS CHAR FORMAT "x(100)" INIT ""     
    FIELD add1          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add2          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add3          AS CHAR FORMAT "x(50)"  INIT ""    
    FIELD add4          AS CHAR FORMAT "x(50)"  INIT ""     
    FIELD add5          AS CHAR FORMAT "x(5)"   INIT ""      
    /*FIELD engno         AS CHAR FORMAT "x(20)"  INIT ""  /*A67-0184*/     
    FIELD chasno        AS CHAR FORMAT "x(20)"  INIT ""*/  /*A67-0184*/ 
    FIELD engno         AS CHAR FORMAT "x(100)"  INIT ""   /*A67-0184*/    
    FIELD chasno        AS CHAR FORMAT "x(100)"  INIT ""   /*A67-0184*/  
    FIELD brand         AS CHAR FORMAT "x(3)"   INIT ""      
    FIELD model         AS CHAR FORMAT "x(40)"  INIT ""     
    FIELD cc            AS CHAR FORMAT "x(5)"   INIT ""      
    FIELD COLORno       AS CHAR FORMAT "x(4)"   INIT ""   
    FIELD reg1          AS CHAR FORMAT "x(5)"   INIT ""     
    FIELD reg2          AS CHAR FORMAT "x(5)"   INIT ""     
    FIELD provinco      AS CHAR FORMAT "x(2)"   INIT ""       
    FIELD subinsco      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD covamount     AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD grpssprem     AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD effecdat      AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD notifyno      AS CHAR FORMAT "x(100)" INIT ""       
    FIELD noticode      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD noticodesty   AS CHAR FORMAT "x(25)"  INIT ""       
    FIELD notiname      AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD substyname    AS CHAR FORMAT "x(50)"  INIT ""       
    FIELD comamount     AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD comprem       AS CHAR FORMAT "x(20)"  INIT ""       
    FIELD comeffecdat   AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD compno        AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivno       AS CHAR FORMAT "x(100)" INIT ""      
    FIELD recivcode     AS CHAR FORMAT "x(4)"   INIT ""       
    FIELD recivcosty    AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivstynam   AS CHAR FORMAT "x(50)"  INIT ""      
    FIELD comppol       AS CHAR FORMAT "x(25)"  INIT ""      
    FIELD recivstydat   AS CHAR FORMAT "x(8)"   INIT ""      
    FIELD drivnam1      AS CHAR FORMAT "x(30)"  INIT ""      
    FIELD drivnam2      AS CHAR FORMAT "x(30)"  INIT ""    
    FIELD drino1        AS CHAR FORMAT "x(13)"  INIT ""     
    FIELD drino2        AS CHAR FORMAT "x(13)"  INIT ""     
    FIELD oldeng        AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD oldchass      AS CHAR FORMAT "x(20)"  INIT ""      
    FIELD NAMEpay       AS CHAR FORMAT "x(100)" INIT ""      
    FIELD addpay1       AS CHAR FORMAT "X(50)"  INIT ""     
    FIELD addpay2       AS CHAR FORMAT "X(50)"  INIT ""      
    FIELD addpay3       AS CHAR FORMAT "X(50)"  INIT ""      
    FIELD addpay4       AS CHAR FORMAT "x(50)"  INIT ""      
    FIELD postpay       AS CHAR FORMAT "x(5)"   INIT ""       
    FIELD Reserved1     AS CHAR FORMAT "X(13)"  INIT ""      
    FIELD Reserved2     AS CHAR FORMAT "x(13)"  INIT ""      
    FIELD norcovdat     AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD norcovenddat  AS CHAR FORMAT "x(10)"  INIT ""       
    FIELD delercode     AS CHAR FORMAT "X(40)"  INIT ""       
    FIELD caryear       AS CHAR FORMAT "x(4)"   INIT ""       
    FIELD renewtyp      AS CHAR FORMAT "x(1)"   INIT ""       
    FIELD Reserved5     AS CHAR FORMAT "x(59)"  INIT ""      
    FIELD Reserved6     AS CHAR FORMAT "x(21)"  INIT ""  
    FIELD access        AS CHAR FORMAT "x(1000)" INIT ""    
    FIELD branch        AS CHAR FORMAT "x(2)"   INIT ""    
    FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD agent         AS CHAR FORMAT "x(10)"  INIT ""    
    FIELD prvpol        AS CHAR FORMAT "x(15)"  INIT ""  
    FIELD covcod        AS CHAR FORMAT "x(1)"   INIT ""  
    FIELD class         AS CHAR FORMAT "x(5)"   INIT ""
    /*---- Nopparuj P. A67-0113 [17/09/2024] ----*/
    FIELD covtype       AS CHAR FORMAT "X(2)"   INIT ""                
    FIELD garage        AS CHAR FORMAT "X(2)"   INIT ""              
    FIELD driver        AS CHAR FORMAT "X(1)"   INIT ""  
    FIELD name1         AS CHAR FORMAT "X(100)" INIT ""     
    FIELD birth1        AS CHAR FORMAT "X(8)"   INIT ""     
    FIELD licen1        AS CHAR FORMAT "X(20)"  INIT ""     
    FIELD name2         AS CHAR FORMAT "x(100)" INIT ""     
    FIELD birth2        AS CHAR FORMAT "X(8)"   INIT ""     
    FIELD licen2        AS CHAR FORMAT "X(20)"  INIT ""     
    FIELD vehuse        AS CHAR FORMAT "X(3)"   INIT ""     
    FIELD deduct        AS CHAR FORMAT "X(6)"   INIT ""     
    FIELD addcap        AS CHAR FORMAT "X(7)"   INIT ""     
    FIELD addfee        AS CHAR FORMAT "X(5)"   INIT ""     
    FIELD dealer        AS CHAR FORMAT "X(7)"   INIT ""     
    
    .   
DEFINE VAR nv_total     AS INTEGER   FORMAT "999999".
DEFINE WORKFILE wtailer   NO-UNDO
    FIELD Recordtype  AS CHAR FORMAT "X(01)"     INIT ""    /*1  Header Record "T"*/
    FIELD CompanyCode AS CHAR FORMAT "X(04)"     INIT ""    /*2  "SAFE"*/
    FIELD Datesent    AS CHAR FORMAT "X(8)"      INIT ""    /*3  yyyymmdd*/
    FIELD Usersent    AS CHAR FORMAT "X(10)"     INIT ""    /*4  TLT.'s User*/
    FIELD Lotno       AS CHAR FORMAT "X(09)"     INIT ""    /*5  Lot no.*/
    FIELD Seqno       AS CHAR FORMAT "X(06)"     INIT ""    /*6  000001*/
    FIELD Total_rec   AS CHAR FORMAT "X(6)"      INIT ""    /*7  999999*/
    FIELD Filler      AS CHAR FORMAT "X(980)"    INIT "" .  /*8  Blank.*/
DEFINE  WORKFILE wheader   NO-UNDO
    FIELD Recordtype  AS CHAR FORMAT "X(01)"     INIT ""    /*1  Header Record "H"*/
    FIELD CompanyCode AS CHAR FORMAT "X(04)"     INIT ""    /*2  "SAFE"*/
    FIELD Datesent    AS CHAR FORMAT "X(08)"     INIT ""    /*3  yyyymmdd*/
    FIELD Usersent    AS CHAR FORMAT "X(10)"     INIT ""    /*4  TLT.'s User*/
    FIELD Lotno       AS CHAR FORMAT "X(09)"     INIT ""    /*5  Lot no.*/
    FIELD Seqno       AS CHAR FORMAT "X(6)"      INIT ""    /*6  000001*/
    FIELD Filler      AS CHAR FORMAT "X(986)"    INIT "".   /*7  Blank.*/
DEF  shared  Var   n_User    As    Char.
DEF  Shared  Var   n_PassWd  As    Char.
DEFINE NEW SHARED WORKFILE wdetail1 NO-UNDO
    FIELD Recordtype    AS CHAR FORMAT "X(01)"   INIT ""    /*1  Header Record "D"*/
    FIELD CompanyCode   AS CHAR FORMAT "X(04)"   INIT ""    /*2  "SAFE"*/
    FIELD Datesent      AS CHAR FORMAT "X(08)"   INIT ""    /*3  yyyymmdd*/
    FIELD Usersent      AS CHAR FORMAT "X(10)"   INIT ""    /*4  TLT.'s User*/
    FIELD Lotno         AS CHAR FORMAT "X(09)"   INIT ""    /*5  Lot no.*/
    FIELD Seqno         AS CHAR FORMAT "X(06)"   INIT ""    /*6  Ex.000002,000003*/
    FIELD rec_active    AS CHAR FORMAT "X(01)"   INIT ""    /*7  Record Active = "A"*/
    FIELD stat          AS CHAR FORMAT "X(01)"   INIT ""    /*8  "A":Add, "E":Edit, "C":Cancel*/
    FIELD flag          AS CHAR FORMAT "X(01)"   INIT ""    /*8.1"Y":แก้ไขเลขเครื่องยนต์/ตัวถังรถ */
    FIELD pol_name      AS CHAR FORMAT "X(50)"   INIT ""    /*9  ชื่อผู้เอาประกัน*/
    FIELD pol_addr1     AS CHAR FORMAT "X(50)"   INIT ""    /*10 ที่อยู่ผู้เอาประกัน1/สำหรับส่งเอกสาร*/
    FIELD pol_addr2     AS CHAR FORMAT "X(50)"   INIT ""    /*11 ที่อยู่ผู้เอาประกัน2/สำหรับส่งเอกสาร*/
    FIELD pol_addr3     AS CHAR FORMAT "X(50)"   INIT ""    /*12 ที่อยู่ผู้เอาประกัน3/สำหรับส่งเอกสาร*/
    FIELD pol_addr4     AS CHAR FORMAT "X(50)"   INIT ""    /*13 ที่อยู่ผู้เอาประกัน4/สำหรับส่งเอกสาร*/
    FIELD pol_addr5     AS CHAR FORMAT "X(05)"   INIT ""    /*14 รหัสไปรษณีย์/สำหรับส่งเอกสาร*/
    FIELD engine        AS CHAR FORMAT "X(20)"   INIT ""    /*15 หมายเลขเครื่องยนต์*/
    FIELD chassis       AS CHAR FORMAT "X(20)"   INIT ""    /*16 หมายเลขตัวถังรถ*/
    FIELD carbrand      AS CHAR FORMAT "X(03)"   INIT ""    /*17 Car brand code:"001"=TOYOTA*/
    FIELD model         AS CHAR FORMAT "X(40)"   INIT ""    /*18 HILUX,SOLUNA*/       /*add by kridtiya i..A52-0337*/ 
    FIELD cc_weight     AS CHAR FORMAT "X(05)"   INIT ""    /*19 CC/WEIGHT KG/TON*/
    FIELD colorcode     AS CHAR FORMAT "X(04)"   INIT ""    /*20 Color Code*/
    FIELD licence1      AS CHAR FORMAT "X(05)"   INIT ""    /*21 ป้ายทะเบียนรถ 1*/        /*add by kridtiya i..A52-0337*/ 
    FIELD licence2      AS CHAR FORMAT "X(05)"   INIT ""    /*22 ป้ายทะเบียนรถ 2*/
    FIELD province      AS CHAR FORMAT "X(02)"   INIT ""    /*23 จังหวัดที่จดทะเบียนรถ*/
    FIELD subinscod     AS CHAR FORMAT "X(04)"   INIT ""    /*24 รหัสย่อยบริษัทประกันภัย(TLT.COMMENT)*/
    FIELD norcovamt     AS CHAR FORMAT "X(13)"   INIT ""    /*25 Normal Coverage Amount*/
    FIELD norgroprm     AS CHAR FORMAT "X(11)"   INIT ""    /*26 Normal Coverage Amount*/
    FIELD effdat        AS CHAR FORMAT "X(08)"   INIT ""    /*27 yyyymmdd/ effective Date*/
    FIELD tlt_noti1     AS CHAR FORMAT "X(100)"  INIT ""    /*28 เลขที่รับแจ้งฯ TLT.*/       /*add by kridtiya i..A52-0337*/  
    FIELD tlt_usr1      AS CHAR FORMAT "X(04)"   INIT ""    /*29 รหัสผู้รับแจ้งฯ TLT.*/
    FIELD notify1       AS CHAR FORMAT "X(25)"   INIT ""    /*30 เลขที่รับแจ้งฯ จากบ.ประกันภัย*/
    FIELD usr_ins1      AS CHAR FORMAT "X(50)"   INIT ""    /*31 ชื่อผู้รับแจ้งฯของ บ.ประกันภัย*/
    FIELD comp_sub      AS CHAR FORMAT "X(04)"   INIT ""    /*32 รหัสย่อย บ.ประกันภัย(TLT.COMMENT)*/
    FIELD comp_amt      AS CHAR FORMAT "X(13)"   INIT ""    /*33 Compl.Coverage amount*/
    FIELD comp_grp      AS CHAR FORMAT "X(11)"   INIT ""    /*34 Compl.Gross Premium*/
    FIELD comp_effdat   AS CHAR FORMAT "X(08)"   INIT ""    /*35 yyyymmdd/Compl.Effective date*/
    FIELD sticker       AS CHAR FORMAT "X(25)"   INIT ""    /*36 STICER NUMBER*/
    FIELD tlt_noti2     AS CHAR FORMAT "X(100)"  INIT ""    /*37 เลขที่รับแจ้งฯ TLT.*/      /*add by kridtiya i..A52-0337*/
    FIELD tlt_usr2      AS CHAR FORMAT "X(04)"   INIT ""    /*38 รหัสผู้รับแจ้งฯ TLT.*/
    FIELD notify2       AS CHAR FORMAT "X(25)"   INIT ""    /*39 เลขที่รับแจ้งฯ จากบ.ประกันภัย*/
    FIELD usr_ins2      AS CHAR FORMAT "X(50)"   INIT ""    /*40 ชื่อผู้รับแจ้งฯของ บ.ประกันภัย*/
    FIELD pol_sticker   AS CHAR FORMAT "X(25)"   INIT ""    /*41 เลขกรมธรรม์ พรบ.*/
    FIELD notdat        AS CHAR FORMAT "X(08)"   INIT ""    /*42 yyyymmdd/ วันที่บ.ประกันภัยรับแจ้งฯ*/
    FIELD spec_nam1     AS CHAR FORMAT "X(30)"   INIT ""    /*43 ชื่อผู้ขับขี่คนที่1/กรณีระบุชื่อผู้ขับขี่*/
    FIELD spec_nam2     AS CHAR FORMAT "X(30)"   INIT ""    /*44 ชื่อผู้ขับขี่คนที่2/กรณีระบุชื่อผู้ขับขี่*/
    FIELD driv_linc1    AS CHAR FORMAT "X(13)"   INIT ""    /*45 เลขที่ใบขับขี่ คนที่1*/
    FIELD driv_linc2    AS CHAR FORMAT "X(13)"   INIT ""    /*46 เลขที่ใบขับขี่ คนที่2*/
    FIELD old_engine    AS CHAR FORMAT "X(20)"   INIT ""    /*47 หมายเลขเครื่องยนต์(เดิม) <-Flag="Y"*/
    FIELD old_chassis   AS CHAR FORMAT "X(20)"   INIT ""    /*48 หมายเลขตัวถังรถ(เดิม) <-Flag="Y"*/
    FIELD vat_name      AS CHAR FORMAT "X(100)"  INIT ""    /*49 ชื่อ-สกุล/สำหรับออกใบเสร็จรับเงิน*/
    FIELD vat_addr1     AS CHAR FORMAT "X(50)"   INIT ""    /*50 ที่อยู่1/ออกใบเสร็จรับเงิน*/
    FIELD vat_addr2     AS CHAR FORMAT "X(50)"   INIT ""    /*51 ที่อยู่2/ออกใบเสร็จรับเงิน*/
    FIELD vat_addr3     AS CHAR FORMAT "X(50)"   INIT ""    /*52 ที่อยู่3/ออกใบเสร็จรับเงิน*/
    FIELD vat_addr4     AS CHAR FORMAT "X(50)"   INIT ""    /*53 ที่อยู่4/ออกใบเสร็จรับเงิน*/
    FIELD vat_addr5     AS CHAR FORMAT "X(05)"   INIT ""    /*54 รหัสไปรษณีย์/ออกใบเสร็จรับเงิน*/
    FIELD reserved1     AS CHAR FORMAT "x(13)"   INIT ""    /*55 reserved 1 */
    FIELD reserved2     AS CHAR FORMAT "x(13)"   INIT ""    /*56 reserved 2*/
    FIELD norendcddat   AS CHAR FORMAT "x(8)"    INIT ""    /*57 Normal end coverage date*/
    FIELD comendcodat   AS CHAR FORMAT "x(8)"    INIT ""    /*58 Compulsory end coverage date*/
    FIELD caryear       AS CHAR FORMAT "x(4)"    INIT ""    /*59.2 Showroom Code*/ /*(A51-0108)*/ /*add by kridtiya i..A52-0337*/
    FIELD renewtyp      AS CHAR FORMAT "x(1)"    INIT ""    /*59.1 Showroom Code*/ /*(A51-0108)*/ /*add by kridtiya i..A52-0337*/
    FIELD showroomcode  AS CHAR FORMAT "x(4)"    INIT ""    /*59.1 Showroom Code*/ /*(A51-0108)*/
    FIELD reserved5     AS CHAR FORMAT "x(59)"   INIT ""    /*59.2 reserved5*/     /*(A51-0108)*//*add by kridtiya i..A52-0337*/
    FIELD reserved6     AS CHAR FORMAT "x(21)"   INIT ""    /*60 reserved6*/
    FIELD access        AS CHAR FORMAT "x(100)"  INIT ""  
    FIELD InsuranceType       AS CHAR FORMAT "x(2)"   INIT ""   /*A67-0184*/                     
    FIELD GarageType          AS CHAR FORMAT "x(2)"   INIT ""   /*A67-0184*/               
    FIELD DriverFlag          AS CHAR FORMAT "X(1)"   INIT ""   /*A67-0184*/               
    FIELD Driver1name         AS CHAR FORMAT "x(100)" INIT ""   /*A67-0184*/                    
    FIELD Driver1DOB          AS CHAR FORMAT "x(8)"   INIT ""   /*A67-0184*/              
    FIELD Driver1License      AS CHAR FORMAT "x(20)"  INIT ""   /*A67-0184*/              
    FIELD Driver2name         AS CHAR FORMAT "x(100)" INIT ""   /*A67-0184*/                   
    FIELD Driver2DOB          AS CHAR FORMAT "x(8)"   INIT ""   /*A67-0184*/              
    FIELD Driver2License      AS CHAR FORMAT "x(20)"  INIT ""   /*A67-0184*/               
    FIELD CarUsageCode        AS CHAR FORMAT "x(3)"   INIT ""   /*A67-0184*/              
    FIELD DeductAmount        AS CHAR FORMAT "x(6)"   INIT ""   /*A67-0184*/               
    FIELD EndorseAdditionalSI AS CHAR FORMAT "x(7)"   INIT ""   /*A67-0184*/          
    FIELD EndorseAdditionalPm AS CHAR FORMAT "x(5)"   INIT ""   /*A67-0184*/   
    FIELD DealerCode          AS CHAR FORMAT "x(4)"   INIT ""   /*A67-0184*/  .
DEFINE  WORKFILE wdetailcode NO-UNDO
    FIELD n_num         AS INTE INIT 0
    FIELD n_code        AS CHAR FORMAT "x(10)" INIT ""  
    FIELD n_branch      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD n_delercode   AS CHAR FORMAT "x(15)" INIT "" .
DEF VAR nv_accdat   AS DATE     FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comdat   AS DATE     FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_expdat   AS DATE     FORMAT "99/99/9999"              NO-UNDO.
DEF VAR nv_comchr   AS  CHAR .  
DEF VAR nv_dd       AS  INT     FORMAT "99".
DEF VAR nv_mm       AS  INT     FORMAT "99".
DEF VAR nv_yy       AS  INT     FORMAT "9999".
DEF VAR nv_cpamt1   AS DECI     INIT 0. 
DEF VAR nv_cpamt2   AS DECI     INIT 0. 
DEF VAR nv_cpamt3   AS DECI     INIT 0. 
DEF VAR nv_insamt1  AS DECI     INIT 0. 
DEF VAR nv_insamt2  AS DECI     INIT 0. 
DEF VAR nv_insamt3  AS DECI     INIT 0. 
DEF VAR nv_premt1   AS DECI     INIT 0. 
DEF VAR nv_premt2   AS DECI     INIT 0. 
DEF VAR nv_premt3   AS DECI     INIT 0. 
DEF VAR nv_name1    AS CHAR     INIT ""   Format "X(30)".
DEF VAR nv_ntitle   AS CHAR     INIT ""   Format  "X(10)". 
DEF VAR nv_titleno  AS INT      INIT 0    .
DEF VAR nv_policy   AS CHAR     INIT ""    Format  "X(12)".
def var nv_source   as char  format  "X(35)".
def var nv_indexno  as int   init  0.
def var nv_indexno1 as int   init  0.
def var nv_cnt      as int   init  0.
def var nv_addr     as char  extent 4  format "X(35)".
def var nv_prem     as char  init  "".
def VAR nv_file     as char  init  "d:\fileload\return.txt".
def var nv_row      as int   init 0.
DEF VAR number      AS INT   INIT 1.
DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
DEF VAR nv_FILLER AS CHAR FORMAT "x(42)".
DEF VAR n_seqno   AS INTE FORMAT "999999" INIT 0.
DEF VAR nv_outfile4 AS CHAR.
DEF VAR nv_outfile5 AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename ra_typload ra_typced fi_campno ~
fi_outfile bu_ok bu_file fi_outfile2 fi_outfile1 fi_outfileload fi_outfile4 ~
bu_ok2 bu_exit2 fi_filename2 bu_file-2 fi_outfile3 bu_exit1 RECT-606 ~
RECT-607 RECT-612 RECT-613 RECT-614 RECT-615 RECT-616 RECT-617 
&Scoped-Define DISPLAYED-OBJECTS fi_filename ra_typload ra_typced fi_campno ~
fi_outfile fi_outfile2 fi_outfile1 fi_outfileload fi_outfile4 fi_filename2 ~
fi_outfile3 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit1 
     LABEL "EXIT" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_exit2 
     LABEL "Exit" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_file-2 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_ok2 
     LABEL "OK" 
     SIZE 7 BY 1
     FONT 6.

DEFINE VARIABLE fi_campno AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_filename2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile4 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfileload AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 55 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_typced AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Sort Cedpol_Old", 1,
"Sort Cedpol_New", 2
     SIZE 54.83 BY 1
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typload AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match file for Load     ", 1,
"Match file for Send TIB", 2
     SIZE 54.83 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-606
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 103.5 BY 21.43
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-607
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 101 BY 2
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-612
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 101 BY 5.52
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-613
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 101 BY 6.43
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-614
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-615
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-616
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-617
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.43 COL 34 COLON-ALIGNED NO-LABEL
     ra_typload AT ROW 4.57 COL 36 NO-LABEL
     ra_typced AT ROW 5.67 COL 36 NO-LABEL
     fi_campno AT ROW 6.86 COL 34 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 10.05 COL 34 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 10.91 COL 93.33
     bu_file AT ROW 3.43 COL 92
     fi_outfile2 AT ROW 12.38 COL 34 COLON-ALIGNED NO-LABEL
     fi_outfile1 AT ROW 11.24 COL 34 COLON-ALIGNED NO-LABEL
     fi_outfileload AT ROW 8.05 COL 34 COLON-ALIGNED NO-LABEL
     fi_outfile4 AT ROW 18.05 COL 34 COLON-ALIGNED NO-LABEL
     bu_ok2 AT ROW 19.86 COL 72.17
     bu_exit2 AT ROW 19.86 COL 82.17
     fi_filename2 AT ROW 16.91 COL 34 COLON-ALIGNED NO-LABEL
     bu_file-2 AT ROW 16.91 COL 91.67
     fi_outfile3 AT ROW 13.52 COL 34 COLON-ALIGNED NO-LABEL
     bu_exit1 AT ROW 13.05 COL 93.33
     "                            Text File TIB :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 3.43 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "             Output to excel file TIB :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 10.05 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Send Confirm Text  Back To TIB :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 12.38 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                    Dump Text file TIB :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 11.24 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "                             IMPORT && EXPORT TEXT FILE TIB [TOYOTA]" VIEW-AS TEXT
          SIZE 90 BY 1 AT ROW 1.71 COL 4
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "      Output file Load GW [excel]  :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 8.05 COL 3
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "                                File Type  :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 4.57 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Send Confirm Text Back To TIB :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 18.05 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                         Campaign Code :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 6.86 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "     File Excel Modify to Text TIB :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 16.91 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                          MODIFY EXCEL TO TEXT SEND CONFIRM BACK TO TIB" VIEW-AS TEXT
          SIZE 92 BY 1 AT ROW 15.67 COL 3
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Send Confirm Excel Back To TIB :" VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 13.52 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-606 AT ROW 1 COL 1
     RECT-607 AT ROW 1.24 COL 2
     RECT-612 AT ROW 9.43 COL 2
     RECT-613 AT ROW 15.29 COL 2
     RECT-614 AT ROW 19.33 COL 70.83
     RECT-615 AT ROW 19.33 COL 80.83
     RECT-616 AT ROW 10.38 COL 91.83
     RECT-617 AT ROW 12.52 COL 91.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 104 BY 21.62
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
         TITLE              = "Import and Export text file TIB[TOYOTA]"
         HEIGHT             = 21.48
         WIDTH              = 103.5
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
         VIRTUAL-WIDTH      = 170.67
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
IF NOT C-Win:LOAD-ICON("adeicon/addcomponents.ico":U) THEN
    MESSAGE "Unable to load icon: adeicon/addcomponents.ico"
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
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       bu_file-2:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import and Export text file TIB[TOYOTA] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import and Export text file TIB[TOYOTA] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit1 C-Win
ON CHOOSE OF bu_exit1 IN FRAME fr_main /* EXIT */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit2 C-Win
ON CHOOSE OF bu_exit2 IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.txt"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        IF ra_typload = 1 THEN DO:
            ASSIGN
                fi_filename    = cvData
                fi_outfile     = "" 
                fi_outfile1    = "" 
                fi_outfile2    = ""
                fi_outfile3    = ""
                fi_outfileload = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + "_ex.csv" .
            DISP fi_filename   fi_outfileload fi_outfile  fi_outfile1 fi_outfile2 fi_outfile3  WITH FRAME fr_main. 
        END.
        ELSE DO: 
            ASSIGN 
                fi_filename    = cvData
                fi_outfileload = ""
                fi_outfile  = SUBSTRING(cvData,1,r-index(cvData,"\")) + "iso" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + ".csv"     
                fi_outfile1 = SUBSTRING(cvData,1,r-index(cvData,"\")) + "isi" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + ".txt"     
                fi_outfile2 = SUBSTRING(cvData,1,r-index(cvData,"\")) + "isp" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + ".txt"     
                fi_outfile3 = SUBSTRING(cvData,1,r-index(cvData,"\")) + "isp" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + "_ex.csv" .
            DISP fi_filename fi_outfile fi_outfile1 fi_outfile2  fi_outfile3  WITH FRAME fr_main.     
        END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-2 C-Win
ON CHOOSE OF bu_file-2 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData      AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed   AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Files (*.txt)" "*.csv"
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.

    IF OKpressed = TRUE THEN DO:
        fi_filename2  = cvData.
        ASSIGN 
            fi_outfile4   = SUBSTRING(cvData,1,(LENGTH(fi_filename2) - 7))   + ".txt" .  /*.csv*/
        DISP fi_filename2 fi_outfile4 WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    IF ra_typload = 1 THEN DO:
        IF fi_outfileload = "" THEN DO:
            MESSAGE "Output to excel file TIB is emty!!! :" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfileload.
            RETURN NO-APPLY.
        END.
    END.
    ELSE DO:
        IF fi_outfile = "" THEN DO:
            MESSAGE "Output to excel file TIB is emty!!! :" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfile.
            RETURN NO-APPLY.
        END.
        IF fi_outfile1 = "" THEN DO:
            MESSAGE "Dump Text file TIB is emty!!!:" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfile1.
            RETURN NO-APPLY.
        END.
        IF fi_outfile2 = "" THEN DO:
            MESSAGE "Send Confirm Text Back To TIB is emty!!!:" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfile2.
            RETURN NO-APPLY.
        END.
    END.
    FOR EACH  wdetail:
           DELETE  wdetail.
    End.                 
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:   
        IMPORT UNFORMATTED nv_daily.
        CREATE  wdetail.
        ASSIGN
            wdetail.head         = TRIM(SUBSTRING(nv_daily,1,1))        /*1 D*/         
            wdetail.comcode      = TRIM(SUBSTRING(nv_daily,2,4))        /*2 4 */        
            wdetail.senddat      = TRIM(SUBSTRING(nv_daily,6,8))        /*3 8 yyyymmdd*/   
            wdetail.contractno   = TRIM(SUBSTRING(nv_daily,14,10))      /*4 10*/      
            wdetail.lotno        = TRIM(SUBSTRING(nv_daily,24,9))       /*5 9*/       
            wdetail.seqno        = TRIM(SUBSTRING(nv_daily,33,6))       /*6 6 000002*/       
            wdetail.recact       = TRIM(SUBSTRING(nv_daily,39,1))       /*7 A*/      
            wdetail.STATUSno     = TRIM(SUBSTRING(nv_daily,40,1))       /*8 A,E,C*/      
            wdetail.flag         = TRIM(SUBSTRING(nv_daily,41,1))       /*9 Y */       
            wdetail.insname      = TRIM(SUBSTRING(nv_daily,42,100))     /*10  100 */     
            wdetail.add1         = TRIM(SUBSTRING(nv_daily,142,50))     /*11 50 */    
            wdetail.add2         = TRIM(SUBSTRING(nv_daily,192,50))     /*12 50 */    
            wdetail.add3         = TRIM(SUBSTRING(nv_daily,242,50))     /*13 50 */    
            wdetail.add4         = TRIM(SUBSTRING(nv_daily,292,50))     /*14 50 */     
            wdetail.add5         = TRIM(SUBSTRING(nv_daily,342,5))      /*15 5  */ 
            wdetail.engno        = TRIM(SUBSTRING(nv_daily,347,100))     /*16 20 */     
            wdetail.chasno       = TRIM(SUBSTRING(nv_daily,447,100))     /*17 20 */     
            wdetail.brand        = TRIM(SUBSTRING(nv_daily,547,3))      /*18 3  */ 
            wdetail.model        = TRIM(SUBSTRING(nv_daily,550,40))     /*19 40 */     
            wdetail.cc           = TRIM(SUBSTRING(nv_daily,590,5))      /*20 5 */      
            wdetail.COLORno      = TRIM(SUBSTRING(nv_daily,595,4))      /*21 4 */      
            wdetail.reg1         = TRIM(SUBSTRING(nv_daily,599,5))      /*22 5 */      
            wdetail.reg2         = TRIM(SUBSTRING(nv_daily,604,5))      /*23 5*/      
            wdetail.provinco     = TRIM(SUBSTRING(nv_daily,609,2))      /*24 2*/     
            wdetail.subinsco     = TRIM(SUBSTRING(nv_daily,611,4))      /*25 4 */      
            wdetail.covamount    = TRIM(SUBSTRING(nv_daily,615,13))     /*26 13 */     
            wdetail.grpssprem    = TRIM(SUBSTRING(nv_daily,628,11))     /*27 11 */     
            wdetail.effecdat     = TRIM(SUBSTRING(nv_daily,639,8))      /*28 8  yyyymmdd*/      
            wdetail.notifyno     = TRIM(SUBSTRING(nv_daily,647,100))    /*29   100 */     
            wdetail.noticode     = TRIM(SUBSTRING(nv_daily,747,4))      /*30 4  */     
            wdetail.noticodesty  = TRIM(SUBSTRING(nv_daily,751,25))     /*31 25  */     
            wdetail.notiname     = TRIM(SUBSTRING(nv_daily,776,50))     /*32 50  */     
            wdetail.substyname   = TRIM(SUBSTRING(nv_daily,826,4))      /*33 4   */     
            wdetail.comamount    = TRIM(SUBSTRING(nv_daily,830,13))     /*34 13  */    
            wdetail.comprem      = TRIM(SUBSTRING(nv_daily,843,11))     /*35 11  */       
            wdetail.comeffecdat  = TRIM(SUBSTRING(nv_daily,854,8))      /*36 8 yyyymmdd */     
            wdetail.compno       = TRIM(SUBSTRING(nv_daily,862,25))     /*37 25 */    
            wdetail.recivno      = TRIM(SUBSTRING(nv_daily,887,100))    /*38 100 */    
            wdetail.recivcode    = TRIM(SUBSTRING(nv_daily,987,4))      /*39 4  */     
            wdetail.recivcosty   = TRIM(SUBSTRING(nv_daily,991,25))     /*40 25 */    
            wdetail.recivstynam  = TRIM(SUBSTRING(nv_daily,1016,50))     /*41 50 */      
            wdetail.comppol      = TRIM(SUBSTRING(nv_daily,1066,25))     /*42 25 */   
            wdetail.recivstydat  = TRIM(SUBSTRING(nv_daily,1091,8)) .    /*43 8  */  
        ASSIGN                                                        
            wdetail.drivnam1     = TRIM(SUBSTRING(nv_daily,1099,30))     /*44 30 */    
            wdetail.drivnam2     = TRIM(SUBSTRING(nv_daily,1129,30))     /*45 30 */      
            wdetail.drino1       = TRIM(SUBSTRING(nv_daily,1159,13))     /*46 13 */     
            wdetail.drino2       = TRIM(SUBSTRING(nv_daily,1172,13))    /*47 13 */     
            wdetail.oldeng       = TRIM(SUBSTRING(nv_daily,1185,100))    /*46 20 */    
            wdetail.oldchass     = TRIM(SUBSTRING(nv_daily,1285,100))    /*47 20 */    
            wdetail.NAMEpay      = TRIM(SUBSTRING(nv_daily,1385,100))   /*48 100 */    
            wdetail.addpay1      = TRIM(SUBSTRING(nv_daily,1485,50))    /*49 50 */    
            wdetail.addpay2      = TRIM(SUBSTRING(nv_daily,1535,50))    /*50 50 */    
            wdetail.addpay3      = TRIM(SUBSTRING(nv_daily,1585,50))    /*51 50 */    
            wdetail.addpay4      = TRIM(SUBSTRING(nv_daily,1635,50))    /*52 50 */    
            wdetail.postpay      = TRIM(SUBSTRING(nv_daily,1685,5))     /*53 5  */     
            wdetail.Reserved1    = TRIM(SUBSTRING(nv_daily,1690,13))    /*54 13 */    
            wdetail.Reserved2    = TRIM(SUBSTRING(nv_daily,1703,13))    /*55 13 */   
            wdetail.norcovdat    = TRIM(SUBSTRING(nv_daily,1716,8))     /*56 8 */    
            wdetail.norcovenddat = TRIM(SUBSTRING(nv_daily,1724,8))     /*57 8 */   
            wdetail.delercode    = TRIM(SUBSTRING(nv_daily,1732,4))     /*58 4 */     
            wdetail.caryear      = TRIM(SUBSTRING(nv_daily,1736,4))     /*59 4 */     
            wdetail.renewtyp     = TRIM(SUBSTRING(nv_daily,1740,1))     /*60 1 */     
            wdetail.Reserved5    = TRIM(SUBSTRING(nv_daily,1741,59))    /*61 59*/   
            wdetail.Reserved6    = TRIM(SUBSTRING(nv_daily,1800,21))    /*62 21*/  
            wdetail.access       = TRIM(SUBSTRING(nv_daily,1821,1000))   /*63 100*/  .

        /*---- Nopparuj P. A67-0113 [17/09/2024] ----*/
        ASSIGN
            wdetail.covtype     = TRIM(SUBSTRING(nv_daily,2821,2))   
            wdetail.garage      = TRIM(SUBSTRING(nv_daily,2823,2))   
            wdetail.driver      = TRIM(SUBSTRING(nv_daily,2825,1))   
            wdetail.name1       = TRIM(SUBSTRING(nv_daily,2826,100)) 
            wdetail.birth1      = TRIM(SUBSTRING(nv_daily,2926,8))   
            wdetail.licen1      = TRIM(SUBSTRING(nv_daily,2934,20))  
            wdetail.name2       = TRIM(SUBSTRING(nv_daily,2954,100)) 
            wdetail.birth2      = TRIM(SUBSTRING(nv_daily,3054,8))   
            wdetail.licen2      = TRIM(SUBSTRING(nv_daily,3062,20))  
            wdetail.vehuse      = TRIM(SUBSTRING(nv_daily,3082,3))   
            wdetail.deduct      = TRIM(SUBSTRING(nv_daily,3085,6))   
            wdetail.addcap      = TRIM(SUBSTRING(nv_daily,3091,7))   
            wdetail.addfee      = TRIM(SUBSTRING(nv_daily,3098,5))   
            wdetail.dealer      = TRIM(SUBSTRING(nv_daily,3103,5))   
            .
    END.   /* repeat  */  
    IF ra_typload = 1 THEN DO:
        RUN  Pro_assignbr.
        RUN  Pro_assignLoad.
    END.
    ELSE DO:
        RUN  Pro_assign1.
        Run  Pro_createfile.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok2 C-Win
ON CHOOSE OF bu_ok2 IN FRAME fr_main /* OK */
DO:
    IF fi_filename2 = "" THEN DO:
        MESSAGE "Output to excel file TIB is emty!!! :" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_outfile.
        RETURN NO-APPLY.
    END.
    For each  wdetail:
        DELETE  wdetail.
    End.
    INPUT FROM VALUE (fi_filename2) .  /*create in TEMP-TABLE wImport*/
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.head            
            wdetail.senddat    
            wdetail.seqno               
            wdetail.insname
            wdetail.chasno
            wdetail.engno
            wdetail.noticodesty
            wdetail.compno  
            wdetail.access .
END.  /* repeat  */  
FOR EACH wdetail.
    IF INDEX(wdetail.head,"TEXT") <> 0     THEN DELETE wdetail.
    ELSE IF INDEX(wdetail.head,"COM") <> 0 THEN DELETE wdetail.
    ELSE IF wdetail.head  = " "            THEN DELETE wdetail.
END.
ASSIGN n_seqno  = 0.
OUTPUT STREAM ns2 TO VALUE(fi_outfile4).
FOR EACH wdetail:
    n_seqno  = n_seqno  + 1.
    PUT STREAM NS2 
        "SAFE"              FORMAT "x(4)"   AT  1
        wdetail.senddat     FORMAT "x(8)"   AT  5
        n_seqno             FORMAT "999999" AT  13
        wdetail.insname     FORMAT "x(50)"  AT  19
        wdetail.chasno      FORMAT "x(20)"  AT  69
        wdetail.engno       FORMAT "x(20)"  AT  89
        wdetail.noticodesty FORMAT "x(25)"  AT  109
        wdetail.compno      FORMAT "x(25)"  AT  134
        nv_FILLER           FORMAT "x(42)"  AT  159  
        SKIP.
END.

PUT STREAM NS2 SKIP(1).
OUTPUT STREAM  ns2 CLOSE.
message "Export File  Complete"  view-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campno C-Win
ON LEAVE OF fi_campno IN FRAME fr_main
DO:
    fi_campno  =  Input  fi_campno.
    Disp  fi_campno with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename  =  Input  fi_filename.
    Disp  fi_filename  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename2 C-Win
ON LEAVE OF fi_filename2 IN FRAME fr_main
DO:
  fi_filename2  =  Input  fi_filename2.
  Disp  fi_filename2  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile1 C-Win
ON LEAVE OF fi_outfile1 IN FRAME fr_main
DO:
  fi_outfile1  =  Input  fi_outfile1.
  Disp  fi_outfile1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile2 C-Win
ON LEAVE OF fi_outfile2 IN FRAME fr_main
DO:
  fi_outfile2  =  Input  fi_outfile2.
  Disp  fi_outfile2 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile3 C-Win
ON LEAVE OF fi_outfile3 IN FRAME fr_main
DO:
  fi_outfile3  =  Input  fi_outfile3.
  Disp  fi_outfile3 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile4 C-Win
ON LEAVE OF fi_outfile4 IN FRAME fr_main
DO:
    fi_outfile4  =  Input  fi_outfile4.
    Disp fi_outfile4  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfileload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfileload C-Win
ON LEAVE OF fi_outfileload IN FRAME fr_main
DO:
  fi_outfileload  =  Input  fi_outfileload.
  Disp  fi_outfileload with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typced
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typced C-Win
ON VALUE-CHANGED OF ra_typced IN FRAME fr_main
DO:
    ra_typced = INPUT ra_typced .
    
    DISP ra_typced  WITH FRAME fr_main.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typload C-Win
ON VALUE-CHANGED OF ra_typload IN FRAME fr_main
DO:
    ra_typload = INPUT ra_typload .
    /*IF ( ra_typload = 1 ) OR ( INPUT ra_typload = 1 )  THEN DO:
        APPLY "entry" to fi_outfileload.
        DISABLE  fi_outfile  fi_outfile1  fi_outfile2  WITH FRAME fr_main.
        ENABLE fi_outfileload WITH FRAME fr_main.
        
    END.
    ELSE DO:
        APPLY "entry" to ra_typced.
        DISABLE fi_outfileload  WITH FRAME fr_main.
        ENABLE fi_outfile  fi_outfile1  fi_outfile2  WITH FRAME fr_main.
    END.*/
    IF ra_typload = 1 THEN DO:
            ASSIGN
                fi_filename    = cvData
                fi_outfile     = "" 
                fi_outfile1    = "" 
                fi_outfile2    = ""
                fi_outfile3    = ""
                fi_outfileload = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + "_ex.csv" .
            DISP fi_filename 
                fi_outfileload
                fi_outfile 
                fi_outfile1
                fi_outfile2
                fi_outfile3  WITH FRAME fr_main. 
            APPLY "entry" to fi_outfileload.
            DISABLE  fi_outfile  fi_outfile1  fi_outfile2  WITH FRAME fr_main.
            ENABLE fi_outfileload WITH FRAME fr_main.
        END.
        ELSE DO: 
            ASSIGN 
                fi_filename = cvData
                fi_outfileload = ""
                fi_outfile  = SUBSTRING(cvData,1,r-index(cvData,"\")) + "iso" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + ".csv"    
                fi_outfile1 = SUBSTRING(cvData,1,r-index(cvData,"\")) + "isi" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + ".txt"
                fi_outfile2 = SUBSTRING(cvData,1,r-index(cvData,"\")) + "isp" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + ".txt"   
                fi_outfile3 = SUBSTRING(cvData,1,r-index(cvData,"\")) + "isp" + SUBSTRING(cvData,r-index(cvData,"\") + 4,(LENGTH(fi_filename) - 14))   + "_ex.csv" . 
            DISP fi_filename 
                fi_outfileload
                fi_outfile 
                fi_outfile1
                fi_outfile2
                fi_outfile3  WITH FRAME fr_main.   
            APPLY "entry" to ra_typced.
            DISABLE fi_outfileload  WITH FRAME fr_main.
            ENABLE fi_outfile  fi_outfile1  fi_outfile2  WITH FRAME fr_main.
        END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


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
  
  gv_prgid = "wgwtbtex".
  gv_prog  = "ImportText File TIB  to Excel ".
  

  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN 
      ra_typload  = 1
      ra_typced   = 2
      fi_campno   = "CAM_TOYOTA" .
  DISP ra_typload ra_typced fi_campno WITH FRAM fr_main.
  DISABLE  fi_outfile  fi_outfile1  fi_outfile2  WITH FRAME fr_main.
  ENABLE fi_outfileload WITH FRAME fr_main.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY fi_filename ra_typload ra_typced fi_campno fi_outfile fi_outfile2 
          fi_outfile1 fi_outfileload fi_outfile4 fi_filename2 fi_outfile3 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename ra_typload ra_typced fi_campno fi_outfile bu_ok bu_file 
         fi_outfile2 fi_outfile1 fi_outfileload fi_outfile4 bu_ok2 bu_exit2 
         fi_filename2 bu_file-2 fi_outfile3 bu_exit1 RECT-606 RECT-607 RECT-612 
         RECT-613 RECT-614 RECT-615 RECT-616 RECT-617 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assigntitle C-Win 
PROCEDURE proc_assigntitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST brstat.msgcode USE-INDEX MsgCode01 WHERE
    index(wdetail.insname,brstat.msgcode.MsgDesc) <> 0  NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.msgcode  THEN 
    ASSIGN wdetail.ntitle  = brstat.msgcode.branch
           wdetail.insname = trim(SUBSTR(trim(wdetail.insname),LENGTH(trim(brstat.msgcode.MsgDesc)) + 1 )).
ELSE wdetail.ntitle = "".
IF wdetail.ntitle = "" THEN DO:
    IF INDEX(wdetail.insname,"คุณ") <> 0 THEN DO: 
        IF INDEX(wdetail.insname,"คุณหญิง") <> 0 THEN  
            ASSIGN 
            wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("คุณหญิง") ) 
            wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("คุณหญิง") + 1 )) .
        ELSE 
            ASSIGN 
                wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("คุณ") ) 
                wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("คุณ") + 1 )) . 
    END.
    ELSE IF INDEX(wdetail.insname,"นางสาว") <> 0 THEN 
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("นางสาว") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("นางสาว") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"น.ส.") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("น.ส.") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("น.ส.") + 1 )) .  
    ELSE IF INDEX(wdetail.insname,"นาง") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("นาง") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("นาง") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"นาย") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("นาย") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("นาย") + 1 )) .  
    ELSE IF INDEX(wdetail.insname,"บริษัท") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("บริษัท") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("บริษัท") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"บจก.") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("บจก.") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("บจก.") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"หจก.") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("หจก.") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("หจก.") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"พ.ต.ท.") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("พ.ต.ท.") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("พ.ต.ท.") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"พ.ต.ต.") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("พ.ต.ต.") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("พ.ต.ต.") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"ห.จ.ก.") <> 0 THEN  
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("ห.จ.ก.") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("ห.จ.ก.") + 1 )) . 
    ELSE IF INDEX(wdetail.insname,"Mr.") <> 0 THEN   
        ASSIGN 
        wdetail.ntitle  = substr(trim(wdetail.insname),1,LENGTH("MR.") )                   
        wdetail.insname = trim(substr(trim(wdetail.insname),LENGTH("Mr.") + 1 )) . 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_bu_ok_back C-Win 
PROCEDURE Proc_bu_ok_back :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* backup ปุ่ม bu_ok เก็บไว้
DO:
    IF ra_typload = 1 THEN DO:
        IF fi_outfileload = "" THEN DO:
            MESSAGE "Output to excel file TIB is emty!!! :" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfileload.
            RETURN NO-APPLY.
        END.
    END.
    ELSE DO:
        IF fi_outfile = "" THEN DO:
            MESSAGE "Output to excel file TIB is emty!!! :" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfile.
            RETURN NO-APPLY.
        END.
        IF fi_outfile1 = "" THEN DO:
            MESSAGE "Dump Text file TIB is emty!!!:" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfile1.
            RETURN NO-APPLY.
        END.
        IF fi_outfile2 = "" THEN DO:
            MESSAGE "Send Confirm Text Back To TIB is emty!!!:" VIEW-AS ALERT-BOX .
            APPLY "entry" to fi_outfile2.
            RETURN NO-APPLY.
        END.
    END.
    FOR EACH  wdetail:
           DELETE  wdetail.
    End.                 
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:   
        IMPORT UNFORMATTED nv_daily.
        CREATE  wdetail.
        ASSIGN
            wdetail.head         = TRIM(SUBSTRING(nv_daily,1,1))        /*1 D*/         
            wdetail.comcode      = TRIM(SUBSTRING(nv_daily,2,4))        /*2 4 */        
            wdetail.senddat      = TRIM(SUBSTRING(nv_daily,6,8))        /*3 8 yyyymmdd*/   
            wdetail.contractno   = TRIM(SUBSTRING(nv_daily,14,10))      /*4 10*/      
            wdetail.lotno        = TRIM(SUBSTRING(nv_daily,24,9))       /*5 9*/       
            wdetail.seqno        = TRIM(SUBSTRING(nv_daily,33,6))       /*6 6 000002*/       
            wdetail.recact       = TRIM(SUBSTRING(nv_daily,39,1))       /*7 A*/      
            wdetail.STATUSno     = TRIM(SUBSTRING(nv_daily,40,1))       /*8 A,E,C*/      
            wdetail.flag         = TRIM(SUBSTRING(nv_daily,41,1))       /*9 Y */       
            wdetail.insname      = TRIM(SUBSTRING(nv_daily,42,100))     /*10  100 */     
            wdetail.add1         = TRIM(SUBSTRING(nv_daily,142,50))     /*11 50 */    
            wdetail.add2         = TRIM(SUBSTRING(nv_daily,192,50))     /*12 50 */    
            wdetail.add3         = TRIM(SUBSTRING(nv_daily,242,50))     /*13 50 */    
            wdetail.add4         = TRIM(SUBSTRING(nv_daily,292,50))     /*14 50 */     
            wdetail.add5         = TRIM(SUBSTRING(nv_daily,342,5))      /*15 5  */      
            wdetail.engno        = TRIM(SUBSTRING(nv_daily,347,100))     /*16 20 */     
            wdetail.chasno       = TRIM(SUBSTRING(nv_daily,447,100))     /*17 20 */     
            wdetail.brand        = TRIM(SUBSTRING(nv_daily,547,3))      /*18 3  */ 
            wdetail.model        = TRIM(SUBSTRING(nv_daily,550,40))     /*19 40 */     
            wdetail.cc           = TRIM(SUBSTRING(nv_daily,590,5))      /*20 5 */      
            wdetail.COLORno      = TRIM(SUBSTRING(nv_daily,595,4))      /*21 4 */      
            wdetail.reg1         = TRIM(SUBSTRING(nv_daily,599,5))      /*22 5 */      
            wdetail.reg2         = TRIM(SUBSTRING(nv_daily,604,5))      /*23 5*/      
            wdetail.provinco     = TRIM(SUBSTRING(nv_daily,609,2))      /*24 2*/     
            wdetail.subinsco     = TRIM(SUBSTRING(nv_daily,611,4))      /*25 4 */      
            wdetail.covamount    = TRIM(SUBSTRING(nv_daily,615,13))     /*26 13 */     
            wdetail.grpssprem    = TRIM(SUBSTRING(nv_daily,628,11))     /*27 11 */     
            wdetail.effecdat     = TRIM(SUBSTRING(nv_daily,639,8))      /*28 8  yyyymmdd*/      
            wdetail.notifyno     = TRIM(SUBSTRING(nv_daily,647,100))    /*29   100 */     
            wdetail.noticode     = TRIM(SUBSTRING(nv_daily,747,4))      /*30 4  */     
            wdetail.noticodesty  = TRIM(SUBSTRING(nv_daily,751,25))     /*31 25  */     
            wdetail.notiname     = TRIM(SUBSTRING(nv_daily,776,50))     /*32 50  */     
            wdetail.substyname   = TRIM(SUBSTRING(nv_daily,826,4))      /*33 4   */     
            wdetail.comamount    = TRIM(SUBSTRING(nv_daily,830,13))     /*34 13  */    
            wdetail.comprem      = TRIM(SUBSTRING(nv_daily,843,11))     /*35 11  */       
            wdetail.comeffecdat  = TRIM(SUBSTRING(nv_daily,854,8))      /*36 8 yyyymmdd */     
            wdetail.compno       = TRIM(SUBSTRING(nv_daily,862,25))     /*37 25 */    
            wdetail.recivno      = TRIM(SUBSTRING(nv_daily,887,100))    /*38 100 */    
            wdetail.recivcode    = TRIM(SUBSTRING(nv_daily,987,4))      /*39 4  */     
            wdetail.recivcosty   = TRIM(SUBSTRING(nv_daily,991,25))     /*40 25 */    
            wdetail.recivstynam  = TRIM(SUBSTRING(nv_daily,1016,50))     /*41 50 */      
            wdetail.comppol      = TRIM(SUBSTRING(nv_daily,1066,25))     /*42 25 */   
            wdetail.recivstydat  = TRIM(SUBSTRING(nv_daily,1091,8)) .    /*43 8  */  
        ASSIGN                                                        
            wdetail.drivnam1     = TRIM(SUBSTRING(nv_daily,1099,30))     /*44 30 */    
            wdetail.drivnam2     = TRIM(SUBSTRING(nv_daily,1129,30))     /*45 30 */      
            wdetail.drino1       = TRIM(SUBSTRING(nv_daily,1159,13))     /*46 13 */     
            wdetail.drino2       = TRIM(SUBSTRING(nv_daily,1172,13))    /*47 13 */     
            wdetail.oldeng       = TRIM(SUBSTRING(nv_daily,1185,100))    /*46 20 */    
            wdetail.oldchass     = TRIM(SUBSTRING(nv_daily,1285,100))    /*47 20 */    
            wdetail.NAMEpay      = TRIM(SUBSTRING(nv_daily,1385,100))   /*48 100 */    
            wdetail.addpay1      = TRIM(SUBSTRING(nv_daily,1485,50))    /*49 50 */    
            wdetail.addpay2      = TRIM(SUBSTRING(nv_daily,1535,50))    /*50 50 */    
            wdetail.addpay3      = TRIM(SUBSTRING(nv_daily,1585,50))    /*51 50 */    
            wdetail.addpay4      = TRIM(SUBSTRING(nv_daily,1635,50))    /*52 50 */    
            wdetail.postpay      = TRIM(SUBSTRING(nv_daily,1685,5))     /*53 5  */     
            wdetail.Reserved1    = TRIM(SUBSTRING(nv_daily,1690,13))    /*54 13 */    
            wdetail.Reserved2    = TRIM(SUBSTRING(nv_daily,1703,13))    /*55 13 */   
            wdetail.norcovdat    = TRIM(SUBSTRING(nv_daily,1716,8))     /*56 8 */    
            wdetail.norcovenddat = TRIM(SUBSTRING(nv_daily,1724,8))     /*57 8 */   
            wdetail.delercode    = TRIM(SUBSTRING(nv_daily,1732,4))     /*58 4 */     
            wdetail.caryear      = TRIM(SUBSTRING(nv_daily,1736,4))     /*59 4 */     
            wdetail.renewtyp     = TRIM(SUBSTRING(nv_daily,1740,1))     /*60 1 */     
            wdetail.Reserved5    = TRIM(SUBSTRING(nv_daily,1741,59))    /*61 59*/   
            wdetail.Reserved6    = TRIM(SUBSTRING(nv_daily,1800,21))    /*62 21*/  
            wdetail.access       = TRIM(SUBSTRING(nv_daily,1821,1000))   /*63 100*/  .

        /*---- Nopparuj P. A67-0113 [17/09/2024] ----*/
        ASSIGN
            wdetail.covtype     = TRIM(SUBSTR(nv_daily,2821,2))       
            wdetail.garage      = TRIM(SUBSTR(nv_daily,2823,2))       
            wdetail.driver      = TRIM(SUBSTR(nv_daily,2825,1))     
            wdetail.name1       = TRIM(SUBSTR(nv_daily,2826,100))    
            wdetail.birth1      = TRIM(SUBSTR(nv_daily,2926,8))     
            wdetail.licen1      = TRIM(SUBSTR(nv_daily,2934,20))     
            wdetail.name2       = TRIM(SUBSTR(nv_daily,2954,100))     
            wdetail.birth2      = TRIM(SUBSTR(nv_daily,3054,8))     
            wdetail.licen2      = TRIM(SUBSTR(nv_daily,3062,20))     
            wdetail.vehuse      = TRIM(SUBSTR(nv_daily,3082,3))     
            wdetail.deduct      = TRIM(SUBSTR(nv_daily,3085,6))     
            wdetail.addcap      = TRIM(SUBSTR(nv_daily,3091,7))     
            wdetail.addfee      = TRIM(SUBSTR(nv_daily,3098,5))     
            wdetail.dealer      = TRIM(SUBSTR(nv_daily,3103,5))     
            .
    END.   /* repeat  */  
    IF ra_typload = 1 THEN DO:
        RUN  Pro_assignbr.
        RUN  Pro_assignLoad.
    END.
    ELSE DO:
        RUN  Pro_assign1.
        Run  Pro_createfile.
    END.
END.

*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign1 C-Win 
PROCEDURE Pro_assign1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail1.
    DELETE wdetail1.
END.
FOR EACH wtailer.
    DELETE wtailer.
END.
FOR EACH wheader.
    DELETE wheader.
END.
FOR EACH wdetail WHERE wdetail.head = "d" NO-LOCK
    BREAK BY wdetail.seqno :
    FIND FIRST wdetail1 WHERE wdetail1.usersent = trim(wdetail.contractno)  NO-ERROR NO-WAIT.
    IF NOT AVAIL wdetail1 THEN DO:
        CREATE wdetail1.
        ASSIGN 
        wdetail1.Recordtype   = wdetail.head                 /*1  Header Record    */
        wdetail1.CompanyCode  = wdetail.comcode              /*2  Company Code     */
        wdetail1.Datesent     = wdetail.senddat              /*3  date   99/99/9999 Date Sent*/
        wdetail1.usersent     = trim(wdetail.contractno)     /*4  char   x(10)      User Sent*/
        wdetail1.lotno        = wdetail.lotno                /*5  char   x(9)       Lot No.  */
        wdetail1.seqno        = wdetail.seqno                /*6  inte   999999     Seq.No.  */
        wdetail1.rec_active   = wdetail.recact               /*7  char   x          Record Active*/
        wdetail1.stat         = wdetail.STATUSno             /*8  char   x          Status       */
        wdetail1.flag         = wdetail.flag                 /*8.1char   x          Flag         */
        wdetail1.pol_name     = wdetail.insname              /*9  char   x(50)      Ins.Name     /ชื่อผู้เอาประกัน */
        wdetail1.pol_addr1    = wdetail.add1                 /*10 char   x(30)      Ins.Address1 /ที่อยู่ผู้เอาประกัน 1*/
        wdetail1.pol_addr2    = wdetail.add2                 /*11 char   x(30)      Ins.Address 2/ที่อยู่ผู้เอาประกัน 2*/
        wdetail1.pol_addr3    = wdetail.add3                 /*12 char   x(30)      Ins.Address 3/ที่อยู่ผู้เอาประกัน 3*/
        wdetail1.pol_addr4    = wdetail.add4                 /*13 char   x(30)      Ins.Address 4/ที่อยู่ผู้เอาประกัน 4*/
        wdetail1.pol_addr5    = wdetail.add5                 /*14 char   x(5)       Ins.Addr 5   /รหัสไปรษณีย์*/
        wdetail1.engine       = wdetail.engno                /*15 char   x(20)      Engine no.    */
        wdetail1.chassis      = wdetail.chasno               /*16 char   x(20)      Chassis no.   */
        wdetail1.carbrand     = wdetail.brand                /*17 char   x(3)       Car Brand Code*/
        wdetail1.model        = wdetail.model                /*18 char   x(25)      Model         */
        wdetail1.cc_weight    = wdetail.cc                   /*19 inte   >>,>>9     CC./weight(นน.กิโล)*/
        wdetail1.colorcode    = wdetail.COLORno              /*20 char   x(4)       Color Code    */
        wdetail1.licence1     = wdetail.reg1                 /*21 char   x(2)       ทะเบียนรถ1  */
        wdetail1.licence2     = wdetail.reg2                 /*22 char   x(5)       ทะเบียนรถ2  */
        wdetail1.province     = wdetail.provinco             /*23 char   x(2)       จว.จดทะเบียน */
        wdetail1.subinscod    = wdetail.subinsco             /*24 char   x(4)       รหัสย่อยบ.ประกัน(TLT.C */
        wdetail1.norcovamt    = wdetail.covamount            /*25 deci-2 9(13)      Normal Coverage amount*/
        wdetail1.norgroprm    = wdetail.grpssprem            /*26 deci-2 9(13)      Normal Gross premium  */
        wdetail1.effdat       = wdetail.effecdat             /*27 date   99/99/9999 Effective date        */
        wdetail1.tlt_noti1    = wdetail.notifyno             /*28 char   x(25)      เลขรับแจ้งฯ,TLT       */
        wdetail1.tlt_usr1     = wdetail.noticode             /*29 char   x(4)       รหัสผู้รับแจ้งฯ,TLT   */
        wdetail1.notify1      = wdetail.noticodesty          /*30 char   x(25)      Policy no. /เลขรับแจ้งฯจากบ.ประกัน*/
        wdetail1.usr_ins1     = n_User    /*wdetail.notiname */            /*31 char   x(50)      ชื่อผู้รับแจ้งฯของบ.ปร         */
        wdetail1.comp_sub     = wdetail.substyname           /*32 char   x(4)       Comp.Sub Insurance Cod/รหัสย่อยบ.ประกัน(TLT.C*/
        wdetail1.comp_amt     = wdetail.comamount            /*33 deci-2 9(10)      Comp.Coverage amount*/
        wdetail1.comp_grp     = wdetail.comprem              /*34 deci-2 9(10)      Compl.Gross premium */
        wdetail1.comp_effdat  = wdetail.comeffecdat          /*35 date   99/99/9999 Compl.Effective date*/
        wdetail1.sticker      = wdetail.compno               /*36 char   x(25)      เครื่องหมาย(พรบ.)   */     
        wdetail1.tlt_noti2    = wdetail.recivno              /*37 char   x(25)      เลขที่รับแจ้งฯ TLT. */
        wdetail1.tlt_usr2     = wdetail.recivcode            /*38 char   x(4)       รหัสผู้รับแจ้งฯ TLT. */
        wdetail1.notify2      = wdetail.recivcosty           /*39 char   x(25)      เลขรับแจ้งฯจากบ.ประกัน*/
        wdetail1.usr_ins2     = n_User      /*wdetail.recivstynam */         /*40 char   x(50)      ชื่อผู้รับแจ้งฯของบ.ปร*/
        wdetail1.pol_sticker  = wdetail.comppol              /*41 char   x(25)      เลขกรมธรรม์ พรบ. */
        wdetail1.notdat       = STRING(year(TODAY)) +             /*42 date   99/99/9999 วันที่บ.ประกัน รับแจ้ง */
                                STRING(MONTH(TODAY)) + STRING(DAY(TODAY)) 
        wdetail1.spec_nam1    = wdetail.drivnam1             /*43 char   x(30)      Driver Name1/ชื่อผู้ขับขี่คนที่ 1*/
        wdetail1.spec_nam2    = wdetail.drivnam2             /*44 char   x(30)      Driver Name2/ชื่อผู้ขับขี่คนที่ 2 */
        wdetail1.driv_linc1   = wdetail.drino1               /*45 char   x(13)      Driver No.1 /เลขที่ใบขับขี่คนที่1*/
        wdetail1.driv_linc2   = wdetail.drino2               /*46 char   x(13)      Driver No.2 /เลขที่ใบขับขี่คนที่2*/
        wdetail1.old_engine   = wdetail.oldeng               /*47 char   x(20)      Old Engine */
        wdetail1.old_chassis  = wdetail.oldchass             /*48 char   x(20)      Old Chassis*/
        wdetail1.vat_name     = wdetail.NAMEpay              /*49 char   x(50)      ชื่อ-สกุล */
        wdetail1.vat_addr1    = wdetail.addpay1              /*50 char   x(30)      ที่อยู่บรรทั 1*/
        wdetail1.vat_addr2    = wdetail.addpay2              /*51 char   x(30)      ที่อยู่ 2 */
        wdetail1.vat_addr3    = wdetail.addpay3              /*52 char   x(30)      ที่อยู่ 3 */
        wdetail1.vat_addr4    = wdetail.addpay4              /*53 char   x(30)      ที่อยู่ 4 */
        wdetail1.vat_addr5    = wdetail.postpay              /*54 char   x(5)       รหัสไปรษณีย์ */
        wdetail1.reserved1    = wdetail.Reserved1            /*55 reserved1*/
        wdetail1.reserved2    = wdetail.Reserved2            /*56 reserved2*/  
        wdetail1.norendcddat  = wdetail.norcovdat            /*57 normal end coverage date*/ 
        wdetail1.comendcodat  = wdetail.norcovenddat         /*58 compulsory end coverage date */
        wdetail1.showroomcode = wdetail.delercode            /*59.1 showroomcode*/ /*(A51-0108)*/  
        wdetail1.caryear      = wdetail.caryear              /*59.2 caryear     */ /*(A51-0108)*/  
        wdetail1.renewtyp     = wdetail.renewtyp             /*59.3 renewtyp    */ /*(A51-0108)*/  
        wdetail1.reserved5    = wdetail.Reserved5            /*59.4 reserved5   */ /*(A51-0108)*/
        wdetail1.reserved6    = wdetail.Reserved6            /*60 reserved6*/   /*(A51-0108)*/      
        wdetail1.access       = wdetail.access               /*kridtiya i. A53-0351*/
        wdetail1.InsuranceType       = wdetail.covtype       
        wdetail1.GarageType          = wdetail.garage           
        wdetail1.DriverFlag          = wdetail.driver          
        wdetail1.Driver1name         = wdetail.name1         
        wdetail1.Driver1DOB          = wdetail.birth1        
        wdetail1.Driver1License      = wdetail.licen1        
        wdetail1.Driver2name         = wdetail.name2        
        wdetail1.Driver2DOB          = wdetail.birth2       
        wdetail1.Driver2License      = wdetail.licen2       
        wdetail1.CarUsageCode        = wdetail.vehuse       
        wdetail1.DeductAmount        = wdetail.deduct   
        wdetail1.EndorseAdditionalSI = wdetail.addcap   
        wdetail1.EndorseAdditionalPm = wdetail.addfee   
        wdetail1.DealerCode          = wdetail.dealer  .  
        IF LAST-OF(wdetail.seqno)  THEN DO:
            CREATE wheader.
            ASSIGN wheader.Recordtype  = "H"                  /*1 CHAR "X(01)"     Header Record "H"*/
                wheader.CompanyCode = wdetail1.CompanyCode /*2 CHAR "X(04)"     "SAFE"*/
                wheader.Datesent    = wdetail1.Datesent    /*3 INTE "99999999"  yyyymmdd*/
                wheader.Usersent    = wdetail1.Usersent    /*4 CHAR "X(10)"     TLT.'s User*/
                wheader.Lotno       = wdetail1.Lotno       /*5 INTE "999999999" Lot no.*/
                wheader.Seqno       = wdetail1.Seqno.      /*6 INTE "999999"    Seq. no.*/
            END.

    END.

END.
RUN  Pro_assign2.
RUN  Pro_assign3.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign2 C-Win 
PROCEDURE Pro_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_deci AS DECI INIT 0 .
FOR EACH wdetail WHERE wdetail.head = "d" .
    ASSIGN n_deci            = deci(wdetail.covamount)           /*26*/ 
        n_deci               = n_deci / 100
        wdetail.covamount    = STRING(n_deci)
        n_deci               = deci(wdetail.grpssprem)           /*27*/  
        n_deci               = n_deci / 100
        wdetail.grpssprem    = STRING(n_deci)
        n_deci               = deci(wdetail.comamount)           
        n_deci               = n_deci / 100
        wdetail.comamount    = STRING(n_deci)
        n_deci               = deci(wdetail.comprem)           
        n_deci               = n_deci / 100
        wdetail.comprem      = STRING(n_deci).
    IF (wdetail.effecdat = "") OR (wdetail.effecdat = "00000000") THEN wdetail.effecdat = "".
    ELSE wdetail.effecdat     = SUBSTR(wdetail.effecdat,7,2) + "/" +  
                               SUBSTR(wdetail.effecdat,5,2) + "/" +  
                               SUBSTR(wdetail.effecdat,1,4).
    IF (wdetail.comeffecdat = "") OR (wdetail.comeffecdat = "00000000") THEN wdetail.comeffecdat = "".
    ELSE wdetail.comeffecdat  = SUBSTR(wdetail.comeffecdat,7,2) + "/" +  
                               SUBSTR(wdetail.comeffecdat,5,2) + "/" +  
                               SUBSTR(wdetail.comeffecdat,1,4) .
    IF (wdetail.norcovdat = "") OR (wdetail.norcovdat = "00000000") THEN wdetail.norcovdat = "".
    ELSE wdetail.norcovdat     = SUBSTR(wdetail.norcovdat,7,2) + "/" +  
                                SUBSTR(wdetail.norcovdat,5,2) + "/" +  
                                SUBSTR(wdetail.norcovdat,1,4).
    IF (wdetail.norcovenddat = "") OR (wdetail.norcovenddat = "00000000") THEN wdetail.norcovenddat = "".
    ELSE  wdetail.norcovenddat  = SUBSTR(wdetail.norcovenddat,7,2) + "/" +  
                                SUBSTR(wdetail.norcovenddat,5,2) + "/" +  
                                SUBSTR(wdetail.norcovenddat,1,4) .
    
    IF wdetail.subinsco      = "K1KK" THEN  wdetail.subinsco = "ใบเสร็จส่วนบุคคลดำเนินการเอง" . 
    ELSE IF wdetail.subinsco = "K2KK" THEN  wdetail.subinsco = "ใบเสร็จนิติบุคคลดำเนินการเอง" .
    ELSE IF wdetail.subinsco = "K3KK" THEN  wdetail.subinsco = "ใบเสร็จดีเลอร์ประกันเก็บเงิน" .
    ELSE IF wdetail.subinsco = "K1ZZ" THEN  wdetail.subinsco = "ใบเสร็จส่วนบุคคลประกันเก็บเงิน" . 
    ELSE IF wdetail.subinsco = "K2ZZ" THEN  wdetail.subinsco = "ใบเสร็จนิติบุคคลประกันเก็บเงิน" .
    ELSE IF wdetail.subinsco = "K3ZZ" THEN  wdetail.subinsco = "ใบเสร็จดีเลอร์ประกันเก็บเงิน" .
    IF      wdetail.substyname  = "K1KK" THEN  wdetail.substyname = "ใบเสร็จส่วนบุคคลดำเนินการเอง" . 
    ELSE IF wdetail.substyname  = "K2KK" THEN  wdetail.substyname = "ใบเสร็จนิติบุคคลดำเนินการเอง" .
    ELSE IF wdetail.substyname  = "K3KK" THEN  wdetail.substyname = "ใบเสร็จดีเลอร์ดำเนินการเอง" .
    ELSE IF wdetail.substyname  = "K1ZZ" THEN  wdetail.substyname = "ใบเสร็จส่วนบุคคลประกันเก็บเงิน" . 
    ELSE IF wdetail.substyname  = "K2ZZ" THEN  wdetail.substyname = "ใบเสร็จนิติบุคคลประกันเก็บเงิน" .
    ELSE IF wdetail.substyname  = "K3ZZ" THEN  wdetail.substyname = "ใบเสร็จดีเลอร์ประกันเก็บเงิน" .
    /*add Kridtiya i. A530263....*/
    FIND FIRST stat.insure USE-INDEX insure01 
        WHERE insure.compno = "TIB" AND
        stat.insure.lname   = wdetail.delercode   NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL stat.insure THEN wdetail.delercode = stat.Insure.FName .
    /*add Kridtiya i. A530263....*/
    RUN pro_assign4.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assign3 C-Win 
PROCEDURE Pro_assign3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*add endcomment.. Kridtiya i. A54-0178 */
DEF VAR n_polced70   AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_polced72   AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_comdate70  AS DATE FORMAT "99/99/9999" INIT ? .
DEF VAR n_comdate72  AS DATE FORMAT "99/99/9999" INIT ? .
/*end..add endcomment.. Kridtiya i. A54-0178 */

ASSIGN nv_total = 0 .
FOR EACH  wdetail1  .
    nv_total = nv_total + 1.
    /*add endcomment.. Kridtiya i. A54-0178 */
    IF ra_typced = 2  THEN DO:
        ASSIGN 
            n_polced70   = ""
            n_polced72   = ""
            n_comdate70  = ? 
            n_comdate72  = ?.
        FOR EACH sicuw.uwm100 USE-INDEX uwm10002  WHERE 
            sicuw.uwm100.cedpol  =  wdetail1.usersent NO-LOCK.
            
            IF sicuw.uwm100.poltyp  = "v70"   THEN DO:
                IF n_comdate70 = ? THEN 
                    ASSIGN n_polced70  = sicuw.uwm100.policy
                           n_comdate70 = sicuw.uwm100.comdat.
                ELSE DO:
                    IF sicuw.uwm100.comdat > n_comdate70  THEN
                        ASSIGN 
                        n_polced70 = sicuw.uwm100.policy
                        n_comdate70  = sicuw.uwm100.comdat.
                END.
            END.
            ELSE DO:
                IF n_comdate72 = ? THEN 
                    ASSIGN n_polced72   = sicuw.uwm100.policy
                           n_comdate72  = sicuw.uwm100.comdat.
                ELSE DO:
                    IF sicuw.uwm100.comdat > n_comdate72  THEN
                        ASSIGN 
                        n_polced72  = sicuw.uwm100.policy
                        n_comdate72 = sicuw.uwm100.comdat.
                END.

            END.
        END.
        ASSIGN  wdetail1.tlt_noti1   = n_polced70
                wdetail1.notify1     = n_polced70
                wdetail1.notify2     = n_polced70
                wdetail1.pol_sticker = n_polced72
                wdetail1.sticker     = n_polced72. 

        FIND FIRST wtailer WHERE wtailer.Recordtype  = "T"  NO-ERROR NO-WAIT.
        IF NOT AVAIL wtailer THEN
            CREATE wtailer.
        ASSIGN 
            wtailer.Recordtype  = "T"                        /*1 CHAR "X(01)"     Header Record "H"*/
            wtailer.CompanyCode = wdetail1.CompanyCode       /*2 CHAR "X(04)"     "SAFE"*/
            wtailer.Datesent    = wdetail1.Datesent          /*3 CHAR "99999999"  yyyymmdd*/
            wtailer.Usersent    = wdetail1.Usersent          /*4 CHAR "X(10)"     TLT.'s User*/
            wtailer.Lotno       = wdetail1.Lotno             /*5 CHAR "999999999" Lot no.*/
            wtailer.Seqno       = wdetail1.Seqno             /*6 CHAR "999999"    Seq. no.*/
            wtailer.Total_rec   = STRING(nv_total,"999999"). /*7 CHAR "X(6)"  */
    END.
    ELSE DO:  /*add endcomment.. Kridtiya i. A54-0178 */
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002      WHERE 
            sicuw.uwm100.cedpol  =  wdetail1.usersent  AND
            sicuw.uwm100.poltyp  = "v70"               NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            /*comment by Kridtiya i. A530263....
        FIND LAST uwm301 USE-INDEX uwm30103 WHERE
            uwm301.trareg = wdetail1.chassis AND 
            uwm301.policy = sicuw.uwm100.policy
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN 
            ASSIGN wdetail1.tlt_noti1 = uwm301.policy
                   wdetail1.notify1  = uwm301.policy 
                   wdetail1.notify2  = uwm301.policy.
        end...comment by Kridtiya i. A530263....*/
        /*add Kridtiya i. A530263....*/
            ASSIGN wdetail1.tlt_noti1 = sicuw.uwm100.policy
                wdetail1.notify1  = sicuw.uwm100.policy 
                wdetail1.notify2  = sicuw.uwm100.policy.
            /*add Kridtiya i. A530263....*/
        END.
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  /*policy 72 */
            sicuw.uwm100.cedpol  =  wdetail1.usersent  AND 
            sicuw.uwm100.poltyp  =  "v72"  
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            /*comment by Kridtiya i. A530263....
            FIND LAST uwm301 USE-INDEX uwm30103 WHERE
            uwm301.trareg = wdetail1.chassis AND 
            uwm301.policy = sicuw.uwm100.policy
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN 
            ASSIGN wdetail1.pol_sticker  = uwm301.policy.
          end...comment by Kridtiya i. A530263....*/
            ASSIGN wdetail1.pol_sticker  = sicuw.uwm100.policy  /*add Kridtiya i. A530263....*/
                wdetail1.sticker = sicuw.uwm100.policy .        /*add Kridtiya i. A530263....*/
        END.
        ELSE ASSIGN wdetail1.pol_sticker  = "".
        FIND FIRST wtailer WHERE wtailer.Recordtype  = "T"  NO-ERROR NO-WAIT.
        IF NOT AVAIL wtailer THEN
            CREATE wtailer.
        ASSIGN 
            wtailer.Recordtype  = "T"                        /*1 CHAR "X(01)"     Header Record "H"*/
            wtailer.CompanyCode = wdetail1.CompanyCode       /*2 CHAR "X(04)"     "SAFE"*/
            wtailer.Datesent    = wdetail1.Datesent          /*3 CHAR "99999999"  yyyymmdd*/
            wtailer.Usersent    = wdetail1.Usersent          /*4 CHAR "X(10)"     TLT.'s User*/
            wtailer.Lotno       = wdetail1.Lotno             /*5 CHAR "999999999" Lot no.*/
            wtailer.Seqno       = wdetail1.Seqno             /*6 CHAR "999999"    Seq. no.*/
            wtailer.Total_rec   = STRING(nv_total,"999999"). /*7 CHAR "X(6)"  */
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_assign4 C-Win 
PROCEDURE pro_assign4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wdetail.noticode = "TLT" THEN wdetail.noticode = "บจก.โตโยต้าลีสซิ่ง (ปทท.)".
ELSE IF wdetail.noticode = "W01" THEN wdetail.noticode = "บมจ. เงินทุน เอไอจี ไฟแนนซ์ (ประเทศไทย)".
ELSE IF wdetail.noticode = "W02" THEN wdetail.noticode = "บมจ. นวลิสซิ่ง".
ELSE IF wdetail.noticode = "W03" THEN wdetail.noticode = "ธนาคาร ทิสโก้ จำกัด (มหาชน)".
ELSE IF wdetail.noticode = "W04" THEN wdetail.noticode = "บจก.ตรีเพชรอีซูซุลีสซิ่ง".
ELSE IF wdetail.noticode = "W05" THEN wdetail.noticode = "ธนาคาร เกียรตินาคิน จำกัด (มหาชน)".
ELSE IF wdetail.noticode = "W06" THEN wdetail.noticode = "บมจ. เงินทุน สินอุตสาหกรรม".
ELSE IF wdetail.noticode = "W07" THEN wdetail.noticode = "บริษัท ซัมมิท แคปปิตอล ลีสซิ่ง".
ELSE IF wdetail.noticode = "W08" THEN wdetail.noticode = "บจก. สแตนดาร์ด ชาร์เตอร์ (ประเทศไทย)".
ELSE IF wdetail.noticode = "W09" THEN wdetail.noticode = "บมจ. อยุธยา แคปปิตอล ออโต้ ลีส".
ELSE IF wdetail.noticode = "W10" THEN wdetail.noticode = "บจก. ไพรมัส ลีสซิ่ง".
ELSE IF wdetail.noticode = "W11" THEN wdetail.noticode = "บมจ. เอเซียเสริมกิจลีสซิ่ง".
ELSE IF wdetail.noticode = "W12" THEN wdetail.noticode = "ธนาคาร ธนชาต จำกัด (มหาชน)".
ELSE IF wdetail.noticode = "W13" THEN wdetail.noticode = "บจก. ยู เอ็ม แอล ลีสซิ่ง".
ELSE IF wdetail.noticode = "W14" THEN wdetail.noticode = "บจก. ยูไนเต็ดลีสซิ่ง".
ELSE IF wdetail.noticode = "W15" THEN wdetail.noticode = "บมจ. ไทยพาณิชย์ลีสซิ่ง".
ELSE IF wdetail.noticode = "W16" THEN wdetail.noticode = "บจก. ชยภาค".
ELSE IF wdetail.noticode = "W17" THEN wdetail.noticode = "บจก. พระนคร ยนตการ".
ELSE IF wdetail.noticode = "W18" THEN wdetail.noticode = "บจก. ซิตี้คอร์ป ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.noticode = "W19" THEN wdetail.noticode = "บจก. เจนเนอรัล มอเตอร์ส แอคเซพแตนซ์ คอร์ปอเรชั่น(ประเทศไทย)".
ELSE IF wdetail.noticode = "W20" THEN wdetail.noticode = "บจก. กรุงเทพทรัพย์ถาวร".
ELSE IF wdetail.noticode = "W21" THEN wdetail.noticode = "บจก. บีเอ็มดับเบิลยู ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.noticode = "W22" THEN wdetail.noticode = "บมจ. สแกนดิเนเวียลีสซิ่ง".
ELSE IF wdetail.noticode = "W23" THEN wdetail.noticode = "บมจ. ราชธานีลีสซิ่ง".
ELSE IF wdetail.noticode = "W24" THEN wdetail.noticode = "บจก. เดมเลอร์ไครสเลอร์ ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.noticode = "W25" THEN wdetail.noticode = "บจก. ตะวันออกพาณิชย์ลีสซิ่ง (ประเทศไทย)".
ELSE IF wdetail.noticode = "W26" THEN wdetail.noticode = "บมจ. จีอี แคปปิตอล ออโต้ ลีส".
ELSE IF wdetail.noticode = "W27" THEN wdetail.noticode = "บจก. ไทยประกันชีวิต".
ELSE IF wdetail.noticode = "W28" THEN wdetail.noticode = "บจก. คลังเศรษฐการ".
ELSE IF wdetail.noticode = "W29" THEN wdetail.noticode = "บจก. เอ. ที ลีสซิ่ง".
ELSE IF wdetail.noticode = "W30" THEN wdetail.noticode = "บจก. ทวีทรัพย์สมเด็จ".
ELSE IF wdetail.noticode = "W31" THEN wdetail.noticode = "บจก. กรุงไทย ออโตลีส".
ELSE IF wdetail.noticode = "W32" THEN wdetail.noticode = "บจก. ลีสซิ่งกสิกรไทย".
ELSE IF wdetail.noticode = "W33" THEN wdetail.noticode = "บจก. บีที ลีสซิ่ง".
ELSE IF wdetail.noticode = "W34" THEN wdetail.noticode = "บจก. ลีสซิ่งสินเอเซีย".
ELSE IF wdetail.noticode = "W35" THEN wdetail.noticode = "บจก. เคทีบี ลีสซิ่ง".
ELSE IF wdetail.noticode = "W36" THEN wdetail.noticode = "บจก.โตโยต้า มอเตอร์ ประเทศไทย".
ELSE IF wdetail.noticode = "W37" THEN wdetail.noticode = "บจก.บางกอก มิตซูบิชิ ยูเอฟเจ ลิส".
ELSE IF wdetail.noticode = "W38" THEN wdetail.noticode = "ธนาคาร ไทยเครดิต เพื่อรายย่อย จำกัด (มหาชน)".
ELSE IF wdetail.noticode = "W39" THEN wdetail.noticode = "บจก. เงินทุน ฟินันซ่า".
ELSE IF wdetail.noticode = "W40" THEN wdetail.noticode = "บจก. โปรออโต้ลีส".
ELSE IF wdetail.noticode = "W41" THEN wdetail.noticode = "บจก.โตโยต้า สุรินทร์(1991)".
ELSE IF wdetail.noticode = "W42" THEN wdetail.noticode = "ธนาคารเอไอจี เพื่อรายย่อย จำกัด(มหาชน)".
ELSE IF wdetail.noticode = "w43" THEN wdetail.noticode = "ธนาคารไทยพาณิชย์ จำกัด (มหาชน)".
ELSE IF wdetail.noticode = "w44" THEN wdetail.noticode = "บจก.ไทยโอริกซ์ลีสซิ่ง".
ELSE IF wdetail.noticode = "w45" THEN wdetail.noticode = "บจก.ทิสโก้ โตเกียว ลิสซิ่ง".
ELSE IF wdetail.noticode = "w46" THEN wdetail.noticode = "บจก.ซูมิโตโม มิตซุย ออโต้ ลิสซิ่ง แอนด์ เซอร์วิส (ไทยแลนด์)".
ELSE IF wdetail.noticode = "w47" THEN wdetail.noticode = "บจก.โตโยต้าชุมพร ผู้จำหน่ายโตโยต้า ".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assignbr C-Win 
PROCEDURE Pro_assignbr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_model01  AS CHAR FORMAT "x(50)".
DEF VAR n_model02  AS CHAR FORMAT "x(50)".
DEF VAR n_setclass AS CHAR FORMAT "x(20)". 
DEF VAR n_matbrand AS CHAR FORMAT "x(50)".  /*A63-0259*/
ASSIGN 
    n_model01  = ""
    n_model02  = ""  
    n_setclass = "" 
    n_matbrand = "".

FOR EACH wdetail   NO-LOCK 
    WHERE wdetail.head = "d"  .
    FIND FIRST stat.insure USE-INDEX Insure06 WHERE 
        stat.insure.lname  = wdetail.delercode  AND
        stat.insure.compno = "TIB" NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL insure THEN 
        ASSIGN  
        wdetail.branch   = stat.insure.branch
        wdetail.producer = stat.insure.addr1
        wdetail.agent    = stat.insure.addr2 .
    ELSE 
        ASSIGN  
            wdetail.branch   = ""
            wdetail.producer = ""
            wdetail.agent    = ""  . 
    RUN proc_assigntitle.
    /*Add A63-0259 Match brand */
    IF      trim(wdetail.brand) = "001" THEN  n_matbrand = "TOYOTA"        .     /*โตโยต้า          */    
    ELSE IF trim(wdetail.brand) = "002" THEN  n_matbrand = "HINO"          .     /*ฮีโน่                */
    ELSE IF trim(wdetail.brand) = "003" THEN  n_matbrand = "CHEROKEE"      .     /*เชอโรกี          */    
    ELSE IF trim(wdetail.brand) = "004" THEN  n_matbrand = "DAIHATSU"      .     /*ไดฮัทสุ          */    
    ELSE IF trim(wdetail.brand) = "005" THEN  n_matbrand = "VOLVO"         .     /*วอลโว่           */    
    ELSE IF trim(wdetail.brand) = "006" THEN  n_matbrand = "BMW"           .     /*บีเอ็มดับบลิว        */
    ELSE IF trim(wdetail.brand) = "007" THEN  n_matbrand = "NISSAN"        .     /*นิสสัน           */    
    ELSE IF trim(wdetail.brand) = "008" THEN  n_matbrand = "OPEL"          .     /*โอเปิล           */    
    ELSE IF trim(wdetail.brand) = "009" THEN  n_matbrand = "SAAB"          .     /*ซาบ           */  
    ELSE IF trim(wdetail.brand) = "010" THEN  n_matbrand = "PEUGEOT"       .     /*เปอร์โย          */    
    ELSE IF trim(wdetail.brand) = "011" THEN  n_matbrand = "CHRYSLER"      .     /*ไคร์สเลอร์   */    
    ELSE IF trim(wdetail.brand) = "012" THEN  n_matbrand = "VOLKSWAGEN"    .     /*โวสวาเกนต์   */    
    ELSE IF trim(wdetail.brand) = "013" THEN  n_matbrand = "MITSUBISHI"    .     /*มิซูบิชิ         */
    ELSE IF trim(wdetail.brand) = "014" THEN  n_matbrand = "ISUZU"         .     /*อีซูซุ           */    
    ELSE IF trim(wdetail.brand) = "015" THEN  n_matbrand = "MAZDA"         .     /*มาสด้า           */    
    ELSE IF trim(wdetail.brand) = "016" THEN  n_matbrand = "CITROEN"       .     /*ซีตรอง           */    
    ELSE IF trim(wdetail.brand) = "017" THEN  n_matbrand = "HONDA"         .     /*ฮอนด้า           */    
    ELSE IF trim(wdetail.brand) = "018" THEN  n_matbrand = "LEXUS"         .     /*เล็กซัส          */    
    ELSE IF trim(wdetail.brand) = "999" THEN  n_matbrand = "Other"         .     /*อื่นๆ                */
    ELSE IF trim(wdetail.brand) = "101" THEN  n_matbrand = "CITIA HARDWARE".     /*CITIA HARDWARE*/     
    ELSE IF trim(wdetail.brand) = "031" THEN  n_matbrand = "HARRIER"       .     /*แฮริเออร์        */
    ELSE IF trim(wdetail.brand) = "032" THEN  n_matbrand = "RANGE ROVER"   .     /*RANGE ROVER  */    
    ELSE IF trim(wdetail.brand) = "030" THEN  n_matbrand = "Porsche"       .     /*ปอร์เช่          */    
    ELSE IF trim(wdetail.brand) = "019" THEN  n_matbrand = "Benz"          .     /*เบนซ์                */
    ELSE IF trim(wdetail.brand) = "020" THEN  n_matbrand = "Audi"          .     /*ออดี้                */
    ELSE IF trim(wdetail.brand) = "021" THEN  n_matbrand = "Ford"          .     /*ฟอร์ด                */
    ELSE IF trim(wdetail.brand) = "022" THEN  n_matbrand = "SUZUKI"        .     /*ซูซูกิ           */    
    ELSE IF trim(wdetail.brand) = "023" THEN  n_matbrand = "Cheverolet"    .     /*เชฟโรเลต         */
    ELSE IF trim(wdetail.brand) = "024" THEN  n_matbrand = "TATA"          .     /*ทาทา         */
    ELSE IF trim(wdetail.brand) = "026" THEN  n_matbrand = "Kubota"        .     /*คูโบต้า          */    
    ELSE IF trim(wdetail.brand) = "027" THEN  n_matbrand = "Tadano"        .     /*ทาดาโน่          */    
    ELSE IF trim(wdetail.brand) = "028" THEN  n_matbrand = "Hino Trailer"  .     /*Hino Trailer  */  
    ELSE IF trim(wdetail.brand) = "025" THEN  n_matbrand = "PROTON"        .     /*โปรตอน           */    
    ELSE IF trim(wdetail.brand) = "029" THEN  n_matbrand = "Mini Cooper"   .     /*มินิคูเปอร์  */    
    /*Add A63-0259 Match brand */
    ASSIGN 
        /*wdetail.brand      = IF      trim(wdetail.brand) = "001" THEN "TOYOTA" 
                               ELSE IF trim(wdetail.brand) = "017" THEN "HONDA" 
                               ELSE wdetail.brand*/ /*Add A63-0259 Match brand */
        wdetail.brand        = n_matbrand           /*Add A63-0259 Match brand */
        wdetail.effecdat     = SUBSTR(wdetail.effecdat,7,2 ) + "/" +
        SUBSTR(wdetail.effecdat,5,2 ) + "/" +
        SUBSTR(wdetail.effecdat,1,4 )
        wdetail.comeffecdat  = SUBSTR(wdetail.comeffecdat,7,2 ) + "/" +
        SUBSTR(wdetail.comeffecdat,5,2 ) + "/" +
        SUBSTR(wdetail.comeffecdat,1,4 )
        wdetail.norcovdat    = SUBSTR(wdetail.norcovdat,7,2 ) + "/" +
                               SUBSTR(wdetail.norcovdat,5,2 ) + "/" +
                               SUBSTR(wdetail.norcovdat,1,4 )
        wdetail.norcovenddat = SUBSTR(wdetail.norcovenddat,7,2 ) + "/" +
                               SUBSTR(wdetail.norcovenddat,5,2 ) + "/" +
                               SUBSTR(wdetail.norcovenddat,1,4 )  
        n_model01 = IF index(wdetail.model," ") <> 0 THEN trim(substr(wdetail.model,1,index(wdetail.model," "))) ELSE wdetail.model.
       
    IF wdetail.branch = "8"  THEN DO:
        ASSIGN n_setclass = "".
        IF ((index(wdetail.model,"Hilux") <> 0 ) OR (index(wdetail.model,"Vigo") <> 0 )) THEN DO:
            ASSIGN n_model01 = "Vigo".
            IF      (index(wdetail.model,"Prerunner B") <> 0 ) THEN  
                ASSIGN wdetail.class = "F320"
                n_model02 = "Vigo B-Cab".
            ELSE IF (index(wdetail.model,"Prerunner C") <> 0 ) THEN  
                ASSIGN wdetail.class = "F210"
                n_model02 = "Vigo C-Cab".
            ELSE IF (index(wdetail.model,"Prerunner D") <> 0 ) THEN  
                ASSIGN wdetail.class = "F110"
                n_model02 = "Vigo D-Cab".
            ELSE IF (index(wdetail.model,"4x2 B") <> 0 )       THEN  
                ASSIGN wdetail.class = "F320"
                n_model02 = "Vigo B-Cab".
            ELSE IF (index(wdetail.model,"4x2 C") <> 0 )       THEN  
                ASSIGN wdetail.class = "F210"
                n_model02 = "Vigo C-Cab".
            ELSE IF (index(wdetail.model,"4x2 D") <> 0 )       THEN  
                ASSIGN wdetail.class = "F110"
                n_model02 = "Vigo D-Cab".
            ELSE IF (index(wdetail.model,"4x4 B") <> 0 )       THEN  
                ASSIGN wdetail.class = "F320"
                n_model02 = "Vigo B-Cab".
            ELSE IF (index(wdetail.model,"4x4 C") <> 0 )       THEN  
                ASSIGN wdetail.class = "F210"
                n_model02 = "Vigo C-Cab".
            ELSE IF (index(wdetail.model,"4x4 D") <> 0 )       THEN  
                ASSIGN wdetail.class = "F110"
                n_model02 = "Vigo D-Cab".
            ELSE n_model02 = "". 
        END.
        ELSE IF n_model01 = "COMMUTER" THEN wdetail.class = "F220".
        ELSE IF n_model01 = "Ventury"  THEN wdetail.class = "F220".
        ELSE IF n_model01 = "Corolla"  THEN 
            ASSIGN n_model01 = "Altis"
            wdetail.class = "F110".
        ELSE wdetail.class = "F110".
        /* G120 */
        FIND FIRST brstat.insure WHERE 
            brstat.insure.InsNo                   = fi_campno   AND 
          ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
           (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))) AND 
           (deci(brstat.insure.PostCode)          = (deci(wdetail.grpssprem) / 100 )      OR 
           (round(deci(brstat.insure.PostCode),0) + 1 ) = (deci(wdetail.grpssprem) / 100 ) OR
            round(deci(brstat.insure.PostCode),0) = (deci(wdetail.grpssprem) / 100 ))      NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.insure THEN
            ASSIGN wdetail.class = trim(brstat.insure.Text3)
            n_setclass = brstat.insure.Text3. 
        ELSE ASSIGN n_setclass = "".
        IF n_setclass = ""  THEN DO:
            FIND FIRST brstat.insure WHERE 
                brstat.insure.InsNo         = fi_campno   AND
              ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
               (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100))))  AND
              ((deci(brstat.insure.PostCode)    = deci(wdetail.grpssprem))      OR
               (round(deci(brstat.insure.PostCode),0) + 1 ) = (deci(wdetail.grpssprem) / 100 ) OR
               (deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4))    = deci(wdetail.grpssprem) OR 
               (ROUND((deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4)),0)  = deci(wdetail.grpssprem))     OR
               ((ROUND((deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4)),0) + 1 )  = deci(wdetail.grpssprem)) OR
               (round(deci(brstat.insure.PostCode),0)  = deci(wdetail.grpssprem) - 1 ) OR 
               (round(deci(brstat.insure.PostCode) - deci(wdetail.comprem),0)  = deci(wdetail.grpssprem)) OR 
               (deci(brstat.insure.PostCode) - deci(wdetail.comprem)   = deci(wdetail.grpssprem)))  AND
                deci(brstat.insure.ICAddr4) = (deci(wdetail.comprem) / 100 )    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.insure THEN
                ASSIGN wdetail.class = trim(brstat.insure.Text3)
                n_setclass = brstat.insure.Text3. 
            ELSE ASSIGN n_setclass = "".
        END.
        IF (deci(wdetail.caryear) = YEAR(TODAY)) AND ((n_setclass = "") OR (n_setclass <> "G120")) THEN DO: /* new car */
            IF n_model02 = ""  THEN DO:  /*class Z120 or new car */
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo    = fi_campno           AND 
                    brstat.insure.Text3    = wdetail.class       AND
                  ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
                   (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100))))  
                    /*index(brstat.insure.Text2,n_model01) <> 0   AND
                    deci(brstat.insure.PostCode)          = (deci(wdetail.grpssprem) / 100 )*/  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = trim(brstat.insure.Text3)
                    n_setclass = brstat.insure.Text3. 
                ELSE ASSIGN n_setclass = "".
                IF n_setclass = "" THEN DO:
                    FIND FIRST brstat.insure WHERE 
                        brstat.insure.InsNo                    = fi_campno       AND
                        brstat.insure.Text3                    = wdetail.class   AND
                      ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
                       (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))) AND 
                        deci(brstat.insure.ICAddr4)            = (deci(wdetail.comprem) / 100 )    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL brstat.insure THEN
                        ASSIGN wdetail.class = brstat.insure.Text3
                        n_setclass = brstat.insure.Text3. 
                    ELSE n_setclass = "". 
                END.
            END.
            ELSE DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo    = fi_campno      AND 
                    index(brstat.insure.Text2,"vigo") <> 0  AND 
                    /*brstat.insure.Text3    = wdetail.class  AND   /* 15062012 */*/
                   ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
                    (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100))))  AND 
                    ((deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4))        = (deci(wdetail.grpssprem) / 100 ) OR 
                     (round(deci(brstat.insure.PostCode),0) + 1 ) = (deci(wdetail.grpssprem) / 100 ) OR
                   round((deci(brstat.insure.PostCode) - deci(brstat.insure.ICAddr4)),0) = ROUND((deci(wdetail.grpssprem) / 100 ),0))  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = trim(brstat.insure.Text3)
                    n_setclass = brstat.insure.Text3. 
                ELSE ASSIGN n_setclass = "".
            END.
            IF n_setclass = ""  THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo                    = fi_campno   AND
                  ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
                   (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100))))  AND     
                    deci(brstat.insure.ICAddr4)            = (deci(wdetail.comprem) / 100 )      NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = brstat.insure.Text3
                    n_setclass = brstat.insure.Text3. 
                ELSE n_setclass = "". 
            END.
        END.  
        ELSE DO:  /*use car */
            FIND FIRST brstat.insure WHERE 
                brstat.insure.InsNo                   = fi_campno   AND
              ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
               (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100))))  AND     
                deci(brstat.insure.ICAddr4)           = (deci(wdetail.comprem) / 100 )     AND
              ((deci(brstat.insure.PostCode)          = (deci(wdetail.grpssprem) / 100 ))  OR
               (round(deci(brstat.insure.PostCode),0) + 1 ) = (deci(wdetail.grpssprem) / 100 ) OR
               (round(deci(brstat.insure.PostCode),0) = (deci(wdetail.grpssprem) / 100 )) ) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.insure THEN
                ASSIGN wdetail.class = brstat.insure.Text3
                n_setclass = brstat.insure.Text3. 
            ELSE n_setclass = "". 
            IF n_setclass = "" THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo                    = fi_campno   AND
                  ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))  AND
                   (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))) AND 
                   ( (deci(brstat.insure.PostCode)          = (deci(wdetail.grpssprem) / 100 ))  OR
                     (round(deci(brstat.insure.PostCode),0) + 1 ) = (deci(wdetail.grpssprem) / 100 ) OR
                    (round(deci(brstat.insure.PostCode),0) = (deci(wdetail.grpssprem) / 100 )) ) NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = brstat.insure.Text3
                    n_setclass = brstat.insure.Text3. 
                ELSE n_setclass = "". 
            END.
        END.      /* Hilux vigo     */
        IF n_setclass = "" THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo                    = fi_campno   AND
                  ((brstat.insure.Deci2   >= ((deci(wdetail.covamount) / 100 ) - (((deci(wdetail.covamount) / 100 ) * 5 ) / 100)))   AND
                   (brstat.insure.Deci2   <= ((deci(wdetail.covamount) / 100 ) + (((deci(wdetail.covamount) / 100 ) * 5 ) / 100))))  AND 
                    deci(brstat.insure.ICAddr4)            = (deci(wdetail.comprem) / 100 )     NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN DO: 
                    ASSIGN wdetail.class = brstat.insure.Text3
                        n_setclass = brstat.insure.Text3. 
                    IF deci(wdetail.caryear) = YEAR(TODAY) THEN 
                        wdetail.class = "F" + SUBSTR(wdetail.class,2,3).
                END.
                ELSE n_setclass = "". 
        END.
        ELSE IF (deci(wdetail.caryear) = YEAR(TODAY)) AND (SUBSTR(wdetail.class,1,1) = "G") THEN 
            wdetail.class = "F" + SUBSTR(wdetail.class,2,3).
    END.      /*end ...br 8*/
    ELSE DO:  /* br dm or ..*/
        IF ((index(wdetail.model,"Hilux") <> 0 ) OR (index(wdetail.model,"Vigo") <> 0 )) THEN DO:
            IF      (index(wdetail.model,"Prerunner B") <> 0 ) THEN  ASSIGN wdetail.class = "X320".
            ELSE IF (index(wdetail.model,"Prerunner C") <> 0 ) THEN  ASSIGN wdetail.class = "X210".
            ELSE IF (index(wdetail.model,"Prerunner D") <> 0 ) THEN  ASSIGN wdetail.class = "X110".
            ELSE IF (index(wdetail.model,"4x2 B") <> 0 )       THEN  ASSIGN wdetail.class = "X320".
            ELSE IF (index(wdetail.model,"4x2 C") <> 0 )       THEN  ASSIGN wdetail.class = "X210".
            ELSE IF (index(wdetail.model,"4x2 D") <> 0 )       THEN  ASSIGN wdetail.class = "X110".
            ELSE IF (index(wdetail.model,"4x4 B") <> 0 )       THEN  ASSIGN wdetail.class = "X320".
            ELSE IF (index(wdetail.model,"4x4 C") <> 0 )       THEN  ASSIGN wdetail.class = "X210".
            ELSE IF (index(wdetail.model,"4x4 D") <> 0 )       THEN  ASSIGN wdetail.class = "X110".
            ELSE ASSIGN wdetail.class = "X110".
        END.
        ELSE IF n_model01 = "COMMUTER" THEN wdetail.class = "X220".
        ELSE IF n_model01 = "Ventury"  THEN wdetail.class = "X220".
        ELSE wdetail.class = "X110".
    END.
    IF n_matbrand = "HINO"  THEN wdetail.class = "T320".  /*Add by Kridtiya i. A63-0259 */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assignbr1 C-Win 
PROCEDURE Pro_assignbr1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_model01  AS CHAR FORMAT "x(50)".
DEF VAR n_model02  AS CHAR FORMAT "x(50)".
DEF VAR n_setclass AS CHAR FORMAT "x(20)".
ASSIGN 
    n_model01  = ""
    n_model02  = ""  
    n_setclass = "" .
FOR EACH wdetail   NO-LOCK 
    WHERE wdetail.head = "d"  .
    FIND FIRST stat.insure USE-INDEX Insure06 WHERE 
        stat.insure.lname  = wdetail.delercode  AND
        stat.insure.compno = "TIB" NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL stat.insure THEN  
        ASSIGN  wdetail.branch   = stat.insure.branch
        wdetail.producer     = stat.insure.addr1
        wdetail.agent        = stat.insure.addr2 .
    ELSE 
        ASSIGN  wdetail.branch   = ""
            wdetail.producer     = ""
            wdetail.agent        = ""  . 
    RUN proc_assigntitle.
    ASSIGN 
        wdetail.brand        = IF trim(wdetail.brand) = "001" THEN "TOYOTA" 
                               ELSE IF trim(wdetail.brand) = "017" THEN "HONDA" 
                               ELSE wdetail.brand
        wdetail.effecdat     = SUBSTR(wdetail.effecdat,7,2 ) + "/" +
        SUBSTR(wdetail.effecdat,5,2 ) + "/" +
        SUBSTR(wdetail.effecdat,1,4 )
        wdetail.comeffecdat  = SUBSTR(wdetail.comeffecdat,7,2 ) + "/" +
        SUBSTR(wdetail.comeffecdat,5,2 ) + "/" +
        SUBSTR(wdetail.comeffecdat,1,4 )
        wdetail.norcovdat    = SUBSTR(wdetail.norcovdat,7,2 ) + "/" +
                               SUBSTR(wdetail.norcovdat,5,2 ) + "/" +
                               SUBSTR(wdetail.norcovdat,1,4 )
        wdetail.norcovenddat = SUBSTR(wdetail.norcovenddat,7,2 ) + "/" +
                               SUBSTR(wdetail.norcovenddat,5,2 ) + "/" +
                               SUBSTR(wdetail.norcovenddat,1,4 )  
        n_model01 = IF index(wdetail.model," ") <> 0 THEN trim(substr(wdetail.model,1,index(wdetail.model," "))) ELSE wdetail.model.
        
    IF wdetail.branch = "8"  THEN DO:
        ASSIGN n_setclass = "".
        IF ((index(wdetail.model,"Hilux") <> 0 ) OR (index(wdetail.model,"Vigo") <> 0 )) THEN DO:
            ASSIGN n_model01 = "Vigo".
            IF      (index(wdetail.model,"Prerunner B") <> 0 ) THEN  
                ASSIGN wdetail.class = "F320"
                n_model02 = "Vigo B-Cab".
            ELSE IF (index(wdetail.model,"Prerunner C") <> 0 ) THEN  
                ASSIGN wdetail.class = "F210"
                n_model02 = "Vigo C-Cab".
            ELSE IF (index(wdetail.model,"Prerunner D") <> 0 ) THEN  
                ASSIGN wdetail.class = "F110"
                n_model02 = "Vigo D-Cab".
            ELSE IF (index(wdetail.model,"4x2 B") <> 0 )       THEN  
                ASSIGN wdetail.class = "F320"
                n_model02 = "Vigo B-Cab".
            ELSE IF (index(wdetail.model,"4x2 C") <> 0 )       THEN  
                ASSIGN wdetail.class = "F210"
                n_model02 = "Vigo C-Cab".
            ELSE IF (index(wdetail.model,"4x2 D") <> 0 )       THEN  
                ASSIGN wdetail.class = "F110"
                n_model02 = "Vigo D-Cab".
            ELSE IF (index(wdetail.model,"4x4 B") <> 0 )       THEN  
                ASSIGN wdetail.class = "F320"
                n_model02 = "Vigo B-Cab".
            ELSE IF (index(wdetail.model,"4x4 C") <> 0 )       THEN  
                ASSIGN wdetail.class = "F210"
                n_model02 = "Vigo C-Cab".
            ELSE IF (index(wdetail.model,"4x4 D") <> 0 )       THEN  
                ASSIGN wdetail.class = "F110"
                n_model02 = "Vigo D-Cab".
            ELSE n_model02 = "".
        END.
        IF (deci(wdetail.caryear) = YEAR(TODAY)) THEN DO: /* new car */
            IF n_model02 = ""  THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo    = fi_campno   AND 
                    brstat.insure.Deci2    = (deci(wdetail.covamount) / 100 )  AND
                    (deci(brstat.insure.PostCode)          = (deci(wdetail.grpssprem) / 100 ) + (deci(wdetail.comprem) / 100 ) OR 
                    round(deci(brstat.insure.PostCode),0) = ROUND((deci(wdetail.grpssprem) / 100 ) + (deci(wdetail.comprem) / 100 ),0))  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = trim(brstat.insure.Text3)
                    n_setclass = brstat.insure.Text3. 
                ELSE ASSIGN n_setclass = "".
            END.
            ELSE DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo    = fi_campno   AND 
                    brstat.insure.Text2    = n_model02   AND 
                    brstat.insure.Deci2    = (deci(wdetail.covamount) / 100 ) AND
                    (deci(brstat.insure.PostCode)         = (deci(wdetail.grpssprem) / 100 ) + (deci(wdetail.comprem) / 100 ) OR 
                   round(deci(brstat.insure.PostCode),0) = ROUND((deci(wdetail.grpssprem) / 100 ) + (deci(wdetail.comprem) / 100 ),0))  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = trim(brstat.insure.Text3)
                    n_setclass = brstat.insure.Text3. 
                ELSE ASSIGN n_setclass = "".
            END.
            IF n_setclass = ""  THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo                    = fi_campno   AND
                    brstat.insure.Deci2                    = (deci(wdetail.covamount) / 100 )   AND 
                    deci(brstat.insure.ICAddr4)            = (deci(wdetail.comprem) / 100 )      NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = brstat.insure.Text3
                    n_setclass = brstat.insure.Text3. 
                ELSE n_setclass = "". 
            END.
        END.  
        ELSE DO:  /*use car */
            FIND FIRST brstat.insure WHERE 
                brstat.insure.InsNo                    = fi_campno   AND
                brstat.insure.Deci2                    = (deci(wdetail.covamount) / 100 )   AND 
                deci(brstat.insure.ICAddr4)            = (deci(wdetail.comprem) / 100 )     AND
               ( (deci(brstat.insure.PostCode)          = (deci(wdetail.grpssprem) / 100 ))  OR
                (round(deci(brstat.insure.PostCode),0) = (deci(wdetail.grpssprem) / 100 )) ) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.insure THEN
                ASSIGN wdetail.class = brstat.insure.Text3
                n_setclass = brstat.insure.Text3. 
            ELSE n_setclass = "". 
            IF n_setclass = "" THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo                    = fi_campno   AND
                    brstat.insure.Deci2                    = (deci(wdetail.covamount) / 100 )   AND 
                   ( (deci(brstat.insure.PostCode)          = (deci(wdetail.grpssprem) / 100 ))  OR
                    (round(deci(brstat.insure.PostCode),0) = (deci(wdetail.grpssprem) / 100 )) ) NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = brstat.insure.Text3
                    n_setclass = brstat.insure.Text3. 
                ELSE n_setclass = "". 
            END.
        END.      /* Hilux vigo     */
        IF n_setclass = "" THEN DO:
                FIND FIRST brstat.insure WHERE 
                    brstat.insure.InsNo                    = fi_campno   AND
                    brstat.insure.Deci2                    = (deci(wdetail.covamount) / 100 )   AND 
                    deci(brstat.insure.ICAddr4)            = (deci(wdetail.comprem) / 100 )     NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.insure THEN
                    ASSIGN wdetail.class = brstat.insure.Text3
                    n_setclass = brstat.insure.Text3. 
                ELSE n_setclass = "". 
        END.
    END.      /*end ...br 8*/
    ELSE DO:  /* br dm or ..*/
        IF ((index(wdetail.model,"Hilux") <> 0 ) OR (index(wdetail.model,"Vigo") <> 0 )) THEN DO:
            IF      (index(wdetail.model,"Prerunner B") <> 0 ) THEN  ASSIGN wdetail.class = "X320".
            ELSE IF (index(wdetail.model,"Prerunner C") <> 0 ) THEN  ASSIGN wdetail.class = "X210".
            ELSE IF (index(wdetail.model,"Prerunner D") <> 0 ) THEN  ASSIGN wdetail.class = "X110".
            ELSE IF (index(wdetail.model,"4x2 B") <> 0 )       THEN  ASSIGN wdetail.class = "X320".
            ELSE IF (index(wdetail.model,"4x2 C") <> 0 )       THEN  ASSIGN wdetail.class = "X210".
            ELSE IF (index(wdetail.model,"4x2 D") <> 0 )       THEN  ASSIGN wdetail.class = "X110".
            ELSE IF (index(wdetail.model,"4x4 B") <> 0 )       THEN  ASSIGN wdetail.class = "X320".
            ELSE IF (index(wdetail.model,"4x4 C") <> 0 )       THEN  ASSIGN wdetail.class = "X210".
            ELSE IF (index(wdetail.model,"4x4 D") <> 0 )       THEN  ASSIGN wdetail.class = "X110".
            ELSE ASSIGN wdetail.class = "X110".
        END.
        ELSE IF n_model01 = "COMMUTER" THEN wdetail.class = "X220".
        ELSE IF n_model01 = "Ventury"  THEN wdetail.class = "X220".
        ELSE wdetail.class = "X110".
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_assignLoad C-Win 
PROCEDURE Pro_assignLoad :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_output AS CHAR FORMAT "x(50)" INIT "".
IF INDEX(fi_outfileload,".slk") = 0  THEN 
    nv_output = fi_outfileload + ".slk".
ELSE 
    nv_output = substr(fi_outfileload,1,INDEX(fi_outfileload,".slk") - 1 ) + ".slk".
OUTPUT TO VALUE(nv_output).    /*out put file full policy */
EXPORT DELIMITER "|"    
    "ประเภทรายการ" 
    "รหัสบริษัท"  
    "วันที่ส่ง"  
    "เลขที่(ApplicationNo.)" 
    "Lotno."   
    "Seqno."   
    "Record Active."  
    "สถานะ"   
    "แก้ไขเลขเครื่องยนต์/เลขตัวถัง" 
    "คำนำ"
    "ชื่อผู้เอาประกันภัย" 
    "ที่อยู่ผู้เอาประกันภัย1" 
    "ที่อยู่ผู้เอาประกันภัย2" 
    "ที่อยู่ผู้เอาประกันภัย3" 
    "ที่อยู่ผู้เอาประกันภัย4" 
    "ที่อยู่ผู้เอาประกันภัย5" 
    "เลขเครื่องยนต์"
    "เลขตัวถัง"     
    "รหัสยี่ห้อรถ"  
    "รุ่นรถ"      
    "ขนาดเครื่องยนต์" 
    "สีรถ"      
    "ทะเบียนรถ1"
    "ทะเบียนรถ2"
    "จังหวัดที่จดทะเบียน"            
    "รหัสย่อยบริษัทประกันภัย"        
    "Normal Coverage amount"         
    "Normal Gross premium"           
    "Effective date"                 
    "เลขรับแจ้งฯ TLT."               
    "รหัสผู้รับแจ้งฯ TLT."           
    "เลขรับแจ้งฯ จากบ.ประกันภัย"     
    "ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย" 
    "รหัสย่อยบริษัทประกันภัย"        
    "Compl. Coverage amount"         
    "Compl. Gross premium"           
    "Compl. Effective date"          
    "เครื่องหมาย (พรบ.)"             
    "เลขรับแจ้งฯ TLT."               
    "รหัสผู้รับแจ้งฯ TLT."           
    "เลขรับแจ้งฯ จากบ.ประกันภัย"     
    "ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย" 
    "เลขกรมธรรม์ พรบ."               
    "วันที่บ.ประกันภัย รับแจ้งฯ"     
    "ชื่อผู้ขับขี่ คนที่ 1" 
    "ชื่อผู้ขับขี่ คนที่ 2"             
    "เลขที่ใบขับขี่ คนที่ 1"   
    "เลขที่ใบขับขี่ คนที่ 2"   
    "หมายเลขเครื่องยนต์ (เดิม)"
    "หมายเลขตัวถังรถ (เดิม)"    
    "ชื่อ-สกุลสำหรับออกใบเสร็จรับเงิน"   
    "ที่อยู่ บรรทัดที่1"   
    "ที่อยู่ บรรทัดที่2  " 
    "ที่อยู่ บรรทัดที่3  " 
    "ที่อยู่ บรรทัดที่4 "  
    "รหัสไปรษณีย์"   
    "Reserved1"  
    "Reserved2"  
    "Normal End coverage date" 
    "Compulsory End coverage date " 
    "Dealer code" 
    "ปีรถ" 
    "Renewal type"
    "Reserved5"   
    "Reserved6"   
    "access"  
    "branch" 
    "producer"
    "agent"
    "Previous Policy" 
    "covcod" 
    "class"
    "GarageType"                            
    "DriverFlag"                            
    "Driver1Name"                       
    "Driver1DOB"                       
    "Driver1License"               
    "Driver2Name"                          
    "Driver2DOB"               
    "Driver2License"  
    "Dealer Code"
    "Car Usage Code"                                 
    "Deduct Amount"                                       
    "ทุนสลักหลังเพิ่ม"               
    "เบี้ยสลักหลังเพิ่ม" . 
FOR EACH wdetail   NO-LOCK .
    IF wdetail.head   = "H"  THEN NEXT.
    ELSE IF wdetail.head   = "T"  THEN NEXT.
    EXPORT DELIMITER "|" 
        wdetail.head                      /*1 D*/         
        wdetail.comcode                   /*2 4 */        
        wdetail.senddat                   /*3 8 yyyymmdd*/   
        wdetail.contractno                /*4 10*/      
        wdetail.lotno                     /*5 9*/       
        wdetail.seqno                     /*6 6 000002*/       
        wdetail.recact                    /*7 A*/      
        wdetail.STATUSno                  /*8 A,E,C*/      
        wdetail.flag                      /*9 Y */   
        wdetail.ntitle                    
        wdetail.insname                   /*10  100 */     
        wdetail.add1                      /*11 50 */    
        wdetail.add2                      /*12 50 */    
        wdetail.add3                      /*13 50 */    
        wdetail.add4                      /*14 50 */     
        wdetail.add5                      /*15 5  */      
        wdetail.engno                     /*16 20 */     
        wdetail.chasno                    /*17 20 */     
        wdetail.brand                     /*18 3  */ 
        wdetail.model                     /*19 40 */     
        wdetail.cc                        /*20 5 */      
        wdetail.COLORno                   /*21 4 */      
        wdetail.reg1                      /*22 5 */      
        wdetail.reg2                      /*23 5*/      
        wdetail.provinco                  /*24 2*/     
        wdetail.subinsco                  /*25 4 */      
        (deci(wdetail.covamount) / 100 )  /*26 13 */     
        (deci(wdetail.grpssprem) / 100 )  /*27 11 */     
        wdetail.effecdat                  /*28 8  yyyymmdd*/      
        wdetail.notifyno                  /*29   100 */     
        wdetail.noticode                  /*30 4  */     
        wdetail.noticodesty               /*31 25  */     
        wdetail.notiname                  /*32 50  */     
        wdetail.substyname                /*33 4   */     
        (deci(wdetail.comamount) / 100 )  /*34 13  */    
        (deci(wdetail.comprem) / 100 )    /*35 11  */     
        wdetail.comeffecdat               /*36 8 yyyymmdd */      
        wdetail.compno                    /*37 25 */    
        wdetail.recivno                   /*38 100 */    
        wdetail.recivcode                 /*39 4  */     
        wdetail.recivcosty                /*40 25 */    
        wdetail.recivstynam               /*41 50 */      
        wdetail.comppol                   /*42 25 */   
        wdetail.recivstydat               /*43 8  */  
        wdetail.drivnam1                  /*44 30 */    
        wdetail.drivnam2                  /*45 30 */      
        wdetail.drino1                    /*46 13 */     
        wdetail.drino2                    /*47 13 */     
        wdetail.oldeng                    /*46 20 */    
        wdetail.oldchass                  /*47 20 */    
        wdetail.NAMEpay                   /*48 100 */    
        wdetail.addpay1                   /*49 50 */    
        wdetail.addpay2                   /*50 50 */    
        wdetail.addpay3                   /*51 50 */    
        wdetail.addpay4                   /*52 50 */    
        wdetail.postpay                   /*53 5  */     
        wdetail.Reserved1                 /*54 13 */    
        wdetail.Reserved2                 /*55 13 */   
        wdetail.norcovdat                 /*56 8 */    
        wdetail.norcovenddat              /*57 8 */   
        wdetail.delercode                 /*58 4 */     
        wdetail.caryear                   /*59 4 */     
        wdetail.renewtyp                  /*60 1 */     
        wdetail.Reserved5                 /*61 59*/   
        wdetail.Reserved6                 /*62 21*/  
        wdetail.access 
        wdetail.branch  
        wdetail.producer 
        wdetail.agent    
        wdetail.prvpol  
        /*"1"  *//*A67-0184*/ 
        wdetail.covtype                /*A67-0184*/ 
        wdetail.CLASS      
        wdetail.garage     /*A67-0184*/  
        wdetail.driver     /*A67-0184*/  
        wdetail.name1      /*A67-0184*/  
        wdetail.birth1     /*A67-0184*/  
        wdetail.licen1     /*A67-0184*/  
        wdetail.name2      /*A67-0184*/  
        wdetail.birth2     /*A67-0184*/  
        wdetail.licen2     /*A67-0184*/  
        wdetail.dealer     /*A67-0184*/ 
        wdetail.vehuse     /*A67-0184*/  
        wdetail.deduct     /*A67-0184*/  
        wdetail.addcap     /*A67-0184*/  
        wdetail.addfee     /*A67-0184*/  
        
        
        
        .  
END.    /*FOR  wdetail  */
MESSAGE "Export data complete " VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  Then
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
If  substr(fi_outfile1,length(fi_outfile1) - 3,4) <>  ".txt"  Then
    fi_outfile1  =  Trim(fi_outfile1) + ".txt"  .
If  substr(fi_outfile2,length(fi_outfile2) - 3,4) <>  ".txt"  Then
    fi_outfile2  =  Trim(fi_outfile2) + ".txt"  .
RUN Pro_createfile2.  
RUN Pro_createfile3. 
RUN Pro_createfile4. 
RUN Pro_createfile5.
RUN Pro_createfile6.
message "Export File  Complete"  view-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile1 C-Win 
PROCEDURE Pro_createfile1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "TEXT FILE FROM TIB"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_export  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  "ประเภทรายการ"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  "รหัสบริษัท"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  "วันที่ส่ง"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  "เลขที่(ApplicationNo.)"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  "กรมธรรม์70"   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  "กรมธรรม์72"   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  "Lotno."   '"' SKIP.                                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  "Seqno."   '"' SKIP.                                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  "Record Active."   '"' SKIP.                                  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "สถานะ"   '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "แก้ไขเลขเครื่องยนต์/เลขตัวถัง"  '"' SKIP.                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "ชื่อผู้เอาประกันภัย"            '"' SKIP.                              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ที่อยู่ผู้เอาประกันภัย1"        '"' SKIP.                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ที่อยู่ผู้เอาประกันภัย2"        '"' SKIP.                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ที่อยู่ผู้เอาประกันภัย3"        '"' SKIP.                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "ที่อยู่ผู้เอาประกันภัย4"        '"' SKIP.                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "ที่อยู่ผู้เอาประกันภัย5"        '"' SKIP.                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "เลขเครื่องยนต์"                 '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "เลขตัวถัง"                      '"' SKIP.                                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "รหัสยี่ห้อรถ"                   '"' SKIP.                                 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "รุ่นรถ"                         '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "ขนาดเครื่องยนต์"                '"' SKIP.                              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "สีรถ"                           '"' SKIP.                                         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "ทะเบียนรถ1"                     '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "ทะเบียนรถ2"                     '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "จังหวัดที่จดทะเบียน"            '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "รหัสย่อยบริษัทประกันภัย"        '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "Normal Coverage amount"         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "Normal Gross premium"           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "Effective date"                 '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "เลขรับแจ้งฯ TLT."               '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "รหัสผู้รับแจ้งฯ TLT."           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "เลขรับแจ้งฯ จากบ.ประกันภัย"     '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย" '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "รหัสย่อยบริษัทประกันภัย"        '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "Compl. Coverage amount"         '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "Compl. Gross premium"           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "Compl. Effective date"          '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "เครื่องหมาย (พรบ.)"             '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "เลขรับแจ้งฯ TLT."               '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "รหัสผู้รับแจ้งฯ TLT."           '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "เลขรับแจ้งฯ จากบ.ประกันภัย"     '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "ชื่อผู้รับแจ้งฯ ของบ.ประกันภัย" '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "เลขกรมธรรม์ พรบ."               '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "วันที่บ.ประกันภัย รับแจ้งฯ"     '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "ชื่อผู้ขับขี่ คนที่ 1" '"' SKIP.                             
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "ชื่อผู้ขับขี่ คนที่ 2"               '"' SKIP.               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "เลขที่ใบขับขี่ คนที่ 1"   '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "เลขที่ใบขับขี่ คนที่ 2"   '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "หมายเลขเครื่องยนต์ (เดิม)"     '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "หมายเลขตัวถังรถ (เดิม)"     '"' SKIP.                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "ชื่อ-สกุลสำหรับออกใบเสร็จรับเงิน"     '"' SKIP.              
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "ที่อยู่ บรรทัดที่1"     '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "ที่อยู่ บรรทัดที่2  "     '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "ที่อยู่ บรรทัดที่3  "     '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "ที่อยู่ บรรทัดที่4 "     '"' SKIP.                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "รหัสไปรษณีย์"   '"' SKIP.                                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "Reserved1"   '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "Reserved2"   '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "Normal End coverage date" '"' SKIP.                          
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "Compulsory End coverage date "   '"' SKIP.                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "Dealer code"   '"' SKIP.                                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "ปีรถ"   '"' SKIP.                                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "Renewal type"   '"' SKIP.                                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "Reserved5"   '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "Reserved6"   '"' SKIP.                                        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "access"   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "Insurance Type"                 '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "Garage Type"                    '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "Driver Flag"                    '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "Driver 1"                       '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "Driver 1 DOB"                   '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "Driver 1 License"               '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "Driver 2"                       '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "Driver 2 DOB"                   '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "Driver 2 License"               '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' "Car Usage Code"                 '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' "Deduct Amount"                  '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' "Endorsement Additional S/I"     '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' "Endorsement Additional Premium" '"' SKIP.  /*A67-0184*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' "Dealer Code"                    '"' SKIP.  /*A67-0184*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile2 C-Win 
PROCEDURE Pro_createfile2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_pol70 AS CHAR FORMAT "x(20)" INIT "".
DEF VAR n_pol72 AS CHAR FORMAT "x(20)" INIT "".

ASSIGN  nv_cnt  =  0
    nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
RUN Pro_createfile1. 
FOR EACH wdetail  no-lock.  
    IF wdetail.head = "H" THEN NEXT.
    ASSIGN 
        n_pol70 = ""
        n_pol72 = ""
    nv_cnt  =  nv_cnt  + 1                    
    nv_row  =  nv_row  + 1.   
    FIND LAST sicuw.uwm100   USE-INDEX uwm10002 
         WHERE sicuw.uwm100.cedpol = TRIM(wdetail.contractno) NO-LOCK  NO-ERROR.
    IF AVAIL sicuw.uwm100  THEN DO:
        IF sicuw.uwm100.poltyp = "v70" THEN
            ASSIGN n_pol70 = sicuw.uwm100.policy
                   n_pol72 = sicuw.uwm100.cr_2.
        ELSE  ASSIGN n_pol70 = sicuw.uwm100.cr_2
                     n_pol72 = sicuw.uwm100.policy.
    END.
    ELSE ASSIGN n_pol70 = ""
                n_pol72 = "".
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' wdetail.head        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail.comcode     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' wdetail.senddat     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail.contractno  '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' n_pol70             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' n_pol72             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail.lotno       '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail.seqno       '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' wdetail.recact      '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' wdetail.STATUSno    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' wdetail.flag        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' wdetail.insname     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' wdetail.add1        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' wdetail.add2        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' wdetail.add3        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' wdetail.add4        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' wdetail.add5        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' wdetail.engno       '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' wdetail.chasno      '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' wdetail.brand       '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' wdetail.model       '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' wdetail.cc          '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' wdetail.COLORno     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' wdetail.reg1        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' wdetail.reg2        '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' wdetail.provinco    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' wdetail.subinsco    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' wdetail.covamount   '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' wdetail.grpssprem   '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' wdetail.effecdat    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' wdetail.notifyno    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' wdetail.noticode    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' wdetail.noticodesty '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' wdetail.notiname    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' wdetail.substyname  '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' wdetail.comamount   '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' wdetail.comprem     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' wdetail.comeffecdat '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' wdetail.compno      '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' wdetail.recivno     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' wdetail.recivcode   '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' wdetail.recivcosty  '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' wdetail.recivstynam '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' wdetail.comppol     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' wdetail.recivstydat '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' wdetail.drivnam1    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' wdetail.drivnam2    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' wdetail.drino1      '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' wdetail.drino2      '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' wdetail.oldeng      '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' wdetail.oldchass    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' wdetail.NAMEpay     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' wdetail.addpay1     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' wdetail.addpay2     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' wdetail.addpay3     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' wdetail.addpay4     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' wdetail.postpay     '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' wdetail.Reserved1    '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' wdetail.Reserved2    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' wdetail.norcovdat    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' wdetail.norcovenddat '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' wdetail.delercode    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' wdetail.caryear      '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' wdetail.renewtyp     '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' wdetail.Reserved5    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' wdetail.Reserved6    '"' SKIP.       
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' wdetail.access       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' wdetail.covtype      '"' SKIP.  /*A67-0184*/   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' wdetail.garage       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' wdetail.driver       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' wdetail.name1        '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' wdetail.birth1       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' wdetail.licen1       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' wdetail.name2        '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' wdetail.birth2       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' wdetail.licen2       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' wdetail.vehuse       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"  '"' wdetail.deduct       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"  '"' wdetail.addcap       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"  '"' wdetail.addfee       '"' SKIP.  /*A67-0184*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"  '"' wdetail.dealer       '"' SKIP.  /*A67-0184*/  
END.  /*  end  wdetail  */ 

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile3 C-Win 
PROCEDURE Pro_createfile3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR n_line1   AS CHAR FORMAT "x(256)" INIT "" .   
OUTPUT STREAM ns2 TO VALUE(fi_outfile1).
FIND FIRST wheader NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE wheader THEN DO:
    PUT STREAM ns2
        wheader.Recordtype
        wheader.CompanyCode
        wheader.Datesent
        wheader.Usersent
        wheader.Lotno
        wheader.Seqno  SKIP.
END. 
FOR EACH wdetail1 NO-LOCK:
    PUT STREAM ns2
        wdetail1.Recordtype
        wdetail1.CompanyCode
        wdetail1.Datesent
        wdetail1.usersent
        wdetail1.lotno
        wdetail1.seqno
        wdetail1.rec_active
        wdetail1.stat
        wdetail1.flag
        wdetail1.pol_name
        wdetail1.pol_addr1
        wdetail1.pol_addr2
        wdetail1.pol_addr3
        wdetail1.pol_addr4
        wdetail1.pol_addr5
        wdetail1.engine
        wdetail1.chassis
        wdetail1.carbrand
        wdetail1.model
        wdetail1.cc_weight
        wdetail1.colorcode
        wdetail1.licence1
        wdetail1.licence2
        wdetail1.province
        wdetail1.subinscod
        wdetail1.norcovamt
        wdetail1.norgroprm
        wdetail1.effdat
        wdetail1.tlt_noti1
        wdetail1.tlt_usr1
        wdetail1.notify1
        wdetail1.usr_ins1
        wdetail1.comp_sub
        wdetail1.comp_amt
        wdetail1.comp_grp
        wdetail1.comp_effdat
        wdetail1.sticker
        wdetail1.tlt_noti2
        wdetail1.tlt_usr2
        wdetail1.notify2
        wdetail1.usr_ins2
        wdetail1.pol_sticker
        wdetail1.notdat
        wdetail1.spec_nam1
        wdetail1.spec_nam2
        wdetail1.driv_linc1
        wdetail1.driv_linc2
        wdetail1.old_engine
        wdetail1.old_chassis
        wdetail1.vat_name
        wdetail1.vat_addr1
        wdetail1.vat_addr2
        wdetail1.vat_addr3
        wdetail1.vat_addr4
        wdetail1.vat_addr5
        wdetail1.reserved1                  
        wdetail1.reserved2                 
        wdetail1.norendcddat    
        wdetail1.comendcodat            
        wdetail1.showroomcode 
        wdetail1.caryear      
        wdetail1.renewtyp     
        wdetail1.reserved5                 
        wdetail1.reserved6 
        wdetail1.access  
        wdetail1.InsuranceType        /*A67-0184*/       
        wdetail1.GarageType           /*A67-0184*/  
        wdetail1.DriverFlag           /*A67-0184*/  
        wdetail1.Driver1name          /*A67-0184*/  
        wdetail1.Driver1DOB           /*A67-0184*/  
        wdetail1.Driver1License       /*A67-0184*/  
        wdetail1.Driver2name          /*A67-0184*/  
        wdetail1.Driver2DOB           /*A67-0184*/  
        wdetail1.Driver2License       /*A67-0184*/  
        wdetail1.CarUsageCode         /*A67-0184*/  
        wdetail1.DeductAmount         /*A67-0184*/  
        wdetail1.EndorseAdditionalSI  /*A67-0184*/  
        wdetail1.EndorseAdditionalPm  /*A67-0184*/  
        wdetail1.DealerCode           /*A67-0184*/  
        
        SKIP.
END.
FIND FIRST wtailer NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE wtailer THEN DO:
    PUT STREAM ns2
        wtailer.Recordtype
        wtailer.CompanyCode
        wtailer.Datesent
        wtailer.Usersent
        wtailer.Lotno
        wtailer.Seqno
        wtailer.Total_rec  SKIP.
END.
PUT STREAM  ns2
        n_line1  SKIP.  
     
OUTPUT STREAM ns2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile4 C-Win 
PROCEDURE Pro_createfile4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_FILLER AS CHAR FORMAT "x(42)".
DEF VAR n_seqno   AS INTE FORMAT "999999" INIT 0.
ASSIGN n_seqno  = 0.
nv_outfile5 = REPLACE(fi_outfile2, ".txt", "-SAFE-.txt").
OUTPUT STREAM ns2 TO VALUE(nv_outfile5).
FOR EACH wdetail1 NO-LOCK .
    n_seqno  = n_seqno  + 1.
    PUT STREAM NS2 
        "SAFE"                   AT  1
        wdetail1.Datesent        AT  5
        n_seqno                  AT  13
        wdetail1.pol_name        AT  19
        wdetail1.chassis         AT  69
        wdetail1.engine          AT  89
        wdetail1.notify1         AT  109
        wdetail1.pol_sticker     AT  134
        nv_FILLER                AT  159
        SKIP.
END.
PUT STREAM NS2 SKIP(1).
OUTPUT STREAM  ns2 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile5 C-Win 
PROCEDURE Pro_createfile5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_seqno = 0 
    nv_cnt  = 0
    nv_row  = 1.

OUTPUT STREAM ns2 TO VALUE(fi_outfile3).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "TEXT FILE FROM TIB"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' nv_export  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   "Company code"        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   "Date sent"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   "Seq.no"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   "CustomerThai  Name"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   "Chassis no."         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   "Engine no."          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   "Policy no."          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   "Pol_sticker"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   "FILLER"              '"' SKIP.

FOR EACH  wdetail1  no-lock. 
    ASSIGN 
        nv_cnt  =  nv_cnt   + 1                     
        nv_row  =  nv_row   + 1 
        n_seqno  = n_seqno  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "SAFE"                 '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' wdetail1.Datesent      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' n_seqno                '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' wdetail1.pol_name      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' wdetail1.chassis       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' wdetail1.engine        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' wdetail1.notify1       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' wdetail1.pol_sticker   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' nv_FILLER              '"' SKIP.
END.   /*  end  wdetail  */ 

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile6 C-Win 
PROCEDURE Pro_createfile6 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_FILLER AS CHAR FORMAT "x(42)".
DEF VAR n_seqno   AS INTE FORMAT "999999" INIT 0.
DEF VAR n_policy  AS CHAR FORMAT "X(25)".

ASSIGN n_seqno  = 0.
nv_outfile4 = REPLACE(fi_outfile2, ".txt", "-SMI-.txt").
OUTPUT STREAM ns2 TO VALUE(nv_outfile4).
FOR EACH wdetail1 NO-LOCK .

    /*----- Add Nopparuj P. A67-0013 -----*/
    n_policy = "".
    FIND sicuw.uwm100 USE-INDEX uwm10001
        WHERE sicuw.uwm100.policy = wdetail1.notify1
        NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN DO:
        FIND FIRST brpaysh_fil USE-INDEX brpaysh_fil001
             WHERE brpaysh_fil.mtype = "PH"
             AND   brpaysh_fil.mcode = sicuw.uwm100.campaign
             AND   brpaysh_fil.mcode <> ""
             NO-LOCK NO-ERROR.
        IF AVAIL brpaysh_fil THEN DO:
            IF INDEX(sicuw.uwm100.opnpol,"PHYD") <> 0 THEN  
                  n_policy = sicuw.uwm100.policy + SUBSTR(sicuw.uwm100.opnpol,1,4).
            ELSE  n_policy = sicuw.uwm100.policy + "PHYD" .
        END.
        ELSE DO:
            FIND FIRST brpaysh_fil USE-INDEX brpaysh_fil001
                 WHERE brpaysh_fil.mtype = "TC"
                 AND   brpaysh_fil.mcode = sicuw.uwm100.campaign
                 AND   brpaysh_fil.mcode <> ""
                 NO-LOCK NO-ERROR.
            IF AVAIL brpaysh_fil THEN n_policy = sicuw.uwm100.policy + "TCARE".
            ELSE                      n_policy = sicuw.uwm100.policy.
        END.
    END.
    /*----- Add Nopparuj P. A67-0013 -----*/

    n_seqno  = n_seqno  + 1.
    PUT STREAM NS2 
        "SMI "                   AT  1
        wdetail1.Datesent        AT  5
        n_seqno                  AT  13
        wdetail1.pol_name        AT  19
        wdetail1.chassis         AT  69
        wdetail1.engine          AT  89
        /*wdetail1.notify1         AT  109  --- Comment By A67-0113 ---*/
        n_policy                 AT  109
        wdetail1.pol_sticker     AT  134
        nv_FILLER                AT  159
        SKIP.
END.
PUT STREAM NS2 SKIP(1).
OUTPUT STREAM  ns2 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

