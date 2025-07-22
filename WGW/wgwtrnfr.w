&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
       Narin  06/10/10   <Assign A52-242>
       
   Create Table : uwm100 , uwm110 , uwm120 , uwm130 , etc
   สรุปหลักการ Connect Database GW  และ Database local 
   1. DATABASE GW  ที่ CONNECT ได้ ให้ทำการ DISCONNECT ออก SIC_BRAN  กับ  BRSTAT
      และ ทำการ Conncet database : gw_safe  &  gw_stat
          sic_bran  
          brstat    --->  gw_stat
   2. DATABASE Local Connect ดังนี้ 
          bransafe --->  -ld  brsic_bran
          brstat   --->  -ld  brstat
       
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

DEF NEW GLOBAL SHARED VAR n_user            AS    CHAR.
DEF NEW GLOBAL SHARED VAR n_passwd          AS    CHAR.

DEF NEW  SHARED VAR gv_id    AS  CHAR FORMAT "X(12)"         NO-UNDO.
DEF             VAR nv_pwd   AS  CHAR FORMAT "X(15)" INIT "" NO-UNDO.

DEFINE NEW SHARED VAR  nv_batchyr   AS INT FORMAT "9999"            INIT 0.
DEFINE NEW SHARED VAR  nv_batcnt    AS INT FORMAT "99"              INIT 0.
DEFINE NEW SHARED VAR  nv_batchno   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.

DEFINE VAR  nv_batprev   AS CHARACTER FORMAT "X(13)"     INIT ""  NO-UNDO.
DEFINE VAR  nv_tmppolrun AS INTEGER   FORMAT "999"       INIT 0. /*Temp Policy Running No.*/
DEFINE VAR  nv_batbrn    AS CHARACTER FORMAT "x(2)"      INIT ""  NO-UNDO. /*Batch Branch*/
DEFINE VAR  nv_tmppol    AS CHARACTER FORMAT "x(16)"     INIT "". /*Temp Policy*/

DEFINE VAR  nv_batrunno  AS INT FORMAT  ">,>>9"          INIT 0.
DEFINE VAR  nv_imppol    AS INT  FORMAT ">>,>>9"         INIT 0.
DEFINE VAR  nv_impprem   AS DECI FORMAT "->,>>>,>>9.99"  INIT 0.

DEF VAR nv_daily     AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.

DEF VAR nv_reccnt    AS  INT  INIT  0.        /*all load record*/
DEF VAR nv_completecnt    AS   INT   INIT  0.  /*complete record */
/*** ADD 30/09/09 ***/
DEFINE VAR  nv_premtot   AS DECI FORMAT "->,>>>,>>>,>>9.99"  INIT 0.  /* เบี้ยสุทธิ ทั้งหมด */
DEFINE VAR  nv_stmptot   AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แสตมป์ทั้งหมด */
DEFINE VAR  nv_taxtot    AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แวตทั้งหมด */

DEFINE VAR  nv_premsuc   AS DECI FORMAT "->,>>>,>>>,>>9.99"  INIT 0.  /* เบี้ยสุทธิ ที่นำเข้าได้ */
DEFINE VAR  nv_stmpsuc   AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แสตมป์ที่นำเข้าได้ */    
DEFINE VAR  nv_taxsuc    AS DECI FORMAT "->>>,>>>,>>9.99"    INIT 0.  /* แวตที่นำเข้าได้ */
/*** ADD 30/09/09 ***/

DEFINE VAR  nv_rectot    AS INT  FORMAT ">>,>>>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ทั้งไฟล์ */
DEFINE VAR  nv_recsuc    AS INT  FORMAT ">>,>>>,>>9"         INIT 0.  /* Display จำนวน ก/ธ ที่นำเข้าได้ */
DEFINE VAR  nv_netprm_t  AS DECI FORMAT "->,>>>,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ทั้งไฟล์ */
DEFINE VAR  nv_netprm_s  AS DECI FORMAT "->,>>>,>>>,>>9.99"  INIT 0.  /* Display เบี้ยรวม ที่นำเข้าได้ */

DEFINE VAR  nv_batflg    AS LOG                            INIT NO.
DEFINE VAR  nv_txtmsg    AS CHAR FORMAT "x(120)"           INIT "".   /* Parameter คู่กับ nv_check */
DEFINE VAR  nv_check     AS CHARACTER                      INITIAL ""  NO-UNDO.
DEFINE VAR  nv_sist_p    AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR  nv_chkstk    AS CHARACTER FORMAT "9999999999999" INITIAL "".             /*A51-0253*/
DEFINE NEW SHARED VAR nvw_sticker AS INTEGER  FORMAT "999999999999" INIT 0 NO-UNDO.  /*A51-0253*/
DEFINE NEW SHARED VAR chr_sticker AS CHAR     FORMAT "X(15)".                        /*A51-0253*/
DEFINE NEW SHARED VAR nv_modulo   AS INT      FORMAT "9".                          /*A50-0165 Shukiat T. Add*/       


def  var  nv_row  as  int  init  0.
/*DEFINE STREAM  ns1.*/ 
DEFINE STREAM  ns2. 
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
/*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"  INITIAL "".

DEFINE            WORKFILE wdelimi   NO-UNDO
       FIELD txt     AS CHARACTER FORMAT "X(1000)" INITIAL "".

/*DEFINE STREAM nfile. */
DEFINE STREAM ndata.
DEFINE STREAM nnotdata.
/*DEFINE STREAM outputdata.*/

DEFINE NEW SHARED STREAM ns1.

DEFINE VAR nv_line      AS INTEGER   INITIAL 0            NO-UNDO.
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

DEFINE NEW SHARED VAR sh_policy  AS CHARACTER FORMAT "X(16)"  INITIAL ""  NO-UNDO.
DEFINE NEW SHARED VAR sh_rencnt  AS INTEGER   FORMAT "999".
DEFINE NEW SHARED VAR sh_endcnt  AS INTEGER   FORMAT "999".
 
DEFINE VAR nv_name    AS CHARACTER FORMAT "X(70)"       INITIAL ""  NO-UNDO.

DEFINE VAR nv_ADDR1   AS CHAR      FORMAT "X(35)"        INIT ""     NO-UNDO.
DEFINE VAR nv_ADDR2   AS CHAR      FORMAT "X(35)"        INIT ""     NO-UNDO.
DEFINE VAR nv_ADDR3   AS CHAR      FORMAT "X(35)"        INIT ""     NO-UNDO.
DEFINE VAR nv_ADDR4   AS CHAR      FORMAT "X(20)"        INIT ""     NO-UNDO.

DEFINE VAR nv_trndat  AS DATE      FORMAT "99/99/9999" INITIAL TODAY NO-UNDO.
DEFINE VAR nv_comdat  AS DATE      FORMAT "99/99/9999"               NO-UNDO.
DEFINE VAR nv_expdat  AS DATE      FORMAT "99/99/9999"               NO-UNDO.

DEFINE VAR nv_total   AS DECIMAL   FORMAT ">>>,>>>,>>9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_count   AS INTEGER   INITIAL 0  NO-UNDO.


DEFINE VAR nv_data     AS CHARACTER FORMAT "X(40)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_notdata  AS CHARACTER FORMAT "X(40)"     INITIAL ""  NO-UNDO.

DEFINE VAR nv_rencnt   AS INTEGER   FORMAT "99"        INITIAL 0   NO-UNDO.
DEFINE VAR nv_endcnt   AS INTEGER   FORMAT "999"       INITIAL 0   NO-UNDO.

DEFINE VAR nv_branch   AS CHARACTER FORMAT "X(02)"     INITIAL ""  NO-UNDO.

DEFINE VAR nv_com1p    AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE VAR nv_com1_t   AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_com1_sum AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_prem_t   AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_stamp    AS DECIMAL   FORMAT ">>>,>>>,>>9.99-"   INITIAL 0.
DEFINE VAR nv_tax      AS DECIMAL   FORMAT ">>>,>>>,>>9.99-"   INITIAL 0.

DEFINE VAR nv_undyr    AS CHARACTER FORMAT "X(04)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_poltyp   AS CHARACTER FORMAT "X(04)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_sticker  AS INTEGER   FORMAT "9999999999999".  /*a51-0253*/
DEFINE VAR nv_sticker1 AS CHARACTER FORMAT "X(15)"     INITIAL ""  NO-UNDO. /*Note Ad on A50-0097 11/05/2007*/ /*a51-0253*/

DEFINE VAR nv_insname1 AS CHARACTER FORMAT "X(70)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_title    AS CHARACTER FORMAT "X(15)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_insref   AS CHARACTER FORMAT "X(7)"  INITIAL ""  NO-UNDO.
DEFINE VAR nv_acno1    AS CHARACTER FORMAT "X(07)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_agent    AS CHARACTER FORMAT "X(07)" INITIAL ""  NO-UNDO.

DEFINE VAR nv_class    AS CHARACTER FORMAT "X(04)" INITIAL ""  NO-UNDO.
DEFINE VAR nv_modcod   AS CHARACTER FORMAT "X(04)" INITIAL ""  NO-UNDO.

DEFINE VAR nv_sity_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_pdst_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_pdty_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.
DEFINE VAR nv_cost_p  AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.

DEFINE VAR nv_uom8_c   AS CHARACTER FORMAT "X(2)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_uom9_c   AS CHARACTER FORMAT "X(2)"    INITIAL ""  NO-UNDO.
DEFINE VAR nv_uom8_v   AS DECIMAL   FORMAT ">>>,>>>,>>9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_uom9_v   AS DECIMAL   FORMAT ">>>,>>>,>>9.99" INITIAL 0 NO-UNDO.

DEFINE VAR nv_opnpol   LIKE sic_bran.uwm100.opnpol INIT "". 

/*---a51-0253---*/
DEF VAR nv_seqno AS INT.
DEF VAR nv_seqno2 AS INT.
/*---a51-0253---*/

DEF VAR nv_fptr       AS   RECID.
DEF VAR nv_bptr       AS   RECID.

DEF NEW SHARED VAR sh_insref LIKE sic_bran.uwm100.insref INIT "". 
DEF NEW SHARED VAR nv_duprec100  AS LOGI INIT NO NO-UNDO. 
DEF NEW SHARED VAR nv_duprec120  AS LOGI INIT NO NO-UNDO.
DEF NEW SHARED VAR nv_duprec301  AS LOGI INIT NO NO-UNDO.

DEF VAR putchr     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_releas  AS LOGI                 INIT NO NO-UNDO.

DEF BUFFER wf_uwd100 FOR sic_bran.uwd100. 
DEF BUFFER wf_uwd102 FOR sic_bran.uwd102.
DEF BUFFER wf_uwd103 FOR sic_bran.uwd103.
DEF BUFFER wf_uwd104 FOR sic_bran.uwd104.
DEF BUFFER wf_uwd105 FOR sic_bran.uwd105.
DEF BUFFER wf_uwd106 FOR sic_bran.uwd106.

DEF VAR nv_output1     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_output2     AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR nv_filename    AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_branch fi_brndes fi_producer ~
fi_proname fi_agent fi_agtname fi_prevbat fi_bchyr fi_usrcnt fi_usrprem ~
BU_OK fi_filename BU_HPBRN BU_HPACNO1 BU_HPAGENT fi_output1 BU_EXIT ~
fi_output4 fi_output2 fi_output3 fi_impcnt fi_premtot fi_bchno ~
fi_completecnt fi_premsuc RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_branch fi_brndes fi_producer ~
fi_proname fi_agent fi_agtname fi_prevbat fi_bchyr fi_usrcnt fi_usrprem ~
fi_filename fi_output1 fi_output4 fi_output2 fi_output3 fi_impcnt ~
fi_premtot fi_bchno fi_completecnt fi_premsuc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BU_EXIT 
     LABEL "EXIT" 
     SIZE 11 BY 1.19
     FONT 6.

DEFINE BUTTON BU_HPACNO1 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "Btn 2" 
     SIZE 4 BY .95
     FGCOLOR 2 FONT 6.

DEFINE BUTTON BU_HPAGENT 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "Btn 3" 
     SIZE 4.5 BY .95
     FONT 6.

DEFINE BUTTON BU_HPBRN 
     IMAGE-UP FILE "WIMAGE/help.bmp":U
     LABEL "Btn 1" 
     SIZE 4 BY .95
     FONT 6.

DEFINE BUTTON BU_OK 
     LABEL "OK" 
     SIZE 11 BY 1.19
     FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(19)":U 
     VIEW-AS FILL-IN 
     SIZE 24.5 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8.5 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output4 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 69 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 21 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 25 BY .95
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 122 BY 2.14
     BGCOLOR 11 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 122 BY 8.1
     BGCOLOR 11 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 122 BY 6.67
     BGCOLOR 11 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 122 BY 3.57
     BGCOLOR 11 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 118.5 BY 2.62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 3.86 COL 33 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 5.05 COL 33 COLON-ALIGNED NO-LABEL
     fi_brndes AT ROW 5.05 COL 53.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 6.24 COL 33 COLON-ALIGNED NO-LABEL
     fi_proname AT ROW 6.24 COL 53.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 7.43 COL 33 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 7.43 COL 53.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 8.62 COL 33 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 8.62 COL 66.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 9.81 COL 33 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 9.81 COL 77 COLON-ALIGNED NO-LABEL
     BU_OK AT ROW 13.86 COL 108
     fi_filename AT ROW 13.14 COL 33 COLON-ALIGNED NO-LABEL
     BU_HPBRN AT ROW 5.05 COL 42.5
     BU_HPACNO1 AT ROW 6.24 COL 49.5
     BU_HPAGENT AT ROW 7.43 COL 49
     fi_output1 AT ROW 14.33 COL 33 COLON-ALIGNED NO-LABEL
     BU_EXIT AT ROW 15.29 COL 108
     fi_output4 AT ROW 11.95 COL 33 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 15.52 COL 33 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 16.71 COL 33 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 18.86 COL 56.5 COLON-ALIGNED NO-LABEL
     fi_premtot AT ROW 18.86 COL 93 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 19.33 COL 14 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 20.05 COL 56.5 COLON-ALIGNED NO-LABEL
     fi_premsuc AT ROW 20.05 COL 93 COLON-ALIGNED NO-LABEL
     "Date of Load :" VIEW-AS TEXT
          SIZE 14 BY 1.19 AT ROW 3.86 COL 19.5
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Batch No :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 19.33 COL 5
          BGCOLOR 11 FGCOLOR 9 FONT 6
     "Output Data Error :" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 15.52 COL 15
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 20.05 COL 73
          BGCOLOR 11 FGCOLOR 9 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 13.14 COL 11.5
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Branchs :" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 5.05 COL 24
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Agent Code :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 7.43 COL 20.5
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Policy Import Total :" VIEW-AS TEXT
          SIZE 19 BY .71 AT ROW 9.81 COL 14
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Output Data Dupicate :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 14.33 COL 11
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Previous Batch No :" VIEW-AS TEXT
          SIZE 19.5 BY .71 AT ROW 8.62 COL 14
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "PROGRAM TRANSFER DATA POLICY LINE 70 , 72 TO GATEWAY" VIEW-AS TEXT
          SIZE 64 BY 1.67 AT ROW 1.48 COL 27.5
          BGCOLOR 11 FGCOLOR 4 FONT 6
     "Total Net Premium Imp :" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 9.81 COL 55
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "File Process :" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 11.95 COL 20
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 16.71 COL 16
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "BHT." VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 9.81 COL 105
          BGCOLOR 11 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1
         SIZE 124.17 BY 21
         FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BHT." VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 20.05 COL 116
          BGCOLOR 11 FGCOLOR 9 FONT 6
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 6.24 COL 17.5
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Total Record :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 18.86 COL 44.5
          BGCOLOR 11 FGCOLOR 9 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17 BY .95 AT ROW 20.05 COL 41.5
          BGCOLOR 11 FGCOLOR 9 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 8.62 COL 55.5
          BGCOLOR 11 FGCOLOR 2 FONT 6
     "Total Net Premium :" VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 18.86 COL 76
          BGCOLOR 11 FGCOLOR 9 FONT 6
     "BHT." VIEW-AS TEXT
          SIZE 5.5 BY .95 AT ROW 18.86 COL 116
          BGCOLOR 11 FGCOLOR 9 FONT 6
     RECT-1 AT ROW 1.24 COL 2
     RECT-2 AT ROW 3.38 COL 2
     RECT-3 AT ROW 11.48 COL 2
     RECT-4 AT ROW 18.1 COL 2
     RECT-5 AT ROW 18.62 COL 3.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1
         SIZE 124.17 BY 21
         FONT 6.


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
         HEIGHT             = 21
         WIDTH              = 124.17
         MAX-HEIGHT         = 21
         MAX-WIDTH          = 124.67
         VIRTUAL-HEIGHT     = 21
         VIRTUAL-WIDTH      = 124.67
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   Custom                                                               */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
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


&Scoped-define SELF-NAME BU_EXIT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_EXIT C-Win
ON CHOOSE OF BU_EXIT IN FRAME fr_main /* EXIT */
DO:
     IF CONNECTED ("brsic_bran")   THEN DISCONNECT brsic_bran.
     IF CONNECTED ("lremote")      THEN DISCONNECT lremote.
    
     APPLY "close" TO THIS-PROCEDURE.
     RETURN NO-APPLY.
     
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_HPACNO1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_HPACNO1 C-Win
ON CHOOSE OF BU_HPACNO1 IN FRAME fr_main /* Btn 2 */
DO:
   DEF   VAR     n_acno       AS  CHAR.
   DEF   VAR     n_agent      AS  CHAR.    
     
   RUN whp\whpacno1(output  n_acno, 
                    output  n_agent).
                                          
     IF  n_acno  <>  ""  THEN  fi_producer =  n_acno.
     
     DISP  fi_producer  WITH FRAME  fr_main.

     APPLY "Entry"  TO  fi_producer.
     RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_HPAGENT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_HPAGENT C-Win
ON CHOOSE OF BU_HPAGENT IN FRAME fr_main /* Btn 3 */
DO:
   DEF   VAR     n_acno       AS  CHAR.
   DEF   VAR     n_agent      AS  CHAR.    
     
   RUN whp\whpacno1(OUTPUT  n_acno,   
                    OUTPUT  n_agent). 
                                          
     IF  n_acno  <>  ""  THEN  fi_agent =  n_acno.
     
     DISP  fi_agent  WITH FRAME  fr_main.

     APPLY "Entry"  TO  fi_agent.
     RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_HPBRN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_HPBRN C-Win
ON CHOOSE OF BU_HPBRN IN FRAME fr_main /* Btn 1 */
DO:
   RUN  whp\whpbran1(INPUT-OUTPUT   fi_branch, 
                     INPUT-OUTPUT   fi_brndes).
                                     
   DISP    fi_branch  fi_brndes  WITH FRAME  fr_main.                                     
   APPLY "Entry"  To  fi_producer.
   RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BU_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BU_OK C-Win
ON CHOOSE OF BU_OK IN FRAME fr_main /* OK */
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
    IF fi_branch = " " THEN DO: 
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
    
    nv_batchyr = INPUT fi_bchyr.
    /*--- Batch No ---*/
      IF nv_batprev = "" THEN DO:  /* เป็นการนำเข้าข้อมูลครั้งแรกของไฟล์นั้นๆ */
         ASSIGN  
          nv_batbrn    = fi_branch.
/*           MESSAGE "fi_producer" fi_producer  SKIP               */
/*                   "nv_batbrn"   nv_batbrn    SKIP               */
/*                   "nv_batchyr"  nv_batchyr   VIEW-AS ALERT-BOX. */
        FIND LAST sic_bran.uzm700 USE-INDEX uzm70001
            WHERE sic_bran.uzm700.acno    = TRIM(fi_producer)  AND
                  sic_bran.uzm700.branch  = TRIM(nv_batbrn) AND
                  sic_bran.uzm700.bchyr   = nv_batchyr
        NO-LOCK NO-ERROR .
        IF AVAIL sic_bran.uzm700 THEN DO:   /*ได้ running 4 หลักหลัง Branch */

          nv_batrunno = sic_bran.uzm700.runno.

          FIND LAST sic_bran.uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10006 ---> sicuw.uzm70102 31/10/2006*/
              WHERE sic_bran.uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") 
          NO-LOCK NO-ERROR.
          IF AVAIL sic_bran.uzm701 THEN DO:
            nv_batcnt = sic_bran.uzm701.bchcnt .
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

        FIND LAST sic_bran.uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10006 ---> sicuw.uzm70102 31/10/2006*/
            WHERE sic_bran.uzm701.bchno = CAPS(nv_batprev)
        NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sic_bran.uzm701 THEN DO:
          MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                + " on file uzm701" .
          APPLY "entry" TO fi_prevbat.
          RETURN NO-APPLY.
        END.
        IF AVAIL sic_bran.uzm701 THEN DO:
          nv_batcnt  = sic_bran.uzm701.bchcnt + 1.
          nv_batchno = CAPS(TRIM(nv_batprev)).

        END.
      END.
/*----------------*/
      
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

/*          MESSAGE "fi_load:"     fi_loaddat  SKIP               */
/*                  "nv_batchyr:"  nv_batchyr  SKIP               */
/*                  "fi_producer:" fi_producer SKIP               */
/*                  "nv_batbrn:"   nv_batbrn   SKIP               */
/*                  "fi_prevbat:"  fi_prevbat  SKIP(1)            */
/*                  "nv_batchno:"  nv_batchno  SKIP               */
/*                  "nv_batcnt:"   nv_batcnt   SKIP               */
/*                  "nv_imppol:"   nv_imppol   SKIP               */
/*                  "nv_impprem:"  nv_impprem  VIEW-AS ALERT-BOX. */

         /***---A490166 Run Batch No. ---***/ 
        RUN wgw\wgwbatch.p    (INPUT        fi_loaddat ,     /* DATE  */
                               INPUT        nv_batchyr ,     /* INT   */
                               INPUT        fi_producer,     /* CHAR  */ 
                               INPUT        nv_batbrn  ,     /* CHAR  */
                               INPUT        fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                               INPUT        "WGWTRN72" ,     /* CHAR  */
                               INPUT-OUTPUT nv_batchno ,     /* CHAR  */
                               INPUT-OUTPUT nv_batcnt  ,     /* INT   */
                               INPUT        nv_imppol  ,     /* INT   */
                               INPUT        nv_impprem       /* DECI  */
                               ).
        ASSIGN
        fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
        
        DISP  fi_bchno   WITH FRAME fr_main.

        IF string(nv_batcnt,"99") > "01" THEN DO:
             RUN wgw\wgwdup72.p  (INPUT-OUTPUT nv_batchno,
                                  INPUT-OUTPUT nv_batcnt ,
                                  INPUT-OUTPUT nv_output1).
        END.

        /***--- Loop Tmimp72.p save ---***/
    MESSAGE COLOR YEL/RED SKIP
            " Confirm Process Data Transfer !!!! " SKIP
            /*" พรบ. 72,73,74 " SKIP                        */
            VIEW-AS ALERT-BOX WARNING BUTTONS YES-NO
            TITLE "Warning Message" UPDATE choice AS LOGICAL.
    IF NOT choice THEN DO:
       MESSAGE COLOR YELLOW "ยกเลิกกระบวนการ Process Data!!!" VIEW-AS ALERT-BOX QUESTION.  
       APPLY "ENTRY" TO fi_producer.
       RETURN NO-APPLY.
    END.
  /*-----A52-0242------*/ 
    ELSE DO:
        IF SUBSTRING(fi_bchno,1,7) <> fi_producer THEN DO:
           MESSAGE "Please Check Producer Code <> Prev Batch"  VIEW-AS ALERT-BOX QUESTION.
           APPLY "ENTRY" TO fi_producer.
           RETURN NO-APPLY.
        END.
  /*-----A52-0242------*/  
  
      ASSIGN
       
       fi_output1   = "C:\SIC_BRAN\TEMP\" +                                              
                      CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")) + ".DUP".  /*DUP*/ 
       
       fi_output2   = "C:\SIC_BRAN\TEMP\" +
                      CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")) + ".ERR". /*ERR*/

       fi_output3   = "C:\SIC_BRAN\TEMP\" +
                      CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")) + ".OK".

       fi_filename  = "C:\SIC_BRAN\TEMP\" +
                      CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")) + ".FUW".

       /**** Comment  
       fi_filename = "C:\SIC_BRAN\TEMP\" +
                           STRING(MONTH(TODAY),"99")    +
                           STRING(DAY(TODAY),"99")      +
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".FUW". 
        ***/   
       DISPLAY fi_output1 fi_output2 fi_output3 fi_filename WITH FRAME fr_main.
        
       RUN proc_chk.
  
/*        MESSAGE "After proc_chk"  SKIP                         */
/*              "nv_rectot"   nv_rectot   SKIP                   */
/*              "nv_recsuc"   nv_recsuc   SKIP                   */
/*              "nv_netprm_s" nv_netprm_s SKIP(1)                */
/*                                                               */
/*              "nv_stampsuc" nv_stmpsuc  SKIP                   */
/*              "nv_taxsuc"   nv_taxsuc   SKIP                   */
/*              "nv_stmptot"  nv_stmptot  SKIP                   */
/*              "nv_taxtot"   nv_taxtot   SKIP(1)                */
/*              "nv_com1p"    nv_com1p    SKIP                   */
/*              "nv_com1_t"   nv_com1_t   SKIP                   */
/*              "nv_com1_sum"   nv_com1_sum   VIEW-AS ALERT-BOX. */
         

        DISP fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAM fr_main.

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
/*                 MESSAGE "+++Batch GW+++"                            */
/*                         "nv_batchyr"  nv_batchyr SKIP               */
/*                         "nv_batchno"  nv_batchno SKIP               */
/*                         "nv_batcnt"   nv_batcnt  SKIP               */
/*                         "nv_batflg"   nv_batflg  VIEW-AS ALERT-BOX. */
    FIND LAST uzm701 USE-INDEX uzm70102 /*Shukiat T. chg Index btm10009 ---> uzm70102 31/10/2006*/
        WHERE uzm701.bchyr   = nv_batchyr AND
              uzm701.bchno   = nv_batchno AND
              uzm701.bchcnt  = nv_batcnt 
    NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
          /***--- ไม่มีการระบุ Tax Stamp ไว้ใน Text File ---***/
        /*uzm701.rec_suc     = nv_recsuc */  /***--- 26-10-2006 change field Name ---***/
          uzm701.recsuc      = nv_recsuc     /***--- 31-10-2006 change field Name ---***/
          uzm701.premsuc     = nv_netprm_s   /*nv_premsuc*/
          uzm701.stampsuc    = nv_stmpsuc
          uzm701.taxsuc      = nv_taxsuc
          
        /*uzm701.rec_tot     = nv_rectot*/   /***--- 26-10-2006 change field Name ---***/
          uzm701.rectot      = nv_rectot     /***--- 26-10-2006 change field Name ---***/
          uzm701.premtot     = nv_netprm_t   /*nv_premtot*/
          uzm701.stamptot    = nv_stmptot
          uzm701.taxtot      = nv_taxtot

          /*-- Commition --*/
          uzm701.com1suc    =   nv_com1_sum
          uzm701.com1tot    =   nv_com1_sum
          
          uzm701.impendtim = STRING(TIME,"HH:MM:SS")
        /*uzm701.sucflg1     = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
          uzm701.impflg      = nv_batflg    /***--- 26-10-2006 change field Name ---***/
        /*uzm701.batchsta    = nv_batflg*/  /***--- 26-10-2006 change field Name ---***/
          uzm701.cnfflg      = nv_batflg    .
         /* YES  สามารถนำเข้าข้อมูลได้หมด ไม่มี error  
            NO   นำเข้าข้อมูลได้ไม่ได้ไม่หมด  */
          
    END.
    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .
    
        IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
        ELSE
             nv_txtmsg = "      Total Net Premium ที่ระบุกับ Success Net Premium ที่เครื่องคำนวณได้ไม่ตรงกัน".

             IF nv_batflg = NO THEN DO:  
                 RUN wgw\wgwrer72.p (INPUT-OUTPUT nv_batchno ,
                                     INPUT-OUTPUT nv_batcnt  ,
                                     INPUT-OUTPUT nv_output2).
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6.

        DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
                "Batch No.   : " nv_batchno             SKIP
                "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please Check Data Again."              

        VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES THEN DO: 
               
            RUN wgw\wgwrep72.p  (INPUT-OUTPUT nv_batchno ,
                                 INPUT-OUTPUT nv_batcnt  ,
                                 INPUT-OUTPUT nv_filename,
                                 INPUT-OUTPUT nv_output2 ).
             
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc:FGCOLOR     = 6 
            fi_bchno:FGCOLOR       = 6.
            
        MESSAGE "Data Process Complete!!!" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.

    FIND FIRST sic_bran.uwm100 WHERE
               sic_bran.uwm100.policy = sh_policy AND
               sic_bran.uwm100.rencnt = sh_rencnt AND
               sic_bran.uwm100.endcnt = sh_endcnt NO-ERROR.
         IF AVAILABLE sic_bran.uwm100 THEN DO:
            ASSIGN 
              sic_bran.uwm100.impflg = nv_batflg
              sic_bran.uwm100.imperr = "".
         END.
    
    RUN proc_screen  .
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
  /*-----A52-0242------*/ 
   END.  /*-- ElSE DO: IF NOT choice THEN DO: --*/
  /*-----A52-0242------*/ 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
   
   fi_agent = INPUT  fi_agent.
   IF fi_agent <> ""    THEN DO:
    
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
             sicsyac.xmm600.acno  =  INPUT fi_agent  
        NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL sicsyac.xmm600 THEN DO:
                 MESSAGE  "Not on Name & Address Master File xmm600" 
                 VIEW-AS ALERT-BOX.
                 APPLY "Entry" TO  fi_agent.
                 RETURN NO-APPLY. 
            END.
            ELSE DO: 
                ASSIGN
                 fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                 fi_agent   =  CAPS(INPUT  fi_agent) 
                 nv_agent   =  fi_agent.            
                
            END. 
    END. 

    DISP  fi_agent  fi_agtname  WITH FRAME  fr_main.
    
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
  IF  INPUT fi_branch  =  ""  THEN DO:
      MESSAGE "กรุณาระบุ Branch Code !!!" VIEW-AS ALERT-BOX.
      APPLY "Entry"  To  fi_branch.
  END.
  ELSE DO:

      FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
           sicsyac.xmm023.branch   =  Input  fi_branch 
           NO-LOCK NO-ERROR NO-WAIT.
           IF NOT AVAIL  sicsyac.xmm023 THEN DO:
                  MESSAGE  "Not on Description Master File xmm023" 
                  VIEW-AS ALERT-BOX.
                  APPLY "Entry"  To  fi_branch.
                  RETURN NO-APPLY.
           END.
      fi_branch  =  CAPS(Input fi_branch) .
      fi_brndes  =  sicsyac.xmm023.bdes.
  END. 

  DISP fi_branch  fi_brndes  WITH FRAME  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  INPUT  fi_loaddat.
  DISP  fi_loaddat  WITH  FRAME  fr_main.
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
                     "Please Check Batch No. Again             " VIEW-AS ALERT-BOX.
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
                    MESSAGE  "Not on Name & Address Master File xmm600" 
                    VIEW-AS ALERT-BOX.
                    APPLY "Entry" TO  fi_producer.
                    RETURN NO-APPLY. 
                END.
                ELSE DO:
                    ASSIGN
                      fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                      fi_producer =  CAPS(INPUT  fi_producer) 
                      nv_ACNO1    =  fi_producer .             
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
     Disp  fi_usrcnt  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem C-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
    fi_usrprem = INPUT fi_usrprem.
    Disp  fi_usrprem  with  frame  fr_main.
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

  RUN wgw/wgwdisgw.p.
  RUN wgw/wgwcongw.p.
  RUN wgw/wgwconbk.p.

/*   MESSAGE "!!!**Display RB-DB-Connect Broker (GW) !!!"  SKIP      */
/*           "LDBNAME(1) "  LDBNAME(1) PDBNAME(1) SKIP               */
/*           "LDBNAME(2) "  LDBNAME(2) PDBNAME(2) SKIP               */
/*           "LDBNAME(3) "  LDBNAME(3) PDBNAME(3) SKIP               */
/*           "LDBNAME(4) "  LDBNAME(4) PDBNAME(4) SKIP               */
/*           "LDBNAME(5) "  LDBNAME(5) PDBNAME(5) SKIP               */
/*           "LDBNAME(6) "  LDBNAME(6) PDBNAME(6) SKIP               */
/*           "LDBNAME(7) "  LDBNAME(7) PDBNAME(7) SKIP               */
/*           "LDBNAME(8) "  LDBNAME(8) PDBNAME(8) SKIP               */
/*           "LDBNAME(9) "  LDBNAME(9) PDBNAME(9) VIEW-AS ALERT-BOX. */
  /********************  T I T L E   F O R  C - W I N  ****************/

 

  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "Wgwtrnfr".
  gv_prog  = "Program Transfer Data Policy Line 70,72 To GW (Head Office)".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/
  ASSIGN
  fi_producer = ""
  fi_agent    = ""
  fi_bchyr    = YEAR(TODAY)
  fi_loaddat  = TODAY .

  DISP fi_producer fi_agent fi_bchyr fi_loaddat WITH FRAME fr_main. 

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
  DISPLAY fi_loaddat fi_branch fi_brndes fi_producer fi_proname fi_agent 
          fi_agtname fi_prevbat fi_bchyr fi_usrcnt fi_usrprem fi_filename 
          fi_output1 fi_output4 fi_output2 fi_output3 fi_impcnt fi_premtot 
          fi_bchno fi_completecnt fi_premsuc 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_loaddat fi_branch fi_brndes fi_producer fi_proname fi_agent 
         fi_agtname fi_prevbat fi_bchyr fi_usrcnt fi_usrprem BU_OK fi_filename 
         BU_HPBRN BU_HPACNO1 BU_HPAGENT fi_output1 BU_EXIT fi_output4 
         fi_output2 fi_output3 fi_impcnt fi_premtot fi_bchno fi_completecnt 
         fi_premsuc RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_chk C-Win 
PROCEDURE Proc_chk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  nv_reccnt   = 0.
  nv_netprm_t = 0.
      
  nv_rectot   = 0.
  nv_premtot  = 0.
  nv_stmptot  = 0.
  nv_taxtot   = 0.
  nv_recsuc   = 0.
  nv_stmpsuc  = 0.
  nv_taxsuc   = 0.
  nv_premsuc  = 0.
  nv_netprm_s = 0. 
  nv_com1p    = 0. 
     
/*       MESSAGE "!!!** 11111 Connect Broker (GW) !!!"  SKIP         */
/*           "LDBNAME(1) "  LDBNAME(1) PDBNAME(1) SKIP               */
/*           "LDBNAME(2) "  LDBNAME(2) PDBNAME(2) SKIP               */
/*           "LDBNAME(3) "  LDBNAME(3) PDBNAME(3) SKIP               */
/*           "LDBNAME(4) "  LDBNAME(4) PDBNAME(4) SKIP               */
/*           "LDBNAME(5) "  LDBNAME(5) PDBNAME(5) SKIP               */
/*           "LDBNAME(6) "  LDBNAME(6) PDBNAME(6) SKIP               */
/*           "LDBNAME(7) "  LDBNAME(7) PDBNAME(7) SKIP               */
/*           "LDBNAME(8) "  LDBNAME(8) PDBNAME(8) SKIP               */
/*           "LDBNAME(9) "  LDBNAME(9) PDBNAME(9) VIEW-AS ALERT-BOX. */


   /*IF CONNECTED ("brsic_bran")    THEN DO:*/
     IF CONNECTED ("brsic_bran") AND CONNECTED ("brstat") THEN DO:
     /*  MESSAGE "Connect DB brsic_bran & lremote"  VIEW-AS ALERT-BOX INFORMATION.*/
        RUN wgw\wgwtrnf1.p (INPUT-OUTPUT fi_impcnt,
                            INPUT-OUTPUT fi_completecnt,
                            INPUT-OUTPUT fi_premtot,
                            INPUT-OUTPUT fi_premsuc,
                            INPUT-OUTPUT nv_batchyr,
                            INPUT-OUTPUT nv_batchno,
                            INPUT-OUTPUT nv_batcnt,
                            INPUT-OUTPUT n_user,
                            INPUT-OUTPUT fi_output4,
                            INPUT-OUTPUT nv_releas,

                            INPUT-OUTPUT nv_reccnt,
                            INPUT-OUTPUT nv_netprm_t,
                            INPUT-OUTPUT nv_rectot,
                            INPUT-OUTPUT nv_premtot,
                            INPUT-OUTPUT nv_stmptot,
                            INPUT-OUTPUT nv_taxtot,
                            INPUT-OUTPUT nv_recsuc,
                            INPUT-OUTPUT nv_stmpsuc,
                            INPUT-OUTPUT nv_taxsuc,
                            INPUT-OUTPUT nv_premsuc,
                            INPUT-OUTPUT nv_netprm_s,
                            INPUT-OUTPUT nv_com1p,
                            INPUT-OUTPUT nv_com1_t,
                            INPUT-OUTPUT nv_com1_sum).

           DISP "UWM101"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM110"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM120"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM130"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM200"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM300"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM301"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM304"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM305"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM306"      @ fi_output4 WITH FRAME fr_main.
           DISP "UWM307"      @ fi_output4 WITH FRAME fr_main.
           DISP "MAILTXT"     @ fi_output4 WITH FRAME fr_main.
           DISP "DETAITEM"    @ fi_output4 WITH FRAME fr_main.
           DISP "XMM600"      @ fi_output4 WITH FRAME fr_main.
           DISP "DEALER CODE" @ fi_output4 WITH FRAME fr_main.
           DISP "VAT100"      @ fi_output4 WITH FRAME fr_main.

    END.
    ELSE DO:
        MESSAGE "Not Connect DB local brsic_bran & brstat"  VIEW-AS ALERT-BOX QUESTION.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_screen C-Win 
PROCEDURE Proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
" Transfer Data COMPULSORY TO GW (V72,V73,V74) " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer   SKIP
"          Agent Code : " fi_agent      SKIP
"  Previous Batch No. : " fi_prevbat   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"   Output Data (Dup) : " fi_output1    SKIP
" Output Data (Error) : " fi_output2    SKIP
"     Batch File Name : " fi_output3    SKIP
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

