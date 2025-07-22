&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          stat             PROGRESS
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
  File: WacRAY6.W    Statement Text File AYCL by Group Statement  
          
  Description:       Dup. program from Wacraycl.W
                     1. เรียกข้อมูลตาม Group Statement ที่ระบุจากหน้าจอ  โดยดึงมาทุก Producer code 
                        - Sum ยอด Premium by Policy No. (New Policy , Endorement , Renew)  Export เป็น 1 ไฟล์
                     2. ใช้ไฟล์จากข้อ 1 มา Split ออกเป็น 8 ไฟล์ตามเงื่อนไข โดยมี 2 รูปแบบหลักคือ ที่เป็น V70 และ V72
                     3. ใช้ไฟล์จากข้อ 2 มา Convert เป็นรูปแบบ text file ตามที่ AYCL กำหนด โดยแบ่งเป็น 2 รูปแบบคือ  V70 และ V72 
  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author:   Tantawan Ch. 

  Created:   A60-0434    @24/10/2017 
----------------------------------------------------------------------------  
 Modify By  : Tantawan C.  Assign : A61-0020   Date : 16/1/2018
              - เพิ่มข้อมูล Title name ใน Statement (ntitle)
---------------------------------------------------------------------------
 Modify By  : Nontamas H. [A63-0391] Date 06/02/2021
              - แก้ไข Group Code จาก "A0M0016" เป็น "B3MLAY0100" 
              และเพิ่ม Producer Code B3MLAY0101, B3MLAY0102, B3MLAY0103, 
              B3MLAY0104, B3MLAY0105, B3MLAY0106 
              - แก้ไขไฟล์ Spilt และอัตราผลประโยชน์
---------------------------------------------------------------------------
 Modify By  : Tantawan Ch.  A65-0021  Date 02/02/2022
            - อ่านค่า Free Rate จาก Parameter (stat.Insure) แทนการ Fix 
            - เพิ่มให้ user สามารถ manage file Split ได้เอง จำกัดไว้ 8 กลุ่มหลัก
              ถ้าไม่อยู่ใน 8 กลุ่มหลัก จะแยกไปเป็น Other งาน V70 และ Other งาน V72
-------------------------------------------------------------------------
 Modify By : TANTAWAN CH. ASSIGN : A65-0335  DATE : 04/11/2022
             - แก้ไข Text file V72 Column ที่ 3 เดิมเป็น 0 + เลขกรมธรรม์ พรบ. 
               ให้เปลี่ยนเป็น  เลขกรมธรรม์ พรบ. + ช่องว่างให้ 30 ตัวอักษร 
               ( Function CONVERT => Convert Text CSV 72 to Text)
-------------------------------------------------------------------------*/
/***************************************************************************/
CREATE WIDGET-POOL.                                                        
/* ***************************  Definitions  **************************    */
/* Parameters Definitions ---                                              */

/* Local Variable Definitions ---                                          */
DEFINE NEW SHARED VAR n_branch      AS CHAR FORMAT "X(2)".                                       
DEFINE NEW SHARED VAR n_branch2     AS CHAR FORMAT "X(2)".                                        
DEFINE            VAR n_asdat       AS DATE FORMAT "99/99/9999".                                 
DEFINE            VAR n_bindate     AS CHAR FORMAT "99/99/9999".                                  
DEFINE            VAR n_binloop     AS CHAR FORMAT "99".                                          
DEFINE            VAR n_OutputFile1 AS CHAR.                                                      
DEFINE            VAR n_bdes        AS CHAR FORMAT "X(50)".     /*branch name*/                   
DEFINE            VAR n_chkBname    AS CHAR FORMAT "X(1)".      /* branch-- chk button 1-2 */     

DEFINE            VAR nv_nor_si         AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_comp_si        AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_Netprm         AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_freeper        AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nvfiFile-Name2    AS CHAR FORMAT "x(30)" INIT "".    
DEFINE            VAR nv_sckno          AS CHAR FORMAT "x(30)" INIT "".  
DEFINE            VAR n_wRecordno       AS DECI FORMAT "99999" INIT 0.  
DEFINE            VAR nv_Tbal           AS DECI FORMAT "->>,>>>,>>9.99". 
DEFINE            VAR dateasof          AS CHAR INIT "" .

DEFINE TEMP-TABLE wBill
    FIELD wPolicy       AS CHAR FORMAT "X(20)"            /*    Record Type        */                 
    FIELD wPoltype      AS CHAR FORMAT "X(3)"             /*    Sequence no.       */
    FIELD nv_sckno      AS CHAR FORMAT "x(30)"
    FIELD wcovcod       AS CHAR FORMAT "X(2)"             /*4   INS. Policy No.    */                   
    FIELD wtitle        AS CHAR FORMAT "X(10)"            /*5   insurance Type     */              
    FIELD wfirstname    AS CHAR FORMAT "X(25)"            /*6   Customer Title Name*/ 
    FIELD wlastname     AS CHAR FORMAT "X(65)"            /*7   Customer First Name / Company Name*/                
    FIELD wNor_Comdat   AS CHAR FORMAT "x(8)"             /*8   Customer Last Name */                 
    FIELD wNor_Expdat   AS CHAR FORMAT "x(8)"             /*9   วันเริ่มคุ้มครอง   */                
    FIELD wsuminsurce   AS DECI FORMAT "->>>,>>>,>>9.99"  /*10  วันสิ้นสุดคุ้มครอง */                     
    FIELD wNetprm       AS DECI FORMAT "->>>,>>>,>>9.99"  /*11  Sum Insured        */                      
    FIELD wtotNetprm    AS DECI FORMAT "->>>,>>>,>>9.99"  /*12  Net.INS.Prm        */                     
    FIELD wChassis_no   AS CHAR FORMAT "X(22)"            /*14  Chassis No.        */                      
    FIELD wEngine_no    AS CHAR FORMAT "X(22)"            /*15  Engine No.         */                        
    FIELD wBrandModel   AS CHAR FORMAT "X(45)"
    FIELD wFee          AS DECI FORMAT "->>>,>>>,>>9.99"  /*16  ค่า Fee            */                             
    FIELD wFeeamount    AS DECI FORMAT "->>>,>>>,>>9.99"  /*17  ค่า Fee amount     */                   
    FIELD wFee_orthe    AS DECI FORMAT "->>>,>>>,>>9.99"  /*18  ค่าอนุโลม          */                         
    FIELD wAcno         AS CHAR FORMAT "X(10)"                                  
    FIELD wEndno        AS CHAR FORMAT "X(12)"
    FIELD wTrnty1       AS CHAR FORMAT "X"
    FIELD wTrnty2       AS CHAR FORMAT "X"
    FIELD wDocno        AS CHAR FORMAT "X(10)"
    FIELD wRecordno     AS INTE FORMAT "999999"
    FIELD wbal          AS DECI FORMAT "->>>,>>>,>>9.99"  /* Balance        */

    INDEX wBill01 IS UNIQUE PRIMARY   wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
    INDEX wBill02 wAcno wPolType
    INDEX wBill03 wAcno
    INDEX wBill04 wPoltype        
    INDEX wBill05 wPolicy  wEndNo .

DEFINE STREAM filebill1.
DEFINE STREAM filebill2.
DEFINE STREAM filebill3.
DEFINE STREAM filebill4.
DEFINE STREAM filebill5.
DEFINE STREAM filebill6.
DEFINE STREAM filebill7.
DEFINE STREAM filebill8.
DEFINE STREAM filebill9.
DEFINE STREAM filebill10. /* A65-0021 */

DEFINE VAR vExpCount1   AS INTE INIT 0.
DEFINE VAR vCountRec    AS INTE INIT 0.    
DEFINE VAR vBackUp      AS CHAR.
DEFINE VAR vAcProc_fil  AS CHAR.
DEFINE VAR nv_strdate   AS CHAR.
DEFINE VAR nv_enddate   AS CHAR.
DEFINE VAR nv_accode    AS CHAR FORMAT "X(10)".
DEFINE VAR nv_sumfile   AS CHAR FORMAT "X(100)".
DEFINE VAR nv_sumprem   AS DECI FORMAT ">>>,>>>,>>>,>>9.99".
DEFINE VAR nv_fptr      AS RECID.
DEFINE VAR nv_rec100    AS RECID.  
DEFINE VAR nv_grossPrem_com1 AS DECI FORMAT "->>,>>>,>>9.99".   
DEFINE VAR nv_row       as  int  init 0.
DEFINE VAR nv_cnt       as  int  init  0.
DEF STREAM ns2.
DEFINE VAR nv_daily     AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.

DEF VAR nv_RecordType           AS CHAR FORMAT "x"     .                                 
DEF VAR nv_Sequenceno           AS CHAR FORMAT "x(5)"  .                                    
DEF VAR nv_INS_PolicyNo         AS CHAR FORMAT "x(40)" .             
DEF VAR nv_insuranceType        AS CHAR FORMAT "x(4)"  .      
DEF VAR nv_CustomerTitleName    AS CHAR FORMAT "X(10)" .      /*5   insurance Type     */                                    
DEF VAR nv_CustomerFirstNAME    AS CHAR FORMAT "X(25)" .      /*6   Customer Title Name*/                                    
DEF VAR nv_CustomerLastName     AS CHAR FORMAT "X(65)" .      /*7   Customer First Name / Company Name*/      
DEF VAR nv_comdate              AS CHAR FORMAT "x(8)"  .      /*8   Customer Last Name */                     
DEF VAR nv_expdate              AS CHAR FORMAT "x(8)"  .      /*9   วันเริ่มคุ้มครอง   */                     
DEF VAR nv_SumInsured           AS CHAR FORMAT "x(20)" .      /*10  วันสิ้นสุดคุ้มครอง */                     
DEF VAR nv_NetINSPrm            AS CHAR FORMAT "x(20)" .      /*11  Sum Insured        */                     
DEF VAR nv_TotalINSPrm          AS CHAR FORMAT "x(20)" .      /*12  Net.INS.Prm        */                     
def var nv_ChassisNo            AS CHAR FORMAT "X(22)" .      /*14  Chassis No.        */                     
def var nv_EngineNo             AS CHAR FORMAT "X(22)" .      /*15  Engine No.         */                     
def var nv_Fee                  AS CHAR FORMAT "x(20)" .      /*16  ค่า Fee            */                     
def var nv_Feeamount            AS CHAR FORMAT "x(20)" .      /*17  ค่า Fee amount     */ 
def var nv_fee01                AS CHAR FORMAT "x(20)" .      /*18  ค่าอนุโลม          */

DEFINE VAR tim01        AS CHAR INIT "".
DEFINE VAR tim02        AS CHAR INIT "".
DEFINE VAR tim02_1      AS INTE INIT 0.
DEFINE VAR tim02_2      AS INTE INIT 0.
DEFINE VAR tim02_3      AS INTE INIT 0.
DEFINE VAR vProdCod     AS CHAR.
DEFINE VAR vChkFirstAdd AS INT.
DEFINE VAR n_append     AS CHAR INIT "" .

DEFINE TEMP-TABLE wBill2
    FIELD recordtyp     AS CHAR FORMAT "x"   
    FIELD asofdate      AS CHAR FORMAT "x(8)"  
    FIELD producttype   AS CHAR FORMAT "x(1)"  
    FIELD sequenceno    AS CHAR FORMAT "x(5)"   
    FIELD companyname   AS CHAR FORMAT "x(5)"   
    FIELD product       AS CHAR FORMAT "x(5)"   
    FIELD insurcename   AS CHAR FORMAT "x(40)"
    FIELD insurcecode   AS CHAR FORMAT "x(4)"    
    FIELD wPolicy       AS CHAR FORMAT "X(20)"  /*    Record Type        */  
    FIELD wcovcod       AS CHAR FORMAT "X(2)"   /*4   INS. Policy No.    */                   
    FIELD wtitle        AS CHAR FORMAT "X(10)"  /*5   insurance Type     */                                              
    FIELD wfirstname    AS CHAR FORMAT "X(25)"  /*6   Customer Title Name*/                           
    FIELD wlastname     AS CHAR FORMAT "X(65)"  /*7   Customer First Name / Company Name*/            
    FIELD wNor_Comdat   AS CHAR FORMAT "x(8)"   /*8   Customer Last Name */                                           
    FIELD wNor_Expdat   AS CHAR FORMAT "x(8)"   /*9   วันเริ่มคุ้มครอง   */                             
    FIELD wsuminsurce   AS DECI FORMAT "->>>,>>>,>>9.99"    /*10  วันสิ้นสุดคุ้มครอง */              
    FIELD wNetprm       AS DECI FORMAT "->>>,>>>,>>9.99"    /*11  Sum Insured        */                                 
    FIELD wtotNetprm    AS DECI FORMAT "->>>,>>>,>>9.99"    /*12  Net.INS.Prm        */                                  
    FIELD wChassis_no   AS CHAR FORMAT "X(22)"              /*14  Chassis No.        */                                 
    FIELD wEngine_no    AS CHAR FORMAT "X(22)"              /*15  Engine No.         */                                  
    FIELD wBrandModel   AS CHAR FORMAT "X(45)"
    FIELD wFee          AS DECI FORMAT "->>>,>>>,>>9.99"    /*16  ค่า Fee            */                                          
    FIELD wFeeamount    AS DECI FORMAT "->>>,>>>,>>9.99"    /*17  ค่า Fee amount     */
    FIELD wFee_orthe    AS DECI FORMAT "->>>,>>>,>>9.99"    /*18  ค่าอนุโลม          */   
    INDEX wBill202 wPolicy .

DEF VAR nv_comdat AS DATE FORMAT "99/99/9999".
DEF VAR nv_expdat AS DATE FORMAT "99/99/9999".
DEF VAR nv_endno  AS CHAR FORMAT "X(10)".
DEF VAR nv_ntitle AS CHAR FORMAT "X(25)".
DEF VAR nv_fname  AS CHAR FORMAT "X(35)".
DEF VAR nv_lname  AS CHAR FORMAT "X(35)".
DEF VAR nv_covcod AS CHAR FORMAT "X(15)".
DEF VAR nv_cha_no AS CHAR FORMAT "X(35)".
DEF VAR nv_eng_no AS CHAR FORMAT "X(35)".
DEF VAR nv_model  AS CHAR FORMAT "X(45)".

DEFINE TEMP-TABLE wBill3
    FIELD wPolicy       AS CHAR FORMAT "X(20)"            /*    Record Type        */                 
    FIELD wPoltype      AS CHAR FORMAT "X(3)"             /*    Policy Type       */
    FIELD nv_sckno      AS CHAR FORMAT "x(30)"
    FIELD wcovcod       AS CHAR FORMAT "X(2)"             /*4   INS. Policy No.    */                   
    FIELD wtitle        AS CHAR FORMAT "X(10)"            /*5   insurance Type     */              
    FIELD wfirstname    AS CHAR FORMAT "X(25)"            /*6   Customer Title Name*/ 
    FIELD wlastname     AS CHAR FORMAT "X(65)"            /*7   Customer First Name / Company Name*/                
    FIELD wNor_Comdat   AS CHAR FORMAT "x(8)"             /*8   Customer Last Name */                 
    FIELD wNor_Expdat   AS CHAR FORMAT "x(8)"             /*9   วันเริ่มคุ้มครอง   */                
    FIELD wsuminsurce   AS DECI FORMAT "->>>,>>>,>>9.99"  /*10  วันสิ้นสุดคุ้มครอง */                     
    FIELD wNetprm       AS DECI FORMAT "->>>,>>>,>>9.99"  /*11  Sum Insured        */                      
    FIELD wtotNetprm    AS DECI FORMAT "->>>,>>>,>>9.99"  /*12  Net.INS.Prm        */                     
    FIELD wChassis_no   AS CHAR FORMAT "X(22)"            /*14  Chassis No.        */                      
    FIELD wEngine_no    AS CHAR FORMAT "X(22)"            /*15  Engine No.         */                        
    FIELD wBrandModel   AS CHAR FORMAT "X(45)"
    FIELD wFee          AS DECI FORMAT "->>>,>>>,>>9.99"  /*16  ค่า Fee            */                             
    FIELD wFeeamount    AS DECI FORMAT "->>>,>>>,>>9.99"  /*17  ค่า Fee amount     */                   
    FIELD wFee_orthe    AS DECI FORMAT "->>>,>>>,>>9.99"  /*18  ค่าอนุโลม          */                         
    FIELD wAcno         AS CHAR FORMAT "X(10)"                                  
    FIELD wEndno        AS CHAR FORMAT "X(12)"
    FIELD wTrnty1       AS CHAR FORMAT "X"
    FIELD wTrnty2       AS CHAR FORMAT "X"
    FIELD wDocno        AS CHAR FORMAT "X(10)"
    FIELD wRecordno     AS INTE FORMAT "999999"
    FIELD wbal          AS DECI FORMAT "->>>,>>>,>>9.99"  /* Balance        */

    INDEX wBill301 IS UNIQUE PRIMARY   wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
    INDEX wBill302 wPolicy  wEndNo
    INDEX wBill303 wAcno wPoltype wPolicy .

DEFINE TEMP-TABLE wBill4
    FIELD wrecordtyp     AS CHAR FORMAT "x"                 /*    Record Type        */  
    FIELD wasofdate      AS CHAR FORMAT "x(8)" 
    FIELD wAcno          AS CHAR FORMAT "x(10)"
    FIELD wsequenceno    AS CHAR FORMAT "x(5)" 
    FIELD wPolicy       AS CHAR FORMAT "X(20)"             /*4  INS. Policy No.    */                
    FIELD wPoltype      AS CHAR FORMAT "X(3)"              /*   Policy Type        */
    FIELD wcovcod       AS CHAR FORMAT "X(2)"              /*5  insurance Type     */                   
    FIELD wSckno        AS CHAR FORMAT "X(15)"
    FIELD wtitle        AS CHAR FORMAT "X(15)"             /*6  Customer Title Name*/                                              
    FIELD wfirstname    AS CHAR FORMAT "X(35)"             /*7  Customer First Name*/            
    FIELD wlastname     AS CHAR FORMAT "X(45)"             /*8  Customer Last Name */                           
    FIELD wNor_Comdat   AS CHAR FORMAT "x(8)"              /*9  วันเริ่มคุ้มครอง   */                                           
    FIELD wNor_Expdat   AS CHAR FORMAT "x(8)"              /*10 วันสิ้นสุดคุ้มครอง */    
    FIELD wsuminsurce   AS DECI FORMAT "->>>,>>>,>>9.99"   /*11  Sum Insured        */
    FIELD wNetprm       AS DECI FORMAT "->>>,>>>,>>9.99"   /*12  Net.INS.Prm        */          
    FIELD wtotNetprm    AS DECI FORMAT "->>>,>>>,>>9.99"   /*13 Total Net.Prm       */
    FIELD wChassis_no   AS CHAR FORMAT "X(22)"             /*14  Chassis No.        */
    FIELD wEngine_no    AS CHAR FORMAT "X(22)"             /*15  Engine No.         */
    FIELD wFee          AS DECI FORMAT "->>>,>>>,>>9.99"   /*16  ค่า Fee %          */                                          
    FIELD wFeeamount    AS DECI FORMAT "->>>,>>>,>>9.99"   /*17  ค่า Fee amount     */
    FIELD wFee_orthe    AS DECI FORMAT "->>>,>>>,>>9.99"   /*18  ค่าอนุโลม          */   
    FIELD wBrandModel   AS CHAR FORMAT "X(45)"             /*    Model Description  */                      
    FIELD wbal          AS DECI FORMAT "->>>,>>>,>>9.99"  /* Balance        */

    INDEX wBill401 IS UNIQUE PRIMARY wPolicy ASCENDING
    INDEX wBill402 wAcno     wPolicy  
    INDEX wBill403 wAcno     wPolType  
    INDEX wBill404 wPolType .

DEF VAR nv_InsureSticker  AS CHAR FORMAT "x(15)".
DEF VAR nv_InsureCover    AS CHAR FORMAT "x(2)". 
DEF VAR nv_Brand          AS CHAR FORMAT "x(50)".
DEF VAR nv_acno           AS CHAR FORMAT "x(10)".
DEF VAR nv_poltype        AS CHAR FORMAT "X(5)".
DEF VAR nv_bal            AS DECI FORMAT "->>>,>>>,>>9.99".

DEF BUFFER bwBill4 FOR wBill4.
DEF VAR nv_confile AS CHAR.
DEF VAR nv_reccnt  AS INT .


/*--- A65-0021 ---*/
DEF TEMP-TABLE  wImportData
    FIELD wField AS CHAR format "x(256)" init "".

/* สำหรับเป็น Key ในการกรองข้อมูลเฉพาะที่ต้องการ */
DEF VAR gv_FreeFix   AS DECI .
DEF VAR gv_Key1      AS CHAR INIT  "FreeRate". 
DEF VAR gv_Key2      AS CHAR INIT  "FN". 
DEF VAR gv_freeCnt   AS INT.
/*--- A65-0021 ---*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_browse

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Insure

/* Definitions for BROWSE br_browse                                     */
&Scoped-define FIELDS-IN-QUERY-br_browse Insure.FName Insure.LName ~
Insure.Addr1 Insure.Addr2 Insure.Addr3 Insure.Addr4 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_browse 
&Scoped-define QUERY-STRING-br_browse FOR EACH Insure NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_browse OPEN QUERY br_browse FOR EACH Insure NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_browse Insure
&Scoped-define FIRST-TABLE-IN-QUERY-br_browse Insure


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_browse}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fiBranch fiBranch2 fi_grpstat fi_trandatF ~
fi_trandatT fi_binloop fi_bindate fiFile-Name1 br_browse ra_Free cbAsDat ~
bu_add bu_del bu_delall Btn_OK fibdes fiFile-Nameinput bu_file ra_filetype ~
Btn_conver fi_freeper se_producer Btn_Exit fibdes2 fi_process buBranch ~
buBranch2 bu_SplitFile fi_rate bu_Rate bu_help RECT-5 RECT-6 RECT-7 RECT-8 ~
RECT-1 RECT-3 RECT-2 RECT-615 RECT-616 RECT-617 RECT-618 
&Scoped-Define DISPLAYED-OBJECTS fiBranch fiBranch2 fi_grpstat fi_trandatF ~
fi_trandatT fi_binloop fi_bindate fiFile-Name1 ra_Free cbAsDat fibdes ~
fiFile-Nameinput ra_filetype fi_freeper se_producer fibdes2 fi_process ~
fi_rate 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuDateToChar C-Win 
FUNCTION fuDateToChar RETURNS CHARACTER
  (vDate AS DATE)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuDeciToChar C-Win 
FUNCTION fuDeciToChar RETURNS CHARACTER
  ( vDeci   AS DECIMAL, vCharno AS INTEGER )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuFindAcno C-Win 
FUNCTION fuFindAcno RETURNS LOGICAL
  ( nv_accode AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuFindBranch C-Win 
FUNCTION fuFindBranch RETURNS CHARACTER
  ( nv_branch AS CHAR )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( Y AS INTEGER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  ( vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_conver AUTO-GO 
     LABEL "CONVERT" 
     SIZE 16.17 BY 1
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 11.17 BY 1.19
     BGCOLOR 8 FONT 2.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "Output File" 
     SIZE 16.5 BY 1
     BGCOLOR 8 FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3.5 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3.5 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 6.5 BY .95.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6.5 BY .95.

DEFINE BUTTON bu_delall 
     LABEL "DELAll" 
     SIZE 6.5 BY .95.

DEFINE BUTTON bu_file 
     LABEL "...." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_help 
     LABEL "Ex.file upload" 
     SIZE 13.5 BY .91.

DEFINE BUTTON bu_Rate 
     LABEL "Import" 
     SIZE 7.83 BY 1.

DEFINE BUTTON bu_SplitFile AUTO-GO 
     LABEL "Split File" 
     SIZE 16.5 BY 1
     BGCOLOR 8 FONT 6.

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U INITIAL ? 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 42.67 BY .95
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 42.67 BY .95
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Nameinput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bindate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_binloop AS INTEGER FORMAT "9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_freeper AS DECIMAL FORMAT "->>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_grpstat AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 102.33 BY .86
     BGCOLOR 172 FGCOLOR 30 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_rate AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 53.5 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_trandatF AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trandatT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_filetype AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Convert file CSV 70 to Text ", 1,
"Convert file CSV 72 to Text ", 2
     SIZE 62.67 BY .86
     BGCOLOR 14 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_Free AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          " 22% ", 1,
"Change % to ", 2
     SIZE 20 BY 1.95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21 BY 15.33
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 43.33 BY 2.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21 BY 1.33
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 120.83 BY 23.1
     BGCOLOR 173 FGCOLOR 0 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 1.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-615
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 103.83 BY 4.67
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-616
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 1.81
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-617
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19 BY 1.81
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-618
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73.5 BY 12.81
     BGCOLOR 79 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.17 BY 1.91
     BGCOLOR 155 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 121 BY 1.38
     BGCOLOR 19 .

DEFINE VARIABLE se_producer AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 16 BY 4.76
     BGCOLOR 15  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_browse FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_browse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_browse C-Win _STRUCTURED
  QUERY br_browse NO-LOCK DISPLAY
      Insure.FName COLUMN-LABEL "Group File" FORMAT "X(10)":U
      Insure.LName COLUMN-LABEL "Account No" FORMAT "X(13)":U
      Insure.Addr1 COLUMN-LABEL "V70 ป1" FORMAT "X(7)":U
      Insure.Addr2 COLUMN-LABEL "V70 ป2" FORMAT "X(7)":U
      Insure.Addr3 COLUMN-LABEL "V70 ป3" FORMAT "X(7)":U
      Insure.Addr4 COLUMN-LABEL "V72" FORMAT "X(7)":U WIDTH 6.83
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 58 BY 10.14
         BGCOLOR 15 FGCOLOR 2  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fiBranch AT ROW 2.86 COL 22.33 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 3.95 COL 22.33 COLON-ALIGNED NO-LABEL
     fi_grpstat AT ROW 5.14 COL 22.33 COLON-ALIGNED NO-LABEL
     fi_trandatF AT ROW 11.48 COL 22.33 COLON-ALIGNED NO-LABEL
     fi_trandatT AT ROW 12.57 COL 22.33 COLON-ALIGNED NO-LABEL
     fi_binloop AT ROW 15.14 COL 22.33 COLON-ALIGNED NO-LABEL
     fi_bindate AT ROW 16.43 COL 22.17 COLON-ALIGNED NO-LABEL
     fiFile-Name1 AT ROW 18.29 COL 22.17 COLON-ALIGNED NO-LABEL
     br_browse AT ROW 6.1 COL 48.83 WIDGET-ID 2500
     ra_Free AT ROW 2.67 COL 87 NO-LABEL WIDGET-ID 16
     cbAsDat AT ROW 13.81 COL 22.33 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 5.19 COL 40.83
     bu_del AT ROW 6.57 COL 40.83
     bu_delall AT ROW 8 COL 40.83
     Btn_OK AT ROW 18.19 COL 87.83
     fibdes AT ROW 2.86 COL 31.33 COLON-ALIGNED NO-LABEL
     fiFile-Nameinput AT ROW 20.95 COL 14.33 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 20.95 COL 82.17
     ra_filetype AT ROW 23 COL 16.33 NO-LABEL
     Btn_conver AT ROW 23.24 COL 87.83
     fi_freeper AT ROW 3.71 COL 105 COLON-ALIGNED NO-LABEL
     se_producer AT ROW 6.14 COL 24.33 NO-LABEL
     Btn_Exit AT ROW 23.67 COL 108.5
     fibdes2 AT ROW 3.95 COL 31.33 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.67 COL 3.17 NO-LABEL
     buBranch AT ROW 2.86 COL 29.5
     buBranch2 AT ROW 3.95 COL 29.5
     bu_SplitFile AT ROW 21.19 COL 87.67 WIDGET-ID 14
     fi_rate AT ROW 16.62 COL 57 COLON-ALIGNED NO-LABEL WIDGET-ID 30
     bu_Rate AT ROW 16.62 COL 112.67 WIDGET-ID 32
     bu_help AT ROW 15.33 COL 107.33 WIDGET-ID 86
     " รอบของการวางบิล" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 15.1 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "3.Bay-70" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.29 COL 107.83 WIDGET-ID 58
          BGCOLOR 79 FGCOLOR 7 FONT 6
     " Input Rate:" VIEW-AS TEXT
          SIZE 10.17 BY .95 AT ROW 16.67 COL 48.83 WIDGET-ID 72
          BGCOLOR 18 FGCOLOR 2 
     " To:" VIEW-AS TEXT
          SIZE 4.5 BY .86 AT ROW 12.62 COL 18.33
          BGCOLOR 20 FGCOLOR 0 FONT 6
     "6.AY-72Fee" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 10.29 COL 107.83 WIDGET-ID 84
          BGCOLOR 79 FGCOLOR 7 FONT 6
     " **ถ้าไม่มีใน Rate table จะใช้ Free% Program Fix":100 VIEW-AS TEXT
          SIZE 39.5 BY .81 AT ROW 5.29 COL 67.17 WIDGET-ID 74
          BGCOLOR 14 FGCOLOR 2 
     "7.Renew-70" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 11.29 COL 107.83 WIDGET-ID 62
          BGCOLOR 79 FGCOLOR 7 FONT 6
     "**การ Split file จะได้ file ที่เป็น .CSV ทั้งหมด 7 file โดยบันทึกลงที่ D:~\TEMP":100 VIEW-AS TEXT
          SIZE 65 BY .62 AT ROW 22.05 COL 16.5 WIDGET-ID 22
          BGCOLOR 14 FGCOLOR 2 
     " Input File :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 21 COL 4.17
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "9.Other-70" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 13.29 COL 107.83 WIDGET-ID 90
          BGCOLOR 79 FGCOLOR 7 FONT 6
     "  Free Rate Table" VIEW-AS TEXT
          SIZE 18 BY .81 AT ROW 5.29 COL 49 WIDGET-ID 52
          BGCOLOR 62 FGCOLOR 7 FONT 6
     "1.BigBike" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 5.29 COL 107.83 WIDGET-ID 54
          BGCOLOR 79 FGCOLOR 7 FONT 6
     "Free%" VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 2.67 COL 79.5
          BGCOLOR 20 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 122.17 BY 24.95
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Group Statement" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 5.33 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Output To TextFile" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 18.29 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Branch From":25 VIEW-AS TEXT
          SIZE 19 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 2.86 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Text File เพื่อวางบิลเรียกเก็บเงินค่าเบี้ยฯ จาก บมจ. อยุธยา แคปปิตอล ออโต้ลีส" VIEW-AS TEXT
          SIZE 110.33 BY 1 AT ROW 1.24 COL 2.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Branch To":10 VIEW-AS TEXT
          SIZE 19 BY .95 TOOLTIP "ถึงสาขา" AT ROW 3.95 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " V. 2.20" VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 1.24 COL 112.5 WIDGET-ID 88
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "8.Install-70" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 12.29 COL 107.83 WIDGET-ID 68
          BGCOLOR 79 FGCOLOR 7 FONT 6
     "รอบวันของการวางบิล" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 16.33 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " As of Date (Statement)":30 VIEW-AS TEXT
          SIZE 19 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 13.81 COL 4
          BGCOLOR 19 FGCOLOR 0 
     "      Trandate From:" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 11.48 COL 4
          BGCOLOR 20 FGCOLOR 0 FONT 6
     "4.Bay-72" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 8.29 COL 107.83 WIDGET-ID 60
          BGCOLOR 79 FGCOLOR 7 FONT 6
     "2.ISUZU" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.29 COL 107.83 WIDGET-ID 56
          BGCOLOR 79 FGCOLOR 7 FONT 6
     "**การ Convert file จะได้ file ที่เป็น .txt คั่นด้วย |":100 VIEW-AS TEXT
          SIZE 59.83 BY .62 AT ROW 24 COL 16.5 WIDGET-ID 24
          BGCOLOR 14 FGCOLOR 2 
     "10.Other-72" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 14.29 COL 107.83 WIDGET-ID 92
          BGCOLOR 79 FGCOLOR 7 FONT 6
     "5.AY-72" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 9.29 COL 107.83 WIDGET-ID 64
          BGCOLOR 79 FGCOLOR 7 FONT 6
     RECT-5 AT ROW 2.43 COL 1.17
     RECT-6 AT ROW 17.95 COL 86.67
     RECT-7 AT ROW 23.33 COL 107.5
     RECT-8 AT ROW 1 COL 1
     RECT-1 AT ROW 2.57 COL 3
     RECT-3 AT ROW 18.1 COL 3
     RECT-2 AT ROW 2.43 COL 78.17
     RECT-615 AT ROW 20.62 COL 3.17 WIDGET-ID 4
     RECT-616 AT ROW 22.86 COL 86.5 WIDGET-ID 6
     RECT-617 AT ROW 20.81 COL 86.5 WIDGET-ID 20
     RECT-618 AT ROW 5.1 COL 48 WIDGET-ID 50
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 122.17 BY 24.95
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
         TITLE              = "WACRAY6 - STATEMENT AYCL (บมจ. อยุธยา แคปปิตอล ออโต้ลีส)"
         HEIGHT             = 24.86
         WIDTH              = 121.83
         MAX-HEIGHT         = 33.1
         MAX-WIDTH          = 154.67
         VIRTUAL-HEIGHT     = 33.1
         VIRTUAL-WIDTH      = 154.67
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
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
/* BROWSE-TAB br_browse fiFile-Name1 fr_main */
/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_browse
/* Query rebuild information for BROWSE br_browse
     _TblList          = "stat.Insure"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > stat.Insure.FName
"Insure.FName" "Group File" "X(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > stat.Insure.LName
"Insure.LName" "Account No" "X(13)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > stat.Insure.Addr1
"Insure.Addr1" "V70 ป1" "X(7)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > stat.Insure.Addr2
"Insure.Addr2" "V70 ป2" "X(7)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > stat.Insure.Addr3
"Insure.Addr3" "V70 ป3" "X(7)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > stat.Insure.Addr4
"Insure.Addr4" "V72" "X(7)" "character" ? ? ? ? ? ? no ? no no "6.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is OPENED
*/  /* BROWSE br_browse */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WACRAY6 - STATEMENT AYCL (บมจ. อยุธยา แคปปิตอล ออโต้ลีส) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WACRAY6 - STATEMENT AYCL (บมจ. อยุธยา แคปปิตอล ออโต้ลีส) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_conver
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_conver C-Win
ON CHOOSE OF Btn_conver IN FRAME fr_main /* CONVERT */
DO:
    FOR EACH wBill2 : DELETE  wBill2. END.
    
    RUN proc_init.

    IF fiFile-Nameinput = "" THEN MESSAGE "กรุณาระบุ Path และ File ที่ต้องการจะใช้ Convert" VIEW-AS ALERT-BOX WARNING.
    ELSE DO:
    
        IF      ra_filetype = 1 THEN RUN proc_output2.  /*convert 70*/
        ELSE IF ra_filetype = 2 THEN RUN proc_output3.  /*convert 72*/
    
        MESSAGE "Convert File Complete" SKIP(1)
                "Convert File to : " nv_confile  VIEW-AS ALERT-BOX INFORMATION.
                
    END.
    
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Exit C-Win
ON CHOOSE OF Btn_Exit IN FRAME fr_main /* Exit */
DO:
    APPLY "Close" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME fr_main /* Output File */
DO:
    
    ASSIGN
        tim01          = STRING(TIME,"HH:MM:SS")  
        fibranch       fibranch
        fibranch2      fibranch2   
        fiFile-Name1   fiFile-Name1
        n_branch       =  fiBranch
        n_branch2      =  fiBranch2
        n_asdat        =  DATE(INPUT cbAsDat)
        n_OutputFile1  =  fiFile-Name1 .

    IF fiBranch = "" THEN DO:
        MESSAGE "กรุณาใส่รหัสสาขา" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" TO fiBranch.
        RETURN NO-APPLY.
    END.
    IF fiBranch2 = "" THEN DO:
        MESSAGE "กรุณาใส่รหัสสาขา" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" TO fiBranch2.
        RETURN NO-APPLY.
    END.
    IF (fiBranch > fiBranch2) THEN DO:
        MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
            "รหัสสาขาเริ่มต้นต้องน้อยกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" To fibranch.
        RETURN NO-APPLY.
    END.
    IF fi_binloop = 0 THEN DO:
        MESSAGE "กรุณาคีย์จำนวนรอบของการวางบิล" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" TO fi_binloop.
        RETURN NO-APPLY.
    END.
    IF fi_bindate = ? THEN DO:
        MESSAGE "กรุณาคีย์รอบวันที่ของการวางบิล" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" TO fi_bindate.
        RETURN NO-APPLY.
    END.
    IF n_OutputFile1 = "" THEN DO:
        MESSAGE "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" TO fiFile-Name1.
        RETURN NO-APPLY.
    END.
    ASSIGN 
        nv_strdate = STRING(TODAY,"99/99/9999") + " (" +
                     STRING(TIME ,"HH:MM:SS")   + " น.)".

    RUN PD_Proc.           /* Process Data from agtprm ลง Temp-Table */
    RUN PD_GrpByPolicyNo.  /* Group รวมข้อมูลของกรมธรรม์และสลักหลังเป็นเรคคอร์ดเดียว */
    RUN PD_PutCSV.         /* Export Data to CSV format */

    DISPLAY "Export Data Complete...." @ fi_process WITH FRAME {&FRAME-NAME}.
    ASSIGN nv_enddate = STRING(TODAY,"99/99/9999") + " (" + STRING(TIME ,"HH:MM:SS")   + " น.)"
           tim02   = STRING(TIME,"HH:MM:SS")
           tim02_1 = 0
           tim02_2 = 0
           tim02_3 = 0 .

    IF  DECI(SUBSTR(tim02,7,2)) < DECI(SUBSTR(tim01,7,2))  THEN DO:
        ASSIGN tim02_3 =  DECI(SUBSTR(tim02,7,2)) + 60 .
        IF DECI(SUBSTR(tim02,4,2)) < DECI(SUBSTR(tim01,4,2))    THEN DO:
            ASSIGN tim02_2 = DECI(SUBSTR(tim02,4,2)) + 60 - 1
                   tim02_1 = DECI(SUBSTR(tim02,1,2)) - 1.
        END.
        ELSE 
            ASSIGN tim02_2 = DECI(SUBSTR(tim02,4,2)) - 1
                   tim02_1 = DECI(SUBSTR(tim02,1,2)) .
    END.
    ELSE DO: 
        IF DECI(SUBSTR(tim02,4,2)) < DECI(SUBSTR(tim01,4,2)) THEN 
            ASSIGN tim02_3 = DECI(SUBSTR(tim02,7,2))
                   tim02_2 = DECI(SUBSTR(tim02,4,2)) + 60 
                   tim02_1 = DECI(SUBSTR(tim02,1,2)) - 1.
        ELSE 
            ASSIGN tim02_1 =  DECI(SUBSTR(tim02,1,2))
                   tim02_2   =  DECI(SUBSTR(tim02,4,2))
                   tim02_3 =  DECI(SUBSTR(tim02,7,2)).
    END.
    ASSIGN
        tim02 = string(tim02_1 - DECI(SUBSTR(tim01,1,2)),"99") + ":" +
                string(tim02_2 - DECI(SUBSTR(tim01,4,2)),"99") + ":" + 
                string(tim02_3 - DECI(SUBSTR(tim01,7,2)),"99").
    MESSAGE 
        "ข้อมูล Text file ต้นฉบับก่อน Group ข้อมูลอยู่ที่ D:\Temp\WACRAY6.TXT " SKIP(1)
        "จำนวนเรคคอร์ดใน Text File : " nv_reccnt " เรคคอร์ด" SKIP(2)
        "Group ข้อมูลลง CSV File   : " nvfiFile-Name2 SKIP(1)
      "การส่งออกข้อมูลจำนวน        : " vExpCount1  " รายการ" SKIP(1)
        FILL("=",35) SKIP(1)
        "Start Date : " nv_strdate   SKIP(1)
        "End Date   : " nv_enddate  
        "Time       : " tim01 STRING(TIME,"HH:MM:SS") tim02  VIEW-AS ALERT-BOX INFORMATION.
    ASSIGN tim01 = "" .
    APPLY "ENTRY" TO Btn_Exit.

END.   /*DO*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME fr_main /* ... */
DO:
    n_chkBName = "1".
    RUN Whp\Whpbran(INPUT-OUTPUT  n_bdes,INPUT-OUTPUT n_chkBName).
    
    ASSIGN
       fibranch = n_branch
       fibdes   = n_bdes.

   DISP fibranch fibdes WITH FRAME {&FRAME-NAME}.

   APPLY "ENTRY" TO fibranch IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 C-Win
ON CHOOSE OF buBranch2 IN FRAME fr_main /* ... */
DO:
    n_chkBName = "2".
    RUN Whp\Whpbran(INPUT-OUTPUT n_bdes,INPUT-OUTPUT n_chkBName).

    ASSIGN
        fibranch2 = n_branch2
        fibdes2   = n_bdes.

    DISP fibranch2 fibdes2 WITH FRAME {&FRAME-NAME}.

    APPLY "ENTRY" TO fibranch2 IN FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:

    FOR EACH xmm600 WHERE xmm600.gpstmt = fi_grpstat NO-LOCK .
    
       IF xmm600.acno <> "" THEN vProdCod = vProdCod + TRIM(CAPS(xmm600.acno)) + ",".
    
    END.
    IF fi_grpstat = "B3MLAY0100" THEN vProdCod = vProdCod + "A0M0018,A0M0019,A0M0028,A0M0061,A0M0073,A0M1011,B3M0039,". /*A63-0391*/
    
    vChkFirstAdd = 1.
    
    IF vChkFirstAdd = 1 THEN DO:
        DO WITH FRAME  fr_main :
            
            se_producer:ADD-FIRST(vProdCod).
            se_producer = se_producer:SCREEN-VALUE .
            vProdCod = se_producer:List-items.
    
        END.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
    DO WITH FRAME  fr_main :
        se_producer = se_producer:SCREEN-VALUE .
        IF  LOOKUP(se_producer,vProdCod) <> 0 THEN DO:
            IF LOOKUP(se_producer,vProdCod) = 1 THEN 
                vProdCod = SUBSTR(vProdCod,LENGTH(se_producer) + 2).
            ELSE 
                vProdCod = SUBSTR(vProdCod,1,INDEX(vProdCod,se_producer) - 2 ) + 
                    SUBSTR(vProdCod,INDEX(vProdCod,se_producer) + LENGTH(se_producer) ).
        END.
        ASSIGN   
            se_producer.
        se_producer:Delete(se_producer).
        se_producer = se_producer:SCREEN-VALUE .
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delall
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delall C-Win
ON CHOOSE OF bu_delall IN FRAME fr_main /* DELAll */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ท่านต้องการลบข้อมูลทั้งหมด    ? " UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลทั้งหมด".   
    IF logAns THEN DO:  
        
        ASSIGN   
            se_producer = vProdCod .
        se_producer:Delete(se_producer).
       
    END.

    vProdCod = "".
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* .... */
DO:
  DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
     
        SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
            FILTERS 
            "Text .csv" "*.csv" ,
            "Text .csv" "*.txt" ,
            "Text file" "*"
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.

    IF OKpressed = TRUE THEN DO:
        fiFile-Nameinput  = cvData.
        DISP fiFile-Nameinput WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_help
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_help C-Win
ON CHOOSE OF bu_help IN FRAME fr_main /* Ex.file upload */
DO:
  MESSAGE "File ที่ใช้ Upload ต้องเป็น type .csv โดยเรียงลำดับดังนี้" SKIP(2)
          "| Group | Account No | FreeRate70ป1 | FreeRate70ป2 | FreeRate70ป3 | FreeRate72 |" SKIP
          "------------------------------------------------------------------------------------" SKIP
          "| 1          | B000000001  | 10                     | 15                    | 15                    | -                  |" SKIP

          "| 2          | B000000005  | -                       | -                       | -                      | 12                |" SKIP
          "| 3          | B000000009  | 18                     | -                      | -                       | -                  |" SKIP
  VIEW-AS ALERT-BOX.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Rate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Rate C-Win
ON CHOOSE OF bu_Rate IN FRAME fr_main /* Import */
DO:
   DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
   DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.

   DEFINE VAR  nv_grp    AS CHAR.
   DEFINE VAR  nv_acno1  AS CHAR.
   DEFINE VAR  nv_rv701  AS CHAR.   
   DEFINE VAR  nv_rv702  AS CHAR.   
   DEFINE VAR  nv_rv703  AS CHAR.    
   DEFINE VAR  nv_rv72   AS CHAR.

   gv_freeCnt = 0.
      
   SYSTEM-DIALOG GET-FILE cvData
       TITLE      "Choose Data File to Import ..."
       FILTERS 
       "Text .csv" "*.csv" 
       MUST-EXIST
       USE-FILENAME
       UPDATE OKpressed.
   
   IF OKpressed = TRUE THEN DO:
       fi_rate  = cvData.
       DISP fi_rate WITH FRAME fr_main.     
   
       IF cvData <> "" THEN DO:

            /* การโหลด Free Rate ทุกครั้ง จะ Delete ข้อมูลเก่าทั้งหมดก่อน และยึดตามข้อมูลที่โหลดเข้าไปใหม่ */
            FOR EACH Insure USE-INDEX Insure01
                 WHERE Insure.CompNo   = gv_Key1   /* INIT  "FreeRate" */
                   AND Insure.InsTitle = gv_Key2 . /* INIT  "FN"       */

                DELETE Insure.

            END.
            /*-------------------------------------------------*/

           INPUT FROM VALUE (fi_rate).
              CREATE wImportData.
              IMPORT  wField .
           INPUT CLOSE.  
           
           INPUT FROM VALUE (fi_rate) .                                   
           REPEAT: 
               IMPORT DELIMITER ","
                   nv_grp
                   nv_acno1
                   nv_rv701 
                   nv_rv702
                   nv_rv703 
                   nv_rv72 .

               IF nv_grp >= "1" AND nv_grp <= "99" THEN DO:  /* ไม่เอาแถวแรก */
               
                   FIND FIRST Insure USE-INDEX Insure01
                        WHERE Insure.CompNo   = gv_Key1
                          AND Insure.InsTitle = gv_Key2 
                          AND Insure.FName    = nv_grp   /* 1,2,3...n */
                          AND Insure.LName    = TRIM(nv_acno1) NO-LOCK NO-ERROR.
                   IF NOT AVAILABLE Insure THEN DO:

                      gv_freeCnt = gv_freeCnt + 1.
               
                      CREATE Insure.
                      ASSIGN 
                        Insure.CompNo   = gv_Key1  
                        Insure.InsTitle = gv_Key2   
                        Insure.FName    = nv_grp
                        Insure.LName    = TRIM(nv_acno1)
                        Insure.Addr1    = if (nv_rv701 <= "0" and nv_rv701 >= "99") or nv_rv701 = "" then "-" else nv_rv701
                        Insure.Addr2    = if (nv_rv702 <= "0" and nv_rv702 >= "99") or nv_rv702 = "" then "-" else nv_rv702
                        Insure.Addr3    = if (nv_rv703 <= "0" and nv_rv703 >= "99") or nv_rv703 = "" then "-" else nv_rv703
                        Insure.Addr4    = if (nv_rv72  <= "0" and nv_rv72  >= "99") or nv_rv72  = "" then "-" else nv_rv72 
                        Insure.UDate    = TODAY
                        Insure.Text1    = "WACRAY6.W"
                        Insure.Text1    = "สำหรับใช้เก็บ Free Rate งาน AYCAL".
                   END.
               END.

               ASSIGN 
                 nv_grp    = ""
                 nv_acno1  = ""
                 nv_rv701  = ""
                 nv_rv702  = ""
                 nv_rv703  = ""
                 nv_rv72   = "".
           END.      /* repeat  */
           
           MESSAGE "Import Rate Complete.." SKIP
                   gv_freeCnt " รายการ" VIEW-AS ALERT-BOX INFORMATION.
    
           RUN PD_UpdateQ.
           
       END.
   END.

END.

/*
IF cvData <> "" THEN DO:
       
           FOR EACH wFreeRate : DELETE  wFreeRate. END.
           nv_cnt = 0.
           
           INPUT FROM VALUE (fi_rate) .                                   
           REPEAT: 
               IMPORT DELIMITER ","
                   nv_grp
                   nv_acno1
                   nv_rv701 
                   nv_rv702
                   nv_rv703 
                   nv_rv72 .
           
               FIND FIRST wFreeRate WHERE wFreeRate.wAcno = trim(nv_acno1) NO-LOCK NO-ERROR.
               IF NOT AVAIL wFreeRate THEN DO:
                   nv_cnt = nv_cnt + 1.
                   CREATE wFreeRate.
                   ASSIGN 
                     wFreeRate.wSeqno     = nv_cnt 
                     wFreeRate.wGrp       = nv_grp
                     wFreeRate.wAcno      = TRIM(nv_acno1)   
                     wFreeRate.wRateV701  = nv_rv701   
                     wFreeRate.wRateV702  = nv_rv702  
                     wFreeRate.wRateV703  = nv_rv703   
                     wFreeRate.wRateV72   = nv_rv72 .      
               END.
    
               ASSIGN 
                   nv_grp    = 0
                   nv_acno1  = ""
                   nv_rv701  = 0
                   nv_rv702  = 0
                   nv_rv703  = 0
                   nv_rv72   = 0.
           END.      /* repeat  */
           
           MESSAGE "Import Rate Complete.." VIEW-AS ALERT-BOX INFORMATION.
    
           RUN PD_UpdateQ.
           
       END.
*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_SplitFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_SplitFile C-Win
ON CHOOSE OF bu_SplitFile IN FRAME fr_main /* Split File */
DO:

    IF fiFile-Nameinput = "" THEN MESSAGE "กรุณาระบุ Path และ File ที่ต้องการจะใช้ Split File" VIEW-AS ALERT-BOX WARNING.
    ELSE DO:

        RUN PD_ImportCSV.

        /*------------- A65-0021 --------------
        RUN PD_SplitFile1.
        RUN PD_SplitFile2.
        /*RUN PD_SplitFile3.A63-0391*/
        RUN PD_SplitFile4.
        RUN PD_SplitFile5.
        /*Add A63-0391*/
        RUN PD_SplitFile5-1. 
        RUN PD_SplitFile5-2. 
        RUN PD_SplitFile5-3. 
        /*End A63-0391*/
        /*---
        RUN PD_SplitFile6.
        RUN PD_SplitFile7.
        RUN PD_SplitFile8.
        ----Block by A63-0391*/
        ---------------- A65-0021 -------------*/
        /* --- A65-0021  ---- ใช้โปรแกรมชุดใหม่
        RUN PD_SplitFile1.
        RUN PD_SplitFile2.
        RUN PD_SplitFile4.
        RUN PD_SplitFile5.
        RUN PD_SplitFile5-1. 
        RUN PD_SplitFile5-2. 
        RUN PD_SplitFile5-3. 
        ------------*/

        /* Clear Text file ทิ้งทุก 6 เดือน */
        IF MONTH(TODAY) = 6 OR MONTH(TODAY) = 12 THEN DO:
           OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt. 
           PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") SKIP.
           OUTPUT CLOSE.
        END.

        RUN PD_1SplitBigBike.
        RUN PD_2SplitISUZU.
        RUN PD_3SplitBay70.
        RUN PD_4SplitBay72.
        RUN PD_5SplitAY72.
        RUN PD_6SplitAY72Fee.
        RUN PD_7SplitRenew70.
        RUN PD_8SplitInstall70.
        RUN PD_90Oth70.
        RUN PD_91Oth72.

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ".--------------------------------------------------------------------------------" SKIP.
        OUTPUT CLOSE.

        /*------ A65-0021 -----*/
        
        /**/
        MESSAGE "Import Data Total : " nv_cnt " record" SKIP(1)
                "Split File Complete, See file split at D:\TEMP "   VIEW-AS ALERT-BOX INFORMATION.
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbAsDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON LEAVE OF cbAsDat IN FRAME fr_main
DO:
    /*p-------------*/
    cbAsDat = INPUT cbAsDat.
    n_asdat = DATE(INPUT cbAsDat).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*-------------p*/

    APPLY "ENTRY" TO fi_trandatF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON RETURN OF cbAsDat IN FRAME fr_main
DO:
    APPLY "LEAVE" TO cbAsDat.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON VALUE-CHANGED OF cbAsDat IN FRAME fr_main
DO:
    /*p-------------*/
    cbAsDat = INPUT cbAsDat.
    n_asdat = DATE(INPUT cbAsDat).

    IF n_asdat = ? THEN DO:
        MESSAGE "ไม่พบข้อมูล กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    APPLY "ENTRY" TO fi_trandatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiBranch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME fr_main
DO:
    ASSIGN
        fibranch = CAPS(INPUT fibranch)
        n_branch = fibranch.

    fibdes  = fuFindBranch(fibranch).

    IF fibdes = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX WARNING.
        APPLY "ENTRY" TO fiBranch.
        RETURN NO-APPLY.
    END.

    DISP fibranch fibdes WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiBranch2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME fr_main
DO:
    ASSIGN
        fibranch2 = INPUT fibranch2
        n_branch2  = fibranch2.

    fibdes2 = fuFindBranch(fibranch2).

    IF fibdes2 = "" THEN DO:
        MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX WARNING TITLE "Warning!".
        APPLY "ENTRY" TO fiBranch2.
        RETURN NO-APPLY.
    END.

    DISP fibranch2 fibdes2 WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON LEAVE OF fiFile-Name1 IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiFile-Name1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name1 C-Win
ON RETURN OF fiFile-Name1 IN FRAME fr_main
DO:
    fiFile-Name1 = TRIM(CAPS(INPUT fiFile-Name1)).

    DISPLAY fiFile-Name1 WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Nameinput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Nameinput C-Win
ON LEAVE OF fiFile-Nameinput IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiFile-Nameinput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Nameinput C-Win
ON RETURN OF fiFile-Nameinput IN FRAME fr_main
DO:
    fiFile-Nameinput = TRIM(CAPS(INPUT fiFile-Nameinput)).
    DISPLAY fiFile-Nameinput WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bindate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bindate C-Win
ON LEAVE OF fi_bindate IN FRAME fr_main
DO:
    fi_bindate = INPUT fi_bindate.

    DISPLAY fi_bindate WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_binloop
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_binloop C-Win
ON LEAVE OF fi_binloop IN FRAME fr_main
DO:
    fi_binloop = INPUT fi_binloop.

    DISPLAY fi_binloop WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_freeper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_freeper C-Win
ON LEAVE OF fi_freeper IN FRAME fr_main
DO:
  fi_freeper = INPUT fi_freeper.

  DISP fi_freeper WITH FRAM fr_main.

  gv_FreeFix = fi_freeper.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_grpstat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_grpstat C-Win
ON LEAVE OF fi_grpstat IN FRAME fr_main
DO:
  fi_grpstat = INPUT fi_grpstat.

  DISP fi_grpstat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rate C-Win
ON LEAVE OF fi_rate IN FRAME fr_main
DO:
    fi_rate = INPUT fi_rate.

    DISP fi_rate WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rate C-Win
ON RETURN OF fi_rate IN FRAME fr_main
DO:
    fiFile-Nameinput = TRIM(CAPS(INPUT fiFile-Nameinput)).
    DISPLAY fiFile-Nameinput WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trandatF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trandatF C-Win
ON LEAVE OF fi_trandatF IN FRAME fr_main
DO:
    fi_trandatF = INPUT fi_trandatF.

    DISPLAY fi_trandatF WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trandatT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trandatT C-Win
ON LEAVE OF fi_trandatT IN FRAME fr_main
DO:
    fi_trandatT = INPUT fi_trandatT.
    
    IF fi_trandatT <> ?  THEN DO:
        APPLY "ENTRY" TO fi_binloop IN FRAME fr_main.
        RETURN NO-APPLY.
    END.

    DISPLAY fi_trandatT WITH FRAME fr_main.

    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_filetype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_filetype C-Win
ON VALUE-CHANGED OF ra_filetype IN FRAME fr_main
DO:
    ra_filetype = INPUT   ra_filetype  .
    DISP ra_filetype WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_Free
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_Free C-Win
ON VALUE-CHANGED OF ra_Free IN FRAME fr_main
DO:
   ra_Free = INPUT ra_Free.
   DISP ra_Free WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME se_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL se_producer C-Win
ON VALUE-CHANGED OF se_producer IN FRAME fr_main
DO:
  IF (se_producer = ?) OR (se_producer = "")  THEN
      ASSIGN se_producer = "".
  IF vProdCod = ? THEN vProdCod = "".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_browse
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

    gv_prgid = "WACRAY6".
    gv_prog  = "Text File วางบิล บมจ.อยุธยา แคปปิตอล ออโต้ลีส (AYCAL)".

    RUN  WUT\WUTHEAD  (c-win:HANDLE,gv_prgid,gv_prog).
    RUN  WUT\WUTDICEN (c-win:HANDLE).
    /*********************************************************************/
    
    SESSION:DATA-ENTRY-RETURN = YES.
    SESSION:DATE-FORMAT  = "DMY".
    RECT-1:MOVE-TO-TOP( ).
    RECT-3:MOVE-TO-TOP( ).
    /*cbAsdat = vAcProc_fil.*/

    /*------------------------*/
    RUN pdAcproc_fil.

    n_asdat = DATE(cbAsdat).  /* A65-0021 Default ค่า กรณีไม่ได้เลือก As Date */
    /*------------------------*/
    ASSIGN
        fibranch      = "0"
        fibranch2     = "Z"
        n_branch      = fibranch
        n_branch2     = fibranch2
        fi_process    = ""
        fi_binloop    = 1
        fi_bindate    = DATE(MONTH(TODAY),DAY(TODAY),YEAR(TODAY))
        n_OutputFile1 = "" 
        fi_trandatF   = TODAY          
        fi_trandatT   = TODAY      

        fiFile-Name1  = "D:\TEMP\AYCAL" + 
                         STRING(DAY(TODAY),"99") +
                         STRING(MONTH(TODAY),"99") +
                         STRING(YEAR(TODAY),"9999")  
        tim01         = ""
        tim02         = "" 
        vProdCod      = ""
        ra_filetype   = 1
        se_producer   = ""
        ra_Free       = 1
        fi_grpstat    = "B3MLAY0100" /*A63-0391*/ /*"A0M0061"---A63-0391*/ 

        gv_FreeFix    = 22 .         /* A65-0021  Fix จาก main */

   fibdes  = fuFindBranch(fibranch).
   fibdes2 = fuFindBranch(fibranch2).

   RUN PD_UpdateQ.
   
  DISP fibranch   fibranch2  fibdes fibdes2  fi_trandatF fi_trandatT se_producer  ra_filetype fi_process fi_binloop fi_bindate fiFile-Name1 fi_grpstat WITH FRAME {&FRAME-NAME}.
   
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
  DISPLAY fiBranch fiBranch2 fi_grpstat fi_trandatF fi_trandatT fi_binloop 
          fi_bindate fiFile-Name1 ra_Free cbAsDat fibdes fiFile-Nameinput 
          ra_filetype fi_freeper se_producer fibdes2 fi_process fi_rate 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fiBranch fiBranch2 fi_grpstat fi_trandatF fi_trandatT fi_binloop 
         fi_bindate fiFile-Name1 br_browse ra_Free cbAsDat bu_add bu_del 
         bu_delall Btn_OK fibdes fiFile-Nameinput bu_file ra_filetype 
         Btn_conver fi_freeper se_producer Btn_Exit fibdes2 fi_process buBranch 
         buBranch2 bu_SplitFile fi_rate bu_Rate bu_help RECT-5 RECT-6 RECT-7 
         RECT-8 RECT-1 RECT-3 RECT-2 RECT-615 RECT-616 RECT-617 RECT-618 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcproc_fil C-Win 
PROCEDURE pdAcproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     pdAcproc_fil
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME {&FRAME-NAME} :
    vAcProc_fil = "" .
    FOR EACH Acproc_fil NO-LOCK WHERE
        (acproc_fil.type = "01" OR acproc_fil.type = "05" ) AND
        SUBSTR(acProc_fil.enttim,10,3) <>  "NO"
        BY acproc_fil.asdat DESC.
        vAcProc_fil = vAcProc_fil + STRING(AcProc_fil.asdat,"99/99/9999") + ",".
    END.
    ASSIGN
        cbAsDat:LIST-ITEMS = vAcProc_fil
        cbAsDat = ENTRY(1,vAcProc_fil).

    DISPLAY cbAsDat.
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_1SplitBigBike C-Win 
PROCEDURE PD_1SplitBigBike :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Tantawan Ch.  A65-0021  คำนวณค่า Free ตาม Table Parameter   
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

    OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1 + "_BigBike.CSV").
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill1
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo = gv_Key1
        AND Insure.InsTitle = gv_Key2 
        AND Insure.FName    = "1"  NO-LOCK.   /* 1.BigBike */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)" 
           "1" SKIP.
        OUTPUT CLOSE.

        ASSIGN
          nv_Acno    = Insure.LName                 /* Account No */
          nv_freeper = DECI(Insure.Addr1) NO-ERROR. /* Free Rate V70 */

        Loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
            AND   wBill4.wPolType = "V70" 
            BREAK BY wBill4.wPolicy :

            IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.

            DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
            ASSIGN
                n_wRecordno = n_wRecordno + 1 
                vExpCount1  = vExpCount1  + 1
                nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm. 
    
            wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
            PUT STREAM filebill1
                "D"                       FORMAT "X"               ","   /* 1  Record Type         */
                n_wRecordno               FORMAT "99999"           ","   /* 2  Sequence no.        */
                wBill4.wPolicy            FORMAT "x(20)"           ","   /* 3  INS. Policy No.     */               
                wBill4.wcovcod            FORMAT "x(2)"            ","   /* 4  insurance Type      */                
                wBill4.wtitle             FORMAT "x(10)"           ","   /* 5  Customer Title Name */              
                wBill4.wfirstname         FORMAT "x(25)"           ","   /* 6  Customer First Name */ 
                wBill4.wlastname          FORMAT "x(65)"           ","   /* 7  Customer Last Name  */               
                wBill4.wNor_Comdat        FORMAT "x(8)"            ","   /* 8  วันเริ่มคุ้มครอง    */               
                wBill4.wNor_Expdat        FORMAT "x(8)"            ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
                deci(wBill4.wsuminsurce)  FORMAT ">>>>>>>>9.99-"   ","  /* 10  Sum Insured         */
                deci(wBill4.wNetprm)      FORMAT ">>>>>>>>9.99-"   ","  /* 11  Net.INS.Prm         */
                deci(wBill4.wtotNetprm)   FORMAT ">>>>>>>>9.99-"   ","  /* 12  Total.INS.Prm       */
                wBill4.wChassis_no        FORMAT "x(30)"           ","  /* 13  Chassis No.         */
                wBill4.wEngine_no         FORMAT "x(30)"           ","  /* 14  Engine No.          */
                deci(nv_freeper)          FORMAT ">>>>>>>>9.99-"   ","  /* 15  ค่า Fee             */
                deci(wBill4.wFeeamount)   FORMAT ">>>>>>>>9.99-"   ","  /* 16  ค่า Fee amount      */
                deci(wBill4.wFee_orthe)   FORMAT ">>>>>>>>9.99-"   ","  /* 17  ค่าอนุโลม           */
                wBill4.wacno              FORMAT "X(10)"           ","  /* 18  Account No.         */ 
                wBill4.wBrand             FORMAT "X(50)"                /* 19  Brand               */ 
            SKIP.
            
            DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/
    
        END.      /* for each wBill4 */
    END.
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill1
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"        SKIP. 
    OUTPUT STREAM filebill1 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_2SplitISUZU C-Win 
PROCEDURE PD_2SplitISUZU :
/*------------------------------------------------------------------------------
  Purpose: Brand ISUZU ที่เป็น 70 ที่พ่วง 72 - 72 เดียวๆ ให้ Next   
  Parameters:  <none>
  Notes:   Tantawan Ch.  A65-0021  คำนวณค่า Free ตาม Table Parameter   
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

def VAR nv_SumInsurce  as deci init 0.
def VAR nv_NetPrm      as deci init 0.
def VAR nv_TotNetPrm   as deci init 0.
DEF VAR nv_pol1        AS CHAR init "".
DEF VAR nv_pol2        AS CHAR init "".
DEF VAR nv_pol3        AS CHAR INIT "".

    OUTPUT STREAM filebill2 TO VALUE(fiFile-Name1 + "_ISUZU.CSV").
    ASSIGN
        vExpCount1   = 0
        n_wRecordno  = 1
        nv_sumprem   = 0
        nv_NetPrm    = 0   
        nv_TotNetPrm = 0  
        n_binloop    = ""
        n_bindate    = ""
        n_binloop    = STRING(fi_binloop,"9")
        n_bindate    = STRING(fi_bindate,"99/99/9999")
        dateasof     = STRING(n_asdat)
        dateasof     = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill2
        "H"                                  FORMAT "X"       ","      /* 1.*/
        "00001"                              FORMAT "x(5)"    ","      /* 2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    OUTPUT TO D:\TEMP\WACRAY6_File2BeforGrpChassis.TXT.
       PUT "wAcno|Sticker|wPolicy|wPoltype|wcovcod|wtitle|wfirstname|wlastnamew|Nor_Comdat|wNor_Expdat|
            wSuminsurce|wNetprm|wtotNetprm|wChassis_no|wEngine_no|wModel|wFee|wFeeamount|wFee_orthe" 
       SKIP.
    OUTPUT CLOSE.
    
    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo   = gv_Key1
        AND   Insure.InsTitle = gv_Key2 
        AND   Insure.FName    = "2"  NO-LOCK.   /* 2.ISUZU   V70 + V72 */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)"
           "2" SKIP.
        OUTPUT CLOSE.

        ASSIGN
          nv_Acno    = Insure.LName                  /* Account No */
          nv_freeper = DECI(Insure.Addr1) NO-ERROR.  /* Free Rate V70 */

        loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
        BREAK BY wBill4.wChassis_no 
              BY wBill4.wPolType :

            IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
            
            DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
            
            IF INDEX(wBill4.wBrandModel,"ISUZU") = 0 THEN NEXT loop1.
            IF wBill4.wPolType = "V70" AND wBill4.wcovcod <> "1" THEN NEXT loop1. /* งาน 70 ที่ไม่ใช่ประเภท 1 ให้ Next */

            IF wBill4.wPolType = "V70" THEN 
                ASSIGN 
                  nv_pol1        = wBill4.wPolicy
                  nv_SumInsurce  = wBill4.wsuminsurce .  /* เก็บค่าทุนประกันล่าสุดของแต่ละกรมธรรม์ เฉพาะ กธ. 70 */
    
            IF FIRST-OF(wBill4.wChassis_no) THEN DO:
                ASSIGN
                  nv_NetPrm      = nv_NetPrm     +  wBill4.wNetprm
                  nv_TotNetPrm   = nv_TotNetPrm  +  wBill4.wtotNetprm
    
                  n_wRecordno = n_wRecordno + 1 
                  vExpCount1  = vExpCount1  + 1
                  nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
                nv_pol3 = wBill4.wPolicy. 
            END.
    
            OUTPUT TO D:\TEMP\WACRAY6_BeforGrpChassis.TXT APPEND.
              PUT wBill4.wAcno       "|"
                  wbill4.wSckno      "|"
                  wBill4.wPolicy     "|"
                  wBill4.wPoltype    "|"
                  wBill4.wcovcod     "|"
                  wBill4.wtitle      "|"
                  wBill4.wfirstname  "|"
                  wBill4.wlastname   "|"
                  wBill4.wNor_Comdat "|"
                  wBill4.wNor_Expdat "|"
                  wbill4.wsuminsurce "|"
                  wBill4.wNetprm     "|"
                  wBill4.wtotNetprm  "|"
                  wBill4.wChassis_no "|"
                  wBill4.wEngine_no  "|"
                  wBill4.wBrandModel "|"
                  wBill4.wFee        "|"
                  wBill4.wFeeamount  "|"
                  wBill4.wFee_orthe  "|"  SKIP.
            OUTPUT CLOSE.
    
            IF LAST-OF(wBill4.wChassis_no) THEN DO:  /* กรณีคีย์ 72 แยกจาก 70 ให้ใช้ Chassis Group เบี้ย */
    
                /* ถ้า กธ. 72 */
                IF wBill4.wPolType = "V72" THEN DO: 
    
                    IF nv_pol3 = wBill4.wPolicy THEN DO : /* กธ. 72 เดี่ยว ๆ ไม่มี กธ. 70 ให้เคลียร์ค่าออก และ Next record*/
                        ASSIGN
                            n_wRecordno  = n_wRecordno - 1 
                            vExpCount1   = vExpCount1  - 1 
                            nv_sumprem   = nv_sumprem  - wBill4.wtotNetprm
                            nv_NetPrm    = 0.
                            nv_TotNetPrm = 0.
                        NEXT loop1.
                    END.
                    ELSE DO: /* รวมเบี้ย 72 เข้าไปด้วย */
                        ASSIGN 
                          nv_sumprem   = nv_sumprem   + wBill4.wtotNetprm 
                          nv_NetPrm    = nv_NetPrm    + wBill4.wNetprm 
                          nv_TotNetPrm = nv_TotNetPrm + wBill4.wtotNetprm.
                    END.
                END.
    
                wBill4.wFeeamount   = (nv_NetPrm  * nv_freeper) / 100 .
                /* แสดงกรมธรรม์ 70 */
                IF wBill4.wPolType <> "V70" THEN nv_pol2 = nv_pol1 .
                                            ELSE nv_pol2 = wBill4.wPolicy. 
                PUT STREAM filebill2
                    "D"                     FORMAT "X"              ","  /* 1  Record Type         */
                    n_wRecordno             FORMAT "99999"          ","  /* 2  Sequence no.        */
                    nv_pol2                 FORMAT "x(20)"          ","  /* 3  INS. Policy No.     */               
                    "1"                     FORMAT "X"              ","  /* 4  fix ค่าเป็น 1 --- wBill4.wcovcod */
                    wBill4.wtitle           FORMAT "x(10)"          ","  /* 5  Customer Title Name */              
                    wBill4.wfirstname       FORMAT "x(25)"          ","  /* 6  Customer First Name */ 
                    wBill4.wlastname        FORMAT "x(65)"          ","  /* 7  Customer Last Name  */               
                    wBill4.wNor_Comdat      FORMAT "x(8)"           ","  /* 8  วันเริ่มคุ้มครอง    */               
                    wBill4.wNor_Expdat      FORMAT "x(8)"           ","  /* 9  วันสิ้นสุดคุ้มครอง  */               
                    deci(nv_suminsurce)     FORMAT ">>>>>>>>9.99-"  ","  /* 11 Sum Insured         */
                    deci(nv_Netprm)         FORMAT ">>>>>>>>9.99-"  ","  /* 12 Net.INS.Prm         */
                    deci(nv_totNetprm)      FORMAT ">>>>>>>>9.99-"  ","  /* 13 Total.INS.Prm       */
                    wBill4.wChassis_no      FORMAT "x(30)"          ","  /* 14 Chassis No.         */
                    wBill4.wEngine_no       FORMAT "x(30)"          ","  /* 15 Engine No.          */
                    deci(nv_freeper)        FORMAT ">>>>>>>>9.99-"  ","  /* 16 ค่า Fee             */
                    deci(wBill4.wFeeamount) FORMAT ">>>>>>>>9.99-"  ","  /* 17 ค่า Fee amount      */
                    deci(wBill4.wFee_orthe) FORMAT ">>>>>>>>9.99-"  ","  /* 18 ค่าอนุโลม           */
                    wBill4.wacno            FORMAT "X(10)"          ","  /* 19 Account No.         */
                    wBill4.wBrand           FORMAT "X(50)"          ","  /* 20 Brand               */
                    wBill4.wPolicy          FORMAT "x(20)"          ","  /* 21 Policy No. V72      */               
                    deci(wBill4.wNetprm)    FORMAT ">>>>>>>>9.99-"  ","  /* 22 Net.INS.Prm   V72   */  
                    deci(wBill4.wtotNetprm) FORMAT ">>>>>>>>9.99-"       /* 23 Total.INS.Prm V72   */  
                    SKIP.
    
                /* เก็บค่าแล้ว Clear ค่าเป็น 0*/
                ASSIGN
                    nv_SumInsurce  = 0
                    nv_NetPrm      = 0
                    nv_TotNetPrm   = 0.
    
                /* ถ้ามีกรมธรรม์ 72 คียแยกจาก 70 */
                IF nv_pol3 <> wBill4.wPolicy THEN DO:
                    FIND FIRST bwBill4 WHERE bwBill4.wChassis_no = wBill4.wChassis_no 
                                       AND   bwBill4.wPolType    = "V70" NO-ERROR.
                    IF AVAIL bwBill4 THEN DELETE bwBill4. /* Delete กรมธรรม์ 70 ออกจาก TEMP-TABLE */
                END.
                
                DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp -- Delete หลังจาก Delete V70 แล้ว */
    
            END.
        END.      /* for each wBill4 */
    END. 
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill2
    "T"                     FORMAT "X"      ","   /* 1.Title */
    n_wRecordno             FORMAT "99999"  ","   /* 2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","   /* 3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_3SplitBay70 C-Win 
PROCEDURE PD_3SplitBay70 :
/*------------------------------------------------------------------------------
  Purpose: เฉพาะงาน 70     
  Parameters:  <none>
  Notes: Tantawan Ch.  A65-0021  คำนวณค่า Free ตาม Table Parameter         
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

    OUTPUT STREAM filebill3 TO VALUE(fiFile-Name1 + "_BayV70.CSV").
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = STRING(DECI(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill3
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo = gv_Key1
        AND Insure.InsTitle = gv_Key2 
        AND Insure.FName    = "3"  NO-LOCK.   /* 3.Bay70 */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)"
           "3" SKIP.
        OUTPUT CLOSE.

        ASSIGN
          nv_Acno    = Insure.LName.                /* Account No */
          nv_freeper = DECI(Insure.Addr1) NO-ERROR. /* Free Rate V70 */

        Loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
            AND   wBill4.wPolType = "V70" 

            BREAK BY wBill4.wPolicy :

                 IF wBill4.wcovcod = "1" THEN nv_freeper = DECI(Insure.Addr1) NO-ERROR.
            ELSE IF wBill4.wcovcod = "2" THEN nv_freeper = DECI(Insure.Addr2) NO-ERROR.
            ELSE IF wBill4.wcovcod = "3" THEN nv_freeper = DECI(Insure.Addr3) NO-ERROR.
                                         
            IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
        
            DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
            ASSIGN
                n_wRecordno = n_wRecordno + 1 
                vExpCount1  = vExpCount1  + 1
                nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
            wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
            PUT STREAM filebill3
              "D"                      FORMAT "X"             ","  /* 1  Record Type         */ 
              n_wRecordno              FORMAT "99999"         ","  /* 2  Sequence no.        */ 
              wBill4.wPolicy           FORMAT "x(20)"         ","  /* 3  INS. Policy No.     */               
              wBill4.wcovcod           FORMAT "x(2)"          ","  /* 4  insurance Type      */                
              wBill4.wtitle            FORMAT "x(10)"         ","  /* 5  Customer Title Name */              
              wBill4.wfirstname        FORMAT "x(25)"         ","  /* 6  Customer First Name */ 
              wBill4.wlastname         FORMAT "x(65)"         ","  /* 7  Customer Last Name  */               
              wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /* 8  วันเริ่มคุ้มครอง    */               
              wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /* 9  วันสิ้นสุดคุ้มครอง  */               
              deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 10  Sum Insured        */ 
              deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 11  Net.INS.Prm        */ 
              deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 12  Total.INS.Prm      */ 
              wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 13  Chassis No.        */ 
              wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 14  Engine No.         */ 
              deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่า Fee            */ 
              deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee amount     */ 
              deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่าอนุโลม          */ 
              wBill4.wacno             FORMAT "X(10)"         ","  /* 18  Account No.        */ 
              wBill4.wBrand            FORMAT "X(50)"              /* 19  Brand              */ 
            SKIP.
            
            DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/
    
        END.      /* for each wBill4 */
    END.
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill3
      "T"                         FORMAT "X"      ","   /*  1.*/
      n_wRecordno                 FORMAT "99999"  ","   /*  2.Last sequence no.*/
      (n_wRecordno - 2 )          FORMAT "99999"  ","   /*  3.ผลรวมจำนวนกรมธรรม์*/
      fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
      SKIP. 
    OUTPUT STREAM filebill3 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_4SplitBay72 C-Win 
PROCEDURE PD_4SplitBay72 :
/*------------------------------------------------------------------------------
  Purpose:  เฉพาะงาน 72    
  Parameters:  <none>
  Notes: Tantawan Ch.  A65-0021  คำนวณค่า Free ตาม Table Parameter         
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

    OUTPUT STREAM filebill4 TO VALUE(fiFile-Name1 + "_BayV72.CSV").
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill4
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "2"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo = gv_Key1
        AND Insure.InsTitle = gv_Key2 
        AND Insure.FName    = "4"  NO-LOCK.   /* 4.Bay72 */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)"
           "4" SKIP.
        OUTPUT CLOSE.

        ASSIGN
          nv_Acno    = Insure.LName                  /* Account No */
          nv_freeper = DECI(Insure.Addr4) NO-ERROR.  /* Free Rate V72 */

        Loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
            AND   wBill4.wPolType = "V72" 
            BREAK BY wBill4.wPolicy :

            IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
        
            DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
            ASSIGN
                n_wRecordno = n_wRecordno + 1 
                vExpCount1  = vExpCount1  + 1
                nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
            wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
            PUT STREAM filebill4
                "D"                      FORMAT "X"             ","  /* 1  Record Type          */
                n_wRecordno              FORMAT "99999"         ","  /* 2  Sequence no.         */
                wBill4.wSckno            FORMAT "x(20)"         ","  /* 3  INS. Policy No.      */        
                wBill4.wtitle            FORMAT "x(10)"         ","  /* 4  Customer Title Name  */       
                wBill4.wfirstname        FORMAT "x(25)"         ","  /* 5  Customer First Name  */
                wBill4.wlastname         FORMAT "x(65)"         ","  /* 6  Customer Last Name   */        
                wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /* 7  วันเริ่มคุ้มครอง     */        
                wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /* 8  วันสิ้นสุดคุ้มครอง   */        
                deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 9   Net.INS.Prm         */
                deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 10  Total.INS.Prm       */
                wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 11  Chassis No.         */
                wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 12  Engine No.          */
                deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 13  ค่า Fee             */
                deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 14  ค่า Fee amount      */
                deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่าอนุโลม           */
                wBill4.wPolicy           FORMAT "x(20)"         ","  /* 16  INS. Policy No.     */        
                wBill4.wacno             FORMAT "X(10)"         ","  /* 17  Account No.         */ 
                wBill4.wBrand            FORMAT "X(50)"              /* 18  Brand               */ 
                SKIP.
    
            DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/
    
        END.      /* for each wBill4 */
    END.
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill4
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill4 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_5SplitAY72 C-Win 
PROCEDURE PD_5SplitAY72 :
/*------------------------------------------------------------------------------
  Purpose:  V72 แถม   
  Parameters:  <none>
  Notes: Tantawan Ch.  A65-0021  คำนวณค่า Free ตาม Table Parameter        
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

    OUTPUT STREAM filebill5 TO VALUE(fiFile-Name1 + "_AYCAL72.CSV"). 
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill5
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "2"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo = gv_Key1
        AND Insure.InsTitle = gv_Key2 
        AND Insure.FName    = "5"  NO-LOCK.   /* 5.AYCAL72 */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)"
           "5" SKIP.
        OUTPUT CLOSE.
    
        ASSIGN
          nv_Acno    = Insure.LName                 /* Account No */
          nv_freeper = DECI(Insure.Addr4) NO-ERROR. /* Free Rate V72 */

        Loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
            AND   wBill4.wPolType = "V72" 
            BREAK BY wBill4.wPolicy :

            /*-----------------------------*/
            FIND LAST uwm100 WHERE uwm100.policy = TRIM(wBill4.wPolicy) 
                             AND   uwm100.releas = YES NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN DO:

                IF INDEX(uwm100.name2,"และ/หรือ") <> 0 THEN NEXT loop1.   /* ถ้ามี และ/หรือ จะเป็นแบบ แถม ให้ Next */
                
            END.
            /*-----------------------------*/

            IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
    
            DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
            ASSIGN
                n_wRecordno = n_wRecordno + 1 
                vExpCount1  = vExpCount1  + 1
                nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
            wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
            PUT STREAM filebill5
                "D"                      FORMAT "X"             ","  /* 1  Record Type          */
                n_wRecordno              FORMAT "99999"         ","  /* 2  Sequence no.         */
                wBill4.wSckno            FORMAT "x(20)"         ","  /* 3  INS. Policy No.      */             
                wBill4.wtitle            FORMAT "x(10)"         ","  /* 4  Customer Title Name  */            
                wBill4.wfirstname        FORMAT "x(25)"         ","  /* 5  Customer First Name  */
                wBill4.wlastname         FORMAT "x(65)"         ","  /* 6  Customer Last Name   */             
                wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /* 7  วันเริ่มคุ้มครอง     */             
                wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /* 8  วันสิ้นสุดคุ้มครอง   */             
                deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 9   Net.INS.Prm         */
                deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 10  Total.INS.Prm       */
                wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 11  Chassis No.         */
                wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 12  Engine No.          */
                deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 13  ค่า Fee             */
                deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 14  ค่า Fee amount      */
                deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่าอนุโลม           */
                wBill4.wPolicy           FORMAT "x(20)"         ","  /* 16  INS. Policy No.     */             
                wBill4.wacno             FORMAT "X(10)"         ","  /* 17 Account No.         */ 
                wBill4.wBrand            FORMAT "X(50)"              /* 18 Brand               */ 
            SKIP.

            DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/

        END.      /* for each wBill4 */
    END.
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill5
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill5 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_6SplitAY72Fee C-Win 
PROCEDURE PD_6SplitAY72Fee :
/*------------------------------------------------------------------------------
  Purpose:  V72 แถม   
  Parameters:  <none>
  Notes: Tantawan Ch.  A65-0021  คำนวณค่า Free ตาม Table Parameter        
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

    OUTPUT STREAM filebill6 TO VALUE(fiFile-Name1 + "_AYCAL72Fee.CSV"). /*ต่ออายุปกติ V72*/
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill6
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "2"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo = gv_Key1
        AND Insure.InsTitle = gv_Key2 
        AND Insure.FName    = "6"  NO-LOCK.   /* 6.AYCAL72Fee   และ/หรือ */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)"
           "6" SKIP.
        OUTPUT CLOSE.
    
        ASSIGN
          nv_Acno    = Insure.LName                 /* Account No */
          nv_freeper = DECI(Insure.Addr4) NO-ERROR. /* Free Rate V72 */

        Loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
            AND   wBill4.wPolType = "V72" 
            BREAK BY wBill4.wPolicy :

            /*-----------------------------*/
            FIND LAST uwm100 WHERE uwm100.policy = TRIM(wBill4.wPolicy) 
                             AND   uwm100.releas = YES NO-LOCK NO-ERROR.
            IF AVAIL uwm100 THEN DO:

                IF INDEX(uwm100.name2,"และ/หรือ") = 0 THEN NEXT loop1.   /* แบบแถม ถ้าไม่มี และ/หรือ ให้ Next */
                
            END.
            /*-----------------------------*/

            IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
    
            DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
            ASSIGN
                n_wRecordno = n_wRecordno + 1 
                vExpCount1  = vExpCount1  + 1
                nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
            wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
            PUT STREAM filebill6
                "D"                      FORMAT "X"             ","  /* 1  Record Type          */
                n_wRecordno              FORMAT "99999"         ","  /* 2  Sequence no.         */
                wBill4.wSckno            FORMAT "x(20)"         ","  /* 3  INS. Policy No.      */               
                wBill4.wtitle            FORMAT "x(10)"         ","  /* 4  Customer Title Name  */              
                wBill4.wfirstname        FORMAT "x(25)"         ","  /* 5  Customer First Name  */ 
                wBill4.wlastname         FORMAT "x(65)"         ","  /* 6  Customer Last Name   */               
                wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /* 7  วันเริ่มคุ้มครอง     */               
                wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /* 8  วันสิ้นสุดคุ้มครอง   */               
                deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 9   Net.INS.Prm         */
                deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 10  Total.INS.Prm       */
                wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 11  Chassis No.         */
                wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 12  Engine No.          */
                deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 13  ค่า Fee             */
                deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 14  ค่า Fee amount      */
                deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่าอนุโลม           */
                wBill4.wPolicy           FORMAT "x(20)"         ","  /* 16  INS. Policy No.     */               
                wBill4.wacno             FORMAT "X(10)"         ","  /* 17 Account No.          */ 
                wBill4.wBrand            FORMAT "X(50)"              /* 18 Brand                */ 
            SKIP.
    
            DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/
    
        END.      /* for each wBill4 */
    END.
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill6
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill6 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_7SplitRenew70 C-Win 
PROCEDURE PD_7SplitRenew70 :
/*------------------------------------------------------------------------------
  Purpose: Renew V70    
  Parameters:  <none>
  Notes: Tantawan Ch.  A65-0021  คำนวณค่า Free ตาม Table Parameter                
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

    OUTPUT STREAM filebill7 TO VALUE(fiFile-Name1 + "_RenewV70.CSV"). /* ต่ออายุ V70 */
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = STRING(DECI(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill7
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo = gv_Key1
        AND Insure.InsTitle = gv_Key2 
        AND Insure.FName    = "7"  NO-LOCK.   /* 7.Renew 70 */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)"
           "7" SKIP.
        OUTPUT CLOSE.

        ASSIGN
          nv_Acno    = Insure.LName                 /* Account No */
          nv_freeper = DECI(Insure.Addr1) NO-ERROR. /* Free Rate V70 */
    
        Loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
            AND   wBill4.wPolType = "V70" 
        BREAK BY wBill4.wPolicy :

            IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
        
            DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
            ASSIGN
                n_wRecordno = n_wRecordno + 1 
                vExpCount1  = vExpCount1  + 1
                nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
            wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
            PUT STREAM filebill7
                "D"                      FORMAT "X"              ","  /* 1  Record Type         */      
                n_wRecordno              FORMAT "99999"          ","  /* 2  Sequence no.        */ 
                wBill4.wPolicy           FORMAT "x(20)"          ","  /* 3  INS. Policy No.     */               
                wBill4.wcovcod           FORMAT "x(2)"           ","  /* 4  insurance Type      */                
                wBill4.wtitle            FORMAT "x(10)"          ","  /* 5  Customer Title Name */              
                wBill4.wfirstname        FORMAT "x(25)"          ","  /* 6  Customer First Name */ 
                wBill4.wlastname         FORMAT "x(65)"          ","  /* 7  Customer Last Name  */               
                wBill4.wNor_Comdat       FORMAT "x(8)"           ","  /* 8  วันเริ่มคุ้มครอง    */               
                wBill4.wNor_Expdat       FORMAT "x(8)"           ","  /* 9  วันสิ้นสุดคุ้มครอง  */               
                deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-"  ","  /* 10  Sum Insured        */ 
                deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-"  ","  /* 11  Net.INS.Prm        */ 
                deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-"  ","  /* 12  Total.INS.Prm      */ 
                wBill4.wChassis_no       FORMAT "x(30)"          ","  /* 13  Chassis No.        */ 
                wBill4.wEngine_no        FORMAT "x(30)"          ","  /* 14  Engine No.         */ 
                deci(nv_freeper)         FORMAT ">>>>>>>>9.99-"  ","  /* 15  ค่า Fee            */ 
                deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-"  ","  /* 16  ค่า Fee amount     */ 
                deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-"  ","  /* 17  ค่าอนุโลม          */ 
                wBill4.wacno             FORMAT "X(10)"          ","  /* 18 Account No.         */ 
                wBill4.wBrand            FORMAT "X(50)"               /* 19 Brand               */ 
            SKIP.
    
            DELETE wBill4.  /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        END.
    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill7
    "T"                         FORMAT "X"      ","    /*  1.*/
    n_wRecordno                 FORMAT "99999"  ","    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  ","   /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 
    OUTPUT STREAM filebill7 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_8SplitInstall70 C-Win 
PROCEDURE PD_8SplitInstall70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A65-0021  คำนวณค่า Free ตาม Table Parameter       
------------------------------------------------------------------------------*/
DEF VAR nv_acno AS CHAR.

    OUTPUT STREAM filebill8 TO VALUE(fiFile-Name1 + "_InstallV70.CSV"). /*ป้ายแดงปกติ V70*/
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = STRING(DECI(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill8
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    FOR EACH Insure USE-INDEX Insure01
        WHERE Insure.CompNo = gv_Key1
        AND Insure.InsTitle = gv_Key2 
        AND Insure.FName    = "8"  NO-LOCK.   /* 8.Install-70    เดิม RedLabel */

        OUTPUT TO D:\TEMP\WACRAY6-FreeRate.txt APPEND.
        PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") ". "
           Insure.CompNo        FORMAT "X(10)"
           Insure.InsTitle      FORMAT "X(5)"
           Insure.FName         FORMAT "X(5)"
           Insure.LName         FORMAT "X(15)"
           Insure.Addr1         FORMAT "X(5)"
           Insure.Addr2         FORMAT "X(5)"
           Insure.Addr3         FORMAT "X(5)"
           Insure.Addr4         FORMAT "X(5)"
           STRING(Insure.UDate) FORMAT "X(15)"
           "8" SKIP.
        OUTPUT CLOSE.
    
        ASSIGN
          nv_Acno    = Insure.LName                 /* Account No */
          nv_freeper = DECI(Insure.Addr1) NO-ERROR. /* Free Rate V70 */

        Loop1:
        FOR EACH wBill4 USE-INDEX wBill403 
            WHERE wBill4.wAcno    = nv_acno  
            AND   wBill4.wPolType = "V70" 
            BREAK BY wBill4.wPolicy :

           IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
    
           DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
           ASSIGN
             n_wRecordno = n_wRecordno + 1 
             vExpCount1  = vExpCount1  + 1
             nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
           wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
           PUT STREAM filebill8
             "D"                      FORMAT "X"             ","  /* 1  Record Type         */       
             n_wRecordno              FORMAT "99999"         ","  /* 2  Sequence no.        */ 
             wBill4.wPolicy           FORMAT "x(20)"         ","  /* 3  INS. Policy No.     */                
             wBill4.wcovcod           FORMAT "x(2)"          ","  /* 4  insurance Type      */                 
             wBill4.wtitle            FORMAT "x(10)"         ","  /* 5  Customer Title Name */               
             wBill4.wfirstname        FORMAT "x(25)"         ","  /* 6  Customer First Name */  
             wBill4.wlastname         FORMAT "x(65)"         ","  /* 7  Customer Last Name  */                
             wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /* 8  วันเริ่มคุ้มครอง    */                
             wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /* 9  วันสิ้นสุดคุ้มครอง  */                
             deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 10  Sum Insured        */ 
             deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 11  Net.INS.Prm        */ 
             deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 12  Total.INS.Prm      */ 
             wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 13  Chassis No.        */ 
             wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 14  Engine No.         */ 
             deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่า Fee            */ 
             deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee amount     */ 
             deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่าอนุโลม          */ 
             wBill4.wacno             FORMAT "X(10)"         ","  /* 18 Account No.         */ 
             wBill4.wBrand            FORMAT "X(50)"              /* 19 Brand               */ 
           SKIP.
    
           DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/
    
        END.      /* for each wBill4 */
    END.
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill8
    "T"                         FORMAT "X"      ","    /*  1.*/
    n_wRecordno                 FORMAT "99999"  ","    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  ","   /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 
    OUTPUT STREAM filebill8 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_90Oth70 C-Win 
PROCEDURE PD_90Oth70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Tantawan Ch.  A65-0021  กรมธรรม์ 70 ที่เหลือจาก Group 1-8 คำนวณค่า Free Fix   
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill9 TO VALUE(fiFile-Name1 + "_Other70.CSV").
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill9
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 


    loop1:
    FOR EACH wBill4 USE-INDEX wBill403 
        WHERE wBill4.wPolType = "V70"   /* ทุกรายการที่เป็น 70 */
        BREAK BY wBill4.wPolicy :

        IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.

        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm. 
    
        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
        PUT STREAM filebill9
            "D"                       FORMAT "X"               ","   /* 1  Record Type         */
            n_wRecordno               FORMAT "99999"           ","   /* 2  Sequence no.        */
            wBill4.wPolicy            FORMAT "x(20)"           ","   /* 3  INS. Policy No.     */               
            wBill4.wcovcod            FORMAT "x(2)"            ","   /* 4  insurance Type      */                
            wBill4.wtitle             FORMAT "x(10)"           ","   /* 5  Customer Title Name */              
            wBill4.wfirstname         FORMAT "x(25)"           ","   /* 6  Customer First Name */ 
            wBill4.wlastname          FORMAT "x(65)"           ","   /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat        FORMAT "x(8)"            ","   /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat        FORMAT "x(8)"            ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wsuminsurce)  FORMAT ">>>>>>>>9.99-"   ","  /* 10  Sum Insured         */
            deci(wBill4.wNetprm)      FORMAT ">>>>>>>>9.99-"   ","  /* 11  Net.INS.Prm         */
            deci(wBill4.wtotNetprm)   FORMAT ">>>>>>>>9.99-"   ","  /* 12  Total.INS.Prm       */
            wBill4.wChassis_no        FORMAT "x(30)"           ","  /* 13  Chassis No.         */
            wBill4.wEngine_no         FORMAT "x(30)"           ","  /* 14  Engine No.          */
            deci(nv_freeper)          FORMAT ">>>>>>>>9.99-"   ","  /* 15  ค่า Fee             */
            deci(wBill4.wFeeamount)   FORMAT ">>>>>>>>9.99-"   ","  /* 16  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)   FORMAT ">>>>>>>>9.99-"   ","  /* 17  ค่าอนุโลม           */
            wBill4.wacno              FORMAT "X(10)"           ","  /* 18 Account No.          */
            wBill4.wBrand             FORMAT "X(50)"                /* 19 Brand                */
        SKIP.
        
        DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/
    
    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill9
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"        SKIP. 
    OUTPUT STREAM filebill9 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_91Oth72 C-Win 
PROCEDURE PD_91Oth72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Tantawan Ch.  A65-0021  กรมธรรม์ 70 ที่เหลือจาก Group 1-8 คำนวณค่า Free Fix   
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill10 TO VALUE(fiFile-Name1 + "_Other72.CSV").
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    PUT STREAM filebill10
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "2"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill403 
        WHERE wBill4.wPolType = "V72" 
        BREAK BY wBill4.wPolicy :

        IF nv_freeper <= 0 THEN nv_freeper = gv_FreeFix.
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 
    
        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .
    
        PUT STREAM filebill10
            "D"                      FORMAT "X"             ","  /* 1  Record Type          */
            n_wRecordno              FORMAT "99999"         ","  /* 2  Sequence no.         */
            wBill4.wSckno            FORMAT "x(20)"         ","  /* 3  INS. Policy No.      */            
            wBill4.wtitle            FORMAT "x(10)"         ","  /* 4  Customer Title Name  */           
            wBill4.wfirstname        FORMAT "x(25)"         ","  /* 5  Customer First Name  */
            wBill4.wlastname         FORMAT "x(65)"         ","  /* 6  Customer Last Name   */            
            wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /* 7  วันเริ่มคุ้มครอง     */            
            wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /* 8  วันสิ้นสุดคุ้มครอง   */            
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 9   Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 10  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 11  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 12  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 13  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 14  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่าอนุโลม           */
            wBill4.wPolicy           FORMAT "x(20)"         ","  /* 16  INS. Policy No.     */            
            wBill4.wacno             FORMAT "X(10)"         ","  /* 17 Account No.         */ 
            wBill4.wBrand            FORMAT "X(50)"              /* 18 Brand               */ 
            SKIP.
    
        DELETE wBill4. /* put data แล้ว delete ข้อมูลออกจาก Temp*/
    
    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill10
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill10 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_GrpByPolicyNo C-Win 
PROCEDURE PD_GrpByPolicyNo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Group Data by Policy No.
------------------------------------------------------------------------------*/
def var nv_SumInsurce  as deci.
def var nv_NetPrm      as deci.
def var nv_TotNetPrm   as deci.
def var nv_Tbal        as deci.


    OUTPUT TO D:\TEMP\WACRAY6_GrpPolicy.TXT .
    PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS")             SKIP
        "wAcno|wEndno|nv_sckno|wPolicy|wPoltype|wcovcod|wTrnTy|wDocno|wtitle|wfirstname|wlastname|wNor_Comdat|wNor_Expdat|
         wSuminsurce|wNetprm|wtotNetprm|wChassis_no|wEngine_no|wModel|wFee|wFeeamount|wFee_orthe|bal" 
    SKIP.
    OUTPUT CLOSE.


    FOR EACH wBill USE-INDEX  wBill05 NO-LOCK 
        BREAK BY wBill.wPolicy BY wBill.wEndno.

        nv_SumInsurce  = wBill.wsuminsurce .  /* เก็บค่าทุนประกันล่าสุดของแต่ละกรมธรรม์ */
        nv_Tbal        = nv_Tbal       +  wBill.wBal .
        nv_NetPrm      = nv_NetPrm     +  wBill.wNetprm    .
        nv_TotNetPrm   = nv_TotNetPrm  +  wBill.wtotNetprm .

        IF LAST-OF(wBill.wPolicy) THEN DO:

            IF nv_NetPrm <= 0 THEN DO: 

                OUTPUT TO D:\TEMP\WACRAY6_GrpPolicy.TXT APPEND.
                PUT wBill.wAcno       "|"
                    wBill.wEndno      "|"
                    wbill.nv_sckno    "|"
                    wBill.wPolicy     "|"
                    wBill.wPoltype    "|"
                    wBill.wcovcod     "|"
                    wBill.wtrnty1 + wBill.wtrnty2 "|"
                    wBill.wDocno      "|"
                    wBill.wtitle      "|"
                    wBill.wfirstname  "|"
                    wBill.wlastname   "|"
                    wBill.wNor_Comdat "|"
                    wBill.wNor_Expdat "|"
                    wbill.wsuminsurce "|"
                    wBill.wNetprm     "|"
                    wBill.wtotNetprm  "|"
                    wBill.wChassis_no "|"
                    "Prem000"  SKIP.
                OUTPUT CLOSE.

                /* ก่อน Next record ให้ Clear ค่า */
                ASSIGN
                    nv_SumInsurce  = 0
                    nv_NetPrm      = 0
                    nv_TotNetPrm   = 0
                    nv_TBal        = 0.

                NEXT.  /* ถ้าเบี้ยน้อยกว่าหรือเท่ากับ 0  ไม่ต้องออกใน Statement */
            END.

            FIND LAST wBill3 USE-INDEX wBill301 
                 WHERE wBill3.wAcno    = wBill.wAcno  
                 AND   wBill3.wPolicy  = wBill.wPolicy
                 AND   wBill3.wEndno   = wBill.wEndno 
                 AND   wBill3.wtrnty1  = wBill.wtrnty1
                 AND   wBill3.wtrnty2  = wBill.wtrnty2
                 AND   wBill3.wdocno   = wBill.wdocno   NO-LOCK NO-ERROR.
            IF NOT AVAIL wBill3 THEN DO:
                CREATE wBill3.
                ASSIGN
                   wBill3.wacno       =  wBill.wacno
                   wBill3.wdocno      =  wBill.wdocno 
                   wBill3.wtrnty1     =  wBill.wtrnty1
                   wBill3.wtrnty2     =  wBill.wtrnty2
                   wBill3.wEndno      =  wBill.wEndno      
                   wbill3.nv_sckno    =  wbill.nv_sckno    
                   wBill3.wPolicy     =  wBill.wPolicy     
                   wBill3.wPoltype    =  wBill.wPoltype    
                   wBill3.wcovcod     =  wBill.wcovcod     
                   wBill3.wtitle      =  wBill.wtitle      
                   wBill3.wfirstname  =  wBill.wfirstname  
                   wBill3.wlastname   =  wBill.wlastname   
                   wBill3.wNor_Comdat =  wBill.wNor_Comdat 
                   wBill3.wNor_Expdat =  wBill.wNor_Expdat 
                   wBill3.wsuminsurce =  nv_SumInsurce      /* wBill.wsuminsurce*/ 
                   wBill3.wNetprm     =  nv_NetPrm          /* wBill.wNetprm    */ 
                   wBill3.wtotNetprm  =  nv_TotNetPrm       /* wBill.wtotNetprm */ 
                   wBill3.wChassis_no =  wBill.wChassis_no 
                   wBill3.wEngine_no  =  wBill.wEngine_no  
                   wBill3.wBrandModel =  wBill.wBrandModel
                   wBill3.wFee        =  wBill.wFee        
                   wBill3.wFee_orthe  =  wBill.wFee_orthe
                   wBill3.wBal        =  nv_Tbal           /* wBill.wbal    */  .

                OUTPUT TO D:\TEMP\WACRAY6_GrpPolicy.TXT APPEND.
                PUT 
                  wBill3.wAcno       "|"
                  wBill3.wEndno      "|"
                  wbill3.nv_sckno    "|"
                  wBill3.wPolicy     "|"
                  wBill3.wPoltype    "|"
                  wBill3.wcovcod     "|"
                  wBill3.wtrnty1 + wBill.wtrnty2 "|"
                  wBill3.wDocno      "|"
                  wBill3.wtitle      "|"
                  wBill3.wfirstname  "|"
                  wBill3.wlastname   "|"
                  wBill3.wNor_Comdat "|"
                  wBill3.wNor_Expdat "|"
                  wbill3.wsuminsurce "|"
                  wBill3.wNetprm     "|"
                  wBill3.wtotNetprm  "|"
                  wBill3.wChassis_no "|"
                  wBill3.wEngine_no  "|"
                  wBill3.wBrandModel "|"
                  wBill3.wFee        "|"
                  wBill3.wFeeamount  "|"
                  wBill3.wFee_orthe  "|"
                  wBill3.wBal        "|"
                SKIP.
                OUTPUT CLOSE.

            END.
            /* เก็บค่าแล้ว Clear ค่าเป็น 0*/
            ASSIGN
                nv_SumInsurce  = 0
                nv_NetPrm      = 0
                nv_TotNetPrm   = 0
                nv_TBal        = 0.
        END.
    END.  /* find first wBill */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_ImportCSV C-Win 
PROCEDURE PD_ImportCSV :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cnt = 0.

    FOR EACH wBill4. DELETE wBill4. END. 

    INPUT FROM VALUE (fiFile-Nameinput) .                                   
    REPEAT: 
        IMPORT DELIMITER ","
            nv_RecordType                           
            nv_Sequenceno            
            nv_INS_PolicyNo  
            nv_poltype
            nv_InsureSticker
            nv_InsureCover
            nv_CustomerTitleName   
            nv_CustomerFirstNAME 
            nv_CustomerLastName     
            nv_comdate               
            nv_expdate               
            nv_SumInsured        
            nv_NetINSPrm         
            nv_TotalINSPrm       
            nv_ChassisNo         
            nv_EngineNo          
            nv_Fee               
            nv_Feeamount         
            nv_fee01
            nv_acno
            nv_bal
            nv_Brand .  

        IF TRIM(nv_RecordType) = "D"  THEN DO:

          nv_cnt = nv_cnt + 1.

          CREATE wBill4.
          ASSIGN 
              wBill4.wrecordtyp   = TRIM(nv_RecordType)          /* 1   Record Type         */ 
              wBill4.wsequenceno  = TRIM(nv_Sequenceno)          /* 2   Sequence no.        */ 
              wBill4.wPolicy      = TRIM(nv_INS_PolicyNo)        /* 3   INS. Policy No.     */ 
              wBill4.wPolType     = TRIM(nv_poltype)
              /*wBill4.wPolType     = "V" + SUBSTRING(TRIM(nv_INS_PolicyNo),3,2)*/
              wBill4.wSckno       = TRIM(nv_InsureSticker)       /* 4   Sticker No.         */ 
              wBill4.wcovcod      = TRIM(nv_insureCover)         /* 5   Cover Type          */ 
              wBill4.wtitle       = TRIM(nv_CustomerTitleName)   /* 6   Customer Title Name */ 
              wBill4.wfirstname   = TRIM(nv_CustomerFirstNAME)   /* 7   Customer First Name */ 
              wBill4.wlastname    = TRIM(nv_CustomerLastName)    /* 8   Customer Last Name  */ 
              wBill4.wNor_Comdat  = TRIM(nv_comdate)             /* 9   วันเริ่มคุ้มครอง    */ 
              wBill4.wNor_Expdat  = TRIM(nv_expdate)             /* 10  วันสิ้นสุดคุ้มครอง  */ 
              wBill4.wsuminsurce  = deci(nv_SumInsured)          /* 11  Sum Insured         */ 
              wBill4.wNetprm      = deci(nv_NetINSPrm)           /* 12  Net.INS.Prm         */ 
              wBill4.wtotNetprm   = deci(nv_TotalINSPrm)         /* 13  Total.INS.Prm       */ 
              wBill4.wChassis_no  = TRIM(nv_ChassisNo)           /* 14  Chassis No.         */ 
              wBill4.wEngine_no   = TRIM(nv_EngineNo)            /* 15  Engine No.          */ 
              wBill4.wFee         = deci(nv_Fee)                 /* 16  ค่า Fee             */ 
              wBill4.wFeeamount   = deci(nv_Feeamount)           /* 17  ค่า Fee amount      */ 
              wBill4.wFee_orthe   = deci(nv_fee01)               /* 18  ค่าอนุโลม           */ 
              wBill4.wAcno        = TRIM(nv_acno)                /* 19  Account No.         */ 
              wBill4.wBrandModel  = TRIM(nv_Brand)               /* 20  Model Description   */                                
              wBill4.wBal         = deci(nv_bal).
        END.                                                    
        ELSE NEXT .


        RUN proc_init.

    END.  /* repeat  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Proc C-Win 
PROCEDURE PD_Proc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_balos AS DECI .

FOR EACH wBill:     DELETE wBill.   END.

ASSIGN vCountRec    = 0 
       nv_reccnt    = 0. 


OUTPUT TO D:\TEMP\WACRAY6.TXT .
PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS")             SKIP
    "wAcno|wEndno|nv_sckno|wPolicy|wPoltype|wcovcod|wTrnTy|wDocno|wtitle|wfirstname|wlastname|wNor_Comdat|wNor_Expdat|
     wSuminsurce|wNetprm|wtotNetprm|wChassis_no|wEngine_no|wModel|wFee|wFeeamount|wFee_orthe" 
SKIP.
OUTPUT CLOSE.

LOOP_MAIN:  
FOR EACH Agtprm_fil USE-INDEX by_acno          WHERE  
         Agtprm_fil.asdat          =  n_asdat    AND 
  LOOKUP(Agtprm_fil.acno,vProdCod) <> 0          AND    
        (Agtprm_fil.poltyp         =  "V70"      OR  Agtprm_fil.poltyp  =      "V72" )    AND 
        (Agtprm_fil.TYPE           =  "01"       OR  Agtprm_fil.TYPE    =      "05"  )    AND 
        (Agtprm_fil.trntyp BEGINS 'M'            OR  Agtprm_fil.trntyp  BEGINS 'R'   )    AND 
        (Agtprm_fil.polbran       >=  n_branch   AND Agtprm_fil.polbran <=     n_branch2) AND 
        /* Agtprm_fil.bal           >   0       */
         Agtprm_fil.bal         <>  0          /* ทั้งเบี้ย + และ - */
NO-LOCK: 

    IF      Agtprm_fil.trndat    <  fi_trandatF THEN NEXT. 
    ELSE IF Agtprm_fil.trndat    >  fi_trandatT THEN NEXT. 

    /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. (bal <> 0) */
    IF Agtprm_fil.prem + Agtprm_fil.prem_comp = 0 THEN NEXT loop_main.
    
    /*-- export ทุกเรคคอร์ดที่ bal <> 0  รวมถึงกรมธรรม์ที่ยกเลิก -- Tantawan --  
    FIND LAST acm001 USE-INDEX acm00104  WHERE acm001.policy = Agtprm_fil.policy  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL acm001 THEN IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT.
    -*/

    ASSIGN
        nv_nor_si      = 0     nv_Netprm      = 0     nv_freeper   = 0
        nv_sckno       = ""    nv_Tbal        = 0     nv_balos     = 0 
        nv_covcod      = ""    nv_cha_no      = ""    nv_eng_no    = ""
        nv_ntitle      = "".
    
    FIND LAST acm001 USE-INDEX acm00101  
        WHERE acm001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) 
        AND   acm001.docno  = agtprm_fil.docno  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL acm001 THEN DO: 
        nv_balos = acm001.bal.
        IF acm001.comm = acm001.bal THEN NEXT.  /* ถ้า balance = comm. ถือว่าตัดเบี้ยค้างคอมฯ ไม่เอามาคิด */
    END.

    fi_Process     = "Process : " + STRING(Agtprm_fil.asdat) + '  ' +  Agtprm_fil.policy + '   ' + Agtprm_fil.trnty + '  ' + Agtprm_fil.docno. 
    DISPLAY     fi_Process  WITH FRAME fr_main .

    IF agtprm_fil.poltyp = "V70" THEN DO: 
        IF Agtprm_fil.prem_comp > 0 THEN nv_Netprm = Agtprm_fil.prem + Agtprm_fil.prem_comp .  /* เบี้ย 70 + เบี้ย พรบ.  (พรบ. ในตัว) */
                                    ELSE nv_Netprm = Agtprm_fil.prem.
    END.
    ELSE IF agtprm_fil.poltyp = "V72" THEN nv_Netprm = Agtprm_fil.prem_comp.
    
    /* ข้อมูลตามสลักครั้งล่าสุดที่โอนงานแล้ว */
    FIND LAST uwm100 USE-INDEX uwm10001 WHERE         
                  uwm100.policy = agtprm_fil.policy  AND
                  uwm100.relea  = YES    NO-LOCK NO-ERROR.
        IF AVAIL  uwm100 THEN 
            ASSIGN 
                nv_comdat  =  uwm100.comdat
                nv_expdat  =  uwm100.expdat
                nv_ntitle  =  TRIM(uwm100.ntitle)   /* A61-0020 */
                nv_fname   =  SUBSTR(TRIM(uwm100.name1),1,INDEX(TRIM(uwm100.name1)," ") - 1) 
                nv_lname   =  SUBSTR(TRIM(uwm100.name1),INDEX(TRIM(uwm100.name1)," ") + 1)
                nv_endno   =  uwm100.endno.

    FIND LAST uwm301 USE-INDEX uwm30101   WHERE
        uwm301.policy  =    uwm100.policy  AND
        uwm301.rencnt  =    uwm100.rencnt  AND
        uwm301.endcnt  =    uwm100.endcnt  NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN DO:
        ASSIGN
          nv_covcod  = uwm301.covcod
          nv_cha_no  = uwm301.cha_no 
          nv_eng_no  = uwm301.eng_no
          nv_model   = uwm301.moddes .

        IF agtprm_fil.poltyp = "V72"  THEN DO:

            FIND LAST Detaitem USE-INDEX detaitem01 WHERE
                      Detaitem.Policy  = uwm301.Policy NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL Detaitem THEN nv_sckno =  Detaitem.serailno.
                               ELSE nv_sckno = trim(substr(uwm301.drinam[9],7)) .
        END.
    END.

    /* ข้อมูลตามสลักครั้งนั้นๆ */
    FIND FIRST uwm100    WHERE
        uwm100.policy = Agtprm_fil.policy  AND
        uwm100.endno  = Agtprm_fil.endno   AND
        uwm100.docno1 = Agtprm_fil.docno   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm100 THEN DO:
        
        nv_rec100 = RECID(uwm100).

        FIND uwm100 WHERE RECID(uwm100) = nv_rec100 NO-LOCK NO-ERROR NO-WAIT.   

        FIND FIRST uwm130 USE-INDEX uwm13001  WHERE
                   uwm130.policy = uwm100.policy     AND
                   uwm130.rencnt = uwm100.rencnt     AND
                   uwm130.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE uwm130 THEN NEXT.
        ELSE DO:

                 IF agtprm_fil.poltyp = "V70"  THEN nv_nor_si  =  uwm130.uom6_v.
            ELSE IF agtprm_fil.poltyp = "V72"  THEN nv_nor_si  =  uwm130.uom8_v.

            /*--- ไม่ใช่ข้อมูลจาก Parameter แล้ว  -- ใช้การ Fix ในโปรแกรม และ User ระบุเองที่หน้าจอ
            FIND FIRST stat.insure USE-INDEX Insure03 WHERE 
                       stat.insure.compno = TRIM(fiCompNo)     AND
                       stat.Insure.InsNo  = Agtprm_fil.poltyp  AND
                       stat.Insure.Branch = Agtprm_fil.polbran NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL insure THEN ASSIGN nv_freeper  = Insure.deci1.
            ELSE nv_freeper = 0.
            */

            /*------------ create data to table wBill -----------*/
            FIND FIRST wBill USE-INDEX  wBill01               WHERE
                wBill.wAcno   = Agtprm_fil.acno               AND
                wBill.wPolicy = Agtprm_fil.policy             AND
                wBill.wEndno  = Agtprm_fil.endno              AND
                wBill.wtrnty1 = SUBSTR(Agtprm_fil.trnty,1,1)  AND
                wBill.wtrnty2 = SUBSTR(Agtprm_fil.trnty,2,1)  AND
                wBill.wdocno  = Agtprm_fil.docno              NO-ERROR NO-WAIT.
            IF NOT AVAIL wBill THEN DO:
                vCountRec = vCountRec + 1.
                DISPLAY "Create data to Table wBill ..." @ fi_Process WITH FRAME fr_main.
                CREATE wBill.
                ASSIGN 
                    wBill.wacno        = agtprm_fil.acno     /*Account Code      */  
                    wBill.wdocno       = Agtprm_fil.docno
                    wBill.wtrnty1      = SUBSTR(agtprm_fil.trntyp,1,1)
                    wBill.wtrnty2      = SUBSTR(agtprm_fil.trntyp,2,1)
                    wBill.wPolicy      = Agtprm_fil.policy   /*3   INS. Policy No.  */                 
                    wBill.wEndno       = nv_endno            /*Agtprm_fil.endno           /*A56-0176 */*/
                    wbill.nv_sckno     = nv_sckno            
                    wBill.wPoltype     = Agtprm_fil.poltyp          
                    wBill.wcovcod      = nv_covcod                                             /*4   insurance Type  */            
                    wBill.wtitle       = nv_ntitle                                             /*5   Customer Title Name  */              
                    wBill.wfirstname   = nv_fname                                              /*6   Customer First Name / Company Name*/ 
                    wBill.wlastname    = nv_lname                                              /*7 Customer Last Name */                
                    wBill.wNor_Comdat  = SUBSTR(STRING((YEAR(nv_comdat) + 543),"9999"),3,2) +  /*8 วันเริ่มคุ้มครอง  */                 
                                                STRING(MONTH(nv_comdat),"99") +                
                                                  STRING(DAY(nv_comdat),"99")                  
                    wBill.wNor_Expdat  = SUBSTR(STRING((YEAR(nv_expdat) + 543),"9999"),3,2) +  /*9 วันสิ้นสุดคุ้มครอง */                
                                                STRING(MONTH(nv_expdat),"99") + 
                                                  STRING(DAY(nv_expdat),"99")   
                    wBill.wsuminsurce  = nv_nor_si
                    wBill.wNetprm      = nv_Netprm
                    wBill.wtotNetprm   = nv_Netprm + Agtprm_fil.stamp  + Agtprm_fil.tax
                    wBill.wChassis_no  = nv_cha_no
                    wBill.wEngine_no   = nv_eng_no
                    wBill.wBrandModel  = nv_Model
                    wBill.wFee         = nv_freeper
                    wBill.wBal         = nv_balos
                    wBill.wFee_orthe   = 0  .

                nv_reccnt = nv_reccnt + 1.
                OUTPUT TO D:\TEMP\WACRAY6.TXT APPEND.
                PUT 
                  wBill.wAcno       "|"
                  wBill.wEndno      "|"
                  wbill.nv_sckno    "|"
                  wBill.wPolicy     "|"
                  wBill.wPoltype    "|"
                  wBill.wcovcod     "|"
                  wBill.wtrnty1 + wBill.wtrnty2 "|"
                  wBill.wDocno      "|"
                  wBill.wtitle      "|"
                  wBill.wfirstname  "|"
                  wBill.wlastname   "|"
                  wBill.wNor_Comdat "|"
                  wBill.wNor_Expdat "|"
                  wbill.wsuminsurce "|"
                  wBill.wNetprm     "|"
                  wBill.wtotNetprm  "|"
                  wBill.wChassis_no "|"
                  wBill.wEngine_no  "|"
                  wBill.wBrandModel "|"
                  wBill.wFee        "|"
                  wBill.wFeeamount  "|"
                  wBill.wFee_orthe  "|"
                SKIP.
                OUTPUT CLOSE.

            END.  /* find first wBill */
        END.  /* uwm301 */
    END.   /* avail  uwm100 */
END.     /* for each Agtprm_fil */

HIDE ALL NO-PAUSE.
IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_PutCSV C-Win 
PROCEDURE PD_PutCSV :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    nvfiFile-Name2 = fiFile-Name1 +  ".CSV".

    OUTPUT STREAM filebill1 TO VALUE(nvfiFile-Name2).
    n_wRecordno = 0.

    Loop1:
    FOR EACH wBill3 USE-INDEX wBill301 NO-LOCK :
    
        DISPLAY  "Export Data CSV : " + STRING(n_wRecordno,">>>>>9") + '  ' + wBill3.wpolicy
            + '  ' + wBill3.wtrnty1 + '-' + wBill3.wdocno @ fi_Process WITH FRAME fr_main .

        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill3.wtotNetprm. 
        
        PUT STREAM filebill1                                                                     
            "D"                       FORMAT "X"               ","  /* 1   Record Type         */
            n_wRecordno               FORMAT "99999"           ","  /* 2   Sequence no.        */
            wBill3.wPolicy            FORMAT "x(20)"           ","  /* 3   INS. Policy No.     */
            wBill3.wPolType           FORMAT "x(3)"            ","
            wBill3.nv_sckno           FORMAT "x(13)"           ","  /* 4   Sticker No.         */
            wBill3.wcovcod            FORMAT "x(2)"            ","  /* 5   Cover Type          */
            wBill3.wtitle             FORMAT "x(10)"           ","  /* 6   Customer Title Name */
            wBill3.wfirstname         FORMAT "x(25)"           ","  /* 7   Customer First Name */
            wBill3.wlastname          FORMAT "x(65)"           ","  /* 8   Customer Last Name  */
            wBill3.wNor_Comdat        FORMAT "x(8)"            ","  /* 9   วันเริ่มคุ้มครอง    */
            wBill3.wNor_Expdat        FORMAT "x(8)"            ","  /* 10  วันสิ้นสุดคุ้มครอง  */
            deci(wBill3.wsuminsurce)  FORMAT ">>>>>>>>9.99-"   ","  /* 11  Sum Insured         */
            deci(wBill3.wNetprm)      FORMAT ">>>>>>>>9.99-"   ","  /* 12  Net.INS.Prm         */
            deci(wBill3.wtotNetprm)   FORMAT ">>>>>>>>9.99-"   ","  /* 13  Total.INS.Prm       */
            wBill3.wChassis_no        FORMAT "x(30)"           ","  /* 14  Chassis No.         */
            wBill3.wEngine_no         FORMAT "x(30)"           ","  /* 15  Engine No.          */
            deci(wBill3.wFee)         FORMAT ">>>>>>>>9.99-"   ","  /* 16  ค่า Fee             */
            deci(wBill3.wFeeamount)   FORMAT ">>>>>>>>9.99-"   ","  /* 17  ค่า Fee amount      */
            deci(wBill3.wFee_orthe)   FORMAT ">>>>>>>>9.99-"   ","  /* 18  ค่าอนุโลม           */
            wBill3.wAcno              FORMAT "X(10)"           ","  /* 19  Account No.         */
            wBill3.wBal               FORMAT ">>>>>>>>9.99-"   ","  /* 20  Balance             */
            wBill3.wBrandModel        FORMAT "X(65)"                /* 21  Model Description   */
            
        SKIP. 
    END.      /* for each wBill3 */
    
    n_wRecordno = n_wRecordno + 1 .
    OUTPUT STREAM filebill1 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile1 C-Win 
PROCEDURE PD_SplitFile1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File1 === Export เฉพาะ Code = 'A0M0073'   และที่เป็น  'V70'    Fix 18% ===
------------------------------------------------------------------------------*/
    /*OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1 + "_A0M0073.CSV").----A63-0391*/
    OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1 + "_BigBike.CSV"). /*A0M0073, B3MLAY0105*/ /*A63-0391*/
    ASSIGN
        vExpCount1  = 0
        nv_sumprem  = 0
        n_wRecordno = 1
        n_binloop   = ""
        n_bindate   = ""
        n_binloop   = STRING(fi_binloop,"9")
        n_bindate   = STRING(fi_bindate,"99/99/9999")
        dateasof    = STRING(n_asdat)
        dateasof    = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = 18 . /* Fix */

    PUT STREAM filebill1
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill402 
        WHERE /*wBill4.Acno     = "A0M0073"---A63-0391*/
        (wBill4.wAcno = "A0M0073" OR wBill4.wAcno = "B3MLAY0105") /*A63-0391*/ AND wBill4.wPolType = "V70" 

        BREAK BY wBill4.wPolicy :
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .

        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm. 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill1
            "D"                FORMAT "X"                         ","   /* 1  Record Type         */
            n_wRecordno        FORMAT "99999"                     ","   /* 2  Sequence no.        */
            wBill4.wPolicy     FORMAT "x(20)"                     ","   /* 3  INS. Policy No.     */               
            wBill4.wcovcod     FORMAT "x(2)"                      ","   /* 4  insurance Type      */                
            wBill4.wtitle      FORMAT "x(10)"                     ","   /* 5  Customer Title Name */              
            wBill4.wfirstname  FORMAT "x(25)"                     ","   /* 6  Customer First Name */ 
            wBill4.wlastname   FORMAT "x(65)"                     ","   /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat FORMAT "x(8)"                      ","   /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat FORMAT "x(8)"                      ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wsuminsurce)  FORMAT ">>>>>>>>9.99-"   ","  /* 11  Sum Insured         */
            deci(wBill4.wNetprm)      FORMAT ">>>>>>>>9.99-"   ","  /* 12  Net.INS.Prm         */
            deci(wBill4.wtotNetprm)   FORMAT ">>>>>>>>9.99-"   ","  /* 13  Total.INS.Prm       */
            wBill4.wChassis_no        FORMAT "x(30)"           ","  /* 14  Chassis No.         */
            wBill4.wEngine_no         FORMAT "x(30)"           ","  /* 15  Engine No.          */
            deci(nv_freeper)          FORMAT ">>>>>>>>9.99-"   ","  /* 16  ค่า Fee             */
            deci(wBill4.wFeeamount)   FORMAT ">>>>>>>>9.99-"   ","  /* 17  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)   FORMAT ">>>>>>>>9.99-"   ","  /* 18  ค่าอนุโลม           */
            wBill4.wacno              FORMAT "X(10)"   ","
            wBill4.wBrand             FORMAT "X(50)"   
            SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill1
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"        SKIP. 
    OUTPUT STREAM filebill1 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile2 C-Win 
PROCEDURE PD_SplitFile2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File2 === Export เฉพาะ Code = 'A0M0028','A0M0012'   และที่ Model Description = 'ISUZU'    V70 Fix 22%, V72 Fix12%  ===
------------------------------------------------------------------------------*/
def var nv_SumInsurce  as deci init 0.
def var nv_NetPrm      as deci init 0.
def var nv_TotNetPrm   as deci init 0.
DEF VAR nv_pol1        AS CHAR init "".
DEF VAR nv_pol2        AS CHAR init "".
DEF VAR nv_pol3        AS CHAR INIT "".

    OUTPUT STREAM filebill2 TO VALUE(fiFile-Name1 + "_ISUZU.CSV").
    ASSIGN
        vExpCount1   = 0
        n_wRecordno  = 1
        nv_sumprem   = 0
        nv_NetPrm    = 0   
        nv_TotNetPrm = 0  
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = IF ra_Free = 1 THEN 22 ELSE fi_freeper. /* ELSE = User ระบุเองจากหน้าจอ */ /*-----Block by A63-0391*/

    PUT STREAM filebill2
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

OUTPUT TO D:\TEMP\WACRAY6_File2BeforGrpChassis.TXT.
PUT "wAcno|Sticker|wPolicy|wPoltype|wcovcod|wtitle|wfirstname|wlastnamew|Nor_Comdat|wNor_Expdat|
     wSuminsurce|wNetprm|wtotNetprm|wChassis_no|wEngine_no|wModel|wFee|wFeeamount|wFee_orthe" 
SKIP.
OUTPUT CLOSE.

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill402 
        WHERE wBill4.wAcno = "A0M0028" /*OR wBill4.Acno = "A0M0012" --A63-0391*/
           OR wBill4.wAcno = "B3MLAY0103" /*A63-0391*/

    BREAK BY wBill4.wChassis_no 
          BY wBill4.wPolType :
        
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        
        IF INDEX(wBill4.wBrandModel,"ISUZU") = 0 THEN NEXT loop1.

        /* งาน 70 ที่ไม่ใช่ประเภท 1 ให้ Next */
        IF wBill4.wPolType = "V70" AND wBill4.wcovcod <> "1" THEN NEXT.
        IF wBill4.wPolType = "V70" THEN 
            ASSIGN 
              nv_pol1        = wBill4.wPolicy
              nv_SumInsurce  = wBill4.wsuminsurce .  /* เก็บค่าทุนประกันล่าสุดของแต่ละกรมธรรม์ เฉพาะ กธ. 70 */

        IF FIRST-OF(wBill4.wChassis_no) THEN DO:
            ASSIGN
              nv_NetPrm      = nv_NetPrm     +  wBill4.wNetprm
              nv_TotNetPrm   = nv_TotNetPrm  +  wBill4.wtotNetprm

              n_wRecordno = n_wRecordno + 1 
              vExpCount1  = vExpCount1  + 1
              nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

            nv_pol3 = wBill4.wPolicy. 
        END.

        OUTPUT TO D:\TEMP\WACRAY6_BeforGrpChassis.TXT APPEND.
        PUT wBill4.wAcno       "|"
            wbill4.wSckno      "|"
            wBill4.wPolicy     "|"
            wBill4.wPoltype    "|"
            wBill4.wcovcod     "|"
            wBill4.wtitle      "|"
            wBill4.wfirstname  "|"
            wBill4.wlastname   "|"
            wBill4.wNor_Comdat "|"
            wBill4.wNor_Expdat "|"
            wbill4.wsuminsurce "|"
            wBill4.wNetprm     "|"
            wBill4.wtotNetprm  "|"
            wBill4.wChassis_no "|"
            wBill4.wEngine_no  "|"
            wBill4.wBrandModel "|"
            wBill4.wFee        "|"
            wBill4.wFeeamount  "|"
            wBill4.wFee_orthe  "|"  SKIP.
        OUTPUT CLOSE.

        IF LAST-OF(wBill4.wChassis_no) THEN DO:  /* กรณีคีย์ 72 แยกจาก 70 ให้ใช้ Chassis Group เบี้ย */

            /* ถ้า กธ. 72 */
            IF wBill4.wPolType = "V72" THEN DO: 

                IF nv_pol3 = wBill4.wPolicy THEN DO : /* กธ. 72 เดี่ยว ๆ ไม่มี กธ. 70 ให้เคลียร์ค่าออก และ Next record*/
                    ASSIGN
                        n_wRecordno  = n_wRecordno - 1 
                        vExpCount1   = vExpCount1  - 1 
                        nv_sumprem   = nv_sumprem  - wBill4.wtotNetprm
                        nv_NetPrm    = 0.
                        nv_TotNetPrm = 0.
                    NEXT loop1.
                END.
                ELSE DO: /* รวมเบี้ย 72 เข้าไปด้วย */
                    ASSIGN 
                      nv_sumprem   = nv_sumprem   + wBill4.wtotNetprm 
                      nv_NetPrm    = nv_NetPrm    + wBill4.wNetprm 
                      nv_TotNetPrm = nv_TotNetPrm + wBill4.wtotNetprm.
                END.
            END.

            wBill4.wFeeamount   = (nv_NetPrm  * nv_freeper) / 100 .
            /* แสดงกรมธรรม์ 70 */
            IF wBill4.wPolType <> "V70" THEN nv_pol2 = nv_pol1 .
                                        ELSE nv_pol2 = wBill4.wPolicy. 
            PUT STREAM filebill2
                "D"                FORMAT "X"                   ","   /* 1  Record Type         */
                n_wRecordno        FORMAT "99999"               ","   /* 2  Sequence no.        */
                nv_pol2            FORMAT "x(20)"               ","   /* 3  INS. Policy No.     */               
                /*wBill4.wcovcod     FORMAT "x(2)"                ","   /* 4  insurance Type      */                */
                "1"                FORMAT "X"                   ","  /* fix ค่าเป็น 1 --- wBill4.wcovcod */
                wBill4.wtitle      FORMAT "x(10)"               ","    /* 5  Customer Title Name */              
                wBill4.wfirstname  FORMAT "x(25)"               ","   /* 6  Customer First Name */ 
                wBill4.wlastname   FORMAT "x(65)"               ","   /* 7  Customer Last Name  */               
                wBill4.wNor_Comdat FORMAT "x(8)"                ","   /* 8  วันเริ่มคุ้มครอง    */               
                wBill4.wNor_Expdat FORMAT "x(8)"                ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
                deci(nv_suminsurce)     FORMAT ">>>>>>>>9.99-"  ","  /* 11  Sum Insured         */
                deci(nv_Netprm)         FORMAT ">>>>>>>>9.99-"  ","  /* 12  Net.INS.Prm         */
                deci(nv_totNetprm)      FORMAT ">>>>>>>>9.99-"  ","  /* 13  Total.INS.Prm       */
                wBill4.wChassis_no      FORMAT "x(30)"          ","  /* 14  Chassis No.         */
                wBill4.wEngine_no       FORMAT "x(30)"          ","  /* 15  Engine No.          */
                deci(nv_freeper)        FORMAT ">>>>>>>>9.99-"  ","  /* 16  ค่า Fee             */
                deci(wBill4.wFeeamount) FORMAT ">>>>>>>>9.99-"  ","  /* 17  ค่า Fee amount      */
                deci(wBill4.wFee_orthe) FORMAT ">>>>>>>>9.99-"  ","  /* 18  ค่าอนุโลม           */
                wBill4.wacno            FORMAT "X(10)"          "," 
                wBill4.wBrand           FORMAT "X(50)"          "," 
                wBill4.wPolicy          FORMAT "x(20)"          ","  /* 3  Policy No. V72       */               
                deci(wBill4.wNetprm)    FORMAT ">>>>>>>>9.99-"  ","  /* 12  Net.INS.Prm   V72   */  
                deci(wBill4.wtotNetprm) FORMAT ">>>>>>>>9.99-"       /* 13  Total.INS.Prm V72   */  
                SKIP.

            /* เก็บค่าแล้ว Clear ค่าเป็น 0*/
            ASSIGN
                nv_SumInsurce  = 0
                nv_NetPrm      = 0
                nv_TotNetPrm   = 0.

            /*--- nok --- 25/1/2018 --
            /* ถ้ามีกรมธรรม์ 72 คียแยกจาก 70 */
            IF nv_pol3 <> wBill4.wPolicy THEN DO:
                FIND FIRST bwBill4 WHERE bwBill4.wChassis_no = wBill4.wChassis_no 
                                   AND   bwBill4.wPolType    = "V70" NO-ERROR.
                IF AVAIL bwBill4 THEN DELETE bwBill4. /* Delete กรมธรรม์ 70 ออกจาก TEMP-TABLE */
            END.
            --------------*/

            /* ถ้ามีกรมธรรม์ 72 คียแยกจาก 70 */
            IF nv_pol3 <> wBill4.wPolicy THEN DO:
                FIND FIRST bwBill4 WHERE bwBill4.wChassis_no = wBill4.wChassis_no 
                                   AND   bwBill4.wPolType    = "V70" NO-ERROR.
                IF AVAIL bwBill4 THEN DELETE bwBill4. /* Delete กรมธรรม์ 70 ออกจาก TEMP-TABLE */
            END.

            /* put data แล้ว delete ข้อมูลออกจาก Temp -- Delete หลังจาก Delete V70 แล้ว */
            DELETE wBill4.

        END.
    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .

    PUT STREAM filebill2
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile3 C-Win 
PROCEDURE PD_SplitFile3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File3 === Export เฉพาะ Code = A0M0012' และ Model Description = 'MAZDA' , 'FORD' และเป็น ป.1   
                   Fix Rate ตามรุ่น 
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill3 TO VALUE(fiFile-Name1 + "_MazFord.CSV").
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2)
        nv_freeper = 0.

    PUT STREAM filebill3
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill401
        WHERE wBill4.wAcno    = "A0M0012"
        AND   wBill4.wPolType = "V70"
        AND   wBill4.wcovcod  = "1"        /* ประเภท 1 */
        
    BREAK BY wBill4.wPolicy :
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .

        IF INDEX(wBill4.wBrandModel,"MAZDA") = 0 AND INDEX(wBill4.wBrandModel,"FORD")  = 0 THEN NEXT.
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm. 

        /* MAZDA */
        IF INDEX(wBill4.wBrandModel,"Mazda 2")   <> 0 THEN wBill4.wFee_orthe = 500.
        IF INDEX(wBill4.wBrandModel,"BT-50")     <> 0 THEN wBill4.wFee_orthe = 500.
        IF INDEX(wBill4.wBrandModel,"CX-3")      <> 0 THEN wBill4.wFee_orthe = 800.
        IF INDEX(wBill4.wBrandModel,"Mazda 3")   <> 0 THEN wBill4.wFee_orthe = 1000.
        IF INDEX(wBill4.wBrandModel,"CX-5")      <> 0 THEN wBill4.wFee_orthe = 1000.
        IF INDEX(wBill4.wBrandModel,"CX-9")      <> 0 THEN wBill4.wFee_orthe = 2000.
        /* FORD */
        IF INDEX(wBill4.wBrandModel,"ECOSPORT")  <> 0 THEN wBill4.wFee_orthe = 500.
        IF INDEX(wBill4.wBrandModel,"RANGER")    <> 0 THEN wBill4.wFee_orthe = 500.
        IF INDEX(wBill4.wBrandModel,"FIESTA")    <> 0 THEN wBill4.wFee_orthe = 500.
        IF INDEX(wBill4.wBrandModel,"FOCUS")     <> 0 THEN wBill4.wFee_orthe = 500.
        IF INDEX(wBill4.wBrandModel,"ESCAPE")    <> 0 THEN wBill4.wFee_orthe = 1000.
        IF INDEX(wBill4.wBrandModel,"EVEREST")   <> 0 THEN wBill4.wFee_orthe = 1000.
        IF INDEX(wBill4.wBrandModel,"TERRITORY") <> 0 THEN wBill4.wFee_orthe = 2000.

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill3
            "D"                FORMAT "X"                   ","   /* 1  Record Type         */
            n_wRecordno        FORMAT "99999"               ","   /* 2  Sequence no.        */
            wBill4.wPolicy     FORMAT "x(20)"               ","   /* 3  INS. Policy No.     */               
            wBill4.wcovcod     FORMAT "x(2)"                ","   /* 4  insurance Type      */                
            wBill4.wtitle      FORMAT "x(10)"               ","   /* 5  Customer Title Name */              
            wBill4.wfirstname  FORMAT "x(25)"               ","   /* 6  Customer First Name */ 
            wBill4.wlastname   FORMAT "x(65)"               ","   /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat FORMAT "x(8)"                ","   /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat FORMAT "x(8)"                ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 11  Sum Insured         */
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 12  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 13  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 14  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 15  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 18  ค่าอนุโลม           */
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"          
            SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill3
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill3 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile4 C-Win 
PROCEDURE PD_SplitFile4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File4 === Export เฉพาะ Code = 'A0M0012' , 'A0M0028' , 'A0M0061' , 'A0M0064", 'A0M1011' 
                 ที่ Poltype = "V70" 
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill4 TO VALUE(fiFile-Name1 + "_BayV70.CSV").
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = STRING(DECI(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    /*-nv_freeper = IF ra_Free = 1 THEN 22 ELSE fi_freeper. /* ELSE = User ระบุเองจากหน้าจอ */-Block by A63-0391*/

    PUT STREAM filebill4
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    /*--------
    FOR EACH wBill4 USE-INDEX wBill401 
        WHERE (wBill4.Acno  = "A0M0012" OR wBill4.Acno = "A0M0028"
        OR     wBill4.Acno  = "A0M0061" OR wBill4.Acno = "A0M1011"
        OR     wBill4.Acno  = "A0M0064"  )
        AND    wBill4.wPolType = "V70"
    BREAK BY wBill4.wPolicy :
    --------Block by A63-0391*/

    /*--A63-0391--*/
    FOR EACH wBill4 USE-INDEX wBill401 
        WHERE ( wBill4.wAcno = "A0M1011" OR wBill4.wAcno = "B3MLAY0106") AND wBill4.wPolType = "V70"
        BREAK BY wBill4.wPolicy :

             IF wBill4.wcovcod = "1" THEN nv_freeper = 25.
        ELSE IF wBill4.wcovcod = "2" THEN nv_freeper = 30.
        ELSE IF wBill4.wcovcod = "3" THEN nv_freeper = 22.
   /*--End A63-0391--*/
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill4
            "D"                      FORMAT "X"             ","  /*  1  Record Type         */
            n_wRecordno              FORMAT "99999"         ","  /*  2  Sequence no.        */
            wBill4.wPolicy           FORMAT "x(20)"         ","  /*  3  INS. Policy No.     */               
            wBill4.wcovcod           FORMAT "x(2)"          ","  /*  4  insurance Type      */                
            wBill4.wtitle            FORMAT "x(10)"         ","  /*  5  Customer Title Name */              
            wBill4.wfirstname        FORMAT "x(25)"         ","  /*  6  Customer First Name */ 
            wBill4.wlastname         FORMAT "x(65)"         ","  /*  7  Customer Last Name  */               
            wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /*  8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /*  9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 11  Sum Insured         */
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 12  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 13  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 14  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 15  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 18  ค่าอนุโลม           */
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"         SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill4
    "T"                         FORMAT "X"      ","    /*  1.*/
    n_wRecordno                 FORMAT "99999"  ","    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  ","   /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 
    OUTPUT STREAM filebill4 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile5 C-Win 
PROCEDURE PD_SplitFile5 :
/*------------------------------------------------------------------------------
  Purpose:   
  Parameters:  <none>
  Notes: File4 === Export เฉพาะ Code = 'A0M0012' , 'A0M0028' , 'A0M0061' , 'A0M0064", 'A0M1011' 
                 ที่ Poltype = "V70"   Fix = 22%
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill5 TO VALUE(fiFile-Name1 + "_BayV72.CSV").
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    /*nv_freeper = IF ra_Free = 1 THEN 22 ELSE fi_freeper. /* ELSE = User ระบุเองจากหน้าจอ */-----Block by A63-0391*/
    nv_freeper = 12. /*A63-0391*/

    PUT STREAM filebill5
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "2"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    /*------
    FOR EACH wBill4 USE-INDEX wBill401
        WHERE ( wBill4.Acno = "A0M0028" OR wBill4.Acno = "A0M0061" OR wBill4.Acno = "A0M1011" 
             OR wBill4.Acno  = "B3MLAY0104" OR wBill4.Acno  = "B3MLAY0106" /*A63-0391*/ )
        AND    wBill4.wPolType = "V72"
    BREAK BY wBill4.wPolicy :
    ---------Block by A63-0391*/
    /*A63-0391*/
    FOR EACH wBill4 USE-INDEX wBill401
        WHERE ( wBill4.wAcno = "A0M0061" OR wBill4.wAcno  = "B3MLAY0104") AND wBill4.wPolType = "V72"
        BREAK BY wBill4.wPolicy :

    /*End A63-0391*/
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .

        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill5
            "D"                      FORMAT "X"                   ","  /* 1  Record Type         */
            n_wRecordno              FORMAT "99999"               ","  /* 2  Sequence no.        */
            wBill4.wSckno            FORMAT "x(20)"               ","  /* 3  INS. Policy No.     */               
            wBill4.wtitle            FORMAT "x(10)"               ","  /* 5  Customer Title Name */              
            wBill4.wfirstname        FORMAT "x(25)"               ","  /* 6  Customer First Name */ 
            wBill4.wlastname         FORMAT "x(65)"               ","  /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat       FORMAT "x(8)"                ","  /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat       FORMAT "x(8)"                ","  /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 10  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 11  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 12  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 13  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 14  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่าอนุโลม           */
            wBill4.wPolicy           FORMAT "x(20)"         ","  /* 17  INS. Policy No.     */               
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"          
            SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill5
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill5 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile5-1 C-Win 
PROCEDURE PD_SplitFile5-1 :
/*------------------------------------------------------------------------------
  Purpose: A63-0391    
  Parameters:  <none>
  Notes: File4 === Export เฉพาะ Code = 'A0M0018' , 'B3MLAY0101'
                 ที่ Poltype = "V70"   Fix = 22%
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill5 TO VALUE(fiFile-Name1 + "_RenewV70.CSV"). /*ต่ออายุปกติ V70*/
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = STRING(DECI(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = 22. /* ELSE = User ระบุเองจากหน้าจอ */ 

    PUT STREAM filebill5
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill401 
        WHERE ( wBill4.wAcno = "A0M0018" OR wBill4.wAcno = "B3MLAY0101") AND wBill4.wPolType = "V70"
        BREAK BY wBill4.wPolicy :
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill5
            "D"                      FORMAT "X"             ","  /*  1  Record Type         */      
            n_wRecordno              FORMAT "99999"         ","  /*  2  Sequence no.        */
            wBill4.wPolicy           FORMAT "x(20)"         ","  /*  3  INS. Policy No.     */               
            wBill4.wcovcod           FORMAT "x(2)"          ","  /*  4  insurance Type      */                
            wBill4.wtitle            FORMAT "x(10)"         ","  /*  5  Customer Title Name */              
            wBill4.wfirstname        FORMAT "x(25)"         ","  /*  6  Customer First Name */ 
            wBill4.wlastname         FORMAT "x(65)"         ","  /*  7  Customer Last Name  */               
            wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /*  8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /*  9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 11  Sum Insured         */
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 12  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 13  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 14  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 15  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 18  ค่าอนุโลม           */
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"         SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill5
    "T"                         FORMAT "X"      ","    /*  1.*/
    n_wRecordno                 FORMAT "99999"  ","    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  ","   /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 
    OUTPUT STREAM filebill5 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile5-2 C-Win 
PROCEDURE PD_SplitFile5-2 :
/*------------------------------------------------------------------------------
  Purpose: A63-0391
  Parameters:  <none>
  Notes: File5 === Export เฉพาะ Code = 'A0M0018' , 'B3MLAY0101'
                   ที่ Poltype = "V72"   Fix = 12%
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill5 TO VALUE(fiFile-Name1 + "_AYCAL72.CSV"). /*ต่ออายุปกติ V72*/
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = 12.  /* ELSE = User ระบุเองจากหน้าจอ */

    PUT STREAM filebill5
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "2"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:

    FOR EACH wBill4 USE-INDEX wBill401
        WHERE ( wBill4.wAcno = "A0M0018" OR wBill4.wAcno  = "B3MLAY0101" OR
                wBill4.wAcno = "A0M0019" OR wBill4.wAcno  = "B3MLAY0102" OR 
                wBill4.wAcno = "A0M1011" OR wBill4.wAcno  = "B3MLAY0106" )  AND wBill4.wPolType = "V72"
        BREAK BY wBill4.wPolicy :

        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill5
            "D"                      FORMAT "X"             ","  /* 1  Record Type          */
            n_wRecordno              FORMAT "99999"         ","  /* 2  Sequence no.         */
            wBill4.wSckno            FORMAT "x(20)"         ","  /* 3  INS. Policy No.      */               
            wBill4.wtitle            FORMAT "x(10)"         ","  /* 5  Customer Title Name  */              
            wBill4.wfirstname        FORMAT "x(25)"         ","  /* 6  Customer First Name  */ 
            wBill4.wlastname         FORMAT "x(65)"         ","  /* 7  Customer Last Name   */               
            wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /* 8  วันเริ่มคุ้มครอง     */               
            wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /* 9  วันสิ้นสุดคุ้มครอง   */               
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 10  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 11  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 12  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 13  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 14  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่าอนุโลม           */
            wBill4.wPolicy           FORMAT "x(20)"         ","  /* 17  INS. Policy No.     */               
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"          
            SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill5
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill5 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile5-3 C-Win 
PROCEDURE PD_SplitFile5-3 :
/*------------------------------------------------------------------------------
  Purpose: A63-0391    
  Parameters:  <none>
  Notes: File4 === Export เฉพาะ Code = 'A0M0061' , 'B3MLAY0104'
                   ที่ Poltype = "V70"  
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill5 TO VALUE(fiFile-Name1 + "_RedLabelV70.CSV"). /*ป้ายแดงปกติ V70*/
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = STRING(DECI(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = 22. /* ELSE = User ระบุเองจากหน้าจอ */

    PUT STREAM filebill5
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:

    FOR EACH wBill4 USE-INDEX wBill401 
        WHERE ( wBill4.wAcno = "A0M0061" OR wBill4.wAcno = "B3MLAY0104") AND    wBill4.wPolType = "V70"
       BREAK BY wBill4.wPolicy :

       DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
       ASSIGN
         n_wRecordno = n_wRecordno + 1 
         vExpCount1  = vExpCount1  + 1
         nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

       wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

       PUT STREAM filebill5
         "D"                      FORMAT "X"             ","  /*  1  Record Type         */      
         n_wRecordno              FORMAT "99999"         ","  /*  2  Sequence no.        */
         wBill4.wPolicy           FORMAT "x(20)"         ","  /*  3  INS. Policy No.     */               
         wBill4.wcovcod           FORMAT "x(2)"          ","  /*  4  insurance Type      */                
         wBill4.wtitle            FORMAT "x(10)"         ","  /*  5  Customer Title Name */              
         wBill4.wfirstname        FORMAT "x(25)"         ","  /*  6  Customer First Name */ 
         wBill4.wlastname         FORMAT "x(65)"         ","  /*  7  Customer Last Name  */               
         wBill4.wNor_Comdat       FORMAT "x(8)"          ","  /*  8  วันเริ่มคุ้มครอง    */               
         wBill4.wNor_Expdat       FORMAT "x(8)"          ","  /*  9  วันสิ้นสุดคุ้มครอง  */               
         deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 11  Sum Insured         */
         deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 12  Net.INS.Prm         */
         deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 13  Total.INS.Prm       */
         wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 14  Chassis No.         */
         wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 15  Engine No.          */
         deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee             */
         deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่า Fee amount      */
         deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 18  ค่าอนุโลม           */
         wBill4.wacno             FORMAT "X(10)"         "," 
         wBill4.wBrand            FORMAT "X(50)"         SKIP.

       /* put data แล้ว delete ข้อมูลออกจาก Temp*/
       DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill5
    "T"                         FORMAT "X"      ","    /*  1.*/
    n_wRecordno                 FORMAT "99999"  ","    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  ","   /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 
    OUTPUT STREAM filebill5 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile6 C-Win 
PROCEDURE PD_SplitFile6 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File6 === Export Poltype = "V70"  ที่ไม่ใช่ Acno ที่กำหนดไว้ที่ไฟลืก่อนหน้า  Fix = 22%
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill6 TO VALUE(fiFile-Name1 + "_OthV70.CSV").
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = IF ra_Free = 1 THEN 22 ELSE fi_freeper. /* ELSE = User ระบุเองจากหน้าจอ */

    PUT STREAM filebill6
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill401 WHERE wBill4.wPolType = "V70" :
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill6
            "D"                FORMAT "X"                   ","   /* 1  Record Type         */
            n_wRecordno        FORMAT "99999"               ","   /* 2  Sequence no.        */
            wBill4.wPolicy     FORMAT "x(20)"               ","   /* 3  INS. Policy No.     */               
            wBill4.wcovcod     FORMAT "x(2)"                ","   /* 4  insurance Type      */                
            wBill4.wtitle      FORMAT "x(10)"               ","   /* 5  Customer Title Name */              
            wBill4.wfirstname  FORMAT "x(25)"               ","   /* 6  Customer First Name */ 
            wBill4.wlastname   FORMAT "x(65)"               ","   /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat FORMAT "x(8)"                ","   /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat FORMAT "x(8)"                ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 11  Sum Insured         */
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 12  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 13  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 14  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 15  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 18  ค่าอนุโลม           */
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"          
            SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill6
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill6 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile7 C-Win 
PROCEDURE PD_SplitFile7 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File7 === Export Poltype = "V72"  ที่ไม่ใช่ Acno ที่กำหนดไว้ที่ไฟลืก่อนหน้า  Fix = 22%
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill7 TO VALUE(fiFile-Name1 + "_OthV72.CSV").
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = IF ra_Free = 1 THEN 22 ELSE fi_freeper. /* ELSE = User ระบุเองจากหน้าจอ */

    PUT STREAM filebill7
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "2"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill401 WHERE wBill4.wPolType = "V72" :
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill7
            "D"                FORMAT "X"                   ","  /* 1  Record Type         */
            n_wRecordno        FORMAT "99999"               ","  /* 2  Sequence no.        */
            wBill4.wSckno      FORMAT "x(20)"               ","  /* 3  INS. Policy No.     */               
            wBill4.wtitle      FORMAT "x(10)"               ","  /* 5  Customer Title Name */              
            wBill4.wfirstname  FORMAT "x(25)"               ","  /* 6  Customer First Name */ 
            wBill4.wlastname   FORMAT "x(65)"               ","  /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat FORMAT "x(8)"                ","  /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat FORMAT "x(8)"                ","  /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 10  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 11  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 12  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 13  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 14  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 15  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่าอนุโลม           */
            wBill4.wPolicy           FORMAT "x(20)"         ","  /* 17  INS. Policy No.     */               
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"          
            SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill7
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill7 CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_SplitFile8 C-Win 
PROCEDURE PD_SplitFile8 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File8 === Export Other Policy Fix = 22%
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill8 TO VALUE(fiFile-Name1 + "_Other.CSV").
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = IF ra_Free = 1 THEN 22 ELSE fi_freeper. /* ELSE = User ระบุเองจากหน้าจอ */

    PUT STREAM filebill8
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill401 :
    
        DISPLAY  "Split Data File : " + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill8
            "D"                FORMAT "X"                   ","   /* 1  Record Type         */
            n_wRecordno        FORMAT "99999"               ","   /* 2  Sequence no.        */
            wBill4.wPolicy     FORMAT "x(20)"               ","   /* 3  INS. Policy No.     */               
            wBill4.wSckno      FORMAT "x(20)"               ","   /* 3  INS. Policy No.     */               
            wBill4.wcovcod     FORMAT "x(2)"                ","   /* 4  insurance Type      */                
            wBill4.wtitle      FORMAT "x(10)"               ","   /* 5  Customer Title Name */              
            wBill4.wfirstname  FORMAT "x(25)"               ","   /* 6  Customer First Name */ 
            wBill4.wlastname   FORMAT "x(65)"               ","   /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat FORMAT "x(8)"                ","   /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat FORMAT "x(8)"                ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 11  Sum Insured         */
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 12  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 13  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 14  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 15  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 18  ค่าอนุโลม           */
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"          
            SKIP.

        /* put data แล้ว delete ข้อมูลออกจาก Temp*/
        DELETE wBill4.

    END.      /* for each wBill4 */

    DISPLAY  "Split Data End. See file split at D:\TEMP "  @ fi_Process WITH FRAME fr_main .
    
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill8
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill8 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_UpdateQ C-Win 
PROCEDURE PD_UpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Tantawan Ch.    A65-0021    
------------------------------------------------------------------------------*/
OPEN QUERY br_browse FOR EACH Insure USE-INDEX Insure01
    WHERE Insure.CompNo   = "FreeRate"
    AND   Insure.InsTitle = "FN" NO-LOCK 
    BY Insure.FName.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_init C-Win 
PROCEDURE proc_init :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_RecordType         = ""    
    nv_Sequenceno         = ""    
    nv_INS_PolicyNo       = ""   
    nv_poltype            = ""
    nv_insuranceType      = ""    
    nv_CustomerTitleName  = ""    
    nv_CustomerFirstNAME  = ""    
    nv_CustomerLastName   = ""    
    nv_comdate            = ""   
    nv_expdate            = ""   
    nv_SumInsured         = ""   
    nv_NetINSPrm          = ""   
    nv_TotalINSPrm        = ""   
    nv_ChassisNo          = ""   
    nv_EngineNo           = ""   
    nv_Fee                = ""   
    nv_Feeamount          = ""   
    nv_fee01              = ""
    nv_acno               = ""
    nv_Brand              = ""
    nv_InsureSticker      = ""
    nv_InsureCover        = ""
    . 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_output2 C-Win 
PROCEDURE proc_output2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wBill2. DELETE wBill2. END. 

INPUT FROM VALUE (fiFile-Nameinput) .                                   
    REPEAT: 
        IMPORT DELIMITER ","
            nv_RecordType                                                   
            nv_Sequenceno                                    
            nv_INS_PolicyNo                                  
            nv_insuranceType                                 
            nv_CustomerTitleName                           
            nv_CustomerFirstNAME                         
            nv_CustomerLastName                             
            nv_comdate                                       
            nv_expdate                                       
            nv_SumInsured              
            nv_NetINSPrm               
            nv_TotalINSPrm             
            nv_ChassisNo           
            nv_EngineNo            
            nv_Fee                  
            nv_Feeamount            
            nv_fee01      .  

        IF TRIM(nv_RecordType) = "H"  THEN NEXT.
        ELSE IF trim(nv_RecordType) = "D"  THEN DO:
          CREATE wBill2.
          ASSIGN 
              wBill2.recordtyp    = TRIM(nv_RecordType)          /*1 Record Type  */  
              wBill2.sequenceno   = TRIM(nv_Sequenceno)          /*2 Sequence no. */  
              wBill2.wPolicy      = TRIM(nv_INS_PolicyNo)        /*3 Company Name */  
              wBill2.wcovcod      = TRIM(nv_insuranceType)       /*4 Product      */  
              wBill2.wtitle       = TRIM(nv_CustomerTitleName)   /*5 Insurance company name*/
              wBill2.wfirstname   = TRIM(nv_CustomerFirstNAME)   /*6 Insurer  code*/
              wBill2.wlastname    = TRIM(nv_CustomerLastName)    /*7 As of Date   */
              wBill2.wNor_Comdat  = TRIM(nv_comdate)             /*8 Product Type */
              wBill2.wNor_Expdat  = TRIM(nv_expdate)             /* วันเริ่มคุ้มครอง       */
              wBill2.wsuminsurce  = deci(nv_SumInsured)          /* วันสิ้นสุดคุ้มครอง    */
              wBill2.wNetprm      = deci(nv_NetINSPrm)           /* วันสิ้นสุดคุ้มครอง    */
              wBill2.wtotNetprm   = deci(nv_TotalINSPrm)         /* Sum Insured    */
              wBill2.wChassis_no  = TRIM(nv_ChassisNo)           /* Net.INS.Prm    */
              wBill2.wEngine_no   = TRIM(nv_EngineNo)            /* Total.INS.Prm  */
              wBill2.wFee         = deci(nv_Fee)                 /* ค่า Fee        */
              wBill2.wFeeamount   = deci(nv_Feeamount)           /* ค่า Fee amount */
              wBill2.wFee_orthe   = deci(nv_fee01)            .  /* ค่าอนุโลม      */   
        END.
        ELSE IF trim(nv_RecordType) = "T" THEN NEXT.
        ELSE IF trim(nv_RecordType) = ""  THEN NEXT.

        RUN proc_init.
END.  /* repeat  */
 
RUN proc_output2txt.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_output2txt C-Win 
PROCEDURE proc_output2txt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_confile = "".

/* A65-0335 */
ASSIGN
  n_binloop   = STRING(fi_binloop,"9")
  n_bindate   = STRING(fi_bindate,"99/99/9999")
  dateasof   = string(deci(SUBSTR(cbAsDat,7,2)) + 43 ) + SUBSTR(cbAsDat,4,2) + SUBSTR(cbAsDat,1,2).

IF INDEX(fiFile-Nameinput,".csv") <> 0 THEN DO:
    nv_confile = SUBSTRING(TRIM(fiFile-Nameinput),1,INDEX(fiFile-Nameinput,".csv")) + "_mat.txt".
END.
ELSE DO:
    nv_confile = "D:\TEMP\Convert70_mat.txt".
END.

OUTPUT STREAM filebill1 TO VALUE(nv_confile).

ASSIGN
    vExpCount1  = 0
    nv_sumprem  = 0
    n_wRecordno = 1.

PUT STREAM filebill1
    "H"                              FORMAT "X"      "|"      
    "00001"                          FORMAT "99999"  "|"     
    "บริษัทประกันคุ้มภัย จำกัดมหาชน" FORMAT "X(40)"  "|"       
    "KPI"                            FORMAT "X(4)"   "|" 
    dateasof                         FORMAT "X(8)"   "|" 
    "1"                              FORMAT "X"      "|"      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                        FORMAT "X"      SKIP. 

FOR EACH wBill2 USE-INDEX wBill202 WHERE wBill2.recordtyp = "D" NO-LOCK
    BREAK BY wBill2.wPolicy.
     
    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1  + 1
        nv_sumprem  = nv_sumprem  +  deci(wBill2.wtotNetprm)    . 

    PUT STREAM filebill1
        "D"                FORMAT "X"                            "|"   /* 1  Record Type      */
        n_wRecordno        FORMAT "99999"                        "|"   /* 2  Sequence no. */
        STRING(wBill2.wPolicy)     FORMAT "x(20)"                        "|"   /* 3  INS. Policy No.      */               
        wBill2.wcovcod     FORMAT "x(2)"                         "|"   /* 4  insurance Type       */                
        wBill2.wtitle      FORMAT "x(10)"                        "|"   /* 5  Customer Title Name  */              
        wBill2.wfirstname  FORMAT "x(25)"                        "|"   /* 6  Customer First Name / Company Name */ 
        wBill2.wlastname   FORMAT "x(65)"                        "|"   /* 7  Customer Last Name   */               
        wBill2.wNor_Comdat FORMAT "x(8)"                         "|"   /* 8  วันเริ่มคุ้มครอง    */               
        wBill2.wNor_Expdat FORMAT "x(8)"                         "|"   /* 9  วันสิ้นสุดคุ้มครอง  */               
        fuDeciToChar(deci(wBill2.wsuminsurce),13) FORMAT "X(13)" "|"   /* 10 Sum Insured          */
        fuDeciToChar(deci(wBill2.wNetprm),13)     FORMAT "X(13)" "|"   /* 11 Net.INS.Prm          */
        fuDeciToChar(deci(wBill2.wtotNetprm),13)  FORMAT "X(13)" "|"   /* 12 Total.INS.Prm        */                  
        wBill2.wChassis_no                        FORMAT "x(22)" "|"   /* 13 Chassis No.      */                     
        wBill2.wEngine_no                         FORMAT "x(22)" "|"   /* 14 Engine No.       */
        fuDeciToChar(deci(wBill2.wFee),5)         FORMAT "X(5)"  "|"   /* 15 ค่า Fee              */
        fuDeciToChar(deci(wBill2.wFeeamount),13)  FORMAT "X(13)" "|"   /* 16 ค่า Fee amount*/ 
        fuDeciToChar(deci(wBill2.wFee_orthe),13)  FORMAT "X(13)"       /* 17 ค่าอนุโลม     */     
        SKIP.
END.   
n_wRecordno = n_wRecordno + 1 .

PUT STREAM filebill1
    "T"                         FORMAT "X"      "|"    /*  1.*/
    n_wRecordno                 FORMAT "99999"  "|"    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  "|"    /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 

OUTPUT STREAM filebill1 CLOSE. 
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_output3 C-Win 
PROCEDURE proc_output3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wbill2. DELETE wbill2. END.

INPUT FROM VALUE (fiFile-Nameinput) .                                   
    REPEAT: 
        IMPORT DELIMITER ","
            nv_RecordType          
            nv_Sequenceno         
            nv_INS_PolicyNo       
            nv_insuranceType      
            nv_CustomerTitleName  
            nv_CustomerFirstNAME  
            nv_CustomerLastName 
            nv_comdate          
            nv_expdate          
            nv_SumInsured       
            nv_NetINSPrm       
            nv_TotalINSPrm     
            nv_ChassisNo        
            nv_EngineNo         
            nv_Fee              
            nv_Feeamount .
    
             IF TRIM(nv_RecordType) = "H"  THEN NEXT .
        ELSE IF trim(nv_RecordType) = "D"  THEN DO:
            CREATE wBill2.
            ASSIGN 
                wBill2.recordtyp      =   TRIM(nv_RecordType)         
                wBill2.sequenceno     =   TRIM(nv_Sequenceno)   
                /*--- A65-0335 ---
                wBill2.wPolicy        =   IF SUBSTRING(TRIM(nv_INS_PolicyNo),1,1) <> "0" THEN  ("0" + TRIM(nv_INS_PolicyNo)) ELSE TRIM(nv_INS_PolicyNo)  
                ------------------*/
                wBill2.wPolicy        =   TRIM(nv_Feeamount)  /*--- A65-0335 --- Policy No. ---*/
                wBill2.wtitle         =   TRIM(nv_insuranceType)  
                wBill2.wfirstname     =   TRIM(nv_CustomerTitleName)  
                wBill2.wlastname      =   TRIM(nv_CustomerFirstNAME)   
                wBill2.wNor_Comdat    =   TRIM(nv_CustomerLastName)            
                wBill2.wNor_Expdat    =   TRIM(nv_comdate)            
                wBill2.wNetprm        =   DECI(nv_expdate)          
                wBill2.wtotNetprm     =   DECI(nv_SumInsured)    
                wBill2.wChassis_no    =   TRIM(nv_NetINSPrm)  
                wBill2.wEngine_no     =   TRIM(nv_TotalINSPrm)         
                wBill2.wFee           =   DECI(nv_ChassisNo)     
                wBill2.wFeeamount     =   DECI(nv_EngineNo)    
                wBill2.wFee_orthe     =   DECI(nv_Fee). 
        END.
        ELSE IF trim(nv_RecordType) = "T" THEN NEXT.
        ELSE IF trim(nv_RecordType) = "" THEN NEXT.
    
        RUN proc_init.
    END.   /* repeat  */
    
    RUN proc_output3txt.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_output3txt C-Win 
PROCEDURE proc_output3txt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_confile = "".

/* A65-0335 */
ASSIGN
  n_binloop   = STRING(fi_binloop,"9")
  n_bindate   = STRING(fi_bindate,"99/99/9999")
  dateasof   = string(deci(SUBSTR(cbAsDat,7,2)) + 43 ) + SUBSTR(cbAsDat,4,2) + SUBSTR(cbAsDat,1,2).

IF INDEX(fiFile-Nameinput,".csv") <> 0 THEN DO:
    nv_confile = SUBSTRING(TRIM(fiFile-Nameinput),1,INDEX(fiFile-Nameinput,".csv")) + "_mat.txt".
END.
ELSE DO:
    nv_confile = "D:\TEMP\Convert72_mat.txt".
END.

OUTPUT STREAM filebill1 TO VALUE(nv_confile).

ASSIGN
    vExpCount1  = 0
    nv_sumprem  = 0
    n_wRecordno = 1.

PUT STREAM filebill1
    "H"                              FORMAT "X"       "|"      
    "00001"                          FORMAT "99999"   "|"      
    "บริษัทประกันคุ้มภัย จำกัดมหาชน" FORMAT "X(40)"   "|"       
    "KPI"                            FORMAT "X(4)"    "|" 
    dateasof                         FORMAT "X(8)"    "|"   
    "2"                              FORMAT "X"       "|"      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                        FORMAT "X"        SKIP. 

FOR EACH wBill2 USE-INDEX wBill202 WHERE wBill2.recordtyp = "D" NO-LOCK
    BREAK BY wBill2.wPolicy.

    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1  + 1
        nv_sumprem  = nv_sumprem  + (DECI(wBill2.wtotNetprm))   . 
    PUT STREAM filebill1
        "D"                                      FORMAT "X"       "|"   
        n_wRecordno                              FORMAT "99999"   "|"   
        STRING(wBill2.wPolicy)                   /*FORMAT "x(13)"   "|" */  FORMAT "X(30)" "|"  /*--- A65-0335 ---*/
        wBill2.wtitle                            FORMAT "x(10)"   "|"   
        wBill2.wfirstname                        FORMAT "x(25)"   "|"   
        wBill2.wlastname                         FORMAT "x(65)"   "|"   
        wBill2.wNor_Comdat                       FORMAT "x(8)"    "|"   
        wBill2.wNor_Expdat                       FORMAT "x(8)"    "|"   
        fuDeciToChar(deci(wBill2.wNetprm),13)    FORMAT "X(13)"   "|"                
        fuDeciToChar(deci(wBill2.wtotNetprm),13) FORMAT "X(13)"   "|"   
        wBill2.wChassis_no                       FORMAT "x(22)"   "|"   
        wBill2.wEngine_no                        FORMAT "x(22)"   "|"   
        fuDeciToChar(deci(wBill2.wFee),5)        FORMAT "X(5)"    "|"   
        fuDeciToChar(deci(wBill2.wFeeamount),13) FORMAT "X(13)"   "|"   
        fuDeciToChar(deci(wBill2.wFee_orthe),13) FORMAT "X(13)"     
        SKIP.
END. 
n_wRecordno = n_wRecordno + 1 .

PUT STREAM filebill1
    "T"                         FORMAT "X"      "|"    /*  1.*/
    n_wRecordno                 FORMAT "99999"  "|"    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  "|"    /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 
OUTPUT STREAM filebill1 CLOSE. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Test C-Win 
PROCEDURE Test :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    OUTPUT STREAM filebill9 TO VALUE(fiFile-Name1 + "_22.CSV").
    ASSIGN
        vExpCount1 = 0
        nv_sumprem = 0
        n_wRecordno = 1
        n_binloop  = ""
        n_bindate  = ""
        n_binloop  = STRING(fi_binloop,"9")
        n_bindate  = STRING(fi_bindate,"99/99/9999")
        dateasof   = STRING(n_asdat)
        dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).

    nv_freeper = IF ra_Free = 1 THEN 22 ELSE fi_freeper. /* ELSE = User ระบุเองจากหน้าจอ */

    PUT STREAM filebill9
        "H"                                  FORMAT "X"       ","      /*  1.*/
        "00001"                              FORMAT "x(5)"    ","      /*  2.*/
        "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
        "KPI"                                FORMAT "X(4)"    "," 
        dateasof                             FORMAT "X(8)"    "," 
        "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
        n_binloop                            FORMAT "X"        SKIP. 

    Loop1:
    FOR EACH wBill4 USE-INDEX wBill401 :
    
        DISPLAY  "Split Data File : " + STRING(wBill4.wsequenceno,">>>>>9") + '  ' + wBill4.wpolicy @ fi_Process WITH FRAME fr_main .
        
        ASSIGN
            n_wRecordno = n_wRecordno + 1 
            vExpCount1  = vExpCount1  + 1
            nv_sumprem  = nv_sumprem  + wBill4.wtotNetprm . 

        wBill4.wFeeamount   = (wBill4.wNetprm  * nv_freeper) / 100 .

        PUT STREAM filebill9
            "D"                FORMAT "X"                   ","   /* 1  Record Type         */
            n_wRecordno        FORMAT "99999"               ","   /* 2  Sequence no.        */
            wBill4.wPolicy     FORMAT "x(20)"               ","   /* 3  INS. Policy No.     */               
            wBill4.wSckno      FORMAT "x(20)"               ","   /* 3  INS. Policy No.     */               
            wBill4.wcovcod     FORMAT "x(2)"                ","   /* 4  insurance Type      */                
            wBill4.wtitle      FORMAT "x(10)"               ","   /* 5  Customer Title Name */              
            wBill4.wfirstname  FORMAT "x(25)"               ","   /* 6  Customer First Name */ 
            wBill4.wlastname   FORMAT "x(65)"               ","   /* 7  Customer Last Name  */               
            wBill4.wNor_Comdat FORMAT "x(8)"                ","   /* 8  วันเริ่มคุ้มครอง    */               
            wBill4.wNor_Expdat FORMAT "x(8)"                ","   /* 9  วันสิ้นสุดคุ้มครอง  */               
            deci(wBill4.wSuminsurce) FORMAT ">>>>>>>>9.99-" ","  /* 11  Sum Insured         */
            deci(wBill4.wNetprm)     FORMAT ">>>>>>>>9.99-" ","  /* 12  Net.INS.Prm         */
            deci(wBill4.wTotNetprm)  FORMAT ">>>>>>>>9.99-" ","  /* 13  Total.INS.Prm       */
            wBill4.wChassis_no       FORMAT "x(30)"         ","  /* 14  Chassis No.         */
            wBill4.wEngine_no        FORMAT "x(30)"         ","  /* 15  Engine No.          */
            deci(nv_freeper)         FORMAT ">>>>>>>>9.99-" ","  /* 16  ค่า Fee             */
            deci(wBill4.wFeeamount)  FORMAT ">>>>>>>>9.99-" ","  /* 17  ค่า Fee amount      */
            deci(wBill4.wFee_orthe)  FORMAT ">>>>>>>>9.99-" ","  /* 18  ค่าอนุโลม           */
            wBill4.wacno             FORMAT "X(10)"         "," 
            wBill4.wBrand            FORMAT "X(50)"          
            SKIP.

        
        

    END.      /* for each wBill4 */
    
    n_wRecordno = n_wRecordno + 1 .
    
    PUT STREAM filebill9
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    OUTPUT STREAM filebill9 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuDateToChar C-Win 
FUNCTION fuDateToChar RETURNS CHARACTER
  (vDate AS DATE) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

  DEFINE VAR vBillDate  AS CHAR.

  IF vDate <> ? THEN
       vBillDate = STRING( YEAR(vDate),"9999") +
                   STRING(MONTH(vDate),"99")   +
                   STRING(  DAY(vDate),"99").
  ELSE vBillDate = "".

  RETURN vBillDate.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuDeciToChar C-Win 
FUNCTION fuDeciToChar RETURNS CHARACTER
  ( vDeci   AS DECIMAL, vCharno AS INTEGER ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VAR vChar AS CHAR.
    DEFINE VAR c     AS CHAR.
    DEFINE VAR c2    AS CHAR.
    DEFINE VAR c3    AS CHAR.

    c  = TRIM(STRING(vDeci,"->>>>>>>>>>9.99")).  /* จำนวนตัวเลขรวมจุด เครื่องหมายลบ*/
    c2 = SUBSTR(c,1, LENGTH(c) - 3 ).  /* เครื่องหมายลบ รวม ตัวเลข */
    c3 = SUBSTR(c, LENGTH(c) - 1, 2 ).  /* ตัวเลขหลัง จุดทศนิยม  2 ตำแหน่ง*/

    vChar = FILL("0",vCharNo - LENGTH(c) + 1 ) + c2 + c3.

/*
    vChar = SUBSTR(STRING(vDeci,"99999999.99"),1,INDEX(STRING(vDeci,"99999999.99"),".") - 1) +
                  SUBSTR(STRING(vDeci,"99999999.99"),INDEX(STRING(vDeci,"99999999.99"),".") + 1,2).
*/

    RETURN vChar.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuFindAcno C-Win 
FUNCTION fuFindAcno RETURNS LOGICAL
  ( nv_accode AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    FIND FIRST xmm600 WHERE  xmm600.acno = nv_accode NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL xmm600 THEN
         RETURN TRUE.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuFindBranch C-Win 
FUNCTION fuFindBranch RETURNS CHARACTER
  ( nv_branch AS CHAR ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

   DEFINE VAR nv_brndes AS CHAR INIT "".

   FIND xmm023 WHERE xmm023.branch = nv_branch NO-LOCK NO-ERROR NO-WAIT.
   IF AVAILABLE xmm023 THEN
       nv_brndes = TRIM(CAPS(xmm023.bdes)).

   RETURN nv_brndes.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( Y AS INTEGER) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
    DEFINE VAR vLeapYear  AS LOGICAL.

    vLeapYear = IF (y MOD 4 = 0) AND ((y MOD 100 <> 0) OR (y MOD 400 = 0))
                THEN TRUE ELSE FALSE.

    RETURN vLeapYear.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  ( vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/

    DEFINE VAR vNum AS INTE INITIAL 0.

    IF MONTH(vDate) = 1   OR  MONTH(vDate) = 3    OR
       MONTH(vDate) = 5   OR  MONTH(vDate) = 7    OR
       MONTH(vDate) = 8   OR  MONTH(vDate) = 10   OR
       MONTH(vDate) = 12 THEN DO:

        vNum = 31.
    END.

    IF MONTH(vDate) = 4   OR  MONTH(vDate) = 6    OR
       MONTH(vDate) = 9   OR  MONTH(vDate) = 11   THEN DO:

        vNum = 30.
    END.

    IF MONTH(vDate) = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN 
             vNum = 29. 
        ELSE vNum = 28.
    END.

    RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

