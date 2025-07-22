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
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*++++++++++++++++++++++++++++++++++++++++++++++
  wuwqtis2.w :  Import text file from  ICBCTL  to create  new policy   
               Add in table  tlt Quey & Update data before Gen.
  Create  by  :  Ranu I. A59-0288  date. 26/09/2016 
  Modify by : Ranu I. A60-0263 date 12/06/2017 เพิ่มช่องแคมเปญ 
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . /*A57-0262*/
DEF VAR n_length  AS INT INIT 0 .
DEF VAR n_id1   AS char format "x(15)"  init "" . 
DEF VAR n_id2   AS char format "x(15)"  init "" . 
DEF VAR n_br    AS char format "x(15)"  init "" . 
DEF VAR n_char  AS CHAR FORMAT "x(100)" init "" .
DEF VAR n_comdat    AS CHAR.
DEF VAR n_expdat    AS CHAR.
DEF VAR n_comdat72  AS CHAR.
DEF VAR n_expdat72  AS CHAR.
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

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_policy fi_covcod2 fi_polstatus fi_compol ~
fi_producer fi_agent fi_branchsaf fi_notno fi_accno fi_comtotal fi_brand ~
fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no fi_licence fi_province ~
fi_comdat fi_expdat fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_title ~
fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 ~
fi_remark1 fi_remark2 bu_save bu_exit fi_class fi_camp fi_occup fi_comtyp ~
RECT-335 RECT-381 RECT-382 RECT-383 RECT-385 RECT-386 
&Scoped-Define DISPLAYED-OBJECTS fi_policy fi_covcod2 fi_type fi_polstatus ~
fi_paydate fi_compol fi_producer fi_agent fi_branchsaf fi_notno fi_accno ~
fi_comtotal fi_brand fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no ~
fi_licence fi_province fi_comdat fi_expdat fi_gross_amt fi_compprm fi_sckno ~
fi_prem1 fi_title fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 ~
fi_addr3 fi_addr4 fi_remark1 fi_remark2 fi_ldate fi_ltime fi_trndat ~
fi_userid fi_class fi_camp fi_trndat1 fi_occup fi_comtyp 

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
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 8 BY 1
     FONT 6.

DEFINE VARIABLE fi_accno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_addr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_addr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branchsaf AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 16.67 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_compol AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_compprm AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comtotal AS DECIMAL FORMAT "->>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comtyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covcod2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 47.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_firstname AS CHARACTER FORMAT "X(75)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_gross_amt AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20.33 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lastname AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 23.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ldate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_licence AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ltime AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 24.83 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_paydate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_polstatus AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 17.33 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prem1 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 91.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark2 AS CHARACTER FORMAT "X(85)":U 
     VIEW-AS FILL-IN 
     SIZE 91.33 BY .86
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sckno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ton AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.17 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 10 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndat1 AS DATE FORMAT "99/99/9999":U 
     LABEL "วันที่โหลด" 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 3 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 6.83 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.67 BY 28
     BGCOLOR 3 FGCOLOR 2 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 11 FGCOLOR 2 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.52
     BGCOLOR 6 FGCOLOR 0 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 3
     BGCOLOR 29 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 6.67.

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130.5 BY 9.33.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_policy AT ROW 1.43 COL 74.17 COLON-ALIGNED NO-LABEL
     fi_covcod2 AT ROW 11.86 COL 76.33 COLON-ALIGNED NO-LABEL
     fi_type AT ROW 1.33 COL 3.17 NO-LABEL
     fi_polstatus AT ROW 22.67 COL 50.67 COLON-ALIGNED NO-LABEL
     fi_paydate AT ROW 22.67 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_compol AT ROW 1.43 COL 109.33 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 3.62 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.57 COL 106.33 COLON-ALIGNED NO-LABEL
     fi_branchsaf AT ROW 4.67 COL 102.67 COLON-ALIGNED NO-LABEL
     fi_notno AT ROW 4.62 COL 47 COLON-ALIGNED NO-LABEL
     fi_accno AT ROW 4.67 COL 78.17 COLON-ALIGNED NO-LABEL
     fi_comtotal AT ROW 10.81 COL 79.17 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 7.76 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 7.71 COL 43.33 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 7.71 COL 78.17 COLON-ALIGNED NO-LABEL
     fi_ton AT ROW 7.67 COL 95.83 COLON-ALIGNED NO-LABEL
     fi_eng_no AT ROW 8.76 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 8.71 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_licence AT ROW 8.71 COL 85.83 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 8.71 COL 109.17 COLON-ALIGNED NO-LABEL
     fi_comdat AT ROW 9.76 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_expdat AT ROW 9.76 COL 45.83 COLON-ALIGNED NO-LABEL
     fi_gross_amt AT ROW 10.81 COL 56.67 COLON-ALIGNED NO-LABEL
     fi_compprm AT ROW 10.81 COL 16.33 COLON-ALIGNED NO-LABEL
     fi_sckno AT ROW 11.86 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_prem1 AT ROW 10.81 COL 38.67 COLON-ALIGNED NO-LABEL
     fi_title AT ROW 15.62 COL 18 COLON-ALIGNED NO-LABEL
     fi_firstname AT ROW 15.57 COL 38.17 COLON-ALIGNED NO-LABEL
     fi_lastname AT ROW 15.57 COL 72.5 COLON-ALIGNED NO-LABEL
     fi_icno AT ROW 16.67 COL 18 COLON-ALIGNED NO-LABEL
     fi_addr1 AT ROW 17.67 COL 18 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_addr2 AT ROW 17.67 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_addr3 AT ROW 18.62 COL 18 COLON-ALIGNED NO-LABEL
     fi_addr4 AT ROW 18.62 COL 77.67 COLON-ALIGNED NO-LABEL
     fi_remark1 AT ROW 19.57 COL 20 NO-LABEL
     fi_remark2 AT ROW 20.52 COL 18 COLON-ALIGNED NO-LABEL
     bu_save AT ROW 27.62 COL 112.33
     bu_exit AT ROW 27.62 COL 123
     fi_ldate AT ROW 3.57 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_ltime AT ROW 3.57 COL 47.83 COLON-ALIGNED NO-LABEL
     fi_trndat AT ROW 4.62 COL 18.17 COLON-ALIGNED NO-LABEL
     fi_userid AT ROW 22.62 COL 115 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 10.81 COL 102.17 COLON-ALIGNED NO-LABEL
     fi_camp AT ROW 11.86 COL 49.33 COLON-ALIGNED NO-LABEL
     fi_trndat1 AT ROW 22.62 COL 100.5 COLON-ALIGNED
     fi_occup AT ROW 16.62 COL 49 COLON-ALIGNED NO-LABEL
     fi_comtyp AT ROW 9.76 COL 72.33 COLON-ALIGNED NO-LABEL
     " Agent code :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 3.57 COL 95
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "  ที่อยู่ 4 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 18.62 COL 69.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 14.29 COL 2.33
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " รุ่นรถ :":30 VIEW-AS TEXT
          SIZE 7.67 BY .95 AT ROW 7.71 COL 37.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Remark :":30 VIEW-AS TEXT
          SIZE 10 BY .86 AT ROW 19.67 COL 9.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ยี่ห้อรถ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 7.76 COL 9.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขตัวถัง :":20 VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 8.71 COL 42.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เลขที่สัญญา :":30 VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 4.67 COL 68.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขที่เอกสาร :":30 VIEW-AS TEXT
          SIZE 12.83 BY .95 AT ROW 11.86 COL 38
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "ประเภทรถ :" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 9.76 COL 63.33
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "เบี้ยสุทธิ 72 :":30 VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 10.81 COL 5.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ปีรถ :":35 VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 7.67 COL 73.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "IC No :":30 VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 16.67 COL 12
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "VAT :":30 VIEW-AS TEXT
          SIZE 6.17 BY .95 AT ROW 10.81 COL 52
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " กรมธรรม์เดิม  :":35 VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 1.43 COL 60.67
          BGCOLOR 4 FGCOLOR 7 FONT 6
     "  อาชีพ :":30 VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 16.62 COL 42.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบี้ยรวม72 :":35 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 10.81 COL 68.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " เลขรับแจ้ง :":35 VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 4.57 COL 36.67
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Status Policy :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 22.67 COL 37.83
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " วันที่คุ้มครอง :":35 VIEW-AS TEXT
          SIZE 13.33 BY .95 AT ROW 9.76 COL 4.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "  ที่อยู่ 3 :":35 VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 18.67 COL 10.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ข้อรถและการประกันภัย" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 6.48 COL 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "เลขสติ๊กเกอร์ :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 11.86 COL 4.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "Stamp :":25 VIEW-AS TEXT
          SIZE 8.33 BY .95 AT ROW 10.81 COL 32
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " น้ำหนัก :":30 VIEW-AS TEXT
          SIZE 8.83 BY .95 AT ROW 7.67 COL 88.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ข้อมูลการแจ้งงาน" VIEW-AS TEXT
          SIZE 17 BY .81 AT ROW 2.62 COL 2
          BGCOLOR 3 FGCOLOR 7 FONT 6
     " นามสกุล :":30 VIEW-AS TEXT
          SIZE 9.67 BY .95 AT ROW 15.57 COL 64.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เบอร์ พรบ  :":35 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 1.43 COL 98
          BGCOLOR 2 FGCOLOR 7 FONT 6
     " วันที่หมดอายุ :":35 VIEW-AS TEXT
          SIZE 13.83 BY .95 AT ROW 9.76 COL 33.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " เลขเครื่อง :":35 VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 8.76 COL 7
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันที่ไฟล์แจ้งงาน :":30 VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 3.67 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ทะเบียน :":30 VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 8.71 COL 77.5
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " ชื่อ :":30 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 15.62 COL 34.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " เวลาโหลด  :":30 VIEW-AS TEXT
          SIZE 12.67 BY .95 AT ROW 3.57 COL 36.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Producer code :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.62 COL 63.33
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " สาขา :":30 VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 4.67 COL 98
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Class :":30 VIEW-AS TEXT
          SIZE 6.83 BY .95 AT ROW 10.81 COL 97.17
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " จังหวัด :":30 VIEW-AS TEXT
          SIZE 9.17 BY .95 AT ROW 8.71 COL 101.83
          BGCOLOR 19 FGCOLOR 0 FONT 6
     " คำนำหน้าชื่อ :":30 VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 15.67 COL 6.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     " ที่อยู่หน้าตาราง1 :":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 17.67 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันที่ออกงาน :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 22.67 COL 5
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "  ที่อยู่ 2 :":30 VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 17.67 COL 69.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "การใช้รถ:" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 11.81 COL 68.67
          BGCOLOR 19 FGCOLOR 0 FONT 6
     "วันที่ออกกรมธรรม์:" VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 4.67 COL 3
          BGCOLOR 19 FGCOLOR 2 FONT 6
     RECT-335 AT ROW 1 COL 1
     RECT-381 AT ROW 27.38 COL 111
     RECT-382 AT ROW 27.38 COL 121.83
     RECT-383 AT ROW 3.14 COL 2
     RECT-385 AT ROW 6.91 COL 2.33
     RECT-386 AT ROW 14.71 COL 2.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 133 BY 28.24
         BGCOLOR 3 FGCOLOR 1 .


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
         TITLE              = "Update Data ORICO (NEW/RENEW)"
         HEIGHT             = 28.43
         WIDTH              = 134.17
         MAX-HEIGHT         = 29.19
         MAX-WIDTH          = 135
         VIRTUAL-HEIGHT     = 29.19
         VIRTUAL-WIDTH      = 135
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
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
/* SETTINGS FOR FILL-IN fi_ldate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ltime IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_paydate IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_remark1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trndat1 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_type IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
ASSIGN 
       fi_type:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_userid IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data ORICO (NEW/RENEW) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data ORICO (NEW/RENEW) */
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
  Apply "Close"  To this-procedure.
  Return no-apply.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(brstat.tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                Assign
                       brstat.tlt.filler1         =  trim(input fi_policy)       /* กรมธรรม์เดิม*/
                       /*brstat.tlt.nor_noti_ins    =  trim(input fi_polsystem) */   /* เบอร์กรมธรรม์ใหม่ */ 
                       brstat.tlt.comp_pol        =  trim(input fi_compol)       /*เลขกรมธรรม์พรบ */ 
                       brstat.tlt.comp_sub        =  trim(input fi_producer)     /* produer code */                                                                                               
                       brstat.tlt.comp_noti_ins   =  trim(input fi_agent)        /* Agent */ 
                       /*brstat.tlt.rec_addr1       =  trim(input fi_vatcode)*/      /* Vatcode */
                       brstat.tlt.EXP             =  trim(input fi_branchsaf)    /*สาขาคุ้มภัย      */
                       brstat.tlt.nor_noti_tlt    =  trim(input fi_notno)        /*เลขที่รับแจ้ง*/
                       brstat.tlt.safe2           =  trim(input fi_accno)        /*เลขที่สัญญา  */   
                       /*brstat.tlt.nor_usr_ins     =  trim(input fi_ins_off)*/      /*ผู้แจ้ง                 */ 
                       brstat.tlt.brand           =  trim(input fi_brand)        /*ยี่ห้อ           */ 
                       brstat.tlt.model           =  trim(input fi_vehuse)       /*รุ่น             */ 
                       brstat.tlt.lince2          =  trim(input fi_year)         /*ปี           */  
                       brstat.tlt.cc_weight       =  fi_ton                /*ขนาดเครื่อง  */ 
                       /*brstat.tlt.colorcod        =  trim(fi_color) */             /*สี*/
                       brstat.tlt.eng_no          =  trim(input fi_eng_no)       /*เลขเครื่อง   */ 
                       brstat.tlt.cha_no          =  trim(input fi_cha_no)       /*เลขถัง       */ 
                       brstat.tlt.lince1          =  trim(input fi_licence)      /*เลขทะเบียน   */ 
                       brstat.tlt.lince3          =  trim(input fi_province)     /*จังหวัด          */
                       /*brstat.tlt.comp_usr_tlt    =  trim(input fi_covcod) */      /*ความคุ้มครอง */       
                       brstat.tlt.expousr         =  trim(input fi_covcod2)      /*ประเภทประกัน   */
                       brstat.tlt.old_eng         =  TRIM(INPUT fi_comtyp)       /*ประเภท พรบ.   */
                       brstat.tlt.gendat          =  input fi_comdat             /*วันที่เริ่มคุ้มครอง     */                                                                                            
                       brstat.tlt.expodat         =  input fi_expdat             /*วันที่สิ้นสุดคุ้มครอง   */
                      /* brstat.tlt.nor_coamt       =  input fi_sumsi  */            /*ทุนประกัน        */       
                       brstat.tlt.nor_grprm       =  input fi_prem1              /*เบี้ยสุทธิกธ.    */    
                       brstat.tlt.comp_coamt      =  input fi_gross_amt          /*เบี้ยรวมกธ       */ 
                       brstat.tlt.rec_addr4       =  string(input fi_compprm)    /*เบี้ยสุทธิพรบ.    */
                       brstat.tlt.comp_grprm      =  input fi_comtotal           /*เบี้ยรวมพรบ.    */ 
                       brstat.tlt.comp_sck        =  trim(input fi_sckno)        /*เลขที่สติ๊กเกอร์ */
                      /* brstat.tlt.stat            =  trim(input fi_garage)       /*สถานที่ซ่อม */
                       brstat.tlt.rec_addr3       =  trim(input fi_inspace)  */    /*ตรวจสภาพ     */                                                                                      /*A60-0263*/
                       brstat.tlt.safe3           =  trim(input fi_class)        /*class70         */      
                       brstat.tlt.lotno           =  trim(input fi_camp)         /*แคมเปญ*/                                  
                      /* brstat.tlt.old_cha         =  trim(input fi_acc) + " PRICE:" + trim(INPUT fi_accprice)*/  /*อุปกรณ์*/ /*ราคาอุปกรณ์*/  
                       brstat.tlt.rec_name        =  trim(fi_title)                    /*คำนำหน้าชื่อผู้เอาประกันภัย */                                                                                           
                       brstat.tlt.ins_name        =  trim(fi_firstname) + " " + trim(fi_lastname)           /* ชื่อ */                          
                       brstat.tlt.ins_addr5       =  trim(fi_icno)          /*IC No */                                                                                              
                      /* brstat.tlt.rec_addr2       =  trim(fi_recname)     /*ชื่อออกใบกำกับภาษี*/
                       brstat.tlt.rec_addr5       =  trim(fi_recadd)  */    /*ที่อยู่ออกใบกำกับภาษี*/
                       brstat.tlt.ins_addr1       =  trim(fi_addr1)       /*ที่อยู่ลูกค้า1         */                                                                                                     
                       brstat.tlt.ins_addr2       =  trim(fi_addr2)       /*ที่อยู่ลูกค้า2        */ 
                       brstat.tlt.ins_addr3       =  trim(fi_addr3)       /*ที่อยู่ลูกค้า3          */ 
                       brstat.tlt.ins_addr4       =  trim(fi_addr4)      /*ที่อยู่ลูกค้า4          */ 
                       brstat.tlt.recac           =  trim(fi_occup)      /*อาชีพ*/ 
                       /*brstat.tlt.safe1           =  trim(fi_benname) + " Delear:" + trim(fi_dealer) */ /*ดีลเลอร์ */ 
                       brstat.tlt.filler2         =  trim(fi_remark1) + " " + trim(fi_remark2) .  /*หมายเหตุ  */
                      /* brstat.tlt.dri_name1       =  trim(fi_driv1) + " ID1:" + TRIM(fi_drivid1)
                       brstat.tlt.dri_no1         =  trim(fi_birth1) 
                       brstat.tlt.dri_name2       =  trim(fi_driv2) + " ID2:" + trim(fi_drivid2)
                       brstat.tlt.dri_no2         =  trim(fi_birth2)*/
                       /*brstat.tlt.nor_usr_tlt     = "TAX:" + trim(fi_taxno)   +
                                                     " ID:" + trim(fi_saleid)   +   
                                                     " BR:" + trim(fi_branchtax).*/
            END.
            Apply "Close" to this-procedure.
            Return no-apply.
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            /*APPLY "entry" TO fi_covcod.*/
            RETURN NO-APPLY.
        END.
        END CASE.
RELEASE brstat.tlt.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_accno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_accno C-Win
ON LEAVE OF fi_accno IN FRAME fr_main
DO:
  fi_accno = INPUT fi_accno.
  DISP fi_accno WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr1 C-Win
ON LEAVE OF fi_addr1 IN FRAME fr_main
DO:
  fi_addr1 = INPUT fi_addr1 .
  DISP fi_addr1 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr2 C-Win
ON LEAVE OF fi_addr2 IN FRAME fr_main
DO:
  fi_addr2 = INPUT fi_addr2 .
  DISP fi_addr2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr3 C-Win
ON LEAVE OF fi_addr3 IN FRAME fr_main
DO:
  fi_addr3 = INPUT fi_addr3 .
  DISP fi_addr3 WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_addr4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_addr4 C-Win
ON LEAVE OF fi_addr4 IN FRAME fr_main
DO:
    fi_addr4 = INPUT fi_addr4.
    DISP fi_addr4 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent .
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchsaf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchsaf C-Win
ON LEAVE OF fi_branchsaf IN FRAME fr_main
DO:
  fi_branchsaf = INPUT fi_branchsaf.
  DISP fi_branchsaf WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
  fi_brand = INPUT fi_brand .
  DISP fi_brand WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp C-Win
ON LEAVE OF fi_camp IN FRAME fr_main
DO:
    /*A60-0263*/
    fi_camp = INPUT fi_camp .
    DISP fi_camp WITH FRAM fr_main.
     /*A60-0263*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cha_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cha_no C-Win
ON LEAVE OF fi_cha_no IN FRAME fr_main
DO:
  fi_cha_no  =  Input  fi_cha_no.
  Disp  fi_cha_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_class = INPUT fi_class.
  DISP fi_class WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat C-Win
ON LEAVE OF fi_comdat IN FRAME fr_main
DO:
  fi_comdat = INPUT fi_comdat.
  DISP fi_comdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compol C-Win
ON LEAVE OF fi_compol IN FRAME fr_main
DO:
  fi_compol  =  Input  fi_compol.
  Disp  fi_compol with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compprm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compprm C-Win
ON LEAVE OF fi_compprm IN FRAME fr_main
DO:
  fi_compprm = INPUT fi_compprm.
  DISP fi_compprm WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comtotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comtotal C-Win
ON LEAVE OF fi_comtotal IN FRAME fr_main
DO:
    fi_comtotal = INPUT fi_comtotal  .
    DISP fi_comtotal WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comtyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comtyp C-Win
ON LEAVE OF fi_comtyp IN FRAME fr_main
DO:
    fi_comtyp = INPUT fi_comtyp.
    DISP fi_comtyp WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod2 C-Win
ON LEAVE OF fi_covcod2 IN FRAME fr_main
DO:
    fi_covcod2 = INPUT fi_covcod2.
    DISP fi_covcod2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no C-Win
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
  fi_eng_no  =  Input  fi_eng_no.
  Disp  fi_eng_no with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_expdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_expdat C-Win
ON LEAVE OF fi_expdat IN FRAME fr_main
DO:
  fi_expdat = INPUT fi_expdat.
  DISP fi_expdat WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_firstname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_firstname C-Win
ON LEAVE OF fi_firstname IN FRAME fr_main
DO:
  fi_firstname = INPUT fi_firstname .
  DISP fi_firstname WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gross_amt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gross_amt C-Win
ON LEAVE OF fi_gross_amt IN FRAME fr_main
DO:
  fi_gross_amt = INPUT fi_gross_amt.
  DISP fi_gross_amt WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno C-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
    fi_icno = INPUT fi_icno .
    DISP fi_icno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_lastname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_lastname C-Win
ON LEAVE OF fi_lastname IN FRAME fr_main
DO:
    fi_lastname = INPUT fi_lastname .
    DISP fi_lastname WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licence
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licence C-Win
ON LEAVE OF fi_licence IN FRAME fr_main
DO:
  fi_licence =  Input  fi_licence.
  Disp  fi_licence with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notno C-Win
ON LEAVE OF fi_notno IN FRAME fr_main
DO:
  fi_notno = INPUT fi_notno .
  DISP fi_notno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup C-Win
ON LEAVE OF fi_occup IN FRAME fr_main
DO:
    fi_occup = INPUT fi_occup .
    DISP fi_occup WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prem1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prem1 C-Win
ON LEAVE OF fi_prem1 IN FRAME fr_main
DO:
  fi_prem1 = INPUT fi_prem1 .
  DISP fi_prem1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
  fi_province =  Input  fi_province.
  Disp  fi_province with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 C-Win
ON LEAVE OF fi_remark1 IN FRAME fr_main
DO:
    fi_remark1 = trim(INPUT fi_remark1).
    DISP fi_remark1 with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark2 C-Win
ON LEAVE OF fi_remark2 IN FRAME fr_main
DO:
    fi_remark2 = trim(INPUT fi_remark2).
    DISP fi_remark2 with frame  fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sckno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sckno C-Win
ON LEAVE OF fi_sckno IN FRAME fr_main
DO:
  fi_sckno = INPUT fi_sckno .
  DISP fi_sckno WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_title C-Win
ON LEAVE OF fi_title IN FRAME fr_main
DO:
  fi_title = INPUT fi_title.
  DISP fi_title WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ton C-Win
ON LEAVE OF fi_ton IN FRAME fr_main
DO:
  fi_ton  =  Input  fi_ton.
  Disp  fi_ton with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndat1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndat1 C-Win
ON LEAVE OF fi_trndat1 IN FRAME fr_main /* วันที่โหลด */
DO:
   /* fi_trndat1 = INPUT fi_trndat1.
    DISP fi_trndat1 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
  fi_vehuse =  Input  fi_vehuse.
  Disp  fi_vehuse with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year .
  DISP fi_year WITH FRAM fr_main.
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
  
  gv_prgid = "wgwqori2".
  gv_prog  = "Query & Update Data  (orico) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  Find  brstat.tlt  Where  Recid(brstat.tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  brstat.tlt  Then do:
         RUN proc_assignfi.
         DISP                                                                                                     
         fi_type      fi_ldate     fi_ltime     fi_trndat    fi_comtotal                              
         fi_accno     fi_notno     fi_year      fi_eng_no    fi_cha_no    fi_ton       
         fi_licence   /*fi_garage */   fi_province  fi_brand     fi_sckno     /*fi_sumsi     */
         fi_gross_amt fi_prem1     fi_compprm   /*fi_dealer*/    /*fi_inspace   fi_color*/
         fi_vehuse    fi_comdat    fi_expdat    fi_covcod2   /*fi_accprice  fi_acc*/
         /*fi_ins_off */  fi_addr1     fi_addr2     fi_addr3     fi_addr4     fi_branchsaf
         /*fi_driv1     fi_drivid1   fi_birth1    fi_driv2     fi_drivid2   fi_birth2   */ 
         fi_class     /*fi_benname */  fi_userid    /*fi_branchtax fi_saleid    fi_taxno   */       
         fi_compol    /*fi_covcod */   fi_policy    fi_producer  fi_agent     fi_remark1   
         fi_remark2   fi_title     fi_firstname fi_lastname  fi_icno      /*fi_polsystem */   
         fi_paydate   fi_polstatus /*fi_recname   fi_recadd*/    /*fi_nottime*/   fi_comtyp
         /*fi_vatcode*/   fi_camp      fi_trndat1   fi_occup  With frame  fr_main. 

        /* IF INDEX(brstat.tlt.releas,"YES") <> 0 THEN DO:
            DISABLE  fi_type      fi_ldate     fi_ltime     fi_trndat    fi_comtotal                              
            fi_accno     fi_notno     fi_year      fi_eng_no    fi_cha_no    fi_ton       
            fi_licence   fi_garage    fi_province  fi_brand     fi_sckno     fi_sumsi     
            fi_gross_amt fi_prem1     fi_compprm   fi_dealer    fi_inspace   fi_color
            fi_vehuse    fi_comdat    fi_expdat    fi_covcod2   fi_accprice  fi_acc
            fi_ins_off   fi_addr1     fi_addr2     fi_addr3     fi_addr4     fi_branchsaf
            fi_driv1     fi_drivid1   fi_birth1    fi_driv2     fi_drivid2   fi_birth2    
            fi_class     fi_benname   fi_userid    fi_branchtax fi_saleid    fi_taxno          
            fi_compol    fi_covcod    fi_policy    fi_producer  fi_agent     fi_remark1   
            fi_remark2   fi_title     fi_firstname fi_lastname  fi_icno      fi_polsystem    
            fi_paydate   fi_polstatus fi_recname   fi_recadd    fi_nottime   fi_comtyp
            fi_vatcode   fi_camp      fi_trndat1   fi_occup      bu_save     buchk With frame  fr_main.  
            bu_save:BGCOLOR = 18.
            buchk:BGCOLOR = 18.
         END.*/
  END.
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
  DISPLAY fi_policy fi_covcod2 fi_type fi_polstatus fi_paydate fi_compol 
          fi_producer fi_agent fi_branchsaf fi_notno fi_accno fi_comtotal 
          fi_brand fi_vehuse fi_year fi_ton fi_eng_no fi_cha_no fi_licence 
          fi_province fi_comdat fi_expdat fi_gross_amt fi_compprm fi_sckno 
          fi_prem1 fi_title fi_firstname fi_lastname fi_icno fi_addr1 fi_addr2 
          fi_addr3 fi_addr4 fi_remark1 fi_remark2 fi_ldate fi_ltime fi_trndat 
          fi_userid fi_class fi_camp fi_trndat1 fi_occup fi_comtyp 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_policy fi_covcod2 fi_polstatus fi_compol fi_producer fi_agent 
         fi_branchsaf fi_notno fi_accno fi_comtotal fi_brand fi_vehuse fi_year 
         fi_ton fi_eng_no fi_cha_no fi_licence fi_province fi_comdat fi_expdat 
         fi_gross_amt fi_compprm fi_sckno fi_prem1 fi_title fi_firstname 
         fi_lastname fi_icno fi_addr1 fi_addr2 fi_addr3 fi_addr4 fi_remark1 
         fi_remark2 bu_save bu_exit fi_class fi_camp fi_occup fi_comtyp 
         RECT-335 RECT-381 RECT-382 RECT-383 RECT-385 RECT-386 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi C-Win 
PROCEDURE proc_assignfi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Assign
          fi_type       = brstat.tlt.flag
          fi_policy     = brstat.tlt.filler1             /* กรมธรรม์เดิม*/
          /*fi_polsystem  = brstat.tlt.nor_noti_ins*/           /* เบอร์กรมธรรม์ใหม่ */ 
          fi_compol     = brstat.tlt.comp_pol            /*เลขกรมธรรม์พรบ */ 
          fi_ldate      = brstat.tlt.entdat              /* วันที่โหลด */  
          fi_ltime      = brstat.tlt.enttim              /* เวลาโหลด   */  
          fi_producer   = brstat.tlt.comp_sub            /* produer code */                                                                                               
          fi_agent      = brstat.tlt.comp_noti_ins       /* Agent */ 
          /*fi_vatcode    = brstat.tlt.rec_addr1  */          /* Vatcode */
          fi_trndat     = brstat.tlt.datesent              /* วันที่ไฟล์แจ้งงาน */ 
          /*fi_nottime    = brstat.tlt.trntim   */           /* เวลาแจ้งงาน */
          fi_branchsaf  = brstat.tlt.EXP                 /*สาขาคุ้มภัย      */
          fi_notno      = brstat.tlt.nor_noti_tlt        /*เลขที่รับแจ้ง*/
          fi_accno      = brstat.tlt.safe2               /*เลขที่สัญญา  */   
          /*fi_ins_off    = brstat.tlt.nor_usr_ins */        /*ผู้แจ้ง                 */ 
          fi_brand      = brstat.tlt.brand               /*ยี่ห้อ           */ 
          fi_vehuse     = brstat.tlt.model               /*รุ่น             */ 
          fi_year       = brstat.tlt.lince2              /*ปี           */  
          fi_ton        = brstat.tlt.cc_weight           /*ขนาดเครื่อง  */ 
          /*fi_color      = brstat.tlt.colorcod */           /*สี*/
          fi_eng_no     = brstat.tlt.eng_no              /*เลขเครื่อง   */ 
          fi_cha_no     = brstat.tlt.cha_no              /*เลขถัง       */ 
          fi_licence    = brstat.tlt.lince1              /*เลขทะเบียน   */ 
          fi_province   = brstat.tlt.lince3              /*จังหวัด          */
          /*fi_covcod     = trim(brstat.tlt.comp_usr_tlt)*/  /*ความคุ้มครอง */       
          fi_covcod2    = TRIM(brstat.tlt.expousr)       /*ประเภทการใช้รถ   */ 
          fi_comtyp     = TRIM(brstat.tlt.OLD_eng)       /*ประเภทรถ */
          fi_comdat     = brstat.tlt.gendat              /*วันที่เริ่มคุ้มครอง     */                                                                                            
          fi_expdat     = brstat.tlt.expodat             /*วันที่สิ้นสุดคุ้มครอง   */
          /*fi_sumsi      = brstat.tlt.nor_coamt */          /*ทุนประกัน        */       
          fi_prem1      = brstat.tlt.nor_grprm           /*stamp    */    
          fi_gross_amt  = brstat.tlt.comp_coamt          /*vat      */ 
          fi_compprm    = deci(brstat.tlt.rec_addr4)     /*เบี้ยสุทธิพรบ.    */
          fi_comtotal   = brstat.tlt.comp_grprm          /*เบี้ยรวมพรบ.    */ 
          fi_sckno      = brstat.tlt.comp_sck            /*เลขที่สติ๊กเกอร์ */
          /*fi_garage     = TRIM(brstat.tlt.stat)          /*สถานที่ซ่อม */
          fi_inspace    = brstat.tlt.rec_addr3    */       /*ตรวจสภาพ     */                                                                                      /*A60-0263*/
          fi_class      = trim(brstat.tlt.safe3)            /*class70         */      
          fi_camp       = brstat.tlt.lotno                 /* Docno */                                  
         /* fi_accprice   = IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,R-INDEX(brstat.tlt.old_cha,"PRICE:") + 6)  ELSE ""           /*ราคาอุปกรณ์*/                                                                               
          fi_acc        = IF trim(brstat.tlt.old_cha) <> "PRICE:" THEN substr(brstat.tlt.old_cha,1,INDEX(brstat.tlt.old_cha,"PRICE:") - 2)  ELSE ""    */      /*อุปกรณ์*/                                                                                               
          fi_title      = brstat.tlt.rec_name                          /*คำนำหน้าชื่อผู้เอาประกันภัย */                                                                                           
          nv_index      = Index(brstat.tlt.ins_name," ")      /* ชื่อ */                          
          fi_firstname  = IF index(fi_title,"บจก") <> 0 AND index(fi_title,"มูลนิธิ") <> 0 AND  
                          index(fi_title,"หจก") <> 0 AND  index(fi_title,"บริษัท") <> 0 THEN 
                          TRIM(brstat.tlt.ins_name)  ELSE Substr(brstat.tlt.ins_name,1,R-INDEX(brstat.tlt.ins_name," "))               
          fi_lastname   = IF index(fi_title,"บจก") <> 0 AND index(fi_title,"มูลนิธิ") <> 0 AND  
                          index(fi_title,"หจก") <> 0 AND  index(fi_title,"บริษัท") <> 0 THEN ""
                          ELSE Substr(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1,length(brstat.tlt.ins_name))                                                                                                 
          fi_icno       = TRIM(brstat.tlt.ins_addr5)           /*IC No */                                                                                              
          /*fi_recname    = brstat.tlt.rec_addr2         /*ชื่อออกใบกำกับภาษี*/
          fi_recadd     = brstat.tlt.rec_addr5 */        /*ที่อยู่ออกใบกำกับภาษี*/
          fi_addr1      = brstat.tlt.ins_addr1         /*ที่อยู่ลูกค้า1         */                                                                                                     
          fi_addr2      = brstat.tlt.ins_addr2         /*ที่อยู่ลูกค้า2        */ 
          fi_addr3      = brstat.tlt.ins_addr3         /*ที่อยู่ลูกค้า3          */ 
          fi_addr4      = trim(brstat.tlt.ins_addr4)   /*ที่อยู่ลูกค้า4          */ 
          fi_occup      = brstat.tlt.recac             /*อาชีพ*/
          n_length      = LENGTH(brstat.tlt.safe1)                                                 
          /*fi_benname    = IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,1,R-INDEX(brstat.tlt.safe1,"Delear:") - 1)) ELSE ""   /*ผู้รับผลประโยชน์*/      
          fi_dealer     = IF trim(brstat.tlt.safe1) <> "Delear:" THEN trim(SUBSTR(brstat.tlt.safe1,R-INDEX(brstat.tlt.safe1,"Delear:") + 7,n_length)) ELSE ""  /*ดีลเลอร์ */ */     
          fi_remark1    = IF LENGTH(brstat.tlt.filler2) <> 0  then SUBSTR(brstat.tlt.filler2,1,80)  else ""     /*หมายเหตุ  */                                
          fi_remark2    = IF LENGTH(brstat.tlt.filler2) > 80  then SUBSTR(brstat.tlt.filler2,81,80) else ""     /*หมายเหตุ  */
          fi_paydate    = brstat.tlt.dat_ins_noti       /*วันที่ matchfile confirm */
          fi_polstatus  = IF brstat.tlt.releas = "NO" THEN "ยังไม่ออกงาน" ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN "ยกเลิก" ELSE "ออกงานแล้ว"
          fi_trndat1    = brstat.tlt.entdat
          fi_userid     = brstat.tlt.usrid .              /*User Load Data */

         /* IF brstat.tlt.dri_name1 <> "" AND TRIM(brstat.tlt.dri_name1) <> "ID1:" THEN DO:
              ASSIGN
                n_char        = trim(brstat.tlt.dri_name1) /* ผู้ขับขี่ 1 */
                n_length      = LENGTH(n_char)
                fi_driv1      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID1:") - 1))         /*ระบุผู้ขับขี้1    */  
                fi_drivid1    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID1:") + 4,n_length))  /*เลขที่ใบขับขี่1   */ 
                fi_birth1     = trim(brstat.tlt.dri_no1 ). /*วันเดือนปีเกิด1   */ 
          END.
          ELSE ASSIGN fi_drivid1   = ""     fi_driv1     = ""   fi_birth1    = "".

          IF brstat.tlt.dri_name2 <> "" AND TRIM(brstat.tlt.dri_name2) <> "ID2:"THEN DO:
              ASSIGN 
                n_char        = trim(brstat.tlt.dri_name2)  /*ผู้ขับขี่ 2*/ 
                n_length      = LENGTH(n_char)
                fi_driv2      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"ID2:") - 1))          /*ระบุผู้ขับขี้2      */  
                fi_drivid2    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"ID2:") + 4,n_length))   /*เลขที่ใบขับขี่2     */ 
                fi_birth2     = trim(brstat.tlt.dri_no2). /*วันเดือนปีเกิด2*/
          END.
          ELSE  ASSIGN fi_drivid2   = ""     fi_driv2     = ""    fi_birth2    = "".  

        IF brstat.tlt.nor_usr_tlt <> "" AND TRIM(brstat.tlt.nor_usr_tlt) <> "TAX: ID: BR:" THEN DO:
            ASSIGN
            n_char        = trim(brstat.tlt.nor_usr_tlt)
            n_length      = LENGTH(n_char)
            n_br          = IF INDEX(n_char,"BR:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"BR:"),n_length)) ELSE ""   /*wht 72*/
            n_char        = IF INDEX(n_char,"BR:") <> 0 THEN SUBSTR(n_char,1,INDEX(n_char,"BR:")) ELSE SUBSTR(n_char,1,n_length) 
            n_length      = LENGTH(n_char)
            n_ID2         = IF INDEX(n_char,"ID:") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char,"ID:"),n_length)) ELSE ""    /*wht70              */
            n_ID1         = IF INDEX(n_char,"TAX:") <> 0 THEN trim(SUBSTR(n_char,1,INDEX(n_char,"ID:"))) 
                            ELSE ""       /*ทุนหาย           */
            fi_taxno     = if n_ID1  <> "TAX:" then  substr(n_id1,5,(LENGTH(n_id1) - 5 ))  else ""
            fi_saleid    = if n_ID2  <> "ID:"  then  substr(n_id2,4,(LENGTH(n_id2) - 5 ))  else ""
            fi_branchtax = if n_br   <> "BR:"  then  substr(n_br,4,LENGTH(n_br))   else ""  .
          END.
          ELSE  ASSIGN  fi_saleid    = ""    fi_taxno = ""   fi_branchtax = "".*/
         
         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

