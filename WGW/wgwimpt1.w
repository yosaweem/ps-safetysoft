&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/*Parameters Definitions ---                                            */
                                                                        
/*Local Variable Definitions ---                                        */

/*Modify By Chutikarn Date 15/11/2006 
  User Thitaporn Dankul M2 request (Date 15/11/2006)
  -> Check Cedpol. [Ex Data: 64002359 OR 06-64002359 (Year-Policy No Aon Enterprise)]
    - Find uwm100.cedpol = Policy No (Aon Enterprise) OR 
      Find substring(uwm100.cedpol,4,length(Policy No (Aon Enterprise)) = Policy No (Aon Enterprise)*/

/*Modify By Chutikarn A50-0072 Date 22/03/2007 : New Check Policy Class  */
/*Modify By Chutikarn A50-0248 Date 08/10/2007 : Change M61 ===> M68     */
/*Modify By Chutikarn A51-0056 Date 26/02/2008 : Modify Allocate         */
/*Modify BY  : Jiraphon P. A64-0380 06/06/2022                           
             : Change Table Allocate Treaty Code (xmm025 > run uwetr225) */                
/*Modefy BY  : Jiraphon P. A64-0380 01/01/2023
             : แก้ไข Comm. Allocate ให้เก็บทศนิยม 2 ตำแหน่ง  
               Truncate(com,0) >> Round(com,2)*/
/* Modify by : Jiraphon P. A64-0380 Date 06/07/2023
             : ปรับเงื่อนไขการดึงพารามิเตอร์  Treaty Code 
               โดยเช็คจากวัน Com.date ของกรมธรรม์ ให้อยู่ในช่วง
               ของ Com.date and Ter.date ใน Table xmm225 */

DEFINE NEW SHARED WORKFILE wgenerage NO-UNDO
   FIELD policycode AS CHAR FORMAT "X(3)"                INIT ""  /*Column : Policy Class*/
   FIELD account    AS CHAR FORMAT "X(8)"                INIT ""  /*Column : Account Code*/
   FIELD cedpol     AS CHAR FORMAT "X(16)"               INIT ""  /*Column : Policy No.*/
   FIELD risk       AS INTE FORMAT ">9"                  INIT 0   /*Column : Risk*/
   FIELD inscode    AS CHAR FORMAT "X(8)"                INIT ""  /*Column : Insured Code*/
   FIELD name1      AS CHAR FORMAT "X(60)"               INIT ""  /*Column : Insured Name*/
   FIELD transac    AS INTE FORMAT ">>9"                 INIT 0   /*Column : Transaction No.*/
   FIELD comdat     AS INTE FORMAT "99999999"            INIT 0   /*Column : Effective Date*/
   FIELD expdat     AS INTE FORMAT "99999999"            INIT 0   /*Column : Expiry Date*/
   FIELD premper    AS INTE FORMAT ">>9"                 INIT 0   /*Column : %Premium Ceded*/
   FIELD comper     AS INTE FORMAT ">>9"                 INIT 0   /*Column : % R/I Commistion*/
   FIELD prem       AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0   /*Column : Premium*/
   FIELD comm       AS DECI FORMAT ">>>,>>9.99-"         INIT 0   /*Column : Commistion*/
   FIELD netprem    AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0   /*Column : Net Premium (Premium)*/
   FIELD grosssi    AS DECI FORMAT ">>>,>>>,>>>,>>>,>>9" INIT 0   /*Column : Gross Sum Insured*/
   FIELD si         AS DECI FORMAT ">>>,>>>,>>>,>>>,>>9" INIT 0   /*Column : R/I Insured*/
   FIELD policy     AS CHAR FORMAT "X(16)"               INIT ""  /*Policy*/
   FIELD rencnt     AS INTE FORMAT ">9"                  INIT 0   /*Renew Count*/
   FIELD endcnt     AS INTE FORMAT "999"                 INIT 0   /*Endcnt Count*/
   FIELD dcomdat    AS DATE FORMAT "99/99/9999"          INIT ?   /*Column : Effective Date*/
   FIELD dexpdat    AS DATE FORMAT "99/99/9999"          INIT ?   /*Column : Expiry Date*/
   FIELD rec100     AS RECID                             INIT 0   
   FIELD rec120     AS RECID                             INIT 0
   FIELD rec130     AS RECID                             INIT 0
   FIELD rec132     AS RECID                             INIT 0
   FIELD rec304     AS RECID                             INIT 0
   FIELD rec307     AS RECID                             INIT 0   
   FIELD poltyp     AS CHAR FORMAT "X(3)"                INIT "".  /*Policy Type*/

DEFINE WORKFILE wdelimi NO-UNDO
   FIELD txt AS CHARACTER FORMAT "X(1000)" INITIAL "".

DEFINE VAR n_hptyp1    AS CHAR.
DEFINE VAR n_hpDestyp1 AS CHAR.

DEFINE STREAM nfile.
DEFINE STREAM nerror.   
DEFINE STREAM nnoterror. /*--Wantanee A49-0165 --*/
DEFINE STREAM nbatch.    /*--Wantanee A49-0165 --*/

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

/*---13/10/05--------------*/
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
/*--------------13/10/05-----*/

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
/*-- Add chutikarn A50-0072 --*/
/*DEF VAR nv_typpol AS INTEGER FORMAT ">9".    /*Poltyp Aon*/*/
DEF VAR nv_typpol AS INTEGER FORMAT ">>9".    /*Poltyp Aon*/
/*-- End chutikarn A50-0072 --*/

DEFINE WORKFILE wallocate NO-UNDO
   FIELD csftq  AS CHAR    FORMAT "X(1)"             INIT ""  /*csftq*/
   FIELD rico   AS CHAR    FORMAT "X(20)"            INIT ""  /*rico*/
   FIELD rip1   AS DECIMAL FORMAT ">>9.99"           INIT ""  /*%com1*/
   FIELD si     AS DECIMAL FORMAT ">,>>>,>>>,>>9.99" INIT 0   /*si*/
   FIELD per    AS DECIMAL FORMAT ">>9.99"           INIT 0   /*percent*/
   FIELD pd     AS DECIMAL FORMAT ">,>>>,>>9.99-"    INIT 0   /*prem*/
   FIELD com    AS DECIMAL FORMAT ">,>>>,>>9.99-"    INIT 0   /*comm*/
   /*Add A64-0380*/
   FIELD rip2   AS DECIMAL FORMAT ">>9.99"           INIT ""  /*%com2*/
   FIELD com2   AS DECIMAL FORMAT ">,>>>,>>9.99-"    INIT 0   /*comm*/
   FIELD rip1ae AS LOGICAL INIT NO
   FIELD rip2ae AS LOGICAL INIT NO
   FIELD treaty_yr AS CHAR INIT "".
   /*End Add A64-0380*/
DEFINE VAR nv_file AS CHAR    INIT "".
DEFINE VAR nv_row  AS INTEGER INIT 0.
DEF STREAM ns1.

/*---- Wantanee A49-0165 2/10/2006 ----*/
DEFINE VAR nv_texterror   AS CHAR FORMAT "X(200)" INIT "". 
DEFINE VAR nv_Bchyr     AS INT  FORMAT "9999"                  INITIAL 0.
DEFINE VAR nv_Bchno     AS CHARACTER FORMAT "X(12)"           INITIAL ""  NO-UNDO.
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

DEFINE VAR  nv_dattime    AS CHAR INIT "". /*8/11/2006*/

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
&Scoped-define INTERNAL-TABLES wgenerage

/* Definitions for BROWSE br_main                                       */
&Scoped-define FIELDS-IN-QUERY-br_main poltyp policy rencnt endcnt name1 dcomdat dexpdat premper comper prem comm netprem grosssi si   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_main   
&Scoped-define SELF-NAME br_main
&Scoped-define QUERY-STRING-br_main FOR EACH wgenerage NO-LOCK
&Scoped-define OPEN-QUERY-br_main OPEN QUERY br_main FOR EACH wgenerage NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_main wgenerage
&Scoped-define FIRST-TABLE-IN-QUERY-br_main wgenerage


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_trndat fi_bran fi_acno1 bu_acno1 fi_agent ~
bu_agent fi_prvbatch fi_Bchyr fi_input bu_open fi_output1 fi_output2 ~
fi_output3 fi_policyinput fi_preminput bu_ok bu_exit br_main RECT-1 RECT-2 ~
RECT-262 RECT-263 RECT-264 RECT-266 RECT-267 
&Scoped-Define DISPLAYED-OBJECTS fi_trndat fi_bran fi_brandesc fi_acno1 ~
fi_acdesc fi_agent fi_agdesc fi_prvbatch fi_Bchyr fi_input fi_output1 ~
fi_output2 fi_output3 fi_policyinput fi_preminput fi_policytotal ~
fi_premtotal fi_policysuccess fi_premsuccess fi_batch 

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

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131 BY 10.33
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
     SIZE 131 BY 7.43
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-267
     EDGE-PIXELS 8    
     SIZE 131 BY 3.86
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_main FOR 
      wgenerage SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_main
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_main C-Win _FREEFORM
  QUERY br_main DISPLAY
      poltyp      COLUMN-LABEL "Policy Type"  FORMAT "X(3)"
    policy      COLUMN-LABEL "Policy"       FORMAT "X(17)"
    rencnt      COLUMN-LABEL "Rencnt"
    endcnt      COLUMN-LABEL "Endcnt"
    name1       COLUMN-LABEL "Insured Name"
    dcomdat     COLUMN-LABEL "Comdate"
    dexpdat     COLUMN-LABEL "Expdate"
    premper     COLUMN-LABEL "% Premium"
    comper      COLUMN-LABEL "% Commission"
    prem        COLUMN-LABEL "Premium"
    comm        COLUMN-LABEL "Commission"
    netprem     COLUMN-LABEL "Net Premium"
    grosssi     COLUMN-LABEL "Sum insured 100%"
    si          COLUMN-LABEL "Sum insured Safety"
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
     fi_policyinput AT ROW 11.76 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_preminput AT ROW 11.76 COL 69.33 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 4.38 COL 114.33
     bu_exit AT ROW 6.43 COL 114.33
     br_main AT ROW 13.57 COL 4
     fi_policytotal AT ROW 21.48 COL 60.5 COLON-ALIGNED NO-LABEL
     fi_premtotal AT ROW 21.48 COL 95.17 COLON-ALIGNED NO-LABEL
     fi_policysuccess AT ROW 22.43 COL 60.5 COLON-ALIGNED NO-LABEL
     fi_premsuccess AT ROW 22.43 COL 95.17 COLON-ALIGNED NO-LABEL
     fi_batch AT ROW 21.86 COL 16.5 COLON-ALIGNED NO-LABEL
     "LOAD POLICY INWARD NON-MOTOR (Aon Enterprise)" VIEW-AS TEXT
          SIZE 56.5 BY .57 AT ROW 1.76 COL 5.5
          BGCOLOR 1 FGCOLOR 15 
     "Premium Total :" VIEW-AS TEXT
          SIZE 15.17 BY .57 AT ROW 21.71 COL 81.33
          BGCOLOR 8 FGCOLOR 1 
     "BHT." VIEW-AS TEXT
          SIZE 5.33 BY .57 AT ROW 21.62 COL 125
          BGCOLOR 8 FGCOLOR 1 
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .57 AT ROW 8.14 COL 6.67
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No :" VIEW-AS TEXT
          SIZE 19.5 BY .57 AT ROW 7.14 COL 9.67
          BGCOLOR 8 FGCOLOR 1 
     "Premium Import Total :" VIEW-AS TEXT
          SIZE 22.5 BY .57 AT ROW 11.95 COL 47.83
          BGCOLOR 8 FGCOLOR 1 
     "File Not Completed :" VIEW-AS TEXT
          SIZE 20.17 BY .57 AT ROW 10 COL 9.17
          BGCOLOR 8 FGCOLOR 1 
     "BHT." VIEW-AS TEXT
          SIZE 6.5 BY .57 AT ROW 11.91 COL 100.33
          BGCOLOR 8 FGCOLOR 1 
     "(Note : Premium Safety)" VIEW-AS TEXT
          SIZE 22.5 BY .86 AT ROW 11.81 COL 106.33
          BGCOLOR 8 FGCOLOR 1 
     "Trandate :" VIEW-AS TEXT
          SIZE 10.5 BY .57 AT ROW 3.38 COL 18.67
          BGCOLOR 8 FGCOLOR 1 
     "File Completed :" VIEW-AS TEXT
          SIZE 16.33 BY .57 AT ROW 9.05 COL 13
          BGCOLOR 8 FGCOLOR 1 
     "Premium Success :" VIEW-AS TEXT
          SIZE 17.83 BY .57 AT ROW 22.67 COL 78.17
          BGCOLOR 8 FGCOLOR 1 
     "Agent Code :" VIEW-AS TEXT
          SIZE 14 BY .57 AT ROW 6.24 COL 16.17
          BGCOLOR 8 FGCOLOR 1 
     "Screen Output To File :" VIEW-AS TEXT
          SIZE 23.5 BY .57 AT ROW 10.95 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Record Success :" VIEW-AS TEXT
          SIZE 16.67 BY .57 AT ROW 22.62 COL 44.83
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
     "Record Total :" VIEW-AS TEXT
          SIZE 13.5 BY .57 AT ROW 21.67 COL 48
          BGCOLOR 8 FGCOLOR 1 
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .57 AT ROW 5.29 COL 13.17
          BGCOLOR 8 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 12.83 BY 1.19 AT ROW 21.86 COL 5.17
          BGCOLOR 8 FGCOLOR 1 FONT 36
     "Policy Import Total :" VIEW-AS TEXT
          SIZE 19 BY .57 AT ROW 11.91 COL 9.5
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 13 BY .57 AT ROW 7.19 COL 56.5
          BGCOLOR 8 FGCOLOR 1 
     RECT-1 AT ROW 1.24 COL 2
     RECT-2 AT ROW 2.81 COL 2
     RECT-262 AT ROW 1.48 COL 3
     RECT-263 AT ROW 4.1 COL 113.33
     RECT-264 AT ROW 6.14 COL 113.33
     RECT-266 AT ROW 13.05 COL 2
     RECT-267 AT ROW 20.48 COL 2
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
         TITLE              = "Wgwimpt1 : Load Policy Inward Non-Motor (Aon Enterprise)"
         HEIGHT             = 23.57
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_main
/* Query rebuild information for BROWSE br_main
     _START_FREEFORM
OPEN QUERY br_main FOR EACH wgenerage NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Wgwimpt1 : Load Policy Inward Non-Motor (Aon Enterprise) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Wgwimpt1 : Load Policy Inward Non-Motor (Aon Enterprise) */
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
       MESSAGE "Not found Batch File Master on file uzm701...!!!" VIEW-AS ALERT-BOX ERROR.
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

  /*----Wantanee A49-0165 02/10/2006----*/
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

  IF INPUT fi_policyinput = 0 THEN DO:
      MESSAGE "Plese Input Policy Import Total...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_policyinput.
      RETURN NO-APPLY.
  END.
  /*------------------*/

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
    ASSIGN fi_acno1.

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
    ASSIGN fi_agent.

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
  ASSIGN fi_bran.

  fi_bran = CAPS(INPUT fi_bran).
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
    ASSIGN fi_input.

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


&Scoped-define SELF-NAME fi_prvbatch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prvbatch C-Win
ON LEAVE OF fi_prvbatch IN FRAME fr_main
DO:
  ASSIGN fi_prvbatch = CAPS(INPUT fi_prvbatch).
  DISP fi_prvbatch WITH FRAME fr_main.
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
  
  gv_prgid = "wgwimpt1".
  gv_prog  = "Load Policy Inward Non-Motor (Aon Enterprise) ".
  RUN  WUT\WUTHEAD (C-Win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (C-Win:handle). 
/********************************************************************/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN
    fi_trndat  = TODAY
    fi_bran    = "W"
    fi_Bchyr = YEAR(TODAY)
    fi_batch   = "".

  DISP fi_trndat fi_bran fi_Bchyr fi_batch WITH FRAME fr_main.

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
          fi_policysuccess fi_premsuccess fi_batch 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_trndat fi_bran fi_acno1 bu_acno1 fi_agent bu_agent fi_prvbatch 
         fi_Bchyr fi_input bu_open fi_output1 fi_output2 fi_output3 
         fi_policyinput fi_preminput bu_ok bu_exit br_main RECT-1 RECT-2 
         RECT-262 RECT-263 RECT-264 RECT-266 RECT-267 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_allocate C-Win 
PROCEDURE pd_allocate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   A64-0380 06/07/2023
           Duplicate มากจาก pd_allocate-CommentA640380 แล้วมาลบ comment ออก
           เนื่องจาก Procedure เต็ม 
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_type AS CHAR FORMAT "X(3)".
DEFINE VAR n_per            AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_per2           AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_comper         AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_limitsi        AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99" INITIAL 0.
DEFINE VAR n_check0ret      AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_0ret           AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_case           AS INTEGER INITIAL 1.
DEFINE VAR n_allo1          AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_allo2          AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_per3           AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_per4           AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_sicheck0ret    AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_si0ret         AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_siall          AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_all            AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_si0rq          AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_0rq            AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_comper2        AS DECIMAL FORMAT ">>9.99" INITIAL 0.  
DEFINE VAR n_rip1ae         AS LOGICAL.                            
DEFINE VAR n_rip2ae         AS LOGICAL.                            
DEFINE VAR n_err            AS CHAR INIT "".  
DEFINE VAR n_treaty_yr      AS CHAR INIT "".

FOR EACH wallocate.
    DELETE wallocate.
END.

ASSIGN
  n_limitsi   = 0 n_si0ret      = 0     
  n_per       = 0 n_sicheck0ret = 0     
  n_per2      = 0 n_siall       = 0     
  n_0ret      = 0 n_all         = 0     
  n_check0ret = 0 n_si0rq       = 0     
  n_allo1     = 0 n_0rq         = 0    
  n_allo2     = 0
  n_per3      = 0
  n_per4      = 0.
  
IF      nv_type = "F10" THEN ASSIGN n_limitsi = 7500000   n_case = 1.
ELSE IF nv_type = "M12" THEN ASSIGN n_limitsi = 7500000   n_case = 1.       
ELSE IF nv_type = "M20" THEN ASSIGN n_limitsi = 7500000   n_case = 1. 
ELSE IF nv_type = "M21" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
ELSE IF nv_type = "M22" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
ELSE IF nv_type = "M23" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
ELSE IF nv_type = "M24" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
ELSE IF nv_type = "M37" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
ELSE IF nv_type = "M40" THEN ASSIGN n_limitsi = 5000000   n_case = 2. 
ELSE IF nv_type = "M41" THEN ASSIGN n_limitsi = 5000000   n_case = 2. 
ELSE IF nv_type = "M43" THEN ASSIGN n_limitsi = 5000000   n_case = 2. 
ELSE IF nv_type = "M60" THEN ASSIGN n_limitsi = 1000000   n_case = 1. 
ELSE IF nv_type = "M61" THEN ASSIGN n_limitsi = 1000000   n_case = 1. 
ELSE IF nv_type = "M68" THEN ASSIGN n_limitsi = 1000000   n_case = 1.  
ELSE IF nv_type = "M64" THEN ASSIGN n_limitsi = 5000000   n_case = 1. 
ELSE IF nv_type = "M80" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
ELSE IF nv_type = "M82" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
ELSE IF nv_type = "M83" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
ELSE IF nv_type = "M84" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
ELSE IF nv_type = "M85" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
ELSE NEXT.

IF wgenerage.si <> 0 THEN DO:
   ASSIGN
     n_per  = TRUNCATE((n_limitsi * 100) / wgenerage.si , 0)
     n_per2 = TRUNCATE(n_per / 2 , 1)
     n_per3 = (n_per * 30) / 100
     n_per4 = (n_per * 70) / 100.
END.

IF n_case = 1 THEN DO:
    IF n_per >= 100 THEN DO:
        RUN pd_xmm225(INPUT "0RET", INPUT wgenerage.dcomdat,
                      OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                      OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
        
        CREATE wallocate.
        ASSIGN
          wallocate.csftq = "T" 
          wallocate.rico  = "0RET"
          wallocate.rip1  = 0
          wallocate.per   = 100
          wallocate.si    = wgenerage.si        
          wallocate.pd    = wgenerage.prem
          wallocate.com   = 0
          wallocate.rip2   = 0
          wallocate.rip1ae = n_rip1ae
          wallocate.rip2ae = n_rip2ae
          wallocate.com2   = n_comper2
          wallocate.treaty_yr = n_treaty_yr.
    END.
    ELSE DO:
        IF n_per <> 0  THEN DO:
            ASSIGN
              n_0ret      = (wgenerage.prem * n_per) / 100
              n_check0ret = n_0ret - ROUND(n_0ret,0).
            IF n_check0ret > 0 THEN n_0ret = ROUND(n_0ret,0) + 1.
            ELSE n_0ret = ROUND(n_0ret,0).
            RUN pd_xmm225(INPUT "0RET", INPUT wgenerage.dcomdat,
                          OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                          OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
            CREATE wallocate.
            ASSIGN
              wallocate.csftq = "T" 
              wallocate.rico  = "0RET"
              wallocate.rip1  = 0
              wallocate.per   = n_per
              wallocate.si    = (wgenerage.si * n_per) / 100             
              wallocate.pd    = n_0ret 
              wallocate.com   = 0
              wallocate.rip2   = 0
              wallocate.rip1ae = n_rip1ae 
              wallocate.rip2ae = n_rip2ae 
              wallocate.com2   = n_comper2
              wallocate.treaty_yr = n_treaty_yr.

            n_comper = 0. n_comper2 = 0.
            /*Add A64-0380 06/07/2023*/
            RUN pd_xmm225(INPUT "0TA" + SUBSTRING(nv_type,2,2) + "01", INPUT wgenerage.dcomdat,
                          OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                          OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
            /*End A64-0380 06/07/2023*/
            CREATE wallocate.
            ASSIGN
              wallocate.csftq = "T" 
              wallocate.rico  = "0TA" + SUBSTRING(nv_type,2,2) + "01"
              wallocate.rip1  = n_comper
              wallocate.per   = 100 - n_per
              wallocate.si    = (wgenerage.si * wallocate.per) / 100             
              wallocate.pd    = (wgenerage.prem - n_0ret) * (-1)   /*((wgenerage.prem * wallocate.per) / 100) * (-1) */
              wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * -1), 2) /*ปัดทศนิยม 2 ตำแหน่ง*/
              wallocate.rip2  = n_comper2 
              wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2) /*ปัดทศนิยม 2 ตำแหน่ง*/
              wallocate.treaty_yr = n_treaty_yr
              wallocate.rip1ae = n_rip1ae
              wallocate.rip2ae = n_rip2ae.
        END.
    END.
END.
ELSE DO: /*CASE <> 1*/
    IF n_per >= 100 THEN DO:
        IF n_case = 2 THEN DO: 
            ASSIGN
              n_0ret        = wgenerage.prem / 2
              n_si0ret      = wgenerage.si   / 2
              n_check0ret   = n_0ret   - ROUND(n_0ret,0)
              n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
            IF n_check0ret > 0   THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
            IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

            ASSIGN n_allo1 = 50
                   n_allo2 = 50.
        END.
        ELSE IF n_case = 3 THEN DO:
            ASSIGN
              n_0ret        = (wgenerage.prem * 30) / 100
              n_si0ret      = (wgenerage.si * 30) / 100
              n_check0ret   = n_0ret   - ROUND(n_0ret,0)
              n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
            IF n_check0ret   > 0 THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
            IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

            ASSIGN n_allo1 = 30
                   n_allo2 = 70.
        END.
        /*Add A64-0380 06/07/2023*/
        RUN pd_xmm225(INPUT "0RET", INPUT wgenerage.dcomdat,
                      OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                      OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
        /*End A64-0380 06/07/2023*/
        CREATE wallocate.
        ASSIGN
          wallocate.csftq = "T" 
          wallocate.rico  = "0RET"
          wallocate.rip1  = 0
          wallocate.per   = n_allo1
          wallocate.si    = n_si0ret
          wallocate.pd    = n_0ret 
          wallocate.com   = 0
          wallocate.rip2   = 0
          wallocate.rip1ae = n_rip1ae 
          wallocate.rip2ae = n_rip2ae 
          wallocate.com2   = n_comper2
          wallocate.treaty_yr = n_treaty_yr.

        n_comper = 0. n_comper2 = 0.

        /*Add A64-0380 06/07/2023*/
        RUN pd_xmm225(INPUT "0RQ" + SUBSTRING(nv_type,2,2), INPUT wgenerage.dcomdat,
                      OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                      OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
        /*End A64-0380 06/07/2023*/
        CREATE wallocate.
        ASSIGN
          wallocate.csftq = "T" 
          wallocate.rico  = "0RQ" + SUBSTRING(nv_type,2,2)
          wallocate.rip1  = n_comper
          wallocate.per   = n_allo2
          wallocate.si    = (wgenerage.si - n_si0ret) 
          wallocate.pd    = (wgenerage.prem - n_0ret) * (-1) 
          wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * (-1)), 2) /*ทศนิยม 2 ตำแหน่ง*/
          wallocate.rip2  = n_comper2 
          wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2) /*ทศนิยม 2 ตำแหน่ง*/
          wallocate.treaty_yr = n_treaty_yr
          wallocate.rip1ae = n_rip1ae
          wallocate.rip2ae = n_rip2ae.
    END.
    ELSE DO:
        IF n_per <> 0  THEN DO:
            IF n_case = 2 THEN DO: 
               ASSIGN
                  n_all         = TRUNCATE((wgenerage.prem * n_per) / 100,0)
                  n_siall       = TRUNCATE((wgenerage.si * n_per) / 100,0)                    
                  n_0ret        = (wgenerage.prem * n_per2) / 100
                  n_si0ret      = (wgenerage.si   * n_per2) / 100
                  n_check0ret   = n_0ret   - ROUND(n_0ret,0)
                  n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
               IF n_check0ret   > 0 THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
               IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

               ASSIGN n_allo1   = n_per2
                      n_allo2   = n_per2
                      n_si0rq   = n_siall - n_si0ret
                      n_0rq     = n_all - n_0ret.
            END.
            ELSE IF n_case = 3 THEN DO:
               ASSIGN
                  n_all         = TRUNCATE((wgenerage.prem * n_per) / 100,0)
                  n_siall       = TRUNCATE((wgenerage.si * n_per) / 100,0)
                  n_0ret        = (wgenerage.prem * n_per3) / 100
                  n_si0ret      = (wgenerage.si   * n_per3) / 100
                  n_check0ret   = n_0ret   - ROUND(n_0ret,0).
                  n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
               IF n_check0ret   > 0 THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
               IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

               ASSIGN n_allo1 = n_per3
                      n_allo2 = n_per4
                      n_si0rq = n_siall - n_si0ret
                      n_0rq     = n_all - n_0ret.
            END.

            /*Add A64-0380 06/07/2023*/
            RUN pd_xmm225(INPUT "0RET", INPUT wgenerage.dcomdat,
                          OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                          OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
            /*End A64-0380 06/07/2023*/
            CREATE wallocate.
            ASSIGN
              wallocate.csftq = "T" 
              wallocate.rico  = "0RET"
              wallocate.rip1  = 0
              wallocate.per   = n_allo1
              wallocate.si    = n_si0ret
              wallocate.pd    = n_0ret 
              wallocate.com   = 0
              wallocate.rip2  = 0
              wallocate.rip1ae = n_rip1ae 
              wallocate.rip2ae = n_rip2ae 
              wallocate.com2   = n_comper2
              wallocate.treaty_yr = n_treaty_yr.

            n_comper = 0. n_comper2 = 0.
            /*Add A64-0380 06/07/2023*/
            RUN pd_xmm225(INPUT "0RQ" + SUBSTRING(nv_type,2,2), INPUT wgenerage.dcomdat,
                          OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                          OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
            /*End A64-0380 06/07/2023*/
            CREATE wallocate.
            ASSIGN
              wallocate.csftq = "T" 
              wallocate.rico  = "0RQ" + SUBSTRING(nv_type,2,2)
              wallocate.rip1  = n_comper
              wallocate.per   = n_allo2
              wallocate.si    = n_si0rq  
              wallocate.pd    = n_0rq    
              wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * (-1)), 2)
              wallocate.rip2  = n_comper2 
              wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2)
              wallocate.treaty_yr = n_treaty_yr
              wallocate.rip1ae = n_rip1ae
              wallocate.rip2ae = n_rip2ae.

            n_comper = 0. n_comper2 = 0.
            /*Add A64-0380 06/07/2023*/
            RUN pd_xmm225(INPUT "0TA" + SUBSTRING(nv_type,2,2) + "01", INPUT wgenerage.dcomdat,
                          OUTPUT n_comper, OUTPUT n_comper2, OUTPUT n_rip1ae,   
                          OUTPUT n_rip2ae, OUTPUT n_err, OUTPUT n_treaty_yr).
            /*End A64-0380 06/07/2023*/
            CREATE wallocate.
            ASSIGN
              wallocate.csftq = "T" 
              wallocate.rico  = "0TA" + SUBSTRING(nv_type,2,2) + "01"
              wallocate.rip1  = n_comper
              wallocate.per   = 100 - n_per
              wallocate.si    = wgenerage.si - (n_si0ret + n_si0rq)    
              wallocate.pd    = wgenerage.prem - (n_0ret + n_0rq)                            
              wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * (-1)) , 2)
              wallocate.rip2  = n_comper2 
              wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2)
              wallocate.treaty_yr = n_treaty_yr
              wallocate.rip1ae = n_rip1ae
              wallocate.rip2ae = n_rip2ae.
        END.
    END.
END.

ASSIGN
    /*-- STAT --*/
    nv_stper  = 0
    nv_sistp  = 0  
    nv_pdstp  = 0
    nv_ratest = 0
    nv_comst  = 0
    /*-- TREATY --*/                  
    nv_typer  = 100            /* % */
    nv_sityp  = wgenerage.si   /* SI */
    nv_pdtyp  = wgenerage.prem /* prem */
    nv_ratety = 0              /* % Com*/
    nv_comty  = 0              /* com */
    /*--Coinsurance--*/
    nv_coper  = 0
    nv_sicop  = 0
    nv_pdcop  = 0
    nv_rateco = 0
    nv_comco  = 0
    /*--Facultative--*/ 
    nv_faper  = 0
    nv_sifap  = 0
    nv_pdfap  = 0
    nv_ratefa = 0 
    nv_comfa  = 0
    /*--Quota Share--*/ 
    nv_qsper  = 0
    nv_siqsp  = 0
    nv_pdqsp  = 0
    nv_rateqs = 0 
    nv_comqs  = 0.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_allocate-commentA640380 C-Win 
PROCEDURE pd_allocate-commentA640380 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_type AS CHAR FORMAT "X(3)".
DEFINE VAR n_per            AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_per2           AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_comper         AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_limitsi        AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99" INITIAL 0.
DEFINE VAR n_check0ret      AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_0ret           AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
/*------ Add Chutikarn A51-0056 -----------*/
/*DEFINE VAR n_case           AS LOGICAL INITIAL NO.-- A50-0178 --*/
DEFINE VAR n_case           AS INTEGER INITIAL 1.
DEFINE VAR n_allo1          AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_allo2          AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_per3           AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_per4           AS DECIMAL FORMAT ">>9.99"             INITIAL 0.
DEFINE VAR n_sicheck0ret    AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_si0ret         AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_siall          AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_all            AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_si0rq          AS DECIMAL FORMAT ">>>,>>>,>>>,>>>,>>9.99"       INITIAL 0.
DEFINE VAR n_0rq            AS DECIMAL FORMAT ">,>>>,>>9.99"       INITIAL 0.
/*------ End Chutikarn A51-0056 -----------*/
/*Add A64-0380*/
DEF VAR n_comper2 AS DECIMAL FORMAT ">>9.99" INITIAL 0.  
DEF VAR n_rip1ae  AS LOGICAL.                            
DEF VAR n_rip2ae  AS LOGICAL.                            
DEF VAR n_err     AS CHAR INIT "".  
DEF VAR n_treaty_yr AS CHAR INIT "".
/*End Add A64-0380*/

  FOR EACH wallocate.
      DELETE wallocate.
  END.

  ASSIGN
    n_limitsi   = 0
    n_per       = 0
    n_per2      = 0
    n_0ret      = 0
    n_check0ret = 0
    /*-- Add A51-0056 --*/
    n_allo1     = 0
    n_allo2     = 0
    n_per3      = 0
    n_per4      = 0
    n_si0ret      = 0
    n_sicheck0ret = 0
    n_siall       = 0
    n_all         = 0    
    n_si0rq       = 0  
    n_0rq         = 0   .
    /*-- End A51-0056 --*/
  /*---------------- Add chutikarn A51-0056 -----------------*/
  /*-----
  IF      nv_type = "F10" THEN ASSIGN n_limitsi = 5000000   n_case = NO.
  ELSE IF nv_type = "M12" THEN ASSIGN n_limitsi = 5000000   n_case = NO.       
  ELSE IF nv_type = "M20" THEN ASSIGN n_limitsi = 5000000   n_case = NO. 
  ELSE IF nv_type = "M21" THEN ASSIGN n_limitsi = 3000000   n_case = NO. 
  ELSE IF nv_type = "M22" THEN ASSIGN n_limitsi = 3000000   n_case = NO. 
  ELSE IF nv_type = "M23" THEN ASSIGN n_limitsi = 3000000   n_case = NO. 
  ELSE IF nv_type = "M24" THEN ASSIGN n_limitsi = 3000000   n_case = NO. 
  ELSE IF nv_type = "M37" THEN ASSIGN n_limitsi = 3000000   n_case = NO. 
  ELSE IF nv_type = "M40" THEN ASSIGN n_limitsi = 5000000   n_case = YES. 
  ELSE IF nv_type = "M41" THEN ASSIGN n_limitsi = 5000000   n_case = YES. 
  ELSE IF nv_type = "M43" THEN ASSIGN n_limitsi = 5000000   n_case = YES. 
  ELSE IF nv_type = "M60" THEN ASSIGN n_limitsi = 1000000   n_case = NO. 
  ELSE IF nv_type = "M61" THEN ASSIGN n_limitsi = 1000000   n_case = NO. 
  ELSE IF nv_type = "M68" THEN ASSIGN n_limitsi = 1000000   n_case = NO.  /*-- A50-0248 --*/
  ELSE IF nv_type = "M64" THEN ASSIGN n_limitsi = 5000000   n_case = NO. 
  ELSE IF nv_type = "M80" THEN ASSIGN n_limitsi = 10000000  n_case = NO. 
  ELSE IF nv_type = "M82" THEN ASSIGN n_limitsi = 10000000  n_case = NO. 
  ELSE IF nv_type = "M83" THEN ASSIGN n_limitsi = 10000000  n_case = NO. 
  ELSE IF nv_type = "M84" THEN ASSIGN n_limitsi = 10000000  n_case = NO. 
  ELSE IF nv_type = "M85" THEN ASSIGN n_limitsi = 10000000  n_case = YES. 
  ELSE NEXT.
  -----*/

  IF      nv_type = "F10" THEN ASSIGN n_limitsi = 7500000   n_case = 1.
  ELSE IF nv_type = "M12" THEN ASSIGN n_limitsi = 7500000   n_case = 1.       
  ELSE IF nv_type = "M20" THEN ASSIGN n_limitsi = 7500000   n_case = 1. 
  ELSE IF nv_type = "M21" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
  ELSE IF nv_type = "M22" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
  ELSE IF nv_type = "M23" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
  ELSE IF nv_type = "M24" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
  ELSE IF nv_type = "M37" THEN ASSIGN n_limitsi = 3000000   n_case = 1. 
  ELSE IF nv_type = "M40" THEN ASSIGN n_limitsi = 5000000   n_case = 2. 
  ELSE IF nv_type = "M41" THEN ASSIGN n_limitsi = 5000000   n_case = 2. 
  ELSE IF nv_type = "M43" THEN ASSIGN n_limitsi = 5000000   n_case = 2. 
  ELSE IF nv_type = "M60" THEN ASSIGN n_limitsi = 1000000   n_case = 1. 
  ELSE IF nv_type = "M61" THEN ASSIGN n_limitsi = 1000000   n_case = 1. 
  ELSE IF nv_type = "M68" THEN ASSIGN n_limitsi = 1000000   n_case = 1.  /*-- A50-0248 --*/
  ELSE IF nv_type = "M64" THEN ASSIGN n_limitsi = 5000000   n_case = 1. 
  ELSE IF nv_type = "M80" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
  ELSE IF nv_type = "M82" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
  ELSE IF nv_type = "M83" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
  ELSE IF nv_type = "M84" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
  ELSE IF nv_type = "M85" THEN ASSIGN n_limitsi = 10000000  n_case = 3. 
  ELSE NEXT.
  /*---------------- End chutikarn A51-0056 -----------------*/

  IF wgenerage.si <> 0 THEN DO:
     ASSIGN
       n_per  = TRUNCATE((n_limitsi * 100) / wgenerage.si , 0)
       n_per2 = TRUNCATE(n_per / 2 , 1)
       /*-- Add A51-0056 --*/
       n_per3 = (n_per * 30) / 100
       n_per4 = (n_per * 70) / 100.
       /*-- End A51-0056 --*/
  END.

  /*IF n_case = NO THEN DO: /*CASE = NO*/   --- A51-0056 --*/
  IF n_case = 1 THEN DO: /*CASE = 1*/    /*-- A51-0056 --*/
      IF n_per >= 100 THEN DO:
          /*Add A64-0380*/
          FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
               sicsyac.xmm225.treaty = "0RET"    AND 
               sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
          NO-LOCK NO-ERROR.
          IF AVAILABLE sicsyac.xmm225 THEN DO:
            ASSIGN
            n_err    = ""   n_treaty_yr = ""
            n_comper = 0    n_comper2   = 0
            n_rip1ae = NO   n_rip2ae    = NO.
            RUN wuw\wuwetr225
              (INPUT  wgenerage.policy , 
                      wgenerage.rencnt , 
                      wgenerage.endcnt ,
                      YEAR(wgenerage.dcomdat) ,
                      wgenerage.dcomdat ,
                      sicsyac.xmm225.treaty ,
               OUTPUT n_comper   ,
               OUTPUT n_comper2  ,
               OUTPUT n_rip1ae   ,
               OUTPUT n_rip2ae   ,
               OUTPUT n_err,
               OUTPUT n_treaty_yr).
            IF n_err <> "" THEN DO:
                HIDE MESSAGE NO-PAUSE.
                MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                NEXT.
            END.
          END.
          /*End A64-0380*/

          CREATE wallocate.
          ASSIGN
            wallocate.csftq = "T" 
            wallocate.rico  = "0RET"
            wallocate.rip1  = 0
            wallocate.per   = 100
            wallocate.si    = wgenerage.si        
            wallocate.pd    = wgenerage.prem
            wallocate.com   = 0
            /*Add A64-0380*/
            wallocate.rip1ae = n_rip1ae
            wallocate.rip2ae = n_rip2ae
            wallocate.com2   = n_comper2
            wallocate.treaty_yr = n_treaty_yr.
            /*End A64-0380*/
      END.
      ELSE DO:
          IF n_per <> 0  THEN DO:
              ASSIGN
                n_0ret      = (wgenerage.prem * n_per) / 100
                n_check0ret = n_0ret - ROUND(n_0ret,0).
              IF n_check0ret > 0 THEN n_0ret = ROUND(n_0ret,0) + 1.
              ELSE n_0ret = ROUND(n_0ret,0).

              /*Add A64-0380*/
              FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
                   sicsyac.xmm225.treaty = "0RET"    AND 
                   sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
              NO-LOCK NO-ERROR.
              IF AVAILABLE sicsyac.xmm225 THEN DO:
                ASSIGN
                n_err    = ""  n_treaty_yr = ""
                n_comper = 0   n_rip1ae = NO
                n_comper2 = 0  n_rip2ae = NO.

                RUN wuw\wuwetr225
                  (INPUT  wgenerage.policy , 
                          wgenerage.rencnt , 
                          wgenerage.endcnt ,
                          YEAR(wgenerage.dcomdat) ,
                          wgenerage.dcomdat ,
                          sicsyac.xmm225.treaty ,
                   OUTPUT n_comper   ,
                   OUTPUT n_comper2  ,
                   OUTPUT n_rip1ae   ,
                   OUTPUT n_rip2ae   ,
                   OUTPUT n_err,
                   OUTPUT n_treaty_yr).
                IF n_err <> "" THEN DO:
                    HIDE MESSAGE NO-PAUSE.
                    MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                    NEXT.
                END.
              END.
              /*End A64-0380*/
              CREATE wallocate.
              ASSIGN
                wallocate.csftq = "T" 
                wallocate.rico  = "0RET"
                wallocate.rip1  = 0
                wallocate.per   = n_per
                wallocate.si    = (wgenerage.si * n_per) / 100             
                wallocate.pd    = n_0ret /*(wgenerage.prem * n_per) / 100*/  
                wallocate.com   = 0
                /*Add A64-0380*/
                wallocate.rip1ae = n_rip1ae 
                wallocate.rip2ae = n_rip2ae 
                wallocate.com2   = n_comper2
                wallocate.treaty_yr = n_treaty_yr.
                /*End A64-0380*/

              n_comper = 0. n_comper2 = 0.
              /*FIND sicsyac.xmm025 USE-INDEX xmm02501 WHERE
                   sicsyac.xmm025.treaty = "0TA" + SUBSTRING(nv_type,2,2) + "01"
              NO-LOCK NO-ERROR.
              IF AVAILABLE sicsyac.xmm025 THEN ASSIGN n_comper = sicsyac.xmm025.rip1.  Comment Jiraphon P. A64-0380*/
              /*Add Jiraphon P. A64-0380*/
              FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
                   sicsyac.xmm225.treaty = "0TA" + SUBSTRING(nv_type,2,2) + "01" AND 
                   sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
              NO-LOCK NO-ERROR.
              IF AVAILABLE sicsyac.xmm225 THEN DO:
                ASSIGN
                n_err    = ""  n_comper = 0  n_comper2 = 0
                n_rip1ae = NO  n_rip2ae = NO n_treaty_yr = "".
                RUN wuw\wuwetr225
                  (INPUT  wgenerage.policy , 
                          wgenerage.rencnt , 
                          wgenerage.endcnt ,
                          YEAR(wgenerage.dcomdat) ,
                          wgenerage.dcomdat ,
                          sicsyac.xmm225.treaty ,
                   OUTPUT n_comper,
                   OUTPUT n_comper2 ,
                   OUTPUT n_rip1ae  ,
                   OUTPUT n_rip2ae  ,
                   OUTPUT n_err,
                   OUTPUT n_treaty_yr).
                IF n_err <> "" THEN DO:
                    HIDE MESSAGE NO-PAUSE.
                    MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                    NEXT.
                END.
              END.
              /*End Add Jiraphon P. A64-0380*/

              CREATE wallocate.
              ASSIGN
                wallocate.csftq = "T" 
                wallocate.rico  = "0TA" + SUBSTRING(nv_type,2,2) + "01"
                wallocate.rip1  = n_comper
                wallocate.per   = 100 - n_per
                wallocate.si    = (wgenerage.si * wallocate.per) / 100             
                wallocate.pd    = (wgenerage.prem - n_0ret) * (-1)   /*((wgenerage.prem * wallocate.per) / 100) * (-1) */
                /*wallocate.com   = TRUNCATE((((wallocate.pd * n_comper) / 100) * -1), 0) Comment a64-0380*/
                /*Add A64-0380*/
                wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * -1), 2) /*ปัดทศนิยม 2 ตำแหน่ง*/
                wallocate.rip2  = n_comper2 
                wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2) /*ปัดทศนิยม 2 ตำแหน่ง*/
                wallocate.treaty_yr = n_treaty_yr
                wallocate.rip1ae = n_rip1ae
                wallocate.rip2ae = n_rip2ae.
                /*End A64-0380*/
          END.
      END.
  END.
  ELSE DO: /*CASE <> 1*/
      IF n_per >= 100 THEN DO:
          /*--------- Add Chutikarn A51-0056 ------*/
          /*--
          ASSIGN
            n_0ret      = wgenerage.prem / 2
            n_check0ret = n_0ret - ROUND(n_0ret,0).
          IF n_check0ret > 0 THEN n_0ret = ROUND(n_0ret,0) + 1.
          ELSE n_0ret = ROUND(n_0ret,0). --*/
          IF n_case = 2 THEN DO: 
              ASSIGN
                n_0ret        = wgenerage.prem / 2
                n_si0ret      = wgenerage.si   / 2
                n_check0ret   = n_0ret   - ROUND(n_0ret,0)
                n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
              IF n_check0ret > 0   THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
              IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

              ASSIGN n_allo1 = 50
                     n_allo2 = 50.
          END.
          ELSE IF n_case = 3 THEN DO:
              ASSIGN
                n_0ret        = (wgenerage.prem * 30) / 100
                n_si0ret      = (wgenerage.si * 30) / 100
                n_check0ret   = n_0ret   - ROUND(n_0ret,0)
                n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
              IF n_check0ret   > 0 THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
              IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

              ASSIGN n_allo1 = 30
                     n_allo2 = 70.
          END.
          /*--------- End Chutikarn A51-0056 ------*/
          /*Add A64-0380*/
          FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
               sicsyac.xmm225.treaty = "0RET"    AND 
               sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
          NO-LOCK NO-ERROR.
          IF AVAILABLE sicsyac.xmm225 THEN DO:
            ASSIGN
            n_err    = ""  n_comper = 0   n_comper2 = 0
            n_rip1ae = NO  n_rip2ae = NO  n_treaty_yr = "".
            RUN wuw\wuwetr225
              (INPUT  wgenerage.policy , 
                      wgenerage.rencnt , 
                      wgenerage.endcnt ,
                      YEAR(wgenerage.dcomdat) ,
                      wgenerage.dcomdat ,
                      sicsyac.xmm225.treaty ,
               OUTPUT n_comper   ,
               OUTPUT n_comper2  ,
               OUTPUT n_rip1ae   ,
               OUTPUT n_rip2ae   ,
               OUTPUT n_err,
               OUTPUT n_treaty_yr).
            IF n_err <> "" THEN DO:
                HIDE MESSAGE NO-PAUSE.
                MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                NEXT.
            END.
          END.
          /*End A64-0380*/  
          CREATE wallocate.
          ASSIGN
            wallocate.csftq = "T" 
            wallocate.rico  = "0RET"
            wallocate.rip1  = 0
            /*wallocate.per   = 50 -- A51-0056--*/
            wallocate.per   = n_allo1
            /*wallocate.si    = wgenerage.si / 2-- A51-0056 --*/
            wallocate.si    = n_si0ret
            wallocate.pd    = n_0ret /*wgenerage.prem / 2*/
            wallocate.com   = 0
            /*Add A64-0380*/
            wallocate.rip1ae = n_rip1ae 
            wallocate.rip2ae = n_rip2ae 
            wallocate.com2   = n_comper2
            wallocate.treaty_yr = n_treaty_yr.
            /*End A64-0380*/
          n_comper = 0. n_comper2 = 0.
          /*FIND sicsyac.xmm025 USE-INDEX xmm02501 WHERE
               sicsyac.xmm025.treaty = "0RQ" + SUBSTRING(nv_type,2,2)
          NO-LOCK NO-ERROR.
          IF AVAILABLE sicsyac.xmm025 THEN ASSIGN n_comper = sicsyac.xmm025.rip1.  Comment Jiraphon P. A64-0380*/
          /*Add Jiraphon P. A64-0380*/
          FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
               sicsyac.xmm225.treaty = "0RQ" + SUBSTRING(nv_type,2,2) AND 
               sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
          NO-LOCK NO-ERROR.
          IF AVAILABLE sicsyac.xmm225 THEN DO:
            ASSIGN
            n_err    = ""  n_comper = 0  n_comper2 = 0
            n_rip1ae = NO  n_rip2ae = NO n_treaty_yr = "".
            RUN wuw\wuwetr225
              (INPUT  wgenerage.policy , 
                      wgenerage.rencnt , 
                      wgenerage.endcnt ,
                      YEAR(wgenerage.dcomdat) ,
                      wgenerage.dcomdat ,
                      sicsyac.xmm225.treaty ,
               OUTPUT n_comper,
               OUTPUT n_comper2 ,
               OUTPUT n_rip1ae  ,
               OUTPUT n_rip2ae  ,
               OUTPUT n_err,
               OUTPUT n_treaty_yr).
            IF n_err <> "" THEN DO:
                HIDE MESSAGE NO-PAUSE.
                MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                NEXT.
            END.
          END.
         /*End Add Jiraphon P. A64-0380*/
          CREATE wallocate.
          ASSIGN
            wallocate.csftq = "T" 
            wallocate.rico  = "0RQ" + SUBSTRING(nv_type,2,2)
            wallocate.rip1  = n_comper
            /*wallocate.per   = 50 -- A51-0056--*/
            wallocate.per   = n_allo2
            wallocate.si    = (wgenerage.si - n_si0ret) 
            wallocate.pd    = (wgenerage.prem - n_0ret) * (-1) /*(wgenerage.prem / 2) * (-1)*/
            /*wallocate.com   = TRUNCATE((((wallocate.pd * n_comper) / 100) * (-1)), 0) Comment a64-0380*/
            /*Add A64-0380*/
            wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * (-1)), 2) /*ทศนิยม 2 ตำแหน่ง*/
            wallocate.rip2  = n_comper2 
            wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2) /*ทศนิยม 2 ตำแหน่ง*/
            wallocate.treaty_yr = n_treaty_yr
            wallocate.rip1ae = n_rip1ae
            wallocate.rip2ae = n_rip2ae.
            /*End A64-0380*/
      END.
      ELSE DO:
          IF n_per <> 0  THEN DO:
              /*--------- Add Chutikarn A51-0056 ------*/
              /*---
              ASSIGN
                n_0ret      = (wgenerage.prem * n_per2) / 100
                n_check0ret = n_0ret - ROUND(n_0ret,0).
              IF n_check0ret > 0 THEN n_0ret = ROUND(n_0ret,0) + 1.
              ELSE n_0ret = ROUND(n_0ret,0).
              ----*/
              IF n_case = 2 THEN DO: 
                 ASSIGN
                    n_all         = TRUNCATE((wgenerage.prem * n_per) / 100,0)
                    n_siall       = TRUNCATE((wgenerage.si * n_per) / 100,0)                    
                    n_0ret        = (wgenerage.prem * n_per2) / 100
                    n_si0ret      = (wgenerage.si   * n_per2) / 100
                    n_check0ret   = n_0ret   - ROUND(n_0ret,0)
                    n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
                 IF n_check0ret   > 0 THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
                 IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

                 ASSIGN n_allo1   = n_per2
                        n_allo2   = n_per2
                        n_si0rq   = n_siall - n_si0ret
                        n_0rq     = n_all - n_0ret.
              END.
              ELSE IF n_case = 3 THEN DO:
                 ASSIGN
                    n_all         = TRUNCATE((wgenerage.prem * n_per) / 100,0)
                    n_siall       = TRUNCATE((wgenerage.si * n_per) / 100,0)
                    n_0ret        = (wgenerage.prem * n_per3) / 100
                    n_si0ret      = (wgenerage.si   * n_per3) / 100
                    n_check0ret   = n_0ret   - ROUND(n_0ret,0).
                    n_sicheck0ret = n_si0ret - ROUND(n_si0ret,0).
                 IF n_check0ret   > 0 THEN n_0ret   = ROUND(n_0ret,0) + 1.   ELSE n_0ret   = ROUND(n_0ret,0).
                 IF n_sicheck0ret > 0 THEN n_si0ret = ROUND(n_si0ret,0) + 1. ELSE n_si0ret = ROUND(n_si0ret,0).

                 ASSIGN n_allo1 = n_per3
                        n_allo2 = n_per4
                        n_si0rq = n_siall - n_si0ret
                        n_0rq     = n_all - n_0ret.
              END.
              /*--------- End Chutikarn A51-0056 ------*/
              /*Add A64-0380*/
              FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
                   sicsyac.xmm225.treaty = "0RET"    AND 
                   sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
              NO-LOCK NO-ERROR.
              IF AVAILABLE sicsyac.xmm225 THEN DO:
                ASSIGN
                n_err    = ""  n_comper = 0  n_comper2 = 0
                n_rip1ae = NO  n_rip2ae = NO n_treaty_yr = "".
                RUN wuw\wuwetr225
                  (INPUT  wgenerage.policy , 
                          wgenerage.rencnt , 
                          wgenerage.endcnt ,
                          YEAR(wgenerage.dcomdat) ,
                          wgenerage.dcomdat ,
                          sicsyac.xmm225.treaty ,
                   OUTPUT n_comper   ,
                   OUTPUT n_comper2  ,
                   OUTPUT n_rip1ae   ,
                   OUTPUT n_rip2ae   ,
                   OUTPUT n_err,
                   OUTPUT n_treaty_yr).
                IF n_err <> "" THEN DO:
                    HIDE MESSAGE NO-PAUSE.
                    MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                    NEXT.
                END.
              END.
              /*End A64-0380*/  
              CREATE wallocate.
              ASSIGN
                wallocate.csftq = "T" 
                wallocate.rico  = "0RET"
                wallocate.rip1  = 0
                /*wallocate.per   = n_per2-- A51-0056 --*/
                wallocate.per   = n_allo1
                wallocate.si    = n_si0ret
                wallocate.pd    = n_0ret /*(wgenerage.prem * n_per2) / 100*/
                wallocate.com   = 0
                /*Add A64-0380*/
                wallocate.rip1ae = n_rip1ae 
                wallocate.rip2ae = n_rip2ae 
                wallocate.com2   = n_comper2
                wallocate.treaty_yr = n_treaty_yr.
                /*End A64-0380*/

              n_comper = 0. n_comper2 = 0.
              /*FIND sicsyac.xmm025 USE-INDEX xmm02501 WHERE
                   sicsyac.xmm025.treaty = "0RQ" + SUBSTRING(nv_type,2,2)
              NO-LOCK NO-ERROR.
              IF AVAILABLE sicsyac.xmm025 THEN ASSIGN n_comper = sicsyac.xmm025.rip1.  Comment Jiraphon P. A64-0380*/
              /*Add Jiraphon P. A64-0380*/
              FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
                   sicsyac.xmm225.treaty = "0RQ" + SUBSTRING(nv_type,2,2) AND 
                   sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
              NO-LOCK NO-ERROR.
              IF AVAILABLE sicsyac.xmm225 THEN DO:
                ASSIGN
                n_err    = ""  n_comper = 0  n_comper2 = 0
                n_rip1ae = NO  n_rip2ae = NO n_treaty_yr = "".
                RUN wuw\wuwetr225
                  (INPUT  wgenerage.policy , 
                          wgenerage.rencnt , 
                          wgenerage.endcnt ,
                          YEAR(wgenerage.dcomdat) ,
                          wgenerage.dcomdat ,
                          sicsyac.xmm225.treaty ,
                   OUTPUT n_comper,
                   OUTPUT n_comper2 ,
                   OUTPUT n_rip1ae  ,
                   OUTPUT n_rip2ae  ,
                   OUTPUT n_err,
                   OUTPUT n_treaty_yr).
                IF n_err <> "" THEN DO:
                    HIDE MESSAGE NO-PAUSE.
                    MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                    NEXT.
                END.
              END.
              /*End Add Jiraphon P. A64-0380*/

              CREATE wallocate.
              ASSIGN
                wallocate.csftq = "T" 
                wallocate.rico  = "0RQ" + SUBSTRING(nv_type,2,2)
                wallocate.rip1  = n_comper
                /*wallocate.per   = n_per2-- A51-0056 --*/
                wallocate.per   = n_allo2
                wallocate.si    = n_si0rq  /*TRUNCATE(((wgenerage.si * n_per2) / 100) , 0) * (-1)       */
                wallocate.pd    = n_0rq  /*(wgenerage.prem / 2) * (-1)*/                                  
                /*wallocate.com   = TRUNCATE((((wallocate.pd * n_comper) / 100) * (-1)), 0) Comment A64-0380*/
                /*Add A64-0380*/
                wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * (-1)), 2)
                wallocate.rip2  = n_comper2 
                wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2)
                wallocate.treaty_yr = n_treaty_yr
                wallocate.rip1ae = n_rip1ae
                wallocate.rip2ae = n_rip2ae.
                /*End A64-0380*/

              n_comper = 0. n_comper2 = 0.
              /*FIND sicsyac.xmm025 USE-INDEX xmm02501 WHERE
                   sicsyac.xmm025.treaty = "0TA" + SUBSTRING(nv_type,2,2) + "01"
              NO-LOCK NO-ERROR.
              IF AVAILABLE sicsyac.xmm025 THEN ASSIGN n_comper = sicsyac.xmm025.rip1.  Comment Jiraphon P. A64-0380*/
                  /*Add Jiraphon P. A64-0380*/
                  FIND sicsyac.xmm225 USE-INDEX xmm22501 WHERE
                       sicsyac.xmm225.treaty = "0TA" + SUBSTRING(nv_type,2,2) + "01" AND 
                       sicsyac.xmm225.tryear = YEAR(wgenerage.dcomdat)
                  NO-LOCK NO-ERROR.
                  IF AVAILABLE sicsyac.xmm225 THEN DO:
                    ASSIGN
                    n_err    = ""  n_comper = 0  n_comper2 = 0
                    n_rip1ae = NO  n_rip2ae = NO n_treaty_yr = "".
                    RUN wuw\wuwetr225
                      (INPUT  wgenerage.policy , 
                              wgenerage.rencnt , 
                              wgenerage.endcnt ,
                              YEAR(wgenerage.dcomdat) ,
                              wgenerage.dcomdat ,
                              sicsyac.xmm225.treaty ,
                       OUTPUT n_comper,
                       OUTPUT n_comper2 ,
                       OUTPUT n_rip1ae  ,
                       OUTPUT n_rip2ae  ,
                       OUTPUT n_err, 
                       OUTPUT n_treaty_yr).
                    IF n_err <> "" THEN DO:
                        HIDE MESSAGE NO-PAUSE.
                        MESSAGE n_err VIEW-AS ALERT-BOX ERROR.
                        NEXT.
                    END.
                  END.
                  /*End Add Jiraphon P. A64-0380*/

              CREATE wallocate.
              ASSIGN
                wallocate.csftq = "T" 
                wallocate.rico  = "0TA" + SUBSTRING(nv_type,2,2) + "01"
                wallocate.rip1  = n_comper
                wallocate.per   = 100 - n_per
                /*wallocate.si    = (wgenerage.si * wallocate.per) / 100    -- A51-0056 --*/
                wallocate.si    = wgenerage.si - (n_si0ret + n_si0rq)    
                /*wallocate.pd    = TRUNCATE(((wgenerage.prem * wallocate.per) / 100), 0) * (-1) -- A51-0056*/
                wallocate.pd    = wgenerage.prem - (n_0ret + n_0rq)                            
                /*wallocate.com   = TRUNCATE((((wallocate.pd * n_comper) / 100) * (-1)) , 0) Comment A64-0380*/
                /*Add A64-0380*/
                wallocate.com   = ROUND((((wallocate.pd * n_comper) / 100) * (-1)) , 2)
                wallocate.rip2  = n_comper2 
                wallocate.com2  = ROUND((((wallocate.pd * n_comper2) / 100) * -1), 2)
                wallocate.treaty_yr = n_treaty_yr
                wallocate.rip1ae = n_rip1ae
                wallocate.rip2ae = n_rip2ae.
                /*End A64-0380*/
          END.
      END.
  END.

  ASSIGN
      /*-- STAT --*/
      nv_stper  = 0
      nv_sistp  = 0  
      nv_pdstp  = 0
      nv_ratest = 0
      nv_comst  = 0
      /*-- TREATY --*/                  
      nv_typer  = 100            /* % */
      nv_sityp  = wgenerage.si   /* SI */
      nv_pdtyp  = wgenerage.prem /* prem */
      nv_ratety = 0              /* % Com*/
      nv_comty  = 0              /* com */
      /*--Coinsurance--*/
      nv_coper  = 0
      nv_sicop  = 0
      nv_pdcop  = 0
      nv_rateco = 0
      nv_comco  = 0
      /*--Facultative--*/ 
      nv_faper  = 0
      nv_sifap  = 0
      nv_pdfap  = 0
      nv_ratefa = 0 
      nv_comfa  = 0
      /*--Quota Share--*/ 
      nv_qsper  = 0
      nv_siqsp  = 0
      nv_pdqsp  = 0
      nv_rateqs = 0 
      nv_comqs  = 0.

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
        IF INPUT fi_policyinput <> nv_poltotal   OR
           INPUT fi_policyinput <> nv_polsuccess OR
           nv_poltotal          <> nv_polsuccess THEN DO: 
           nv_batflg = NO.
           nv_txtmsg = "have batch file error..!!".
        END.
        ELSE /*--- Check Premium ---*/
           IF INPUT fi_preminput  <> nv_premtotal   OR
              INPUT fi_preminput  <> nv_premsuccess OR
              nv_premtotal        <> nv_premsuccess THEN DO:
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_Checkpol C-Win 
PROCEDURE pd_Checkpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
      /*------------- Add Chutikarn A50-0072 --------------*/
      /*--- Begin Policy Type -----*/
      ASSIGN
         nv_typpol = 0
         nv_typpol = INTEGER(SUBSTRING(STRING(wgenerage.cedpol),1,3)).

      IF      nv_typpol = 110 THEN nv_poltyp = "F10".
      ELSE IF nv_typpol = 180 THEN nv_poltyp = "F10".
      ELSE IF nv_typpol = 090 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 140 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 174 THEN nv_poltyp = "M80".
      ELSE IF nv_typpol = 155 THEN nv_poltyp = "M83".
      ELSE IF nv_typpol = 410 THEN nv_poltyp = "M43".
      ELSE IF nv_typpol = 537 THEN nv_poltyp = "M40".
      ELSE IF nv_typpol = 573 THEN nv_poltyp = "M84".
      ELSE IF nv_typpol = 125 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 135 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 548 THEN nv_poltyp = "M41".
      ELSE IF nv_typpol = 591 THEN nv_poltyp = "M21".
      ELSE IF nv_typpol = 612 THEN nv_poltyp = "M23".
      ELSE IF nv_typpol = 640 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 655 THEN nv_poltyp = "M20".
      ELSE IF nv_typpol = 680 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 676 THEN nv_poltyp = "M22".
      ELSE IF nv_typpol = 825 THEN nv_poltyp = "M82".
      ELSE IF nv_typpol = 846 THEN nv_poltyp = "M85".
      ELSE IF nv_typpol = 858 THEN nv_poltyp = "M37".
      ELSE IF nv_typpol = 501 THEN nv_poltyp = "M60".
      ELSE IF nv_typpol = 510 THEN nv_poltyp = "M60".
      ELSE IF nv_typpol = 502 THEN nv_poltyp = "M64".
      /*----- Add A50-0248 -----*/
      /*----
      ELSE IF nv_typpol = 580 THEN nv_poltyp = "M61".
      ELSE IF nv_typpol = 422 THEN nv_poltyp = "M61".
      ------*/
      ELSE IF nv_typpol = 580 THEN nv_poltyp = "M68".
      ELSE IF nv_typpol = 422 THEN nv_poltyp = "M68".
      /*----- End A50-0248 ------*/
      ELSE IF nv_typpol = 426 THEN nv_poltyp = "M64".
      ELSE IF nv_typpol = 425 THEN nv_poltyp = "M65".
      ELSE DO: 
          ASSIGN
              nv_texterror = "ไม่พบ Policy Class ที่สามารถแปลงไปเป็นกรมธรรม์ Safety ได้"
              nv_poltyp    = " ".
      END. 
      /*--- End Policy Type -----*/      
      /*------------- End Chutikarn A50-0072 --------------*/

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
          /*---Wantanee A49-0165 03/10/2006-----
          /*----------- Begin Running Policy -----*/  
          n_undyr = STRING(YEAR(TODAY),"9999"). 

          IF nv_policy = "" THEN DO:
              RUN wuz\wuzpolno(INPUT  NO,/*nv_dir_ri*/
                               INPUT         nv_poltyp,
                               INPUT         nv_branch,
                               INPUT         n_undyr ,
                               INPUT-OUTPUT  nv_policy ,
                               INPUT-OUTPUT  nv_check).
              IF  nv_check  <>  ""  THEN DO:
                    PUT STREAM nerror
                        n_count ";"
                        wgenerage.cedpol ";"
                        "Error Running Policy No." ";"
                    SKIP.
                    NEXT Loop_main.              
              END.
                  
              loop_runningPolicy: /*Check Insured*/
              REPEAT:
                  FIND FIRST sicuw.uwm100 USE-INDEX  uwm10001 WHERE
                             sicuw.uwm100.policy  =  nv_policy  NO-LOCK NO-ERROR NO-WAIT.
                  IF  AVAIL  sicuw.uwm100 THEN DO:
                      RUN wuz\wuzpolno(INPUT  NO,             /*nv_dir_ri*/
                                       INPUT         nv_poltyp,
                                       INPUT         nv_branch,
                                       INPUT         n_undyr ,
                                       INPUT-OUTPUT  nv_policy ,
                                       INPUT-OUTPUT  nv_check).
                      IF  nv_check  <>  ""  THEN DO:                            
                            PUT STREAM nerror
                                n_count ";"
                                wgenerage.cedpol ";"
                                "Error Running Policy No." ";"
                            SKIP.
                            LEAVE loop_runningPolicy.
                            NEXT Loop_main. 
                      END.
                  END.
                  ELSE DO:
                      LEAVE loop_runningPolicy.
                  END.
              END.
          END. /*End nv_policy = "" */
          /*----------- End Running Policy -----*/

          /*-----Endorse----------------------------------
          /*----------- Begin Running EndNo -----*/
          IF nv_endcnt > 0 THEN DO:
              loop_runningEndno:
              REPEAT:
                 FIND XZM054 WHERE
                    XZM054.dir_ri = NO        AND
                    XZM054.poltyp = nv_poltyp AND
                    XZM054.branch = nv_branch
                    NO-WAIT NO-ERROR.
                 IF NOT AVAILABLE xzm054 THEN DO:
                    IF LOCKED XZM054 THEN DO:
                        PUT STREAM nerror
                            n_count ";"
                            wgenerage.cedpol ";"
                            "Error Running Endorse No." ";"
                        SKIP.                      
                        LEAVE loop_runningEndno.
                        NEXT Loop_main. 
                    END.
                    ELSE DO:
                        RELEASE XZM054.
                        MESSAGE "Not parameter on XZM054" VIEW-AS ALERT-BOX. 
                        PUT STREAM nerror
                            n_count ";"
                            wgenerage.cedpol ";"
                            "Error Running Endorse No.---> Not parameter on XZM054" ";"
                        SKIP.                      
                        LEAVE loop_runningEndno.
                        NEXT Loop_main. 
                    END.
                 END.
                 ASSIGN nv_endnum = SUBSTRING(STRING(YEAR(TODAY) + 543,"9999"),3,2) + "-" +
                                    STRING(xzm054.nextno,"99999").
                 ASSIGN xzm054.nextno = xzm054.nextno + 1.
                 LEAVE loop_runningEndno.
              END.
              RELEASE xzm054.
          END.
          /*----------- End Running EndNO -----*/
          -----Endorse----------------------------------*/
          ---Wantanee A49-0165 03/10/2006-----*/

          DISP "Process cedpol : " wgenerage.cedpol "To Policy : " nv_policy " R/E : " nv_rencnt "/" nv_endcnt 
               WITH COLOR BLACK/WHITE NO-LABEL TITLE "PROCESS..." WIDTH 100 FRAME AMain VIEW-AS DIALOG-BOX.

          /*--------------------BEGIN GENERATE----------------------*/
          RUN pd_uwm100.  /*--UWM100--*/ 
          /*-----Wantanee A49-0165 3/10/2006-----
          IF nv_check <> "" THEN DO:
            PUT STREAM nerror
                n_count ";"
                wgenerage.cedpol ";"
                "พบข้อมูลมีอยู่แล้วที่ Policy Master (UWM100) <" nv_policy ">" ";"
            SKIP.
            NEXT Loop_main. 
          END.
          -----------------------------*/    

          RUN pd_uwm120. /*UWM120*/
          /*-----Wantanee A49-0165 3/10/2006-----
          IF nv_check <> "" THEN DO:
            PUT STREAM nerror
                n_count ";"
                wgenerage.cedpol ";"
                "พบข้อมูลมีอยู่แล้วที่ Risk Header (UWM120) <" nv_policy ">" ";"
            SKIP.
            NEXT Loop_main. 
          END.
          -----------------------------*/

          IF nv_poltyp = "M60" OR 
             nv_poltyp = "M61" OR 
             nv_poltyp = "M64" OR 
             nv_poltyp = "M68" THEN DO:  /*-- A50-0248 chutikarn --*/
              RUN pd_uwm307. /*UWM304*/
              /*-----Wantanee A49-0165 3/10/2006-----
              IF nv_check <> "" THEN DO:
                PUT STREAM nerror
                    n_count ";"
                    wgenerage.cedpol ";"
                    "พบข้อมูลมีอยู่แล้วที่ Detail Risk (UWM307) <" nv_policy ">" ";"
                SKIP.
                NEXT Loop_main. 
              END.
              -----------------------------*/
          END.
          ELSE DO:
              RUN pd_uwm304. /*UWM304*/
              /*-----Wantanee A49-0165 3/10/2006-----
              IF nv_check <> "" THEN DO:
                PUT STREAM nerror
                    n_count ";"
                    wgenerage.cedpol ";"
                    "พบข้อมูลมีอยู่แล้วที่ Fire Risk (UWM304) <" nv_policy ">" ";"
                SKIP.
                NEXT Loop_main. 
              END.
              -----------------------------*/
          END.
          
          RUN pd_uwm130. /*UWM130*/
          /*-----Wantanee A49-0165 3/10/2006-----
          IF nv_check <> "" THEN DO:
            PUT STREAM nerror
                n_count ";"
                wgenerage.cedpol ";"
                "พบข้อมูลมีอยู่แล้วที่ Insured Item (UWM130 OR UWD132) <" nv_policy ">" ";"
            SKIP.
            NEXT Loop_main. 
          END.
          -----------------------------*/
          
          RUN pd_uwm200. /*UWM200*/
          /*-----Wantanee A49-0165 3/10/2006-----
          IF nv_check <> "" THEN DO:
            PUT STREAM nerror
                n_count ";"
                wgenerage.cedpol ";"
                "พบข้อมูลมีอยู่แล้วที่ RI OUT HEADER (UWM200 OR UWD200) <" nv_policy ">" ";"
            SKIP.
            NEXT Loop_main.
          END.
          -----------------------------*/
          /*--------------------END GENERATE----------------------*/

          ASSIGN 
            wgenerage.policy  = nv_policy
            wgenerage.rencnt  = nv_rencnt
            wgenerage.endcnt  = nv_endcnt
            wgenerage.dcomdat = n_cdate 
            wgenerage.dexpdat = n_edate
            wgenerage.rec100  = nv_recid100
            wgenerage.rec120  = nv_recid120
            wgenerage.rec130  = nv_recid130
            wgenerage.rec132  = nv_recid132
            wgenerage.rec304  = nv_recid304
            wgenerage.rec307  = nv_recid307
            wgenerage.poltyp  = nv_poltyp.

      END. /*End Transaction*/    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Import C-Win 
PROCEDURE Pd_Import :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_sum = 0.
DO WITH FRAME fr_main:

    FOR EACH wgenerage:
        DELETE wgenerage.
    END.
    
    IF INPUT fi_output1 <> "" THEN DO:
        OUTPUT STREAM nfile TO VALUE(INPUT fi_output1).
        OUTPUT STREAM nfile CLOSE.
    END.

    FOR EACH wdelimi:
        DELETE wdelimi.
    END.

    INPUT STREAM nfile FROM VALUE(INPUT fi_input).
    REPEAT:
        CREATE wdelimi.
        IMPORT STREAM nfile wdelimi.
        LEAVE.
    END.    
    INPUT STREAM nfile CLOSE.

    FIND FIRST wdelimi NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE wdelimi THEN DO:
        HIDE MESSAGE NO-PAUSE.
        MESSAGE " Not found data " VIEW-AS ALERT-BOX ERROR.
        NEXT.
    END.

    ASSIGN
        nv_line      = 0
        nv_delimiter = NO
        nv_delimitxt = wdelimi.txt.

    REPEAT:
        IF INDEX(nv_delimitxt,",") <> 0 THEN DO:
            IF nv_line = 0 THEN
                nv_delimitxt = SUBSTRING(wdelimi.txt,INDEX(nv_delimitxt,",") + 1,256).
            ELSE DO:
                nv_delimiter = YES.
                LEAVE.
            END.
            nv_line = nv_line + 1.
        END.
        ELSE LEAVE.
    END.
    /* END Check data DELIMITER "," */

    IF nv_delimiter = YES THEN DO:
        INPUT STREAM nfile FROM VALUE(INPUT fi_input).    
        REPEAT :
            CREATE wgenerage.
            IMPORT STREAM nfile DELIMITER "," wgenerage.
            n_sum = n_sum + 1.
        END.     
        INPUT STREAM nfile CLOSE.    
    END.
    
    FIND FIRST wgenerage NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE wgenerage THEN DO:
        MESSAGE " Not found data " VIEW-AS ALERT-BOX ERROR.
        NEXT.
    END.
    ELSE DO:
        /*-- Running Batch file Master , Update field, Trasaction batch no.--*/
        RUN wgw\wgwbatch.p(INPUT        nv_trndat   ,             /* DATE  */
                           INPUT        nv_Bchyr  ,             /* INT   */
                           INPUT        nv_acno1    ,             /* CHAR  */ 
                           INPUT        (INPUT fi_bran)     ,     /* CHAR  */
                           INPUT        (INPUT fi_prvbatch) ,     /* CHAR  */
                           INPUT        "WGWIMPT1"  ,             /* CHAR  */
                           INPUT-OUTPUT nv_Bchno  ,             /* CHAR  */
                           INPUT-OUTPUT nv_Bchcnt   ,             /* INT   */
                           INPUT        (INPUT fi_policyinput)  , /* INT   */
                           INPUT        (INPUT fi_preminput)      /* DECI  */
                           ).

        fi_batch = CAPS(nv_Bchno + "." + STRING(nv_Bchcnt,"99")).
        DISP fi_batch WITH FRAME fr_main.
    END.
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

    RUN Pd_Import. /*IMPORT DATA*/

    OUTPUT STREAM nnoterror TO VALUE(INPUT fi_output1). /* Wantanee A49-0165*/
    OUTPUT STREAM nerror    TO VALUE(INPUT fi_output2). 

    PUT STREAM nnoterror   /* Wantanee A49-0165 */
      "ลำดับที่" ";"
      "Policy No" ";"
      "Policy Type" ";"
      "Insured Name" ";"
      "Com Date" ";"
      "Expiry Date" ";"
      "% Safety" ";"
      "% Commission" ";"
      "Premium" ";"
      "Commission" ";"
      "Net Premium" ";"
      "Sum Insured(100%)" ";"
      "Sum Insured Safety" ";"
    SKIP.
    
    PUT STREAM nerror   /* Wantanee A49-0165 */
      "ลำดับที่" ";"
      "Policy No" ";"
      "Policy Type" ";"
      "Insured Name" ";"
      "Com Date" ";"
      "Expiry Date" ";"
      "% Safety" ";"
      "% Commission" ";"
      "Premium" ";"
      "Commission" ";"
      "Net Premium" ";"
      "Sum Insured(100%)" ";"
      "Sum Insured Safety" ";"
      "รายการข้อผิดพลาด" ";"
      SKIP.

    /*---
    /*-- Running Batch file Master , Update field, Trasaction batch no.--*/
    RUN wgw\wgwbatch.p(INPUT        nv_trndat   ,             /* DATE  */
                       INPUT        nv_Bchyr  ,             /* INT   */
                       INPUT        nv_acno1    ,             /* CHAR  */ 
                       INPUT        (INPUT fi_bran)     ,     /* CHAR  */
                       INPUT        (INPUT fi_prvbatch) ,     /* CHAR  */
                       INPUT        "WGWIMPT1"  ,             /* CHAR  */
                       INPUT-OUTPUT nv_Bchno  ,             /* CHAR  */
                       INPUT-OUTPUT nv_Bchcnt   ,             /* INT   */
                       INPUT        (INPUT fi_policyinput)  , /* INT   */
                       INPUT        (INPUT fi_preminput)      /* DECI  */
                       ).

    fi_batch = CAPS(nv_Bchno + "." + STRING(nv_Bchcnt,"99")).
    DISP fi_batch WITH FRAME fr_main.
    -----*/

      Loop_main:
      FOR EACH wgenerage NO-LOCK :
        ASSIGN
         nv_texterror = ""
         n_count      = n_count + 1
         nv_polflg    = YES.

        IF n_count > n_sum THEN NEXT.
        DISP " Please Wait.... Check Data No. : " TRIM(STRING(n_count)  + "/" + STRING(n_sum))
               WITH COLOR BLACK/WHITE NO-LABEL TITLE "PROCESS..." WIDTH 100 FRAME AAMain VIEW-AS DIALOG-BOX.

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
        nv_recid304  = 0.

      IF wgenerage.cedpol = "" AND wgenerage.comdat = 0  AND  /*Last Record*/   
         wgenerage.expdat = 0  AND wgenerage.name1  = "" AND 
         wgenerage.prem   = 0  AND wgenerage.si     = 0  THEN NEXT Loop_main.                                                                                                                                             
      
      /*------------- Add Chutikarn A50-0072 --------------*/
      /*--- Begin Policy Type -----
      ASSIGN
         nv_typpol = 0
         nv_typpol = INTEGER(SUBSTRING(STRING(wgenerage.cedpol),1,2)).

      IF      nv_typpol = 9  THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 10 THEN nv_poltyp = "F10".
      ELSE IF nv_typpol = 11 THEN nv_poltyp = "F10".
      ELSE IF nv_typpol = 12 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 13 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 14 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 15 THEN nv_poltyp = "M83".
      ELSE IF nv_typpol = 16 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 17 THEN nv_poltyp = "M80".
      ELSE IF nv_typpol = 18 THEN nv_poltyp = "F10".
      ELSE IF nv_typpol = 19 THEN nv_poltyp = "F10".
      ELSE IF nv_typpol = 41 THEN nv_poltyp = "M43".
      ELSE IF nv_typpol = 42 THEN nv_poltyp = "M43".
      ELSE IF nv_typpol = 43 THEN nv_poltyp = "M43".
      ELSE IF nv_typpol = 50 THEN nv_poltyp = "M64".
      ELSE IF nv_typpol = 51 THEN nv_poltyp = "M60".
      ELSE IF nv_typpol = 52 THEN nv_poltyp = "M61".
      ELSE IF nv_typpol = 53 THEN nv_poltyp = "M40".
      ELSE IF nv_typpol = 54 THEN nv_poltyp = "M41".
      ELSE IF nv_typpol = 55 THEN nv_poltyp = "M24".
      ELSE IF nv_typpol = 56 THEN nv_poltyp = "M40".
      ELSE IF nv_typpol = 57 THEN nv_poltyp = "M84".
      ELSE IF nv_typpol = 59 THEN nv_poltyp = "M21".
      ELSE IF nv_typpol = 61 THEN nv_poltyp = "M23".
      ELSE IF nv_typpol = 63 THEN nv_poltyp = "M23".
      ELSE IF nv_typpol = 64 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 65 THEN nv_poltyp = "M20".
      ELSE IF nv_typpol = 67 THEN nv_poltyp = "M22".
      ELSE IF nv_typpol = 68 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 80 THEN nv_poltyp = "M82".
      ELSE IF nv_typpol = 81 THEN nv_poltyp = "M82".
      ELSE IF nv_typpol = 83 THEN nv_poltyp = "M12".
      ELSE IF nv_typpol = 84 THEN nv_poltyp = "M85".
      ELSE IF nv_typpol = 85 THEN nv_poltyp = "M37".
      ELSE DO: 
          ASSIGN
              nv_texterror = "ไม่พบ Policy Class ที่สามารถแปลงไปเป็นกรมธรรม์ Safety ได้"
              nv_poltyp    = " ".
      END.
      --- End Policy Type -----*/
      RUN pd_Checkpol.
      /*------------- End Chutikarn A50-0072 --------------*/

      IF wgenerage.cedpol = "" THEN DO:    
         IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
         nv_texterror = nv_texterror + "ไม่มีค่า POLICY NO.".   
      END.

      IF wgenerage.name1 = "" THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า INSURED NAME".   
      END.

      IF wgenerage.comdat = 0 THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า EFFECTIVE DATE (Comdate)".   
      END.

      IF wgenerage.expdat = 0 THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า EXPIRY DATE".   
      END.

      ASSIGN
        n_cdate = DATE(SUBSTRING(STRING(wgenerage.comdat),7,2) + "/" + 
                       SUBSTRING(STRING(wgenerage.comdat),5,2) + "/" + 
                       SUBSTRING(STRING(wgenerage.comdat),1,4)). 
        n_edate = DATE(SUBSTRING(STRING(wgenerage.expdat),7,2) + "/" + 
                       SUBSTRING(STRING(wgenerage.expdat),5,2) + "/" + 
                       SUBSTRING(STRING(wgenerage.expdat),1,4)).   

      IF n_cdate <> ? AND n_edate <> ? THEN DO:
          IF (DAY(n_cdate)   <> DAY(n_edate))   OR 
             (MONTH(n_cdate) <> MONTH(n_edate)) OR 
             (YEAR(n_edate)  <> (YEAR(n_cdate) + 1)) THEN DO:
              IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
              nv_texterror = nv_texterror + "วันคุ้มครองไม่เต็มปี".   
          END.
      END.

      IF wgenerage.prem = 0 THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า PREMIUM".   
      END.
      
      IF wgenerage.netprem = 0 THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า NET PREMIUM".   
      END.

      IF wgenerage.si = 0 THEN DO:
          IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
          nv_texterror = nv_texterror + "ไม่มีค่า SUM INSURED (R/I INSURED)".   
      END.
                                                          
      /*---- Begin Find Cedpol --------*/
      /*----Add Chutikarn 23/01/2006-----*/
      /*--
      FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
               (sicuw.uwm100.cedpol  = wgenerage.cedpol OR
                SUBSTRING(sicuw.uwm100.cedpol,4,LENGTH(wgenerage.cedpol))  = wgenerage.cedpol) /*Chutikarn : Thitaporn Dankul M2 request Date 15/11/2006*/
      NO-LOCK NO-ERROR NO-WAIT.
      --*/
      FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                sicuw.uwm100.cedpol  = wgenerage.cedpol
      NO-LOCK NO-ERROR NO-WAIT.
      /*-- Chutikarn A50-0072 --
      IF NOT AVAIL sicuw.uwm100 THEN DO:
          FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                    SUBSTRING(sicuw.uwm100.cedpol,4,LENGTH(wgenerage.cedpol))  = wgenerage.cedpol /*Chutikarn : Thitaporn Dankul M2 request Date 15/11/2006*/
          NO-LOCK NO-ERROR NO-WAIT.
      END.
      ------------------------*/
      /*----End Chutikarn 23/01/2006-----*/
      IF AVAIL sicuw.uwm100 THEN DO:
          IF sicuw.uwm100.comdat <= n_cdate AND
             sicuw.uwm100.expdat  = n_cdate THEN DO:
              IF sicuw.uwm100.releas = NO THEN DO:
                  IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
                  nv_texterror = nv_texterror + "พบข้อมูลแต่กรมธรรม์ (" + sicuw.uwm100.policy +
                                 "สลักหลังครั้งที่ " + STRING(sicuw.uwm100.endcnt) + ") ยังไม่ได้ Release ไม่สามารถต่ออายุได้".
              END.  /*End uwm100.releas*/

              ASSIGN
                nv_rencnt    = sicuw.uwm100.rencnt + 1
                nv_endcnt    = 0
                nv_prvpol    = ""
                nv_renpol    = ""
                nv_policyold = sicuw.uwm100.policy
                nv_fdateold  = sicuw.uwm100.fstdat
                /*nv_policy    = ""--Wantanee A49-0165--*/
                nv_policy    = wgenerage.cedpol
                nv_status    = "REN".
          END.
          ELSE DO:

              ASSIGN
                nv_rencnt    = 99
                nv_endcnt    = 999
                nv_prvpol    = ""
                nv_renpol    = ""
                nv_policyold = ""
                nv_fdateold  = TODAY
                nv_policy    = wgenerage.cedpol
                nv_status    = "REN".

              IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
              nv_texterror = nv_texterror + "พบข้อมูลกรมธรรม์ (" + sicuw.uwm100.policy + 
                             ") แต่วันคุ้มครองไม่สัมพันธ์กัน ไม่สามารถต่ออายุได้".
          END.
      END.
      ELSE DO:
          ASSIGN 
            nv_prvpol    = ""
            nv_renpol    = ""
            nv_policyold = ""
            nv_fdateold  = ?
            nv_policy    = wgenerage.cedpol
            nv_status    = "NEW".
      END.
      /*---- End Find Cedpol --------*/
                                                          
      /*------Begin check Gen ซ้ำ------
      FIND LAST sicuw.uwm100 WHERE uwm100.cedpol = wgenerage.cedpol AND
                             sicuw.uwm100.comdat = n_cdate AND
                             sicuw.uwm100.expdat = n_edate AND
                             sicuw.uwm100.endcnt = 0
      USE-INDEX uwm10002 NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL sicuw.uwm100 OR LOCKED sicuw.uwm100 THEN DO:
          IF sicuw.uwm100.rencnt > 0 THEN DO:
              PUT STREAM nerror
                  n_count ";"
                  wgenerage.cedpol ";"
                  "มีการ Generate ข้อมูลการต่ออายุแล้ว เป็นเบอร์ Policy " sicuw.uwm100.policy ";"
              SKIP.
          END.
          ELSE DO:
              PUT STREAM nerror
                  n_count ";"
                  wgenerage.cedpol ";"
                  "มีการ Generate ข้อมูลไปแล้ว เป็นเบอร์ Policy " sicuw.uwm100.policy ";"
              SKIP.                  
          END.
          NEXT Loop_main. 
      END.
      --------End check Gen ซ้ำ--------*/

      nv_line   = nv_line  + 1.
      
      /* ----- COMMISSION -----*/
      ASSIGN
        nv_com1_t = 0
        nv_com1p  = 0        
        nv_com1_t = wgenerage.comm
        nv_com1p  = wgenerage.comper.

      IF nv_com1_t <> 0 THEN nv_com1_t = nv_com1_t * -1.

      RUN pd_allocate(INPUT nv_poltyp).

      /*------Wantanee A49-0165------*/
      IF nv_texterror <> "" THEN DO: 
         ASSIGN
           nv_polflg   = NO
           nv_reccount = nv_reccount + 1.
      END.
      ELSE nv_polflg = YES.

      ASSIGN
        nv_poltotal  = nv_poltotal  + 1
        nv_premtotal = nv_premtotal + wgenerage.prem
        nv_comtotal  = nv_comtotal  + wgenerage.comm
        nv_sitotal   = nv_sitotal   + wgenerage.si.


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
         /*NEXT Loop_main.         */
      END.
      ELSE  RUN Pd_Create.  /*Create Data To Database*/
          
      IF nv_texterror <> "" THEN DO:
          PUT STREAM nerror
              n_count ";"
              wgenerage.cedpol ";"
              nv_poltyp ";"
              wgenerage.name1 ";"
              wgenerage.comdat ";"
              wgenerage.expdat ";"             
              wgenerage.premper ";"
              wgenerage.comper ";"
              wgenerage.prem ";"
              wgenerage.comm ";"
              wgenerage.netprem ";"
              wgenerage.grosssi ";"
              wgenerage.si ";"    
              nv_texterror ";"
          SKIP.

          ASSIGN
            nv_polerror  = nv_polerror  + 1
            nv_premerror = nv_premerror + wgenerage.prem
            nv_comerror  = nv_comerror  + wgenerage.comm
            nv_sierror   = nv_sierror   + wgenerage.si.
      END.
      ELSE DO:
          PUT STREAM nnoterror
              n_count ";"
              wgenerage.cedpol ";"
              nv_poltyp ";"
              wgenerage.name1 ";"
              wgenerage.comdat ";"
              wgenerage.expdat ";"             
              wgenerage.premper ";"
              wgenerage.comper ";"
              wgenerage.prem ";"
              wgenerage.comm ";"
              wgenerage.netprem ";"
              wgenerage.grosssi ";"
              wgenerage.si ";"    
          SKIP.

          ASSIGN
            nv_polsuccess  = nv_polsuccess  + 1
            nv_premsuccess = nv_premsuccess + wgenerage.prem
            nv_comsuccess  = nv_comsuccess  + wgenerage.comm
            nv_sisuccess   = nv_sisuccess   + wgenerage.si.
      END.

     END. /*For each wgenerage*/     

     OPEN QUERY br_main FOR EACH wgenerage WHERE wgenerage.policy <> "" NO-LOCK.    

     /*---A49-0165----*/
     ASSIGN
       fi_policytotal   = nv_poltotal
       fi_premtotal     = nv_premtotal
       fi_policysuccess = nv_polsuccess
       fi_premsuccess   = nv_premsuccess.     
     DISP fi_policytotal fi_premtotal fi_policysuccess fi_premsuccess WITH FRAME fr_main.

     RUN Pd_Batch. /* Create uzm701.*/

     /*--------Sum Si & Prem Error------------*/
     PUT STREAM nerror
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         "Total" ";"
         nv_premerror ";"
         nv_comerror ";"
         " " ";"
         " " ";"
         nv_sierror ";"
         " " ";"
     SKIP. 

     /*--------Sum Si & Prem Success------------*/
     PUT STREAM nnoterror
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         " " ";"
         "Total" ";"
         nv_premsuccess ";"
         nv_comsuccess ";"
         " " ";"
         " " ";"
         nv_sisuccess ";"
     SKIP. 

     /*----------------- Screen Data.-------------*/
     OUTPUT STREAM nbatch TO VALUE(INPUT fi_output3).
     PUT STREAM nbatch

     "--- GWTRANSFER : LOAD POLICY INWARD NON-MOTOR (Aon Enterprise) ---" SKIP
     "             Trandate : " INPUT fi_trndat                           SKIP
     "               Branch : " INPUT fi_bran   "  " INPUT fi_brandesc    SKIP
     "        Producer Code : " INPUT fi_acno1  "  " INPUT fi_acdesc      SKIP
     "           Agent Code : " INPUT fi_agent  "  " INPUT fi_agdesc      SKIP
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

 END. /*End do with frame fr_main*/    
 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm100 C-Win 
PROCEDURE pd_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_dept   AS CHAR    FORMAT "X(1)" INIT "".
DEF VAR nv_gstrat AS DECIMAL FORMAT ">>9.99-".

/* ------------- Policy Header ------------ */
nv_check = "".
IF      nv_poltyp = "F10" THEN ASSIGN nv_dept = "A" nv_gstrat = 7.
ELSE IF nv_poltyp = "M12" THEN ASSIGN nv_dept = "B" nv_gstrat = 7.       
ELSE IF nv_poltyp = "M20" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M21" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M22" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M23" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M24" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M37" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M40" THEN ASSIGN nv_dept = "D" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M41" THEN ASSIGN nv_dept = "D" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M43" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M60" THEN ASSIGN nv_dept = "E" nv_gstrat = 2.75. 
ELSE IF nv_poltyp = "M61" THEN ASSIGN nv_dept = "E" nv_gstrat = 2.75. 
ELSE IF nv_poltyp = "M68" THEN ASSIGN nv_dept = "E" nv_gstrat = 7.     /*-- A50-0248 Chutikarn --*/
ELSE IF nv_poltyp = "M64" THEN ASSIGN nv_dept = "E" nv_gstrat = 2.75. 
ELSE IF nv_poltyp = "M80" THEN ASSIGN nv_dept = "C" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M82" THEN ASSIGN nv_dept = "C" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M83" THEN ASSIGN nv_dept = "C" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M84" THEN ASSIGN nv_dept = "B" nv_gstrat = 7. 
ELSE IF nv_poltyp = "M85" THEN ASSIGN nv_dept = "C" nv_gstrat = 7. 
ELSE ASSIGN nv_dept = " " nv_gstrat = 0.

RUN wgw/wgwge100 (INPUT nv_Bchyr,   /*--Wantanee A49-0165--*/               
                        nv_Bchno,                                           
                        nv_Bchcnt,                                            
                        "WGWIMPT0",                                           
                        TRIM(nv_texterror),                                   
                        nv_polflg,

                        nv_policy, 
                        nv_rencnt,
                        nv_endcnt,
                        nv_prvpol, 
                        nv_agent,         
                        wgenerage.name1,   /*nv_insname1,*/
                        n_cdate,           /*nv_comdat */
                        n_edate,           /*nv_expdat */
                        nv_trndat,         /*nv_trndat */
                        nv_acno1,          /*nv_acno1  */
                        wgenerage.prem,    /*nv_prem   */
                        /*nv_pdty_p,       /*nv_pdty_p */*/
                        nv_pdstp,          /*Prem stat*/
                        nv_pdtyp,          /*Prem 0Ret*/
                        nv_pdcop,          /*Prem Coinsurance*/
                        nv_pdfap,          /*Prem Fac*/
                        nv_pdqsp,          /*Prem Qs*/
                        nv_com1_t,         /*Comm */
                        nv_comst,          /*com stat*/
                        nv_comty,          /*com 0Ret*/
                        nv_comco,          /*com coinsurance*/
                        nv_comfa,          /*com fac*/
                        nv_comqs,          /*com qs*/
                        nv_docno1,         /*nv_docno1 */
                        nv_enttim,         /*nv_enttim */
                        wgenerage.si,      /*Sum insured */
                        /*nv_sity_p,       /*nv_sity_p */*/
                        nv_sistp,          /*Si stat*/ 
                        nv_sityp,          /*Si 0Ret*/ 
                        nv_sicop,          /*Si Coinsurance*/
                        nv_sifap,          /*Si Fac*/
                        nv_siqsp,          /*Si Qs*/
                        nv_renpol,         /*nv_renpol*/
                        "",                /*nv_append,*/
                        nv_poltyp,         /*nv_poltyp,*/
                        wgenerage.cedpol,  /*nv_cedpol*/
                        wgenerage.grosssi, /*nv_cedsi*/
                        nv_policyold,     
                        nv_fdateold,      
                        nv_endnum,        
                        nv_status,
                        nv_dept,                          
                        nv_gstrat,         /*Vat or tax*/
                        INPUT fi_bran,
                 OUTPUT nv_recid100,      
           INPUT-OUTPUT nv_check).         /*nv_check  */
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
DEF VAR n_bclass AS CHARACTER FORMAT "X(04)".
DEF VAR n_rtext  AS CHARACTER FORMAT "X(04)".

IF      nv_poltyp = "F10" THEN ASSIGN n_bclass = "F10"   n_rtext = "FI1".
ELSE IF nv_poltyp = "M12" THEN ASSIGN n_bclass = "M12"   n_rtext = "IN1".
ELSE IF nv_poltyp = "M20" THEN ASSIGN n_bclass = "M20"   n_rtext = "AR1".
ELSE IF nv_poltyp = "M21" THEN ASSIGN n_bclass = "M21"   n_rtext = "BG1".
ELSE IF nv_poltyp = "M22" THEN ASSIGN n_bclass = "M22"   n_rtext = "MN1".
ELSE IF nv_poltyp = "M23" THEN ASSIGN n_bclass = "M23"   n_rtext = "FG1".
ELSE IF nv_poltyp = "M24" THEN ASSIGN n_bclass = "M24"   n_rtext = "PG1".
ELSE IF nv_poltyp = "M37" THEN ASSIGN n_bclass = "M37"   n_rtext = "GF0".
ELSE IF nv_poltyp = "M40" THEN ASSIGN n_bclass = "M40"   n_rtext = "IN1".
ELSE IF nv_poltyp = "M41" THEN ASSIGN n_bclass = "M41"   n_rtext = "CPL".
ELSE IF nv_poltyp = "M43" THEN ASSIGN n_bclass = "M43"   n_rtext = "IN1".
ELSE IF nv_poltyp = "M60" THEN ASSIGN n_bclass = "P100"  n_rtext = "".
ELSE IF nv_poltyp = "M61" THEN ASSIGN n_bclass = "P100"  n_rtext = "".
ELSE IF nv_poltyp = "M68" THEN ASSIGN n_bclass = "P100"  n_rtext = "".  /*-- A50-0248 Chutikarn --*/
ELSE IF nv_poltyp = "M64" THEN ASSIGN n_bclass = "P100"  n_rtext = "".
ELSE IF nv_poltyp = "M80" THEN ASSIGN n_bclass = "M80"   n_rtext = "IN1".
ELSE IF nv_poltyp = "M82" THEN ASSIGN n_bclass = "M82"   n_rtext = "IN1".
ELSE IF nv_poltyp = "M83" THEN ASSIGN n_bclass = "M83"   n_rtext = "IN1".
ELSE IF nv_poltyp = "M84" THEN ASSIGN n_bclass = "M84"   n_rtext = "IN1".
ELSE IF nv_poltyp = "M85" THEN ASSIGN n_bclass = "M85"   n_rtext = "EL1".
ELSE ASSIGN n_bclass = " "   n_rtext = " ".

/* ------------ RISK HEADER ------------ */
nv_check = "".
RUN wgw/wgwge120(INPUT nv_Bchyr,   /*--Wantanee A49-0165--*/                                                                         
                       nv_Bchno,                                                                                                     
                       nv_Bchcnt,                                                                                                      
                                
                       nv_policy,        /*nv_policy */
                       nv_rencnt,        
                       nv_endcnt,        
                       wgenerage.prem,   /*nv_prem   */
                       /*nv_pdty_p,      /*nv_pdty_p */*/
                       nv_pdstp,         /*Prem stat*/ 
                       nv_pdtyp,         /*Prem 0Ret*/ 
                       nv_pdcop,         /*Prem Coinsurance*/
                       nv_pdfap,         /*Prem Fac*/
                       nv_pdqsp,         /*Prem Qs*/
                       nv_com1_t,        /*com */
                       nv_com1p,         /*com% */
                       nv_comst,         /*com stat*/
                       nv_comty,         /*com 0Ret*/
                       nv_comco,         /*com coinsurance*/
                       nv_comfa,         /*com fac*/
                       nv_comqs,         /*com qs*/
                       wgenerage.si,     /*nv_si     */
                       /*nv_sity_p,      /*nv_sity_p */*/
                       nv_sistp,         /*Si stat*/ 
                       nv_sityp,         /*Si 0Ret*/  
                       nv_sicop,         /*Si Coinsurance*/
                       nv_sifap,         /*Si Fac*/
                       nv_siqsp,         /*Si Qs*/
                       n_bclass,         /*nv_class  */
                       n_rtext,          /*nv_r_text */
                OUTPUT nv_recid120,      
          INPUT-OUTPUT nv_check).        /*nv_check  */
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
DEF VAR n_itext  AS CHARACTER FORMAT "X(04)".
DEF VAR n_uom1c  AS CHARACTER FORMAT "X(03)".

IF      nv_poltyp = "F10" THEN ASSIGN  n_itext = "F00"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M12" THEN ASSIGN  n_itext = "IN1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M20" THEN ASSIGN  n_itext = "COA"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M21" THEN ASSIGN  n_itext = "B01"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M22" THEN ASSIGN  n_itext = "M01"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M23" THEN ASSIGN  n_itext = "FG1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M24" THEN ASSIGN  n_itext = "PG1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M37" THEN ASSIGN  n_itext = "G10"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M40" THEN ASSIGN  n_itext = "IN1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M41" THEN ASSIGN  n_itext = "41A"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M43" THEN ASSIGN  n_itext = "IN1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M60" THEN ASSIGN  n_itext = ""     n_uom1c = "".  
ELSE IF nv_poltyp = "M61" THEN ASSIGN  n_itext = ""     n_uom1c = "".  
ELSE IF nv_poltyp = "M68" THEN ASSIGN  n_itext = ""     n_uom1c = "".   /*-- A50-0248 Chutikarn --*/
ELSE IF nv_poltyp = "M64" THEN ASSIGN  n_itext = ""     n_uom1c = "".  
ELSE IF nv_poltyp = "M80" THEN ASSIGN  n_itext = "IN1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M82" THEN ASSIGN  n_itext = "IN1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M83" THEN ASSIGN  n_itext = "IN1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M84" THEN ASSIGN  n_itext = "IN1"  n_uom1c = "SI".
ELSE IF nv_poltyp = "M85" THEN ASSIGN  n_itext = "E01"  n_uom1c = "SI".
ELSE ASSIGN  n_itext = " "  n_uom1c = " ".
/* ------------ INSURED ITEM ------------ */
nv_check = "".

RUN wgw/wgwge130 (INPUT nv_Bchyr,   /*--Wantanee A49-0165--*/
                        nv_Bchno,                            
                        nv_Bchcnt,                             
                        
                        nv_policy,      /*nv_policy */
                        nv_rencnt,      
                        nv_endcnt,      
                        wgenerage.prem, /*nv_prem   */
                        wgenerage.si,   /*nv_si     */
                        n_itext,        /*nv_i_text */
                        n_uom1c,        /*nv_uom1_c */
                        SUBSTRING(nv_poltyp, 2, 2),
                 OUTPUT nv_recid130,    
                 OUTPUT nv_recid132,    
           INPUT-OUTPUT nv_check).      /*nv_check  */
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
FOR EACH wallocate NO-LOCK:
    RUN wgw/wgwge200 (INPUT nv_Bchyr,   /*--Wantanee A49-0165--*/ 
                            nv_Bchno,                             
                            nv_Bchcnt,  
                            nv_policy,        /*nv_policy */
                            nv_rencnt,        
                            nv_endcnt,        
                            wallocate.csftq,  /*nv_csftq  */
                            wallocate.rico,   /*nv_rico   */
                            /*YES,            /*nv_rip2ae */ Comment A64-0380*/
                            wallocate.rip2ae, /*Add A64-0380*/ 
                            wallocate.rip1,   /*nv_rip1   */ /* % com1*/
                            n_cdate,          /*nv_comdat */
                            n_edate,          /*nv_expdat */
                            nv_trndat,        /*nv_trndat */
                            0,                /*nv_c_year*/
                            NO,               /*nv_risiae */
                            wallocate.si,     
                            wallocate.per,    
                            NO,               
                            wallocate.pd,     
                            wallocate.com,    /* com ---> rate com * prem*/
               INPUT-OUTPUT nv_check,         /*nv_check  */
                      /*Add A64-0380*/
                      INPUT wallocate.rip2,      /*comm% rip2*/
                      INPUT wallocate.com2,      /*Comm.2 ric2*/
                      INPUT wallocate.treaty_yr, /*Treaty Year*/
                      INPUT wallocate.rip1ae).  
                      /*End A64-0380*/  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm304 C-Win 
PROCEDURE pd_uwm304 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* ------------ FIRE RISK ------------ */
nv_check = "".
RUN wgw/wgwge304 (INPUT nv_Bchyr,   /*--Wantanee A49-0165--*/
                        nv_Bchno,                            
                        nv_Bchcnt,                             
                        nv_policy,
                        nv_rencnt,
                        nv_endcnt,
                 OUTPUT nv_recid304,
           INPUT-OUTPUT nv_check).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm307 C-Win 
PROCEDURE pd_uwm307 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_check = "".

RUN wgw/wgwge307 (INPUT nv_Bchyr,   /*--Wantanee A49-0165--*/
                        nv_Bchno,                            
                        nv_Bchcnt,

                        nv_policy,
                        nv_rencnt,
                        nv_endcnt,
                        wgenerage.name1,
                        wgenerage.si,
                        wgenerage.prem,
                 OUTPUT nv_recid307,
           INPUT-OUTPUT nv_check).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_xmm225 C-Win 
PROCEDURE pd_xmm225 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER nv_date      AS DATE        NO-UNDO.
DEFINE INPUT  PARAMETER nv_treaty    AS CHARACTER   NO-UNDO.
DEFINE OUTPUT PARAMETER nv_comper    AS DECIMAL FORMAT ">>9.99" INITIAL 0 NO-UNDO.
DEFINE OUTPUT PARAMETER nv_comper2   AS DECIMAL FORMAT ">>9.99" INITIAL 0 NO-UNDO.
DEFINE OUTPUT PARAMETER nv_rip1ae    AS LOGICAL                           NO-UNDO.
DEFINE OUTPUT PARAMETER nv_rip2ae    AS LOGICAL                           NO-UNDO.
DEFINE OUTPUT PARAMETER nv_err       AS CHAR INIT ""                      NO-UNDO.
DEFINE OUTPUT PARAMETER nv_treaty_yr AS CHAR INIT ""                      NO-UNDO.

ASSIGN
    nv_comper    = 0
    nv_comper2   = 0
    nv_rip1ae    = NO
    nv_rip2ae    = NO
    nv_err       = ""
    nv_treaty_yr = "".

FIND FIRST sicsyac.xmm225 USE-INDEX xmm22504 WHERE
     sicsyac.xmm225.comdat <= nv_date AND
     sicsyac.xmm225.terdat >= nv_date AND
     sicsyac.xmm225.treaty = nv_treaty
NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm225 THEN DO:
    ASSIGN
        nv_err    = ""   nv_treaty_yr = ""
        nv_comper = 0    nv_comper2   = 0
        nv_rip1ae = NO   nv_rip2ae    = NO.
        RUN wuw\wuwetr225
          (INPUT  wgenerage.policy , 
                  wgenerage.rencnt , 
                  wgenerage.endcnt ,
                  YEAR(wgenerage.dcomdat) ,
                  wgenerage.dcomdat ,
                  sicsyac.xmm225.treaty ,
           OUTPUT nv_comper   ,
           OUTPUT nv_comper2  ,
           OUTPUT nv_rip1ae   ,
           OUTPUT nv_rip2ae   ,
           OUTPUT nv_err,
           OUTPUT nv_treaty_yr).
    IF nv_err <> "" THEN DO:
        HIDE MESSAGE NO-PAUSE.
        MESSAGE nv_err VIEW-AS ALERT-BOX ERROR.
        NEXT.
    END.
END.
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
ASSIGN
 nv_check  = ""
 nv_insref = "".

RUN wtm/wtmge600 (INPUT-OUTPUT nv_insref,          /*nv_insref*/
                                "",                 /*nv_ntitle */
                                wgenerage.name1,    /*nv_name1*/
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

IF nv_check = "ERROR1" THEN nv_xmm600 = "WARNING: พบข้อมูล Name (XMM600) ของ " + wgenerage.name1. 
IF nv_check = "ERROR2" THEN nv_xmm600 = "WARNING: พบข้อมูลและมีการใช้ที่ Name (XMM600) ของ " + wgenerage.name1.
IF nv_check = "ERROR3" THEN nv_xmm600 = "WARNING: CREATE NEW RECORD Name & Address Master (XMM600) ของ " + wgenerage.name1.
IF nv_check = "ERROR4" THEN nv_xmm600 = "WARNING: พบข้อมูล Name THAI (XTM600) " + nv_insref.
IF nv_check = "ERROR5" THEN nv_xmm600 = "WARNING: พบข้อมูลและมีการใช้ Name THAI (XTM600) " + nv_insref.
IF nv_check = "ERROR6" THEN nv_xmm600 = "WARNING: CREATE NEW RECORD Name THAI (XTM600) " + nv_insref.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

