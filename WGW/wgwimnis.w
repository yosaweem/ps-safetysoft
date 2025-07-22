&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: WGWIMNIS.W

  Description: Load งาน Extened Warranty for Nissan

  Created: Watsana K. [A56-0235]  Date. 25/07/2013
  
  Connect DB: gw_safe ; gw_stat ; stat ; sicsyac ;sicuw 
  
  Modify By: Watsana K. [A57-0115] Date. 27/03/2014 
            - เพิ่มช่อง vatcode

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

DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO
   FIELD recno      AS CHAR FORMAT "x(4)"                INIT ""  /*  Column : NO. */
   FIELD policy     AS CHAR FORMAT "X(16)"               INIT ""  /*  Column : Policy No.*/
   FIELD comdat     AS CHAR FORMAT "x(10)"               INIT ""  /*  Column : Com Date*/
   FIELD tname      AS CHAR FORMAT "x(10)"               INIT ""  /*  Column : คำนำหน้า */
   FIELD name1      AS CHAR FORMAT "X(120)"              INIT ""  /*  Column : Insured Name*/
   FIELD cpolno     AS CHAR FORMAT "x(10)"               INIT ""  /*  Column : รหัสลูกค้า */
   FIELD addr       AS CHAR FORMAT "x(120)"              INIT ""  /*  Column : ที่อยู่ */
   FIELD model      AS CHAR FORMAT "x(120)"              INIT ""  /*  Column : ยี่ห้อ/รุ่น */
   FIELD vehreg     AS CHAR FORMAT "x(11)"               INIT ""  /*  Column : ทะเบียนรถ */
   /* FIELD vehyear    AS INTE FORMAT "9999"                INIT 0  /*  Column : ปีจดทะเบียน */    */
   FIELD vehyear    AS CHAR FORMAT "x(4)"                 INIT ""
   FIELD cha_no     AS CHAR FORMAT "x(20)"               INIT ""  /*  Column : เลขตัวถัง */
   FIELD eng_no     AS CHAR FORMAT "x(20)"               INIT ""  /*  Column : เลขเครื่องยนต์ */
  /* FIELD cc         AS INTE FORMAT ">>>>9"               INIT 0  /*  Column : ขนาดเครื่องยนต์ */ */
   FIELD cc         AS CHAR FORMAT "x(5)"                INIT "" 
   FIELD sname      AS CHAR FORMAT "x(100)"              INIT ""  /*  Column : ชื่อผู้จำหน่ายรถยนต์ */
  /* FIELD seat       AS INTE FORMAT ">>9"                 INIT ""  /*  Column : ทะเบียนรถ */ */
   FIELD seat       AS CHAR FORMAT "x(3)"                INIT "" 
   FIELD class      AS CHAR FORMAT "x(4)"                INIT ""  /*  Column : ปีจดทะเบียน */    
   FIELD body       AS CHAR FORMAT "x(20)"               INIT ""  /*  Column : เลขตัวถัง */
 /*
   FIELD prem       AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0   /*  Column : เบี้ยสุทธิ */
   FIELD stamp      AS DECI FORMAT ">>>,>>9.99-"         INIT 0   /*  Column : อากร */
   FIELD vat        AS DECI FORMAT ">>>,>>9.99-"         INIT 0   /*  Column : ภาษี */
   FIELD gross      AS DECI FORMAT ">>>,>>>,>>>,>>9.99-" INIT 0   /*  Column : เบี้ยประกันภัย NEW */
 */
   FIELD prem       AS CHAR FORMAT "x(20)"               INIT ""  /*  Column : เบี้ยสุทธิ */
   FIELD stamp      AS CHAR FORMAT "x(20)"               INIT ""   /*  Column : อากร */
   FIELD vat        AS CHAR FORMAT "x(20)"               INIT ""   /*  Column : ภาษี */
   FIELD gross      AS CHAR FORMAT "x(20)"               INIT ""   /*  Column : เบี้ยประกันภัย NEW */

   FIELD comyear    AS CHAR FORMAT "x(3)"                INIT ""   /*  Column : ปีที่ขยาย */
 /*  FIELD mile       AS INTE FORMAT ">>>,>>>,>>9"         INIT 0   /*  Column : เลขไมล์ที่คุ้มครอง */ */
   FIELD mile       AS CHAR FORMAT "x(15)"               INIT ""   /*  Column : เลขไมล์ที่คุ้มครอง */
   FIELD sign       AS CHAR FORMAT "x(80)"               INIT "" . /* Column : ออกใบเสร็จในนาม */
   

DEF VAR nv_dept   AS CHAR    FORMAT "X(1)" INIT "".
DEF VAR nv_gstrat AS DECIMAL FORMAT ">>9.99-".
DEF VAR nv_si     AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99".
DEF VAR nv_cedpol    AS CHARACTER FORMAT "X(16)". 
DEF VAR nv_cedsi     AS DECIMAL   FORMAT ">>,>>>,>>>,>>>,>>9.99".

DEFINE WORKFILE wdelimi NO-UNDO
   FIELD txt AS CHARACTER FORMAT "X(1000)" INITIAL "".

DEFINE VAR n_hptyp1    AS CHAR.
DEFINE VAR n_hpDestyp1 AS CHAR.

DEFINE STREAM nfile.
DEFINE STREAM nerror.   
DEFINE STREAM nnoterror. 
DEFINE STREAM nbatch.    

DEFINE VAR nv_trndat AS DATE      FORMAT "99/99/9999"  INITIAL TODAY NO-UNDO.
DEFINE VAR nv_enttim AS CHARACTER FORMAT "X(08)".

DEFINE VAR nv_agent  AS CHARACTER FORMAT "X(07)"       INITIAL "" NO-UNDO.
DEFINE VAR nv_acno1  AS CHARACTER FORMAT "X(07)"       INITIAL "" NO-UNDO.
DEFINE VAR nv_line   AS INTEGER   INITIAL 0            NO-UNDO.
DEFINE VAR nv_com1p  AS DECIMAL   INITIAL 0            NO-UNDO.
DEFINE VAR nv_com1_t AS DECIMAL   FORMAT ">>>,>>9.99-" INITIAL 0.

DEFINE VAR nv_ty_per AS DECIMAL   INITIAL 0            NO-UNDO. /*Treaty %*/
DEFINE VAR nv_sity_p AS DECIMAL   FORMAT ">,>>>,>>>,>>9.99"  INITIAL 0.
DEFINE VAR nv_pdty_p AS DECIMAL   FORMAT ">,>>>,>>9.99-"     INITIAL 0.

/*--Coinsurance %--*/
DEFINE VAR nv_coper  AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_sicop  AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_pdcop  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
DEFINE VAR nv_rateco AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_comco  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
/*--Statutory %--*/                                   
DEFINE VAR nv_stper  AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_sistp  AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_pdstp  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
DEFINE VAR nv_ratest AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_comst  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
/*--Facultative %--*/                                 
DEFINE VAR nv_faper  AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_sifap  AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_pdfap  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
DEFINE VAR nv_ratefa AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_comfa  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
/*--Treaty %--*/                                      
DEFINE VAR nv_typer  AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_sityp  AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_pdtyp  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
DEFINE VAR nv_ratety AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_comty  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
/*--Quota Share %--*/                                 
DEFINE VAR nv_qsper  AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_siqsp  AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" INITIAL 0.
DEFINE VAR nv_pdqsp  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.
DEFINE VAR nv_rateqs AS DECIMAL FORMAT ">>9.99"           INITIAL 0.
DEFINE VAR nv_comqs  AS DECIMAL FORMAT ">,>>>,>>9.99-"    INITIAL 0.

DEFINE VAR nv_docno1    AS CHARACTER FORMAT "X(7)"      INITIAL ""  NO-UNDO.
DEFINE VAR nv_check     AS CHARACTER                    INITIAL ""  NO-UNDO.
DEFINE VAR nv_branch    AS CHARACTER FORMAT "X(02)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_policy    AS CHARACTER FORMAT "X(12)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_rencnt    AS INTEGER   FORMAT "99"        INITIAL 0   NO-UNDO.
DEFINE VAR nv_endcnt    AS INTEGER   FORMAT "999"       INITIAL 0   NO-UNDO.
DEFINE VAR nv_insref    AS CHARACTER FORMAT "X(7)"      INITIAL ""  NO-UNDO.
DEFINE VAR nv_delimiter AS LOGICAL                      NO-UNDO.
DEFINE VAR nv_delimitxt AS CHAR FORMAT "X(25)"  INIT "" NO-UNDO.

DEFINE VAR nv_status    AS CHAR    FORMAT "X(3)".
DEFINE VAR n_cdate      AS DATE    FORMAT "99/99/9999".
DEFINE VAR n_edate      AS DATE    FORMAT "99/99/9999".
DEFINE VAR nv_shared    AS INTEGER                            INITIAL 0 NO-UNDO. /* % Shared */
DEFINE VAR nv_pd_shared AS DECIMAL FORMAT ">>,>>>,>>9.99-"    INITIAL 0.         /* Premium  */
DEFINE VAR nv_si_shared AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99" INITIAL 0.         /* SI       */
DEFINE VAR nv_prvpol    AS CHAR    FORMAT "X(16)"       INITIAL "".  /* Prev Policy*/
DEFINE VAR nv_renpol    AS CHAR    FORMAT "X(16)"       INITIAL "".  /* Renew  Policy*/
DEFINE VAR nv_policyold AS CHAR    FORMAT "X(16)"       INITIAL "".  /* Check เพื่อให้ค่าเบอร์เก่าก่อน Renew และ Endorse*/
DEFINE VAR nv_fdateold  AS DATE    FORMAT "99/99/9999". /* Check เพื่อให้ค่า First Date เก่าก่อน Renew และ Endorse*/
DEFINE VAR nv_endnum    AS CHAR    FORMAT "XXXXXXX".
DEFINE VAR n_undyr      AS CHAR    FORMAT "9999".

DEFINE BUFFER buwm100 FOR sicuw.uwm100.
DEFINE VAR n_count     AS INTEGER.     /*Number Record For Excel*/
DEFINE VAR n_sum       AS INTE INIT 0. /*Nuber Record All is Import*/
DEFINE VAR nv_xmm600   AS CHAR.        /*Warning Create xmm600 And xtm600*/

DEFINE VAR nv_recid100 AS RECID. /*RECID UWM100*/
DEFINE VAR nv_recid120 AS RECID. /*RECID UWM120*/
DEFINE VAR nv_recid130 AS RECID. /*RECID UWM130*/
DEFINE VAR nv_recid132 AS RECID. /*RECID UWD132*/
DEFINE VAR nv_recid304 AS RECID. /*RECID UWM304*/
DEFINE VAR nv_recid307 AS RECID. /*RECID UWM304*/

DEF VAR nv_poltyp AS CHAR    FORMAT "X(3)".  /*Poltyp Safety*/
DEF VAR nv_typpol AS INTEGER FORMAT ">>9".    /*Poltyp Aon*/

DEFINE WORKFILE wallocate NO-UNDO
   FIELD csftq  AS CHAR    FORMAT "X(1)"             INIT ""  /*csftq*/
   FIELD rico   AS CHAR    FORMAT "X(20)"            INIT ""  /*rico*/
   FIELD rip1   AS DECIMAL FORMAT ">>9.99"           INIT ""  /*%com1*/
   FIELD si     AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" INIT 0   /*si*/
   FIELD per    AS DECIMAL FORMAT ">>9.99"           INIT 0   /*percent*/
   FIELD pd     AS DECIMAL FORMAT ">,>>>,>>9.99-"    INIT 0   /*prem*/
   FIELD com    AS DECIMAL FORMAT ">,>>>,>>9.99-"    INIT 0.  /*comm*/

DEFINE VAR nv_file AS CHAR    INIT "".
DEFINE VAR nv_row  AS INTEGER INIT 0.
DEF STREAM ns1.

DEFINE VAR nv_texterror   AS CHAR FORMAT "X(200)" INIT "". 
DEFINE VAR nv_Bchyr       AS INT  FORMAT "9999"                  INITIAL 0.
DEFINE VAR nv_Bchno       AS CHARACTER FORMAT "X(12)"           INITIAL ""  NO-UNDO.
DEFINE VAR nv_Bchcnt      AS INT FORMAT "99"                    INITIAL 0.

DEFINE VAR nv_poltotal    AS INTEGER                            INITIAL 0   NO-UNDO.
DEFINE VAR nv_premtotal   AS DECIMAL FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.   
DEFINE VAR nv_comtotal    AS DECIMAL FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.  
DEFINE VAR nv_sitotal     AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99" INITIAL 0. 

DEFINE VAR nv_polsuccess  AS INTEGER                            INITIAL 0   NO-UNDO.
DEFINE VAR nv_premsuccess AS DECIMAL FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.  
DEFINE VAR nv_comsuccess  AS DECIMAL FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.  
DEFINE VAR nv_sisuccess   AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99" INITIAL 0.  

DEFINE VAR nv_polerror    AS INTEGER                            INITIAL 0   NO-UNDO.
DEFINE VAR nv_premerror   AS DECIMAL FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.  
DEFINE VAR nv_comerror    AS DECIMAL FORMAT ">,>>>,>>>,>>9.99-" INITIAL 0.  
DEFINE VAR nv_sierror     AS DECIMAL FORMAT ">>,>>>,>>>,>>9.99" INITIAL 0.  

DEFINE VAR  nv_batflg     AS LOG  INIT NO.  /*uzm701.*/
DEFINE VAR  nv_polflg     AS LOG  INIT NO.  /*uwm100.Sucflg*/
DEFINE VAR  nv_txtmsg     AS CHAR FORMAT "X(50)" INIT "".
DEFINE VAR  nv_reccount   AS INTE INIT 0.  

DEFINE VAR  nv_dattime    AS CHAR INIT "".

DEFINE VAR s_riskgp    AS INTE FORMAT ">9".
DEFINE VAR s_riskno    AS INTE FORMAT "999".
DEFINE VAR s_itemno    AS INTE FORMAT "999".
DEF VAR nv_fptr        AS RECID.  
DEF VAR nv_bptr        AS RECID.                           
DEF VAR nv_nptr        AS RECID.                           
DEFINE VAR nv_line1    AS INTEGER   INITIAL 0            NO-UNDO.
DEFINE VAR n_text      AS CHAR FORMAT "x(30)" INIT "" .

DEFINE  WORKFILE wuppertxt3 NO-UNDO                                                             
 /*1*/  FIELD line     AS INTEGER   FORMAT ">>9"                                                
 /*2*/  FIELD txt      AS CHARACTER FORMAT "X(78)"   INITIAL "".

DEFINE VAR nv_vatcode  AS CHARACTER FORMAT "x(10)". /* Add Watsana K. [A57-0115] */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdetail2

/* Definitions for BROWSE br_main                                       */
&Scoped-define FIELDS-IN-QUERY-br_main recno policy TRIM(name1) cpolno comdat prem stamp vat gross   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_main   
&Scoped-define SELF-NAME br_main
&Scoped-define QUERY-STRING-br_main FOR EACH wdetail2 NO-LOCK
&Scoped-define OPEN-QUERY-br_main OPEN QUERY br_main FOR EACH wdetail2 NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_main wdetail2
&Scoped-define FIRST-TABLE-IN-QUERY-br_main wdetail2


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_trndat fi_bran fi_acno1 bu_acno1 fi_agent ~
bu_agent fi_prvbatch fi_Bchyr fi_input bu_open fi_output1 fi_output2 ~
fi_output3 fi_policyinput fi_preminput bu_ok bu_exit br_main fi_vatcode ~
RECT-1 RECT-2 RECT-262 RECT-263 RECT-264 RECT-266 RECT-267 
&Scoped-Define DISPLAYED-OBJECTS fi_trndat fi_bran fi_brandesc fi_acno1 ~
fi_acdesc fi_agent fi_agdesc fi_prvbatch fi_Bchyr fi_input fi_output1 ~
fi_output2 fi_output3 fi_policyinput fi_preminput fi_policytotal ~
fi_premtotal fi_policysuccess fi_premsuccess fi_batch fi_vatcode fi_vatdesc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_acno1 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "" 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_agent 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "" 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 14.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 14.5 BY 1.05.

DEFINE BUTTON bu_open 
     LABEL "..." 
     SIZE 4 BY .91.

DEFINE VARIABLE fi_acdesc AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.5 BY .91
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno1 AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agdesc AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.5 BY .91
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_batch AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1.19
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_Bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bran AS CHARACTER FORMAT "XX":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brandesc AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .91
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_input AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policyinput AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policysuccess AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_policytotal AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_preminput AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 26.67 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premsuccess AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY .91
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_premtotal AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 26.17 BY .91
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_prvbatch AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 21 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vatdesc AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60.5 BY .91
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 11.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-262
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 129 BY 1.1
     BGCOLOR 1 FGCOLOR 1 .

DEFINE RECTANGLE RECT-263
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-264
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.57
     BGCOLOR 148 .

DEFINE RECTANGLE RECT-266
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 7
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-267
     EDGE-PIXELS 8    
     SIZE 131 BY 3
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_main FOR 
      wdetail2 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_main
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_main C-Win _FREEFORM
  QUERY br_main DISPLAY
      recno       COLUMN-LABEL "No."           
    policy      COLUMN-LABEL "Policy"         FORMAT "X(15)"
    TRIM(name1) COLUMN-LABEL "Insured Name"   FORMAT "x(20)"
    cpolno      COLUMN-LABEL "Insured Code"
    comdat      COLUMN-LABEL "Comdate"        
    prem        COLUMN-LABEL "Premium"        FORMAT "X(15)"
    stamp       COLUMN-LABEL "Stamp"          FORMAT "X(10)"
    vat         COLUMN-LABEL "Vat"            FORMAT "X(10)"
    gross       COLUMN-LABEL "Premium New"    FORMAT "X(15)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH SEPARATORS SIZE 127 BY 6.52
         BGCOLOR 15 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_trndat AT ROW 3.19 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_bran AT ROW 4.14 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_brandesc AT ROW 4.14 COL 33.67 COLON-ALIGNED NO-LABEL
     fi_acno1 AT ROW 5.1 COL 28.67 COLON-ALIGNED NO-LABEL
     bu_acno1 AT ROW 5.1 COL 43.67
     fi_acdesc AT ROW 5.1 COL 45.67 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.05 COL 28.67 COLON-ALIGNED NO-LABEL
     bu_agent AT ROW 6.1 COL 43.67
     fi_agdesc AT ROW 6.05 COL 45.67 COLON-ALIGNED NO-LABEL
     fi_prvbatch AT ROW 7 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_Bchyr AT ROW 7 COL 68.67 COLON-ALIGNED NO-LABEL
     fi_input AT ROW 7.95 COL 28.67 COLON-ALIGNED NO-LABEL
     bu_open AT ROW 8.1 COL 98.33
     fi_output1 AT ROW 8.91 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 9.86 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 10.81 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_policyinput AT ROW 12.86 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_preminput AT ROW 12.86 COL 69.33 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 4.38 COL 114.33
     bu_exit AT ROW 6.43 COL 114.33
     br_main AT ROW 14.62 COL 4
     fi_policytotal AT ROW 22 COL 60.5 COLON-ALIGNED NO-LABEL
     fi_premtotal AT ROW 22 COL 95.17 COLON-ALIGNED NO-LABEL
     fi_policysuccess AT ROW 22.95 COL 60.5 COLON-ALIGNED NO-LABEL
     fi_premsuccess AT ROW 22.95 COL 95.17 COLON-ALIGNED NO-LABEL
     fi_batch AT ROW 22.38 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_vatcode AT ROW 11.81 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_vatdesc AT ROW 11.86 COL 42.5 COLON-ALIGNED NO-LABEL
     "Load Policy Extened Warranty for Nissan" VIEW-AS TEXT
          SIZE 56.5 BY .57 AT ROW 1.76 COL 5.5
          BGCOLOR 1 FGCOLOR 15 
     "Agent Code :" VIEW-AS TEXT
          SIZE 14 BY .57 AT ROW 6.24 COL 16.17
          BGCOLOR 8 FGCOLOR 1 
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .57 AT ROW 8.14 COL 6.67
          BGCOLOR 8 FGCOLOR 1 
     "Record Success :" VIEW-AS TEXT
          SIZE 16.67 BY .57 AT ROW 23.14 COL 44.83
          BGCOLOR 8 FGCOLOR 1 
     "Premium Import Total :" VIEW-AS TEXT
          SIZE 22.5 BY .57 AT ROW 13.05 COL 47.83
          BGCOLOR 8 FGCOLOR 1 
     "Trandate :" VIEW-AS TEXT
          SIZE 10.5 BY .57 AT ROW 3.38 COL 18.67
          BGCOLOR 8 FGCOLOR 1 
     "BHT." VIEW-AS TEXT
          SIZE 6.5 BY .57 AT ROW 13 COL 100.33
          BGCOLOR 8 FGCOLOR 1 
     "(Note : Premium Safety)" VIEW-AS TEXT
          SIZE 22.5 BY .86 AT ROW 12.91 COL 106.33
          BGCOLOR 8 FGCOLOR 1 
     "File Completed :" VIEW-AS TEXT
          SIZE 16.33 BY .57 AT ROW 9.05 COL 13
          BGCOLOR 8 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 12.83 BY 1.19 AT ROW 22.38 COL 5.17
          BGCOLOR 8 FGCOLOR 1 FONT 36
     "Premium Success :" VIEW-AS TEXT
          SIZE 17.83 BY .57 AT ROW 23.19 COL 78.17
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No :" VIEW-AS TEXT
          SIZE 19.5 BY .57 AT ROW 7.14 COL 9.67
          BGCOLOR 8 FGCOLOR 1 
     "Screen Output To File :" VIEW-AS TEXT
          SIZE 23.5 BY .57 AT ROW 10.95 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Record Total :" VIEW-AS TEXT
          SIZE 13.5 BY .57 AT ROW 22.19 COL 48
          BGCOLOR 8 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57
         BGCOLOR 3 FGCOLOR 0 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Branch :" VIEW-AS TEXT
          SIZE 8.5 BY .57 AT ROW 4.33 COL 20.67
          BGCOLOR 8 FGCOLOR 1 
     "BHT." VIEW-AS TEXT
          SIZE 4.83 BY .57 AT ROW 22.81 COL 125
          BGCOLOR 8 FGCOLOR 1 
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .57 AT ROW 5.29 COL 13.17
          BGCOLOR 8 FGCOLOR 1 
     "File Not Completed :" VIEW-AS TEXT
          SIZE 20.17 BY .57 AT ROW 10 COL 9.17
          BGCOLOR 8 FGCOLOR 1 
     "Premium Total :" VIEW-AS TEXT
          SIZE 15.17 BY .57 AT ROW 22.24 COL 81.33
          BGCOLOR 8 FGCOLOR 1 
     "Vat Code  :" VIEW-AS TEXT
          SIZE 12 BY .62 AT ROW 11.95 COL 17.67
          BGCOLOR 8 FGCOLOR 1 
     "Policy Import Total :" VIEW-AS TEXT
          SIZE 19 BY .57 AT ROW 13 COL 9.5
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 13 BY .57 AT ROW 7.19 COL 56.5
          BGCOLOR 8 FGCOLOR 1 
     "BHT." VIEW-AS TEXT
          SIZE 5.33 BY .57 AT ROW 21.62 COL 125
          BGCOLOR 8 FGCOLOR 1 
     RECT-1 AT ROW 1.24 COL 2
     RECT-2 AT ROW 2.81 COL 2
     RECT-262 AT ROW 1.48 COL 3
     RECT-263 AT ROW 4.1 COL 113.33
     RECT-264 AT ROW 6.14 COL 113.33
     RECT-266 AT ROW 14.38 COL 2
     RECT-267 AT ROW 21.43 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.57
         BGCOLOR 3 FGCOLOR 0 FONT 6.


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
         TITLE              = "Wgwimnis : Load Policy Extened Warranty for Nissan"
         HEIGHT             = 23.62
         WIDTH              = 133.17
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24
         VIRTUAL-WIDTH      = 133.33
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
/* BROWSE-TAB br_main bu_exit fr_main */
/* SETTINGS FOR FILL-IN fi_acdesc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_agdesc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_batch IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brandesc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policysuccess IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policytotal IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuccess IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtotal IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vatdesc IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_main
/* Query rebuild information for BROWSE br_main
     _START_FREEFORM
OPEN QUERY br_main FOR EACH wdetail2 NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Wgwimnis : Load Policy Extened Warranty for Nissan */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Wgwimnis : Load Policy Extened Warranty for Nissan */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_main
&Scoped-define SELF-NAME br_main
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_main C-Win
ON LEFT-MOUSE-DBLCLICK OF br_main IN FRAME fr_main
DO:
    /*---Wantanee A49-0165---
    {&WINDOW-NAME}:SENSITIVE = NO.
    RUN  wtm\wtmgen00(Input  wgenerage.rec100,      /* 100  */
                             wgenerage.rec120,      /* 120  */
                             wgenerage.rec130       /* 130  */
                             /*wgenerage.rec304*/). /* 304  */
    {&WINDOW-NAME}:SENSITIVE = YES.
    ---Wantanee A49-0165---*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_acno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_acno1 C-Win
ON CHOOSE OF bu_acno1 IN FRAME fr_main
DO:
   DEF VAR n_acno  AS CHAR.
   DEF VAR n_agent AS CHAR.    
     
   CURRENT-WINDOW:SENSITIVE = NO.  
   RUN whp\whpacno1(OUTPUT  n_acno,
                    OUTPUT  n_agent).
   CURRENT-WINDOW:SENSITIVE = YES. 
                                         
   IF n_acno <> "" THEN fi_acno1 = n_acno.      
   Disp fi_acno1 WITH FRAME fr_main.
   APPLY "Entry"  TO fi_acno1.
   RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_agent C-Win
ON CHOOSE OF bu_agent IN FRAME fr_main
DO:
   DEF VAR n_acno  AS CHAR.
   DEF VAR n_agent AS CHAR.    
     
   CURRENT-WINDOW:SENSITIVE = NO.  
   RUN whp\whpacno1(OUTPUT n_acno,
                    OUTPUT n_agent).
   CURRENT-WINDOW:SENSITIVE = YES. 
                                          
   IF n_acno <> "" THEN fi_agent = n_acno.      
   Disp fi_agent WITH FRAME fr_main.
   APPLY "Entry" TO fi_agent.
   RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   APPLY "Close" TO THIS-PROCEDURE.
   RETURN NO-APPLY.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
  ASSIGN
      fi_batch         = ""
      fi_policytotal   = 0
      fi_policysuccess = 0
      fi_premtotal     = 0
      fi_premsuccess   = 0 .  

 
  DISP fi_batch fi_policytotal fi_policysuccess fi_premtotal fi_premsuccess WITH FRAME fr_main .  

  IF INPUT fi_trndat = ? OR  INPUT fi_trndat = "" THEN DO:
      MESSAGE "Plese Input Trandate...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_trndat.
      RETURN NO-APPLY.
  END.
  
  IF INPUT fi_bran <> "" THEN DO:
      FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE 
                 sicsyac.xmm023.branch = INPUT fi_bran NO-LOCK NO-ERROR.
      IF AVAILABLE sicsyac.xmm023 THEN DO:
          ASSIGN
            fi_bran     = CAPS(INPUT fi_bran)
            fi_brandesc = sicsyac.xmm023.bdes.
          DISPLAY fi_bran fi_brandesc WITH FRAME {&FRAME-NAME}.
      END.
      ELSE DO :
          MESSAGE " Not on Parameters by branch file sicsyac.xmm023 ...!!!" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fi_bran.
          RETURN NO-APPLY.
      END.
  END.    
  ELSE DO:
      MESSAGE "Plese Input Branch...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_bran.
      RETURN NO-APPLY.
  END.  

  IF INPUT fi_acno1 <> "" THEN DO:
      fi_acno1 = CAPS(INPUT fi_acno1).
      FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
           sicsyac.xmm600.acno = INPUT fi_acno1  NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
        MESSAGE "Not on Name & Address Master file sicsyac.xmm600...!!!" VIEW-AS ALERT-BOX ERROR.
        DISPLAY fi_acno1  WITH FRAME fr_main.
        APPLY "Entry" TO fi_acno1.
        RETURN NO-APPLY.
      END.
      fi_acdesc = TRIM(TRIM(sicsyac.xmm600.ntitle) + " " + TRIM(sicsyac.xmm600.name)).
      IF INPUT fi_agent = "" THEN DO:
        ASSIGN
         fi_agent  = CAPS(INPUT fi_acno1)
         fi_agdesc = fi_acdesc.
      END.

      DISPLAY fi_acno1 fi_acdesc fi_agent fi_agdesc WITH FRAME fr_main.
  END.
  ELSE DO:
      MESSAGE "Plese Input Producer Code...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_acno1.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_agent <> "" THEN DO:
      fi_agent = CAPS(INPUT fi_agent).

      FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
           sicsyac.xmm600.acno = fi_agent NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
        MESSAGE "Not on Name & Address Master file sicsyac.xmm600...!!!" VIEW-AS ALERT-BOX ERROR.
        DISPLAY fi_agent  WITH FRAME fr_main.
        APPLY "Entry" TO fi_agent.
        RETURN NO-APPLY.
      END.
      fi_agdesc = TRIM(TRIM(sicsyac.xmm600.ntitle) + " " + TRIM(sicsyac.xmm600.name)).
      DISPLAY  fi_acno1 fi_acdesc fi_agent fi_agdesc WITH FRAME fr_main.  
  END.
  ELSE DO:
      MESSAGE "Plese Input Agent Code...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_agent.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_prvbatch <> "" THEN DO:
    FIND LAST uzm701 USE-INDEX uzm70102 WHERE
              uzm701.Bchno = INPUT fi_prvbatch NO-LOCK NO-ERROR.
    IF NOT AVAIL uzm701 THEN DO:
       MESSAGE "Not found Batch File Master: " + CAPS(INPUT fi_prvbatch) + "on file uzm701...!!!" VIEW-AS ALERT-BOX ERROR.
       APPLY "Entry" TO fi_prvbatch.
       RETURN NO-APPLY.
    END.
    ELSE DO: 
       IF uzm701.Bchyr <> INPUT fi_Bchyr THEN DO:
          MESSAGE "Not found Batch File Master on file uzm701 (Year)...!!!" VIEW-AS ALERT-BOX ERROR.
          PAUSE 5 NO-MESSAGE.
          APPLY "Entry" TO fi_Bchyr.
          RETURN NO-APPLY.
       END.
    END.
  END.

  IF INPUT fi_Bchyr <= 0 THEN DO:
      MESSAGE "Batch Year Error...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_Bchyr.
      RETURN NO-APPLY.
  END.                                            

  IF INPUT fi_input <> "" THEN DO:
    IF SEARCH(INPUT fi_input) = ? THEN DO:
      MESSAGE "ไม่พบแฟ้มข้อมูลนี้...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_input.
      RETURN NO-APPLY.
    END.
  END.
  ELSE DO:
      MESSAGE "Plese Input File name...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_input.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_output1 = "" THEN DO:
      MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output1.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_output2 = "" THEN DO:
      MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output2.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_output3 = "" THEN DO:
      MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output3.
      RETURN NO-APPLY.
  END.

  MESSAGE "กด Yes เพื่อ Confirm Process Data  " SKIP
           VIEW-AS ALERT-BOX INFORMATION BUTTONS YES-NO
           TITLE "Information Message" UPDATE choice AS LOGICAL.
  IF NOT choice THEN DO:  
    MESSAGE "ยกเลิกการ Process Data...!!!" VIEW-AS ALERT-BOX INFORMATION.
    NEXT.
  END.
  ELSE DO:
    RUN Pd_Process.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_open
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_open C-Win
ON CHOOSE OF bu_open IN FRAME fr_main /* ... */
DO:
   DEFINE VARIABLE nv_cvData    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE nv_OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE nv_cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Excel (*.csv)" "*.csv"
                   /*"Excel (*.er)" "*.er",
                   "Text Files (*.txt)" "*.txt",
                   "Data Files (*." + Company.ABName + ")"   "*." + Company.ABName*/
                   
        MUST-EXIST
        USE-FILENAME
        UPDATE nv_OKpressed.
      
   ASSIGN  /*--8/11/2006---*/
       nv_dattime = ""
       nv_dattime = STRING(MONTH(TODAY),"99")    +
                    STRING(DAY(TODAY),"99")      +
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2).

    IF nv_OKpressed = TRUE THEN DO:
         ASSIGN
            fi_input   = nv_cvData 
            /*----8/11/2006---
            fi_output1 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + "SUCCESS" + ".txt" 
            fi_output2 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + "ERROR"   + ".err" 
            fi_output3 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + "SCREEN"  + ".txt".
            ----8/11/2006---*/
            fi_output1 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".fuw" 
            fi_output2 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".err" 
            fi_output3 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".sce".

         DISP fi_output1 fi_output2 fi_output3 fi_input WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno1 C-Win
ON RETURN OF fi_acno1 IN FRAME fr_main
DO:
    ASSIGN fi_acno1 = INPUT fi_acno1.

    IF INPUT fi_acno1 <> "" THEN DO:
        fi_acno1 = CAPS(INPUT fi_acno1).
        FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
             sicsyac.xmm600.acno = INPUT fi_acno1  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
          MESSAGE "Not on Name & Address Master file sicsyac.xmm600" VIEW-AS ALERT-BOX ERROR.
          DISPLAY fi_acno1  WITH FRAME fr_main.
          APPLY "Entry" TO fi_acno1.
          RETURN NO-APPLY.
        END.
        fi_acdesc = TRIM(TRIM(sicsyac.xmm600.ntitle) + " " + TRIM(sicsyac.xmm600.name)).
        IF INPUT fi_agent = "" THEN DO:
          ASSIGN
            fi_agent  = CAPS(INPUT fi_acno1)
            fi_agdesc = fi_acdesc.
        END.

    END.

    DISPLAY fi_acno1 fi_acdesc fi_agent fi_agdesc WITH FRAME fr_main.

    APPLY "Entry" TO fi_agent.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON RETURN OF fi_agent IN FRAME fr_main
DO:
    ASSIGN fi_agent = INPUT fi_agent.
    DISP fi_agent WITH FRAME {&FRAME-NAME}.


    IF INPUT fi_agent <> "" THEN DO:
        fi_agent = CAPS(INPUT fi_agent).

        FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
             sicsyac.xmm600.acno = fi_agent NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
          MESSAGE "Not on Name & Address Master file sicsyac.xmm600" VIEW-AS ALERT-BOX ERROR.
          DISPLAY fi_agent  WITH FRAME fr_main.
          APPLY "Entry" TO fi_agent.
          RETURN NO-APPLY.
        END.
        fi_agdesc = TRIM(TRIM(sicsyac.xmm600.ntitle) + " " + TRIM(sicsyac.xmm600.name)).
    END.

    DISPLAY fi_acno1 fi_acdesc fi_agent fi_agdesc
    WITH FRAME fr_main.  

    APPLY "Entry" TO fi_prvbatch.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bran
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bran C-Win
ON RETURN OF fi_bran IN FRAME fr_main
DO:
  ASSIGN fi_bran = CAPS(INPUT fi_bran).
  DISP fi_bran WITH FRAME {&FRAME-NAME}.
  
    IF INPUT fi_bran <> "" THEN DO:
        FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE 
                   sicsyac.xmm023.branch = INPUT fi_bran NO-LOCK NO-ERROR.
        IF AVAILABLE sicsyac.xmm023 THEN DO:
            fi_brandesc = sicsyac.xmm023.bdes.
            DISPLAY fi_bran fi_brandesc WITH FRAME {&FRAME-NAME}.
            APPLY "ENTRY" TO fi_acno1.
            RETURN NO-APPLY. 
        END.
        ELSE DO :
            MESSAGE " Not on Parameters by branch file sicsyac.xmm023 " VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fi_bran.
            RETURN NO-APPLY.
        END.
    END.    
    ELSE DO:
        ASSIGN 
           fi_bran      = "" 
           fi_brandesc  = "".
        DISP fi_bran  fi_brandesc WITH FRAME {&FRAME-NAME}.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_input
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_input C-Win
ON RETURN OF fi_input IN FRAME fr_main
DO:
    ASSIGN fi_input = INPUT fi_input.
    DISP fi_input WITH FRAME {&FRAME-NAME}.


    ASSIGN  /*--8/11/2006---*/
        nv_dattime = ""
        nv_dattime = STRING(MONTH(TODAY),"99")    +
                     STRING(DAY(TODAY),"99")      +
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2).

    IF INPUT fi_input <> "" THEN DO:
      IF SEARCH(INPUT fi_input) = ? THEN DO:
        MESSAGE "ไม่พบแฟ้มข้อมูลนี้ .." VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_input.
        RETURN NO-APPLY.
      END.
      ELSE DO:
        /*--8/11/2006--
        ASSIGN                              
          fi_output1 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + "SUCCESS" + ".txt"
          fi_output2 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + "ERROR"   + ".err"
          fi_output3 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + "SCREEN"  + ".txt".
        --8/11/2006--*/
        ASSIGN                              
          fi_output1 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".fuw"
          fi_output2 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".err"
          fi_output3 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".sce".

        DISP fi_output1 fi_output2 fi_output3 WITH FRAME fr_main.
        APPLY "Entry" TO fi_output1.
        RETURN NO-APPLY.
      END.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policyinput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policyinput C-Win
ON LEAVE OF fi_policyinput IN FRAME fr_main
DO:
  ASSIGN fi_policyinput = INPUT fi_policyinput .
  DISP fi_policyinput WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_preminput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_preminput C-Win
ON LEAVE OF fi_preminput IN FRAME fr_main
DO:
  ASSIGN fi_preminput = INPUT fi_preminput .
  DISP fi_preminput WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prvbatch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prvbatch C-Win
ON LEAVE OF fi_prvbatch IN FRAME fr_main
DO:
  ASSIGN fi_prvbatch = CAPS(INPUT fi_prvbatch).
  DISP fi_prvbatch WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode C-Win
ON RETURN OF fi_vatcode IN FRAME fr_main
DO:
   ASSIGN fi_vatcode = INPUT fi_vatcode 
          nv_vatcode = fi_vatcode . 
        
   IF INPUT fi_vatcode <> "" THEN DO:
     FIND sicsyac.xmm600  USE-INDEX xmm60001  WHERE sicsyac.xmm600.acno  = INPUT fi_vatcode 
     NO-LOCK  NO-ERROR.
     IF  AVAIL  sicsyac.xmm600  THEN ASSIGN fi_vatdesc  = xmm600.name.
  END.
  ELSE fi_vatdesc = "" .

  DISP fi_vatcode fi_vatdesc WITH FRAME fr_main.
  APPLY "Entry" TO fi_policyinput.
  RETURN NO-APPLY.
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

/********************  T I T L E   F O R  C - W I N  ***************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wgwimnis".
  gv_prog  = "Load Policy Extened Warranty for Nissan".
 RUN  WUT\WUTHEAD (C-Win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (C-Win:handle). 
/********************************************************************/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN
    fi_trndat  = TODAY
    fi_bran    = "Y"
    fi_acno1   = "B3W0025"
    fi_agent   = "B3W0025"
    fi_Bchyr = YEAR(TODAY)
    fi_batch   = "".

  DISP fi_trndat fi_bran fi_acno1 fi_agent fi_Bchyr fi_batch WITH FRAME fr_main.

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
  DISPLAY fi_trndat fi_bran fi_brandesc fi_acno1 fi_acdesc fi_agent fi_agdesc 
          fi_prvbatch fi_Bchyr fi_input fi_output1 fi_output2 fi_output3 
          fi_policyinput fi_preminput fi_policytotal fi_premtotal 
          fi_policysuccess fi_premsuccess fi_batch fi_vatcode fi_vatdesc 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_trndat fi_bran fi_acno1 bu_acno1 fi_agent bu_agent fi_prvbatch 
         fi_Bchyr fi_input bu_open fi_output1 fi_output2 fi_output3 
         fi_policyinput fi_preminput bu_ok bu_exit br_main fi_vatcode RECT-1 
         RECT-2 RECT-262 RECT-263 RECT-264 RECT-266 RECT-267 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_assign C-Win 
PROCEDURE pd_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail2.
    DELETE wdetail2.
    END.
INPUT FROM VALUE(fi_input).
REPEAT:
    CREATE wdetail2.
    IMPORT DELIMITER "|" 
        wdetail2.recno  
        wdetail2.policy 
        wdetail2.comdat 
        wdetail2.tname  
        wdetail2.name1  
        wdetail2.cpolno 
        wdetail2.addr   
        wdetail2.model  
        wdetail2.vehreg 
        wdetail2.vehyear
        wdetail2.cha_no 
        wdetail2.eng_no 
        wdetail2.cc     
        wdetail2.sname  
        wdetail2.seat   
        wdetail2.class  
        wdetail2.body   
        wdetail2.prem   
        wdetail2.stamp  
        wdetail2.vat    
        wdetail2.gross  
        wdetail2.comyear
        wdetail2.mile   
        wdetail2.sign   .
END.

/*------ ลบหัวคอลัมน์ ------*/
FOR EACH wdetail2:


    IF INDEX(wdetail2.policy,"เลขรับแจ้ง") <> 0 THEN DELETE wdetail2.
    ELSE IF wdetail2.policy = " " THEN DELETE wdetail2.
END.



FIND FIRST wdetail2 NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE wdetail2 THEN DO:
    MESSAGE " Not found data " VIEW-AS ALERT-BOX ERROR.
    NEXT.
END.
ELSE DO:
   
    /*-- Running Batch file Master , Update field, Trasaction batch no.--*/
    RUN wgw\wgwbatch.p(INPUT        nv_trndat   ,             /* DATE  */
                       INPUT        nv_Bchyr  ,             /* INT   */
                       INPUT        nv_acno1    ,             /* CHAR  */ 
                       INPUT        (fi_bran)     ,     /* CHAR  */
                       INPUT        (fi_prvbatch) ,     /* CHAR  */
                       INPUT        "WGWIMNIS"  ,             /* CHAR  */
                       INPUT-OUTPUT nv_Bchno  ,             /* CHAR  */
                       INPUT-OUTPUT nv_Bchcnt   ,             /* INT   */
                       INPUT        (fi_policyinput)  , /* INT   */
                       INPUT        (fi_preminput)      /* DECI  */
                       ).

    
    fi_batch = CAPS(nv_Bchno + "." + STRING(nv_Bchcnt,"99")).
    DISP fi_batch WITH FRAME fr_main.
END.









END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Batch C-Win 
PROCEDURE Pd_Batch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DO WITH FRAME fr_main:
    /***------------ update ข้อมูลที่  uzm701 ------------***/

    nv_txtmsg = "".
    
    IF nv_reccount > 0 THEN DO:
       nv_batflg = NO.
       nv_txtmsg = "have record error..!!".
    END.
    ELSE DO:

        /*--- Check Record ---*/
        IF nv_poltotal          <> nv_polsuccess THEN DO: 
           nv_batflg = NO.
           nv_txtmsg = "have batch file error..!!".
        END.
        ELSE /*--- Check Premium ---*/
           IF nv_premtotal        <> nv_premsuccess THEN DO:
              nv_batflg = NO.
              nv_txtmsg = "have batch file error..!!".
           END.
           ELSE nv_batflg = YES.
    END.
    
    FIND LAST uzm701 USE-INDEX uzm70102
        WHERE uzm701.Bchyr   = nv_Bchyr AND
              uzm701.Bchno   = nv_Bchno AND
              uzm701.Bchcnt  = nv_Bchcnt 
    NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
          uzm701.recsuc       = nv_polsuccess 
          uzm701.premsuc      = nv_premsuccess   
          uzm701.stampsuc     = 0 /*nv_stmpsuc*/
          uzm701.taxsuc       = 0 /*nv_taxsuc */
          uzm701.com1suc      = nv_comsuccess
    
          uzm701.rectot       = nv_poltotal
          uzm701.premtot      = nv_premtotal   
          uzm701.stamptot     = 0 /*nv_stmptot*/
          uzm701.taxtot       = 0 /*nv_taxtot */
          uzm701.com1tot      = nv_comtotal
            
          uzm701.impflg       = nv_batflg
          uzm701.cnfflg       = nv_batflg
          uzm701.Trfflg       = NO
          uzm701.impendtim    = STRING(TIME,"HH:MM:SS").

         /* YES  สามารถนำเข้าข้อมูลได้หมด ไม่มี error  
            NO   นำเข้าข้อมูลได้ไม่ได้ไม่หมด  */         
    END.
    /***---------- END update ข้อมูลที่  uzm701 ---------***/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Create C-Win 
PROCEDURE Pd_Create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main:

      DO TRANSACTION: 
        
          DISP "Process policy : " wdetail2.policy "To Policy : " nv_policy " R/E : " nv_rencnt "/" nv_endcnt 
               WITH COLOR BLACK/WHITE NO-LABEL TITLE "PROCESS..." WIDTH 100 FRAME AMain VIEW-AS DIALOG-BOX.

          /*--------------------BEGIN GENERATE----------------------*/
          RUN pd_uwm100.      /*UWM100*/ 
                            
          RUN pd_uwm120.      /*UWM120*/
                            
          RUN pd_uwd102.      /*uwd102*/      
                            
          RUN pd_uwm130.      /*UWM130*/
          RUN pd_uwd132.      /*uwd132*/
        
          RUN pd_uwm200.      /*UWM200*/ 
          RUN pd_uwd200.      /*uwd200*/
     
          RUN pd_uwm301.      /*uwm301*/
          /*--------------------END GENERATE----------------------*/
    
      END. /*End Transaction*/    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_Process C-Win 
PROCEDURE pd_Process :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main:
    
    ASSIGN
     nv_line        = 0 
     fi_batch       = ""
     nv_poltotal    = 0
     nv_polsuccess  = 0
     nv_polerror    = 0
     
     nv_premtotal   = 0
     nv_premsuccess = 0
     nv_premerror   = 0

     nv_comtotal    = 0
     nv_comsuccess  = 0
     nv_comerror    = 0

     nv_sitotal     = 0
     nv_sisuccess   = 0
     nv_sierror     = 0
     
     nv_Bchyr       = 0
     nv_Bchyr       = INPUT fi_Bchyr
     nv_acno1       = INPUT fi_acno1
     nv_agent       = INPUT fi_agent
     nv_branch      = INPUT fi_bran
     n_count        = 0  /*Count Record*/
     nv_reccount    = 0. /*Count Record Error*/ 
   
    RUN pd_assign .

    OUTPUT STREAM nnoterror TO VALUE(INPUT fi_output1). 
    OUTPUT STREAM nerror    TO VALUE(INPUT fi_output2). 
    
    PUT STREAM nnoterror   
      "ลำดับที่"                           "|"
      "เลขรับแจ้ง Extened Warranty"        "|"
      "วันที่เริ่มคุ้มครอง"                "|"
      "คำนำหน้า"                           "|"                        
      "ชื่อผู้เอาประกันภัย"                "|"
      "รหัสลูกค้า"                         "|"
      "ที่อยู่ผู้เอาประกันภัย"             "|"
      "ยี่ห้อ/รุ่น"                        "|"
      "ทะเบียนรถ"                          "|"
      "ปีที่จดทะเบียน"                     "|"
      "เลขตัวถัง"                          "|"                      
      "เลขเครื่องยนต์"                     "|"
      "ขนาดเครื่องยนต์"                    "|"
      "ชื่อผู้จำหน่ายรถยนต์นิสสัน"         "|"
      "จำนวนที่นั่ง"                       "|"
      "รหัสตัวถัง"                         "|"
      "แบบตัวถัง"                          "|"
      "เบี้ยประกันสุทธิ"                   "|"
      "อากร"                               "|"
      "ภาษี"                               "|"
      "เบี้ยประกันภัย N.E.W."              "|"
      "ปีที่ขยาย"                          "|"
      "เลขไมล์ที่คุ้มครอง"                 "|"
      "ออกใบเสร็จในนาม "                   "|"
      SKIP.

    PUT STREAM nerror   
      "ลำดับที่"                           "|"
      "เลขรับแจ้ง Extened Warranty"        "|"
      "วันที่เริ่มคุ้มครอง"                "|"
      "คำนำหน้า"                           "|"
      "ชื่อผู้เอาประกันภัย"                "|"
      "รหัสลูกค้า"                         "|"                     
      "ที่อยู่ผู้เอาประกันภัย"             "|"
      "ยี่ห้อ/รุ่น"                        "|"
      "ทะเบียนรถ"                          "|"
      "ปีที่จดทะเบียน"                     "|"
      "เลขตัวถัง"                          "|"
      "เลขเครื่องยนต์"                     "|"
      "ขนาดเครื่องยนต์"                    "|"
      "ชื่อผู้จำหน่ายรถยนต์นิสสัน"         "|"
      "จำนวนที่นั่ง"                       "|"
      "รหัสตัวถัง"                         "|"
      "แบบตัวถัง"                          "|"
      "เบี้ยประกันสุทธิ"                   "|"
      "อากร"                               "|"
      "ภาษี"                               "|"
      "เบี้ยประกันภัย N.E.W."              "|"
      "ปีที่ขยาย"                          "|"
      "เลขไมล์ที่คุ้มครอง"                 "|"
      "ออกใบเสร็จในนาม "                   "|"
      SKIP.

    Loop_main:
    FOR EACH wdetail2 NO-LOCK WHERE wdetail2.policy <> ""  :
         
        ASSIGN
         nv_texterror = ""
         n_count      = n_count + 1
         nv_polflg    = YES.
       
        ASSIGN
            nv_policyold = ""
            nv_prvpol    = ""
            nv_renpol    = ""
            n_cdate      = ?
            n_edate      = ?
            nv_status    = ""
            nv_rencnt    = 0
            nv_endcnt    = 0
            nv_trndat    = TODAY
            nv_enttim    = STRING(TIME,"HH:MM:SS")
            nv_recid100  = 0
            nv_recid120  = 0
            nv_recid130  = 0
            nv_recid132  = 0
            nv_recid304  = 0
            nv_com1_t    = 0
            nv_com1p     = 0   .

        IF wdetail2.policy = "" THEN DO:    
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า POLICY NO.".   
        END.
    
        IF wdetail2.name1 = "" THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า INSURED NAME".   
        END.
    
        IF wdetail2.comdat = "" THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า EFFECTIVE DATE (Comdate)".   
        END.
  
        ASSIGN
            n_cdate =  DATE(SUBSTRING(wdetail2.comdat,1,R-INDEX(wdetail2.comdat,"/")) +  
                       STRING(INTEGER(substring(wdetail2.comdat,R-INDEX(wdetail2.comdat,"/") 
                       + 1 ,length(wdetail2.comdat))) + 3)) 
            n_edate =  DATE(SUBSTRING(wdetail2.comdat,1,R-INDEX(wdetail2.comdat,"/")) +  
                       STRING(INTEGER(substring(wdetail2.comdat,R-INDEX(wdetail2.comdat,"/") 
                       + 1 ,length(wdetail2.comdat))) + 5)) .

        IF wdetail2.prem = "" THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า PREMIUM".   
        END.
      
        IF wdetail2.gross = "" THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า NET PREMIUM".   
        END.
                                                         
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol  = wdetail2.cpolno
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.comdat >= n_cdate THEN DO: 
                IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
                nv_texterror = nv_texterror + "เลขที่สัญญานี้ได้ถูกใช้ไปแล้ว" .
            END.

        END.
        ELSE DO:
          ASSIGN 
            nv_prvpol    = ""
            nv_renpol    = ""
            nv_policyold = ""
            nv_fdateold  = ?
            nv_policy    = wdetail2.policy
            nv_status    = "NEW".
        END.
         /*---- End Find Cedpol --------*/

        FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE sicuw.uwm100.policy  = wdetail2.policy
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN DO:
                IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
                nv_texterror = nv_texterror + "เลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว" .
            END.
        END.
                                                              
        nv_line   = nv_line  + 1.
          
        IF nv_texterror <> "" THEN DO: 
           ASSIGN  nv_polflg   = NO
                   nv_reccount = nv_reccount + 1.
        END.
        ELSE nv_polflg = YES.

        ASSIGN
            nv_poltotal  = nv_poltotal  + 1 
            nv_premtotal = nv_premtotal + (DECI(wdetail2.prem) )
            nv_sitotal   = nv_sitotal   + nv_si.

        FIND sic_bran.uwm100 USE-INDEX uwm10001  WHERE 
           sic_bran.uwm100.policy  = nv_policy AND
           sic_bran.uwm100.rencnt  = nv_rencnt AND
           sic_bran.uwm100.endcnt  = nv_endcnt AND
           sic_bran.uwm100.Bchyr   = nv_Bchyr  AND
           sic_bran.uwm100.Bchno   = nv_Bchno  AND
           sic_bran.uwm100.Bchcnt  = nv_Bchcnt
        NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwm100 THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
             nv_texterror = nv_texterror + "พบข้อมูลมีอยู่แล้วที่ Gwtransfer:Policy Master (uwm100)".
           
        END.
        ELSE  RUN Pd_Create.  /*Create Data To Database*/
              
        IF nv_texterror <> "" THEN DO:
          PUT STREAM nerror
              wdetail2.recno      "|"  
              wdetail2.policy     "|"  
              wdetail2.comdat     "|"  
              wdetail2.tname      "|"  
              wdetail2.name1      "|"  
              wdetail2.cpolno     "|"  
              wdetail2.addr       "|"  
              wdetail2.model      "|"  
              wdetail2.vehreg     "|"  
              wdetail2.vehyear    "|"  
              wdetail2.cha_no     "|"  
              wdetail2.eng_no     "|"  
              wdetail2.cc         "|"  
              wdetail2.sname      "|"  
              wdetail2.seat       "|"  
              wdetail2.class      "|"  
              wdetail2.body       "|"  
              wdetail2.prem       "|"  
              wdetail2.stamp      "|"  
              wdetail2.vat        "|"  
              wdetail2.gross      "|"  
              wdetail2.comyear    "|"  
              wdetail2.mile       "|"  
              wdetail2.sign       "|"  
              
              nv_texterror "|"
          SKIP.

          ASSIGN
            nv_polerror  = nv_polerror  + 1 
            nv_premerror = nv_premerror + deci(wdetail2.prem) 
            nv_sierror   = nv_sierror   + nv_si. 
        END.
        ELSE DO:
              PUT STREAM nnoterror
                    wdetail2.recno      "|"  
                    wdetail2.policy     "|"  
                    wdetail2.comdat     "|"  
                    wdetail2.tname      "|"  
                    wdetail2.name1      "|"  
                    wdetail2.cpolno     "|"  
                    wdetail2.addr       "|"  
                    wdetail2.model      "|"  
                    wdetail2.vehreg     "|"  
                    wdetail2.vehyear    "|"  
                    wdetail2.cha_no     "|"  
                    wdetail2.eng_no     "|"  
                    wdetail2.cc         "|"  
                    wdetail2.sname      "|"  
                    wdetail2.seat       "|"  
                    wdetail2.class      "|"  
                    wdetail2.body       "|"  
                    wdetail2.prem       "|"  
                    wdetail2.stamp      "|"  
                    wdetail2.vat        "|"  
                    wdetail2.gross      "|"  
                    wdetail2.comyear    "|"  
                    wdetail2.mile       "|"  
                    wdetail2.sign       "|"  

              SKIP.
    
              ASSIGN
                nv_polsuccess  = nv_polsuccess  + 1 
                nv_premsuccess = nv_premsuccess + deci(wdetail2.prem) 
                nv_sisuccess   = nv_sisuccess   + nv_si. 
        END.
          

    END. /*For each wdetail2 */     

    OPEN QUERY br_main FOR EACH wdetail2 WHERE wdetail2.policy <> "" NO-LOCK.    

     
    ASSIGN
       fi_policytotal   = nv_poltotal
       fi_premtotal     = nv_premtotal
       fi_policysuccess = nv_polsuccess
       fi_premsuccess   = nv_premsuccess.     
    DISP fi_policytotal fi_premtotal fi_policysuccess fi_premsuccess WITH FRAME fr_main.

    RUN Pd_Batch. /* Create uzm701.*/

    /*--------Sum Si & Prem Error------------*/
    PUT STREAM nerror
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         "Total" "|"
         nv_premerror "|"
         nv_comerror  "|"
         " " "|"
         " " "|"
         nv_sierror "|"
         " " "|"
    SKIP. 

    /*--------Sum Si & Prem Success------------*/
    PUT STREAM nnoterror
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         " " "|"
         "Total" "|"
         nv_premsuccess "|"
         nv_comsuccess "|"
         " " "|"
         " " "|"
         nv_sisuccess "|"
    SKIP. 
 
    /*----------------- Screen Data.-------------*/
    OUTPUT STREAM nbatch TO VALUE(INPUT fi_output3).
    PUT STREAM nbatch

     "--- GWTRANSFER : LOAD POLICY EXTENED WARRANTY FOR NISSAN ---" SKIP
     "             Trandate : " INPUT fi_trndat                           SKIP
     "               Branch : " INPUT fi_bran   "  " INPUT fi_brandesc    SKIP
     "        Producer Code : " INPUT fi_acno1  "  " INPUT fi_acdesc      SKIP
     "           Agent Code : " INPUT fi_agent  "  " INPUT fi_agdesc      SKIP
     "             Vat Code : " INPUT fi_vatcode " " INPUT fi_vatdesc     SKIP   /* Add Watsana K. [A57-0115] */
     "    Previous Batch No : " INPUT fi_prvbatch                         SKIP
     "           Batch Year : " INPUT fi_Bchyr                          SKIP
     " Input file name Load : " INPUT fi_input                            SKIP
     "     Output Data Load : " INPUT fi_output1                          SKIP                
     " Output Data Not Load : " INPUT fi_output2                          SKIP         
     "      Batch File Name : " INPUT fi_output3                          SKIP     
     "  Policy Import Total : " INPUT fi_policyinput                      SKIP
     " Premium Import Total : " INPUT fi_preminput  " BHT."               SKIP(1)
     "            Batch No. : " INPUT fi_batch                            SKIP(1)
     "         Record Total : " INPUT fi_policytotal                      SKIP
     "        Premium Total : " INPUT fi_premtotal  " BHT."               SKIP
     "       Record Success : " INPUT fi_policysuccess                    SKIP
     "      Premium Success : " INPUT fi_premsuccess  " BHT."             SKIP.

    OUTPUT STREAM nerror    CLOSE.
    OUTPUT STREAM nnoterror CLOSE.
    OUTPUT STREAM nbatch    CLOSE.

    IF nv_batflg = NO AND n_count <> 0 THEN DO:  
        ASSIGN
            fi_policysuccess:FGCOLOR = 6
            fi_premsuccess:FGCOLOR   = 6 
            fi_batch:FGCOLOR         = 6. 
        DISP fi_policysuccess fi_premsuccess WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_Bchyr)     SKIP
                "Batch No.   : " nv_Bchno             SKIP
                "Batch Count : " STRING(nv_Bchcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please check Data again."      
        VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES AND n_count <> 0 THEN DO: 
        ASSIGN
            fi_policysuccess:FGCOLOR = 2
            fi_premsuccess:FGCOLOR   = 2 
            fi_batch:FGCOLOR         = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        DISP fi_policysuccess fi_premsuccess fi_batch WITH FRAME fr_main.        
    END.

    RELEASE uzm700.         
    RELEASE uzm701.         
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xtm600. 
    RELEASE sicsyac.xmm600. 
    RELEASE sicsyac.xzm056. 

 END. /*End do with frame fr_main*/    
 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwd102 C-Win 
PROCEDURE pd_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 1.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
    DO WHILE nv_line1 <= 4:
        CREATE wuppertxt3.
        wuppertxt3.line = nv_line1.
        IF nv_line1 = 1  THEN wuppertxt3.txt = "Vehicle purchase date : " + string(wdetail2.comdat).  
        IF nv_line1 = 2  THEN wuppertxt3.txt = "Date first registered : " + string(wdetail2.comdat).  
        IF nv_line1 = 3  THEN wuppertxt3.txt = "Type of plan : " + n_text .             
        nv_line1 = nv_line1 + 1.                                                   
    END.
    IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
            FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr
                NO-ERROR NO-WAIT.
            IF AVAILABLE sic_bran.uwd102 THEN DO:  
                nv_fptr = sic_bran.uwd102.fptr.
                CREATE sic_bran.uwd102.
                ASSIGN
                    sic_bran.uwd102.policy        = sic_bran.uwm100.policy      
                    sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt
                    sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt      
                    sic_bran.uwd102.bptr          = nv_bptr
                    sic_bran.uwd102.fptr          = 0
                    uwd102.ltext                  = sic_bran.uwd102.ltext.  
                IF nv_bptr <> 0 THEN DO:
                    FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_bptr NO-ERROR NO-WAIT.
                    sic_bran.uwd102.fptr = RECID(uwd102).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
                nv_bptr = RECID(sic_bran.uwd102).
            END.
            ELSE DO:    
                HIDE MESSAGE NO-PAUSE.
                MESSAGE "not found " sic_bran.uwd102.policy sic_bran.uwd102.rencnt "/"
                    sic_bran.uwd102.endcnt "on file sic_bran.uwd102".
                LEAVE.
            END.
        END.
    END.
    ELSE DO:
        Assign            
            nv_fptr = 0 
            nv_bptr = 0  
            nv_nptr = 0. 
        FOR EACH wuppertxt3 NO-LOCK BREAK BY wuppertxt3.line:
            CREATE sic_bran.uwd102.
            ASSIGN
                sic_bran.uwd102.policy        = sic_bran.uwm100.policy        
                sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
                sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt        
                sic_bran.uwd102.ltext         = wuppertxt3.txt
                nv_nptr        =     Recid(sic_bran.uwd102).
            If  nv_fptr  = 0  And  nv_bptr = 0 Then      
                Assign        
                sic_bran.uwm100.fptr02  = Recid(sic_bran.uwd102)                   
                sic_bran.uwd102.fptr    = 0  
                sic_bran.uwd102.bptr    = 0                                  
                nv_nptr        =  Recid(sic_bran.uwd102)
                nv_bptr        =  Recid(sic_bran.uwd102).
            ELSE DO:
                Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_bptr No-Error. 
                If  Avail  sic_bran.uwd102   Then    sic_bran.uwd102.fptr   =  nv_nptr.
                Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_nptr No-Error.
                If Avail sic_bran.uwd102 Then Do :
                    sic_bran.uwd102.bptr  =      nv_bptr.
                    nv_bptr      =      Recid(sic_bran.uwd102).             
                END.
            END.
        END.
        sic_bran.uwm100.bptr02         =       Recid(uwd102).
        sic_bran.uwd102.fptr           =      0.  
        IF nv_bptr = 0 THEN  
            sic_bran.uwm100.fptr02 = RECID(uwd102).
        nv_bptr = RECID(uwd102).
    END.
    sic_bran.uwm100.bptr02 = nv_bptr.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwd132 C-Win 
PROCEDURE pd_uwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    CREATE sic_bran.uwd132.
    ASSIGN
      sic_bran.uwd132.bencod  = "EXWA"           /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""               /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO               /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = DECI(wdetail2.prem)    /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"              /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = deci(wdetail2.prem)    /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                /*Backward Pointer*/
      sic_bran.uwd132.policy  = nv_policy        /*Policy No. - sic_bran.uwm130*/
      sic_bran.uwd132.rencnt  = nv_rencnt        /*Renewal Count - sic_bran.uwm130*/
      sic_bran.uwd132.endcnt  = nv_endcnt        /*Endorsement Count - sic_bran.uwm130*/
      sic_bran.uwd132.riskgp  = 0                /*Risk Group - sic_bran.uwm130*/
      sic_bran.uwd132.riskno  = 1                /*Risk No. - sic_bran.uwm130*/
      sic_bran.uwd132.itemno  = 1                /*Insured Item No. - sic_bran.uwm130*/
      sic_bran.uwd132.rateae  = NO               /*Premium Rate % A/E Code*/
      sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)    /*First sic_bran.uwd132 Cover & Premium*/
      sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132).   /*Last  sic_bran.uwd132 Cover & Premium*/
    
    ASSIGN
      sic_bran.uwd132.bchyr   = nv_Bchyr          /* batch Year */
      sic_bran.uwd132.bchno   = nv_Bchno          /* batchno    */
      sic_bran.uwd132.bchcnt  = nv_Bchcnt.        /* batcnt     */

    ASSIGN
      nv_recid130   = RECID(sic_bran.uwm130)
      nv_recid132   = RECID(sic_bran.uwd132).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwd200 C-Win 
PROCEDURE pd_uwd200 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

CREATE sic_bran.uwd200.
ASSIGN
  sic_bran.uwd200.policy  = nv_policy     /*Policy No. - sic_bran.uwm200*/
  sic_bran.uwd200.rencnt  = nv_rencnt     /*Renewal Count  - sic_bran.uwm200*/
  sic_bran.uwd200.endcnt  = nv_endcnt     /*Endorsement Count - sic_bran.uwm200*/
  sic_bran.uwd200.c_enct  = 0             /*Cession Endt. Count - sic_bran.uwm200*/
  sic_bran.uwd200.csftq   = "T"           /*Co/Stat/Fac/Tty/Qs - sic_bran.uwm200*/
  sic_bran.uwd200.rico    = "0RET"        /*RI Company/Treaty - sic_bran.uwm200*/
  sic_bran.uwd200.riskgp  = 0             /*Risk Group*/
  sic_bran.uwd200.riskno  = 1             /*Risk No.*/
  sic_bran.uwd200.risiae  = YES           /*RI SI A/E*/
  sic_bran.uwd200.risi    = 0             /*RI SI*/
  sic_bran.uwd200.risiid  = 0             /*RI SI Increase/Decrease*/
  sic_bran.uwd200.risi_p  = 100             /*RI SI %*/
  sic_bran.uwd200.ripsae  = NO            /*RI Premium A/E*/
  sic_bran.uwd200.ripr    = deci(wdetail2.prem)  /*RI Premium*/
  sic_bran.uwd200.ric1ae  = YES            /*RI Commission 1 A/E*/
  sic_bran.uwd200.ric2ae  = YES           /*RI Commission 2 A/E*/
  sic_bran.uwd200.ric1    = 0       /*RI Commission 1*/
  sic_bran.uwd200.ric2    = 0             /*RI Commission 2*/
  sic_bran.uwd200.fptr    = 0             /*Forward Pointer*/
  sic_bran.uwd200.bptr    = 0             /*Backward pointer*/
  sic_bran.uwd200.sicurr  = "BHT".        /*Sum Insured Currency*/

ASSIGN
  sic_bran.uwd200.bchyr   = nv_Bchyr     /* batch Year */
  sic_bran.uwd200.bchno   = nv_Bchno     /* batchno    */
  sic_bran.uwd200.bchcnt  = nv_Bchcnt.   /* batcnt     */

ASSIGN
  sic_bran.uwm200.fptr01  = RECID(sic_bran.uwd200)   /*First sic_bran.uwd200 RI Out Premium*/
  sic_bran.uwm200.bptr01  = RECID(sic_bran.uwd200).  /*Last sic_bran.uwd200 RI Out Premium*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm100 C-Win 
PROCEDURE pd_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Policy Header      
------------------------------------------------------------------------------*/
DEF VAR nv_undyr  AS CHARACTER FORMAT "X(4)"  INITIAL "".
DEF VAR n_name2   AS CHARACTER FORMAT "x(50)" INITIAL "".
DEF VAR n_addr2   AS CHARACTER FORMAT "x(50)" INITIAL "". 

ASSIGN n_addr2   = ""
       n_name2   = ""
       nv_check  = ""
       nv_poltyp = "M86" 
       nv_dept   = "C"
       nv_gstrat = 7  
       nv_si     = 0
       nv_rencnt    = 0
       nv_endcnt    = 0 .

/*---- Name  -----*/
n_name2 = "และ/หรือ " + TRIM(wdetail2.sign) .

/*---- Address ----*/
wdetail2.addr = TRIM(wdetail2.addr).

IF INDEX(wdetail2.addr,"อ.") <> 0 THEN DO: 
    ASSIGN n_addr2       = TRIM(SUBSTRING(wdetail2.addr,INDEX(wdetail2.addr,"อ."),LENGTH(wdetail2.addr)))
           wdetail2.addr = TRIM(SUBSTRING(wdetail2.addr,1,INDEX(wdetail2.addr,"อ.")- 2 )).
END.
ELSE IF INDEX(wdetail2.addr,"แขวง") <> 0 THEN DO:
    ASSIGN n_addr2       = TRIM(SUBSTRING(wdetail2.addr,INDEX(wdetail2.addr,"แขวง"),LENGTH(wdetail2.addr)))
           wdetail2.addr = TRIM(SUBSTRING(wdetail2.addr,1,INDEX(wdetail2.addr,"แขวง")- 4 )).
END.
   
IF n_cdate <> ? THEN nv_undyr = STRING(YEAR(nv_trndat)).
ELSE nv_undyr = "".

CREATE sic_bran.uwm100.
ASSIGN
  sic_bran.uwm100.curbil = "BHT"                         /*Currency of Billing*/
  sic_bran.uwm100.curate = 1                             /*Currency rate for Billing*/
  sic_bran.uwm100.branch = fi_bran                 /*Branch Code (of Transaction)*/
  /* sic_bran.uwm100.dir_ri = NO                            /*Direct/RI Code (D/R)*/    Block Watsana K. [A57-0115] */
  sic_bran.uwm100.DIR_ri = YES                           /*Direct/RI Code (D/R)*/   /* Add Watsana K. [A57-0115] */
  sic_bran.uwm100.dept   = nv_dept                       /*Department code*/
  sic_bran.uwm100.policy = wdetail2.policy               /*Policy No.*/
  sic_bran.uwm100.rencnt = nv_rencnt                     /*Renewal Count*/
  sic_bran.uwm100.renno  = ""                            /*Renewal No.*/
  sic_bran.uwm100.endcnt = nv_endcnt                     /*Endorsement Count*/
  sic_bran.uwm100.cntry  = "TH"                          /*Country where risk is situated*/
  sic_bran.uwm100.agent  = nv_agent                      /*Agent's Ref. No.*/
  sic_bran.uwm100.poltyp = nv_poltyp                     /*Policy Type*/
  sic_bran.uwm100.insref = ""                            /*Insured's Ref. No.*/
  sic_bran.uwm100.opnpol = ""                            /*Open Cover/Master Policy No.*/
  sic_bran.uwm100.ntitle = TRIM(wdetail2.tname)          /*Title for Name Mr/Mrs/etc*/
  sic_bran.uwm100.fname  = ""                            /*First Name*/
  sic_bran.uwm100.name1  = TRIM(wdetail2.name1)                /*Name of Insured Line 1*/
  sic_bran.uwm100.name2  = n_name2                       /*Name of Insured Line 2*/
  sic_bran.uwm100.name3  = ""                            /*Name of Insured Line 3*/
  sic_bran.uwm100.addr1  = TRIM(wdetail2.addr)                 /*Address 1*/
  sic_bran.uwm100.addr2  = n_addr2                       /*Address 2*/
  sic_bran.uwm100.postcd = ""                            /*Postal Code*/
  sic_bran.uwm100.occupn = "".                           /*Occupation Description*/
                                          
ASSIGN                                                   
  sic_bran.uwm100.comdat = n_cdate                       /*Cover Commencement Date*/
  sic_bran.uwm100.expdat = n_edate                       /*Expiry Date*/
  sic_bran.uwm100.accdat = n_cdate                       /*Acceptance Date*/
  sic_bran.uwm100.trndat = nv_trndat                     /*Transaction Date*/
  sic_bran.uwm100.rendat = ?                             /*Date Renewal Notice Printed*/
  sic_bran.uwm100.terdat = ?                             /*Termination Date*/
  sic_bran.uwm100.cn_dat = ?                             /*Cover Note Date*/
  sic_bran.uwm100.cn_no  = 0                             /*Cover Note No.*/
  sic_bran.uwm100.undyr  = nv_undyr                      /*Underwriting Year*/
  sic_bran.uwm100.acno1  = nv_acno1                      /*Account no. 1*/
  sic_bran.uwm100.acno2  = ""                            /*Account no. 2*/
  sic_bran.uwm100.acno3  = ""                            /*Account no. 3*/
  sic_bran.uwm100.instot = 1                             /*Total No. of Instalments*/
  sic_bran.uwm100.pstp   = 0                             /*Policy Level Stamp*/
  sic_bran.uwm100.pfee   = 0                             /*Policy Level Fee*/
  sic_bran.uwm100.ptax   = 0                             /*Policy Level Tax*/
  sic_bran.uwm100.rstp_t = DECI(wdetail2.stamp)                /*Risk Level Stamp, Tran. Total*/
  sic_bran.uwm100.rfee_t = 0                             /*Risk Level Fee, Tran. Total*/
  sic_bran.uwm100.rtax_t = DECI(wdetail2.vat)                  /*Risk Level Tax, Tran. Total*/
  sic_bran.uwm100.prem_t = DECI(wdetail2.prem)                 /*Premium Due, Tran. Total*/
  sic_bran.uwm100.pdco_t = 0                             /*PD Coinsurance, Tran. Total*/
  sic_bran.uwm100.pdst_t = 0                             /*PD Statutory, Tran. total*/
  sic_bran.uwm100.pdfa_t = 0                             /*PD Facultative, Tran. Total*/
  sic_bran.uwm100.pdty_t = 0                             /*PD Treaty, Tran. Total*/
  sic_bran.uwm100.pdqs_t = 0                             /*PD Quota Share, Tran. Total*/
  sic_bran.uwm100.com1_t = 0                             /*Commission 1, Tran. Total*/
  sic_bran.uwm100.com2_t = 0                                   /*Commission 2, Tran. Total*/
  sic_bran.uwm100.com3_t = 0                             /*Commission 3, Tran. Total*/
  sic_bran.uwm100.com4_t = 0                             /*Commission 4, Tran. Total*/
  sic_bran.uwm100.coco_t = 0                              /*Comm. Coinsurance, Tran Total*/
  sic_bran.uwm100.cost_t = 0                              /*Comm. Statutory, Tran. Total*/
  sic_bran.uwm100.cofa_t = 0                              /*Comm. Facultative, Tran. To*/
  sic_bran.uwm100.coty_t = 0                              /*Comm. Treaty, Tran. Total*/
  sic_bran.uwm100.coqs_t = 0                              /*Comm. Quota Share, Tran. Total*/
  sic_bran.uwm100.reduc1 = NO                            /*Reducing Balance 1 (Y/N)*/
  sic_bran.uwm100.reduc2 = NO                            /*Reducing Balance 2 (Y/N)*/
  sic_bran.uwm100.reduc3 = NO.                           /*Reducing Balance 3 (Y/N)*/
                                                         
ASSIGN                                                   
  sic_bran.uwm100.gap_p  = DECI(wdetail2.prem)                      /*Gross Annual Prem, Pol. Total*/
  sic_bran.uwm100.dl1_p  = 0                             /*Discount/Loading 1, Pol. Total*/
  sic_bran.uwm100.dl2_p  = 0                             /*Discount/Loading 2, Pol. Total*/
  sic_bran.uwm100.dl3_p  = 0                             /*Discount/Loading 3, Pol. Total*/
  sic_bran.uwm100.dl2red = YES                           /*Disc./Load 2 Red. Balance Y/N*/
  sic_bran.uwm100.dl3red = YES                           /*Disc./Load 3 Red. Balance Y/N*/
  sic_bran.uwm100.dl1sch = YES                           /*Disc./Load 1 Prt on Sched. Y/N*/
  sic_bran.uwm100.dl2sch = YES                           /*Disc./Load 2 Prt on Sched. Y/N*/
  sic_bran.uwm100.dl3sch = YES                           /*Disc./Load 3 Prt on Sched. Y/N*/
  sic_bran.uwm100.drnoae = NO                            /*Dr/Cr Note No. (A/E)*/
  sic_bran.uwm100.insddr = NO                            /*Print Insd. Name on DrN*/
  sic_bran.uwm100.trty11 = ""                            /*Tran. Type (1), A/C No. 1*/
  sic_bran.uwm100.trty12 = ""                            /*Tran. Type (1), A/C No. 2*/
  sic_bran.uwm100.trty13 = ""                            /*Tran. Type (1), A/C No. 3*/
  sic_bran.uwm100.docno1 = nv_docno1                     /*Document No., A/C No. 1*/
  sic_bran.uwm100.docno2 = ""                            /*Document No., A/C No. 2*/
  sic_bran.uwm100.docno3 = ""                            /*Document No., A/C No. 3*/
  sic_bran.uwm100.no_sch = 1                             /*No. to print, Schedule*/
  sic_bran.uwm100.no_dr  = 1                             /*No. to print, Dr/Cr Note*/
  sic_bran.uwm100.no_ri  = 1                             /*No. to print, RI Appln*/
  sic_bran.uwm100.no_cer = 0                             /*No. to print, Certificate*/
  sic_bran.uwm100.li_sch = YES                           /*Print Later/Imm., Schedule*/
  sic_bran.uwm100.li_dr  = YES                           /*Print Later/Imm., Dr/Cr Note*/
  sic_bran.uwm100.li_ri  = YES                           /*Print Later/Imm., RI Appln,*/
  sic_bran.uwm100.li_cer = YES                           /*Print Later/Imm., Certificate*/
  sic_bran.uwm100.scform = ""                            /*Schedule Format*/
  sic_bran.uwm100.apptax = YES                           /*Apply risk level tax (Y/N)*/
  sic_bran.uwm100.dl1cod = ""                            /*Discount/Loading Type Code 1*/
  sic_bran.uwm100.dl2cod = ""                            /*Discount/Loading Type Code 2*/
  sic_bran.uwm100.dl3cod = ""                            /*Discount/Loading Type Code 3*/
  sic_bran.uwm100.styp20 = ""                            /*Statistic Type Codes (4 x 20)*/
  sic_bran.uwm100.sval20 = ""                            /*Statistic Value Codes (4 x 20)*/
  sic_bran.uwm100.finint = ""                            /*Financial Interest Ref. No.*/
  sic_bran.uwm100.cedco  = ""                            /*Ceding Co. No.*/
 /*  sic_bran.uwm100.cedsi  = nv_cedsi                   /*Ceding Co. Sum Insured*/   Block Watsana K. [A57-0115]  */
  sic_bran.uwm100.cedsi  = 0                             /*Ceding Co. Sum Insured*/  /* Add Watsana K. [A57-0115] */
  sic_bran.uwm100.cedpol = TRIM(wdetail2.cpolno)               /*Open Cover/Master Policy No.*/      
  sic_bran.uwm100.cedces = ""                            /*Ceding Co. Cession No.*/
  sic_bran.uwm100.recip  = "N"                           /*Reciprocal (Y/N/C)*/
 /* sic_bran.uwm100.short  = YES                         /*Short Term Rates*/       Block Watsana K. [A57-0115] */
  sic_bran.uwm100.short  = NO                            /*Short Term Rates*/   /* Add Watsana K. [A57-0115] */
  sic_bran.uwm100.receit = "".                           /*Receipt No.*/
                                                         
ASSIGN                                                   
  sic_bran.uwm100.fptr01 = 0                             /*First uwd100 Policy Upper Text*/
  sic_bran.uwm100.bptr01 = 0                             /*Last  uwd100 Policy Upper Text*/
  sic_bran.uwm100.fptr02 = 0                             /*First uwd102 Policy Memo Text*/
  sic_bran.uwm100.bptr02 = 0                             /*Last  uwd102 Policy Memo Text*/
  sic_bran.uwm100.fptr03 = 0                             /*First uwd105 Policy Clauses*/
  sic_bran.uwm100.bptr03 = 0                             /*Last  uwd105 Policy Clauses*/
  sic_bran.uwm100.fptr04 = 0                             /*First uwd103 Policy Ren. Text*/
  sic_bran.uwm100.bptr04 = 0                             /*Last uwd103 Policy Ren. Text*/
  sic_bran.uwm100.fptr05 = 0                             /*First uwd104 Policy Endt. Text*/
  sic_bran.uwm100.bptr05 = 0                             /*Last uwd104 Policy Endt. Text*/
  sic_bran.uwm100.fptr06 = 0                             /*First uwd106 Pol.Endt.Clauses*/
  sic_bran.uwm100.bptr06 = 0                             /*Last uwd106 Pol. Endt. Clauses*/
  sic_bran.uwm100.coins  = NO                            /*Is this Coinsurance (Y/N)*/
  sic_bran.uwm100.billco = ""                            /*Bill Coinsurer's Share (Y/N)*/
  sic_bran.uwm100.pmhead = ""                            /*Premium Headings on Schedule*/
  sic_bran.uwm100.usrid  = USERID(LDBNAME("sic_bran"))                      /*User Id*/
  sic_bran.uwm100.entdat = nv_trndat                     /*Entered Date*/
  sic_bran.uwm100.enttim = nv_enttim                     /*Entered Time*/
  sic_bran.uwm100.prog   = "WGWIMNIS"                      /*Program Id that input record*/
  sic_bran.uwm100.usridr = ""                            /*Release User Id*/
  sic_bran.uwm100.reldat = ?                             /*Release Date*/
  sic_bran.uwm100.reltim = ""                            /*Release Time*/
  sic_bran.uwm100.rilate = NO                            /*RI to Enter Later*/
  sic_bran.uwm100.releas = NO                            /*Transaction Released*/
  sic_bran.uwm100.sch_p  = NO                            /*Schedule Printed*/
  sic_bran.uwm100.drn_p  = NO                            /*Dr/Cr Note Printed*/
  sic_bran.uwm100.ri_p   = NO                            /*RI Application Printed*/
  sic_bran.uwm100.cert_p = NO                            /*Certificate Printed*/
  sic_bran.uwm100.dreg_p = NO                            /*Daily Prem. Reg. Printed*/
  sic_bran.uwm100.langug = "T"                           /*Language*/
  sic_bran.uwm100.sigr_p = 0                            /*SI Gross Pol. Total*/
  sic_bran.uwm100.sico_p = nv_sicop                      /*SI Coinsurance Pol. Total*/
  sic_bran.uwm100.sist_p = nv_sistp                      /*SI Statutory Pol. Total*/
  sic_bran.uwm100.sifa_p = nv_sifap                      /*SI Facultative Pol. Total*/
  sic_bran.uwm100.sity_p = nv_sityp                      /*SI Treaty Pol. Total*/
  sic_bran.uwm100.siqs_p = nv_siqsp                      /*SI Quota Share Pol. Total*/
  sic_bran.uwm100.co_per = 0                             /*Coinsurance %*/
  sic_bran.uwm100.acctim = "00:00"                       /*Acceptance Time*/
  sic_bran.uwm100.agtref = ""                            /*Agents Closing Reference*/
  sic_bran.uwm100.sckno  = 0                             /*sticker no.*/
  sic_bran.uwm100.anam1  = ""                            /*Alternative Insured Name 1*/
  sic_bran.uwm100.sirt_p = 0                             /*SI RETENTION Pol. total*/
  sic_bran.uwm100.anam2  = ""                            /*Alternative Insured Name 2*/
  sic_bran.uwm100.gstrat = 7                             /*GST Rate %*/
  sic_bran.uwm100.prem_g = 0                             /*Premium GST*/
  sic_bran.uwm100.com1_g = 0                             /*Commission 1 GST*/
  sic_bran.uwm100.com3_g = 0                             /*Commission 3 GST*/
  sic_bran.uwm100.com4_g = 0                             /*Commission 4 GST*/
  sic_bran.uwm100.gstae  = YES                           /*GST A/E*/
  sic_bran.uwm100.nr_pol = NO                            /*New Policy No. (Y/N)*/
  sic_bran.uwm100.issdat = nv_trndat                     /*Issue date*/
  sic_bran.uwm100.cr_1   = ""                            /*A/C 1 cash(C)/credit(R) agent*/
  sic_bran.uwm100.cr_2   = ""                            /*Appened กรมธรรม์ พ่วง */
  sic_bran.uwm100.cr_3   = ""                            /*A/C 3 cash(C)/credit(R) agent*/
  sic_bran.uwm100.rt_er  = NO                            /*Batch Release*/
  sic_bran.uwm100.endern = ?                             /*Receipt Date*/  /*== Add By Chutikarn A53-0015 ==*/
  sic_bran.uwm100.bs_cd  = nv_vatcode .                  /*Vat Code */   /* Add Watsana K. [A57-0115] */

 
  IF nv_status = "END" OR nv_status = "CAN" THEN DO: /*--Endorse And Cancel--*/
     IF nv_status = "CAN" THEN DO:
          ASSIGN
           sic_bran.uwm100.polsta = "CA"
           sic_bran.uwm100.tranty = "C".        /*Transaction Type (N/R/E/C/T)*/
     END.                              
     ELSE DO:                          
          ASSIGN                       
           sic_bran.uwm100.polsta = "IF"        
           sic_bran.uwm100.tranty = "E".        /*Transaction Type (N/R/E/C/T)*/
     END.                              
     ASSIGN                            
         sic_bran.uwm100.prvpol = nv_prvpol     /*Prvpol Policy No.*/
         sic_bran.uwm100.enddat = nv_trndat     /*Endorsement Date*/
         sic_bran.uwm100.fstdat = nv_fdateold   /*First Issue Date of Policy*/
         sic_bran.uwm100.renpol = nv_renpol     /*Renewal Policy No.*/
         sic_bran.uwm100.enform = "F"           /*Endt. Format (Full/Abbr/Blank)*/
         sic_bran.uwm100.endno  = nv_endnum.    /*Endorsement No.*/
  END.
  
  ELSE IF nv_status = "REP" OR nv_status = "REN" THEN DO: /*--Renew--*/
     ASSIGN
         sic_bran.uwm100.polsta = "IF"
         sic_bran.uwm100.prvpol = nv_policyold   /*Prvpol Policy No.*/
         sic_bran.uwm100.enddat = ?              /*Endorsement Date*/
         sic_bran.uwm100.fstdat = nv_fdateold    /*First Issue Date of Policy*/
         sic_bran.uwm100.renpol = ""             /*Renewal Policy No.*/
         sic_bran.uwm100.tranty = "R"            /*Transaction Type (N/R/E/C/T)*/
         sic_bran.uwm100.enform = ""             /*Endt. Format (Full/Abbr/Blank)*/
         sic_bran.uwm100.endno  = "".            /*Endorsement No.*/
  END.
  ELSE IF (nv_endcnt = 0 AND nv_rencnt = 0) AND (nv_status = "NEW") THEN DO: /*--New--*/
     ASSIGN
         sic_bran.uwm100.polsta = "IF"
         sic_bran.uwm100.prvpol = ""                /*Prvpol Policy No.*/
         sic_bran.uwm100.enddat = ?                 /*Endorsement Date*/
         sic_bran.uwm100.fstdat = n_cdate            /*First Issue Date of Policy*/
         sic_bran.uwm100.renpol = ""                /*Renewal Policy No.*/
         sic_bran.uwm100.tranty = "N"               /*Transaction Type (N/R/E/C/T)*/
         sic_bran.uwm100.enform = ""                /*Endt. Format (Full/Abbr/Blank)*/
         sic_bran.uwm100.endno  = "".               /*Endorsement No.*/
  END.                                              
                                            
  ASSIGN                                            
      sic_bran.uwm100.bchyr     = nv_Bchyr          /*Batch Year */  
      sic_bran.uwm100.bchno     = nv_Bchno          /*Batch No.  */  
      sic_bran.uwm100.bchcnt    = nv_Bchcnt         /*Batch Count*/  
      sic_bran.uwm100.impflg    = nv_polflg         /*Policy Flag*/
      sic_bran.uwm100.imperr    = nv_texterror      /*Detail Error*/
      sic_bran.uwm100.impusrid  = USERID(LDBNAME("sic_bran"))
      sic_bran.uwm100.impdat    = TODAY
      sic_bran.uwm100.imptim    = STRING(TIME,"HH:MM:SS").
  

  nv_recid100 = RECID(sic_bran.uwm100).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm120 C-Win 
PROCEDURE pd_uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_bclass AS CHARACTER FORMAT "X(04)" .
DEF VAR n_rtext  AS CHARACTER FORMAT "X(04)" .
DEF VAR n_tafiff AS CHAR      FORMAT "x" .
DEF VAR n_year   AS CHAR      FORMAT "x(3)".
DEF VAR n_mile   AS CHAR      FORMAT "x(10)".

/* ------------ RISK HEADER ------------ */
ASSIGN
    nv_check = ""
    n_bclass = ""
    n_rtext  = ""
    n_tafiff = "" 
    n_year   = ""
    n_mile   = ""
    n_text   = "".

ASSIGN
   n_tafiff = "0" 
   n_year   = TRIM(wdetail2.comyear) .
   n_mile   = TRIM(String(INTEGER(wdetail2.mile),">>>,>>9")) .
  

FIND FIRST sicsyac.xmm016 USE-INDEX xmm01602  WHERE substring(sicsyac.xmm016.clsdes,1,1) = n_year
                                                AND INDEX(sicsyac.xmm016.clsdes,n_mile) <> 0  
NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm016 THEN  DO:
  n_bclass = sicsyac.xmm016.class .
  n_text   = sicsyac.xmm016.clsdes.
END.

CREATE sic_bran.uwm120.
ASSIGN
  sic_bran.uwm120.policy   = wdetail2.policy        /*Policy No. */
  sic_bran.uwm120.rencnt   = nv_rencnt              /*Renewal Count*/
  sic_bran.uwm120.endcnt   = nv_endcnt              /*Endorsement Count*/
  sic_bran.uwm120.riskgp   = 0                      /*Risk Group */
  sic_bran.uwm120.riskno   = 1                      /*Risk No. */
  sic_bran.uwm120.fptr01   = 0                      /*First uwd120 Risk Upper Text */
  sic_bran.uwm120.bptr01   = 0                      /*Last  uwd120 Risk Upper Text */
  sic_bran.uwm120.fptr02   = 0                      /*First uwd121 Risk Lower Text */
  sic_bran.uwm120.bptr02   = 0                      /*Last  uwd121 Risk Lower Text */
  sic_bran.uwm120.fptr03   = 0                      /*First uwd123 Borderau Text */
  sic_bran.uwm120.bptr03   = 0                      /*Last  uwd123 Borderau Text */
  sic_bran.uwm120.fptr04   = 0                      /*First uwd125 Risk Clauses*/
  sic_bran.uwm120.bptr04   = 0                      /*Last  uwd125 Risk Clauses*/
  sic_bran.uwm120.fptr08   = 0                      /*First uwd124 Risk Endt. Text */
  sic_bran.uwm120.bptr08   = 0                      /*Last uwd124 Risk Endt. Text*/
  sic_bran.uwm120.fptr09   = 0                      /*First uwd126 Risk Endt. Clause */
  sic_bran.uwm120.bptr09   = 0                      /*Last uwd126 Risk Endt. Clause*/
  sic_bran.uwm120.class    = n_bclass               /*Business Class Code*/
  sic_bran.uwm120.sicurr   = "BHT"                  /*Sum Insured Currency */
  sic_bran.uwm120.siexch   = 1                      /*Sum Insured Exchange Rate*/
  sic_bran.uwm120.r_text   = ""                     /*Standard Risk Text Ref. No.*/
  sic_bran.uwm120.rskdel   = NO                     /*Risk Deleted (Y/N) */
  sic_bran.uwm120.styp20   = ""                     /*Statistic Type Codes (4 x 20)*/
  sic_bran.uwm120.sval20   = ""                     /*Statistic Value Codes (4 x 20) */
  sic_bran.uwm120.gap_r    = DECI(wdetail2.prem)    /*Gross Annual Prem., Risk Total */
  sic_bran.uwm120.dl1_r    = 0                      /*Discount/Loading 1, Risk Total */
  sic_bran.uwm120.dl2_r    = 0                      /*Discount/Loading 2, Risk Total */
  sic_bran.uwm120.dl3_r    = 0                      /*Discount/Loading 3, Risk Total */
  sic_bran.uwm120.rstp_r   = DECI(wdetail2.stamp)   /*Risk Level Stamp, Risk Total */
  sic_bran.uwm120.rfee_r   = 0                      /*Risk Level Fee, Risk Total */
  sic_bran.uwm120.rtax_r   = DECI(wdetail2.vat)     /*Risk Level Tax, Risk Total */
  sic_bran.uwm120.prem_r   = DECI(wdetail2.prem)    /*Premium Due, Risk Total*/
  sic_bran.uwm120.com1_r   = 0                      /*Commission 1, Risk Total */
  sic_bran.uwm120.com2_r   = 0                      /*Commission 2, Risk Total */
  sic_bran.uwm120.com3_r   = 0                      /*Commission 3, Risk Total */
  sic_bran.uwm120.com4_r   = 0                      /*Commission 4, Risk Total */
  sic_bran.uwm120.com1p    = 0                      /*Commission 1 % */
  sic_bran.uwm120.com2p    = 0                      /*Commission 2 % */
  sic_bran.uwm120.com3p    = 0                      /*Commission 3 % */
  sic_bran.uwm120.com4p    = 0                      /*Commission 4 % */
  sic_bran.uwm120.com1ae   = YES                     /*Commission 1 (A/E) */
  sic_bran.uwm120.com2ae   = YES                    /*Commission 2 (A/E) */
  sic_bran.uwm120.com3ae   = YES                    /*Commission 3 (A/E) */
  sic_bran.uwm120.com4ae   = YES                    /*Commission 4 (A/E) */
  sic_bran.uwm120.rilate   = NO                     /*RI to Enter Later (Y/N)*/
  sic_bran.uwm120.sigr     = 0                      /*Sum Insured, Gross */
  sic_bran.uwm120.sico     = nv_sicop               /*Sum Insured, Coinsurance */
  sic_bran.uwm120.sist     = nv_sistp               /*Sum Insured, Statutory */
  sic_bran.uwm120.sifac    = nv_sifap               /*Sum Insured, Facultative */
  sic_bran.uwm120.sitty    = nv_sityp               /*Sum Insured, Treaty*/
  sic_bran.uwm120.siqs     = nv_siqsp               /*Sum Insured, Quota Share */
  sic_bran.uwm120.pdco     = nv_pdcop               /*Premium Due, Coinsurance */
  sic_bran.uwm120.pdst     = nv_pdstp               /*Premium Due, Statutory */
  sic_bran.uwm120.pdfac    = nv_pdfap               /*Premium Due, Facultative */
  sic_bran.uwm120.pdtty    = nv_pdtyp               /*Premium Due, Treaty*/
  sic_bran.uwm120.pdqs     = nv_pdqsp               /*Premium Due, Quota Share */
  sic_bran.uwm120.comco    = nv_comco               /*Commission, Coinsurance*/
  sic_bran.uwm120.comst    = nv_comst               /*Commission, Statutory*/
  sic_bran.uwm120.comfac   = nv_comfa               /*Commission, Facultative*/
  sic_bran.uwm120.comtty   = nv_comty               /*Commission, Treaty */
  sic_bran.uwm120.comqs    = nv_comqs               /*Commission, Quota Share*/
  sic_bran.uwm120.stmpae   = YES                    /*Risk Level Stamp (A/E) */
  sic_bran.uwm120.feeae    = YES                    /*Risk Level Fee (A/E) */
  sic_bran.uwm120.taxae    = YES                    /*Risk Level Tax (A/E) */
  sic_bran.uwm120.siret    = 0.                     /*SI Retention */

ASSIGN                                     
  sic_bran.uwm120.bchyr  = nv_Bchyr           /* batch Year */ 
  sic_bran.uwm120.bchno  = nv_Bchno           /* batchno    */ 
  sic_bran.uwm120.bchcnt = nv_Bchcnt .        /* batcnt     */ 

  nv_recid120   = RECID(sic_bran.uwm120).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm130 C-Win 
PROCEDURE pd_uwm130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_itext  AS CHARACTER FORMAT "X(04)" INIT "".
DEF VAR n_uom1c  AS CHARACTER FORMAT "X(03)" INIT "".
/* ------------ INSURED ITEM ------------ */
nv_check = "".

CREATE sic_bran.uwm130.
ASSIGN
  sic_bran.uwm130.policy    = nv_policy   /*Policy No.*/
  sic_bran.uwm130.rencnt    = nv_rencnt   /*Renewal Count*/
  sic_bran.uwm130.endcnt    = nv_endcnt   /*Endorsement Count*/
  sic_bran.uwm130.riskgp    = 0           /*Risk Group*/
  sic_bran.uwm130.riskno    = 1           /*Risk No.*/
  sic_bran.uwm130.itemno    = 1           /*Item No.*/
  sic_bran.uwm130.i_text    = n_itext     /*Std. Item Text Ref. No.*/
  sic_bran.uwm130.uom1_c    = n_uom1c     /*UOM 1 Code*/
  sic_bran.uwm130.uom2_c    = ""          /*UOM 2 Code*/
  sic_bran.uwm130.uom3_c    = ""          /*UOM 3 Code*/
  sic_bran.uwm130.uom4_c    = ""          /*UOM 4 Code*/
  sic_bran.uwm130.uom5_c    = ""          /*UOM 5 Code*/
  sic_bran.uwm130.uom6_c    = ""          /*UOM 6 Code*/
  sic_bran.uwm130.uom7_c    = ""          /*UOM 7 Code*/
  sic_bran.uwm130.uom1_v    = nv_si       /*UOM 1 Value*/
  sic_bran.uwm130.uom2_v    = 0           /*UOM 2 Value*/
  sic_bran.uwm130.uom3_v    = 0           /*UOM 3 Value*/
  sic_bran.uwm130.uom4_v    = 0           /*UOM 4 Value*/
  sic_bran.uwm130.uom5_v    = 0           /*UOM 5 Value*/
  sic_bran.uwm130.uom6_v    = 0           /*UOM 6 Value*/
  sic_bran.uwm130.uom7_v    = 0           /*UOM 7 Value*/
  sic_bran.uwm130.uom1_u    = ""          /*UOM 1 Unlimited*/
  sic_bran.uwm130.uom2_u    = ""          /*UOM 2 Unlimited*/
  sic_bran.uwm130.uom3_u    = ""          /*UOM 3 Unlimited*/
  sic_bran.uwm130.uom4_u    = ""          /*UOM 4 Unlimited*/
  sic_bran.uwm130.uom5_u    = ""          /*UOM 5 Unlimited*/
  sic_bran.uwm130.uom6_u    = ""          /*UOM 6 Unlimited*/
  sic_bran.uwm130.uom7_u    = ""          /*UOM 7 Unlimited*/
  sic_bran.uwm130.dl1per    = 0           /*Discount/Loading 1 %*/
  sic_bran.uwm130.dl2per    = 0           /*Discount/Loading 2 %*/
  sic_bran.uwm130.dl3per    = 0           /*Discount/Loading 3 %*/
  sic_bran.uwm130.fptr01    = 0           /*First sic_bran.uwd130 Item Upper text*/
  sic_bran.uwm130.bptr01    = 0           /*Last  sic_bran.uwd130 Item Upper Text*/
  sic_bran.uwm130.fptr02    = 0           /*First sic_bran.uwd131 Item Lower Text*/
  sic_bran.uwm130.bptr02    = 0           /*Last  sic_bran.uwd131 Item Lower Text*/
  sic_bran.uwm130.fptr03    = 0           /*First sic_bran.uwd132 Cover & Premium*/
  sic_bran.uwm130.bptr03    = 0           /*Last  sic_bran.uwd132 Cover & Premium*/
  sic_bran.uwm130.fptr04    = 0           /*First sic_bran.uwd134 Item Endt. Text*/
  sic_bran.uwm130.bptr04    = 0           /*Last sic_bran.uwd134 Item Endt. Text*/
  sic_bran.uwm130.fptr05    = 0           /*First sic_bran.uwd136 Item Endt. Clause*/
  sic_bran.uwm130.bptr05    = 0           /*Last sic_bran.uwd136 Item Endt. Clause*/
  sic_bran.uwm130.styp20    = ""          /*Statistic Type Codes (4 x 20)*/
  sic_bran.uwm130.sval20    = ""          /*Statistic Value Codes (4 x 20)*/
  sic_bran.uwm130.itmdel    = NO          /*Item Deleted*/
  sic_bran.uwm130.uom8_c    = ""          /*UOM 8 Code*/
  sic_bran.uwm130.uom8_v    = 0           /*UOM 8 Value*/
  sic_bran.uwm130.uom9_c    = ""          /*UOM 9 Code*/
  sic_bran.uwm130.uom9_v    = 0           /*UOM 9 Value*/
  sic_bran.uwm130.prem_item = 0.          /*Premium Due,item total*/

ASSIGN
  sic_bran.uwm130.bchyr   = nv_Bchyr     /* batch Year */
  sic_bran.uwm130.bchno   = nv_Bchno     /* batchno    */
  sic_bran.uwm130.bchcnt  = nv_Bchcnt.    /* batcnt     */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm200 C-Win 
PROCEDURE pd_uwm200 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* ------------ RI OUT HEADER ------------ */
nv_check = "".

CREATE sic_bran.uwm200.
ASSIGN
  sic_bran.uwm200.policy    = nv_policy      /*Policy No.*/
  sic_bran.uwm200.rencnt    = nv_rencnt      /*Renewal Count*/
  sic_bran.uwm200.endcnt    = nv_endcnt      /*Endorsement Count*/
  sic_bran.uwm200.c_enct    = 0              /*Cession Endorsement Count*/
  sic_bran.uwm200.csftq     = "T"           /*Co/Stat/Fac/Tty/Qs*/
  sic_bran.uwm200.rico      = "0RET"        /*RI Company/Treaty*/
  sic_bran.uwm200.dept      = "B"            /*Department Code*/
  sic_bran.uwm200.c_no      = 0              /*Cession No.*/
  sic_bran.uwm200.c_enno    = 0              /*Cession Endorsement No.*/
  sic_bran.uwm200.rip1ae    = NO             /*Commission 1% A/E*/
  sic_bran.uwm200.rip2ae    = YES            /*Commission 2% A/E*/
  sic_bran.uwm200.rip1      = 0              /*Commission 1%*/
  sic_bran.uwm200.rip2      = 0              /*Commission 2%*/
  sic_bran.uwm200.recip     = "N"            /*Reciprocal (Y/N/C)*/
  sic_bran.uwm200.ricomm    = n_cdate        /*RI Cover Commencement Date*/
  sic_bran.uwm200.riexp     = n_edate        /*RI Cover Expiry Date*/
  sic_bran.uwm200.trndat    = nv_trndat      /*Transaction Date*/
  sic_bran.uwm200.com2gn    = YES            /*Commission 2 Gross/Net*/
  sic_bran.uwm200.ristmp    = 0              /*Stamp Duty on Cession*/
  sic_bran.uwm200.prntri    = NO             /*Print RI Application Y/N*/
  sic_bran.uwm200.thpol     = ""             /*Their Policy No.*/
  sic_bran.uwm200.c_year    = 0              /*Cession Year*/
  sic_bran.uwm200.trtyri    = ""             /*Tran. Type(1) RI Out*/
  sic_bran.uwm200.docri     = ""             /*Document No.*/
  sic_bran.uwm200.fptr01    = 0              /*First sic_bran.uwd200 RI Out Premium*/
  sic_bran.uwm200.bptr01    = 0              /*Last sic_bran.uwd200 RI Out Premium*/
  sic_bran.uwm200.fptr02    = 0              /*First sic_bran.uwd201 RI Appl. Text*/
  sic_bran.uwm200.bptr02    = 0              /*Last sic_bran.uwd201 RI Appl. Text*/
  sic_bran.uwm200.fptr03    = 0              /*First sic_bran.uwd202 RI Appl.Endt.Text*/
  sic_bran.uwm200.bptr03    = 0              /*Last sic_bran.uwd202 RI Appl.Endt.Text*/
  sic_bran.uwm200.dreg_p    = NO             /*Daily Prem.Reg.Printed*/
  sic_bran.uwm200.curbil    = "BHT"          /*Currency of Billing*/
  sic_bran.uwm200.reg_no    = 0              /*Daily Prem. Reg. No.*/
  sic_bran.uwm200.bordno    = 0              /*Bordereau No.*/
  sic_bran.uwm200.panel     = ""             /*Open Cover Fac Panel*/
  sic_bran.uwm200.riendt    = ?.             /*RI Cover Endorsement Date*/

/*----------Wantanee 29/09/2006 A49-0165----*/
ASSIGN
  sic_bran.uwm200.bchyr   = nv_Bchyr          /* batch Year */ 
  sic_bran.uwm200.bchno   = nv_Bchno          /* batchno    */ 
  sic_bran.uwm200.bchcnt  = nv_Bchcnt.        /* batcnt     */ 



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm301 C-Win 
PROCEDURE pd_uwm301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_vehreg AS CHAR FORMAT "x(12)" .
DEF VAR nv_model  AS CHAR FORMAT "x(120)".
DEF VAR nv_modcod AS CHAR .
DEF VAR nv_moddes AS CHAR FORMAT "x(50)".
DEF VAR nv_body   AS CHAR FORMAT "x(15)".
DEF VAR nv_vehgrp AS CHAR .
DEF VAR nv_tons   AS DECI FORMAT ">>>9.99" .

ASSIGN  nv_vehreg  = ""
        nv_model   = ""
        nv_modcod  = ""
        nv_moddes  = ""
        nv_body    = ""   
        nv_vehgrp  = ""   
        nv_tons    =  0
        s_riskgp   =  0                     
        s_riskno   =  1 
        s_itemno   =  1  .

/* Make/Model */
nv_model = SUBSTRING(TRIM(wdetail2.model),9,LENGTH(wdetail2.model)) .
nv_model = "NISSAN " + SUBSTRING(nv_model,1,INDEX(nv_model," ") - 1 ) .

FIND FIRST sicsyac.xmm102 USE-INDEX xmm10202 WHERE sicsyac.xmm102.moddes = nv_model
NO-LOCK NO-ERROR .
IF AVAIL sicsyac.xmm102 THEN DO:
    ASSIGN
        nv_modcod = sicsyac.xmm102.modcod
        nv_moddes = sicsyac.xmm102.moddes
        nv_body   = sicsyac.xmm102.body
        nv_vehgrp = sicsyac.xmm102.vehgrp 
        nv_tons   = sicsyac.xmm102.tons.
END.

/* ทะเบียน */
IF wdetail2.vehreg = "ป้ายแดง" THEN DO:
    nv_vehreg = "/" + SUBSTRING(trim(wdetail2.cha_no),LENGTH(trim(wdetail2.cha_no)) - 8 ,LENGTH(TRIM(wdetail2.cha_no))) .
END.
ELSE DO:
   nv_vehreg = TRIM(wdetail2.vehreg) .
END.


FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
     sic_bran.uwm301.policy = nv_policy      AND
     sic_bran.uwm301.rencnt = nv_rencnt      AND
     sic_bran.uwm301.endcnt = nv_endcnt      AND
     sic_bran.uwm301.riskgp = s_riskgp       AND
     sic_bran.uwm301.riskno = s_riskno       AND
     sic_bran.uwm301.itemno = s_itemno       AND
     sic_bran.uwm301.bchyr  = nv_Bchyr       AND 
     sic_bran.uwm301.bchno  = nv_Bchno       AND 
     sic_bran.uwm301.bchcnt = nv_Bchcnt      
NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
    END. /*transaction*/
END.          

ASSIGN
    sic_bran.uwm301.covcod      =  "0"                          /*  Cover Type Code            */
    sic_bran.uwm301.modcod      =  nv_modcod                    /*  Make/Model Code            */
    sic_bran.uwm301.vehreg      =  nv_vehreg                    /*  Vehicle Registration       */
    sic_bran.uwm301.eng_no      =  TRIM(wdetail2.eng_no)        /*  Engine No.                 */
    sic_bran.uwm301.cha_no      =  TRIM(wdetail2.cha_no)        /*  Chassis No.                */
    sic_bran.uwm301.yrmanu      =  INTEGER(TRIM(wdetail2.vehyear))    /*  Year of Manufacture        */
    sic_bran.uwm301.vehuse      =  "1"                          /*  Vehicle Usage Code         */
    sic_bran.uwm301.ncbyrs      =  0                            /*  NCB Years                  */
    sic_bran.uwm301.ncbper      =  0                            /*  NCB Percent                */
    sic_bran.uwm301.tariff      =  "0"                          /*  Tariff                     */
    sic_bran.uwm301.drinam      =  ""                           /*  Driver Name                */  
    sic_bran.uwm301.driage      =  0                            /*  Driver Year of Birth       */  
    sic_bran.uwm301.driexp      =  0                            /*  Driver Year Comm.Exper     */  
    sic_bran.uwm301.dridip      =  0                            /*  Driver DIP's               */  
    sic_bran.uwm301.act_ae      =  YES                          /*  Act Premium A/E            */  
    sic_bran.uwm301.actprm      =  0                            /*  Act Premium                */  
    sic_bran.uwm301.tp_ae       =  YES                          /*  TP Premium A/E             */  
    sic_bran.uwm301.tpprm       =  0                            /*  TP Premium                 */  
    sic_bran.uwm301.policy      =  nv_policy                    /*  Policy No.                 */  
    sic_bran.uwm301.rencnt      =  nv_rencnt                    /*  Renewal Count              */  
    sic_bran.uwm301.endcnt      =  nv_endcnt                    /*  Endorsement Count          */  
    sic_bran.uwm301.riskgp      =  s_riskgp                     /*  Risk Group                 */  
    sic_bran.uwm301.riskno      =  s_riskno                     /*  Risk No.                   */  
    sic_bran.uwm301.itemno      =  s_itemno                     /*  Item No.                   */  
    sic_bran.uwm301.cert        =  ""                           /*  Certificate Ref.           */  
    sic_bran.uwm301.moddes      =  nv_moddes                    /*  Vehicle Make/Model Des     */  
    sic_bran.uwm301.body        =  nv_body                      /*  Vehicle Body Type          */  
    sic_bran.uwm301.engine      =  INTEGER(TRIM(wdetail2.cc))   /*  Vehicle Engine CC's        */  
    sic_bran.uwm301.tons        =  nv_tons                      /*  Vehicle Tonage             */  
    sic_bran.uwm301.seats       =  INTEGER(TRIM(wdetail2.seat)) /*  No. of Seats               */  
    sic_bran.uwm301.vehgrp      =  nv_vehgrp                    /*  Vehicle Group              */  
    sic_bran.uwm301.trareg      =  TRIM(wdetail2.cha_no)       /*  Trailer Registration N     */  
    sic_bran.uwm301.logbok      =  ""                           /*  Vehicle Log Book No.       */  
    sic_bran.uwm301.garage      =  ""                           /*  GARAGE                     */  
    sic_bran.uwm301.marsts      =  ""                           /*  Marital Status             */  
    sic_bran.uwm301.mv41a       =  ""                           /*  MV.4.1A                    */  
    sic_bran.uwm301.sex         =  ""                           /*  Sex                        */  
    sic_bran.uwm301.mv41b       =  ""                           /*  MV.4.1B                    */  
    sic_bran.uwm301.mv41c       =  ""                           /*  MV.4.1C                    */  
    sic_bran.uwm301.mv42        =  ""                           /*  MV.4.2                     */  
    sic_bran.uwm301.atttxt      =  ""                           /*  Endorsement Attached       */  
    sic_bran.uwm301.mv41seat    =  0                            /*  Cover Seat (4.1)           */  
    sic_bran.uwm301.comp_cod    =  ""                           /*  Compulsory Code            */  
    sic_bran.uwm301.sckno       =  0                            /*  sticker no.                */  
    sic_bran.uwm301.mv_ben83    =  ""                           /*  Benefit Text For MV8.3     */  
    sic_bran.uwm301.prmtxt      =  ""                           /*  Premium text               */  
    sic_bran.uwm301.itmdel      =  NO                           /*  Item Deleted               */  
    sic_bran.uwm301.bchyr       =  nv_Bchyr                     /*  Batch Year                 */  
    sic_bran.uwm301.bchno       =  nv_Bchno                     /*  Batch No.                  */  
    sic_bran.uwm301.bchcnt      =  nv_Bchcnt                    /*  Batch Count                */
    sic_bran.uwm301.drinam[2]   =  "และ/หรือ " + TRIM(wdetail2.sign)  /*ชื่อผู้ขับขี่*/ .             
                                                                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_xmm600 C-Win 
PROCEDURE pd_xmm600 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* ---- Name & Address Master (XMM600) ---- */
/*
ASSIGN
 nv_check  = ""
 nv_insref = "".

RUN wtm/wtmge600 (INPUT-OUTPUT nv_insref,          /*nv_insref*/
                                "",                 /*nv_ntitle */
                                wdetail.name1,    /*nv_name1*/
                                "",                 /*nv_name1*/
                                "",                 /*nv_addr1  */
                                "",                 /*nv_addr2  */
                                "",                 /*nv_addr3  */
                                "",                 /*nv_addr4  */
                         SUBSTR(nv_policy,2,1),     /*nv_branch */
                                nv_trndat,          /*nv_trndat */
                                nv_enttim,          /*nv_enttim */
                                "",                 /*nv_vat_addr1*/
                                "",                 /*nv_vat_addr2*/
                                "",                 /*nv_vat_addr3*/
                                "",                 /*nv_vat_addr4*/
                                "",                 /*nv_vat_name */
                   INPUT-OUTPUT nv_check).          /*nv_check  */

IF nv_check = "ERROR1" THEN nv_xmm600 = "WARNING: พบข้อมูล Name (XMM600) ของ " + wdetail2.name1. 
IF nv_check = "ERROR2" THEN nv_xmm600 = "WARNING: พบข้อมูลและมีการใช้ที่ Name (XMM600) ของ " + wdetail2.name1.
IF nv_check = "ERROR3" THEN nv_xmm600 = "WARNING: CREATE NEW RECORD Name & Address Master (XMM600) ของ " + wdetail2.name1.
IF nv_check = "ERROR4" THEN nv_xmm600 = "WARNING: พบข้อมูล Name THAI (XTM600) " + nv_insref.
IF nv_check = "ERROR5" THEN nv_xmm600 = "WARNING: พบข้อมูลและมีการใช้ Name THAI (XTM600) " + nv_insref.
IF nv_check = "ERROR6" THEN nv_xmm600 = "WARNING: CREATE NEW RECORD Name THAI (XTM600) " + nv_insref.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

