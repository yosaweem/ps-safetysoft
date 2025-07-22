&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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
wgwimtpis.w :  Import text file from  Tri Petch  to create  new policy Add in table tlt(brstat)  
Program Import Text File    - File detail insured 
Create  by   : Ranu I.  [A66-0252]  date. 07/02/2024
copy program : wgwimtpis.w  
Connect    : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW , STAT */
/*Modify by      : Kridtiya i. A68-0019 ปรับ การแสดงค่า สาขา        */     
/*Modify by      : Kridtiya i. A68-0044 Date. 02/05/2025 Add Drivername 5 Person       */  
/*+++++++++++++++++++++++++++++++++++++++++++++++*/
DEF     SHARED VAR n_User    AS CHAR.  
DEF     SHARED VAR n_Passwd  AS CHAR FORMAT "x(15)".  

DEFINE VAR gv_id       AS CHAR FORMAT "X(10)" NO-UNDO.   
/*DEFINE VAR nv_pwd      AS CHAR NO-UNDO.  */ /*A61-0152*/
DEFINE VAR nv_pwd      AS CHAR FORMAT "X(15)" NO-UNDO.   /*A61-0152*/


DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
DEFINE STREAM  ns2.
DEF VAR nv_row AS INTE.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD ins_ytyp               AS CHAR FORMAT "x(20)"         INIT ""    
    FIELD bus_typ                AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD TASreceived            AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD InsCompany             AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD Insurancerefno         AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD tpis_no                AS CHAR FORMAT "x(11)"         INIT ""     
    FIELD ntitle                 AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD insnam                 AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD NAME2                  AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD cust_type              AS CHAR FORMAT "x(1)"          INIT ""     
    FIELD nDirec                 AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD ICNO                   AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD address                AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD build                  AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mu                     AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD soi                    AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD road                   AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD tambon                 AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD amper                  AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD country                AS CHAR FORMAT "x(50)"         INIT ""     
    FIELD post                   AS CHAR FORMAT "x(50)"         INIT ""     
    FIELD brand                  AS CHAR FORMAT "x(30)"         INIT ""     
    FIELD model                  AS CHAR FORMAT "x(30)"         INIT ""     
    FIELD class                  AS CHAR FORMAT "x(20)"         INIT ""    
    FIELD md_year                AS CHAR FORMAT "x(20)"         INIT ""    
    FIELD Usage                  AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD coulor                 AS CHAR FORMAT "x(30)"         INIT ""     
    FIELD cc                     AS CHAR FORMAT "x(20)"         INIT ""    
    FIELD regis_year             AS CHAR FORMAT "x(20)"         INIT ""    
    FIELD engno                  AS CHAR FORMAT "x(40)"         INIT ""     
    FIELD chasno                 AS CHAR FORMAT "x(25)"         INIT ""     
    FIELD Acc_CV                 AS CHAR FORMAT "x(255)"        INIT ""     
    FIELD Acc_amount             AS CHAR FORMAT "x(100)"        INIT ""    
    FIELD License                AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD regis_CL               AS CHAR FORMAT "x(100)"        INIT ""    
    FIELD campaign               AS CHAR FORMAT "x(100)"        INIT ""    
    FIELD typ_work               AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD si                     AS CHAR FORMAT "X(20)"         INIT ""     
    FIELD pol_comm_date          AS CHAR FORMAT "X(20)"         INIT ""     
    FIELD pol_exp_date           AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD LAST_pol               AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD cover                  AS CHAR FORMAT "x(20)"         INIT ""    
    FIELD pol_netprem            AS CHAR FORMAT "X(15)"         INIT ""     
    FIELD pol_gprem              AS CHAR FORMAT "X(15)"         INIT ""     
    FIELD pol_stamp              AS CHAR FORMAT "X(15)"         INIT ""     
    FIELD pol_vat                AS CHAR FORMAT "X(15)"         INIT ""     
    FIELD pol_wht                AS CHAR FORMAT "X(15)"         INIT ""     
    FIELD com_no                 AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD stkno                  AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD com_comm_date          AS CHAR FORMAT "X(20)"         INIT ""     
    FIELD com_exp_date           AS CHAR FORMAT "X(20)"         INIT ""     
    FIELD com_netprem            AS CHAR FORMAT "x(15)"         INIT ""     
    FIELD com_gprem              AS CHAR FORMAT "x(15)"         INIT ""     
    FIELD com_stamp              AS CHAR FORMAT "x(15)"         INIT ""     
    FIELD com_vat                AS CHAR FORMAT "X(15)"         INIT ""     
    FIELD com_wht                AS CHAR FORMAT "x(15)"         INIT ""     
    FIELD deler                  AS CHAR FORMAT "x(200)"        INIT ""    
    FIELD showroom               AS CHAR FORMAT "x(200)"        INIT ""    
    FIELD typepay                AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD financename            AS CHAR FORMAT "x(200)"        INIT ""    
    FIELD mail_hno               AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mail_build             AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mail_mu                AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mail_soi               AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mail_road              AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mail_tambon            AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mail_amper             AS CHAR FORMAT "x(60)"         INIT ""     
    FIELD mail_country           AS CHAR FORMAT "x(50)"         INIT ""     
    FIELD mail_post              AS CHAR FORMAT "x(50)"         INIT ""     
    FIELD send_date              AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD policy_no              AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD send_data              AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD REMARK1                AS CHAR FORMAT "x(255)"        INIT ""     
    FIELD occup                  AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD regis_no               AS CHAR FORMAT "x(20)"         INIT ""     
    FIELD np_f18line1            AS CHAR FORMAT "x(60)"         INIT "" 
    FIELD np_f18line2            AS CHAR FORMAT "x(60)"         INIT "" 
    FIELD np_f18line3            AS CHAR FORMAT "x(60)"         INIT "" 
    FIELD np_f18line4            AS CHAR FORMAT "x(60)"         INIT "" 
    FIELD np_f18line5            AS CHAR FORMAT "x(60)"         INIT "" 
    FIELD np_f18line6            AS CHAR FORMAT "x(255)"        INIT "" 
    FIELD np_f18line7            AS CHAR FORMAT "x(2)"          INIT "" 
    FIELD np_f18line8            AS CHAR FORMAT "x(50)"         INIT "" 
    FIELD np_f18line9            AS CHAR FORMAT "x(255)"        INIT "" 
    FIELD pol_typ                AS CHAR FORMAT "x(3)"          INIT "" 
    FIELD financename2           AS CHAR FORMAT "x(10)"         INIT ""     
    FIELD branch                 AS CHAR FORMAT "x(10)"         INIT ""     
    FIELD baseprm                AS CHAR FORMAT "x(10)"         INIT "" 
    FIELD delerco                AS CHAR FORMAT "x(10)"         INIT "" 
    FIELD dealer_name2           AS CHAR FORMAT "x(60)"         INIT ""
    FIELD campens                AS CHAR FORMAT "X(50)"         INIT ""
    FIELD producer               AS CHAR FORMAT "X(10)"         INIT ""
    FIELD agent                  AS CHAR FORMAT "X(10)"         INIT ""
    FIELD memotext               AS CHAR FORMAT "X(50)"         INIT ""
    FIELD vatcode                AS CHAR FORMAT "X(10)"         INIT ""
    FIELD name02                 AS CHAR FORMAT "X(50)"         INIT ""
    FIELD bran_name              AS CHAR FORMAT "X(30)"         INIT ""
    FIELD bran_name2             AS CHAR FORMAT "X(15)"         INIT ""
    FIELD Region                 AS CHAR FORMAT "X(20)"         INIT ""
    FIELD ton                    AS CHAR FORMAT "x(5)"          INIT ""  
    FIELD prempa                 AS CHAR FORMAT "x(2)"          INIT ""  
    FIELD garage                 AS CHAR FORMAT "X(25)"         INIT ""  
    FIELD desmodel               AS CHAR FORMAT "x(50)"         INIT ""  
    FIELD claimdi                AS CHAR FORMAT "x(50)"         INIT ""  
    FIELD product                AS CHAR FORMAT "x(50)"         INIT ""  
    FIELD codeocc                AS CHAR FORMAT "x(4)"          INIT ""   
    FIELD codeaddr1              AS CHAR FORMAT "x(2)"          INIT ""   
    FIELD codeaddr2              AS CHAR FORMAT "x(2)"          INIT ""   
    FIELD codeaddr3              AS CHAR FORMAT "x(2)"          INIT ""   
    FIELD campaign_ov            AS CHAR FORMAT "x(30)"         INIT ""   
    FIELD insnamtyp              AS CHAR FORMAT "x(60)"         INIT ""   
    FIELD firstName              AS CHAR FORMAT "x(60)"         INIT ""   
    FIELD lastName               AS CHAR FORMAT "x(60)"         INIT ""   
    FIELD financecd              AS CHAR FORMAT "x(60)"         INIT "" 
    FIELD prvpol                 AS CHAR FORMAT "x(15)"         INIT "" 
    FIELD isp                    AS CHAR FORMAT "x(2)"          INIT "" 
    FIELD ispno                  AS CHAR FORMAT "x(15)"         INIT "" 
    FIELD ispresult              AS CHAR FORMAT "x(50)"         INIT "" 
    FIELD ispdetail              AS CHAR FORMAT "x(255)"        INIT "" 
    FIELD ispacc                 AS CHAR FORMAT "x(255)"        INIT ""
    FIELD err                    AS CHAR FORMAT "x(255)"        INIT ""  
    FIELD Driver1_title          AS CHAR FORMAT "x(60)"         INIT ""  
    FIELD Driver1_name           AS CHAR FORMAT "x(100)"        INIT ""  
    FIELD Driver1_lastname       AS CHAR FORMAT "x(100)"        INIT ""  
    FIELD Driver1_birthdate      AS CHAR FORMAT "x(30)"         INIT ""  
    FIELD Driver1_id_no          AS CHAR FORMAT "x(30)"         INIT ""  
    FIELD Driver1_license_no     AS CHAR FORMAT "x(30)"         INIT ""  
    FIELD Driver1_occupation     AS CHAR FORMAT "x(100)"        INIT ""  
    FIELD Driver2_title          AS CHAR FORMAT "x(60)"         INIT ""    
    FIELD Driver2_name           AS CHAR FORMAT "x(100)"        INIT ""    
    FIELD Driver2_lastname       AS CHAR FORMAT "x(100)"        INIT ""    
    FIELD Driver2_birthdate      AS CHAR FORMAT "x(30)"         INIT ""    
    FIELD Driver2_id_no          AS CHAR FORMAT "x(30)"         INIT ""    
    FIELD Driver2_license_no     AS CHAR FORMAT "x(30)"         INIT ""    
    FIELD Driver2_occupation     AS CHAR FORMAT "x(100)"        INIT ""    
    FIELD Driver3_title          AS CHAR FORMAT "x(60)"         INIT ""   
    FIELD Driver3_name           AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD Driver3_lastname       AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD Driver3_birthday       AS CHAR FORMAT "x(30)"         INIT ""     
    FIELD Driver3_id_no          AS CHAR FORMAT "x(30)"         INIT ""     
    FIELD Driver3_license_no     AS CHAR FORMAT "x(30)"         INIT ""     
    FIELD Driver3_occupation     AS CHAR FORMAT "x(100)"        INIT ""     
    FIELD Driver4_title          AS CHAR FORMAT "x(60)"         INIT ""   
    FIELD Driver4_name           AS CHAR FORMAT "x(100)"        INIT ""   
    FIELD Driver4_lastname       AS CHAR FORMAT "x(100)"        INIT ""   
    FIELD Driver4_birthdate      AS CHAR FORMAT "x(30)"         INIT ""   
    FIELD Driver4_id_no          AS CHAR FORMAT "x(30)"         INIT ""   
    FIELD Driver4_license_no     AS CHAR FORMAT "x(30)"         INIT ""   
    FIELD Driver4_occupation     AS CHAR FORMAT "x(100)"        INIT ""   
    FIELD Driver5_title          AS CHAR FORMAT "x(60)"         INIT ""   
    FIELD Driver5_name           AS CHAR FORMAT "x(100)"        INIT ""   
    FIELD Driver5_lastname       AS CHAR FORMAT "x(100)"        INIT ""   
    FIELD Driver5_birthdate      AS CHAR FORMAT "x(30)"         INIT ""   
    FIELD Driver5_id_no          AS CHAR FORMAT "x(30)"         INIT ""   
    FIELD Driver5_license_no     AS CHAR FORMAT "x(30)"         INIT ""   
    FIELD Driver5_occupation     AS CHAR FORMAT "x(100)"        INIT ""  .
/*---------------------------------------------------------*/

DEF VAR nv_memo1  AS CHAR Format "x(255)" init "".
DEF VAR nv_memo2  AS CHAR Format "x(255)" init "".
DEF VAR nv_memo3  AS CHAR Format "x(255)" init "".
DEF VAR n_benname AS CHAR INIT "" FORMAT "x(50)".
DEF VAR n_model   AS CHAR FORMAT "x(40)".


/*------------------------------ข้อมูลผู้ขับขี่ -------------------------*/
DEF  STREAM nfile.  
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
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
DEF VAR nn_remark1  AS CHAR INIT "".   
DEF VAR nn_remark2  AS CHAR INIT "".   
DEF VAR nn_remark3  AS CHAR INIT "".   
DEF VAR nn_remark4  AS CHAR INIT "".   
DEF VAR nv_len      AS INTE INIT 0.    
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
DEF VAR np_70 AS CHAR FORMAT "x(15)" INIT "".        
DEF VAR np_72 AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_flag AS CHAR FORMAT "x(8)" INIT "".
DEF VAR nv_message AS CHAR FORMAT "x(150)" .
DEF VAR np_garage    AS CHAR FORMAT "x(25)" INIT "" .  /*A66-0084*/

DEFINE VAR  re_class         AS CHAR FORMAT "x(4)"      . 
DEFINE VAR  re_covcod        AS CHAR FORMAT "x(3)"   INIT "" .       /*A61-0152*/
DEFINE VAR  re_si            AS CHAR FORMAT ">>>,>>>,>>9.99-"  .      
DEFINE VAR  re_baseprm       AS DECI FORMAT ">>>,>>>,>>9.99-"  . 
DEFINE VAR  re_expdat        AS CHAR FORMAT "x(10)" INIT "" .        
DEFINE VAR  nv_chkerror      AS CHAR  FORMAT "X(250)".   /*Add by Kridtiya i. A63-0472*/
DEFINE VAR  re_producerexp   AS CHAR . /*A63-00472*/
DEFINE VAR  re_dealerexp     AS CHAR . /*A63-00472*/
DEFINE VAR  re_year          AS CHAR .
DEFINE VAR  re_chassic       AS CHAR .
DEFINE VAR  re_rencnt        AS INTE .
DEFINE VAR  re_model         AS CHAR  FORMAT "X(150)". /**/

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
&Scoped-define INTERNAL-TABLES wdetail

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt wdetail.ins_ytyp wdetail.bus_typ wdetail.tpis_no wdetail.ntitle wdetail.insnam wdetail.NAME2 wdetail.brand wdetail.model wdetail.class wdetail.md_year wdetail.cc wdetail.engno wdetail.chasno   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt   
&Scoped-define SELF-NAME br_imptxt
&Scoped-define QUERY-STRING-br_imptxt FOR EACH wdetail WHERE wdetail.err = ""
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH wdetail WHERE wdetail.err = "" .
&Scoped-define TABLES-IN-QUERY-br_imptxt wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt wdetail


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_imptxt}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_imptxt fi_mail fi_process rs_type ~
fi_loaddat fi_compa fi_filename bu_ok bu_exit bu_file fi_output fi_insp ~
fi_name fi_notdate RECT-1 
&Scoped-Define DISPLAYED-OBJECTS fi_mail fi_process rs_type fi_loaddat ~
fi_compa fi_filename fi_impcnt fi_completecnt fi_output fi_insp fi_name ~
fi_notdate 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 8.5 BY 1
     BGCOLOR 12 FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8.5 BY 1
     BGCOLOR 2 FGCOLOR 0 FONT 6.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 8.17 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_mail AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_notdate AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 13.83 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 57.5 BY .81
     BGCOLOR 32 FONT 1 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "งานป้ายแดง", 1,
"งานต่ออายุ/โอนย้าย/UsedCar", 2
     SIZE 50.5 BY 1
     BGCOLOR 33 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 19.76
     BGCOLOR 34 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _FREEFORM
  QUERY br_imptxt DISPLAY
      wdetail.ins_ytyp   COLUMN-LABEL "Ins. Year type "     FORMAT "x(20)"      
      wdetail.bus_typ    COLUMN-LABEL "Business type "      FORMAT "x(20)"    
      wdetail.tpis_no    COLUMN-LABEL "TPIS Contract No. "  FORMAT "x(20)" 
      wdetail.ntitle     COLUMN-LABEL "Title name "         FORMAT "x(20)"    
      wdetail.insnam     COLUMN-LABEL "First name "         FORMAT "x(50)"   
      wdetail.NAME2      COLUMN-LABEL "Last name "          FORMAT "x(50)" 
      wdetail.brand      COLUMN-LABEL "Brand "              FORMAT "x(20)" 
      wdetail.model      COLUMN-LABEL "Model "              FORMAT "x(30)" 
      wdetail.class      COLUMN-LABEL "Class "              FORMAT "x(5)" 
      wdetail.md_year    COLUMN-LABEL "Year "               FORMAT "x(5)" 
      wdetail.cc         COLUMN-LABEL "CC"                  FORMAT "x(10)" 
      wdetail.engno      COLUMN-LABEL "Engine "             FORMAT "x(30)" 
      wdetail.chasno     COLUMN-LABEL "Chassic no. "        FORMAT "x(35)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 116 BY 10.24
         BGCOLOR 15 FGCOLOR 1  ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_imptxt AT ROW 10.05 COL 3.5 WIDGET-ID 100
     fi_mail AT ROW 3.62 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_process AT ROW 8.86 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     rs_type AT ROW 2.52 COL 34.33 NO-LABEL WIDGET-ID 8
     fi_loaddat AT ROW 1.48 COL 32.33 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.48 COL 66.33 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 5.52 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.91 COL 101.33
     bu_exit AT ROW 7.91 COL 110.67
     bu_file AT ROW 5.48 COL 110.83
     fi_impcnt AT ROW 7.71 COL 32.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 7.71 COL 69 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 6.62 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_insp AT ROW 2.57 COL 99.83 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_name AT ROW 4.57 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     fi_notdate AT ROW 4.57 COL 86.17 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.71 COL 46.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.48 COL 51.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                  E-Mail ผู้แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 4.57 COL 4.83 WIDGET-ID 20
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                              Subject :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 3.57 COL 4.67 WIDGET-ID 22
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "เวลาแจ้งงาน :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 4.57 COL 75.5 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "รายการ" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.71 COL 83.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Inspection Year :" VIEW-AS TEXT
          SIZE 16.5 BY .95 AT ROW 2.57 COL 85.17 WIDGET-ID 18
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "นำเข้าระบบได้  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 7.71 COL 55.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "       ข้อมูลไฟล์โหลดงานต่ออายุ :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6.62 COL 5 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "               ประเภทไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 2.57 COL 4.67 WIDGET-ID 12
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                      แนบไฟล์นำเข้า :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.57 COL 4.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " ข้อมูลแจ้งประกันนำเข้าทั้งหมด  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 7.71 COL 4.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   วันที่ไฟล์แจ้งงาน :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.52 COL 4.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 119.67 BY 19.95
         BGCOLOR 51 .


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
         TITLE              = "Import Text File to open policy (Tri Petch Insurance Service Co., Ltd.)"
         HEIGHT             = 20.05
         WIDTH              = 119.67
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
IF NOT C-Win:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
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
/* BROWSE-TAB br_imptxt 1 fr_main */
ASSIGN 
       br_imptxt:SEPARATOR-FGCOLOR IN FRAME fr_main      = 8.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
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
     _START_FREEFORM
OPEN QUERY br_imptxt FOR EACH wdetail WHERE wdetail.err = "" .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import Text File to open policy (Tri Petch Insurance Service Co., Ltd.) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import Text File to open policy (Tri Petch Insurance Service Co., Ltd.) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
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
    DEF VAR no_add AS CHAR FORMAT "x(8)" .

    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        /*      FILTERS    "Text Documents" "*.txt"    */
        FILTERS    /* "Text Documents"   "*.txt",
        "Data Files (*.*)"     "*.*"*/
        "Text Documents" "*.csv"
        
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_filename  = cvData.
        fi_output = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + "output.csv" .
        DISP fi_filename fi_output WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_daily   =  ""
        nv_reccnt  =  0.

    For each  wdetail:
        DELETE  wdetail.
    END.
    IF rs_type = 1  THEN RUN IMPORT_New.
    ELSE Run  Import_Renew.    /*ไฟล์แจ้งงาน กรมธรรม์*/
    RELEASE brstat.tlt.

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


&Scoped-define SELF-NAME fi_insp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insp C-Win
ON LEAVE OF fi_insp IN FRAME fr_main
DO:
    fi_insp =  INPUT  fi_insp.
    Disp  fi_insp   WITH Frame  fr_main.                 

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


&Scoped-define SELF-NAME fi_mail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_mail C-Win
ON LEAVE OF fi_mail IN FRAME fr_main
DO:
     fi_mail =  INPUT  fi_mail.
    Disp  fi_mail   WITH Frame  fr_main. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name C-Win
ON LEAVE OF fi_name IN FRAME fr_main
DO:
     fi_name =  INPUT  fi_name.
    Disp  fi_name   WITH Frame  fr_main. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdate C-Win
ON LEAVE OF fi_notdate IN FRAME fr_main
DO:
     fi_notdate =  INPUT  fi_notdate.
    Disp  fi_notdate   WITH Frame  fr_main. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdate C-Win
ON VALUE-CHANGED OF fi_notdate IN FRAME fr_main
DO:
     fi_notdate =  INPUT  fi_notdate.
    Disp  fi_notdate   WITH Frame  fr_main. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename .
  Disp  fi_filename with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type.
    DISP rs_type WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwimtpis".
  gv_prog  = "Import Text File to open policy (Tri Petch Insurance Service Co., Ltd.) ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      fi_loaddat  =  today
      fi_compa    = "TPIS" 
      rs_type     = 1 
      fi_insp     = STRING(YEAR(TODAY),"9999").
      
  disp  fi_loaddat  fi_compa rs_type fi_insp with  frame  fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_detail_new C-Win 
PROCEDURE 00-pro_detail_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*FOR EACH wdetail  NO-LOCK.
     ASSIGN 
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' trim(wdetail.ins_ytyp)    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' trim(wdetail.bus_typ )    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' trim(wdetail.TASreceived)    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' trim(wdetail.InsCompany)    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' trim(wdetail.Insurancerefno) '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(wdetail.tpis_no)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' trim(wdetail.ntitle)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' trim(wdetail.insnam)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' trim(wdetail.NAME2 )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' trim(wdetail.cust_type)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' trim(wdetail.nDirec)         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' trim(wdetail.ICNO )         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' trim(wdetail.address)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' trim(wdetail.build)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' trim(wdetail.mu )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' trim(wdetail.soi)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' trim(wdetail.road)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' trim(wdetail.tambon)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' trim(wdetail.amper)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' trim(wdetail.country)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' trim(wdetail.post )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' trim(wdetail.brand)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' trim(wdetail.model)        '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' trim(wdetail.class)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(wdetail.md_year)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' trim(wdetail.usage)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' trim(wdetail.coulor)         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' trim(wdetail.cc)         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' trim(wdetail.regis_year)     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' trim(wdetail.engno)         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' trim(wdetail.chasno)         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' trim(wdetail.Acc_CV)         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' IF wdetail.Acc_CV <> "" THEN trim(STRING(DECI(wdetail.Acc_amount))) ELSE "" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' trim(wdetail.License )         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' trim(wdetail.regis_CL)         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' trim(wdetail.campaign)  /*wdetail.campens*/        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' trim(wdetail.typ_work)         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' trim(wdetail.si)              /*DECI(wdetail.si) FORMAT ">>>>>>>9.99"             */   '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' trim(wdetail.pol_comm_date)   /*DATE(wdetail.pol_comm_date)  FORMAT "99/99/9999"  */    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' trim(wdetail.pol_exp_date)    /*DATE(wdetail.pol_exp_date)   FORMAT "99/99/9999"  */    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' trim(wdetail.prvpol)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' trim(wdetail.cover )            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' /*DECI*/ trim(wdetail.pol_netprem) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' /*DECI*/ trim(wdetail.pol_gprem)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' /*DECI*/ trim(wdetail.pol_stamp)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' /*DECI*/ trim(wdetail.pol_vat)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' /*DECI*/ trim(wdetail.pol_wht)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' trim(wdetail.com_no)            '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' TRIM(wdetail.com_comm_date) /*DATE(wdetail.com_comm_date) FORMAT "99/99/9999" */  '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' trim(wdetail.com_exp_date)  /*DATE(wdetail.com_exp_date)  FORMAT "99/99/9999" */  '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' /*DECI*/ trim(wdetail.com_netprem) '"' SKIP.                                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' /*DECI*/ trim(wdetail.com_gprem)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' /*DECI*/ trim(wdetail.com_stamp)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' /*DECI*/ trim(wdetail.com_vat)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' /*DECI*/ trim(wdetail.com_wht)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' trim(wdetail.deler    )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' trim(wdetail.showroom )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' trim(wdetail.typepay  )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' trim(wdetail.financename)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' trim(wdetail.mail_hno )   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' trim(wdetail.mail_build )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' trim(wdetail.mail_mu  )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' trim(wdetail.mail_soi )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' trim(wdetail.mail_road)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' trim(wdetail.mail_tambon )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' trim(wdetail.mail_amper  )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' trim(wdetail.mail_country)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' trim(wdetail.mail_post)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' trim(wdetail.send_date)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' trim(wdetail.policy   )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' trim(wdetail.send_data)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' trim(wdetail.REMARK1  )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "" /*wdetail.occup */     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' trim(wdetail.model)             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' ""                        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "CLAIMDI"             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' trim(wdetail.product)           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' trim(wdetail.np_f18line1)       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' trim(wdetail.np_f18line2)       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' trim(wdetail.np_f18line3)       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' trim(wdetail.producer)          '"' SKIP.  /*Producer       */ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' trim(wdetail.agent )          '"' SKIP.  /*Agent          */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' trim(wdetail.branch)          '"' SKIP.  /*Branch         */
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' trim(wdetail.campens )          '"' SKIP.  /*Campaign TMSTH */                          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' trim(wdetail.err)          '"' SKIP. /*Error          */ 
 End.  /*end for*/                                                                                            
 nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_detail_Renew C-Win 
PROCEDURE 00-pro_detail_Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_model AS CHAR FORMAT "x(50)" INIT "" .
 FOR EACH wdetail  NO-LOCK.
     ASSIGN 
         nv_model = ""
         nv_model = IF trim(wdetail.brand) <> "ISUZU" THEN  trim(wdetail.desmodel)  ELSE trim(wdetail.model) 
         nv_cnt   =  nv_cnt  + 1 
         nv_row   =  nv_row + 1.

    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' trim(wdetail.ins_ytyp)    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' trim(wdetail.bus_typ )    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' trim(wdetail.TASreceived)    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' trim(wdetail.InsCompany)    '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' trim(wdetail.Insurancerefno) '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(wdetail.tpis_no)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' trim(wdetail.ntitle )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' trim(wdetail.insnam )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' trim(wdetail.NAME2  )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' trim(wdetail.cust_type)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' trim(wdetail.nDirec)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' trim(wdetail.ICNO)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' trim(wdetail.address)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' trim(wdetail.build )      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' trim(wdetail.mu  )      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' trim(wdetail.soi )      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' trim(wdetail.road)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' trim(wdetail.tambon)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' trim(wdetail.amper )      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' trim(wdetail.country)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' trim(wdetail.post )      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' trim(wdetail.brand)      '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' nv_model    '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' trim(wdetail.class  )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(wdetail.md_year)        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' trim(wdetail.usage  )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' trim(wdetail.coulor )        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' trim(wdetail.cc     )        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' trim(wdetail.regis_year)     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' trim(wdetail.engno )         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' trim(wdetail.chasno)         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' trim(wdetail.Acc_CV)         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' IF wdetail.Acc_CV <> "" THEN trim(STRING(DECI(wdetail.Acc_amount))) ELSE "" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' trim(wdetail.License )        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' trim(wdetail.regis_CL)        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' trim(wdetail.campens )       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' trim(wdetail.typ_work)        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' trim(wdetail.si)             /*DECI(wdetail.si) FORMAT ">>>>>>>9.99"             */   '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' trim(wdetail.pol_comm_date)  /*DATE(wdetail.pol_comm_date)  FORMAT "99/99/9999"  */    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' trim(wdetail.pol_exp_date)   /*DATE(wdetail.pol_exp_date)   FORMAT "99/99/9999"  */    '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' trim(wdetail.prvpol)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' trim(wdetail.Branch)            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' trim(wdetail.cover )            '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' trim(wdetail.pol_netprem)   /*DECI(wdetail.pol_netprem)*/ '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' trim(wdetail.pol_gprem)     /*DECI(wdetail.pol_gprem)  */ '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' trim(wdetail.pol_stamp)     /*DECI(wdetail.pol_stamp)  */ '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' trim(wdetail.pol_vat)       /*DECI(wdetail.pol_vat)    */ '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' trim(wdetail.pol_wht)       /*DECI(wdetail.pol_wht)    */ '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' trim(wdetail.com_no)            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "" /*wdetail.docno*/            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' trim(wdetail.stkno) /*FORMAT "x(35)" */  '"' SKIP.                               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' TRIM(wdetail.com_comm_date) /*DATE(wdetail.com_comm_date) FORMAT "99/99/9999" */  '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' TRIM(wdetail.com_exp_date)  /*DATE(wdetail.com_exp_date)  FORMAT "99/99/9999" */  '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' /*DECI*/ trim(wdetail.com_netprem) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' /*DECI*/ trim(wdetail.com_gprem)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' /*DECI*/ trim(wdetail.com_stamp)   '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' /*DECI*/ trim(wdetail.com_vat)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' /*DECI*/ trim(wdetail.com_wht)     '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' trim(wdetail.deler    )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' trim(wdetail.showroom )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' trim(wdetail.typepay  )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' trim(wdetail.financename )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' trim(wdetail.mail_hno )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' trim(wdetail.mail_build )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' trim(wdetail.mail_mu ) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' trim(wdetail.mail_soi) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' trim(wdetail.mail_road) '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' trim(wdetail.mail_tambon)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' trim(wdetail.mail_amper )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' trim(wdetail.mail_country)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' trim(wdetail.mail_post)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' trim(wdetail.send_date)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' trim(wdetail.policy   )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' trim(wdetail.send_data)      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' trim(wdetail.REMARK1  )      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "" /*wdetail.occup*/      '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' trim(wdetail.regis_no)          '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' trim(wdetail.np_f18line1)       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' trim(wdetail.np_f18line2)       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' trim(wdetail.np_f18line3)       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' trim(wdetail.np_f18line4)       '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' trim(wdetail.np_f18line5)       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' trim(wdetail.np_f18line7)       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' trim(wdetail.np_f18line8)       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' trim(wdetail.np_f18line9)       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' trim(wdetail.isp  )             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' trim(wdetail.ispno)             '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' trim(wdetail.ispresult)         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' trim(wdetail.ispdetail)         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' trim(wdetail.ispacc   )         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' trim(wdetail.producer )         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' trim(wdetail.product  )         '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' trim(wdetail.np_f18line6)       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"' trim(wdetail.err)               '"' SKIP. 
 
 End.  /*end for*/                                                                                            
 nv_row  =  nv_row  + 1.  
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_head_New C-Win 
PROCEDURE 00-pro_head_New :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*****************Header file Excel***********************************/
If substr(fi_output,length(fi_output) - 3,4) <> ".slk" THEN fi_output  =  Trim(fi_output) + ".slk"  .
    ASSIGN nv_cnt  =  0
           nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output).
 nv_row  =  nv_row + 1.
 PUT STREAM ns2 "ID;PND" SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Ins. Year type"    '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Business type"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "TAS received by"   '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Ins company "      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Insurance ref no." '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "TPIS Contract No." '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Title name "       '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "customer name"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "customer lastname "'"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "Customer type"     '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Director Name"     '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "ID number"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "House no."         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Building "         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Village name/no."  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "Soi"           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "Road "         '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Sub-district"  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "District"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Province"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Postcode"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Brand"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Car model"    '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Insurance Code"'"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Model Year"    '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Usage Type"    '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Colour "       '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Car Weight"    '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Year "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Engine No."    '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Chassis No."   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Accessories (for CV)"   '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Accessories amount"     '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "License No."            '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Registered Car License" '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Campaign"               '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Type of work "          '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "Insurance amount  "     '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Insurance Date (Voluntary)" '"' SKIP.                                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Expiry Date (Voluntary)   " '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Last Policy No.(Voluntary)" '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Insurance Type            " '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Net premium (Voluntary)   " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Gross premium (Voluntary) " '"' SKIP.                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Stamp "         '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "VAT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "WHT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "Compulsory No." '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Insurance Date (Compulsory)" '"' SKIP.    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "Expiry Date ( Compulsory)  " '"' SKIP.      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Net premium (Compulsory)   " '"' SKIP.      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "Gross premium (Compulsory) " '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Stamp   " '"' SKIP.                                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "VAT     " '"' SKIP.                                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "WHT     " '"' SKIP.                                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Dealer  " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "Showroom   "   '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "Payment Type " '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Beneficiery  " '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Mailing House no." '"' SKIP.                                          
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Mailing  Building" '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Mailing  Village name/no. "  '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Mailing  Soi  "              '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "Mailing  Road "              '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Mailing  Sub-district"       '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Mailing  District "          '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Mailing Province  "          '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Mailing Postcode  "          '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Policy no. to customer date" '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "New policy no"  '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Insurer Stamp Date "  '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Remark"  '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "Occupation code"      '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Car Model     "       '"' SKIP.                                  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' " "                    '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Promo "               '"' skip.                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Product"              '"' skip. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "f18line1"             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "f18line2"             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "f18line3"             '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "Producer"             '"' SKIP.                                  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "Agent "               '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "Branch "              '"' skip.                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "Campaign TMSTH"       '"' skip.                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "Error"       '"' skip. 
 RUN pro_detail_new.
 
 /***End Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-pro_head_Renew C-Win 
PROCEDURE 00-pro_head_Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*****************Header file Excel***********************************/
If substr(fi_output,length(fi_output) - 3,4) <> ".slk" THEN fi_output  =  Trim(fi_output) + ".slk"  .
    ASSIGN nv_cnt  =  0
           nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_output).
 nv_row  =  nv_row + 1.
 PUT STREAM ns2 "ID;PND" SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Ins. Year type"    '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "Business type"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "TAS received by"   '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "Ins company "      '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "Insurance ref no." '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "TPIS Contract No." '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "Title name "       '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "customer name"     '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "customer lastname "'"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "Customer type"     '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "Director Name"     '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "ID number"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "House no."         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "Building "         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "Village name/no."  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "Soi"           '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "Road "         '"' SKIP.                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "Sub-district"  '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "District"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "Province"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "Postcode"      '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "Brand"         '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "Car model "    '"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "Insurance Code"'"' SKIP.                     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "Model Year"    '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "Usage Type"    '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "Colour "       '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "Car Weight"    '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "Year      "    '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "Engine No."    '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "Chassis No."   '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "Accessories (for CV)"   '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "Accessories amount"     '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "License No."            '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "Registered Car License" '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "Campaign"               '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "Type of work "          '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "Insurance amount  "     '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "Insurance Date (Voluntary)" '"' SKIP.                                                
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "Expiry Date (Voluntary)   " '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "Last Policy No.(Voluntary)" '"' SKIP.                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "Branch             "        '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "Insurance Type            " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "Net premium (Voluntary)   " '"' SKIP.                                         
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "Gross premium (Voluntary) " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "Stamp "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "VAT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "WHT   "         '"' SKIP.                                                   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "Compulsory No." '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "เลขใบแจ้งหนี้." '"' SKIP.        /**Add By Nontamas H. [A62-0329] Date 08/07/2019****/
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "Sticker No.   " '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "Insurance Date (Compulsory)" '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "Expiry Date ( Compulsory)  " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "Net premium (Compulsory)   " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "Gross premium (Compulsory) " '"' SKIP.                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "Stamp   " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "VAT     " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "WHT     " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "Dealer  " '"' SKIP.                                                 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "Showroom   "   '"' SKIP.                                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "Payment Type " '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "Beneficiery  " '"' SKIP.                                            
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "Mailing House no." '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "Mailing  Building" '"' SKIP.                                        
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "Mailing  Village name/no. "  '"' SKIP.                               
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "Mailing  Soi  "              '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "Mailing  Road "              '"' SKIP.                                           
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "Mailing  Sub-district"       '"' SKIP.                                    
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "Mailing  District "          '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "Mailing Province  "          '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "Mailing Postcode  "          '"' SKIP.                                       
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "Policy no. to customer date" '"' SKIP.                              
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "New policy no      "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "Insurer Stamp Date "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "Remark             "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "Occupation code"         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "Register NO.   "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "f18line1       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K" '"' "f18line2       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K" '"' "f18line3       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K" '"' "f18line4       "         '"' SKIP.                                      
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K" '"' "f18line5       "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K" '"' "f18line6       "         '"' SKIP.   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K" '"' "f18line7       "         '"' SKIP.   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K" '"' "f18line8       "         '"' SKIP.   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K" '"' "f18line9       "         '"' SKIP.   
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K" '"' "Inspection     "         '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K" '"' "ISP No.        "         '"' SKIP.     
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K" '"' "ISP Detail     "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K" '"' "ISP Damge      "         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K" '"' "ISP Accessories"         '"' SKIP. 
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K" '"' "Producer       "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K" '"' "Product        "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K" '"' "Data Check     "         '"' SKIP.  
 PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K" '"' "Error          "         '"' SKIP.  
 RUN pro_detail_renew.
 
 /***End Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
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
DEF VAR nv_des AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_cc  AS CHAR INIT "" .

LOOP_wdetail:
FOR EACH wdetail .
    ASSIGN   nv_des   = ""    nv_cc      = ""
             nv_flag  = ""    nv_message = "" .

    IF wdetail.tpis_no = "" THEN  DELETE wdetail.
    ELSE DO:
        nv_reccnt = nv_reccnt + 1.

        ASSIGN wdetail.np_f18line1 = trim(fi_mail) 
               wdetail.np_f18line2 = trim(fi_name) 
               wdetail.np_f18line3 = trim(string(fi_loaddat,"99/99/9999")) + " " + trim(fi_notdate)
            wdetail.ntitle = REPLACE(wdetail.ntitle,"บจก.","บริษัท")
            wdetail.ntitle = REPLACE(wdetail.ntitle,"บ.","บริษัท").
        RUN proc_chkaddr.
        
        /*------  หาแคมเปญ ------------*/
        IF rs_type = 2 THEN DO: 
            IF wdetail.producer = "B3M0034" THEN DO:
                IF index(wdetail.deler,"Refinance") <> 0 THEN  ASSIGN  nv_flag = "RF" .
                ELSE if index(wdetail.deler,"UsedCar") <> 0  THEN ASSIGN nv_flag = "UC" .
                ELSE if index(wdetail.deler,"Used Car") <> 0 THEN ASSIGN nv_flag = "UC" .
            END.
            ELSE IF INDEX(wdetail.last_pol,"Dummy") <> 0 THEN  ASSIGN nv_flag = "TF" .
            ELSE IF TRIM(wdetail.last_pol) = ""  THEN  ASSIGN nv_flag = "TF" .
            ELSE ASSIGN  nv_flag = "RW" .
            RUN proc_inspection.

            IF TRIM(wdetail.License) = "" THEN DO:
               ASSIGN  wdetail.License = IF LENGTH(wdetail.chasno)  > 8 THEN "/" + trim(substr(trim(wdetail.chasno),LENGTH(trim(wdetail.chasno)) - 8 )) 
                                         ELSE "/" + trim(wdetail.chasno)  .
            END.
            IF index(wdetail.License,"-") <> 0 THEN ASSIGN wdetail.License = TRIM(REPLACE(wdetail.License,"-"," ")) .

            IF nv_flag = "UC" THEN DO:
               ASSIGN  nv_des = TRIM(wdetail.desmodel) .
               IF INDEX(nv_des," ") <> 0 THEN DO:  
                   ASSIGN nv_cc =  SUBSTR(nv_des,R-INDEX(nv_des," ")) 
                          nv_des = trim(SUBSTR(nv_des,1,R-INDEX(nv_des," "))).
               
                  IF index("0123456789",nv_cc) <> 0 THEN DO: 
                      ASSIGN nv_cc = nv_cc .
                  END.
                  ELSE ASSIGN nv_cc = SUBSTR(nv_des,R-INDEX(nv_des," ")).
               END.
               ASSIGN wdetail.cc = IF DECI(nv_cc) <> 0 THEN STRING(DECI(nv_cc) * 1000 ) ELSE nv_cc  .
            END.
        END.
        ELSE IF rs_type = 1  THEN DO: 
            RUN proc_chkproduct.
            nv_flag = "NW".
        END.
        ELSE nv_flag = "".

        IF trim(wdetail.branch) = "-" OR trim(wdetail.branch) = " " THEN DO: 
            ASSIGN  wdetail.branch = " "
                    wdetail.err = wdetail.err + " สาขาเป็นค่าว่าง กรุณาตรวจสอบข้อมูล" .
        END.
       
        wdetail.icno = TRIM(wdetail.icno) .  
        IF trim(wdetail.cust_type) = "J"  AND LENGTH(wdetail.icno) < 13 THEN ASSIGN wdetail.icno = "0" + TRIM(wdetail.icno) . 

        ASSIGN nv_CheckLog  = "no".   /*Check susspect no ไม่ติด yes ติด*/
        RUN proc_susspect ( INPUT trim(wdetail.insnam)
                           ,INPUT trim(wdetail.NAME2) 
                           ,INPUT trim(wdetail.License) + " " + trim(wdetail.regis_CL)   
                           ,INPUT trim(wdetail.chasno)
                           ,INPUT-OUTPUT nv_message).
        IF nv_message <> "" THEN ASSIGN wdetail.err = TRIM(wdetail.err + "|" + nv_message) .
         
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
            brstat.tlt.cha_no       = trim(wdetail.chasno)  AND
            brstat.tlt.eng_no       = TRIM(wdetail.engno)   AND 
            brstat.tlt.nor_noti_tlt = TRIM(wdetail.tpis_no) AND 
            brstat.tlt.genusr       = trim(fi_compa)               NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO:  
            CREATE brstat.tlt.
            nv_completecnt  =  nv_completecnt + 1.
            ASSIGN                                                 
               brstat.tlt.entdat          = TODAY
               brstat.tlt.enttim          = STRING(TIME,"HH:MM:SS") 
               brstat.tlt.trndat          = fi_loaddat
               /*brstat.tlt.ndate1          = TODAY */ 
               /*brstat.tlt.trntime         = STRING(TIME,"HH:MM:SS") */
               brstat.tlt.genusr          = TRIM(fi_compa)
               brstat.tlt.usrid           = USERID(LDBNAME(1)) 
               /*brstat.tlt.usrsent         = USERID(LDBNAME(1))*/
               brstat.tlt.releas          = "NO"
              
               brstat.tlt.flag            = nv_flag
               brstat.tlt.ins_typ         = trim(wdetail.ins_ytyp)              
               brstat.tlt.rec_addr4       = trim(wdetail.bus_typ)          
               brstat.tlt.rec_addr3       = trim(wdetail.TASreceived)          
               brstat.tlt.subins          = trim(wdetail.InsCompany)          
               brstat.tlt.nor_usr_ins     = trim(wdetail.Insurancerefno)        
               brstat.tlt.nor_noti_tlt    = trim(wdetail.tpis_no )          
               brstat.tlt.ins_title       = trim(wdetail.ntitle)          
               brstat.tlt.ins_firstname   = trim(wdetail.insnam)          
               brstat.tlt.ins_lastname    = trim(wdetail.NAME2 )          
               brstat.tlt.id_typ          = trim(wdetail.cust_type)          
               brstat.tlt.nor_usr_tlt     = trim(wdetail.nDirec  )          
               brstat.tlt.ins_icno        = trim(wdetail.ICNO    )          
               brstat.tlt.hrg_no          = trim(wdetail.address )          
               brstat.tlt.hrg_moo         = trim(wdetail.build   )          
               brstat.tlt.hrg_vill        = trim(wdetail.mu      )          
               brstat.tlt.hrg_soi         = trim(wdetail.soi     )          
               brstat.tlt.hrg_street      = trim(wdetail.road    )          
               brstat.tlt.hrg_subdistrict = trim(wdetail.tambon  )          
               brstat.tlt.hrg_district    = trim(wdetail.amper   )          
               brstat.tlt.hrg_prov        = trim(wdetail.country )          
               brstat.tlt.hrg_postcd      = trim(wdetail.post    )          
               brstat.tlt.brand           = trim(wdetail.brand   )          
               brstat.tlt.model           = trim(wdetail.model   )          
               brstat.tlt.pack            = trim(wdetail.class   )          
               brstat.tlt.old_eng         = trim(wdetail.md_year )          
               brstat.tlt.vehuse          = trim(wdetail.Usage   )          
               brstat.tlt.colordes        = trim(wdetail.coulor  )          
               brstat.tlt.cc_weight       = deci(wdetail.cc)                    
               brstat.tlt.old_cha         = IF trim(wdetail.regis_year) <> "" THEN trim(wdetail.regis_year) 
                                            ELSE IF trim(wdetail.pol_comm_date) <> "" THEN  STRING(YEAR(date(wdetail.pol_comm_date)),"9999") 
                                            ELSE STRING(YEAR(date(wdetail.com_comm_date)),"9999")
               brstat.tlt.eng_no          = trim(wdetail.engno     )            
               brstat.tlt.cha_no          = trim(wdetail.chasno    )            
               brstat.tlt.filler1         = trim(wdetail.Acc_CV    )            
               brstat.tlt.filler2         = trim(wdetail.Acc_amount)            
               brstat.tlt.lince1          = trim(wdetail.License )            
               brstat.tlt.lince2          = trim(wdetail.regis_CL)
               brstat.tlt.packnme         = trim(wdetail.campaign)   /*campaign TPIS*/
               /*brstat.tlt.campaign        = TRIM(wdetail.campens)  */  /* campaign tmsth */           
               brstat.tlt.safe1           = trim(wdetail.typ_work)            
               brstat.tlt.safe2           = trim(wdetail.garage)           
               brstat.tlt.safe3           = trim(wdetail.desmodel)              
               brstat.tlt.nor_coamt       = deci(wdetail.si)                    
               brstat.tlt.gendat          = date(wdetail.pol_comm_date)         
               brstat.tlt.expodat         = date(wdetail.pol_exp_date)          
               brstat.tlt.note1           = trim(wdetail.last_pol)
               brstat.tlt.nor_noti_ins    = TRIM(wdetail.prvpol) /* กรมธรรม์เดิม*/
               brstat.tlt.covcod          = trim(wdetail.cover)                 
               brstat.tlt.nor_grprm       = deci(wdetail.pol_netprem)           
               brstat.tlt.ndeci1          = deci(wdetail.pol_gprem  )           
               brstat.tlt.ndeci2          = deci(wdetail.pol_stamp  )           
               brstat.tlt.ndeci3          = deci(wdetail.pol_vat    )           
               brstat.tlt.ndeci4          = deci(wdetail.pol_wht    )           
               brstat.tlt.comp_pol        = ""  /*trim(wdetail.com_no)*/
               brstat.tlt.comp_sck        = TRIM(wdetail.com_no)
               brstat.tlt.nor_effdat      = date(wdetail.com_comm_date)         
               brstat.tlt.comp_effdat     = date(wdetail.com_exp_date)          
               brstat.tlt.comp_coamt      = deci(wdetail.com_netprem)           
               brstat.tlt.comp_grprm      = deci(wdetail.com_gprem)             
               brstat.tlt.rstp            = deci(wdetail.com_stamp)             
               brstat.tlt.rtax            = deci(wdetail.com_vat)               
               brstat.tlt.tax_coporate    = DECI(wdetail.com_wht)               
               brstat.tlt.note2           = trim(wdetail.deler )          
               brstat.tlt.note3           = trim(wdetail.showroom )          
               brstat.tlt.note4           = trim(wdetail.typepay)          
               brstat.tlt.ben83           = trim(wdetail.financename)          
               brstat.tlt.ins_addr1       = "MH:" + trim(wdetail.mail_hno) + " " +
                                            "MB:" + trim(wdetail.mail_build) + " " +     
                                            "MM:" + trim(wdetail.mail_mu )         
               brstat.tlt.ins_addr2       = "MS:" + trim(wdetail.mail_soi) + " " +
                                            "MR:" + trim(wdetail.mail_road)          
               brstat.tlt.ins_addr3       = trim(wdetail.mail_tambon)          
               brstat.tlt.ins_addr4       = trim(wdetail.mail_amper)          
               brstat.tlt.ins_addr5       = trim(wdetail.mail_country)          
               brstat.tlt.lince3          = trim(wdetail.mail_post)          
               brstat.tlt.datesent        = IF TRIM(wdetail.send_date) <> "" THEN DATE(wdetail.send_date) ELSE ?          
               brstat.tlt.policy          = "" /*trim(wdetail.policy_no)*/          
               brstat.tlt.ndate2          = IF trim(wdetail.send_data) <> "" THEN DATE(wdetail.send_data) ELSE ?          
               brstat.tlt.note5           = trim(wdetail.REMARK1  )          
               brstat.tlt.ins_occ         = trim(wdetail.occup ) 

               brstat.tlt.acno1           = trim(wdetail.producer ) 
               brstat.tlt.agent           = IF trim(wdetail.agent) <> "" THEN trim(wdetail.agent) ELSE "B3M0018" 
               brstat.tlt.ins_brins       = trim(wdetail.branch)  
               brstat.tlt.product         = trim(wdetail.product) 
               brstat.tlt.dealer          = trim(wdetail.delerco)
               brstat.tlt.finint          = TRIM(wdetail.vatcode)
               brstat.tlt.hclfg           = IF wdetail.err = "" THEN "N" ELSE "Y"      /*สถานะติดปัญหา : Y, N*/
               brstat.tlt.note6           = ""                                         /*comment             */
               /*brstat.tlt.note7           = IF TRIM(wdetail.producer) = "B3M0034" THEN "Y" ELSE IF trim(wdetail.isp) <> "" THEN "Y" ELSE "N" */                 /*การตรวจสภาพ : Y , N */
               brstat.tlt.note8           = TRIM(wdetail.ispno)         /*เลขตรวจสภาพ         */
               brstat.tlt.note9           = trim(wdetail.ispresult)     /*ข้อมูลตรวจสภาพ      */
               brstat.tlt.note10          = trim(wdetail.ispdetail)     /* ข้อมูลความเสียหาย */
               brstat.tlt.note11          = TRIM(wdetail.ispacc)        /* ข้อมูลอุปกรณ์เสริม */
               brstat.tlt.note12          = trim(wdetail.np_f18line1)
               brstat.tlt.note13          = trim(wdetail.np_f18line2)
               brstat.tlt.note14          = trim(fi_notdate)  /* เวลาแจ้งงาน */
               brstat.tlt.note15          = trim(wdetail.np_f18line6) + "/" + trim(wdetail.err)          /*error               */    
               brstat.tlt.note16          = ""   /* EMS No.*/                                            
               brstat.tlt.note17          = ""   /* Tran dat */
               brstat.tlt.note18          = ""   /* Release dat */
               brstat.tlt.note19          = trim(wdetail.np_f18line5)    /* type swit ,first , renew ,refinance*/
               brstat.tlt.dri_title1      = trim(wdetail.Driver1_title)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_fname1      = trim(wdetail.Driver1_name)          /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lname1      = trim(wdetail.Driver1_lastname)      /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_birth1      = trim(wdetail.Driver1_birthdate)     /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_no1         = trim(wdetail.Driver1_id_no)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lic1        = trim(wdetail.Driver1_license_no)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dir_occ1        = trim(wdetail.Driver1_occupation)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_title2      = trim(wdetail.Driver2_title)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_fname2      = trim(wdetail.Driver2_name)          /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lname2      = trim(wdetail.Driver2_lastname)      /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_birth2      = trim(wdetail.Driver2_birthdate)     /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_no2         = trim(wdetail.Driver2_id_no)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lic2        = trim(wdetail.Driver2_license_no)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_occ2        = trim(wdetail.Driver2_occupation)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_title3      = trim(wdetail.Driver3_title)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_fname3      = trim(wdetail.Driver3_name)          /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lname3      = trim(wdetail.Driver3_lastname)      /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_birth3      = trim(wdetail.Driver3_birthday)      /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_no3         = trim(wdetail.Driver3_id_no)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lic3        = trim(wdetail.Driver3_license_no)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dir_occ3        = trim(wdetail.Driver3_occupation)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_title4      = trim(wdetail.Driver4_title)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_fname4      = trim(wdetail.Driver4_name)          /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lname4      = trim(wdetail.Driver4_lastname)      /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_birth4      = trim(wdetail.Driver4_birthdate)     /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_no4         = trim(wdetail.Driver4_id_no)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lic4        = trim(wdetail.Driver4_license_no)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_occ4        = trim(wdetail.Driver4_occupation)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_title5      = trim(wdetail.Driver5_title)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_fname5      = trim(wdetail.Driver5_name)          /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lname5      = trim(wdetail.Driver5_lastname)      /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_birth5      = trim(wdetail.Driver5_birthdate)     /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_no5         = trim(wdetail.Driver5_id_no)         /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_lic5        = trim(wdetail.Driver5_license_no)    /*add by kridtiyai. A68-0044*/
               brstat.tlt.dri_occ5        = trim(wdetail.Driver5_occupation).   /*add by kridtiyai. A68-0044*/
                   
          ASSIGN wdetail.regis_year = brstat.tlt.old_cha .

          IF TRIM(wdetail.producer) = "A000324" THEN DO: 
            IF index(wdetail.err,"กรมธรรม์ขาดต่ออายุ") <> 0 THEN ASSIGN  brstat.tlt.note7 = "Y" .
            ELSE IF trim(wdetail.prvpol) = "" AND INDEX(wdetail.class,"110") = 0 THEN ASSIGN  brstat.tlt.note7 = "Y" . 
            ELSE ASSIGN  brstat.tlt.note7 = "N" . 
          END.
          ELSE IF TRIM(wdetail.producer) = "B3M0034" THEN assign brstat.tlt.note7 = "Y" .
          ELSE IF TRIM(wdetail.producer) = "B3M0031" THEN assign brstat.tlt.note7 = "N" . 
          ELSE IF TRIM(wdetail.producer) = "B3M0018" THEN assign brstat.tlt.note7 = "N" .
          ELSE IF TRIM(wdetail.producer) = "A0M2001" THEN assign brstat.tlt.note7 = "N" .
          ELSE IF trim(wdetail.ispno) <> "" THEN ASSIGN brstat.tlt.note7 = "Y" . 
          ELSE ASSIGN brstat.tlt.note7 = "N" .                  /*การตรวจสภาพ : Y , N */
          ASSIGN wdetail.isp  = brstat.tlt.note7 .
        END.
        ELSE DO: 
            nv_completecnt  =  nv_completecnt + 1.
            RUN Create_tlt2.
        END.
    END. /*Else */
END. /*wdetail*/

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
DO:  
     ASSIGN                                                 
      /*brstat.tlt.entdat          = TODAY
      brstat.tlt.enttim          = STRING(TIME,"HH:MM:SS") */
      brstat.tlt.trndat          = fi_loaddat
      brstat.tlt.ndate1          = TODAY  
      brstat.tlt.trntime         = STRING(TIME,"HH:MM:SS") 
      brstat.tlt.genusr          = TRIM(fi_compa)
      /*brstat.tlt.usrid           = USERID(LDBNAME(1)) */
      brstat.tlt.usrsent         = USERID(LDBNAME(1))
      brstat.tlt.releas          = "NO"

      brstat.tlt.flag            = nv_flag
      brstat.tlt.ins_typ         = trim(wdetail.ins_ytyp)              
      brstat.tlt.rec_addr4       = trim(wdetail.bus_typ)          
      brstat.tlt.rec_addr3       = trim(wdetail.TASreceived)          
      brstat.tlt.subins          = trim(wdetail.InsCompany)          
      brstat.tlt.nor_usr_ins     = trim(wdetail.Insurancerefno)        
      brstat.tlt.nor_noti_tlt    = trim(wdetail.tpis_no )          
      brstat.tlt.ins_title       = trim(wdetail.ntitle)          
      brstat.tlt.ins_firstname   = trim(wdetail.insnam)          
      brstat.tlt.ins_lastname    = trim(wdetail.NAME2 )          
      brstat.tlt.id_typ          = trim(wdetail.cust_type)          
      brstat.tlt.nor_usr_tlt     = trim(wdetail.nDirec  )          
      brstat.tlt.ins_icno        = trim(wdetail.ICNO    )          
      brstat.tlt.hrg_no          = trim(wdetail.address )          
      brstat.tlt.hrg_moo         = trim(wdetail.build   )          
      brstat.tlt.hrg_vill        = trim(wdetail.mu      )          
      brstat.tlt.hrg_soi         = trim(wdetail.soi     )          
      brstat.tlt.hrg_street      = trim(wdetail.road    )          
      brstat.tlt.hrg_subdistrict = trim(wdetail.tambon  )          
      brstat.tlt.hrg_district    = trim(wdetail.amper   )          
      brstat.tlt.hrg_prov        = trim(wdetail.country )          
      brstat.tlt.hrg_postcd      = trim(wdetail.post    )          
      brstat.tlt.brand           = trim(wdetail.brand   )          
      brstat.tlt.model           = trim(wdetail.model   )          
      brstat.tlt.pack            = trim(wdetail.class   )          
      brstat.tlt.old_eng         = trim(wdetail.md_year )          
      brstat.tlt.vehuse          = trim(wdetail.Usage   )          
      brstat.tlt.colordes        = trim(wdetail.coulor  )          
      brstat.tlt.cc_weight       = deci(wdetail.cc)                    
      brstat.tlt.old_cha         = IF trim(wdetail.regis_year) <> "" THEN trim(wdetail.regis_year) 
                                   ELSE IF trim(wdetail.pol_comm_date) <> "" THEN  STRING(YEAR(date(wdetail.pol_comm_date)),"9999") 
                                   ELSE STRING(YEAR(date(wdetail.com_comm_date)),"9999")            
      brstat.tlt.eng_no          = trim(wdetail.engno     )            
      brstat.tlt.cha_no          = trim(wdetail.chasno    )            
      brstat.tlt.filler1         = trim(wdetail.Acc_CV    )            
      brstat.tlt.filler2         = trim(wdetail.Acc_amount)            
      brstat.tlt.lince1          = trim(wdetail.License )            
      brstat.tlt.lince2          = trim(wdetail.regis_CL)
      brstat.tlt.packnme         = trim(wdetail.campaign)   /*campaign TPIS*/
      brstat.tlt.campaign        = TRIM(wdetail.campens)    /* campaign tmsth */           
      brstat.tlt.safe1           = trim(wdetail.typ_work)            
      brstat.tlt.safe2           = trim(wdetail.garage  )           
      brstat.tlt.safe3           = trim(wdetail.desmodel)              
      brstat.tlt.nor_coamt       = deci(wdetail.si)                    
      brstat.tlt.gendat          = date(wdetail.pol_comm_date)         
      brstat.tlt.expodat         = date(wdetail.pol_exp_date)          
      brstat.tlt.note1           = trim(wdetail.last_pol)
      brstat.tlt.nor_noti_ins    = TRIM(wdetail.prvpol) /* กรมธรรม์เดิม*/
      brstat.tlt.covcod          = trim(wdetail.cover)                 
      brstat.tlt.nor_grprm       = deci(wdetail.pol_netprem)           
      brstat.tlt.ndeci1          = deci(wdetail.pol_gprem  )           
      brstat.tlt.ndeci2          = deci(wdetail.pol_stamp  )           
      brstat.tlt.ndeci3          = deci(wdetail.pol_vat    )           
      brstat.tlt.ndeci4          = deci(wdetail.pol_wht    )           
      brstat.tlt.comp_pol        = ""  /*trim(wdetail.com_no)*/
      brstat.tlt.comp_sck        = TRIM(wdetail.com_no)
      brstat.tlt.nor_effdat      = date(wdetail.com_comm_date)         
      brstat.tlt.comp_effdat     = date(wdetail.com_exp_date)          
      brstat.tlt.comp_coamt      = deci(wdetail.com_netprem)           
      brstat.tlt.comp_grprm      = deci(wdetail.com_gprem)             
      brstat.tlt.rstp            = deci(wdetail.com_stamp)             
      brstat.tlt.rtax            = deci(wdetail.com_vat)               
      brstat.tlt.tax_coporate    = DECI(wdetail.com_wht)               
      brstat.tlt.note2           = trim(wdetail.deler )          
      brstat.tlt.note3           = trim(wdetail.showroom )          
      brstat.tlt.note4           = trim(wdetail.typepay)          
      brstat.tlt.ben83           = trim(wdetail.financename)          
      brstat.tlt.ins_addr1       = "MH:" + trim(wdetail.mail_hno) + " " +
                                   "MB:" + trim(wdetail.mail_build) + " " +    
                                   "MM:" + trim(wdetail.mail_mu )         
      brstat.tlt.ins_addr2       = "MS:" + trim(wdetail.mail_soi) + " " +
                                   "MR:" + trim(wdetail.mail_road)        
      brstat.tlt.ins_addr3       = trim(wdetail.mail_tambon)          
      brstat.tlt.ins_addr4       = trim(wdetail.mail_amper)          
      brstat.tlt.ins_addr5       = trim(wdetail.mail_country)          
      brstat.tlt.lince3          = trim(wdetail.mail_post)          
      brstat.tlt.datesent        = IF TRIM(wdetail.send_date) <> "" THEN DATE(wdetail.send_date) ELSE ?          
      brstat.tlt.policy          = "" /*trim(wdetail.policy_no)*/          
      brstat.tlt.ndate2          = IF trim(wdetail.send_data) <> "" THEN DATE(wdetail.send_data) ELSE ?          
      brstat.tlt.note5           = trim(wdetail.REMARK1  )          
      brstat.tlt.ins_occ         = trim(wdetail.occup ) 

      brstat.tlt.acno1           = trim(wdetail.producer ) 
      brstat.tlt.agent           = IF trim(wdetail.agent) <> "" THEN trim(wdetail.agent) ELSE "B3M0018" 
      brstat.tlt.ins_brins       = trim(wdetail.branch)  
      brstat.tlt.product         = trim(wdetail.product) 
      brstat.tlt.dealer          = trim(wdetail.delerco)
      brstat.tlt.finint          = TRIM(wdetail.vatcode)
      brstat.tlt.hclfg           = IF wdetail.err = "" THEN "N" ELSE "Y"      /*สถานะติดปัญหา : Y, N*/
      brstat.tlt.note6           = ""                                        /*comment             */
      brstat.tlt.note8           = TRIM(wdetail.ispno)         /*เลขตรวจสภาพ         */
      brstat.tlt.note9           = trim(wdetail.ispresult)     /*ข้อมูลตรวจสภาพ      */
      brstat.tlt.note10          = trim(wdetail.ispdetail)     /* ข้อมูลความเสียหาย */
      brstat.tlt.note11          = TRIM(wdetail.ispacc)        /* ข้อมูลอุปกรณ์เสริม */
      brstat.tlt.note12          = trim(wdetail.np_f18line1)
      brstat.tlt.note13          = trim(wdetail.np_f18line2)
      brstat.tlt.note14          = trim(fi_notdate)    /* เวลาแจ้งงาน */
      brstat.tlt.note15          = trim(wdetail.err)          /*error               */
      brstat.tlt.note16          = ""   /* EMS No.*/
      brstat.tlt.note17          = ""   /* Tran dat */
      brstat.tlt.note18          = ""   /* Release dat */
      brstat.tlt.note19          = trim(wdetail.np_f18line5) .   /* type swit ,first , renew ,refinance*/
      
      ASSIGN wdetail.regis_year = brstat.tlt.old_cha .
        
      IF TRIM(wdetail.producer) = "A000324" THEN DO: 
          IF index(wdetail.err,"กรมธรรม์ขาดต่ออายุ") <> 0 THEN ASSIGN  brstat.tlt.note7 = "Y" .
          ELSE IF trim(wdetail.prvpol) = "" AND INDEX(wdetail.class,"110") = 0  THEN ASSIGN  brstat.tlt.note7 = "Y" . 
          ELSE ASSIGN  brstat.tlt.note7 = "N" . 
      END.
      ELSE IF TRIM(wdetail.producer) = "B3M0034" THEN assign brstat.tlt.note7 = "Y" .
      ELSE IF TRIM(wdetail.producer) = "B3M0031" THEN assign brstat.tlt.note7 = "N" . 
      ELSE IF TRIM(wdetail.producer) = "B3M0018" THEN assign brstat.tlt.note7 = "N" .
      ELSE IF TRIM(wdetail.producer) = "A0M2001" THEN assign brstat.tlt.note7 = "N" .
      ELSE IF trim(wdetail.ispno) <> "" THEN ASSIGN brstat.tlt.note7 = "Y" . 
      ELSE ASSIGN brstat.tlt.note7 = "N" .                  /*การตรวจสภาพ : Y , N */

      ASSIGN wdetail.isp  = brstat.tlt.note7 .
END.
    
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
  DISPLAY fi_mail fi_process rs_type fi_loaddat fi_compa fi_filename fi_impcnt 
          fi_completecnt fi_output fi_insp fi_name fi_notdate 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_imptxt fi_mail fi_process rs_type fi_loaddat fi_compa fi_filename 
         bu_ok bu_exit bu_file fi_output fi_insp fi_name fi_notdate RECT-1 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_New C-Win 
PROCEDURE Import_New :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfwdetail FOR wdetail. /*A62-0422*/
ASSIGN fi_process  = "Create data to workfile TAS/TPIB.......[ISUZU]" .  
DISP  fi_process WITH FRAM fr_main.
/*A61-0152
ASSIGN nv_memo1 = ""
       nv_memo2 = ""
       nv_memo3 = "" .
end A61-0152*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"    
        wdetail.ins_ytyp          
        wdetail.bus_typ           
        wdetail.TASreceived          
        wdetail.InsCompany           
        wdetail.Insurancerefno       
        wdetail.tpis_no
        wdetail.ntitle             
        wdetail.insnam               
        wdetail.NAME2                
        wdetail.cust_type
        wdetail.nDirec               
        wdetail.ICNO                 
        wdetail.address              
        wdetail.build
        wdetail.mu                   
        wdetail.soi                  
        wdetail.road                 
        wdetail.tambon               
        wdetail.amper                
        wdetail.country              
        wdetail.post                 
        wdetail.brand             
        wdetail.model                
        wdetail.class
        wdetail.md_year
        wdetail.Usage              
        wdetail.coulor               
        wdetail.cc                   
        wdetail.regis_year     
        wdetail.engno                
        wdetail.chasno               
        wdetail.Acc_CV            
        wdetail.Acc_amount        
        wdetail.License
        wdetail.regis_CL
        wdetail.campaign
        wdetail.typ_work
        wdetail.si                   
        wdetail.pol_comm_date     
        wdetail.pol_exp_date     
        wdetail.last_pol
        wdetail.cover
        wdetail.pol_netprem
        wdetail.pol_gprem
        wdetail.pol_stamp
        wdetail.pol_vat
        wdetail.pol_wht
        wdetail.com_no
        wdetail.com_comm_date
        wdetail.com_exp_date
        wdetail.com_netprem
        wdetail.com_gprem
        wdetail.com_stamp
        wdetail.com_vat
        wdetail.com_wht
        wdetail.deler                
        wdetail.showroom             
        wdetail.typepay              
        wdetail.financename          
        wdetail.mail_hno
        wdetail.mail_build
        wdetail.mail_mu                   
        wdetail.mail_soi                  
        wdetail.mail_road                 
        wdetail.mail_tambon               
        wdetail.mail_amper                
        wdetail.mail_country              
        wdetail.mail_post                 
        wdetail.send_date
        wdetail.policy_no
        wdetail.send_data
        wdetail.REMARK1              
        wdetail.occup
        /*wdetail.np_f18line1  /*A61-0152*/ comment by kridtiyai .A68-0044
        wdetail.regis_no                    comment by kridtiyai .A68-0044
        wdetail.claimdi      /*A63-0209*/   comment by kridtiyai .A68-0044
        wdetail.product .    /*A63-0209*/   comment by kridtiyai .A68-0044*/
        wdetail.Driver1_title                /*add by kridtiyai. A68-0044*/
        wdetail.Driver1_name                 /*add by kridtiyai. A68-0044*/
        wdetail.Driver1_lastname             /*add by kridtiyai. A68-0044*/
        wdetail.Driver1_birthdate            /*add by kridtiyai. A68-0044*/
        wdetail.Driver1_id_no                /*add by kridtiyai. A68-0044*/
        wdetail.Driver1_license_no           /*add by kridtiyai. A68-0044*/
        wdetail.Driver1_occupation           /*add by kridtiyai. A68-0044*/
        wdetail.Driver2_title                /*add by kridtiyai. A68-0044*/
        wdetail.Driver2_name                 /*add by kridtiyai. A68-0044*/
        wdetail.Driver2_lastname             /*add by kridtiyai. A68-0044*/
        wdetail.Driver2_birthdate            /*add by kridtiyai. A68-0044*/
        wdetail.Driver2_id_no                /*add by kridtiyai. A68-0044*/
        wdetail.Driver2_license_no           /*add by kridtiyai. A68-0044*/
        wdetail.Driver2_occupation           /*add by kridtiyai. A68-0044*/
        wdetail.Driver3_title                /*add by kridtiyai. A68-0044*/
        wdetail.Driver3_name                 /*add by kridtiyai. A68-0044*/
        wdetail.Driver3_lastname             /*add by kridtiyai. A68-0044*/
        wdetail.Driver3_birthday             /*add by kridtiyai. A68-0044*/
        wdetail.Driver3_id_no                /*add by kridtiyai. A68-0044*/
        wdetail.Driver3_license_no           /*add by kridtiyai. A68-0044*/
        wdetail.Driver3_occupation           /*add by kridtiyai. A68-0044*/
        wdetail.Driver4_title                /*add by kridtiyai. A68-0044*/
        wdetail.Driver4_name                 /*add by kridtiyai. A68-0044*/
        wdetail.Driver4_lastname             /*add by kridtiyai. A68-0044*/
        wdetail.Driver4_birthdate            /*add by kridtiyai. A68-0044*/
        wdetail.Driver4_id_no                /*add by kridtiyai. A68-0044*/
        wdetail.Driver4_license_no           /*add by kridtiyai. A68-0044*/
        wdetail.Driver4_occupation           /*add by kridtiyai. A68-0044*/
        wdetail.Driver5_title                /*add by kridtiyai. A68-0044*/
        wdetail.Driver5_name                 /*add by kridtiyai. A68-0044*/
        wdetail.Driver5_lastname             /*add by kridtiyai. A68-0044*/
        wdetail.Driver5_birthdate            /*add by kridtiyai. A68-0044*/
        wdetail.Driver5_id_no                /*add by kridtiyai. A68-0044*/
        wdetail.Driver5_license_no           /*add by kridtiyai. A68-0044*/
        wdetail.Driver5_occupation   .       /*add by kridtiyai. A68-0044*/
    
    /*IF INDEX(wdetail.ins_ytyp,"mail") <> 0 THEN DO:
      ASSIGN nv_memo1 = wdetail.bus_typ 
             nv_memo2 = wdetail.TASreceived  
             nv_memo3 = wdetail.InsCompany.
    END. */

         
    
    IF INDEX(wdetail.ins_ytyp,"Ins") <> 0 THEN DELETE wdetail.               
    ELSE IF INDEX(wdetail.ins_ytyp,"ins")  <> 0 THEN DELETE wdetail. 
    ELSE IF INDEX(wdetail.ins_ytyp,"Renew") <> 0 THEN DO: 
        ASSIGN  wdetail.err = "Ins. Year type ไม่ใช่งานป้ายแดง" .
    END.
    ELSE IF INDEX(wdetail.ins_ytyp,"renew")  <> 0 THEN DO:
        ASSIGN  wdetail.err = "Ins. Year type ไม่ใช่งานป้ายแดง" .
    END.
    ELSE IF wdetail.tpis_no = "" THEN DELETE wdetail.
    

END. /*-Repeat-*/ 

RELEASE wdetail. 

FIND FIRST bfwdetail WHERE bfwdetail.tpis_no <> "" AND INDEX(bfwdetail.si,"ซ่อม") <> 0 NO-ERROR NO-WAIT .
 IF AVAIL bfwdetail THEN DO:
     MESSAGE "ไฟล์แจ้งงานไม่ถูกต้อง " VIEW-AS ALERT-BOX.
     FOR EACH wdetail .
        DELETE wdetail.
     END.
 END.
 RUN pro_chknew.
ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
 
Run  Create_tlt.   
If  nv_completecnt  <>  0  Then do:
    /*Enable br_imptxt       With frame fr_main.*/
End. 

RUN pro_head_new.

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Complete"  View-as alert-box.  
Run Open_tlt.
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_Renew C-Win 
PROCEDURE Import_Renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
/*ASSIGN nv_memo1 = ""
       nv_memo2 = ""
       nv_memo3 = "" .*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|"        
        wdetail.ins_ytyp          
        wdetail.bus_typ           
        wdetail.TASreceived          
        wdetail.InsCompany           
        wdetail.Insurancerefno       
        wdetail.tpis_no
        wdetail.ntitle             
        wdetail.insnam               
        wdetail.NAME2                
        wdetail.cust_type
        wdetail.nDirec               
        wdetail.ICNO                 
        wdetail.address              
        wdetail.build
        wdetail.mu                   
        wdetail.soi                  
        wdetail.road                 
        wdetail.tambon               
        wdetail.amper                
        wdetail.country              
        wdetail.post                 
        wdetail.brand             
        wdetail.model                
        wdetail.class
        wdetail.md_year
        wdetail.Usage              
        wdetail.coulor               
        wdetail.cc                   
        wdetail.regis_year     
        wdetail.engno                
        wdetail.chasno               
        wdetail.Acc_CV            
        wdetail.Acc_amount        
        wdetail.License
        wdetail.regis_CL
        wdetail.campaign
        wdetail.typ_work
        wdetail.garage     
        wdetail.desmodel   
        wdetail.si                   
        wdetail.pol_comm_date     
        wdetail.pol_exp_date     
        wdetail.last_pol
        wdetail.cover
        wdetail.pol_netprem
        wdetail.pol_gprem
        wdetail.pol_stamp
        wdetail.pol_vat
        wdetail.pol_wht
        wdetail.com_no
        wdetail.com_comm_date
        wdetail.com_exp_date
        wdetail.com_netprem
        wdetail.com_gprem
        wdetail.com_stamp
        wdetail.com_vat
        wdetail.com_wht
        wdetail.deler                
        wdetail.showroom             
        wdetail.typepay              
        wdetail.financename          
        wdetail.mail_hno
        wdetail.mail_build
        wdetail.mail_mu                   
        wdetail.mail_soi                  
        wdetail.mail_road                 
        wdetail.mail_tambon               
        wdetail.mail_amper                
        wdetail.mail_country              
        wdetail.mail_post                 
        wdetail.send_date
        wdetail.policy_no
        wdetail.send_data
        wdetail.REMARK1              
        wdetail.occup . 
    
    /*IF INDEX(wdetail.ins_ytyp,"mail") <> 0 THEN DO:
      ASSIGN nv_memo1 = wdetail.bus_typ 
             nv_memo2 = wdetail.TASreceived  
             nv_memo3 = wdetail.InsCompany.
    END. 
    ELSE*/ IF index(wdetail.ins_ytyp,"ins.")   <> 0 THEN DELETE wdetail.   
    ELSE IF index(wdetail.ins_ytyp,"Ins.")   <> 0 THEN DELETE wdetail.            
    ELSE IF index(wdetail.ins_ytyp,"first")  <> 0 THEN DO: 
        ASSIGN  wdetail.err = "Ins. Year type ไม่ใช่งาน RENEWAL" .
    END.
    ELSE IF index(wdetail.ins_ytyp,"First")  <> 0 THEN DO:
        ASSIGN  wdetail.err = "Ins. Year type ไม่ใช่งาน RENEWAL" .
    END.
    ELSE IF TRIM(wdetail.tpis_no) = ""  THEN DELETE wdetail.

   /* IF nv_memo1 <> "" THEN DO:
        ASSIGN wdetail.np_f18line1 = nv_memo1 
               wdetail.np_f18line2 = nv_memo2 
               wdetail.np_f18line3 = nv_memo3 .
    END.*/

END.  /* repeat  */
RUN pro_chkfile.

ASSIGN nv_reccnt    = 0
    nv_completecnt  = 0 . 
 
Run  Create_tlt.   
If  nv_completecnt  <>  0  Then do:
    /*Enable br_imptxt       With frame fr_main.*/
End. 
RUN pro_head_renew.

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
Open Query br_imptxt  For each wdetail NO-LOCK .

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
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
//nv_c = wdetail.prev_pol.
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
/*ASSIGN
    wdetail.prev_pol = nv_c .*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkaddr C-Win 
PROCEDURE proc_chkaddr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    DEF VAR nv_i AS INT.
    DEF VAR nv_c AS CHAR FORMAT "x(255)" .
    DEF VAR nv_l AS INT.
    DEF VAR nv_p AS CHAR.
    DEF VAR ind  AS INT.
    nv_c = wdetail.Acc_CV.
    nv_i = 0.
    nv_l = LENGTH(nv_c).
    /* Acc text */
    IF nv_c <> ""   THEN DO:
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
            ind = INDEX(nv_c,":").
            IF ind <> 0 THEN DO:
                nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_c,";").
            IF ind <> 0 THEN DO:
                nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_c,"|").
            IF ind <> 0 THEN DO:
                nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_c,"'").
            IF ind <> 0 THEN DO:
                nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
            END.
            ind = INDEX(nv_c,"=").
            IF ind <> 0 THEN DO:
                nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
            END.
            
            nv_i = nv_i + 1.
        END.
        ASSIGN wdetail.Acc_CV = nv_c .
    END.
   
    /* เอาขอ้มูล ตำบล อำเภอ จังหวัด ออก */

     
   /* = trim(wdetail.soi     ) 

           "MM:" + trim(wdetail.mail_mu )           
         = "MS:" + trim(wdetail.mail_soi)  */
    IF      index(wdetail.mu,"หมู่ที่")      <> 0 THEN ASSIGN wdetail.mu      = TRIM(REPLACE(wdetail.mu,"หมู่ที่","")).
    ELSE IF index(wdetail.mu,"หมู่")         <> 0 THEN ASSIGN wdetail.mu      = TRIM(REPLACE(wdetail.mu,"หมู่","")).
    ELSE IF index(wdetail.mu,"ม.")           <> 0 THEN ASSIGN wdetail.mu      = TRIM(REPLACE(wdetail.mu,"ม.","")).
    IF      index(wdetail.mail_mu,"หมู่ที่") <> 0 THEN ASSIGN wdetail.mail_mu = TRIM(REPLACE(wdetail.mail_mu,"หมู่ที่","")).
    ELSE IF index(wdetail.mail_mu,"หมู่")    <> 0 THEN ASSIGN wdetail.mail_mu = TRIM(REPLACE(wdetail.mail_mu,"หมู่","")).
    ELSE IF index(wdetail.mail_mu,"ม.")      <> 0 THEN ASSIGN wdetail.mail_mu = TRIM(REPLACE(wdetail.mail_mu,"ม.","")).
     
    IF      index(wdetail.soi,"ซอย") <> 0 THEN ASSIGN wdetail.soi = TRIM(REPLACE(wdetail.soi,"ซอย","")).
    ELSE IF index(wdetail.soi,"ซ.")  <> 0 THEN ASSIGN wdetail.soi = TRIM(REPLACE(wdetail.soi,"ซ.","")).
    IF      index(wdetail.mail_soi,"ซอย") <> 0 THEN ASSIGN wdetail.mail_soi = TRIM(REPLACE(wdetail.mail_soi,"ซอย","")).
    ELSE IF index(wdetail.mail_soi,"ซ.")  <> 0 THEN ASSIGN wdetail.mail_soi = TRIM(REPLACE(wdetail.mail_soi,"ซ.","")). 

    IF index(wdetail.mail_tambon,"ตำบล") <> 0 THEN DO:               
        ASSIGN wdetail.mail_tambon = TRIM(REPLACE(wdetail.mail_tambon,"ตำบล","")).
    END.
    ELSE IF index(wdetail.mail_tambon,"ต.") <> 0 THEN DO:               
        ASSIGN wdetail.mail_tambon = TRIM(REPLACE(wdetail.mail_tambon,"ต.","")).
    END.
    ELSE IF index(wdetail.mail_tambon,"แขวง") <> 0 THEN DO:               
        ASSIGN wdetail.mail_tambon = TRIM(REPLACE(wdetail.mail_tambon,"แขวง","")).
    END.
    ELSE IF index(wdetail.mail_tambon,"ขว.") <> 0 THEN DO:               
        ASSIGN wdetail.mail_tambon = TRIM(REPLACE(wdetail.mail_tambon,"ขว.","")).
    END.
    
    IF INDEX(wdetail.mail_amper,"อำเภอ") <> 0 THEN DO:
        ASSIGN wdetail.mail_amper = TRIM(REPLACE(wdetail.mail_amper,"อำเภอ","")).
    END.
    ELSE IF INDEX(wdetail.mail_amper,"อ.") <> 0 THEN DO:
        ASSIGN wdetail.mail_amper = TRIM(REPLACE(wdetail.mail_amper,"อ.","")).
    END.
    ELSE IF INDEX(wdetail.mail_amper,"เขต") <> 0 THEN DO:
        ASSIGN wdetail.mail_amper = TRIM(REPLACE(wdetail.mail_amper,"เขต","")).
    END.
    
    IF index(wdetail.mail_country,"จังหวัด") <> 0 THEN DO: 
        ASSIGN wdetail.mail_country = TRIM(REPLACE(wdetail.mail_country,"จังหวัด","")).
    END.
    ELSE IF index(wdetail.mail_country,"จ.") <> 0 THEN DO: 
            ASSIGN wdetail.mail_country = TRIM(REPLACE(wdetail.mail_country,"จ.","")).
    END.
     
    
    IF index(wdetail.tambon,"ตำบล") <> 0 THEN DO:               
        ASSIGN wdetail.tambon = TRIM(REPLACE(wdetail.tambon,"ตำบล","")).
    END.
    ELSE IF index(wdetail.tambon,"ต.") <> 0 THEN DO:               
        ASSIGN wdetail.tambon = TRIM(REPLACE(wdetail.tambon,"ต.","")).
    END.
    ELSE IF index(wdetail.tambon,"แขวง") <> 0 THEN DO:               
        ASSIGN wdetail.tambon = TRIM(REPLACE(wdetail.tambon,"แขวง","")).
    END.
    ELSE IF index(wdetail.tambon,"ขว.") <> 0 THEN DO:               
        ASSIGN wdetail.tambon = TRIM(REPLACE(wdetail.tambon,"ขว.","")).
    END.
    
    IF INDEX(wdetail.amper,"อำเภอ") <> 0 THEN DO:
        ASSIGN wdetail.amper = TRIM(REPLACE(wdetail.amper,"อำเภอ","")).
    END.
    ELSE IF INDEX(wdetail.amper,"อ.") <> 0 THEN DO:
        ASSIGN wdetail.amper = TRIM(REPLACE(wdetail.amper,"อ.","")).
    END.
    ELSE IF INDEX(wdetail.amper,"เขต") <> 0 THEN DO:
        ASSIGN wdetail.amper = TRIM(REPLACE(wdetail.amper,"เขต","")).
    END.
    
    IF index(wdetail.country,"จังหวัด") <> 0 THEN DO: 
        ASSIGN wdetail.country = TRIM(REPLACE(wdetail.country,"จังหวัด","")).
    END.
    ELSE IF index(wdetail.country,"จ.") <> 0 THEN DO: 
            ASSIGN wdetail.country = TRIM(REPLACE(wdetail.country,"จ.","")).
    END.

    /* check date */
    IF  trim(wdetail.pol_comm_date) <> "" AND  YEAR(DATE(wdetail.pol_comm_date)) <> YEAR(TODAY) THEN DO:
        ASSIGN wdetail.err = wdetail.err + " " + "/ปีที่คุ้มครองของ กธ.ไม่เท่ากับปีปัจจุบัน" .
    END.
    IF trim(wdetail.pol_exp_date) <> "" AND YEAR(DATE(wdetail.pol_exp_date)) <> (YEAR(TODAY) + 1) THEN DO:
        ASSIGN wdetail.err = wdetail.err + " " + "/ปีที่หมดอายุของ กธ.ไม่ถูกต้อง" .
    END.

    IF TRIM(wdetail.com_comm_date) <> "" AND  YEAR(date(wdetail.com_comm_date)) <> YEAR(TODAY) THEN DO:
        ASSIGN wdetail.err = wdetail.err + " " + "/ปีที่คุ้มครองของ พรบ.ไม่เท่ากับปีปัจจุบัน" .
    END.
    IF trim(wdetail.com_exp_date) <> "" AND  YEAR(date(wdetail.com_exp_date)) <> (YEAR(TODAY) + 1) THEN DO: 
        ASSIGN wdetail.err = wdetail.err + " " + "/ปีที่หมดอายุของ พรบ.ไม่ถูกต้อง" .
    END.


END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkbrRefin C-Win 
PROCEDURE proc_chkbrRefin :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST stat.insure USE-INDEX insure01 WHERE 
    stat.insure.compno = "TPIS"            AND    
    stat.insure.fname  = "Refinance"       AND
    index(wdetail.Acc_CV,stat.insure.lname) <> 0  
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL stat.insure THEN DO: 
    ASSIGN wdetail.branch  = trim(stat.insure.branch)  . 
END.
ELSE     ASSIGN wdetail.branch  = "M".

/* 
index(wdetail.deler,"Refinance")
wdetail.Acc_CV = เชียงใหม่ */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdealer C-Win 
PROCEDURE proc_chkdealer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  n_deler      AS  CHAR  FORMAT  "x(70)" INIT  "" .
DEF VAR  n_showroom   AS  CHAR  FORMAT  "x(70)" INIT  "" . 

DO:
    ASSIGN n_deler    = TRIM(wdetail.deler)    
           n_showroom = TRIM(wdetail.showroom)  .

    IF INDEX(n_deler,"-") <> 0 THEN DO:
        ASSIGN n_deler = TRIM(SUBSTR(n_deler,1,R-INDEX(n_deler,"-") - 1)).
    END.

    IF INDEX(n_showroom,n_deler) <> 0 THEN DO:
        ASSIGN n_showroom = TRIM(REPLACE(n_showroom,n_deler,""))
               n_showroom = TRIM(REPLACE(n_showroom,"-","")).
    END.

    ASSIGN wdetail.deler     = trim(n_deler)   
           wdetail.showroom  = trim(n_showroom) .


    IF TRIM(wdetail.remark) = "Send receipt to"  THEN ASSIGN wdetail.remark = "" .
    ELSE IF TRIM(wdetail.remark) = "-" THEN ASSIGN wdetail.remark = "" .



END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkLicense C-Win 
PROCEDURE proc_chkLicense :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR License AS CHAR FORMAT "x(60)".
ASSIGN 
    License = ""
    License = trim(wdetail.License)
    License = REPLACE(License,"  "," ")
    License = REPLACE(License,"-"," ")
    License = REPLACE(License,"."," ")
    License = REPLACE(License,CHR(63),"").
    
IF SUBSTR(License,1,1) <> "/"  THEN DO:

    IF  INDEX("0123456789",SUBSTR(License,1,1)) <> 0 THEN DO:
        IF SUBSTR(License,2,1) = "" THEN License = trim(SUBSTR(License,1,1) + SUBSTR(License,3)).

        IF  INDEX("0123456789",SUBSTR(License,2,1)) = 0 THEN DO:
            
                IF  INDEX("0123456789",SUBSTR(License,3,1)) = 0 THEN DO:
                    IF SUBSTR(License,3,1) = "" THEN DO:
                        IF  INDEX("0123456789",SUBSTR(License,4,1)) = 0 THEN  
                             License = trim(SUBSTR(License,1,3))   + trim(SUBSTR(License,4)).
                        ELSE License = trim(SUBSTR(License,1,3)) + " " + trim(SUBSTR(License,4)).
                         
                    END.
                    ELSE License = trim(SUBSTR(License,1,3) +  " " +    trim(SUBSTR(License,4))).
                END.
                ELSE License = trim(SUBSTR(License,1,2) +  " " +    trim(SUBSTR(License,3))).
           

        END.
        ELSE License = trim(SUBSTR(License,1,2) +  " " +    trim(SUBSTR(License,3))).
    END.
    ELSE DO:  /*License = "กท 123".*/
        IF  INDEX("0123456789",SUBSTR(License,2,1)) = 0 THEN DO:
            /*MESSAGE "001"  License VIEW-AS ALERT-BOX.*/
            IF SUBSTR(License,2,1) = "" THEN License = trim(SUBSTR(License,1,1) + trim(SUBSTR(License,2))).
            IF  INDEX("0123456789",SUBSTR(License,3,1)) = 0 THEN DO:
                IF SUBSTR(License,3,1) = "" THEN 
                    License = trim(SUBSTR(License,1,2) +  " " +    trim(SUBSTR(License,3))).
                ELSE License = trim(SUBSTR(License,1,3) +  " " +    trim(SUBSTR(License,4))).
            END.
            ELSE License = trim(SUBSTR(License,1,2) +  " " +    trim(SUBSTR(License,3))).
        END.
        ELSE IF SUBSTR(License,2,1) = "" THEN DO: 
            License = trim(SUBSTR(License,1,1) + trim(SUBSTR(License,2))).
            /*MESSAGE "002"  License  VIEW-AS ALERT-BOX.*/
            IF  INDEX("0123456789",SUBSTR(License,2,1)) = 0 THEN DO:
                IF SUBSTR(License,2,1) = "" THEN 
                    License = trim(SUBSTR(License,1,2)) +  " " +    trim(SUBSTR(License,3)).
                ELSE License = trim(SUBSTR(License,1,3)) +  " " +    trim(SUBSTR(License,4)).
            END.
            ELSE License = trim(SUBSTR(License,1,2) +  " " +    trim(SUBSTR(License,3))).
        END.
        ELSE DO: 
            IF  INDEX("0123456789",SUBSTR(License,2,1)) = 0 THEN DO:
                IF SUBSTR(License,2,1) = "" THEN 
                    License = trim(SUBSTR(License,1,2)) +  " " +    trim(SUBSTR(License,3)).
                ELSE License = trim(SUBSTR(License,1,3)) +  " " +    trim(SUBSTR(License,4)).
            END.
            ELSE License = trim(SUBSTR(License,1,1) +  " " +    trim(SUBSTR(License,2))).
        END.
    END.
END.
ASSIGN 
    wdetail.License  = trim(License). 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkproduct C-Win 
PROCEDURE proc_chkproduct :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 IF DECI(wdetail.pol_netprem) <> 0 AND TRIM(wdetail.cover) <> "2"  THEN DO:
    
    FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
              brstat.insure.compno      = "TPIS"           AND 
              index(brstat.insure.Text4,wdetail.class) <> 0       AND  
              brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
              deci(brstat.insure.Text5) = DECI(wdetail.pol_netprem) /* AND 
              trim(brstat.insure.Text2) = trim(np_garage)*/   NO-LOCK NO-ERROR.

    IF AVAIL brstat.insure THEN DO:
     ASSIGN /*wdetail.CLASS    = TRIM(brstat.insure.Text4) 
            wdetail.campens  = trim(brstat.insure.Text1)*/
            wdetail.product  = trim(brstat.insure.Text3). /*A65-0177*/
    END.
    ELSE DO: 
      ASSIGN /*wdetail.CLASS    = ""
             wdetail.campens  = ""*/
             wdetail.product  = "".
    END.
 END.
 IF TRIM(wdetail.cover) = "2"  THEN DO:
      FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                brstat.insure.compno      = "TPIS"            AND 
                index(brstat.insure.Text4,wdetail.class) <> 0        AND  
                brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                deci(brstat.insure.Text5) = DECI(wdetail.pol_netprem) NO-LOCK NO-ERROR.
      IF AVAIL brstat.insure THEN DO:
          ASSIGN /*wdetail.CLASS    = TRIM(brstat.insure.Text4) 
                 wdetail.campens  = trim(brstat.insure.Text1) */
                 wdetail.product  = trim(brstat.insure.Text3).
      END.
      ELSE DO: 
        ASSIGN /*wdetail.CLASS    = ""
               wdetail.campens  = ""*/
               wdetail.product  = "".
      END.
 END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkprvpol C-Win 
PROCEDURE proc_chkprvpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  n_polced70   AS CHAR.
DEF VAR  n_comdate70  as DATE. 
DEF VAR  n_renpol     AS CHAR.
ASSIGN 
    n_polced70   = "" 
    n_comdate70  = ? 
    n_renpol     = "" .

FOR EACH sicuw.uwm301 USE-INDEX uwm30121 WHERE 
    sicuw.uwm301.cha_no = TRIM(wdetail.chasno)  AND 
    sicuw.uwm301.tariff = "X" NO-LOCK  .

    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
        sicuw.uwm100.policy = sicuw.uwm301.policy  
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF n_comdate70 = ? THEN 
            ASSIGN 
            n_polced70  = sicuw.uwm100.policy
            n_comdate70 = sicuw.uwm100.comdat
            n_renpol    = sicuw.uwm100.renpol.

        ELSE IF sicuw.uwm100.comdat > n_comdate70  THEN
            ASSIGN 
            n_polced70   = sicuw.uwm100.policy
            n_comdate70  = sicuw.uwm100.comdat
            n_renpol     = sicuw.uwm100.renpol.

    END.
END.
IF n_polced70 = "" THEN ASSIGN  wdetail.prvpol = "".
ELSE IF n_polced70 <> "" AND n_renpol <> "" THEN
    ASSIGN 
    wdetail.prvpol = n_polced70 + " ต่ออายุแล้ว "
    wdetail.err    = wdetail.err + "/" + n_polced70 + " ต่ออายุแล้ว".
ELSE ASSIGN  wdetail.prvpol = trim(n_polced70) . 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpol72 C-Win 
PROCEDURE proc_cutpol72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
nv_c = wdetail.com_no.
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
ASSIGN wdetail.com_no = nv_c .
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
DEF VAR n_list           AS INT init 0.
DEF VAR n_count          AS INT init 0.
DEF VAR n_repair         AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam            AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil         AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag         AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair        AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_damdetail     AS LONGCHAR  INIT "".
DEF VAR nv_docno         AS CHAR FORMAT "x(15)" .
DEF VAR nv_survey        AS CHAR FORMAT "x(50)" .
DEF VAR nv_detail        AS CHAR FORMAT "x(255)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(250)".  
DEF VAR nv_today         AS CHAR FORMAT "x(15)" .

ASSIGN  nv_docno    = ""      nv_survey   = ""    nv_detail  = ""     
        nv_damlist  = ""     nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
        nv_acc2     = ""     nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
        nv_acc8     = ""     nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = ""
        nv_tmp      = "Inspect" + SUBSTR(fi_insp,3,2) + ".nsf" .
        /*nv_today    = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY),"9999")
        nv_time     = STRING(TIME,"HH:MM:SS")
        nv_branchdesp = "" . */

/*--------- Server Real ---------- */
nv_server = "Safety_NotesServer/Safety".
nv_tmp   = "safety\uw\" + nv_tmp .
/* -------------------------------*/
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
  ELSE DO:
    chNotesView    = chNotesDatabase:GetView("chassis_no").
    chNavView      = chNotesView:CreateViewNav.
    chDocument     = chNotesView:GetDocumentByKey(trim(wdetail.chasno)).
    
    IF VALID-HANDLE(chDocument) = YES THEN DO:

        chitem       = chDocument:Getfirstitem("docno"). 
        IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
        ELSE nv_docno = "".

        chitem       = chDocument:Getfirstitem("SurveyClose").
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
           IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
           ELSE nv_damlist = "".
           chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
           IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
           ELSE nv_totaldam = "".
          
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
                             n_repair = "Repair" + STRING(n_count) .
                     
                     chitem       = chDocument:Getfirstitem(n_dam).
                     IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                     ELSE nv_damag = "".  
                     
                     chitem       = chDocument:Getfirstitem(n_repair).
                     IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                     ELSE nv_repair = "".
                         
                     IF nv_damag <> "" THEN  
                         ASSIGN nv_damdetail = nv_damdetail + string(n_count) + "." + nv_damag + /*" " + nv_repair +*/ " , " .
                     n_count = n_count + 1.
                 END.
                 ELSE LEAVE loop_damage.
             END.
           END.
        END. /* end ความเสียหาย */
        /*-- อุปกรณ์เสริม --*/  
          chitem       = chDocument:Getfirstitem("device1").
          IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
          ELSE nv_device = "".

          IF nv_device <> "" THEN DO:
              chitem       = chDocument:Getfirstitem("pricesTotal").  /* ราคารวมอุปกรณ์เสริม */
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
              nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " .
          END.
    
        IF nv_docno <> ""  THEN DO:
            IF nv_survey <> "" THEN DO:
                IF nv_detail = "ติดปัญหา" THEN DO:
                   ASSIGN  wdetail.isp       = "Y"
                           wdetail.ispno     = nv_docno
                           wdetail.ispresult = nv_detail 
                           wdetail.ispdetail = nv_damage
                           wdetail.ispacc    = nv_device .
                END.
                ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                  ASSIGN  wdetail.isp       = "Y"
                          wdetail.ispno     = nv_docno
                          wdetail.ispresult = nv_detail 
                          wdetail.ispdetail = nv_damlist  + " " + nv_damdetail
                          wdetail.ispacc    = nv_device .
                END.
                ELSE DO:
                    ASSIGN  wdetail.isp       = "Y"
                            wdetail.ispno     = nv_docno
                            wdetail.ispresult = nv_detail 
                            wdetail.ispdetail = nv_damlist  + " " + nv_damdetail
                            wdetail.ispacc    = nv_device .
                END.
            END.
            ELSE DO:
              ASSIGN  wdetail.isp       = "Y"
                      wdetail.ispno     = nv_docno
                      wdetail.ispresult = "" 
                      wdetail.ispdetail = ""
                      wdetail.ispacc    = nv_device .
            END.
        END.
        ELSE DO:
            ASSIGN  wdetail.isp       = "Y"
                    wdetail.ispno     = ""
                    wdetail.ispresult = ""
                    wdetail.ispdetail = ""
                    wdetail.ispacc    = nv_device .
        END.
        RELEASE  OBJECT chitem          NO-ERROR.
        RELEASE  OBJECT chDocument      NO-ERROR.          
        RELEASE  OBJECT chNotesDataBase NO-ERROR.     
        RELEASE  OBJECT chNotesSession  NO-ERROR.
    END.
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
      chDocument:AppendItemValue( "Fname", wdetail.pol_fname).    
      chDocument:AppendItemValue( "Lname", wdetail.pol_lname).    
      chDocument:AppendItemValue( "PolicyNo", ""). 
      chDocument:AppendItemValue( "agentCode",trim(wdetail.producer)).  
      chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
      chDocument:AppendItemValue( "model", nv_brand).
      chDocument:AppendItemValue( "modelCode", nv_model).
      chDocument:AppendItemValue( "carCC", trim(wdetail.chassis)).
      chDocument:AppendItemValue( "Year", trim(brstat.tlt.lince2)).           
      chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
      chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
      chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
      chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
      chDocument:AppendItemValue( "LicenseNo_2", trim(wdetail.province)).
      chDocument:AppendItemValue( "commentMK", trim(wdetail.remark)).
      chDocument:SAVE(TRUE,TRUE).
    RELEASE  OBJECT chitem          NO-ERROR.
    RELEASE  OBJECT chDocument      NO-ERROR.          
    RELEASE  OBJECT chNotesDataBase NO-ERROR.     
    RELEASE  OBJECT chNotesSession  NO-ERROR.

    ASSIGN brstat.tlt.model = "ISP:".
  END.*/
  /*comment by Kridtiya i. A63-00472
    chDocument:AppendItemValue( "BranchReq", "Business Unit 3").  ปรับแก้ไข จาก "Business Unit 3" เป็น nv_branchdesp
    chDocument:AppendItemValue( "BranchReq", nv_branchdesp ).
  comment by Kridtiya i. A63-00472  */
  
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_province C-Win 
PROCEDURE proc_province :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
        IF INDEX(wdetail.province,".") <> 0 THEN REPLACE(wdetail.province,".","").
/*1*/        IF wdetail.province = "ANG THONG"          THEN wdetail.province = "อท".
/*2*/   ELSE IF wdetail.province = "AYUTTHAYA"          THEN wdetail.province = "อย".
/*3*/   ELSE IF wdetail.province = "BKK"                THEN wdetail.province = "กท". 
/*3*/   ELSE IF wdetail.province = "BANGKOK"            THEN wdetail.province = "กท".
/*4*/   ELSE IF wdetail.province = "BURIRAM"            THEN wdetail.province = "บร".
/*5*/   ELSE IF wdetail.province = "CHAI NAT"           THEN wdetail.province = "ชน".
/*6*/   ELSE IF wdetail.province = "CHANTHABURI"        THEN wdetail.province = "จบ".
/*7*/   ELSE IF wdetail.province = "CHIANG MAI"         THEN wdetail.province = "ชม".
/*8*/   ELSE IF wdetail.province = "CHONBURI"           THEN wdetail.province = "ชบ".
/*9*/   ELSE IF wdetail.province = "KALASIN"            THEN wdetail.province = "กส".
/*10*/  ELSE IF wdetail.province = "KANCHANABURI"       THEN wdetail.province = "กจ".
/*11*/  ELSE IF wdetail.province = "KHON KAEN"          THEN wdetail.province = "ขก".
/*12*/  ELSE IF wdetail.province = "KRABI"              THEN wdetail.province = "กบ".
/*13*/  ELSE IF wdetail.province = "LOPBURI"            THEN wdetail.province = "ลบ".
/*14*/  ELSE IF wdetail.province = "NAKHON NAYOK"       THEN wdetail.province = "นย".
/*15*/  ELSE IF wdetail.province = "NAKHON PATHOM"      THEN wdetail.province = "นฐ".
/*16*/  ELSE IF wdetail.province = "NAKHON RATCHASIMA"  THEN wdetail.province = "นม".
/*17*/  ELSE IF wdetail.province = "NAKHON SITHAMMARAT" THEN wdetail.province = "นศ".
/*18*/  ELSE IF wdetail.province = "NONTHABURI"         THEN wdetail.province = "นบ".
/*19*/  ELSE IF wdetail.province = "PHETCHABURI"        THEN wdetail.province = "พบ".
/*20*/  ELSE IF wdetail.province = "PHUKET"             THEN wdetail.province = "ภก".
/*21*/  ELSE IF wdetail.province = "PHITSANULOK"        THEN wdetail.province = "พล".
/*22*/  ELSE IF wdetail.province = "PRACHINBURI"        THEN wdetail.province = "ปจ".
/*23*/  ELSE IF wdetail.province = "RATCHABURI"         THEN wdetail.province = "รบ".
/*24*/  ELSE IF wdetail.province = "RAYONG"             THEN wdetail.province = "รย".
/*25*/  ELSE IF wdetail.province = "ROI ET"             THEN wdetail.province = "รอ".
/*26*/  ELSE IF wdetail.province = "SARABURI"           THEN wdetail.province = "สบ".
/*27*/  ELSE IF wdetail.province = "SRISAKET"           THEN wdetail.province = "ศก".
/*28*/  ELSE IF wdetail.province = "SONGKHLA"           THEN wdetail.province = "สข".
/*29*/  ELSE IF wdetail.province = "SA KAEO"            THEN wdetail.province = "สก".
/*30*/  ELSE IF wdetail.province = "SUPHANBURI"         THEN wdetail.province = "สพ".
/*31*/  ELSE IF wdetail.province = "SURAT THANI"        THEN wdetail.province = "สฏ".
/*32*/  ELSE IF wdetail.province = "TRANG"              THEN wdetail.province = "ตง".
/*33*/  ELSE IF wdetail.province = "UBON RATCHATHANI"   THEN wdetail.province = "อบ".
/*34*/  ELSE IF wdetail.province = "UDON THANI"         THEN wdetail.province = "อด".
/*35*/  ELSE IF wdetail.province = "AMNAT CHAROEN"      THEN wdetail.province = "อจ".
/*36*/  ELSE IF wdetail.province = "CHAIYAPHUM"         THEN wdetail.province = "ชย".
/*37*/  ELSE IF wdetail.province = "CHIANG RAI"         THEN wdetail.province = "ชร".
/*38*/  ELSE IF wdetail.province = "CHUMPHON"           THEN wdetail.province = "ชพ".
/*39*/  ELSE IF wdetail.province = "KAMPHAENG PHET"     THEN wdetail.province = "กพ".
/*40*/  ELSE IF wdetail.province = "LAMPANG"            THEN wdetail.province = "ลป".
/*41*/  ELSE IF wdetail.province = "LAMPHUN"            THEN wdetail.province = "ลพ".
/*42*/  ELSE IF wdetail.province = "NAKHON SAWAN"       THEN wdetail.province = "นว".
/*43*/  ELSE IF wdetail.province = "NONG KHAI"          THEN wdetail.province = "นค".
/*44*/  ELSE IF wdetail.province = "PATHUM THANI"       THEN wdetail.province = "ปท".
/*45*/  ELSE IF wdetail.province = "PATTANI"            THEN wdetail.province = "ปน".
/*46*/  ELSE IF wdetail.province = "PHATTHALUNG"        THEN wdetail.province = "พท".
/*47*/  ELSE IF wdetail.province = "PHETCHABUN"         THEN wdetail.province = "พช".
/*48*/  ELSE IF wdetail.province = "SAKON NAKHON"       THEN wdetail.province = "สน".
/*49*/  ELSE IF wdetail.province = "SING BURI"          THEN wdetail.province = "สห".
/*50*/  ELSE IF wdetail.province = "SURIN"              THEN wdetail.province = "สร".
/*51*/  ELSE IF wdetail.province = "YASOTHON"           THEN wdetail.province = "ยส".
/*52*/  ELSE IF wdetail.province = "YALA"               THEN wdetail.province = "ยล".
/*53*/  ELSE IF wdetail.province = "BAYTONG"            THEN wdetail.province = "บต".
/*54*/  ELSE IF wdetail.province = "CHACHOENGSAO"       THEN wdetail.province = "ฉช".
/*55*/  ELSE IF wdetail.province = "LOEI"               THEN wdetail.province = "ลย".
/*56*/  ELSE IF wdetail.province = "MAE HONG SON"       THEN wdetail.province = "มส".
/*57*/  ELSE IF wdetail.province = "MAHA SARAKHAM"      THEN wdetail.province = "มค".
/*58*/  ELSE IF wdetail.province = "MUKDAHAN"           THEN wdetail.province = "มห".
/*59*/  ELSE IF wdetail.province = "NAN"                THEN wdetail.province = "นน".
/*60*/  ELSE IF wdetail.province = "NARATHIWAT"         THEN wdetail.province = "นธ".
/*61*/  ELSE IF wdetail.province = "NONG BUA LAMPHU"    THEN wdetail.province = "นภ".
/*62*/  ELSE IF wdetail.province = "PHAYAO"             THEN wdetail.province = "พย".  
/*63*/  ELSE IF wdetail.province = "PHANG NGA"          THEN wdetail.province = "พง".
/*64*/  ELSE IF wdetail.province = "PHRAE"              THEN wdetail.province = "พร".
/*65*/  ELSE IF wdetail.province = "PHICHIT"            THEN wdetail.province = "พจ".
/*66*/  ELSE IF wdetail.province = "PRACHUAP KHIRIKHAN" THEN wdetail.province = "ปข".
/*67*/  ELSE IF wdetail.province = "RANONG"             THEN wdetail.province = "รน".
/*68*/  ELSE IF wdetail.province = "SAMUT PRAKAN"       THEN wdetail.province = "สป".
/*69*/  ELSE IF wdetail.province = "SAMUT SAKHON"       THEN wdetail.province = "สค". 
/*70*/  ELSE IF wdetail.province = "SAMUT SONGKHRAM"    THEN wdetail.province = "สส".
/*71*/  ELSE IF wdetail.province = "SATUN"              THEN wdetail.province = "สต".
/*72*/  ELSE IF wdetail.province = "SUKHOTHAI"          THEN wdetail.province = "สท".
/*73*/  ELSE IF wdetail.province = "TAK"                THEN wdetail.province = "ตก".
/*74*/  ELSE IF wdetail.province = "TRAT"               THEN wdetail.province = "ตร".
/*75*/  ELSE IF wdetail.province = "UTHAI THANI"        THEN wdetail.province = "อน".
/*76*/  ELSE IF wdetail.province = "UTTARADIT"          THEN wdetail.province = "อต".
/*77*/  ELSE IF wdetail.province = "NAKHON PHANOM"      THEN wdetail.province = "นพ". 
/*78*/  ELSE IF wdetail.province = "BUENG KAN"          THEN wdetail.province = "บก". 
        ELSE IF wdetail.province = "กทม"                THEN wdetail.province = "กท".  /*a60-0095*/
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(wdetail.province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN wdetail.province = brstat.Insure.LName.
        END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 C-Win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create by kridtiya i. A53-0220*/
DEF VAR pv_conpara AS CHAR FORMAT "x(150)" INIT "".
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
  /*A68-0019*/ 
  FIND FIRST sicsyac.dbtable WHERE sicsyac.dbtable.phyname = "expiry"
      NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL sicsyac.dbtable THEN pv_conpara = sicsyac.dbtable.unixpara.
  ELSE pv_conpara = "". 
  pv_conpara = pv_conpara +    " -U " + gv_id + " -P " + nv_pwd.   
  /*A68-0019*/
  
  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
      /*CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) .  /*Production จริง*/*/
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) .     /*Production จริง*/*//*A62-0105*/
      /*CONNECT expiry -H devserver -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) .*/  /*db dev.*/  

      CONNECT VALUE(pv_conpara) NO-ERROR. /*A66-0266*/

      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

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
DEF input parameter nn_namelist   as char.    
DEF input parameter nn_namelist2  as char.    
DEF input parameter nn_vehreglist as char. 
DEF input parameter nv_chanolist  as char.
DEF INPUT-OUTPUT PARAMETER nv_msgstatus AS CHAR.
ASSIGN nv_msgstatus = "" .  
IF nn_vehreglist <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            nv_CheckLog  = "YES"
            nv_msgstatus = nv_msgstatus + "|รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน"  .
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN nv_CheckLog  = "YES"
            nv_msgstatus = nv_msgstatus + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN nv_CheckLog  = "YES"
                nv_msgstatus = nv_msgstatus + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" .
        END.
    END.
END.
IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN nv_CheckLog  = "YES"
            nv_msgstatus = nv_msgstatus + "|รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" .
    END.
END. 
IF nv_msgstatus <> "" THEN MESSAGE nv_msgstatus VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_chkfile C-Win 
PROCEDURE pro_chkfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  backup pro_chkfilebk1  and new pro_chkfile by     /*A68-0019*/  
------------------------------------------------------------------------------*/
DEF VAR n_pol       AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt     AS INT INIT 0.
DEF VAR n_encnt     AS INT INIT 0.
DEF VAR n_rev       AS INT INIT 0. 
DEF VAR n_revday    AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_cc        AS CHAR FORMAT "x(3)" INIT "".    
DEF VAR n_model     AS CHAR FORMAT "x(2)" INIT "".    
DEF VAR n_model1    AS CHAR FORMAT "x(5)" INIT "".    
FOR EACH wdetail.
    IF TRIM(wdetail.tpis_no) = ""  THEN NEXT . /*DELETE wdetail.*/
    ELSE DO:
        ASSIGN re_class        = ""       re_producerexp  = ""      re_covcod       = ""       re_dealerexp    = ""  re_model = "" /*A68-0019*/      
               re_si           = ""       re_year         = ""      re_baseprm      = 0        re_chassic      = ""   
               re_expdat       = ""       n_cc            = ""      n_model         = ""       np_garage = ""   /*A66-0084*/
               np_garage = IF trim(wdetail.garage) = "ซ่อมห้าง" THEN "ซ่อมอู่ห้าง" ELSE "ซ่อมอู่ประกัน"  /*A66-0084*/ 
               wdetail.np_f18line4 = wdetail.garage . /*A62-0422*/
        wdetail.nDirec = REPLACE(wdetail.nDirec,"TIL-HO","").
        RUN proc_chkdealer.
        RUN proc_cutpol72.
        IF wdetail.com_no <> "" THEN wdetail.stkno = TRIM(wdetail.com_no) .
        IF TRIM(wdetail.License) <> "" THEN DO:
            RUN proc_chkLicense.
        END.
        IF TRIM(wdetail.regis_CL) <> "" THEN DO:
          FIND FIRST brstat.insure USE-INDEX Insure03   WHERE 
            brstat.insure.compno = "999"    AND 
            brstat.insure.fname  = trim(wdetail.regis_CL)  NO-LOCK NO-WAIT NO-ERROR.
          IF AVAIL brstat.insure THEN DO:
              ASSIGN wdetail.regis_CL = trim(Insure.LName).
          END.
        END.
        ELSE ASSIGN  wdetail.regis_CL =  "".
        ASSIGN fi_process   = "Check data Old Policy............".    /*A56-0262*/
        DISP fi_process WITH FRAM fr_main.
        IF trim(wdetail.chasno) <> "" AND INDEX(wdetail.typ_work,"V") <> 0 AND 
          index(wdetail.deler,"Refinance") = 0  THEN DO:  /*A61-0152*/
            RUN proc_chkprvpol.   /*A68-0019*/
        END.
        ELSE DO:
            ASSIGN  wdetail.prvpol = "".
        END.
        IF TRIM(wdetail.prvpol) <> ""  THEN  DO:
            IF substr(TRIM(wdetail.prvpol),1,1) = "D" THEN ASSIGN wdetail.branch = substr(TRIM(wdetail.prvpol),2,1).
            ELSE ASSIGN wdetail.branch = substr(TRIM(wdetail.prvpol),1,2).
        END.
        ELSE DO:
            /*A68-0019
          FIND FIRST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.compno = "TPIS"             AND    
              stat.insure.fname  = wdetail.deler     AND
              stat.insure.lname  = wdetail.showroom  NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL stat.insure THEN DO: 
              ASSIGN wdetail.branch  = stat.insure.branch  . 
          END.
          ELSE DO: */  /*A68-0019*/
              IF wdetail.deler <> "" THEN DO:
                  IF index(wdetail.deler,"Refinance") <> 0 THEN RUN proc_chkbrRefin.   /*A68-0019*/
                  ELSE IF INDEX(wdetail.deler,"ISUZU NONGBUALUMPHO") <> 0    OR INDEX(wdetail.deler,"ISUZU UDONTHANI(2018)") <> 0 OR 
                          INDEX(wdetail.deler,"HIAB NGUAN ISUZU SALES") <> 0 OR INDEX(wdetail.deler,"HIAB NGUAN MILLER") <> 0 THEN
                       ASSIGN wdetail.branch  = "S" . 
                  ELSE ASSIGN wdetail.branch  = "M" . 
              END.    /*A68-0019*/
              ELSE ASSIGN wdetail.branch  = "M" . 
          /*END. *//*A68-0019*/
        END.
        IF trim(wdetail.cust_type) = "J" AND TRIM(wdetail.icno) <> "" THEN DO:
            IF LENGTH(TRIM(wdetail.icno)) < 13 THEN ASSIGN wdetail.icno = "0" + TRIM(wdetail.icno) .
        END.
        IF trim(wdetail.cover) = "2+" THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF trim(wdetail.cover) = "3+" THEN ASSIGN wdetail.cover = "3.2" .
        ELSE ASSIGN wdetail.cover = TRIM(wdetail.cover).
        IF INT(wdetail.cc) = 0 AND wdetail.chasno <> "" THEN DO:
            n_cc = trim(SUBSTR(wdetail.chasno,7,2)).
            IF n_cc = "85"  THEN wdetail.cc = "3000".
            ELSE IF n_cc = "86" THEN wdetail.cc = "2500".
            ELSE wdetail.cc = "1900" .
        END.
        RUN pro_chkmodel.
        IF wdetail.CLASS = "" THEN DO:
            IF DECI(wdetail.com_netprem) = 600 THEN ASSIGN wdetail.CLASS = "110" .
            ELSE wdetail.CLASS = "" .
        END.
        IF trim(wdetail.prvpol) <> "" THEN DO: /* มีกรมธรรม์เดิม */
            ASSIGN wdetail.producer = "A000324" /*TRIM(fi_producer)*/
                   re_class   = ""      re_covcod  = ""     re_si      = ""      re_baseprm = 0 
                   re_expdat  = ""      re_year    = ""     re_chassic = ""      re_rencnt  = 0.
            IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
            IF  CONNECTED("sic_exp") THEN DO:
                ASSIGN re_producerexp = ""   /*A63-00472*/ 
                       re_dealerexp   = ""   /*A63-00472*/
                       re_model       = "" .  /*A68-0019*/
                RUN wgw\wgwchktil (INPUT-OUTPUT  wdetail.prvpol,               
                                   INPUT-OUTPUT  wdetail.branch, 
                                   INPUT-OUTPUT  re_producerexp,
                                   INPUT-OUTPUT  re_dealerexp,
                                   INPUT-OUTPUT  re_class ,
                                   INPUT-OUTPUT  re_covcod,
                                   INPUT-OUTPUT  re_si     ,                          
                                   INPUT-OUTPUT  re_baseprm,
                                   input-output  re_expdat ,
                                   INPUT-OUTPUT  re_year  ,  
                                   INPUT-OUTPUT  re_chassic,
                                   INPUT-OUTPUT  re_rencnt,
                                   INPUT-OUTPUT  re_model).  /*A68-0019*/
                /*A63-00472*/
                IF wdetail.prvpol <> "" AND re_producerexp = "" THEN DO: 
                    ASSIGN  wdetail.np_f18line6 = wdetail.np_f18line6 + " /ไม่พบรหัส Producer ที่ระบบ Expiry"
                            wdetail.err         = wdetail.err + "/ ไม่พบรหัส Producer ที่ระบบ Expiry".
                END.
                IF wdetail.prvpol <> "" AND re_dealerexp   = "" THEN DO: 
                    ASSIGN  wdetail.np_f18line6 = wdetail.np_f18line6 + " /ไม่พบรหัส Dealer ที่ระบบ Expiry"
                            wdetail.err         = wdetail.err + "/ ไม่พบรหัส Dealer ที่ระบบ Expiry".
                END.
                IF wdetail.prvpol <> "" AND re_producerexp <> "" AND re_dealerexp <> ""  THEN DO:
                    IF trim(re_producerexp) = "B3MF101980"  THEN DO:
                        FIND LAST stat.insure USE-INDEX insure01 WHERE 
                            stat.insure.compno = "TPIS"             AND   
                            stat.insure.insno =  re_dealerexp  NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL stat.insure THEN  ASSIGN wdetail.branch =   trim(stat.Insure.Branch).
                    END.
                END.
                IF wdetail.prvpol <> "" AND  index(re_model,wdetail.model) = 0  THEN 
                    ASSIGN wdetail.np_f18line6 = "Model ไม่ตรง"
                    wdetail.err  = wdetail.err + "/Model ไม่ตรง ที่ระบบ Expiry".
                /*A63-00472*/
                IF re_class = "" AND re_covcod = "" AND re_si = "" AND re_baseprm = 0 THEN DO: 
                    ASSIGN  wdetail.np_f18line6 = "ไม่มีขอ้มูลที่ระบบ Expiry"
                            wdetail.err         = wdetail.err + "/ ไม่มีขอ้มูลที่ระบบ Expiry".
                END.
                ELSE DO:
                    IF INDEX(re_class,wdetail.CLASS) <> 0 THEN DO:
                        ASSIGN wdetail.np_f18line6 = "Class ตรง" 
                               wdetail.CLASS        = re_class .
                    END.
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = "Class ไม่ตรง"
                               wdetail.err         = wdetail.err + "/ Class ไม่ตรง". 
                    END.
                    IF trim(wdetail.cover) = TRIM(re_covcod)  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /Cover ตรง".
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /Cover ไม่ตรง"
                               wdetail.err         = wdetail.err + "/ Cover ไม่ตรง". 
                    END.

                    IF DECI(wdetail.si) = deci(re_si)  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /SI ตรง".
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /SI ไม่ตรง"
                               wdetail.err         = wdetail.err + "/ SI ไม่ตรง".
                    END.
                    IF DECI(wdetail.pol_netprem) = re_baseprm  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /เบี้ยตรง".
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /เบี้ยไม่ตรง " + wdetail.pol_netprem .
                               wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรง".
                    END.

                    IF YEAR(date(re_expdat)) < YEAR(TODAY) THEN DO:
                        ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat 
                               wdetail.err         = wdetail.err + "/ กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน".
                    END.
                    ELSE DO:
                        IF MONTH(date(re_expdat)) <= MONTH(date(wdetail.pol_comm_date)) THEN DO:
                            IF MONTH(date(re_expdat)) = MONTH(date(wdetail.pol_comm_date)) THEN DO:
                                IF DAY(date(re_expdat)) < (DAY(date(wdetail.pol_comm_date)) - 1 ) THEN DO:
                                   ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat 
                                          wdetail.err         = wdetail.err + "/ กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน".
                                END.
                            END.
                            ELSE DO:
                                ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat 
                                       wdetail.err         = wdetail.err + "/ กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน". 
                            END.
                        END.
                    END.
                    IF trim(wdetail.md_year) = TRIM(re_year)  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /ปีรถตรงกัน".
                    ELSE DO:
                        ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /ปีรถไม่ตรงกัน " + re_year 
                               wdetail.err         =  wdetail.err + "|ปีรถไม่ตรงกัน".
                    END.
                    IF TRIM(wdetail.chasno) = TRIM(re_chassic) THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /เลขตัวถังตรงกัน".
                    ELSE DO:
                        ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /เลขตัวถังไม่ตรงกัน " + re_chassic 
                               wdetail.err         =  wdetail.err + "/ เลขตัวถังไม่ตรงกัน".
                    END.
                    IF ( re_rencnt + 1 ) < 2  AND (re_dealerexp <> "B3M0034" OR re_dealerexp <> "A000324") THEN ASSIGN wdetail.np_f18line5 = "First Year" .
                    ELSE ASSIGN wdetail.np_f18line5 = "Other Year" .
                END.
                ASSIGN  re_class = ""      re_covcod = ""        re_si = ""      re_baseprm = 0 .
            END.
        END.
        ELSE DO: /* ไม่มีกรมธรรม์เดิม */
            IF index(wdetail.deler,"Refinance") <> 0 THEN ASSIGN wdetail.producer = "B3M0034".
            ELSE if index(wdetail.deler,"UsedCar") <> 0  THEN ASSIGN wdetail.producer = "B3M0034".
            ELSE if index(wdetail.deler,"Used Car") <> 0 THEN ASSIGN wdetail.producer = "B3M0034".
            ELSE IF trim(wdetail.typ_work) = "C" THEN ASSIGN wdetail.producer = "A000324".
            ELSE ASSIGN wdetail.producer = "A000324".
            IF DECI(wdetail.pol_netprem) <> 0 AND TRIM(wdetail.cover) <> "2"  THEN DO:
                /* A66-0084 */
                IF TRIM(wdetail.cover) = "1" THEN DO:
                   IF wdetail.brand <> "ISUZU" THEN DO:
                        FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                                  brstat.insure.compno      = "TPIS_RE"           AND 
                                  index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                                  brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                                  deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                                  trim(brstat.insure.Text2) = trim(np_garage)           AND 
                                  TRIM(brstat.insure.icno)  <> "ISUZU"  NO-LOCK NO-ERROR.
                   END.
                   ELSE DO:
                       FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                              brstat.insure.compno      = "TPIS_RE"           AND 
                              index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                              brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                              deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                              trim(brstat.insure.Text2) = trim(np_garage)           AND 
                              TRIM(brstat.insure.icno)  = "ISUZU"  NO-LOCK NO-ERROR.

                       IF NOT AVAIL brstat.insure THEN DO:
                           FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                              brstat.insure.compno      = "TPIS_RE"           AND 
                              index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                              brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                              deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                              trim(brstat.insure.Text2) = trim(np_garage)    NO-LOCK NO-ERROR.
                       END.
                   END.
                END.
                ELSE DO: /* end A66-0084*/
                  FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                         brstat.insure.compno      = "TPIS_RE"            AND 
                         index(brstat.insure.Text3,wdetail.class) <> 0        AND  
                         brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                         deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) NO-LOCK NO-ERROR.
                END.
                IF AVAIL brstat.insure THEN DO:
                    ASSIGN wdetail.CLASS       = TRIM(brstat.insure.Text3) 
                           wdetail.campens     = trim(brstat.insure.Text1)
                           wdetail.np_f18line4 = TRIM(brstat.insure.Text2)
                           wdetail.np_f18line6 = "เบี้ยตรงกับแคมเปญ"
                           wdetail.product     = IF TRIM(brstat.insure.icaddr2) <> "" THEN TRIM(brstat.insure.icaddr2) + "_" + trim(brstat.insure.Text1) 
                                                  ELSE trim(brstat.insure.Text1). /*A65-0177*/
                END.
                ELSE ASSIGN wdetail.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail.pol_netprem
                             wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรงกับแคมเปญ" .

            END.
            IF TRIM(wdetail.cover) = "2"  THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = "TPIS_RE"           AND 
                           index(brstat.insure.Text3,wdetail.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail.cover)      AND
                           deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) NO-LOCK NO-ERROR.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail.np_f18line4 = trim(brstat.insure.Text1) 
                            wdetail.np_f18line6 = "เบี้ยตรงกับแคมเปญ".
                 END.
                 ELSE ASSIGN wdetail.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail.pol_netprem 
                             wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรงกับแคมเปญ" .
            END.
            IF index(wdetail.deler,"Refinance") <> 0 THEN ASSIGN wdetail.np_f18line5 = "Refinence". 
            ELSE IF index(wdetail.deler,"Used Car") <> 0 THEN ASSIGN wdetail.np_f18line5 = "Used Car".
            ELSE IF index(wdetail.deler,"UsedCar")  <> 0 THEN ASSIGN wdetail.np_f18line5 = "Used Car".
            ELSE ASSIGN wdetail.np_f18line5 = "Switch".
        END.
        RUN pro_chkfile2.
    END.
    RELEASE stat.insure.
    RELEASE brstat.tlt.
    RELEASE sicuw.uwm301.
    RELEASE sicuw.uwm100.
END.
IF CONNECTED("sic_exp") THEN DISCONNECT  sic_exp.
ASSIGN fi_process   = "Check data Expiry complete ......".     
DISP fi_process WITH FRAM fr_main.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_chkfile2 C-Win 
PROCEDURE pro_chkfile2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF wdetail.np_f18line6 = "ไม่มีขอ้มูลที่ระบบ Expiry" THEN DO:   /* ไม่มีที่ใบเตือน */
        IF index(wdetail.deler,"Refinance") <> 0 THEN ASSIGN wdetail.producer = "B3M0034".
        ELSE if index(wdetail.deler,"UsedCar") <> 0  THEN ASSIGN wdetail.producer = "B3M0034".
        ELSE if index(wdetail.deler,"Used Car") <> 0 THEN ASSIGN wdetail.producer = "B3M0034".
        ELSE IF trim(wdetail.typ_work) = "C" THEN ASSIGN wdetail.producer = "A000324".
        ELSE ASSIGN wdetail.producer = "A000324".

        IF DECI(wdetail.pol_netprem) <> 0 AND TRIM(wdetail.cover) <> "2"  THEN DO:
             /* A66-0084 */
            IF TRIM(wdetail.cover) = "1" THEN DO:
               IF wdetail.brand <> "ISUZU" THEN DO:
                    FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                              brstat.insure.compno      = "TPIS_RE"           AND 
                              index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                              brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                              deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                              trim(brstat.insure.Text2) = trim(np_garage)           AND 
                              TRIM(brstat.insure.icno)  <> "ISUZU"  NO-LOCK NO-ERROR.
               END.
               ELSE DO:
                   FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                          brstat.insure.compno      = "TPIS_RE"           AND 
                          index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                          brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                          deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                          trim(brstat.insure.Text2) = trim(np_garage)           AND 
                          TRIM(brstat.insure.icno)  = "ISUZU"  NO-LOCK NO-ERROR.
                   IF NOT AVAIL brstat.insure THEN DO:
                        FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                          brstat.insure.compno      = "TPIS_RE"           AND 
                          index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                          brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                          deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                          trim(brstat.insure.Text2) = trim(np_garage)           NO-LOCK NO-ERROR.
                   END.
               END. 
            END.
            ELSE DO: /* end A66-0084*/
             FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                       brstat.insure.compno      = "TPIS_RE"            AND 
                       index(brstat.insure.Text3,wdetail.class) <> 0        AND  
                       brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                       deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) NO-LOCK NO-ERROR.
            END.
             IF AVAIL brstat.insure THEN DO:
                 ASSIGN wdetail.CLASS       = TRIM(brstat.insure.Text3) 
                        wdetail.campens    = trim(brstat.insure.Text1)
                        wdetail.np_f18line4 = TRIM(brstat.insure.Text2)
                        wdetail.np_f18line6 = wdetail.np_f18line6 + " /เบี้ยตรงกับแคมเปญ " 
                        wdetail.product     = IF TRIM(brstat.insure.icaddr2) <> "" THEN TRIM(brstat.insure.icaddr2) + "_" + trim(brstat.insure.Text1) 
                                               ELSE trim(brstat.insure.Text1). /*A65-0177*/
             END.
             ELSE ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /เบี้ยไม่ตรงกับแคมเปญ " + wdetail.pol_netprem 
                         wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรงกับแคมเปญ" .
        END.
        IF TRIM(wdetail.cover) = "2"  THEN DO:
             FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                       brstat.insure.compno      = "TPIS_RE"            AND 
                       index(brstat.insure.Text3,wdetail.class) <> 0        AND  
                       brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                       deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) NO-LOCK NO-ERROR.
             IF AVAIL brstat.insure THEN DO:
                 ASSIGN wdetail.CLASS       = TRIM(brstat.insure.Text3) 
                        wdetail.np_f18line4 = trim(brstat.insure.Text1) 
                        wdetail.np_f18line6 = wdetail.np_f18line6 + " /เบี้ยตรงกับแคมเปญ ".
             END.
             ELSE ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /เบี้ยไม่ตรงกับแคมเปญ " + wdetail.pol_netprem  
                         wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรงกับแคมเปญ" .
        END.
        IF index(wdetail.deler,"Refinance") <> 0 THEN ASSIGN wdetail.np_f18line5 = "Refinence". 
        ELSE IF index(wdetail.deler,"Used Car") <> 0 THEN ASSIGN wdetail.np_f18line5 = "Used Car".
        ELSE IF index(wdetail.deler,"UsedCar")  <> 0 THEN ASSIGN wdetail.np_f18line5 = "Used Car".
        ELSE ASSIGN wdetail.np_f18line5 = "Switch".
    END.
    /* ---end : A61-0152---*/         
    IF TRIM(wdetail.financename) = "Cash" THEN ASSIGN wdetail.financename = " ". 
    IF wdetail.financename <> " "  THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno = "TPIS-LEAS"        AND 
                                 stat.insure.fname = wdetail.financename   OR
                                 stat.insure.lname = wdetail.financename   NO-LOCK NO-ERROR . 
         IF AVAIL stat.insure THEN
             ASSIGN wdetail.financename = stat.insure.addr1 + stat.insure.addr2.
         ELSE 
             ASSIGN wdetail.financename = "error : " + wdetail.financename.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_chkfilebk1 C-Win 
PROCEDURE pro_chkfilebk1 :
DEF VAR n_pol       AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_recnt     AS INT INIT 0.
DEF VAR n_encnt     AS INT INIT 0.
DEF VAR n_rev       AS INT INIT 0. 
DEF VAR n_revday    AS CHAR FORMAT "x(15)" INIT "".
DEF VAR n_cc        AS CHAR FORMAT "x(3)" INIT "".    /*a61-0152*/
DEF VAR n_model     AS CHAR FORMAT "x(2)" INIT "".    /*a61-0152*/
DEF VAR n_model1    AS CHAR FORMAT "x(5)" INIT "".    /*a61-0152*/
FOR EACH wdetail.
    IF TRIM(wdetail.tpis_no) = ""  THEN NEXT . /*DELETE wdetail.*/
    ELSE DO:
        ASSIGN re_class        = ""       re_producerexp  = ""      re_covcod       = ""       re_dealerexp    = ""  re_model = "" /*A68-0019*/      
               re_si           = ""       re_year         = ""      re_baseprm      = 0        re_chassic      = ""   
               re_expdat       = ""       n_cc            = ""      n_model         = ""       np_garage = ""   /*A66-0084*/
               np_garage = IF trim(wdetail.garage) = "ซ่อมห้าง" THEN "ซ่อมอู่ห้าง" ELSE "ซ่อมอู่ประกัน"  /*A66-0084*/ 
               wdetail.np_f18line4 = wdetail.garage . /*A62-0422*/
        wdetail.nDirec = REPLACE(wdetail.nDirec,"TIL-HO","").
        RUN proc_chkdealer.
        RUN proc_cutpol72.
        IF wdetail.com_no <> "" THEN wdetail.stkno = TRIM(wdetail.com_no) .
        IF TRIM(wdetail.License) <> "" THEN DO:
            /*IF R-INDEX(wdetail.License," ") <> 0 THEN
                    ASSIGN wdetail.License = trim(SUBSTR(trim(wdetail.License),1,INDEX(trim(wdetail.License)," "))) + " " +
                                             trim(SUBSTR(trim(wdetail.License),INDEX(trim(wdetail.License)," "))). */
            RUN proc_chkLicense.
        END.
        IF TRIM(wdetail.regis_CL) <> "" THEN DO:
          FIND FIRST brstat.insure USE-INDEX Insure03   WHERE 
            brstat.insure.compno = "999"    AND 
            brstat.insure.fname  = trim(wdetail.regis_CL)  NO-LOCK NO-WAIT NO-ERROR.
          IF AVAIL brstat.insure THEN DO:
              ASSIGN wdetail.regis_CL = trim(Insure.LName).
          END.
        END.
        ELSE ASSIGN  wdetail.regis_CL =  "".
        ASSIGN fi_process   = "Check data Old Policy............".    /*A56-0262*/
        DISP fi_process WITH FRAM fr_main.
        /*IF trim(wdetail.chasno) <> "" AND INDEX(wdetail.typ_work,"V") <> 0  THEN DO:*/  /*A61-0152*/
        IF trim(wdetail.chasno) <> "" AND INDEX(wdetail.typ_work,"V") <> 0 AND 
          index(wdetail.deler,"Refinance") = 0  THEN DO:  /*A61-0152*/
            /*A68-0019 
            FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail.chasno)) AND 
                sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                ASSIGN  n_pol   = ""
                    n_recnt = 0
                    n_encnt = 0
                    n_pol   = sicuw.uwm301.policy 
                    n_recnt = sicuw.uwm301.rencnt 
                    n_encnt = sicuw.uwm301.endcnt .
                FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                    sicuw.uwm100.policy = n_pol     AND
                    sicuw.uwm100.rencnt = n_recnt   AND
                    sicuw.uwm100.endcnt = n_encnt  NO-LOCK NO-ERROR .
                IF AVAIL sicuw.uwm100 THEN
                    IF sicuw.uwm100.renpol = "" THEN ASSIGN wdetail.prvpol = sicuw.uwm100.policy.
                    ELSE  ASSIGN wdetail.prvpol = sicuw.uwm100.policy + " ต่ออายุแล้ว "
                            wdetail.err    = wdetail.err + "/" + sicuw.uwm100.policy + " ต่ออายุแล้ว".
                    ELSE  ASSIGN wdetail.prvpol = "".
            END.
            ELSE DO: 
                ASSIGN  wdetail.prvpol = "".
            END.
             A68-0019*/
            RUN proc_chkprvpol.   /*A68-0019*/
        END.
        ELSE DO:
            ASSIGN  wdetail.prvpol = "".
        END.
        IF TRIM(wdetail.prvpol) <> ""  THEN  DO:
            IF substr(TRIM(wdetail.prvpol),1,1) = "D" THEN ASSIGN wdetail.branch = substr(TRIM(wdetail.prvpol),2,1).
            ELSE ASSIGN wdetail.branch = substr(TRIM(wdetail.prvpol),1,2).
        END.
        ELSE DO:
          FIND FIRST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.compno = "TPIS"             AND    
              stat.insure.fname  = wdetail.deler     AND
              stat.insure.lname  = wdetail.showroom  NO-LOCK NO-ERROR NO-WAIT.
          IF AVAIL stat.insure THEN DO: 
              ASSIGN wdetail.branch  = stat.insure.branch  . 
          END.
          ELSE DO:   /*A68-0019*/
              IF wdetail.deler <> "" THEN DO:
                  IF index(wdetail.deler,"Refinance") <> 0 THEN RUN proc_chkbrRefin.   /*A68-0019*/
                  ELSE IF INDEX(wdetail.deler,"ISUZU NONGBUALUMPHO") <> 0    OR INDEX(wdetail.deler,"ISUZU UDONTHANI(2018)") <> 0 OR 
                      INDEX(wdetail.deler,"HIAB NGUAN ISUZU SALES") <> 0 OR INDEX(wdetail.deler,"HIAB NGUAN MILLER") <> 0 THEN
                       ASSIGN wdetail.branch  = "S" . 
                  ELSE ASSIGN wdetail.branch  = "M" . 
              END.    /*A68-0019*/
              ELSE ASSIGN wdetail.branch  = "M" . 
          END.
        END.
        IF trim(wdetail.cust_type) = "J" AND TRIM(wdetail.icno) <> "" THEN DO:
            IF LENGTH(TRIM(wdetail.icno)) < 13 THEN ASSIGN wdetail.icno = "0" + TRIM(wdetail.icno) .
        END.
        IF trim(wdetail.cover) = "2+" THEN ASSIGN wdetail.cover = "2.2" .
        ELSE IF trim(wdetail.cover) = "3+" THEN ASSIGN wdetail.cover = "3.2" .
        ELSE ASSIGN wdetail.cover = TRIM(wdetail.cover).
        IF INT(wdetail.cc) = 0 AND wdetail.chasno <> "" THEN DO:
            n_cc = trim(SUBSTR(wdetail.chasno,7,2)).
            IF n_cc = "85"  THEN wdetail.cc = "3000".
            ELSE IF n_cc = "86" THEN wdetail.cc = "2500".
            ELSE wdetail.cc = "1900" .
        END.
        IF trim(wdetail.chasno) <> ""  THEN DO:
            n_model = trim(SUBSTR(wdetail.chasno,9,1)) . 
            n_model1 = trim(SUBSTR(wdetail.chasno,7,5)) .  /*A62-0110*/
            IF n_model = "G" THEN wdetail.model = "MU-X".
            ELSE IF n_model = "H" THEN wdetail.model = "MU-7".
            /*ELSE wdetail.model = "D-MAX" .*/ /*A61-0416*/
            ELSE IF wdetail.brand = "ISUZU"  THEN  DO:
                IF n_model1 = "85HBT" THEN wdetail.model = "MU-7". /*A62-0110*/
                ELSE IF TRIM(wdetail.bus_typ) = "CV" THEN wdetail.model = wdetail.model. 
                ELSE  wdetail.model = "D-MAX" . /*A61-0416*/  
            END.
            ELSE wdetail.model = trim(wdetail.model) . /*A61-0416*/
        END.
        
        IF wdetail.CLASS = "" THEN DO:
            IF DECI(wdetail.com_netprem) = 600 THEN ASSIGN wdetail.CLASS = "110" .
            ELSE wdetail.CLASS = "" .
        END.
        IF trim(wdetail.prvpol) <> "" THEN DO: /* มีกรมธรรม์เดิม */
            ASSIGN wdetail.producer = "A000324" /*TRIM(fi_producer)*/
                   re_class   = ""      re_covcod  = ""     re_si      = ""      re_baseprm = 0 
                   re_expdat  = ""      re_year    = ""     re_chassic = ""      re_rencnt  = 0.
            IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
            IF  CONNECTED("sic_exp") THEN DO:
                ASSIGN re_producerexp = ""   /*A63-00472*/ 
                       re_dealerexp   = ""   /*A63-00472*/
                       re_model       = "" .  /*A68-0019*/
                RUN wgw\wgwchktil (INPUT-OUTPUT  wdetail.prvpol,               
                                   INPUT-OUTPUT  wdetail.branch, 
                                   INPUT-OUTPUT  re_producerexp,
                                   INPUT-OUTPUT  re_dealerexp,
                                   INPUT-OUTPUT  re_class ,
                                   INPUT-OUTPUT  re_covcod,
                                   INPUT-OUTPUT  re_si     ,                          
                                   INPUT-OUTPUT  re_baseprm,
                                   input-output  re_expdat ,
                                   INPUT-OUTPUT  re_year  ,  
                                   INPUT-OUTPUT  re_chassic,
                                   INPUT-OUTPUT  re_rencnt,
                                   INPUT-OUTPUT  re_model).  /*A68-0019*/
                /*A63-00472*/
                IF wdetail.prvpol <> "" AND re_producerexp = "" THEN DO: 
                    ASSIGN  wdetail.np_f18line6 = wdetail.np_f18line6 + " /ไม่พบรหัส Producer ที่ระบบ Expiry"
                            wdetail.err         = wdetail.err + "/ ไม่พบรหัส Producer ที่ระบบ Expiry".
                END.
                IF wdetail.prvpol <> "" AND re_dealerexp   = "" THEN DO: 
                    ASSIGN  wdetail.np_f18line6 = wdetail.np_f18line6 + " /ไม่พบรหัส Dealer ที่ระบบ Expiry"
                            wdetail.err         = wdetail.err + "/ ไม่พบรหัส Dealer ที่ระบบ Expiry".
                END.
                IF wdetail.prvpol <> "" AND re_producerexp <> "" AND re_dealerexp <> ""  THEN DO:
                    IF trim(re_producerexp) = "B3MF101980"  THEN DO:
                        FIND LAST stat.insure USE-INDEX insure01 WHERE 
                            stat.insure.compno = "TPIS"             AND   
                            stat.insure.insno =  re_dealerexp  NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL stat.insure THEN  ASSIGN wdetail.branch =   trim(stat.Insure.Branch).
                    END.
                END.
                IF wdetail.prvpol <> "" AND  index(re_model,wdetail.model) = 0  THEN 
                    ASSIGN wdetail.np_f18line6 = "Model ไม่ตรง"
                    wdetail.err  = wdetail.err + "/Model ไม่ตรง ที่ระบบ Expiry".
                /*A63-00472*/
                IF re_class = "" AND re_covcod = "" AND re_si = "" AND re_baseprm = 0 THEN DO: 
                    ASSIGN  wdetail.np_f18line6 = "ไม่มีขอ้มูลที่ระบบ Expiry"
                            wdetail.err         = wdetail.err + "/ ไม่มีขอ้มูลที่ระบบ Expiry".
                END.
                ELSE DO:
                    IF INDEX(re_class,wdetail.CLASS) <> 0 THEN DO:
                        ASSIGN wdetail.np_f18line6 = "Class ตรง" 
                               wdetail.CLASS        = re_class .
                    END.
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = "Class ไม่ตรง"
                               wdetail.err         = wdetail.err + "/ Class ไม่ตรง". 
                    END.
                    IF trim(wdetail.cover) = TRIM(re_covcod)  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /Cover ตรง".
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /Cover ไม่ตรง"
                               wdetail.err         = wdetail.err + "/ Cover ไม่ตรง". 
                    END.

                    IF DECI(wdetail.si) = deci(re_si)  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /SI ตรง".
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /SI ไม่ตรง"
                               wdetail.err         = wdetail.err + "/ SI ไม่ตรง".
                    END.
                    IF DECI(wdetail.pol_netprem) = re_baseprm  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /เบี้ยตรง".
                    ELSE DO: 
                        ASSIGN wdetail.np_f18line6 = wdetail.np_f18line6 + " /เบี้ยไม่ตรง " + wdetail.pol_netprem .
                               wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรง".
                    END.

                    IF YEAR(date(re_expdat)) < YEAR(TODAY) THEN DO:
                        ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat 
                               wdetail.err         = wdetail.err + "/ กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน".
                    END.
                    ELSE DO:
                        IF MONTH(date(re_expdat)) <= MONTH(date(wdetail.pol_comm_date)) THEN DO:
                            IF MONTH(date(re_expdat)) = MONTH(date(wdetail.pol_comm_date)) THEN DO:
                                IF DAY(date(re_expdat)) < (DAY(date(wdetail.pol_comm_date)) - 1 ) THEN DO:
                                   ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat 
                                          wdetail.err         = wdetail.err + "/ กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน".
                                END.
                            END.
                            ELSE DO:
                                ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน  Exp:" + re_expdat 
                                       wdetail.err         = wdetail.err + "/ กรมธรรม์ขาดต่ออายุมากกว่า 1 วัน". 
                            END.
                        END.
                    END.
                    IF trim(wdetail.md_year) = TRIM(re_year)  THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /ปีรถตรงกัน".
                    ELSE DO:
                        ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /ปีรถไม่ตรงกัน " + re_year 
                               wdetail.err         =  wdetail.err + "|ปีรถไม่ตรงกัน".
                    END.
                    IF TRIM(wdetail.chasno) = TRIM(re_chassic) THEN ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /เลขตัวถังตรงกัน".
                    ELSE DO:
                        ASSIGN wdetail.np_f18line6 =  wdetail.np_f18line6 + " /เลขตัวถังไม่ตรงกัน " + re_chassic 
                               wdetail.err         =  wdetail.err + "/ เลขตัวถังไม่ตรงกัน".
                    END.
                    IF ( re_rencnt + 1 ) < 2  AND (re_dealerexp <> "B3M0034" OR re_dealerexp <> "A000324") THEN ASSIGN wdetail.np_f18line5 = "First Year" .
                    ELSE ASSIGN wdetail.np_f18line5 = "Other Year" .
                END.
                ASSIGN  re_class = ""      re_covcod = ""        re_si = ""      re_baseprm = 0 .
            END.
        END.
        ELSE DO: /* ไม่มีกรมธรรม์เดิม */
            IF index(wdetail.deler,"Refinance") <> 0 THEN ASSIGN wdetail.producer = "B3M0034".
            ELSE if index(wdetail.deler,"UsedCar") <> 0  THEN ASSIGN wdetail.producer = "B3M0034".
            ELSE if index(wdetail.deler,"Used Car") <> 0 THEN ASSIGN wdetail.producer = "B3M0034".
            ELSE IF trim(wdetail.typ_work) = "C" THEN ASSIGN wdetail.producer = "A000324".
            ELSE ASSIGN wdetail.producer = "A000324".
            IF DECI(wdetail.pol_netprem) <> 0 AND TRIM(wdetail.cover) <> "2"  THEN DO:
                /* A66-0084 */
                IF TRIM(wdetail.cover) = "1" THEN DO:
                   IF wdetail.brand <> "ISUZU" THEN DO:
                        FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                                  brstat.insure.compno      = "TPIS_RE"           AND 
                                  index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                                  brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                                  deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                                  trim(brstat.insure.Text2) = trim(np_garage)           AND 
                                  TRIM(brstat.insure.icno)  <> "ISUZU"  NO-LOCK NO-ERROR.
                   END.
                   ELSE DO:
                       FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                              brstat.insure.compno      = "TPIS_RE"           AND 
                              index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                              brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                              deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                              trim(brstat.insure.Text2) = trim(np_garage)           AND 
                              TRIM(brstat.insure.icno)  = "ISUZU"  NO-LOCK NO-ERROR.

                       IF NOT AVAIL brstat.insure THEN DO:
                           FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                              brstat.insure.compno      = "TPIS_RE"           AND 
                              index(brstat.insure.Text3,wdetail.class) <> 0       AND  
                              brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                              deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) AND 
                              trim(brstat.insure.Text2) = trim(np_garage)    NO-LOCK NO-ERROR.
                       END.
                   END.
                END.
                ELSE DO: /* end A66-0084*/
                  FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                         brstat.insure.compno      = "TPIS_RE"            AND 
                         index(brstat.insure.Text3,wdetail.class) <> 0        AND  
                         brstat.insure.vatcode     = TRIM(wdetail.cover)     AND
                         deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) NO-LOCK NO-ERROR.
                END.
                IF AVAIL brstat.insure THEN DO:
                    ASSIGN wdetail.CLASS       = TRIM(brstat.insure.Text3) 
                           wdetail.campens     = trim(brstat.insure.Text1)
                           wdetail.np_f18line4 = TRIM(brstat.insure.Text2)
                           wdetail.np_f18line6 = "เบี้ยตรงกับแคมเปญ"
                           wdetail.product     = IF TRIM(brstat.insure.icaddr2) <> "" THEN TRIM(brstat.insure.icaddr2) + "_" + trim(brstat.insure.Text1) 
                                                  ELSE trim(brstat.insure.Text1). /*A65-0177*/
                END.
                ELSE ASSIGN wdetail.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail.pol_netprem
                             wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรงกับแคมเปญ" .

            END.
            IF TRIM(wdetail.cover) = "2"  THEN DO:
                 FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
                           brstat.insure.compno      = "TPIS_RE"           AND 
                           index(brstat.insure.Text3,wdetail.class) <> 0        AND  
                           brstat.insure.vatcode     = TRIM(wdetail.cover)      AND
                           deci(brstat.insure.Text4) = DECI(wdetail.pol_netprem) NO-LOCK NO-ERROR.
                 IF AVAIL brstat.insure THEN DO:
                     ASSIGN wdetail.CLASS       = TRIM(brstat.insure.Text3) 
                            wdetail.np_f18line4 = trim(brstat.insure.Text1) 
                            wdetail.np_f18line6 = "เบี้ยตรงกับแคมเปญ".
                 END.
                 ELSE ASSIGN wdetail.np_f18line6 = "เบี้ยไม่ตรงกับแคมเปญ " + wdetail.pol_netprem 
                             wdetail.err         = wdetail.err + "/ เบี้ยไม่ตรงกับแคมเปญ" .
            END.
            IF index(wdetail.deler,"Refinance") <> 0 THEN ASSIGN wdetail.np_f18line5 = "Refinence". 
            ELSE IF index(wdetail.deler,"Used Car") <> 0 THEN ASSIGN wdetail.np_f18line5 = "Used Car".
            ELSE IF index(wdetail.deler,"UsedCar")  <> 0 THEN ASSIGN wdetail.np_f18line5 = "Used Car".
            ELSE ASSIGN wdetail.np_f18line5 = "Switch".
        END.
        RUN pro_chkfile2.
    END.
    RELEASE stat.insure.
    RELEASE brstat.tlt.
    RELEASE sicuw.uwm301.
    RELEASE sicuw.uwm100.
END.
IF CONNECTED("sic_exp") THEN DISCONNECT  sic_exp.
ASSIGN fi_process   = "Check data Expiry complete ......".    /*A56-0262*/
DISP fi_process WITH FRAM fr_main.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_chkmodel C-Win 
PROCEDURE pro_chkmodel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
DEF VAR n_model     AS CHAR FORMAT "x(2)"  INIT "".    
DEF VAR n_model1    AS CHAR FORMAT "x(5)"  INIT "".   
DEF VAR n_model3    AS CHAR FORMAT "x(10)" INIT "".  

ASSIGN 
    n_model  = ""  
    n_model1 = ""
    n_model3 = "".
IF trim(wdetail.chasno) <> ""  THEN DO:
    n_model  = trim(SUBSTR(wdetail.chasno,9,1)) . 
    n_model1 = trim(SUBSTR(wdetail.chasno,7,5)) .  /*A62-0110*/
END.
IF wdetail.model <> "" THEN n_model3 = trim(SUBSTR(trim(wdetail.model),6,2)).
ELSE n_model3 = trim(wdetail.model).

IF      n_model3 = "JV" THEN wdetail.model = "D-MAX" .
ELSE IF n_model3 = "JR" THEN wdetail.model = "D-MAX" .
ELSE IF n_model3 = "JE" THEN wdetail.model = "D-MAX" .
ELSE IF n_model3 = "JC" THEN wdetail.model = "D-MAX" .
ELSE IF n_model3 = "GW" THEN wdetail.model = "MU-X" .
ELSE IF n_model3 = "HG" THEN wdetail.model = "MU-7" .
ELSE IF n_model3 = "HD" THEN wdetail.model = "MU-7" .
ELSE IF n_model  = "G"  THEN wdetail.model = "MU-X".
ELSE IF wdetail.brand = "ISUZU"  THEN  DO:
    IF n_model1 = "85HBT" THEN wdetail.model = "MU-7".  
    ELSE IF TRIM(wdetail.bus_typ) = "CV" THEN wdetail.model = wdetail.model. 
    ELSE  wdetail.model = "D-MAX" .  
END.
ELSE wdetail.model = trim(wdetail.model) . 
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_chknew C-Win 
PROCEDURE pro_chknew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail .

    RUN proc_chkdealer.

    IF trim(wdetail.campaign) = "" THEN DO:
        IF trim(wdetail.bus_typ) = "LCV" THEN DO:
            ASSIGN wdetail.campaign = "*" .
        END.
        ELSE DO:
            ASSIGN wdetail.campaign = "-" .
        END.
    END.

    FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
               brstat.insure.compno    = "TPIS"            AND
               brstat.insure.fname     = trim(wdetail.campaign) AND
               brstat.insure.vatcode   = trim(wdetail.bus_typ)  NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN
         wdetail.campens  =  trim(brstat.insure.text1)      
         wdetail.producer =  trim(brstat.insure.icaddr2)
         wdetail.agent    =  "B3M0018"
         wdetail.memotext =  trim(brstat.insure.text2)
         wdetail.vatcode  =  trim(brstat.insure.text4)
         wdetail.prempa   =  trim(brstat.insure.Text3).  /*A61-0152*/
    END.
    ELSE DO:
        ASSIGN  
            wdetail.campens   =  ""      
            wdetail.producer  =  ""      
            wdetail.agent     =  ""      
            wdetail.memotext  =  ""      
            wdetail.vatcode   =  "" 
            wdetail.prempa    =  "" 
            wdetail.err        =  wdetail.err + " ไม่พบข้อมูล Producer/Agent code ที่พารามิเตอร์". 
    END.

    /*---------- สาขา , Deler code , vat code ------------------*/
    IF TRIM(wdetail.showroom) <> "" THEN DO:
        FIND FIRST stat.insure USE-INDEX insure01 WHERE 
            stat.insure.compno       = "TPIS"                   AND         
            TRIM(stat.insure.fname)  = TRIM(wdetail.deler)     AND
            TRIM(stat.insure.lname)  = TRIM(wdetail.showroom)  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO:
                ASSIGN  wdetail.branch     = trim(stat.insure.branch)
                        wdetail.delerco    = trim(stat.insure.insno)  
                        wdetail.financecd  = trim(stat.Insure.Text3) .    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                        /*wdetail.typepay    = stat.insure.vatcode .   /* kridtiya i. A53-0183*/ 
                
                /*----------ออกใบเสร็จในนามดีลเลอร์ ----------------*/
                IF INDEX(wdetail.remark1,"Issue tax invoice") <> 0 THEN DO: 
                    IF trim(stat.insure.addr1) <> " " THEN DO:
                        ASSIGN wdetail.dealer_name2  = "และ/หรือ " + trim(stat.insure.addr1) + 
                                                        IF TRIM(stat.insure.addr2) <> "" THEN " " + trim(stat.insure.addr2) ELSE "". 
                   END.
                   ELSE DO:
                       FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = trim(wdetail.typepay) NO-LOCK NO-ERROR .
                            IF AVAIL sicsyac.xmm600 THEN 
                                ASSIGN wdetail.dealer_name2  = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + trim(sicsyac.xmm600.NAME).    
                   END.
                END.
                ELSE DO:
                     ASSIGN  wdetail.dealer_name2  = "".
                END.*/
                /*---end a58-0489----*/
            END.
            ELSE DO:   
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                    stat.insure.compno       = "TPIS-CV"                   AND         
                    TRIM(stat.insure.fname)  = TRIM(wdetail.deler)     AND
                    TRIM(stat.insure.lname)  = TRIM(wdetail.showroom)  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL stat.insure THEN DO:
                        ASSIGN  wdetail.branch     = trim(stat.insure.branch)
                                wdetail.delerco    = trim(stat.insure.insno)  
                                wdetail.financecd  = trim(stat.Insure.Text3) .    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/
                    END.
                    ELSE DO:
                        ASSIGN wdetail.branch     = ""              
                               wdetail.delerco    = ""  
                               wdetail.financecd  = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                               /*wdetail.typepay    = ""              
                               wdetail.dealer_name2   = "" */
                               wdetail.err        =  wdetail.err + " ไม่พบข้อมูลสาขาที่พารามิเตอร์".  
                    END.
            END.  
    END.
    ELSE DO:
      FIND FIRST stat.insure USE-INDEX insure01 WHERE stat.insure.compno       = "TPIS"     AND       
                                                      TRIM(stat.insure.fname)  = TRIM(wdetail.deler) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL stat.insure THEN DO:
                ASSIGN  wdetail.branch     = trim(stat.insure.branch)
                        wdetail.delerco    = trim(stat.insure.insno )
                        wdetail.financecd  = trim(stat.Insure.Text3 )  .  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                       /* wdetail.typepay    = stat.insure.vatcode.*/   /* kridtiya i. A53-0183*/ 
                
                /*----------ออกใบเสร็จในนามดีลเลอร์ ----------------*/
               /* IF INDEX(wdetail.remark1,"Issue tax invoice") <> 0 THEN DO: 
                    IF trim(stat.insure.addr1) <> " " THEN DO:
                        ASSIGN wdetail.dealer_name2  = "และ/หรือ " + trim(stat.insure.addr1) + 
                                                        IF TRIM(stat.insure.addr2) <> "" THEN " " + trim(stat.insure.addr2) ELSE "". 
                   END.
                   ELSE DO:
                       FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = trim(wdetail.typepay) NO-LOCK NO-ERROR .
                            IF AVAIL sicsyac.xmm600 THEN 
                                ASSIGN wdetail.dealer_name2  = "และ/หรือ " + trim(sicsyac.xmm600.ntitle) + " " + trim(sicsyac.xmm600.NAME).    
                   END.
                END.
                ELSE DO:
                     ASSIGN  wdetail.dealer_name2  = "".
                END.*/
                /*---end a58-0489----*/
            END.
            ELSE DO:                                       
                FIND FIRST stat.insure USE-INDEX insure01 WHERE 
                    stat.insure.compno       = "TPIS-CV"                   AND         
                    TRIM(stat.insure.fname)  = TRIM(wdetail.deler)     NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL stat.insure THEN DO:
                        ASSIGN  wdetail.branch     = trim(stat.insure.branch) 
                                wdetail.delerco    = trim(stat.insure.insno )  
                                wdetail.financecd  = trim(stat.Insure.Text3 ) .    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/
                    END.
                    ELSE DO:
                        ASSIGN wdetail.branch     = ""              
                               wdetail.delerco    = ""  
                               wdetail.financecd  = ""    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*//*Finance Code*/ 
                               /*wdetail.typepay    = ""              
                               wdetail.dealer_name2   = "" */
                               wdetail.err        =  wdetail.err + " ไม่พบข้อมูลสาขาที่พารามิเตอร์".  
                    END.
            END.  
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_detail_new C-Win 
PROCEDURE pro_detail_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 FOR EACH wdetail  NO-LOCK.
     EXPORT DELIMITER "|"
     trim(wdetail.ins_ytyp)      
     trim(wdetail.bus_typ )      
     trim(wdetail.TASreceived)   
     trim(wdetail.InsCompany)    
     trim(wdetail.Insurancerefno)
     trim(wdetail.tpis_no)       
     trim(wdetail.ntitle)        
     trim(wdetail.insnam)        
     trim(wdetail.NAME2 )        
     trim(wdetail.cust_type)     
     IF trim(wdetail.bus_typ) = "CV" OR rs_type = 2 THEN "" ELSE trim(wdetail.nDirec)        
     trim(wdetail.ICNO )         
     trim(wdetail.address)       
     trim(wdetail.build)         
     trim(wdetail.mu )           
     trim(wdetail.soi)           
     trim(wdetail.road)          
     trim(wdetail.tambon)        
     trim(wdetail.amper)         
     trim(wdetail.country)       
     trim(wdetail.post )        
     trim(wdetail.brand)        
     trim(wdetail.model)                 
     trim(wdetail.class)        
     trim(wdetail.md_year)       
     trim(wdetail.usage)        
     trim(wdetail.coulor)       
     trim(wdetail.cc)           
     trim(wdetail.regis_year)   
     trim(wdetail.engno)        
     trim(wdetail.chasno)        
     trim(wdetail.Acc_CV)        
     IF wdetail.Acc_CV <> "" THEN trim(STRING(DECI(wdetail.Acc_amount))) ELSE "" 
     trim(wdetail.License )        
     trim(wdetail.regis_CL)        
     trim(wdetail.campaign)  /*wdetail.campens*/       
     trim(wdetail.typ_work)         
     trim(wdetail.si)              /*DECI(wdetail.si) FORMAT ">>>>>>>9.99"             */ 
     trim(wdetail.pol_comm_date)   /*DATE(wdetail.pol_comm_date)  FORMAT "99/99/9999"  */ 
     trim(wdetail.pol_exp_date)    /*DATE(wdetail.pol_exp_date)   FORMAT "99/99/9999"  */ 
     trim(wdetail.prvpol)             
     trim(wdetail.cover )            
     /*DECI*/ trim(wdetail.pol_netprem)                                   
     /*DECI*/ trim(wdetail.pol_gprem)                                     
     /*DECI*/ trim(wdetail.pol_stamp)                                     
     /*DECI*/ trim(wdetail.pol_vat)                                       
     /*DECI*/ trim(wdetail.pol_wht)                                       
     trim(wdetail.com_no)                                               
     TRIM(wdetail.com_comm_date) /*DATE(wdetail.com_comm_date) FORMAT "99/99/9999" */    
     trim(wdetail.com_exp_date)  /*DATE(wdetail.com_exp_date)  FORMAT "99/99/9999" */  
     /*DECI*/ trim(wdetail.com_netprem)                                                     
     /*DECI*/ trim(wdetail.com_gprem)                                      
     /*DECI*/ trim(wdetail.com_stamp)                                      
     /*DECI*/ trim(wdetail.com_vat)                                        
     /*DECI*/ trim(wdetail.com_wht)                                        
     trim(wdetail.deler    )                                   
     trim(wdetail.showroom )                                   
     trim(wdetail.typepay  )                                   
     trim(wdetail.financename)                                   
     trim(wdetail.mail_hno )                                
     trim(wdetail.mail_build )                                   
     trim(wdetail.mail_mu  )                                   
     trim(wdetail.mail_soi )                                   
     trim(wdetail.mail_road)                                   
     trim(wdetail.mail_tambon )                                   
     trim(wdetail.mail_amper  )                                   
     trim(wdetail.mail_country)                                   
     trim(wdetail.mail_post)                                   
     trim(wdetail.send_date)                                   
     "" /*trim(wdetail.policy   ) */                                  
     trim(wdetail.send_data)                                   
     trim(wdetail.REMARK1  )                                   
     "" /*wdetail.occup */     
     trim(wdetail.model)       
     ""                        
     "CLAIMDI"             
     trim(wdetail.product)     
     trim(wdetail.np_f18line1)                                     
     trim(wdetail.np_f18line2)                                     
     trim(wdetail.np_f18line3)  
     trim(wdetail.producer)      /*Producer       */ 
     trim(wdetail.agent )        /*Agent          */
     trim(wdetail.branch)        /*Branch         */
     trim(wdetail.campens )      /*Campaign TMSTH */                          
     trim(wdetail.err)          /*Error          */ 
     trim(wdetail.Driver1_title)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver1_name)          /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver1_lastname)      /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver1_birthdate)     /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver1_id_no)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver1_license_no)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver1_occupation)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver2_title)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver2_name)          /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver2_lastname)      /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver2_birthdate)     /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver2_id_no)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver2_license_no)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver2_occupation)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver3_title)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver3_name)          /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver3_lastname)      /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver3_birthday)      /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver3_id_no)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver3_license_no)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver3_occupation)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver4_title)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver4_name)          /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver4_lastname)      /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver4_birthdate)     /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver4_id_no)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver4_license_no)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver4_occupation)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver5_title)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver5_name)          /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver5_lastname)      /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver5_birthdate)     /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver5_id_no)         /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver5_license_no)    /*add by kridtiyai. A68-0044*/
     trim(wdetail.Driver5_occupation).   /*add by kridtiyai. A68-0044*/
 End.  /*end for*/                                                                    
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_detail_renew C-Win 
PROCEDURE pro_detail_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_model AS CHAR FORMAT "x(50)" INIT "" .
 FOR EACH wdetail  NO-LOCK.
     ASSIGN 
         nv_model = ""
         nv_model = IF trim(wdetail.brand) <> "ISUZU" THEN  trim(wdetail.desmodel)  ELSE trim(wdetail.model).
         
    EXPORT DELIMITER "|"
    trim(wdetail.ins_ytyp)      
    trim(wdetail.bus_typ )      
    trim(wdetail.TASreceived)      
    trim(wdetail.InsCompany)      
    trim(wdetail.Insurancerefno)   
    trim(wdetail.tpis_no)          
    trim(wdetail.ntitle )          
    trim(wdetail.insnam )          
    trim(wdetail.NAME2)          
    trim(wdetail.cust_type)        
    IF trim(wdetail.bus_typ) = "CV" OR rs_type = 2 THEN "" ELSE trim(wdetail.nDirec)        
    trim(wdetail.ICNO)        
    trim(wdetail.address)        
    trim(wdetail.build )      
    trim(wdetail.mu  )        
    trim(wdetail.soi )        
    trim(wdetail.road)        
    trim(wdetail.tambon)        
    trim(wdetail.amper )        
    trim(wdetail.country)        
    trim(wdetail.post )        
    trim(wdetail.brand)        
    nv_model                
    trim(wdetail.class  )          
    trim(wdetail.md_year)          
    trim(wdetail.usage  )          
    trim(wdetail.coulor )         
    trim(wdetail.cc     )          
    trim(wdetail.regis_year)      
    trim(wdetail.engno )          
    trim(wdetail.chasno)           
    trim(wdetail.Acc_CV)           
    IF wdetail.Acc_CV <> "" THEN trim(wdetail.Acc_amount) ELSE ""  /*IF wdetail.Acc_CV <> "" THEN trim(STRING(DECI(wdetail.Acc_amount))) ELSE ""  A68-0019*/
    trim(wdetail.License )        
    trim(wdetail.regis_CL)        
    trim(wdetail.campens )   
    trim(wdetail.typ_work)        
    trim(wdetail.si)             /*DECI(wdetail.si) FORMAT ">>>>>>>9.99"             */      
    trim(wdetail.pol_comm_date)  /*DATE(wdetail.pol_comm_date)  FORMAT "99/99/9999"  */       
    trim(wdetail.pol_exp_date)   /*DATE(wdetail.pol_exp_date)   FORMAT "99/99/9999"  */       
    trim(wdetail.prvpol)               
    trim(wdetail.Branch)              
    trim(wdetail.cover )                                                
    trim(wdetail.pol_netprem)   /*DECI(wdetail.pol_netprem)*/                                     
    trim(wdetail.pol_gprem)     /*DECI(wdetail.pol_gprem)  */                                     
    trim(wdetail.pol_stamp)     /*DECI(wdetail.pol_stamp)  */                                     
    trim(wdetail.pol_vat)       /*DECI(wdetail.pol_vat)    */                                     
    trim(wdetail.pol_wht)       /*DECI(wdetail.pol_wht)    */                                     
    trim(wdetail.com_no)              
    "" /*wdetail.docno*/             
    trim(wdetail.stkno) /*FORMAT "x(35)" */                                 
    TRIM(wdetail.com_comm_date) /*DATE(wdetail.com_comm_date) FORMAT "99/99/9999" */              
    TRIM(wdetail.com_exp_date)  /*DATE(wdetail.com_exp_date)  FORMAT "99/99/9999" */              
    /*DECI*/ trim(wdetail.com_netprem)                                     
    /*DECI*/ trim(wdetail.com_gprem)                                       
    /*DECI*/ trim(wdetail.com_stamp)                                       
    /*DECI*/ trim(wdetail.com_vat)                                         
    /*DECI*/ trim(wdetail.com_wht)                                         
    trim(wdetail.deler    )                                          
    trim(wdetail.showroom )                                          
    trim(wdetail.typepay  )                                          
    trim(wdetail.financename )                                          
    trim(wdetail.mail_hno )                                          
    trim(wdetail.mail_build )                                          
    trim(wdetail.mail_mu )                                     
    trim(wdetail.mail_soi)                                     
    trim(wdetail.mail_road)                                     
    trim(wdetail.mail_tambon)                                          
    trim(wdetail.mail_amper )                                          
    trim(wdetail.mail_country)                                          
    trim(wdetail.mail_post)                                          
    trim(wdetail.send_date)                                          
    ""  /*trim(wdetail.policy   )  */                                        
    trim(wdetail.send_data)                                          
    trim(wdetail.REMARK1  )                                          
    "" /*wdetail.occup*/                                          
    trim(wdetail.regis_no)                                              
    trim(wdetail.np_f18line1)                                           
    trim(wdetail.np_f18line2)                                           
    trim(wdetail.np_f18line3)                                           
    trim(wdetail.np_f18line4)                                           
    trim(wdetail.np_f18line5)        
    ""    
    trim(wdetail.np_f18line7)       
    trim(wdetail.np_f18line8)      
    trim(wdetail.np_f18line9)           
    trim(wdetail.isp  )                 
    trim(wdetail.ispno)             
    trim(wdetail.ispresult)         
    trim(wdetail.ispdetail)         
    trim(wdetail.ispacc   )          
    trim(wdetail.producer )          
    trim(wdetail.product  )          
    trim(wdetail.np_f18line6)  
    trim(wdetail.err) .        
 End.  /*end for*/                                                                                            
OUTPUT  CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_head_new C-Win 
PROCEDURE pro_head_new :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*****************Header file Excel***********************************/
If substr(fi_output,length(fi_output) - 3,4) <> ".CSV" THEN fi_output  =  Trim(fi_output) + ".CSV"  .
    ASSIGN nv_cnt  =  0
           nv_row  =  0.
OUTPUT TO VALUE(fi_output).
EXPORT DELIMITER "|"
  "Ins. Year type"                              
  "Business type"                               
  "TAS received by"                             
  "Ins company "                                
  "Insurance ref no."                           
  "TPIS Contract No."                           
  "Title name "                                 
  "customer name"                               
  "customer lastname "                          
  "Customer type"                        
  "Director Name"                        
  "ID number"                            
  "House no."                            
  "Building "                            
  "Village name/no."                     
  "Soi"                              
  "Road "                                          
  "Sub-district"                     
  "District"                         
  "Province"                         
  "Postcode"                         
  "Brand"                            
  "Car model"                   
  "Insurance Code"                    
  "Model Year"        
  "Usage Type"        
  "Colour "       
  "Car Weight"     
  "Year "    
  "Engine No."     
  "Chassis No."                      
  "Accessories (for CV)"   
  "Accessories amount"                                               
  "License No."                                          
  "Registered Car License"                    
  "Campaign"                                  
  "Type of work "                             
  "Insurance amount  "                        
  "Insurance Date (Voluntary)"                                                
  "Expiry Date (Voluntary)   "                                      
  "Last Policy No.(Voluntary)"                    
  "Insurance Type            "     
  "Net premium (Voluntary)   "                            
  "Gross premium (Voluntary) "                                         
  "Stamp "                                    
  "VAT   "                                                         
  "WHT   "                                                         
  "Compulsory No."                                                 
  "Insurance Date (Compulsory)"   
  "Expiry Date ( Compulsory)  "     
  "Net premium (Compulsory)   "     
  "Gross premium (Compulsory) "                             
  "Stamp   "                                              
  "VAT     "                                              
  "WHT     "                                              
  "Dealer  "                                                
  "Showroom   "                                             
  "Payment Type "                                           
  "Beneficiery  "                                           
  "Mailing House no."                                           
  "Mailing  Building"                                         
  "Mailing  Village name/no. "                                
  "Mailing  Soi  "                                            
  "Mailing  Road "                                            
  "Mailing  Sub-district"                                      
  "Mailing  District "                                                     
  "Mailing Province  "                                                     
  "Mailing Postcode  "                                              
  "Policy no. to customer date"                                        
  "New policy no"                                        
  "Insurer Stamp Date "                                         
  "Remark"                              
  "Occupation code"    
  "Car Model     "                                    
  " "                                              
  "Promo "                             
  "Product"            
  "f18line1"           
  "f18line2"           
  "f18line3"           
  "Producer"                                          
  "Agent "                                         
  "Branch "                            
  "Campaign TMSTH"                        
  "Error"        
  "Driver1_title"        /*Add by Kridtiyai. A68-0044*/
  "Driver1_name"         /*Add by Kridtiyai. A68-0044*/
  "Driver1_lastname"     /*Add by Kridtiyai. A68-0044*/
  "Driver1_birthdate"    /*Add by Kridtiyai. A68-0044*/
  "Driver1_id_no"        /*Add by Kridtiyai. A68-0044*/
  "Driver1_license_no"   /*Add by Kridtiyai. A68-0044*/
  "Driver1_occupation"   /*Add by Kridtiyai. A68-0044*/
  "Driver2_title"        /*Add by Kridtiyai. A68-0044*/
  "Driver2_name"         /*Add by Kridtiyai. A68-0044*/
  "Driver2_lastname"     /*Add by Kridtiyai. A68-0044*/
  "Driver2_birthdate"    /*Add by Kridtiyai. A68-0044*/
  "Driver2_id_no"        /*Add by Kridtiyai. A68-0044*/
  "Driver2_license_no"   /*Add by Kridtiyai. A68-0044*/
  "Driver2_occupation"   /*Add by Kridtiyai. A68-0044*/
  "Driver3_title"        /*Add by Kridtiyai. A68-0044*/
  "Driver3_name"         /*Add by Kridtiyai. A68-0044*/
  "Driver3_lastname"     /*Add by Kridtiyai. A68-0044*/
  "Driver3_birthday"     /*Add by Kridtiyai. A68-0044*/
  "Driver3_id_no"        /*Add by Kridtiyai. A68-0044*/
  "Driver3_license_no"   /*Add by Kridtiyai. A68-0044*/
  "Driver3_occupation"   /*Add by Kridtiyai. A68-0044*/
  "Driver4_title"        /*Add by Kridtiyai. A68-0044*/
  "Driver4_name"         /*Add by Kridtiyai. A68-0044*/
  "Driver4_lastname"     /*Add by Kridtiyai. A68-0044*/
  "Driver4_birthdate"    /*Add by Kridtiyai. A68-0044*/
  "Driver4_id_no"        /*Add by Kridtiyai. A68-0044*/
  "Driver4_license_no"   /*Add by Kridtiyai. A68-0044*/
  "Driver4_occupation"   /*Add by Kridtiyai. A68-0044*/
  "Driver5_title"        /*Add by Kridtiyai. A68-0044*/
  "Driver5_name"         /*Add by Kridtiyai. A68-0044*/
  "Driver5_lastname"     /*Add by Kridtiyai. A68-0044*/
  "Driver5_birthdate"    /*Add by Kridtiyai. A68-0044*/
  "Driver5_id_no"        /*Add by Kridtiyai. A68-0044*/
  "Driver5_license_no"   /*Add by Kridtiyai. A68-0044*/
  "Driver5_occupation"   /*Add by Kridtiyai. A68-0044*/
    .

 RUN pro_detail_new.
 
 /***End Add By Nontamas H. [A62-0329] Date 08/07/2019*****/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_head_renew C-Win 
PROCEDURE pro_head_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 /*****************Header file Excel***********************************/
If substr(fi_output,length(fi_output) - 3,4) <> ".csv" THEN fi_output  =  Trim(fi_output) + ".csv"  .
    ASSIGN nv_cnt  =  0
           nv_row  =  0.
OUTPUT TO VALUE(fi_output).
 EXPORT DELIMITER  "|"
 "Ins. Year type"                             
 "Business type"                              
 "TAS received by"                            
 "Ins company "                               
 "Insurance ref no."                          
 "TPIS Contract No."                          
 "Title name "                                
 "customer name"                              
 "customer lastname "                         
 "Customer type"                       
 "Director Name"                       
 "ID number"                           
 "House no."                           
 "Building "                           
 "Village name/no."                    
 "Soi"                               
 "Road "                                           
 "Sub-district"                      
 "District"                          
 "Province"                          
 "Postcode"                          
 "Brand"                             
 "Car model "                        
 "Insurance Code"                    
 "Model Year"        
 "Usage Type"        
 "Colour "       
 "Car Weight"     
 "Year      "    
 "Engine No."     
 "Chassis No."                      
 "Accessories (for CV)"   
 "Accessories amount"                                              
 "License No."                                         
 "Registered Car License"                   
 "Campaign"                                 
 "Type of work "                            
 "Insurance amount  "                       
 "Insurance Date (Voluntary)"                                                
 "Expiry Date (Voluntary)   "                                      
 "Last Policy No.(Voluntary)"                    
 "Branch             "        
 "Insurance Type            "                            
 "Net premium (Voluntary)   "                                         
 "Gross premium (Voluntary) "                            
 "Stamp "                                                           
 "VAT   "                                                           
 "WHT   "                                                           
 "Compulsory No." 
 "เลขใบแจ้งหนี้."       
 "Sticker No.   "                               
 "Insurance Date (Compulsory)"                              
 "Expiry Date ( Compulsory)  "                            
 "Net premium (Compulsory)   "                            
 "Gross premium (Compulsory) "                            
 "Stamp   "                                                  
 "VAT     "                                                  
 "WHT     "                                                  
 "Dealer  "                                                  
 "Showroom   "                                                 
 "Payment Type "                                             
 "Beneficiery  "                                             
 "Mailing House no."                                      
 "Mailing  Building"                                      
 "Mailing  Village name/no. "                              
 "Mailing  Soi  "                                                      
 "Mailing  Road "                                                      
 "Mailing  Sub-district"                                        
 "Mailing  District "                                              
 "Mailing Province  "                                              
 "Mailing Postcode  "                                              
 "Policy no. to customer date"                            
 "New policy no      "                                            
 "Insurer Stamp Date "                                            
 "Remark             "                       
 "Occupation code"                                   
 "Register NO.   "                                   
 "f18line1       "                                   
 "f18line2       "                                   
 "f18line3       "                                   
 "f18line4       "                                   
 "f18line5       "       
 "f18line6       "       
 "f18line7       "       
 "f18line8       "       
 "f18line9       "       
 "Inspection     "       
 "ISP No.        "       
 "ISP Detail     "       
 "ISP Damge      "       
 "ISP Accessories"       
 "Producer       "       
 "Product        "       
 "Data Check     "       
 "Error          ".       
 RUN pro_detail_renew.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

