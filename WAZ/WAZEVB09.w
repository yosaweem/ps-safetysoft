&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          stat             PROGRESS
*/
&Scoped-define WINDOW-NAME WAZRBV08
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WAZRBV08 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created:
  
  Modify by : Yosawee M.  ASSIGN : A67-0066  DATE : 17/06/2025
              Issue โปรแกรมบนระบบ Safety's Soft ขึ้น Error Image was not found
  ------------------------------------------------------------------- 
  Copyright : Safety Insurance Public Company Limited
              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
  CREATE BY : SUTHIDA T.  A540093  31-05-11
              โปรแกรมคีย์งาน เฉพาะ Type 'B' = ภาษีซื้อ     
              และที่เป็น TYPE 1 ค่าซ่อม+ค่าแรง 
------------------------------------------------------------------- 
Modify By   : Suthida T. A54-0293 26-09-11
             -> เมื่อทำการใส่ข้อมูลเรียบร้อยแล้วทำการกดปุ่ม Search กว่าข้อมูลจะแสดงช้ามากค่ะ
             -> เมื่อกดปุ่ม SAVE 2 ครั้ง หน้าจอจะค้าง
------------------------------------------------------------------------
Modify By   : Suthida T. A55-0063 22-02-12
            ->  ในส่วนของ VAT SYSTEM ช่อง Tax Month /Invoice Branch
               / Vat % /Inv date 
            -> ในส่วนของ VAT SYSTEM ช่อง TAX ID / Comp name / Address 
              ให้ยังคงที่ไว้ไม่ต้องเคลียค่า จะเตลียค่าก็ต่อเมื่อกดปุ่ม Search  
              และ ช่อง PAY TO มีการเปลี่ยนแปลง  
           ->ในส่วนของ Print Cheque Claim  ให้ช่อง Amount  อยู่
             หลังช่อง Policy และ เพิ่มให้แสดง ชื่อบริษัท หลังช่อง Amount 
------------------------------------------------------------------------             
/*Modify By: Chaiyong W. A54-0112 02/01/2013*/
/*          Change format vehreg 10 to 11   */      

/*------------------------------------------------------------------------*/  
/* Modify By : Piyachat P. DATE 25-03-2013  A56-0097                      */    
/*           - เลขที่ใบกำกับ ช่อง Ref.No  กรณีมีเลขที่ซ้ำกัน ให้ทำการ     */
/*             เช็ค Policy No. ร่วมด้วย                                   */ 
/*------------------------------------------------------------------------*/
 Modify By   : Suthida T. A56-0339 11-11-2013
              ->  เพิ่มช่องสำนักงานใหญ่/สาขาที่ กรณี่ที่เป็นงานนิติบุคคล
------------------------------------------------------------------------
 Modify By   : Suthida T. A57-0196 11-06-2014
              -> Browser   ให้ย้ายช่อง Licence มาอยู่ด้านหน้าของช่อง Company ค่ะ
------------------------------------------------------------------------
 Modify By   :  Manop G  . A59-0367   19/08/2016
              ->  เพิ่มแก้ไข ให้ มีข้อความ "JVโอนอู่ สำหรับสาขา"
              
------------------------------------------------------------------------
 Modify By   :  Manop G  . A59-0533   20/11/2016
              ->  Auto เลข PV No.
------------------------------------------------------------------------
 Modify By   :  Manop G  . A59-0611   15/12/2016
              ->  ให้โชว์ ยอด Total   /   Vat amo    /Grand Total 
              ->  เลือกข้อมูลในช่อง Browse 
------------------------------------------------------------------------
Modify By  :  MANOP  G>  A60-0072    08/02/2017              
                Duplicate WAZEVB08.W    
            ->  แยกโปรแกรมระหว่าง สนญ. และ สาขา
------------------------------------------------------------------------
Modify By  :  MANOP  G.  A62-0266   31/05/2019
            ->  Auto PVRVJV No.  Branch
------------------------------------------------------------------------*/

/*          This .W file was created with the Progress AppBuilder.      */
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
DEF SHARED VAR n_User   AS CHAR.
DEF SHARED VAR n_Passwd AS CHAR.
      

DEF            VAR n_year      AS    CHAR  FORMAT "X(2)".
DEF            VAR n_brndes    AS    CHAR  FORMAT "X(20)".
DEF            VAR n_brnno     AS    CHAR  FORMAT "X(2)".
DEF            VAR n_refno     AS    CHAR  FORMAT "X(16)".
DEF            VAR n_crevat_p  AS    DECI  FORMAT ">>9.99-".
DEF            VAR n_crevat    AS    CHAR  FORMAT "X".
DEF            VAR n_btyp      AS    CHAR  FORMAT "X".
DEF            VAR n_branch    AS    CHAR  FORMAT "X(3)".
DEF            VAR n_choice    AS    LOGIC.
DEF            VAR nv_ratevat  AS    INTEGER.
DEF            VAR nv_tol      AS    DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEF            VAR nv_branch   LIKE arm120.branch.
DEF            VAR nv_acno     LIKE arm130.acno. /* ----- Suthida T. A54-0293 -------- */
DEF            VAR nv_sort     AS    CHAR  INIT "By Pay To.,By req No." .
DEF            VAR nv_pay      AS    CHAR  FORMAT "X(10)". /* ---- suthida T. A55-0063 ----*/ 
DEF            FRAME a.

/*-- Manop G. A59-0611 --*/
DEF            VAR n_amount1      AS DECIMAL FORMAT ">>>,>>>,>>9.99".
DEF            VAR n_tot          AS DECIMAL FORMAT ">>>,>>>,>>9.99".
DEF            VAR n_vat          AS DECIMAL FORMAT ">>>,>>>,>>9.99".
DEF            VAR n_grd          AS DECIMAL FORMAT ">>>,>>>,>>9.99".
/*DEF            VAR n_tot          AS DECIMAL FORMAT ">>>,>>>,>>9.99".*/
DEF            VAR nv_selcnt     AS INT INIT 0.
DEF            VAR n_book        AS CHAR .

DEF WORKFILE warm120
    FIELD  policy  LIKE arm120.policy
    FIELD  trnty1  LIKE arm120.trnty1
    FIELD  docno   LIKE arm120.docno
    FIELD  pdate   LIKE arm120.trndat
    FIELD  insf    LIKE arm120.ref
    FIELD  prem    LIKE arm120.aramt
    FIELD  licen   LIKE arm120.vehreg
    FIELD  cdate   LIKE arm130.cdate
    FIELD  acno    LIKE arm130.acno
    FIELD  taxid   LIKE tax001.taxid
    FIELD  name    LIKE tax001.name         
    FIELD  paddr1  LIKE tax001.addr1 
    FIELD  paddr2  LIKE tax001.addr2
    FIELD  amount  LIKE arm120.aramt
    FIELD  TOTAL   AS   DECIMAL FORMAT ">,>>>,>>>,>>9.99" 
    FIELD  PVRVJV  LIKE arm120.rvno
    FIELD  ratw    LIKE arm130.text3
    FIELD  ratV    LIKE arm130.text2
    FIELD  branch  LIKE arm120.branch
    FIELD  Text1   AS CHAR FORMAT "X(10)".


DEF WORKFILE bwarm120 
    FIELD  policy  LIKE arm120.policy
    FIELD  trnty1  LIKE arm120.trnty1
    FIELD  docno   LIKE arm120.docno
    FIELD  pdate   LIKE arm120.trndat
    FIELD  insf    LIKE arm120.ref
    FIELD  prem    LIKE arm120.aramt
    FIELD  licen   LIKE arm120.vehreg
    FIELD  cdate   LIKE arm130.cdate
    FIELD  acno    LIKE arm130.acno
    FIELD  taxid   LIKE tax001.taxid
    FIELD  name    LIKE tax001.name         
    FIELD  paddr1  LIKE tax001.addr1 
    FIELD  paddr2  LIKE tax001.addr2
    FIELD  amount  LIKE arm120.aramt
    FIELD  TOTAL   AS   DECIMAL FORMAT ">,>>>,>>>,>>9.99" 
    FIELD  PVRVJV  LIKE arm120.rvno
    FIELD  ratw    LIKE arm130.text3
    FIELD  ratV    LIKE arm130.text2
    FIELD  branch  LIKE arm120.branch
    FIELD  Text1   AS CHAR FORMAT "X(10)".

DEF STREAM ns1.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fMain
&Scoped-define BROWSE-NAME br_paid

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES warm120 VAT100

/* Definitions for BROWSE br_paid                                       */
&Scoped-define FIELDS-IN-QUERY-br_paid warm120.text1 warm120.trnty + "-" + STRING(warm120.docno) warm120.policy warm120.prem warm120.licen /* --- suthida T. A57-0196 ย้ายตน. --- */ warm120.NAME warm120.cdate warm120.insf /*--- warm120.licen comment by Chaiyong W. A54-0112 03/01/2013*/ /*warm120.licen /*---add by Chaiyong W. A54-0112 03/01/2013*/--- suthida t. A57-0196 ย้าย ตน.*/ warm120.PVRVJV   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_paid   
&Scoped-define SELF-NAME br_paid
&Scoped-define QUERY-STRING-br_paid FOR EACH warm120 NO-LOCK
&Scoped-define OPEN-QUERY-br_paid OPEN QUERY br_paid FOR EACH warm120 NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_paid warm120
&Scoped-define FIRST-TABLE-IN-QUERY-br_paid warm120


/* Definitions for BROWSE br_vat100                                     */
&Scoped-define FIELDS-IN-QUERY-br_vat100 VAT100.invoice VAT100.refno ~
VAT100.policy VAT100.pvrvjv VAT100.invbrn ~
STRING (VAT100.taxmont,"99")  + "/" +  STRING (VAT100.taxyear,"9999") 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_vat100 
&Scoped-define QUERY-STRING-br_vat100 FOR EACH VAT100 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_vat100 OPEN QUERY br_vat100 FOR EACH VAT100 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_vat100 VAT100
&Scoped-define FIRST-TABLE-IN-QUERY-br_vat100 VAT100


/* Definitions for FRAME fMain                                          */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fMain ~
    ~{&OPEN-QUERY-br_paid}

/* Definitions for FRAME frvat                                          */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_savese tg_select bu_desc cb_sort fi_trnty ~
fi_docno br_paid fi_pay fi_paid fi_vc bu_search fi_mon fi_year fi_ref fi_pv ~
fi_clmtyp fi_clmno fi_policy fi_book fi_ratevat fi_inv fi_buytype fi_taxre ~
fi_taxid fi_brncus fi_comname1 fi_comaddr1 fi_comaddr2 fi_typedesc ~
fi_typedesc2 fi_amount1 fi_amount2 fi_ram1 fi_ram2 fi_crevat fi_crev ~
bu_save bu_exit RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 RECT-16 RECT-17 ~
RECT-18 RECT-19 
&Scoped-Define DISPLAYED-OBJECTS tg_select fi_date fi_vc2 cb_sort fi_pd ~
fi_trnty fi_docno fi_Cqclm fi_ratw fi_pay fi_paid fi_net fi_vc fi_tol ~
fi_vat7 fi_withhold fi_netamount fi_mon fi_year fi_branch fi_ref fi_branchs ~
fi_pv fi_clmtyp fi_clmno fi_policy fi_book fi_ratevat fi_ent fi_inv ~
fi_buytype fi_taxre fi_taxid fi_brncus fi_comname1 fi_comaddr1 fi_comaddr2 ~
fi_typedesc fi_typedesc2 fi_amount1 fi_amount2 fi_tot fi_vat fi_grd fi_ram1 ~
fi_ram2 fi_crevat fi_crev fi_ratv fi_totv100 fi_selcnt 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WAZRBV08 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_desc 
     IMAGE-UP FILE "WIMAGE/help.bmp":U /*----EDIT TO Yosawee M. A67-0066 17/06/2025----*/
     LABEL ". . ." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 12.67 BY 1.57
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "SAVE" 
     SIZE 12.67 BY 1.57
     FONT 6.

DEFINE BUTTON bu_savese 
     LABEL "Save Select" 
     SIZE 14.83 BY 1.57
     BGCOLOR 8 FGCOLOR 12 FONT 6.

DEFINE BUTTON bu_search 
     LABEL "Search" 
     SIZE 9.83 BY .91
     FONT 6.

DEFINE VARIABLE cb_sort AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 12.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_amount1 AS DECIMAL FORMAT "->>>,>>>,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_amount2 AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_book AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(20)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branchs AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 13.17 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_brncus AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_buytype AS CHARACTER FORMAT "X(1)":U INITIAL "no" 
     VIEW-AS FILL-IN 
     SIZE 3.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_clmno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_clmtyp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comaddr1 AS CHARACTER FORMAT "X(54)":U 
     VIEW-AS FILL-IN 
     SIZE 48.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comaddr2 AS CHARACTER FORMAT "X(54)":U 
     VIEW-AS FILL-IN 
     SIZE 48.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comname1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_Cqclm AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_crev AS DECIMAL FORMAT ">>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_crevat AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 5.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_date AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 8 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_docno AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_ent AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_grd AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_inv AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_mon AS INTEGER FORMAT "99":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_net AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_netamount AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_paid AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pay AS CHARACTER FORMAT "X(30)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pd AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY 1
     BGCOLOR 8 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pv AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ram1 AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 49.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ram2 AS CHARACTER FORMAT "X(70)":U 
     VIEW-AS FILL-IN 
     SIZE 49.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ratevat AS DECIMAL FORMAT ">9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ratv AS CHARACTER FORMAT "X(10)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     FGCOLOR 14 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ratw AS CHARACTER FORMAT "X(10)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     FGCOLOR 14 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ref AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_selcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3.5 BY 1
     BGCOLOR 3 FGCOLOR 14 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_taxid AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 19.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_taxre AS LOGICAL FORMAT "yes/no":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 9.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tol AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_tot AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_totv100 AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_trnty AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_typedesc AS CHARACTER FORMAT "XX":U 
     VIEW-AS FILL-IN 
     SIZE 4.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_typedesc2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 26.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vat AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_vat7 AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_vc AS CHARACTER FORMAT "XX-XXXX/XXXXX":U INITIAL ? 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vc2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 8 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_withhold AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE fi_year AS INTEGER FORMAT ">>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-16
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 66.5 BY 5.67.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67 BY 1.43
     BGCOLOR 3 FGCOLOR 7 .

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 35 BY 1.43
     BGCOLOR 3 FGCOLOR 0 .

DEFINE RECTANGLE RECT-19
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17.83 BY 5.57
     BGCOLOR 3 FGCOLOR 7 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65 BY 22.24
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 68 BY 22.24
     BGCOLOR 3 FGCOLOR 14 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 27.5 BY 2
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 65.67 BY 2.86
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.19
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 30.5 BY 1.19
     BGCOLOR 2 FGCOLOR 0 .

DEFINE VARIABLE tg_select AS LOGICAL INITIAL no 
     LABEL "" 
     VIEW-AS TOGGLE-BOX
     SIZE 2 BY .95
     BGCOLOR 3 FGCOLOR 14 FONT 6 NO-UNDO.

DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 75.5 BY 7.81
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-15
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 75.5 BY 1.91
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_paid FOR 
      warm120 SCROLLING.

DEFINE QUERY br_vat100 FOR 
      VAT100 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_paid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_paid WAZRBV08 _FREEFORM
  QUERY br_paid NO-LOCK DISPLAY
      warm120.text1  COLUMN-LABEL " "          FORMAT "X(5)"
       warm120.trnty  + "-" + 
STRING(warm120.docno) COLUMN-LABEL "REQ.No."     FORMAT "X(10)"
       warm120.policy COLUMN-LABEL "Policy No."  FORMAT "X(16)"
       warm120.prem   COLUMN-LABEL "Amount"      FORMAT ">>>,>>>,>>>,>>9.99-"
       warm120.licen  COLUMN-LABEL "Licence"     FORMAT "X(11)"   /* --- suthida T. A57-0196 ย้ายตน. --- */
       warm120.NAME   COLUMN-LABEL "Company"     FORMAT "X(30)"
       warm120.cdate  COLUMN-LABEL "PAID"        FORMAT "99/99/9999"
       warm120.insf   COLUMN-LABEL "INSURED"     FORMAT "X(30)"
       /*---
       warm120.licen  COLUMN-LABEL "Licence"     FORMAT "X(10)"
       comment by Chaiyong W. A54-0112 03/01/2013*/
       /*warm120.licen  COLUMN-LABEL "Licence"     FORMAT "X(11)" /*---add by Chaiyong W. A54-0112 03/01/2013*/--- suthida t. A57-0196 ย้าย ตน.*/
       warm120.PVRVJV COLUMN-LABEL "PVRVJV"      FORMAT "X(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 66.33 BY 11.67
         BGCOLOR 15 .

DEFINE BROWSE br_vat100
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_vat100 WAZRBV08 _STRUCTURED
  QUERY br_vat100 NO-LOCK DISPLAY
      VAT100.invoice FORMAT "x(16)":U
      VAT100.refno FORMAT "x(16)":U
      VAT100.policy FORMAT "x(16)":U
      VAT100.pvrvjv FORMAT "x(16)":U
      VAT100.invbrn COLUMN-LABEL "รหัสสาขา" FORMAT "x(2)":U WIDTH 10
      STRING (VAT100.taxmont,"99")  + "/" +  STRING (VAT100.taxyear,"9999") COLUMN-LABEL "Tax Month/Year"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 73.17 BY 6.95
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fMain
     bu_savese AT ROW 19.95 COL 52.83
     tg_select AT ROW 17.95 COL 65.5
     bu_desc AT ROW 14.24 COL 88.67
     fi_date AT ROW 4.81 COL 1 COLON-ALIGNED NO-LABEL
     fi_vc2 AT ROW 4.81 COL 27.5 COLON-ALIGNED NO-LABEL
     cb_sort AT ROW 3.62 COL 11 COLON-ALIGNED NO-LABEL
     fi_pd AT ROW 3.62 COL 24 COLON-ALIGNED NO-LABEL
     fi_trnty AT ROW 3.62 COL 36.5 COLON-ALIGNED NO-LABEL
     fi_docno AT ROW 3.62 COL 42 COLON-ALIGNED NO-LABEL
     fi_Cqclm AT ROW 23.62 COL 26.67 COLON-ALIGNED NO-LABEL
     fi_ratw AT ROW 21 COL 17.33 COLON-ALIGNED NO-LABEL
     br_paid AT ROW 6 COL 2
     fi_pay AT ROW 3.62 COL 42 COLON-ALIGNED NO-LABEL
     fi_paid AT ROW 4.81 COL 14 COLON-ALIGNED NO-LABEL
     fi_net AT ROW 19 COL 26.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_vc AT ROW 4.81 COL 37.5 COLON-ALIGNED NO-LABEL
     bu_search AT ROW 4.95 COL 57
     fi_tol AT ROW 18 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_vat7 AT ROW 20 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_withhold AT ROW 21 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_netamount AT ROW 21.95 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_mon AT ROW 3.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 3.24 COL 90.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.24 COL 82.33 COLON-ALIGNED NO-LABEL
     fi_ref AT ROW 4.24 COL 112 COLON-ALIGNED NO-LABEL
     fi_branchs AT ROW 4.24 COL 88.83 COLON-ALIGNED NO-LABEL
     fi_pv AT ROW 5.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_clmtyp AT ROW 6.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_clmno AT ROW 6.24 COL 86.83 COLON-ALIGNED NO-LABEL
     fi_policy AT ROW 6.29 COL 112.33 COLON-ALIGNED NO-LABEL
     fi_book AT ROW 7.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_ratevat AT ROW 7.24 COL 112.33 COLON-ALIGNED NO-LABEL
     fi_ent AT ROW 8.24 COL 112.33 COLON-ALIGNED NO-LABEL
     fi_inv AT ROW 8.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_buytype AT ROW 9.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_taxre AT ROW 9.24 COL 112.33 COLON-ALIGNED NO-LABEL
     fi_taxid AT ROW 10.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_brncus AT ROW 10.29 COL 112.33 COLON-ALIGNED NO-LABEL
     fi_comname1 AT ROW 11.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_comaddr1 AT ROW 12.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_comaddr2 AT ROW 13.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_typedesc AT ROW 14.24 COL 82.17 COLON-ALIGNED NO-LABEL
     fi_typedesc2 AT ROW 15.24 COL 82 COLON-ALIGNED NO-LABEL
     fi_amount1 AT ROW 15.24 COL 109.5 COLON-ALIGNED NO-LABEL
     fi_amount2 AT ROW 16.24 COL 109.5 COLON-ALIGNED NO-LABEL
     fi_tot AT ROW 17.24 COL 109.5 COLON-ALIGNED NO-LABEL
     fi_vat AT ROW 18.24 COL 109.5 COLON-ALIGNED NO-LABEL
     fi_grd AT ROW 19.24 COL 109.5 COLON-ALIGNED NO-LABEL
     fi_ram1 AT ROW 20.24 COL 81.5 COLON-ALIGNED NO-LABEL
     fi_ram2 AT ROW 21.24 COL 81.5 COLON-ALIGNED NO-LABEL
     fi_crevat AT ROW 22.24 COL 81.5 COLON-ALIGNED NO-LABEL
     fi_crev AT ROW 22.24 COL 89.17 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 23 COL 105.83
     bu_exit AT ROW 23 COL 119
     fi_ratv AT ROW 20 COL 17.33 COLON-ALIGNED NO-LABEL
     fi_totv100 AT ROW 23.57 COL 81 COLON-ALIGNED NO-LABEL
     fi_selcnt AT ROW 18.86 COL 62.5 COLON-ALIGNED NO-LABEL
     "Buy Type       :" VIEW-AS TEXT
          SIZE 14.33 BY .71 AT ROW 9.38 COL 69.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.99 BY 24
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fMain
     "%" VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 21 COL 26.83
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Claim.No.       :" VIEW-AS TEXT
          SIZE 14.33 BY .67 AT ROW 6.43 COL 69.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Vat  %  :" VIEW-AS TEXT
          SIZE 8.33 BY .67 AT ROW 7.38 COL 105.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "NET AMOUNT :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 22.05 COL 4.17
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "TOTAL (บวก VAT 7%)  :" VIEW-AS TEXT
          SIZE 23.33 BY 1 AT ROW 18 COL 3.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Policy.:" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 6.24 COL 106.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Select All :" VIEW-AS TEXT
          SIZE 10.83 BY 1 AT ROW 17.91 COL 53.83
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Cust.Brn:" VIEW-AS TEXT
          SIZE 9.5 BY .67 AT ROW 10.38 COL 104.83
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "/" VIEW-AS TEXT
          SIZE 1.67 BY .91 TOOLTIP "/" AT ROW 3.19 COL 91
          BGCOLOR 3 
     "NET VAT  :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 19 COL 4
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "(Y/N/E)" VIEW-AS TEXT
          SIZE 9 BY .71 AT ROW 9.33 COL 88.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Tax ID           :" VIEW-AS TEXT
          SIZE 14.67 BY .67 AT ROW 10.52 COL 69.33
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Book N0./No  :" VIEW-AS TEXT
          SIZE 14.33 BY 1 AT ROW 7.24 COL 69.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     " Vat System" VIEW-AS TEXT
          SIZE 16 BY .81 AT ROW 2.38 COL 69.83
          BGCOLOR 3 FGCOLOR 7 FONT 2
     "Ref.No:" VIEW-AS TEXT
          SIZE 7.5 BY .67 AT ROW 4.48 COL 106.17
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Type  Desc    :" VIEW-AS TEXT
          SIZE 14.33 BY .67 AT ROW 14.52 COL 69.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "UPDATE INPUT VAT(B)" VIEW-AS TEXT
          SIZE 25.33 BY .95 AT ROW 1.24 COL 53.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Tax Repayment :" VIEW-AS TEXT
          SIZE 16.5 BY .67 AT ROW 9.43 COL 97.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Credit Vat    :" VIEW-AS TEXT
          SIZE 12.5 BY .67 AT ROW 22.38 COL 69.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "จำนวนที่เลือก :" VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 18.81 COL 51.33
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Vat amount     :" VIEW-AS TEXT
          SIZE 15 BY .67 AT ROW 18.33 COL 93.17
          BGCOLOR 3 FGCOLOR 14 FONT 6
     " Print Cheque Claim" VIEW-AS TEXT
          SIZE 26.5 BY .81 AT ROW 2.24 COL 2.17
          BGCOLOR 3 FGCOLOR 7 FONT 2
     "Remarks      :" VIEW-AS TEXT
          SIZE 13.33 BY .67 AT ROW 20.43 COL 69.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Grand Total    :" VIEW-AS TEXT
          SIZE 15.33 BY .67 AT ROW 19.43 COL 93.17
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "%" VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 20 COL 26.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "หักส่วนลด       :" VIEW-AS TEXT
          SIZE 15.17 BY .67 AT ROW 16.43 COL 93.83
          BGCOLOR 3 FGCOLOR 14 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.99 BY 24
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fMain
     "%" VIEW-AS TEXT
          SIZE 1.83 BY .86 AT ROW 22.38 COL 100.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Tax Month      :" VIEW-AS TEXT
          SIZE 14.67 BY .67 AT ROW 3.38 COL 69.33
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "VAT   :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 20 COL 4.17
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "WITHHOL.TAX:" VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 21 COL 4
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Inv Branch     :" VIEW-AS TEXT
          SIZE 14.5 BY .67 AT ROW 4.43 COL 69.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     " :" VIEW-AS TEXT
          SIZE 1 BY .95 AT ROW 22.29 COL 89.33
          BGCOLOR 3 FGCOLOR 14 
     "Total             :" VIEW-AS TEXT
          SIZE 15.5 BY .67 AT ROW 17.38 COL 93.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Comp Name    :" VIEW-AS TEXT
          SIZE 14.33 BY .67 AT ROW 11.43 COL 69.5
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "SORT BY:" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 3.62 COL 3
          BGCOLOR 8 FONT 6
     "จำนวนเงิน Amount" VIEW-AS TEXT
          SIZE 17.5 BY .67 AT ROW 14.48 COL 115.83
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Inv Date        :" VIEW-AS TEXT
          SIZE 14.33 BY .67 AT ROW 8.38 COL 69.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Pv/Rv/Jv No. :" VIEW-AS TEXT
          SIZE 14.33 BY .67 AT ROW 5.43 COL 69.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "รายการ DESCRIPTION" VIEW-AS TEXT
          SIZE 22 BY .67 AT ROW 14.43 COL 93.83
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Total Cheque Claim :" VIEW-AS TEXT
          SIZE 21.17 BY .95 AT ROW 23.62 COL 4
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Entry Date :" VIEW-AS TEXT
          SIZE 11.67 BY .67 AT ROW 8.33 COL 102.17
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Total Vat100 :" VIEW-AS TEXT
          SIZE 13.33 BY .95 AT ROW 23.57 COL 69.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     "Address         :" VIEW-AS TEXT
          SIZE 14.33 BY .71 AT ROW 12.33 COL 69.67
          BGCOLOR 3 FGCOLOR 14 FONT 6
     RECT-4 AT ROW 2.67 COL 68.83
     RECT-5 AT ROW 2.67 COL 1
     RECT-6 AT ROW 22.76 COL 105
     RECT-7 AT ROW 3.05 COL 2.17
     RECT-8 AT ROW 4.81 COL 56
     RECT-9 AT ROW 1.1 COL 50.83
     RECT-16 AT ROW 17.71 COL 2
     RECT-17 AT ROW 23.38 COL 2
     RECT-18 AT ROW 23.33 COL 69.33
     RECT-19 AT ROW 17.81 COL 50.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.99 BY 24
         BGCOLOR 3 .

DEFINE FRAME frvat
     br_vat100 AT ROW 2.57 COL 3
     bu_ok AT ROW 10.1 COL 21.5
     bu_cancel AT ROW 10.1 COL 38.5
     "TAX INVOICE IN VAT100" VIEW-AS TEXT
          SIZE 24.5 BY 1.19 AT ROW 1.1 COL 27.17
          BGCOLOR 14 FGCOLOR 0 FONT 6
     RECT-10 AT ROW 1.95 COL 1.83
     RECT-15 AT ROW 9.76 COL 1.83
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 30.5 ROW 6.29
         SIZE 77.5 BY 10.95
         BGCOLOR 14 .


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
  CREATE WINDOW WAZRBV08 ASSIGN
         HIDDEN             = YES
         TITLE              = "UPDATE INPUT VAT(B)"
         HEIGHT             = 24.14
         WIDTH              = 132.67
         MAX-HEIGHT         = 245
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 245
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
IF NOT WAZRBV08:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WAZRBV08
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frvat:FRAME = FRAME fMain:HANDLE.

/* SETTINGS FOR FRAME fMain
   FRAME-NAME Custom                                                    */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME frvat:MOVE-AFTER-TAB-ITEM (bu_desc:HANDLE IN FRAME fMain)
       XXTABVALXX = FRAME frvat:MOVE-BEFORE-TAB-ITEM (fi_date:HANDLE IN FRAME fMain)
/* END-ASSIGN-TABS */.

/* BROWSE-TAB br_paid fi_ratw fMain */
/* SETTINGS FOR FILL-IN fi_branch IN FRAME fMain
   NO-ENABLE                                                            */
ASSIGN 
       fi_branch:READ-ONLY IN FRAME fMain        = TRUE.

/* SETTINGS FOR FILL-IN fi_branchs IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Cqclm IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_date IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ent IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_grd IN FRAME fMain
   NO-ENABLE                                                            */
ASSIGN 
       fi_mon:AUTO-RESIZE IN FRAME fMain      = TRUE.

/* SETTINGS FOR FILL-IN fi_net IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_netamount IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_pd IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ratv IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ratw IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_selcnt IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tol IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tot IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_totv100 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vat IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vat7 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vc2 IN FRAME fMain
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_withhold IN FRAME fMain
   NO-ENABLE                                                            */
ASSIGN 
       fi_year:AUTO-RESIZE IN FRAME fMain      = TRUE.

ASSIGN 
       RECT-9:HIDDEN IN FRAME fMain           = TRUE.

/* SETTINGS FOR FRAME frvat
                                                                        */
/* BROWSE-TAB br_vat100 RECT-15 frvat */
ASSIGN 
       br_vat100:SEPARATOR-FGCOLOR IN FRAME frvat      = 8.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WAZRBV08)
THEN WAZRBV08:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_paid
/* Query rebuild information for BROWSE br_paid
     _START_FREEFORM
OPEN QUERY br_paid FOR EACH warm120 NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_paid */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_vat100
/* Query rebuild information for BROWSE br_vat100
     _TblList          = "stat.VAT100"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   = stat.VAT100.invoice
     _FldNameList[2]   = stat.VAT100.refno
     _FldNameList[3]   = stat.VAT100.policy
     _FldNameList[4]   = stat.VAT100.pvrvjv
     _FldNameList[5]   > stat.VAT100.invbrn
"VAT100.invbrn" "รหัสสาขา" ? "character" ? ? ? ? ? ? no ? no no "10" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"STRING (VAT100.taxmont,""99"")  + ""/"" +  STRING (VAT100.taxyear,""9999"")" "Tax Month/Year" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_vat100 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WAZRBV08
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WAZRBV08 WAZRBV08
ON END-ERROR OF WAZRBV08 /* UPDATE INPUT VAT(B) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WAZRBV08 WAZRBV08
ON WINDOW-CLOSE OF WAZRBV08 /* UPDATE INPUT VAT(B) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_paid
&Scoped-define SELF-NAME br_paid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_paid WAZRBV08
ON MOUSE-SELECT-CLICK OF br_paid IN FRAME fMain
DO:
   DEF BUFFER bufwarm120   FOR warm120.
   DEF BUFFER bufwarm120_2 FOR warm120.


   DEF VAR nv_recid AS RECID.
   ASSIGN nv_recid = 0.

   GET CURRENT br_paid.
   FIND CURRENT warm120 .
   /*---Select---*/
   IF AVAIL warm120 THEN DO:
       ASSIGN nv_recid = RECID(warm120).

       FIND FIRST bufwarm120 WHERE RECID(bufwarm120) = nv_recid NO-ERROR.                                                              
       IF AVAIL bufwarm120 THEN DO:                                                                                                    
                                                                                                                                       
          IF bufwarm120.text1 = "" THEN DO:                                                                                            
             ASSIGN bufwarm120.text1 = "**"      
                    nv_selcnt = nv_selcnt + 1.
                    warm120.text1:BGCOLOR IN BROWSE br_paid= 6. 

                    ASSIGN 
                    fi_selcnt   = nv_selcnt
                    fi_clmtyp   = warm120.trnty1
                    fi_clmno    = warm120.docno
                    fi_policy   = warm120.policy
                    /* ----- suthida T. A55-0063 ----
                    fi_taxid    = warm120.taxid 
                    fi_comname1 = warm120.name  
                    fi_comaddr1 = warm120.paddr1
                    fi_comaddr2 = warm120.paddr2
                    ----- suthida T. A55-0063 ---- */
                    fi_grd      = fi_grd + warm120.prem 
                    fi_ram2     = STRING(warm120.docno)
                    fi_amount1  = (warm120.prem * 100 ) / 107
                    fi_pv       = IF warm120.pvrvjv = "" THEN fi_pv ELSE warm120.pvrvjv    /*- Comment A59-0553 -*/
                    /*-fi_pv       = IF (SUBSTR(warm120.pvrvjv,1,2)) = "00" AND (SUBSTR(n_user,6,2)) <> "0" THEN "Jvโอนอู่" +  SUBSTR(n_user,6,2)  ELSE  warm120.pvrvjv /*- A59-0533 -*/
                    fi_pv       =   IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" THEN "Jvโอนอู่" +  SUBSTR(n_user,6,2)  ELSE     /* PV = 00XXXX = JVโอนอู่*/
                                    IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" AND warm120.pvrvjv = "" THEN "Jvโอนอู่" + SUBSTR(n_user,6,2) ELSE warm120.pvrvjv   /*- A59-0533 -*/  -*/
                    fi_tol      = fi_tol   - warm120.prem
                    nv_branch   = ""
                    nv_acno     = "" /* --------- Suthida T. A54-0293------- */
                    nv_branch   = warm120.branch
                    nv_acno     = warm120.acno. /*--------- Suthida T. A 54-0293------- */
                    
                    /* ------------------ suthida T. A55-0063 --------------- */
                    IF   fi_taxid = "" AND fi_comname1 = ""       AND 
                         fi_comaddr1 = "" AND fi_comaddr2 = ""    THEN
                         ASSIGN
                           fi_taxid    = warm120.taxid
                           fi_comname1 = warm120.name  
                           fi_comaddr1 = warm120.paddr1
                           fi_comaddr2 = warm120.paddr2.
                    ELSE 
                       ASSIGN
                            fi_taxid    = INPUT fi_taxid   
                            fi_comname1 = INPUT fi_comname1
                            fi_comaddr1 = INPUT fi_comaddr1
                            fi_comaddr2 = INPUT fi_comaddr2.
                    /* ------------------ suthida T. A55-0063 --------------- */
                    /* Select ลง  bwarm120 */
                    CREATE bwarm120 .
                    ASSIGN bwarm120.policy     = warm120.policy  
                           bwarm120.trnty1     = warm120.trnty1  
                           bwarm120.docno      = warm120.docno   
                           bwarm120.pdate      = warm120.pdate   
                           bwarm120.insf       = warm120.insf    
                           bwarm120.prem       = warm120.prem    
                           bwarm120.licen      = warm120.licen   
                           bwarm120.cdate      = warm120.cdate   
                           bwarm120.acno       = warm120.acno    
                           bwarm120.taxid      = warm120.taxid   
                           bwarm120.name       = warm120.name    
                           bwarm120.paddr1     = warm120.paddr1  
                           bwarm120.paddr2     = warm120.paddr2  
                           bwarm120.amount     = warm120.amount  
                           bwarm120.TOTAL      = warm120.TOTAL   
                           bwarm120.PVRVJV     = warm120.PVRVJV  
                           bwarm120.ratw       = warm120.ratw    
                           bwarm120.ratV       = warm120.ratV    
                           bwarm120.branch     = warm120.branch  
                           bwarm120.Text1      = warm120.Text1   .
          END.                                                                                                                         
          ELSE DO:                                                                                                                     
             ASSIGN bufwarm120.text1 = ""  .
             FIND CURRENT bwarm120.   
             IF AVAIL bwarm120 THEN DELETE bwarm120.
             nv_selcnt = nv_selcnt - 1.
             fi_grd      = fi_grd - warm120.prem .
             warm120.text1:BGCOLOR IN BROWSE br_paid = ?.
                    
          END.                                                                                                                         
                                                                                                                                       
       END.     


       ASSIGN warm120.text1 = bufwarm120.text1.  
       DISP warm120.text1 WITH BROWSE br_paid.


       FIND FIRST bufwarm120_2 WHERE bufwarm120_2.text1 = "" NO-ERROR.                                                                 
       IF AVAIL bufwarm120_2 THEN DO:     /* ถ้า  ไม่ mark 1 รายการ  แสดงว่า เลือก mark ไม่หมด*/                                   
          tg_select = FALSE.                                                                                                        
          DISP tg_select WITH FRAME fMain.                                                                                           
       END.                                                                                                                        
       ELSE DO:                           /* ถ้าไม่เจอ ที่ เป็น no แสดงว่า mark all  */                                            
          tg_select = TRUE.                                                                                                         
          DISP tg_select WITH FRAME fMain.                                                                                           
       END.                                                                                                                       
   /*----Select----*/                                                                                                                               
       
   END.

/*-------
    OPEN QUERY br_paid FOR EACH warm120.
------*/
    ASSIGN
         fi_net       = (fi_tol * 100) / 107
         fi_vat7      = (fi_net  * INTEGER(fi_ratv) ) / 100.
         
         fi_selcnt    = nv_selcnt.
         IF   fi_tol < 1000 THEN fi_withhold = 0.
         ELSE fi_withhold = (fi_net * (INTEGER(fi_ratw) * 0.01)).
         fi_netamount = fi_tol - fi_withhold.

    DISP fi_tol       fi_net  fi_vat7  fi_netamount fi_ratw 
         fi_withhold  fi_ratv WITH FRAME fmain.


    DISP  fi_clmtyp   fi_clmno     fi_policy
          fi_taxid    fi_comname1  fi_comaddr1 
          fi_comaddr2 fi_grd       fi_ram2      
          fi_amount1  fi_pv        fi_tol  fi_selcnt WITH FRAME fMain.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_paid WAZRBV08
ON MOUSE-SELECT-DBLCLICK OF br_paid IN FRAME fMain
DO:
  
    GET CURRENT br_paid.
    FIND CURRENT warm120 NO-LOCK. 
      ASSIGN 
        fi_clmtyp   = warm120.trnty1
        fi_clmno    = warm120.docno
        fi_policy   = warm120.policy
        /* ----- suthida T. A55-0063 ----
        fi_taxid    = warm120.taxid 
        fi_comname1 = warm120.name  
        fi_comaddr1 = warm120.paddr1
        fi_comaddr2 = warm120.paddr2
        ----- suthida T. A55-0063 ---- */
        fi_grd      = warm120.prem 
        fi_ram2     = STRING(warm120.docno)
        fi_amount1  = (warm120.prem * 100 ) / 107
        fi_pv       = IF warm120.pvrvjv = "" THEN fi_pv ELSE warm120.pvrvjv    /*- Comment A59-0553 -*/
        /*-fi_pv       = IF (SUBSTR(warm120.pvrvjv,1,2)) = "00" AND (SUBSTR(n_user,6,2)) <> "0" THEN "Jvโอนอู่" +  SUBSTR(n_user,6,2)  ELSE  warm120.pvrvjv /*- A59-0533 -*/
        fi_pv       =   IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" THEN "Jvโอนอู่" +  SUBSTR(n_user,6,2)  ELSE     /* PV = 00XXXX = JVโอนอู่*/
                        IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" AND warm120.pvrvjv = "" THEN "Jvโอนอู่" + SUBSTR(n_user,6,2) ELSE warm120.pvrvjv   /*- A59-0533 -*/  -*/
        fi_tol      = fi_tol   - warm120.prem
        nv_branch   = ""
        nv_acno     = "" /* --------- Suthida T. A54-0293------- */
        nv_branch   = warm120.branch
        nv_acno     = warm120.acno. /*--------- Suthida T. A54-0293------- */

        /* ------------------ suthida T. A55-0063 --------------- */
        IF   fi_taxid = "" AND fi_comname1 = ""       AND 
             fi_comaddr1 = "" AND fi_comaddr2 = ""    THEN
             ASSIGN
               fi_taxid    = warm120.taxid
               fi_comname1 = warm120.name  
               fi_comaddr1 = warm120.paddr1
               fi_comaddr2 = warm120.paddr2.
        ELSE 
           ASSIGN
                fi_taxid    = INPUT fi_taxid   
                fi_comname1 = INPUT fi_comname1
                fi_comaddr1 = INPUT fi_comaddr1
                fi_comaddr2 = INPUT fi_comaddr2.
        /* ------------------ suthida T. A55-0063 --------------- */
        

    DISP  fi_clmtyp   fi_clmno     fi_policy
          fi_taxid    fi_comname1  fi_comaddr1 
          fi_comaddr2 fi_grd       fi_ram2      
          fi_amount1  fi_pv        fi_tol   WITH FRAME fMain.
          

    FOR EACH warm120 WHERE 
             warm120.policy =  fi_policy AND
             warm120.docno  =  fi_clmno  /*-AND
             warm120.PVRVJV =  fi_pv  -*/   NO-LOCK.

        DELETE warm120. 
    END.

    OPEN QUERY br_paid FOR EACH warm120.

    ASSIGN
         fi_net       = (fi_tol * 100) / 107
         fi_vat7      = (fi_net  * INTEGER(fi_ratv) ) / 100.
         

         IF   fi_tol < 1000 THEN fi_withhold = 0.
         ELSE fi_withhold = (fi_net * (INTEGER(fi_ratw) * 0.01)).
         fi_netamount = fi_tol - fi_withhold.

    DISP fi_tol       fi_net  fi_vat7  fi_netamount fi_ratw 
         fi_withhold  fi_ratv WITH FRAME fmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_paid WAZRBV08
ON VALUE-CHANGED OF br_paid IN FRAME fMain
DO:
    /*----
   DEF BUFFER bufwarm120   FOR warm120.
   DEF BUFFER bufwarm120_2 FOR warm120.

   DEF VAR nv_recid AS RECID.
   ASSIGN nv_recid = 0.


   FIND CURRENT warm120.
   /*---Select---*/
   IF AVAIL warm120 THEN DO:
       ASSIGN nv_recid = RECID(warm120).

       FIND FIRST bufwarm120 WHERE RECID(bufwarm120) = nv_recid NO-ERROR.                                                              
       IF AVAIL bufwarm120 THEN DO:                                                                                                    
                                                                                                                                       
          IF bufwarm120.text1 = "" THEN DO:                                                                                            
             ASSIGN bufwarm120.text1 = "**"      
                    nv_selcnt = nv_selcnt + 1.
                    warm120.text1:BGCOLOR IN BROWSE br_paid= 6. 

                    ASSIGN 
                    fi_clmtyp   = warm120.trnty1
                    fi_clmno    = warm120.docno
                    fi_policy   = warm120.policy
                    /* ----- suthida T. A55-0063 ----
                    fi_taxid    = warm120.taxid 
                    fi_comname1 = warm120.name  
                    fi_comaddr1 = warm120.paddr1
                    fi_comaddr2 = warm120.paddr2
                    ----- suthida T. A55-0063 ---- */
                    fi_grd      = fi_grd + warm120.prem 
                    fi_ram2     = STRING(warm120.docno)
                    fi_amount1  = (warm120.prem * 100 ) / 107
                    /*-fi_pv       = IF warm120.pvrvjv = "" THEN fi_pv ELSE warm120.pvrvjv-*/    /*- Comment A59-0553 -*/
                    /*-fi_pv       = IF (SUBSTR(warm120.pvrvjv,1,2)) = "00" AND (SUBSTR(n_user,6,2)) <> "0" THEN "Jvโอนอู่" +  SUBSTR(n_user,6,2)  ELSE  warm120.pvrvjv /*- A59-0533 -*/-*/
                    fi_pv       =   IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" THEN "Jvโอนอู่" +  SUBSTR(n_user,6,2)  ELSE     /* PV = 00XXXX = JVโอนอู่*/
                                    IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" AND warm120.pvrvjv = "" THEN "Jvโอนอู่" + SUBSTR(n_user,6,2) ELSE warm120.pvrvjv   /*- A59-0533 -*/
                    fi_tol      = fi_tol   - warm120.prem
                    nv_branch   = ""
                    nv_acno     = "" /* --------- Suthida T. A54-0293------- */
                    nv_branch   = warm120.branch
                    nv_acno     = warm120.acno. /*--------- Suthida T. A54-0293------- */
                    
                    /* ------------------ suthida T. A55-0063 --------------- */
                    IF   fi_taxid = "" AND fi_comname1 = ""       AND 
                         fi_comaddr1 = "" AND fi_comaddr2 = ""    THEN
                         ASSIGN
                           fi_taxid    = warm120.taxid
                           fi_comname1 = warm120.name  
                           fi_comaddr1 = warm120.paddr1
                           fi_comaddr2 = warm120.paddr2.
                    ELSE 
                       ASSIGN
                            fi_taxid    = INPUT fi_taxid   
                            fi_comname1 = INPUT fi_comname1
                            fi_comaddr1 = INPUT fi_comaddr1
                            fi_comaddr2 = INPUT fi_comaddr2.
                    /* ------------------ suthida T. A55-0063 --------------- */

          END.                                                                                                                         
          ELSE DO:                                                                                                                     
             ASSIGN bufwarm120.text1 = ""    
                    nv_selcnt = nv_selcnt - 1.
                    fi_grd      = fi_grd - warm120.prem .
                    warm120.text1:BGCOLOR IN BROWSE br_paid = ?.

          END.                                                                                                                         
                                                                                                                                       
       END.     

       ASSIGN warm120.text1 = bufwarm120.text1.  
     
       DISP warm120.text1 WITH BROWSE br_paid.


        FIND FIRST bufwarm120_2 WHERE bufwarm120_2.text1 = "" NO-ERROR.                                                                 
        IF AVAIL bufwarm120_2 THEN DO:     /* ถ้า  ไม่ mark 1 รายการ  แสดงว่า เลือก mark ไม่หมด*/                                   
           tg_select = FALSE.                                                                                                        
           DISP tg_select WITH FRAME fMain.                                                                                           
        END.                                                                                                                        
        ELSE DO:                           /* ถ้าไม่เจอ ที่ เป็น no แสดงว่า mark all  */                                            
           tg_select = TRUE.                                                                                                         
           DISP tg_select WITH FRAME fMain.                                                                                           
        END.                                                                                                                       
   /*----Select----*/                                                                                                                               
       
   END.


    DISP  fi_clmtyp   fi_clmno     fi_policy
          fi_taxid    fi_comname1  fi_comaddr1 
          fi_comaddr2 fi_grd       fi_ram2      
          fi_amount1  fi_pv        fi_tol   WITH FRAME fMain.
    -----*/
  /* --------- Suthida T. A54-0293-------

   FIND CURRENT warm120 NO-LOCK NO-ERROR. 
    IF AVAIL arm120 THEN                  
        ASSIGN 
          fi_clmtyp     = warm120.trnty1
          fi_clmno      = warm120.docno
          fi_policy     = warm120.policy
          fi_taxid      = warm120.taxid 
          fi_comname1   = warm120.name  
          fi_comaddr1   = warm120.paddr1
          fi_comaddr2   = warm120.paddr2
          fi_grd        = warm120.prem
          fi_ram2       = STRING(warm120.docno)
          fi_amount1    = (warm120.prem * 100 ) / 107
          fi_pv         = warm120.PVRVJV
          fi_tol        = fi_tol   - warm120.prem
          nv_branch     = ""
          nv_acno       = "" /* --------- Suthida T. A54-0293------- */
          nv_branch     = warm120.branch
          nv_acno       = warm120.acno. /* --------- Suthida T. A54-0293------- */
          


    /* --------- Suthida T. A54-0293-------*/
     /*-ELSE DO:
       MESSAGE  "NOT AVAILABLE ARM120" VIEW-AS ALERT-BOX ERROR.
        ASSIGN                             
          fi_clmtyp     = ""   
          fi_clmno      = ""    
          fi_policy     = ""  
          fi_taxid      = ""    
          fi_comname1   = ""    
          fi_comaddr1   = ""    
          fi_comaddr2   = ""
          fi_grd        = 0
          fi_ram2       = "" 
          fi_amount1    = 0
          fi_pv         = ""
          fi_tol        = 0  
          fi_branch     = ""
          nv_branch     = "". 
          /*--------- Suthida T. A54-0293-------*/
        
    END.-*/

    DISP fi_clmtyp   fi_clmno     fi_policy
         fi_taxid    fi_comname1  fi_comaddr1 
         fi_comaddr2 fi_grd       fi_ram2       
         fi_amount1  fi_pv        fi_tol  WITH FRAME fMain.
         

    FOR EACH warm120 WHERE 
             warm120.policy =  fi_policy AND
             warm120.docno  =  fi_clmno  /*AND
             warm120.PVRVJV =  fi_pv */    NO-LOCK.
        
         DELETE warm120. 
    END.
    OPEN QUERY br_paid FOR EACH warm120.

     ASSIGN
      fi_net       = (fi_tol * 100) / 107
      fi_vat7      = (fi_net  * INTEGER(fi_ratv) ) / 100.
         

         IF   fi_tol < 1000 THEN fi_withhold = 0.
         ELSE fi_withhold = (fi_net * (INTEGER(fi_ratw) * 0.01)).
         fi_netamount = fi_tol - fi_withhold.

      DISP fi_tol       fi_net  fi_vat7  fi_netamount fi_ratw 
           fi_withhold  fi_ratv WITH FRAME fmain.
  --------- Suthida T. A54-0293------- */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frvat
&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel WAZRBV08
ON CHOOSE OF bu_cancel IN FRAME frvat /* CANCEL */
DO:
   APPLY "Close" TO THIS-PROCEDURE. 
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define SELF-NAME bu_desc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_desc WAZRBV08
ON CHOOSE OF bu_desc IN FRAME fMain /* . . . */
DO:
    /*-- Manop G .  A59-0611 --*/
DEFINE var    n_descnum       As  Char.
DEFINE var    n_descnam       As  Char.  

    /*-
    OPEN QUERY br_desctyp
    FOR EACH  wdesctype   WHERE
              wdesctype.descnumb  =  ""      AND
              wdesctype.descname  =  ""      NO-LOCK. 
        IF not AVAIL wdesctype  THEN DO:
            MESSAGE wdesctype.descnumb    VIEW-AS ALERT-BOX.
        END.
    -*/
    RUN whp\whpdesc(INPUT-OUTPUT n_descnum, 
                    INPUT-OUTPUT n_descnam ).

    fi_typedesc = n_descnum.
    fi_typedesc2 =  n_descnam.

    DISP fi_typedesc  fi_typedesc2  WITH FRAME fmain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit WAZRBV08
ON CHOOSE OF bu_exit IN FRAME fMain /* Exit */
DO:
  
    APPLY "Close" TO THIS-PROCEDURE. 
    RETURN NO-APPLY.


    


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frvat
&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok WAZRBV08
ON CHOOSE OF bu_ok IN FRAME frvat /* OK */
DO:
  
    ASSIGN
        n_year    = STRING(fi_year + 543)
        fi_book   = "Z" + SUBSTRING(n_year,3,2)   + STRING((fi_mon),"99") +
                          STRING(DAY(TODAY),"99") + STRING(TIME).    /* Running invoice NO. (book no.)*/

    DISP fi_book WITH FRAME fmain.
    HIDE FRAME frvat.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fMain
&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save WAZRBV08
ON CHOOSE OF bu_save IN FRAME fMain /* SAVE */
DO:
    IF fi_book = "" THEN DO:
         MESSAGE "เล่มที่/เลขที่ใบกำกับภาษีเป็นค่าว่าง" VIEW-AS ALERT-BOX ERROR TITLE "Error".  
         APPLY "Entry"  TO fi_book.  /* ----- Suthida T. A54-0293 -------- */
         RETURN NO-APPLY.            /* ----- Suthida T. A54-0293 -------- */
    END.

    
    FIND vat100 USE-INDEX vat10001    WHERE
            vat100.invtyp  = "B"      AND /** ประเภทขาย **/
            vat100.invoice = fi_book  NO-LOCK NO-ERROR.
    IF AVAIL vat100 THEN DO:
        MESSAGE "เล่มที่/เลขที่ใบกำกับภาษีซ้ำ..!" VIEW-AS ALERT-BOX ERROR TITLE "Error".
        APPLY "Entry"  TO fi_book.  /* ----- Suthida T. A54-0293 -------- */ 
        RETURN NO-APPLY.            /* ----- Suthida T. A54-0293 -------- */ 
    END.

    IF  fi_mon <= 0 OR fi_mon >= 13  THEN  DO:
          MESSAGE " In put month error. " VIEW-AS ALERT-BOX ERROR TITLE "Error".
          APPLY "Entry"  TO fi_mon.
          RETURN NO-APPLY.
    END.

    IF  fi_year <= 1942 OR fi_year >= 2500 THEN  DO:
         MESSAGE " In put year error. " VIEW-AS ALERT-BOX ERROR TITLE "Error".
         APPLY "Entry"  TO fi_year.
         RETURN NO-APPLY.
    END.
    
    FIND xmm023 USE-INDEX xmm02301 WHERE
         xmm023.branch = fi_branch   NO-LOCK NO-ERROR.
    IF AVAIL xmm023 THEN fi_branchs = xmm023.bdes.
    
    /** vat100 **/
    CREATE VAT100. 
    ASSIGN                 
      vat100.invtyp      =  "B" /** ประเภทภาษีซื้อ **/
      vat100.refno       =  fi_ref
      vat100.invoice     =  fi_book
      vat100.invdat      =  fi_inv
      vat100.entdat      =  fi_ent
      vat100.ratevat     =  fi_ratevat
      vat100.buytyp      =  fi_buytype
      vat100.amount      =  fi_amount1
      vat100.discamt     =  fi_amount2
      vat100.totamt      =  fi_tot
      vat100.vatamt      =  fi_vat
      vat100.grandamt    =  fi_grd
      vat100.pvrvjv      =  fi_pv  
      vat100.name        =  fi_comname1
      vat100.add1        =  fi_comaddr1
      vat100.add2        =  fi_comaddr2 
      vat100.desci       =  fi_typedesc2
      vat100.desci       =  fi_typedesc + " " + fi_typedesc2 /* ----- Suthida T. A54-0293 -------- */
      vat100.entdat      =  TODAY
      vat100.enttime     =  STRING(TIME,"HH:MM:SS")
      vat100.branch      =  nv_branch
      vat100.invbrn      =  fi_branch
      vat100.usrid       =  n_User
      vat100.remark1     =  fi_ram1
      vat100.remark2     =  fi_ram2
                                   
    /* vat100.program       = "azrvat07". */
    /*  vat100.program     =  fi_typedesc /* type description */ /* ----- Suthida T. A54-0293 -------- */ */
      vat100.program      =  "WAZEVB08" /* ----- Suthida T. A54-0293 -------- */
      vat100.crevat      =  fi_crevat
      vat100.crevat_p    =  fi_crev
      vat100.taxmont     =  fi_mon
      vat100.taxyear     =  fi_year
      vat100.taxrepm     =  fi_taxre
      VAt100.policy      =  fi_policy
      vat100.insref      =  nv_acno. /* ----- Suthida T. A54-0293 -------- */
      /*vat100.taxno       =  fi_taxid /* ----- Suthida T. A54-0293 -------- */- Suthida T. A56-0339 -*/
      fi_taxid           = TRIM(fi_taxid).  /* --- Suthida T. A56-0339 ---*/
      fi_brncus          = TRIM(fi_brncus). /* --- Suthida T. A56-0339 ---*/
      vat100.taxno       = fi_taxid + FILL(" ",19 - LENGTH(fi_taxid)) + fi_brncus.    /*---- Suthida T. A56-0339 ------*/
      nv_branch          =  "".
      
    MESSAGE "Update Complete" VIEW-AS ALERT-BOX.
    /** vat100 **/
    fi_totv100 = 0. 
    FOR EACH  vat100 USE-INDEX vat10008 WHERE 
              vat100.pvrvjv = INPUT fi_pv  AND   
              vat100.entdat = INPUT fi_ent NO-LOCK.

             fi_totv100 = fi_totv100 + vat100.grandamt.
    END.

    ASSIGN 
      /* ------- Suthida t. A55-0063 ไม่ต้องเคลียค่า---------------------
      fi_mon           = MONTH(TODAY)     fi_year        = YEAR(TODAY)
      fi_branch        ="0"               fi_branchs     = "M1"
      fi_ref           = ""               fi_pv          = ""
      fi_policy        = ""               fi_clmtyp      = ""
      fi_clmno         = ""               fi_book        = ""               
      fi_ratevat       = 7                fi_inv         = TODAY            
      fi_ent           = TODAY            fi_buytype     = ""              
      fi_taxre         = NO               fi_taxid       = ""  
      fi_comname1      = ""               fi_comaddr1    =""                
      fi_comaddr2      = ""  
      ------------------- Suthida t. A55-0063 ----------------------- */                            
                    
      fi_amount1       = 0                fi_amount2     =0                 
      /*-fi_tot           = 0                fi_vat         = 0              A59-0999  
      fi_grd           = 0    -*/            fi_ram1        = ""               
      fi_ram2          = ""                      
      fi_crevat        = "1"              fi_brncus      = "00000".   

    DISP fi_mon     fi_year     fi_branch       fi_branchs  fi_ref          fi_pv           fi_book     
         fi_ratevat fi_policy   fi_clmtyp       fi_clmno  
         fi_taxre   fi_taxid    fi_comname1     fi_comaddr1 fi_comaddr2     fi_typedesc     fi_typedesc2   
         fi_amount1 fi_amount2  fi_tot          fi_vat      fi_grd          fi_ram1         fi_ram2     fi_crevat       
         fi_totv100 fi_brncus   WITH FRAME fMain.            
              
       /* Save  */
END.  /* Loop_main  */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_savese
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_savese WAZRBV08
ON CHOOSE OF bu_savese IN FRAME fMain /* Save Select */
DO:

     IF fi_book = "" THEN DO:
          MESSAGE "เล่มที่/เลขที่ใบกำกับภาษีเป็นค่าว่าง" VIEW-AS ALERT-BOX ERROR TITLE "Error".  
          APPLY "Entry"  TO fi_book.  /* ----- Suthida T. A54-0293 -------- */
          RETURN NO-APPLY.            /* ----- Suthida T. A54-0293 -------- */
     END.

     FIND vat100 USE-INDEX vat10001    WHERE
             vat100.invtyp  = "B"      AND /** ประเภทขาย **/
             vat100.invoice = fi_book  NO-LOCK NO-ERROR.
     IF AVAIL vat100 THEN DO:
         MESSAGE "เล่มที่/เลขที่ใบกำกับภาษีซ้ำ..!" VIEW-AS ALERT-BOX ERROR TITLE "Error".
         APPLY "Entry"  TO fi_book.  /* ----- Suthida T. A54-0293 -------- */ 
         RETURN NO-APPLY.            /* ----- Suthida T. A54-0293 -------- */ 
     END.

     IF  fi_mon <= 0 OR fi_mon >= 13  THEN  DO:
           MESSAGE " In put month error. " VIEW-AS ALERT-BOX ERROR TITLE "Error".
           APPLY "Entry"  TO fi_mon.
           RETURN NO-APPLY.
     END.
     
     IF  fi_year <= 1942 OR fi_year >= 2500 THEN  DO:
          MESSAGE " In put year error. " VIEW-AS ALERT-BOX ERROR TITLE "Error".
          APPLY "Entry"  TO fi_year.
          RETURN NO-APPLY.
     END.
     
     FIND xmm023 USE-INDEX xmm02301 WHERE
          xmm023.branch = fi_branch   NO-LOCK NO-ERROR.
     IF AVAIL xmm023 THEN fi_branchs = xmm023.bdes.

     
     
     FOR EACH bwarm120 WHERE bwarm120.text1 = "**" NO-LOCK.
            ASSIGN  n_Amount1     =   (bwarm120.prem * 100) / 107
                    n_tot         =   n_amount1 - fi_amount2   
                    n_vat         =   n_tot * fi_ratevat / 100  
                    n_grd         =   n_tot + n_vat    . 
       
            /*-
            FIND vat100 WHERE  vat100.remark2 = STRING(warm120.docno) NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL vat100 THEN DO:  -*/

            /*-- Manop G .  A59-0611 --*/
            /*-  vat100   -*/
             CREATE VAT100.                  
             ASSIGN                    
                vat100.invtyp      =      "B"
                vat100.refno       =      fi_ref 
                vat100.invoice     =      fi_book
                vat100.invdat      =      fi_inv
                vat100.entdat      =      fi_ent
                vat100.ratevat     =      fi_ratevat
                vat100.buytyp      =      fi_buytype
                vat100.amount      =      n_Amount1           /* Amount1 */
                vat100.discamt     =      fi_amount2          /* Amount2 */
                vat100.totamt      =      n_tot               /* Total  */
                vat100.vatamt      =      n_vat               /* VatAmt   */
                vat100.grandamt    =      n_grd               /* GrandTotal */
                vat100.pvrvjv      =      IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" THEN "Jvโอนอู่" +  SUBSTR(n_user,6,2)  ELSE     /* PV = 00XXXX = JVโอนอู่*/
                                          IF (SUBSTR(INPUT fi_vc,1,2))  = "00" AND (SUBSTR(n_user,6,2)) <> "0" AND bwarm120.pvrvjv = "" THEN "Jvโอนอู่" + SUBSTR(n_user,6,2) ELSE warm120.pvrvjv   /*- A59-0533 -*/
                vat100.name        =      bwarm120.name    
                vat100.add1        =      bwarm120.paddr1  
                vat100.add2        =      bwarm120.paddr2  
                vat100.desci       =      fi_typedesc + " " + fi_typedesc2
                /*vat100.desci       =        */
                /*vat100.entdat      =      TODAY-*/
                vat100.enttime     =      STRING(TIME,"HH:MM:SS")
                vat100.branch      =      bwarm120.branch 
                vat100.invbrn      =      fi_branch 
                vat100.usrid       =      n_User
                vat100.remark1     =      fi_ram1                          /* Remark1 */
                vat100.remark2     =      STRING(bwarm120.docno)            /* Remark2 */
                /* vat100.program     */
                vat100.program     =      "WAZEVB08"
                vat100.crevat      =      fi_crevat  
                vat100.crevat_p    =      fi_crev    
                vat100.taxmont     =      fi_mon     
                vat100.taxyear     =      fi_year    
                vat100.taxrepm     =      fi_taxre
                VAt100.policy      =      bwarm120.policy      
                vat100.insref      =      bwarm120.acno
                /*vat100.taxno     */      
                fi_taxid           =      TRIM(fi_taxid)  
                fi_brncus          =      TRIM(fi_brncus)
                vat100.taxno       =      bwarm120.taxid + FILL(" ",19 - LENGTH(bwarm120.taxid)) + fi_brncus.   
                
                /*- Bookno+1 Z0000+1 -*/
                fi_book       = TRIM(SUBSTR(fi_book,INDEX(fi_book,"Z") + 1)).     
                fi_book       = STRING(DECI(fi_book) + 1 ).
                fi_book       = TRIM("Z" + STRING(fi_book)). 
             
                DELETE bwarm120.     
               
     END.       /* for each */
     
     MESSAGE "Save Complete"  VIEW-AS ALERT-BOX. 

     FOR EACH warm120 WHERE warm120.text1 = "**" NO-LOCK.
         DELETE warm120.
     END.

     /*-DELETE warm120.-*/
     OPEN QUERY br_paid FOR EACH warm120.
     /* A59-0611 */

     ASSIGN   n_Amount1    = 0      n_tot        = 0        n_vat        = 0 
              n_grd        = 0      nv_selcnt    = 0        fi_selcnt    = nv_selcnt
              fi_amount1       = 0                fi_amount2     =0                 
              fi_ram1        = ""                 fi_ram2          = ""                      
              fi_crevat        = "1"              fi_brncus      = "00000".                  



     DISP fi_typedesc  fi_typedesc2 
          fi_amount1    fi_amount2 
          fi_ram1       fi_ram2     fi_crevat       fi_brncus 
          br_paid  bu_savese fi_selcnt   WITH FRAME fMain.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_search WAZRBV08
ON CHOOSE OF bu_search IN FRAME fMain /* Search */
DO:
    FOR EACH warm120 NO-LOCK.
        DELETE warm120.
    END.

    FOR EACH bwarm120 NO-LOCK.
        DELETE bwarm120.
    END.
    
    IF INPUT cb_sort = "By req No." THEN DO:

    /* ----- Suthida T. A54-0293 -------- 
       FOR EACH  arm120 USE-INDEX arm12009 
           WHERE arm120.trnty1 = INPUT fi_trnty
           AND   arm120.docno  = INPUT fi_docno NO-LOCK
           ,EACH arm130 USE-INDEX arm13001
             WHERE arm130.rectyp = arm120.rectyp
             AND   arm130.prjno  = arm120.prjno NO-LOCK.
           CREATE warm120.
            ASSIGN
                warm120.policy  = arm120.policy 
                warm120.trnty1  = arm120.trnty1 
                warm120.docno   = arm120.docno  
                warm120.pdate   = arm120.trndat 
                warm120.insf    = arm120.ref    
                warm120.prem    = arm120.aramt  
                warm120.licen   = arm120.vehreg
                warm120.cdate   = arm130.cdate
                warm120.acno    = arm130.acno
                warm120.prem    = ABS(arm120.aramt)
                warm120.amount  = (arm120.aramt * 100 ) / 107
                warm120.TOTAL   = DECI(arm130.text1)
                warm120.pvrvjv  = arm120.rvno
                warm120.branch  = arm120.branch
                /* nv_ratevat      = INTEGER(arm130.text2)*/
                nv_tol          = nv_tol + ABS(arm120.aramt) /* warm120.TOTAL*/
                warm120.ratw    = arm130.text3
                warm120.ratV    = arm130.text2
                fi_ratw         = arm130.text3
                fi_ratv         = arm130.text2.
                ----- Suthida T. A54-0293 -------- */ 

        /* ----- Suthida T. A54-0293 -------- */
        nv_selcnt = 0.
        nv_tol = 0.
        FIND FIRST  arm120 USE-INDEX arm12009 WHERE 
                    arm120.trnty1 = INPUT fi_trnty AND   
                    arm120.docno  = INPUT fi_docno NO-ERROR.
        IF AVAIL arm120 THEN DO:

            FIND FIRST arm130 USE-INDEX arm13001 WHERE 
                       arm130.rectyp = arm120.rectyp AND   
                       arm130.prjno  = arm120.prjno  NO-LOCK.
            IF AVAIL arm130 THEN DO:
               CREATE warm120.
               ASSIGN
                  warm120.policy  = arm120.policy 
                  warm120.trnty1  = arm120.trnty1 
                  warm120.docno   = arm120.docno  
                  warm120.pdate   = arm120.trndat 
                  warm120.insf    = arm120.ref    
                  warm120.prem    = arm120.aramt  
                  warm120.licen   = arm120.vehreg
                  warm120.cdate   = arm130.cdate
                  warm120.acno    = arm130.acno
                  warm120.prem    = ABS(arm120.aramt)
                  warm120.amount  = (arm120.aramt * 100 ) / 107
                  warm120.TOTAL   = DECI(arm130.text1)
                  warm120.pvrvjv  = arm120.rvno
                  warm120.branch  = arm120.branch
                  /* nv_ratevat      = INTEGER(arm130.text2)*/
                  nv_tol          = nv_tol + ABS(arm120.aramt) /* warm120.TOTAL*/
                 /* ----- Suthida T. A54-0293 --------
                  warm120.ratw    = arm130.text3
                  warm120.ratV    = arm130.text2
                  ----- Suthida T. A54-0293 -------- */
                  fi_ratw         = arm130.text3
                  fi_ratv         = arm130.text2.
               
            END.
            /* ----- Suthida T. A54-0293 -------- */
            
            IF arm130.acno = "" THEN DO:
               ASSIGN             
                 warm120.taxid  = ""
                 warm120.name   = ""
                 warm120.paddr1 = ""
                 warm120.paddr2 = "".
            END.
            ELSE DO: 
                /* --------------- Suthida T. A55-0063 ----------------- 
                FIND FIRST tax001 USE-INDEX tax00101                      
                   WHERE  tax001.acno = arm130.acno NO-LOCK NO-ERROR.
                IF AVAIL tax001 THEN DO:                                     
                  ASSIGN 
                    warm120.taxid  = tax001.taxid
                    warm120.name   = tax001.name                               
                    warm120.paddr1 = TRIM(tax001.addr1)                        
                    warm120.paddr2 = TRIM(tax001.addr2). 
                END.
                ELSE DO:
                --------------- Suthida T. A55-0063 ----------------- */
                /* --------------- Suthida T. A55-0063 ----------------- */
                IF  arm130.acno  = "0EV" THEN
                    ASSIGN            
                      warm120.taxid     = ""
                      warm120.name      = ""
                      warm120.paddr1    = ""
                      warm120.paddr2    = "".
                ELSE DO:
                     ASSIGN  
                      fi_taxid    = ""
                      fi_comname1   = ""
                      fi_comaddr1   = ""
                      fi_comaddr2   = "".
                /* --------------- Suthida T. A55-0063 ----------------- */
                     /*- A59-0533 -*/
                        FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = arm130.acno  NO-LOCK NO-ERROR.
                        IF AVAIL xmm600 THEN DO:
                           ASSIGN   
                             /* warm120.taxid  = "" ----- Suthida T. A54-0293 -------- */
                             warm120.taxid  = xmm600.icno /* ----- Suthida T. A54-0293 -------- */         
                             warm120.name   = xmm600.name           
                             warm120.paddr1 = TRIM(xmm600.addr1) + " " + TRIM(xmm600.addr2)
                             warm120.paddr2 = TRIM(xmm600.addr3) + " " + TRIM(xmm600.addr4). 
                        END.
                        ELSE DO: 
                          FIND xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = arm130.acno NO-LOCK NO-ERROR.
                          IF AVAIL xtm600  THEN
                              ASSIGN                                   
                                warm120.taxid  = ""          
                                warm120.name   = xtm600.name           
                                warm120.paddr1 = TRIM(xtm600.addr1) + " " + TRIM(xtm600.addr2)
                                warm120.paddr2 = TRIM(xtm600.addr3) + " " + TRIM(xtm600.addr4).  
                          ELSE 
                              ASSIGN            
                                warm120.taxid  = ""
                                warm120.name   = ""
                                warm120.paddr1 = ""
                                warm120.paddr2 = "".
                        END. /* FIND xmm600  */
                END. /* arm130.acno  = "0EV" */ 
            END. /*IF arm130.acno = ""  */
        END. /* FIND FIRST  arm120 */
        /* ----- Suthida T. A54-0293 -------- */
        ELSE DO:

            MESSAGE "NOT AVAILABLE ARM120" VIEW-AS ALERT-BOX.
            APPLY "Entry"  TO cb_sort.  
            RETURN NO-APPLY.            

        END.
        /** ----- Suthida T. A54-0293 -------- */
    END.     /* INPUT cb_sort = "By req No." */
    ELSE DO:
        nv_selcnt = 0.
        nv_tol = 0.

        /*  ----- Suthida T. A54-0293 --------
        FOR EACH arm130 USE-INDEX arm13014
        WHERE arm130.cdate    =  INPUT fi_paid
        AND   arm130.ctyp     <> ""
        /* ----- Suthida T. A54-0293 --------
        AND   arm130.acno     >=  INPUT fi_pay
        AND   arm130.acno     <=  INPUT fi_pay-2
        AND   arm130.rectyp   <>  " "
        ----- Suthida T. A54-0293 -------- */
        AND   arm130.acno     =  INPUT fi_pay    /* ----- Suthida T. A54-0293 -------- */
        AND   arm130.rectyp   =  "VC"
        AND   arm130.prjno    =  INPUT fi_vc  NO-LOCK.
         ----- Suthida T. A54-0293 -------- */
      /*  , EACH  arm120  
             WHERE arm120.rectyp = arm130.rectyp
             AND   arm120.prjno  = arm130.prjno
             AND   SUBSTR(STRING(arm120.prjcnt,"99999999"),1,4) = STRING(arm130.itemno,"9999") NO-LOCK.  ----- Suthida T. A54-0293 -------- */ 
       /* ----- Suthida T. A54-0293 -------- */   

        FIND FIRST arm130 USE-INDEX arm13014 WHERE 
                   arm130.cdate    =  INPUT fi_paid AND   
                   arm130.ctyp     <> ""            AND   
                   arm130.acno     =  INPUT fi_pay  AND   
                   arm130.rectyp   =  "VC"          AND   
                   arm130.prjno    =  INPUT fi_vc   NO-ERROR.
        IF AVAIL arm130 THEN DO:
             FOR EACH arm120  USE-INDEX arm12001
                 WHERE arm120.rectyp = arm130.rectyp
                 AND   arm120.prjno  = arm130.prjno
                 AND   SUBSTR(STRING(arm120.prjcnt,"99999999"),1,4) BEGINS STRING(arm130.itemno,"9999") NO-LOCK. 
            /* ----- Suthida T. A54-0293 -------- */ 
                CREATE warm120.
                ASSIGN
                    warm120.policy  = arm120.policy 
                    warm120.trnty1  = arm120.trnty1 
                    warm120.docno   = arm120.docno  
                    warm120.pdate   = arm120.trndat 
                    warm120.insf    = arm120.ref    
                    warm120.prem    = arm120.aramt  
                    warm120.licen   = arm120.vehreg
                    warm120.cdate   = arm130.cdate
                    warm120.acno    = arm130.acno
                    warm120.prem    = ABS(arm120.aramt)
                    warm120.amount  = (arm120.aramt * 100 ) / 107
                    warm120.TOTAL   = DECI(arm130.text1)
                    warm120.pvrvjv  = arm120.rvno
                    warm120.branch  = arm120.branch
                    /* nv_ratevat      = INTEGER(arm130.text2)*/
                    nv_tol          = nv_tol + ABS(arm120.aramt) /* warm120.TOTAL*/
                    /* ----- Suthida T. A54-0293 --------
                    warm120.ratw    = arm130.text3
                    warm120.ratV    = arm130.text2
                    ----- Suthida T. A54-0293 -------- */
                    fi_ratw         = arm130.text3
                    fi_ratv         = arm130.text2.
            
                IF arm130.acno = "" THEN DO:
                   ASSIGN             
                     warm120.taxid  = ""
                     warm120.name   = ""
                     warm120.paddr1 = ""
                     warm120.paddr2 = "".
                END.
                ELSE DO:
                    /* --------------- Suthida T. A55-0063 ----------------- 
                    FIND FIRST tax001 USE-INDEX tax00101                      
                        WHERE  tax001.acno = arm130.acno NO-LOCK NO-ERROR.
                    IF AVAIL tax001 THEN DO:                                     
                       ASSIGN 
                         warm120.taxid  = tax001.taxid
                         warm120.name   = tax001.name                               
                         warm120.paddr1 = TRIM(tax001.addr1)                        
                         warm120.paddr2 = TRIM(tax001.addr2).
                    END.
                    --------------- Suthida T. A55-0063 ----------------- */
                    /* --------------- Suthida T. A55-0063 ----------------- */
                    IF  arm130.acno = "0EV" THEN
                        ASSIGN            
                          warm120.taxid     = ""
                          warm120.name      = ""
                          warm120.paddr1    = ""
                          warm120.paddr2    = "".
                    ELSE DO:
                       ASSIGN  
                          fi_taxid      = ""
                          fi_comname1   = ""
                          fi_comaddr1   = ""
                          fi_comaddr2   = "".
                    /* --------------- Suthida T. A55-0063 ----------------- */
                    /*- A59-0533 -*/
                       
          
                      FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = arm130.acno  NO-LOCK NO-ERROR.
                      IF AVAIL xmm600 THEN DO:
                         ASSIGN                                   
                           /* warm120.taxid  = ""       ----- Suthida T. A54-0293 -------- */   
                           warm120.taxid  = xmm600.taxno  /* ----- Suthida T. A54-0293 -------- */ 
                           warm120.name   = xmm600.name           
                           warm120.paddr1 = TRIM(xmm600.addr1) + " " + TRIM(xmm600.addr2)
                           warm120.paddr2 = TRIM(xmm600.addr3) + " " + TRIM(xmm600.addr4).
                      END.
                      ELSE DO: 
                        FIND xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = arm130.acno NO-LOCK NO-ERROR.
                        IF AVAIL xtm600  THEN
                           ASSIGN                                   
                             warm120.taxid  = ""          
                             warm120.name   = xtm600.name           
                             warm120.paddr1 = TRIM(xtm600.addr1) + " " + TRIM(xtm600.addr2)
                             warm120.paddr2 = TRIM(xtm600.addr3) + " " + TRIM(xtm600.addr4). 
                        ELSE 
                           ASSIGN            
                             warm120.taxid  = ""
                             warm120.name   = ""
                             warm120.paddr1 = ""
                             warm120.paddr2 = "".
                      END.
                  END. /* arm130.acno = "0EV" */
                END. /* IF arm130.acno = ""  */
            END. /* FOR EACH ARM120 */
        END. /* IF AVAIL arm130 THEN DO: */
        /* ----- Suthida T. A54-0293 -------- */
        ELSE DO:
            MESSAGE "NOT AVAILABLE ARM130" VIEW-AS ALERT-BOX.
            APPLY "Entry"  TO cb_sort.  
            RETURN NO-APPLY.            
        END. /* IF not AVAIL arm130 THEN DO:*/
        /* ----- Suthida T. A54-0293 -------- */
    END. /* <> INPUT cb_sort = "By req No." */

    OPEN QUERY br_paid FOR EACH warm120 NO-LOCK.
    tg_select = FALSE.
    RUN proc_report.

    IF  INPUT fi_pay = "0EV" THEN
        ASSIGN  
          fi_taxid      = ""
          fi_comname1   = ""
          fi_comaddr1   = ""
          fi_comaddr2   = "".

    ASSIGN
       fi_Cqclm     =  nv_tol
       fi_tol       =  nv_tol
       fi_net       = (fi_tol * 100) / 107
       fi_vat7      = (fi_net  * INTEGER(fi_ratv) ) / 100
       fi_selcnt    = nv_selcnt  .

       IF   fi_tol < 1000 THEN fi_withhold = 0.
       ELSE fi_withhold = (fi_net * (INTEGER(fi_ratw) * 0.01)).
       fi_netamount = fi_tol - fi_withhold.

    DISP fi_tol       fi_net  fi_vat7    fi_netamount fi_ratw  fi_selcnt
         fi_withhold  fi_ratv fi_Cqclm   fi_taxid     fi_comname1   
         fi_comaddr1  fi_comaddr2  tg_select  WITH FRAME fmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_sort
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_sort WAZRBV08
ON VALUE-CHANGED OF cb_sort IN FRAME fMain
DO:
  cb_sort = INPUT cb_sort.

  IF INPUT cb_sort = "By req No." THEN DO:

      DO WITH FRAME fMain:
        DISP fi_pd fi_trnty fi_docno WITH FRAME fmain. /* ------ suthida T. A54-0293 -------- */
        fi_trnty:MOVE-TO-TOP().
        fi_docno:MOVE-TO-TOP().
        /* ------ suthida T. A54-0293 --------
        ENABLE fi_trnty.
        ENABLE fi_docno.
        DISABLE fi_pay.
        DISABLE fi_pay-2. 
        DISABLE fi_date.
        DISABLE fi_vC2 .
        DISABLE fi_paid.
        DISABLE fi_vc.
        ------ suthida T. A54-0293 -------- */
        /* ------ suthida T. A54-0293 -------- */
        fi_trnty :HIDDEN = FALSE.
        fi_docno :HIDDEN = FALSE.
        fi_pay   :HIDDEN = TRUE.
        fi_date  :HIDDEN = TRUE.
        fi_vC2   :HIDDEN = TRUE.
        fi_paid  :HIDDEN = TRUE.
        fi_vc    :HIDDEN = TRUE.  

        /* ------ suthida T. A54-0293 -------- */
        fi_pd    = "REQ.NO.: " .
        /* fi_pd-2  = " " . ------ suthida T. A54-0293 -------- */
        fi_date  = "".
        fi_paid  = TODAY.
        fi_vc2   = "".
        fi_vc    = "".
        fi_pay   = "".

        DISP fi_pd fi_trnty fi_docno WITH FRAME fmain.
        APPLY "ENTRY" TO bu_search.

      END.

      /* ------ suthida T. A54-0293 --------
      DISP fi_pd     fi_pd      fi_pay  fi_pay-2 
           fi_trnty  fi_docno   fi_date fi_vC2 
           fi_paid   fi_vc WITH FRAME fMain. 
      ------ suthida T. A54-0293 -------- */

  END.
  IF  INPUT cb_sort = "By Pay To." THEN DO:

        DO WITH FRAME fMain:

            DISP fi_pd fi_pay fi_date fi_paid fi_vc2 fi_vc  WITH FRAME fMain.  /* ------ suthida T. A54-0293 -------- */
      
            /* ----- suthida T. A54-0293 --------
            fi_pay  :MOVE-TO-TOP().
            fi_pay-2:MOVE-TO-TOP().
            fi_pd   :MOVE-TO-TOP().
            fi_pd-2 :MOVE-TO-TOP().

            ENABLE fi_pay.
            ENABLE fi_pay-2.
            ENABLE fi_paid.
            ENABLE fi_vc.  
            DISABLE fi_trnty . 
            DISABLE fi_docno .
            ----- suthida T. A54-0293 -------- */
            /* ------ suthida T. A54-0293 -------- */
            fi_pay  :MOVE-TO-TOP().
            fi_date :MOVE-TO-TOP().
            fi_paid :MOVE-TO-TOP().
            fi_vc2  :MOVE-TO-TOP().
            fi_vc   :MOVE-TO-TOP().
            fi_trnty:HIDDEN = TRUE.
            fi_docno:HIDDEN = TRUE.
            fi_pay  :HIDDEN = FALSE.
            fi_date :HIDDEN = FALSE.
            fi_paid :HIDDEN = FALSE.
            fi_vc2  :HIDDEN = FALSE.
            fi_vc   :HIDDEN = FALSE.
            /* ------ suthida T. A54-0293 --------*/

            fi_pd    = "PAY TO : " .
            /* fi_pd-2  = "PAY TO : " . ------ suthida T. A54-0293 -------- */
            fi_date  = "PAID DATE:".
            fi_vC2   = " VC. NO.:".
            fi_trnty = "".
            fi_docno = "".
            fi_paid  = TODAY.

            DISP fi_pd fi_pay fi_date fi_vC2  fi_vc fi_paid WITH FRAM fmain. 
            APPLY "ENTRY" TO bu_search.

        END.

        /* ------ suthida T. A54-0293 --------
        DISP fi_pd     /*fi_pd-2*/    fi_pay  /*fi_pay-2 */
             fi_trnty  fi_docno   fi_date fi_vC2
             fi_paid   fi_vc WITH FRAME fMain. 
       ------ suthida T. A54-0293 -------- */      

  END.

  /* ------ suthida T. A54-0293 --------
  DISP fi_pd     /*fi_pd-2*/    fi_pay  /*fi_pay-2 */
       fi_trnty  fi_docno   fi_date fi_vC2 
       fi_paid   fi_vc WITH FRAME fMain. 
 ------ suthida T. A54-0293 -------- */      
      
      


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_amount1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_amount1 WAZRBV08
ON LEAVE OF fi_amount1 IN FRAME fMain
DO:
   fi_amount1 = INPUT fi_amount1 .
  DISP fi_amount1  WITH FRAME fMain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_amount2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_amount2 WAZRBV08
ON LEAVE OF fi_amount2 IN FRAME fMain
DO:

  fi_amount2  = INPUT fi_amount2 .

  ASSIGN
     fi_tot      = fi_amount1 - fi_amount2
     fi_vat      = fi_tot * fi_ratevat / 100
     fi_grd      = fi_tot + fi_vat.

  DISP fi_amount2   fi_tot  fi_vat  fi_grd     WITH FRAME fMain.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_book
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_book WAZRBV08
ON LEAVE OF fi_book IN FRAME fMain
DO:
  fi_book = INPUT fi_book.
  IF  n_choice = NO THEN DO:
  END.
  ELSE DO:

      IF fi_book = "" THEN MESSAGE "เล่มที่/เลขที่ใบกำกับภาษีเป็นค่าว่าง" VIEW-AS ALERT-BOX ERROR.        

       FIND vat100 USE-INDEX vat10001    WHERE
            vat100.invtyp  = "B"          AND /** ประเภทซื้อ **/
            vat100.invoice = INPUT fi_book     NO-LOCK NO-ERROR.
       IF AVAIL vat100 THEN 
           MESSAGE "เลขที่ใบกำกับภาษีซ้ำ..!" VIEW-AS ALERT-BOX ERROR.
  END.

  DISP fi_book WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch WAZRBV08
ON LEAVE OF fi_branch IN FRAME fMain
DO:
    fi_branch= CAPS(INPUT fi_branch).

    FIND xmm023 USE-INDEX xmm02301 WHERE
         xmm023.branch = fi_branch NO-LOCK NO-ERROR.
    IF AVAIL xmm023 THEN DO:
       fi_branchs = xmm023.bdes.
    END.
    ELSE DO: 
        MESSAGE "Not Available in table xmm023" VIEW-AS ALERT-BOX.

    END.
    
    DISP fi_branch fi_branchs WITH FRAME fMain.  
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brncus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brncus WAZRBV08
ON LEAVE OF fi_brncus IN FRAME fMain
DO:
  fi_brncus = INPUT fi_brncus.
  DISP fi_brncus WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_buytype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_buytype WAZRBV08
ON LEAVE OF fi_buytype IN FRAME fMain
DO:
    fi_buytype   = CAPS(INPUT FRAME fMain fi_buytype).

    DISP fi_buytype WITH FRAME fMain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_clmno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_clmno WAZRBV08
ON LEAVE OF fi_clmno IN FRAME fMain
DO:
   fi_clmno = INPUT fi_clmno.

  FIND FIRST  acm001 USE-INDEX acm00101 
       WHERE  acm001.trnty1 = INPUT fi_clmtyp 
       AND    acm001.docno  = INPUT fi_clmno NO-ERROR.
  IF AVAIL acm001 THEN fi_policy = acm001.policy.
  ELSE fi_policy = "".

   DISP fi_clmno fi_policy WITH FRAME fMain.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_clmtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_clmtyp WAZRBV08
ON LEAVE OF fi_clmtyp IN FRAME fMain
DO:
  fi_clmtyp = INPUT fi_clmtyp.
   DISP fi_clmtyp WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comaddr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comaddr1 WAZRBV08
ON LEAVE OF fi_comaddr1 IN FRAME fMain
DO:
    fi_comaddr1 = INPUT fi_comaddr1.
   
 DISP fi_comaddr1 WITH FRAME fMain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comaddr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comaddr2 WAZRBV08
ON LEAVE OF fi_comaddr2 IN FRAME fMain
DO:
    fi_comaddr2 = INPUT fi_comaddr2.
    DISP fi_comaddr2 WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comname1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comname1 WAZRBV08
ON LEAVE OF fi_comname1 IN FRAME fMain
DO:
    fi_comname1= INPUT fi_comname1.
DISP fi_comname1 WITH FRAME fMain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_crev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_crev WAZRBV08
ON LEAVE OF fi_crev IN FRAME fMain
DO:
      fi_crev = INPUT fi_crev .

  DISP fi_crev  WITH FRAME fMain.
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_crevat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_crevat WAZRBV08
ON LEAVE OF fi_crevat IN FRAME fMain
DO:
    fi_crevat = INPUT fi_crevat .
    /* IF fi_crevat = "1" THEN DO:
        fi_crev = 100.
        DISP fi_crevat fi_crev  WITH FRAME fMain.
     END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_docno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_docno WAZRBV08
ON LEAVE OF fi_docno IN FRAME fMain
DO:
  fi_docno = INPUT fi_docno.
  DISP fi_docno WITH FRAME fmain.
  APPLY "ENTRY" TO bu_search.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inv WAZRBV08
ON LEAVE OF fi_inv IN FRAME fMain
DO:
         fi_inv = INPUT fi_inv.
         DISP fi_inv WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_mon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_mon WAZRBV08
ON LEAVE OF fi_mon IN FRAME fMain
DO:
   fi_mon = INPUT fi_mon.
   IF  fi_mon <= 0 OR fi_mon >= 13  THEN  DO:
       MESSAGE " In put month error. " VIEW-AS ALERT-BOX ERROR TITLE "Error".
       APPLY "Entry"  TO fi_mon.
       RETURN NO-APPLY.
   END.
   DISP fi_mon WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_paid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_paid WAZRBV08
ON LEAVE OF fi_paid IN FRAME fMain
DO:
   fi_paid = INPUT fi_paid.
   DISP fi_paid WITH FRAME fMain.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pay WAZRBV08
ON LEAVE OF fi_pay IN FRAME fMain
DO:
    fi_pay     = CAPS(INPUT fi_pay).
        /* fi_pay-2   = fi_pay.------ suthida T. A54-0293 -------- */
    DISP fi_pay /* fi_pay-2*/  WITH FRAME fMain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy WAZRBV08
ON LEAVE OF fi_policy IN FRAME fMain
DO:
   FIND FIRST vat100 USE-INDEX vat10008   WHERE
              vat100.pvrvjv  =  fi_pv      AND
              vat100.refno   =  fi_ref     AND
              vat100.policy  =  fi_policy  AND /*-- Piyachat A56-0097 --*/
              vat100.invbrn  =  fi_branch  AND
              vat100.taxmont =  fi_mon     AND
              vat100.taxyear =  fi_year    NO-LOCK NO-ERROR.

   IF AVAIL vat100 THEN  DO:

       VIEW FRAME frvat.
       OPEN QUERY br_vat100 
        FOR EACH vat100 USE-INDEX vat10008   WHERE
                  vat100.pvrvjv  = fi_pv      AND
                  vat100.refno   = fi_ref     AND
                  vat100.policy  = fi_policy  AND   /*-- Piyachat A56-0097 --*/                  
                  vat100.invbrn  = fi_branch  AND
                  vat100.taxmont = fi_mon     AND
                  vat100.taxyear = fi_year    NO-LOCK.
   END.
   ELSE DO: 

      ASSIGN
          fi_policy = INPUT fi_policy
          n_year    = STRING(fi_year + 543)
          fi_book   = "Z" + SUBSTRING(n_year,3,2)   + STRING((fi_mon),"99") +
                            STRING(DAY(TODAY),"99") + STRING(TIME).    /* Running invoice NO. (book no.)*/
   END.
   DISP fi_policy fi_book WITH FRAME fMain.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy WAZRBV08
ON RETURN OF fi_policy IN FRAME fMain
DO:
  /*FIND FIRST vat100 USE-INDEX vat10008   WHERE
              vat100.pvrvjv  = fi_pv      AND
              vat100.refno   = fi_ref     AND
              vat100.invbrn  = fi_branch  AND
              vat100.taxmont = fi_mon     AND
              vat100.taxyear = fi_year    NO-LOCK NO-ERROR.

   IF AVAIL vat100 THEN  DO:
       VIEW FRAME frvat.
       OPEN QUERY br_vat100 
        FOR EACH vat100 USE-INDEX vat10008   WHERE
                  vat100.pvrvjv  = fi_pv      AND
                  vat100.refno   = fi_ref     AND
                  vat100.invbrn  = fi_branch  AND
                  vat100.taxmont = fi_mon     AND
                  vat100.taxyear = fi_year    NO-LOCK.

   END.
   ELSE DO: 

      ASSIGN
          fi_policy = INPUT fi_policy
          n_year    = STRING(fi_year + 543)
          fi_book   = "Z" + SUBSTRING(n_year,3,2)   + STRING((fi_mon),"99") +
                            STRING(DAY(TODAY),"99") + STRING(TIME).    /* Running invoice NO. (book no.)*/


   END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pv WAZRBV08
ON LEAVE OF fi_pv IN FRAME fMain
DO:
    ASSIGN
        
        fi_pv = INPUT fi_pv
        fi_pv = CAPS(INPUT FRAME fMain fi_pv).
             
    DISP fi_pv  WITH FRAME fMain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ram1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ram1 WAZRBV08
ON LEAVE OF fi_ram1 IN FRAME fMain
DO:
    fi_ram1= INPUT fi_ram1 .
  DISP fi_ram1  WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ram2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ram2 WAZRBV08
ON LEAVE OF fi_ram2 IN FRAME fMain
DO:
    fi_ram2 = INPUT fi_ram2.
  DISP fi_ram2  WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ratevat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ratevat WAZRBV08
ON LEAVE OF fi_ratevat IN FRAME fMain
DO:
    fi_ratevat = INPUT fi_ratevat.
  IF fi_ratevat = 10  THEN DO: 
  END.

  DISP fi_ratevat  WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ref
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ref WAZRBV08
ON LEAVE OF fi_ref IN FRAME fMain
DO:
   fi_ref = INPUT fi_ref.
   fi_ref   = CAPS(INPUT FRAME fMain fi_ref).
   DISP fi_ref WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_taxid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_taxid WAZRBV08
ON LEAVE OF fi_taxid IN FRAME fMain
DO:
    fi_taxid= INPUT fi_taxid.
    IF INPUT fi_taxid <> "" THEN DO:
       /* ---- suthida T. A55-0064 ----*/
       IF  INPUT fi_pay = "0EV" THEN DO: 
           

            FIND FIRST tax001 USE-INDEX tax00101  /* ค้นหาเลขที่ผู้เสียภาษี*/
                 WHERE tax001.taxid = INPUT fi_taxid NO-LOCK NO-ERROR.
            IF AVAIL tax001 THEN 
               ASSIGN
                    fi_comname1      = tax001.name
                    fi_comaddr1      = TRIM(tax001.addr1)
                    fi_comaddr2      = TRIM(tax001.addr2).
            ELSE 
               ASSIGN
                 fi_comname1      = ""
                 fi_comaddr1      = ""
                 fi_comaddr2      = "".
       END.
       ELSE DO:
            /* ------------ Suthida t. A54-0293 ---------- 
            MESSAGE "Not Available Tax ID in TAX001" VIEW-AS ALERT-BOX ERROR. 
            APPLY "Entry" TO fi_taxid.
            RETURN NO-APPLY.
            ------------ Suthida t. A54-0293 ----------*/
           /*- A59-0533 -*/
            FIND FIRST tax001 USE-INDEX tax00101                      
               WHERE  tax001.taxid = INPUT fi_taxid NO-LOCK NO-ERROR.
            IF AVAIL tax001 THEN DO:                                     
              ASSIGN 
                fi_comname1 = tax001.name                               
                fi_comaddr1 = TRIM(tax001.addr1)                        
                fi_comaddr2 = TRIM(tax001.addr2). 
            END.         /*- A59-0533 -*/
            ELSE DO:

                FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = INPUT fi_pay  NO-LOCK NO-ERROR.
                IF AVAIL xmm600 THEN DO:
                   ASSIGN   
                     fi_comname1    = xmm600.name           
                     fi_comaddr1    = TRIM(xmm600.addr1) + " " + TRIM(xmm600.addr2)
                     fi_comaddr2    = TRIM(xmm600.addr3) + " " + TRIM(xmm600.addr4).  /* xmm600.dval20 เก็บ TAXID*/
                END.
                ELSE DO: 

                  FIND xtm600 USE-INDEX xtm60001 WHERE xtm600.acno = INPUT fi_pay NO-LOCK NO-ERROR.
                  IF AVAIL xtm600  THEN
                      ASSIGN                                   
                        fi_comname1 = xtm600.name           
                        fi_comaddr1 = TRIM(xtm600.addr1) + " " + TRIM(xtm600.addr2)
                        fi_comaddr2 = TRIM(xtm600.addr3) + " " + TRIM(xtm600.addr4).  
                  ELSE DO:               
                      ASSIGN            
                        fi_comname1 = ""  
                        fi_comaddr1 = ""  
                        fi_comaddr2 = "". 
                  END.

                END. /* FIND xmm600  */
            END. /* Find Tax001 */

       END. 
    END.
    /* ------------ suthida T. A55-0064 --------- */
    ELSE DO:
        IF  INPUT fi_pay = "0EV" THEN DO:
            FIND FIRST tax001 USE-INDEX tax00101  /* ค้นหาเลขที่ผู้เสียภาษี*/
                 WHERE tax001.taxid = INPUT fi_taxid NO-LOCK NO-ERROR.
            IF AVAIL tax001 THEN 
               ASSIGN
                    fi_comname1      = tax001.name
                    fi_comaddr1      = TRIM(tax001.addr1)
                    fi_comaddr2      = TRIM(tax001.addr2).
            ELSE 
               ASSIGN
                 fi_comname1      = ""
                 fi_comaddr1      = ""
                 fi_comaddr2      = "".
        END.
        ELSE 
            ASSIGN
              fi_comname1      = INPUT fi_comname1 
              fi_comaddr1      = INPUT fi_comaddr1 
              fi_comaddr2      = INPUT fi_comaddr2 .
    END.
    /* ------------ suthida T. A55-0064 --------- */ 
        
    DISP fi_taxid fi_comname1 fi_comaddr1 fi_comaddr2   WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_taxre
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_taxre WAZRBV08
ON LEAVE OF fi_taxre IN FRAME fMain
DO:
    fi_taxre= INPUT fi_taxre.
DISP fi_taxre WITH FRAME fMain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trnty
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trnty WAZRBV08
ON LEAVE OF fi_trnty IN FRAME fMain
DO:
  fi_trnty = CAPS(INPUT fi_trnty).
  DISP fi_trnty WITH FRAME fMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typedesc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typedesc WAZRBV08
ON LEAVE OF fi_typedesc IN FRAME fMain
DO:
  /*  Description= 1  ออกงานที่เป็น Tranction Type = X ข้อมูลการจ่าย Claim*/

  fi_typedesc = INPUT fi_typedesc.
     
  IF INPUT  fi_typedesc = " "  THEN DO:  /* not complete Type Description: 1  */

      MESSAGE "Type Description: 1-14 " VIEW-AS ALERT-BOX ERROR.

      ASSIGN 
          fi_typedesc  = ""
          fi_typedesc2 = "".

      DISP fi_typedesc fi_typedesc2 WITH FRAME fMain.
      APPLY "Entry" TO fi_typedesc.
      RETURN NO-APPLY.
  END. 
  ELSE DO: /* complete Type Description: 1  */
      /*-IF INPUT  fi_typedesc = "1" THEN 
         ASSIGN
           fi_typedesc2     = "ค่าซ่อม+ค่าแรง"
           fi_crevat        = "1".-*/
      /*--- Manop G .  A59-0611 --*/
        IF INPUT  fi_typedesc = "1" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าซ่อม+ค่าแรง"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "2" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่านายหน้า"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "3" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าจัดเก็บเบี้ยฯ"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "4" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าเบี้ยประกันต่อ"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "5" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าจัดส่งกรมธรรม์"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "6" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าใช้จ่ายอื่นๆ"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "7" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าสำรวจภัย"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "8" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าซาก"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "9" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าธรรมเนียม"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "10" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าบริการ"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "11" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าที่ปรึกษา"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "12" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าส่งเสริมการขาย"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "13" THEN DO:
             ASSIGN
             fi_typedesc2     = "ค่าบริการข้อมูล"
             fi_crevat        = "1".
        END.
        ELSE IF INPUT  fi_typedesc = "14" THEN DO:
              ASSIGN
             fi_typedesc2     = "ค่าที่ปรึกษาการตลาด"
             fi_crevat        = "1".
        END.

      DISP fi_typedesc fi_typedesc2 fi_crevat WITH FRAME fMain.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_typedesc2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_typedesc2 WAZRBV08
ON LEAVE OF fi_typedesc2 IN FRAME fMain
DO:
      fi_typedesc2 = INPUT fi_typedesc2.
 DISP fi_typedesc2 WITH FRAME fMain. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vc WAZRBV08
ON LEAVE OF fi_vc IN FRAME fMain
DO:
  fi_vc = INPUT fi_vc.
  DISP fi_vc WITH FRAME fMain.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year WAZRBV08
ON LEAVE OF fi_year IN FRAME fMain
DO:
   fi_year = INPUT fi_year.
        IF  fi_year <= 1942 OR fi_year >= 2500 THEN  DO:
       MESSAGE " In put year error. " VIEW-AS ALERT-BOX ERROR TITLE "Error".
       APPLY "Entry"  TO fi_year.
       RETURN NO-APPLY.
  END.

   DISP  fi_year WITH FRAME fmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_select WAZRBV08
ON VALUE-CHANGED OF tg_select IN FRAME fMain
DO:
  tg_select = INPUT tg_select .
  

    DO WITH FRAME fMain:
         IF tg_select = YES THEN DO:
             FOR EACH warm120 WHERE warm120.TEXT1 = "":
                        nv_selcnt = nv_selcnt + 1.
                 ASSIGN warm120.text1 = "**"
                        fi_grd = fi_grd + warm120.prem.
                        /*-warm120.text1:BGCOLOR IN BROWSE br_paid= 6.-*/
                        /*nv_selcnt = nv_selcnt + 1.-*/
                 /*-DELETE warm120.-*/
                 /* Select เก็บลง bwarm120 */
                 CREATE bwarm120 .
                 ASSIGN bwarm120.policy     = warm120.policy  
                        bwarm120.trnty1     = warm120.trnty1  
                        bwarm120.docno      = warm120.docno   
                        bwarm120.pdate      = warm120.pdate   
                        bwarm120.insf       = warm120.insf    
                        bwarm120.prem       = warm120.prem    
                        bwarm120.licen      = warm120.licen   
                        bwarm120.cdate      = warm120.cdate   
                        bwarm120.acno       = warm120.acno    
                        bwarm120.taxid      = warm120.taxid   
                        bwarm120.name       = warm120.name    
                        bwarm120.paddr1     = warm120.paddr1  
                        bwarm120.paddr2     = warm120.paddr2  
                        bwarm120.amount     = warm120.amount  
                        bwarm120.TOTAL      = warm120.TOTAL   
                        bwarm120.PVRVJV     = warm120.PVRVJV  
                        bwarm120.ratw       = warm120.ratw    
                        bwarm120.ratV       = warm120.ratV    
                        bwarm120.branch     = warm120.branch  
                        bwarm120.Text1      = warm120.Text1   .
                        fi_pv               = warm120.PVRVJV  .
                 /*       RELEASE bwarm120.*/
             END.
             RUN pd_OpenQ.
              
         END.
         ELSE DO:
             FOR EACH warm120 WHERE warm120.text1 = "**" :
                 ASSIGN warm120.text1 = "" 
                        fi_grd = 0 
                        nv_selcnt = 0 .
                        /*-nv_selcnt = 0.-*/
                 FIND FIRST bwarm120 WHERE bwarm120.Text1 = warm120.Text1  NO-ERROR NO-WAIT.
                 IF AVAIL bwarm120 THEN DELETE bwarm120. 
             END.   
         END.
         /*-DISP nv_selcnt @ fiSelcnt  WITH FRAME frST.-*/
    END.
    RUN pd_OpenQ.
    fi_selcnt  =  nv_selcnt .


    DISP  fi_clmtyp   fi_clmno     fi_policy
          fi_taxid    fi_comname1  fi_comaddr1 
          fi_comaddr2 fi_grd       fi_ram2      
          fi_amount1  fi_pv        fi_tol  fi_selcnt WITH FRAME fMain.


    DISP tg_select WITH FRAME fmain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WAZRBV08 


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
       
        gv_prgid = "WAZEVB09".
        gv_prog  = "UPDATE INPUT VAT(B)".

        RUN  WUT\WUTHEAD (WAZRBV08:HANDLE,gv_prgid,gv_prog).
        RUN Wut\WutwiCen (WAZRBV08:HANDLE).
        SESSION:DATA-ENTRY-RETURN = YES.
        
     /*********************************************************************/ 
      HIDE FRAME frvat.


      
       ASSIGN 
                                
            fi_inv         =    TODAY
            fi_ent         =    TODAY
            fi_mon         =    MONTH(TODAY)
            fi_year        =    YEAR(TODAY)
            fi_paid        =    TODAY
            fi_buytype     =    "Y"
            fi_typedesc    =    "1"
            fi_typedesc2   =    "ค่าซ่อม+ค่าแรง"
            fi_crev        =    100.0
            fi_clmtyp      =    "X"
            fi_pay         =    ""
            fi_vc          =    ""
            fi_ratevat     =    7
            fi_branch      =    SUBSTR(n_user,6,2)
            fi_taxre       =    YES
            fi_pv          =    ""      /*- A59-0369 -*/
            fi_brncus      =    "00000" /*--- suthida T. A56-0339 */
            fi_amount2     =    0.00  .   /* Manop G. A59-0611 */
            /* -------- suthida T. A54-0293 ----------
            ENABLE fi_trnty.    
            ENABLE fi_docno.  
            fi_pd   = "".   
            -------- suthida T. A54-0293 ---------- */ 
            /* fi_pd-2 = "".  -------- suthida T. A54-0293 ---------- */

/*
      OPEN QUERY br_vat100 
           FOR EACH vat100 WHERE 
                    vat100.refno   = INPUT fi_ref AND
                    vat100.pvrvjv  = INPUT fi_pv  .

*/             

      FIND xmm023 USE-INDEX xmm02301 WHERE /* ---- check branch ----- */
           xmm023.branch = fi_branch   NO-LOCK NO-ERROR.
      IF AVAIL xmm023 THEN DO:
         fi_branchs = xmm023.bdes.
      END.

      /*  -------- suthida T. A54-0293 ----------  */
      DO WITH FRAME fmain:
          ASSIGN 
              cb_sort:LIST-ITEMS = nv_sort
              cb_sort            = ENTRY(1,nv_sort).
              fi_pd  :MOVE-TO-TOP().
              fi_pay :MOVE-TO-TOP().
              fi_date:MOVE-TO-TOP().
              fi_paid:MOVE-TO-TOP().
              fi_vc2 :MOVE-TO-TOP().
              fi_vc  :MOVE-TO-TOP().
              fi_trnty:HIDDEN = TRUE.
              fi_docno:HIDDEN = TRUE.
              fi_pd   = "PAY TO : ".
              fi_date = "PAID DATE : ".
              fi_vc2  = "VC. NO.: ".
          DISP cb_sort  fi_pd fi_date fi_vc2 fi_paid.
          APPLY "ENTRY" TO fi_pay.

      /*  -------- suthida T. A54-0293 ---------- */

          DISP fi_ent      fi_inv    fi_typedesc   fi_branchs  fi_branch
               fi_mon      fi_year   fi_buytype    fi_crev  
               fi_paid     fi_clmtyp fi_pay        fi_vc 
               fi_ratevat  fi_pay    fi_taxre      fi_pd   fi_pv
               fi_amount2  fi_typedesc2
               /*fi_pd-2   fi_trnty  fi_docno */   fi_brncus WITH FRAME fMain.

      END.
                        
         IF NOT THIS-PROCEDURE:PERSISTENT THEN
             WAIT-FOR CLOSE OF THIS-PROCEDURE.
    
    END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WAZRBV08  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WAZRBV08)
  THEN DELETE WIDGET WAZRBV08.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WAZRBV08  _DEFAULT-ENABLE
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
  DISPLAY tg_select fi_date fi_vc2 cb_sort fi_pd fi_trnty fi_docno fi_Cqclm 
          fi_ratw fi_pay fi_paid fi_net fi_vc fi_tol fi_vat7 fi_withhold 
          fi_netamount fi_mon fi_year fi_branch fi_ref fi_branchs fi_pv 
          fi_clmtyp fi_clmno fi_policy fi_book fi_ratevat fi_ent fi_inv 
          fi_buytype fi_taxre fi_taxid fi_brncus fi_comname1 fi_comaddr1 
          fi_comaddr2 fi_typedesc fi_typedesc2 fi_amount1 fi_amount2 fi_tot 
          fi_vat fi_grd fi_ram1 fi_ram2 fi_crevat fi_crev fi_ratv fi_totv100 
          fi_selcnt 
      WITH FRAME fMain IN WINDOW WAZRBV08.
  ENABLE bu_savese tg_select bu_desc cb_sort fi_trnty fi_docno br_paid fi_pay 
         fi_paid fi_vc bu_search fi_mon fi_year fi_ref fi_pv fi_clmtyp fi_clmno 
         fi_policy fi_book fi_ratevat fi_inv fi_buytype fi_taxre fi_taxid 
         fi_brncus fi_comname1 fi_comaddr1 fi_comaddr2 fi_typedesc fi_typedesc2 
         fi_amount1 fi_amount2 fi_ram1 fi_ram2 fi_crevat fi_crev bu_save 
         bu_exit RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 RECT-16 RECT-17 
         RECT-18 RECT-19 
      WITH FRAME fMain IN WINDOW WAZRBV08.
  {&OPEN-BROWSERS-IN-QUERY-fMain}
  ENABLE RECT-10 RECT-15 br_vat100 bu_ok bu_cancel 
      WITH FRAME frvat IN WINDOW WAZRBV08.
  {&OPEN-BROWSERS-IN-QUERY-frvat}
  VIEW WAZRBV08.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_OpenQ WAZRBV08 
PROCEDURE PD_OpenQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OPEN QUERY br_paid FOR EACH warm120.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report WAZRBV08 
PROCEDURE proc_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

 OUTPUT STREAM ns1 TO VALUE("PAYMENT VOUCHER.txt").
 PUT STREAM ns1 
    "PAY TO"     "|"       
    "REQ. NO."   "|"       
    "POLICY NO." "|"      
    "INSURED"    "|"          
    "AMOUNT"     "|" 
    "PV. NO. "   "|"         SKIP . 

FOR EACH warm120 .
   PUT STREAM ns1 
       warm120.acno                    "|"                   
       warm120.docno                   "|"                   
       warm120.policy                  "|"                   
       warm120.name                    "|"                   
       warm120.prem                    "|"                   
       warm120.PVRVJV                  "|"         SKIP .    

END.
OUTPUT STREAM ns1 CLOSE.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

