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

  Created: Porntiwa P. A56-0345  11/11/2013  
  Duplicate Program : WGWARGEN.W
  
  Modify By : Piyachat P. A57-0078  DATE 23-02-2014
              - แก้ไขโปรแกรมนำเข้า Gw transfer ของบริษัท เวิลด์คลาส เรนท์ อะ คาร์ จำกัด (Budget)   
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A57-0228 15/08/2014
            - เพิ่มการนำเข้างานต่ออายุ 70 / 72
            - ปรับ Format การนำเข้า Line 70 / 72
            - ปรับงาน Line 72 ให้นำเข้า Make; Moddes; Body ตามไฟล์ Excel
            - ปรับชื่อที่อยู่ลูกค้าเป็น Code Insure : 0C56114 ทั้งหมด ปรับรองรับกรณีชื่อที่อยู่เปลี่ยนแปลงด้วย
            - เพิ่มความคุ้มครอง MN30 ใส่ใน Text F5
            - Vehicel Use. ใส่ค่าเอง หากไม่มีค่า Default เป็น 2    
            - เพิ่มตัวแปร nv_si_max ; nv_si_min        
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A58-0081   23/02/2015
           - ปรับการนำเข้า New 72 เรื่องคำนวนเบี้ยเต็มปี ไม่เต็มปี และเกินปี
           - ปรับการ Connect งานต่ออายุ เป็น DB Real              
-------------------------------------------------------------------------
Modify By : Tunyaporn K. A58-0265   29/07/2015
           - ปรับการนำเข้าข้อมูลทะเบียนเกิน 11 ตัวอักษร โดย นำเข้าข้อมูลด้วยโปรแกรม Load text file MC Gen   
-------------------------------------------------------------------------         
Modify By : Thitirat M. A58-0418  02/11/2015
           - แก้ไขข้อมูล Vat ; Stamp ให้คิดค่าคุ้มครองไม่เต็มปี  
-------------------------------------------------------------------------
Modify By : Porntiwa T. A59-0409  31/08/2016
          - แก้ไขการคำนวเบี้ยใหม่  
Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
          : Change Host => TMSth   
Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname....    
Modify by : Kridtiya i. A65-0035 comment message error premium not on file                            
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
/*******************************/

DEFINE SHARED VAR n_user AS CHAR.
DEFINE SHARED VAR n_passwd AS CHAR.

/*a490166*/
DEFINE NEW SHARED VAR  nv_batchyr       AS INTE FORMAT "9999"               INIT    0. 
DEFINE NEW SHARED VAR  nv_batcnt        AS INTE FORMAT "99"                 INIT    0. 
DEFINE NEW SHARED VAR  nv_batchno       AS CHAR FORMAT "X(13)"              INIT    ""  NO-UNDO.
                                                                                    
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
DEFINE NEW SHARED VAR  nv_chkstk        AS CHAR FORMAT "9999999999999"      INIT    "".             /*A51-0253*/
DEFINE NEW SHARED VAR  nvw_sticker      AS INTE FORMAT "999999999999"       INIT    0   NO-UNDO.  /*A51-0253*/
DEFINE NEW SHARED VAR  chr_sticker      AS CHAR FORMAT "X(15)".                            /*A51-0253*/
DEFINE NEW SHARED VAR  nv_modulo        AS INTE FORMAT "9".                              /*A50-0165 Shukiat T. Add*/       

DEFINE            VAR  nv_row           AS INTE                             INIT  0.
/*DEFINE STREAM  ns1.*/ 
/*DEFINE STREAM  ns2.*/ 

/*DEFINE STREAM  ns3.*/ 

{wgw\wgwmcgen.i} /*ประกาศตัวแปร*/

/***--- End Old variable ---***/

DEFINE NEW SHARED WORKFILE wendtext  NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".

DEFINE            WORKFILE wdelimi   NO-UNDO
       FIELD txt     AS CHARACTER FORMAT "X(1000)" INITIAL "".

/*DEFINE STREAM nfile.
DEFINE STREAM ndata.*/
DEFINE STREAM nnotdata.
/*DEFINE STREAM outputdata.*/
DEFINE STREAM ns1. 
DEFINE STREAM ns2.
DEFINE STREAM ns3.

DEFINE NEW SHARED VAR nv_line          AS INTE                              INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_delimiter     AS LOGI                                          NO-UNDO.
DEFINE NEW SHARED VAR nv_delimitxt     AS CHAR      FORMAT "X(25)"          INIT ""     NO-UNDO.
                                                    
DEFINE NEW SHARED VAR nv_chr           AS CHAR      FORMAT "X(01)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR sh_policy2       AS CHAR      FORMAT "X(16)"          INIT ""     NO-UNDO.
                                       
DEFINE NEW SHARED VAR nv_text1         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text2         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text3         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text4         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text5         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_text6         AS CHAR      FORMAT "X(100)"         INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_vehreg        AS CHAR      FORMAT "X(12)"          INIT ""     NO-UNDO.

DEFINE NEW SHARED VAR sh_policy        AS CHAR      FORMAT "X(16)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_tiname        AS CHAR      FORMAT "X(70)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_name          AS CHAR      FORMAT "X(70)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR1         AS CHAR      FORMAT "X(35)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR2         AS CHAR      FORMAT "X(35)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR3         AS CHAR      FORMAT "X(35)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_ADDR4         AS CHAR      FORMAT "X(20)"          INIT ""     NO-UNDO.
                                       
DEFINE NEW SHARED VAR nv_trndat        AS DATE      FORMAT "99/99/9999"     INIT TODAY  NO-UNDO.
DEFINE NEW SHARED VAR nv_comdat        AS DATE      FORMAT "99/99/9999"                 NO-UNDO.
DEFINE NEW SHARED VAR nv_expdat        AS DATE      FORMAT "99/99/9999"                 NO-UNDO.
                                       
DEFINE NEW SHARED VAR nv_total         AS DECI      FORMAT ">>>,>>>,>>9.99" INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_count         AS INTE                              INIT 0      NO-UNDO.


DEFINE NEW SHARED VAR nv_data          AS CHAR      FORMAT "X(40)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_notdata       AS CHAR      FORMAT "X(40)"          INIT ""     NO-UNDO.
                                                                                        
DEFINE NEW SHARED VAR nv_rencnt        AS INTE      FORMAT "99"             INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_endcnt        AS INTE      FORMAT "999"            INIT 0      NO-UNDO.
                                                                                        
DEFINE NEW SHARED VAR nv_branch        AS CHAR      FORMAT "X(02)"          INIT ""     NO-UNDO.

DEFINE NEW SHARED VAR nv_com1p         AS DECI                              INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_com1_t        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_prem_t        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_stamp         AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_tax           AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.

DEFINE NEW SHARED VAR nv_undyr         AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_poltyp        AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_sticker       AS INTE      FORMAT "9999999999999".  /*a51-0253*/
DEFINE NEW SHARED VAR nv_sticker1      AS CHAR      FORMAT "X(15)"          INIT ""     NO-UNDO. /*Note Ad on A50-0097 11/05/2007*/ /*a51-0253*/
                                                                                        
DEFINE NEW SHARED VAR nv_insname1      AS CHAR      FORMAT "X(70)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_title         AS CHAR      FORMAT "X(15)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_insref        AS CHAR      FORMAT "X(7)"           INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_acno1         AS CHAR      FORMAT "X(07)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_agent         AS CHAR      FORMAT "X(07)"          INIT ""     NO-UNDO.
                                                                                        
DEFINE NEW SHARED VAR nv_class         AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_modcod        AS CHAR      FORMAT "X(04)"          INIT ""     NO-UNDO.

DEFINE NEW SHARED VAR nv_sity_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_pdst_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_pdty_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.
DEFINE NEW SHARED VAR nv_cost_p        AS DECI      FORMAT ">>>,>>9.99-"    INIT 0.

DEFINE NEW SHARED VAR nv_uom8_c        AS CHAR      FORMAT "X(2)"           INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_uom9_c        AS CHAR      FORMAT "X(2)"           INIT ""     NO-UNDO.
DEFINE NEW SHARED VAR nv_uom8_v        AS DECI      FORMAT ">>>,>>>,>>9.99" INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_uom9_v        AS DECI      FORMAT ">>>,>>>,>>9.99" INIT 0      NO-UNDO.
DEFINE NEW SHARED VAR nv_opnpol        LIKE sicuw.uwm100.opnpol INIT "".
/*---a51-0253---*/
DEFINE NEW SHARED VAR nv_seqno         AS INT.
DEFINE NEW SHARED VAR nv_seqno2        AS INT.
/*---a51-0253---*/
DEFINE NEW SHARED VAR nv_makdes        AS CHAR    FORMAT "X(50)".
DEFINE NEW SHARED VAR n_check          AS CHAR.
DEFINE NEW SHARED VAR nv_typ           AS CHAR.
DEFINE NEW SHARED VAR nv_dept          AS CHAR    FORMAT  "X(1)".
DEFINE NEW SHARED VAR nv_polday        AS INTE    FORMAT ">>9".
DEFINE NEW SHARED VAR nv_subclass      AS CHAR    FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_uwm301trareg  LIKE sic_bran.uwm301.cha_no        INIT "".

DEFINE NEW SHARED VAR s_recid1         AS RECID .     /* uwm100  */
DEFINE NEW SHARED VAR s_recid2         AS RECID .     /* uwm120  */
DEFINE NEW SHARED VAR s_recid3         AS RECID .     /* uwm130  */  
DEFINE NEW SHARED VAR s_recid4         AS RECID .     /* uwm301  */

DEFINE NEW SHARED VAR n_recid301       AS RECID.
DEFINE NEW SHARED VAR n_recid130       AS RECID.
DEFINE NEW SHARED WORKFILE wk_uwd132   LIKE brstat.wkuwd132.
DEFINE BUFFER wf_uwd132 FOR sic_bran.uwd132.
DEFINE VAR nv_body   AS CHAR FORMAT "X(20)".

/*---- Piyachat A56-0078 ------*/
DEFINE VAR nv_pol1    AS INTE.
DEFINE VAR nv_pol2    AS CHAR FORMAT "X(15)".
DEFINE VAR nv_pol3    AS INTE.
DEFINE VAR n_classtxt AS CHAR FORMAT "X(50)".
/*-----------------------------*/

/*-- Add A57-0149 --*/
DEFINE VAR nv_pol70 AS INTE.
DEFINE VAR nv_pol72 AS INTE.
/*-- End A57-0149 --*/

DEFINE VAR nv_si_max AS DECI FORMAT ">>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_si_min AS DECI FORMAT ">>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_devide AS INTEGER                     NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME BROWSE-4

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wgenerage

/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 wgenerage.policy wgenerage.name1 wgenerage.addr1 wgenerage.addr2 wgenerage.addr3 wgenerage.addr4 wgenerage.comdat wgenerage.expdat wgenerage.accdat wgenerage.class wgenerage.makdes /* wgenerage.vehreg */ /*--- A58-0265 Tunyaporn K. ---*/ wgenerage.vehreg /*--- A58-0265 Tunyaporn K. ---*/ wgenerage.cha_no wgenerage.body wgenerage.engine wgenerage.vehusg wgenerage.sticker wgenerage.prem wgenerage.stamp wgenerage.tax wgenerage.rec_status wgenerage.rec_comment   
&Scoped-define ENABLED-FIELDS-IN-QUERY-BROWSE-4   
&Scoped-define SELF-NAME BROWSE-4
&Scoped-define QUERY-STRING-BROWSE-4 FOR EACH wgenerage
&Scoped-define OPEN-QUERY-BROWSE-4 OPEN QUERY {&SELF-NAME} FOR EACH wgenerage.
&Scoped-define TABLES-IN-QUERY-BROWSE-4 wgenerage
&Scoped-define FIRST-TABLE-IN-QUERY-BROWSE-4 wgenerage


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-BROWSE-4}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS BROWSE-4 fi_display fi_vehuse fi_comm ~
ra_type fi_loaddat fi_branch fi_producer fi_agent fi_prevbat fi_bchyr ~
fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem ~
buok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent fi_package fi_class fi_dspc ~
RECT-368 RECT-370 RECT-373 RECT-374 RECT-375 RECT-376 RECT-372 RECT-377 ~
RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_display fi_vehuse fi_comm ra_type ~
fi_loaddat fi_branch fi_bchno fi_producer fi_agent fi_prevbat fi_bchyr ~
fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes ~
fi_impcnt fi_completecnt fi_proname fi_agtname fi_premtot fi_premsuc ~
fi_package fi_class fi_dspc 

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

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
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
     SIZE 44.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comm AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_display AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 121 BY .95
     BGCOLOR 8 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dspc AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

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

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "V70", 1,
"V72", 2,
"R70", 3,
"R72", 4
     SIZE 38.5 BY .95
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

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
DEFINE QUERY BROWSE-4 FOR 
      wgenerage SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE BROWSE-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS BROWSE-4 C-Win _FREEFORM
  QUERY BROWSE-4 DISPLAY
      wgenerage.policy      COLUMN-LABEL "Policy"
 wgenerage.name1       COLUMN-LABEL "Name"
 wgenerage.addr1       COLUMN-LABEL "Address 1"
 wgenerage.addr2       COLUMN-LABEL "Address 2"
 wgenerage.addr3       COLUMN-LABEL "Address 3"
 wgenerage.addr4       COLUMN-LABEL "Address 4"
 wgenerage.comdat      COLUMN-LABEL "Comdat"
 wgenerage.expdat      COLUMN-LABEL "Expdat"
 wgenerage.accdat      COLUMN-LABEL "Accdat"
 wgenerage.class       COLUMN-LABEL "Class"
 wgenerage.makdes      COLUMN-LABEL "Veh. Desc."
 /* wgenerage.vehreg      COLUMN-LABEL "Veh. Reg." */      /*--- A58-0265 Tunyaporn K. ---*/
 wgenerage.vehreg      COLUMN-LABEL "Veh. Reg."  FORMAT "x(15)"       /*--- A58-0265 Tunyaporn K. ---*/
 wgenerage.cha_no      COLUMN-LABEL "Chassic No."
 wgenerage.body        COLUMN-LABEL "Body"
 wgenerage.engine      COLUMN-LABEL "Engine"
 wgenerage.vehusg      COLUMN-LABEL "Veh. Use"
 wgenerage.sticker     COLUMN-LABEL "Sticker"
 wgenerage.prem        COLUMN-LABEL "Premium"
 wgenerage.stamp       COLUMN-LABEL "Stamp"
 wgenerage.tax         COLUMN-LABEL "Tax"
 wgenerage.rec_status  COLUMN-LABEL "Record Status"
 wgenerage.rec_comment COLUMN-LABEL "Comment"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 122 BY 5.24
         BGCOLOR 15 FONT 6 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     BROWSE-4 AT ROW 14.86 COL 3
     fi_display AT ROW 20.19 COL 1.5 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 6.86 COL 110.83 COLON-ALIGNED NO-LABEL
     fi_comm AT ROW 4.67 COL 110.83 COLON-ALIGNED NO-LABEL
     ra_type AT ROW 3.62 COL 83 NO-LABEL
     fi_loaddat AT ROW 3.71 COL 32 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.81 COL 32 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.48 COL 16.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
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
     fi_brndes AT ROW 4.67 COL 52.5 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 4.76 COL 40.67
     fi_impcnt AT ROW 21.91 COL 59.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno1 AT ROW 5.86 COL 49
     fi_completecnt AT ROW 22.91 COL 59.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 6.91 COL 49
     fi_proname AT ROW 5.76 COL 52.5 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.86 COL 52.5 COLON-ALIGNED NO-LABEL
     fi_premtot AT ROW 21.91 COL 97.67 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.95 COL 95.67 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_package AT ROW 3.62 COL 61.83 COLON-ALIGNED NO-LABEL
     fi_class AT ROW 3.62 COL 66 COLON-ALIGNED NO-LABEL
     fi_dspc AT ROW 5.76 COL 110.83 COLON-ALIGNED NO-LABEL
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY 1.05 AT ROW 4.76 COL 23.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Veh.usage :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 6.86 COL 100.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY 1.05 AT ROW 3.71 COL 20.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 13.19 COL 76 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 10.05 COL 13.5
          BGCOLOR 8 FGCOLOR 1 
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY 1.05 AT ROW 13.19 COL 31.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 12.14 COL 14.83
          BGCOLOR 8 FGCOLOR 1 
     "Producer  Code :" VIEW-AS TEXT
          SIZE 17.17 BY 1.05 AT ROW 5.86 COL 15.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "%" VIEW-AS TEXT
          SIZE 3 BY 1 AT ROW 5.76 COL 119.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 13.19 COL 96.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY 1.05 AT ROW 6.91 COL 18.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.48 COL 6
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 127.67 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "%" VIEW-AS TEXT
          SIZE 3 BY 1 AT ROW 4.67 COL 119.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Type :" VIEW-AS TEXT
          SIZE 6.83 BY 1 AT ROW 3.57 COL 75.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Comm. :" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 4.62 COL 100.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.91 COL 116.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.91 COL 95.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY 1.05 AT ROW 9 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.91 COL 95.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 11.1 COL 9.5
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21 BY 1.05 AT ROW 7.95 COL 11
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "DSPC :" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 5.71 COL 100.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.91 COL 58.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS4 01/03/2022":60 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 9.48 COL 105.5 WIDGET-ID 2
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Package :" VIEW-AS TEXT
          SIZE 10 BY .62 AT ROW 3.86 COL 53.33
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1.05 AT ROW 7.95 COL 64.16 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.91 COL 58.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   LOAD TEXT FILE MC BROKER (V70,V72)" VIEW-AS TEXT
          SIZE 122 BY .95 AT ROW 1.62 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.91 COL 116.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-368 AT ROW 12.95 COL 41.67
     RECT-370 AT ROW 1.29 COL 2
     RECT-373 AT ROW 14.57 COL 2
     RECT-374 AT ROW 21.24 COL 2
     RECT-375 AT ROW 21.43 COL 3.5
     RECT-376 AT ROW 21.67 COL 5
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
         TITLE              = "<insert window title>"
         HEIGHT             = 24
         WIDTH              = 126
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
/* BROWSE-TAB BROWSE-4 1 fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bchno IN FRAME fr_main
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
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12.83 BY 1.05 AT ROW 7.95 COL 64.16 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY 1.05 AT ROW 13.19 COL 31.17 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1.05 AT ROW 13.19 COL 76 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.91 COL 58.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.91 COL 95.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.91 COL 58.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.91 COL 95.5 RIGHT-ALIGNED        */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE BROWSE-4
/* Query rebuild information for BROWSE BROWSE-4
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wgenerage.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE BROWSE-4 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
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

    /*--- Comment A57-0149 ---
    IF fi_usrcnt <= 0  THEN DO:
        MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrcnt.
        RETURN NO-APPLY.
    END.
    IF fi_usrprem <= 0  THEN DO:
        MESSAGE "Total Net Premium can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrprem.
        RETURN NO-APPLY.
    END.
    --- End Comment A57-0149 ---*/

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
    nv_batbrn   = TRIM(nv_batbrn).

    /*-- Check Batch No. --*/
    IF nv_batprev = "" THEN DO:  /*-- Check Batch นำเข้าครั้งแรก --*/
        FIND LAST uzm700 USE-INDEX uzm70001
            WHERE uzm700.acno   = fi_Producer AND
                  uzm700.branch = nv_batbrn   AND
                  uzm700.bchyr  = nv_batchyr
        NO-LOCK NO-ERROR.
        IF AVAIL uzm700 THEN DO:  /*-- Running 4 หลักหลัง branch --*/
            nv_batrunno = uzm700.runno.

            FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                      uzm701.bchno = fi_producer + nv_batbrn + STRING(nv_batrunno,"9999")
            NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN DO:
                nv_batcnt   = uzm701.bchcnt.
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

        FIND LAST uzm701 USE-INDEX uzm70102
            WHERE uzm701.bchno = nv_batprev NO-LOCK NO-ERROR NO-WAIT.
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
    /*-- End Check Batch --*/

    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
        fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
        fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
        nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
        nv_tmppolrun = 0                    nv_daily        = ""
        nv_reccnt    = 0                    nv_completecnt  = 0
        nv_netprm_t  = 0                    nv_netprm_s     = 0
        nv_batbrn    = fi_branch            nv_data         = fi_output1
        nv_notdata   = fi_output2.

    RUN wgw\wgwbatch.p (INPUT        fi_loaddat ,     /* DATE  */
                        INPUT        nv_batchyr ,     /* INT   */
                        INPUT        fi_producer,     /* CHAR  */ 
                        INPUT        nv_batbrn  ,     /* CHAR  */
                        INPUT        fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                        INPUT        "WGWMCGEN" ,     /* CHAR  */
                        INPUT-OUTPUT nv_batchno ,     /* CHAR  */
                        INPUT-OUTPUT nv_batcnt  ,     /* INT   */
                        INPUT        nv_imppol  ,     /* INT   */
                        INPUT        nv_impprem       /* DECI  */
                        ).

    ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).

    DISPLAY fi_bchno   WITH FRAME fr_main.

    /*--- Loop Import Policy ---*/
    MESSAGE COLOR YEL/RED SKIP
            "      กด Yes เพื่อ Confirm Process Data    " SKIP
            " พรบ. 72 , ก/ธ 70 " SKIP
             VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO
             TITLE "Warning Message" UPDATE choice AS LOGICAL.
    IF NOT choice THEN DO:
        MESSAGE COLOR YELLOW "ยกเลิกการ Process Data" VIEW-AS ALERT-BOX.  
        RETURN NO-APPLY.
    END.

    /*--- Clear Temp Data ---*/
    FOR EACH wgenerage:
      DELETE wgenerage.
    END.

    FOR EACH wexcel:
      DELETE wexcel.
    END.

    FOR EACH wdelimi:
      DELETE wdelimi.
    END.

    /*-- Comment Phorn --
    RUN Proc_GenData.  /*-- Gen Data --*/
    -- End Comment Phorn --*/
    /*-- Add Phorn --*/
    IF      ra_type = 1 THEN RUN Proc_70Gen.
    ELSE IF ra_type = 2 THEN RUN Proc_72Gen.
    ELSE IF ra_type = 3 THEN RUN Proc_ReGen70.
    ELSE                     RUN Proc_ReGen72.
    /*-- End Phorn --*/

    ASSIGN
        nv_netprm_s  = 0 nv_completecnt = 0 
        nv_rectot    = 0 nv_recsuc      = 0.

    /*-- Not Record Run Batch --*/
    /*IF nv_reccnt = 0 THEN DO:
        MESSAGE "No Record Can Gen" VIEW-AS ALERT-BOX.
    END.*/

    FOR EACH wgenerage WHERE wgenerage.rec_status = "Y":
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + wgenerage.prem .
    END.

    /*-- Update data to uzm701 --*/
    nv_rectot = nv_reccnt.      
    nv_recsuc = nv_completecnt. 

    IF nv_rectot <> nv_recsuc THEN nv_batflg = NO.
    ELSE IF nv_netprm_t <> nv_netprm_s THEN nv_batflg = NO.
    ELSE IF nv_reccnt = 0 THEN nv_batflg = NO.
    ELSE nv_batflg = YES.

    FIND LAST uzm701 USE-INDEX uzm70102
        WHERE uzm701.bchyr  = nv_batchyr AND
              uzm701.bchno  = nv_batchno AND
              uzm701.bchcnt = nv_batcnt  NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        /***--- ไม่มีการระบุ Tax Stamp ไว้ใน Text File ---***/
        ASSIGN
            uzm701.recsuc      = nv_recsuc   
            uzm701.premsuc     = nv_netprm_s 
            uzm701.rectot      = nv_rectot  
            uzm701.premtot     = nv_netprm_t
            uzm701.impflg      = nv_batflg
            uzm701.cnfflg      = nv_batflg .

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

    RUN Proc_Reports.
    RUN Proc_screen  .
    DISPLAY fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.

    /*--- Add A56-0345 -3 ---*/
    RELEASE sic_bran.uzm701.
    RELEASE sicsyac.xmm600.
    /*--- End A56-0345 -3 ---*/
    /*-- End Loop Import Policy --*/

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
         ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/

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
            fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
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


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON LEAVE OF fi_class IN FRAME fr_main
DO:
  fi_package = CAPS(INPUT fi_package).
  DISP fi_package WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class C-Win
ON RETURN OF fi_class IN FRAME fr_main
DO:
  fi_package = CAPS(INPUT fi_package).
  DISP fi_package WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comm C-Win
ON LEAVE OF fi_comm IN FRAME fr_main
DO:
  fi_comm = INPUT fi_comm.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dspc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dspc C-Win
ON LEAVE OF fi_dspc IN FRAME fr_main
DO:
  fi_dspc = INPUT fi_dspc.
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
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
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


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
  fi_vehuse = INPUT fi_vehuse.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_type C-Win
ON VALUE-CHANGED OF ra_type IN FRAME fr_main
DO:
  ra_type = INPUT ra_type.

  IF ra_type = 1 THEN DO:
      fi_comm = "3".
      fi_dspc = "".
      DISPLAY fi_comm fi_dspc WITH FRAME fr_main.
  END.
  ELSE IF ra_type = 2 THEN DO:
      fi_comm = "".
      fi_dspc = "12".
      DISPLAY fi_comm fi_dspc WITH FRAME fr_main.
  END.
  ELSE IF ra_type = 3 THEN DO:
      fi_comm = "3".
      fi_dspc = "".
      DISPLAY fi_comm fi_dspc WITH FRAME fr_main.

      IF CONNECTED("SIC_EXP") THEN DISCONNECT sic_exp.

      IF NOT CONNECTED("SIC_EXP") THEN DO:

          fi_display = "Please wait... Connecting expiry...".
          DISPLAY fi_display WITH FRAME fr_main.

          /*CONNECT -db expiry -ld sic_exp -H devserver -N TCP -S 9060 -U  VALUE(n_user) -P VALUE(n_passwd) .*/
          /*CONNECT -db expiry -ld sic_exp -H alpha4 -S expiry -N TCP -U  VALUE(n_user) -P VALUE(n_passwd)  NO-ERROR.*//*Comment A62-0105*/
          CONNECT -db expiry -ld sic_exp -H tmsth -S expiry -N TCP -U  VALUE(n_user) -P VALUE(n_passwd)  NO-ERROR.
          IF NOT CONNECTED("SIC_EXP") THEN RUN WUW\WUWLOGEX.
          ELSE DO:
              fi_display = "Connect expiry complete...".
              DISPLAY fi_display WITH FRAME fr_main.
          END.
      END.

      IF NOT CONNECTED("SIC_EXP") THEN MESSAGE "Not Connect Expiry".

  END.
  ELSE IF ra_type = 4 THEN DO:
      fi_comm = "".
      fi_dspc = "12".
      DISPLAY fi_comm fi_dspc WITH FRAME fr_main.

      IF CONNECTED("SIC_EXP") THEN DISCONNECT sic_exp.

      IF NOT CONNECTED("SIC_EXP") THEN DO:

          fi_display = "Please wait... Connecting expiry...".
          DISPLAY fi_display WITH FRAME fr_main.

          /*CONNECT -db expiry -ld sic_exp -H devserver -N TCP -S 9060 -U  VALUE(n_user) -P VALUE(n_passwd) .*/
          /*CONNECT -db expiry -ld sic_exp -H alpha4 -S expiry -N TCP -U  VALUE(n_user) -P VALUE(n_passwd)  NO-ERROR.*//*Comment A62-0105*/
          CONNECT -db expiry -ld sic_exp -H tmsth -S expiry -N TCP -U  VALUE(n_user) -P VALUE(n_passwd)  NO-ERROR.
          IF NOT CONNECTED("SIC_EXP") THEN RUN WUW\WUWLOGEX.
          ELSE DO:
              fi_display = "Connect expiry complete...".
              DISPLAY fi_display WITH FRAME fr_main.
          END.
      END.

      IF NOT CONNECTED("SIC_EXP") THEN MESSAGE "Not Connect Expiry".

  END.

  /*--
  ELSE DO:
      fi_comm = "".
      fi_dspc = "".
      DISPLAY fi_comm fi_dspc WITH FRAME fr_main.

      IF CONNECTED("SIC_EXP") THEN DISCONNECT sic_exp.

      IF NOT CONNECTED("SIC_EXP") THEN DO:

          fi_display = "Please wait... Connecting expiry...".
          DISPLAY fi_display WITH FRAME fr_main.

          CONNECT -db expiry -ld sic_exp -H devserver -N TCP -S 9060 -U  VALUE(n_user) -P VALUE(n_passwd) .
          /*CONNECT -db expiry -ld sic_exp -H alpha4 -S expiry -N TCP -U  VALUE(n_user) -P VALUE(n_passwd)  NO-ERROR.*/
          IF NOT CONNECTED("SIC_EXP") THEN RUN WUW\WUWLOGEX.
          ELSE DO:
              fi_display = "Connect expiry complete...".
              DISPLAY fi_display WITH FRAME fr_main.
          END.
      END.

      IF NOT CONNECTED("SIC_EXP") THEN MESSAGE "Not Connect Expiry".

  END.
  ---*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME BROWSE-4
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
  
  gv_prgid = "WGWMCGEN".
  gv_prog  = "Load Excel File Mc Motor".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.

  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/

  RUN  WUT\WUTWICEN (c-win:handle).  
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN
      fi_branch   = "0"
      fi_producer = "B300402"
      fi_agent    = "B300402"
      fi_bchyr    = YEAR(TODAY)
      fi_comm     = "3"
      ra_type     = 1
      fi_vehuse   = "2".
      /*fi_mn30     = "Y".*/

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
       fi_agtname fi_bchyr    fi_comm    fi_brndes 
       ra_type    fi_vehuse  /* fi_mn30  */  WITH FRAME fr_main.
/*********************************************************************/  
  
  fi_package = "Z".
  DISP fi_package WITH FRAME fr_main.

  APPLY "ENTRY" TO fi_branch IN FRAME fr_main.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKProc_70DeBase C-Win 
PROCEDURE BKProc_70DeBase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Comment A57-0228   
------------------------------------------------------------------------------*/
DEFINE VAR nv_base_max AS INTE.
DEFINE VAR nv_base_min AS INTE.
DEFINE VAR i AS INTE.
DEFINE VAR nv_per AS DECI.

FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
          sicsyac.xmm106.tariff  = "X"               AND
          sicsyac.xmm106.bencod  = "BASE"            AND
          sicsyac.xmm106.CLASS   = wgenerage.CLASS   AND
          sicsyac.xmm106.covcod  = wgenerage.covcod  AND
          sicsyac.xmm106.KEY_b  >= nv_key_b          AND
          sicsyac.xmm106.effdat <= wgenerage.comdat  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm106 THEN DO:
    ASSIGN
        nv_base_max = sicsyac.xmm106.max_ap
        nv_base_min = sicsyac.xmm106.min_ap.
END.

nv_baseprm = nv_base_min.

LOOP_CHKPRM:
DO i = 1 TO 10 :
    IF nv_gapprm <> wgenerage.prem THEN DO:

        IF nv_baseprm < nv_base_min OR nv_baseprm > nv_base_max THEN i = 10.
        ELSE DO:
            ASSIGN
                nv_basevar   = " "
                nv_prem1     = nv_baseprm
                nv_basecod   = "BASE"
                nv_basevar1  = "      Base Premium = "
                SUBSTR(nv_basevar,1,30)  = nv_basevar1
                SUBSTR(nv_basevar,31,30) = nv_basevar2.
        END.


        IF nv_gapprm > wgenerage.prem THEN DO: 
            nv_per = 0.
            nv_per = TRUNCATE((nv_gapprm - wgenerage.prem),1).
            nv_per = TRUNCATE((nv_per * 100),1).
            nv_per = ROUND((nv_per / nv_gapprm),2).

            nv_dsspcvar = "".
            nv_dss_per  = nv_per.
            ASSIGN
                nv_dsspcvar1 = "     Discount Special % = "
                nv_dsspcvar2   =  STRING(nv_dss_per)
                SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
                SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.

            RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                       nv_class,
                                       nv_covcod,
                                       nv_key_b,
                                       nv_comdat,
                                       wgenerage.si,
                                       sic_bran.uwm130.uom1_v ,       
                                       sic_bran.uwm130.uom2_v ,       
                                       sic_bran.uwm130.uom5_v ). 

            IF nv_gapprm <> wgenerage.prem THEN DO:
                IF nv_gapprm - wgenerage.prem < 3 THEN DO:

                    ASSIGN
                        nv_dss_per = nv_dss_per + 0.01.

                    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                               nv_class,
                                               nv_covcod,
                                               nv_key_b,
                                               nv_comdat,
                                               wgenerage.si,
                                               sic_bran.uwm130.uom1_v ,       
                                               sic_bran.uwm130.uom2_v ,       
                                               sic_bran.uwm130.uom5_v ). 

                    IF nv_gapprm = wgenerage.prem THEN i = 10.
                END.
                ELSE DO:
                    ASSIGN
                        nv_dss_per = nv_dss_per - 0.01.

                    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                               nv_class,
                                               nv_covcod,
                                               nv_key_b,
                                               nv_comdat,
                                               wgenerage.si,
                                               sic_bran.uwm130.uom1_v ,       
                                               sic_bran.uwm130.uom2_v ,       
                                               sic_bran.uwm130.uom5_v ). 

                    IF nv_gapprm = wgenerage.prem THEN i = 10.
                END.

                /*nv_baseprm = nv_baseprm + 1.*/
                IF nv_baseprm > nv_base_max THEN DO: 
                    nv_baseprm = nv_baseprm - 1.
                END.
                ELSE IF nv_baseprm < nv_base_max THEN DO:
                    
                    IF nv_gapprm > wgenerage.prem THEN DO: 
                        nv_baseprm = nv_baseprm - 1.
                        IF nv_baseprm < nv_base_min THEN nv_baseprm = nv_baseprm + 1.
                    END.
                    ELSE nv_baseprm = nv_baseprm + 1.
                END.

                i = i + 1.
            END.
            ELSE i = 10.
        END.
    END.
END.


/*---
REPEAT:

    IF nv_gapprm <> wgenerage.prem THEN DO:
        
        /*----
        IF wgenerage.prem < nv_base_min THEN nv_baseprm = nv_base_min.
        ELSE IF wgenerage.prem > nv_base_max THEN nv_baseprm = nv_base_max.

        /*---*/
        IF nv_drivcod = "A000" THEN DO:
            nv_baseprm = nv_baseprm - 1.
        END.
        ELSE DO:
            nv_baseprm = nv_baseprm + 1.
        END.
        ---*/

        IF nv_gapprm > wgenerage.prem THEN nv_baseprm = nv_baseprm - 1.
        ELSE IF nv_gapprm < wgenerage.prem THEN nv_baseprm = nv_baseprm + 1.
    
        IF nv_baseprm < nv_base_min OR nv_baseprm > nv_base_max THEN DO:
            LEAVE LOOP_CHKPRM.
        END.
        ELSE DO:
            RUN WGS\WGSORPRM.P (INPUT  nv_tariff, 
                                       nv_class,
                                       nv_covcod,
                                       nv_key_b,
                                       nv_comdat,
                                       wgenerage.si,
                                       sic_bran.uwm130.uom1_v,
                                       sic_bran.uwm130.uom2_v,
                                       sic_bran.uwm130.uom5_v).
        END.
    
    END.
    ELSE LEAVE LOOP_CHKPRM.
END.  /*REPEAT*/

MESSAGE nv_baseprm VIEW-AS ALERT-BOX.
-----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKproc_checkbase C-Win 
PROCEDURE BKproc_checkbase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Comment A57-0228        
------------------------------------------------------------------------------*/

DEFINE VAR nv_bencod1 AS CHARACTER FORMAT "X(4)" INITIAL "" NO-UNDO.

nv_bencod1 = "BASE".

FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
           sicsyac.xmm106.tariff =  "X"        AND
           sicsyac.xmm106.bencod =  "BASE"     AND
           sicsyac.xmm106.class  =  nv_class   AND
           sicsyac.xmm106.covcod =  nv_covcod  AND
           sicsyac.xmm106.key_b  GE nv_key_b   AND
           sicsyac.xmm106.effdat LE nv_comdat
NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm106 THEN DO:
   IF nv_drivcod = "A000" THEN DO:
     nv_baseprm = sicsyac.xmm106.max_ap.
   END.
   ELSE DO:
     nv_baseprm = sicsyac.xmm106.min_ap.
   END.
END.


IF wgenerage.covcod = "3" /*AND rapolicy = 2*/ THEN DO:
    IF fi_package = "R" THEN DO:    
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN ASSIGN nv_ncb = 30 nv_baseprm = 2468.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN ASSIGN nv_ncb = 40 nv_baseprm = 2535.
        ELSE IF wgenerage.class = "210" THEN ASSIGN nv_ncb = 30 nv_baseprm = 3410.
        ELSE IF wgenerage.class = "320" THEN ASSIGN nv_ncb = 30 nv_baseprm = 4140.
    END.
    IF fi_package = "V" THEN DO:
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN nv_baseprm = 2646.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN nv_baseprm = 2657.
        ELSE IF wgenerage.class = "210" THEN nv_baseprm = 3553.
        ELSE IF wgenerage.class = "320" THEN nv_baseprm = 4051.
    END.
    IF fi_package = "Z" THEN DO:
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN nv_baseprm = 2691.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN nv_baseprm = 2341.
        ELSE IF wgenerage.class = "210" THEN nv_baseprm = 3245.
        ELSE IF wgenerage.class = "320" THEN nv_baseprm = 3750.
    END.
    IF fi_package = "P" THEN DO:
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN nv_baseprm = 2638.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN nv_baseprm = 2295.
        ELSE IF wgenerage.class = "210" THEN nv_baseprm = 3925.
        ELSE IF wgenerage.class = "320" THEN nv_baseprm = 3740.
    END.
    
END.
ELSE IF wgenerage.covcod = "1" THEN DO:
    IF      wgenerage.class = "110" THEN nv_baseprm = 7600.
    ELSE IF wgenerage.class = "210" THEN nv_baseprm = 12000.
    ELSE IF wgenerage.class = "320" THEN nv_baseprm = 13000.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKproc_checkcover C-Win 
PROCEDURE BKproc_checkcover :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Comment A57-0228       
------------------------------------------------------------------------------*/
ASSIGN
    nv_411    =  wgenerage.m411
    nv_412    =  wgenerage.m412
    nv_42     =  wgenerage.m42
    nv_43     =  wgenerage.m43 
    nv_bipp00 =  wgenerage.bip
    nv_bipa00 =  wgenerage.bia
    nv_bipd00 =  wgenerage.pda.

IF nv_411 = 0 AND nv_42 = 0 AND nv_43 = 0 AND 
   nv_bipp00 = 0 AND nv_bipa00 = 0 AND nv_bipd00 = 0 THEN DO:

    FIND FIRST stat.clastab_fil WHERE
               stat.clastab_fil.CLASS  = nv_class         AND
               stat.clastab_fil.covcod = nv_covcod AND
               stat.clastab_fil.tariff = "X"              NO-ERROR NO-WAIT.
    IF AVAIL stat.clastab_fil THEN DO:
        ASSIGN
            nv_411    = stat.clastab_fil.si_41unp
            nv_412    = stat.clastab_fil.si_41unp
            nv_42     = stat.clastab_fil.si_42
            nv_43     = stat.clastab_fil.si_43
            nv_seat41 = stat.clastab_fil.dri_41 + clastab_fil.pass_41
            nv_bipp00 = stat.clastab_fil.uom1_si 
            nv_bipa00 = stat.clastab_fil.uom2_si
            nv_bipd00 = stat.clastab_fil.uom5_si .
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKproc_chkredbook C-Win 
PROCEDURE BKproc_chkredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Comment A57-0228       
------------------------------------------------------------------------------*/

/*wexcel.CLASS = SUBSTR(wexcel.CLASS,1,INDEX(wexcel.CLASS," ")).*/ /*----- Piyachat A57-0078 ------*/

n_classtxt = SUBSTR(wexcel.CLASS,1,INDEX(wexcel.CLASS," ")). /*A57-0078*/
nv_moddes  = wexcel.CLASS.  /*A57-0078*/

/*----
FIND FIRST stat.makdes31 WHERE
           stat.makdes31.makdes = "X" AND
           stat.makdes31.moddes = fi_package + wexcel.class1 NO-LOCK NO-ERROR.
IF AVAIL stat.makdes31 THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
               stat.maktab_fil.sclass  = stat.makdes31.moddes  AND
               stat.maktab_fil.makdes  = wexcel.makdes         AND
         INDEX(stat.maktab_fil.moddes,wexcel.CLASS) <> 0       AND
               stat.maktab_fil.makyea  = wexcel.yrmanuf        AND
               stat.maktab_fil.engine <= INTE(wexcel.engine)   NO-LOCK NO-ERROR.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            nv_modcod  = stat.maktab_fil.modcod
            nv_moddes  = stat.maktab_fil.makdes + " " + stat.maktab_fil.moddes
            nv_cargrp  = stat.maktab_fil.prmpac
            nv_body    = stat.maktab_fil.body.
    END.
END.
-----*/

FIND FIRST stat.makdes31 WHERE
           stat.makdes31.makdes = "X" AND
           stat.makdes31.moddes = "Z" + wexcel.class NO-LOCK NO-ERROR.
IF AVAIL stat.makdes31 THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
               stat.maktab_fil.makdes  =  wexcel.makdes        AND
         INDEX(stat.maktab_fil.moddes,n_classtxt) <> 0         AND
         /*INDEX(stat.maktab_fil.moddes,wexcel.CLASS) <> 0       AND*//*A57-0078*/
               stat.maktab_fil.makyea  =  wexcel.yrmanuf       AND
               stat.maktab_fil.engine  =  INTE(wexcel.engine)  AND
               stat.maktab_fil.sclass  =  wexcel.class        AND
              (stat.maktab_fil.si - (stat.maktab_fil.si * stat.makdes31.si_theft_p / 100 ) LE INTE(wexcel.si)   AND 
               stat.maktab_fil.si + (stat.maktab_fil.si * stat.makdes31.load_p / 100 )     GE INTE(wexcel.si) ) AND
               stat.maktab_fil.seats   =  INTE(wexcel.seat)      NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            nv_modcod  = stat.maktab_fil.modcod
            nv_moddes  = stat.maktab_fil.makdes + " " + stat.maktab_fil.moddes
            nv_cargrp  = stat.maktab_fil.prmpac
            nv_body    = stat.maktab_fil.body
            nv_seat41  = stat.maktab_fil.seats.
    END.
    ELSE DO:
        ASSIGN
            nv_simat  = 0
            nv_simat1 = 0
            nv_simat  = DECI(wexcel.si) * 50 / 100 
            nv_simat1 = DECI(wexcel.si) + nv_simat .

        FIND FIRST stat.maktab_fil USE-INDEX      maktab04          WHERE
                   stat.maktab_fil.makdes   =     nv_makdes                  AND                  
                   INDEX(stat.maktab_fil.moddes,SUBSTRING(nv_moddes,1,INDEX(nv_moddes," "))) <> 0  AND
                   stat.maktab_fil.makyea   =     INTEGER(wexcel.yrmanuf) AND
                   stat.maktab_fil.engine   =     INTEGER(wexcel.engine)  AND
                   stat.maktab_fil.sclass   =     "****"                     AND
                   (stat.maktab_fil.si      >=     nv_simat                  OR
                   stat.maktab_fil.si       <=     nv_simat1 )               AND  
                   stat.maktab_fil.seats    =     INTEGER(wexcel.seat)    NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.maktab_fil THEN DO:
            ASSIGN
                nv_modcod  = stat.maktab_fil.modcod                                    
                nv_moddes  = stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                nv_cargrp  = stat.maktab_fil.prmpac
                nv_body    = stat.maktab_fil.body
                nv_seat41  = stat.maktab_fil.seats.

        END.
    END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKproc_cleardata C-Win 
PROCEDURE BKproc_cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Comment A57-0228        
------------------------------------------------------------------------------*/
/*--- nv_drivcod ----*/
ASSIGN nv_drivvar  = " "
       nv_drivcod  = " "
       nv_drivvar1 = " "
       nv_drivvar2 = " "
       SUBSTRING(nv_drivvar,1,30)   = " "
       SUBSTRING(nv_drivvar,31,30)  = " ".
/*---- nv_BasePrem ---*/
ASSIGN nv_prem1    = 0
       nv_basecod  = " "
       nv_basevar1 = " " 
       nv_basevar2 = " "
       SUBSTRING(nv_basevar,1,30)   = " "
       SUBSTRING(nv_basevar,31,30)  = " ".

/*---- nv_usecod ---*/
ASSIGN nv_usecod   = " "
       nv_usevar1  = " "
       nv_usevar2  = " "
       Substring(nv_usevar,1,30)    = " "
       Substring(nv_usevar,31,30)   = " ".
/*--- nv_engcod ---*/
ASSIGN nv_sclass   = " ".

/*----- nv_yrcod ------*/
ASSIGN nv_caryr    = 0
       nv_yrvar1   = " "
       nv_yrvar2   = " "
       nv_yrcod    = " "
       SUBSTRING(nv_yrvar,1,30)     = " "
       SUBSTRING(nv_yrvar,31,30)    = " ".
/*----- nv_sicod ------*/
ASSIGN nv_sicod    = " "
       nv_sivar1   = " "
       nv_sivar2   = " "
       SUBSTRING(nv_sivar,1,30)     = " "
       SUBSTRING(nv_sivar,31,30)    = " ".
/*------ nv_grpcod -----*/
ASSIGN nv_grpcod   = " "
       nv_grpvar1  = " "
       nv_grpvar2  = " "
       SUBSTRING(nv_grpvar,1,30)    = " "
       SUBSTRING(nv_grpvar,31,30)   = " ".
/*------ nv_bipcod ------*/
ASSIGN nv_bipcod   = " "
       nv_bipvar1  = " "
       nv_bipvar2  = " "
       SUBSTRING(nv_bipvar,1,30)    = " "
       SUBSTRING(nv_bipvar,31,30)   = " ".
/*------ nv_biacod -------*/
ASSIGN nv_biacod   = " "
       nv_biavar1  = " "
       nv_biavar2  = " "
       SUBSTRING(nv_biavar,1,30)    = " "
       SUBSTRING(nv_biavar,31,30)   = " ".
/*------- nv_pdacod --------*/
ASSIGN nv_pdacod   = " "
       nv_pdavar1  = " "
       nv_pdavar2  = " "
       SUBSTRING(nv_pdavar,1,30)    = " "
       SUBSTRING(nv_pdavar,31,30)   = " ".
/*--- nv_add perils ---*/
ASSIGN nv_41cod1   = " "
       nv_411var1  = " "
       nv_411var2  = " "
       SUBSTRING(nv_411var,1,30)    = " "
       SUBSTRING(nv_411var,31,30)   = " "
       nv_41cod2   = " "
       nv_412var1  = " "
       nv_412var2  = " "
       SUBSTRING(nv_412var,1,30)    = " "
       SUBSTRING(nv_412var,31,30)   = " "
       nv_411prm   = 0
       nv_412prm   = 0
       nv_42var    = " "       /* -------fi_42---------*/
       nv_42cod    = " "
       nv_42var1   = " "
       nv_42var2   = " "
       SUBSTRING(nv_42var,1,30)     = " "
       SUBSTRING(nv_42var,31,30)    = " "
       nv_43var    = " "      /*---------fi_43--------------*/
       nv_43prm    = 0
       nv_43cod    = " "
       nv_43var1   = " "
       nv_43var2   =  " "
       SUBSTRING(nv_43var,1,30)     = " "
       SUBSTRING(nv_43var,31,30)    = " ".
/*-- NCB ---*/
ASSIGN nv_ncbper = 0
       nv_ncbyrs = 0
       nv_ncb    = 0
       nv_ncb1   = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK_Proc_gen301 C-Win 
PROCEDURE BK_Proc_gen301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Comment A57-0228        
------------------------------------------------------------------------------*/
/*--- Comment Phorn --
RUN proc_cha_no.
---End Comment  ---*/
/*--- Run Red book ---*/
ASSIGN
    nv_cargrp = ""
    nv_modcod = ""
    nv_moddes = ""
    nv_seats  = 0
    nv_body   = ""
    nv_tons   = 0.

IF wgenerage.modcod = "" THEN DO:
    FIND FIRST stat.makdes31 WHERE
               stat.makdes31.makdes = "X" AND
               stat.makdes31.moddes = fi_package + wgenerage.class NO-LOCK NO-ERROR.
    IF AVAIL stat.makdes31 THEN DO:

        FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                   stat.maktab_fil.sclass  = wgenerage.CLASS          AND
                   stat.maktab_fil.makdes  = wgenerage.makdes         AND
             INDEX(stat.maktab_fil.moddes,wgenerage.CLASS) <> 0       AND
                   stat.maktab_fil.makyea  = wgenerage.yrmanuf        AND
                   stat.maktab_fil.engine <= INTE(wgenerage.engine)   AND
                  (stat.maktab_fil.si - (stat.maktab_fil.si * stat.makdes31.si_theft_p / 100 ) LE INTE(wexcel.si)   AND 
                   stat.maktab_fil.si + (stat.maktab_fil.si * stat.makdes31.load_p / 100 )     GE INTE(wexcel.si) ) NO-LOCK NO-ERROR.
        IF AVAIL stat.maktab_fil THEN DO:

            ASSIGN
                nv_modcod  = stat.maktab_fil.modcod
                nv_moddes  = stat.maktab_fil.makdes + " " + stat.maktab_fil.moddes
                nv_cargrp  = stat.maktab_fil.prmpac
                nv_body    = stat.maktab_fil.body
                nv_tons    = stat.maktab_fil.tons.
        END.
        ELSE DO:
            FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
                   stat.maktab_fil.sclass  = wgenerage.CLASS          AND
                   stat.maktab_fil.makdes  = wgenerage.makdes         AND
             INDEX(stat.maktab_fil.moddes,wgenerage.CLASS) <> 0       AND
                   stat.maktab_fil.makyea  = wgenerage.yrmanuf        AND
                   stat.maktab_fil.engine <= INTE(wgenerage.engine)   NO-LOCK NO-ERROR.
            IF AVAIL stat.maktab_fil THEN DO:
                ASSIGN
                    nv_modcod  = stat.maktab_fil.modcod
                    nv_moddes  = stat.maktab_fil.makdes + " " + stat.maktab_fil.moddes
                    nv_cargrp  = stat.maktab_fil.prmpac
                    nv_body    = stat.maktab_fil.body
                    nv_tons    = stat.maktab_fil.tons.
            END.
        END.
    END.
END.
/*--- End Run Redbook ---*/

FIND sic_bran.uwm301 USE-INDEX uwm30101  WHERE
     sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
     sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
     sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
     sic_bran.uwm301.riskgp = 0                       AND
     sic_bran.uwm301.riskno = 1                       AND
     sic_bran.uwm301.itemno = 1                       AND
     sic_bran.uwm301.bchyr  = nv_batchyr              AND 
     sic_bran.uwm301.bchno  = nv_batchno              AND 
     sic_bran.uwm301.bchcnt = nv_batcnt                     
NO-WAIT NO-ERROR.
IF NOT AVAIL sic_bran.uwm301 THEN DO:
    DO TRANSACTION:

        CREATE sic_bran.uwm301.

        ASSIGN
            sic_bran.uwm301.policy    =  sic_bran.uwm100.policy
            sic_bran.uwm301.rencnt    =  sic_bran.uwm100.rencnt
            sic_bran.uwm301.endcnt    =  sic_bran.uwm100.endcnt
            sic_bran.uwm301.riskgp    =  0
            sic_bran.uwm301.riskno    =  1
            sic_bran.uwm301.itemno    =  1
            sic_bran.uwm301.bchyr     =  nv_batchyr       /* batch Year */
            sic_bran.uwm301.bchno     =  nv_batchno       /* bchno      */
            sic_bran.uwm301.bchcnt    =  nv_batcnt        /* bchcnt     */
            sic_bran.uwm301.tariff    =  "X"
            sic_bran.uwm301.covcod    =  wgenerage.covcod
            sic_bran.uwm301.cha_no    =  wgenerage.cha_no
            sic_bran.uwm301.trareg    =  nv_uwm301trareg
            sic_bran.uwm301.eng_no    =  wgenerage.engno
            sic_bran.uwm301.tons      =  nv_tons
            sic_bran.uwm301.engine    =  INTE(wgenerage.engine)
            sic_bran.uwm301.yrmanu    =  wgenerage.yrmanuf
            sic_bran.uwm301.garage    =  ""
            sic_bran.uwm301.body      =  nv_body
            sic_bran.uwm301.mv_ben83  =  wgenerage.finance
            sic_bran.uwm301.vehreg    =  wgenerage.vehreg + " " + wgenerage.provin
            sic_bran.uwm301.vehgrp    =  nv_cargrp
            sic_bran.uwm301.vehuse    =  "2"
            sic_bran.uwm301.modcod    =  nv_modcod
            sic_bran.uwm301.moddes    =  nv_moddes
            sic_bran.uwm301.sckno     =  0
            sic_bran.uwm301.itmdel    =  NO
            sic_bran.uwm301.prmtxt    =  "".
        
        IF sic_bran.uwm301.seats = 0 THEN DO:
            IF      wgenerage.body = "PICKUP" THEN sic_bran.uwm301.seats = 3.
            ELSE IF wgenerage.body = "VAN"    THEN sic_bran.uwm301.seats = 12.
            ELSE sic_bran.uwm301.seats = 7.
        END.

        nv_seats  = sic_bran.uwm301.seats.
        s_recid4  = RECID(sic_bran.uwm301).

    END.  /*DO TRANSACTION*/
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK_proc_gencov C-Win 
PROCEDURE BK_proc_gencov :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Comment A57-0228       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

ASSIGN
    nv_covcod = wgenerage.covcod
    nv_tariff = sic_bran.uwm301.tariff. 

/*--- Driver Name ---*/
ASSIGN
    nv_drivvar   = " "
    nv_drivcod   = "A000"
    nv_drivvar1  = "      Unname Driver"
    nv_drivvar2  = "0"
    SUBSTR(nv_drivvar,1,30)  = nv_drivvar1
    SUBSTR(nv_drivvar,31,30) = nv_drivvar2.

IF wgenerage.base = 0 THEN RUN proc_checkbase.
ELSE nv_baseprm = wgenerage.base.

/*--- Base Premium ---*/
ASSIGN
    nv_prem1     = nv_baseprm
    nv_basecod   = "BASE"
    nv_basevar1  = "      Base Premium = "
    SUBSTR(nv_basevar,1,30)  = nv_basevar1
    SUBSTR(nv_basevar,31,30) = nv_basevar2.

RUN proc_checkcover.

RUN WGS\WGSOPER(INPUT nv_tariff,
                      nv_class,
                      nv_key_b,
                      nv_comdat).

/*--- 411 ---*/
nv_41 = nv_411.
ASSIGN
    nv_41cod1    = "411"
    nv_411var1   = "      PA Driver = "
    nv_411var2   = STRING(nv_411)
    SUBSTR(nv_411var,1,30)  = nv_411var1
    SUBSTR(nv_411var,31,30) = nv_411var2
    nv_411prm    = nv_411.

/*--- 412 ---*/
nv_41 = nv_412.
ASSIGN
    nv_41cod2   = "412"                                   
    nv_412var1  = "     PA Passengers = "                 
    nv_412var2  =  STRING(nv_412)                          
    SUBSTRING(nv_412var,1,30)   = nv_412var1              
    SUBSTRING(nv_412var,31,30)  = nv_412var2              
    nv_412prm  = nv_412.   

/*--- 42 ---*/
nv_42var  = "".
ASSIGN
    nv_42cod     = "42"
    nv_42var1    = "      Medical Expense = "
    nv_42var2    = STRING(nv_42)
    SUBSTR(nv_42var,1,30)   = nv_42var1
    SUBSTR(nv_42var,31,30)  = nv_42var2

/*--- 43 ---*/
nv_43var = "".
ASSIGN
    nv_43prm     = nv_43
    nv_43cod     = "43"
    nv_43var1    = "      Airfrieght = "
    nv_43var2    = STRING(nv_43)
    SUBSTR(nv_43var,1,30)  = nv_43var1
    SUBSTR(nv_43var,31,30) = nv_43var2.

RUN WGS\WGSOPER(INPUT nv_tariff,
                      nv_class ,
                      nv_key_b ,
                      nv_comdat).

/*--- usecod ---*/
ASSIGN
    nv_usecod    = "USE" + TRIM(wgenerage.vehusg)
    nv_usevar1   = "      Vehicle Use = "
    nv_usevar2   = wgenerage.vehusg
    SUBSTR(nv_usevar,1,30)  = nv_usevar1
    SUBSTR(nv_usevar,31,30) = nv_usevar2.

nv_sclass = wgenerage.CLASS.
RUN wgs\wgsoeng.

/*--- yrcod ---*/
ASSIGN
    nv_caryr     = (YEAR(nv_comdat) - wgenerage.yrmanuf) + 1
    nv_yrcod     = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr) ELSE "YR99"
    nv_yrvar1    = "      Vehicle Year = "
    nv_yrvar2    = STRING(wgenerage.yrmanuf)
    SUBSTR(nv_yrvar,1,30)  = nv_yrvar1
    SUBSTR(nv_yrvar,31,30) = nv_yrvar2.

/*--- sicod ---*/
ASSIGN
    nv_sicod     = "SI"
    nv_sivar1    = "      Own Damage = "
    nv_sivar2    = STRING(wgenerage.si)
    SUBSTR(nv_sivar,1,30)  = nv_sivar1
    SUBSTR(nv_sivar,31,30) = nv_sivar2.

/*--- Group Code ---*/
ASSIGN
    nv_grpcod    = "GRP" + nv_cargrp
    nv_grpvar1   = "     Vehicle Group = "
    nv_grpvar2   = nv_cargrp
    SUBSTR(nv_grpvar,1,30)  = nv_grpvar1
    SUBSTR(nv_grpvar,31,30) = nv_grpvar2.

/*--- bipcod ---*/
ASSIGN
    nv_bipcod    = "BI1"
    nv_bipvar1   = "      BI per Person = "
    nv_bipvar2   = STRING(nv_bipp00)
    SUBSTR(nv_bipvar,1,30)  = nv_bipvar1
    SUBSTR(nv_bipvar,31,30) = nv_bipvar2.

/*--- biacod ---*/
ASSIGN
    nv_biacod    = "BI2"
    nv_biavar1   = "      BI per Accident = "
    nv_biavar2   = STRING(nv_bipa00)
    SUBSTR(nv_biavar,1,30)  = nv_biavar1
    SUBSTR(nv_biavar,31,30) = nv_biavar2. 

/*--- PDAc ----*/
ASSIGN
    nv_pdacod    = "PD"
    nv_pdavar1   = "      PD per Accident"
    nv_pdavar2   = STRING(nv_bipd00)
    SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
    SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.

/*--- Fleet ----*/
nv_flet_per = INTE(wgenerage.fleet).
IF nv_flet_per <> 0 AND nv_flet_per <> 10 THEN DO:
END.
IF nv_flet_per = 0 THEN DO:
    nv_flet = 0.
    nv_fletvar = " ".
END.

RUN WGS\WGSORPRM.P (INPUT  nv_tariff, 
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           wgenerage.si,
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).

ASSIGN
    nv_fletvar     = " "                         
    nv_fletvar1    = "     Fleet % = "           
    nv_fletvar2    =  STRING(nv_flet_per)        
    SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1 
    SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.

IF nv_flet  = 0 THEN nv_fletvar = " ".

/*--- NCB ---*/
nv_ncbyrs = 0.
nv_ncbper = 0.
IF wgenerage.ncb <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
               sicsyac.xmm104.tariff  =  "X"        AND
               sicsyac.xmm104.CLASS   =  nv_class   AND
               sicsyac.xmm104.covcod  =  nv_covcod  AND
               sicsyac.xmm104.ncbper  =  INTE(wgenerage.ncb) 
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm104 THEN DO:
        ASSIGN
            nv_ncbyrs  = xmm104.ncbyrs
            nv_ncbper  = xmm104.ncbper.
    END.
END.
ELSE DO: 
    nv_ncbyrs  = 0.
    nv_ncbper  = 0.
    nv_ncb     = 0.
END.

RUN WGS\WGSORPRM.P(INPUT nv_tariff,      
                         nv_class,
                         nv_covcod,      
                         nv_key_b,
                         nv_comdat,      
                         wgenerage.si,
                         uwm130.uom1_v,  
                         uwm130.uom2_v,
                         uwm130.uom5_v).

nv_ncbvar   = " " .
IF nv_ncbper <> 0 THEN DO:
    ASSIGN
        nv_ncbvar1    = "      NCB % = "
        nv_ncbvar2    = STRING(nv_ncbper)
        SUBSTR(nv_ncbvar,1,30)  = nv_ncbvar1
        SUBSTR(nv_ncbvar,31,30) = nv_ncbvar2.
END.

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN 
         sic_bran.uwm100.prem_t = nv_gapprm
         sic_bran.uwm100.sigr_p = INTE(wgenerage.si)
         sic_bran.uwm100.gap_p  = nv_gapprm.
     /*IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = "".*/       
END.

ASSIGN
    nv_stamp  = 0
    nv_tax    = 0
    nv_com1_t = 0.

nv_com1_t = ((nv_pdprm * nv_com1p) / 100) * -1.
IF (nv_pdprm * (0.4 / 100)) - TRUNCATE(nv_pdprm * (0.4 / 100),0) > 0 THEN
     nv_stamp  = TRUNCATE(nv_pdprm * (0.4 / 100),0) + 1.
ELSE nv_stamp  = TRUNCATE(nv_pdprm * (0.4 / 100),0).

nv_tax    = (nv_pdprm + nv_stamp) * (7 / 100).  

FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
         sic_bran.uwm120.gap_r  = nv_gapprm
         sic_bran.uwm120.prem_r = nv_pdprm
         sic_bran.uwm120.sigr   = INTE(wgenerage.si)
         sic_bran.uwm120.com1_r = nv_com1_t
         sic_bran.uwm120.rstp_r = nv_stamp
         sic_bran.uwm120.rtax_r = nv_tax.

 
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        sic_bran.uwm301.mv41seat = INTE(nv_seat41).
        /*sic_bran.uwm301.logbok   = nv_logbok. /*A53-0111*/*/
  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
                         
RUN proc_cleardata.    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK_Proc_GenData C-Win 
PROCEDURE BK_Proc_GenData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Comment A57-0228       
------------------------------------------------------------------------------*/
/*--
FOR EACH wexcel :
    DELETE wexcel.
END.

INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.seqno1   
        wexcel.policy   
        wexcel.sticker  
        wexcel.comdat   
        wexcel.expdat  
        wexcel.comdatcomp
        wexcel.expdatcomp
        wexcel.tiname   
        wexcel.name1    
        wexcel.addr1    
        wexcel.addr2    
        wexcel.addr3    
        wexcel.addr4  
        wexcel.icno
        wexcel.vehreg   
        wexcel.provin   
        wexcel.yrmanuf  
        wexcel.makdes   
        wexcel.class    
        wexcel.engine   
        wexcel.body     
        wexcel.access   
        wexcel.engno    
        wexcel.cha_no   
        wexcel.orderno  
        wexcel.finance  
        wexcel.dealer 
        /*wexcel.class1   *//*phorn*/
        wexcel.remark
        wexcel.si  
        wexcel.bip
        wexcel.bia
        wexcel.pda
        wexcel.m411
        wexcel.m412
        wexcel.m42
        wexcel.m43
        wexcel.prem70   
        wexcel.premtot70
        wexcel.prem     
        wexcel.stamp    
        wexcel.tax      
        wexcel.sumtotal 
        wexcel.covcod 
        wexcel.vehusg   
        wexcel.ncb 
        wexcel.fleet
        wexcel.baseprm
        wexcel.seats
        wexcel.modcod
        wexcel.tran72 
        wexcel.tran70. 

    /*---
    MESSAGE wexcel.seqno1   
        wexcel.policy   
        wexcel.sticker  
        wexcel.comdat   
        wexcel.expdat   
        wexcel.tiname   
        wexcel.name1    
        wexcel.addr1    
        wexcel.addr2    
        wexcel.addr3    
        wexcel.addr4  
        wexcel.icno
        wexcel.vehreg   
        wexcel.provin   
        wexcel.yrmanuf  
        wexcel.makdes   
        wexcel.class    
        wexcel.engine   
        wexcel.body     
        wexcel.access   
        wexcel.engno    
        wexcel.cha_no   
        wexcel.orderno  
        wexcel.finance  
        wexcel.dealer   
        wexcel.si       
        wexcel.class1   
        wexcel.remark   
        wexcel.prem70   
        wexcel.premtot70
        wexcel.prem     
        wexcel.stamp    
        wexcel.tax      
        wexcel.sumtotal 
        wexcel.covcod 
        wexcel.vehusg   
        wexcel.ncb      
        wexcel.baseprm
        wexcel.seats
        wexcel.modcod
        wexcel.tran72  VIEW-AS ALERT-BOX. */

END.  /*REPEAT*/

/*--- Add A57-0149 ---*/
IF wexcel.tran70 = "Y" THEN DO:
    FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
               stat.polno_fil.dir_ri    = YES       AND
               stat.polno_fil.poltyp    = "V70"     AND
               stat.polno_fil.branch    = "0WC" /*fi_branch*/ AND
               stat.polno_fil.undyr     = STRING(YEAR(TODAY) + 543,"9999") AND
               stat.polno_fil.start_no  = "WC" NO-LOCK NO-ERROR.
    IF AVAIL stat.polno_fil THEN DO:
        nv_pol70 = stat.polno_fil.nextno - 1.
    END.
END.
ELSE IF wexcel.tran72 = "Y" THEN DO:
    FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
               stat.polno_fil.dir_ri    = YES       AND
               stat.polno_fil.poltyp    = "V72"     AND
               stat.polno_fil.branch    = "0WC" /*fi_branch*/ AND
               stat.polno_fil.undyr     = STRING(YEAR(TODAY) + 543,"9999") AND
               stat.polno_fil.start_no  = "WC" NO-LOCK NO-ERROR.
    IF AVAIL stat.polno_fil THEN DO:
        nv_pol72 = stat.polno_fil.nextno - 1.
    END.
END.
/*--- End A57-0149 ---*/

FOR EACH wexcel NO-LOCK:

    /*IF wexcel.name1               = ""  THEN NEXT. -- Piyachat A57-0078 --*/
    IF wexcel.prem  = ""  THEN NEXT.
    
    /*IF wexcel.policy = "" THEN sh_policy = "70" + wexcel.orderno.*//*A57-0078*/

    nv_comdat = ?.
    nv_expdat = ?.

    nv_comdat = DATE(wexcel.comdat).
    nv_expdat = DATE(wexcel.expdat).

/*---
    nv_comdat = 
                DATE(INT(SUBSTR(wexcel.comdat,1,2)) ,
                     INT(SUBSTR(wexcel.comdat,4,2)) ,
                     INT("20" + SUBSTR(wexcel.comdat,9,2))     /*note modi*/
                    ).
    nv_expdat =
                DATE(INT(SUBSTR(wexcel.expdat,1,2)) ,
                     INT(SUBSTR(wexcel.expdat,4,2)) ,
                     INT("20" + SUBSTR(wexcel.expdat,9,2))) .    /*note modi*/
---*/
    nv_vehreg = wexcel.vehreg.
    IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
        wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)).
    END.
    ELSE DO:
        wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)).
    END.

    /*-- Add Piyachat A57-0078 --*/
    FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE                   
         sicsyac.xmm600.acno = "0C56114" NO-ERROR NO-WAIT.         
    IF AVAILABLE sicsyac.xmm600 THEN DO:   
        IF wexcel.tiname = "" THEN wexcel.tiname = sicsyac.xmm600.ntitle.  
        IF wexcel.name1  = "" THEN wexcel.name1  = sicsyac.xmm600.NAME. 
        IF wexcel.addr1  = "" THEN wexcel.addr1  = sicsyac.xmm600.addr1.  
        IF wexcel.addr2  = "" THEN wexcel.addr2  = sicsyac.xmm600.addr2.  
        IF wexcel.addr3  = "" THEN wexcel.addr3  = sicsyac.xmm600.addr3.  
        IF wexcel.addr4  = "" THEN wexcel.addr4  = sicsyac.xmm600.addr4.  
        IF wexcel.icno   = "" THEN wexcel.icno   = sicsyac.xmm600.icno.                                                                  
    END.
    ELSE DO: 
        FIND sicsyac.xtm600 USE-INDEX xtm60001 WHERE                             
             sicsyac.xtm600.acno = "0C56114" NO-ERROR NO-WAIT.                   
        IF AVAILABLE sicsyac.xtm600 THEN DO:                                     
            IF wexcel.tiname = "" THEN wexcel.tiname = sicsyac.xtm600.ntitle.  
            IF wexcel.name1  = "" THEN wexcel.name1  = sicsyac.xtm600.NAME.    
            IF wexcel.addr1  = "" THEN wexcel.addr1  = sicsyac.xtm600.addr1.   
            IF wexcel.addr2  = "" THEN wexcel.addr2  = sicsyac.xtm600.addr2.   
            IF wexcel.addr3  = "" THEN wexcel.addr3  = sicsyac.xtm600.addr3.   
            IF wexcel.addr4  = "" THEN wexcel.addr4  = sicsyac.xtm600.addr4.   
            IF wexcel.icno   = "" THEN wexcel.icno   = sicsyac.xtm600.addr1.  
        END.
    END. 
    /*-- End Piyachat A57-0078 --*/

    wexcel.rec_status = "Y".
    RUN proc_chkdatagen.

    IF wexcel.rec_status = "Y" THEN DO:
        IF wexcel.tran70 = "Y" THEN DO:
            /*--- Add A57-0078 ---*/
            /*-- Comment A57-0149 --
            nv_pol1 = LENGTH(wexcel.cha_no).
            nv_pol3 = (nv_pol1 - 8) + 1.
            nv_pol2 = SUBSTRING(wexcel.cha_no,nv_pol3,nv_pol1).
            --- A57-0149 ---*/
            /*-- Add A57-0149 --*/
            nv_pol70 = nv_pol70 + 1.
            nv_pol2 = SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2) + STRING(nv_pol70,"999999").
            /*-- End A57-0149 --*/

            IF wexcel.orderno = "" THEN wexcel.orderno = "70MC" + nv_pol2.
            ELSE wexcel.orderno = "70" + wexcel.orderno.
            IF wexcel.policy = "" THEN sh_policy = wexcel.orderno.
            /*--- End A57-0078 ---*/
            
            CREATE wgenerage.
        
            ASSIGN
                wgenerage.seqno1      =  wexcel.seqno1 
                wgenerage.policy      =  sh_policy
                wgenerage.poltyp      =  "V70"
                wgenerage.sticker     =  wexcel.sticker  
                wgenerage.comdat      =  DATE(wexcel.comdat) 
                wgenerage.expdat      =  DATE(wexcel.expdat) 
                wgenerage.accdat      =  DATE(wexcel.comdat)
                wgenerage.tiname      =  wexcel.tiname   
                wgenerage.name1       =  wexcel.name1    
                wgenerage.addr1       =  wexcel.addr1    
                wgenerage.addr2       =  wexcel.addr2    
                wgenerage.addr3       =  wexcel.addr3    
                wgenerage.addr4       =  wexcel.addr4  
                wgenerage.icno        =  wexcel.icno
                wgenerage.vehreg      =  wexcel.vehreg   
                wgenerage.provin      =  wexcel.provin   
                wgenerage.yrmanuf     =  wexcel.yrmanuf  
                wgenerage.makdes      =  wexcel.makdes   
                wgenerage.class       =  wexcel.class    
                wgenerage.engine      =  wexcel.engine   
                wgenerage.body        =  wexcel.body     
                wgenerage.access      =  wexcel.access   
                wgenerage.engno       =  wexcel.engno    
                wgenerage.cha_no      =  wexcel.cha_no   
                wgenerage.orderno     =  wexcel.orderno  
                wgenerage.finance     =  wexcel.finance  
                wgenerage.dealer      =  wexcel.dealer   
                wgenerage.si          =  wexcel.si 
                wgenerage.bip         =  wexcel.bip  
                wgenerage.bia         =  wexcel.bia  
                wgenerage.pda         =  wexcel.pda  
                wgenerage.m411        =  wexcel.m411 
                wgenerage.m412        =  wexcel.m412 
                wgenerage.m42         =  wexcel.m42  
                wgenerage.m43         =  wexcel.m43  
                /*wgenerage.class1      =  wexcel.class1   *//*phorn*/
                wgenerage.remark      =  wexcel.remark   
                wgenerage.prem70      =  wexcel.prem70   
                wgenerage.premtot70   =  wexcel.premtot70
                wgenerage.prem        =  DECI(wexcel.prem)     
                wgenerage.stamp       =  DECI(wexcel.stamp)    
                wgenerage.tax         =  DECI(wexcel.tax)      
                wgenerage.sumtotal    =  wexcel.sumtotal
                wgenerage.covcod      =  wexcel.covcod
                wgenerage.vehusg      =  wexcel.vehusg   
                wgenerage.ncb         =  wexcel.ncb    
                wgenerage.fleet       =  wexcel.fleet
                wgenerage.baseprm     =  wexcel.baseprm 
                wgenerage.seats       =  wexcel.seats
                wgenerage.modcod      =  wexcel.modcod
        
                wgenerage.rec_status  = "Y"                           
                wgenerage.rec_comment = " " .   
        END.

        IF wexcel.tran72 = "Y" THEN DO:
            /*---------- STR Piyachat A57-0078 ------------*/
            /*--- Comment A57-0149 ---
            nv_pol1 = LENGTH(wexcel.cha_no).
            nv_pol3 = (nv_pol1 - 8) + 1.
            nv_pol2 = SUBSTRING(wexcel.cha_no,nv_pol3,nv_pol1).
            ---- End A57-0149 ----*/

            /*-- Add A57-0149 --*/
            nv_pol72 = nv_pol72 + 1.
            nv_pol2 = SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2) + STRING(nv_pol72,"999999").
            /*-- End A57-0149 --*/

            IF wexcel.orderno = "" THEN wexcel.orderno = "72MC" + nv_pol2.
            ELSE wexcel.orderno = "72" + wexcel.orderno.
            IF wexcel.policy = "" THEN sh_policy = wexcel.orderno.                                                 
            /*---------- END Piyachat A57-0078 ------------*/

            CREATE wgenerage.
        
            ASSIGN
               wgenerage.policy  = sh_policy
               wgenerage.poltyp  = "V72"
               wgenerage.tiname  = wexcel.tiname
               wgenerage.name1   = wexcel.name1                    
               wgenerage.addr1   = wexcel.addr1                     
               wgenerage.addr2   = wexcel.addr2                     
               wgenerage.addr3   = wexcel.addr3                     
               wgenerage.addr4   = wexcel.addr4                     
               wgenerage.icno    = wexcel.icno
               wgenerage.comdat  = DATE(wexcel.comdatcomp)
               wgenerage.expdat  = DATE(wexcel.expdatcomp)                    
               wgenerage.accdat  = DATE(wexcel.comdatcomp) 
               wgenerage.class1  = wexcel.class1
               wgenerage.class   = wexcel.CLASS                   
               wgenerage.makdes  = wexcel.makdes                 
               wgenerage.vehreg  = wexcel.vehreg 
               wgenerage.provin  = wexcel.provin
               wgenerage.cha_no  = wexcel.cha_no                    
               wgenerage.engno   = wexcel.engno
               wgenerage.body    = wexcel.body                      
               wgenerage.engine  = wexcel.engine                    
               wgenerage.yrmanuf = wexcel.yrmanuf
               wgenerage.vehusg  = wexcel.vehusg                    
               wgenerage.sticker = wexcel.sticker                   
               wgenerage.prem    = DECIMAL(wexcel.prem)             
               wgenerage.stamp   = DECIMAL(wexcel.stamp)            
               wgenerage.tax     = DECIMAL(wexcel.tax)              
               wgenerage.rec_status  = "Y"                          
               wgenerage.rec_comment = " " .   
          
            IF INDEX(wgenerage.engine,".") <> 0 THEN DO:        
              nv_count = INDEX(wgenerage.engine,".").
              wgenerage.engine = SUBSTR(wgenerage.engine,1,(nv_count - 1)).
            END.
        END.
    END.
END.  /*FOR EACH wexcel*/

/***--- Check ว่ามีงานที่จะนำเข้าหรือไม่ ---***/
FIND FIRST wgenerage NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE wgenerage THEN DO:
  MESSAGE " Not found data For Generate" VIEW-AS ALERT-BOX.
END.

sh_policy  = "".
nv_line    = 0.

OUTPUT STREAM nnotdata  TO  VALUE(nv_notdata).

FOR EACH wgenerage NO-LOCK:
    ASSIGN
      nv_reccnt   = nv_reccnt + 1 /*note add on 23/05/2007*/
      nv_netprm_t = nv_netprm_t + wgenerage.prem.

    IF wgenerage.poltyp = "V70" THEN RUN proc_check70.
    ELSE IF wgenerage.poltyp = "V72" THEN RUN proc_check72.
END.

OUTPUT STREAM nnotdata  CLOSE.
/***--- Disp Browse ---***/
OPEN QUERY BROWSE-4 FOR EACH wgenerage . 
---*/
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
  DISPLAY fi_display fi_vehuse fi_comm ra_type fi_loaddat fi_branch fi_bchno 
          fi_producer fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 
          fi_output2 fi_output3 fi_usrcnt fi_usrprem fi_brndes fi_impcnt 
          fi_completecnt fi_proname fi_agtname fi_premtot fi_premsuc fi_package 
          fi_class fi_dspc 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE BROWSE-4 fi_display fi_vehuse fi_comm ra_type fi_loaddat fi_branch 
         fi_producer fi_agent fi_prevbat fi_bchyr fi_filename bu_file 
         fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem buok bu_exit 
         bu_hpbrn bu_hpacno1 bu_hpagent fi_package fi_class fi_dspc RECT-368 
         RECT-370 RECT-373 RECT-374 RECT-375 RECT-376 RECT-372 RECT-377 
         RECT-378 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70cha_no C-Win 
PROCEDURE Proc_70cha_no :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Check Chassis...".
DISPLAY fi_display WITH FRAME fr_main.

IF SUBSTRING(wgenerage.cha_no,1,1) = "'" THEN DO:
    wgenerage.cha_no = SUBSTRING(wgenerage.cha_no,2,LENGTH(wgenerage.cha_no)).
END.

DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.

ASSIGN nv_uwm301trareg = wgenerage.cha_no.

    loop_chk1:
    REPEAT:
        IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
            nv_len = LENGTH(nv_uwm301trareg).
            nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
                SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
        END.
        ELSE LEAVE loop_chk1.
    END.
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70Check C-Win 
PROCEDURE Proc_70Check :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: เปลี่ยนชื่อ Procedure จาก proc_Check70 --> Proc_70Check    Add A57-0228   
------------------------------------------------------------------------------*/
/*--- Phorn Comment ---
nv_class = "".
nv_class = fi_package + wgenerage.CLASS.

nv_com1p = 3.  /*Fix Comm. 3%*/
--- End Comment ---*/

fi_display = "Run Create 70 ...".
DISPLAY fi_display WITH FRAME fr_main.

IF fi_comm <> "" THEN nv_com1p  = INTE(fi_comm).
ELSE nv_com1p = 3.

nv_branch = fi_branch.

/*RUN proc_gencr_2.*//*แบบไม่พ่วง พรบ.*/
RUN proc_chkcode . /*A64-0138*/
RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */
RUN Proc_70gen100.
RUN Proc_70gen120.
RUN Proc_70gen130.
RUN Proc_70Cha_no.
RUN Proc_70gen301.
RUN Proc_70gencov.
RUN Proc_GenPrem.

IF wgenerage.rec_status  = "Y" THEN sic_bran.uwm100.impflg = YES.
ELSE sic_bran.uwm100.impflg = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70ChkBase C-Win 
PROCEDURE Proc_70ChkBase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228       
------------------------------------------------------------------------------*/
fi_display = "Check Base Premium ...".
DISPLAY fi_display WITH FRAME fr_main.

FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
          sicsyac.xmm106.tariff  = "X"               AND
          sicsyac.xmm106.bencod  = "BASE"            AND
          sicsyac.xmm106.CLASS   = wgenerage.CLASS   AND
          sicsyac.xmm106.covcod  = wgenerage.covcod  AND
          sicsyac.xmm106.key_b  >= nv_key_b          AND
          sicsyac.xmm106.effdat <= wgenerage.comdat
NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm106 THEN DO:

    /*--
    IF nv_drivcod = "A000" THEN DO:
        nv_baseprm = sicsyac.xmm106.max_ap.
    END.
    ELSE DO:
        nv_baseprm = sicsyac.xmm106.min_ap.
    END.
    ---*/

    IF wgenerage.prem > sicsyac.xmm106.max_ap THEN nv_baseprm = sicsyac.xmm106.max_ap.
    ELSE IF wgenerage.prem < sicsyac.xmm106.max_ap THEN nv_baseprm = sicsyac.xmm106.min_ap.

END.

IF wgenerage.covcod = "3" THEN DO:
    IF fi_package = "R" THEN DO:    
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN ASSIGN nv_ncb = 30 nv_baseprm = 2468.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN ASSIGN nv_ncb = 40 nv_baseprm = 2535.
        ELSE IF wgenerage.class = "210" THEN ASSIGN nv_ncb = 30 nv_baseprm = 3410.
        ELSE IF wgenerage.class = "320" THEN ASSIGN nv_ncb = 30 nv_baseprm = 4140.
    END.
    IF fi_package = "V" THEN DO:
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN nv_baseprm = 2646.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN nv_baseprm = 2657.
        ELSE IF wgenerage.class = "210" THEN nv_baseprm = 3553.
        ELSE IF wgenerage.class = "320" THEN nv_baseprm = 4051.
    END.
    IF fi_package = "Z" THEN DO:
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN nv_baseprm = 2691.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN nv_baseprm = 2341.
        ELSE IF wgenerage.class = "210" THEN nv_baseprm = 3245.
        ELSE IF wgenerage.class = "320" THEN nv_baseprm = 3750.
    END.
    IF fi_package = "P" THEN DO:
        IF      wgenerage.class = "110" AND INTE(wgenerage.engine) <= 2000 THEN nv_baseprm = 2638.
        ELSE IF wgenerage.class = "110" AND INTE(wgenerage.engine) > 2000 THEN nv_baseprm = 2295.
        ELSE IF wgenerage.class = "210" THEN nv_baseprm = 3925.
        ELSE IF wgenerage.class = "320" THEN nv_baseprm = 3740.
    END.
    
END.
ELSE IF wgenerage.covcod = "1" THEN DO:
    IF      wgenerage.class = "110" THEN nv_baseprm = 7600.
    ELSE IF wgenerage.class = "210" THEN nv_baseprm = 12000.
    ELSE IF wgenerage.class = "320" THEN nv_baseprm = 13000.
END.

wgenerage.baseprm = nv_baseprm.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70ChkCover C-Win 
PROCEDURE Proc_70ChkCover :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228       
------------------------------------------------------------------------------*/

ASSIGN
    nv_411    =  wgenerage.m411
    nv_412    =  wgenerage.m412
    nv_42     =  wgenerage.m42
    nv_43     =  wgenerage.m43 
    nv_bipp00 =  wgenerage.bip
    nv_bipa00 =  wgenerage.bia
    nv_bipd00 =  wgenerage.pda.

FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           stat.clastab_fil.CLASS  = wgenerage.CLASS  AND
           stat.clastab_fil.covcod = wgenerage.covcod AND
           stat.clastab_fil.tariff = "X"              NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL stat.clastab_fil THEN DO:

    IF nv_411    = 0 THEN nv_411    = stat.clastab_fil.si_41unp.
    IF nv_412    = 0 THEN nv_412    = stat.clastab_fil.si_41unp.                     
    IF nv_42     = 0 THEN nv_42     = stat.clastab_fil.si_42.                        
    IF nv_43     = 0 THEN nv_43     = stat.clastab_fil.si_43.                        
    
    IF nv_bipp00 = 0 THEN nv_bipp00 = stat.clastab_fil.uom1_si.                      
    IF nv_bipa00 = 0 THEN nv_bipa00 = stat.clastab_fil.uom2_si.                      
    IF nv_bipd00 = 0 THEN nv_bipd00 = stat.clastab_fil.uom5_si.   

    nv_seat41 = stat.clastab_fil.dri_41 + clastab_fil.pass_41. 
 
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70ChkGen C-Win 
PROCEDURE Proc_70ChkGen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228       
------------------------------------------------------------------------------*/
IF wexcel.policy = "" OR SUBSTR(wexcel.policy,1,1) <> "D" /*OR SUBSTR(wexcel.policy,1,1) <> "I"*/ THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| No Policy, Can not transfer ".
END.

IF wexcel.vehreg = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Vehicle Register is mandatory field ".
END.

/*---
IF wexcel.name1 = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Name is mandatory field ".
END.
---*/

IF wexcel.makdes = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Makedes is mandatory field ".
END.
IF wexcel.CLASS = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Moddes is mandatory field ".
END.
IF wexcel.engine = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Engine\CC is mandatory field ".
END.
IF wexcel.yrmanuf = 0 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Year Manuf. is mandatory field ".
END.
IF wexcel.cha_no = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Chassis is mandatory field ".
END.
ELSE DO:
    /*-- Comment A58-0377 --
    FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
              sicuw.uwm301.cha_no = wexcel.cha_no NO-LOCK NO-ERROR.
    --- End A58-0377 --*/
    FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE
              sicuw.uwm301.trareg = wexcel.cha_no AND
              SUBSTR(sicuw.uwm301.policy,3,2) = "70" NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm301 THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = sicuw.uwm301.policy AND
                  sicuw.uwm100.poltyp = "V70"               NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.comdat = DATE(wexcel.comdat) THEN DO:
                ASSIGN
                    wexcel.rec_status  = "N"
                    wexcel.rec_comment = wexcel.rec_comment + "| Chassis : " + wexcel.cha_no + " นำเข้าระบบแล้ว".
            END.
        END.
    END.
END.

/*--
IF wexcel.modcod = "" THEN DO:
    RUN proc_chkredbook.
END.
ELSE DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
               stat.maktab_fil.sclass = wexcel.CLASS      AND 
               stat.maktab_fil.modcod = wexcel.modcod     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            nv_modcod  = stat.maktab_fil.modcod
            nv_moddes  = stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            nv_cargrp  = stat.maktab_fil.prmpac  
            nv_si      = stat.maktab_fil.si
            wexcel.makdes  = stat.maktab_fil.makdes
            wexcel.modcod  = stat.maktab_fil.modcod
            wexcel.seats   = STRING(stat.maktab_fil.seats).

        IF wexcel.covcod = "1" THEN DO:
            FIND FIRST stat.makdes31 WHERE
                       stat.makdes31.makdes = "X"              AND
                       stat.makdes31.moddes = wexcel.class NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.makdes31 THEN DO:
                ASSIGN
                    nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                    nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                    nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                    nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            END.
            ELSE DO:
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
            END.

            IF DECI(wexcel.si) > nv_maxsi  OR  DECI(wexcel.si) < nv_minsi THEN DO:
                IF nv_maxsi = nv_minsi THEN DO:
                    IF nv_maxsi = 0 AND nv_minsi = 0 THEN DO:
                        ASSIGN
                            wexcel.rec_status  = "N"
                            wexcel.rec_comment = "Not Found Sum Insure in Maktab_fil".
                    END.
                    ELSE DO:
                        ASSIGN
                            wexcel.rec_status  = "N"
                            wexcel.rec_comment = "Not Found Sum Insured Rates Maintenance in makdes31 Tariff X".
                    END.
                END.
                ELSE DO:
                    ASSIGN
                        wexcel.rec_status  = "N"
                        wexcel.rec_comment = "Sum Insure must " + nv_mindes + " and " + nv_maxdes.
                END.
            END.
        END.
    END.
END.
-----*/

IF wexcel.class <> "" THEN DO:

    FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
               sicsyac.xmd031.poltyp  = "V70"        AND
               sicsyac.xmd031.CLASS   = wexcel.CLASS NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmd031 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|Not On Business Class xmd031".
    END.

    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
         sicsyac.xmm016.CLASS = wexcel.CLASS NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm016 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|Not on Business class on xmm016".
    END.

    /*--- Phorn Comment --
    IF wexcel.tran70 = "Y" AND wexcel.tran72 = "N" THEN DO:
        FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
                   sicsyac.xmd031.poltyp  = "V70"       AND
                   sicsyac.xmd031.CLASS   = "Z" + wexcel.class NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmd031 THEN DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "|Not On Business Class xmd031".
        END.

        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
             sicsyac.xmm016.CLASS  =  "Z" + wexcel.class NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm016 THEN DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "|Not on Business class on xmm016".
        END.
    END.
    ELSE DO:   /*-- Add A56-0345 -3 --*/
        IF wexcel.tran72 = "Y" AND wexcel.tran70 = "N" THEN DO:
            FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
                       sicsyac.xmd031.poltyp  = "V72"       AND
                       sicsyac.xmd031.CLASS   = wexcel.class NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmd031 THEN DO:
                ASSIGN
                    wexcel.rec_status  = "N"
                    wexcel.rec_comment = wexcel.rec_comment + "|Not On Business Class xmd031".
            END.

            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                 sicsyac.xmm016.CLASS  =  wexcel.class NO-LOCK NO-ERROR.
            IF NOT AVAIL sicsyac.xmm016 THEN DO:
                ASSIGN
                    wexcel.rec_status  = "N"
                    wexcel.rec_comment = wexcel.rec_comment + "|Not on Business class on xmm016".
            END.
        END.
    END.  /*-- END A56-0345 -3 ---*/
    --- End Comment----*/
END.

FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod  = "U014"   AND
     sicsyac.sym100.itmcod  = wexcel.vehusg NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|Not on Vehicle Usage Codes table sym100 u014".
END.

FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod = "U013"    AND
     sicsyac.sym100.itmcod = wexcel.covcod NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|Not on Motor Cover Type Codes table sym100 u013".
END.

IF DECI(wexcel.ncb) = 0  OR DECI(wexcel.ncb) = 20 OR
   DECI(wexcel.ncb) = 30 OR DECI(wexcel.ncb) = 40 OR
   DECI(wexcel.ncb) = 50 THEN.
ELSE DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|not on NCB Rates file xmm104".
END.

IF DECI(wexcel.ncb) <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
               sicsyac.xmm104.tariff = "X"                     AND
               sicsyac.xmm104.CLASS  = wexcel.class            AND
               sicsyac.xmm104.covcod = wexcel.covcod           AND
               sicsyac.xmm104.ncbper = DECI(wexcel.ncb)        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm104 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|This NCB Step not on NCB Rates file xmm104".
    END.
END.
RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70DeBase C-Win 
PROCEDURE Proc_70DeBase :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Check Discount Base...".
DISPLAY fi_display WITH FRAME fr_main.

DEFINE VAR nv_base_max AS INTE.
DEFINE VAR nv_base_min AS INTE.
DEFINE VAR i AS INTE.
DEFINE VAR nv_per AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
          sicsyac.xmm106.tariff  = "X"               AND
          sicsyac.xmm106.bencod  = "BASE"            AND
          sicsyac.xmm106.CLASS   = wgenerage.CLASS   AND
          sicsyac.xmm106.covcod  = wgenerage.covcod  AND
          sicsyac.xmm106.KEY_b  >= nv_key_b          AND
          sicsyac.xmm106.effdat <= wgenerage.comdat  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL sicsyac.xmm106 THEN DO:
    ASSIGN
        nv_base_max = sicsyac.xmm106.max_ap
        nv_base_min = sicsyac.xmm106.min_ap
        nv_baseprm  = nv_base_min.
END.

LOOP_CHKPRM:
DO i = 1 TO 10:

    ASSIGN
        nv_covcod = sic_bran.uwm301.covcod
        nv_class  = wgenerage.CLASS
        nv_tariff = sic_bran.uwm301.tariff.

    /*-- Driver Name --*/
    ASSIGN
        nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  = "      Unname Driver"
        nv_drivvar2  = "0"
        SUBSTR(nv_drivvar,1,30)  = nv_drivvar1
        SUBSTR(nv_drivvar,31,30) = nv_drivvar2.

    /*-- Base Premium --*/
    ASSIGN
        nv_basevar   = " "
        nv_prem1     = nv_baseprm
        nv_basecod   = "BASE"
        nv_basevar1  = "      Base Premium = "
        SUBSTR(nv_basevar,1,30)  = nv_basevar1
        SUBSTR(nv_basevar,31,30) = nv_basevar2.

    /*-- Cover --*/
    fi_display = "Check Cover 2...".
    DISPLAY fi_display WITH FRAME fr_main.

    RUN Proc_70ChkCover.

    /*WGSOPER*/
    RUN WGS\WGSOPER(INPUT nv_tariff,
                          nv_class,
                          nv_key_b,
                          nv_comdat).

    /*-- 411 --*/
    nv_41 = nv_411.
    ASSIGN
        nv_411var    = " "
        nv_41cod1    = "411"
        nv_411var1   = "      PA Driver = "
        nv_411var2   = STRING(nv_411)
        SUBSTR(nv_411var,1,30)  = nv_411var1
        SUBSTR(nv_411var,31,30) = nv_411var2
        nv_411prm    = nv_411.
    
    /*-- 412 --*/
    nv_41 = nv_412.
    ASSIGN
        nv_412var   = " "
        nv_41cod2   = "412"                                   
        nv_412var1  = "     PA Passengers = "                 
        nv_412var2  =  STRING(nv_412)                          
        SUBSTRING(nv_412var,1,30)   = nv_412var1              
        SUBSTRING(nv_412var,31,30)  = nv_412var2              
        nv_412prm  = nv_412.   
    
    /*-- 42 --*/
    ASSIGN
        nv_42var     = " "
        nv_42cod     = "42"
        nv_42var1    = "      Medical Expense = "
        nv_42var2    = STRING(nv_42)
        SUBSTR(nv_42var,1,30)   = nv_42var1
        SUBSTR(nv_42var,31,30)  = nv_42var2.
    
    /*-- 43 --*/
    ASSIGN
        nv_43var     = " "
        nv_43prm     = nv_43
        nv_43cod     = "43"
        nv_43var1    = "      Airfrieght = "
        nv_43var2    = STRING(nv_43)
        SUBSTR(nv_43var,1,30)  = nv_43var1
        SUBSTR(nv_43var,31,30) = nv_43var2.

    /*WGSOPER*/
    RUN WGS\WGSOPER(INPUT nv_tariff,
                          nv_class ,
                          nv_key_b ,
                          nv_comdat).
    
    /*-- USECOD --*/
    ASSIGN
        nv_usevar    = " "
        nv_usecod    = "USE" + TRIM(wgenerage.vehusg)
        nv_usevar1   = "      Vehicle Use = "
        nv_usevar2   = wgenerage.vehusg
        SUBSTR(nv_usevar,1,30)  = nv_usevar1
        SUBSTR(nv_usevar,31,30) = nv_usevar2.
    
    /*-- GROUP CODE --*/
    nv_sclass = SUBSTR(wgenerage.CLASS,2,3).
    RUN wgs\wgsoeng.
    
    ASSIGN
        nv_grpvar    = " "
        nv_grpcod    = "GRP" + nv_cargrp
        nv_grpvar1   = "     Vehicle Group = "
        nv_grpvar2   = nv_cargrp
        SUBSTR(nv_grpvar,1,30)  = nv_grpvar1
        SUBSTR(nv_grpvar,31,30) = nv_grpvar2.
    
    /*-- YRCOD --*/
    ASSIGN
        nv_yrvar     = " "
        nv_caryr     = (YEAR(nv_comdat) - wgenerage.yrmanuf) + 1
        nv_yrcod     = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr) ELSE "YR99"
        nv_yrvar1    = "      Vehicle Year = "
        nv_yrvar2    = STRING(wgenerage.yrmanuf)
        SUBSTR(nv_yrvar,1,30)  = nv_yrvar1
        SUBSTR(nv_yrvar,31,30) = nv_yrvar2.

    /*-- SICOD --*/
    ASSIGN
        nv_sivar     = " "
        nv_sicod     = "SI"
        nv_sivar1    = "      Own Damage = "
        nv_sivar2    = STRING(wgenerage.si)
        SUBSTR(nv_sivar,1,30)  = nv_sivar1
        SUBSTR(nv_sivar,31,30) = nv_sivar2.
    
    /*-- BIPCOD --*/
    ASSIGN
        nv_bipvar    = " "
        nv_bipcod    = "BI1"
        nv_bipvar1   = "      BI per Person = "
        nv_bipvar2   = STRING(nv_bipp00)
        SUBSTR(nv_bipvar,1,30)  = nv_bipvar1
        SUBSTR(nv_bipvar,31,30) = nv_bipvar2.
    
    /*-- BIACOD --*/
    ASSIGN
        nv_biavar    = " "
        nv_biacod    = "BI2"
        nv_biavar1   = "      BI per Accident = "
        nv_biavar2   = STRING(nv_bipa00)
        SUBSTR(nv_biavar,1,30)  = nv_biavar1
        SUBSTR(nv_biavar,31,30) = nv_biavar2. 
    
    /*-- PDACOD --*/
    ASSIGN
        nv_pdavar    = " "
        nv_pdacod    = "PD"
        nv_pdavar1   = "      PD per Accident"
        nv_pdavar2   = STRING(nv_bipd00)
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.

    /*-- FLEET --*/
    nv_flet_per = INTE(wgenerage.fleet).
    IF nv_flet_per <> 0 AND nv_flet_per <> 10 THEN DO:
    END.
    ELSE IF nv_flet_per = 0 THEN DO:
        nv_flet    = 0.
        nv_fletvar = " ".
    END.
    
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, 
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               wgenerage.si,
                               uwm130.uom1_v,
                               uwm130.uom2_v,
                               uwm130.uom5_v).
    
    ASSIGN
        nv_fletvar     = " "                         
        nv_fletvar1    = "     Fleet % = "           
        nv_fletvar2    =  STRING(nv_flet_per)        
        SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1 
        SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.
    
    IF nv_flet = 0 THEN nv_fletvar = " ".
    
    /*-- NCB --*/
    nv_ncbyrs = 0.  /*NCB YEAR*/
    nv_ncbper = 0.  /*NCB %*/
    
    /*-- Check NCB --*/
    IF wgenerage.ncb <> 0 THEN DO:
        FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
                   sicsyac.xmm104.tariff  = "X"                 AND 
                   sicsyac.xmm104.CLASS   = wgenerage.CLASS     AND
                   sicsyac.xmm104.covcod  = wgenerage.covcod    AND
                   sicsyac.xmm104.ncbper  = INTE(wgenerage.ncb)
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm104 THEN DO:
            ASSIGN
                nv_ncbyrs = sicsyac.xmm104.ncbyrs
                nv_ncbper = sicsyac.xmm104.ncbper.
        END.
    END.
    ELSE DO:
        nv_ncbyrs  = 0.
        nv_ncbper  = 0.
        nv_ncb     = 0.
    END.

    RUN WGS\WGSORPRM.P(INPUT nv_tariff,      
                             nv_class,
                             nv_covcod,      
                             nv_key_b,
                             nv_comdat,      
                             wgenerage.si,
                             uwm130.uom1_v,  
                             uwm130.uom2_v,
                             uwm130.uom5_v).
    
    IF nv_ncbper <> 0 THEN DO:
        ASSIGN
            nv_ncbvar     = " " 
            nv_ncbvar1    = "      NCB % = "
            nv_ncbvar2    = STRING(nv_ncbper)
            SUBSTR(nv_ncbvar,1,30)  = nv_ncbvar1
            SUBSTR(nv_ncbvar,31,30) = nv_ncbvar2.
    END.

    nv_dss_per = 0.
    IF nv_gapprm <> wgenerage.prem THEN DO:

        fi_display = "Please wait...Adjust base..[" + string(i) + "]" + wgenerage.cr_2 .
        DISPLAY fi_display WITH FRAME fr_main.

        nv_per = 0.
        nv_per = TRUNCATE((nv_gapprm - wgenerage.prem),1).
        nv_per = TRUNCATE((nv_per * 100),1).
        nv_per = ROUND((nv_per / nv_gapprm),2).

        nv_dsspcvar = "".
        nv_dss_per  = nv_per.

        ASSIGN
            nv_dsspcvar1 = "     Discount Special % = "
            nv_dsspcvar2   =  STRING(nv_dss_per)
            SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
            SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.

        RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                   nv_class,
                                   nv_covcod,
                                   nv_key_b,
                                   nv_comdat,
                                   wgenerage.si,
                                   sic_bran.uwm130.uom1_v ,       
                                   sic_bran.uwm130.uom2_v ,       
                                   sic_bran.uwm130.uom5_v ). 

        IF nv_gapprm <> wgenerage.prem THEN DO:

            IF nv_gapprm - wgenerage.prem < 3 THEN DO:

                ASSIGN
                    nv_dss_per = nv_dss_per + 0.01.

                RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                           nv_class,
                                           nv_covcod,
                                           nv_key_b,
                                           nv_comdat,
                                           wgenerage.si,
                                           sic_bran.uwm130.uom1_v ,       
                                           sic_bran.uwm130.uom2_v ,       
                                           sic_bran.uwm130.uom5_v ). 

                IF nv_gapprm = wgenerage.prem THEN i = 10.
            END.
            ELSE DO:
                ASSIGN
                    nv_dss_per = nv_dss_per - 0.01.

                RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                                           nv_class,
                                           nv_covcod,
                                           nv_key_b,
                                           nv_comdat,
                                           wgenerage.si,
                                           sic_bran.uwm130.uom1_v ,       
                                           sic_bran.uwm130.uom2_v ,       
                                           sic_bran.uwm130.uom5_v ). 

                IF nv_gapprm = wgenerage.prem THEN i = 10.
            END.

            nv_baseprm = nv_baseprm + 1.

            /*
            IF nv_baseprm > nv_base_max THEN DO: 
                nv_baseprm = nv_baseprm - 1.
            END.
            ELSE IF nv_baseprm < nv_base_max THEN DO:
                
                IF nv_gapprm > wgenerage.prem THEN DO: 
                    nv_baseprm = nv_baseprm - 1.
                    IF nv_baseprm < nv_base_min THEN nv_baseprm = nv_baseprm + 1.
                END.
                ELSE nv_baseprm = nv_baseprm + 1.
            END.*/

            IF nv_baseprm > nv_base_max THEN i = 10.
            ELSE IF nv_baseprm < nv_base_min THEN i = 10.

            i = i + 1.
        END.
        ELSE i = 10.
    END.
END.

fi_display = "Adjust base complete....".
DISPLAY fi_display WITH FRAME fr_main.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70Gen C-Win 
PROCEDURE Proc_70Gen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228       
------------------------------------------------------------------------------*/
FOR EACH wexcel :
    DELETE wexcel.
END.

INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.seqno1 
        wexcel.policy
        wexcel.comdat 
        wexcel.expdat
        wexcel.insref
        wexcel.tiname  
        wexcel.name1 
        wexcel.addr1  
        wexcel.addr2
        wexcel.addr3
        wexcel.addr4 
        wexcel.icno
        wexcel.vehreg
        wexcel.provin
        wexcel.yrmanuf
        wexcel.makdes 
        wexcel.moddes
        wexcel.engine 
        wexcel.body 
        wexcel.Text5        /*F5 Policy Text*/
        wexcel.Text7        /*F7 Memo Text*/
        wexcel.engno 
        wexcel.cha_no
        wexcel.finance
        wexcel.class
        wexcel.remark
        wexcel.si
        wexcel.bip
        wexcel.bia
        wexcel.pda
        wexcel.m411
        wexcel.m412
        wexcel.m42
        wexcel.m43
        wexcel.covcod 
        wexcel.vehusg 
        wexcel.ncb 
        wexcel.fleet
        wexcel.baseprm
        wexcel.Prem
        /*wexcel.Prem_t*/
        wexcel.seats
        .
    /*----
    MESSAGE  
       "wexcel.seqno1 = " wexcel.seqno1   "wexcel.policy = " wexcel.policy  "wexcel.comdat  = " wexcel.comdat   "wexcel.expdat  = " wexcel.expdat  
       "wexcel.insref = " wexcel.insref   "wexcel.tiname = " wexcel.tiname  "wexcel.name1   = " wexcel.name1    "wexcel.addr1   = " wexcel.addr1   
       "wexcel.addr2  = " wexcel.addr2    "wexcel.addr3  = " wexcel.addr3   "wexcel.addr4   = " wexcel.addr4    "wexcel.icno    = " wexcel.icno    
       "wexcel.vehreg = " wexcel.vehreg   "wexcel.provin = " wexcel.provin  "wexcel.yrmanuf = " wexcel.yrmanuf  "wexcel.makdes  = " wexcel.makdes  
       "wexcel.moddes = " wexcel.moddes   "wexcel.engine = " wexcel.engine  "wexcel.body    = " wexcel.body     "wexcel.Text5   = " wexcel.Text5   
       "wexcel.Text7  = " wexcel.Text7    "wexcel.engno  = " wexcel.engno   "wexcel.cha_no  = " wexcel.cha_no   "wexcel.finance = " wexcel.finance 
       "wexcel.CLASS  = " wexcel.CLASS    "wexcel.remark = " wexcel.remark  "wexcel.si      = " wexcel.si       "wexcel.bip     = " wexcel.bip     
       "wexcel.bia    = " wexcel.bia      "wexcel.pda    = " wexcel.pda     "wexcel.m411    = " wexcel.m411     "wexcel.m412    = " wexcel.m412    
       "wexcel.m42    = " wexcel.m42      "wexcel.m43    = " wexcel.m43     "wexcel.covcod  = " wexcel.covcod   "wexcel.vehusg  = " wexcel.vehusg  
       "wexcel.ncb    = " wexcel.ncb      "wexcel.fleet  = " wexcel.fleet   "wexcel.baseprm = " wexcel.baseprm  "wexcel.seats   = " wexcel.seats
       "wexcel.Prem   = " wexcel.Prem     "wexcel.Prem_t = " wexcel.Prem_t
    VIEW-AS ALERT-BOX.
    ----*/

END. /*REPEAT*/

/*--- ยกเลิก Loop เนื่องจากต้องมี Policy ถึงนำเข้าได้ ---
FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
           stat.polno_fil.dir_ri    = YES                              AND
           stat.polno_fil.poltyp    = "V70"                            AND
           stat.polno_fil.branch    = "0WC"                            AND
           stat.polno_fil.undyr     = STRING(YEAR(TODAY) + 543,"9999") AND
           stat.polno_fil.start_no  = "WC"                             NO-LOCK NO-ERROR.
IF AVAIL stat.polno_fil THEN DO:
    nv_pol70 = stat.polno_fil.nextno - 1.
END.
ELSE DO:
    FIND LAST stat.polno_fil USE-INDEX polno01 WHERE
              stat.polno_fil.dir_ri   = YES    AND
              stat.polno_fil.poltyp   = "V70"  AND
              stat.polno_fil.branch   = "0WC"                                  
    NO-LOCK NO-ERROR.
    IF AVAIL stat.polno_fil THEN DO:
        nv_pol70 = stat.polno_fil.nextno - 1.
    END.
END.
-----*/

FOR EACH wexcel NO-LOCK:

    IF wexcel.prem   = "" THEN NEXT.    /*เบี้ยสุทธิเป็นค่าว่าง ไม่สามารถคำนวณได้*/
    IF wexcel.seqno1 = "" THEN NEXT.    /*No Record ไม่เอา*/

    /*-- ลักษณะการใช้รถ --*/
    IF wexcel.vehusg = "" THEN wexcel.vehusg = fi_Vehuse.

    /*-- Class --*/
    IF LENGTH(wexcel.CLASS) = 3 THEN wexcel.CLASS = fi_package + wexcel.CLASS.

    /*-- เลขที่สัญญา --*/ /*---- ยกเลิก เนื่องจาก ต้องมีกรมธรรม์ถึงนำเข้าได้ ---
    IF wexcel.policy = "" THEN DO:

        nv_pol2       = SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2) + "WC" + STRING(nv_pol70 + 1,"9999").
        wexcel.policy = "MC70" + nv_pol2.
        nv_pol70      = nv_pol70 + 1.

    END.
    ----*/

    /*--- หาทะเบียนรถ ---*/
    IF wexcel.vehreg <> "" THEN DO:
        IF wexcel.provin = "" THEN wexcel.provin = "กท".
        ELSE DO:
            IF LENGTH(wexcel.provin) > 2 THEN DO:
                FIND FIRST brstat.insure                        WHERE
                           brstat.insure.compno = "999"         AND
                           brstat.insure.Fname  = wexcel.provin NO-LOCK NO-ERROR.
                IF AVAIL brstat.insure THEN DO:
                    wexcel.provin = brstat.insure.Lname.
                END.
                ELSE wexcel.provin = "กท".
            END.
            ELSE wexcel.provin = "กท".
        END.
    
        nv_vehreg = wexcel.vehreg.

        IF  SUBSTR(wexcel.vehreg,1,1) <> "/" THEN DO:
            IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
                IF SUBSTR(wexcel.vehreg,2,1) >= "1" AND SUBSTR(wexcel.vehreg,2,1) <= "9" THEN DO:
                    wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
                END.
                ELSE wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)) + " " + wexcel.provin.
            END.
            ELSE DO:
                wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
            END.
        END.
        ELSE wexcel.vehreg = wexcel.vehreg.
    END.
    ELSE DO:
        IF LENGTH(wexcel.cha_no) >= 9 THEN wexcel.vehreg = "/" + SUBSTR(wexcel.cha_no,(LENGTH(wexcel.cha_no) - 9) + 1,9).
        ELSE wexcel.vehreg = "/" + wexcel.cha_no.
    END.

    nv_comdat = ?.
    nv_expdat = ?.

    nv_comdat = DATE(wexcel.comdat).
    nv_expdat = DATE(wexcel.expdat).

    /*-- ชือ - ที่อยู่ --*/
    IF wexcel.name1 = "" AND wexcel.insref = "" THEN DO:  /*กรณี ไม่ใส่ชื่อและ Insure Code*/
        FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
             sicsyac.xmm600.acno = "0C56114"   NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN
                wexcel.insref = sicsyac.xmm600.acno
                wexcel.tiname = sicsyac.xmm600.ntitle
                wexcel.name1  = sicsyac.xmm600.NAME  
                wexcel.addr1  = sicsyac.xmm600.addr1 
                wexcel.addr2  = sicsyac.xmm600.addr2 
                wexcel.addr3  = sicsyac.xmm600.addr3 
                wexcel.addr4  = sicsyac.xmm600.addr4 
                wexcel.icno   = sicsyac.xmm600.icno
                /*Add by Kridtiya i. A63-0472*/
                wexcel.insnamtyp      = TRIM(sicsyac.xmm600.acno_typ)
                wexcel.firstName      = TRIM(sicsyac.xmm600.firstname)
                wexcel.lastName       = TRIM(sicsyac.xmm600.lastName)
                wexcel.postcd         = trim(sicsyac.xmm600.postcd)
                wexcel.codeocc        = trim(sicsyac.xmm600.codeocc) 
                wexcel.codeaddr1      = TRIM(sicsyac.xmm600.codeaddr1)
                wexcel.codeaddr2      = TRIM(sicsyac.xmm600.codeaddr2)
                wexcel.codeaddr3      = trim(sicsyac.xmm600.codeaddr3)
                /*wexcel.br_insured     = trim(sicsyac.xmm600.anlyc5) */  .
                /*Add by Kridtiya i. A63-0472*/
        END.
        ELSE DO:
            FIND sicsyac.xtm600 USE-INDEX xtm60001 WHERE
                 sicsyac.xtm600.acno = "0C56114"   NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xtm600 THEN DO:
                ASSIGN
                    wexcel.insref = sicsyac.xtm600.acno
                    wexcel.tiname = sicsyac.xtm600.ntitle
                    wexcel.name1  = sicsyac.xtm600.NAME  
                    wexcel.addr1  = sicsyac.xtm600.addr1 
                    wexcel.addr2  = sicsyac.xtm600.addr2 
                    wexcel.addr3  = sicsyac.xtm600.addr3 
                    wexcel.addr4  = sicsyac.xtm600.addr4 
                    wexcel.icno   = sicsyac.xtm600.addr1 
                    /* xtm600 *//*Add by Kridtiya i. A63-0472*/
                    wexcel.postcd    =  sicsyac.xtm600.postcd   
                    wexcel.firstName =  sicsyac.xtm600.firstname
                    wexcel.lastName  =  sicsyac.xtm600.lastname .
                    /*Add by Kridtiya i. A63-0472*/
            END.
        END.  
    END. 
    ELSE IF wexcel.insref <> "" THEN DO:   /*กรณีใส่ Insure Code แต่ไม่ใส่ชื่อ*/
        FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
             sicsyac.xmm600.acno = wexcel.insref NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN
                wexcel.insref = sicsyac.xmm600.acno
                wexcel.tiname = sicsyac.xmm600.ntitle
                wexcel.name1  = sicsyac.xmm600.NAME  
                wexcel.addr1  = sicsyac.xmm600.addr1 
                wexcel.addr2  = sicsyac.xmm600.addr2 
                wexcel.addr3  = sicsyac.xmm600.addr3 
                wexcel.addr4  = sicsyac.xmm600.addr4 
                wexcel.icno   = sicsyac.xmm600.icno 
                /*Add by Kridtiya i. A63-0472*/
                wexcel.insnamtyp      = TRIM(sicsyac.xmm600.acno_typ)
                wexcel.firstName      = TRIM(sicsyac.xmm600.firstname)
                wexcel.lastName       = TRIM(sicsyac.xmm600.lastName)
                wexcel.postcd         = trim(sicsyac.xmm600.postcd)
                wexcel.codeocc        = trim(sicsyac.xmm600.codeocc) 
                wexcel.codeaddr1      = TRIM(sicsyac.xmm600.codeaddr1)
                wexcel.codeaddr2      = TRIM(sicsyac.xmm600.codeaddr2)
                wexcel.codeaddr3      = trim(sicsyac.xmm600.codeaddr3)
                /*wexcel.br_insured     = trim(sicsyac.xmm600.anlyc5)*/  .
                /*Add by Kridtiya i. A63-0472*/
        END.
        ELSE DO:
            FIND sicsyac.xtm600 USE-INDEX xtm60001 WHERE
                 sicsyac.xtm600.acno = wexcel.insref NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xtm600 THEN DO:
                ASSIGN
                    wexcel.insref = sicsyac.xtm600.acno
                    wexcel.tiname = sicsyac.xtm600.ntitle
                    wexcel.name1  = sicsyac.xtm600.NAME  
                    wexcel.addr1  = sicsyac.xtm600.addr1 
                    wexcel.addr2  = sicsyac.xtm600.addr2 
                    wexcel.addr3  = sicsyac.xtm600.addr3 
                    wexcel.addr4  = sicsyac.xtm600.addr4 
                    wexcel.icno   = sicsyac.xtm600.addr1 
                    /* xtm600 *//*Add by Kridtiya i. A63-0472*/
                    wexcel.postcd    =  sicsyac.xtm600.postcd   
                    wexcel.firstName =  sicsyac.xtm600.firstname
                    wexcel.lastName  =  sicsyac.xtm600.lastname .
                    /*Add by Kridtiya i. A63-0472*/
            END.
        END.
    END.

    wexcel.rec_status = "Y".
    RUN Proc_70ChkGen.

    IF wexcel.rec_status = "Y" THEN DO:
        CREATE wgenerage.
        ASSIGN
            wgenerage.seqno1      = wexcel.seqno1
            wgenerage.policy      = wexcel.policy
            wgenerage.poltyp      = "V70"
            wgenerage.comdat      = DATE(wexcel.comdat)
            wgenerage.expdat      = DATE(wexcel.expdat)
            wgenerage.accdat      = DATE(wexcel.comdat)
            wgenerage.insref      = wexcel.insref
            wgenerage.tiname      = wexcel.tiname
            wgenerage.name1       = wexcel.name1
            wgenerage.addr1       = wexcel.addr1
            wgenerage.addr2       = wexcel.addr2
            wgenerage.addr3       = wexcel.addr3
            wgenerage.addr4       = wexcel.addr4
            wgenerage.icno        = wexcel.icno
            wgenerage.vehreg      = wexcel.vehreg 
            wgenerage.yrmanuf     = wexcel.yrmanuf
            wgenerage.makdes      = wexcel.makdes 
            wgenerage.moddes      = wexcel.moddes 
            wgenerage.engine      = wexcel.engine
            wgenerage.body        = wexcel.body  
            wgenerage.text5       = wexcel.text5
            wgenerage.text7       = wexcel.text7
            wgenerage.engno       = wexcel.engno
            wgenerage.cha_no      = wexcel.cha_no
            wgenerage.finance     = wexcel.finance
            wgenerage.si          = wexcel.si 
            wgenerage.bip         = wexcel.bip 
            wgenerage.bia         = wexcel.bia
            wgenerage.pda         = wexcel.pda 
            wgenerage.m411        = wexcel.m411
            wgenerage.m412        = wexcel.m412 
            wgenerage.m42         = wexcel.m42 
            wgenerage.m43         = wexcel.m43
            wgenerage.CLASS       = TRIM(wexcel.CLASS)
            wgenerage.covcod      = wexcel.covcod
            wgenerage.vehusg      = wexcel.vehusg
            wgenerage.ncb         = DECI(wexcel.ncb)
            wgenerage.fleet       = DECI(wexcel.fleet)
            wgenerage.baseprm     = DECI(wexcel.baseprm)
            wgenerage.prem        = DECI(wexcel.prem)
            wgenerage.prem_t      = wexcel.prem_t
            wgenerage.seats       = wexcel.seats
            wgenerage.rec_status  = "Y"
            wgenerage.rec_comment = ""
            /*Add by Kridtiya i. A63-0472*/
            wgenerage.insnamtyp   = trim(wexcel.insnamtyp)  
            wgenerage.firstName   = trim(wexcel.firstName)  
            wgenerage.lastName    = trim(wexcel.lastName)  
            wgenerage.postcd      = trim(wexcel.postcd)  
            wgenerage.icno        = trim(wexcel.icno)  
            wgenerage.codeocc     = trim(wexcel.codeocc)  
            wgenerage.codeaddr1   = trim(wexcel.codeaddr1)  
            wgenerage.codeaddr2   = trim(wexcel.codeaddr2)  
            wgenerage.codeaddr3   = trim(wexcel.codeaddr3)  
            /*wgenerage.br_insured  = trim(wexcel.br_insured) */
            wgenerage.campaign_ov = trim(wexcel.campaign_ov)   .   
            /*Add by Kridtiya i. A63-0472*/  
    END.

END.  /*FOR EACH wexcel*/

FIND FIRST wgenerage NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL wgenerage THEN DO:

    fi_display = "Not found data For Generate...".
    DISPLAY fi_display WITH FRAME fr_main.

    /*MESSAGE " Not found data For Generate" VIEW-AS ALERT-BOX.*/
END.

sh_policy  = "".
nv_line    = 0.

OUTPUT STREAM nnotdata  TO  VALUE(nv_notdata).

FOR EACH wgenerage NO-LOCK:
    ASSIGN
        nv_reccnt   = nv_reccnt + 1 /*note add on 23/05/2007*/
        nv_netprm_t = nv_netprm_t + wgenerage.prem.

    RUN Proc_70Check.

END.

nv_rectot = nv_reccnt.
nv_recsuc = nv_completecnt. 

OUTPUT STREAM nnotdata  CLOSE.

/***--- Disp Browse ---***/
OPEN QUERY BROWSE-4 FOR EACH wgenerage . 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70gen100 C-Win 
PROCEDURE Proc_70gen100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Create UWM100...".
DISPLAY fi_display WITH FRAME fr_main.

DO TRANSACTION :

    CREATE sic_bran.uwm100.

    ASSIGN
        sic_bran.uwm100.policy  = wgenerage.policy
        sic_bran.uwm100.cr_2    = wgenerage.cr_2
        sic_bran.uwm100.rencnt  = nv_rencnt
        sic_bran.uwm100.endcnt  = nv_endcnt
        sic_bran.uwm100.bchyr   = nv_batchyr 
        sic_bran.uwm100.bchno   = nv_batchno 
        sic_bran.uwm100.bchcnt  = nv_batcnt
        sic_bran.uwm100.renno   = ""
        sic_bran.uwm100.opnpol  = nv_opnpol
        sic_bran.uwm100.poltyp  = wgenerage.poltyp
        sic_bran.uwm100.insref  = wgenerage.insref
        sic_bran.uwm100.anam2   = wgenerage.icno
        sic_bran.uwm100.ntitle  = wgenerage.tiname
        sic_bran.uwm100.name1   = wgenerage.name1
        sic_bran.uwm100.name2   = ""
        sic_bran.uwm100.name3   = ""
        sic_bran.uwm100.addr1   = wgenerage.addr1
        sic_bran.uwm100.addr2   = wgenerage.addr2
        sic_bran.uwm100.addr3   = wgenerage.addr3
        sic_bran.uwm100.addr4   = wgenerage.addr4
        sic_bran.uwm100.postcd  = ""
        sic_bran.uwm100.undyr   = STRING(YEAR(TODAY),"9999")
        sic_bran.uwm100.branch  = nv_branch
        sic_bran.uwm100.dept    = "G"
        sic_bran.uwm100.usrid   = USERID(LDBNAME(1))
        /*sic_bran.uwm100.fstdat  = TODAY*//*Comment A56-0345 -3*/
        sic_bran.uwm100.fstdat  = wgenerage.comdat  /*A56-0345 -3*/
        sic_bran.uwm100.comdat  = wgenerage.comdat
        sic_bran.uwm100.expdat  = wgenerage.expdat
        sic_bran.uwm100.accdat  = wgenerage.comdat
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
        sic_bran.uwm100.prog    = "WGWMCGEN"
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
        sic_bran.uwm100.cedpol  = "MC" + SUBSTR(wgenerage.policy,3,10)
        sic_bran.uwm100.finint  = ""
        sic_bran.uwm100.bs_cd   = ""
        sic_bran.uwm100.polsta  = "IF"
        sic_bran.uwm100.gstrat  = 7
        sic_bran.uwm100.firstName  =  trim(wgenerage.firstName)       /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   =  trim(wgenerage.lastName)        /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     =  trim(wgenerage.postcd)          /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       =  trim(wgenerage.icno)            /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    =  trim(wgenerage.codeocc)         /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  =  trim(wgenerage.codeaddr1)       /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  =  trim(wgenerage.codeaddr2)       /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  =  trim(wgenerage.codeaddr3)       /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.br_insured =  trim(wgenerage.br_insured)      /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   =  trim(wgenerage.campaign_ov) .   /*Add by Kridtiya i. A63-0472*/

    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
                       ELSE sic_bran.uwm100.trndat = TODAY.

    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.

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

    IF sic_bran.uwm100.insref = "" THEN DO:

        RUN Proc_CreateIns.
        sic_bran.uwm100.insref = nv_insref.

    END.

    RUN Proc_uwd100.  /*Text F15 Policy Text*/

    IF wgenerage.text7 <> "" THEN DO:
        RUN Proc_uwd102.  /*Text F17 Memo Text*/
    END.

END.

s_recid1 = RECID(sic_bran.uwm100).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70gen120 C-Win 
PROCEDURE Proc_70gen120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Create UWM120...".
DISPLAY fi_display WITH FRAME fr_main.

DO TRANSACTION :

      CREATE sic_bran.uwm120.

      ASSIGN
        sic_bran.uwm120.policy   = wgenerage.policy                  /*Policy No.*/
        sic_bran.uwm120.rencnt   = nv_rencnt                         /*Renewal Count*/
        sic_bran.uwm120.endcnt   = nv_endcnt                         /*Endorsement Count*/
        sic_bran.uwm120.riskgp   = 0                                 /*Risk Group*/
        sic_bran.uwm120.riskno   = 1                                 /*Risk No.*/
        sic_bran.uwm120.fptr01   = 0  sic_bran.uwm120.bptr01 = 0     /*uwd120 Risk Upper Text*/
        sic_bran.uwm120.fptr02   = 0  sic_bran.uwm120.bptr02 = 0     /*uwd121 Risk Lower Text*/
        sic_bran.uwm120.fptr03   = 0  sic_bran.uwm120.bptr03 = 0     /*uwd123 Borderau Text*/
        sic_bran.uwm120.fptr04   = 0  sic_bran.uwm120.bptr04 = 0     /*uwd125 Risk Clauses*/
        sic_bran.uwm120.fptr08   = 0  sic_bran.uwm120.bptr08 = 0     /*uwd124 Risk Endt. Text*/
        sic_bran.uwm120.fptr09   = 0  sic_bran.uwm120.bptr09 = 0     /*uwd126 Risk Endt. Clause*/
        sic_bran.uwm120.class    = wgenerage.CLASS                   /*Business Class Code*/   /*nv_class*/
        sic_bran.uwm120.sicurr   = "BHT"                             /*Sum Insured Currency*/
        sic_bran.uwm120.siexch   = 1                                 /*Sum Insured Exchange Rate*/
        sic_bran.uwm120.r_text   = ""                                /*Standard Risk Text Ref. No.*/
        sic_bran.uwm120.bchyr    = nv_batchyr 
        sic_bran.uwm120.bchno    = nv_batchno 
        sic_bran.uwm120.bchcnt   = nv_batcnt  

        /*
        uwm120.r_text   = "IN1"                                      /*Standard Risk Text Ref. No.*/
        */
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

      s_recid2  = RECID(sic_bran.uwm120).
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70gen130 C-Win 
PROCEDURE Proc_70gen130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add A57-0228     
------------------------------------------------------------------------------*/
fi_display = "Create UWM130...".
DISPLAY fi_display WITH FRAME fr_main.

FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
     sic_bran.uwm130.policy = sic_bran.uwm100.policy  AND
     sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  AND
     sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt  AND
     sic_bran.uwm130.riskgp = 0                       AND
     sic_bran.uwm130.riskno = 1                       AND
     sic_bran.uwm130.itemno = 1                       AND
     sic_bran.uwm130.bchyr  = nv_batchyr              AND
     sic_bran.uwm130.bchno  = nv_batchno              AND
     sic_bran.uwm130.bchcnt = nv_batcnt               
NO-WAIT NO-ERROR.
IF NOT AVAIL sic_bran.uwm130 THEN DO:

    DO TRANSACTION :

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

        IF (wgenerage.covcod = "1") OR (wgenerage.covcod = "5")  THEN DO:
            ASSIGN
                sic_bran.uwm130.uom6_v   = INTE(wgenerage.si)
                sic_bran.uwm130.uom7_v   = INTE(wgenerage.si)
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.
        ELSE IF wgenerage.covcod = "2" THEN DO:
            ASSIGN
                sic_bran.uwm130.uom6_v   = 0
                sic_bran.uwm130.uom7_v   = INTE(wgenerage.si)
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        END.
        ELSE IF wgenerage.covcod = "3" THEN
            ASSIGN
                sic_bran.uwm130.uom6_v   = 0
                sic_bran.uwm130.uom7_v   = 0
                sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
                sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
                sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
                sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
                sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/

        /*--- Phorn Comment --
        IF fi_package <> "" THEN nv_subclass = TRIM(fi_package) + TRIM(wgenerage.class).
        ELSE nv_subclass = "Z" + TRIM(wgenerage.class).

        /*--- ตรวจสอบความคุ้มครอง ---*/
        FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
                   stat.clastab_fil.class  = wgenerage.CLASS    AND
                   stat.clastab_fil.covcod = wgenerage.covcod   NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            ASSIGN
                sic_bran.uwm130.uom1_v     =  IF stat.clastab_fil.uom1_si = 0 THEN wgenerage.bip ELSE stat.clastab_fil.uom1_si
                sic_bran.uwm130.uom2_v     =  IF stat.clastab_fil.uom2_si = 0 THEN wgenerage.bia ELSE stat.clastab_fil.uom2_si
                sic_bran.uwm130.uom5_v     =  IF stat.clastab_fil.uom5_si = 0 THEN wgenerage.pda ELSE stat.clastab_fil.uom5_si
                sic_bran.uwm130.uom8_v     =  0                
                sic_bran.uwm130.uom9_v     =  0          
                sic_bran.uwm130.uom3_v     =  0
                sic_bran.uwm130.uom4_v     =  0
                sic_bran.uwm130.uom1_c     =  "D1"
                sic_bran.uwm130.uom2_c     =  "D2"
                sic_bran.uwm130.uom5_c     =  "D5"
                sic_bran.uwm130.uom6_c     =  "D6"
                sic_bran.uwm130.uom7_c     =  "D7"
                sic_bran.uwm130.uom8_c     =  "C8"
                sic_bran.uwm130.uom9_c     =  "C9".
        END.
        ELSE DO:
            ASSIGN
                sic_bran.uwm130.uom1_v     =  wgenerage.bip
                sic_bran.uwm130.uom2_v     =  wgenerage.bia
                sic_bran.uwm130.uom5_v     =  wgenerage.pda
                sic_bran.uwm130.uom8_v     =  0               
                sic_bran.uwm130.uom9_v     =  0          
                sic_bran.uwm130.uom3_v     =  0
                sic_bran.uwm130.uom4_v     =  0
                sic_bran.uwm130.uom1_c     =  "D1"
                sic_bran.uwm130.uom2_c     =  "D2"
                sic_bran.uwm130.uom5_c     =  "D5"
                sic_bran.uwm130.uom6_c     =  "D6"
                sic_bran.uwm130.uom7_c     =  "D7"
                sic_bran.uwm130.uom8_c     =  "C8"
                sic_bran.uwm130.uom9_c     =  "C9".
        END.
        --- End Comment ---*/

        IF wgenerage.bip = 0 OR wgenerage.bia = 0 OR wgenerage.pda = 0 THEN DO:
            FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
                       stat.clastab_fil.class  = wgenerage.CLASS    AND
                       stat.clastab_fil.covcod = wgenerage.covcod   NO-LOCK NO-ERROR.
            IF AVAIL stat.clastab_fil THEN DO:
                ASSIGN
                    sic_bran.uwm130.uom1_v     =  IF stat.clastab_fil.uom1_si = 0 THEN wgenerage.bip ELSE stat.clastab_fil.uom1_si
                    sic_bran.uwm130.uom2_v     =  IF stat.clastab_fil.uom2_si = 0 THEN wgenerage.bia ELSE stat.clastab_fil.uom2_si
                    sic_bran.uwm130.uom5_v     =  IF stat.clastab_fil.uom5_si = 0 THEN wgenerage.pda ELSE stat.clastab_fil.uom5_si
                    sic_bran.uwm130.uom8_v     =  0                
                    sic_bran.uwm130.uom9_v     =  0          
                    sic_bran.uwm130.uom3_v     =  0
                    sic_bran.uwm130.uom4_v     =  0
                    sic_bran.uwm130.uom1_c     =  "D1"
                    sic_bran.uwm130.uom2_c     =  "D2"
                    sic_bran.uwm130.uom5_c     =  "D5"
                    sic_bran.uwm130.uom6_c     =  "D6"
                    sic_bran.uwm130.uom7_c     =  "D7"
                    sic_bran.uwm130.uom8_c     =  "C8"
                    sic_bran.uwm130.uom9_c     =  "C9".
            END.
        END.
        ELSE DO:
            ASSIGN
                sic_bran.uwm130.uom1_v     =  wgenerage.bip
                sic_bran.uwm130.uom2_v     =  wgenerage.bia
                sic_bran.uwm130.uom5_v     =  wgenerage.pda
                sic_bran.uwm130.uom8_v     =  0               
                sic_bran.uwm130.uom9_v     =  0          
                sic_bran.uwm130.uom3_v     =  0
                sic_bran.uwm130.uom4_v     =  0
                sic_bran.uwm130.uom1_c     =  "D1"
                sic_bran.uwm130.uom2_c     =  "D2"
                sic_bran.uwm130.uom5_c     =  "D5"
                sic_bran.uwm130.uom6_c     =  "D6"
                sic_bran.uwm130.uom7_c     =  "D7"
                sic_bran.uwm130.uom8_c     =  "C8"
                sic_bran.uwm130.uom9_c     =  "C9".
        END.
    
        IF wgenerage.covcod = "1" THEN DO:
            RUN wgs/wgschsum(INPUT  wgenerage.policy, 
                                    1, /*nv_riskno*/
                                    1  /*nv_itemno*/).
        END.
      
        s_recid3   = RECID(sic_bran.uwm130).

    END. /*DO TRANSACTION*/
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70Gen301 C-Win 
PROCEDURE Proc_70Gen301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add A57-0228     
------------------------------------------------------------------------------*/

fi_display = "Create UWM301...".
DISPLAY fi_display WITH FRAME fr_main.

ASSIGN
    nv_class   = ""
    nv_makdes  = ""
    nv_modcod  = ""
    nv_moddes  = ""
    nv_moddes1 = ""
    nv_seats   = 0.

/*-- SCLASS --*/
IF LENGTH(wgenerage.CLASS) = 4 THEN nv_class = SUBSTR(wgenerage.CLASS,2,3).

/*-- MAKDES --*/
FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
           stat.maktab_fil.makdes BEGINS wgenerage.makdes NO-LOCK NO-ERROR.
IF AVAIL stat.maktab_fil THEN DO:
    nv_makdes = TRIM(stat.maktab_fil.makdes).
END.

/*-- MODDES --*/
LOOP_MODDES:
FOR EACH stat.maktab_fil USE-INDEX maktab04 WHERE
         stat.maktab_fil.makdes  = nv_makdes         AND
         stat.maktab_fil.makyea  = wgenerage.yrmanuf AND
         stat.maktab_fil.sclass  = nv_class          AND
         stat.maktab_fil.engine <= INTE(wgenerage.engine) NO-LOCK:

    IF INDEX(stat.maktab_fil.moddes," ") <> 0 THEN DO:
        nv_moddes1 = TRIM(SUBSTR(stat.maktab_fil.moddes,1,INDEX(stat.maktab_fil.moddes," "))).
    END.
    ELSE nv_moddes1 = TRIM(stat.maktab_fil.moddes).

    IF INDEX(wgenerage.moddes,nv_moddes1) <> 0 THEN DO:

        nv_si_max = stat.maktab_fil.si + (stat.maktab_fil.si * (20 / 100)).
        nv_si_min = stat.maktab_fil.si - (stat.maktab_fil.si * (20 / 100)).

        IF wgenerage.si >= nv_si_min AND wgenerage.si <= nv_si_max THEN DO:
            ASSIGN
                nv_modcod = stat.maktab_fil.modcod
                nv_moddes = stat.maktab_fil.moddes
                nv_cargrp = stat.maktab_fil.prmpac
                nv_tons   = stat.maktab_fil.tons
                nv_seats  = stat.maktab_fil.seats.
        END.
    END.
    ELSE DO:
        IF nv_moddes1 = "COROLLA" THEN DO:
            nv_moddes1 = "ALTIS".
            IF INDEX(wgenerage.moddes,nv_moddes1) <> 0 THEN DO:
                 nv_si_max = stat.maktab_fil.si + (stat.maktab_fil.si * (20 / 100)).
                 nv_si_min = stat.maktab_fil.si - (stat.maktab_fil.si * (20 / 100)).
            
                 IF wgenerage.si >= nv_si_min AND wgenerage.si <= nv_si_max THEN DO:
                     ASSIGN
                         nv_modcod = stat.maktab_fil.modcod
                         nv_moddes = stat.maktab_fil.moddes
                         nv_cargrp = stat.maktab_fil.prmpac
                         nv_tons   = stat.maktab_fil.tons
                         nv_seats  = stat.maktab_fil.seats.
                 END.
            END.
        END.
    END.
END.

IF nv_modcod = "" THEN DO:
    FOR EACH stat.maktab_fil USE-INDEX maktab04 WHERE
             stat.maktab_fil.makdes  = nv_makdes         AND
             stat.maktab_fil.makyea  = wgenerage.yrmanuf AND
             stat.maktab_fil.engine <= INTE(wgenerage.engine) NO-LOCK:

        IF INDEX(stat.maktab_fil.moddes," ") <> 0 THEN DO:
            nv_moddes1 = TRIM(SUBSTR(stat.maktab_fil.moddes,1,INDEX(stat.maktab_fil.moddes," "))).
        END.
        ELSE nv_moddes1 = TRIM(stat.maktab_fil.moddes).
    
        IF INDEX(wgenerage.moddes,nv_moddes1) <> 0 THEN DO:
    
            nv_si_max = stat.maktab_fil.si + (stat.maktab_fil.si * (20 / 100)).
            nv_si_min = stat.maktab_fil.si - (stat.maktab_fil.si * (20 / 100)).
    
            IF wgenerage.si >= nv_si_min AND wgenerage.si <= nv_si_max THEN DO:
                ASSIGN
                    nv_modcod = stat.maktab_fil.modcod
                    nv_moddes = stat.maktab_fil.moddes
                    nv_cargrp = stat.maktab_fil.prmpac
                    nv_tons   = stat.maktab_fil.tons
                    nv_seats  = stat.maktab_fil.seats.
            END.
        END.
        ELSE DO:
            IF nv_moddes1 = "COROLLA" THEN DO:
                nv_moddes1 = "ALTIS".
                IF INDEX(wgenerage.moddes,nv_moddes1) <> 0 THEN DO:
                     nv_si_max = stat.maktab_fil.si + (stat.maktab_fil.si * (20 / 100)).
                     nv_si_min = stat.maktab_fil.si - (stat.maktab_fil.si * (20 / 100)).
                
                     IF wgenerage.si >= nv_si_min AND wgenerage.si <= nv_si_max THEN DO:
                         ASSIGN
                             nv_modcod = stat.maktab_fil.modcod
                             nv_moddes = stat.maktab_fil.moddes
                             nv_cargrp = stat.maktab_fil.prmpac
                             nv_tons   = stat.maktab_fil.tons
                             nv_seats  = stat.maktab_fil.seats.
                     END.
                END.
            END.
        END.
    END.
END.

/*---
/*-- เปรียบเทียบทุน --*/
FIND FIRST stat.makdes31 USE-INDEX makdes31       WHERE
           stat.makdes31.makdes = "X"             AND
           stat.makdes31.moddes = wgenerage.CLASS NO-LOCK NO-ERROR.
IF AVAIL stat.makdes31 THEN DO:

    FIND FIRST stat.maktab_fil USE-INDEX maktab02 WHERE
               stat.maktab_fil.sclass  = nv_class                AND
               stat.maktab_fil.makdes  = nv_makdes               AND
         INDEX(stat.maktab_fil.moddes,nv_moddes) <> 0            AND
               stat.maktab_fil.makyea  = wgenerage.yrmanuf       AND
               stat.maktab_fil.engine <= INTE(wgenerage.engine)  AND
              (stat.maktab_fil.si - (stat.maktab_fil.si * stat.makdes31.si_theft_p / 100) <= INTE(wgenerage.si)  AND
               stat.maktab_fil.si + (stat.maktab_fil.si * stat.makdes31.load_p / 100)     >= INTE(wgenerage.si)) NO-LOCK NO-ERROR.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            nv_modcod = stat.maktab_fil.modcod
            nv_cargrp = stat.maktab_fil.prmpac
            nv_tons   = stat.maktab_fil.tons
            nv_seats  = stat.maktab_fil.seats.
    END.      
    ELSE DO:
        FIND FIRST stat.maktab_fil USE-INDEX maktab04 WHERE
                   stat.maktab_fil.makdes = nv_makdes                AND
             INDEX(stat.maktab_fil.moddes,nv_moddes) <> 0            AND
                   stat.maktab_fil.makyea  = wgenerage.yrmanuf       AND
                   stat.maktab_fil.engine <= INTE(wgenerage.engine)  AND
                  (stat.maktab_fil.si - (stat.maktab_fil.si * stat.makdes31.si_theft_p / 100) <= INTE(wgenerage.si)  AND
                   stat.maktab_fil.si + (stat.maktab_fil.si * stat.makdes31.load_p / 100)     >= INTE(wgenerage.si)) NO-LOCK NO-ERROR.
        IF AVAIL stat.maktab_fil THEN DO:
            ASSIGN
                nv_modcod = stat.maktab_fil.modcod
                nv_cargrp = stat.maktab_fil.prmpac
                nv_tons   = stat.maktab_fil.tons
                nv_seats  = stat.maktab_fil.seats.
        END.
    END.
END.
----*/

IF wgenerage.seats <> "" THEN nv_seats = INTE(wgenerage.seats).  /*Add A57-0228-01*/

FIND sic_bran.uwm301 USE-INDEX uwm30101 WHERE
     sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
     sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
     sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
     sic_bran.uwm301.riskgp = 0                       AND
     sic_bran.uwm301.riskno = 1                       AND
     sic_bran.uwm301.itemno = 1                       AND
     sic_bran.uwm301.bchyr  = nv_batchyr              AND 
     sic_bran.uwm301.bchno  = nv_batchno              AND 
     sic_bran.uwm301.bchcnt = nv_batcnt                     
NO-WAIT NO-ERROR.
IF NOT AVAIL sic_bran.uwm301 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm301.

        ASSIGN
            sic_bran.uwm301.policy    =  sic_bran.uwm100.policy
            sic_bran.uwm301.rencnt    =  sic_bran.uwm100.rencnt
            sic_bran.uwm301.endcnt    =  sic_bran.uwm100.endcnt
            sic_bran.uwm301.riskgp    =  0
            sic_bran.uwm301.riskno    =  1
            sic_bran.uwm301.itemno    =  1
            sic_bran.uwm301.bchyr     =  nv_batchyr       /* batch Year */
            sic_bran.uwm301.bchno     =  nv_batchno       /* bchno      */
            sic_bran.uwm301.bchcnt    =  nv_batcnt        /* bchcnt     */
            sic_bran.uwm301.tariff    =  "X"
            sic_bran.uwm301.covcod    =  wgenerage.covcod
            sic_bran.uwm301.cha_no    =  wgenerage.cha_no
            sic_bran.uwm301.trareg    =  nv_uwm301trareg
            sic_bran.uwm301.eng_no    =  wgenerage.engno
            sic_bran.uwm301.engine    =  INTE(wgenerage.engine)
            sic_bran.uwm301.yrmanu    =  wgenerage.yrmanuf
            sic_bran.uwm301.garage    =  ""
            sic_bran.uwm301.body      =  wgenerage.body
            sic_bran.uwm301.moddes    =  nv_makdes + " " + wgenerage.moddes
            sic_bran.uwm301.mv_ben83  =  wgenerage.finance
            sic_bran.uwm301.vehreg    =  wgenerage.vehreg
            sic_bran.uwm301.vehuse    =  wgenerage.vehusg
            sic_bran.uwm301.vehgrp    =  nv_cargrp
            sic_bran.uwm301.sckno     =  0
            sic_bran.uwm301.itmdel    =  NO
            sic_bran.uwm301.prmtxt    =  ""
            sic_bran.uwm301.modcod    =  nv_modcod
            sic_bran.uwm301.seats     =  nv_seats
            .

        IF sic_bran.uwm301.seats = 0 THEN DO:
                 IF wgenerage.body = "PICKUP" THEN sic_bran.uwm301.seats = 3.
            ELSE IF wgenerage.body = "VAN"    OR 
                    wgenerage.body = "12SEAT" OR 
                    wgenerage.body = "11SEAT" THEN sic_bran.uwm301.seats = 12.
            ELSE sic_bran.uwm301.seat = 7.
        END.

        nv_seats  = sic_bran.uwm301.seats.
        nv_seat41 = nv_seats.
        s_recid4  = RECID(sic_bran.uwm301).

    END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_70GenCov C-Win 
PROCEDURE Proc_70GenCov :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Create Code ...".
DISPLAY fi_display WITH FRAME fr_main.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

ASSIGN
    nv_covcod = sic_bran.uwm301.covcod
    nv_class  = wgenerage.CLASS
    nv_tariff = sic_bran.uwm301.tariff
    nv_engine = INTE(wgenerage.engine).

/*-- Driver Name --*/
ASSIGN
    nv_drivvar   = " "
    nv_drivcod   = "A000"
    nv_drivvar1  = "      Unname Driver"
    nv_drivvar2  = "0"
    SUBSTR(nv_drivvar,1,30)  = nv_drivvar1
    SUBSTR(nv_drivvar,31,30) = nv_drivvar2.

/*-- Base Premium --*/
nv_baseprm = 0.
IF wgenerage.baseprm = 0 THEN RUN Proc_70ChkBase.
ELSE nv_baseprm = wgenerage.baseprm.

ASSIGN
    nv_basevar   = " "
    nv_prem1     = nv_baseprm
    nv_basecod   = "BASE"
    nv_basevar1  = "      Base Premium = "
    SUBSTR(nv_basevar,1,30)  = nv_basevar1
    SUBSTR(nv_basevar,31,30) = nv_basevar2.

/*-- Cover --*/
fi_display = "Check Cover 1...".
DISPLAY fi_display WITH FRAME fr_main.

RUN Proc_70ChkCover.
IF nv_seat41 = 0 THEN nv_seat41 = sic_bran.uwm301.seats.

/*WGSOPER*/
/*comment by : A64-0138...
RUN WGS\WGSOPER(INPUT nv_tariff,
                      nv_class,
                      nv_key_b,
                      nv_comdat).*/
/*-- 411 --*/
nv_41 = nv_411.
ASSIGN
    nv_411var    = " "
    nv_41cod1    = "411"
    nv_411var1   = "      PA Driver = "
    nv_411var2   = STRING(nv_411)
    SUBSTR(nv_411var,1,30)  = nv_411var1
    SUBSTR(nv_411var,31,30) = nv_411var2
    nv_411prm    = nv_411.

/*-- 412 --*/
nv_412 = nv_412.
ASSIGN
    nv_412var   = " "
    nv_41cod2   = "412"                                   
    nv_412var1  = "     PA Passengers = "                 
    nv_412var2  =  STRING(nv_412)                          
    SUBSTRING(nv_412var,1,30)   = nv_412var1              
    SUBSTRING(nv_412var,31,30)  = nv_412var2              
    nv_412prm  = nv_412.   

/*-- 42 --*/
ASSIGN
    nv_42var     = " "
    nv_42cod     = "42"
    nv_42var1    = "      Medical Expense = "
    nv_42var2    = STRING(nv_42)
    SUBSTR(nv_42var,1,30)   = nv_42var1
    SUBSTR(nv_42var,31,30)  = nv_42var2.

/*-- 43 --*/
ASSIGN
    nv_43var     = " "
    nv_43prm     = nv_43
    nv_43cod     = "43"
    nv_43var1    = "      Airfrieght = "
    nv_43var2    = STRING(nv_43)
    SUBSTR(nv_43var,1,30)  = nv_43var1
    SUBSTR(nv_43var,31,30) = nv_43var2.

/*WGSOPER*/
/*comment by : A64-0138...
RUN WGS\WGSOPER(INPUT nv_tariff,
                      nv_class ,
                      nv_key_b ,
                      nv_comdat).*/

/*-- USECOD --*/
ASSIGN
    nv_usevar    = " "
    nv_usecod    = "USE" + TRIM(wgenerage.vehusg)
    nv_usevar1   = "      Vehicle Use = "
    nv_usevar2   = wgenerage.vehusg
    SUBSTR(nv_usevar,1,30)  = nv_usevar1
    SUBSTR(nv_usevar,31,30) = nv_usevar2.

/*-- GROUP CODE --*/
nv_sclass = SUBSTR(wgenerage.CLASS,2,3).

RUN wgs\wgsoeng.

ASSIGN
    nv_grpvar    = " "
    nv_grpcod    = "GRP" + nv_cargrp
    nv_grpvar1   = "     Vehicle Group = "
    nv_grpvar2   = nv_cargrp
    SUBSTR(nv_grpvar,1,30)  = nv_grpvar1
    SUBSTR(nv_grpvar,31,30) = nv_grpvar2.

/*-- YRCOD --*/
ASSIGN
    nv_yrvar     = " "
    nv_caryr     = (YEAR(nv_comdat) - wgenerage.yrmanuf) + 1
    nv_yrcod     = IF nv_caryr <= 10 THEN "YR" + STRING(nv_caryr) ELSE "YR99"
    nv_yrvar1    = "      Vehicle Year = "
    nv_yrvar2    = STRING(wgenerage.yrmanuf)
    SUBSTR(nv_yrvar,1,30)  = nv_yrvar1
    SUBSTR(nv_yrvar,31,30) = nv_yrvar2.

/*-- SICOD --*/
ASSIGN
    nv_sivar     = " "
    nv_sicod     = "SI"
    nv_sivar1    = "      Own Damage = "
    nv_sivar2    = STRING(wgenerage.si)
    SUBSTR(nv_sivar,1,30)  = nv_sivar1
    SUBSTR(nv_sivar,31,30) = nv_sivar2.

/*-- BIPCOD --*/
ASSIGN
    nv_bipvar    = " "
    nv_bipcod    = "BI1"
    nv_bipvar1   = "      BI per Person = "
    nv_bipvar2   = STRING(nv_bipp00)
    SUBSTR(nv_bipvar,1,30)  = nv_bipvar1
    SUBSTR(nv_bipvar,31,30) = nv_bipvar2.

/*-- BIACOD --*/
ASSIGN
    nv_biavar    = " "
    nv_biacod    = "BI2"
    nv_biavar1   = "      BI per Accident = "
    nv_biavar2   = STRING(nv_bipa00)
    SUBSTR(nv_biavar,1,30)  = nv_biavar1
    SUBSTR(nv_biavar,31,30) = nv_biavar2. 

/*-- PDACOD --*/
ASSIGN
    nv_pdavar    = " "
    nv_pdacod    = "PD"
    nv_pdavar1   = "      PD per Accident"
    nv_pdavar2   = STRING(nv_bipd00)
    SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
    SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.

/*-- FLEET --*/
nv_flet_per = INTE(wgenerage.fleet).
IF nv_flet_per <> 0 AND nv_flet_per <> 10 THEN DO:
END.
ELSE IF nv_flet_per = 0 THEN DO:
    nv_flet    = 0.
    nv_fletvar = " ".
END.
/*comment by : A64-0138...
RUN WGS\WGSORPRM.P (INPUT  nv_tariff, 
                           nv_class,
                           nv_covcod,
                           nv_key_b,
                           nv_comdat,
                           wgenerage.si,
                           uwm130.uom1_v,
                           uwm130.uom2_v,
                           uwm130.uom5_v).*/
ELSE 
    ASSIGN
        nv_fletvar     = " "                         
        nv_fletvar1    = "     Fleet % = "           
        nv_fletvar2    =  STRING(nv_flet_per)        
        SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1 
        SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.

IF nv_flet = 0 THEN nv_fletvar = " ".

/*-- NCB --*/
nv_ncbyrs = 0.  /*NCB YEAR*/
nv_ncbper = 0.  /*NCB %*/

/*-- Check NCB --*/
IF wgenerage.ncb <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
               sicsyac.xmm104.tariff  = "X"                 AND 
               sicsyac.xmm104.CLASS   = wgenerage.CLASS     AND
               sicsyac.xmm104.covcod  = wgenerage.covcod    AND
               sicsyac.xmm104.ncbper  = INTE(wgenerage.ncb)
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm104 THEN DO:
        ASSIGN
            nv_ncbyrs = sicsyac.xmm104.ncbyrs
            nv_ncbper = sicsyac.xmm104.ncbper.
    END.
END.
ELSE DO:
    nv_ncbyrs  = 0.
    nv_ncbper  = 0.
    nv_ncb     = 0.
END.
/*comment by : A64-0138...
RUN WGS\WGSORPRM.P(INPUT nv_tariff,      
                         nv_class,
                         nv_covcod,      
                         nv_key_b,
                         nv_comdat,      
                         wgenerage.si,
                         uwm130.uom1_v,  
                         uwm130.uom2_v,
                         uwm130.uom5_v).*/

IF nv_ncbper <> 0 THEN DO:
    ASSIGN
        nv_ncbvar     = " " 
        nv_ncbvar1    = "      NCB % = "
        nv_ncbvar2    = STRING(nv_ncbper)
        SUBSTR(nv_ncbvar,1,30)  = nv_ncbvar1
        SUBSTR(nv_ncbvar,31,30) = nv_ncbvar2.
END.
/*--
IF nv_gapprm <> wgenerage.prem THEN RUN Proc_70DeBase.
*---*/
/*---
IF nv_baseprm <> wgenerage.baseprm THEN DO:
    ASSIGN
        nv_basevar   = " "
        nv_prem1     = nv_baseprm
        nv_basecod   = "BASE"
        nv_basevar1  = "      Base Premium = "
        SUBSTR(nv_basevar,1,30)  = nv_basevar1
        SUBSTR(nv_basevar,31,30) = nv_basevar2.
END.
---*/

RUN proc_calpremt .     /*A64-0138*/
RUN proc_adduwd132prem. /*A64-0138*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR.
IF AVAIL sic_bran.uwm100 THEN DO:
    ASSIGN
        sic_bran.uwm100.prem_t = nv_gapprm
        sic_bran.uwm100.sigr_p = INTE(wgenerage.si)
        sic_bran.uwm100.gap_p  = nv_gapprm.
END.

fi_display = "Generage Premium...".
DISPLAY fi_display WITH FRAME fr_main.

ASSIGN
    nv_stamp  = 0
    nv_tax    = 0
    nv_com1_t = 0.

nv_com1_t = ((nv_pdprm * nv_com1p) / 100) * -1.
IF (nv_pdprm * (0.4 / 100)) - TRUNCATE(nv_pdprm * (0.4 / 100),0) > 0 THEN
     nv_stamp  = TRUNCATE(nv_pdprm * (0.4 / 100),0) + 1.
ELSE nv_stamp  = TRUNCATE(nv_pdprm * (0.4 / 100),0).

nv_tax    = (nv_pdprm + nv_stamp) * (7 / 100).  

FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-ERROR.
IF AVAIL sic_bran.uwm120 THEN DO:
    ASSIGN
         sic_bran.uwm120.gap_r  = nv_gapprm
         sic_bran.uwm120.prem_r = nv_pdprm
         sic_bran.uwm120.sigr   = INTE(wgenerage.si)
         sic_bran.uwm120.com1_r = nv_com1_t
         sic_bran.uwm120.rstp_r = nv_stamp
         sic_bran.uwm120.rtax_r = nv_tax.
END.

FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-ERROR.
IF AVAIL sic_bran.uwm301 THEN DO:
    ASSIGN   
        /*sic_bran.uwm301.ncbper   = nv_ncbper  */ /*A64-0138*/
        /*sic_bran.uwm301.ncbyrs   = nv_ncbyrs  */ /*A64-0138*/
        sic_bran.uwm301.mv41seat = INTE(nv_seat41).
END.
/*comment by : A64-0138..
RUN WGS\WGSTN132(INPUT s_recid3,
                 INPUT s_recid4).*/

RUN Proc_ClearData.

fi_display = "Generage Data Complete...".
DISPLAY fi_display WITH FRAME fr_main.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_72Check C-Win 
PROCEDURE Proc_72Check :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ตรวจสอบข้อมูล 72 ก่อนนำเข้า   Add A57-0228     
------------------------------------------------------------------------------*/

fi_display = "Check data transfer...".
DISPLAY fi_display WITH FRAME fr_main.

/*--- comment phorn ---
IF wgenerage.policy = "" OR
   wgenerage.prem   = 0  OR
   wgenerage.stamp  = 0  OR
   wgenerage.tax    = 0  THEN DO:

    MESSAGE "(1) ข้อมูล Prem, Stamp, Tax ไม่ถูกต้อง" wgenerage.policy.
    ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "(1) ข้อมูล Prem, Stamp, Tax ไม่ถูกต้อง |".

    PUT STREAM nnotdata
        "Prem,Stamp,Vat = 0 " wgenerage.policy
        " "                   wgenerage.name1
        " Sticker: "          wgenerage.sticker
    SKIP.
    NEXT.
END.
--- end comment phorn----*/

/*--- Add phorn ---*/
IF wgenerage.policy = "" THEN DO:
    ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "(1) ข้อมูล Policy ไม่ถูกต้อง |".
END.
/*--- End Add phorn ---*/

IF wgenerage.name1   = "" OR
   wgenerage.addr1   = "" THEN DO:

    /*MESSAGE "(2) ข้อมูล Name, Address, Sticker ไม่ถูกต้อง" wgenerage.policy.*/
    ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "(2) ข้อมูล Name, Address, Sticker ไม่ถูกต้อง |".

    /*--
    PUT STREAM nnotdata
        "Name,Address = '' " wgenerage.policy
        " "                  wgenerage.name1
        " Sticker: "         wgenerage.sticker SKIP.
    NEXT.
    ---*/
END.

IF wgenerage.comdat  = ?  OR
   wgenerage.expdat  = ? THEN DO:
    /*MESSAGE "(3) ข้อมูล Com.Date, Exp.Date Name ไม่ถูกต้อง" wgenerage.policy.*/
    ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "(3) ข้อมูล Com.Date, Exp.Date Name ไม่ถูกต้อง |".

    /*--
    PUT STREAM nnotdata
        "Com.Date,Exp.Date= " wgenerage.policy
        " Sticker: "          wgenerage.sticker
        " Com.Dat: "          wgenerage.comdat
        " Exp.Dat: "          wgenerage.expdat
        " "                   wgenerage.name1   SKIP.
    NEXT.
    ---*/
END.

ASSIGN
    nv_rencnt = 0
    nv_endcnt = 0
    nv_line   = nv_line  + 1
    nv_branch = fi_branch.

ASSIGN
    nv_prem_t = 0 /*wgenerage.prem*/
    nv_stamp  = 0 /*wgenerage.stamp*/
    nv_tax    = 0 /*wgenerage.tax*/
    nv_com1p  = 0
    nv_com1_t = 0
    nv_prem1  = 0.

ASSIGN
    nv_undyr  = ""
    nv_undyr  = STRING(YEAR(wgenerage.comdat),"9999")
    nv_poltyp = ""
    nv_poltyp = wgenerage.poltyp.

/*--- ค้นหาค่า Commission -----*/
FIND LAST sicsyac.xmm018 USE-INDEX xmm01801 WHERE
          sicsyac.xmm018.agent       = TRIM(fi_producer)  AND
   SUBSTR(sicsyac.xmm018.poltyp,1,5) = "CR" + nv_poltyp   AND
   SUBSTR(sicsyac.xmm018.poltyp,7,1) = nv_branch          AND
          sicsyac.xmm018.datest     <= wgenerage.comdat   NO-LOCK NO-ERROR. 
IF AVAIL sicsyac.xmm018 THEN DO:
    nv_com1p = sicsyac.xmm018.commsp.
END.
ELSE DO:
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.poltyp = nv_poltyp
    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm031 THEN nv_com1p = 0.
    ELSE nv_com1p = sicsyac.xmm031.comm1.
END.

IF fi_comm <> "" THEN nv_com1p = INTE(fi_comm).  

/*--- ตรวจสอบเบี้ยเต็มปีไม่เต็มปี ---*/
/*nv_polday = wgenerage.expdat - wgenerage.comdat.*//*Comment A58-0081*/
/*-- Add A58-0081 --*/
nv_polday = 0.
RUN Proc_ChkDate.
/*-- End A58-0081 --*/

/*--- Phorn ---
IF nv_polday <> 365 THEN DO:
    nv_prem_t = ROUND(wgenerage.prem * (nv_polday + 1),2) / 365.
    nv_prem_t = nv_prem_t - ((nv_prem_t * 12) / 100).
END.
ELSE nv_prem_t = wgenerage.prem - ((wgenerage.prem * 12) / 100).

IF (nv_prem_t * (0.4 / 100)) - TRUNCATE(nv_prem_t * (0.4 / 100),0) > 0 THEN
     nv_stamp  = TRUNCATE(nv_prem_t * (0.4 / 100),0) + 1.
ELSE nv_stamp  = TRUNCATE(nv_prem_t * (0.4 / 100),0).
---- Phorn ---*/

IF fi_dspc = "" THEN fi_dspc = "12". /*-- Phorn ---*/
DISPLAY fi_dspc WITH FRAME fr_main.  /*A59-0409*/

fi_dspc = INPUT fi_dspc.  /*A59-0409*/

/*-- Add A59-0409 --*/
IF nv_polday = 365 OR nv_polday = 366 THEN DO:
    nv_prem_t = TRUNCATE(ROUND((wgenerage.prem_t * nv_polday),2) / 365,2).
    nv_prem_t = nv_prem_t - ((nv_prem_t * INTE(fi_dspc)) / 100).
END.
ELSE DO:
    nv_prem_t = ROUND(wgenerage.prem_t / 365,2).
    
    nv_prem_t = nv_prem_t * (nv_polday).
    
    nv_prem_t = nv_prem_t - (nv_prem_t * INTE(fi_dspc)) / 100.
END.
/*-- End Add A59-0409 --*/

/*-- Comment A58-0081 --
IF nv_polday <> 365 THEN DO:
    nv_prem_t = ROUND(wgenerage.prem_t * (nv_polday + 1),2) / 365.
    nv_prem_t = nv_prem_t - ((nv_prem_t * INTE(fi_dspc)) / 100).
END.
ELSE nv_prem_t = wgenerage.prem_t - ((wgenerage.prem_t * INTE(fi_dspc)) / 100).
--- End A58-0081 ---*/
/*-- Comment A59-0409 --
/*-- Add A58-0081 --*/
nv_prem_t = ROUND((wgenerage.prem_t * nv_polday),2) / 365.
nv_prem_t = nv_prem_t - ((nv_prem_t * INTE(fi_dspc)) / 100).
/*-- End A58-0081 --*/
--- End Comment A59-0409 ----*/

IF (nv_prem_t * (0.4 / 100)) - TRUNCATE(nv_prem_t * (0.4 / 100),0) > 0 THEN
     nv_stamp  = TRUNCATE(nv_prem_t * (0.4 / 100),0) + 1.
ELSE nv_stamp  = TRUNCATE(nv_prem_t * (0.4 / 100),0).

nv_tax    = (nv_prem_t + nv_stamp) * (7 / 100).


/*-- Phorn --
ASSIGN
    nv_name      = ""
    nv_insname1  = "".


nv_insref   = "".
nv_title    = "".
nv_insref   = "0C56114". /*A57-0078*/ 
nv_insname1 = wgenerage.name1.
nv_title    = wgenerage.tiname.
-- Phorn --*/

sh_policy   = wgenerage.policy.
RUN proc_chkcode . /*A64-0138*/
RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */
RUN proc_72uwm100.
RUN proc_72uwm120.
RUN proc_72uwm301.
RUN proc_72uwm130.
RUN proc_72uwd132.

nv_total = 0.
nv_total = sic_bran.uwm100.prem_t
         + sic_bran.uwm100.rstp_t
         + sic_bran.uwm100.rtax_t.

IF wgenerage.rec_status  = "Y" THEN sic_bran.uwm100.impflg = YES.
ELSE sic_bran.uwm100.impflg = NO.

RELEASE sic_bran.uwm100.
RELEASE sic_bran.uwm120.
RELEASE sic_bran.uwm130.
RELEASE sic_bran.uwm301.
RELEASE sic_bran.uwd132.
RELEASE stat.detaitem.    

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_72ChkGen C-Win 
PROCEDURE Proc_72ChkGen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Check data gen....".
DISPLAY fi_display WITH FRAME fr_main.

IF wexcel.policy = "" OR SUBSTR(wexcel.policy,1,1) <> "D" /*OR SUBSTR(wexcel.policy,1,1) <> "I"*/ THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| No Policy, Can not transfer ".
END.

IF wexcel.vehreg = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Vehicle Register is mandatory field ".
END.

IF wexcel.name1 = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Name is mandatory field ".
END.

IF wexcel.makdes = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Makedes is mandatory field ".
END.

IF wexcel.CLASS = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Moddes is mandatory field ".
END.

IF wexcel.engine = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Engine\CC is mandatory field ".
END.

IF wexcel.yrmanuf = 0 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Year Manuf. is mandatory field ".
END.

IF wexcel.cha_no = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Chassis is mandatory field ".

END.
ELSE DO:
    /*-- Comment A58-0377 --
    FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
              sicuw.uwm301.cha_no = wexcel.cha_no NO-LOCK NO-ERROR.  
    --- End Comment A58-0377 --*/
    FIND LAST sicuw.uwm301 USE-INDEX uwm30103 WHERE
              sicuw.uwm301.trareg = wexcel.cha_no AND
              SUBSTR(sicuw.uwm301.policy,3,2) = "72" NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm301 THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                  sicuw.uwm100.policy = sicuw.uwm301.policy AND
                  sicuw.uwm100.poltyp = "V72"               NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.comdat = DATE(wexcel.comdat) THEN DO:
                ASSIGN
                    wexcel.rec_status  = "N"
                    wexcel.rec_comment = wexcel.rec_comment + "| Chassis : " + wexcel.cha_no + " นำเข้าระบบแล้ว".
            END.
        END.
    END.
END.

/*--
IF wexcel.modcod = "" THEN DO:
    RUN proc_chkredbook.
END.
ELSE DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
               stat.maktab_fil.sclass = wexcel.CLASS      AND 
               stat.maktab_fil.modcod = wexcel.modcod     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            nv_modcod  = stat.maktab_fil.modcod
            nv_moddes  = stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            nv_cargrp  = stat.maktab_fil.prmpac  
            nv_si      = stat.maktab_fil.si
            wexcel.makdes  = stat.maktab_fil.makdes
            wexcel.modcod  = stat.maktab_fil.modcod
            wexcel.seats   = STRING(stat.maktab_fil.seats).

        IF wexcel.covcod = "1" THEN DO:
            FIND FIRST stat.makdes31 WHERE
                       stat.makdes31.makdes = "X"              AND
                       stat.makdes31.moddes = wexcel.class NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.makdes31 THEN DO:
                ASSIGN
                    nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                    nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                    nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                    nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            END.
            ELSE DO:
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
            END.

            IF DECI(wexcel.si) > nv_maxsi  OR  DECI(wexcel.si) < nv_minsi THEN DO:
                IF nv_maxsi = nv_minsi THEN DO:
                    IF nv_maxsi = 0 AND nv_minsi = 0 THEN DO:
                        ASSIGN
                            wexcel.rec_status  = "N"
                            wexcel.rec_comment = "Not Found Sum Insure in Maktab_fil".
                    END.
                    ELSE DO:
                        ASSIGN
                            wexcel.rec_status  = "N"
                            wexcel.rec_comment = "Not Found Sum Insured Rates Maintenance in makdes31 Tariff X".
                    END.
                END.
                ELSE DO:
                    ASSIGN
                        wexcel.rec_status  = "N"
                        wexcel.rec_comment = "Sum Insure must " + nv_mindes + " and " + nv_maxdes.
                END.
            END.
        END.
    END.
END.
-----*/

IF wexcel.CLASS <> "" THEN DO:

    FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
               sicsyac.xmd031.poltyp  = "V72"        AND
               sicsyac.xmd031.CLASS   = wexcel.CLASS NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmd031 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|Not On Business Class xmd031".
    END.

    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
         sicsyac.xmm016.CLASS = wexcel.CLASS NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm016 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|Not on Business class on xmm016".
    END.

END.

FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod  = "U014"   AND
     sicsyac.sym100.itmcod  = wexcel.vehusg NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|Not on Vehicle Usage Codes table sym100 u014".
END.

FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod = "U013"    AND
     sicsyac.sym100.itmcod = wexcel.covcod NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|Not on Motor Cover Type Codes table sym100 u013".
END.

IF DECI(wexcel.ncb) = 0  OR DECI(wexcel.ncb) = 20 OR
   DECI(wexcel.ncb) = 30 OR DECI(wexcel.ncb) = 40 OR
   DECI(wexcel.ncb) = 50 THEN.
ELSE DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|not on NCB Rates file xmm104".
END.

IF DECI(wexcel.ncb) <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
               sicsyac.xmm104.tariff = "X"               AND
               sicsyac.xmm104.CLASS  = wexcel.class      AND
               sicsyac.xmm104.covcod = wexcel.covcod     AND
               sicsyac.xmm104.ncbper = DECI(wexcel.ncb)  NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm104 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|This NCB Step not on NCB Rates file xmm104".
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_72Gen C-Win 
PROCEDURE Proc_72Gen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Gen Policy 72 For Transfer to Premium  Add A57-0228    
------------------------------------------------------------------------------*/
fi_display = "Please wait... Generate data...".
DISPLAY fi_display WITH FRAME fr_main.

FOR EACH wexcel:
    DELETE wexcel.
END.

INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.seqno1
        wexcel.policy
        wexcel.CLASS
        wexcel.makdes
        wexcel.moddes
        wexcel.body
        wexcel.engno
        wexcel.cha_no
        wexcel.engine
        wexcel.seats     /*Add A57-0228-01*/
        wexcel.vehreg
        wexcel.provin
        wexcel.yrmanuf
        wexcel.covcod
        wexcel.comdat
        wexcel.expdat
        wexcel.prem_t
        wexcel.comp
        wexcel.prem
        wexcel.stamp
        wexcel.tax
        wexcel.sumtot
        wexcel.name1
        wexcel.addr1
        wexcel.addr2
        wexcel.addr3
        wexcel.addr4
        .

    IF wexcel.CLASS = "220" THEN wexcel.CLASS = "220A".
    ELSE IF wexcel.CLASS = "320" THEN wexcel.CLASS = "240A".

    /*---
    MESSAGE " wexcel.seqno1  = "  wexcel.seqno1  SKIP
            " wexcel.policy  = "  wexcel.policy  SKIP
            " wexcel.CLASS   = "  wexcel.CLASS   SKIP
            " wexcel.makdes  = "  wexcel.makdes  SKIP
            " wexcel.moddes  = "  wexcel.moddes  SKIP
            " wexcel.body    = "  wexcel.body    SKIP
            " wexcel.engno   = "  wexcel.engno   SKIP
            " wexcel.cha_no  = "  wexcel.cha_no  SKIP
            " wexcel.engine  = "  wexcel.engine  SKIP
            " wexcel.vehreg  = "  wexcel.vehreg  SKIP
            " wexcel.provin  = "  wexcel.provin  SKIP
            " wexcel.yrmanuf = "  wexcel.yrmanuf SKIP
            " wexcel.covcod  = "  wexcel.covcod  SKIP 
            " wexcel.comdat  = "  wexcel.comdat  SKIP 
            " wexcel.expdat  = "  wexcel.expdat  SKIP 
            " wexcel.prem_t  = "  wexcel.prem_t  SKIP 
            " wexcel.comp    = "  wexcel.comp    SKIP 
            " wexcel.prem    = "  wexcel.prem    SKIP 
            " wexcel.stamp   = "  wexcel.stamp   SKIP
            " wexcel.tax     = "  wexcel.tax     SKIP
            " wexcel.sumtot  = "  wexcel.sumtot   VIEW-AS ALERT-BOX.
      ---*/      

END. /*REPEAT*/

/*--- ยกเลิกการนำเข้า Policy ตาม Parameter ใช้นำเข้าจาก Excel File อย่างเดียว ---
FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
           stat.polno_fil.dir_ri    = YES                              AND
           stat.polno_fil.poltyp    = "V72"                            AND
           stat.polno_fil.branch    = "0WC"                            AND
           stat.polno_fil.undyr     = STRING(YEAR(TODAY) + 543,"9999") AND
           stat.polno_fil.start_no  = "WC"                             NO-LOCK NO-ERROR.
IF AVAIL stat.polno_fil THEN DO:
    nv_pol70 = stat.polno_fil.nextno - 1.
END.
ELSE DO:
    FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
               stat.polno_fil.dir_ri   = YES    AND
               stat.polno_fil.poltyp   = "V72"  AND
               stat.polno_fil.branch   = "0WC"                                  
    NO-LOCK NO-ERROR.
    IF AVAIL stat.polno_fil THEN DO:
        nv_pol70 = stat.polno_fil.nextno - 1.
    END.
END.
----*/

FOR EACH wexcel NO-LOCK:

    IF wexcel.seqno1 = "" THEN NEXT.
    IF wexcel.prem = "" THEN NEXT.

    IF wexcel.vehusg = "" THEN wexcel.vehusg = fi_vehuse.

    /*-- เลขที่สัญญา --*//*--- ยกเลิกการนำเข้า Policy ตาม parameter ---
    IF wexcel.policy = "" THEN DO:

        nv_pol2       = SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2) + "WC" + STRING(nv_pol70 + 1,"9999").
        wexcel.policy = "MC72" + nv_pol2.
        nv_pol70      = nv_pol70 + 1.

    END. ---*/

    ASSIGN
        nv_comdat = ?
        nv_expdat = ?
        nv_comdat = DATE(wexcel.comdat)
        nv_expdat = DATE(wexcel.expdat).

    /*--- หาทะเบียนรถ ---*/
    IF wexcel.vehreg <> "" THEN DO:
        IF wexcel.provin = "" THEN wexcel.provin = "กท".
        ELSE DO:
            IF LENGTH(wexcel.provin) > 2 THEN DO:
                FIND FIRST brstat.insure                        WHERE
                           brstat.insure.compno = "999"         AND
                           brstat.insure.Fname  = wexcel.provin NO-LOCK NO-ERROR.
                IF AVAIL brstat.insure THEN DO:
                    wexcel.provin = brstat.insure.Lname.
                END.
                ELSE wexcel.provin = "กท".
            END.
            /*---- Add Tunyaporn K. ---*/
            IF LENGTH(wexcel.provin) <> 2 THEN DO:
                FIND FIRST brstat.insure                        WHERE
                           brstat.insure.compno = "999"         AND
                           brstat.insure.Fname  = wexcel.provin NO-LOCK NO-ERROR.
                IF AVAIL brstat.insure THEN DO:
                    wexcel.provin = brstat.insure.Lname.
                END.
                ELSE wexcel.provin = "กท".
            END.
            /*---- End Tunyaporn K. ---*/
            /*ELSE wexcel.provin = "กท".*/     /*--- A58-0265 Tunyaporn K. ---*/
        END.
    
        nv_vehreg = wexcel.vehreg.

        IF  SUBSTR(wexcel.vehreg,1,1) <> "/" THEN DO:
            IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
                IF SUBSTR(wexcel.vehreg,2,1) >= "1" AND SUBSTR(wexcel.vehreg,2,1) <= "9" THEN DO:
                    wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
                END.
                ELSE wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)) + " " + wexcel.provin.
            END.
            ELSE DO:
                wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
            END.
        END.
        ELSE wexcel.vehreg = wexcel.vehreg.
    END.
    ELSE DO:
        IF LENGTH(wexcel.cha_no) >= 9 THEN wexcel.vehreg = "/" + SUBSTR(wexcel.cha_no,(LENGTH(wexcel.cha_no) - 9) + 1,9).
        ELSE wexcel.vehreg = "/" + wexcel.cha_no.
    END.

    /*---
    nv_vehreg = wexcel.vehreg.
    IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
        wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)).
    END.
    ELSE DO:
        wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)).
    END.
    ----*/

    /*-- หา Address --*/
    IF wexcel.name1 = "" THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
            sicsyac.xmm600.acno = "0C56114" NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm600 THEN DO:
            ASSIGN
                wexcel.insref = sicsyac.xmm600.acno
                wexcel.tiname = sicsyac.xmm600.ntitle
                wexcel.name1  = sicsyac.xmm600.NAME  
                wexcel.addr1  = sicsyac.xmm600.addr1 
                wexcel.addr2  = sicsyac.xmm600.addr2 
                wexcel.addr3  = sicsyac.xmm600.addr3 
                wexcel.addr4  = sicsyac.xmm600.addr4
                wexcel.icno   = sicsyac.xmm600.icno 
                /*Add by Kridtiya i. A63-0472*/
                wexcel.insnamtyp      = TRIM(sicsyac.xmm600.acno_typ)
                wexcel.firstName      = TRIM(sicsyac.xmm600.firstname)
                wexcel.lastName       = TRIM(sicsyac.xmm600.lastName)
                wexcel.postcd         = trim(sicsyac.xmm600.postcd)
                wexcel.codeocc        = trim(sicsyac.xmm600.codeocc) 
                wexcel.codeaddr1      = TRIM(sicsyac.xmm600.codeaddr1)
                wexcel.codeaddr2      = TRIM(sicsyac.xmm600.codeaddr2)
                wexcel.codeaddr3      = trim(sicsyac.xmm600.codeaddr3)
                wexcel.br_insured     = trim(sicsyac.xmm600.anlyc5) .
                /*Add by Kridtiya i. A63-0472*/
        END.
    END.

    wexcel.rec_status = "Y".
    RUN Proc_72ChkGen.

    IF wexcel.rec_status = "Y" THEN DO:
        /*--- Create Data Gen ---*/
        CREATE wgenerage.
        ASSIGN
            wgenerage.policy      = wexcel.policy
            wgenerage.poltyp      = "V72"
            wgenerage.insref      = wexcel.insref  /*Phorn*/
            wgenerage.tiname      = wexcel.tiname
            wgenerage.name1       = wexcel.name1                    
            wgenerage.addr1       = wexcel.addr1                     
            wgenerage.addr2       = wexcel.addr2                     
            wgenerage.addr3       = wexcel.addr3                     
            wgenerage.addr4       = wexcel.addr4                     
            wgenerage.icno        = wexcel.icno
            wgenerage.comdat      = nv_comdat
            wgenerage.expdat      = nv_expdat
            wgenerage.accdat      = nv_comdat
            wgenerage.CLASS       = wexcel.CLASS
            wgenerage.makdes      = wexcel.makdes
            wgenerage.moddes      = wexcel.moddes
            wgenerage.vehreg      = wexcel.vehreg   /***/
            wgenerage.seats       = wexcel.seats     /*Add A57-0228-01*/
            wgenerage.Provin      = wexcel.Provin   /***/
            wgenerage.cha_no      = wexcel.cha_no
            wgenerage.engno       = wexcel.engno
            wgenerage.body        = wexcel.body     /***/
            wgenerage.engine      = wexcel.engine
            wgenerage.yrmanuf     = wexcel.yrmanuf  /***/
            wgenerage.vehusg      = wexcel.vehusg
            wgenerage.sticker     = wexcel.sticker  /***/
            wgenerage.Prem_t      = wexcel.prem_t
            wgenerage.comp        = wexcel.comp
            wgenerage.prem        = DECIMAL(wexcel.prem)
            wgenerage.stamp       = DECIMAL(wexcel.stamp)
            wgenerage.tax         = DECIMAL(wexcel.tax)
            wgenerage.rec_status  = "Y"                          
            wgenerage.rec_comment = " "
            /*Add by Kridtiya i. A63-0472*/
            wgenerage.insnamtyp   = trim(wexcel.insnamtyp)  
            wgenerage.firstName   = trim(wexcel.firstName)  
            wgenerage.lastName    = trim(wexcel.lastName)  
            wgenerage.postcd      = trim(wexcel.postcd)  
            wgenerage.icno        = trim(wexcel.icno)  
            wgenerage.codeocc     = trim(wexcel.codeocc)  
            wgenerage.codeaddr1   = trim(wexcel.codeaddr1)  
            wgenerage.codeaddr2   = trim(wexcel.codeaddr2)  
            wgenerage.codeaddr3   = trim(wexcel.codeaddr3)  
            wgenerage.br_insured  = trim(wexcel.br_insured) 
            wgenerage.campaign_ov = trim(wexcel.campaign_ov)   .   
            /*Add by Kridtiya i. A63-0472*/  
    
        IF INDEX(wgenerage.engine,".") <> 0 THEN DO:
            nv_count         = INDEX(wgenerage.engine,".").
            wgenerage.engine = SUBSTR(wgenerage.engine,1,(nv_count - 1)).
        END.
    END.

END.  /*FOR EACH wexcel*/

/*-- Check งานนำเข้า --*/
FIND FIRST wgenerage NO-LOCK NO-ERROR.
IF NOT AVAIL wgenerage THEN DO:
    MESSAGE " Not found data For Generate" VIEW-AS ALERT-BOX.
END.

sh_policy  = "".
nv_line    = 0.

OUTPUT STREAM nnotdata  TO  VALUE(nv_notdata).

FOR EACH wgenerage NO-LOCK:
    ASSIGN
        nv_reccnt   = nv_reccnt + 1 /*note add on 23/05/2007*/
        nv_netprm_t = nv_netprm_t + wgenerage.prem.

    RUN Proc_72Check.
END.

OUTPUT STREAM nnotdata  CLOSE.

/***--- Disp Browse ---***/
OPEN QUERY BROWSE-4 FOR EACH wgenerage . 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72uwd132 C-Win 
PROCEDURE proc_72uwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Please wait.. Gen 72 UWD132...".
DISPLAY fi_display WITH FRAME fr_main.

DEF VAR nv_compcod AS CHAR.
DEF VAR nv_compvar AS CHAR.
DEF VAR nv_dspccod AS CHAR.
DEF VAR nv_dspcvar AS CHAR.
DEF VAR nv_dspc    AS DECI.
DEF VAR nv_bptr    AS INTE.

FOR EACH  wk_uwd132 :
    DELETE wk_uwd132.
END.

nv_line   = 0.
nv_polday = 0.
nv_prem_t = 0.

/*-- Add A58-0081 --*/
RUN Proc_ChkDate.
/*nv_prem_t = TRUNCATE(ROUND((wgenerage.prem_t * nv_polday),2) / 365,2).*//*Comment A59-0409*/
/*-- End A58-0081 --*/

/*-- Comment A58-0081 --
nv_polday = wgenerage.expdat - wgenerage.comdat. 
IF nv_polday <> 365 THEN DO:
    nv_prem_t = TRUNCATE(ROUND(wgenerage.prem_t * (nv_polday + 1),2) / 365,2).
END.
ELSE nv_prem_t = wgenerage.prem_t.
---- End Comment A58-0081 --*/

/*-- Add A59-0409 --*/

IF nv_polday = 365 OR nv_polday = 366 THEN DO:
    nv_prem_t = TRUNCATE(ROUND((wgenerage.prem_t * nv_polday),2) / 365,2).
END.
ELSE DO:
    nv_prem_t = ROUND(wgenerage.prem_t / 365,2).
    nv_prem_t = nv_prem_t * (nv_polday).
END.
/*-- End Add A59-0409 --*/

ASSIGN
    nv_compcod = "COMP"
    nv_dspccod = "DSPC"
    nv_dspc    = ((nv_prem_t * DECI(fi_dspc)) / 100) * -1.
   
nv_line = nv_line + 1.

IF nv_prem_t <> 0 THEN DO:
    RUN proc_WGSTK132(INPUT sic_bran.uwm130.policy,
                           sic_bran.uwm130.rencnt,
                           sic_bran.uwm130.endcnt,
                           sic_bran.uwm130.riskno,
                           sic_bran.uwm130.itemno,
                           sic_bran.uwm301.tariff,
                           nv_compcod,
                           nv_compvar,
                           nv_prem_t,
                           nv_prem_t,
                      INPUT-OUTPUT nv_line
                     ).
END.

IF nv_dspc <> 0 THEN DO:
    ASSIGN
        nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   = STRING(fi_DSPC)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1 
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2 .

    RUN proc_WGSTK132(INPUT sic_bran.uwm130.policy,
                           sic_bran.uwm130.rencnt,
                           sic_bran.uwm130.endcnt,
                           sic_bran.uwm130.riskno,
                           sic_bran.uwm130.itemno,
                           sic_bran.uwm301.tariff,
                           nv_dspccod,
                           nv_dsspcvar,
                           nv_dspc,
                           nv_dspc,
                      INPUT-OUTPUT nv_line
                     ).
END.

IF nv_line <> 0 THEN DO:
    nv_bptr = 0.
    FOR EACH wk_uwd132 NO-LOCK .
      
        CREATE sic_bran.uwd132.

        ASSIGN  sic_bran.uwd132.policy    = wk_uwd132.policy
            sic_bran.uwd132.rencnt        = wk_uwd132.rencnt
            sic_bran.uwd132.endcnt        = wk_uwd132.endcnt
            sic_bran.uwd132.riskgp        = wk_uwd132.riskgp
            sic_bran.uwd132.riskno        = wk_uwd132.riskno
            sic_bran.uwd132.itemno        = wk_uwd132.itemno
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
            sic_bran.uwd132.fptr          = 0
            sic_bran.uwd132.bchyr   = nv_batchyr  
            sic_bran.uwd132.bchno   = nv_batchno  
            sic_bran.uwd132.bchcnt  = nv_batcnt  .

        IF nv_bptr <> 0 THEN DO:
           FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
    
           wf_uwd132.fptr = RECID(sic_bran.uwd132).
        END.
    
        IF nv_bptr = 0 THEN  uwm130.fptr03 = RECID(sic_bran.uwd132).
    
        nv_bptr = RECID(sic_bran.uwd132).
    END.
    uwm130.bptr03 = nv_bptr.
END.

ASSIGN
    nv_dspc        = 0
    nv_dsspcvar1   = " "
    nv_dsspcvar2   = " "
    nv_dsspcvar    = " " .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_72uwm100 C-Win 
PROCEDURE Proc_72uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Gen Line 72 to UWM100  Add A57-0228    
------------------------------------------------------------------------------*/
fi_display = "Please wait...Gen 72 UWM100..".
DISPLAY fi_display WITH FRAME fr_main.

DO TRANSACTION :
    CREATE sic_bran.uwm100.
    ASSIGN
        sic_bran.uwm100.policy  = wgenerage.policy                        /*Policy No.*/
        sic_bran.uwm100.cr_2    = wgenerage.cr_2                          /*Append*/
        sic_bran.uwm100.cedpol  = "MC" + SUBSTR(wgenerage.policy,3,10)
        sic_bran.uwm100.rencnt  = nv_rencnt                               /*Renewal Count*/
        sic_bran.uwm100.endcnt  = nv_endcnt                               /*Endorsement Count*/
        sic_bran.uwm100.renno   = ""                                      
        sic_bran.uwm100.bchyr   = nv_batchyr                              
        sic_bran.uwm100.bchno   = nv_batchno                              
        sic_bran.uwm100.bchcnt  = nv_batcnt                               
        sic_bran.uwm100.opnpol  = nv_opnpol                               
        sic_bran.uwm100.fptr01  = 0                                       
        sic_bran.uwm100.bptr01  = 0                                       /*uwd100 Policy Upper Text*/
        sic_bran.uwm100.fptr02  = 0                                       
        sic_bran.uwm100.bptr02  = 0                                       /*uwd102 Policy Memo Text*/
        sic_bran.uwm100.fptr03  = 0                                       
        sic_bran.uwm100.bptr03  = 0                                       /*uwd105 Policy Clauses*/
        sic_bran.uwm100.fptr04  = 0                                       
        sic_bran.uwm100.bptr04  = 0                                       /*uwd103 Policy Ren. Text*/
        sic_bran.uwm100.fptr05  = 0                                       
        sic_bran.uwm100.bptr05  = 0                                       /*uwd104 Policy Endt. Text*/
        sic_bran.uwm100.fptr06  = 0                                       
        sic_bran.uwm100.bptr06  = 0                                       /*uwd106 Pol.Endt.Clauses*/
        sic_bran.uwm100.curbil  = "BHT"                                   /*Currency of Billing*/
        sic_bran.uwm100.curate  = 1                                       /*Currency rate for Billing*/
        sic_bran.uwm100.branch  = nv_branch                               /*Branch Code (of Transaction)*/
        sic_bran.uwm100.dir_ri  = YES                                     /*Direct/RI Code (D/R)*/
        sic_bran.uwm100.dept    = "B"                                     /*Department code*/
        sic_bran.uwm100.cntry   = "TH"                                    /*Country where risk is situated*/
        sic_bran.uwm100.agent   = nv_agent                                /*Agent's Ref. No.*/
        sic_bran.uwm100.poltyp  = nv_poltyp                               /*Policy Type*/
        sic_bran.uwm100.insref  = wgenerage.insref                        /*Insured's Ref. No.*/ /*nv_insref*/
        sic_bran.uwm100.ntitle  = wgenerage.tiname                        /*Title for Name Mr/Mrs/etc*/ /*nv_title */
        sic_bran.uwm100.fname   = ""                                      /*First Name*/
        sic_bran.uwm100.name1   = wgenerage.name1                         /*Name of Insured Line 1*/ /*nv_insname1*/
        sic_bran.uwm100.name2   = ""                                      /*Name of Insured Line 2*/
        sic_bran.uwm100.name3   = ""                                      /*Name of Insured Line 3*/
        sic_bran.uwm100.anam2   = wgenerage.icno                          
        sic_bran.uwm100.addr1   = wgenerage.addr1                         /*Address 1*/
        sic_bran.uwm100.addr2   = wgenerage.addr2                         /*Address 2*/
        sic_bran.uwm100.addr3   = wgenerage.addr3                         /*Address 3*/
        sic_bran.uwm100.addr4   = wgenerage.addr4                         /*Address 4*/
        sic_bran.uwm100.comdat  = wgenerage.comdat                        /*Cover Commencement Date*/
        sic_bran.uwm100.expdat  = wgenerage.expdat                        /*Expiry Date*/
        sic_bran.uwm100.accdat  = wgenerage.accdat                        /*Acceptance Date*/
        sic_bran.uwm100.trndat  = nv_trndat                               /*Transaction Date*/
        sic_bran.uwm100.fstdat  = wgenerage.comdat                        
        sic_bran.uwm100.tranty  = "N"                                     /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.undyr   = nv_undyr                                /*Underwriting Year*/
        sic_bran.uwm100.acno1   = nv_acno1                                /*Account no. 1*/
        sic_bran.uwm100.instot  = 1                                       /*Total No. of Instalments*/
        sic_bran.uwm100.trty11  = "M".                                    /*A50-0202 Shukiat T. modi on 14/08/2007*/
                                                                          
    ASSIGN                                                                
        sic_bran.uwm100.rstp_t  = nv_stamp                                /*Risk Level Stamp, Tran. Total*/   /*wgenerage.stamp*/
        sic_bran.uwm100.rtax_t  = nv_tax                                  /*Risk Level Tax, Tran. Total*/     /*wgenerage.tax */ 
        sic_bran.uwm100.prem_t  = nv_prem_t                               /*Premium Due, Tran. Total*/        /*wgenerage.prem*/ 
        sic_bran.uwm100.com1_t  = 0                                       /*Commission 1, Tran. Total*/       /*nv_com1_t*/   
        sic_bran.uwm100.gap_p   = nv_prem_t                               /*Gross Annual Prem, Pol. Total*/   /*wgenerage.prem */
        sic_bran.uwm100.drnoae  = YES                                     /*Dr/Cr Note No. (A/E)*/
        sic_bran.uwm100.insddr  = NO                                      /*Print Insd. Name on DrN*/
        sic_bran.uwm100.no_sch  = 1                                       /*No. to print, Schedule*/
        sic_bran.uwm100.no_dr   = 1                                       /*No. to print, Dr/Cr Note*/
        sic_bran.uwm100.no_ri   = 0                                       /*No. to print, RI Appln*/
        sic_bran.uwm100.no_cer  = 0                                       /*No. to print, Certificate*/
        sic_bran.uwm100.li_sch  = YES                                     /*Print Later/Imm., Schedule*/
        sic_bran.uwm100.li_dr   = YES                                     /*Print Later/Imm., Dr/Cr Note*/
        sic_bran.uwm100.li_ri   = YES                                     /*Print Later/Imm., RI Appln,*/
        sic_bran.uwm100.li_cer  = YES                                     /*Print Later/Imm., Certificate*/
        sic_bran.uwm100.scform  = ""                                      /*Schedule Format*/
        sic_bran.uwm100.enform  = ""                                      /*Endt. Format (Full/Abbr/Blank)*/
        sic_bran.uwm100.apptax  = YES                                     /*Apply risk level tax (Y/N)*/
        sic_bran.uwm100.recip  = "N"                                      /*Reciprocal (Y/N/C)*/
        sic_bran.uwm100.short   = YES                                     /*Short Term Rates*/
        sic_bran.uwm100.usrid   = USERID(LDBNAME(1))                      /*User Id  */
        sic_bran.uwm100.entdat  = TODAY                                   /*Entered Date*/
        sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS")                 /*Entered Time*/
        sic_bran.uwm100.prog    = "WGWMCGEN"                              /*Program Id that input record*/
        sic_bran.uwm100.polsta  = "IF"                                    /*Policy Status*/
        sic_bran.uwm100.langug  = "T"                                     /*Language */
        sic_bran.uwm100.sigr_p  = 0                                       /*SI Gross Pol. Total*/
        sic_bran.uwm100.acctim  = "00:00"                                 /*Acceptance Time*/
        sic_bran.uwm100.agtref  = ""                                      /*Agents Closing Reference*/
        sic_bran.uwm100.sckno   = 0                                       /*sticker no.*/
        sic_bran.uwm100.anam1   = ""                                      /*Alternative Insured Name 1*/
        sic_bran.uwm100.sirt_p  = 0                                       /*SI RETENTION Pol. total*/
        sic_bran.uwm100.anam2   = ""                                      /*Alternative Insured Name 2*/
        sic_bran.uwm100.gstrat  =  7                                      /*GST Rate % (TAX %) */
        sic_bran.uwm100.gstae   = YES                                     /*GST A/E  */
        sic_bran.uwm100.nr_pol  = NO                                      /*New Policy No. (Y/N)*/
        sic_bran.uwm100.issdat  = TODAY                                   /*Issue date*/
        sic_bran.uwm100.endern  = ?                                       /*Receipt Date*/  /*== Add By Chutikarn A53-0015 ==*/
        sic_bran.uwm100.docno1  = ""                                      /*Document No.*/
        sic_bran.uwm100.sch_p   = NO                                      /*Schedule Printed*/
        sic_bran.uwm100.drn_p   = NO.                                     /*Dr/Cr Note Printed*/
    ASSIGN
        sic_bran.uwm100.firstName  =  trim(wgenerage.firstName)        /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   =  trim(wgenerage.lastName)         /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     =  trim(wgenerage.postcd)           /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       =  trim(wgenerage.icno)             /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    =  trim(wgenerage.codeocc)          /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  =  trim(wgenerage.codeaddr1)        /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  =  trim(wgenerage.codeaddr2)        /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  =  trim(wgenerage.codeaddr3)        /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.br_insured =  trim(wgenerage.br_insured) */      /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   =  trim(wgenerage.campaign_ov)  .   /*Add by Kridtiya i. A63-0472*/

                                                                          
    IF sic_bran.uwm100.docno1 <> "" THEN                                  
        ASSIGN                                                            
            sic_bran.uwm100.sch_p  = YES                                  /*Schedule Printed*/
            sic_bran.uwm100.drn_p  = YES.                                 /*Dr/Cr Note Printed*/
                                                                          
    IF sic_bran.uwm100.prem_t =  0  THEN                                  
        ASSIGN                                                            
            sic_bran.uwm100.sch_p  = NO                                   /*Schedule Printed*/
            sic_bran.uwm100.drn_p  = NO.                                  /*Dr/Cr Note Printed*/
                                                                          
    IF wgenerage.insref = "" THEN DO:                                     
                                                                          
        nv_insref = wgenerage.insref.                                     
                                                                          
        RUN proc_createins.  /*-- Create Insure --*/                      
                                                                          
        ASSIGN                                                            
            sic_bran.uwm100.insref  = nv_insref.                          /*Insured's Ref. No.*/
                                                                          
    END.

    /*-- Set Class --*/
    IF wgenerage.CLASS = "" THEN DO:
                IF wgenerage.prem =   700   OR
                   wgenerage.prem =   800   THEN nv_class = "110" .
          ELSE  IF wgenerage.prem =  1200   THEN nv_class = "120A".
          ELSE  IF wgenerage.prem =  2050   THEN nv_class = "120B".
          ELSE  IF wgenerage.prem =  3200   THEN nv_class = "120C".
          ELSE  IF wgenerage.prem =  3740   THEN nv_class = "120D".
          ELSE  IF wgenerage.prem =   150   THEN nv_class = "130A".
          ELSE  IF wgenerage.prem =   300   THEN nv_class = "130B".
          ELSE  IF wgenerage.prem =   400   THEN nv_class = "130C".
          ELSE  IF wgenerage.prem =   600   THEN nv_class = "130D".
          ELSE  IF wgenerage.prem =  1100   THEN nv_class = "140A".
          ELSE  IF wgenerage.prem =  1220   THEN nv_class = "140B".
          ELSE  IF wgenerage.prem =  1310   THEN nv_class = "140C".
          ELSE  IF wgenerage.prem =  1700   THEN nv_class = "140D".
          ELSE  IF wgenerage.prem =  1680   THEN nv_class = "142A".
          ELSE  IF wgenerage.prem =  2320   THEN nv_class = "142B".
          ELSE  IF wgenerage.prem =  2370   THEN nv_class = "150" .
          ELSE  IF wgenerage.prem =   600   THEN nv_class = "160" .
          ELSE  IF wgenerage.prem =   720   THEN nv_class = "170" .
          ELSE  IF wgenerage.prem =   400   THEN nv_class = "171" .
          ELSE  IF wgenerage.prem =  1900   THEN nv_class = "210" .
          ELSE  IF wgenerage.prem =  2320   THEN nv_class = "220A".
          ELSE  IF wgenerage.prem =  3480   THEN nv_class = "220B".
          ELSE  IF wgenerage.prem =  6660   THEN nv_class = "220C".
          ELSE  IF wgenerage.prem =  7520   THEN nv_class = "220D".
          ELSE  IF wgenerage.prem =  4630   THEN nv_class = "220H".
          ELSE  IF wgenerage.prem =  1760   THEN nv_class = "240A".
          ELSE  IF wgenerage.prem =  1830   THEN nv_class = "240B".
          ELSE  IF wgenerage.prem =  1980   THEN nv_class = "240C".
          ELSE  IF wgenerage.prem =  2530   THEN nv_class = "240D".
          ELSE  IF wgenerage.prem =  1980   THEN nv_class = "242A".
          ELSE  IF wgenerage.prem =  3060   THEN nv_class = "242B".
          ELSE  IF wgenerage.prem =  3160   THEN nv_class = "250" .
          ELSE  IF wgenerage.prem =  600    THEN nv_class = "260" .
          ELSE  IF wgenerage.prem =  1900   THEN nv_class = "310" .
          ELSE  IF wgenerage.prem =  2320   THEN nv_class = "320A".
          ELSE  IF wgenerage.prem =  3480   THEN nv_class = "320B".
          ELSE  IF wgenerage.prem =  6660   THEN nv_class = "320C".
          ELSE  IF wgenerage.prem =  7520   THEN nv_class = "320D".
          ELSE  IF wgenerage.prem =  1580   THEN nv_class = "320E".
          ELSE  IF wgenerage.prem =  2260   THEN nv_class = "320F".
          ELSE  IF wgenerage.prem =  3810   THEN nv_class = "320G".
          ELSE  IF wgenerage.prem =  4630   THEN nv_class = "320H".
          ELSE  IF wgenerage.prem =  1760   THEN nv_class = "340A".
          ELSE  IF wgenerage.prem =  1830   THEN nv_class = "340B".
          ELSE  IF wgenerage.prem =  1980   THEN nv_class = "340C".
          ELSE  IF wgenerage.prem =  2530   THEN nv_class = "340D".
          ELSE  IF wgenerage.prem =  1980   THEN nv_class = "342A".
          ELSE  IF wgenerage.prem =  3060   THEN nv_class = "342B".
          ELSE  IF wgenerage.prem =  3160   THEN nv_class = "350" .
          ELSE  IF wgenerage.prem =   600   THEN nv_class = "360" .
          ELSE  IF wgenerage.prem =  1440   THEN nv_class = "370" .
          ELSE  IF wgenerage.prem =  1530   THEN nv_class = "401" .
          ELSE  IF wgenerage.prem =    90   THEN nv_class = "406" .
          ELSE  IF wgenerage.prem =   770   THEN nv_class = "407" .
          ELSE DO:
            IF      TRIM(wgenerage.class) = "1.3" THEN nv_class = "130B".
            ELSE IF TRIM(wgenerage.class) = "1.1" THEN nv_class = "110".
            ELSE DO:
                    IF SUBSTRING(wgenerage.policy,3,2) = "73" OR
                       SUBSTRING(wgenerage.policy,3,2) = "74"
                    THEN DO:
                      IF DECIMAL(wgenerage.engine) <=  75 THEN nv_class = "130A".
                      ELSE
                      IF DECIMAL(wgenerage.engine) >   75 AND
                         DECIMAL(wgenerage.engine) <= 125 THEN nv_class = "130B".
                      ELSE
                      IF DECIMAL(wgenerage.engine) >  125 AND
                         DECIMAL(wgenerage.engine) <= 150 THEN nv_class = "130C".
                      ELSE
                      IF DECIMAL(wgenerage.engine) >  150 THEN nv_class = "130D".
                    END.
            END.
          END.
    END.
    ELSE DO:
             IF wgenerage.CLASS = "320" THEN nv_class = "240A".
        ELSE IF wgenerage.CLASS = "120" THEN nv_class = "210".
        ELSE IF wgenerage.CLASS = "220" THEN nv_class = "220A".
        ELSE nv_class = wgenerage.CLASS.
    END.
    /*-- End Set Class --*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_72uwm120 C-Win 
PROCEDURE Proc_72uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228     
------------------------------------------------------------------------------*/
fi_display = "Please wait...Gen 72 UWM120..".
DISPLAY fi_display WITH FRAME fr_main.

DO TRANSACTION :
    CREATE sic_bran.uwm120.
    ASSIGN
        sic_bran.uwm120.policy   = wgenerage.policy               /*Policy No.*/
        sic_bran.uwm120.rencnt   = nv_rencnt                      /*Renewal Count*/
        sic_bran.uwm120.endcnt   = nv_endcnt                      /*Endorsement Count*/
        sic_bran.uwm120.riskgp   = 0                              /*Risk Group*/
        sic_bran.uwm120.riskno   = 1                              /*Risk No.*/
        sic_bran.uwm120.fptr01   = 0  sic_bran.uwm120.bptr01 = 0  /*uwd120 Risk Upper Text*/
        sic_bran.uwm120.fptr02   = 0  sic_bran.uwm120.bptr02 = 0  /*uwd121 Risk Lower Text*/
        sic_bran.uwm120.fptr03   = 0  sic_bran.uwm120.bptr03 = 0  /*uwd123 Borderau Text*/
        sic_bran.uwm120.fptr04   = 0  sic_bran.uwm120.bptr04 = 0  /*uwd125 Risk Clauses*/
        sic_bran.uwm120.fptr08   = 0  sic_bran.uwm120.bptr08 = 0  /*uwd124 Risk Endt. Text*/
        sic_bran.uwm120.fptr09   = 0  sic_bran.uwm120.bptr09 = 0  /*uwd126 Risk Endt. Clause*/
        sic_bran.uwm120.class    = nv_class                       /*Business Class Code*/
        sic_bran.uwm120.sicurr   = "BHT"                          /*Sum Insured Currency*/
        sic_bran.uwm120.siexch   = 1                              /*Sum Insured Exchange Rate*/
        sic_bran.uwm120.r_text   = ""                             /*Standard Risk Text Ref. No.*/
        sic_bran.uwm120.bchyr    = nv_batchyr 
        sic_bran.uwm120.bchno    = nv_batchno 
        sic_bran.uwm120.bchcnt   = nv_batcnt  
        sic_bran.uwm120.rskdel   = NO                             /*Risk Deleted (Y/N)*/
        sic_bran.uwm120.styp20   = ""                             /*Statistic Type Codes (4 x 20)*/
        sic_bran.uwm120.sval20   = ""                             /*Statistic Value Codes (4 x 20)*/
        sic_bran.uwm120.gap_r    = nv_prem_t                      /*Gross Annual Prem., Risk Total*/  /*wgenerage.prem*/
        sic_bran.uwm120.dl1_r    = 0                              /*Discount/Loading 1, Risk Total*/
        sic_bran.uwm120.dl2_r    = 0                              /*Discount/Loading 2, Risk Total*/
        sic_bran.uwm120.dl3_r    = 0                              /*Discount/Loading 3, Risk Total*/
        sic_bran.uwm120.rstp_r   = nv_stamp                       /*Risk Level Stamp, Risk Total*/   /*wgenerage.stamp*/
        sic_bran.uwm120.rfee_r   = 0                              /*Risk Level Fee, Risk Total*/
        sic_bran.uwm120.rtax_r   = nv_tax                         /*Risk Level Tax, Risk Total*/  /*wgenerage.tax*/  
        sic_bran.uwm120.prem_r   = nv_prem_t                      /*Premium Due, Risk Total*/     /*wgenerage.prem*/ 
        sic_bran.uwm120.com1_r   = 0                              /*Commission 1, Risk Total*/   /*nv_com1_t*/
        sic_bran.uwm120.com2_r   = 0                              /*Commission 2, Risk Total*/
        sic_bran.uwm120.com3_r   = 0                              /*Commission 3, Risk Total*/
        sic_bran.uwm120.com4_r   = 0                              /*Commission 4, Risk Total*/
        sic_bran.uwm120.com1p    = 0                              /*Commission 1 %*/   /*nv_com1p*/
        sic_bran.uwm120.com2p    = 0                              /*Commission 2 %*/
        sic_bran.uwm120.com3p    = 0                              /*Commission 3 %*/
        sic_bran.uwm120.com4p    = 0                              /*Commission 4 %*/
        sic_bran.uwm120.com1ae   = YES                            /*Commission 1 (A/E)*/  /*NO  A56-0345 -3*/
        sic_bran.uwm120.com2ae   = YES                            /*Commission 2 (A/E)*/
        sic_bran.uwm120.com3ae   = YES                            /*Commission 3 (A/E)*/
        sic_bran.uwm120.com4ae   = YES                            /*Commission 4 (A/E)*/
        sic_bran.uwm120.rilate   = NO                             /*RI to Enter Later (Y/N)*/
        sic_bran.uwm120.sigr     = 0                              /*nv_si Sum Insured, Gross*/
        sic_bran.uwm120.sico     = 0                              /*Sum Insured, Coinsurance*/
        sic_bran.uwm120.sist     = nv_sist_p                      /*Sum Insured, Statutory*/
        sic_bran.uwm120.sifac    = 0                              /*Sum Insured, Facultative*/
        sic_bran.uwm120.sitty    = nv_sity_p                      /*Sum Insured, Treaty*/
        sic_bran.uwm120.siqs     = 0                              /*Sum Insured, Quota Share*/
        sic_bran.uwm120.pdco     = 0                              /*Premium Due, Coinsurance*/
        sic_bran.uwm120.pdst     = nv_pdst_p                      /*Premium Due, Statutory*/
        sic_bran.uwm120.pdfac    = 0                              /*Premium Due, Facultative*/
        sic_bran.uwm120.pdtty    = 0                              /*Premium Due, Treaty*/
        sic_bran.uwm120.pdqs     = 0                              /*Premium Due, Quota Share*/
        sic_bran.uwm120.comco    = 0                              /*Commission, Coinsurance*/
        sic_bran.uwm120.comst    = nv_cost_p                      /*Commission, Statutory*/
        sic_bran.uwm120.comfac   = 0                              /*Commission, Facultative*/
        sic_bran.uwm120.comtty   = 0                              /*Commission, Treaty*/
        sic_bran.uwm120.comqs    = 0                              /*Commission, Quota Share*/ 
        sic_bran.uwm120.stmpae   = YES                            /*Risk Level Stamp (A/E)*/   /*NO  A56-0345 -3*/
        sic_bran.uwm120.feeae    = YES                            /*Risk Level Fee (A/E)*/
        sic_bran.uwm120.taxae    = YES                            /*Risk Level Tax (A/E)*/    /*NO  A56-0345 -3*/
        sic_bran.uwm120.siret    = 0   .                          /*SI Retention*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72uwm130 C-Win 
PROCEDURE proc_72uwm130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add A57-0228     
------------------------------------------------------------------------------*/
fi_display = "Please wait... Gen 72 UWM130...".
DISPLAY fi_display WITH FRAME fr_main.

/*--- INSURED ITEM ---*/
/* หา TARIFF ของ LINE 72 */
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
     sicsyac.xmm016.CLASS = nv_class   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL xmm016 THEN DO:
    /*--
    MESSAGE COLOR YELLOW/RED
          "Not on Business Class :" nv_class
          "on Filename xmm016".
    ---*/      

    ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "Not on Business Classes:" + nv_class + "on Filename xmm016 | ".
    NEXT.
END.
ELSE DO:
    ASSIGN
        nv_uom8_c   = sicsyac.xmm016.uom8
        nv_uom9_c   = sicsyac.xmm016.uom9
        nv_uom8_v   = sicsyac.xmm016.si_d_t[8]
        nv_uom9_v   = sicsyac.xmm016.si_d_t[9].
END.

DO TRANSACTION :
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy    = wgenerage.policy               /*Policy No.*/
        sic_bran.uwm130.rencnt    = 0                              /*Renewal Count*/
        sic_bran.uwm130.endcnt    = 0                              /*Endorsement Count*/
        sic_bran.uwm130.riskgp    = 0                              /*Risk Group*/
        sic_bran.uwm130.riskno    = 1                              /*Risk No.*/
        sic_bran.uwm130.itemno    = 1                              /*Item No.*/
        sic_bran.uwm130.i_text    = ""                             /*Std. Item Text Ref. No.*/
        sic_bran.uwm130.uom1_c    = ""                             /*UOM 1 Code*/
        sic_bran.uwm130.bchyr     = nv_batchyr                     /* batch Year */      
        sic_bran.uwm130.bchno     = nv_batchno                     /* bchno */        
        sic_bran.uwm130.bchcnt    = nv_batcnt                      /* bchcnt*/
        sic_bran.uwm130.uom2_c    = ""                             /*UOM 2 Code*/
        sic_bran.uwm130.uom3_c    = ""                             /*UOM 3 Code*/
        sic_bran.uwm130.uom4_c    = ""                             /*UOM 4 Code*/
        sic_bran.uwm130.uom5_c    = ""                             /*UOM 5 Code*/
        sic_bran.uwm130.uom6_c    = ""                             /*UOM 6 Code*/
        sic_bran.uwm130.uom7_c    = ""                             /*UOM 7 Code*/
        sic_bran.uwm130.uom1_v    = 0                              /*UOM 1 Value*/
        sic_bran.uwm130.uom2_v    = 0                              /*UOM 2 Value*/
        sic_bran.uwm130.uom3_v    = 0                              /*UOM 3 Value*/
        sic_bran.uwm130.uom4_v    = 0                              /*UOM 4 Value*/
        sic_bran.uwm130.uom5_v    = 0                              /*UOM 5 Value*/
        sic_bran.uwm130.uom6_v    = 0                              /*UOM 6 Value*/
        sic_bran.uwm130.uom7_v    = 0                              /*UOM 7 Value*/
        sic_bran.uwm130.uom1_u    = ""                             /*UOM 1 Unlimited*/
        sic_bran.uwm130.uom2_u    = ""                             /*UOM 2 Unlimited*/
        sic_bran.uwm130.uom3_u    = ""                             /*UOM 3 Unlimited*/
        sic_bran.uwm130.uom4_u    = ""                             /*UOM 4 Unlimited*/
        sic_bran.uwm130.uom5_u    = ""                             /*UOM 5 Unlimited*/
        sic_bran.uwm130.uom6_u    = ""                             /*UOM 6 Unlimited*/
        sic_bran.uwm130.uom7_u    = ""                             /*UOM 7 Unlimited*/
        sic_bran.uwm130.dl1per    = 0                              /*Discount/Loading 1 %*/
        sic_bran.uwm130.dl2per    = 0                              /*Discount/Loading 2 %*/
        sic_bran.uwm130.dl3per    = 0                              /*Discount/Loading 3 %*/
        sic_bran.uwm130.fptr01    = 0  sic_bran.uwm130.bptr01 = 0  /*uwd130 Item Upper Text*/
        sic_bran.uwm130.fptr02    = 0  sic_bran.uwm130.bptr02 = 0  /*uwd131 Item Lower Text*/
        sic_bran.uwm130.fptr03    = 0  sic_bran.uwm130.bptr03 = 0  /*uwd132 Cover & Premium*/
        sic_bran.uwm130.fptr04    = 0  sic_bran.uwm130.bptr04 = 0  /*uwd134 Item Endt. Text*/
        sic_bran.uwm130.fptr05    = 0  sic_bran.uwm130.bptr05 = 0  /*uwd136 Item Endt. Clause*/
        sic_bran.uwm130.styp20    = ""                             /*Statistic Type Codes (4 x 20)*/
        sic_bran.uwm130.sval20    = ""                             /*Statistic Value Codes (4 x 20)*/
        sic_bran.uwm130.itmdel    = NO                             /*Item Deleted*/
        sic_bran.uwm130.uom8_c    = nv_uom8_c                      /*UOM 8 Code*/
        sic_bran.uwm130.uom8_v    = nv_uom8_v                      /*UOM 8 Value*/
        sic_bran.uwm130.uom9_c    = nv_uom9_c                      /*UOM 9 Code*/
        sic_bran.uwm130.uom9_v    = nv_uom9_v                      /*UOM 9 Value*/
        sic_bran.uwm130.prem_item = 0  .                           /*Premium Due,item total*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_72uwm301 C-Win 
PROCEDURE Proc_72uwm301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Please wait... Gen 72 UWM301..".
DISPLAY fi_display WITH FRAME fr_main.

/*----- : Motor Vehicle : ------*/
nv_vehreg = "".

IF wgenerage.vehreg = "ป้ายแดง" OR
   wgenerage.vehreg = "ปด"      OR
   wgenerage.vehreg = "-"       OR
   wgenerage.vehreg = ""        THEN DO:

    IF TRIM(wgenerage.cha_no) = "" THEN DO:
        nv_vehreg = wgenerage.vehreg + " " + wgenerage.provin.
    END.
    ELSE DO:
           IF LENGTH(TRIM(wgenerage.cha_no)) <= 9  THEN
             nv_vehreg = "/" + wgenerage.cha_no.
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 10 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,2,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 11 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,3,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 12 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,4,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 13 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,5,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 14 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,6,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 15 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,7,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 16 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,8,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 17 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,9,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 18 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,10,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 19 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,11,9).
        ELSE IF LENGTH(TRIM(wgenerage.cha_no))  = 20 THEN
             nv_vehreg = "/" + SUBSTR(wgenerage.cha_no,12,9).
    END.
END.
/*ELSE nv_vehreg = wgenerage.vehreg + " " + wgenerage.provin.*/     /*--- A58-0265  Tunyaporn K. ---*/
ELSE nv_vehreg = wgenerage.vehreg.    /*--- A58-0265  Tunyaporn K. ---*/

FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE
           sicsyac.xmm102.moddes BEGINS wgenerage.makdes NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm102 THEN DO:
    wgenerage.makdes = sicsyac.xmm102.moddes.
END.
         
nv_makdes = "".
nv_makdes = TRIM(wgenerage.makdes + " " + TRIM(wgenerage.moddes)).

nv_modcod = "".
nv_cargrp = "".
nv_seats  = 0.

     IF INDEX(wgenerage.makdes,"Yamaha")   <> 0 THEN nv_modcod = "YA00".
ELSE IF INDEX(wgenerage.makdes,"Suzuki")   <> 0 THEN nv_modcod = "ZU00".
/*ELSE IF INDEX(wgenerage.makdes,"Honda")    <> 0 THEN nv_modcod = "HO00".*/
ELSE IF INDEX(wgenerage.makdes,"Kawasaki") <> 0 THEN nv_modcod = "KA03".
ELSE IF INDEX(wgenerage.makdes,"Tiger")    <> 0 THEN nv_modcod = "TI01".
ELSE DO:

    FOR EACH sicsyac.xmm102 USE-INDEX xmm10202 WHERE
       INDEX(sicsyac.xmm102.moddes,wgenerage.makdes) <> 0 NO-LOCK:

        nv_makdes = TRIM(SUBSTR(sicsyac.xmm102.moddes,LENGTH(wgenerage.makdes) + 1,20)).

        /*MESSAGE wgenerage.moddes "/" nv_makdes.*/

        IF INDEX(wgenerage.moddes,nv_makdes) = 0 THEN NEXT.
        ELSE DO:
            nv_modcod = sicsyac.xmm102.modcod.
            nv_cargrp = sicsyac.xmm102.vehgrp.
            /*nv_seats  = sicsyac.xmm102.seat.*//*Comment A57-0228-01*/

            IF wgenerage.makdes = "" THEN wgenerage.makdes = sicsyac.xmm102.moddes.
            IF wgenerage.body   = "" THEN wgenerage.body   = sicsyac.xmm102.body.
        END.
    END.

    IF nv_modcod = "" THEN DO:
        FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE
             INDEX(sicsyac.xmm102.moddes,wgenerage.makdes) <> 0 NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            nv_modcod = sicsyac.xmm102.modcod.
            nv_cargrp = sicsyac.xmm102.vehgrp.
            /*nv_seats  = sicsyac.xmm102.seat.*//*Comment A57-0228-01*/

            IF wgenerage.makdes = "" THEN wgenerage.makdes = sicsyac.xmm102.moddes.
            IF wgenerage.body   = "" THEN wgenerage.body   = sicsyac.xmm102.body.
        END.
    END.
    /*---
    FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE
               nv_makdes BEGINS sicsyac.xmm102.moddes
    NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm102 THEN DO:
        nv_modcod = sicsyac.xmm102.modcod.
        nv_cargrp = sicsyac.xmm102.vehgrp.
        nv_seats  = sicsyac.xmm102.seat.
    END.
    ---*/

    /*---
    FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE
               sicsyac.xmm102.moddes BEGINS nv_makdes 
    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicsyac.xmm102 THEN DO:

        nv_modcod = sicsyac.xmm102.modcod.
        nv_cargrp = sicsyac.xmm102.vehgrp.
        nv_seats  = sicsyac.xmm102.seat.

        IF wgenerage.makdes = "" THEN wgenerage.makdes = sicsyac.xmm102.moddes.
        IF wgenerage.body   = "" THEN wgenerage.body   = sicsyac.xmm102.body.

    END.
    ELSE DO:
        FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE
                   nv_makdes MATCHES "*" + sicsyac.xmm102.moddes + "*"
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm102 THEN DO:
            nv_modcod = sicsyac.xmm102.modcod.
            nv_cargrp = sicsyac.xmm102.vehgrp.
            nv_seats  = sicsyac.xmm102.seat.

            IF wgenerage.makdes = "" THEN wgenerage.makdes = sicsyac.xmm102.moddes.
            IF wgenerage.body   = "" THEN wgenerage.body   = sicsyac.xmm102.body.
        END.
    END.
    ---*/
END.

IF wgenerage.seats = "" THEN DO:
    IF wgenerage.CLASS = "210" THEN nv_seats = 7.
    ELSE IF wgenerage.CLASS = "220A" THEN nv_seats = 12.
    ELSE IF wgenerage.CLASS = "240A" THEN nv_seats = 3.
END.
ELSE nv_seats = INTE(wgenerage.seats).

DO TRANSACTION:

    FIND sic_bran.uwm301 USE-INDEX uwm30101 WHERE
         sic_bran.uwm301.policy = wgenerage.policy AND
         sic_bran.uwm301.rencnt = 0                AND
         sic_bran.uwm301.endcnt = 0                AND
         sic_bran.uwm301.riskgp = 0                AND
         sic_bran.uwm301.riskno = 1                AND
         sic_bran.uwm301.itemno = 1                AND
         sic_bran.uwm301.bchyr  = nv_batchyr       AND 
         sic_bran.uwm301.bchno  = nv_batchno       AND 
         sic_bran.uwm301.bchcnt = nv_batcnt        NO-ERROR NO-WAIT.
    IF NOT AVAIL sic_bran.uwm301 THEN DO:

        IF LOCKED sic_bran.uwm301 THEN DO:
            /*--- 
            MESSAGE "กรมธรรม์ Motor Vehicle "
                    wgenerage.policy 
                    "นี้ถูกใช้งานอยู่ ไม่สามารถGenerageได้".
             ----*/       

            nv_check = "ERROR".

            ASSIGN
                wgenerage.rec_status  = "N"
                wgenerage.rec_comment = wgenerage.rec_comment + "กรมธรรม์ Motor Vehicle " +              
                                        wgenerage.policy      +                  
                                        "นี้ถูกใช้งานอยู่ ไม่สามารถGenerageได้ | ".
            NEXT.
        END.

        CREATE sic_bran.uwm301.
        CREATE brstat.DetaItem.
    END.

    ASSIGN
        sic_bran.uwm301.policy   = wgenerage.policy       /*Policy No.           char*/
        sic_bran.uwm301.rencnt   = 0                      /*Renewal Count        inte*/
        sic_bran.uwm301.endcnt   = 0                      /*Endorsement Count    inte*/
        sic_bran.uwm301.riskgp   = 0                      /*Risk Group           inte*/
        sic_bran.uwm301.riskno   = 1                      /*Risk No.             inte*/
        sic_bran.uwm301.itemno   = 1                      /*Item No.             inte*/
        sic_bran.uwm301.covcod   = "T"                    /*Cover Type Code      char*/
        sic_bran.uwm301.modcod   = nv_modcod              /*Make/Model Code      char*/
        sic_bran.uwm301.bchyr    = nv_batchyr
        sic_bran.uwm301.bchno    = nv_batchno
        sic_bran.uwm301.bchcnt   = nv_batcnt 
        sic_bran.uwm301.vehreg   = nv_vehreg
        sic_bran.uwm301.eng_no   = wgenerage.engno        /*Engine No.           char*/
        sic_bran.uwm301.cha_no   = wgenerage.cha_no       /*Chassis No.          char*/
        sic_bran.uwm301.yrmanu   = wgenerage.yrmanuf      /*Year of Manufacture  inte*/
        sic_bran.uwm301.vehuse   = wgenerage.vehusg       /*Vehicle Usage Code   char*/
        sic_bran.uwm301.ncbyrs   = 0                      /*NCB Years            inte*/
        sic_bran.uwm301.ncbper   = 0                      /*NCB Percent          deci-2*/
        sic_bran.uwm301.tariff   = "9"                    /*Tariff               char*/
        sic_bran.uwm301.moddes   = wgenerage.makdes + " " + wgenerage.moddes        /*Vehicle Make/Model   char*/ /*nv_makdes */
        sic_bran.uwm301.body     = wgenerage.body         /*Vehicle Body Type    char*/
        sic_bran.uwm301.tons     = 0                      /*Vehicle Tonage       deci-2*/
        sic_bran.uwm301.seats    = nv_seats               /*No. of Seats         inte*/
        sic_bran.uwm301.vehgrp   = nv_cargrp              /*Vehicle Group        char*/  
        sic_bran.uwm301.trareg   = ""                     /*Trailer Registration char*/
        sic_bran.uwm301.logbok   = ""                     /*Vehicle Log Book No. char*/
        sic_bran.uwm301.garage   = ""                     /*GARAGE               char*/
        sic_bran.uwm301.mv41seat = 0                      /*Cover Seat (4.1)     inte*/
        sic_bran.uwm301.sckno    = nv_sticker             /*sticker no.          inte*/
        sic_bran.uwm301.itmdel   = NO     .               /*Item Deleted         logi*/

    IF sic_bran.uwm301.sckno <> 0 THEN
        sic_bran.uwm301.cert   = "Y".                  /*Vehicle Engine CC's inte*/

    IF INDEX(wgenerage.engine,".") <> 0 THEN DO:
        sic_bran.uwm301.engine = INTEGER(
        SUBSTR(wgenerage.engine,1,(INDEX(wgenerage.engine,".") - 1) )).
    END.
    ELSE
        sic_bran.uwm301.engine = INTEGER(wgenerage.engine). /*Vehicle Engine CC's inte*/


    IF wgenerage.sticker <> " " THEN DO:
        IF SUBSTR(wgenerage.sticker,1,1) = "2" THEN uwm301.drinam[9] = "STKNO:" + "0" + wgenerage.sticker.
        ELSE uwm301.drinam[9] = "STKNO:" + wgenerage.sticker. 
    END.
    ELSE uwm301.drinam[9] = "".

    ASSIGN
        brstat.detaitem.policy   = sic_bran.uwm301.policy                 
        brstat.Detaitem.rencnt   = sic_bran.uwm301.rencnt                 
        brstat.Detaitem.endcnt   = sic_bran.uwm301.endcnt                 
        brstat.Detaitem.riskno   = sic_bran.uwm301.riskno                 
        brstat.Detaitem.itemno   = sic_bran.uwm301.itemno                 
        brstat.detaitem.serailno = wgenerage.sticker
        brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
        brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
        brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt).   

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem C-Win 
PROCEDURE proc_adduwd132prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A64-0138       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 .
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

               ASSIGN fi_display = "Create data to sic_bran.uwd132  ..." + wgenerage.policy .
               DISP fi_display WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  stat.pmuwd132.gap_ae                   
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  stat.pmuwd132.pd_aep                   
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
              
               
              /* IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND wgenerage.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.*/
               IF sic_bran.uwd132.bencod = "NCB" THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END. /* end uwd132*/
            /* add : A64-0138*/
            If nv_ncbper  <> 0 Then do:
               Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = nv_tariff           AND
                   sicsyac.xmm104.class  = nv_class            AND 
                   sicsyac.xmm104.covcod = nv_covcod           AND 
                   sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
               IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                   ASSIGN wgenerage.rec_status    = "N"
                          wgenerage.rec_comment = wgenerage.rec_comment + "| This NCB Step not on NCB Rates file xmm104. ".
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
            
           /* DELETE stat.pmuwd132 .*/  /* end A64-0138 */
    END. /* end pmuwd132 */
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt C-Win 
PROCEDURE proc_calpremt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A64-0138      
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wgenerage.poltyp = "V70" THEN DO:
    ASSIGN fi_display = "Create data to base..." + wgenerage.policy .
    DISP fi_display WITH FRAM fr_main.
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
         nv_seat41  = 0          
         nv_dedod   = 0
         nv_addod   = 0
         nv_dedpd   = 0        
         nv_ncbp    = 0
         nv_fletp   = 0
         nv_dspcp   = 0
         nv_dstfp   = 0
         nv_clmp    = 0
         nv_netprem = 0     /*เบี้ยสุทธิ */
         nv_gapprm  = 0     /*เบี้ยรวม */
         nv_flagprm = "N"   /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
         nv_effdat  = ?
         nv_ratatt  = 0 
         nv_siatt   = 0 
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = NO
         nv_uom1_c  = "" 
         nv_uom2_c  = "" 
         nv_uom5_c  = "" 
         nv_uom6_c  = "" 
         nv_uom7_c  = "" .

    ASSIGN               
         nv_covcod  = wgenerage.covcod                                              
         nv_class   = trim(wgenerage.class)                                         
         nv_vehuse  = wgenerage.vehusg                                    
       /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
         nv_drivno  = 0   */                                     
         nv_driage1 = 0 /*nv_drivage1 */                                
         nv_driage2 = 0 /*nv_drivage2 */                                   
         nv_yrmanu  = INT(wgenerage.yrmanuf)                         
         nv_totsi   = sic_bran.uwm130.uom6_v       
         nv_totfi   = sic_bran.uwm130.uom7_v
         nv_vehgrp  = nv_cargrp                                                     
         nv_access  = ""                                             
       /*nv_supe    = NO*/                                              
         nv_tpbi1si = sic_bran.uwm130.uom1_v            
         nv_tpbi2si = sic_bran.uwm130.uom2_v            
         nv_tppdsi  = sic_bran.uwm130.uom5_v            
         nv_411si   = nv_411       
         nv_412si   = nv_412       
         nv_413si   = 0                       
         nv_414si   = 0                       
         nv_42si    = nv_42                
         nv_43si    = nv_43                
         nv_seat41  = nv_seat41   
         nv_dedod   = 0    
         nv_addod   = 0                              
         nv_dedpd   = 0                                  
         nv_ncbp    = wgenerage.ncb                                     
         nv_fletp   = wgenerage.fleet                                  
         nv_dspcp   = nv_dss_per                                      
         nv_dstfp   = 0                                                     
         nv_clmp    = 0  
         /*nv_netprem  = TRUNCATE(((deci(wgenerage.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wgenerage.premt) * 100) / 107.43) - TRUNCATE(((deci(wgenerage.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
         nv_netprem  = DECI(wgenerage.prem) /* เบี้ยสุทธิ */                                                
         nv_gapprm  = 0                                                       
         nv_flagprm = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat  = sic_bran.uwm100.comdat                             
         nv_ratatt  = 0                    
         nv_siatt   = 0                                                   
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = NO . 

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = nv_class     AND
           clastab_fil.covcod = wgenerage.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(wgenerage.engine) ELSE INT(wgenerage.engine).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(wgenerage.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(sic_bran.uwm301.Tons).
            END.
            nv_engcst = nv_engine .
        END.

    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */

    IF nv_modcod = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook(input  nv_makdes ,  
                               input  wgenerage.moddes ,  
                               input  INT(wgenerage.si) ,  
                               INPUT  "X",  
                               input  SUBSTR(nv_class,2,5),   
                               input  wgenerage.yrmanuf, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT nv_modcod) .
        END.
        ELSE DO:
            RUN wgw/wgwredbook(input  nv_makdes ,         
                               input  wgenerage.moddes ,  
                               input  INT(wgenerage.si) ,  
                               INPUT  "X",  
                               input  SUBSTR(nv_class,2,5),   
                               input  wgenerage.yrmanuf, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT nv_modcod) .
        END.

        IF nv_modcod <> ""  THEN ASSIGN sic_bran.uwm301.modcod = nv_modcod .
        ELSE DO:
         ASSIGN
                wgenerage.rec_comment = wgenerage.rec_comment + "| " + "Redbook is Null !! "
                wgenerage.rec_status  = "Y" .
        END.
    END.

    FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  nv_makdes AND 
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
          nv_pdprem   = DECI(wgenerage.prem).
          nv_netprem  = TRUNCATE(DECI(wgenerage.prem)  / nv_polday * 365 ,0 ) .

        END.
    END.
    /*
    MESSAGE 
    " wgenerage.covcod   "  nv_covcod     skip  
    " wgenerage.class    "  nv_class      skip  
    " wdetail.vehuse   "  nv_vehuse     skip  
    " nv_cstflg        "  nv_cstflg     skip  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/
    " nv_engine        "  nv_engcst     skip  /* ต้องใส่ค่าตาม nv_cstflg  */
    " nv_drivno        "  nv_drivno     skip  
    " nv_drivage1      "  nv_driage1    skip  
    " nv_drivage2      "  nv_driage2    skip
    " wdetail.caryear  "  nv_yrmanu     skip
    " wdetail.si       "  nv_totsi      skip  
    " wdetail.fi       "  nv_totfi      skip  
    " wdetail.cargrp   "  nv_vehgrp     skip  
    " wdetail.prmtxt   "  nv_access     skip  
    " nv_supe          "  nv_supe       skip  /*  supercar = yes/no  */                  
    " wdetail.uom1_v   "  nv_tpbi1si    skip  
    " wdetail.uom2_v   "  nv_tpbi2si    skip  
    " wdetail.uom5_v   "  nv_tppdsi     skip  
    " nv_411           "  nv_411si      skip  /*nv_411si */    
    " nv_412           "  nv_412si      skip  /*nv_412si */    
    " nv_413           "  nv_413si      skip  /*nv_413si */  
    " nv_414           "  nv_414si      skip  /*nv_414si */ 
    " nv_42            "  nv_42si       skip  
    " nv_43            "  nv_43si       skip  
    " wdetail.seat41   "  nv_seat41     skip  
    " dod1             "  nv_dedod      skip  /*nv_dedod */ 
    " dod2             "  nv_addod      skip  /*nv_addod */  
    " dod0             "  nv_dedpd      skip  /*nv_dedpd */                
    " wdetail.ncb      "  nv_ncbp       skip  
    " wdetail.fleet    "  nv_fletp      skip  
    " wdetail.dspc     "  nv_dspcp      skip  
    " nv_dstfp         "  nv_dstfp      skip  
    " nv_clmp          "  nv_clmp       skip  
    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.     
*/ 
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
/*                        INPUT-OUTPUT nv_totfi  , */
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
                       OUTPUT nv_uom1_c,  
                       OUTPUT nv_uom2_c,  
                       OUTPUT nv_uom5_c,  
                       OUTPUT nv_uom6_c,
                       OUTPUT nv_uom7_c,
                       OUTPUT nv_status, 
                       OUTPUT nv_message). 

    /*IF nv_gapprm <> DECI(wgenerage.prem) THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + string(wgenerage.prem,">>>,>>>,>>9.99")
        + nv_message VIEW-AS ALERT-BOX. 
        ASSIGN
            wgenerage.rec_comment = wgenerage.rec_comment + "| " + "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + 
            " ไม่เท่ากับเบี้ยในไฟล์ " + string(wgenerage.prem,">>,>>>,>>9.99") .
            /*wgenerage.rec_status  = "Y" .*/ */   /*comment by Kridtiya i. A65-0035*/ 
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN  ASSIGN wexcel.rec_status  = "N". /*  by Kridtiya i. A65-0035*/
        ASSIGN wgenerage.rec_comment = wgenerage.rec_comment + "|" + nv_message.              /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035*/
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input  wgenerage.comdat,
                        input  wgenerage.expdat,
                        input  wgenerage.poltyp,
                        OUTPUT nv_chkerror ) .
    IF nv_chkerror <> ""  THEN 
        ASSIGN wgenerage.rec_comment = wgenerage.rec_comment + "|" + nv_chkerror 
               wexcel.rec_status  = "N".
    /* end : A65-0035 */
    ASSIGN 
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode C-Win 
PROCEDURE proc_chkcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: A64-0138 chk Agent producer code      
------------------------------------------------------------------------------*/
nv_chkerror = "".
RUN wgw\wgwchkagpd  (INPUT fi_agent ,           
                     INPUT fi_producer ,  
                     INPUT-OUTPUT nv_chkerror).
IF nv_chkerror <> "" THEN DO:
    MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
    fi_producer SKIP
    fi_agent  VIEW-AS ALERT-BOX. 
    ASSIGN 
    wgenerage.rec_comment = wgenerage.rec_comment + nv_chkerror 
            wgenerage.rec_status  = "N" .

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ChkDataGen C-Win 
PROCEDURE Proc_ChkDataGen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Add A57-0228    
------------------------------------------------------------------------------*/
IF wexcel.vehreg = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Vehicle Register is mandatory field ".
END.

IF wexcel.name1 = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Name is mandatory field ".
END.

IF wexcel.class = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Class is mandatory field ".
END.
IF wexcel.makdes = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Makedes is mandatory field ".
END.
IF wexcel.CLASS = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Moddes is mandatory field ".
END.
IF wexcel.engine = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Engine\CC is mandatory field ".
END.
IF wexcel.yrmanuf = 0 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Year Manuf. is mandatory field ".
END.

/*--
IF wexcel.modcod = "" THEN DO:
    RUN proc_chkredbook.
END.
ELSE DO:
    FIND FIRST stat.maktab_fil USE-INDEX maktab01 WHERE 
               stat.maktab_fil.sclass = wexcel.CLASS      AND 
               stat.maktab_fil.modcod = wexcel.modcod     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.maktab_fil THEN DO:
        ASSIGN
            nv_modcod  = stat.maktab_fil.modcod
            nv_moddes  = stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            nv_cargrp  = stat.maktab_fil.prmpac  
            nv_si      = stat.maktab_fil.si
            wexcel.makdes  = stat.maktab_fil.makdes
            wexcel.modcod  = stat.maktab_fil.modcod
            wexcel.seats   = STRING(stat.maktab_fil.seats).

        IF wexcel.covcod = "1" THEN DO:
            FIND FIRST stat.makdes31 WHERE
                       stat.makdes31.makdes = "X"              AND
                       stat.makdes31.moddes = wexcel.class NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.makdes31 THEN DO:
                ASSIGN
                    nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                    nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                    nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                    nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            END.
            ELSE DO:
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
            END.

            IF DECI(wexcel.si) > nv_maxsi  OR  DECI(wexcel.si) < nv_minsi THEN DO:
                IF nv_maxsi = nv_minsi THEN DO:
                    IF nv_maxsi = 0 AND nv_minsi = 0 THEN DO:
                        ASSIGN
                            wexcel.rec_status  = "N"
                            wexcel.rec_comment = "Not Found Sum Insure in Maktab_fil".
                    END.
                    ELSE DO:
                        ASSIGN
                            wexcel.rec_status  = "N"
                            wexcel.rec_comment = "Not Found Sum Insured Rates Maintenance in makdes31 Tariff X".
                    END.
                END.
                ELSE DO:
                    ASSIGN
                        wexcel.rec_status  = "N"
                        wexcel.rec_comment = "Sum Insure must " + nv_mindes + " and " + nv_maxdes.
                END.
            END.
        END.
    END.
END.
-----*/

IF wexcel.class <> "" THEN DO:

    FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
               sicsyac.xmd031.poltyp  = "V70"        AND
               sicsyac.xmd031.CLASS   = wexcel.CLASS NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmd031 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|Not On Business Class xmd031".
    END.

    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
         sicsyac.xmm016.CLASS = wexcel.CLASS NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmm016 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|Not on Business class on xmm016".
    END.

    /*--- Phorn Comment --
    IF wexcel.tran70 = "Y" AND wexcel.tran72 = "N" THEN DO:
        FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
                   sicsyac.xmd031.poltyp  = "V70"       AND
                   sicsyac.xmd031.CLASS   = "Z" + wexcel.class NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmd031 THEN DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "|Not On Business Class xmd031".
        END.

        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
             sicsyac.xmm016.CLASS  =  "Z" + wexcel.class NO-LOCK NO-ERROR.
        IF NOT AVAIL sicsyac.xmm016 THEN DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "|Not on Business class on xmm016".
        END.
    END.
    ELSE DO:   /*-- Add A56-0345 -3 --*/
        IF wexcel.tran72 = "Y" AND wexcel.tran70 = "N" THEN DO:
            FIND FIRST sicsyac.xmd031 USE-INDEX xmd03101 WHERE
                       sicsyac.xmd031.poltyp  = "V72"       AND
                       sicsyac.xmd031.CLASS   = wexcel.class NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmd031 THEN DO:
                ASSIGN
                    wexcel.rec_status  = "N"
                    wexcel.rec_comment = wexcel.rec_comment + "|Not On Business Class xmd031".
            END.

            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                 sicsyac.xmm016.CLASS  =  wexcel.class NO-LOCK NO-ERROR.
            IF NOT AVAIL sicsyac.xmm016 THEN DO:
                ASSIGN
                    wexcel.rec_status  = "N"
                    wexcel.rec_comment = wexcel.rec_comment + "|Not on Business class on xmm016".
            END.
        END.
    END.  /*-- END A56-0345 -3 ---*/
    --- End Comment----*/
END.

FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod  = "U014"   AND
     sicsyac.sym100.itmcod  = wexcel.vehusg NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|Not on Vehicle Usage Codes table sym100 u014".
END.

FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
     sicsyac.sym100.tabcod = "U013"    AND
     sicsyac.sym100.itmcod = wexcel.covcod NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|Not on Motor Cover Type Codes table sym100 u013".
END.

IF DECI(wexcel.ncb) = 0  OR DECI(wexcel.ncb) = 20 OR
   DECI(wexcel.ncb) = 30 OR DECI(wexcel.ncb) = 40 OR
   DECI(wexcel.ncb) = 50 THEN.
ELSE DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "|not on NCB Rates file xmm104".
END.

IF DECI(wexcel.ncb) <> 0 THEN DO:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
               sicsyac.xmm104.tariff = "X"                     AND
               sicsyac.xmm104.CLASS  = "Z" + wexcel.class      AND
               sicsyac.xmm104.covcod = wexcel.covcod           AND
               sicsyac.xmm104.ncbper = DECI(wexcel.ncb)        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm104 THEN DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + "|This NCB Step not on NCB Rates file xmm104".
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ChkDate C-Win 
PROCEDURE Proc_ChkDate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VAR nv_count AS INTE FORMAT ">>>9".

nv_count = (wgenerage.expdat - wgenerage.comdat) + 1.

IF nv_count < 0 THEN RETURN.

IF (  DAY(wgenerage.comdat)     = DAY(wgenerage.expdat)   AND
    MONTH(wgenerage.comdat)     = MONTH(wgenerage.expdat) AND
     YEAR(wgenerage.comdat) + 1 = YEAR(wgenerage.expdat)) OR

   (  DAY(wgenerage.comdat)     = 29                      AND
    MONTH(wgenerage.comdat)     = 02                      AND
      DAY(wgenerage.expdat)     = 01                      AND
    MONTH(wgenerage.expdat)     = 03                      AND
     YEAR(wgenerage.comdat) + 1 = YEAR(wgenerage.expdat)) OR
     
   (  DAY(wgenerage.comdat)     = 01                      AND
    MONTH(wgenerage.comdat)     = 01                      AND
      DAY(wgenerage.expdat)     = 31                      AND
    MONTH(wgenerage.expdat)     = 12                      AND
     YEAR(wgenerage.comdat)     = YEAR(wgenerage.expdat)) 
THEN DO:
    nv_polday = 365.
END.
ELSE DO:
    nv_polday = (wgenerage.expdat - wgenerage.comdat) + 1.
END.

nv_devide = 365.

IF nv_polday = 366 THEN nv_polday = 365.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ChkPrem72 C-Win 
PROCEDURE Proc_ChkPrem72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF wgenerage.CLASS = "110"   THEN wgenerage.prem_t = 700.
IF wgenerage.class = "120A"  THEN wgenerage.prem_t = 1200.
IF wgenerage.class = "120B"  THEN wgenerage.prem_t = 2050.
IF wgenerage.class = "120C"  THEN wgenerage.prem_t = 3200.
IF wgenerage.class = "120D"  THEN wgenerage.prem_t = 3740.
IF wgenerage.class = "130A"  THEN wgenerage.prem_t = 150.
IF wgenerage.class = "130B"  THEN wgenerage.prem_t = 300.
IF wgenerage.class = "130C"  THEN wgenerage.prem_t = 400.
IF wgenerage.class = "130D"  THEN wgenerage.prem_t = 600.
IF wgenerage.class = "140A"  THEN wgenerage.prem_t = 1100.
IF wgenerage.class = "140B"  THEN wgenerage.prem_t = 1220.
IF wgenerage.class = "140C"  THEN wgenerage.prem_t = 1310.
IF wgenerage.class = "140D"  THEN wgenerage.prem_t = 1700.
IF wgenerage.class = "142A"  THEN wgenerage.prem_t = 1680.
IF wgenerage.class = "142B"  THEN wgenerage.prem_t = 2320.
IF wgenerage.class = "150"   THEN wgenerage.prem_t = 2370.
IF wgenerage.class = "160"   THEN wgenerage.prem_t = 600.
IF wgenerage.class = "170"   THEN wgenerage.prem_t = 720.
IF wgenerage.class = "171"   THEN wgenerage.prem_t = 400.
IF wgenerage.class = "210"   THEN wgenerage.prem_t = 1900.
IF wgenerage.class = "220A"  THEN wgenerage.prem_t = 2320.
IF wgenerage.class = "220B"  THEN wgenerage.prem_t = 3480.
IF wgenerage.class = "220C"  THEN wgenerage.prem_t = 6660.
IF wgenerage.class = "220D"  THEN wgenerage.prem_t = 7520.
IF wgenerage.class = "220H"  THEN wgenerage.prem_t = 4630.
IF wgenerage.class = "240A"  THEN wgenerage.prem_t = 1760.
IF wgenerage.class = "240B"  THEN wgenerage.prem_t = 1830 .
IF wgenerage.class = "240C"  THEN wgenerage.prem_t = 1980.
IF wgenerage.class = "240D"  THEN wgenerage.prem_t = 2530.
IF wgenerage.class = "242A"  THEN wgenerage.prem_t = 1980.
IF wgenerage.class = "242B"  THEN wgenerage.prem_t = 3060.
IF wgenerage.class = "250"   THEN wgenerage.prem_t = 3160.
IF wgenerage.class = "260"   THEN wgenerage.prem_t = 600.
IF wgenerage.class = "310"   THEN wgenerage.prem_t = 1900.
IF wgenerage.class = "320A"  THEN wgenerage.prem_t = 2320.
IF wgenerage.class = "320B"  THEN wgenerage.prem_t = 3480.
IF wgenerage.class = "320C"  THEN wgenerage.prem_t = 6660.
IF wgenerage.class = "320D"  THEN wgenerage.prem_t = 7520.
IF wgenerage.class = "320E"  THEN wgenerage.prem_t = 1580.
IF wgenerage.class = "320F"  THEN wgenerage.prem_t = 2260.
IF wgenerage.class = "320G"  THEN wgenerage.prem_t = 3810.
IF wgenerage.class = "320H"  THEN wgenerage.prem_t = 4630.
IF wgenerage.class = "340A"  THEN wgenerage.prem_t = 1760.
IF wgenerage.class = "340B"  THEN wgenerage.prem_t = 1830.
IF wgenerage.class = "340C"  THEN wgenerage.prem_t = 1980.
IF wgenerage.class = "340D"  THEN wgenerage.prem_t = 2530.
IF wgenerage.class = "342A"  THEN wgenerage.prem_t = 1980.
IF wgenerage.class = "342B"  THEN wgenerage.prem_t = 3060.
IF wgenerage.class = "350"   THEN wgenerage.prem_t = 3160.
IF wgenerage.class = "360"   THEN wgenerage.prem_t = 600.
IF wgenerage.class = "370"   THEN wgenerage.prem_t = 1440.
IF wgenerage.class = "401"   THEN wgenerage.prem_t = 1530.
IF wgenerage.class = "406"   THEN wgenerage.prem_t = 90.
IF wgenerage.class = "407"   THEN wgenerage.prem_t = 770. 



































































END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ClearData C-Win 
PROCEDURE Proc_ClearData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
fi_display = "Please wait... Clear data...".
DISPLAY fi_display WITH FRAME fr_main.

/*--- nv_drivcod ----*/
ASSIGN 
    nv_drivvar  = " "
    nv_drivcod  = " "
    nv_drivvar1 = " "
    nv_drivvar2 = " ".

/*---- nv_BasePrem ---*/
ASSIGN 
    nv_basevar  = " "
    nv_prem1    = 0
    nv_basecod  = " "
    nv_basevar1 = " " 
    nv_basevar2 = " ".

/*---- nv_usecod ---*/
ASSIGN 
    nv_usevar   = " "
    nv_usecod   = " "
    nv_usevar1  = " "
    nv_usevar2  = " ".

/*--- nv_engcod ---*/
ASSIGN nv_sclass   = " ".

/*----- nv_yrcod ------*/
ASSIGN
    nv_yrvar    = " "
    nv_caryr    = 0
    nv_yrvar1   = " "
    nv_yrvar2   = " "
    nv_yrcod    = " ".

/*----- nv_sicod ------*/
ASSIGN 
    nv_sivar    = " "
    nv_sicod    = " "
    nv_sivar1   = " "
    nv_sivar2   = " ".

/*------ nv_grpcod -----*/
ASSIGN 
    nv_grpvar   = " "
    nv_grpcod   = " "
    nv_grpvar1  = " "
    nv_grpvar2  = " ".

/*------ nv_bipcod ------*/
ASSIGN 
    nv_bipvar   = " "
    nv_bipcod   = " "
    nv_bipvar1  = " "
    nv_bipvar2  = " ".

/*--- nv_biacod ---*/
ASSIGN 
    nv_biavar   = " "
    nv_biacod   = " "
    nv_biavar1  = " "
    nv_biavar2  = " ".

/*--- nv_pdacod ---*/
ASSIGN 
    nv_pdavar   = " "
    nv_pdacod   = " "
    nv_pdavar1  = " "
    nv_pdavar2  = " ".

/*--- nv_add perils ---*/
ASSIGN 
    nv_411var   = " "
    nv_41cod1   = " "
    nv_411var1  = " "
    nv_411var2  = " "

    nv_412var   = " "
    nv_41cod2   = " "
    nv_412var1  = " "
    nv_412var2  = " "

    nv_411prm   = 0
    nv_412prm   = 0

    nv_42var    = " "       /*---fi_42---*/
    nv_42cod    = " "
    nv_42var1   = " "
    nv_42var2   = " "

    nv_43var    = " "      /*---fi_43---*/
    nv_43prm    = 0
    nv_43cod    = " "
    nv_43var1   = " "
    nv_43var2   = " ".

/*-- NCB --*/
ASSIGN nv_ncbper = 0
       nv_ncbyrs = 0
       nv_ncb    = 0
       nv_ncb1   = 0.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createins C-Win 
PROCEDURE proc_createins :
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

nv_name = wgenerage.tiname + wgenerage.name1.

nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4).
nv_transfer = YES.

IF nv_insref = "" THEN DO:
    FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
              sicsyac.xmm600.NAME = wgenerage.name1
    NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmm600 THEN DO:
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
    
        RUN Proc_Insno. 
                  
        IF n_check <> "" THEN DO:
            ASSIGN
                putchr  = ""
                putchr1 = ""
                putchr1 = "Error Running Insured Code."
                putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                          " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                          "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                          " "             + TRIM(putchr1).
                /*--Suthida T. A55-0064--*/
                MESSAGE putchr1 SKIP putchr
                VIEW-AS ALERT-BOX.
                /*-- Suthida T. A55-0064 --*/
    
           /* nv_message  = putchr1.*/
            nv_transfer = NO.
            nv_insref   = "".
            RETURN.
        END.
    
        loop_runningins: /*Check Insured*/
        REPEAT:
          FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
               sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL sicsyac.xmm600 THEN DO:
              RUN Proc_Insno. 
              IF  n_check <> ""  THEN DO:   
                  ASSIGN
                      putchr  = ""
                      putchr1 = ""
                      putchr1 = "Error Running Insured Code."
                      putchr  = "Policy No. : " + TRIM(sic_bran.uwm100.policy)         +               
                                " R/E "         + STRING(sic_bran.uwm100.rencnt,"99")  +
                                "/"             + STRING(sic_bran.uwm100.endcnt,"999") +
                                " "             + TRIM(putchr1).
                  /*--Suthida T. A55-0064--*/
                  MESSAGE putchr1 SKIP putchr
                  VIEW-AS ALERT-BOX.
                  /*-- Suthida T. A55-0064 --*/
                 /* nv_message  = putchr1.*/
                  nv_transfer = NO.
                  nv_insref   = "".
                  RETURN.
              END.
          END.  
          ELSE LEAVE loop_runningins.
        END.
        
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
    sicsyac.xmm600.anlyc5   =  "" .                     /*Analysis Code 5*/
END.

nv_insref = sicsyac.xmm600.acno.
nv_transfer = YES.

FIND sicsyac.xtm600 WHERE
     sicsyac.xtm600.acno  = nv_insref
NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
  IF LOCKED sicsyac.xtm600 THEN DO:
    nv_transfer = NO.
    RETURN.
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

RETURN.
HIDE MESSAGE NO-PAUSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_gencr_2 C-Win 
PROCEDURE proc_gencr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR len AS INTE.
DEFINE BUFFER wuwm100 FOR wgenerage.
    len = LENGTH(wgenerage.policy).

    FOR EACH wuwm100 WHERE SUBSTRING(wuwm100.policy,3,len) = SUBSTRING(wgenerage.policy,3,len) AND
                                     wuwm100.policy        <>          wgenerage.policy        NO-LOCK.

        ASSIGN
            wgenerage.cr_2 = wuwm100.policy.

    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_genprem C-Win 
PROCEDURE proc_genprem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   n_sigr_r        LIKE sic_bran.uwm130.uom6_v.
DEF VAR   n_gap_r         LIKE sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r        LIKE sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm      LIKE sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t         LIKE sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t        LIKE sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t        LIKE sic_bran.uwm100.sigr_p.
DEF VAR   nv_policy       LIKE sic_bran.uwm100.policy.
DEF VAR   nv_rencnt       LIKE sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt       LIKE sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per     LIKE sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per    LIKE sicsyac.xmm020.rvstam.
DEF VAR   nv_com2p        AS DECI INIT 0.00 .
DEF VAR   nv_com1p        AS DECI INIT 0.00 .
DEF VAR   nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR   NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR   nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR   nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR   nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR   nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR   nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR   nv_fi_com2_t    AS DECI INIT 0.00.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-ERROR NO-WAIT.
IF NOT AVAIL sic_bran.uwm100 THEN DO:
    RETURN.
END.
ELSE DO:
    ASSIGN
        nv_policy = CAPS(sic_bran.uwm100.policy)
        nv_rencnt = sic_bran.uwm100.rencnt
        nv_endcnt = sic_bran.uwm100.endcnt.

    FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwm120.bchyr   = nv_batchyr             AND 
             sic_bran.uwm120.bchno   = nv_batchno             AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt              NO-LOCK.

        FOR EACH sic_bran.uwm130 USE-INDEX uwm13001 WHERE
                 sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND 
                 sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND 
                 sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND 
                 sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND 
                 sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                 sic_bran.uwm130.bchno   = nv_batchno              AND 
                 sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.

            n_sigr_r  = n_sigr_r + uwm130.uom6_v.

            FOR EACH sic_bran.uwd132 USE-INDEX uwd13201 WHERE
                     sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                     sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                     sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                     sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                     sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                     sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                     sic_bran.uwd132.bchno   = nv_batchno              AND 
                     sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.

                IF sic_bran.uwd132.bencod = "COMP" THEN nt_compprm = nt_compprm + sic_bran.uwd132.prem_c.

                ASSIGN
                    n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r
                    n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
            END.  /*uwd132*/
        END.  /*uwm130*/

        ASSIGN
            n_gap_t      = n_gap_t   + n_gap_r
            n_prem_t     = n_prem_t  + n_prem_r
            n_sigr_t     = n_sigr_t  + n_sigr_r
            n_gap_r      = 0 
            n_prem_r     = 0  
            n_sigr_r     = 0.

    END.  /*uwm120*/
END. /* AVAIL SIC_BRAN.UWM100 */

/*--- Calculate Premium ---*/
FIND LAST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
          sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND
          sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND
          sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
          sic_bran.uwm120.bchyr   = nv_batchyr             AND 
          sic_bran.uwm120.bchno   = nv_batchno             AND 
          sic_bran.uwm120.bchcnt  = nv_batcnt              NO-ERROR.

FIND LAST sicsyac.xmm018 USE-INDEX xmm01801 WHERE
          sicsyac.xmm018.agent              = sic_bran.uwm100.acno1         AND
          SUBSTR(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp AND
          SUBSTR(sicsyac.xmm018.poltyp,7,1) = sic_bran.uwm100.branch        AND
          sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat        NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm018 THEN DO:
    ASSIGN
        nv_com1p  = sicsyac.xmm018.commsp
        nv_com2p  = 0.
END.
ELSE DO:
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm031 THEN DO:
        ASSIGN
            nv_com1p = 0
            nv_com2p = 0.
    END.
    ELSE DO:
        ASSIGN
            nv_com1p  = sicsyac.xmm031.comm1
            nv_com2p  = 0.
    END.
END.

/*---- TAX ---*/
FIND sicsyac.xmm020 USE-INDEX xmm02001 WHERE
     sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
     sicsyac.xmm020.DIR_ri = sic_bran.uwm100.DIR_ri NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN DO:

    nv_fi_stamp_per = sicsyac.xmm020.rvstam.

    IF sic_bran.uwm100.gstrat <> 0 THEN nv_fi_tax_per = sic_bran.uwm100.gstrat.
                                   ELSE nv_fi_tax_per = sicsyac.xmm020.rvtax.
END.

/*--- STAMP ---*/
IF sic_bran.uwm120.stmpae = YES THEN DO:
    nv_fi_rstp_t  = TRUNCATE(n_prem_t * nv_fi_stamp_per / 100,0) +
                    (IF     (n_prem_t * nv_fi_stamp_per / 100)   -
                    TRUNCATE(n_prem_t * nv_fi_stamp_per / 100,0) > 0
                    THEN 1 ELSE 0).
 /* nv_fi_rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                    (IF     (sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100)   -
                    TRUNCATE(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                    THEN 1 ELSE 0).                                                                        A58-0418*/
END.

sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
IF  sic_bran.uwm120.taxae   = YES   THEN DO:                       /* TAX */
    nv_fi_rtax_t  = (n_prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                     * nv_fi_tax_per  / 100. 
/* nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                     * nv_fi_tax_per  / 100.                                                               A58-0418*/
END.

sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
sic_bran.uwm120.com1ae = YES.
sic_bran.uwm120.com2ae = YES.

/*--------- motor commission -----------------*/
IF sic_bran.uwm120.com1ae   = YES THEN DO:                   /* MOTOR COMMISION */
   IF sic_bran.uwm120.com1p <> 0  THEN nv_com1p  = sic_bran.uwm120.com1p.
         nv_fi_com1_t   =  - (n_prem_t - nt_compprm) * nv_com1p / 100.            
    /*  nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.                       A58-0418*/
END.
/*----------- comp comission ------------*/
IF sic_bran.uwm120.com2ae   = YES  THEN DO:                   /* Comp.COMMISION */
    If sic_bran.uwm120.com2p <> 0  THEN nv_com2p  = sic_bran.uwm120.com2p.
         nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              
END.

IF sic_bran.uwm100.pstp <> 0 THEN DO:
   IF sic_bran.uwm100.no_sch  = 1 THEN NV_fi_dup_trip = "D".
   ELSE IF sic_bran.uwm100.no_sch  = 2 THEN  NV_fi_dup_trip = "T".
END.
ELSE  NV_fi_dup_trip  =  "".

nv_fi_netprm = n_prem_t + sic_bran.uwm100.rtax_t
             + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.

/* nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
             + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.                                             A58-0418 */


FIND sic_bran.uwm100 WHERE  RECID(sic_bran.uwm100)  =  s_recid1.
IF AVAIL sic_bran.uwm100 THEN DO: 
    ASSIGN 
         sic_bran.uwm100.gap_p   = n_gap_t
         sic_bran.uwm100.prem_t  = n_prem_t
         sic_bran.uwm100.sigr_p  = n_sigr_t
         sic_bran.uwm100.instot  = uwm100.instot
         sic_bran.uwm100.com1_t  = nv_fi_com1_t
         sic_bran.uwm100.com2_t  = nv_fi_com2_t
         sic_bran.uwm100.pstp    = 0               
         sic_bran.uwm100.rstp_t  = nv_fi_rstp_t
         sic_bran.uwm100.rtax_t  = nv_fi_rtax_t          
         sic_bran.uwm100.gstrat  = nv_fi_tax_per.
   
              
    END.
/*
FIND sic_bran.uwm120 WHERE  RECID(sic_bran.uwm120) =  s_recid2.
IF AVAIL sic_bran.uwm120 THEN DO:
     ASSIGN
         sic_bran.uwm120.gap_r    = n_gap_t   
         sic_bran.uwm120.prem_r   = n_prem_t  
         sic_bran.uwm120.sigr     = n_sigr_T  
         sic_bran.uwm120.rtax     = nv_fi_rtax_t
         sic_bran.uwm120.taxae    = YES
         sic_bran.uwm120.stmpae   = YES
         sic_bran.uwm120.rstp_r   = nv_fi_rstp_t            
         sic_bran.uwm120.com1ae   = YES
         sic_bran.uwm120.com1p    = nv_com1p
         sic_bran.uwm120.com1_r   = nv_fi_com1_t
         sic_bran.uwm120.com2ae   = YES
         sic_bran.uwm120.com2p    = nv_com2p
         sic_bran.uwm120.com2_r   = nv_fi_com2_t.
END.
comment : แก้ไข้ASSIGN                                                                                    A58-0418*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno C-Win 
PROCEDURE proc_insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_lastno   AS INT. 
DEF VAR nv_seqno    AS INT.
DEF VAR n_search    AS LOGICAL.  

n_search = YES.

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
          sicsyac.xzm056.seqtyp  =  nv_typ      AND
          sicsyac.xzm056.branch  =  nv_branch  NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
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
END. /*not avail xzm056*/       

/*---- Begin 21/11/2006 Chutikarn ----*/
ASSIGN
   nv_lastno = sicsyac.xzm056.lastno
   nv_seqno  = sicsyac.xzm056.seqno. 

IF n_check = "YES" THEN DO:       
    IF nv_typ = "0s" THEN DO: 

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

       IF   nv_typ = "0s" THEN DO:

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ReCheck72 C-Win 
PROCEDURE Proc_ReCheck72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Add A57-0228    
------------------------------------------------------------------------------*/
fi_display = "Please wait... Transfer expiry to premium...".
DISPLAY fi_display WITH FRAME fr_main.

IF wgenerage.policy = "" THEN DO:
    ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wexcel.rec_comment + "| No Policy, Can not transfer ".
END.
ELSE DO:
    IF CONNECTED("SIC_EXP") THEN DO:
    
        RUN WGW\WGWRE100 (INPUT        wgenerage.policy     ,
                          INPUT        wgenerage.cr_2       ,
                          INPUT        wgenerage.vehreg     ,
                          INPUT        wgenerage.cha_no     ,
                          INPUT        wgenerage.comdat     ,
                          INPUT        wgenerage.expdat     ,
                          INPUT        wgenerage.color1     ,
                          INPUT        nv_batchyr           ,  
                          INPUT        nv_batchno           ,  
                          INPUT        nv_batcnt            ,  
                          INPUT        n_user               ,
                          OUTPUT       wgenerage.name1      ,
                          OUTPUT       wgenerage.addr1      ,
                          OUTPUT       wgenerage.addr2      ,
                          OUTPUT       wgenerage.addr3      ,
                          OUTPUT       wgenerage.addr4      ,
                          INPUT-OUTPUT wgenerage.rec_comment,
                          INPUT-OUTPUT wgenerage.rec_status ).
    
        wgenerage.policy = wgenerage.cr_2.
        nv_line = nv_line + 1.
       
    END.
    ELSE DO:
        wgenerage.rec_comment = wgenerage.rec_comment + " | Not Connect DB :Expiry ".
        wgenerage.rec_status  = "N".
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ReChkGen70 C-Win 
PROCEDURE Proc_ReChkGen70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Please wait... Check data gen...".
DISPLAY fi_display WITH FRAME fr_main.

IF wexcel.vehreg = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Vehicle Register is mandatory field ".
END.

IF wexcel.cha_no = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Chassis no. is mandatory field ".
END.

IF ra_type = 3 THEN DO:

    FIND LAST sicuw.uwm301 USE-INDEX uwm30102 WHERE
              sicuw.uwm301.vehreg      = wexcel.vehreg AND
       SUBSTR(sicuw.uwm301.policy,3,2) = "70"          NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm301 THEN DO:
        IF TRIM(wexcel.cha_no) = sicuw.uwm301.cha_no THEN DO:
            wexcel.policy = sicuw.uwm301.policy.
        END.
        /*--
        ELSE DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "| เลขทะเบียนรถ " + sicuw.uwm301.vehreg + 
                                                            "เลขตัวถัง " + sicuw.uwm301.cha_no + " ไม่เท่ากับ " + wexcel.cha_no.
        END.
        ---*/
    END.
    ELSE DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                  sicuw.uwm301.trareg = wexcel.cha_no AND
                  SUBSTR(sicuw.uwm301.policy,3,2) = "70" NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm301 THEN DO:
            wexcel.policy = sicuw.uwm301.policy.
        END.
        /*---
        ELSE DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "| ไม่พบเลขตัวถังที่ต้องการต่ออายุ ".
        END.
        ---*/
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ReChkGen72 C-Win 
PROCEDURE Proc_ReChkGen72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Add A57-0228    
------------------------------------------------------------------------------*/
fi_display = "Please wait... Check data gen...".
DISPLAY fi_display WITH FRAME fr_main.

/*--
IF wexcel.policy = "" OR SUBSTR(wexcel.policy,1,1) <> "D" /*OR SUBSTR(wexcel.policy,1,1) <> "I"*/ THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| No Policy, Can not transfer ".
END.
---*/

IF wexcel.vehreg = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Vehicle Register is mandatory field ".
END.

IF wexcel.cha_no = "" THEN DO:
    ASSIGN
        wexcel.rec_status  = "N"
        wexcel.rec_comment = wexcel.rec_comment + "| Chassis no. is mandatory field ".
END.

IF wexcel.color1 <> "" THEN DO:
    FIND sicsyac.xmm023 WHERE sicsyac.xmm023.branch = TRIM(wexcel.color1) NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm023 THEN DO:
        wexcel.color1 = sicsyac.xmm023.branch.
    END.
    ELSE DO:
        ASSIGN
            wexcel.rec_status  = "N"
            wexcel.rec_comment = wexcel.rec_comment + " | Not found branch for change branch " + wexcel.color1. 
    END.
END.

/*--- แยกงานต่ออายุ Line 70 ออกจาก 72 เนื่องจาก Format ต่างกัน ---
IF ra_type = 3 THEN DO:

    FIND LAST sicuw.uwm301 USE-INDEX uwm30102 WHERE
              sicuw.uwm301.vehreg      = wexcel.vehreg AND
       SUBSTR(sicuw.uwm301.policy,3,2) = "70"          NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm301 THEN DO:
        IF TRIM(wexcel.cha_no) = sicuw.uwm301.cha_no THEN DO:
            wexcel.policy = sicuw.uwm301.policy.
        END.
        ELSE DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "| เลขทะเบียนรถ " + sicuw.uwm301.vehreg + 
                                                            "เลขตัวถัง " + sicuw.uwm301.cha_no + " ไม่เท่ากับ " + wexcel.cha_no.
        END.
    END.
    ELSE DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                  sicuw.uwm301.cha_no = wexcel.cha_no AND
                  SUBSTR(sicuw.uwm301.policy,3,2) = "70" NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm301 THEN DO:
            wexcel.policy = sicuw.uwm301.policy.
        END.
        ELSE DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "| ไม่พบเลขตัวถังที่ต้องการต่ออายุ ".
        END.
    END.
END.
----*/

IF ra_type = 4 THEN DO:

    FIND LAST sicuw.uwm301 USE-INDEX uwm30102 WHERE
              sicuw.uwm301.vehreg      = wexcel.vehreg AND
       SUBSTR(sicuw.uwm301.policy,3,2) = "72"          NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm301 THEN DO:
        IF TRIM(wexcel.cha_no) = sicuw.uwm301.cha_no THEN DO:
            wexcel.policy = sicuw.uwm301.policy.
        END.
        /*--
        ELSE DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "| เลขทะเบียนรถ " + sicuw.uwm301.vehreg + 
                                                            "เลขตัวถัง " + sicuw.uwm301.cha_no + " ไม่เท่ากับ " + wexcel.cha_no.
        END.
        ---*/
    END.
    ELSE DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
                  sicuw.uwm301.trareg = wexcel.cha_no AND
                  SUBSTR(sicuw.uwm301.policy,3,2) = "72" NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm301 THEN DO:
            wexcel.policy = sicuw.uwm301.policy.
        END.
        /*--
        ELSE DO:
            ASSIGN
                wexcel.rec_status  = "N"
                wexcel.rec_comment = wexcel.rec_comment + "| ไม่พบเลขตัวถังที่ต้องการต่ออายุ ".
        END.
        ---*/
    END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ReGen70 C-Win 
PROCEDURE Proc_ReGen70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Please wait... Generate data...".
DISPLAY fi_display WITH FRAME fr_main.

FOR EACH wexcel:
    DELETE wexcel.
END.

FOR EACH wgenerage:
    DELETE wgenerage.
END.

INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.seqno1
        wexcel.policy
        wexcel.comdat
        wexcel.expdat
        wexcel.insref
        wexcel.yrmanuf
        wexcel.vehreg
        wexcel.provin
        wexcel.makdes
        wexcel.moddes
        wexcel.engine
        wexcel.body
        wexcel.color1
        wexcel.access
        wexcel.engno
        wexcel.cha_no
        wexcel.finance
        wexcel.Text5
        wexcel.dealer
        wexcel.si
        wexcel.bip
        wexcel.bia
        wexcel.pda
        wexcel.m411
        wexcel.m412
        wexcel.m42
        wexcel.m43
        wexcel.CLASS
        wexcel.remark
        wexcel.prem
        wexcel.prem_t
        wexcel.covcod
        wexcel.baseprm
        wexcel.ncb
        wexcel.fleet
        wexcel.seats
        .
        
    /*-- Add Check Seats --*/
    IF wexcel.seats = "" THEN DO:
             IF INDEX(wexcel.remark,"6")  <> 0 OR
                INDEX(wexcel.remark,"4")  <> 0 THEN wexcel.seats = "7".
        ELSE IF INDEX(wexcel.remark,"2")  <> 0 THEN wexcel.seats = "3".
        ELSE IF INDEX(wexcel.remark,"11") <> 0 THEN wexcel.seats = "12".
        ELSE IF INDEX(wexcel.remark,"14") <> 0 THEN wexcel.seats = "12".
        ELSE wexcel.seats = "7".
    END.
    /*-- End Check Seats --*/

    /*-- Add Check Class --*/
    IF wexcel.CLASS = "" THEN DO:
        IF wexcel.seats = "7" THEN DO:
            IF wexcel.body = "SEDAN"  OR
               wexcel.body = "4WD"    OR
               wexcel.body = "4 WD"   OR
               wexcel.body = "2WD"    OR
               wexcel.body = "2 WD"   OR
               wexcel.body = "5 DOOR" OR
               wexcel.body = "5-DOOR" THEN wexcel.CLASS = "120".
        END.
        ELSE IF wexcel.seats = "3" THEN DO:
            IF wexcel.body = "PICKUP" THEN wexcel.CLASS = "320".
        END.
        ELSE IF wexcel.seats = "12" THEN DO:
            IF wexcel.body = "VAN"    OR
               wexcel.body = "12SEAT" OR
               wexcel.body = "11SEAT" THEN wexcel.CLASS = "220".
        END.
    END.
    /*-- End Check Class --*/
    /*----
    MESSAGE
       " wexcel.seqno1  =" wexcel.seqno1 
       " wexcel.policy  =" wexcel.policy 
       " wexcel.comdat  =" wexcel.comdat 
       " wexcel.expdat  =" wexcel.expdat 
       " wexcel.insref  =" wexcel.insref 
       " wexcel.yrmanuf =" wexcel.yrmanuf
       " wexcel.vehreg  =" wexcel.vehreg 
       " wexcel.makdes  =" wexcel.makdes 
       " wexcel.moddes  =" wexcel.moddes 
       " wexcel.engine  =" wexcel.engine 
       " wexcel.body    =" wexcel.body   
       " wexcel.color1  =" wexcel.color1 
       " wexcel.access  =" wexcel.access 
       " wexcel.engno   =" wexcel.engno  
       " wexcel.cha_no  =" wexcel.cha_no 
       " wexcel.finance =" wexcel.finance
       " wexcel.Text5   =" wexcel.Text5  
       " wexcel.dealer  =" wexcel.dealer 
       " wexcel.si      =" wexcel.si     
       " wexcel.bip     =" wexcel.bip    
       " wexcel.bia     =" wexcel.bia    
       " wexcel.pda     =" wexcel.pda    
       " wexcel.m411    =" wexcel.m411   
       " wexcel.m412    =" wexcel.m412   
       " wexcel.m42     =" wexcel.m42    
       " wexcel.m43     =" wexcel.m43    
       " wexcel.CLASS   =" wexcel.CLASS  
       " wexcel.remark  =" wexcel.remark 
       " wexcel.prem    =" wexcel.prem   
       " wexcel.prem_t  =" wexcel.prem_t 
       " wexcel.covcod  =" wexcel.covcod 
       " wexcel.baseprm =" wexcel.baseprm
       " wexcel.ncb     =" wexcel.ncb    
       " wexcel.fleet   =" wexcel.fleet  
       " wexcel.seats   =" wexcel.seats  VIEW-AS ALERT-BOX.
     ----*/  
END.

FOR EACH wexcel NO-LOCK:

    IF wexcel.seqno1 = "" THEN NEXT.

    IF wexcel.vehusg = "" THEN wexcel.vehusg = fi_vehuse.

    /*--- หาทะเบียนรถ ---*/
    IF wexcel.vehreg <> "" THEN DO:
        IF wexcel.provin = "" THEN wexcel.provin = "กท".
        ELSE DO:
            IF LENGTH(wexcel.provin) > 2 THEN DO:
                FIND FIRST brstat.insure                        WHERE
                           brstat.insure.compno = "999"         AND
                           brstat.insure.Fname  = wexcel.provin NO-LOCK NO-ERROR.
                IF AVAIL brstat.insure THEN DO:
                    wexcel.provin = brstat.insure.Lname.
                END.
                ELSE wexcel.provin = "กท".
            END.
            ELSE wexcel.provin = "กท".
        END.
    
        nv_vehreg = wexcel.vehreg.

        IF  SUBSTR(wexcel.vehreg,1,1) <> "/" THEN DO:
            IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
                IF SUBSTR(wexcel.vehreg,2,1) >= "1" AND SUBSTR(wexcel.vehreg,2,1) <= "9" THEN DO:
                    wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
                END.
                ELSE wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)) + " " + wexcel.provin.
            END.
            ELSE DO:
                wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
            END.
        END.
        ELSE wexcel.vehreg = wexcel.vehreg.
    END.
    ELSE DO:
        IF LENGTH(wexcel.cha_no) >= 9 THEN wexcel.vehreg = "/" + SUBSTR(wexcel.cha_no,(LENGTH(wexcel.cha_no) - 9) + 1,9).
        ELSE wexcel.vehreg = "/" + wexcel.cha_no.
    END.

    IF wexcel.cr_2 = "" THEN DO: 
        wexcel.cr_2   = wexcel.policy.
        wexcel.policy = "".
    END.

    nv_comdat = ?.
    nv_expdat = ?.

    nv_comdat = DATE(wexcel.comdat).
    nv_expdat = DATE(wexcel.expdat).

    wexcel.rec_status = "Y".
    RUN Proc_ReChkGen70.

    IF wexcel.rec_status = "Y" THEN DO:
        CREATE wgenerage.
        ASSIGN
            wgenerage.seqno1       = wexcel.seqno1
            wgenerage.policy       = wexcel.policy    /*Old Policy*/
            wgenerage.cr_2         = wexcel.cr_2      /*New Policy*/
            wgenerage.poltyp       = "V70"
            wgenerage.comdat       = DATE(wexcel.comdat)
            wgenerage.expdat       = DATE(wexcel.expdat)
            wgenerage.insref       = wexcel.insref
            wgenerage.tiname       = wexcel.tiname
            wgenerage.name1        = wexcel.name1
            wgenerage.addr1        = wexcel.addr1
            wgenerage.addr2        = wexcel.addr2
            wgenerage.addr3        = wexcel.addr3
            wgenerage.addr4        = wexcel.addr4
            wgenerage.icno         = wexcel.icno
            wgenerage.vehreg       = wexcel.vehreg
            wgenerage.yrmanuf      = wexcel.yrmanuf
            wgenerage.makdes       = wexcel.makdes
            wgenerage.moddes       = wexcel.moddes
            wgenerage.engine       = wexcel.engine
            wgenerage.body         = wexcel.body
            wgenerage.text7        = wexcel.access
            wgenerage.engno        = wexcel.engno
            wgenerage.cha_no       = wexcel.cha_no
            wgenerage.finance      = wexcel.finance
            wgenerage.dealer       = wexcel.dealer
            wgenerage.CLASS        = wexcel.CLASS
            wgenerage.text5        = wexcel.text5
            wgenerage.si           = wexcel.si
            wgenerage.bip          = wexcel.bip
            wgenerage.bia          = wexcel.bia
            wgenerage.pda          = wexcel.pda
            wgenerage.m411         = wexcel.m411
            wgenerage.m412         = wexcel.m412
            wgenerage.m42          = wexcel.m42
            wgenerage.m43          = wexcel.m43
            wgenerage.prem         = wexcel.prem70
            wgenerage.prem_t       = wexcel.premtot70
            wgenerage.covcod       = wexcel.covcod
            wgenerage.vehusg       = wexcel.vehusg
            wgenerage.ncb          = DECI(wexcel.ncb)
            wgenerage.fleet        = DECI(wexcel.fleet)
            wgenerage.baseprm      = DECI(wexcel.baseprm)
            wgenerage.seats        = wexcel.seats
            wgenerage.campaign_ov = trim(wexcel.campaign_ov)    /*Add by Kridtiya i. A63-0472*/ 
            .

    END.

END.

FIND FIRST wgenerage NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL wgenerage THEN DO:
    MESSAGE " Not Found Data For Generage " VIEW-AS ALERT-BOX.
END.

sh_policy  = "".
nv_line    = 0.

OUTPUT STREAM nnotdata  TO  VALUE(nv_notdata).

FOR EACH wgenerage NO-LOCK:
 
    IF wgenerage.policy <> "" THEN RUN Proc_ReCheck72.  /*ใช้ Loop งานต่ออายุแบบเดียวกับ 72*/
    ELSE DO: 

        IF LENGTH(wgenerage.CLASS) = 3 THEN 
            wgenerage.CLASS = fi_package + wgenerage.CLASS.

        ASSIGN
            wgenerage.policy  = wgenerage.cr_2
            wgenerage.cr_2    = ""
            wgenerage.accdat  = nv_comdat.

        IF wgenerage.insref = "" THEN DO:
            FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                       sicsyac.xmm600.acno = "0C56114" NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm600 THEN DO:
                ASSIGN
                    wgenerage.insref = sicsyac.xmm600.acno
                    wgenerage.tiname = sicsyac.xmm600.ntitle
                    wgenerage.name1  = sicsyac.xmm600.NAME  
                    wgenerage.addr1  = sicsyac.xmm600.addr1 
                    wgenerage.addr2  = sicsyac.xmm600.addr2 
                    wgenerage.addr3  = sicsyac.xmm600.addr3 
                    wgenerage.addr4  = sicsyac.xmm600.addr4
                    wgenerage.icno   = sicsyac.xmm600.icno 
                    /*Add by Kridtiya i. A63-0472*/
                    wgenerage.insnamtyp   = TRIM(sicsyac.xmm600.acno_typ)  
                    wgenerage.firstName   = TRIM(sicsyac.xmm600.firstname) 
                    wgenerage.lastName    = TRIM(sicsyac.xmm600.lastName)  
                    wgenerage.postcd      = TRIM(sicsyac.xmm600.postcd)    
                    wgenerage.codeocc     = TRIM(sicsyac.xmm600.codeocc)   
                    wgenerage.codeaddr1   = TRIM(sicsyac.xmm600.codeaddr1) 
                    wgenerage.codeaddr2   = TRIM(sicsyac.xmm600.codeaddr2) 
                    wgenerage.codeaddr3   = TRIM(sicsyac.xmm600.codeaddr3) 
                    wgenerage.br_insured  = TRIM(sicsyac.xmm600.anlyc5) .
                    /*Add by Kridtiya i. A63-0472*/  
            END.
        END.
        ELSE DO:
            FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001      WHERE
                       sicsyac.xmm600.acno = wgenerage.insref NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm600 THEN DO:
                ASSIGN
                    wgenerage.insref = sicsyac.xmm600.acno
                    wgenerage.tiname = sicsyac.xmm600.ntitle
                    wgenerage.name1  = sicsyac.xmm600.NAME  
                    wgenerage.addr1  = sicsyac.xmm600.addr1 
                    wgenerage.addr2  = sicsyac.xmm600.addr2 
                    wgenerage.addr3  = sicsyac.xmm600.addr3 
                    wgenerage.addr4  = sicsyac.xmm600.addr4
                    wgenerage.icno   = sicsyac.xmm600.icno 
                    /*Add by Kridtiya i. A63-0472*/
                    wgenerage.insnamtyp   = TRIM(sicsyac.xmm600.acno_typ)  
                    wgenerage.firstName   = TRIM(sicsyac.xmm600.firstname) 
                    wgenerage.lastName    = TRIM(sicsyac.xmm600.lastName)  
                    wgenerage.postcd      = TRIM(sicsyac.xmm600.postcd)    
                    wgenerage.codeocc     = TRIM(sicsyac.xmm600.codeocc)   
                    wgenerage.codeaddr1   = TRIM(sicsyac.xmm600.codeaddr1) 
                    wgenerage.codeaddr2   = TRIM(sicsyac.xmm600.codeaddr2) 
                    wgenerage.codeaddr3   = TRIM(sicsyac.xmm600.codeaddr3) 
                    wgenerage.br_insured  = TRIM(sicsyac.xmm600.anlyc5) .
                    /*Add by Kridtiya i. A63-0472*/  
            END.
        END.

        RUN Proc_70Check.

    END.

    ASSIGN
        nv_reccnt   = nv_reccnt + 1 /*note add on 23/05/2007*/
        nv_netprm_t = nv_netprm_t + wgenerage.prem.
END.

OUTPUT STREAM nnotdata  CLOSE.

IF CONNECTED("SIC_EXP") THEN DISCONNECT sic_exp.

/***--- Disp Browse ---***/
OPEN QUERY BROWSE-4 FOR EACH wgenerage. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ReGen72 C-Win 
PROCEDURE Proc_ReGen72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add A57-0228      
------------------------------------------------------------------------------*/
fi_display = "Please wait... Generate data...".
DISPLAY fi_display WITH FRAME fr_main.

FOR EACH wexcel :
    DELETE wexcel.
END.

FOR EACH wgenerage:
    DELETE wgenerage.
END.

INPUT FROM VALUE(fi_filename) NO-ECHO.
REPEAT:
    CREATE wexcel.
    IMPORT DELIMITER "|"
        wexcel.seqno1
        wexcel.policy
        wexcel.vehreg
        wexcel.makdes
        wexcel.moddes
        wexcel.engine
        wexcel.body
        wexcel.engno
        wexcel.cha_no
        wexcel.seats      /*Add A57-0228-01*/
        wexcel.CLASS      /*Add A57-0228-01*/
        wexcel.orderno
        wexcel.comdat
        wexcel.expdat
        wexcel.provin
        wexcel.color1
        .
/*---
    MESSAGE "wexcel.seqno1 =  " wexcel.seqno1 
            "wexcel.policy =  " wexcel.policy
            "wexcel.vehreg =  " wexcel.vehreg 
            "wexcel.makdes =  " wexcel.makdes 
            "wexcel.moddes =  " wexcel.moddes 
            "wexcel.engine =  " wexcel.engine 
            "wexcel.body   =  " wexcel.body   
            "wexcel.engno  =  " wexcel.engno  
            "wexcel.cha_no =  " wexcel.cha_no 
            "wexcel.oderno =  " wexcel.orderno 
            "wexcel.comdat =  " wexcel.comdat 
            "wexcel.expdat =  " wexcel.expdat 
            "wexcel.provin =  " wexcel.provin  VIEW-AS ALERT-BOX.
---*/            

END.  /*REPEAT*/

/*--- ยกเลิกการ Running Policy จาก Parameter ---
IF ra_type = 3 THEN DO:
    FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
               stat.polno_fil.dir_ri    = YES                              AND
               stat.polno_fil.poltyp    = "V70"                            AND
               stat.polno_fil.branch    = "0WC"                            AND
               stat.polno_fil.undyr     = STRING(YEAR(TODAY) + 543,"9999") AND
               stat.polno_fil.start_no  = "WC"                             NO-LOCK NO-ERROR.
    IF AVAIL stat.polno_fil THEN DO:
        nv_pol70 = stat.polno_fil.nextno - 1.
    END.
    ELSE DO:
        FIND LAST stat.polno_fil USE-INDEX polno01 WHERE
                  stat.polno_fil.dir_ri   = YES    AND
                  stat.polno_fil.poltyp   = "V70"  AND
                  stat.polno_fil.branch   = "0WC"                                  
        NO-LOCK NO-ERROR.
        IF AVAIL stat.polno_fil THEN DO:
            nv_pol70 = stat.polno_fil.nextno - 1.
        END.
    END.
END.

IF ra_type = 4 THEN DO:
    FIND FIRST stat.polno_fil USE-INDEX polno01 WHERE
               stat.polno_fil.dir_ri    = YES                              AND
               stat.polno_fil.poltyp    = "V72"                            AND
               stat.polno_fil.branch    = "0WC"                            AND
               stat.polno_fil.undyr     = STRING(YEAR(TODAY) + 543,"9999") AND
               stat.polno_fil.start_no  = "WC"                             NO-LOCK NO-ERROR.
    IF AVAIL stat.polno_fil THEN DO:
        nv_pol70 = stat.polno_fil.nextno - 1.
    END.
    ELSE DO:
        FIND LAST stat.polno_fil USE-INDEX polno01 WHERE
                  stat.polno_fil.dir_ri   = YES    AND
                  stat.polno_fil.poltyp   = "V72"  AND
                  stat.polno_fil.branch   = "0WC"                                  
        NO-LOCK NO-ERROR.
        IF AVAIL stat.polno_fil THEN DO:
            nv_pol70 = stat.polno_fil.nextno - 1.
        END.
    END.
END. ----*/

FOR EACH wexcel NO-LOCK:

    IF wexcel.seqno1 = "" THEN NEXT.
    IF wexcel.vehreg = "" THEN NEXT.

    /*-- เลขที่สัญญา --*//*--- ยกเลิกการ Running Policy ตาม Parameter ---
    IF wexcel.cr_2 = "" THEN DO:

        nv_pol2       = SUBSTR(STRING(YEAR(TODAY) + 543,"9999"),3,2) + "WC" + STRING(nv_pol70 + 1,"9999").
        
        IF ra_type = 3 THEN wexcel.cr_2 = "MC70" + nv_pol2.
        ELSE IF ra_type = 4 THEN wexcel.cr_2 = "MC72" + nv_pol2.

        nv_pol70      = nv_pol70 + 1.

    END.----*/

    /*--- หาทะเบียนรถ ---*/
    IF wexcel.vehreg <> "" THEN DO:
        IF wexcel.provin = "" THEN wexcel.provin = "กท".
        ELSE DO:
            IF LENGTH(wexcel.provin) > 2 THEN DO:
                FIND FIRST brstat.insure                        WHERE
                           brstat.insure.compno = "999"         AND
                           brstat.insure.Fname  = wexcel.provin NO-LOCK NO-ERROR.
                IF AVAIL brstat.insure THEN DO:
                    wexcel.provin = brstat.insure.Lname.
                END.
                ELSE wexcel.provin = "กท".
            END.
            ELSE wexcel.provin = "กท".
        END.
    
        nv_vehreg = wexcel.vehreg.

        IF  SUBSTR(wexcel.vehreg,1,1) <> "/" THEN DO:
            IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
                IF SUBSTR(wexcel.vehreg,2,1) >= "1" AND SUBSTR(wexcel.vehreg,2,1) <= "9" THEN DO:
                    wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
                END.
                ELSE wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)) + " " + wexcel.provin.
            END.
            ELSE DO:
                wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
            END.
        END.
        ELSE wexcel.vehreg = wexcel.vehreg.
    END.
    ELSE DO:
        IF LENGTH(wexcel.cha_no) >= 9 THEN wexcel.vehreg = "/" + SUBSTR(wexcel.cha_no,(LENGTH(wexcel.cha_no) - 9) + 1,9).
        ELSE wexcel.vehreg = "/" + wexcel.cha_no.
    END.

    /*----
    /*-- เลขทะเบียนรถ --*/
    IF wexcel.provin = "" THEN wexcel.provin = "กท".
    ELSE DO:
        IF LENGTH(wexcel.provin) > 2 THEN DO:
            FIND FIRST brstat.insure                        WHERE
                       brstat.insure.compno = "999"         AND
                       brstat.insure.Fname  = wexcel.provin NO-LOCK NO-ERROR.
            IF AVAIL brstat.insure THEN DO:
                wexcel.provin = brstat.insure.Lname.
            END.
            ELSE wexcel.provin = "กท".
        END.
        ELSE wexcel.provin = "กท".
    END.

    nv_vehreg = wexcel.vehreg.
    IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
        IF SUBSTR(wexcel.vehreg,2,1) >= "1" AND SUBSTR(wexcel.vehreg,2,1) <= "9" THEN DO:
            wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
        END.
        ELSE wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)) + " " + wexcel.provin.
    END.
    ELSE DO:
        wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
    END.
    ----*/

    /*---
    nv_vehreg = wexcel.vehreg.
    IF SUBSTR(wexcel.vehreg,1,1) >= "1" AND SUBSTR(wexcel.vehreg,1,1) <= "9"  THEN DO:
        IF wexcel.provin = "" THEN wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)) + " " + "กท".
        ELSE wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,3)) + " " + TRIM(SUBSTR(nv_vehreg,4,5)) + " " + wexcel.provin.
    END.
    ELSE DO:
        IF wexcel.provin = "" THEN wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + "กท".
        ELSE wexcel.vehreg = TRIM(SUBSTR(nv_vehreg,1,2)) + " " + TRIM(SUBSTR(nv_vehreg,3,5)) + " " + wexcel.provin.
    END.
    ---*/

    IF wexcel.cr_2 = "" THEN DO: 
        wexcel.cr_2   = wexcel.policy.
        wexcel.policy = "".
    END.

    nv_comdat = ?.
    nv_expdat = ?.

    nv_comdat = DATE(wexcel.comdat).
    nv_expdat = DATE(wexcel.expdat).

    wexcel.rec_status = "Y".
    RUN Proc_ReChkGen72.

    IF wexcel.rec_status = "Y" THEN DO:
        CREATE wgenerage.
        ASSIGN
            wgenerage.seqno1      = wexcel.seqno1
            wgenerage.policy      = wexcel.policy     /*เก็บค่า Policy เดิม*/
            wgenerage.cr_2        = wexcel.cr_2       /*เก็บ Policy ที่ต่ออายุใหม่*/
            wgenerage.poltyp      = "V72"             /*"V" + SUBSTR(wexcel.policy,3,2)*/
            wgenerage.vehreg      = wexcel.vehreg
            wgenerage.makdes      = wexcel.makdes
            wgenerage.moddes      = wexcel.moddes
            wgenerage.engine      = wexcel.engine
            wgenerage.body        = wexcel.body
            wgenerage.engno       = wexcel.engno
            wgenerage.cha_no      = wexcel.cha_no
            wgenerage.seats       = wexcel.seats      /*Add A57-0228-01*/
            wgenerage.CLASS       = wexcel.CLASS     /*Add A57-0228-01*/
            wgenerage.orderno     = wexcel.orderno
            wgenerage.comdat      = DATE(wexcel.comdat)
            wgenerage.expdat      = DATE(wexcel.expdat)
            wgenerage.color1      = wexcel.color1
            wgenerage.rec_status  = "Y"                          
            wgenerage.rec_comment = " "
            wgenerage.campaign_ov = trim(wexcel.campaign_ov)  /*Add by Kridtiya i. A63-0472*/ 
            .
    END.

END. /*FOR EACH wexcel*/

FIND FIRST wgenerage NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL wgenerage THEN DO:
    MESSAGE " Not Found Data For Generage " VIEW-AS ALERT-BOX.
END.

sh_policy  = "".
nv_line    = 0.

OUTPUT STREAM nnotdata  TO  VALUE(nv_notdata).

FOR EACH wgenerage NO-LOCK:
    
    IF wgenerage.policy <> "" THEN RUN Proc_ReCheck72.
    ELSE DO: 

        ASSIGN
            wgenerage.policy  = wgenerage.cr_2
            wgenerage.cr_2    = ""
            wgenerage.accdat  = nv_comdat
            wgenerage.yrmanuf = INTE(SUBSTR(wgenerage.orderno,7,4))
            wgenerage.vehusg  = fi_vehuse.

        IF wgenerage.CLASS = "" THEN DO:
                 IF wgenerage.body = "PICKUP" THEN wgenerage.CLASS = "240A".
            ELSE IF wgenerage.body = "VAN"    OR
                    wgenerage.body = "12SEAT" OR
                    wgenerage.body = "11SEAT" THEN wgenerage.CLASS = "220A".
            ELSE wgenerage.CLASS = "210".
        END.

        RUN Proc_ChkPrem72.  /*Add A57-0228-01*/

        IF wgenerage.prem_t = 0 THEN DO:
            IF wgenerage.CLASS = "210" THEN wgenerage.prem_t = 1900.
            ELSE IF wgenerage.CLASS = "220A" THEN wgenerage.prem_t = 2320.
            ELSE IF wgenerage.CLASS = "240A" THEN wgenerage.prem_t = 1760.
        END.

        IF wgenerage.name1 = "" THEN DO:
            FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                       sicsyac.xmm600.acno = "0C56114" NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm600 THEN DO:
                ASSIGN
                    wgenerage.insref = sicsyac.xmm600.acno
                    wgenerage.tiname = sicsyac.xmm600.ntitle
                    wgenerage.name1  = sicsyac.xmm600.NAME  
                    wgenerage.addr1  = sicsyac.xmm600.addr1 
                    wgenerage.addr2  = sicsyac.xmm600.addr2 
                    wgenerage.addr3  = sicsyac.xmm600.addr3 
                    wgenerage.addr4  = sicsyac.xmm600.addr4
                    wgenerage.icno   = sicsyac.xmm600.icno
                    /*Add by Kridtiya i. A63-0472*/
                    wgenerage.insnamtyp   = TRIM(sicsyac.xmm600.acno_typ)   
                    wgenerage.firstName   = TRIM(sicsyac.xmm600.firstname)  
                    wgenerage.lastName    = TRIM(sicsyac.xmm600.lastName)   
                    wgenerage.postcd      = trim(sicsyac.xmm600.postcd)     
                    wgenerage.codeocc     = trim(sicsyac.xmm600.codeocc)    
                    wgenerage.codeaddr1   = TRIM(sicsyac.xmm600.codeaddr1)  
                    wgenerage.codeaddr2   = TRIM(sicsyac.xmm600.codeaddr2)  
                    wgenerage.codeaddr3   = trim(sicsyac.xmm600.codeaddr3)  
                    /*wgenerage.br_insured  = trim(sicsyac.xmm600.anlyc5)*/   . 
                    /*Add by Kridtiya i. A63-0472*/  
            END.
        END.

        IF INDEX(wgenerage.engine,".") <> 0 THEN DO:
            nv_count         = INDEX(wgenerage.engine,".").
            wgenerage.engine = SUBSTR(wgenerage.engine,1,(nv_count - 1)).
        END.

        RUN Proc_72Check.
    END.

    ASSIGN
        nv_reccnt   = nv_reccnt + 1 /*note add on 23/05/2007*/
        nv_netprm_t = nv_netprm_t + wgenerage.prem.
END.

OUTPUT STREAM nnotdata  CLOSE.

IF CONNECTED("SIC_EXP") THEN DISCONNECT sic_exp.

/***--- Disp Browse ---***/
OPEN QUERY BROWSE-4 FOR EACH wgenerage. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Reports C-Win 
PROCEDURE Proc_Reports :
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

FOR EACH wexcel WHERE wexcel.rec_status = "N" NO-LOCK:
    NOT_pass = NOT_pass + 1.
END.

FOR EACH wgenerage NO-LOCK:
    IF wgenerage.rec_status = "N" THEN NOT_pass = NOT_pass + 1.
    ELSE pass = pass + 1.
END.

IF pass > 0 THEN DO:
    OUTPUT STREAM ns1 TO VALUE(fi_output1).
    PUT STREAM ns1
        "Policy"       ","
        "Chassis"      "," 
        "Vehicle Reg." ","
        "Comment"
    SKIP.

    FOR EACH wgenerage WHERE wgenerage.rec_status = "Y" NO-LOCK:
        PUT STREAM ns1
            wgenerage.policy  FORMAT "X(12)"  ","
            wgenerage.cha_no  FORMAT "X(30)"  ","
            wgenerage.vehreg  FORMAT "X(12)"  ","
            wgenerage.rec_comment
        SKIP.
    END.

    OUTPUT STREAM ns1 CLOSE. 

END.

IF NOT_pass > 0 THEN DO:

    OUTPUT STREAM ns2 TO VALUE(fi_output2).
    PUT STREAM ns2
        "Policy"       ","
        "Chassis"      "," 
        "Vehicle Reg." ","
        "Comment"
    SKIP.

    FOR EACH wexcel WHERE wexcel.rec_status = "N" NO-LOCK:
        PUT STREAM ns2
            wexcel.policy  FORMAT "X(12)"   ","
            wexcel.cha_no  FORMAT "X(30)"   ","
            wexcel.vehreg  FORMAT "X(12)"   ","
            wexcel.rec_comment
        SKIP.
    END.

    FOR EACH wgenerage WHERE wgenerage.rec_status = "N" NO-LOCK:
        PUT STREAM ns2
            wgenerage.policy  FORMAT "X(12)"   ","
            wgenerage.cha_no  FORMAT "X(30)"   ","
            wgenerage.vehreg  FORMAT "X(12)"   ","
            wgenerage.rec_comment
        SKIP.
    END.

    OUTPUT STREAM ns2 CLOSE. 
END.
              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen C-Win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
" LOAD TEXT FILE COMPULSORY (V72,V73,V74) " SKIP
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
    nn_vehreglist  = trim(wgenerage.vehreg)
    nv_chanolist   = trim(wgenerage.cha_no)  
    nv_idnolist    = trim(wgenerage.icno) .

IF R-INDEX(wgenerage.name1," ") <> 0 THEN  
    ASSIGN
    nn_namelist    = trim(SUBSTR(wgenerage.name1,1,R-INDEX(wgenerage.name1," ")))
    nn_namelist2   = trim(SUBSTR(wgenerage.name1,R-INDEX(wgenerage.name1," "))).
ELSE ASSIGN
    nn_namelist    = TRIM(wgenerage.name1) 
    nn_namelist2   = "".


IF wgenerage.vehreg <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wexcel.rec_comment = wexcel.rec_comment + "| รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wexcel.rec_status  = "N"   .                               
    END.    
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wexcel.rec_comment = wexcel.rec_comment + "| ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wexcel.rec_status  = "N"   .                    
            
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wexcel.rec_comment = wexcel.rec_comment + "| ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wexcel.rec_status  = "N"   .                    
                
        END.
    END.
END.

IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wexcel.rec_comment = wexcel.rec_comment + "| รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wexcel.rec_status  = "N"   .                    
            
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:

    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wexcel.rec_comment = wexcel.rec_comment + "| IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wexcel.rec_status  = "N"   .                    
            
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
                wexcel.rec_comment = wexcel.rec_comment + "| IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wexcel.rec_status  = "N"   .                    
                
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Temp1 C-Win 
PROCEDURE Proc_Temp1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---
    IF nv_delimiter = YES THEN DO:
      /* ------ ทำการตัด , ตัวสุดท้ายออก ---------------- */
      FOR EACH wdelimi:
        DELETE wdelimi.
      END.

      INPUT  STREAM nfile FROM VALUE(fi_filename). 
      OUTPUT STREAM outputdata TO C:\TESTCOMP.TXT.

      nv_daily = "".
      nv_chr   = "".

      loop_source:
      DO WHILE LASTKEY <> -2:
        READKEY STREAM nfile.
        nv_chr = chr(LASTKEY).
        
        IF LASTKEY = 12 THEN DO:           /* PAGE */
           nv_daily = "".
           NEXT loop_source.
        END.

        IF LASTKEY = 13 THEN DO:
          nv_daily = REPLACE(nv_daily , "  ", " ").
          nv_daily = REPLACE(nv_daily , "  ", " ").
          /* ----- */
          ASSIGN
          nv_text1 = ""
          nv_text2 = ""
          nv_text3 = ""
          nv_text4 = ""
          nv_text5 = ""
          nv_text6 = "".

          nv_text1 = SUBSTR(nv_daily,1  ,100).
          nv_text2 = SUBSTR(nv_daily,101,100).
          nv_text3 = SUBSTR(nv_daily,201,100).
          nv_text4 = SUBSTR(nv_daily,301,100).
          nv_text5 = SUBSTR(nv_daily,401,100).
          nv_text6 = SUBSTR(nv_daily,501,100).

          IF TRIM(nv_text6) <> "" THEN DO:

            IF SUBSTR(nv_text6, LENGTH(TRIM(nv_text6)), 1) = "," THEN
              nv_text6 = SUBSTR(nv_text6, 1, LENGTH(TRIM(nv_text6)) - 1 ).

            PUT STREAM outputdata
              nv_text1
              nv_text2
              nv_text3
              nv_text4
              nv_text5
              nv_text6 
            SKIP.
          END.
          ELSE DO:
            IF TRIM(nv_text5) <> "" THEN DO:

              IF SUBSTR(nv_text5, LENGTH(TRIM(nv_text5)), 1) = "," THEN
                nv_text5 = SUBSTR(nv_text5, 1, LENGTH(TRIM(nv_text5)) - 1 ).

              PUT STREAM outputdata
                nv_text1
                nv_text2
                nv_text3
                nv_text4
                nv_text5
              SKIP.
            END.
            ELSE DO:
              IF TRIM(nv_text4) <> "" THEN DO:

                IF SUBSTR(nv_text4, LENGTH(TRIM(nv_text4)), 1) = "," THEN
                  nv_text4 = SUBSTR(nv_text4, 1, LENGTH(TRIM(nv_text4)) - 1 ).

                PUT STREAM outputdata
                  nv_text1
                  nv_text2
                  nv_text3
                  nv_text4
                SKIP.
              END.
              ELSE DO:
                IF TRIM(nv_text3) <> "" THEN DO:

                  IF SUBSTR(nv_text3, LENGTH(TRIM(nv_text3)), 1) = "," THEN
                    nv_text3 = SUBSTR(nv_text3, 1, LENGTH(TRIM(nv_text3)) - 1 ).

                  PUT STREAM outputdata
                  nv_text1
                  nv_text2
                  nv_text3
                  SKIP.
                END.
                ELSE DO:
                  IF TRIM(nv_text2) <> "" THEN DO:

                    IF SUBSTR(nv_text2, LENGTH(TRIM(nv_text2)), 1) = "," THEN
                      nv_text2 = SUBSTR(nv_text2, 1, LENGTH(TRIM(nv_text2)) - 1 ).

                    PUT STREAM outputdata
                      nv_text1
                      nv_text2
                    SKIP.
                  END.
                  ELSE DO:
                    IF TRIM(nv_text1) <> "" THEN DO:

                      IF SUBSTR(nv_text1, LENGTH(TRIM(nv_text1)), 1) = "," THEN
                        nv_text1 = SUBSTR(nv_text1, 1, LENGTH(TRIM(nv_text1)) - 1 ).

                      PUT STREAM outputdata
                        nv_text1
                      SKIP.
                    END.
                  END.
                END.
              END.
            END.
          END.

          nv_daily = "".
          NEXT loop_source.
        END.                                    /* IF LASTKEY = 13 THEN DO: */
        nv_daily = nv_daily + nv_chr.
      END.                                      /* DO WHILE LASTKEY <> -2: */

      OUTPUT STREAM outputdata CLOSE.
      INPUT  STREAM nfile CLOSE.

      PAUSE 1 NO-MESSAGE.

      /* ------ สิ้นสุด ทำการตัด , ตัวสุดท้ายออก ---------------- */


      /* ----- */
      HIDE MESSAGE NO-PAUSE.

      INPUT STREAM nfile FROM C:\TESTCOMP.TXT.
      
      REPEAT :
          MESSAGE wexcel.policy VIEW-AS ALERT-BOX.
        CREATE wexcel.
        IMPORT STREAM nfile DELIMITER "," wexcel.
      END.

      INPUT STREAM nfile CLOSE.
      FOR EACH wexcel NO-LOCK:
      
        IF SUBSTR(wexcel.policy,1,1) <> "D" THEN NEXT.
        IF wexcel.name1               = ""  THEN NEXT.
        IF wexcel.prem                = ""  THEN NEXT.

        sh_policy  = "".
        sh_policy2 = "".
        sh_policy  = REPLACE(wexcel.policy,"-","").
        sh_policy2 = REPLACE(sh_policy    ,"/","").
        sh_policy2 = REPLACE(sh_policy2   ,"\","").
        sh_policy2 = REPLACE(sh_policy2   ,".","").
        sh_policy2 = REPLACE(sh_policy2   ,".","").
        sh_policy2 = REPLACE(sh_policy2   ,".","").
        sh_policy  = sh_policy2.

        ASSIGN
          nv_name  = ""
          nv_addr1 = ""
          nv_addr2 = ""
          nv_addr3 = ""
          nv_addr4 = "".

        nv_name   = wexcel.name1.
        nv_name   = REPLACE(TRIM(nv_name), "  ", " ").
        nv_name   = REPLACE(TRIM(nv_name), "  ", " ").
        nv_name   = REPLACE(TRIM(nv_name), "  ", " ").
        nv_name   = REPLACE(TRIM(nv_name), "  ", " ").

        nv_addr1  = SUBSTR(wexcel.addr1,  1,35).
        nv_addr2  = SUBSTR(wexcel.addr1, 36,35).
        nv_addr3  = SUBSTR(wexcel.addr1, 71,35).
        nv_addr4  = SUBSTR(wexcel.addr1,106,20).

        nv_comdat = ?.
        nv_expdat = ?.

                  /* 09/17/03
                     12345678 */

        nv_comdat = 
                    DATE(INT(SUBSTR(wexcel.comdat,1,2)) ,
                         INT(SUBSTR(wexcel.comdat,4,2)) ,
                         INT("20" + SUBSTR(wexcel.comdat,9,2))     /*note modi*/
                        ).
        nv_expdat =
                    DATE(INT(SUBSTR(wexcel.expdat,1,2)) ,
                         INT(SUBSTR(wexcel.expdat,4,2)) ,
                         INT("20" + SUBSTR(wexcel.expdat,9,2))     /*note modi*/
                        ).


        CREATE wgenerage.

        ASSIGN
        wgenerage.policy  = sh_policy
        wgenerage.name1   = nv_name                           /*2  Name1*/
        wgenerage.addr1   = nv_addr1                          /*3  Address 1*/
        wgenerage.addr2   = nv_addr2                          /*4  Address 2*/
        wgenerage.addr3   = nv_addr3                          /*5  Address 3*/
        wgenerage.addr4   = nv_addr4                          /*6  Address 4*/
        wgenerage.comdat  = nv_comdat
        wgenerage.expdat  = nv_expdat                         /*8  วันที่สิ้นสุด*/
        wgenerage.accdat  = nv_comdat                         /*9  วันที่ใบกำกับภาษี*/
        /* ---- */
        wgenerage.class   = wexcel.class                      /*1  Class */
        /* ---- */
        wgenerage.makdes  = wexcel.makdes                     /*10 ยี่ห้อรถ*/
        wgenerage.vehreg  = wexcel.vehreg                     /*11 ทะเบียนรถ*/
        wgenerage.cha_no  = wexcel.cha_no                     /*12 เลขที่ตัวรถ*/
        wgenerage.body    = wexcel.body                       /*13 ชนิดของตัวรถ*/
        wgenerage.engine  = wexcel.engine                     /*14 จำนวน CC.*/
        wgenerage.vehusg  = "1"                               /*15 ลักษณะการใช้รถ(1=รถส่วนบุคคล 2=รับจ้าง/ให้เช่า */
        wgenerage.sticker = wexcel.sticker                    /*16 Sticker no.*/
        wgenerage.prem    = DECIMAL(wexcel.prem)              /*17 เบี้ยประกันสุทธิ*/
        wgenerage.stamp   = DECIMAL(wexcel.stamp)             /*18 Stamp*/
        wgenerage.tax     = DECIMAL(wexcel.tax)               /*19 VAT*/
        /***--- Assign No. A50-0130---***/
        /***--- Note Add on 14/05/2007 ---***/
        wgenerage.rec_status  = "Y"                            /*20 Record Status ให้มีค่าเป็น Y ไว้ก่อน ---*/
        wgenerage.rec_comment = " " .                          /*21 Record Comment*/

        IF INDEX(wgenerage.engine,".") <> 0 THEN DO:        /*14 จำนวน CC.*/
          nv_count = INDEX(wgenerage.engine,".").
          wgenerage.engine = SUBSTR(wgenerage.engine,1,(nv_count - 1)).
        END.

      END.
    END.     /*nv_delimiter = Yes*/
    
    /***--- Check ว่ามีงานที่จะนำเข้าหรือไม่ ---***/
    FIND FIRST wgenerage NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE wgenerage THEN DO:
      MESSAGE " Not found data For Generate" VIEW-AS ALERT-BOX.
    END.

    sh_policy  = "".
    nv_line    = 0.

    OUTPUT STREAM ndata     TO  VALUE(nv_data).
    OUTPUT STREAM nnotdata  TO  VALUE(nv_notdata).

    RUN proc_check1.
    
    /***--- Disp Browse ---***/
    OPEN QUERY BROWSE-4 FOR EACH wgenerage . 
---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 C-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
DEF VAR nv_text5     AS CHAR.

n_rencnt = 0.
n_endcnt = 0.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
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

    /*nv_txt2  = wgenerage.text5   /*Accessories*/
    nv_txt3  = ""
    nv_txt4  = ""   
    nv_txt5  = ""                              
    nv_txt6  = ""
    nv_txt7  = "". */
/*---
     IF fi_mn30 = "Y" THEN nv_txt1 = "NO-MN30 คุ้มครองภัยก่อการร้าย".
ELSE IF fi_mn30 = "N" THEN nv_txt1 = "คุ้มครองการสูญหายโดยผู้เช่า".
--*/

IF INDEX(wgenerage.text5,"/") <> 0 THEN DO:
    nv_text5 = wgenerage.text5.
    nv_txt1  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt2  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt3  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt4  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt5  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt6  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt7  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt8  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt9  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt10  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt11  = SUBSTR(wgenerage.text5,1,INDEX(wgenerage.text5,"/") - 1).
    IF INDEX(wgenerage.text5,"/") <> 0 THEN 
        wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).
    ELSE wgenerage.text5 = "".
    
    nv_txt12  = wgenerage.text5.
    /*wgenerage.text5 = SUBSTR(wgenerage.text5,(INDEX(wgenerage.text5,"/") + 1),LENGTH(wgenerage.text5) - (INDEX(wgenerage.text5,"/"))).*/
END.
ELSE nv_txt1 = wgenerage.text5.


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
     sic_bran.uwm100.policy  = wgenerage.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt          AND
     sic_bran.uwm100.endcnt  = n_endcnt          AND
     sic_bran.uwm100.bchyr   = nv_batchyr        AND
     sic_bran.uwm100.bchno   = nv_batchno        AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
 NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd100.
        ASSIGN
            sic_bran.uwd100.bptr    = nv_bptr
            sic_bran.uwd100.fptr    = 0
            sic_bran.uwd100.policy  = wgenerage.policy
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_uwd102 C-Win 
PROCEDURE Proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF VAR nv_bptr      AS RECID.

n_rencnt = 0.
n_endcnt = 0.

FOR EACH wuppertxt.
    DELETE wuppertxt.
END.

ASSIGN 
    nv_bptr   = 0
    nv_line1  = 1
    nv_txt1   = ""  
    nv_txt2   = ""
    nv_txt3   = ""  
    nv_txt4   = ""
    nv_txt5   = ""  
    nv_txt6   = ""
    nv_txt7   = ""
    nv_txt8   = ""
    nv_txt9   = ""
    nv_txt10  = ""
    nv_txt11  = ""
    nv_txt12  = "".

nv_txt2  = wgenerage.text7.

    /*nv_txt1  = ""
    nv_txt2  = wgenerage.text7
    nv_txt3  = ""
    nv_txt4  = ""   
    nv_txt5  = ""                              
    nv_txt6  = ""
    nv_txt7  = "". */

/*--- เปิด LOOOP กรณีมีมากกว่า 1 บรรทัด ---
IF INDEX(wgenerage.text7,"/") <> 0 THEN DO:
    nv_txt1  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt2  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt3  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt4  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt5  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt6  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt7  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt8  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt9  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt10  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt11  = SUBSTR(wgenerage.text7,1,INDEX(wgenerage.text7,"/") - 1).
    IF INDEX(wgenerage.text7,"/") <> 0 THEN 
        wgenerage.text7 = SUBSTR(wgenerage.text7,(INDEX(wgenerage.text7,"/") + 1),LENGTH(wgenerage.text7) - (INDEX(wgenerage.text7,"/"))).
    ELSE wgenerage.text7 = "".
    
    nv_txt12  = wgenerage.text7.
END.
ELSE nv_txt1 = wgenerage.text7.
---*/

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
     sic_bran.uwm100.policy  = wgenerage.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt          AND
     sic_bran.uwm100.endcnt  = n_endcnt          AND
     sic_bran.uwm100.bchyr   = nv_batchyr        AND
     sic_bran.uwm100.bchno   = nv_batchno        AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
        CREATE sic_bran.uwd102.
        ASSIGN
            sic_bran.uwd102.bptr    = nv_bptr
            sic_bran.uwd102.fptr    = 0
            sic_bran.uwd102.policy  = wgenerage.policy
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgstk132 C-Win 
PROCEDURE proc_wgstk132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER   n_policy    AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   n_rencnt    AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   n_endcnt    AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_riskno   AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_itemno   AS INTEGER           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_tariff   AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   nv_bencod   AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   nv_benvar   AS CHARACTER         NO-UNDO.
DEFINE INPUT        PARAMETER   nv_gap      AS DECIMAL           NO-UNDO.
DEFINE INPUT        PARAMETER   nv_prem_c   AS DECIMAL           NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER   nv_line     AS INTEGER           NO-UNDO.

/*DEFINE  SHARED WORKFILE wk_uwd132  LIKE brstat.wkuwd132.*/
HIDE MESSAGE NO-PAUSE.


nv_line   = nv_line + 1.

IF nv_bencod  <> " "  THEN DO:
   CREATE wk_uwd132.
   ASSIGN wk_uwd132.policy = n_policy
          wk_uwd132.rencnt = n_rencnt
          wk_uwd132.endcnt = n_endcnt
          wk_uwd132.riskgp = 0
          wk_uwd132.riskno = nv_riskno
          wk_uwd132.itemno = nv_itemno
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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

