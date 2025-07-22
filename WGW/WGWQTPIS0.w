&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
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
  wgwqtpis0.w :  Query & Update Data Hold TPIS
  Create  by  :  Ranu i. A66-0252 Date : 07/02/2024
  Connect     :  sicuw , siccl , sicsyac , sic_bran, brstat /* not stat*/
  +++++++++++++++++++++++++++++++++++++++++++++++*/
/*Modify by      : Kridtiya i. A68-0019 ‡æ‘Ë¡ °“√√—∫ Ëß§Ë“ Product          */  
/*Modify by      : Kridtiya i. A68-0044 Date. 02/05/2025 Add Drivername 5 Person       */  


 Def    var  nv_rectlt    as recid  init  0.
 Def    var  nv_recidtlt  as recid  init  0.
 DEFINE VAR  n_asdat      AS CHAR.
 DEFINE VAR  vAcProc_fil  AS CHAR.
 DEFINE VAR  n_asdat1     AS CHAR. /*A55-0365 */
 DEFINE VAR  vAcProc_fil1 AS CHAR. /*A55-0365 */
 DEF    VAR  nv_72Reciept AS CHAR INIT "" .
 DEFINE stream  ns2.
 DEF VAR nv_row AS INT INIT 0.  /*A60-0118*/
/*------- create by A60-0118------------*/
 DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
     FIELD ins_ytyp                AS CHAR FORMAT "x(20)"         INIT ""    
     FIELD bus_typ                 AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD TASreceived             AS CHAR FORMAT "x(100)"        INIT ""     
     FIELD InsCompany              AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD Insurancerefno          AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD tpis_no                 AS CHAR FORMAT "x(11)"         INIT ""     
     FIELD ntitle                  AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD insnam                  AS CHAR FORMAT "x(100)"        INIT ""     
     FIELD NAME2                   AS CHAR FORMAT "x(100)"        INIT ""     
     FIELD cust_type               AS CHAR FORMAT "x(1)"          INIT ""     
     FIELD nDirec                  AS CHAR FORMAT "x(100)"        INIT ""     
     FIELD ICNO                    AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD address                 AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD build                   AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mu                      AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD soi                     AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD road                    AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD tambon                  AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD amper                   AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD country                 AS CHAR FORMAT "x(50)"         INIT ""     
     FIELD post                    AS CHAR FORMAT "x(50)"         INIT ""     
     FIELD brand                   AS CHAR FORMAT "x(30)"         INIT ""     
     FIELD model                   AS CHAR FORMAT "x(30)"         INIT ""     
     FIELD class                   AS CHAR FORMAT "x(20)"         INIT ""    
     FIELD md_year                 AS CHAR FORMAT "x(20)"         INIT ""    
     FIELD Usage                   AS CHAR FORMAT "x(100)"        INIT ""     
     FIELD coulor                  AS CHAR FORMAT "x(30)"         INIT ""     
     FIELD cc                      AS CHAR FORMAT "x(20)"         INIT ""    
     FIELD regis_year              AS CHAR FORMAT "x(20)"         INIT ""    
     FIELD engno                   AS CHAR FORMAT "x(40)"         INIT ""     
     FIELD chasno                  AS CHAR FORMAT "x(25)"         INIT ""     
     FIELD Acc_CV                  AS CHAR FORMAT "x(255)"        INIT ""     
     FIELD Acc_amount              AS CHAR FORMAT "x(100)"        INIT ""    
     FIELD License                 AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD regis_CL                AS CHAR FORMAT "x(100)"        INIT ""    
     FIELD campaign                AS CHAR FORMAT "x(100)"        INIT ""    
     FIELD typ_work                AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD si                      AS CHAR FORMAT "X(20)"         INIT ""     
     FIELD pol_comm_date           AS CHAR FORMAT "X(20)"         INIT ""     
     FIELD pol_exp_date            AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD LAST_pol                AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD cover                   AS CHAR FORMAT "x(20)"         INIT ""    
     FIELD pol_netprem             AS CHAR FORMAT "X(15)"         INIT ""     
     FIELD pol_gprem               AS CHAR FORMAT "X(15)"         INIT ""     
     FIELD pol_stamp               AS CHAR FORMAT "X(15)"         INIT ""     
     FIELD pol_vat                 AS CHAR FORMAT "X(15)"         INIT ""     
     FIELD pol_wht                 AS CHAR FORMAT "X(15)"         INIT ""     
     FIELD com_no                  AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD stkno                   AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD com_comm_date           AS CHAR FORMAT "X(20)"         INIT ""     
     FIELD com_exp_date            AS CHAR FORMAT "X(20)"         INIT ""     
     FIELD com_netprem             AS CHAR FORMAT "x(15)"         INIT ""     
     FIELD com_gprem               AS CHAR FORMAT "x(15)"         INIT ""     
     FIELD com_stamp               AS CHAR FORMAT "x(15)"         INIT ""     
     FIELD com_vat                 AS CHAR FORMAT "X(15)"         INIT ""     
     FIELD com_wht                 AS CHAR FORMAT "x(15)"         INIT ""     
     FIELD deler                   AS CHAR FORMAT "x(200)"        INIT ""    
     FIELD showroom                AS CHAR FORMAT "x(200)"        INIT ""    
     FIELD typepay                 AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD financename             AS CHAR FORMAT "x(200)"        INIT ""    
     FIELD mail_hno                AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mail_build              AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mail_mu                 AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mail_soi                AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mail_road               AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mail_tambon             AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mail_amper              AS CHAR FORMAT "x(60)"         INIT ""     
     FIELD mail_country            AS CHAR FORMAT "x(50)"         INIT ""     
     FIELD mail_post               AS CHAR FORMAT "x(50)"         INIT ""     
     FIELD send_date               AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD policy_no               AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD send_data               AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD REMARK1                 AS CHAR FORMAT "x(200)"        INIT ""     
     FIELD occup                   AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD regis_no                AS CHAR FORMAT "x(20)"         INIT ""     
     FIELD np_f18line1             AS CHAR FORMAT "x(60)"         INIT "" 
     FIELD np_f18line2             AS CHAR FORMAT "x(60)"         INIT "" 
     FIELD np_f18line3             AS CHAR FORMAT "x(60)"         INIT "" 
     FIELD np_f18line4             AS CHAR FORMAT "x(60)"         INIT "" 
     FIELD np_f18line5             AS CHAR FORMAT "x(60)"         INIT "" 
     FIELD np_f18line6             AS CHAR FORMAT "x(255)"        INIT "" 
     FIELD np_f18line7             AS CHAR FORMAT "x(2)"          INIT "" 
     FIELD np_f18line8             AS CHAR FORMAT "x(50)"         INIT "" 
     FIELD np_f18line9             AS CHAR FORMAT "x(255)"        INIT "" 
     FIELD pol_typ                 AS CHAR FORMAT "x(3)"          INIT "" 
     FIELD financename2            AS CHAR FORMAT "x(10)"         INIT ""     
     FIELD branch                  AS CHAR FORMAT "x(10)"         INIT ""     
     FIELD baseprm                 AS CHAR FORMAT "x(10)"         INIT "" 
     FIELD delerco                 AS CHAR FORMAT "x(10)"         INIT "" 
     FIELD dealer_name2            AS CHAR FORMAT "x(60)"         INIT ""
     FIELD campens                 AS CHAR FORMAT "X(50)"         INIT ""
     FIELD producer                AS CHAR FORMAT "X(10)"         INIT ""
     FIELD agent                   AS CHAR FORMAT "X(10)"         INIT ""
     FIELD memotext                AS CHAR FORMAT "X(50)"         INIT ""
     FIELD vatcode                 AS CHAR FORMAT "X(10)"         INIT ""
     FIELD name02                  AS CHAR FORMAT "X(50)"         INIT ""
     FIELD bran_name               AS CHAR FORMAT "X(30)"         INIT ""
     FIELD bran_name2              AS CHAR FORMAT "X(15)"         INIT ""
     FIELD Region                  AS CHAR FORMAT "X(20)"         INIT ""
     FIELD ton                     AS CHAR FORMAT "x(5)"          INIT ""  
     FIELD prempa                  AS CHAR FORMAT "x(2)"          INIT ""  
     FIELD garage                  AS CHAR FORMAT "X(25)"         INIT ""  
     FIELD desmodel                AS CHAR FORMAT "x(50)"         INIT ""  
     FIELD claimdi                 AS CHAR FORMAT "x(50)"         INIT ""  
     FIELD product                 AS CHAR FORMAT "x(50)"         INIT ""  
     FIELD codeocc                 AS CHAR FORMAT "x(4)"          INIT ""   
     FIELD codeaddr1               AS CHAR FORMAT "x(2)"          INIT ""   
     FIELD codeaddr2               AS CHAR FORMAT "x(2)"          INIT ""   
     FIELD codeaddr3               AS CHAR FORMAT "x(2)"          INIT ""   
     FIELD campaign_ov             AS CHAR FORMAT "x(30)"         INIT ""   
     FIELD insnamtyp               AS CHAR FORMAT "x(60)"         INIT ""   
     FIELD firstName               AS CHAR FORMAT "x(60)"         INIT ""   
     FIELD lastName                AS CHAR FORMAT "x(60)"         INIT ""   
     FIELD financecd               AS CHAR FORMAT "x(60)"         INIT "" 
     FIELD prvpol                  AS CHAR FORMAT "x(15)"         INIT "" 
     FIELD isp                     AS CHAR FORMAT "x(2)"          INIT "" 
     FIELD ispno                   AS CHAR FORMAT "x(15)"         INIT "" 
     FIELD ispresult               AS CHAR FORMAT "x(50)"         INIT "" 
     FIELD ispdetail               AS CHAR FORMAT "x(255)"        INIT "" 
     FIELD ispacc                  AS CHAR FORMAT "x(255)"        INIT ""
     FIELD err                     AS CHAR FORMAT "x(255)"        INIT "" 
     FIELD Driver1_title          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver1_name           as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver1_lastname       as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver1_birthdate      as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver1_id_no          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver1_license_no     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver1_occupation     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver2_title          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver2_name           as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver2_lastname       as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver2_birthdate      as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver2_id_no          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver2_license_no     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver2_occupation     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver3_title          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver3_name           as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver3_lastname       as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver3_birthdate      as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver3_id_no          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver3_license_no     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver3_occupation     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver4_title          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver4_name           as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver4_lastname       as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver4_birthdate      as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver4_id_no          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver4_license_no     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver4_occupation     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver5_title          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver5_name           as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver5_lastname       as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver5_birthdate      as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver5_id_no          as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver5_license_no     as char format "x(100)"  init "" /*A68-0044*/
     FIELD Driver5_occupation     as char format "x(100)"  init "" /*A68-0044*/    .

 /*----end A60-0118-----------*/
DEF VAR no_add AS CHAR FORMAT "x(25)" INIT "" .
def var nv_Maddr1   as char format "x(50)" init "" .
def var nv_Maddr2   as char format "x(50)" init "" .
def var nv_Maddr3   as char format "x(50)" init "" .
def var nv_Maddr4   as char format "x(50)" init "" .
def var nv_Maddr5   as char format "x(50)" init "" .
DEF VAR n_status AS LOGICAL.
DEF VAR n_stpol  AS CHAR.
DEF VAR n_stcom  AS CHAR.
DEF VAR n_rencnt AS INT.
DEF VAR n_endcnt AS INT.
DEF VAR n_length AS INT.
DEF VAR n_policyuwm100 AS CHAR FORMAT "x(20)" INIT "".

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
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_tlt                                        */
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.releas tlt.hclfg ~
IF trim(brstat.tlt.flag) = "NW" THEN "NEW" ELSE IF trim(brstat.tlt.flag) = "RW" THEN "RENEW" ELSE IF trim(brstat.tlt.flag) = "TF" THEN  "SWITF" ELSE IF trim(brstat.tlt.flag) = "UC" THEN  "USEDCAR" ELSE "REFINANCE" ~
tlt.rec_addr4 tlt.ins_brins tlt.nor_noti_tlt tlt.policy tlt.comp_pol ~
tlt.ins_firstname tlt.ins_lastname tlt.cha_no tlt.gendat tlt.expodat ~
tlt.comp_sck tlt.nor_coamt tlt.nor_grprm tlt.comp_grprm tlt.comp_coamt ~
tlt.note1 tlt.note7 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_pol fi_post rs_type bu_match bu_post ~
fi_trndatfr fi_trndatto bu_ok cb_search bu_oksch br_tlt fi_search bu_update ~
bu_exit bu_upyesno cb_report ra_status fi_br fi_outfile bu_report ~
fi_outfile1 fi_producer fi_outfile2 fi_comdat1 fi_comdat2 ra_status1 ~
RECT-332 RECT-338 RECT-339 RECT-340 RECT-341 RECT-381 RECT-382 RECT-384 ~
RECT-385 
&Scoped-Define DISPLAYED-OBJECTS rs_pol fi_post rs_type fi_trndatfr ~
fi_trndatto cb_search fi_search fi_name cb_report ra_status fi_br ~
fi_outfile fi_outfile1 fi_producer fi_outfile2 fi_comdat1 fi_comdat2 ~
ra_status1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-wins AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 9 BY 1
     FONT 6.

DEFINE BUTTON bu_match 
     LABEL "MATCH POLICY" 
     SIZE 14.67 BY 1.19
     BGCOLOR 2 .

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.67 BY 1
     FONT 6.

DEFINE BUTTON bu_oksch 
     LABEL "Search" 
     SIZE 7.67 BY .95
     FONT 6.

DEFINE BUTTON bu_post 
     LABEL "Match Send TPIS" 
     SIZE 27.5 BY 1
     BGCOLOR 22 .

DEFINE BUTTON bu_report 
     LABEL "OK" 
     SIZE 7 BY .95
     FONT 6.

DEFINE BUTTON bu_update 
     LABEL "CANCEL" 
     SIZE 12 BY 1.05
     FONT 6.

DEFINE BUTTON bu_upyesno 
     LABEL "YES/NO" 
     SIZE 11.67 BY 1.05
     FONT 6.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 11
     LIST-ITEMS "All" 
     DROP-DOWN-LIST
     SIZE 32.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 15
     LIST-ITEMS "TPIS No." 
     DROP-DOWN-LIST
     SIZE 32.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_br AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat1 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_comdat2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 43.33 BY .95
     BGCOLOR 32 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 57.17 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 71.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 71.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_post AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 9.33 BY .91
     BGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 35.33 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 26.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_status AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"Cancel", 3,
"All", 4
     SIZE 27.17 BY 1
     BGCOLOR 21 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE ra_status1 AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Yes", 1,
"No", 2,
"Cancel", 3,
"All", 4
     SIZE 10.17 BY 2.48
     BGCOLOR 19 FGCOLOR 2 FONT 1 NO-UNDO.

DEFINE VARIABLE rs_pol AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "V70", 1,
"V72", 2,
"All", 3
     SIZE 7.17 BY 1.91
     BGCOLOR 10 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2
     SIZE 12.5 BY 1.43
     BGCOLOR 10  NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 9.71
     BGCOLOR 34 FGCOLOR 2 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 59 BY 2.81
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-339
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 71 BY 2.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 100.67 BY 1.67
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.33 BY 1.76
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 1.24.

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 9 BY 2
     BGCOLOR 21 FGCOLOR 4 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 131.5 BY 2.52
     FGCOLOR 10 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 130.5 BY 2.38
     BGCOLOR 7 FGCOLOR 7 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.releas COLUMN-LABEL "Release~\CA" FORMAT "x(20)":U WIDTH 10.5
      tlt.hclfg COLUMN-LABEL "Problem" FORMAT "x(2)":U
      IF trim(brstat.tlt.flag) = "NW" THEN "NEW" ELSE IF trim(brstat.tlt.flag) = "RW" THEN "RENEW" ELSE IF trim(brstat.tlt.flag) = "TF" THEN  "SWITF" ELSE IF trim(brstat.tlt.flag) = "UC" THEN  "USEDCAR" ELSE "REFINANCE" COLUMN-LABEL "Type" FORMAT "x(8)":U
            WIDTH 10.83 LABEL-FGCOLOR 1 LABEL-FONT 6
      tlt.rec_addr4 COLUMN-LABEL "Business type" FORMAT "x(15)":U
      tlt.ins_brins COLUMN-LABEL "Branch" FORMAT "x(5)":U WIDTH 6.5
      tlt.nor_noti_tlt COLUMN-LABEL "‡≈¢√—∫·®Èß" FORMAT "x(25)":U
            WIDTH 13.17
      tlt.policy FORMAT "x(16)":U WIDTH 14.83
      tlt.comp_pol FORMAT "x(25)":U WIDTH 17.17
      tlt.ins_firstname FORMAT "x(60)":U WIDTH 21
      tlt.ins_lastname FORMAT "x(60)":U WIDTH 23.83
      tlt.cha_no FORMAT "x(20)":U WIDTH 20.33
      tlt.gendat COLUMN-LABEL "Comm.Date" FORMAT "99/99/9999":U
      tlt.expodat COLUMN-LABEL "Exp.Date" FORMAT "99/99/9999":U
            WIDTH 9.5
      tlt.comp_sck FORMAT "x(15)":U WIDTH 14.17
      tlt.nor_coamt COLUMN-LABEL "Coverage amount" FORMAT "->,>>>,>>>,>>9.99":U
            WIDTH 21.67
      tlt.nor_grprm COLUMN-LABEL "Gross premium" FORMAT ">>,>>>,>>9.99":U
            WIDTH 13.33
      tlt.comp_grprm FORMAT ">>>,>>9.99":U WIDTH 17.17
      tlt.comp_coamt FORMAT "->>,>>>,>>9.99":U WIDTH 20.83
      tlt.note1 COLUMN-LABEL "Prv.Policy" FORMAT "x(30)":U
      tlt.note7 COLUMN-LABEL "Inspection" FORMAT "x(2)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 12.1
         BGCOLOR 15  ROW-HEIGHT-CHARS .75.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_pol AT ROW 5.86 COL 47.33 NO-LABEL WIDGET-ID 72
     fi_post AT ROW 8.29 COL 120.5 COLON-ALIGNED NO-LABEL WIDGET-ID 50
     rs_type AT ROW 8.91 COL 3.5 NO-LABEL WIDGET-ID 42
     bu_match AT ROW 1.43 COL 103.33 WIDGET-ID 26
     bu_post AT ROW 9.29 COL 104.5 WIDGET-ID 28
     fi_trndatfr AT ROW 1.52 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.52 COL 60.67 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.57 COL 91.67
     cb_search AT ROW 3.19 COL 13.17 COLON-ALIGNED NO-LABEL
     bu_oksch AT ROW 4.48 COL 39.67
     br_tlt AT ROW 10.76 COL 1.33
     fi_search AT ROW 4.43 COL 3.17 NO-LABEL
     fi_name AT ROW 4.24 COL 60.5 COLON-ALIGNED NO-LABEL
     bu_update AT ROW 4.29 COL 107.17
     bu_exit AT ROW 1.57 COL 122
     bu_upyesno AT ROW 4.29 COL 119.83
     cb_report AT ROW 5.81 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     ra_status AT ROW 5.76 COL 94.83 NO-LABEL WIDGET-ID 8
     fi_br AT ROW 5.76 COL 86.33 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_outfile AT ROW 6.86 COL 65 NO-LABEL WIDGET-ID 18
     bu_report AT ROW 6.29 COL 123.83 WIDGET-ID 14
     fi_outfile1 AT ROW 8.38 COL 30.5 NO-LABEL WIDGET-ID 32
     fi_producer AT ROW 5.81 COL 63 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_outfile2 AT ROW 9.43 COL 30.5 NO-LABEL WIDGET-ID 48
     fi_comdat1 AT ROW 6.86 COL 11.83 COLON-ALIGNED NO-LABEL
     fi_comdat2 AT ROW 6.86 COL 30.33 COLON-ALIGNED NO-LABEL
     ra_status1 AT ROW 3.05 COL 49.67 NO-LABEL WIDGET-ID 64
     "Click for update Flag Cancel":40 VIEW-AS TEXT
          SIZE 29.5 BY .95 AT ROW 3.19 COL 62.83
          BGCOLOR 19 FONT 6
     "Postdocument YR:" VIEW-AS TEXT
          SIZE 17.83 BY .95 AT ROW 8.24 COL 104.5 WIDGET-ID 52
          FGCOLOR 7 FONT 6
     " Producer :" VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 5.81 COL 54.17 WIDGET-ID 38
          BGCOLOR 34 FGCOLOR 1 FONT 6
     "Report Type :" VIEW-AS TEXT
          SIZE 13 BY .67 AT ROW 8.19 COL 3.5 WIDGET-ID 70
          FGCOLOR 7 FONT 1
     "«—π∑’Ë‰ø≈Ï·®Èßß“π  From :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.52 COL 4
          BGCOLOR 34 FONT 6
     "Search By :" VIEW-AS TEXT
          SIZE 11.33 BY 1 AT ROW 3.19 COL 3.17
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Report BY :" VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 5.86 COL 2.33 WIDGET-ID 4
          BGCOLOR 34 FGCOLOR 1 FONT 6
     "BR :" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 5.76 COL 83.33 WIDGET-ID 22
          BGCOLOR 34 FGCOLOR 1 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY 1 AT ROW 6.86 COL 28.17 WIDGET-ID 60
          BGCOLOR 34 FONT 6
     "Date From :" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 6.91 COL 2.5 WIDGET-ID 62
          BGCOLOR 34 FONT 6
     "Output :" VIEW-AS TEXT
          SIZE 8 BY .95 AT ROW 6.86 COL 56.5 WIDGET-ID 24
          BGCOLOR 34 FGCOLOR 1 FONT 6
     "Output CSV :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 9.33 COL 17.5 WIDGET-ID 54
          FGCOLOR 7 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 1.52 COL 54.17
          BGCOLOR 34 FONT 6
     "Output SLK :" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 8.38 COL 17.5 WIDGET-ID 34
          FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1 COL 1.17
     RECT-338 AT ROW 2.91 COL 2
     RECT-339 AT ROW 3 COL 61.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 22.29
         BGCOLOR 51 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     RECT-340 AT ROW 1.19 COL 1.83
     RECT-341 AT ROW 1.14 COL 120.33
     RECT-381 AT ROW 4.33 COL 39
     RECT-382 AT ROW 5.76 COL 122.83 WIDGET-ID 20
     RECT-384 AT ROW 8.1 COL 1.5 WIDGET-ID 40
     RECT-385 AT ROW 5.67 COL 1.83 WIDGET-ID 46
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133.17 BY 22.29
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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [Tisco]"
         HEIGHT             = 22.29
         WIDTH              = 133.17
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
         FONT               = 6
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-wins:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
/* BROWSE-TAB br_tlt bu_oksch fr_main */
/* SETTINGS FOR FILL-IN fi_name IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_outfile IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_outfile1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_outfile2 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.tlt.releas
"tlt.releas" "Release\CA" "x(20)" "character" ? ? ? ? ? ? no ? no no "10.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.hclfg
"tlt.hclfg" "Problem" "x(2)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > "_<CALC>"
"IF trim(brstat.tlt.flag) = ""NW"" THEN ""NEW"" ELSE IF trim(brstat.tlt.flag) = ""RW"" THEN ""RENEW"" ELSE IF trim(brstat.tlt.flag) = ""TF"" THEN  ""SWITF"" ELSE IF trim(brstat.tlt.flag) = ""UC"" THEN  ""USEDCAR"" ELSE ""REFINANCE""" "Type" "x(8)" ? ? ? ? ? 1 6 no ? no no "10.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.rec_addr4
"tlt.rec_addr4" "Business type" "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.ins_brins
"tlt.ins_brins" "Branch" ? "character" ? ? ? ? ? ? no ? no no "6.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "‡≈¢√—∫·®Èß" ? "character" ? ? ? ? ? ? no ? no no "13.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.policy
"tlt.policy" ? ? "character" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.comp_pol
"tlt.comp_pol" ? ? "character" ? ? ? ? ? ? no ? no no "17.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.ins_firstname
"tlt.ins_firstname" ? ? "character" ? ? ? ? ? ? no ? no no "21" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.ins_lastname
"tlt.ins_lastname" ? ? "character" ? ? ? ? ? ? no ? no no "23.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > brstat.tlt.cha_no
"tlt.cha_no" ? ? "character" ? ? ? ? ? ? no ? no no "20.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   > brstat.tlt.gendat
"tlt.gendat" "Comm.Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[13]   > brstat.tlt.expodat
"tlt.expodat" "Exp.Date" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "9.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   > brstat.tlt.comp_sck
"tlt.comp_sck" ? "x(15)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[15]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "Coverage amount" ? "decimal" ? ? ? ? ? ? no ? no no "21.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > brstat.tlt.nor_grprm
"tlt.nor_grprm" "Gross premium" ">>,>>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   > brstat.tlt.comp_grprm
"tlt.comp_grprm" ? ">>>,>>9.99" "decimal" ? ? ? ? ? ? no ? no no "17.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[18]   > brstat.tlt.comp_coamt
"tlt.comp_coamt" ? ? "decimal" ? ? ? ? ? ? no ? no no "20.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[19]   > brstat.tlt.note1
"tlt.note1" "Prv.Policy" "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[20]   > brstat.tlt.note7
"tlt.note7" "Inspection" "x(2)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [Tisco] */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [Tisco] */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_tlt
&Scoped-define SELF-NAME br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON LEFT-MOUSE-DBLCLICK OF br_tlt IN FRAME fr_main
DO:
    Get Current br_tlt.
          nv_recidtlt  =  Recid(tlt).

    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\wgwqtpis1(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON MOUSE-SELECT-CLICK OF br_tlt IN FRAME fr_main
DO:
    Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  trim(tlt.ins_firstname) + " " + TRIM(tlt.ins_lastname).
     disp  fi_name  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     fi_name   =  trim(tlt.ins_firstname) + " " + TRIM(tlt.ins_lastname).
     disp  fi_name  with frame  fr_main.
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


&Scoped-define SELF-NAME bu_match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_match c-wins
ON CHOOSE OF bu_match IN FRAME fr_main /* MATCH POLICY */
DO:
    For each brstat.tlt Use-index  tlt01  Where
        brstat.tlt.trndat  >=   fi_trndatfr   And
        brstat.tlt.trndat  <=   fi_trndatto   And
        brstat.tlt.genusr   =  "TPIS"        .
        IF trim(brstat.tlt.safe1) = "V+C" THEN DO:

            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = trim(tlt.nor_noti_tlt)   AND 
                sicuw.uwm100.poltyp       = "V72"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO: 
                ASSIGN  
                    brstat.tlt.comp_pol    = sicuw.uwm100.policy .
            END.
        
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = trim(tlt.nor_noti_tlt)   AND 
                sicuw.uwm100.poltyp       = "V70"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO: 
                FIND LAST sicuw.uwm301 USE-INDEX uwm30101       WHERE
                    sicuw.uwm301.policy = sicuw.uwm100.policy AND
                    sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                    sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:
                    ASSIGN  
                        brstat.tlt.policy    = sicuw.uwm100.policy
                        brstat.tlt.ins_brins = sicuw.uwm100.branch
                        brstat.tlt.acno1     = sicuw.uwm100.acno1  
                        brstat.tlt.agent     = sicuw.uwm100.agent
                        brstat.tlt.hclfg     = "N"
                        brstat.tlt.safe2     = sicuw.uwm301.garage 
                        brstat.tlt.note17    = STRING(sicuw.uwm100.entdat,"99/99/9999")
                        brstat.tlt.note18    = IF sicuw.uwm100.releas = YES THEN STRING(sicuw.uwm100.reldat,"99/99/9999") ELSE "" 
                        brstat.tlt.releas    = IF index(brstat.tlt.releas,"NO") <> 0 THEN trim(REPLACE(brstat.tlt.releas,"NO","YES")) ELSE brstat.tlt.releas.
                END.
            END.
        END.
        ELSE IF trim(brstat.tlt.safe1) = "V" THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = trim(tlt.nor_noti_tlt)   AND 
                sicuw.uwm100.poltyp       = "V70"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO:
                FIND LAST sicuw.uwm301 USE-INDEX uwm30101       WHERE
                    sicuw.uwm301.policy = sicuw.uwm100.policy AND
                    sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                    sicuw.uwm301.endcnt = sicuw.uwm100.endcnt NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL uwm301 THEN DO:
                    ASSIGN  
                        brstat.tlt.policy    = sicuw.uwm100.policy
                        brstat.tlt.ins_brins = sicuw.uwm100.branch
                        brstat.tlt.acno1     = sicuw.uwm100.acno1  
                        brstat.tlt.agent     = sicuw.uwm100.agent
                        brstat.tlt.hclfg     = "N"
                        brstat.tlt.safe2     = sicuw.uwm301.garage 
                        brstat.tlt.note17    = STRING(sicuw.uwm100.entdat,"99/99/9999")
                        brstat.tlt.note18    = IF sicuw.uwm100.releas = YES THEN STRING(sicuw.uwm100.reldat,"99/99/9999") ELSE "" 
                        brstat.tlt.releas    = IF index(brstat.tlt.releas,"NO") <> 0 THEN trim(REPLACE(brstat.tlt.releas,"NO","YES")) ELSE brstat.tlt.releas.
                END.
            END.
        END.
        ELSE IF trim(brstat.tlt.safe1) = "C" THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = trim(tlt.nor_noti_tlt)   AND 
                sicuw.uwm100.poltyp       = "V72"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL uwm100 THEN DO: 
                ASSIGN  
                    brstat.tlt.comp_pol  = sicuw.uwm100.policy
                    brstat.tlt.ins_brins = sicuw.uwm100.branch
                    brstat.tlt.acno1     = sicuw.uwm100.acno1  
                    brstat.tlt.agent     = sicuw.uwm100.agent
                    brstat.tlt.hclfg     = "N"
                    brstat.tlt.note17    = STRING(sicuw.uwm100.entdat,"99/99/9999")
                    brstat.tlt.note18    = IF sicuw.uwm100.releas = YES THEN STRING(sicuw.uwm100.reldat,"99/99/9999") ELSE "" 
                    brstat.tlt.releas    = IF index(brstat.tlt.releas,"NO") <> 0 THEN trim(REPLACE(brstat.tlt.releas,"NO","YES")) ELSE brstat.tlt.releas.
            END.
        END.
       
    END.
    MESSAGE "Complete" VIEW-AS ALERT-BOX.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    Open Query br_tlt 
        For each tlt Use-index  tlt01  Where
        tlt.trndat  >=   fi_trndatfr   And
        tlt.trndat  <=   fi_trndatto   And
        tlt.genusr   =  "TPIS"        no-lock.  
            nv_rectlt =  recid(tlt).   
            Apply "Entry"  to br_tlt.
            Return no-apply.    
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_oksch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_oksch c-wins
ON CHOOSE OF bu_oksch IN FRAME fr_main /* Search */
DO:
    Disp fi_search  with frame fr_main.
    If  cb_search = "TPIS No."  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01    Where                                     
            tlt.trndat  >=  fi_trndatfr      And                                            
            tlt.trndat  <=  fi_trndatto      And  
            tlt.genusr   =  "TPIS"           And
            index(tlt.nor_noti_tlt,TRIM(fi_search)) <> 0 no-lock. 
            ASSIGN nv_rectlt =  recid(tlt) .   
            Apply "Entry"  to br_tlt.
            Return no-apply.
    END.
    ELSE If  cb_search = "Customer Name"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01    Where                                     
            tlt.trndat  >=  fi_trndatfr      And                                            
            tlt.trndat  <=  fi_trndatto      And  
            tlt.genusr   =  "TPIS"           And
            index(tlt.ins_firstname,trim(fi_search)) <> 0 no-lock.
            ASSIGN nv_rectlt =  recid(tlt) .   
            Apply "Entry"  to br_tlt.
            Return no-apply.
    END.
    ELSE If  cb_search  =  "Policy New"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "TPIS"      And
            index(tlt.policy,trim(fi_search)) <> 0  no-lock.
            ASSIGN nv_rectlt =  recid(tlt) .   
            Apply "Entry"  to br_tlt.
            Return no-apply.        
    END.
    ELSE If  cb_search  =  "Prev Policy"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "TPIS"      And
            index(tlt.note1,trim(fi_search)) <> 0  NO-LOCK.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.              
    END.

    ELSE If  cb_search  =  "New"  Then do:  
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat   >=  fi_trndatfr   And  tlt.trndat   <=  fi_trndatto   And
                tlt.genusr    =  "TPIS"        And  tlt.flag      =  "NW"          AND
                INDEX(tlt.releas,"yes") <> 0   NO-LOCK.
         END.
         ELSE IF ra_status1 = 2 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND tlt.flag      =  "NW"         AND
                INDEX(brstat.tlt.releas,"no") <> 0 NO-LOCK.
         END.
         ELSE IF ra_status1 = 3 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "NW"         AND
                index(brstat.tlt.releas,"cancel") <> 0 NO-LOCK.
         END.
         ELSE DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "NW"         NO-LOCK.
         END.
         ASSIGN nv_rectlt =  recid(tlt) .  
         Apply "Entry"  to br_tlt.
         Return no-apply.              
    END.
    ELSE If  cb_search  =  "Renew"  Then do:   
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "RW"         AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
         END.
         ELSE IF ra_status1 = 2 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "RW"         AND
                INDEX(brstat.tlt.releas,"no") <> 0 NO-LOCK.
         END.
         ELSE IF ra_status1 = 3 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "RW"         AND
                index(brstat.tlt.releas,"cancel") <> 0 NO-LOCK.
         END.
         ELSE DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "RW"        NO-LOCK.
         END.
         ASSIGN nv_rectlt =  recid(tlt) .  
         Apply "Entry"  to br_tlt.
         Return no-apply.              
    END.
    ELSE If  cb_search  =  "SWITF"  Then do: 
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "TF"         AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
        END.
        ELSE IF ra_status1 = 2 THEN DO: 
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND   tlt.flag      =  "TF"         AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
        END.
        ELSE IF ra_status1 = 3 THEN DO: 
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "TF"         AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
        END.
        ELSE DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  AND tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND tlt.flag      =  "TF"         NO-LOCK.
        END.
        ASSIGN nv_rectlt =  recid(tlt) .  
        Apply "Entry"  to br_tlt.
        Return no-apply.              
    END.
    ELSE If  cb_search  =  "UsedCar"  Then do: 
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  AND tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND tlt.flag      =  "UC"         AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
         END.
         ELSE IF ra_status1 = 2 THEN DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  AND tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND tlt.flag      =  "UC"         AND
                INDEX(brstat.tlt.releas,"no") <> 0   NO-LOCK.
         END.
         ELSE IF ra_status1 = 3 THEN DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And
                tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And
                tlt.flag      =  "UC"         AND
                index(brstat.tlt.releas,"cancel") <> 0  NO-LOCK.
         END.
         ELSE DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  AND tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND tlt.flag      =  "UC"         NO-LOCK.
         END.
         ASSIGN nv_rectlt =  recid(tlt) .  
         Apply "Entry"  to br_tlt.
         Return no-apply.              
    END.
    ELSE If  cb_search  =  "Refinance"  Then do:   
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "RF"         AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
        END.
        ELSE IF ra_status1 = 2 THEN DO: 
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND   tlt.flag      =  "RF"         AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
        END.
        ELSE IF ra_status1 = 3 THEN DO: 
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "RF"         AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
        END.
        ELSE DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND   tlt.flag      =  "RF"         NO-LOCK.
        END.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.              
    END.
    ELSE If  cb_search  = "Chassis no."  Then do:  /* chassis no */
        Open Query br_tlt 
            For each tlt Use-index  tlt06 Where
            tlt.trndat >=  fi_trndatfr    And
            tlt.trndat <=  fi_trndatto    AND 
            tlt.genusr   =  "TPIS"       And
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  NO-LOCK.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.              
    END.
    ELSE If  cb_search  =  "Release_yes"  Then do:   /* Confirm yes..*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "TPIS"         And
            INDEX(tlt.releas,"yes") <> 0   NO-LOCK.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.              
    END.
    ELSE If  cb_search  =  "Release_no"  Then do:     /* confirm no...*/
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat >=  fi_trndatfr     And
            tlt.trndat <=  fi_trndatto     And
            tlt.genusr   =  "TPIS"         And
            INDEX(tlt.releas,"no")  <> 0   NO-LOCK.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.              
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "TPIS"        And
            index(tlt.releas,"cancel") <> 0     NO-LOCK.
            ASSIGN nv_rectlt =  recid(tlt) .  
            Apply "Entry"  to br_tlt.
            Return no-apply.                           
    END.
    ELSE If  cb_search  =  "Status_Problem"  Then do:    /* cancel */
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                index(tlt.hclfg,"Y") <> 0     AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
        END.
        ELSE IF ra_status1 = 2 THEN DO: 
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                index(tlt.hclfg,"Y") <> 0     AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
        END.
        ELSE IF ra_status1 = 3 THEN DO: 
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                index(tlt.hclfg,"Y") <> 0     AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
        END.
        ELSE DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                index(tlt.hclfg,"Y") <> 0     NO-LOCK.
        END.
        ASSIGN nv_rectlt =  recid(tlt) .  
        Apply "Entry"  to br_tlt.
        Return no-apply.                                
    END.
    ELSE If  cb_search  =  "Branch"  Then do:    /* cancel */
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                tlt.ins_brins  = trim(fi_search)  AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
         END.
         ELSE IF ra_status1 = 2 THEN DO:
              Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                tlt.ins_brins  = trim(fi_search)  AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
         END.
         ELSE IF ra_status1 = 3 THEN DO:
              Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                tlt.ins_brins  = trim(fi_search)  AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
         END.
         ELSE DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"        And
                tlt.ins_brins  = trim(fi_search)  NO-LOCK.
         END.
         ASSIGN nv_rectlt =  recid(tlt) .  
         Apply "Entry"  to br_tlt.
         Return no-apply.                           
    END.
    ELSE If  cb_search  =  "ISP/Yes"  Then do:    /* cancel */
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01   Where
                tlt.trndat  >=  fi_trndatfr     And
                tlt.trndat  <=  fi_trndatto     And
                tlt.genusr   =  "TPIS"          And
                tlt.note7  = "Y"                AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
         END.
         ELSE IF  ra_status1 = 2 THEN DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01   Where
                tlt.trndat  >=  fi_trndatfr     And
                tlt.trndat  <=  fi_trndatto     And
                tlt.genusr   =  "TPIS"          And
                tlt.note7  = "Y"                AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
         END.
         ELSE IF  ra_status1 = 3 THEN DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01   Where
                tlt.trndat  >=  fi_trndatfr     And
                tlt.trndat  <=  fi_trndatto     And
                tlt.genusr   =  "TPIS"          And
                tlt.note7  = "Y"                AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
         END.
         ELSE DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01   Where
                tlt.trndat  >=  fi_trndatfr     And
                tlt.trndat  <=  fi_trndatto     And
                tlt.genusr   =  "TPIS"          And
                tlt.note7  = "Y"                NO-LOCK.
         END.
         ASSIGN nv_rectlt =  recid(tlt) .  
         Apply "Entry"  to br_tlt.
         Return no-apply.                                     
    END.
    ELSE If  cb_search  =  "ISP/No"  Then do:    /* cancel */
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                tlt.note7  = "N"               AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
        END.
        ELSE IF  ra_status1 = 2 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                tlt.note7  = "N"               AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
        END.
        ELSE IF  ra_status1 = 3 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                tlt.note7  = "N"               AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
        END.
        ELSE DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                tlt.note7  = "N"               NO-LOCK.
        END.
        ASSIGN nv_rectlt =  recid(tlt) .  
        Apply "Entry"  to br_tlt.
        Return no-apply.                             
    END.
    ELSE DO:
        RUN proc_chktrn.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_post
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_post c-wins
ON CHOOSE OF bu_post IN FRAME fr_main /* Match Send TPIS */
DO:
    DEF var ins_addr1 AS CHAR INIT "".
    DEF var ins_addr2 AS CHAR INIT "".
    DEF VAR n_length AS INT.

    IF fi_post = "" THEN DO:
        MESSAGE "°√ÿ≥“√–∫ÿª’¢Õß°≈ËÕß Post document" VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_post.
        Return no-apply.

    END.
    IF fi_outfile1 = "" THEN DO:
        MESSAGE "°√ÿ≥“√–∫ÿ™◊ËÕ‰ø≈Ï" VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile1.
        Return no-apply. 
    END.
    ELSE DO:

       FOR EACH wdetail:
           DELETE wdetail.
       END.

       For each tlt Use-index  tlt01  Where
          tlt.trndat  >=   fi_trndatfr   And
          tlt.trndat  <=   fi_trndatto   And
          tlt.genusr   =  "TPIS"         NO-LOCK.

          IF rs_type = 1 THEN DO:
            IF  tlt.flag <> "NW" THEN NEXT.
          END.
          ELSE DO:
              IF tlt.flag = "NW" THEN NEXT.
          END.

          ASSIGN 
            nv_Maddr1   = ""
            nv_Maddr2   = ""
            nv_Maddr3   = ""
            nv_Maddr4   = ""
            nv_Maddr5   = ""
            ins_addr1   = ""
            ins_addr2   = ""
            n_length    = 0   
            ins_addr1   = brstat.tlt.ins_addr1
            ins_addr2   = brstat.tlt.ins_addr2

            nv_Maddr5   = SUBSTR(ins_addr2,R-INDEX(ins_addr2,"MR:"))
            n_length    = LENGTH(nv_Maddr5)
            ins_addr2   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2) - n_length) 
            nv_Maddr4   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2)) 

            nv_Maddr3   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MM:"))
            n_length    = LENGTH(nv_Maddr3)
            ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
            nv_Maddr2   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MB:"))
            n_length    = LENGTH(nv_Maddr2)
            ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
            nv_Maddr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1)).

            if index(nv_Maddr1,"MH:") <> 0  then  nv_Maddr1 =  trim(REPLACE(nv_Maddr1,"MH:","")) .
            if index(nv_Maddr2,"MB:") <> 0  then  nv_Maddr2 =  trim(REPLACE(nv_Maddr2,"MB:","")) .
            if index(nv_Maddr3,"MM:") <> 0  then  nv_Maddr3 =  trim(REPLACE(nv_Maddr3,"MM:","")) .
            if index(nv_Maddr4,"MS:") <> 0  then  nv_Maddr4 =  trim(REPLACE(nv_Maddr4,"MS:","")) .
            if index(nv_Maddr5,"MR:") <> 0  then  nv_Maddr5 =  trim(REPLACE(nv_Maddr5,"MR:","")) .


          CREATE wdetail.
          ASSIGN 
            wdetail.ins_ytyp         = trim(brstat.tlt.ins_typ)      
            wdetail.bus_typ          = trim(brstat.tlt.rec_addr4)   
            wdetail.TASreceived      = trim(brstat.tlt.rec_addr3)     
            wdetail.InsCompany       = trim(brstat.tlt.subins   )    
            wdetail.Insurancerefno   = trim(brstat.tlt.nor_usr_ins  )      
            wdetail.tpis_no          = trim(brstat.tlt.nor_noti_tlt )   
            wdetail.ntitle           = trim(brstat.tlt.ins_title)   
            wdetail.insnam           = trim(brstat.tlt.ins_firstname)   
            wdetail.NAME2            = trim(brstat.tlt.ins_lastname )   
            wdetail.cust_type        = trim(brstat.tlt.id_typ   )   
            wdetail.nDirec           = trim(brstat.tlt.nor_usr_tlt  )   
            wdetail.ICNO             = trim(brstat.tlt.ins_icno )   
            wdetail.address          = trim(brstat.tlt.hrg_no   )   
            wdetail.build            = trim(brstat.tlt.hrg_moo  )   
            wdetail.mu               = trim(brstat.tlt.hrg_vill )   
            wdetail.soi              = trim(brstat.tlt.hrg_soi  )   
            wdetail.road             = trim(brstat.tlt.hrg_street )   
            wdetail.tambon           = trim(brstat.tlt.hrg_subdistrict) 
            wdetail.amper            = trim(brstat.tlt.hrg_district) 
            wdetail.country          = trim(brstat.tlt.hrg_prov) 
            wdetail.post             = trim(brstat.tlt.hrg_postcd  ) 
            wdetail.brand            = trim(brstat.tlt.brand )  
            wdetail.model            = trim(brstat.tlt.model )  
            wdetail.class            = trim(brstat.tlt.pack  )  
            wdetail.md_year          = trim(brstat.tlt.old_eng ) 
            wdetail.Usage            = trim(brstat.tlt.vehuse  ) 
            wdetail.coulor           = trim(brstat.tlt.colordes) 
            wdetail.cc               = STRING(brstat.tlt.cc_weight,">>>>>>>9.99")      
            wdetail.regis_year       = TRIM(brstat.tlt.old_cha )
            wdetail.engno            = trim(brstat.tlt.eng_no  )                    
            wdetail.chasno           = trim(brstat.tlt.cha_no  )                    
            wdetail.Acc_CV           = trim(brstat.tlt.filler1 )                    
            wdetail.Acc_amount       = trim(brstat.tlt.filler2 )                    
            wdetail.License         = trim(brstat.tlt.lince1  )                  
            wdetail.regis_CL        = trim(brstat.tlt.lince2  )        
            wdetail.campaign        = trim(brstat.tlt.packnme )         /*campaign TPIS*/
            wdetail.typ_work        = trim(brstat.tlt.safe1   )              
            wdetail.garage          = trim(brstat.tlt.safe2   )             
            wdetail.desmodel        = trim(brstat.tlt.safe3   )                
            wdetail.si              = string(brstat.tlt.nor_coamt,">>>>>>>>>9.99-")               
            wdetail.pol_comm_date   = string(brstat.tlt.gendat,"99/99/9999")                  
            wdetail.pol_exp_date    = string(brstat.tlt.expodat,"99/99/9999")                 
            wdetail.last_pol        = trim(brstat.tlt.note1) 
            wdetail.cover           = trim(brstat.tlt.covcod    )  
            wdetail.pol_netprem     = string(brstat.tlt.nor_grprm )  
            wdetail.pol_gprem       = string(brstat.tlt.ndeci1 ,">>>>>>9.99-")  
            wdetail.pol_stamp       = string(brstat.tlt.ndeci2 ,">>>>>>9.99-")  
            wdetail.pol_vat         = string(brstat.tlt.ndeci3 ,">>>>>>9.99-")  
            wdetail.pol_wht         = string(brstat.tlt.ndeci4 ,">>>>>>9.99-")  
            wdetail.com_no          = trim(brstat.tlt.comp_pol )
            wdetail.com_comm_date   = string(brstat.tlt.nor_effdat,"99/99/9999")              
            wdetail.com_exp_date    = string(brstat.tlt.comp_effdat,"99/99/9999")             
            wdetail.com_netprem     = string(brstat.tlt.comp_coamt,">>>>>>>>9.99-")              
            wdetail.com_gprem       = string(brstat.tlt.comp_grprm,">>>>>>>>9.99-")              
            wdetail.com_stamp       = string(brstat.tlt.rstp,">>>>>9.99-")                    
            wdetail.com_vat         = string(brstat.tlt.rtax,">>>>>9.99-")                    
            wdetail.com_wht         = string(brstat.tlt.tax_coporate,">>>>9.99-")            
            wdetail.deler           = trim(brstat.tlt.note2)             
            wdetail.showroom        = trim(brstat.tlt.note3)                
            wdetail.typepay         = trim(brstat.tlt.note4)              
            wdetail.financename     = trim(brstat.tlt.ben83)                  
            wdetail.mail_hno        = trim(nv_Maddr1)      /* brstat.tlt.ins_addr1  = "MH:"  */
            wdetail.mail_build      = trim(nv_Maddr2)      /*                         "MB:"  */    
            wdetail.mail_mu         = trim(nv_Maddr3)      /*                         "MM:"  */
            wdetail.mail_soi        = trim(nv_Maddr4)      /* brstat.tlt.ins_addr2  = "MS:"  */
            wdetail.mail_road       = trim(nv_Maddr5)      /*                       "  MR:"  */
            wdetail.mail_tambon     = trim(brstat.tlt.ins_addr3)                    
            wdetail.mail_amper      = trim(brstat.tlt.ins_addr4)        
            wdetail.mail_country    = trim(brstat.tlt.ins_addr5)          
            wdetail.mail_post       = trim(brstat.tlt.lince3   )       
            wdetail.send_date       = STRING(brstat.tlt.datesent,"99/99/9999")              
            wdetail.policy_no       = TRIM(brstat.tlt.policy)                         
            wdetail.send_data       = STRING(brstat.tlt.ndate2,"99/99/9999")                
            wdetail.REMARK1         = trim(brstat.tlt.note5  )               
            wdetail.occup           = trim(brstat.tlt.ins_occ)       
            wdetail.regis_no        = trim(brstat.tlt.note16 )
            wdetail.Driver1_title       =   brstat.tlt.dri_title1 
            wdetail.Driver1_name        =   brstat.tlt.dri_fname1 
            wdetail.Driver1_lastname    =   brstat.tlt.dri_lname1 
            wdetail.Driver1_birthdate   =   brstat.tlt.dri_birth1 
            wdetail.Driver1_id_no       =   brstat.tlt.dri_no1    
            wdetail.Driver1_license_no  =   brstat.tlt.dri_lic1   
            wdetail.Driver1_occupation  =   brstat.tlt.dir_occ1   
            wdetail.Driver2_title       =   brstat.tlt.dri_title2 
            wdetail.Driver2_name        =   brstat.tlt.dri_fname2 
            wdetail.Driver2_lastname    =   brstat.tlt.dri_lname2 
            wdetail.Driver2_birthdate   =   brstat.tlt.dri_birth2 
            wdetail.Driver2_id_no       =   brstat.tlt.dri_no2    
            wdetail.Driver2_license_no  =   brstat.tlt.dri_lic2   
            wdetail.Driver2_occupation  =   brstat.tlt.dri_occ2   
            wdetail.Driver3_title       =   brstat.tlt.dri_title3 
            wdetail.Driver3_name        =   brstat.tlt.dri_fname3 
            wdetail.Driver3_lastname    =   brstat.tlt.dri_lname3 
            wdetail.Driver3_birthdate   =   brstat.tlt.dri_birth3 
            wdetail.Driver3_id_no       =   brstat.tlt.dri_no3    
            wdetail.Driver3_license_no  =   brstat.tlt.dri_lic3   
            wdetail.Driver3_occupation  =   brstat.tlt.dir_occ3   
            wdetail.Driver4_title       =   brstat.tlt.dri_title4 
            wdetail.Driver4_name        =   brstat.tlt.dri_fname4 
            wdetail.Driver4_lastname    =   brstat.tlt.dri_lname4 
            wdetail.Driver4_birthdate   =   brstat.tlt.dri_birth4 
            wdetail.Driver4_id_no       =   brstat.tlt.dri_no4    
            wdetail.Driver4_license_no  =   brstat.tlt.dri_lic4   
            wdetail.Driver4_occupation  =   brstat.tlt.dri_occ4   
            wdetail.Driver5_title       =   brstat.tlt.dri_title5 
            wdetail.Driver5_name        =   brstat.tlt.dri_fname5 
            wdetail.Driver5_lastname    =   brstat.tlt.dri_lname5 
            wdetail.Driver5_birthdate   =   brstat.tlt.dri_birth5 
            wdetail.Driver5_id_no       =   brstat.tlt.dri_no5    
            wdetail.Driver5_license_no  =   brstat.tlt.dri_lic5   
            wdetail.Driver5_occupation  =   brstat.tlt.dri_occ5 .  

       END.
       
       IF rs_type = 1 THEN DO:
            RUN proc_createslk_N.
       END.
       ELSE DO:
            RUN proc_createslk_re.   
       END.
    END.
    
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_report c-wins
ON CHOOSE OF bu_report IN FRAME fr_main /* OK */
DO:
    IF fi_outfile = "" THEN DO:
        MESSAGE "°√ÿ≥“„ ™◊ËÕ‰ø≈Ï!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_outfile.
        Return no-apply. 
    END.
    ELSE IF cb_report = "Comm.Date" AND fi_comdat1 = ? THEN DO:
        MESSAGE "°√ÿ≥“„ Ë«—π∑’Ë§ÿÈ¡§√Õß!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_comdat1.
        Return no-apply.
    END.
    ELSE DO:
        RUN pd_reportfile. 
        Message "Export data Complete"  View-as alert-box.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update c-wins
ON CHOOSE OF bu_update IN FRAME fr_main /* CANCEL */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt .
    If  avail tlt Then do:
        If  index(tlt.releas,"CANCEL")  =  0  Then do:
            message "¬°‡≈‘°¢ÈÕ¡Ÿ≈√“¬°“√π’È  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "CANCEL" .
            ELSE tlt.releas  =  "CANCEL/" + tlt.releas .
        END.
        Else do:
            message "‡√’¬°¢ÈÕ¡Ÿ≈°≈—∫¡“„™Èß“π "  View-as alert-box.
            IF index(tlt.releas,"CANCEL/")  =  0 THEN
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"CANCEL") + 6 ) .
            ELSE 
                tlt.releas =  substr(tlt.releas,index(tlt.releas,"CANCEL") + 7 ) .
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return no-apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_upyesno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_upyesno c-wins
ON CHOOSE OF bu_upyesno IN FRAME fr_main /* YES/NO */
DO:
    Find tlt Where Recid(tlt)  =  nv_rectlt.
    If  avail tlt Then do:
        If  index(tlt.releas,"NO")  =  0  Then do:  /* yes */
            message "Update NO ¢ÈÕ¡Ÿ≈√“¬°“√π’È  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "NO" .
            ELSE IF index(tlt.releas,"CANCEL/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "CANCEL/NO" .
            ELSE ASSIGN tlt.releas  =  "NO" .
        END.
        Else do:    /* NO */
            If  index(tlt.releas,"YES")  =  0  Then do:  /* YES */
            message "Update YES ¢ÈÕ¡Ÿ≈√“¬°“√π’È  "  View-as alert-box.
            IF tlt.releas = "" THEN tlt.releas  =  "YES" .
            ELSE IF index(tlt.releas,"CANCEL/")  <> 0 THEN 
                ASSIGN tlt.releas  =  "CANCEL/YES" .
            ELSE ASSIGN tlt.releas  =  "YES" .
        END.
        END.
    END.
    RELEASE tlt.
    Run Pro_OpenQuery2.
    Apply "Entry"  to br_tlt.
    Return NO-apply. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
  /*p-------------*/
    cb_report = INPUT cb_report.
    n_asdat1  = INPUT cb_report.

    IF n_asdat1 = "" THEN DO:
        MESSAGE "‰¡Ëæ∫¢ÈÕ¡Ÿ≈ °√ÿ≥“µ√«® Õ∫°“√ Process ¢ÈÕ¡Ÿ≈" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    
    IF cb_report = "Comm.Date"  THEN DO:
       ENABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   END.
   ELSE IF cb_report = "Trans Date"  THEN DO:
       ENABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   END.
   ELSE IF cb_report = "Release Date"  THEN DO:
       ENABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   END.
   ELSE DO:
       DISABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   END.

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
    n_asdat1 =  (INPUT cb_report).

    IF n_asdat1 = "" THEN DO:
        MESSAGE "‰¡Ëæ∫¢ÈÕ¡Ÿ≈ °“√§Èπ" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.

   IF cb_report = "Comm.Date"  THEN DO:
       ENABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   END.
   ELSE IF cb_report = "Trans Date"  THEN DO:
       ENABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   END.
   ELSE IF cb_report = "Release Date"  THEN DO:
       ENABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   END.
   ELSE DO:
       DISABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
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
        MESSAGE "‰¡Ëæ∫¢ÈÕ¡Ÿ≈ °√ÿ≥“µ√«® Õ∫°“√ Process ¢ÈÕ¡Ÿ≈" VIEW-AS ALERT-BOX WARNING.
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
  /*p-------------*/
    cb_search = INPUT cb_search.
    n_asdat =  (INPUT cb_search).

    IF n_asdat = "" THEN DO:
        MESSAGE "‰¡Ëæ∫¢ÈÕ¡Ÿ≈ °“√§Èπ" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_br
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_br c-wins
ON LEAVE OF fi_br IN FRAME fr_main
DO:
  fi_br = INPUT fi_br .
  DISP fi_br WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat1 c-wins
ON LEAVE OF fi_comdat1 IN FRAME fr_main
DO:
  fi_comdat1  =  Input  fi_comdat1.
  If  fi_comdat2  =  ?  Then  fi_comdat2  =  fi_comdat1.
  Disp fi_comdat1  fi_comdat2  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comdat2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comdat2 c-wins
ON LEAVE OF fi_comdat2 IN FRAME fr_main
DO:
  If  Input  fi_comdat2  <  fi_comdat1  Then  fi_comdat2  =  fi_comdat1.
  Else  fi_comdat2 =  Input  fi_comdat2  .

  Disp  fi_comdat2  with frame fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_name c-wins
ON LEAVE OF fi_name IN FRAME fr_main
DO:
  /*fi_polfr  =  Input  fi_polfr.
  Disp  fi_polfr  with frame  fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile c-wins
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile1 c-wins
ON LEAVE OF fi_outfile1 IN FRAME fr_main
DO:
  fi_outfile1 = INPUT fi_outfile1.
  DISP fi_outfile1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile2 c-wins
ON LEAVE OF fi_outfile2 IN FRAME fr_main
DO:
  fi_outfile = INPUT fi_outfile.
  DISP fi_outfile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_post
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_post c-wins
ON LEAVE OF fi_post IN FRAME fr_main
DO:
    fi_post = INPUT fi_post .
    DISP fi_post WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-wins
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
  fi_producer = INPUT fi_producer .
  DISP fi_producer WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    DEF VAR  nv_sort   as  int  init 0.
    ASSIGN
        fi_search     =  Input  fi_search.
    /*add A55-0184 */
    Disp fi_search  with frame fr_main.
    /*
    If  cb_search = "Customer Name"  Then do:              /* name  */                          
        Open Query br_tlt                                                        
            For each tlt Use-index  tlt01  Where                                     
            tlt.trndat  >=  fi_trndatfr         And                                            
            tlt.trndat  <=  fi_trndatto         And  
            tlt.genusr   =  "TPIS"             And
            index(tlt.ins_name,fi_search) <> 0  no-lock.      
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Policy New"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "TPIS"      And
            index(tlt.nor_noti_ins,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "°√¡∏√√¡Ï‡°Ë“"  Then do:   /* policy */
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "TPIS"      And
            index(tlt.rec_addr5,fi_search) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "New"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr  And
            tlt.trndat   <=  fi_trndatto  And
            tlt.genusr    =  "TPIS"      And
            tlt.flag      =  "N"          no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.        
    END.
    ELSE If  cb_search  =  "Renew"  Then do:    
        Open Query br_tlt 
            For each tlt Use-index  tlt01 Where
            tlt.trndat   >=  fi_trndatfr            And 
            tlt.trndat   <=  fi_trndatto            And 
            tlt.genusr    =  "TPIS"                And 
            tlt.flag      =  "R"                    no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  = "‡≈¢µ—«∂—ß"  Then do:  /* chassis no */
        Open Query br_tlt                           
            For each tlt Use-index  tlt06 Where     
            tlt.trndat >=  fi_trndatfr              And 
            tlt.trndat <=  fi_trndatto              AND 
            tlt.genusr   =  "TPIS"                 And 
            INDEX(tlt.cha_no,trim(fi_search)) <> 0  no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .  /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.           
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_yes"  Then do:  /* Confirm yes..*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01  Where    
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "TPIS"                 And 
            INDEX(tlt.releas,"yes") <> 0            no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.            
                Return no-apply.                    
    END.                                            
    ELSE If  cb_search  =  "Confirm_no"  Then do:    /* confirm no...*/
        Open Query br_tlt                           
            For each tlt Use-index  tlt01   Where   
            tlt.trndat  >=  fi_trndatfr             And 
            tlt.trndat  <=  fi_trndatto             And 
            tlt.genusr   =  "TPIS"                 And 
            INDEX(tlt.releas,"no") <> 0             no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .       /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.            
    END.
    ELSE If  cb_search  =  "Status_cancel"  Then do:    /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "TPIS"        And
            index(tlt.releas,"cancel") > 0 no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE If  cb_search  =  "⁄Branch"  Then do:          /* cancel */
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=  fi_trndatfr    And
            tlt.trndat  <=  fi_trndatto    And
            tlt.genusr   =  "TPIS"        And
            tlt.EXP      =  fi_search      no-lock.
                ASSIGN nv_rectlt =  recid(tlt) .     /*add Kridtiya i. A56-0323*/
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    Else  do:
        ASSIGN nv_rectlt =  recid(tlt) .             /*add Kridtiya i. A56-0323*/
        Apply "Entry"  to  fi_search.
        Return no-apply.
    END.*/
    /*A55-0184*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON VALUE-CHANGED OF fi_search IN FRAME fr_main
DO:
  ASSIGN
        fi_search     =  Input  fi_search.
    /*add A55-0184 */
    Disp fi_search  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr c-wins
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
  fi_trndatfr  =  Input  fi_trndatfr.
  If  fi_trndatto  =  ?  Then  fi_trndatto  =  fi_trndatfr.
  Disp fi_trndatfr  fi_trndatto  with frame fr_main.

  ASSIGN 
    fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".slk"   
    fi_outfile2 = "D:\Temp\TPIS\INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .
    
  DISP fi_outfile1 fi_outfile2   with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto c-wins
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
  If  Input  fi_trndatto  <  fi_trndatfr  Then  fi_trndatto  =  fi_trndatfr.
  Else  fi_trndatto =  Input  fi_trndatto  .

  IF rs_type = 1 THEN DO:
      ASSIGN 
        fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                       STRING(DAY(fi_trndatfr),"99") + ".slk"   
        fi_outfile2 = "D:\Temp\TPIS\INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                       STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .
  END.
  ELSE DO:
      ASSIGN 
       fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_RENEW_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                      STRING(DAY(fi_trndatfr),"99") + ".slk"   
       fi_outfile2 = "D:\Temp\TPIS\INFORM_RENEW_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                      STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .
  END.
    
  DISP fi_outfile1 fi_outfile2  fi_trndatto  with frame fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_status
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status c-wins
ON VALUE-CHANGED OF ra_status IN FRAME fr_main
DO:
  ra_status = INPUT ra_status.
  DISP ra_status WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_status1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_status1 c-wins
ON VALUE-CHANGED OF ra_status1 IN FRAME fr_main
DO:
  ra_status1 = INPUT ra_status1.
  DISP ra_status1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_pol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_pol c-wins
ON VALUE-CHANGED OF rs_pol IN FRAME fr_main
DO:
    ASSIGN rs_pol = INPUT rs_pol .
    DISP rs_pol WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type c-wins
ON LEAVE OF rs_type IN FRAME fr_main
DO:
    IF rs_type = 1 THEN DO:
        ASSIGN 
         fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".slk"   
         fi_outfile2 = "D:\Temp\TPIS\INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .
    END.
    ELSE DO:
        ASSIGN 
         fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_RENEW_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".slk"   
        fi_outfile2 = "D:\Temp\TPIS\INFORM_RENEW_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .
    END.
    DISP fi_outfile1 fi_outfile2 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type c-wins
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type .
    DISP rs_type WITH FRAME fr_main.
    IF rs_type = 1 THEN DO:
        ASSIGN 
         fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".slk"   
        fi_outfile2 = "D:\Temp\TPIS\INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .
    END.
    ELSE DO:
        ASSIGN 
        fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_RENEW_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".slk"   
        fi_outfile2 = "D:\Temp\TPIS\INFORM_RENEW_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                   STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .
    END.
    DISP fi_outfile1 fi_outfile2 WITH FRAME fr_main.


   

  
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
  gv_prgid = "WGWQTPIS0".
  gv_prog  = "Query & Update  Detail (Tri Petch Insurance Service Co., Ltd.)".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN 
      fi_trndatfr = TODAY
      fi_trndatto = TODAY
      fi_post     = STRING(YEAR(TODAY),"9999")
      vAcProc_fil = vAcProc_fil 
                                + "TPIS No."   + ","
                                + "Customer Name"  + "," 
                                + "Policy New"     + "," 
                                + "Prev Policy"    + ","
                                + "New"            + ","
                                + "New-LCV"        + ","
                                + "New-CV"         + ","
                                + "Renew"          + "," 
                                + "SWITF"       + ","
                                + "UsedCar"        + ","
                                + "Refinance"      + ","
                                + "Chassis no."    + "," 
                                + "Release_yes"    + "," 
                                + "Release_No"     + "," 
                                + "Status_cancel"  + ","
                                + "Status_Problem" + ","
                                + "Branch"         + ","
                                + "ISP/Yes"        + ","
                                + "ISP/No"         + ","
                                + "Trans Date"     + ","
                                + "Release Date"   + ","
                                
      cb_search:LIST-ITEMS = vAcProc_fil
      cb_search = ENTRY(1,vAcProc_fil)

      vAcProc_fil1 = vAcProc_fil1 
                                + "All"            + ","
                                + "Comm.Date"      + ","
                                + "Trans Date" + ","
                                + "Release Date" + ","
                                + "New-LCV"        + ","
                                + "New-CV"         + "," 
                                + "Renew"        + ","
                                + "SWITF"        + ","
                                + "UsedCar"        + ","
                                + "Refinance"      + ","
                                + "Branch"           + "," 
                                + "Release_yes"    + "," 
                                + "Release_No"     + "," 
                                + "Status_cancel"  + ","
                                + "Status_Problem" + ","
      cb_report:LIST-ITEMS = vAcProc_fil1
      cb_report = ENTRY(1,vAcProc_fil1)
      rs_type   = 1
      ra_status = 4
      ra_status1 = 4
      rs_pol  = 3
      
      fi_outfile = "D:\Temp\tpis_" + 
                    STRING(YEAR(TODAY),"9999") + 
                    STRING(MONTH(TODAY),"99")  + 
                    STRING(DAY(TODAY),"99")    + 
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                    /*SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".slk" *//*A68-0019*/
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".csv"   /*A68-0019*/
      no_add =    STRING(MONTH(TODAY),"99")    + 
                  STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) 
      
        fi_outfile1 = "D:\Temp\TPIS\DATA_INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                       STRING(DAY(fi_trndatfr),"99") + ".slk"   
        fi_outfile2 = "D:\Temp\TPIS\INFORM_FIRST_TMST_" + STRING(YEAR(fi_trndatfr),"9999") + STRING(MONTH(fi_trndatfr),"99") +
                       STRING(DAY(fi_trndatfr),"99") + ".csv" /*.csv*/   .

 DISABLE fi_comdat1 fi_comdat2 WITH FRAME fr_main.
   
    
 Disp fi_trndatfr  fi_trndatto fi_outfile  fi_outfile1 fi_outfile2  cb_report cb_search ra_status rs_type fi_post ra_status1
      rs_pol with frame fr_main.

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  
  Rect-338:Move-to-top().  
  Rect-339:Move-to-top(). 
  RECT-381:Move-to-top().
  
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
  DISPLAY rs_pol fi_post rs_type fi_trndatfr fi_trndatto cb_search fi_search 
          fi_name cb_report ra_status fi_br fi_outfile fi_outfile1 fi_producer 
          fi_outfile2 fi_comdat1 fi_comdat2 ra_status1 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE rs_pol fi_post rs_type bu_match bu_post fi_trndatfr fi_trndatto bu_ok 
         cb_search bu_oksch br_tlt fi_search bu_update bu_exit bu_upyesno 
         cb_report ra_status fi_br fi_outfile bu_report fi_outfile1 fi_producer 
         fi_outfile2 fi_comdat1 fi_comdat2 ra_status1 RECT-332 RECT-338 
         RECT-339 RECT-340 RECT-341 RECT-381 RECT-382 RECT-384 RECT-385 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfile c-wins 
PROCEDURE pd_reportfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF cb_report = "New-LCV" OR cb_report = "New-CV"  THEN DO: 
    If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
        fi_outfile  =  Trim(fi_outfile) + ".csv"  .

    OUTPUT TO VALUE(fi_outfile).
    EXPORT DELIMITER "|" 
        "Ins. Year type "
        "Business type  "
        "TAS received by"
        "Ins company    "
        "Insurance ref no. "
        "TPIS Contract No. "
        "Title name    "  
        "customer name "  
        "customer lastname "
        "Customer type"   
        "Director Name"   
        "ID number    "   
        "House no.    "   
        "Building     "   
        "Village name/no."
        "Soi         "
        "Road        "
        "Sub-district"
        "District    "
        "Province    "
        "Postcode    "
        "Brand       "
        "Car model   "
        "Insurance Code "
        "Model Year  "
        "Usage Type  "
        "Colour      "
        "Car Weight (CC.)  "
        "Year       " 
        "Engine No. " 
        "Chassis No." 
        "Accessories (for CV)"
        "Accessories amount  "
        "License No.  "
        "Registered Car License "
        "Campaign     "   
        "Type of work "   
        "Insurance amount "   
        "Insurance Date ( Voluntary )"
        "Expiry Date ( Voluntary)    "
        "Last Policy No. (Voluntary) "
        "Insurance Type  "   
        "Net premium (Voluntary)  "   
        "Gross premium (Voluntary)"   
        "Stamp "                  
        "VAT   "                  
        "WHT   "                  
        "Compulsory No."   
        "Insurance Date ( Compulsory )"
        "Expiry Date ( Compulsory) "
        "Net premium (Compulsory)  "
        "Gross premium (Compulsory)"
        "Stamp    "
        "VAT      "
        "WHT      "
        "Dealer   "
        "Showroom "
        "Payment Type"
        "Beneficiery "
        "Mailing House no. "
        "Mailing Building "
        "Mailing Village name/no."
        "Mailing Soi  "   
        "Mailing Road "   
        "Mailing Sub-district"
        "Mailing District "   
        "Mailing Province "   
        "Mailing Postcode "   
        "Policy no. to customer date"
        "New policy no  "
        "Insurer Stamp Date"  
        "Remark  "  
        "Occupation code"
        "Car Model"
        ""
        "Prom"
        "Product"
        "f18line1"
        "f18line2"
        "f18line3"
        "Producer"
        "Agent "
        "Branch"
        "Campaign "       
        "Status Problam "
        "Status Release "
        "Trans date"
        "Release Date"
        "Type "
        "Error "  
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
        "Driver5_occupation".   /*Add by Kridtiyai. A68-0044*/  


    RUN pd_reportfile_detail.

    
END.
ELSE DO:
    RUN pd_reportfile2.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfile2 c-wins 
PROCEDURE pd_reportfile2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF var ins_addr1 AS CHAR INIT "".
DEF var ins_addr2 AS CHAR INIT "".
DEF VAR n_length AS INT.
DO:
  If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
      fi_outfile  =  Trim(fi_outfile) + ".csv"  .
  OUTPUT TO VALUE(fi_outfile).
  EXPORT DELIMITER "|" 
        "Ins. Year type  " 
        "Business type    "
        "TAS received by  "
        "Ins company      "
        "Insurance ref no."
        "TPIS Contract No."
        "Title name       "
        "customer name    "
        "customer lastname" 
        "Customer type    "
        "Director Name    "
        "ID number        "
        "House no.        "
        "Building         "
        "Village name/no. "
        "Soi              "
        "Road             "
        "Sub-district     "
        "District         "
        "Province         "
        "Postcode         "
        "Brand            "
        "Car model        "
        "Insurance Code   "
        "Model Year "
        "Usage Type "
        "Colour     "
        "Car Weight "
        "Year       "
        "Engine No. "
        "Chassis No."
        "Accessories (for CV)  "
        "Accessories amount    "
        "License No.           "
        "Registered Car License"
        "Campaign              "
        "Type of work          "
        "Insurance amount      "
        "Insurance Date (Voluntary)"
        "Expiry Date (Voluntary)   "
        "Last Policy No.(Voluntary)"
        "Branch                    "
        "Insurance Type            "
        "Net premium (Voluntary)   "
        "Gross premium (Voluntary) "
        "Stamp                     "
        "VAT                       "
        "WHT                       "
        "Compulsory No.            "
        "‡≈¢„∫·®ÈßÀπ’È.            "
        "Sticker No.               "
        "Insurance Date (Compulsory)"
        "Expiry Date ( Compulsory)  "
        "Net premium (Compulsory)   "
        "Gross premium (Compulsory) "
        "Stamp                      "
        "VAT                        "
        "WHT                        "
        "Dealer                     "
        "Showroom                   "
        "Payment Type               "
        "Beneficiery                "
        "Mailing House no.          "
        "Mailing  Building          "
        "Mailing  Village name/no.  "
        "Mailing  Soi               "
        "Mailing  Road              "
        "Mailing  Sub-district      "
        "Mailing  District          "
        "Mailing Province           "
        "Mailing Postcode           "
        "Policy no. to customer date"
        "New policy no     " 
        "Insurer Stamp Date" 
        "Remark            " 
        "Occupation code   "
        "Register NO.  "   
        "f18line1   "      
        "f18line2   "      
        "f18line3   "      
        "f18line4   "      
        "f18line5   " 
        "f18line6  " 
        "f18line7  "   
        "f18line8  " 
        "f18line9  " 
        "Inspection "      
        "ISP No.    "        
        "ISP Result "
        "ISP Damge "
        "ISP Accessories "
        "Producer   "        
        "Product    "        
        "Data Check "        
        "Agent"              
        "Status problem"     
        "Status Release "
        "Trans Date"
        "Release Date"
        "Type" 
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
        "Driver5_occupation".   /*Add by Kridtiyai. A68-0044*/  
  RUN pd_reportfile2_detail.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfile2bk c-wins 
PROCEDURE pd_reportfile2bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF var ins_addr1 AS CHAR INIT "".
DEF var ins_addr2 AS CHAR INIT "".
DEF VAR n_length AS INT.
DO:
  If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
      fi_outfile  =  Trim(fi_outfile) + ".csv"  .
  OUTPUT TO VALUE(fi_outfile).
  EXPORT DELIMITER "|" 
        "Ins. Year type  " 
        "Business type    "
        "TAS received by  "
        "Ins company      "
        "Insurance ref no."
        "TPIS Contract No."
        "Title name       "
        "customer name    "
        "customer lastname" 
        "Customer type    "
        "Director Name    "
        "ID number        "
        "House no.        "
        "Building         "
        "Village name/no. "
        "Soi              "
        "Road             "
        "Sub-district     "
        "District         "
        "Province         "
        "Postcode         "
        "Brand            "
        "Car model        "
        "Insurance Code   "
        "Model Year "
        "Usage Type "
        "Colour     "
        "Car Weight "
        "Year       "
        "Engine No. "
        "Chassis No."
        "Accessories (for CV)  "
        "Accessories amount    "
        "License No.           "
        "Registered Car License"
        "Campaign              "
        "Type of work          "
        "Insurance amount      "
        "Insurance Date (Voluntary)"
        "Expiry Date (Voluntary)   "
        "Last Policy No.(Voluntary)"
        "Branch                    "
        "Insurance Type            "
        "Net premium (Voluntary)   "
        "Gross premium (Voluntary) "
        "Stamp                     "
        "VAT                       "
        "WHT                       "
        "Compulsory No.            "
        "‡≈¢„∫·®ÈßÀπ’È.            "
        "Sticker No.               "
        "Insurance Date (Compulsory)"
        "Expiry Date ( Compulsory)  "
        "Net premium (Compulsory)   "
        "Gross premium (Compulsory) "
        "Stamp                      "
        "VAT                        "
        "WHT                        "
        "Dealer                     "
        "Showroom                   "
        "Payment Type               "
        "Beneficiery                "
        "Mailing House no.          "
        "Mailing  Building          "
        "Mailing  Village name/no.  "
        "Mailing  Soi               "
        "Mailing  Road              "
        "Mailing  Sub-district      "
        "Mailing  District          "
        "Mailing Province           "
        "Mailing Postcode           "
        "Policy no. to customer date"
        "New policy no     " 
        "Insurer Stamp Date" 
        "Remark            " 
        "Occupation code   "
        "Register NO.  "   
        "f18line1   "      
        "f18line2   "      
        "f18line3   "      
        "f18line4   "      
        "f18line5   " 
        "f18line6  " 
        "f18line7  "   
        "f18line8  " 
        "f18line9  " 
        "Inspection "      
        "ISP No.    "        
        "ISP Result "
        "ISP Damge "
        "ISP Accessories "
        "Producer   "        
        "Product    "        
        "Data Check "        
        "Agent"              
        "Status problem"     
        "Status Release "
        "Trans Date"
        "Release Date"
        "Type" 
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
        "Driver5_occupation".   /*Add by Kridtiyai. A68-0044*/  

  loop_tlt:
  For each brstat.tlt Use-index  tlt01 Where
              brstat.tlt.trndat   >=  fi_trndatfr   And
              brstat.tlt.trndat   <=  fi_trndatto   And
              brstat.tlt.genusr    =  "TPIS"       no-lock. 

        IF      ra_status = 1 THEN DO: 
            IF INDEX(brstat.tlt.releas,"yes") = 0    THEN NEXT.
        END.
        ELSE IF ra_status = 2 THEN DO: 
            IF INDEX(brstat.tlt.releas,"no") = 0     THEN NEXT.
        END.
        ELSE IF ra_status = 3 THEN DO: 
            IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
        END.

        IF rs_pol = 1 THEN DO:
           IF index(brstat.tlt.safe1,"V") = 0 THEN NEXT.
        END.
        ELSE IF rs_pol = 2 THEN DO:
            IF index(brstat.tlt.safe1,"C") = 0 THEN NEXT.
        END.

        IF cb_report = "Comm.Date"  THEN DO:
            IF brstat.tlt.gendat >=  fi_comdat1 AND 
               brstat.tlt.gendat <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "Trans Date"  THEN DO:
            IF date(brstat.tlt.note17) >=  fi_comdat1 AND 
               date(brstat.tlt.note17) <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "Release Date"  THEN DO:
            IF date(brstat.tlt.note18) >=  fi_comdat1 AND 
               date(brstat.tlt.note18) <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "New-LCV" THEN DO:  
            IF index(brstat.tlt.rec_addr4,"LCV") = 0 THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF cb_report = "New-CV" THEN DO:  
            IF index(brstat.tlt.rec_addr4,"LCV") <> 0 THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Renew"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.

        END.
        ELSE IF   cb_report =  "SWITF"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "UsedCar"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Refinance"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF cb_report = "Branch" THEN DO:
            IF brstat.tlt.EXP    <> fi_br  THEN NEXT.
        END.
        ELSE IF cb_report = "Release_yes" THEN DO:
            IF INDEX(brstat.tlt.releas,"yes") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "Release_No" THEN DO:
            IF INDEX(brstat.tlt.releas,"no") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_cancel"   THEN DO:
            IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_Problem"   THEN DO:
          IF index(brstat.tlt.hclfg,"Y") = 0 THEN NEXT.
        END.

        IF TRIM(fi_br) <> "" THEN DO:
            IF trim(fi_br) <> brstat.tlt.ins_brins THEN NEXT loop_tlt.
        END.

        IF TRIM(fi_producer) <> "" THEN DO:
            IF TRIM(fi_producer) <> trim(brstat.tlt.acno1)  THEN NEXT.
        END.
        
      ASSIGN 
        nv_Maddr1   = ""
        nv_Maddr2   = ""
        nv_Maddr3   = ""
        nv_Maddr4   = ""
        nv_Maddr5   = ""
        ins_addr1   = ""
        ins_addr2   = ""
        n_length    = 0   
        ins_addr1   = brstat.tlt.ins_addr1
        ins_addr2   = brstat.tlt.ins_addr2
        nv_Maddr5   = SUBSTR(ins_addr2,R-INDEX(ins_addr2,"MR:"))
        n_length    = LENGTH(nv_Maddr5)
        ins_addr2   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2) - n_length) 
        nv_Maddr4   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2)) 
        nv_Maddr3   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MM:"))
        n_length    = LENGTH(nv_Maddr3)
        ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
        nv_Maddr2   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MB:"))
        n_length    = LENGTH(nv_Maddr2)
        ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
        nv_Maddr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1)).
        if index(nv_Maddr1,"MH:") <> 0  then  nv_Maddr1 =  trim(REPLACE(nv_Maddr1,"MH:","")) .
        if index(nv_Maddr2,"MB:") <> 0  then  nv_Maddr2 =  trim(REPLACE(nv_Maddr2,"MB:","")) .
        if index(nv_Maddr3,"MM:") <> 0  then  nv_Maddr3 =  trim(REPLACE(nv_Maddr3,"MM:","")) .
        if index(nv_Maddr4,"MS:") <> 0  then  nv_Maddr4 =  trim(REPLACE(nv_Maddr4,"MS:","")) .
        if index(nv_Maddr5,"MR:") <> 0  then  nv_Maddr5 =  trim(REPLACE(nv_Maddr5,"MR:","")) .


      EXPORT DELIMITER "|" 
          brstat.tlt.ins_typ               /*Ins. Year type  */                 
          brstat.tlt.rec_addr4             /*Business type    */                
          brstat.tlt.rec_addr3             /*TAS received by  */                
          brstat.tlt.subins                /*Ins company      */                
          brstat.tlt.nor_usr_ins           /*Insurance ref no.*/                
          brstat.tlt.nor_noti_tlt          /*TPIS Contract No.*/                
          brstat.tlt.ins_title             /*Title name       */                
          brstat.tlt.ins_firstname         /*customer name    */                
          brstat.tlt.ins_lastname          /*customer lastname*/                
          brstat.tlt.id_typ                /*Customer type    */                
          brstat.tlt.nor_usr_tlt           /*Director Name    */                
          brstat.tlt.ins_icno              /*ID number        */                
          brstat.tlt.hrg_no                /*House no.        */                
          brstat.tlt.hrg_moo               /*Building         */                
          brstat.tlt.hrg_vill              /*Village name/no. */                
          brstat.tlt.hrg_soi               /*Soi              */                
          brstat.tlt.hrg_street            /*Road             */                
          brstat.tlt.hrg_subdistrict       /*Sub-district     */                
          brstat.tlt.hrg_district          /*District         */                
          brstat.tlt.hrg_prov              /*Province         */                
          brstat.tlt.hrg_postcd            /*Postcode         */                
          brstat.tlt.brand                 /*Brand            */                
          IF brstat.tlt.brand <> "ISUZU" THEN brstat.tlt.safe3 ELSE brstat.tlt.model                 /*Car model        */                
          brstat.tlt.pack                  /*Insurance Code   */                
          brstat.tlt.old_eng               /*Model Year */                      
          brstat.tlt.vehuse                /*Usage Type */                      
          brstat.tlt.colordes               /*Colour     */                      
          brstat.tlt.cc_weight             /*Car Weight */                      
          brstat.tlt.old_cha               /*Year       */                      
          brstat.tlt.eng_no                /*Engine No. */                      
          brstat.tlt.cha_no                /*Chassis No.*/                      
          brstat.tlt.filler1               /*Accessories (for CV)  */           
          brstat.tlt.filler2               /*Accessories amount    */           
          brstat.tlt.lince1                /*License No.           */           
          brstat.tlt.lince2                /*Registered Car License*/           
          brstat.tlt.campaign              /*Campaign              */           
          IF rs_pol = 1 THEN "V" ELSE IF rs_pol = 2 THEN "C" ELSE brstat.tlt.safe1               /*Type of work */             
          brstat.tlt.nor_coamt             /*Insurance amount      */           
          string(brstat.tlt.gendat,"99/99/9999")                /*Insurance Date (Voluntary)*/       
          string(brstat.tlt.expodat,"99/99/9999")               /*Expiry Date (Voluntary)   */       
          brstat.tlt.note1                 /*Last Policy No.(Voluntary)*/       
          brstat.tlt.ins_brins             /*Branch                    */       
          brstat.tlt.covcod                /*Insurance Type            */       
          brstat.tlt.nor_grprm             /*Net premium (Voluntary)   */       
          brstat.tlt.ndeci1                /*Gross premium (Voluntary) */       
          brstat.tlt.ndeci2                /*Stamp                     */       
          brstat.tlt.ndeci3                /*VAT                       */       
          brstat.tlt.ndeci4                /*WHT                       */       
          brstat.tlt.comp_pol              /*Compulsory No.            */       
          ""                               /*‡≈¢„∫·®ÈßÀπ’È.            */       
          brstat.tlt.comp_sck              /*Sticker No.               */       
          if brstat.tlt.nor_effdat  = ? then "" else string(brstat.tlt.nor_effdat,"99/99/9999")            /*Insurance Date (Compulsory)*/      
          if brstat.tlt.comp_effdat = ? then "" else string(brstat.tlt.comp_effdat,"99/99/9999")           /*Expiry Date ( Compulsory)  */      
          brstat.tlt.comp_coamt            /*Net premium (Compulsory)   */      
          brstat.tlt.comp_grprm            /*Gross premium (Compulsory) */      
          brstat.tlt.rstp                  /*Stamp                      */      
          brstat.tlt.rtax                  /*VAT                        */      
          brstat.tlt.tax_coporate          /*WHT                        */      
          brstat.tlt.note2                 /*Dealer                     */      
          brstat.tlt.note3                 /*Showroom                   */      
          brstat.tlt.note4                 /*Payment Type               */      
          brstat.tlt.ben83                 /*Beneficiery                */      
          nv_Maddr1                        /*Mailing House no.          */      
          nv_Maddr2                        /*Mailing  Building          */      
          nv_Maddr3                        /*Mailing  Village name/no.  */      
          nv_Maddr4                        /*Mailing  Soi               */      
          nv_Maddr5                        /*Mailing  Road              */      
          brstat.tlt.ins_addr3             /*Mailing  Sub-district      */      
          brstat.tlt.ins_addr4             /*Mailing  District          */      
          brstat.tlt.ins_addr5             /*Mailing Province           */      
          brstat.tlt.lince3                /*Mailing Postcode           */      
          IF brstat.tlt.datesent = ? THEN "" ELSE  string(brstat.tlt.datesent,"99/99/9999")              /*Policy no. to customer date*/      
          brstat.tlt.policy                /*New policy no     */               
          IF brstat.tlt.ndate2 = ? THEN "" ELSE string(brstat.tlt.ndate2,"99/99/9999")                /*Insurer Stamp Date*/               
          brstat.tlt.note5                 /*Remark            */               
          "" /*brstat.tlt.ins_occ */              /*Occupation code   */               
          brstat.tlt.note16                /*Register NO.  */                   
          brstat.tlt.note12                /*f18line1   */                      
          brstat.tlt.note13                /*f18line2   */                      
          string(brstat.tlt.trndat,"99/99/9999") + " " + brstat.tlt.note14                /*f18line3   */                      
          brstat.tlt.safe2                 /*f18line4   */                      
          brstat.tlt.note19               /*f18line5   */
          ""
          ""
          ""
          ""
          brstat.tlt.note7                  /*Inspection */
          brstat.tlt.note8                  /*ISP No.    */                      
          brstat.tlt.note9                  /*ISP Detail */                      
          brstat.tlt.note10                 /* isp damage*/ 
          brstat.tlt.note11                 /*isp acc */
          brstat.tlt.acno1                 /*Producer   */                      
          brstat.tlt.product               /*Product    */                      
          brstat.tlt.note15                /*Data Check */                      
          brstat.tlt.agent                 /*Agent*/                            
          brstat.tlt.hclfg                 /*Status problem*/                   
          brstat.tlt.releas               /*Status Release */  
          brstat.tlt.note17
          brstat.tlt.note18
          If  tlt.flag  =  "NW"  Then  "New"  Else If  tlt.flag = "RW" Then  "Renew" else If  tlt.flag = "UC" Then  "Usedcar" Else If  tlt.flag = "RE" Then  "Refinance"  else "SWITF ".

  END.
  OUTPUT   CLOSE.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfile2_detail c-wins 
PROCEDURE pd_reportfile2_detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF var ins_addr1 AS CHAR INIT "".
DEF var ins_addr2 AS CHAR INIT "".
DEF VAR n_length AS INT.
DO:
    loop_tlt:
    For each brstat.tlt Use-index  tlt01 Where
        brstat.tlt.trndat   >=  fi_trndatfr   And
        brstat.tlt.trndat   <=  fi_trndatto   And
        brstat.tlt.genusr    =  "TPIS"       no-lock. 

        IF      ra_status = 1 THEN DO: 
            IF INDEX(brstat.tlt.releas,"yes") = 0    THEN NEXT.
        END.
        ELSE IF ra_status = 2 THEN DO: 
            IF INDEX(brstat.tlt.releas,"no") = 0     THEN NEXT.
        END.
        ELSE IF ra_status = 3 THEN DO: 
            IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
        END.

        IF rs_pol = 1 THEN DO:
           IF index(brstat.tlt.safe1,"V") = 0 THEN NEXT.
        END.
        ELSE IF rs_pol = 2 THEN DO:
            IF index(brstat.tlt.safe1,"C") = 0 THEN NEXT.
        END.

        IF cb_report = "Comm.Date"  THEN DO:
            IF brstat.tlt.gendat >=  fi_comdat1 AND 
               brstat.tlt.gendat <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "Trans Date"  THEN DO:
            IF date(brstat.tlt.note17) >=  fi_comdat1 AND 
               date(brstat.tlt.note17) <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "Release Date"  THEN DO:
            IF date(brstat.tlt.note18) >=  fi_comdat1 AND 
               date(brstat.tlt.note18) <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "New-LCV" THEN DO:  
            IF index(brstat.tlt.rec_addr4,"LCV") = 0 THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF cb_report = "New-CV" THEN DO:  
            IF index(brstat.tlt.rec_addr4,"LCV") <> 0 THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Renew"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.

        END.
        ELSE IF   cb_report =  "SWITF"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "UsedCar"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Refinance"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF cb_report = "Branch" THEN DO:
            IF brstat.tlt.EXP    <> fi_br  THEN NEXT.
        END.
        ELSE IF cb_report = "Release_yes" THEN DO:
            IF INDEX(brstat.tlt.releas,"yes") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "Release_No" THEN DO:
            IF INDEX(brstat.tlt.releas,"no") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_cancel"   THEN DO:
            IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_Problem"   THEN DO:
          IF index(brstat.tlt.hclfg,"Y") = 0 THEN NEXT.
        END.

        IF TRIM(fi_br) <> "" THEN DO:
            IF trim(fi_br) <> brstat.tlt.ins_brins THEN NEXT loop_tlt.
        END.

        IF TRIM(fi_producer) <> "" THEN DO:
            IF TRIM(fi_producer) <> trim(brstat.tlt.acno1)  THEN NEXT.
        END.
        
      ASSIGN 
        nv_Maddr1   = ""
        nv_Maddr2   = ""
        nv_Maddr3   = ""
        nv_Maddr4   = ""
        nv_Maddr5   = ""
        ins_addr1   = ""
        ins_addr2   = ""
        n_length    = 0   
        ins_addr1   = brstat.tlt.ins_addr1
        ins_addr2   = brstat.tlt.ins_addr2
        nv_Maddr5   = SUBSTR(ins_addr2,R-INDEX(ins_addr2,"MR:"))
        n_length    = LENGTH(nv_Maddr5)
        ins_addr2   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2) - n_length) 
        nv_Maddr4   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2)) 
        nv_Maddr3   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MM:"))
        n_length    = LENGTH(nv_Maddr3)
        ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
        nv_Maddr2   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MB:"))
        n_length    = LENGTH(nv_Maddr2)
        ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
        nv_Maddr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1)).
        if index(nv_Maddr1,"MH:") <> 0  then  nv_Maddr1 =  trim(REPLACE(nv_Maddr1,"MH:","")) .
        if index(nv_Maddr2,"MB:") <> 0  then  nv_Maddr2 =  trim(REPLACE(nv_Maddr2,"MB:","")) .
        if index(nv_Maddr3,"MM:") <> 0  then  nv_Maddr3 =  trim(REPLACE(nv_Maddr3,"MM:","")) .
        if index(nv_Maddr4,"MS:") <> 0  then  nv_Maddr4 =  trim(REPLACE(nv_Maddr4,"MS:","")) .
        if index(nv_Maddr5,"MR:") <> 0  then  nv_Maddr5 =  trim(REPLACE(nv_Maddr5,"MR:","")) .


      EXPORT DELIMITER "|" 
          brstat.tlt.ins_typ               /*Ins. Year type  */                 
          brstat.tlt.rec_addr4             /*Business type    */                
          brstat.tlt.rec_addr3             /*TAS received by  */                
          brstat.tlt.subins                /*Ins company      */                
          brstat.tlt.nor_usr_ins           /*Insurance ref no.*/                
          brstat.tlt.nor_noti_tlt          /*TPIS Contract No.*/                
          brstat.tlt.ins_title             /*Title name       */                
          brstat.tlt.ins_firstname         /*customer name    */                
          brstat.tlt.ins_lastname          /*customer lastname*/                
          brstat.tlt.id_typ                /*Customer type    */                
          brstat.tlt.nor_usr_tlt           /*Director Name    */                
          brstat.tlt.ins_icno              /*ID number        */                
          brstat.tlt.hrg_no                /*House no.        */                
          brstat.tlt.hrg_moo               /*Building         */                
          brstat.tlt.hrg_vill              /*Village name/no. */                
          brstat.tlt.hrg_soi               /*Soi              */                
          brstat.tlt.hrg_street            /*Road             */                
          brstat.tlt.hrg_subdistrict       /*Sub-district     */                
          brstat.tlt.hrg_district          /*District         */                
          brstat.tlt.hrg_prov              /*Province         */                
          brstat.tlt.hrg_postcd            /*Postcode         */                
          brstat.tlt.brand                 /*Brand            */                
          IF brstat.tlt.brand <> "ISUZU" THEN brstat.tlt.safe3 ELSE brstat.tlt.model                 /*Car model        */                
          brstat.tlt.pack                  /*Insurance Code   */                
          brstat.tlt.old_eng               /*Model Year */                      
          brstat.tlt.vehuse                /*Usage Type */                      
          brstat.tlt.colordes               /*Colour     */                      
          brstat.tlt.cc_weight             /*Car Weight */                      
          brstat.tlt.old_cha               /*Year       */                      
          brstat.tlt.eng_no                /*Engine No. */                      
          brstat.tlt.cha_no                /*Chassis No.*/                      
          brstat.tlt.filler1               /*Accessories (for CV)  */           
          brstat.tlt.filler2               /*Accessories amount    */           
          brstat.tlt.lince1                /*License No.           */           
          brstat.tlt.lince2                /*Registered Car License*/           
          brstat.tlt.campaign              /*Campaign              */           
          IF rs_pol = 1 THEN "V" ELSE IF rs_pol = 2 THEN "C" ELSE brstat.tlt.safe1               /*Type of work */             
          brstat.tlt.nor_coamt             /*Insurance amount      */           
          string(brstat.tlt.gendat,"99/99/9999")                /*Insurance Date (Voluntary)*/       
          string(brstat.tlt.expodat,"99/99/9999")               /*Expiry Date (Voluntary)   */       
          brstat.tlt.note1                 /*Last Policy No.(Voluntary)*/       
          brstat.tlt.ins_brins             /*Branch                    */       
          brstat.tlt.covcod                /*Insurance Type            */       
          brstat.tlt.nor_grprm             /*Net premium (Voluntary)   */       
          brstat.tlt.ndeci1                /*Gross premium (Voluntary) */       
          brstat.tlt.ndeci2                /*Stamp                     */       
          brstat.tlt.ndeci3                /*VAT                       */       
          brstat.tlt.ndeci4                /*WHT                       */       
          brstat.tlt.comp_pol              /*Compulsory No.            */       
          ""                               /*‡≈¢„∫·®ÈßÀπ’È.            */       
          brstat.tlt.comp_sck              /*Sticker No.               */       
          if brstat.tlt.nor_effdat  = ? then "" else string(brstat.tlt.nor_effdat,"99/99/9999")            /*Insurance Date (Compulsory)*/      
          if brstat.tlt.comp_effdat = ? then "" else string(brstat.tlt.comp_effdat,"99/99/9999")           /*Expiry Date ( Compulsory)  */      
          brstat.tlt.comp_coamt            /*Net premium (Compulsory)   */      
          brstat.tlt.comp_grprm            /*Gross premium (Compulsory) */      
          brstat.tlt.rstp                  /*Stamp                      */      
          brstat.tlt.rtax                  /*VAT                        */      
          brstat.tlt.tax_coporate          /*WHT                        */      
          brstat.tlt.note2                 /*Dealer                     */      
          brstat.tlt.note3                 /*Showroom                   */      
          brstat.tlt.note4                 /*Payment Type               */      
          brstat.tlt.ben83                 /*Beneficiery                */      
          nv_Maddr1                        /*Mailing House no.          */      
          nv_Maddr2                        /*Mailing  Building          */      
          nv_Maddr3                        /*Mailing  Village name/no.  */      
          nv_Maddr4                        /*Mailing  Soi               */      
          nv_Maddr5                        /*Mailing  Road              */      
          brstat.tlt.ins_addr3             /*Mailing  Sub-district      */      
          brstat.tlt.ins_addr4             /*Mailing  District          */      
          brstat.tlt.ins_addr5             /*Mailing Province           */      
          brstat.tlt.lince3                /*Mailing Postcode           */      
          IF brstat.tlt.datesent = ? THEN "" ELSE  string(brstat.tlt.datesent,"99/99/9999")              /*Policy no. to customer date*/      
          brstat.tlt.policy                /*New policy no     */               
          IF brstat.tlt.ndate2 = ? THEN "" ELSE string(brstat.tlt.ndate2,"99/99/9999")                /*Insurer Stamp Date*/               
          brstat.tlt.note5                 /*Remark            */               
          "" /*brstat.tlt.ins_occ */              /*Occupation code   */               
          brstat.tlt.note16                /*Register NO.  */                   
          brstat.tlt.note12                /*f18line1   */                      
          brstat.tlt.note13                /*f18line2   */                      
          string(brstat.tlt.trndat,"99/99/9999") + " " + brstat.tlt.note14                /*f18line3   */                      
          brstat.tlt.safe2                 /*f18line4   */                      
          brstat.tlt.note19               /*f18line5   */
          ""
          ""
          ""
          ""
          brstat.tlt.note7                  /*Inspection */
          brstat.tlt.note8                  /*ISP No.    */                      
          brstat.tlt.note9                  /*ISP Detail */                      
          brstat.tlt.note10                 /* isp damage*/ 
          brstat.tlt.note11                 /*isp acc */
          brstat.tlt.acno1                 /*Producer   */                      
          brstat.tlt.product               /*Product    */                      
          brstat.tlt.note15                /*Data Check */                      
          brstat.tlt.agent                 /*Agent*/                            
          brstat.tlt.hclfg                 /*Status problem*/                   
          brstat.tlt.releas               /*Status Release */  
          brstat.tlt.note17
          brstat.tlt.note18
          If  tlt.flag  =  "NW"  Then  "New"  Else If  tlt.flag = "RW" Then  "Renew" else If  tlt.flag = "UC" Then  "Usedcar" Else If  tlt.flag = "RE" Then  "Refinance"  else "SWITF " 
          trim(brstat.tlt.dri_title1)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_fname1)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lname1)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_birth1)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_no1)       /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lic1)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dir_occ1)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_title2)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_fname2)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lname2)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_birth2)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_no2)       /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lic2)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_occ2)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_title3)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_fname3)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lname3)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_birth3)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_no3)       /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lic3)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dir_occ3)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_title4)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_fname4)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lname4)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_birth4)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_no4)       /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lic4)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_occ4)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_title5)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_fname5)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lname5)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_birth5)    /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_no5)       /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_lic5)      /*add by kridtiyai. A68-0044*/
          trim(brstat.tlt.dri_occ5).     /*add by kridtiyai. A68-0044*/

    END.
    OUTPUT   CLOSE.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfile_detail c-wins 
PROCEDURE pd_reportfile_detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_remak3      AS CHAR FORMAT "x(255)" INIT "".
DEF VAR nnidbr72      AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid72        AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nnidbr70      AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid70        AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nv_chaidrep   AS CHAR FORMAT "x(100)" INIT "".  
DEF VAR nv_Rec        AS CHAR FORMAT "x(300)" INIT "".   /* start A63-0210 */
DEF VAR nv_remark     AS CHAR FORMAT "x(300)" INIT "".  
DEF VAR nv_Rec_name72 AS CHAR FORMAT "x(150)" INIT "".
DEF VAR nv_Rec_add1   AS CHAR FORMAT "x(60)"  INIT "".   /* end A63-0210 */
DEF var ins_addr1     AS CHAR INIT "".
DEF var ins_addr2     AS CHAR INIT "".
DEF VAR n_length      AS INT.

loop_tlt:
For each brstat.tlt Use-index  tlt01 Where
    brstat.tlt.trndat   >=  fi_trndatfr   And
    brstat.tlt.trndat   <=  fi_trndatto   And
    brstat.tlt.genusr    =  "TPIS"       no-lock. 
    IF      ra_status = 1 THEN DO: 
        IF INDEX(brstat.tlt.releas,"yes") = 0    THEN NEXT.
    END.
    ELSE IF ra_status = 2 THEN DO: 
        IF INDEX(brstat.tlt.releas,"no") = 0     THEN NEXT.
    END.
    ELSE IF ra_status = 3 THEN DO: 
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    IF rs_pol = 1 THEN DO:
        IF index(brstat.tlt.safe1,"V") = 0 THEN NEXT.
    END.
    ELSE IF rs_pol = 2 THEN DO:
        IF index(brstat.tlt.safe1,"C") = 0 THEN NEXT.
    END.
    IF cb_report = "Comm.Date"  THEN DO:
        IF brstat.tlt.gendat >=  fi_comdat1 AND 
            brstat.tlt.gendat <=  fi_comdat2 THEN DO:  
        END.
        ELSE NEXT.
    END.
    ELSE IF cb_report = "Trans Date"  THEN DO:
        IF date(brstat.tlt.note17) >=  fi_comdat1 AND 
            date(brstat.tlt.note17) <=  fi_comdat2 THEN DO:  
        END.
        ELSE NEXT.
    END.
    ELSE IF cb_report = "Release Date"  THEN DO:
        IF date(brstat.tlt.note18) >=  fi_comdat1 AND 
            date(brstat.tlt.note18) <=  fi_comdat2 THEN DO:  
        END.
        ELSE NEXT.
    END.
    ELSE IF cb_report = "New-LCV" THEN DO:  
        IF index(brstat.tlt.rec_addr4,"LCV") = 0 THEN NEXT.
        IF brstat.tlt.flag =  "RW"  THEN NEXT.
        IF brstat.tlt.flag =  "RF"  THEN NEXT.
        IF brstat.tlt.flag =  "TF"  THEN NEXT.
        IF brstat.tlt.flag =  "UC"  THEN NEXT.
    END.
    ELSE IF cb_report = "New-CV" THEN DO:  
        IF index(brstat.tlt.rec_addr4,"LCV") <> 0 THEN NEXT.
        IF brstat.tlt.flag =  "RW"  THEN NEXT.
        IF brstat.tlt.flag =  "RF"  THEN NEXT.
        IF brstat.tlt.flag =  "TF"  THEN NEXT.
        IF brstat.tlt.flag =  "UC"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "Renew"  THEN DO:
        IF brstat.tlt.flag =  "NW"  THEN NEXT.
        IF brstat.tlt.flag =  "RF"  THEN NEXT.
        IF brstat.tlt.flag =  "TF"  THEN NEXT.
        IF brstat.tlt.flag =  "UC"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "SWITF"  THEN DO:
         IF brstat.tlt.flag =  "NW"  THEN NEXT.
         IF brstat.tlt.flag =  "RW"  THEN NEXT.
         IF brstat.tlt.flag =  "RF"  THEN NEXT.
         IF brstat.tlt.flag =  "UC"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "UsedCar"  THEN DO:
        IF brstat.tlt.flag =  "NW"  THEN NEXT.
        IF brstat.tlt.flag =  "RW"  THEN NEXT.
        IF brstat.tlt.flag =  "RF"  THEN NEXT.
        IF brstat.tlt.flag =  "TF"  THEN NEXT.
    END.
    ELSE IF   cb_report =  "Refinance"  THEN DO:
        IF brstat.tlt.flag =  "NW"  THEN NEXT.
        IF brstat.tlt.flag =  "RW"  THEN NEXT.
        IF brstat.tlt.flag =  "TF"  THEN NEXT.
        IF brstat.tlt.flag =  "UC"  THEN NEXT.
    END.
    ELSE IF cb_report = "Branch" THEN DO:
        IF brstat.tlt.EXP    <> fi_br  THEN NEXT.
    END.
    ELSE IF cb_report = "Release_yes" THEN DO:
        IF INDEX(brstat.tlt.releas,"yes") = 0 THEN NEXT.
    END.
    ELSE IF cb_report = "Release_No" THEN DO:
        IF INDEX(brstat.tlt.releas,"no") = 0 THEN NEXT.
    END.
    ELSE IF cb_report =   "Status_cancel"   THEN DO:
        IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
    END.
    ELSE IF cb_report =   "Status_Problem"   THEN DO:
        IF index(brstat.tlt.hclfg,"Y") = 0 THEN NEXT.
    END.
    IF TRIM(fi_br) <> "" THEN DO:
        IF trim(fi_br) <> brstat.tlt.ins_brins THEN NEXT loop_tlt.
    END.
    IF TRIM(fi_producer) <> "" THEN DO:
        IF TRIM(fi_producer) <> trim(brstat.tlt.acno1)  THEN NEXT.
    END.
    ASSIGN 
    nv_Maddr1   = ""
    nv_Maddr2   = ""
    nv_Maddr3   = ""
    nv_Maddr4   = ""
    nv_Maddr5   = ""
    ins_addr1   = ""
    ins_addr2   = ""
    n_length    = 0   
    ins_addr1   = brstat.tlt.ins_addr1
    ins_addr2   = brstat.tlt.ins_addr2
    nv_Maddr5   = SUBSTR(ins_addr2,R-INDEX(ins_addr2,"MR:"))
    n_length    = LENGTH(nv_Maddr5)
    ins_addr2   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2) - n_length) 
    nv_Maddr4   = SUBSTR(ins_addr2,1,LENGTH(ins_addr2)) 
    nv_Maddr3   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MM:"))
    n_length    = LENGTH(nv_Maddr3)
    ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
    nv_Maddr2   = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MB:"))
    n_length    = LENGTH(nv_Maddr2)
    ins_addr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
    nv_Maddr1   = SUBSTR(ins_addr1,1,LENGTH(ins_addr1)).
    if index(nv_Maddr1,"MH:") <> 0  then  nv_Maddr1 =  trim(REPLACE(nv_Maddr1,"MH:","")) .
    if index(nv_Maddr2,"MB:") <> 0  then  nv_Maddr2 =  trim(REPLACE(nv_Maddr2,"MB:","")) .
    if index(nv_Maddr3,"MM:") <> 0  then  nv_Maddr3 =  trim(REPLACE(nv_Maddr3,"MM:","")) .
    if index(nv_Maddr4,"MS:") <> 0  then  nv_Maddr4 =  trim(REPLACE(nv_Maddr4,"MS:","")) .
    if index(nv_Maddr5,"MR:") <> 0  then  nv_Maddr5 =  trim(REPLACE(nv_Maddr5,"MR:","")) .
    EXPORT DELIMITER "|" 
        brstat.tlt.ins_typ             /*Ins. Year type */               
        brstat.tlt.rec_addr4           /*Business type  */               
        brstat.tlt.rec_addr3           /*TAS received by*/               
        brstat.tlt.subins              /*Ins company    */               
        brstat.tlt.nor_usr_ins         /*Insurance ref no. */            
        brstat.tlt.nor_noti_tlt        /*TPIS Contract No. */            
        brstat.tlt.ins_title           /*Title name    */                
        brstat.tlt.ins_firstname       /*customer name */                
        brstat.tlt.ins_lastname        /*customer lastname */            
        brstat.tlt.id_typ              /*Customer type*/                 
        brstat.tlt.nor_usr_tlt         /*Director Name*/                 
        brstat.tlt.ins_icno            /*ID number    */                 
        brstat.tlt.hrg_no              /*House no.    */                 
        brstat.tlt.hrg_moo             /*Building     */                 
        brstat.tlt.hrg_vill            /*Village name/no.*/              
        brstat.tlt.hrg_soi             /*Soi         */                  
        brstat.tlt.hrg_street          /*Road        */                  
        brstat.tlt.hrg_subdistrict     /*Sub-district*/                  
        brstat.tlt.hrg_district        /*District    */                  
        brstat.tlt.hrg_prov            /*Province    */                  
        brstat.tlt.hrg_postcd          /*Postcode    */                  
        brstat.tlt.brand               /*Brand       */                  
        brstat.tlt.model               /*Car model   */                  
        brstat.tlt.pack                /*Insurance Code */               
        brstat.tlt.old_eng             /*Model Year  */                  
        brstat.tlt.vehuse              /*Usage Type  */                  
        brstat.tlt.colordes            /*Colour      */                  
        brstat.tlt.cc_weight           /*Car Weight (CC.)  */            
        brstat.tlt.old_cha             /*Year       */                   
        brstat.tlt.eng_no              /*Engine No. */                   
        brstat.tlt.cha_no              /*Chassis No.*/                   
        brstat.tlt.filler1             /*Accessories (for CV)*/          
        brstat.tlt.filler2             /*Accessories amount  */          
        brstat.tlt.lince1              /*License No.  */                 
        brstat.tlt.lince2              /*Registered Car License */       
        brstat.tlt.packnme             /*Campaign     */                 
        IF rs_pol = 1 THEN "V" ELSE IF rs_pol = 2 THEN "C" ELSE brstat.tlt.safe1               /*Type of work */                 
        brstat.tlt.nor_coamt           /*Insurance amount */             
        string(brstat.tlt.gendat,"99/99/9999")              /*Insurance Date ( Voluntary )*/  
        string(brstat.tlt.expodat,"99/99/9999")             /*Expiry Date ( Voluntary)    */  
        brstat.tlt.note1               /*Last Policy No. (Voluntary) */  
        brstat.tlt.covcod              /*Insurance Type  */              
        brstat.tlt.nor_grprm           /*Net premium (Voluntary)  */     
        brstat.tlt.ndeci1              /*Gross premium (Voluntary)*/     
        brstat.tlt.ndeci2              /*Stamp */                        
        brstat.tlt.ndeci3              /*VAT   */                        
        brstat.tlt.ndeci4              /*WHT   */                        
        IF brstat.tlt.comp_pol = "" THEN brstat.tlt.comp_sck ELSE brstat.tlt.comp_pol  /*Compulsory No.*/                
        if brstat.tlt.nor_effdat  = ? then "" else  string(brstat.tlt.nor_effdat,"99/99/9999")          /*Insurance Date ( Compulsory )*/ 
        if brstat.tlt.comp_effdat = ? then "" else  string(brstat.tlt.comp_effdat,"99/99/9999")         /*Expiry Date ( Compulsory) */    
        brstat.tlt.comp_coamt          /*Net premium (Compulsory)  */    
        brstat.tlt.comp_grprm          /*Gross premium (Compulsory)*/    
        brstat.tlt.rstp                /*Stamp    */                     
        brstat.tlt.rtax                /*VAT      */                     
        brstat.tlt.tax_coporate        /*WHT      */                     
        brstat.tlt.note2               /*Dealer   */                     
        brstat.tlt.note3               /*Showroom */                     
        brstat.tlt.note4               /*Payment Type*/                  
        brstat.tlt.ben83               /*Beneficiery */                  
        nv_Maddr1           /*Mailing House no. */            
        nv_Maddr2           /*Mailing Building */             
        nv_Maddr3           /*Mailing Village name/no.*/      
        nv_Maddr4           /*Mailing Soi  */                 
        nv_Maddr5           /*Mailing Road */                 
        brstat.tlt.ins_addr3           /*Mailing Sub-district*/          
        brstat.tlt.ins_addr4           /*Mailing District */             
        brstat.tlt.ins_addr5           /*Mailing Province */             
        brstat.tlt.lince3              /*Mailing Postcode */             
        IF brstat.tlt.datesent = ? THEN "" ELSE  STRING(brstat.tlt.datesent,"99/99/9999")            /*Policy no. to customer date*/   
        brstat.tlt.policy              /*New policy no  */               
        IF brstat.tlt.ndate2 = ? THEN "" ELSE string(brstat.tlt.ndate2,"99/99/9999")              /*Insurer Stamp Date*/            
        brstat.tlt.note5               /*Remark  */                      
        "" /*brstat.tlt.ins_occ*/            /*Occupation code*/
        brstat.tlt.model               /*Car model   */ 
        ""                             /* */
        "CLAIMDI"                             /*Prom */
        brstat.tlt.product             /*Product */
        brstat.tlt.note12 
        brstat.tlt.note13 
        STRING(brstat.tlt.trndat,"99/99/9999") + " " + brstat.tlt.note14
        brstat.tlt.acno1              /*Producer */
        brstat.tlt.agent              /*Agent */
        brstat.tlt.ins_brins          /*Branch */
        brstat.tlt.campaign           /*Campaign */ 
        brstat.tlt.hclfg              /*Status Problam */ 
        brstat.tlt.releas            /*Status Release*/
        brstat.tlt.note17
        brstat.tlt.note18
        If  tlt.flag  =  "NW"  Then  "New"  Else If  tlt.flag = "RW" Then  "Renew" else If  tlt.flag = "UC" Then  "Usedcar" Else If  tlt.flag = "RE" Then  "Refinance"  else "SWITF "
        brstat.tlt.note15              /*Error */
        trim(brstat.tlt.dri_title1)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_fname1)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lname1)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_birth1)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_no1)       /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lic1)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dir_occ1)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_title2)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_fname2)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lname2)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_birth2)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_no2)       /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lic2)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_occ2)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_title3)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_fname3)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lname3)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_birth3)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_no3)       /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lic3)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dir_occ3)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_title4)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_fname4)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lname4)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_birth4)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_no4)       /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lic4)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_occ4)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_title5)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_fname5)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lname5)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_birth5)    /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_no5)       /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_lic5)      /*add by kridtiyai. A68-0044*/
        trim(brstat.tlt.dri_occ5).     /*add by kridtiyai. A68-0044*/
END.
OUTPUT   CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_reportfil_bk c-wins 
PROCEDURE pd_reportfil_bk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by Kridtiyai .A68-0044
DEF VAR n_remak3    AS CHAR FORMAT "x(255)" INIT "".
DEF VAR nnidbr72    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid72      AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nnidbr70    AS CHAR FORMAT "x(20)" INIT "".
DEF VAR nnid70      AS CHAR FORMAT "x(13)" INIT "".
DEF VAR nv_chaidrep AS CHAR FORMAT "x(100)" INIT "".  
DEF VAR nv_Rec          AS CHAR FORMAT "x(300)" INIT "".   /* start A63-0210 */
DEF VAR nv_remark       AS CHAR FORMAT "x(300)" INIT "".  
DEF VAR nv_Rec_name72   AS CHAR FORMAT "x(150)" INIT "".
DEF VAR nv_Rec_add1     AS CHAR FORMAT "x(60)"  INIT "".   /* end A63-0210 */
DEF var ins_addr1 AS CHAR INIT "".
DEF var ins_addr2 AS CHAR INIT "".
DEF VAR n_length AS INT.


IF cb_report = "New-LCV" OR cb_report = "New-CV"  THEN DO: 
    If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".csv"  THEN 
        fi_outfile  =  Trim(fi_outfile) + ".csv"  .
    OUTPUT TO VALUE(fi_outfile).
    EXPORT DELIMITER "|" 
          "Ins. Year type "
          "Business type  "
          "TAS received by"
          "Ins company    "
          "Insurance ref no. "
          "TPIS Contract No. "
          "Title name    "  
          "customer name "  
          "customer lastname "
          "Customer type"   
          "Director Name"   
          "ID number    "   
          "House no.    "   
          "Building     "   
          "Village name/no."
          "Soi         "
          "Road        "
          "Sub-district"
          "District    "
          "Province    "
          "Postcode    "
          "Brand       "
          "Car model   "
          "Insurance Code "
          "Model Year  "
          "Usage Type  "
          "Colour      "
          "Car Weight (CC.)  "
          "Year       " 
          "Engine No. " 
          "Chassis No." 
          "Accessories (for CV)"
          "Accessories amount  "
          "License No.  "
          "Registered Car License "
          "Campaign     "   
          "Type of work "   
          "Insurance amount "   
          "Insurance Date ( Voluntary )"
          "Expiry Date ( Voluntary)    "
          "Last Policy No. (Voluntary) "
          "Insurance Type  "   
          "Net premium (Voluntary)  "   
          "Gross premium (Voluntary)"   
          "Stamp "                  
          "VAT   "                  
          "WHT   "                  
          "Compulsory No."   
          "Insurance Date ( Compulsory )"
          "Expiry Date ( Compulsory) "
          "Net premium (Compulsory)  "
          "Gross premium (Compulsory)"
          "Stamp    "
          "VAT      "
          "WHT      "
          "Dealer   "
          "Showroom "
          "Payment Type"
          "Beneficiery "
          "Mailing House no. "
          "Mailing Building "
          "Mailing Village name/no."
          "Mailing Soi  "   
          "Mailing Road "   
          "Mailing Sub-district"
          "Mailing District "   
          "Mailing Province "   
          "Mailing Postcode "   
          "Policy no. to customer date"
          "New policy no  "
          "Insurer Stamp Date"  
          "Remark  "  
          "Occupation code"
          "Car Model"
          ""
          "Prom"
          "Product"
          "f18line1"
          "f18line2"
          "f18line3"
          "Producer"
          "Agent "
          "Branch"
          "Campaign "       
          "Status Problam "
          "Status Release "
          "Trans date"
          "Release Date"
          "Type "
          "Error "  
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
          "Driver5_occupation".   /*Add by Kridtiyai. A68-0044*/  

    loop_tlt:
    For each brstat.tlt Use-index  tlt01 Where
                brstat.tlt.trndat   >=  fi_trndatfr   And
                brstat.tlt.trndat   <=  fi_trndatto   And
                brstat.tlt.genusr    =  "TPIS"       no-lock. 

        IF      ra_status = 1 THEN DO: 
            IF INDEX(brstat.tlt.releas,"yes") = 0    THEN NEXT.
        END.
        ELSE IF ra_status = 2 THEN DO: 
            IF INDEX(brstat.tlt.releas,"no") = 0     THEN NEXT.
        END.
        ELSE IF ra_status = 3 THEN DO: 
            IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
        END.

        IF rs_pol = 1 THEN DO:
           IF index(brstat.tlt.safe1,"V") = 0 THEN NEXT.
        END.
        ELSE IF rs_pol = 2 THEN DO:
            IF index(brstat.tlt.safe1,"C") = 0 THEN NEXT.
        END.
        
        IF cb_report = "Comm.Date"  THEN DO:
            IF brstat.tlt.gendat >=  fi_comdat1 AND 
               brstat.tlt.gendat <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "Trans Date"  THEN DO:
            IF date(brstat.tlt.note17) >=  fi_comdat1 AND 
               date(brstat.tlt.note17) <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "Release Date"  THEN DO:
            IF date(brstat.tlt.note18) >=  fi_comdat1 AND 
               date(brstat.tlt.note18) <=  fi_comdat2 THEN DO:  
            END.
            ELSE NEXT.
        END.
        ELSE IF cb_report = "New-LCV" THEN DO:  
            IF index(brstat.tlt.rec_addr4,"LCV") = 0 THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF cb_report = "New-CV" THEN DO:  
            IF index(brstat.tlt.rec_addr4,"LCV") <> 0 THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Renew"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.

        END.
        ELSE IF   cb_report =  "SWITF"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "UsedCar"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "RF"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
        END.
        ELSE IF   cb_report =  "Refinance"  THEN DO:
            IF brstat.tlt.flag =  "NW"  THEN NEXT.
            IF brstat.tlt.flag =  "RW"  THEN NEXT.
            IF brstat.tlt.flag =  "TF"  THEN NEXT.
            IF brstat.tlt.flag =  "UC"  THEN NEXT.
        END.
        ELSE IF cb_report = "Branch" THEN DO:
            IF brstat.tlt.EXP    <> fi_br  THEN NEXT.
        END.
        ELSE IF cb_report = "Release_yes" THEN DO:
            IF INDEX(brstat.tlt.releas,"yes") = 0 THEN NEXT.
        END.
        ELSE IF cb_report = "Release_No" THEN DO:
            IF INDEX(brstat.tlt.releas,"no") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_cancel"   THEN DO:
            IF index(brstat.tlt.releas,"cancel") = 0 THEN NEXT.
        END.
        ELSE IF cb_report =   "Status_Problem"   THEN DO:
          IF index(brstat.tlt.hclfg,"Y") = 0 THEN NEXT.
        END.

        IF TRIM(fi_br) <> "" THEN DO:
            IF trim(fi_br) <> brstat.tlt.ins_brins THEN NEXT loop_tlt.
        END.

        IF TRIM(fi_producer) <> "" THEN DO:
            IF TRIM(fi_producer) <> trim(brstat.tlt.acno1)  THEN NEXT.
        END.
        
        ASSIGN 
        nv_Maddr1   = ""
        nv_Maddr2   = ""
        nv_Maddr3   = ""
        nv_Maddr4   = ""
        nv_Maddr5   = ""
        ins_addr1         = ""
        ins_addr2         = ""
        n_length          = 0   
        ins_addr1         = brstat.tlt.ins_addr1
        ins_addr2         = brstat.tlt.ins_addr2
        nv_Maddr5         = SUBSTR(ins_addr2,R-INDEX(ins_addr2,"MR:"))
        n_length          = LENGTH(nv_Maddr5)
        ins_addr2         = SUBSTR(ins_addr2,1,LENGTH(ins_addr2) - n_length) 
        nv_Maddr4         = SUBSTR(ins_addr2,1,LENGTH(ins_addr2)) 
        nv_Maddr3         = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MM:"))
        n_length          = LENGTH(nv_Maddr3)
        ins_addr1         = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
        nv_Maddr2         = SUBSTR(ins_addr1,R-INDEX(ins_addr1,"MB:"))
        n_length          = LENGTH(nv_Maddr2)
        ins_addr1         = SUBSTR(ins_addr1,1,LENGTH(ins_addr1) - n_length)
        nv_Maddr1         = SUBSTR(ins_addr1,1,LENGTH(ins_addr1)).
        if index(nv_Maddr1,"MH:") <> 0  then  nv_Maddr1 =  trim(REPLACE(nv_Maddr1,"MH:","")) .
        if index(nv_Maddr2,"MB:") <> 0  then  nv_Maddr2 =  trim(REPLACE(nv_Maddr2,"MB:","")) .
        if index(nv_Maddr3,"MM:") <> 0  then  nv_Maddr3 =  trim(REPLACE(nv_Maddr3,"MM:","")) .
        if index(nv_Maddr4,"MS:") <> 0  then  nv_Maddr4 =  trim(REPLACE(nv_Maddr4,"MS:","")) .
        if index(nv_Maddr5,"MR:") <> 0  then  nv_Maddr5 =  trim(REPLACE(nv_Maddr5,"MR:","")) .

        
        EXPORT DELIMITER "|" 
             brstat.tlt.ins_typ             /*Ins. Year type */               
             brstat.tlt.rec_addr4           /*Business type  */               
             brstat.tlt.rec_addr3           /*TAS received by*/               
             brstat.tlt.subins              /*Ins company    */               
             brstat.tlt.nor_usr_ins         /*Insurance ref no. */            
             brstat.tlt.nor_noti_tlt        /*TPIS Contract No. */            
             brstat.tlt.ins_title           /*Title name    */                
             brstat.tlt.ins_firstname       /*customer name */                
             brstat.tlt.ins_lastname        /*customer lastname */            
             brstat.tlt.id_typ              /*Customer type*/                 
             brstat.tlt.nor_usr_tlt         /*Director Name*/                 
             brstat.tlt.ins_icno            /*ID number    */                 
             brstat.tlt.hrg_no              /*House no.    */                 
             brstat.tlt.hrg_moo             /*Building     */                 
             brstat.tlt.hrg_vill            /*Village name/no.*/              
             brstat.tlt.hrg_soi             /*Soi         */                  
             brstat.tlt.hrg_street          /*Road        */                  
             brstat.tlt.hrg_subdistrict     /*Sub-district*/                  
             brstat.tlt.hrg_district        /*District    */                  
             brstat.tlt.hrg_prov            /*Province    */                  
             brstat.tlt.hrg_postcd          /*Postcode    */                  
             brstat.tlt.brand               /*Brand       */                  
             brstat.tlt.model               /*Car model   */                  
             brstat.tlt.pack                /*Insurance Code */               
             brstat.tlt.old_eng             /*Model Year  */                  
             brstat.tlt.vehuse              /*Usage Type  */                  
             brstat.tlt.colordes            /*Colour      */                  
             brstat.tlt.cc_weight           /*Car Weight (CC.)  */            
             brstat.tlt.old_cha             /*Year       */                   
             brstat.tlt.eng_no              /*Engine No. */                   
             brstat.tlt.cha_no              /*Chassis No.*/                   
             brstat.tlt.filler1             /*Accessories (for CV)*/          
             brstat.tlt.filler2             /*Accessories amount  */          
             brstat.tlt.lince1              /*License No.  */                 
             brstat.tlt.lince2              /*Registered Car License */       
             brstat.tlt.packnme             /*Campaign     */                 
             IF rs_pol = 1 THEN "V" ELSE IF rs_pol = 2 THEN "C" ELSE brstat.tlt.safe1               /*Type of work */                 
             brstat.tlt.nor_coamt           /*Insurance amount */             
             string(brstat.tlt.gendat,"99/99/9999")              /*Insurance Date ( Voluntary )*/  
             string(brstat.tlt.expodat,"99/99/9999")             /*Expiry Date ( Voluntary)    */  
             brstat.tlt.note1               /*Last Policy No. (Voluntary) */  
             brstat.tlt.covcod              /*Insurance Type  */              
             brstat.tlt.nor_grprm           /*Net premium (Voluntary)  */     
             brstat.tlt.ndeci1              /*Gross premium (Voluntary)*/     
             brstat.tlt.ndeci2              /*Stamp */                        
             brstat.tlt.ndeci3              /*VAT   */                        
             brstat.tlt.ndeci4              /*WHT   */                        
             IF brstat.tlt.comp_pol = "" THEN brstat.tlt.comp_sck ELSE brstat.tlt.comp_pol  /*Compulsory No.*/                
             if brstat.tlt.nor_effdat  = ? then "" else  string(brstat.tlt.nor_effdat,"99/99/9999")          /*Insurance Date ( Compulsory )*/ 
             if brstat.tlt.comp_effdat = ? then "" else  string(brstat.tlt.comp_effdat,"99/99/9999")         /*Expiry Date ( Compulsory) */    
             brstat.tlt.comp_coamt          /*Net premium (Compulsory)  */    
             brstat.tlt.comp_grprm          /*Gross premium (Compulsory)*/    
             brstat.tlt.rstp                /*Stamp    */                     
             brstat.tlt.rtax                /*VAT      */                     
             brstat.tlt.tax_coporate        /*WHT      */                     
             brstat.tlt.note2               /*Dealer   */                     
             brstat.tlt.note3               /*Showroom */                     
             brstat.tlt.note4               /*Payment Type*/                  
             brstat.tlt.ben83               /*Beneficiery */                  
             nv_Maddr1           /*Mailing House no. */            
             nv_Maddr2           /*Mailing Building */             
             nv_Maddr3           /*Mailing Village name/no.*/      
             nv_Maddr4           /*Mailing Soi  */                 
             nv_Maddr5           /*Mailing Road */                 
             brstat.tlt.ins_addr3           /*Mailing Sub-district*/          
             brstat.tlt.ins_addr4           /*Mailing District */             
             brstat.tlt.ins_addr5           /*Mailing Province */             
             brstat.tlt.lince3              /*Mailing Postcode */             
             IF brstat.tlt.datesent = ? THEN "" ELSE  STRING(brstat.tlt.datesent,"99/99/9999")            /*Policy no. to customer date*/   
             brstat.tlt.policy              /*New policy no  */               
             IF brstat.tlt.ndate2 = ? THEN "" ELSE string(brstat.tlt.ndate2,"99/99/9999")              /*Insurer Stamp Date*/            
             brstat.tlt.note5               /*Remark  */                      
             "" /*brstat.tlt.ins_occ*/            /*Occupation code*/
             brstat.tlt.model               /*Car model   */ 
             ""                             /* */
             "CLAIMDI"                             /*Prom */
             brstat.tlt.product             /*Product */
             brstat.tlt.note12 
             brstat.tlt.note13 
             STRING(brstat.tlt.trndat,"99/99/9999") + " " + brstat.tlt.note14
             brstat.tlt.acno1              /*Producer */
             brstat.tlt.agent              /*Agent */
             brstat.tlt.ins_brins          /*Branch */
             brstat.tlt.campaign           /*Campaign */ 
             brstat.tlt.hclfg              /*Status Problam */ 
             brstat.tlt.releas            /*Status Release*/
             brstat.tlt.note17
             brstat.tlt.note18
             If  tlt.flag  =  "NW"  Then  "New"  Else If  tlt.flag = "RW" Then  "Renew" else If  tlt.flag = "UC" Then  "Usedcar" Else If  tlt.flag = "RE" Then  "Refinance"  else "SWITF "
             brstat.tlt.note15.            /*Error */

               
    END.
OUTPUT   CLOSE.  
END.
ELSE DO:
    RUN pd_reportfile2.
END.
  comment by Kridtiyai .A68-0044 --------------*/                                        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chknote c-wins 
PROCEDURE proc_chknote :
/* proc_ExportNote */
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chNotesSession   As Com-Handle.
DEF VAR chNotesDataBase  As Com-Handle.
DEF VAR chDocument       As Com-Handle.
DEF VAR chNotesView      As Com-Handle .
DEF VAR chDocument1      As Com-Handle.
DEF VAR chNotesView1     As Com-Handle .
DEF VAR chnotecollection AS COM-HANDLE.
DEF VAR chItem           AS Com-Handle .
DEF VAR chData           AS Com-Handle .
DEF VAR nv_server        AS Char.
DEF VAR nv_tmp           AS char .
DEF VAR nv_extref        AS char.
DEF VAR n_year           AS CHAR FORMAT "x(4)" .
DEF VAR n_day            AS CHAR FORMAT "x(15)" .
DEF VAR n_date           AS CHAR FORMAT "99/99/9999".
DEF VAR nv_name          AS CHAR FORMAT "x(25)".
DEF VAR n_pol            AS CHAR FORMAT "x(13)".
DEF VAR n_ems            AS CHAR FORMAT "x(14)".
DEF VAR nt_name          AS CHAR FORMAT "x(25)".
DEF VAR nt_policyno      AS CHAR FORMAT "x(12)".    
DEF VAR nt_date          AS DATE FORMAT "99/99/9999".     
DEF VAR nt_ems           AS CHAR FORMAT "x(14)".
DEF VAR n_snote          AS CHAR FORMAT "X(25)".

DO:
    /*For each wdetail WHERE wdetail.policy_no <> "" . */ 
      ASSIGN n_day        = STRING(TODAY,"99/99/9999")
             n_year       = SUBSTR(n_day,9,2)
             n_snote      = "postdocument" + n_year + ".nsf"
             nv_name      = "∫. µ√’‡æ™√œ"      
             n_pol        = ""
             n_pol        = trim(wdetail.policy_no)     
             nt_policyno  = ""                 
             nt_ems       = ""                 
             n_ems        = ""
             n_date       = ""
             nt_date      = ?.
      IF n_pol <> "" THEN DO:
             CREATE "Notes.NotesSession"  chNotesSession. 
             /*--------- Lotus Server Real ----------*/
             nv_tmp    = "safety\fi\" + n_snote.
             chNotesDatabase = chNotesSession:GetDatabase ("Safety_NotesServer/Safety",nv_tmp).
             /*-------------------------------------*/
             /*--------- Lotus Server test ----------
             nv_tmp    = "U:\Lotus\Notes\Data\" + n_snote.
             chNotesDatabase = chNotesSession:GetDatabase ("",nv_tmp).
             -------------------------------*/
            IF chNotesDatabase:IsOpen() = NO  THEN  DO:
                MESSAGE "Can not open database" SKIP  
                        "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
            END.
            ELSE DO:
                chNotesView = chNotesDatabase:GetView("ByPol").
                chnotecollection = chNotesView:GetallDocumentsByKey(n_pol).
                chDocument  =  chnotecollection:GetlastDocument.
                IF VALID-HANDLE(chDocument) = YES THEN DO:
                     chitem       = chDocument:Getfirstitem("PolicyNo"). 
                     nt_policyno  = chitem:TEXT.                      
                     chitem       = chDocument:Getfirstitem("EmsNo").     
                     nt_ems       = chitem:TEXT.
                     chitem       = chDocument:Getfirstitem("Date").     
                     nt_date      = chitem:TEXT.                
                    
                   IF nt_ems <> "" THEN DO:
                       ASSIGN wdetail.regis_no   = TRIM(nt_ems)
                              wdetail.send_date  = trim(string(nt_date,"99/99/9999"))
                              wdetail.send_data  = trim(string(nt_date,"99/99/9999")).
                   END.
                   ELSE DO: 
                       ASSIGN wdetail.regis_no   =  "" 
                              wdetail.send_date  =  "" 
                              wdetail.send_data  =  "" .
                   END.
                END.
            END.
            RELEASE  OBJECT chNotesSession NO-ERROR.  
            RELEASE  OBJECT chNotesDataBase NO-ERROR. 
            RELEASE  OBJECT chDocument NO-ERROR.      
            RELEASE  OBJECT chNotesView NO-ERROR.     
            RELEASE  OBJECT chDocument1 NO-ERROR.     
            RELEASE  OBJECT chNotesView1 NO-ERROR.    
            RELEASE  OBJECT chnotecollection NO-ERROR.
      END. /* if nv_pol */
    /*END. /* for each*/
    RELEASE wdetail.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktrn c-wins 
PROCEDURE proc_chktrn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF  cb_search  =  "Trans Date"  THEN DO:
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note17,TRIM(fi_search)) <> 0   AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
        END.
        ELSE IF  ra_status1 = 2 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note17,TRIM(fi_search)) <> 0   AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
        END.
        ELSE IF  ra_status1 = 3 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note17,TRIM(fi_search)) <> 0   AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
        END.
        ELSE DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note17,TRIM(fi_search)) <> 0     NO-LOCK.
        END.
        ASSIGN nv_rectlt =  recid(tlt) .  
        /*Apply "Entry"  to fi_search.
        Return no-apply. */

    END.
    ELSE IF  cb_search  =  "Release Date"  THEN DO:
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note18,TRIM(fi_search)) <> 0   AND
                INDEX(tlt.releas,"yes") <> 0    NO-LOCK.
        END.
        ELSE IF  ra_status1 = 2 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note18,TRIM(fi_search)) <> 0   AND
                INDEX(tlt.releas,"no") <> 0    NO-LOCK.
        END.
        ELSE IF  ra_status1 = 3 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note18,TRIM(fi_search)) <> 0   AND
                INDEX(tlt.releas,"cancel") <> 0    NO-LOCK.
        END.
        ELSE DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=  fi_trndatfr    And
                tlt.trndat  <=  fi_trndatto    And
                tlt.genusr   =  "TPIS"         And
                index(tlt.note18,TRIM(fi_search)) <> 0    NO-LOCK.
        END.
        ASSIGN nv_rectlt =  recid(tlt) .  
        /*Apply "Entry"  to br_tlt.
        Apply "Entry"  to  fi_search.
        Return no-apply. */
    END.
    ELSE If  cb_search  =  "New-LCV"  Then do:  
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat   >=  fi_trndatfr   And  tlt.trndat   <=  fi_trndatto   And
                tlt.genusr    =  "TPIS"        And  tlt.flag      =  "NW"          AND
                index(tlt.rec_addr4,"LCV") <> 0 AND INDEX(tlt.releas,"yes") <> 0   NO-LOCK.
         END.
         ELSE IF ra_status1 = 2 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND tlt.flag      =  "NW"         AND
                index(tlt.rec_addr4,"LCV") <> 0 AND INDEX(brstat.tlt.releas,"no") <> 0 NO-LOCK.
         END.
         ELSE IF ra_status1 = 3 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "NW"         AND
                index(tlt.rec_addr4,"LCV") <> 0 AND index(brstat.tlt.releas,"cancel") <> 0 NO-LOCK.
         END.
         ELSE DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "NW"         AND 
                index(tlt.rec_addr4,"LCV") <> 0 NO-LOCK.
         END.
         ASSIGN nv_rectlt =  recid(tlt) .  
         /*Apply "Entry"  to br_tlt.
         Return no-apply.*/              
    END.
    ELSE If  cb_search  =  "New-CV"  Then do:  
        IF  ra_status1 = 1 THEN DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat   >=  fi_trndatfr   And  tlt.trndat   <=  fi_trndatto   And
                tlt.genusr    =  "TPIS"        And  tlt.flag      =  "NW"          AND
                index(tlt.rec_addr4,"LCV") = 0 AND INDEX(tlt.releas,"yes") <> 0   NO-LOCK.
         END.
         ELSE IF ra_status1 = 2 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       AND tlt.flag      =  "NW"         AND
                index(tlt.rec_addr4,"LCV") = 0 AND INDEX(brstat.tlt.releas,"no") <> 0 NO-LOCK.
         END.
         ELSE IF ra_status1 = 3 THEN DO: 
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "NW"         AND
                index(tlt.rec_addr4,"LCV") = 0 AND index(brstat.tlt.releas,"cancel") <> 0 NO-LOCK.
         END.
         ELSE DO:
             Open Query br_tlt 
                For each tlt Use-index  tlt01 Where
                tlt.trndat   >=  fi_trndatfr  And   tlt.trndat   <=  fi_trndatto  And
                tlt.genusr    =  "TPIS"       And   tlt.flag      =  "NW"         AND 
                index(tlt.rec_addr4,"LCV") = 0 NO-LOCK.
         END.
         ASSIGN nv_rectlt =  recid(tlt) .  
         /*Apply "Entry"  to br_tlt.
         Return no-apply.*/              
    END.
    ELSE DO:
        ASSIGN nv_rectlt =  recid(tlt) .  
        /*Apply "Entry"  to  fi_search.
        Return no-apply.*/
    END.
    
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createslk_N c-wins 
PROCEDURE proc_createslk_N :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  ‰ø≈Ï Ëßµ√’‡æ™√     
------------------------------------------------------------------------------*/
/*--------------- Create by : A58-0489-------------------------------------*/
If  substr(fi_outfile1,length(fi_outfile1) - 3,4) <>  ".SLK"  Then
    fi_outfile1  =  Trim(fi_outfile1) + ".SLK"  .
ASSIGN /*nv_cnt   =  0*/
       nv_row   =  0 .
OUTPUT STREAM ns2 TO VALUE(fi_outfile1).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "Ins. Year type               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "Business type                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "TAS received by              "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "Ins company                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "Insurance ref no.            "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "TPIS Contract No.            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Title name                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "customer name                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "customer lastname            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Customer type                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Director Name                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "ID number                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "House no.                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Building                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "Village name/no.             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "Soi                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "Road                         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "Sub-district                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "District                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "Province                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "Postcode                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "Brand                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "Car model                    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "Insurance Code               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "Model Year                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "Usage Type                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "Colour                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "Car Weight (CC.)             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "Year                         "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "Engine No.                   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "Chassis No.                  "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "Accessories (for CV)         "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "Accessories amount           "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "License No.                  "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "Registered Car License       "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "Campaign                     "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "Type of work                 "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "Insurance amount             "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "Insurance Date ( Voluntary ) "    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "Expiry Date ( Voluntary)     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "Last Policy No. (Voluntary)  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "Insurance Type               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "Net premium (Voluntary)      "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "Gross premium (Voluntary)    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "Stamp                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "VAT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "WHT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "Compulsory No.               "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "Insurance Date ( Compulsory )"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "Expiry Date ( Compulsory)    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "Net premium (Compulsory)     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "Gross premium (Compulsory)   "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "Stamp                        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "VAT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "WHT                          "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "Dealer                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "Showroom                     "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "Payment Type                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "Beneficiery                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' "Mailing House no.            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "Mailing  Building            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "Mailing  Village name/no.    "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "Mailing Soi                  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "Mailing  Road                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "Mailing  Sub-district        "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "Mailing  District            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "Mailing Province             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "Mailing Postcode             "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "Policy no. to customer date  "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "New policy no                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "Insurer Stamp Date           "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "Remark                       "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "Occupation code              "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "Register NO.                 "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "Status Policy                "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "Status Compulsory            "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"   '"' "Driver1_title     "    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"   '"' "Driver1_name      "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"   '"' "Driver1_lastname  "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"   '"' "Driver1_birthdate "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"   '"' "Driver1_id_no     "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"   '"' "Driver1_license_no"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"   '"' "Driver1_occupation"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"   '"' "Driver2_title     "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"   '"' "Driver2_name      "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"   '"' "Driver2_lastname  "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"   '"' "Driver2_birthdate "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"   '"' "Driver2_id_no     "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"   '"' "Driver2_license_no"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"   '"' "Driver2_occupation"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"   '"' "Driver3_title     "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"   '"' "Driver3_name      "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"   '"' "Driver3_lastname  "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"   '"' "Driver3_birthdate "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"   '"' "Driver3_id_no     "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"   '"' "Driver3_license_no"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"   '"' "Driver3_occupation"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"   '"' "Driver4_title     "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"   '"' "Driver4_name      "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K"  '"' "Driver4_lastname  "    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K"  '"' "Driver4_birthdate "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K"  '"' "Driver4_id_no     "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K"  '"' "Driver4_license_no"    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K"  '"' "Driver4_occupation"    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K"  '"' "Driver5_title     "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K"  '"' "Driver5_name      "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K"  '"' "Driver5_lastname  "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K"  '"' "Driver5_birthdate "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K"  '"' "Driver5_id_no     "    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K"  '"' "Driver5_license_no"    '"' SKIP.    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K"  '"' "Driver5_occupation"    '"' SKIP.

RUN proc_matchchktil. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.
RUN proc_createtxt_N.
For each  wdetail :
    DELETE  wdetail.
END.
message "Export File  Complete"  view-as alert-box.

/*---------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createslk_re c-wins 
PROCEDURE proc_createslk_re :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by A58-0489     
------------------------------------------------------------------------------*/
If  substr(fi_outfile1,length(fi_outfile1) - 3,4) <>  ".slk"  Then
    fi_outfile1  =  Trim(fi_outfile1) + ".slk"  .
ASSIGN nv_row  =  0.
OUTPUT STREAM ns2 TO VALUE(fi_outfile1).
PUT STREAM ns2 "ID;PND" SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "  Ins. Year type                 "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "  Business type                  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "  TAS received by                "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "  Ins company                    "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "  Insurance ref no.              "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "  TPIS Contract No.              "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "  Title name                     "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "  customer name                  "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "  customer lastname              "  '"' SKIP.                            
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' "  Customer type                  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' "  Director Name                  "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' "  ID number                      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' "  House no.                      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' "  Building                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' "  Village name/no.               "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' "  Soi                            "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' "  Road                           "  '"' SKIP.                                   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' "  Sub-district                   "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' "  District                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' "  Province                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' "  Postcode                       "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' "  Brand                          "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' "  Car model                      "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' "  Insurance Code                 "  '"' SKIP.                     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' "  Model Year                     "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' "  Usage Type                     "  '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' "  Colour                         "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' "  Car Weight                     "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' "  Year                           "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' "  Engine No.                     "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' "  Chassis No.                    "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' "  Accessories (for CV)           "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' "  Accessories amount             "  '"' SKIP.                                           
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' "  License No.                    "  '"' SKIP.                               
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' "  Registered Car License         "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' "  Campaign                       "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' "  Type of work                   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' "  Garage Repair                  "  '"' SKIP. /*a62-0422*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' "  Model Description              "  '"' SKIP. /*a62-0422*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' "  Insurance amount               "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' "  Insurance Date ( Voluntary )   "  '"' SKIP.                                                
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' "  Expiry Date ( Voluntary)       "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' "  Last Policy No. (Voluntary)    "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' "  Insurance Type                 "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' "  Net premium (Voluntary)        "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' "  Gross premium (Voluntary)      "  '"' SKIP.                                       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' "  Stamp                          "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' "  VAT                            "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' "  WHT                            "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' "  Compulsory No.                 "  '"' SKIP.                                      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' "  Insurance Date ( Compulsory )  "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' "  Expiry Date ( Compulsory)      "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' "  Net premium (Compulsory)       "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' "  Gross premium (Compulsory)     "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' "  Stamp                          "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' "  VAT                            "  '"' SKIP.                    
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"' "  WHT                            "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"' "  Dealer                         "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"' "  Showroom                       "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"' "  Payment Type                   "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"' "  Beneficiery                    "  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"' "  Mailing House no.              "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"' "  Mailing  Building              "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"' "  Mailing  Village name/no.      "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"' "  Mailing Soi                    "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"' "  Mailing  Road                  "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"' "  Mailing  Sub-district          "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"' "  Mailing  District              "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"' "  Mailing Province               "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"' "  Mailing Postcode               "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"' "  Policy no. to customer date    "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"' "  New policy no                  "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"' "  Insurer Stamp Date             "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"' "  Remark                         "  '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"' "  Occupation code                "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"' "  Register NO.                   "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"' "  Status Policy                  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"' "  Status Compulsory              "  '"' SKIP.
RUN proc_matchchktil_re.
nv_row   =  nv_row + 1.
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

RUN proc_createtxt_re.

FOR EACH wdetail.
    DELETE wdetail.
END.
message "Export Match File Policy Complete"  view-as ALERT-BOX.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createtxt_N c-wins 
PROCEDURE proc_createtxt_N :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outfile2,length(fi_outfile2) - 3,4) <>  ".CSV"  Then
    fi_outfile2  =  Trim(fi_outfile2) + ".CSV"  .
OUTPUT TO VALUE(fi_outfile2).
EXPORT DELIMITER ","
"Ins. Year type "                       /*1  */            
"Business type"                         /*2  */   
"TAS received by"                       /*3  */     
"Ins company"                           /*4  */ 
"Insurance ref no."                     /*5  */       
"TPIS Contract No."                     /*6  */       
"Title name"                            /*7  */
"customer name"                         /*8  */   
"customer lastname"                     /*9  */       
"Customer type"                         /*10 */
"Director Name"                         /*11 */
"ID number"                             /*12 */
"House no."                             /*13 */
"Building"                              /*14 */
"Village name/no."                      /*15 */
"Soi "                                  /*16 */
"Road"                                  /*17 */ 
"Sub-district"                          /*18 */
"District"                              /*19 */
"Province"                              /*20 */
"Postcode"                              /*21 */
"Brand "                                /*22 */
"Car model"                             /*23 */
"Insurance Code"                        /*24 */
"Model Year "                           /*25 */
"Usage Type "                           /*26 */
"Colour"                                /*27 */
"Car Weight "                           /*28 */
"Year"                                  /*29 */
"Engine No. "                           /*30 */
"Chassis No."                           /*31 */
"Accessories (for CV)"                  /*32 */
"Accessories amount"                    /*33 */                       
"License No."                           /*34 */    
"Registered Car License"                /*35 */    
"Campaign"                              /*36 */
"Type of work"                          /*37 */
"Insurance amount "                     /*38 */
"Insurance Date ( Voluntary )"          /*39 */                                      
"Expiry Date ( Voluntary) "             /*40 */                         
"Last Policy No. (Voluntary) "          /*41 */          
"Insurance Type "                       /*42 */
"Net premium (Voluntary)"               /*43 */     
"Gross premium (Voluntary)"             /*44 */                          
"Stamp"                                 /*45 */
"VAT"                                   /*46 */
"WHT"                                   /*47 */
"Compulsory No."                        /*48 */              
"Insurance Date ( Compulsory )"         /*49 */           
"Expiry Date ( Compulsory)"             /*50 */       
"Net premium (Compulsory)"              /*51 */      
"Gross premium (Compulsory)"            /*52 */        
"Stamp"                                 /*53 */
"VAT"                                   /*54 */
"WHT"                                   /*55 */
"Dealer"                                /*56 */
"Showroom"                              /*57 */
"Payment Type"                          /*58 */
"Beneficiery"                           /*59 */
"Mailing House no."                     /*60 */
"Mailing Building"                      /*61 */
"Mailing Village name/no."              /*62 */
"Mailing Soi"                           /*63 */
"Mailing Road"                          /*64 */
"Mailing Sub-district"                  /*65 */
"Mailing District"                      /*66 */
"Mailing Province"                      /*67 */
"Mailing Postcode"                      /*68 */
"Policy no. to customer date"           /*69 */
"New policy no"                         /*70 */
"Insurer Stamp Date"                    /*71 */
"Remark"                                /*72 */
"Occupation code"                       /*73 */
"Driver1_title     "
"Driver1_name      "
"Driver1_lastname  "
"Driver1_birthdate "
"Driver1_id_no     "
"Driver1_license_no"
"Driver1_occupation"
"Driver2_title     "
"Driver2_name      "
"Driver2_lastname  "
"Driver2_birthdate "
"Driver2_id_no     "
"Driver2_license_no"
"Driver2_occupation"
"Driver3_title     "
"Driver3_name      "
"Driver3_lastname  "
"Driver3_birthdate "
"Driver3_id_no     "
"Driver3_license_no"
"Driver3_occupation"
"Driver4_title     "
"Driver4_name      "
"Driver4_lastname  "
"Driver4_birthdate "
"Driver4_id_no     "
"Driver4_license_no"
"Driver4_occupation"
"Driver5_title     "
"Driver5_name      "
"Driver5_lastname  "
"Driver5_birthdate "
"Driver5_id_no     "
"Driver5_license_no"
"Driver5_occupation".

FOR EACH wdetail NO-LOCK.     
    
EXPORT DELIMITER ","
trim(wdetail.ins_ytyp)                                                                                 /*1  */
trim(wdetail.bus_typ)                                                                                  /*2  */
trim(wdetail.TASreceived)                                                                              /*3  */
trim(wdetail.InsCompany)                                                                               /*4  */
trim(wdetail.Insurancerefno)                                                                           /*5  */
trim(wdetail.tpis_no)                                                                                  /*6  */
trim(wdetail.ntitle)                                                                                   /*7  */
TRIM(wdetail.insnam)                                                                                   /*8  */
TRIM(wdetail.NAME2)                                                                                    /*9  */
trim(wdetail.cust_type)                  /*®“°‰ø≈Ï */                                                  /*10 */
trim(wdetail.nDirec)                                                                                   /*11 */
trim(wdetail.ICNO)                                                                                     /*12 */
trim(wdetail.address)                                                                                  /*13 */
trim(wdetail.build)                                                                                    /*14 */
trim(wdetail.mu)                                                                                       /*15 */
trim(wdetail.soi)                                                                                      /*16 */
trim(wdetail.road)                                                                                     /*17 */
trim(wdetail.tambon)                                                                                   /*18 */
trim(wdetail.amper)                                                                                    /*19 */
trim(wdetail.country)                                                                                  /*20 */
trim(wdetail.post)                                                                                     /*21 */
trim(wdetail.brand)                      /*®“°‰ø≈Ï*/                                                   /*22 */
trim(wdetail.model)                      /*®“°‰ø≈Ï*/                                                   /*23 */
trim(wdetail.class)                                                                                    /*24 */
trim(wdetail.md_year)                    /*®“°‰ø≈Ï*/                                                   /*25 */
trim(wdetail.Usage)                      /*®“°‰ø≈Ï*/                                                   /*26 */
trim(wdetail.coulor)                     /*®“°‰ø≈Ï*/                                                   /*27 */
trim(wdetail.cc)                         /*®“°‰ø≈Ï*/                                                   /*28 */
trim(wdetail.regis_year)                 /*®“°‰ø≈Ï*/                                                   /*29 */
trim(wdetail.engno)                                                                                    /*30 */
trim(wdetail.chasno)                                                                                   /*31 */
trim(wdetail.Acc_CV)                    /*®“°‰ø≈Ï*/                                                    /*32 */
trim(wdetail.Acc_amount) /*®“°‰ø≈Ï*/                                                                   /*33 */
trim(wdetail.License)                                                                                  /*34 */
trim(wdetail.regis_CL)                                                                                 /*35 */
trim(wdetail.campaign)                                                                                 /*36 */
trim(wdetail.typ_work)                                                                                 /*37 */
TRIM(wdetail.si)                                                                                       /*38 */
IF wdetail.pol_comm_date <> "" THEN string(date(wdetail.pol_comm_date),"99/99/9999") ELSE ""          /*39 */
IF wdetail.pol_exp_date <> "" THEN string(date(wdetail.pol_exp_date),"99/99/9999") ELSE ""            /*40 */
trim(wdetail.LAST_pol)                                                                                 /*41 */
trim(wdetail.cover)                                                                                    /*42 */
trim(wdetail.pol_netprem)                                                                              /*43 */
trim(wdetail.pol_gprem)                                                                                /*44 */
trim(wdetail.pol_stamp)                                                                                /*45 */
trim(wdetail.pol_vat)                                                                                  /*46 */
trim(wdetail.pol_wht)               /*®“°‰ø≈Ï */                                                       /*47 */
trim(wdetail.com_no)                                                                                   /*48 */
if wdetail.com_comm_date <> "" THEN string(date(wdetail.com_comm_date),"99/99/9999") ELSE ""          /*49 */
if wdetail.com_exp_date <> "" THEN string(date(wdetail.com_exp_date),"99/99/9999")  ELSE ""           /*50 */
trim(wdetail.com_netprem)                                                                              /*51 */
trim(wdetail.com_gprem)                                                                                /*52 */
trim(wdetail.com_stamp)                                                                                /*53 */
trim(wdetail.com_vat)               /*®“°‰ø≈Ï*/                                                        /*54 */
trim(wdetail.com_wht)               /*®“°‰ø≈Ï*/                                                        /*55 */
trim(wdetail.deler)                 /*®“°‰ø≈Ï*/                                                        /*56 */
trim(wdetail.showroom)              /*®“°‰ø≈Ï*/                                                        /*57 */
trim(wdetail.typepay)               /*®“°‰ø≈Ï*/                                                        /*58 */
trim(wdetail.financename)           /*®“°‰ø≈Ï*/                                                        /*59 */
trim(wdetail.mail_hno)              /*®“°‰ø≈Ï*/                                                        /*60 */
trim(wdetail.mail_build)            /*®“°‰ø≈Ï*/                                                        /*61 */
trim(wdetail.mail_mu)               /*®“°‰ø≈Ï*/                                                        /*62 */
trim(wdetail.mail_soi)              /*®“°‰ø≈Ï*/                                                        /*63 */
trim(wdetail.mail_road)             /*®“°‰ø≈Ï*/                                                        /*64 */
trim(wdetail.mail_tambon)           /*®“°‰ø≈Ï*/                                                        /*65 */
trim(wdetail.mail_amper)            /*®“°‰ø≈Ï*/                                                        /*66 */
trim(wdetail.mail_country)          /*®“°‰ø≈Ï*/                                                        /*67 */
trim(wdetail.mail_post)                                                                                /*68 */
IF trim(wdetail.send_date) <> "?" AND trim(wdetail.send_date) <> "" THEN string(date(wdetail.send_date),"99/99/9999") ELSE ""                                                                                /*69 */
trim(wdetail.policy_no)                                                             /*70 */
IF trim(wdetail.send_data) <> "?" AND trim(wdetail.send_data) <> "" THEN string(date(wdetail.send_data),"99/99/9999") ELSE ""                                                                               /*71 */
trim(wdetail.REMARK1)                                                                                  /*72 */
trim(wdetail.occup) 
trim(wdetail.Driver1_title) 
trim(wdetail.Driver1_name) 
trim(wdetail.Driver1_lastname)  
trim(wdetail.Driver1_birthdate) 
trim(wdetail.Driver1_id_no)   
trim(wdetail.Driver1_license_no) 
trim(wdetail.Driver1_occupation) 
trim(wdetail.Driver2_title)   
trim(wdetail.Driver2_name)    
trim(wdetail.Driver2_lastname)
trim(wdetail.Driver2_birthdate) 
trim(wdetail.Driver2_id_no)   
trim(wdetail.Driver2_license_no) 
trim(wdetail.Driver2_occupation) 
trim(wdetail.Driver3_title)   
trim(wdetail.Driver3_name)    
trim(wdetail.Driver3_lastname)
trim(wdetail.Driver3_birthdate) 
trim(wdetail.Driver3_id_no)   
trim(wdetail.Driver3_license_no) 
trim(wdetail.Driver3_occupation) 
trim(wdetail.Driver4_title)   
trim(wdetail.Driver4_name)    
trim(wdetail.Driver4_lastname)
trim(wdetail.Driver4_birthdate) 
trim(wdetail.Driver4_id_no)   
trim(wdetail.Driver4_license_no) 
trim(wdetail.Driver4_occupation) 
trim(wdetail.Driver5_title)   
trim(wdetail.Driver5_name)    
trim(wdetail.Driver5_lastname)
trim(wdetail.Driver5_birthdate) 
trim(wdetail.Driver5_id_no)   
trim(wdetail.Driver5_license_no) 
trim(wdetail.Driver5_occupation) . 
                                                    
END.                                                                                                   
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createtxt_re c-wins 
PROCEDURE proc_createtxt_re :
If  substr(fi_outfile2,length(fi_outfile2) - 3,4) <>  ".csv"  Then
    fi_outfile2  =  Trim(fi_outfile2) + ".csv"  .
OUTPUT TO VALUE(fi_outfile2).
EXPORT DELIMITER ","                       
"Ins. Year type"                            /*1  */                           
"Business type"                             /*2  */
"TAS received by"                           /*3  */ 
"Ins company"                               /*4  */
"Insurance ref no."                         /*5  */   
"TPIS Contract No."                         /*6  */   
"Title name"                                /*7  */
"customer name "                            /*8  */
"customer lastname"                         /*9  */   
"Customer type"                             /*10 */
"Director Name"                             /*11 */
"ID number "                                /*12 */
"House no. "                                /*13 */
"Building "                                 /*14 */
"Village name/no."                          /*15 */
"Soi"                                       /*16 */
"Road"                                      /*17 */
"Sub-district"                              /*18 */
"District"                                  /*19 */
"Province"                                  /*20 */
"Postcode"                                  /*21 */
"Brand "                                    /*22 */
"Car model"                                 /*23 */
"Insurance Code"                            /*24 */
"Model Year"                                /*25 */
"Usage Type"                                /*26 */
"Colour"                                    /*27 */
"Car Weight"                                /*28 */
"Year"                                      /*29 */
"Engine No."                                /*30 */
"Chassis No."                               /*31 */
"Accessories (for CV)"                      /*32 */
"Accessories amount  "                      /*33 */                     
"License No."                               /*34 */
"Registered Car License"                    /*35 */
"Campaign "                                 /*36 */
"Type of work"                              /*37 */
"Garage "                                   /*38 */  
"Model Description "                        /*39 */  
"Insurance amount"                          /*40 */   
"Insurance Date ( Voluntary )"              /*41 */                                  
"Expiry Date ( Voluntary)"                  /*42 */                    
"Last Policy No. (Voluntary)"               /*43 */     
"Insurance Type"                            /*44 */   
"Net premium (Voluntary)"                   /*45 */   
"Gross premium (Voluntary)"                 /*46 */                      
"Stamp"                                     /*47 */   
"VAT"                                       /*48 */   
"WHT"                                       /*49 */   
"Compulsory No."                            /*50 */          
"Insurance Date ( Compulsory )"             /*51 */       
"Expiry Date ( Compulsory)"                 /*52 */   
"Net premium (Compulsory) "                 /*53 */   
"Gross premium (Compulsory)"                /*54 */    
"Stamp "                                    /*55 */   
"VAT"                                       /*56 */   
"WHT"                                       /*57 */   
"Dealer"                                    /*58 */   
"Showroom "                                 /*59 */   
"Payment Type"                              /*60 */   
"Beneficiery "                              /*61 */   
"Mailing House no."                         /*62 */   
"Mailing  Building"                         /*63 */   
"Mailing  Village name/no."                 /*64 */   
"Mailing Soi"                               /*65 */   
"Mailing  Road"                             /*66 */   
"Mailing  Sub-district"                     /*67 */   
"Mailing  District"                         /*68 */   
"Mailing Province"                          /*69 */   
"Mailing Postcode"                          /*70 */   
"Policy no. to customer date"               /*71 */   
"New policy no "                            /*72 */   
"Insurer Stamp Date"                        /*73 */   
"Remark "                                   /*74 */
"Occupation code"  .                        /*75 */
FOR EACH wdetail NO-LOCK.  
EXPORT DELIMITER ","                        
 trim(wdetail.ins_ytyp)                                                                                        /*1  */
 trim(wdetail.bus_typ)                                                                                         /*2  */
 trim(wdetail.TASreceived)                                                                                     /*3  */
 trim(wdetail.InsCompany)                                                                                      /*4  */
 trim(wdetail.Insurancerefno)                                                                                  /*5  */
 trim(wdetail.tpis_no)                                                                                         /*6  */
 trim(wdetail.ntitle)                                                                                          /*7  */
 trim(wdetail.insnam)                                                                                          /*8  */
 trim(wdetail.NAME2)                                                                                           /*9  */
 trim(wdetail.cust_type)                                                                                       /*10 */
 trim(wdetail.nDirec)                                                                                          /*11 */
 trim(wdetail.ICNO)                                                                                            /*12 */
 trim(wdetail.address)                                                                                         /*13 */
 trim(wdetail.build)                                                                                           /*14 */
 trim(wdetail.mu)                                                                                              /*15 */
 trim(wdetail.soi)                                                                                             /*16 */
 trim(wdetail.road)                                                                                            /*17 */
 trim(wdetail.tambon)                                                                                          /*18 */
 trim(wdetail.amper)                                                                                           /*19 */
 trim(wdetail.country)                                                                                         /*20 */
 trim(wdetail.post)                                                                                            /*21 */
 trim(wdetail.brand)                                                                                           /*22 */
 trim(wdetail.model)                                                                                           /*23 */
 trim(wdetail.class)                                                                                           /*24 */
 trim(wdetail.md_year)                                                                                         /*25 */
 trim(wdetail.Usage)                                                                                           /*26 */
 trim(wdetail.coulor)                                                                                          /*27 */
 trim(wdetail.cc)                                                                                              /*28 */
 trim(wdetail.regis_year)                                                                                      /*29 */
 trim(wdetail.engno)                                                                                           /*30 */
 trim(wdetail.chasno)                                                                                          /*31 */
 trim(wdetail.Acc_CV)                                                                                          /*32 */
 trim(wdetail.Acc_amount)                                                                                      /*33 */
 trim(wdetail.License)                                                                                         /*34 */
 trim(wdetail.regis_CL)                                                                                        /*35 */
 trim(wdetail.campaign)                                                                                        /*36 */
 trim(wdetail.typ_work)                                                                                        /*37 */
 trim(wdetail.garage)                                                                                          /*38 */      /*A62-0422*/
 trim(wdetail.desmodel)                                                                                        /*39 */      /*A62-0422*/
 trim(wdetail.si)                                                                                              /*40 */ 
 if wdetail.pol_comm_date <> "" then string(date(wdetail.pol_comm_date),"99/99/9999") ELSE ""                 /*41 */ 
 if wdetail.pol_exp_date  <> "" then string(date(wdetail.pol_exp_date),"99/99/9999") ELSE ""                  /*42 */ 
 trim(wdetail.prvpol)                                                                                          /*43 */ 
 trim(wdetail.cover)                                                                                           /*44 */ 
 trim(wdetail.pol_netprem)                                                                                     /*45 */ 
 trim(wdetail.pol_gprem)                                                                                       /*46 */ 
 trim(wdetail.pol_stamp)                                                                                       /*47 */ 
 trim(wdetail.pol_vat)                                                                                         /*48 */ 
 trim(wdetail.pol_wht)                                                                                         /*49 */ 
 trim(wdetail.com_no)                                                                                          /*50 */ 
 IF wdetail.com_comm_date <> "" then string(date(wdetail.com_comm_date),"99/99/9999") ELSE ""                 /*51 */ 
 IF wdetail.com_exp_date  <> "" then string(date(wdetail.com_exp_date),"99/99/9999") ELSE ""                  /*52 */ 
 trim(wdetail.com_netprem)                                                                                     /*53 */ 
 trim(wdetail.com_gprem)                                                                                       /*54 */ 
 trim(wdetail.com_stamp)                                                                                       /*55 */ 
 trim(wdetail.com_vat)                                                                                         /*56 */ 
 trim(wdetail.com_wht)                                                                                         /*57 */ 
 trim(wdetail.deler)                                                                                           /*58 */ 
 trim(wdetail.showroom)                                                                                        /*59 */ 
 trim(wdetail.typepay)                                                                                         /*60 */ 
 trim(wdetail.financename)                                                                                     /*61 */ 
 trim(wdetail.mail_hno)                                                                                        /*62 */ 
 trim(wdetail.mail_build)                                                                                      /*63 */ 
 trim(wdetail.mail_mu)                                                                                         /*64 */ 
 trim(wdetail.mail_soi)                                                                                        /*65 */ 
 trim(wdetail.mail_road)                                                                                       /*66 */ 
 trim(wdetail.mail_tambon)                                                                                     /*67 */ 
 trim(wdetail.mail_amper)                                                                                      /*68 */ 
 trim(wdetail.mail_country)                                                                                    /*69 */ 
 trim(wdetail.mail_post)                                                                                       /*70 */ 
 IF trim(wdetail.send_date) <> "?" AND trim(wdetail.send_date) <> "" THEN string(date(wdetail.send_date),"99/99/9999") ELSE ""                                                                                /*69 */
 trim(wdetail.policy_no)                                                                /*70 */
 IF trim(wdetail.send_data) <> "?" AND trim(wdetail.send_data) <> "" THEN string(date(wdetail.send_data),"99/99/9999") ELSE ""                                                                               /*71 */
 trim(wdetail.REMARK)                                                                                          /*74 */
 TRIM(wdetail.occup).                                                                                          /*75 */
END.                                                                                                           
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchchktil c-wins 
PROCEDURE proc_matchchktil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: ‰ø≈Ï Ëßµ√’‡æ™√      
------------------------------------------------------------------------------*/
/*
DEF VAR n_status AS LOGICAL.
DEF VAR n_stpol  AS CHAR.
DEF VAR n_stcom  AS CHAR.
DEF VAR n_rencnt AS INT.
DEF VAR n_endcnt AS INT.
DEF VAR n_length AS INT.
DEF VAR n_policyuwm100 AS CHAR FORMAT "x(20)" INIT "".*/
For each wdetail .
  IF wdetail.ins_ytyp = "" THEN DELETE wdetail.
  ELSE DO:
      ASSIGN n_stpol             = ""          n_stcom          = ""           n_length = 0
             wdetail.policy_no   = ""          wdetail.delerco  = ""           wdetail.financecd   = "".  
      FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.tpis_no) NO-LOCK.
          IF      sicuw.uwm100.poltyp <> "V70"  THEN NEXT.
          ELSE IF sicuw.uwm100.expdat <= TODAY  THEN DO:
              ASSIGN wdetail.policy        = ""     n_stpol               = ""     
                     wdetail.pol_comm_date = ""     wdetail.pol_exp_date  = "".
          END.
          ELSE DO:
                 ASSIGN 
                    wdetail.policy_no     = sicuw.uwm100.policy
                    wdetail.pol_comm_date = string(sicuw.uwm100.comdat) 
                    wdetail.pol_exp_date  = string(sicuw.uwm100.expdat) 
                    wdetail.ntitle        = sicuw.uwm100.ntitle                                                 
                    wdetail.ICNO          = sicuw.uwm100.anam2
                    wdetail.pol_netprem   = STRING(sicuw.uwm100.prem_t)
                    wdetail.pol_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)
                    wdetail.pol_stamp     = string(sicuw.uwm100.rstp_t)    
                    wdetail.pol_vat       = string(sicuw.uwm100.rtax_t)
                    wdetail.pol_wht       = STRING((DECI(wdetail.pol_netprem) + DECI(wdetail.pol_stamp)) * 0.01 )
                    n_status              = sicuw.uwm100.releas
                    n_stpol               = STRING(n_status) + "/" + sicuw.uwm100.polsta.
                 IF wdetail.cust_type = "J" THEN DO:
                     IF INDEX(uwm100.name1,"®”°—¥") <> 0 THEN DO:
                         ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"®”°—¥") + 5 )
                                wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail.NAME2   = "".
                     END.
                     ELSE IF INDEX(uwm100.name1,"¡À“™π") <> 0 THEN
                         ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"¡À“™π") + 5 )
                                wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail.NAME2   = "".
                  END.
                  ELSE DO:
                      IF INDEX(sicuw.uwm100.ntitle,"¡Ÿ≈π‘∏‘") = 0 THEN DO:
                          ASSIGN  wdetail.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                  n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail.insnam)
                                  wdetail.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                      END.
                      ELSE DO:
                          ASSIGN wdetail.insnam = sicuw.uwm100.name1
                                 wdetail.insnam = TRIM(wdetail.insnam) + TRIM(sicuw.uwm100.name2)
                                 wdetail.NAME2  = "".
                      END.
                  END.
                FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                    sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                    sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                    sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                    sicuw.uwm301.riskno = 1                   AND
                    sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
                 IF AVAIL sicuw.uwm301 THEN DO:
                   ASSIGN wdetail.License     = sicuw.uwm301.vehreg
                          wdetail.engno       = sicuw.uwm301.eng_no
                          wdetail.chasno      = sicuw.uwm301.cha_no.
                          
                          FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                              sicuw.uwm130.policy = sicuw.uwm100.policy AND 
                              sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                              sicuw.uwm130.endcnt = sicuw.uwm100.endcnt AND 
                              sicuw.uwm130.riskno = 1                   AND
                              sicuw.uwm130.itemno = 1                   NO-LOCK NO-ERROR.
                          IF AVAIL sicuw.uwm130 THEN 
                             ASSIGN wdetail.si   = IF sicuw.uwm301.covcod = "1" THEN STRING(sicuw.uwm130.uom6_v) ELSE STRING(sicuw.uwm130.uom7_v).
                          ELSE
                             ASSIGN wdetail.si   = "".
                 END.
                 ELSE DO:
                     ASSIGN wdetail.License   = ""      wdetail.engno       = ""        wdetail.chasno      = "".
                 END.
                 RUN proc_chknote.
           END.
      END.
      IF wdetail.com_no <> "" THEN DO:
        FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail.tpis_no) NO-LOCK.
             IF sicuw.uwm100.poltyp <> "V72"  THEN NEXT.
             ELSE IF sicuw.uwm100.expdat <= TODAY THEN DO:
                 ASSIGN wdetail.com_no         = ""         n_stcom                = ""           
                        wdetail.com_comm_date  = ""         wdetail.com_exp_date   = "".
            END.
            ELSE DO:
              ASSIGN 
                  wdetail.com_no        = sicuw.uwm100.policy 
                  wdetail.com_comm_date = STRING(sicuw.uwm100.comdat)
                  wdetail.com_exp_date  = STRING(sicuw.uwm100.expdat)
                  wdetail.ntitle        = sicuw.uwm100.ntitle                                                          
                  wdetail.ICNO          = sicuw.uwm100.anam2                                                           
                  wdetail.com_netprem   = STRING(sicuw.uwm100.prem_t)                                                  
                  wdetail.com_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)      
                  wdetail.com_stamp     = string(sicuw.uwm100.rstp_t)                                                  
                  wdetail.com_vat       = string(sicuw.uwm100.rtax_t)
                  wdetail.com_wht       = STRING((DECI(wdetail.com_netprem) + DECI(wdetail.com_stamp)) * 0.01 ) 
                  n_status               = sicuw.uwm100.releas
                  n_stcom                = STRING(n_status) + "/" + sicuw.uwm100.polsta .
             
                 IF wdetail.cust_type = "J" THEN DO:
                     IF INDEX(uwm100.name1,"®”°—¥") <> 0 THEN DO:
                         ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"®”°—¥") + 5 )
                                wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail.NAME2   = "".
                     END.
                     ELSE IF INDEX(uwm100.name1,"¡À“™π") <> 0 THEN
                         ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"®”°—¥") + 5 )
                                wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                wdetail.NAME2   = "".
                 END.
                 ELSE DO:
                    IF INDEX(sicuw.uwm100.ntitle,"¡Ÿ≈π‘∏‘") = 0 THEN DO:
                        ASSIGN  wdetail.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail.insnam)
                                wdetail.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                    END.
                    ELSE DO:
                        ASSIGN wdetail.insnam = sicuw.uwm100.name1
                               wdetail.insnam = TRIM(wdetail.insnam) + TRIM(sicuw.uwm100.name2)
                               wdetail.NAME2  = "".
                    END.
                 END.
                 
                 FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                            sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                            sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                            sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                            sicuw.uwm301.riskno = 1                   AND 
                            sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
             
                     IF AVAIL sicuw.uwm301 THEN DO:
                       ASSIGN wdetail.License = sicuw.uwm301.vehreg
                              wdetail.engno   = sicuw.uwm301.eng_no  
                              wdetail.chasno  = sicuw.uwm301.cha_no.
                     END.
                     ELSE DO:
                       ASSIGN wdetail.License  = ""     wdetail.engno    = ""      wdetail.chasno   = "".
                     END.
                 RUN proc_chknote.
             END.
        END.
       END.
       RUN proc_matchchktil1.

       /*nv_row  =  nv_row + 1.

       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail.ins_ytyp             '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.bus_typ              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.TASreceived          '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.InsCompany           '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.Insurancerefno       '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.tpis_no              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.ntitle               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   TRIM(wdetail.insnam) FORMAT "X(100)"  '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   TRIM(wdetail.NAME2)  FORMAT "X(100)"  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail.cust_type            '"' SKIP.         /*®“°‰ø≈Ï */        
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail.nDirec               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail.ICNO                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail.address              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail.build                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail.mu                   '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail.soi                  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail.road                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail.tambon               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail.amper                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail.country              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail.post                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail.brand                '"' SKIP.         /*®“°‰ø≈Ï*/   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail.model                '"' SKIP.         /*®“°‰ø≈Ï*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail.class                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail.md_year              '"' SKIP.         /*®“°‰ø≈Ï*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail.Usage                '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail.coulor               '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail.cc                   '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail.regis_year           '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail.engno                '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail.chasno               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   wdetail.Acc_CV  FORMAT "x(155)"   '"' SKIP.                                              /*®“°‰ø≈Ï*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   IF wdetail.Acc_amount = "" THEN "" ELSE STRING(DECI(wdetail.Acc_amount)) '"' SKIP. /*®“°‰ø≈Ï*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail.License  FORMAT "x(20)"     '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail.regis_CL             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail.campaign             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail.typ_work             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   DECI(wdetail.si) FORMAT ">>,>>>,>>9.99"               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   DATE(wdetail.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   DATE(wdetail.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   wdetail.LAST_pol             '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   wdetail.cover                '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   DECI(wdetail.pol_netprem)    '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   DECI(wdetail.pol_gprem)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   DECI(wdetail.pol_stamp)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   DECI(wdetail.pol_vat)        '"' SKIP.           
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   DECI(wdetail.pol_wht)        '"' SKIP.          /*®“°‰ø≈Ï */
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   wdetail.com_no               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   DATE(wdetail.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   DATE(wdetail.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   DECI(wdetail.com_netprem)    '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   DECI(wdetail.com_gprem)      '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   DECI(wdetail.com_stamp)      '"' SKIP.     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   DECI(wdetail.com_vat)        '"' SKIP.          /*®“°‰ø≈Ï*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   DECI(wdetail.com_wht)        '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   wdetail.deler                '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   wdetail.showroom             '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   wdetail.typepay              '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   wdetail.financename          '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   wdetail.mail_hno             '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   wdetail.mail_build           '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   wdetail.mail_mu              '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   wdetail.mail_soi             '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   wdetail.mail_road            '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   wdetail.mail_tambon          '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   wdetail.mail_amper           '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   wdetail.mail_country         '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   wdetail.mail_post            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   date(wdetail.send_date) FORMAT "99/99/9999" '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   wdetail.policy_no            '"' SKIP.                                                                               
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   DATE(wdetail.send_data) FORMAT "99/99/9999" '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   wdetail.REMARK1              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   wdetail.occup                '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   wdetail.regis_no             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'   n_stpol                       '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'   n_stcom                       '"' SKIP.*/



       FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
                 brstat.tlt.cha_no       = trim(wdetail.chasno)  AND
                 brstat.tlt.eng_no       = TRIM(wdetail.engno)   AND 
                 brstat.tlt.nor_noti_tlt = TRIM(wdetail.tpis_no) AND 
                 brstat.tlt.genusr       = "TPIS" NO-ERROR NO-WAIT.
       IF AVAIL brstat.tlt THEN DO:
         ASSIGN brstat.tlt.datesent  = date(wdetail.send_date) 
                brstat.tlt.ndate1    = date(wdetail.send_data)
                brstat.tlt.note16    = wdetail.regis_no .
                /*brstat.tlt.comp_pol  = wdetail.com_no
                brstat.tlt.policy    = wdetail.policy_no.
         IF index(brstat.tlt.releas,"YES") = 0  THEN ASSIGN brstat.tlt.releas = trim(REPLACE(brstat.tlt.releas,"NO","YES")).*/
       END.
   END.
   RELEASE sicuw.uwm100.
   RELEASE sicuw.uwm130.
   RELEASE sicuw.uwm301.
   RELEASE wdetail.
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchchktil1 c-wins 
PROCEDURE proc_matchchktil1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

       nv_row  =  nv_row + 1.

       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail.ins_ytyp             '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.bus_typ              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.TASreceived          '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.InsCompany           '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.Insurancerefno       '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.tpis_no              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.ntitle               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   TRIM(wdetail.insnam) FORMAT "X(100)"  '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   TRIM(wdetail.NAME2)  FORMAT "X(100)"  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail.cust_type            '"' SKIP.         /*®“°‰ø≈Ï */        
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail.nDirec               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail.ICNO                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail.address              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail.build                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail.mu                   '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail.soi                  '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail.road                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail.tambon               '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail.amper                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail.country              '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail.post                 '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail.brand                '"' SKIP.         /*®“°‰ø≈Ï*/   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail.model                '"' SKIP.         /*®“°‰ø≈Ï*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail.class                '"' SKIP.         
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail.md_year              '"' SKIP.         /*®“°‰ø≈Ï*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail.Usage                '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail.coulor               '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail.cc                   '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail.regis_year           '"' SKIP.         /*®“°‰ø≈Ï*/
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail.engno                '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail.chasno               '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   wdetail.Acc_CV  FORMAT "x(155)"   '"' SKIP.                                              /*®“°‰ø≈Ï*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   IF wdetail.Acc_amount = "" THEN "" ELSE STRING(DECI(wdetail.Acc_amount)) '"' SKIP. /*®“°‰ø≈Ï*/ 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail.License  FORMAT "x(20)"     '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail.regis_CL             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail.campaign             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail.typ_work             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   DECI(wdetail.si) FORMAT ">>,>>>,>>9.99"               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   DATE(wdetail.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   DATE(wdetail.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   wdetail.LAST_pol             '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   wdetail.cover                '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   DECI(wdetail.pol_netprem)    '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   DECI(wdetail.pol_gprem)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   DECI(wdetail.pol_stamp)      '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   DECI(wdetail.pol_vat)        '"' SKIP.           
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   DECI(wdetail.pol_wht)        '"' SKIP.          /*®“°‰ø≈Ï */
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   wdetail.com_no               '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   DATE(wdetail.com_comm_date) FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   DATE(wdetail.com_exp_date)  FORMAT "99/99/9999"   '"' SKIP.   
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   DECI(wdetail.com_netprem)    '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   DECI(wdetail.com_gprem)      '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   DECI(wdetail.com_stamp)      '"' SKIP.     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   DECI(wdetail.com_vat)        '"' SKIP.          /*®“°‰ø≈Ï*/     
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   DECI(wdetail.com_wht)        '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   wdetail.deler                '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   wdetail.showroom             '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   wdetail.typepay              '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   wdetail.financename          '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   wdetail.mail_hno             '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   wdetail.mail_build           '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   wdetail.mail_mu              '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   wdetail.mail_soi             '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   wdetail.mail_road            '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   wdetail.mail_tambon          '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   wdetail.mail_amper           '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   wdetail.mail_country         '"' SKIP.          /*®“°‰ø≈Ï*/  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   wdetail.mail_post            '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   date(wdetail.send_date) FORMAT "99/99/9999" '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   wdetail.policy_no            '"' SKIP.                                                                               
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   DATE(wdetail.send_data) FORMAT "99/99/9999" '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   wdetail.REMARK1              '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   wdetail.occup                '"' SKIP.  
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   wdetail.regis_no             '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'   n_stpol                       '"' SKIP.
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'   n_stcom                       '"' SKIP. 
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"     '"' wdetail.Driver1_title         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K"     '"' wdetail.Driver1_name          '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X79;K"     '"' wdetail.Driver1_lastname      '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X80;K"     '"' wdetail.Driver1_birthdate     '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X81;K"     '"' wdetail.Driver1_id_no         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X82;K"     '"' wdetail.Driver1_license_no    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X83;K"     '"' wdetail.Driver1_occupation    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X84;K"     '"' wdetail.Driver2_title         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X85;K"     '"' wdetail.Driver2_name          '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X86;K"     '"' wdetail.Driver2_lastname      '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X87;K"     '"' wdetail.Driver2_birthdate     '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X88;K"     '"' wdetail.Driver2_id_no         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X89;K"     '"' wdetail.Driver2_license_no    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X90;K"     '"' wdetail.Driver2_occupation    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X91;K"     '"' wdetail.Driver3_title         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X92;K"     '"' wdetail.Driver3_name          '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X93;K"     '"' wdetail.Driver3_lastname      '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X94;K"     '"' wdetail.Driver3_birthdate     '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X95;K"     '"' wdetail.Driver3_id_no         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X96;K"     '"' wdetail.Driver3_license_no    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X97;K"     '"' wdetail.Driver3_occupation    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X98;K"     '"' wdetail.Driver4_title         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X99;K"     '"' wdetail.Driver4_name          '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X100;K"    '"' wdetail.Driver4_lastname      '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X101;K"    '"' wdetail.Driver4_birthdate     '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X102;K"    '"' wdetail.Driver4_id_no         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X103;K"    '"' wdetail.Driver4_license_no    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X104;K"    '"' wdetail.Driver4_occupation    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X105;K"    '"' wdetail.Driver5_title         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X106;K"    '"' wdetail.Driver5_name          '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X107;K"    '"' wdetail.Driver5_lastname      '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X108;K"    '"' wdetail.Driver5_birthdate     '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X109;K"    '"' wdetail.Driver5_id_no         '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X110;K"    '"' wdetail.Driver5_license_no    '"' SKIP.    
       PUT STREAM ns2 "C;Y" STRING(nv_row) ";X111;K"    '"' wdetail.Driver5_occupation    '"' SKIP.    
                                                                                           

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchchktil_re c-wins 
PROCEDURE proc_matchchktil_re :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_status AS LOGICAL.
DEF VAR n_statuspol  AS CHAR.
DEF VAR n_statuscomp  AS CHAR.
DEF VAR nf_expdat70 AS CHAR FORMAT "x(15)".
DEF VAR nf_expdat72 AS CHAR FORMAT "x(15)".
DEF VAR nv_expdat70 AS CHAR FORMAT "x(15)".
DEF VAR nv_expdat72 AS CHAR FORMAT "x(15)".
DEF VAR n_length  AS INT.
for each wdetail.
   IF wdetail.ins_ytyp = "" THEN DELETE wdetail.
   ELSE DO:                                                                                
       ASSIGN n_statuspol       = ""         nf_expdat70   = ""      n_statuscomp         = ""         nf_expdat72   = ""    
              n_length          = 0          nv_expdat70   = ""                         
              wdetail.policy    = ""         nv_expdat72   = ""                         
              wdetail.com_no    = ""         nf_expdat70   = trim(wdetail.pol_exp_date)  
              wdetail.prvpol    = ""         nf_expdat72   = trim(wdetail.com_exp_date)  
              wdetail.pol_comm_date = ""     wdetail.pol_exp_date  = ""
              wdetail.com_comm_date = ""     wdetail.com_exp_date  = ""
              wdetail.si        = ""         wdetail.License   = ""    
              wdetail.engno     = ""         wdetail.chasno    = "" . 
       FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail.tpis_no) NO-LOCK.
            ASSIGN nv_expdat70 = STRING(DAY(sicuw.uwm100.expdat),"99") + "/" + STRING(MONTH(sicuw.uwm100.expdat),"99") + "/" + STRING(YEAR(sicuw.uwm100.expdat),"9999") .  
            IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
            ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.       
            ELSE IF DATE(nv_expdat70) <> DATE(nf_expdat70)  THEN NEXT.       
            ELSE DO:
                  ASSIGN 
                     wdetail.policy        = sicuw.uwm100.policy 
                     wdetail.prvpol        = sicuw.uwm100.prvpol 
                     wdetail.pol_comm_date = STRING(sicuw.uwm100.comdat) 
                     wdetail.pol_exp_date  = STRING(sicuw.uwm100.expdat)
                     wdetail.ntitle        = sicuw.uwm100.ntitle                                                 
                     wdetail.ICNO          = sicuw.uwm100.anam2
                     wdetail.pol_netprem   = STRING(sicuw.uwm100.prem_t)
                     wdetail.pol_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)
                     wdetail.pol_stamp     = string(sicuw.uwm100.rstp_t)    
                     wdetail.pol_vat       = string(sicuw.uwm100.rtax_t)
                     wdetail.pol_wht       = STRING((DECI(wdetail.pol_netprem) + DECI(wdetail.pol_stamp)) * 0.01 )
                     n_status              = sicuw.uwm100.releas
                     n_statuspol           = STRING(n_status) + "\" + sicuw.uwm100.polsta.
                  IF wdetail.cust_type = "J" THEN DO:
                    IF INDEX(uwm100.name1,"®”°—¥") <> 0 THEN DO:
                        ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"®”°—¥") + 5 )
                               wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                               wdetail.NAME2   = "".
                    END.
                    ELSE IF INDEX(uwm100.name1,"¡À“™π") <> 0 THEN
                        ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"¡À“™π") + 5 )
                               wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                               wdetail.NAME2   = "".
                  END.
                  ELSE DO:
                      IF INDEX(sicuw.uwm100.ntitle,"¡Ÿ≈π‘∏‘") = 0 THEN DO:
                          ASSIGN  wdetail.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                  n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail.insnam)
                                  wdetail.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                      END.
                      ELSE DO:
                          ASSIGN wdetail.insnam = sicuw.uwm100.name1
                                 wdetail.insnam = TRIM(wdetail.insnam) + TRIM(sicuw.uwm100.name2)
                                 wdetail.NAME2  = "".
                      END.
                  END.
                  /*-- À“∑–‡∫’¬π --*/
                  FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
                      sicuw.uwm301.policy = sicuw.uwm100.policy AND 
                      sicuw.uwm301.rencnt = sicuw.uwm100.rencnt AND
                      sicuw.uwm301.endcnt = sicuw.uwm100.endcnt AND 
                      sicuw.uwm301.riskno = 1                   AND
                      sicuw.uwm301.itemno = 1                   NO-LOCK NO-ERROR.
                     IF AVAIL sicuw.uwm301 THEN DO:
                        ASSIGN wdetail.License     = sicuw.uwm301.vehreg
                               wdetail.engno       = sicuw.uwm301.eng_no
                               wdetail.chasno      = sicuw.uwm301.cha_no
                               wdetail.License     = SUBSTR(wdetail.License,1,R-INDEX(wdetail.license," ")).
                              /*-- À“∑ÿπ --*/
                              FIND FIRST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                                   sicuw.uwm130.policy = sicuw.uwm100.policy  AND 
                                   sicuw.uwm130.rencnt = sicuw.uwm100.rencnt AND
                                   sicuw.uwm130.endcnt = sicuw.uwm100.endcnt AND 
                                   sicuw.uwm130.riskno = 1                   AND
                                   sicuw.uwm130.itemno = 1                   NO-LOCK NO-ERROR.
                                  IF AVAIL sicuw.uwm130 THEN 
                                      ASSIGN wdetail.si   = IF sicuw.uwm301.covcod = "1" THEN STRING(sicuw.uwm130.uom6_v) 
                                                            ELSE STRING(sicuw.uwm130.uom7_v).
                                  ELSE  ASSIGN wdetail.si = "".
                      END.
                      ELSE DO:
                          ASSIGN wdetail.si     = ""    wdetail.License   = ""
                                 wdetail.engno  = ""    wdetail.chasno    = "".
                      END.
                RUN proc_chkNote.
            END.
       END.
       IF wdetail.com_no = "" AND INDEX(wdetail.typ_work,"C") <> 0  THEN DO:
           FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol =  trim(wdetail.tpis_no) NO-LOCK.
             ASSIGN nv_expdat72 = STRING(DAY(sicuw.uwm100.expdat),"99") + "/" + STRING(MONTH(sicuw.uwm100.expdat),"99") + "/" + STRING(YEAR(sicuw.uwm100.expdat),"9999") . 
             IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
             ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY) THEN NEXT.     
             ELSE IF DATE(nv_expdat72) <> DATE(nf_expdat72)  THEN NEXT.     
             ELSE DO:
                    ASSIGN wdetail.com_no = sicuw.uwm100.policy 
                         wdetail.com_comm_date = STRING(sicuw.uwm100.comdat)
                         wdetail.com_exp_date  = STRING(sicuw.uwm100.expdat)
                         wdetail.ntitle        = sicuw.uwm100.ntitle                                                          
                         wdetail.ICNO          = sicuw.uwm100.anam2                                                           
                         wdetail.com_netprem   = STRING(sicuw.uwm100.prem_t)                                                  
                         wdetail.com_gprem     = string(sicuw.uwm100.prem_t + sicuw.uwm100.rstp_t + sicuw.uwm100.rtax_t)      
                         wdetail.com_stamp     = string(sicuw.uwm100.rstp_t)                                                  
                         wdetail.com_vat       = string(sicuw.uwm100.rtax_t)
                         wdetail.com_wht       = STRING((DECI(wdetail.com_netprem) + DECI(wdetail.com_stamp)) * 0.01 ) 
                         n_status              = sicuw.uwm100.releas
                         n_statuscomp          = string(n_status) + "\" + sicuw.uwm100.polsta .
                     IF wdetail.cust_type = "J" THEN DO:
                         IF INDEX(uwm100.name1,"®”°—¥") <> 0 THEN DO:
                             ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"®”°—¥") + 5 )
                                    wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                    wdetail.NAME2   = "".
                         END.
                         ELSE IF INDEX(uwm100.name1,"¡À“™π") <> 0 THEN
                             ASSIGN wdetail.insnam  = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1,"®”°—¥") + 5 )
                                    wdetail.nDire   = SUBSTR(uwm100.name1,(INDEX(uwm100.name1,"(")),INDEX(uwm100.name1,")"))
                                    wdetail.NAME2   = "".
                     END.
                     ELSE DO:
                       IF INDEX(sicuw.uwm100.ntitle,"¡Ÿ≈π‘∏‘") = 0 THEN DO:
                           ASSIGN  wdetail.insnam = SUBSTR(uwm100.name1,1,INDEX(uwm100.name1," ")) 
                                   n_length        = LENGTH(uwm100.NAME1) - LENGTH(wdetail.insnam)
                                   wdetail.NAME2  = SUBSTR(uwm100.name1,INDEX(uwm100.name1," "),n_length + 1).
                       END.
                       ELSE DO:
                           ASSIGN wdetail.insnam = sicuw.uwm100.name1
                                  wdetail.insnam = TRIM(wdetail.insnam) + TRIM(sicuw.uwm100.name2)
                                  wdetail.NAME2  = "".
                       END.
                    END.
                    FIND FIRST sicuw.uwm301 USE-INDEX uwm30101      WHERE 
                      sicuw.uwm301.policy   = sicuw.uwm100.policy AND 
                      sicuw.uwm301.rencnt   = sicuw.uwm100.rencnt AND
                      sicuw.uwm301.endcnt   = sicuw.uwm100.endcnt AND 
                      sicuw.uwm301.riskno   = 1                   AND 
                      sicuw.uwm301.itemno   = 1                   NO-LOCK NO-ERROR.
                      IF AVAIL sicuw.uwm301 THEN DO:
                          ASSIGN wdetail.License = sicuw.uwm301.vehreg
                                 wdetail.engno   = sicuw.uwm301.eng_no  
                                 wdetail.chasno  = sicuw.uwm301.cha_no 
                                 wdetail.License = SUBSTR(wdetail.License,1,R-INDEX(wdetail.License," ")).
                      END.
                      ELSE DO:
                          ASSIGN wdetail.License  = ""      wdetail.engno    = ""       wdetail.chasno   = "".
                      END.
                    RUN proc_chkNote. 
                 END.
            END.
       END.
     ASSIGN nv_row  =  nv_row  + 1 .
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail.ins_ytyp         '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.bus_typ          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.TASreceived      '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.InsCompany       '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.Insurancerefno   '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.tpis_no          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.ntitle           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.insnam           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.NAME2            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'   wdetail.cust_type        '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'   wdetail.nDirec           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'   wdetail.ICNO             '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'   wdetail.address          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'   wdetail.build            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'   wdetail.mu               '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'   wdetail.soi              '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'   wdetail.road             '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'   wdetail.tambon           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'   wdetail.amper            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'   wdetail.country          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'   wdetail.post             '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'   wdetail.brand            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'   wdetail.model            '"' SKIP.            
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'   wdetail.class            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'   wdetail.md_year          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'   wdetail.Usage FORMAT "x(50)"  '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'   wdetail.coulor           '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'   wdetail.cc               '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'   wdetail.regis_year       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'   wdetail.engno            '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'   wdetail.chasno           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'   wdetail.Acc_CV           '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'   wdetail.Acc_amount       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'   wdetail.License          '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'   wdetail.regis_CL         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'   wdetail.campaign         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'   wdetail.typ_work         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'   wdetail.garage           '"' SKIP.    /*A62-0422*/
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'   wdetail.desmodel         '"' SKIP.    /*A62-0422*/
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'   deci(wdetail.si) FORMAT ">>,>>>,>>9.99"      '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'   DATE(wdetail.pol_comm_date)  FORMAT "99/99/9999"      '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'   DATE(wdetail.pol_exp_date)   FORMAT "99/99/9999"      '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'   wdetail.prvpol           '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'   wdetail.cover            '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'   deci(wdetail.pol_netprem)'"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'   deci(wdetail.pol_gprem)  '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'   deci(wdetail.pol_stamp)  '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'   deci(wdetail.pol_vat)    '"' SKIP.           
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'   deci(wdetail.pol_wht)    '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'   wdetail.com_no           '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'   DATE(wdetail.com_comm_date) FORMAT "99/99/9999" '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'   DATE(wdetail.com_exp_date)  FORMAT "99/99/9999" '"' SKIP.   
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'   deci(wdetail.com_netprem)'"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'   deci(wdetail.com_gprem)  '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'   deci(wdetail.com_stamp)  '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'   deci(wdetail.com_vat)    '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'   deci(wdetail.com_wht)    '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K" '"'   wdetail.deler            '"' SKIP.     
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K" '"'   wdetail.showroom         '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K" '"'   wdetail.typepay          '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K" '"'   wdetail.financename      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K" '"'   wdetail.mail_hno         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K" '"'   wdetail.mail_build       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K" '"'   wdetail.mail_mu          '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K" '"'   wdetail.mail_soi         '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K" '"'   wdetail.mail_road        '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K" '"'   wdetail.mail_tambon      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K" '"'   wdetail.mail_amper       '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K" '"'   wdetail.mail_country     '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K" '"'   wdetail.mail_post        '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K" '"'   date(wdetail.send_date) FORMAT "99/99/9999"     '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K" '"'   wdetail.policy           '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K" '"'   date(wdetail.send_data) FORMAT "99/99/9999"     '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K" '"'   wdetail.REMARK1          '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K" '"'   wdetail.occup            '"' SKIP.  
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K" '"'   wdetail.regis_no         '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K" '"'   n_statuspol               '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X78;K" '"'   n_statuscomp              '"' SKIP.
        RUN proc_update_ems.
    END.
    RELEASE wdetail.
END.
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_update_ems c-wins 
PROCEDURE proc_update_ems :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
     FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
                 brstat.tlt.cha_no       = trim(wdetail.chasno)  AND
                 brstat.tlt.eng_no       = TRIM(wdetail.engno)   AND 
                 brstat.tlt.nor_noti_tlt = TRIM(wdetail.tpis_no) AND 
                 brstat.tlt.genusr       = "TPIS" NO-ERROR NO-WAIT.
       IF AVAIL brstat.tlt THEN DO:
         ASSIGN brstat.tlt.datesent  = date(wdetail.send_date) 
                brstat.tlt.ndate1    = date(wdetail.send_data)
                brstat.tlt.note16    = wdetail.regis_no .
               /* brstat.tlt.comp_pol  = IF brstat.tlt.comp_pol = ""  THEN wdetail.com_no    ELSE brstat.tlt.comp_pol
                brstat.tlt.policy    = IF brstat.tlt.policy   = ""  THEN wdetail.policy_no ELSE brstat.tlt.policy .
         IF index(brstat.tlt.releas,"YES") = 0  THEN ASSIGN brstat.tlt.releas = trim(REPLACE(brstat.tlt.releas,"NO","YES")).*/
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
    For each tlt Use-index  tlt01 Where
        tlt.trndat  >=  fi_trndatfr  And
        tlt.trndat  <=  fi_trndatto  And
        tlt.genusr   =  "Tisco"      no-lock.
        ASSIGN
            nv_rectlt =  recid(tlt).  
                             

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_openQuery2 c-wins 
PROCEDURE Pro_openQuery2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Open Query br_tlt 
    FOR EACH tlt Where Recid(tlt)  =  nv_rectlt NO-LOCK .
        ASSIGN nv_rectlt =  recid(tlt).   
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

