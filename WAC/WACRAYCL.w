&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          stat             PROGRESS
*/
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
CREATE BY       : Kridtiya i.   21/05/2013   [A56-0176]
Program name    : การส่งข้อมูล Text File เพื่อวางบิลเรียกเก็บเงินค่าเบี้ยฯ จากบมจ. อยุธยา แคปปิต
                  เพิ่มโปรแกรม วางบิล ทาง อยุธยา แคปปิตอล ออโต้ลีส ( AYCAL) 
Program id      : wacพaycl.w                
Database connect: sicfn,sic_test,stat  
modify by       : Kridtiya i. A58-0094 add Producer : A0M0012    
Modify by       : Kridtiya i. A59-0362 date. 10/11/2016 เพิ่มคำสั่งคืนค่าฐานข้อมูล     
Modify by       : Kridtiya i. A59-0597 date. 22/12/2016 เพิ่ม การรวมเบี้ย comp สำหรับ 70  
/* Modify By : Porntiwa T. A60-0267  Date 14/09/2018
               ปรับขยายเลข Document จาก 7 เป็น 10 หลัก เพื่อนำเข้าระบบให้ถูกต้อง                  */    
---------------------------------------------------------------------------*/
/***************************************************************************/
CREATE WIDGET-POOL.                                                        
/* ***************************  Definitions  **************************    */
/* Parameters Definitions ---                                              */
DEFINE SHARED VAR n_User    AS CHAR.                                   
DEFINE SHARED VAR n_passwd  AS CHAR.                                   
/* Local Variable Definitions ---                                          */
DEFINE        VAR nv_User   AS CHAR NO-UNDO.                                                
DEFINE        VAR nv_pwd    AS CHAR NO-UNDO.                                                 
/* DEF VAR pRowIns AS ROWID.                                               */
DEFINE        VAR cUpdate   AS CHAR.                                                                     
DEFINE        VAR pComp     AS CHAR.                                                                          
DEFINE        VAR gComp     AS CHAR.                                                                         
                                                                         
DEFINE NEW SHARED VAR n_branch      AS CHAR FORMAT "X(2)".                                       
DEFINE NEW SHARED VAR n_branch2     AS CHAR FORMAT "X(2)".                                        
DEFINE            VAR n_asdat       AS DATE FORMAT "99/99/9999".                                 
DEFINE            VAR n_bindate     AS CHAR FORMAT "99/99/9999".                                  
DEFINE            VAR n_binloop     AS CHAR FORMAT "99".                                          
DEFINE            VAR n_OutputFile1 AS CHAR.                                                      
DEFINE            VAR n_bdes        AS CHAR FORMAT "X(50)".     /*branch name*/                   
DEFINE            VAR n_chkBname    AS CHAR FORMAT "X(1)".      /* branch-- chk button 1-2 */     
DEFINE            VAR nv_norpol     AS CHAR FORMAT "X(25)".                                       
DEFINE            VAR nv_pol72      AS CHAR FORMAT "X(16)".                                       
DEFINE            VAR nv_insure     AS CHAR FORMAT "X(50)".                                       
DEFINE            VAR nv_job_nr     AS CHAR FORMAT "X(1)".                                        
DEFINE            VAR nv_subins     AS CHAR FORMAT "X(4)".                                        
DEFINE            VAR nv_comp_sub   AS CHAR FORMAT "X(4)".                                        
/*DEFINE            VAR nv_poltyp70   AS CHAR FORMAT "X(3)".      /* PolType Commission Special */  
DEFINE            VAR nv_poltyp72   AS CHAR FORMAT "X(3)". */     /* PolType Commission Special */  
DEFINE            VAR nv_remark         AS CHAR FORMAT "X(49)".                                       
DEFINE            VAR nv_comdat72       AS DATE FORMAT "99/99/9999".                                  
DEFINE            VAR nv_expdat72       AS DATE FORMAT "99/99/9999".                                  
DEFINE            VAR nv_nor_si         AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_comp_si        AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_Netprm         AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_grossPrem      AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_grossPrem_comp AS DECI FORMAT "->>,>>>,>>9.99".                          
DEFINE            VAR nv_netamount      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                   
DEFINE            VAR nv_totalprm       AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                   
DEFINE            VAR nv_tax_per        AS DECI FORMAT "->>9.99" INIT 0.                          
DEFINE            VAR nv_stamp_per      AS DECI FORMAT "->>9.99" INIT 0.                          
/*DEFINE          VAR nv_comm_per70     AS DECI FORMAT ">9.999"  INIT 0.                          
DEFINE            VAR nv_comm_per72     AS DECI FORMAT ">9.999"  INIT 0. */                         
DEFINE            VAR nv_nor_net      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_nor_prm      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_nor_com      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_stamp70      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_vat70        AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_vat_comm70   AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_tax3_comm70  AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_comp_net     AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_comp_prm     AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_comp_com     AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_stamp72      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_vat72        AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_vat_comm72   AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_tax3_comm72  AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nv_freeper      AS DECI FORMAT "->>,>>>,>>9.99" INIT 0.                               
DEFINE            VAR nvfiFile-Name2  AS CHAR FORMAT "x(30)" INIT "".    
DEFINE            VAR nv_sckno        AS CHAR FORMAT "x(30)" INIT "".  
DEFINE            VAR n_wRecordno     AS DECI FORMAT "99999" INIT 0.  
DEFINE            VAR dateasof        AS CHAR INIT "" .
DEFINE TEMP-TABLE wBill
    FIELD producttype   AS CHAR FORMAT "x(1)" 
    FIELD asofdate      AS CHAR FORMAT "x(8)"
    FIELD insurcename   AS CHAR FORMAT "x(40)"
    FIELD insurcecode   AS CHAR FORMAT "x(4)" 
    FIELD product       AS CHAR FORMAT "x(5)"
    FIELD companyname   AS CHAR FORMAT "x(5)"
    FIELD recordtyp     AS CHAR FORMAT "x"
    FIELD sequenceno    AS CHAR FORMAT "x(5)"
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
    FIELD wFee          AS DECI FORMAT "->>>,>>>,>>9.99"  /*16  ค่า Fee            */                             
    FIELD wFeeamount    AS DECI FORMAT "->>>,>>>,>>9.99"  /*17  ค่า Fee amount     */                   
    FIELD wFee_orthe    AS DECI FORMAT "->>>,>>>,>>9.99"  /*18  ค่าอนุโลม          */                         
    FIELD wAcno         AS CHAR FORMAT "X(10)"                                  
    FIELD wEndno        AS CHAR FORMAT "X(12)"
    FIELD wTrnty1       AS CHAR FORMAT "X"
    FIELD wTrnty2       AS CHAR FORMAT "X"
    FIELD wDocno        AS CHAR FORMAT /*"X(7)"*/ "X(10)" /* A60-0267  */
    FIELD wRecordno     AS INTE FORMAT "999999"
    FIELD wNorpol       AS CHAR FORMAT "X(25)" 
    INDEX wBill01  IS UNIQUE PRIMARY
          wAcno wPolicy wEndno wTrnty1 wTrnty2 wDocno ASCENDING
    INDEX wBill02 wRecordno
    INDEX wBill03 wNor_Comdat wNorpol 
    /*INDEX wBill04 wPolicy    .*//*Add kridtiya i. A59-0362*/
    INDEX wBill04 wPoltype.       /*Add kridtiya i. A59-0362*/

DEFINE STREAM filebill1.
DEFINE STREAM filebill2.
DEFINE VAR vExpCount1   AS INTE INIT 0.
DEFINE VAR vCountRec    AS INTE INIT 0.    
DEFINE VAR vBackUp      AS CHAR.
DEFINE VAR vAcProc_fil  AS CHAR.
DEFINE VAR nv_strdate   AS CHAR.
DEFINE VAR nv_enddate   AS CHAR.
DEFINE VAR nv_accode    AS CHAR FORMAT "X(10)".
DEFINE VAR nv_sumfile   AS CHAR FORMAT "X(100)".
DEFINE VAR nv_sumprem   AS DECI FORMAT ">>>,>>>,>>>,>>9.99".
/*DEFINE VAR nv_sumcomp   AS DECI FORMAT ">>>,>>>,>>>,>>9.99".*/
/*DEFINE VAR nv_sum       AS DECI FORMAT ">>>,>>>,>>>,>>9.99".*/
DEFINE VAR nv_fptr      AS RECID.
DEFINE VAR nv_rec100    AS RECID.  
DEFINE VAR nv_grossPrem_com1 AS DECI FORMAT "->>,>>>,>>9.99".   
DEFINE VAR nv_row   as  int  init 0.
DEFINE VAR nv_cnt   as  int  init  0.
DEF  stream  ns2.
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
DEFINE VAR n_cha_no     LIKE uwm301.cha_no.
DEFINE VAR n_eng_no     LIKE uwm301.eng_no.
DEFINE VAR n_vehreg     LIKE uwm301.vehreg.
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
    FIELD wFee          AS DECI FORMAT "->>>,>>>,>>9.99"    /*16  ค่า Fee            */                                          
    FIELD wFeeamount    AS DECI FORMAT "->>>,>>>,>>9.99"    /*17  ค่า Fee amount     */
    FIELD wFee_orthe    AS DECI FORMAT "->>>,>>>,>>9.99"    /*18  ค่าอนุโลม          */   
    INDEX wBill202 wPolicy .
DEFINE WORKFILE winsur
    FIELD compno   AS CHAR FORMAT "x(20)"   
    FIELD FName    AS CHAR FORMAT "x(5)"  
    FIELD Branch   AS CHAR FORMAT "x(2)"  
    FIELD InsNo    AS CHAR FORMAT "x(3)"   
    FIELD deci1    AS CHAR FORMAT "x(5)" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME brinsure

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES Insure

/* Definitions for BROWSE brinsure                                      */
&Scoped-define FIELDS-IN-QUERY-brinsure Insure.CompNo Insure.FName ~
Insure.Branch Insure.InsNo Insure.Deci1 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brinsure 
&Scoped-define QUERY-STRING-brinsure FOR EACH Insure NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brinsure OPEN QUERY brinsure FOR EACH Insure NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brinsure Insure
&Scoped-define FIRST-TABLE-IN-QUERY-brinsure Insure


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fiBranch fiBranch2 fi_producer bu_add bu_clr ~
bu_del bu_delall fi_trandatF fi_trandatT cbAsDat fi_binloop fi_bindate ~
fibdes fiFile-Name1 Btn_OK fiFile-Nameinput bu_file ra_filetype ~
fi_outputcon Btn_conver fiCompNo fiCompNo2 bu_query fibdes2 fi_import ~
bu_file-2 bu_import fi_comoutput bu_import-2 fiInComp fiInBranch fi_process ~
fiFName fi_freeper btninadd btnInUpdate btnInDelete btnInOK btnInCancel ~
btnInDeleteall brinsure se_producer Btn_Exit buBranch buBranch2 RECT-5 ~
RECT-6 RECT-7 RECT-8 RECT-609 RECT-610 RECT-611 RECT-1 RECT-3 RECT-9 RECT-2 ~
RECT-613 RECT-614 
&Scoped-Define DISPLAYED-OBJECTS fiBranch fiBranch2 fi_producer fi_trandatF ~
fi_trandatT cbAsDat fi_binloop fi_bindate fibdes fiFile-Name1 ~
fiFile-Nameinput ra_filetype fi_outputcon fiCompNo fiCompNo2 fibdes2 ~
fi_import fi_comoutput fiInComp fiInBranch fi_process fiFName fi_freeper ~
se_producer 

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
DEFINE BUTTON btninadd 
     LABEL "ADD" 
     SIZE 10 BY .95
     FONT 6.

DEFINE BUTTON btnInCancel 
     LABEL "CANCEL" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON btnInDelete 
     LABEL "DEL" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON btnInDeleteall 
     LABEL "DEL ALL" 
     SIZE 9.5 BY 1
     FONT 6.

DEFINE BUTTON btnInOK 
     LABEL "SAVE" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON btnInUpdate 
     LABEL "EDIT" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON Btn_conver AUTO-GO 
     LABEL "CONV" 
     SIZE 9 BY 1
     BGCOLOR 8 FONT 2.

DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 10 BY 1
     BGCOLOR 8 FONT 2.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 9 BY 1
     BGCOLOR 8 FONT 2.

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

DEFINE BUTTON bu_clr 
     LABEL "CLR" 
     SIZE 6.5 BY .95.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6.5 BY .95.

DEFINE BUTTON bu_delall 
     LABEL "DELAll" 
     SIZE 6.5 BY .95.

DEFINE BUTTON bu_file 
     LABEL "...." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_file-2 
     LABEL "...." 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_import 
     LABEL "IMP" 
     SIZE 5 BY .95.

DEFINE BUTTON bu_import-2 
     LABEL "OUT" 
     SIZE 5 BY .95.

DEFINE BUTTON bu_query 
     IMAGE-UP FILE "I:/Safety/WALP10/WIMAGE/flipu.bmp":U
     LABEL "OK" 
     SIZE 8 BY .95.

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U INITIAL ? 
     VIEW-AS COMBO-BOX INNER-LINES 5
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 36 BY .95
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 36 BY .95
     BGCOLOR 18 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiCompNo2 AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Nameinput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFName AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInBranch AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInComp AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bindate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_binloop AS INTEGER FORMAT "9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comoutput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 41 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_freeper AS DECIMAL FORMAT "->>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_import AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outputcon AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 120 BY .95
     BGCOLOR 172 FGCOLOR 30 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trandatF AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_trandatT AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE ra_filetype AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Convert file_CSV 70 to Text ", 1,
"Convert file_CSV 72 to Text ", 2
     SIZE 62.67 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21 BY 14.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 60.5 BY 13.1
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 1.57
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 5 GRAPHIC-EDGE    
     SIZE 132.5 BY 22
     BGCOLOR 173 FGCOLOR 0 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.5 BY 1.67
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-609
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-610
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.52
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-611
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-613
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.33 BY 1.67
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-614
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.67 BY 1.67
     BGCOLOR 155 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.57
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.5 BY 1.67
     BGCOLOR 2 .

DEFINE VARIABLE se_producer AS CHARACTER 
     VIEW-AS SELECTION-LIST SINGLE SCROLLBAR-VERTICAL 
     SIZE 30 BY 4.19
     BGCOLOR 15  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brinsure FOR 
      Insure SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brinsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brinsure C-Win _STRUCTURED
  QUERY brinsure NO-LOCK DISPLAY
      Insure.CompNo COLUMN-LABEL "Company" FORMAT "X(10)":U WIDTH 8.33
      Insure.FName COLUMN-LABEL "IDNo." FORMAT "X(10)":U WIDTH 7.5
      Insure.Branch FORMAT "X(2)":U WIDTH 7.17
      Insure.InsNo COLUMN-LABEL "Poltyp." FORMAT "X(7)":U
      Insure.Deci1 COLUMN-LABEL "  Free%" FORMAT "->>>,>>>,>>9.99":U
            WIDTH 10.5
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 47 BY 8
         BGCOLOR 15  ROW-HEIGHT-CHARS .5.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fiBranch AT ROW 3.14 COL 22.83 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 4.24 COL 22.83 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 6.48 COL 22.83 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 6.86 COL 58.33
     bu_clr AT ROW 8.33 COL 58.33
     bu_del AT ROW 9.91 COL 58.33
     bu_delall AT ROW 11.24 COL 58.33
     fi_trandatF AT ROW 12.62 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_trandatT AT ROW 12.62 COL 50.5 COLON-ALIGNED NO-LABEL
     cbAsDat AT ROW 13.71 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_binloop AT ROW 14.86 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_bindate AT ROW 15.95 COL 24.5 COLON-ALIGNED NO-LABEL
     fibdes AT ROW 3.14 COL 32.17 COLON-ALIGNED NO-LABEL
     fiFile-Name1 AT ROW 17.71 COL 25.33 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 17.71 COL 97.5
     fiFile-Nameinput AT ROW 21.48 COL 25 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 21.48 COL 90.83
     ra_filetype AT ROW 20.24 COL 3.5 NO-LABEL
     fi_outputcon AT ROW 22.67 COL 25 COLON-ALIGNED NO-LABEL
     Btn_conver AT ROW 22.1 COL 97.33
     fiCompNo AT ROW 3.14 COL 81.67 COLON-ALIGNED NO-LABEL
     fiCompNo2 AT ROW 3.14 COL 98.83 COLON-ALIGNED NO-LABEL
     bu_query AT ROW 3.14 COL 117.67
     fibdes2 AT ROW 4.24 COL 32.17 COLON-ALIGNED NO-LABEL
     fi_import AT ROW 4.24 COL 81.5 COLON-ALIGNED NO-LABEL
     bu_file-2 AT ROW 4.24 COL 121.17
     bu_import AT ROW 4.24 COL 126
     fi_comoutput AT ROW 5.33 COL 81.5 COLON-ALIGNED NO-LABEL
     bu_import-2 AT ROW 5.33 COL 126
     fiInComp AT ROW 6.48 COL 75 COLON-ALIGNED NO-LABEL
     fiInBranch AT ROW 6.48 COL 87.67 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 19.1 COL 1.5 COLON-ALIGNED NO-LABEL
     fiFName AT ROW 6.48 COL 98.67 COLON-ALIGNED NO-LABEL
     fi_freeper AT ROW 6.48 COL 110.33 COLON-ALIGNED NO-LABEL
     btninadd AT ROW 7.71 COL 121
     btnInUpdate AT ROW 8.86 COL 121
     btnInDelete AT ROW 10.05 COL 121
     btnInOK AT ROW 11.24 COL 121
     btnInCancel AT ROW 12.38 COL 121
     btnInDeleteall AT ROW 13.81 COL 121.17
     brinsure AT ROW 7.62 COL 73
     se_producer AT ROW 7.62 COL 24.67 NO-LABEL
     Btn_Exit AT ROW 22.1 COL 111
     buBranch AT ROW 3.14 COL 30.33
     buBranch2 AT ROW 4.24 COL 30.33
     " รอบของการวางบิล" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 14.86 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "File Imp :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 4.24 COL 73
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "Trandate_To:" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 12.62 COL 41
          BGCOLOR 18 FGCOLOR 0 
     " Producer Code" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 6.48 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " As of Date (Statement)":30 VIEW-AS TEXT
          SIZE 19 BY .95 TOOLTIP "วันที่ออกรายงาน" AT ROW 13.71 COL 4
          BGCOLOR 19 FGCOLOR 0 
     " Branch To":10 VIEW-AS TEXT
          SIZE 19 BY .95 TOOLTIP "ถึงสาขา" AT ROW 4.24 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " Branch From":25 VIEW-AS TEXT
          SIZE 19 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 3.14 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "branch:" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 6.48 COL 82.33
          BGCOLOR 20 FGCOLOR 0 FONT 6
     "No." VIEW-AS TEXT
          SIZE 3.5 BY .95 AT ROW 6.48 COL 73
          BGCOLOR 20 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "  การส่งข้อมูล Text File เพื่อวางบิลเรียกเก็บเงินค่าเบี้ยฯ จากบมจ. อยุธยา แคปปิต" VIEW-AS TEXT
          SIZE 128 BY 1 AT ROW 1.24 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Line:" VIEW-AS TEXT
          SIZE 5.17 BY .95 AT ROW 6.48 COL 95
          BGCOLOR 20 FGCOLOR 0 FONT 6
     "Company:" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 3.14 COL 73
          BGCOLOR 20 FGCOLOR 0 FONT 6
     "Free%" VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 6.48 COL 106.17
          BGCOLOR 20 FGCOLOR 0 FONT 6
     "รอบวันของการวางบิล" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 15.95 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "    Trandate_From:" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 12.62 COL 4
          BGCOLOR 20 FGCOLOR 0 FONT 6
     " Output To TextFile" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 17.71 COL 4.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "File Out :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 5.33 COL 73
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "         Output File" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 22.67 COL 4.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "          Input file" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 21.48 COL 4.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     RECT-5 AT ROW 2.67 COL 1
     RECT-6 AT ROW 17.33 COL 95.33
     RECT-7 AT ROW 21.71 COL 109.5
     RECT-8 AT ROW 1 COL 1
     RECT-609 AT ROW 6.52 COL 57
     RECT-610 AT ROW 8.05 COL 57
     RECT-611 AT ROW 9.62 COL 57
     RECT-1 AT ROW 2.91 COL 3
     RECT-3 AT ROW 17.43 COL 3
     RECT-9 AT ROW 21.71 COL 95.33
     RECT-2 AT ROW 2.91 COL 72
     RECT-613 AT ROW 13.48 COL 120.17
     RECT-614 AT ROW 11 COL 57
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "wacraycl - การส่งข้อมูล Text File เพื่อวางบิลบมจ. อยุธยา แคปปิตอล ออโต้ลีส( AY"
         HEIGHT             = 24
         WIDTH              = 133.17
         MAX-HEIGHT         = 26.67
         MAX-WIDTH          = 153.33
         VIRTUAL-HEIGHT     = 26.67
         VIRTUAL-WIDTH      = 153.33
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
IF NOT C-Win:LOAD-ICON("i:/safety/walp10/wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: i:/safety/walp10/wimage/iconhead.ico"
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
/* BROWSE-TAB brinsure btnInDeleteall fr_main */
ASSIGN 
       brinsure:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brinsure
/* Query rebuild information for BROWSE brinsure
     _TblList          = "stat.Insure"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > stat.Insure.CompNo
"Insure.CompNo" "Company" "X(10)" "character" ? ? ? ? ? ? no ? no no "8.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > stat.Insure.FName
"Insure.FName" "IDNo." "X(10)" "character" ? ? ? ? ? ? no ? no no "7.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > stat.Insure.Branch
"Insure.Branch" ? ? "character" ? ? ? ? ? ? no ? no no "7.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > stat.Insure.InsNo
"Insure.InsNo" "Poltyp." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > stat.Insure.Deci1
"Insure.Deci1" "  Free%" ? "decimal" ? ? ? ? ? ? no ? no no "10.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE brinsure */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacraycl - การส่งข้อมูล Text File เพื่อวางบิลบมจ. อยุธยา แคปปิตอล ออโต้ลีส( AY */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacraycl - การส่งข้อมูล Text File เพื่อวางบิลบมจ. อยุธยา แคปปิตอล ออโต้ลีส( AY */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brinsure
&Scoped-define SELF-NAME brinsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brinsure C-Win
ON VALUE-CHANGED OF brinsure IN FRAME fr_main
DO:
    FIND CURRENT Insure  NO-LOCK NO-ERROR. 
    RUN pdDispIns IN THIS-PROCEDURE. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btninadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btninadd C-Win
ON CHOOSE OF btninadd IN FRAME fr_main /* ADD */
DO:
  DEF BUFFER bIns FOR Insure.
  DEF VAR vInsNo    AS INTE INIT 0.
  DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
  DEF VAR vInsFirst AS CHAR.   
  DEF VAR v_InsNo   AS char.
  DEF VAR nv_Insno  AS CHAR.
  DEF VAR nv_vinsc  AS CHAR.
  DEF VAR insno     AS CHAR.
  DEF VAR insno1    AS CHAR.
  DEF VAR n_Insno   AS INT.
  gComp = fiCompno2.
  /*RUN PDEnable IN THIS-PROCEDURE.*/
  ENABLE 
      fiCompNo2   
      fiInComp   
      fiInBranch 
      fiFName    
      fi_freeper 
      btnInOK     btnInCancel 
      WITH FRAME fr_main.
  ASSIGN 
      cUpdate    = "ADD"
      fiIncomp   = nv_InsNo
      fiInComp   = "" 
      fiInBranch = "" 
      fiFName    = ""
      fi_freeper = 0
      /*btnFirst:Sensitive  = No
      btnPrev:Sensitive   = No
      btnNext:Sensitive   = No
      btnLast:Sensitive   = No*/
      btnInAdd:Sensitive    = No
      btnInUpdate:Sensitive = No
      btnInDelete:Sensitive = No  
      btnInOK:Sensitive     = Yes
      btnInCancel:Sensitive = Yes.
  DISPLAY 
      fiCompNo2
      fiInComp
      fiInBranch
      fiFName
      fi_freeper      
      WITH FRAME fr_main.
  APPLY "ENTRY" TO fiInComp IN FRAME fr_main .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInCancel C-Win
ON CHOOSE OF btnInCancel IN FRAME fr_main /* CANCEL */
DO:
  RUN ProcDisable IN THIS-PROCEDURE.
  ASSIGN 
    /*btnFirst:Sensitive IN FRAM fr_main = Yes
    btnPrev:Sensitive  IN FRAM fr_main = Yes
    btnNext:Sensitive  IN FRAM fr_main = Yes
    btnLast:Sensitive  IN FRAM fr_main = Yes*/
     
    btnInAdd:Sensitive    IN FRAM fr_main = Yes
    btnInUpdate:Sensitive IN FRAM fr_main = Yes
    btnInDelete:Sensitive IN FRAM fr_main = Yes
         
    btnInOK:Sensitive     IN FRAM fr_main = No
    btnInCancel:Sensitive IN FRAM fr_main = No.
    brInsure:Sensitive IN FRAM fr_main = Yes.
    
  APPLY "VALUE-CHANGED" TO brInsure IN FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInDelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDelete C-Win
ON CHOOSE OF btnInDelete IN FRAME fr_main /* DEL */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ต้องการลบข้อมูลรายการ " + TRIM (Insure.Fname) + " " + string(Insure.deci1) + " ?"  UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูล Free%".   
    IF logAns THEN DO:  
        GET CURRENT brInsure EXCLUSIVE-LOCK.
        DELETE Insure.
        MESSAGE "ลบข้อมูลFree% เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.
    RUN PdUpdateQ.

    APPLY "VALUE-CHANGED" TO brInsure IN FRAM fr_main. 
    /*RUN ProcDisable IN THIS-PROCEDURE.*/

DISABLE 
   fiCompNo2    
   fiInComp    
   fiInBranch  
   fiFName     
   fi_freeper  

  WITH FRAME frinsure.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInDeleteall
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInDeleteall C-Win
ON CHOOSE OF btnInDeleteall IN FRAME fr_main /* DEL ALL */
DO:
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ท่านต้องการลบข้อมูลทั้งหมดของ  " + fiCompNo2 + " ? " UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลทั้งหมด".   
    IF logAns THEN DO:  
        /*GET CURRENT brInsure EXCLUSIVE-LOCK.*/
        FOR EACH Insure WHERE insure.compno = fiCompNo2 .
            DELETE Insure.
        END.
        MESSAGE "ลบข้อมูลทั้งหมด เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.
    /*FIND FIRST insure USE-INDEX Insure03  WHERE Insure.CompNo = fiCompNo2  NO-LOCK NO-ERROR .
    IF NOT AVAIL insure THEN DO:
        DISPLAY 
            ""  @ fiInComp  
            ""  @ fiInBranch
            ""  @ fiFName
            ""  @ fi_Freeper
            WITH FRAME fr_main.
        MESSAGE "Not found Company ???" VIEW-AS ALERT-BOX WARNING.
        APPLY "Entry" TO fiCompNo.
        RETURN NO-APPLY.
    END. */
    OPEN QUERY brInsure  FOR EACH stat.Insure USE-INDEX Insure03 NO-LOCK  
        WHERE stat.Insure.CompNo = fiCompNo2
        BY stat.Insure.fname .
        RUN pdDispIns.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAM fr_main. 
    /*RUN ProcDisable IN THIS-PROCEDURE.*/
    DISABLE 
        fiCompNo2    
        fiInComp    
        fiInBranch  
        fiFName     
        fi_freeper 
  WITH FRAME frinsure.  
  APPLY "Entry" TO fiCompNo2.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInOK C-Win
ON CHOOSE OF btnInOK IN FRAME fr_main /* SAVE */
DO:
    ASSIGN
        FRAME fr_main fiCompNo   
        FRAME fr_main fiInComp   
        FRAME fr_main fiInBranch 
        FRAME fr_main fiFName    
        FRAME fr_main fi_freeper 
        /*FRAME fr_main fiInAddr1
        FRAME fr_main fiInAddr2
        FRAME fr_main fiInAddr3
        FRAME fr_main fiInAddr4
        FRAME fr_main fiInTelNo*/    .
    /*IF fivatcode NE ""   THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = fivatcode NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO: 
            ASSIGN fivatcode = "".
            MESSAGE "Not found vatcode in table xmm600 Please insert again!!!!!" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fivatcode IN FRAME fr_main.
        END.
    END.*/
    /*kridtiya i. A53-0182 ตรวจสอบค่า Producer code*/
    
    /*kridtiya i. A53-0182 ตรวจสอบค่า Producer code*/
    IF (fiInBranch = ""  OR fiIncomp  = "" ) THEN DO:
            MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบข้อมูลใหม่ "  VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fiIncomp IN FRAME fr_main.
    END.
    ELSE DO:
        RUN ProcUpdateInsure IN THIS-PROCEDURE (INPUT cUpdate).
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInUpdate C-Win
ON CHOOSE OF btnInUpdate IN FRAME fr_main /* EDIT */
DO:
    /*RUN PdEnable IN THIS-PROCEDURE.*/
    ENABLE 
        fiCompNo2
        fiInComp
        fiInBranch
        fiFName
        fi_freeper
        btnInOK     btnInCancel 
        WITH FRAME fr_main.
    ASSIGN
        fiIncomp 
        fiInBranch 
        fiFName 
        fi_freeper
        cUpdate = "UPDATE"
        
       /* btnFirst:SENSITIVE IN FRAME fr_main = No
        btnPrev:Sensitive  IN FRAME fr_main = No
        btnNext:Sensitive  IN FRAME fr_main = No
        btnLast:Sensitive  IN FRAME fr_main = No*/
        btnInAdd:Sensitive    IN FRAME fr_main = No
        btnInUpdate:Sensitive IN FRAME fr_main = No
        btnInDelete:Sensitive IN FRAME fr_main = No  
        btnInOK:Sensitive     IN FRAME fr_main = Yes
        btnInCancel:Sensitive IN FRAME fr_main = Yes
        brInsure:Sensitive IN FRAME fr_main = No.
    RUN PdDispIns IN THIS-PROCEDURE.
    APPLY "ENTRY" TO fiIncomp IN FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_conver
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_conver C-Win
ON CHOOSE OF Btn_conver IN FRAME fr_main /* CONV */
DO:
    For each  wBill2 :
        DELETE  wBill2.
    END.
    
    RUN proc_init.
    
    IF      ra_filetype = 1 THEN RUN proc_output2.  /*convert 70*/
    ELSE IF ra_filetype = 2 THEN RUN proc_output3.  /*convert 72*/

    message "Export File  Complete"  view-as alert-box.
    
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
ON CHOOSE OF Btn_OK IN FRAME fr_main /* OK */
DO:
    ASSIGN
        tim01          = STRING(TIME,"HH:MM:SS")  
        fibranch       fibranch
        fibranch2      fibranch2   
        fiFile-Name1   fiFile-Name1
        n_branch       =  fiBranch
        n_branch2      =  fiBranch2
        n_asdat        =  DATE(INPUT cbAsDat)
        n_OutputFile1  =  fiFile-Name1  .
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
    RUN pdproc.
    RUN pdo3.
    RUN pd03_csv.
    DISPLAY "Export Data Complete...." @ fi_process WITH FRAME {&FRAME-NAME}.
    ASSIGN nv_enddate = STRING(TODAY,"99/99/9999") + " (" +
        STRING(TIME ,"HH:MM:SS")   + " น.)"
        tim02         = STRING(TIME,"HH:MM:SS")
        tim02_1       = 0
        tim02_2       = 0
        tim02_3       = 0 .
    IF  DECI(SUBSTR(tim02,7,2)) < DECI(SUBSTR(tim01,7,2))  THEN DO:
        ASSIGN tim02_3 =  DECI(SUBSTR(tim02,7,2)) + 60 .
        IF DECI(SUBSTR(tim02,4,2)) < DECI(SUBSTR(tim01,4,2))    THEN DO:
            ASSIGN tim02_2 = DECI(SUBSTR(tim02,4,2)) + 60 - 1
                tim02_1    = DECI(SUBSTR(tim02,1,2)) - 1.
        END.
        ELSE 
            ASSIGN  tim02_2 = DECI(SUBSTR(tim02,4,2))  - 1
                tim02_1     = DECI(SUBSTR(tim02,1,2)) .
    END.
    ELSE DO: 
        IF DECI(SUBSTR(tim02,4,2)) < DECI(SUBSTR(tim01,4,2)) THEN 
            ASSIGN tim02_3 =  DECI(SUBSTR(tim02,7,2))
            tim02_2    = DECI(SUBSTR(tim02,4,2)) + 60 
            tim02_1    = DECI(SUBSTR(tim02,1,2)) - 1.
        ELSE 
            ASSIGN tim02_1   =  DECI(SUBSTR(tim02,1,2))
                tim02_2   =  DECI(SUBSTR(tim02,4,2))
                tim02_3 =  DECI(SUBSTR(tim02,7,2)).
    END.
    ASSIGN
        tim02 = string(tim02_1 - DECI(SUBSTR(tim01,1,2)),"99") + ":" +
                string(tim02_2 - DECI(SUBSTR(tim01,4,2)),"99") + ":" + 
                string(tim02_3 - DECI(SUBSTR(tim01,7,2)),"99").
    MESSAGE 
        "Dump ข้อมูลลง Text File 70 : " fiFile-Name1   SKIP(1)
        "Dump ข้อมูลลง Text File 72 : " nvfiFile-Name2 SKIP(1)
        "Text File สรุปข้อมูล       : " nv_sumfile   SKIP(1)
        "การส่งออกจำนวน             : " vExpCount1  " รายการ" SKIP(1)
        FILL("=",27) SKIP(1)
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
    IF fi_producer = "" THEN DO:
        MESSAGE "Not Create Brand..! is empty!!!..." VIEW-AS ALERT-BOX .
        APPLY "ENTRY" TO fi_producer.   
    END.
    ELSE DO:
        vProdCod = se_producer:List-items.        
        vChkFirstAdd = IF vProdCod = ? THEN 1 ELSE 0 .
        IF (LOOKUP(fi_producer,vProdCod) <> 0) AND (vProdcod <> ? ) THEN DO:
            fi_producer = "".
            MESSAGE "Please Check Brand Code dupplicate!!!" VIEW-AS ALERT-BOX WARNING TITLE "Confirm" .
            APPLY "ENTRY" TO fi_producer.         
            /*RETURN NO-APPLY.*/
        END.
        ELSE DO:
            IF vProdcod = ?  THEN vChkFirstAdd = 1.
            IF vChkFirstAdd = 1 THEN DO:
                DO WITH FRAME  fr_main :
                    ASSIGN  fi_producer.
                    se_producer:Add-first(fi_producer).
                    se_producer = se_producer:SCREEN-VALUE .
                END.
                ASSIGN vProdCod = vProdCod + "," + fi_producer
                    fi_producer = "".
                APPLY "ENTRY" TO fi_producer IN FRAME fr_main.
                disp  fi_producer  with frame  fr_main.
            END.
            ELSE DO:          /* เพิ่มข้อมูลต่อ */   
                IF LookUp(fi_producer,vProdCod) <> 0 THEN DO: 
                    MESSAGE "Not Create Brand..! " VIEW-AS ALERT-BOX ERROR.
                    APPLY "ENTRY" TO fi_producer.            
                    /*RETURN NO-APPLY.*/
                END.
                ELSE DO:               /* ข้อมูลไม่ซ้ำเพิ่มได้  */
                    DO WITH FRAME  fr_main :
                        ASSIGN  fi_producer.
                        se_producer:Add-first(fi_producer).
                        se_producer = se_producer:SCREEN-VALUE .
                    END.
                    ASSIGN vProdCod = vProdCod + "," + fi_producer
                        fi_producer = "".
                    APPLY "ENTRY" TO fi_producer IN FRAME fr_main.
                    disp  fi_producer  with frame  fr_main.
                END.
            END.
        END.
    END.
    ASSIGN fi_producer = "".
    APPLY "ENTRY" TO fi_producer IN FRAME fr_main.
    disp  fi_producer  with frame  fr_main.
    vProdCod = se_producer:List-items. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_clr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_clr C-Win
ON CHOOSE OF bu_clr IN FRAME fr_main /* CLR */
DO:
    ASSIGN 
        fi_producer = "".
    APPLY "ENTRY" TO fi_producer IN FRAME fr_main.
    disp  fi_producer  with frame  fr_main.

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
    DISP "" @ fi_producer WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delall
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delall C-Win
ON CHOOSE OF bu_delall IN FRAME fr_main /* DELAll */
DO:
    /*DO WITH FRAME  fr_main :
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
    DISP "" @ fi_producer WITH FRAME fr_main.*/
    /***/
    DEF VAR logAns AS LOGI INIT No.  
    logAns = No.
    MESSAGE "ท่านต้องการลบข้อมูลทั้งหมด    ? " UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ลบข้อมูลทั้งหมด".   
    IF logAns THEN DO:  
        /*DO WITH FRAME  fr_main :
            /*se_producer = se_producer:SCREEN-VALUE .*/

            IF  LOOKUP(se_producer,vProdCod) <> 0 THEN DO:
                IF LOOKUP(se_producer,vProdCod) = 1 THEN 
                    vProdCod = SUBSTR(vProdCod,LENGTH(se_producer) + 2).
                ELSE 
                    vProdCod = SUBSTR(vProdCod,1,INDEX(vProdCod,se_producer) - 2 ) + 
                        SUBSTR(vProdCod,INDEX(vProdCod,se_producer) + LENGTH(se_producer) ). 
        END.*/
        ASSIGN   
            se_producer = vProdCod .
        se_producer:Delete(se_producer).
       /* se_producer = se_producer:SCREEN-VALUE   */ .
    END.
    DISP "" @ fi_producer WITH FRAME fr_main.
        MESSAGE "ลบข้อมูลทั้งหมด เรียบร้อย ..." VIEW-AS ALERT-BOX INFORMATION.  
    
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


&Scoped-define SELF-NAME bu_file-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-2 C-Win
ON CHOOSE OF bu_file-2 IN FRAME fr_main /* .... */
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
        fi_import  = cvData.
        DISP fi_import  WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import C-Win
ON CHOOSE OF bu_import IN FRAME fr_main /* IMP */
DO:
    DEFINE VAR  nv_compno AS CHAR FORMAT "x(20)" INIT "" .  
    DEFINE VAR  nv_FName  AS CHAR FORMAT "x(5)"  INIT "" .   
    DEFINE VAR  nv_Branch AS CHAR FORMAT "x(2)"  INIT "" .   
    DEFINE VAR  nv_InsNo  AS CHAR FORMAT "x(3)"  INIT "" .    
    DEFINE VAR  nv_deci1  AS CHAR FORMAT "x(5)"  INIT "" .  
    For each  winsur :
        DELETE  winsur.
    END.
    INPUT FROM VALUE (fi_import) .                                   
    REPEAT: 
        IMPORT DELIMITER "|"
            nv_compno
            nv_FName 
            nv_Branch
            nv_InsNo 
            nv_deci1 .
        FIND FIRST winsur WHERE winsur.FName = trim(nv_FName) NO-ERROR NO-WAIT.
        IF NOT AVAIL winsur THEN DO:
            CREATE winsur.
            ASSIGN 
                winsur.compno  = TRIM(fiCompNo2)   
                winsur.FName   = TRIM(nv_FName)   
                winsur.Branch  = TRIM(nv_Branch)  
                winsur.InsNo   = TRIM(nv_InsNo)   
                winsur.deci1   = TRIM(nv_deci1) .      
        END.
        ASSIGN 
            nv_compno = ""
            nv_FName  = ""
            nv_Branch = ""
            nv_InsNo  = ""
            nv_deci1  = "".
    END.      /* repeat  */
    FOR EACH winsur  NO-LOCK.
        IF (winsur.fname <> "") AND (index(winsur.fname,"idno") = 0 ) THEN DO:
            FIND FIRST stat.insure WHERE  
                stat.insure.compno = trim(fiCompNo2) AND
                stat.Insure.FName  = winsur.FName    NO-ERROR NO-WAIT.
            IF NOT AVAIL Insure  THEN DO:
                CREATE Insure.
                ASSIGN 
                    insure.compno   =  winsur.compno 
                    Insure.FName    =  winsur.FName  
                    Insure.Branch   =  winsur.Branch 
                    Insure.InsNo    =  winsur.InsNo  
                    Insure.deci1    =  deci(winsur.deci1)  .
            END.
            ELSE 
                ASSIGN     /* update */
                    Insure.Branch   =  winsur.Branch 
                    Insure.InsNo    =  winsur.InsNo  
                    Insure.deci1    =  deci(winsur.deci1) . 
        END.
    END.
    MESSAGE "Import File Data Complete.." VIEW-AS ALERT-BOX .
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_import-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_import-2 C-Win
ON CHOOSE OF bu_import-2 IN FRAME fr_main /* OUT */
DO:
    IF fi_comoutput = "" THEN DO:
        message "Please insert filename output..."  view-as alert-box.
        APPLY "Entry" TO fi_comoutput.
        RETURN NO-APPLY.
    END.
    If  substr(fi_comoutput,length(fi_comoutput) - 3,4) <>  ".csv"  Then
        fi_comoutput  =  Trim(fi_comoutput) + ".csv"  .
    OUTPUT  TO VALUE(fi_comoutput).
    EXPORT DELIMITER "|"
        "Company"                                                 
        "IDno"                   
        "Branch"                                    
        "Poltyp"                                                         
        "Free%"
        SKIP. 
    FOR EACH  stat.insure USE-INDEX Insure03 NO-LOCK
        WHERE stat.insure.compno  = fiCompno2        
        BY stat.Insure.FName  .
        EXPORT DELIMITER "|"  
            stat.insure.compno  
            stat.Insure.FName   
            stat.Insure.Branch  
            stat.Insure.InsNo   
            stat.Insure.deci1 .  
    END.
    OUTPUT  CLOSE.
    message "Export File  Complete"  view-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_query
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_query C-Win
ON CHOOSE OF bu_query IN FRAME fr_main /* OK */
DO:
    IF TRIM(fiCompNo) = "" THEN DO:
        message "Please insert company name.."  view-as alert-box.
        APPLY "Entry" TO fiCompNo.
        RETURN NO-APPLY.
    END.
    IF TRIM(fiCompNo2) = "" THEN DO:
        message "Please insert company name2.."  view-as alert-box.
        APPLY "Entry" TO fiCompNo2.
        RETURN NO-APPLY.
    END.
    FIND LAST company WHERE company.compno = trim(fiCompNo) NO-LOCK NO-ERROR.
    IF AVAIL company  THEN DO:
        OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure03 NO-LOCK  
            WHERE Insure.CompNo = trim(fiCompNo2)
            BY Insure.fname .
            RUN pdDispIns.
            APPLY "VALUE-CHANGED" TO brInsure IN FRAM fr_main. 
            /*RUN ProcDisable IN THIS-PROCEDURE.*/
            DISABLE 
                fiCompNo    
                fiInComp    
                fiInBranch  
                fiFName     
                fi_freeper 
                WITH FRAME frinsure.  
            APPLY "Entry" TO fiCompNo.
            RETURN NO-APPLY.
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


&Scoped-define SELF-NAME fiCompNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompNo C-Win
ON LEAVE OF fiCompNo IN FRAME fr_main
DO:
    fiCompNo = INPUT fiCompNo.
    ASSIGN fiCompNo2 = trim(fiCompNo).
    DISP fiCompNo fiCompNo2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCompNo2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompNo2 C-Win
ON LEAVE OF fiCompNo2 IN FRAME fr_main
DO:
    fiCompNo2 = INPUT fiCompNo2.
    DISP fiCompNo2 WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fiFName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFName C-Win
ON LEAVE OF fiFName IN FRAME fr_main
DO:
  fiFName = INPUT fiFName.
  DISP fiFName WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInBranch C-Win
ON LEAVE OF fiInBranch IN FRAME fr_main
DO:
  fiInBranch = INPUT fiInBranch.
  DISP fiInBranch WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiInComp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiInComp C-Win
ON LEAVE OF fiInComp IN FRAME fr_main
DO:
  fiInComp = INPUT fiInComp.
  DISP fiInComp WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bindate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bindate C-Win
ON LEAVE OF fi_bindate IN FRAME fr_main
DO:
    fi_bindate = INPUT fi_bindate.

    DISPLAY fi_bindate WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_binloop
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_binloop C-Win
ON LEAVE OF fi_binloop IN FRAME fr_main
DO:
    fi_binloop = INPUT fi_binloop.

    DISPLAY fi_binloop WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comoutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comoutput C-Win
ON LEAVE OF fi_comoutput IN FRAME fr_main
DO:
    fi_comoutput = INPUT fi_comoutput.
    DISP fi_comoutput WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_freeper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_freeper C-Win
ON LEAVE OF fi_freeper IN FRAME fr_main
DO:
  fi_freeper = INPUT fi_freeper.
  DISP fi_freeper WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_import
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_import C-Win
ON LEAVE OF fi_import IN FRAME fr_main
DO:
  fi_import = INPUT fi_import.
  DISP fi_import WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputcon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputcon C-Win
ON LEAVE OF fi_outputcon IN FRAME fr_main
DO:
  fi_outputcon = INPUT fi_outputcon.
  DISP fi_outputcon WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer.
  DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trandatF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trandatF C-Win
ON LEAVE OF fi_trandatF IN FRAME fr_main
DO:
    fi_trandatF = INPUT fi_trandatF.
    /*n_comdatF  = fi_trandatF.*/

    DISPLAY fi_trandatF WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trandatT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trandatT C-Win
ON LEAVE OF fi_trandatT IN FRAME fr_main
DO:
    fi_trandatT = INPUT fi_trandatT.
    /*n_comdatT  = fi_trandatT.*/
    IF fi_trandatT <> ?  THEN DO:
        APPLY "ENTRY" TO fi_binloop IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    DISPLAY fi_trandatT WITH FRAME {&FRAME-NAME}.

    
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
    gv_prgid = "Wacraycl".
    gv_prog  = "ข้อมูล Text File เพื่อวางบิลบมจ.อยุธยา แคปปิตอล ออโต้ลีส (AYCAL)".
    RUN  WUT\WUTHEAD (c-win:HANDLE,gv_prgid,gv_prog).
    RUN  WUT\WUTDICEN (c-win:HANDLE).
    /*********************************************************************/
    
    SESSION:DATA-ENTRY-RETURN = YES.
    SESSION:DATE-FORMAT  = "DMY".    /* -d dmy */
    RECT-1:MOVE-TO-TOP( ).
    /*RECT-2:MOVE-TO-TOP( ).*/
    RECT-3:MOVE-TO-TOP( ).
    /*RECT-4:MOVE-TO-TOP( ).*/
    cbAsdat = vAcProc_fil.
    /*------------------------*/
    RUN pdAcproc_fil.
    /*------------------------*/
    ASSIGN
        nv_User       = n_user                                                                              
        nv_pwd        = n_passwd    
        fibranch      = "0"
        fibranch2     = "Z"
        n_branch      = fibranch
        n_branch2     = fibranch2
        fi_process    = ""
        fi_binloop    = 1
        fi_bindate    = DATE(MONTH(TODAY),DAY(TODAY),YEAR(TODAY))
        /*n_comdatF     = ?
        n_comdatT     = ?*/
        n_OutputFile1 = "" 
        /*ra_type       = 2             */ /*kridtiya i. A53-0167*/
        fi_trandatF   = TODAY          
        fi_trandatT   = TODAY          
        fiFile-Name1  = "d:\Aycl" + 
                        STRING(DAY(TODAY),"99") +
                        STRING(MONTH(TODAY),"99") +
                        STRING(YEAR(TODAY),"9999")  
        tim01         = ""
        tim02         = "" 
        vProdCod      = ""
        ra_filetype   = 1
        se_producer   = ""
        fiCompNo      = "AYCL"
        fiCompNo2     = "AYCL"
        gComp         = "AYCL"  .
   fibdes  = fuFindBranch(fibranch).
   fibdes2 = fuFindBranch(fibranch2).
   RUN proc_createproducer.
   RUN pdDispComp.
   DISP fibranch   fibranch2  fibdes fibdes2  fi_trandatF fi_trandatT se_producer  ra_filetype fiCompNo2
        fi_process fi_binloop fi_bindate fiFile-Name1 fiCompNo  WITH FRAME {&FRAME-NAME}.
    

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
  DISPLAY fiBranch fiBranch2 fi_producer fi_trandatF fi_trandatT cbAsDat 
          fi_binloop fi_bindate fibdes fiFile-Name1 fiFile-Nameinput ra_filetype 
          fi_outputcon fiCompNo fiCompNo2 fibdes2 fi_import fi_comoutput 
          fiInComp fiInBranch fi_process fiFName fi_freeper se_producer 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fiBranch fiBranch2 fi_producer bu_add bu_clr bu_del bu_delall 
         fi_trandatF fi_trandatT cbAsDat fi_binloop fi_bindate fibdes 
         fiFile-Name1 Btn_OK fiFile-Nameinput bu_file ra_filetype fi_outputcon 
         Btn_conver fiCompNo fiCompNo2 bu_query fibdes2 fi_import bu_file-2 
         bu_import fi_comoutput bu_import-2 fiInComp fiInBranch fi_process 
         fiFName fi_freeper btninadd btnInUpdate btnInDelete btnInOK 
         btnInCancel btnInDeleteall brinsure se_producer Btn_Exit buBranch 
         buBranch2 RECT-5 RECT-6 RECT-7 RECT-8 RECT-609 RECT-610 RECT-611 
         RECT-1 RECT-3 RECT-9 RECT-2 RECT-613 RECT-614 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd03_csv C-Win 
PROCEDURE pd03_csv :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1 + "_v70.csv").
ASSIGN
    vExpCount1 = 0
    nv_sumprem = 0
    /*nv_sumcomp = 0*/
    n_wRecordno = 1
    n_binloop  = ""
    n_bindate  = ""
    n_binloop  = STRING(fi_binloop,"9")
    n_bindate  = STRING(fi_bindate,"99/99/9999")
    dateasof   = STRING(n_asdat)
    dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).
PUT STREAM filebill1
    "H"                                  FORMAT "X"       ","      /*  1.*/
    "00001"                              FORMAT "x(5)"    ","      /*  2.*/
    "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   ","       
    "KPI"                                FORMAT "X(4)"    "," 
    dateasof                             FORMAT "X(8)"    "," 
    "1"                                  FORMAT "X"       ","      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                            FORMAT "X"       
    SKIP. 
loop1:
FOR EACH wBill USE-INDEX wBill04 NO-LOCK
    WHERE wBill.wPoltype = "v70" 
    BREAK BY wBill.wPolicy :

    DISPLAY  "Export Data : " + STRING(wBill.wRecordno,">>>>>9") + '  ' + wBill.wpolicy
        + '  ' + wBill.wtrnty1 + '-' + wBill.wdocno FORMAT "X(10)" /* A60-0267 */
        @ fi_Process WITH FRAME fr_main .
    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1  + 1
        nv_sumprem  = nv_sumprem  + wBill.wtotNetprm   . 
    PUT STREAM filebill1
        "D"                      FORMAT "X"                 ","  /* 1  Record Type        */
        n_wRecordno              FORMAT "99999"             ","  /* 2  Sequence no.       */
        wBill.wPolicy            FORMAT "x(20)"             ","  /* 3  INS. Policy No.    */               
        wBill.wcovcod            FORMAT "x(2)"              ","  /* 4  insurance Type     */                
        wBill.wtitle             FORMAT "x(10)"             ","  /* 5  Customer Title Name*/              
        wBill.wfirstname         FORMAT "x(25)"             ","  /* 6  Customer First Name / Company Name*/ 
        wBill.wlastname          FORMAT "x(65)"             ","  /* 7  Customer Last Name */               
        wBill.wNor_Comdat        FORMAT "x(8)"              ","  /* 8  วันเริ่มคุ้มครอง   */               
        wBill.wNor_Expdat        FORMAT "x(8)"              ","  /* 9  วันสิ้นสุดคุ้มครอง */               
        deci(wBill.wsuminsurce)  FORMAT ">>>>>>>>9.99-"     ","  /* 10 Sum Insured   */
        deci(wBill.wNetprm)      FORMAT ">>>>>>>>9.99-"     ","  /* 11 Net.INS.Prm   */
        deci(wBill.wtotNetprm)   FORMAT ">>>>>>>>9.99-"     ","  /* 12 Total.INS.Prm */                  
        wBill.wChassis_no        FORMAT "x(30)"             ","  /* 13 Chassis No.   */                 
        wBill.wEngine_no         FORMAT "x(30)"             ","  /* 14 Engine No.    */
        deci(wBill.wFee)         FORMAT ">>>>>>>>9.99-"     ","  /* 15 ค่า Fee       */
        deci(wBill.wFeeamount)   FORMAT ">>>>>>>>9.99-"     ","  /* 16 ค่า Fee amount*/ 
        deci(wBill.wFee_orthe)   FORMAT ">>>>>>>>9.99-"          /* 17 ค่าอนุโลม */     
        SKIP.
    END.      /* for each wbill */
    ASSIGN 
        /*nv_sum      = nv_sumprem + nv_sumcomp */
        n_wRecordno = n_wRecordno + 1 .
    PUT STREAM filebill1
    "T"                     FORMAT "X"      ","           /*  1.*/
    n_wRecordno             FORMAT "99999"  ","           /*  2.Last sequence no.*/
    (n_wRecordno - 2 )      FORMAT "99999"  ","           /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    
    OUTPUT STREAM filebill1 CLOSE.
    RUN pdo3_72_csv.
    /*RUN pdo3_ex.*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDispComp C-Win 
PROCEDURE pdDispComp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
gComp = fiCompNo.
RUN pdUpdateQ.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdDispIns C-Win 
PROCEDURE PdDispIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF CAN-FIND (FIRST stat.Insure WHERE stat.Insure.compno = TRIM(fiCompNo2))  THEN DO:
    DISPLAY 
        Insure.compno    @ ficompno2 
        Insure.FName     @ fiInComp  
        Insure.Branch    @ fiInBranch
        Insure.insno     @ fiFName
        Insure.deci1     @ fi_Freeper
        WITH FRAME fr_main.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdEnable C-Win 
PROCEDURE pdEnable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
    ENABLE 
    fi_poltyp fi_freeper  fi_branchfree    

    WITH FRAME fr_main.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3 C-Win 
PROCEDURE pdo3 :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
/*----------------------------- export to file *** since 01/12/01 file comp ***---------------------------*/
/*DEF BUFFER bufwBill FOR wBill.  */ 
OUTPUT STREAM filebill1 TO VALUE(fiFile-Name1 + "_v70.txt").
ASSIGN
    vExpCount1 = 0
    nv_sumprem = 0
    /*nv_sumcomp = 0*/
    n_wRecordno = 1
    n_binloop  = ""
    n_bindate  = ""
    n_binloop  = STRING(fi_binloop,"9")
    n_bindate  = STRING(fi_bindate,"99/99/9999")
    dateasof   = STRING(n_asdat)
    dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).
PUT STREAM filebill1
    "H"                                  FORMAT "X"       "|"      /*  1.*/
    "00001"                              FORMAT "x(5)"    "|"      /*  2.*/
    "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   "|"       
    "KPI"                                FORMAT "X(4)"    "|" 
    dateasof                             FORMAT "X(8)"    "|" 
    "1"                                  FORMAT "X"       "|"      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                            FORMAT "X"        
    SKIP. 
loop1:
FOR EACH wBill USE-INDEX wBill04 NO-LOCK

    WHERE wBill.wPoltype = "v70" 
    BREAK BY wBill.wPolicy :

    DISPLAY  "Export Data : " + STRING(wBill.wRecordno,">>>>>9") + '  ' + wBill.wpolicy
        + '  ' + wBill.wtrnty1 + '-' + wBill.wdocno FORMAT "X(10)" /* A60-0267 */
        @ fi_Process WITH FRAME fr_main .
    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1  + 1
        nv_sumprem  = nv_sumprem  + wBill.wtotNetprm   . 
    PUT STREAM filebill1
        "D"               FORMAT "X"                         "|"   /* 1  Record Type      */
        n_wRecordno       FORMAT "99999"                     "|"   /* 2  Sequence no. */
        wBill.wPolicy     FORMAT "x(20)"                     "|"   /* 3  INS. Policy No.      */               
        wBill.wcovcod     FORMAT "x(2)"                      "|"   /* 4  insurance Type       */                
        wBill.wtitle      FORMAT "x(10)"                     "|"   /* 5  Customer Title Name  */              
        wBill.wfirstname  FORMAT "x(25)"                     "|"   /* 6  Customer First Name / Company Name */ 
        wBill.wlastname   FORMAT "x(65)"                     "|"   /* 7  Customer Last Name   */               
        wBill.wNor_Comdat FORMAT "x(8)"                      "|"   /* 8  วันเริ่มคุ้มครอง    */               
        wBill.wNor_Expdat FORMAT "x(8)"                      "|"   /* 9  วันสิ้นสุดคุ้มครอง  */               
        fuDeciToChar(wBill.wsuminsurce,13)  FORMAT "X(13)"   "|"   /* 10 Sum Insured          */
        fuDeciToChar(wBill.wNetprm,13)      FORMAT "X(13)"   "|"   /* 11 Net.INS.Prm          */
        fuDeciToChar(wBill.wtotNetprm,13)   FORMAT "X(13)"   "|"   /* 12 Total.INS.Prm        */                  
        wBill.wChassis_no                   FORMAT "x(22)"   "|"   /* 13 Chassis No.      */                     
        wBill.wEngine_no                    FORMAT "x(22)"   "|"   /* 14 Engine No.       */
        fuDeciToChar(wBill.wFee,5)          FORMAT "X(5)"    "|"   /* 15 ค่า Fee              */
        fuDeciToChar(wBill.wFeeamount,13)   FORMAT "X(13)"   "|"   /* 16 ค่า Fee amount*/ 
        fuDeciToChar(wBill.wFee_orthe,13)   FORMAT "X(13)"         /* 17 ค่าอนุโลม     */     
        SKIP.
    END.      /* for each wbill */
    ASSIGN 
        /*nv_sum      = nv_sumprem + nv_sumcomp */
        n_wRecordno = n_wRecordno + 1 .
    PUT STREAM filebill1
    "T"                         FORMAT "X"      "|"    /*  1.*/
    n_wRecordno                 FORMAT "99999"  "|"    /*  2.Last sequence no.*/
    (n_wRecordno - 2 )          FORMAT "99999"  "|"   /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13) FORMAT "X(13)"   
    SKIP. 
    OUTPUT STREAM filebill1 CLOSE.
    RUN pdo3_72.
    /*RUN pdo3_ex.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_72 C-Win 
PROCEDURE pdo3_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nvfiFile-Name2 = fiFile-Name1 +  "_v72.txt".
OUTPUT STREAM filebill1 TO VALUE(nvfiFile-Name2).
ASSIGN
    nv_sumprem  = 0
    /*nv_sumcomp  = 0*/
    n_wRecordno = 1 
    n_binloop   = ""
    n_bindate  = ""
    n_binloop  = STRING(fi_binloop,"9")
    n_bindate  = STRING(fi_bindate,"99/99/9999")
    dateasof   = STRING(n_asdat)
    dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).
PUT STREAM filebill1
    "H"                                  FORMAT "X"       "|"   /*  1.*/
    "00001"                              FORMAT "x(5)"    "|"   /*  2.*/
    "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   "|"   
    "KPI"                                FORMAT "X(4)"    "|"   
    dateasof                             FORMAT "X(8)"    "|"   
    "2"                                  FORMAT "X"       "|"   /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                            FORMAT "X"             
    SKIP. 

loop1:
FOR EACH wBill USE-INDEX wBill04 NO-LOCK
    WHERE wBill.wPoltype = "v72" 
    BREAK BY wBill.wPolicy :
    DISPLAY  "Export Data : " + STRING(wBill.wRecordno,">>>>>9") + '  ' + wBill.wpolicy
        + '  ' + wBill.wtrnty1 + '-' + wBill.wdocno FORMAT "X(10)" /* A60-0267 */
        @ fi_Process WITH FRAME {&FRAME-NAME}.
    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1 + 1
        nv_sumprem  = nv_sumprem + wBill.wtotNetprm
        /*nv_sumcomp = nv_sumcomp + wBill.wCompNetPrem*/    . 
    PUT STREAM filebill1
        "D"                                FORMAT "X"      "|"    /* 1  Record Type  */
        n_wRecordno                        FORMAT "99999"  "|"    /* 2  Sequence no. */
        wbill.nv_sckno                     FORMAT "x(13)"  "|"    /* 3  CTP .number  */                 
        wBill.wtitle                       FORMAT "x(10)"  "|"    /* 4  Customer Title Name */              
        wBill.wfirstname                   FORMAT "x(25)"  "|"    /* 5  Customer First Name/Company Name*/ 
        wBill.wlastname                    FORMAT "x(65)"  "|"    /* 6  Customer Last Name */               
        wBill.wNor_Comdat                  FORMAT "x(8)"   "|"    /* 7  วันเริ่มคุ้มครอง   */               
        wBill.wNor_Expdat                  FORMAT "x(8)"   "|"    /* 8  วันสิ้นสุดคุ้มครอง */               
        fuDeciToChar(wBill.wNetprm,13)     FORMAT "X(13)"  "|"    /* 9  Net.INS.Prm   */     
        fuDeciToChar(wBill.wtotNetprm,13)  FORMAT "X(13)"  "|"    /* 10 Total.INS.Prm */                   
        wBill.wChassis_no                  FORMAT "x(22)"  "|"    /* 11 Chassis No.   */ 
        wBill.wEngine_no                   FORMAT "x(22)"  "|"    /* 12 Engine No.    */        
        fuDeciToChar(wBill.wFee,5)         FORMAT "X(5)"   "|"    /* 13 ค่า Fee */  
        fuDeciToChar(wBill.wFeeamount,13)  FORMAT "X(13)"  "|"    /* 14 ค่า Fee amount  */  
        fuDeciToChar(wBill.wFee_orthe,13)  FORMAT "X(13)"         /* 15 ค่าอนุโลม   */      
        SKIP.
    END.         /* for each wbill */
    ASSIGN 
        n_wRecordno = n_wRecordno + 1 
        /*nv_sum = nv_sumprem + nv_sumcomp*/   .

    PUT STREAM filebill1
    "T"                          FORMAT "X"      "|"      /*  1.*/
    (n_wRecordno)                FORMAT "99999"  "|"     /*  2.Last sequence no.*/
    (n_wRecordno - 2 )           FORMAT "99999"  "|"    /*  3.ผลรวมจำนวนกรมธรรม์*/
    fuDeciToChar(nv_sumprem,13)  FORMAT "X(13)"   
    SKIP. 
    OUTPUT STREAM filebill1 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_72_csv C-Win 
PROCEDURE pdo3_72_csv :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nvfiFile-Name2 = fiFile-Name1 +  "_v72.csv".
OUTPUT STREAM filebill1 TO VALUE(nvfiFile-Name2).
ASSIGN
    nv_sumprem  = 0
    /*nv_sumcomp  = 0*/
    n_wRecordno = 1 
    n_binloop   = ""
    n_bindate  = ""
    n_binloop  = STRING(fi_binloop,"9")
    n_bindate  = STRING(fi_bindate,"99/99/9999")
    dateasof   = STRING(n_asdat)
    dateasof   = string(deci(SUBSTR(dateasof,7,2)) + 43 ) + SUBSTR(dateasof,4,2) + SUBSTR(dateasof,1,2).
PUT STREAM filebill1
    "H"                                  FORMAT "X"       ","    /*  1.*/
    "00001"                              FORMAT "x(5)"    ","    /*  2.*/
    "บริษัทประกันคุ้มภัย จำกัดมหาชน"     FORMAT "X(40)"   "," 
    "KPI"                                FORMAT "X(4)"    "," 
    dateasof                             FORMAT "X(8)"    "," 
    "2"                                  FORMAT "X"       ","   /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                            FORMAT "X"       ","   /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    SKIP. 

loop1:
FOR EACH wBill USE-INDEX wBill04 NO-LOCK
    WHERE wBill.wPoltype = "v72" 
    BREAK BY wBill.wpolicy :
    
    DISPLAY  "Export Data : " + STRING(wBill.wRecordno,">>>>>9") + '  ' + wBill.wpolicy
        + '  ' + wBill.wtrnty1 + '-' + wBill.wdocno FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */
        @ fi_Process WITH FRAME {&FRAME-NAME}.
    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1 + 1
        nv_sumprem  = nv_sumprem + wBill.wtotNetprm  . 
    PUT STREAM filebill1
        "D"                      FORMAT "X"             ","   /* 1  Record Type  */
        n_wRecordno              FORMAT "99999"         ","   /* 2  Sequence no. */
        wbill.nv_sckno           FORMAT "x(13)"         ","   /* 3  CTP .number  */                 
        wBill.wtitle             FORMAT "x(10)"         ","   /* 4  Customer Title Name */              
        wBill.wfirstname         FORMAT "x(25)"         ","   /* 5  Customer First Name/Company Name*/ 
        wBill.wlastname          FORMAT "x(65)"         ","   /* 6  Customer Last Name */               
        wBill.wNor_Comdat        FORMAT "x(8)"          ","   /* 7  วันเริ่มคุ้มครอง   */               
        wBill.wNor_Expdat        FORMAT "x(8)"          ","   /* 8  วันสิ้นสุดคุ้มครอง */               
        DECI(wBill.wNetprm)      FORMAT ">>>>>>>>9.99-" ","   /* 9   Net.INS.Prm   */     
        DECI(wBill.wtotNetprm)   FORMAT ">>>>>>>>9.99-" ","   /* 10  Total.INS.Prm */                   
        wBill.wChassis_no        FORMAT "x(22)"         ","   /* 11  Chassis No.   */ 
        wBill.wEngine_no         FORMAT "x(22)"         ","   /* 12  Engine No.    */        
        DECI(wBill.wFee)         FORMAT ">>>>>>>>9.99-" ","   /* 13  ค่า Fee */  
        DECI(wBill.wFeeamount)   FORMAT ">>>>>>>>9.99-" ","   /* 14  ค่า Fee amount  */  
        DECI(wBill.wFee_orthe)   FORMAT ">>>>>>>>9.99-" ","   /* 15  ค่าอนุโลม   */ 
        wBill.wPolicy            FORMAT "x(20)"                    
        SKIP.
    END.         /* for each wbill */
    ASSIGN n_wRecordno = n_wRecordno + 1 
    /*nv_sum = nv_sumprem + nv_sumcomp*/    .
    PUT STREAM filebill1
    "T"                     FORMAT "X"      ","     /*  1.*/
    (n_wRecordno)           FORMAT "99999"  ","     /*  2.Last sequence no. */
    (n_wRecordno - 2 )      FORMAT "99999"  ","     /*  3.ผลรวมจำนวนกรมธรรม์*/
    deci(nv_sumprem)        FORMAT ">>>>>>>>9.99-"  SKIP. 
    
    OUTPUT STREAM filebill1 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdo3_ex C-Win 
PROCEDURE pdo3_ex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_wRecordno     AS INTE FORMAT "99999" INIT 0.  
If  substr(fiFile-Name1,length(fiFile-Name1) - 3,4) <>  ".csv"  Then
    fiFile-Name1  =  Trim(fiFile-Name1) + "_ex.csv"  .

OUTPUT STREAM ns2 TO VALUE(fiFile-Name1).
PUT STREAM ns2 
    " "    "|"
    "TEXT FILE FROM Aycl"    SKIP.
PUT STREAM ns2  
    "Record Type    "              "|" 
    "Sequence no.   "              "|"      
    "INS. Policy No."              "|"   
    "Stk No."                      "|"    
    "insurance Type "              "|"      
    "Customer Title Name "         "|"      
    "Customer First Name/ Company Name"    "|"      
    "Customer Last Name"           "|"      
    "วันเริ่มคุ้มครอง  "           "|"      
    "วันสิ้นสุดคุ้มครอง"           "|"      
    "Sum Insured  "                "|"      
    "Net.INS.Prm  "                "|"      
    "Total.INS.Prm"                "|"      
    "Chassis No.  "                "|"      
    "Engine No.   "                "|"      
    "ค่า Fee      "                "|"      
    "ค่า Fee amount"               "|"      
    "ค่าอนุโลม    "                "|" 
    "วันที่ asofdate"              "|"     
    SKIP.  
ASSIGN n_wRecordno = 0.

for each wBill  no-lock.  
    n_wRecordno = n_wRecordno + 1.
    PUT STREAM ns2   
        "D"               FORMAT "X"                "|"  
        n_wRecordno       FORMAT ">>>>9"            "|"  
        wBill.wPolicy     FORMAT "x(20)"            "|"  
        wbill.nv_sckno    FORMAT "x(13)"            "|"
        wBill.wcovcod     FORMAT "x(2)"             "|"  
        wBill.wtitle      FORMAT "x(10)"            "|"  
        wBill.wfirstname  FORMAT "x(25)"            "|"  
        wBill.wlastname   FORMAT "x(65)"            "|"  
        wBill.wNor_Comdat FORMAT "x(8)"             "|"  
        wBill.wNor_Expdat FORMAT "x(8)"             "|"  
        wBill.wsuminsurce FORMAT ">>>,>>>,>>9.99-"  "|"  
        wBill.wNetprm     FORMAT ">>>,>>>,>>9.99-"  "|"  
        wBill.wtotNetprm  FORMAT ">>>,>>>,>>9.99-"  "|"    
        wBill.wChassis_no FORMAT "x(22)"            "|"              
        wBill.wEngine_no  FORMAT "x(22)"            "|"  
        wBill.wFee        FORMAT ">>9"              "|"  
        wFeeamount        FORMAT ">>>,>>>,>>9.99-"  "|"  
        wFee_orthe        FORMAT ">>>,>>>,>>9.99-"  "|" 
        dateasof          FORMAT "x(8)"             "|"
        SKIP.  
     
END.

OUTPUT STREAM ns2 CLOSE.

/*message "Export File  Complete"  view-as alert-box.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProc C-Win 
PROCEDURE pdProc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_taxx  AS DECI INIT 0.
DEF VAR n_stamm AS DECI INIT 0.
/*comment by kridtiya i.  A59-0362 .........
FIND LAST  AcProc_fil USE-INDEX by_type_asdat WHERE
    AcProc_fil.type  = "09"                   AND
    AcProc_fil.asdat = n_asdat                NO-ERROR NO-WAIT.     /* n_asdat */
IF NOT AVAIL AcProc_fil THEN DO:                                    
    CREATE AcProc_fil.                                              
    ASSIGN AcProc_fil.type  = "09"                                  
        AcProc_fil.typdesc  = "PROCESS STATEMENT BILLING(Aycl)"     
        AcProc_fil.asdat    = n_asdat                               /* วันที่ process statement */
        AcProc_fil.trndatfr = fi_trandatF                           /* depend on condition on interface */
        AcProc_fil.trndatto = fi_trandatT                           
        AcProc_fil.entdat   = TODAY                                 /* วันที่ export textfile */
        AcProc_fil.enttim   = STRING(TIME, "HH:MM:SS")              /* เวลา export textfile */
        AcProc_fil.usrid    = n_user .
END.
RELEASE AcProc_fil.
end.......comment by kridtiya i.  A59-0362 .... */

FOR EACH wBill:     DELETE wBill.   END.    

ASSIGN vCountRec    = 0 .                               

LOOP_MAIN:  
/*-FOR EACH  Agtprm_fil USE-INDEX by_trndat_acno WHERE  
    (Agtprm_fil.trndat    >=  fi_trandatF     AND      
     Agtprm_fil.trndat    <=  fi_trandatT)    AND      
    LOOKUP(Agtprm_fil.acno,vProdCod) <> 0     AND      
    (Agtprm_fil.poltyp     =  "V70"           OR 
     Agtprm_fil.poltyp     =  "V72" )         AND
    (Agtprm_fil.TYPE       =  "01"            OR  
     Agtprm_fil.TYPE       =  "05")           AND 
     Agtprm_fil.asdat      =  n_asdat         AND    
     Agtprm_fil.trntyp   BEGINS 'M'           AND 
    (Agtprm_fil.polbran   >=  n_branch        AND 
     Agtprm_fil.polbran   <=  n_branch2)      AND 
     Agtprm_fil.bal        >   0              NO-LOCK: */
FOR EACH  Agtprm_fil USE-INDEX by_acno          WHERE  
        Agtprm_fil.asdat          =  n_asdat    AND 
 LOOKUP(Agtprm_fil.acno,vProdCod) <> 0          AND    
       (Agtprm_fil.poltyp         =  "V70"      OR  
        Agtprm_fil.poltyp         =  "V72" )    AND 
       (Agtprm_fil.TYPE           =  "01"       OR  
        Agtprm_fil.TYPE           =  "05")      AND 
        Agtprm_fil.trntyp BEGINS 'M'            AND 
       (Agtprm_fil.polbran       >=  n_branch   AND 
        Agtprm_fil.polbran       <=  n_branch2) AND 
        Agtprm_fil.bal           >   0          NO-LOCK: 

    IF      Agtprm_fil.trndat    <  fi_trandatF THEN NEXT.   /*Add by kridtiya i.  A59-0362 ....*/
    ELSE IF Agtprm_fil.trndat    >  fi_trandatT THEN NEXT.   /*Add by kridtiya i.  A59-0362 ....*/

    /* เบี้ยเป็น 0 แต่ยังค้างค่า comm. (bal <> 0) */
    IF Agtprm_fil.prem + Agtprm_fil.prem_comp = 0 THEN NEXT.

    FIND LAST acm001 USE-INDEX acm00104    WHERE acm001.policy = Agtprm_fil.policy  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL acm001 THEN
        IF acm001.trnty1 = "R" AND acm001.trnty2 = "C" THEN NEXT.

        ASSIGN
            nv_pol72       = ""     nv_norpol        = ""
            nv_job_nr      = ""     nv_insure        = ""
            nv_subins      = ""     nv_comp_sub      = ""
            nv_remark      = ""     n_cha_no         = ""       
            n_eng_no       = ""     n_vehreg         = ""       
            nv_grossPrem   = 0     nv_grossPrem_comp = 0
            nv_nor_si      = 0     nv_comp_si        = 0
            nv_nor_net     = 0     nv_comp_net       = 0
            nv_nor_prm     = 0     nv_comp_prm       = 0
            nv_nor_com     = 0     nv_comp_com       = 0
            nv_stamp_per   = 0     nv_tax_per        = 0
            nv_stamp70     = 0     nv_stamp72        = 0
            nv_vat70       = 0     nv_vat72          = 0
            nv_vat_comm70  = 0     nv_vat_comm72     = 0
            nv_tax3_comm70 = 0     nv_tax3_comm72    = 0
            nv_comdat72    = ?     nv_expdat72       = ?
            nv_fptr        = ?     n_append          = "" 
            n_taxx         = 0     n_stamm           = 0
            nv_Netprm      = 0     nv_freeper        = 0
            nv_sckno       = "" 
            fi_Process     = "Process : " + Agtprm_fil.policy + '   ' + Agtprm_fil.trnty
            + '  ' + Agtprm_fil.docno.
        DISPLAY     fi_Process  WITH FRAME fr_main .
        /*CENTERED.*/
        ASSIGN
            nv_norpol   = Agtprm_fil.policy
            nv_nor_net  = Agtprm_fil.prem           /* Premium ไม่รวม Compulsory */
            nv_nor_prm  = Agtprm_fil.prem           
            nv_stamp70  = Agtprm_fil.stamp          /* Stamp Premium + Compulsory */
            nv_vat70    = Agtprm_fil.tax            /* Tax Premium + Compulsory */
            nv_comp_net = Agtprm_fil.prem_comp      /* Compulsory */
            nv_comp_prm = Agtprm_fil.prem_comp  .
        IF agtprm_fil.poltyp = "v70" THEN DO: 
            IF Agtprm_fil.prem_comp > 0 THEN                          /*add by kridtiya i. A59-0597 รวมเบี้ยพรบ.ในตัว*/
                 nv_Netprm = Agtprm_fil.prem + Agtprm_fil.prem_comp . /*add by kridtiya i. A59-0597 รวมเบี้ยพรบ.ในตัว*/
            ELSE nv_Netprm = Agtprm_fil.prem.                         /*add by kridtiya i. A59-0597 รวมเบี้ยพรบ.ในตัว*/
        END.
        ELSE IF agtprm_fil.poltyp = "v72"  THEN nv_Netprm = Agtprm_fil.prem_comp  .

        /*FIND FIRST uwm100 USE-INDEX uwm10001   WHERE*/
        FIND FIRST uwm100    WHERE
            uwm100.policy = Agtprm_fil.policy  AND
            uwm100.endno  = Agtprm_fil.endno   AND
            uwm100.docno1 = Agtprm_fil.docno   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL uwm100 THEN DO:
            IF uwm100.rencnt = 0 AND uwm100.prvpol = "" THEN
                nv_job_nr = "N".
            ELSE nv_job_nr = "R".
            nv_insure = TRIM(uwm100.ntitle) + " " + TRIM(uwm100.name1).
            IF nv_insure = " " THEN nv_insure = TRIM(Agtprm_fil.insure).
            ASSIGN n_append = uwm100.cr_2     
                nv_rec100 = RECID(uwm100).
            FIND uwm100 WHERE RECID(uwm100) = nv_rec100 NO-LOCK NO-ERROR NO-WAIT.   

            FIND FIRST uwm130 USE-INDEX uwm13001  WHERE
                uwm130.policy = uwm100.policy     AND
                uwm130.rencnt = uwm100.rencnt     AND
                uwm130.endcnt = uwm100.endcnt     NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE uwm130 THEN NEXT.
            ELSE DO:
                IF agtprm_fil.poltyp = "v70"       THEN nv_nor_si  =  uwm130.uom6_v.
                ELSE IF agtprm_fil.poltyp = "v72"  THEN nv_nor_si  =  uwm130.uom8_v.
                FIND FIRST stat.insure USE-INDEX Insure03 WHERE 
                    stat.insure.compno = TRIM(fiCompNo)     AND
                    stat.Insure.InsNo  = Agtprm_fil.poltyp  AND
                    stat.Insure.Branch = Agtprm_fil.polbran NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL insure THEN ASSIGN nv_freeper  = Insure.deci1.
                ELSE nv_freeper = 0.
                FIND FIRST uwm301 USE-INDEX uwm30101   WHERE
                    uwm301.policy  =    uwm130.policy  AND
                    uwm301.rencnt  =    uwm130.rencnt  AND
                    uwm301.endcnt  =    uwm130.endcnt  AND
                    uwm301.riskgp  =    uwm130.riskgp  AND
                    uwm301.riskno  =    uwm130.riskno  AND
                    uwm301.itemno  =    uwm130.itemno  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:
                    IF agtprm_fil.poltyp = "v72"  THEN DO:
                        FIND FIRST Detaitem USE-INDEX detaitem01 WHERE
                            Detaitem.Policy  = uwm301.Policy     NO-LOCK NO-ERROR NO-WAIT.
                        IF  AVAIL Detaitem THEN  ASSIGN  nv_sckno =  Detaitem.serailno.
                        ELSE nv_sckno = trim(substr(uwm301.drinam[9],7)) .
                    END.
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
                            wBill.wEndno        = Agtprm_fil.endno           /*A56-0176 */
                            wbill.nv_sckno      = nv_sckno                   
                            wBill.wPolicy       = Agtprm_fil.policy          /*3   INS. Policy No.  */                 
                            wBill.wPoltype      = Agtprm_fil.poltyp          
                            wBill.wcovcod       = uwm301.covcod              /*uwm301.covcod *//*4   insurance Type  */                   
                            wBill.wtitle        = TRIM(uwm100.ntitle)        /*5   Customer Title Name  */              
                            wBill.wfirstname    = SUBSTR(TRIM(uwm100.name1),1,INDEX(TRIM(uwm100.name1)," ") - 1) /*6 Customer First Name / Company Name*/ 
                            wBill.wlastname     = SUBSTR(TRIM(uwm100.name1),INDEX(TRIM(uwm100.name1)," ") + 1)   /*7 Customer Last Name */                
                            wBill.wNor_Comdat   = SUBstr(STRING((YEAR(Agtprm_fil.comdat) + 543),"9999"),3,2) +   /*8 วันเริ่มคุ้มครอง  */                 
                                                  STRING(month(Agtprm_fil.comdat),"99") +                            
                                                  STRING(DAY(Agtprm_fil.comdat),"99")                                
                            wBill.wNor_Expdat   = SUBstr(STRING((YEAR(uwm100.expdat) + 543),"9999"),3,2) +       /*9 วันสิ้นสุดคุ้มครอง */                
                                                  STRING(month(uwm100.expdat),"99") + 
                                                  STRING(DAY(uwm100.expdat),"99")   
                            wBill.wsuminsurce   = nv_nor_si
                            wBill.wNetprm       = nv_Netprm
                            wBill.wtotNetprm    = nv_Netprm + Agtprm_fil.stamp  + Agtprm_fil.tax
                            wBill.wChassis_no   = uwm301.cha_no
                            wBill.wEngine_no    = uwm301.eng_no
                            wBill.wFee          = nv_freeper
                            wBill.wFeeamount    = (nv_Netprm  * nv_freeper) / 100
                            wBill.wFee_orthe    = 0  .
                    END.  /* find first wBill */
                END.     /*130*/
            END.  /* uwm301 */
        END.   /* avail  uwm100 */
    END.     /* for each Agtprm_fil */
/*END.    /* wfAcno */ /*kridtiya i. A53-0394*/*/
HIDE ALL NO-PAUSE.
IF vCountRec = 0 THEN DO:
    MESSAGE "ไม่พบข้อมูล ที่จะส่งออก" VIEW-AS ALERT-BOX INFORMATION.
    RETURN NO-APPLY.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ C-Win 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure03 NO-LOCK
                     WHERE Insure.CompNo = fiCompNo2
     BY Insure.fname .
     RUN pdDispIns.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE procdisable C-Win 
PROCEDURE procdisable :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DISABLE 
    fiCompNo   
    fiInComp   
    fiInBranch 
    fiFName    
    fi_freeper 
  WITH FRAME fr_main.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcUpdateinsure C-Win 
PROCEDURE ProcUpdateinsure :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER cmode AS CHAR.
DEF BUFFER bIns FOR Insure.
DEF VAR logAns    AS LOGI INIT No.  
DEF VAR rIns      AS ROWID.
DEF VAR vInsNo    AS INTE INIT 0.
DEF VAR vInsC     AS CHAR FORMAT "X" INIT "W".
DEF VAR vInsFirst AS CHAR.   /* multi  company*/
ASSIGN 
    pComp = fiCompno2.
FIND FIRST Company WHERE Company.CompNo =  pComp  .
DO:  vInsFirst = Company.InsNoPrf. END.          
ASSIGN
    rIns   = ROWID (Insure)
    logAns = No.
IF cmode = "ADD" THEN DO:
    MESSAGE "เพิ่มข้อมูลรายการ Free% " UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "เพิ่มข้อมูลรายการ Free% Complete ".
    IF logAns THEN DO:
        FIND LAST bIns   USE-INDEX Insure01 WHERE bIns.CompNo = pComp NO-LOCK NO-ERROR.
        CREATE Insure.
    END.
END.
ELSE IF cmode = "UPDATE" THEN DO WITH FRAME fr_main  /*{&FRAME-NAME}*/:
    GET CURRENT brInsure EXCLUSIVE-LOCK.
END.
ASSIGN 
    FRAME fr_main    fiCompNo2   
    FRAME fr_main    fiInComp   
    FRAME fr_main    fiInBranch 
    FRAME fr_main    fiFName    
    FRAME fr_main    fi_freeper 
    insure.compno = caps(fiCompNo2)    
    Insure.FName  = fiInComp    
    Insure.Branch = caps(fiInBranch)  
    Insure.InsNo  = caps(fiFName)     
    Insure.deci1  = fi_freeper  
    
    /*btnFirst:Sensitive IN FRAM fr_main = Yes
        btnPrev:Sensitive  IN FRAM fr_main = Yes
        btnNext:Sensitive  IN FRAM fr_main = Yes
        btnLast:Sensitive  IN FRAM fr_main = Yes*/
          
        btnInAdd:Sensitive    IN FRAM fr_main = Yes
        btnInUpdate:Sensitive IN FRAM fr_main = Yes
        btnInDelete:Sensitive IN FRAM fr_main = Yes
          
        btnInOK:Sensitive     IN FRAM fr_main = No
        btnInCancel:Sensitive IN FRAM fr_main = NO
        brInsure:Sensitive    IN FRAM fr_main = Yes.   
        
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO brInsure IN FRAME fr_main.
    /*RUN ProcDisable IN THIS-PROCEDURE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createproducer C-Win 
PROCEDURE proc_createproducer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN vChkFirstAdd = 1 .
IF vChkFirstAdd = 1 THEN DO:
    DO WITH FRAME  fr_main :
        /*vProdCod = "A0M0061,A0M1011,A0M0018,A0M0019,A0M0073,A0M0062". *//*A58-0094*/
        vProdCod = "A0M0061,A0M1011,A0M0018,A0M0019,A0M0073,A0M0062,A0M0012".     /*A58-0094*/
        se_producer:ADD-FIRST(vProdCod).
        se_producer = se_producer:SCREEN-VALUE .
        vProdCod = se_producer:List-items.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_dispwfree C-Win 
PROCEDURE proc_dispwfree :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DISPLAY 
     wbfree.branch     @ fi_branchfree    
     wbfree.poltyp     @ fi_poltyp
     wbfree.freeper    @ fi_freeper
   WITH FRAME frmain.*/

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
    nv_fee01              = ""  . 
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
FOR EACH wBill2 .
    DELETE wBill2.
END. 
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

        IF trim(nv_RecordType) = "H"  THEN NEXT.
            /*CREATE wBill2.
            ASSIGN 
                wBill2.recordtyp    = nv_RecordType       
                wBill2.sequenceno   = nv_Sequenceno       
                wBill2.companyname  = nv_INS_PolicyNo     
                wBill2.product      = nv_insuranceType    
                wBill2.insurcename  = nv_CustomerTitleName
                wBill2.insurcecode  = nv_CustomerFirstNAME
                wBill2.product      = nv_CustomerLastName .
        END.*/
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
            /*CREATE wBill2.
            ASSIGN 
                wBill2.recordtyp    = nv_RecordType         
                wBill2.sequenceno   = nv_Sequenceno         
                wBill2.companyname  = nv_INS_PolicyNo       
                wBill2.product      = nv_insuranceType      
                wBill2.insurcename  = nv_CustomerTitleName  
                wBill2.insurcecode  = nv_CustomerFirstNAME  
                wBill2.asofdate     = nv_CustomerLastName   
                wBill2.producttype  = nv_comdate   .    
        END.*/
         ELSE IF trim(nv_RecordType) = "" THEN NEXT.
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
IF INDEX(fi_outputcon,".txt") = 0 THEN fi_outputcon = fi_outputcon + "_mat.txt".
OUTPUT STREAM filebill1 TO VALUE(fi_outputcon).
ASSIGN
    vExpCount1  = 0
    nv_sumprem  = 0
    /*nv_sumcomp  = 0*/
    n_wRecordno = 1.

PUT STREAM filebill1
    "H"                              FORMAT "X"      "|"      
    "00001"                          FORMAT "99999"  "|"     
    "บริษัทประกันคุ้มภัย จำกัดมหาชน" FORMAT "X(40)"  "|"       
    "KPI"                            FORMAT "X(4)"   "|" 
    dateasof                         FORMAT "X(8)"   "|" 
    "1"                              FORMAT "X"      "|"      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                        FORMAT "X"        
    SKIP. 
FOR EACH wBill2 USE-INDEX wBill202 WHERE wBill2.recordtyp = "D" NO-LOCK
    BREAK BY wBill2.wPolicy.
     
    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1  + 1
        nv_sumprem  = nv_sumprem  +  deci(wBill2.wtotNetprm)    . 
    PUT STREAM filebill1
        "D"                FORMAT "X"                            "|"   /* 1  Record Type      */
        n_wRecordno        FORMAT "99999"                        "|"   /* 2  Sequence no. */
        wBill2.wPolicy     FORMAT "x(20)"                        "|"   /* 3  INS. Policy No.      */               
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
END.   /* for each wBill2 */
ASSIGN 
    /*nv_sum      = nv_sumprem + nv_sumcomp */
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
FOR EACH wbill2.
    DELETE wbill2.
END.
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
        IF trim(nv_RecordType) = "H"  THEN NEXT .
            /*CREATE wBill2.
            ASSIGN 
                wBill2.recordtyp     = nv_RecordType       
                wBill2.sequenceno    = nv_Sequenceno       
                wBill2.companyname   = nv_INS_PolicyNo     
                wBill2.product       = nv_insuranceType    
                wBill2.insurcename   = nv_CustomerTitleName
                wBill2.insurcecode   = nv_CustomerFirstNAME
                wBill2.product       = nv_CustomerLastName   .
            END.*/
        ELSE IF trim(nv_RecordType) = "D"  THEN DO:
            CREATE wBill2.
            ASSIGN 
                wBill2.recordtyp      =   TRIM(nv_RecordType)         
                wBill2.sequenceno     =   TRIM(nv_Sequenceno)        
                wBill2.wPolicy        =   IF substr(TRIM(nv_INS_PolicyNo),1,1) <> "0" THEN  ("0" + TRIM(nv_INS_PolicyNo)) ELSE TRIM(nv_INS_PolicyNo)  
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
            /*CREATE wBill2.
            ASSIGN 
                    wBill2.recordtyp    = nv_RecordType         
                    wBill2.sequenceno   = nv_Sequenceno         
                    wBill2.companyname  = nv_INS_PolicyNo       
                    wBill2.product      = nv_insuranceType .    
           END.*/
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
IF INDEX(fi_outputcon,".txt") = 0 THEN fi_outputcon = fi_outputcon + "_mat.txt".
OUTPUT STREAM filebill1 TO VALUE(fi_outputcon).
ASSIGN
    vExpCount1 = 0
    nv_sumprem = 0
    /*nv_sumcomp = 0*/
    n_wRecordno = 1.

PUT STREAM filebill1
    "H"                               FORMAT "X"       "|"      
    "00001"                           FORMAT "99999"   "|"      
    "บริษัทประกันคุ้มภัย จำกัดมหาชน"  FORMAT "X(40)"   "|"       
    "KPI"                             FORMAT "X(4)"    "|" 
    dateasof                          FORMAT "X(8)"    "|"   
    "2"                               FORMAT "X"       "|"      /*1' ภาคสมัครใจ , '2' พ.ร.บ.*/
    n_binloop                         FORMAT "X"        SKIP. 

FOR EACH wBill2 USE-INDEX wBill202 WHERE wBill2.recordtyp = "D" NO-LOCK
    BREAK BY wBill2.wPolicy.
    ASSIGN
        n_wRecordno = n_wRecordno + 1 
        vExpCount1  = vExpCount1  + 1
        nv_sumprem  = nv_sumprem  + (DECI(wBill2.wtotNetprm))   . 
    PUT STREAM filebill1
        "D"                                      FORMAT "X"       "|"   
        n_wRecordno                              FORMAT "99999"   "|"   
        wBill2.wPolicy                           FORMAT "x(13)"   "|"   
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
END.   /* for each wBill2 */
ASSIGN 
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

