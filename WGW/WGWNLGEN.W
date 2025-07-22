&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
          sic_test         PROGRESS
*/
  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: Porntiwa T. A59-0423  28/09/2016 
  Duplicate Program : WGWMCGEN.W
  modify by : Chaiyong W. A59-0614 
              add paycod
  modify by : Chaiyong W. A61-0016
              add text f7 & f8 
  Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth            
  Modify By : Tontawan S. A63-0124 03/04/2020
            : แก้ไขเปลี่ยน pack การโหลดงาน NTL เป็น PACK T   
  Modify By : Tontawan S. A63-0124 07/04/2020   
            : เพิ่มเงื่อนไขการเช็คเลขที่มีการต่ออายุเพิ่มถ้าไม่ใช่ Pack "A"
            : ให้เปลี่ยนเป็น Pack "T"
  Modify By : Tontawan S. A63-0124 15/04/2020   
            : แก้ไข Field uwm120.Class Check "T" ไม่ต้อง Substring
  Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname..... 
  Modify by : Tontawan S. A64-0149 Date. 07/04/2021
              แก้ไข Insure Code ลูกค้างานต่ออายุ NTL ให้ Update ชื่อที่อยู่ 
              ตามไฟล์แจ้งงาน อัพทั้งหน้า Premium uwm100 และ หน้า xmm600 / xtm600
 Modify by : Ranu I. A64-0247 เพิ่มการ match File ดึงข้อมูลตรวจสภาพ 
             เก็บข้อมูลตรวจสภาพเข้าระบบพรีเมียมเพื่อออกรายงาน  
 Modify by  : Kridtiya i. A65-0125 Date 01/05/2022 add Claimdi to Product  
 Modify by  : Ranu I. A65-0203 เพิ่มการใช้ parameter uw และ ใช้โปรแกรมการคำนวณเบี้ยกลาง 
 Modify by  : Kridtiya i. A66-0069 Date. 22/03/2023 เพิ่ม จำนวนความเสียหายที่ไฟล์แมทตรวจสภาพ
 Modify By  : Porntiwa T. A67-0029 Date. 26/06/2024 Add New Template
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
SESSION:MULTITASKING-INTERVAL = 100.
/* Local Variable Definitions ---                                       */
/*******************************/

DEFINE SHARED VAR n_user   AS CHAR.
DEFINE SHARED VAR n_passwd AS CHAR.

/*a490166*/
DEFINE NEW SHARED VAR  nv_batchyr       AS INTE FORMAT "9999"               INIT    0. 
DEFINE NEW SHARED VAR  nv_batcnt        AS INTE FORMAT "99"                 INIT    0. 
DEFINE NEW SHARED VAR  nv_batchno       AS CHAR FORMAT "X(15)"              INIT    ""  NO-UNDO.
                                                                                    
DEFINE NEW SHARED VAR  nv_batprev       AS CHAR FORMAT "X(13)"              INIT    ""  NO-UNDO.
DEFINE NEW SHARED VAR  nv_tmppolrun     AS INTE FORMAT "999"                INIT    0. /*Temp Policy Running No.*/
DEFINE NEW SHARED VAR  nv_batbrn        AS CHAR FORMAT "x(2)"               INIT    ""  NO-UNDO. /*Batch Branch*/
DEFINE NEW SHARED VAR  nv_tmppol        AS CHAR FORMAT "x(16)"              INIT    "". /*Temp Policy*/
                                                                                    
DEFINE NEW SHARED VAR  nv_batrunno      AS INTE FORMAT  ">,>>9"             INIT    0. 
DEFINE NEW SHARED VAR  nv_imppol        AS INTE FORMAT ">>,>>9"             INIT    0. 
DEFINE NEW SHARED VAR  nv_impprem       AS DECI FORMAT "->,>>>,>>9.99"      INIT    0. 
                                                                                    
DEFINE NEW SHARED VAR  nv_daily         AS CHAR FORMAT "X(1024)"            INIT    ""  NO-UNDO.
                                                                                    
DEFINE NEW SHARED VAR  nv_reccnt        AS INTE                             INIT    0.        /*all load record*/
DEFINE NEW SHARED VAR  nv_completecnt   AS INTE                             INIT    0.  /*complete record */
                                                                                    
DEFINE NEW SHARED VAR  nv_rectot        AS INTE FORMAT ">>,>>9"             INIT    0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE NEW SHARED VAR  nv_recsuc        AS INTE FORMAT ">>,>>9"             INIT    0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE NEW SHARED VAR  nv_netprm_t      AS DECI FORMAT "->,>>>,>>9.99"      INIT    0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE NEW SHARED VAR  nv_netprm_s      AS DECI FORMAT "->,>>>,>>9.99"      INIT    0.  /* Display เบี้ยรวม ที่นำเข้าได้ */
                                                                                    
DEFINE NEW SHARED VAR  nv_batflg        AS LOG                              INIT    NO.
DEFINE NEW SHARED VAR  nv_txtmsg        AS CHAR FORMAT "x(50)"              INIT    "".   /* Parameter คู่กับ nv_check */
DEFINE NEW SHARED VAR  nv_check         AS CHAR                             INIT    ""  NO-UNDO.
DEFINE NEW SHARED VAR  nv_sist_p        AS DECI FORMAT ">>>,>>9.99-"        INIT    0. 
DEFINE NEW SHARED VAR  nv_chkstk        AS CHAR FORMAT "9999999999999"      INIT    "".           
DEFINE NEW SHARED VAR  nvw_sticker      AS INTE FORMAT "999999999999"       INIT    0   NO-UNDO.  
DEFINE NEW SHARED VAR  chr_sticker      AS CHAR FORMAT "X(15)".                        
DEFINE NEW SHARED VAR  nv_modulo        AS INTE FORMAT "9".                                 

DEFINE            VAR  nv_row           AS INTE                             INIT  0.

{wgw\wgwnlgen.i} /*ประกาศตัวแปร*/

DEFINE NEW SHARED WORKFILE wendtext  NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".

DEFINE            WORKFILE wdelimi   NO-UNDO
       FIELD txt     AS CHARACTER FORMAT "X(1000)" INITIAL "".

DEFINE STREAM nnotdata.
DEFINE STREAM ns1. 
DEFINE STREAM ns2.
DEFINE STREAM ns3.

DEFINE VAR nv_cstw AS DECI.
DEFINE VAR nv_modelchk AS CHAR FORMAT "X(60)".
DEFINE VAR nv_cpcdat AS CHAR FORMAT "X(10)".
DEFINE VAR nv_cpedat AS CHAR FORMAT "X(10)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME brquery

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wexcel

/* Definitions for BROWSE brquery                                       */
&Scoped-define FIELDS-IN-QUERY-brquery wexcel.werror wexcel.policy wexcel.fname wexcel.addr1 wexcel.addr2 wexcel.addr3 wexcel.addr4 wexcel.comdat wexcel.wmark   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brquery   
&Scoped-define SELF-NAME brquery
&Scoped-define QUERY-STRING-brquery FOR EACH wexcel
&Scoped-define OPEN-QUERY-brquery OPEN QUERY brquery FOR EACH wexcel.
&Scoped-define TABLES-IN-QUERY-brquery wexcel
&Scoped-define FIRST-TABLE-IN-QUERY-brquery wexcel


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-brquery}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brquery fi_camptruck fi_ispyr ra_type ~
fi_display fi_loaddat fi_branch fi_bchno fi_producer fi_agent fi_prevbat ~
fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt ~
fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent fi_package fi_txt ~
RECT-368 RECT-370 RECT-373 RECT-374 RECT-375 RECT-376 RECT-372 RECT-377 ~
RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_camptruck fi_ispyr ra_type fi_display ~
fi_loaddat fi_branch fi_bchno fi_producer fi_agent fi_prevbat fi_bchyr ~
fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes ~
fi_impcnt fi_completecnt fi_proname fi_agtname fi_premtot fi_premsuc ~
fi_package fi_txt 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.1.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 38.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_camptruck AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_display AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 121 BY .95
     BGCOLOR 8 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_ispyr AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.33 BY 1
     BGCOLOR 15 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_package AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_txt AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 14.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Match Inspection", 1,
"Load File To GW", 2,
"Match Inspection New", 3,
"Load File To GW New", 4
     SIZE 24.5 BY 5.14
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-368
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 53.5 BY 1.67
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 11.71
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 6.67
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124 BY 3.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 121.5 BY 3.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 106 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brquery FOR 
      wexcel SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brquery
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brquery C-Win _FREEFORM
  QUERY brquery DISPLAY
      wexcel.werror  COLUMN-LABEL "Comment"    FORMAT "X(50)" 
 wexcel.policy  COLUMN-LABEL "Policy"     FORMAT "X(16)"
 wexcel.fname   COLUMN-LABEL "Name"       FORMAT "X(35)" 
 wexcel.addr1   COLUMN-LABEL "Address 1"  FORMAT "X(35)" 
 wexcel.addr2   COLUMN-LABEL "Address 2"  FORMAT "X(35)" 
 wexcel.addr3   COLUMN-LABEL "Address 3"  FORMAT "X(35)" 
 wexcel.addr4   COLUMN-LABEL "Address 4"  FORMAT "X(35)" 
 wexcel.comdat  COLUMN-LABEL "Comdat"     FORMAT "99/99/9999" 
 wexcel.wmark   COLUMN-LABEL "Status"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 122.5 BY 6.43
         BGCOLOR 15 FONT 6 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     brquery AT ROW 14.71 COL 2.67 WIDGET-ID 100
     fi_camptruck AT ROW 3.62 COL 71.5 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     fi_ispyr AT ROW 8.76 COL 114.67 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     ra_type AT ROW 3.48 COL 100.5 NO-LABEL WIDGET-ID 6
     fi_display AT ROW 20.19 COL 1.5 COLON-ALIGNED NO-LABEL
     fi_loaddat AT ROW 3.71 COL 32 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.76 COL 47.67 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.48 COL 15.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producer AT ROW 5.86 COL 32 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.91 COL 32 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 7.95 COL 32 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 7.95 COL 64.67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9 COL 32 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9 COL 95.83
     fi_output1 AT ROW 10.05 COL 32 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.1 COL 32 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.14 COL 32 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.19 COL 32 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.19 COL 77.5 NO-LABEL
     buok AT ROW 11.1 COL 108.33
     bu_exit AT ROW 12.95 COL 108.5
     fi_brndes AT ROW 4.67 COL 58.5 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 4.67 COL 56.17
     fi_impcnt AT ROW 21.91 COL 61.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno1 AT ROW 5.86 COL 49.5
     fi_completecnt AT ROW 22.91 COL 61.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 6.91 COL 49.5
     fi_proname AT ROW 5.76 COL 52.5 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.86 COL 52.5 COLON-ALIGNED NO-LABEL
     fi_premtot AT ROW 21.91 COL 97.67 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.95 COL 95.67 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_package AT ROW 4.76 COL 32 COLON-ALIGNED NO-LABEL
     fi_txt AT ROW 8.76 COL 100 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY 1.05 AT ROW 4.71 COL 39.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 11.1 COL 9.5
          BGCOLOR 8 FGCOLOR 1 
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.91 COL 60.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21 BY 1.05 AT ROW 7.95 COL 11
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 13.19 COL 76 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.91 COL 95.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.91 COL 95.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY 1.05 AT ROW 9 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TRUCK Campaing :" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 3.62 COL 53.83 WIDGET-ID 24
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.48 COL 5.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.91 COL 116.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 127.67 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Producer  Code :" VIEW-AS TEXT
          SIZE 17.17 BY 1.05 AT ROW 5.86 COL 15.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.91 COL 60.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1.05 AT ROW 7.95 COL 64.16 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY 1.05 AT ROW 3.71 COL 20.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 12.14 COL 14.83
          BGCOLOR 8 FGCOLOR 1 
     "Package :" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 5 COL 22.17
          BGCOLOR 8 FGCOLOR 1 
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY 1.05 AT ROW 13.19 COL 31.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.91 COL 116.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   LOAD TEXT FILE NTL BROKER (V70, เงินติดล้อ)" VIEW-AS TEXT
          SIZE 122 BY .95 AT ROW 1.62 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 10.05 COL 13.5
          BGCOLOR 8 FGCOLOR 1 
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY 1.05 AT ROW 6.91 COL 18.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 13.19 COL 96.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-368 AT ROW 12.95 COL 41.67
     RECT-370 AT ROW 1.29 COL 2
     RECT-373 AT ROW 14.57 COL 2
     RECT-374 AT ROW 21.24 COL 2
     RECT-375 AT ROW 21.43 COL 3.5
     RECT-376 AT ROW 21.71 COL 4.67
     RECT-372 AT ROW 2.86 COL 2
     RECT-377 AT ROW 10.81 COL 107.33
     RECT-378 AT ROW 12.67 COL 107.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 127.67 BY 24
         BGCOLOR 3 FONT 6.


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
         TITLE              = "Load text File NTL V70 - WGWNLGEN.W"
         HEIGHT             = 23.95
         WIDTH              = 126.17
         MAX-HEIGHT         = 47.52
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 47.52
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
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
/* BROWSE-TAB brquery 1 fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_bchno:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_brndes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtot IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_txt:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY 1.05 AT ROW 7.95 COL 64.16 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY 1.05 AT ROW 13.19 COL 31.17 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1.05 AT ROW 13.19 COL 76 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.91 COL 60.5 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.91 COL 95.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.91 COL 60.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.91 COL 95.5 RIGHT-ALIGNED        */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brquery
/* Query rebuild information for BROWSE brquery
     _START_FREEFORM
OPEN QUERY brquery FOR EACH wexcel.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brquery */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load text File NTL V70 - WGWNLGEN.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load text File NTL V70 - WGWNLGEN.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brquery
&Scoped-define SELF-NAME brquery
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brquery C-Win
ON ROW-DISPLAY OF brquery IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 28.
      
    IF wexcel.werror <> "" THEN DO:
       wexcel.policy     :BGCOLOR IN BROWSE brquery = z NO-ERROR.
       wexcel.fname      :BGCOLOR IN BROWSE brquery = z NO-ERROR.  
       wexcel.addr1      :BGCOLOR IN BROWSE brquery = z NO-ERROR.  
       wexcel.addr3      :BGCOLOR IN BROWSE brquery = z NO-ERROR.  
       wexcel.addr4      :BGCOLOR IN BROWSE brquery = z NO-ERROR.  
       wexcel.comdat     :BGCOLOR IN BROWSE brquery = z NO-ERROR.  
       wexcel.werror     :BGCOLOR IN BROWSE brquery = z NO-ERROR. 
       wexcel.wmark      :BGCOLOR IN BROWSE brquery = z NO-ERROR. 

       wexcel.policy    :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
       wexcel.fname     :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
       wexcel.addr1     :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
       wexcel.addr3     :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
       wexcel.addr4     :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
       wexcel.comdat    :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
       wexcel.werror    :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
       wexcel.wmark     :FGCOLOR IN BROWSE brquery = s NO-ERROR. 
        
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
  IF ra_type = 1  THEN DO:
      RUN proc_matchisp.
  END.
  ELSE IF ra_type = 3 THEN DO:
      RUN proc_matchispNew.
  END.
  ELSE DO:
    ASSIGN
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0.
    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
    
    IF fi_branch = " " THEN DO: /*note add 10/11/2005*/
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_producer = " " THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer.
        RETURN NO-APPLY.
    END.
    IF fi_agent = " " THEN DO:
        MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_Agent.
        RETURN NO-APPLY.
    END.
    IF fi_loaddat = ? THEN DO:
        MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_loaddat.
        RETURN NO-APPLY.
    END.
    IF fi_bchyr <= 0 THEN DO:
        MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_bchyr.
        RETURN NO-APPLY.
    END.
    ASSIGN
        fi_output1 = INPUT fi_output1
        fi_output2 = INPUT fi_output2
        fi_output3 = INPUT fi_output3.
    
    IF fi_output1 = "" THEN DO:
        MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output1.
        RETURN NO-APPLY.
    END.
    IF fi_output2 = "" THEN DO:
        MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output2.
        RETURN NO-APPLY.
    END.
    IF fi_output3 = "" THEN DO:
        MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output3.
        RETURN NO-APPLY.
    END.

    nv_batchyr  = INPUT fi_bchyr.
    fi_Producer = TRIM(fi_Producer).
    nv_batbrn   = "M".

    /*-- Check Batch No. --*/
    IF nv_batprev = "" THEN DO:  /*-- Check Batch นำเข้าครั้งแรก --*/
        FIND LAST uzm700 USE-INDEX uzm70001 WHERE 
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.branch  = TRIM(nv_batbrn)   AND
            uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:  /*-- Running 4 หลักหลัง branch --*/
            ASSIGN nv_batrunno = uzm700.runno.
    
            FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                      uzm701.bchyr = nv_batchyr AND /*A64-0247*/
                      uzm701.bchno = trim(fi_producer) + trim(nv_batbrn) + STRING(nv_batrunno,"9999")
            NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN DO:
                ASSIGN 
                nv_batcnt   = uzm701.bchcnt
                nv_batrunno = nv_batrunno + 1.
            END.
        END.
        ELSE DO:
            ASSIGN
                nv_batcnt   = 1
                nv_batrunno = 1.
        END.
        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  /*-- Check Batch Old --*/
        nv_batprev = fi_prevbat.
        FIND LAST uzm701 USE-INDEX uzm70102 WHERE 
            uzm701.bchyr = nv_batchyr        AND
            uzm701.bchno = nv_batprev NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + nv_batprev
                  + " on file uzm701" .
            APPLY "ENTRY" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        IF AVAIL uzm701 THEN DO:
            nv_batcnt  = uzm701.bchcnt + 1.
            nv_batchno = CAPS(TRIM(nv_batprev)).
        END.
    END.

    ASSIGN
       fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
       fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
       fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
       fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
       nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
       nv_tmppolrun = 0                    nv_daily        = ""
       nv_reccnt    = 0                    nv_completecnt  = 0
       nv_netprm_t  = 0                    nv_netprm_s     = 0
       /*nv_batbrn    = fi_branch */           nv_data         = fi_output1
       nv_notdata   = fi_output2.

    /*-- End Check Batch --*/
    RUN wgw\wgwbatch.p (INPUT        fi_loaddat ,     /* DATE  */
                        INPUT        nv_batchyr ,     /* INT   */
                        INPUT        fi_producer,     /* CHAR  */ 
                        INPUT        nv_batbrn  ,     /* CHAR  */
                        INPUT        fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                        INPUT        "WGWNLGEN" ,     /* CHAR  */
                        INPUT-OUTPUT nv_batchno ,     /* CHAR  */
                        INPUT-OUTPUT nv_batcnt  ,     /* INT   */
                        INPUT        nv_imppol  ,     /* INT   */
                        INPUT        nv_impprem       /* DECI  */
                        ).
    
    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    
    DISPLAY fi_bchno   WITH FRAME fr_main.
    
    /*--- Loop Import Policy ---*/
    
    FOR EACH wexcel:
      DELETE wexcel.
    END.
    
    FOR EACH wdelimi:
      DELETE wdelimi.
    END.
    
    /*RUN PDGenV70*//*Comment A67-0029*/

    /*-- Add A67-0029 --*/
    IF ra_type = 1 OR ra_type = 2 THEN RUN PDGenV70.
    ELSE IF ra_type = 3 OR ra_type = 4 THEN RUN PDGenV70New.
    /*-- End Add A67-0029 --*/
    
    MESSAGE COLOR YEL/RED SKIP
            "  กด Yes เพื่อ Confirm Generage Data ก/ธ 70 [NTL]   " SKIP
            "  ทั้งหมด " nt_count_pol " records" SKIP
             VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO
             TITLE "Warning Message" UPDATE choice AS LOGICAL.
    IF NOT choice THEN DO:
        MESSAGE COLOR YELLOW "ยกเลิกการ Process Data" VIEW-AS ALERT-BOX.  
        RETURN NO-APPLY.
    END.
    
    /*--- Clear Temp Data ---*/
    /* FOR EACH wgenerage:
      DELETE wgenerage.
    END.*/
    
    ASSIGN
        nv_netprm_s  = 0 nv_completecnt = 0 
        nv_rectot    = 0 nv_recsuc      = 0.
    
    /*-- Str Import Data Excel --*/
    /*RUN PDMatch100.*/
    
    /*RUN PDCheckMatch.*/

    IF ra_type = 1 OR ra_type = 2 THEN RUN PDCheckMatch.
    ELSE IF ra_type = 3 OR ra_type = 4 THEN RUN PDCheckMatchNew.
    
    /*RUN PDCreate100.*/
    /*-- End Import Data Excel --*/
    
    /*FOR EACH wgenerage WHERE wgenerage.rec_status = "Y":
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + wgenerage.prem .
    END.*/
    
    FOR EACH wexcel WHERE wexcel.policy <> "" AND wexcel.wmark = YES:
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + DECI(wexcel.netprm).
    END.
    
    nv_reccnt = nt_count_pol. 
    nv_rectot = nv_reccnt.      
    nv_recsuc = nv_completecnt. 
    
    IF nv_rectot <> nv_recsuc THEN DO: 
        nv_batflg = NO.
    END.
    /* ELSE IF nv_netprm_t <> nv_netprm_s THEN DO: 
        nv_batflg = NO.
        MESSAGE "2" VIEW-AS ALERT-BOX.
    END.*/
    ELSE IF nv_reccnt = 0 THEN DO: 
        nv_batflg = NO.
    END.
    ELSE DO: 
        nv_batflg = YES.
    END.
    
    FIND LAST uzm701 USE-INDEX uzm70102
        WHERE uzm701.bchyr  = nv_batchyr AND
              uzm701.bchno  = nv_batchno AND
              uzm701.bchcnt = nv_batcnt  NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        /***--- ไม่มีการระบุ Tax Stamp ไว้ใน Text File ---***/
        ASSIGN
            uzm701.recsuc  = nv_recsuc   
            uzm701.premsuc = nv_netprm_s 
            uzm701.rectot  = nv_rectot  
            uzm701.premtot = nv_netprm_t
            uzm701.impflg  = nv_batflg
            uzm701.cnfflg  = nv_batflg .
    
        /* YES  สามารถนำเข้าข้อมูลได้หมด ไม่มี error  
            NO   นำเข้าข้อมูลได้ไม่ได้ไม่หมด  */
    END.
    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .
    
    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE IF nv_reccnt = 0 THEN nv_txtmsg = " no record can gen..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".

    /* add by : A64-0247 */
    OPEN QUERY brquery FOR EACH wexcel WHERE wexcel.wmark = YES NO-LOCK.
    /*RUN PDShowReport.*//*Comment A67-0029*/

    IF ra_type = 1 OR ra_type = 2 THEN RUN PDShowReport.
    ELSE IF ra_type = 3 OR ra_type = 4 THEN RUN PDShowReportNew.

    RUN PDoutputScreen.
    DISPLAY fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RELEASE sic_bran.uzm701.
    RELEASE sicsyac.xmm600.
   /*..end A64-0247..*/
    
    IF nv_batflg = NO THEN DO:
    
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
        DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
    
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
                "Batch No.   : " nv_batchno             SKIP
                "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please check Data again."      
        VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".
    END.
    ELSE IF nv_batflg = YES THEN DO:
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
    
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    /* comment by : A64-0247...
    OPEN QUERY brquery FOR EACH wexcel WHERE wexcel.wmark = YES NO-LOCK.
    RUN PDShowReport.
    RUN PDoutputScreen.
    DISPLAY fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
   
    RELEASE sic_bran.uzm701.
    RELEASE sicsyac.xmm600. 
    ..end A64-0247..*/
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS     "CSV (Comma Delimited)"   "*.csv",
                            "Data Files (*.dat)"     "*.dat"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         IF ra_type = 1 THEN DO:
             ASSIGN 
             fi_filename  = cvData
             fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + "_load" + no_add + ".csv"  /*.csv*/
             fi_output2 = ""
             fi_output3 = "" .
         END.
         ELSE DO:
            ASSIGN
               fi_filename  = cvData
               fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
               fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
               fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         END.

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
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
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent C-Win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn C-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
   Run  whp\whpbrn01(Input-output  fi_branch, /*a490166 note modi*/
                     Input-output   fi_brndes).
                                     
   Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
   Apply "Entry"  To  fi_producer.
   Return no-apply.                            
                                        

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
         sicsyac.xmm600.acno  =  Input fi_agent  
    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
             MESSAGE  "Not on Name & Address Master File xmm600" 
             VIEW-AS ALERT-BOX.
             Apply "Entry" To  fi_agent.
             RETURN NO-APPLY. /*note add on 10/11/2005*/
        END.
        ELSE DO: /*note modi on 10/11/2005*/
            ASSIGN
            fi_agtname =  TRIM(TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name))
            fi_agent   =  caps(INPUT  fi_agent) /*note modi 08/11/05*/
            nv_agent   =  fi_agent.             /*note add  08/11/05*/
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_agent <> ""*/
    
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr C-Win
ON LEAVE OF fi_bchyr IN FRAME fr_main
DO:
        nv_batchyr = INPUT fi_bchyr.
        IF nv_batchyr <= 0 THEN DO:
           MESSAGE "Batch Year Error...!!!".
           APPLY "entry" TO fi_bchyr.
           RETURN NO-APPLY.
        END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  IF  INPUT fi_branch  =  ""  Then do:
       MESSAGE "กรุณาระบุ Branch Code ." VIEW-AS ALERT-BOX.
       APPLY "Entry"  TO  fi_branch.
  END.
  ELSE DO:
      FIND sicsyac.xmm023  USE-INDEX xmm02301 WHERE
           sicsyac.xmm023.branch   =  INPUT  fi_branch 
      NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL  sicsyac.xmm023 THEN DO:
             MESSAGE  "Not on Description Master File xmm023" 
             VIEW-AS ALERT-BOX.
             APPLY "Entry"  TO  fi_branch.
             RETURN NO-APPLY.
      END.
      fi_branch  =  CAPS(INPUT fi_branch) .
      fi_brndes  =  sicsyac.xmm023.bdes.
  END. /*else do:*/

  DISP fi_branch  fi_brndes  WITH FRAME  fr_main.

  nv_branch = fi_branch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camptruck
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camptruck C-Win
ON LEAVE OF fi_camptruck IN FRAME fr_main
DO:
    fi_camptruck = INPUT fi_camptruck.
    DISP fi_camptruck WITH FRAME fr_main .
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispyr C-Win
ON LEAVE OF fi_ispyr IN FRAME fr_main
DO:
    fi_ispyr = INPUT fi_ispyr .
    DISP fi_ispyr WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  Input  fi_loaddat.
  Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_package
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_package C-Win
ON LEAVE OF fi_package IN FRAME fr_main
DO:
  fi_package = CAPS(INPUT fi_package).
  DISP fi_package WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_package C-Win
ON RETURN OF fi_package IN FRAME fr_main
DO:
  fi_package = CAPS(INPUT fi_package).
  DISP fi_package WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat C-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = CAPS(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) <> 13 THEN DO:
             MESSAGE "Length Of Batch no. Must Be 13 Character " SKIP
                     "Please Check Batch No. Again             " view-as alert-box.
             APPLY "entry" TO fi_prevbat.
             RETURN NO-APPLY.
        END.
    END. /*nv_batprev <> " "*/
    
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer.
  IF  fi_producer <> " " THEN DO:
  FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
       sicsyac.xmm600.acno  =  INPUT fi_producer  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
                MESSAGE  "Not on Name & Address Master File xmm600" VIEW-AS ALERT-BOX.
                Apply "Entry" To  fi_producer.
                RETURN NO-APPLY. /*note add on 10/11/2005*/
            END.
            ELSE DO:
                ASSIGN
                fi_proname  =  TRIM(TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name))
                fi_producer =  CAPS(INPUT  fi_producer) /*note modi 08/11/05*/
                nv_ACNO1    = fi_producer .             /*note add  08/11/05*/
            END.
  END.
  DISP  fi_producer  fi_proname  WITH Frame  fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt C-Win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem C-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
    ra_type = INPUT ra_type.
    DISP ra_type WITH FRAME fr_main .

    IF ra_type = 1 THEN DO:
        ENABLE fi_txt WITH FRAME fr_main.
        ENABLE fi_ispyr WITH FRAME fr_main.
    END.
    ELSE DO:
        HIDE fi_txt .
        HIDE fi_ispyr .
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
  
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.


/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WGWNLGEN".
  gv_prog  = "Load Text File NTL Motor".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.

  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/

  RUN  WUT\WUTWICEN (c-win:handle).  
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN
      /*fi_branch   = "M"  */  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_branch   = "ML"   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
     /* fi_producer = "B3M0040"     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
        fi_agent    = "B3M0040"*/   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
     fi_producer =  "B3MLNTL101"   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
     fi_agent    =  "B3MLNTL100"   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 

      fi_bchyr    = YEAR(TODAY)
      /*fi_comm     = "3"*/
      /*fi_campaign = "C59/00531".
      comment by Chaiyong W. A61-0016 09/02/2018*/
      /*fi_campaign  = "C61/00012"    /*--add by Chaiyong W. A61-0016 09/02/2018*/*/ /*A65-0203*/
      /* a64-0247*/
      fi_camptruck  = "CAMP_NTL" /*A65-0203*/
      ra_type      = 1              
      fi_txt       = "Inspection Year :"
      fi_ispyr     = STRING(YEAR(TODAY),"9999") .  
      /* end a64-0247*/

  FIND sicsyac.xmm023 USE-INDEX xmm02301 WHERE
       sicsyac.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
  IF AVAIL xmm023 THEN DO:
      fi_brndes = xmm023.bdes.
  END.

  /*------------ Piyachat A57-0078 ----------------*/
  FIND sicsyac.xmm600 USE-INDEX xmm60001  WHERE                                                        
       sicsyac.xmm600.acno  = fi_producer AND 
       sicsyac.xmm600.acno  = fi_agent    NO-LOCK NO-ERROR NO-WAIT.                                
       IF AVAIL sicsyac.xmm600 THEN DO: 
           fi_proname  =  TRIM(sicsyac.xmm600.name).
           fi_agtname  =  TRIM(sicsyac.xmm600.name).  
           nv_ACNO1    =  fi_producer.  
           nv_agent    =  fi_agent.
       END.
  /*------------------------------------------------*/

  DISP fi_branch  fi_producer fi_proname fi_agent 
       fi_agtname fi_bchyr    /*fi_comm */   fi_brndes 
       /*ra_type    fi_vehuse   fi_mn30  */ /*fi_campaign  A65-0203 */ 
       ra_type fi_txt fi_ispyr /*A64-0247*/
       fi_camptruck /* A65-0203*/  WITH FRAME fr_main.
/*********************************************************************/  
  
  /*fi_package = "Z".*/   /*A64-0247*/
  fi_package = "T" .      /*A64-0247*/
  DISP fi_package WITH FRAME fr_main.

  APPLY "ENTRY" TO fi_branch IN FRAME fr_main.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDCampaign C-Win 
PROCEDURE 00-PDCampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Comment by : Ranu I. A65-0203...
DEF VAR nv_camp1 AS CHAR INIT "".  /*---add by Chaiyong W. A61-0015 14/03/2018*/
DEF VAR nv_year  AS CHAR INIT "".
DEF VAR nv_camp2 AS CHAR INIT "".
IF wexcel.campaign <> "" THEN DO:  
    /*---Begin by chaiyong W. A61-0015 14/03/2018*/
    
    nv_camp1 = trim(wexcel.campaign).
                   
    IF TRIM(wexcel.covcod) = "1"  THEN DO:
       
        IF wexcel.body = "PIckUP" THEN nv_camp1  = TRIM(wexcel.campaign) + "PICK".
        ELSE IF wexcel.body = "VAN" THEN nv_camp1 = TRIM(wexcel.campaign) + "VAN".
        ELSE nv_camp1  = TRIM(wexcel.campaign) + "GRP" + wexcel.vehgrp.
        nv_camp1 = nv_camp1 + wexcel.garage.
       /*
      nv_year  = "YR" + STRING((YEAR(DATE(wexcel.comdat)) - INT(wexcel.yrmanu)) + 1).*/
       /*
      nv_camp1 = nv_camp1 + nv_year.*/

    END.

    /*
    IF wexcel.policy = "DM7061NL1540" THEN MESSAGE wexcel.policy nv_camp1 "TEST".*/
    /*End by chaiyong W. A61-0015 14/03/2018-----*/
    /*
      MESSAGE wexcel.campaign 
                wexcel.covcod   
                wexcel.sclass   
                wexcel.si
                nv_cc    .      */
   
     FIND FIRST brstat.campaign WHERE 
         /*--
               brstat.campaign.tltc   = wexcel.campaign   AND
         comment by chaiyong W. A61-0015 14/03/2018*/
         brstat.campaign.tltc   = nv_camp1   AND /*--add  by chaiyong W. A61-0015 14/03/2018*/
               brstat.campaign.usrid  = "NTL"             AND
               brstat.campaign.covcod = wexcel.covcod     AND
               brstat.campaign.CLASS  = wexcel.sclass     AND
               brstat.campaign.garage = wexcel.garage     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL brstat.campaign THEN DO:
        CREATE wexcamp.
        ASSIGN
            wexcamp.policy = wexcel.policy
            wexcamp.tp_bi1 = brstat.campaign.baseprm   
            wexcamp.tp_bi2 = brstat.campaign.fleet     
            wexcamp.tp_pd  = brstat.campaign.dspc      
            wexcamp.pa411  = brstat.campaign.mv1       
            wexcamp.pa412  = brstat.campaign.mv1s      
            wexcamp.pa42   = brstat.campaign.mv2       
            wexcamp.pa43   = brstat.campaign.mv3. 
                           /*---
        IF wexcel.sclass = "110" THEN DO:
            IF wexcel.engine <= "2000" THEN DO:
                nv_cc = "2000".
            END.
            ELSE IF wexcel.engine > "2000" THEN DO:
                nv_cc = "2001".
            END.
        END.
        ELSE nv_cc = "". 
        
        comment by Chaiyong W. A61-0015 19/03/2018*/
                               /*
        MESSAGE wexcel.campaign 
                wexcel.covcod   
                wexcel.sclass   
                wexcel.si
                nv_cc    .      */  

        /*---Begin by chaiyong W. A61-0015 14/03/2018*/
        IF wexcel.sclass = "110" THEN DO:
            IF INT(wexcel.engine) <= 2000 THEN DO:
                nv_cc = "2000".
            END.
            ELSE IF int(wexcel.engine) > 2000 THEN DO:
                nv_cc = "2001".
            END.
        END.
        ELSE nv_cc = "". 
    
        nv_camp1 = trim(wexcel.campaign).
        IF TRIM(wexcel.covcod) = "1"  THEN DO:
            IF wexcel.body = "PIckUP" THEN nv_camp1  = TRIM(wexcel.campaign) + "PICK".
            ELSE IF wexcel.body = "VAN" THEN nv_camp1 = TRIM(wexcel.campaign) + "VAN".
            ELSE nv_camp1  = TRIM(wexcel.campaign) + "GRP" + wexcel.vehgrp.
            nv_year  = "YR" + STRING((YEAR(DATE(wexcel.comdat)) - INT(wexcel.yrmanu)) + 1).
            nv_camp1 = nv_camp1 + nv_year.
            nv_camp1 = nv_camp1 + trim(wexcel.garage).
            
    
        END.
        ELSE nv_camp1 = wexcel.campaign .
        /*End by chaiyong W. A61-0015 14/03/2018-----*/
/*

        IF wexcel.policy = "DM7061NL1726" THEN MESSAGE nv_camp1 SKIP wexcel.covcod SKIP wexcel.sclass   SKIP wexcel.si   SKIP nv_cc   .
  */
        FIND FIRST brstat.campaign WHERE
            /*---
                   brstat.campaign.tltc   = wexcel.campaign + "NTL" AND
                     comment by chaiyong W. A61-0015 14/03/2018*/
         brstat.campaign.tltc   = nv_camp1  + "NTL" AND /*--add  by chaiyong W. A61-0015 14/03/2018*/
                   brstat.campaign.covcod = wexcel.covcod                 AND
                   brstat.campaign.CLASS  = wexcel.sclass                 AND
                   brstat.campaign.mv1    = INTE(wexcel.si)               AND
                   brstat.campaign.garage = nv_cc
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.campaign THEN DO:

            ASSIGN
                /*---
                wexcamp.ncb   = STRING(brstat.campaign.comp_prm)
                comment by Chaiyong W. A61-0015 15/02/2018*/

                /*----Begin by Chaiyong W. A61-0015 15/02/2018*/       
                wexcamp.base2  = trim(STRING(brstat.campaign.mv1s))
                wexcamp.ncb    = trim(STRING(brstat.campaign.mv2))
                wexcamp.loadcl = TRIM(STRING(brstat.campaign.mv3))
                /*End by Chaiyong W. A61-0015 15/02/2018------*/
                wexcamp.fleet = STRING(brstat.campaign.fleet)
                wexcamp.base1 = STRING(brstat.campaign.baseprm)
                wexcamp.dspc  = STRING(brstat.campaign.dspc).
            
        END.  
    END.  
    ELSE DO:
        FIND FIRST brstat.campaign WHERE
                   /*--
                   brstat.campaign.tltc   = TRIM(wexcel.campaign)   AND
                   comment by chaiyong W. A61-0015 14/03/2018*/
                   brstat.campaign.tltc   = nv_camp1 AND /*--add  by chaiyong W. A61-0015 14/03/2018*/
                   brstat.campaign.usrid  = "NTL"             AND
                   brstat.campaign.covcod = wexcel.covcod     AND
                   brstat.campaign.CLASS  = wexcel.sclass     NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.campaign THEN DO:
            CREATE wexcamp.
            ASSIGN
                wexcamp.policy = wexcel.policy
                wexcamp.tp_bi1 = brstat.campaign.baseprm
                wexcamp.tp_bi2 = brstat.campaign.fleet  
                wexcamp.tp_pd  = brstat.campaign.dspc   
                wexcamp.pa411  = brstat.campaign.mv1    
                wexcamp.pa412  = brstat.campaign.mv1s   
                wexcamp.pa42   = brstat.campaign.mv2    
                wexcamp.pa43   = brstat.campaign.mv3.

            /*--
            IF wexcel.sclass = "110" THEN DO:
                IF wexcel.engine <= "2000" THEN DO:
                    nv_cc = "2000".
                END.
                ELSE IF wexcel.engine > "2000" THEN DO:
                    nv_cc = "2001".
                END.
            END.
            ELSE nv_cc = "".
            comment by Chaiyong W. A61-0015 19/03/2018*/

            /*---Begin by chaiyong W. A61-0015 14/03/2018*/
            IF wexcel.sclass = "110" THEN DO:
                IF INT(wexcel.engine) <= 2000 THEN DO:
                    nv_cc = "2000".
                END.
                ELSE IF int(wexcel.engine) > 2000 THEN DO:
                    nv_cc = "2001".
                END.
            END.
            ELSE nv_cc = "". 
    
            nv_camp1 = trim(wexcel.campaign).
            IF TRIM(wexcel.covcod) = "1" THEN DO:
                IF wexcel.body = "PIckUP" THEN nv_camp1  = TRIM(wexcel.campaign) + "PICK".
                ELSE IF wexcel.body = "VAN" THEN nv_camp1 = TRIM(wexcel.campaign) + "VAN".
                ELSE nv_camp1  = TRIM(wexcel.campaign) + "GRP" + wexcel.vehgrp.
                nv_year  = "YR" + STRING((YEAR(DATE(wexcel.comdat)) - INT(wexcel.yrmanu)) + 1).
                nv_camp1 = nv_camp1  + nv_year.
                nv_camp1 = nv_camp1 + wexcel.garage.
                
        
            END.
            ELSE nv_camp1 = wexcel.campaign .
            nv_camp1 = TRIM(nv_camp1).
                                                                         /*
            IF wexcel.policy = "DM7061NL1124"  THEN MESSAGE nv_camp1 . */
            /*End by chaiyong W. A61-0015 14/03/2018-----*/

            FIND FIRST brstat.campaign WHERE
                /*---
                brstat.campaign.tltc   = TRIM(wexcel.campaign) + "NTL" AND
                comment by chaiyong W. A61-0015 14/03/2018*/
                      brstat.campaign.tltc   = nv_camp1  + "NTL" AND /*--add  by chaiyong W. A61-0015 14/03/2018*/
                       brstat.campaign.covcod = wexcel.covcod                 AND
                       brstat.campaign.CLASS  = wexcel.sclass                 AND
                       brstat.campaign.mv1    = INTE(wexcel.si)               AND
                       brstat.campaign.garage = nv_cc
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.campaign THEN DO:
                ASSIGN
                    /*---
                    wexcamp.ncb   = STRING(brstat.campaign.comp_prm)
                    comment by Chaiyong W. A61-0015 15/02/2018*/
                    /*----Begin by Chaiyong W. A61-0015 15/02/2018*/       
                    wexcamp.base2  = trim(STRING(brstat.campaign.mv1s))
                    wexcamp.ncb    = trim(STRING(brstat.campaign.mv2))
                    wexcamp.loadcl = TRIM(STRING(brstat.campaign.mv3))
                    /*End by Chaiyong W. A61-0015 15/02/2018------*/

                    wexcamp.fleet = STRING(brstat.campaign.fleet)
                    wexcamp.base1 = STRING(brstat.campaign.baseprm)
                    wexcamp.dspc  = STRING(brstat.campaign.dspc).
            END.
        END.
        ELSE DO:
            FIND FIRST brstat.campaign WHERE
                /*--
                       brstat.campaign.tltc   = wexcel.campaign   AND
                                comment by chaiyong W. A61-0015 14/03/2018*/
                       brstat.campaign.tltc   = nv_camp1 AND /*--add  by chaiyong W. A61-0015 14/03/2018*/
                       brstat.campaign.usrid  = "NTL"             AND
                       brstat.campaign.covcod = wexcel.covcod     AND
                       brstat.campaign.CLASS  = "All"             
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.campaign THEN DO:
                CREATE wexcamp.
                ASSIGN
                    wexcamp.policy = wexcel.policy
                    wexcamp.tp_bi1 = brstat.campaign.baseprm
                    wexcamp.tp_bi2 = brstat.campaign.fleet  
                    wexcamp.tp_pd  = brstat.campaign.dspc   
                    wexcamp.pa411  = brstat.campaign.mv1    
                    wexcamp.pa412  = brstat.campaign.mv1s   
                    wexcamp.pa42   = brstat.campaign.mv2    
                    wexcamp.pa43   = brstat.campaign.mv3.   

                /*---
                IF wexcel.sclass = "110" THEN DO:
                    IF wexcel.engine <= "2000" THEN DO:
                        nv_cc = "2000".
                    END.
                    ELSE IF wexcel.engine > "2000" THEN DO:
                        nv_cc = "2001".
                    END.
                END.
                ELSE nv_cc = "".
                comment by Chaiyong W. A61-0015 19/03/2018*/
               
                /*---Begin by chaiyong W. A61-0015 14/03/2018*/
                IF wexcel.sclass = "110" THEN DO:
                    IF INT(wexcel.engine) <= 2000 THEN DO:
                        nv_cc = "2000".
                    END.
                    ELSE IF int(wexcel.engine) > 2000 THEN DO:
                        nv_cc = "2001".
                    END.
                END.
                ELSE nv_cc = "". 
    
                nv_camp1 = trim(wexcel.campaign).
                IF TRIM(wexcel.covcod) = "1"  THEN DO:
                    IF wexcel.body = "PIckUP" THEN nv_camp1  = TRIM(wexcel.campaign) + "PICK".
                    ELSE IF wexcel.body = "VAN" THEN nv_camp1 = TRIM(wexcel.campaign) + "VAN".
                    ELSE nv_camp1  = TRIM(wexcel.campaign) + "GRP" + wexcel.vehgrp.
                    nv_year  = "YR" + STRING((YEAR(DATE(wexcel.comdat)) - INT(wexcel.yrmanu)) + 1).
                    nv_camp1 = nv_camp1  + nv_year.
                    nv_camp1 = nv_camp1 + wexcel.garage.
                   
            
                END.
                ELSE nv_camp1 = wexcel.campaign .
                nv_camp1 = TRIM(nv_camp1).
                                                                             /*
                IF wexcel.policy = "DM7061NL1124"  THEN MESSAGE nv_camp1 . */
                /*End by chaiyong W. A61-0015 14/03/2018-----*/
                FIND FIRST brstat.campaign WHERE
                    /*---
                           brstat.campaign.tltc   = TRIM(wexcel.campaign) + "NTL" AND
                                    comment by chaiyong W. A61-0015 14/03/2018*/
                      brstat.campaign.tltc   = nv_camp1  + "NTL" AND /*--add  by chaiyong W. A61-0015 14/03/2018*/
                           brstat.campaign.covcod = wexcel.covcod                 AND
                           brstat.campaign.CLASS  = wexcel.sclass                 AND
                           brstat.campaign.mv1    = INTE(wexcel.si)               AND
                           brstat.campaign.garage = nv_cc
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL brstat.campaign THEN DO:
                    ASSIGN
                       /*---
                       wexcamp.ncb   = STRING(brstat.campaign.comp_prm)
                       comment by Chaiyong W. A61-0015 15/02/2018*/
                       /*----Begin by Chaiyong W. A61-0015 15/02/2018*/       
                       wexcamp.base2  = trim(STRING(brstat.campaign.mv1s))
                       wexcamp.ncb    = trim(STRING(brstat.campaign.mv2))
                       wexcamp.loadcl = TRIM(STRING(brstat.campaign.mv3))
                       /*End by Chaiyong W. A61-0015 15/02/2018------*/
                        wexcamp.fleet = STRING(brstat.campaign.fleet)
                        wexcamp.base1 = STRING(brstat.campaign.baseprm)
                        wexcamp.dspc  = STRING(brstat.campaign.dspc).
                END.
            END.
            ELSE DO:
                ASSIGN
                    wexcel.werror = "Campaign2 Error"
                    wexcel.wmark  = NO.
            END.
        END.
    END.

END.
ELSE DO:
    ASSIGN
        wexcel.werror = "Campaign Error"
        wexcel.wmark  = NO.
END.
..end A65-0203...*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDChangeData C-Win 
PROCEDURE 00-PDChangeData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : Ranu I. A65-0203....
RUN PDChkChassis.

/*-- Check Branch --*/
/*
IF wexcel.brncod <> "" THEN DO:
    FIND FIRST stat.insure WHERE
               stat.insure.compno = "NTL" AND
               stat.insure.insno  = TRIM(wexcel.brncod) NO-LOCK NO-ERROR.
    IF AVAIL stat.insure THEN DO:
        wexcel.brnsty = stat.insure.branch.
    END.
    ELSE wexcel.brnsty = "M".
END.
ELSE wexcel.brnsty = "M".*/
ASSIGN wexcel.brnsty =  "ML".  /*A63-00472*/


/*-- Check Name --*/
IF wexcel.ntitle <> "" THEN DO:
    wexcel.ntitle = TRIM(wexcel.ntitle).
END.
ELSE wexcel.ntitle = "".

IF wexcel.fname + wexcel.lname <> "" THEN DO:
    wexcel.fname = TRIM(TRIM(wexcel.fname) + " " + TRIM(wexcel.lname)).
END.


/*----
/*-- Check Cedpol --*/
IF wexcel.cedpol <> "" THEN DO:
    wexcel.policy = "NTL" + TRIM(SUBSTR(wexcel.cedpol,9,12)).
END.
ELSE DO:
    wexcel.policy = "NTL" + STRING(DAY(TODAY),"99") + STRING(MONTH(TODAY),"99") +
                    SUBSTR(STRING(YEAR(TODAY),"9999"),3,2) + "/" + STRING(nv_running + 1,"99999").
END.  
comment by Chaiyong W. A59-0614 02/05/2017---*/
wexcel.policy = wexcel.newpol. /*---add by Chaiyong W. A59-0614 02/05/2017*/
wexcel.cedpol = REPLACE(wexcel.cedpol," ","").

/*--
IF INDEX(wexcel.cedpol,"NTL-") = 1 THEN DO:
    wexcel.cedpol = trim(SUBSTR(wexcel.cedpol,5)).
END. Chaiyong W. A60-0016 21/01/2019*/

/* comment by : Ranu I. A65-0203 ....
/*-- sclass --*/
IF wexcel.sclass = "" THEN DO:
    IF wexcel.body = "เก๋ง" THEN wexcel.sclass = "110".
    ELSE IF wexcel.body = "กระบะ" THEN wexcel.sclass = "210".
    ELSE IF wexcel.body = "บรรทุก" THEN wexcel.sclass = "320".
END.
ELSE wexcel.sclass = TRIM(wexcel.sclass).
...end A65-0203..*/

/*-- Vehreg No. --*/
IF wexcel.provin <> "" THEN DO:
    FIND FIRST brstat.insure WHERE
               brstat.insure.compno = "999" AND
               brstat.insure.fname  = TRIM(wexcel.provin) NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        IF wexcel.vehreg <> "" THEN DO:
            wexcel.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(brstat.insure.lname).
        END.
    END.
    ELSE wexcel.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(wexcel.provin). /*----add by Chaiyong W. A59-0614 27/04/2017*/
END.

/*---Begin by Chaiyong W. A59-0614 18/07/2017*/
wexcel.modcod = TRIM(wexcel.modcod).
IF wexcel.modcod <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
               stat.maktab_fil.sclass = wexcel.sclass AND
               stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            wexcel.modcod = stat.maktab_fil.modcod
            wexcel.seat   = STRING(stat.maktab_fil.seats)
            wexcel.vehgrp = stat.maktab_fil.prmpac.
    END.
    ELSE DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                   stat.maktab_fil.sclass = "****" AND
                   stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            ASSIGN
                wexcel.modcod = stat.maktab_fil.modcod
                wexcel.seat   = STRING(stat.maktab_fil.seats)
                wexcel.vehgrp = stat.maktab_fil.prmpac.
        END.
        ELSE wexcel.modcod = "".
    END.

    IF wexcel.modcod <> "" THEN DO:
        IF wexcel.seat = "" THEN DO:
            IF wexcel.sclass = "110" THEN DO: 
                ASSIGN
                    wexcel.seat   = "7"
                    wexcel.vehuse = "1".
            END.
            ELSE IF wexcel.sclass = "210" THEN DO:
                ASSIGN
                    wexcel.seat   = "12"
                    wexcel.vehuse = "1".
            END.
            ELSE IF wexcel.sclass = "320" THEN DO:
                ASSIGN
                    wexcel.seat   = "3"
                    wexcel.vehuse = "2".
            END.
        END.
        
        IF wexcel.vehuse = "" THEN DO:
            wexcel.vehuse = SUBSTR(wexcel.sclass,2,1).
        END.
        /*---Begin by Chaiyong W. A59-0614 27/04/2017*/
        IF TRIM(wexcel.sclass) = "320" THEN DO:
            IF wexcel.body = "บรรทุก" OR wexcel.body = "รถบรรทุก" OR  wexcel.body = "Truck" THEN wexcel.vehuse = "2".
            ELSE IF wexcel.body = "กระบะ" OR  wexcel.body = "Pickup" OR  wexcel.body = "minitruck" THEN wexcel.vehuse = "1".
            ELSE wexcel.vehuse = "1".
        END.
    END.

END.
IF wexcel.modcod = "" THEN DO:
/*End by Chaiyong W. A59-0614 18/07/2017-----*/
    /*-- Redbook Code --*/
    nv_lencod = LENGTH(wexcel.moddes) - 4.
    
    IF wexcel.moddes <> "" THEN DO:
        wexcel.modcod = SUBSTR(wexcel.moddes,nv_lencod + 1,4).
        wexcel.modcod = TRIM(SUBSTR(wexcel.makdes,1,4)) + TRIM(wexcel.modcod).
    END.
    ELSE wexcel.modcod = "".
    
    RUN PDChkRedbook.
END. /*---add end by Chaiyong W. A59-614 18/07/2017*/
/*-- Driver Age --*/
IF wexcel.driname = "ระบุผู้ขับขี่" THEN DO:
    IF wexcel.dribir1 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir1)) > YEAR(TODAY) THEN DO:
            wexcel.driage1 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir1)) - 543).
        END.
        ELSE wexcel.driage1 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir1)).
    END.

    IF wexcel.dribir2 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir2)) > YEAR(TODAY) THEN DO:
            wexcel.driage2 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir2)) - 543).
        END.
        ELSE wexcel.driage2 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir2)).
    END.

    IF wexcel.drinam1 <> "" AND wexcel.drinam2 <> "" THEN DO:
        wexcel.driname = "2".
    END.
    ELSE IF wexcel.drinam1 <> "" AND wexcel.drinam2 = "" THEN DO: 
        wexcel.driname = "1".
    END.
END.

/*-- Cover Type --*/
IF wexcel.covcod = "2+" THEN DO:
    wexcel.covcod = "2.2".
END.
ELSE IF wexcel.covcod = "3+" THEN DO:
    wexcel.covcod = "3.2".
END.

/*-- Garage --*/
IF wexcel.garage = "ห้าง" THEN wexcel.garage = "".
ELSE IF wexcel.garage = "อู่" THEN wexcel.garage = "G".

RUN PDCampaign.*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDChkBase C-Win 
PROCEDURE 00-PDChkBase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
IF LENGTH(TRIM(sic_bran.uwm301.covcod)) = 1 AND INDEX(sic_bran.uwm301.covcod,".") = 0 THEN DO:
    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
              sicsyac.xmm106.tariff  = "X"                    AND
              sicsyac.xmm106.bencod  = "BASE"                 AND
              sicsyac.xmm106.CLASS   = sic_bran.uwm120.CLASS  AND
              sicsyac.xmm106.covcod  = sic_bran.uwm301.covcod AND
              sicsyac.xmm106.key_b  >= nv_key_b               AND
              sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        ASSIGN
            nv_base_max = sicsyac.xmm106.max_ap
            nv_base_min = sicsyac.xmm106.min_ap
            nv_baseprm1 = sicsyac.xmm106.min_ap.
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
              sicsyac.xmm106.tariff  = "X"                    AND
              sicsyac.xmm106.bencod  = "BASE"                 AND
              sicsyac.xmm106.CLASS   = sic_bran.uwm120.CLASS  AND
              sicsyac.xmm106.covcod  = sic_bran.uwm301.covcod AND
              sicsyac.xmm106.key_b  >= nv_key_b               AND
              sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        ASSIGN
            nv_base_max = sicsyac.xmm106.max_ap
            nv_base_min = sicsyac.xmm106.min_ap
            nv_baseprm1 = sicsyac.xmm106.min_ap.
    END.

    IF sic_bran.uwm301.covcod = "2.1" THEN nv_basecod3 = "BA21".
    ELSE IF sic_bran.uwm301.covcod = "2.2" THEN nv_basecod3 = "BA22".
    ELSE IF sic_bran.uwm301.covcod = "3.1" THEN nv_basecod3 = "BA31".
    ELSE IF sic_bran.uwm301.covcod = "3.2" THEN nv_basecod3 = "BA32".
    ELSE nv_basecod3 = "".

    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
              sicsyac.xmm106.tariff  = "X"                    AND
              sicsyac.xmm106.bencod  = nv_basecod3            AND
              sicsyac.xmm106.CLASS   = sic_bran.uwm120.CLASS  AND
              sicsyac.xmm106.covcod  = sic_bran.uwm301.covcod AND
              sicsyac.xmm106.key_b  >= nv_key_b               AND
              sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        ASSIGN
            nv_base_max_p = sicsyac.xmm106.max_ap
            nv_base_min_p = sicsyac.xmm106.min_ap
            nv_baseprm2   = sicsyac.xmm106.min_ap.
    END.
    
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDChkENG C-Win 
PROCEDURE 00-PDChkENG :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: USOENG      
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
/*--
IF SUBSTRING(TRIM(nv_sclass),1,1) <> "1" AND
   SUBSTRING(TRIM(nv_sclass),1,1) <> "6" AND
   SUBSTRING(TRIM(nv_sclass),1,1) <> "7"
THEN DO:
    IF SUBSTRING(TRIM(nv_sclass),1,1) <> "2" THEN DO:
        IF SUBSTRING(TRIM(nv_sclass),1,1) <> "8" THEN DO:
            nv_engcod = "ENGT".
        END.
        ELSE DO:
            IF TRIM(nv_sclass) = "801" THEN nv_engcod = "ENG".
            IF TRIM(nv_sclass) = "802" THEN nv_engcod = "ENGC".
            IF TRIM(nv_sclass) = "803" OR TRIM(nv_sclass) = "804"
            OR TRIM(nv_sclass) = "805" THEN nv_engcod = "ENGT".
        END.
    END.
    ELSE nv_engcod = "ENGS".
END.
ELSE nv_engcod = "ENGC".
comment by Chaiyon W. A614-0016 12/03/2018---*/
IF SUBSTRING(TRIM(nv_sclass),2,1) <> "1" AND
   SUBSTRING(TRIM(nv_sclass),2,1) <> "6" AND
   SUBSTRING(TRIM(nv_sclass),2,1) <> "7"
THEN DO:
    IF SUBSTRING(TRIM(nv_sclass),2,1) <> "2" THEN DO:
        IF SUBSTRING(TRIM(nv_sclass),2,1) <> "8" THEN DO:
            nv_engcod = "ENGT".
        END.
        ELSE DO:
            IF SUBSTRING(TRIM(nv_sclass),2,3) = "801" THEN nv_engcod = "ENG".
            IF SUBSTRING(TRIM(nv_sclass),2,3) = "802" THEN nv_engcod = "ENGC".
            IF SUBSTRING(TRIM(nv_sclass),2,3) = "803" OR SUBSTRING(TRIM(nv_sclass),2,3)= "804"
            OR SUBSTRING(TRIM(nv_sclass),2,3) = "805" THEN nv_engcod = "ENGT".
        END.
    END.
    ELSE nv_engcod = "ENGS".
END.
ELSE nv_engcod = "ENGC".
/*End by Chaiyong W.   A61-0016 12/03/2018 */

IF nv_engcod <> "" THEN DO:
    IF nv_engcod = "ENGC" THEN DO:
        ASSIGN nv_engvar   = " "
               nv_engcod   = "ENGC"
               nv_engvar1  = "     Vehicle CC. = "
               nv_engvar2  =  STRING (nv_engine)
               SUBSTRING(nv_engvar,1,30)   = nv_engvar1
               SUBSTRING(nv_engvar,31,30)  = nv_engvar2.
    END.
    ELSE IF nv_engcod = "ENGS" THEN DO:
        ASSIGN nv_engvar   = " "
               nv_engcod   = "ENGS"
               nv_engvar1  = "     Vehicle Seats = "
               nv_engvar2  = STRING(nv_seats)
               SUBSTRING(nv_engvar,1,30)  = nv_engvar1
               SUBSTRING(nv_engvar,31,30) = nv_engvar2.
    END.
    ELSE IF nv_engcod  = "ENGT" THEN DO:
        ASSIGN nv_engvar  = " "
               nv_engcod  = "ENGT"
               nv_engvar1 = "     Vehicle Tons. = "
               nv_engvar2 =  STRING(nv_tons)
               SUBSTRING(nv_engvar,1,30)  = nv_engvar1
               SUBSTRING(nv_engvar,31,30) = nv_engvar2.
    END.
END.
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDChkGenPA C-Win 
PROCEDURE 00-PDChkGenPA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
FIND FIRST wexcamp WHERE wexcamp.policy = wexcel.policy NO-LOCK NO-ERROR.
IF AVAIL wexcamp THEN DO:
    IF wexcamp.pa411 <> 0 AND wexcamp.pa411 <> ? THEN DO:
        ASSIGN
            nv_41cod1 = "411"
            nv_41cod2 = "412"
            nv_chkpa  = 1.
    
        /*-- 411 --*/
        nv_bencod = nv_41cod1.
        nv_prem   = wexcamp.pa411.
    
        RUN PDChkTariffPA.
        nv_411prm = nv_prem.
    
        /*-- 412 --*/
        nv_bencod = nv_41cod2.
        nv_prem   = wexcamp.pa412.
    /*
         MESSAGE nv_prem SKIP nv_seat41 SKIP nv_key_b  VIEW-AS ALERT-BOX.*/
        RUN PDChkTariffPA.
        nv_412prm = nv_prem.                                                   /*--
        MESSAGE nv_412prm VIEW-AS ALERT-BOX.                                 */
    END.
    ELSE DO:
        nv_411prm = 0.
        nv_412prm = 0.
    END.
    
    IF wexcamp.pa42 <> 0 AND wexcamp.pa42 <> ? THEN DO:
        ASSIGN
            nv_42cod = "42"
            nv_chkpa = 2.
    
        nv_bencod = nv_42cod.
        nv_key_b  = wexcamp.pa42.
        nv_prem   = wexcamp.pa42.
    
        RUN PDChkTariffPA.
        nv_42prm = nv_prem.
    END.
    ELSE nv_42prm = 0.
    
    IF wexcamp.pa43 <> 0 AND wexcamp.pa43 <> ? THEN DO:
        ASSIGN
            nv_43cod = "43"
            nv_chkpa = 1.
    
        nv_bencod = nv_43cod.
        nv_prem   = wexcamp.pa43.
    
        RUN PDChkTariffPA.
        nv_43prm = nv_prem.
    
    END.
    ELSE nv_43prm = 0.
END.
ELSE DO:
    ASSIGN
        wexcel.werror = "ไม่พบความคุ้มครอง"
        wexcel.wmark  = NO.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDChkPrem C-Win 
PROCEDURE 00-PDChkPrem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
FIND FIRST wexcamp WHERE wexcamp.policy = wexcel.policy NO-LOCK NO-ERROR.
IF AVAIL wexcamp THEN DO:
    ASSIGN
        nv_flet_per = DECI(wexcamp.fleet)
        nv_ncbper   = DECI(wexcamp.ncb)
        nv_dss_per  = DECI(wexcamp.dspc)
        nv_cl_per   = DECI(wexcamp.loadcl).
    nv_cl_per = nv_cl_per / 100. /*---add by Chaiyong W. A61-0015 16/03/2018*/
END.
ELSE DO:
    ASSIGN
        nv_flet_per = 0
        nv_ncbper   = 0
        nv_dss_per  = 0
        nv_cl_per   = 0.
END.

/*----Begin by Chaiyong W. A59-0614 02/05/2017*/
/*---
IF np_prepol <> "" THEN DO:
    IF index(sic_bran.uwm100.name1,np_name1) <> 0  THEN DO:
        nv_flet_per   = DECIMAL(Trim(np_flet_per)) NO-ERROR .
        nv_ncbper     = DECIMAL(Trim(np_ncbper  )) NO-ERROR .
        nv_dss_per    = DECIMAL(Trim(np_dss_per )) NO-ERROR .
        ASSIGN
            nv_stf_per    = np_stf_per 
            nv_cl_per     = np_cl_per  .
                
    END.
END. comment by Chaiyong W. A61-0016 22/03/2018---*/
/*End by Chaiyong W. A59-0614 02/05/2017-----*/



IF nv_baseprm1 <> 0  AND nv_usecod  <> "" AND
   nv_engcod   <> "" AND nv_drivcod <> "" AND
   nv_yrcod    <> "" AND nv_sicod   <> "" AND
   nv_grpcod   <> "" AND nv_bipcod  <> "" AND
   nv_biacod   <> "" AND nv_pdacod  <> "" THEN DO:

    /*-- Base 1 --*/
    nv_prvprm = nv_baseprm1.
    nv_prem1  = nv_baseprm1.

    /*-- Base 3 --*/
    nv_prvprm3 = nv_baseprm2.
    nv_prem3   = nv_baseprm2.

    IF nv_usecod <> "" THEN DO:  /*VEHICLE USE 1*/
        nv_chkpa = 3.
        nv_bencod = nv_usecod.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem1  = nv_prem.
        nv_useprm = nv_prem1 - nv_prvprm.
        nv_prvprm = nv_prem1.
    END.

    IF nv_usecod3 <> "" THEN DO:  /*VEHICLE USE 3*/
        nv_chkpa = 3.
        nv_bencod = nv_usecod3.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem3   = nv_prem.
        nv_useprm3 = nv_prem3 - nv_prvprm3.
        nv_prvprm3 = nv_prem3. 
    END.

    IF nv_engcod <> "" THEN DO:  /* ENGINE SIZE */
        IF nv_engcod = "ENGC" THEN DO:
            nv_chkpa  = 3.
            nv_bencod = nv_engcod.
            nv_key_b  = nv_engine.
            nv_prem   = nv_prem1.

            RUN PDChkTariffPA.
            nv_prem1  = nv_prem.
            nv_engprm = nv_prem1 - nv_prvprm.
            nv_prvprm = nv_prem1.
        END.
        IF nv_engcod = "ENGS" THEN DO:
            nv_chkpa = 3.
            nv_bencod = nv_engcod.
            nv_key_b  = nv_seat41.
            nv_prem   = nv_prem1.

            RUN PDChkTariffPA.
            nv_prem1  = nv_prem.
            nv_engprm = nv_prem1 - nv_prvprm.
            nv_prvprm = nv_prem1.
        END.
        IF nv_engcod = "ENGT" THEN DO:
            nv_chkpa = 3.
            nv_bencod = nv_engcod.
            nv_key_b  = nv_tons.
            nv_prem   = nv_prem1.

            RUN PDChkTariffPA.
            nv_prem1  = nv_prem.
            nv_engprm = nv_prem1 - nv_prvprm.
            nv_prvprm = nv_prem1.
        END.
    END.

    IF nv_drivcod <> "" THEN DO:  /* DRIVER'S AGE */
        nv_chkpa = 3.
        nv_bencod = nv_drivcod.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem1   = nv_prem.
        nv_drivprm = nv_prem1 - nv_prvprm.
        nv_prvprm  = nv_prem1.
    END.

    
    IF nv_yrcod <> "" THEN DO:  /* VEHICLE'S AGE */
        nv_chkpa = 3.
        nv_bencod = nv_yrcod.
        nv_prem   = nv_prem1.
    
        RUN PDChkTariffPA.
/*
        IF wexcel.policy = "DM7061NL1124" THEN MESSAGE "PDChkTariffPA  nv_prem"  nv_prem SKIP nv_prvprm  .
  */
        nv_prem1   = nv_prem.
        nv_yrprm   = nv_prem1 - nv_prvprm.
        nv_prvprm  = nv_prem1.

       /* IF wexcel.policy = "DM7061NL1124" THEN MESSAGE "PDChkTariffPA" nv_yrcod SKIP nv_yrprm  .*/

    END.

    IF nv_sicod <> "" THEN DO:          /* SUM INSURE  */
        IF nv_covcod = "1" THEN DO:
            nv_chkpa = 3.
            nv_bencod = nv_sicod.
            nv_key_b  = nv_si00.
            nv_prem   = nv_prem1.

            RUN PDChkTariffPA.
            nv_prem1   = nv_prem.
        END.
        IF nv_covcod = "2" THEN DO:
            nv_chkpa = 3.
            nv_bencod = nv_sicod.
            nv_key_b  = nv_si00.
            nv_prem   = nv_prem1.
            /*---Begin by Chaiyong W. A61-0014 20/03/2018*/
            IF nv_key_b = 0 THEN DO:
                nv_key_b = DECI(wexcel.si) NO-ERROR.

                
            END.
            /*End by Chaiyong W. A61-0014 20/03/2018-----*/

            RUN PDChkTariffPA.
            nv_prem1   = nv_prem.
        END.
        IF nv_covcod = "5" THEN DO:
            nv_chkpa = 3.
            nv_bencod = nv_sicod.
            nv_key_b  = nv_si00.
            nv_prem   = nv_prem1.

            RUN PDChkTariffPA.
            nv_prem1   = nv_prem.
        END.
        IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR
           nv_covcod = "3.1" OR nv_covcod = "3.2" THEN DO:

            IF nv_covcod = "2.1" OR nv_covcod = "2.2" THEN DO:
                nv_chkpa = 3.
                nv_bencod = nv_sicod.
                nv_key_b  = nv_si01.
                nv_prem   = nv_prem1.
    
                RUN PDChkTariffPA.
                nv_prem1   = nv_prem.
            END.
            ELSE DO:
                nv_chkpa = 3.
                nv_bencod = nv_sicod.
                nv_key_b  = nv_si00.
                nv_prem   = nv_prem1.
    
                RUN PDChkTariffPA.
                nv_prem1   = nv_prem.
            END.

        END.

        nv_siprm   = nv_prem1 - nv_prvprm.
        nv_prvprm  = nv_prem1.
    END.

    IF nv_sicod3 <> "" THEN DO:  /* SUM INSURE 3 */
        nv_chkpa = 3.
        nv_bencod = nv_sicod3.
        nv_key_b  = nv_si00.
        nv_prem   = nv_prem3.
    
        RUN PDChkTariffPA.
        nv_prem3    = nv_prem.
        nv_siprm3   = nv_prem3 - nv_prvprm3.
        nv_prvprm3  = nv_prem3.
    END.

    /*--
    IF nv_totlcod <> "" THEN DO:  /* TOTAL LOSS */
        IF nv_covcod = "5" THEN DO:
            nv_chkpa = 3.
            nv_bencod = nv_totlcod.
            nv_key_b = 0.

            RUN PDChkTariffPA.
            nv_si00 = nv_prem.
        END.

        nv_totlprm = nv_si00.
    END.
    --*/

    IF nv_othcod <> "" THEN DO:  /* ACCESSORY */
        nv_chkpa = 3.
        nv_bencod = nv_othcod.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem1 = nv_prem.
        nv_othprm = nv_prem1 - nv_prvprm.
        nv_prvprm = nv_prem1.
    END.

    IF nv_grpcod <> "" THEN DO:  /* VEHICLE GRP */
        nv_chkpa = 3.
        nv_bencod = nv_grpcod.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem1 = nv_prem.
        nv_grprm = nv_prem1 - nv_prvprm.
        nv_prvprm = nv_prem1.
    END.

    IF nv_bipcod <> "" THEN DO:  /* TPBI/PER */
        nv_chkpa = 3.
        nv_bencod = nv_bipcod.
        nv_key_b  = nv_bip00.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem1 = nv_prem.
        nv_bipprm  = nv_prem1 - nv_prvprm.
        nv_prvprm  = nv_prem1.
    END.

    IF nv_biacod <> "" THEN DO:  /* TPBI/ACC */
        nv_chkpa = 3.
        nv_bencod = nv_biacod.
        nv_key_b  = nv_bia00.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem1 = nv_prem.
        nv_biaprm  = nv_prem1 - nv_prvprm.
        nv_prvprm  = nv_prem1.
    END.

    IF nv_pdacod <> "" THEN DO:  /* TPPD         */
        nv_chkpa  = 3.
        nv_bencod = nv_pdacod.
        nv_key_b  = nv_pd00.
        nv_prem   = nv_prem1.

        RUN PDChkTariffPA.
        nv_prem1  = nv_prem.
        nv_pdaprm = nv_prem1 - nv_prvprm.
        nv_prvprm = nv_prem1.
    END.

    /*--
    IF nv_supecod <> "" THEN DO:  /* SUPE        */
        nv_chkpa  = 3.
        nv_bencod = nv_supecod.
        nv_key_b  = 0.
        nv_prem   = nv_supe00.

        RUN PDChkTariffPA.
        nv_supe00  = nv_prem.
        nv_supeprm  = ROUND(nv_supe00,0). 
        nv_supe00   = nv_prem1.
    END.
    --*/

    nv_prem1   = ROUND(nv_prem1,0).
    nv_prem3   = ROUND(nv_prem3,0).

END.

ASSIGN
    nv_dedod1_prm =  nv_ded1prm
    nv_dedod2_prm =  nv_aded1prm
    nv_dedpd_prm  =  nv_ded2prm
    nv_41prm   = nv_411prm + nv_412prm
    nv_addprm  = nv_41prm + nv_42prm + nv_43prm.

IF nv_covcod = "2.1" OR nv_covcod = "3.1" THEN nv_totded = 0.
ELSE nv_totded  = nv_ded1prm + nv_aded1prm + nv_ded2prm.

nv_flet    = - TRUNCATE(( nv_prem1 + nv_addprm + nv_totded) * nv_flet_per / 100,0).

nv_ncb     = - TRUNCATE(( nv_prem1 + nv_addprm + nv_totded + nv_flet) * nv_ncbper / 100,0).

nv_dsspc   = - TRUNCATE(( nv_prem1 + nv_addprm  + nv_totded + nv_flet + nv_ncb) * nv_dss_per / 100,0).

nv_stf_amt = - TRUNCATE(( nv_prem1 + nv_addprm + nv_totded + nv_flet + nv_ncb + nv_dsspc + nv_prem3) * nv_stf_per / 100,0). /*A58-0272*/

nv_lodclm  =   ( nv_prem1 + nv_addprm + nv_totded + nv_flet + nv_ncb + nv_dsspc + nv_stf_amt) * nv_cl_per / 100.
nv_lodclm1 =   TRUNCATE(( nv_prem1 + nv_addprm + nv_totded  + nv_flet + nv_ncb + nv_dsspc + nv_stf_amt) * nv_cl_per / 100,0).

IF nv_lodclm - nv_lodclm1 > 0 THEN nv_lodclm = nv_lodclm1 + 1.

nv_totdis  =   nv_totded + nv_flet + nv_ncb + nv_dsspc + nv_stf_amt.

/*nv_prem1   = nv_prem1 + nv_totlprm + nv_supeprm.*/
nv_prem1   = nv_prem1. /*+ nv_supeprm.*/

nv_gapprm  =   ROUND((nv_prem1 + nv_prem3 + nv_addprm + nv_totdis + nv_lodclm),0)  /*--A56-0394--*/
                    + nv_compprm + nv_camprem.

nv_pdprm   =   ROUND((nv_gapprm * nv_polday) / 365,0).
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDChkPrm132 C-Win 
PROCEDURE 00-PDChkPrm132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

ASSIGN
    nv_sclass = sic_bran.uwm120.CLASS
    nv_effdat = sic_bran.uwm100.comdat
    nv_seat41 = sic_bran.uwm301.seat
    nv_covcod = sic_bran.uwm301.covcod
    nv_engine = sic_bran.uwm301.engine
    nv_tons   = sic_bran.uwm301.tons
    nv_si00   = sic_bran.uwm130.uom6_v
    nv_si01   = sic_bran.uwm130.uom7_v.

ASSIGN
    nv_modcod = sic_bran.uwm301.modcod
    nv_vehreg = sic_bran.uwm301.vehgrp
    nv_vehuse = sic_bran.uwm301.vehuse
    nv_drivnam = 0.

ASSIGN
    nv_bip00 = sic_bran.uwm130.uom1_v
    nv_bia00 = sic_bran.uwm130.uom2_v
    nv_pd00  = sic_bran.uwm130.uom5_v.
/*---
FIND FIRST wexcamp WHERE wexcamp.policy = wexcel.policy NO-LOCK NO-ERROR.
IF AVAIL wexcamp THEN nv_baseprm1 = DECI(wexcamp.base1).
IF nv_baseprm1 = 0 THEN RUN PDChkBase.
comment by Chaiyong W. A61-0015 15/02/2018*/


/*---Begin by Chaiyong W. A61-0015 15/02/2018*/
FIND FIRST wexcamp WHERE wexcamp.policy = wexcel.policy NO-LOCK NO-ERROR.
IF AVAIL wexcamp THEN DO:
    
    nv_baseprm1 = DECI(wexcamp.base1) NO-ERROR.
    nv_baseprm2 = DECI(wexcamp.base2) NO-ERROR.



   

END.
IF nv_baseprm1 = 0 THEN RUN PDChkBase.
IF sic_bran.uwm301.covcod = "2.1" THEN nv_basecod3 = "BA21".
ELSE IF sic_bran.uwm301.covcod = "2.2" THEN nv_basecod3 = "BA22".
ELSE IF sic_bran.uwm301.covcod = "3.1" THEN nv_basecod3 = "BA31".
ELSE IF sic_bran.uwm301.covcod = "3.2" THEN nv_basecod3 = "BA32".
ELSE nv_basecod3 = "".

IF nv_basecod3 <> "" AND nv_baseprm2 = 0 THEN DO:
    
    FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
              sicsyac.xmm106.tariff  = "X"                    AND
              sicsyac.xmm106.bencod  = nv_basecod3            AND
              sicsyac.xmm106.CLASS   = sic_bran.uwm120.CLASS  AND
              sicsyac.xmm106.covcod  = sic_bran.uwm301.covcod AND
              sicsyac.xmm106.key_b  >= nv_key_b               AND
              sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        ASSIGN
            nv_base_max_p = sicsyac.xmm106.max_ap
            nv_base_min_p = sicsyac.xmm106.min_ap
            nv_baseprm2   = sicsyac.xmm106.min_ap.
    END.
END.

/*End by Chaiyong W. A61-0015 15/02/2018-----*/



/*-- VEHICLE GROUP --*/
ASSIGN
    nv_grpcod      = "GRP" + sic_bran.uwm301.vehgrp
    nv_grpvar1     = "     Vehicle Group = "
    nv_grpvar2     =  sic_bran.uwm301.vehgrp
    SUBSTRING(nv_grpvar,1,30)  = nv_grpvar1
    SUBSTRING(nv_grpvar,31,30) = nv_grpvar2.

RUN PDChkGenPA.  /*USOPER*/
RUN PDChkPrem.   /*USORPRM*/
/*-- MAKYEA --*/
ASSIGN
    nv_caryr   = 0.
/*---
    nv_caryr   = (YEAR(nv_comdat) - sic_bran.uwm301.yrmanu) + 1.
comment by Chaiyong W. A61-0015 14/03/2018*/
nv_caryr   = (YEAR(sic_bran.uwm100.comdat) - sic_bran.uwm301.yrmanu) + 1. /*----add by Chaiyong W. A61-0015 14/03/2018*/

ASSIGN
    nv_yrvar1  = "     Vehicle Year = "
    nv_yrvar2  = STRING(sic_bran.uwm301.yrmanu)
    nv_yrcod   = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr)
                                   ELSE "YR99"
    nv_yrcod  = TRIM(nv_yrcod ) /*----add by Chaiyong W. A61-0015 14/03/2018*/
    SUBSTRING(nv_yrvar,1,30)  = nv_yrvar1
    SUBSTRING(nv_yrvar,31,30) = nv_yrvar2.

RUN PDChkPrem.   /*USORPRM*/

RUN PDChkEng.  /*USOENG*/

RUN PDChkPrem.   /*USORPRM*/
/*-- VEHICLE USE --*/
ASSIGN
    nv_usecod  = "USE" + TRIM(nv_vehuse)
    nv_usevar1 = "     Vehicle Use = "
    nv_usevar2 =  nv_vehuse
    SUBSTRING(nv_usevar,1,30)  = nv_usevar1
    SUBSTRING(nv_usevar,31,30) = nv_usevar2.

RUN PDChkPrem.   /*USORPRM*/
/*-- DRIVER NAME --*/                /*
nv_drivno = INTE(wexcel.driname).
nv_age1   = INTE(wexcel.driage1).
nv_age2   = INTE(wexcel.driage2).  
comment by Chaiyong W. 18/07/2017*/
/*---Begin by Chaiyong W. 18/07/2017*/
nv_drivno = INTE(wexcel.driname) no-error.
nv_age1   = INTE(wexcel.driage1) no-error.
nv_age2   = INTE(wexcel.driage2) no-error.  
/*End by Chaiyong W. 18/07/2017*/

IF nv_drivno = 0 THEN DO:
    ASSIGN
        nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivno    = 0
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = STRING(nv_drivno)
        SUBSTRING(nv_drivvar,1,30)   = nv_drivvar1
        SUBSTRING(nv_drivvar,31,30)  = nv_drivvar2.

    nv_chkmail = TRIM(sic_bran.uwm100.policy) +
                 STRING(sic_bran.uwm100.rencnt,"99" ) +
                 STRING(sic_bran.uwm100.endcnt,"999") +
                 STRING(sic_bran.uwm130.riskno,"999") +
                 STRING(sic_bran.uwm130.itemno,"999").

    FOR EACH brstat.mailtxt_fil WHERE
             brstat.mailtxt_fil.policy = nv_chkmail:
        DELETE brstat.mailtxt_fil.
    END.
END.
ELSE IF nv_drivno <= 2 THEN DO:
    ASSIGN
        nv_drivvar     = " "
        nv_drivvar1    = "     Driver name person = "
        nv_drivvar2    = STRING(nv_drivno)
        SUBSTRING(nv_drivvar,1,30)  = nv_drivvar1
        SUBSTRING(nv_drivvar,31,30) = nv_drivvar2.

    RUN PDCreateMailtxt.

    RUN PDChkUsdCod.
END.

/*-- COMP --*/
IF sic_bran.uwm130.uom9_v <> 0 THEN DO:
    ASSIGN
        nv_compcod      = "COMP"
        nv_compvar1     = "     Compulsory  =   "
        nv_compvar2     = STRING(uwm130.uom9_v)
        SUBSTRING(nv_compvar,1,30)   = nv_compvar1
        SUBSTRING(nv_compvar,31,30)  = nv_compvar2.
END.
/*-- TPBI/PER --*/
ASSIGN
    nv_bipcod      = "BI1"
    nv_bipvar1     = "     BI per Person = "
    nv_bipvar2     = STRING(uwm130.uom1_v)
    SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
    SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.

/*-- TPBI/ACC --*/
ASSIGN
    nv_biacod      = "BI2"
    nv_biavar1     = "     BI per Accident = "
    nv_biavar2     = STRING(uwm130.uom2_v)
    SUBSTRING(nv_biavar,1,30)  = nv_biavar1
    SUBSTRING(nv_biavar,31,30) = nv_biavar2.

/*-- TPPD/ACC --*/
ASSIGN
    nv_pdacod      = "PD"
    nv_pdavar1     = "     PD per Accident = "
    nv_pdavar2     = STRING(uwm130.uom5_v)
    SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
    SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.

/*-- SI --*/
ASSIGN
    nv_sicod     = "SI"
    nv_sivar1    = "     Own Damage = "
    nv_sivar2    =  STRING(uwm130.uom6_v)
    SUBSTRING(nv_sivar,1,30)  = nv_sivar1
    SUBSTRING(nv_sivar,31,30) = nv_sivar2.

/*-- SI3 --*/
IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR
   nv_covcod = "3.1" OR nv_covcod = "3.2" THEN DO:
    ASSIGN
        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  STRING(uwm130.uom6_v)
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = "0".
 
         IF nv_covcod = "2.1" THEN nv_sicod3 = "SI21".
    ELSE IF nv_covcod = "2.2" THEN nv_sicod3 = "SI22".
    ELSE IF nv_covcod = "3.1" THEN nv_sicod3 = "SI31".
    ELSE IF nv_covcod = "3.2" THEN nv_sicod3 = "SI32".

    ASSIGN
        nv_sivar4    = "     Own Damage = "
        nv_sivar5    =  STRING(uwm130.uom6_v)
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4.
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5.
END.
ELSE DO:
    ASSIGN
        nv_sicod3 = "".
END.
/*-- Assecsory --*/
IF sic_bran.uwm130.uom6_u = "A" THEN DO:
    ASSIGN
        nv_othcod     = "OTH"
        nv_othvar1    = "     Accessory  = "
        nv_othvar2    =  STRING(uwm130.uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
END.
ELSE DO:
    ASSIGN
        nv_othcod     = ""
        nv_othvar1    = ""
        nv_othvar2    = ""
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
END.

/*-- BASEPRM --*/
ASSIGN
    nv_basecod = "BASE"
    nv_basevar1 = "     Base Premium = "
    nv_basevar2 = STRING(nv_baseprm1)
    SUBSTRING(nv_basevar,1,30)   = nv_basevar1
    SUBSTRING(nv_basevar,31,30)  = nv_basevar2.

/*-- BASEPRM3 --*/
IF nv_covcod = "2.1" OR nv_covcod = "2.2" OR
   nv_covcod = "3.1" OR nv_covcod = "3.2" THEN DO:
    ASSIGN
        nv_basevar4 = "     Base Premium3 = "
        nv_basevar5 = STRING(nv_baseprm2)
        SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
        SUBSTRING(nv_basevar3,31,30)  = nv_basevar5.
END.
ELSE DO:
    ASSIGN
        nv_baseprm2 = 0.
END.

/*-- 411 --*/
ASSIGN
    nv_41cod1   = "411"
    nv_411var1  = "     PA Driver = "
    nv_411var2  =  STRING(wexcamp.pa411)
    SUBSTRING(nv_411var,1,30)    = nv_411var1
    SUBSTRING(nv_411var,31,30)   = nv_411var2.

/*-- 412 --*/
ASSIGN
    nv_41cod2   = "412"
    nv_412var1  = "     PA Passengers = "
    nv_412var2  =  STRING(wexcamp.pa412)
    SUBSTRING(nv_412var,1,30)   = nv_412var1
    SUBSTRING(nv_412var,31,30)  = nv_412var2.

/*-- 42 --*/
ASSIGN
    nv_42cod   = "42"
    nv_42var1  = "     Medical Expense = "
    nv_42var2  = STRING(wexcamp.pa42)
    SUBSTRING(nv_42var,1,30)   = nv_42var1
    SUBSTRING(nv_42var,31,30)  = nv_42var2.

/*-- 43 --*/
ASSIGN
    nv_43cod   = "43"
    nv_43var1  = "     Airfrieght = "
    nv_43var2  =  STRING(wexcamp.pa43)
    SUBSTRING(nv_43var,1,30)   = nv_43var1
    SUBSTRING(nv_43var,31,30)  = nv_43var2.

/*-- DEDUCT OD --*/
ASSIGN
    nv_dedod1_cod     = "DOD"
    nv_dedod1var1     = "     Deduct OD = "
    nv_dedod1var2     = STRING(nv_dedod)
    SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
    SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.

/*-- DEDUCT ADD OD --*/
ASSIGN
    nv_dedod2_cod   = "DOD2"
    nv_dedod2var1   = "     Add Ded.OD = "
    nv_dedod2var2   =  STRING(nv_addod)
    SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
    SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2.

/*-- DEDUCT PD --*/
ASSIGN
    nv_dedpd_cod   = "DPD"
    nv_dedpdvar1   = "     Deduct PD = "
    nv_dedpdvar2   =  STRING(nv_dedpd)
    SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
    SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2.

/*-- FLEET --*/
IF nv_flet_per <> 0 OR nv_flet_per <> ? THEN DO:
    ASSIGN
        nv_fletvar  = " "
        nv_fletvar1 = "     Fleet % = "
        nv_fletvar2 =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)   = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30)  = nv_fletvar2.
END.

/*-- NCB --*/
IF nv_ncbper <> 0 OR nv_ncbper <> ? THEN DO:
    ASSIGN
        nv_ncbvar   = " "
        nv_ncbvar1  = "     NCB % = "
        nv_ncbvar2  =  STRING(nv_ncbper)
        SUBSTRING(nv_ncbvar,1,30)  = nv_ncbvar1
        SUBSTRING(nv_ncbvar,31,30) = nv_ncbvar2.
END.

/*-- DSSPC --*/
IF nv_dss_per <> 0 OR nv_dss_per <> ? THEN DO:
    ASSIGN
        nv_dsspcvar  = " "
        nv_dsspcvar1 = "     Discount Special % = "
        nv_dsspcvar2 =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)  = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30) = nv_dsspcvar2.
END.

/*-- DS STAFF --*/
IF nv_stf_per <> 0 OR nv_stf_per <> ? THEN DO:
    ASSIGN
        nv_stfvar  = " "
        nv_stfvar1 = "     Discount Staff % = "
        nv_stfvar2 =  STRING(nv_stf_per)
        SUBSTRING(nv_stfvar,1,30)  = nv_stfvar1
        SUBSTRING(nv_stfvar,31,30) = nv_stfvar2.
END.

/*-- LOAD CLAIM --*/
IF nv_cl_per <> 0 OR nv_cl_per <> ? THEN DO:
    ASSIGN
        nv_clmvar    = " "
        nv_clmvar1   = "     Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
END.
RUN PDChkPrem.   /*USORPRM*/*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDChkTariffPA C-Win 
PROCEDURE 00-PDChkTariffPA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203....
/*nv_prem = 0.*/
nv_rate = 0.

IF nv_chkpa = 1 THEN DO: /*QUOMX022.P*/

    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff = "X"       AND
               sicsyac.xmm106.bencod = nv_bencod AND
               sicsyac.xmm106.CLASS  = nv_sclass AND
               sicsyac.xmm106.key_b  GE nv_key_b /*AND
               sicsyac.xmm106.effdat LE nv_effdat*/ NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm106 THEN DO:
        IF SUBSTR(sicsyac.xmm106.bencod,3,1) = "2" OR 
           SUBSTR(sicsyac.xmm106.bencod,3,1) = "4" THEN DO:
            ASSIGN
                nv_rate = sicsyac.xmm106.appinc
                nv_prem = nv_prem * nv_rate * (nv_seat41 - 1).
        END.
        ELSE DO:
            ASSIGN
                nv_rate = sicsyac.xmm106.appinc
                nv_prem = nv_prem * nv_rate.
        END.
    END.
END.
ELSE IF nv_chkpa = 2 THEN DO: /*QUOMX023.P*/
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff = "X"       AND
               sicsyac.xmm106.bencod = nv_bencod AND
               sicsyac.xmm106.CLASS  = nv_sclass AND
               sicsyac.xmm106.key_b  GE nv_key_b /*AND
               sicsyac.xmm106.effdat LE nv_effdat*/ NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xmm106 THEN DO:
        nv_rate = xmm106.baseap.
        nv_prem = nv_seat41 * nv_rate.
    END.
END.
ELSE IF nv_chkpa = 3 THEN DO: /*QUOMX021.P*/

    IF SUBSTR(nv_bencod,1,2) = "YR" THEN DO:
        nv_yr = INTEGER(TRIM(SUBSTRING(nv_bencod,3,2))).

        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                   sicsyac.xmm106.tariff = "X"        AND
                   /*---
                   sicsyac.xmm106.bencod > nv_bencod  AND  
                   comment by Chaiyong W. A61-0015 15/03/2018*/
                   sicsyac.xmm106.bencod >= nv_bencod  AND   /*---add by Chaiyong W. A61-0015 15/03/2018*/
                   INTEGER(TRIM(SUBSTRING(sicsyac.xmm106.bencod,3,2))) >= nv_yr AND
                   sicsyac.xmm106.class  = nv_sclass  AND
                   sicsyac.xmm106.covcod = nv_covcod  AND
                   sicsyac.xmm106.key_b  GE nv_key_b 
                   AND sicsyac.xmm106.effdat LE nv_effdat    /*---add by Chaiyong W. A61-0015 15/03/2018*/
                   /* AND
                   sicsyac.xmm106.effdat LE nv_effdat comment by Chaiyong W. A61-0015 15/03/2018  */
        NO-LOCK NO-ERROR NO-WAIT.
        /*---begin by chaiyong W. A61-0016 15/03/2018*/
        IF AVAIL sicsyac.xmm106 THEN DO:
            ASSIGN
                nv_rate = sicsyac.xmm106.appinc
                nv_prem = nv_prem * ( nv_rate / 100 ).
        
        END.
        /*end  by chaiyong W. A61-0016 15/03/2018*/
    END.
    ELSE DO:
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                   sicsyac.xmm106.tariff = "X"        AND
                   sicsyac.xmm106.bencod = nv_bencod  AND
                   sicsyac.xmm106.class  = nv_sclass  AND
                   sicsyac.xmm106.covcod = nv_covcod  AND
                   sicsyac.xmm106.key_b  GE nv_key_b /* AND
                   sicsyac.xmm106.effdat LE nv_effdat*/
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm106 THEN DO:
            IF nv_bencod = "BI1" OR nv_bencod = "BI2" OR nv_bencod = "PD" THEN DO:
                nv_rate = sicsyac.xmm106.appinc.
                nv_prem = nv_prem * nv_rate.
            END.
            ELSE DO:
                nv_rate = sicsyac.xmm106.appinc.
                nv_prem = nv_prem * (nv_rate / 100).
            END.
        END.
        
    END.
END.

nv_key_b = 0.
nv_bencod = "".
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDCreate100d-bk C-Win 
PROCEDURE 00-PDCreate100d-bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0247...
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
DEF VAR nv_text5     AS CHAR.
             
n_rencnt = 0.
n_endcnt = 0.
n_rencnt = np_rencnt .  /*---add by Chaiyong W. A59-0614 30/04/2017*/

FOR EACH wuppertxt.
    DELETE wuppertxt.
END.

ASSIGN
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = wexcel.campaign   
    nv_txt2  = "Date Recive: " + wexcel.trndat
    nv_txt3  = "Ref.No.: " + wexcel.cedpol    
    nv_txt4  = "Branch NTL: " + wexcel.brncod + " " + wexcel.brnnam   
    nv_txt5  = "ที่อยู่จัดส่งเอกสาร: "  
    nv_txt6  = wexcel.baddr1 + " " + wexcel.baddr2
    nv_txt7  = wexcel.baddr3 + " " + wexcel.baddr4 
    nv_txt8  = wexcel.bpostcod
    nv_txt9  = ""
    nv_txt10 = wexcel.isp  /*- add by Chaiyong W. A59-0614--*/
    nv_txt11 = ""
    nv_txt12 = "".
IF nv_txt11 = "" AND wexcel.f7 <> "" THEN nv_txt11 =  wexcel.f7. /*---add by Chaiyong W. A60-0016 15/01/2018*/
/*-----begin by Chaiyong W. A59-0614 15/12/2016*/
IF wexcel.paycod <> "" THEN DO:
    IF      wexcel.paycod = "CA" THEN nv_txt9 = "ประเภทการรับชำระ : เงินสด" .
    ELSE IF wexcel.paycod = "CC" THEN nv_txt9 = "ประเภทการรับชำระ : บัตรเครดิต" .
    ELSE IF wexcel.paycod = "BP" THEN nv_txt9 = "ประเภทการรับชำระ : Bill Payment" .
    ELSE IF wexcel.paycod = "CV" THEN nv_txt9 = "ประเภทการรับชำระ : หักจากยอดจัดสินเชื่อ" .
    ELSE IF wexcel.paycod = "CL" THEN nv_txt9 = "Installment (ผ่อนชำระ)" .


END.
/*End by Chaiyong W. A59-0614 15/12/2016-------*/


DO WHILE nv_line1 <= 12:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    IF nv_line1 = 8  THEN wuppertxt.txt = nv_txt8.
    IF nv_line1 = 9  THEN wuppertxt.txt = nv_txt9.
    IF nv_line1 = 10 THEN wuppertxt.txt = nv_txt10.
    IF nv_line1 = 11 THEN wuppertxt.txt = nv_txt11.
    IF nv_line1 = 12 THEN wuppertxt.txt = nv_txt12.
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wexcel.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt        AND
     sic_bran.uwm100.endcnt  = n_endcnt        AND
     sic_bran.uwm100.bchyr   = nv_batchyr      AND
     sic_bran.uwm100.bchno   = nv_batchno      AND
     sic_bran.uwm100.bchcnt  = nv_batcnt       NO-ERROR NO-WAIT.
IF AVAIL sic_bran.uwm100 THEN DO:

    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd100.
        ASSIGN
            sic_bran.uwd100.bptr    = nv_bptr
            sic_bran.uwd100.fptr    = 0
            sic_bran.uwd100.policy  = wexcel.policy
            sic_bran.uwd100.rencnt  = n_rencnt
            sic_bran.uwd100.endcnt  = n_endcnt
            sic_bran.uwd100.ltext   = wuppertxt.txt.

        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
            wf_uwd100.fptr = RECID(uwd100).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(uwd100).
        nv_bptr = RECID(uwd100).
    END.
END.
...end A64-0247..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDCreate132 C-Win 
PROCEDURE 00-PDCreate132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
RUN PDCreateBencod.

IF nv_line <> 0 THEN DO:
    nv_bptr = 0.

    FOR EACH wk_uwd132 NO-LOCK BREAK BY wk_uwd132.line:
        CREATE sic_bran.uwd132.
        ASSIGN  sic_bran.uwd132.policy        = wk_uwd132.policy
                sic_bran.uwd132.rencnt        = wk_uwd132.rencnt
                sic_bran.uwd132.endcnt        = wk_uwd132.endcnt
                sic_bran.uwd132.riskgp        = wk_uwd132.riskgp
                sic_bran.uwd132.riskno        = wk_uwd132.riskno
                sic_bran.uwd132.itemno        = wk_uwd132.itemno
                sic_bran.uwd132.bchyr         = wk_uwd132.bchyr 
                sic_bran.uwd132.bchno         = wk_uwd132.bchno 
                sic_bran.uwd132.bchcnt        = wk_uwd132.bchcnt
                sic_bran.uwd132.rateae        = wk_uwd132.rateae
                sic_bran.uwd132.bencod        = wk_uwd132.bencod
                sic_bran.uwd132.benvar        = wk_uwd132.benvar
                sic_bran.uwd132.rate          = wk_uwd132.rate
                sic_bran.uwd132.gap_ae        = wk_uwd132.gap_ae
                sic_bran.uwd132.gap_c         = wk_uwd132.gap_c
                sic_bran.uwd132.pd_aep        = wk_uwd132.pd_aep
                sic_bran.uwd132.prem_c        = wk_uwd132.prem_c
                sic_bran.uwd132.bptr          = nv_bptr
                sic_bran.uwd132.dl1_c         = 0
                sic_bran.uwd132.dl2_c         = 0
                sic_bran.uwd132.dl3_c         = 0
                sic_bran.uwd132.fptr          = 0.

         IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
        
            wf_uwd132.fptr = RECID(sic_bran.uwd132).
         END.

         IF nv_bptr = 0 THEN  sic_bran.uwm130.fptr03 = RECID(sic_bran.uwd132).

         nv_bptr = RECID(sic_bran.uwd132).
    END.

    sic_bran.uwm130.bptr03 = nv_bptr.

    nt_gapprm   = 0.
    nt_pdprm    = 0.

    FOR EACH sic_bran.uwd132   WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
             sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
             sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
             sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-LOCK:
   
         nt_gapprm   = nt_gapprm + uwd132.gap_c.
         nt_pdprm    = nt_pdprm  + uwd132.prem_c.   
    END.

    IF nv_gapprm <> nt_gapprm THEN DO:
        nv_adjgap = nv_gapprm - nt_gapprm.

        FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "PD"           NO-ERROR.
        IF  AVAIL  sic_bran.uwd132  THEN  DO:
            ASSIGN  sic_bran.uwd132.gap_c  =  sic_bran.uwd132.gap_c + nv_adjgap.

        END.
    END.

    IF nv_pdprm <> nt_pdprm THEN DO:
        nv_adjpd = nv_pdprm - nt_pdprm.

        FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "PD"           NO-ERROR.
        IF AVAIL sic_bran.uwd132 THEN DO:
            ASSIGN sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c + nv_adjpd.
        END.
    END.

END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDCreateBencod C-Win 
PROCEDURE 00-PDCreateBencod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
FOR EACH  wk_uwd132 .
    DELETE wk_uwd132.
END.

FIND FIRST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-ERROR.
FIND FIRST sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-ERROR.

ASSIGN
    n_policy = sic_bran.uwm130.policy
    n_rencnt = sic_bran.uwm130.rencnt 
    n_endcnt = sic_bran.uwm130.endcnt 
    n_riskno = sic_bran.uwm130.riskno
    n_itemno = sic_bran.uwm130.itemno.


FIND FIRST sic_bran.uwd132 USE-INDEX uwd13201  WHERE
           sic_bran.uwd132.policy = sic_bran.uwm130.policy AND
           sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt AND
           sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt AND
           sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp AND
           sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
           sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
           sic_bran.uwd132.bchyr  = nv_batchyr             AND
           sic_bran.uwd132.bchno  = nv_batchno             AND
           sic_bran.uwd132.bchcnt = nv_batcnt              
NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwd132 THEN DO:
    FOR EACH sic_bran.uwd132 USE-INDEX uwd13201  WHERE
             sic_bran.uwd132.policy = sic_bran.uwm130.policy AND
             sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt AND
             sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt AND
             sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr  = nv_batchyr             AND
             sic_bran.uwd132.bchno  = nv_batchno             AND
             sic_bran.uwd132.bchcnt = nv_batcnt              :
        DELETE sic_bran.uwd132.
    END.

    sic_bran.uwm130.fptr03 = 0.
    sic_bran.uwm130.bptr03 = 0.
END.

nv_line = 0.

nt_gapprm  = 0.    nt_pdprm  = 0.
nv_adjgap  = 0.    nv_adjpd  = 0.

/*-- COMPULLSORY PREMIUM --*/
IF nv_compprm <> 0 THEN DO:

    ASSIGN nv_gap     = 0
           nv_prem_c  = 0.

    nv_gap    = nv_compprm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT        n_policy,
                                     n_rencnt,
                                     n_endcnt,
                                     n_riskno,
                                     n_itemno,
                                     sic_bran.uwm301.tariff,
                                     nv_compcod,
                                     nv_compvar,
                                     nv_gap,
                                     nv_prem_c,
                        INPUT-OUTPUT nv_line).

END.

/*-- BASE PREMIUM --*/
ASSIGN nv_gap     = 0
       nv_prem_c  = 0.

nv_gap    = nv_baseprm1.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT        n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_basecod,
                                 nv_basevar,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).

IF nv_basecod3 <> "" THEN DO:
    ASSIGN nv_gap     = 0
           nv_prem_c  = 0.

    nv_gap    = nv_baseprm2.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_basecod3,
                                 nv_basevar3,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/*-- Vehicel Use --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_useprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_usecod,
                             nv_usevar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*MESSAGE "usecod3" nv_usecod3 VIEW-AS ALERT-BOX.*//*Phorn*/
IF nv_usecod3  <> "" THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_useprm3.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_usecod3,
                                 nv_usevar3,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/*-- ENGINE --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_engprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_engcod,
                             nv_engvar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- Driver Age --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_drivprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_drivcod,
                             nv_drivvar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*--Vehicle Year --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_yrprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_yrcod,
                             nv_yrvar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- Sum Insured --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_siprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_sicod,
                             nv_sivar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

IF nv_sicod3 <> "" THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_siprm3.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_sicod3,
                                 nv_sivar3,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/*-- Total Loss --*/

/*-- Super Car --*/

/*-- Accessory --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_othprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_othcod,
                             nv_othvar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- Vehicel Group --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_grprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_grpcod,
                             nv_grpvar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- BI per Person --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_bipprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_bipcod,
                             nv_bipvar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- BI per Accident --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_biaprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_biacod,
                             nv_biavar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- PD per Accident --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_pdaprm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_pdacod,
                             nv_pdavar,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- PA. 411  Driver Person --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_411prm.
nv_prem_c = TRUNCATE((nv_gap  * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_41cod1,
                             nv_411var,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- PA. 412 : PASSENGER --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_412prm.
nv_prem_c = TRUNCATE((nv_gap  * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_41cod2,
                             nv_412var,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- PA. 42 : Medical Expense --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_42prm.
nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_42cod,
                             nv_42var,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- PA. 43 : Airfrieght --*/
ASSIGN nv_gap    = 0
       nv_prem_c = 0.

nv_gap    = nv_43prm.
nv_prem_c = TRUNCATE((nv_gap *  nv_polday) / 365,0).

RUN PDSubCreate132 (INPUT    n_policy,
                             n_rencnt,
                             n_endcnt,
                             n_riskno,
                             n_itemno,
                             sic_bran.uwm301.tariff,
                             nv_43cod,
                             nv_43var,
                             nv_gap,
                             nv_prem_c,
                INPUT-OUTPUT nv_line).

/*-- PA. 413 : Person --*/

RUN PDCreateDOD.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDCreateDOD C-Win 
PROCEDURE 00-PDCreateDOD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
/*-- Deductible Benefit : Deduct  OD --*/
/*--
IF sic_bran.uwm301.covcod = "2.1" OR sic_bran.uwm301.covcod = "2.2" OR
   sic_bran.uwm301.covcod = "3.1" OR sic_bran.uwm301.covcod = "3.2" THEN DO:
comment by Chaiyong W. A60-0016 22/01/2018*/

IF sic_bran.uwm301.covcod = "2.1"  OR sic_bran.uwm301.covcod = "3.1"  THEN DO: /*---add by Chaiyong W. A60-0016 22/01/2018*/

    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_dedod1_prm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_dedod1_cod,
                                 nv_dedod1var,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).

    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_dedod2_prm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_dedod2_cod,
                                 nv_dedod2var,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.
ELSE DO:
    IF nv_dedod1_prm  <> 0 THEN DO:
        ASSIGN nv_gap    = 0
               nv_prem_c = 0.

        nv_gap    = nv_dedod1_prm.
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

        RUN PDSubCreate132 (INPUT    n_policy,
                                     n_rencnt,
                                     n_endcnt,
                                     n_riskno,
                                     n_itemno,
                                     sic_bran.uwm301.tariff,
                                     nv_dedod1_cod,
                                     nv_dedod1var,
                                     nv_gap,
                                     nv_prem_c,
                        INPUT-OUTPUT nv_line).
    END.

    /* Deductible ADD OD  */
    IF  nv_dedod2_prm  <> 0  THEN DO:
        ASSIGN nv_gap    = 0
               nv_prem_c = 0.

        nv_gap    = nv_dedod2_prm.
        nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

        RUN PDSubCreate132 (INPUT    n_policy,
                                     n_rencnt,
                                     n_endcnt,
                                     n_riskno,
                                     n_itemno,
                                     sic_bran.uwm301.tariff,
                                     nv_dedod2_cod,
                                     nv_dedod2var,
                                     nv_gap,
                                     nv_prem_c,
                        INPUT-OUTPUT nv_line).
    END.
END.

/* Deductible PD   */
IF  nv_dedpd_prm  <> 0 THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap    = nv_dedpd_prm.
    nv_prem_c = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_dedpd_cod,
                                 nv_dedpdvar,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/*-- FLEET --*/
IF nv_flet  <> 0 THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap     = nv_flet.
    nv_prem_c  = TRUNCATE((nv_gap  * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 "FLET",
                                 nv_fletvar,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/* NCB : Experience Discount */
IF nv_ncb   <> 0 THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap     = nv_ncb.
    nv_prem_c  = TRUNCATE((nv_gap   * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 "NCB",
                                 nv_ncbvar,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/* Discount Special Percent */
IF nv_dsspc <> 0 THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap     = nv_dsspc.
    nv_prem_c  = TRUNCATE((nv_gap * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 "DSPC",
                                 nv_dsspcvar,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/* Discount Staff */
IF nv_stf_amt   <> 0 THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap     = nv_stf_amt.
    nv_prem_c  = TRUNCATE((nv_gap  * nv_polday) / 365,0).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 "DSTF",
                                 nv_stfvar,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.

/*-- Load Claim --*/
IF nv_cl_per <> 0 THEN DO:
    ASSIGN nv_gap    = 0
           nv_prem_c = 0.

    nv_gap     = nv_lodclm.
    nv_prem_c  = TRUNCATE((nv_gap  * nv_polday) / 365,0).

    nv_bencod = "".
    nv_bencod = "CL" + STRING(nv_cl_per).

    RUN PDSubCreate132 (INPUT    n_policy,
                                 n_rencnt,
                                 n_endcnt,
                                 n_riskno,
                                 n_itemno,
                                 sic_bran.uwm301.tariff,
                                 nv_bencod,
                                 nv_clmvar,
                                 nv_gap,
                                 nv_prem_c,
                    INPUT-OUTPUT nv_line).
END.
*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pdncb301 C-Win 
PROCEDURE 00-pdncb301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
IF nv_ncbper  <> 0  THEN DO:
    FIND FIRST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-ERROR NO-WAIT.
    IF AVAIL sic_bran.uwm301 THEN DO:
        ASSIGN
            uwm301.ncbper = nv_ncbper .
        FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
            sicsyac.xmm104.tariff = "X"           AND
            sicsyac.xmm104.class  = nv_sclass     AND
            sicsyac.xmm104.covcod = nv_covcod     AND
            sicsyac.xmm104.ncbper = uwm301.ncbper NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm104 THEN uwm301.ncbyrs = sicsyac.xmm104.ncbyrs.
    END.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-PDSubCreate132 C-Win 
PROCEDURE 00-PDSubCreate132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
DEFINE INPUT        PARAMETER   n_policy    AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   n_rencnt    AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   n_endcnt    AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_riskno   AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_itemno   AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_tariff   AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   nv_bencod   AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   nv_benvar   AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   nv_gap      AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_prem_c   AS INTEGER           NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER   nv_line     AS INTEGER           NO-UNDO.

nv_line   = nv_line + 1.

IF nv_bencod <> "" THEN DO:
   CREATE wk_uwd132.
   ASSIGN wk_uwd132.policy = n_policy
          wk_uwd132.rencnt = n_rencnt
          wk_uwd132.endcnt = n_endcnt
          wk_uwd132.riskgp = 0
          wk_uwd132.riskno = nv_riskno
          wk_uwd132.itemno = nv_itemno
          wk_uwd132.bchyr  = nv_batchyr
          wk_uwd132.bchno  = nv_batchno
          wk_uwd132.bchcnt = nv_batcnt 
          wk_uwd132.rateae = YES
          wk_uwd132.bencod = nv_bencod
          wk_uwd132.gap_ae = NO
          wk_uwd132.gap_c  = nv_gap
          wk_uwd132.pd_aep = "E"
          wk_uwd132.prem_c = nv_prem_c
          wk_uwd132.line   = nv_line
          wk_uwd132.benvar = nv_benvar.
END.

nv_benvar  = " ".
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132 C-Win 
PROCEDURE 00-pd_add132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/  
/* comment by : A65-0203...
/*--
DEF VAR nv_total AS DECI INIT 0.
ASSIGN
     nv_stds   = NO
     nv_deci   = 0
     nv_dncb   = 0 
     nv_c132   = 0.

nv_deci = DECI(wexcel.netprm ) NO-ERROR.
IF nv_deci <> 0  THEN DO:
    
    
    RUN pd_add132_132.
     /*
    IF wexcel.policy = "98" THEN                  
    MESSAGE nv_deci SKIP nv_stds VIEW-AS ALERT-BOX.*/
    IF nv_deci <> 0 AND nv_stds = NO THEN DO:
        FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "NCB"           NO-ERROR.
        IF NOT AVAIL sic_bran.uwd132 AND nv_deci < nt_gapprm THEN DO:

            
            RUN pd_add132_ncb.
            IF nv_dncb <> 0 THEN nv_ncbper = nv_dncb.
            RUN pd_add132_132.
            nv_deci = DECI(wexcel.netprm ) NO-ERROR.


            RUN pd_add132_43.


            /*--
            FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "NCB"           NO-ERROR.
            IF  AVAIL  sic_bran.uwd132  THEN  DO:
                sic_bran.uwd132.gap_c  = round((nt_gapprm  * nv_ncbper / 100 ) * -1,0).
                sic_bran.uwd132.prem_c = round((nt_pdprm   * nv_ncbper / 100 ) * -1,0).

                nt_gapprm  =  nt_gapprm + sic_bran.uwd132.gap_c   .
                nt_pdprm   =  nt_pdprm  + sic_bran.uwd132.prem_c  .
               
            END. ---*/



        END.
        ELSE DO:
            RUN pd_add132_43.
        END.
    END.
    ELSE IF nv_deci  <> 0 AND nv_stds = YES THEN DO:



        IF nv_cl_per   <> 0  THEN DO:
            nv_deci  = nv_deci  *  nv_cl_per / (100 + nv_cl_per).
            FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   substr(sic_bran.uwd132.bencod,1,2)  = "CL"           NO-ERROR.
            IF  AVAIL  sic_bran.uwd132  THEN  DO:
                sic_bran.uwd132.gap_c  = round(nt_gapprm  * nv_cl_per / 100,0).
                sic_bran.uwd132.prem_c = round(nt_pdprm   * nv_cl_per / 100,0).

                nt_gapprm  =  nt_gapprm + sic_bran.uwd132.gap_c   .
                nt_pdprm   =  nt_pdprm  + sic_bran.uwd132.prem_c  .
               
            END.
        END.
        IF nv_dss_per <> 0 THEN DO:
            nv_deci  = nv_deci + (nv_deci  * nv_dss_per / (100 - nv_dss_per)) .
            nv_deci  = ROUND(nv_deci,2).
            
            FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "DSPC"           NO-ERROR.
            IF  AVAIL  sic_bran.uwd132  THEN  DO:
                sic_bran.uwd132.gap_c  = round((nv_deci  * nv_dss_per / 100) * - 1,0).
                sic_bran.uwd132.prem_c = round((nv_deci  * nv_dss_per / 100) * - 1,0).

                nt_gapprm  =  nt_gapprm + sic_bran.uwd132.gap_c   .
                nt_pdprm   =  nt_pdprm  + sic_bran.uwd132.prem_c  .
               
            END.
        END.
        RUN pd_add132_132.
        IF nv_flet_per <> 0  THEN DO:
            RUN pd_add132_dc.
            RUN pd_add132_dc2.
            
            
            FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "FLET"           NO-ERROR.
            IF  AVAIL  sic_bran.uwd132  THEN  DO:
                sic_bran.uwd132.gap_c  = round((nt_gapprm  * nv_flet_per / 100) * -1,0).
                sic_bran.uwd132.prem_c = round((nt_pdprm   * nv_flet_per / 100) * -1,0).
               
            END. 
        END.
        RUN pd_add132_132.
        RUN pd_add132_dc.

        IF nv_ncbper <> 0 THEN DO:
            nv_deci  = nv_deci + (nv_deci  * nv_dss_per / (100 - nv_dss_per)) .
            nv_deci  = ROUND(nv_deci,2).
            FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "NCB"           NO-ERROR.
            IF  AVAIL  sic_bran.uwd132  THEN  DO:
                sic_bran.uwd132.gap_c  = round((nv_deci  * nv_ncbper / 100 ) * -1,0).
                sic_bran.uwd132.prem_c = round((nv_deci  * nv_ncbper / 100 ) * -1,0).

                nt_gapprm  =  nt_gapprm + sic_bran.uwd132.gap_c   .
                nt_pdprm   =  nt_pdprm  + sic_bran.uwd132.prem_c  .
               
            END.
        END.
        ELSE DO:
            nv_deci = DECI(wexcel.netprm ) NO-ERROR.
            IF nv_deci < nt_gapprm THEN DO:
                FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                   sic_bran.uwd132.bencod  = "NCB"           NO-ERROR.
                IF NOT AVAIL sic_bran.uwd132 AND nv_deci < nt_gapprm THEN DO:
                    RUN pd_add132_ncb.
                    nv_ncbper = nv_dncb.
                    FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                           sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                           sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                           sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                           sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                           sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                           sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
                           sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
                           sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
                           sic_bran.uwd132.bencod  = "NCB"           NO-ERROR.
                    IF  AVAIL  sic_bran.uwd132  THEN  DO:
                        sic_bran.uwd132.gap_c  = round((nt_gapprm  * nv_ncbper / 100 ) * -1,0).
                        sic_bran.uwd132.prem_c = round((nt_pdprm   * nv_ncbper / 100 ) * -1,0).
                        nt_gapprm  =  nt_gapprm + sic_bran.uwd132.gap_c   .
                        nt_pdprm   =  nt_pdprm  + sic_bran.uwd132.prem_c  .
                       
                    END.
                END.                  
            END.        
        END.
        nv_deci = DECI(wexcel.netprm ) NO-ERROR. 
        RUN pd_add132_132.
        RUN pd_add132_43.
        RUN pd_add132_nw. 
        nv_deci = DECI(wexcel.netprm ) NO-ERROR.
        RUN pd_add132_132.
        RUN pd_add132_43.
    END.
END.
---*/

IF nv_ncbper <> 0 THEN DO:
    FIND FIRST sic_bran.uwm120 WHERE 
        sic_bran.uwm120.policy  = sic_bran.uwm130.policy  AND
        sic_bran.uwm120.rencnt  = sic_bran.uwm130.rencnt  AND
        sic_bran.uwm120.endcnt  = sic_bran.uwm130.endcnt  AND
        sic_bran.uwm120.riskno  = sic_bran.uwm130.riskno  AND
        sic_bran.uwm120.bchyr   = sic_bran.uwm130.bchyr   AND
        sic_bran.uwm120.bchno   = sic_bran.uwm130.bchno   AND
        sic_bran.uwm120.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR.
    FIND FIRST sic_bran.uwm301   WHERE
           sic_bran.uwm301.policy  = sic_bran.uwm130.policy  AND
           sic_bran.uwm301.rencnt  = sic_bran.uwm130.rencnt  AND
           sic_bran.uwm301.endcnt  = sic_bran.uwm130.endcnt  AND
           sic_bran.uwm301.riskno  = sic_bran.uwm130.riskno  AND
           sic_bran.uwm301.itemno  = sic_bran.uwm130.itemno  AND
           sic_bran.uwm301.bchyr   = sic_bran.uwm130.bchyr   AND
           sic_bran.uwm301.bchno   = sic_bran.uwm130.bchno   AND
           sic_bran.uwm301.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR.
    IF  AVAIL  sic_bran.uwm301 THEN  DO:
        uwm301.ncbper = nv_ncbper .
        /*IF nv_ncbper = 10 THEN uwm301.ncbyrs = 1.
        ELSE*/ 

        FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
                   sicsyac.xmm104.tariff = "X"           AND
                   sicsyac.xmm104.class  = uwm120.CLASS  AND
                   sicsyac.xmm104.covcod = uwm301.covcod AND
                   sicsyac.xmm104.ncbper = uwm301.ncbper NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm104 THEN uwm301.ncbyrs = sicsyac.xmm104.ncbyrs .  /*  uwm301.ncbyrs = sicsyac.xmm104.ncbyrs*/



    END.
END. 
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_132 C-Win 
PROCEDURE 00-pd_add132_132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
ASSIGN
    nt_gapprm = 0
    nt_pdprm  = 0.
FOR EACH sic_bran.uwd132   WHERE
       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
       sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
       sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
       sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-LOCK:
    IF sic_bran.uwd132.bencod = "DSPC" OR
       sic_bran.uwd132.bencod = "NCB"  OR
       sic_bran.uwd132.bencod = "flet" OR 
       SUBSTR(sic_bran.uwd132.bencod,1,2) = "CL" THEN DO:
        nv_stds = YES.
        /*IF nv_dncb = 0 THEN NEXT. */
    END.
    nt_gapprm   = nt_gapprm + uwd132.gap_c.
    nt_pdprm    = nt_pdprm  + uwd132.prem_c.   
END.
IF nv_dncb <> 0 THEN nv_stds = YES.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_43 C-Win 
PROCEDURE 00-pd_add132_43 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : a65-0203...
IF  nv_deci < nt_gapprm THEN DO:
    RUN pd_add132_dspc.
END.
RUN pd_add132_132.

FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
       sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
       sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
       sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
       sic_bran.uwd132.bencod  = "43"           NO-ERROR.
IF  AVAIL  sic_bran.uwd132  THEN  DO:
    IF nv_deci > nt_gapprm  THEN sic_bran.uwd132.gap_c  =  sic_bran.uwd132.gap_c  + (nv_deci - nt_gapprm).
    ELSE sic_bran.uwd132.gap_c  =  sic_bran.uwd132.gap_c  - (nt_gapprm - nv_deci).
    IF nv_deci > nt_pdprm   THEN sic_bran.uwd132.prem_c =  sic_bran.uwd132.prem_c + (nv_deci - nt_pdprm).
    ELSE sic_bran.uwd132.prem_c =  sic_bran.uwd132.prem_c - ( nt_pdprm - nv_deci).
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_dc C-Win 
PROCEDURE 00-pd_add132_dc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
   substr(sic_bran.uwd132.bencod,1,2)  = "CL"        NO-ERROR.
IF  AVAIL  sic_bran.uwd132  THEN  DO:
    ASSIGN
        nt_gapprm = nt_gapprm +  (sic_bran.uwd132.gap_c * -1) 
        nt_pdprm  = nt_pdprm  +  (sic_bran.uwd132.prem_c * -1) .
END.
FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
   sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
   sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
   sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
   sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
   sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
   sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
   sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
   sic_bran.uwd132.bencod  = "DSPC"        NO-ERROR.
IF  AVAIL  sic_bran.uwd132  THEN  DO:
    ASSIGN
        nt_gapprm = nt_gapprm +  (sic_bran.uwd132.gap_c  * -1) 
        nt_pdprm  = nt_pdprm  +  (sic_bran.uwd132.prem_c * -1) .
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_dc2 C-Win 
PROCEDURE 00-pd_add132_dc2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
       sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
       sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
       sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
       sic_bran.uwd132.bencod  = "FLET"           NO-ERROR.
IF  AVAIL  sic_bran.uwd132  THEN  DO:
    ASSIGN
        nt_gapprm = nt_gapprm +  (sic_bran.uwd132.gap_c  * -1) 
        nt_pdprm  = nt_pdprm  +  (sic_bran.uwd132.prem_c * -1) .
   
END. 
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_dc3 C-Win 
PROCEDURE 00-pd_add132_dc3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
                   sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
       sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
       sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
       sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
       sic_bran.uwd132.bencod  = "NCB"           NO-ERROR.
IF  AVAIL  sic_bran.uwd132  THEN  DO:
    ASSIGN
        nt_gapprm = nt_gapprm +  (sic_bran.uwd132.gap_c  * -1) 
        nt_pdprm  = nt_pdprm  +  (sic_bran.uwd132.prem_c * -1) .
   
END. 
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_dspc C-Win 
PROCEDURE 00-pd_add132_dspc :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
DEF VAR nv_dspcvar  AS CHAR INIT "".
DEF VAR nv_dspcvar1 AS CHAR INIT "".
DEF VAR nv_dspcvar2 AS CHAR INIT "".
DEF VAR nv_total    AS DECI INIT 0.
DEF VAR nv_dper     AS DECI INIT 0.
DEF VAR nv_dspco    AS DECI INIT 0.

FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
       sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
       sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
       sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
       sic_bran.uwd132.bencod  = "DSPC"           NO-ERROR.
IF  AVAIL  sic_bran.uwd132  THEN  DO:
    nv_dspco = nv_dsspc.
    nt_gapprm = nt_gapprm + uwd132.prem_c.
END.


nv_total = nt_gapprm - nv_deci.
nv_dper  = (nv_deci * 100) / nv_dper NO-ERROR.
nv_dper  = ROUND(nv_dper, 2).
IF nv_dper > 18 THEN nv_dper = 18.
ASSIGN
    nv_dspcvar   = " "
    nv_dspcvar1  = "Discount Special % = "
    nv_dspcvar2  =  STRING(nv_dper)
    SUBSTRING(nv_dspcvar,1,30)  = nv_dspcvar1
    SUBSTRING(nv_dspcvar,31,30) = nv_dspcvar2.
CREATE sic_bran.uwd132.
ASSIGN
    sic_bran.uwd132.policy = sic_bran.uwm130.policy  
    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt  
    sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt  
    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp 
    sic_bran.uwd132.riskno = sic_bran.uwm130.riskno     
    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno     
    sic_bran.uwd132.bchyr  = sic_bran.uwm130.bchyr      
    sic_bran.uwd132.bchno  = sic_bran.uwm130.bchno      
    sic_bran.uwd132.bchcnt = sic_bran.uwm130.bchcnt     
    sic_bran.uwd132.rateae = YES       
    sic_bran.uwd132.bencod = "DSPC" 
    sic_bran.uwd132.gap_ae = NO    
    sic_bran.uwd132.fptr   = 0
    /*sic_bran.uwd132.gap_c  = nv_gap    */
    sic_bran.uwd132.pd_aep = "E"       
    /*sic_bran.uwd132.prem_c = nv_prem_c */
    /*sic_bran.uwd132.line   = nv_c132*/
    sic_bran.uwd132.benvar = nv_dspcvar.

sic_bran.uwd132.gap_c  = round((nt_gapprm  *  nv_dper  / 100 ) * -1,0).
sic_bran.uwd132.prem_c = round((nt_pdprm   *  nv_dper  / 100 ) * -1,0).
FIND FIRST wf_uwd132  WHERE RECID(wf_uwd132) = uwm130.bptr03 NO-ERROR NO-WAIT.
IF AVAIL wf_uwd132 THEN DO:

    ASSIGN
        sic_bran.uwd132.bptr =  RECID(wf_uwd132)
        wf_uwd132.fptr = RECID(sic_bran.uwd132)
        uwm130.bptr03 = RECID(sic_bran.uwd132).


END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_ncb C-Win 
PROCEDURE 00-pd_add132_ncb :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
IF nv_deci > nt_gapprm THEN nv_dncb = nv_deci - nt_gapprm  .
ELSE DO:
    nv_dncb = nt_gapprm  - nv_deci  .
    nv_dncb = (nv_dncb  * 100) / nt_gapprm.
END.
IF nv_dncb < 10 THEN RETURN.
/*--
IF nv_dncb > 10 AND nv_dncb < 20 THEN DO:
    nv_dncb = 10.
END.
ELSE*/
IF nv_dncb > 20 AND nv_dncb < 30 THEN DO:
    nv_dncb = 20.
END.
ELSE IF nv_dncb > 30 AND nv_dncb < 40 THEN DO:
    nv_dncb = 30.
END.
ELSE IF nv_dncb > 40 AND nv_dncb < 50 THEN DO:
    nv_dncb = 40.
END.
ELSE nv_dncb = 50.
nv_deci  = nv_deci + (nv_deci  * nv_dncb  /  (100 - nv_dncb )) .
nv_deci = ROUND(nv_deci,2).


RUN pd_add132_132.
RUN pd_add132_dc.
ASSIGN
    nv_ncbvar   = " "
    nv_ncbvar1  = "     NCB % = "
    nv_ncbvar2  =  STRING(nv_dncb)
    SUBSTRING(nv_ncbvar,1,30)  = nv_ncbvar1
    SUBSTRING(nv_ncbvar,31,30) = nv_ncbvar2.
CREATE sic_bran.uwd132.
ASSIGN
    sic_bran.uwd132.policy = sic_bran.uwm130.policy  
    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt  
    sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt  
    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp 
    sic_bran.uwd132.riskno = sic_bran.uwm130.riskno     
    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno     
    sic_bran.uwd132.bchyr  = sic_bran.uwm130.bchyr      
    sic_bran.uwd132.bchno  = sic_bran.uwm130.bchno      
    sic_bran.uwd132.bchcnt = sic_bran.uwm130.bchcnt     
    sic_bran.uwd132.rateae = YES       
    sic_bran.uwd132.bencod = "NCB" 
    sic_bran.uwd132.gap_ae = NO    
    sic_bran.uwd132.fptr   = 0
    /*sic_bran.uwd132.gap_c  = nv_gap    */
    sic_bran.uwd132.pd_aep = "E"       
    /*sic_bran.uwd132.prem_c = nv_prem_c */
    /*sic_bran.uwd132.line   = nv_c132*/
    sic_bran.uwd132.benvar = nv_ncbvar.
sic_bran.uwd132.gap_c  = round((nt_gapprm  * nv_dncb / 100 ) * -1,0).
sic_bran.uwd132.prem_c = round((nt_pdprm   * nv_dncb / 100 ) * -1,0).
FIND FIRST wf_uwd132  WHERE RECID(wf_uwd132) = uwm130.bptr03 NO-ERROR NO-WAIT.
IF AVAIL wf_uwd132 THEN DO:

    ASSIGN
        sic_bran.uwd132.bptr =  RECID(wf_uwd132)
        wf_uwd132.fptr = RECID(sic_bran.uwd132)
        uwm130.bptr03 = RECID(sic_bran.uwd132).


END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_add132_nw C-Win 
PROCEDURE 00-pd_add132_nw :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A65-0203...
DEF VAR nv_totncb AS DECI INIT 0.
RUN pd_add132_132.
RUN pd_add132_dc.
RUN pd_add132_dc2.
RUN pd_add132_dc3.
IF nv_flet_per <> 0  THEN DO:
    FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
           sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
           sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
           sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
           sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
           sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
           sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
           sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
           sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
           sic_bran.uwd132.bencod  = "FLET"           NO-ERROR.
    IF  AVAIL  sic_bran.uwd132  THEN  DO:
        sic_bran.uwd132.gap_c  = round((nt_gapprm  * nv_flet_per / 100) * -1,0).
        sic_bran.uwd132.prem_c = round((nt_pdprm   * nv_flet_per / 100) * -1,0).

        
       
    END.
END.
RUN pd_add132_132.
RUN pd_add132_dc.
RUN pd_add132_dc3.
IF nv_dncb <> 0 THEN nv_ncbper = nv_dncb.
IF nv_ncbper <> 0 THEN DO:
    FIND FIRST sic_bran.uwd132  USE-INDEX uwd13201  WHERE
           sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
           sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
           sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
           sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
           sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
           sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
           sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
           sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  AND 
           sic_bran.uwd132.bencod  = "NCB"           NO-ERROR.
    IF  AVAIL  sic_bran.uwd132  THEN  DO:
        sic_bran.uwd132.gap_c  = round((nt_gapprm  * nv_ncbper / 100 ) * -1,0).
        sic_bran.uwd132.prem_c = round((nt_pdprm   * nv_ncbper / 100 ) * -1,0).
        nv_deci =  sic_bran.uwd132.gap_c .
        
    END.
END.                 /*--
RUN pd_add132_132.
RUN pd_add132_dc.
RUN pd_add132_dc2.
IF nv_deci <  THEN */
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDCheckData C-Win 
PROCEDURE BKPDCheckData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF wuwm100.policy = "" THEN DO:
    nv_msg = "Policy not fornd | ". 
END.

IF wuwm100.brnno = "" THEN DO:
    nv_msg = nv_msg + "Branch not found | ".
END.

IF wuwm100.addr1 + wuwm100.addr2 +
   wuwm100.addr3 + wuwm100.addr4 = "" THEN DO:
    nv_msg = nv_msg + "Address not found | ".
END.

IF wuwm100.comdat = ? THEN DO:
    nv_msg = nv_msg + "Comm.Date not found | ".
END.

IF wuwm100.expdat = ? THEN DO:
    nv_msg = nv_msg + "Exp.Date not found | ".
END.

IF wuwm301.makdes = "" THEN DO:
    nv_msg = nv_msg + "Makdes not found | ".
END.

IF wuwm301.manuyr = "" THEN DO:
    nv_msg = nv_msg + "Year Manuf not found | ".
END.

IF wuwm301.covcod = "" THEN DO:
    nv_msg = nv_msg + "Cover Type not found | ".
END.

IF wuwm301.vehreg = "" THEN DO:
    nv_msg = nv_msg + "Registration not found | ".
END.

IF wuwm301.cha_no = "" THEN DO:
    nv_msg = nv_msg + "Chassis No not found | ".
END.

IF wuwm301.sumins = "" THEN DO:
    nv_msg = nv_msg + "Sum Insured not found | ".
END.

IF wuwm301.prem_t = 0 THEN DO:
    nv_msg = nv_msg + "Premium not found | ".
END.

/*MESSAGE  "1101" nv_msg VIEW-AS ALERT-BOX.*/
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDCreate100 C-Win 
PROCEDURE BKPDCreate100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO TRANSACTION:
    FOR EACH wuwm100 WHERE wuwm100.mark = NO NO-LOCK:
        CREATE sic_bran.uwm100.
        ASSIGN
            sic_bran.uwm100.policy  = wuwm100.policy
            sic_bran.uwm100.cr_2    = ""
            sic_bran.uwm100.rencnt  = 0
            sic_bran.uwm100.endcnt  = 0
            sic_bran.uwm100.bchyr   = nv_batchyr 
            sic_bran.uwm100.bchno   = nv_batchno 
            sic_bran.uwm100.bchcnt  = nv_batcnt
            sic_bran.uwm100.renno   = ""
            sic_bran.uwm100.opnpol  = wuwm100.opnpol
            sic_bran.uwm100.poltyp  = wuwm100.poltyp
            sic_bran.uwm100.insref  = wuwm100.insref
            sic_bran.uwm100.anam2   = wuwm100.icno
            sic_bran.uwm100.ntitle  = wuwm100.ntitle
            sic_bran.uwm100.name1   = wuwm100.name1
            sic_bran.uwm100.name2   = ""
            sic_bran.uwm100.name3   = ""
            sic_bran.uwm100.addr1   = wuwm100.addr1
            sic_bran.uwm100.addr2   = wuwm100.addr2
            sic_bran.uwm100.addr3   = wuwm100.addr3
            sic_bran.uwm100.addr4   = wuwm100.addr4
            sic_bran.uwm100.postcd  = ""
            sic_bran.uwm100.undyr   = STRING(YEAR(TODAY),"9999")
            sic_bran.uwm100.branch  = wuwm100.brnno
            sic_bran.uwm100.dept    = "G"
            sic_bran.uwm100.usrid   = USERID(LDBNAME(1))
            /*sic_bran.uwm100.fstdat  = TODAY*//*Comment A56-0345 -3*/
            sic_bran.uwm100.fstdat  = wuwm100.comdat  /*A56-0345 -3*/
            sic_bran.uwm100.comdat  = wuwm100.comdat
            sic_bran.uwm100.expdat  = wuwm100.expdat
            sic_bran.uwm100.accdat  = wuwm100.comdat
            sic_bran.uwm100.tranty  = "N"
            sic_bran.uwm100.langug  = "T"
            sic_bran.uwm100.acctim  = "00:00"
            sic_bran.uwm100.trty11  = "M"      
            sic_bran.uwm100.docno1  =  " " /*STRING(nv_docno,"9999999")*/     
            sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS")
            sic_bran.uwm100.entdat  = TODAY
            sic_bran.uwm100.curbil  = "BHT"
            sic_bran.uwm100.curate  = 1
            sic_bran.uwm100.instot  = 1
            sic_bran.uwm100.prog    = "WGWNLGEN"
            sic_bran.uwm100.cntry   = "TH"        /*Country where risk is situated*/
            sic_bran.uwm100.insddr  = YES         /*Print Insd. Name on DrN       */
            sic_bran.uwm100.no_sch  = 0           /*No. to print, Schedule        */
            sic_bran.uwm100.no_dr   = 1           /*No. to print, Dr/Cr Note      */
            sic_bran.uwm100.no_ri   = 0           /*No. to print, RI Appln        */
            sic_bran.uwm100.no_cer  = 0           /*No. to print, Certificate     */
            sic_bran.uwm100.li_sch  = YES         /*Print Later/Imm., Schedule    */
            sic_bran.uwm100.li_dr   = YES         /*Print Later/Imm., Dr/Cr Note  */
            sic_bran.uwm100.li_ri   = YES         /*Print Later/Imm., RI Appln,   */
            sic_bran.uwm100.li_cer  = YES         /*Print Later/Imm., Certificate */
            sic_bran.uwm100.apptax  = YES         /*Apply risk level tax (Y/N)    */
            sic_bran.uwm100.recip   = "N"         /*Reciprocal (Y/N/C)            */
            sic_bran.uwm100.short   = NO
            sic_bran.uwm100.acno1   = fi_producer
            sic_bran.uwm100.agent   = fi_agent
            sic_bran.uwm100.insddr  = NO
            sic_bran.uwm100.coins   = NO
            sic_bran.uwm100.billco  = ""
            sic_bran.uwm100.fptr01  = 0        sic_bran.uwm100.bptr01 = 0
            sic_bran.uwm100.fptr02  = 0        sic_bran.uwm100.bptr02 = 0
            sic_bran.uwm100.fptr03  = 0        sic_bran.uwm100.bptr03 = 0
            sic_bran.uwm100.fptr04  = 0        sic_bran.uwm100.bptr04 = 0
            sic_bran.uwm100.fptr05  = 0        sic_bran.uwm100.bptr05 = 0
            sic_bran.uwm100.fptr06  = 0        sic_bran.uwm100.bptr06 = 0  
            sic_bran.uwm100.styp20  = "NORM"
            sic_bran.uwm100.dir_ri  = YES
            sic_bran.uwm100.drn_p   = NO
            sic_bran.uwm100.sch_p   = NO
            sic_bran.uwm100.prvpol  = ""
            sic_bran.uwm100.cedpol  = wuwm100.cedpol
            sic_bran.uwm100.finint  = ""
            sic_bran.uwm100.bs_cd   = ""
            sic_bran.uwm100.polsta  = "IF"
            sic_bran.uwm100.gstrat  = 7
            sic_bran.uwm100.trndat = TODAY
            .

        IF  (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
             MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
             YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
            (DAY(sic_bran.uwm100.comdat)      =  29                             AND
             MONTH(sic_bran.uwm100.comdat)    =  02                             AND
             DAY(sic_bran.uwm100.expdat)      =  01                             AND
             MONTH(sic_bran.uwm100.expdat)    =  03                             AND
             YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN nv_polday = 365.
        ELSE nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .

        /*-- Create Insure Code --*/
        IF sic_bran.uwm100.insref = "" THEN DO:
            RUN PDCreateIns.
            sic_bran.uwm100.insref = nv_insref.
            nv_insref = "".
        END.
        /*-- End Create Insure Code --*/
        s_recid1 = RECID(sic_bran.uwm100).

        RUN PDCreate100d.

        RUN PDCreate102d.

        RUN PDCreate120.

        RUN PDCreate130.

        RUN PDCreate301.

        RUN PDChkPrm132.

        RUN PDCreate132.

        RUN PDAutoSave.

        RUN PDClearData.

        /*RUN PDChkMthPrm.*/

    END.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDGenV70 C-Win 
PROCEDURE BKPDGenV70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH wexcel:
    DELETE wexcel.
END.

FOR EACH wuwm100:
    DELETE wuwm100.
END.
nt_count_pol = 0.
INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.mdat    
        wexcel.ddat    
        wexcel.brndel  
        wexcel.brnare  
        wexcel.covcod  
        wexcel.makdes  
        wexcel.moddes  
        wexcel.engine  
        wexcel.cha_no  
        wexcel.gwv     
        wexcel.seat    
        wexcel.inspec  
        wexcel.vehtyp  
        wexcel.vehuse  
        wexcel.CLASS   
        wexcel.yr      
        wexcel.yrmanu  
        wexcel.vehreg  
        wexcel.provin  
        wexcel.sitot   
        wexcel.si      
        wexcel.prem    
        wexcel.garage  
        wexcel.insure  
        wexcel.broker  
        wexcel.confirm 
        wexcel.staff   
        wexcel.comdat  
        wexcel.datto   
        wexcel.expdat  
        wexcel.name1   
        wexcel.addr1   
        wexcel.addr2   
        wexcel.addr3   
        wexcel.addr4   
        wexcel.postcod 
        wexcel.icno    
        wexcel.bennam  
        wexcel.chknam  
        wexcel.chkq    
        wexcel.cedpol  
        wexcel.recnam 
        wexcel.campaign 
        wexcel.titlemail
        wexcel.datrec   
        wexcel.timrec   
        wexcel.docnote
    .

    IF wexcel.cedpol <> "" THEN nt_count_pol = nt_count_pol + 1.

    fi_display = "Please wait..Process Input Data...".
    DISP fi_display WITH FRAME fr_main.

END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPDMatch100 C-Win 
PROCEDURE BKPDMatch100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*fi_display = "Please wait..Process Match Data 100 ...".
DISP fi_display WITH FRAME fr_main.

FOR EACH wexcel WHERE wexcel.cedpol <> "" NO-LOCK:

    /*-- Create wuwm100 --*/
    CREATE wuwm100.

    IF wexcel.cedpol <> "" THEN DO:
        IF INDEX(wexcel.cedpol,"/") <> 0 THEN DO:
            wuwm100.policy = TRIM(SUBSTR(wexcel.cedpol,1,INDEX(wexcel.cedpol,"/") - 1) +
                                  SUBSTR(wexcel.cedpol,INDEX(wexcel.cedpol,"/") + 1,5)).
        END.
    END.
    ELSE wuwm100.policy = "STY" + STRING(YEAR(TODAY)) + STRING(TIME,"HH:MM:SS").

    IF wexcel.brndel <> "" THEN DO:
        FIND FIRST stat.insure WHERE 
                   stat.insure.compno = "NTL" AND
                   stat.insure.insno  = TRIM(wexcel.brndel) NO-LOCK NO-ERROR.
        IF AVAIL stat.insure THEN DO:
            wuwm100.brnno = stat.insure.branch.
        END.
        ELSE DO:
            wuwm100.brnno = fi_branch.
        END.
    END.

    IF wexcel.name1 <> "" THEN DO:

        IF INDEX(wexcel.name1,"นางสาว") <> 0 THEN DO: 
            wuwm100.ntitle = "นางสาว".
        END.
        ELSE DO:
            FOR EACH brstat.msgcode WHERE
                       brstat.msgcode.compno = "999" AND
                 INDEX(wexcel.name1,TRIM(brstat.msgcode.msgdesc)) <> 0 NO-LOCK:
                wuwm100.ntitle = brstat.msgcode.msgdesc.
            END.
        END.

        IF wuwm100.ntitle <> "" THEN DO:
            wuwm100.name1  = SUBSTR(wexcel.name1,LENGTH(wuwm100.ntitle) + 1,LENGTH(wexcel.name1)).
        END.
        ELSE wuwm100.name1 = wexcel.name1.
    END.

    ASSIGN
        wuwm100.poltyp    = "V70"
        wuwm100.opnpol    = wexcel.brndel + "/" + wexcel.brnare
        wuwm100.cr_1      = ""
        wuwm100.acno      = fi_producer
        wuwm100.agent     = fi_agent
        wuwm100.insref    = ""
        wuwm100.name2     = ""
        wuwm100.icno      = wexcel.icno
        wuwm100.addr1     = wexcel.addr1
        wuwm100.addr2     = wexcel.addr2
        wuwm100.addr3     = wexcel.addr3
        wuwm100.addr4     = wexcel.addr4
        wuwm100.comdat    = DATE(wexcel.comdat)
        wuwm100.expdat    = DATE(wexcel.expdat)
        wuwm100.cedpol    = wexcel.cedpol
        wuwm100.campaign  = wexcel.campaign 
        wuwm100.titlemail = wexcel.titlemail
        wuwm100.datrec    = wexcel.datrec   
        wuwm100.timrec    = wexcel.timrec   
        wuwm100.docnote   = wexcel.docnote 
        wuwm100.staff     = wexcel.staff
        .

    /*MESSAGE 
        "wuwm100.policy= "  + wuwm100.policy skip
        "wuwm100.brnno = "  + wuwm100.brnno  skip
        "wuwm100.ntitle= "  + wuwm100.ntitle skip
        "wuwm100.name1 = "  + wuwm100.name1  skip
        "wuwm100.poltyp= "  + wuwm100.poltyp skip
        "wuwm100.opnpol= "  + wuwm100.opnpol skip
        "wuwm100.cr_1  = "  + wuwm100.cr_1   skip
        "wuwm100.acno  = "  + wuwm100.acno   skip
        "wuwm100.agent = "  + wuwm100.agent  skip
        "wuwm100.insref= "  + wuwm100.insref skip
        "wuwm100.name2 = "  + wuwm100.name2  skip
        "wuwm100.icno  = "  + wuwm100.icno   skip
        "wuwm100.addr1 = "  + wuwm100.addr1  skip
        "wuwm100.addr2 = "  + wuwm100.addr2  skip
        "wuwm100.addr3 = "  + wuwm100.addr3  skip
        "wuwm100.addr4 = "  + wuwm100.addr4  skip
        "wuwm100.comdat= "  + STRING(wuwm100.comdat) skip
        "wuwm100.expdat= "  + STRING(wuwm100.expdat) skip
        "wuwm100.cedpol= "  + wuwm100.cedpol .*/
    /*-- End Create 100 --*/

    /*-- Create 301 --*/
    CREATE wuwm301.

    ASSIGN
        wuwm301.policy = wuwm100.policy
        wuwm301.sclass = wexcel.CLASS
        wuwm301.makdes = wexcel.makdes
        wuwm301.moddes = wexcel.moddes
        wuwm301.manuyr = wexcel.yrmanu
        /*wuwm301.vehgrp = ""
        wuwm301.body   = ""*/
        wuwm301.engine = wexcel.engine
        wuwm301.tons   = wexcel.gwv
        wuwm301.seat   = wexcel.seat
        wuwm301.vehuse = wexcel.vehuse
        wuwm301.covcod = wexcel.covcod
        /*wuwm301.garage = "อู่"
        wuwm301.vehreg = wexcel.vehreg + "จังหวัด"*/
        wuwm301.cha_no = wexcel.cha_no
        wuwm301.eng_no = ""
        /*wuwm301.tp_bi1 = ""
        wuwm301.tp_bi2 = ""
        wuwm301.tp_pd  = ""*/
        wuwm301.sumins = wexcel.si
        wuwm301.sumfit = wexcel.si
        wuwm301.prem_t = DECI(wexcel.prem)
        wuwm301.base1  = ""
        /*wuwm301.pa411  = ""
        wuwm301.pa412  = ""
        wuwm301.pa42   = ""
        wuwm301.pa43   = ""*/
        wuwm301.base3  = ""
        wuwm301.dedod  = ""
        wuwm301.deaod  = ""
        wuwm301.dedpd  = ""
        wuwm301.fleet  = ""
        wuwm301.ncbper = ""
        wuwm301.dspc   = ""
        wuwm301.staff  = ""
        wuwm301.loadcl = ""
        wuwm301.inspec = wexcel.inspec
        wuwm301.benanm = wexcel.bennam.

    IF wexcel.covcod = "2+" THEN wuwm301.covcod = "2.2".
    ELSE IF wexcel.covcod = "3+" THEN wuwm301.covcod = "3.2".

    IF wexcel.garage <> "" THEN DO:
        IF wexcel.garage = "อู่" THEN wuwm301.garage = "G".
    END.

    IF INDEX(wexcel.vehreg,"-") <> 0 THEN DO:
        wexcel.vehreg = SUBSTR(wexcel.vehreg,1,INDEX(wexcel.vehreg,"-") - 1) + " " +
                        SUBSTR(wexcel.vehreg,INDEX(wexcel.vehreg,"-") + 1,10).
    END.

    IF wexcel.provin <> "" AND LENGTH(wexcel.provin) > 2 THEN DO:
        FIND FIRST brstat.insure WHERE 
                   brstat.insure.compno = "999" AND 
                   brstat.insure.fname  = TRIM(wexcel.provin) NO-LOCK NO-ERROR.
        IF AVAIL brstat.insure THEN DO:
            wuwm301.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(brstat.insure.lname).
        END.
        ELSE wuwm301.vehreg = TRIM(wexcel.vehreg).
    END.
    ELSE wuwm301.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(wexcel.provin).

    /*-- Redbook --*/
    IF wexcel.CLASS <> "" THEN DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                   stat.maktab_fil.sclass BEGINS wexcel.CLASS 
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            wexcel.CLASS = stat.maktab_fil.sclass.
            FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                       stat.maktab_fil.sclass = wexcel.CLASS AND
                       stat.maktab_fil.makdes BEGINS wexcel.makdes 
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.maktab_fil THEN DO:
                wexcel.makdes = stat.maktab_fil.makdes.
                FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                           stat.maktab_fil.sclass = wexcel.class AND
                           stat.maktab_fil.makdes = wexcel.makdes AND
                           stat.maktab_fil.moddes BEGINS wexcel.moddes 
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.maktab_fil THEN DO:
                    wexcel.moddes = stat.maktab_fil.moddes.
                    FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                               stat.maktab_fil.sclass = wexcel.class AND
                               stat.maktab_fil.makdes = wexcel.makdes AND
                               stat.maktab_fil.moddes = wexcel.moddes AND
                               stat.maktab_fil.makyea >= INTE(wexcel.yrmanu) 
                    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL stat.maktab_fil THEN DO:
                        ASSIGN
                            wuwm301.modcod = stat.maktab_fil.modcod
                            wuwm301.vehgrp = stat.maktab_fil.prmpac
                            wuwm301.body   = stat.maktab_fil.body
                            wuwm301.seat   = STRING(stat.maktab_fil.seat).
                    END.
                END.
            END.
        END.
    END.
    ELSE DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
                   stat.maktab_fil.makdes BEGINS wexcel.makdes NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            wexcel.makdes = stat.maktab_fil.makdes.
            FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
                       stat.maktab_fil.makdes = wexcel.makdes AND
                       stat.maktab_fil.moddes BEGINS wexcel.moddes NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.maktab_fil THEN DO:
                wexcel.moddes = stat.maktab_fil.moddes.
                FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
                           stat.maktab_fil.makdes = wexcel.makdes AND
                           stat.maktab_fil.moddes = wexcel.moddes AND
                           stat.maktab_fil.makyea >= INTE(wexcel.yrmanu) NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.maktab_fil THEN DO:
                    ASSIGN
                        wuwm301.modcod = stat.maktab_fil.modcod
                        wuwm301.vehgrp = stat.maktab_fil.prmpac
                        wuwm301.body   = stat.maktab_fil.body
                        wuwm301.seat   = STRING(stat.maktab_fil.seat).
                END.
            END.
        END.
    END.
    /*-- End Redbook --*/

    /*-- ความคุ้มครอง --*/

    /*MESSAGE fi_campaign SKIP wexcel.covcod SKIP wexcel.CLASS SKIP wuwm301.garage VIEW-AS ALERT-BOX.*/

    IF fi_campaign <> "" THEN DO:
        FIND FIRST brstat.campaign WHERE
                   brstat.campaign.tltc    = fi_campaign    AND
                   brstat.campaign.usrid   = "NTL"          AND
                   brstat.campaign.covcod  = wexcel.covcod  AND
                   brstat.campaign.CLASS   = wexcel.CLASS   AND
                   brstat.campaign.garage  = wuwm301.garage /*AND
                   brstat.campaign.effdat <= DATE(wexcel.comdat)*/ NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL brstat.campaign THEN DO:
            ASSIGN
                wuwm301.tp_bi1 = brstat.campaign.baseprm
                wuwm301.tp_bi2 = brstat.campaign.fleet
                wuwm301.tp_pd  = brstat.campaign.dspc
                wuwm301.pa411  = brstat.campaign.mv1
                wuwm301.pa412  = brstat.campaign.mv1s
                wuwm301.pa42   = brstat.campaign.mv2
                wuwm301.pa43   = brstat.campaign.mv3.
        END.
        ELSE DO:
            /*MESSAGE "ไม่พบความคุ้มครอง" VIEW-AS ALERT-BOX.*/

            FIND FIRST brstat.campaign WHERE
                       brstat.campaign.tltc    = fi_campaign    AND
                       brstat.campaign.usrid   = "NTL"          AND
                       brstat.campaign.covcod  = wexcel.covcod  AND
                       brstat.campaign.CLASS   = wexcel.CLASS   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL brstat.campaign THEN DO:
                ASSIGN
                    wuwm301.tp_bi1 = brstat.campaign.baseprm
                    wuwm301.tp_bi2 = brstat.campaign.fleet
                    wuwm301.tp_pd  = brstat.campaign.dspc
                    wuwm301.pa411  = brstat.campaign.mv1
                    wuwm301.pa412  = brstat.campaign.mv1s
                    wuwm301.pa42   = brstat.campaign.mv2
                    wuwm301.pa43   = brstat.campaign.mv3.
            END.
        END.
    END.
    /*-- End Create 301 --*/

    RUN PDCheckData.
/*MESSAGE "11102" nv_msg VIEW-AS ALERT-BOX.*/
    wuwm100.msg = nv_msg.
    
    IF nv_msg <> "" THEN wuwm100.mark = YES.

    nv_msg = "".

END.
*/

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
  DISPLAY fi_camptruck fi_ispyr ra_type fi_display fi_loaddat fi_branch fi_bchno 
          fi_producer fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 
          fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt 
          fi_completecnt fi_proname fi_agtname fi_premtot fi_premsuc fi_package 
          fi_txt 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE brquery fi_camptruck fi_ispyr ra_type fi_display fi_loaddat fi_branch 
         fi_bchno fi_producer fi_agent fi_prevbat fi_bchyr fi_filename bu_file 
         fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit 
         bu_hpbrn bu_hpacno1 bu_hpagent fi_package fi_txt RECT-368 RECT-370 
         RECT-373 RECT-374 RECT-375 RECT-376 RECT-372 RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdAssignDataCalNew C-Win 
PROCEDURE PdAssignDataCalNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    nv_covcod  = wexcel.covcod              nv_ncbamt   = 0  
    nv_class   = sic_bran.uwm120.CLASS      nv_fletamt  = 0  
    nv_vehuse  = wexcel.vehuse              nv_dspcamt  = 0  
    nv_driage1 = INT(wexcel.driage1)        nv_dstfamt  = 0  
    nv_driage2 = INT(wexcel.driage2)        nv_clmamt   = 0  
    nv_yrmanu  = INT(wexcel.yrmanu)         nv_baseprm  = deci(wexcamp.base1) 
    nv_totsi   = sic_bran.uwm130.uom6_v     nv_baseprm3 = deci(wexcamp.base2) 
    nv_totfi   = sic_bran.uwm130.uom7_v     nv_netprem  = DECI(wexcamp.Prem_t)
    nv_vehgrp  = wexcel.vehgrp              nv_pdprem   = DECI(wexcamp.Prem_t)
    nv_access  = wexcamp.acc                nv_gapprm   = 0                   
    nv_tpbi1si = int(wexcamp.tp_bi1)        nv_flagprm  = "N"                 
    nv_tpbi2si = int(wexcamp.tp_bi2)        nv_effdat   = sic_bran.uwm100.comdat  
    nv_tppdsi  = int(wexcamp.tp_pd)         nv_ratatt   = 0                       
    nv_411si   = int(wexcamp.pa411)         nv_siatt    = 0                       
    nv_412si   = int(wexcamp.pa412)         nv_netatt   = 0                       
    nv_413si   = 0                          nv_fltatt   = 0                       
    nv_414si   = 0                          nv_ncbatt   = 0                       
    nv_42si    = int(wexcamp.pa42)          nv_dscatt   = 0                       
    nv_43si    = int(wexcamp.pa43)          nv_attgap   = 0                       
    nv_41prmt  = 0                          nv_atfltgap = 0                       
    nv_412prmt = 0                          nv_atncbgap = 0                       
    nv_413prmt = 0                          nv_atdscgap = 0                       
    nv_414prmt = 0                          nv_packatt  = ""                      
    nv_42prmt  = 0                          nv_flgsht   = "P"                     
    nv_43prmt  = 0                          nv_fcctv    = NO                    
    nv_seat41  = INT(wexcel.seat)     
    nv_dedod   = INTE(wexcel.dedtp)               
    nv_addod   = 0                    
    nv_dedpd   = INTE(wexcel.dedpd)                    
    nv_ncbp    = deci(wexcamp.ncb )   
    nv_fletp   = deci(wexcamp.fleet)  
    nv_dspcp   = deci(wexcamp.dspc)   
    nv_dstfp   = 0                    
    nv_clmp    = deci(wexcamp.loadcl) 
    nv_mainprm  = 0      
    .

ASSIGN
    nv_evflg    = wexcel.evflg                 nv_chgflg     = IF sic_bran.uwm301.chargflg = "Y" THEN nv_chgflg = YES ELSE nv_chgflg = NO
    nv_diffprm  = 5                            nv_chgrate    = 0 
    nv_newpdprm = DECI(wexcamp.Prem_t)         nv_chgsi      = sic_bran.uwm301.chargsi
    nv_newgpprm = DECI(wexcamp.Prem_t)          
    nv_adjpaprm = NO                           
    nv_adjprem  = YES                          
    nv_flgpol   = "NU"                         nv_battrate   = 0 
    nv_flgclm   = "NC"                         nv_battsi     = sic_bran.uwm301.battsi
    cv_lfletper = 10                           nv_battprice  = 0 
    cv_lncbper  = 50                           
    cv_ldssper  = 40                            
    cv_lclmper  = 50                           nv_battyr     = sic_bran.uwm301.battyr 
    cv_ldstfper = 18                           nv_battper    = sic_bran.uwm301.battper
    nv_reflag   = NO  /*ไม่ Re-Calculate?*/    nv_compprm    = 0
    nv_packatt1 = ""                           nv_uom9_v     = 0
    nv_attgapt  = 0                            nv_levcod     = nv_levcod
    nv_levper   = nv_levper                    nv_tariff     = sic_bran.uwm301.tariff   
    .

FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
          sicsyac.xmm106.tariff = "X"       AND
          sicsyac.xmm106.bencod = "DC01"    AND
          sicsyac.xmm106.class  = nv_class  AND
          sicsyac.xmm106.key_b  GE 0        AND
          sicsyac.xmm106.effdat LE 01/01/2024
NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm106 THEN DO:
    IF sicsyac.xmm106.baseap <> 0 THEN DO:
        IF INTE(wexcel.dedtp) > sicsyac.xmm106.baseap THEN DO:
            nv_dedod = sicsyac.xmm106.baseap.
            nv_addod = INTE(wexcel.dedtp) - sicsyac.xmm106.baseap.
        END.
        ELSE DO:
            nv_dedod = INTE(wexcel.dedtp).
            nv_addod = 0.
        END.
    END.
END.

FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           stat.clastab_fil.CLASS  = nv_class      AND
           stat.clastab_fil.covcod = wexcel.covcod NO-LOCK NO-ERROR.
IF AVAIL stat.clastab_fil THEN DO:
    IF clastab_fil.unit = "C" THEN DO:
        ASSIGN
            nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
            nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(sic_bran.uwm301.watt) ELSE INT(sic_bran.uwm301.engine).
    END.
    ELSE IF clastab_fil.unit = "S" THEN DO: 
        ASSIGN                                
            nv_cstflg = clastab_fil.unit
            nv_engine = INT(wexcel.seat).
    END.
    ELSE IF clastab_fil.unit = "T" THEN DO:
        ASSIGN
            nv_cstflg = clastab_fil.unit
            nv_engine = INTE(sic_bran.uwm301.tons).
    END.
    ELSE IF clastab_fil.unit = "H" THEN DO:
        ASSIGN
            nv_cstflg = clastab_fil.unit
            nv_engine = INTE(sic_bran.uwm301.watts).
    END.
    nv_engcst = nv_engine .
END.

IF wexcel.modcod = ""  THEN DO:
    IF nv_cstflg <> "T" THEN DO:
        RUN wgw/wgwredbk1(input  wexcel.makdes ,       /*A65=0079*/
                           input wexcel.moddes ,  
                           input  nv_totsi      ,  
                           INPUT  "X" ,  
                           input  SUBSTR(nv_class,2,5),   
                           input  wexcel.yrmanu, 
                           input  nv_engine  ,
                           input  0 , 
                           INPUT-OUTPUT wexcel.modcod) .
    END.
    ELSE DO:
        RUN wgw/wgwredbk1(input  wexcel.makdes ,       /*A65=0079*/
                           input wexcel.moddes ,  
                           input  nv_totsi      ,  
                           INPUT  "X" ,  
                           input  SUBSTR(nv_class,2,5),   
                           input  wexcel.yrmanu, 
                           input  nv_engine  ,
                           input  0 , 
                           INPUT-OUTPUT wexcel.modcod) .
    END.

    IF wexcel.modcod <> ""  THEN ASSIGN sic_bran.uwm301.modcod = wexcel.modcod .
    ELSE DO:
     ASSIGN
          wexcel.werror = wexcel.werror + "Redbook is Null !!  |"
          wexcel.wmark  = NO.
    END.
END.

FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wexcel.makdes AND 
                                maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
    IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
       MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
        YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
       ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
       MONTH(sic_bran.uwm100.comdat)     =   02                             AND
         DAY(sic_bran.uwm100.expdat)     =   01                             AND
       MONTH(sic_bran.uwm100.expdat)     =   03                             AND
        YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
    THEN DO:
      nv_polday = 365.
    END.
    ELSE DO:
      nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
    END.
END.

IF nv_polday < 365 THEN DO:
    nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDAutoSave C-Win 
PROCEDURE PDAutoSave :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: USOPL80      
------------------------------------------------------------------------------*/

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
IF NOT AVAIL sic_bran.uwm100 THEN DO:
    MESSAGE "not found (uwm100./USOPL80)" VIEW-AS ALERT-BOX.
END.
ELSE DO:
    FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
             sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
             sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
             sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
             sic_bran.uwm120.bchyr  = sic_bran.uwm100.bchyr  AND
             sic_bran.uwm120.bchno  = sic_bran.uwm100.bchno  AND
             sic_bran.uwm120.bchcnt = sic_bran.uwm100.bchcnt :

        FOR EACH sic_bran.uwm130 USE-INDEX uwm13001 WHERE
                 sic_bran.uwm130.policy = sic_bran.uwm120.policy AND
                 sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt AND
                 sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt AND
                 sic_bran.uwm130.bchyr  = sic_bran.uwm120.bchyr  AND
                 sic_bran.uwm130.bchno  = sic_bran.uwm120.bchno  AND
                 sic_bran.uwm130.bchcnt = sic_bran.uwm120.bchcnt NO-LOCK:

            n_sigr_r = n_sigr_r + uwm130.uom6_v.

            FOR EACH sic_bran.uwd132 USE-INDEX uwd13201 WHERE
                     sic_bran.uwd132.policy = sic_bran.uwm130.policy AND
                     sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt AND
                     sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt AND
                     sic_bran.uwd132.riskno = sic_bran.uwm130.riskno AND
                     sic_bran.uwd132.itemno = sic_bran.uwm130.itemno AND
                     sic_bran.uwd132.bchyr  = sic_bran.uwm130.bchyr  AND
                     sic_bran.uwd132.bchno  = sic_bran.uwm130.bchno  AND
                     sic_bran.uwd132.bchcnt = sic_bran.uwm130.bchcnt NO-LOCK:

                IF sic_bran.uwd132.bencod = "COMP" THEN DO:
                    nt_compprm = nt_compprm + uwd132.prem_c.
                END.

                n_gap_r  = uwd132.gap_c  + n_gap_r.
                n_prem_r = uwd132.prem_c + n_prem_r.
            END.  /*uwd132*/
        END.  /*uwm130*/

        sic_bran.uwm120.gap_r  = n_gap_r.
        sic_bran.uwm120.prem_r = n_prem_r.
        sic_bran.uwm120.sigr   = n_sigr_r.

        n_gap_t  = n_gap_t   + n_gap_r.
        n_prem_t = n_prem_t  + n_prem_r.
        n_sigr_t = n_sigr_t  + n_sigr_r.

        n_gap_r  = 0.  n_prem_r  = 0.  n_sigr_r  = 0.
    END.  /*uwm120*/

    sic_bran.uwm100.gap_p  = n_gap_t.
    sic_bran.uwm100.prem_t = n_prem_t.
    sic_bran.uwm100.sigr_p = n_sigr_t.

    n_gap_t = 0. n_prem_t = 0. n_sigr_t = 0.

END.  /*else do*/

IF sic_bran.uwm100.instot = 0 OR sic_bran.uwm100.instot = ? THEN sic_bran.uwm100.instot = 1.

FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
           sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
           sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
           sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
           sic_bran.uwm120.bchyr  = sic_bran.uwm100.bchyr  AND
           sic_bran.uwm120.bchno  = sic_bran.uwm100.bchno  AND
           sic_bran.uwm120.bchcnt = sic_bran.uwm100.bchcnt NO-ERROR.

FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
           sicsyac.xmm600.acno = sic_bran.uwm100.acno1 NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm600 THEN DO:
    nv_acdes = TRIM(TRIM(xmm600.ntitle) + " " + TRIM(xmm600.name)).
END.

FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
     sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp 
NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.xmm031 THEN DO:
    nv_com1_per = 0.
END.
ELSE nv_com1_per = sicsyac.xmm031.comm1.

/*IF nv_dss_per <> 0 THEN nv_com1_per = nv_com1_per - nv_dss_per. /*---add by Chaiyong W. A60-0016 08/02/2018*/ -- Comment By Tontawan S. A64-0149 07/04/2021 */
IF nv_com1_per < 0 THEN nv_com1_per = 0. /*---add by Chaiyong W. A60-0016 08/02/2018*/
IF nt_compprm <> 0 THEN DO:
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.polty = "V72"
    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sic_bran.xmm031 THEN nv_com2_per = 0.
                                 ELSE nv_com2_per = sicsyac.xmm031.comm1.
END.
ELSE nv_com2_per = 0.

IF n_comm1 = 0 AND n_comm2 = 0 THEN DO:
    ASSIGN
        n_comm1 = nv_com1_per
        n_comm2 = nv_com2_per.  
END.

FIND sicsyac.xmm020 USE-INDEX xmm02001 WHERE 
     sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
     sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN DO:
    nv_stamp_per = xmm020.rvstam.
    nv_tax_per   = xmm020.rvtax.
END.

IF sic_bran.uwm120.stmpae = YES THEN DO:
    IF (((sic_bran.uwm100.prem_t * nv_stamp_per) / 100) - TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0)) > 0 THEN DO:
        sic_bran.uwm100.rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0) + 1.     
    END.
    ELSE sic_bran.uwm100.rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_stamp_per / 100,0) .
END.

IF sic_bran.uwm120.taxae = YES THEN DO:
    sic_bran.uwm100.rtax_t  = (sic_bran.uwm100.prem_t + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp)
                               * nv_tax_per  / 100.
END.

IF sic_bran.uwm120.com1ae = YES THEN DO:
    IF sic_bran.uwm120.com1p <> 0 THEN nv_com1_per  = sic_bran.uwm120.com1p.
    ELSE sic_bran.uwm120.com1p = nv_com1_per.   
    sic_bran.uwm100.com1_t = - (sic_bran.uwm100.prem_t - nt_compprm) * sic_bran.uwm120.com1p / 100.
END.

IF sic_bran.uwm120.com2ae  = YES THEN DO: 
    IF sic_bran.uwm120.com2p <> 0 THEN nv_com2_per  = sic_bran.uwm120.com2p.
    ELSE sic_bran.uwm120.com2p = nv_com2_per.
    sic_bran.uwm100.com2_t  = - nt_compprm * sic_bran.uwm120.com2p / 100.
END.

nv_com12_t = sic_bran.uwm100.com1_t + sic_bran.uwm100.com2_t.
     
IF sic_bran.uwm100.no_sch <> 0 THEN DO:
    IF sic_bran.uwm100.rstp_t LE 5 THEN sic_bran.uwm100.pstp =  1.
                                   ELSE sic_bran.uwm100.pstp = sic_bran.uwm100.no_sch  * 5.
END.

nv_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
          + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.
nv_netprm_t = nv_netprm_t + nv_netprm.

RUN PDUpdateUwm120.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCalPremNew C-Win 
PROCEDURE PdCalPremNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

RUN WGW\WGWMCP01.P (INPUT sic_bran.uwm100.policy,            
                    INPUT sic_bran.uwm100.policy,                                  
                    INPUT sic_bran.uwm100.rencnt,            
                    INPUT sic_bran.uwm100.endcnt,            
                    INPUT sic_bran.uwm130.riskgp ,                                 
                    INPUT sic_bran.uwm130.riskno ,                                 
                    INPUT sic_bran.uwm130.itemno ,                                 
                    INPUT sic_bran.uwm100.bchyr ,                        
                    INPUT sic_bran.uwm100.bchno ,                        
                    INPUT sic_bran.uwm100.bchcnt,                                 
                    INPUT nv_polday ,                        
                    INPUT USERID(LDBNAME(1)),                                  
                    INPUT sic_bran.uwm100.prog,                                  
                    INPUT nv_diffprm,                                  
                                                                                  
                    INPUT nv_tariff ,                                  
                    INPUT nv_covcod ,                        
                    INPUT nv_class  ,                        
                    INPUT nv_vehuse ,                        
                    INPUT nv_cstflg ,                        
                    INPUT nv_engcst ,                        
                    INPUT nv_drivno ,                        
                    INPUT nv_driage1,                        
                    INPUT nv_driage2,                        
                    INPUT nv_levcod ,                                 
                    INPUT nv_levper ,                                 
                    INPUT nv_yrmanu ,                        
                    INPUT nv_totsi  ,                        
                    INPUT nv_totfi  ,                                
                                                                                  
                    INPUT nv_vehgrp,                         
                    INPUT nv_access,                         
                    INPUT nv_supe  ,                         
                                                            
                    INPUT nv_tpbi1si,                        
                    INPUT nv_tpbi2si,                        
                    INPUT nv_tppdsi ,                        
                                                                                                
                    INPUT nv_411si,                          
                    INPUT nv_412si,                          
                    INPUT nv_413si,                          
                    INPUT nv_414si,                          
                    INPUT nv_42si ,                          
                    INPUT nv_43si ,                          
                    INPUT nv_41prmt ,                        
                    INPUT nv_412prmt,                                   
                    INPUT nv_413prmt,                                  
                    INPUT nv_414prmt,                                  
                    INPUT nv_42prmt,                         
                    INPUT nv_43prmt,                         
                    INPUT nv_seat41,                         
                                                            
                    INPUT nv_dedod,                          
                    INPUT nv_addod,                          
                    INPUT nv_dedpd,                          
                                                                                  
                    INPUT nv_dodamt,                                           
                    INPUT nv_dadamt,                                  
                    INPUT nv_dpdamt,                                  
                                                                                                
                    INPUT nv_newpdprm,                                  
                    INPUT nv_newgpprm,                                  
                    INPUT nv_flagprm ,                                   
                                                           
                    INPUT nv_effdat,                        
                                                            
                    INPUT nv_adjpaprm,                                     
                    INPUT nv_adjprem ,                                  
                    INPUT nv_flgpol  ,                                  
                    INPUT nv_flgclm  ,                                  
                                                            
                    INPUT cv_lfletper,                                    
                    INPUT cv_lncbper ,                                  
                    INPUT cv_ldssper ,                                  
                    INPUT cv_lclmper ,                                  
                    INPUT cv_ldstfper,                                  
                    INPUT nv_reflag  ,                                  

                    INPUT-OUTPUT nv_ncbyrs,
                    INPUT-OUTPUT nv_ncbp,    
                    INPUT-OUTPUT nv_fletp,  
                    INPUT-OUTPUT nv_dspcp,  
                    INPUT-OUTPUT nv_dstfp,  
                    INPUT-OUTPUT nv_clmp,   
                                                     
                    INPUT-OUTPUT nv_pdprm0, 
                    INPUT-OUTPUT nv_ncbamt, 
                    INPUT-OUTPUT nv_fletamt,
                    INPUT-OUTPUT nv_dspcamt, 
                    INPUT-OUTPUT nv_dstfamt,
                    INPUT-OUTPUT nv_clmamt,
                                                          
                    INPUT-OUTPUT nv_baseprm , 
                    INPUT-OUTPUT nv_baseprm3, 
                    INPUT-OUTPUT nv_mainprm ,
                                                                                                               
                    INPUT-OUTPUT nv_ratatt,  
                    INPUT-OUTPUT nv_siatt ,  
                    INPUT-OUTPUT nv_netatt,  
                    INPUT-OUTPUT nv_fltatt,  
                    INPUT-OUTPUT nv_ncbatt,  
                    INPUT-OUTPUT nv_dscatt,  
                    INPUT-OUTPUT nv_attgapt, 
                    INPUT-OUTPUT nv_atfltgap,
                    INPUT-OUTPUT nv_atncbgap,
                    INPUT-OUTPUT nv_atdscgap,
                    INPUT-OUTPUT nv_packatt1,
                                                                                                                
                    INPUT-OUTPUT nv_chgflg ,  
                    INPUT-OUTPUT nv_chgrate , 
                    INPUT-OUTPUT nv_chgsi,    
                    INPUT-OUTPUT nv_chgpdprm ,
                    INPUT-OUTPUT nv_chggapprm,
                                                                                                      
                    INPUT-OUTPUT nv_battflag,
                    INPUT-OUTPUT nv_battrate,  
                    INPUT-OUTPUT nv_battsi ,   
                    INPUT-OUTPUT nv_battprice, 
                    INPUT-OUTPUT nv_battpdprm, 
                    INPUT-OUTPUT nv_battgapprm,
                    INPUT-OUTPUT nv_battyr ,   
                    INPUT-OUTPUT nv_battper,   
                                                          
                    INPUT-OUTPUT nv_compprm,
                    INPUT-OUTPUT nv_uom9_v ,
                                 
                    INPUT-OUTPUT nv_fcctv,
                    INPUT-OUTPUT nv_flgsht,
                    INPUT-OUTPUT nv_evflg,
                                                                                    
                    OUTPUT nv_uom1_c,  
                    OUTPUT nv_uom2_c,  
                    OUTPUT nv_uom5_c,  
                    OUTPUT nv_uom6_c,  
                    OUTPUT nv_uom7_c,  
                    OUTPUT nv_gapprm,  
                    OUTPUT nv_netprem, 
                    OUTPUT nv_status,  
                    OUTPUT nv_message ).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCampaign C-Win 
PROCEDURE PDCampaign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by a65-0203     
------------------------------------------------------------------------------*/
DEF VAR nv_camp1 AS CHAR INIT "".  /*---add by Chaiyong W. A61-0015 14/03/2018*/
DEF VAR nv_year  AS CHAR INIT "".
DEF VAR nv_camp2 AS CHAR INIT "".
DEF VAR n_yr     AS INTE INIT 0.
DEF VAR n_model  AS CHAR INIT "" .

IF wexcel.campaign <> "" THEN DO: 
    fi_display = "Check Campaign policy: " + wexcel.policy.
    DISP fi_display WITH FRAME fr_main.

    nv_camp1 = trim(wexcel.campaign).
    /* เช็ค แพ็คเกจ ในพารามิเตอร์ uw  */
    IF nv_camp1 <> ""  THEN DO:
       ASSIGN n_yr = 0       
              n_yr = (YEAR(TODAY) - DECI(wexcel.yrmanu)) + 1.

       CREATE wexcamp.
       ASSIGN wexcamp.policy    = wexcel.policy
              wexcamp.campaign  = wexcel.campaign.

       FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                 stat.campaign_fil.camcod   = nv_camp1  NO-LOCK NO-ERROR . /* campaign no */
       IF NOT AVAIL stat.campaign_fil THEN DO:

           RUN PDCampaign_brstat. /* รถบรรทุก */
       END.
       ELSE DO:
          IF wexcel.covcod = "1"  THEN DO:
              IF wexcel.sclass <> "110" THEN DO:  /* 110E 210 320 */ 

                 FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                      stat.campaign_fil.camcod = nv_camp1         AND /* campaign no */
                      stat.campaign_fil.sclass = wexcel.sclass    AND /* class 110 210 320 */
                      stat.campaign_fil.covcod = wexcel.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                      stat.campaign_fil.garage = wexcel.garage    AND /* การซ่อม */
                      stat.campaign_fil.maxyea = n_yr             AND /* อายุรถ */
                      stat.campaign_fil.simax  = deci(wexcel.si)  AND  /* ทุน */
                      stat.campaign_fil.makdes = trim(wexcel.makdes)    AND 
                      (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                      index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                      stat.campaign_fil.netprm  = deci(wexcel.netprm)   NO-LOCK NO-ERROR. 
                 IF AVAIL stat.campaign_fil THEN DO:
                    ASSIGN   
                        wexcel.pack       = stat.campaign_fil.paccod
                        wexcamp.polmaster = stat.campaign_fil.polmst
                        wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                        wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                        wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                        wexcamp.pa411     = stat.campaign_fil.mv411
                        wexcamp.pa412     = stat.campaign_fil.mv412
                        wexcamp.pa42      = stat.campaign_fil.mv42 
                        wexcamp.pa43      = stat.campaign_fil.mv43 
                        wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                        wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                        wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                        wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                        wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                        wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                        wexcamp.sumins    = wexcel.si
                        wexcamp.sumfit    = wexcel.si
                        wexcamp.Prem_t    = stat.campaign_fil.netprm  . 
                 END.
                 ELSE ASSIGN wexcamp.polmaster = "" .
              END. /* end <> 110 */
              ELSE DO:  /* class 110 */
                  IF wexcel.sclass = "110" THEN DO:
                       IF INT(wexcel.engine) <= 2000 THEN nv_cc = "2000".
                       ELSE IF int(wexcel.engine) > 2000 THEN nv_cc = "2001".
                  END.
                  ELSE nv_cc = "". 
                  RUN PDCampaign110_1.
              END.
          END. /* end ป.1 */
          ELSE IF (wexcel.covcod = "2.2") OR (wexcel.covcod = "3.2") THEN DO:
               IF wexcel.sclass <> "110" THEN DO: 

                FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                    stat.campaign_fil.camcod  = nv_camp1           and  /*campaign */ 
                    stat.campaign_fil.sclass  = wexcel.sclass      and  /* class 110 210 320 */
                    stat.campaign_fil.covcod  = wexcel.covcod      and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    stat.campaign_fil.garage  = wexcel.garage      and  /*   ประเภทการซ่อม   */
                    stat.campaign_fil.maxyea  = n_yr               AND /* อายุรถ */
                    stat.campaign_fil.simax   = deci(wexcel.si)    AND  /*   วงเงินทุนประกัน */
                    stat.campaign_fil.makdes  = trim(wexcel.makdes)      AND 
                    (index(wexcel.moddes,stat.campaign_fil.moddes)<> 0   OR   /* Model */
                    index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                    stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
                  IF AVAIL stat.campaign_fil THEN DO:
                    ASSIGN
                        wexcel.pack       = stat.campaign_fil.paccod
                        wexcamp.polmaster = stat.campaign_fil.polmst
                        wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                        wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                        wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                        wexcamp.pa411     = stat.campaign_fil.mv411
                        wexcamp.pa412     = stat.campaign_fil.mv412
                        wexcamp.pa42      = stat.campaign_fil.mv42 
                        wexcamp.pa43      = stat.campaign_fil.mv43 
                        wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                        wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                        wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                        wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                        wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                        wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                        wexcamp.sumins    = wexcel.si
                        wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
                        wexcamp.Prem_t    = stat.campaign_fil.netprm .
                  END.
                  ELSE ASSIGN wexcamp.polmaster = "" . 
               END. /* <> 110 */
               ELSE DO: /* class 110 */

                   IF INT(wexcel.engine) <= 2000 THEN nv_cc = "2000".
                   ELSE IF int(wexcel.engine) > 2000 THEN nv_cc = "2001".  
          
                   IF int(nv_cc) <= 2000 THEN DO:
                        FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                         stat.campaign_fil.camcod  =  nv_camp1               and     /*campaign */ /*A63-0443*/
                         stat.campaign_fil.sclass  =  wexcel.sclass          and     /* class 110 210 320 */
                         stat.campaign_fil.covcod  =  wexcel.covcod          and     /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                         stat.campaign_fil.garage  =  wexcel.garage          and     /*   ประเภทการซ่อม   */
                         stat.campaign_fil.maxyea  =  n_yr                   AND  /* อายุรถ */
                         stat.campaign_fil.engine  <= 2000                   AND     /* cc */   
                         stat.campaign_fil.simax    = deci(wexcel.si)        AND     /*   วงเงินทุนประกันสูงสุด */
                         stat.campaign_fil.makdes   = trim(wexcel.makdes)    AND 
                         (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                         index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                         stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
                   END.
                   ELSE DO:
                        FIND LAST stat.campaign_fil /*USE-INDEX campf   il15*/  WHERE                
                         stat.campaign_fil.camcod  =  nv_camp1                 and       /*campaign */ /*A63-0443*/
                         stat.campaign_fil.sclass  =  wexcel.sclass            and       /* class 110 210 320 */
                         stat.campaign_fil.covcod  =  wexcel.covcod            and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                         stat.campaign_fil.garage  =  wexcel.garage            and       /*   ประเภทการซ่อม   */
                         stat.campaign_fil.maxyea  =  n_yr                     AND  /* อายุรถ */
                         stat.campaign_fil.engine  > 2000                      AND /* cc */  
                         stat.campaign_fil.simax   = deci(wexcel.si)           AND       /*   วงเงินทุนประกันสูงสุด */
                         stat.campaign_fil.makdes  = trim(wexcel.makdes)       AND 
                         (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                         index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                         stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
                   END.
                   IF AVAIL stat.campaign_fil THEN DO:
                       ASSIGN
                           wexcel.pack       = stat.campaign_fil.paccod
                           wexcamp.polmaster = stat.campaign_fil.polmst
                           wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                           wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                           wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                           wexcamp.pa411     = stat.campaign_fil.mv411
                           wexcamp.pa412     = stat.campaign_fil.mv412
                           wexcamp.pa42      = stat.campaign_fil.mv42 
                           wexcamp.pa43      = stat.campaign_fil.mv43 
                           wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                           wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                           wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                           wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                           wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                           wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                           wexcamp.sumins    = wexcel.si
                           wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
                           wexcamp.Prem_t    = stat.campaign_fil.netprm .
                   END.
                   ELSE ASSIGN wexcamp.polmaster = "" . 
               END. /* 110 */
          END. /* end ป.2+ ป.3+ */ 
          ELSE DO: /* ป2 ป3 */
              IF wexcel.sclass = "110"  THEN DO:
                  IF INT(wexcel.engine) <= 2000 THEN nv_cc = "2000".
                  ELSE IF int(wexcel.engine) > 2000 THEN nv_cc = "2001". 
              END.
              ELSE nv_cc = "0".
              IF wexcel.covcod = "2" THEN DO: /* ป 2 */
                   FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                       stat.campaign_fil.camcod  = nv_camp1             and       /*campaign */ /*A63-0443*/
                       stat.campaign_fil.sclass  = wexcel.sclass        and       /* class 110 210 320 */
                       stat.campaign_fil.covcod  = wexcel.covcod        and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                       stat.campaign_fil.maxyea  =  n_yr                AND
                       stat.campaign_fil.engine  = INTE(nv_cc)          AND       /* cc */ 
                       stat.campaign_fil.simax   = deci(wexcel.si)      AND       /* ทุนประกัน */
                       stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
              END.
              ELSE DO: /* ป 3*/
                   FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                    stat.campaign_fil.camcod  = nv_camp1             and       /*campaign */ /*A63-0443*/
                    stat.campaign_fil.sclass  = wexcel.sclass        and       /* class 110 210 320 */
                    stat.campaign_fil.covcod  = wexcel.covcod        and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    stat.campaign_fil.engine  = INTE(nv_cc)          AND       /* cc */  
                    stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
              END.
              IF AVAIL stat.campaign_fil THEN DO:
                  ASSIGN
                    wexcel.pack       = stat.campaign_fil.paccod
                    wexcamp.polmaster = stat.campaign_fil.polmst
                    wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                    wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                    wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                    wexcamp.pa411     = stat.campaign_fil.mv411
                    wexcamp.pa412     = stat.campaign_fil.mv412
                    wexcamp.pa42      = stat.campaign_fil.mv42 
                    wexcamp.pa43      = stat.campaign_fil.mv43 
                    wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                    wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                    wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                    wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                    wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                    wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                    wexcamp.sumins    = "0"
                    wexcamp.sumfit    = IF (wexcel.covcod = "2") THEN wexcel.si ELSE "0"
                    wexcamp.Prem_t    = stat.campaign_fil.netprm .
              END.
              ELSE ASSIGN wexcamp.polmaster = "" . 
          END.
       END. /* else campagin_fil */

       IF wexcamp.polmaster = "" THEN 
          ASSIGN  wexcel.werror = wexcel.werror + "ไม่พบ Policy Master ตามรายละเอียดของไฟล์โหลดในแคมเปญ " + nv_camp1 + " |" 
                  wexcel.wmark  = NO. 
     END. /* end nv_camp1 <> "" */
     RELEASE stat.campaign_fil.
END. /* end wexcel.campaign <> "" */
ELSE DO:

    /* campaign = "" : อ้างอิง ประเภทประกัน class และความคุ้มครอง ตาม C65/00001 (110,210,320) */
    FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno      = TRIM(fi_camptruck)    AND
            brstat.insure.vatcode     = wexcel.covcod         AND /* cover */
            brstat.insure.text1       = "Non-Camp"            and /* camp name*/       
            brstat.insure.text4       = wexcel.sclass         AND    /* class */
            brstat.insure.icno        = wexcel.garage          /* garage */
        NO-LOCK NO-ERROR .
        IF AVAIL brstat.insure THEN DO:
            CREATE wexcamp.
            ASSIGN wexcamp.policy    = wexcel.policy
                   wexcamp.campaign  = "Non-Camp"
                   wexcel.pack       = brstat.insure.text3
                   wexcamp.polmaster = "Non-Camp"
                   wexcamp.tp_bi1    = int(brstat.insure.lname)     /* BI  */ 
                   wexcamp.tp_bi2    = int(brstat.insure.addr1)     /* PA  */ 
                   wexcamp.tp_pd     = int(brstat.insure.addr2)     /* PD  */ 
                   wexcamp.pa411     = int(brstat.insure.addr3)     /* 411 */ 
                   wexcamp.pa412     = int(brstat.insure.addr3)     /* 412 */
                   wexcamp.pa42      = int(brstat.insure.addr4)     /* 42  */    
                   wexcamp.pa43      = int(brstat.insure.telno)     /* 43  */ 
                   wexcamp.base1     = "0"                 
                   wexcamp.base2     = "0"                 
                   wexcamp.ncb       = "0"                 
                   wexcamp.loadcl    = "0"                 
                   wexcamp.fleet     = "0"                 
                   wexcamp.dspc      = "0"                 
                   wexcamp.sumins    = IF (wexcel.covcod <> "2") AND (wexcel.covcod <> "3") THEN wexcel.si ELSE "0"  
                   wexcamp.sumfit    = IF (wexcel.covcod = "3") THEN "0" ELSE wexcel.si                                               
                   wexcamp.Prem_t    = int(wexcel.netprm). 
        END.
        ELSE ASSIGN  wexcamp.polmaster = "" .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCampaign-00 C-Win 
PROCEDURE PDCampaign-00 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by a65-0203   BACKUP   
------------------------------------------------------------------------------*/
/*DEF VAR nv_camp1 AS CHAR INIT "".  /*---add by Chaiyong W. A61-0015 14/03/2018*/
DEF VAR nv_year  AS CHAR INIT "".
DEF VAR nv_camp2 AS CHAR INIT "".
DEF VAR n_yr     AS INTE INIT 0.
DEF VAR n_model  AS CHAR INIT "" .
IF wexcel.campaign <> "" THEN DO:  
    nv_camp1 = trim(wexcel.campaign).
    /* เช็ค แพ็คเกจ ในพารามิเตอร์ uw  */
    IF nv_camp1 <> ""  THEN DO:
       ASSIGN n_yr = 0       
              n_yr = (YEAR(TODAY) - DECI(wexcel.yrmanu)) + 1.

       CREATE wexcamp.
       ASSIGN wexcamp.policy    = wexcel.policy
              wexcamp.campaign  = wexcel.campaign.

       IF wexcel.covcod = "1"  THEN DO:
           IF wexcel.sclass <> "110" THEN DO:  /* 110E 210 320 */ /*A64-0044 */
               /*MESSAGE " nv_camp1      "    nv_camp1         skip
                       " wexcel.sclass "    wexcel.sclass    skip
                       " wexcel.covcod "    wexcel.covcod    skip
                       " wexcel.garage "    wexcel.garage    skip
                       " n_yr          "    n_yr             skip
                       " wexcel.si     "    wexcel.si        skip
                       " wexcel.makdes "    wexcel.makdes    skip
                       " wexcel.moddes "    wexcel.moddes    skip
                       " wexcel.netprm "    wexcel.netprm    VIEW-AS ALERT-BOX.*/
              FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
                   stat.campaign_fil.camcod = nv_camp1         AND /* campaign no */
                   stat.campaign_fil.sclass = wexcel.sclass    AND /* class 110 210 320 */
                   stat.campaign_fil.covcod = wexcel.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                   stat.campaign_fil.garage = wexcel.garage    AND /* การซ่อม */
                   stat.campaign_fil.maxyea = n_yr             AND /* อายุรถ */
                   stat.campaign_fil.simax  = deci(wexcel.si)  AND  /* ทุน */
                   stat.campaign_fil.makdes = trim(wexcel.makdes)    AND 
                   (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                   index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ /*A64-0044*/
                   stat.campaign_fil.netprm  = deci(wexcel.netprm)   NO-LOCK NO-ERROR. 
              IF AVAIL stat.campaign_fil THEN DO:
                 ASSIGN   
                  wexcamp.polmaster = stat.campaign_fil.polmst
                  wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                  wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                  wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                  wexcamp.pa411     = stat.campaign_fil.mv411
                  wexcamp.pa412     = stat.campaign_fil.mv412
                  wexcamp.pa42      = stat.campaign_fil.mv42 
                  wexcamp.pa43      = stat.campaign_fil.mv43 
                  wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                  wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                  wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                  wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                  wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                  wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                  wexcamp.sumins    = wexcel.si
                  wexcamp.sumfit    = wexcel.si
                  wexcamp.Prem_t    = stat.campaign_fil.netprm . 
              END.
              ELSE ASSIGN wexcamp.polmaster = "" .
              /* ไม่เช็คอายุรถ */
              /*IF wexcamp.polmaster = "" THEN DO: 
                IF n_yr = 0 THEN n_yr = 1 . 
                ELSE n_yr = n_yr + 1.
               
                /*n_model = "" .
                IF INDEX(wexcel.moddes," ") <> 0 THEN ASSIGN n_model = SUBSTR(wexcel.moddes,1,INDEX(wexcel.moddes," ") - 1).
                ELSE n_model = TRIM(wexcel.moddes) .*/
                
                FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/ WHERE 
                     stat.campaign_fil.camcod = nv_camp1            AND /* campaign no */
                     stat.campaign_fil.sclass = wexcel.sclass       AND /* class 110 210 320 */
                     stat.campaign_fil.covcod = wexcel.covcod       AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                     stat.campaign_fil.garage = wexcel.garage       AND /* การซ่อม */
                     stat.campaign_fil.maxyea = n_yr                AND /* อายุรถ */
                     stat.campaign_fil.simax  = deci(wexcel.si)     AND  /* ทุน */
                     stat.campaign_fil.makdes = wexcel.makdes       AND 
                     (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                     index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                     stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR. 
                    IF AVAIL stat.campaign_fil THEN DO: 
                        ASSIGN   
                            wexcamp.polmaster = stat.campaign_fil.polmst
                            wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                            wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                            wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                            wexcamp.pa411     = stat.campaign_fil.mv411
                            wexcamp.pa412     = stat.campaign_fil.mv412
                            wexcamp.pa42      = stat.campaign_fil.mv42 
                            wexcamp.pa43      = stat.campaign_fil.mv43 
                            wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                            wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                            wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                            wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                            wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                            wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                            wexcamp.sumins    = wexcel.si
                            wexcamp.sumfit    = wexcel.si
                            wexcamp.Prem_t    = stat.campaign_fil.netprm .
                    END.
                    ELSE ASSIGN wexcamp.polmaster = "" .
              END.*/
           END. /* end <> 110 */
           ELSE DO:  /* class 110 */
               IF wexcel.sclass = "110" THEN DO:
                    IF INT(wexcel.engine) <= 2000 THEN nv_cc = "2000".
                    ELSE IF int(wexcel.engine) > 2000 THEN nv_cc = "2001".
               END.
               ELSE nv_cc = "". 
               RUN PDCampaign110_1.
           END.
       END. /* end ป.1 */
       ELSE IF (wexcel.covcod = "2.2") OR (wexcel.covcod = "3.2") THEN DO:
            IF wexcel.sclass <> "110" THEN DO:  /*A64-0044*/
             FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                 stat.campaign_fil.camcod  = nv_camp1           and  /*campaign */ /*A63-0443*/
                 stat.campaign_fil.sclass  = wexcel.sclass      and  /* class 110 210 320 */
                 stat.campaign_fil.covcod  = wexcel.covcod      and  /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                 stat.campaign_fil.garage  = wexcel.garage      and  /*   ประเภทการซ่อม   */
                 stat.campaign_fil.maxyea  = n_yr               AND /* อายุรถ */
                 stat.campaign_fil.simax   = deci(wexcel.si)    AND  /*   วงเงินทุนประกัน */
                 stat.campaign_fil.makdes  = trim(wexcel.makdes)      AND 
                 (index(wexcel.moddes,stat.campaign_fil.moddes)<> 0   OR   /* Model */
                 index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                 stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
               /* add by : A64-0044 */
               IF AVAIL stat.campaign_fil THEN DO:
                 ASSIGN
                     wexcamp.polmaster = stat.campaign_fil.polmst
                     wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                     wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                     wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                     wexcamp.pa411     = stat.campaign_fil.mv411
                     wexcamp.pa412     = stat.campaign_fil.mv412
                     wexcamp.pa42      = stat.campaign_fil.mv42 
                     wexcamp.pa43      = stat.campaign_fil.mv43 
                     wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                     wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                     wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                     wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                     wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                     wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                     wexcamp.sumins    = wexcel.si
                     wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
                     wexcamp.Prem_t    = stat.campaign_fil.netprm .
               END.
               ELSE ASSIGN wexcamp.polmaster = "" . 
            END. /* <> 110 */
            ELSE DO: /* class 110 */
                IF INT(wexcel.engine) <= 2000 THEN nv_cc = "2000".
                ELSE IF int(wexcel.engine) > 2000 THEN nv_cc = "2001".  

                IF int(nv_cc) <= 2000 THEN DO:
                     FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                      stat.campaign_fil.camcod  =  nv_camp1               and     /*campaign */ /*A63-0443*/
                      stat.campaign_fil.sclass  =  wexcel.sclass          and     /* class 110 210 320 */
                      stat.campaign_fil.covcod  =  wexcel.covcod          and     /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                      stat.campaign_fil.garage  =  wexcel.garage          and     /*   ประเภทการซ่อม   */
                      stat.campaign_fil.maxyea  =  n_yr                   AND  /* อายุรถ */
                      stat.campaign_fil.engine  <= 2000                   AND     /* cc */   
                      stat.campaign_fil.simax    = deci(wexcel.si)        AND     /*   วงเงินทุนประกันสูงสุด */
                      stat.campaign_fil.makdes   = trim(wexcel.makdes)    AND 
                      (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                      index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                      stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR. /* เบี้ยจากไฟล์ */
                END.
                ELSE DO:
                     FIND LAST stat.campaign_fil /*USE-INDEX campf   il15*/  WHERE                
                      stat.campaign_fil.camcod  =  nv_camp1                 and       /*campaign */ /*A63-0443*/
                      stat.campaign_fil.sclass  =  wexcel.sclass            and       /* class 110 210 320 */
                      stat.campaign_fil.covcod  =  wexcel.covcod            and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                      stat.campaign_fil.garage  =  wexcel.garage            and       /*   ประเภทการซ่อม   */
                      stat.campaign_fil.maxyea  =  n_yr                     AND  /* อายุรถ */
                      stat.campaign_fil.engine  > 2000                      AND /* cc */  
                      stat.campaign_fil.simax   = deci(wexcel.si)           AND       /*   วงเงินทุนประกันสูงสุด */
                      stat.campaign_fil.makdes  = trim(wexcel.makdes)       AND 
                      (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                      index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
                      stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
                END.
                IF AVAIL stat.campaign_fil THEN DO:
                    ASSIGN
                      wexcamp.polmaster = stat.campaign_fil.polmst
                      wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                      wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                      wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                      wexcamp.pa411     = stat.campaign_fil.mv411
                      wexcamp.pa412     = stat.campaign_fil.mv412
                      wexcamp.pa42      = stat.campaign_fil.mv42 
                      wexcamp.pa43      = stat.campaign_fil.mv43 
                      wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                      wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                      wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                      wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                      wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                      wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                      wexcamp.sumins    = wexcel.si
                      wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
                      wexcamp.Prem_t    = stat.campaign_fil.netprm .
                END.
                ELSE ASSIGN wexcamp.polmaster = "" . 
            END. /* 110 */
       END. /* end ป.2+ ป.3+ */ 
       ELSE DO: /* ป2 ป3 */
           IF wexcel.sclass = "110"  THEN DO:
               IF INT(wexcel.engine) <= 2000 THEN nv_cc = "2000".
               ELSE IF int(wexcel.engine) > 2000 THEN nv_cc = "2001". 
           END.
           ELSE nv_cc = "0".
           IF wexcel.covcod = "2" THEN DO: /* ป 2 */
                FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                    stat.campaign_fil.camcod  = nv_camp1             and       /*campaign */ /*A63-0443*/
                    stat.campaign_fil.sclass  = wexcel.sclass        and       /* class 110 210 320 */
                    stat.campaign_fil.covcod  = wexcel.covcod        and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                    stat.campaign_fil.maxyea  =  n_yr                AND
                    stat.campaign_fil.engine  = INTE(nv_cc)          AND       /* cc */ 
                    stat.campaign_fil.simax   = deci(wexcel.si)      AND       /* ทุนประกัน */
                    /*stat.campaign_fil.makdes  = wexcel.makdes        AND       
                    (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                    index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND*/  /* Model */ 
                    stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
           END.
           ELSE DO: /* ป 3*/
                FIND LAST stat.campaign_fil /*USE-INDEX campfil15*/  WHERE                
                 stat.campaign_fil.camcod  = nv_camp1             and       /*campaign */ /*A63-0443*/
                 stat.campaign_fil.sclass  = wexcel.sclass        and       /* class 110 210 320 */
                 stat.campaign_fil.covcod  = wexcel.covcod        and       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                 stat.campaign_fil.engine  = INTE(nv_cc)          AND       /* cc */ 
                 /*stat.campaign_fil.makdes  = wexcel.makdes        AND       
                 (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                 index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND  */ /* Model */ 
                 stat.campaign_fil.netprm  = deci(wexcel.netprm)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
           END.
           IF AVAIL stat.campaign_fil THEN DO:
               ASSIGN
                 wexcamp.polmaster = stat.campaign_fil.polmst
                 wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                 wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                 wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                 wexcamp.pa411     = stat.campaign_fil.mv411
                 wexcamp.pa412     = stat.campaign_fil.mv412
                 wexcamp.pa42      = stat.campaign_fil.mv42 
                 wexcamp.pa43      = stat.campaign_fil.mv43 
                 wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                 wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                 wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                 wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                 wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                 wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                 wexcamp.sumins    = IF (wexcel.covcod = "2") THEN wexcel.si ELSE "0"
                 wexcamp.sumfit    = "0"
                 wexcamp.Prem_t    = stat.campaign_fil.netprm .
           END.
           ELSE ASSIGN wexcamp.polmaster = "" . 
       END.

       IF wexcamp.polmaster = "" THEN 
          ASSIGN  wexcel.werror = wexcel.werror + "ไม่พบ Policy Master ตามรายละเอียดของไฟล์โหลดในแคมเปญ " + nv_camp1 + " |" 
                  wexcel.wmark  = NO. 
     END. /* end nv_camp1 <> "" */
     RELEASE stat.campaign_fil.
END. /* end wexcel.campaign <> "" */*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCampaign110_1 C-Win 
PROCEDURE PDCampaign110_1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_camp1 AS CHAR INIT "".  /*---add by Chaiyong W. A61-0015 14/03/2018*/
DEF VAR n_yr     AS INTE INIT 0.
DO:
    ASSIGN nv_camp1 = trim(wexcel.campaign)
           n_yr = 0       
           n_yr = (YEAR(TODAY) - DECI(wexcel.yrmanu)) + 1 .

    IF INT(wexcel.engine) <= 2000  THEN DO:  /* 2000 CC */
      FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
       stat.campaign_fil.camcod = nv_camp1   AND /* campaign no */
       stat.campaign_fil.sclass = wexcel.sclass  AND /* class 110 210 320 */
       stat.campaign_fil.covcod = wexcel.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
       stat.campaign_fil.garage = wexcel.garage    AND /* การซ่อม */
       stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
       stat.campaign_fil.engine <= 2000             AND /* cc */  
       stat.campaign_fil.simax  = deci(wexcel.si)  AND  /* ทุน */
       stat.campaign_fil.makdes = wexcel.makdes    AND 
       (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
       index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ /*A64-0044*/
       stat.campaign_fil.netprm  = deci(wexcel.netprm)   NO-LOCK NO-ERROR. 
    END.
    ELSE DO:  /* > 2000 CC */
       FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
           stat.campaign_fil.camcod = nv_camp1   AND /* campaign no */
           stat.campaign_fil.sclass = wexcel.sclass  AND /* class 110 210 320 */
           stat.campaign_fil.covcod = wexcel.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
           stat.campaign_fil.garage = wexcel.garage    AND /* การซ่อม */
           stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
           stat.campaign_fil.engine > 2000              AND /* cc */  
           stat.campaign_fil.simax  = deci(wexcel.si)  AND  /* ทุน */
           stat.campaign_fil.makdes = wexcel.makdes    AND 
           (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
           index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ /*A64-0044*/
           stat.campaign_fil.netprm  = deci(wexcel.netprm)   NO-LOCK NO-ERROR. 
    END.
    IF AVAIL stat.campaign_fil THEN DO:
        ASSIGN   
          wexcel.pack       = stat.campaign_fil.paccod
          wexcamp.polmaster = stat.campaign_fil.polmst
          wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
          wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
          wexcamp.tp_pd     = stat.campaign_fil.uom5_v
          wexcamp.pa411     = stat.campaign_fil.mv411
          wexcamp.pa412     = stat.campaign_fil.mv412
          wexcamp.pa42      = stat.campaign_fil.mv42 
          wexcamp.pa43      = stat.campaign_fil.mv43 
          wexcamp.base1     = string(stat.campaign_fil.baseprm)   
          wexcamp.base2     = string(stat.campaign_fil.baseprm3)
          wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
          wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
          wexcamp.fleet     = string(stat.campaign_fil.fletper)    
          wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
          wexcamp.sumins    = wexcel.si
          wexcamp.sumfit    = wexcel.si
          wexcamp.Prem_t    = stat.campaign_fil.netprm . 
    END.
    ELSE ASSIGN wexcamp.polmaster = "" .
    
    /*IF wexcamp.polmaster = "" THEN DO: 
        IF n_yr = 0 THEN n_yr = 1 . 
        ELSE n_yr = n_yr + 1.

        IF INT(wexcel.engine) <= 2000 THEN DO:
            FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                stat.campaign_fil.camcod = nv_camp1          AND /* campaign no */
                stat.campaign_fil.sclass = wexcel.sclass     AND /* class 110 210 320 */
                stat.campaign_fil.covcod = wexcel.covcod     AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = wexcel.garage     AND /* การซ่อม */
                stat.campaign_fil.maxyea = n_yr              AND /* อายุรถ */
                stat.campaign_fil.engine <= 2000             AND /* cc */ 
                stat.campaign_fil.simax  = deci(wexcel.si)   AND  /* ทุน */
                stat.campaign_fil.makdes = wexcel.makdes     AND 
                (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = deci(wexcel.netprm)   NO-LOCK NO-ERROR. 
        END.
        ELSE DO:
             FIND LAST stat.campaign_fil /*USE-INDEX campfil01*/  WHERE 
                stat.campaign_fil.camcod = nv_camp1         AND /* campaign no */
                stat.campaign_fil.sclass = wexcel.sclass    AND /* class 110 210 320 */
                stat.campaign_fil.covcod = wexcel.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
                stat.campaign_fil.garage = wexcel.garage    AND /* การซ่อม */
                stat.campaign_fil.maxyea = n_yr             AND /* อายุรถ */
                stat.campaign_fil.engine > 2000             AND /* cc */ 
                stat.campaign_fil.simax  = deci(wexcel.si)  AND  /* ทุน */
                stat.campaign_fil.makdes = wexcel.makdes    AND 
                (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
                index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ /*A64-0044*/
                stat.campaign_fil.netprm  = deci(wexcel.netprm)   NO-LOCK NO-ERROR.
        END.
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN   
              wexcamp.polmaster = stat.campaign_fil.polmst
              wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
              wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
              wexcamp.tp_pd     = stat.campaign_fil.uom5_v
              wexcamp.pa411     = stat.campaign_fil.mv411
              wexcamp.pa412     = stat.campaign_fil.mv412
              wexcamp.pa42      = stat.campaign_fil.mv42 
              wexcamp.pa43      = stat.campaign_fil.mv43 
              wexcamp.base1     = string(stat.campaign_fil.baseprm)   
              wexcamp.base2     = string(stat.campaign_fil.baseprm3)
              wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
              wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
              wexcamp.fleet     = string(stat.campaign_fil.fletper)    
              wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
              wexcamp.sumins    = wexcel.si
              wexcamp.sumfit    = wexcel.si
              wexcamp.Prem_t    = stat.campaign_fil.netprm . 
        END.
        ELSE ASSIGN wexcamp.polmaster = "" . 
    END.*/
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCampaignC01 C-Win 
PROCEDURE PdCampaignC01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF wexcel.sclass <> "110" THEN DO:
    FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
         stat.campaign_fil.camcod = wexcel.campaign  AND /* campaign no */
         stat.campaign_fil.sclass = wexcel.sclass    AND /* class 110 210 320 */
         stat.campaign_fil.covcod = wexcel.covcod    AND /* cover 1 2 3 2.1 2.2 3.1 3.2 */
         stat.campaign_fil.garage = wexcel.garage    AND /* การซ่อม */
         stat.campaign_fil.maxyea = nv_yr            AND /* อายุรถ */
         stat.campaign_fil.simax  = deci(wexcel.si)  AND  /* ทุน */
         stat.campaign_fil.makdes = trim(wexcel.makdes)    AND 
         (index(wexcel.moddes,stat.campaign_fil.moddes) <> 0   OR   /* Model */
         index(stat.campaign_fil.moddes,wexcel.moddes)  <> 0 ) AND   /* Model */ 
         stat.campaign_fil.netprm  = deci(wexcel.netprm)   NO-LOCK NO-ERROR. 
    IF AVAIL stat.campaign_fil THEN DO:
       ASSIGN   
           wexcel.pack       = stat.campaign_fil.paccod
           wexcamp.polmaster = stat.campaign_fil.polmst
           wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
           wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
           wexcamp.tp_pd     = stat.campaign_fil.uom5_v
           wexcamp.pa411     = stat.campaign_fil.mv411
           wexcamp.pa412     = stat.campaign_fil.mv412
           wexcamp.pa42      = stat.campaign_fil.mv42 
           wexcamp.pa43      = stat.campaign_fil.mv43 
           wexcamp.base1     = string(stat.campaign_fil.baseprm)   
           wexcamp.base2     = string(stat.campaign_fil.baseprm3)
           wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
           wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
           wexcamp.fleet     = string(stat.campaign_fil.fletper)    
           wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
           wexcamp.sumins    = wexcel.si
           wexcamp.sumfit    = wexcel.si
           wexcamp.Prem_t    = stat.campaign_fil.netprm  . 
    END.
    ELSE ASSIGN wexcamp.polmaster = "" .
END.
ELSE DO:
END.*/

FIND LAST stat.campaign_fil WHERE
          stat.campaign_fil.camcod = wexcel.campaign AND
          stat.campaign_fil.sclass = wexcel.sclass   AND
          stat.campaign_fil.covcod = wexcel.covcod   AND
          stat.campaign_fil.garage = wexcel.garage   AND
          stat.campaign_fil.makdes = nv_makdes       AND
          stat.campaign_fil.moddes = nv_moddes       AND
          stat.campaign_fil.maxyea = nv_yr            AND
         (stat.campaign_fil.mincst <= wexcel.cstw    AND
          stat.campaign_fil.maxcst >= wexcel.cstw)   AND
          stat.campaign_fil.simax  = DECI(wexcel.si) AND
          stat.campaign_fil.netprm = DECI(wexcel.netprm)
NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL stat.campaign_fil THEN DO:
    ASSIGN
        wexcel.pack       = stat.campaign_fil.paccod
        wexcamp.polmaster = stat.campaign_fil.polmst
        wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
        wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
        wexcamp.tp_pd     = stat.campaign_fil.uom5_v
        wexcamp.pa411     = stat.campaign_fil.mv411
        wexcamp.pa412     = stat.campaign_fil.mv412
        wexcamp.pa42      = stat.campaign_fil.mv42 
        wexcamp.pa43      = stat.campaign_fil.mv43 
        wexcamp.base1     = string(stat.campaign_fil.baseprm)   
        wexcamp.base2     = string(stat.campaign_fil.baseprm3)
        wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
        wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
        wexcamp.fleet     = string(stat.campaign_fil.fletper)    
        wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
        wexcamp.sumins    = wexcel.si
        wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
        wexcamp.Prem_t    = stat.campaign_fil.netprm .
END.
ELSE DO:
    FIND LAST stat.campaign_fil WHERE
              stat.campaign_fil.camcod = wexcel.campaign AND
              stat.campaign_fil.sclass = wexcel.sclass   AND
              stat.campaign_fil.covcod = wexcel.covcod   AND
              stat.campaign_fil.garage = wexcel.garage   AND
              stat.campaign_fil.makdes = nv_makdes       AND
        INDEX(stat.campaign_fil.moddes,nv_moddes) <> 0   AND
              stat.campaign_fil.maxyea = nv_yr            AND
             (stat.campaign_fil.mincst <= wexcel.cstw    AND
              stat.campaign_fil.maxcst >= wexcel.cstw)   AND
              stat.campaign_fil.simax  = DECI(wexcel.si) AND
              stat.campaign_fil.netprm = DECI(wexcel.netprm)
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.campaign_fil THEN DO:
        ASSIGN
            wexcel.pack       = stat.campaign_fil.paccod
            wexcamp.polmaster = stat.campaign_fil.polmst
            wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
            wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
            wexcamp.tp_pd     = stat.campaign_fil.uom5_v
            wexcamp.pa411     = stat.campaign_fil.mv411
            wexcamp.pa412     = stat.campaign_fil.mv412
            wexcamp.pa42      = stat.campaign_fil.mv42 
            wexcamp.pa43      = stat.campaign_fil.mv43 
            wexcamp.base1     = string(stat.campaign_fil.baseprm)   
            wexcamp.base2     = string(stat.campaign_fil.baseprm3)
            wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
            wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
            wexcamp.fleet     = string(stat.campaign_fil.fletper)    
            wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
            wexcamp.sumins    = wexcel.si
            wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
            wexcamp.Prem_t    = stat.campaign_fil.netprm .
    END.
    ELSE wexcamp.polmaster = "".
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCampaignC02 C-Win 
PROCEDURE PdCampaignC02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_sumins AS DECI FORMAT "->>>,>>>,>>9.99".

IF wexcel.covcod = "2" THEN DO:
    nv_sumins = DECI(wexcel.si).
END.
ELSE IF wexcel.covcod = "3" THEN DO:
    nv_sumins = 0.
END.

FIND LAST stat.campaign_fil WHERE
          stat.campaign_fil.camcod  = wexcel.campaign      AND
          stat.campaign_fil.sclass  = wexcel.sclass        AND       /* class 110 210 320 */
          stat.campaign_fil.covcod  = wexcel.covcod        AND       /* cover 1 2 3 2.1 2.2 3.1 3.2 */
          stat.campaign_fil.maxyea  =  nv_yr               AND
         (stat.campaign_fil.mincst  <= wexcel.cstw         AND
          stat.campaign_fil.maxcst  >= wexcel.cstw)        AND
          /*stat.campaign_fil.engine  = INTE(nv_cc)          AND       /* cc */ */
          stat.campaign_fil.simax   = nv_sumins            AND       /* ทุนประกัน */
          stat.campaign_fil.netprm  = DECI(wexcel.netprm)  NO-LOCK NO-ERROR.  /* เบี้ยจากไฟล์ */
IF AVAIL stat.campaign_fil THEN DO:
    ASSIGN  
        wexcel.pack       = stat.campaign_fil.paccod
        wexcamp.polmaster = stat.campaign_fil.polmst
        wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
        wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
        wexcamp.tp_pd     = stat.campaign_fil.uom5_v
        wexcamp.pa411     = stat.campaign_fil.mv411
        wexcamp.pa412     = stat.campaign_fil.mv412
        wexcamp.pa42      = stat.campaign_fil.mv42 
        wexcamp.pa43      = stat.campaign_fil.mv43 
        wexcamp.base1     = string(stat.campaign_fil.baseprm)   
        wexcamp.base2     = string(stat.campaign_fil.baseprm3)
        wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
        wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
        wexcamp.fleet     = string(stat.campaign_fil.fletper)    
        wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
        wexcamp.sumins    = "0"
        wexcamp.sumfit    = IF (wexcel.covcod = "2") THEN wexcel.si ELSE "0"
        wexcamp.Prem_t    = stat.campaign_fil.netprm .
END.
ELSE ASSIGN wexcamp.polmaster = "" . 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCampaignC03 C-Win 
PROCEDURE PdCampaignC03 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VAR nv_netprmmin AS DECI.
DEFINE VAR nv_netprmmax AS DECI.

/*-- Search Package 2+,3+ --*/

nv_makdes = TRIM(wexcel.makdes).
nv_moddes = TRIM(SUBSTR(wexcel.moddes,1,INDEX(wexcel.moddes," "))).

FIND LAST stat.campaign_fil WHERE
          stat.campaign_fil.camcod = wexcel.campaign AND
          stat.campaign_fil.sclass = wexcel.sclass   AND
          stat.campaign_fil.covcod = wexcel.covcod   AND
          stat.campaign_fil.garage = wexcel.garage   AND
          stat.campaign_fil.makdes = nv_makdes       AND
          stat.campaign_fil.moddes = nv_moddes       AND
          stat.campaign_fil.maxyea = nv_yr            AND
         (stat.campaign_fil.mincst <= wexcel.cstw    AND
          stat.campaign_fil.maxcst >= wexcel.cstw)   AND
          stat.campaign_fil.simax  = DECI(wexcel.si) AND
          stat.campaign_fil.netprm = DECI(wexcel.netprm)
NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL stat.campaign_fil THEN DO:
    ASSIGN
        wexcel.pack       = stat.campaign_fil.paccod
        wexcamp.polmaster = stat.campaign_fil.polmst
        wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
        wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
        wexcamp.tp_pd     = stat.campaign_fil.uom5_v
        wexcamp.pa411     = stat.campaign_fil.mv411
        wexcamp.pa412     = stat.campaign_fil.mv412
        wexcamp.pa42      = stat.campaign_fil.mv42 
        wexcamp.pa43      = stat.campaign_fil.mv43 
        wexcamp.base1     = string(stat.campaign_fil.baseprm)   
        wexcamp.base2     = string(stat.campaign_fil.baseprm3)
        wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
        wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
        wexcamp.fleet     = string(stat.campaign_fil.fletper)    
        wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
        wexcamp.sumins    = wexcel.si
        wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
        wexcamp.Prem_t    = stat.campaign_fil.netprm .
END.
ELSE DO:
    FIND LAST stat.campaign_fil WHERE
              stat.campaign_fil.camcod = wexcel.campaign AND
              stat.campaign_fil.sclass = wexcel.sclass   AND
              stat.campaign_fil.covcod = wexcel.covcod   AND
              stat.campaign_fil.garage = wexcel.garage   AND
              stat.campaign_fil.makdes = nv_makdes       AND
        INDEX(stat.campaign_fil.moddes,nv_moddes) <> 0   AND
              stat.campaign_fil.maxyea = nv_yr            AND
             (stat.campaign_fil.mincst <= wexcel.cstw    AND
              stat.campaign_fil.maxcst >= wexcel.cstw)   AND
              stat.campaign_fil.simax  = DECI(wexcel.si) AND
              stat.campaign_fil.netprm = DECI(wexcel.netprm)
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.campaign_fil THEN DO:
        ASSIGN
            wexcel.pack       = stat.campaign_fil.paccod
            wexcamp.polmaster = stat.campaign_fil.polmst
            wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
            wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
            wexcamp.tp_pd     = stat.campaign_fil.uom5_v
            wexcamp.pa411     = stat.campaign_fil.mv411
            wexcamp.pa412     = stat.campaign_fil.mv412
            wexcamp.pa42      = stat.campaign_fil.mv42 
            wexcamp.pa43      = stat.campaign_fil.mv43 
            wexcamp.base1     = string(stat.campaign_fil.baseprm)   
            wexcamp.base2     = string(stat.campaign_fil.baseprm3)
            wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
            wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
            wexcamp.fleet     = string(stat.campaign_fil.fletper)    
            wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
            wexcamp.sumins    = wexcel.si
            wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
            wexcamp.Prem_t    = stat.campaign_fil.netprm .
    END.
    ELSE DO:
        nv_makdes = "".  nv_moddes = "".  nv_netprmmin = DECI(wexcel.netprm) - 1. nv_netprmmax = DECI(wexcel.netprm) + 1.

        FIND FIRST stat.campaign_fil WHERE
                  stat.campaign_fil.camcod = wexcel.campaign AND
                  stat.campaign_fil.sclass = wexcel.sclass   AND
                  stat.campaign_fil.covcod = wexcel.covcod   AND
                  stat.campaign_fil.garage = wexcel.garage   AND
                  stat.campaign_fil.makdes = nv_makdes       AND
                  stat.campaign_fil.moddes = nv_moddes       AND
                  stat.campaign_fil.maxyea = nv_yr           AND
                  stat.campaign_fil.simax  = DECI(wexcel.si) AND
                  stat.campaign_fil.netprm >= nv_netprmmin   AND
                  stat.campaign_fil.netprm <= nv_netprmmax
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.campaign_fil THEN DO:
            ASSIGN
                wexcel.pack       = stat.campaign_fil.paccod
                wexcamp.polmaster = stat.campaign_fil.polmst
                wexcamp.tp_bi1    = stat.campaign_fil.uom1_v
                wexcamp.tp_bi2    = stat.campaign_fil.uom2_v
                wexcamp.tp_pd     = stat.campaign_fil.uom5_v
                wexcamp.pa411     = stat.campaign_fil.mv411
                wexcamp.pa412     = stat.campaign_fil.mv412
                wexcamp.pa42      = stat.campaign_fil.mv42 
                wexcamp.pa43      = stat.campaign_fil.mv43 
                wexcamp.base1     = string(stat.campaign_fil.baseprm)   
                wexcamp.base2     = string(stat.campaign_fil.baseprm3)
                wexcamp.ncb       = string(stat.campaign_fil.ncbper)        
                wexcamp.loadcl    = string(stat.campaign_fil.clmper)          
                wexcamp.fleet     = string(stat.campaign_fil.fletper)    
                wexcamp.dspc      = string(stat.campaign_fil.dspcper) 
                wexcamp.sumins    = wexcel.si
                wexcamp.sumfit    = IF (wexcel.covcod = "2.2") THEN wexcel.si ELSE "0"
                wexcamp.Prem_t    = stat.campaign_fil.netprm .
        END.
        ELSE wexcamp.polmaster = "".
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCampaignCNon C-Win 
PROCEDURE PdCampaignCNon :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND FIRST stat.campaign_fil WHERE
           stat.campaign_fil.camcod = wexcel.campaign AND
           stat.campaign_fil.sclass = wexcel.sclass   AND
           stat.campaign_fil.covcod = wexcel.covcod   AND
           stat.campaign_fil.garage = wexcel.garage   NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL stat.campaign_fil THEN DO:

    CREATE wexcamp.
    ASSIGN wexcamp.policy    = wexcel.policy
           wexcamp.campaign  = "Non-Camp"
           wexcel.pack       = stat.campaign_fil.paccod
           wexcamp.polmaster = "Non-Camp"
           wexcamp.tp_bi1    = stat.campaign_fil.uom1_v 
           wexcamp.tp_bi2    = stat.campaign_fil.uom2_v 
           wexcamp.tp_pd     = stat.campaign_fil.uom5_v 
           wexcamp.pa411     = stat.campaign_fil.mv411    
           wexcamp.pa412     = stat.campaign_fil.mv412    
           wexcamp.pa42      = stat.campaign_fil.mv42        
           wexcamp.pa43      = stat.campaign_fil.mv43     
           wexcamp.base1     = "0"                 
           wexcamp.base2     = "0"                 
           wexcamp.ncb       = "0"                 
           wexcamp.loadcl    = "0"                 
           wexcamp.fleet     = "0"                 
           wexcamp.dspc      = "0"                 
           wexcamp.sumins    = IF (wexcel.covcod <> "2") AND (wexcel.covcod <> "3") THEN wexcel.si ELSE "0"  
           wexcamp.sumfit    = IF (wexcel.covcod = "3") THEN "0" ELSE wexcel.si                                               
           wexcamp.Prem_t    = INTE(wexcel.netprm). 

    wexcel.campaign = "".
END.
ELSE DO:
    FIND FIRST stat.campaign_fil WHERE
               stat.campaign_fil.camcod = wexcel.campaign AND
               stat.campaign_fil.sclass = wexcel.sclass   AND
               stat.campaign_fil.covcod = wexcel.covcod   AND
               stat.campaign_fil.garage = ""              NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.campaign_fil THEN DO:

        CREATE wexcamp.
        ASSIGN wexcamp.policy    = wexcel.policy
               wexcamp.campaign  = "Non-Camp"
               wexcel.pack       = stat.campaign_fil.paccod
               wexcamp.polmaster = "Non-Camp"
               wexcamp.tp_bi1    = stat.campaign_fil.uom1_v 
               wexcamp.tp_bi2    = stat.campaign_fil.uom2_v 
               wexcamp.tp_pd     = stat.campaign_fil.uom5_v 
               wexcamp.pa411     = stat.campaign_fil.mv411    
               wexcamp.pa412     = stat.campaign_fil.mv412    
               wexcamp.pa42      = stat.campaign_fil.mv42        
               wexcamp.pa43      = stat.campaign_fil.mv43     
               wexcamp.base1     = "0"                 
               wexcamp.base2     = "0"                 
               wexcamp.ncb       = "0"                 
               wexcamp.loadcl    = "0"                 
               wexcamp.fleet     = "0"                 
               wexcamp.dspc      = "0"                 
               wexcamp.sumins    = IF (wexcel.covcod <> "2") AND (wexcel.covcod <> "3") THEN wexcel.si ELSE "0"  
               wexcamp.sumfit    = IF (wexcel.covcod = "3") THEN "0" ELSE wexcel.si                                               
               wexcamp.Prem_t    = INTE(wexcel.netprm).

        wexcel.campaign = "".
    END.
    ELSE DO:

        /*--
        FOR EACH wexcamp WHERE wexcamp.policy    = wexcel.policy AND
                               wexcamp.campaign  = wexcel.campaign:
            DELETE wexcamp.
        END.
        --*/
        wexcel.campaign = "".

        RUN PdCampaignNonCamp.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCampaignNew C-Win 
PROCEDURE PDCampaignNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_camp1 AS CHAR INIT "".  
DEF VAR nv_year  AS CHAR INIT "".
DEF VAR nv_camp2 AS CHAR INIT "".
DEF VAR n_yr     AS INTE INIT 0.
DEF VAR n_model  AS CHAR INIT "" .

nv_yr         = (YEAR(DATE(wexcel.comdat)) - DECI(wexcel.yrmanu)) + 1.
wexcel.moddes = TRIM(wexcel.moddes).
nv_modelchk   = TRIM(SUBSTR(wexcel.moddes,1,INDEX(wexcel.moddes," "))).

IF wexcel.campaign <> "" THEN DO:
    fi_display = "Check Campaign policy: " + wexcel.policy.
    DISP fi_display WITH FRAME fr_main.

    nv_camp1 = TRIM(wexcel.campaign).

    ASSIGN n_yr = 0       
           n_yr = (YEAR(TODAY) - DECI(wexcel.yrmanu)) + 1.

    CREATE wexcamp.
    ASSIGN wexcamp.policy    = wexcel.policy
           wexcamp.campaign  = wexcel.campaign.

    FIND LAST stat.campaign_fil USE-INDEX campfil04  WHERE 
              stat.campaign_fil.camcod   = nv_camp1  NO-LOCK NO-ERROR . /* campaign no */
    IF NOT AVAIL stat.campaign_fil THEN DO:
        RUN PDCampaign_brstat. /* รถบรรทุก */
    END.
    ELSE DO:
        IF wexcel.covcod = "1" THEN DO:
            RUN PdCampaignC01.
        END.
        ELSE IF wexcel.covcod = "2" OR wexcel.covcod = "3" THEN DO:
            RUN PdCampaignC02.
        END.
        ELSE IF wexcel.covcod = "2.2" OR wexcel.covcod = "3.2" THEN DO:
            RUN PdCampaignC03.
        END.
    END.

    /*--*/
    IF wexcamp.polmaster = "" THEN DO: 

        /*wexcel.campaign = "".*/
        FOR EACH wexcamp WHERE wexcamp.policy    = wexcel.policy AND
                               wexcamp.campaign  = wexcel.campaign:
            DELETE wexcamp.
        END.

        RUN PdCampaignCNon. 
       
        /*-- 
        IF wexcamp.polmaster = "" THEN DO: 
            wexcel.campaign = "".
            FOR EACH wexcamp WHERE wexcamp.policy    = wexcel.policy AND
                                   wexcamp.campaign  = wexcel.campaign:
                DELETE wexcamp.
            END.
    
            RUN PdCampaignNonCamp.
        END.
        --*/
    END.
    /*--*/
END.
ELSE DO:  /*NON-CAMPAIGN*/
    RUN PdCampaignNonCamp.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCampaignNonCamp C-Win 
PROCEDURE PdCampaignNonCamp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wexcel.sclass <> "E11" THEN DO:
    FIND LAST brstat.insure USE-INDEX insure03 WHERE 
              brstat.insure.compno      = TRIM(fi_camptruck)    AND
              brstat.insure.vatcode     = wexcel.covcod         AND /* cover */
              brstat.insure.text1       = "Non-Camp"            AND /* camp name*/       
              brstat.insure.text4       = wexcel.sclass         AND /* class */
              brstat.insure.icno        = wexcel.garage             /* garage */
    NO-LOCK NO-ERROR .
    IF AVAIL brstat.insure THEN DO:
        CREATE wexcamp.
        ASSIGN wexcamp.policy    = wexcel.policy
               wexcamp.campaign  = "Non-Camp"
               wexcel.pack       = brstat.insure.text3
               wexcamp.polmaster = "Non-Camp"
               wexcamp.tp_bi1    = INTE(brstat.insure.lname)     /* BI  */ 
               wexcamp.tp_bi2    = INTE(brstat.insure.addr1)     /* PA  */ 
               wexcamp.tp_pd     = INTE(brstat.insure.addr2)     /* PD  */ 
               wexcamp.pa411     = INTE(brstat.insure.addr3)     /* 411 */ 
               wexcamp.pa412     = INTE(brstat.insure.addr3)     /* 412 */
               wexcamp.pa42      = INTE(brstat.insure.addr4)     /* 42  */    
               wexcamp.pa43      = INTE(brstat.insure.telno)     /* 43  */ 
               wexcamp.base1     = "0"                 
               wexcamp.base2     = "0"                 
               wexcamp.ncb       = "0"                 
               wexcamp.loadcl    = "0"                 
               wexcamp.fleet     = "0"                 
               wexcamp.dspc      = "0"                 
               wexcamp.sumins    = IF (wexcel.covcod <> "2") AND (wexcel.covcod <> "3") THEN wexcel.si ELSE "0"  
               wexcamp.sumfit    = IF (wexcel.covcod = "3") THEN "0" ELSE wexcel.si                                               
               wexcamp.Prem_t    = INTE(wexcel.netprm). 
    END.
    ELSE DO: 
        CREATE wexcamp.
        ASSIGN wexcamp.policy    = wexcel.policy
               wexcamp.campaign  = wexcel.campaign
               wexcamp.polmaster = "" .
    END.
END.
ELSE DO:
    IF nv_yr = 1 THEN DO:
        CREATE wexcamp.
        ASSIGN wexcamp.policy    = wexcel.policy
               wexcamp.campaign  = "Non-Camp"
               wexcel.pack       = "T"
               wexcamp.polmaster = "Non-Camp"
               wexcamp.tp_bi1    = 500000     /* BI  */ 
               wexcamp.tp_bi2    = 10000000     /* PA  */ 
               wexcamp.tp_pd     = 2500000     /* PD  */ 
               wexcamp.pa411     = 100000     /* 411 */ 
               wexcamp.pa412     = 100000     /* 412 */
               wexcamp.pa42      = 100000     /* 42  */    
               wexcamp.pa43      = 300000     /* 43  */ 
               wexcamp.base1     = "0"                 
               wexcamp.base2     = "0"                 
               wexcamp.ncb       = "0"                 
               wexcamp.loadcl    = "0"                 
               wexcamp.fleet     = "0"                 
               wexcamp.dspc      = "0"                 
               wexcamp.sumins    = IF (wexcel.covcod <> "2") AND (wexcel.covcod <> "3") THEN wexcel.si ELSE "0"  
               wexcamp.sumfit    = IF (wexcel.covcod = "3") THEN "0" ELSE wexcel.si                                               
               wexcamp.Prem_t    = INTE(wexcel.netprm). 
    END.
    ELSE DO:
        CREATE wexcamp.
        ASSIGN wexcamp.policy    = wexcel.policy
               wexcamp.campaign  = "Non-Camp"
               wexcel.pack       = "T"
               wexcamp.polmaster = "Non-Camp"
               wexcamp.tp_bi1    = 1000000       /* BI  */ 
               wexcamp.tp_bi2    = 10000000     /* PA  */ 
               wexcamp.tp_pd     = 5000000      /* PD  */ 
               wexcamp.pa411     = 200000       /* 411 */ 
               wexcamp.pa412     = 200000       /* 412 */
               wexcamp.pa42      = 200000       /* 42  */    
               wexcamp.pa43      = 300000       /* 43  */ 
               wexcamp.base1     = "0"                 
               wexcamp.base2     = "0"                 
               wexcamp.ncb       = "0"                 
               wexcamp.loadcl    = "0"                 
               wexcamp.fleet     = "0"                 
               wexcamp.dspc      = "0"                 
               wexcamp.sumins    = IF (wexcel.covcod <> "2") AND (wexcel.covcod <> "3") THEN wexcel.si ELSE "0"  
               wexcamp.sumfit    = IF (wexcel.covcod = "3") THEN "0" ELSE wexcel.si                                               
               wexcamp.Prem_t    = INTE(wexcel.netprm). 
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCampaign_brstat C-Win 
PROCEDURE PDCampaign_brstat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A65-0203  parameter ของรถบรรทุก       
------------------------------------------------------------------------------*/
DEF VAR nv_brand AS CHAR .
DO: 
    /* รถบรรทุก ป.1 */
    IF wexcel.covcod = "1"  THEN DO:

        IF trim(wexcel.makdes) = "ISUZU" THEN nv_brand = "ISUZU" . 
        ELSE IF TRIM(wexcel.makdes) = "HINO" THEN nv_brand = "HINO" .
        ELSE nv_brand = "OTHER" .

        FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno      = TRIM(fi_camptruck)    AND
            brstat.insure.vatcode     = wexcel.covcod         AND /* cover */
            brstat.insure.text1       = trim(wexcel.campaign) and  /*campaign NO.*/
            brstat.insure.text2       = nv_brand   and              /* brand */
            brstat.insure.text4       = wexcel.sclass         and /* class */
            deci(brstat.insure.text5) = deci(wexcel.netprm)      /* net prem */
            NO-LOCK NO-ERROR .
        IF AVAIL brstat.insure THEN DO:
            ASSIGN 
                wexcel.pack       = brstat.insure.text3
                wexcamp.polmaster = "CAMP_NTL"
                wexcamp.tp_bi1    = int(brstat.insure.lname)     /* BI  */ 
                wexcamp.tp_bi2    = int(brstat.insure.addr1)     /* PA  */ 
                wexcamp.tp_pd     = int(brstat.insure.addr2)     /* PD  */ 
                wexcamp.pa411     = int(brstat.insure.addr3)     /* 411 */ 
                wexcamp.pa412     = int(brstat.insure.addr3)     /* 412 */
                wexcamp.pa42      = int(brstat.insure.addr4)     /* 42  */    
                wexcamp.pa43      = int(brstat.insure.telno)     /* 43  */       
                wexcamp.base1     = "0"
                wexcamp.base2     = "0"
                wexcamp.ncb       = "0"   
                wexcamp.loadcl    = "0"     
                wexcamp.fleet     = "0"
                wexcamp.dspc      = "0"
                wexcamp.sumins    = wexcel.si
                wexcamp.sumfit    = wexcel.si
                wexcamp.Prem_t    = deci(brstat.insure.text5) 
                wexcamp.acc       = IF brstat.insure.icaddr2 = "ACC+" THEN "A" ELSE ""  .  /* ACC+    */ 
        END.
        ELSE ASSIGN  wexcamp.polmaster = "" .
    END.
    ELSE DO:  /* รถบรรทุก ป.2 3 */
        FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno      = TRIM(fi_camptruck)    AND
            brstat.insure.vatcode     = wexcel.covcod         AND /* cover */
            brstat.insure.text1       = trim(wexcel.campaign) and  /*campaign NO.*/
            brstat.insure.text4       = wexcel.sclass         and /* class */
            deci(brstat.insure.text5) = deci(wexcel.netprm)      /* net prem */
            NO-LOCK NO-ERROR .
        IF AVAIL brstat.insure THEN DO:
            ASSIGN 
                wexcel.pack       = brstat.insure.text3
                wexcamp.polmaster = "CAMP_NTL"
                wexcamp.tp_bi1    = int(brstat.insure.lname)     /* BI  */ 
                wexcamp.tp_bi2    = int(brstat.insure.addr1)     /* PA  */ 
                wexcamp.tp_pd     = int(brstat.insure.addr2)     /* PD  */ 
                wexcamp.pa411     = int(brstat.insure.addr3)     /* 411 */ 
                wexcamp.pa412     = int(brstat.insure.addr3)     /* 412 */
                wexcamp.pa42      = int(brstat.insure.addr4)     /* 42  */    
                wexcamp.pa43      = int(brstat.insure.telno)     /* 43  */       
                wexcamp.base1     = "0"
                wexcamp.base2     = "0"
                wexcamp.ncb       = "0"   
                wexcamp.loadcl    = "0"     
                wexcamp.fleet     = "0"
                wexcamp.dspc      = "0"
                wexcamp.sumins    = wexcel.si
                wexcamp.sumfit    = wexcel.si
                wexcamp.Prem_t    = deci(brstat.insure.text5) 
                wexcamp.acc       = IF brstat.insure.icaddr2 = "ACC+" THEN "A" ELSE ""  .  /* ACC+    */ 
        END.
        ELSE ASSIGN wexcamp.polmaster = " " .
    END.
    RELEASE brstat.insure.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChangeData C-Win 
PROCEDURE PDChangeData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name AS CHAR . /*A65-0203*/

RUN PDChkChassis.

ASSIGN wexcel.brnsty =  "ML".  /*A63-00472*/

/*-- Check Name --*/
IF wexcel.ntitle <> "" THEN DO:
    wexcel.ntitle = TRIM(wexcel.ntitle).
END.
ELSE wexcel.ntitle = "".

/* comment by : A65-0203
IF wexcel.fname + wexcel.lname <> "" THEN DO:
    wexcel.fname = TRIM(TRIM(wexcel.fname) + " " + TRIM(wexcel.lname)) .
 end. */ 
/* add by : A65-0203*/
ASSIGN  nv_name = "" 
        nv_name = TRIM(TRIM(wexcel.fname) + " " + TRIM(wexcel.lname)) .
IF nv_name <> "" THEN DO: 
   ASSIGN 
   wexcel.firstname = TRIM(wexcel.fname) 
   wexcel.lastname  = TRIM(wexcel.lname)
   wexcel.fname     = nv_name.
END.
/* end : A65-0203*/

wexcel.policy = wexcel.newpol. /*---add by Chaiyong W. A59-0614 02/05/2017*/
wexcel.cedpol = REPLACE(wexcel.cedpol," ","").


/*-- Vehreg No. --*/
IF wexcel.provin <> "" THEN DO:
    FIND FIRST brstat.insure WHERE
               brstat.insure.compno = "999" AND
               brstat.insure.fname  = TRIM(wexcel.provin) NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        IF wexcel.vehreg <> "" THEN DO:
            wexcel.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(brstat.insure.lname).
        END.
    END.
    ELSE wexcel.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(wexcel.provin). /*----add by Chaiyong W. A59-0614 27/04/2017*/
END.

/*---Begin by Chaiyong W. A59-0614 18/07/2017*/
wexcel.modcod = TRIM(wexcel.modcod).
IF wexcel.modcod <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
               stat.maktab_fil.sclass = wexcel.sclass AND
               stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            wexcel.modcod = stat.maktab_fil.modcod
            wexcel.seat   = STRING(stat.maktab_fil.seats)
            wexcel.vehgrp = stat.maktab_fil.prmpac.
    END.
    ELSE DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                   stat.maktab_fil.sclass = "****" AND
                   stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            ASSIGN
                wexcel.modcod = stat.maktab_fil.modcod
                wexcel.seat   = STRING(stat.maktab_fil.seats)
                wexcel.vehgrp = stat.maktab_fil.prmpac.
        END.
        ELSE wexcel.modcod = "".
    END.

    IF wexcel.modcod <> "" THEN DO:
        IF wexcel.seat = "" THEN DO:
            IF wexcel.sclass = "110" THEN DO: 
                ASSIGN
                    wexcel.seat   = "7"
                    wexcel.vehuse = "1".
            END.
            ELSE IF wexcel.sclass = "210" THEN DO:
                ASSIGN
                    wexcel.seat   = "12"
                    wexcel.vehuse = "1".
            END.
            ELSE IF wexcel.sclass = "320" THEN DO:
                ASSIGN
                    wexcel.seat   = "3"
                    wexcel.vehuse = "2".
            END.
        END.
        
        IF wexcel.vehuse = "" THEN DO:
            wexcel.vehuse = SUBSTR(wexcel.sclass,2,1).
        END.
        /*---Begin by Chaiyong W. A59-0614 27/04/2017*/
        IF TRIM(wexcel.sclass) = "320" THEN DO:
            IF wexcel.body = "บรรทุก" OR wexcel.body = "รถบรรทุก" OR  wexcel.body = "Truck" THEN wexcel.vehuse = "2".
            ELSE IF wexcel.body = "กระบะ" OR  wexcel.body = "Pickup" OR  wexcel.body = "minitruck" THEN wexcel.vehuse = "1".
            ELSE wexcel.vehuse = "1".
        END.
    END.

END.
IF wexcel.modcod = "" THEN DO:
/*End by Chaiyong W. A59-0614 18/07/2017-----*/
    /*-- Redbook Code --*/
    nv_lencod = LENGTH(wexcel.moddes) - 4.
    
    IF wexcel.moddes <> "" THEN DO:
        wexcel.modcod = SUBSTR(wexcel.moddes,nv_lencod + 1,4).
        wexcel.modcod = TRIM(SUBSTR(wexcel.makdes,1,4)) + TRIM(wexcel.modcod).
    END.
    ELSE wexcel.modcod = "".
    
    RUN PDChkRedbook.
END. /*---add end by Chaiyong W. A59-614 18/07/2017*/
/*-- Driver Age --*/
IF wexcel.driname = "ระบุผู้ขับขี่" THEN DO:
    IF wexcel.dribir1 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir1)) > YEAR(TODAY) THEN DO:
            wexcel.driage1 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir1)) - 543).
        END.
        ELSE wexcel.driage1 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir1)).
    END.

    IF wexcel.dribir2 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir2)) > YEAR(TODAY) THEN DO:
            wexcel.driage2 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir2)) - 543).
        END.
        ELSE wexcel.driage2 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir2)).
    END.

    IF wexcel.drinam1 <> "" AND wexcel.drinam2 <> "" THEN DO:
        wexcel.driname = "2".
    END.
    ELSE IF wexcel.drinam1 <> "" AND wexcel.drinam2 = "" THEN DO: 
        wexcel.driname = "1".
    END.
END.

/*-- Cover Type --*/
IF wexcel.covcod = "2+" THEN DO:
    wexcel.covcod = "2.2".
END.
ELSE IF wexcel.covcod = "3+" THEN DO:
    wexcel.covcod = "3.2".
END.

/*-- Garage --*/
IF wexcel.garage = "ห้าง" THEN wexcel.garage = "G".
ELSE IF wexcel.garage = "อู่" THEN wexcel.garage = "".
ELSE wexcel.garage = TRIM(wexcel.garage).

IF wexcel.prvpol = "" THEN RUN PDCampaign.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChangeDataNew C-Win 
PROCEDURE PDChangeDataNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name AS CHAR .

RUN PDChkChassis.

ASSIGN wexcel.brnsty =  "ML".

/*-- Check Name --*/
IF wexcel.ntitle <> "" THEN DO:
    wexcel.ntitle = TRIM(wexcel.ntitle).
END.
ELSE wexcel.ntitle = "".

ASSIGN  nv_name = "" 
        nv_name = TRIM(TRIM(wexcel.fname) + " " + TRIM(wexcel.lname)) .
IF nv_name <> "" THEN DO: 
   ASSIGN 
   wexcel.firstname = TRIM(wexcel.fname) 
   wexcel.lastname  = TRIM(wexcel.lname)
   wexcel.fname     = nv_name.
END.

wexcel.policy = wexcel.newpol. 
wexcel.cedpol = REPLACE(wexcel.cedpol," ","").

/*-- Vehreg No. --*/
IF wexcel.provin <> "" THEN DO:
    FIND FIRST brstat.insure WHERE
               brstat.insure.compno = "999" AND
               brstat.insure.fname  = TRIM(wexcel.provin) NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        IF wexcel.vehreg <> "" THEN DO:
            wexcel.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(brstat.insure.lname).
        END.
    END.
    ELSE wexcel.vehreg = TRIM(wexcel.vehreg) + " " + TRIM(wexcel.provin). /*----add by Chaiyong W. A59-0614 27/04/2017*/
END.

wexcel.modcod = TRIM(wexcel.modcod).
IF wexcel.modcod <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
               stat.maktab_fil.sclass = wexcel.sclass AND
               stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            wexcel.modcod = stat.maktab_fil.modcod
            wexcel.seat   = STRING(stat.maktab_fil.seats)
            wexcel.vehgrp = stat.maktab_fil.prmpac.

        /*-- Add A67-0029 --*/
        IF wexcel.evflg = YES THEN DO:
            nv_si_mv = stat.maktab_fil.si.
        END.
        ELSE nv_si_mv = 0.
        /*-- End Add A67-0029 --*/
    END.
    ELSE DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                   stat.maktab_fil.sclass = "****" AND
                   stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            ASSIGN
                wexcel.modcod = stat.maktab_fil.modcod
                wexcel.seat   = STRING(stat.maktab_fil.seats)
                wexcel.vehgrp = stat.maktab_fil.prmpac.

            IF wexcel.evflg = YES THEN DO:
                nv_si_mv = stat.maktab_fil.si.
            END.
            ELSE nv_si_mv = 0.
            
        END.
        ELSE wexcel.modcod = "".
    END.

    IF wexcel.modcod <> "" THEN DO:
        IF wexcel.seat = "" THEN DO:
            IF wexcel.sclass = "110"  OR
               wexcel.sclass = "110E" OR
               wexcel.sclass = "120E" OR
               wexcel.sclass = "E11"  OR
               wexcel.sclass = "E12"  THEN DO: 
                ASSIGN
                    wexcel.seat   = "7"
                    wexcel.vehuse = "1".
            END.
            ELSE IF wexcel.sclass = "210" THEN DO:
                ASSIGN
                    wexcel.seat   = "12"
                    wexcel.vehuse = "1".
            END.
            ELSE IF wexcel.sclass = "320" THEN DO:
                ASSIGN
                    wexcel.seat   = "3"
                    wexcel.vehuse = "2".
            END.
        END.
        
        IF wexcel.vehuse = "" THEN DO:
            wexcel.vehuse = SUBSTR(wexcel.sclass,2,1).
        END.
 
        IF TRIM(wexcel.sclass) = "320" THEN DO:
            IF wexcel.body = "บรรทุก" OR wexcel.body = "รถบรรทุก" OR  wexcel.body = "Truck" THEN wexcel.vehuse = "2".
            ELSE IF wexcel.body = "กระบะ" OR  wexcel.body = "Pickup" OR  wexcel.body = "minitruck" THEN wexcel.vehuse = "1".
            ELSE wexcel.vehuse = "1".
        END.
    END.

END.
IF wexcel.modcod = "" THEN DO:
    nv_lencod = LENGTH(wexcel.moddes) - 4.
    
    IF wexcel.moddes <> "" THEN DO:
        wexcel.modcod = SUBSTR(wexcel.moddes,nv_lencod + 1,4).
        wexcel.modcod = TRIM(SUBSTR(wexcel.makdes,1,4)) + TRIM(wexcel.modcod).
    END.
    ELSE wexcel.modcod = "".
    
    RUN PDChkRedbook.
END.

/*-- Driver Age --*/
IF wexcel.driname = "ระบุผู้ขับขี่" THEN DO:
    IF wexcel.dribir1 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir1)) > YEAR(TODAY) THEN DO:
            wexcel.driage1 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir1)) - 543).
        END.
        ELSE wexcel.driage1 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir1)).
    END.

    IF wexcel.dribir2 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir2)) > YEAR(TODAY) THEN DO:
            wexcel.driage2 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir2)) - 543).
        END.
        ELSE wexcel.driage2 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir2)).
    END.

    IF wexcel.dribir3 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir3)) > YEAR(TODAY) THEN DO:
            wexcel.driage3 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir3)) - 543).
        END.
        ELSE wexcel.driage3 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir3)).
    END.

    IF wexcel.dribir4 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir4)) > YEAR(TODAY) THEN DO:
            wexcel.driage4 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir4)) - 543).
        END.
        ELSE wexcel.driage4 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir4)).
    END.

    IF wexcel.dribir5 <> "" THEN DO:
        IF YEAR(DATE(wexcel.dribir5)) > YEAR(TODAY) THEN DO:
            wexcel.driage5 = YEAR(TODAY) - (YEAR(DATE(wexcel.dribir5)) - 543).
        END.
        ELSE wexcel.driage5 = YEAR(TODAY) - YEAR(DATE(wexcel.dribir5)).
    END.

    IF wexcel.drinam1 <> "" AND wexcel.drinam2 <> "" AND
       wexcel.drinam3 <> "" AND wexcel.drinam4 <> "" AND
       wexcel.drinam5 <> "" THEN DO:
        wexcel.driname = "5".
    END.
    ELSE IF wexcel.drinam1 <> "" AND wexcel.drinam2 <> "" AND
            wexcel.drinam3 <> "" AND wexcel.drinam4 <> "" THEN DO:
        wexcel.driname = "4".
    END.
    ELSE IF wexcel.drinam1 <> "" AND wexcel.drinam2 <> "" AND
            wexcel.drinam3 <> "" THEN DO:
        wexcel.driname = "3".
    END.
    ELSE IF wexcel.drinam1 <> "" AND wexcel.drinam2 <> "" THEN DO:
        wexcel.driname = "2".
    END.
    ELSE IF wexcel.drinam1 <> "" AND wexcel.drinam2 = "" THEN DO: 
        wexcel.driname = "1".
    END.
END.

IF wexcel.sclass = "E11" THEN DO:
    IF wexcel.driname = "" THEN DO:
        ASSIGN   
            wexcel.werror = wexcel.werror + "Class E11 ต้องมี Driver Name  |"
            wexcel.wmark  = NO.
    END.
END.
ELSE IF wexcel.sclass = "E12" THEN DO:
    IF wexcel.driname <> "" THEN DO:
        ASSIGN   
            wexcel.werror = wexcel.werror + "Class E12 ไม่สามารถมี Driver Name ได้  |"
            wexcel.wmark  = NO.
    END.
END.
ELSE DO:
    IF INTE(wexcel.driname) > 2 THEN DO:
        ASSIGN   
            wexcel.werror = wexcel.werror + "Driver Name ต้องน้อยกว่าหรือเท่ากับ 2  |"
            wexcel.wmark  = NO.
    END.
END.

/*-- Cover Type --*/
IF wexcel.covcod = "2+" THEN DO:
    wexcel.covcod = "2.2".
END.
ELSE IF wexcel.covcod = "3+" THEN DO:
    wexcel.covcod = "3.2".
END.

/*-- Garage --*/
IF wexcel.garage = "ห้าง" THEN wexcel.garage = "G".
ELSE IF wexcel.garage = "อู่" THEN wexcel.garage = "".
ELSE wexcel.garage = TRIM(wexcel.garage).

IF wexcel.wmark = YES THEN DO:
    IF wexcel.prvpol = "" THEN RUN PDCampaignNew.
END.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckMatch C-Win 
PROCEDURE PDCheckMatch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wexcel WHERE wexcel.newpol <> "" : /* A65-0203*/
    fi_display = "Please wait check data policy: " + wexcel.newpol.
    DISP fi_display WITH FRAME fr_main.
    /* add by : A65-0203 */
    IF wexcel.newpol <> "" THEN DO:
        Find LAST sicuw.uwm100 Use-index uwm10001 WHERE sicuw.uwm100.policy = TRIM(wexcel.newpol)  No-lock no-error no-wait.
           If avail sicuw.uwm100 Then DO:
               ASSIGN   wexcel.werror = wexcel.werror + "Policy has on Premium  |"
                        wexcel.wmark  = NO.
           END.
    END.
    /* end : A65-0203 */

    /*-- Check Name and Address --*/
    IF TRIM(wexcel.fname) + TRIM(wexcel.lname) = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Name is Null |"
            wexcel.wmark  = NO.
    END.

    IF TRIM(wexcel.addr1) + TRIM(wexcel.addr2) +
       TRIM(wexcel.addr3) + TRIM(wexcel.addr4) = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Address is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- Com.date and Exp.date --*/
    IF wexcel.comdat = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Comm.Date is Null |"
            wexcel.wmark  = NO.
    END.

    IF wexcel.expdat = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Exp.Date is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- Chassis No. --*/
    IF wexcel.cha_no = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Chassis No. is Null |"
            wexcel.wmark  = NO.
    END.
    /* add by : A65-0203 */
    ELSE DO:
      FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no = trim(wexcel.cha_no) AND 
                substr(sicuw.uwm301.policy,3,2) = "70" No-lock no-error no-wait.
        If avail sicuw.uwm301 Then DO:
          FOR EACH  sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(wexcel.cha_no) NO-LOCK:
          
              Find LAST sicuw.uwm100 Use-index uwm10001       Where
                  sicuw.uwm100.policy = sicuw.uwm301.policy   and
                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and   
                  sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
              If avail sicuw.uwm100 Then DO:
                  IF DATE(sicuw.uwm100.expdat) > date(wexcel.comdat) AND 
                     YEAR(sicuw.uwm100.expdat) >= YEAR(date(wexcel.expdat)) AND  
                     sicuw.uwm100.polsta    = "IF" THEN DO:
                     ASSIGN wexcel.werror = wexcel.werror + "Chassis No. has Policy No. " + sicuw.uwm100.policy + "|"
                            wexcel.wmark  = NO.
                  END.
              END.
          END. /*FOR EACH  sicuw.uwm301 */
        END.        /*avil 301*/
        RELEASE sicuw.uwm301.
        RELEASE sicuw.uwm100.
    END.
    /* end : A65-0203 */
    /*-- Vehreg No. --*/
    IF wexcel.vehreg = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Vehreg No. is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- ประเภทความคุ้มครอง --*/
    IF wexcel.covcod = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Cover Type is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- Make and Model --*/
    IF wexcel.makdes = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Brand is Null |"
            wexcel.wmark  = NO.
    END.

    IF wexcel.moddes = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Model is Null |"
            wexcel.wmark  = NO.
    END.
    /* create by : Ranu I. A65-0203 */
    /* check campaign code parameter */
    IF wexcel.prvpol = "" THEN DO:
        IF wexcel.campaign <> "" THEN DO:
            FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno      = fi_camptruck   AND
            brstat.insure.text1       = TRIM(wexcel.campaign)  NO-LOCK NO-ERROR .  /*campaign NO.*/
            IF NOT AVAIL brstat.insure THEN DO:
        
                FIND LAST stat.caccount USE-INDEX caccount05 WHERE caccount.camcod = TRIM(wexcel.campaign) NO-LOCK NO-ERROR.
                IF AVAIL stat.caccount THEN DO:
                    FIND LAST stat.campaign_fil USE-INDEX campfil14  WHERE campaign_fil.camcod = caccount.camcod NO-LOCK NO-ERROR.
                    IF NOT AVAIL stat.campaign_fil THEN DO:
                        ASSIGN wexcel.werror = wexcel.werror + "Campaign code : " + wexcel.campaign + " ยังไม่มีวิธีคีย์ในระบบพารามิเตอร์ |" 
                               wexcel.wmark  = NO. 
                    END.
                END.
                ELSE ASSIGN wexcel.werror = wexcel.werror +  "ไม่พบรหัสแคมเปญ :" + wexcel.campaign + " ในระบบพารามิเตอร์ |"
                            wexcel.wmark  = NO.   
            END.
        END.
        
        IF wexcel.sclass = "" THEN DO:
             ASSIGN
                wexcel.werror = wexcel.werror + "Class is Null |"
                wexcel.wmark  = NO.
        END.
        
        IF wexcel.campaign = ""  THEN DO:
            ASSIGN
                wexcel.werror = wexcel.werror + "Campiagn is Null |".
                /*wexcel.wmark  = NO.*/
        END.
    END.
    /* end : A65-0203 */
    /*----Begin by Chaiyong W. A59-0614 15/12/2016*/
    IF LENGTH(wexcel.paycod) > 2 THEN DO:  
        ASSIGN
            wexcel.werror = wexcel.werror + "Pay code = 2 symbol |"
            wexcel.wmark  = NO.
    END.
    /*End by Chaiyong W. A59-0614 15/12/2016------*/

    IF wexcel.wmark = YES THEN DO: /*Change Data Before Create*/
        RUN PDChangeData.
    END.

    /*-----Begin by Chaiyong W. A61-0016 22/03/2018*/
    RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */

    RUN pd_clearrenewal.
    /*Add by Kridtiya i. A63-0472*/
    RUN proc_assign2addr (INPUT  wexcel.addr1  
                         ,INPUT  wexcel.addr2 
                         ,INPUT  wexcel.addr3 + " " + wexcel.addr4 
                         ,INPUT  ""     /*wexcel.occup  */ 
                         ,OUTPUT wexcel.codeocc  
                         ,OUTPUT wexcel.codeaddr1
                         ,OUTPUT wexcel.codeaddr2
                         ,OUTPUT wexcel.codeaddr3).
    IF nv_postcd <> ""  THEN DO:
        wexcel.postcd =  nv_postcd.
        IF      INDEX(wexcel.addr4,nv_postcd) <> 0 THEN wexcel.addr4 = trim(REPLACE(wexcel.addr4,nv_postcd,"")). 
        ELSE IF INDEX(wexcel.addr3,nv_postcd) <> 0 THEN wexcel.addr3 = trim(REPLACE(wexcel.addr3,nv_postcd,"")). 
        ELSE IF INDEX(wexcel.addr2,nv_postcd) <> 0 THEN wexcel.addr2 = trim(REPLACE(wexcel.addr2,nv_postcd,"")). 
        ELSE IF INDEX(wexcel.addr1,nv_postcd) <> 0 THEN wexcel.addr1 = trim(REPLACE(wexcel.addr1,nv_postcd,"")). 

    END.
    RUN proc_matchtypins (INPUT  wexcel.ntitle 
                         ,INPUT  wexcel.fname
                         ,OUTPUT wexcel.insnamtyp
                         ,OUTPUT wexcel.firstName
                         ,OUTPUT wexcel.lastName).
    ASSIGN 
        wexcel.financecd   = "FNTL".
    IF      wexcel.broker = "B3MLNTL101"  THEN  wexcel.campaign_ov = "USED". 
    ELSE IF wexcel.broker = "B3MLNTL102" AND wexcel.prvpol <> ""  THEN  wexcel.campaign_ov = "RENEW".  
    ELSE IF wexcel.broker = "B3MLNTL102" AND wexcel.prvpol =  ""  THEN  wexcel.campaign_ov = "USED".  
    ELSE IF wexcel.broker = "B3MLNTL103" AND wexcel.prvpol <> ""  THEN  wexcel.campaign_ov = "RENEW".    
    ELSE IF wexcel.broker = "B3MLNTL103" AND wexcel.prvpol =  ""  THEN  wexcel.campaign_ov = "USED". 
    ELSE IF wexcel.broker = "B3MLNTL104" AND wexcel.prvpol <> ""  THEN  wexcel.campaign_ov = "RENEW".     
    ELSE IF wexcel.broker = "B3MLNTL104" AND wexcel.prvpol =  ""  THEN  wexcel.campaign_ov = "USED".   
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /*Add by Kridtiya i. A63-0472*/
    /*Add by Kridtiya i. A65-0125*/
    IF index(wexcel.body,"TRUCK") = 0 AND (wexcel.covcod = "1" OR wexcel.covcod = "2.2" )  THEN DO:
        IF  wexcel.sclass = "110" OR wexcel.sclass = "210" OR wexcel.sclass = "320"  THEN
            wexcel.product = "CLAIMDI".
    END.
    /*Add by Kridtiya i. A65-0125*/
  
    IF wexcel.prvpol <> "" /*AND wexcel.wmark = YES AND wexcel.instyp  = "RENEW"*/ THEN DO: 
        wexcel.wmark = YES.
        ASSIGN
            nv_flet_per   = 0
            nv_ncbper     = 0
            nv_dss_per    = 0
            nv_stf_per    = 0
            nv_cl_per     = 0 .

        RUN proc_assignrenew_pol. 
    END. 
    ELSE  /*End by Chaiyong W. A61-0016 22/03/2018-------*/
    IF wexcel.wmark = YES THEN DO: /*Create Policy*/

        RUN PDCreate100.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckMatchNew C-Win 
PROCEDURE PDCheckMatchNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH wexcel WHERE wexcel.newpol <> "" :
    fi_display = "Please wait check data policy: " + wexcel.newpol.
    DISP fi_display WITH FRAME fr_main.

    IF wexcel.newpol <> "" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                  sicuw.uwm100.policy = TRIM(wexcel.newpol)  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN   wexcel.werror = wexcel.werror + "Policy has on Premium  |"
                     wexcel.wmark  = NO.
        END.
    END.

    /*-- Check Name and Address --*/
    IF TRIM(wexcel.fname) + TRIM(wexcel.lname) = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Name is Null |"
            wexcel.wmark  = NO.
    END.

    IF TRIM(wexcel.addr1) + TRIM(wexcel.addr2) +
       TRIM(wexcel.addr3) + TRIM(wexcel.addr4) = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Address is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- Com.date and Exp.date --*/
    IF wexcel.comdat = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Comm.Date is Null |"
            wexcel.wmark  = NO.
    END.

    IF wexcel.expdat = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Exp.Date is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- Chassis No. --*/
    IF wexcel.cha_no = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Chassis No. is Null |"
            wexcel.wmark  = NO.
    END.
    ELSE DO:
      FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                sicuw.uwm301.cha_no = trim(wexcel.cha_no) AND 
                substr(sicuw.uwm301.policy,3,2) = "70" No-lock no-error no-wait.
        If avail sicuw.uwm301 Then DO:
          FOR EACH  sicuw.uwm301 Use-index uwm30121 Where sicuw.uwm301.cha_no = trim(wexcel.cha_no) NO-LOCK:
          
              Find LAST sicuw.uwm100 Use-index uwm10001       Where
                  sicuw.uwm100.policy = sicuw.uwm301.policy   and
                  sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and   
                  sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
              If avail sicuw.uwm100 Then DO:
                  IF DATE(sicuw.uwm100.expdat) > date(wexcel.comdat) AND 
                     YEAR(sicuw.uwm100.expdat) >= YEAR(date(wexcel.expdat)) AND  
                     sicuw.uwm100.polsta    = "IF" THEN DO:
                     ASSIGN wexcel.werror = wexcel.werror + "Chassis No. has Policy No. " + sicuw.uwm100.policy + "|"
                            wexcel.wmark  = NO.
                  END.
              END.
          END. /*FOR EACH  sicuw.uwm301 */
        END.  /*avil 301*/
        RELEASE sicuw.uwm301.
        RELEASE sicuw.uwm100.
    END.

    /*-- Vehreg No. --*/
    IF wexcel.vehreg = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Vehreg No. is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- ประเภทความคุ้มครอง --*/
    IF wexcel.covcod = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Cover Type is Null |"
            wexcel.wmark  = NO.
    END.

    /*-- Make and Model --*/
    IF wexcel.makdes = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Brand is Null |"
            wexcel.wmark  = NO.
    END.

    IF wexcel.moddes = "" THEN DO:
        ASSIGN
            wexcel.werror = wexcel.werror + "Model is Null |"
            wexcel.wmark  = NO.
    END.

    IF wexcel.prvpol = "" THEN DO:
        IF wexcel.campaign <> "" THEN DO:
            FIND LAST brstat.insure USE-INDEX insure03 WHERE 
            brstat.insure.compno      = fi_camptruck   AND
            brstat.insure.text1       = TRIM(wexcel.campaign)  NO-LOCK NO-ERROR .  /*campaign NO.*/
            IF NOT AVAIL brstat.insure THEN DO:
        
                FIND LAST stat.caccount USE-INDEX caccount05 WHERE caccount.camcod = TRIM(wexcel.campaign) NO-LOCK NO-ERROR.
                IF AVAIL stat.caccount THEN DO:
                    FIND LAST stat.campaign_fil USE-INDEX campfil14  WHERE campaign_fil.camcod = caccount.camcod NO-LOCK NO-ERROR.
                    IF NOT AVAIL stat.campaign_fil THEN DO:
                        ASSIGN wexcel.werror = wexcel.werror + "Campaign code : " + wexcel.campaign + " ยังไม่มีวิธีคีย์ในระบบพารามิเตอร์ |" 
                               wexcel.wmark  = NO. 
                    END.
                END.
                ELSE ASSIGN wexcel.werror = wexcel.werror +  "ไม่พบรหัสแคมเปญ :" + wexcel.campaign + " ในระบบพารามิเตอร์ |"
                            wexcel.wmark  = NO.   
            END.
        END.
        
        IF wexcel.sclass = "" THEN DO:
             ASSIGN
                wexcel.werror = wexcel.werror + "Class is Null |"
                wexcel.wmark  = NO.
        END.
        
        IF wexcel.campaign = ""  THEN DO:
            ASSIGN
                wexcel.werror = wexcel.werror + "Campiagn is Null |".
        END.
    END.

    IF LENGTH(wexcel.paycod) > 2 THEN DO:  
        ASSIGN
            wexcel.werror = wexcel.werror + "Pay code = 2 symbol |"
            wexcel.wmark  = NO.
    END.

    IF TRIM(wexcel.sclass) = "E11" THEN DO:
        IF wexcel.driname <> "1" AND
           wexcel.driname <> "2" AND
           wexcel.driname <> "3" AND
           wexcel.driname <> "4" AND
           wexcel.driname <> "5" THEN DO:
            ASSIGN
                wexcel.werror = wexcel.werror + "(E11) Driver Name are 1 to 5 only |"
                wexcel.wmark  = NO.
        END.
    END.
    ELSE IF TRIM(wexcel.sclass) = "E12" THEN DO:
        IF INTE(wexcel.driname) <> 0 THEN DO:
            ASSIGN
                wexcel.werror = wexcel.werror + "Driver must be null |"
                wexcel.wmark  = NO.
        END.
    END.
    ELSE DO:
        IF INTE(wexcel.driname) <> 0 THEN DO:
            IF INTE(wexcel.driname) <= 1 OR INTE(wexcel.driname) >= 2 THEN DO:
                ASSIGN
                    wexcel.werror = wexcel.werror + "Driver name are 1 to 2 only |"
                    wexcel.wmark  = NO.
            END.
        END.
    END.

    IF wexcel.wmark = YES THEN DO: /*Change Data Before Create*/
        RUN PDChangeDataNew.
    END.

    RUN proc_susspect.
    RUN pd_clearrenewal.

    RUN proc_assign2addr (INPUT  wexcel.addr1  
                         ,INPUT  wexcel.addr2 
                         ,INPUT  wexcel.addr3 + " " + wexcel.addr4 
                         ,INPUT  ""     /*wexcel.occup  */ 
                         ,OUTPUT wexcel.codeocc  
                         ,OUTPUT wexcel.codeaddr1
                         ,OUTPUT wexcel.codeaddr2
                         ,OUTPUT wexcel.codeaddr3).
    IF nv_postcd <> ""  THEN DO:
        wexcel.postcd =  nv_postcd.
        IF      INDEX(wexcel.addr4,nv_postcd) <> 0 THEN wexcel.addr4 = trim(REPLACE(wexcel.addr4,nv_postcd,"")). 
        ELSE IF INDEX(wexcel.addr3,nv_postcd) <> 0 THEN wexcel.addr3 = trim(REPLACE(wexcel.addr3,nv_postcd,"")). 
        ELSE IF INDEX(wexcel.addr2,nv_postcd) <> 0 THEN wexcel.addr2 = trim(REPLACE(wexcel.addr2,nv_postcd,"")). 
        ELSE IF INDEX(wexcel.addr1,nv_postcd) <> 0 THEN wexcel.addr1 = trim(REPLACE(wexcel.addr1,nv_postcd,"")). 

    END.
    RUN proc_matchtypins (INPUT  wexcel.ntitle 
                         ,INPUT  wexcel.fname
                         ,OUTPUT wexcel.insnamtyp
                         ,OUTPUT wexcel.firstName
                         ,OUTPUT wexcel.lastName).

    ASSIGN 
        wexcel.financecd   = "FNTL".
    IF      wexcel.broker = "B3MLNTL101"  THEN  wexcel.campaign_ov = "USED". 
    ELSE IF wexcel.broker = "B3MLNTL102" AND wexcel.prvpol <> ""  THEN  wexcel.campaign_ov = "RENEW".  
    ELSE IF wexcel.broker = "B3MLNTL102" AND wexcel.prvpol =  ""  THEN  wexcel.campaign_ov = "USED".  
    ELSE IF wexcel.broker = "B3MLNTL103" AND wexcel.prvpol <> ""  THEN  wexcel.campaign_ov = "RENEW".    
    ELSE IF wexcel.broker = "B3MLNTL103" AND wexcel.prvpol =  ""  THEN  wexcel.campaign_ov = "USED". 
    ELSE IF wexcel.broker = "B3MLNTL104" AND wexcel.prvpol <> ""  THEN  wexcel.campaign_ov = "RENEW".     
    ELSE IF wexcel.broker = "B3MLNTL104" AND wexcel.prvpol =  ""  THEN  wexcel.campaign_ov = "USED".   

    IF INDEX(wexcel.body,"TRUCK") = 0 AND (wexcel.covcod = "1" OR wexcel.covcod = "2.2" )  THEN DO:
        IF  wexcel.sclass = "110" OR wexcel.sclass = "210" OR wexcel.sclass = "320" OR
            wexcel.sclass = "E11" OR wexcel.sclass = "E12" THEN  /*Add A67-0029*/
            wexcel.product = "CLAIMDI".
    END.

    IF wexcel.prvpol <> "" THEN DO: 
        wexcel.wmark = YES.
        ASSIGN
            nv_flet_per   = 0
            nv_ncbper     = 0
            nv_dss_per    = 0
            nv_stf_per    = 0
            nv_cl_per     = 0 .

        RUN proc_assignrenew_pol. 
    END. 
    ELSE  
    IF wexcel.wmark = YES THEN DO: /*Create Policy*/
        RUN PDCreate100New.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkChassis C-Win 
PROCEDURE PDChkChassis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_display = "Please wait..Check Chassis..".
DISPLAY fi_display WITH FRAME fr_main.

DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len    AS INTE INIT 0.

ASSIGN
    nv_uwm301trareg = ""
    nv_uwm301trareg = wexcel.cha_no.

loop_chk1:
REPEAT:
    IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
                          SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk1.
END.  /*loop_chk1*/

loop_chk2:
REPEAT:
    IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk2.
END.

loop_chk3:
REPEAT:
    IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk3.
END.

loop_chk4:
REPEAT:
    IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk4.
END.

loop_chk5:
REPEAT:
    IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk5.
END.

loop_chk6:
REPEAT:
    IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk6.
END.

loop_chk7:
REPEAT:
    IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk7.
END.

loop_chk8:
REPEAT:
    IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk8.
END.

loop_chk9:
REPEAT:
    IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk9.
END.

loop_chk10:
REPEAT:
    IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk10.
END.

loop_chk11:
REPEAT:
    IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk11.
END.

loop_chk12:
REPEAT:
    IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk12.
END.

loop_chk13:
REPEAT:
    IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk13.
END.

loop_chk14:
REPEAT:
    IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk14.
END.

loop_chk15:
REPEAT:
    IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk15.
END.

loop_chk16:
REPEAT:
    IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk16.
END.

loop_chk17:
REPEAT:
    IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk17.
END.

loop_chk18:
REPEAT:
    IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk18.
END.

loop_chk19:
REPEAT:
    IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
        
    END.
    ELSE LEAVE loop_chk19.
END.

IF nv_uwm301trareg <> "" THEN ASSIGN wexcel.trareg = nv_uwm301trareg.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkMthPrm C-Win 
PROCEDURE PDChkMthPrm :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE VAR nu_prem   AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.
DEFINE VAR nu_stmp   AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.
DEFINE VAR nu_stmp1  AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.
DEFINE VAR nu_stmp2  AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.
DEFINE VAR nu_tax    AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.
DEFINE VAR nu_prem_t AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.
DEFINE VAR nv_chkprm1 AS DECI FORMAT ">>,>>>,>>9.99-" INIT 0.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.

FIND FIRST wuwm301 WHERE wuwm301.policy = wuwm100.policy NO-LOCK NO-ERROR.
IF AVAIL wuwm301 THEN DO:
    nu_prem_t = wuwm301.prem_t.
END.

/*-- ถอยเบี้ย --*/
/*-- Tax --*/
nu_tax = (nu_prem_t * 7) / 107.

/*-- Stamp --*/
nu_stmp1 = ROUND((nu_prem_t - nu_tax) * (0.4 / 100),0).
nu_stmp2 = ROUND((nu_prem_t - nu_tax) * (0.4 / 100),2).

nu_stmp = nu_stmp2 - nu_stmp1.

IF nu_stmp > 0 THEN nu_stmp = nu_stmp1 + 1.
               ELSE nu_stmp = nu_stmp1.

/*-- Premium --*/
nu_prem = ROUND(nu_prem_t - nu_tax - nu_stmp,0).
/*MESSAGE "MatchPrem " nu_prem VIEW-AS ALERT-BOX.*//*Phorn*/
/*-- Check Premium --*/
loop_prm:
REPEAT:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    IF sic_bran.uwm100.gap_p <> nu_prem THEN DO:

        OUTPUT TO testNTL.txt APPEND.
        PUT "nu_prem " nu_prem  "nv_chkprm1 " nv_chkprm1
            "nv_dss_per " nv_dss_per "prem100 " sic_bran.uwm100.gap_p
            "nv_baseprm1 " nv_baseprm1 
        SKIP.
        OUTPUT CLOSE.

        IF sic_bran.uwm100.gap_p > nu_prem THEN DO:
            nv_chkprm1 = sic_bran.uwm100.gap_p - nu_prem.
        END.
        ELSE DO:
            nv_chkprm1 = nu_prem - sic_bran.uwm100.gap_p.
        END.

        IF nv_chkprm1 <= 1 THEN LEAVE loop_prm.

        IF ROUND(sic_bran.uwm100.gap_p / 2,0) > nu_prem THEN DO:
            nv_baseprm1 = ROUND(nv_baseprm1 / 2,0).
    
            RUN PDChkPrm132.
    
            RUN PDCreate132.
            
            RUN PDAutoSave.
        END.

        FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
        IF sic_bran.uwm100.gap_p > nu_prem THEN DO:
            
            IF nv_dss_per > 30 THEN DO:
                IF nv_baseprm1 <> 0 THEN DO:
                    nv_baseprm1 = nv_baseprm1 - 1.
                END.
                ELSE LEAVE loop_prm.
            END.
            ELSE DO:
                nv_dss_per = nv_dss_per + 1.
                IF sic_bran.uwm100.gap_p = nu_prem THEN LEAVE loop_prm.
            END.


            /*--
            IF nv_dss_per > 30 THEN DO: LEAVE loop_prm.
            END.
            ELSE IF sic_bran.uwm100.gap_p = nu_prem THEN LEAVE loop_prm.
            ELSE IF nv_baseprm1 <> 0 THEN DO:
                nv_baseprm1 = nv_baseprm1 - 1.
            END.
            ELSE IF nv_baseprm1 = 0 THEN LEAVE loop_prm.
            --*/
           
            RUN PDChkPrm132.

            RUN PDCreate132.
        
            RUN PDAutoSave.
            
        END.
        ELSE DO:
            nv_baseprm1 = nv_baseprm1 + 1.
            IF nv_base_max = nv_baseprm1 THEN LEAVE loop_prm.
            ELSE IF sic_bran.uwm100.gap_p = nu_prem THEN LEAVE loop_prm.
            /*ELSE DO:*/
            RUN PDChkPrm132.

            RUN PDCreate132.
        
            RUN PDAutoSave.
            /*END.*/
        END.

    END.
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkPrm132 C-Win 
PROCEDURE PDChkPrm132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A65-0203      
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

ASSIGN
    nv_sclass = sic_bran.uwm120.CLASS
    nv_effdat = sic_bran.uwm100.comdat
    nv_seat41 = sic_bran.uwm301.seat
    nv_covcod = sic_bran.uwm301.covcod
    nv_engine = sic_bran.uwm301.engine
    nv_tons   = sic_bran.uwm301.tons
    nv_si00   = sic_bran.uwm130.uom6_v
    nv_si01   = sic_bran.uwm130.uom7_v.

ASSIGN
    nv_modcod = sic_bran.uwm301.modcod
    nv_vehreg = sic_bran.uwm301.vehgrp
    nv_vehuse = sic_bran.uwm301.vehuse
    nv_drivnam = 0.

ASSIGN
    nv_bip00 = sic_bran.uwm130.uom1_v
    nv_bia00 = sic_bran.uwm130.uom2_v
    nv_pd00  = sic_bran.uwm130.uom5_v.

/*---Begin by Chaiyong W. 18/07/2017*/
nv_drivno = INTE(wexcel.driname) no-error.
nv_age1   = INTE(wexcel.driage1) no-error.
nv_age2   = INTE(wexcel.driage2) no-error.  
/*End by Chaiyong W. 18/07/2017*/

IF nv_drivno = 0 THEN DO:
    ASSIGN
        nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivno    = 0
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = STRING(nv_drivno)
        SUBSTRING(nv_drivvar,1,30)   = nv_drivvar1
        SUBSTRING(nv_drivvar,31,30)  = nv_drivvar2.

    nv_chkmail = TRIM(sic_bran.uwm100.policy) +
                 STRING(sic_bran.uwm100.rencnt,"99" ) +
                 STRING(sic_bran.uwm100.endcnt,"999") +
                 STRING(sic_bran.uwm130.riskno,"999") +
                 STRING(sic_bran.uwm130.itemno,"999").

    FOR EACH brstat.mailtxt_fil WHERE
             brstat.mailtxt_fil.policy = nv_chkmail:
        DELETE brstat.mailtxt_fil.
    END.
END.
ELSE IF nv_drivno <= 2 THEN DO:
    ASSIGN
        nv_drivvar     = " "
        nv_drivvar1    = "     Driver name person = "
        nv_drivvar2    = STRING(nv_drivno)
        SUBSTRING(nv_drivvar,1,30)  = nv_drivvar1
        SUBSTRING(nv_drivvar,31,30) = nv_drivvar2.

    RUN PDCreateMailtxt.
    RUN PDChkUsdCod.
END.
FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy) AND
                        wexcamp.campaign  = TRIM(wexcel.campaign) AND 
                        wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
IF AVAIL wexcamp THEN DO:
    IF wexcamp.polmaster <> "" AND wexcamp.polmaster <> "CAMP_NTL" THEN RUN PDCreate132_camp.
    ELSE DO:
        RUN proc_calpremt.
        RUN PDCreate132_Cal.
    END.
END.
ELSE DO:
    /* campaign = "" */
    FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy) AND
                            wexcamp.campaign  = "Non-Camp" AND 
                            wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
        RUN proc_calpremt.
        RUN PDCreate132_Cal.
    END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkPrm132New C-Win 
PROCEDURE PDChkPrm132New :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

ASSIGN
    nv_sclass = sic_bran.uwm120.CLASS
    nv_effdat = sic_bran.uwm100.comdat
    nv_seat41 = sic_bran.uwm301.seat
    nv_covcod = sic_bran.uwm301.covcod
    nv_engine = sic_bran.uwm301.engine
    nv_tons   = sic_bran.uwm301.tons
    nv_si00   = sic_bran.uwm130.uom6_v
    nv_si01   = sic_bran.uwm130.uom7_v.

ASSIGN
    nv_modcod = sic_bran.uwm301.modcod
    nv_vehreg = sic_bran.uwm301.vehgrp
    nv_vehuse = sic_bran.uwm301.vehuse
    nv_drivnam = 0.

ASSIGN
    nv_bip00 = sic_bran.uwm130.uom1_v
    nv_bia00 = sic_bran.uwm130.uom2_v
    nv_pd00  = sic_bran.uwm130.uom5_v.

nv_drivno = INTE(wexcel.driname) NO-ERROR.
nv_age1 = wexcel.driage1.
nv_age2 = wexcel.driage2.
nv_age3 = wexcel.driage3.
nv_age4 = wexcel.driage4.
nv_age5 = wexcel.driage5.

IF nv_drivno = 0 THEN DO:
    ASSIGN
        nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivno    = 0
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = STRING(nv_drivno)
        SUBSTRING(nv_drivvar,1,30)   = nv_drivvar1
        SUBSTRING(nv_drivvar,31,30)  = nv_drivvar2.

    nv_chkmail = TRIM(sic_bran.uwm100.policy) +
                 STRING(sic_bran.uwm100.rencnt,"99" ) +
                 STRING(sic_bran.uwm100.endcnt,"999") +
                 STRING(sic_bran.uwm130.riskno,"999") +
                 STRING(sic_bran.uwm130.itemno,"999").

    FOR EACH brstat.mailtxt_fil WHERE
             brstat.mailtxt_fil.policy = nv_chkmail:
        DELETE brstat.mailtxt_fil.
    END.
END.
ELSE DO:
    IF INDEX(nv_sclass,"E11") <> 0 THEN DO:
        IF nv_drivno >= 1 AND nv_drivno <= 5 THEN DO:
            ASSIGN
                nv_drivvar     = " "
                nv_drivvar1    = "     Driver name person = "
                nv_drivvar2    = STRING(nv_drivno)
                SUBSTRING(nv_drivvar,1,30)  = nv_drivvar1
                SUBSTRING(nv_drivvar,31,30) = nv_drivvar2.
        
            RUN PDCreateMailtxtNew.
            RUN PDChkUsdCodNew.
        END.
    END.
    ELSE DO:
        IF nv_drivno >= 1 AND nv_drivno <= 2 THEN DO:
            ASSIGN
                nv_drivvar     = " "
                nv_drivvar1    = "     Driver name person = "
                nv_drivvar2    = STRING(nv_drivno)
                SUBSTRING(nv_drivvar,1,30)  = nv_drivvar1
                SUBSTRING(nv_drivvar,31,30) = nv_drivvar2.
        
            RUN PDCreateMailtxtNew.
            RUN PDChkUsdCodNew.
        END.
    END.
END.

FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy)   AND
                        wexcamp.campaign  = TRIM(wexcel.campaign) AND 
                        wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
IF AVAIL wexcamp THEN DO:
    IF wexcamp.polmaster <> "" AND wexcamp.polmaster <> "CAMP_NTL" THEN DO: 
        RUN PDCreate132_camp.
    END.
    ELSE DO:
        RUN proc_calpremtNew.
        RUN PDCreate132_CalNew.
    END.
END.
ELSE DO:
    /* campaign = "" */
    FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy) AND
                            wexcamp.campaign  = "Non-Camp" AND 
                            wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
        RUN proc_calpremtNew.
        RUN PDCreate132_CalNew.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkRedbook C-Win 
PROCEDURE PDChkRedbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wexcel.modcod <> "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
               stat.maktab_fil.sclass = wexcel.sclass AND
               stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            wexcel.modcod = stat.maktab_fil.modcod
            wexcel.seat   = STRING(stat.maktab_fil.seats)
            wexcel.vehgrp = stat.maktab_fil.prmpac.
    END.
    ELSE DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE
                   stat.maktab_fil.sclass = "****" AND
                   stat.maktab_fil.modcod = wexcel.modcod NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            ASSIGN
                wexcel.modcod = stat.maktab_fil.modcod
                wexcel.seat   = STRING(stat.maktab_fil.seats)
                wexcel.vehgrp = stat.maktab_fil.prmpac.
        END.
        ELSE wexcel.modcod = "".
    END.
END.

nv_moddes = TRIM(SUBSTR(wexcel.moddes,1,INDEX(wexcel.moddes," "))).

IF wexcel.modcod = "" THEN DO:  /*maktab02*/
    FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
               stat.maktab_fil.sclass BEGINS wexcel.sclass 
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        wexcel.sclass = stat.maktab_fil.sclass.
        FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                   stat.maktab_fil.sclass = wexcel.sclass AND
                   stat.maktab_fil.makdes BEGINS wexcel.makdes 
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            nv_makdes = stat.maktab_fil.makdes.
            FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                       stat.maktab_fil.sclass = wexcel.sclass AND
                       stat.maktab_fil.makdes = nv_makdes     AND
                       stat.maktab_fil.moddes BEGINS nv_moddes 
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.maktab_fil THEN DO:
                nv_moddes = stat.maktab_fil.moddes.
                FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                           stat.maktab_fil.sclass = wexcel.sclass AND
                           stat.maktab_fil.makdes = nv_makdes     AND
                           stat.maktab_fil.moddes = nv_moddes     AND
                           stat.maktab_fil.makyea = INTE(wexcel.yrmanu) 
                NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.maktab_fil THEN DO:
                    ASSIGN
                        wexcel.modcod = stat.maktab_fil.modcod
                        wexcel.seat   = STRING(stat.maktab_fil.seats)
                        wexcel.vehgrp = stat.maktab_fil.prmpac.
                END.
            END.
        END.
    END.
END.

IF wexcel.modcod = "" THEN DO:  /*maktab04*/
    FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
               stat.maktab_fil.makdes BEGINS wexcel.makdes 
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        nv_makdes = stat.maktab_fil.makdes.
        FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
                   stat.maktab_fil.makdes = nv_makdes  AND
                   stat.maktab_fil.moddes BEGINS nv_moddes 
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            nv_moddes = stat.maktab_fil.moddes.
            FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
                       stat.maktab_fil.makdes = nv_makdes AND
                       stat.maktab_fil.moddes = nv_moddes AND
                       stat.maktab_fil.makyea = INTE(wexcel.yrmanu) 
            NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.maktab_fil THEN DO:
                ASSIGN
                    wexcel.modcod = stat.maktab_fil.modcod
                    wexcel.seat   = STRING(stat.maktab_fil.seats)
                    wexcel.vehgrp = stat.maktab_fil.prmpac.
            END.
        END.
    END.
END.

IF wexcel.modcod = "" THEN DO:
    wexcel.modcod = TRIM(SUBSTR(wexcel.makdes,1,4)) + TRIM(SUBSTR(wexcel.yrmanu,3,2)).

    FIND FIRST stat.maktab_fil WHERE INDEX(stat.maktab_fil.modcod,wexcel.modcod) <> 0
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            wexcel.modcod = stat.maktab_fil.modcod
            wexcel.seat   = STRING(stat.maktab_fil.seats)
            wexcel.vehgrp = stat.maktab_fil.prmpac.
    END.
    ELSE wexcel.modcod = "".
END.

IF wexcel.seat = "" THEN DO:
    IF wexcel.sclass = "110" OR wexcel.sclass = "E11" OR wexcel.sclass = "E12" THEN DO: 
        ASSIGN
            wexcel.seat   = "7"
            wexcel.vehuse = "1".
    END.
    ELSE IF wexcel.sclass = "210" THEN DO:
        ASSIGN
            wexcel.seat   = "12"
            wexcel.vehuse = "1".
    END.
    ELSE IF wexcel.sclass = "320" THEN DO:
        ASSIGN
            wexcel.seat   = "3"
            wexcel.vehuse = "2".
    END.
END.

IF wexcel.vehuse = "" THEN DO:
    wexcel.vehuse = SUBSTR(wexcel.sclass,2,1).
END.
/*---Begin by Chaiyong W. A59-0614 27/04/2017*/
IF TRIM(wexcel.sclass) = "320" THEN DO:
    IF wexcel.body = "บรรทุก" OR wexcel.body = "รถบรรทุก" OR  wexcel.body = "Truck" THEN wexcel.vehuse = "2".
    ELSE IF wexcel.body = "กระบะ" OR  wexcel.body = "Pickup" OR  wexcel.body = "minitruck" THEN wexcel.vehuse = "1".
    ELSE wexcel.vehuse = "1".
END.
/*End by Chaiyong W. A59-0614 27/04/2017-----*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkUsdCod C-Win 
PROCEDURE PDChkUsdCod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_drivcod = "A" + STRING(nv_drivno,"9").
IF nv_drivno = 1 THEN DO:
    IF nv_age1 LE 50 THEN DO:
        IF nv_age1 LE 35 THEN DO:
            IF nv_age1 LE 24 THEN DO:
                nv_drivcod = nv_drivcod + "24".
            END.
            ELSE nv_drivcod = nv_drivcod + "35".
        END.
        ELSE nv_drivcod = nv_drivcod + "50".
    END.
    ELSE nv_drivcod = nv_drivcod + "99".
END.

IF nv_drivno = 2 THEN DO:
    IF nv_age1 LE 50 THEN DO:
        IF nv_age1 LE 35 THEN DO:
            IF nv_age1 LE 24 THEN DO:
                nv_drivcod1 = nv_drivcod + "24".
            END.
            ELSE nv_drivcod1 = nv_drivcod + "35".
        END.
        ELSE nv_drivcod1 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod1 = nv_drivcod + "99".

    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff = "X" AND
               sicsyac.xmm106.bencod = nv_drivcod1 AND
               sicsyac.xmm106.CLASS  = nv_sclass   AND
               sicsyac.xmm106.covcod = nv_covcod   AND
               sicsyac.xmm106.key_b  GE nv_key_b   AND
               sicsyac.xmm106.effdat LE nv_effdat  NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN DO:
        nv_age1rate = xmm106.appinc.
    END.

    IF nv_age2 LE 50 THEN DO:
        IF nv_age2 LE 35 THEN DO:
            IF nv_age2 LE 24 THEN DO:
                nv_drivcod2 = nv_drivcod + "24".
            END.
            ELSE nv_drivcod2 = nv_drivcod + "35".
        END.
        ELSE nv_drivcod2 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod2 = nv_drivcod + "99".

    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff =  "X"         AND
               sicsyac.xmm106.bencod =  nv_drivcod2 AND
               sicsyac.xmm106.CLASS  =  nv_sclass   AND
               sicsyac.xmm106.covcod =  nv_covcod   AND
               sicsyac.xmm106.key_b  GE nv_key_b    AND
               sicsyac.xmm106.effdat LE nv_effdat   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN DO:
        nv_age2rate = xmm106.appinc.
    END.

    IF nv_age2rate > nv_age1rate THEN nv_drivcod  = nv_drivcod2.
    ELSE nv_drivcod  = nv_drivcod1.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkUsdCodNew C-Win 
PROCEDURE PDChkUsdCodNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INDEX(nv_sclass,"E11") <> 0 THEN DO:
    nv_drivcod = "AL0" + STRING(nv_levcod,"9").
END.
ELSE DO:
    nv_drivcod = "A" + STRING(nv_drivno,"9").
    IF nv_drivno = 1 THEN DO:
        IF nv_age1 LE 50 THEN DO:
            IF nv_age1 LE 35 THEN DO:
                IF nv_age1 LE 24 THEN DO:
                    nv_drivcod = nv_drivcod + "24".
                END.
                ELSE nv_drivcod = nv_drivcod + "35".
            END.
            ELSE nv_drivcod = nv_drivcod + "50".
        END.
        ELSE nv_drivcod = nv_drivcod + "99".
    END.
    
    IF nv_drivno = 2 THEN DO:
        IF nv_age1 LE 50 THEN DO:
            IF nv_age1 LE 35 THEN DO:
                IF nv_age1 LE 24 THEN DO:
                    nv_drivcod1 = nv_drivcod + "24".
                END.
                ELSE nv_drivcod1 = nv_drivcod + "35".
            END.
            ELSE nv_drivcod1 = nv_drivcod + "50".
        END.
        ELSE nv_drivcod1 = nv_drivcod + "99".
    
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                   sicsyac.xmm106.tariff = "X" AND
                   sicsyac.xmm106.bencod = nv_drivcod1 AND
                   sicsyac.xmm106.CLASS  = nv_sclass   AND
                   sicsyac.xmm106.covcod = nv_covcod   AND
                   sicsyac.xmm106.key_b  GE nv_key_b   AND
                   sicsyac.xmm106.effdat LE nv_effdat  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN DO:
            nv_age1rate = xmm106.appinc.
        END.
    
        IF nv_age2 LE 50 THEN DO:
            IF nv_age2 LE 35 THEN DO:
                IF nv_age2 LE 24 THEN DO:
                    nv_drivcod2 = nv_drivcod + "24".
                END.
                ELSE nv_drivcod2 = nv_drivcod + "35".
            END.
            ELSE nv_drivcod2 = nv_drivcod + "50".
        END.
        ELSE nv_drivcod2 = nv_drivcod + "99".
    
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                   sicsyac.xmm106.tariff =  "X"         AND
                   sicsyac.xmm106.bencod =  nv_drivcod2 AND
                   sicsyac.xmm106.CLASS  =  nv_sclass   AND
                   sicsyac.xmm106.covcod =  nv_covcod   AND
                   sicsyac.xmm106.key_b  GE nv_key_b    AND
                   sicsyac.xmm106.effdat LE nv_effdat   NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm106 THEN DO:
            nv_age2rate = xmm106.appinc.
        END.
    
        IF nv_age2rate > nv_age1rate THEN nv_drivcod  = nv_drivcod2.
        ELSE nv_drivcod  = nv_drivcod1.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClearData C-Win 
PROCEDURE PDClearData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN   nv_modcod   = " "  nv_seats    = 0    nv_covcod     = " "  nv_dss_per  = 0
         nv_moddes   = " "  nv_vehuse   = " "  /*nv_garage     = " "*/  nv_prem1    = 0
         /*nv_yrmanu   = 0*/   /*nv_itmdes   = " "*/  nv_vehreg     = " "  nv_prvprm   = 0 
         nv_body     = " "  /*nv_covdes   = " "*/  /*nv_cha_no     = " "*/  nv_stf_per  = 0
         nv_engine   = 0       /*nv_eng_no     = " "*/  nv_pdprm    = 0
         nv_tons     = 0    nv_drivno   = 0    nv_baseprm    = 0    nv_gapprm   = 0
         nv_41       = 0    nv_addod    = 0    nv_ncb        = 0    nv_dsspcvar = " "
         nv_seat41   = 0    nv_dedpd    = 0    nv_dss_per    = 0    nv_addprm   = 0
         nv_42       = 0    nv_flet_per = 0    nv_dsspc      = 0    nv_dsspc    = 0
         nv_43       = 0    nv_flet     = 0    nv_stf_per    = 0    nv_ncb      = 0
         nv_dedod    = 0    nv_ncbyrs   = 0    nv_stf_amt    = 0    nv_clmvar   = " "
         nv_cl_per   = 0    nv_usevar   = " "  nv_engcod     = " "  nv_ncbvar   = " "
         nv_lodclm   = 0    nv_grpcod   = " "  nv_engprm     = 0    nv_ncbper   = 0
         nv_compcod  = " "  nv_grprm    = 0    nv_engvar     = " "  nv_lodclm   = 0
         nv_compprm  = 0    nv_grpvar   = " "  nv_drivcod    = " "  nv_camprem  = 0
         nv_compvar  = " "  nv_yrcod    = " "  nv_drivprm    = 0    /*nv_bennam2  = " "*/
         nv_basecod  = " "  nv_yrprm    = 0    nv_drivvar    = " "  nv_cl_per   = 0 
         nv_baseprm  = 0    nv_yrvar    = " "  nv_bipcod     = " "  nv_fletvar  = " "
         nv_basevar  = " "  nv_sicod    = " "  nv_biaprm     = 0    /*nv_bennam1  = " "*/
         nv_usecod   = " "  nv_siprm    = 0    nv_biavar     = " "  nv_flet     = 0
         nv_useprm   = 0    nv_sivar    = " "  nv_pdacod     = " "  nv_stfvar   = " "
         nv_pdaprm   = 0    nv_42cod    = " "  nv_dedod1_cod = " "  nv_flet_per = 0
         nv_pdavar   = " "  nv_42       = 0    nv_dedod1_prm = 0    nv_stf_amt  = 0
         nv_41cod1   = " "  nv_42prm    = 0    nv_dedod1var  = " "  nv_dedod    = 3000
         nv_41cod2   = " "  nv_42var    = " "  nv_dedod2_cod = " "  nv_412var   = " "
         nv_41       = 0    nv_43cod    = " "  nv_dedod2_prm = 0    nv_aded1prm = 0
         nv_seat41   = 0    nv_43       = 0    nv_dedod2var  = " "  nv_ded2prm  = 0
         nv_411prm   = 0    nv_43prm    = 0    nv_dedpd_cod  = " "  nv_dedpdvar = " "
         nv_412prm   = 0    nv_43var    = " "  nv_dedpd_prm  = 0    nv_ded1prm  = 0
         nv_411var   = " "  
         nv_bipvar   = " "  nv_prem3    = 0    nv_baseprm    = 0 nv_prem = 0
         nv_baseprm1 = 0    nv_baseprm3 = 0    nv_basecod3   = ""

         nv_baseprm2 = 0 /*---add by Chaiyong W. A61-0015 15/02/2018*/
         .






END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate100 C-Win 
PROCEDURE PDCreate100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO TRANSACTION:
    /*---
    /*---Begin by Chaiyong W. A59-0614 30/04/2017*/
    RUN pd_clearrenewal.
    IF wexcel.prvpol <> "" THEN RUN proc_assignrenew_pol. 
    /*End by Chaiyong W. A59-0614 30/04/2017-----*/
    comment by Chaiyong W. A61-0016 22/03/2018*/
    IF wexcel.policy <> "" THEN DO:
        fi_display = "Create data uwm100 policy: " + wexcel.newpol.
        DISP fi_display WITH FRAME fr_main.
        
        CREATE sic_bran.uwm100.
        ASSIGN
            sic_bran.uwm100.policy  = wexcel.policy
            sic_bran.uwm100.cr_2    = ""
            sic_bran.uwm100.rencnt  = 0
            sic_bran.uwm100.endcnt  = 0
            sic_bran.uwm100.bchyr   = nv_batchyr 
            sic_bran.uwm100.bchno   = nv_batchno 
            sic_bran.uwm100.bchcnt  = nv_batcnt
            sic_bran.uwm100.renno   = ""
            sic_bran.uwm100.opnpol  = wexcel.brncod
            sic_bran.uwm100.poltyp  = "V70"
            sic_bran.uwm100.insref  = "" /**/
            sic_bran.uwm100.anam2   = wexcel.icno
            sic_bran.uwm100.ntitle  = wexcel.ntitle
            sic_bran.uwm100.name1   = wexcel.fname
            sic_bran.uwm100.name2   = ""
            sic_bran.uwm100.name3   = ""
            sic_bran.uwm100.addr1   = wexcel.addr1
            sic_bran.uwm100.addr2   = wexcel.addr2
            sic_bran.uwm100.addr3   = wexcel.addr3
            sic_bran.uwm100.addr4   = wexcel.addr4
            sic_bran.uwm100.postcd  = ""
            sic_bran.uwm100.undyr   = STRING(YEAR(TODAY),"9999")
            sic_bran.uwm100.branch  = wexcel.brnsty
            sic_bran.uwm100.dept    = "G"
            sic_bran.uwm100.usrid   = USERID(LDBNAME(1))
            sic_bran.uwm100.fstdat  = DATE(wexcel.comdat)  
            sic_bran.uwm100.comdat  = DATE(wexcel.comdat)
            sic_bran.uwm100.expdat  = DATE(wexcel.expdat)
            sic_bran.uwm100.accdat  = DATE(wexcel.comdat)
            sic_bran.uwm100.tranty  = "N"
            sic_bran.uwm100.langug  = "T"
            sic_bran.uwm100.acctim  = "00:00"
            sic_bran.uwm100.trty11  = "M"      
            sic_bran.uwm100.docno1  =  " " /*STRING(nv_docno,"9999999")*/     
            sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS")
            sic_bran.uwm100.entdat  = TODAY
            sic_bran.uwm100.curbil  = "BHT"
            sic_bran.uwm100.curate  = 1
            sic_bran.uwm100.instot  = 1
            sic_bran.uwm100.prog    = "WGWNLGEN"
            sic_bran.uwm100.cntry   = "TH"        /*Country where risk is situated*/
            sic_bran.uwm100.insddr  = YES         /*Print Insd. Name on DrN       */
            sic_bran.uwm100.no_sch  = 0           /*No. to print, Schedule        */
            sic_bran.uwm100.no_dr   = 1           /*No. to print, Dr/Cr Note      */
            sic_bran.uwm100.no_ri   = 0           /*No. to print, RI Appln        */
            sic_bran.uwm100.no_cer  = 0           /*No. to print, Certificate     */
            sic_bran.uwm100.li_sch  = YES         /*Print Later/Imm., Schedule    */
            sic_bran.uwm100.li_dr   = YES         /*Print Later/Imm., Dr/Cr Note  */
            sic_bran.uwm100.li_ri   = YES         /*Print Later/Imm., RI Appln,   */
            sic_bran.uwm100.li_cer  = YES         /*Print Later/Imm., Certificate */
            sic_bran.uwm100.apptax  = YES         /*Apply risk level tax (Y/N)    */
            sic_bran.uwm100.recip   = "N"         /*Reciprocal (Y/N/C)            */
            sic_bran.uwm100.short   = NO
            sic_bran.uwm100.acno1   = wexcel.broker
            sic_bran.uwm100.agent   = wexcel.agent
            sic_bran.uwm100.insddr  = NO
            sic_bran.uwm100.coins   = NO
            sic_bran.uwm100.billco  = ""
            sic_bran.uwm100.fptr01  = 0        sic_bran.uwm100.bptr01 = 0
            sic_bran.uwm100.fptr02  = 0        sic_bran.uwm100.bptr02 = 0
            sic_bran.uwm100.fptr03  = 0        sic_bran.uwm100.bptr03 = 0
            sic_bran.uwm100.fptr04  = 0        sic_bran.uwm100.bptr04 = 0
            sic_bran.uwm100.fptr05  = 0        sic_bran.uwm100.bptr05 = 0
            sic_bran.uwm100.fptr06  = 0        sic_bran.uwm100.bptr06 = 0  
            sic_bran.uwm100.styp20  = "NORM"
            sic_bran.uwm100.dir_ri  = YES
            sic_bran.uwm100.drn_p   = NO
            sic_bran.uwm100.sch_p   = NO
            sic_bran.uwm100.prvpol  = ""
            /*--
            sic_bran.uwm100.cedpol  = wexcel.policy comment by chaiyong W. A59-0614 21/03/2017*/
            sic_bran.uwm100.cedpol  = wexcel.cedpol  /*---add by Chaiyong W. A59-0614 21/03/2017*/
            sic_bran.uwm100.finint  = ""
            sic_bran.uwm100.bs_cd   = ""
            sic_bran.uwm100.polsta  = "IF"
            sic_bran.uwm100.gstrat  = 7
            sic_bran.uwm100.trndat = TODAY
/*             sic_bran.uwm100.cr_1   = wexcel.campaign /*---add by Chaiyong W. A59-0614 21/03/2017*/ */
            sic_bran.uwm100.cr_1       = IF wexcel.product = "" THEN wexcel.campaign ELSE wexcel.product  /*Add by Kridtiya i. A65-0125*/
            sic_bran.uwm100.firstName  = trim(wexcel.firstName)           /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.lastName   = trim(wexcel.lastName)            /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.postcd     = trim(wexcel.postcd)              /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.icno       = trim(wexcel.icno)                /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.codeocc    = trim(wexcel.codeocc)             /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.codeaddr1  = trim(wexcel.codeaddr1)           /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.codeaddr2  = trim(wexcel.codeaddr2)           /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.codeaddr3  = trim(wexcel.codeaddr3)           /*Add by Kridtiya i. A63-0472*/
            /*sic_bran.uwm100.br_insured = "00000" */                   /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.campaign   = trim(wexcel.campaign_ov)   /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.dealer     = trim(wexcel.financecd) .         /*Add by Kridtiya i. A63-0472*/ 
            
        IF sic_bran.uwm100.postcd = "" THEN sic_bran.uwm100.postcd = trim(wexcel.postcod). /*---add by Chaiyong W. A59-0614 21/03/2017*/
        
        
        /*---begin by Chaiyong W. A59-0614 15/12/2016*/
        /*---
        IF TRIM(sic_bran.uwm100.ntitle) <> "" THEN DO:
            IF SUBSTR(TRIM(sic_bran.uwm100.ntitle),1,1) = "บ" OR 
               SUBSTR(TRIM(sic_bran.uwm100.ntitle),1,1) = "ห" THEN DO:
            END.
            ELSE sic_bran.uwm100.ntitle = "คุณ".
        END. ---*/
        IF wexcel.paycod <> "" THEN DO:
            IF  wexcel.paycod = "CA"  or 
                wexcel.paycod = "CC"  or 
                wexcel.paycod = "BP"  or 
                wexcel.paycod = "CV"  or 
                wexcel.paycod = "CL"  THEN DO:
                IF sic_bran.uwm100.opnpol <> "" THEN sic_bran.uwm100.opnpol = TRIM(sic_bran.uwm100.opnpol) + "/" .
                sic_bran.uwm100.opnpol = sic_bran.uwm100.opnpol + wexcel.paycod .
            END.


        END.
        ASSIGN
            nv_flet_per   = 0
            nv_ncbper     = 0
            nv_dss_per    = 0
            nv_stf_per    = 0
            nv_cl_per     = 0.
        IF np_prepol <> "" THEN DO:
            /*--
            IF index(sic_bran.uwm100.name1,np_name1) <> 0  THEN DO:*/
                ASSIGN  
                    sic_bran.uwm100.prvpol =  np_prepol
                    sic_bran.uwm100.rencnt =  np_rencnt     /*--
                    sic_bran.uwm100.insref =  np_insref   
                    sic_bran.uwm100.ntitle =  np_title    
                    sic_bran.uwm100.name1  =  np_name1    
                    sic_bran.uwm100.name2  =  np_name2    
                    sic_bran.uwm100.name3  =  np_name3    
                    sic_bran.uwm100.addr1  =  np_addr1    
                    sic_bran.uwm100.addr2  =  np_addr2    
                    sic_bran.uwm100.addr3  =  np_addr3    
                    sic_bran.uwm100.addr4  =  np_addr4    comment by Chaiyong W. A60-0016 18/01/2018*/
                    sic_bran.uwm100.fstdat =  DATE(np_firstdat).
               /*--
                nv_flet_per   = DECIMAL(Trim(np_flet_per)) NO-ERROR .
                nv_ncbper     = DECIMAL(Trim(np_ncbper  )) NO-ERROR .
                nv_dss_per    = DECIMAL(Trim(np_dss_per )) NO-ERROR .
                ASSIGN
                    nv_stf_per    = np_stf_per 
                    nv_cl_per     = np_cl_per  .
                    
                    ---*/
                    /*        
            END.  */
/*---
            ELSE DO:
                sic_bran.uwm100.rencnt =  np_rencnt.
                nv_flet_per   = DECIMAL(Trim(np_flet_per)) NO-ERROR .
                nv_ncbper     = DECIMAL(Trim(np_ncbper  )) NO-ERROR .
                nv_dss_per    = DECIMAL(Trim(np_dss_per )) NO-ERROR .
                ASSIGN
                    nv_stf_per    = np_stf_per 
                    nv_cl_per     = np_cl_per  .

            END.---*/
        END.
        /*End by Chaiyong W. A59-0614 15/12/2016-----*/

        IF  (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
             MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
             YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
            (DAY(sic_bran.uwm100.comdat)      =  29                             AND
             MONTH(sic_bran.uwm100.comdat)    =  02                             AND
             DAY(sic_bran.uwm100.expdat)      =  01                             AND
             MONTH(sic_bran.uwm100.expdat)    =  03                             AND
             YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN nv_polday = 365.
        ELSE nv_polday = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat ) + 1.

        /*-- Create Insure Code --*/
        IF sic_bran.uwm100.insref = "" THEN DO:
            RUN PDCreateIns.
            RUN PDCreateIns2.  /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.insref = nv_insref.
            nv_insref = "".
        END.
        s_recid1 = RECID(sic_bran.uwm100).
        
        RUN PDCreate100d.
        RUN PDCreate102d.
        FIND sic_bran.uwm100 WHERE RECID(uwm100) = s_recid1 NO-ERROR NO-WAIT.
        IF AVAIL sic_Bran.uwm100 THEN DO:
            RUN PDCreate120.
        END.
        RUN PDCreate130.
        RUN PDCreate301.
        RUN PDChkPrm132New.
        /*comment by : A65-0203..
        RUN PDCreate132.
        RUN pd_add132. /*---add by Chaiyong W. A60-0016 15/01/2018*/
        ...end A65-0203..*/
        RUN PDAutoSave.
        RUN PDClearData.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate100d C-Win 
PROCEDURE PDCreate100d :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
DEF VAR nv_text5     AS CHAR.
DEF VAR nv_txt       AS CHAR.

fi_display = "Create data uwd100 policy: " + wexcel.newpol.
DISP fi_display WITH FRAME fr_main.
             
n_rencnt = 0.
n_endcnt = 0.
n_rencnt = np_rencnt .  /*---add by Chaiyong W. A59-0614 30/04/2017*/

FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt   = ""
    nv_txt1  = ""
    nv_txt2  = ""
    nv_txt3  = ""
    nv_txt4  = "" 
    nv_txt5  = ""
    nv_txt6  = ""
    nv_txt7  = ""
    nv_txt8  = ""
    nv_txt9  = ""
    nv_txt10 = ""
    nv_txt11 = ""
    nv_txt12 = "".

IF nv_txt = "" AND wexcel.f7 <> "" THEN nv_txt =  wexcel.f7. 

ASSIGN  nv_txt1  = IF index(nv_txt,":")  <> 0 THEN SUBSTR(nv_txt,1,index(nv_txt,":") - 1) ELSE nv_txt 
        nv_txt   = IF index(nv_txt,":") <> 0 THEN SUBSTR(nv_txt,R-INDEX(nv_txt,":") + 1) ELSE "" .

IF nv_txt <> "" THEN DO:
    ASSIGN 
    nv_txt12 = IF index(nv_txt,"12.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"12."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt12))

    nv_txt11 = IF index(nv_txt,"11.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"11."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt11))
    
    nv_txt10 = IF index(nv_txt,"10.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"10."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt10)) 

    nv_txt9 = IF index(nv_txt,"9.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"9."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt9)) 
        
    nv_txt8 = IF index(nv_txt,"8.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"8."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt8))    
        
    nv_txt7 = IF index(nv_txt,"7.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"7."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt7))     
       
    nv_txt6 = IF index(nv_txt,"6.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"6."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt6))   
          
    nv_txt5 = IF index(nv_txt,"5.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"5."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt5))   
            
    nv_txt4 = IF index(nv_txt,"4.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"4."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt4))   
            
    nv_txt3 = IF index(nv_txt,"3.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"3."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt3))       
        
    nv_txt2 = IF index(nv_txt,"2.") <> 0 THEN SUBSTR(nv_txt,index(nv_txt,"2."),R-INDEX(nv_txt,","))   ELSE "" 
    nv_txt = SUBSTR(nv_txt,1,LENGTH(nv_txt) - LENGTH(nv_txt2)) .
END.

DO WHILE nv_line1 <= 13:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = trim(nv_txt1).
    IF nv_line1 = 2  THEN wuppertxt.txt = trim(nv_txt).
    IF nv_line1 = 3  THEN wuppertxt.txt = trim(nv_txt2). 
    IF nv_line1 = 4  THEN wuppertxt.txt = trim(nv_txt3). 
    IF nv_line1 = 5  THEN wuppertxt.txt = trim(nv_txt4). 
    IF nv_line1 = 6  THEN wuppertxt.txt = trim(nv_txt5). 
    IF nv_line1 = 7  THEN wuppertxt.txt = trim(nv_txt6). 
    IF nv_line1 = 8  THEN wuppertxt.txt = trim(nv_txt7). 
    IF nv_line1 = 9  THEN wuppertxt.txt = trim(nv_txt8). 
    IF nv_line1 = 10 THEN wuppertxt.txt = trim(nv_txt9). 
    IF nv_line1 = 11 THEN wuppertxt.txt = trim(nv_txt10).
    IF nv_line1 = 12 THEN wuppertxt.txt = trim(nv_txt11).
    IF nv_line1 = 13 THEN wuppertxt.txt = trim(nv_txt12).
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wexcel.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt        AND
     sic_bran.uwm100.endcnt  = n_endcnt        AND
     sic_bran.uwm100.bchyr   = nv_batchyr      AND
     sic_bran.uwm100.bchno   = nv_batchno      AND
     sic_bran.uwm100.bchcnt  = nv_batcnt       NO-ERROR NO-WAIT.
IF AVAIL sic_bran.uwm100 THEN DO:

    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd100.
        ASSIGN
            sic_bran.uwd100.bptr    = nv_bptr
            sic_bran.uwd100.fptr    = 0
            sic_bran.uwd100.policy  = wexcel.policy
            sic_bran.uwd100.rencnt  = n_rencnt
            sic_bran.uwd100.endcnt  = n_endcnt
            sic_bran.uwd100.ltext   = wuppertxt.txt.

        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
            wf_uwd100.fptr = RECID(uwd100).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(uwd100).
        nv_bptr = RECID(uwd100).
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate100New C-Win 
PROCEDURE PDCreate100New :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO TRANSACTION:
    IF wexcel.policy <> "" THEN DO:
        fi_display = "Create data uwm100 policy: " + wexcel.newpol.
        DISP fi_display WITH FRAME fr_main.

        CREATE sic_bran.uwm100.
        ASSIGN
            sic_bran.uwm100.policy  = wexcel.policy
            sic_bran.uwm100.cr_2    = ""
            sic_bran.uwm100.rencnt  = 0
            sic_bran.uwm100.endcnt  = 0
            sic_bran.uwm100.bchyr   = nv_batchyr 
            sic_bran.uwm100.bchno   = nv_batchno 
            sic_bran.uwm100.bchcnt  = nv_batcnt
            sic_bran.uwm100.renno   = ""
            sic_bran.uwm100.opnpol  = wexcel.brncod
            sic_bran.uwm100.poltyp  = "V70"
            sic_bran.uwm100.insref  = "" 
            sic_bran.uwm100.anam2   = wexcel.icno
            sic_bran.uwm100.ntitle  = wexcel.ntitle
            sic_bran.uwm100.name1   = wexcel.fname
            sic_bran.uwm100.name2   = ""
            sic_bran.uwm100.name3   = ""
            sic_bran.uwm100.addr1   = wexcel.addr1
            sic_bran.uwm100.addr2   = wexcel.addr2
            sic_bran.uwm100.addr3   = wexcel.addr3
            sic_bran.uwm100.addr4   = wexcel.addr4
            sic_bran.uwm100.postcd  = ""
            sic_bran.uwm100.undyr   = STRING(YEAR(TODAY),"9999")
            sic_bran.uwm100.branch  = wexcel.brnsty
            sic_bran.uwm100.dept    = "G"
            sic_bran.uwm100.usrid   = USERID(LDBNAME(1))
            sic_bran.uwm100.fstdat  = DATE(wexcel.comdat)  
            sic_bran.uwm100.comdat  = DATE(wexcel.comdat)
            sic_bran.uwm100.expdat  = DATE(wexcel.expdat)
            sic_bran.uwm100.accdat  = DATE(wexcel.comdat)
            sic_bran.uwm100.tranty  = "N"
            sic_bran.uwm100.langug  = "T"
            sic_bran.uwm100.acctim  = "00:00"
            sic_bran.uwm100.trty11  = "M"      
            sic_bran.uwm100.docno1  =  " "      
            sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS")
            sic_bran.uwm100.entdat  = TODAY
            sic_bran.uwm100.curbil  = "BHT"
            sic_bran.uwm100.curate  = 1
            sic_bran.uwm100.instot  = 1
            sic_bran.uwm100.prog    = "WGWNLGEN"
            sic_bran.uwm100.cntry   = "TH"        /*Country where risk is situated*/
            sic_bran.uwm100.insddr  = YES         /*Print Insd. Name on DrN       */
            sic_bran.uwm100.no_sch  = 0           /*No. to print, Schedule        */
            sic_bran.uwm100.no_dr   = 1           /*No. to print, Dr/Cr Note      */
            sic_bran.uwm100.no_ri   = 0           /*No. to print, RI Appln        */
            sic_bran.uwm100.no_cer  = 0           /*No. to print, Certificate     */
            sic_bran.uwm100.li_sch  = YES         /*Print Later/Imm., Schedule    */
            sic_bran.uwm100.li_dr   = YES         /*Print Later/Imm., Dr/Cr Note  */
            sic_bran.uwm100.li_ri   = YES         /*Print Later/Imm., RI Appln,   */
            sic_bran.uwm100.li_cer  = YES         /*Print Later/Imm., Certificate */
            sic_bran.uwm100.apptax  = YES         /*Apply risk level tax (Y/N)    */
            sic_bran.uwm100.recip   = "N"         /*Reciprocal (Y/N/C)            */
            sic_bran.uwm100.short   = NO
            sic_bran.uwm100.acno1   = wexcel.broker
            sic_bran.uwm100.agent   = wexcel.agent
            sic_bran.uwm100.insddr  = NO
            sic_bran.uwm100.coins   = NO
            sic_bran.uwm100.billco  = ""
            sic_bran.uwm100.fptr01  = 0        sic_bran.uwm100.bptr01 = 0
            sic_bran.uwm100.fptr02  = 0        sic_bran.uwm100.bptr02 = 0
            sic_bran.uwm100.fptr03  = 0        sic_bran.uwm100.bptr03 = 0
            sic_bran.uwm100.fptr04  = 0        sic_bran.uwm100.bptr04 = 0
            sic_bran.uwm100.fptr05  = 0        sic_bran.uwm100.bptr05 = 0
            sic_bran.uwm100.fptr06  = 0        sic_bran.uwm100.bptr06 = 0  
            sic_bran.uwm100.styp20  = "NORM"
            sic_bran.uwm100.dir_ri  = YES
            sic_bran.uwm100.drn_p   = NO
            sic_bran.uwm100.sch_p   = NO
            sic_bran.uwm100.prvpol  = ""
            sic_bran.uwm100.cedpol  = wexcel.cedpol  
            sic_bran.uwm100.finint  = ""
            sic_bran.uwm100.bs_cd   = ""
            sic_bran.uwm100.polsta  = "IF"
            sic_bran.uwm100.gstrat  = 7
            sic_bran.uwm100.trndat = TODAY
            sic_bran.uwm100.cr_1       = IF wexcel.product = "" THEN wexcel.campaign ELSE wexcel.product  
            sic_bran.uwm100.firstName  = TRIM(wexcel.firstName)    
            sic_bran.uwm100.lastName   = TRIM(wexcel.lastName)     
            sic_bran.uwm100.postcd     = TRIM(wexcel.postcd)       
            sic_bran.uwm100.icno       = TRIM(wexcel.icno)         
            sic_bran.uwm100.codeocc    = TRIM(wexcel.codeocc)      
            sic_bran.uwm100.codeaddr1  = TRIM(wexcel.codeaddr1)    
            sic_bran.uwm100.codeaddr2  = TRIM(wexcel.codeaddr2)    
            sic_bran.uwm100.codeaddr3  = TRIM(wexcel.codeaddr3)                 
            sic_bran.uwm100.campaign   = TRIM(wexcel.campaign_ov)  
            sic_bran.uwm100.dealer     = TRIM(wexcel.financecd) .  
            
        IF sic_bran.uwm100.postcd = "" THEN sic_bran.uwm100.postcd = TRIM(wexcel.postcod). 

        IF wexcel.baddr1 + wexcel.baddr2 + 
           wexcel.baddr3 + wexcel.baddr4  <> ""  THEN DO:
            ASSIGN
                sic_bran.uwm100.delimet    = "POST"
                sic_bran.uwm100.dtitle     = wexcel.btitle
                sic_bran.uwm100.dfirstname = wexcel.bfname
                sic_bran.uwm100.dlastname  = wexcel.blname
                sic_bran.uwm100.daddr1     = wexcel.baddr1
                sic_bran.uwm100.daddr2     = wexcel.baddr2
                sic_bran.uwm100.daddr3     = wexcel.baddr3
                sic_bran.uwm100.daddr4     = wexcel.baddr4            
                sic_bran.uwm100.dpostcd    = wexcel.bpostcod.         

            IF sic_bran.uwm100.dtitle     = "" THEN sic_bran.uwm100.dtitle     = wexcel.ntitle.
            IF sic_bran.uwm100.dfirstname = "" THEN sic_bran.uwm100.dfirstname = TRIM(wexcel.fname).
            IF sic_bran.uwm100.dlastname  = "" THEN sic_bran.uwm100.dlastname  = TRIM(wexcel.lname).
        END.

        IF wexcel.paycod <> "" THEN DO:
            IF  wexcel.paycod = "CA"  or 
                wexcel.paycod = "CC"  or 
                wexcel.paycod = "BP"  or 
                wexcel.paycod = "CV"  or 
                wexcel.paycod = "CL"  THEN DO:
                IF sic_bran.uwm100.opnpol <> "" THEN sic_bran.uwm100.opnpol = TRIM(sic_bran.uwm100.opnpol) + "/" .
                sic_bran.uwm100.opnpol = sic_bran.uwm100.opnpol + wexcel.paycod .
            END.
        END.
        ASSIGN
            nv_flet_per   = 0
            nv_ncbper     = 0
            nv_dss_per    = 0
            nv_stf_per    = 0
            nv_cl_per     = 0.

        IF np_prepol <> "" THEN DO:
            ASSIGN  
                sic_bran.uwm100.prvpol =  np_prepol
                sic_bran.uwm100.rencnt =  np_rencnt     
                sic_bran.uwm100.fstdat =  DATE(np_firstdat).
        END.

        IF  (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
             MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
             YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
            (DAY(sic_bran.uwm100.comdat)      =  29                             AND
             MONTH(sic_bran.uwm100.comdat)    =  02                             AND
             DAY(sic_bran.uwm100.expdat)      =  01                             AND
             MONTH(sic_bran.uwm100.expdat)    =  03                             AND
             YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN nv_polday = 365.
        ELSE nv_polday = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat ) + 1.

        /*-- Create Insure Code --*/
        IF sic_bran.uwm100.insref = "" THEN DO:
            RUN PDCreateIns.
            RUN PDCreateIns2.  
            sic_bran.uwm100.insref = nv_insref.
            nv_insref = "".
        END.
        s_recid1 = RECID(sic_bran.uwm100).
        
        RUN PDCreate100d.
        RUN PDCreate102dNew.
        FIND sic_bran.uwm100 WHERE RECID(uwm100) = s_recid1 NO-ERROR NO-WAIT.
        IF AVAIL sic_Bran.uwm100 THEN DO:
            RUN PDCreate120.
        END.
        RUN PDCreate130.
        RUN PDCreate301.
        RUN PDChkPrm132New.
        RUN PDAutoSave.
        RUN PDClearData.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate102d C-Win 
PROCEDURE PDCreate102d :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF VAR nv_bptr      AS RECID.
DEF VAR nv_polmaster AS CHAR . /* A65-0203*/

fi_display = "Create data uwd102 policy: " + wexcel.newpol.
DISP fi_display WITH FRAME fr_main.

n_rencnt = 0.
n_endcnt = 0.
n_rencnt = np_rencnt .  /*---add by Chaiyong W. A59-0614 30/04/2017*/
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
/* A65-0203*/
FIND LAST wexcamp WHERE wexcamp.policy   = wexcel.policy /*AND
                        wexcamp.campaign = wexcel.campaign*/ NO-LOCK NO-ERROR .
IF AVAIL wexcamp THEN ASSIGN nv_polmaster = wexcamp.polmaster .
/* end : A65-0203*/
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    /*nv_txt1  = wexcel.campaign */ /* A65-0203*/
    nv_txt1  = wexcel.campaign + " " + "Polmaster : " + nv_polmaster   /* A65-0203*/
    nv_txt2  = "Date Recive: " + wexcel.trndat
    nv_txt3  = "Ref.No.: " + wexcel.cedpol    
    nv_txt4  = "Branch NTL: " + wexcel.brncod + " " + wexcel.brnnam   
    nv_txt5  = "ที่อยู่จัดส่งเอกสาร: "  
    nv_txt6  = wexcel.baddr1 + " " + wexcel.baddr2
    nv_txt7  = wexcel.baddr3 + " " + wexcel.baddr4 
    nv_txt8  = wexcel.bpostcod
    nv_txt9  = ""
    nv_txt10 = wexcel.isp  /*- add by Chaiyong W. A59-0614--*/
    nv_txt11 = ""
    nv_txt12 = "".

IF nv_txt11 = "" AND wexcel.f8 <> "" THEN nv_txt11 =  wexcel.f8. /*---add by Chaiyong W. A60-0016 15/01/2018*/

/*-----begin by Chaiyong W. A59-0614 15/12/2016*/
IF wexcel.paycod <> "" THEN DO:
    IF      wexcel.paycod = "CA" THEN nv_txt9 = "ประเภทการรับชำระ : เงินสด" .
    ELSE IF wexcel.paycod = "CC" THEN nv_txt9 = "ประเภทการรับชำระ : บัตรเครดิต" .
    ELSE IF wexcel.paycod = "BP" THEN nv_txt9 = "ประเภทการรับชำระ : Bill Payment" .
    ELSE IF wexcel.paycod = "CV" THEN nv_txt9 = "ประเภทการรับชำระ : หักจากยอดจัดสินเชื่อ" .
    ELSE IF wexcel.paycod = "CL" THEN nv_txt9 = "Installment (ผ่อนชำระ)" .


END.
/*End by Chaiyong W. A59-0614 15/12/2016-------*/


DO WHILE nv_line1 <= 12:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    IF nv_line1 = 8  THEN wuppertxt.txt = nv_txt8.
    IF nv_line1 = 9  THEN wuppertxt.txt = nv_txt9.
    IF nv_line1 = 10 THEN wuppertxt.txt = nv_txt10.
    IF nv_line1 = 11 THEN wuppertxt.txt = nv_txt11.
    IF nv_line1 = 12 THEN wuppertxt.txt = nv_txt12.
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wexcel.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt        AND
     sic_bran.uwm100.endcnt  = n_endcnt        AND
     sic_bran.uwm100.bchyr   = nv_batchyr      AND
     sic_bran.uwm100.bchno   = nv_batchno      AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.bptr    = nv_bptr
            sic_bran.uwd102.fptr    = 0
            sic_bran.uwd102.policy  = wexcel.policy
            sic_bran.uwd102.rencnt  = n_rencnt
            sic_bran.uwd102.endcnt  = n_endcnt
            sic_bran.uwd102.ltext   = wuppertxt.txt.
        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
            wf_uwd102.fptr = RECID(uwd102).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
        nv_bptr = RECID(uwd102).
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate102dNew C-Win 
PROCEDURE PDCreate102dNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Dupllicate PDCreate102d (A67-0029 05/06/2024)      
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF VAR nv_bptr      AS RECID.
DEF VAR nv_polmaster AS CHAR . /* A65-0203*/

fi_display = "Create data uwd102 policy: " + wexcel.newpol.
DISP fi_display WITH FRAME fr_main.

n_rencnt = 0.
n_endcnt = 0.
n_rencnt = np_rencnt .  /*---add by Chaiyong W. A59-0614 30/04/2017*/
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
/* A65-0203*/
FIND LAST wexcamp WHERE wexcamp.policy   = wexcel.policy /*AND
                        wexcamp.campaign = wexcel.campaign*/ NO-LOCK NO-ERROR .
IF AVAIL wexcamp THEN ASSIGN nv_polmaster = wexcamp.polmaster .
/* end : A65-0203*/
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    /*nv_txt1  = wexcel.campaign */ /* A65-0203*/
    nv_txt1  = wexcel.campaign + " " + "Polmaster : " + nv_polmaster   /* A65-0203*/
    nv_txt2  = "Date Recive: " + wexcel.trndat
    nv_txt3  = "Ref.No.: " + wexcel.cedpol    
    nv_txt4  = "Branch NTL: " + wexcel.brncod + " " + wexcel.brnnam   
    nv_txt5  = "ที่อยู่จัดส่งเอกสาร: "  
    nv_txt6  = TRIM(wexcel.btitle) + " " + TRIM(wexcel.bfname) + " " + TRIM(wexcel.blname)
    nv_txt7  = wexcel.baddr1 + " " + wexcel.baddr2 
    nv_txt8  = wexcel.baddr3 + " " + wexcel.baddr4 
    nv_txt9  = wexcel.bpostcod                  
    nv_txt10 = ""
    nv_txt11 = wexcel.isp
    nv_txt12 = "".

IF nv_txt12 = "" AND wexcel.f8 <> "" THEN nv_txt12 =  wexcel.f8. /*---add by Chaiyong W. A60-0016 15/01/2018*/

/*-----begin by Chaiyong W. A59-0614 15/12/2016*/
IF wexcel.paycod <> "" THEN DO:
    IF      wexcel.paycod = "CA" THEN nv_txt10 = "ประเภทการรับชำระ : เงินสด" .
    ELSE IF wexcel.paycod = "CC" THEN nv_txt10 = "ประเภทการรับชำระ : บัตรเครดิต" .
    ELSE IF wexcel.paycod = "BP" THEN nv_txt10 = "ประเภทการรับชำระ : Bill Payment" .
    ELSE IF wexcel.paycod = "CV" THEN nv_txt10 = "ประเภทการรับชำระ : หักจากยอดจัดสินเชื่อ" .
    ELSE IF wexcel.paycod = "CL" THEN nv_txt10 = "Installment (ผ่อนชำระ)" .
END.
/*End by Chaiyong W. A59-0614 15/12/2016-------*/

DO WHILE nv_line1 <= 12:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
    IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
    IF nv_line1 = 6  THEN wuppertxt.txt = nv_txt6.
    IF nv_line1 = 7  THEN wuppertxt.txt = nv_txt7.
    IF nv_line1 = 8  THEN wuppertxt.txt = nv_txt8.
    IF nv_line1 = 9  THEN wuppertxt.txt = nv_txt9.
    IF nv_line1 = 10 THEN wuppertxt.txt = nv_txt10.
    IF nv_line1 = 11 THEN wuppertxt.txt = nv_txt11.
    IF nv_line1 = 12 THEN wuppertxt.txt = nv_txt12.
    nv_line1 = nv_line1 + 1.
END.
FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wexcel.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt        AND
     sic_bran.uwm100.endcnt  = n_endcnt        AND
     sic_bran.uwm100.bchyr   = nv_batchyr      AND
     sic_bran.uwm100.bchno   = nv_batchno      AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
NO-ERROR NO-WAIT.
IF AVAILABLE sic_bran.uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.bptr    = nv_bptr
            sic_bran.uwd102.fptr    = 0
            sic_bran.uwd102.policy  = wexcel.policy
            sic_bran.uwd102.rencnt  = n_rencnt
            sic_bran.uwd102.endcnt  = n_endcnt
            sic_bran.uwd102.ltext   = wuppertxt.txt.
        IF nv_bptr <> 0 THEN DO:
            FIND wf_uwd102 WHERE RECID(wf_uwd102) = nv_bptr.
            wf_uwd102.fptr = RECID(uwd102).
        END.
        IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(uwd102).
        nv_bptr = RECID(uwd102).
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate120 C-Win 
PROCEDURE PDCreate120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_display = "Please wait..Create uwm120..".
DISP fi_display WITH FRAME fr_main.
CREATE sic_bran.uwm120.
ASSIGN
    sic_bran.uwm120.policy   = sic_bran.uwm100.policy                    /*Policy No.*/
    sic_bran.uwm120.rencnt   = sic_bran.uwm100.rencnt                    /*Renewal Count*/
    sic_bran.uwm120.endcnt   = sic_bran.uwm100.endcnt                    /*Endorsement Count*/
    sic_bran.uwm120.riskgp   = 0                                 /*Risk Group*/
    sic_bran.uwm120.riskno   = 1                                 /*Risk No.*/
    sic_bran.uwm120.fptr01   = 0  sic_bran.uwm120.bptr01 = 0     /*uwd120 Risk Upper Text*/
    sic_bran.uwm120.fptr02   = 0  sic_bran.uwm120.bptr02 = 0     /*uwd121 Risk Lower Text*/
    sic_bran.uwm120.fptr03   = 0  sic_bran.uwm120.bptr03 = 0     /*uwd123 Borderau Text*/
    sic_bran.uwm120.fptr04   = 0  sic_bran.uwm120.bptr04 = 0     /*uwd125 Risk Clauses*/
    sic_bran.uwm120.fptr08   = 0  sic_bran.uwm120.bptr08 = 0     /*uwd124 Risk Endt. Text*/
    sic_bran.uwm120.fptr09   = 0  sic_bran.uwm120.bptr09 = 0     /*uwd126 Risk Endt. Clause*/
    /*sic_bran.uwm120.class    = wexcel.sclass    */                 /*Business Class Code*/   /*nv_class*/
    sic_bran.uwm120.sicurr   = "BHT"                             /*Sum Insured Currency*/
    sic_bran.uwm120.siexch   = 1                                 /*Sum Insured Exchange Rate*/
    sic_bran.uwm120.r_text   = ""                                /*Standard Risk Text Ref. No.*/
    sic_bran.uwm120.bchyr    = nv_batchyr 
    sic_bran.uwm120.bchno    = nv_batchno 
    sic_bran.uwm120.bchcnt   = nv_batcnt  
    sic_bran.uwm120.rskdel   = NO                                /*Risk Deleted (Y/N)*/
    sic_bran.uwm120.styp20   = ""                                /*Statistic Type Codes (4 x 20)*/
    sic_bran.uwm120.sval20   = ""                                /*Statistic Value Codes (4 x 20)*/
    sic_bran.uwm120.gap_r    = 0 /*wgenerage.prem */             /*Gross Annual Prem., Risk Total*/
    sic_bran.uwm120.dl1_r    = 0                                 /*Discount/Loading 1, Risk Total*/
    sic_bran.uwm120.dl2_r    = 0                                 /*Discount/Loading 2, Risk Total*/
    sic_bran.uwm120.dl3_r    = 0                                 /*Discount/Loading 3, Risk Total*/
    sic_bran.uwm120.rstp_r   = 0 /*wgenerage.stamp */            /*Risk Level Stamp, Risk Total*/
    sic_bran.uwm120.rfee_r   = 0                                 /*Risk Level Fee, Risk Total*/
    sic_bran.uwm120.rtax_r   = 0 /*wgenerage.tax*/               /*Risk Level Tax, Risk Total*/
    sic_bran.uwm120.prem_r   = 0 /*wgenerage.prem */             /*Premium Due, Risk Total*/
    sic_bran.uwm120.com1_r   = 0 /*nv_com1_t*/                   /*Commission 1, Risk Total*/
    sic_bran.uwm120.com2_r   = 0                                 /*Commission 2, Risk Total*/
    sic_bran.uwm120.com3_r   = 0                                 /*Commission 3, Risk Total*/
    sic_bran.uwm120.com4_r   = 0                                 /*Commission 4, Risk Total*/
    sic_bran.uwm120.com1p    = nv_com1p                          /*Commission 1 %*/
    sic_bran.uwm120.com2p    = 0                                 /*Commission 2 %*/
    sic_bran.uwm120.com3p    = 0                                 /*Commission 3 %*/
    sic_bran.uwm120.com4p    = 0                                 /*Commission 4 %*/
    sic_bran.uwm120.com1ae   = YES  /*NO  A56-0345 -3*/          /*Commission 1 (A/E)*/
    sic_bran.uwm120.com2ae   = YES                               /*Commission 2 (A/E)*/
    sic_bran.uwm120.com3ae   = YES                               /*Commission 3 (A/E)*/
    sic_bran.uwm120.com4ae   = YES                               /*Commission 4 (A/E)*/
    sic_bran.uwm120.rilate   = NO                                /*RI to Enter Later (Y/N)*/
    sic_bran.uwm120.sigr     = 0                                 /*nv_si Sum Insured, Gross*/
    sic_bran.uwm120.sico     = 0                                 /*Sum Insured, Coinsurance*/
    sic_bran.uwm120.sist     = nv_sist_p                         /*Sum Insured, Statutory*/
    sic_bran.uwm120.sifac    = 0                                 /*Sum Insured, Facultative*/
    sic_bran.uwm120.sitty    = nv_sity_p                         /*Sum Insured, Treaty*/
    sic_bran.uwm120.siqs     = 0                                 /*Sum Insured, Quota Share*/
    sic_bran.uwm120.pdco     = 0                                 /*Premium Due, Coinsurance*/
    sic_bran.uwm120.pdst     = nv_pdst_p                         /*Premium Due, Statutory*/
    sic_bran.uwm120.pdfac    = 0                                 /*Premium Due, Facultative*/
    sic_bran.uwm120.pdtty    = 0                                 /*Premium Due, Treaty*/
    sic_bran.uwm120.pdqs     = 0                                 /*Premium Due, Quota Share*/
    sic_bran.uwm120.comco    = 0                                 /*Commission, Coinsurance*/
    sic_bran.uwm120.comst    = nv_cost_p                         /*Commission, Statutory*/
    sic_bran.uwm120.comfac   = 0                                 /*Commission, Facultative*/
    sic_bran.uwm120.comtty   = 0                                 /*Commission, Treaty*/
    sic_bran.uwm120.comqs    = 0                                 /*Commission, Quota Share*/
    sic_bran.uwm120.stmpae   = YES                               /*Risk Level Stamp (A/E)*/
    sic_bran.uwm120.feeae    = YES                               /*Risk Level Fee (A/E)*/
    sic_bran.uwm120.taxae    = YES                               /*Risk Level Tax (A/E)*/
    sic_bran.uwm120.siret    = 0      .                          /*SI Retention*/
/*--
FIND FIRST wuwm301 WHERE wuwm301.policy = wuwm100.policy NO-LOCK NO-ERROR.
IF AVAIL wuwm301 THEN DO:
    IF LENGTH(wuwm301.covcod) = 1 THEN sic_bran.uwm120.class = "Z" + wuwm301.sclass.
    ELSE sic_bran.uwm120.class = "K" + wuwm301.sclass.
END.
--*/

/*--- Comment By Tontawan S. A63-0124 03/04/2020
IF sic_bran.uwm120.CLASS = "" THEN DO:
    IF LENGTH(wexcel.covcod) = 1 THEN DO: /*1 - 3*/
        sic_bran.uwm120.CLASS = "Z" +  wexcel.sclass.
    END.
    ELSE DO:
        /*--sic_bran.uwm120.CLASS = "K" + wexcel.sclass.  comment by Chaiyong W. A59-0614 27/04/2017*/
        /*---sic_bran.uwm120.CLASS = "M" + wexcel.sclass.  /*----add by Chaiyong W. A59-0614 27/04/2017*/
        comment by Chaiyong W. A61-0016 08/03/2018*/
        /*----Begin by Chaiyong W. A61-0016 08/03/2018*/
        IF INDEX(wexcel.campaign,"C60") <> 0 THEN sic_bran.uwm120.CLASS = "M" + wexcel.sclass.
        ELSE sic_bran.uwm120.CLASS = "C" + wexcel.sclass.

        /*End by Chaiyong W. A61-0016 08/03/2018------*/
    END.
END.
--- Comment By Tontawan S. A63-0124 03/04/2020 */

/*IF sic_bran.uwm120.CLASS = "" THEN  sic_bran.uwm120.CLASS = "T" +  wexcel.sclass. /* Add By Tontawan S. A63-0124 03/04/2020 */*/ /*A65-0203*/
IF sic_bran.uwm120.CLASS = "" THEN  sic_bran.uwm120.CLASS = IF wexcel.pack = "" THEN "T" +  wexcel.sclass ELSE trim(wexcel.pack) + wexcel.sclass . /*A65-0203*/
  
s_recid2  = RECID(sic_bran.uwm120).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate130 C-Win 
PROCEDURE PDCreate130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_display = "Please wait..Create UWM130...".
DISPLAY fi_display WITH FRAME fr_main.

FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
     sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
     sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
     sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
     sic_bran.uwm130.riskgp = 0                      AND
     sic_bran.uwm130.riskno = 1                      AND
     sic_bran.uwm130.itemno = 1                      AND
     sic_bran.uwm130.bchyr  = nv_batchyr             AND
     sic_bran.uwm130.bchno  = nv_batchno             AND
     sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAIL sic_bran.uwm130 THEN DO:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt
        sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = 1
        sic_bran.uwm130.bchyr  = nv_batchyr
        sic_bran.uwm130.bchno  = nv_batchno
        sic_bran.uwm130.bchcnt = nv_batcnt.

    IF wexcel.covcod = "1" OR wexcel.covcod = "5" THEN DO:
        ASSIGN
            sic_bran.uwm130.uom6_v   = INTE(wexcel.si)
            sic_bran.uwm130.uom7_v   = INTE(wexcel.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    END.
    ELSE IF wexcel.covcod = "2" THEN DO:
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = INTE(wexcel.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    END.
    ELSE IF wexcel.covcod = "3" THEN DO:
        ASSIGN
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    END.
    ELSE IF wexcel.covcod = "2.2" THEN DO:
        ASSIGN
            sic_bran.uwm130.uom6_v   = INTE(wexcel.si)
            sic_bran.uwm130.uom7_v   = INTE(wexcel.si)
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    END.
    ELSE IF wexcel.covcod = "3.2" THEN DO:
        ASSIGN
            sic_bran.uwm130.uom6_v   = INTE(wexcel.si)
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    END.

    FIND FIRST wexcamp WHERE wexcamp.policy = wexcel.policy 
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wexcamp THEN DO:
        ASSIGN
            sic_bran.uwm130.uom1_v  =  wexcamp.tp_bi1
            sic_bran.uwm130.uom2_v  =  wexcamp.tp_bi2
            sic_bran.uwm130.uom5_v  =  wexcamp.tp_pd
            sic_bran.uwm130.uom6_u  =  wexcamp.acc . /*A65-0203*/
    END.

    ASSIGN
        sic_bran.uwm130.uom8_v  =  0               
        sic_bran.uwm130.uom9_v  =  0          
        sic_bran.uwm130.uom3_v  =  0
        sic_bran.uwm130.uom4_v  =  0
        sic_bran.uwm130.uom1_c  =  "D1"
        sic_bran.uwm130.uom2_c  =  "D2"
        sic_bran.uwm130.uom5_c  =  "D5"
        sic_bran.uwm130.uom6_c  =  "D6"
        sic_bran.uwm130.uom7_c  =  "D7"
        sic_bran.uwm130.uom8_c  =  "C8"
        sic_bran.uwm130.uom9_c  =  "C9".

    s_recid3   = RECID(sic_bran.uwm130).

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate132_cal C-Win 
PROCEDURE PDCreate132_cal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A65-0203      
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
def var nv_comment   as char .
def var nv_warning   as char .
def var nv_pass      as char .

DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 
           nv_411t = 0      nv_412t = 0
           nv_42t  = 0      nv_43t  = 0.

     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd    = sic_bran.uwm100.policy AND
              stat.pmuwd132.policy    = sic_bran.uwm100.policy AND
              stat.pmuwd132.rencnt    = sic_bran.uwm100.rencnt AND
              stat.pmuwd132.endcnt    = sic_bran.uwm100.endcnt AND
              stat.pmuwd132.txt1      = STRING(nv_batchyr,"9999") AND
              stat.pmuwd132.txt2      = nv_batchno             .
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod    NO-ERROR NO-WAIT.
    
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.
    
               ASSIGN fi_display = "Create data to sic_bran.uwd132  ..." + wexcel.policy .
               DISP fi_display WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae --A64-0355--*/                     
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep --A64-0355--*/                   
                  sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                  
                  sic_bran.uwd132.fptr    =  0                   
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.
    
                  nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_C.
              
               IF sic_bran.uwd132.bencod = "SI" AND wexcel.covcod = "2"  THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = "0".
               IF sic_bran.uwd132.bencod = "NCB" THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 
               
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  wexcamp.pa411 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  wexcamp.pa412 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  wexcamp.pa42  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  wexcamp.pa43  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
    
               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).
    
            END. /* end uwd132*/
            
            If nv_ncbper  <> 0 Then do:
               Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = "X"         AND
                   sicsyac.xmm104.class  = nv_class    AND 
                   sicsyac.xmm104.covcod = nv_covcod   AND 
                   sicsyac.xmm104.ncbper = INTE(nv_ncbper) No-lock no-error no-wait.
               IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                  ASSIGN wexcel.werror = wexcel.werror + "This NCB Step not on NCB Rates file xmm104. | "
                         wexcel.wmark  = NO .
               END.
               ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                           nv_ncbyrs = xmm104.ncbyrs.
            END.
            Else do:  
               ASSIGN nv_ncbyrs    =   0
                      nv_ncbper    =   0
                      nv_ncb       =   0.
            END.
            ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .
            
            DELETE stat.pmuwd132 .  
            /* end A64-0355 */
    END. /* end pmuwd132 */
    IF wexcel.sclass <> "520" THEN DO:
        RUN wgw\wgwchkpadd 
                (input        sic_bran.uwm100.comdat, 
                 input        sic_bran.uwm100.expdat, 
                 input        wexcel.sclass, /* 110 ,210 ,320 */
                 input        int(wexcamp.pa411),  
                 input        int(wexcamp.pa412),             
                 input        int(wexcamp.pa42 ) , 
                 input        int(wexcamp.pa43 ) ,  
                 input        int(wexcel.seat),  
                 input        nv_411t,  
                 input        nv_412t,  
                 input        nv_42t ,  
                 input        nv_43t ,  
                 input        wexcamp.polmaster,
                 input        wexcamp.campaign,
                 input-output nv_comment  ,
                 input-output nv_warning  ,
                 input-output nv_pass    ). 
        if nv_comment <> "" then assign wexcel.werror = wexcel.werror  + trim(nv_comment) + "| " .
        ASSIGN wexcel.wmark = IF wexcel.wmark  = NO THEN NO ELSE IF nv_pass = "Y" THEN YES ELSE NO . 
    END.
   
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate132_calNew C-Win 
PROCEDURE PDCreate132_calNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
def var nv_comment   as char .
def var nv_warning   as char .
def var nv_pass      as char .

DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 
           nv_411t = 0      nv_412t = 0
           nv_42t  = 0      nv_43t  = 0.

     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd    = sic_bran.uwm100.policy   AND
              stat.pmuwd132.policy    = sic_bran.uwm100.policy   AND
              stat.pmuwd132.rencnt    = sic_bran.uwm100.rencnt   AND
              stat.pmuwd132.endcnt    = sic_bran.uwm100.endcnt   AND
              stat.pmuwd132.txt1      = STRING(nv_batchyr,"9999") AND
              stat.pmuwd132.txt2      = nv_batchno             .
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod    NO-ERROR NO-WAIT.
    
            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.
    
               ASSIGN fi_display = "Create data to sic_bran.uwd132  ..." + wexcel.policy .
               DISP fi_display WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae --A64-0355--*/                     
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep --A64-0355--*/                   
                  sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                  
                  sic_bran.uwd132.fptr    =  0                   
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.
    
                  nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_C.
              
               IF sic_bran.uwd132.bencod = "SI" AND wexcel.covcod = "2"  THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = "0".
               IF sic_bran.uwd132.bencod = "NCB" THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 
               
               IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  wexcamp.pa411 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  wexcamp.pa412 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  wexcamp.pa42  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
               IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  wexcamp.pa43  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
    
               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).
    
            END. /* end uwd132*/
            
            If nv_ncbper  <> 0 Then do:
               Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = "X"         AND
                   sicsyac.xmm104.class  = nv_class    AND 
                   sicsyac.xmm104.covcod = nv_covcod   AND 
                   sicsyac.xmm104.ncbper = INTE(nv_ncbper) No-lock no-error no-wait.
               IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                  ASSIGN wexcel.werror = wexcel.werror + "This NCB Step not on NCB Rates file xmm104. | "
                         wexcel.wmark  = NO .
               END.
               ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                           nv_ncbyrs = xmm104.ncbyrs.
            END.
            Else do:  
               ASSIGN nv_ncbyrs    =   0
                      nv_ncbper    =   0
                      nv_ncb       =   0.
            END.
            ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .
            
            DELETE stat.pmuwd132 .  
            /* end A64-0355 */
    END. /* end pmuwd132 */
    IF wexcel.sclass <> "520" THEN DO:
        RUN wgw\wgwchkpadd 
                (input        sic_bran.uwm100.comdat, 
                 input        sic_bran.uwm100.expdat, 
                 input        wexcel.sclass, /* 110 ,210 ,320 */
                 input        int(wexcamp.pa411),  
                 input        int(wexcamp.pa412),             
                 input        int(wexcamp.pa42 ) , 
                 input        int(wexcamp.pa43 ) ,  
                 input        int(wexcel.seat),  
                 input        nv_411t,  
                 input        nv_412t,  
                 input        nv_42t ,  
                 input        nv_43t ,  
                 input        wexcamp.polmaster,
                 input        wexcamp.campaign,
                 input-output nv_comment  ,
                 input-output nv_warning  ,
                 input-output nv_pass    ). 
        if nv_comment <> "" then assign wexcel.werror = wexcel.werror  + trim(nv_comment) + "| " .
        ASSIGN wexcel.wmark = IF wexcel.wmark  = NO THEN NO ELSE IF nv_pass = "Y" THEN YES ELSE NO . 
    END.
   
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate132_Camp C-Win 
PROCEDURE PDCreate132_Camp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  A65-0203     
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
def var nv_comment   as char .
def var nv_warning   as char .
def var nv_pass      as char .
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    fi_display = "Create data uwd132 policy: " + wexcel.policy.
    DISP fi_display WITH FRAME fr_main.
    
    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 
           /* A64-0309 */ 
           nv_411t = 0      nv_412t = 0
           nv_42t  = 0      nv_43t  = 0.
           /* end : A64-0309 */ 
    FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy) AND
                            wexcamp.campaign  = TRIM(wexcel.campaign) AND
                            wexcamp.polmaster <> "" NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
         FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
                  stat.pmuwd132.campcd        = trim(wexcamp.campaign)   AND 
                  TRIM(stat.pmuwd132.policy)  = TRIM(wexcamp.polmaster)  NO-LOCK.    /*A64-0044*/
            FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
                 sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
                 sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
                 sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
                 sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
                 sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
                 sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
                 sic_bran.uwd132.bchyr   = nv_batchyr             AND
                 sic_bran.uwd132.bchno   = nv_batchno             AND
                 sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
                 sic_bran.uwd132.bencod  = stat.pmuwd132.bencod      NO-ERROR NO-WAIT.
        
                IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                    CREATE sic_bran.uwd132.
        
                   ASSIGN fi_display = "Create data to sic_bran.uwd132  ..." + wexcel.policy .
                   DISP fi_display WITH FRAM fr_main. 
                   ASSIGN
                      sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                      sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                      sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                      sic_bran.uwd132.gap_ae  =  NO /*stat.pmuwd132.gap_ae --A64-0355--*/                
                      sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                      sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                      sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                      sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                      sic_bran.uwd132.pd_aep  =  "E" /*stat.pmuwd132.pd_aep --A64-0355--*/                      
                      sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                   
                      sic_bran.uwd132.fptr    =  0                   
                      sic_bran.uwd132.bptr    =  nv_bptr                   
                      sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                      sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                      sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                      sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                      sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                      sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                      sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                      sic_bran.uwd132.bchyr   =  nv_batchyr                   
                      sic_bran.uwd132.bchno   =  nv_batchno 
                      sic_bran.uwd132.bchcnt  =  nv_batcnt.
                   
                      nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                      nv_pdprm  = nv_pdprm + stat.pmuwd132.prem_C.
                         
                   IF sic_bran.uwd132.bencod = "ENGC" THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = trim(STRING(sic_bran.uwm301.engine)) .
                   IF sic_bran.uwd132.bencod = "ENGT" THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = TRIM(STRING(sic_bran.uwm301.tons)).
                   IF sic_bran.uwd132.bencod = "NCB"  THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                  
                   /*Add A67-0029*/
                   IF sic_bran.uwd132.bencod = "ENGS" THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = TRIM(STRING(sic_bran.uwm301.mv41seat)).  
                   IF sic_bran.uwd132.bencod = "ENGH" THEN ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = TRIM(STRING(sic_bran.uwm301.watts)).
                   IF SUBSTR(sic_bran.uwd132.bencod,1,1) = "A" THEN DO:
                       IF sic_bran.uwd132.bencod <> "A000" THEN DO:
                           ASSIGN SUBSTRING(sic_bran.uwd132.benvar,31,30) = TRIM(STRING(nv_drivno)). 
                       END.
                   END.
                   /*End Add A67-0029*/

                   IF sic_bran.uwd132.bencod = "411"  THEN ASSIGN  nv_411t = stat.pmuwd132.prem_C  wexcamp.pa411 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                   IF sic_bran.uwd132.bencod = "412"  THEN ASSIGN  nv_412t = stat.pmuwd132.prem_C  wexcamp.pa412 = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                   IF sic_bran.uwd132.bencod = "42"   THEN ASSIGN  nv_42t  = stat.pmuwd132.prem_C  wexcamp.pa42  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                   IF sic_bran.uwd132.bencod = "43"   THEN ASSIGN  nv_43t  = stat.pmuwd132.prem_C  wexcamp.pa43  = int(SUBSTRING(sic_bran.uwd132.benvar,31,30)).   
                   
                   If nv_ncbper  <> 0 Then do:
                       Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                           sicsyac.xmm104.tariff = "X"           AND
                           sicsyac.xmm104.class  = trim(trim(wexcel.pack) + trim(wexcel.sclass)) AND 
                           sicsyac.xmm104.covcod = wexcel.covcod AND 
                           sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
                       IF not avail  sicsyac.xmm104  Then do:
                           Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                           ASSIGN wexcel.werror = wexcel.werror + "This NCB Step not on NCB Rates file xmm104. | "
                                  wexcel.wmark  = NO .
                                  
                       END.
                       ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                                   nv_ncbyrs = xmm104.ncbyrs.
                   END.
                   Else do:  
                       ASSIGN nv_ncbyrs =   0
                              nv_ncbper =   0
                              nv_ncb    =   0.
                   END.
                   ASSIGN   
                    sic_bran.uwm301.ncbper   = nv_ncbper
                    sic_bran.uwm301.ncbyrs   = nv_ncbyrs .
        
                   IF nv_bptr <> 0 THEN DO:
                       FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                           wf_uwd132.fptr = RECID(sic_bran.uwd132).
                   END.
                   IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
                   nv_bptr = RECID(sic_bran.uwd132).
        
                END.
            END.
        RUN wgw\wgwchkpadd 
            (input sic_bran.uwm100.comdat, 
             input sic_bran.uwm100.expdat, 
             input wexcel.sclass, /* 110 ,210 ,320 */
             input int(wexcamp.pa411),  
             input int(wexcamp.pa412),             
             input int(wexcamp.pa42 ) , 
             input int(wexcamp.pa43 ) ,  
             input int(wexcel.seat),  
             input nv_411t,  
             input nv_412t,  
             input nv_42t ,  
             input nv_43t ,  
             input wexcamp.polmaster,
             input wexcamp.campaign,
             input-output nv_comment  ,
             input-output nv_warning  ,
             input-output nv_pass). 
        if nv_comment <> "" then assign wexcel.werror = wexcel.werror + trim(nv_comment) + "| " .
        ASSIGN wexcel.wmark = IF wexcel.wmark  = NO THEN NO ELSE IF nv_pass = "Y" THEN YES ELSE NO . 

        sic_bran.uwm130.bptr03  =  nv_bptr. 
        RELEASE stat.pmuwd132.
        RELEASE sic_bran.uwd132.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreate301 C-Win 
PROCEDURE PDCreate301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_display = "Please wait..Create uwm301...".
DISPLAY fi_display WITH FRAME fr_main.

RUN PDChkChassis.

FIND sic_bran.uwm301 USE-INDEX uwm30101 WHERE
     sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
     sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt AND
     sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt AND
     sic_bran.uwm301.riskgp = 0                      AND
     sic_bran.uwm301.riskno = 1                      AND
     sic_bran.uwm301.itemno = 1                      AND
     sic_bran.uwm301.bchyr  = nv_batchyr             AND 
     sic_bran.uwm301.bchno  = nv_batchno             AND 
     sic_bran.uwm301.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAIL sic_bran.uwm301 THEN DO:
    CREATE sic_bran.uwm301.
    ASSIGN
        sic_bran.uwm301.covcod   = wexcel.covcod      
        sic_bran.uwm301.modcod   = wexcel.modcod      
        sic_bran.uwm301.vehreg   = wexcel.vehreg      
        sic_bran.uwm301.eng_no   = wexcel.eng_no      
        sic_bran.uwm301.cha_no   = wexcel.cha_no      
        sic_bran.uwm301.yrmanu   = INTE(wexcel.yrmanu)      
        sic_bran.uwm301.vehuse   = wexcel.vehuse
        sic_bran.uwm301.ncbyrs   = 0     
        sic_bran.uwm301.ncbper   = 0      
        sic_bran.uwm301.tariff   = "X"            
        sic_bran.uwm301.act_ae   = YES      
        sic_bran.uwm301.actprm   = 0      
        sic_bran.uwm301.tp_ae    = YES      
        sic_bran.uwm301.tpprm    = 0      
        sic_bran.uwm301.policy   = sic_bran.uwm100.policy       
        sic_bran.uwm301.rencnt   = sic_bran.uwm100.rencnt       
        sic_bran.uwm301.endcnt   = sic_bran.uwm100.endcnt       
        sic_bran.uwm301.riskgp   = 0      
        sic_bran.uwm301.riskno   = 1       
        sic_bran.uwm301.itemno   = 1 
        sic_bran.uwm301.bchyr    = nv_batchyr
        sic_bran.uwm301.bchno    = nv_batchno
        sic_bran.uwm301.bchcnt   = nv_batcnt 
        sic_bran.uwm301.cert     = ""      
        sic_bran.uwm301.moddes   = TRIM(wexcel.makdes) + " " + TRIM(wexcel.moddes)      
        sic_bran.uwm301.body     = wexcel.body      
        sic_bran.uwm301.engine   = INTE(wexcel.engine)      
        sic_bran.uwm301.tons     = INTE(wexcel.gwv) 
        /*sic_bran.uwm301.tons     = sic_bran.uwm301.tons  / 1000  */  /*A66-0069*/
        sic_bran.uwm301.seats    = INTE(wexcel.seat)    
        sic_bran.uwm301.vehgrp   = wexcel.vehgrp    
        sic_bran.uwm301.trareg   = nv_uwm301trareg      
        /*sic_bran.uwm301.logbok   = "" */                                         /*A64-0247*/
        sic_bran.uwm301.logbok    = IF trim(wexcel.isp) <> "" THEN "Y" ELSE ""  /*A64-0247*/
        sic_bran.uwm301.garage   = wexcel.garage           
        sic_bran.uwm301.mv41a    = ""             
        sic_bran.uwm301.mv41b    = ""      
        sic_bran.uwm301.mv41c    = ""      
        sic_bran.uwm301.mv42     = ""      
        sic_bran.uwm301.atttxt   = ""      
        sic_bran.uwm301.mv41seat = INTE(wexcel.seat)    
        sic_bran.uwm301.comp_cod = ""      
        sic_bran.uwm301.sckno    = 0      
        sic_bran.uwm301.mv_ben83 = wexcel.bennam    
        sic_bran.uwm301.prmtxt   = "" /*wexcel.inspec*/      
        sic_bran.uwm301.itmdel   = NO. 

       ASSIGN                       
           wexcel.tacc1             = trim(substr(wexcel.tacc1,1,60))  
           wexcel.tacc2             = trim(substr(wexcel.tacc2,1,60))  
           wexcel.tacc3             = trim(substr(wexcel.tacc3,1,60))  
           wexcel.tacc4             = trim(substr(wexcel.tacc4,1,60))  
           wexcel.tacc5             = trim(substr(wexcel.tacc5,1,60)).  
           sic_bran.uwm301.prmtxt   = wexcel.tacc1 + FILL(" ",60 - LENGTH(wexcel.tacc1))  +      
                                      wexcel.tacc2 + FILL(" ",60 - LENGTH(wexcel.tacc2))  +     
                                      wexcel.tacc3 + FILL(" ",60 - LENGTH(wexcel.tacc3))  +     
                                      wexcel.tacc4 + FILL(" ",60 - LENGTH(wexcel.tacc4))  +     
                                      wexcel.tacc5 + FILL(" ",60 - LENGTH(wexcel.tacc5))  . 
        
    /*-- Add A67-0029 --*/
    ASSIGN  
        sic_bran.uwm301.eng_no2   = nv_eng_no2  
        sic_bran.uwm301.battper   = nv_battper  
        sic_bran.uwm301.battyr    = nv_battyr   
        sic_bran.uwm301.battprice = nv_battprice
        sic_bran.uwm301.battsi    = nv_battsi   
        sic_bran.uwm301.battno    = nv_battno   
        sic_bran.uwm301.battflg   = nv_battflg 
        sic_bran.uwm301.chargno   = nv_chargno  
        sic_bran.uwm301.chargsi   = nv_chargsi   
        sic_bran.uwm301.chargflg  = nv_chargflg 
        sic_bran.uwm301.car_color = wexcel.carcol.

    IF wexcel.evflg = YES THEN DO:
        IF nv_si_mv < INTE(wexcel.si) THEN sic_bran.uwm301.maksi = INTE(wexcel.si).
        ELSE sic_bran.uwm301.maksi = nv_si_mv.

        IF sic_bran.uwm301.battflg = "Y" THEN DO:
            nv_battper = 100.
        END.
        ELSE DO:
            IF nv_battyr = 0 THEN DO:
                nv_battyr = INTE(wexcel.yrmanu).
    
                nv_comdat  = DATE(wexcel.comdat).
                nv_ckbatyr = (YEAR(nv_comdat) - nv_battyr) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE 
                           sicsyac.xmm106.tariff  = "X"        AND
                           sicsyac.xmm106.bencod  = "CBAT"     AND
                           sicsyac.xmm106.CLASS   = ""         AND
                           sicsyac.xmm106.covcod  = ""         AND
                           sicsyac.xmm106.KEY_a   = 0          AND
                           sicsyac.xmm106.KEY_b  >= nv_ckbatyr AND
                           sicsyac.xmm106.effdat <= nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm106 THEN DO:
                    nv_battper = sicsyac.xmm106.appinc.
                END.
            END.
        END.
        sic_bran.uwm301.battper = nv_battper.
    END.
    ELSE DO:
        sic_bran.uwm301.maksi = INTE(wexcel.si).
    END.
    /*-- End Add A67-0029 --*/

    s_recid4   = RECID(sic_bran.uwm301).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreateIns C-Win 
PROCEDURE PDCreateIns :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name     AS CHAR.
DEF VAR nv_transfer AS LOGICAL.
DEF VAR n_insref    AS CHARACTER FORMAT "X(10)".
DEF VAR putchr      AS CHAR      FORMAT "X(200)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR      FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_usrid    AS CHARACTER FORMAT "X(08)".

fi_display = "Create data xmm600 policy: " + wexcel.policy.
DISP fi_display WITH FRAME fr_main.

nv_name = wexcel.ntitle + wexcel.fname.

nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4).
nv_transfer = YES.

IF nv_insref = "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
              sicsyac.xmm600.NAME = wexcel.fname 
        /*AND sicsyac.xmm600.homebr   = fi_branch    /*---add by Chaiyong W. A59-0614 02/05/2017*/*/
        AND sicsyac.xmm600.homebr   = wexcel.brnsty  /*A63-00472*/ 
        AND sicsyac.xmm600.clicod   = "IN"
    NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        IF LOCKED sicsyac.xmm600 THEN DO:
            nv_transfer = NO.
            n_insref = sicsyac.xmm600.acno.
            RETURN.
        END.
        ELSE DO:
            n_check   = "".
            nv_insref = "".

            IF R-INDEX(nv_name,"จก.")             <> 0  OR              
               R-INDEX(nv_name,"จำกัด")           <> 0  OR  
               R-INDEX(nv_name,"(มหาชน)")         <> 0  OR  
               R-INDEX(nv_name,"INC.")            <> 0  OR 
               R-INDEX(nv_name,"CO.")             <> 0  OR 
               R-INDEX(nv_name,"LTD.")            <> 0  OR 
               R-INDEX(nv_name,"LIMITED")         <> 0  OR 
               INDEX(nv_name,"บริษัท")            <> 0  OR 
               INDEX(nv_name,"บ.")                <> 0  OR 
               INDEX(nv_name,"บจก.")              <> 0  OR 
               INDEX(nv_name,"หจก.")              <> 0  OR 
               INDEX(nv_name,"หสน.")              <> 0  OR 
               INDEX(nv_name,"บรรษัท")            <> 0  OR 
               INDEX(nv_name,"มูลนิธิ")           <> 0  OR 
               INDEX(nv_name,"ห้าง")              <> 0  OR 
               INDEX(nv_name,"ห้างหุ้นส่วน")      <> 0  OR 
               INDEX(nv_name,"ห้างหุ้นส่วนจำกัด") <> 0  OR
               INDEX(nv_name,"ห้างหุ้นส่วนจำก")   <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".  /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/

            RUN PDRunInsNo.

            IF n_check <> "" THEN DO:
                ASSIGN
                    putchr  = ""
                    putchr1 = ""
                    putchr1 = "Error Running Insured Code."
                    putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                              " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                              "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                              " "             + TRIM(putchr1).
                nv_transfer = NO.
                nv_insref   = "".
                RETURN.
            END.

            loop_runningins: /*Check Insured*/
            REPEAT:
                FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                     sicsyac.xmm600.acno = CAPS(nv_insref)  NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm600 THEN DO:
                    RUN PDRunInsNo.

                    IF  n_check <> ""  THEN DO:  
                        ASSIGN
                            putchr  = ""
                            putchr1 = ""
                            putchr1 = "Error Running Insured Code."
                            putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                                      " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                                      "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                                        " "             + TRIM(putchr1).

                        nv_transfer = NO.
                        nv_insref   = "".
                        RETURN.
                    END.
                END.
                ELSE LEAVE loop_runningins.
            END.  /*loop_runningins*/

            CREATE sicsyac.xmm600.

        END.
        n_insref = nv_insref.
    END.
    ELSE DO:
        nv_insref = sicsyac.xmm600.acno.
        n_insref  = nv_insref.
        nv_transfer = NO. /*-- Add chutikarn A50-0072 --*/
        RETURN.
    END.
END.

IF nv_transfer = YES THEN DO:
    ASSIGN
        sicsyac.xmm600.acno     = nv_insref                 /*Account no*/
        sicsyac.xmm600.gpstcs   = nv_insref                 /*Group A/C for statistics*/
        sicsyac.xmm600.gpage    = ""                        /*Group A/C for ageing*/
        sicsyac.xmm600.gpstmt   = ""                        /*Group A/C for Statement*/
        sicsyac.xmm600.or1ref   = ""                        /*OR Agent 1 Ref. No.*/
        sicsyac.xmm600.or2ref   = ""                        /*OR Agent 2 Ref. No.*/
        sicsyac.xmm600.or1com   = 0                         /*OR Agent 1 Comm. %*/
        sicsyac.xmm600.or2com   = 0                         /*OR Agent 2 Comm. %*/
        sicsyac.xmm600.or1gn    = "G"                       /*OR Agent 1 Gross/Net*/
        sicsyac.xmm600.or2gn    = "G"                       /*OR Agent 2 Gross/Net*/
        sicsyac.xmm600.ntitle   = sic_bran.uwm100.ntitle    /*Title for Name Mr/Mrs/etc*/  
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = sic_bran.uwm100.name1     /*Name Line 1*/
        sicsyac.xmm600.abname   = sic_bran.uwm100.name1     /*Abbreviated Name*/
        sicsyac.xmm600.icno     = sic_bran.uwm100.anam2     /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = sic_bran.uwm100.addr1     /*Address line 1*/
        sicsyac.xmm600.addr2    = sic_bran.uwm100.addr2     /*Address line 2*/
        sicsyac.xmm600.addr3    = sic_bran.uwm100.addr3     /*Address line 3*/
        sicsyac.xmm600.addr4    = sic_bran.uwm100.addr4     /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = sic_bran.uwm100.branch    /*Home branch*/
        sicsyac.xmm600.opened   = sic_bran.uwm100.trndat    /*Date A/C opened*/
        sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
        sicsyac.xmm600.langug   = ""                        /*Language Code*/
        sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
        sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
        sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
        sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
        sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
        sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
        sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
        sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
        sicsyac.xmm600.phone    = ""                        /*Phone no.*/
        sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
        sicsyac.xmm600.crper    = 0                         /*Credit period*/
        sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
        sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid                  /*Userid*/
        sicsyac.xmm600.regagt   = ""                        /*Registered agent code*/
        sicsyac.xmm600.agtreg   = ""                        /*Agents Registration/Licence No*/
        sicsyac.xmm600.debtyn   = YES                       /*Permit debtor trans Y/N*/
        sicsyac.xmm600.crcon    = NO                        /*Credit Control Report*/
        sicsyac.xmm600.muldeb   = NO                        /*Multiple Debtors Acc.*/
        sicsyac.xmm600.styp20   = ""                        /*Statistic Type Codes (4 x 20)*/
        sicsyac.xmm600.sval20   = ""                        /*Statistic Value Codes (4 x 20)*/
        sicsyac.xmm600.dtyp20   = ""                        /*Type of Date Codes (2 X 20)*/
        sicsyac.xmm600.dval20   = ""                        /*Date Values (8 X 20)*/
        sicsyac.xmm600.iblack   = ""                        /*Insured Black List Code*/
        sicsyac.xmm600.oldic    = ""                        /*Old IC No.*/
        sicsyac.xmm600.cardno   = ""                        /*Credit Card Account No.*/
        sicsyac.xmm600.cshcrd   = ""                        /*Cash(C)/Credit(R) Agent*/
        sicsyac.xmm600.naddr1   = ""                        /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                        /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = ""                        /*New address line 2*/
        sicsyac.xmm600.fax      = ""                        /*Fax No.*/
        sicsyac.xmm600.naddr3   = ""                        /*New address line 3*/
        sicsyac.xmm600.telex    = ""                        /*Telex No.*/
        sicsyac.xmm600.naddr4   = ""                        /*New address line 4*/
        sicsyac.xmm600.name2    = ""                        /*Name Line 2*/
        sicsyac.xmm600.npostcd  = ""                        /*New postal code*/
        sicsyac.xmm600.name3    = ""                        /*Name Line 3*/
        sicsyac.xmm600.nphone   = ""                        /*New phone no.*/    
        sicsyac.xmm600.nachg    = YES                       /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                         /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                         /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                        /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = ""                        /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                         /*Agent tax date*/
        sicsyac.xmm600.anlyc5   = "".                       /*Analysis Code 5*/
    IF sicsyac.xmm600.postcd = "" THEN sicsyac.xmm600.postcd  = trim(sic_bran.uwm100.postcd). /*---add by Chaiyong W. A59-0614 21/03/2017*/
END.

nv_insref = sicsyac.xmm600.acno.
nv_transfer = YES.

FIND sicsyac.xtm600 WHERE
     sicsyac.xtm600.acno = nv_insref
NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.xtm600 THEN DO:
    IF LOCKED sicsyac.xtm600 THEN DO:
        nv_transfer = NO.
        /*RETURN.*/
    END.
    ELSE DO:
        CREATE sicsyac.xtm600.
    END.
END.

IF nv_transfer = YES THEN DO:
    ASSIGN
        sicsyac.xtm600.acno    = nv_insref                  /*Account no.*/
        sicsyac.xtm600.name    = sic_bran.uwm100.name1      /*Name of Insured Line 1*/
        sicsyac.xtm600.abname  = sic_bran.uwm100.name1      /*Abbreviated Name*/
        sicsyac.xtm600.addr1   = sic_bran.uwm100.addr1      /*address line 1*/
        sicsyac.xtm600.addr2   = sic_bran.uwm100.addr2      /*address line 2*/
        sicsyac.xtm600.addr3   = sic_bran.uwm100.addr3      /*address line 3*/
        sicsyac.xtm600.addr4   = sic_bran.uwm100.addr4      /*address line 4*/
        sicsyac.xtm600.name2   = ""                         /*Name of Insured Line 2*/
        sicsyac.xtm600.ntitle  = sic_bran.uwm100.ntitle     /*Title*/
        sicsyac.xtm600.name3   = ""                         /*Name of Insured Line 3*/
        sicsyac.xtm600.fname   = "" .                       /*First Name*/
END.

/*RETURN.*/
HIDE MESSAGE NO-PAUSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreateIns2 C-Win 
PROCEDURE PDCreateIns2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  nv_insref   NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = trim(wexcel.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wexcel.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wexcel.lastName)   
    sicsyac.xmm600.postcd    = trim(wexcel.postcd)     
    sicsyac.xmm600.icno      = trim(wexcel.icno)       
    sicsyac.xmm600.codeocc   = trim(wexcel.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wexcel.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wexcel.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wexcel.codeaddr3)  

    /*-- Add By Tontawan S. A64-0149 07/04/2021 --*/
    sicsyac.xmm600.addr1     = TRIM(wexcel.addr1)
    sicsyac.xmm600.addr2     = TRIM(wexcel.addr2)
    sicsyac.xmm600.addr3     = TRIM(wexcel.addr3)
    sicsyac.xmm600.addr4     = TRIM(wexcel.addr4).
    /*-- End By Tontawan S. A64-0149 07/04/2021 --*/

    /*sicsyac.xmm600.anlyc5    = trim(wexcel.br_insured)*/   .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    /*-- Add By Tontawan S. A64-0149 07/04/2021 --*/
    sicsyac.xtm600.addr1     = TRIM(wexcel.addr1)
    sicsyac.xtm600.addr2     = TRIM(wexcel.addr2)
    sicsyac.xtm600.addr3     = TRIM(wexcel.addr3)
    sicsyac.xtm600.addr4     = TRIM(wexcel.addr4)
    /*-- End By Tontawan S. A64-0149 07/04/2021 --*/

    sicsyac.xtm600.postcd    = trim(wexcel.postcd)        
    sicsyac.xtm600.firstname = trim(wexcel.firstName)     
    sicsyac.xtm600.lastname  = trim(wexcel.lastName)  .  
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xtm600.
/*Add by Kridtiya i. A63-0472*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreateMailtxt C-Win 
PROCEDURE PDCreateMailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR no_policy AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt AS CHAR FORMAT "99".
DEF VAR no_endcnt AS CHAR FORMAT "999".

DEF VAR no_riskno AS CHAR FORMAT "999".
DEF VAR no_itemno AS CHAR FORMAT "999".

fi_display = "Create data mailtxt_fil policy: " + wexcel.policy.
DISP fi_display WITH FRAME fr_main.

IF nv_drivno <> 0 THEN DO:
      no_policy = sic_bran.uwm301.policy .
      no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") .
      no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") .
    
      no_riskno = "001".
      no_itemno = "001".
     
      /*nv_age1 =  YEAR(TODAY) - INT(SUBSTR(wexcel.dribir1,7,4))  .
      nv_age2 =  YEAR(TODAY) - INT(SUBSTR(wexcel.dribir2,7,4))  .*/

      IF wexcel.dribir1 <> " "  AND wexcel.drinam1 <> " " THEN DO: /*note add & modified*/
          IF YEAR(TODAY) < YEAR(DATE(wexcel.dribir1)) THEN DO:
              nv_dribir1      = STRING(INT(SUBSTR(wexcel.dribir1,7,4))).
              wexcel.dribir1  = SUBSTR(wexcel.dribir1,1,6) + nv_dribir1.
          END.
          ELSE DO:
              nv_dribir1      = STRING(INT(SUBSTR(wexcel.dribir1,7,4)) + 543).
              wexcel.dribir1  = SUBSTR(wexcel.dribir1,1,6) + nv_dribir1.
          END.
      END.

      IF wexcel.dribir2 <>  " " AND wexcel.drinam2 <> " " THEN DO: /*note add & modified */
          IF YEAR(TODAY) < YEAR(DATE(wexcel.dribir2)) THEN DO:
              nv_dribir2      = STRING(INT(SUBSTR(wexcel.dribir2,7,4))).
              wexcel.dribir2  = SUBSTR(wexcel.dribir2,1,6) + nv_dribir2.
          END.
          ELSE DO:
              nv_dribir2      = STRING(INT(SUBSTR(wexcel.dribir2,7,4)) + 543).
              wexcel.dribir2  = SUBSTR(wexcel.dribir2,1,6) + nv_dribir2.
          END.
      END.

      FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                   brstat.mailtxt_fil.policy = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
                   brstat.mailtxt_fil.bchyr  = nv_batchyr   AND                                               
                   brstat.mailtxt_fil.bchno  = nv_batchno   AND
                   brstat.mailtxt_fil.bchcnt = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
      IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.  

      FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                   brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
                   brstat.mailtxt_fil.lnumber = nv_lnumber    AND
                   brstat.mailtxt_fil.bchyr   = nv_batchyr    AND                                               
                   brstat.mailtxt_fil.bchno   = nv_batchno    AND
                   brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
      IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
          IF wexcel.drinam1 <> " " THEN DO:
              CREATE brstat.mailtxt_fil.
              ASSIGN                                           
                  brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                  brstat.mailtxt_fil.lnumber   = nv_lnumber.
                  /*-- Comment by Narin A54-0396
                  brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                  --*/
                  /*--    Add by Narin A54-0396--*/
                  brstat.mailtxt_fil.ltext     = wexcel.drinam1 + FILL(" ",50 - LENGTH(wexcel.drinam1)). 
                  /*--End Add by Narin A54-0396--*/
                  brstat.mailtxt_fil.ltext2    = wexcel.dribir1 + "  " 
                                               + STRING(nv_age1).
                  nv_drivno                    = 1.
              ASSIGN /*a490166*/
                  brstat.mailtxt_fil.bchyr = nv_batchyr 
                  brstat.mailtxt_fil.bchno = nv_batchno 
                  brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                  SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
          END.

          IF wexcel.drinam2 <> "" THEN DO:
              CREATE brstat.mailtxt_fil. 
              ASSIGN
                  brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                  brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                  /*-- Comment by Narin A54-0396
                  brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                  --*/
                  /*--    Add by Narin A54-0396--*/
                  brstat.mailtxt_fil.ltext    = wexcel.drinam2 + FILL(" ",50 - LENGTH(wexcel.drinam2)). 
                  /*--End Add by Narin A54-0396--*/
                  brstat.mailtxt_fil.ltext2   = wexcel.dribir2 + "  "
                                              + STRING(nv_age2). 
                  nv_drivno                   = 2.
              ASSIGN /*a490166*/
                  brstat.mailtxt_fil.bchyr = nv_batchyr 
                  brstat.mailtxt_fil.bchno = nv_batchno 
                  brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                  SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/    .
          END.
      END.
      ELSE DO:
          IF wexcel.drinam1 <> " " THEN DO:
            CREATE  brstat.mailtxt_fil.
            ASSIGN  brstat.mailtxt_fil.policy     = wexcel.policy + STRING(sic_bran.uwm100.rencnt) + STRING(sic_bran.uwm100.endcnt) + STRING(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                    brstat.mailtxt_fil.lnumber    = nv_lnumber.
                    /*-- Comment by Narin A54-0396
                    brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                    --*/
                    /*--    Add by Narin A54-0396--*/
                    brstat.mailtxt_fil.ltext      = wexcel.drinam1 + FILL(" ",50 - LENGTH(wexcel.drinam1)). 
                    /*--End Add by Narin A54-0396--*/
                    brstat.mailtxt_fil.ltext2     = wexcel.dribir1 + "  "
                                                  +  TRIM(STRING(nv_age1)).
          END. /*drivnam1 <> "" */
          IF wexcel.drinam2 <> "" THEN DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN
                  brstat.mailtxt_fil.policy   = wexcel.policy + STRING(uwm100.rencnt) + STRING(uwm100.endcnt) + STRING(uwm301.riskno)  + STRING(uwm301.itemno)
                  brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                  /*-- Comment by Narin A54-0396
                  brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)). 
                  --*/
                  /*--    Add by Narin A54-0396--*/
                  brstat.mailtxt_fil.ltext    = wexcel.drinam2 + FILL(" ",50 - LENGTH(wexcel.drinam2)). 
                  /*--End Add by Narin A54-0396--*/
                  brstat.mailtxt_fil.ltext2   = wexcel.dribir2 + "  "
                                              + TRIM(STRING(nv_age2)).
              ASSIGN /*a490166*/
                  brstat.mailtxt_fil.bchyr = nv_batchyr 
                  brstat.mailtxt_fil.bchno = nv_batchno 
                  brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                  SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
          END. /*drivnam2 <> " " */
      END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreateMailtxtNew C-Win 
PROCEDURE PDCreateMailtxtNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR no_policy AS CHAR FORMAT "x(20)" .
DEF VAR no_rencnt AS CHAR FORMAT "99".
DEF VAR no_endcnt AS CHAR FORMAT "999".

DEF VAR no_riskno AS CHAR FORMAT "999".
DEF VAR no_itemno AS CHAR FORMAT "999".

DEF VAR nv_i AS INTE INIT 1.
DEF VAR nv_chkdelmail AS LOGICAL.
DEF VAR nv_dd    AS INTE FORMAT "99".
DEF VAR nv_mm    AS INTE FORMAT "99".
DEF VAR nv_yy    AS INTE FORMAT "9999".

fi_display = "Create data mailtxt_fil policy: " + wexcel.policy.
DISP fi_display WITH FRAME fr_main.

IF nv_drivno <> 0 THEN DO:
    nv_mailpol = sic_bran.uwm301.policy +
                 STRING(sic_bran.uwm301.rencnt,"99") + 
                 STRING(sic_bran.uwm301.endcnt,"999") + "001" + "001".
    nv_lnumber = 1.
    nv_chkdelmail = NO.

    FIND LAST brstat.mailtxt_fil USE-INDEX mailtxt01 WHERE
              brstat.mailtxt_fil.policy = nv_mailpol AND
              brstat.mailtxt_fil.bchyr  = nv_batchyr AND                                               
              brstat.mailtxt_fil.bchno  = nv_batchno AND
              brstat.mailtxt_fil.bchcnt = nv_batcnt  NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber = 1.
    ELSE DO:
        nv_chkdelmail = YES.
    END.

    IF nv_chkdelmail = YES THEN DO:

        nv_lnumber = 1.

        FOR EACH brstat.mailtxt_fil USE-INDEX mailtxt01 WHERE
                 brstat.mailtxt_fil.policy = nv_mailpol AND
                 brstat.mailtxt_fil.bchyr  = nv_batchyr AND                                               
                 brstat.mailtxt_fil.bchno  = nv_batchno AND
                 brstat.mailtxt_fil.bchcnt = nv_batcnt  :
            DELETE brstat.mailtxt_fil.
        END.
        RELEASE brstat.mailtxt_fil.
    END.

    loop_mail:
    REPEAT:
        ASSIGN
            nv_dd = 0
            nv_mm = 0
            nv_yy = 0.

        FIND FIRST brstat.mailtxt_fil USE-INDEX mailtxt01 WHERE
                   brstat.mailtxt_fil.policy  = nv_mailpol AND
                   brstat.mailtxt_fil.lnumber = nv_lnumber AND
                   brstat.mailtxt_fil.bchyr   = nv_batchyr AND                                               
                   brstat.mailtxt_fil.bchno   = nv_batchno AND
                   brstat.mailtxt_fil.bchcnt  = nv_batcnt  NO-LOCK  NO-ERROR  NO-WAIT.
        IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
            IF nv_lnumber = 1 THEN DO:
                IF wexcel.drinam1 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil.
                    ASSIGN
                        brstat.mailtxt_fil.policy    = nv_mailpol
                        brstat.mailtxt_fil.bchyr     = nv_batchyr 
                        brstat.mailtxt_fil.bchno     = nv_batchno 
                        brstat.mailtxt_fil.bchcnt    = nv_batcnt
                        brstat.mailtxt_fil.lnumber   = nv_lnumber
                        brstat.mailtxt_fil.ltext     = wexcel.drinam1 + FILL(" ",50 - LENGTH(wexcel.drinam1))
                        brstat.mailtxt_fil.drivage   = nv_age1
                        brstat.mailtxt_fil.drivlevel = nv_levcod
                        brstat.mailtxt_fil.levelper  = nv_levper
                        brstat.mailtxt_fil.titlenam  = ""
                        brstat.mailtxt_fil.firstnam  = TRIM(wexcel.drinam1)
                        brstat.mailtxt_fil.lastnam   = ""
                        brstat.mailtxt_fil.occupcod  = ""
                        brstat.mailtxt_fil.occupdes  = "-"
                        brstat.mailtxt_fil.licenno   = "-"
                        brstat.mailtxt_fil.drividno  = "-" .

                    IF wexcel.dribir1 <> "" THEN DO:
                        nv_dd = INTE(SUBSTR(wexcel.dribir1,1,2)).
                        nv_mm = INTE(SUBSTR(wexcel.dribir1,4,2)).
                        nv_yy = INTE(SUBSTR(wexcel.dribir1,7,4)).

                        IF nv_yy > YEAR(TODAY) THEN DO:
                            nv_yy = nv_yy - 543.
                        END.

                        brstat.mailtxt_fil.drivbirth = DATE(nv_mm,nv_dd,nv_yy).
                    END.

                    IF YEAR(TODAY) < YEAR(DATE(wexcel.dribir1)) THEN DO:
                        nv_dribir1      = STRING(INT(SUBSTR(wexcel.dribir1,7,4))).
                        wexcel.dribir1  = SUBSTR(wexcel.dribir1,1,6) + nv_dribir1.
                    END.
                    ELSE DO:
                        nv_dribir1      = STRING(INT(SUBSTR(wexcel.dribir1,7,4)) + 543).
                        wexcel.dribir1  = SUBSTR(wexcel.dribir1,1,6) + nv_dribir1.
                    END.

                    brstat.mailtxt_fil.ltext2 = wexcel.dribir1 + "  " + STRING(nv_age1).
                    SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-".
                END.
            END.
            ELSE IF nv_lnumber = 2 THEN DO:
                IF wexcel.drinam2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil.
                    ASSIGN
                        brstat.mailtxt_fil.policy    = nv_mailpol
                        brstat.mailtxt_fil.bchyr     = nv_batchyr 
                        brstat.mailtxt_fil.bchno     = nv_batchno 
                        brstat.mailtxt_fil.bchcnt    = nv_batcnt
                        brstat.mailtxt_fil.lnumber   = nv_lnumber
                        brstat.mailtxt_fil.ltext     = wexcel.drinam2 + FILL(" ",50 - LENGTH(wexcel.drinam2))
                        brstat.mailtxt_fil.drivage   = nv_age2
                        brstat.mailtxt_fil.drivlevel = nv_levcod
                        brstat.mailtxt_fil.levelper  = nv_levper
                        brstat.mailtxt_fil.titlenam  = ""
                        brstat.mailtxt_fil.firstnam  = TRIM(wexcel.drinam2)
                        brstat.mailtxt_fil.lastnam   = ""
                        brstat.mailtxt_fil.occupcod  = ""
                        brstat.mailtxt_fil.occupdes  = "-"
                        brstat.mailtxt_fil.licenno   = "-"
                        brstat.mailtxt_fil.drividno  = "-".

                    IF wexcel.dribir2 <> "" THEN DO:
                        nv_dd = INTE(SUBSTR(wexcel.dribir2,1,2)).
                        nv_mm = INTE(SUBSTR(wexcel.dribir2,4,2)).
                        nv_yy = INTE(SUBSTR(wexcel.dribir2,7,4)).

                        IF nv_yy > YEAR(TODAY) THEN DO:
                            nv_yy = nv_yy - 543.
                        END.

                        brstat.mailtxt_fil.drivbirth = DATE(nv_mm,nv_dd,nv_yy).
                    END.

                    IF YEAR(TODAY) < YEAR(DATE(wexcel.dribir2)) THEN DO:
                        nv_dribir2      = STRING(INT(SUBSTR(wexcel.dribir2,7,4))).
                        wexcel.dribir2  = SUBSTR(wexcel.dribir2,1,6) + nv_dribir2.
                    END.
                    ELSE DO:
                        nv_dribir2      = STRING(INT(SUBSTR(wexcel.dribir2,7,4)) + 543).
                        wexcel.dribir2  = SUBSTR(wexcel.dribir2,1,6) + nv_dribir2.
                    END.

                    brstat.mailtxt_fil.ltext2 = wexcel.dribir2 + "  " + STRING(nv_age2).
                    SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-".
                END.
            END.
            ELSE IF nv_lnumber = 3 THEN DO:
                IF wexcel.drinam3 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil.
                    ASSIGN
                        brstat.mailtxt_fil.policy    = nv_mailpol
                        brstat.mailtxt_fil.bchyr     = nv_batchyr 
                        brstat.mailtxt_fil.bchno     = nv_batchno 
                        brstat.mailtxt_fil.bchcnt    = nv_batcnt
                        brstat.mailtxt_fil.lnumber   = nv_lnumber
                        brstat.mailtxt_fil.ltext     = wexcel.drinam3 + FILL(" ",50 - LENGTH(wexcel.drinam3))
                        brstat.mailtxt_fil.drivage   = nv_age3
                        brstat.mailtxt_fil.drivlevel = nv_levcod
                        brstat.mailtxt_fil.levelper  = nv_levper
                        brstat.mailtxt_fil.titlenam  = ""
                        brstat.mailtxt_fil.firstnam  = TRIM(wexcel.drinam3)
                        brstat.mailtxt_fil.lastnam   = ""
                        brstat.mailtxt_fil.occupcod  = ""
                        brstat.mailtxt_fil.occupdes  = "-"
                        brstat.mailtxt_fil.licenno   = "-"
                        brstat.mailtxt_fil.drividno  = "-".

                    IF wexcel.dribir3 <> "" THEN DO:
                        nv_dd = INTE(SUBSTR(wexcel.dribir3,1,2)).
                        nv_mm = INTE(SUBSTR(wexcel.dribir3,4,2)).
                        nv_yy = INTE(SUBSTR(wexcel.dribir3,7,4)).

                        IF nv_yy > YEAR(TODAY) THEN DO:
                            nv_yy = nv_yy - 543.
                        END.

                        brstat.mailtxt_fil.drivbirth = DATE(nv_mm,nv_dd,nv_yy).
                    END.

                    IF YEAR(TODAY) < YEAR(DATE(wexcel.dribir3)) THEN DO:
                        nv_dribir3     = STRING(INT(SUBSTR(wexcel.dribir3,7,4))).
                        wexcel.dribir3  = SUBSTR(wexcel.dribir3,1,6) + nv_dribir3.
                    END.
                    ELSE DO:
                        nv_dribir3      = STRING(INT(SUBSTR(wexcel.dribir3,7,4)) + 543).
                        wexcel.dribir3  = SUBSTR(wexcel.dribir3,1,6) + nv_dribir3.
                    END.

                    brstat.mailtxt_fil.ltext2 = wexcel.dribir3 + "  " + STRING(nv_age3).
                    SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-".
                END.
            END.
            ELSE IF nv_lnumber = 4 THEN DO:
                IF wexcel.drinam4 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil.
                    ASSIGN
                        brstat.mailtxt_fil.policy    = nv_mailpol
                        brstat.mailtxt_fil.bchyr     = nv_batchyr 
                        brstat.mailtxt_fil.bchno     = nv_batchno 
                        brstat.mailtxt_fil.bchcnt    = nv_batcnt
                        brstat.mailtxt_fil.lnumber   = nv_lnumber
                        brstat.mailtxt_fil.ltext     = wexcel.drinam4 + FILL(" ",50 - LENGTH(wexcel.drinam4))
                        brstat.mailtxt_fil.drivage   = nv_age4
                        brstat.mailtxt_fil.drivlevel = nv_levcod
                        brstat.mailtxt_fil.levelper  = nv_levper
                        brstat.mailtxt_fil.titlenam  = ""
                        brstat.mailtxt_fil.firstnam  = TRIM(wexcel.drinam4)
                        brstat.mailtxt_fil.lastnam   = ""
                        brstat.mailtxt_fil.occupcod  = ""
                        brstat.mailtxt_fil.occupdes  = "-"
                        brstat.mailtxt_fil.licenno   = "-"
                        brstat.mailtxt_fil.drividno  = "-".

                    IF wexcel.dribir4 <> "" THEN DO:
                        nv_dd = INTE(SUBSTR(wexcel.dribir4,1,2)).
                        nv_mm = INTE(SUBSTR(wexcel.dribir4,4,2)).
                        nv_yy = INTE(SUBSTR(wexcel.dribir4,7,4)).

                        IF nv_yy > YEAR(TODAY) THEN DO:
                            nv_yy = nv_yy - 543.
                        END.

                        brstat.mailtxt_fil.drivbirth = DATE(nv_mm,nv_dd,nv_yy).
                    END.

                    IF YEAR(TODAY) < YEAR(DATE(wexcel.dribir4)) THEN DO:
                        nv_dribir4     = STRING(INT(SUBSTR(wexcel.dribir4,7,4))).
                        wexcel.dribir4  = SUBSTR(wexcel.dribir4,1,6) + nv_dribir4.
                    END.
                    ELSE DO:
                        nv_dribir4      = STRING(INT(SUBSTR(wexcel.dribir4,7,4)) + 543).
                        wexcel.dribir4  = SUBSTR(wexcel.dribir4,1,6) + nv_dribir4.
                    END.

                    brstat.mailtxt_fil.ltext2 = wexcel.dribir4 + "  " + STRING(nv_age4).
                    SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-".
                END.
            END.
            ELSE IF nv_lnumber = 5 THEN DO:
                IF wexcel.drinam5 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil.
                    ASSIGN
                        brstat.mailtxt_fil.policy    = nv_mailpol
                        brstat.mailtxt_fil.bchyr     = nv_batchyr 
                        brstat.mailtxt_fil.bchno     = nv_batchno 
                        brstat.mailtxt_fil.bchcnt    = nv_batcnt
                        brstat.mailtxt_fil.lnumber   = nv_lnumber
                        brstat.mailtxt_fil.ltext     = wexcel.drinam5 + FILL(" ",50 - LENGTH(wexcel.drinam5))
                        brstat.mailtxt_fil.drivage   = nv_age5
                        brstat.mailtxt_fil.drivlevel = nv_levcod
                        brstat.mailtxt_fil.levelper  = nv_levper
                        brstat.mailtxt_fil.titlenam  = ""
                        brstat.mailtxt_fil.firstnam  = TRIM(wexcel.drinam5)
                        brstat.mailtxt_fil.lastnam   = ""
                        brstat.mailtxt_fil.occupcod  = ""
                        brstat.mailtxt_fil.occupdes  = "-"
                        brstat.mailtxt_fil.licenno   = "-"
                        brstat.mailtxt_fil.drividno  = "-".

                    IF wexcel.dribir5 <> "" THEN DO:
                        nv_dd = INTE(SUBSTR(wexcel.dribir5,1,2)).
                        nv_mm = INTE(SUBSTR(wexcel.dribir5,4,2)).
                        nv_yy = INTE(SUBSTR(wexcel.dribir5,7,4)).

                        IF nv_yy > YEAR(TODAY) THEN DO:
                            nv_yy = nv_yy - 543.
                        END.

                        brstat.mailtxt_fil.drivbirth = DATE(nv_mm,nv_dd,nv_yy).
                    END.

                    IF YEAR(TODAY) < YEAR(DATE(wexcel.dribir5)) THEN DO:
                        nv_dribir5     = STRING(INT(SUBSTR(wexcel.dribir5,7,4))).
                        wexcel.dribir5  = SUBSTR(wexcel.dribir5,1,6) + nv_dribir5.
                    END.
                    ELSE DO:
                        nv_dribir5      = STRING(INT(SUBSTR(wexcel.dribir5,7,4)) + 543).
                        wexcel.dribir5  = SUBSTR(wexcel.dribir5,1,6) + nv_dribir5.
                    END.

                    brstat.mailtxt_fil.ltext2 = wexcel.dribir5 + "  " + STRING(nv_age5).
                    SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-".
                END.
            END.
        END.

        nv_lnumber = nv_lnumber + 1.
        IF nv_lnumber > nv_drivno OR nv_lnumber > 5 THEN LEAVE loop_mail.
    END.  /*REPEAT*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDGenV70 C-Win 
PROCEDURE PDGenV70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wexcel:
    DELETE wexcel.
END.

nt_count_pol = 0.
INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.newpol
        wexcel.trndat   
        wexcel.comins   
        wexcel.cedpol   
        wexcel.ntitle   
        wexcel.fname    
        wexcel.lname    
        wexcel.icno   
        wexcel.modcod
        wexcel.makdes   
        wexcel.moddes   
        wexcel.sclass   
        wexcel.garage   
        wexcel.vehreg   
        wexcel.provin   
        wexcel.cha_no   
        wexcel.eng_no   
        wexcel.engine   
        wexcel.gwv      
        wexcel.body     
        wexcel.yrmanu   
        wexcel.addr1    
        wexcel.addr2    
        wexcel.addr3    
        wexcel.addr4    
        wexcel.postcod  
        wexcel.driname   
        wexcel.drinam1  
        wexcel.drino1   
        wexcel.dribir1  
        wexcel.drinam2  
        wexcel.drino2   
        wexcel.dribir2  
        wexcel.si       
        wexcel.covcod   
        wexcel.comdat   
        wexcel.expdat   
        wexcel.netprm   
        wexcel.tax      
        wexcel.vat      
        wexcel.totprm   
        wexcel.bennam   
        wexcel.brncod   
        wexcel.brnnam   
        wexcel.baddr1   
        wexcel.baddr2   
        wexcel.baddr3   
        wexcel.baddr4   
        wexcel.bpostcod 
        wexcel.isp    /*---add by Chaiyong W. A59-0614 15/12/2016*/
        wexcel.f7   /*---add by Chaiyong W. A60-0016 15/01/2018*/
        wexcel.f8   /*---add by Chaiyong W. A60-0016 15/01/2018*/
        wexcel.instyp   
        wexcel.custyp   
        wexcel.quotyp
        wexcel.paycod  /*---add by Chaiyong W. A59-0614 15/12/2016*/
        wexcel.campaign

        wexcel.prvpol    /*---add by Chaiyong W. A59-0614 15/12/2016*/
        wexcel.oldexpdat /*---add by Chaiyong W. A59-0614 15/12/2016*/
        wexcel.oldname   /*---add by Chaiyong W. A59-0614 15/12/2017*/
        wexcel.oldacno   /*---add by Chaiyong W. A59-0614 15/12/2016*/
        wexcel.acnocode /*---add by Chaiyong W. A59-0614 15/12/2016*/
        wexcel.tacc1    /*---add by Chaiyong W. A59-0614 15/12/2016*/    
        wexcel.tacc2    /*---add by Chaiyong W. A59-0614 15/12/2016*/    
        wexcel.tacc3    /*---add by Chaiyong W. A59-0614 15/12/2017*/    
        wexcel.tacc4    /*---add by Chaiyong W. A59-0614 15/12/2016*/    
        wexcel.tacc5 .  /*---add by Chaiyong W. A59-0614 15/12/2016*/     
                                                                        
    IF wexcel.newpol = " " THEN DELETE wexcel. /*A65-0203*/
    ELSE DO: /*A65-0203*/
        /*---Begin by Chaiyong W. A59-0614 15/12/2016*/
        wexcel.cha_no   = TRIM(wexcel.cha_no).
        wexcel.instyp   = trim(wexcel.instyp).   
        wexcel.custyp   = trim(wexcel.custyp). 
        wexcel.campaign = TRIM(wexcel.campaign).
        /*End by Chaiyong W. A59-0614 15/12/2016-----*/
        IF wexcel.cedpol <> "" AND index(wexcel.cedpol,"Reference") = 0 THEN nt_count_pol = nt_count_pol + 1.
        
        /*IF wexcel.campaign = "" THEN wexcel.campaign = TRIM(fi_campaign).*/ /*A65-0203*/
        
        /*--
        IF wexcel.instyp = "NEW" THEN DO:
            ASSIGN
                wexcel.agent  = "B3M0040"
                wexcel.broker = "B3M0040".
        END.
        /*ELSE IF wexcel.instyp = "RENEW" THEN DO:
            ASSIGN
                wexcel.agent  = "B3M0040"
                wexcel.broker = "B3M0041".
        END.*/
        ELSE DO:
            ASSIGN
                wexcel.agent  = fi_agent
                wexcel.broker = fi_producer.
        END.
        comment by Chaiyong W. A59-0614 18/04/2017*/
        /*---Begin by Chaiyong W. A59-0614 15/12/2017*/
        /*wexcel.agent  = "B3M0040". */   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        wexcel.agent  = "B3MLNTL100".     /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        
        wexcel.acnocode = TRIM(wexcel.acnocode).
        IF wexcel.acnocode <> "" THEN DO:
            wexcel.broker = wexcel.acnocode.
        END.
        ELSE DO:
            ASSIGN
                wexcel.quotyp = TRIM(wexcel.quotyp)
                wexcel.paycod = TRIM(wexcel.paycod).
                
            IF wexcel.paycod = "CS" THEN DO:
                /*wexcel.broker = "B3M0042". */      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
                wexcel.broker = "B3MLNTL104".        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
            END.
            ELSE IF wexcel.paycod = "CL" THEN DO:
                /*wexcel.broker = "B3M0047". */      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/      
                wexcel.broker = "B3MLNTL103".        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/      
            END.
            ELSE DO:
                IF wexcel.quotyp = "R" THEN DO:
                    /*wexcel.broker = "B3M0041". */  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
                    wexcel.broker = "B3MLNTL102".    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
                END.
                ELSE DO:
                    /*wexcel.broker = "B3M0040". */  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
                    wexcel.broker = "B3MLNTL101".    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
                END.
            END.
        END.
         IF      wexcel.broker = "B3M0042" THEN wexcel.broker = "B3MLNTL104".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
         ELSE IF wexcel.broker = "B3M0047" THEN wexcel.broker = "B3MLNTL103".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/      
         ELSE IF wexcel.broker = "B3M0041" THEN wexcel.broker = "B3MLNTL102".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
         ELSE IF wexcel.broker = "B3M0040" THEN wexcel.broker = "B3MLNTL101".  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        
        ASSIGN
            wexcel.prvpol    = TRIM(wexcel.prvpol )
            wexcel.oldacno   = TRIM(wexcel.oldacno).
        IF wexcel.prvpol <> "" THEN DO:
            
            IF wexcel.oldacno = "B3M0040"    OR
               wexcel.oldacno = "B3M0041"    OR
               wexcel.oldacno = "B3M0042"    OR
               wexcel.oldacno = "B3M0047"    OR 
               wexcel.oldacno = "B3MLNTL101" OR
               wexcel.oldacno = "B3MLNTL102" OR
               wexcel.oldacno = "B3MLNTL104" OR
               wexcel.oldacno = "B3MLNTL103" THEN DO:
            END.
            ELSE DO:
                wexcel.prvpol = "".
            END.
        END.
    /*End by Chaiyong W. A59-0614 15/12/2017-----*/
    END. /* A65-0203 */
    fi_display = "Please wait..Process Input Data...".
    DISP fi_display WITH FRAME fr_main.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDGenV70New C-Win 
PROCEDURE PDGenV70New :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add BY Porntiwa T.  A67-0029  31/05/2025       
------------------------------------------------------------------------------*/

FOR EACH wexcel:
    DELETE wexcel.
END.

nt_count_pol = 0.
INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.newpol                 /*New Policy No.      */    
        wexcel.trndat                 /*Transfer_Date       */    
        wexcel.comins                 /*Company_INS         */    
        wexcel.cedpol                 /*Reference_no        */    
        wexcel.ntitle                 /*Title               */    
        wexcel.fname                  /*Name                */    
        wexcel.lname                  /*Surname             */    
        wexcel.icno                   /*ID_no               */    
        wexcel.bridat                 /*Birth_Date          */    
        wexcel.modcod                 /*Model Code          */    
        wexcel.makdes                 /*Brand_of_Auto       */    
        wexcel.moddes                 /*Model               */    
        wexcel.sclass                 /*PropertiesCode      */    
        wexcel.garage                 /*MaintenanceType     */    
        wexcel.vehreg                 /*License_No          */    
        wexcel.provin                 /*Province_Code       */    
        wexcel.cha_no                 /*Chassis_No          */    
        wexcel.eng_no                 /*Engine_No           */    
        wexcel.engine                 /*CC_GVW              */    
        wexcel.gwv                    /*Weight_GVW          */    
        wexcel.body                   /*Body_Type           */    
        wexcel.yrmanu                 /*Model_Year          */    
        wexcel.addr1                  /*Asset_Location      */    
        wexcel.addr2                  /*Asset_District      */    
        wexcel.addr3                  /*Asset_Zone          */    
        wexcel.addr4                  /*Asset_Province      */    
        wexcel.postcod                /*ZipCode             */    
        wexcel.driname                /*Driver Type         */    
        wexcel.drinam1                /*Driver1_Name        */    
        wexcel.drino1                 /*Driver1 _ License No*/    
        wexcel.dribir1                /*Driver1_Birth Date  */    
        wexcel.drinam2                /*Driver2_Name        */    
        wexcel.drino2                 /*Driver2_License No  */    
        wexcel.dribir2                /*Driver2_Birth Date  */    
        wexcel.drinam3                /*Driver3_Name        */    
        wexcel.drino3                 /*Driver3_License No  */    
        wexcel.dribir3                /*Driver3_Birth Date  */    
        wexcel.drinam4                /*Driver4_Name        */    
        wexcel.drino4                 /*Driver4_License No  */    
        wexcel.dribir4                /*Driver4_Birth Date  */    
        wexcel.drinam5                /*Driver5_Name        */    
        wexcel.drino5                 /*Driver5_License No  */    
        wexcel.dribir5                /*Driver5_Birth Date  */    
        wexcel.si                     /*Sum_Insure_Amt      */    
        wexcel.dedpd                  /*Deductible_PD       */    
        wexcel.dedtp                  /*Deductible_TP       */    
        wexcel.covcod                 /*Type_of_Policy      */    
        wexcel.comdat                 /*Effective_date      */    
        wexcel.expdat                 /*Expirty_Date        */    
        wexcel.netprm                 /*Net_Premium         */    
        wexcel.tax                    /*Tax                 */    
        wexcel.vat                    /*Duty                */    
        wexcel.totprm                 /*Total_Premium       */    
        wexcel.bennam                 /*Beneficiary_Surname */    
        wexcel.brncod                 /*Branch_Code         */    
        wexcel.brnnam                 /*Branch_Name_Thai    */    
        wexcel.btitle                 /*Mailing_Title       */    
        wexcel.bfname                 /*Mailing_Name        */    
        wexcel.blname                 /*Mailing_Surname     */    
        wexcel.baddr1                 /*Mailing_Address     */    
        wexcel.baddr2                 /*Mailing_District    */    
        wexcel.baddr3                 /*Mailing_Zone        */    
        wexcel.baddr4                 /*Mailing_Province    */    
        wexcel.bpostcod               /*Mailing_ZipCode     */    
        wexcel.instyp                 /*Transaction_Type    */    
        wexcel.custyp                 /*Customer_Type       */    
        wexcel.prmtyp                 /*Premium_Type        */    
        wexcel.quotyp                 /*Quote_Type          */    
        wexcel.paycod                 /*Payment_Type        */    
        wexcel.campaign               /*Remark_Coverage     */    
        wexcel.budcmi                 /*Bundle_CMI          */    
        wexcel.cmicdat                /*CMI_Effective_Date  */    
        wexcel.cmiedat                /*CMI_Expirty_Date    */    
        wexcel.cmiprm                 /*CMI_Total           */    
        wexcel.carcol                 /*Car_Color           */    
        wexcel.pacref                 /*Package_Refer       */    
        wexcel.isp                    /*Inspection No.      */    
        wexcel.f7                     /*Text F7             */    
        wexcel.f8                     /*Text F8             */    
        wexcel.prvpol                 /*Prev.Policy         */    
        wexcel.oldexpdat              /*Old Expiry Date     */    
        wexcel.oldname                /*Old Insure Name     */    
        wexcel.oldacno                /*Old Account         */    
        wexcel.acnocode               /*Account Code        */    
        wexcel.tacc1                  /*Accessory Text1     */    
        wexcel.tacc2                  /*Accessory Text2     */    
        wexcel.tacc3                  /*Accessory Text3     */    
        wexcel.tacc4                  /*Accessory Text4     */    
        wexcel.tacc5                  /*Accessory5          */    
        wexcel.modelRB                /*Model Code RB       */    
        wexcel.vehgrp                 /*Vehicle Group       */    
        wexcel.prmexp                 /*Premium Expiry      */    
        wexcel.cha_old                /*Old Chassis No      */    
        wexcel.remark                 /*Remark              */    
        wexcel.insnamtyp              /*ความเสียหายทั้งสิ้น */    
        wexcel.campaign_ov            /*รายละเอียด          */    
        .
                                                                  
    IF wexcel.newpol = " " THEN DELETE wexcel. 
    ELSE DO: 
        wexcel.cha_no   = TRIM(wexcel.cha_no).
        wexcel.instyp   = trim(wexcel.instyp).   
        wexcel.custyp   = trim(wexcel.custyp). 
        wexcel.campaign = TRIM(wexcel.campaign).
   
        IF wexcel.cedpol <> "" AND index(wexcel.cedpol,"Reference") = 0 THEN nt_count_pol = nt_count_pol + 1.

        IF INDEX(wexcel.sclass,"E11") <> 0 THEN DO: 
            nv_levcod = 1.
        END.

        nv_class = "T" + TRIM(wexcel.sclass).
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
             sicsyac.xmm016.CLASS =  nv_class  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm016 THEN DO:
            wexcel.evflg = sicsyac.xmm016.evflg.
        END.

        IF wexcel.evflg = YES THEN DO:
            ASSIGN
                nv_si_mv     = 0                    nv_battno    = "" 
                nv_eng_no2   = ""                   nv_battflg   = "N"
                nv_battper   = 0                    nv_chargno   = "" 
                nv_battyr    = INTE(wexcel.yrmanu)  nv_chargsi   = 0  
                nv_battprice = 0                    nv_chargflg  = "N"
                nv_battsi    = 0.

            nv_comdat  = DATE(wexcel.comdat).
            nv_ckbatyr = (YEAR(nv_comdat) - nv_battyr) + 1.
            FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE 
                       sicsyac.xmm106.tariff  = "X"        AND
                       sicsyac.xmm106.bencod  = "CBAT"     AND
                       sicsyac.xmm106.CLASS   = ""         AND
                       sicsyac.xmm106.covcod  = ""         AND
                       sicsyac.xmm106.KEY_a   = 0          AND
                       sicsyac.xmm106.KEY_b  >= nv_ckbatyr AND
                       sicsyac.xmm106.effdat <= nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm106 THEN DO:
                nv_battper = sicsyac.xmm106.appinc.
            END.
        END.

        FIND FIRST stat.clastab_fil USE-INDEX clastab02 WHERE
                   stat.clastab_fil.CLASS = nv_class    NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.clastab_fil THEN DO:

            wexcel.seat = STRING(clastab_fil.dri_41 + clastab_fil.pass_41).

            IF stat.clastab_fil.unit = "C" THEN DO:
                IF LENGTH(nv_class) > 4 AND SUBSTR(nv_class,4,1) = "E" THEN DO:
                    wexcel.fcst = "W".
                END.
                ELSE wexcel.fcst = "C".
                wexcel.cstw = DECI(wexcel.engine).
            END.
            ELSE IF stat.clastab_fil.unit = "S" THEN DO:
                wexcel.fcst = "S".
                wexcel.cstw = INTE(wexcel.seat).
            END.
            ELSE IF stat.clastab_fil.unit = "T" THEN DO:
                wexcel.fcst = "T".
                wexcel.cstw = DECI(wexcel.gwv).
            END.
            ELSE IF stat.clastab_fil.unit = "H" THEN DO:
                wexcel.fcst = "H".
                wexcel.cstw = DECI(wexcel.engine).
            END. 
        END.

        IF wexcel.carcol = "ไม่ระบุ" THEN DO:
            wexcel.carcol = "".
        END.
        
        IF wexcel.carcol <> "" THEN DO:
            FIND sicsyac.sym100 WHERE
                 sicsyac.sym100.tabcod = "U118"        AND
                 sicsyac.sym100.itmdes = wexcel.carcol NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.sym100 THEN DO:
                wexcel.carcol = sicsyac.sym100.itmcod.
            END.
            ELSE wexcel.carcol = "99999".
        END.

        wexcel.agent  = "B3MLNTL100".  
        
        wexcel.acnocode = TRIM(wexcel.acnocode).
        IF wexcel.acnocode <> "" THEN DO:
            wexcel.broker = wexcel.acnocode.
        END.
        ELSE DO:
            ASSIGN
                wexcel.quotyp = TRIM(wexcel.quotyp)
                wexcel.paycod = TRIM(wexcel.paycod).
                
            IF wexcel.paycod = "CS" THEN DO:
                wexcel.broker = "B3MLNTL104".        
            END.
            ELSE IF wexcel.paycod = "CL" THEN DO:    
                wexcel.broker = "B3MLNTL103".       
            END.
            ELSE DO:
                IF wexcel.quotyp = "R" THEN DO: 
                    wexcel.broker = "B3MLNTL102".   
                END.
                ELSE DO:
                    wexcel.broker = "B3MLNTL101".   
                END.
            END.
        END.
         IF      wexcel.broker = "B3M0042" THEN wexcel.broker = "B3MLNTL104". 
         ELSE IF wexcel.broker = "B3M0047" THEN wexcel.broker = "B3MLNTL103". 
         ELSE IF wexcel.broker = "B3M0041" THEN wexcel.broker = "B3MLNTL102". 
         ELSE IF wexcel.broker = "B3M0040" THEN wexcel.broker = "B3MLNTL101". 
        
        ASSIGN
            wexcel.prvpol    = TRIM(wexcel.prvpol )
            wexcel.oldacno   = TRIM(wexcel.oldacno).
        IF wexcel.prvpol <> "" THEN DO:
            
            IF wexcel.oldacno = "B3M0040"    OR
               wexcel.oldacno = "B3M0041"    OR
               wexcel.oldacno = "B3M0042"    OR
               wexcel.oldacno = "B3M0047"    OR 
               wexcel.oldacno = "B3MLNTL101" OR
               wexcel.oldacno = "B3MLNTL102" OR
               wexcel.oldacno = "B3MLNTL104" OR
               wexcel.oldacno = "B3MLNTL103" THEN DO:
            END.
            ELSE DO:
                wexcel.prvpol = "".
            END.
        END.
    END. 
    fi_display = "Please wait..Process Input Data...".
    DISP fi_display WITH FRAME fr_main.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDOutputScreen C-Win 
PROCEDURE PDOutputScreen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OUTPUT STREAM ns3 TO VALUE(fi_output3).
PUT STREAM ns3
" LOAD TEXT FILE NTL (V70) " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer   SKIP
"          Agent Code : " fi_agent      SKIP
"  Previous Batch No. : " fi_prevbat   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"    Output Data Load : " fi_output1    SKIP
"Output Data Not Load : " fi_output1    SKIP
"     Batch File Name : " fi_output1    SKIP
" policy Import Total : " fi_usrcnt    "Total Net Premium Imp : " fi_usrprem " BHT." SKIP
SKIP
SKIP
SKIP
"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP
"Batch No. : " fi_bchno SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.                 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDRunInsNo C-Win 
PROCEDURE PDRunInsNo :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_lastno   AS INT. 
DEF VAR nv_seqno    AS INT.
DEF VAR n_search    AS LOGICAL.  

n_search = YES.

nv_branch = sic_bran.uwm100.branch.

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
          sicsyac.xzm056.seqtyp = nv_typ    AND
          sicsyac.xzm056.branch = nv_branch NO-LOCK NO-ERROR.
IF NOT AVAIL xzm056 THEN DO:
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp   =  nv_typ
            sicsyac.xzm056.branch   =  nv_branch
            sicsyac.xzm056.des      =  "Personal/Start"
            sicsyac.xzm056.lastno   =  1.     
    END.
    ELSE DO:
        ASSIGN
            nv_insref  =    nv_branch + STRING(1,"999999").
            nv_lastno  =    1.
        RETURN.
    END.
END.

/*-- Create Running Insure --*/
ASSIGN
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno.

IF n_check = "YES" THEN DO:
    IF nv_typ = "0S" THEN DO:
        IF LENGTH(TRIM(nv_branch)) = 1 THEN DO:
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    nv_insref = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO: 
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    nv_insref = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =      nv_branch + STRING(sicsyac.xzm056.lastno,"999999").
            END.
        END.
        ELSE  nv_insref = nv_branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").

        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  nv_branch 
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(TRIM(nv_branch)) = 1 THEN DO:
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
               IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                   nv_insref = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
               END.
               ELSE nv_insref = "0" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
           END.
           ELSE DO:
               IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                   nv_insref = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
               END.
               ELSE nv_insref =      nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
           END.
        END.
        ELSE nv_insref = nv_branch + "C" + STRING(sicsyac.xzm056.lastno + 1 ,"9999999").

        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  nv_branch
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF LENGTH(TRIM(nv_branch)) = 1 THEN DO:
        IF nv_typ = "0s" THEN DO:
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    nv_insref = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO: 
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    nv_insref = "7" + nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =      nv_branch + STRING(sicsyac.xzm056.lastno,"999999").
            END.
        END.
        ELSE IF nv_typ = "Cs" THEN DO:
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    nv_insref = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF nv_branch = "A" OR nv_branch = "B" THEN DO:
                    nv_insref = "7" + nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =      nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.
        END.
    END.
    ELSE DO:
        IF      nv_typ = "0s" THEN nv_insref = nv_branch + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE IF nv_typ = "Cs" THEN nv_insref = nv_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
    END.
END.

IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno THEN DO :
  MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
           "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
           "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. 
  n_check = "ERROR".
  RETURN.                
END. /*lastno > seqno*/                       
ELSE DO :   /*lastno <= seqno */
   IF nv_typ = "0s" THEN DO:
       IF n_search = YES THEN DO:
           CREATE sicsyac.xzm056.
           ASSIGN
                 sicsyac.xzm056.seqtyp    =  nv_typ
                 sicsyac.xzm056.branch    =  nv_branch
                 sicsyac.xzm056.des       =  "Personal/Start"
                 sicsyac.xzm056.lastno    =  nv_lastno + 1
                 sicsyac.xzm056.seqno     =  nv_seqno.   
       END.
   END.
   ELSE IF nv_typ = "Cs" THEN DO:
       IF n_search = YES THEN DO:
           CREATE sicsyac.xzm056.
           ASSIGN
                 sicsyac.xzm056.seqtyp    =  nv_typ
                 sicsyac.xzm056.branch    =  nv_branch 
                 sicsyac.xzm056.des       =  "Company/Start"
                 sicsyac.xzm056.lastno    =  nv_lastno + 1
                 sicsyac.xzm056.seqno     =  nv_seqno. 
       END.
   END.  

END.   /*lastno <= seqno */ 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDShowReport C-Win 
PROCEDURE PDShowReport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
nv_row  =  1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.

FOR EACH wexcel NO-LOCK:
    IF wexcel.wmark = NO THEN NOT_pass = NOT_pass + 1.
    ELSE pass = pass + 1.
END.

IF pass > 0 THEN DO:
    OUTPUT STREAM ns1 TO VALUE(fi_output1).
    PUT STREAM ns1
        "Policy"       ","
        "branch"       ","
        "Chassis"      "," 
        "Vehicle Reg." ","
        "Comment"
    SKIP.

    FOR EACH wexcel WHERE wexcel.wmark = YES NO-LOCK:
        PUT STREAM ns1
            /*wexcel.policy  FORMAT "X(12)"  ","*/ /* a65-0203*/
            wexcel.newpol  FORMAT "X(12)"  ","  /* a65-0203*/
            wexcel.brnsty  FORMAT "X(10)"  ","
            wexcel.cha_no  FORMAT "X(30)"  ","
            wexcel.vehreg  FORMAT "X(12)"  ","
            wexcel.werror  FORMAT "X(255)" /*---add format by chaiyong W. A59-0614 04/05/2017*/
        SKIP.
    END.

    OUTPUT STREAM ns1 CLOSE. 
END.

IF NOT_pass > 0 THEN DO:

    OUTPUT STREAM ns2 TO VALUE(fi_output2).
    PUT STREAM ns2
        "Policy"       ","
        "branch"       ","
        "Chassis"      "," 
        "Vehicle Reg." ","
        "Comment"
    SKIP.

    FOR EACH wexcel WHERE wexcel.wmark = NO NO-LOCK:
        PUT STREAM ns2
            /*wexcel.policy  FORMAT "X(12)"  ","*/ /* a65-0203*/
            wexcel.newpol  FORMAT "X(12)"  ","  /* a65-0203*/
            wexcel.brnsty  FORMAT "X(10)"  ","
            wexcel.cha_no  FORMAT "X(30)"   ","
            wexcel.vehreg  FORMAT "X(12)"   ","
            wexcel.werror  FORMAT "x(255)" 
        SKIP.
    END.

    OUTPUT STREAM ns2 CLOSE. 
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDShowReportNew C-Win 
PROCEDURE PDShowReportNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
nv_row  =  1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.

FOR EACH wexcel NO-LOCK:
    IF wexcel.wmark = NO THEN NOT_pass = NOT_pass + 1.
    ELSE pass = pass + 1.
END.

IF NOT_pass > 0 THEN DO:

    OUTPUT STREAM ns2 TO VALUE(fi_output2).
    PUT STREAM ns2
        "Policy"       ","
        "branch"       ","
        "Chassis"      "," 
        "Vehicle Reg." ","
        "Comment"
    SKIP.

    FOR EACH wexcel WHERE wexcel.wmark = NO NO-LOCK:
        PUT STREAM ns2
            /*wexcel.policy  FORMAT "X(12)"  ","*/ /* a65-0203*/
            wexcel.newpol  FORMAT "X(12)"  ","  /* a65-0203*/
            wexcel.brnsty  FORMAT "X(10)"  ","
            wexcel.cha_no  FORMAT "X(30)"   ","
            wexcel.vehreg  FORMAT "X(12)"   ","
            wexcel.werror  FORMAT "x(255)" 
        SKIP.
    END.

    OUTPUT STREAM ns2 CLOSE. 
END.

/*IF pass > 0 THEN DO:*/
    OUTPUT TO VALUE(fi_output1).
    EXPORT DELIMITER "|"  
      "New Policy No.      "
      "Transfer_Date       "
      "Company_INS         "
      "Reference_no        "
      "Title               "
      "Name                "
      "Surname             "
      "ID_no               "
      "Birth_Date          "
      "Model Code          "
      "Brand_of_Auto       "
      "Model               "
      "PropertiesCode      "
      "MaintenanceType     "
      "License_No          "
      "Province_Code       "
      "Chassis_No          "
      "Engine_No           "
      "CC_GVW              "
      "Weight_GVW          "
      "Body_Type           "
      "Model_Year          "
      "Asset_Location      "
      "Asset_District      "
      "Asset_Zone          "
      "Asset_Province      "
      "ZipCode             "
      "Driver Type         "
      "Driver1_Name        "
      "Driver1 _ License No"
      "Driver1_Birth Date  "
      "Driver2_Name        "
      "Driver2_License No  "
      "Driver2_Birth Date  "
      "Driver3_Name        "
      "Driver3_License No  "
      "Driver3_Birth Date  "
      "Driver4_Name        "
      "Driver4_License No  "
      "Driver4_Birth Date  "
      "Driver5_Name        "
      "Driver5_License No  "
      "Driver5_Birth Date  "
      "Sum_Insure_Amt      "
      "Deductible_PD       "
      "Deductible_TP       "
      "Type_of_Policy      "
      "Effective_date      "
      "Expirty_Date        "
      "Net_Premium         "
      "Tax                 "
      "Duty                "
      "Total_Premium       "
      "Beneficiary_Surname "
      "Branch_Code         "
      "Branch_Name_Thai    "
      "Mailing_Title       "
      "Mailing_Name        "
      "Mailing_Surname     "
      "Mailing_Address     "
      "Mailing_District    "
      "Mailing_Zone        "
      "Mailing_Province    "
      "Mailing_ZipCode     "
      "Transaction_Type    "
      "Customer_Type       "
      "Premium_Type        "
      "Quote_Type          "
      "Payment_Type        "
      "Remark_Coverage     "
      "Bundle_CMI          "
      "CMI_Effective_Date  "
      "CMI_Expirty_Date    "
      "CMI_Total           "
      "Car_Color           "
      "Package_Refer       "
      "Inspection No.      "
      "Text F7             "
      "Text F8             "
      "Prev.Policy         "
      "Old Expiry Date     "
      "Old Insure Name     "
      "Old Account         "
      "Account Code        "
      "Accessory Text1     "
      "Accessory Text2     "
      "Accessory Text3     "
      "Accessory Text4     "
      "Accessory5          "
      "Model Code RB       "
      "Vehicle Group       "
      "Premium Expiry      "
      "Old Chassis No      "
      "Remark              "
      "จำนวนความเสียหายทั้งสิ้น"  /*A66-0069*/
      "รายละเอียด"                /*A66-0069*/
      "Status (Pass)"
      "Error Message"
        SKIP.

    FOR EACH wexcel  NO-LOCK:

       IF wexcel.cmicdat = ? THEN nv_cpcdat = "". ELSE nv_cpcdat = STRING(DAY(wexcel.cmicdat),"99") + "/" + STRING(MONTH(wexcel.cmicdat),"99") + "/" + STRING(YEAR(wexcel.cmicdat),"9999").
       IF wexcel.cmiedat = ? THEN nv_cpedat = "". ELSE nv_cpedat = STRING(DAY(wexcel.cmiedat),"99") + "/" + STRING(MONTH(wexcel.cmiedat),"99") + "/" + STRING(YEAR(wexcel.cmiedat),"9999").

       EXPORT DELIMITER "|"
           wexcel.newpol      
           wexcel.trndat      
           wexcel.comins      
           wexcel.cedpol      
           wexcel.ntitle      
           wexcel.fname       
           wexcel.lname       
           wexcel.icno        
           wexcel.bridat      
           wexcel.modcod      
           wexcel.makdes      
           wexcel.moddes      
           wexcel.sclass      
           wexcel.garage      
           wexcel.vehreg      
           wexcel.provin      
           wexcel.cha_no      
           wexcel.eng_no      
           wexcel.engine      
           wexcel.gwv         
           wexcel.body        
           wexcel.yrmanu      
           wexcel.addr1       
           wexcel.addr2       
           wexcel.addr3       
           wexcel.addr4       
           wexcel.postcod     
           wexcel.driname     
           wexcel.drinam1     
           wexcel.drino1      
           wexcel.dribir1     
           wexcel.drinam2     
           wexcel.drino2      
           wexcel.dribir2     
           wexcel.drinam3     
           wexcel.drino3      
           wexcel.dribir3     
           wexcel.drinam4     
           wexcel.drino4      
           wexcel.dribir4     
           wexcel.drinam5     
           wexcel.drino5      
           wexcel.dribir5     
           wexcel.si          
           wexcel.dedpd       
           wexcel.dedtp       
           wexcel.covcod      
           wexcel.comdat      
           wexcel.expdat      
           wexcel.netprm      
           wexcel.tax         
           wexcel.vat         
           wexcel.totprm      
           wexcel.bennam      
           wexcel.brncod      
           wexcel.brnnam      
           wexcel.btitle      
           wexcel.bfname      
           wexcel.blname      
           wexcel.baddr1      
           wexcel.baddr2      
           wexcel.baddr3      
           wexcel.baddr4      
           wexcel.bpostcod    
           wexcel.instyp      
           wexcel.custyp      
           wexcel.prmtyp      
           wexcel.quotyp      
           wexcel.paycod      
           wexcel.campaign    
           wexcel.budcmi      
           nv_cpcdat    
           nv_cpedat   
           wexcel.cmiprm      
           wexcel.carcol      
           wexcel.pacref      
           wexcel.isp         
           wexcel.f7          
           wexcel.f8          
           wexcel.prvpol      
           wexcel.oldexpdat   
           wexcel.oldname     
           wexcel.oldacno     
           wexcel.acnocode    
           wexcel.tacc1       
           wexcel.tacc2       
           wexcel.tacc3       
           wexcel.tacc4       
           wexcel.tacc5       
           wexcel.modelRB     
           wexcel.vehgrp      
           wexcel.prmexp      
           wexcel.cha_old     
           wexcel.remark      
           wexcel.insnamtyp   
           wexcel.campaign_ov   FORMAT "X(500)"
           wexcel.wmark
           wexcel.werror        FORMAT "x(255)"
        SKIP.
    END.
    OUTPUT CLOSE.
/*END.*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateUwm120 C-Win 
PROCEDURE PDUpdateUwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_display = "Update data uwm120 policy: " + wexcel.policy.
DISP fi_display WITH FRAME fr_main.

FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
         sic_bran.uwm120.policy = sic_bran.uwm100.policy AND
         sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwm120.bchyr  = sic_bran.uwm100.bchyr  AND
         sic_bran.uwm120.bchno  = sic_bran.uwm100.bchno  AND
         sic_bran.uwm120.bchcnt = sic_bran.uwm100.bchcnt :
    IF sic_bran.uwm120.riskno = 1 THEN DO:
        ASSIGN
            sic_bran.uwm120.com1_r = sic_bran.uwm100.com1_t
            sic_bran.uwm120.com1ae = YES
            sic_bran.uwm120.com2_r = sic_bran.uwm100.com2_t
            sic_bran.uwm120.com2ae = YES
            sic_bran.uwm120.rstp_r = sic_bran.uwm100.rstp_t
            sic_bran.uwm120.stmpae = YES
            sic_bran.uwm120.rtax_r = sic_bran.uwm100.rtax_t
            sic_bran.uwm120.taxae  = YES.
    END.
    ELSE DO:
        ASSIGN
            sic_bran.uwm120.com1_r = 0
            sic_bran.uwm120.com1p  = 0
            sic_bran.uwm120.com1ae = YES
            sic_bran.uwm120.com2_r = 0
            sic_bran.uwm120.com2p  = 0
            sic_bran.uwm120.com2ae = YES
            sic_bran.uwm120.rstp_r = 0
            sic_bran.uwm120.stmpae = YES
            sic_bran.uwm120.rtax_r = 0
            sic_bran.uwm120.taxae  = YES.
    END.

    sic_bran.uwm100.gstrat = nv_tax_per.
END.

RELEASE sic_bran.uwm100.
RELEASE sic_bran.uwm120.
RELEASE sic_bran.uwm130.
RELEASE sic_bran.uwm301.
RELEASE sic_bran.uwd132.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_clearrenewal C-Win 
PROCEDURE pd_clearrenewal :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN           
    np_rencnt         =   0
    np_prepol         =   ""          
    np_branch         =   ""          
    np_insref         =   ""          
    np_title          =   ""          
    np_name1          =   ""          
    np_name2          =   ""          
    np_name3          =   ""          
    np_addr1          =   ""          
    np_addr2          =   ""          
    np_addr3          =   ""          
    np_addr4          =   ""          
    np_firstdat       =   ""          
    np_comdat         =   ""          
    np_expdat         =   ""          
    np_class          =   ""          
    np_redbook        =   ""          
    np_moddes         =   ""          
    np_yrmanu         =   ""          
    np_vehgrp         =   ""          
    np_body           =   ""          
    np_engine         =   ""          
    np_tons           =   0           
    np_seats          =   ""          
    np_vehuse         =   ""          
    np_covcod         =   ""          
    np_garage         =   ""          
    np_vehreg         =   ""          
    np_cha_no         =   ""          
    np_eng_no         =   ""          
    np_uom1_v         =   ""          
    np_uom2_v         =   ""          
    np_uom5_v         =   ""          
    np_si             =   ""          
    np_baseprm        =   0           
    np_41             =   0           
    np_42             =   0           
    np_43             =   0           
    np_seat41         =   0           
    np_dedod          =   0           
    np_addod          =   0           
    np_dedpd          =   0           
    np_flet_per       =   ""          
    np_ncbper         =   ""          
    np_dss_per        =   ""          
    np_stf_per        =   0           
    np_cl_per         =   0           
    np_bennam1        =   "".         

FOR EACH wuwd132:
    DELETE wuwd132.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_conexp C-Win 
PROCEDURE pd_conexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FORM
    gv_id  LABEL " User Id " colon 35 SKIP
    nv_pwd LABEL " Password" colon 35 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
    TITLE   " Connect DB Expiry System"  . 
/*HIDE ALL NO-PAUSE.*//*note block*/
STATUS INPUT OFF.
/*
{s0/s0sf1.i}
*/
gv_prgid = "GWNEXP02".

REPEAT:
  pause 0.
  STATUS DEFAULT "F4=EXIT".
  ASSIGN
  gv_id     = ""
  n_user    = "".
  UPDATE gv_id nv_pwd GO-ON(F1 F4) WITH FRAME nf00
  EDITING:
    READKEY.
    IF FRAME-FIELD = "gv_id" AND 
       LASTKEY = KEYCODE("ENTER") OR 
       LASTKEY = KEYCODE("f1") THEN DO:
       
       IF INPUT gv_id = "" THEN DO:
          MESSAGE "User ID. IS NOT BLANK".
          NEXT-PROMPT gv_id WITH FRAME nf00.
          NEXT.
       END.
       gv_id = INPUT gv_id.

    END.
    IF FRAME-FIELD = "nv_pwd" AND 
       LASTKEY = KEYCODE("ENTER") OR 
       LASTKEY = KEYCODE("f1") THEN DO:
       
       nv_pwd = INPUT nv_pwd.
    END.      
    APPLY LASTKEY.
  END.
  ASSIGN n_user = gv_id.

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
      CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.  
     /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*//*Comment A62-0105*/    
     /*CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/ /* test dev*/
      
      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2addr C-Win 
PROCEDURE proc_assign2addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER  np_tambon        as char init "".
DEFINE INPUT  PARAMETER  np_mail_amper    as char init "".
DEFINE INPUT  PARAMETER  np_mail_country  as char init "".
DEFINE INPUT  PARAMETER  np_occupation    as char init "".
DEFINE OUTPUT PARAMETER  np_codeocc       as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr1     as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr2     as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr3     as char init "".
DEFINE VAR nv_address AS CHAR INIT  "".

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country) .

IF      R-INDEX(nv_address,"จ.")       <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จ.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จ.")       - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด.") <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด.")   + 8 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด.") - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด")    + 7 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด")  - 1 )). 
ELSE IF R-INDEX(nv_address,"กรุงเทพ")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"กรุงเทพ"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"กรุงเทพ")  - 1 )).
ELSE IF R-INDEX(nv_address,"กทม")      <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"กทม"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"กทม")  - 1 )).

IF index(np_mail_country," ") <> 0  THEN 
    ASSIGN 
    nv_postcd       = trim(SUBSTR(np_mail_country,index(np_mail_country," "))) 
    np_mail_country = trim(SUBSTR(np_mail_country,1,index(np_mail_country," ") - 1 )) .
IF      index(np_mail_country,"กรุงเทพ") <> 0 THEN np_mail_country = "กรุงเทพมหานคร".
ELSE IF index(np_mail_country,"กทม")     <> 0 THEN np_mail_country = "กรุงเทพมหานคร".

IF      R-INDEX(nv_address,"อำเภอ.")   <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อำเภอ.")     + 6 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อำเภอ.")   - 1 )). 
ELSE IF R-INDEX(nv_address,"อำเภอ")    <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อำเภอ")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อำเภอ")    - 1 )).
ELSE IF R-INDEX(nv_address,"อ.")       <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อ.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อ.")       - 1 )).
ELSE IF R-INDEX(nv_address,"เขต.")     <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"เขต.")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"เขต.")     - 1 )).
ELSE IF R-INDEX(nv_address,"เขต")      <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"เขต")        + 3 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"เขต")      - 1 )). 

IF      R-INDEX(nv_address,"ต.")       <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ต.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ต.")       - 1 )).
ELSE IF R-INDEX(nv_address,"ตำบล.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ตำบล.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ตำบล.")    - 1 )).
ELSE IF R-INDEX(nv_address,"ตำบล")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ตำบล")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ตำบล")     - 1 )).

ELSE IF R-INDEX(nv_address,"แขวง.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"แขวง.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"แขวง.")    - 1 )). 
ELSE IF R-INDEX(nv_address,"แขวง")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"แขวง")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"แขวง")     - 1 )). 

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
     /*DISP sicuw.uwm500.prov_n . */
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
         /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . */
         
        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
            sicuw.uwm506.prov_n   = sicuw.uwm501.prov_n and
            sicuw.uwm506.dist_n   = sicuw.uwm501.dist_n and
            sicuw.uwm506.sdist_d  = np_tambon           NO-LOCK NO-ERROR NO-WAIT. /*"รางหวาย"*/
        IF AVAIL sicuw.uwm506 THEN  
            ASSIGN 
            np_codeaddr1 =  sicuw.uwm506.prov_n   /*= uwm100.codeaddr1 */
            np_codeaddr2 =  sicuw.uwm506.dist_n   /*= uwm100.codeaddr2 */
            np_codeaddr3 =  sicuw.uwm506.sdist_n  /*= uwm100.codeaddr3 */
            .  
    END.
END. 
/*occup */
IF np_occupation = "" THEN np_codeocc  = "9999".
ELSE DO:
    FIND FIRST stat.occupdet WHERE 
        stat.occupdet.desocct = np_occupation   /*Thai*/
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.occupdet THEN DO:
        ASSIGN np_codeocc = stat.occupdet.codeocc .
    END.
    ELSE DO:
        FIND FIRST stat.occupdet WHERE 
            stat.occupdet.desocce = np_occupation   /*Eng*/
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.occupdet THEN DO:
            ASSIGN np_codeocc = stat.occupdet.codeocc .
        END.
        ELSE np_codeocc  = "9999".
    END.
END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew_pol C-Win 
PROCEDURE proc_assignrenew_pol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_fptrdel AS RECID INIT ?. /*--add by Chaiyong W.  A61-0016 22/03/2018*/
FIND FIRST sicuw.uwm100 WHERE sicuw.uwm100.policy = wexcel.prvpol NO-LOCK NO-ERROR.
IF AVAIL sicuw.uwm100 THEN DO:
    IF NOT CONNECTED("sic_exp") THEN DO:
        IF gv_id = "" THEN 
            ASSIGN
                gv_id  = n_user   
                nv_pwd = n_passwd .

        CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. 
        /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. *//*Comment A62-0105*/     
        /*CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/     
        IF NOT CONNECTED("sic_exp") THEN DO:
            RUN pd_conexp.
        END.
    END.

    IF CONNECTED("sic_exp") THEN DO:
        RUN wgw\wgwrw100(INPUT wexcel.prvpol,
                         INPUT wexcel.newpol,
                         INPUT nv_batchyr   , 
                         INPUT nv_batchno   , 
                         INPUT nv_batcnt    , 
                         INPUT TRIM(fi_branch)).
        /*---np_rencnt = sicuw.uwm100.rencnt + 1.
        np_prepol = wexcel.prvpol.
        RUN wgw\wgwbu2ex(INPUT-OUTPUT  np_prepol     ,
                         INPUT-OUTPUT  np_branch     ,
                         INPUT-OUTPUT  np_insref     ,
                         INPUT-OUTPUT  np_title      ,
                         INPUT-OUTPUT  np_name1      ,
                         INPUT-OUTPUT  np_name2      ,
                         INPUT-OUTPUT  np_name3      ,
                         INPUT-OUTPUT  np_addr1      ,
                         INPUT-OUTPUT  np_addr2      ,
                         INPUT-OUTPUT  np_addr3      ,
                         INPUT-OUTPUT  np_addr4      ,
                         INPUT-OUTPUT  np_firstdat   ,
                         INPUT-OUTPUT  np_comdat     ,
                         INPUT-OUTPUT  np_expdat     ,
                         INPUT-OUTPUT  np_class      ,
                         INPUT-OUTPUT  np_redbook    ,
                         INPUT-OUTPUT  np_moddes     ,
                         INPUT-OUTPUT  np_yrmanu     ,
                         INPUT-OUTPUT  np_vehgrp     ,
                         INPUT-OUTPUT  np_body       ,
                         INPUT-OUTPUT  np_engine     ,
                         INPUT-OUTPUT  np_tons       ,
                         INPUT-OUTPUT  np_seats      ,
                         INPUT-OUTPUT  np_vehuse     ,
                         INPUT-OUTPUT  np_covcod     ,
                         INPUT-OUTPUT  np_garage     ,
                         INPUT-OUTPUT  np_vehreg     ,
                         INPUT-OUTPUT  np_cha_no     ,
                         INPUT-OUTPUT  np_eng_no     ,
                         INPUT-OUTPUT  np_uom1_v     ,
                         INPUT-OUTPUT  np_uom2_v     ,
                         INPUT-OUTPUT  np_uom5_v     ,
                         INPUT-OUTPUT  np_si         ,
                         INPUT-OUTPUT  np_baseprm    ,
                         INPUT-OUTPUT  np_41         ,
                         INPUT-OUTPUT  np_42         ,
                         INPUT-OUTPUT  np_43         ,
                         INPUT-OUTPUT  np_seat41     ,
                         INPUT-OUTPUT  np_dedod      ,
                         INPUT-OUTPUT  np_addod      ,
                         INPUT-OUTPUT  np_dedpd      ,
                         INPUT-OUTPUT  np_flet_per   ,
                         INPUT-OUTPUT  np_ncbper     ,
                         INPUT-OUTPUT  np_dss_per    ,
                         INPUT-OUTPUT  np_stf_per    ,
                         INPUT-OUTPUT  np_cl_per     ,
                         INPUT-OUTPUT  np_bennam1    ). ---*/
        /*----Begin by Chaiyong W. A61-0016 22/03/2018*/
        
        RUN wgw\wgwrwr70(INPUT wexcel.newpol,
                         INPUT nv_batchyr, 
                         INPUT nv_batchno, 
                         INPUT nv_batcnt ).
        /*Add by Kridtiya i. A65-0125*/
        IF index(wexcel.body,"TRUCK") = 0 AND (wexcel.covcod = "1" OR wexcel.covcod = "2.2" )  THEN DO:
            IF  wexcel.sclass = "110" OR wexcel.sclass = "210" OR wexcel.sclass = "320"  THEN
                wexcel.product = "CLAIMDI".
        END.
        /*Add by Kridtiya i. A65-0125*/
        FIND FIRST sic_bran.uwm100 WHERE
            sic_bran.uwm100.policy = wexcel.newpol AND
            sic_bran.uwm100.bchyr  = nv_batchyr    AND
            sic_bran.uwm100.bchno  = nv_batchno    AND
            sic_bran.uwm100.bchcnt = nv_batcnt     NO-ERROR NO-WAIT.
        IF AVAIL sic_bran.uwm100 THEN DO:

            ASSIGN
                s_recid1 = RECID(sic_bran.uwm100)
                sic_bran.uwm100.cr_2    = ""
                sic_bran.uwm100.renno   = ""
                sic_bran.uwm100.opnpol  = wexcel.brncod
                sic_bran.uwm100.poltyp  = "V70"
                sic_bran.uwm100.insref  = "" /**/
                sic_bran.uwm100.anam2   = wexcel.icno
                sic_bran.uwm100.ntitle  = wexcel.ntitle
                sic_bran.uwm100.name1   = wexcel.fname
                sic_bran.uwm100.name2   = ""
                sic_bran.uwm100.name3   = ""
                sic_bran.uwm100.addr1   = wexcel.addr1
                sic_bran.uwm100.addr2   = wexcel.addr2
                sic_bran.uwm100.addr3   = wexcel.addr3
                sic_bran.uwm100.addr4   = wexcel.addr4
                sic_bran.uwm100.postcd  = ""
                sic_bran.uwm100.undyr   = STRING(YEAR(TODAY),"9999")
                sic_bran.uwm100.branch  = wexcel.brnsty
                sic_bran.uwm100.dept    = "G"
                sic_bran.uwm100.usrid   = USERID(LDBNAME(1))
                sic_bran.uwm100.comdat  = DATE(wexcel.comdat)
                sic_bran.uwm100.expdat  = DATE(wexcel.expdat)
                sic_bran.uwm100.accdat  = DATE(wexcel.comdat)
                sic_bran.uwm100.tranty  = "R"
                sic_bran.uwm100.langug  = "T"
                sic_bran.uwm100.acctim  = "00:00"
                sic_bran.uwm100.trty11  = "M"      
                sic_bran.uwm100.docno1  =  " " /*STRING(nv_docno,"9999999")*/     
                sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS")
                sic_bran.uwm100.entdat  = TODAY
                sic_bran.uwm100.curbil  = "BHT"
                sic_bran.uwm100.curate  = 1
                sic_bran.uwm100.instot  = 1
                sic_bran.uwm100.prog    = "WGWNLGEN"
                sic_bran.uwm100.cntry   = "TH"        /*Country where risk is situated*/
                sic_bran.uwm100.insddr  = YES         /*Print Insd. Name on DrN       */
                sic_bran.uwm100.no_sch  = 0           /*No. to print, Schedule        */
                sic_bran.uwm100.no_dr   = 1           /*No. to print, Dr/Cr Note      */
                sic_bran.uwm100.no_ri   = 0           /*No. to print, RI Appln        */
                sic_bran.uwm100.no_cer  = 0           /*No. to print, Certificate     */
                sic_bran.uwm100.li_sch  = YES         /*Print Later/Imm., Schedule    */
                sic_bran.uwm100.li_dr   = YES         /*Print Later/Imm., Dr/Cr Note  */
                sic_bran.uwm100.li_ri   = YES         /*Print Later/Imm., RI Appln,   */
                sic_bran.uwm100.li_cer  = YES         /*Print Later/Imm., Certificate */
                sic_bran.uwm100.apptax  = YES         /*Apply risk level tax (Y/N)    */
                sic_bran.uwm100.recip   = "N"         /*Reciprocal (Y/N/C)            */
                sic_bran.uwm100.short   = NO
                sic_bran.uwm100.acno1   = wexcel.broker
                sic_bran.uwm100.agent   = wexcel.agent
                sic_bran.uwm100.insddr  = NO
                sic_bran.uwm100.coins   = NO
                sic_bran.uwm100.billco  = ""
                sic_bran.uwm100.fptr01  = 0        sic_bran.uwm100.bptr01 = 0
                sic_bran.uwm100.fptr02  = 0        sic_bran.uwm100.bptr02 = 0
                sic_bran.uwm100.fptr03  = 0        sic_bran.uwm100.bptr03 = 0
                sic_bran.uwm100.fptr04  = 0        sic_bran.uwm100.bptr04 = 0
                sic_bran.uwm100.fptr05  = 0        sic_bran.uwm100.bptr05 = 0
                sic_bran.uwm100.fptr06  = 0        sic_bran.uwm100.bptr06 = 0  
                sic_bran.uwm100.styp20  = "NORM"
                sic_bran.uwm100.dir_ri  = YES
                sic_bran.uwm100.drn_p   = NO
                sic_bran.uwm100.sch_p   = NO
                sic_bran.uwm100.cedpol  = wexcel.cedpol  
                sic_bran.uwm100.finint  = ""
                sic_bran.uwm100.bs_cd   = ""
                sic_bran.uwm100.polsta  = "IF"
                sic_bran.uwm100.gstrat  = 7
                sic_bran.uwm100.trndat = TODAY
/*                 sic_bran.uwm100.cr_1   = wexcel.campaign *//*comment by Kridtiya i. A65-0125*/
                sic_bran.uwm100.cr_1   = IF wexcel.product = "" THEN wexcel.campaign ELSE wexcel.product  /*Add by Kridtiya i. A65-0125*/
                n_rencnt   = sic_bran.uwm100.rencnt
                n_endcnt   = sic_bran.uwm100.endcnt
                np_rencnt = sic_bran.uwm100.rencnt
                sic_bran.uwm100.firstName  = trim(wexcel.firstName)           /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.lastName   = trim(wexcel.lastName)            /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.postcd     = trim(wexcel.postcd)              /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.icno       = trim(wexcel.icno)                /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.codeocc    = trim(wexcel.codeocc)             /*Add by Kridtiya i. A63-0472*/ 
            sic_bran.uwm100.codeaddr1  = trim(wexcel.codeaddr1)           /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.codeaddr2  = trim(wexcel.codeaddr2)           /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.codeaddr3  = trim(wexcel.codeaddr3)           /*Add by Kridtiya i. A63-0472*/
            /*sic_bran.uwm100.br_insured = "00000" */                   /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.campaign   = trim(wexcel.campaign_ov)   /*Add by Kridtiya i. A63-0472*/
            sic_bran.uwm100.dealer     = trim(wexcel.financecd) .         /*Add by Kridtiya i. A63-0472*/ 
                
            IF sic_bran.uwm100.postcd = "" THEN sic_bran.uwm100.postcd = trim(wexcel.postcod). 
            
            /*---
            IF TRIM(sic_bran.uwm100.ntitle) <> "" THEN DO:
                IF SUBSTR(TRIM(sic_bran.uwm100.ntitle),1,1) = "บ" OR 
                   SUBSTR(TRIM(sic_bran.uwm100.ntitle),1,1) = "ห" THEN DO:
                END.
                ELSE sic_bran.uwm100.ntitle = "คุณ".
            END. */
            IF wexcel.paycod <> "" THEN DO:
                IF  wexcel.paycod = "CA"  or 
                    wexcel.paycod = "CC"  or 
                    wexcel.paycod = "BP"  or 
                    wexcel.paycod = "CV"  or 
                    wexcel.paycod = "CL"  THEN DO:
                    IF sic_bran.uwm100.opnpol <> "" THEN sic_bran.uwm100.opnpol = TRIM(sic_bran.uwm100.opnpol) + "/" .
                    sic_bran.uwm100.opnpol = sic_bran.uwm100.opnpol + wexcel.paycod .
                END.
            END.
    
            IF  (DAY(sic_bran.uwm100.comdat)      =  DAY(sic_bran.uwm100.expdat)    AND
                 MONTH(sic_bran.uwm100.comdat)    =  MONTH(sic_bran.uwm100.expdat)  AND
                 YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) ) OR
                (DAY(sic_bran.uwm100.comdat)      =  29                             AND
                 MONTH(sic_bran.uwm100.comdat)    =  02                             AND
                 DAY(sic_bran.uwm100.expdat)      =  01                             AND
                 MONTH(sic_bran.uwm100.expdat)    =  03                             AND
                 YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
            THEN nv_polday = 365.
            ELSE nv_polday = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat ) + 1.
    


            IF sic_bran.uwm100.insref = "" THEN DO:
                RUN PDCreateIns.
                sic_bran.uwm100.insref = nv_insref.
                nv_insref = "".
            END.
            nv_fptrdel = sic_bran.uwm100.fptr01.
            REPEAT:
                IF nv_fptrdel = 0 OR nv_fptrdel = ? THEN LEAVE.
                FIND FIRST sic_bran.uwd100 WHERE RECID(sic_bran.uwd100) = nv_fptrdel .
                IF AVAIL sic_bran.uwd100 THEN DO:
                    nv_fptrdel = sic_bran.uwd100.fptr.
                    DELETE sic_bran.uwd100.
                END.
                ELSE LEAVE.
            END.
            ASSIGN
                sic_bran.uwm100.fptr01 = 0
                sic_bran.uwm100.bptr01 = 0.

           
            nv_fptrdel = sic_bran.uwm100.fptr02.
            REPEAT:
                IF nv_fptrdel = 0 OR nv_fptrdel = ? THEN LEAVE.
                FIND FIRST sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptrdel .
                IF AVAIL sic_bran.uwd102 THEN DO:
                    nv_fptrdel = sic_bran.uwd102.fptr.
                    DELETE uwd102.
                END.
                ELSE LEAVE.
            END.
            ASSIGN
                sic_bran.uwm100.fptr02 = 0
                sic_bran.uwm100.bptr02 = 0.

            /* Add By Tontawan S. A63-0124 07/04/2020 */
            FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
                       sic_bran.uwm120.policy = sic_bran.uwm100.policy  AND
                       sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt  AND
                       sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt  NO-ERROR NO-WAIT.
            IF AVAIL sic_bran.uwm120 THEN DO:
            /* End By Tontawan S. A63-0124 */
                /*-- Comment By Tontawan S. A63-0124 07/04/2020 ---
                FIND FIRST sic_bran.uwm301 WHERE 
                    sic_bran.uwm301.policy = sic_bran.uwm100.policy AND
                    sic_bran.uwm301.bchyr  = nv_batchyr    AND
                    sic_bran.uwm301.bchno  = nv_batchno    AND
                    sic_bran.uwm301.bchcnt = nv_batcnt     NO-ERROR NO-WAIT. -- */
                FIND FIRST sic_bran.uwm301 WHERE 
                    sic_bran.uwm301.policy = sic_bran.uwm120.policy AND
                    sic_bran.uwm301.bchyr  = nv_batchyr    AND
                    sic_bran.uwm301.bchno  = nv_batchno    AND
                    sic_bran.uwm301.bchcnt = nv_batcnt     NO-ERROR NO-WAIT.
                IF AVAIL sic_bran.uwm301 THEN DO:
                    ASSIGN
                        sic_bran.uwm301.vehreg = wexcel.vehreg
                        sic_bran.uwm301.mv_ben83 = wexcel.bennam    .

                    /*A66-0069
                    IF sic_bran.uwm301.tons < 100 THEN DO:
                       sic_bran.uwm301.tons  = sic_bran.uwm301.tons  * 1000. 
                    END.
                    A66-0069*/

                   /* comment by A65-0203..
                    /* Add By Tontawan S. A63-0124 07/04/2020 */
                    IF substr(sic_bran.uwm120.CLASS,1,1) <> "A" THEN DO: 
                        IF sic_bran.uwm301.tons < 100 THEN DO:
                           sic_bran.uwm301.tons  = sic_bran.uwm301.tons  * 1000. 
                        END.
                        /*SUBSTR(sic_bran.uwm120.CLASS,1,1) = "T" +  SUBSTR(sic_bran.uwm120.CLASS,2). -- Comment By Tontawan S. */
                        sic_bran.uwm120.CLASS = "T" +  SUBSTR(sic_bran.uwm120.CLASS,2). /* Tontawan S. A63-0124 15/04/2020 */
                    END.
                    /* End Tontawan S. A63-0124 07/04/2020 */
                    ...end A65-0203...*/
                    
                    IF LENGTH(TRIM(sic_bran.uwm301.prmtxt)) > 60 AND LENGTH(TRIM(sic_bran.uwm301.prmtxt)) <= 300 THEN DO:
                        ASSIGN
                        wexcel.tacc1             = trim(substr(wexcel.tacc1,1,60))  
                        wexcel.tacc2             = trim(substr(wexcel.tacc2,1,60))  
                        wexcel.tacc3             = trim(substr(wexcel.tacc3,1,60))  
                        wexcel.tacc4             = trim(substr(wexcel.tacc4,1,60))  
                        wexcel.tacc5             = trim(substr(wexcel.tacc5,1,60)).  
                        sic_bran.uwm301.prmtxt   = sic_bran.uwm301.prmtxt  + FILL(" ",300 - LENGTH(sic_bran.uwm301.prmtxt))  + 
                                                  wexcel.tacc1 + FILL(" ",60 - LENGTH(wexcel.tacc1))  +      
                                                  wexcel.tacc2 + FILL(" ",60 - LENGTH(wexcel.tacc2))  +     
                                                  wexcel.tacc3 + FILL(" ",60 - LENGTH(wexcel.tacc3))  +     
                                                  wexcel.tacc4 + FILL(" ",60 - LENGTH(wexcel.tacc4))  +     
                                                  wexcel.tacc5 + FILL(" ",60 - LENGTH(wexcel.tacc5))  . 
                
                    END.
                    ELSE do: /*IF TRIM(sic_bran.uwm301.prmtxt) = 0  THEN DO:*/
                        ASSIGN
                        wexcel.tacc1             = trim(substr(wexcel.tacc1,1,60))  
                        wexcel.tacc2             = trim(substr(wexcel.tacc2,1,60))  
                        wexcel.tacc3             = trim(substr(wexcel.tacc3,1,60))  
                        wexcel.tacc4             = trim(substr(wexcel.tacc4,1,60))  
                        wexcel.tacc5             = trim(substr(wexcel.tacc5,1,60)).  
                        sic_bran.uwm301.prmtxt   = wexcel.tacc1 + FILL(" ",60 - LENGTH(wexcel.tacc1))  +      
                                                  wexcel.tacc2 + FILL(" ",60 - LENGTH(wexcel.tacc2))  +     
                                                  wexcel.tacc3 + FILL(" ",60 - LENGTH(wexcel.tacc3))  +     
                                                  wexcel.tacc4 + FILL(" ",60 - LENGTH(wexcel.tacc4))  +     
                                                  wexcel.tacc5 + FILL(" ",60 - LENGTH(wexcel.tacc5))  . 
                    END.
                  
                    RUN PDCreate100d.
                    RUN PDCreate102d.
                
                END. 
            END. /* uwm120 ton */
            ELSE DO:  /* Add A67-0029 */
                wexcel.wmark  = NO.
                wexcel.werror = wexcel.werror + "Not Found Policy Renew (UWM120) !!  |".
            END.
        END. 
        ELSE DO:  /* Add A67-0029 */
            wexcel.wmark  = NO.
            wexcel.werror = wexcel.werror + "Not Found Policy Renew (UWM100) !!  |".
        END.
        /*End by Chaiyong W. A61-0016 22/03/2018------*/
    END.
    ELSE DO:  /* Add A67-0029 */
        wexcel.wmark  = NO.
        wexcel.werror = wexcel.werror + "Not Conect DB Expiry !!  |".
    END.

    IF np_name1 = "" THEN DO:
        ASSIGN
            np_rencnt = 0
            np_prepol = "".  
    END.
    DISCONNECT sic_exp NO-ERROR.
END.
ELSE DO:  /* Add A67-0029 */
    wexcel.wmark  = NO.
    wexcel.werror = wexcel.werror + "Not Found Prev.Policy (UWM100) !!  |".
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt C-Win 
PROCEDURE proc_calpremt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A65-0203      
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy)  NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
        fi_display = "Calculate Premium policy: " + wexcel.policy.
        DISP fi_display WITH FRAME fr_main.
        ASSIGN 
            nv_polday  = 0 
            nv_covcod  = ""  
            nv_class   = ""  
            nv_vehuse  = ""  
            nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
            nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
            /*nv_drivno  = 0*/
            nv_driage1 = 0
            nv_driage2 = 0
            nv_pdprm0  = 0  /*เบี้ยส่วนลดผู้ขับขี่*/
            nv_yrmanu  = 0
            nv_totsi   = 0
            nv_totfi   = 0
            nv_vehgrp  = ""
            nv_access  = ""
            nv_supe    = NO
            nv_tpbi1si = 0
            nv_tpbi2si = 0
            nv_tppdsi  = 0   
            nv_411si   = 0
            nv_412si   = 0
            nv_413si   = 0
            nv_414si   = 0  
            nv_42si    = 0
            nv_43si    = 0
            nv_41prmt  = 0
            nv_412prmt = 0  
            nv_413prmt = 0  
            nv_414prmt = 0  
            nv_42prmt  = 0
            nv_43prmt  = 0
            nv_seat41  = 0          
            nv_dedod   = 0
            nv_addod   = 0
            nv_dedpd   = 0        
            nv_ncbp    = 0
            nv_fletp   = 0
            nv_dspcp   = 0
            nv_dstfp   = 0
            nv_clmp    = 0
            /* A65-0079*/
            nv_mainprm = 0 
            nv_ncbamt  = 0 
            nv_fletamt = 0 
            nv_dspcamt = 0 
            nv_dstfamt = 0 
            nv_clmamt  = 0 
            /* end : A65-0079 */
            nv_baseprm  = 0
            nv_baseprm3 = 0
            nv_pdprem   = 0
            nv_netprem  = 0    /*เบี้ยสุทธิ */
            nv_gapprm   = 0    /*เบี้ยรวม */
            nv_flagprm  = "N"  /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
            nv_effdat   = ?    
            nv_ratatt   = 0    
            nv_siatt    = 0    
            nv_netatt   = 0    
            nv_fltatt   = 0    
            nv_ncbatt   = 0    
            nv_dscatt   = 0    
            nv_atfltgap = 0   /*A65-0079*/
            nv_atncbgap = 0   /*A65-0079*/
            nv_atdscgap = 0   /*A65-0079*/
            nv_packatt  = ""  /*A65-0079*/
            nv_flgsht   = ""  /*A65-0079*/
            nv_status   = "" 
            nv_fcctv    = NO
            nv_uom1_c   = "" 
            nv_uom2_c   = "" 
            nv_uom5_c   = "" 
            nv_uom6_c   = "" 
            nv_uom7_c   = ""
            nv_message  = "" .
        ASSIGN               
            nv_covcod  = wexcel.covcod                                              
            nv_class   = sic_bran.uwm120.CLASS     /* T110 */                                     
            nv_vehuse  = wexcel.vehuse                                    
           /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
            nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
            nv_drivno  = 0   */                                     
            nv_driage1 = int(wexcel.driage1)                                
            nv_driage2 = int(wexcel.driage2)                                   
            nv_yrmanu  = INT(wexcel.yrmanu)                         
            nv_totsi   = IF sic_bran.uwm130.uom6_v <> 0 THEN sic_bran.uwm130.uom6_v  ELSE sic_bran.uwm130.uom7_v      
            nv_totfi   = sic_bran.uwm130.uom7_v
            nv_vehgrp  = wexcel.vehgrp                                                     
            nv_access  = wexcamp.acc                                         
           /*nv_supe    = NO*/                                              
            nv_tpbi1si = int(wexcamp.tp_bi1)          
            nv_tpbi2si = int(wexcamp.tp_bi2)           
            nv_tppdsi  = int(wexcamp.tp_pd)            
            nv_411si   = int(wexcamp.pa411)        
            nv_412si   = int(wexcamp.pa412)        
            nv_413si   = 0                       
            nv_414si   = 0                     
            nv_42si    = int(wexcamp.pa42)              
            nv_43si    = int(wexcamp.pa43)
            nv_41prmt  = 0
            nv_412prmt = 0 
            nv_413prmt = 0 
            nv_414prmt = 0 
            nv_42prmt  = 0
            nv_43prmt  = 0
            nv_seat41  = int(wexcel.seat)                    
            nv_dedod   = 0                                
            nv_addod   = 0                                
            nv_dedpd   = 0                  
            nv_ncbp    = deci(wexcamp.ncb )                    
            nv_fletp   = deci(wexcamp.fleet)                   
            nv_dspcp   = deci(wexcamp.dspc)                                   
            nv_dstfp   = 0                                                 
            nv_clmp    = deci(wexcamp.loadcl) 
            nv_mainprm  = 0
            /*nv_dodamt   = deci(wdetail.int1)
            nv_dadamt   = deci(wdetail.int2)
            nv_dpdamt   = deci(wdetail.int3)*/
            nv_ncbamt   = 0
            nv_fletamt  = 0
            nv_dspcamt  = 0
            nv_dstfamt  = 0
            nv_clmamt   = 0
            /* end : A65-0079*/
            nv_baseprm  = deci(wexcamp.base1)
            nv_baseprm3 = deci(wexcamp.base2) 
            nv_netprem  = DECI(wexcamp.Prem_t) /* เบี้ยสุทธิ */  
            nv_pdprem   = DECI(wexcamp.Prem_t)
            nv_gapprm   = 0                                                       
            nv_flagprm  = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
            nv_effdat   = sic_bran.uwm100.comdat
            nv_ratatt   = 0                     
            nv_siatt    = 0                                                   
            nv_netatt   = 0       
            nv_fltatt   = 0      
            nv_ncbatt   = 0      
            nv_dscatt   = 0
            nv_attgap   = 0
            nv_atfltgap = 0
            nv_atncbgap = 0
            nv_atdscgap = 0 
            nv_packatt  = ""
            nv_flgsht   = "P" 
            nv_fcctv    = NO .
            /*nv_status  = "" */

         FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
               clastab_fil.CLASS  = nv_class     AND
               clastab_fil.covcod = wexcel.covcod    NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                IF clastab_fil.unit = "C" THEN DO:
                    ASSIGN
                        nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                        nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(sic_bran.uwm301.watt) ELSE INT(sic_bran.uwm301.engine).
                END.
                ELSE IF clastab_fil.unit = "S" THEN DO: 
                    ASSIGN                                
                        nv_cstflg = clastab_fil.unit
                        nv_engine = INT(wexcel.seat).
                END.
                ELSE IF clastab_fil.unit = "T" THEN DO:
                    ASSIGN
                        nv_cstflg = clastab_fil.unit
                        nv_engine = INTE(sic_bran.uwm301.tons).
                END.
                nv_engcst = nv_engine .
            END.

        IF wexcel.modcod = ""  THEN DO:
            IF nv_cstflg <> "T" THEN DO:
                RUN wgw/wgwredbk1(input  wexcel.makdes ,       /*A65=0079*/
                                   input wexcel.moddes ,  
                                   input  nv_totsi      ,  
                                   INPUT  "X" ,  
                                   input  SUBSTR(nv_class,2,5),   
                                   input  wexcel.yrmanu, 
                                   input  nv_engine  ,
                                   input  0 , 
                                   INPUT-OUTPUT wexcel.modcod) .
            END.
            ELSE DO:
                RUN wgw/wgwredbk1(input  wexcel.makdes ,       /*A65=0079*/
                                   input wexcel.moddes ,  
                                   input  nv_totsi      ,  
                                   INPUT  "X" ,  
                                   input  SUBSTR(nv_class,2,5),   
                                   input  wexcel.yrmanu, 
                                   input  nv_engine  ,
                                   input  0 , 
                                   INPUT-OUTPUT wexcel.modcod) .
            END.

            IF wexcel.modcod <> ""  THEN ASSIGN sic_bran.uwm301.modcod = wexcel.modcod .
            ELSE DO:
             ASSIGN
                  wexcel.werror = wexcel.werror + "Redbook is Null !!  |"
                  wexcel.wmark  = NO.
            END.
        END.

        FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wexcel.makdes AND 
                                        maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
            IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

        IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
            IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
               MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
               ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
               MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                 DAY(sic_bran.uwm100.expdat)     =   01                             AND
               MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
            THEN DO:
              nv_polday = 365.
            END.
            ELSE DO:
              nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
            END.
        END.

        IF nv_polday < 365 THEN DO:
            nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).
        END.

    RUN WUW\WUWPADP2.P(INPUT sic_bran.uwm100.policy,
                       INPUT sic_bran.uwm100.rencnt,
                       INPUT sic_bran.uwm100.endcnt,
                       INPUT 1 ,  
                       INPUT nv_batchyr, 
                       INPUT nv_batchno, 
                       INPUT nv_polday,
                       INPUT-OUTPUT nv_covcod ,
                       INPUT-OUTPUT nv_class  ,
                       INPUT-OUTPUT nv_vehuse ,
                       INPUT-OUTPUT nv_cstflg ,
                       INPUT-OUTPUT nv_engcst ,
                       INPUT-OUTPUT nv_drivno ,
                       INPUT-OUTPUT nv_driage1,
                       INPUT-OUTPUT nv_driage2,
                       INPUT-OUTPUT nv_pdprm0 , 
                       INPUT-OUTPUT nv_yrmanu ,
                       INPUT-OUTPUT nv_totsi  ,
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
                       INPUT-OUTPUT nv_tpbi2si, 
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,    
                       INPUT-OUTPUT nv_41prmt, /* nv_41prmt */
                       INPUT-OUTPUT nv_42prmt, /* nv_42prmt */
                       INPUT-OUTPUT nv_43prmt, /* nv_43prmt */
                       INPUT-OUTPUT nv_seat41, /* nv_seat41 */               
                       INPUT-OUTPUT nv_dedod,   
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,                  
                       INPUT-OUTPUT nv_ncbp,      
                       INPUT-OUTPUT nv_fletp,   
                       INPUT-OUTPUT nv_dspcp,   
                       INPUT-OUTPUT nv_dstfp,   
                       INPUT-OUTPUT nv_clmp,                  
                       INPUT-OUTPUT nv_baseprm , /* nv_baseprm  */
                       INPUT-OUTPUT nv_baseprm3, /* nv_baseprm3 */
                       INPUT-OUTPUT nv_pdprem  , /* nv_pdprem   */
                       INPUT-OUTPUT nv_netprem,  /* nv_netprem  */
                       INPUT-OUTPUT nv_gapprm,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       INPUT-OUTPUT nv_fcctv , /* cctv = yes/no */
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       OUTPUT nv_status, 
                       OUTPUT nv_message). 
   
    ASSIGN                        
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    
    /*IF nv_status = "NO" THEN DO:*/
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wexcel.wmark  = NO. /*A65-0043*/
        ASSIGN   wexcel.werror = wexcel.werror + "|" + nv_message.
    END. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt-01 C-Win 
PROCEDURE proc_calpremt-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: comment by A65-0203      
------------------------------------------------------------------------------*/
/*DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy) AND
                        wexcamp.campaign  = TRIM(wexcel.campaign) AND
                        wexcamp.polmaster = "CAMP_NTL" NO-LOCK NO-ERROR .
    IF AVAIL wexcamp THEN DO:
        fi_display = "Calculate Premium policy: " + wexcel.policy.
        DISP fi_display WITH FRAME fr_main.
        ASSIGN 
            nv_polday  = 0 
            nv_covcod  = ""  
            nv_class   = ""  
            nv_vehuse  = ""  
            nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
            nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
            /*nv_drivno  = 0*/
            nv_driage1 = 0
            nv_driage2 = 0
            nv_pdprm0  = 0  /*เบี้ยส่วนลดผู้ขับขี่*/
            nv_yrmanu  = 0
            nv_totsi   = 0
            nv_totfi   = 0
            nv_vehgrp  = ""
            nv_access  = ""
            nv_supe    = NO
            nv_tpbi1si = 0
            nv_tpbi2si = 0
            nv_tppdsi  = 0   
            nv_411si   = 0
            nv_412si   = 0
            nv_413si   = 0
            nv_414si   = 0  
            nv_42si    = 0
            nv_43si    = 0
            nv_41prmt  = 0
            nv_412prmt = 0  /*A65-0079*/
            nv_413prmt = 0  /*A65-0079*/
            nv_414prmt = 0  /*A65-0079*/
            nv_42prmt  = 0
            nv_43prmt  = 0
            nv_seat41  = 0          
            nv_dedod   = 0
            nv_addod   = 0
            nv_dedpd   = 0        
            nv_ncbp    = 0
            nv_fletp   = 0
            nv_dspcp   = 0
            nv_dstfp   = 0
            nv_clmp    = 0
            /* A65-0079*/
            nv_mainprm = 0 
            nv_ncbamt  = 0 
            nv_fletamt = 0 
            nv_dspcamt = 0 
            nv_dstfamt = 0 
            nv_clmamt  = 0 
            /* end : A65-0079 */
            nv_baseprm  = 0
            nv_baseprm3 = 0
            nv_pdprem   = 0
            nv_netprem  = 0    /*เบี้ยสุทธิ */
            nv_gapprm   = 0    /*เบี้ยรวม */
            nv_flagprm  = "N"  /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
            nv_effdat   = ?    
            nv_ratatt   = 0    
            nv_siatt    = 0    
            nv_netatt   = 0    
            nv_fltatt   = 0    
            nv_ncbatt   = 0    
            nv_dscatt   = 0    
            nv_atfltgap = 0   /*A65-0079*/
            nv_atncbgap = 0   /*A65-0079*/
            nv_atdscgap = 0   /*A65-0079*/
            nv_packatt  = ""  /*A65-0079*/
            nv_flgsht   = ""  /*A65-0079*/
            nv_status   = "" 
            nv_fcctv    = NO
            nv_uom1_c   = "" 
            nv_uom2_c   = "" 
            nv_uom5_c   = "" 
            nv_uom6_c   = "" 
            nv_uom7_c   = ""
            nv_message  = "" .
        ASSIGN               
            nv_covcod  = wexcel.covcod                                              
            nv_class   = sic_bran.uwm120.CLASS     /* T110 */                                     
            nv_vehuse  = wexcel.vehuse                                    
           /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
            nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
            nv_drivno  = 0   */                                     
            nv_driage1 = int(wexcel.driage1)                                
            nv_driage2 = int(wexcel.driage2)                                   
            nv_yrmanu  = INT(wexcel.yrmanu)                         
            nv_totsi   = IF sic_bran.uwm130.uom6_v <> 0 THEN sic_bran.uwm130.uom6_v  ELSE sic_bran.uwm130.uom7_v      
            nv_totfi   = sic_bran.uwm130.uom7_v
            nv_vehgrp  = wexcel.vehgrp                                                     
            nv_access  = wexcamp.acc                                         
           /*nv_supe    = NO*/                                              
            nv_tpbi1si = int(wexcamp.tp_bi1)          
            nv_tpbi2si = int(wexcamp.tp_bi2)           
            nv_tppdsi  = int(wexcamp.tp_pd)            
            nv_411si   = int(wexcamp.pa411)        
            nv_412si   = int(wexcamp.pa412)        
            nv_413si   = 0                       
            nv_414si   = 0                     
            nv_42si    = int(wexcamp.pa42)              
            nv_43si    = int(wexcamp.pa43)
            nv_41prmt  = 0
            nv_412prmt = 0 
            nv_413prmt = 0 
            nv_414prmt = 0 
            nv_42prmt  = 0
            nv_43prmt  = 0
            nv_seat41  = int(wexcel.seat)                    
            nv_dedod   = 0                                
            nv_addod   = 0                                
            nv_dedpd   = 0                  
            nv_ncbp    = deci(wexcamp.ncb )                    
            nv_fletp   = deci(wexcamp.fleet)                   
            nv_dspcp   = deci(wexcamp.dspc)                                   
            nv_dstfp   = 0                                                 
            nv_clmp    = deci(wexcamp.loadcl)             
                                     
            nv_mainprm  = 0
            /*nv_dodamt   = deci(wdetail.int1)
            nv_dadamt   = deci(wdetail.int2)
            nv_dpdamt   = deci(wdetail.int3)*/
            nv_ncbamt   = 0
            nv_fletamt  = 0
            nv_dspcamt  = 0
            nv_dstfamt  = 0
            nv_clmamt   = 0
            /* end : A65-0079*/
            nv_baseprm  = deci(wexcamp.base1)
            nv_baseprm3 = deci(wexcamp.base2) 
            nv_netprem  = DECI(wexcamp.Prem_t) /* เบี้ยสุทธิ */  
            nv_pdprem   = DECI(wexcamp.Prem_t)
            nv_gapprm   = 0                                                       
            nv_flagprm  = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
            nv_effdat   = sic_bran.uwm100.comdat
            nv_ratatt   = 0                     
            nv_siatt    = 0                                                   
            nv_netatt   = 0       
            nv_fltatt   = 0      
            nv_ncbatt   = 0      
            nv_dscatt   = 0
            nv_attgap   = 0
            nv_atfltgap = 0
            nv_atncbgap = 0
            nv_atdscgap = 0 
            nv_packatt  = ""
            nv_flgsht   = "P" 
            nv_fcctv    = NO .
            /*nv_status  = "" */

         FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
               clastab_fil.CLASS  = nv_class     AND
               clastab_fil.covcod = wexcel.covcod    NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                IF clastab_fil.unit = "C" THEN DO:
                    ASSIGN
                        nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                        nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(sic_bran.uwm301.watt) ELSE INT(sic_bran.uwm301.engine).
                END.
                ELSE IF clastab_fil.unit = "S" THEN DO: 
                    ASSIGN                                
                        nv_cstflg = clastab_fil.unit
                        nv_engine = INT(wexcel.seat).
                END.
                ELSE IF clastab_fil.unit = "T" THEN DO:
                    ASSIGN
                        nv_cstflg = clastab_fil.unit
                        nv_engine = INTE(wexcel.gwv).
                END.
                nv_engcst = nv_engine .
            END.

        IF wexcel.modcod = ""  THEN DO:
            IF nv_cstflg <> "T" THEN DO:
                RUN wgw/wgwredbk1(input  wexcel.makdes ,       /*A65=0079*/
                                   input wexcel.moddes ,  
                                   input  nv_totsi      ,  
                                   INPUT  "X" ,  
                                   input  SUBSTR(nv_class,2,5),   
                                   input  wexcel.yrmanu, 
                                   input  nv_engine  ,
                                   input  0 , 
                                   INPUT-OUTPUT wexcel.modcod) .
            END.
            ELSE DO:
                RUN wgw/wgwredbk1(input  wexcel.makdes ,       /*A65=0079*/
                                   input wexcel.moddes ,  
                                   input  nv_totsi      ,  
                                   INPUT  "X" ,  
                                   input  SUBSTR(nv_class,2,5),   
                                   input  wexcel.yrmanu, 
                                   input  nv_engine  ,
                                   input  0 , 
                                   INPUT-OUTPUT wexcel.modcod) .
            END.

            IF wexcel.modcod <> ""  THEN ASSIGN sic_bran.uwm301.modcod = wexcel.modcod .
            ELSE DO:
             ASSIGN
                  wexcel.werror = wexcel.werror + "Redbook is Null !!  |"
                  wexcel.wmark  = NO.
            END.
        END.

        FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wexcel.makdes AND 
                                        maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
            IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

        IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
            IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
               MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
               ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
               MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                 DAY(sic_bran.uwm100.expdat)     =   01                             AND
               MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
            THEN DO:
              nv_polday = 365.
            END.
            ELSE DO:
              nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
            END.
        END.

        IF nv_polday < 365 THEN DO:
            nv_polday  = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat).
        END.

    RUN WUW\WUWPADP3.P(INPUT sic_bran.uwm100.policy,
                       INPUT nv_campcd , 
                       INPUT sic_bran.uwm100.rencnt,
                       INPUT sic_bran.uwm100.endcnt,
                       INPUT 0  ,
                       INPUT 1 ,
                       INPUT 1 ,  
                       INPUT nv_batchyr, 
                       INPUT nv_batchno,
                       INPUT nv_batcnt , 
                       INPUT nv_polday ,
                       INPUT USERID(LDBNAME(1))  ,
                       INPUT "wgwnlgen"  ,
                       INPUT-OUTPUT nv_covcod ,
                       INPUT-OUTPUT nv_class  ,
                       INPUT-OUTPUT nv_vehuse ,
                       INPUT-OUTPUT nv_cstflg ,
                       INPUT-OUTPUT nv_engcst ,
                       INPUT-OUTPUT nv_drivno ,
                       INPUT-OUTPUT nv_driage1,
                       INPUT-OUTPUT nv_driage2,
                       INPUT-OUTPUT nv_pdprm0 , 
                       INPUT-OUTPUT nv_yrmanu ,
                       INPUT-OUTPUT nv_totsi  ,
                       INPUT-OUTPUT nv_totfi  ,
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
                       INPUT-OUTPUT nv_tpbi2si, 
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,
                       INPUT-OUTPUT nv_41prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_412prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_413prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_414prmt,   /* ระบุเบี้ย รย.*/
                       INput-output nv_42prmt,   /* ระบุเบี้ย รย.*/
                       INput-output nv_43prmt,   /* ระบุเบี้ย รย.*/
                       INPUT-OUTPUT nv_seat41,              
                       INPUT-OUTPUT nv_dedod,    
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,    
                       input-output nv_dodamt,   /* ระบุเบี้ย DOD */ 
                       input-output nv_dadamt,   /* ระบุเบี้ย DOD1 */ 
                       input-output nv_dpdamt,   /* ระบุเบี้ย DPD */ 
                       INPUT-OUTPUT nv_ncbp,     
                       INPUT-OUTPUT nv_fletp,    
                       INPUT-OUTPUT nv_dspcp,    
                       INPUT-OUTPUT nv_dstfp,    
                       INPUT-OUTPUT nv_clmp,     
                       input-output nv_ncbamt ,  /* ระบุเบี้ย  NCB PREMIUM */       
                       input-output nv_fletamt,  /* ระบุเบี้ย  FLEET PREMIUM */     
                       input-output nv_dspcamt,  /* ระบุเบี้ย  DSPC PREMIUM */      
                       input-output nv_dstfamt,  /* ระบุเบี้ย  DSTF PREMIUM */      
                       input-output nv_clmamt ,  /* ระบุเบี้ย  LOAD CLAIM PREMIUM */
                       INPUT-OUTPUT nv_baseprm,
                       INPUT-OUTPUT nv_baseprm3,
                       INPUT-OUTPUT nv_mainprm,  /* Main Premium หรือเบี้ยหลัก ช่อง Name/Unname Premium (HG) */
                       INPUT-OUTPUT nv_pdprem,
                       INPUT-OUTPUT nv_netprem, 
                       INPUT-OUTPUT nv_gapprem,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       input-output nv_attgap ,   /*a65-0079*/
                       input-output nv_atfltgap,  /*a65-0079*/
                       input-output nv_atncbgap,  /*a65-0079*/
                       input-output nv_atdscgap,  /*a65-0079*/
                       input-output nv_packatt ,  /*a65-0079*/
                       INPUT-OUTPUT nv_fcctv ,  /* cctv = yes/no */
                       INPUT-OUTPUT nv_flgsht , /* Short rate = "S" , Pro rate = "P" */
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       output nv_gapprm ,
                       output nv_pdprm  ,
                       OUTPUT nv_status ,
                       OUTPUT nv_message ).
    ASSIGN                        
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 

    /*IF nv_status = "NO" THEN DO:*/
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wexcel.wmark  = NO. /*A65-0043*/
        ASSIGN   wexcel.werror = wexcel.werror + "|" + nv_message.
    END. 
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremtNew C-Win 
PROCEDURE proc_calpremtNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

FIND LAST wexcamp WHERE wexcamp.policy    = TRIM(wexcel.policy)  NO-LOCK NO-ERROR .
IF AVAIL wexcamp THEN DO:
    fi_display = "Calculate Premium policy: " + wexcel.policy.
    DISP fi_display WITH FRAME fr_main.
    ASSIGN                                                  /*Add A67-0029*/
        nv_polday  = 0          nv_baseprm  = 0             nv_diffprm    = 0   
        nv_covcod  = ""         nv_baseprm3 = 0             nv_totfi      = 0   
        nv_class   = ""         nv_pdprem   = 0             nv_newpdprm   = 0   
        nv_vehuse  = ""         nv_netprem  = 0             nv_newgpprm   = 0   
        nv_cstflg  = ""         nv_gapprm   = 0             nv_adjpaprm   = NO  
        nv_engcst  = 0          nv_flagprm  = "N"           nv_adjprem    = NO  
        /*nv_drivno  = 0*/      nv_effdat   = ?             nv_flgpol     = ""  
        nv_driage1 = 0          nv_ratatt   = 0             nv_flgclm     = ""  
        nv_driage2 = 0          nv_siatt    = 0             cv_lfletper   = 0   
        nv_pdprm0  = 0          nv_netatt   = 0             cv_lncbper    = 0   
        nv_yrmanu  = 0          nv_fltatt   = 0             cv_ldssper    = 0   
        nv_totsi   = 0          nv_ncbatt   = 0             cv_lclmper    = 0   
        nv_totfi   = 0          nv_dscatt   = 0             cv_ldstfper   = 0   
        nv_vehgrp  = ""         nv_atfltgap = 0             nv_reflag     = NO  
        nv_access  = ""         nv_atncbgap = 0             nv_ncbyrs     = 0   
        nv_supe    = NO         nv_atdscgap = 0             nv_attgapt    = 0   
        nv_tpbi1si = 0          nv_packatt  = ""            nv_packatt1   = ""  
        nv_tpbi2si = 0          nv_flgsht   = ""            nv_chgflg     = NO  
        nv_tppdsi  = 0          nv_status   = ""            nv_chgrate    = 0   
        nv_411si   = 0          nv_fcctv    = NO            nv_chgsi      = 0   
        nv_412si   = 0          nv_uom1_c   = ""            nv_chgpdprm   = 0                            
        nv_413si   = 0          nv_uom2_c   = ""            nv_chggapprm  = 0                            
        nv_414si   = 0          nv_uom5_c   = ""            nv_battflag   = NO                            
        nv_42si    = 0          nv_uom6_c   = ""            nv_battrate   = 0                           
        nv_43si    = 0          nv_uom7_c   = ""            nv_battsi     = 0                           
        nv_41prmt  = 0          nv_message  = ""            nv_battprice  = 0                          
        nv_412prmt = 0          /* A65-0079*/               nv_battpdprm  = 0   
        nv_413prmt = 0          nv_mainprm = 0              nv_battgapprm = 0   
        nv_414prmt = 0          nv_ncbamt  = 0              nv_battyr     = 0   
        nv_42prmt  = 0          nv_fletamt = 0              nv_battper    = 0   
        nv_43prmt  = 0          nv_dspcamt = 0              nv_compprm    = 0   
        nv_seat41  = 0          nv_dstfamt = 0              nv_uom9_v     = 0   
        nv_dedod   = 0          nv_clmamt  = 0              nv_evflg      = NO  
        nv_addod   = 0          /* end : A65-0079 */        /*End Add A67-0029*/ 
        nv_dedpd   = 0          nv_dspcp   = 0 
        nv_ncbp    = 0          nv_dstfp   = 0 
        nv_fletp   = 0          nv_clmp    = 0 
        .

    RUN PdAssignDataCalNew.
    RUN PdCalPremNew.
    
    ASSIGN                        
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0.
    
    IF nv_message <> "" THEN DO:   /*A65-0079*/
        IF INDEX(nv_message,"Not Found Benefit") <> 0 THEN ASSIGN wexcel.wmark  = NO. /*A65-0043*/
        ASSIGN   wexcel.werror = wexcel.werror + "|" + nv_message.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkispno C-Win 
PROCEDURE proc_chkispno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_list      AS INT init 0.                     
DEF VAR n_count     AS INT init 0.                     
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".    
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".    
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".    
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".    
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".  
DEF VAR n_repair2      AS CHAR FORMAT "x(100)" init "".  
DEF VAR nv_repair2     AS CHAR FORMAT "x(100)" init "".  
DEF VAR nv_damdetail2  AS CHAR FORMAT "x(500)" init "".  
DEF VAR nv_damdetail AS LONGCHAR  INIT "".             
DEF VAR n_agent      AS CHAR FORMAT "x(12)" INIT "".  

DO:
    FOR EACH wexcel WHERE wexcel.cha_no <> "" .
       ASSIGN  nv_year     = ""     nv_docno  = ""      nv_survey   = ""    nv_detail  = ""     nv_remark1 = ""     nv_remark2  = ""
               nv_damlist  = ""     nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
               nv_acc2     = ""     nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
               nv_acc8     = ""     nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = ""
               nv_surdata  = ""     nv_tmp    = ""      nv_date     = ""    n_agent    = ""     nv_damdetail = ""
               nv_year     = TRIM(fi_ispyr)   n_repair2 = ""   nv_repair2 = ""   nv_damdetail2 = ""
               nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".

       /*--------- Server Real ----------*/
       nv_server = "Safety_NotesServer/Safety".
       nv_tmp   = "safety\uw\" + nv_tmp .
       /*------------------------------*/
       /*---------- Server test local -------
       nv_server = "".
       nv_tmp    = "D:\Lotus\Notes\Data\" + nv_tmp .
       -----------------------------*/
       CREATE "Notes.NotesSession"  chNotesSession.
       chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
                    
         IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
            MESSAGE "Can not open database" SKIP  
                    "Please Check database and server" VIEW-AS  ALERT-BOX ERROR.
         END.
         ELSE DO:
           chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
           chNavView      = chNotesView:CreateViewNav.
           chDocument     = chNotesView:GetDocumentByKey(TRIM(wexcel.cha_no)).
          
          IF VALID-HANDLE(chDocument) = YES THEN DO:
              chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
              IF chitem <> 0 THEN nv_date = chitem:TEXT. 
              ELSE nv_date = "".
        
              chitem       = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
              IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
              ELSE nv_docno = "".
              
              chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
              IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
              ELSE nv_survey = "".
              
              chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
              IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
              ELSE nv_detail = "".
              
              IF nv_detail = "ติดปัญหา" THEN DO:
                  chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
                  IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
                  ELSE nv_damage = "".
              END.
              IF nv_detail = "มีความเสียหาย"  THEN DO:
                  chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
                  IF chitem <> 0 THEN nv_damlist    = chitem:TEXT.
                  ELSE nv_damlist = "".
                  /*chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
                  IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
                  ELSE nv_totaldam = "".*/
                  /*Add A66-0069*/ 
                  chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
                  IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
                  ELSE nv_totaldam = "".
                  /*End A66-0069*/ 
                  IF nv_damlist <> "" THEN DO: 
                      ASSIGN n_list     = INT(nv_damlist)
                             nv_damlist = "จำนวนความเสียหาย " + nv_damlist + " รายการ " .
                  END.
                  /*IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหายทั้งสิ้น " + nv_totaldam + " บาท " .*/
        
                  IF n_list > 0  THEN DO:
                    ASSIGN  n_count = 1 .
                    loop_damage:
                    REPEAT:
                        IF n_count <= n_list THEN DO:
                            ASSIGN  n_dam    = "List"   + STRING(n_count) 
                                    n_repair  = "Damage" + STRING(n_count) 
                                    n_repair2 = "Repair" + STRING(n_count).

                            
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
                                ASSIGN 
                                nv_damdetail  = nv_damdetail + string(n_count) + "."  + nv_damag + nv_repair + " , "  
                                nv_damdetail2 = nv_damdetail2 + string(n_count) + "." + nv_damag + nv_repair2 + " , " .
                                
                            n_count = n_count + 1.
                        END.
                        ELSE LEAVE loop_damage.
                    END.
                END.
        
              END. /* end ความเสียหาย */
              /*-- ข้อมูลอื่น ๆ ---*/
              /*chitem       = chDocument:Getfirstitem("SurveyData").
              IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
              ELSE nv_surdata = "".
              IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata.
              /*agentCode*/
              chitem       = chDocument:Getfirstitem("agentCode").      
              IF chitem <> 0 THEN n_agent = chitem:TEXT. 
              ELSE n_agent = "".
              IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.*/
        
              /*-- อุปกรณ์เสริม --*/  
              chitem       = chDocument:Getfirstitem("device1").
              IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
              ELSE nv_device = "".
        
              IF nv_device <> "" THEN DO:
                  /*chitem       = chDocument:Getfirstitem("pricesTotal").*/  /* ราคารวมอุปกรณ์เสริม */
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
                  IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1).
                  IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2).
                  IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3).
                  IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4).
                  IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5).
                  IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6).
                  IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7).
                  IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8).
                  IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9).
                  IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10).
                  IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11).
                  IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12) .
                  /*nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .*/
              END.
        
              IF nv_docno <> ""  THEN DO:
                  IF nv_survey <> "" THEN DO:
                        IF nv_detail = "ติดปัญหา" THEN DO:
                            ASSIGN  /*winsp.Insp_date      = nv_date
                                    winsp.Insp_Code      = "04"
                                    winsp.Insp_Result    = "RI-Request More Info"
                                    winsp.Insp_Detail    = nv_detail + " : " + nv_damage /* ความเสียหาย */ 
                                    winsp.Insp_Remark1   = nv_device + nv_acctotal       
                                    winsp.insp_remark2   = nv_surdata                    
                                    winsp.insp_no        = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                    winsp.insp_damage    = nv_damdetail                  /*รายการความเสียหาย */           
                                    winsp.insp_driver    = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                                    winsp.Insp_other     = nv_surdata   */               /*รายละเอียดอื่นๆ */
                                    wexcel.insnamtyp   = nv_totaldam                                                      /*A66-0069*/
                                    wexcel.campaign_ov = nv_detail + " : " + nv_damage  + nv_damdetail2  /* ความเสียหาย *//*A66-0069*/ 
                                    wexcel.isp         = nv_docno                 
                                    wexcel.f7          = nv_detail + " : " + nv_damdetail             
                                    wexcel.f8          = nv_device 
                                    wexcel.remark      = "Closed :" + nv_date.
                        END.
                        ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                            ASSIGN  /*winsp.Insp_date     = nv_date
                                    winsp.Insp_Code     = "03"
                                    winsp.Insp_Result   = "AC-Approved with Condition"
                                    winsp.Insp_Detail   = nv_detail + " : " + nv_damlist + nv_totaldam  /* ความเสียหาย */ 
                                    winsp.Insp_Remark1  = nv_damdetail
                                    winsp.insp_remark2  = nv_device + nv_acctotal + nv_surdata
                                    winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                    winsp.insp_damage   = nv_damdetail                  /*รายการความเสียหาย */           
                                    winsp.insp_driver   = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                                    winsp.Insp_other    = nv_surdata                    /*รายละเอียดอื่นๆ */
                                    winsp.insp_status   = "YES" */
                                    wexcel.insnamtyp   = nv_totaldam                                                                            /*A66-0069*/
                                    wexcel.campaign_ov = nv_detail + " : " + nv_damlist + nv_totaldam  + " " +  nv_damdetail2  /* ความเสียหาย *//*A66-0069*/  
                                    wexcel.isp         = nv_docno                 
                                    wexcel.f7          = nv_detail + " : " + nv_damdetail             
                                    wexcel.f8          = nv_device 
                                    wexcel.remark      = "Closed :" + nv_date.
                                    
                        END.
                        ELSE DO: 
                            ASSIGN  /*winsp.Insp_date     = nv_date
                                    winsp.Insp_Code     = "01"
                                    winsp.Insp_Result   = "AU-Approve"
                                    winsp.Insp_Detail   = nv_detail
                                    winsp.Insp_Remark1  = nv_device + nv_acctotal
                                    winsp.insp_remark2  = nv_surdata
                                    winsp.insp_no       = nv_docno                      /*เลขที่ตรวจสภาพ */              
                                    winsp.insp_damage   = ""                            /*รายการความเสียหาย */           
                                    winsp.insp_driver   = nv_device + nv_acctotal       /*รายละเอียดอุปกรณ์เสริม */      
                                    winsp.Insp_other    = nv_surdata                    /*รายละเอียดอื่นๆ */
                                    winsp.insp_status   = "YES" */
                                    wexcel.insnamtyp   = nv_totaldam  /*A66-0069*/ 
                                    wexcel.campaign_ov = nv_detail    /*A66-0069*/
                                    wexcel.isp         = nv_docno                 
                                    wexcel.f7          = nv_detail            
                                    wexcel.f8          = nv_device 
                                    wexcel.remark      = "Closed :" + nv_date.
                        END.
                  END. /* end servey*/
                  ELSE DO:
                      ASSIGN  /*winsp.insp_no      = nv_docno       
                              winsp.insp_status  = "NO"          
                              winsp.Insp_Detail  = ""
                              winsp.insp_damage  = ""                           /*รายการความเสียหาย */       
                              winsp.insp_driver  = nv_device + nv_acctotal      /*รายละเอียดอุปกรณ์เสริม */  
                              winsp.Insp_other   = nv_surdata .  */             /*รายละเอียดอื่นๆ */ 
                              wexcel.insnamtyp   = nv_totaldam                  /*A66-0069*/
                              wexcel.campaign_ov = ""                           /*A66-0069*/
                              wexcel.isp        = nv_docno                 
                              wexcel.f7         = ""            
                              wexcel.f8         = nv_device 
                              wexcel.remark     = "Open".
                  END.
              END. /* doc no */
              RELEASE  OBJECT chitem          NO-ERROR.
              RELEASE  OBJECT chDocument      NO-ERROR.          
              RELEASE  OBJECT chNotesDataBase NO-ERROR.     
              RELEASE  OBJECT chNotesSession  NO-ERROR.
          END. /* chkdoc = yes */
          ELSE DO:
               ASSIGN wexcel.remark = "Not found" .
          END.
        END.
        IF wexcel.remark = "" THEN wexcel.remark = "Not found" .
    END. /*end for wexcel*/
END. /* end do:*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportisp C-Win 
PROCEDURE proc_exportisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    OUTPUT TO VALUE(fi_output1).
    EXPORT DELIMITER "|"  
      "Policy No.  "       
      "Transfer_Date "     
      "Company_INS "       
      "Reference_no"       
      "Title   "           
      "Name    "           
      "Surname "           
      "ID_no   "           
      "Model Redcook"      
      "Brand_of_Auto"      
      "Model   "           
      "PropertiesCode  "   
      "MaintenanceType "   
      "License_No   "      
      "Province_Code"      
      "Chassis_No "        
      "Engine_No  "        
      "CC_GVW     "        
      "Weight_GVW "        
      "Body_Type  "        
      "Model_Year "        
      "Asset_Location"     
      "Asset_District"     
      "Asset_Zone    "     
      "Asset_Province"     
      "ZipCode     "       
      "Driver Type "       
      "Driver1_Name"       
      "Driver1 _ License No"
      "Driver1_ Birth Date "
      "Driver2_Name        "
      "Driver2_License No  "
      "Driver2 _Birth Date "
      "Sum_Insure_Amt"     
      "Type_of_Policy"     
      "Effective_date"     
      "Expirty_Date"       
      "Net_Premium "       
      "Tax    "            
      "Duty   "            
      "Total_Premium "     
      "Beneficiary_Surname "
      "Branch_Code"        
      "Branch_Name_Thai"   
      "Mailing_Address "   
      "Mailing_District"   
      "Mailing_Zone "      
      "Mailing_Province"   
      "Mailing_ZipCode "   
      "Inspection "        
      "F7    "             
      "F8    "             
      "Transaction_Type"   
      "Customer_Type "     
      "Quote_Type    "     
      "Payment_Type  "     
      "Campaign Code "     
      "Previous Policy "   
      "Old Expiry Date "   
      "Old Name     "      
      "Old Producer "      
      "Producer Code"      
      "Text F6 Line 1"     
      "Text F6 Line 2"     
      "Text F6 Line 3"     
      "Text F6 Line 4"     
      "Text F6 Line 5"     
      "Model Redcook "     
      "Veh Group "         
      "Premium Expiry"     
      "Old Chassis No "    
      "Remark " 
      "จำนวนความเสียหายทั้งสิ้น"  /*A66-0069*/
      "รายละเอียด"                /*A66-0069*/
        SKIP.
    FOR EACH wexcel  NO-LOCK:
       EXPORT DELIMITER "|"
        wexcel.newpol
        wexcel.trndat   
        wexcel.comins   
        wexcel.cedpol   
        wexcel.ntitle   
        wexcel.fname    
        wexcel.lname    
        wexcel.icno   
        wexcel.modcod
        wexcel.makdes   
        wexcel.moddes   
        wexcel.sclass   
        wexcel.garage   
        wexcel.vehreg   
        wexcel.provin   
        wexcel.cha_no   
        wexcel.eng_no   
        wexcel.engine   
        wexcel.gwv      
        wexcel.body     
        wexcel.yrmanu   
        wexcel.addr1    
        wexcel.addr2    
        wexcel.addr3    
        wexcel.addr4    
        wexcel.postcod  
        wexcel.driname   
        wexcel.drinam1  
        wexcel.drino1   
        wexcel.dribir1  
        wexcel.drinam2  
        wexcel.drino2   
        wexcel.dribir2  
        wexcel.si       
        wexcel.covcod   
        wexcel.comdat   
        wexcel.expdat   
        wexcel.netprm   
        wexcel.tax      
        wexcel.vat      
        wexcel.totprm   
        wexcel.bennam   
        wexcel.brncod   
        wexcel.brnnam   
        wexcel.baddr1   
        wexcel.baddr2   
        wexcel.baddr3   
        wexcel.baddr4   
        wexcel.bpostcod 
        wexcel.isp        
        wexcel.f7         
        wexcel.f8         
        wexcel.instyp      
        wexcel.custyp      
        wexcel.quotyp      
        wexcel.paycod   
        wexcel.campaign
        wexcel.prvpol   
        wexcel.oldexpdat
        wexcel.oldname  
        wexcel.oldacno  
        wexcel.acnocode 
        wexcel.tacc1    
        wexcel.tacc2    
        wexcel.tacc3    
        wexcel.tacc4    
        wexcel.tacc5   
        wexcel.modelRB  
        wexcel.vehgrp
        wexcel.prmexp 
        wexcel.cha_old
        wexcel.remark
        wexcel.insnamtyp    /*A66-0069*/
        wexcel.campaign_ov FORMAT "X(500)" /*A66-0069*/

        SKIP.
    END.
    OUTPUT CLOSE.
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_exportispNew C-Win 
PROCEDURE proc_exportispNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DO:
    OUTPUT TO VALUE(fi_output1).
    EXPORT DELIMITER "|"  
      "New Policy No.      "
      "Transfer_Date       "
      "Company_INS         "
      "Reference_no        "
      "Title               "
      "Name                "
      "Surname             "
      "ID_no               "
      "Birth_Date          "
      "Model Code          "
      "Brand_of_Auto       "
      "Model               "
      "PropertiesCode      "
      "MaintenanceType     "
      "License_No          "
      "Province_Code       "
      "Chassis_No          "
      "Engine_No           "
      "CC_GVW              "
      "Weight_GVW          "
      "Body_Type           "
      "Model_Year          "
      "Asset_Location      "
      "Asset_District      "
      "Asset_Zone          "
      "Asset_Province      "
      "ZipCode             "
      "Driver Type         "
      "Driver1_Name        "
      "Driver1 _ License No"
      "Driver1_Birth Date  "
      "Driver2_Name        "
      "Driver2_License No  "
      "Driver2_Birth Date  "
      "Driver3_Name        "
      "Driver3_License No  "
      "Driver3_Birth Date  "
      "Driver4_Name        "
      "Driver4_License No  "
      "Driver4_Birth Date  "
      "Driver5_Name        "
      "Driver5_License No  "
      "Driver5_Birth Date  "
      "Sum_Insure_Amt      "
      "Deductible_PD       "
      "Deductible_TP       "
      "Type_of_Policy      "
      "Effective_date      "
      "Expirty_Date        "
      "Net_Premium         "
      "Tax                 "
      "Duty                "
      "Total_Premium       "
      "Beneficiary_Surname "
      "Branch_Code         "
      "Branch_Name_Thai    "
      "Mailing_Title       "
      "Mailing_Name        "
      "Mailing_Surname     "
      "Mailing_Address     "
      "Mailing_District    "
      "Mailing_Zone        "
      "Mailing_Province    "
      "Mailing_ZipCode     "
      "Transaction_Type    "
      "Customer_Type       "
      "Premium_Type        "
      "Quote_Type          "
      "Payment_Type        "
      "Remark_Coverage     "
      "Bundle_CMI          "
      "CMI_Effective_Date  "
      "CMI_Expirty_Date    "
      "CMI_Total           "
      "Car_Color           "
      "Package_Refer       "
      "Inspection No.      "
      "Text F7             "
      "Text F8             "
      "Prev.Policy         "
      "Old Expiry Date     "
      "Old Insure Name     "
      "Old Account         "
      "Account Code        "
      "Accessory Text1     "
      "Accessory Text2     "
      "Accessory Text3     "
      "Accessory Text4     "
      "Accessory5          "
      "Model Code RB       "
      "Vehicle Group       "
      "Premium Expiry      "
      "Old Chassis No      "
      "Remark              "
      "จำนวนความเสียหายทั้งสิ้น"  /*A66-0069*/
      "รายละเอียด"                /*A66-0069*/
        SKIP.

    FOR EACH wexcel  NO-LOCK:

       IF wexcel.cmicdat = ? THEN nv_cpcdat = "". ELSE nv_cpcdat = STRING(DAY(wexcel.cmicdat),"99") + "/" + STRING(MONTH(wexcel.cmicdat),"99") + "/" + STRING(YEAR(wexcel.cmicdat),"9999").
       IF wexcel.cmiedat = ? THEN nv_cpedat = "". ELSE nv_cpedat = STRING(DAY(wexcel.cmiedat),"99") + "/" + STRING(MONTH(wexcel.cmiedat),"99") + "/" + STRING(YEAR(wexcel.cmiedat),"9999").

       EXPORT DELIMITER "|"
           wexcel.newpol      
           wexcel.trndat      
           wexcel.comins      
           wexcel.cedpol      
           wexcel.ntitle      
           wexcel.fname       
           wexcel.lname       
           wexcel.icno        
           wexcel.bridat      
           wexcel.modcod      
           wexcel.makdes      
           wexcel.moddes      
           wexcel.sclass      
           wexcel.garage      
           wexcel.vehreg      
           wexcel.provin      
           wexcel.cha_no      
           wexcel.eng_no      
           wexcel.engine      
           wexcel.gwv         
           wexcel.body        
           wexcel.yrmanu      
           wexcel.addr1       
           wexcel.addr2       
           wexcel.addr3       
           wexcel.addr4       
           wexcel.postcod     
           wexcel.driname     
           wexcel.drinam1     
           wexcel.drino1      
           wexcel.dribir1     
           wexcel.drinam2     
           wexcel.drino2      
           wexcel.dribir2     
           wexcel.drinam3     
           wexcel.drino3      
           wexcel.dribir3     
           wexcel.drinam4     
           wexcel.drino4      
           wexcel.dribir4     
           wexcel.drinam5     
           wexcel.drino5      
           wexcel.dribir5     
           wexcel.si          
           wexcel.dedpd       
           wexcel.dedtp       
           wexcel.covcod      
           wexcel.comdat      
           wexcel.expdat      
           wexcel.netprm      
           wexcel.tax         
           wexcel.vat         
           wexcel.totprm      
           wexcel.bennam      
           wexcel.brncod      
           wexcel.brnnam      
           wexcel.btitle      
           wexcel.bfname      
           wexcel.blname      
           wexcel.baddr1      
           wexcel.baddr2      
           wexcel.baddr3      
           wexcel.baddr4      
           wexcel.bpostcod    
           wexcel.instyp      
           wexcel.custyp      
           wexcel.prmtyp      
           wexcel.quotyp      
           wexcel.paycod      
           wexcel.campaign    
           wexcel.budcmi      
           nv_cpcdat    
           nv_cpedat   
           wexcel.cmiprm      
           wexcel.carcol      
           wexcel.pacref      
           wexcel.isp         
           wexcel.f7          
           wexcel.f8          
           wexcel.prvpol      
           wexcel.oldexpdat   
           wexcel.oldname     
           wexcel.oldacno     
           wexcel.acnocode    
           wexcel.tacc1       
           wexcel.tacc2       
           wexcel.tacc3       
           wexcel.tacc4       
           wexcel.tacc5       
           wexcel.modelRB     
           wexcel.vehgrp      
           wexcel.prmexp      
           wexcel.cha_old     
           wexcel.remark      
           wexcel.insnamtyp   
           wexcel.campaign_ov   FORMAT "X(500)"
        SKIP.
    END.
    OUTPUT CLOSE.
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchisp C-Win 
PROCEDURE proc_matchisp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wexcel:
    DELETE wexcel.
END.

INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.newpol
        wexcel.trndat   
        wexcel.comins   
        wexcel.cedpol   
        wexcel.ntitle   
        wexcel.fname    
        wexcel.lname    
        wexcel.icno   
        wexcel.modcod
        wexcel.makdes   
        wexcel.moddes   
        wexcel.sclass   
        wexcel.garage   
        wexcel.vehreg   
        wexcel.provin   
        wexcel.cha_no   
        wexcel.eng_no   
        wexcel.engine   
        wexcel.gwv      
        wexcel.body     
        wexcel.yrmanu   
        wexcel.addr1    
        wexcel.addr2    
        wexcel.addr3    
        wexcel.addr4    
        wexcel.postcod  
        wexcel.driname   
        wexcel.drinam1  
        wexcel.drino1   
        wexcel.dribir1  
        wexcel.drinam2  
        wexcel.drino2   
        wexcel.dribir2  
        wexcel.si       
        wexcel.covcod   
        wexcel.comdat   
        wexcel.expdat   
        wexcel.netprm   
        wexcel.tax      
        wexcel.vat      
        wexcel.totprm   
        wexcel.bennam   
        wexcel.brncod   
        wexcel.brnnam   
        wexcel.baddr1   
        wexcel.baddr2   
        wexcel.baddr3   
        wexcel.baddr4   
        wexcel.bpostcod 
        wexcel.isp        
        wexcel.f7         
        wexcel.f8         
        wexcel.instyp      
        wexcel.custyp      
        wexcel.quotyp      
        wexcel.paycod   
        wexcel.campaign
        wexcel.prvpol   
        wexcel.oldexpdat
        wexcel.oldname  
        wexcel.oldacno  
        wexcel.acnocode 
        wexcel.tacc1    
        wexcel.tacc2    
        wexcel.tacc3    
        wexcel.tacc4    
        wexcel.tacc5 
        wexcel.modelRB
        wexcel.vehgrp
        wexcel.prmexp
        wexcel.cha_old .

    IF index(wexcel.trndat,"Tran") <> 0 THEN DELETE wexcel.
    ELSE IF wexcel.trndat = "" THEN DELETE wexcel. 

    fi_display = "Please wait..Process Input Data...".
    DISP fi_display WITH FRAME fr_main.
END.
RUN proc_chkispno .
RUN proc_exportisp.
MESSAGE "Match Inspection Finish " VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchispNew C-Win 
PROCEDURE proc_matchispNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wexcel:
    DELETE wexcel.
END.

INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.newpol                 /*New Policy No.      */    
        wexcel.trndat                 /*Transfer_Date       */    
        wexcel.comins                 /*Company_INS         */    
        wexcel.cedpol                 /*Reference_no        */    
        wexcel.ntitle                 /*Title               */    
        wexcel.fname                  /*Name                */    
        wexcel.lname                  /*Surname             */    
        wexcel.icno                   /*ID_no               */    
        wexcel.bridat                 /*Birth_Date          */    
        wexcel.modcod                 /*Model Code          */    
        wexcel.makdes                 /*Brand_of_Auto       */    
        wexcel.moddes                 /*Model               */    
        wexcel.sclass                 /*PropertiesCode      */    
        wexcel.garage                 /*MaintenanceType     */    
        wexcel.vehreg                 /*License_No          */    
        wexcel.provin                 /*Province_Code       */    
        wexcel.cha_no                 /*Chassis_No          */    
        wexcel.eng_no                 /*Engine_No           */    
        wexcel.engine                 /*CC_GVW              */    
        wexcel.gwv                    /*Weight_GVW          */    
        wexcel.body                   /*Body_Type           */    
        wexcel.yrmanu                 /*Model_Year          */    
        wexcel.addr1                  /*Asset_Location      */    
        wexcel.addr2                  /*Asset_District      */    
        wexcel.addr3                  /*Asset_Zone          */    
        wexcel.addr4                  /*Asset_Province      */    
        wexcel.postcod                /*ZipCode             */    
        wexcel.driname                /*Driver Type         */    
        wexcel.drinam1                /*Driver1_Name        */    
        wexcel.drino1                 /*Driver1 _ License No*/    
        wexcel.dribir1                /*Driver1_Birth Date  */    
        wexcel.drinam2                /*Driver2_Name        */    
        wexcel.drino2                 /*Driver2_License No  */    
        wexcel.dribir2                /*Driver2_Birth Date  */    
        wexcel.drinam3                /*Driver3_Name        */    
        wexcel.drino3                 /*Driver3_License No  */    
        wexcel.dribir3                /*Driver3_Birth Date  */    
        wexcel.drinam4                /*Driver4_Name        */    
        wexcel.drino4                 /*Driver4_License No  */    
        wexcel.dribir4                /*Driver4_Birth Date  */    
        wexcel.drinam5                /*Driver5_Name        */    
        wexcel.drino5                 /*Driver5_License No  */    
        wexcel.dribir5                /*Driver5_Birth Date  */    
        wexcel.si                     /*Sum_Insure_Amt      */    
        wexcel.dedpd                  /*Deductible_PD       */    
        wexcel.dedtp                  /*Deductible_TP       */    
        wexcel.covcod                 /*Type_of_Policy      */    
        wexcel.comdat                 /*Effective_date      */    
        wexcel.expdat                 /*Expirty_Date        */    
        wexcel.netprm                 /*Net_Premium         */    
        wexcel.tax                    /*Tax                 */    
        wexcel.vat                    /*Duty                */    
        wexcel.totprm                 /*Total_Premium       */    
        wexcel.bennam                 /*Beneficiary_Surname */    
        wexcel.brncod                 /*Branch_Code         */    
        wexcel.brnnam                 /*Branch_Name_Thai    */    
        wexcel.btitle                 /*Mailing_Title       */    
        wexcel.bfname                 /*Mailing_Name        */    
        wexcel.blname                 /*Mailing_Surname     */    
        wexcel.baddr1                 /*Mailing_Address     */    
        wexcel.baddr2                 /*Mailing_District    */    
        wexcel.baddr3                 /*Mailing_Zone        */    
        wexcel.baddr4                 /*Mailing_Province    */    
        wexcel.bpostcod               /*Mailing_ZipCode     */    
        wexcel.instyp                 /*Transaction_Type    */    
        wexcel.custyp                 /*Customer_Type       */    
        wexcel.prmtyp                 /*Premium_Type        */    
        wexcel.quotyp                 /*Quote_Type          */    
        wexcel.paycod                 /*Payment_Type        */    
        wexcel.campaign               /*Remark_Coverage     */    
        wexcel.budcmi                 /*Bundle_CMI          */    
        wexcel.cmicdat                /*CMI_Effective_Date  */    
        wexcel.cmiedat                /*CMI_Expirty_Date    */    
        wexcel.cmiprm                 /*CMI_Total           */    
        wexcel.carcol                 /*Car_Color           */    
        wexcel.pacref                 /*Package_Refer       */    
        wexcel.isp                    /*Inspection No.      */    
        wexcel.f7                     /*Text F7             */    
        wexcel.f8                     /*Text F8             */    
        wexcel.prvpol                 /*Prev.Policy         */    
        wexcel.oldexpdat              /*Old Expiry Date     */    
        wexcel.oldname                /*Old Insure Name     */    
        wexcel.oldacno                /*Old Account         */    
        wexcel.acnocode               /*Account Code        */    
        wexcel.tacc1                  /*Accessory Text1     */    
        wexcel.tacc2                  /*Accessory Text2     */    
        wexcel.tacc3                  /*Accessory Text3     */    
        wexcel.tacc4                  /*Accessory Text4     */    
        wexcel.tacc5                  /*Accessory5          */    
        wexcel.modelRB                /*Model Code RB       */    
        wexcel.vehgrp                 /*Vehicle Group       */    
        wexcel.prmexp                 /*Premium Expiry      */    
        wexcel.cha_old                /*Old Chassis No      */    
        wexcel.remark                 /*Remark              */    
        wexcel.insnamtyp              /*ความเสียหายทั้งสิ้น */    
        wexcel.campaign_ov            /*รายละเอียด          */ 
        .

    IF index(wexcel.trndat,"Tran") <> 0 THEN DELETE wexcel.
    ELSE IF wexcel.trndat = "" THEN DELETE wexcel. 

    fi_display = "Please wait..Process Input Data...".
    DISP fi_display WITH FRAME fr_main.
END.

fi_display = "Process Input Data Complete...".
DISP fi_display WITH FRAME fr_main.

fi_display = "Please Wait Check Inspection...".
DISP fi_display WITH FRAME fr_main.

RUN proc_chkispno .
RUN proc_exportispNew.

fi_display = "Match Inspection New Finish...".
DISP fi_display WITH FRAME fr_main.

MESSAGE "Match Inspection New Finish " VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchtypins C-Win 
PROCEDURE proc_matchtypins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER  np_title      as char init "".
DEFINE INPUT  PARAMETER  np_name1      as char init "".
DEFINE OUTPUT PARAMETER  np_insnamtyp  as char init "".
DEFINE OUTPUT PARAMETER  np_firstName  as char init "".
DEFINE OUTPUT PARAMETER  np_lastName   as char init "".
DEFINE VAR               np_textname   AS CHAR INIT "".
ASSIGN np_textname = TRIM(np_title) + TRIM(np_name1).

IF  R-INDEX(TRIM(np_textname),"จก.")             <> 0  OR              
    R-INDEX(TRIM(np_textname),"จำกัด")           <> 0  OR  
    R-INDEX(TRIM(np_textname),"(มหาชน)")         <> 0  OR  
    R-INDEX(TRIM(np_textname),"INC.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"CO.")             <> 0  OR 
    R-INDEX(TRIM(np_textname),"LTD.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"LIMITED")         <> 0  OR 
    INDEX(TRIM(np_textname),"บริษัท")            <> 0  OR 
    INDEX(TRIM(np_textname),"บ.")                <> 0  OR 
    INDEX(TRIM(np_textname),"บจก.")              <> 0  OR 
    INDEX(TRIM(np_textname),"หจก.")              <> 0  OR 
    INDEX(TRIM(np_textname),"หสน.")              <> 0  OR 
    INDEX(TRIM(np_textname),"บรรษัท")            <> 0  OR 
    INDEX(TRIM(np_textname),"มูลนิธิ")           <> 0  OR 
    INDEX(TRIM(np_textname),"ห้าง")              <> 0  OR 
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วน")      <> 0  OR 
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
    INDEX(TRIM(np_textname),"และ/หรือ")          <> 0  THEN DO: 
    /*  Cs = นิติบุคคล */
    ASSIGN
    np_insnamtyp   = "CO"
    np_firstName   = TRIM(np_name1)
    np_lastName    = "".
     
END.
ELSE DO:
    np_insnamtyp   = "PR".
    IF INDEX(trim(np_name1)," ") <> 0 THEN
        ASSIGN
        np_firstName  = substr(TRIM(np_name1),1,INDEX(trim(np_name1)," ")) 
        np_lastName   = substr(TRIM(np_name1),INDEX(trim(np_name1)," ")) .
    ELSE ASSIGN       
        np_firstName  = TRIM(np_name1)
        np_lastName   = "".          

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
DEF VAR nv_msgstatus  as char.
DEF VAR nn_vehreglist as char.
DEF VAR nn_namelist   as char.
DEF VAR nn_namelist2  as char.
DEF VAR nv_chanolist  as char.
DEF VAR nv_idnolist   as char.
DEF VAR nv_CheckLog   as LOGICAL.   
DEF VAR nv_idnolist2  AS CHAR.
ASSIGN 
    nv_msgstatus   = ""
    nn_vehreglist  = ""
    nn_namelist    = ""
    nn_namelist2   = "" 
    nv_chanolist   = "" 
    nv_idnolist    = "" 
    nv_CheckLog    = YES
    nn_vehreglist  = trim(wexcel.vehreg)  
    nv_chanolist   = trim(wexcel.cha_no)  
    nv_idnolist    = trim(wexcel.icno) 
    nn_namelist    = trim(wexcel.firstname) /* A65-0203 */
    nn_namelist2   = trim(wexcel.lastname). /* A65-0203 */

/* comment by : A65-0203...
IF R-INDEX(wexcel.fname," ") <> 0 THEN DO:
    ASSIGN
    nn_namelist    = trim(SUBSTR(wexcel.fname,1,R-INDEX(wexcel.fname," ")))
    nn_namelist2   = trim(SUBSTR(wexcel.fname,R-INDEX(wexcel.fname," "))).
END.
ELSE DO: 
    ASSIGN
    nn_namelist    = TRIM(wexcel.fname) 
    nn_namelist2   = "".
END.
*/

IF wexcel.vehreg <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wexcel.werror =  " รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน |" 
            wexcel.wmark  = NO.                
                         
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wexcel.werror =  " ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน|" 
            wexcel.wmark  = NO.      
              
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wexcel.werror =  " ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน|" 
                wexcel.wmark  = NO.    
                
        END.
    END.
END.

IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
           wexcel.werror =  " รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน |" 
           wexcel.wmark  = NO.    
           
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:

    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wexcel.werror =  " IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน |" 
            wexcel.wmark  = NO.    
            
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
                wexcel.werror =  "IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน |" 
                wexcel.wmark  = NO.    
                
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

