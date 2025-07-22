&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME WACR0091
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WACR0091 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 
  Created: Nattanicha N.  A59-0109 Date 23/03/2016
  
เรียกรายงาน RBC Report
1. statement เบี้ย inward ค้างรับจากบริษัทเอาประกันภัยต่อ (Ceding company)
2. statement เบี้ย outward ค้างจ่ายบริษัทรับประกันภัยต่อ (Reinsurer company)
3. statement claim paid outward ค้างรับจากบริษัทรับประกันภัยต่อ (Reinsurer company)

Modify BY : Saowapa U. A62-0448 24/10/2019 
            เพิ่มคอลัมน์ ์New License,Reinsurer A/C Type
            ทำรายงานสรุปเพิ่ม
            
Modify BY : Nontamas H. [A63-0415] Date 14/09/2020
            - เพิ่ม Column "Their Policy No." ในรายงาน Statement Premium Outward 
              โดยเรียกข้อมูลจาก UWM200.THPOL
              
Modify By : Nattanicha K. [A64-0093]  Date 20/03/2021
            - Clear Value  nv_si (SI not Correct)     
           
Modify By : Nattanicha K. [A64-0410]  Date 16112021
            - Add No-Error for Find Loop 
            - Add TRIM(riroprm.ttyfac)  
            
Modify By : Nattanicha K. [F67-0002] Date 08/11/2024, 05/02/2025
            - XOL >> riroprm.cedper2
            - Change Index on FOR EACH Loop for PA Foreign  

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

DEF     SHARED VAR n_User           AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.  

/* Parameters Definitions ---                                           */
DEF VAR n_agent1      AS CHAR FORMAT "x(10)".
DEF VAR n_agent2      AS CHAR FORMAT "x(10)".

DEF VAR n_branch      AS CHAR FORMAT "x(2)".
DEF VAR n_branch2     AS CHAR FORMAT "x(2)".
                                                                                 
DEF VAR n_name        AS CHAR FORMAT "x(50)".    /*acno name*/                  
DEF VAR n_chkname     AS CHAR FORMAT "x(1)".     
DEF VAR n_bdes        AS CHAR FORMAT "x(50)".    /*branch name*/                
DEF VAR n_chkBname    AS CHAR FORMAT "x(1)".     

DEF VAR nv_asmth      AS INTE INIT 0.
DEF VAR nv_frmth      AS INTE INIT 0.
DEF VAR nv_tomth      AS INTE INIT 0.
DEF VAR cv_mthListT   AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE   AS CHAR INIT " January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_frdate      AS DATE FORMAT "99/99/9999".
DEF VAR n_todate      AS DATE FORMAT "99/99/9999".
DEF VAR n_asdat       AS DATE FORMAT "99/99/9999".
DEF VAR n_OutputFile  AS CHAR.     

/* --------------------- Define Var use in process ---------------------------*/
DEF VAR n_frbr        AS CHAR FORMAT "x(2)".
DEF VAR n_tobr        AS CHAR FORMAT "x(2)".
DEF VAR n_frac        AS CHAR FORMAT "x(10)".
DEF VAR n_toac        AS CHAR FORMAT "x(10)".

DEF VAR n_insur       AS CHAR FORMAT "x(80)". 
DEF VAR nv_payee      AS CHAR FORMAT "x(80)". .
DEF VAR n_xmm600      LIKE xtm600.name.   
DEF VAR n_prem        LIKE acm001.netamt.
DEF VAR n_gross       LIKE acm001.netamt.
DEF VAR n_comp        AS DECI FORMAT "->>,>>>,>>9.99".
DEF VAR n_bal         LIKE acm001.netamt.
DEF VAR n_settle      LIKE acm001.netamt.
DEF VAR n_comdat      AS DATE FORMAT "99/99/9999".  
DEF VAR n_losdat      AS DATE FORMAT "99/99/9999". 
DEF VAR n_entrydat    AS DATE FORMAT "99/99/9999".  /*A56-0267*/
DEF VAR n_paddat      AS DATE FORMAT "99/99/9999".  /*A56-0267*/

DEF VAR n_type        AS CHAR FORMAT "X(10)" INIT "".  
DEF VAR n_typereport  AS CHAR FORMAT "X(1)"  INIT "".  
DEF VAR nv_filter1    AS CHAR INIT "".                 
DEF VAR nv_disp       AS CHAR.
DEF VAR nv_Progid     AS CHAR.
DEF VAR nv_Userid     AS CHAR.
DEF VAR nv_Entdat     AS DATE.
DEF VAR nv_EntTime    AS CHAR.
DEF VAR nv_policy     LIKE uwm100.policy.
DEF VAR nv_rencnt     LIKE uwm100.rencnt.
DEF VAR nv_endcnt     LIKE uwm100.endcnt.
DEF VAR nv_company    LIKE uwm100.acno1.
DEF VAR nv_nlicense     AS CHAR.   /*Saowapa U. 02/10/2019 A62-0448*/

DEFINE TEMP-TABLE wprocess   
     FIELD wasdat        LIKE acm001.latdat            LABEL "As of Date    "                                                                                       
     FIELD wdept         LIKE acm001.dept              LABEL "Department    "                                                      
     FIELD wtrndat       LIKE acm001.trndat            LABEL "Trans.date    "                                                      
     FIELD wpolicy       LIKE acm001.policy            LABEL "Policy        "                                                      
     FIELD wEndno        LIKE acm001.ref               LABEL "Endt.No.      "                                                      
     FIELD wComdat       LIKE acm001.Comdat            LABEL "Com Date      "                                                      
     FIELD wtrntyp1      LIKE acm001.trnty1            LABEL "Tran.type1    "                                                      
     FIELD wtrntyp2      LIKE acm001.trnty2            LABEL "Tran.type2    "                                                      
     FIELD wDocno        LIKE acm001.Docno FORMAT "X(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */ LABEL "Doc.No.  "           
     FIELD wagent        LIKE acm001.agent             LABEL "Agent         "                                                      
     FIELD wInsure       LIKE acm001.ref               LABEL "Customer      "                                                      
     FIELD wPrem         LIKE acm001.Prem              LABEL "Premium       "                                                      
     FIELD wdicc         LIKE acm001.fee               LABEL "R/I Discount  "                                                      
     FIELD wPrem_Comp    LIKE acm001.Prem              LABEL "Compulsory    "                                                      
     FIELD wStamp        LIKE acm001.Stamp             LABEL "Stamp         "                                                      
     FIELD wTax          LIKE acm001.Tax               LABEL "Vat           "                                                      
     FIELD wTax1         LIKE acm001.Tax               LABEL "TAX           "                                                      
     FIELD wGross        LIKE acm001.Prem              LABEL "Total         "                                                      
     FIELD wcomm         LIKE acm001.comm              LABEL "Commission    "                                                      
     FIELD wctotal       LIKE acm001.Prem              LABEL "Tot.Comm.     "                                                      
     FIELD wnetprem      LIKE acm001.prem              LABEL "Net Premium   "                                                      
     FIELD wnetamt       LIKE acm001.netamt            LABEL "Net Amount    "                                                      
     FIELD wbal          LIKE acm001.bal               LABEL "Balance O/S   "                                                      
     FIELD wLicense      AS   CHAR FORMAT "X(10)"      LABEL "New License   "       /*Saowapa U. A62-0448 02/10/2019*/             
     FIELD wacno         LIKE acm001.acno              LABEL "Producer      "                                                      
     FIELD wacname       LIKE xmm600.NAME              LABEL "Producer Name "                                                      
     FIELD wcedco        LIKE acm001.cedco             LABEL "Reinsurer Code"                                                      
     FIELD wcedname      LIKE xmm600.NAME              LABEL "Reinsurer Name"                                                      
     FIELD wacccod        LIKE xmm600.acccod           LABEL "Reinsurer A/C Type"   /*Saowapa U. A62-0448 02/10/2019*/             
     FIELD wcampol       LIKE uwm100.opnpol            LABEL "Campaign      "                                                      
     FIELD wagtreg       LIKE xmm600.agtreg            LABEL "Licence No    "
     FIELD wriappl       AS CHAR FORMAT "X(20)"        LABEL "R/I Appl No   "
     FIELD wclityp       LIKE xmm600.clicod            LABEL "Producer Type "
     FIELD wProgid       AS   CHAR FORMAT "X(8)"       LABEL "Program ID    "
     FIELD wUserid       AS   CHAR FORMAT "X(7)"       LABEL "User ID       "
     FIELD wEntdat       AS   DATE FORMAT "99/99/9999" LABEL "Entry Date    "
     FIELD wEntTime      AS   CHAR FORMAT "X(10)"      LABEL "Entry Time    "
     FIELD wsi           LIKE acm001.bal               LABEL "Sum Insured   "   /*A59-0103*/
     FIELD wthpol        LIKE uwm200.thpol             LABEL "Their Policy no."   /*A63-0415*/
     INDEX wprocess01  wcedco  wtrndat wpolicy  wtrntyp1  wDocno
     INDEX wprocess02  wProgid   wUserid  wEntdat   wEntTime . 

DEF VAR nv_si AS DEC FORMAT "->,>>>,>>>,>>>,>>9.99".   /*A59-0103*/

/*Saowapa U. A62-0448 09/10/2019*/
DEFINE TEMP-TABLE rcode 
    FIELD rcedco    AS CHAR
    FIELD racccod   AS CHAR
    FIELD rcomdat   AS CHAR
    FIELD rname     AS CHAR
    FIELD rLicense  AS CHAR
    FIELD amt       AS DEC.

DEFINE TEMP-TABLE summar 
    FIELD spolicy    AS CHAR
    FIELD sacccod    AS CHAR
    FIELD sfire      AS DEC
    FIELD stotal     AS DEC
    FIELD siar       AS DEC
    FIELD smisc      AS DEC
    FIELD setc       AS DEC
    FIELD sfirerd    AS DEC
    FIELD siarrd     AS DEC
    FIELD smiscrd    AS DEC
    FIELD setcr      AS DEC
    FIELD sfirerf    AS DEC
    FIELD siarrf     AS DEC
    FIELD smiscrf    AS DEC
    FIELD setcrf    AS DEC.
/*end Saowapa U. A62-0448 09/10/2019*/
  


DEFINE TEMP-TABLE cprocess   
     FIELD casdat        LIKE acm001.latdat            LABEL "As of Date           "
     FIELD cdept         LIKE acm001.dept              LABEL "Department           "                 
     FIELD ctrndat       LIKE acm001.trndat            LABEL "Trans.date           "   
     FIELD cclaim        LIKE acm001.ref               LABEL "Claim No.            "   
     FIELD cpolicy       LIKE acm001.policy            LABEL "Policy               "        
     FIELD clossdat      LIKE acm001.Comdat            LABEL "Loss Date            "   
     FIELD centrydat     LIKE acm001.entdat            LABEL "Entry Date           "    /*A56-0267*/ 
     FIELD cpaddat       LIKE acm001.trndat            LABEL "Paid Date            "    /*A56-0267*/ 
     FIELD ctrntyp1      LIKE acm001.trnty1            LABEL "Tran.type1           "  
     FIELD ctrntyp2      LIKE acm001.trnty2            LABEL "Tran.type2           "  
     FIELD cDocno        LIKE acm001.Docno FORMAT "X(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */ LABEL "Doc.No. "
     FIELD cagent        LIKE acm001.agent             LABEL "Agent                "
     FIELD cInsure       LIKE acm001.ref               LABEL "Insured Name         "
     FIELD cpayname      LIKE acm001.ref               LABEL "Payee Name           "
     FIELD cGross        LIKE acm001.Prem              LABEL "Gross Claim Paid     "    
     FIELD cPrem         LIKE acm001.Prem              LABEL "You Share            "     
     FIELD cbal          LIKE acm001.bal               LABEL "Balance O/S          "
     FIELD cacno         LIKE acm001.acno              LABEL "Outward Producer     "
     FIELD cacname       LIKE xmm600.NAME              LABEL "Outward Producer Name"
     FIELD crico         LIKE acm001.acno              LABEL "Reinsurer            "
     FIELD ccedco        LIKE acm001.cedco             LABEL "Reinsurer Code"
     FIELD ccedname      LIKE xmm600.NAME              LABEL "Reinsurer Name "
     FIELD ccampol       LIKE uwm100.opnpol            LABEL "Campaign      "
     FIELD cagtreg       LIKE xmm600.agtreg            LABEL "Licence No    "
     FIELD criappl       AS CHAR FORMAT "X(20)"        LABEL "R/I Appl No   "
     FIELD cclityp       LIKE xmm600.clicod            LABEL "Producer Type "
     FIELD cProgid       AS   CHAR FORMAT "X(8)"       LABEL "Program ID           "
     FIELD cUserid       AS   CHAR FORMAT "X(7)"       LABEL "User ID              "
     FIELD cEntdat       AS   DATE FORMAT "99/99/9999" LABEL "Entry Date           "
     FIELD cEntTime      AS   CHAR FORMAT "X(10)"      LABEL "Entry Time           "
     INDEX cprocess01  crico ctrndat cclaim  cpolicy  ctrntyp1  cDocno
     INDEX cprocess02  cProgid   cUserid cEntdat  cEntTime .


DEF VAR n_campol  LIKE uwm100.opnpol.
DEF VAR n_clityp  LIKE xmm600.clicod.
DEF VAR n_raccod  LIKE xmm600.acccod.
DEF VAR n_netprem AS DEC FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR n_cedname LIKE xmm600.NAME.
DEF VAR n_agtreg  LIKE xmm600.agtreg. 
DEF VAR n_riappl  AS CHAR FORMAT "X(20)".
DEF VAR n_appno   AS CHAR FORMAT "X(20)".
DEF VAR n_no      AS CHAR FORMAT "X(20)".  
DEF VAR n_year    AS CHAR FORMAT "X(20)".

DEF VAR n_thpol AS CHAR INIT "". /*A63-0415*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-408 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WACR0091 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-408
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 133 BY 1.91
     BGCOLOR 3 .

DEFINE VARIABLE fiDisplay AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 64 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "CANCEL" 
     SIZE 16 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 16 BY 1.29
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 20.5 BY 2.14
     BGCOLOR 4 .

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 20.33 BY 2.14
     BGCOLOR 1 .

DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE VARIABLE cbAsMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cbFrMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cbRptList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 3
     LIST-ITEMS "Statement Premium Inward","Statement Premium Outward","Statement Claim Paid Outward" 
     DROP-DOWN-LIST
     SIZE 62 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cbToMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 12
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAsYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 47.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 47.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFrDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiFrYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 39.17 BY .95
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 39.17 BY .95
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE fioutput AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 87 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiToDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiToYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTyp1 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp10 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp11 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp12 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp13 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp14 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp3 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp4 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp5 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp6 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp7 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp8 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp9 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_code AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 71.83 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE rstype AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "MOTOR", 1,
"NON-MOTOR", 2,
"ALL", 3
     SIZE 16.83 BY 2.71
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE reAsdate
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 116.67 BY 3.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-102
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 72.5 BY 3.95
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-109
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 44 BY 4.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-110
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 44 BY 3.95
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-409
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 72.67 BY 4.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-86
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 44 BY 4.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 72.5 BY 4.38
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     "R/I  REPORT  FOR  RBC  (PREMIUM INWARD-OUTWARD ,CLAIM PAID OUTWARD)":120 VIEW-AS TEXT
          SIZE 72.33 BY .95 AT ROW 1.48 COL 33.17
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-408 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 21.95
         BGCOLOR 19 .

DEFINE FRAME frMain
     Btn_Cancel AT ROW 18.57 COL 106.5
     Btn_OK AT ROW 18.62 COL 85.67
     RECT-3 AT ROW 18.19 COL 104
     RECT2 AT ROW 18.19 COL 83.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.33 ROW 3
         SIZE 130.5 BY 19.67
         BGCOLOR 3 .

DEFINE FRAME frST
     fi_code AT ROW 9.76 COL 4.5 COLON-ALIGNED
     cbRptList AT ROW 3.24 COL 8.67 COLON-ALIGNED NO-LABEL
     fiBranch AT ROW 6.91 COL 15.67 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 7.95 COL 15.67 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 11.19 COL 15.33 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 12.29 COL 15.33 COLON-ALIGNED NO-LABEL
     fiFrDay AT ROW 2.86 COL 89.17 COLON-ALIGNED NO-LABEL
     cbFrMth AT ROW 2.86 COL 93.33 COLON-ALIGNED NO-LABEL
     fiFrYear AT ROW 2.86 COL 110.67 COLON-ALIGNED NO-LABEL
     fiToDay AT ROW 3.95 COL 89.17 COLON-ALIGNED NO-LABEL
     cbToMth AT ROW 3.95 COL 93.33 COLON-ALIGNED NO-LABEL
     fiToYear AT ROW 3.95 COL 110.67 COLON-ALIGNED NO-LABEL
     rstype AT ROW 6.57 COL 80.83 NO-LABEL
     fiTyp1 AT ROW 11.1 COL 81.67 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 11.1 COL 86.67 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 11.1 COL 91.67 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 11.1 COL 96.67 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 11.1 COL 101.67 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 11.1 COL 106.67 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 11.1 COL 111.67 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 12.19 COL 81.67 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 12.19 COL 86.67 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 12.19 COL 91.67 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 12.19 COL 96.67 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 12.19 COL 101.67 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 12.19 COL 106.67 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 12.19 COL 111.67 COLON-ALIGNED NO-LABEL
     fiAsDay AT ROW 14.38 COL 25.83 COLON-ALIGNED NO-LABEL
     cbAsMth AT ROW 14.38 COL 30 COLON-ALIGNED NO-LABEL
     fiAsYear AT ROW 14.38 COL 47 COLON-ALIGNED NO-LABEL
     fioutput AT ROW 15.62 COL 25.67 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 6.91 COL 22.83
     buBranch2 AT ROW 8 COL 22.83
     buAcno1 AT ROW 11.24 COL 32.5
     buAcno2 AT ROW 12.38 COL 32.5
     fibdes AT ROW 6.91 COL 25.17 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 7.95 COL 25.17 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 11.29 COL 35 COLON-ALIGNED
     finame2 AT ROW 12.29 COL 35 COLON-ALIGNED NO-LABEL
     "TO :":5 VIEW-AS TEXT
          SIZE 5.5 BY .95 TOOLTIP "ถึง" AT ROW 4 COL 85
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     TO :":40 VIEW-AS TEXT
          SIZE 8.5 BY 1 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 8 COL 9.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " FROM :":40 VIEW-AS TEXT
          SIZE 8.5 BY 1 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 6.95 COL 9.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  TYPE OF REPORT":40 VIEW-AS TEXT
          SIZE 71.83 BY 1 AT ROW 1.57 COL 6.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "  BRANCH":40 VIEW-AS TEXT
          SIZE 71.83 BY 1 TOOLTIP "ประเภทงาน" AT ROW 5.48 COL 6.67
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "  POLICY TYPE":40 VIEW-AS TEXT
          SIZE 43.5 BY 1 TOOLTIP "ประเภทงาน" AT ROW 5.38 COL 79
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "          OUTPUT TO :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 15.57 COL 6.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " TRANSACTION  DATE":40 VIEW-AS TEXT
          SIZE 43.5 BY 1 TOOLTIP "วันที่ทำกรมธรรม์" AT ROW 1.57 COL 79
          BGCOLOR 1 FGCOLOR 7 FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.67 ROW 1.14
         SIZE 127 BY 16.76
         BGCOLOR 19 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     "FROM :":10 VIEW-AS TEXT
          SIZE 8.17 BY .95 TOOLTIP "ตั้งแต่" AT ROW 2.91 COL 82.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " FROM :":40 VIEW-AS TEXT
          SIZE 8.5 BY 1 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 11.19 COL 8.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "          AS OF DATE :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 14.43 COL 6.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     TO :":40 VIEW-AS TEXT
          SIZE 8.5 BY 1 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 12.38 COL 8.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "  INCLUDE TYPE ALL":40 VIEW-AS TEXT
          SIZE 43.5 BY 1 AT ROW 9.76 COL 79
          BGCOLOR 1 FGCOLOR 7 FONT 6
     reAsdate AT ROW 13.81 COL 6
     RECT11 AT ROW 5.24 COL 6.17
     RECT-109 AT ROW 5.24 COL 78.67
     RECT-409 AT ROW 9.62 COL 6
     RECT-86 AT ROW 9.62 COL 78.67
     RECT-102 AT ROW 1.43 COL 6.17
     RECT-110 AT ROW 1.43 COL 78.67
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.67 ROW 1.14
         SIZE 127 BY 16.76
         BGCOLOR 19 .

DEFINE FRAME frDisplay
     fiDisplay AT ROW 1.48 COL 6 NO-LABEL
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 2.83 ROW 18.38
         SIZE 74.83 BY 2.05
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
  CREATE WINDOW WACR0091 ASSIGN
         HIDDEN             = YES
         TITLE              = "wacr0091 - R/I  Outstanding"
         HEIGHT             = 21.95
         WIDTH              = 133
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = no
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
IF NOT WACR0091:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WACR0091
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frDisplay:FRAME = FRAME frMain:HANDLE
       FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frDisplay
                                                                        */
/* SETTINGS FOR FILL-IN fiDisplay IN FRAME frDisplay
   ALIGN-L                                                              */
ASSIGN 
       fiDisplay:HIDDEN IN FRAME frDisplay           = TRUE.

/* SETTINGS FOR FRAME frMain
                                                                        */
/* SETTINGS FOR FRAME frST
   Custom                                                               */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN fi_code IN FRAME frST
   LABEL ":"                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACR0091)
THEN WACR0091:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WACR0091
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACR0091 WACR0091
ON END-ERROR OF WACR0091 /* wacr0091 - R/I  Outstanding */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACR0091 WACR0091
ON WINDOW-CLOSE OF WACR0091 /* wacr0091 - R/I  Outstanding */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel WACR0091
ON CHOOSE OF Btn_Cancel IN FRAME frMain /* CANCEL */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK WACR0091
ON CHOOSE OF Btn_OK IN FRAME frMain /* OK */
DO:
   DEF VAR vFirstTime  AS CHAR INIT "".
   DEF VAR vLastTime   AS CHAR INIT "".

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN 
            FRAME frST fibranch  fibranch   
            FRAME frST fibranch2 fibranch2  
            FRAME frST rsType    rsType
            FRAME frST cbRptList cbRptList
            FRAME frST fioutput  fioutput

            FRAME frST fiacno1   fiacno1
            FRAME frST fiacno2   fiacno2
            FRAME frST fiAsDay   fiAsDay
            FRAME frST cbAsMth   cbAsMth
            FRAME frST fiAsYear  fiAsYear

            FRAME frST fiFrDay   fiFrDay
            FRAME frST cbFrMth   cbFrMth
            FRAME frST fiFrYear  fiFrYear
            FRAME frST fiToDay   fiToDay
            FRAME frST cbToMth   cbToMth
            FRAME frST fiToYear  fiToYear
       
            nv_asmth     =  LOOKUP (cbasMth, cv_mthlistE)
            nv_frmth     =  LOOKUP (cbFrMth, cv_mthlistE)
            nv_tomth     =  LOOKUP (cbToMth, cv_mthlistE)
                       
            n_asdat      =  DATE (nv_asmth, fiasDay, fiasYear)
            n_frdate     =  DATE (nv_Frmth, fiFrDay, fiFrYear)
            n_todate     =  DATE (nv_Tomth, fiToDay, fiToYear)
            n_frac       =  fiacno1
            n_toac       =  fiacno2 
            n_branch     =  fiBranch 
            n_branch2    =  fiBranch2
            n_OutputFile =  fioutput.

         IF      rsType = 1 THEN n_type = "Motor" .
         ELSE IF rsType = 2 THEN n_type = "Non-Motor" .
         ELSE                    n_type = "All".

       ASSIGN
         nv_filter1 = IF fityp1  <> "" THEN fityp1 + ","  ELSE "" + ","
         nv_filter1 = IF fityp2  <> "" THEN nv_filter1 + fityp2   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp3  <> "" THEN nv_filter1 + fityp3   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp4  <> "" THEN nv_filter1 + fityp4   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp5  <> "" THEN nv_filter1 + fityp5   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp6  <> "" THEN nv_filter1 + fityp6   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp7  <> "" THEN nv_filter1 + fityp7   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp8  <> "" THEN nv_filter1 + fityp8   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp9  <> "" THEN nv_filter1 + fityp9   + ","   ELSE nv_filter1
         nv_filter1 = IF fityp10 <> "" THEN nv_filter1 + fityp10  + ","   ELSE nv_filter1
         nv_filter1 = IF fityp11 <> "" THEN nv_filter1 + fityp11  + ","   ELSE nv_filter1
         nv_filter1 = IF fityp12 <> "" THEN nv_filter1 + fityp12  + ","   ELSE nv_filter1
         nv_filter1 = IF fityp13 <> "" THEN nv_filter1 + fityp13  + ","   ELSE nv_filter1
         nv_filter1 = IF fityp14 <> "" THEN nv_filter1 + fityp14  + ","   ELSE nv_filter1.         

   END.

   If  n_frac = "" Then  n_frac = "0D00000".      
   If  n_toac = "" Then  n_toac = "0FZZZZZZZZ".   

   IF n_branch = "" THEN DO:
      MESSAGE "Branch From is Mandatory " VIEW-AS ALERT-BOX WARNING . 
      APPLY "Entry" TO fiBranch.
      RETURN NO-APPLY.
   END.

   IF n_branch2 = "" THEN DO:
      MESSAGE "Branch To is Mandatory " VIEW-AS ALERT-BOX WARNING . 
      APPLY "Entry" TO fiBranch.
      RETURN NO-APPLY.
   END.

   IF (n_branch > n_branch2) THEN DO:
       MESSAGE "ข้อมูลรหัสสาขาผิดพลาด" SKIP
               "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" TO fibranch.
       RETURN NO-APPLY.
   END.

   IF n_frac = "" THEN DO:
       MESSAGE "Producer OR Reinsurance Code From is Mandatory " VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" TO fiacno1.
       RETURN NO-APPLY.
   END.

   IF n_toac = "" THEN DO:
       MESSAGE "Producer OR Reinsurance Code To is Mandatory " VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" TO fiacno2.
       RETURN NO-APPLY.
   END.

   IF (n_frac > n_toac) THEN DO:
      MESSAGE "ข้อมูล Producer OR Reinsurance Code ผิดพลาด" SKIP
              "Cedding OR Reinsurance Code เริ่มต้นต้องมากกว่า Cedding OR Reinsurance Code สุดท้าย" VIEW-AS ALERT-BOX WARNING . 
      APPLY "Entry" TO fiacno1.
      RETURN NO-APPLY.
   END.

   IF n_frdate = ? THEN DO:
       MESSAGE "Transaction Date From is Mandatory " VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" TO fifrday.
       RETURN NO-APPLY.
   END.

   IF n_todate = ? THEN DO:
       MESSAGE "Transaction Date To is Mandatory " VIEW-AS ALERT-BOX WARNING . 
       APPLY "Entry" TO fitoday.
       RETURN NO-APPLY.
   END.

   IF (n_frdate > n_todate) THEN DO:
      MESSAGE "ข้อมูล Transaction Date ผิดพลาด" SKIP
              "Transaction Date เริ่มต้นต้องมากกว่า Transaction Date สุดท้าย" VIEW-AS ALERT-BOX WARNING . 
      APPLY "Entry" TO fifrday.
      RETURN NO-APPLY.
   END.

   IF n_asdat = ?   THEN DO:
      MESSAGE "As of Date To is Mandatory " VIEW-AS ALERT-BOX WARNING . 
      APPLY "Entry" TO fiasday. 
      RETURN NO-APPLY.          
   END.

   IF n_OutputFile = "" THEN DO:
      MESSAGE "Output To File is Mandatory " VIEW-AS ALERT-BOX WARNING . 
      APPLY "Entry" TO fioutput.
      RETURN NO-APPLY.
   END.
   ELSE DO:
        OUTPUT TO VALUE(fioutput).
        OUTPUT CLOSE.
   END.

   IF n_typereport = "1"  THEN DO: /*Statement Premium Inward*/
       MESSAGE "สาขา                  : "  n_Branch " ถึง " n_Branch2 SKIP(1)
               "Producer Code           : "  n_frac " ถึง " n_toac      SKIP(1)
               "ข้อมูล ณ. วันที่      : "  STRING(n_asdat,"99/99/9999") SKIP(1)
               "กรมธรรม์ตั้งแต่วันที่ : " STRING(n_frdate,"99/99/9999") " ถึง " STRING(n_todate,"99/99/9999") SKIP (1)
               "Include Type          : "  nv_filter1 SKIP(1)
               "พิมพ์รายงาน           : "  cbRptList 
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "CONFIRM"    
       UPDATE CHOICE1 AS LOGICAL.
       CASE CHOICE1:
              WHEN TRUE THEN DO:
                
                vFirstTime =  STRING(TIME, "HH:MM:SS AM").
                
                RUN PDPROCESS_INWARD.
                RUN PDPrintPage1.
               
                vLastTime =  STRING(TIME, "HH:MM:SS AM").
    
                MESSAGE "ข้อมูล ณ. วันที่ : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                        "Ceding Code      : "  n_frac " ถึง " n_toac SKIP (1)
                        "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.         
              END.
              WHEN FALSE THEN DO:
                   RETURN NO-APPLY.
              END.
       END CASE.

       RUN pdClearReport1.
   END.
   ELSE IF n_typereport = "2"  THEN DO: /*Statement Premium Outward*/
       MESSAGE "สาขา                  : "  n_Branch " ถึง " n_Branch2 SKIP(1)
               "Reinsurance Code      : "  n_frac " ถึง " n_toac      SKIP(1)
               "ข้อมูล ณ. วันที่      : "  STRING(n_asdat,"99/99/9999") SKIP(1)
               "กรมธรรม์ตั้งแต่วันที่ : " STRING(n_frdate,"99/99/9999") " ถึง " STRING(n_todate,"99/99/9999") SKIP (1)
               "Include Type          : "  nv_filter1 SKIP(1)
               "พิมพ์รายงาน           : "  cbRptList 
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "CONFIRM"    
       UPDATE CHOICE2 AS LOGICAL.
       CASE CHOICE2:
              WHEN TRUE THEN DO:
                
                vFirstTime =  STRING(TIME, "HH:MM:SS AM").

                RUN PDPROCESS_OUTWARD.
                RUN PDPrintPage1.
               
                vLastTime =  STRING(TIME, "HH:MM:Ss AM").
    
                MESSAGE "ข้อมูล ณ. วันที่ : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                        "Reinsurance Code : "  n_frac " ถึง " n_toac SKIP (1)
                        "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.         
              END.
              WHEN FALSE THEN DO:
                   RETURN NO-APPLY.
              END.
       END CASE.

       RUN pdClearReport1.
   END.
   ELSE IF n_typereport = "3"  THEN DO: /*Statement Claim paid Outward*/
       MESSAGE "สาขา                  : "  n_Branch " ถึง " n_Branch2 SKIP(1)
               "Reinsurance Code      : "  n_frac " ถึง " n_toac      SKIP(1)
               "ข้อมูล ณ. วันที่      : "  STRING(n_asdat,"99/99/9999") SKIP(1)
               "กรมธรรม์ตั้งแต่วันที่ : " STRING(n_frdate,"99/99/9999") " ถึง " STRING(n_todate,"99/99/9999") SKIP (1)
               "Include Type          : "  nv_filter1 SKIP(1)
               "พิมพ์รายงาน           : "  cbRptList 
       VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO TITLE "CONFIRM"    
       UPDATE CHOICE3 AS LOGICAL.
       CASE CHOICE3:
              WHEN TRUE THEN DO:
                
                vFirstTime =  STRING(TIME, "HH:MM:SS AM").

                RUN PDPROCESS_CLAIM.
                RUN PDPrintPage2.
               
                vLastTime =  STRING(TIME, "HH:MM:SS AM").
    
                MESSAGE "ข้อมูล ณ. วันที่ : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                        "Reinsurance Code : "  n_frac " ถึง " n_toac SKIP (1)
                        "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.         
              END.
              WHEN FALSE THEN DO:
                   RETURN NO-APPLY.
              END.
       END CASE.

       RUN pdClearReport2.
   END.
         
   /*MESSAGE "Export Data Complete"  VIEW-AS ALERT-BOX INFORMATION.*/
   /*APPLY "CHOOSE" TO btn_cancel.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 WACR0091
ON CHOOSE OF buAcno1 IN FRAME frST /* ... */
DO:
  n_chkname = "1". 
  RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT  n_chkname).
  
  ASSIGN    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  DISP fiacno1 finame1  WITH FRAME {&FRAME-NAME}.

  n_agent1 = fiacno1 .

  RETURN NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 WACR0091
ON CHOOSE OF buAcno2 IN FRAME frST /* ... */
DO:
  n_chkname = "2". 
  RUN Whp\WhpAcno(INPUT-OUTPUT  n_name,INPUT-OUTPUT  n_chkname).
  
  ASSIGN    
     fiacno2 = n_agent2
     finame2 = n_name.
       
  Disp fiacno2 finame2 with Frame {&Frame-Name}      .
   
  n_agent2 =  fiacno2 .
  
  Return NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch WACR0091
ON CHOOSE OF buBranch IN FRAME frST /* ... */
DO:
  n_chkBName = "1". 
  RUN Whp\Whpbran(INPUT-OUTPUT  n_bdes,INPUT-OUTPUT n_chkBName).
  
  ASSIGN    
        fibranch = n_branch
        fibdes   = n_bdes.
       
  DISP fibranch fibdes  WITH FRAME {&FRAME-NAME}.
 
  n_branch =  fibranch .
  RETURN NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 WACR0091
ON CHOOSE OF buBranch2 IN FRAME frST /* ... */
DO:
   n_chkBName = "2". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch2 = n_branch2
        fibdes2   = n_bdes.
       
  Disp fibranch2 fibdes2  with Frame {&Frame-Name}      .
 
 n_branch2 =  fibranch2.

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbRptList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList WACR0091
ON RETURN OF cbRptList IN FRAME frST
DO:
    APPLY "ENTRY" TO fiBranch IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList WACR0091
ON VALUE-CHANGED OF cbRptList IN FRAME frST
DO:  

  IF cbRptList:SCREEN-VALUE = "Statement Premium Inward" THEN DO:
       ASSIGN fityp1       = "O" 
              fityp2       = "T"
              /*fi_code      = "  CEDING CODE"*/
              fi_code      = "  PRODUCER CODE"
              n_typereport = "1" .
       DISPLAY fityp1 fityp2 fi_code WITH FRAME frst.
  END.
  ELSE IF cbRptList:SCREEN-VALUE = "Statement Premium Outward" THEN DO:
       ASSIGN fityp1       = "U" 
              fityp2       = "P"
              fi_code      = "  REINSURANCE CODE"
              n_typereport = "2" .
       DISPLAY fityp1 fityp2 fi_code WITH FRAME frst.
  END.
  ELSE IF cbRptList:SCREEN-VALUE = "Statement Claim Paid Outward" THEN DO:
       ASSIGN fityp1       = "F" 
              fityp2       = "E"
              fi_code      = "  REINSURANCE CODE"
              n_typereport = "3" .
       DISPLAY fityp1 fityp2 fi_code WITH FRAME frst.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 WACR0091
ON LEAVE OF fiacno1 IN FRAME frST
DO:
    ASSIGN
        fiacno1  = INPUT fiacno1
        n_agent1 = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME frST.
        
    IF INPUT FiAcno1 <> "" Then Do :        
        FIND xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
            finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
            /*fiAcno1 = "".*/
            finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
            /*MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  WARNING TITLE "Confirm" .*/
        END.
    END.
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 WACR0091
ON RETURN OF fiacno1 IN FRAME frST
DO:
/*    Assign
 *   fiacno1 = input fiacno1
 *   n_agent1  = fiacno1.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 WACR0091
ON LEAVE OF fiacno2 IN FRAME frST
DO:
    ASSIGN
        fiacno2  = INPUT fiacno2
        n_agent2 = fiacno2.

    DISP CAPS(fiacno2) @ fiacno2 WITH FRAME frST.
            
    IF INPUT  FiAcno2 <> "" THEN DO:
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              /*fiAcno2 = "".*/
              finame2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Not Found !".
              /*MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  WARNING TITLE "Confirm" .*/
        END.
    END.
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 WACR0091
ON RETURN OF fiacno2 IN FRAME frST
DO:
/*      Assign
 *   fiacno2 = input fiacno2
 *   n_agent2  = fiacno2.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiAsDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiAsDay WACR0091
ON LEAVE OF fiAsDay IN FRAME frST
DO:
  ASSIGN fiAsDay.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch WACR0091
ON LEAVE OF fiBranch IN FRAME frST
DO:
  ASSIGN
    fibranch = INPUT fibranch
    n_branch = fibranch.

  DISP CAPS(fibranch) @ fibranch WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch WACR0091
ON RETURN OF fiBranch IN FRAME frST
DO:
  ASSIGN
    fibranch = INPUT fibranch
    n_branch = fibranch.
  
  FIND xmm023 WHERE xmm023.branch = n_branch  NO-ERROR.
    IF AVAILABLE xmm023 THEN DO:
       fibdes:SCREEN-VALUE IN FRAME {&FRAME-NAME} = xmm023.bdes.
    END.        
    ELSE DO:
       fibdes:SCREEN-VALUE IN FRAME {&FRAME-NAME} = "Not Found !".
       MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 WACR0091
ON LEAVE OF fiBranch2 IN FRAME frST
DO:
 ASSIGN
   fibranch2 = INPUT fibranch2
   n_branch2  = fibranch2.

 DISP CAPS(fibranch2)@ fibranch2 WITH FRAME frST.         
 APPLY "Entry" TO fiAcno1.           
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 WACR0091
ON RETURN OF fiBranch2 IN FRAME frST
DO:
  Assign
  fibranch2 = input fibranch2
  n_branch2  = fibranch2.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
  END.        
  ELSE DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFrDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFrDay WACR0091
ON LEAVE OF fiFrDay IN FRAME frST
DO:
  ASSIGN fiFrDay.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToDay WACR0091
ON LEAVE OF fiToDay IN FRAME frST
DO:
  ASSIGN fiToDay.
  
  fiToDay  = INPUT fiToDay.
  DISP fiToDay WITH FRAME frst.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToYear WACR0091
ON LEAVE OF fiToYear IN FRAME frST
DO:
    ASSIGN fiToYear.
  
/*     fiAsYear  =  fiToYear.
 *    DISP fiAsYear WITH FRAME frST.*/
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp1 WACR0091
ON LEAVE OF fiTyp1 IN FRAME frST
DO:
    fiTyp1 = CAPS(INPUT fiTyp1).
    DISP fiTyp1 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp10 WACR0091
ON LEAVE OF fiTyp10 IN FRAME frST
DO:
    fiTyp10 = CAPS(INPUT fiTyp10).
    DISP fiTyp10 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp11 WACR0091
ON LEAVE OF fiTyp11 IN FRAME frST
DO:
    fiTyp11 = CAPS(INPUT fiTyp11).
    DISP fiTyp11 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp12 WACR0091
ON LEAVE OF fiTyp12 IN FRAME frST
DO:
    fiTyp12 = CAPS(INPUT fiTyp12).
    DISP fiTyp12 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp13 WACR0091
ON LEAVE OF fiTyp13 IN FRAME frST
DO:
    fiTyp13 = CAPS(INPUT fiTyp13).
    DISP fiTyp13 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp14 WACR0091
ON LEAVE OF fiTyp14 IN FRAME frST
DO:
    fiTyp14 = CAPS(INPUT fiTyp14).
    DISP fiTyp14 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp2 WACR0091
ON LEAVE OF fiTyp2 IN FRAME frST
DO:
    fiTyp2 = CAPS(INPUT fiTyp2).
    DISP fiTyp2 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp3 WACR0091
ON LEAVE OF fiTyp3 IN FRAME frST
DO:
    fiTyp3 = CAPS(INPUT fiTyp3).
    DISP fiTyp3 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp4 WACR0091
ON LEAVE OF fiTyp4 IN FRAME frST
DO:
    fiTyp4 = CAPS(INPUT fiTyp4).
    DISP fiTyp4 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp5 WACR0091
ON LEAVE OF fiTyp5 IN FRAME frST
DO:
    fiTyp5 = CAPS(INPUT fiTyp5).
    DISP fiTyp5 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp6 WACR0091
ON LEAVE OF fiTyp6 IN FRAME frST
DO:
    fiTyp6 = CAPS(INPUT fiTyp6).
    DISP fiTyp6 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp7 WACR0091
ON LEAVE OF fiTyp7 IN FRAME frST
DO:
    fiTyp7 = CAPS(INPUT fiTyp7).
    DISP fiTyp7 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp8 WACR0091
ON LEAVE OF fiTyp8 IN FRAME frST
DO:
    fiTyp8 = CAPS(INPUT fiTyp8).
    DISP fiTyp8 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp9 WACR0091
ON LEAVE OF fiTyp9 IN FRAME frST
DO:
    fiTyp9 = CAPS(INPUT fiTyp9).
    DISP fiTyp9 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rstype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rstype WACR0091
ON VALUE-CHANGED OF rstype IN FRAME frST
DO:
  ASSIGN {&SELF-NAME}.
  rstype = INPUT rstype.

  IF      rsType = 1 THEN n_type = "Motor" .
  ELSE IF rsType = 2 THEN n_type = "Non-Motor" .
  ELSE                    n_type = "All".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WACR0091 


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
  
  gv_prgid = "WACR0091".
  gv_prog  = "R/I OUTSTANDING REPORT".

  RUN  WUT\WUTHEAD (WACR0091:handle,gv_prgid,gv_prog).
/*********************************************************************/  
  RUN WUT\WUTWICEN (WACR0091:HANDLE).

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.  */

  
  SESSION:DATA-ENTRY-RETURN = YES. 

  DO WITH FRAME frST:
     APPLY "ENTRY" TO fibranch.

     ASSIGN   
         cbRptList:LIST-ITEMS = "Statement Premium Inward,Statement Premium Outward,Statement Claim Paid Outward"         
         cbAsMth:LIST-ITEMS   = cv_mthlistE
         cbFrMth:List-Items   = cv_mthlistE
         cbToMth:List-Items   = cv_mthlistE
         cbRptList            = ENTRY(1, cbRptList:LIST-ITEMS) 
         n_typereport         = "1" /*Statement Premium Inward*/
         fiacno1      = "0D00000"
         fiacno2      = "0FZZZZZZZZ" 
         fiBranch     = "0" 
         fiBranch2    = "Z" 

         /**** วันที่สิ้นเดือนของเดือนก่อน วันปัจจุบัน 
         fiAsDAy      = DAY(DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1)           
         cbAsMth      = IF MONTH(TODAY) = 1 THEN ENTRY (12 , cv_mthlistE)
                        ELSE ENTRY( (MONTH (TODAY)) - 1 , cv_mthlistE)                    
         fiAsYear     = YEAR(DATE(MONTH(TODAY),1,YEAR(TODAY)) - 1)    
         ****/
         fiAsDAy      = DAY (TODAY) 
         cbAsMth      = ENTRY(MONTH (TODAY), cv_mthlistE)                          
         fiAsYear     = YEAR (TODAY)

         fiFrDay      = 1 
         cbFrMth      = ENTRY(1, cv_mthlistE)     
         fiFrYear     = 1988 

         fiToDay      = DAY (TODAY) 
         cbToMth      = ENTRY(MONTH (TODAY), cv_mthlistE)                                                                                                                           
         fiToYear     = YEAR (TODAY)                       

         fityp1       = "O" 
         fityp2       = "T"
         fityp3       = ""
         fityp4       = ""
         fityp5       = ""
         rsType       = 1
         fi_code      = "  PRODUCER CODE".
         

     IF      rstype = 1 THEN n_type = "MOTOR".
     ELSE IF rstype = 2 THEN n_type = "NON-MOTOR".
     ELSE                    n_type = "ALL".        
                            
     DISPLAY fiBranch  fiBranch2             
             fiacno1   fiacno2  
             fiAsDay   cbAsMth  fiAsYear 
             fiFrDay   cbFrMth  fiFrYear
             fiToDay   cbToMth  fiToYear
             cbRptList fi_code
             fityp1   fityp2  fityp3  fityp4  fityp5  rsType 
             
     WITH FRAME frST.

    RUN pdInitData.  

  END.     

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WACR0091  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACR0091)
  THEN DELETE WIDGET WACR0091.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WACR0091  _DEFAULT-ENABLE
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
  ENABLE RECT-408 
      WITH FRAME DEFAULT-FRAME IN WINDOW WACR0091.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fi_code cbRptList fiBranch fiBranch2 fiacno1 fiacno2 fiFrDay cbFrMth 
          fiFrYear fiToDay cbToMth fiToYear rstype fiTyp1 fiTyp2 fiTyp3 fiTyp4 
          fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 
          fiTyp14 fiAsDay cbAsMth fiAsYear fioutput fibdes fibdes2 finame1 
          finame2 
      WITH FRAME frST IN WINDOW WACR0091.
  ENABLE fi_code cbRptList fiBranch fiBranch2 fiacno1 fiacno2 fiFrDay cbFrMth 
         fiFrYear fiToDay cbToMth fiToYear rstype fiTyp1 fiTyp2 fiTyp3 fiTyp4 
         fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 fiTyp12 fiTyp13 
         fiTyp14 fiAsDay cbAsMth fiAsYear fioutput buBranch buBranch2 buAcno1 
         buAcno2 fibdes fibdes2 finame1 finame2 reAsdate RECT11 RECT-109 
         RECT-409 RECT-86 RECT-102 RECT-110 
      WITH FRAME frST IN WINDOW WACR0091.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  ENABLE RECT-3 RECT2 Btn_Cancel Btn_OK 
      WITH FRAME frMain IN WINDOW WACR0091.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiDisplay 
      WITH FRAME frDisplay IN WINDOW WACR0091.
  ENABLE fiDisplay 
      WITH FRAME frDisplay IN WINDOW WACR0091.
  {&OPEN-BROWSERS-IN-QUERY-frDisplay}
  VIEW WACR0091.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClearReport1 WACR0091 
PROCEDURE pdClearReport1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   nv_disp = "กรุณารอสักครู่...!   โปรแกรมกำลังทำการ Clear Report".
 
   DISP  nv_disp @  fiDisplay WITH FRAME frDisplay .
   
   /* Clear Data */
   FOR EACH wprocess 
      WHERE wprocess.wProgid   =  nv_Progid 
        AND wprocess.wUserid   =  nv_Userid 
        AND wprocess.wEntdat   =  nv_Entdat 
        AND wprocess.wEntTime  =  nv_EntTime.
       DELETE wprocess.
   END.
   
   nv_disp = "Clear Report Complete..".
   DISP  nv_disp @  fiDisplay WITH FRAME frDisplay .

   FOR EACH rcode.
       DELETE rcode. 
   END.
   FOR EACH summar.
       DELETE summar. 
   END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClearReport2 WACR0091 
PROCEDURE pdClearReport2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

   nv_disp = "กรุณารอสักครู่...!   โปรแกรมกำลังทำการ Clear Report".
 
   DISP  nv_disp @  fiDisplay WITH FRAME frDisplay .
   
   /* Clear Data */
   FOR EACH cprocess 
      WHERE cprocess.cProgid   =  nv_Progid 
        AND cprocess.cUserid   =  nv_Userid 
        AND cprocess.cEntdat   =  nv_Entdat 
        AND cprocess.cEntTime  =  nv_EntTime.
       DELETE cprocess.
   END.
   
   nv_disp = "Clear Report Complete..".
   DISP  nv_disp @  fiDisplay WITH FRAME frDisplay .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData WACR0091 
PROCEDURE pdInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch  = xmm023.branch
                fibdes     = xmm023.bdes.
             DISP fiBranch fibdes .
         END.
    END.     

FIND Last  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch2  = xmm023.branch
                fibdes2     = xmm023.bdes.
             DISP fiBranch2 fibdes2 .
         END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrintPage1 WACR0091 
PROCEDURE pdPrintPage1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_wPrem       LIKE wprocess.wPrem    INIT 0.    
DEF VAR n_wPrem_com   LIKE wprocess.wPrem    INIT 0.
DEF VAR n_wStamp      LIKE wprocess.wStamp   INIT 0.   
DEF VAR n_wTax        LIKE wprocess.wTax     INIT 0.
DEF VAR n_wTax1       LIKE wprocess.wTax1    INIT 0.     
DEF VAR n_wGross      LIKE wprocess.wGross   INIT 0.   
DEF VAR n_wcomm       LIKE wprocess.wcomm    INIT 0.    
DEF VAR n_wdicc       LIKE wprocess.wdicc    INIT 0.    
DEF VAR n_wctotal     LIKE wprocess.wctotal  INIT 0.  
DEF VAR n_wnetamt     LIKE wprocess.wnetamt  INIT 0.  
DEF VAR n_wnetprem    LIKE wprocess.wnetprem INIT 0.
DEF VAR n_wbal        LIKE wprocess.wbal     INIT 0.   
DEF VAR n_wsi         LIKE wprocess.wsi      INIT 0.  /*A59-0103*/
DEF VAR ns_wPrem      LIKE wprocess.wPrem    INIT 0.    
DEF VAR ns_wPrem_com  LIKE wprocess.wPrem    INIT 0.
DEF VAR ns_wStamp     LIKE wprocess.wStamp   INIT 0.   
DEF VAR ns_wTax       LIKE wprocess.wTax     INIT 0.     
DEF VAR ns_wTax1      LIKE wprocess.wTax1    INIT 0. 
DEF VAR ns_wGross     LIKE wprocess.wGross   INIT 0. 
DEF VAR ns_wnetprem   LIKE wprocess.wnetprem INIT 0.
DEF VAR ns_wcomm      LIKE wprocess.wcomm    INIT 0.    
DEF VAR ns_wdicc      LIKE wprocess.wdicc    INIT 0.    
DEF VAR ns_wctotal    LIKE wprocess.wctotal  INIT 0.  
DEF VAR ns_wnetamt    LIKE wprocess.wnetamt  INIT 0.  
DEF VAR ns_wbal       LIKE wprocess.wbal     INIT 0.  
DEF VAR ns_wsi        LIKE wprocess.wsi      INIT 0.  /*A59-0103*/
DEF VAR n_nameacno    AS CHAR INIT "".
DEF VAR n_agtreg      AS CHAR FORMAT "X(15)" INIT "".
DEF VAR n_amt         LIKE rcode.amt         INIT 0.  /*Saowapa U. A62-0448 09/10/2019*/
DEF VAR n_mr AS CHAR.
DEF VAR n_dr AS CHAR.
DEF VAR n_yr AS CHAR.
DEF VAR n_ymdr AS CHAR.

ASSIGN
    n_wPrem       = 0        ns_wPrem      = 0  
    n_wPrem_com   = 0        ns_wPrem_com  = 0  
    n_wStamp      = 0        ns_wStamp     = 0  
    n_wTax        = 0        ns_wTax       = 0  
    n_wTax1       = 0        ns_wTax1      = 0
    n_wGross      = 0        ns_wGross     = 0  
    n_wcomm       = 0        ns_wcomm      = 0  
    n_wdicc       = 0        ns_wdicc      = 0  
    n_wctotal     = 0        ns_wctotal    = 0  
    n_wnetamt     = 0        ns_wnetamt    = 0  
    n_wbal        = 0        ns_wbal       = 0
    n_wnetprem    = 0        ns_wnetprem   = 0
    n_wsi         = 0        ns_wsi        = 0   /*A59-0103*/
    nv_nlicense   = ""
    n_ymdr        = ""
    n_mr          = ""
    n_yr          = ""
    n_dr          = "".
    /*Saowapa U. A62-0448 02/10/2019*/
      
OUTPUT TO VALUE(fioutput).


loop_exprocess1:
FOR EACH wprocess USE-INDEX wprocess02 NO-LOCK 
    WHERE wprocess.wProgid   =  nv_Progid 
      AND wprocess.wUserid   =  nv_Userid 
      AND wprocess.wEntdat   =  nv_Entdat 
      AND wprocess.wEntTime  =  nv_EntTime
    BREAK BY wprocess.wcedco
          BY wprocess.wtrndat
          BY wprocess.wpolicy
          BY wprocess.wDocno.   

        IF wprocess.wbal  = 0 THEN NEXT loop_exprocess1.
        
        IF FIRST-OF(wprocess.wcedco) THEN DO: 

            n_nameacno = "".
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = wprocess.wcedco NO-LOCK NO-ERROR.
            IF AVAIL xmm600  THEN ASSIGN n_nameacno  =  TRIM(xmm600.ntitle + " " + xmm600.name)
                                         n_agtreg    = xmm600.agtreg.

            /*
            IF n_typereport = "1" THEN DO:
                EXPORT "Producer Code  : " + wprocess.wcedco .   
                EXPORT "Producer Name : " + n_nameacno .
            END.
            ELSE DO:  
                EXPORT "Reinsurer Code : " + wprocess.wcedco .   
                EXPORT "Reinsurer Name : " + n_nameacno .            
            END.
            */

            EXPORT "Reinsurer Code : " + wprocess.wcedco .   
            EXPORT "Reinsurer Name : " + n_nameacno .

            EXPORT DELIMITER "|"
                   "Trans.date"                                                    /*1*/         
                   "Policy"                                                        /*2*/
                   "Endt.No."                                                      /*3*/
                   "Com Date"                                                      /*4*/
                   "Tran.type"                                                     /*5*/
                   "Doc.No."                                                       /*6*/
                   "Agent"                                                         /*7*/
                   "Customer"                                                      /*8*/
                   "Premium"                                                       /*9*/
                   "R/I Discount"                                                  /*10*/
                   "Net Premium"                                                   /*11*/
                   "Vat"                                                           /*12*/
                   "TAX"                                                           /*13*/
                   "Total"                                                         /*14*/
                   "Commission"                                                    /*15*/
                   "Net Amount"                                                    /*16*/
                   "Balance O/S"                                                   /*17*/
                   "New License"      /*Saowapa U. A62-0448 02/10/2562*/           /*18*/
                   "Reinsurer Code"                                                /*19*/
                   "Reinsurer Name"                                                /*20*/
                   "Their Policy no."      /*A63-0415*/                            /*21*/
                   "Reinsurer A/C Type"    /*Saowapa U. A62-0448 02/10/2562*/      /*22*/
                   "Campaign"                                                      /*23*/
                   "Licence No"                                                    /*24*/
                   "R/I Appl No"                                                   /*25*/
                   "Producer"                                                      /*26*/
                   "Producer Name"                                                 /*27*/
                   "Producer Type"                                                 /*28*/
                   "SI" .  /*A59-0103*/                                            /*29*/
                   
        END.

        ASSIGN
            n_wPrem       = n_wPrem      + wprocess.wPrem    
            n_wPrem_com   = n_wPrem_com  + wprocess.wPrem_Com
            n_wStamp      = n_wStamp     + wprocess.wStamp    
            n_wTax        = n_wTax       + wprocess.wTax   
            n_wTax1       = n_wTax1      + ((wprocess.wPrem * 0.01) * (-1))
            n_wGross      = n_wGross     + wprocess.wGross    
            n_wcomm       = n_wcomm      + wprocess.wcomm      
            n_wdicc       = n_wdicc      + wprocess.wdicc    
            n_wnetprem    = n_wnetprem   + wprocess.wnetprem
            n_wctotal     = n_wctotal    + wprocess.wctotal  
            n_wnetamt     = n_wnetamt    + wprocess.wnetamt  
            n_wbal        = n_wbal       + wprocess.wbal    
            n_wsi         = n_wsi        + wprocess.wsi   /*A59-0103*/
            ns_wPrem      = ns_wPrem     + wprocess.wPrem      
            ns_wPrem_com  = ns_wPrem_com + wprocess.wPrem_Com
            ns_wStamp     = ns_wStamp    + wprocess.wStamp    
            ns_wTax       = ns_wTax      + wprocess.wTax        
            ns_wTax1      = ns_wTax1     + ((wprocess.wPrem * 0.01) * (-1))      
            ns_wGross     = ns_wGross    + wprocess.wGross    
            ns_wcomm      = ns_wcomm     + wprocess.wcomm      
            ns_wdicc      = ns_wdicc     + wprocess.wdicc 
            ns_wnetprem   = ns_wnetprem  + wprocess.wnetprem
            ns_wctotal    = ns_wctotal   + wprocess.wctotal  
            ns_wnetamt    = ns_wnetamt   + wprocess.wnetamt  
            ns_wbal       = ns_wbal      + wprocess.wbal
            ns_wsi        = ns_wsi       + wprocess.wsi.    /*A59-0103*/ 
        /*Saowapa U A62-0448 03/10/2019*/

        FIND xmm600 WHERE  xmm600.acno = wprocess.wcedco NO-LOCK NO-ERROR.  /*A64-0410*/
        IF AVAIL xmm600 THEN DO:
            wprocess.wacccod = xmm600.acccod.
        END.
        ELSE DO:
            wprocess.wacccod = "".
        END.


        
        FIND FIRST rcode WHERE rcode.rcedco = wprocess.wcedco NO-LOCK NO-ERROR.
        IF NOT AVAIL rcode THEN DO:
            
            CREATE rcode.
            rcode.rcedco = wprocess.wcedco.
            rcode.rname =  n_nameacno.
            rcode.racccod = wprocess.wacccod.

            

            IF SUBSTRING(rcode.rcedco,1,2) = "0D" OR SUBSTRING(rcode.rcedco,1,2) = "0A"   THEN DO:   
                rcode.rLicense = "TIC-00" + n_agtreg.                                                   
            END.                                                                                           
            IF SUBSTRING(rcode.rcedco,1,2) = "0F"  THEN DO:                                             
                rcode.rLicense = "FIC-00" + n_agtreg.                                                   
            END.                                                                                           
        END.
        ASSIGN rcode.amt    = rcode.amt + wprocess.wPrem.


        IF SUBSTRING(wprocess.wcedco,1,2) = "0D" OR SUBSTRING(wprocess.wcedco,1,2) = "0A"   THEN DO:
            wprocess.wLicense = "TIC-00" + n_agtreg.
        END.
        IF SUBSTRING(wprocess.wcedco,1,2) = "0F"  THEN DO:
            wprocess.wLicense = "FIC-00" + n_agtreg.
        END.

        FIND FIRST summar WHERE summar.sacccod  = wprocess.wacccod NO-ERROR NO-WAIT.
        IF NOT AVAIL summar THEN DO:
            CREATE summar.
            ASSIGN 
            summar.sacccod  = wprocess.wacccod
            summar.spolicy = "MISC" .
        
            CREATE summar.
            ASSIGN 
            summar.sacccod  = wprocess.wacccod
            summar.spolicy = "IAR" .
        
            CREATE summar.
            ASSIGN 
            summar.sacccod  = wprocess.wacccod
            summar.spolicy = "FIRE" .
        
            CREATE summar.
            ASSIGN 
            summar.sacccod  = wprocess.wacccod
            summar.spolicy = "ETC" .
           
        END.
        
        IF SUBSTRING(wprocess.wpolicy,3,2) = "04" OR
        SUBSTRING(wprocess.wpolicy,3,2) = "21" OR
        SUBSTRING(wprocess.wpolicy,3,2) = "22" OR
        SUBSTRING(wprocess.wpolicy,3,2) = "23" OR
        SUBSTRING(wprocess.wpolicy,3,2) = "24" OR
        SUBSTRING(wprocess.wpolicy,3,2) = "30" OR
        SUBSTRING(wprocess.wpolicy,3,2) = "37" OR
        SUBSTRING(wprocess.wpolicy,3,2) = "38" THEN DO:
    
           FIND LAST summar WHERE summar.sacccod = wprocess.wacccod AND
                                  summar.spolicy = "MISC" NO-ERROR NO-WAIT .
           IF AVAIL summar  THEN DO:
                 summar.smisc    =  summar.smisc + wprocess.wPrem.
           END.
    
        END.
        ELSE IF SUBSTRING(wprocess.wpolicy,3,2) = "11" OR
              SUBSTRING(wprocess.wpolicy,3,2) = "12" OR
              SUBSTRING(wprocess.wpolicy,3,2) = "15" OR
              SUBSTRING(wprocess.wpolicy,3,2) = "16" THEN DO: 
    
             FIND LAST summar WHERE summar.sacccod = wprocess.wacccod AND
                                    summar.spolicy = "IAR" NO-ERROR NO-WAIT .
              IF AVAIL summar  THEN DO:
                    summar.siar = summar.siar + wprocess.wPrem.
              END.
        END.
        ELSE IF SUBSTRING(wprocess.wpolicy,3,2) = "10" OR
                SUBSTRING(wprocess.wpolicy,3,2) = "18" THEN DO:
              FIND LAST summar WHERE summar.sacccod = wprocess.wacccod AND 
                                     summar.spolicy = "FIRE" NO-ERROR NO-WAIT .
               IF AVAIL summar  THEN DO:
                     summar.sfire = summar.sfire + wprocess.wPrem.
               END.
        END.
        ELSE DO: 
          FIND LAST summar WHERE  summar.sacccod = wprocess.wacccod AND
                                  summar.spolicy = "ETC" NO-ERROR NO-WAIT .
           IF AVAIL summar  THEN DO:
             
                 summar.setc  = summar.setc + wprocess.wPrem.
           END.
        END.

        FIND LAST rcode WHERE rcode.rcedco = wprocess.wcedco NO-LOCK NO-ERROR.
        IF AVAIL rcode THEN DO:
             n_ymdr = IF wprocess.wComdat = ? THEN "" ELSE STRING(wprocess.wComdat,"99/99/9999").
             n_mr = SUBSTRING(n_ymdr,4,2).
             n_yr = SUBSTRING(n_ymdr,7,4).
             n_dr = SUBSTRING(n_ymdr,1,2).
             rcode.rcomdat = n_yr + "-" + n_mr + "-" + n_dr.

        END.

        /*END Saowapa U A62-0448 03/10/2019*/

        


        EXPORT DELIMITER "|"
               IF wprocess.wtrndat = ? THEN "" ELSE STRING(wprocess.wtrndat,"99/99/9999")      /*1*/   
               wprocess.wpolicy                                                                /*2*/   
               wprocess.wEndno                                                                 /*3*/   
               IF wprocess.wComdat = ? THEN "" ELSE STRING(wprocess.wComdat,"99/99/9999")      /*4*/   
               TRIM(wprocess.wtrntyp1) + TRIM(wprocess.wtrntyp2)                               /*5*/   
               wprocess.wDocno FORMAT "X(10)"  /* Benjaporn J. A60-0267 date 27/06/2017 */     /*6*/   
               wprocess.wagent                                                                 /*7*/   
               wprocess.wInsure  FORMAT "X(60)"                                                /*8*/   
               wprocess.wPrem                                                                  /*9*/   
               wprocess.wdicc                                                                  /*10*/  
               wprocess.wnetprem                                                               /*11*/  
               wprocess.wTax                                                                   /*12*/  
               wprocess.wtax1                                                                  /*13*/  
               wprocess.wGross                                                                 /*14*/  
               wprocess.wcomm                                                                  /*15*/  
               wprocess.wnetamt                                                                /*16*/  
               wprocess.wbal                                                                   /*17*/  
               wprocess.wLicense    /*Saowapa U A62-0448 03/10/2019*/                          /*18*/  
               wprocess.wcedco                                                                 /*19*/  
               /*wprocess.wcedname*/ n_nameacno                                                /*20*/  
               wprocess.wthpol       /*A63-0415*/                                              /*21*/  
               wprocess.wacccod     /*Saowapa U. A62-0448 02/10/2562*/                         /*22*/  
               wprocess.wcampol                                                                /*23*/  
               /*wprocess.wagtreg*/  n_agtreg                                                  /*24*/  
               wprocess.wriappl                                                                /*25*/  
               wprocess.wacno                                                                  /*26*/  
               wprocess.wacname                                                                /*27*/  
               wprocess.wclityp                                                                /*28*/  
               wprocess.wsi.    /*A59-0103*/                                                   /*29*/  
                                                                                                

        IF LAST-OF(wprocess.wcedco) THEN DO:
           EXPORT DELIMITER "|"
                   wprocess.wcedco 
                   n_nameacno
                   ""
                   ""
                   ""
                   ""
                   ""
                   ""
                   n_wPrem 
                   n_wdicc 
                   n_wnetprem
                   n_wTax 
                   n_wtax1
                   n_wGross   
                   n_wcomm 
                   n_wnetamt  
                   n_wbal
                   "" "" "" "" "" "" "" "" "" "" 
                   "" /*A63-0415*/
                   n_wsi.   /*A59-0103*/
            EXPORT " " .

            ASSIGN
                n_wPrem       = 0
                n_wPrem_com   = 0
                n_wStamp      = 0   
                n_wTax        = 0  
                n_wTax1       = 0
                n_wGross      = 0   
                n_wcomm       = 0    
                n_wdicc       = 0    
                n_wctotal     = 0  
                n_wnetamt     = 0  
                n_wbal        = 0  
                n_wnetprem    = 0 
                n_wsi         = 0 .   /*A59-0103*/
                END.
END.



EXPORT DELIMITER "|"
       "All Total  : "
       ""  
       ""
       ""
       ""
       ""
       ""
       ""
       ns_wPrem 
       ns_wdicc
       ns_wnetprem
       ns_wTax 
       ns_wTax1
       ns_wGross   
       ns_wcomm 
       ns_wnetamt  
       ns_wbal
       "" "" "" "" "" "" "" "" "" ""
       "" /*A59-0103*/
       ns_wsi.     /*A59-0103*/

ASSIGN
    ns_wPrem      = 0    
    ns_wPrem_com  = 0
    ns_wStamp     = 0   
    ns_wTax       = 0  
    ns_wTax1      = 0
    ns_wGross     = 0   
    ns_wcomm      = 0    
    ns_wdicc      = 0    
    ns_wctotal    = 0  
    ns_wnetamt    = 0  
    ns_wbal       = 0
    ns_wnetprem   = 0
    ns_wsi        = 0.   /*A59-0103*/

RUN pdPrintPage3.    /*Saowapa U. A62-0448 24/10/2018*/

OUTPUT CLOSE.





END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrintPage2 WACR0091 
PROCEDURE pdPrintPage2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_cGross      LIKE cprocess.cGross  INIT 0.  
DEF VAR n_cPrem       LIKE cprocess.cPrem   INIT 0.  
DEF VAR n_cbal        LIKE cprocess.cbal    INIT 0.  
DEF VAR ns_cGross     LIKE cprocess.cGross  INIT 0.  
DEF VAR ns_cPrem      LIKE cprocess.cPrem   INIT 0.  
DEF VAR ns_cbal       LIKE cprocess.cbal    INIT 0.  
DEF VAR n_nameacno    AS CHAR INIT "".
DEF VAR n_agtreg      AS CHAR FORMAT "X(15)" INIT "".

ASSIGN
    n_cGross   = 0  ns_cGross  = 0 
    n_cPrem    = 0  ns_cPrem   = 0 
    n_cbal     = 0  ns_cbal    = 0 .    
      
OUTPUT TO VALUE(fioutput).

loop_exprocess2:
FOR EACH cprocess USE-INDEX cprocess02 NO-LOCK 
    WHERE cprocess.cProgid   =  nv_Progid 
      AND cprocess.cUserid   =  nv_Userid 
      AND cprocess.cEntdat   =  nv_Entdat 
      AND cprocess.cEntTime  =  nv_EntTime
    BREAK BY cprocess.crico
          BY cprocess.ctrndat
          BY cprocess.cclaim
          BY cprocess.cpolicy
          BY cprocess.cDocno .           

        IF cprocess.cbal  = 0 THEN NEXT loop_exprocess2.

        IF FIRST-OF(cprocess.crico) THEN DO: 

            n_nameacno = "".
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = cprocess.crico NO-LOCK NO-ERROR.
            IF AVAIL xmm600  THEN ASSIGN n_nameacno  =  TRIM(xmm600.ntitle + " " + xmm600.name)
                                         n_agtreg    = xmm600.agtreg.
 
            EXPORT "Reinsurer Code : " + cprocess.crico .   
            EXPORT "Reinsurer Name : " + n_nameacno .            
            EXPORT DELIMITER "|"
                   "Trans.date"                                  /*1*/    
                   "Claim No."                                   /*2*/    
                   "Policy"                                      /*3*/    
                   "Loss Date"                                   /*4*/    
                  /* "Entry Date"   /*A56-0267*/*/               /*5*/    
                   "Paid Date"    /*A56-0267*/                   /*6*/    
                   "Tran.type"                                   /*7*/    
                   "Doc.No."                                     /*8*/    
                 /*  "Agent"                */                   /*9*/    
                   "Insured Name"                                /*10*/   
                   "Payee Name"                                  /*11*/   
                   "Gross Claim Paid"                            /*12*/   
                   "Your Share"                                  /*13*/   
                   "Balance O/S"                                 /*14*/   
                   "Reinsurer"                                   /*15*/   
                   "Reinsurer Name"                              /*16*/
                   "Licence"                                     /*17*/ 
                   "Outward Producer"                            /*18*/   
                   "Outward Producer Name"                       /*19*/   
                   "Producer"                                    /*20*/   
                   "Producer Name"                               /*21*/   
                   "Producer Type".                              /*22*/   
                                             
                                                              
        END.                                                    
                                                                
        ASSIGN                                                  
            n_cGross   = n_cGross  + cprocess.cGross            
            n_cPrem    = n_cPrem   + cprocess.cPrem             
            n_cbal     = n_cbal    + cprocess.cbal              
            ns_cGross  = ns_cGross + cprocess.cGross 
            ns_cPrem   = ns_cPrem  + cprocess.cPrem  
            ns_cbal    = ns_cbal   + cprocess.cbal   .

        EXPORT DELIMITER "|"                                                                                                      
               IF cprocess.ctrndat = ? THEN "" ELSE STRING(cprocess.ctrndat, "99/99/9999")                /*1*/                   
               cprocess.cclaim                                                                            /*2*/                   
               cprocess.cpolicy                                                                           /*3*/                   
               IF cprocess.clossdat  = ? THEN "" ELSE STRING(cprocess.clossdat, "99/99/9999")             /*4*/                   
             /*  IF cprocess.centrydat  = ? THEN "" ELSE STRING(cprocess.centrydat, "99/99/9999")*/       /*5*/                   
               IF cprocess.cpaddat  = ? THEN "" ELSE STRING(cprocess.cpaddat, "99/99/9999")               /*6*/                   
               TRIM(cprocess.ctrntyp1) + TRIM(cprocess.ctrntyp2)                                          /*7*/                   
               cprocess.cDocno   FORMAT "X(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */               /*8*/                   
               /*cprocess.cagent     */                                                                   /*9*/                   
               cprocess.cInsure  FORMAT "X(60)"                                                           /*10*/                  
               cprocess.cpayname FORMAT "X(60)"                                                           /*11*/                  
               cprocess.cGross                                                                            /*12*/                  
               cprocess.cPrem                                                                             /*13*/                  
               cprocess.cbal                                                                              /*14*/                  
               cprocess.crico                                                                             /*15*/                  
               n_nameacno /*cprocess.ccedname*/                                                           /*16*/    
               n_agtreg   /*cprocess.cagtreg*/                                                            /*17*/  
               cprocess.cacno                                                                             /*18*/                  
               cprocess.cacname                                                                           /*19*/                  
               cprocess.cacno                                                                             /*20*/                  
               cprocess.cacname                                                                           /*21*/                  
               cprocess.cclityp.                                                                          /*22*/                  
            
                                                                                                           
                                                                                                                                  
        IF LAST-OF(cprocess.crico) THEN DO:
            EXPORT DELIMITER "|"
                   cprocess.crico 
                   n_nameacno
                   ""
                   ""
                   /*""  /*A56-0267*/*/
                   ""  /*A56-0267*/
                   ""
                   /*""*/
                   ""
                   ""
                   ""
                   n_cGross
                   n_cPrem 
                   n_cbal  .
            EXPORT " " .

            ASSIGN
                n_cGross   = 0
                n_cPrem    = 0
                n_cbal     = 0 .
        END.
END.

EXPORT DELIMITER "|"
       "All Total  : "
       ""  
       ""
       ""
       /*""    /*A56-0267*/*/
       ""    /*A56-0267*/
       ""
       /*""*/
       ""
       ""
       ""
       ns_cGross
       ns_cPrem 
       ns_cbal.

ASSIGN
    ns_cGross  = 0    
    ns_cPrem   = 0
    ns_cbal    = 0 .  

OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdPrintPage3 WACR0091 
PROCEDURE pdPrintPage3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR tfire AS DEC.
DEF VAR tiar AS DEC.
DEF VAR tetc AS DEC.
DEF VAR tmisc AS DEC.
DEF VAR totalt AS DEC.


OUTPUT TO VALUE(fioutput + "Summary").
EXPORT DELIMITER "|"
    "Reinsurer Code"        
    "Reinsurer related"     
    "Comm date"             
    "Reinsurer Client Type" 
    "Reinsurer Code"        
    "Reinsurer Name"        
    "Total"                 
    "Contract Type". 


FOR EACH rcode WHERE rcode.racccod = "RD" OR 
                     rcode.racccod = "RA" OR 
                     rcode.racccod = "RB" OR   /*A64-0410*/
                     rcode.racccod = "RF" NO-LOCK. 
  
    EXPORT DELIMITER "|"
    rcode.rLicense
    ""
    rcode.rcomdat
    rcode.racccod
    rcode.rcedco
    rcode.rname
    rcode.amt
    "FRM0003".
           

END.

EXPORT DELIMITER "|"
    "".
EXPORT DELIMITER "|"
    "".
EXPORT DELIMITER "|"
    "Summary ALL Reinsurer A/C Type".

tfire  = 0.
tiar   = 0.
tetc   = 0.
tmisc  = 0.

FOR EACH summar WHERE summar.sacccod = "RD" OR 
                      summar.sacccod = "RA" OR 
                      summar.sacccod = "RB" OR   /*A64-0410*/
                      summar.sacccod = "RF" NO-LOCK.

  
    IF summar.sfire <> 0  THEN DO:
        EXPORT DELIMITER "|"
            summar.sacccod
            summar.spolicy 
            summar.sfire.
        tfire = tfire + summar.sfire.
    END.

    ELSE IF summar.siar <> 0  THEN DO:
        EXPORT DELIMITER "|" 
            summar.sacccod
            summar.spolicy
            summar.siar.
        tiar = tiar + summar.siar.
    END.
    ELSE IF summar.smisc <> 0  THEN DO:
        EXPORT DELIMITER "|" 
            summar.sacccod
            summar.spolicy
            summar.smisc.
        tmisc = tmisc + summar.smisc.
    END.

    ELSE IF summar.setc <> 0  THEN DO:
        EXPORT DELIMITER "|" 
            summar.sacccod
            summar.spolicy
            summar.setc.
        tetc = tetc + summar.setc.
    END.
    ELSE DO :  
        EXPORT DELIMITER "|"
            summar.sacccod
            summar.spolicy
            "-".
    END.
  


    
           
END.
totalt =  tfire + tiar + tetc + tmisc.
EXPORT DELIMITER "|"
            "TOTAL"
            ""
            totalt.

EXPORT DELIMITER "|"
            ""
            "".
EXPORT DELIMITER "|"
            ""
            "".

EXPORT DELIMITER "|" 
            "หมายเหตุ"
            "MISC"
            "Line (4,21,22,23,24,30,37,38)".
EXPORT DELIMITER "|"
    ""
            "FIRE"
            "Line (10,18)".
EXPORT DELIMITER "|"
    ""
            "IAR"
            "Line (11,12,15,16)".
EXPORT DELIMITER "|"
            ""
            "ETC"
            "Line (14,19,20,32,33,35,36,39,31,90,92,93,80-86,61,65,66,91,40,41,43,44-48,70,72,73,74,60,62,63,64,67,68,69)".
            

OUTPUT CLOSE.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_Claim WACR0091 
PROCEDURE pdProcess_Claim :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_sub      AS LOGICAL INIT NO.
DEF VAR n_risk     AS INTEGER FORMAT "999"  INIT 0.
DEF VAR nv_req     AS CHAR.
DEF VAR nv_reqno   AS CHAR.
DEF VAR nv_totcl   AS DECI FORMAT "->>>,>>>,>>9.99".
DEF VAR n_agent    AS CHAR FORMAT "X(10)".
DEF VAR n_poltyp   AS CHAR INIT "".

ASSIGN
  nv_Progid  = "WACR0091"
  nv_Userid  = n_User
  nv_Entdat  = TODAY
  nv_EntTime = STRING(TIME,"HH:MM:SS").

/*== Begin Check Type ==*/
IF n_type = "MOTOR" THEN DO: /*MOTOR*/
    FOR EACH xmm031 WHERE xmm031.dept = "M" OR
                          xmm031.dept = "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE IF n_type = "NON-MOTOR" THEN DO:  /*NON-MOTOR*/ 
    FOR EACH xmm031 WHERE xmm031.dept <> "M" AND
                          xmm031.dept <> "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK: /*ALL*/
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
/*== End Check Type ==*/


/*---- F67-0002 Nattanicha K. 05/02/2025 -----
loop_acm001:
FOR EACH acm001 USE-INDEX acm00103 NO-LOCK
        WHERE  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac 
          AND  acm001.curcod   =  "BHT"
          AND  acm001.trndat  >=  n_frdate 
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0                    
          AND  acm001.branch  >=  n_branch
          AND  acm001.branch  <=  n_branch2          
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) 
    :
    -----------------------*/
/*--- F67-0002 Nattanicha K. 05/02/2025 -----*/
loop_acm001:
FOR EACH acm001 USE-INDEX acm00191  NO-LOCK
        WHERE  acm001.trndat  >=  n_frdate  
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0
          AND  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac
          AND  acm001.branch  >=  n_branch   
          AND  acm001.branch  <=  n_branch2 
          AND  acm001.curcod   =  "BHT"
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) 
    :
/*-----------end F67-0002 Nattanicha K. 05/02/2025 -----*/

    IF INDEX(n_poltyp,SUBSTRING(acm001.poltyp,2,2)) = 0 THEN NEXT loop_acm001.

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT loop_acm001.

    DISP  "PROCESS : " + STRING(acm001.trndat,"99/99/9999")   + "  " + acm001.acno  + "  " + acm001.recno + "  " +
                         acm001.trnty1 + "  " + acm001.trnty2 + "  " + acm001.docno FORMAT "x(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */  @ fiDisplay  
    WITH FRAME  frDisplay.

    ASSIGN       
        n_insur   =  ""    nv_policy   = ""       
        n_losdat  =  ?     nv_rencnt   = 0    
        n_bal     =  0     nv_endcnt   = 0    
        n_settle  =  0     n_risk      = 0
        nv_totcl  =  0     nv_req      = ""
        nv_reqno  =  ""    nv_payee    = ""
        n_agent   =  ""    
        n_campol   = ""
        n_clityp  = ""      n_cedname  = ""
        n_agtreg  = ""      n_riappl   = "".

    /* check company is reinsurance only */
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
    ELSE ASSIGN n_xmm600  =  TRIM(xmm600.ntitle + " " + xmm600.name)
                n_clityp = xmm600.clicod
                n_agtreg = xmm600.agtreg
                n_cedname =  TRIM(xmm600.ntitle + " " + xmm600.name).

    /* clm100 : claim */
    FIND FIRST clm100  USE-INDEX  clm10001  WHERE
               clm100.claim = acm001.recno NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm100 THEN DO:
        ASSIGN
          n_losdat    = clm100.losdat
          n_insur     = TRIM(clm100.name1) + " " + TRIM(clm100.name2) 
          nv_policy   = clm100.policy
          nv_rencnt   = clm100.rencnt 
          nv_endcnt   = clm100.endcnt
          n_risk      = clm100.riskno
          n_agent     = clm100.agent.                       
    END.
    ELSE DO:
        ASSIGN
          n_losdat    = ?
          n_insur     = TRIM(acm001.ref)
          nv_policy   = acm001.policy
          nv_rencnt   = acm001.rencnt 
          nv_endcnt   = acm001.endcnt
          n_risk      = 0
          n_agent     = acm001.agent.                       
    END.

    /* หา total claim */
    nv_req = TRIM(acm001.TRNTY1) + "-" + TRIM(acm001.DOCNO).  

    FIND FIRST country_fil  WHERE 
               country_fil.ctydes  = nv_req  NO-LOCK NO-ERROR . /* หา Req-no */ 
    IF AVAIL country_fil THEN 
         nv_reqno = country_fil.cntry.
    ELSE nv_reqno = "".

    FIND FIRST clm130   USE-INDEX clm13001           WHERE
               clm130.TRNTY1 =  SUBSTR(nv_reqno,1,1) AND 
               clm130.docno  =  SUBSTR(nv_reqno,3,10) AND
               clm130.claim  =  acm001.recno                AND
               clm130.Releas =  YES                  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm130 THEN DO:

       nv_totcl    = clm130.netl_d.
       n_paddat    = clm130.trndat.   /*A56-0267*/
       n_entrydat  = clm130.entdat.   /*A56-0267*/
       
       FIND clm200 USE-INDEX clm20001      WHERE
            clm200.trnty1 = clm130.trnty1  AND
            clm200.docno  = clm130.docno   NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL clm200 THEN nv_payee = clm200.name.

    END.  /*== End clm130 ==*/
        
    /* Balance */
    IF acm001.latdat > n_asdat THEN DO:
        FOR EACH acd001 USE-INDEX acd00191
            WHERE acd001.trnty1 = acm001.trnty1
            AND   acd001.docno  = acm001.docno
            AND   acd001.cjodat <= n_asdat NO-LOCK.
            n_settle = n_settle + acd001.netamt.
        END.
        n_bal = acm001.netamt + n_settle.
    END.
    ELSE n_bal = acm001.bal.

    RUN pdRIAppl.

     /*========== Begin Outward Broker ==========*/
     n_sub = NO.

     loop_riroprm:
     FOR EACH riroprm NO-LOCK USE-INDEX riroprm01 
        WHERE riroprm.policy = nv_policy
          AND riroprm.rencnt = nv_rencnt
          AND riroprm.endcnt = nv_endcnt
          AND riroprm.csftq  = "F"
          AND riroprm.rico   = acm001.acno
          AND riroprm.riskno = n_risk.

             /* A59-0109---keep Reinsurer name */  
         FIND xmm600 USE-INDEX xmm60001 WHERE
              xmm600.acno = nv_company NO-LOCK NO-ERROR.
         IF AVAIL xmm600  THEN 
            ASSIGN n_cedname =  TRIM(xmm600.ntitle + " " + xmm600.name)
                   n_agtreg  = xmm600.agtreg.

          CREATE cprocess.
          ASSIGN cprocess.casdat     =  n_asdat      
                 cprocess.cdept      =  acm001.dept  
                 cprocess.ctrndat    =  acm001.trndat
                 cprocess.cclaim     =  acm001.recno 
                 cprocess.cpolicy    =  acm001.policy
                 cprocess.clossdat   =  n_losdat 
                 cprocess.cpaddat    =  n_paddat   /*A56-0267*/
                 cprocess.centrydat  =  n_entrydat /*A56-0267*/
                 cprocess.ctrntyp1   =  TRIM(acm001.trnty1) 
                 cprocess.ctrntyp2   =  TRIM(acm001.trnty2) 
                 cprocess.cDocno     =  acm001.docno        
                 cprocess.cagent     =  n_agent
                 cprocess.cInsure    =  n_insur
                 cprocess.cpayname   =  nv_payee
                 cprocess.cGross     =  (nv_totcl * riroprm.cedper) / 100
                 cprocess.cPrem      =  (acm001.netamt * riroprm.cedper) / 100
                 cprocess.cbal       =  (n_bal * riroprm.cedper) / 100  
                 cprocess.cacno      =  acm001.acno
                 cprocess.cacname    =  n_xmm600
                 cprocess.cagtreg    =  n_agtreg
                 cprocess.crico      =  riroprm.ttyfac /* SUB CODE */  
                 cprocess.ccedname   =  n_cedname
                 cprocess.cclityp    =  n_clityp
                 cprocess.cProgid    =  nv_Progid   
                 cprocess.cUserid    =  nv_Userid   
                 cprocess.cEntdat    =  nv_Entdat   
                 cprocess.cEntTime   =  nv_EntTime .

          n_sub  = YES.
     END.
     /*========== End Inward Broker ==========*/

     IF n_sub = YES THEN NEXT loop_acm001.
     ELSE DO:
        CREATE cprocess.
        ASSIGN cprocess.casdat     =  n_asdat      
               cprocess.cdept      =  acm001.dept  
               cprocess.ctrndat    =  acm001.trndat
               cprocess.cclaim     =  acm001.recno 
               cprocess.cpolicy    =  acm001.policy
               cprocess.clossdat   =  n_losdat
               cprocess.cpaddat    =  n_paddat   /*A56-0267*/
               cprocess.centrydat  =  n_entrydat /*A56-0267*/
               cprocess.ctrntyp1   =  TRIM(acm001.trnty1) 
               cprocess.ctrntyp2   =  TRIM(acm001.trnty2) 
               cprocess.cDocno     =  acm001.docno        
               cprocess.cagent     =  n_agent
               cprocess.cInsure    =  n_insur
               cprocess.cpayname   =  nv_payee
               cprocess.cGross     =  nv_totcl
               cprocess.cPrem      =  acm001.netamt
               cprocess.cbal       =  n_bal  
               cprocess.cacno      =  acm001.acno
               cprocess.cacname    =  n_xmm600
               cprocess.cagtreg    =  n_agtreg
               cprocess.ccedname    =  n_cedname
               cprocess.cclityp    =  n_clityp
               cprocess.crico      =  acm001.acno 
               cprocess.cProgid    =  nv_Progid   
               cprocess.cUserid    =  nv_Userid   
               cprocess.cEntdat    =  nv_Entdat   
               cprocess.cEntTime   =  nv_EntTime .
     END.

     n_sub = NO.
END.  /*acm001*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_Inward WACR0091 
PROCEDURE pdProcess_Inward :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_sub      AS LOGICAL INIT NO.
DEF VAR n_poltyp   AS CHAR INIT "".

ASSIGN
  nv_Progid  = "WACR0091"
  nv_Userid  = n_User
  nv_Entdat  = TODAY
  nv_EntTime = STRING(TIME,"HH:MM:SS").

/*== Begin Check Type ==*/
IF n_type = "MOTOR" THEN DO: /*MOTOR*/
    FOR EACH xmm031 WHERE xmm031.dept = "M" OR
                          xmm031.dept = "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE IF n_type = "NON-MOTOR" THEN DO:  /*NON-MOTOR*/ 
    FOR EACH xmm031 WHERE xmm031.dept <> "M" AND
                          xmm031.dept <> "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK: /*ALL*/
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
/*== End Check Type ==*/

/*-------------------F67-0002 Nattanicha K. 05/02/2025 -----
loop_acm001:
FOR EACH acm001 USE-INDEX acm00103 NO-LOCK
        WHERE  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac 
          AND  acm001.curcod   =  "BHT"
          AND  acm001.trndat  >=  n_frdate 
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0                    
          AND  acm001.branch  >=  n_branch
          AND  acm001.branch  <=  n_branch2          
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) 
    :
  ------------------*/
/*------ F67-0002 Nattanicha K. 05/02/2025 ----- */
loop_acm001:
FOR EACH acm001 USE-INDEX acm00191  NO-LOCK
        WHERE  acm001.trndat  >=  n_frdate  
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0
          AND  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac
          AND  acm001.branch  >=  n_branch   
          AND  acm001.branch  <=  n_branch2 
          AND  acm001.curcod   =  "BHT"
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) 
    :
/*---- end F67-0002 Nattanicha K. 05/02/2025 -----------*/

    IF INDEX(n_poltyp,SUBSTRING(acm001.poltyp,2,2)) = 0 THEN NEXT loop_acm001.

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT loop_acm001.

    DISP  "PROCESS : " + STRING(acm001.trndat,"99/99/9999")   + "  " + acm001.cedco  + "  " + acm001.policy + "  " +
                         acm001.trnty1 + "  " + acm001.trnty2 + "  " + acm001.docno FORMAT "x(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */ @ fiDisplay  
    WITH FRAME  frDisplay.

    ASSIGN       
        n_insur   =  ""     nv_policy  = ""  
        n_comdat  =  ?      nv_rencnt  = 0
        n_prem    =  0      nv_endcnt  = 0
        n_comp    =  0      nv_company = ""
        n_bal     =  0      n_xmm600   = ""
        n_settle  =  0      n_campol   = ""
        n_clityp  = ""      n_cedname  = ""
        n_agtreg  = ""      n_riappl   = "".
        

    /* check company is reinsurance only */
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
     

    /* check company is reinsurance only 
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.cedco NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001. */

    /* uwm100: trnty1 & docno & policy */
    FIND FIRST uwm100 USE-INDEX uwm10090 
         WHERE uwm100.trty11 = acm001.trnty1
          AND  uwm100.docno1 = acm001.docno 
          AND  uwm100.policy = acm001.policy NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN RUN pd_uwm100.       
    ELSE DO:
        /* uwm100: policy & recno(endno) */
        FIND FIRST uwm100 WHERE
                   uwm100.policy = acm001.policy AND
                   uwm100.endno  = acm001.recno  NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN RUN pd_uwm100  .
        ELSE
            ASSIGN
                n_insur    = acm001.ref
                n_comdat   = acm001.comdat
                n_prem     = acm001.prem
                n_comp     = 0 
                nv_policy  = acm001.policy
                nv_rencnt  = acm001.rencnt 
                nv_endcnt  = acm001.endcnt
                nv_company = acm001.acno.
    END.

    RUN pdRIAppl.

   /* keep Account name */  
    FIND xmm600 USE-INDEX xmm60001 WHERE
         xmm600.acno = nv_company NO-LOCK NO-ERROR.
    IF AVAIL xmm600  THEN 
       ASSIGN n_xmm600 =  TRIM(xmm600.ntitle + " " + xmm600.name)
              n_clityp = xmm600.clicod. 


              

    IF (acm001.trnty1 = "Y" OR acm001.trnty1 = "Z") THEN
        ASSIGN
            n_prem = 0
            n_comp = 0.
    
    /* Balance */ 
    IF acm001.latdat > n_asdat THEN DO:
        FOR EACH acd001 USE-INDEX acd00191
            WHERE acd001.trnty1 = acm001.trnty1
            AND   acd001.docno  = acm001.docno
            AND   acd001.cjodat <= n_asdat NO-LOCK.
            n_settle = n_settle + acd001.netamt.
        END.
        n_bal = acm001.netamt + n_settle.
    END.
    ELSE n_bal = acm001.bal.

 

    /* Begin Inward Broker */
    ASSIGN n_sub = NO
           nv_si = 0.    /*A59-0103*/

    /*---A59-0103---*/
    FOR EACH uwm120 USE-INDEX uwm12001 WHERE
             uwm120.policy = acm001.policy AND uwm120.rencnt  = acm001.rencnt AND
             uwm120.endcnt = acm001.endcnt AND uwm120.riskgp >= 0  NO-LOCK.

        nv_si = 0.    /*-----A64-0093----*/
    
        FOR EACH uwm130 USE-INDEX uwm13001 WHERE uwm130.policy = uwm120.policy AND
                 uwm130.rencnt  = uwm120.rencnt AND uwm130.endcnt  = uwm120.endcnt    AND
                 uwm130.riskgp >= uwm120.riskgp NO-LOCK.
            
            ASSIGN nv_si = nv_si + uwm130.uom1_v.
            /*DISP uwm130.uom1_c   uwm130.uom1_v.  */
        END.                                     
    END.
    /*---end A59-0103---*/

    loop_riroprm:
    FOR EACH riroprm NO-LOCK USE-INDEX riroprm01 
       WHERE riroprm.policy = nv_policy
         AND riroprm.rencnt = nv_rencnt
         AND riroprm.endcnt = nv_endcnt
         AND riroprm.csftq  = "I"
         AND riroprm.rico   = nv_company.

              /* A59-0109---keep Reinsurer name */  
         FIND xmm600 USE-INDEX xmm60001 WHERE
              xmm600.acno = nv_company NO-LOCK NO-ERROR.
         IF AVAIL xmm600  THEN 
            ASSIGN n_cedname =  TRIM(xmm600.ntitle + " " + xmm600.name)
                   n_agtreg  = xmm600.agtreg.
        
        RUN pdRIAppl.  

        CREATE wprocess.
        ASSIGN wprocess.wasdat      =  n_asdat
               wprocess.wdept       =  acm001.dept
               wprocess.wtrndat     =  acm001.trndat
               wprocess.wpolicy     =  acm001.policy
               wprocess.wEndno      =  acm001.recno
               wprocess.wComdat     =  n_comdat
               wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
               wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
               wprocess.wDocno      =  acm001.docno
               wprocess.wagent      =  acm001.agent
               wprocess.wInsure     =  n_insur
               wprocess.wPrem       =  ((n_prem) * riroprm.cedper) / 100
               wprocess.wPrem_Comp  =  ((n_comp) * riroprm.cedper) / 100
               wprocess.wStamp      =  ((acm001.stamp) * riroprm.cedper) / 100
               wprocess.wTax        =  ((acm001.tax) * riroprm.cedper) / 100
               wprocess.wTax1       =  ((wprocess.wPrem * 0.01) * (-1))
               wprocess.wcomm       =  ((acm001.comm) * riroprm.cedper) / 100
               wprocess.wdicc       =  ((acm001.fee) * riroprm.cedper) / 100
               wprocess.wnetprem    =  wprocess.wprem + wprocess.wdicc
               wprocess.wGross      =  wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1
               wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
               wprocess.wnetamt     =  ((acm001.netamt) * riroprm.cedper) / 100 
               wprocess.wbal        =  ((n_bal) * riroprm.cedper) / 100
               wprocess.wacno       =  nv_company
               wprocess.wacname     =  n_xmm600
               wprocess.wcedco      =  riroprm.ttyfac /* SUB CODE */
               wprocess.wcedname    =  n_cedname
               wprocess.wagtreg     =  n_agtreg
               wprocess.wriappl     =  n_appno
               wprocess.wProgid     =  nv_Progid
               wprocess.wUserid     =  nv_Userid
               wprocess.wEntdat     =  nv_Entdat
               wprocess.wEntTime    =  nv_EntTime 
               wprocess.wcampol     =  n_campol
               wprocess.wclityp     =  n_clityp
               wprocess.wsi         =  nv_si.   /*A59-0103*/
            
        n_sub = YES.
    END.
    /* End Inward Broker */

    IF n_sub = YES THEN NEXT loop_acm001.
    ELSE DO:
        
        CREATE wprocess.
        ASSIGN wprocess.wasdat      =  n_asdat
               wprocess.wdept       =  acm001.dept
               wprocess.wtrndat     =  acm001.trndat
               wprocess.wpolicy     =  acm001.policy
               wprocess.wEndno      =  acm001.recno
               wprocess.wComdat     =  n_comdat
               wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
               wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
               wprocess.wDocno      =  acm001.docno
               wprocess.wagent      =  acm001.agent
               wprocess.wInsure     =  n_insur
               wprocess.wPrem       =  n_prem
               wprocess.wPrem_Comp  =  n_comp
               wprocess.wStamp      =  acm001.stamp
               wprocess.wTax        =  acm001.tax
               wprocess.wTax1       =  ((wprocess.wPrem * 0.01) * (-1))
               wprocess.wcomm       =  acm001.comm
               wprocess.wdicc       =  acm001.fee
               wprocess.wnetprem    =  wprocess.wprem + wprocess.wdicc
               wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
               wprocess.wGross      =  wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1
               wprocess.wnetamt     =  acm001.netamt 
               wprocess.wbal        =  n_bal
               wprocess.wacno       =  nv_company 
               wprocess.wacname     =  n_xmm600
               wprocess.wcedco      =  acm001.cedco
               wprocess.wcedname    =  n_cedname
               wprocess.wProgid     =  nv_Progid
               wprocess.wUserid     =  nv_Userid
               wprocess.wEntdat     =  nv_Entdat
               wprocess.wEntTime    =  nv_EntTime 
               wprocess.wcampol     =  n_campol
               wprocess.wclityp     =  n_clityp
               wprocess.wagtreg     =  n_agtreg
               wprocess.wriappl     =  n_appno
               wprocess.wsi         =  nv_si.   /*A59-0103*/
             
        
    END.

    n_sub = NO.

END.  /*acm001*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_Outward WACR0091 
PROCEDURE pdProcess_Outward :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_sub       AS LOGICAL INIT NO.
DEF VAR n_per       AS DECIMAL FORMAT ">>9.999999" INIT 0.000000.
DEF VAR n_poltyp    AS CHAR INIT "".
DEF VAR n_premri    LIKE uwd200.ripr.
DEF VAR n_comri1    LIKE uwd200.ric1.
DEF VAR n_comri2    LIKE uwd200.ric2.
DEF VAR n_prem_p    LIKE uwd200.risi_p.
DEF VAR n_com1_p    LIKE uwd200.risi_p.
DEF VAR n_com2_p    LIKE uwd200.risi_p.

ASSIGN
  nv_Progid  = "WACR0091"
  nv_Userid  = n_User
  nv_Entdat  = TODAY
  nv_EntTime = STRING(TIME,"HH:MM:SS").

/*== Begin Check Type ==*/
IF n_type = "MOTOR" THEN DO: /*MOTOR*/
    FOR EACH xmm031 WHERE xmm031.dept = "M" OR
                          xmm031.dept = "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE IF n_type = "NON-MOTOR" THEN DO:  /*NON-MOTOR*/ 
    FOR EACH xmm031 WHERE xmm031.dept <> "M" AND
                          xmm031.dept <> "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK: /*ALL*/
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
/*== End Check Type ==*/


/*-------------------- F67-0002-----
loop_acm001:
FOR EACH acm001 USE-INDEX acm00103 NO-LOCK
        WHERE  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac 
          AND  acm001.curcod   =  "BHT"
          AND  acm001.trndat  >=  n_frdate 
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0                    
          AND  acm001.branch  >=  n_branch
          AND  acm001.branch  <=  n_branch2          
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) :
          ---------end F67-0002-------------------*/

/*-----F67-0002 Nattanicha K. 05/02/2025 -----*/
loop_acm001:
FOR EACH acm001 USE-INDEX acm00191  NO-LOCK
        WHERE  acm001.trndat  >=  n_frdate  
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0
          AND  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac
          AND  acm001.branch  >=  n_branch   
          AND  acm001.branch  <=  n_branch2 
          AND  acm001.curcod   =  "BHT"
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) 
    :
/*--------end F67-0002-------------------------*/

    IF INDEX(n_poltyp,SUBSTRING(acm001.poltyp,2,2)) = 0 THEN NEXT loop_acm001.

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT loop_acm001.

    DISP  "PROCESS : " + STRING(acm001.trndat,"99/99/9999")   + "  " + acm001.acno  + "  " + acm001.policy + "  " +
                         acm001.trnty1 + "  " + acm001.trnty2 + "  " + acm001.docno FORMAT "x(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */ @ fiDisplay  
    WITH FRAME  frDisplay.

    ASSIGN       
        n_insur   = ""    nv_policy  = ""       
        n_comdat  = ?     nv_rencnt  = 0    
        n_prem    = 0     nv_endcnt  = 0    
        n_comp    = 0     n_bal      = 0     
        n_xmm600  = ""
        n_settle  = 0     n_campol   = ""
        n_clityp  = ""    n_cedname  = ""
        n_agtreg  = ""    n_riappl   = "".
       

    /* check company is reinsurance only */
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
    ELSE ASSIGN n_xmm600  =  TRIM(xmm600.ntitle + " " + xmm600.name)
                n_clityp = xmm600.clicod
                n_agtreg = xmm600.agtreg.

    /* A59-0109---keep Reinsurer name */  
    FIND xmm600 USE-INDEX xmm60001 WHERE
         xmm600.acno = acm001.cedno NO-LOCK NO-ERROR.
    IF AVAIL xmm600  THEN ASSIGN n_cedname =  TRIM(xmm600.ntitle + " " + xmm600.name).

    /* uwm100: policy & recno(endno) */
    FIND FIRST uwm100 WHERE
               uwm100.policy = acm001.policy AND
               uwm100.endno  = acm001.recno  NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO: 

        RUN pd_uwm100.  
        
    END.
    ELSE
        ASSIGN
            n_comdat   = acm001.comdat
            n_insur    = acm001.ref            
            n_prem     = acm001.prem
            nv_policy  = acm001.policy
            nv_rencnt  = acm001.rencnt 
            nv_endcnt  = acm001.endcnt
            n_comp     = 0 
            nv_company = acm001.acno.
    
    IF (acm001.trnty1 = "Y" OR acm001.trnty1 = "Z") THEN
        ASSIGN n_prem = 0
               n_comp = 0.
    
    /* Balance */
    IF acm001.latdat > n_asdat THEN DO:
        FOR EACH acd001 USE-INDEX acd00191
            WHERE acd001.trnty1 = acm001.trnty1
            AND   acd001.docno  = acm001.docno
            AND   acd001.cjodat <= n_asdat NO-LOCK.
            n_settle = n_settle + acd001.netamt.
        END.
        n_bal = acm001.netamt + n_settle.
    END.
    ELSE n_bal = acm001.bal.

     /*========== Begin Outward Broker ==========*/
     ASSIGN
       n_sub       = NO
       n_per       = 0.000000
       n_premri    = 0
       n_comri1    = 0
       n_comri2    = 0
       n_prem_p    = 0
       n_com1_p    = 0
       n_com2_p    = 0
       nv_si       = 0.    /*A59-0103*/
         
     RUN pdRIAppl.
     

     /*---------F68-0002----
     /*---A59-0103---*/
     FOR EACH uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = acm001.policy AND uwm120.rencnt  = acm001.rencnt AND
              uwm120.endcnt = acm001.endcnt AND uwm120.riskgp >= 0  NO-LOCK.

         nv_si = 0.   /*---A64-0093----*/
     
         FOR EACH uwm130 USE-INDEX uwm13001 WHERE uwm130.policy = uwm120.policy AND
                  uwm130.rencnt  = uwm120.rencnt AND uwm130.endcnt  = uwm120.endcnt    AND
                  uwm130.riskgp >= uwm120.riskgp NO-LOCK.
             
             ASSIGN nv_si = nv_si + uwm130.uom1_v.
             /*DISP uwm130.uom1_c   uwm130.uom1_v.  */
         END.          

     END.
     
     /*---end A59-0103---*/
     -----------end F68-0002---------*/
     /*--F68-0002---*/

IF   uwm100.poltyp   = "M60" OR 
     uwm100.poltyp   = "M62" OR  uwm100.poltyp = "M63" OR
     uwm100.poltyp   = "M64" OR  uwm100.poltyp = "M67" THEN  DO:

    FOR EACH uwm307 USE-INDEX uwm30701 WHERE uwm307.policy = nv_policy AND 
                                             uwm307.rencnt = nv_rencnt AND 
                                             uwm307.endcnt = nv_endcnt NO-LOCK .
        nv_si  = nv_si  + uwm307.mbsi[1].
    END.

END.
ELSE DO:
  FOR EACH uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = nv_policy AND 
                                           uwm120.rencnt = nv_rencnt AND 
                                           uwm120.endcnt = nv_endcnt NO-LOCK .

     IF AVAIL uwm120 THEN DO:
        nv_si  = nv_si + (uwm120.sigr - uwm120.sico).
     END.

  END.
END.
     /*----end F68-0002---------*/
loop_riroprm:
FOR EACH riroprm NO-LOCK USE-INDEX riroprm01 
WHERE riroprm.policy = nv_policy
  AND riroprm.rencnt = nv_rencnt
  AND riroprm.endcnt = nv_endcnt      /* Break By */  
  AND riroprm.csftq  = "F"            /* Rico 0DAAA , Risk 001 , Ttyfac 0A...1 */  
  AND riroprm.rico   = acm001.acno    /* Rico 0DAAA , Risk 001 , Ttyfac 0B...2 */  
BREAK BY riroprm.rico                    /* Rico 0DAAA , Risk 002 , Ttyfac 0A...1 */ 
   BY riroprm.riskno                  /* Rico 0DAAA , Risk 002 , Ttyfac 0B...2 */  
   BY riroprm.ttyfac.   

         IF FIRST-OF(riroprm.rico) THEN DO:
             ASSIGN n_premri    = 0
                    n_comri1    = 0
                    n_comri2    = 0.

             /* A59-0109---keep Reinsurer name */  
             FIND xmm600 USE-INDEX xmm60001 WHERE
                  xmm600.acno = nv_company NO-LOCK NO-ERROR.
             IF AVAIL xmm600  THEN 
                ASSIGN n_cedname =  TRIM(xmm600.ntitle + " " + xmm600.name)
                       n_agtreg  = xmm600.agtreg.
             /*--Fai--*/

             loop_uwd200:
             FOR EACH   uwd200 USE-INDEX uwd20001 WHERE
                        uwd200.policy = nv_policy      
                    AND uwd200.rencnt = nv_rencnt      
                    AND uwd200.endcnt = nv_endcnt      
                    AND uwd200.csftq  = "F"            
                    AND uwd200.rico   = acm001.acno   NO-LOCK .
                 ASSIGN /*ข้อ 1 : หาเบี้ยทั้งหมดของแต่ละบริษัท*/
                    n_premri = n_premri + (IF uwd200.ripr < 0 THEN uwd200.ripr * -1 ELSE uwd200.ripr)
                    n_comri1 = n_comri1 + (IF uwd200.ric1 < 0 THEN uwd200.ric1 * -1 ELSE uwd200.ric1)
                    n_comri2 = n_comri2 + (IF uwd200.ric2 < 0 THEN uwd200.ric2 * -1 ELSE uwd200.ric2).
             END.
             
         END.

         IF FIRST-OF(riroprm.riskno) THEN DO: 
             ASSIGN n_prem_p = 0
                    n_com1_p = 0
                    n_com2_p = 0.

             FIND FIRST uwd200 USE-INDEX uwd20001 WHERE
                        uwd200.policy = nv_policy      
                    AND uwd200.rencnt = nv_rencnt      
                    AND uwd200.endcnt = nv_endcnt      
                    AND uwd200.csftq  = "F"            
                    AND uwd200.rico   = acm001.acno  
                    AND uwd200.riskno = riroprm.riskno NO-LOCK NO-ERROR.
             IF AVAIL uwd200 THEN DO:
                 
                 ASSIGN /*ข้อ 2 : หาเบี้ยของแต่ละบริษัท แต่ละ risk  เป็นกี่ % ของเบี้ยทั้งบริษัท*/
                    n_prem_p = IF uwd200.ripr = 0 THEN 0 ELSE ((IF uwd200.ripr < 0 THEN uwd200.ripr * -1 ELSE uwd200.ripr) * 100) / n_premri
                    n_com1_p = IF uwd200.ric1 = 0 THEN 0 ELSE ((IF uwd200.ric1 < 0 THEN uwd200.ric1 * -1 ELSE uwd200.ric1) * 100) / n_comri1
                    n_com2_p = IF uwd200.ric2 = 0 THEN 0 ELSE ((IF uwd200.ric2 < 0 THEN uwd200.ric2 * -1 ELSE uwd200.ric2) * 100) / n_comri2.
             END.
            
         END.

         n_per = 0. /* ข้อ 3 : หา % ของแต่ละบริษัท ในแต่ละ Risk เป็นกี่ % ของข้อ 2*/
         IF riroprm.xol = YES AND riroprm.cedper = 100 THEN DO:
            IF      n_prem_p <> 0 THEN n_per = (riroprm.cedper2 * n_prem_p) / 100.
            ELSE IF n_com1_p <> 0 THEN n_per = (riroprm.cedper2 * n_com1_p) / 100.
            ELSE IF n_com2_p <> 0 THEN n_per = (riroprm.cedper2 * n_com2_p) / 100.
         END.
         ELSE DO:
             IF      n_prem_p <> 0 THEN n_per = (riroprm.cedper * n_prem_p) / 100.
             ELSE IF n_com1_p <> 0 THEN n_per = (riroprm.cedper * n_com1_p) / 100.
             ELSE IF n_com2_p <> 0 THEN n_per = (riroprm.cedper * n_com2_p) / 100.

         END.
         

         IF LAST-OF(riroprm.riskno) THEN DO:  
             ASSIGN n_prem_p = 0
                    n_com1_p = 0
                    n_com2_p = 0.
         END.

         loop_wprocess:
         DO:
             FIND FIRST wprocess USE-INDEX wprocess01 WHERE
                        wprocess.wcedco   =  riroprm.ttyfac      AND
                        wprocess.wtrndat  =  acm001.trndat       AND
                        wprocess.wpolicy  =  acm001.policy       AND
                        wprocess.wtrntyp1 =  TRIM(acm001.trnty1) AND
                        wprocess.wDocno   =  acm001.docno        AND
                        wprocess.wProgid  =  nv_Progid           AND       
                        wprocess.wUserid  =  nv_Userid           AND
                        wprocess.wEntdat  =  nv_Entdat           AND
                        wprocess.wEntTime =  nv_EntTime NO-ERROR.
             IF NOT AVAIL wprocess THEN DO:   
                 CREATE wprocess.
                 ASSIGN wprocess.wasdat      =  n_asdat
                        wprocess.wdept       =  acm001.dept
                        wprocess.wtrndat     =  acm001.trndat
                        wprocess.wpolicy     =  acm001.policy
                        wprocess.wEndno      =  acm001.recno
                        wprocess.wComdat     =  n_comdat
                        wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
                        wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
                        wprocess.wDocno      =  acm001.docno
                        wprocess.wagent      =  acm001.agent
                        wprocess.wInsure     =  n_insur
                        wprocess.wPrem       =  (n_prem * n_per) / 100
                        wprocess.wPrem_Comp  =  (n_comp * n_per) / 100
                        wprocess.wStamp      =  (acm001.stamp * n_per) / 100
                        wprocess.wTax        =  (wprocess.wprem * 0.07) /*(acm001.tax * n_per) / 100*/
                        wprocess.wTax1       =  ((wprocess.wPrem * 0.01) * (-1))
                        wprocess.wcomm       =  (acm001.comm * n_per) / 100
                        wprocess.wdicc       =  (acm001.fee * n_per) / 100
                        wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
                        wprocess.wnetprem    =  wprocess.wprem - wprocess.wdicc
                        wprocess.wGross      =  wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1
                        wprocess.wnetamt     =  (acm001.netamt * n_per) / 100 
                        wprocess.wbal        =  (n_bal * n_per) / 100
                        wprocess.wacno       =  acm001.acno
                        wprocess.wacname     =  n_xmm600
                        wprocess.wcedco      =  TRIM(riroprm.ttyfac) /* SUB CODE */   /*A64-0410*/
                        wprocess.wcedname    =  n_cedname
                        wprocess.wagtreg     =  n_agtreg
                        wprocess.wriappl     =  n_appno
                        wprocess.wProgid     =  nv_Progid
                        wprocess.wUserid     =  nv_Userid
                        wprocess.wEntdat     =  nv_Entdat
                        wprocess.wEntTime    =  nv_EntTime 
                        wprocess.wcampol     =  n_campol
                        wprocess.wclityp     =  n_clityp
                        wprocess.wsi         =  nv_si          /*A59-0103*/
                        wprocess.wthpol      =  n_thpol.       /*A63-0415*/
                    
             END.
             ELSE DO:
                 
                 ASSIGN wprocess.wPrem       =  wprocess.wPrem      + ((n_prem * n_per) / 100)
                        wprocess.wPrem_Comp  =  wprocess.wPrem_Comp + ((n_comp * n_per) / 100)
                        wprocess.wStamp      =  wprocess.wStamp     + ((acm001.stamp * n_per) / 100)
                        wprocess.wTax        =  wprocess.wTax       + ((wprocess.wprem * 0.07)) /*((acm001.tax * n_per) / 100)*/
                        wprocess.wTax1       =  wprocess.wTax1      + ((wprocess.wPrem * 0.01) * (-1))
                        wprocess.wnetprem    =  wprocess.wnetprem   + (wprocess.wprem + wprocess.wdicc)
                        wprocess.wcomm       =  wprocess.wcomm      + ((acm001.comm * n_per) / 100)
                        wprocess.wdicc       =  wprocess.wdicc      + ((acm001.fee * n_per) / 100)
                        wprocess.wctotal     =  wprocess.wctotal    + (wprocess.wcomm  + wprocess.wdicc)
                        wprocess.wGross      =  wprocess.wgross     + (wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1)
                        wprocess.wnetamt     =  wprocess.wnetamt    + (((acm001.netamt * n_per) / 100))
                        wprocess.wbal        =  wprocess.wbal       + ((n_bal * n_per) / 100) 
                        wprocess.wsi         =  wprocess.wsi        + nv_si.   /*A59-0103*/
             END.
             RELEASE wprocess.
         END.
                
         ASSIGN
           n_sub  = YES
           n_per  = 0.
     END.
     /*========== End Inward Broker ==========*/

     IF n_sub = YES THEN NEXT loop_acm001.
     ELSE DO:
        CREATE wprocess.
        ASSIGN wprocess.wasdat      =  n_asdat
               wprocess.wdept       =  acm001.dept
               wprocess.wtrndat     =  acm001.trndat
               wprocess.wpolicy     =  acm001.policy
               wprocess.wEndno      =  acm001.recno
               wprocess.wComdat     =  n_comdat
               wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
               wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
               wprocess.wDocno      =  acm001.docno
               wprocess.wagent      =  acm001.agent
               wprocess.wInsure     =  n_insur
               wprocess.wPrem       =  n_prem
               wprocess.wPrem_Comp  =  n_comp
               wprocess.wStamp      =  acm001.stamp
               wprocess.wTax        =  (wprocess.wprem * 0.07)  /*acm001.tax*/ 
               wprocess.wTax1       =  ((wprocess.wPrem * 0.01) * (-1))
               wprocess.wcomm       =  acm001.comm
               wprocess.wdicc       =  acm001.fee
               wprocess.wnetprem    =  wprocess.wprem - wprocess.wdicc
               wprocess.wGross      =  wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1
               wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
               wprocess.wnetamt     =  acm001.netamt 
               wprocess.wbal        =  n_bal
               wprocess.wacno       =  acm001.acno
               wprocess.wacname     =  n_xmm600
               wprocess.wcedco      =  acm001.acno
               wprocess.wcedname    =  n_cedname
               wprocess.wProgid     =  nv_Progid
               wprocess.wUserid     =  nv_Userid
               wprocess.wEntdat     =  nv_Entdat
               wprocess.wEntTime    =  nv_EntTime
               wprocess.wcampol     =  n_campol
               wprocess.wclityp     =  n_clityp
               wprocess.wagtreg     =  n_agtreg
               wprocess.wriappl     =  n_appno 
               wprocess.wsi         =  nv_si          /*A59-0103*/
               wprocess.wthpol      =  n_thpol.       /*A63-0415*/
     END.

     n_sub = NO.
END.  /*acm001*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_Outward-BK WACR0091 
PROCEDURE pdProcess_Outward-BK :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_sub       AS LOGICAL INIT NO.
DEF VAR n_sumper    AS DECIMAL FORMAT ">>9.999999" INIT 0.000000.
DEF VAR n_per       AS DECIMAL FORMAT ">>9.999999" INIT 0.000000.
DEF VAR n_countrisk AS INTEGER FORMAT "999"        INIT 0.
DEF VAR n_poltyp    AS CHAR INIT "".

ASSIGN
  nv_Progid  = "WACR008"
  nv_Userid  = n_User
  nv_Entdat  = TODAY
  nv_EntTime = STRING(TIME,"HH:MM:SS").

/*== Begin Check Type ==*/
IF n_type = "MOTOR" THEN DO: /*MOTOR*/
    FOR EACH xmm031 WHERE xmm031.dept = "M" OR
                          xmm031.dept = "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE IF n_type = "NON-MOTOR" THEN DO:  /*NON-MOTOR*/ 
    FOR EACH xmm031 WHERE xmm031.dept <> "M" AND
                          xmm031.dept <> "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK: /*ALL*/
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
/*== End Check Type ==*/

loop_acm001:
FOR EACH acm001 USE-INDEX acm00103 NO-LOCK
        WHERE  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac 
          AND  acm001.curcod   =  "BHT"
          AND  acm001.trndat  >=  n_frdate 
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0                    
          AND  acm001.branch  >=  n_branch
          AND  acm001.branch  <=  n_branch2          
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) 
    :

    /*
    IF n_type = "Motor"     THEN DO:  /* MOTOR & COMP */
        IF acm001.dept <> "G" AND acm001.dept <> "M" THEN NEXT loop_acm001.
    END.
    IF n_type = "Non-Motor" THEN DO: /* NON-MOTOR */
        IF acm001.dept  = "G" OR  acm001.dept = "M" THEN NEXT loop_acm001.
    END. */

    IF INDEX(n_poltyp,SUBSTRING(acm001.poltyp,2,2)) = 0 THEN NEXT loop_acm001.

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT loop_acm001.

    DISP  "PROCESS : " + STRING(acm001.trndat,"99/99/9999")   + "  " + acm001.acno  + "  " + acm001.policy + "  " +
                         acm001.trnty1 + "  " + acm001.trnty2 + "  " + acm001.docno FORMAT "x(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */ @ fiDisplay  
    WITH FRAME  frDisplay.

    ASSIGN       
        n_insur   =  ""    nv_policy   = ""       
        n_comdat  =  ?     nv_rencnt   = 0    
        n_prem    =  0     nv_endcnt   = 0    
        n_comp    =  0     n_countrisk = 0
        n_bal     =  0     n_xmm600    = ""
        n_settle  =  0 .

    /* check company is reinsurance only */
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
    ELSE n_xmm600  =  TRIM(xmm600.ntitle + " " + xmm600.name).

    /* uwm100: policy & recno(endno) */
    FIND FIRST uwm100 WHERE
               uwm100.policy = acm001.policy AND
               uwm100.endno  = acm001.recno  NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO: 

        RUN pd_uwm100.  
        /*
        ASSIGN
            n_comdat   = uwm100.comdat          
            n_insur    = TRIM(uwm100.name1) + " " + TRIM(uwm100.name2) 
            n_prem     = acm001.prem
            nv_policy  = uwm100.policy
            nv_rencnt  = uwm100.rencnt 
            nv_endcnt  = uwm100.endcnt. */

        FIND LAST uwm120 USE-INDEX uwm12001 WHERE
                  uwm120.policy = uwm100.policy 
              AND uwm120.rencnt = uwm100.rencnt
              AND uwm120.endcnt = uwm100.endcnt
        NO-LOCK NO-ERROR.
        IF AVAIL uwm120 THEN n_countrisk = uwm120.riskno.    
      
    END.
    ELSE
        ASSIGN
            n_comdat   = acm001.comdat
            n_insur    = acm001.ref            
            n_prem     = acm001.prem
            nv_policy  = acm001.policy
            nv_rencnt  = acm001.rencnt 
            nv_endcnt  = acm001.endcnt
            n_comp     = 0 .
    
    IF (acm001.trnty1 = "Y" OR acm001.trnty1 = "Z") THEN
        ASSIGN
            n_prem = 0
            n_comp = 0.
    
    /* Balance */
    IF acm001.latdat > n_asdat THEN DO:
        FOR EACH acd001 USE-INDEX acd00191
            WHERE acd001.trnty1 = acm001.trnty1
            AND   acd001.docno  = acm001.docno
            AND   acd001.cjodat <= n_asdat NO-LOCK.
            n_settle = n_settle + acd001.netamt.
        END.
        n_bal = acm001.netamt + n_settle.
    END.
    ELSE n_bal = acm001.bal.

     /*========== Begin Outward Broker ==========*/
     ASSIGN
       n_sub       = NO
       n_sumper    = 0.000000
       n_per       = 0.000000.

     IF n_countrisk = 0  THEN DO:
        FIND LAST riroprm USE-INDEX riroprm01 
            WHERE riroprm.policy = nv_policy
              AND riroprm.rencnt = nv_rencnt
              AND riroprm.endcnt = nv_endcnt
              AND riroprm.csftq  = "F"
              AND riroprm.rico   = acm001.acno
        NO-LOCK NO-ERROR .
        IF AVAIL riroprm THEN n_countrisk = riroprm.riskno.             
     END.
    
       
     loop_riroprm:
     FOR EACH riroprm NO-LOCK USE-INDEX riroprm01 
        WHERE riroprm.policy = nv_policy
          AND riroprm.rencnt = nv_rencnt
          AND riroprm.endcnt = nv_endcnt
          AND riroprm.csftq  = "F"
          AND riroprm.rico   = acm001.acno
     BREAK BY riroprm.ttyfac 
           BY riroprm.riskno.

         n_sumper = n_sumper + riroprm.cedper. /* Sum Persent All Risk By Company */     

         IF LAST-OF(riroprm.ttyfac) AND LAST-OF(riroprm.riskno) THEN DO:

              IF n_countrisk = 0 THEN NEXT loop_riroprm.  /*เนื่องจาก ตัวหารไม่สามารถเป็น 0 ได้*/

              ASSIGN
               n_per    = (n_sumper * 100) / (n_countrisk * 100) /* Persent Of 100 By Company */ 
               n_sumper = 0.

              /*===
              n_per = ?  
              ตัวอย่าง : กรณี 0DTRC มี Sub Outward และ มีจำนวน 2 Risk ภายในกรมธรรม์
              
              Risk 001 => Sub Outward 1 => 0D....1  = 10%
                          Sub Outward 2 => 0D....2  = 20%
                          Sub Outward 3 => 0D....3  = 70%                          
              Risk 002 => Sub Outward 1 => 0D....1  = 30%
                          Sub Outward 2 => 0D....2  = 50%
                          Sub Outward 3 => 0D....3  = 20%
              *** แต่ละ Risk รวมกันได้ 100%
              
              สูตรการคำนวณ => (จำนวน % รวมของแต่ละบริษัท  คูณกับ 100) แล้วหารด้วย จำนวน % รวมทั้งหมด
               
              จำนวน % รวมทั้งหมด คือ ==> ถ้า มี 1 Risk จะได้ => 1 * 100 = 100
                                     ==> ถ้า มี 2 Risk จะได้ => 2 * 100 = 200
                                     ==> ถ้า มี 3 Risk จะได้ => 3 * 100 = 300
              
              Record ของ Sub Outward 1 => 10% + 30% = 40% => (40 * 100) / 200 => 20%
              Record ของ Sub Outward 2 => 20% + 50% = 70% => (70 * 100) / 200 => 35%
              Record ของ Sub Outward 3 => 70% + 20% = 90% => (90 * 100) / 200 => 45%              
              ===*/

              CREATE wprocess.
              ASSIGN wprocess.wasdat      =  n_asdat
                     wprocess.wdept       =  acm001.dept
                     wprocess.wtrndat     =  acm001.trndat
                     wprocess.wpolicy     =  acm001.policy
                     wprocess.wEndno      =  acm001.recno
                     wprocess.wComdat     =  n_comdat
                     wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
                     wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
                     wprocess.wDocno      =  acm001.docno
                     wprocess.wagent      =  acm001.agent
                     wprocess.wInsure     =  n_insur
                     wprocess.wPrem       =  ((n_prem) * n_per) / 100
                     wprocess.wPrem_Comp  =  ((n_comp) * n_per) / 100
                     wprocess.wStamp      =  ((acm001.stamp) * n_per) / 100
                     wprocess.wTax        =  ((acm001.tax) * n_per) / 100
                     wprocess.wGross      =  wprocess.wPrem + wprocess.wPrem_Comp + wprocess.wStamp + wprocess.wTax
                     wprocess.wcomm       =  ((acm001.comm) * n_per) / 100
                     wprocess.wdicc       =  ((acm001.fee) * n_per) / 100
                     wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
                     wprocess.wnetamt     =  ((acm001.netamt) * n_per) / 100 /*wprocess.wGross + wprocess.wctotal*/
                     wprocess.wbal        =  ((n_bal) * n_per) / 100
                     wprocess.wacno       =  acm001.acno
                     wprocess.wacname     =  n_xmm600
                     wprocess.wcedco      =  riroprm.ttyfac /* SUB CODE */
                     wprocess.wProgid     =  nv_Progid
                     wprocess.wUserid     =  nv_Userid
                     wprocess.wEntdat     =  nv_Entdat
                     wprocess.wEntTime    =  nv_EntTime .
         END.

         ASSIGN
           n_sub  = YES
           n_per  = 0.
     END.
     /*========== End Inward Broker ==========*/

     IF n_sub = YES THEN NEXT loop_acm001.
     ELSE DO:
        CREATE wprocess.
        ASSIGN wprocess.wasdat      =  n_asdat
               wprocess.wdept       =  acm001.dept
               wprocess.wtrndat     =  acm001.trndat
               wprocess.wpolicy     =  acm001.policy
               wprocess.wEndno      =  acm001.recno
               wprocess.wComdat     =  n_comdat
               wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
               wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
               wprocess.wDocno      =  acm001.docno
               wprocess.wagent      =  acm001.agent
               wprocess.wInsure     =  n_insur
               wprocess.wPrem       =  n_prem
               wprocess.wPrem_Comp  =  n_comp
               wprocess.wStamp      =  acm001.stamp
               wprocess.wTax        =  acm001.tax
               wprocess.wGross      =  wprocess.wPrem + wprocess.wPrem_Comp + wprocess.wStamp + wprocess.wTax 
               wprocess.wcomm       =  acm001.comm
               wprocess.wdicc       =  acm001.fee
               wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
               wprocess.wnetamt     =  acm001.netamt /*wprocess.wGross + wprocess.wctotal*/
               wprocess.wbal        =  n_bal
               wprocess.wacno       =  acm001.acno
               wprocess.wacname     =  n_xmm600
               wprocess.wcedco      =  acm001.acno
               wprocess.wProgid     =  nv_Progid
               wprocess.wUserid     =  nv_Userid
               wprocess.wEntdat     =  nv_Entdat
               wprocess.wEntTime    =  nv_EntTime .
     END.

     n_sub = NO.
END.  /*acm001*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_Outward_Bk2 WACR0091 
PROCEDURE pdProcess_Outward_Bk2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_sub       AS LOGICAL INIT NO.
DEF VAR n_per       AS DECIMAL FORMAT ">>9.999999" INIT 0.000000.
DEF VAR n_poltyp    AS CHAR INIT "".
DEF VAR n_premri    LIKE uwd200.ripr.
DEF VAR n_comri1    LIKE uwd200.ric1.
DEF VAR n_comri2    LIKE uwd200.ric2.
DEF VAR n_prem_p    LIKE uwd200.risi_p.
DEF VAR n_com1_p    LIKE uwd200.risi_p.
DEF VAR n_com2_p    LIKE uwd200.risi_p.

ASSIGN
  nv_Progid  = "WACR0091"
  nv_Userid  = n_User
  nv_Entdat  = TODAY
  nv_EntTime = STRING(TIME,"HH:MM:SS").

/*== Begin Check Type ==*/
IF n_type = "MOTOR" THEN DO: /*MOTOR*/
    FOR EACH xmm031 WHERE xmm031.dept = "M" OR
                          xmm031.dept = "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE IF n_type = "NON-MOTOR" THEN DO:  /*NON-MOTOR*/ 
    FOR EACH xmm031 WHERE xmm031.dept <> "M" AND
                          xmm031.dept <> "G"
    NO-LOCK:
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK: /*ALL*/
       n_poltyp = n_poltyp + "|" + SUBSTRING(xmm031.poltyp,2,2 ) .
    END.
END.
/*== End Check Type ==*/

loop_acm001:
FOR EACH acm001 USE-INDEX acm00103 NO-LOCK
        WHERE  acm001.acno    >=  n_frac 
          AND  acm001.acno    <=  n_toac 
          AND  acm001.curcod   =  "BHT"
          AND  acm001.trndat  >=  n_frdate 
          AND  acm001.trndat  <=  n_todate 
          AND  LOOKUP(SUBSTR(acm001.trnty1,1,1),nv_filter1) <> 0                    
          AND  acm001.branch  >=  n_branch
          AND  acm001.branch  <=  n_branch2          
          AND (acm001.bal     <>  0  
          OR  (acm001.bal      =  0  AND acm001.latdat > n_asdat) ) :

    IF INDEX(n_poltyp,SUBSTRING(acm001.poltyp,2,2)) = 0 THEN NEXT loop_acm001.

    IF ( YEAR(acm001.latdat) > 2999 ) AND (acm001.bal = 0)  THEN NEXT loop_acm001.

    DISP  "PROCESS : " + STRING(acm001.trndat,"99/99/9999")   + "  " + acm001.acno  + "  " + acm001.policy + "  " +
                         acm001.trnty1 + "  " + acm001.trnty2 + "  " + acm001.docno FORMAT "x(10)" /* Benjaporn J. A60-0267 date 27/06/2017 */ @ fiDisplay  
    WITH FRAME  frDisplay.

    ASSIGN       
        n_insur   = ""    nv_policy  = ""       
        n_comdat  = ?     nv_rencnt  = 0    
        n_prem    = 0     nv_endcnt  = 0    
        n_comp    = 0     n_bal      = 0     
        n_xmm600  = ""
        n_settle  = 0     n_campol   = ""
        n_clityp  = ""    n_cedname  = ""
        n_agtreg  = ""    n_riappl   = "".
       

    /* check company is reinsurance only */
    FIND  xmm600 USE-INDEX xmm60001 WHERE
          xmm600.acno = acm001.acno NO-LOCK NO-ERROR.
    IF NOT AVAIL xmm600 THEN NEXT loop_acm001.
    ELSE ASSIGN n_xmm600  =  TRIM(xmm600.ntitle + " " + xmm600.name)
                n_clityp = xmm600.clicod
                n_agtreg = xmm600.agtreg.

    /* A59-0109---keep Reinsurer name */  
    FIND xmm600 USE-INDEX xmm60001 WHERE
         xmm600.acno = acm001.cedno NO-LOCK NO-ERROR.
    IF AVAIL xmm600  THEN ASSIGN n_cedname =  TRIM(xmm600.ntitle + " " + xmm600.name).

    /* uwm100: policy & recno(endno) */
    FIND FIRST uwm100 WHERE
               uwm100.policy = acm001.policy AND
               uwm100.endno  = acm001.recno  NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO: 

        RUN pd_uwm100.  
        
    END.
    ELSE
        ASSIGN
            n_comdat   = acm001.comdat
            n_insur    = acm001.ref            
            n_prem     = acm001.prem
            nv_policy  = acm001.policy
            nv_rencnt  = acm001.rencnt 
            nv_endcnt  = acm001.endcnt
            n_comp     = 0 
            nv_company = acm001.acno.
    
    IF (acm001.trnty1 = "Y" OR acm001.trnty1 = "Z") THEN
        ASSIGN n_prem = 0
               n_comp = 0.
    
    /* Balance */
    IF acm001.latdat > n_asdat THEN DO:
        FOR EACH acd001 USE-INDEX acd00191
            WHERE acd001.trnty1 = acm001.trnty1
            AND   acd001.docno  = acm001.docno
            AND   acd001.cjodat <= n_asdat NO-LOCK.
            n_settle = n_settle + acd001.netamt.
        END.
        n_bal = acm001.netamt + n_settle.
    END.
    ELSE n_bal = acm001.bal.

     /*========== Begin Outward Broker ==========*/
     ASSIGN
       n_sub       = NO
       n_per       = 0.000000
       n_premri    = 0
       n_comri1    = 0
       n_comri2    = 0
       n_prem_p    = 0
       n_com1_p    = 0
       n_com2_p    = 0
       nv_si       = 0.    /*A59-0103*/
         
     RUN pdRIAppl.
     

     /*---A59-0103---*/
     FOR EACH uwm120 USE-INDEX uwm12001 WHERE
              uwm120.policy = acm001.policy AND uwm120.rencnt  = acm001.rencnt AND
              uwm120.endcnt = acm001.endcnt AND uwm120.riskgp >= 0  NO-LOCK.

         nv_si = 0.   /*---A64-0093----*/
     
         FOR EACH uwm130 USE-INDEX uwm13001 WHERE uwm130.policy = uwm120.policy AND
                  uwm130.rencnt  = uwm120.rencnt AND uwm130.endcnt  = uwm120.endcnt    AND
                  uwm130.riskgp >= uwm120.riskgp NO-LOCK.
             
             ASSIGN nv_si = nv_si + uwm130.uom1_v.
             /*DISP uwm130.uom1_c   uwm130.uom1_v.  */
         END.          

     END.
     
     /*---end A59-0103---*/

     loop_riroprm:
     FOR EACH riroprm NO-LOCK USE-INDEX riroprm01 
        WHERE riroprm.policy = nv_policy
          AND riroprm.rencnt = nv_rencnt
          AND riroprm.endcnt = nv_endcnt      /* Break By */  
          AND riroprm.csftq  = "F"            /* Rico 0DAAA , Risk 001 , Ttyfac 0A...1 */  
          AND riroprm.rico   = acm001.acno    /* Rico 0DAAA , Risk 001 , Ttyfac 0B...2 */  
     BREAK BY riroprm.rico                    /* Rico 0DAAA , Risk 002 , Ttyfac 0A...1 */ 
           BY riroprm.riskno                  /* Rico 0DAAA , Risk 002 , Ttyfac 0B...2 */  
           BY riroprm.ttyfac.    


         IF FIRST-OF(riroprm.rico) THEN DO:
             ASSIGN n_premri    = 0
                    n_comri1    = 0
                    n_comri2    = 0.

             loop_uwd200:
             FOR EACH   uwd200 USE-INDEX uwd20001 WHERE
                        uwd200.policy = nv_policy      
                    AND uwd200.rencnt = nv_rencnt      
                    AND uwd200.endcnt = nv_endcnt      
                    AND uwd200.csftq  = "F"            
                    AND uwd200.rico   = acm001.acno    
             NO-LOCK .
                 ASSIGN /*ข้อ 1 : หาเบี้ยทั้งหมดของแต่ละบริษัท*/
                    n_premri = n_premri + (IF uwd200.ripr < 0 THEN uwd200.ripr * -1 ELSE uwd200.ripr)
                    n_comri1 = n_comri1 + (IF uwd200.ric1 < 0 THEN uwd200.ric1 * -1 ELSE uwd200.ric1)
                    n_comri2 = n_comri2 + (IF uwd200.ric2 < 0 THEN uwd200.ric2 * -1 ELSE uwd200.ric2).
             END.

             /* A59-0109---keep Reinsurer name */  
             FIND xmm600 USE-INDEX xmm60001 WHERE
                  xmm600.acno = nv_company NO-LOCK NO-ERROR.
             IF AVAIL xmm600  THEN 
                ASSIGN n_cedname =  TRIM(xmm600.ntitle + " " + xmm600.name)
                       n_agtreg  = xmm600.agtreg.

             /*--Fai--*/
         END.

         IF FIRST-OF(riroprm.riskno) THEN DO: 

             ASSIGN n_prem_p = 0
                    n_com1_p = 0
                    n_com2_p = 0.

             FIND FIRST uwd200 USE-INDEX uwd20001 WHERE
                        uwd200.policy = nv_policy      
                    AND uwd200.rencnt = nv_rencnt      
                    AND uwd200.endcnt = nv_endcnt      
                    AND uwd200.csftq  = "F"            
                    AND uwd200.rico   = acm001.acno  
                    AND uwd200.riskno = riroprm.riskno NO-LOCK NO-ERROR.
             IF AVAIL uwd200 THEN DO:
                 
                 ASSIGN /*ข้อ 2 : หาเบี้ยของแต่ละบริษัท แต่ละ risk  เป็นกี่ % ของเบี้ยทั้งบริษัท*/
                    n_prem_p = IF uwd200.ripr = 0 THEN 0 ELSE ((IF uwd200.ripr < 0 THEN uwd200.ripr * -1 ELSE uwd200.ripr) * 100) / n_premri
                    n_com1_p = IF uwd200.ric1 = 0 THEN 0 ELSE ((IF uwd200.ric1 < 0 THEN uwd200.ric1 * -1 ELSE uwd200.ric1) * 100) / n_comri1
                    n_com2_p = IF uwd200.ric2 = 0 THEN 0 ELSE ((IF uwd200.ric2 < 0 THEN uwd200.ric2 * -1 ELSE uwd200.ric2) * 100) / n_comri2.
             END.
            
         END.

         n_per = 0. /* ข้อ 3 : หา % ของแต่ละบริษัท ในแต่ละ Risk เป็นกี่ % ของข้อ 2*/
         IF      n_prem_p <> 0 THEN n_per = (riroprm.cedper * n_prem_p) / 100.
         ELSE IF n_com1_p <> 0 THEN n_per = (riroprm.cedper * n_com1_p) / 100.
         ELSE IF n_com2_p <> 0 THEN n_per = (riroprm.cedper * n_com2_p) / 100.

         IF LAST-OF(riroprm.riskno) THEN DO:  
             ASSIGN n_prem_p = 0
                    n_com1_p = 0
                    n_com2_p = 0.
         END.
         loop_wprocess:
         DO:
             FIND FIRST wprocess USE-INDEX wprocess01 WHERE
                        wprocess.wcedco   =  riroprm.ttyfac      AND
                        wprocess.wtrndat  =  acm001.trndat       AND
                        wprocess.wpolicy  =  acm001.policy       AND
                        wprocess.wtrntyp1 =  TRIM(acm001.trnty1) AND
                        wprocess.wDocno   =  acm001.docno        AND
                        wprocess.wProgid  =  nv_Progid           AND       
                        wprocess.wUserid  =  nv_Userid           AND
                        wprocess.wEntdat  =  nv_Entdat           AND
                        wprocess.wEntTime =  nv_EntTime NO-ERROR.
             IF NOT AVAIL wprocess THEN DO:   
                 CREATE wprocess.
                 ASSIGN wprocess.wasdat      =  n_asdat
                        wprocess.wdept       =  acm001.dept
                        wprocess.wtrndat     =  acm001.trndat
                        wprocess.wpolicy     =  acm001.policy
                        wprocess.wEndno      =  acm001.recno
                        wprocess.wComdat     =  n_comdat
                        wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
                        wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
                        wprocess.wDocno      =  acm001.docno
                        wprocess.wagent      =  acm001.agent
                        wprocess.wInsure     =  n_insur
                        wprocess.wPrem       =  (n_prem * n_per) / 100
                        wprocess.wPrem_Comp  =  (n_comp * n_per) / 100
                        wprocess.wStamp      =  (acm001.stamp * n_per) / 100
                        wprocess.wTax        =  (wprocess.wprem * 0.07) /*(acm001.tax * n_per) / 100*/
                        wprocess.wTax1       =  ((wprocess.wPrem * 0.01) * (-1))
                        wprocess.wcomm       =  (acm001.comm * n_per) / 100
                        wprocess.wdicc       =  (acm001.fee * n_per) / 100
                        wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
                        wprocess.wnetprem    =  wprocess.wprem - wprocess.wdicc
                        wprocess.wGross      =  wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1
                        wprocess.wnetamt     =  (acm001.netamt * n_per) / 100 
                        wprocess.wbal        =  (n_bal * n_per) / 100
                        wprocess.wacno       =  acm001.acno
                        wprocess.wacname     =  n_xmm600
                        wprocess.wcedco      =  TRIM(riroprm.ttyfac) /* SUB CODE */   /*A64-0410*/
                        wprocess.wcedname    =  n_cedname
                        wprocess.wagtreg     =  n_agtreg
                        wprocess.wriappl     =  n_appno
                        wprocess.wProgid     =  nv_Progid
                        wprocess.wUserid     =  nv_Userid
                        wprocess.wEntdat     =  nv_Entdat
                        wprocess.wEntTime    =  nv_EntTime 
                        wprocess.wcampol     =  n_campol
                        wprocess.wclityp     =  n_clityp
                        wprocess.wsi         =  nv_si          /*A59-0103*/
                        wprocess.wthpol      =  n_thpol.       /*A63-0415*/
                    
             END.
             ELSE DO:
                 
                 ASSIGN wprocess.wPrem       =  wprocess.wPrem      + ((n_prem * n_per) / 100)
                        wprocess.wPrem_Comp  =  wprocess.wPrem_Comp + ((n_comp * n_per) / 100)
                        wprocess.wStamp      =  wprocess.wStamp     + ((acm001.stamp * n_per) / 100)
                        wprocess.wTax        =  wprocess.wTax       + ((wprocess.wprem * 0.07)) /*((acm001.tax * n_per) / 100)*/
                        wprocess.wTax1       =  wprocess.wTax1      + ((wprocess.wPrem * 0.01) * (-1))
                        wprocess.wnetprem    =  wprocess.wnetprem   + (wprocess.wprem + wprocess.wdicc)
                        wprocess.wcomm       =  wprocess.wcomm      + ((acm001.comm * n_per) / 100)
                        wprocess.wdicc       =  wprocess.wdicc      + ((acm001.fee * n_per) / 100)
                        wprocess.wctotal     =  wprocess.wctotal    + (wprocess.wcomm  + wprocess.wdicc)
                        wprocess.wGross      =  wprocess.wgross     + (wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1)
                        wprocess.wnetamt     =  wprocess.wnetamt    + (((acm001.netamt * n_per) / 100))
                        wprocess.wbal        =  wprocess.wbal       + ((n_bal * n_per) / 100) 
                        wprocess.wsi         =  wprocess.wsi        + nv_si.   /*A59-0103*/
             END.
             RELEASE wprocess.
         END.
                
         ASSIGN
           n_sub  = YES
           n_per  = 0.
     END.
     /*========== End Inward Broker ==========*/

     IF n_sub = YES THEN NEXT loop_acm001.
     ELSE DO:
        CREATE wprocess.
        ASSIGN wprocess.wasdat      =  n_asdat
               wprocess.wdept       =  acm001.dept
               wprocess.wtrndat     =  acm001.trndat
               wprocess.wpolicy     =  acm001.policy
               wprocess.wEndno      =  acm001.recno
               wprocess.wComdat     =  n_comdat
               wprocess.wtrntyp1    =  TRIM(acm001.trnty1)
               wprocess.wtrntyp2    =  TRIM(acm001.trnty2)
               wprocess.wDocno      =  acm001.docno
               wprocess.wagent      =  acm001.agent
               wprocess.wInsure     =  n_insur
               wprocess.wPrem       =  n_prem
               wprocess.wPrem_Comp  =  n_comp
               wprocess.wStamp      =  acm001.stamp
               wprocess.wTax        =  (wprocess.wprem * 0.07)  /*acm001.tax*/ 
               wprocess.wTax1       =  ((wprocess.wPrem * 0.01) * (-1))
               wprocess.wcomm       =  acm001.comm
               wprocess.wdicc       =  acm001.fee
               wprocess.wnetprem    =  wprocess.wprem - wprocess.wdicc
               wprocess.wGross      =  wprocess.wnetPrem + wprocess.wTax + wprocess.wTax1
               wprocess.wctotal     =  wprocess.wcomm  + wprocess.wdicc
               wprocess.wnetamt     =  acm001.netamt 
               wprocess.wbal        =  n_bal
               wprocess.wacno       =  acm001.acno
               wprocess.wacname     =  n_xmm600
               wprocess.wcedco      =  acm001.acno
               wprocess.wcedname    =  n_cedname
               wprocess.wProgid     =  nv_Progid
               wprocess.wUserid     =  nv_Userid
               wprocess.wEntdat     =  nv_Entdat
               wprocess.wEntTime    =  nv_EntTime
               wprocess.wcampol     =  n_campol
               wprocess.wclityp     =  n_clityp
               wprocess.wagtreg     =  n_agtreg
               wprocess.wriappl     =  n_appno 
               wprocess.wsi         =  nv_si          /*A59-0103*/
               wprocess.wthpol      =  n_thpol.       /*A63-0415*/
     END.

     n_sub = NO.
END.  /*acm001*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRIAppl WACR0091 
PROCEDURE pdRIAppl :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_thpol = "". /*A63-0415*/
/*------- F67-0002, F68-0002-----
FOR EACH uwm200 USE-INDEX uwm20001      WHERE
                     uwm200.policy = nv_policy    AND
                     uwm200.rencnt = nv_rencnt    AND
                     uwm200.endcnt = nv_endcnt    AND
                     uwm200.csftq  = "F"          AND
                     uwm200.rico   = acm001.acno  NO-LOCK.
-----end F67-0002, F68-0002 ----*/
FIND FIRST uwm200 USE-INDEX uwm20001      WHERE
                     uwm200.policy = nv_policy    AND
                     uwm200.rencnt = nv_rencnt    AND
                     uwm200.endcnt = nv_endcnt    AND
                     uwm200.csftq  = "F"          AND
                     uwm200.rico   = acm001.acno  NO-LOCK NO-ERROR.
IF AVAIL uwm200 THEN DO:
                
         ASSIGN n_appno = " "
                n_no    = STRING(uwm200.c_no,"9999999")
                n_year  = SUBSTR(STRING(uwm200.c_year,"9999"),3,2)
                n_appno = SUBSTR(uwm200.policy,1,4) + n_year + n_no
                n_thpol = uwm200.thpol. /*A63-0415*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm100 WACR0091 
PROCEDURE pd_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
            
ASSIGN
    n_comdat   = uwm100.comdat          
    n_insur    = TRIM(uwm100.name1) + " " + TRIM(uwm100.name2) 
    nv_policy  = uwm100.policy
    nv_rencnt  = uwm100.rencnt 
    nv_endcnt  = uwm100.endcnt
    nv_company = uwm100.acno1
    n_campol  =  uwm100.opnpol.

IF acm001.insno = 1 AND uwm100.instot = 1 THEN DO:
    IF SUBSTRING(acm001.policy,3,2) = "70" THEN DO:
        FOR EACH uwd132 WHERE
                 uwd132.policy = uwm100.policy AND
                 uwd132.rencnt = uwm100.rencnt AND
                 uwd132.endcnt = uwm100.endcnt NO-LOCK:
            IF uwd132.bencod = "COMP"  OR
               uwd132.bencod = "COMG"  OR
               uwd132.bencod = "COMH"  THEN
               n_comp = n_comp + uwd132.prem_c.
        END.    
        n_prem = acm001.prem - n_comp.
    END.
    ELSE  ASSIGN                             
            n_prem = acm001.prem             
            n_comp = 0.                      
END.    
ELSE  ASSIGN
        n_prem = acm001.prem
        n_comp = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

