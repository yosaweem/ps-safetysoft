&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/*************************************************************************
  program id   : wgwrklex.w
  program name : Load text file K-Leasing to excel file     
  create by    : Kridtiya i. A57-0244 date. 07/07/2014
  copy write   : WUWHCTEX.W    
/*------------------------------------------------------------------------*/
Modify by : Ranu I. A58-0372  DATE.30/09/2015 
      - Create brInsure ใหม่ใช้ Freeform query โดยใช้ข้อมูลจาก brstat.insure 
        ที่เก็บไว้ที่ wcampaign
      - Check Branch จากชื่อที่ออกใบกำกับภาษีที่เซ็ทไว้ที่ stat.insure จาก
        stat.Insure.compno   = "K-LEASING"     
        stat.insure.Fname    = TRIM(im2text16) 
        stat.insure.Lname    = trim(im2text16) 
/*-----------------------------------------------------------------------*/
 Modify by : Ranu I. A59-0029 Date 04/02/2016 
        - เพิ่มตัวเลือก Type ที่หน้าจอรับข้อมูล Renew (New Form)
        - สร้างตัวแปรรับค่าข้อมูล งานต่ออายุฟอร์มใหม่ Wgwrklex.i 
        - create procedure PDCREATE3 , PDCLEAR2
/*---------------------------------------------------------------------*/
Modify by : Ranu I. A59-0182 Date 25/05/2016  เฉพาะงาน Renew (New form)
        - เพิ่มเติมช่อง BENEFICIARY(ผู้รับผลประโยชน์)
        - เก็บข้อมูลการจัดส่ง ใน (Memo Text หรือ Text F.8)    
        - เช็คสาขาจากเลขที่รับแจ้งตำแหน่งที่ 2,3 
        - ตรวจสอบเงื่อนไขการแสดงข้อมูล Pro-D ใน่ช่อง Promotion
        - เก็บข้อมูลในช่อง payment ไว้ที่ Product
        - เช็ค Garage = G 
        - เช็คการเก็บข้อมูลจากช่อง หมายเหตุ, ISP_NO , Campaign เนื่องจากเก็บข้อมูลไม่ครบ
---------------------------------------------------------------------*/
/*Modify by : Ranu I. A59-0604 09/12/2016
        -  ในกรณีที่แจ้งงานโอนย้ายหรือต่ออายุมาเป็นประเภท ป2+ / ป3+  ให้เช็คจากเบี้ยตามแคมเปญ  
           และให้ออกมาเป็น 2.2 กรณีที่เป็นป2+   และ 3.3 กรณีที่เป็น ป3+  ใช้ Producer code : B3M0045/B3M0025
        -  กรณีงานป้ายแดง ที่เป็นงานพรบ  แต่ในส่วนงานมอเตอร์ไซค์  ให้ออก พรบ. เป็นLine 74   
-------------------------------------------------------------------------------*/
/*Modify by : Ranu I. A62-0435 date 20/09/2019 
        - แก้ไขฟอร์แมตไฟล์แจ้งงานแบบใหม่ Renew(New Form) 
        -เพิ่มการเก็บข้อมูล PACKAGE_NAME จากไฟล์แจ้งงาน 
        -แก้ไขคำนำหน้าชื่อตามไฟล์แจ้งงาน
-----------------------------------------------------------------------------*/ 
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
DEF    STREAM ns1.
DEFINE STREAM  ns2.
DEFINE VAR nv_daily          AS CHARACTER FORMAT "X(2465)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt         AS INT  INIT  0.
DEFINE VAR nv_completecnt    AS INT  INIT  0.
DEFINE VAR nv_enttim         AS CHAR INIT  "".
DEF    VAR  nv_export        AS CHAR INIT  ""  FORMAT "X(8)".
DEF    STREAM  ns2.
DEF VAR  im1batchdat   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1applino    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1polclass   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1sumins     AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1netprm     AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1grossprm   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1effecdat   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1expirdat   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1trantyp    AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR  im1fleetflg   AS CHAR FORMAT "x(1)"   INIT "". 
DEF VAR  im1Tinsnam    AS CHAR FORMAT "x(40)"  INIT "". 
DEF VAR  im1Tintinam   AS CHAR FORMAT "x(40)"  INIT "". 
DEF VAR  im1Einsname   AS CHAR FORMAT "x(60)"  INIT "". 
DEF VAR  im1Eintinam   AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1Tlasnam    AS CHAR FORMAT "x(65)"  INIT "". 
DEF VAR  im1Elasnam    AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1moobarn    AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1room       AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR  im1HOME       AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR  im1moo        AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR  im1soi        AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1road       AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1tumbon     AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1amphur     AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1provice    AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR  im1postcard   AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR  im1telext     AS CHAR FORMAT "x(15)"  INIT "". 
DEF VAR  im1tal        AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR  im1fax        AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1occup      AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR  im1modepay    AS CHAR FORMAT "x(2)"   INIT "". 
DEF VAR  im1paycal     AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR  im1cardtyp    AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR  im1crecrad    AS CHAR FORMAT "x(16)"  INIT "". 
DEF VAR  im1cradins    AS CHAR FORMAT "x(5)"   INIT "". 
DEF VAR  im1cradexp    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR  im1detailno   AS CHAR FORMAT "x(20)"  INIT "".
/*impfile2*/
DEF VAR im2applino AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2seq     AS CHAR FORMAT "x(2)"   INIT "".   
DEF VAR im2typins  AS CHAR FORMAT "x(3)"   INIT "".   
DEF VAR im2CVMI    AS CHAR FORMAT "x(10)"  INIT "".   
DEF VAR im2package AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im2merch   AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2pattern AS CHAR FORMAT "x(10)"  INIT "".  
DEF VAR im2sumins  AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2YEAR    AS CHAR FORMAT "x(4)"   INIT "".   
DEF VAR im2make    AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im2model   AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im2engine  AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2cc      AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2seat    AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2tonnage AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2chassis AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2access  AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2polcmi  AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2sticker AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2instype AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2driver  AS CHAR FORMAT "x(1)"   INIT "".   
DEF VAR im2drinam1 AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im2dribht1 AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2driocc1 AS CHAR FORMAT "x(50)"  INIT "".   
DEF VAR im2driid1  AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2dricr1  AS CHAR FORMAT "x(20)"  INIT "".   
DEF VAR im2dridat1 AS CHAR FORMAT "x(10)"  INIT "".   
DEF VAR im2drimth1 AS CHAR FORMAT "x(10)"  INIT "".   
DEF VAR im2driyer1 AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2driage1 AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2drinam2 AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2dribht2 AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2driocc2 AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2driid2  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2dricr2  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2dridat2 AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2drimth2 AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2driyer2 AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2driage2 AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2aecsdes AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR im2lisen   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2lisenpr AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR im2discft  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2discncb AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2addclm  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2discoth AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2benefi  AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2oldpol  AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2oldins  AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2Tnamt   AS CHAR FORMAT "x(40)"  INIT "". 
DEF VAR im2tnam    AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2tmoobr  AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR im2troom   AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2thome   AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2tmoo    AS CHAR FORMAT "x(3)"   INIT "". 
DEF VAR im2tsoi    AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2troad   AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2ttumb   AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2tamph   AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2tprov   AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2tpost   AS CHAR FORMAT "x(10)"  INIT "". 
DEF VAR im2tetel   AS CHAR FORMAT "x(15)"  INIT "". 
DEF VAR im2ttell   AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2tfex    AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2dedat   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2recdat  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2inspac  AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR im2vmimo   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2dricar  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2addess  AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR im2coment  AS CHAR FORMAT "x(100)" INIT "". 
DEF VAR im2text1   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text2   AS CHAR FORMAT "x(25)"  INIT "". 
DEF VAR im2text3   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text4   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text5   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text6   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text7   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text8   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text9   AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text10  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text11  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text12  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text13  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text14  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text15  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text16  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text17  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text18  AS CHAR FORMAT "x(20)"  INIT "". 
DEF VAR im2text19  AS CHAR FORMAT "x(20)"  INIT "". 
 
{wgw\Wgwrklex.i}      /*ประกาศตัวแปร*/ /*A59-0029*/
DEFINE  WORKFILE wdetailcode NO-UNDO
    FIELD n_num          AS INTE INIT 0
    FIELD n_code         AS CHAR FORMAT "x(10)" INIT ""  
    FIELD n_branch       AS CHAR FORMAT "x(10)" INIT "" 
    FIELD n_delercode    AS CHAR FORMAT "x(15)" INIT "" .
DEF BUFFER BWCREATE2 FOR WCREATE2.  
DEF VAR im2type    AS CHAR    FORMAT "x(5)"   INIT "".     
DEF VAR im2type2   AS CHAR    FORMAT "x(5)"   INIT "".     
DEF VAR nv_class   AS CHAR    FORMAT "x(5)"   INIT "".
DEF VAR nv_check   AS INTEGER.  
DEF VAR nv_output  AS CHAR    FORMAT "x(50)"   INIT "".
DEF VAR nv_prmp    AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99"   INIT 0. 
DEF VAR nv_stamp   AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99"   INIT 0. 
DEF VAR nv_stamp1  AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99"   INIT 0. 
DEF VAR nv_vatp    AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99"   INIT 0.
DEF VAR nv_totalp  AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99"   INIT 0.
DEF VAR nv_file     AS CHAR.    
DEF VAR nv_detype   AS CHAR.    
DEF VAR nv_Error    AS LOGICAL. 
DEF VAR nv_prov     AS CHAR.
DEF VAR nv_sub      AS CHAR.
DEF VAR i           AS INTEGER. 
DEF WORKFILE   wdetailpack NO-UNDO
    FIELD       nv_id      AS CHAR FORMAT "x(5)" INIT ""  
    FIELD       nv_brand   AS CHAR FORMAT "x(30)" INIT ""  
    FIELD       nv_pack    AS CHAR FORMAT "x(3)"  INIT "" .
/*----------------- A58-0372 -------------------*/
DEF WORKFILE wcampaign NO-UNDO 
    FIELD  campno  AS CHAR FORMAT "x(20)"    INIT ""
    FIELD  id      AS CHAR FORMAT "x(5)"    INIT ""  
    FIELD  cover   AS CHAR FORMAT "x(3)"    INIT ""  
    FIELD  pack    AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD  bi      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd1     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd2     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n41      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n42      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  n43      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  nname    AS CHAR FORMAT "x(25)"    INIT "" .
/*--------------- end A58-0372 --------------------*/
DEF VAR    nv_1      AS DECI    FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEF VAR    nv_2      AS DECI    FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEFINE VAR E2totalp  AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEFINE VAR nv_E2prmp AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEFINE VAR nv_policy AS CHAR    FORMAT "X(20)".
DEFINE VAR nv_oldpol AS CHAR    FORMAT "X(20)".
DEFINE VAR nv_len    AS INTE    INIT 0.
/*DEFINE VAR nv_pack   AS CHAR    FORMAT "x(5)" INIT "".*/ /*A59-0182*/
DEF VAR n_pol   AS CHAR FORMAT "x(20)".
DEF VAR n_recnt AS INT .
DEF VAR n_encnt AS INT .
DEF VAR n_tariff AS CHAR FORMAT "x(2)".
DEF VAR n_type AS CHAR FORMAT "x(3)".   /*A59-0182*/
DEF VAR nv_promo AS CHAR FORMAT "x(20)" INIT "". /*A61-0269*/
DEF VAR n_year  AS INT INIT 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME brInsure

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcampaign wdetailpack

/* Definitions for BROWSE brInsure                                      */
&Scoped-define FIELDS-IN-QUERY-brInsure wcampaign.id wcampaign.cover wcampaign.pack wcampaign.bi wcampaign.pd1 wcampaign.pd2 wcampaign.n41 wcampaign.n42 wcampaign.n43 wcampaign.nname   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brInsure   
&Scoped-define SELF-NAME brInsure
&Scoped-define QUERY-STRING-brInsure FOR EACH wcampaign NO-LOCK
&Scoped-define OPEN-QUERY-brInsure OPEN QUERY {&SELF-NAME} FOR EACH wcampaign NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brInsure wcampaign
&Scoped-define FIRST-TABLE-IN-QUERY-brInsure wcampaign


/* Definitions for BROWSE br_comp                                       */
&Scoped-define FIELDS-IN-QUERY-br_comp wdetailpack.nv_id wdetailpack.nv_brand wdetailpack.nv_pack   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_comp   
&Scoped-define SELF-NAME br_comp
&Scoped-define QUERY-STRING-br_comp FOR EACH wdetailpack
&Scoped-define OPEN-QUERY-br_comp OPEN QUERY br_comp FOR EACH wdetailpack.
&Scoped-define TABLES-IN-QUERY-br_comp wdetailpack
&Scoped-define FIRST-TABLE-IN-QUERY-br_comp wdetailpack


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brInsure bu_camok fi_brandid fi_brand ~
fi_package bu_add bu_del rs_typ fi_filename fi_outfile bu_ok bu_file ~
fi_filename02 bu_file-2 bu_clear br_comp bu_exit fi_compa fi_campaignkl ~
RECT-76 RECT-77 RECT-78 RECT-79 RECT-379 RECT-389 
&Scoped-Define DISPLAYED-OBJECTS fi_brandid fi_brand fi_package fi_detype ~
rs_typ fi_filename fi_outfile fi_filename02 fi_compa fi_campaignkl 

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
     SIZE 6 BY .95.

DEFINE BUTTON bu_camok 
     LABEL "OK" 
     SIZE 13 BY .95.

DEFINE BUTTON bu_clear 
     LABEL "CLEAR" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 6 BY .95.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_file-2 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brandid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_campaignkl AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_detype AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 59 BY 1
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_filename02 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_package AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_typ AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2,
"ALL", 3,
"RENEW(New Form)", 4
     SIZE 90 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 2 NO-UNDO.

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 8.5 BY 5.52
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-389
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 84 BY 8.52.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 46 BY 8.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 1.52
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-78
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 131 BY 1.71.

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 1.52
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brInsure FOR 
      wcampaign SCROLLING.

DEFINE QUERY br_comp FOR 
      wdetailpack SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brInsure
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brInsure C-Win _FREEFORM
  QUERY brInsure NO-LOCK DISPLAY
      wcampaign.id       COLUMN-LABEL "ID"              FORMAT "X(10)"           
 wcampaign.cover    COLUMN-LABEL "Cover"           FORMAT "X(7)"            
 wcampaign.pack     COLUMN-LABEL "Pack"            FORMAT "x(5)"            
 wcampaign.bi       COLUMN-LABEL "Per Person (BI)" FORMAT "X(15)"   
 wcampaign.pd1      COLUMN-LABEL "Per Accident"    FORMAT "X(15)"      
 wcampaign.pd2      COLUMN-LABEL "Per Accident"    FORMAT "X(15)"      
 wcampaign.n41      COLUMN-LABEL "4.1"             FORMAT "X(15)"           
 wcampaign.n42      COLUMN-LABEL "4.2"             FORMAT "X(15)"           
 wcampaign.n43      COLUMN-LABEL "4.3"             FORMAT "X(15)"           
 wcampaign.nname    COLUMN-LABEL "Name"            FORMAT "X(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 80.5 BY 5.48
         BGCOLOR 15 .

DEFINE BROWSE br_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_comp C-Win _FREEFORM
  QUERY br_comp DISPLAY
      wdetailpack.nv_id      COLUMN-LABEL " ID "       FORMAT "x(6)"
      wdetailpack.nv_brand   COLUMN-LABEL "Brand"      FORMAT "x(13)"
      wdetailpack.nv_pack    COLUMN-LABEL "Pack"       FORMAT "x(4)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 34 BY 5.52
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     brInsure AT ROW 5.62 COL 50
     bu_camok AT ROW 4.38 COL 92.67
     fi_brandid AT ROW 3.29 COL 36.83 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 4.38 COL 11.83 COLON-ALIGNED NO-LABEL
     fi_package AT ROW 4.38 COL 39.83 COLON-ALIGNED NO-LABEL
     bu_add AT ROW 6.1 COL 39.67
     bu_del AT ROW 8.33 COL 39.67
     fi_detype AT ROW 16.91 COL 17.33 COLON-ALIGNED NO-LABEL
     rs_typ AT ROW 11.91 COL 19.83 NO-LABEL
     fi_filename AT ROW 13 COL 17.5 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 15.19 COL 17.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 16.95 COL 80.5
     bu_file AT ROW 13 COL 110.67
     fi_filename02 AT ROW 14.1 COL 17.5 COLON-ALIGNED NO-LABEL
     bu_file-2 AT ROW 14.1 COL 110.67
     bu_clear AT ROW 16.95 COL 89.67
     br_comp AT ROW 5.48 COL 3.33
     bu_exit AT ROW 16.95 COL 100.5
     fi_compa AT ROW 3.29 COL 11.83 COLON-ALIGNED NO-LABEL
     fi_campaignkl AT ROW 4.38 COL 59.17 COLON-ALIGNED NO-LABEL
     "Text Motor 01:":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 13 COL 5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "                              Load Text K-Leasing [บริษัท ลีสซิ่งกสิกรไทย จำกัด]" VIEW-AS TEXT
          SIZE 125 BY 1.24 AT ROW 1.38 COL 3.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "           Type :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 11.91 COL 5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Company :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 3.29 COL 3.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "    ID:" VIEW-AS TEXT
          SIZE 6 BY .95 AT ROW 3.29 COL 31.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Output to File :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 15.19 COL 5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Text Motor 02:":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 14.1 COL 5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Campaign :" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 4.38 COL 49.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "   BRAND:" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 4.38 COL 3.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 4.38 COL 31.33
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-76 AT ROW 2.95 COL 2
     RECT-77 AT ROW 16.67 COL 79.5
     RECT-78 AT ROW 1.1 COL 2
     RECT-79 AT ROW 16.67 COL 99.67
     RECT-379 AT ROW 5.48 COL 38.33
     RECT-389 AT ROW 2.95 COL 48.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 20
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
         TITLE              = "Load Text K-Leasing (บริษัท ลีสซิ่งกสิกรไทย จำกัด)"
         HEIGHT             = 20.19
         WIDTH              = 133.5
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
/* BROWSE-TAB brInsure 1 fr_main */
/* BROWSE-TAB br_comp bu_clear fr_main */
ASSIGN 
       brInsure:SEPARATOR-FGCOLOR IN FRAME fr_main      = 0.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       bu_file-2:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_detype IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_detype:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brInsure
/* Query rebuild information for BROWSE brInsure
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wcampaign NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK"
     _Query            is NOT OPENED
*/  /* BROWSE brInsure */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_comp
/* Query rebuild information for BROWSE br_comp
     _START_FREEFORM
OPEN QUERY br_comp FOR EACH wdetailpack.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_comp */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Load Text K-Leasing (บริษัท ลีสซิ่งกสิกรไทย จำกัด) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Load Text K-Leasing (บริษัท ลีสซิ่งกสิกรไทย จำกัด) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_comp
&Scoped-define SELF-NAME br_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_comp C-Win
ON ROW-DISPLAY OF br_comp IN FRAME fr_main
DO:

    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    wdetailpack.nv_id:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.   
    wdetailpack.nv_brand:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.  
    wdetailpack.nv_pack :BGCOLOR IN BROWSE BR_comp = z NO-ERROR.

    wdetailpack.nv_id:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wdetailpack.nv_brand:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wdetailpack.nv_pack :FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
          
  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_brand = "" THEN DO:
        APPLY "ENTRY" TO fi_brand .
        disp fi_brand  with frame  fr_main.
    END.
    ELSE DO:
        FIND LAST brstat.Insure   WHERE Insure.compno = trim(fi_compa)   AND 
                                      Insure.LName = trim(fi_brand)   NO-ERROR.
        IF NOT AVAIL brstat.Insure THEN DO:
            CREATE brstat.insure .
            ASSIGN 
                Insure.compno = trim(fi_compa) 
                insure.insno  = trim(fi_brandid)
                Insure.FName  = trim(fi_package)
                Insure.LName  = trim(fi_brand)   .  
            FIND LAST wdetailpack WHERE 
                wdetailpack.nv_id    = trim(fi_brandid) AND 
                wdetailpack.nv_brand = trim(fi_brand)   NO-ERROR.
            IF NOT AVAIL wdetailpack THEN DO:
                CREATE wdetailpack.
                ASSIGN 
                    wdetailpack.nv_id    = trim(fi_brandid)
                    wdetailpack.nv_brand = trim(fi_brand)
                    wdetailpack.nv_pack  = trim(fi_package)   .
            END.
            ASSIGN 
                fi_brandid     = ""
                fi_brand       = "" 
                fi_package     = "" .
        END.
    END.
    OPEN QUERY br_comp FOR EACH wdetailpack.
    APPLY "ENTRY" TO fi_brandid  .
    disp fi_brandid fi_brand   fi_package  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_camok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_camok C-Win
ON CHOOSE OF bu_camok IN FRAME fr_main /* OK */
DO:
    OPEN QUERY brInsure  FOR EACH wcampaign NO-LOCK
        WHERE wcampaign.campno = trim(fi_campaignkl). /*--- A58-0372---*/

    /*OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure01 NO-LOCK
        WHERE CompNo = trim(fi_campaignkl).  --- A58-0372 ---*/
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_clear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_clear C-Win
ON CHOOSE OF bu_clear IN FRAME fr_main /* CLEAR */
DO:

  ENABLE rs_typ     WITH FRAM fr_main.
  ENABLE bu_file    WITH FRAM fr_main.
  ENABLE bu_file-2  WITH FRAM fr_main.
  ENABLE fi_outfile WITH FRAM fr_main.

  ASSIGN
    rs_typ        = 1
    fi_filename   = " "
    fi_filename02 = " "
    fi_outfile    = " "
    fi_detype     = " ".

  FOR EACH WCREATE.   DELETE WCREATE.   END.
  FOR EACH WCREATE2.  DELETE WCREATE2.  END.

  DISP rs_typ       bu_file        bu_file-2 fi_outfile 
       fi_filename  fi_filename02  fi_detype WITH FRAM fr_main.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
    GET CURRENT br_comp EXCLUSIVE-LOCK.
    
    FIND LAST brstat.Insure  WHERE 
        Insure.compno = TRIM(fi_compa) AND 
        insure.insno  = wdetailpack.nv_id NO-ERROR .
    IF AVAIL brstat.Insure THEN DO:
        DELETE brstat.Insure.
        
        MESSAGE "Delete ID Package K-Lising OK " VIEW-AS ALERT-BOX.
    END.
    DELETE wdetailpack. 
    /*FIND LAST wdetailpack WHERE wcomp.package  = fi_packcom NO-ERROR NO-WAIT.
        IF    AVAIL wcomp THEN DELETE wcomp.
        ELSE MESSAGE "Not found Package !!! in : " fi_packcom VIEW-AS ALERT-BOX.*/
         
    OPEN QUERY br_comp FOR EACH wdetailpack .
    APPLY "ENTRY" TO fi_brandid IN FRAME fr_main.
    disp fi_brandid fi_brand fi_package with frame  fr_main. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "Close" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEF VAR nv_text AS CHAR FORMAT "x(50)".
    DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    IF rs_typ <> 4 THEN DO:
        SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
            FILTERS    "Text Documents" "*.txt"
                   
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.
   END.
   ELSE DO:
       SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
            FILTERS    "File CSV" "*.csv"

            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.
   END.
   IF OKpressed = TRUE THEN DO:
       fi_filename  = cvData.
       /* start : A59-0029*/
       IF rs_typ = 4 THEN DO:
           ASSIGN
           nv_text     = trim(REPLACE(fi_filename,".csv",""))
           nv_text     = IF LENGTH(nv_text) > 35 THEN SUBSTR(nv_text,1,35) ELSE nv_text
           fi_outfile  = nv_text + "_complete" +  
                         STRING(MONTH(TODAY),"99")    +     
                         STRING(DAY(TODAY),"99")      + 
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".CSV".
       END.
       ELSE DO:  
       
           ASSIGN
           nv_text     = trim(REPLACE(fi_filename,".txt",""))
           nv_text     = IF LENGTH(nv_text) > 35 THEN SUBSTR(nv_text,1,35) ELSE nv_text
           fi_outfile  = nv_text + "_complete" + 
                         STRING(MONTH(TODAY),"99")    +                    
                         STRING(DAY(TODAY),"99")      +                    
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +          
                         SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".CSV".  
       END.
       nv_output = "".
       nv_output = nv_text + "_error" + 
                   STRING(MONTH(TODAY),"99")    +     
                   STRING(DAY(TODAY),"99")      + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                   SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".

       DISP fi_filename fi_outfile WITH FRAME fr_main.    
      /* end : A59-0029*/
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-2 C-Win
ON CHOOSE OF bu_file-2 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Text Documents" "*.txt"
                   
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename02  = cvData.
         DISP fi_filename02 WITH FRAME fr_main.     
    END. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN
        nv_file = ""
        rs_typ = INPUT rs_typ.
    IF INPUT rs_typ = 3  THEN DO:
        nv_file = INPUT fi_outfile.
        DISABLE fi_outfile WITH FRAME fr_main.
        DISABLE rs_typ     WITH FRAME fr_main.
        DISPLAY fi_outfile rs_typ WITH FRAME fr_main.
    END.
    FOR EACH WCREATE.   DELETE WCREATE.   END.
    FOR EACH WCREATE2.  DELETE WCREATE2.  END.
    IF INPUT rs_typ <> 4 THEN DO:   /*--A59-0029--*/
        ASSIGN
            nv_prmp   = 0
            nv_stamp  = 0
            nv_vatp   = 0
            nv_totalp = 0
            nv_error = NO.  
        RUN PDCLEAR.    
        INPUT FROM VALUE (fi_filename). 
        REPEAT:     
            IMPORT DELIMITER "|"          
                im1batchdat    
                im1applino    
                im1polclass  
                im1sumins    
                im1netprm    
                im1grossprm  
                im1effecdat  
                im1expirdat  
                im1trantyp   
                im1fleetflg  
                im1Tinsnam   
                im1Tintinam  
                im1Einsname  
                im1Eintinam  
                im1Tlasnam   
                im1Elasnam   
                im1moobarn   
                im1room      
                im1HOME      
                im1moo       
                im1soi       
                im1road      
                im1tumbon    
                im1amphur    
                im1provice   
                im1postcard  
                im1telext    
                im1tal       
                im1fax       
                im1occup     
                im1modepay   
                im1paycal    
                im1cardtyp   
                im1crecrad   
                im1cradins   
                im1cradexp   
                im1detailno  .
            RUN PDCREATE.
            RUN PDCLEAR.
        END.
        INPUT FROM VALUE (fi_filename02).  
        REPEAT:     
            IMPORT DELIMITER "|"          
                im2applino  
                im2seq     
                im2typins  
                im2CVMI    
                im2package 
                im2merch   
                im2pattern 
                im2sumins  
                im2YEAR    
                im2make    
                im2model   
                im2engine  
                im2cc      
                im2seat    
                im2tonnage 
                im2chassis 
                im2access  
                im2polcmi  
                im2sticker 
                im2instype 
                im2driver  
                im2drinam1 
                im2dribht1 
                im2driocc1 
                im2driid1  
                im2dricr1  
                im2dridat1 
                im2drimth1 
                im2driyer1 
                im2driage1 
                im2drinam2 
                im2dribht2 
                im2driocc2 
                im2driid2  
                im2dricr2  
                im2dridat2 
                im2drimth2 
                im2driyer2 
                im2driage2 
                im2aecsdes 
                im2lisen   
                im2lisenpr 
                im2discft  
                im2discncb 
                im2addclm  
                im2discoth 
                im2benefi  
                im2oldpol  
                im2oldins  
                im2Tnamt   
                im2tnam    
                im2tmoobr  
                im2troom   
                im2thome   
                im2tmoo    
                im2tsoi    
                im2troad   
                im2ttumb   
                im2tamph   
                im2tprov   
                im2tpost   
                im2tetel   
                im2ttell   
                im2tfex    
                im2dedat   
                im2recdat  
                im2inspac  
                im2vmimo   
                im2dricar  
                im2addess  
                im2coment  
                im2text1   
                im2text2   
                im2text3   
                im2text4   
                im2text5   
                im2text6   
                im2text7   
                im2text8   
                im2text9 
                im2text10  
                im2text11  
                im2text12  
                im2text13  
                im2text14  
                im2text15  
                im2text16  
                im2text17  
                im2text18  
                /*im2text19*/    . 
            RUN PDCREATE2.
            RUN PDCLEAR.
        END.
        RUN PDCREATE4. /*a61-0269*/
    END. /*--A59-0029--*/
    /*--A59-0029--*/
    ELSE DO: /* Renew new format */
        RUN PD_Assign.
    END.
    /*--A59-0029--*/
    RUN PDCHERROR.
    rs_typ = INPUT rs_typ.
    IF INPUT rs_typ = 2 AND nv_detype = "NEW" THEN DO:
        MESSAGE "Select Type = 2 don't Input New File And Export File  Not Complete" VIEW-AS ALERT-BOX ERROR TITLE "ERROR MESSAGE". 
        nv_error = YES.
    END.
    IF INPUT rs_typ = 1 AND nv_detype = "RENEW" THEN DO:
        MESSAGE "Select Type = 1 Don't Input Renew File And Export File  Not Complete " VIEW-AS ALERT-BOX ERROR TITLE "ERROR MESSAGE".   
        nv_error = YES.
    END.
    IF (fi_outfile <>  nv_file) AND (INPUT rs_typ = 3) THEN DO:
        MESSAGE "Select Type = 3 don't chang output to name file and Export File  Not Complete" VIEW-AS ALERT-BOX ERROR TITLE "ERROR MESSAGE".
        nv_error = YES.
    END.
    IF    nv_check > 0 THEN 
        MESSAGE "Please check Data again."   
        VIEW-AS ALERT-BOX ERROR TITLE "ERROR MESSAGE".        
    ELSE  DO:
        IF    nv_error = YES THEN DO: 
            MESSAGE "Export File  Not Complete"  VIEW-AS ALERT-BOX ERROR TITLE "ERROR MESSAGE".
            RUN Proc_clear.
            NEXT.
        END.
         
    END.
    /*RUN PDCHEXK. */ /* A59-0182*/
    /*IF rs_typ = 4 THEN RUN pd_report.  /*A59-0182*/
    ELSE RUN PDCHEXK.    /*A59-0182*/*/ /*A61-0269*/
    RUN pd_report. /*A61-0269*/
    RUN PDCLEAR.
    FOR EACH WCREATE.  DELETE WCREATE.  END. 
    FOR EACH WCREATE2. DELETE WCREATE2. END. 
    MESSAGE "Export File  Complete"  VIEW-AS ALERT-BOX.
END.   /*DO*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
    fi_brand =  Input  fi_brand.
    Disp  fi_brand  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brandid
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brandid C-Win
ON LEAVE OF fi_brandid IN FRAME fr_main
DO:
    fi_brandid =  Input  fi_brandid.
    Disp  fi_brandid  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaignkl
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaignkl C-Win
ON LEAVE OF fi_campaignkl IN FRAME fr_main
DO:
    fi_campaignkl =  Input  fi_campaignkl.
    Disp  fi_campaignkl with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compa
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compa C-Win
ON LEAVE OF fi_compa IN FRAME fr_main
DO:
    fi_compa =  Input  fi_compa.
    Disp  fi_compa with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_detype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_detype C-Win
ON LEAVE OF fi_detype IN FRAME fr_main
DO:
  fi_detype = INPUT fi_detype.
  DISP fi_detype WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_filename02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename02 C-Win
ON LEAVE OF fi_filename02 IN FRAME fr_main
DO:

  fi_filename02  =  Input  fi_filename02.
  Disp  fi_filename02  with frame  fr_main.

  /*A59-0029*/
  IF INPUT rs_typ = 4 THEN DO:
      DISABLE fi_filename02 WITH FRAME fr_main.
      DISP fi_filename02  with frame  fr_main.
  END.
  /*A59-0029*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  
  DISP  fi_outfile WITH FRAME  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_package
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_package C-Win
ON LEAVE OF fi_package IN FRAME fr_main
DO:
    fi_package =  Input  fi_package.
    Disp  fi_package  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_typ
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_typ C-Win
ON VALUE-CHANGED OF rs_typ IN FRAME fr_main
DO:
  rs_typ = INPUT rs_typ.

  IF INPUT rs_typ = 1 OR INPUT rs_typ = 2  THEN DO:
        
      ENABLE bu_file   WITH FRAME fr_main.      
      ENABLE bu_file-2 WITH FRAME fr_main.    
      ENABLE fi_outfile WITH FRAME fr_main.
      DISP rs_typ fi_outfile bu_file bu_file-2 WITH FRAME fr_main.

  END.
  /*A59-0029*/
  IF INPUT rs_typ = 4 THEN DO:     
      DISABLE bu_file-2 WITH FRAME fr_main.
      DISABLE fi_filename02 WITH FRAME fr_main.
      fi_filename02:FGCOLOR = 18. 
      fi_filename02:BGCOLOR = 19. 
  END.
  ELSE DO:
      ENABLE  bu_file-2 WITH FRAME fr_main.
      ENABLE  fi_filename02 WITH FRAME fr_main.
      fi_filename02:FGCOLOR = 0. 
      fi_filename02:BGCOLOR = 15. 

  END.
  /*A59-0029*/
  DISP rs_typ fi_outfile bu_file bu_file-2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brInsure
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

  ASSIGN 
      gv_prgid       = "wgwrklex.w"
      gv_prog        = "Import Text File(K-Leasing) to Excel "
      fi_campaignkl  = "CAMPAIGN_KLEASING"
      fi_compa       = "K-LES-PACK".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:HANDLE,gv_prgid,gv_prog).
  RUN proc_createcomp.
  RUN proc_camp.        /*-- A58-0372 --*/
  OPEN QUERY br_comp FOR EACH wdetailpack.
  OPEN QUERY brInsure FOR EACH wcampaign  NO-LOCK WHERE wcampaign.campno = fi_campaignkl. /*-- A58-0372--*/
  /*OPEN QUERY brInsure  FOR EACH Insure USE-INDEX Insure01 NO-LOCK
            WHERE CompNo = fi_campaignkl. --- A58-0372--*/
  DISP fi_compa  fi_campaignkl  WITH FRAM fr_main.
      
/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.

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
  DISPLAY fi_brandid fi_brand fi_package fi_detype rs_typ fi_filename fi_outfile 
          fi_filename02 fi_compa fi_campaignkl 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE brInsure bu_camok fi_brandid fi_brand fi_package bu_add bu_del rs_typ 
         fi_filename fi_outfile bu_ok bu_file fi_filename02 bu_file-2 bu_clear 
         br_comp bu_exit fi_compa fi_campaignkl RECT-76 RECT-77 RECT-78 RECT-79 
         RECT-379 RECT-389 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHERROR C-Win 
PROCEDURE PDCHERROR :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A59-0029 */
/*nv_output = "".
nv_output = fi_outfile + STRING(MONTH(TODAY),"99")    + 
                  STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".*/
/* end : A59-0029 */

OUTPUT STREAM ns2 TO value(nv_output).
          PUT STREAM NS2
              "เลขที่ใบคำขอ"         ";"               
              "เลขที่รับแจ้ง"        ";"        
              "Error    "            ";" SKIP.  

FOR EACH WCREATE2 /* WHERE WCREATE2.E2applino = WCREATE.Eapplino*/ NO-LOCK. 

    FOR EACH BWCREATE2 WHERE
             BWCREATE2.E2text14  =  WCREATE2.E2text14  AND
             BWCREATE2.E2applino <> WCREATE2.E2applino NO-LOCK. /* ------- suthida T. A52-0275 20-09-10 -------- */
        
        IF BWCREATE2.E2text14 <> "" THEN DO:
              
           nv_check = nv_check + 1.
              PUT STREAM ns2
                  BWCREATE2.E2applino                        ";"
                  BWCREATE2.E2text14                         ";" 
                  "Duplicate Policy"                         ";"
          SKIP.   
        END.
    END.
    /* ---- Suthida T. A54-0010 ---- */
   /* ASSIGN
      nv_detype = ""
      nv_detype = WCREATE.Etrantyp.*/
END.

FOR EACH WCREATE NO-LOCK.
    ASSIGN
      nv_detype = ""
      nv_detype = WCREATE.Etrantyp.
END.

OUTPUT STREAM ns2 CLOSE. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHEXK C-Win 
PROCEDURE PDCHEXK :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_cnt    AS INTE INIT 0 .
DEFINE VAR nv_prmp1  AS DECIMAL INIT 0 .
DEFINE VAR nv_totap1 AS DECIMAL INIT 0 .
DEFINE VAR nv_branch AS CHAR.
IF INDEX(fi_outfile,".csv") = 0  THEN 
    nv_output = fi_outfile + ".csv".
ELSE 
    nv_output = substr(fi_outfile,1,INDEX(fi_outfile,".csv") - 1 ) + ".csv".

OUTPUT TO VALUE(nv_output).    /*out put file full policy */
EXPORT DELIMITER "|"  
    "TEXT FILE FROM K-Leasing"      
    "วันที่คำขอประกันภัย"           
    im1batchdat                  
    "ผู้แจ้งงาน "                      
    "  "      .   
EXPORT DELIMITER "|" 
    "สาขา"                          
    "เลขที่ใบคำขอ"                       
    "เลขที่รับแจ้ง"                 
    "เลขที่สติ๊กเกอร์"              
    "เลขที่กรมธรรม์เดิม"            
    "ประเภทความคุ้มครอง "           
    "ประเภทที่แจ้งงาน"              
    "คำนำหน้าชื่อผู้เอาประกันภัย"   
    "ชื่อผู้เอาประกันภัย"           
    "ชื่อบริษัทรถประจำตำแหน่ง"   
    "Occup./อาชีพ"
    "ID/บัตรประชาชน"
    "ที่อยู่1"                      
    "ที่อยู่2"                      
    "ที่อยู่3"                      
    "ที่อยู่4"                      
    "เบอร์โทรศัพท์"                 
    "ชื่อที่ออกใบกำกับภาษี"         
    "ที่อยู่ออกใบกำกับภาษี"         
    "ชื่อ/นามสกุล1 "                
    "วัน/เดือน/ปีเกิด 1"           
    "อายุ1"                        
    "เลขที่บัตรประชาชน 1"          
    "เลขที่ใบขับขี่1"              
    "ชื่อ/นามสกุล 2"               
    "วัน/เดือน/ปีเกิด2 "           
    "อายุ2"                        
    "เลขที่บัตรประชาชน 2"          
    "เลขที่ใบขับขี่2"              
    "วันที่เริ่มคุ้มครอง"          
    "วันที่สิ้นสุด "               
    "ยี่ห้อ"                       
    "รุ่น"                         
    "ปีที่จดทะเบียน"               
    "ทะเบียนรถ"                    
    "เลขตัวถัง"                    
    "เลขเครื่องยนต์ "                     
    "ขนาดเครื่องยนต์"              
    "น้ำหนัก"                      
    "จำนวนที่นั่ง"                 
    /*"ลักษณะการใช้งาน"*/   /*A57-0244*/           
    "ทุนประกัน "                   
    "เบี้ยสุทธิ "                  
    "เบี้ยรวมภาษีอากร"             
    "เบี้ยพรบ"                     
    "เบี้ยรวมพรบ"                        
    "ซ่อม(0:อู่ห้าง,1:อู่ในเครือ)"       
    "อุปกรณ์เสริม"                       
    "รายละเอียดอุปกรณ์เสริม"             
    "หมายเหตุ"
    "รหัสตัวแทน" 
    "ลักษณะการใช้งาน"       /*A57-0244*/  
    "Pol_Type 70/72/74"     /*Add poltype */
    "Per Person (BI)"       /*A57-0244*/  
    "Per Accident"          /*A57-0244*/  
    "Per Accident(PD)"      /*A57-0244*/  
    "4.1 SI."               /*A57-0244*/  
    "4.2 Sum"               /*A57-0244*/  
    "4.3 Sum"               /*A57-0244*/ 
    "VATCODE"               /*A57-0244*/   
    "ISP_NO"                /*A57-0244*/   
    "Campaign".             /*A57-0244*/   

/*IF rs_typ <> 4 THEN DO:  /*A59-0029*/  */   /*A59-0182*/
    FOR EACH WCREATE2 WHERE E2sticker = "" NO-LOCK.
        ASSIGN
            nv_branch = ""
            nv_branch = wCREATE2.im2bran.
        FIND FIRST bWCREATE2 WHERE 
            bWCREATE2.E2sticker <> "" AND 
            bWCREATE2.E2applino =  wCREATE2.E2applino NO-ERROR.
        IF AVAIL  bWCREATE2 THEN DO:
            bWCREATE2.im2bran =  nv_branch.
        END.
    END.
    nv_cnt = 0.    
    FOR EACH WCREATE NO-LOCK 
        BY WCREATE.Eapplino :
        FOR EACH WCREATE2 NO-LOCK 
            WHERE WCREATE2.E2applino = WCREATE.Eapplino 
            BY WCREATE2.E2applino
            BY WCREATE2.E2typins .
            nv_cnt = nv_cnt + 1.
            EXPORT DELIMITER "|"                   
                WCREATE2.im2bran   
                WCREATE.Eapplino    
                WCREATE2.E2text14    
                WCREATE2.E2sticker   FORMAT "x(20)"                   
                WCREATE2.E2oldpol                                     
                IF WCREATE2.E2instype = " " THEN "T" ELSE WCREATE2.E2instype                                
                WCREATE.Etrantyp                                       
                WCREATE.ETinsnam                                        
                WCREATE.THnam     FORMAT "X(60)"  
                WCREATE2.E2text15                                         
                WCREATE.occoup 
                WCREATE.idno   
                WCREATE2.EAddress1                                     
                WCREATE2.EAddress2                                     
                WCREATE2.EAddress3                                     
                WCREATE2.EAddress4                                     
                trim(WCREATE.im1tal + " " + WCREATE.im1fax)    /*WCREATE.EAddress3 */                                     
                WCREATE2.E2text16                                         
                WCREATE2.E2text17                                         
                WCREATE2.E2drinam1                                  
                WCREATE2.E2dribht1                                  
                WCREATE2.E2driage1                                  
                WCREATE2.E2dricr1                                   
                WCREATE2.E2driid1                                   
                WCREATE2.E2drinam2                                  
                WCREATE2.E2dribht2                                  
                WCREATE2.E2driage2                                  
                WCREATE2.E2dricr2                                   
                WCREATE2.E2driid2                                   
                WCREATE.Eeffecdat                                   
                WCREATE.Eexpirdat                                   
                WCREATE2.E2make                                     
                WCREATE2.E2model                                    
                WCREATE2.E2YEAR                                     
                WCREATE2.E22lisen                                   
                WCREATE2.E2chassis                                  
                WCREATE2.E2engine                                   
                WCREATE2.E2cc                                       
                WCREATE2.E2tonnage                                  
                WCREATE2.E2seat  
                WCREATE.Esumins                                                     
                IF  WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Enetprm)          
                IF  WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Egrossprm)        
                STRING(WCREATE2.E2prmp)                                  
                STRING(WCREATE2.E2totalp)                                
                " "                                                   
                WCREATE2.E2access                                        
                WCREATE2.E2aecsdes                                       
                WCREATE2.E2text18 
                WCREATE2.E2pattern 
                WCREATE2.E2CVMI   /*IF WCREATE2.E2instype <> "" THEN    "Z" + WCREATE2.E2CVMI  ELSE    WCREATE2.E2CVMI  */          
                /*IF WCREATE2.E2instype = " " THEN "" ELSE "V70"   /*Add poltype */ */ /*A59-0604*/
                IF index(WCREATE2.E2CVMI,"130") <> 0 THEN "V74" ELSE IF WCREATE2.E2instype = " " THEN "V72" ELSE "V70"   /*A59-0604 */
                WCREATE2.TPBI_Person  
                WCREATE2.TPBI_Accident
                WCREATE2.TPPD_Accident
                WCREATE2.no41         
                WCREATE2.no42         
                WCREATE2.no43 .   
                     
        END.
        ASSIGN
            fi_detype = ""
            fi_detype = "LOAD TEXT" + " " + WCREATE.Etrantyp + " " +  "FILE ".
    
    END.
/*END.*/ /*A59-0182*/
/* Comment by : Ranu i. A59-0182 .........
/*----Start : A59-0029*/
ELSE DO:
    FOR EACH WCREATE WHERE WCREATE.Eapplino <> "" NO-LOCK 
        BY WCREATE.Eapplino :
        FOR EACH WCREATE2 NO-LOCK 
            WHERE WCREATE2.E2applino = WCREATE.Eapplino 
            BY WCREATE2.E2applino
            BY WCREATE2.E2typins .
            nv_cnt = nv_cnt + 1.
            EXPORT DELIMITER "|"                   
                WCREATE2.im2bran   
                WCREATE.Eapplino    
                WCREATE2.E2text14    
                WCREATE2.E2sticker   FORMAT "x(20)"                   
                WCREATE2.E2oldpol                                     
                IF WCREATE2.E2typins = "CMI" THEN "T" ELSE "1"                                
                WCREATE.Etrantyp                                       
                WCREATE.ETinsnam                                        
                WCREATE.THnam     FORMAT "X(60)"  
                WCREATE2.E2text15                                         
                WCREATE.occoup 
                WCREATE.idno   
                WCREATE2.EAddress1                                     
                WCREATE2.EAddress2                                     
                WCREATE2.EAddress3                                     
                WCREATE2.EAddress4                                     
                trim(WCREATE.im1tal + " " + WCREATE.im1fax)    /*WCREATE.EAddress3 */                                     
                WCREATE2.E2text16                                         
                WCREATE2.E2text17                                         
                WCREATE2.E2drinam1                                  
                WCREATE2.E2dribht1                                  
                WCREATE2.E2driage1                                  
                WCREATE2.E2dricr1                                   
                WCREATE2.E2driid1                                   
                WCREATE2.E2drinam2                                  
                WCREATE2.E2dribht2                                  
                WCREATE2.E2driage2                                  
                WCREATE2.E2dricr2                                   
                WCREATE2.E2driid2                                   
                WCREATE.Eeffecdat                                   
                WCREATE.Eexpirdat                                   
                WCREATE2.E2make                                     
                WCREATE2.E2model                                    
                WCREATE2.E2YEAR                                     
                WCREATE2.E22lisen                                   
                WCREATE2.E2chassis                                  
                WCREATE2.E2engine                                   
                WCREATE2.E2cc                                       
                WCREATE2.E2tonnage                                  
                WCREATE2.E2seat  
                WCREATE.Esumins                                                     
                IF WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Enetprm) FORMAT ">,>>>,>>9.99"          
                IF WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Egrossprm) FORMAT ">,>>>,>>9.99"        
                STRING(WCREATE2.E2prmp) FORMAT "->>>,>>9.99"                                  
                STRING(WCREATE2.E2totalp) FORMAT "->>>,>>9.99"                               
                WCREATE2.im2garage  /*A59-0029*/                                                    
                WCREATE2.E2access                                        
                WCREATE2.E2aecsdes                                       
                WCREATE2.E2text18 
                WCREATE2.E2pattern 
                WCREATE2.E2CVMI   /*IF WCREATE2.E2instype <> "" THEN    "Z" + WCREATE2.E2CVMI  ELSE    WCREATE2.E2CVMI   */          
                IF WCREATE2.E2typins = "CMI" THEN "V72" ELSE "V70"   /*Add poltype */
                WCREATE2.TPBI_Person  
                WCREATE2.TPBI_Accident
                WCREATE2.TPPD_Accident
                WCREATE2.no41         
                WCREATE2.no42         
                WCREATE2.no43 
                ""
                ""
                "". 
        END.
        ASSIGN
            fi_detype = ""
            fi_detype = "LOAD TEXT" + " " + WCREATE.Etrantyp + " " +  "FILE ".
    END.
END.
/*---- End : A59-0029-----*/
----- End A59-0182......*/
OUTPUT CLOSE.
DISP fi_detype WITH FRAME fr_main.    /* ----- Suthida T. A54-0010 -------- */
ASSIGN
    nv_prmp   = 0
    nv_stamp  = 0
    nv_vatp   = 0
    nv_totalp = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHEXK_old C-Win 
PROCEDURE PDCHEXK_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEFINE VAR nv_cnt    AS INTE INIT 0 .
DEFINE VAR nv_prmp1  AS DECIMAL INIT 0 .
DEFINE VAR nv_totap1 AS DECIMAL INIT 0 .
DEFINE VAR nv_branch AS CHAR.

/* RUN PDCHERROR. */ /*  ---- Suthida t . A54-0010 14-01-11  ----- */
OUTPUT  TO VALUE(fi_outfile + ".txt") NO-ECHO APPEND.
 /*EXPORT DELIMITER "|"   */   
 PUT UNFORMATTED 
    "TEXT FILE FROM K-Leasing"       "|"       
    "วันที่คำขอประกันภัย"            "|"       
      im1batchdat                    "|"      
    "ผู้แจ้งงาน "                    "|"          /* -- Suthida T. A54-0010 -- */
    "  "                             "|" SKIP .   /* -- Suthida T. A54-0010 -- */
 /*EXPORT DELIMITER "|"   */ 
 PUT UNFORMATTED 
    "สาขา"                          "|" 
    "เลขที่ใบคำขอ"                  "|"               
    "เลขที่รับแจ้ง"                 "|" 
    /*"สาขา"                          "|" */
    "เลขที่สติ๊กเกอร์"              "|" 
    "เลขที่กรมธรรม์เดิม"            "|" 
    "ประเภทความคุ้มครอง "           "|"
    "ประเภทที่แจ้งงาน"              "|"
    "คำนำหน้าชื่อผู้เอาประกันภัย"   "|" 
    "ชื่อผู้เอาประกันภัย"           "|"        
    "ชื่อบริษัทรถประจำตำแหน่ง"      "|"        
    "ที่อยู่1"                      "|" 
    "ที่อยู่2"                      "|"
    "ที่อยู่3"                      "|"
    "ที่อยู่4"                      "|"
    "เบอร์โทรศัพท์"                 "|"
    "ชื่อที่ออกใบกำกับภาษี"         "|" 
    "ที่อยู่ออกใบกำกับภาษี"         "|" 
    "ชื่อ/นามสกุล1 "                "|"        
    "วัน/เดือน/ปีเกิด 1"            "|"        
    "อายุ1"                         "|"              
    "เลขที่บัตรประชาชน 1"           "|"        
    "เลขที่ใบขับขี่1"               "|"        
    "ชื่อ/นามสกุล 2"                "|"        
    "วัน/เดือน/ปีเกิด2 "            "|"        
    "อายุ2"                         "|"        
    "เลขที่บัตรประชาชน 2"           "|"        
    "เลขที่ใบขับขี่2"               "|"        
    "วันที่เริ่มคุ้มครอง"           "|"        
    "วันที่สิ้นสุด "                "|"        
    "ยี่ห้อ"                        "|"        
    "รุ่น"                          "|"        
    "ปีที่จดทะเบียน"                "|"        
    "ทะเบียนรถ"                     "|"        
    "เลขตัวถัง"                     "|"        
    "เลขเครื่องยนต์ "               "|"                     
    "ขนาดเครื่องยนต์"               "|"        
    "น้ำหนัก"                       "|"        
    "จำนวนที่นั่ง"                  "|"        
    "ลักษณะการใช้งาน"               "|"        
    "ทุนประกัน "                    "|"        
    "เบี้ยสุทธิ "                   "|"        
    "เบี้ยรวมภาษีอากร"              "|"        
    "เบี้ยพรบ"                      "|"        
    "เบี้ยรวมพรบ"                   "|"        
    "ซ่อม(0:อู่ห้าง,1:อู่ในเครือ)"  "|"        
    "อุปกรณ์เสริม"                  "|"        
    "รายละเอียดอุปกรณ์เสริม"        "|"        
    "หมายเหตุ"                      "|"  SKIP. 
   FOR EACH WCREATE2 WHERE E2sticker = "" NO-LOCK.
       /*FOR EACH bwCREATE2 WHERE 
                  bwCREATE2.E2sticker = "" NO-LOCK.
       IF AVAIL  bwCREATE2 THEN DO: */
          ASSIGN
             nv_branch = ""
             nv_branch = wCREATE2.im2bran.

          FIND FIRST bWCREATE2 WHERE 
                     bWCREATE2.E2sticker <> "" AND 
                     bWCREATE2.E2applino =  wCREATE2.E2applino NO-ERROR.
          IF AVAIL  bWCREATE2 THEN DO:

                bWCREATE2.im2bran =  nv_branch.
          END.
      /* END.*/
   END.

   nv_cnt = 0.
   FOR EACH WCREATE NO-LOCK.
       FOR EACH WCREATE2 WHERE WCREATE2.E2applino = WCREATE.Eapplino NO-LOCK. 
           
           nv_cnt = nv_cnt + 1.
           /*EXPORT DELIMITER "|" */
           PUT UNFORMATTED 

          /* IF WCREATE2.E2text14 <> "" THEN  SUBSTRING(WCREATE2.E2text14,2,1)                         
           ELSE "M" */ WCREATE2.im2bran             /* สาขา */                                                        "|"
           WCREATE.Eapplino       /*เลขที่ใบคำขอ*/                                                  "|"
           WCREATE2.E2text14      /*เลขที่รับแจ้ง                 */                                "|"
           /*IF WCREATE2.E2text14 <> "" THEN  SUBSTRING( WCREATE2.E2text14,2,1)                         
           ELSE "M"                                               /* สาขา */                          "|"            */
           WCREATE2.E2sticker   FORMAT "x(20)"                    /*เลขที่สติ๊กเกอร์ */  "|"    /*FORMAT "x(20)"*//* --- suthida T. A52-0275 21-09-10 ---*/
           WCREATE2.E2oldpol                                      /*เลขที่กรมธรรม์เดิม            */  "|"    
           IF WCREATE2.E2instype = " " THEN "T"                   /*ประเภทความคุ้มครอง            */  
           ELSE WCREATE2.E2instype                                                                    "|"    
           WCREATE.Etrantyp                                       /* ประเภทที่แจ้งงาน*/               "|" 
           /*IF   WCREATE.ETinsnam <> "บจก." OR WCREATE.ETinsnam <> "หจก." 
           THEN "คุณ" ELSE WCREATE.ETinsnam   */                     
           WCREATE.ETinsnam                                       /*คำนำหน้าชื่อผู้เอาประกันภัย   */  "|"  
           /*WCREATE.ENnam                                        /*คำนำหน้าชื่อผู้เอาประกันภัย   */  "|" */   
           WCREATE.THnam     FORMAT "X(60)"                       /*ชื่อผู้เอาประกันภัย           */  "|"    /*FORMAT "X(60)"*//* --- suthida T. A52-0275 21-09-10 ---*/
           WCREATE2.E2text15                                      /*รถประจำตำแหน่ง                */  "|"    
           WCREATE2.EAddress1                                     /*ที่อยู่ 1                      */ "|"
           WCREATE2.EAddress2                                     /*ที่อยู่ 2                      */ "|"
           WCREATE2.EAddress3                                     /*ที่อยู่ 3                      */ "|"
           WCREATE2.EAddress4                                     /*ที่อยู่ 4                      */ "|"
           WCREATE.EAddress3                                      /*โทรศัพท์                       */ "|" 
           WCREATE2.E2text16                                      /*ชื่อที่ออกใบกำกับภาษี         */  "|"    
           WCREATE2.E2text17                                                                          "|"    
           WCREATE2.E2drinam1                                     /*ชื่อ/นามสกุล1                 */  "|"    
           WCREATE2.E2dribht1                                     /*วัน/เดือน/ปีเกิด 1            */  "|"    
           WCREATE2.E2driage1                                     /*อายุ1                         */  "|"    
           WCREATE2.E2dricr1                                      /*เลขที่บัตรประชาชน 1           */  "|"    
           WCREATE2.E2driid1                                      /*เลขที่ใบขับขี่1               */  "|"    
           WCREATE2.E2drinam2                                     /*ชื่อ/นามสกุล 2                */  "|"    
           WCREATE2.E2dribht2                                     /*วัน/เดือน/ปีเกิด2             */  "|"    
           WCREATE2.E2driage2                                     /*อายุ2                         */  "|"    
           WCREATE2.E2dricr2                                      /*เลขที่บัตรประชาชน 2           */  "|"    
           WCREATE2.E2driid2                                      /*เลขที่ใบขับขี่2               */  "|"    
           WCREATE.Eeffecdat                                      /*วันที่เริ่มคุ้มครอง"         */   "|"    
           WCREATE.Eexpirdat                                      /*วันที่สิ้นสุด "              */   "|"    
           WCREATE2.E2make                                        /*ยี่ห้อ"                      */   "|"    
           WCREATE2.E2model                                       /*รุ่น"                        */   "|"    
           WCREATE2.E2YEAR                                        /*ปีที่จดทะเบียน"              */   "|"    
           WCREATE2.E22lisen                                      /*ทะเบียนรถ"                   */   "|"    
           WCREATE2.E2chassis                                     /*เลขตัวถัง"                   */   "|"    
           WCREATE2.E2engine                                      /*เลขเครื่องยนต์ "             */   "|"    
           WCREATE2.E2cc                                          /*ขนาดเครื่องยนต์"             */   "|"    
           WCREATE2.E2tonnage                                     /*น้ำหนัก"                     */   "|"    
           WCREATE2.E2seat                                        /*จำนวนที่นั่ง"                */   "|"    
           IF WCREATE2.E2instype <> "" THEN    "Z" + WCREATE2.E2CVMI  ELSE   WCREATE2.E2CVMI                                    /*ลักษณะการใช้งาน"          */   "|"    
           WCREATE.Esumins                                           /*ทุนประกัน " */                 "|"   /*FORMAT ">>,>>>,>>>,>>9.99" */
           IF  WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Enetprm)    /*WCREATE2.Enetprm*/      /*"เบี้ยสุทธิ " */               "|"   /*FORMAT ">>,>>>,>>>,>>9.99"*/
           IF  WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Egrossprm)  /*WCREATE2.Egrossprm */   /*"เบี้ยรวมภาษีอากร"*/           "|"   /*FORMAT ">>,>>>,>>>,>>9.99" */
           STRING(WCREATE2.E2prmp)                                   /*"เบี้ยพรบ"   */                "|"   /*FORMAT ">>,>>>,>>>,>>9.99"*/
           STRING(WCREATE2.E2totalp)                                 /*"เบี้ยรวมพรบ" */               "|"   /*FORMAT ">>,>>>,>>>,>>9.99"*/
           " "                                                       /*"ซ่อม(0:อู่ห้าง,1:อู่ในเครือ)" */  "|"
           WCREATE2.E2access                                         /*"อุปกรณ์เสริม"                 */  "|"
           WCREATE2.E2aecsdes                                        /*"รายละเอียดอุปกรณ์เสริม"       */  "|"
           WCREATE2.E2text18                                         /*"หมายเหตุ"                     */  
                 SKIP.
       END.   

       /* ----- Suthida T. A54-0010 ----------- */
       ASSIGN
        fi_detype = ""
        fi_detype = "LOAD TEXT" + " " + WCREATE.Etrantyp + " " +  "FILE ".

   END.

   OUTPUT CLOSE.

   DISP fi_detype WITH FRAME fr_main. /* ----- Suthida T. A54-0010 -------- */
   ASSIGN
     nv_prmp   =0
     nv_stamp  =0
     nv_vatp   =0
     nv_totalp =0.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHK_CAMP_RE C-Win 
PROCEDURE PDCHK_CAMP_RE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File RENEW A61-0269       
------------------------------------------------------------------------------*/
DO:
    IF (INDEX(WCREATE2.E2make,"KIA")       <> 0 AND INDEX(WCREATE2.E2model,"GRAND CARNIVAL") <> 0 ) OR 
       (INDEX(WCREATE2.E2make,"SSANGYONG") <> 0 AND INDEX(WCREATE2.E2model,"STAVIC") <> 0 ) AND 
       n_year <= 5 THEN DO:
           FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
               trim(brstat.Insure.compno)  = "KL-PACK"             AND 
               trim(brstat.insure.text2)   = "KIA"                 AND
               INDEX(WCREATE2.E2CVMI,brstat.insure.Text3) <> 0     AND  /*class */
               DECI(brstat.insure.text5)   = DECI(WCREATE.Enetprm) AND 
               trim(brstat.insure.vatcode) = trim(WCREATE2.E2instype)  NO-LOCK  NO-ERROR.
            IF AVAIL brstat.insure THEN  
               ASSIGN
               WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
               WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
               WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
               WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
               WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
               WCREATE2.no43            =  DECI(brstat.insure.telno)
               wcreate2.campaign        =  TRIM(brstat.insure.text4)
               WCREATE2.im2garage       =  trim(brstat.insure.text1)
               wcreate2.promo           =  "".
    END.

    IF WCREATE2.E2instype = "2" THEN DO:
        FIND FIRST brstat.insure USE-INDEX insure01  WHERE
            trim(brstat.Insure.compno)   = "KL-PACK"                AND    
            INDEX(WCREATE2.E2CVMI,brstat.insure.Text3) <> 0         AND  /*class */
            DECI(brstat.insure.text5)    = DECI(WCREATE.Enetprm)    AND  /*เบี้ยสุทธิ*/  
            trim(brstat.insure.vatcode)  = "2.2" NO-LOCK  NO-ERROR.      /* covcod */
            IF AVAIL brstat.insure THEN DO:                            
                ASSIGN
                WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
                WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
                WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
                WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
                WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
                WCREATE2.no43            =  DECI(brstat.insure.telno)
                wcreate2.campaign        =  TRIM(brstat.insure.text4)
                WCREATE2.E2instype       =  trim(brstat.insure.vatcode)
                WCREATE2.E2CVMI          =  TRIM(brstat.insure.Text3).
             END.
             ELSE DO:
                  FIND FIRST brstat.insure USE-INDEX insure01  WHERE 
                       trim(brstat.Insure.compno)   = "KL-PACK"                    AND     /*A59-0182*/
                       trim(brstat.insure.vatcode)  = trim(WCREATE2.E2instype)     NO-LOCK  NO-ERROR.
                       IF AVAIL brstat.insure THEN  
                          ASSIGN
                          WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
                          WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
                          WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
                          WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
                          WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
                          WCREATE2.no43            =  DECI(brstat.insure.telno)
                          wcreate2.campaign        =  TRIM(brstat.insure.text4)
                          WCREATE2.E2CVMI          =  TRIM(brstat.insure.Text3) + WCREATE2.E2CVMI.
             END.
    END.
    IF WCREATE2.E2instype = "3" THEN DO:
        FIND FIRST brstat.insure USE-INDEX insure01  WHERE
            trim(brstat.Insure.compno)   = "KL-PACK"                AND    
            INDEX(WCREATE2.E2CVMI,brstat.insure.Text3) <> 0         AND  /*class */
            DECI(brstat.insure.text5)    = DECI(WCREATE.Enetprm)    AND  /*เบี้ยสุทธิ*/  
            trim(brstat.insure.vatcode)  = "3.2" NO-LOCK  NO-ERROR.      /* covcod */
            IF AVAIL brstat.insure THEN DO:                            
                ASSIGN
                WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
                WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
                WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
                WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
                WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
                WCREATE2.no43            =  DECI(brstat.insure.telno)
                wcreate2.campaign        =  TRIM(brstat.insure.text4)
                WCREATE2.E2instype       =  trim(brstat.insure.vatcode)
                WCREATE2.E2CVMI          =  TRIM(brstat.insure.Text3).
             END.
             ELSE DO:
                  FIND FIRST brstat.insure USE-INDEX insure01  WHERE 
                       trim(brstat.Insure.compno)   = "KL-PACK"                    AND     /*A59-0182*/
                       trim(brstat.insure.vatcode)  = trim(WCREATE2.E2instype)     NO-LOCK  NO-ERROR.
                       IF AVAIL brstat.insure THEN  
                          ASSIGN
                          WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
                          WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
                          WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
                          WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
                          WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
                          WCREATE2.no43            =  DECI(brstat.insure.telno)
                          wcreate2.campaign        =  TRIM(brstat.insure.text4)
                          WCREATE2.E2CVMI          =  TRIM(brstat.insure.Text3) + WCREATE2.E2CVMI.
             END.
    END.

           
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHK_PRO_NEW C-Win 
PROCEDURE PDCHK_PRO_NEW :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  File RENEW A61-0269     
------------------------------------------------------------------------------*/
DEF VAR n_model AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR n_class AS CHAR FORMAT "x(3)" INIT "" .
DO:
    ASSIGN n_year  = 0
           n_year  = (YEAR(TODAY) - INT(WCREATE2.E2year)) + 1 .
    IF n_year <= 12 THEN DO:
        /* PRO-D 2 */
        IF INDEX(WCREATE2.E2make,"BENZ") <> 0 OR INDEX(WCREATE2.E2make,"VOLVO") <> 0  OR
           ((INDEX(WCREATE2.E2make,"Audi")  <> 0 AND SUBSTR(WCREATE2.E2model,1,1) = "A"  OR SUBSTR(WCREATE2.E2model,1,1) = "Q") OR          /* AUDI */
            (INDEX(WCREATE2.E2make,"MINI")  <> 0 AND INDEX(WCREATE2.E2model,"Cooper")    <> 0   OR INDEX(WCREATE2.E2model,"One") <> 0 ) OR  /* MINI */
            (INDEX(WCREATE2.E2make,"Ford")  <> 0 AND INDEX(WCREATE2.E2model,"Territory") <> 0 ) OR                                  /* FORD */
            (INDEX(WCREATE2.E2make,"Mazda") <> 0 AND INDEX(WCREATE2.E2model,"CX9")       <> 0 ) OR                                  /* MAZDA */
            /* BMW */
           (INDEX(WCREATE2.E2make,"BMW") <> 0  AND SUBSTR(WCREATE2.E2model,1,1) = "1" OR SUBSTR(WCREATE2.E2model,1,1) = "3"    OR 
           SUBSTR(WCREATE2.E2model,1,1) = "5"  OR SUBSTR(WCREATE2.E2model,1,1) = "7"  OR SUBSTR(WCREATE2.E2model,1,2) = "X1"   OR
           SUBSTR(WCREATE2.E2model,1,2) = "X3" OR SUBSTR(WCREATE2.E2model,1,2) = "X5" OR SUBSTR(WCREATE2.E2model,1,2) = "X6" ) OR 
            /* SUBARU */
           (INDEX(WCREATE2.E2make,"Subaru") <> 0 AND INDEX(WCREATE2.E2model,"B9") <> 0 OR INDEX(WCREATE2.E2model,"Tribeca")  <> 0 OR 
           INDEX(WCREATE2.E2model,"Exiga")  <> 0 OR  INDEX(WCREATE2.E2model,"Forester") <> 0 OR INDEX(WCREATE2.E2model,"R2") <> 0 OR 
           INDEX(WCREATE2.E2model,"R1")     <> 0 OR  INDEX(WCREATE2.E2model,"Outback") <> 0 ) OR
            /* LEXUS */
           (INDEX(WCREATE2.E2make,"Lexus") <> 0 AND INDEX(WCREATE2.E2model,"CT200H") <> 0 OR INDEX(WCREATE2.E2model,"ES300") <> 0   OR  
           INDEX(WCREATE2.E2model,"IS200") <> 0 OR  INDEX(WCREATE2.E2model,"IS250") <> 0  OR INDEX(WCREATE2.E2model,"IS460") <> 0   OR  
           INDEX(WCREATE2.E2model,"LS400") <> 0 OR  INDEX(WCREATE2.E2model,"LS430") <> 0  OR INDEX(WCREATE2.E2model,"LS430") <> 0   OR  
           INDEX(WCREATE2.E2model,"LX470") <> 0 OR  INDEX(WCREATE2.E2model,"RX270") <> 0  OR INDEX(WCREATE2.E2model,"RX300") <> 0 ) OR 
            /* SSANGYONG */
           (INDEX(WCREATE2.E2make,"SSANGYONG") <> 0 AND INDEX(WCREATE2.E2model,"Actyon")  <> 0 OR INDEX(WCREATE2.E2model,"Chairman") <> 0 OR
           INDEX(WCREATE2.E2model,"Korando") <> 0 OR INDEX(WCREATE2.E2model,"Kyron")  <> 0   OR INDEX(WCREATE2.E2model,"Musso")  <> 0 OR
           INDEX(WCREATE2.E2model,"Rexton")  <> 0 OR INDEX(WCREATE2.E2model,"Stavic") <> 0 ) OR
            /*Volkswagen*/
           (INDEX(WCREATE2.E2make,"Volkswagen") <> 0 AND INDEX(WCREATE2.E2model,"Amarok")  <> 0 OR INDEX(WCREATE2.E2model,"Beetle") <> 0   OR 
           INDEX(WCREATE2.E2model,"Caravelle") <> 0  OR INDEX(WCREATE2.E2model,"Golf")     <> 0 OR INDEX(WCREATE2.E2model,"Multivan") <> 0 OR 
           INDEX(WCREATE2.E2model,"Passat")    <> 0  OR INDEX(WCREATE2.E2model,"Scirocco") <> 0 OR INDEX(WCREATE2.E2model,"Sharan")   <> 0 OR 
           INDEX(WCREATE2.E2model,"Tiguan")    <> 0  OR INDEX(WCREATE2.E2model,"Vento")    <> 0 ) OR
            /*Hyundai */
           (INDEX(WCREATE2.E2make,"Hyundai") <> 0 AND INDEX(WCREATE2.E2model,"Starex")  <> 0  OR INDEX(WCREATE2.E2model,"Tucson") <> 0  OR
           INDEX(WCREATE2.E2model,"Elantra") <> 0 ) OR
           /*Nissan*/
           (INDEX(WCREATE2.E2make,"Nissan") <> 0 AND INDEX(WCREATE2.E2model,"Cube")   <> 0  OR INDEX(WCREATE2.E2model,"Murano")  <> 0  OR
           INDEX(WCREATE2.E2model,"Presea") <> 0  OR INDEX(WCREATE2.E2model,"Serena") <> 0  OR INDEX(WCREATE2.E2model,"Terrano") <> 0 ) OR
            /*Toyota */
           (INDEX(WCREATE2.E2make,"Toyota")  <> 0 AND INDEX(WCREATE2.E2model,"Alphard") <> 0 OR INDEX(WCREATE2.E2model,"4Runner") <> 0  OR 
           INDEX(WCREATE2.E2model,"Estima")  <> 0 OR  INDEX(WCREATE2.E2model,"Grand Wagon") <> 0  OR INDEX(WCREATE2.E2model,"Granvia") <> 0  OR 
           INDEX(WCREATE2.E2model,"Harrier") <> 0 OR  INDEX(WCREATE2.E2model,"Landcruiser") <> 0  OR INDEX(WCREATE2.E2model,"Rav4") <> 0  OR 
           INDEX(WCREATE2.E2model,"Vellfire") <> 0 )) THEN DO:

            IF n_year <= 5 THEN DO:
                IF DECI(WCREATE.Enetprm) = 32719 OR DECI(WCREATE.Enetprm) = 32718 OR DECI(WCREATE.Enetprm) = 32720 OR /* เบี้ยสุทธิ +-1 */
                   DECI(WCREATE.Enetprm) = 36442 OR DECI(WCREATE.Enetprm) = 36441 OR DECI(WCREATE.Enetprm) = 36443 OR 
                   DECI(WCREATE.Enetprm) = 40165 OR DECI(WCREATE.Enetprm) = 40164 OR DECI(WCREATE.Enetprm) = 40166 OR
                   DECI(WCREATE.Enetprm) = 43889 OR DECI(WCREATE.Enetprm) = 43888 OR DECI(WCREATE.Enetprm) = 43890 OR 
                   DECI(WCREATE.Enetprm) = 47613 OR DECI(WCREATE.Enetprm) = 47612 or DECI(WCREATE.Enetprm) = 47614 OR
                   DECI(WCREATE.Enetprm) = 51336 OR DECI(WCREATE.Enetprm) = 51335 or DECI(WCREATE.Enetprm) = 51337 OR
                   DECI(WCREATE.Enetprm) = 55059 OR DECI(WCREATE.Enetprm) = 55058 or DECI(WCREATE.Enetprm) = 55060 OR
                   DECI(WCREATE.Enetprm) = 58783 OR DECI(WCREATE.Enetprm) = 58782 or DECI(WCREATE.Enetprm) = 58784 OR
                   DECI(WCREATE.Enetprm) = 62506 OR DECI(WCREATE.Enetprm) = 62505 or DECI(WCREATE.Enetprm) = 62507 THEN DO: 
                    ASSIGN   WCREATE2.im2garage  = "G"   wcreate2.promo  = "K-CAR". 
                END.
                ELSE IF DECI(WCREATE.Enetprm) = 26065 OR DECI(WCREATE.Enetprm) = 26064 OR DECI(WCREATE.Enetprm) = 26066 OR
                    DECI(WCREATE.Enetprm) = 29788 OR  DECI(WCREATE.Enetprm) = 29787 OR  DECI(WCREATE.Enetprm) = 29789 OR
                    DECI(WCREATE.Enetprm) = 33511 OR  DECI(WCREATE.Enetprm) = 33510 OR  DECI(WCREATE.Enetprm) = 33512 OR
                    DECI(WCREATE.Enetprm) = 37235 OR  DECI(WCREATE.Enetprm) = 37234 OR  DECI(WCREATE.Enetprm) = 37236 OR
                    DECI(WCREATE.Enetprm) = 40958 OR  DECI(WCREATE.Enetprm) = 40957 OR  DECI(WCREATE.Enetprm) = 40959 OR
                    DECI(WCREATE.Enetprm) = 44681 OR  DECI(WCREATE.Enetprm) = 44680 OR  DECI(WCREATE.Enetprm) = 44682 OR
                    DECI(WCREATE.Enetprm) = 48405 OR  DECI(WCREATE.Enetprm) = 48404 OR  DECI(WCREATE.Enetprm) = 48406 OR
                    DECI(WCREATE.Enetprm) = 52128 OR  DECI(WCREATE.Enetprm) = 52127 OR  DECI(WCREATE.Enetprm) = 52129 OR
                    DECI(WCREATE.Enetprm) = 55852 OR  DECI(WCREATE.Enetprm) = 55851 OR  DECI(WCREATE.Enetprm) = 55853 THEN DO:
                    ASSIGN  WCREATE2.im2garage  = ""   wcreate2.promo  = "K-CAR".
                END.
                ELSE  ASSIGN  WCREATE2.im2garage  = ""   wcreate2.promo  = "".
            END.
            ELSE DO:
                IF DECI(WCREATE.Enetprm) = 23272 OR DECI(WCREATE.Enetprm) = 23271 OR DECI(WCREATE.Enetprm) = 23273 OR
                   DECI(WCREATE.Enetprm) = 26065 OR DECI(WCREATE.Enetprm) = 26064 OR DECI(WCREATE.Enetprm) = 26066 OR
                   DECI(WCREATE.Enetprm) = 28857 OR DECI(WCREATE.Enetprm) = 28856 OR DECI(WCREATE.Enetprm) = 28858 OR
                   DECI(WCREATE.Enetprm) = 31649 OR DECI(WCREATE.Enetprm) = 31648 OR DECI(WCREATE.Enetprm) = 31650 OR
                   DECI(WCREATE.Enetprm) = 34442 OR DECI(WCREATE.Enetprm) = 34441 OR DECI(WCREATE.Enetprm) = 34443 OR
                   DECI(WCREATE.Enetprm) = 37235 OR DECI(WCREATE.Enetprm) = 37234 OR DECI(WCREATE.Enetprm) = 37236 THEN DO: 
                    ASSIGN  WCREATE2.im2garage  = ""   wcreate2.promo  = "K-CAR".
                END.
                ELSE  ASSIGN  WCREATE2.im2garage  = ""   wcreate2.promo  = "".
            END.
        END.
        ELSE DO:
            RUN PDCHK_PRO_NEW1.  /* PRO-D 1 */
        END. 
    END.
    ELSE ASSIGN  WCREATE2.im2garage  = ""   wcreate2.promo  = "".
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHK_PRO_NEW1 C-Win 
PROCEDURE PDCHK_PRO_NEW1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File RENEW A61-0269       
------------------------------------------------------------------------------*/
DO:
   IF INDEX(WCREATE2.E2cvmi,"110") <> 0  THEN DO:
       /* Sedan : S 110 */
       IF INDEX(WCREATE2.E2model,"Mirage") <> 0  OR INDEX(WCREATE2.E2model,"Attrage") <> 0  OR INDEX(WCREATE2.E2model,"Vios")   <> 0 OR  
          INDEX(WCREATE2.E2model,"Avanza") <> 0  OR INDEX(WCREATE2.E2model,"Yaris")   <> 0  OR INDEX(WCREATE2.E2model,"Aveo")   <> 0 OR  
          INDEX(WCREATE2.E2model,"Sonic" ) <> 0  OR INDEX(WCREATE2.E2model,"Swift" )  <> 0  OR INDEX(WCREATE2.E2model,"Ertiga") <> 0 OR 
          INDEX(WCREATE2.E2model,"Ciaz")   <> 0  OR INDEX(WCREATE2.E2model,"Almera")  <> 0  OR INDEX(WCREATE2.E2model,"March")  <> 0 OR 
          INDEX(WCREATE2.E2model,"Fiesta") <> 0  OR (WCREATE2.E2make = "MAZDA" AND INDEX(WCREATE2.E2model,"2") <> 0 ) THEN DO:
          
           IF n_year <= 5 THEN DO:
               IF DECI(WCREATE.Enetprm) = 13498 OR DECI(WCREATE.Enetprm) = 13497 OR DECI(WCREATE.Enetprm) = 13499 THEN 
                   ASSIGN   WCREATE2.im2garage  = "G"   wcreate2.promo  = "K-CAR".
               ELSE IF  DECI(WCREATE.Enetprm) = 12567 OR DECI(WCREATE.Enetprm) = 12566 OR DECI(WCREATE.Enetprm) = 12568 THEN 
                   ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "K-CAR".
               ELSE ASSIGN WCREATE2.im2garage  = ""  wcreate2.promo  = "".
           END.
           ELSE DO:
               IF  DECI(WCREATE.Enetprm) = 11635 OR DECI(WCREATE.Enetprm) = 11634 OR DECI(WCREATE.Enetprm) = 11636 THEN 
                   ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "K-CAR".
               ELSE ASSIGN WCREATE2.im2garage  = ""  wcreate2.promo  = "".
           END.
       END.
       /* Sedan : M 110 */
       ELSE IF INDEX(WCREATE2.E2model,"Lanser") <> 0 OR INDEX(WCREATE2.E2model,"Corolla") <> 0 OR INDEX(WCREATE2.E2model,"Altis") <> 0 OR
          INDEX(WCREATE2.E2model,"Sylphy") <> 0  OR INDEX(WCREATE2.E2model,"Juke")   <> 0  OR INDEX(WCREATE2.E2model,"Pulsar")   <> 0 OR  
          INDEX(WCREATE2.E2model,"Tida" )  <> 0  OR INDEX(WCREATE2.E2model,"Focus" ) <> 0  OR INDEX(WCREATE2.E2model,"Ecosport") <> 0 OR 
          INDEX(WCREATE2.E2model,"Cruze")  <> 0  OR INDEX(WCREATE2.E2model,"Optra")  <> 0  OR 
          (WCREATE2.E2make = "MAZDA" AND INDEX(WCREATE2.E2model,"3") <> 0 )  THEN DO:

           IF n_year <= 5  THEN DO:
               IF      DECI(WCREATE.Enetprm) = 14428 OR DECI(WCREATE.Enetprm) = 14427 OR DECI(WCREATE.Enetprm) = 14429  THEN 
                   ASSIGN   WCREATE2.im2garage  = "G" wcreate2.promo  = "K-CAR".
               ELSE IF DECI(WCREATE.Enetprm) = 13498 OR DECI(WCREATE.Enetprm) = 13497 OR DECI(WCREATE.Enetprm) = 13499  THEN 
                   ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
               ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "".
           END.
           ELSE DO:
               IF DECI(WCREATE.Enetprm) = 12567 OR DECI(WCREATE.Enetprm) = 12566 OR DECI(WCREATE.Enetprm) = 12568 THEN 
                   ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
               ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "".
           END.
       END.
       /* SUV 110 */
       ELSE IF INDEX(WCREATE2.E2model,"Pajero Sport") <> 0 OR INDEX(WCREATE2.E2model,"Pajero") <> 0 OR INDEX(WCREATE2.E2model,"Space Wagon") <> 0 OR 
               INDEX(WCREATE2.E2model,"Innova")  <> 0 OR INDEX(WCREATE2.E2model,"Wish")     <> 0 OR INDEX(WCREATE2.E2model,"Trailbrazer") <> 0  OR 
               INDEX(WCREATE2.E2model,"Captiva") <> 0 OR INDEX(WCREATE2.E2model,"Spin")     <> 0 OR INDEX(WCREATE2.E2model,"CX-5")    <> 0 OR  
               INDEX(WCREATE2.E2model,"CX-3")    <> 0 OR INDEX(WCREATE2.E2model,"X trail")  <> 0 OR INDEX(WCREATE2.E2model,"X-trail") <> 0 OR 
               INDEX(WCREATE2.E2model,"Escape")  <> 0 OR INDEX(WCREATE2.E2model,"Explorer") <> 0 OR INDEX(WCREATE2.E2model,"Everest") <> 0 OR  
               INDEX(WCREATE2.E2model,"XV")      <> 0 OR INDEX(WCREATE2.E2model,"Mu-X")     <> 0 OR INDEX(WCREATE2.E2model,"Mu-7")    <> 0 OR 
               INDEX(WCREATE2.E2model,"Fortuner") <> 0 THEN DO:
            IF n_year <= 5 THEN DO:
                IF      DECI(WCREATE.Enetprm) = 15825 OR DECI(WCREATE.Enetprm) = 15824 OR DECI(WCREATE.Enetprm) = 15826 THEN 
                    ASSIGN   WCREATE2.im2garage  = "G" wcreate2.promo  = "K-CAR".
                ELSE IF DECI(WCREATE.Enetprm) = 14894 OR DECI(WCREATE.Enetprm) = 14893 OR DECI(WCREATE.Enetprm) = 14895 THEN 
                    ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
                ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "". 
            END.
            ELSE DO:
                 IF DECI(WCREATE.Enetprm) = 15000 OR DECI(WCREATE.Enetprm) = 14999 OR DECI(WCREATE.Enetprm) = 15001 THEN 
                     ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
                 ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "".
            END.
       END.
       /* Sedan : L 110 */
       ELSE IF INDEX(WCREATE2.E2model,"Camry") <> 0 OR INDEX(WCREATE2.E2model,"Prius") <> 0 OR INDEX(WCREATE2.E2model,"Sienta") <> 0 OR
               INDEX(WCREATE2.E2model,"Teana") <> 0 THEN DO:

           IF n_year <= 5 THEN DO:
               IF      DECI(WCREATE.Enetprm) = 16756 OR DECI(WCREATE.Enetprm) = 16755 OR DECI(WCREATE.Enetprm) = 16757 THEN 
                   ASSIGN   WCREATE2.im2garage  = "G" wcreate2.promo  = "K-CAR".
               ELSE IF DECI(WCREATE.Enetprm) = 15825 OR DECI(WCREATE.Enetprm) = 15824 OR DECI(WCREATE.Enetprm) = 15826 THEN 
                   ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
               ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "". 
           END.
           ELSE DO:
                IF DECI(WCREATE.Enetprm) = 14894 OR DECI(WCREATE.Enetprm) = 14893 OR DECI(WCREATE.Enetprm) = 14895 THEN 
                    ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
                ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "".
           END.
       END.
       /* PICKUP : 110 */
       ELSE IF INDEX(WCREATE2.E2model,"Triton") <> 0 OR INDEX(WCREATE2.E2model,"Vigo")  <> 0 OR INDEX(WCREATE2.E2model,"Revo") <> 0    OR
            INDEX(WCREATE2.E2model,"Corollado") <> 0 OR INDEX(WCREATE2.E2model,"Bt-50") <> 0 OR INDEX(WCREATE2.E2model,"Navara") <> 0  OR 
            INDEX(WCREATE2.E2model,"Ranger")    <> 0 OR INDEX(WCREATE2.E2model,"D-Max") <> 0 OR INDEX(WCREATE2.E2model,"CAB4") <> 0  THEN DO:

              IF n_year <= 5 THEN DO:
                  IF      DECI(WCREATE.Enetprm) = 15360 OR DECI(WCREATE.Enetprm) = 15359 OR DECI(WCREATE.Enetprm) = 15361 THEN 
                      ASSIGN   WCREATE2.im2garage  = "G" wcreate2.promo  = "K-CAR".
                  ELSE IF DECI(WCREATE.Enetprm) = 14428 OR DECI(WCREATE.Enetprm) = 14427 OR DECI(WCREATE.Enetprm) = 14429 THEN 
                      ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
                  ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "". 
              END.
              ELSE DO:
                   IF DECI(WCREATE.Enetprm) = 12567 OR DECI(WCREATE.Enetprm) = 12566 OR DECI(WCREATE.Enetprm) = 12568 THEN 
                       ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
                   ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "".
              END.
       END.
       ELSE ASSIGN nv_promo  = "".
   END. /* end 110*/
   ELSE IF INDEX(WCREATE2.E2cvmi,"210") <> 0 THEN DO: /* van 210 */
       IF INDEX(WCREATE2.E2model,"Ventury") <> 0 OR INDEX(WCREATE2.E2model,"Urvan")  <> 0 THEN DO:
              IF n_year <= 5 THEN DO:
                  IF      DECI(WCREATE.Enetprm) = 18152 OR DECI(WCREATE.Enetprm) = 18151 OR DECI(WCREATE.Enetprm) = 18153  THEN 
                      ASSIGN   WCREATE2.im2garage  = "G" wcreate2.promo  = "K-CAR".
                  ELSE IF DECI(WCREATE.Enetprm) = 15359 OR DECI(WCREATE.Enetprm) = 15358 OR DECI(WCREATE.Enetprm) = 15360 THEN 
                      ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
                  ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "". 
              END.
              ELSE DO:
                   IF DECI(WCREATE.Enetprm) = 14428 OR DECI(WCREATE.Enetprm) = 14427  OR DECI(WCREATE.Enetprm) = 14429  THEN 
                       ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
                   ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "".
              END.
       END.
       ELSE IF INDEX(WCREATE2.E2model,"H1") <> 0 OR INDEX(WCREATE2.E2model,"H-1") <> 0 AND n_year <= 5 THEN DO:

           IF DECI(WCREATE.Enetprm) = 18721 OR DECI(WCREATE.Enetprm) = 18720 OR DECI(WCREATE.Enetprm) = 18722 OR
              DECI(WCREATE.Enetprm) = 20585 OR DECI(WCREATE.Enetprm) = 20584 OR DECI(WCREATE.Enetprm) = 20586 THEN 
               ASSIGN   WCREATE2.im2garage  = "G" wcreate2.promo  = "K-CAR".
           ELSE IF DECI(WCREATE.Enetprm) = 15600 OR DECI(WCREATE.Enetprm) = 15599 OR DECI(WCREATE.Enetprm) = 15601 OR
                   DECI(WCREATE.Enetprm) = 17462 OR DECI(WCREATE.Enetprm) = 17461 OR DECI(WCREATE.Enetprm) = 17463 THEN 
                   ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
           ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "". 
       END.
       ELSE ASSIGN WCREATE2.im2garage  = ""    wcreate2.promo  = "".
   END.
   ELSE DO: /* pick up 320 */
       IF INDEX(WCREATE2.E2model,"Triton") <> 0 OR INDEX(WCREATE2.E2model,"Vigo")  <> 0 OR INDEX(WCREATE2.E2model,"Revo") <> 0    OR
          INDEX(WCREATE2.E2model,"Corollado") <> 0 OR INDEX(WCREATE2.E2model,"Bt-50") <> 0 OR INDEX(WCREATE2.E2model,"Navara") <> 0  OR 
          INDEX(WCREATE2.E2model,"Ranger")    <> 0 OR INDEX(WCREATE2.E2model,"D-Max") <> 0 OR INDEX(WCREATE2.E2model,"CAB4") <> 0  THEN DO:

          IF n_year <= 5 THEN DO:
              IF      DECI(WCREATE.Enetprm) = 15825 OR DECI(WCREATE.Enetprm) = 15824 OR DECI(WCREATE.Enetprm) = 15826 THEN 
                  ASSIGN   WCREATE2.im2garage  = "G" wcreate2.promo  = "K-CAR".
              ELSE IF DECI(WCREATE.Enetprm) = 14894 OR DECI(WCREATE.Enetprm) = 14893 OR DECI(WCREATE.Enetprm) = 14895 THEN 
                  ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
              ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "". 
          END.
          ELSE DO:
               IF DECI(WCREATE.Enetprm) = 13498 OR DECI(WCREATE.Enetprm) = 13497 OR DECI(WCREATE.Enetprm) = 13499 THEN 
                   ASSIGN   WCREATE2.im2garage  = ""  wcreate2.promo  = "K-CAR".
               ELSE ASSIGN   WCREATE2.im2garage  = ""    wcreate2.promo  = "".
          END.
       END.
       ELSE ASSIGN WCREATE2.im2garage  = ""    wcreate2.promo  = "".
   END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHK_PRO_RE C-Win 
PROCEDURE PDCHK_PRO_RE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  File RENEW A61-0269     
------------------------------------------------------------------------------*/
DEF VAR n_model AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR n_class AS CHAR FORMAT "x(3)" INIT "" .
DO:
    ASSIGN n_year  = 0
           nv_pack = "Z"
           n_year  = (YEAR(TODAY) - INT(im_YEAR)) + 1 .
    IF n_year <= 12 THEN DO:
        /* PRO-D 2 */
        IF INDEX(im_make,"BENZ") <> 0 OR INDEX(im_make,"VOLVO") <> 0  OR
           ((INDEX(im_make,"Audi")  <> 0 AND SUBSTR(im_model,1,1) = "A"  OR SUBSTR(im_model,1,1) = "Q") OR          /* AUDI */
            (INDEX(im_make,"MINI")  <> 0 AND INDEX(im_model,"Cooper")    <> 0   OR INDEX(im_model,"One") <> 0 ) OR  /* MINI */
            (INDEX(im_make,"Ford")  <> 0 AND INDEX(im_model,"Territory") <> 0 ) OR                                  /* FORD */
            (INDEX(im_make,"Mazda") <> 0 AND INDEX(im_model,"CX9")       <> 0 ) OR                                  /* MAZDA */
            /* BMW */
           (INDEX(im_make,"BMW") <> 0  AND SUBSTR(im_model,1,1) = "1" OR SUBSTR(im_model,1,1) = "3"    OR 
           SUBSTR(im_model,1,1) = "5"  OR SUBSTR(im_model,1,1) = "7"  OR SUBSTR(im_model,1,2) = "X1"   OR
           SUBSTR(im_model,1,2) = "X3" OR SUBSTR(im_model,1,2) = "X5" OR SUBSTR(im_model,1,2) = "X6" ) OR 
            /* SUBARU */
           (INDEX(im_make,"Subaru") <> 0 AND INDEX(im_model,"B9") <> 0 OR INDEX(im_model,"Tribeca")  <> 0 OR 
           INDEX(im_model,"Exiga")  <> 0 OR  INDEX(im_model,"Forester") <> 0 OR INDEX(im_model,"R2") <> 0 OR 
           INDEX(im_model,"R1")     <> 0 OR  INDEX(im_model,"Outback") <> 0 ) OR
            /* LEXUS */
           (INDEX(im_make,"Lexus") <> 0 AND INDEX(im_model,"CT200H") <> 0 OR INDEX(im_model,"ES300") <> 0   OR  
           INDEX(im_model,"IS200") <> 0 OR  INDEX(im_model,"IS250") <> 0  OR INDEX(im_model,"IS460") <> 0   OR  
           INDEX(im_model,"LS400") <> 0 OR  INDEX(im_model,"LS430") <> 0  OR INDEX(im_model,"LS430") <> 0   OR  
           INDEX(im_model,"LX470") <> 0 OR  INDEX(im_model,"RX270") <> 0  OR INDEX(im_model,"RX300") <> 0 ) OR 
            /* SSANGYONG */
           (INDEX(im_make,"SSANGYONG") <> 0 AND INDEX(im_model,"Actyon")  <> 0 OR INDEX(im_model,"Chairman") <> 0 OR
           INDEX(im_model,"Korando") <> 0 OR INDEX(im_model,"Kyron")  <> 0   OR INDEX(im_model,"Musso")  <> 0 OR
           INDEX(im_model,"Rexton")  <> 0 OR INDEX(im_model,"Stavic") <> 0 ) OR
            /*Volkswagen*/
           (INDEX(im_make,"Volkswagen") <> 0 AND INDEX(im_model,"Amarok")  <> 0 OR INDEX(im_model,"Beetle") <> 0   OR 
           INDEX(im_model,"Caravelle") <> 0  OR INDEX(im_model,"Golf")     <> 0 OR INDEX(im_model,"Multivan") <> 0 OR 
           INDEX(im_model,"Passat")    <> 0  OR INDEX(im_model,"Scirocco") <> 0 OR INDEX(im_model,"Sharan")   <> 0 OR 
           INDEX(im_model,"Tiguan")    <> 0  OR INDEX(im_model,"Vento")    <> 0 ) OR
            /*Hyundai */
           (INDEX(im_make,"Hyundai") <> 0 AND INDEX(im_model,"Starex")  <> 0  OR INDEX(im_model,"Tucson") <> 0  OR
           INDEX(im_model,"Elantra") <> 0 ) OR
           /*Nissan*/
           (INDEX(im_make,"Nissan") <> 0 AND INDEX(im_model,"Cube")   <> 0  OR INDEX(im_model,"Murano")  <> 0  OR
           INDEX(im_model,"Presea") <> 0  OR INDEX(im_model,"Serena") <> 0  OR INDEX(im_model,"Terrano") <> 0 ) OR
            /*Toyota */
           (INDEX(im_make,"Toyota")  <> 0 AND INDEX(im_model,"Alphard") <> 0 OR INDEX(im_model,"4Runner") <> 0  OR 
           INDEX(im_model,"Estima")  <> 0 OR  INDEX(im_model,"Grand Wagon") <> 0  OR INDEX(im_model,"Granvia") <> 0  OR 
           INDEX(im_model,"Harrier") <> 0 OR  INDEX(im_model,"Landcruiser") <> 0  OR INDEX(im_model,"Rav4") <> 0  OR 
           INDEX(im_model,"Vellfire") <> 0 )) THEN DO:

            IF n_year <= 5 THEN DO:
                IF DECI(im_vnetprem) = 32719 OR DECI(im_vnetprem) = 32718 OR DECI(im_vnetprem) = 32720 OR
                   DECI(im_vnetprem) = 36442 OR DECI(im_vnetprem) = 36441 OR DECI(im_vnetprem) = 36443 OR
                   DECI(im_vnetprem) = 40165 OR DECI(im_vnetprem) = 40164 OR DECI(im_vnetprem) = 40166 OR
                   DECI(im_vnetprem) = 43889 OR DECI(im_vnetprem) = 43888 OR DECI(im_vnetprem) = 43890 OR
                   DECI(im_vnetprem) = 47613 OR DECI(im_vnetprem) = 47612 OR DECI(im_vnetprem) = 47614 OR
                   DECI(im_vnetprem) = 51336 OR DECI(im_vnetprem) = 51335 OR DECI(im_vnetprem) = 51337 OR
                   DECI(im_vnetprem) = 55059 OR DECI(im_vnetprem) = 55058 OR DECI(im_vnetprem) = 55060 OR
                   DECI(im_vnetprem) = 58783 OR DECI(im_vnetprem) = 58782 OR DECI(im_vnetprem) = 58784 OR
                   DECI(im_vnetprem) = 62506 OR DECI(im_vnetprem) = 62505 OR DECI(im_vnetprem) = 62507 OR
                   DECI(im_vnetprem) = 26065 OR DECI(im_vnetprem) = 26064 OR DECI(im_vnetprem) = 26066 OR
                   DECI(im_vnetprem) = 29788 OR DECI(im_vnetprem) = 29787 OR DECI(im_vnetprem) = 29789 OR
                   DECI(im_vnetprem) = 33511 OR DECI(im_vnetprem) = 33510 OR DECI(im_vnetprem) = 33512 OR
                   DECI(im_vnetprem) = 37235 OR DECI(im_vnetprem) = 37234 OR DECI(im_vnetprem) = 37236 OR
                   DECI(im_vnetprem) = 40958 OR DECI(im_vnetprem) = 40957 OR DECI(im_vnetprem) = 40959 OR
                   DECI(im_vnetprem) = 44681 OR DECI(im_vnetprem) = 44680 OR DECI(im_vnetprem) = 44682 OR
                   DECI(im_vnetprem) = 48405 OR DECI(im_vnetprem) = 48404 OR DECI(im_vnetprem) = 48406 OR
                   DECI(im_vnetprem) = 52128 OR DECI(im_vnetprem) = 52127 OR DECI(im_vnetprem) = 52129 OR
                   DECI(im_vnetprem) = 55852 OR DECI(im_vnetprem) = 55851 OR DECI(im_vnetprem) = 55853 THEN 
                   ASSIGN   nv_promo  = "PRO-D". 
                ELSE ASSIGN  nv_promo  = "".
            END.
            ELSE DO:
                IF DECI(im_vnetprem) = 23272 OR DECI(im_vnetprem) = 23271 OR DECI(im_vnetprem) = 23273 OR
                   DECI(im_vnetprem) = 26065 OR DECI(im_vnetprem) = 26064 OR DECI(im_vnetprem) = 26066 OR
                   DECI(im_vnetprem) = 28857 OR DECI(im_vnetprem) = 28856 OR DECI(im_vnetprem) = 28858 OR
                   DECI(im_vnetprem) = 31649 OR DECI(im_vnetprem) = 31648 OR DECI(im_vnetprem) = 31650 OR
                   DECI(im_vnetprem) = 34442 OR DECI(im_vnetprem) = 34441 OR DECI(im_vnetprem) = 34443 OR
                   DECI(im_vnetprem) = 37235 OR DECI(im_vnetprem) = 37234 OR DECI(im_vnetprem) = 37236 THEN 
                    ASSIGN  nv_promo  = "PRO-D". 
                ELSE ASSIGN   nv_promo  = "".
            END.
        END.
        ELSE DO:
            RUN PDCHK_PRO_RE1.  /* PRO-D 1 */
        END. 
    END.
    ELSE ASSIGN nv_promo  = "".
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCHK_PRO_RE1 C-Win 
PROCEDURE PDCHK_PRO_RE1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File RENEW A61-0269       
------------------------------------------------------------------------------*/
DO:
   IF trim(im_class) = "110"  THEN DO:
       /* Sedan : S 110 */
       IF INDEX(im_model,"Mirage") <> 0  OR INDEX(im_model,"Attrage") <> 0  OR INDEX(im_model,"Vios")   <> 0 OR  
          INDEX(im_model,"Avanza") <> 0  OR INDEX(im_model,"Yaris")   <> 0  OR INDEX(im_model,"Aveo")   <> 0 OR  
          INDEX(im_model,"Sonic" ) <> 0  OR INDEX(im_model,"Swift" )  <> 0  OR INDEX(im_model,"Ertiga") <> 0 OR 
          INDEX(im_model,"Ciaz")   <> 0  OR INDEX(im_model,"Almera")  <> 0  OR INDEX(im_model,"March")  <> 0 OR 
          INDEX(im_model,"Fiesta") <> 0  OR (im_make = "MAZDA" AND INDEX(im_model,"2") <> 0 ) THEN DO:
          
           IF n_year <= 5 THEN DO:
               IF DECI(im_vnetprem) = 13498 OR  DECI(im_vnetprem) = 13497 OR  DECI(im_vnetprem) = 13499 OR
                  DECI(im_vnetprem) = 12567 OR  DECI(im_vnetprem) = 12566 OR  DECI(im_vnetprem) = 12568 THEN 
                   ASSIGN   nv_promo  = "PRO-D".
               ELSE ASSIGN nv_promo  = "".
           END.
           ELSE DO:
               IF  DECI(im_vnetprem) = 11635 OR DECI(im_vnetprem) = 11634 OR DECI(im_vnetprem) = 11636 THEN 
                   ASSIGN  nv_promo  = "PRO-D".
               ELSE ASSIGN  nv_promo  = "".
           END.
       END.
       /* Sedan : M 110 */
       ELSE IF INDEX(im_model,"Lanser") <> 0 OR INDEX(im_model,"Corolla") <> 0 OR INDEX(im_model,"Altis") <> 0 OR
          INDEX(im_model,"Sylphy") <> 0  OR INDEX(im_model,"Juke")   <> 0  OR INDEX(im_model,"Pulsar")   <> 0 OR  
          INDEX(im_model,"Tida" )  <> 0  OR INDEX(im_model,"Focus" ) <> 0  OR INDEX(im_model,"Ecosport") <> 0 OR 
          INDEX(im_model,"Cruze")  <> 0  OR INDEX(im_model,"Optra")  <> 0  OR 
          (im_make = "MAZDA" AND INDEX(im_model,"3") <> 0 )  THEN DO:

           IF n_year <= 5  THEN DO:
               IF DECI(im_vnetprem) = 14428 OR DECI(im_vnetprem) = 14427 OR DECI(im_vnetprem) = 14429 OR
                  DECI(im_vnetprem) = 13498 OR DECI(im_vnetprem) = 13497 OR DECI(im_vnetprem) = 13499 THEN 
                  ASSIGN  nv_promo  = "PRO-D".
               ELSE ASSIGN  nv_promo  = "".
           END.
           ELSE DO:
               IF DECI(im_vnetprem) = 12567 OR DECI(im_vnetprem) = 12566 OR DECI(im_vnetprem) = 12568 THEN 
                   ASSIGN  nv_promo  = "PRO-D".
               ELSE ASSIGN  nv_promo  = "".
           END.
       END.
       /* SUV 110 */
       ELSE IF INDEX(im_model,"Pajero Sport") <> 0 OR INDEX(im_model,"Pajero") <> 0 OR INDEX(im_model,"Space Wagon") <> 0 OR 
               INDEX(im_model,"Innova")  <> 0 OR INDEX(im_model,"Wish")     <> 0 OR INDEX(im_model,"Trailbrazer") <> 0  OR 
               INDEX(im_model,"Captiva") <> 0 OR INDEX(im_model,"Spin")     <> 0 OR INDEX(im_model,"CX-5")    <> 0 OR  
               INDEX(im_model,"CX-3")    <> 0 OR INDEX(im_model,"X trail")  <> 0 OR INDEX(im_model,"X-trail") <> 0 OR 
               INDEX(im_model,"Escape")  <> 0 OR INDEX(im_model,"Explorer") <> 0 OR INDEX(im_model,"Everest") <> 0 OR  
               INDEX(im_model,"XV")      <> 0 OR INDEX(im_model,"Mu-X")     <> 0 OR INDEX(im_model,"Mu-7")    <> 0 OR
               INDEX(im_model,"Fortuner") <> 0 THEN DO:
            IF n_year <= 5 THEN DO:
                IF DECI(im_vnetprem) = 15825 OR DECI(im_vnetprem) = 15824 OR DECI(im_vnetprem) = 15826 OR
                   DECI(im_vnetprem) = 14894 OR DECI(im_vnetprem) = 14893 OR DECI(im_vnetprem) = 14895  THEN 
                   ASSIGN  nv_promo  = "PRO-D".
                ELSE ASSIGN  nv_promo  = "". 
            END.
            ELSE DO:
                 IF DECI(im_vnetprem) = 15000 OR DECI(im_vnetprem) = 14999 OR DECI(im_vnetprem) = 15001 THEN 
                     ASSIGN     nv_promo  = "PRO-D".
                 ELSE ASSIGN       nv_promo  = "".
            END.
       END.
       /* Sedan : L 110 */
       ELSE IF INDEX(im_model,"Camry") <> 0 OR INDEX(im_model,"Prius") <> 0 OR INDEX(im_model,"Sienta") <> 0 OR
               INDEX(im_model,"Teana") <> 0 THEN DO:

           IF n_year <= 5 THEN DO:
               IF DECI(im_vnetprem) = 16756 OR DECI(im_vnetprem) = 16755 or DECI(im_vnetprem) = 16757 OR
                  DECI(im_vnetprem) = 15825 OR DECI(im_vnetprem) = 15824 or DECI(im_vnetprem) = 15826 THEN 
                   ASSIGN  nv_promo  = "PRO-D".
               ELSE ASSIGN nv_promo  = "". 
           END.
           ELSE DO:
                IF DECI(im_vnetprem) = 14894 OR DECI(im_vnetprem) = 14893 OR DECI(im_vnetprem) = 14895 THEN 
                    ASSIGN nv_promo  = "PRO-D".
                ELSE ASSIGN  nv_promo  = "".
           END.
       END.
       /* PICKUP : 110 */
       ELSE IF INDEX(im_model,"Triton") <> 0 OR INDEX(im_model,"Vigo")  <> 0 OR INDEX(im_model,"Revo") <> 0    OR
            INDEX(im_model,"Corollado") <> 0 OR INDEX(im_model,"Bt-50") <> 0 OR INDEX(im_model,"Navara") <> 0  OR 
            INDEX(im_model,"Ranger")    <> 0 OR INDEX(im_model,"D-Max") <> 0 OR INDEX(im_model,"CAB4") <> 0  THEN DO:

              IF n_year <= 5 THEN DO:
                  IF  DECI(im_vnetprem) = 15360 OR DECI(im_vnetprem) = 15359 OR DECI(im_vnetprem) = 15361 OR
                      DECI(im_vnetprem) = 14428 OR DECI(im_vnetprem) = 14427 OR DECI(im_vnetprem) = 14429 THEN 
                      ASSIGN  nv_promo  = "PRO-D".
                  ELSE ASSIGN   nv_promo  = "". 
              END.
              ELSE DO:
                   IF DECI(im_vnetprem) = 12567 OR DECI(im_vnetprem) = 12566 OR DECI(im_vnetprem) = 12568 THEN 
                       ASSIGN  nv_promo  = "PRO-D".
                   ELSE ASSIGN  nv_promo  = "".
              END.
       END.
       ELSE ASSIGN nv_promo  = "".
   END. /* end 110*/
   ELSE IF trim(im_class) = "210" THEN DO: /* van 210 */
       IF INDEX(im_model,"Ventury") <> 0 OR INDEX(im_model,"Urvan")  <> 0 THEN DO:
              IF n_year <= 5 THEN DO:
                  IF DECI(im_vnetprem) = 18152 OR DECI(im_vnetprem) = 18151 or DECI(im_vnetprem) = 18153 OR
                     DECI(im_vnetprem) = 15359 OR DECI(im_vnetprem) = 15358 or DECI(im_vnetprem) = 15360  THEN 
                      ASSIGN  nv_promo  = "PRO-D".
                  ELSE ASSIGN  nv_promo  = "". 
              END.
              ELSE DO:
                   IF DECI(im_vnetprem) = 14428 OR DECI(im_vnetprem) = 14427 OR DECI(im_vnetprem) = 14429 THEN 
                       ASSIGN nv_promo  = "PRO-D".
                   ELSE ASSIGN  nv_promo  = "".
              END.
       END.
       ELSE IF INDEX(im_model,"H1") <> 0 OR INDEX(im_model,"H-1") <> 0 AND n_year <= 5 THEN DO:
           IF DECI(im_vnetprem) = 18721 OR DECI(im_vnetprem) = 18720 or DECI(im_vnetprem) = 18722 or
              DECI(im_vnetprem) = 20585 OR DECI(im_vnetprem) = 20584 or DECI(im_vnetprem) = 20586 or
              DECI(im_vnetprem) = 15600 OR DECI(im_vnetprem) = 15599 or DECI(im_vnetprem) = 15601 or
              DECI(im_vnetprem) = 17462 OR DECI(im_vnetprem) = 17461 or DECI(im_vnetprem) = 17463 THEN 
                ASSIGN  nv_promo  = "PRO-D".
           ELSE ASSIGN  nv_promo  = "". 
       END.
       ELSE ASSIGN nv_promo  = "".
   END.
   ELSE DO: /* pick up 320 */
       IF INDEX(im_model,"Triton") <> 0 OR INDEX(im_model,"Vigo")  <> 0 OR INDEX(im_model,"Revo") <> 0    OR
          INDEX(im_model,"Corollado") <> 0 OR INDEX(im_model,"Bt-50") <> 0 OR INDEX(im_model,"Navara") <> 0  OR 
          INDEX(im_model,"Ranger")    <> 0 OR INDEX(im_model,"D-Max") <> 0 OR INDEX(im_model,"CAB4") <> 0  THEN DO:

          IF n_year <= 5 THEN DO:
              IF  DECI(im_vnetprem) = 15825 OR  DECI(im_vnetprem) = 15824 or DECI(im_vnetprem) = 15826 OR
                  DECI(im_vnetprem) = 14894 OR  DECI(im_vnetprem) = 14893 or DECI(im_vnetprem) = 14895 THEN 
                  ASSIGN nv_promo  = "PRO-D".
              ELSE ASSIGN nv_promo  = "". 
          END.
          ELSE DO:
               IF DECI(im_vnetprem) = 13498 OR DECI(im_vnetprem) = 13497 OR DECI(im_vnetprem) = 13499 THEN 
                   ASSIGN nv_promo  = "PRO-D".
               ELSE ASSIGN  nv_promo  = "".
          END.
       END.
       ELSE ASSIGN  nv_promo  = "".
   END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCLEAR C-Win 
PROCEDURE PDCLEAR :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
     /*im1batchdat    = " "*/
     im1applino     = " "
     im1polclass    = " "
     im1sumins      = " "
     im1netprm      = " "
     im1grossprm    = " "
     im1effecdat    = " "
     im1expirdat    = " "
     im1trantyp     = " "
     im1fleetflg    = " "
     im1Tinsnam     = " "
     im1Tintinam    = " "
     im1Einsname    = " "
     im1Eintinam    = " "
     im1Tlasnam     = " "
     im1Elasnam     = " "
     im1moobarn     = " "
     im1room        = " "
     im1HOME        = " "
     im1moo         = " "
     im1soi         = " "
     im1road        = " "
     im1tumbon      = " "
     im1amphur      = " "
     im1provice     = " " 
     im1postcard    = " "
     im1telext      = " "
     im1tal         = " "
     im1fax         = " "
     im1occup       = " "
     im1modepay     = " "
     im1paycal      = " "
     im1cardtyp     = " "
     im1crecrad     = " "
     im1cradins     = " "
     im1cradexp     = " "
     im1detailno    = " "   
     im2applino     = " " 
     im2seq         = " " 
     im2typins      = " " 
     im2CVMI        = " " 
     im2package     = " " 
     im2merch       = " " 
     im2pattern     = " " 
     im2sumins      = " " 
     im2YEAR        = " " 
     im2make        = " " 
     im2model       = " " 
     im2engine      = " " 
     im2cc          = " " 
     im2seat        = " " 
     im2tonnage     = " " 
     im2chassis     = " " 
     im2access      = " " 
     im2polcmi      = " " 
     im2sticker     = " " 
     im2instype     = " " 
     im2driver      = " " 
     im2drinam1     = " " 
     im2dribht1     = " " 
     im2driocc1     = " " 
     im2driid1      = " " 
     im2dricr1      = " " 
     im2dridat1     = " " 
     im2drimth1     = " " 
     im2driyer1     = " " 
     im2driage1     = " " 
     im2drinam2     = " " 
     im2dribht2     = " " 
     im2driocc2     = " " 
     im2driid2      = " " 
     im2dricr2      = " " 
     im2dridat2     = " " 
     im2drimth2     = " " 
     im2driyer2     = " " 
     im2driage2     = " " 
     im2aecsdes     = " " 
     im2lisen       = " " 
     im2lisenpr     = " " 
     im2discft      = " " 
     im2discncb     = " " 
     im2addclm      = " " 
     im2discoth     = " " 
     im2benefi      = " " 
     im2oldpol      = " " 
     im2oldins      = " " 
     im2Tnamt       = " " 
     im2tnam        = " " 
     im2tmoobr      = " " 
     im2troom       = " " 
     im2thome       = " " 
     im2tmoo        = " " 
     im2tsoi        = " " 
     im2troad       = " " 
     im2ttumb       = " " 
     im2tamph       = " " 
     im2tprov       = " " 
     im2tpost       = " " 
     im2tetel       = " " 
     im2ttell       = " " 
     im2tfex        = " " 
     im2dedat       = " " 
     im2recdat      = " " 
     im2inspac      = " " 
     im2vmimo       = " " 
     im2dricar      = " " 
     im2addess      = " " 
     im2coment      = " " 
     im2text1       = " " 
     im2text2       = " " 
     im2text3       = " " 
     im2text4       = " " 
     im2text5       = " " 
     im2text6       = " " 
     im2text7       = " "  
     im2text8       = " " 
     im2text9       = " " 
     im2text10      = " " 
     im2text11      = " " 
     im2text12      = " " 
     im2text13      = " " 
     im2text14      = " " 
     im2text15      = " " 
     im2text16      = " " 
     im2text17      = " " 
     im2text18      = " " 
     im2text19      = " " .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCLEAR2 C-Win 
PROCEDURE PDCLEAR2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0029      
------------------------------------------------------------------------------*/
/*---- Create by A59-0029 --------*/
ASSIGN
     im_no               = " "
     im_thname           = " "
     im_applino          = " "
     im_contractno       = " "
     im_effecdat         = " "
     im_expirdat         = " "
     im_cusname          = " "
     im_custype          = " "
     im_icno             = " "
     im_moobr            = " "
     im_room             = " "
     im_home             = " "
     im_moo              = " "
     im_soi              = " "
     im_road             = " "
     im_tumb             = " "
     im_amph             = " "
     im_prov             = " "
     im_post             = " "
     im_benefi           = " "
     im_drinam1          = " "
     im_dribht1          = " "
     im_driid1           = " "
     im_dricr1           = " " 
     im_drinam2          = " "
     im_dribht2          = " "
     im_driid2           = " "
     im_dricr2           = " "
     im_package          = " "
     im_packname         = " "
     im_garage           = " "
     im_cvmi             = " "
     im_make             = " "
     im_model            = " "
     im_chass            = " "
     im_engno            = " "   
     im_licen            = " " 
     im_regis            = " " 
     im_year             = " " 
     im_color            = " " 
     im_class            = " " 
     im_seat             = " " 
     im_cc               = " " 
     im_weight           = " " 
     im_sumins           = " " 
     im_access           = " " 
     im_accdetail        = " " 
     im_vnetprem         = " " 
     im_vstamp           = " " 
     im_vvat             = " " 
     im_vtprem           = " " 
     im_vwht             = " " 
     im_cnetprem         = " " 
     im_cstamp           = " " 
     im_cvat             = " " 
     im_ctprem           = " " 
     im_cwht             = " " 
     im_remark           = " " 
     im_charge           = " " 
     im_cperson          = " " 
     im_workdate         = " " 
     im_srt_pol_no       = " " 
     im_payment          = " " 
     im_track            = " " 
     im_post_no          = " " 
     im_volu_no          = " " 
     im_comp_no          = " " 
     im_status           = " "
     im_ispno            = " ".
/*---- End A59-0029 --------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCREATE C-Win 
PROCEDURE PDCREATE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF rs_typ <> 4 THEN DO: /*A59-0029*/
    FIND LAST wcreate WHERE WCREATE.Eapplino  =  trim(im1applino)  NO-ERROR NO-WAIT.
    IF NOT AVAIL wcreate THEN DO:
        RUN proc_occoup.
        CREATE WCREATE.
        ASSIGN
            WCREATE.Ebatchdat   =  ""                 /*1*/ 
            WCREATE.Eapplino    =  trim(im1applino)   /*2*/  
            WCREATE.Epolclass   =  trim(im1polclass)  /*3*/  
            WCREATE.Esumins     =  trim(im1sumins)    /*4*/  
            WCREATE.Enetprm     =  trim(im1netprm)    /*5*/
            WCREATE.Egrossprm   =  trim(im1grossprm)  /*6*/
            WCREATE.Eeffecdat   =  trim(im1effecdat)  /*7*/
            WCREATE.Eexpirdat   =  trim(im1expirdat)  /*8*/
            WCREATE.Etrantyp    =  trim(im1trantyp)   /*9*/
            WCREATE.ETinsnam    =  trim(im1Tinsnam) 
            WCREATE.ETintinam   =  trim(im1Tintinam)
            WCREATE.Einsname    =  trim(im1Einsname)
            WCREATE.Eintinam    =  trim(im1Eintinam)   
            WCREATE.ETlasnam    =  trim(im1Tlasnam)    
            WCREATE.Elasnam     =  trim(im1Elasnam)
            WCREATE.im1tal      =  trim(trim(im1telext)   + " " + trim(im1tal))  
            WCREATE.im1fax      =  trim(im1fax) 
            WCREATE.EAddress2   =  trim(im1tumbon)
            WCREATE.EAddress3   =  trim(im1amphur)
            WCREATE.EAddress4   =  trim(trim(im1provice) + " " + TRIM(im1postcard))  
            WCREATE.occoup      =  trim(im1occup)    
            WCREATE.idno        =  TRIM(im1crecrad).
        /*IF  trim(im1moobarn) <> "" THEN WCREATE.EAddress1 = "หมู่บ้าน"    + trim(im1moobarn).  
        IF  trim(im1room)    <> "" THEN WCREATE.EAddress1 = WCREATE.EAddress1 + "เลขที่ห้อง"  +  trim(im1room) . */ 
        IF  trim(im1HOME)       <> "" THEN WCREATE.EAddress1 = trim(im1HOME). 
        IF  trim(im1moobarn)    <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + " "    +  trim(im1moobarn)) .                           /*หมู่บ้าน */
        IF  trim(im1room)       <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + " "    +  trim(im1room)). /*เลขที่ห้อง*/                                                                 
        IF  trim(im1moo)        <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + "หมู่" +  trim(im1moo)).                                       
        IF  trim(im1soi)        <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + "ซอย"  +  trim(im1soi)).                                         
        IF  trim(im1road)       <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + "ถนน"  +  trim(im1road)).
        /*IF im1moo <> "" THEN
            WCREATE.EAddress1   =  trim(im1HOME) + " " + trim(im1moobarn) + " " + trim(im1room) + " " + 
                                   "ม."    +       trim(im1moo)     + " " + trim(im1soi)  + " " + 
                                   trim(im1road) + " " + trim(im1tumbon)  . 
        ELSE 
            WCREATE.EAddress1   =  trim(im1HOME) + " " + trim(im1moobarn) + " " + trim(im1room) + " " + 
                                   trim(im1moo)  + " " + trim(im1soi)     + " " + 
                                   trim(im1road) + " " + trim(im1tumbon) . */
        /* comment by A62-0435...
        IF   WCREATE.ETinsnam = "บจก." OR WCREATE.ETinsnam = "หจก." THEN WCREATE.ETinsnam = WCREATE.ETinsnam.
        ELSE WCREATE.ETinsnam = "คุณ".
        .. end A62-0435...*/

        IF   WCREATE.Einsname <> " " THEN WCREATE.THnam = WCREATE.Einsname + " " + WCREATE.ETlasnam.
        ELSE WCREATE.THnam = WCREATE.Eintinam + " " + WCREATE.Elasnam.
    END.
    RELEASE WCREATE.
END.
 /*-- Start : A59-0029 ------*/
ELSE DO:
    IF trim(im_applino) <> "" THEN DO:
        FIND LAST wcreate WHERE WCREATE.Eapplino  = trim(im_applino)  NO-ERROR NO-WAIT.
            IF NOT AVAIL wcreate THEN DO:
                CREATE WCREATE.
                ASSIGN
                    WCREATE.Ebatchdat   =  ""               
                    WCREATE.Eapplino    =  trim(im_applino) 
                    /*WCREATE.Epolclass   =  ""*/   /*A59-0182*/
                    WCREATE.Epolclass   =  TRIM(im_contractno)  /*A59-0182*/
                    WCREATE.Esumins     =  trim(im_sumins)  
                    WCREATE.Enetprm     =  trim(im_vnetprem)
                    WCREATE.Egrossprm   =  trim(im_vtprem)  
                    WCREATE.Eeffecdat   =  trim(im_effecdat)
                    WCREATE.Eexpirdat   =  trim(im_expirdat)
                    WCREATE.Etrantyp    =  "RENEW"
                    WCREATE.THnam       =  TRIM(im_cusname)
                    WCREATE.EAddress2   =  trim(im_tumb)
                    WCREATE.EAddress3   =  trim(im_amph)
                    WCREATE.EAddress4   =  trim(trim(im_prov) + " " + TRIM(im_post)) 
                    WCREATE.idno        =  TRIM(im_icno).
                IF INDEX(WCREATE.Eapplino,"NB") <> 0 THEN WCREATE.Eapplino = REPLACE(WCREATE.Eapplino,"NB","RW").
                IF  trim(im_moobr) <> "" THEN WCREATE.EAddress1 = trim(im_moobr). 
                IF  trim(im_room ) <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + " "    +  trim(im_room)) .
                IF  trim(im_home)  <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + " "    +  trim(im_home)).                               
                IF  trim(im_moo)   <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + "หมู่" +  trim(im_moo)).                                       
                IF  trim(im_soi)   <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + "ซอย"  +  trim(im_soi)).                                         
                IF  trim(im_road)  <> "" THEN WCREATE.EAddress1 = trim(WCREATE.EAddress1 + "ถนน"  +  trim(im_road)).
                
                IF INDEX(WCREATE.THnam,"บจก.") <> 0 THEN DO:
                    WCREATE.ETinsnam = "บจก.".  
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"บจก.","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"บจก") <> 0  THEN DO:
                    WCREATE.ETinsnam = "บจก.".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"บจก","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"หจก.") <> 0 THEN DO: 
                    WCREATE.ETinsnam = "หจก.".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"หจก.","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"หจก") <> 0 THEN DO:
                    WCREATE.ETinsnam = "หจก.". 
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"หจก","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"บริษัท") <> 0  THEN DO: 
                    WCREATE.ETinsnam = "บริษัท".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"บริษัท","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"ห้างหุ้นส่วนจำกัด") <> 0  THEN DO: 
                    WCREATE.ETinsnam = "หจก.".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"ห้างหุ้นส่วนจำกัด","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"ห้างหุ้นส่วน") <> 0 THEN DO:
                    WCREATE.ETinsnam = "หจก.".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"ห้างหุ้นส่วน","")).
                END.
                 /* add by a62-0435..*/
                ELSE IF INDEX(WCREATE.THnam,"นาย") <> 0 THEN DO:
                    WCREATE.ETinsnam = "นาย".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"นาย","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"นางสาว") <> 0 THEN DO:
                    WCREATE.ETinsnam = "นางสาว".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"นางสาว","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"นาง") <> 0 THEN DO:
                    WCREATE.ETinsnam = "นาง".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"นาง","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"น.ส.") <> 0 THEN DO:
                    WCREATE.ETinsnam = "นางสาว".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"น.ส.","")).
                END.
                ELSE DO:
                    FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno  = "999" AND
                                        INDEX(WCREATE.THnam,brstat.msgcode.MsgDesc) <> 0   NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL brstat.msgcode THEN DO:  
                            ASSIGN WCREATE.ETinsnam = trim(brstat.msgcode.branch)
                                   WCREATE.THnam    = trim(REPLACE(WCREATE.THnam,trim(brstat.msgcode.branch),"")).
                        END.
                END.
                /* end A62-0435*/
                /* comment by a62-0435..
                ELSE IF INDEX(WCREATE.THnam,"นาย") <> 0 THEN DO:
                    WCREATE.ETinsnam = "คุณ".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"นาย","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"นาง") <> 0 THEN DO:
                    WCREATE.ETinsnam = "คุณ".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"นาง","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"นางสาว") <> 0 THEN DO:
                    WCREATE.ETinsnam = "คุณ".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"นางสาว","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"น.ส.") <> 0 THEN DO:
                    WCREATE.ETinsnam = "คุณ".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"น.ส.","")).
                END.
                ELSE IF INDEX(WCREATE.THnam,"คุณ") <> 0 THEN DO:
                    WCREATE.ETinsnam = "คุณ".
                    WCREATE.THnam = trim(REPLACE(WCREATE.THnam,"คุณ","")).
                END.
                .. end A62-0435*/
            END.
    END.
    RELEASE WCREATE.
END.
/*------ End : A59-0029--------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCREATE2 C-Win 
PROCEDURE PDCREATE2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR    nv_1      AS DECI    FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEF VAR    nv_2      AS DECI    FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEFINE VAR E2totalp  AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEFINE VAR nv_E2prmp AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99"   INIT 0.
DEFINE VAR nv_policy AS CHAR    FORMAT "X(20)".
DEFINE VAR nv_oldpol AS CHAR    FORMAT "X(20)".
DEFINE VAR nv_len    AS INTE    INIT 0.
DEFINE VAR nv_pack   AS CHAR    FORMAT "x(5)" INIT "".
ASSIGN 
    nv_pack   = ""
    nv_prmp   = 0  
    nv_stamp  = 0  
    nv_vatp   = 0  
    nv_totalp = 0
    nv_policy = " " 
    nv_policy = trim(im2text14).
IF nv_policy <> ""  THEN DO:
    loop_chk1:
    REPEAT:
        IF INDEX(nv_policy,"-") <> 0 THEN DO:
            nv_len    = LENGTH(nv_policy).
            nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"-") - 1) +
                        SUBSTRING(nv_policy,INDEX(nv_policy,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
    loop_chk2:
    REPEAT:
        IF INDEX(nv_policy,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_policy).
            nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"/") - 1) +
                        SUBSTRING(nv_policy,INDEX(nv_policy,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk2.
    END.
    loop_chk3:
    REPEAT:
        IF INDEX(nv_policy,"\") <> 0 THEN DO:
            nv_len = LENGTH(nv_policy).
            nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"\") - 1) +
                        SUBSTRING(nv_policy,INDEX(nv_policy,"\") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk3.
    END.
END.
ASSIGN  
    nv_oldpol = " "
    nv_oldpol = im2oldpol.
IF nv_oldpol <> "" THEN DO:
    loop_chko1:
    REPEAT:
        IF INDEX(nv_oldpol,"-") <> 0 THEN DO:
            nv_len    = LENGTH(nv_oldpol).
            nv_oldpol = SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"-") - 1) +
                        SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chko1.
    END.
    loop_chko2:
    REPEAT:
        IF INDEX(nv_oldpol,"/") <> 0 THEN DO:
            nv_len = LENGTH(nv_oldpol).
            nv_oldpol = SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"/") - 1) +
                        SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"/") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chko2.
    END.
END.
/* comment by A61-0269....
FIND LAST wdetailpack WHERE wdetailpack.nv_brand = TRIM(im2make) NO-LOCK NO-ERROR.
IF  AVAIL wdetailpack THEN  
    ASSIGN nv_pack = trim(wdetailpack.nv_pack).
ELSE ASSIGN nv_pack = "Z".
....end A61-0269.....*/
IF im2instype = "1" THEN ASSIGN nv_pack = "Z" . /*A61-0269*/
ELSE IF im2instype = "2" THEN DO: 
    IF index(im2text18,"ป.2+") <> 0 THEN ASSIGN  im2instype = "2.2"  nv_pack = "C".  /*A61-0269*/
    ELSE ASSIGN nv_pack = "Y".  /*A61-0269*/
END.
ELSE IF im2instype = "3" THEN DO: 
    IF index(im2text18,"ป.3+") <> 0 THEN ASSIGN  im2instype = "3.2"  nv_pack = "C".  /*A61-0269*/
    ASSIGN nv_pack = "P".  /*A61-0269*/
END.

FIND LAST wcreate2 WHERE WCREATE2.E2applino  = trim(im2applino)  AND 
                         WCREATE2.E2typins   = trim(im2typins)   NO-ERROR NO-WAIT.
IF NOT AVAIL wcreate2 THEN DO:
    CREATE WCREATE2.
    ASSIGN
        WCREATE2.E2applino  = trim(im2applino)  
        WCREATE2.E2typins   = trim(im2typins)    /*cmi,vmi */
        WCREATE2.E2CVMI     = IF im2instype <> "" THEN  nv_pack + trim(im2CVMI) ELSE   trim(im2CVMI)  
        WCREATE2.E2package  = trim(im2package) 
        WCREATE2.E2pattern  = im2pattern
        WCREATE2.E2YEAR     = im2YEAR
        WCREATE2.E2make     = im2make   
        WCREATE2.E2model    = im2model  
        WCREATE2.E2engine   = im2engine 
        WCREATE2.E2cc       = im2cc     
        WCREATE2.E2seat     = im2seat   
        WCREATE2.E2tonnage  = im2tonnage
        WCREATE2.E2chassis  = im2chassis
        WCREATE2.E2access   = im2access 
        WCREATE2.E2sticker  = im2sticker
        WCREATE2.E2instype  = im2instype 
        WCREATE2.E2drinam1  = im2drinam1
        WCREATE2.E2dribht1  = im2dribht1
        WCREATE2.E2driocc1  = im2driocc1
        WCREATE2.E2driid1   = im2driid1 
        WCREATE2.E2dricr1   = im2dricr1 
        WCREATE2.E2dridat1  = im2dridat1
        WCREATE2.E2drimth1  = im2drimth1
        WCREATE2.E2driyer1  = im2driyer1
        WCREATE2.E2driage1  = im2driage1
        WCREATE2.E2drinam2  = im2drinam2 
        WCREATE2.E2dribht2  = im2dribht2 
        WCREATE2.E2driocc2  = im2driocc2 
        WCREATE2.E2driid2   = im2driid2  
        WCREATE2.E2dricr2   = im2dricr2  
        WCREATE2.E2dridat2  = im2dridat2 
        WCREATE2.E2drimth2  = im2drimth2 
        WCREATE2.E2driyer2  = im2driyer2 
        WCREATE2.E2driage2  = im2driage2 
        WCREATE2.E2aecsdes  = im2aecsdes                   
        /*WCREATE2.E22lisen   = im2lisen  + " " + im2lisenpr*/ /* --- suthida T. A54-0010 ตัวย่อจังหวัด 07-03-11 --- */
        WCREATE2.E2text14   = IF      (trim(nv_policy)  = "") AND (trim(im2typins) = "VMI") THEN "0" + substr(trim(im2applino),3)
                              ELSE IF (trim(nv_policy)  = "") AND (trim(im2typins) = "CMI") THEN "1" + substr(trim(im2applino),3)
                              ELSE trim(nv_policy) 
        WCREATE2.E2text15   = im2text15 
        WCREATE2.E2text16   = im2text16 
        WCREATE2.E2text17   = im2text17 
        WCREATE2.E2text18   = trim(im2text18)
        WCREATE2.E2oldpol   = trim(nv_oldpol)
        WCREATE2.im2tmoobr  = trim(im2tmoobr)  
        WCREATE2.im2troom   = trim(im2troom) 
        WCREATE2.im2thome   = trim(im2thome) 
        WCREATE2.im2tmoo    = IF trim(im2tmoo)  = "" THEN "" ELSE "หมู่" + trim(im2tmoo) 
        WCREATE2.im2tsoi    = IF trim(im2tsoi)  = "" THEN "" ELSE "ซอย"  + trim(im2tsoi) 
        WCREATE2.im2troad   = IF trim(im2troad) = "" THEN "" ELSE "ถนน"  + trim(im2troad)
        WCREATE2.im2ttumb   = trim(im2ttumb)
        WCREATE2.im2tamph   = trim(im2tamph)
        WCREATE2.im2tprov   = trim(im2tprov)
        WCREATE2.im2tpost   = trim(im2tpost)      
        WCREATE2.im2tetel   = trim(im2tetel) .
    /* comment by A61-0262...                                                         
    IF trim(im2instype) <> "T" THEN DO:
       FIND FIRST brstat.insure USE-INDEX insure01  WHERE 
            Insure.compno   = fi_campaignkl          AND
            insure.Text3    = TRIM(WCREATE2.E2CVMI)  AND 
            insure.vatcode  = trim(im2instype)       NO-LOCK  NO-ERROR.
        IF AVAIL insure THEN  
            ASSIGN
            WCREATE2.TPBI_Person     =  DECI(insure.lName)                       
            WCREATE2.TPBI_Accident   =  deci(insure.Addr1)                 
            WCREATE2.TPPD_Accident   =  DECI(insure.Addr2)                
            WCREATE2.no41            =  DECI(insure.Addr3)                
            WCREATE2.no42            =  DECI(insure.Addr4)                
            WCREATE2.no43            =  DECI(insure.telno).
    END.
    .. end : A61-0262...*/
    IF index(WCREATE2.im2tprov,"กรุงเทพ") <> 0 THEN  
        ASSIGN
        WCREATE2.im2ttumb = "แขวง" + WCREATE2.im2ttumb
        WCREATE2.im2tamph = "เขต"  + WCREATE2.im2tamph
        WCREATE2.im2tprov = "กรุงเทพฯ".
    ELSE  
        ASSIGN                                           
            WCREATE2.im2ttumb = "ต."  + WCREATE2.im2ttumb 
            WCREATE2.im2tamph = "อ."  + WCREATE2.im2tamph
            WCREATE2.im2tprov = "จ."  + WCREATE2.im2tprov.

    IF  (WCREATE2.E2typins = "VMI") AND (index(WCREATE2.E2CVMI,"310") <> 0 ) THEN  WCREATE2.E2CVMI = nv_pack + "320". /* ---- Suthida T. A54-0010 01-07-11 ----- */
    /*IF WCREATE2.im2tmoo <> "" THEN DO:*/  /* ---- Suthida T. A54-0010 ----- */
    IF WCREATE2.im2thome <> "" THEN DO:
        /*ASSIGN*/
            /* ---- Suthida T. A54-0010 ----- 
            WCREATE2.EAddress1  = im2tmoobr  + " " + im2troom + " " + im2thome + " " +
                                  im2tmoo    + " " + im2tsoi + im2troad
            ---- Suthida T. A54-0010 ----- */    
            /* ---- Suthida T. A54-0010 ----- */
        IF WCREATE2.im2thome  <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.im2thome) .
        IF WCREATE2.im2tmoobr <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2tmoobr). 
        IF WCREATE2.im2troom  <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2troom).
        IF WCREATE2.im2tmoo   <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2tmoo). 
        IF WCREATE2.im2tsoi   <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2tsoi).
        IF WCREATE2.im2troad  <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2troad).
        ASSIGN 
            WCREATE2.EAddress2  = WCREATE2.im2ttumb
            WCREATE2.EAddress3  = WCREATE2.im2tamph
            WCREATE2.EAddress4  = WCREATE2.im2tprov  + " " + WCREATE2.im2tpost .
    END.
    ELSE  /* ---- Suthida T. A54-0010 ----- */
        ASSIGN
            WCREATE2.EAddress1  = im2thome + " " + im2tmoobr + " " + im2troom + " " + 
                                  im2tmoo  + " " + im2tsoi   + " " + im2troad
            WCREATE2.EAddress2  = WCREATE2.im2ttumb
            WCREATE2.EAddress3  = WCREATE2.im2tamph
            WCREATE2.EAddress4  = WCREATE2.im2tprov  + " " + WCREATE2.im2tpost .
    
    IF  im2typins = "CMI" THEN
        WCREATE2.E2CVMI  = (SUBSTRING(im2CVMI,1,(INDEX(im2CVMI,".") - 1 ))) + 
                           (SUBSTRING(im2CVMI,(INDEX(im2CVMI,".") + 1),LENGTH(im2CVMI))).
    
    IF      im2driver = "1" THEN  WCREATE2.E2driver   = "ไม่มี".
    ELSE IF im2driver = "2" THEN  WCREATE2.E2driver   = "มี".
    IF E2drinam1 = " " AND E2drinam2 = " " THEN WCREATE2.E2driver   = "ไม่มี".
    ELSE WCREATE2.E2driver   = "มี".
    nv_1 = 0.
    nv_2 = 0.
    IF WCREATE2.E2typins = "CMI" THEN DO:
        FIND FIRST wcreate WHERE WCREATE.Eapplino = WCREATE2.E2applino NO-ERROR.
        IF AVAIL wcreate THEN DO:
            FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                sicsyac.xmm106.tariff =  "9"                AND
                sicsyac.xmm106.bencod =  "COMP"             AND
                sicsyac.xmm106.covcod =  "T"                AND
                sicsyac.xmm106.class  =  WCREATE2.E2CVMI    AND
                sicsyac.xmm106.key_b  GE 0.00               AND
                sicsyac.xmm106.effdat LE DATE(WCREATE.Eeffecdat) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL xmm106 THEN DO:
                ASSIGN
                    nv_prmp  = xmm106.baseap 
                    nv_stamp = TRUNCATE(((nv_prmp * 0.4) / 100),0).
                IF nv_stamp < nv_prmp  THEN nv_stamp1 = nv_stamp + 1.
                ELSE nv_stamp1 = nv_stamp.
                nv_vatp  = ((nv_prmp + nv_stamp1) * 7) / 100.
                nv_totalp = nv_prmp + nv_stamp1 + nv_vatp.
            END.
            ASSIGN
                WCREATE2.E2prmp     = nv_prmp  
                WCREATE2.E2totalp   = nv_totalp
                nv_1 = DECI(WCREATE.Enetprm)   
                nv_2 = DECI(WCREATE.Egrossprm)
                nv_1 = nv_1 -  nv_prmp
                nv_2 = nv_2 -  nv_totalp
                WCREATE.Enetprm     = STRING(nv_1)     
                WCREATE.Egrossprm   = STRING(nv_2) .  
        END.
        RELEASE WCREATE.
    END.
    /* ---- add suthida T. A54-0010 ตัวย่อจังหวัด 07-03-11 ------  */
    FIND FIRST brstat.insure WHERE brstat.insure.fname = im2lisenpr NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN nv_prov = brstat.Insure.LName.
    ELSE nv_prov = im2lisenpr.
    ASSIGN 
        i       = 1            
        nv_sub  = "".
    IF im2lisen = ""  THEN WCREATE2.E22lisen  = "".
    ELSE DO:
        loop_a:
        REPEAT i = 1 TO LENGTH(im2lisen):
            IF  INDEX("1234567890" , SUBSTRING(im2lisen,i,1)) = 0 THEN
                nv_sub   = nv_sub + SUBSTRING(im2lisen,i,1).
            ELSE   LEAVE loop_a.
        END.
        IF INDEX("1234567890" , SUBSTRING(im2lisen,i,1)) <> 0 THEN 
            WCREATE2.E22lisen   = TRIM(SUBSTRING(im2lisen,1,2) + " " + 
                                   SUBSTRING(im2lisen,3,LENGTH(im2lisen)) + " " + nv_prov).
        ELSE 
            WCREATE2.E22lisen   = TRIM(nv_sub + " " + SUBSTRING(im2lisen,LENGTH(nv_sub) + 1,LENGTH(im2lisen) ) 
                                       + " " + nv_prov).
    END.
    /*------------- Comment : A58-0372 ---------------------------------
    IF  WCREATE2.E2text14 <> "" AND SUBSTRING(WCREATE2.E2applino,1,2) <> "RW" THEN DO:
        IF SUBSTRING(WCREATE2.E2text14,1,1) = "D" OR  
            SUBSTRING(WCREATE2.E2text14,1,1) = "I" THEN WCREATE2.im2bran = SUBSTRING(WCREATE2.E2text14,2,1).
        ELSE WCREATE2.im2bran = SUBSTRING(WCREATE2.E2text14,1,2).
    END.
    ELSE WCREATE2.im2bran = "M".
    ------------------ end A58-0372 ----------------------------------------*/
    /*---------------- A58-0372------------------------------------------*/
    IF  WCREATE2.E2text14 <> "" AND SUBSTRING(WCREATE2.E2applino,1,2) <> "RW" THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01  WHERE 
            stat.Insure.compno   = "K-LEASING"            AND
            stat.insure.Fname    = TRIM(im2text16)        AND 
            stat.insure.Lname    = trim(im2text16)        NO-LOCK  NO-ERROR.
        IF AVAIL stat.insure THEN  
            ASSIGN  WCREATE2.im2bran = stat.insure.branch.
        ELSE WCREATE2.im2bran = " ".
    END.
    ELSE DO:
        FIND FIRST stat.insure USE-INDEX insure01  WHERE 
            stat.Insure.compno   = "K-LEASING"            AND
            stat.insure.Fname    = TRIM(im2text16)        AND 
            stat.insure.Lname    = trim(im2text16)        NO-LOCK  NO-ERROR.
        IF AVAIL stat.insure THEN  
            ASSIGN  WCREATE2.im2bran = stat.insure.branch.
        ELSE WCREATE2.im2bran = " ".
    END.
    /*------------------------ end A58-0372 -----------------------------*/
END.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCREATE3 C-Win 
PROCEDURE PDCREATE3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by : A59-0029     
------------------------------------------------------------------------------*/
/*ASSIGN nv_pack  = ""    nv_promo = "".*/ /*A61-0269 */
IF rs_typ = 4 THEN DO:
    ASSIGN  nv_prmp   = 0       nv_stamp  = 0  
            nv_vatp   = 0       nv_totalp = 0
            nv_policy = " "     nv_policy = trim(im2text14)
            nv_pack  = ""       nv_promo = "". /*A61-0269 */
    IF nv_policy <> ""  THEN DO:
        loop_chk1:
        REPEAT:
            IF INDEX(nv_policy,"-") <> 0 THEN DO:
                nv_len    = LENGTH(nv_policy).
                nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"-") - 1) +
                            SUBSTRING(nv_policy,INDEX(nv_policy,"-") + 1, nv_len ) .
            END.
            ELSE LEAVE loop_chk1.
        END.
        loop_chk2:
        REPEAT:
            IF INDEX(nv_policy,"/") <> 0 THEN DO:
                nv_len = LENGTH(nv_policy).
                nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"/") - 1) +
                            SUBSTRING(nv_policy,INDEX(nv_policy,"/") + 1, nv_len ) .
            END.
            ELSE LEAVE loop_chk2.
        END.
        loop_chk3:
        REPEAT:
            IF INDEX(nv_policy,"\") <> 0 THEN DO:
                nv_len = LENGTH(nv_policy).
                nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"\") - 1) +
                            SUBSTRING(nv_policy,INDEX(nv_policy,"\") + 1, nv_len ) .
            END.
            ELSE LEAVE loop_chk3.
        END.
    END.
    ASSIGN  nv_oldpol = " "
            nv_oldpol = TRIM(im_srt_pol_no).
    IF nv_oldpol <> "" THEN DO:
        loop_chko1:
            REPEAT:
                IF INDEX(nv_oldpol,"-") <> 0 THEN DO:
                    nv_len    = LENGTH(nv_oldpol).
                    nv_oldpol = SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"-") - 1) +
                                SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"-") + 1, nv_len ) .
                END.
                ELSE LEAVE loop_chko1.
            END.
            loop_chko2:
            REPEAT:
                IF INDEX(nv_oldpol,"/") <> 0 THEN DO:
                    nv_len = LENGTH(nv_oldpol).
                    nv_oldpol = SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"/") - 1) +
                                SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"/") + 1, nv_len ) .
                END.
                ELSE LEAVE loop_chko2.
            END.
    END.
   /* comment by A59-0182............
    FIND LAST wdetailpack WHERE wdetailpack.nv_brand = TRIM(im_make) NO-LOCK NO-ERROR.
    IF  AVAIL wdetailpack THEN  ASSIGN nv_pack = trim(wdetailpack.nv_pack).
    ELSE ASSIGN nv_pack = "Z". */ /* end A59-0182...*/ 
    /* comment by A61-0269.....
    IF DECI(im_vnetprem) = 11635 OR DECI(im_vnetprem) = 12567 OR DECI(im_vnetprem) = 13498 OR DECI(im_vnetprem) = 14428 OR 
       DECI(im_vnetprem) = 14894 OR DECI(im_vnetprem) = 15000 OR DECI(im_vnetprem) = 15359 OR DECI(im_vnetprem) = 15360 OR 
       DECI(im_vnetprem) = 15825 OR DECI(im_vnetprem) = 16756 OR DECI(im_vnetprem) = 18152 OR DECI(im_vnetprem) = 23272 OR
       DECI(im_vnetprem) = 26065 OR DECI(im_vnetprem) = 28857 OR DECI(im_vnetprem) = 29788 OR DECI(im_vnetprem) = 30719 OR 
       DECI(im_vnetprem) = 31649 OR DECI(im_vnetprem) = 33511 OR DECI(im_vnetprem) = 34442 OR DECI(im_vnetprem) = 37235 OR 
       DECI(im_vnetprem) = 38165 OR DECI(im_vnetprem) = 40958 OR DECI(im_vnetprem) = 41889 OR DECI(im_vnetprem) = 44681 OR
       DECI(im_vnetprem) = 45613 OR DECI(im_vnetprem) = 48405 OR DECI(im_vnetprem) = 49336 OR DECI(im_vnetprem) = 52128 OR 
       DECI(im_vnetprem) = 53059 OR DECI(im_vnetprem) = 55852 OR DECI(im_vnetprem) = 56783 OR DECI(im_vnetprem) = 60506 THEN DO:
         ASSIGN nv_pack  = "Z"   nv_promo = "PRO-D"  .
    END.
    ELSE DO: 
        ASSIGN nv_pack  = ""    nv_promo = "".
    END.
    ....end A61-0269...*/

   IF INDEX(im_package,"ชั้น 1") <> 0 OR INDEX(im_package,"ชั้น1") <> 0 OR                      /* A61-0269*/
      INDEX(im_packname,"ป.1")   <> 0 OR INDEX(im_packname,"ป. 1") <> 0 THEN RUN PDCHK_PRO_RE.  /* A61-0269*/

    FIND LAST wcreate2 WHERE WCREATE2.E2applino  = trim(im_applino)  AND 
                             WCREATE2.E2typins   = trim(im_cvmi)   NO-ERROR NO-WAIT.
    IF NOT AVAIL wcreate2 THEN DO:
        CREATE WCREATE2.
        ASSIGN
            WCREATE2.E2applino  = TRIM(im_applino)
            WCREATE2.E2typins   = trim(im_cvmi)    /*cmi,vmi */
            WCREATE2.E2CVMI     = IF im_cvmi = "VMI" THEN IF nv_pack <> "" THEN nv_pack + trim(im_class) ELSE " " ELSE  trim(im_class)   
            WCREATE2.E2package  = trim(im_package) 
            WCREATE2.E2pattern  = ""
            WCREATE2.E2YEAR     = TRIM(im_YEAR)
            WCREATE2.E2make     = TRIM(im_make)   
            WCREATE2.E2model    = trim(im_model) 
            WCREATE2.E2engine   = TRIM(im_engno) 
            WCREATE2.E2cc       = TRIM(im_cc)     
            WCREATE2.E2seat     = TRIM(im_seat)   
            WCREATE2.E2tonnage  = TRIM(im_weight)
            WCREATE2.E2chassis  = TRIM(im_chass)
            WCREATE2.E2access   = trim(im_access) 
            /*WCREATE2.E2sticker  = ""          */  /*A59-0604*/
            WCREATE2.E2sticker  = trim(im_package)  /*A59-0604*/
            WCREATE2.E2instype  = IF WCREATE2.E2typins = "CMI" THEN "T" ELSE ""
            WCREATE2.E2drinam1  = trim(im_drinam1)
            WCREATE2.E2dribht1  = TRIM(im_dribht1)
            WCREATE2.E2driocc1  = "" /*im2driocc1*/
            WCREATE2.E2driid1   = TRIM(im_driid1) 
            WCREATE2.E2dricr1   = trim(im_dricr1) 
            WCREATE2.E2dridat1  = "" /*im2dridat1*/
            WCREATE2.E2drimth1  = "" /*im2drimth1*/
            WCREATE2.E2driyer1  = "" /*im2driyer1*/
            WCREATE2.E2driage1  = "" /*im2driage1*/
            WCREATE2.E2drinam2  = TRIM(im_drinam2) 
            WCREATE2.E2dribht2  = TRIM(im_dribht2) 
            WCREATE2.E2driocc2  = "" /*im2driocc2 */
            WCREATE2.E2driid2   = trim(im_driid2)  
            WCREATE2.E2dricr2   = trim(im_dricr2)  
            WCREATE2.E2dridat2  = "" /*im2dridat2 */
            WCREATE2.E2drimth2  = "" /*im2drimth2 */
            WCREATE2.E2driyer2  = "" /*im2driyer2 */
            WCREATE2.E2driage2  = "" /*im2driage2 */
            WCREATE2.E2aecsdes  = trim(im_accdetail)                   
            WCREATE2.E2text14   = IF (trim(nv_policy)  = "") AND (trim(im_cvmi) = "VMI") THEN "0" + substr(trim(im_applino),3)
                                  ELSE IF (trim(nv_policy)  = "") AND (trim(im_cvmi) = "CMI") THEN "1" + substr(trim(im_applino),3)
                                  ELSE trim(nv_policy) 
            WCREATE2.E2text18   = trim(im_remark)
            WCREATE2.E2oldpol   = trim(nv_oldpol)
            WCREATE2.im2tmoobr  = trim(im_moobr)  
            WCREATE2.im2troom   = trim(im_room) 
            WCREATE2.im2thome   = trim(im_home) 
            WCREATE2.im2tmoo    = IF trim(im_moo)  = "" THEN "" ELSE "หมู่" + trim(im_moo) 
            WCREATE2.im2tsoi    = IF trim(im_soi)  = "" THEN "" ELSE "ซอย"  + trim(im_soi) 
            WCREATE2.im2troad   = IF trim(im_road) = "" THEN "" ELSE "ถนน"  + trim(im_road)
            WCREATE2.im2ttumb   = trim(im_tumb)
            WCREATE2.im2tamph   = trim(im_amph)
            WCREATE2.im2tprov   = trim(im_prov)
            WCREATE2.im2tpost   = trim(im_post)
            /*WCREATE2.im2garage  = IF TRIM(im_garage) = "อู่ห้าง" THEN "G" ELSE ""  /*A59-0182*/ */ /*A62-0435*/
            WCREATE2.im2garage  = IF TRIM(im_garage) = "อู่ห้าง" THEN "G" ELSE IF INDEX(im_garage,"อะไหล่แท้") <> 0 THEN "P" ELSE ""  /*A62-0435*/
            wcreate2.benefic    = TRIM(im_benefi) /*A59-0182*/                            
            wcreate2.payment    = TRIM(im_payment)  /*A59-0182*/ 
            wcreate2.track      = TRIM(im_track)   /*A59-0182*/
            wcreate2.promo      = TRIM(nv_promo).   /*A59-0182*/

        IF INDEX(WCREATE2.E2applino,"NB") <> 0 THEN WCREATE2.E2applino = REPLACE(WCREATE2.E2applino,"NB","RW").
        IF WCREATE2.E2typins = "VMI" THEN DO:
           IF       INDEX(im_package,"ชั้น 1") <> 0 OR INDEX(im_package,"ชั้น1") <> 0 OR
                    INDEX(im_packname,"ป.1")   <> 0 OR INDEX(im_packname,"ป. 1") <> 0 THEN 
                        ASSIGN WCREATE2.E2instype = "1" .
           ELSE IF INDEX(im_package,"ชั้น 2") <> 0 OR INDEX(im_package,"ชั้น2") <> 0 OR      
                   INDEX(im_packname,"ป.2")   <> 0 OR INDEX(im_packname,"ป. 2") <> 0 THEN DO: 
               ASSIGN WCREATE2.E2instype = "2" . /*A61-0269*/
               /* comment by A61-0269.....
                /* A59-0604 */
               IF DECI(im_vnetprem) = 6981 OR DECI(im_vnetprem) = 7296 OR DECI(im_vnetprem) = 7726 OR DECI(im_vnetprem) = 8073 OR 
                  DECI(im_vnetprem) = 8471 OR DECI(im_vnetprem) = 8974 OR DECI(im_vnetprem) = 9476 OR DECI(im_vnetprem) = 9979 OR
                  DECI(im_vnetprem) = 10474 THEN ASSIGN WCREATE2.E2instype = "2.2" . 
               /* A59-0604 */
               ELSE WCREATE2.E2instype = "2" .
               ...end A61-0269...*/
           END.
           ELSE IF INDEX(im_package,"ชั้น 3") <> 0 OR INDEX(im_package,"ชั้น3") <> 0 OR      
                   INDEX(im_packname,"ป.3")   <> 0 OR INDEX(im_packname,"ป. 3") <> 0 THEN    
                      ASSIGN WCREATE2.E2instype = "3" . 
           ELSE IF INDEX(im_package,"ชั้น 5") <> 0 OR INDEX(im_package,"ชั้น5") <> 0 OR    
                   INDEX(im_packname,"ป.5")   <> 0 OR INDEX(im_packname,"ป. 5") <> 0 THEN  
                      ASSIGN WCREATE2.E2instype = "5" .                          
        END.
        RUN pdcreate3-1.
       /* comment by A59-0182 ....
        /* ----  ตัวย่อจังหวัด ------  */
        FIND FIRST brstat.insure WHERE brstat.insure.fname = im_regis NO-LOCK NO-ERROR.
        IF AVAIL brstat.insure THEN nv_prov = brstat.Insure.LName.
        ELSE nv_prov = im_regis.
        ASSIGN  i  = 1    nv_sub  = "".
        IF im_licen = ""  THEN WCREATE2.E22lisen  = "".
        ELSE DO:
            loop_a:
            REPEAT i = 1 TO LENGTH(im_licen):
                IF  INDEX("1234567890" ,SUBSTRING(im_licen,i,1)) = 0 THEN
                    nv_sub   = nv_sub + SUBSTRING(im_licen,i,1).
                ELSE   LEAVE loop_a.
            END.
            IF INDEX("1234567890" , SUBSTRING(im_licen,i,1)) <> 0 THEN                                                                  
                WCREATE2.E22lisen   = TRIM(SUBSTRING(im_licen,1,2) + " " + SUBSTRING(im_licen,3,LENGTH(im_licen)) + " " + nv_prov).     
            ELSE  WCREATE2.E22lisen   = TRIM(nv_sub + " " + SUBSTRING(im_licen,LENGTH(nv_sub) + 1,LENGTH(im_licen) ) + " " + nv_prov).  
            
        END.
        /*-------- หากรมธรรม์เดิม --------------*/
        ASSIGN n_tariff = "".
        IF WCREATE2.E2typins = "CMI"  THEN ASSIGN n_tariff = "9".
        ELSE ASSIGN n_tariff = "X".
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = WCREATE2.E2chassis) AND sicuw.uwm301.tariff = n_tariff NO-LOCK  NO-ERROR.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN  n_pol   = ""    n_recnt = 0     n_encnt = 0     
                        n_pol   = sicuw.uwm301.policy 
                        n_recnt = sicuw.uwm301.rencnt 
                        n_encnt = sicuw.uwm301.endcnt .
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy = n_pol   AND 
                          sicuw.uwm100.rencnt = n_recnt AND sicuw.uwm100.endcnt = n_encnt NO-LOCK NO-ERROR .
                    IF AVAIL sicuw.uwm100 THEN DO:
                        ASSIGN  WCREATE2.im2bran  = sicuw.uwm100.branch
                                WCREATE2.E2oldpol = sicuw.uwm100.policy.
                    END. 
                    ELSE 
                        ASSIGN WCREATE2.im2bran  = ""   
                               WCREATE2.E2oldpol = "".
            END.
            ELSE DO: 
                ASSIGN WCREATE2.im2bran  = ""   
                       WCREATE2.E2oldpol = "".
            END.
        .... End A59-0182 ....*/
        /*-- ความคุ้มครอง ---*/
       IF  (WCREATE2.E2typins = "VMI") AND (index(WCREATE2.E2CVMI,"310") <> 0 ) THEN  WCREATE2.E2CVMI = nv_pack + "320". 

       IF WCREATE2.E2instype <> "T" THEN DO:
         IF trim(WCREATE2.E2CVMI) = "Z610"  THEN  ASSIGN nv_promo = "BIGBIKE" .
         FIND FIRST brstat.insure USE-INDEX insure01  WHERE 
             /*Insure.compno   = fi_campaignkl          AND*/ /*A59-0182*/
             trim(brstat.Insure.compno)   = "KL-PACK"   AND     /*A59-0182*/
             INDEX(brstat.insure.text2,nv_promo) <> 0   AND    /* A61-0269*/
             trim(brstat.insure.Text3)    = trim(WCREATE2.E2CVMI)    AND 
             trim(brstat.insure.text1)    = trim(WCREATE2.im2garage) AND     /*A59-0182*/
             trim(brstat.insure.vatcode)  = trim(WCREATE2.E2instype) NO-LOCK  NO-ERROR.
         IF AVAIL brstat.insure THEN  
             ASSIGN
             WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
             WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
             WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
             WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
             WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
             WCREATE2.no43            =  DECI(brstat.insure.telno)
             wcreate2.campaign        =  IF nv_promo = "BIGBIKE" THEN "" ELSE TRIM(brstat.insure.text4). /*A61-0269*/
       END.
       /* create A61-0269 */
       ASSIGN  n_year = 0     
               n_year = (YEAR(TODAY) - INT(WCREATE2.E2YEAR)) + 1.
       IF WCREATE2.E2instype = "1" AND n_year <= 5 AND (INDEX(WCREATE2.E2make,"KIA") <> 0 ) OR 
         (INDEX(WCREATE2.E2make,"SSANGYONG") <> 0 ) THEN RUN PDCHK_CAMP_RE.
       IF WCREATE2.E2instype = "2" OR WCREATE2.E2instype = "3" THEN RUN PDCHK_CAMP_RE.
       /* end A61-0269 */

       /*--- ที่อยู่---*/
       IF index(WCREATE2.im2tprov,"กรุงเทพ") <> 0 THEN  DO:
           ASSIGN
           WCREATE2.im2ttumb = "แขวง" + WCREATE2.im2ttumb
           WCREATE2.im2tamph = "เขต"  + WCREATE2.im2tamph
           WCREATE2.im2tprov = "กรุงเทพฯ".
       END.
       ELSE DO:
           ASSIGN                                           
               WCREATE2.im2ttumb = "ต."  + WCREATE2.im2ttumb 
               WCREATE2.im2tamph = "อ."  + WCREATE2.im2tamph
               WCREATE2.im2tprov = "จ."  + WCREATE2.im2tprov.
       END.
       IF WCREATE2.im2thome <> "" THEN DO:
           IF WCREATE2.im2tmoobr <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.im2tmoobr). 
           IF WCREATE2.im2troom  <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2troom).
           IF WCREATE2.im2thome  <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2thome) .
           IF WCREATE2.im2tmoo   <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2tmoo). 
           IF WCREATE2.im2tsoi   <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2tsoi).
           IF WCREATE2.im2troad  <> "" THEN WCREATE2.EAddress1  = trim(WCREATE2.EAddress1 + " " + WCREATE2.im2troad).
           ASSIGN 
               WCREATE2.EAddress2  = WCREATE2.im2ttumb
               WCREATE2.EAddress3  = WCREATE2.im2tamph
               WCREATE2.EAddress4  = WCREATE2.im2tprov  + " " + WCREATE2.im2tpost .         
       END.                                                                                 
       ELSE DO:  /* ---- Suthida T. A54-0010 ----- */                                  
           ASSIGN                                                                           
               WCREATE2.EAddress1  = TRIM(im_moobr) + " " + trim(im_room) + " " +  trim(im_home) + " " 
                                     + trim(im_moo) + " " + trim(im_soi)   + " " + trim(im_road)                      
               WCREATE2.EAddress2  = WCREATE2.im2ttumb
               WCREATE2.EAddress3  = WCREATE2.im2tamph
               WCREATE2.EAddress4  = WCREATE2.im2tprov  + " " + WCREATE2.im2tpost .
       END.

       IF im_drinam1 = " " AND im_drinam2 = " " THEN WCREATE2.E2driver   = "ไม่มี".
       ELSE WCREATE2.E2driver   = "มี".
       nv_1 = 0.
       nv_2 = 0.

       IF WCREATE2.E2typins = "CMI" THEN DO:
           FIND FIRST wcreate WHERE WCREATE.Eapplino = WCREATE2.E2applino NO-ERROR.
           IF AVAIL wcreate THEN DO:
               FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601 WHERE
                   sicsyac.xmm106.tariff =  "9"                AND
                   sicsyac.xmm106.bencod =  "COMP"             AND
                   sicsyac.xmm106.covcod =  "T"                AND
                   sicsyac.xmm106.class  =  WCREATE2.E2CVMI    AND
                   sicsyac.xmm106.key_b  GE 0.00               AND
                   sicsyac.xmm106.effdat LE DATE(WCREATE.Eeffecdat) NO-LOCK NO-ERROR NO-WAIT.
               IF AVAIL xmm106 THEN DO:
                   ASSIGN
                       nv_prmp  = xmm106.baseap 
                       nv_stamp = TRUNCATE(((nv_prmp * 0.4) / 100),0).
                   IF nv_stamp < nv_prmp  THEN nv_stamp1 = nv_stamp + 1.
                   ELSE nv_stamp1 = nv_stamp.
                   nv_vatp  = ((nv_prmp + nv_stamp1) * 7) / 100.
                   nv_totalp = nv_prmp + nv_stamp1 + nv_vatp.
               END.
               ASSIGN
                   WCREATE2.E2prmp     = DECI(TRIM(im_cnetprem))  
                   WCREATE2.E2totalp   = DECI(TRIM(im_ctprem))
                   nv_1 = DECI(WCREATE.Enetprm)   
                   nv_2 = DECI(WCREATE.Egrossprm)
                   nv_1 = nv_1 -  nv_prmp
                   nv_2 = nv_2 -  nv_totalp
                   WCREATE.Enetprm     = STRING(nv_1)     
                   WCREATE.Egrossprm   = STRING(nv_2) .  
           END.
       END.
    END.
END. /*End ra_type*/ /*-- end A59-0029 --*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdcreate3-1 C-Win 
PROCEDURE pdcreate3-1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0182      
------------------------------------------------------------------------------*/
 /* ----  ตัวย่อจังหวัด ------  */
 FIND FIRST brstat.insure WHERE brstat.insure.fname = im_regis NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN nv_prov = brstat.Insure.LName.
    ELSE nv_prov = im_regis.
    ASSIGN  i  = 1    nv_sub  = "".
 /* ทะเบียนรถ */
 IF im_licen = ""  THEN WCREATE2.E22lisen  = "".
 ELSE DO:
     IF INDEX(im_licen," ") <> 0 OR INDEX(im_licen,"  ") <> 0 THEN ASSIGN im_licen = trim(REPLACE(im_licen," ","")). /*A59-0182*/
     loop_a:
     REPEAT i = 1 TO LENGTH(im_licen):
         IF  INDEX("1234567890" ,SUBSTRING(im_licen,i,1)) = 0 THEN
             nv_sub   = nv_sub + SUBSTRING(im_licen,i,1).
         ELSE   LEAVE loop_a.
     END.
     IF INDEX("1234567890",SUBSTRING(im_licen,1,1)) <> 0 THEN
         WCREATE2.E22lisen   = TRIM(SUBSTRING(im_licen,1,3) + " " + SUBSTRING(im_licen,4,LENGTH(im_licen)) + " " + nv_prov). /*A59-0182*/
     ELSE WCREATE2.E22lisen  = TRIM(SUBSTRING(im_licen,1,2) + " " + SUBSTRING(im_licen,3,LENGTH(im_licen)) + " " + nv_prov). /*A59-0182*/
 END.
 /*-------- หากรมธรรม์เดิม --------------*/
 ASSIGN n_tariff = "".
 IF WCREATE2.E2typins = "CMI"  THEN ASSIGN n_tariff = "9".
 ELSE ASSIGN n_tariff = "X".
 FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = WCREATE2.E2chassis) AND sicuw.uwm301.tariff = n_tariff NO-LOCK  NO-ERROR.
       IF AVAIL sicuw.uwm301 THEN DO:
           ASSIGN  n_pol   = ""    n_recnt = 0     n_encnt = 0     
                   n_pol   = sicuw.uwm301.policy 
                   n_recnt = sicuw.uwm301.rencnt 
                   n_encnt = sicuw.uwm301.endcnt .
           FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                         sicuw.uwm100.policy = n_pol   AND 
                         sicuw.uwm100.rencnt = n_recnt AND 
                         sicuw.uwm100.endcnt = n_encnt NO-LOCK NO-ERROR .
               IF AVAIL sicuw.uwm100 THEN DO:
                   ASSIGN  WCREATE2.im2bran  = sicuw.uwm100.branch
                           WCREATE2.E2oldpol = sicuw.uwm100.policy. 
                    FIND LAST sicuw.uwm120  USE-INDEX uwm12001  WHERE 
                                    uwm120.policy = uwm100.policy AND                
                                    uwm120.rencnt = uwm100.rencnt AND 
                                    uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.  
                       IF AVAIL sicuw.uwm120 THEN ASSIGN WCREATE2.E2CVMI = uwm120.CLASS.                               
               END. 
               ELSE ASSIGN WCREATE2.im2bran  = ""   WCREATE2.E2oldpol = "".
       END.
       ELSE DO: 
         FIND LAST sicuw.uwm301 USE-INDEX uwm30102 WHERE (sicuw.uwm301.vehreg = WCREATE2.E22lisen) AND 
                                                         sicuw.uwm301.tariff = n_tariff NO-LOCK  NO-ERROR.
           IF AVAIL sicuw.uwm301 THEN DO:
               ASSIGN  n_pol   = ""    n_recnt = 0     n_encnt = 0     
                   n_pol   = sicuw.uwm301.policy 
                   n_recnt = sicuw.uwm301.rencnt 
                   n_encnt = sicuw.uwm301.endcnt .
               FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                            sicuw.uwm100.policy = n_pol   AND 
                            sicuw.uwm100.rencnt = n_recnt AND 
                            sicuw.uwm100.endcnt = n_encnt NO-LOCK NO-ERROR .
                   IF AVAIL sicuw.uwm100 THEN DO:
                       ASSIGN  WCREATE2.im2bran  = sicuw.uwm100.branch
                               WCREATE2.E2oldpol = sicuw.uwm100.policy. 
                    FIND LAST sicuw.uwm120  USE-INDEX uwm12001  WHERE 
                                    uwm120.policy = uwm100.policy AND                
                                    uwm120.rencnt = uwm100.rencnt AND 
                                    uwm120.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.  
                       IF AVAIL sicuw.uwm120 THEN ASSIGN WCREATE2.E2CVMI = uwm120.CLASS.                               
               END. 
               ELSE ASSIGN WCREATE2.im2bran  = ""   WCREATE2.E2oldpol = "".
           END.
           ELSE ASSIGN WCREATE2.im2bran  = ""   WCREATE2.E2oldpol = "".
       END.
  
    IF wcreate2.e2typins = "CMI" AND wcreate2.E2oldpol <> "" AND WCREATE2.E2CVMI = "610" THEN WCREATE2.E2CVMI = "130D". /*Big bike V74 */
     /*------ หาสาขา ----*/
    IF WCREATE2.im2bran = "" THEN  
       IF trim(im_contractno) <> "" THEN DO:
          FIND FIRST stat.insure USE-INDEX insure02 WHERE stat.insure.insno = SUBSTR(TRIM(im_contractno),2,2) 
                                                      AND stat.insure.compno = "KL-BR"  NO-LOCK NO-ERROR.
           IF AVAIL stat.insure THEN ASSIGN WCREATE2.im2bran = stat.Insure.Branch.
           ELSE ASSIGN WCREATE2.im2bran ="M".
       END.
       ELSE ASSIGN WCREATE2.im2bran ="M".
    /* อายุผู้ขับขี่ */
    IF WCREATE2.E2drinam1 <> " "  AND WCREATE2.E2dribht1 <> " " THEN DO: 
        ASSIGN  WCREATE2.E2driyer1 = STRING(INT(SUBSTR(WCREATE2.E2dribht1,7,4)) - 543)
                WCREATE2.E2driage1 = STRING(YEAR(TODAY) - INT(WCREATE2.E2driyer1)).
    END.
    IF WCREATE2.E2drinam2 <>  " " AND WCREATE2.E2dribht2 <> " " THEN DO: 
        ASSIGN  WCREATE2.E2driyer2 = STRING(INT(SUBSTR(WCREATE2.E2dribht2,7,4)) - 543)
                WCREATE2.E2driage2 = STRING(YEAR(TODAY) - INT(WCREATE2.E2driyer2)).
    END.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCREATE4 C-Win 
PROCEDURE PDCREATE4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: File NEW A61-0269      
------------------------------------------------------------------------------*/
DEF VAR n_model AS CHAR FORMAT "x(20)" INIT "" .
DEF VAR n_class AS CHAR FORMAT "x(3)" INIT "" .
DO:
    FOR EACH wcreate2 WHERE WCREATE2.E2typins = "VMI" NO-LOCK .
        FIND FIRST wcreate WHERE wcreate.Eapplino = WCREATE2.E2applino NO-LOCK NO-ERROR.
        IF AVAIL wcreate THEN DO:
            IF WCREATE2.E2Year <> STRING(YEAR(TODAY),"9999") AND WCREATE2.E2instype = "1" THEN DO:
                RUN PDCHK_PRO_NEW.
            END. /* end if*/
            ELSE IF WCREATE2.E2YEAR = STRING(YEAR(TODAY),"9999")  AND WCREATE2.E2instype = "1" THEN ASSIGN WCREATE2.im2garage  = "G".
     
            ASSIGN n_model = ""     n_class = ""
                   n_class = SUBSTR(wcreate2.e2cvmi,2,3) .
            IF INDEX(WCREATE2.E2CVMI,"610") <> 0 THEN ASSIGN n_model = "Bigbike" .
            ELSE ASSIGN n_model = TRIM(wcreate2.promo) .

            IF WCREATE2.E2instype = "1" THEN DO:
                 FIND FIRST brstat.insure USE-INDEX insure01  WHERE 
                    trim(brstat.Insure.compno)  = "KL-PACK"                    AND 
                    trim(brstat.insure.text1)   = trim(WCREATE2.im2garage)     AND 
                    INDEX(brstat.insure.text2,n_model) <> 0     AND  
                    INDEX(brstat.insure.Text3,n_class) <> 0     AND
                    trim(brstat.insure.vatcode) = trim(WCREATE2.E2instype)     NO-LOCK  NO-ERROR.
                 IF AVAIL brstat.insure THEN  
                    ASSIGN
                    WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
                    WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
                    WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
                    WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
                    WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
                    WCREATE2.no43            =  DECI(brstat.insure.telno)
                    wcreate2.campaign        =  IF n_model = "Bigbike" THEN "" ELSE TRIM(brstat.insure.text4).
            END. 
            ELSE IF WCREATE2.E2instype = "2" OR WCREATE2.E2instype = "3" THEN  DO:
                 FIND FIRST brstat.insure USE-INDEX insure01  WHERE 
                  trim(brstat.Insure.compno)   = "KL-PACK"                    AND     /*A59-0182*/
                  trim(brstat.insure.vatcode)  = trim(WCREATE2.E2instype)     NO-LOCK  NO-ERROR.
                  IF AVAIL brstat.insure THEN  
                     ASSIGN
                     WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
                     WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
                     WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
                     WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
                     WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
                     WCREATE2.no43            =  DECI(brstat.insure.telno)
                     wcreate2.campaign        =  TRIM(brstat.insure.text4).
            END.
            ELSE DO:
                 FIND FIRST brstat.insure USE-INDEX insure01  WHERE       
                  trim(brstat.Insure.compno)   = "KL-PACK"                AND     /*A59-0182*/
                  INDEX(WCREATE2.E2CVMI,brstat.insure.Text3) <> 0         AND
                  DECI(brstat.insure.text5)    = DECI(WCREATE.Enetprm)    AND     /*A59-0182*/
                  trim(brstat.insure.vatcode)  = trim(WCREATE2.E2instype) NO-LOCK  NO-ERROR.
                  IF AVAIL brstat.insure THEN                             
                     ASSIGN
                     WCREATE2.TPBI_Person     =  DECI(brstat.insure.lName)                       
                     WCREATE2.TPBI_Accident   =  deci(brstat.insure.Addr1)                 
                     WCREATE2.TPPD_Accident   =  DECI(brstat.insure.Addr2)                
                     WCREATE2.no41            =  DECI(brstat.insure.Addr3)                
                     WCREATE2.no42            =  DECI(brstat.insure.Addr4)                
                     WCREATE2.no43            =  DECI(brstat.insure.telno)
                     wcreate2.campaign        =  TRIM(brstat.insure.text4).
            END.
        END.
    END.
    
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Assign C-Win 
PROCEDURE PD_Assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0029 
------------------------------------------------------------------------------*/
/*---- Create by A59-0029 --------*/
IF rs_typ = 4 THEN DO:   
        ASSIGN
            nv_prmp   = 0
            nv_stamp  = 0
            nv_vatp   = 0
            nv_totalp = 0
            nv_error = NO.  
        RUN PDCLEAR2.    
        INPUT FROM VALUE (fi_filename).   
        REPEAT:     
            IMPORT DELIMITER "|"          
                /* comment by A62-0435 ...
                im_no
                im_thname
                im_applino
                im_contractno
                im_effecdat
                im_expirdat
                im_cusname
                im_custype
                im_icno
                im_moobr
                im_room
                im_home
                im_moo
                im_soi
                im_road
                im_tumb
                im_amph
                im_prov
                im_post
                im_benefi
                im_drinam1
                im_dribht1
                im_driid1
                im_dricr1
                im_drinam2
                im_dribht2
                im_driid2
                im_dricr2
                im_package
                im_packname
                im_garage
                im_cvmi
                im_make
                im_model
                im_chass
                im_engno
                im_licen
                im_regis
                im_year
                im_color
                im_class
                im_seat
                im_cc
                im_weight
                im_sumins
                im_access
                im_accdetail
                im_vnetprem
                im_vstamp
                im_vvat
                im_vtprem
                im_vwht
                im_cnetprem
                im_cstamp
                im_cvat
                im_ctprem
                im_cwht
                im_remark
                im_charge
                im_cperson
                im_workdate
                im_srt_pol_no
                im_payment
                im_track
                im_post_no
                im_volu_no
                im_comp_no
                im_status
                im_ispno.
                end A62-0435...*/
                /* create by A62-0435 */
                im_no               /*No                 */ 
                im_thname           /*TH_NAME            */ 
                im_applino          /*APPLICATION_ID     */ 
                im_effecdat         /*EFFECTIVE_DATE     */ 
                im_expirdat         /*EXPIRED_DATE       */ 
                im_cusname          /*CUSNAME            */ 
                im_custype          /*CUS_TYPE           */ 
                im_icno             /*CUS_ID             */ 
                im_moobr            /*MOOBARN            */ 
                im_room             /*ROOM_NUMBER        */ 
                im_home             /*HOME_NUMBER        */ 
                im_moo              /*MOO                */ 
                im_soi              /*SOI                */ 
                im_road             /*ROAD               */ 
                im_tumb             /*TUMBOL             */ 
                im_amph             /*AMPHUR             */ 
                im_prov             /*PROVINCE           */ 
                im_post             /*POST_CODE          */ 
                im_benefi           /*BENEFICIARY        */ 
                im_drinam1          /*DRIVERNAME1        */ 
                im_dribht1          /*D_BIRTH1           */ 
                im_driid1           /*D_ID1              */ 
                im_dricr1           /*D_DRIVE_ID1        */ 
                im_drinam2          /*DRIVERNAME2        */ 
                im_dribht2          /*D_BIRTH2           */ 
                im_driid2           /*D_ID2              */ 
                im_dricr2           /*D_DRIVE_ID2        */ 
                im_garage           /*GARAGE_TYPE        */ 
                im_cvmi             /*TYPE_INSURANCE     */ 
                im_make             /*MAKE_DESCRIPTION1  */ 
                im_model            /*MODEL_DESCRIPTION  */ 
                im_chass            /*CHASSIS            */ 
                im_engno            /*ENGINE             */ 
                im_licen            /*REGISTER_ID        */ 
                im_regis            /*PROVINCE_ID        */ 
                im_year             /*YEAR               */ 
                im_color            /*COLOR              */ 
                im_class            /*VEHICLE_CODE       */ 
                im_seat             /*SEAT               */ 
                im_cc               /*CC                 */ 
                im_weight           /*WEIGHT             */ 
                im_sumins           /*SUMINSURED         */ 
                im_access           /*ACCESSORIES        */ 
                im_accdetail        /*ACCESSORIES_DETAIL */ 
                im_vnetprem         /*V_NET_PREMIUM      */ 
                im_vstamp           /*V_STAMP            */ 
                im_vvat             /*V_VAT              */ 
                im_vtprem           /*V_TOTAL_PREMIUM    */ 
                im_vwht             /*V_WHT1             */ 
                im_cnetprem         /*C_NET_PREMIUM      */ 
                im_cstamp           /*C_STAMP            */ 
                im_cvat             /*C_VAT              */ 
                im_ctprem           /*C_TOTAL_PREMIUM    */ 
                im_cwht             /*C_WHT1             */ 
                im_remark           /*REMARK             */ 
                im_payment          /*PAYMENT            */ 
                im_track            /*TRACKING           */ 
                im_ispno            /*เลขรับแจ้ง         */ 
                im_package  .        /*PACKAGE_NAME       */
                /* end A62-0435 */
            IF im_no = "No" THEN RUN PDCLEAR2.
            RUN PDCREATE.
            RUN PDCREATE3.
            RUN PDCLEAR2.
        END.
END.
/*---- End A59-0029 --------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_report C-Win 
PROCEDURE pd_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfWCREATE2 FOR WCREATE2.
DEFINE VAR nv_cnt    AS INTE INIT 0 .
DEFINE VAR nv_prmp1  AS DECIMAL INIT 0 .
DEFINE VAR nv_totap1 AS DECIMAL INIT 0 .
DEFINE VAR nv_branch AS CHAR.
ASSIGN nv_poltyp    = ""
       nv_producer  = ""
       nv_agent     = ""
       nv_payment   = ""
       nv_Track     = "".                               /*A59-0182*/
IF INDEX(fi_outfile,".csv") = 0  THEN 
    nv_output = fi_outfile + ".csv".
ELSE 
    nv_output = substr(fi_outfile,1,INDEX(fi_outfile,".csv") - 1 ) + ".csv".

OUTPUT TO VALUE(nv_output).    /*out put file full policy */
EXPORT DELIMITER "|"  
    "TEXT FILE FROM K-Leasing"      
    "วันที่คำขอประกันภัย"           
    im1batchdat                  
    "ผู้แจ้งงาน "                      
    "  "      .   
EXPORT DELIMITER "|" 
    "สาขา"                          
    "เลขที่ใบคำขอ"                       
    "เลขที่รับแจ้ง"                 
    "เลขที่สติ๊กเกอร์"              
    "เลขที่กรมธรรม์เดิม"            
    "ประเภทความคุ้มครอง "           
    "ประเภทที่แจ้งงาน"              
    "คำนำหน้าชื่อผู้เอาประกันภัย"   
    "ชื่อผู้เอาประกันภัย"           
    "ชื่อบริษัทรถประจำตำแหน่ง"   
    "Occup./อาชีพ"
    "ID/บัตรประชาชน"
    "ที่อยู่1"                      
    "ที่อยู่2"                      
    "ที่อยู่3"                      
    "ที่อยู่4"                      
    "เบอร์โทรศัพท์"                 
    "ชื่อที่ออกใบกำกับภาษี"         
    "ที่อยู่ออกใบกำกับภาษี"         
    "ชื่อ/นามสกุล1 "                
    "วัน/เดือน/ปีเกิด 1"            
    "อายุ1"                         
    "เลขที่บัตรประชาชน 1"           
    "เลขที่ใบขับขี่1"               
    "ชื่อ/นามสกุล 2"                
    "วัน/เดือน/ปีเกิด2 "            
    "อายุ2"                         
    "เลขที่บัตรประชาชน 2"           
    "เลขที่ใบขับขี่2"               
    "วันที่เริ่มคุ้มครอง"          
    "วันที่สิ้นสุด "               
    "ยี่ห้อ"                       
    "รุ่น"                         
    "ปีที่จดทะเบียน"               
    "ทะเบียนรถ"                    
    "เลขตัวถัง"                    
    "เลขเครื่องยนต์ "                     
    "ขนาดเครื่องยนต์"              
    "น้ำหนัก"                      
    "จำนวนที่นั่ง"     
    "ทุนประกัน "                   
    "เบี้ยสุทธิ "                  
    "เบี้ยรวมภาษีอากร"             
    "เบี้ยพรบ"                     
    "เบี้ยรวมพรบ"                        
    "ซ่อม(0:อู่ห้าง,1:อู่ในเครือ)"       
    "อุปกรณ์เสริม"                       
    "รายละเอียดอุปกรณ์เสริม"             
    "หมายเหตุ"
    "รหัสตัวแทน" 
    "ลักษณะการใช้งาน"      
    "Pol_Type 70/72/74"    
    "Per Person (BI)"      
    "Per Accident"         
    "Per Accident(PD)"     
    "4.1 SI."              
    "4.2 Sum"              
    "4.3 Sum"              
    "VATCODE"              
    "ISP_NO"               
    "Campaign"
    "Beneficiary"
    "Producer"
    "Agent"
    "Payment"
    "Tracking"
    "Promotion".

FOR EACH WCREATE WHERE WCREATE.Eapplino <> "" NO-LOCK BY WCREATE.Eapplino :
    FOR EACH WCREATE2 /*NO-LOCK*/ WHERE WCREATE2.E2applino = WCREATE.Eapplino 
        BY WCREATE2.E2applino
        BY WCREATE2.E2instype .
         /*A59-0182*/
         IF WCREATE.Etrantyp = "RENEW" THEN DO:
            /*--Policy type--*/
            IF WCREATE2.E2typins = "CMI" THEN DO:
                IF INDEX(WCREATE2.E2CVMI,"130") <> 0 AND WCREATE2.E2oldpol <> " " THEN ASSIGN nv_poltyp =  "V74".
                ELSE ASSIGN nv_poltyp = "V72".
            END.
            ELSE ASSIGN nv_poltyp = "V70". 
            /*--Producer, agent code ---*/
            IF WCREATE2.im2bran = "W" THEN DO: 
                IF INDEX(WCREATE2.E2make,"NISSAN") <> 0 THEN
                     ASSIGN wcreate2.producer = "B3M0025"  
                            wcreate2.agent    = "B3M0025".
                ELSE ASSIGN wcreate2.producer = "A0M0054"
                            wcreate2.agent    = "B3M0025".
            END.
            ELSE DO:
                IF INDEX(WCREATE2.E2CVMI,"610") <> 0 OR INDEX(WCREATE2.E2CVMI,"130") <> 0 THEN DO:
                    ASSIGN wcreate2.producer = "A0M0127"      wcreate2.agent    = "B3M0025".
                END.
                ELSE DO:
                    IF index(WCREATE2.E2make,"BENZ") <> 0 AND WCREATE2.E2instype = "1" THEN DO:
                        ASSIGN wcreate2.producer = "A0M0071"      wcreate2.agent    = "B3M0025".
                    END.
                    ELSE IF index(WCREATE2.E2make,"BENZ") <> 0 AND WCREATE2.E2instype = "T" AND WCREATE2.im2garage = "G" THEN DO:
                        ASSIGN wcreate2.producer = "A0M0071"      wcreate2.agent    = "B3M0025".
                    END.
                    /* start a59-0604 */
                    /*ELSE IF WCREATE2.E2instype = "2.2" OR WCREATE2.E2instype = "3.3" THEN DO:
                        ASSIGN wcreate2.producer = "B3M0045"      wcreate2.agent    = "B3M0025".
                    END. 
                    ELSE IF(INDEX(WCREATE2.E2sticker,"ชั้น2") <> 0 OR INDEX(WCREATE2.E2sticker,"ชั้น 2") <> 0 ) AND WCREATE2.E2instype = "T" THEN DO:
                        ASSIGN wcreate2.producer = "B3M0045"      wcreate2.agent    = "B3M0025".
                    END.*/
                    ELSE  ASSIGN wcreate2.producer = "A0M0054"     wcreate2.agent    = "B3M0025".
                END.
            END.
        END.
        ELSE DO:
             /*--Policy type--*/
            IF WCREATE2.E2typins = "CMI" THEN ASSIGN nv_poltyp = "V72".
            ELSE ASSIGN nv_poltyp = "V70". 

            IF WCREATE2.E2typins = "VMI" THEN DO:
                IF index(WCREATE2.E2pattern ,"12_NN") <> 0 THEN ASSIGN wcreate2.producer = "A0M0127" . 
                ELSE if (index(WCREATE2.E2pattern,"01_NN") <> 0) AND (INDEX(trim(E2make),"BENZ") <> 0 ) THEN 
                    ASSIGN wcreate2.producer =  "A0M0071" .
                ELSE if (index(WCREATE2.E2pattern,"_NN") <> 0) AND trim(WCREATE2.E2YEAR) = STRING(YEAR(TODAY),"9999") THEN  
                    ASSIGN wcreate2.producer = "A0M0068". 
                ELSE ASSIGN wcreate2.producer = "A0M0054" .
            END.
            ELSE DO:
                IF index(WCREATE2.E2pattern ,"12_NN") <> 0 THEN Assign wcreate2.producer = "A0M0127" . 
                ELSE if (index(WCREATE2.E2pattern,"01_NN") <> 0) AND (INDEX(trim(E2make),"BENZ") <> 0 ) THEN 
                    ASSIGN wcreate2.producer =  "A0M0071" .
                ELSE if (index(WCREATE2.E2pattern,"_NN") <> 0) AND trim(WCREATE2.E2YEAR) = STRING(YEAR(TODAY),"9999") THEN  
                     ASSIGN wcreate2.producer = "A0M0068". 
                ELSE ASSIGN wcreate2.producer = "A0M0054" .
            END.
            ASSIGN wcreate2.agent = "B3M0025".
        END.
        nv_cnt = nv_cnt + 1.
        EXPORT DELIMITER "|"                   
            WCREATE2.im2bran   
            WCREATE.Eapplino  
            /*WCREATE.Epolclass */ /*A61-0269*/
            IF rs_typ <> 4 THEN WCREATE2.E2text14 ELSE WCREATE.Epolclass  /*A61-0269*/    
            /*WCREATE2.E2sticker   FORMAT "x(20)"  */ /*A59-0604*/
            /*""    */                               /*A59-0604*/ /*a61-0269*/
            IF rs_typ <> 4 THEN WCREATE2.E2sticker ELSE "" /*A61-0269*/
            WCREATE2.E2oldpol                                     
            /*WCREATE2.E2instype */ /*A61-0269*/
            IF WCREATE2.E2instype = " " THEN "T" ELSE WCREATE2.E2instype  /*A61-0269*/
            WCREATE.Etrantyp                                       
            WCREATE.ETinsnam                                        
            WCREATE.THnam     FORMAT "X(60)"  
            WCREATE2.E2text15                                         
            WCREATE.occoup 
            WCREATE.idno   
            WCREATE2.EAddress1                                     
            WCREATE2.EAddress2                                     
            WCREATE2.EAddress3                                     
            WCREATE2.EAddress4                                     
            trim(WCREATE.im1tal + " " + WCREATE.im1fax)    /*WCREATE.EAddress3 */                                     
            WCREATE2.E2text16                                         
            WCREATE2.E2text17                                         
            WCREATE2.E2drinam1                                  
            WCREATE2.E2dribht1                                  
            WCREATE2.E2driage1                                  
            WCREATE2.E2dricr1                                   
            WCREATE2.E2driid1                                   
            WCREATE2.E2drinam2                                  
            WCREATE2.E2dribht2                                  
            WCREATE2.E2driage2                                  
            WCREATE2.E2dricr2                                   
            WCREATE2.E2driid2                                   
            WCREATE.Eeffecdat                                   
            WCREATE.Eexpirdat                                   
            WCREATE2.E2make                                     
            WCREATE2.E2model                                    
            WCREATE2.E2YEAR                                     
            WCREATE2.E22lisen                                   
            WCREATE2.E2chassis                                  
            WCREATE2.E2engine                                   
            WCREATE2.E2cc                                       
            WCREATE2.E2tonnage                                  
            WCREATE2.E2seat  
            WCREATE.Esumins                                                     
            IF WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Enetprm) FORMAT ">,>>>,>>9.99"          
            IF WCREATE2.E2typins = "CMI" THEN "0" ELSE STRING(WCREATE.Egrossprm) FORMAT ">,>>>,>>9.99"        
            STRING(WCREATE2.E2prmp) FORMAT "->>>,>>9.99"                                  
            STRING(WCREATE2.E2totalp) FORMAT "->>>,>>9.99"                               
            WCREATE2.im2garage  /*A59-0029*/                                                    
            WCREATE2.E2access                                        
            WCREATE2.E2aecsdes                                       
            WCREATE2.E2text18 
            WCREATE2.E2pattern 
            WCREATE2.E2CVMI             
            nv_poltyp
            WCREATE2.TPBI_Person  
            WCREATE2.TPBI_Accident
            WCREATE2.TPPD_Accident
            WCREATE2.no41         
            WCREATE2.no42         
            WCREATE2.no43 
            ""
            ""
            WCREATE2.campaign  
            IF index(wcreate2.benefic,"ไม่ติด") <> 0 THEN " " ELSE wcreate2.benefic
            wcreate2.producer
            wcreate2.agent
            wcreate2.payment
            wcreate2.track
            wcreate2.promo. 
        END.
        RELEASE wcreate2.
        ASSIGN
        fi_detype = ""
        fi_detype = "LOAD TEXT" + " " + WCREATE.Etrantyp + " " +  "FILE ".
    END.
/*---- End : A59-0029-----*/
OUTPUT CLOSE.
DISP fi_detype WITH FRAME fr_main.    /* ----- Suthida T. A54-0010 -------- */
ASSIGN
    nv_prmp   = 0
    nv_stamp  = 0
    nv_vatp   = 0
    nv_totalp = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_camp C-Win 
PROCEDURE Proc_camp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcampaign.   
    DELETE wcampaign.   
END.
FIND LAST wcampaign WHERE wcampaign.campno =  brstat.insure.insno  NO-ERROR NO-WAIT.
    IF NOT AVAIL wcampaign THEN DO:
        FOR EACH brstat.insure USE-INDEX insure02 WHERE brstat.insure.insno = fi_campaignkl AND 
                               brstat.insure.compno = fi_campaignkl  NO-LOCK.
        CREATE wcampaign.
        ASSIGN
            wcampaign.campno = brstat.insure.insno 
            wcampaign.id     = brstat.insure.Fname
            wcampaign.cover  = brstat.insure.vatcode 
            wcampaign.pack   = brstat.insure.text3   
            wcampaign.bi     = brstat.insure.Lname  
            wcampaign.pd1    = brstat.insure.addr1   
            wcampaign.pd2    = brstat.insure.addr2  
            wcampaign.n41    = brstat.insure.addr3   
            wcampaign.n42    = brstat.insure.addr4  
            wcampaign.n43    = brstat.insure.telno   
            wcampaign.nname  = brstat.insure.compno.
        
    END.
    RELEASE brstat.insure.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_clear C-Win 
PROCEDURE Proc_clear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  ENABLE rs_typ     WITH FRAM fr_main.
  ENABLE bu_file    WITH FRAM fr_main.
  ENABLE bu_file-2  WITH FRAM fr_main.
  ENABLE fi_outfile WITH FRAM fr_main.

  ASSIGN
    rs_typ        = 1
    fi_filename   = " "
    fi_filename02 = " "
    fi_outfile    = " "
    fi_detype     = " ".

  FOR EACH WCREATE.   DELETE WCREATE.   END.
  FOR EACH WCREATE2.  DELETE WCREATE2.  END.

  DISP rs_typ       bu_file        bu_file-2 fi_outfile 
       fi_filename  fi_filename02  fi_detype WITH FRAM fr_main.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createcomp C-Win 
PROCEDURE proc_createcomp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetailpack.
    DELETE wdetailpack.                                       
END.
FIND LAST brstat.Company WHERE brstat.Company.compno = fi_compa  NO-LOCK NO-ERROR .
IF AVAIL brstat.company THEN DO:
    FOR EACH brstat.Insure NO-LOCK WHERE 
        brstat.Insure.compno = brstat.Company.compno  .
        FIND LAST wdetailpack WHERE wdetailpack.nv_brand = brstat.Insure.LName NO-ERROR.
        IF NOT AVAIL wdetailpack THEN DO:
            CREATE wdetailpack.
            ASSIGN 
                wdetailpack.nv_id    = insure.fname  
                wdetailpack.nv_brand = insure.Text1  
                wdetailpack.nv_pack  = insure.Text2. 
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_occoup C-Win 
PROCEDURE proc_occoup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF      trim(im1occup) = "01"  THEN im1occup =  "ทำธุรกิจเกษตรกรรม".  
ELSE IF trim(im1occup) = "02"  THEN im1occup =  "ค้าขาย".  
ELSE IF trim(im1occup) = "03"  THEN im1occup =  "พนักงานบริษัทเอกชน".  
ELSE IF trim(im1occup) = "04"  THEN im1occup =  "ลูกจ้าง".  
ELSE IF trim(im1occup) = "05"  THEN im1occup =  "ข้าราชการพลเรือน".  
ELSE IF trim(im1occup) = "06"  THEN im1occup =  "ข้าราชการทหาร".  
ELSE IF trim(im1occup) = "07"  THEN im1occup =  "ข้าราชการตำรวจ".  
ELSE IF trim(im1occup) = "08"  THEN im1occup =  "พนักงานรัฐวิสาหกิจ".  
ELSE IF trim(im1occup) = "09"  THEN im1occup =  "รับจ้างทั่วไป".  
ELSE IF trim(im1occup) = "10"  THEN im1occup =  "เลี้ยงสัตว์-ปศุสัตว์".  
ELSE IF trim(im1occup) = "11"  THEN im1occup =  "การประมง".  
ELSE IF trim(im1occup) = "12"  THEN im1occup =  "ทำเหมืองแร่".  
ELSE IF trim(im1occup) = "13"  THEN im1occup =  "อาชีพอิสระ".  
ELSE IF trim(im1occup) = "21"  THEN im1occup =  "การค้าส่ง/ปลีก".  
ELSE IF trim(im1occup) = "22"  THEN im1occup =  "ทำธุรกิจการผลิต".  
ELSE IF trim(im1occup) = "23"  THEN im1occup =  "ทำธุรกิจนำเข้า".  
ELSE IF trim(im1occup) = "24"  THEN im1occup =  "ทำธุรกิจส่งออก".  
ELSE IF trim(im1occup) = "25"  THEN im1occup =  "ทำธุรกิจให้บริการ".  
ELSE IF trim(im1occup) = "26"  THEN im1occup =  "ทำธุรกิจขนส่ง".  
ELSE IF trim(im1occup) = "27"  THEN im1occup =  "แพทย์ พยาบาล".  
ELSE IF trim(im1occup) = "28"  THEN im1occup =  "เจ้าของกิจการ".  
ELSE IF trim(im1occup) = "29"  THEN im1occup =  "นิติบุคคล".  
ELSE IF trim(im1occup) = "31"  THEN im1occup =  "Civil Servant".  
ELSE IF trim(im1occup) = "32"  THEN im1occup =  "State Enterprise".  
ELSE IF trim(im1occup) = "41"  THEN im1occup =  "Employee".  
ELSE IF trim(im1occup) = "42"  THEN im1occup =  "Juristic Person".  
ELSE IF trim(im1occup) = "43"  THEN im1occup =  "Specialist".  
ELSE IF trim(im1occup) = "51"  THEN im1occup =  "Trade".  
ELSE IF trim(im1occup) = "52"  THEN im1occup =  "Agriculture".  
ELSE IF trim(im1occup) = "53"  THEN im1occup =  "Military".  
ELSE IF trim(im1occup) = "54"  THEN im1occup =  "Police Officer".  
ELSE IF trim(im1occup) = "61"  THEN im1occup =  "Peddler".  
ELSE IF trim(im1occup) = "62"  THEN im1occup =  "Public Transport Car".  
ELSE IF trim(im1occup) = "63"  THEN im1occup =  "Temporary Employee".  
ELSE IF trim(im1occup) = "64"  THEN im1occup =  "Housekeeper".  
ELSE IF trim(im1occup) = "65"  THEN im1occup =  "Freelance".  
ELSE IF trim(im1occup) = "66"  THEN im1occup =  "ผู้พิพากษา".  
ELSE IF trim(im1occup) = "67"  THEN im1occup =  "อัยการ".  
ELSE IF trim(im1occup) = "99"  THEN im1occup =  "อื่นๆ".  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

