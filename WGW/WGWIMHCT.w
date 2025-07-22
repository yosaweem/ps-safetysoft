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
wgwimtis.w :  Import text file from HCT  to create  new policy Add in table tlt( brstat)  
Program Import Text File    - File detail insured 
                            -  File detail Driver
Create  by   : Kridtiya i.  [A64-0414]  date. 27/11/2021
copy program : wuwimhct.w  
Connect    : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)
Modify by  : Kridtiya i. A65-0267 Date. 10/09/2022 ปรับเงื่อนไขการ แสดงรหัสตัวแทน
modify by  : Kridtiya i. A66-0162 Date .18/08/2023 เพิ่ม เงื่อนไขการแสดงรหัส Producer
modify by  : Kridtiya i. A67-0100 Date .01/06/2024 เพิ่ม เงื่อนไขการแสดงcheck vehreg
+++++++++++++++++++++++++++++++++++++++++++++++*/
{wgw\wgwimhct.i}      /*ประกาศตัวแปร*/
DEF     SHARED VAR n_User    AS CHAR. 
DEF     SHARED VAR n_Passwd  AS CHAR. 
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
DEF  STREAM nfile. 
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
DEF VAR nv_bridno AS CHAR INIT "". 
DEF VAR nv_72comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.   
DEF VAR nv_72expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.   
DEF VAR nv_fi       AS CHAR FORMAT "x(15)" INIT "". 
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
DEF VAR nv_producer  as CHAR.   
DEF VAR nv_agent     AS CHAR.
DEF VAR nvsuppect    AS CHAR.
DEF VAR nvckveherr    AS CHAR.
DEF BUFFER bbtlt  FOR brstat.tlt.
DEFINE new SHARED VAR chr_sticker  AS CHAR FORMAT "XXXXXXXXXXXXX".
DEFINE new SHARED VAR nv_modulo    AS INT  FORMAT "9".

DEF VAR n_saletyp AS CHAR INIT "".
DEF VAR n_garage  AS CHAR INIT "" .
DEF VAR n_notityp AS CHAR INIT "" .
DEF VAR n_covcod  AS CHAR INIT "" .

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
&Scoped-define INTERNAL-TABLES tlt wimproducer

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt tlt.comp_noti_ins ~
tlt.comp_noti_tlt tlt.comp_pol tlt.nor_effdat tlt.comp_effdat tlt.comp_sub ~
tlt.cifno tlt.nationality tlt.nor_noti_ins tlt.nor_noti_tlt tlt.nor_usr_ins ~
tlt.covcod tlt.nor_usr_tlt tlt.comp_usr_ins tlt.ins_title tlt.ins_name ~
tlt.ins_firstname tlt.ins_lastname 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt 
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for BROWSE br_producer                                   */
&Scoped-define FIELDS-IN-QUERY-br_producer wimproducer.idno wimproducer.saletype wimproducer.camname wimproducer.notitype wimproducer.producer   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_producer   
&Scoped-define SELF-NAME br_producer
&Scoped-define QUERY-STRING-br_producer FOR EACH wimproducer                        BY wimproducer.idno
&Scoped-define OPEN-QUERY-br_producer OPEN QUERY br_producer FOR EACH wimproducer                        BY wimproducer.idno    .
&Scoped-define TABLES-IN-QUERY-br_producer wimproducer
&Scoped-define FIRST-TABLE-IN-QUERY-br_producer wimproducer


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_producer fi_process fi_loaddat fi_compa ~
fi_filename bu_ok br_imptxt bu_exit bu_file fi_insp fi_proid fi_saletype ~
fi_camname fi_notitype fi_improducer bu_add bu_delete fi_campaign ~
fi_producer01 fi_agent rs_typfile RECT-1 RECT-79 RECT-80 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_process fi_loaddat fi_compa fi_filename ~
fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet fi_insp fi_proid ~
fi_saletype fi_camname fi_notitype fi_improducer fi_campaign fi_producer01 ~
fi_agent rs_typfile 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_add 
     LABEL "ADD" 
     SIZE 8 BY .95.

DEFINE BUTTON bu_delete 
     LABEL "DEL" 
     SIZE 8 BY .95.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_camname AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_campaign AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_improducer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 19 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_notitype AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY 1 NO-UNDO.

DEFINE VARIABLE fi_producer01 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proid AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_saletype AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_typfile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "TEXT", 1,
"CSV", 2
     SIZE 18 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 19.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 127 BY 1.52.

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

DEFINE QUERY br_producer FOR 
      wimproducer SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      tlt.comp_noti_ins COLUMN-LABEL "เลขที่ใบคำขอ" FORMAT "x(10)":U
      tlt.comp_noti_tlt COLUMN-LABEL "วันที่ใบคำขอ" FORMAT "x(10)":U
      tlt.comp_pol COLUMN-LABEL "เลขที่รับแจ้ง" FORMAT "x(32)":U
      tlt.nor_effdat FORMAT "99/99/9999":U
      tlt.comp_effdat FORMAT "99/99/9999":U
      tlt.comp_sub COLUMN-LABEL "รหัสย่อยบ.ประกัน" FORMAT "x(10)":U
      tlt.cifno COLUMN-LABEL "ประเภทรถ" FORMAT "x(4)":U
      tlt.nationality COLUMN-LABEL "ประเภทการขาย" FORMAT "x(1)":U
      tlt.nor_noti_ins COLUMN-LABEL "ประเภทแคมเปญ" FORMAT "x(16)":U
      tlt.nor_noti_tlt COLUMN-LABEL "จำนวนเงินที่เรียกเก็บ" FORMAT "x(10)":U
      tlt.nor_usr_ins COLUMN-LABEL "จำนวนเงินที่เรียกเก็บ" FORMAT "x(1)":U
      tlt.covcod COLUMN-LABEL "ประเภทประกัน" FORMAT "x(9)":U
      tlt.nor_usr_tlt COLUMN-LABEL "ประเภทการซ่อม" FORMAT "x(6)":U
      tlt.comp_usr_ins COLUMN-LABEL "ผู้บันทึก" FORMAT "x(30)":U
      tlt.ins_title COLUMN-LABEL "คำนำหน้า" FORMAT "x(20)":U
      tlt.ins_name COLUMN-LABEL "ชื่อลูกค้า" FORMAT "x(50)":U
      tlt.ins_firstname COLUMN-LABEL "ชื่อกลาง" FORMAT "x(60)":U
      tlt.ins_lastname COLUMN-LABEL "ชื่อกลาง" FORMAT "x(60)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 127.83 BY 8.1
         BGCOLOR 15  ROW-HEIGHT-CHARS .76.

DEFINE BROWSE br_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_producer C-Win _FREEFORM
  QUERY br_producer DISPLAY
      wimproducer.idno        COLUMN-LABEL "ID"           FORMAT "x(3)"
      wimproducer.saletype    COLUMN-LABEL "ประเภทการขาย" FORMAT "x(5)"
      wimproducer.camname     COLUMN-LABEL "ชื่อแคมเปญ"   FORMAT "x(15)"
      wimproducer.notitype    COLUMN-LABEL "การแจ้งงาน"   FORMAT "x(2)"
      wimproducer.producer    COLUMN-LABEL "รหัสตัวแทน"   FORMAT "x(10)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 59 BY 4.33
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .5 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_producer AT ROW 2.95 COL 70.83 WIDGET-ID 100
     fi_process AT ROW 8.86 COL 4 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_loaddat AT ROW 1.52 COL 32.67 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.52 COL 66.67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 7.67 COL 36.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 8.05 COL 108.17
     br_imptxt AT ROW 12.43 COL 3
     bu_exit AT ROW 8.1 COL 119.5
     bu_file AT ROW 7.67 COL 98.83
     fi_impcnt AT ROW 10.05 COL 33.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 10.05 COL 68.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 11.24 COL 33.5 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 11.24 COL 68.17 COLON-ALIGNED NO-LABEL
     fi_insp AT ROW 8.95 COL 80 COLON-ALIGNED NO-LABEL
     fi_proid AT ROW 2.91 COL 9 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_saletype AT ROW 2.91 COL 33 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_camname AT ROW 2.91 COL 48.17 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_notitype AT ROW 4.1 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_improducer AT ROW 4.1 COL 34.83 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     bu_add AT ROW 4.1 COL 51.83 WIDGET-ID 6
     bu_delete AT ROW 4.1 COL 60.67 WIDGET-ID 8
     fi_campaign AT ROW 5.29 COL 54.67 COLON-ALIGNED NO-LABEL WIDGET-ID 30
     fi_producer01 AT ROW 5.24 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_agent AT ROW 6.24 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 34
     rs_typfile AT ROW 1.62 COL 108.5 NO-LABEL WIDGET-ID 42
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 10.05 COL 47
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "   Producer  :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 5.24 COL 15.5 WIDGET-ID 38
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "        ข้อมูลผู้ขับขี่นำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 11.24 COL 6
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "           กรุณาป้อนชื่อไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 7.67 COL 8.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 11.24 COL 82.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 10.05 COL 82.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 10.05 COL 6
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 11.24 COL 47
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "IDNO:" VIEW-AS TEXT
          SIZE 6.5 BY .95 AT ROW 2.91 COL 4 WIDGET-ID 22
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.52 COL 5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รหัสตัวแทน:" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 4.1 COL 25.83 WIDGET-ID 26
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 11.24 COL 54.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.52 COL 52
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Type file :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 1.57 COL 97 WIDGET-ID 46
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 130.67 BY 20.43
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Agent Code :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.24 COL 15.5 WIDGET-ID 40
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ชื่อแคมเปญ:" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 2.91 COL 39.33 WIDGET-ID 24
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 10.05 COL 54.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "การแจ้งงาน N/R/S:" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 4.1 COL 3 WIDGET-ID 20
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 5.29 COL 46 WIDGET-ID 32
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ชนิดการขายN/C/S:" VIEW-AS TEXT
          SIZE 18 BY .95 AT ROW 2.91 COL 16.83 WIDGET-ID 28
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ปีที่ค้นหาและเพิ่มข้อมูลของกล่อง Inspection" VIEW-AS TEXT
          SIZE 34 BY .62 AT ROW 9.24 COL 47.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-1 AT ROW 1 COL 1
     RECT-79 AT ROW 7.57 COL 106.5
     RECT-80 AT ROW 7.57 COL 118.33
     RECT-380 AT ROW 1.29 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 130.67 BY 20.43
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
         TITLE              = "Import text file HCT"
         HEIGHT             = 20.38
         WIDTH              = 130.5
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
IF NOT C-Win:LOAD-ICON("adeicon/client.ico":U) THEN
    MESSAGE "Unable to load icon: adeicon/client.ico"
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
/* BROWSE-TAB br_producer 1 fr_main */
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.comp_noti_ins
"tlt.comp_noti_ins" "เลขที่ใบคำขอ" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.comp_noti_tlt
"tlt.comp_noti_tlt" "วันที่ใบคำขอ" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.comp_pol
"tlt.comp_pol" "เลขที่รับแจ้ง" "x(32)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   = brstat.tlt.nor_effdat
     _FldNameList[5]   = brstat.tlt.comp_effdat
     _FldNameList[6]   > brstat.tlt.comp_sub
"tlt.comp_sub" "รหัสย่อยบ.ประกัน" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.cifno
"tlt.cifno" "ประเภทรถ" "x(4)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.nationality
"tlt.nationality" "ประเภทการขาย" "x(1)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "ประเภทแคมเปญ" "x(16)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "จำนวนเงินที่เรียกเก็บ" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.nor_usr_ins
"tlt.nor_usr_ins" "จำนวนเงินที่เรียกเก็บ" "x(1)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.covcod
"tlt.covcod" "ประเภทประกัน" "x(9)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.nor_usr_tlt
"tlt.nor_usr_tlt" "ประเภทการซ่อม" "x(6)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.comp_usr_ins
"tlt.comp_usr_ins" "ผู้บันทึก" "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.ins_title
"tlt.ins_title" "คำนำหน้า" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.ins_name
"tlt.ins_name" "ชื่อลูกค้า" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.ins_firstname
"tlt.ins_firstname" "ชื่อกลาง" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.ins_lastname
"tlt.ins_lastname" "ชื่อกลาง" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_producer
/* Query rebuild information for BROWSE br_producer
     _START_FREEFORM
OPEN QUERY br_producer FOR EACH wimproducer
                       BY wimproducer.idno    .
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_producer */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import text file HCT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import text file HCT */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_producer
&Scoped-define SELF-NAME br_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_producer C-Win
ON ROW-DISPLAY OF br_producer IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    wimproducer.idno    :BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.saletype:BGCOLOR IN BROWSE br_producer = z NO-ERROR.  
    wimproducer.camname :BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.notitype:BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.producer:BGCOLOR IN BROWSE br_producer = z NO-ERROR.
    wimproducer.idno:FGCOLOR IN BROWSE br_producer = s NO-ERROR.  
    wimproducer.saletype:FGCOLOR IN BROWSE br_producer = s NO-ERROR.  
    wimproducer.camname :FGCOLOR IN BROWSE br_producer = s NO-ERROR. 
    wimproducer.notitype:FGCOLOR IN BROWSE br_producer = s NO-ERROR.
    wimproducer.producer:FGCOLOR IN BROWSE br_producer = s NO-ERROR.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_proid = "" THEN DO:
        MESSAGE " IDNO. เป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_proid .
        RETURN NO-APPLY.
    END.
    IF fi_saletype = "" THEN DO:
        MESSAGE " ประเภทการขายเป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_saletype .
        RETURN NO-APPLY.
    END.
    IF fi_notitype = "" THEN DO:
        MESSAGE " ประเภทการแจ้งงานเป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_notitype .
        RETURN NO-APPLY.
    END.
    IF fi_improducer = "" THEN DO:
        MESSAGE " รหัสตัวแทนเป็นค่าว่างกรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_improducer.
        RETURN NO-APPLY.
    END.
    FIND LAST wimproducer WHERE wimproducer.idno  = TRIM(fi_proid) NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAIL wimproducer THEN DO:
        MESSAGE "พบรหัส IDNO. " + TRIM(fi_proid)  +  "  นี้ในระบบ กรุณาตรวจสอบข้อมูลอีกครั้ง  !!!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_proid .
        RETURN NO-APPLY.
    END.
    FIND LAST wimproducer WHERE 
        /*wimproducer.idno     = TRIM(fi_proid)      AND */
        wimproducer.saletype = trim(fi_saletype)   AND
        wimproducer.camname  = trim(fi_camname)    AND 
        wimproducer.notitype = trim(fi_notitype)   AND
        wimproducer.producer = trim(fi_improducer) NO-ERROR NO-WAIT.
    IF  NOT AVAIL wimproducer THEN DO:
        FIND LAST brstat.insure WHERE brstat.insure.compno  =  fi_campaign AND 
            brstat.insure.lname  = wimproducer.idno      NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.insure THEN DO:
            CREATE brstat.insure. 
            ASSIGN
                brstat.insure.compno  =  fi_campaign
                brstat.insure.lname   =   TRIM(fi_proid)        
                brstat.Insure.InsNo   =   trim(fi_saletype)     
                brstat.insure.vatcode =   trim(fi_camname)      
                brstat.insure.text4   =   trim(fi_notitype)     
                brstat.insure.Text1   =   trim(fi_improducer)   .
            CREATE wimproducer.
            ASSIGN 
                wimproducer.idno       =  TRIM(fi_proid) 
                wimproducer.saletype   =  trim(fi_saletype)   
                wimproducer.camname    =  trim(fi_camname)    
                wimproducer.notitype   =  trim(fi_notitype)   
                wimproducer.producer   =  trim(fi_improducer) 
                fi_proid         = ""
                fi_saletype      =  ""
                fi_camname       =  ""
                fi_notitype      =  ""
                fi_improducer    =  "" .
        END.
        MESSAGE "บันทึกข้อมูลรายการนี้ได้เรียบร้อยแล้ว !!!" VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        MESSAGE "พบข้อมูลรายการนี้ได้เซตไว้แล้ว !!!" VIEW-AS ALERT-BOX.
    END.
    disp fi_proid fi_saletype fi_camname fi_camname fi_notitype  fi_improducer   with frame  fr_main.
    OPEN QUERY br_producer FOR EACH wimproducer BY wimproducer.idno.
        APPLY "ENTRY" TO fi_proid .
    disp fi_proid  fi_saletype  fi_camname  fi_notitype   fi_improducer    with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete C-Win
ON CHOOSE OF bu_delete IN FRAME fr_main /* DEL */
DO:
    GET CURRENT br_producer EXCLUSIVE-LOCK.
    FIND LAST brstat.insure WHERE brstat.insure.compno  =  fi_campaign AND 
        brstat.insure.lname  = wimproducer.idno      NO-ERROR NO-WAIT.
    IF  AVAIL brstat.insure THEN  DELETE brstat.insure. 
    DELETE wimproducer.
    /*FIND LAST wcomp WHERE wcomp.package  = fi_packcom NO-ERROR NO-WAIT.
        IF    AVAIL wcomp THEN DELETE wcomp.
        ELSE MESSAGE "Not found Package !!! in : " fi_packcom VIEW-AS ALERT-BOX.*/

    MESSAGE "ลบข้อมูลรายการนี้ได้เรียบร้อยแล้ว !!!" VIEW-AS ALERT-BOX.
    OPEN QUERY br_producer  FOR EACH wimproducer BY wimproducer.idno.
        APPLY "ENTRY" TO fi_proid IN FRAME fr_main.
        disp  fi_proid  with frame  fr_main.
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
    IF rs_typfile = 1 THEN DO:
        SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
                 FILTERS    "Text Documents" "*.txt"    
         
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.
    END.
    /* A68-0061 */
    ELSE DO:
          SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
                 FILTERS    "Text Documents" "*.csv"    
         
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.

    END.
    /* end A68-0061 */

    IF OKpressed = TRUE THEN DO:
        fi_filename  = cvData.
        DISP fi_filename WITH FRAME fr_main.     
    END.
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
    Run  Import_notification.    /*ไฟล์แจ้งงาน กรมธรรม์*/
    RUN  Proc_updateproducer.

    RELEASE brstat.tlt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    ASSIGN 
        
        fi_agent = "B3M0059".     
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
         sicsyac.xmm600.acno  =  Input fi_agent  
    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
             Message  "Not on Name & Address Master File xmm600" 
             View-as alert-box.
             Apply "Entry" To  fi_agent.
             RETURN NO-APPLY.  
        END.
        ELSE DO:  
            ASSIGN
            
            fi_agent   =  caps(INPUT  fi_agent)  .
            
            
        END.  
    END.  
    
    Disp  fi_agent WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camname C-Win
ON LEAVE OF fi_camname IN FRAME fr_main
DO:
    fi_camname  = CAPS(Input  fi_camname ) .
    Disp  fi_camname  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaign
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaign C-Win
ON LEAVE OF fi_campaign IN FRAME fr_main
DO:
    fi_campaign  = CAPS(Input  fi_campaign ) .
    Disp  fi_campaign  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_improducer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_improducer C-Win
ON LEAVE OF fi_improducer IN FRAME fr_main
DO:
  fi_improducer  = CAPS(Input  fi_improducer ) .
  Disp  fi_improducer  with  frame  fr_main.
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


&Scoped-define SELF-NAME fi_notitype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notitype C-Win
ON LEAVE OF fi_notitype IN FRAME fr_main
DO:
  fi_notitype  = CAPS(Input  fi_notitype ) .
  Disp  fi_notitype  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer01 C-Win
ON LEAVE OF fi_producer01 IN FRAME fr_main
DO:
    fi_producer01 = INPUT fi_producer01.
    ASSIGN  
        fi_producer01 = "B3M0059".  
    fi_producer01 = INPUT fi_producer01.
    IF fi_producer01 <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producer01  
            NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_producer01.
            RETURN NO-APPLY.  
            END.
            ELSE DO:  
                ASSIGN
                     
                    fi_producer01   =  caps(INPUT  fi_producer01) .
                             
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_producer01 <> ""*/
    
    Disp  fi_producer01  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_proid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_proid C-Win
ON LEAVE OF fi_proid IN FRAME fr_main
DO:
    fi_proid  = CAPS(Input  fi_proid ) .
    Disp  fi_proid  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_saletype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_saletype C-Win
ON LEAVE OF fi_saletype IN FRAME fr_main
DO:
    fi_saletype  = CAPS(Input  fi_saletype ) .
    Disp  fi_saletype  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_typfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_typfile C-Win
ON VALUE-CHANGED OF rs_typfile IN FRAME fr_main
DO:
  rs_typfile = INPUT rs_typfile .
  DISP rs_typfile WITH FRAME fr_main.
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
  
  gv_prgid = "wgwimhct".
  gv_prog  = "Import Text File to open policy HCT".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
    fi_loaddat     =  today
    fi_compa       = "HCT"
        
    fi_campaign = "CAM_HCT"
    fi_producer01  = "B3M0064"  
    fi_agent       = "B3M0058"   
    rs_typfile     = 2  /*A68-0061*/
       
      fi_insp     = STRING(YEAR(TODAY),"9999"). /* ranu insp */
  RUN proc_createpro.
  OPEN QUERY br_producer FOR EACH wimproducer  BY wimproducer.idno.
  disp  fi_loaddat    fi_compa fi_insp 
        fi_campaign
      fi_producer01
      fi_agent     
      rs_typfile /*A68-0061*/
      
      
      with  frame  fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_producer C-Win 
PROCEDURE 00-pd_producer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A68-0061...
IF wdetail.n_text011 = "T" OR wdetail.n_text011  = "0" THEN  RUN pd_producer1.  /*72*/
ELSE DO:
  IF index(wdetail.n_text116,"super pack") <> 0 THEN DO:                /* รายละเอียดเคมเปญ */
    FIND FIRST wimproducer WHERE
      wimproducer.saletype = TRIM(wdetail.n_text008)       AND   /* ประเภทการขาย */ 
      TRIM(wimproducer.camname) = TRIM(wdetail.n_text116)  AND   /* รายละเอียดเคมเปญ */ 
      wimproducer.notitype = TRIM(wdetail.n_text120)       /* ประเภทการแจ้งงาน  */ 
      NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL  wimproducer THEN ASSIGN   nv_producer  = wimproducer.producer   .
  END.    /* n_text055    as char   55    เลขที่กรมธรรมเดิม  */
  ELSE IF index(wdetail.n_text116,"TMSTH 0%") <> 0 OR index(wdetail.n_text116,"TMSTH0%") <> 0 OR index(wdetail.n_text116,"DEMON_H") <> 0 THEN  RUN pd_producer2.
  ELSE IF wdetail.n_text008 = "C" THEN DO:   /* ประเภทการขาย  */ 
    IF wdetail.n_text011 = "1"  AND wdetail.n_text120 = "S" THEN DO:    /* ประเภทการแจ้งงาน  */ 
      IF trim(wdetail.n_text013) = "GARAGE" AND   /*อู่*/
          (( YEAR(TODAY) - deci(wdetail.n_text044) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.n_text044) + 1 ) <= 10 ) THEN DO: 
          ASSIGN  nv_producer = "B3M0062".  
      END.
      ELSE ASSIGN  nv_producer = "B3M0065". 
    END.
    ELSE IF wdetail.n_text011 <> "1" AND (wdetail.n_text120 = "S" OR wdetail.n_text120 = "R" OR wdetail.n_text120 = "N") THEN DO:  
                ASSIGN  nv_producer = "B3M0062".
    END.
    ELSE DO: 
        FIND FIRST wimproducer WHERE 
            wimproducer.saletype      = TRIM(wdetail.n_text008) AND     /* ประเภทการขาย */ 
            TRIM(wimproducer.camname) = TRIM(wdetail.n_text116) AND     /* รายละเอียดเคมเปญ */ 
            wimproducer.notitype      = TRIM(wdetail.n_text120) NO-LOCK NO-ERROR NO-WAIT. /* ประเภทการแจ้งงาน  */ 
        IF AVAIL  wimproducer THEN  
             ASSIGN   nv_producer   = wimproducer.producer   .
        ELSE DO:          
            IF      INDEX(wdetail.n_text116,"DEMON_D")          <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0059".
            ELSE IF INDEX(wdetail.n_text116,"HATC CAMPAIGN_22") <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0063".
            ELSE IF INDEX(wdetail.n_text116,"HEI 22-D")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0061".
            ELSE IF INDEX(wdetail.n_text116,"HEI 22-S")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0061".
            ELSE IF INDEX(wdetail.n_text116,"HEI_CCTV")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0060".
            ELSE IF INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"TRIPLE PACK")      <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"HEI2Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"HEI3Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"TRIPLE PACK")      <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"HEI2Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "S" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"HEI3Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "S" THEN ASSIGN nv_producer = "B3M0062".
        END.
    END.
  END.
  ELSE IF wdetail.n_text008 = "H" THEN   ASSIGN nv_producer = "B3M0063". 
  ELSE DO:
      IF      wdetail.n_text011 = "1" AND TRIM(wdetail.n_text120) = "S" THEN DO: 
          IF  trim(wdetail.n_text013)  = "GARAGE"  AND 
              (( YEAR(TODAY) - deci(wdetail.n_text034) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.n_text034) + 1 ) <= 10 ) THEN DO:
              ASSIGN nv_producer = "B3M0062".  
          END.
          ELSE ASSIGN nv_producer = "B3M0065".  
      END.
      ELSE IF wdetail.n_text011 <> "1" AND ( TRIM(wdetail.n_text120) = "S" OR  TRIM(wdetail.n_text120) = "R" OR  TRIM(wdetail.n_text120) = "N") THEN DO:  
          ASSIGN nv_producer = "B3M0062". 
      END.
      ELSE DO: 
          FIND FIRST wimproducer WHERE
              wimproducer.saletype = TRIM(wdetail.n_text008)       AND   /* ประเภทการขาย */ 
              TRIM(wimproducer.camname) = TRIM(wdetail.n_text116)  AND   /* รายละเอียดเคมเปญ */ 
              wimproducer.notitype = TRIM(wdetail.n_text120)       /* ประเภทการแจ้งงาน  */ 
              NO-LOCK NO-ERROR NO-WAIT.  
          IF AVAIL  wimproducer THEN ASSIGN   nv_producer  = wimproducer.producer   .
      END.
  END.
END.

IF nv_producer = "" THEN ASSIGN  nv_producer = fi_producer01.
..end A68-0061...*/


 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_producer1 C-Win 
PROCEDURE 00-pd_producer1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A68-0061...
IF wdetail.n_text008 = "C" THEN DO:
    IF      index(wdetail.n_text116,"DEMON_D")     <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF index(wdetail.n_text116,"HEI 20-D")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 21-D")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 21-S")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 22-D")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 22_S")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI_CCTV")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0060".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")  <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK") <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"HEI2Plus")    <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0062".
    ELSE IF index(wdetail.n_text116,"HEI3Plus")    <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0062".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")  <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK") <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"HEI2Plus")    <> 0 AND wdetail.n_text120 = "S" THEN ASSIGN nv_producer = "B3M0062".
    ELSE IF index(wdetail.n_text116,"HEI3Plus")    <> 0 AND wdetail.n_text120 = "S" THEN ASSIGN nv_producer = "B3M0062". 
END.
ELSE IF wdetail.n_text008 = "F" AND index(wdetail.n_text116,"HLTC CAMPAIGN") <> 0  AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0068".
ELSE IF wdetail.n_text008 = "H" THEN DO:
    IF      index(wdetail.n_text116,"DEMON2YEAR_H")     <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF index(wdetail.n_text116,"HATC CAMPAIGN_20") <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0063".
    ELSE IF index(wdetail.n_text116,"HATC CAMPAIGN_21") <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0063".
    ELSE IF index(wdetail.n_text116,"HATC CAMPAIGN_22") <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0063".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")       <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H")     <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H1")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-HD")    <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK_H1")   <> 0 AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"DEMON2YEAR_H")     <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")       <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H")     <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H1")    <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-HD")    <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK_H1")   <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0066". 
    ELSE IF index(wdetail.n_text116,"TMSTH 0%")         <> 0 AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0058". 
    ELSE IF index(wdetail.n_text116,"TMSTH 0%")         <> 0 AND wdetail.n_text120 = "s" THEN ASSIGN nv_producer = "B3M0058".
    ELSE IF index(wdetail.n_text116,"DEMON_H")          <> 0                             THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF                                                      wdetail.n_text120 = "S" THEN ASSIGN nv_producer = "B3M0065".
END.
ELSE IF wdetail.n_text008 = "N" AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0060". 
ELSE IF wdetail.n_text008 = "N" AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF wdetail.n_text008 = "N" AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0064". 
ELSE IF wdetail.n_text008 = "N" AND wdetail.n_text120 = "S" THEN ASSIGN nv_producer = "B3M0065".
ELSE IF wdetail.n_text008 = "R" AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF wdetail.n_text008 = "R" AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0065". 
ELSE IF wdetail.n_text008 = "R" AND wdetail.n_text120 = "S" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF wdetail.n_text008 = "S" AND wdetail.n_text120 = "N" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF wdetail.n_text008 = "S" AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0064". 
ELSE IF wdetail.n_text008 = "S" AND wdetail.n_text120 = "R" THEN ASSIGN nv_producer = "B3M0065". 
ELSE IF wdetail.n_text008 = "S" AND wdetail.n_text120 = "S" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF wdetail.n_text008 = "S" AND wdetail.n_text120 = "S" THEN ASSIGN nv_producer = "B3M0065". 
ELSE ASSIGN nv_producer =  fi_producer01.
IF nv_producer = "" THEN ASSIGN nv_producer =  fi_producer01.
 ...end A68-0061...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pd_producer2 C-Win 
PROCEDURE 00-pd_producer2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF wdetail.n_text008 = "H" THEN DO:
    IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR  
             index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND wdetail.n_text120 = "R" THEN DO:
        IF wdetail.n_text055  <> ""  THEN DO:
            FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
                sicuw.uwm100.policy = wdetail.n_text055 
                No-lock No-error no-wait.
            IF AVAIL sicuw.uwm100  THEN 
                ASSIGN  nv_producer   = sicuw.uwm100.acno1 .
        END.
    END.
    ELSE IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR  
                  index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND  wdetail.n_text120 = "S" THEN DO:
        IF      wdetail.n_text011 = "1" AND wdetail.n_text013 = "honda"   THEN ASSIGN  nv_producer   = "B3M0065".
        ELSE IF wdetail.n_text011 = "T" OR  wdetail.n_text011  = "0"      THEN ASSIGN  nv_producer   = "B3M0058".
        ELSE ASSIGN  nv_producer   = "B3M0062".
    END.
    ELSE IF index(wdetail.n_text116,"DEMON_H") <> 0  THEN ASSIGN nv_producer   = "B3M0059".
END.
ELSE IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR
              index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND  wdetail.n_text120 = "R" THEN DO:
    IF wdetail.n_text055  <> "" THEN DO:
        FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
            sicuw.uwm100.policy = wdetail.n_text055 
            No-lock No-error no-wait.
        IF AVAIL sicuw.uwm100  THEN ASSIGN nv_producer   = sicuw.uwm100.acno1 .
    END.
END.
ELSE IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR  
              index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND  wdetail.n_text120 = "S" THEN DO:
    IF      wdetail.n_text011 = "1" AND wdetail.n_text013 = "honda" THEN ASSIGN  nv_producer   = "B3M0065" .
    ELSE IF wdetail.n_text011 = "T" OR  wdetail.n_text011 = "0"     THEN ASSIGN  nv_producer   = "B3M0058".
    ELSE ASSIGN  nv_producer   = "B3M0062".
END.
ELSE IF index(wdetail.n_text116,"DEMON_H")  <> 0 THEN ASSIGN  nv_producer   = "B3M0059".
IF nv_producer = ""  THEN DO:
    FIND FIRST wimproducer WHERE
        wimproducer.saletype = TRIM(wdetail.n_text008)       AND   /* ประเภทการขาย */ 
        TRIM(wimproducer.camname) = TRIM(wdetail.n_text116)  AND   /* รายละเอียดเคมเปญ */ 
        wimproducer.notitype = TRIM(wdetail.n_text120)       /* ประเภทการแจ้งงาน  */ 
        NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL  wimproducer THEN ASSIGN   nv_producer  = wimproducer.producer   .
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt C-Win 
PROCEDURE Create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
LOOP_wdetail:
FOR EACH wdetail NO-LOCK .
  ASSIGN   nv_producer  = ""
    nv_agent     = trim(fi_agent)
      nvsuppect  = ""  
      nvckveherr = "".
    RUN pd_producer.
    ASSIGN nv_bridno = "".
    RUN wgw\wgwimhct1 (INPUT wdetail.n_text092
                       ,OUTPUT nv_bridno).

    RUN proc_susspect  (INPUT TRIM(wdetail.n_text016)  
                       ,INPUT TRIM(wdetail.n_text018)  
                       ,INPUT TRIM(wdetail.n_text042)  
                       ,INPUT TRIM(wdetail.n_text043)  
                       ,INPUT TRIM(wdetail.n_text031)  
                       ,OUTPUT nvsuppect).
    nvckveherr = "".
    RUN proc_ckvehreg (INPUT TRIM(wdetail.n_text042)  /*Add A67-0100*/
                       ,OUTPUT nvckveherr).
    IF nvckveherr <> "" THEN nvsuppect = nvsuppect + " " + nvckveherr.
    nvckveherr = "".
    /*IF TRIM(wdetail.n_text012) = "พ.ร.บ." AND TRIM(wdetail.n_text054) <> "" THEN DO:*/ /*A68-0061*/
    IF (TRIM(wdetail.n_text012) = "พ.ร.บ."  OR TRIM(wdetail.n_text012) = "ภาคบังคับ" ) AND TRIM(wdetail.n_text054) <> "" THEN DO: /*A68-0061*/
        RUN proc_ckstk     (INPUT TRIM(wdetail.n_text054)
                            ,OUTPUT nvckveherr).
        IF nvckveherr <> "" THEN nvsuppect = nvsuppect + " " + nvckveherr.
    END.

  FIND LAST brstat.tlt USE-INDEX tlt06  WHERE
    brstat.tlt.comp_noti_ins = wdetail.n_text001 AND
    brstat.tlt.nor_usr_ins   = wdetail.n_text011 AND
    brstat.tlt.cha_no        = wdetail.n_text031 AND   
    brstat.tlt.genusr        = fi_compa          NO-ERROR NO-WAIT .
  IF NOT AVAIL brstat.tlt THEN DO: 
    CREATE brstat.tlt.
    nv_completecnt  =  nv_completecnt + 1.
    ASSIGN
      fi_process = "Create :" + wdetail.n_text001       
      brstat.tlt.comp_noti_ins = wdetail.n_text001      
      brstat.tlt.comp_noti_tlt = wdetail.n_text002      
      brstat.tlt.comp_pol      = wdetail.n_text003      
      brstat.tlt.nor_effdat    = date(wdetail.n_text004)  
      brstat.tlt.comp_effdat   = date(wdetail.n_text005) 
      brstat.tlt.comp_sub      = wdetail.n_text006      
      brstat.tlt.cifno         = wdetail.n_text007      
      brstat.tlt.nationality   = wdetail.n_text008        
      brstat.tlt.nor_noti_ins  = wdetail.n_text009        
      brstat.tlt.nor_noti_tlt  = wdetail.n_text010      
      brstat.tlt.nor_usr_ins   = wdetail.n_text011       
      brstat.tlt.covcod        = wdetail.n_text012      
      brstat.tlt.nor_usr_tlt   = wdetail.n_text013        
      brstat.tlt.comp_usr_ins  = wdetail.n_text014      
      brstat.tlt.ins_title     = wdetail.n_text015      
      brstat.tlt.ins_name      = wdetail.n_text016      
      brstat.tlt.ins_firstname = wdetail.n_text017      
      brstat.tlt.ins_lastname  = wdetail.n_text018      
      brstat.tlt.ins_addr      = wdetail.n_text019      
      brstat.tlt.ins_addr1     = wdetail.n_text020      
      brstat.tlt.ins_addr2     = wdetail.n_text021      
      brstat.tlt.ins_addr3     = wdetail.n_text022      
      brstat.tlt.lince2        = wdetail.n_text023      
      brstat.tlt.ins_addr5     = wdetail.n_text024      
      brstat.tlt.dir_occ1      = wdetail.n_text025      
      brstat.tlt.note28        = wdetail.n_text026      
      brstat.tlt.dri_ic1       = wdetail.n_text027      
      brstat.tlt.dri_lic1      = wdetail.n_text028      
      brstat.tlt.brand         = wdetail.n_text029      
      brstat.tlt.note10        = wdetail.n_text030      
      brstat.tlt.cha_no        = wdetail.n_text031      
      brstat.tlt.eng_no        = wdetail.n_text032      
      brstat.tlt.model         = wdetail.n_text033      
      brstat.tlt.note11        = wdetail.n_text034      
      brstat.tlt.note12        = wdetail.n_text035      
      brstat.tlt.note13        = wdetail.n_text036      
      brstat.tlt.note14        = wdetail.n_text037        
      brstat.tlt.vehuse        = wdetail.n_text038      
      brstat.tlt.seqno         = inte(wdetail.n_text039) 
      brstat.tlt.cc_weight     = inte(wdetail.n_text040)  
      brstat.tlt.colorcod      = wdetail.n_text041      
      brstat.tlt.lince1        = wdetail.n_text042      
      brstat.tlt.ins_addr4     = wdetail.n_text043      
      brstat.tlt.note15        = wdetail.n_text044      
      brstat.tlt.note16        = wdetail.n_text045      
      brstat.tlt.note17        = wdetail.n_text046        
      brstat.tlt.note18        = wdetail.n_text047        
      brstat.tlt.note19        = wdetail.n_text048        
      brstat.tlt.note2         = wdetail.n_text049        
      brstat.tlt.note20        = wdetail.n_text050        
      brstat.tlt.note21        = wdetail.n_text051      
      brstat.tlt.note22        = wdetail.n_text052      
      brstat.tlt.note23        = wdetail.n_text053        
      brstat.tlt.comp_sck      = wdetail.n_text054      
      brstat.tlt.note24        = wdetail.n_text055      
      brstat.tlt.dri_no1       = wdetail.n_text056      
      brstat.tlt.dri_no2       = wdetail.n_text057      
      brstat.tlt.note25        = wdetail.n_text058      
      brstat.tlt.dri_name1     = wdetail.n_text059      
      brstat.tlt.note26        = wdetail.n_text060      
      brstat.tlt.note27        = wdetail.n_text061      
      brstat.tlt.dri_occ2      = wdetail.n_text062      
      brstat.tlt.note4         = wdetail.n_text063      
      brstat.tlt.dri_ic2       = wdetail.n_text064      
      brstat.tlt.dri_lic2      = wdetail.n_text065      
      brstat.tlt.note29        = wdetail.n_text066      
      brstat.tlt.dri_name2     = wdetail.n_text067      
      brstat.tlt.note3         = wdetail.n_text068      
      brstat.tlt.note30        = wdetail.n_text069      
      brstat.tlt.ins_occ       = wdetail.n_text070      
      brstat.tlt.birthdate     = date(wdetail.n_text071) 
      brstat.tlt.ins_icno      = wdetail.n_text072    
      brstat.tlt.note1         = wdetail.n_text073       
      brstat.tlt.ben83         = wdetail.n_text074   
      brstat.tlt.comp_coamt    = deci(wdetail.n_text075) 
      brstat.tlt.comp_grprm    = deci(wdetail.n_text076) 
      brstat.tlt.mileage       = deci(wdetail.n_text077) 
      brstat.tlt.ndeci1        = deci(wdetail.n_text078) 
      brstat.tlt.ndeci2        = deci(wdetail.n_text079) 
      brstat.tlt.ndeci3        = deci(wdetail.n_text080) 
      brstat.tlt.ndeci4        = deci(wdetail.n_text081) 
      brstat.tlt.ndeci5        = deci(wdetail.n_text082) 
      brstat.tlt.nor_coamt     = deci(wdetail.n_text083) 
      brstat.tlt.nor_grprm     = deci(wdetail.n_text084) 
      brstat.tlt.prem_amt      = deci(wdetail.n_text085) 
      brstat.tlt.prem_amttcop  = deci(wdetail.n_text086) 
      brstat.tlt.rstp          = deci(wdetail.n_text087) 
      brstat.tlt.rtax          = deci(wdetail.n_text088) 
      brstat.tlt.tax_coporate  = deci(wdetail.n_text089) 
      brstat.tlt.note5         = wdetail.n_text090      
      brstat.tlt.note6         = wdetail.n_text091      
      brstat.tlt.note7         = wdetail.n_text092      
      brstat.tlt.note8         = wdetail.n_text093      
      brstat.tlt.note9         = wdetail.n_text094      
      brstat.tlt.noteveh1      = wdetail.n_text095      
      brstat.tlt.noteveh2      = wdetail.n_text096      
      brstat.tlt.old_cha       = wdetail.n_text097      
      brstat.tlt.old_eng       = wdetail.n_text098      
      brstat.tlt.pack          = wdetail.n_text099      
      brstat.tlt.packnme       = wdetail.n_text100      
      brstat.tlt.period        = wdetail.n_text101      
      brstat.tlt.ln_note1      = wdetail.n_text102 
      brstat.tlt.product       = wdetail.n_text103      
      brstat.tlt.projnme       = wdetail.n_text104      
      brstat.tlt.proveh        = wdetail.n_text105      
      brstat.tlt.race          = wdetail.n_text106      
      brstat.tlt.recac         = wdetail.n_text107      
      brstat.tlt.rec_addr      = wdetail.n_text108      
      brstat.tlt.rec_addr1     = wdetail.n_text109      
      brstat.tlt.rec_addr2     = wdetail.n_text110      
      brstat.tlt.rec_addr3     = wdetail.n_text111      
      brstat.tlt.rec_addr4     = wdetail.n_text112      
      brstat.tlt.rec_addr5     = wdetail.n_text113      
      brstat.tlt.rec_brins     = wdetail.n_text114      
      brstat.tlt.rec_cou       = wdetail.n_text115      
      brstat.tlt.rec_icno      = wdetail.n_text116      
      brstat.tlt.rec_name      = wdetail.n_text117      
      brstat.tlt.rec_name2     = wdetail.n_text118      
      brstat.tlt.rec_note1     = wdetail.n_text119      
      brstat.tlt.rec_note2     = wdetail.n_text120      
      brstat.tlt.rec_title     = wdetail.n_text121      
      brstat.tlt.rec_typ       = wdetail.n_text122      
      brstat.tlt.rider         = wdetail.n_text123      
      brstat.tlt.safe1         = wdetail.n_text124      
      brstat.tlt.safe2         = wdetail.n_text125      
      brstat.tlt.safe3         = wdetail.n_text126      
      brstat.tlt.sex           = wdetail.n_text127      
      brstat.tlt.stat          = wdetail.n_text128      
      brstat.tlt.subins        = wdetail.n_text129      
      brstat.tlt.tel           = wdetail.n_text130      
      brstat.tlt.tel2          = wdetail.n_text131      
      brstat.tlt.tel3          = wdetail.n_text132      
      brstat.tlt.usrid         = wdetail.n_text133      
      brstat.tlt.usrsent       = wdetail.n_text134      
      brstat.tlt.ln_product    = wdetail.n_text135      
      brstat.tlt.ln_pronme     = wdetail.n_text136      
      brstat.tlt.ln_rate       = wdetail.n_text137      
      brstat.tlt.ln_st         = wdetail.n_text138      
      brstat.tlt.lotno         = wdetail.n_text139      
      brstat.tlt.maritalsts    = wdetail.n_text140      
      brstat.tlt.campaign      = wdetail.n_text141      
      brstat.tlt.mobile        = wdetail.n_text142 
      brstat.tlt.filler1       = nvsuppect
      brstat.tlt.ins_brins     = nv_bridno
      brstat.tlt.acno1         = nv_producer     
      brstat.tlt.agent         = nv_agent   
      brstat.tlt.entdat        = TODAY                        
      brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")      
      brstat.tlt.trndat        = fi_loaddat                   
      brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")
      brstat.tlt.genusr        = "HCT"                    
      brstat.tlt.comp_usr_tlt  = USERID(LDBNAME(1))         
      brstat.tlt.imp           = "IM"                       
      brstat.tlt.releas        = "No" .

    RUN proc_addtlt. /*A68-0061*/

    IF      wdetail.n_text120 = "N"   AND wdetail.n_text011 = "1" AND trim(wdetail.n_text044) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection.
    ELSE IF wdetail.n_text120 = "R"   AND wdetail.n_text011 = "1" THEN RUN proc_inspection. 
    /*add : A68-0061*/
    ELSE IF wdetail.n_text120 = "New"   AND index(wdetail.n_text011,"1") <> 0  AND trim(wdetail.n_text044) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection. 
    ELSE IF wdetail.n_text120 = "Renew" AND INDEX(wdetail.n_text011,"1") <> 0   THEN RUN proc_inspection. 
    /* end :A68-0061*/
    DISP fi_process WITH   frame  fr_main.
  END.   
  ELSE DO: 
      nv_completecnt  =  nv_completecnt + 1.
      RUN Create_tlt2.
      RUN proc_addtlt. /*A68-0061*/
     IF      wdetail.n_text120 = "N" AND wdetail.n_text011 = "1" AND trim(wdetail.n_text044) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection. 
     ELSE IF wdetail.n_text120 = "R" AND wdetail.n_text011 = "1"   THEN RUN proc_inspection. 
     /*add : A68-0061*/
     IF      wdetail.n_text120 = "New"   AND index(wdetail.n_text011,"1") <> 0 AND trim(wdetail.n_text044) <> STRING(YEAR(TODAY),"9999") THEN RUN proc_inspection. 
     ELSE IF wdetail.n_text120 = "Renew" AND index(wdetail.n_text011,"1") <> 0  THEN RUN proc_inspection. 
     /*end : A68-0061*/
  END.  
END.   /* FOR EACH wdetail NO-LOCK: */
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt2 C-Win 
PROCEDURE Create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN
      fi_process = "Update :" + wdetail.n_text001       
      brstat.tlt.comp_noti_ins = wdetail.n_text001      
      brstat.tlt.comp_noti_tlt = wdetail.n_text002      
      brstat.tlt.comp_pol      = wdetail.n_text003      
      brstat.tlt.nor_effdat    = date(wdetail.n_text004)  
      brstat.tlt.comp_effdat   = date(wdetail.n_text005) 
      brstat.tlt.comp_sub      = wdetail.n_text006      
      brstat.tlt.cifno         = wdetail.n_text007      
      brstat.tlt.nationality   = wdetail.n_text008        
      brstat.tlt.nor_noti_ins  = wdetail.n_text009        
      brstat.tlt.nor_noti_tlt  = wdetail.n_text010      
      brstat.tlt.nor_usr_ins   = wdetail.n_text011       
      brstat.tlt.covcod        = wdetail.n_text012      
      brstat.tlt.nor_usr_tlt   = wdetail.n_text013        
      brstat.tlt.comp_usr_ins  = wdetail.n_text014      
      brstat.tlt.ins_title     = wdetail.n_text015      
      brstat.tlt.ins_name      = wdetail.n_text016      
      brstat.tlt.ins_firstname = wdetail.n_text017      
      brstat.tlt.ins_lastname  = wdetail.n_text018      
      brstat.tlt.ins_addr      = wdetail.n_text019      
      brstat.tlt.ins_addr1     = wdetail.n_text020      
      brstat.tlt.ins_addr2     = wdetail.n_text021      
      brstat.tlt.ins_addr3     = wdetail.n_text022      
      brstat.tlt.lince2        = wdetail.n_text023      
      brstat.tlt.ins_addr5     = wdetail.n_text024      
      brstat.tlt.dir_occ1      = wdetail.n_text025      
      brstat.tlt.note28        = wdetail.n_text026      
      brstat.tlt.dri_ic1       = wdetail.n_text027      
      brstat.tlt.dri_lic1      = wdetail.n_text028      
      brstat.tlt.brand         = wdetail.n_text029      
      brstat.tlt.note10        = wdetail.n_text030      
      brstat.tlt.cha_no        = wdetail.n_text031      
      brstat.tlt.eng_no        = wdetail.n_text032      
      brstat.tlt.model         = wdetail.n_text033      
      brstat.tlt.note11        = wdetail.n_text034      
      brstat.tlt.note12        = wdetail.n_text035      
      brstat.tlt.note13        = wdetail.n_text036      
      brstat.tlt.note14        = wdetail.n_text037        
      brstat.tlt.vehuse        = wdetail.n_text038      
      brstat.tlt.seqno         = inte(wdetail.n_text039) 
      brstat.tlt.cc_weight     = inte(wdetail.n_text040)  
      brstat.tlt.colorcod      = wdetail.n_text041      
      brstat.tlt.lince1        = wdetail.n_text042      
      brstat.tlt.ins_addr4     = wdetail.n_text043      
      brstat.tlt.note15        = wdetail.n_text044      
      brstat.tlt.note16        = wdetail.n_text045      
      brstat.tlt.note17        = wdetail.n_text046        
      brstat.tlt.note18        = wdetail.n_text047        
      brstat.tlt.note19        = wdetail.n_text048        
      brstat.tlt.note2         = wdetail.n_text049        
      brstat.tlt.note20        = wdetail.n_text050        
      brstat.tlt.note21        = wdetail.n_text051      
      brstat.tlt.note22        = wdetail.n_text052      
      brstat.tlt.note23        = wdetail.n_text053        
      brstat.tlt.comp_sck      = wdetail.n_text054      
      brstat.tlt.note24        = wdetail.n_text055      
      brstat.tlt.dri_no1       = wdetail.n_text056      
      brstat.tlt.dri_no2       = wdetail.n_text057      
      brstat.tlt.note25        = wdetail.n_text058      
      brstat.tlt.dri_name1     = wdetail.n_text059      
      brstat.tlt.note26        = wdetail.n_text060      
      brstat.tlt.note27        = wdetail.n_text061      
      brstat.tlt.dri_occ2      = wdetail.n_text062      
      brstat.tlt.note4         = wdetail.n_text063      
      brstat.tlt.dri_ic2       = wdetail.n_text064      
      brstat.tlt.dri_lic2      = wdetail.n_text065      
      brstat.tlt.note29        = wdetail.n_text066      
      brstat.tlt.dri_name2     = wdetail.n_text067      
      brstat.tlt.note3         = wdetail.n_text068      
      brstat.tlt.note30        = wdetail.n_text069      
      brstat.tlt.ins_occ       = wdetail.n_text070      
      brstat.tlt.birthdate     = date(wdetail.n_text071) 
      brstat.tlt.ins_icno      = wdetail.n_text072    
      brstat.tlt.note1         = wdetail.n_text073       
      brstat.tlt.ben83         = wdetail.n_text074   
      brstat.tlt.comp_coamt    = deci(wdetail.n_text075) 
      brstat.tlt.comp_grprm    = deci(wdetail.n_text076) 
      brstat.tlt.mileage       = deci(wdetail.n_text077) 
      brstat.tlt.ndeci1        = deci(wdetail.n_text078) 
      brstat.tlt.ndeci2        = deci(wdetail.n_text079) 
      brstat.tlt.ndeci3        = deci(wdetail.n_text080) 
      brstat.tlt.ndeci4        = deci(wdetail.n_text081) 
      brstat.tlt.ndeci5        = deci(wdetail.n_text082) 
      brstat.tlt.nor_coamt     = deci(wdetail.n_text083) 
      brstat.tlt.nor_grprm     = deci(wdetail.n_text084) 
      brstat.tlt.prem_amt      = deci(wdetail.n_text085) 
      brstat.tlt.prem_amttcop  = deci(wdetail.n_text086) 
      brstat.tlt.rstp          = deci(wdetail.n_text087) 
      brstat.tlt.rtax          = deci(wdetail.n_text088) 
      brstat.tlt.tax_coporate  = deci(wdetail.n_text089) 
      brstat.tlt.note5         = wdetail.n_text090      
      brstat.tlt.note6         = wdetail.n_text091      
      brstat.tlt.note7         = wdetail.n_text092      
      brstat.tlt.note8         = wdetail.n_text093      
      brstat.tlt.note9         = wdetail.n_text094      
      brstat.tlt.noteveh1      = wdetail.n_text095      
      brstat.tlt.noteveh2      = wdetail.n_text096      
      brstat.tlt.old_cha       = wdetail.n_text097      
      brstat.tlt.old_eng       = wdetail.n_text098      
      brstat.tlt.pack          = wdetail.n_text099      
      brstat.tlt.packnme       = wdetail.n_text100      
      brstat.tlt.period        = wdetail.n_text101      
      brstat.tlt.ln_note1      = wdetail.n_text102       
      brstat.tlt.product       = wdetail.n_text103      
      brstat.tlt.projnme       = wdetail.n_text104      
      brstat.tlt.proveh        = wdetail.n_text105      
      brstat.tlt.race          = wdetail.n_text106      
      brstat.tlt.recac         = wdetail.n_text107      
      brstat.tlt.rec_addr      = wdetail.n_text108      
      brstat.tlt.rec_addr1     = wdetail.n_text109      
      brstat.tlt.rec_addr2     = wdetail.n_text110      
      brstat.tlt.rec_addr3     = wdetail.n_text111      
      brstat.tlt.rec_addr4     = wdetail.n_text112      
      brstat.tlt.rec_addr5     = wdetail.n_text113      
      brstat.tlt.rec_brins     = wdetail.n_text114      
      brstat.tlt.rec_cou       = wdetail.n_text115      
      brstat.tlt.rec_icno      = wdetail.n_text116      
      brstat.tlt.rec_name      = wdetail.n_text117      
      brstat.tlt.rec_name2     = wdetail.n_text118      
      brstat.tlt.rec_note1     = wdetail.n_text119      
      brstat.tlt.rec_note2     = wdetail.n_text120      
      brstat.tlt.rec_title     = wdetail.n_text121      
      brstat.tlt.rec_typ       = wdetail.n_text122      
      brstat.tlt.rider         = wdetail.n_text123      
      brstat.tlt.safe1         = wdetail.n_text124      
      brstat.tlt.safe2         = wdetail.n_text125      
      brstat.tlt.safe3         = wdetail.n_text126      
      brstat.tlt.sex           = wdetail.n_text127      
      brstat.tlt.stat          = wdetail.n_text128      
      brstat.tlt.subins        = wdetail.n_text129      
      brstat.tlt.tel           = wdetail.n_text130      
      brstat.tlt.tel2          = wdetail.n_text131      
      brstat.tlt.tel3          = wdetail.n_text132      
      brstat.tlt.usrid         = wdetail.n_text133      
      brstat.tlt.usrsent       = wdetail.n_text134      
      brstat.tlt.ln_product    = wdetail.n_text135      
      brstat.tlt.ln_pronme     = wdetail.n_text136      
      brstat.tlt.ln_rate       = wdetail.n_text137      
      brstat.tlt.ln_st         = wdetail.n_text138      
      brstat.tlt.lotno         = wdetail.n_text139      
      brstat.tlt.maritalsts    = wdetail.n_text140      
      brstat.tlt.campaign      = wdetail.n_text141      
      brstat.tlt.mobile        = wdetail.n_text142 
      brstat.tlt.ins_brins     = nv_bridno
      brstat.tlt.acno1         = nv_producer     
      brstat.tlt.agent         = nv_agent 
      brstat.tlt.filler1       = nvsuppect
      brstat.tlt.entdat        = TODAY                        
      brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")      
      brstat.tlt.trndat        = fi_loaddat                   
      brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")
      brstat.tlt.genusr        = "HCT"                    
      brstat.tlt.comp_usr_tlt  = USERID(LDBNAME(1))        
      brstat.tlt.imp           = "IM"                       
      brstat.tlt.releas        = "No" .










































































  






























    DISP fi_process WITH   frame  fr_main.
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
  DISPLAY fi_process fi_loaddat fi_compa fi_filename fi_impcnt fi_completecnt 
          fi_dir_cnt fi_dri_complet fi_insp fi_proid fi_saletype fi_camname 
          fi_notitype fi_improducer fi_campaign fi_producer01 fi_agent 
          rs_typfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_producer fi_process fi_loaddat fi_compa fi_filename bu_ok br_imptxt 
         bu_exit bu_file fi_insp fi_proid fi_saletype fi_camname fi_notitype 
         fi_improducer bu_add bu_delete fi_campaign fi_producer01 fi_agent 
         rs_typfile RECT-1 RECT-79 RECT-80 RECT-380 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
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
FOR EACH  wdetail :
    DELETE  wdetail.
END.
fi_process = "Import file ".
IF rs_typfile = 1 THEN DO:  /*A68-0061*/
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT UNFORMATTED nv_daily.
        CREATE wdetail.
        RUN proc_addwdetail.
    END.   /* repeat  */
/* add :A68-0061*/
END.
ELSE DO:
    RUN proc_addwdetail2.
END.
/* end :A68-0061*/
DISP fi_process WITH   frame  fr_main.
FOR EACH wdetail .
    IF      INDEX(wdetail.n_text001,"จำนวน") <> 0 THEN  DELETE wdetail. 
    ELSE IF  wdetail.n_text001    = "" THEN  DELETE wdetail.
END.
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 

Run  Create_tlt.  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_producer C-Win 
PROCEDURE pd_producer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN n_saletyp   = ""     n_garage    = ""
       n_notityp   = ""     n_covcod    = "" .

IF      trim(wdetail.n_text120) = "New"     THEN ASSIGN n_notityp = "N" .
ELSE IF trim(wdetail.n_text120) = "Renew"   THEN ASSIGN n_notityp = "R" .
ELSE IF trim(wdetail.n_text120) = "Switch"  THEN ASSIGN n_notityp = "S" .
ELSE ASSIGN n_notityp = trim(wdetail.n_text120).

IF       trim(wdetail.n_text013) = "ซ่อมห้าง" THEN ASSIGN n_garage = "HONDA" .
ELSE IF  trim(wdetail.n_text013) = "ซ่อมอู่"  THEN ASSIGN n_garage = "GARAGE" .
ELSE ASSIGN n_garage = trim(wdetail.n_text013) .

IF      trim(wdetail.n_text008) = "Normal"   THEN ASSIGN n_saletyp = "N" .
ELSE IF trim(wdetail.n_text008) = "Campaign" THEN ASSIGN n_saletyp = "C" .
ELSE IF trim(wdetail.n_text008) = "Staff"    THEN ASSIGN n_saletyp = "S" .
ELSE IF INDEX(wdetail.n_text008,"HATC") <> 0   THEN ASSIGN n_saletyp = "H" .
ELSE ASSIGN n_saletyp = trim(wdetail.n_text008) .


IF      TRIM(wdetail.n_text011) = "พรบ."  THEN  ASSIGN n_covcod  = "T" .
ELSE IF INDEX(wdetail.n_text011,"1") <> 0 THEN  ASSIGN n_covcod  = "1" .
ELSE IF INDEX(wdetail.n_text011,"2+")<> 0 THEN  ASSIGN n_covcod  = "2.2" .
ELSE IF INDEX(wdetail.n_text011,"3+")<> 0 THEN  ASSIGN n_covcod  = "3.2" .
ELSE IF INDEX(wdetail.n_text011,"2") <> 0 THEN  ASSIGN n_covcod  = "2" .
ELSE IF INDEX(wdetail.n_text011,"3") <> 0 THEN  ASSIGN n_covcod  = "3" .
ELSE ASSIGN n_covcod  = TRIM(wdetail.n_text011).

IF n_covcod = "T" OR n_covcod  = "0" THEN  RUN pd_producer1.  /*72*/
ELSE DO:
  IF index(wdetail.n_text116,"super pack") <> 0 THEN DO:                /* รายละเอียดเคมเปญ */
    FIND FIRST wimproducer WHERE
      wimproducer.saletype = TRIM(n_saletyp)       AND   /* ประเภทการขาย */ 
      TRIM(wimproducer.camname) = TRIM(wdetail.n_text116)  AND   /* รายละเอียดเคมเปญ */ 
      wimproducer.notitype = TRIM(n_notityp)       /* ประเภทการแจ้งงาน  */ 
      NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL  wimproducer THEN ASSIGN   nv_producer  = wimproducer.producer   .
  END.    /* n_text055    as char   55    เลขที่กรมธรรมเดิม  */
  ELSE IF index(wdetail.n_text116,"TMSTH 0%") <> 0 OR index(wdetail.n_text116,"TMSTH0%") <> 0 OR index(wdetail.n_text116,"DEMON_H") <> 0 THEN  RUN pd_producer2.
  ELSE IF n_saletyp = "C" THEN DO:   /* ประเภทการขาย  */ 
    IF n_covcod = "1"  AND n_notityp = "S" THEN DO:    /* ประเภทการแจ้งงาน  */ 
      IF trim(n_garage) = "GARAGE" AND   /*อู่*/
          (( YEAR(TODAY) - deci(wdetail.n_text044) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.n_text044) + 1 ) <= 10 ) THEN DO: 
          ASSIGN  nv_producer = "B3M0062".  
      END.
      ELSE ASSIGN  nv_producer = "B3M0065". 
    END.
    ELSE IF n_covcod <> "1" AND (n_notityp = "S" OR n_notityp = "R" OR n_notityp = "N") THEN DO:  
                ASSIGN  nv_producer = "B3M0062".
    END.
    ELSE DO: 
        FIND FIRST wimproducer WHERE 
            wimproducer.saletype      = TRIM(n_saletyp) AND     /* ประเภทการขาย */ 
            TRIM(wimproducer.camname) = TRIM(wdetail.n_text116) AND     /* รายละเอียดเคมเปญ */ 
            wimproducer.notitype      = TRIM(n_notityp) NO-LOCK NO-ERROR NO-WAIT. /* ประเภทการแจ้งงาน  */ 
        IF AVAIL  wimproducer THEN  
             ASSIGN   nv_producer   = wimproducer.producer   .
        ELSE DO:          
            IF      INDEX(wdetail.n_text116,"DEMON_D")          <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "N" THEN ASSIGN nv_producer = "B3M0059".
            ELSE IF INDEX(wdetail.n_text116,"HATC CAMPAIGN_22") <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "N" THEN ASSIGN nv_producer = "B3M0063".
            ELSE IF INDEX(wdetail.n_text116,"HEI 22-D")         <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "N" THEN ASSIGN nv_producer = "B3M0061".
            ELSE IF INDEX(wdetail.n_text116,"HEI 22-S")         <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "N" THEN ASSIGN nv_producer = "B3M0061".
            ELSE IF INDEX(wdetail.n_text116,"HEI_CCTV")         <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "N" THEN ASSIGN nv_producer = "B3M0060".
            ELSE IF INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "N" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"TRIPLE PACK")      <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "N" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"HEI2Plus")         <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "R" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"HEI3Plus")         <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "R" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "R" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"TRIPLE PACK")      <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "R" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"HEI2Plus")         <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "S" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"HEI3Plus")         <> 0 AND TRIM(n_saletyp) = "C" AND TRIM(n_notityp) = "S" THEN ASSIGN nv_producer = "B3M0062".
        END.
    END.
  END.
  ELSE IF n_saletyp = "H" THEN   ASSIGN nv_producer = "B3M0063". 
  ELSE DO:
      IF      n_covcod = "1" AND TRIM(n_notityp) = "S" THEN DO: 
          IF  trim(n_garage)  = "GARAGE"  AND 
              (( YEAR(TODAY) - deci(wdetail.n_text034) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.n_text034) + 1 ) <= 10 ) THEN DO:
              ASSIGN nv_producer = "B3M0062".  
          END.
          ELSE ASSIGN nv_producer = "B3M0065".  
      END.
      ELSE IF n_covcod <> "1" AND ( TRIM(n_notityp) = "S" OR  TRIM(n_notityp) = "R" OR  TRIM(n_notityp) = "N") THEN DO:  
          ASSIGN nv_producer = "B3M0062". 
      END.
      ELSE DO: 
          FIND FIRST wimproducer WHERE
              wimproducer.saletype = TRIM(n_saletyp)       AND   /* ประเภทการขาย */ 
              TRIM(wimproducer.camname) = TRIM(wdetail.n_text116)  AND   /* รายละเอียดเคมเปญ */ 
              wimproducer.notitype = TRIM(n_notityp)       /* ประเภทการแจ้งงาน  */ 
              NO-LOCK NO-ERROR NO-WAIT.  
          IF AVAIL  wimproducer THEN ASSIGN   nv_producer  = wimproducer.producer   .
      END.
  END.
END.

IF nv_producer = "" THEN ASSIGN  nv_producer = fi_producer01.

    
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_producer1 C-Win 
PROCEDURE pd_producer1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF n_saletyp = "C" THEN DO:
    IF      index(wdetail.n_text116,"DEMON_D")     <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF index(wdetail.n_text116,"HEI 20-D")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 21-D")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 21-S")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 22-D")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI 22_S")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0061".
    ELSE IF index(wdetail.n_text116,"HEI_CCTV")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0060".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")  <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK") <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"HEI2Plus")    <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0062".
    ELSE IF index(wdetail.n_text116,"HEI3Plus")    <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0062".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")  <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK") <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"HEI2Plus")    <> 0 AND n_notityp = "S" THEN ASSIGN nv_producer = "B3M0062".
    ELSE IF index(wdetail.n_text116,"HEI3Plus")    <> 0 AND n_notityp = "S" THEN ASSIGN nv_producer = "B3M0062". 
END.
ELSE IF n_saletyp = "F" AND index(wdetail.n_text116,"HLTC CAMPAIGN") <> 0  AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0068".
ELSE IF n_saletyp = "H" THEN DO:
    IF      index(wdetail.n_text116,"DEMON2YEAR_H")     <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF index(wdetail.n_text116,"HATC CAMPAIGN_20") <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0063".
    ELSE IF index(wdetail.n_text116,"HATC CAMPAIGN_21") <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0063".
    ELSE IF index(wdetail.n_text116,"HATC CAMPAIGN_22") <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0063".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")       <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H")     <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H1")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-HD")    <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK_H1")   <> 0 AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"DEMON2YEAR_H")     <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF index(wdetail.n_text116,"SUPER PACK")       <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H")     <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-H1")    <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"SUPER PACK-HD")    <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0066".
    ELSE IF index(wdetail.n_text116,"TRIPLE PACK_H1")   <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0066". 
    ELSE IF index(wdetail.n_text116,"TMSTH 0%")         <> 0 AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0058". 
    ELSE IF index(wdetail.n_text116,"TMSTH 0%")         <> 0 AND n_notityp = "s" THEN ASSIGN nv_producer = "B3M0058".
    ELSE IF index(wdetail.n_text116,"DEMON_H")          <> 0                             THEN ASSIGN nv_producer = "B3M0059".
    ELSE IF                                                      n_notityp = "S" THEN ASSIGN nv_producer = "B3M0065".
END.
ELSE IF n_saletyp = "N" AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0060". 
ELSE IF n_saletyp = "N" AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF n_saletyp = "N" AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0064". 
ELSE IF n_saletyp = "N" AND n_notityp = "S" THEN ASSIGN nv_producer = "B3M0065".
ELSE IF n_saletyp = "R" AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF n_saletyp = "R" AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0065". 
ELSE IF n_saletyp = "R" AND n_notityp = "S" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF n_saletyp = "S" AND n_notityp = "N" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF n_saletyp = "S" AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0064". 
ELSE IF n_saletyp = "S" AND n_notityp = "R" THEN ASSIGN nv_producer = "B3M0065". 
ELSE IF n_saletyp = "S" AND n_notityp = "S" THEN ASSIGN nv_producer = "B3M0062". 
ELSE IF n_saletyp = "S" AND n_notityp = "S" THEN ASSIGN nv_producer = "B3M0065". 
ELSE ASSIGN nv_producer =  fi_producer01.
IF nv_producer = "" THEN ASSIGN nv_producer =  fi_producer01.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_producer2 C-Win 
PROCEDURE pd_producer2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF n_saletyp = "H" THEN DO:
    IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR  
             index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND n_saletyp = "R" THEN DO:
        IF wdetail.n_text055  <> ""  THEN DO:
            FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
                sicuw.uwm100.policy = wdetail.n_text055 
                No-lock No-error no-wait.
            IF AVAIL sicuw.uwm100  THEN 
                ASSIGN  nv_producer   = sicuw.uwm100.acno1 .
        END.
    END.
    ELSE IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR  
                  index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND  n_saletyp = "S" THEN DO:
        IF      n_covcod = "1" AND n_garage = "honda"   THEN ASSIGN  nv_producer   = "B3M0065".
        ELSE IF n_covcod = "T" OR  n_covcod  = "0"      THEN ASSIGN  nv_producer   = "B3M0058".
        ELSE ASSIGN  nv_producer   = "B3M0062".
    END.
    ELSE IF index(wdetail.n_text116,"DEMON_H") <> 0  THEN ASSIGN nv_producer   = "B3M0059".
END.
ELSE IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR
              index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND  n_saletyp = "R" THEN DO:
    IF wdetail.n_text055  <> "" THEN DO:
        FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
            sicuw.uwm100.policy = wdetail.n_text055 
            No-lock No-error no-wait.
        IF AVAIL sicuw.uwm100  THEN ASSIGN nv_producer   = sicuw.uwm100.acno1 .
    END.
END.
ELSE IF     ( index(wdetail.n_text116,"TMSTH 0%") <> 0 OR  
              index(wdetail.n_text116,"TMSTH0%")  <> 0 ) AND  n_saletyp = "S" THEN DO:
    IF      n_covcod = "1" AND n_garage = "honda" THEN ASSIGN  nv_producer   = "B3M0065" .
    ELSE IF n_covcod = "T" OR  n_covcod = "0"     THEN ASSIGN  nv_producer   = "B3M0058".
    ELSE ASSIGN  nv_producer   = "B3M0062".
END.
ELSE IF index(wdetail.n_text116,"DEMON_H")  <> 0 THEN ASSIGN  nv_producer   = "B3M0059".
IF nv_producer = ""  THEN DO:
    FIND FIRST wimproducer WHERE
        wimproducer.saletype = TRIM(n_saletyp)       AND   /* ประเภทการขาย */ 
        TRIM(wimproducer.camname) = TRIM(wdetail.n_text116)  AND   /* รายละเอียดเคมเปญ */ 
        wimproducer.notitype = TRIM(n_saletyp)       /* ประเภทการแจ้งงาน  */ 
        NO-LOCK NO-ERROR NO-WAIT.  
    IF AVAIL  wimproducer THEN ASSIGN   nv_producer  = wimproducer.producer   .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_producer_bk C-Win 
PROCEDURE pd_producer_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF index(wdetail.n_text116,"super pack") <> 0 THEN DO:                /* รายละเอียดเคมเปญ */
    FIND FIRST wimproducer WHERE
        wimproducer.saletype = TRIM(wdetail.n_text008)        AND     /* ประเภทการขาย */ 
        TRIM(wimproducer.camname) = TRIM(wdetail.n_text116)     AND   /* รายละเอียดเคมเปญ */ 
                  wimproducer.notitype = TRIM(wdetail.n_text120)      /* ประเภทการแจ้งงาน  */ 
         NO-LOCK NO-ERROR NO-WAIT.     
    IF AVAIL  wimproducer THEN                                                                   
        ASSIGN   nv_producer  = wimproducer.producer   .
                          
END.   /* n_text055    as char   55    เลขที่กรมธรรมเดิม  */
ELSE IF wdetail.n_text008 = "C" THEN DO:   /* ประเภทการขาย  */  
    IF wdetail.n_text011 = "1"  AND wdetail.n_text120 = "S" THEN DO:    /* ประเภทการแจ้งงาน  */ 
        IF trim(wdetail.n_text013) = "GARAGE" AND   /*อู่*/
            (( YEAR(TODAY) - deci(wdetail.n_text044) + 1 ) >= 2 ) AND (( YEAR(TODAY) - deci(wdetail.n_text044) + 1 ) <= 10 ) THEN DO: 
             ASSIGN  nv_producer = "B3M0062".  
        END.
        ELSE ASSIGN  nv_producer = "B3M0065". 
    END.
    ELSE IF wdetail.n_text011 <> "1" AND (wdetail.n_text120 = "S" OR wdetail.n_text120 = "R" OR wdetail.n_text120 = "N") THEN DO:  
                ASSIGN  nv_producer = "B3M0062".
    END.
    ELSE DO: 
        FIND FIRST wimproducer WHERE 
            wimproducer.saletype      = TRIM(wdetail.n_text008) AND     /* ประเภทการขาย */ 
            TRIM(wimproducer.camname) = TRIM(wdetail.n_text116) AND     /* รายละเอียดเคมเปญ */ 
            wimproducer.notitype      = TRIM(wdetail.n_text120) NO-LOCK NO-ERROR NO-WAIT. /* ประเภทการแจ้งงาน  */ 
        IF AVAIL  wimproducer THEN  
             ASSIGN   nv_producer   = wimproducer.producer   .
        ELSE DO:          
            IF      INDEX(wdetail.n_text116,"DEMON_D")          <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0059".
            ELSE IF INDEX(wdetail.n_text116,"HATC CAMPAIGN_22") <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0063".
            ELSE IF INDEX(wdetail.n_text116,"HEI 22-D")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0061".
            ELSE IF INDEX(wdetail.n_text116,"HEI 22-S")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0061".
            ELSE IF INDEX(wdetail.n_text116,"HEI_CCTV")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0060".
            ELSE IF INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"TRIPLE PACK")      <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"HEI2Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"HEI3Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"TRIPLE PACK")      <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
            ELSE IF INDEX(wdetail.n_text116,"HEI2Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "S" THEN ASSIGN nv_producer = "B3M0062".
            ELSE IF INDEX(wdetail.n_text116,"HEI3Plus")         <> 0 AND TRIM(wdetail.n_text008) = "C" AND TRIM(wdetail.n_text120) = "S" THEN ASSIGN nv_producer = "B3M0062".
        END.
    END.
END.
ELSE IF TRIM(wdetail.n_text008) = "F" AND INDEX(wdetail.n_text116,"HLTC CAMPAIGN")    <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0068".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"DEMON2YEAR_H")     <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0059".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"HATC CAMPAIGN_22") <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0063".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK-H")     <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK-H1")    <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK-HD")    <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"TRIPLE PACK_H1")   <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"DEMON2YEAR_H")     <> 0 AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0059".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK")       <> 0 AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK-H")     <> 0 AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK-H1")    <> 0 AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"SUPER PACK-HD")    <> 0 AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".
ELSE IF TRIM(wdetail.n_text008) = "H" AND INDEX(wdetail.n_text116,"TRIPLE PACK_H1")   <> 0 AND TRIM(wdetail.n_text120) = "R" THEN ASSIGN nv_producer = "B3M0066".

ELSE IF TRIM(wdetail.n_text008) = "N" AND INDEX(wdetail.n_text116,"HEI22") <> 0 AND TRIM(wdetail.n_text120) = "N" THEN ASSIGN nv_producer = "B3M0060".
ELSE IF TRIM(wdetail.n_text008) = "N" AND TRIM(wdetail.n_text120) = "R" THEN DO:
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
        sicuw.uwm100.policy = trim(wdetail.n_text055) NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF      sicuw.uwm100.acno1 = "B3M0065"  THEN ASSIGN  nv_producer = "B3M0065". 
        ELSE IF sicuw.uwm100.acno1 = "B3M0062"  AND wdetail.n_text011 = "1"  AND trim(wdetail.n_text013) = "GARAGE" THEN ASSIGN  nv_producer = "B3M0062". 
        ELSE IF sicuw.uwm100.acno1 = "B3M0062"  AND wdetail.n_text011 = "5"   THEN ASSIGN  nv_producer = "B3M0062". 
        ELSE IF sicuw.uwm100.acno1 = "B3M0062"  AND wdetail.n_text011 = "9"   THEN ASSIGN  nv_producer = "B3M0062".
    END.
    ELSE ASSIGN  nv_producer = "B3M0064". 

END.
ELSE IF TRIM(wdetail.n_text008) = "N" AND TRIM(wdetail.n_text120) = "S" THEN DO: 
    IF      wdetail.n_text011 = "1"  AND trim(wdetail.n_text013) = "HONDA"  THEN ASSIGN  nv_producer = "B3M0065".  
    ELSE  ASSIGN  nv_producer = "B3M0062".
END.
ELSE IF TRIM(wdetail.n_text008) = "S" AND TRIM(wdetail.n_text120) = "R" THEN DO:

    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
        sicuw.uwm100.policy = trim(wdetail.n_text055) NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF sicuw.uwm100.acno1 = "B3M0065"  THEN ASSIGN  nv_producer = "B3M0065". 
    END.
    ELSE DO:
        IF      wdetail.n_text011 = "1" AND trim(wdetail.n_text013) = "GARAGE"  THEN ASSIGN  nv_producer = "B3M0062".   /*11    ประเภทความคุ้มครอง        0      */ 
        ELSE IF wdetail.n_text011 = "5" OR wdetail.n_text011 = "9" THEN  ASSIGN  nv_producer = "B3M0062". 
        ELSE  ASSIGN  nv_producer = "B3M0064".
    END.
END.
ELSE IF TRIM(wdetail.n_text008) = "S" AND TRIM(wdetail.n_text120) = "S" THEN DO:
    IF      wdetail.n_text011 = "1"  AND trim(wdetail.n_text013)  = "HONDA"  THEN ASSIGN  nv_producer = "B3M0065".   
    ELSE IF wdetail.n_text011 = "1"  AND trim(wdetail.n_text013)  = "GARAGE" THEN ASSIGN  nv_producer = "B3M0062".  
END.
ELSE ASSIGN  nv_producer = fi_producer01.

  
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
/*
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
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addtlt C-Win 
PROCEDURE proc_addtlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    brstat.tlt.poltyp          = wdetail.typepol      
    brstat.tlt.car_type        = wdetail.typecar      
    brstat.tlt.maksi           = IF trim(wdetail.maksi) = "" THEN 0 ELSE DECI(wdetail.maksi)        
    brstat.tlt.dri_licenexp1   = wdetail.drivexp1      
    brstat.tlt.dri_consen1     = IF trim(wdetail.drivcon1) = "Y" THEN "YES" ELSE "NO"     
    brstat.tlt.dri_level1      = IF trim(wdetail.dlevel1) = "" THEN 1 ELSE INTE(wdetail.dlevel1)      
    brstat.tlt.dri_gender1     = wdetail.dgender1  
    brstat.tlt.dri_licenexp2   = wdetail.drivexp2     
    brstat.tlt.dri_consen2     = IF trim(wdetail.drivcon2) = "Y" THEN "YES" ELSE "NO"                     
    brstat.tlt.dri_level2      = IF trim(wdetail.dlevel2) = "" THEN 1 ELSE INTE(wdetail.dlevel2)      
    brstat.tlt.dri_gender2     = wdetail.dgender2 
    brstat.tlt.dri_title3      = wdetail.ntitle3      
    brstat.tlt.dri_fname3      = trim(trim(wdetail.dname3) + " " + TRIM(wdetail.dcname3))      
    brstat.tlt.dri_lname3      = wdetail.dlname3      
    brstat.tlt.dir_occ3        = wdetail.doccup3      
    brstat.tlt.dri_birth3      = wdetail.dbirth3      
    brstat.tlt.dri_ic3         = wdetail.dicno3       
    brstat.tlt.dri_lic3        = wdetail.ddriveno3    
    brstat.tlt.dri_licenexp3   = wdetail.drivexp3     
    brstat.tlt.dri_consen3     = IF trim(wdetail.drivcon3) = "Y" THEN "YES" ELSE "NO"                     
    brstat.tlt.dri_level3      = IF trim(wdetail.dlevel3) = "" THEN 1 ELSE INTE(wdetail.dlevel3)     
    brstat.tlt.dri_gender3     = wdetail.dgender3  
    brstat.tlt.dri_title4      = wdetail.ntitle4      
    brstat.tlt.dri_fname4      = TRIM(trim(wdetail.dname4)  + " " + trim(wdetail.dcname4))      
    brstat.tlt.dri_lname4      = wdetail.dlname4      
    brstat.tlt.dri_occ4        = wdetail.doccup4      
    brstat.tlt.dri_birth4      = wdetail.dbirth4      
    brstat.tlt.dri_ic4         = wdetail.dicno4       
    brstat.tlt.dri_lic4        = wdetail.ddriveno4    
    brstat.tlt.dri_licenexp4   = wdetail.drivexp4     
    brstat.tlt.dri_consen4     = IF trim(wdetail.drivcon4) = "Y" THEN "YES" ELSE "NO"                
    brstat.tlt.dri_level4      = IF trim(wdetail.dlevel4) = "" THEN 1 ELSE INTE(wdetail.dlevel4) 
    brstat.tlt.dri_gender4     = wdetail.dgender4 
    brstat.tlt.dri_title5      = wdetail.ntitle5      
    brstat.tlt.dri_fname5      = trim(trim(wdetail.dname5) + " " + trim(wdetail.dcname5))      
    brstat.tlt.dri_lname5      = wdetail.dlname5      
    brstat.tlt.dri_occ5        = wdetail.doccup5      
    brstat.tlt.dri_birth5      = wdetail.dbirth5      
    brstat.tlt.dri_ic5         = wdetail.dicno5       
    brstat.tlt.dri_lic5        = wdetail.ddriveno5    
    brstat.tlt.dri_licenexp5   = wdetail.drivexp5     
    brstat.tlt.dri_consen5     = IF trim(wdetail.drivcon5)   = "Y" THEN "YES" ELSE "NO"                  
    brstat.tlt.dri_level5      = IF trim(wdetail.dlevel5)    = ""  THEN 1 ELSE INTE(wdetail.dlevel5)   
    brstat.tlt.dri_gender5     = wdetail.dgender5 
    brstat.tlt.chargflg        = IF trim(wdetail.chargflg)   = "Y" THEN YES ELSE NO         
    brstat.tlt.chargsi         = IF trim(wdetail.chargprice) = ""  THEN 0 ELSE DECI(wdetail.chargprice)       
    brstat.tlt.chargno         = trim(wdetail.chargno)          
    brstat.tlt.chargprem       = IF trim(wdetail.chargprm)  = ""   THEN 0 ELSE DECI(wdetail.chargprm)         
    brstat.tlt.battflg         = IF trim(wdetail.battflg)   = "Y"  THEN YES ELSE NO          
    brstat.tlt.battprice       = IF trim(wdetail.battprice) = ""   THEN 0 ELSE DECI(wdetail.battprice)        
    brstat.tlt.battno          = trim(wdetail.battno)           
    brstat.tlt.battprem        = IF trim(wdetail.battprm)  = "" THEN 0 ELSE DECI(wdetail.battprm)          
    brstat.tlt.ndate1          = IF trim(wdetail.battdate) = "" THEN ? ELSE DATE(wdetail.battdate)                        
    brstat.tlt.dg_prem         = if trim(wdetail.net_re1)  = "" then 0 else deci(wdetail.net_re1)                        
    brstat.tlt.dg_rstp_t       = if trim(wdetail.stam_re1) = "" then 0 else deci(wdetail.stam_re1)                       
    brstat.tlt.dg_rtax_t       = if trim(wdetail.vat_re1)  = "" then 0 else deci(wdetail.vat_re1)                        
    brstat.tlt.ins_code        = wdetail.inscode_re2                     
    brstat.tlt.dg_si           = if trim(wdetail.net_re2)  = "" then 0 else deci(wdetail.net_re2)       
    brstat.tlt.dg_rate         = if trim(wdetail.stam_re2) = "" then 0 else deci(wdetail.stam_re2)      
    brstat.tlt.dg_feet         = if trim(wdetail.vat_re2)  = "" then 0 else deci(wdetail.vat_re2)       
    brstat.tlt.Paycode         = wdetail.inscode_re3  
    brstat.tlt.dg_ncb          = if trim(wdetail.net_re3)  = "" then 0 else deci(wdetail.net_re3)       
    brstat.tlt.dg_disc         = if trim(wdetail.stam_re3) = "" then 0 else deci(wdetail.stam_re3)      
    brstat.tlt.dg_wdisc        = if trim(wdetail.vat_re3)  = "" then 0 else deci(wdetail.vat_re3)   .  
    /*drelation1  */  
    /*drelation2  */   
    /*drelation3  */ 
    /*drelation4  */  
    /*drelation5   */ 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addwdetail C-Win 
PROCEDURE proc_addwdetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    wdetail.n_text001 = TRIM(SUBSTRING(nv_daily,1,12))                                                 
    wdetail.n_text002 = TRIM(SUBSTRING(nv_daily,13,10))                               
    wdetail.n_text003 = TRIM(SUBSTRING(nv_daily,23,32))                               
    wdetail.n_text004 = TRIM(SUBSTRING(nv_daily,55,10))                           
    wdetail.n_text005 = TRIM(SUBSTRING(nv_daily,65,10))                               
    wdetail.n_text006 = TRIM(SUBSTRING(nv_daily,75,10))                           
    wdetail.n_text007 = TRIM(SUBSTRING(nv_daily,85,4))                                    
    wdetail.n_text008 = TRIM(SUBSTRING(nv_daily,89,1))                                
    wdetail.n_text009 = TRIM(SUBSTRING(nv_daily,90,16))                               
    wdetail.n_text010 = TRIM(SUBSTRING(nv_daily,106,10))                      
    wdetail.n_text011 = TRIM(SUBSTRING(nv_daily,116,1))    
    wdetail.n_text012 = TRIM(SUBSTRING(nv_daily,117,9))                             
    wdetail.n_text013 = TRIM(SUBSTRING(nv_daily,126,6))                             
    wdetail.n_text014 = TRIM(SUBSTRING(nv_daily,132,30))                                
    wdetail.n_text015 = TRIM(SUBSTRING(nv_daily,162,20))                                
    wdetail.n_text016 = TRIM(SUBSTRING(nv_daily,182,80))                                
    wdetail.n_text017 = TRIM(SUBSTRING(nv_daily,262,20))                                
    wdetail.n_text018 = TRIM(SUBSTRING(nv_daily,282,60))                                    
    wdetail.n_text019 = TRIM(SUBSTRING(nv_daily,342,80))                                    
    wdetail.n_text020 = TRIM(SUBSTRING(nv_daily,422,40))                                        
    wdetail.n_text021 = TRIM(SUBSTRING(nv_daily,462,60))                                
    wdetail.n_text022 = TRIM(SUBSTRING(nv_daily,522,30))                                
    wdetail.n_text023 = TRIM(SUBSTRING(nv_daily,552,30))                                    
    wdetail.n_text024 = TRIM(SUBSTRING(nv_daily,582,5))                             
    wdetail.n_text025 = TRIM(SUBSTRING(nv_daily,587,50))                                    
    wdetail.n_text026 = TRIM(SUBSTRING(nv_daily,637,10))                                    
    wdetail.n_text027 = TRIM(SUBSTRING(nv_daily,647,15))                         
    wdetail.n_text028 = TRIM(SUBSTRING(nv_daily,662,15))                             
    wdetail.n_text029 = TRIM(SUBSTRING(nv_daily,677,10))                                 
    wdetail.n_text030 = TRIM(SUBSTRING(nv_daily,687,1))                                  
    wdetail.n_text031 = TRIM(SUBSTRING(nv_daily,688,25))                             
    wdetail.n_text032 = TRIM(SUBSTRING(nv_daily,713,20))                            
    wdetail.n_text033 = TRIM(SUBSTRING(nv_daily,733,40))                                
    wdetail.n_text034 = TRIM(SUBSTRING(nv_daily,773,4))                                     
    wdetail.n_text035 = TRIM(SUBSTRING(nv_daily,777,20))                              
    wdetail.n_text036 = TRIM(SUBSTRING(nv_daily,797,40))   
    wdetail.n_text037 = TRIM(SUBSTRING(nv_daily,837,1))                               
    wdetail.n_text038 = TRIM(SUBSTRING(nv_daily,838,2))                           
    wdetail.n_text039 = TRIM(SUBSTRING(nv_daily,840,2))                               
    wdetail.n_text040 = TRIM(SUBSTRING(nv_daily,842,4))      
    wdetail.n_text041 = TRIM(SUBSTRING(nv_daily,846,40))     
    wdetail.n_text042 = TRIM(SUBSTRING(nv_daily,886,10))  /*wdetail.vehreg      */     /*42*/    
    wdetail.n_text043 = TRIM(SUBSTRING(nv_daily,896,30))  /*wdetail.re_country  */     /*43*/            
    wdetail.n_text044 = TRIM(SUBSTRING(nv_daily,926,4))         
    wdetail.n_text045 = TRIM(SUBSTRING(nv_daily,930,512))    
    wdetail.n_text046 = TRIM(SUBSTRING(nv_daily,1442,14))    
    wdetail.n_text047 = TRIM(SUBSTRING(nv_daily,1456,14))      
    wdetail.n_text048 = TRIM(SUBSTRING(nv_daily,1470,14))                 
    wdetail.n_text049 = TRIM(SUBSTRING(nv_daily,1484,14))         
    wdetail.n_text050 = TRIM(SUBSTRING(nv_daily,1498,14))         
    wdetail.n_text051 = TRIM(SUBSTRING(nv_daily,1512,14))    
    wdetail.n_text052 = TRIM(SUBSTRING(nv_daily,1526,14))    
    wdetail.n_text053 = TRIM(SUBSTRING(nv_daily,1540,14))    
    wdetail.n_text054 = TRIM(SUBSTRING(nv_daily,1554,20))           
    wdetail.n_text055 = TRIM(SUBSTRING(nv_daily,1574,32))           
    wdetail.n_text056 = TRIM(SUBSTRING(nv_daily,1606,1))            
    wdetail.n_text057 = TRIM(SUBSTRING(nv_daily,1607,1))     
    wdetail.n_text058 = TRIM(SUBSTRING(nv_daily,1608,20))         
    wdetail.n_text059 = TRIM(SUBSTRING(nv_daily,1628,80))    
    wdetail.n_text060 = TRIM(SUBSTRING(nv_daily,1708,20))         
    wdetail.n_text061 = TRIM(SUBSTRING(nv_daily,1728,60))             
    wdetail.n_text062 = TRIM(SUBSTRING(nv_daily,1788,50))             
    wdetail.n_text063 = TRIM(SUBSTRING(nv_daily,1838,10))             
    wdetail.n_text064 = TRIM(SUBSTRING(nv_daily,1848,15))      
    wdetail.n_text065 = TRIM(SUBSTRING(nv_daily,1863,15))     
    wdetail.n_text066 = TRIM(SUBSTRING(nv_daily,1878,20))    
    wdetail.n_text067 = TRIM(SUBSTRING(nv_daily,1898,80))    
    wdetail.n_text068 = TRIM(SUBSTRING(nv_daily,1978,20))        
    wdetail.n_text069 = TRIM(SUBSTRING(nv_daily,1998,60))              
    wdetail.n_text070 = TRIM(SUBSTRING(nv_daily,2058,50))                 
    wdetail.n_text071 = TRIM(SUBSTRING(nv_daily,2108,10))                 
    wdetail.n_text072 = TRIM(SUBSTRING(nv_daily,2118,15))  
    wdetail.n_text073 = TRIM(SUBSTRING(nv_daily,2133,15))  
    wdetail.n_text074 = TRIM(SUBSTRING(nv_daily,2148,80))  
    wdetail.n_text075 = TRIM(SUBSTRING(nv_daily,2228,14))  
    wdetail.n_text076 = TRIM(SUBSTRING(nv_daily,2242,14))  
    wdetail.n_text077 = TRIM(SUBSTRING(nv_daily,2256,14))  
    wdetail.n_text078 = TRIM(SUBSTRING(nv_daily,2270,14)) 
    wdetail.n_text079 = TRIM(SUBSTRING(nv_daily,2284,14)) 
    wdetail.n_text080 = TRIM(SUBSTRING(nv_daily,2298,14)) 
    wdetail.n_text081 = TRIM(SUBSTRING(nv_daily,2312,14)) 
    wdetail.n_text082 = TRIM(SUBSTRING(nv_daily,2326,14)) 
    wdetail.n_text083 = TRIM(SUBSTRING(nv_daily,2340,2))     
    wdetail.n_text084 = TRIM(SUBSTRING(nv_daily,2342,14))    
    wdetail.n_text085 = TRIM(SUBSTRING(nv_daily,2356,14))   
    wdetail.n_text086 = TRIM(SUBSTRING(nv_daily,2370,2))  
    wdetail.n_text087 = TRIM(SUBSTRING(nv_daily,2372,14))  
    wdetail.n_text088 = TRIM(SUBSTRING(nv_daily,2386,14)) 
    wdetail.n_text089 = TRIM(SUBSTRING(nv_daily,2400,14)) 
    wdetail.n_text090 = TRIM(SUBSTRING(nv_daily,2414,6))                                
    wdetail.n_text091 = TRIM(SUBSTRING(nv_daily,2420,10))                       
    wdetail.n_text092 = TRIM(SUBSTRING(nv_daily,2430,10))                  
    wdetail.n_text093 = TRIM(SUBSTRING(nv_daily,2440,30))                  
    wdetail.n_text094 = TRIM(SUBSTRING(nv_daily,2470,80))              
    wdetail.n_text095 = TRIM(SUBSTRING(nv_daily,2550,10))                      
    wdetail.n_text096 = TRIM(SUBSTRING(nv_daily,2560,30))                     
    wdetail.n_text097 = TRIM(SUBSTRING(nv_daily,2590,12))                          
    wdetail.n_text098 = TRIM(SUBSTRING(nv_daily,2602,3))                               
    wdetail.n_text099 = TRIM(SUBSTRING(nv_daily,2605,10))             
    wdetail.n_text100 = TRIM(SUBSTRING(nv_daily,2615,14))               
    wdetail.n_text101 = TRIM(SUBSTRING(nv_daily,2629,10))                   
    wdetail.n_text102 = TRIM(SUBSTRING(nv_daily,2639,14))               
    wdetail.n_text103 = TRIM(SUBSTRING(nv_daily,2653,10))                   
    wdetail.n_text104 = TRIM(SUBSTRING(nv_daily,2663,14))               
    wdetail.n_text105 = TRIM(SUBSTRING(nv_daily,2677,10))                   
    wdetail.n_text106 = TRIM(SUBSTRING(nv_daily,2687,14))               
    wdetail.n_text107 = TRIM(SUBSTRING(nv_daily,2701,10))                   
    wdetail.n_text108 = TRIM(SUBSTRING(nv_daily,2711,14))               
    wdetail.n_text109 = TRIM(SUBSTRING(nv_daily,2725,15))  
    wdetail.n_text110 = TRIM(SUBSTRING(nv_daily,2740,10))  
    wdetail.n_text111 = TRIM(SUBSTRING(nv_daily,2750,14))  
    wdetail.n_text112 = TRIM(SUBSTRING(nv_daily,2764,10))  
    wdetail.n_text113 = TRIM(SUBSTRING(nv_daily,2774,20))  
    wdetail.n_text114 = TRIM(SUBSTRING(nv_daily,2794,1))   
    wdetail.n_text115 = TRIM(SUBSTRING(nv_daily,2795,120)) 
    wdetail.n_text116 = TRIM(SUBSTRING(nv_daily,2915,100)) 
    wdetail.n_text117 = TRIM(SUBSTRING(nv_daily,3015,2))   
    wdetail.n_text118 = TRIM(SUBSTRING(nv_daily,3017,2))   
    wdetail.n_text119 = TRIM(SUBSTRING(nv_daily,3019,10))  
    wdetail.n_text120 = TRIM(SUBSTRING(nv_daily,3029,1))   
    wdetail.n_text121 = TRIM(SUBSTRING(nv_daily,3030,10))  
    wdetail.n_text122 = TRIM(SUBSTRING(nv_daily,3040,255))     
    wdetail.n_text123 = TRIM(SUBSTRING(nv_daily,3295,5))   
    wdetail.n_text124 = TRIM(SUBSTRING(nv_daily,3300,20))         
    wdetail.n_text125 = TRIM(SUBSTRING(nv_daily,3320,10))             
    wdetail.n_text126 = TRIM(SUBSTRING(nv_daily,3330,150)) 
    wdetail.n_text127 = TRIM(SUBSTRING(nv_daily,3480,15))  
    wdetail.n_text128 = TRIM(SUBSTRING(nv_daily,3495,250))    
    wdetail.n_text129 = TRIM(SUBSTRING(nv_daily,3745,13))         
    wdetail.n_text130 = TRIM(SUBSTRING(nv_daily,3758,10))  
    wdetail.n_text131 = TRIM(SUBSTRING(nv_daily,3768,150))    
    wdetail.n_text132 = TRIM(SUBSTRING(nv_daily,3918,15))         
    wdetail.n_text133 = TRIM(SUBSTRING(nv_daily,3933,250))            
    wdetail.n_text134 = TRIM(SUBSTRING(nv_daily,4183,13))                 
    wdetail.n_text135 = TRIM(SUBSTRING(nv_daily,4196,10))  
    wdetail.n_text136 = TRIM(SUBSTRING(nv_daily,4206,150))    
    wdetail.n_text137 = TRIM(SUBSTRING(nv_daily,4356,15))         
    wdetail.n_text138 = TRIM(SUBSTRING(nv_daily,4371,250))            
    wdetail.n_text139 = TRIM(SUBSTRING(nv_daily,4621,13))                 
    wdetail.n_text140 = TRIM(SUBSTRING(nv_daily,4634,10))  
    wdetail.n_text141 = TRIM(SUBSTRING(nv_daily,4644,10))                     
    wdetail.n_text142 = TRIM(SUBSTRING(nv_daily,4654,10)). 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addwdetail2 C-Win 
PROCEDURE proc_addwdetail2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A68-0061      
------------------------------------------------------------------------------*/
DEF  VAR  nv_acc   AS  CHAR  .
DEF  VAR  nv_count AS  INTEGER . 
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "," 
        wf_policyno      
        wf_cndat         
        wf_appenno       
        wf_comdat        
        wf_expdat        
        wf_comcode       
        wf_cartyp        
        wf_saletyp       
        wf_typcom        
        wf_covhct        
        wf_garage        
        wf_typepol       
        wf_bysave        
        wf_tiname        
        wf_insnam        
        wf_name2         
        wf_name3         
        wf_addr          
        wf_road          
        wf_tambon        
        wf_amper         
        wf_country       
        wf_post          
        wf_icno          
        wf_brdealer      
        wf_occup         
        wf_birthdat      
        wf_driverno      
        wf_brand         
        wf_cargrp        
        wf_typecar       
        wf_chasno        
        wf_eng           
        wf_model         
        wf_caryear       
        wf_carcode       
        wf_maksi         
        wf_body          
        wf_carno         
        wf_seat          
        wf_engcc         
        wf_colorcar      
        wf_vehreg        
        wf_re_country    
        wf_re_year
        wf_si
        wf_premt         
        wf_rstp_t        
        wf_rtax_t        
        wf_prem_r        
        wf_gap           
        wf_ncb           
        wf_ncbprem       
        wf_stk           
        wf_prepol        
        wf_ntitle1       
        wf_drivername1   
        wf_dname1        
        wf_dname2        
        wf_docoup        
        wf_dbirth        
        wf_dicno         
        wf_ddriveno      
        wf_drivexp1 
        wf_drivcon1
        wf_dlevel1       
        wf_dgender1      
        wf_drelation1    
        wf_ntitle2       
        wf_drivername2   
        wf_ddname1       
        wf_ddname2       
        wf_ddocoup       
        wf_ddbirth       
        wf_ddicno        
        wf_dddriveno     
        wf_drivexp2
        wf_drivcon2
        wf_dlevel2       
        wf_dgender2      
        wf_drelation2    
        wf_ntitle3       
        wf_dname3        
        wf_dcname3       
        wf_dlname3       
        wf_doccup3       
        wf_dbirth3       
        wf_dicno3        
        wf_ddriveno3     
        wf_drivexp3
        wf_drivcon3
        wf_dlevel3       
        wf_dgender3      
        wf_drelation3    
        wf_ntitle4       
        wf_dname4        
        wf_dcname4       
        wf_dlname4       
        wf_doccup4       
        wf_dbirth4       
        wf_dicno4        
        wf_ddriveno4     
        wf_drivexp4 
        wf_drivcon4
        wf_dlevel4       
        wf_dgender4      
        wf_drelation4    
        wf_ntitle5       
        wf_dname5        
        wf_dcname5       
        wf_dlname5       
        wf_doccup5       
        wf_dbirth5       
        wf_dicno5        
        wf_ddriveno5     
        wf_drivexp5
        wf_drivcon5
        wf_dlevel5       
        wf_dgender5      
        wf_drelation5    
        wf_benname       
        wf_comper        
        wf_comacc        
        wf_tp1           
        wf_tp2           
        wf_deductda      
        wf_deductpd      
        wf_tpfire        
        wf_ac1           
        wf_ac2           
        wf_ac3           
        wf_ac4           
        wf_ac5           
        wf_ac6           
        wf_ac7           
        wf_drityp        
        wf_typrequest    
        wf_comrequest    
        wf_brrequest     
        wf_salename      
        wf_comcar        
        wf_brcar         
        wf_carold        
        wf_ac_date       
        wf_ac_amount     
        wf_ac_pay        
        wf_ac_agent      
        wf_detailcam     
        wf_ins_pay       
        wf_n_month       
        wf_n_bank        
        wf_TYPE_notify   
        wf_price_acc     
        wf_accdata       
        wf_chargflg      
        wf_chargprice    
        wf_chargno       
        wf_chargprm      
        wf_battflg       
        wf_battprice     
        wf_battno        
        wf_battprm       
        wf_battdate      
        wf_brand_gals    
        wf_brand_galsprm 
        wf_voicnam       
        wf_companyre1    
        wf_companybr1    
        wf_addr_re1      
        wf_idno_re1      
        wf_net_re1       
        wf_stam_re1      
        wf_vat_re1       
        wf_premt_re1     
        wf_inscode_re2   
        wf_companyre2    
        wf_companybr2    
        wf_addr_re2      
        wf_idno_re2      
        wf_net_re2       
        wf_stam_re2      
        wf_vat_re2       
        wf_premt_re2     
        wf_inscode_re3   
        wf_companyre3    
        wf_companybr3    
        wf_addr_re3      
        wf_idno_re3      
        wf_net_re3       
        wf_stam_re3      
        wf_vat_re3       
        wf_premt_re3     
        wf_camp_no       
        wf_payment_type  
        wf_nmember       
        wf_campen   .
    IF            TRIM(wf_policyno) = ""           THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"TEXT")   <> 0 THEN RUN proc_initdataex.
    ELSE IF index(TRIM(wf_policyno),"เลขที่") <> 0 THEN RUN proc_initdataex.
    ELSE IF INDEX(TRIM(wf_policyno),"จำนวน")  <> 0 THEN RUN proc_initdataex.  /*--A58-0419--*/
    ELSE IF INDEX(TRIM(wf_policyno),"HA")  = 0 THEN RUN proc_initdataex. /*A68-0061*/
    ELSE DO: 
        ASSIGN nv_acc  = ""    nv_count = 0
               wf_saletyp = IF      trim(wf_saletyp) = "Normal"   THEN "N" 
                            ELSE IF trim(wf_saletyp) = "Campaign" THEN "C" 
                            ELSE IF trim(wf_saletyp) = "Staff"    THEN "S" 
                           ELSE IF INDEX(wf_saletyp,"HATC") <> 0  THEN "H"
                           ELSE IF INDEX(wf_saletyp,"HLTC") <> 0  THEN "F"
                           ELSE IF INDEX(wf_saletyp,"Campaign") <> 0 THEN "C"
                           ELSE TRIM(wf_saletyp) 
               wf_covhct  = IF      INDEX(wf_covhct,"2+") <> 0 AND deci(wf_deductpd) = 2000 THEN "2.1"
                            ELSE IF INDEX(wf_covhct,"2+") <> 0 AND deci(wf_deductpd) = 0    THEN "2.2"
                            ELSE IF INDEX(wf_covhct,"3+") <> 0 AND deci(wf_deductpd) = 2000 THEN "3.1" 
                            ELSE IF INDEX(wf_covhct,"3+") <> 0 AND deci(wf_deductpd) = 0    THEN "3.2" 
                            ELSE IF INDEX(wf_covhct,"1") <> 0  THEN "1"
                            ELSE IF INDEX(wf_covhct,"2") <> 0  THEN "2" 
                            ELSE IF INDEX(wf_covhct,"3") <> 0  THEN "3" ELSE "0"
               wf_TYPE_notify = IF      trim(wf_TYPE_notify) = "New"    THEN "N" 
                                ELSE IF trim(wf_TYPE_notify) = "Renew"  THEN "R" 
                                ELSE IF TRIM(wf_type_notify) = "Switch" THEN "S" 
                                ELSE TRIM(wf_type_notify) . 

        IF trim(wf_accdata) <> ""  THEN DO:

            ASSIGN nv_acc = trim(wf_accdata).
            nv_count = 1 .
            loop_chk1: 
            REPEAT:
                IF nv_count <= 20 THEN DO:
                  IF (INDEX(nv_acc,",") <> 0 ) THEN ASSIGN  nv_acc = TRIM(REPLACE(nv_acc,",","")) .
                END.
                nv_count = nv_count + 1.
                IF nv_count > 20 THEN LEAVE loop_chk1.
            END.
            ASSIGN wf_accdata = TRIM(nv_acc).
        END.
        RUN proc_assdata. 
        RUN proc_initdataex.
    END.
END.         /* repeat   */
INPUT CLOSE.   /*close Import*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assdata C-Win 
PROCEDURE proc_assdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
CREATE wdetail.
ASSIGN 
    wdetail.n_text001  = trim(wf_policyno)                                    
    wdetail.n_text002  = trim(wf_cndat )                              
    wdetail.n_text003  = trim(wf_appenno)                              
    wdetail.n_text004  = trim(wf_comdat)
    wdetail.n_text005  = trim(wf_expdat)
    wdetail.n_text006  = trim(wf_comcode)                              
    wdetail.n_text007  = trim(wf_cartyp)
    wdetail.n_text008  = trim(wf_saletyp)                              
    wdetail.n_text012  = trim(wf_typcom)
    wdetail.n_text011  = trim(wf_covhct)
    wdetail.n_text013  = trim(wf_garage)
    wdetail.typepol    = trim(wf_typepol)                              
    wdetail.n_text014  = trim(wf_bysave)                              
    wdetail.n_text015  = trim(wf_tiname)                              
    wdetail.n_text016  = trim(wf_insnam)                              
    wdetail.n_text017  = trim(wf_name2)                              
    wdetail.n_text018  = trim(wf_name3)                              
    wdetail.n_text019  = trim(wf_addr)                              
    wdetail.n_text020  = trim(wf_road)                              
    wdetail.n_text021  = trim(wf_tambon)                              
    wdetail.n_text022  = trim(wf_amper )                              
    wdetail.n_text023  = trim(wf_country )                              
    wdetail.n_text024  = trim(wf_post)                              
    wdetail.n_text027  = trim(wf_icno)                              
    wdetail.n_text123  = trim(wf_brdealer)                              
    wdetail.n_text025  = trim(wf_occup   )                              
    wdetail.n_text026  = trim(wf_birthdat)                              
    wdetail.n_text028  = trim(wf_driverno)                              
    wdetail.n_text029  = trim(wf_brand )                              
    wdetail.n_text030  = trim(wf_cargrp)                              
    wdetail.typecar    = trim(wf_typecar)                              
    wdetail.n_text031  = trim(wf_chasno)                              
    wdetail.n_text032  = trim(wf_eng  )                              
    wdetail.n_text033  = trim(wf_model)                              
    wdetail.n_text034  = trim(wf_caryear)                              
    wdetail.n_text035  = trim(wf_carcode)                              
    wdetail.maksi      = trim(wf_maksi)                              
    wdetail.n_text036  = trim(wf_body )                              
    wdetail.n_text038  = trim(wf_carno)                              
    wdetail.n_text039  = trim(wf_seat )                              
    wdetail.n_text040  = trim(wf_engcc)                              
    wdetail.n_text041  = trim(wf_colorcar)                              
    wdetail.n_text042  = trim(wf_vehreg )                              
    wdetail.n_text043  = trim(wf_re_country)                              
    wdetail.n_text044  = trim(wf_re_year)                              
    wdetail.n_text046  = trim(wf_si )                              
    wdetail.n_text047  = trim(wf_premt )                              
    wdetail.n_text048  = trim(wf_rstp_t)                              
    wdetail.n_text049  = trim(wf_rtax_t)                              
    wdetail.n_text050  = trim(wf_prem_r)                              
    wdetail.n_text051  = trim(wf_gap)                              
    wdetail.n_text052  = trim(wf_ncb)                              
    wdetail.n_text053  = trim(wf_ncbprem)                              
    wdetail.n_text054  = trim(wf_stk)                              
    wdetail.n_text055  = trim(wf_prepol )                              
    wdetail.n_text058  = trim(wf_ntitle1)                              
    wdetail.n_text059  = trim(wf_drivername1 )                              
    wdetail.n_text060  = trim(wf_dname1)                              
    wdetail.n_text061  = trim(wf_dname2)                              
    wdetail.n_text062  = trim(wf_docoup)                              
    wdetail.n_text063  = trim(wf_dbirth)                              
    wdetail.n_text064  = trim(wf_dicno)                              
    wdetail.n_text065  = trim(wf_ddriveno)                              
    wdetail.drivexp2   = trim(wf_drivexp1)                              
    wdetail.drivcon2    = trim(wf_drivcon1)                              
    wdetail.dlevel2    = trim(wf_dlevel1 )                              
    wdetail.dgender2   = trim(wf_dgender1)                              
    wdetail.drelation2 = trim(wf_drelation1 )                              
    wdetail.n_text066  = trim(wf_ntitle2)   
    wdetail.n_text067  = trim(wf_drivername2)                              
    wdetail.n_text068  = trim(wf_ddname1)                              
    wdetail.n_text069  = trim(wf_ddname2)                              
    wdetail.n_text070  = trim(wf_ddocoup)                              
    wdetail.n_text071  = trim(wf_ddbirth)                              
    wdetail.n_text072  = trim(wf_ddicno )                              
    wdetail.n_text073  = trim(wf_dddriveno)                              
    wdetail.drivexp2   = trim(wf_drivexp2 )                              
    wdetail.drivcon2    = trim(wf_drivcon2)                              
    wdetail.dlevel2    = trim(wf_dlevel2  )                              
    wdetail.dgender2   = trim(wf_dgender2 )                              
    wdetail.drelation2 = trim(wf_drelation2)                              
    wdetail.ntitle3    = trim(wf_ntitle3  )                 
    wdetail.dname3     = trim(wf_dname3   )                 
    wdetail.dcname3    = trim(wf_dcname3  )                 
    wdetail.dlname3    = trim(wf_dlname3  )                 
    wdetail.doccup3    = trim(wf_doccup3  )                 
    wdetail.dbirth3    = trim(wf_dbirth3  )                 
    wdetail.dicno3     = trim(wf_dicno3   )                 
    wdetail.ddriveno3  = trim(wf_ddriveno3)                 
    wdetail.drivexp3   = trim(wf_drivexp3 )                 
    wdetail.drivcon3    = trim(wf_drivcon3)                 
    wdetail.dlevel3    = trim(wf_dlevel3  )                 
    wdetail.dgender3   = trim(wf_dgender3 )                 
    wdetail.drelation3 = trim(wf_drelation3)                              
    wdetail.ntitle4    = trim(wf_ntitle4)                              
    wdetail.dname4     = trim(wf_dname4 )                              
    wdetail.dcname4    = trim(wf_dcname4)                              
    wdetail.dlname4    = trim(wf_dlname4)                              
    wdetail.doccup4    = trim(wf_doccup4)                              
    wdetail.dbirth4    = trim(wf_dbirth4)                              
    wdetail.dicno4     = trim(wf_dicno4 )                              
    wdetail.ddriveno4  = trim(wf_ddriveno4)                              
    wdetail.drivexp4   = trim(wf_drivexp4 )                              
    wdetail.drivcon4    = trim(wf_drivcon4)                              
    wdetail.dlevel4    = trim(wf_dlevel4  )                              
    wdetail.dgender4   = trim(wf_dgender4 )                              
    wdetail.drelation4 = trim(wf_drelation4)                              
    wdetail.ntitle5    = trim(wf_ntitle5)                   
    wdetail.dname5     = trim(wf_dname5 )                   
    wdetail.dcname5    = trim(wf_dcname5)                   
    wdetail.dlname5    = trim(wf_dlname5)                   
    wdetail.doccup5    = trim(wf_doccup5)                   
    wdetail.dbirth5    = trim(wf_dbirth5)                   
    wdetail.dicno5     = trim(wf_dicno5 )                   
    wdetail.ddriveno5  = trim(wf_ddriveno5)                   
    wdetail.drivexp5   = trim(wf_drivexp5 )                   
    wdetail.drivcon5    = trim(wf_drivcon5)                   
    wdetail.dlevel5    = trim(wf_dlevel5 )                   
    wdetail.dgender5   = trim(wf_dgender5)                   
    wdetail.drelation5 = trim(wf_drelation5)                              
    wdetail.n_text074  = trim(wf_benname)                              
    wdetail.n_text075  = trim(wf_comper )                              
    wdetail.n_text076  = trim(wf_comacc )                              
    wdetail.n_text077  = trim(wf_tp1)                              
    wdetail.n_text078  = trim(wf_tp2)                              
    wdetail.n_text079  = trim(wf_deductda)                              
    wdetail.n_text080  = trim(wf_deductpd)                              
    wdetail.n_text081  = trim(wf_tpfire)                              
    wdetail.n_text082  = trim(wf_ac1)                              
    wdetail.n_text083  = trim(wf_ac2)                              
    wdetail.n_text084  = trim(wf_ac3)                              
    wdetail.n_text085  = trim(wf_ac4)                              
    wdetail.n_text086  = trim(wf_ac5)                              
    wdetail.n_text087  = trim(wf_ac6)                              
    wdetail.n_text088  = trim(wf_ac7)                              
    wdetail.n_text089  = trim(wf_drityp)                              
    wdetail.n_text091  = trim(wf_typrequest)                              
    wdetail.n_text092  = trim(wf_comrequest)                              
    wdetail.n_text093  = trim(wf_brrequest)                              
    wdetail.n_text094  = trim(wf_salename )                              
    wdetail.n_text095  = trim(wf_comcar)                              
    wdetail.n_text096  = trim(wf_brcar )                              
    wdetail.n_text098  = trim(wf_carold)                              
    wdetail.n_text110  = trim(wf_ac_date)                              
    wdetail.n_text111  = trim(wf_ac_amount)                              
    wdetail.n_text112  = trim(wf_ac_pay )                              
    wdetail.n_text113  = trim(wf_ac_agent)                              
    wdetail.n_text116  = trim(wf_detailcam)                              
    wdetail.n_text117  = trim(wf_ins_pay)                              
    wdetail.n_text118  = trim(wf_n_month)                              
    wdetail.n_text119  = trim(wf_n_bank )                              
    wdetail.n_text120  = trim(wf_TYPE_notify)                              
    wdetail.n_text121  = trim(wf_price_acc)                  
    wdetail.n_text122  = trim(wf_accdata)                  
    wdetail.chargflg   = trim(wf_chargflg )                  
    wdetail.chargprice = trim(wf_chargprice )                              
    wdetail.chargno    = trim(wf_chargno)                              
    wdetail.chargprm   = trim(wf_chargprm )                              
    wdetail.battflg    = trim(wf_battflg)                              
    wdetail.battprice  = trim(wf_battprice)                              
    wdetail.battno     = trim(wf_battno )                              
    wdetail.battprm    = trim(wf_battprm)                              
    wdetail.battdate   = trim(wf_battdate )                              
    wdetail.n_text124  = trim(wf_brand_gals  )                              
    wdetail.n_text125  = trim(wf_brand_galsprm)                             
    wdetail.n_text115  = trim(wf_voicnam  )                               
    wdetail.n_text126  = trim(wf_companyre1)                               
    wdetail.n_text127  = trim(wf_companybr1)                               
    wdetail.n_text128  = trim(wf_addr_re1)                               
    wdetail.n_text129  = trim(wf_idno_re1)                               
    wdetail.net_re1    = trim(wf_net_re1 )                               
    wdetail.stam_re1   = trim(wf_stam_re1)                               
    wdetail.vat_re1    = trim(wf_vat_re1 )                               
    wdetail.n_text130  = trim(wf_premt_re1)                               
    wdetail.inscode_re2 = trim(wf_inscode_re2)                               
    wdetail.n_text131  = trim(wf_companyre2 )                               
    wdetail.n_text132  = trim(wf_companybr2 )                               
    wdetail.n_text133  = trim(wf_addr_re2)                               
    wdetail.n_text134  = trim(wf_idno_re2)                               
    wdetail.net_re2    = trim(wf_net_re2 )                               
    wdetail.stam_re2   = trim(wf_stam_re2)                               
    wdetail.vat_re2    = trim(wf_vat_re2 )                               
    wdetail.n_text135  = trim(wf_premt_re2)                               
    wdetail.inscode_re3 = trim(wf_inscode_re3)                               
    wdetail.n_text136  = trim(wf_companyre3 )                               
    wdetail.n_text137  = trim(wf_companybr3 )                               
    wdetail.n_text138  = trim(wf_addr_re3)                               
    wdetail.n_text139  = trim(wf_idno_re3)                               
    wdetail.net_re3    = trim(wf_net_re3 )                               
    wdetail.stam_re3   = trim(wf_stam_re3)                               
    wdetail.vat_re3    = trim(wf_vat_re3 )                               
    wdetail.n_text140  = trim(wf_premt_re3)                               
    wdetail.n_text141  = trim(wf_camp_no  )                               
    wdetail.n_text142  = trim(wf_payment_type)                              
    wdetail.n_text045   = trim(wf_nmember) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ckstk C-Win 
PROCEDURE proc_ckstk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF input  parameter nv_inpstk      as CHAR .   
DEF OUTPUT PARAMETER nv_txtmsgerr   AS CHAR .
DEF VAR chk_sticker AS CHAR INIT "". 

ASSIGN  
    chr_sticker = nv_inpstk.
    chk_sticker = chr_sticker.
    
RUN wuz\wuzchmod.
IF chk_sticker  <>  chr_sticker  THEN DO: 
    
    ASSIGN nv_txtmsgerr = nv_txtmsgerr  + "| เลขพ.ร.บ.ซ้ำ Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error". 
    MESSAGE "เลขพ.ร.บ.ซ้ำ Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error " nv_inpstk  VIEW-AS ALERT-BOX.

END. 
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ckvehreg C-Win 
PROCEDURE proc_ckvehreg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF input parameter nv_inpvehreg    as CHAR .   
DEF OUTPUT PARAMETER nv_txtmsgerr   AS CHAR .
DEF VAR nv_vehreg AS CHAR INIT "".

ASSIGN nv_vehreg =  trim(nv_inpvehreg) . 

IF nv_vehreg <> "" THEN DO:
 

IF      INDEX(nv_vehreg," ")  = 0  THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ติดกัน" .
ELSE IF INDEX(nv_vehreg,".") <> 0  THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มีจุด"  .
ELSE IF INDEX(nv_vehreg,"้") <> 0  THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มี ้" .
ELSE IF INDEX(nv_vehreg,"๊") <> 0  THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มี๊" .
ELSE IF INDEX(nv_vehreg,"๋") <> 0  THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " มี๋"  .
ELSE DO:
    IF INDEX("123456789",SUBSTR(nv_vehreg,1,1)) <> 0  THEN DO: 
        IF  SUBSTR(nv_vehreg,2,1) = "" THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ตำแหน่งที่สอง ค่าว่าง"  .
        ELSE DO:                                                       
            IF      SUBSTR(nv_vehreg,3,2) = "" THEN  ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ตำแหน่งที่สามสี่ ค่าว่าง"  .
            ELSE IF SUBSTR(nv_vehreg,4,2) = "" THEN  ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg + " ตำแหน่งที่สี่ห้า ค่าว่าง"  .
        END.
    END.
    ELSE DO: /*    "ขง 9999".     */                                   
        IF      SUBSTR(nv_vehreg,2,2) = "" THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg +  " ตำแหน่งที่สองสาม ค่าว่าง"  .
        ELSE IF SUBSTR(nv_vehreg,3,2) = "" THEN ASSIGN nv_txtmsgerr = nv_txtmsgerr + "|ทะเบียนรถไม่ถูกต้อง ทะเบียน " + nv_vehreg +  " ตำแหน่งที่สามสี่ ค่าว่าง"   .
    END.
END.
END.

IF nv_txtmsgerr <> ""  THEN MESSAGE nv_txtmsgerr VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createpro C-Win 
PROCEDURE proc_createpro :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wimproducer.
    DELETE wimproducer.
END.
 
FOR EACH brstat.insure USE-INDEX Insure03 WHERE brstat.insure.compno  =  fi_campaign   NO-LOCK.
    FIND LAST wimproducer WHERE wimproducer.idno = brstat.insure.lname NO-ERROR NO-WAIT.
    IF NOT AVAIL wimproducer THEN DO:
        CREATE wimproducer. 
        ASSIGN
            wimproducer.idno     = brstat.insure.lname 
            wimproducer.saletype = brstat.Insure.InsNo
            wimproducer.camname  = brstat.insure.vatcode 
            wimproducer.notitype = brstat.insure.text4   
            wimproducer.producer = brstat.insure.Text1 .
    END.
END.
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
/*
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
*/
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdataex C-Win 
PROCEDURE proc_initdataex :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    wf_policyno        = ""
    wf_cndat           = ""
    wf_appenno         = ""
    wf_comdat          = ""
    wf_expdat          = ""
    wf_comcode         = ""
    wf_cartyp          = ""
    wf_saletyp         = ""
    wf_typcom          = ""
    wf_covhct          = ""
    wf_garage          = ""
    wf_typepol         = ""
    wf_bysave          = ""
    wf_tiname          = ""
    wf_insnam          = ""
    wf_name2           = ""
    wf_name3           = ""
    wf_addr            = ""
    wf_road            = ""
    wf_tambon          = ""
    wf_amper           = ""
    wf_country         = ""
    wf_post            = ""
    wf_icno            = ""
    wf_brdealer        = ""
    wf_occup           = ""
    wf_birthdat        = ""
    wf_driverno        = ""
    wf_brand           = ""
    wf_cargrp          = ""
    wf_typecar         = ""
    wf_chasno          = ""
    wf_eng             = ""
    wf_model           = ""
    wf_caryear         = ""
    wf_carcode         = ""
    wf_maksi           = ""
    wf_body            = ""
    wf_carno           = ""
    wf_seat            = ""
    wf_engcc           = ""
    wf_colorcar        = ""
    wf_vehreg          = ""
    wf_re_country      = ""
    wf_re_year         = ""
    wf_SI              = ""
    wf_premt           = ""
    wf_rstp_t          = ""
    wf_rtax_t          = ""
    wf_prem_r          = ""
    wf_gap             = ""
    wf_ncb             = ""
    wf_ncbprem         = ""
    wf_stk             = ""
    wf_prepol          = ""
    wf_ntitle1         = ""
    wf_drivername1     = ""
    wf_dname1          = ""
    wf_dname2          = ""
    wf_docoup          = ""
    wf_dbirth          = ""
    wf_dicno           = ""
    wf_ddriveno        = ""
    wf_drivexp1        = ""
    wf_drivcon1        = ""
    wf_dlevel1         = ""
    wf_dgender1        = ""
    wf_drelation1      = ""
    wf_ntitle2         = ""
    wf_drivername2     = ""
    wf_ddname1         = ""
    wf_ddname2         = ""
    wf_ddocoup         = ""
    wf_ddbirth         = ""
    wf_ddicno          = ""
    wf_dddriveno       = ""
    wf_drivexp2        = ""
    wf_drivcon2        = ""
    wf_dlevel2         = ""
    wf_dgender2        = ""
    wf_drelation2      = ""
    wf_ntitle3         = ""
    wf_dname3          = ""
    wf_dcname3         = ""
    wf_dlname3         = ""
    wf_doccup3         = ""
    wf_dbirth3         = ""
    wf_dicno3          = ""
    wf_ddriveno3       = ""
    wf_drivexp3        = ""
    wf_drivcon3        = ""
    wf_dlevel3         = ""
    wf_dgender3        = ""
    wf_drelation3      = ""
    wf_ntitle4         = ""
    wf_dname4          = ""
    wf_dcname4         = ""
    wf_dlname4         = ""
    wf_doccup4         = ""
    wf_dbirth4         = ""
    wf_dicno4          = ""
    wf_ddriveno4       = ""
    wf_drivexp4        = ""
    wf_drivcon4        = ""
    wf_dlevel4         = ""
    wf_dgender4        = ""
    wf_drelation4      = ""
    wf_ntitle5         = ""
    wf_dname5          = ""
    wf_dcname5         = ""
    wf_dlname5         = ""
    wf_doccup5         = ""
    wf_dbirth5         = ""
    wf_dicno5          = ""
    wf_ddriveno5       = ""
    wf_drivexp5        = ""
    wf_drivcon5        = ""
    wf_dlevel5         = ""
    wf_dgender5        = ""
    wf_drelation5      = ""
    wf_benname         = ""
    wf_comper          = ""
    wf_comacc          = ""
    wf_tp1             = ""
    wf_tp2             = ""
    wf_deductda        = ""
    wf_deductpd        = ""
    wf_tpfire          = ""
    wf_ac1             = ""
    wf_ac2             = ""
    wf_ac3             = ""
    wf_ac4             = ""
    wf_ac5             = ""
    wf_ac6             = ""
    wf_ac7             = ""
    wf_drityp          = ""
    wf_typrequest      = ""
    wf_comrequest      = ""
    wf_brrequest       = ""
    wf_salename        = ""
    wf_comcar          = ""
    wf_brcar           = ""
    wf_carold          = ""
    wf_ac_date         = ""
    wf_ac_amount       = ""
    wf_ac_pay          = ""
    wf_ac_agent        = ""
    wf_detailcam       = ""
    wf_ins_pay         = ""
    wf_n_month         = ""
    wf_n_bank          = ""
    wf_TYPE_notify     = ""
    wf_price_acc       = ""
    wf_accdata         = ""
    wf_chargflg        = ""
    wf_chargprice      = ""
    wf_chargno         = ""
    wf_chargprm        = ""
    wf_battflg         = ""
    wf_battprice       = ""
    wf_battno          = ""
    wf_battprm         = ""
    wf_battdate        = ""
    wf_brand_gals      = ""
    wf_brand_galsprm   = ""
    wf_voicnam         = ""
    wf_companyre1      = ""
    wf_companybr1      = ""
    wf_addr_re1        = ""
    wf_idno_re1        = ""
    wf_net_re1         = ""
    wf_stam_re1        = ""
    wf_vat_re1         = ""
    wf_premt_re1       = ""
    wf_inscode_re2     = ""
    wf_companyre2      = ""
    wf_companybr2      = ""
    wf_addr_re2        = ""
    wf_idno_re2        = ""
    wf_net_re2         = ""
    wf_stam_re2        = ""
    wf_vat_re2         = ""
    wf_premt_re2       = ""
    wf_inscode_re3     = ""
    wf_companyre3      = ""
    wf_companybr3      = ""
    wf_addr_re3        = ""
    wf_idno_re3        = ""
    wf_net_re3         = ""
    wf_stam_re3        = ""
    wf_vat_re3         = ""
    wf_premt_re3       = ""
    wf_camp_no         = ""
    wf_payment_type    = ""
    wf_nmember         = ""
    wf_campen          = "" .


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
/*------------A67-0110
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
        nv_branchdesp = "" .  
/* 
IF  nv_producer   = "B3M0033"  AND 
    nv_agent      = "B3M0035"  THEN 
     ASSIGN nv_branchdesp = "Dealer Business 1".    /*งาน OEM-FORD*/
ELSE ASSIGN nv_branchdesp = "ML (Bank & Finance)".  /*งาน Tisco   */
*/
 
IF INDEX(wdetail.n_text015,"คุณ")               <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.n_text015,"นาย")          <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.n_text015,"นาง")          <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.n_text015,"น.ส.")         <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.n_text015,"นางสาว")       <> 0 THEN ASSIGN nv_nameT = "บุคคล".
ELSE IF INDEX(wdetail.n_text015,"ห้างหุ้นส่วน") <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
ELSE IF INDEX(wdetail.n_text015,"หจก")          <> 0 THEN ASSIGN nv_nameT = "ห้างหุ้นส่วนจำกัด / ห้างหุ้นส่วน".
ELSE IF INDEX(wdetail.n_text015,"บริษัท")       <> 0 THEN ASSIGN nv_nameT = "บริษัท".
ELSE IF INDEX(wdetail.n_text015,"บจก")          <> 0 THEN ASSIGN nv_nameT = "บริษัท".
ELSE IF INDEX(wdetail.n_text015,"มูลนิธิ")      <> 0 THEN ASSIGN nv_nameT = "มูลนิธิ".
ELSE IF INDEX(wdetail.n_text015,"โรงแรม")       <> 0 THEN ASSIGN nv_nameT = "โรงแรม".
ELSE IF INDEX(wdetail.n_text015,"โรงเรียน")     <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
ELSE IF INDEX(wdetail.n_text015,"ร.ร.")         <> 0 THEN ASSIGN nv_nameT = "โรงเรียน".
ELSE IF INDEX(wdetail.n_text015,"โรงพยาบาล")    <> 0 THEN ASSIGN nv_nameT = "โรงพยาบาล".
ELSE IF INDEX(wdetail.n_text015,"นิติบุคคลอาคารชุด") <> 0 THEN ASSIGN nv_nameT = "นิติบุคคลอาคารชุด".
ELSE ASSIGN nv_nameT = "อื่นๆ".


ASSIGN nv_brand = IF INDEX(wdetail.n_text029," ") <> 0 THEN trim(SUBSTR(wdetail.n_text029,1,INDEX(wdetail.n_text029," ") - 1 )) ELSE trim(wdetail.n_text029)
       nv_model = IF INDEX(wdetail.n_text029," ") <> 0 THEN trim(SUBSTR(wdetail.n_text029,LENGTH(nv_brand) + 1,LENGTH(wdetail.n_text029))) ELSE "".

IF trim(wdetail.n_text042) <> "" AND trim(wdetail.n_text043) <> "" THEN DO:  
    ASSIGN nv_licentyp = "รถเก๋ง/กระบะ/บรรทุก".                            
    RUN proc_province.
END.
ELSE DO: 
    ASSIGN nv_licentyp = "รถที่ยังไม่มีทะเบียน"
           nv_pattern4 = "/ZZZZZZZZZ" 
           wdetail.n_text042 = trim(wdetail.n_text031) /* add A63-0210*/
           wdetail.n_text042 = "/" + SUBSTR(wdetail.n_text042,LENGTH(wdetail.n_text042) - 8,LENGTH(wdetail.n_text042)) 
           wdetail.n_text043 = "".
END.

IF trim(nv_producer) <> "" THEN DO:
 FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
      xmm600.acno  =  trim(nv_producer) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        FIND sicsyac.xtm600 USE-INDEX xtm60001  WHERE xtm600.acno  =  trim(nv_producer) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600 THEN 
            ASSIGN nv_agentname = TRIM(sicsyac.xtm600.ntitle) + "  "  + TRIM(sicsyac.xtm600.name) .
        ELSE 
            ASSIGN nv_agentname = "".
    END.
    ELSE 
        ASSIGN nv_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
END.

IF wdetail.n_text042 <> "" THEN DO:
   ASSIGN nv_licen = REPLACE(wdetail.n_text042," ","").
  /*
   IF INDEX("0123456789",SUBSTR(wdetail.n_text042,1,1)) <> 0 THEN DO:
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
      IF INDEX("0123456789",SUBSTR(wdetail.n_text042,1,1)) <> 0 THEN DO:
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

/*--------- Server Real ---------- */
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
             "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
  END.
  chNotesView    = chNotesDatabase:GetView("เลขตัวถัง").
  chNavView      = chNotesView:CreateViewNav.
  chDocument     = chNotesView:GetDocumentByKey(trim(wdetail.n_text031)).
 
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
          IF nv_survey <> "" THEN
            ASSIGN  brstat.tlt.id_typ = "ISP:" + nv_docno + " Detail:" + nv_detail .
          ELSE 
            ASSIGN  brstat.tlt.id_typ = "ISP:" + nv_docno.
      END.
      ELSE 
          ASSIGN  brstat.tlt.id_typ = "ISP:" .


      RELEASE  OBJECT chitem          NO-ERROR.
      RELEASE  OBJECT chDocument      NO-ERROR.          
      RELEASE  OBJECT chNotesDataBase NO-ERROR.     
      RELEASE  OBJECT chNotesSession  NO-ERROR.
  END.
 /* ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO:
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
      chDocument:AppendItemValue( "Fname", wdetail.n_text016).    
      chDocument:AppendItemValue( "Lname", wdetail.n_text018).    
      chDocument:AppendItemValue( "PolicyNo", ""). 
      chDocument:AppendItemValue( "agentCode",trim(nv_producer)).  
      chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
      chDocument:AppendItemValue( "model", nv_brand).
      chDocument:AppendItemValue( "modelCode", nv_model).
      chDocument:AppendItemValue( "carCC", trim(wdetail.n_text031)).
      chDocument:AppendItemValue( "Year", trim(brstat.tlt.lince2)).           
      chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
      chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
      chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
      chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
      chDocument:AppendItemValue( "LicenseNo_2", trim(wdetail.n_text043)).
      chDocument:AppendItemValue( "commentMK", trim(wdetail.n_text045)).
      chDocument:SAVE(TRUE,TRUE).
    RELEASE  OBJECT chitem          NO-ERROR.
    RELEASE  OBJECT chDocument      NO-ERROR.          
    RELEASE  OBJECT chNotesDataBase NO-ERROR.     
    RELEASE  OBJECT chNotesSession  NO-ERROR.

    ASSIGN brstat.tlt.id_typ = "ISP:".   
  END.
  */
  /*comment by Kridtiya i. A63-00472
    chDocument:AppendItemValue( "BranchReq", "Business Unit 3").  ปรับแก้ไข จาก "Business Unit 3" เป็น nv_branchdesp
    chDocument:AppendItemValue( "BranchReq", nv_branchdesp ).
  comment by Kridtiya i. A63-00472  */
  A67-0110 ---*/
 
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
       IF INDEX(wdetail.n_text043,".") <> 0 THEN REPLACE(wdetail.n_text043,".","").           
/*1*/        IF wdetail.n_text043 = "กระบี่"          THEN wdetail.n_text043 = "กบ".
/*2*/   ELSE IF wdetail.n_text043 = "กรุงเทพมหานคร"   THEN wdetail.n_text043 = "กท".
/*3*/   ELSE IF wdetail.n_text043 = "กาญจนบุรี"       THEN wdetail.n_text043 = "กจ". 
/*3*/   ELSE IF wdetail.n_text043 = "กาฬสินธุ์"       THEN wdetail.n_text043 = "กส".
/*4*/   ELSE IF wdetail.n_text043 = "กำแพงเพชร"       THEN wdetail.n_text043 = "กพ".
/*5*/   ELSE IF wdetail.n_text043 = "ขอนแก่น"         THEN wdetail.n_text043 = "ขก".
/*6*/   ELSE IF wdetail.n_text043 = "จันทบุรี"        THEN wdetail.n_text043 = "จบ".
/*7*/   ELSE IF wdetail.n_text043 = "ฉะเชิงเทรา"      THEN wdetail.n_text043 = "ฉช".
/*8*/   ELSE IF wdetail.n_text043 = "ชลบุรี"          THEN wdetail.n_text043 = "ชบ".
/*9*/   ELSE IF wdetail.n_text043 = "ชัยนาท"          THEN wdetail.n_text043 = "ชน".
/*10*/  ELSE IF wdetail.n_text043 = "ชัยภูมิ"         THEN wdetail.n_text043 = "ชย".
/*11*/  ELSE IF wdetail.n_text043 = "ชุมพร"           THEN wdetail.n_text043 = "ชพ".
/*12*/  ELSE IF wdetail.n_text043 = "เชียงราย"        THEN wdetail.n_text043 = "ชร".
/*13*/  ELSE IF wdetail.n_text043 = "เชียงใหม่"       THEN wdetail.n_text043 = "ชม".
/*14*/  ELSE IF wdetail.n_text043 = "ตรัง"            THEN wdetail.n_text043 = "ตง".
/*15*/  ELSE IF wdetail.n_text043 = "ตราด"            THEN wdetail.n_text043 = "ตร".
/*16*/  ELSE IF wdetail.n_text043 = "ตาก"             THEN wdetail.n_text043 = "ตก".
/*17*/  ELSE IF wdetail.n_text043 = "นครนายก"         THEN wdetail.n_text043 = "นย".
/*18*/  ELSE IF wdetail.n_text043 = "นครปฐม"          THEN wdetail.n_text043 = "นฐ".
/*19*/  ELSE IF wdetail.n_text043 = "นครพนม"          THEN wdetail.n_text043 = "นพ".
/*20*/  ELSE IF wdetail.n_text043 = "นครราชสีมา"      THEN wdetail.n_text043 = "นม".
/*21*/  ELSE IF wdetail.n_text043 = "นครศรีธรรมราช"   THEN wdetail.n_text043 = "นศ".
/*22*/  ELSE IF wdetail.n_text043 = "นครสวรรค์"       THEN wdetail.n_text043 = "นว".
/*23*/  ELSE IF wdetail.n_text043 = "นนทบุรี"         THEN wdetail.n_text043 = "นบ".
/*24*/  ELSE IF wdetail.n_text043 = "นราธิวาส"        THEN wdetail.n_text043 = "นธ".
/*25*/  ELSE IF wdetail.n_text043 = "น่าน"            THEN wdetail.n_text043 = "นน".
/*26*/  ELSE IF wdetail.n_text043 = "บีงกาฬ"          THEN wdetail.n_text043 = "บก".
/*27*/  ELSE IF wdetail.n_text043 = "บุรีรัมย์"       THEN wdetail.n_text043 = "บร".
/*28*/  ELSE IF wdetail.n_text043 = "ปทุมธานี"        THEN wdetail.n_text043 = "ปท".
/*29*/  ELSE IF wdetail.n_text043 = "ประจวบคีรีขันธ์" THEN wdetail.n_text043 = "ปข".
/*30*/  ELSE IF wdetail.n_text043 = "ปราจีนบุรี"      THEN wdetail.n_text043 = "ปจ".
/*31*/  ELSE IF wdetail.n_text043 = "ปัตตานี"         THEN wdetail.n_text043 = "ปน".
/*32*/  ELSE IF wdetail.n_text043 = "พระนครศรีอยุธยา" THEN wdetail.n_text043 = "อย".
/*33*/  ELSE IF wdetail.n_text043 = "พะเยา"           THEN wdetail.n_text043 = "พย".
/*34*/  ELSE IF wdetail.n_text043 = "พังงา"           THEN wdetail.n_text043 = "พง".
/*35*/  ELSE IF wdetail.n_text043 = "พัทลุง"          THEN wdetail.n_text043 = "พท".
/*36*/  ELSE IF wdetail.n_text043 = "พิจิตร"          THEN wdetail.n_text043 = "พจ".
/*37*/  ELSE IF wdetail.n_text043 = "พิษณุโลก"        THEN wdetail.n_text043 = "พล".
/*38*/  ELSE IF wdetail.n_text043 = "เพชรบุรี"        THEN wdetail.n_text043 = "พบ".
/*39*/  ELSE IF wdetail.n_text043 = "เพชรบูรณ์"       THEN wdetail.n_text043 = "พช".
/*40*/  ELSE IF wdetail.n_text043 = "แพร่"            THEN wdetail.n_text043 = "พร".
/*41*/  ELSE IF wdetail.n_text043 = "ภูเก็ต"          THEN wdetail.n_text043 = "ภก".
/*42*/  ELSE IF wdetail.n_text043 = "มหาสารคาม"       THEN wdetail.n_text043 = "มค".
/*43*/  ELSE IF wdetail.n_text043 = "มุกดาหาร"        THEN wdetail.n_text043 = "มห".
/*44*/  ELSE IF wdetail.n_text043 = "แม่ฮ่องสอน"      THEN wdetail.n_text043 = "มส".
/*45*/  ELSE IF wdetail.n_text043 = "ยโสธร"           THEN wdetail.n_text043 = "ยส".
/*46*/  ELSE IF wdetail.n_text043 = "ยะลา"            THEN wdetail.n_text043 = "ยล".
/*47*/  ELSE IF wdetail.n_text043 = "ร้อยเอ็ด"        THEN wdetail.n_text043 = "รอ".
/*48*/  ELSE IF wdetail.n_text043 = "ระนอง"           THEN wdetail.n_text043 = "รน".
/*49*/  ELSE IF wdetail.n_text043 = "ระยอง"           THEN wdetail.n_text043 = "รย".
/*50*/  ELSE IF wdetail.n_text043 = "ราชบุรี"         THEN wdetail.n_text043 = "รบ".
/*51*/  ELSE IF wdetail.n_text043 = "ลพบุรี"          THEN wdetail.n_text043 = "ลบ".
/*52*/  ELSE IF wdetail.n_text043 = "ลำปาง"           THEN wdetail.n_text043 = "ลป".
/*53*/  ELSE IF wdetail.n_text043 = "ลำพูน"           THEN wdetail.n_text043 = "ลพ".
/*54*/  ELSE IF wdetail.n_text043 = "เลย"             THEN wdetail.n_text043 = "ลย".
/*55*/  ELSE IF wdetail.n_text043 = "ศรีสะเกษ"        THEN wdetail.n_text043 = "ศก".
/*56*/  ELSE IF wdetail.n_text043 = "สกลนคร"          THEN wdetail.n_text043 = "สน".
/*57*/  ELSE IF wdetail.n_text043 = "สงขลา"           THEN wdetail.n_text043 = "สข".
/*58*/  ELSE IF wdetail.n_text043 = "สตูล"            THEN wdetail.n_text043 = "สต".
/*59*/  ELSE IF wdetail.n_text043 = "สมุทรปราการ"     THEN wdetail.n_text043 = "สป".
/*60*/  ELSE IF wdetail.n_text043 = "สมุทรสงคราม"     THEN wdetail.n_text043 = "สส".
/*61*/  ELSE IF wdetail.n_text043 = "สมุทรสาคร"       THEN wdetail.n_text043 = "สค".
/*62*/  ELSE IF wdetail.n_text043 = "สระแก้ว"         THEN wdetail.n_text043 = "สก".  
/*63*/  ELSE IF wdetail.n_text043 = "สระบุรี"         THEN wdetail.n_text043 = "สบ".
/*64*/  ELSE IF wdetail.n_text043 = "สิงห์บุรี"       THEN wdetail.n_text043 = "สห".
/*65*/  ELSE IF wdetail.n_text043 = "สุโขทัย"         THEN wdetail.n_text043 = "สท".
/*66*/  ELSE IF wdetail.n_text043 = "สุพรรณบุรี"      THEN wdetail.n_text043 = "สพ".
/*67*/  ELSE IF wdetail.n_text043 = "สุราษฎร์ธานี"    THEN wdetail.n_text043 = "สฎ".
/*68*/  ELSE IF wdetail.n_text043 = "สุรินทร์"        THEN wdetail.n_text043 = "สร".
/*69*/  ELSE IF wdetail.n_text043 = "หนองคาย"         THEN wdetail.n_text043 = "นค". 
/*70*/  ELSE IF wdetail.n_text043 = "หนองบัวลำภู"     THEN wdetail.n_text043 = "นภ".
/*71*/  ELSE IF wdetail.n_text043 = "อ่างทอง"         THEN wdetail.n_text043 = "อท".
/*72*/  ELSE IF wdetail.n_text043 = "อำนาจเจริญ"      THEN wdetail.n_text043 = "อจ".
/*73*/  ELSE IF wdetail.n_text043 = "อุดรธานี"        THEN wdetail.n_text043 = "อด".
/*74*/  ELSE IF wdetail.n_text043 = "อุตรดิตถ์"       THEN wdetail.n_text043 = "อต".
/*75*/  ELSE IF wdetail.n_text043 = "อุทัยธานี"       THEN wdetail.n_text043 = "อน".
/*76*/  ELSE IF wdetail.n_text043 = "อุบลราชธานี"     THEN wdetail.n_text043 = "อบ".

        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(wdetail.n_text043) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN wdetail.n_text043 = brstat.Insure.LName.
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
DEF input parameter nn_namelist     as char.     
DEF input parameter nn_namelist2    as char.   
DEF input parameter nn_vehreglist   as char.   
DEF input parameter nn_vehreglist2  as char.   
DEF input parameter nv_chanolist    as char.   
DEF OUTPUT PARAMETER nv_txtsusspect AS CHAR.

ASSIGN nv_txtsusspect = "" .  

FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
    brstat.insure.compno = "999" AND
    brstat.insure.FName = TRIM(nn_vehreglist2) NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.insure THEN
    ASSIGN 
     nn_vehreglist2 = trim(Insure.LName)
     nn_vehreglist  = trim(substr(nn_vehreglist,1,8)) + " " + nn_vehreglist2 .
ELSE nn_vehreglist  = trim(substr(nn_vehreglist,1,8)). 
     
IF nn_vehreglist <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            nv_txtsusspect = nv_txtsusspect + "|รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน"  .
    END.
END.
IF (nv_txtsusspect = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN
            nv_txtsusspect = nv_txtsusspect + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                nv_txtsusspect = nv_txtsusspect + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
        END.
    END.
END.
IF (nv_txtsusspect = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN  
            nv_txtsusspect = nv_txtsusspect + "|รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
END.
/*
IF (nv_txtsusspect = "") AND (nv_idnolist <> "") THEN DO:
    
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN nv_txtsusspect = nv_txtsusspect + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
    IF nv_txtsusspect = "" THEN DO:
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
                nv_txtsusspect = nv_txtsusspect + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
        END.
    END.
END.*/
IF nv_txtsusspect <> "" THEN MESSAGE nv_txtsusspect VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_updateproducer C-Win 
PROCEDURE Proc_updateproducer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail NO-LOCK WHERE wdetail.n_text011 <> "0" .
    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE
        brstat.tlt.comp_noti_ins = wdetail.n_text001 AND   /*1   เลขที่ใบคำขอ HA641108150     */
        brstat.tlt.nor_usr_ins   = wdetail.n_text011 AND   /*11    ประเภทความคุ้มครอง        0 */  
        brstat.tlt.cha_no        = wdetail.n_text031 AND   /*31    หมายเลขตัวถัง                    */
        brstat.tlt.genusr        = fi_compa      NO-LOCK    NO-ERROR NO-WAIT .
    IF   AVAIL brstat.tlt THEN DO: 
        /*brstat.tlt.acno1  */      
        FIND LAST bbtlt USE-INDEX tlt06  WHERE
            bbtlt.comp_noti_ins = brstat.tlt.comp_noti_ins AND   /*1   เลขที่ใบคำขอ HA641108150     */
            bbtlt.nor_usr_ins   = "0"                      AND   /*11    ประเภทความคุ้มครอง        0 */  
            bbtlt.cha_no        = brstat.tlt.cha_no        AND   /*31    หมายเลขตัวถัง                    */
            bbtlt.genusr        = brstat.tlt.genusr        NO-ERROR NO-WAIT .
        IF AVAIL bbtlt THEN
            ASSIGN bbtlt.acno1 = brstat.tlt.acno1 .
    END.
END.   /* FOR EACH wdetail NO-LOCK: */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

