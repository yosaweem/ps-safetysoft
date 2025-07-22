&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
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

  Created: 

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

/***--- 
    A50-0130 Shukiat T.
    Modi on 01/06/2007
    ปรับโปรแกรม Load Text File Compulsory (04.10.10)
    เข้าสู่ระบบ GW 
---***/

/***--- A50-0165 ---***/
/***--- Shukiat T. develop on 28/06/2007 ---***/
/***---
    ปรับโปรแกรมให้รองรับรูปแบบ Sticker ใหม่ 
    11 หลักแต่จะไม่มีการ chkmod ให้ทำการ check กับ
    field uwm301.drinam[9] แทน
---***/     
/***--- A50-0202 ---***/
/***--- Shukiat T. Develop on 14/08/2007 ---***/
/***--- ให้ค่า Uwm100.trty11 มีค่าเป็น "M" ---***/

/***--- A50-0204 Shukiat T. 04/09/2007 ---***/
/***--- ในกรณีที่เลขศูนย์ข้างหน้าเลข   ---***/
/***--- Sticker ที่ขึ้นต้นด้วย "02"    ---***/
/***--- ใน File Excel ที่นำเข้าหายไป   ---***/
/***--- และ Lock เลข Sticker ให้มี     ---***/
/***--- ได้แค่ 9 หรือ 11 หลัก เท่านั้น ---***/
/*--Amparat c. a51-0253  Sticker 13 หลัก */

/* Modify By : Chutikarn.S Date. 20/01/2010 Assign No.: A53-0015
             : Update & Clear uwm100.endern (วันที่รับเงินจากลูกค้า) */

/*a490166*/
DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.

DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER FORMAT "999"         INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". /*Temp Policy*/

DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.

DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.

DEF VAR nv_reccnt   AS  INT  INIT  0.        /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.  /*complete record */

DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */

DEFINE VAR  nv_batflg    AS LOG                          INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(50)"          INIT "".   /* Parameter คู่กับ nv_check */
DEFINE VAR  nv_check     AS CHARACTER                      INITIAL ""  NO-UNDO.
DEFINE VAR  nv_sist_p    AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR  nv_chkstk    AS CHARACTER FORMAT "9999999999999" INITIAL "".             /*A51-0253*/
DEFINE NEW SHARED VAR nvw_sticker AS INTEGER  FORMAT "999999999999" INIT 0 NO-UNDO.  /*A51-0253*/
DEFINE NEW SHARED VAR chr_sticker AS CHAR     FORMAT "X(15)".                        /*A51-0253*/
DEFINE NEW SHARED VAR nv_modulo   AS INT      FORMAT "9".                          /*A50-0165 Shukiat T. Add*/       


def  var  nv_row  as  int  init  0.
/*DEFINE STREAM  ns1.*/ 
/*DEFINE STREAM  ns2.*/ 

DEFINE STREAM  ns3. 

/***--- End Old variable ---***/

DEFINE NEW SHARED WORKFILE wgenerage NO-UNDO
FIELD policy     AS CHAR FORMAT "X(16)"      INIT ""  /*1 */
FIELD name1      AS CHAR FORMAT "X(50)"      INIT ""  /*2  Name1*/
FIELD addr1      AS CHAR FORMAT "X(30)"      INIT ""  /*3  Address 1*/
FIELD addr2      AS CHAR FORMAT "X(30)"      INIT ""  /*4  Address 2*/
FIELD addr3      AS CHAR FORMAT "X(30)"      INIT ""  /*5  Address 3*/
FIELD addr4      AS CHAR FORMAT "X(20)"      INIT ""  /*6  Address 4*/
FIELD comdat     AS DATE FORMAT "99/99/9999"          /*7  วันที่เริ่มต้น*/
FIELD expdat     AS DATE FORMAT "99/99/9999"          /*8  วันที่สิ้นสุด*/
FIELD accdat     AS DATE FORMAT "99/99/9999"          /*9  วันที่ใบกำกับภาษี*/
FIELD class      AS CHAR FORMAT "X(05)"      INIT ""  /*1 */
FIELD makdes     AS CHAR FORMAT "X(18)"      INIT ""  /*10 ยี่ห้อรถ*/
FIELD vehreg     AS CHAR FORMAT "X(10)"      INIT ""  /*11 ทะเบียนรถ*/
FIELD cha_no     AS CHAR FORMAT "X(20)"      INIT ""  /*12 เลขที่ตัวรถ*/
FIELD body       AS CHAR FORMAT "X(15)"      INIT ""  /*13 ชนิดของตัวรถ*/
FIELD engine     AS CHAR FORMAT "X(05)"      INIT ""  /*14 จำนวน CC.*/
FIELD vehusg     AS CHAR FORMAT "X(01)"      INIT ""  /*15 ลักษณะการใช้รถ(1=รถส่วนบุคคล 2=รับจ้าง/ให้เช่า */
FIELD sticker    AS CHAR FORMAT "X(15)"      INIT ""  /*16 Sticker no.*/  /*--amparat-A51-0253--*/
FIELD prem       AS DECI FORMAT ">>>>>9.99"  INIT 0   /*17 เบี้ยประกันสุทธิ*/
FIELD stamp      AS DECI FORMAT ">>>9.99"    INIT 0   /*18 Stamp*/
FIELD tax        AS DECI FORMAT ">>>>9.99"   INIT 0   /*19 VAT  */
                 /***--- Note Add ---***/
FIELD rec_status  AS CHAR FORMAT "X(01)"     INIT ""  /*20 Record Pass Status Y/N */
FIELD rec_comment AS CHAR FORMAT "X(100)"    INIT "". /*21 Record Comment Must be Complete or comment */
/* -------------------------------------------------------------------- */

DEFINE NEW SHARED WORKFILE wexcel NO-UNDO
FIELD seqno1     AS CHAR FORMAT ">>>>>9"     INIT ""  /*0 */
FIELD policy     AS CHAR FORMAT "X(16)"      INIT ""  /*1 */
/*FIELD sticker    AS CHAR FORMAT "X(11)"      INIT ""  /*16 Sticker no.*/---a51-0253--*/
FIELD sticker    AS CHAR FORMAT "X(15)"      INIT ""  /*16 Sticker no.*/ /*---a51-0253--*/
FIELD comdat     AS CHAR FORMAT "99/99/9999"          /*7  วันที่เริ่มต้น*/
FIELD expdat     AS CHAR FORMAT "99/99/9999"          /*8  วันที่สิ้นสุด*/
FIELD name1      AS CHAR FORMAT "X(50)"      INIT ""  /*2  Name1*/
FIELD addr1      AS CHAR FORMAT "X(70)"      INIT ""  /*3  Address 1*/
FIELD class      AS CHAR FORMAT "X(05)"      INIT ""  /*1 */
FIELD makdes     AS CHAR FORMAT "X(18)"      INIT ""  /*10 ยี่ห้อรถ*/
FIELD vehreg     AS CHAR FORMAT "X(10)"      INIT ""  /*11 ทะเบียนรถ*/
FIELD cha_no     AS CHAR FORMAT "X(20)"      INIT ""  /*12 เลขที่ตัวรถ*/
FIELD body       AS CHAR FORMAT "X(15)"      INIT ""  /*13 ชนิดของตัวรถ*/
FIELD engine     AS CHAR FORMAT "X(05)"      INIT ""  /*14 จำนวน CC.*/
FIELD vehusg     AS CHAR FORMAT "X(01)"      INIT ""  /*15 ลักษณะการใช้รถ(1=รถส่วนบุคคล 2=รับจ้าง/ให้เช่า */
FIELD prem       AS CHAR FORMAT ">>>>>9.99"  INIT 0   /*17 เบี้ยประกันสุทธิ*/
FIELD stamp      AS CHAR FORMAT ">>>9.99"    INIT 0   /*18 Stamp*/
FIELD total      AS CHAR FORMAT ">>>>9.99"   INIT 0   /*19 VAT  */
FIELD tax        AS CHAR FORMAT ">>>>9.99"   INIT 0   /*19 VAT  */
FIELD sumtotal   AS CHAR FORMAT ">>>>>9.99"  INIT 0   /*17 เบี้ยประกันสุทธิ*/
.

DEFINE NEW SHARED WORKFILE wendtext  NO-UNDO
/*1*/  FIELD line     AS INTEGER   FORMAT ">>9"
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".

DEFINE            WORKFILE wdelimi   NO-UNDO
       FIELD txt     AS CHARACTER FORMAT "X(1000)" INITIAL "".

DEFINE STREAM nfile.
DEFINE STREAM ndata.
DEFINE STREAM nnotdata.
DEFINE STREAM outputdata.

DEFINE VAR nv_line    AS INTEGER   INITIAL 0            NO-UNDO.
DEFINE VAR nv_delimiter AS LOGICAL                      NO-UNDO.
DEFINE VAR nv_delimitxt AS CHAR FORMAT "X(25)"  INIT "" NO-UNDO.

DEFINE VAR nv_chr       AS CHARACTER FORMAT "X(01)"     INITIAL ""  NO-UNDO.
DEFINE VAR sh_policy2   AS CHARACTER FORMAT "X(16)"     INITIAL ""  NO-UNDO.

DEFINE VAR nv_text1     AS CHAR      FORMAT "X(100)"       INIT ""     NO-UNDO.
DEFINE VAR nv_text2     AS CHAR      FORMAT "X(100)"       INIT ""     NO-UNDO.
DEFINE VAR nv_text3     AS CHAR      FORMAT "X(100)"       INIT ""     NO-UNDO.
DEFINE VAR nv_text4     AS CHAR      FORMAT "X(100)"       INIT ""     NO-UNDO.
DEFINE VAR nv_text5     AS CHAR      FORMAT "X(100)"       INIT ""     NO-UNDO.
DEFINE VAR nv_text6     AS CHAR      FORMAT "X(100)"       INIT ""     NO-UNDO.
DEFINE VAR nv_vehreg    AS CHAR      FORMAT "X(10)"        INIT ""     NO-UNDO.

DEFINE VAR sh_policy  AS CHARACTER FORMAT "X(16)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_name    AS CHARACTER FORMAT "X(70)"       INITIAL ""  NO-UNDO.

DEFINE VAR nv_ADDR1     AS CHAR      FORMAT "X(35)"        INIT ""     NO-UNDO.
DEFINE VAR nv_ADDR2     AS CHAR      FORMAT "X(35)"        INIT ""     NO-UNDO.
DEFINE VAR nv_ADDR3     AS CHAR      FORMAT "X(35)"        INIT ""     NO-UNDO.
DEFINE VAR nv_ADDR4     AS CHAR      FORMAT "X(20)"        INIT ""     NO-UNDO.

DEFINE VAR nv_trndat  AS DATE      FORMAT "99/99/9999" INITIAL TODAY NO-UNDO.
DEFINE VAR nv_comdat  AS DATE      FORMAT "99/99/9999"               NO-UNDO.
DEFINE VAR nv_expdat  AS DATE      FORMAT "99/99/9999"               NO-UNDO.

DEFINE VAR nv_total    AS DECIMAL   FORMAT ">>>,>>>,>>9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_count    AS INTEGER   INITIAL 0  NO-UNDO.


DEFINE VAR nv_data      AS CHARACTER FORMAT "X(40)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_notdata   AS CHARACTER FORMAT "X(40)"     INITIAL ""  NO-UNDO.

DEFINE VAR nv_rencnt  AS INTEGER   FORMAT "99"          INITIAL 0   NO-UNDO.
DEFINE VAR nv_endcnt  AS INTEGER   FORMAT "999"         INITIAL 0   NO-UNDO.

DEFINE VAR nv_branch  AS CHARACTER FORMAT "X(02)"       INITIAL ""  NO-UNDO.

DEFINE VAR nv_com1p   AS DECIMAL   INITIAL 0            NO-UNDO.
DEFINE VAR nv_com1_t  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_prem_t  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_stamp   AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_tax     AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.

DEFINE VAR nv_undyr    AS CHARACTER FORMAT "X(04)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_poltyp   AS CHARACTER FORMAT "X(04)"       INITIAL ""  NO-UNDO.
DEFINE VAR nv_sticker  AS INTEGER   FORMAT "9999999999999".  /*a51-0253*/
DEFINE VAR nv_sticker1 AS CHARACTER FORMAT "X(15)"     INITIAL ""  NO-UNDO. /*Note Ad on A50-0097 11/05/2007*/ /*a51-0253*/

DEFINE VAR nv_insname1 AS CHARACTER FORMAT "X(70)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_title    AS CHARACTER FORMAT "X(15)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_insref   AS CHARACTER FORMAT "X(7)"  INITIAL ""  NO-UNDO.
DEFINE VAR nv_acno1    AS CHARACTER FORMAT "X(07)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_agent    AS CHARACTER FORMAT "X(07)" INITIAL ""  NO-UNDO.

DEFINE VAR nv_class    AS CHARACTER FORMAT "X(04)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_modcod    AS CHARACTER FORMAT "X(04)"     INITIAL ""  NO-UNDO.

DEFINE VAR nv_sity_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_pdst_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_pdty_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_cost_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.

DEFINE VAR nv_uom8_c   AS CHARACTER FORMAT "X(2)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_uom9_c   AS CHARACTER FORMAT "X(2)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_uom8_v   AS DECIMAL   FORMAT ">>>,>>>,>>9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_uom9_v   AS DECIMAL   FORMAT ">>>,>>>,>>9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_opnpol   LIKE sicuw.uwm100.opnpol INIT "".
/*---a51-0253---*/
DEF VAR nv_seqno AS INT.
DEF VAR nv_seqno2 AS INT.
/*---a51-0253---*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME BROWSE-4

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wgenerage

/* Definitions for BROWSE BROWSE-4                                      */
&Scoped-define FIELDS-IN-QUERY-BROWSE-4 wgenerage.policy wgenerage.name1 wgenerage.addr1 wgenerage.addr2 wgenerage.addr3 wgenerage.addr4 wgenerage.comdat wgenerage.expdat wgenerage.accdat wgenerage.class wgenerage.makdes wgenerage.vehreg wgenerage.cha_no wgenerage.body wgenerage.engine wgenerage.vehusg wgenerage.sticker wgenerage.prem wgenerage.stamp wgenerage.tax wgenerage.rec_status wgenerage.rec_comment   
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
&Scoped-Define ENABLED-OBJECTS BROWSE-4 fi_loaddat fi_branch fi_producer ~
fi_agent fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 ~
fi_output3 fi_usrcnt fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent ~
RECT-368 RECT-370 RECT-373 RECT-374 RECT-375 RECT-376 RECT-372 RECT-377 ~
RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_branch fi_bchno fi_producer ~
fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 fi_output2 fi_output3 ~
fi_usrcnt fi_usrprem fi_brndes fi_impcnt fi_completecnt fi_proname ~
fi_agtname fi_premtot fi_premsuc 

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
     SIZE 63.5 BY 1.05
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
     SIZE 63.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

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
     SIZE 63.5 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

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
     SIZE 124 BY 11.91
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 124 BY 6.19
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
 wgenerage.vehreg      COLUMN-LABEL "Veh. Reg."
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 121.5 BY 5.24
         BGCOLOR 15 FONT 6 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     BROWSE-4 AT ROW 15.29 COL 4
     fi_loaddat AT ROW 3.76 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.86 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.29 COL 17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producer AT ROW 5.91 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.95 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8 COL 70.83 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 9.05 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 9.05 COL 96.33
     fi_output1 AT ROW 10.1 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 11.14 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 12.19 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 13.24 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 13.24 COL 78 NO-LABEL
     buok AT ROW 8.86 COL 104.67
     bu_exit AT ROW 10.71 COL 104.67
     fi_brndes AT ROW 4.71 COL 56 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 4.81 COL 44
     fi_impcnt AT ROW 21.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno1 AT ROW 5.91 COL 49.5
     fi_completecnt AT ROW 22.71 COL 60.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpagent AT ROW 6.95 COL 49.5
     fi_proname AT ROW 5.81 COL 56 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.91 COL 56 COLON-ALIGNED NO-LABEL
     fi_premtot AT ROW 21.71 COL 98.17 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 22.76 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     "Branch  :" VIEW-AS TEXT
          SIZE 9 BY 1.05 AT ROW 4.81 COL 24
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.29 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY 1.05 AT ROW 3.76 COL 21.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY 1.05 AT ROW 9.05 COL 10.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.83 BY 1.05 AT ROW 8 COL 70.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer  Code :" VIEW-AS TEXT
          SIZE 17.17 BY 1.05 AT ROW 5.91 COL 16.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 13.24 COL 96.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 23.5 BY 1.05 AT ROW 13.24 COL 76.5 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Policy Import Total :":60 VIEW-AS TEXT
          SIZE 20 BY 1.05 AT ROW 13.24 COL 31.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.71 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   LOAD TEXT FILE COMPULSORY (V72,V73,V74)" VIEW-AS TEXT
          SIZE 122 BY .95 AT ROW 1.71 COL 3.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.71 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 127.67 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 10.1 COL 14
          BGCOLOR 8 FGCOLOR 1 
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY 1.05 AT ROW 11.14 COL 10
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21 BY 1.05 AT ROW 8 COL 11.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 12.19 COL 15.33
          BGCOLOR 8 FGCOLOR 1 
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY 1.05 AT ROW 6.95 COL 19.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 58.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-368 AT ROW 13 COL 42.17
     RECT-370 AT ROW 1.33 COL 2.5
     RECT-373 AT ROW 14.81 COL 2.5
     RECT-374 AT ROW 21 COL 2.5
     RECT-375 AT ROW 21.24 COL 4
     RECT-376 AT ROW 21.48 COL 5.5
     RECT-372 AT ROW 2.91 COL 2.5
     RECT-377 AT ROW 8.57 COL 103.5
     RECT-378 AT ROW 10.43 COL 103.5
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
         WIDTH              = 126.83
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 127.67
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 127.67
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
   Custom                                                               */
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
          SIZE 12.83 BY 1.05 AT ROW 8 COL 70.33 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "Policy Import Total :"
          SIZE 20 BY 1.05 AT ROW 13.24 COL 31.67 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 23.5 BY 1.05 AT ROW 13.24 COL 76.5 RIGHT-ALIGNED         */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.71 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.71 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.71 COL 58.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.71 COL 96 RIGHT-ALIGNED          */

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

    /*chk first */
    IF fi_branch = " " THEN DO: /*note add 10/11/2005*/
         MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
         APPLY "entry" TO fi_branch.
         RETURN NO-APPLY.
    END. /*end note add 10/11/2005*/

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
    /***---a490166 ---***/
    IF fi_bchyr <= 0 THEN DO:
        MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_bchyr.
        RETURN NO-APPLY.
    END.
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
    /***---a490166 ---***/
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

    nv_batchyr = INPUT fi_bchyr.

    
    /*--- Batch No ---*/
      IF nv_batprev = "" THEN DO:  /* เป็นการนำเข้าข้อมูลครั้งแรกของไฟล์นั้นๆ */

        FIND LAST uzm700 USE-INDEX uzm70001
            WHERE uzm700.acno    = TRIM(fi_producer)  AND
                  uzm700.branch  = TRIM(nv_batbrn) AND
                  uzm700.bchyr = nv_batchyr
        NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:   /*ได้ running 4 หลักหลัง Branch */

          nv_batrunno = uzm700.runno.

          FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
              WHERE uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") 
          NO-LOCK NO-ERROR.
          IF AVAIL uzm701 THEN DO:

            nv_batcnt = uzm701.bchcnt .
            nv_batrunno = nv_batrunno + 1.

          END.
        END.
        ELSE DO:  /* ยังไม่เคยมีการนำเข้าข้อมูลสำหรับ Account No. และ Branch นี้ */
          ASSIGN
            nv_batcnt = 1
            nv_batrunno = 1.
        END.

        nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").

      END.
      ELSE DO:  /* ระบุ batch file เดิมที่เคยนำเข้าแล้ว */
        nv_batprev = INPUT fi_prevbat.

        FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10006 ---> uzm70102 31/10/2006*/
            WHERE uzm701.bchno = CAPS(nv_batprev)
        NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
          MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                + " on file uzm701" .
          APPLY "entry" TO fi_prevbat.
          RETURN NO-APPLY.
        END.
        IF AVAIL uzm701 THEN DO:
          nv_batcnt  = uzm701.bchcnt + 1.
          nv_batchno = CAPS(TRIM(nv_batprev)).

        END.
      END.
/*----------------*/

    /*end chk first*/
    ASSIGN
         fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
         fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
         /*a490166*/
         fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
         fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
         nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
         nv_tmppolrun = 0                    nv_daily        = ""
         nv_reccnt    = 0                    nv_completecnt  = 0
         nv_netprm_t  = 0                    nv_netprm_s     = 0
         nv_batbrn    = fi_branch 
         /***--- NOte Add A50-0095 ---***/
         nv_data      = fi_output1
         nv_notdata   = fi_output2.


/***---A490166 Run Batch No. ---***/ 
RUN wgw\wgwbatch.p    (INPUT        fi_loaddat ,     /* DATE  */
                       INPUT        nv_batchyr ,     /* INT   */
                       INPUT        fi_producer,     /* CHAR  */ 
                       INPUT        nv_batbrn  ,     /* CHAR  */
                       INPUT        fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                       INPUT        "WGWARGEN" ,     /* CHAR  */
                       INPUT-OUTPUT nv_batchno ,     /* CHAR  */
                       INPUT-OUTPUT nv_batcnt  ,     /* INT   */
                       INPUT        nv_imppol  ,     /* INT   */
                       INPUT        nv_impprem       /* DECI  */
                       ).
ASSIGN
fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).

DISP  fi_bchno   WITH FRAME fr_main.

/******************************************************************************/    
/******************************************************************************/
/******************************************************************************/
/***--- Loop Tmimp72.p save ---***/
    MESSAGE COLOR YEL/RED SKIP
            "      กด Yes เพื่อ Confirm Process Data    " SKIP
            " พรบ. 72,73,74 " SKIP
             VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO
             TITLE "Warning Message" UPDATE choice AS LOGICAL.
    IF NOT choice THEN DO:
      MESSAGE COLOR YELLOW "ยกเลิกการProcess Data" VIEW-AS ALERT-BOX.  
      RETURN NO-APPLY.
    END.
    
    /***--- Clear Temp Data ---***/
    FOR EACH wgenerage:
      DELETE wgenerage.
    END.

    FOR EACH wexcel:
      DELETE wexcel.
    END.

    FOR EACH wdelimi:
      DELETE wdelimi.
    END.

    /***--- Start Input ---***/
    INPUT STREAM nfile FROM VALUE(fi_filename).
    REPEAT:
      CREATE wdelimi.
      IMPORT STREAM nfile wdelimi.
      LEAVE.
    END.
    INPUT STREAM nfile CLOSE.

    FIND FIRST wdelimi NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE wdelimi THEN DO:
      MESSAGE " Not found data " VIEW-AS ALERT-BOX.
      RETURN NO-APPLY.
    END.

    nv_line      = 0.
    nv_delimiter = NO.
    nv_delimitxt = wdelimi.txt.
    
    REPEAT:
      IF INDEX(nv_delimitxt,",") <> 0 THEN DO:
        IF nv_line = 0 THEN DO:

          nv_delimitxt = SUBSTRING(wdelimi.txt,INDEX(nv_delimitxt,",") + 1,256).
        END.
        ELSE DO:

          nv_delimiter = YES.
          LEAVE.
        END.
        nv_line = nv_line + 1.
      END.
      ELSE
        LEAVE.
    END.
    
    /* END Check data DELIMITER "," */

    


    RUN proc_temp1.



/******************************************************************************/
/******************************************************************************/
/******************************************************************************/
ASSIGN 
nv_netprm_s  = 0 nv_completecnt = 0 
nv_rectot    = 0 nv_recsuc      = 0    .

/***--- Old Program Part ---***/
/***--- ไมมี Record ไม่ Run Batch ---***/
IF  nv_reccnt = 0 THEN DO: 
    MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
    /*RETURN NO-APPLY.*/
END.

FOR EACH wgenerage WHERE wgenerage.rec_status  = "Y"  :
    ASSIGN
     nv_completecnt = nv_completecnt + 1
     nv_netprm_s    = nv_netprm_s    + wgenerage.prem .
END.


/***--- start a490166 ---***/

    /***------------ update ข้อมูลที่  uzm701 ------------***/
    nv_rectot = nv_reccnt.      
    nv_recsuc = nv_completecnt. 

/*     MESSAGE                                           */
/*         "nv_imppol  " nv_imppol SKIP                  */
/*         "nv_rectot  " nv_rectot SKIP                  */
/*         "nv_rectot  " nv_rectot VIEW-AS ALERT-BOX.    */
/*                                                       */
/*     MESSAGE                                           */
/*         "nv_impprem  " nv_impprem  SKIP               */
/*         "nv_netprm_t " nv_netprm_t SKIP               */
/*         "nv_netprm_s " nv_netprm_s VIEW-AS ALERT-BOX. */

    /*--- Check Record ---*/
    IF nv_imppol <> nv_rectot OR
       nv_imppol <> nv_recsuc OR
       nv_rectot <> nv_recsuc THEN
       nv_batflg = NO.
    ELSE /*--- Check Premium ---*/
    IF nv_impprem  <> nv_netprm_t OR
       nv_impprem  <> nv_netprm_s OR
       nv_netprm_t <> nv_netprm_s THEN
        nv_batflg = NO.
    ELSE 
        nv_batflg = YES.

    FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10009 ---> uzm70102 31/10/2006*/
        WHERE uzm701.bchyr = nv_batchyr AND
              uzm701.bchno = nv_batchno AND
              uzm701.bchcnt  = nv_batcnt 
    NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
          /***--- ไม่มีการระบุ Tax Stamp ไว้ใน Text File ---***/
        /*uzm701.rec_suc     = nv_recsuc */  /***--- 26-10-2006 change field Name ---***/
          uzm701.recsuc      = nv_recsuc     /***--- 31-10-2006 change field Name ---***/
          uzm701.premsuc     = nv_netprm_s   /*nv_premsuc*/
          
        /*uzm701.rec_tot     = nv_rectot*/   /***--- 26-10-2006 change field Name ---***/
          uzm701.rectot      = nv_rectot     /***--- 26-10-2006 change field Name ---***/
          uzm701.premtot     = nv_netprm_t   /*nv_premtot*/
          
        /*uzm701.sucflg1     = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
          uzm701.impflg      = nv_batflg    /***--- 26-10-2006 change field Name ---***/
        /*uzm701.batchsta    = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
          uzm701.cnfflg      = nv_batflg    
         /* YES  สามารถนำเข้าข้อมูลได้หมด ไม่มี error  
            NO   นำเข้าข้อมูลได้ไม่ได้ไม่หมด  */
          .
    END.
    /***---------- END update ข้อมูลที่  uzm701 ---------***/
    ASSIGN
    fi_impcnt      = nv_rectot
    fi_premtot     = nv_netprm_t
    fi_completecnt = nv_recsuc
    fi_premsuc     = nv_netprm_s .

    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    

    /***--- a490166 05/10/2006 ---***/
     IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno    :FGCOLOR = 6. 
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
            fi_bchno:FGCOLOR     = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.



    /***--- end a400166 ---***/
/*RUN   proc_open.    */
RUN proc_screen  .
DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.

/*output*/

/*
RUN proc_report1 .   
RUN PROC_REPORT2 .
*/


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
             Message  "Not on Name & Address Master File xmm600" 
             View-as alert-box.
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
  IF  Input fi_branch  =  ""  Then do:
       Message "กรุณาระบุ Branch Code ." View-as alert-box.
       Apply "Entry"  To  fi_branch.
  END.
  Else do:
  FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
       sicsyac.xmm023.branch   =  Input  fi_branch 
       NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
               Message  "Not on Description Master File xmm023" 
               View-as alert-box.
               Apply "Entry"  To  fi_branch.
               RETURN NO-APPLY.
        END.
  fi_branch  =  CAPS(Input fi_branch) .
  fi_brndes  =  sicsyac.xmm023.bdes.
  End. /*else do:*/

  Disp fi_branch  fi_brndes  With Frame  fr_main.
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


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat C-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
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
       sicsyac.xmm600.acno  =  Input fi_producer  
  NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
                Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
                Apply "Entry" To  fi_producer.
                RETURN NO-APPLY. /*note add on 10/11/2005*/
            END.
            ELSE DO:
                ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer) /*note modi 08/11/05*/
                nv_ACNO1    = fi_producer .             /*note add  08/11/05*/
                
            END.
  END.

  Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
  
  
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
  
  gv_prgid = "Wgwimp72".
  gv_prog  = "Load Text File Compulsory".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
  fi_producer = ""
  fi_agent    = ""
  fi_bchyr  = YEAR(TODAY).
  DISP fi_producer fi_agent fi_bchyr WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.

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
  DISPLAY fi_loaddat fi_branch fi_bchno fi_producer fi_agent fi_prevbat fi_bchyr 
          fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt fi_usrprem 
          fi_brndes fi_impcnt fi_completecnt fi_proname fi_agtname fi_premtot 
          fi_premsuc 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE BROWSE-4 fi_loaddat fi_branch fi_producer fi_agent fi_prevbat fi_bchyr 
         fi_filename bu_file fi_output1 fi_output2 fi_output3 fi_usrcnt 
         fi_usrprem buok bu_exit bu_hpbrn bu_hpacno1 bu_hpagent RECT-368 
         RECT-370 RECT-373 RECT-374 RECT-375 RECT-376 RECT-372 RECT-377 
         RECT-378 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_check1 C-Win 
PROCEDURE proc_check1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


nv_reccnt   = 0.
nv_netprm_t = 0.
/***--- ตรวจสอบความถูกต้องของข้อมูล ---***/
FOR EACH wgenerage NO-LOCK:

      ASSIGN
      nv_reccnt   = nv_reccnt + 1 /*note add on 23/05/2007*/
      nv_netprm_t = nv_netprm_t + wgenerage.prem.
      
      IF wgenerage.policy = "" OR
         wgenerage.prem   = 0  OR
         wgenerage.stamp  = 0  OR
         wgenerage.tax    = 0
      THEN DO:
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

      IF wgenerage.name1   = "" OR
         wgenerage.addr1   = "" OR
         wgenerage.sticker = "" 
      THEN DO:
          MESSAGE "(2) ข้อมูล Name, Address, Sticker ไม่ถูกต้อง" wgenerage.policy.
          ASSIGN
          wgenerage.rec_status  = "N"
          wgenerage.rec_comment = wgenerage.rec_comment + "(2) ข้อมูล Name, Address, Sticker ไม่ถูกต้อง |".

          PUT STREAM nnotdata
              "Name,Address = '' " wgenerage.policy
              " "                  wgenerage.name1
              " Sticker: "         wgenerage.sticker
          SKIP.
          NEXT.
      END.

      IF wgenerage.comdat  = ?  OR
         wgenerage.expdat  = ?
      THEN DO:
          MESSAGE "(3) ข้อมูล Com.Date, Exp.Date Name ไม่ถูกต้อง" wgenerage.policy.
          ASSIGN
          wgenerage.rec_status  = "N"
          wgenerage.rec_comment = wgenerage.rec_comment + "(3) ข้อมูล Com.Date, Exp.Date Name ไม่ถูกต้อง |".          
          PUT STREAM nnotdata
              "Com.Date,Exp.Date= " wgenerage.policy
              " Sticker: "          wgenerage.sticker
              " Com.Dat: "          wgenerage.comdat
              " Exp.Dat: "          wgenerage.expdat
              " "                   wgenerage.name1
          SKIP.
          NEXT.
      END.

      /***---***---***---***/

      nv_rencnt = 0.
      nv_endcnt = 0.

      /***---***---***---***--- Start Uwm100 ---***---***---***---***---***/
      /***---***---***---***--- Start Uwm100 ---***---***---***---***---***/
      /***---***---***---***--- Start Uwm100 ---***---***---***---***---***/
      FIND sicuw.uwm100 WHERE
           sicuw.uwm100.policy = wgenerage.policy  AND
           sicuw.uwm100.rencnt = nv_rencnt         AND
           sicuw.uwm100.endcnt = nv_endcnt
      NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAILABLE sicuw.uwm100 THEN DO:
        IF LOCKED sicuw.uwm100 THEN DO:
              MESSAGE "พบข้อมูลกำลังถูกดำเนินการแก้ไข(SICUW.UWM100)"
                      sicuw.uwm100.policy
                      sicuw.uwm100.rencnt
                      sicuw.uwm100.endcnt VIEW-AS ALERT-BOX.
              ASSIGN
              wgenerage.rec_status  = "N"
              wgenerage.rec_comment = wgenerage.rec_comment + "พบข้อมูลกำลังถูกดำเนินการแก้ไข(SICUW.UWM100) |".          
    
              PUT STREAM nnotdata
                  "LOCK (uwm100) " wgenerage.policy
                  " "              wgenerage.name1
                  " Sticker: "     wgenerage.sticker
              SKIP.
              NEXT.
        END.

        MESSAGE "ไม่พบข้อมูลเบอร์กรมธรรม์ที่ (SICUW.UWM100)" wgenerage.policy VIEW-AS ALERT-BOX.
        ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "ไม่พบข้อมูลเบอร์กรมธรรม์ที่ (SICUW.UWM100) " + wgenerage.policy + " |".         
        PUT STREAM nnotdata
              "NOT  (uwm100) " wgenerage.policy
              " "              wgenerage.name1
              " Sticker: "     wgenerage.sticker
        SKIP.
        NEXT.
      END.
      
      IF uwm100.releas THEN DO:
        MESSAGE "เบอร์Policy ซ้ำ" wgenerage.policy "และโอนไป บ/ช เรียบร้อยแล้ว" VIEW-AS ALERT-BOX.
        ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "เบอร์Policy ซ้ำ" + wgenerage.policy + "และโอนไป บ/ช เรียบร้อยแล้ว | ".          
        
        PUT STREAM nnotdata
              "RELE (uwm100) " wgenerage.policy
              " "              wgenerage.name1
              " Sticker: "     wgenerage.sticker
        SKIP.
        NEXT.
      END.

      IF uwm100.name1 <> "" THEN DO:
        HIDE MESSAGE NO-PAUSE.
        MESSAGE "Policy :" wgenerage.policy "ได้โอนเข้าระบบ Premium ก่อนหน้านี้แล้ว" VIEW-AS ALERT-BOX.
        ASSIGN 
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "Policy :" + wgenerage.policy + "ได้โอนเข้าระบบ Premium ก่อนหน้านี้แล้ว | ".          
        
        PUT STREAM nnotdata
              "DUPL (uwm100) " wgenerage.policy
              " "              wgenerage.name1
              " Sticker: "     wgenerage.sticker
        SKIP.
        NEXT.
      END.
      /* ----------------------------------------------------- */

      nv_line = nv_line  + 1.
      nv_branch = SUBSTR(wgenerage.policy,2,1).

      ASSIGN
        nv_prem_t =  wgenerage.prem
        nv_stamp  =  wgenerage.stamp
        nv_tax    =  wgenerage.tax
        nv_com1p  = 0
        nv_com1_t = 0.

      nv_undyr  = "".
      nv_undyr  = STRING(YEAR(wgenerage.comdat),"9999").

      nv_poltyp = "".

      nv_poltyp = "V" + SUBSTRING(wgenerage.policy,3,2).

      /***--- A50-0130 Shukiat T. 05/06/2007 ---***/
      /***--- เปลี่ยนเงื่อนไขการ Find เงื่อนไขใน Table Xmm018 ---***/
      /* ------------------- COMMISSION -------------------- */
          FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                     sicsyac.xmm018.agent       = trim(fi_producer)      AND               /*แยกงานตาม Code Producer*/  
              SUBSTR(sicsyac.xmm018.poltyp,1,5) = "CR" + nv_poltyp       AND               /*Shukiat T. modi on 25/04/2007*/
              SUBSTR(sicsyac.xmm018.poltyp,7,1) = nv_branch              AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
                     sicsyac.xmm018.datest     <= wgenerage.comdat       NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
          IF AVAIL   sicsyac.xmm018 THEN DO:
                     nv_com1p = sicsyac.xmm018.commsp.
          END. /* Avail Xmm018 */
          ELSE DO:
                  Find sicsyac.xmm031  Use-index xmm03101  Where  
                       sicsyac.xmm031.poltyp   = nv_poltyp
                  No-lock no-error no-wait.
                  IF not  avail sicsyac.xmm031 Then nv_com1p = 0.
                  Else  nv_com1p = sicsyac.xmm031.comm1.
          END. /* Not Avail Xmm018 */

          /***--- Shukiat T. 22/06/2007 ---***/
          /***--- เนื่องมาจากมีงานของ Producer Code 
                  B300228 , B300229 , B300272 
           ที่มีการจองผ่านโปรแกรม UZO72061(04.04.23.16)       
           Assign NO. A50-0095 ให้มีค่าคอม 5 % ---***/
           nv_opnpol = "".
           IF sicuw.uwm100.opnpol = "v72comm05" OR sicuw.uwm100.opnpol = "v73comm05"  OR 
              sicuw.uwm100.opnpol = "v74comm05" THEN DO:
               nv_opnpol = sicuw.uwm100.opnpol. /**--- Shukiat T. 25/06/2007 ---***/
               IF nv_acno1 = "B300228" OR nv_acno1 = "B300229" 
               OR nv_acno1 = "B300272" THEN DO:
                  nv_com1p = 5  . /*Com 12%*/
               END.
           END.
           /***--- End A50-0095 ---***/
                  

      nv_com1_t = nv_prem_t * nv_com1p / 100. /*note modi*/
      IF nv_com1_t > 0 THEN nv_com1_t = nv_com1_t * -1.
          
           /***--- A50-0097 Note Add on  ---***/
           /***--- A50-0165 Shukiat T. ---***/
           /***--- A50-0204 Shukiat T. 04/09/2007 ---***/
           /*-----STR A51-0253 Amparat C. ----*/
                       
             IF SUBSTRING(wgenerage.sticker,1,1) = "2" THEN wgenerage.sticker = "0" + wgenerage.sticker.
               nv_sticker1 = wgenerage.sticker.

             FIND LAST stat.Detaitem USE-INDEX Detaitem11 WHERE /***--- A50-0165 Shukiat T. Modi  ---***/
                       Stat.Detaitem.Serailno = wgenerage.sticker NO-LOCK NO-ERROR NO-WAIT.
              IF AVAIL Stat.Detaitem THEN DO:
                 IF Stat.Detaitem.policy <> wgenerage.policy THEN DO:
                    ASSIGN 
                      wgenerage.rec_status  = "N"
                      wgenerage.rec_comment = wgenerage.rec_comment + "Duplicate Sticker:" + wgenerage.sticker + "Policy Load:" + wgenerage.policy  +
                                              "&Pol no." + Stat.Detaitem.policy + " " +
                                              STRING(Stat.Detaitem.rencnt,"99") + "/" +
                                              STRING(Stat.Detaitem.endcnt,"999") + "| ".
                      PUT STREAM nnotdata
                         "POL  (Detaitem) " Stat.Detaitem.policy
                         "<> TEXT "       wgenerage.policy
                         " "              wgenerage.name1
                         " Duplicate Sticker: "     wgenerage.sticker
                      SKIP.
                      NEXT.
                 END.
              END.
           /*-----END A51-0253 Amparat C. ----*/
           /*----Comment BY Amparat C. A51-0253---
                  IF LENGTH(wgenerage.sticker) = 10 THEN DO:
                            wgenerage.sticker = "0" + wgenerage.sticker.
                  END.
                  
                  nv_sticker1 = wgenerage.sticker.

                  IF LENGTH(nv_sticker1) = 11 THEN DO:
                      IF SUBSTR(wgenerage.sticker,1,2) = "02" THEN DO:
                              nv_sticker = INTEGER(SUBSTR(wgenerage.sticker,3,8)).
                      END.
                      ELSE DO:
                              IF SUBSTR(wgenerage.sticker,1,1) = "2" THEN
                                 nv_sticker = INTEGER(SUBSTR(wgenerage.sticker,2,9)).
                              ELSE
                                 nv_sticker = INTEGER(SUBSTR(wgenerage.sticker,1,10)).
                      END.

                  END. /*length 11*/
                  ELSE IF LENGTH(nv_sticker1) = 9 THEN DO:  /*Length 9*/
                      nv_sticker = integer(wgenerage.sticker).
                  END. /*Length 9*/
                  ELSE DO:
                        ASSIGN 
                        wgenerage.rec_status  = "N"
                        wgenerage.rec_comment = wgenerage.rec_comment + "Error Length Sticker:" + wgenerage.sticker + "Policy Load:" + wgenerage.policy  +
                                                "Not Equal 9 or 11".
                                                
                        PUT STREAM nnotdata
                           "POL  (Load) "   wgenerage.policy
                           " "              wgenerage.name1
                           "Error Length Sticker: "     wgenerage.sticker
                           " Not Equal 9 or 11"
                        SKIP.
                        NEXT.
                  END.
            
           /***--- End A50-0204 Shukiat T. 04/09/2007 ---***/
           /***--- End note A50-0165 ---***/

           /***--- Loop นี้ Check Sticker ซ้ำ ---***/
           /*FIND sicuw.uwm301 USE-INDEX uwm30190 WHERE*/  /***--- A50-0165 Shukiat T. Block ---***/
           FIND LAST sicuw.uwm301 USE-INDEX uwm30190 WHERE /***--- A50-0165 Shukiat T. Modi  ---***/
                     sicuw.uwm301.sckno = nv_sticker
           NO-LOCK  NO-ERROR.
           IF AVAIL sicuw.uwm301 THEN DO:
              IF sicuw.uwm301.policy <> wgenerage.policy
              THEN DO:
                /***--- A50-0165 Shukiat T. ---***/
                /***--- Block Message on 23/07/2007 ---***/
                /***---
                MESSAGE "Duplicate Stricker:" wgenerage.sticker "Policy Load:" wgenerage.policy 
                        "&Pol no." sicuw.uwm301.policy + " " +
                         STRING(sicuw.uwm301.rencnt,"99") + "/" +
                         STRING(sicuw.uwm301.endcnt,"999").
                ---***//***--- End A50-0165 ---***/
                ASSIGN 
                wgenerage.rec_status  = "N"
                wgenerage.rec_comment = wgenerage.rec_comment + "Duplicate Sticker:" + wgenerage.sticker + "Policy Load:" + wgenerage.policy  +
                                        "&Pol no." + sicuw.uwm301.policy + " " +
                                        STRING(sicuw.uwm301.rencnt,"99") + "/" +
                                        STRING(sicuw.uwm301.endcnt,"999") + "| ".
                PUT STREAM nnotdata
                   "POL  (uwm301) " sicuw.uwm301.policy
                   "<> TEXT "       wgenerage.policy
                   " "              wgenerage.name1
                   " Duplicate Sticker: "     wgenerage.sticker
                SKIP.
                NEXT.
              END.
           END.

           /***--- A50-0165 Shukiat T.  ---***/
           /***--- add on 19/07/2007 ----***/
           /***--- Check Sticker ในกรณีที่มีการจอง Policy และ เลข  Sticker ไว้แล้ว 
                  ให้ทำการตรวจสอบเลข Sticker ใน Database กับ
                  เลข Sticker ใน File ที่ Load ด้วยว่าตรงกันหรือไม่?
                  ถ้า"ไม่"ไม่กระทำ Transaction ใดๆต่อ
           ---***/
           -----Comment BY Amparat C. A51-0253---*/
           ASSIGN
           nv_chkstk   = ""
           chr_sticker = ""
           nvw_sticker = 0 .
           FIND LAST sicuw.uwm301 WHERE sicuw.uwm301.policy = sicuw.uwm100.policy  AND
                                        sicuw.uwm301.rencnt = sicuw.uwm100.rencnt  AND /*0*/
                                        sicuw.uwm301.endcnt = sicuw.uwm100.endcnt      /*0*/
           NO-LOCK NO-ERROR NO-WAIT.
           IF AVAIL sicuw.uwm301 THEN DO:
                    /*--Comment by amparat c. a51-0253----
                    IF uwm301.sckno <> 0 THEN DO:
                       IF INDEX(uwm301.drinam[9],"STKNO:") = 0 THEN DO:
                          nvw_sticker = uwm301.sckno.
                        
                           IF SUBSTRING(STRING(nvw_sticker,"9999999999"),1,1) = "1"
                           THEN chr_sticker = STRING(nvw_sticker,"9999999999").
                           ELSE chr_sticker = "2" + SUBSTRING(STRING(nvw_sticker,"9999999999"),2,9).
                           RUN wuz/wuzchmod.
                       END.
                       ELSE DO:
                           chr_sticker = TRIM(SUBSTRING(uwm301.drinam[9],7,LENGTH(uwm301.drinam[9]))).
                       END.
                    END.
                    --Comment by amparat c. a51-0253----*/
                    chr_sticker = TRIM(SUBSTRING(uwm301.drinam[9],7,LENGTH(uwm301.drinam[9]))).
                    nv_chkstk = chr_sticker.

/*                     MESSAGE "nv_chkstk : " nv_chkstk SKIP                                */
/*                             "wgenerage.sticker : " wgenerage.sticker  VIEW-AS ALERT-BOX. */

                    IF nv_chkstk <> wgenerage.sticker  THEN DO:
                            /***--- A50-0165 Shukiat T. Block ---***/
                            /***---
                            MESSAGE "Stricker MisMatch :" wgenerage.sticker "Policy Load:" wgenerage.policy 
                                    "&Pol no." sicuw.uwm301.policy + " " +
                                     STRING(sicuw.uwm301.rencnt,"99") + "/" +
                                     STRING(sicuw.uwm301.endcnt,"999").
                            ---***//***--- End Shukiat T. Block ---***/         
                            ASSIGN 
                            wgenerage.rec_status  = "N"
                            wgenerage.rec_comment = wgenerage.rec_comment + "Sticker MisMatch:" + wgenerage.sticker + "Policy Load:" + wgenerage.policy  +
                                                    "&Pol no." + sicuw.uwm301.policy + " " +
                                                    STRING(sicuw.uwm301.rencnt,"99") + "/" +
                                                    STRING(sicuw.uwm301.endcnt,"999") + "| ".
                            PUT STREAM nnotdata
                               "POL  (uwm301) " sicuw.uwm301.policy
                               "<> TEXT "       wgenerage.policy
                               " "              wgenerage.name1
                               "MisMatch Sticker: "     wgenerage.sticker
                            SKIP.
                            NEXT.
                    END.
           END.
           /***--- End A50-0165 Check Sticker ---***/


      ASSIGN
        nv_name      = ""
        nv_insname1  = "".
/*      nv_name2     = ""  */
/*      nv_insname2  = ""  */
/*      nv_vat_no    = ""  */
/*      nv_vat_name  = ""  */
/*      nv_vat_addr1 = ""  */
/*      nv_vat_addr2 = ""  */
/*      nv_vat_addr3 = ""  */
/*      nv_vat_addr4 = "". */

      sh_policy   = wgenerage.policy.
      nv_insref   = "COMP".
      nv_title    = "".
      nv_insname1 = wgenerage.name1.

      RUN proc_uwm100.
      RUN proc_uwm120.
      RUN proc_uwm301.
      RUN proc_uwm130.

      /***--- A50-0130---***/
      /***--- Shukiat Move This transaction  ---***/
      /***--- ไปขั้นตอน Transfer To Alpha4 ---***/
      /* Update Vat100 */
      /***---
      RUN uz/uzo72vat (INPUT RECID(uwm100),
                       INPUT "TMIMP72").
      ---***/


      nv_total = 0.
      nv_total = uwm100.prem_t
               + uwm100.rstp_t
               + uwm100.rtax_t.

      PUT STREAM ndata
                           sic_bran.uwm100.policy
              " R/E "      sic_bran.uwm100.rencnt
              "/"          sic_bran.uwm100.endcnt
              " Docno:"    sic_bran.uwm100.docno1
              " Sticker:"  wgenerage.sticker
              " "          sic_bran.uwm100.name1   FORMAT "X(30)"
              " "          sic_bran.uwm100.comdat
              " "          sic_bran.uwm100.expdat
              " "          sic_bran.uwm100.prem_t
              " "          sic_bran.uwm100.rstp_t
              " "          sic_bran.uwm100.rtax_t
              " "          nv_total
         SKIP.
      /* ----------------------------- */


      RELEASE sic_bran.uwm100.
      RELEASE sic_bran.uwm120.
      RELEASE sic_bran.uwm130.
      RELEASE sic_bran.uwm301.
      RELEASE sic_bran.uwd132.
      RELEASE stat.detaitem.  /*--A51-0253--*/

      /***--- A50-0130 ---***/
      /***--- Shukiat T. Modi on 18/05/2007 ---***/
      /***--- ย้ายไปอยู่ในอีกขั้นตอนนึงหลังจากนี้ ---***/
      /***---
      RUN tm/tmo098   (INPUT  wgenerage.policy,
                              nv_rencnt,
                              nv_endcnt
                      ).
       ---***//***--- End Note Block on 18/05/2007 ---***/               

END. /* For Wgenerage*/

OUTPUT STREAM nnotdata  CLOSE.
OUTPUT STREAM ndata     CLOSE.




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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Temp1 C-Win 
PROCEDURE Proc_Temp1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
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


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_uwm100 C-Win 
PROCEDURE Proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

      /* ------------- Policy Header ------------ */
      /***--- ค้นหาฝั่ง Alpha4 ---***/
      FIND sicuw.uwm100 WHERE
           sicuw.uwm100.policy = wgenerage.policy  AND
           sicuw.uwm100.rencnt = nv_rencnt         AND
           sicuw.uwm100.endcnt = nv_endcnt         
           
      NO-ERROR NO-WAIT.
      IF NOT AVAILABLE sicuw.uwm100 THEN NEXT.

      /* -------------------------------------------------------- */
      /***--- กรณีที่มีข้อมูลอยู่ฝั่ง Alpha 4 แล้ว
      ให้ทำการ Create Uwm100 ที่ฝั่ง Gateway ---***/
      Create  sic_bran.uwm100.
      
      ASSIGN
        sic_bran.uwm100.policy  = wgenerage.policy        /*Policy No.*/
        sic_bran.uwm100.rencnt  = nv_rencnt               /*Renewal Count*/
        sic_bran.uwm100.endcnt  = nv_endcnt               /*Endorsement Count*/
        sic_bran.uwm100.renno   =  ""
        /***--- Batch Detail ---***/
        sic_bran.uwm100.bchyr   = nv_batchyr 
        sic_bran.uwm100.bchno   = nv_batchno 
        sic_bran.uwm100.bchcnt  = nv_batcnt     
        /* -------------------------------- */
        sic_bran.uwm100.opnpol  = nv_opnpol   /***--- Note Add 25/06/2007 ---***/
        sic_bran.uwm100.fptr01  = 0  
        sic_bran.uwm100.bptr01  = 0   /*uwd100 Policy Upper Text*/
        sic_bran.uwm100.fptr02  = 0  
        sic_bran.uwm100.bptr02  = 0   /*uwd102 Policy Memo Text*/
        sic_bran.uwm100.fptr03  = 0  
        sic_bran.uwm100.bptr03  = 0   /*uwd105 Policy Clauses*/
        sic_bran.uwm100.fptr04  = 0  
        sic_bran.uwm100.bptr04  = 0   /*uwd103 Policy Ren. Text*/
        sic_bran.uwm100.fptr05  = 0  
        sic_bran.uwm100.bptr05  = 0   /*uwd104 Policy Endt. Text*/
        sic_bran.uwm100.fptr06  = 0  
        sic_bran.uwm100.bptr06  = 0   /*uwd106 Pol.Endt.Clauses*/

        /* -------------------------------- */
        sic_bran.uwm100.curbil  = "BHT"                   /*Currency of Billing*/
        sic_bran.uwm100.curate  = 1                       /*Currency rate for Billing*/
        sic_bran.uwm100.branch  = nv_branch               /*Branch Code (of Transaction)*/
        sic_bran.uwm100.dir_ri  = YES                     /*Direct/RI Code (D/R)*/
        sic_bran.uwm100.dept    = "B"                     /*Department code*/
        sic_bran.uwm100.cntry   = "TH"                    /*Country where risk is situated*/
        sic_bran.uwm100.agent   = nv_agent                /*Agent's Ref. No.*/
        sic_bran.uwm100.poltyp  = nv_poltyp               /*Policy Type*/
        sic_bran.uwm100.insref  = "COMP"                  /*Insured's Ref. No.*/
        /* ------------------------------- */
        sic_bran.uwm100.ntitle  = nv_title                /*Title for Name Mr/Mrs/etc*/
        sic_bran.uwm100.fname   = ""                      /*First Name*/
        sic_bran.uwm100.name1   = nv_insname1             /*Name of Insured Line 1*/
        sic_bran.uwm100.name2   = ""                      /*Name of Insured Line 2*/
        sic_bran.uwm100.name3   = ""                      /*Name of Insured Line 3*/
        sic_bran.uwm100.addr1   = wgenerage.addr1         /*Address 1*/
        sic_bran.uwm100.addr2   = wgenerage.addr2         /*Address 2*/
        sic_bran.uwm100.addr3   = wgenerage.addr3         /*Address 3*/
        sic_bran.uwm100.addr4   = wgenerage.addr4         /*Address 4*/
        sic_bran.uwm100.comdat  = wgenerage.comdat        /*Cover Commencement Date*/
        sic_bran.uwm100.expdat  = wgenerage.expdat        /*Expiry Date*/
        sic_bran.uwm100.accdat  = wgenerage.accdat        /*Acceptance Date*/
        sic_bran.uwm100.trndat  = nv_trndat               /*Transaction Date*/
        sic_bran.uwm100.fstdat  = nv_trndat               /*First Issue Date of Policy*/
        sic_bran.uwm100.tranty  = "N"                     /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.undyr   = nv_undyr                /*Underwriting Year*/
        sic_bran.uwm100.acno1   = nv_acno1                /*Account no. 1*/
        sic_bran.uwm100.instot  = 1                       /*Total No. of Instalments*/
        sic_bran.uwm100.trty11  = "M".                    /*A50-0202 Shukiat T. modi on 14/08/2007*/
        /* -------------------------------- */

      ASSIGN
        sic_bran.uwm100.rstp_t  = wgenerage.stamp         /*Risk Level Stamp, Tran. Total*/
        sic_bran.uwm100.rtax_t  = wgenerage.tax           /*Risk Level Tax, Tran. Total*/
        sic_bran.uwm100.prem_t  = wgenerage.prem          /*Premium Due, Tran. Total*/
        sic_bran.uwm100.com1_t  = nv_com1_t               /*Commission 1, Tran. Total*/
        /* ------------------------------- */
        sic_bran.uwm100.gap_p   = wgenerage.prem          /*Gross Annual Prem, Pol. Total*/
        /* ------------------------------- */
        sic_bran.uwm100.drnoae  = YES                     /*Dr/Cr Note No. (A/E)*/
        sic_bran.uwm100.insddr  = NO                      /*Print Insd. Name on DrN*/
        sic_bran.uwm100.no_sch  = 1                       /*No. to print, Schedule*/
        sic_bran.uwm100.no_dr   = 1                       /*No. to print, Dr/Cr Note*/
        sic_bran.uwm100.no_ri   = 0                       /*No. to print, RI Appln*/
        sic_bran.uwm100.no_cer  = 0                       /*No. to print, Certificate*/
        sic_bran.uwm100.li_sch  = YES                     /*Print Later/Imm., Schedule*/
        sic_bran.uwm100.li_dr   = YES                     /*Print Later/Imm., Dr/Cr Note*/
        sic_bran.uwm100.li_ri   = YES                     /*Print Later/Imm., RI Appln,*/
        sic_bran.uwm100.li_cer  = YES                     /*Print Later/Imm., Certificate*/
        /* ------------------------------- */
        sic_bran.uwm100.scform  = ""                      /*Schedule Format*/
        sic_bran.uwm100.enform  = ""                      /*Endt. Format (Full/Abbr/Blank)*/
        sic_bran.uwm100.apptax  = YES                     /*Apply risk level tax (Y/N)*/
        sic_bran.uwm100.recip  = "N"                      /*Reciprocal (Y/N/C)*/
        sic_bran.uwm100.short   = YES                     /*Short Term Rates*/
        /*          */
        sic_bran.uwm100.usrid   = USERID(LDBNAME(1))      /*User Id  */
        sic_bran.uwm100.entdat  = TODAY                   /*Entered Date*/
        sic_bran.uwm100.enttim  = STRING(TIME,"HH:MM:SS") /*Entered Time*/
        sic_bran.uwm100.prog    = "WGWIMP72"              /*Program Id that input record*/
        /*          */
        sic_bran.uwm100.polsta  = "IF"                    /*Policy Status*/
        sic_bran.uwm100.langug  = "T"                     /*Language */
        /* ------------------------------- */
        sic_bran.uwm100.sigr_p  = 0                       /*SI Gross Pol. Total*/
        sic_bran.uwm100.acctim  = "00:00"                 /*Acceptance Time*/
        sic_bran.uwm100.agtref  = ""                      /*Agents Closing Reference*/
        sic_bran.uwm100.sckno   = 0                       /*sticker no.*/
        sic_bran.uwm100.anam1   = ""                      /*Alternative Insured Name 1*/
        sic_bran.uwm100.sirt_p  = 0                       /*SI RETENTION Pol. total*/
        sic_bran.uwm100.anam2   = ""                      /*Alternative Insured Name 2*/
        sic_bran.uwm100.gstrat  =  7                      /*GST Rate % (TAX %) */
        sic_bran.uwm100.gstae   = YES                     /*GST A/E  */
        sic_bran.uwm100.nr_pol  = NO                      /*New Policy No. (Y/N)*/
        sic_bran.uwm100.issdat  = TODAY                   /*Issue date*/
        /*sic_bran.uwm100.endern  = TODAY                 /*End Date of Earned Premium*/ == Comment By Chutikarn A53-0015 ==*/
        sic_bran.uwm100.endern  = ?                       /*Receipt Date*/  /*== Add By Chutikarn A53-0015 ==*/
        sic_bran.uwm100.docno1  = sicuw.uwm100.docno1     /*Note Add จ๊า*/

        sic_bran.uwm100.sch_p   = NO.                     /*Schedule Printed*/
        sic_bran.uwm100.drn_p   = NO.                     /*Dr/Cr Note Printed*/

      IF sic_bran.uwm100.docno1 <> "" THEN
      ASSIGN
         sic_bran.uwm100.sch_p  = YES                     /*Schedule Printed*/
         sic_bran.uwm100.drn_p  = YES.                    /*Dr/Cr Note Printed*/

      IF sic_bran.uwm100.prem_t =  0  THEN
        ASSIGN
          sic_bran.uwm100.sch_p  = NO                      /*Schedule Printed*/
          sic_bran.uwm100.drn_p  = NO.                     /*Dr/Cr Note Printed*/
      
      
      /* ------------------------------- */
      /***--- เงื่อนไขของการ Set Class รถ ---***/
      /***--- จากเบี้ย ---***/
      
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

      /***--- End Set Class ---***/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_uwm120 C-Win 
PROCEDURE Proc_uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
      /* ------------ RISK HEADER ------------ */
      FIND sic_bran.uwm120 WHERE
           sic_bran.uwm120.policy = wgenerage.policy AND
           sic_bran.uwm120.rencnt = nv_rencnt        AND
           sic_bran.uwm120.endcnt = nv_endcnt        AND
           sic_bran.uwm120.riskgp = 0                AND
           sic_bran.uwm120.riskno = 1                AND
           sic_bran.uwm120.bchyr  = nv_batchyr       AND 
           sic_bran.uwm120.bchno  = nv_batchno       AND
           sic_bran.uwm120.bchcnt = nv_batcnt                  
      NO-ERROR NO-WAIT.
      IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
        IF LOCKED sic_bran.uwm120 THEN DO:
          nv_check = "ERROR".
          MESSAGE "พบข้อมูลมีอยู่แล้วที่ Risk Header (UWM120)".
          ASSIGN
          wgenerage.rec_status  = "N"
          wgenerage.rec_comment = wgenerage.rec_comment + "พบข้อมูลมีอยู่แล้วที่ Risk Header (UWM120) | ".
          NEXT.
        END.

/***--- A50-0130 ---***/
/***--- Note Block Not Show ---***/
/*         MESSAGE "CREATE NEW RECORD Risk Header (UWM120)" */
/*                 wgenerage.policy.                        */

        CREATE sic_bran.uwm120.
      END.

/***--- A50-0130 ---***/
/***--- Shukiat T. Block ---***/
/*       ELSE DO:                                       */
/*         HIDE MESSAGE NO-PAUSE.                       */
/*         MESSAGE "UPDATE RECORD Risk Header (UWM120)" */
/*                 wgenerage.policy.                    */
/*       END.                                           */

      ASSIGN
        sic_bran.uwm120.policy   = wgenerage.policy      /*Policy No.*/
        sic_bran.uwm120.rencnt   = nv_rencnt             /*Renewal Count*/
        sic_bran.uwm120.endcnt   = nv_endcnt             /*Endorsement Count*/
        sic_bran.uwm120.riskgp   = 0                     /*Risk Group*/
        sic_bran.uwm120.riskno   = 1                     /*Risk No.*/
        sic_bran.uwm120.fptr01   = 0  sic_bran.uwm120.bptr01 = 0  /*uwd120 Risk Upper Text*/
        sic_bran.uwm120.fptr02   = 0  sic_bran.uwm120.bptr02 = 0  /*uwd121 Risk Lower Text*/
        sic_bran.uwm120.fptr03   = 0  sic_bran.uwm120.bptr03 = 0  /*uwd123 Borderau Text*/
        sic_bran.uwm120.fptr04   = 0  sic_bran.uwm120.bptr04 = 0  /*uwd125 Risk Clauses*/
        sic_bran.uwm120.fptr08   = 0  sic_bran.uwm120.bptr08 = 0  /*uwd124 Risk Endt. Text*/
        sic_bran.uwm120.fptr09   = 0  sic_bran.uwm120.bptr09 = 0  /*uwd126 Risk Endt. Clause*/
        sic_bran.uwm120.class    = nv_class              /*Business Class Code*/
        sic_bran.uwm120.sicurr   = "BHT"                 /*Sum Insured Currency*/
        sic_bran.uwm120.siexch   = 1                     /*Sum Insured Exchange Rate*/
        sic_bran.uwm120.r_text   = ""                    /*Standard Risk Text Ref. No.*/
        sic_bran.uwm120.bchyr    = nv_batchyr 
        sic_bran.uwm120.bchno    = nv_batchno 
        sic_bran.uwm120.bchcnt   = nv_batcnt  

        /*
        uwm120.r_text   = "IN1"                 /*Standard Risk Text Ref. No.*/
        */
        sic_bran.uwm120.rskdel   = NO                    /*Risk Deleted (Y/N)*/
        sic_bran.uwm120.styp20   = ""                    /*Statistic Type Codes (4 x 20)*/
        sic_bran.uwm120.sval20   = ""                    /*Statistic Value Codes (4 x 20)*/
        sic_bran.uwm120.gap_r    = wgenerage.prem        /*Gross Annual Prem., Risk Total*/
        sic_bran.uwm120.dl1_r    = 0                     /*Discount/Loading 1, Risk Total*/
        sic_bran.uwm120.dl2_r    = 0                     /*Discount/Loading 2, Risk Total*/
        sic_bran.uwm120.dl3_r    = 0                     /*Discount/Loading 3, Risk Total*/
        sic_bran.uwm120.rstp_r   = wgenerage.stamp       /*Risk Level Stamp, Risk Total*/
        sic_bran.uwm120.rfee_r   = 0                     /*Risk Level Fee, Risk Total*/
        sic_bran.uwm120.rtax_r   = wgenerage.tax         /*Risk Level Tax, Risk Total*/
        sic_bran.uwm120.prem_r   = wgenerage.prem        /*Premium Due, Risk Total*/
        sic_bran.uwm120.com1_r   = nv_com1_t             /*Commission 1, Risk Total*/
        sic_bran.uwm120.com2_r   = 0                     /*Commission 2, Risk Total*/
        sic_bran.uwm120.com3_r   = 0                     /*Commission 3, Risk Total*/
        sic_bran.uwm120.com4_r   = 0                     /*Commission 4, Risk Total*/
        sic_bran.uwm120.com1p    = nv_com1p              /*Commission 1 %*/
        sic_bran.uwm120.com2p    = 0                     /*Commission 2 %*/
        sic_bran.uwm120.com3p    = 0                     /*Commission 3 %*/
        sic_bran.uwm120.com4p    = 0                     /*Commission 4 %*/
        sic_bran.uwm120.com1ae   = NO                    /*Commission 1 (A/E)*/
        sic_bran.uwm120.com2ae   = YES                   /*Commission 2 (A/E)*/
        sic_bran.uwm120.com3ae   = YES                   /*Commission 3 (A/E)*/
        sic_bran.uwm120.com4ae   = YES                   /*Commission 4 (A/E)*/
        sic_bran.uwm120.rilate   = NO                    /*RI to Enter Later (Y/N)*/
        sic_bran.uwm120.sigr     = 0                     /*nv_si Sum Insured, Gross*/
        sic_bran.uwm120.sico     = 0                     /*Sum Insured, Coinsurance*/
        sic_bran.uwm120.sist     = nv_sist_p             /*Sum Insured, Statutory*/
        sic_bran.uwm120.sifac    = 0                     /*Sum Insured, Facultative*/
        sic_bran.uwm120.sitty    = nv_sity_p             /*Sum Insured, Treaty*/
        sic_bran.uwm120.siqs     = 0                     /*Sum Insured, Quota Share*/
        sic_bran.uwm120.pdco     = 0                     /*Premium Due, Coinsurance*/
        sic_bran.uwm120.pdst     = nv_pdst_p             /*Premium Due, Statutory*/
        sic_bran.uwm120.pdfac    = 0                     /*Premium Due, Facultative*/
        sic_bran.uwm120.pdtty    = 0                     /*Premium Due, Treaty*/
        sic_bran.uwm120.pdqs     = 0                     /*Premium Due, Quota Share*/
        sic_bran.uwm120.comco    = 0                     /*Commission, Coinsurance*/
        sic_bran.uwm120.comst    = nv_cost_p             /*Commission, Statutory*/
        sic_bran.uwm120.comfac   = 0                     /*Commission, Facultative*/
        sic_bran.uwm120.comtty   = 0                     /*Commission, Treaty*/
        sic_bran.uwm120.comqs    = 0                     /*Commission, Quota Share*/
        sic_bran.uwm120.stmpae   = NO                    /*Risk Level Stamp (A/E)*/
        sic_bran.uwm120.feeae    = YES                   /*Risk Level Fee (A/E)*/
        sic_bran.uwm120.taxae    = NO                    /*Risk Level Tax (A/E)*/
        sic_bran.uwm120.siret    = 0      .              /*SI Retention*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm130 C-Win 
PROCEDURE proc_uwm130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
      /* ------------ INSURED ITEM ------------ */
      /* หา   T A R I F F  ของ Line 72 */
      FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
           sicsyac.xmm016.class = nv_class
      NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAILABLE xmm016 THEN DO:
        MESSAGE COLOR YELLOW/RED
          "Not on Business Classes:" nv_class
          "on Filename xmm016".
        ASSIGN
        wgenerage.rec_status  = "N"
        wgenerage.rec_comment = wgenerage.rec_comment + "Not on Business Classes:" + nv_class + "on Filename xmm016 | ".
        NEXT.
      END.

      ASSIGN
        nv_uom8_c   = sicsyac.xmm016.uom8
        nv_uom9_c   = sicsyac.xmm016.uom9
        nv_uom8_v   = sicsyac.xmm016.si_d_t[8]
        nv_uom9_v   = sicsyac.xmm016.si_d_t[9].
      /* -------------------------------------------- */
      /***--- Sic_bran.Uwm130 ---***/

      FIND sic_bran.uwm130 WHERE
           sic_bran.uwm130.policy = wgenerage.policy AND
           sic_bran.uwm130.rencnt = 0                AND
           sic_bran.uwm130.endcnt = 0                AND
           sic_bran.uwm130.riskgp = 0                AND
           sic_bran.uwm130.riskno = 1                AND
           sic_bran.uwm130.itemno = 1                AND
           sic_bran.uwm130.bchyr  = nv_batchyr       AND 
           sic_bran.uwm130.bchno  = nv_batchno       AND 
           sic_bran.uwm130.bchcnt = nv_batcnt                     
      NO-ERROR NO-WAIT.
      IF NOT AVAILABLE sic_bran.uwm130 THEN DO:
        IF LOCKED sic_bran.uwm130 THEN DO:
          MESSAGE "พบข้อมูลกำลังถูกใช้อยู่ Insured Item (UWM130)"
                  wgenerage.policy "ไม่สามารถ Generage ได้.".
          ASSIGN 
          wgenerage.rec_status  = "N"
          wgenerage.rec_comment = wgenerage.rec_comment + "พบข้อมูลกำลังถูกใช้อยู่ Insured Item (UWM130)" +
                                  wgenerage.policy  + "ไม่สามารถ Generage ได้ | ".
          NEXT.
        END.
/***--- A50-0130 ---***/
/***--- Shukiat T. Block on 17/05/2007 ---***/
/*         HIDE MESSAGE NO-PAUSE.                                           */
/*         BELL. BELL. BELL.                                                */
/*         MESSAGE "Generage ข้อมูลInsured Item (UWM130)" wgenerage.policy. */

        CREATE sic_bran.uwm130.
      END.
/***--- A50-0130 ---***/
/***--- Shukiat T. Block on 17/05/2007 ---***/
/*       ELSE DO:                                                   */
/*         HIDE MESSAGE NO-PAUSE.                                   */
/*         MESSAGE "Update Insured Item (UWM130)" wgenerage.policy. */
/*       END.                                                       */

      ASSIGN
        sic_bran.uwm130.policy    = wgenerage.policy   /*Policy No.*/
        sic_bran.uwm130.rencnt    = 0                  /*Renewal Count*/
        sic_bran.uwm130.endcnt    = 0                  /*Endorsement Count*/
        sic_bran.uwm130.riskgp    = 0                  /*Risk Group*/
        sic_bran.uwm130.riskno    = 1                  /*Risk No.*/
        sic_bran.uwm130.itemno    = 1                  /*Item No.*/
        sic_bran.uwm130.i_text    = ""                 /*Std. Item Text Ref. No.*/
        sic_bran.uwm130.uom1_c    = ""                 /*UOM 1 Code*/
        /***--- Batch Detail ---***/
        sic_bran.uwm130.bchyr     = nv_batchyr         /* batch Year */      
        sic_bran.uwm130.bchno     = nv_batchno         /* bchno    */        
        sic_bran.uwm130.bchcnt    = nv_batcnt          /* bchcnt     */    
        /*
        uwm130.i_text    = "IN1"              /*Std. Item Text Ref. No.*/
        uwm130.uom1_c    = "SI"               /*UOM 1 Code*/
        */
        sic_bran.uwm130.uom2_c    = ""                 /*UOM 2 Code*/
        sic_bran.uwm130.uom3_c    = ""                 /*UOM 3 Code*/
        sic_bran.uwm130.uom4_c    = ""                 /*UOM 4 Code*/
        sic_bran.uwm130.uom5_c    = ""                 /*UOM 5 Code*/
        sic_bran.uwm130.uom6_c    = ""                 /*UOM 6 Code*/
        sic_bran.uwm130.uom7_c    = ""                 /*UOM 7 Code*/
        sic_bran.uwm130.uom1_v    = 0                  /*UOM 1 Value*/
        sic_bran.uwm130.uom2_v    = 0                  /*UOM 2 Value*/
        sic_bran.uwm130.uom3_v    = 0                  /*UOM 3 Value*/
        sic_bran.uwm130.uom4_v    = 0                  /*UOM 4 Value*/
        sic_bran.uwm130.uom5_v    = 0                  /*UOM 5 Value*/
        sic_bran.uwm130.uom6_v    = 0                  /*UOM 6 Value*/
        sic_bran.uwm130.uom7_v    = 0                  /*UOM 7 Value*/
        sic_bran.uwm130.uom1_u    = ""                 /*UOM 1 Unlimited*/
        sic_bran.uwm130.uom2_u    = ""                 /*UOM 2 Unlimited*/
        sic_bran.uwm130.uom3_u    = ""                 /*UOM 3 Unlimited*/
        sic_bran.uwm130.uom4_u    = ""                 /*UOM 4 Unlimited*/
        sic_bran.uwm130.uom5_u    = ""                 /*UOM 5 Unlimited*/
        sic_bran.uwm130.uom6_u    = ""                 /*UOM 6 Unlimited*/
        sic_bran.uwm130.uom7_u    = ""                 /*UOM 7 Unlimited*/
        sic_bran.uwm130.dl1per    = 0                  /*Discount/Loading 1 %*/
        sic_bran.uwm130.dl2per    = 0                  /*Discount/Loading 2 %*/
        sic_bran.uwm130.dl3per    = 0                  /*Discount/Loading 3 %*/
        sic_bran.uwm130.fptr01    = 0  sic_bran.uwm130.bptr01 = 0  /*uwd130 Item Upper Text*/
        sic_bran.uwm130.fptr02    = 0  sic_bran.uwm130.bptr02 = 0  /*uwd131 Item Lower Text*/
        sic_bran.uwm130.fptr03    = 0  sic_bran.uwm130.bptr03 = 0  /*uwd132 Cover & Premium*/
        sic_bran.uwm130.fptr04    = 0  sic_bran.uwm130.bptr04 = 0  /*uwd134 Item Endt. Text*/
        sic_bran.uwm130.fptr05    = 0  sic_bran.uwm130.bptr05 = 0  /*uwd136 Item Endt. Clause*/
        sic_bran.uwm130.styp20    = ""                 /*Statistic Type Codes (4 x 20)*/
        sic_bran.uwm130.sval20    = ""                 /*Statistic Value Codes (4 x 20)*/
        sic_bran.uwm130.itmdel    = NO                 /*Item Deleted*/
        sic_bran.uwm130.uom8_c    = nv_uom8_c          /*UOM 8 Code*/
        sic_bran.uwm130.uom8_v    = nv_uom8_v          /*UOM 8 Value*/
        sic_bran.uwm130.uom9_c    = nv_uom9_c          /*UOM 9 Code*/
        sic_bran.uwm130.uom9_v    = nv_uom9_v          /*UOM 9 Value*/
        sic_bran.uwm130.prem_item = 0          .       /*Premium Due,item total*/

      
      /***---- 132 ---***/
      FIND sic_bran.uwd132 WHERE
           sic_bran.uwd132.policy = wgenerage.policy AND
           sic_bran.uwd132.rencnt = 0                AND
           sic_bran.uwd132.endcnt = 0                AND
           sic_bran.uwd132.riskgp = 0                AND
           sic_bran.uwd132.riskno = 1                AND
           sic_bran.uwd132.itemno = 1                AND
           sic_bran.uwd132.bchyr  = nv_batchyr       AND
           sic_bran.uwd132.bchno  = nv_batchno       AND
           sic_bran.uwd132.bchcnt = nv_batcnt 

      NO-ERROR NO-WAIT.
      IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
        IF LOCKED sic_bran.uwd132 THEN DO:
          MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wgenerage.policy
                  "ไม่สามารถ Generage ข้อมูลได้".
          ASSIGN 
          wgenerage.rec_status  = "N"
          wgenerage.rec_comment = wgenerage.rec_comment + "พบกำลังใช้งาน Insured (UWD132)" + wgenerage.policy +
                                  "ไม่สามารถ Generage ข้อมูลได้ | ".
          NEXT.
        END.

        CREATE sic_bran.uwd132.
      END.
/*       ELSE DO:                                              */
/*         HIDE MESSAGE NO-PAUSE.                              */
/*         MESSAGE "UPDATE Insured (UWD132)" wgenerage.policy. */
/*       END.                                                  */

      ASSIGN
        sic_bran.uwd132.bencod  = "COMP"            /*Benefit Code*/
        sic_bran.uwd132.benvar  = ""                /*Benefit Variable*/
        sic_bran.uwd132.rate    = 0                 /*Premium Rate %*/
        sic_bran.uwd132.gap_ae  = NO                /*GAP A/E Code*/
        sic_bran.uwd132.gap_c   = nv_prem_t         /*GAP, per Benefit per Item*/
        sic_bran.uwd132.dl1_c   = 0                 /*Disc./Load 1,p. Benefit p.Item*/
        sic_bran.uwd132.dl2_c   = 0                 /*Disc./Load 2,p. Benefit p.Item*/
        sic_bran.uwd132.dl3_c   = 0                 /*Disc./Load 3,p. Benefit p.Item*/
        sic_bran.uwd132.pd_aep  = "E"               /*Premium Due A/E/P Code*/
        sic_bran.uwd132.prem_c  = nv_prem_t         /*PD, per Benefit per Item*/
        sic_bran.uwd132.fptr    = 0                 /*Forward Pointer*/
        sic_bran.uwd132.bptr    = 0                 /*Backward Pointer*/
        sic_bran.uwd132.policy  = wgenerage.policy  /*Policy No. - uwm130*/
        sic_bran.uwd132.rencnt  = 0                 /*Renewal Count - uwm130*/
        sic_bran.uwd132.endcnt  = 0                 /*Endorsement Count - uwm130*/
        sic_bran.uwd132.riskgp  = 0                 /*Risk Group - uwm130*/
        sic_bran.uwd132.riskno  = 1                 /*Risk No. - uwm130*/
        sic_bran.uwd132.itemno  = 1                 /*Insured Item No. - uwm130*/
        sic_bran.uwd132.rateae  = NO                /*Premium Rate % A/E Code*/
        sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)    /*First uwd132 Cover & Premium*/
        sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132)    /*Last  uwd132 Cover & Premium*/
        sic_bran.uwd132.bchyr   = nv_batchyr  
        sic_bran.uwd132.bchno   = nv_batchno  
        sic_bran.uwd132.bchcnt  = nv_batcnt .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_uwm301 C-Win 
PROCEDURE Proc_uwm301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
      /* ------------: Motor Vehicle :------------ */
      /*Vehicle Registration char*/

      nv_vehreg = "".
      IF wgenerage.vehreg = "ป้ายแดง" OR 
         wgenerage.vehreg = "ปด"      OR
         wgenerage.vehreg = "-"       OR
         wgenerage.vehreg = ""
      THEN DO:    

        IF TRIM(wgenerage.cha_no) = "" THEN
          nv_vehreg = wgenerage.vehreg.
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
      ELSE nv_vehreg = wgenerage.vehreg.

      nv_modcod = "".
           IF INDEX(wgenerage.makdes,"Yamaha")   <> 0 THEN nv_modcod = "YA00".
      ELSE IF INDEX(wgenerage.makdes,"Suzuki")   <> 0 THEN nv_modcod = "ZU00".
      ELSE IF INDEX(wgenerage.makdes,"Honda")    <> 0 THEN nv_modcod = "HO00".
      ELSE IF INDEX(wgenerage.makdes,"Kawasaki") <> 0 THEN nv_modcod = "KA03".
      ELSE IF INDEX(wgenerage.makdes,"Tiger")    <> 0 THEN nv_modcod = "TI01".
      ELSE DO:
        FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE
                   sicsyac.xmm102.moddes BEGINS wgenerage.makdes
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmm102 THEN nv_modcod = sicsyac.xmm102.modcod.
      END.

      FIND sic_bran.uwm301 WHERE
           sic_bran.uwm301.policy = wgenerage.policy AND
           sic_bran.uwm301.rencnt = 0                AND
           sic_bran.uwm301.endcnt = 0                AND
           sic_bran.uwm301.riskgp = 0                AND
           sic_bran.uwm301.riskno = 1                AND
           sic_bran.uwm301.itemno = 1                AND
           sic_bran.uwm301.bchyr  = nv_batchyr       AND 
           sic_bran.uwm301.bchno  = nv_batchno       AND 
           sic_bran.uwm301.bchcnt = nv_batcnt                     
      NO-ERROR NO-WAIT.
      IF  NOT AVAILABLE sic_bran.uwm301 THEN DO:
        IF LOCKED sic_bran.uwm301 THEN DO:
          MESSAGE "กรมธรรม์ Motor Vehicle "
                  wgenerage.policy 
                  "นี้ถูกใช้งานอยู่ ไม่สามารถGenerageได้".
          nv_check = "ERROR".
          ASSIGN
          wgenerage.rec_status  = "N"
          wgenerage.rec_comment = wgenerage.rec_comment + "กรมธรรม์ Motor Vehicle " +              
                                  wgenerage.policy      +                  
                                  "นี้ถูกใช้งานอยู่ ไม่สามารถGenerageได้ | ".
          NEXT.
        END.
/*         HIDE MESSAGE NO-PAUSE.                              */
/*         MESSAGE "(sic_bran.UWM301) Generage Motor Vehicle " */
/*                   wgenerage.policy.                         */
        CREATE sic_bran.uwm301.       
        CREATE brstat.Detaitem.  
      END.
/*    ELSE DO:                                   */
/*                                              */
/*     HIDE MESSAGE NO-PAUSE.                   */
/*     MESSAGE "(UWM301) Update Motor Vehicle " */
/*               wgenerage.policy.              */
/*    END.                                       */
      ASSIGN
        sic_bran.uwm301.policy   = wgenerage.policy       /*Policy No.           char*/
        sic_bran.uwm301.rencnt   = 0                      /*Renewal Count        inte*/
        sic_bran.uwm301.endcnt   = 0                      /*Endorsement Count    inte*/
        sic_bran.uwm301.riskgp   = 0                      /*Risk Group           inte*/
        sic_bran.uwm301.riskno   = 1                      /*Risk No.             inte*/
        sic_bran.uwm301.itemno   = 1                      /*Item No.             inte*/
        /* --------------------------*/
        sic_bran.uwm301.covcod   = "T"                    /*Cover Type Code      char*/
        sic_bran.uwm301.modcod   = nv_modcod              /*Make/Model Code      char*/
        sic_bran.uwm301.bchyr    = nv_batchyr
        sic_bran.uwm301.bchno    = nv_batchno
        sic_bran.uwm301.bchcnt   = nv_batcnt 

        /*
        uwm301.vehreg   = wgenerage.vehreg       /*Vehicle Registration char*/
        */
        sic_bran.uwm301.vehreg   = nv_vehreg
        sic_bran.uwm301.eng_no   = ""                     /*Engine No.           char*/
        sic_bran.uwm301.cha_no   = wgenerage.cha_no       /*Chassis No.          char*/
        sic_bran.uwm301.yrmanu   = YEAR(wgenerage.comdat) /*Year of Manufacture  inte*/
        sic_bran.uwm301.vehuse   = wgenerage.vehusg       /*Vehicle Usage Code   char*/
        sic_bran.uwm301.ncbyrs   = 0                      /*NCB Years            inte*/
        sic_bran.uwm301.ncbper   = 0                      /*NCB Percent          deci-2*/
        sic_bran.uwm301.tariff   = "9"                    /*Tariff               char*/
        /* --------------------------*/
        sic_bran.uwm301.moddes   = wgenerage.makdes       /*Vehicle Make/Model   char*/
        sic_bran.uwm301.body     = wgenerage.body         /*Vehicle Body Type    char*/
        /*
        uwm301.engine   = wgenerage.engine       /*Vehicle Engine CC's  inte*/
        */
        sic_bran.uwm301.tons     = 0                      /*Vehicle Tonage       deci-2*/
        sic_bran.uwm301.seats    = 0                      /*No. of Seats         inte*/
        sic_bran.uwm301.vehgrp   = "1"                    /*Vehicle Group        char*/
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

        /***--- A50-0165 Shukiat T. ---***/
        /*---Comment BY amparat --
        /***--- Add on 16/07/2007   ---***/
        IF SUBSTR(wgenerage.sticker,1,2) = "02" AND INTE(nv_sticker) <> 0 THEN 
             uwm301.drinam[9] = "STKNO:" + wgenerage.sticker. 
        ELSE uwm301.drinam[9] = "".
        /***--- End Shukiat T. A50-0165 ---***/
         ---Comment BY amparat --*/
       /*--STR Amparat C. A51-0253---*/        
        IF wgenerage.sticker <> " " THEN do:
           IF SUBSTRING(wgenerage.sticker,1,1) = "2" THEN  uwm301.drinam[9] = "STKNO:" + "0" + wgenerage.sticker. 
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
        /*--END Amparat C. A51-0253---*/
      /*
        MESSAGE 
        PDBNAME(1)  LDBNAME(1)  SKIP
        PDBNAME(2)  LDBNAME(2)  SKIP
        PDBNAME(3)  LDBNAME(3)  SKIP
        VIEW-AS ALERT-BOX.          
        

        MESSAGE "CREATE DETAITEM"   SKIP         
            stat.detaitem.policy    SKIP 
            stat.Detaitem.rencnt    SKIP 
            stat.Detaitem.endcnt    SKIP 
            stat.Detaitem.riskno    SKIP 
            stat.Detaitem.itemno    SKIP 
            stat.detaitem.serailno  SKIP 
            stat.detaitem.seqno     SKIP 
            stat.detaitem.seqno2    VIEW-AS ALERT-BOX.*/



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

