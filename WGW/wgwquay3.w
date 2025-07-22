&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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
program id   : wgwquay3.w
program name : Query & Update Data Aycl Compulsory
               Import text file from  Aycal to create  new policy Add in table  tlt 
Create  by   : Kridtiya i. [A57-0005]  date  06/01/2014
Connect      : GW_SAFE LD SIC_BRAN, GW_STAT LD BRSTAT ,SICSYAC,SICUW [Not connect : Stat]
Modify       : Jiraporn P. [A59-0342]   date 13/07/2016
             : ��䢡�ù���� �ú. �֧�������ء��Ҩҡ File �ú.�����Ŵ����к������ҧ�١��ͧ��Фú��ǹ             
Modify       : Jiraphon P. [A59-0451]   date 03/09/2016
             : ��䢡�ù���� �ú. �֧�������ء��Ҩҡ File �ú.������õѴ�觪�ͧ������� 
Modify By  : Ranu I. A60-0542 date:18/12/2017  ����������� "Campaign CJ"  �����
             �ҡ�ա�����  "Y" �ʴ������ �ú.������� ��Ҥ�� ��ا�����ظ�� �ӡѴ(��Ҫ�)
Modify By  : Sarinya C. A61-0349 date:31/07/2018  ����� Agent Code ������ B3W0100 
Modify by : Ranu I. A64-0060 ���������� �Ѿഷ �Ţʵ��������ѧ�ѧ Sticker BU3 
+++++++++++++++++++++++++++++++++++++++++++++++*/

DEFINE  VAR nv_rectlt    as recid init  0.  
DEFINE  VAR nv_recidtlt  as recid init  0.  
DEF  STREAM ns2.                        
DEFINE  VAR nv_cnt       as int   init  1. 
DEFINE  VAR nv_row       as int   init  0. 
DEFINE  VAR n_record     AS INTE  INIT  0. 
DEFINE  VAR n_comname    AS CHAR  INIT  "".
DEFINE  VAR n_asdat      AS CHAR.
DEFINE  VAR vAcProc_fil  AS CHAR.
DEFINE  VAR vAcProc_fil2 AS CHAR.
DEFINE  VAR n_asdat2     AS CHAR.
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD notifydate        AS CHAR FORMAT "X(10)"  INIT ""                                                    
    FIELD branch            AS CHAR FORMAT "X(2)"   INIT ""                                    
    FIELD policy            AS CHAR FORMAT "X(12)"  INIT ""   
    FIELD stk               AS CHAR FORMAT "X(15)"  INIT ""                                       
    FIELD docno             AS CHAR FORMAT "X(10)"  INIT ""                                    
    FIELD remark            AS CHAR FORMAT "X(150)" INIT "" 
    FIELD SEQ               AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD INSURANCECODE     AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD CONTRACTNO        AS CHAR FORMAT "X(20)"  INIT ""
    FIELD Campaign_CJ       AS CHAR FORMAT "x(2)"   INIT "" /*A60-0542*/
    FIELD BRANCHCODE        AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD BRANCHNO          AS CHAR FORMAT "X(150)" INIT "" 
    FIELD STICKERNO         AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD CUSTOMERNAME      AS CHAR FORMAT "X(100)" INIT "" 
    FIELD ADDRESS           AS CHAR FORMAT "X(150)" INIT ""  
    FIELD ADDRESS2          AS CHAR FORMAT "X(150)" INIT ""  /*Jiraphon A59-0451*/
    FIELD ADDRESS3          AS CHAR FORMAT "X(150)" INIT ""  /*Jiraphon A59-0451*/
    FIELD ADDRESS4          AS CHAR FORMAT "X(150)" INIT ""  /*Jiraphon A59-0451*/
    FIELD ADDRESS5          AS CHAR FORMAT "X(150)" INIT ""  /*Jiraphon A59-0451*/
    FIELD CARNO             AS CHAR FORMAT "X(10)"  INIT ""
    FIELD MODCOD            AS CHAR FORMAT "X(8)"   INIT ""  /*A59-0069*/
    FIELD BRAND             AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD MODEL             AS CHAR FORMAT "X(60)"  INIT "" 
    FIELD CC                AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD REGISTRATION      AS CHAR FORMAT "X(11)"  INIT "" 
    FIELD PROVINCE          AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD BODY              AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD ENGINE            AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD STARTDATE         AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD ENDDATE           AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD NETINCOME         AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD TOTALINCOME       AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD CARDID            AS CHAR FORMAT "X(15)"  INIT ""  
    FIELD nSTATUS           AS CHAR FORMAT "x(10)"  INIT ""
    FIELD n_memmopremium    AS CHAR FORMAT "x(30)"  INIT ""
    FIELD producer          AS CHAR FORMAT "X(10)"  INIT ""  /*A59-0069*/
    FIELD agent             AS CHAR FORMAT "X(10)"  INIT "" /*A59-0069*/
    FIELD checkpolicy       AS CHAR FORMAT "X(30)"  INIT "" /*A59-0342*/ /*check policy*/
    FIELD Regis             AS CHAR FORMAT "X(10)"  INIT "" /*A59-0342 ����¹ö*/
    FIELD camp_CJ           AS CHAR FORMAT "x(60)"  INIT "" . /*A60-0542*/

DEF VAR nv_countdata     AS DECI INIT 0.
DEF VAR nv_countnotcomp  AS DECI INIT 0.
DEF VAR nv_countcomplete AS DECI INIT 0.
DEF VAR np_addr1         AS CHAR FORMAT "x(256)" INIT "".
DEF VAR np_addr2         AS CHAR FORMAT "x(40)"  INIT "".
DEF VAR np_addr3         AS CHAR FORMAT "x(40)"  INIT "".
DEF VAR np_addr4         AS CHAR FORMAT "x(40)"  INIT "".
DEF VAR np_title         AS CHAR FORMAT "x(30)"  INIT "".
DEF VAR np_name          AS CHAR FORMAT "x(40)"  INIT "".
DEF VAR np_name2         AS CHAR FORMAT "x(40)"  INIT "".
DEF VAR nv_outfile       AS CHAR FORMAT "x(256)" INIT "".
                         
DEF VAR nv_comdat        AS CHAR FORMAT "X(10)"  INIT "".
DEF VAR nv_expdat        AS CHAR FORMAT "X(10)"  INIT "".
DEF VAR nv_model         AS CHAR FORMAT "X(20)"  INIT "".
DEF VAR nv_cha_no        AS CHAR FORMAT "X(35)"  INIT "".

DEF VAR nv_REGISTRATION  AS CHAR FORMAT "X(35)"  INIT "".  /*Add jiraporn A59-0342*/
DEF VAR nv_sdate  AS date FORMAT "99/99/9999"  INIT "".  /*Add jiraporn A59-0342*/
DEF VAR nv_edate  AS date FORMAT "99/99/9999"  INIT "".  /*Add jiraporn A59-0342*/
DEF VAR nv_fname        AS CHAR FORMAT "X(25)"  INIT "". /*Add jiraporn A59-0342*/
DEF VAR nv_lname        AS CHAR FORMAT "X(2)"  INIT "". /*Add jiraporn A59-0342*/

DEFINE TEMP-TABLE brtlt LIKE brstat.tlt.
DEFINE VAR nv_br AS CHAR FORMAT "X(2)" INIT "".
DEFINE VAR nv_brnpol  LIKE sicsyac.s0m003.fld12.
DEFINE VAR nv_startno LIKE sicsyac.s0m003.fld21.
DEFINE VAR nv_brnno  AS CHAR FORMAT "X(5)".
DEFINE VAR nv_polno  AS INTE.
DEFINE VAR nv_year   AS CHAR FORMAT "X(2)".

DEFINE VAR nv_address AS CHAR FORMAT "X(180)". 
DEFINE VAR nv_tam AS CHAR FORMAT "X(180)". 
DEFINE VAR nv_amp AS CHAR FORMAT "X(180)".  
DEFINE VAR nv_no AS CHAR FORMAT "X(180)".
DEFINE VAR n_soy AS CHAR FORMAT "X(180)".
DEFINE VAR n_road AS CHAR FORMAT "X(180)".
DEF VAR nv_prov AS CHAR FORMAT "X(100)".

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
&Scoped-define INTERNAL-TABLES brtlt

/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt /* brtlt.releas brtlt.trndat brtlt.entdat brtlt.nor_noti_tlt brtlt.comp_usr_tlt brtlt.cha_no brtlt.safe2 brtlt.filler2 brtlt.endno */ /*Add Jiraphon A59-0342*/ brtlt.releas brtlt.trndat brtlt.entdat brtlt.nor_noti_tlt brtlt.lotno "Insurance Code" brtlt.comp_noti_tlt "Contract No." brtlt.comp_usr_tlt "�Ң�" brtlt.colorcod "Branch Code" brtlt.subins "Branch No." brtlt.cha_no "�Ţʵ������" brtlt.ins_name "�����١���" brtlt.recac "�Ţ�ѵû�ЪҪ�" brtlt.ins_addr1 "�Ţ���" /**/ brtlt.ins_addr2 "�Ӻ�/�ǧ" brtlt.ins_addr3 "�����/ࢵ" brtlt.ins_addr4 "�ѧ��Ѵ" brtlt.ins_addr5 "������ɳ���" /**/ brtlt.lince1 "Registration" brtlt.lince2 "Province" brtlt.lince3 "�Ţ����¹ö" brtlt.comp_sub "Class" brtlt.brand "������ö" brtlt.model "���ö" brtlt.cc_weight "��.��." brtlt.comp_sck "�Ţ��Ƕѧ" brtlt.eng_no "�Ţ����ͧ¹��" brtlt.nor_effdat "�ѹ��������������ͧ" brtlt.comp_effdat "�ѹ�������ش������ͧ" brtlt.comp_coamt "Net Prem." brtlt.comp_grprm "Gross Prem" brtlt.safe2 "�Ţ��������" brtlt.filler2 "�����˵�" brtlt.endno "User" /*brtlt.sentcnt "Count"*/ /*End Jiraphon A59-0342*/   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt   
&Scoped-define SELF-NAME br_tlt
&Scoped-define QUERY-STRING-br_tlt FOR EACH brtlt BY brtlt.cha_no
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH brtlt BY brtlt.cha_no.
&Scoped-define TABLES-IN-QUERY-br_tlt brtlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt brtlt


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_tlt}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_despd rs_type ra_matchfile fi_loaddate ~
fi_inputfile fi_trndatfr fi_trndatto fi_search ra_bydelete fi_datadelform ~
fi_datadelto fi_filename2 fi_outfile fi_filename bu_reok bu_delete bu_sch ~
bbu_reok2 cb_report fi_reportdata bu_exit bu_file bu_imp bu_ok cb_search ~
fi_report bu_file-2 bu_delete-2 fi_producer fi_agent fi_desag RECT-332 ~
br_tlt RECT-343 RECT-494 RECT-495 RECT-496 RECT-497 RECT-498 RECT-499 ~
RECT-500 RECT-347 
&Scoped-Define DISPLAYED-OBJECTS fi_despd rs_type ra_matchfile fi_loaddate ~
fi_inputfile fi_trndatfr fi_trndatto fi_search ra_bydelete fi_datadelform ~
fi_datadelto fi_filename2 fi_outfile fi_filename fi_process2 cb_report ~
fi_reportdata cb_search fi_report fi_producer fi_agent fi_desag 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bbu_reok2 
     LABEL "OK" 
     SIZE 6 BY 1.

DEFINE BUTTON bu_delete 
     LABEL "DELETE" 
     SIZE 8.83 BY .95
     FONT 0.

DEFINE BUTTON bu_delete-2 
     LABEL "YES/NO" 
     SIZE 8 BY .95.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 6 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_file-2 
     LABEL "..." 
     SIZE 4 BY .95.

DEFINE BUTTON bu_imp 
     LABEL "IMP" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7 BY 1
     FONT 6.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 6 BY 1
     FONT 6.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 7.33 BY 1.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "�Ң�" 
     DROP-DOWN-LIST
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "�Ţ��������" 
     DROP-DOWN-LIST
     SIZE 36 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datadelform AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datadelto AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_desag AS CHARACTER FORMAT "X(56)":U 
      VIEW-AS TEXT 
     SIZE 40.67 BY .91
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_despd AS CHARACTER FORMAT "X(56)":U 
      VIEW-AS TEXT 
     SIZE 40.67 BY .91
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58.67 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_inputfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_loaddate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58.67 BY .91
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58.67 BY .91
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10.5 BY .95
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_reportdata AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.33 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 39.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_bydelete AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Trandate", 1,
"Policy", 2,
"Sticker", 3
     SIZE 39.83 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_matchfile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "File Normal", 1,
"File CJ", 2,
"Cancel", 3
     SIZE 51.5 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 2 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "��", 1,
"�����", 2
     SIZE 10 BY 2.05
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 137.5 BY 9.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 54 BY 8.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-347
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 53 BY 1.33
     BGCOLOR 6 FGCOLOR 0 .

DEFINE RECTANGLE RECT-494
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 137.5 BY 1.81
     BGCOLOR 15 .

DEFINE RECTANGLE RECT-495
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.5 BY 1.38
     BGCOLOR 3 FGCOLOR 7 .

DEFINE RECTANGLE RECT-496
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 81 BY 6.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-497
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 81 BY 2.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-498
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.33 BY 1.38
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-499
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.33 BY 1.33
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-500
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.5 BY 1.33
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      brtlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _FREEFORM
  QUERY br_tlt NO-LOCK DISPLAY
      /*
 brtlt.releas FORMAT "X(6)"  COLUMN-LABEL "Release"
 brtlt.trndat  COLUMN-LABEL "Trn.Date"
 brtlt.entdat  COLUMN-LABEL "Entry Date"
 brtlt.nor_noti_tlt COLUMN-LABEL "�Ţ�������� �ú."
 brtlt.comp_usr_tlt COLUMN-LABEL "�Ң�"
 brtlt.cha_no  COLUMN-LABEL "�Ţʵ������"
 brtlt.safe2   COLUMN-LABEL "�Ţ��������"
 brtlt.filler2 COLUMN-LABEL "�����˵�"
 brtlt.endno   COLUMN-LABEL "User"
 */
 /*Add Jiraphon A59-0342*/
 brtlt.releas FORMAT "X(6)"  COLUMN-LABEL "Release"
 brtlt.trndat  COLUMN-LABEL "Trn.Date"
 brtlt.entdat  COLUMN-LABEL "Entry Date"
 brtlt.nor_noti_tlt COLUMN-LABEL "�Ţ�������� �ú."
 
 
 brtlt.lotno                                COLUMN-LABEL    "Insurance Code"
 brtlt.comp_noti_tlt                        COLUMN-LABEL    "Contract No."
 brtlt.comp_usr_tlt                         COLUMN-LABEL    "�Ң�"
 brtlt.colorcod                             COLUMN-LABEL    "Branch Code"  
 brtlt.subins           FORMAT "X(20)"      COLUMN-LABEL    "Branch No."
 brtlt.cha_no                               COLUMN-LABEL    "�Ţʵ������"
 brtlt.ins_name                             COLUMN-LABEL    "�����١���"   
 brtlt.recac            FORMAT "X(15)"      COLUMN-LABEL    "�Ţ�ѵû�ЪҪ�"    
 brtlt.ins_addr1        FORMAT "X(70)"      COLUMN-LABEL    "�Ţ���"
 /**/
 brtlt.ins_addr2        FORMAT "X(30)"      COLUMN-LABEL    "�Ӻ�/�ǧ"
 brtlt.ins_addr3        FORMAT "X(30)"      COLUMN-LABEL    "�����/ࢵ"
 brtlt.ins_addr4        FORMAT "X(30)"      COLUMN-LABEL    "�ѧ��Ѵ"
 brtlt.ins_addr5        FORMAT "X(10)"      COLUMN-LABEL    "������ɳ���"
 /**/
 brtlt.lince1           FORMAT "X(15)"      COLUMN-LABEL    "Registration"
 brtlt.lince2           FORMAT "X(20)"      COLUMN-LABEL    "Province"
 brtlt.lince3           FORMAT "X(25)"      COLUMN-LABEL    "�Ţ����¹ö"
 brtlt.comp_sub                             COLUMN-LABEL    "Class"
 brtlt.brand            FORMAT "X(20)"      COLUMN-LABEL    "������ö"
 brtlt.model            FORMAT "X(50)"      COLUMN-LABEL    "���ö"
 brtlt.cc_weight                            COLUMN-LABEL    "��.��."
 brtlt.comp_sck                             COLUMN-LABEL    "�Ţ��Ƕѧ"
 brtlt.eng_no                               COLUMN-LABEL    "�Ţ����ͧ¹��"
 brtlt.nor_effdat                           COLUMN-LABEL    "�ѹ��������������ͧ"
 brtlt.comp_effdat                          COLUMN-LABEL    "�ѹ�������ش������ͧ"
 brtlt.comp_coamt                           COLUMN-LABEL    "Net Prem."
 brtlt.comp_grprm                           COLUMN-LABEL    "Gross Prem"
 brtlt.safe2                                COLUMN-LABEL    "�Ţ��������"
 brtlt.filler2                              COLUMN-LABEL    "�����˵�"
 brtlt.endno                                COLUMN-LABEL    "User" 
 /*brtlt.sentcnt                              COLUMN-LABEL    "Count"*/
 /*End Jiraphon A59-0342*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 137.33 BY 14.29
         BGCOLOR 15 FGCOLOR 0  ROW-HEIGHT-CHARS .81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_despd AT ROW 4.24 COL 82.83 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     rs_type AT ROW 3.24 COL 126 NO-LABEL WIDGET-ID 8
     ra_matchfile AT ROW 3.19 COL 74 NO-LABEL
     fi_loaddate AT ROW 1.43 COL 21.17 COLON-ALIGNED NO-LABEL
     fi_inputfile AT ROW 1.43 COL 54 COLON-ALIGNED NO-LABEL
     fi_trndatfr AT ROW 3.38 COL 18.83 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 4.52 COL 18.83 COLON-ALIGNED NO-LABEL
     fi_search AT ROW 7 COL 3 NO-LABEL
     ra_bydelete AT ROW 8.24 COL 15.17 NO-LABEL
     fi_datadelform AT ROW 9.43 COL 8.33 COLON-ALIGNED NO-LABEL
     fi_datadelto AT ROW 9.43 COL 27.33 COLON-ALIGNED NO-LABEL
     fi_filename2 AT ROW 6.14 COL 66.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 7.1 COL 66.83 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.43 COL 66.5 COLON-ALIGNED NO-LABEL
     bu_reok AT ROW 10.33 COL 118.67
     bu_delete AT ROW 9.43 COL 44.67
     fi_process2 AT ROW 8.05 COL 66.83 COLON-ALIGNED NO-LABEL
     bu_sch AT ROW 6.95 COL 42.5
     bbu_reok2 AT ROW 7.19 COL 128.33
     cb_report AT ROW 9.33 COL 68.33 COLON-ALIGNED NO-LABEL
     fi_reportdata AT ROW 9.33 COL 108.67 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 10.33 COL 129.17
     bu_file AT ROW 1.43 COL 119.5
     bu_imp AT ROW 1.43 COL 124.5
     bu_ok AT ROW 4.52 COL 37.33
     cb_search AT ROW 5.86 COL 17.33 NO-LABEL
     fi_report AT ROW 9.33 COL 97.67 COLON-ALIGNED NO-LABEL
     bu_file-2 AT ROW 6 COL 127.67
     bu_delete-2 AT ROW 10.57 COL 20.17
     fi_producer AT ROW 4.24 COL 66.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.19 COL 66.67 COLON-ALIGNED NO-LABEL
     fi_desag AT ROW 5.19 COL 82.83 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     br_tlt AT ROW 11.71 COL 1
     "Report File :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 9.38 COL 57.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Transdate To   :" VIEW-AS TEXT
          SIZE 17.33 BY 1 AT ROW 4.52 COL 3
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Imp KPI :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 6.19 COL 57.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Match file KPN :" VIEW-AS TEXT
          SIZE 16.33 BY .91 AT ROW 3.19 COL 57.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Transdate From :" VIEW-AS TEXT
          SIZE 17.33 BY 1 AT ROW 3.38 COL 3
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "From :" VIEW-AS TEXT
          SIZE 6.83 BY .95 AT ROW 9.43 COL 3
          BGCOLOR 6 FGCOLOR 15 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 9.43 COL 24.5
          BGCOLOR 6 FGCOLOR 15 FONT 6
     "Search By :" VIEW-AS TEXT
          SIZE 13.83 BY 1 AT ROW 5.86 COL 3
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Update Status :" VIEW-AS TEXT
          SIZE 16.33 BY .95 AT ROW 10.57 COL 3
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Producer :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 4.24 COL 57.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "   Agent :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 5.24 COL 57.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "File name :" VIEW-AS TEXT
          SIZE 10.5 BY 1 AT ROW 10.48 COL 57.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Load Date :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 1.43 COL 10.67
          BGCOLOR 3 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 137.83 BY 25.29
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Out KPI :" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 7.14 COL 57.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "AYCAL :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 1.43 COL 3
          BGCOLOR 12 FGCOLOR 7 FONT 6
     " Import File STK :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 1.43 COL 38.67
          BGCOLOR 3 FGCOLOR 15 FONT 6
     " Delete By :" VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 8.29 COL 2.83 WIDGET-ID 12
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RECT-332 AT ROW 2.86 COL 1
     RECT-343 AT ROW 3 COL 2
     RECT-494 AT ROW 1 COL 1
     RECT-495 AT ROW 4.33 COL 36.5
     RECT-496 AT ROW 3 COL 56.5
     RECT-497 AT ROW 9.1 COL 56.5
     RECT-498 AT ROW 7 COL 127.67
     RECT-499 AT ROW 10.14 COL 118
     RECT-500 AT ROW 10.14 COL 128.33
     RECT-347 AT ROW 9.24 COL 2.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 137.83 BY 25.29
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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [DATA BY AYCL Compulsory]"
         HEIGHT             = 25.38
         WIDTH              = 137.33
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
IF NOT c-wins:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
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
/* BROWSE-TAB br_tlt RECT-332 fr_main */
ASSIGN 
       br_tlt:SEPARATOR-FGCOLOR IN FRAME fr_main      = 0.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       bu_file-2:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR COMBO-BOX cb_search IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_process2 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _START_FREEFORM
OPEN QUERY br_tlt FOR EACH brtlt BY brtlt.cha_no.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Query            is OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [DATA BY AYCL Compulsory] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [DATA BY AYCL Compulsory] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bbu_reok2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bbu_reok2 c-wins
ON CHOOSE OF bbu_reok2 IN FRAME fr_main /* OK */
DO:
    IF fi_outfile = ""  THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        APPLY "Entry"  TO fi_outfile.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        IF ra_matchfile = 1      THEN RUN IMPORT_notificationkpi.
        ELSE IF ra_matchfile = 2 THEN RUN IMPORT_notificationkpi2. /*A60-0542*/   
        ELSE RUN IMPORT_filecancel.                            
    END.
    /*ELSE RUN Import_notificationkpi. --Comment Jiraporn A59-0342*/

    /*IF ra_matchfile = 1 THEN DO: */                   /*A60-0542*/   
    IF ra_matchfile = 1 OR ra_matchfile = 2 THEN DO:    /*A60-0542*/   
         RUN proc_reportmat4.
         RUN Open_tlt2.
         MESSAGE "Load  Data Complete "  SKIP
                 "�ӹǹ�����ŷ�����   "  nv_countdata     SKIP
                 "�ӹǹ�����ŷ������ "  nv_countcomplete VIEW-AS ALERT-BOX.
     END.

    /* IF ra_matchfile = 2 THEN DO: */    /*A60-0542*/
     IF ra_matchfile = 3 THEN DO:         /*A60-0542*/
          RUN update_cancel.
          RUN Open_tlt2.
          MESSAGE  "�ӹǹ�����ŷ�����   "  nv_countdata SKIP
                   "�ӹǹ�����ŷ������ "  nv_countcomplete VIEW-AS ALERT-BOX.
                  
     END.
         
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_tlt
&Scoped-define SELF-NAME br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    GET CURRENT br_tlt.
    
    FIND LAST brstat.tlt WHERE 
              brstat.tlt.nor_noti_tlt = brtlt.nor_noti_tlt AND
              brstat.tlt.cha_no       = brtlt.cha_no       NO-LOCK NO-ERROR NO-WAIT.
  
    nv_recidtlt  =  RECID(brstat.tlt).
    
    {&WINDOW-NAME}:HIDDEN  =  YES. 
    RUN  wgw\wgwquay4(INPUT nv_recidtlt).
    {&WINDOW-NAME}:HIDDEN  =  NO.   
    
    RUN Open_tlt2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
  /*   Get  current  br_tlt.
     nv_rectlt =  recid(tlt).*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete c-wins
ON CHOOSE OF bu_delete IN FRAME fr_main /* DELETE */
DO:
    DEF VAR logAns AS LOGI INIT NO.  
    logAns = NO.

    IF ra_bydelete = 1 THEN DO:  
        MESSAGE "��ͧ���ź��������¡�� "  DATE(fi_datadelform)   " - "    DATE(fi_datadelto)  
            UPDATE logAns                     
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "ź�����ŵ���ѹ���".   
    END.
    ELSE DO:
        MESSAGE "��ͧ���ź�����š�������"   TRIM(fi_datadelform)   " - "    TRIM(fi_datadelto)  
            UPDATE logAns                     
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
            TITLE "ź�����š���������".   
    END.
    IF logAns THEN DO:  
        IF ra_bydelete = 1 THEN DO:
            FOR EACH brstat.tlt USE-INDEX  tlt01  WHERE
                brstat.tlt.trndat  >=   DATE(fi_datadelform)  AND
                brstat.tlt.trndat  <=   DATE(fi_datadelto)    AND
                brstat.tlt.genusr   =  "Aycal72"              AND 
                index(brstat.tlt.releas,"YES")  = 0       .  /*A64-0060*/
                DELETE brstat.tlt. 
            END.
        END.
        ELSE IF ra_bydelete = 2 THEN DO:
            FOR EACH brstat.tlt  WHERE
                brstat.tlt.nor_noti_tlt  >=   TRIM(fi_datadelform)  AND
                brstat.tlt.nor_noti_tlt  <=   TRIM(fi_datadelto)    AND
                brstat.tlt.genusr         =  "Aycal72"              AND 
                index(brstat.tlt.releas,"YES")  = 0       .   /*A64-0060*/
                DELETE brstat.tlt. 
            END.
        END.
        ELSE DO:
            FOR EACH brstat.tlt USE-INDEX  tlt06  WHERE
                brstat.tlt.cha_no  >=   TRIM(fi_datadelform)  AND
                brstat.tlt.cha_no  <=   TRIM(fi_datadelto)    AND
                brstat.tlt.genusr   =  "Aycal72"              AND 
                index(brstat.tlt.releas,"YES")  = 0       .   /*A64-0060*/  
                DELETE brstat.tlt. 
            END.
        END.
        MESSAGE "ź���������º���� ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.  
    RUN Open_tlt2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_delete-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_delete-2 c-wins
ON CHOOSE OF bu_delete-2 IN FRAME fr_main /* YES/NO */
DO:
    DEF VAR logAns AS LOGI INIT NO.  
    logAns = NO.

    MESSAGE "Update No ��������¡�ù��  " UPDATE logAns                     
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
    TITLE "Update Data  Yes or No...? ".

    IF logAns THEN DO:  
        FIND brstat.tlt WHERE RECID(brstat.tlt)  =  nv_rectlt.
        IF AVAIL brstat.tlt THEN DO:
            IF  INDEX(brstat.tlt.releas,"No")  =  0  THEN DO:    /* yes */
                IF brstat.tlt.releas = "" THEN tlt.releas  =  "NO" .
                ELSE IF INDEX(brstat.tlt.releas,"Cancel/")  <> 0 THEN ASSIGN brstat.tlt.releas  =  "Cancel/no" .
                ELSE ASSIGN brstat.tlt.releas  =  "no" .

            END.
            ELSE DO:    /* no */
                IF  INDEX(brstat.tlt.releas,"Yes")  =  0  THEN DO:  /* no */
                    IF brstat.tlt.releas = "" THEN tlt.releas  =  "Yes" .
                    ELSE IF INDEX(brstat.tlt.releas,"Cancel/")  <> 0 THEN ASSIGN brstat.tlt.releas  =  "Cancel/Yes" .
                    ELSE ASSIGN brstat.tlt.releas  =  "Yes" .
                END.
            END.
        END.
        MESSAGE "Update ���������º�������� ..." VIEW-AS ALERT-BOX INFORMATION.  
    END.

    RUN Open_tlt2.
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
        FILTERS    "Text Documents" "*.csv"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_inputfile  = cvData.
        nv_outfile    = SUBSTR(cvData,1,LENGTH(cvData) - 4 ) + "_stkbu3" +
                        STRING(DAY(TODAY),"99")      + 
                        STRING(MONTH(TODAY),"99")    + 
                        STRING(YEAR(TODAY),"9999")      + 
                        SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                        SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv".

        DISP fi_inputfile WITH FRAME fr_main.     
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
        
        FILTERS    "Text Documents" "*.csv"
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.

    IF OKpressed = TRUE THEN DO:
        ASSIGN 
            fi_filename2  = cvData
            fi_outfile    = SUBSTR(cvData,1,LENGTH(cvData) - 4 ) + "_" +
                            STRING(DAY(TODAY),"99")      + 
                            STRING(MONTH(TODAY),"99")    + 
                            STRING(YEAR(TODAY),"9999")      + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                            SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv".
             

        DISP fi_filename2 fi_outfile WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_imp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_imp c-wins
ON CHOOSE OF bu_imp IN FRAME fr_main /* IMP */
DO:
    IF  fi_inputfile = "" THEN DO:
        MESSAGE "Please input file name ...........!!!" VIEW-AS ALERT-BOX.
        APPLY "Entry"  TO fi_inputfile.
        RETURN NO-APPLY.
    END.
    ELSE RUN Import_notification1.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    /*--
    OPEN QUERY br_tlt 
        FOR EACH brtlt USE-INDEX  tlt01  NO-LOCK 
        WHERE brtlt.trndat  >=  fi_trndatfr AND
              brtlt.trndat  <=  fi_trndatto AND
              brtlt.genusr   = "Aycal72"  
        BY brtlt.nor_noti_tlt  .
            ASSIGN nv_rectlt =  RECID(brtlt) .
            APPLY "Entry"  TO br_tlt.
            RETURN NO-APPLY.      
    --*/

    FOR EACH brtlt:
        DELETE brtlt.
    END.

    FOR EACH brstat.tlt USE-INDEX tlt01 NO-LOCK
        WHERE brstat.tlt.trndat  >= fi_trndatfr AND
              brstat.tlt.trndat  <= fi_trndatto AND
              brstat.tlt.genusr = "AYCAL72" 
    BY brstat.tlt.nor_noti_tlt.
        ASSIGN
            nv_rectlt = RECID(brstat.tlt).

        CREATE brtlt.
        ASSIGN
            brtlt.releas       = brstat.tlt.releas      
            brtlt.trndat       = brstat.tlt.trndat      
            brtlt.entdat       = brstat.tlt.entdat      
            brtlt.nor_noti_tlt = brstat.tlt.nor_noti_tlt
            brtlt.comp_usr_tlt = brstat.tlt.comp_usr_tlt
            brtlt.cha_no       = brstat.tlt.cha_no      
            brtlt.safe2        = brstat.tlt.safe2       
            brtlt.filler2      = brstat.tlt.filler2     
            brtlt.endno        = brstat.tlt.endno
           /*Add Jiraphon A59-0342*/
            brtlt.lotno           = brstat.tlt.lotno       
            brtlt.comp_noti_tlt   = brstat.tlt.comp_noti_tlt
            brtlt.colorcod        = brstat.tlt.colorcod    
            brtlt.subins          = brstat.tlt.subins      
            brtlt.ins_name        = brstat.tlt.ins_name
            brtlt.recac           = brstat.tlt.recac       
            brtlt.ins_addr1       = brstat.tlt.ins_addr1
            /*add Jiraphon A59-0451*/
            brtlt.ins_addr2       = brstat.tlt.ins_addr2
            brtlt.ins_addr3       = brstat.tlt.ins_addr3
            brtlt.ins_addr4       = brstat.tlt.ins_addr4
            brtlt.ins_addr5       = brstat.tlt.ins_addr5
            /*End Jiraphon A59-0451*/

            brtlt.comp_sub        = brstat.tlt.comp_sub    
            brtlt.brand           = brstat.tlt.brand       
            brtlt.model           = brstat.tlt.model       
            brtlt.cc_weight       = brstat.tlt.cc_weight   
            brtlt.lince1          = brstat.tlt.lince1      
            brtlt.lince2          = brstat.tlt.lince2      
            brtlt.lince3          = brstat.tlt.lince3      
            brtlt.comp_sck        = brstat.tlt.comp_sck    
            brtlt.eng_no          = brstat.tlt.eng_no      
            brtlt.nor_effdat      = brstat.tlt.nor_effdat  
            brtlt.comp_effdat     = brstat.tlt.comp_effdat 
            brtlt.comp_coamt      = brstat.tlt.comp_coamt  
            brtlt.comp_grprm      = brstat.tlt.comp_grprm  
            brtlt.sentcnt         = brstat.tlt.sentcnt .   
            /*End Jiraphon A59-0342*/

    END.              

    OPEN QUERY br_tlt FOR EACH brtlt.
            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok c-wins
ON CHOOSE OF bu_reok IN FRAME fr_main /* OK */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_filename.
        Return no-apply.
    END.
    ELSE RUN proc_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch c-wins
ON CHOOSE OF bu_sch IN FRAME fr_main /* Search */
DO:
    FOR EACH brtlt :
        DELETE brtlt.
    END.

    IF  cb_search =  "�Ţ��������"  THEN DO: 
        /*--Comment A59-0342--
        FOR EACH brstat.tlt USE-INDEX tlt01 WHERE
                 brstat.tlt.trndat       >= fi_trndatfr AND
                 brstat.tlt.trndat       <= fi_trndatto AND
                 brstat.tlt.genusr        = "AYCAL72"   AND 
                 brstat.tlt.nor_noti_tlt  = TRIM(fi_search)
        NO-LOCK:
        --End Comment A59-0342--*/
        FIND LAST brstat.tlt WHERE
                 brstat.tlt.genusr        = "AYCAL72"   AND 
                 brstat.tlt.nor_noti_tlt  = TRIM(fi_search) NO-LOCK NO-ERROR .
        IF AVAIL brstat.tlt THEN DO:
          /*Add by Jiraporn A59-0342*/
          FOR EACH brstat.tlt WHERE
                   brstat.tlt.genusr        = "AYCAL72"   AND 
                   brstat.tlt.nor_noti_tlt  = TRIM(fi_search) NO-LOCK:
          /*End Add by Jiraporn A59-0342*/
              ASSIGN nv_rectlt =  RECID(brstat.tlt).
          
              CREATE brtlt.
              ASSIGN
                  brtlt.releas       = tlt.releas      
                  brtlt.trndat       = tlt.trndat      
                  brtlt.entdat       = tlt.entdat      
                  brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                  brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                  brtlt.cha_no       = tlt.cha_no      
                  brtlt.safe2        = tlt.safe2       
                  brtlt.filler2      = tlt.filler2     
                  brtlt.endno        = tlt.endno
              /*Add Jiraporn A59-0342*/
                  brtlt.lotno         = tlt.lotno         
                  brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                  brtlt.colorcod      = tlt.colorcod      
                  brtlt.subins        = tlt.subins        
                  brtlt.ins_name      = tlt.ins_name      
                  brtlt.recac         = tlt.recac         
                  brtlt.ins_addr1     = tlt.ins_addr1
                  /*Add Jiraphon A59-0451*/
                  brtlt.ins_addr2     = tlt.ins_addr2
                  brtlt.ins_addr3     = tlt.ins_addr3
                  brtlt.ins_addr4     = tlt.ins_addr4
                  brtlt.ins_addr5     = tlt.ins_addr5
                  /*End Jiraphon A59-0451*/
                  brtlt.comp_sub      = tlt.comp_sub      
                  brtlt.brand         = tlt.brand         
                  brtlt.model         = tlt.model         
                  brtlt.cc_weight     = tlt.cc_weight                      
                  brtlt.lince1        = tlt.lince1    
                  brtlt.lince2        = tlt.lince2
                  brtlt.lince3        = tlt.lince3  
                  brtlt.comp_sck      = tlt.comp_sck
                  brtlt.eng_no        = tlt.eng_no  
                  brtlt.nor_effdat    = tlt.nor_effdat    
                  brtlt.comp_effdat   = tlt.comp_effdat   
                  brtlt.comp_coamt    = tlt.comp_coamt    
                  brtlt.comp_grprm    = tlt.comp_grprm .   
                  /*brtlt.sentcnt     = tlt.sentcnt       */
              /*End Jiraporn A59-0342*/
          END.
        END.
        /*-- Comment A59-0069 --
        Open Query br_tlt                      
            For each brtlt Use-index  tlt01 Where
            brtlt.trndat      >=  fi_trndatfr     And
            brtlt.trndat      <=  fi_trndatto     And
            brtlt.genusr       =  "Aycal72"       And
            brtlt.nor_noti_tlt = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(brstat.tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.*/            
    END.
    ELSE IF  cb_search  = "�Ң�"   THEN DO:
        /*--Comment A59-0342--
        FOR EACH brstat.tlt USE-INDEX tlt01 WHERE
                 brstat.tlt.trndat   >= fi_trndatfr AND
                 brstat.tlt.trndat   <= fi_trndatto AND
                 brstat.tlt.genusr    = "AYCAL72"   AND
                 brstat.tlt.comp_usr_tlt  = TRIM(fi_search) NO-LOCK:
         --END Comment A59-0342--*/
        FIND LAST brstat.tlt WHERE  
                 brstat.tlt.genusr    = "AYCAL72"   AND
                 brstat.tlt.comp_usr_tlt  = TRIM(fi_search) NO-LOCK NO-ERROR .
        IF AVAIL brstat.tlt THEN DO:
            /*Add Jiraporn A59-0342*/
            FOR EACH brstat.tlt WHERE
                     brstat.tlt.genusr    = "AYCAL72"   AND
                     brstat.tlt.comp_usr_tlt  = TRIM(fi_search) NO-LOCK:
            /*End Add Jiraporn A59-0342*/
                ASSIGN nv_rectlt =  RECID(brstat.tlt).
            
                CREATE brtlt.
                ASSIGN
                    brtlt.releas       = tlt.releas      
                    brtlt.trndat       = tlt.trndat      
                    brtlt.entdat       = tlt.entdat      
                    brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                    brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                    brtlt.cha_no       = tlt.cha_no      
                    brtlt.safe2        = tlt.safe2       
                    brtlt.filler2      = tlt.filler2     
                    brtlt.endno        = tlt.endno
                    /*Add Jiraporn A59-0342*/
                    brtlt.lotno         = tlt.lotno         
                    brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                    brtlt.colorcod      = tlt.colorcod      
                    brtlt.subins        = tlt.subins        
                    brtlt.ins_name      = tlt.ins_name      
                    brtlt.recac         = tlt.recac         
                    brtlt.ins_addr1     = tlt.ins_addr1
                    /*Add Jiraphon A59-0451*/
                    brtlt.ins_addr2     = tlt.ins_addr2
                    brtlt.ins_addr3     = tlt.ins_addr3
                    brtlt.ins_addr4     = tlt.ins_addr4
                    brtlt.ins_addr5     = tlt.ins_addr5
                    /*End Jiraphon A59-0451*/
                    brtlt.comp_sub      = tlt.comp_sub      
                    brtlt.brand         = tlt.brand         
                    brtlt.model         = tlt.model         
                    brtlt.cc_weight     = tlt.cc_weight                     
                    brtlt.lince1        = tlt.lince1    
                    brtlt.lince2        = tlt.lince2
                    brtlt.lince3        = tlt.lince3  
                    brtlt.comp_sck      = tlt.comp_sck
                    brtlt.eng_no        = tlt.eng_no 
                    brtlt.nor_effdat    = tlt.nor_effdat   
                    brtlt.comp_effdat   = tlt.comp_effdat  
                    brtlt.comp_coamt    = tlt.comp_coamt   
                    brtlt.comp_grprm    = tlt.comp_grprm .  
                    /*brtlt.sentcnt       = tlt.sentcnt       */
                    /*End Jiraporn A59-0342*/
            END.
        END.
        /*--- Comment A59-0069 --
        Open Query br_tlt                      
            For each brtlt Use-index  tlt01 Where
            brtlt.trndat      >=  fi_trndatfr    And 
            brtlt.trndat      <=  fi_trndatto    And 
            brtlt.genusr       =  "Aycal72"      And 
            brtlt.comp_usr_tlt = trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(brtlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.  */
    END.
    ELSE IF  cb_search  = "�Ţʵ������" THEN DO: 
        FIND LAST brstat.tlt WHERE
                  brstat.tlt.genusr    = "AYCAL72"   AND
                  brstat.tlt.cha_no    = TRIM(fi_search) NO-LOCK NO-ERROR .
        IF AVAIL brstat.tlt THEN DO:
            /*Add by Jiraporn A59-0342*/
            FOR EACH brstat.tlt WHERE
                     brstat.tlt.genusr    = "AYCAL72"   AND
                     brstat.tlt.cha_no    = TRIM(fi_search) NO-LOCK:
            /*End Add by Jiraporn A59-0342*/
                ASSIGN nv_rectlt =  RECID(brstat.tlt).
            
                CREATE brtlt.
                ASSIGN
                    brtlt.releas       = tlt.releas      
                    brtlt.trndat       = tlt.trndat      
                    brtlt.entdat       = tlt.entdat      
                    brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                    brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                    brtlt.cha_no       = tlt.cha_no      
                    brtlt.safe2        = tlt.safe2       
                    brtlt.filler2      = tlt.filler2     
                    brtlt.endno        = tlt.endno
                    /*Add Jiraporn A59-0342*/
                    brtlt.lotno         = tlt.lotno         
                    brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                    brtlt.colorcod      = tlt.colorcod      
                    brtlt.subins        = tlt.subins        
                    brtlt.ins_name      = tlt.ins_name      
                    brtlt.recac         = tlt.recac         
                    brtlt.ins_addr1     = tlt.ins_addr1
                    /*Add Jiraphon A59-0451*/
                    brtlt.ins_addr2     = tlt.ins_addr2
                    brtlt.ins_addr3     = tlt.ins_addr3
                    brtlt.ins_addr4     = tlt.ins_addr4
                    brtlt.ins_addr5     = tlt.ins_addr5
                    /*End Jiraphon A59-0451*/
                    brtlt.comp_sub      = tlt.comp_sub      
                    brtlt.brand         = tlt.brand         
                    brtlt.model         = tlt.model         
                    brtlt.cc_weight     = tlt.cc_weight                      
                    brtlt.lince1        = tlt.lince1    
                    brtlt.lince2        = tlt.lince2
                    brtlt.lince3        = tlt.lince3
                    brtlt.comp_sck      = tlt.comp_sck
                    brtlt.eng_no        = tlt.eng_no  
                    brtlt.nor_effdat    = tlt.nor_effdat    
                    brtlt.comp_effdat   = tlt.comp_effdat   
                    brtlt.comp_coamt    = tlt.comp_coamt    
                    brtlt.comp_grprm    = tlt.comp_grprm .   
                    /*brtlt.sentcnt     = tlt.sentcnt       */
                    /*End Jiraporn A59-0342*/
            END.
        END.
    END. 
    /*Add by Jiraporn A59-0342*/
    ELSE IF  cb_search  =  "Release No"  THEN DO: 
        FIND LAST brstat.tlt WHERE
                 brstat.tlt.genusr    = "AYCAL72"   AND
                 brstat.tlt.releas    = "NO"   NO-LOCK NO-ERROR .
        IF AVAIL brstat.tlt THEN DO:
            FOR EACH brstat.tlt WHERE
                     brstat.tlt.genusr    = "AYCAL72"   AND
                     brstat.tlt.releas    = "NO"   NO-LOCK:
                ASSIGN nv_rectlt =  RECID(brstat.tlt).
                CREATE brtlt.
                ASSIGN
                    brtlt.releas       = tlt.releas      
                    brtlt.trndat       = tlt.trndat      
                    brtlt.entdat       = tlt.entdat      
                    brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                    brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                    brtlt.cha_no       = tlt.cha_no      
                    brtlt.safe2        = tlt.safe2       
                    brtlt.filler2      = tlt.filler2     
                    brtlt.endno        = tlt.endno
                    /*Add Jiraporn A59-0342*/
                    brtlt.lotno         = tlt.lotno         
                    brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                    brtlt.colorcod      = tlt.colorcod      
                    brtlt.subins        = tlt.subins        
                    brtlt.ins_name      = tlt.ins_name      
                    brtlt.recac         = tlt.recac         
                    brtlt.ins_addr1     = tlt.ins_addr1
                    /*Add Jiraphon A59-0451*/
                    brtlt.ins_addr2     = tlt.ins_addr2
                    brtlt.ins_addr3     = tlt.ins_addr3
                    brtlt.ins_addr4     = tlt.ins_addr4
                    brtlt.ins_addr5     = tlt.ins_addr5
                    /*End Jiraphon A59-0451*/
                    brtlt.comp_sub      = tlt.comp_sub      
                    brtlt.brand         = tlt.brand         
                    brtlt.model         = tlt.model         
                    brtlt.cc_weight     = tlt.cc_weight                    
                    brtlt.lince1        = tlt.lince1    
                    brtlt.lince2        = tlt.lince2
                    brtlt.lince3        = tlt.lince3  
                    brtlt.comp_sck      = tlt.comp_sck
                    brtlt.eng_no        = tlt.eng_no 
                    brtlt.nor_effdat    = tlt.nor_effdat    
                    brtlt.comp_effdat   = tlt.comp_effdat   
                    brtlt.comp_coamt    = tlt.comp_coamt    
                    brtlt.comp_grprm    = tlt.comp_grprm.    
                    /*brtlt.sentcnt     = tlt.sentcnt       */   
            END.
        END.
    END.
    /*End Jiraporn A59-0342*/
    ELSE IF  cb_search  =  "Release Yes" THEN DO:  
        FIND LAST brstat.tlt WHERE
                 brstat.tlt.genusr    = "AYCAL72"   AND
                 brstat.tlt.releas    = "Yes"       NO-LOCK NO-ERROR .
        IF AVAIL brstat.tlt THEN DO:
            /*Add by Jiraporn A59-0342*/
            FOR EACH brstat.tlt WHERE
                     brstat.tlt.genusr    = "AYCAL72"   AND
                     brstat.tlt.releas    = "Yes"       NO-LOCK:
            /*End Add by Jiraporn A59-0342*/
                ASSIGN nv_rectlt =  RECID(brstat.tlt).
            
                CREATE brtlt.
                ASSIGN
                    brtlt.releas       = tlt.releas      
                    brtlt.trndat       = tlt.trndat      
                    brtlt.entdat       = tlt.entdat      
                    brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                    brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                    brtlt.cha_no       = tlt.cha_no      
                    brtlt.safe2        = tlt.safe2       
                    brtlt.filler2      = tlt.filler2     
                    brtlt.endno        = tlt.endno
                    /*Add Jiraporn A59-0342*/
                    brtlt.lotno         = tlt.lotno         
                    brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                    brtlt.colorcod      = tlt.colorcod      
                    brtlt.subins        = tlt.subins        
                    brtlt.ins_name      = tlt.ins_name      
                    brtlt.recac         = tlt.recac         
                    brtlt.ins_addr1     = tlt.ins_addr1
                    /*Add Jiraphon A59-0451*/
                    brtlt.ins_addr2     = tlt.ins_addr2
                    brtlt.ins_addr3     = tlt.ins_addr3
                    brtlt.ins_addr4     = tlt.ins_addr4
                    brtlt.ins_addr5     = tlt.ins_addr5
                    /*End Jiraphon A59-0451*/
                    brtlt.comp_sub      = tlt.comp_sub      
                    brtlt.brand         = tlt.brand         
                    brtlt.model         = tlt.model         
                    brtlt.cc_weight     = tlt.cc_weight                      
                    brtlt.lince1        = tlt.lince1    
                    brtlt.lince2        = tlt.lince2
                    brtlt.lince3        = tlt.lince3  
                    brtlt.comp_sck      = tlt.comp_sck
                    brtlt.eng_no        = tlt.eng_no 
                    brtlt.nor_effdat    = tlt.nor_effdat    
                    brtlt.comp_effdat   = tlt.comp_effdat   
                    brtlt.comp_coamt    = tlt.comp_coamt    
                    brtlt.comp_grprm    = tlt.comp_grprm .   
                    /*brtlt.sentcnt     = tlt.sentcnt       */
                /*End Jiraporn A59-0342*/
            END.
        END.
    END.
    /*Add Jiraporn A59-0342*/
    ELSE IF  cb_search  =  "�����١���"  THEN DO:
        FIND LAST  brstat.tlt WHERE
                 brstat.tlt.genusr    = "AYCAL72"   AND
                 INDEX(brstat.tlt.ins_name,TRIM(fi_search))  <> 0 NO-LOCK NO-ERROR.
        IF AVAIL brstat.tlt THEN DO:
          FOR EACH brstat.tlt WHERE
                   brstat.tlt.genusr    = "AYCAL72"   AND
                   INDEX(brstat.tlt.ins_name,TRIM(fi_search))  <> 0 NO-LOCK:
          
              ASSIGN nv_rectlt =  RECID(brstat.tlt).
         
              CREATE brtlt.
              ASSIGN
                  brtlt.releas       = tlt.releas      
                  brtlt.trndat       = tlt.trndat      
                  brtlt.entdat       = tlt.entdat      
                  brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                  brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                  brtlt.cha_no       = tlt.cha_no      
                  brtlt.safe2        = tlt.safe2       
                  brtlt.filler2      = tlt.filler2     
                  brtlt.endno        = tlt.endno
                  brtlt.lotno         = tlt.lotno         
                  brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                  brtlt.colorcod      = tlt.colorcod      
                  brtlt.subins        = tlt.subins        
                  brtlt.ins_name      = tlt.ins_name      
                  brtlt.recac         = tlt.recac         
                  brtlt.ins_addr1     = tlt.ins_addr1
                  /*Add Jiraphon A59-0451*/
                  brtlt.ins_addr2     = tlt.ins_addr2
                  brtlt.ins_addr3     = tlt.ins_addr3
                  brtlt.ins_addr4     = tlt.ins_addr4
                  brtlt.ins_addr5     = tlt.ins_addr5
                  /*End Jiraphon A59-0451*/
                  brtlt.comp_sub      = tlt.comp_sub      
                  brtlt.brand         = tlt.brand         
                  brtlt.model         = tlt.model         
                  brtlt.cc_weight     = tlt.cc_weight                      
                  brtlt.lince1        = tlt.lince1    
                  brtlt.lince2        = tlt.lince2
                  brtlt.lince3        = tlt.lince3  
                  brtlt.comp_sck      = tlt.comp_sck
                  brtlt.eng_no        = tlt.eng_no 
                  brtlt.nor_effdat    = tlt.nor_effdat    
                  brtlt.comp_effdat   = tlt.comp_effdat   
                  brtlt.comp_coamt    = tlt.comp_coamt    
                  brtlt.comp_grprm    = tlt.comp_grprm .   
                  /*brtlt.sentcnt     = tlt.sentcnt       */ 
          END.  
        END.
    END.
    RUN proc_SEARCH1.
    /*End Add Jiraporn A59-0342*/

    OPEN QUERY br_tlt FOR EACH brtlt.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  
  
    /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat2 = INPUT cb_report.

    IF n_asdat2 = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
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
    n_asdat2 =  (INPUT cb_report).
    IF      cb_report = "�Ң�"               THEN DO:  
        ASSIGN fi_report = "�Ң�"  .  
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.
    ELSE DO:
        ASSIGN fi_report = ""
               fi_reportdata = "" .   
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_filename .
        RETURN NO-APPLY.
    END.  
    IF n_asdat2 = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
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
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
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
    cb_search = INPUT cb_search.
    n_asdat =  (INPUT cb_search).
    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-wins
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    DISP fi_agent WITH FRAME fr_main.
    /* Add by : A64-0060 */
    IF fi_agent <> ""  THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            xmm600.acno = TRIM(fi_agent) NO-LOCK NO-ERROR .
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN fi_desag = "" .
            MESSAGE "Not Found Agent code on XMM600." VIEW-AS ALERT-BOX.
            APPLY "Entry"  TO fi_agent.
            RETURN NO-APPLY.
        END.
        ELSE DO: 
            ASSIGN fi_desag = xmm600.firstname + " " + xmm600.Lastname .
            IF fi_desag = ""  THEN fi_desag = xmm600.NAME.
        END.
    END.
    DISP fi_agent   fi_desag  WITH FRAME fr_main.
    /* end : A64-0060 */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-wins
ON VALUE-CHANGED OF fi_agent IN FRAME fr_main
DO:
    ASSIGN fi_agent = INPUT fi_agent .
    
    IF fi_agent <> ""  THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            xmm600.acno = TRIM(fi_agent) NO-LOCK NO-ERROR .
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN fi_desag = "" .
            MESSAGE "Not Found Agent code on XMM600." VIEW-AS ALERT-BOX.
            APPLY "Entry"  TO fi_agent.
            RETURN NO-APPLY.
        END.
        ELSE DO: 
            ASSIGN fi_desag = xmm600.firstname + " " + xmm600.Lastname .
            IF fi_desag = ""  THEN fi_desag = xmm600.NAME.
        END.
    END.
    DISP fi_agent   fi_desag  WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datadelform
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datadelform c-wins
ON LEAVE OF fi_datadelform IN FRAME fr_main
DO:
    fi_datadelform  =  Input  fi_datadelform.
    Disp fi_datadelform  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datadelto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datadelto c-wins
ON LEAVE OF fi_datadelto IN FRAME fr_main
DO:
    fi_datadelto =  Input  fi_datadelto  .
    Disp  fi_datadelto  with frame fr_main.
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


&Scoped-define SELF-NAME fi_filename2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename2 c-wins
ON LEAVE OF fi_filename2 IN FRAME fr_main
DO:
    fi_filename2 = INPUT fi_filename2.
    DISP fi_filename2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_inputfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_inputfile c-wins
ON LEAVE OF fi_inputfile IN FRAME fr_main
DO:
    fi_inputfile  =  Input  fi_inputfile .
    Disp  fi_inputfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddate c-wins
ON LEAVE OF fi_loaddate IN FRAME fr_main
DO:
    fi_loaddate  =  Input  fi_loaddate.
    Disp fi_loaddate  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile c-wins
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
    fi_outfile = INPUT fi_outfile.
    DISP fi_outfile  WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-wins
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    /*ASSIGN fi_producer = "A0M0019".*/ /*A64-0060*/
    fi_producer = INPUT fi_producer.
    DISP fi_producer WITH FRAME fr_main.
    /* Add by : A64-0060 */
    IF fi_producer <> ""  THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            xmm600.acno = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN fi_despd = "" .
            MESSAGE "Not Found Producer code on XMM600." VIEW-AS ALERT-BOX.
            APPLY "Entry"  TO fi_Producer.
            RETURN NO-APPLY.
        END.
        ELSE DO:
             ASSIGN fi_despd = xmm600.firstname + " " + xmm600.Lastname .
             IF fi_despd = ""  THEN fi_despd = xmm600.NAME.
        END.
    END.
    DISP fi_producer fi_despd  WITH FRAME fr_main.
    /* end: A64-0060 */
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-wins
ON VALUE-CHANGED OF fi_producer IN FRAME fr_main
DO:
    ASSIGN fi_producer = INPUT fi_producer .

    IF fi_producer <> ""  THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
            xmm600.acno = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN fi_despd = "" .
            MESSAGE "Not Found Producer code on XMM600." VIEW-AS ALERT-BOX.
            APPLY "Entry"  TO fi_Producer.
            RETURN NO-APPLY.
        END.
        ELSE DO: 
            ASSIGN fi_despd = xmm600.firstname + " " + xmm600.Lastname .
            IF fi_despd = ""  THEN fi_despd = xmm600.NAME.
        END.
    END.
    DISP fi_producer fi_despd  WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reportdata
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reportdata c-wins
ON LEAVE OF fi_reportdata IN FRAME fr_main
DO:
    fi_reportdata = trim( INPUT fi_reportdata ).
    Disp  fi_reportdata  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    fi_search = INPUT fi_search. /*Add by Jiraphon A59-0342*/
    /*
    fi_search     =  Input  fi_search .
    Disp fi_search  with frame fr_main.
    If  cb_search =  "�Ţ��������"  Then do:               
        Open Query br_tlt                      
            For each tlt Use-index  tlt01       Where
            tlt.trndat      >=  fi_trndatfr     And 
            tlt.trndat      <=  fi_trndatto     And 
            tlt.genusr       =  "Aycal72"       And 
            tlt.nor_noti_tlt =  trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE IF  cb_search  = "�Ң�"    THEN DO:
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat      >=  fi_trndatfr     And 
            tlt.trndat      <=  fi_trndatto     And 
            tlt.genusr       =  "Aycal72"       And 
            tlt.comp_usr_tlt = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.  
    END.
    ELSE If  cb_search  =  "�Ţʵ������"  Then do:        
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr     And 
            tlt.trndat   <=  fi_trndatto     And 
            tlt.genusr    =  "Aycal72"       And 
            tlt.cha_no    = trim(fi_search)  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "�Ţ��������"  Then do:         
        Open Query br_tlt                      
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr     And 
            tlt.trndat   <=  fi_trndatto     And 
            tlt.genusr    =  "Aycal72"       And 
            tlt.safe2     =  trim(fi_search) no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.      
                Return no-apply.               
    END. 
    ELSE If  cb_search  =  "Release Yes" Then do:         
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "Aycal72"   And
            tlt.releas          =  "Yes"       no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "Release No"  Then do:          
        Open Query br_tlt                      
            For each tlt Use-index  tlt01      Where
            tlt.trndat         >=  fi_trndatfr And
            tlt.trndat         <=  fi_trndatto And
            tlt.genusr          =  "Aycal72"   And
            tlt.releas          =  "No"        no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr c-wins
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
    fi_trndatfr  =  Input  fi_trndatfr.
    If  fi_trndatto  =  ?  Then  fi_trndatto  =  fi_trndatfr.
    ELSE fi_trndatto = INPUT fi_trndatfr. /*Add Jiraporn A59-0342*/
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


&Scoped-define SELF-NAME ra_bydelete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_bydelete c-wins
ON VALUE-CHANGED OF ra_bydelete IN FRAME fr_main
DO:
    ra_bydelete = INPUT ra_bydelete .
    DISP ra_bydelete WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_matchfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_matchfile c-wins
ON VALUE-CHANGED OF ra_matchfile IN FRAME fr_main
DO:
  ra_matchfile = INPUT ra_matchfile.
  /* add by : A64-0060*/
  IF ra_matchfile <> 1  THEN DO:
      DISABLE rs_type WITH FRAME fr_main.
      HIDE rs_type .
  END.
  ELSE DO:
      ENABLE rs_type WITH FRAME fr_main.
      DISP rs_type WITH FRAM fr_main. 
  END.
  /* end : A64-0060 */
  DISP ra_matchfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type c-wins
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type .
    DISP rs_type WITH FRAME fr_main.
  
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
    ASSIGN 
        gv_prgid = "wgwquay3" 
        gv_prog  = "Query & Update DATA Detail By AYCAL Compulsary".
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_loaddate = TODAY
        fi_trndatfr = TODAY
        fi_trndatto = TODAY
        vAcProc_fil = vAcProc_fil   + "�Ţ��������"     + "," 
                                    + "�Ң�"            + ","   
                                    + "�Ţʵ������"   + ","   
                                    /*+ "�Ţ��������" + "," */ /*Comment Jiraporn A59-0342*/
                                    + "�����١���"      + ","  /*Add Jiraporn A59-0342*/
                                    + "�Ţ��Ƕѧö"     + ","  /*Add Jiraporn A59-0342*/
                                    + "Release Cancel"  + ","  /*Add Jiraporn A59-0342*/
                                    + "Release Yes"     + "," 
                                    + "Release No"      + "," 
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil2 = vAcProc_fil2 + "�Ң�"            + ","
                                    + "Release Cancel"  + ","  /*Add Jiraporn A59-0342*/
                                    + "Release Yes"     + "," 
                                    + "Release No"      + ","
                                    + "All"             + ","
        cb_report:LIST-ITEMS = vAcProc_fil2
        cb_report = ENTRY(1,vAcProc_fil2)
        /*fi_producer = "A0M0019"*/  /*A64-0060*/
        fi_producer = "B3MLAY0102"  /*A64-0060*/
        /*fi_agent    = "B300303"*/ /*A61-0349*/
        /*fi_agent    = "B3W0100" /*A61-0349*/ A64-0060*/
        fi_agent    = "B3MLAY0100" /* A64-0060*/
        rs_type     = 1 /*A64-0060*/
        fi_report =  "�Ң�"   
        ra_bydelete = 1 
        ra_matchfile = 1.
     /* A64-0060 */
     IF fi_agent <> ""  THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
             xmm600.acno = TRIM(fi_agent) NO-LOCK NO-ERROR .
         IF NOT AVAIL sicsyac.xmm600 THEN DO:
             ASSIGN fi_desag = "Not found xmm600".
         END.
         ELSE DO: 
             ASSIGN fi_desag = xmm600.firstname + " " + xmm600.Lastname .
             IF fi_desag = ""  THEN fi_desag = xmm600.NAME.
         END.
         DISP fi_desag WITH FRAME fr_main.
     END.

     IF fi_producer <> ""  THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE 
             xmm600.acno = TRIM(fi_producer) NO-LOCK NO-ERROR .
         IF NOT AVAIL sicsyac.xmm600 THEN DO:
             ASSIGN fi_despd = "Not found xmm600".
         END.
         ELSE DO: 
             ASSIGN fi_despd = xmm600.firstname + " " + xmm600.Lastname .
             IF fi_despd = ""  THEN fi_despd = xmm600.NAME.
         END.

         DISP fi_despd  WITH FRAME fr_main.
     END.
    /* end : A64-0060*/
    RUN Open_tlt.
    DISP   ra_bydelete fi_loaddate cb_search cb_report fi_trndatfr  fi_trndatto   fi_report fi_producer fi_agent 
           rs_type /* A64-0060*/ with frame fr_main.
    /*********************************************************************/                    
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

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
  DISPLAY fi_despd rs_type ra_matchfile fi_loaddate fi_inputfile fi_trndatfr 
          fi_trndatto fi_search ra_bydelete fi_datadelform fi_datadelto 
          fi_filename2 fi_outfile fi_filename fi_process2 cb_report 
          fi_reportdata cb_search fi_report fi_producer fi_agent fi_desag 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE fi_despd rs_type ra_matchfile fi_loaddate fi_inputfile fi_trndatfr 
         fi_trndatto fi_search ra_bydelete fi_datadelform fi_datadelto 
         fi_filename2 fi_outfile fi_filename bu_reok bu_delete bu_sch bbu_reok2 
         cb_report fi_reportdata bu_exit bu_file bu_imp bu_ok cb_search 
         fi_report bu_file-2 bu_delete-2 fi_producer fi_agent fi_desag RECT-332 
         br_tlt RECT-343 RECT-494 RECT-495 RECT-496 RECT-497 RECT-498 RECT-499 
         RECT-500 RECT-347 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE export_cancel c-wins 
PROCEDURE export_cancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
    fi_outfile  =  Trim(fi_outfile) + "_mat.csv"  .
ASSIGN nv_cnt  =  0
       nv_row  =  1.

OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|"
        "SEQ"
        "�ѹ��� "         
        "�Ң�  "          
        "�Ţ�������� "    
        "STICKERNO"       
        "�Ţ�����"          
        "Insurance code"  
        "Contract No."    
        "Branch Code."    
        "Branch No."      
        "�����١���"      
        "�Ţ�ѵû�Шӵ�ǻ�ЪҪ� "
        "�������"
        "�������2"
        "�������3"
        "�������4"
        "�������5"
        "Class "             
        "������ö "          
        "���ö"             
        "��.��. "            
        "Registration"       
        "�ѧ��Ѵ "           
        "�Ţ����¹ö"       
        "�Ţ��Ƕѧö  "      
        "�Ţ����ͧ¹��"     
        "�ѹ��������ͧ"     
        "�ѹ�������ش������ͧ"
        "Net.Prem  "           
        "Gross Prem"           
        "�����˵�"             
        "status".               

    

OUTPUT TO VALUE(fi_outfile).
FOR EACH wdetail.
    nv_countdata     = nv_countdata  + 1 .
    EXPORT DELIMITER "|"
        wdetail.SEQ
        wdetail.notifydate      /*    �ѹ���          */              
        wdetail.branch          /*    �Ң�            */  
        wdetail.policy          /*    �Ţ��������     */      
        wdetail.STICKERNO       /*    STICKERNO       */      
        wdetail.docno           /*    �Ţ�����      */       
        wdetail.checkpolicy     /*    check policy    */          
        wdetail.INSURANCECODE   /*    Insurance code  */              
        wdetail.CONTRACTNO      /*    Contract No.    */          
        wdetail.BRANCHCODE      /*    Branch Code.    */          
        wdetail.BRANCHNO        /*    Branch No.      */              
        wdetail.CUSTOMERNAME    /*    �����١���      */  
        wdetail.CARDID          /*    �Ţ�ѵû�Шӵ�ǻ�ЪҪ� */      
        wdetail.ADDRESS         /*    �������         */ 
        wdetail.ADDRESS2         /*    �������2         */ 
        wdetail.ADDRESS3         /*    �������3         */ 
        wdetail.ADDRESS4         /*    �������4         */ 
        wdetail.ADDRESS5         /*    �������5         */ 
        wdetail.CARNO           /*    Class           */          
        wdetail.BRAND           /*    ������ö        */      
        wdetail.MODEL           /*    ���ö          */          
        wdetail.CC              /*    ��.��.          */      
        wdetail.REGISTRATION    /*    Registration    */      
        wdetail.PROVINCE        /*    �ѧ��Ѵ         */
        wdetail.Regis           /*    �Ţ����¹ö    */
        wdetail.BODY            /*    �Ţ��Ƕѧö     */
        wdetail.ENGINE          /*    �Ţ����ͧ¹��  */
        wdetail.STARTDATE       /*    �ѹ��������ͧ  */
        wdetail.ENDDATE         /*    �ѹ�������ش������ͧ*/
        wdetail.NETINCOME       /*    Net.Prem        */
        wdetail.TOTALINCOME     /*    Gross Prem      */
        wdetail.remark          /*    �����˵�        */      
        wdetail.nstatus .       /*    status          */ 
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_filecancel c-wins 
PROCEDURE Import_filecancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.

ASSIGN
    nv_countnotcomp  = 0.
    nv_countcomplete = 0.
    nv_countdata     = 0  .
    
INPUT FROM VALUE(fi_filename2).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"  
        wdetail.SEQ
        wdetail.notifydate
        wdetail.branch          /*    �Ң�            */  
        wdetail.policy          /*    �Ţ��������     */      
        wdetail.STICKERNO       /*    STICKERNO       */      
        wdetail.docno           /*    �Ţ�����      */       
        wdetail.checkpolicy     /*    check policy    */          
        wdetail.INSURANCECODE   /*    Insurance code  */              
        wdetail.CONTRACTNO      /*    Contract No.    */          
        wdetail.BRANCHCODE      /*    Branch Code.    */          
        wdetail.BRANCHNO        /*    Branch No.      */              
        wdetail.CUSTOMERNAME    /*    �����١���      */  
        wdetail.CARDID          /*    �Ţ�ѵû�Шӵ�ǻ�ЪҪ� */      
        wdetail.ADDRESS         /*    �������         */ 
        /*Add Jiraphon A59-0451*/
        wdetail.ADDRESS2         /*    �������2         */ 
        wdetail.ADDRESS3         /*    �������3         */ 
        wdetail.ADDRESS4         /*    �������4         */ 
        wdetail.ADDRESS5         /*    �������5         */ 
        /*End Jiraphon A59-0451*/
        wdetail.CARNO           /*    Class           */          
        wdetail.BRAND           /*    ������ö        */      
        wdetail.MODEL           /*    ���ö          */          
        wdetail.CC              /*    ��.��.          */      
        wdetail.REGISTRATION    /*    Registration    */      
        wdetail.PROVINCE        /*    �ѧ��Ѵ         */
        wdetail.Regis    /*    �Ţ����¹ö    */
        wdetail.BODY            /*    �Ţ��Ƕѧö     */
        wdetail.ENGINE          /*    �Ţ����ͧ¹��  */
        wdetail.STARTDATE       /*    �ѹ��������ͧ  */
        wdetail.ENDDATE         /*    �ѹ�������ش������ͧ*/
        wdetail.NETINCOME       /*    Net.Prem        */
        wdetail.TOTALINCOME     /*    Gross Prem      */
        wdetail.remark          /*    �����˵�        */      
        wdetail.nstatus .       /*    status          */  
END.


FOR EACH wdetail.
    IF INDEX(wdetail.SEQ,"SEQ") <> 0    THEN DELETE wdetail.
    ELSE IF wdetail.SEQ         =  ""   THEN DELETE wdetail.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification1 c-wins 
PROCEDURE Import_notification1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bftlt FOR brstat.tlt. /*A64-0060*/

FOR EACH  wdetail :
    DELETE  wdetail.
END.

INPUT FROM VALUE(fi_inputfile).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.notifydate   /*  1  �ѹ���         */                                  
        wdetail.branch       /*  2  �Ң�           */                          
        wdetail.policy       /*  3  �Ţ��������    */                                  
        wdetail.stk          /*  4  �Ţʵ������  */                                  
        wdetail.docno        /*  5  �Ţ��������  */                   
        wdetail.remark    .  /*  6  �����˵�       */
END.

ASSIGN nv_countdata     = 0
       nv_countnotcomp  = 0 
       nv_countcomplete = 0.

FOR EACH wdetail:
    IF INDEX(wdetail.notifydate,"�ѹ���") <> 0 THEN DELETE wdetail.
    ELSE IF TRIM(wdetail.notifydate)   = " "   THEN DELETE wdetail.
    ELSE DO:
        ASSIGN  nv_countdata = nv_countdata  + 1
                wdetail.stk  = trim(STRING(DECI(TRIM(wdetail.stk)))) . /*A64-0060*/
        /*FIND LAST brstat.tlt WHERE brstat.tlt.cha_no = TRIM(wdetail.stk) AND */ /*A64-0060*/
        FIND LAST brstat.tlt WHERE INDEX(brstat.tlt.cha_no,wdetail.stk) <> 0 AND  /*A64-0060*/
                                   brstat.tlt.genusr = "AYCAL72"           NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.tlt THEN DO:
            nv_countcomplete = nv_countcomplete + 1.
            CREATE brstat.tlt.
            ASSIGN
                brstat.tlt.trndat        = fi_loaddate
                brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")
                brstat.tlt.trntime       = STRING(TIME,"HH:MM:SS")
                brstat.tlt.entdat        = DATE(wdetail.notifydate)
                brstat.tlt.genusr        = "AYCAL72"
                brstat.tlt.nor_noti_tlt  = TRIM(wdetail.policy)
                brstat.tlt.cha_no        = STRING(DECI(TRIM(wdetail.stk)))
                brstat.tlt.comp_usr_tlt  = TRIM(wdetail.branch)
                brstat.tlt.safe2         = TRIM(wdetail.docno)
                brstat.tlt.filler2       = TRIM(wdetail.remark)
                brstat.tlt.endno         = USERID(LDBNAME(1))
                brstat.tlt.imp           = "IM"
                brstat.tlt.releas        = "NO"
                /*Add Jiraphon A59-0342*/
                brstat.tlt.lotno         = TRIM(wdetail.INSURANCECODE)
                brstat.tlt.comp_noti_tlt = TRIM(wdetail.CONTRACTNO)
                brstat.tlt.colorcod      = TRIM(wdetail.BRANCHCODE)
                brstat.tlt.subins        = TRIM(wdetail.BRANCHNO)
                brstat.tlt.ins_name      = TRIM(wdetail.CUSTOMERNAME)
                brstat.tlt.recac         = TRIM(wdetail.CARDID)
                brstat.tlt.ins_addr1     = TRIM(wdetail.ADDRESS)
                brstat.tlt.comp_sub      = TRIM(wdetail.CARNO)
                brstat.tlt.brand         = TRIM(wdetail.BRAND)
                brstat.tlt.model         = TRIM(wdetail.MODEL)
                brstat.tlt.cc_weight     = INTE(TRIM(wdetail.CC))
                brstat.tlt.lince1        = TRIM(wdetail.REGISTRATION)
                brstat.tlt.lince2        = TRIM(wdetail.PROVINCE) 
                brstat.tlt.comp_sck      = TRIM(wdetail.BODY)      
                brstat.tlt.eng_no        = TRIM(wdetail.ENGINE)  
                brstat.tlt.nor_effdat    = DATE(TRIM(wdetail.startdate))      
                brstat.tlt.comp_effdat   = DATE(TRIM(wdetail.enddate))  
                brstat.tlt.comp_coamt    = DECI(TRIM(wdetail.NETINCOME))         
                brstat.tlt.comp_grprm    = DECI(TRIM(wdetail.TOTALINCOME)). 
                wdetail.remark = wdetail.remark + "Add Sticker AYCAL72 " .
                /*End Jiraphon A59-0342*/
            /* Add by : Ranu I. A64-0060 */
            IF wdetail.stk <> "" AND SUBSTR(wdetail.stk,1,1) <> "0"  THEN ASSIGN wdetail.stk = "0" + TRIM(wdetail.stk) .
            FIND FIRST bftlt USE-INDEX tlt06   WHERE  INDEX(bftlt.cha_no,wdetail.stk) <> 0 AND 
                       bftlt.genusr   <> "AYCAL72" NO-ERROR NO-WAIT .
            IF NOT AVAIL bftlt THEN DO: 
                CREATE bftlt.
                ASSIGN
                    bftlt.entdat         = TODAY
                    bftlt.enttim         = STRING(TIME,"HH:MM:SS")
                    bftlt.trntime        = STRING(TIME,"HH:MM:SS")
                    bftlt.trndat         = fi_loaddate
                    bftlt.genusr         = trim(fi_producer)      /* wdetail.Company   */ 
                    bftlt.nor_noti_tlt   = CAPS(trim(wdetail.policy))  /* 3  �Ţ��������    */  
                    bftlt.cha_no         = trim(wdetail.stk)     /* 4  �Ţʵ������  */                    
                    bftlt.safe2          = TRIM(wdetail.docno)   /* 5  �Ţ��������  */ 
                    bftlt.filler2        = trim(wdetail.remark)  /* 6  �����˵�       */ 
                    bftlt.endno          = USERID(LDBNAME(1))    /* User Load Data    */
                    bftlt.imp            = "IM"                  /* Import Data       */
                    bftlt.releas         = "No"  
                    bftlt.comp_usr_tlt   = TRIM(wdetail.branch) .
                wdetail.remark = wdetail.remark + "/Add Sticker BU3 Producer : " + bftlt.genusr.
            END.
            ELSE DO:
                wdetail.remark = wdetail.remark + "/Sticker BU3 �բ��������� Producer :" + bftlt.genusr. 
            END.
            /* end : A64-0060 */
            /*DELETE wdetail. */ /* A64-0060*/
        END.
        ELSE ASSIGN nv_countnotcomp = nv_countnotcomp + 1
                    wdetail.remark = wdetail.remark + "Have Sticker AYCAL72" . 

        /*--- Comment A59-0069 --
        FIND FIRST tlt WHERE 
            tlt.nor_noti_tlt   = TRIM(wdetail.policy) AND 
            tlt.cha_no         = TRIM(wdetail.stk)    AND 
            tlt.genusr         = "aycal72"            NO-ERROR NO-WAIT .
        IF NOT AVAIL tlt THEN DO: 
            ASSIGN nv_countcomplete = nv_countcomplete + 1.
            CREATE tlt.
            ASSIGN
                tlt.trndat         = fi_loaddate
                tlt.enttim         = STRING(TIME,"HH:MM:SS")
                tlt.trntime        = STRING(TIME,"HH:MM:SS")
                tlt.entdat         = DATE(wdetail.notifydate)         /*  TODAY             */
                tlt.genusr         = "aycal72"                        /*  wdetail.Company   */ 
                tlt.nor_noti_tlt   = TRIM(wdetail.policy)             /*  3  �Ţ��������    */  
                tlt.cha_no         = STRING(DECI(TRIM(wdetail.stk)))  /*  4  �Ţʵ������  */                           
                tlt.comp_usr_tlt   = TRIM(wdetail.branch)             /*  2  �Ң�           */  
                tlt.safe2          = TRIM(wdetail.docno)              /*  5  �Ţ��������  */ 
                tlt.filler2        = TRIM(wdetail.remark)             /*  6  �����˵�       */ 
                tlt.endno          = USERID(LDBNAME(1))               /*User Load Data */
                tlt.imp            = "IM"                             /*Import Data    */
                tlt.releas         = "No"   .
            DELETE wdetail.
        END.
        ELSE nv_countnotcomp = nv_countnotcomp + 1.   /* duplicate found*/
        --- End Comment A59-0069 --*/
    END.
END.
/* Add by : Ranu I. A64-0060 */
OUTPUT TO VALUE(nv_outfile).
EXPORT DELIMITER "|"
        "�ѹ��� "        
        "�Ң�   "         
        "�Ţ��������"     
        "�Ţʵ������ "  
        "�Ţ��������  " 
        "�����˵�" SKIP  .
FOR EACH wdetail .
    EXPORT DELIMITER "|" 
         wdetail.notifydate
         wdetail.branch    
         wdetail.policy    
         wdetail.stk       
         wdetail.docno     
         wdetail.remark  .
    DELETE wdetail.
END.
OUTPUT CLOSE .
nv_outfile = "" .
/* end : A64-0060 */
RUN Open_tlt.

MESSAGE "Load  Data Complete " SKIP
    "�ӹǹ�����ŷ�����:    "  nv_countdata      SKIP
    "�ӹǹ�����ŷ������:  "  nv_countcomplete  SKIP
    "�ӹǹ�����ŷ���������ö�����:  "  nv_countnotcomp  VIEW-AS ALERT-BOX.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notificationkpi c-wins 
PROCEDURE Import_notificationkpi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.

INPUT FROM VALUE(fi_filename2).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.SEQ            /*  1  SEQ             */              
        wdetail.INSURANCECODE  /*  2  INSURANCECODE   */  
        wdetail.CONTRACTNO     /*  3  CONTRACTNO      */ 
        wdetail.BRANCHCODE     /*  4  BRANCHCODE      */  
        wdetail.BRANCHNO       /*  5  BRANCHNO        */      
        wdetail.STICKERNO      /*  6  STICKERNO       */      
        wdetail.CUSTOMERNAME   /*  7  CUSTOMERNAME    */      
        wdetail.ADDRESS        /*  8  ADDRESS         */           
        wdetail.CARNO          /*  9  CARNO           */              
        wdetail.BRAND          /*  10 BRAND           */          
        wdetail.MODEL          /*  11 MODEL           */          
        wdetail.CC             /*  12 CC              */              
        wdetail.REGISTRATION   /*  13 REGISTRATION    */  
        wdetail.PROVINCE       /*  14 PROVINCE        */      
        wdetail.BODY           /*  15 BODY            */          
        wdetail.ENGINE         /*  16 ENGINE          */          
        wdetail.STARTDATE      /*  17 STARTDATE       */      
        wdetail.ENDDATE        /*  18 ENDDATE         */          
        wdetail.NETINCOME      /*  19 NETINCOME       */      
        wdetail.TOTALINCOME    /*  20 TOTALINCOME     */      
        wdetail.CARDID   .     /*  21 CARDID          */
END.
FOR EACH wdetail.
    IF INDEX(wdetail.SEQ,"SEQ") <> 0    THEN DELETE wdetail.
    ELSE IF wdetail.SEQ         =  ""   THEN DELETE wdetail.
    /*ELSE RUN proc_cutpolicy.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notificationkpi2 c-wins 
PROCEDURE Import_notificationkpi2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.

INPUT FROM VALUE(fi_filename2).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.SEQ            /*  1   SEQ             */              
        wdetail.INSURANCECODE  /*  2   INSURANCECODE   */  
        wdetail.CONTRACTNO     /*  3   CONTRACTNO      */ 
        wdetail.campaign_CJ    /*  4  Campaign cj      */ /*A60-0542*/
        wdetail.BRANCHCODE     /*  5   BRANCHCODE      */  
        wdetail.BRANCHNO       /*  6   BRANCHNO        */      
        wdetail.STICKERNO      /*  7   STICKERNO       */      
        wdetail.CUSTOMERNAME   /*  8   CUSTOMERNAME    */      
        wdetail.ADDRESS        /*  9   ADDRESS         */           
        wdetail.CARNO          /*  10  CARNO           */              
        wdetail.BRAND          /*  11  BRAND           */          
        wdetail.MODEL          /*  12  MODEL           */          
        wdetail.CC             /*  13  CC              */              
        wdetail.REGISTRATION   /*  14  REGISTRATION    */  
        wdetail.PROVINCE       /*  15  PROVINCE        */      
        wdetail.BODY           /*  16  BODY            */          
        wdetail.ENGINE         /*  17  ENGINE          */          
        wdetail.STARTDATE      /*  18  STARTDATE       */      
        wdetail.ENDDATE        /*  19  ENDDATE         */          
        wdetail.NETINCOME      /*  20  NETINCOME       */      
        wdetail.TOTALINCOME    /*  21  TOTALINCOME     */      
        wdetail.CARDID   .     /*  22  CARDID          */
END.
FOR EACH wdetail.
    IF INDEX(wdetail.SEQ,"SEQ") <> 0    THEN DELETE wdetail.
    ELSE IF wdetail.SEQ         =  ""   THEN DELETE wdetail.
    /*ELSE RUN proc_cutpolicy.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt c-wins 
PROCEDURE Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- Comment A59-0069 --
Open Query br_tlt  For each tlt  NO-LOCK
     WHERE brtlt.trndat   =  fi_loaddate      and
           brtlt.USERID   =  "aycal72"  
    BY tlt.nor_noti_tlt  .
    ASSIGN nv_rectlt =  recid(tlt) .*/
    
FOR EACH brtlt:
    DELETE brtlt.
END.
    
FOR EACH brstat.tlt USE-INDEX tlt01 WHERE
         brstat.tlt.trndat   = fi_loaddate  AND
         brstat.tlt.genusr   = "AYCAL72"    NO-LOCK
BREAK BY brstat.tlt.nor_noti_tlt:

    ASSIGN nv_rectlt = RECID(brstat.tlt) .

    CREATE brtlt.
    ASSIGN
        brtlt.releas       = tlt.releas      
        brtlt.trndat       = tlt.trndat      
        brtlt.entdat       = tlt.entdat      
        brtlt.nor_noti_tlt = tlt.nor_noti_tlt
        brtlt.comp_usr_tlt = tlt.comp_usr_tlt
        brtlt.cha_no       = tlt.cha_no      
        brtlt.safe2        = tlt.safe2       
        brtlt.filler2      = tlt.filler2     
        brtlt.endno        = tlt.endno
    /*Add Jiraphon A59-0342*/
        brtlt.lotno           = tlt.lotno        
        brtlt.comp_noti_tlt   = tlt.comp_noti_tlt
        brtlt.colorcod        = tlt.colorcod     
        brtlt.subins          = tlt.subins       
        brtlt.ins_name        = tlt.ins_name     
        brtlt.recac           = tlt.recac        
        brtlt.ins_addr1       = tlt.ins_addr1 
        /*Add Jiraphon A59-0451*/
        brtlt.ins_addr2       = tlt.ins_addr2 
        brtlt.ins_addr3       = tlt.ins_addr3 
        brtlt.ins_addr4       = tlt.ins_addr4 
        brtlt.ins_addr5       = tlt.ins_addr5
        /*End Jiraphon A59-0451*/
        brtlt.comp_sub        = tlt.comp_sub     
        brtlt.brand           = tlt.brand        
        brtlt.model           = tlt.model        
        brtlt.cc_weight       = tlt.cc_weight    
        brtlt.lince1          = tlt.lince1       
        brtlt.lince2          = tlt.lince2       
        brtlt.lince3          = tlt.lince3       
        brtlt.comp_sck        = tlt.comp_sck     
        brtlt.eng_no          = tlt.eng_no       
        brtlt.nor_effdat      = tlt.nor_effdat   
        brtlt.comp_effdat     = tlt.comp_effdat  
        brtlt.comp_coamt      = tlt.comp_coamt   
        brtlt.comp_grprm      = tlt.comp_grprm   
        brtlt.sentcnt         = tlt.sentcnt .
        /*End Jiraphon A59-0342*/
END.

OPEN QUERY br_tlt FOR EACH brtlt.    
    
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Open_tlt2 c-wins 
PROCEDURE Open_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-- Comment A59-0069 --
Open Query br_tlt  For each tlt  NO-LOCK
    WHERE tlt.trndat >= fi_trndatfr   And
    tlt.trndat       <= fi_trndatto   And
    tlt.genusr        = "aycal72" 
    BY tlt.nor_noti_tlt  .
    ASSIGN nv_rectlt =  recid(tlt) .*/
    
FOR EACH brtlt:
    DELETE brtlt.
END.
    
FOR EACH brstat.tlt USE-INDEX tlt01 WHERE
         brstat.tlt.trndat   >= fi_trndatfr AND
         brstat.tlt.trndat   <= fi_trndatto AND
         brstat.tlt.genusr    = "AYCAL72"   NO-LOCK
BREAK BY brstat.tlt.nor_noti_tlt:

    ASSIGN nv_rectlt = RECID(brstat.tlt) .

    CREATE brtlt.
    ASSIGN
        brtlt.releas       = tlt.releas      
        brtlt.trndat       = tlt.trndat      
        brtlt.entdat       = tlt.entdat      
        brtlt.nor_noti_tlt = tlt.nor_noti_tlt
        brtlt.comp_usr_tlt = tlt.comp_usr_tlt
        brtlt.cha_no       = tlt.cha_no      
        brtlt.safe2        = tlt.safe2       
        brtlt.filler2      = tlt.filler2     
        brtlt.endno        = tlt.endno
        /*Add Jiraphon A59-0342*/
        brtlt.lotno           = tlt.lotno        
        brtlt.comp_noti_tlt   = tlt.comp_noti_tlt
        brtlt.colorcod        = tlt.colorcod     
        brtlt.subins          = tlt.subins       
        brtlt.ins_name        = tlt.ins_name     
        brtlt.recac           = tlt.recac        
        brtlt.ins_addr1       = tlt.ins_addr1
        /*Add jiraphon A59-0451*/
        brtlt.ins_addr2       = tlt.ins_addr2
        brtlt.ins_addr3       = tlt.ins_addr3
        brtlt.ins_addr4       = tlt.ins_addr4
        brtlt.ins_addr5       = tlt.ins_addr5
        /*End Jiraphon A59-0451*/
        brtlt.comp_sub        = tlt.comp_sub     
        brtlt.brand           = tlt.brand        
        brtlt.model           = tlt.model        
        brtlt.cc_weight       = tlt.cc_weight    
        brtlt.lince1          = tlt.lince1       
        brtlt.lince2          = tlt.lince2       
        brtlt.lince3          = tlt.lince3       
        brtlt.comp_sck        = tlt.comp_sck     
        brtlt.eng_no          = tlt.eng_no       
        brtlt.nor_effdat      = tlt.nor_effdat   
        brtlt.comp_effdat     = tlt.comp_effdat  
        brtlt.comp_coamt      = tlt.comp_coamt   
        brtlt.comp_grprm      = tlt.comp_grprm   
        brtlt.sentcnt         = tlt.sentcnt 
        brtlt.EXP             = tlt.EXP.  /*A60-0542*/   
    /*End Jiraphon A59-0342*/
END.

OPEN QUERY br_tlt FOR EACH brtlt.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr c-wins 
PROCEDURE proc_addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by Ranu I. A60-0542 20/12/2017     
------------------------------------------------------------------------------*/
def var nv_no    as char format "x(20)" init "" . /*A64-0060*/
def var nv_road  as char format "x(20)" init "" . /*A64-0060*/
def var nv_soi   as char format "x(20)" init "" . /*A64-0060*/
def var nv_moo   as char format "x(20)" init "" . /*A64-0060*/
DO:
    IF TRIM(wdetail.province) <> ""  THEN DO:
           FIND FIRST brstat.insure USE-INDEX insure01 WHERE brstat.insure.comp = "999" AND /*A64-0060*/ 
               brstat.insure.FName = TRIM(wdetail.province)  NO-LOCK NO-ERROR.
           IF AVAIL brstat.insure THEN  
              ASSIGN wdetail.PROVINCE  = TRIM(brstat.insure.LName).
    END.

    IF wdetail.REGISTRATION  = "" THEN DO:
          ASSIGN wdetail.REGISTRATION = "/" + SUBSTR(wdetail.body,(LENGTH(wdetail.body) - 9) + 1,LENGTH(wdetail.body))
                 wdetail.province     = "" .   
    END.

    ASSIGN nv_address = wdetail.ADDRESS
        n_road = ""
        nv_tam  = ""
        nv_amp  = ""
        nv_prov = ""
        wdetail.ADDRESS  = ""
        wdetail.ADDRESS2 = ""
        wdetail.ADDRESS3 = ""
        wdetail.ADDRESS4 = ""
        wdetail.ADDRESS5 = "" .
       /*IF (r-INDEX(nv_address,"�.")) > (r-INDEX(nv_address,"�.")) THEN DO:*/
       IF r-INDEX(nv_address,"�.") <> 0 THEN DO: 
               n_road  = SUBSTR(nv_address,r-INDEX(nv_address,"�.")).
               wdetail.ADDRESS = SUBSTR(nv_address,1,r-INDEX(nv_address,"�.") - 1  ).
       END.
       ELSE IF r-INDEX(nv_address,"���") <> 0 THEN DO:
           ASSIGN 
               n_road  = SUBSTR(nv_address,r-INDEX(nv_address,"���")).
               wdetail.ADDRESS = SUBSTR(nv_address,1,r-INDEX(nv_address,"���") - 1  ).
       END.
       ELSE IF r-INDEX(nv_address,"�.") <> 0 THEN DO: 
               nv_tam  = SUBSTR(nv_address,r-INDEX(nv_address,"�.")).
               wdetail.ADDRESS = SUBSTR(nv_address,1,r-INDEX(nv_address,"�.") - 1  ).
       END.
       ELSE IF r-INDEX(nv_address,"�Ӻ�") <> 0 THEN DO: 
           ASSIGN 
               nv_tam  = SUBSTR(nv_address,r-INDEX(nv_address,"�Ӻ�"))
               wdetail.ADDRESS = SUBSTR(nv_address,1,r-INDEX(nv_address,"�Ӻ�") - 1).
       END.
       ELSE IF r-INDEX(nv_address,"�ǧ") <> 0 THEN DO: 
               nv_tam = SUBSTR(nv_address,r-INDEX(nv_address,"�ǧ")).
               wdetail.ADDRESS = SUBSTR(nv_address,1,r-INDEX(nv_address,"�ǧ") - 1  ).
       END. 

       IF r-INDEX(nv_address,"�.") <> 0 THEN DO: 
               nv_amp = SUBSTR(nv_address,R-INDEX(nv_address,"�.")).
               wdetail.ADDRESS2 = SUBSTR(nv_address,1,R-INDEX(nv_address,"�.") - 1 ).
       END.
       ELSE IF r-INDEX(nv_address,"�����") <> 0 THEN DO: 
           ASSIGN 
               nv_amp  = SUBSTR(nv_address,r-INDEX(nv_address,"�����")).
               wdetail.ADDRESS2 = SUBSTR(nv_address,1,r-INDEX(nv_address,"�����") - 1  ).
       END.
       ELSE IF r-INDEX(nv_address,"ࢵ") <> 0  THEN DO:
               nv_amp = SUBSTR(nv_address,r-INDEX(nv_address,"ࢵ")).
               wdetail.ADDRESS2 = SUBSTR(nv_address,1,r-INDEX(nv_address,"ࢵ") - 1 ).
       END.

       IF R-INDEX(n_road,"�.")   <> 0 THEN wdetail.ADDRESS2 = SUBSTR(n_road,1,INDEX(n_road, "�.") - 1).
       ELSE IF R-INDEX(n_road,"�����")<> 0 THEN wdetail.ADDRESS2 = SUBSTR(n_road,1,INDEX(n_road, "�����") - 1). /*A60-0542*/
       ELSE IF R-INDEX(n_road,"ࢵ")  <> 0 THEN wdetail.ADDRESS2 = SUBSTR(n_road,1,INDEX(n_road, "ࢵ") - 1).
       ELSE IF R-INDEX(nv_tam,"�.")   <> 0 THEN wdetail.ADDRESS2 = SUBSTR(nv_tam,1,INDEX(nv_tam, "�.") - 1).
       ELSE IF R-INDEX(nv_tam,"�����")<> 0 THEN wdetail.ADDRESS2 = SUBSTR(nv_tam,1,INDEX(nv_tam, "�����") - 1). /*A60-0542*/
       ELSE IF R-INDEX(nv_tam,"ࢵ")  <> 0 THEN wdetail.ADDRESS2 = SUBSTR(nv_tam,1,INDEX(nv_tam, "ࢵ") - 1).
       
       wdetail.ADDRESS3 = SUBSTR(nv_amp,1,INDEX(nv_amp, " ")).
       nv_prov = TRIM(SUBSTR(nv_address,INDEX(nv_address,wdetail.ADDRESS3) + LENGTH(wdetail.ADDRESS3),25)).
       wdetail.ADDRESS4 = TRIM(SUBSTR(nv_prov,1,R-INDEX(nv_prov," "))).
       wdetail.ADDRESS5 = TRIM(SUBSTR(nv_prov,R-INDEX(nv_prov," "))).
       /* add by : A64-0060 */
       IF INDEX(wdetail.ADDRESS,"����")   <> 0 THEN wdetail.ADDRESS  = trim(REPLACE(wdetail.ADDRESS,"����","�.")).         
       IF INDEX(wdetail.ADDRESS,"���")    <> 0 THEN wdetail.ADDRESS  = trim(REPLACE(wdetail.ADDRESS,"���","�.")).          
       IF INDEX(wdetail.ADDRESS,"���")    <> 0 THEN wdetail.ADDRESS  = trim(REPLACE(wdetail.ADDRESS,"���","�.")). 

       IF index(wdetail.ADDRESS,"�.") <> 0 THEN DO:
           ASSIGN nv_road = SUBSTR(wdetail.ADDRESS,r-INDEX(wdetail.ADDRESS,"�."))
                  wdetail.ADDRESS = SUBSTR(wdetail.ADDRESS,1,r-INDEX(wdetail.ADDRESS,"�.") - 1  ).
       END.
       IF index(wdetail.ADDRESS,"�.") <> 0 THEN DO:
           ASSIGN nv_soi = SUBSTR(wdetail.ADDRESS,r-INDEX(wdetail.ADDRESS,"�."))
                  wdetail.ADDRESS = SUBSTR(wdetail.ADDRESS,1,r-INDEX(wdetail.ADDRESS,"�.") - 1  ).
       END.
       IF index(wdetail.ADDRESS,"�.") <> 0 THEN DO:
           ASSIGN nv_moo = SUBSTR(wdetail.ADDRESS,r-INDEX(wdetail.ADDRESS,"�."))
                  wdetail.ADDRESS = SUBSTR(wdetail.ADDRESS,1,r-INDEX(wdetail.ADDRESS,"�.") - 1  ).
       END.

       IF trim(nv_moo)  =  "�."  THEN nv_moo = "" .
       ELSE IF index(nv_moo,"����") <> 0 THEN nv_moo = trim(replace(nv_moo,"����","�.")) .

       IF trim(nv_soi)  =  "�."  THEN nv_soi  = "" .
       ELSE IF index(nv_soi,"���")  <> 0 THEN nv_soi  = trim(replace(nv_soi,"���","�."))  .

       IF trim(nv_road) =  "�."  THEN nv_road = "" .
       ELSE IF index(nv_road,"���") <> 0 THEN nv_road  = trim(replace(nv_road,"���","�.")) .

       ASSIGN wdetail.ADDRESS = trim(wdetail.ADDRESS + " " + TRIM(nv_moo) + " " + TRIM(nv_soi) + " " + TRIM(nv_road)) .

       IF INDEX(wdetail.ADDRESS2,"�Ӻ�")  <> 0 THEN wdetail.ADDRESS2 = trim(REPLACE(wdetail.ADDRESS2,"�Ӻ�","�.")).        
       IF INDEX(wdetail.ADDRESS3,"�����") <> 0 THEN wdetail.ADDRESS3 = trim(REPLACE(wdetail.ADDRESS3,"�����","�.")).       
       IF INDEX(wdetail.address4,"�ѧ��Ѵ") <> 0 THEN  wdetail.address4 = trim(REPLACE(wdetail.address4,"�ѧ��Ѵ","�.")) . 
       IF INDEX(wdetail.address5,"�ѧ��Ѵ") <> 0 THEN  wdetail.address5 = trim(REPLACE(wdetail.address5,"�ѧ��Ѵ","�.")) .

       IF index(wdetail.address4,"�.") = 0 AND (index(wdetail.address4,"���") = 0 AND index(wdetail.address4,"��ا෾") = 0 )
       THEN ASSIGN wdetail.address4 = "�." + TRIM(wdetail.address4).
       /* end a64-0060*/
       
    /*   ASSIGN 
       wdetail.ADDRESS  = wdetail.ADDRESS
       wdetail.ADDRESS2 = wdetail.ADDRESS2
       wdetail.ADDRESS3 = wdetail.ADDRESS3
       wdetail.ADDRESS4 = wdetail.ADDRESS4
       wdetail.ADDRESS5 = wdetail.ADDRESS5.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutaddr c-wins 
PROCEDURE proc_cutaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    IF (R-INDEX(np_addr1,"���")  <> 0 ) THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"���") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"���") - 1 )).

    END.
    ELSE IF (R-INDEX(np_addr1,"��ا")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"��ا") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"��ا") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addr1,"�.")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"�.") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"�.") - 1 )).
    END.
    ELSE IF (R-INDEX(np_addr1,"�ѧ��Ѵ")  <> 0 )  THEN DO:
        ASSIGN np_addr4  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"�ѧ��Ѵ") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"�ѧ��Ѵ") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"ࢵ")  <> 0 )  THEN DO:
        ASSIGN np_addr3  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"ࢵ") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"ࢵ") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"�����")  <> 0 )  THEN DO:
        ASSIGN np_addr3  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"�����") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"�����") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"�ǧ")  <> 0 )  THEN DO:
        ASSIGN np_addr2  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"�ǧ") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"�ǧ") - 1 )).
    END.
    IF (R-INDEX(np_addr1,"�Ӻ�")  <> 0 )  THEN DO:
        ASSIGN np_addr2  =  trim(SUBSTR(np_addr1,R-INDEX(np_addr1,"�Ӻ�") - 1 ))
            np_addr1     =  trim(SUBSTR(np_addr1,1,R-INDEX(np_addr1,"�Ӻ�") - 1 )).
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy c-wins 
PROCEDURE proc_cutpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT .
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = trim(wdetail.policy)
    nv_i = 0
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
    ind = INDEX(nv_c,"_").
    IF ind <> 0 THEN DO:
        nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_c,".").
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
    wdetail.policy  = nv_c . 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname1 c-wins 
PROCEDURE proc_ficomname1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nr_policy  AS CHAR INIT "" FORMAT "x(30)".
FOR EACH brstat.tlt Use-index  tlt01  Where
    brstat.tlt.trndat        >=   fi_trndatfr   And
    brstat.tlt.trndat        <=   fi_trndatto   And
    brstat.tlt.genusr         =  "aycal72"      no-lock. 
    IF      (cb_report = "�Ң�" ) AND (TRIM(brstat.tlt.comp_usr_tlt) <> trim(fi_reportdata))  THEN NEXT.
    ELSE IF (cb_report = "Release Yes" ) AND /*(brstat.tlt.releas = "no" )*/  (brstat.tlt.releas <> "Yes" ) THEN NEXT. /*Edit Jiraporn A59-0342*/
    ELSE IF (cb_report = "Release No" )  AND /*(brstat.tlt.releas = "Yes" )*/ (brstat.tlt.releas <> "No" ) THEN NEXT.  /*Edit Jiraporn A59-0342*/
    ELSE IF (cb_report = "Release Cancel" ) AND (brstat.tlt.releas <> "CANCEL" ) THEN NEXT.  /*Add Jiraporn A59-0342*/
    ASSIGN  n_record =  n_record + 1 . 

    FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
        sicuw.uwm100.policy =  trim(tlt.nor_noti_tlt)  NO-LOCK NO-ERROR NO-WAIT. 
    IF AVAIL sicuw.uwm100 THEN 
        ASSIGN nr_policy  = "���Ţ�������������к� Premium" .
    ELSE ASSIGN nr_policy = "".
    EXPORT DELIMITER "|" 
        n_record
        brstat.tlt.trndat      
        brstat.tlt.comp_usr_tlt         
        brstat.tlt.nor_noti_tlt  
        brstat.tlt.cha_no  
        brstat.tlt.safe2     
        /*brstat.tlt.filler2 
        brstat.tlt.releas -- Comment A59-0342*/ 
        nr_policy 
        /*Add Jiraphon A59-0342*/
        brstat.tlt.lotno         
        brstat.tlt.comp_noti_tlt 
        brstat.tlt.colorcod      
        brstat.tlt.subins        
        brstat.tlt.ins_name      
        brstat.tlt.recac         
        brstat.tlt.ins_addr1
        /*Add Jiraphon A59-0451*/
        brstat.tlt.ins_addr2
        brstat.tlt.ins_addr3
        brstat.tlt.ins_addr4
        brstat.tlt.ins_addr5
        /*End Jiraphon A59-0451*/
        brstat.tlt.comp_sub      
        brstat.tlt.brand         
        brstat.tlt.model         
        brstat.tlt.cc_weight     
        brstat.tlt.lince1        
        brstat.tlt.lince2
        brstat.tlt.lince3
        brstat.tlt.comp_sck      
        brstat.tlt.eng_no        
        brstat.tlt.nor_effdat       
        brstat.tlt.comp_effdat   
        brstat.tlt.comp_coamt          
        brstat.tlt.comp_grprm
        brstat.tlt.filler2 
        brstat.tlt.releas.        
        /*End Jiraphon A59-0342*/
END.                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname2 c-wins 
PROCEDURE proc_ficomname2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH brstat.tlt Use-index  tlt01  Where
    brstat.tlt.trndat        >=   fi_trndatfr   And
    brstat.tlt.trndat        <=   fi_trndatto   And
    brstat.tlt.lotno          =   n_comname   AND
    brstat.tlt.genusr         =  "phone"              no-lock.  
        /*IF (ra_report = 2) AND (index(tlt.OLD_eng,"not")  <> 0 )  THEN NEXT.
        ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"not") = 0 )   THEN NEXT.
        ELSE IF (ra_report = 4) AND (tlt.releas        = "No" )       THEN NEXT.
        ELSE IF (ra_report = 5) AND (tlt.releas        = "Yes" )     THEN NEXT.*/
    IF      (cb_report = "�Ң�" ) AND (tlt.colorcod <> trim(fi_reportdata))           THEN NEXT.
    ELSE IF (cb_report = "����������������ͧ") AND (brstat.tlt.safe3 <> trim(fi_reportdata)) THEN NEXT.
    ELSE IF (cb_report = "Complete" ) AND (index(brstat.tlt.OLD_eng,"not") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Not complete") AND (brstat.tlt.releas = "No" )          THEN NEXT.
    /*ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "Yes" )         THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "No" )          THEN NEXT. */
    ELSE IF (cb_report = "Release Yes" ) AND (brstat.tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (brstat.tlt.releas = "Yes")          THEN NEXT.
    
    ASSIGN 
        n_record =  n_record + 1.
     /*   nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.*/
    EXPORT DELIMITER "|" 
    n_record                                        /*"�ӴѺ���"      */            
    string(brstat.tlt.trndat,"99/99/9999") FORMAT "x(10)"  /*"�ѹ����Ѻ��" */        
    string(brstat.tlt.trntime)             FORMAT "x(10)"  /*"�����Ѻ��"   */         
    trim(brstat.tlt.nor_noti_tlt)          FORMAT "x(50)"  /*"�Ţ�Ѻ�駧ҹ" */       
    trim(brstat.tlt.lotno)                 FORMAT "x(20)"  /*"���ʺ��ѷ" */           
    trim(brstat.tlt.nor_usr_ins)           FORMAT "x(40)"  /*"�������˹�ҷ�� MKT"*/ 
    trim(brstat.tlt.nor_usr_tlt)           FORMAT "x(10)"  /*"�����Ң�"             */             
    trim(brstat.tlt.nor_noti_ins)          FORMAT "x(35)"  /*"Code: "               */                       
    trim(brstat.tlt.colorcod)              FORMAT "x(20)"  /*"�����Ң�_STY "*/               
    trim(brstat.tlt.comp_sub)              FORMAT "x(30)"  /*"Producer." */           
    trim(brstat.tlt.recac)                 FORMAT "x(30)"  /*"Agent." */              
    trim(brstat.tlt.subins)                FORMAT "x(30)"  /* "Campaign no." */ 
    brstat.tlt.safe1                                       /*"��������Сѹ"*/
    brstat.tlt.safe2                                       /*"������ö"*/          
    brstat.tlt.safe3                                       /*"����������������ͧ"*/
    brstat.tlt.stat
    brstat.tlt.filler1                                     /*"��Сѹ ��/�����"*/ 
    brstat.tlt.filler2                                     /*"�ú.   ��/�����"*/
    brstat.tlt.nor_effdat            /*"�ѹ�����������ͧ"       */
    brstat.tlt.expodat               /*"�ѹ����ش����������ͧ" */
    brstat.tlt.dri_no2               /*  A55-0046.....*/
    brstat.tlt.policy                /*"�Ţ��������70"*/    
    brstat.tlt.comp_pol              /*"�Ţ��������72"*/   
    substr(trim(brstat.tlt.ins_name),1,INDEX(trim(brstat.tlt.ins_name)," ") - 1 ) FORMAT "x(20)"       /*"�ӹ�˹�Ҫ���"*/     
    substr(trim(brstat.tlt.ins_name),INDEX(trim(brstat.tlt.ins_name)," ") + 1 )  FORMAT "x(35)"        /*"���ͼ����һ�Сѹ"*/ 
    trim(brstat.tlt.endno)            /*id no */                                               
    IF brstat.tlt.dat_ins_noti = ? THEN "" ELSE trim(string(brstat.tlt.dat_ins_noti))  /*birth of date. */
    IF brstat.tlt.entdat = ?       THEN "" ELSE TRIM(STRING(brstat.tlt.entdat))        /*birth of date. */
    trim(brstat.tlt.flag)            /*occup */
    trim(brstat.tlt.usrsent)         /*Name drirect */
    trim(brstat.tlt.ins_addr1)       /*"��ҹ�Ţ���" */      
    trim(brstat.tlt.ins_addr2)       /*"�Ӻ�/�ǧ" */
    trim(brstat.tlt.ins_addr3)       /*"�����/ࢵ"*/        
    trim(brstat.tlt.ins_addr4)       /*"�ѧ��Ѵ" */
    trim(brstat.tlt.ins_addr5)       /*"������ɳ���"*/         
    brstat.tlt.comp_noti_ins         /*"�������Ѿ��" */  
    IF brstat.tlt.dri_name1 = "" THEN "����кؼ��Ѻ���" ELSE "�кؼ��Ѻ���"
     /*drivname  "���Ѻ��褹���1"1*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE SUBSTR(brstat.tlt.dri_name1,1,INDEX(brstat.tlt.dri_name1,"sex:") - 1 )
     /*sex       "��"            1*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(brstat.tlt.dri_name1,INDEX(brstat.tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "�ѹ�Դ"        1*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(brstat.tlt.dri_name1,INDEX(brstat.tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "�ҪѾ"          1*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE substr(brstat.tlt.dri_name1,INDEX(brstat.tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "�Ţ���㺢Ѻ���" 1*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE trim(brstat.tlt.dri_no1)
     /*drivname "���Ѻ��褹���2" 2*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE  SUBSTR(brstat.tlt.enttim,1,INDEX(brstat.tlt.enttim,"sex:") - 1 )
     /*sex      "��"             2*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(brstat.tlt.enttim,INDEX(brstat.tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"�ѹ�Դ"         2*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(brstat.tlt.enttim,INDEX(brstat.tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "�ҪѾ"           2*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE substr(brstat.tlt.enttim,INDEX(brstat.tlt.enttim,"occ:") + 4 )   
     /*id driv  "�Ţ���㺢Ѻ���"  2*/    IF brstat.tlt.dri_name1 = "" THEN  "" ELSE trim(brstat.tlt.expotim)   

     /*/*drivname  "���Ѻ��褹���1"1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
     /*sex       "��"            1*/    IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "�ѹ�Դ"        1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "�ҪѾ"          1*/    IF substr(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 ) = "" THEN "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "�Ţ���㺢Ѻ���" 1*/    trim(tlt.dri_no1)
        
     /*drivname "���Ѻ��褹���2" 2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
     /*sex      "��"             2*/    IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"�ѹ�Դ"         2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "�ҪѾ"           2*/    IF substr(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 ) = "" THEN "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )   
     /*id driv  "�Ţ���㺢Ѻ���"  2*/    trim(tlt.expotim)  */
    brstat.tlt.brand                 /*"����������ö"*/         
    brstat.tlt.model                 /*"���ö" */              
    brstat.tlt.eng_no                /*"�Ţ����ͧ¹��" */
    brstat.tlt.cha_no                /*"�Ţ��Ƕѧ" */           
    brstat.tlt.cc_weight             /*"�ի�" */               
    brstat.tlt.lince2                /*"��ö¹��"*/            
    /*substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(7)"  /*"�Ţ����¹"  */*//*A54-0112*/ 
    substr(brstat.tlt.lince1,1,R-INDEX(brstat.tlt.lince1," ") - 1) FORMAT "x(8)"  /*"�Ţ����¹"  *//*A54-0112*/
    substr(brstat.tlt.lince1,R-INDEX(brstat.tlt.lince1," ") + 1) FORMAT "x(30)"    /*"�ѧ��Ѵ��訴����¹"*/ 
    brstat.tlt.lince3                /*"ᾤࡨ"*/
    brstat.tlt.exp                   /*"��ë���" */                                 
    brstat.tlt.nor_coamt             /*"�ع��Сѹ"*/  
    brstat.tlt.dri_name2  FORMAT "x(30)"
    brstat.tlt.nor_grprm             /*"���»�Сѹ" */                             
    brstat.tlt.comp_coamt            /*"���¾ú." */      
    brstat.tlt.comp_grprm            /*"�������"*/        
    brstat.tlt.comp_sck              /*"�Ţʵ������" */  
    brstat.tlt.comp_noti_tlt         /*"�ŢReferance no."*/
    brstat.tlt.rec_name              /*"�͡�����㹹��"*/ 
    brstat.tlt.comp_usr_tlt          /*"Vatcode " */
    brstat.tlt.expousr               /*"����Ѻ��"             */
    brstat.tlt.comp_usr_ins          /*"����Ѻ�Ż���ª��"       */
    brstat.tlt.OLD_cha               /*"�����˵�"               */
    brstat.tlt.OLD_eng              /*"complete/not complete"  */ 
    brstat.tlt.releas. 
END.                   /*  end  wdetail  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report c-wins 
PROCEDURE proc_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "�����ŧҹ�Ѻ��Сѹ��� AYCL Compulsory " .
EXPORT DELIMITER "|"
    "SEQ"
    "�ѹ���"   
    "�Ң�"   
    "�Ţ��������"   
    "�Ţʵ������"   
    "�Ţ��������"
    /*"�����˵�" 
    "Status"    --Comment A59-0342*/
    "Check Policy"
/*Add Jiraporn A59-0342*/
    "Insurance Code"   
    "Contract No."
    "Branch Code."
    "Branch No."   
    "�����١���"   
    "�Ţ�ѵû�Шӵ�ǻ�ЪҪ�"
    "�������"
    "�������2"
    "�������3"
    "�������4"
    "�������5"
    "Class" 
    "������ö"   
    "���ö"   
    "��.��."   
    "Registration"   
    "�ѧ��Ѵ"
    "�Ţ����¹ö" 
    "�Ţ��Ƕѧö" 
    "�Ţ����ͧ¹��"   
    "�ѹ��������ͧ"   
    "�ѹ�������ش������ͧ"   
    "Net.Prem"   
    "Gross Prem"
    "�����˵�" 
    "Status" .
/*End Jiraporn A59-0342*/
RUN proc_ficomname1.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-wins 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_filename).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ��Ҥ�����õԹҤԹ �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ���"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "�ѹ����Ѻ��"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�ѹ����Ѻ�Թ������»�Сѹ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "��ª��ͺ���ѷ��Сѹ���"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ţ����ѭ����ҫ���"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "�Ţ�������������"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "�����Ң�"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "�Ң� KK"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "�Ţ�Ѻ���"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Campaign"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Sub Campaign"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "�ؤ��/�ԵԺؤ��"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "�ӹ�˹�Ҫ���"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "���ͼ����һ�Сѹ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "���ʡ�ż����һ�Сѹ"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "��ҹ�Ţ���"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "�Ӻ�/�ǧ"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "�����/ࢵ"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�ѧ��Ѵ"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "������ɳ���"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "����������������ͧ"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "��������ë���"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "�ѹ�����������ͧ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "�ѹ����ش������ͧ"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "����ö"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "��������Сѹ���ö¹��"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "����������ö"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "���ö"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "New/Used"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "�Ţ����¹"                         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "�Ţ��Ƕѧ"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "�Ţ����ͧ¹��"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "��ö¹��"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "�ի�"                               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "���˹ѡ/�ѹ"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�ع��Сѹ�� 1 "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "����������������ҡû� 1"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "�ع��Сѹ�� 2"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "����������������ҡû� 2"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "�����Ѻ���"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "�������˹�ҷ�� MKT"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "�����˵�"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "���Ѻ����� 1 �����ѹ�Դ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "���Ѻ����� 2 �����ѹ�Դ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "���� (�����/㺡ӡѺ����)"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "���ʡ�� (�����/㺡ӡѺ����)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "��ҹ�Ţ��� (�����/㺡ӡѺ����)"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "�Ӻ�/�ǧ (�����/㺡ӡѺ����)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "�����/ࢵ (�����/㺡ӡѺ����)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "�ѧ��Ѵ (�����/㺡ӡѺ����)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "������ɳ��� (�����/㺡ӡѺ����)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "��ǹŴ����ѵԴ�"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "��ǹŴ�ҹ Fleet"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "Remak1"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "Remak2"                             '"' SKIP.

FOR EACH brstat.tlt Use-index  tlt01  Where
        brstat.tlt.trndat        >=   fi_trndatfr   And
        brstat.tlt.trndat        <=   fi_trndatto   And
        /*tlt.comp_noti_tlt >=   fi_polfr      And
        tlt.comp_noti_tlt <=   fi_polto      And*/
        brstat.tlt.genusr   =  "phone"                no-lock.  
    /*IF      (ra_report = 1) AND (tlt.lotno <> fi_comname ) THEN NEXT.
    ELSE IF (ra_report = 2) AND (index(tlt.OLD_eng,"not")  <> 0 ) THEN NEXT.
    ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"not") = 0 )   THEN NEXT.*/
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' n_record                                            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' string(tlt.trndat,"99/99/9999")      FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' trim(tlt.nor_usr_ins)                FORMAT "x(50)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' trim(tlt.nor_noti_tlt)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(tlt.nor_noti_ins)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' trim(tlt.nor_usr_tlt)                FORMAT "x(10)" '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' trim(tlt.comp_usr_tl)                FORMAT "x(35)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' trim(tlt.comp_noti_tlt)              FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' trim(tlt.dri_no1)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' trim(tlt.dri_no2)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' trim(tlt.safe2)                      FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )         FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,r-INDEX(trim(tlt.ins_name)," ") - INDEX(trim(tlt.ins_name)," "))  FORMAT "x(35)" '"' SKIP.                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' substr(trim(tlt.ins_name),r-INDEX(trim(tlt.ins_name)," ") + 1 )         FORMAT "x(35)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' trim(tlt.ins_addr1)                 FORMAT "x(80)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' trim(tlt.ins_addr2)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' trim(tlt.ins_addr3)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' trim(tlt.ins_addr4)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' trim(tlt.ins_addr5)                 FORMAT "x(15)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' trim(tlt.safe3)                                    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' trim(tlt.stat)                      FORMAT "x(30)" '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' string(tlt.expodat,"99/99/9999")    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(tlt.subins)                    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' trim(tlt.filler2)                   FORMAT "x(40)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' trim(tlt.brand)                     FORMAT "x(30)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' trim(tlt.model)                     FORMAT "x(45)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' trim(tlt.filler1)                   FORMAT "x(20)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' trim(tlt.lince1)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' trim(tlt.cha_no)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' trim(tlt.eng_no)                    FORMAT "x(30)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' trim(tlt.lince2)                    FORMAT "x(10)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' string(tlt.cc_weight)               FORMAT "x(10)" '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' trim(tlt.colorcod)                  FORMAT "x(10)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' string(tlt.comp_coamt)              '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' string(tlt.comp_grprm)              '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' string(tlt.nor_coamt)               '"' SKIP.                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' string(tlt.nor_grprm)               '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' string(tlt.gentim)                  FORMAT "x(10)"     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' trim(tlt.comp_usr_in)               FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' trim(tlt.safe1)                     FORMAT "x(100)"     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' trim(tlt.dri_name1)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' trim(tlt.dri_name2)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' trim(tlt.rec_name)             '"' SKIP.                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' ""                             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' ""                             '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' trim(tlt.rec_addr1)            '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' trim(tlt.rec_addr2)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' trim(tlt.rec_addr3)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' trim(tlt.rec_addr4)            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' trim(tlt.rec_addr5)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' string(tlt.seqno)              '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' tlt.lotno                      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' trim(tlt.OLD_eng)       FORMAT "x(100)"  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' trim(tlt.OLD_cha)       FORMAT "x(100)"  '"' SKIP.
END.   /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".

OUTPUT STREAM ns2 CLOSE.  

Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportfileerr c-wins 
PROCEDURE proc_reportfileerr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FOR EACH wdetail NO-LOCK.
    EXPORT DELIMITER "|" 
        wdetail.Seqno         /*  1   Seq.    1   */                                  
        wdetail.Company       /*  2   Company AYCAL   */                          
        wdetail.Porduct       /*  3   Porduct HP  */                                  
        wdetail.Branch        /*  4   Branch  17  */                                  
        wdetail.Contract      /*  5   Contract    TU03590 */                   
        wdetail.nTITLE        /*  6   ����+���ʡ��    ��� */                                                   
        wdetail.name1         /*  7       �����   */                     
        wdetail.name2         /*  8       ����   */                     
        wdetail.addr1         /*  9   ������� 17/2 �.2    */                   
        wdetail.addr2         /*  10      �.�ع��� �.�ù���  */ 
        wdetail.addr3         /*  11      ������� */                                          
        wdetail.addr4         /*  12      11150   */                        
        wdetail.brand         /*  13  ������ö    TOY */                          
        wdetail.model         /*  14  ���ö  FORTUNER TRD    */                  
        wdetail.coler         /*  15  ��  ��� */                                          
        wdetail.vehreg        /*  16  �Ţ����¹  �� 9525 */                      
        wdetail.provin        /*  17  �ѧ��Ѵ��訴����¹ ��ا෾��ҹ��   */      
        wdetail.caryear       /*  18  ��ö    2009    */                          
        wdetail.cc            /*  19  CC. 2982    */                              
        wdetail.chassis       /*  20  �Ţ��Ƕѧ   MR0YZ59G200090615   */          
        wdetail.engno         /*  21  �Ţ����ͧ  1KD6400738  */                  
        wdetail.notifyno      /*  22  Code �����    1716    */                  
        wdetail.covcod        /*  23  ������  1   */                              
        wdetail.Codecompany   /*  24  Code �.��Сѹ   KPI */                      
        wdetail.prepol        /*  25  �Ţ����������� DM7055023011    */          
        wdetail.comdat70      /*  26  �ѹ������ͧ��Сѹ   561019  */              
        wdetail.expdat70      /*  27  �ѹ�����Сѹ    571019  */                      
        wdetail.si            /*  28  �ع��Сѹ   38000000    */                  
        wdetail.premt         /*  29  ��������ط���  1505151 */                  
        wdetail.premtnet      /*  30  ���������������ҡ� 1616884 */ 
        wdetail.other         /*  31      539000  */                                                             
        wdetail.renew         /*  32  �ջ�Сѹ    5   */                                       
        wdetail.policy        /*  33  �Ţ�Ѻ��  STAY13-0349 */        
        wdetail.idno          /*  34  �Ţ�ѵû�ЪҪ� */                                                                   
        wdetail.remak         /*  35  �����˵�. */                                                                               
        wdetail.notifydate    /*  36  �ѹ�����  560821  */                                              
        wdetail.Deduct        /*  37  Deduct */                                                          
        wdetail.Codecompa72   /*  38  Code �.��Сѹ �ú. */                                                  
        wdetail.comdat72      /*  39  �ѹ������ͧ�ú.*/                                                          
        wdetail.expdat72      /*  40  �ѹ����ú. */                                                      
        wdetail.comp          /*  41  ��Ҿú.*/                                                              
        wdetail.driverno      /*  42  �кؼ��Ѻ��� */                                             
        wdetail.garage        /*  43  ������ҧ */                                                      
        wdetail.access        /*  44  ������ͧ�ػ�ó�������� */
        wdetail.endoresadd .  /*  45  ��䢷������  */
END. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat1 c-wins 
PROCEDURE proc_reportmat1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST brstat.tlt   Where
        brstat.tlt.nor_noti_tlt   = trim(wdetail.policy)   AND 
        brstat.tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL brstat.tlt THEN  DELETE wdetail.
END.
 

RUN proc_reporttitle.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat11 c-wins 
PROCEDURE proc_reportmat11 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
        tlt.nor_noti_tlt   = trim(wdetail.policy)   AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN 
            nv_countcomplete = nv_countcomplete + 1 
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "�س"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  �ӴѺ���     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  �ѹ�����   */            
            tlt.nor_noti_tlt               /*  3  �Ţ�Ѻ��   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  �ӹ�˹�Ҫ��� */           
            trim(np_name)                  /*  7  ����         */           
            trim(np_name2)                 /*  8  ���ʡ��      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ������� 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ������� 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ������� 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ������� 4    */           
            tlt.brand               /*  13 ������ö     */           
            tlt.model               /*  14 ���ö       */           
            tlt.lince1              /*  15 �Ţ����¹   */           
            tlt.lince2              /*  16 ��ö         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 �Ţ��Ƕѧ    */           
            tlt.eng_no              /*  19 �Ţ����ͧ   */           
            tlt.comp_noti_tlt       /*  20 Code ����� */           
            tlt.safe3               /*  21 ������       */           
            tlt.nor_usr_ins         /*  22 Code �.��Сѹ        */  
            tlt.nor_noti_ins        /*  23 �Ţ�����������      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 �ѹ������ͧ��Сѹ    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 �ѹ�����Сѹ         */   
            tlt.comp_coamt         /*  26 �ع��Сѹ    */           
            DECI(tlt.dri_name2)    /*  27 ��������ط��� */         
            tlt.nor_grprm          /*  28 ���������������ҡ� */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code �.��Сѹ �ú.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 �ѹ������ͧ�ú.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 �ѹ����ú.   */           
            deci(tlt.dri_no1)   /*  33 ��Ҿú.      */           
            tlt.dri_name1       /*  34 �кؼ��Ѻ���        */   
            tlt.stat            /*  35 ������ҧ     */           
            tlt.safe1           /*  36 ������ͧ�ػ�ó��������*/
            tlt.filler1         /*  37 ��䢷������    */        
            tlt.comp_usr_ins    /*  38 ����Ѻ�Ż���ª�� */       
            tlt.OLD_cha         /*  39 �����˵� */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas         /*  41 Yes/No . */ 
            wdetail.premtnet      /*  �������    */
            wdetail.recivedat.    /*  ��������ش  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat2 c-wins 
PROCEDURE proc_reportmat2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
        tlt.recac    = trim(wdetail.Contract)  AND 
        tlt.genusr   =  "aycal72"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
END.
RUN proc_reporttitle.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat22 c-wins 
PROCEDURE proc_reportmat22 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .

    FIND LAST tlt   Where
        tlt.recac    = trim(wdetail.Contract)  AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "�س"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  �ӴѺ���     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  �ѹ�����   */            
            tlt.nor_noti_tlt               /*  3  �Ţ�Ѻ��   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  �ӹ�˹�Ҫ��� */           
            trim(np_name)                  /*  7  ����         */           
            trim(np_name2)                 /*  8  ���ʡ��      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ������� 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ������� 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ������� 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ������� 4    */           
            tlt.brand               /*  13 ������ö     */           
            tlt.model               /*  14 ���ö       */           
            tlt.lince1              /*  15 �Ţ����¹   */           
            tlt.lince2              /*  16 ��ö         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 �Ţ��Ƕѧ    */           
            tlt.eng_no              /*  19 �Ţ����ͧ   */           
            tlt.comp_noti_tlt       /*  20 Code ����� */           
            tlt.safe3               /*  21 ������       */           
            tlt.nor_usr_ins         /*  22 Code �.��Сѹ        */  
            tlt.nor_noti_ins        /*  23 �Ţ�����������      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 �ѹ������ͧ��Сѹ    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 �ѹ�����Сѹ         */   
            tlt.comp_coamt         /*  26 �ع��Сѹ    */           
            DECI(tlt.dri_name2)    /*  27 ��������ط��� */         
            tlt.nor_grprm          /*  28 ���������������ҡ� */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code �.��Сѹ �ú.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 �ѹ������ͧ�ú.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 �ѹ����ú.   */           
            deci(tlt.dri_no1)   /*  33 ��Ҿú.      */           
            tlt.dri_name1       /*  34 �кؼ��Ѻ���        */   
            tlt.stat            /*  35 ������ҧ     */           
            tlt.safe1           /*  36 ������ͧ�ػ�ó��������*/
            tlt.filler1         /*  37 ��䢷������    */        
            tlt.comp_usr_ins    /*  38 ����Ѻ�Ż���ª�� */       
            tlt.OLD_cha         /*  39 �����˵� */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas          /*  41 Yes/No . */ 
            wdetail.premtnet      /*  �������    */
            wdetail.recivedat.    /*  ��������ش  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat3 c-wins 
PROCEDURE proc_reportmat3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
        tlt.lince1   = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
END.
RUN proc_reporttitle.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat33 c-wins 
PROCEDURE proc_reportmat33 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .

    FIND LAST tlt   Where
        tlt.lince1         = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "�س"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  �ӴѺ���     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  �ѹ�����   */            
            tlt.nor_noti_tlt               /*  3  �Ţ�Ѻ��   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  �ӹ�˹�Ҫ��� */           
            trim(np_name)                  /*  7  ����         */           
            trim(np_name2)                 /*  8  ���ʡ��      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ������� 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ������� 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ������� 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ������� 4    */           
            tlt.brand               /*  13 ������ö     */           
            tlt.model               /*  14 ���ö       */           
            tlt.lince1              /*  15 �Ţ����¹   */           
            tlt.lince2              /*  16 ��ö         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 �Ţ��Ƕѧ    */           
            tlt.eng_no              /*  19 �Ţ����ͧ   */           
            tlt.comp_noti_tlt       /*  20 Code ����� */           
            tlt.safe3               /*  21 ������       */           
            tlt.nor_usr_ins         /*  22 Code �.��Сѹ        */  
            tlt.nor_noti_ins        /*  23 �Ţ�����������      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 �ѹ������ͧ��Сѹ    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 �ѹ�����Сѹ         */   
            tlt.comp_coamt         /*  26 �ع��Сѹ    */           
            DECI(tlt.dri_name2)    /*  27 ��������ط��� */         
            tlt.nor_grprm          /*  28 ���������������ҡ� */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code �.��Сѹ �ú.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 �ѹ������ͧ�ú.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 �ѹ����ú.   */           
            deci(tlt.dri_no1)   /*  33 ��Ҿú.      */           
            tlt.dri_name1       /*  34 �кؼ��Ѻ���        */   
            tlt.stat            /*  35 ������ҧ     */           
            tlt.safe1           /*  36 ������ͧ�ػ�ó��������*/
            tlt.filler1         /*  37 ��䢷������    */        
            tlt.comp_usr_ins    /*  38 ����Ѻ�Ż���ª�� */       
            tlt.OLD_cha         /*  39 �����˵� */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas         /*  41 Yes/No . */ 
            wdetail.premtnet      /*  �������    */
            wdetail.recivedat.    /*  ��������ش  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat4 c-wins 
PROCEDURE proc_reportmat4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_branch AS CHAR FORMAT "x(2)" .
ASSIGN 
    nv_branch        = "" 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.

FOR EACH wdetail WHERE wdetail.SEQ  <> "" :
    ASSIGN fi_process2 =  "Process data match Aycal/KPI Comulsory : " + wdetail.STICKERNO .
    DISP fi_process2  WITH FRAM fr_main.  

    ASSIGN nv_countdata = nv_countdata  + 1.
    /*-- Add A59-0069 --*/
    nv_comdat = SUBSTR(wdetail.startdate,5,2) + "/" + 
                SUBSTR(wdetail.startdate,3,2) + "/" +
                STRING(INTE(SUBSTR(wdetail.startdate,1,2)) - 43,"99").
    nv_comdat = STRING(DAY(DATE(nv_comdat)),"99")   + "/" + 
                STRING(MONTH(DATE(nv_comdat)),"99") + "/" + 
                STRING(YEAR(DATE(nv_comdat)),"9999").
    wdetail.startdate = nv_comdat.

    nv_expdat = SUBSTR(wdetail.enddate,5,2) + "/" + 
                SUBSTR(wdetail.enddate,3,2) + "/" +
                STRING(INTE(SUBSTR(wdetail.enddate,1,2)) - 43,"99").
    nv_expdat = STRING(DAY(DATE(nv_expdat)),"99")   + "/" + 
                STRING(MONTH(DATE(nv_expdat)),"99") + "/" + 
                STRING(YEAR(DATE(nv_expdat)),"9999").
    wdetail.enddate = nv_expdat.
    
   /* FIND LAST brstat.tlt USE-INDEX tlt06 WHERE
              brstat.tlt.cha_no = STRING(DECI(TRIM(wdetail.STICKERNO))) AND 
              brstat.tlt.genusr = "aycal72"                             NO-LOCK NO-ERROR.
    IF AVAIL brstat.tlt THEN DO:*/
        IF wdetail.branchcode = "" THEN DO:
            wdetail.n_memmopremium = "Branch Code Not Avaliable".
        END.

        IF wdetail.brand <> "" THEN DO:
            FIND FIRST sicsyac.xmm102 WHERE INDEX(sicsyac.xmm102.moddes,TRIM(wdetail.brand)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm102 THEN DO:
                wdetail.modcod = sicsyac.xmm102.modcod.
            END.
            ELSE wdetail.modcod = "".
        END.
        ASSIGN
            wdetail.producer = fi_producer
            wdetail.agent    = fi_agent.
        IF wdetail.BRANCHNO = "�ӹѡ�ҹ�˭�" THEN DO:
            IF fi_producer = "" THEN wdetail.producer = "B3MLAY0104" . /*"A0M0061".*/ /*A64-0060*/
                                ELSE wdetail.producer = fi_producer.
            /*IF fi_agent = "" THEN wdetail.agent = "B300303".*/ /*A64-0060*/
            IF fi_agent = "" THEN wdetail.agent = "B3MLAY0100". /*A64-0060*/
                             ELSE wdetail.agent = fi_agent.
        END.
        ELSE DO:
            nv_cha_no = TRIM(wdetail.body).

            IF fi_producer = "" THEN DO:
                FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE  /*��� INDEX �ҡ uwm30101*/
                          sicuw.uwm301.trareg = nv_cha_no AND
                   SUBSTR(sicuw.uwm301.policy,3,2) = "72" NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm301 THEN DO:
                    wdetail.n_memmopremium = "������� " + sicuw.uwm301.policy. 
                    /* comment by : A64-0060 ...
                    IF fi_producer = "" THEN wdetail.producer = "A0M0018".
                    IF fi_agent    = "" THEN wdetail.agent = "B300303".
                    end : A64-0060...*/
                    /* add by : A64-0060 */
                    IF fi_producer = "" THEN wdetail.producer = "B3MLAY0101".
                    IF fi_agent    = "" THEN wdetail.agent    = "B3MLAY0100".
                    /*end : A64-0060...*/
                END.
                ELSE DO:
                    /* comment by : A64-0060 ...
                    IF fi_producer = "" THEN wdetail.producer = "A0M0019".
                    IF fi_agent    = "" THEN wdetail.agent = "B300303".
                    end : A64-0060...*/
                    /* add by : A64-0060 */
                    IF fi_producer = "" THEN wdetail.producer = "B3MLAY0102".   
                    IF fi_agent    = "" THEN wdetail.agent    = "B3MLAY0100".   
                    /*end : A64-0060...*/
                END. 
            END.
            ELSE DO:
                wdetail.producer = fi_producer.
                IF fi_agent <> "" THEN wdetail.agent = fi_agent.
                                 /* ELSE wdetail.agent = "B300303". */ /*A64-0060*/
                                  ELSE wdetail.agent    = "B3MLAY0100".  /*A64-0060*/
            END.
        END.
        /*-- Check Chassis ����� Premium ���� --*/
        nv_cha_no = TRIM(wdetail.body).
        FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE  /*��� INDEX �ҡ uwm30101*/
                  sicuw.uwm301.trareg = nv_cha_no AND
           SUBSTR(sicuw.uwm301.policy,3,2) = "72" NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm301 THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                      sicuw.uwm100.policy = sicuw.uwm301.policy AND
                      sicuw.uwm100.rencnt = sicuw.uwm301.rencnt AND
                      sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.comdat = DATE(wdetail.startdate) AND
                   sicuw.uwm100.expdat = DATE(wdetail.enddate)   THEN DO:  /*�ѹ��������ͧ��ҡѹ*/
                    wdetail.n_memmopremium = "�Ţ Chassis �������к����� " + sicuw.uwm100.policy.
                END.
                ELSE IF sicuw.uwm100.expdat > DATE(wdetail.startdate) THEN DO:  /*�ѧ����㹤���������ͧ*/
                    wdetail.n_memmopremium = "�Ţ Chassis ����ѧ�������ش����������ͧ " + sicuw.uwm100.policy.
                END.
            END.
        END.
        FIND LAST brstat.tlt WHERE
                   brstat.tlt.cha_no = STRING(DECI(TRIM(wdetail.STICKERNO))) AND
                   brstat.tlt.genusr = "aycal72"  NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            IF brstat.tlt.nor_noti_tlt <> "" THEN DO:
                IF brstat.tlt.releas = "NO" THEN DO:
                    /*Add Jiraphon A59-0451*/
                        FIND LAST sicuw.uwm100 WHERE uwm100.policy = TRIM(brstat.tlt.nor_noti_tlt) NO-LOCK NO-ERROR.
                        IF NOT AVAIL sicuw.uwm100 THEN DO:
                            ASSIGN wdetail.policy   = brstat.tlt.nor_noti_tlt
                                   wdetail.branch   = brstat.tlt.comp_usr_tlt
                                   wdetail.n_memmopremium = "Yes".
                        END.
                        ELSE DO:
                            ASSIGN wdetail.policy   = ""
                            wdetail.branch          = ""
                            wdetail.n_memmopremium  = ""
                            brstat.tlt.nor_noti_tlt = "".
                        END.
                    /*End Add Jiraphon A59-0451*/
                    /*ASSIGN
                        wdetail.policy = brstat.tlt.nor_noti_tlt
                        wdetail.branch = brstat.tlt.comp_usr_tlt
                        wdetail.n_memmopremium = "Yes".
                    --Comment Jiraphon A59-0451*/     
                END.
                ELSE DO:
                    wdetail.n_memmopremium = "�Ţʵ������١������� " + brstat.tlt.nor_noti_tlt.
                END.
            END.
        END.
        RELEASE brstat.tlt.
        /*-- Check Branch --*/
        FIND FIRST stat.insure USE-INDEX insure03 WHERE stat.insure.compno = "AYCAL" AND
                   stat.insure.insno  = wdetail.branchcode NO-LOCK NO-ERROR.
        IF AVAIL stat.insure THEN DO:
            nv_branch  = stat.insure.branch.
        END.
        ELSE wdetail.n_memmopremium = "Branch �繤����ҧ �������ö������к���".
 
        IF trim(nv_branch) <> "" AND trim(nv_branch) <> trim(wdetail.branch) THEN DO:
            ASSIGN wdetail.policy = ""  
                   wdetail.branch = nv_branch 
                   wdetail.n_memmopremium = "" .
        END.
        IF wdetail.branch = "" THEN wdetail.n_memmopremium = "Branch �繤����ҧ �������ö������к���".
        /*-- Check Policy --*/
        /*IF wdetail.branchcode <> "" AND wdetail.n_memmopremium = "" THEN DO:*/ /*A64-0060*/
        IF wdetail.n_memmopremium = "" AND wdetail.policy = "" THEN DO:  /*A64-0060*/
            /*-- Check Branch --*/
            /*FIND FIRST stat.insure USE-INDEX insure03 WHERE
                       stat.insure.compno = "AYCAL" AND
                       stat.insure.insno  = wdetail.branchcode NO-LOCK NO-ERROR.
            IF AVAIL stat.insure THEN DO:
                wdetail.branch = stat.insure.branch.
            END.
            ELSE wdetail.n_memmopremium = "Branch �繤����ҧ �������ö������к���".--Comment Jiraphon A59-0451*/
            IF wdetail.branch <> "" THEN DO:
                ASSIGN nv_br    = ""    nv_brnno = "".
                FIND FIRST stat.company USE-INDEX company01 WHERE
                           stat.company.compno = "AYCAL"    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.company THEN DO: 
                    IF stat.company.name2 <> "AY" THEN nv_br = stat.company.abname.  /*Check Running ��ѧ��  "AY"*/
                                                  ELSE nv_br = "AY".
                END.
                ELSE DO:
                    FIND LAST stat.company USE-INDEX company01 WHERE
                              stat.company.compno = "AYCAL72" NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL stat.company THEN nv_br = stat.company.abname.   /*Check Running ��ѧ��  "AY"*/
                    ELSE wdetail.n_memmopremium = "Please Check Running ��ѧ�� [Company]".
                END.

                IF nv_br <> "" THEN DO:

                    nv_brnno = TRIM(wdetail.branch) + TRIM(nv_br).
                    FIND FIRST sicsyac.s0m003 WHERE
                               TRIM(sicsyac.s0m003.fld11) = nv_brnno AND
                               TRIM(sicsyac.s0m003.fld22) = wdetail.producer NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicsyac.s0m003 THEN DO:
                        ASSIGN
                            nv_brnpol  = sicsyac.s0m003.fld12 
                            nv_startno = sicsyac.s0m003.fld21.
                    END.
                    ELSE wdetail.n_memmopremium = "Please Check Running Policy [s0m003]".

                    IF nv_startno <> "" THEN DO:
                        FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
                                   stat.polno_fil.DIR_ri   = YES        AND
                                   stat.polno_fil.poltyp   = "V72"      AND
                                   stat.polno_fil.branch   = nv_brnno   AND
                                   stat.polno_fil.undyr    = STRING(YEAR(TODAY) + 543,"9999") AND
                                   stat.polno_fil.brn_pol  = nv_brnpol  AND
                                   stat.polno_fil.start_no = nv_startno EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                        IF NOT AVAIL stat.polno_fil THEN DO:
                            IF LOCKED stat.polno_fil THEN DO:
                                RETURN.
                            END.
            
                            CREATE stat.polno_fil.
                            ASSIGN
                                stat.polno_fil.dir_ri   = YES
                                stat.polno_fil.poltyp   = "V72"
                                stat.polno_fil.branch   = nv_brnno
                                stat.polno_fil.brn_pol  = nv_brnpol
                                stat.polno_fil.undyr    = STRING(YEAR(TODAY) + 543,"9999")
                                stat.polno_fil.START_no = nv_startno.
                                stat.polno_fil.nextno   = 1.
            
                            nv_polno = 1.
            
                        END.
                        ELSE DO:
                            nv_polno = stat.polno_fil.nextno.
                            /*stat.polno_fil.nextno = stat.polno_fil.nextno + 1.*//*Update ���������ա�� Gen Policy ����Ţʵ���������*/
                        END.

                        nv_year = SUBSTR(STRING(YEAR(TODAY) + 543),3,2).

                        IF LENGTH(nv_brnpol) = 1 THEN DO:
                            wdetail.policy = "D".
                        END.
                        ELSE wdetail.policy = "" . /*A64-0060 */

                        IF nv_startno = "" THEN DO:
                            wdetail.policy = TRIM(wdetail.policy) 
                                           + TRIM(nv_brnpol)
                                           + "72"
                                           + nv_year
                                           + STRING(nv_polno,"9999").
                        END.
                        ELSE IF LENGTH(TRIM(nv_startno)) = 1 THEN DO:
                            wdetail.policy = TRIM(wdetail.policy)
                                           + TRIM(nv_brnpol) + "72"
                                           + nv_year
                                           + TRIM(nv_startno)
                                           + STRING(nv_polno,"99999").
                        END.
                        ELSE IF LENGTH(TRIM(nv_startno)) = 2 THEN DO:
                            wdetail.policy = TRIM(wdetail.policy)
                                           + TRIM(nv_brnpol) + "72"
                                           + nv_year
                                           + TRIM(nv_startno)
                                           + STRING(nv_polno,"9999").
                        END.                                         
                        ELSE DO:
                            wdetail.policy = TRIM(wdetail.policy)
                                           + TRIM(nv_brnpol) + "72"
                                           + nv_year
                                           + STRING(nv_polno,"999999").
                        END.
                        RELEASE stat.polno_fil.
                    END.
                    ELSE wdetail.n_memmopremium = "Running Start No. �繤����ҧ [s0m003]".
                END.
                ELSE wdetail.n_memmopremium = "Running ��ѧ���繤����ҧ".
            END.
        END.

        IF LENGTH(wdetail.policy) = 12 THEN DO:           
             IF wdetail.n_memmopremium = "" THEN DO:
                 /*-- ��Ǩ�ͺ�������� --*/
                 FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                           sicuw.uwm100.policy = TRIM(wdetail.policy) NO-LOCK NO-ERROR NO-WAIT.
                 IF NOT AVAIL sicuw.uwm100 THEN DO:
                     FIND LAST brstat.tlt WHERE 
                                brstat.tlt.cha_no = STRING(DECI(TRIM(wdetail.STICKERNO))) AND
                                brstat.tlt.genusr = "aycal72" NO-ERROR NO-WAIT.
                     IF AVAIL brstat.tlt THEN DO:
                         IF brstat.tlt.nor_noti_tlt = "" THEN DO:
                             ASSIGN
                                 brstat.tlt.nor_noti_tlt = CAPS(wdetail.policy)
                                 brstat.tlt.comp_usr_tlt = wdetail.branch.
                         END.
                         ELSE DO: 
                             IF brstat.tlt.releas = "Yes" THEN DO:
                                 wdetail.n_memmopremium = "�Ţʵ������١������� " + brstat.tlt.nor_noti_tlt.
                             END.              
                         END.
                     END.
                     RELEASE brstat.tlt.
                 END.
                 ELSE DO: 
                     wdetail.n_memmopremium = "�Ţ��������١������� " + wdetail.policy.
                     RUN proc_running01. /*ADD Jiraphon A59-0451 check �Ţ running policy*/
                     /*-- Update Running Policy --*/
                     /*IF wdetail.n_memmopremium = "YES" THEN DO:
                        FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
                                   stat.polno_fil.DIR_ri   = YES        AND
                                   stat.polno_fil.poltyp   = "V72"      AND
                                   stat.polno_fil.branch   = nv_brnno   AND
                                   stat.polno_fil.undyr    = STRING(YEAR(TODAY) + 543,"9999") AND
                                   stat.polno_fil.brn_pol  = nv_brnpol  AND
                                   stat.polno_fil.start_no = nv_startno EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL stat.polno_fil THEN DO:
                            stat.polno_fil.nextno = stat.polno_fil.nextno + 1.
                        END.
                     END.*/
                 END.
             END.
        END.
        ELSE IF wdetail.policy <> "" THEN wdetail.n_memmopremium = "�Ţ�����������١��ͧ".
        ELSE IF wdetail.policy  = "" THEN IF wdetail.n_memmopremium = "" THEN wdetail.n_memmopremium = "�Ţ���������繤����ҧ".
        /*ADD Jiraphon A59-0342*/ /*Query Data*/
        /* add by A64-0060 */
        IF wdetail.n_memmopremium = "" OR wdetail.n_memmopremium = "YES" THEN DO:
            FIND LAST brstat.tlt USE-INDEX tlt06 WHERE
              brstat.tlt.cha_no = STRING(DECI(TRIM(wdetail.STICKERNO))) AND 
              brstat.tlt.genusr = "aycal72"                             NO-ERROR NO-WAIT.
              IF AVAIL brstat.tlt THEN  RUN proc_reportmat4-1.
              ELSE DO:
                  IF TRIM(wdetail.province) <> ""  THEN DO:
                      FIND FIRST brstat.insure USE-INDEX insure01 WHERE brstat.insure.comp = "999" AND /*A64-0060*/  
                           brstat.insure.FName = trim(wdetail.province)  NO-LOCK NO-ERROR.
                      IF AVAIL brstat.insure THEN  
                         ASSIGN wdetail.PROVINCE     = TRIM(brstat.insure.LName).
                  END.
                  IF trim(wdetail.campaign_CJ) = "Y" OR trim(wdetail.campaign_CJ) = "CJ" THEN ASSIGN wdetail.camp_CJ = "��Ҥ�� ��ا�����ظ�� �ӡѴ(��Ҫ�)".
                  ELSE IF rs_type = 1  THEN ASSIGN wdetail.camp_CJ = "��Ҥ�� ��ا�����ظ�� �ӡѴ(��Ҫ�)". 
                  ELSE wdetail.camp_CJ = "" .   
                  RUN proc_addr. 
              END.
        END.
        /* end A64-0060 */
       /*End Jiraphon A59-0342*/
   /* comment by a64-0060..
    END.
    ELSE DO:
        wdetail.n_memmopremium = "Sticker No. not Available".
    END.  .. end A64-0060...*/
    IF wdetail.n_memmopremium <> ""  THEN DO:
        IF wdetail.n_memmopremium <> "Yes" THEN wdetail.policy = "".
    END.
    ELSE DO: 
        nv_countcomplete = nv_countcomplete + 1.
        /*-- Update Running Policy --*/
        FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
                   stat.polno_fil.DIR_ri   = YES        AND
                   stat.polno_fil.poltyp   = "V72"      AND
                   stat.polno_fil.branch   = nv_brnno   AND
                   stat.polno_fil.undyr    = STRING(YEAR(TODAY) + 543,"9999") AND
                   stat.polno_fil.brn_pol  = nv_brnpol  AND
                   stat.polno_fil.start_no = nv_startno EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.polno_fil THEN DO:
            stat.polno_fil.nextno = stat.polno_fil.nextno + 1.
        END.
    END.
    IF INDEX(wdetail.n_memmopremium,"�Ţʵ������١�������") <> 0 THEN RUN proc_addr. /*A60-0542*/
    
    /*-- End Add A59-0069 --*/
    
END.
RUN proc_reporttitle.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat4-1 c-wins 
PROCEDURE proc_reportmat4-1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/ 
def var nv_no    as char format "x(20)" init "" . /*A64-0060*/
def var nv_road  as char format "x(20)" init "" . /*A64-0060*/
def var nv_soi   as char format "x(20)" init "" . /*A64-0060*/
def var nv_moo   as char format "x(20)" init "" . /*A64-0060*/
DEF BUFFER bftlt FOR brstat.tlt. /*A64-0060*/
  /*Query Data*/
    /*Add Jiraporn A59-0342*/
   
  IF brstat.tlt.releas <> "Yes" THEN DO:
       IF brstat.tlt.cha_no = wdetail.STICKERNO THEN DO: 
           ASSIGN
               brstat.tlt.lotno         = TRIM(wdetail.INSURANCECODE)
               brstat.tlt.comp_noti_tlt = TRIM(wdetail.CONTRACTNO)
               brstat.tlt.EXP           = TRIM(wdetail.campaign_CJ) /*A60-0542*/
               brstat.tlt.colorcod      = TRIM(wdetail.BRANCHCODE)
               brstat.tlt.subins        = TRIM(wdetail.BRANCHNO)
               brstat.tlt.ins_name      = TRIM(wdetail.CUSTOMERNAME)
               brstat.tlt.recac         = TRIM(wdetail.CARDID)
               /*brstat.tlt.ins_addr1     = TRIM(wdetail.ADDRESS).*/
               brstat.tlt.comp_sub      = TRIM(wdetail.CARNO)
               brstat.tlt.brand         = TRIM(wdetail.BRAND)
               brstat.tlt.model         = TRIM(wdetail.MODEL)
               brstat.tlt.cc_weight     = INTE(TRIM(wdetail.CC))
               brstat.tlt.lince1        = TRIM(wdetail.REGISTRATION)
               brstat.tlt.lince2        = TRIM(wdetail.PROVINCE)
               brstat.tlt.comp_sck      = TRIM(wdetail.BODY)      
               brstat.tlt.eng_no        = TRIM(wdetail.ENGINE)  
               brstat.tlt.nor_effdat    = DATE(TRIM(wdetail.startdate))      
               brstat.tlt.comp_effdat   = DATE(TRIM(wdetail.enddate))  
               brstat.tlt.comp_coamt    = DECI(TRIM(wdetail.NETINCOME))         
               brstat.tlt.comp_grprm    = DECI(TRIM(wdetail.TOTALINCOME)).
               nv_address = wdetail.ADDRESS.

               IF wdetail.REGISTRATION  = "" THEN ASSIGN wdetail.PROVINCE  = "".
               IF brstat.tlt.lince1     = "" THEN
                  ASSIGN brstat.tlt.lince1    = "/" + SUBSTR(wdetail.body,(LENGTH(wdetail.body) - 9) + 1,LENGTH(wdetail.body))
                         wdetail.REGISTRATION = brstat.tlt.lince1
                         wdetail.province     = "" .   /*A60-0542*/
               /* Add by : A64-0060*/
               
               FIND FIRST bftlt USE-INDEX tlt06   WHERE   
                 index(bftlt.cha_no,brstat.tlt.cha_no) <> 0  AND 
                 bftlt.genusr   <> "AYCAL72"        AND 
                 bftlt.genusr   = TRIM(fi_producer) NO-ERROR NO-WAIT .
                 IF AVAIL bftlt THEN DO: 
                     ASSIGN
                         bftlt.nor_noti_tlt   = CAPS(trim(wdetail.policy))  /* 3  �Ţ��������    */ 
                         bftlt.comp_usr_tlt   = TRIM(wdetail.branch) .
                 END.
                /* end :A64-0060*/

               /* comment by Ranu i. A60-0542 .....
               brstat.tlt.lince2        = TRIM(wdetail.PROVINCE)
               brstat.tlt.comp_sck      = TRIM(wdetail.BODY)      
               brstat.tlt.eng_no        = TRIM(wdetail.ENGINE)  
               brstat.tlt.nor_effdat    = DATE(TRIM(wdetail.startdate))      
               brstat.tlt.comp_effdat   = DATE(TRIM(wdetail.enddate))  
               brstat.tlt.comp_coamt    = DECI(TRIM(wdetail.NETINCOME))         
               brstat.tlt.comp_grprm    = DECI(TRIM(wdetail.TOTALINCOME)).
               nv_address = wdetail.ADDRESS.
               ... end A60-0542....*/
               /*brstat.tlt.sentcnt       = TRIM(wdetail.MODEL).*/
        END.
       /* comment by : A60-0542 
       FIND FIRST brstat.insure USE-INDEX insure01 WHERE brstat.tlt.lince2 = brstat.insure.FName NO-LOCK NO-ERROR.
       IF AVAIL brstat.insure THEN DO: 
           IF brstat.tlt.lince2 <> "" THEN brstat.tlt.lince3 = brstat.tlt.lince1 + " " + brstat.insure.LName.
           ELSE IF brstat.tlt.lince2 = "" THEN brstat.tlt.lince3 = "/" + brstat.tlt.lince1.

           IF brstat.tlt.lince3 <> "" THEN wdetail.registration = brstat.tlt.lince3.
       END.
       ... end A60-0542......*/
       /* Create by A60-0542 */
       IF TRIM(wdetail.province) <> ""  THEN DO:
           FIND FIRST brstat.insure USE-INDEX insure01 WHERE brstat.insure.comp = "999" AND /*A64-0060*/  
                brstat.insure.FName = trim(brstat.tlt.lince2)  NO-LOCK NO-ERROR.
           IF AVAIL brstat.insure THEN  
              ASSIGN wdetail.PROVINCE     = TRIM(brstat.insure.LName).
       END.
       /*IF trim(wdetail.campaign_CJ) = "Y" THEN ASSIGN wdetail.camp_CJ = "��Ҥ�� ��ا�����ظ�� �ӡѴ(��Ҫ�)".  
       ELSE wdetail.camp_CJ = "" .   */  /* A61-0349 */  

       IF trim(wdetail.campaign_CJ) = "Y" OR trim(wdetail.campaign_CJ) = "CJ" THEN ASSIGN wdetail.camp_CJ = "��Ҥ�� ��ا�����ظ�� �ӡѴ(��Ҫ�)".
       ELSE IF rs_type = 1  THEN ASSIGN wdetail.camp_CJ = "��Ҥ�� ��ا�����ظ�� �ӡѴ(��Ҫ�)". /*A64-0060*/
       ELSE wdetail.camp_CJ = "" .    /* A61-0349 */

       /* end : a60-0542 */
       /*Add Jiraphon A59-0451*/
       ASSIGN nv_address = wdetail.ADDRESS
              nv_no   = ""    /*A64-0060 */
              nv_road = ""    /*A64-0060 */
              nv_soi  = ""    /*A64-0060 */
              nv_moo  = ""    /*A64-0060 */
              nv_tam  = ""
              nv_amp  = ""
              nv_prov = ""
              brstat.tlt.ins_addr1 = ""
              brstat.tlt.ins_addr2 = ""
              brstat.tlt.ins_addr3 = ""
              brstat.tlt.ins_addr4 = ""
              brstat.tlt.ins_addr5 = "".
       
       /*IF (r-INDEX(nv_address,"�.")) > (r-INDEX(nv_address,"�.")) THEN DO:*/
       IF r-INDEX(nv_address,"�.") <> 0 THEN DO: 
               ASSIGN 
                nv_tam  = SUBSTR(nv_address,r-INDEX(nv_address,"�."))
                brstat.tlt.ins_addr1 = SUBSTR(nv_address,1,r-INDEX(nv_address,"�.") - 1  ).
       END.
       /* A60-0542*/
       ELSE IF r-INDEX(nv_address,"�Ӻ�") <> 0 THEN DO: 
              ASSIGN 
                  nv_tam  = SUBSTR(nv_address,r-INDEX(nv_address,"�Ӻ�"))
                  brstat.tlt.ins_addr1 = SUBSTR(nv_address,1,r-INDEX(nv_address,"�Ӻ�") - 1  ).
       END.
       /* end : A60-0542*/
       ELSE IF r-INDEX(nv_address,"�ǧ") <> 0 THEN DO: 
               nv_tam = SUBSTR(nv_address,r-INDEX(nv_address,"�ǧ")).
               brstat.tlt.ins_addr1 = SUBSTR(nv_address,1,r-INDEX(nv_address,"�ǧ") - 1  ).
       END. 
       /*END.*/
       IF r-INDEX(nv_address,"�.") <> 0 THEN DO: 
               nv_amp = SUBSTR(nv_address,R-INDEX(nv_address,"�.")).
               brstat.tlt.ins_addr2 = SUBSTR(nv_address,1,R-INDEX(nv_address,"�.") - 1 ).
       END.
        /* A60-0542*/
       ELSE IF r-INDEX(nv_address,"�����") <> 0 THEN DO: 
           ASSIGN
               nv_amp  = SUBSTR(nv_address,r-INDEX(nv_address,"�����"))
               brstat.tlt.ins_addr2 = SUBSTR(nv_address,1,r-INDEX(nv_address,"�����") - 1  ).
       END.
       /* end : A60-0542*/
       ELSE IF r-INDEX(nv_address,"ࢵ") <> 0  THEN DO:
               nv_amp = SUBSTR(nv_address,r-INDEX(nv_address,"ࢵ")).
               brstat.tlt.ins_addr2 = SUBSTR(nv_address,1,r-INDEX(nv_address,"ࢵ") - 1 ).
       END.
       
       IF R-INDEX(nv_tam,"�.") <> 0  THEN brstat.tlt.ins_addr2 = SUBSTR(nv_tam,1,INDEX(nv_tam, "�.") - 1).
       IF R-INDEX(nv_tam,"�����") <> 0  THEN brstat.tlt.ins_addr2 = SUBSTR(nv_tam,1,INDEX(nv_tam, "�����") - 1). /*A60-0542*/
       IF R-INDEX(nv_tam,"ࢵ") <> 0 THEN brstat.tlt.ins_addr2 = SUBSTR(nv_tam,1,INDEX(nv_tam, "ࢵ") - 1).

       brstat.tlt.ins_addr3 = SUBSTR(nv_amp,1,INDEX(nv_amp, " ")).
       nv_prov = TRIM(SUBSTR(nv_address,INDEX(nv_address,brstat.tlt.ins_addr3) + LENGTH(brstat.tlt.ins_addr3),25)).
       brstat.tlt.ins_addr4 = TRIM(SUBSTR(nv_prov,1,R-INDEX(nv_prov," "))).
       brstat.tlt.ins_addr5 = TRIM(SUBSTR(nv_prov,R-INDEX(nv_prov, " "))).

       /* add A64-0060 */
       IF index(brstat.tlt.ins_addr2,"�Ӻ�")  <> 0   THEN ASSIGN brstat.tlt.ins_addr2 = TRIM(REPLACE(brstat.tlt.ins_addr2,"�Ӻ�","�.")).
       IF index(brstat.tlt.ins_addr3,"�����") <> 0   THEN ASSIGN brstat.tlt.ins_addr3 = TRIM(REPLACE(brstat.tlt.ins_addr3,"�����","�.")).
       IF index(brstat.tlt.ins_addr4,"�ѧ��Ѵ") <> 0 THEN ASSIGN brstat.tlt.ins_addr4 = TRIM(REPLACE(brstat.tlt.ins_addr4,"�ѧ��Ѵ","�.")).

       IF index(brstat.tlt.ins_addr4,"�.") = 0 AND (index(brstat.tlt.ins_addr4,"���") = 0 AND index(brstat.tlt.ins_addr4,"��ا෾") = 0 )
       THEN ASSIGN brstat.tlt.ins_addr4 = "�." + TRIM(brstat.tlt.ins_addr4).

       IF index(brstat.tlt.ins_addr1,"���")  <> 0 THEN brstat.tlt.ins_addr1 = TRIM(REPLACE(brstat.tlt.ins_addr1,"���","�.")) .
       IF index(brstat.tlt.ins_addr1,"���")  <> 0 THEN brstat.tlt.ins_addr1 = TRIM(REPLACE(brstat.tlt.ins_addr1,"���","�.")) .
       IF index(brstat.tlt.ins_addr1,"����") <> 0 THEN brstat.tlt.ins_addr1 = TRIM(REPLACE(brstat.tlt.ins_addr1,"����","�.")) .

       IF index(brstat.tlt.ins_addr1,"���") <> 0 THEN DO:
           ASSIGN nv_road = SUBSTR(brstat.tlt.ins_addr1,r-INDEX(brstat.tlt.ins_addr1,"���"))
                  brstat.tlt.ins_addr1 = SUBSTR(brstat.tlt.ins_addr1,1,r-INDEX(brstat.tlt.ins_addr1,"���") - 1  ).
       END.
       ELSE IF index(brstat.tlt.ins_addr1,"�.") <> 0 THEN DO:
           ASSIGN nv_road = SUBSTR(brstat.tlt.ins_addr1,r-INDEX(brstat.tlt.ins_addr1,"�."))
                  brstat.tlt.ins_addr1 = SUBSTR(brstat.tlt.ins_addr1,1,r-INDEX(brstat.tlt.ins_addr1,"�.") - 1  ).
       END.
       IF index(brstat.tlt.ins_addr1,"���") <> 0 THEN DO:
           ASSIGN nv_soi = SUBSTR(brstat.tlt.ins_addr1,r-INDEX(brstat.tlt.ins_addr1,"���"))
                  brstat.tlt.ins_addr1 = SUBSTR(brstat.tlt.ins_addr1,1,r-INDEX(brstat.tlt.ins_addr1,"���") - 1  ).
       END.
       ELSE IF index(brstat.tlt.ins_addr1,"�.") <> 0 THEN DO:
           ASSIGN nv_soi = SUBSTR(brstat.tlt.ins_addr1,r-INDEX(brstat.tlt.ins_addr1,"�."))
                  brstat.tlt.ins_addr1 = SUBSTR(brstat.tlt.ins_addr1,1,r-INDEX(brstat.tlt.ins_addr1,"�.") - 1  ).
       END.
       IF index(brstat.tlt.ins_addr1,"����") <> 0 THEN DO:
           ASSIGN nv_moo = SUBSTR(brstat.tlt.ins_addr1,r-INDEX(brstat.tlt.ins_addr1,"����"))
                  brstat.tlt.ins_addr1 = SUBSTR(brstat.tlt.ins_addr1,1,r-INDEX(brstat.tlt.ins_addr1,"����") - 1  ).
       END.
       ELSE IF index(brstat.tlt.ins_addr1,"�.") <> 0 THEN DO:
           ASSIGN nv_moo = SUBSTR(brstat.tlt.ins_addr1,r-INDEX(brstat.tlt.ins_addr1,"�."))
                  brstat.tlt.ins_addr1 = SUBSTR(brstat.tlt.ins_addr1,1,r-INDEX(brstat.tlt.ins_addr1,"�.") - 1  ).
       END.

       IF trim(nv_moo)  =  "�."  THEN nv_moo = "" .
       ELSE IF index(nv_moo,"����") <> 0 THEN nv_moo = trim(replace(nv_moo,"����","�.")) .

       IF trim(nv_soi)  =  "�."  THEN nv_soi  = "" .
       ELSE IF index(nv_soi,"���")  <> 0 THEN nv_soi  = trim(replace(nv_soi,"���","�."))  .

       IF trim(nv_road) =  "�."  THEN nv_road = "" .
       ELSE IF index(nv_road,"���") <> 0 THEN nv_road  = trim(replace(nv_road,"���","�.")) .

       ASSIGN brstat.tlt.ins_addr1 = trim(brstat.tlt.ins_addr1 + " " + TRIM(nv_moo) + " " + TRIM(nv_soi) + " " + TRIM(nv_road)) .
       /* end A64-0060 */

       ASSIGN 
       wdetail.ADDRESS  = brstat.tlt.ins_addr1
       wdetail.ADDRESS2 = brstat.tlt.ins_addr2
       wdetail.ADDRESS3 = brstat.tlt.ins_addr3
       wdetail.ADDRESS4 = brstat.tlt.ins_addr4
       wdetail.ADDRESS5 = brstat.tlt.ins_addr5.
       /*End Jiraphon A59-0451*/
  END.  
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat44 c-wins 
PROCEDURE proc_reportmat44 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_countdata     = 0  .
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .
        EXPORT DELIMITER "|" 
            wdetail.SEQ            /*  1   SEQ             */              
            wdetail.INSURANCECODE  /*  2   INSURANCECODE   */  
            wdetail.CONTRACTNO     /*  3   CONTRACTNO      */      
            wdetail.BRANCHCODE     /*  4   BRANCHCODE      */      
            wdetail.BRANCHNO       /*  5   BRANCHNO        */      
            wdetail.policy
            wdetail.branch
            wdetail.STICKERNO      /*  6   STICKERNO       */      
            wdetail.CUSTOMERNAME   /*  7   CUSTOMERNAME    */      
            /*Add Jiraphon A59-0451*/
            wdetail.ADDRESS  
            wdetail.ADDRESS2 
            wdetail.ADDRESS3 
            wdetail.ADDRESS4 
            wdetail.ADDRESS5 
            /*End Jiraphon A59-0451*/
            wdetail.CARNO          /*  9   CARNO           */
            wdetail.MODCOD    /*A59-0069*/
            wdetail.BRAND          /*  10  BRAND           */          
            wdetail.MODEL          /*  11  MODEL           */          
            wdetail.CC             /*  12  CC              */              
            wdetail.REGISTRATION   /*  13  REGISTRATION    */  
            wdetail.PROVINCE       /*  14  PROVINCE        */      
            wdetail.BODY           /*  15  BODY            */          
            wdetail.ENGINE         /*  16  ENGINE          */          
            wdetail.STARTDATE      /*  17  STARTDATE       */      
            wdetail.ENDDATE        /*  18  ENDDATE         */          
            wdetail.NETINCOME      /*  19  NETINCOME       */      
            wdetail.TOTALINCOME    /*  20  TOTALINCOME     */      
            wdetail.CARDID         /*  21  CARDID          */ 
            wdetail.producer      /*A59-0069*/
            wdetail.agent         /*A59-0069*/
            wdetail.camp_cj   /*A60-0542*/
            wdetail.nstatus      /*Jiraporn A59-0342*/
            wdetail.n_memmopremium.
            
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat5 c-wins 
PROCEDURE proc_reportmat5 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail WHERE wdetail.policy  <> "" .
    ASSIGN fi_process2 =  "Process data match Aycal/KPI : " + wdetail.policy .
    DISP fi_process2 WITH FRAM fr_main.  
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
       (tlt.recac        = trim(wdetail.Contract)  OR
        tlt.nor_noti_tlt = trim(wdetail.policy)    OR
        tlt.lince1       = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) OR
        tlt.cha_no       = trim(wdetail.chassis)  ) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF NOT AVAIL tlt THEN  DELETE wdetail.
END.
RUN proc_reporttitle.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat55 c-wins 
PROCEDURE proc_reportmat55 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.
FOR EACH wdetail  NO-LOCK .
    ASSIGN nv_countdata     = nv_countdata  + 1 .
    FIND LAST tlt   Where
       (tlt.recac        = trim(wdetail.Contract)  OR
        tlt.nor_noti_tlt = trim(wdetail.policy)    OR
        tlt.lince1       = trim(wdetail.vehreg) + " " +  trim(wdetail.provin) OR
        tlt.cha_no       = trim(wdetail.chassis)  ) AND 
        tlt.genusr   =  "aycal"               NO-LOCK NO-ERROR . 
    IF AVAIL tlt THEN DO:
        ASSIGN nv_countcomplete = nv_countcomplete + 1
        n_record =  n_record + 1 
        np_title = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,1,index(tlt.ins_name," ") - 1 )  ELSE "�س"
        np_name  = IF index(tlt.ins_name," ") <> 0 THEN SUBSTR(tlt.ins_name,index(tlt.ins_name," ") + 1 ) ELSE tlt.ins_name
        np_name2 = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,index(np_name," ") + 1 )   ELSE tlt.ins_name
        np_name  = IF index(np_name," ") <> 0 THEN SUBSTR(np_name,1,index(np_name," ") - 1 )  ELSE tlt.ins_name.
        
        EXPORT DELIMITER "|" 
            n_record                                           /*  1  �ӴѺ���     */             
            string(tlt.datesent,"99/99/9999") FORMAT "x(10)"   /*  2  �ѹ�����   */            
            tlt.nor_noti_tlt               /*  3  �Ţ�Ѻ��   */           
            caps(TRIM(tlt.comp_usr_tlt))   /*  4  Branch       */           
            trim(tlt.recac)                /*  5  Contract     */           
            trim(np_title)                 /*  6  �ӹ�˹�Ҫ��� */           
            trim(np_name)                  /*  7  ����         */           
            trim(np_name2)                 /*  8  ���ʡ��      */           
            trim(tlt.ins_addr1)               FORMAT "x(50)"                /*  9  ������� 1    */           
            trim(tlt.ins_addr2)               FORMAT "x(40)"                /*  10 ������� 2    */           
            trim(tlt.ins_addr3)               FORMAT "x(40)"                /*  11 ������� 3    */           
            trim(tlt.ins_addr4) + " " + trim(tlt.ins_addr5) FORMAT "x(40)"  /*  12 ������� 4    */           
            tlt.brand               /*  13 ������ö     */           
            tlt.model               /*  14 ���ö       */           
            tlt.lince1              /*  15 �Ţ����¹   */           
            tlt.lince2              /*  16 ��ö         */           
            tlt.cc_weight           /*  17 CC.          */           
            tlt.cha_no              /*  18 �Ţ��Ƕѧ    */           
            tlt.eng_no              /*  19 �Ţ����ͧ   */           
            tlt.comp_noti_tlt       /*  20 Code ����� */           
            tlt.safe3               /*  21 ������       */           
            tlt.nor_usr_ins         /*  22 Code �.��Сѹ        */  
            tlt.nor_noti_ins        /*  23 �Ţ�����������      */ 
            tlt.safe2
            IF tlt.nor_effdat = ? THEN "" ELSE string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" /*  24 �ѹ������ͧ��Сѹ    */
            IF tlt.expodat = ? THEN "" ELSE string(tlt.expodat,"99/99/9999") FORMAT "x(10)"    /*  25 �ѹ�����Сѹ         */   
            tlt.comp_coamt         /*  26 �ع��Сѹ    */           
            DECI(tlt.dri_name2)    /*  27 ��������ط��� */         
            tlt.nor_grprm          /*  28 ���������������ҡ� */    
            tlt.seqno              /*  29 Deduct       */           
            tlt.nor_usr_tlt        /*  30 Code �.��Сѹ �ú.   */   
            IF tlt.comp_effdat = ? THEN "" ELSE string(tlt.comp_effdat,"99/99/9999")  FORMAT "x(10)"  /*  31 �ѹ������ͧ�ú.*/   
            IF tlt.dat_ins_noti = ? THEN "" ELSE string(tlt.dat_ins_noti,"99/99/9999") FORMAT "x(10)"  /*  32 �ѹ����ú.   */           
            deci(tlt.dri_no1)   /*  33 ��Ҿú.      */           
            tlt.dri_name1       /*  34 �кؼ��Ѻ���        */   
            tlt.stat            /*  35 ������ҧ     */           
            tlt.safe1           /*  36 ������ͧ�ػ�ó��������*/
            tlt.filler1         /*  37 ��䢷������    */        
            tlt.comp_usr_ins    /*  38 ����Ѻ�Ż���ª�� */       
            tlt.OLD_cha         /*  39 �����˵� */               
            tlt.OLD_eng         /*  40 complete/not complete */  
            tlt.releas          /*  41 Yes/No . */ 
            wdetail.premtnet      /*  �������    */
            wdetail.recivedat.    /*  ��������ش  */
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportnotcom c-wins 
PROCEDURE proc_reportnotcom :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_outputerr AS CHAR .

ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_inputfile,length(fi_inputfile) - 3,4) <>  ".csv"  THEN 
    nv_outputerr  =  Trim(fi_filename) + ".csv"  .
ELSE  nv_outputerr = substr(fi_inputfile,1,length(fi_inputfile) - 4) +  "_outerr.csv" .  

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(nv_outputerr). 
EXPORT DELIMITER "|" 
    "�����ŧҹ�Ѻ��Сѹ��� AYCL" .
EXPORT DELIMITER "|" 
    "�ӴѺ���"  
    "�ѹ����� "
    "�Ţ�Ѻ�� "
    "Branch     "
    "Contract   "
    "�ӹ�˹�Ҫ���"
    "����"  
    "���ʡ��"  
    "������� 1   "
    "������� 2   "  
    "������� 3   "  
    "������� 4   "  
    "������ö   "
    "���ö     "
    "�Ţ����¹ "
    "��ö       "
    "CC.        "
    "�Ţ��Ƕѧ  "
    "�Ţ����ͧ "
    "Code �����       "
    "������     "
    "Code �.��Сѹ      "
    "�Ţ�����������    "
    "�ѹ������ͧ��Сѹ  "
    "�ѹ�����Сѹ       "
    "�ع��Сѹ  "
    "��������ط���     "
    "���������������ҡ�        "   
    "Deduct     "
    "Code �.��Сѹ �ú. "
    "�ѹ������ͧ�ú.    "
    "�ѹ����ú. "
    "��Ҿú.    "
    "�кؼ��Ѻ���      "
    "������ҧ   "
    "������ͧ�ػ�ó��������   "
    "��䢷������       "
    "����Ѻ�Ż���ª��" 
    "�����˵�"                           
    "complete/not complete"
    "Yes/No" .  
RUN proc_reportfileerr.

Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reporttitle c-wins 
PROCEDURE proc_reporttitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
    fi_outfile  =  Trim(fi_outfile) + "_mat.csv"  .
ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outfile). 
/* Comment Jiraporn A59-0342
EXPORT DELIMITER "|" 
    "Match file KPN_Aycal Comulsory" .
*/    
EXPORT DELIMITER "|" 
    "SEQ"   
    "INSURANCECODE"   
    "CONTRACTNO"   
    "BRANCHCODE"   
    "BRANCHNO " 
    "POLICY_COMP" 
    "Branch"
    "STICKERNO"   
    "CUSTOMERNAME"   
    "ADDRESS"
    /*Add Jiraphon A59-0451*/
    "ADDRESS2"
    "ADDRESS3"
    "ADDRESS4"
    "ADDRESS5"
    /*end Jiraphon A59-0451*/
    "CARNO"
    "MODCOD"
    "BRAND"   
    "MODEL"   
    "CC"   
    "REGISTRATION "   
    "PROVINCE"
    "BODY"   
    "ENGINE"   
    "STARTDATE"   
    "ENDDATE"   
    "NETINCOME"   
    "TOTALINCOME"   
    "CARDID"
    "PRODUCER CODE"
    "AGENT CODE"
    "Campaign_CJ"  /*A60-0542*/
    "Status"
    "Remark".
    
  
RUN proc_reportmat44.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_running01 c-wins 
PROCEDURE proc_running01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*check �Ţ running*/
DEFINE VAR n_lopcnt AS INTE.
loop_run01:
REPEAT:

    n_lopcnt = n_lopcnt + 1.
    IF n_lopcnt = 10 THEN LEAVE loop_run01.

    FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE       /*check �Ѻ premium 17.14.01*/
               stat.polno_fil.DIR_ri   = YES        AND
               stat.polno_fil.poltyp   = "V72"      AND
               stat.polno_fil.branch   = nv_brnno   AND
               stat.polno_fil.undyr    = STRING(YEAR(TODAY) + 543,"9999") AND
               stat.polno_fil.brn_pol  = nv_brnpol  AND
               stat.polno_fil.start_no = nv_startno EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL stat.polno_fil THEN DO:
        IF LOCKED stat.polno_fil THEN DO:
            RETURN.
        END.
    
        CREATE stat.polno_fil.
        ASSIGN
            stat.polno_fil.dir_ri   = YES
            stat.polno_fil.poltyp   = "V72"
            stat.polno_fil.branch   = nv_brnno
            stat.polno_fil.brn_pol  = nv_brnpol
            stat.polno_fil.undyr    = STRING(YEAR(TODAY) + 543,"9999")
            stat.polno_fil.START_no = nv_startno.
            stat.polno_fil.nextno   = 1.
    
        nv_polno = 1.
    
    END.
    ELSE DO:
        nv_polno = stat.polno_fil.nextno.
    END.
    
    nv_year = SUBSTR(STRING(YEAR(TODAY) + 543),3,2).
    
    IF LENGTH(nv_brnpol) = 1 THEN DO:
        wdetail.policy = "D".
    END.
    ELSE wdetail.policy = "" . /*A64-0060*/
    
    IF nv_startno = "" THEN DO:
        wdetail.policy = TRIM(wdetail.policy) 
                       + TRIM(nv_brnpol)
                       + "72"
                       + nv_year
                       + STRING(nv_polno,"9999").
    END.
    ELSE IF LENGTH(TRIM(nv_startno)) = 1 THEN DO:
        wdetail.policy = TRIM(wdetail.policy)
                       + TRIM(nv_brnpol) + "72"
                       + nv_year
                       + TRIM(nv_startno)
                       + STRING(nv_polno,"99999").
    END.
    ELSE IF LENGTH(TRIM(nv_startno)) = 2 THEN DO:
        wdetail.policy = TRIM(wdetail.policy)
                       + TRIM(nv_brnpol) + "72"
                       + nv_year
                       + TRIM(nv_startno)
                       + STRING(nv_polno,"9999").
    END.                                         
    ELSE DO:
        wdetail.policy = TRIM(wdetail.policy)
                       + TRIM(nv_brnpol) + "72"
                       + nv_year
                       + STRING(nv_polno,"999999").
    END.
    RELEASE stat.polno_fil.
    IF LENGTH(wdetail.policy) = 12 THEN DO:  /*check �Ţ�������� 12 ��ѡ*/
        IF wdetail.policy <> wdetail.policy  THEN DO:  /*PUI*/
        /*-- ��Ǩ�ͺ�������� �Ѻ��к� premium--*/
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                      sicuw.uwm100.policy = TRIM(wdetail.policy) NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicuw.uwm100 THEN DO:
                FIND FIRST brstat.tlt WHERE 
                           brstat.tlt.cha_no = STRING(DECI(TRIM(wdetail.STICKERNO))) AND
                           brstat.tlt.genusr = "aycal72" NO-ERROR NO-WAIT.
                IF AVAIL brstat.tlt THEN DO:
                    IF brstat.tlt.nor_noti_tlt = "" THEN DO:
                        ASSIGN
                            brstat.tlt.nor_noti_tlt = wdetail.policy
                            brstat.tlt.comp_usr_tlt = wdetail.branch.
                    END.
                    ELSE DO: 
                        IF brstat.tlt.releas = "Yes" THEN DO:
                            wdetail.n_memmopremium = "�Ţʵ������١������� " + brstat.tlt.nor_noti_tlt.
                        END.
                    END.
                END.
                RELEASE brstat.tlt.
                wdetail.n_memmopremium = "".
                LEAVE loop_run01.
            END.
            ELSE DO: 
                wdetail.n_memmopremium = "�Ţ��������١������� " + wdetail.policy.
                /*-- Update Running Policy --*/
                FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
                           stat.polno_fil.DIR_ri   = YES        AND
                           stat.polno_fil.poltyp   = "V72"      AND
                           stat.polno_fil.branch   = nv_brnno   AND
                           stat.polno_fil.undyr    = STRING(YEAR(TODAY) + 543,"9999") AND
                           stat.polno_fil.brn_pol  = nv_brnpol  AND
                           stat.polno_fil.start_no = nv_startno EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
                IF AVAIL stat.polno_fil THEN DO:
                    stat.polno_fil.nextno = stat.polno_fil.nextno + 1.
                END.
            END.
        END.  /*PUI*/
    END.
    ELSE DO:
        wdetail.n_memmopremium = "�������������ҡѺ 12 ��ѡ " + wdetail.policy.
        LEAVE loop_run01.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_SEARCH1 c-wins 
PROCEDURE proc_SEARCH1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    IF  cb_search =  "�Ţ��Ƕѧö"  THEN DO: 
        FIND LAST brstat.tlt WHERE
                 brstat.tlt.genusr    = "AYCAL72"   AND 
                 brstat.tlt.comp_sck  = TRIM(fi_search) NO-LOCK NO-ERROR .
        IF AVAIL brstat.tlt THEN DO:
            FOR EACH brstat.tlt WHERE
                     brstat.tlt.genusr    = "AYCAL72"   AND 
                     brstat.tlt.comp_sck  = TRIM(fi_search) NO-LOCK:
            
                ASSIGN nv_rectlt =  RECID(brstat.tlt).
            
                CREATE brtlt.
                ASSIGN
                    brtlt.releas       = tlt.releas      
                    brtlt.trndat       = tlt.trndat      
                    brtlt.entdat       = tlt.entdat      
                    brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                    brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                    brtlt.cha_no       = tlt.cha_no      
                    brtlt.safe2        = tlt.safe2       
                    brtlt.filler2      = tlt.filler2     
                    brtlt.endno        = tlt.endno
                    brtlt.lotno         = tlt.lotno         
                    brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                    brtlt.colorcod      = tlt.colorcod      
                    brtlt.subins        = tlt.subins        
                    brtlt.ins_name      = tlt.ins_name      
                    brtlt.recac         = tlt.recac         
                    brtlt.ins_addr1     = tlt.ins_addr1
                    /*Add Jiraphon A59-0451*/
                    brtlt.ins_addr2     = tlt.ins_addr2
                    brtlt.ins_addr3     = tlt.ins_addr3
                    brtlt.ins_addr4     = tlt.ins_addr4
                    brtlt.ins_addr5     = tlt.ins_addr5
                    /*Edd Jiraphon A59-0451*/
                    brtlt.comp_sub      = tlt.comp_sub      
                    brtlt.brand         = tlt.brand         
                    brtlt.model         = tlt.model         
                    brtlt.cc_weight     = tlt.cc_weight                      
                    brtlt.lince1        = tlt.lince1    
                    brtlt.lince2        = tlt.lince2
                    brtlt.lince3        = tlt.lince3  
                    brtlt.comp_sck      = tlt.comp_sck
                    brtlt.eng_no        = tlt.eng_no  
                    brtlt.nor_effdat    = tlt.nor_effdat    
                    brtlt.comp_effdat   = tlt.comp_effdat   
                    brtlt.comp_coamt    = tlt.comp_coamt    
                    brtlt.comp_grprm    = tlt.comp_grprm .   
                    /*brtlt.sentcnt     = tlt.sentcnt       */
            END.
        END.
    END.
    ELSE IF  cb_search =  "Release Cancel"  THEN DO:
        FIND LAST brstat.tlt WHERE
                 brstat.tlt.genusr  = "AYCAL72"   AND 
                 brstat.tlt.releas  = "CANCEL" NO-LOCK NO-ERROR .
        IF AVAIL brstat.tlt THEN DO:
        
            FOR EACH brstat.tlt WHERE
                     brstat.tlt.genusr  = "AYCAL72"   AND 
                     brstat.tlt.releas  = "CANCEL" NO-LOCK:
                ASSIGN nv_rectlt =  RECID(brstat.tlt).
                CREATE brtlt.
                ASSIGN
                    brtlt.releas       = tlt.releas      
                    brtlt.trndat       = tlt.trndat      
                    brtlt.entdat       = tlt.entdat      
                    brtlt.nor_noti_tlt = tlt.nor_noti_tlt
                    brtlt.comp_usr_tlt = tlt.comp_usr_tlt
                    brtlt.cha_no       = tlt.cha_no      
                    brtlt.safe2        = tlt.safe2       
                    brtlt.filler2      = tlt.filler2     
                    brtlt.endno        = tlt.endno
                    brtlt.lotno         = tlt.lotno         
                    brtlt.comp_noti_tlt = tlt.comp_noti_tlt 
                    brtlt.colorcod      = tlt.colorcod      
                    brtlt.subins        = tlt.subins        
                    brtlt.ins_name      = tlt.ins_name      
                    brtlt.recac         = tlt.recac         
                    brtlt.ins_addr1     = tlt.ins_addr1
                    /*Add Jiraphon A59-0451*/
                    brtlt.ins_addr2     = tlt.ins_addr2
                    brtlt.ins_addr3     = tlt.ins_addr3
                    brtlt.ins_addr4     = tlt.ins_addr4
                    brtlt.ins_addr5     = tlt.ins_addr5
                    /*End Jiraphon A59-0451*/
                    brtlt.comp_sub      = tlt.comp_sub      
                    brtlt.brand         = tlt.brand         
                    brtlt.model         = tlt.model         
                    brtlt.cc_weight     = tlt.cc_weight                      
                    brtlt.lince1        = tlt.lince1    
                    brtlt.lince2        = tlt.lince2
                    brtlt.lince3        = tlt.lince3  
                    brtlt.comp_sck      = tlt.comp_sck
                    brtlt.eng_no        = tlt.eng_no  
                    brtlt.nor_effdat    = tlt.nor_effdat    
                    brtlt.comp_effdat   = tlt.comp_effdat   
                    brtlt.comp_coamt    = tlt.comp_coamt    
                    brtlt.comp_grprm    = tlt.comp_grprm .   
                    /*brtlt.sentcnt     = tlt.sentcnt       */
            END.
        END.
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
Open Query br_tlt 
    For each brtlt Use-index  tlt01 NO-LOCK 
    WHERE 
    brtlt.trndat         >=  fi_trndatfr   And
    brtlt.trndat         <=  fi_trndatto   And
    brtlt.genusr   =  "phone"         .
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE update_cancel c-wins 
PROCEDURE update_cancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN 
    nv_countdata     = 0
    nv_countcomplete = 0 
    n_record         = 0.

FOR EACH wdetail WHERE wdetail.SEQ  <> "" :

    ASSIGN fi_process2 =  "Process data match Aycal/KPI Comulsory : " + wdetail.policy .
    DISP fi_process2  WITH FRAM fr_main.  

    ASSIGN nv_countdata = nv_countdata  + 1.

   
    FIND LAST brstat.tlt USE-INDEX tlt06 WHERE
              brstat.tlt.cha_no = STRING(DECI(TRIM(wdetail.STICKERNO))) AND 
              brstat.tlt.genusr = "aycal72"                             NO-LOCK NO-ERROR.
    IF AVAIL brstat.tlt THEN DO:
        IF wdetail.branchcode = "" THEN DO:
            wdetail.n_memmopremium = "Branch Code Not Avaliable".
        END.
        IF wdetail.brand <> "" THEN DO:
            FIND FIRST sicsyac.xmm102 WHERE INDEX(sicsyac.xmm102.moddes,TRIM(wdetail.brand)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm102 THEN DO:
                wdetail.modcod = sicsyac.xmm102.modcod.
            END.
            ELSE wdetail.modcod = "".
        END.

        ASSIGN
            wdetail.producer = fi_producer
            wdetail.agent    = fi_agent.

        IF wdetail.BRANCHNO = "�ӹѡ�ҹ�˭�" THEN DO:
            IF fi_producer = "" THEN wdetail.producer = "B3MLAY0104" . /*"A0M0061".*/ /*A64-0060*/
                                ELSE wdetail.producer = fi_producer.
            /*IF fi_agent = "" THEN wdetail.agent = "B300303".*/ /*A64-0060*/
            IF fi_agent = "" THEN wdetail.agent = "B3MLAY0100". /*A64-0060*/
                             ELSE wdetail.agent = fi_agent.
        END.
        ELSE DO:
            nv_cha_no = TRIM(wdetail.body).

            IF fi_producer = "" THEN DO:
                FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE  /*��� INDEX �ҡ uwm30101*/
                          sicuw.uwm301.trareg = nv_cha_no AND
                   SUBSTR(sicuw.uwm301.policy,3,2) = "72" NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm301 THEN DO:
                    wdetail.n_memmopremium = "������� " + sicuw.uwm301.policy. 
                    /* comment by : A64-0060 ...
                    IF fi_producer = "" THEN wdetail.producer = "A0M0018".
                    IF fi_agent    = "" THEN wdetail.agent = "B300303".
                    end : A64-0060...*/
                    /* add by : A64-0060 */
                    IF fi_producer = "" THEN wdetail.producer = "B3MLAY0101".
                    IF fi_agent    = "" THEN wdetail.agent    = "B3MLAY0100".
                    /*end : A64-0060...*/
                END.
                ELSE DO:
                    /* comment by : A64-0060 ...
                    IF fi_producer = "" THEN wdetail.producer = "A0M0019".
                    IF fi_agent    = "" THEN wdetail.agent = "B300303".
                    end : A64-0060...*/
                    /* add by : A64-0060 */
                    IF fi_producer = "" THEN wdetail.producer = "B3MLAY0102".   
                    IF fi_agent    = "" THEN wdetail.agent    = "B3MLAY0100".   
                    /*end : A64-0060...*/
                END. 
            END.
            ELSE DO:
                wdetail.producer = fi_producer.
                IF fi_agent <> "" THEN wdetail.agent = fi_agent.
                                  /*ELSE wdetail.agent = "B300303".*/ /*a64-0060*/
                                  ELSE wdetail.agent    = "B3MLAY0100". /*A64-0060*/
            END.
        END.

        /*-- Check Branch --*/
        FIND FIRST stat.insure USE-INDEX insure03 WHERE
                   stat.insure.compno = "AYCAL" AND
                   stat.insure.insno  = wdetail.branchcode NO-LOCK NO-ERROR.
        IF AVAIL stat.insure THEN DO:
            wdetail.branch = stat.insure.branch.
        END.
        ELSE wdetail.n_memmopremium = "Branch �繤����ҧ �������ö������к���".
 
        IF wdetail.branch = "" THEN wdetail.n_memmopremium = "Branch �繤����ҧ �������ö������к���".
 
        FIND FIRST brstat.tlt WHERE
                   brstat.tlt.cha_no = STRING(DECI(TRIM(wdetail.STICKERNO))) AND
                   brstat.tlt.genusr = "aycal72" NO-ERROR NO-WAIT.
        IF AVAIL brstat.tlt THEN DO:
            IF brstat.tlt.nor_noti_tlt <> "" THEN DO:
                IF brstat.tlt.releas = "NO" THEN DO:
                    ASSIGN
                        wdetail.policy = brstat.tlt.nor_noti_tlt
                        wdetail.branch = brstat.tlt.comp_usr_tlt
                        wdetail.n_memmopremium = "Yes".
                END.
                ELSE DO:
                    wdetail.n_memmopremium = "�Ţʵ������١������� " + brstat.tlt.nor_noti_tlt.
                END.
            END.
        END.

        IF brstat.tlt.releas <> "Yes" THEN DO:  
            /*Update Cancel*/
           IF wdetail.nstatus = "cancel"  THEN DO:
               RUN data.
               wdetail.n_memmopremium = "Complete".
           END.           
           /*Update Yes*/          
           ELSE IF wdetail.nstatus = "yes" THEN DO:
               FIND LAST sicuw.uwm100 WHERE uwm100.policy = wdetail.policy NO-LOCK NO-ERROR.
               IF AVAIL sicuw.uwm100 THEN DO:
                  RUN data.
                  wdetail.n_memmopremium = "Complete".
                  nv_countcomplete = nv_countcomplete + 1.
               END.
               ELSE DO:
                  wdetail.n_memmopremium = "��辺�Ţ����������к� | " + brstat.tlt.nor_noti_tlt.
                  wdetail.nstatus = "No".
               END.
           END.
           ELSE DO:
                wdetail.n_memmopremium = "PleaseCheck Status Again".
                wdetail.nstatus = "No".
           END.          
        END.
    END.
END.

RUN proc_reporttitle.
END PROCEDURE.


DEF BUFFER bftlt FOR brstat.tlt. /*A64-0060*/
PROCEDURE data :
    IF brstat.tlt.releas <> "Yes" THEN DO:
     IF brstat.tlt.cha_no = wdetail.STICKERNO THEN DO: 
         ASSIGN
             brstat.tlt.lotno         = TRIM(wdetail.INSURANCECODE).
             brstat.tlt.comp_noti_tlt = TRIM(wdetail.CONTRACTNO).
             brstat.tlt.colorcod      = TRIM(wdetail.BRANCHCODE).
             brstat.tlt.subins        = TRIM(wdetail.BRANCHNO).
             brstat.tlt.ins_name      = TRIM(wdetail.CUSTOMERNAME).
             brstat.tlt.recac         = TRIM(wdetail.CARDID).
             brstat.tlt.ins_addr1     = TRIM(wdetail.ADDRESS).
             /*Add Jiraphon A59-0451*/
             brstat.tlt.ins_addr2     = TRIM(wdetail.ADDRESS2).
             brstat.tlt.ins_addr3     = TRIM(wdetail.ADDRESS3).
             brstat.tlt.ins_addr4     = TRIM(wdetail.ADDRESS4).
             brstat.tlt.ins_addr5     = TRIM(wdetail.ADDRESS5).
             /*End Jiraphon A59-0451*/
             brstat.tlt.comp_sub      = TRIM(wdetail.CARNO).
             brstat.tlt.brand         = TRIM(wdetail.BRAND).
             brstat.tlt.model         = TRIM(wdetail.MODEL).
             brstat.tlt.cc_weight     = INTE(TRIM(wdetail.CC)).
             brstat.tlt.lince1        = TRIM(wdetail.REGISTRATION).
             
    
             IF wdetail.REGISTRATION  = "" THEN wdetail.PROVINCE      = "".
             IF brstat.tlt.lince1     = "" THEN brstat.tlt.lince1     = SUBSTR(wdetail.body,(LENGTH(wdetail.body) - 9) + 1,LENGTH(wdetail.body)).  
             
             brstat.tlt.lince2        = TRIM(wdetail.PROVINCE).
             brstat.tlt.comp_sck      = TRIM(wdetail.BODY).      
             brstat.tlt.eng_no        = TRIM(wdetail.ENGINE).  
             brstat.tlt.nor_effdat    = DATE(TRIM(wdetail.startdate)).      
             brstat.tlt.comp_effdat   = DATE(TRIM(wdetail.enddate)).  
             brstat.tlt.comp_coamt    = DECI(TRIM(wdetail.NETINCOME)).         
             brstat.tlt.comp_grprm    = DECI(TRIM(wdetail.TOTALINCOME)).
             brstat.tlt.releas        = wdetail.nstatus.   
            /* Add by : A64-0060*/
            FIND FIRST bftlt USE-INDEX tlt06   WHERE   
             index(bftlt.cha_no,brstat.tlt.cha_no) <> 0  AND 
             bftlt.genusr   <> "AYCAL72"        AND 
             bftlt.genusr   =  fi_producer NO-ERROR NO-WAIT .
             IF AVAIL bftlt THEN DO: 
                ASSIGN bftlt.releas  = wdetail.nstatus.
             END.
            /* end :A64-0060*/
      END. 
    END.
    FIND FIRST brstat.insure USE-INDEX insure01 WHERE brstat.tlt.lince2 = brstat.insure.FName NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO: 
        IF brstat.tlt.lince2 <> "" THEN brstat.tlt.lince3 = brstat.tlt.lince1 + " " + brstat.insure.LName.
        ELSE IF brstat.tlt.lince2 = "" THEN brstat.tlt.lince3 = "/" + brstat.tlt.lince1.
    
        IF brstat.tlt.lince3 <> "" THEN wdetail.registration = brstat.tlt.lince3.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

