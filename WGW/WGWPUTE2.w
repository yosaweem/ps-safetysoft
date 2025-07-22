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

CREATE WIDGET-POOL.

/* ***************************  Definitions  **************************     */
                                                                            
/* Parameters Definitions ---                                               */
/* Local Variable Definitions ---                                           */
/*Program name : Import Text file Tisco to excel file                       */
/*create by    : Kridtiya i. A53-0207                                       */
/*               แปลงเทคเป็นไฟล์excel                                       */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*modify by    : Kridtiya i. A54-0216 ปรับการค้นหาข้อมูล จาก find first 
                 เป็น find Last และ ทริมข้อมูลก่อนให้ค่าตัวแปร*/
/*Proc Definition */
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE NEW SHARED WORKFILE  wdetail
    FIELD pol70           AS CHAR FORMAT "x(12)"  INIT ""
    FIELD recordID        AS CHAR FORMAT "x(2)"   INIT ""
    FIELD app_code        AS CHAR FORMAT "x(2)"   INIT ""
    FIELD Account_no      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD client_no       AS CHAR FORMAT "x(7)"   INIT ""
    FIELD preaccno        AS CHAR FORMAT "x(10)"  INIT ""
    FIELD notino          AS CHAR FORMAT "x(25)"  INIT ""
    FIELD NOTIFIED_DATE   AS CHAR FORMAT "x(10)"  INIT ""
    FIELD stk             AS CHAR FORMAT "x(25)"  INIT ""  
    FIELD policyno        AS CHAR FORMAT "x(25)"  INIT ""  
    /*FIELD chasno          AS CHAR FORMAT "x(25)"  INIT ""   /*A65-0356*/*/
    FIELD chasno          AS CHAR FORMAT "x(35)"  INIT ""     /*A65-0356*/
   /*FIELD vehreg          AS CHAR FORMAT "x(10)" INIT "" *//*A65-0356*/
    FIELD vehreg          AS CHAR FORMAT "x(30)" INIT ""    /*A65-0356*/
    FIELD re_country      AS CHAR FORMAT "x(20)" INIT ""  
    FIELD not_office      AS CHAR FORMAT "x(2)"  INIT ""
    FIELD name_insur      AS CHAR FORMAT "x(50)"  INIT ""
    FIELD tiname          AS CHAR FORMAT "x(30)" INIT ""     
    FIELD insnam          AS CHAR FORMAT "x(75)" INIT ""     
    FIELD name2           AS CHAR FORMAT "x(45)" INIT ""     
    FIELD idno            AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD comdat          AS CHAR FORMAT "x(10)" INIT ""
    FIELD expdat          AS CHAR FORMAT "x(10)" INIT ""  
    FIELD dup_pol         AS CHAR FORMAT "x(10)" INIT ""    
    FIELD ori_pol         AS CHAR FORMAT "X(10)" INIT ""    
    FIELD PREM_REC        AS CHAR FORMAT "X(10)" INIT "" 
    FIELD REC_DATE        AS CHAR FORMAT "X(10)" INIT "" 
    FIELD RECP_NAME       AS CHAR FORMAT "X(150)" INIT "" 
    FIELD RECP_ADD1       AS CHAR FORMAT "X(60)" INIT "" 
    FIELD RECP_ADD2       AS CHAR FORMAT "X(60)" INIT "" 
    FIELD mail_add1       AS CHAR FORMAT "X(50)" INIT ""    
    FIELD mail_add2       AS CHAR FORMAT "X(60)" INIT "" 
    FIELD tambon          AS CHAR FORMAT "x(35)" INIT ""     
    FIELD amper           AS CHAR FORMAT "x(35)" INIT ""     
    FIELD country         AS CHAR FORMAT "x(35)" INIT ""     
    FIELD post            AS CHAR FORMAT "x(5)"  INIT "" 
    FIELD CHQ_ADDR           AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD APP_TYPE           AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD RECP_MAIL1         AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD RECP_MAIL2         AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD NOTIFIED_EFF_DATE  AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD NOTIFIED_EXP_DATE  AS CHAR FORMAT "x(8)"   INIT "" 
    FIELD Pro_off         AS CHAR FORMAT "x(10)" INIT ""
    FIELD cmr_code        AS CHAR FORMAT "x(3)"  INIT ""
    FIELD comcode         AS CHAR FORMAT "x(3)"  INIT ""  
    FIELD caryear         AS CHAR FORMAT "x(4)"  INIT "" 
    /*FIELD eng             AS CHAR FORMAT "x(25)" INIT "" *//*A65-0356*/ 
    FIELD eng             AS CHAR FORMAT "x(35)" INIT ""     /*A65-0356*/ 
    FIELD engcc           AS CHAR FORMAT "x(5)"  INIT ""   
    FIELD power           AS CHAR FORMAT "x(7)"  INIT ""
    /*FIELD colorcode       AS CHAR FORMAT "x(15)" INIT ""*//*A65-0356*/
    FIELD colorcode       AS CHAR FORMAT "x(30)" INIT ""    /*A65-0356*/
    FIELD garage          AS CHAR FORMAT "x(1)"  INIT "" 
    FIELD fleetper        AS CHAR FORMAT "X(5)"  INIT "" 
    FIELD ncb             AS CHAR FORMAT "X(5)"  INIT "" 
    FIELD orthper         AS CHAR FORMAT "X(5)"  INIT ""  
    FIELD vehuse          AS CHAR FORMAT "x(1)"  INIT ""  
    FIELD si              AS CHAR FORMAT "x(13)" INIT ""                    
    FIELD entdat          AS CHAR FORMAT "x(10)" INIT ""                    
    FIELD enttim          AS CHAR FORMAT "x(8)"  INIT ""                    
    FIELD not_code        AS CHAR FORMAT "x(4)"  INIT ""                    
    FIELD premt           AS CHAR FORMAT "x(11)" INIT ""                    
    FIELD comp_prm        AS CHAR FORMAT "x(9)"  INIT ""                    
    FIELD brand           AS CHAR FORMAT "x(50)" INIT ""                    
    /*FIELD addr1           AS CHAR FORMAT "x(50)" INIT ""                  
    FIELD addr2           AS CHAR FORMAT "x(60)" INIT "" */                 
    FIELD benname         AS CHAR FORMAT "x(65)" INIT ""                    
    FIELD remark          AS CHAR FORMAT "x(150)" INIT ""                   
    FIELD gap             AS CHAR FORMAT "X(11)" INIT ""                    
    /*FIELD receipt_name    AS CHAR FORMAT "x(50)" INIT ""*/                
    FIELD agent      AS CHAR FORMAT "x(15)" INIT ""                    
    FIELD prev_insur AS CHAR FORMAT "x(50)" INIT ""                    
    FIELD prepol     AS CHAR FORMAT "x(25)" INIT ""                    
    FIELD drivnam1   AS CHAR FORMAT "x(75)" INIT ""                    
    FIELD driag1     AS CHAR FORMAT "x(10)" INIT ""
    FIELD driocc1    AS CHAR FORMAT "x(50)" INIT "" /* A67-0087*/
    field dripos1    as char format "x(50)"  init ""
    FIELD drivnam2   AS CHAR FORMAT "x(75)" INIT ""                    
    FIELD driag2     AS CHAR FORMAT "x(10)" INIT "" 
    FIELD driocc2    AS CHAR FORMAT "x(50)" INIT "" /* A67-0087*/
    field dripos2   AS char format "x(50)"  init ""
    FIELD deduct    AS CHAR FORMAT "X(9)"  INIT "" 
    FIELD cndat     AS CHAR FORMAT "x(10)" INIT ""     
    FIELD covcod    AS CHAR FORMAT "x(1)"  INIT "" 
    FIELD branch    AS CHAR FORMAT "x(2)"  INIT ""
    FIELD tp1       AS CHAR FORMAT "X(14)" INIT "" 
    FIELD tp2       AS CHAR FORMAT "X(14)" INIT "" 
    FIELD tp3       AS CHAR FORMAT "X(14)" INIT "" 
    FIELD prempa    AS CHAR FORMAT "x(4)"  INIT ""  
    /*FIELD seatenew       AS CHAR FORMAT "x(4)"  INIT ""  */
    FIELD delerbr      AS CHAR FORMAT "x(10)" INIT "" 
    FIELD npoltyp      AS CHAR FORMAT "x(30)"  INIT ""
    FIELD pol72        AS CHAR FORMAT "x(12)"  INIT ""
    FIELD  Reciept72   AS CHAR FORMAT  "X(60)" INIT ""
    /* add by : A64-0271 */
    FIELD addr1_70     AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD addr2_70     AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD nsub_dist70  AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD ndirection70 AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD nprovin70    AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD zipcode70    AS CHAR FORMAT "X(5)"   INIT ""   
    FIELD addr1_72     AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD addr2_72     AS CHAR FORMAT "X(100)"  INIT ""  
    FIELD nsub_dist72  AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD ndirection72 AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD nprovin72    AS CHAR FORMAT "X(30)"  INIT ""   
    FIELD zipcode72    AS CHAR FORMAT "X(5)"   INIT "" 
    FIELD policy2y70   AS CHAR FORMAT "X(20)"   INIT ""  
    FIELD policy2y72   AS CHAR FORMAT "X(20)"   INIT "" 
/* A67-0087 */
    field nblank     as char format "x(150)" init "" 
    field caracc     as char format "x(150)" init "" 
    field Rec_name72 as char format "x(100)" init "" 
    field Rec_add1   as char format "x(150)" init "" 
    field Rec_add2   as char format "x(150)" init "" 
    field insbdate   as char format "x(20)" init "" 
    FIELD comment   AS CHAR FORMAT "x(150)" INIT "" 
    FIELD Schanel   AS Char FORMAT "X(1)"   init "" 
    FIELD bev       AS Char FORMAT "X(1)"   init ""
    FIELD drivnam3  AS CHAR FORMAT "x(75)" INIT ""                
    FIELD driag3    AS CHAR FORMAT "x(10)" INIT ""                
    FIELD driocc3   AS CHAR FORMAT "x(50)" INIT "" /* A67-0087*/
    field dripos3   as char format "x(50)"  init "" /*A67-0114*/
    FIELD drino4    AS Char FORMAT "X(75)"  init ""   
    FIELD drivnam4  AS Char FORMAT "X(100)" init "" 
    FIELD driag4    AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD driocc4   AS Char FORMAT "X(75)"  init "" 
    field dripos4   as char format "x(50)"  init ""
    field drino5    as char format "x(2)"   init ""
    FIELD drivnam5  AS Char FORMAT "X(100)" init "" 
    FIELD driag5    AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD driocc5   AS Char FORMAT "X(75)"  init ""
    FIELD dripos5   AS CHAR FORMAT "x(50)"  init "" 
    FIELD campagin  AS Char FORMAT "X(20)"  init "" 
    FIELD inspic    AS Char FORMAT "X(1)"   init "" 
    FIELD engcount  AS Char FORMAT "X(2)"   init "" 
    FIELD engno2    AS Char FORMAT "X(35)"  init "" 
    FIELD engno3    AS Char FORMAT "X(35)"  init "" 
    FIELD engno4    AS Char FORMAT "X(35)"  init "" 
    FIELD engno5    AS Char FORMAT "X(35)"  init "" 
    FIELD classcomp AS Char FORMAT "X(5)"   init ""  
    FIELD carbrand  AS CHAR FORMAT "X(50)"  INIT "" .
   /* end : A67-0087 */ 
DEF VAR  ID_NO1           AS CHAR FORMAT "x(15)"  INIT "" /*A57-0262*/ .        
DEF VAR  CLIENT_BRANCH    AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ .      
DEF VAR  CLIENT_Birthdate AS CHAR FORMAT "x(30)"  INIT "" /*A65-0356*/ .   
DEFINE WORKFILE wdetail3 NO-UNDO                                             
    FIELD policyid          AS CHAR FORMAT "x(30)" INIT ""                       
    FIELD poltyp            AS CHAR FORMAT "x(3)" INIT ""
    FIELD ID_NO1            AS CHAR FORMAT "x(15)"  INIT "" /*A57-0262*/  
    FIELD CLIENT_RANCH      AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ 
    FIELD RECEIPT_72        AS CHAR FORMAT "X(50)"  INIT ""
    FIELD comppdat          AS CHAR FORMAT "X(10)"  INIT ""
    FIELD exppdat           AS CHAR FORMAT "X(10)"  INIT ""
    FIELD com_prem          AS CHAR FORMAT "X(20)"  INIT ""
    FIELD CLIENT_Birthdate  AS CHAR FORMAT "x(20)"  INIT "" .    /*A65-0356   วันเดือนปีเกิด YYYYMMDD */ 
DEFINE WORKFILE wdetail2 NO-UNDO
    FIELD nppolicy     AS CHAR FORMAT "x(30)" INIT ""
    FIELD tambon70     AS CHAR FORMAT "x(35)" INIT ""     
    FIELD amper70      AS CHAR FORMAT "x(35)" INIT ""     
    FIELD country70    AS CHAR FORMAT "x(35)" INIT ""     
    FIELD post70       AS CHAR FORMAT "x(5)"  INIT "" 
    FIELD nnproducer   AS CHAR FORMAT "x(30)" INIT ""
    FIELD nnagent      AS CHAR FORMAT "x(30)" INIT ""
    FIELD nnbranch     AS CHAR FORMAT "x(2)"  INIT ""
    FIELD nntyppol     AS CHAR FORMAT "x(20)" INIT ""
    FIELD npRedbook    AS CHAR FORMAT "x(10)" INIT ""          /*A57-0262*/
    FIELD npPrice_Ford AS CHAR FORMAT "x(20)" INIT ""          /*A57-0262*/
    FIELD npYear       AS CHAR FORMAT "x(10)" INIT ""          /*A57-0262*/
    FIELD npBrand_Mo   AS CHAR FORMAT "x(60)" INIT ""          /*A57-0262*/
    FIELD npid70       AS CHAR FORMAT "x(13)" INIT ""          /*A57-0262*/
    FIELD npid70br     AS CHAR FORMAT "x(20)" INIT ""          /*A57-0262*/
    FIELD npid72       AS CHAR FORMAT "x(13)" INIT ""          /*A57-0262*/
    FIELD npid72br     AS CHAR FORMAT "x(20)" INIT ""          /*A57-0262*/
    FIELD npComdat   AS CHAR FORMAT  "x(12)" INIT ""
    FIELD npExpdat   AS CHAR FORMAT  "x(12)" INIT ""
    FIELD np_fi      AS CHAR FORMAT  "x(20)" INIT ""
    FIELD npCode     AS CHAR FORMAT  "x(5)"  INIT ""
    FIELD npCaruse   AS CHAR FORMAT  "x(5)"  INIT ""
    FIELD npdrino1   AS CHAR FORMAT  "x(2)"  INIT ""
    FIELD npdrinam1  AS CHAR FORMAT  "x(50)" INIT ""
    FIELD npdridat1  AS CHAR FORMAT  "x(12)" INIT ""
    FIELD npdriocc1  AS CHAR FORMAT  "x(50)" INIT ""
    FIELD npdripos1  AS CHAR FORMAT  "x(40)" INIT ""
    FIELD npdrino2   AS CHAR FORMAT  "x(2)"  INIT ""
    FIELD npdrinam2  AS CHAR FORMAT  "x(50)" INIT ""
    FIELD npdridat2  AS CHAR FORMAT  "x(12)" INIT ""
    FIELD npdriocc2  AS CHAR FORMAT  "x(50)" INIT ""
    FIELD npdripos2  AS CHAR FORMAT  "x(40)" INIT ""
    FIELD npdrino3   AS CHAR FORMAT  "x(2)"  INIT ""
    FIELD npdrinam3  AS CHAR FORMAT  "x(50)" INIT ""
    FIELD npdridat3  AS CHAR FORMAT  "x(12)" INIT ""   
    FIELD npdriocc3  AS CHAR FORMAT  "x(50)" INIT ""   
    FIELD npdripos3  AS CHAR FORMAT  "x(40)" INIT "" 
    FIELD Reciept72  AS CHAR FORMAT  "X(60)" INIT ""
    FIELD np_add70       AS CHAR FORMAT  "x(100)" INIT ""
    FIELD np_add72       AS CHAR FORMAT  "x(100)" INIT ""
    FIELD np_remark      AS CHAR FORMAT  "x(300)" INIT ""
    FIELD np_Rec_name72  AS CHAR FORMAT  "x(100)" INIT ""
    FIELD np_Rec_add1    AS CHAR FORMAT  "x(100)" INIT "" .
   
DEF VAR tambon70      AS CHAR FORMAT "x(35)" INIT "".     
DEF VAR amper70       AS CHAR FORMAT "x(35)" INIT "" .    
DEF VAR country70     AS CHAR FORMAT "x(35)" INIT "".     
DEF VAR post70        AS CHAR FORMAT "x(5)"  INIT "" .
DEF VAR nnproducer   AS CHAR FORMAT "x(30)" INIT "" .
DEF VAR nnagent      AS CHAR FORMAT "x(30)" INIT "" .
DEF VAR nnbranch     AS CHAR FORMAT "x(2)" INIT "" .
DEF VAR nntyppol     AS CHAR FORMAT "x(20)" INIT "".
DEF VAR npRedbook    AS CHAR FORMAT "x(10)" INIT "".    /*A57-0262*/
DEF VAR npPrice_Ford AS CHAR FORMAT "x(20)" INIT "".    /*A57-0262*/
DEF VAR npYear       AS CHAR FORMAT "x(10)" INIT "".    /*A57-0262*/
DEF VAR npBrand_Mo   AS CHAR FORMAT "x(60)" INIT "".    /*A57-0262*/
DEF VAR npid70       AS CHAR FORMAT "x(13)" INIT "".    /*A57-0262*/
DEF VAR npid70br     AS CHAR FORMAT "x(20)" INIT "".    /*A57-0262*/
DEF VAR npid72       AS CHAR FORMAT "x(13)" INIT "".    /*A57-0262*/
DEF VAR npid72br     AS CHAR FORMAT "x(20)" INIT "".    /*A57-0262*/
/*-------------------พรบ----------------------------*/
DEF VAR npComdat       AS CHAR FORMAT "x(12)" INIT "". 
DEF VAR npExpdat       AS CHAR FORMAT "x(12)" INIT "". 
DEF VAR np_fi          AS CHAR FORMAT "x(20)" INIT "". 
DEF VAR npCode         AS CHAR FORMAT "x(5)" INIT "". 
DEF VAR npCaruse       AS CHAR FORMAT "x(5)" INIT "". 
DEF VAR npdrino1       AS CHAR FORMAT "x(2)"  INIT "". 
DEF VAR npdrinam1      AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR npdridat1      AS CHAR FORMAT "x(12)"  INIT "". 
DEF VAR npdriocc1      AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR npdripos1      AS CHAR FORMAT "x(40)"  INIT "". 
DEF VAR npdrino2       AS CHAR FORMAT "x(2)"  INIT "". 
DEF VAR npdrinam2      AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR npdridat2      AS CHAR FORMAT "x(12)"  INIT "". 
DEF VAR npdriocc2      AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR npdripos2      AS CHAR FORMAT "x(40)"  INIT "". 
DEF VAR npdrino3       AS CHAR FORMAT "x(2)"  INIT "". 
DEF VAR npdrinam3      AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR npdridat3      AS CHAR FORMAT "x(12)"  INIT "". 
DEF VAR npdriocc3      AS CHAR FORMAT "x(50)"  INIT "". 
DEF VAR npdripos3      AS CHAR FORMAT "x(40)"  INIT "". 
/*------------------------------ข้อมูลผู้ขับขี่ -------------------------*/
DEFINE WORKFILE  wdriver NO-UNDO
FIELD RecordID     AS CHAR FORMAT "X(02)"    INIT ""            /*1 Detail Record "D"*/
FIELD Pro_off      AS CHAR FORMAT "X(02)"    INIT ""            /*2 รหัสสาขาที่ผู้เอาประกันเปิดบัญชี    */
FIELD chassis      AS CHAR FORMAT "X(25)"    INIT ""            /*3 หมายเลขตัวถัง    */
FIELD dri_no       AS CHAR FORMAT "X(02)"    INIT ""            /*4 ลำดับที่คนขับ  */
FIELD dri_name     AS CHAR FORMAT "X(40)"    INIT ""            /*5 ชื่อคนขับ   */
FIELD Birthdate    AS CHAR FORMAT "X(8)"     INIT ""            /*6 วันเดือนปีเกิด  */
FIELD occupn       AS CHAR FORMAT "X(75)"    INIT ""            /*7 อาชีพ*/
FIELD position     AS CHAR FORMAT "X(40)"    INIT ""  .         /*8 ตำแหน่งงาน */
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   ind_f1   AS  INTE INIT   0.
DEF VAR nv_messag  AS CHAR  INIT  "".
DEFINE  WORKFILE wcomp NO-UNDO
/*1*/      FIELD package     AS CHARACTER FORMAT "X(10)"   INITIAL ""
/*2*/      FIELD premcomp    AS DECI FORMAT "->>,>>9.99"    INITIAL 0.
DEF VAR producer_mat AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR agent_mat    AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nnidbr72    AS CHAR FORMAT "x(20)"  INIT "". /*A57-0262*/
DEF VAR nnid72      AS CHAR FORMAT "x(13)"  INIT "". /*A57-0262*/
DEF VAR nnidbr70    AS CHAR FORMAT "x(20)"  INIT "". /*A57-0262*/
DEF VAR nnid70      AS CHAR FORMAT "x(13)"  INIT "". /*A57-0262*/
DEF VAR nv_chaidrep AS CHAR FORMAT "x(100)" INIT "". /*A57-0262*/
DEF VAR nnBirthdate AS CHAR FORMAT "x(20)"  INIT "".  
DEF VAR n_compdat   AS CHAR FORMAT "X(15)"  INIT "".
DEF VAR n_exppdat   AS CHAR FORMAT "X(15)"  INIT "".
DEF VAR n_fi        AS CHAR FORMAT "X(10)"  INIT "".
DEF VAR n_vehus     AS CHAR FORMAT "X(5)"  INIT "".
DEF VAR n_class     AS CHAR FORMAT "X(5)"  INIT "".
DEF VAR n_comprem   AS CHAR FORMAT "X(10)"    INIT "".
DEF VAR nv_72Reciept    AS CHAR FORMAT "X(50)" INIT "".
DEF VAR n_comdat     AS CHAR FORMAT "x(15)" INIT "".
DEF VAR pol72        AS CHAR FORMAT "x(12)" INIT "" .
DEF VAR n_product    AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_Rec          AS CHAR FORMAT "x(300)" INIT "".     /* start A63-0210 */
DEF VAR nv_remark       AS CHAR FORMAT "x(300)" INIT "".     
DEF VAR nv_Rec_name72   AS CHAR FORMAT "x(150)" INIT "".     
DEF VAR np_add70        AS CHAR FORMAT "x(150)" INIT "".     
DEF VAR np_add72        AS CHAR FORMAT "x(150)" INIT "".     
DEF VAR np_remark       AS CHAR FORMAT "x(300)" INIT "".     
DEF VAR np_Rec_name72   AS CHAR FORMAT "x(150)" INIT "".     
DEF VAR np_Rec_add1     AS CHAR FORMAT "x(150)" INIT "".     
DEF VAR nv_Rec_add1     AS CHAR FORMAT "x(60)"  INIT "".
DEF VAR np_INIT         AS CHAR FORMAT "x(60)"  INIT "".    /* end A63-0210 */
/* Add by : A64-0271 */
DEF VAR n_address  as char format "X(250)" .
DEF VAR n_build    as char format "X(100)" .
DEF VAR n_tambon   as char format "X(50)" .
DEF VAR n_amper    as char format "X(50)" .
DEF VAR n_country  as char format "X(50)" .
DEF VAR n_post     as char format "X(5)" .
/* end A64-0271 */
DEF VAR n_policy01y     as char format "X(20)" .
DEF VAR n_policy02y     as char format "X(20)" .
DEF BUFFER buwm100 FOR sicuw.uwm100.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_comp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcomp

/* Definitions for BROWSE br_comp                                       */
&Scoped-define FIELDS-IN-QUERY-br_comp wcomp.package wcomp.premcomp   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_comp   
&Scoped-define SELF-NAME br_comp
&Scoped-define QUERY-STRING-br_comp FOR EACH wcomp
&Scoped-define OPEN-QUERY-br_comp OPEN QUERY br_comp FOR EACH wcomp.
&Scoped-define TABLES-IN-QUERY-br_comp wcomp
&Scoped-define FIRST-TABLE-IN-QUERY-br_comp wcomp


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_year ra_matpoltyp fi_producernewf ~
fi_agentnewfo fi_producernewtis fi_agentnewtis fi_producerford fi_agentford ~
fi_producerno83 fi_agentno83 fi_producer83 fi_agent83 fi_filename ~
fi_filename2 fi_outfile br_comp ra_matchpol bu_add bu_del fi_packcom ~
fi_loadname bu_ok bu_exit bu_file bu_file2 fi_outload bu_file-3 bu_ok2 ~
bu_exit-2 fi_premcomp fi_produceris fi_agentis fi_producernewf2 ~
fi_agentnewfo2 fi_producerMI fi_agentMI fi_producerNCIR fi_agentNCIR ~
fi_producerCIR fi_agentCIR fi_pdtkcode fi_agtkcode fi_pdbkcode fi_agbkcode ~
fi_producerTF fi_agentTF fi_producerf2y fi_agentf2y fi_producerhv ~
fi_agenthv fi_producerns fi_agentns fi_producerns2 fi_agentns2 RECT-76 ~
RECT-77 RECT-381 RECT-382 RECT-383 RECT-384 RECT-385 RECT-386 
&Scoped-Define DISPLAYED-OBJECTS fi_year ra_matpoltyp fi_producernewf ~
fi_agentnewfo fi_producernewtis fi_agentnewtis fi_producerford fi_agentford ~
fi_producerno83 fi_agentno83 fi_producer83 fi_agent83 fi_filename ~
fi_filename2 fi_outfile ra_matchpol fi_packcom fi_loadname fi_outload ~
fi_premcomp fi_produceris fi_agentis fi_producernewf2 fi_agentnewfo2 ~
fi_producerMI fi_agentMI fi_producerNCIR fi_agentNCIR fi_producerCIR ~
fi_agentCIR fi_pdtkcode fi_agtkcode fi_pdbkcode fi_agbkcode fi_producerTF ~
fi_agentTF fi_producerf2y fi_agentf2y fi_producerhv fi_agenthv ~
fi_producerns fi_agentns fi_producerns2 fi_agentns2 

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
     SIZE 5 BY .91.

DEFINE BUTTON bu_del 
     LABEL "DEL" 
     SIZE 5 BY .91.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_exit-2 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_file-3 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_file2 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_ok2 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_agbkcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agent83 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentCIR AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentf2y AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentford AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agenthv AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentis AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentMI AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentNCIR AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentnewfo AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentnewfo2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentnewtis AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentno83 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentns AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentns2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agentTF AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agtkcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_filename2 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 66 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_packcom AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pdbkcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_pdtkcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premcomp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer83 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerCIR AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerf2y AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerford AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerhv AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_produceris AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerMI AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerNCIR AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producernewf AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producernewf2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producernewtis AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerno83 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerns AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerns2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerTF AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_matchpol AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match File Confirm to Policy [Renew] ", 1,
"Match File New[ไฟล์แจ้งงาน] to Policy [New]", 2
     SIZE 100.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_matpoltyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "All", 1,
"Pol 70", 2,
"Pol 72", 3
     SIZE 39.5 BY 1
     FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124.5 BY 9
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-383
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10 BY 2
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-384
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7 BY 1.19
     BGCOLOR 5 .

DEFINE RECTANGLE RECT-385
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 7.17 BY 1.19
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-386
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105.5 BY 1.29
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124.5 BY 16.19
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 2
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_comp FOR 
      wcomp SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_comp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_comp C-Win _FREEFORM
  QUERY br_comp DISPLAY
      wcomp.package    COLUMN-LABEL "Package" FORMAT "x(10)"
      wcomp.premcomp   COLUMN-LABEL "Premcomp"   FORMAT "->>>,>>9.99"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 29.17 BY 4
         BGCOLOR 15  ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_year AT ROW 9.95 COL 108.17 COLON-ALIGNED NO-LABEL
     ra_matpoltyp AT ROW 20.19 COL 70 NO-LABEL
     fi_producernewf AT ROW 4.24 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_agentnewfo AT ROW 4.24 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_producernewtis AT ROW 6.33 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_agentnewtis AT ROW 6.33 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_producerford AT ROW 4.29 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_agentford AT ROW 4.29 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_producerno83 AT ROW 5.33 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_agentno83 AT ROW 5.33 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_producer83 AT ROW 6.38 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_agent83 AT ROW 6.38 COL 76.67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 13.62 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_filename2 AT ROW 14.71 COL 31.5 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 15.81 COL 31.5 COLON-ALIGNED NO-LABEL
     br_comp AT ROW 5.81 COL 95
     ra_matchpol AT ROW 18.91 COL 9.5 NO-LABEL
     bu_add AT ROW 3.48 COL 118.5
     bu_del AT ROW 4.67 COL 118.33
     fi_packcom AT ROW 3.62 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_loadname AT ROW 21.48 COL 25.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 15.14 COL 105.67
     bu_exit AT ROW 15.14 COL 114.33
     bu_file AT ROW 13.62 COL 100
     bu_file2 AT ROW 14.71 COL 100
     fi_outload AT ROW 22.62 COL 25.17 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 21.43 COL 118
     bu_ok2 AT ROW 24.33 COL 67.17
     bu_exit-2 AT ROW 24.33 COL 77.33
     fi_premcomp AT ROW 4.71 COL 105.33 COLON-ALIGNED NO-LABEL
     fi_produceris AT ROW 7.38 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_agentis AT ROW 7.38 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_producernewf2 AT ROW 5.29 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_agentnewfo2 AT ROW 5.29 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_producerMI AT ROW 7.38 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_agentMI AT ROW 7.38 COL 76.83 COLON-ALIGNED NO-LABEL
     fi_producerNCIR AT ROW 8.38 COL 15.17 COLON-ALIGNED NO-LABEL
     fi_agentNCIR AT ROW 8.38 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_producerCIR AT ROW 8.43 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_agentCIR AT ROW 8.43 COL 76.83 COLON-ALIGNED NO-LABEL
     fi_pdtkcode AT ROW 9.38 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_agtkcode AT ROW 9.38 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_pdbkcode AT ROW 10.43 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_agbkcode AT ROW 10.43 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_producerTF AT ROW 9.48 COL 59.33 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_agentTF AT ROW 9.48 COL 76.83 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_producerf2y AT ROW 11.48 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_agentf2y AT ROW 11.48 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     fi_producerhv AT ROW 12.52 COL 15.17 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_agenthv AT ROW 12.52 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 34
     fi_producerns AT ROW 10.52 COL 59.33 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_agentns AT ROW 10.52 COL 76.83 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     fi_producerns2 AT ROW 11.57 COL 59.33 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_agentns2 AT ROW 11.57 COL 76.83 COLON-ALIGNED NO-LABEL WIDGET-ID 50
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.67 BY 25.48
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " File Confirm MV (TISCO_V70):" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 13.62 COL 4
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Match by :" VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 20.19 COL 58.67
          BGCOLOR 3 FGCOLOR 4 FONT 6
     "Ford Ranger" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 4.19 COL 4
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "  Match Text File Confirm (TISCO) & TLT(data) to Excel" VIEW-AS TEXT
          SIZE 118.83 BY 1.52 AT ROW 1.33 COL 3.17
          BGCOLOR 18 FGCOLOR 4 FONT 2
     "Not 8.3" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 5.33 COL 51.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "FILE LOAD TEXT :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 21.48 COL 4.5
          BGCOLOR 18 FONT 6
     "BIGBIKE" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 10.43 COL 4 WIDGET-ID 14
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "                         MATCH FILE LOAD TO POLICY NO. AND Update YES" VIEW-AS TEXT
          SIZE 123.5 BY 1.24 AT ROW 17.43 COL 1.5
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "CIR" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 8.43 COL 51.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Ford" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 4.29 COL 51.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 10.43 COL 32.33 WIDGET-ID 16
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "NISSAN 1" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 10.52 COL 51.17 WIDGET-ID 46
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 5.33 COL 76.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Tisco" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 6.29 COL 4
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "งานป้ายแดงปี :" VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 9.91 COL 95
          BGCOLOR 14 FGCOLOR 2 FONT 6
     "Ford 2 Year" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 11.48 COL 4 WIDGET-ID 30
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "CIN" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 8.38 COL 4
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "Mazda MI" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 7.38 COL 51.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Ford Other" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 5.24 COL 4
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "base comp :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 4.71 COL 95
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "HAVAL" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 12.52 COL 4 WIDGET-ID 38
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "Pack comp :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 3.62 COL 95
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 10.48 COL 76.5 WIDGET-ID 48
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 12.52 COL 32.33 WIDGET-ID 40
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 9.38 COL 32.33 WIDGET-ID 8
          BGCOLOR 2 FGCOLOR 6 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.67 BY 25.48
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 22.62 COL 4.5
          BGCOLOR 18 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 5.33 COL 32.33
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 11.52 COL 76.5 WIDGET-ID 56
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 7.38 COL 32.33
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 4.24 COL 32.33
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "Producer/ Agent Code (ReNew)" VIEW-AS TEXT
          SIZE 43 BY 1 AT ROW 3.14 COL 51.33
          BGCOLOR 21 FGCOLOR 2 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 6.38 COL 32.33
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 7.33 COL 76.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Date 12/07/2023" VIEW-AS TEXT
          SIZE 16 BY .71 AT ROW 24.81 COL 88 WIDGET-ID 58
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 8.38 COL 32.33
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "TURCK" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 9.38 COL 4 WIDGET-ID 6
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 6.33 COL 76.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "TRANF 23" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 9.48 COL 51.17 WIDGET-ID 22
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 11.48 COL 32.33 WIDGET-ID 32
          BGCOLOR 2 FGCOLOR 6 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 8.38 COL 76.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Producer/ Agent Code (New)" VIEW-AS TEXT
          SIZE 45.5 BY 1 AT ROW 3.1 COL 4
          BGCOLOR 29 FGCOLOR 6 FONT 6
     " File Confirm MC (TISCO_V72):" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 14.71 COL 4
          BGCOLOR 18 FGCOLOR 1 FONT 6
     " Output Match Data to Excel :" VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 15.81 COL 4
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "NISSAN 2" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 11.57 COL 51.17 WIDGET-ID 54
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 9.43 COL 76.5 WIDGET-ID 24
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Isuzu" VIEW-AS TEXT
          SIZE 13 BY .95 AT ROW 7.33 COL 4
          BGCOLOR 2 FGCOLOR 15 FONT 6
     "8.3" VIEW-AS TEXT
          SIZE 10 BY .95 AT ROW 6.38 COL 51.17
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "/" VIEW-AS TEXT
          SIZE 2 BY .95 AT ROW 4.29 COL 76.5
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 14.67 COL 104
     RECT-381 AT ROW 17.24 COL 1
     RECT-382 AT ROW 23.91 COL 76
     RECT-383 AT ROW 23.91 COL 66
     RECT-384 AT ROW 3.33 COL 117.5
     RECT-385 AT ROW 4.52 COL 117.33
     RECT-386 AT ROW 18.76 COL 5.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124.67 BY 25.48
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
         TITLE              = "Match text TISCO && TLT"
         HEIGHT             = 25.43
         WIDTH              = 124.67
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
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
/* BROWSE-TAB br_comp fi_outfile fr_main */
ASSIGN 
       br_comp:SEPARATOR-FGCOLOR IN FRAME fr_main      = 15.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

ASSIGN 
       bu_file2:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_comp
/* Query rebuild information for BROWSE br_comp
     _START_FREEFORM
OPEN QUERY br_comp FOR EACH wcomp.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_comp */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text TISCO  TLT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text TISCO  TLT */
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
    wcomp.package:BGCOLOR IN BROWSE  BR_comp = z NO-ERROR.  
    wcomp.premcomp:BGCOLOR IN BROWSE BR_comp = z NO-ERROR.

    wcomp.package:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
    wcomp.premcomp:FGCOLOR IN BROWSE BR_comp = s NO-ERROR.  
          
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_add C-Win
ON CHOOSE OF bu_add IN FRAME fr_main /* ADD */
DO:
    IF fi_packcom = "" THEN DO:
        APPLY "ENTRY" TO fi_packcom .
        disp fi_packcom  with frame  fr_main.
    END.
    ELSE DO:
        FIND LAST WComp WHERE wcomp.package = trim(fi_packcom) NO-ERROR NO-WAIT.
        IF NOT AVAIL wcomp THEN DO:
            CREATE wcomp.
            ASSIGN wcomp.package   = trim(fi_packcom)
                   wcomp.premcomp  = fi_premcomp
                fi_packcom      = "" 
                fi_premcomp     = 0  .
        END.
    END.
    OPEN QUERY br_comp FOR EACH wcomp.
    APPLY "ENTRY" TO fi_packcom  .
    disp  fi_packcom  fi_premcomp  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_del
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_del C-Win
ON CHOOSE OF bu_del IN FRAME fr_main /* DEL */
DO:
    GET CURRENT br_comp EXCLUSIVE-LOCK.
    DELETE wcomp.
    /*FIND LAST wcomp WHERE wcomp.package  = fi_packcom NO-ERROR NO-WAIT.
        IF    AVAIL wcomp THEN DELETE wcomp.
        ELSE MESSAGE "Not found Package !!! in : " fi_packcom VIEW-AS ALERT-BOX.
        */
    OPEN QUERY br_comp FOR EACH wcomp.
    APPLY "ENTRY" TO fi_packcom IN FRAME fr_main.
    disp  fi_packcom  fi_premcomp with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit-2 C-Win
ON CHOOSE OF bu_exit-2 IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
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

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename  = cvData.
         DISP fi_filename WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-3 C-Win
ON CHOOSE OF bu_file-3 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.
    SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
        "Text Documents" "*.csv",
        "Data Files (*.*)"     "*.*"
        
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
    IF OKpressed = TRUE THEN DO:
        fi_loadname  = cvData.
        fi_outload  = replace(fi_loadname,".csv","").
        fi_outload = fi_outload + "_mat.csv" .
        DISP fi_loadname fi_outload WITH FRAME fr_main .     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file2 C-Win
ON CHOOSE OF bu_file2 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename2  = cvData.
         DISP fi_filename2 WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    /*nv_daily   =  "". */
    ASSIGN 
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wdetail3:
        DELETE  wdetail3.
    END.
    IF r-index(fi_filename,"\") <> 0 THEN DO:
       IF SUBSTR(fi_filename,r-index(fi_filename,"\") + 1,2) <> "MV" THEN DO:
            MESSAGE "Plese check filename confirm again...!!!" SKIP
                "Insert file name Confirm policy 70 MV...!!!"      VIEW-AS ALERT-BOX.
            APPLY "Entry" TO fi_filename.
            RETURN NO-APPLY.
        END.
    END.
    IF r-index(fi_filename2,"\") <> 0 THEN DO:
        IF SUBSTR(fi_filename2,r-index(fi_filename2,"\") + 1,2) <> "MC" THEN DO:
            MESSAGE "Plese check filename confirm again...!!!" SKIP
                "Insert file name Confirm policy 72 MC...!!!"      VIEW-AS ALERT-BOX.
            APPLY "Entry" TO fi_filename2.
            RETURN NO-APPLY.
        END.
    END.
    IF fi_outfile = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
                "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
            APPLY "Entry" TO fi_outfile.
            RETURN NO-APPLY.
         
    END.
    /*INPUT FROM VALUE (fi_filename) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.recordID     /*REC_ID      */       
            wdetail.Account_no   /*ACCOUNT_NO  */   
            wdetail.client_no    /*CLIENT_NO   */   
            wdetail.preaccno     /*PRE_ACC_NO  */   
            wdetail.notino       /*NOTIFY_NO   */   
            wdetail.stk          /*STICKER_NO  */  
            wdetail.policyno     /*POLICY_NO   */  
            wdetail.chasno       /*CHASSIS_NO  */  
            wdetail.vehreg       /*LICENCE     */  
            wdetail.re_country   /*PROVINCE_REG*/  
            wdetail.not_office   /*OFFICE_CODE */  
            wdetail.name_insur   /*OFFICE_NAME */ 
            wdetail.tiname       /*TITLE_NAME  */ 
            wdetail.insnam       /*FIRST_NAME  */ 
            wdetail.name2        /*LAST_NAME   */ 
            wdetail.idno         /*ID_NO       */ 
            wdetail.dup_pol      /*DUP_POLICY  */ 
            wdetail.ori_pol      /*ORI_POLICY  */
            wdetail.mail_add1    /*MAIL_ADD1   */        
            wdetail.mail_add2    /*MAIL_ADD2   */        
            wdetail.tambon       /*DISTRICT    */        
            wdetail.amper        /*AMPHUR      */        
            wdetail.country      /*PROVINCE    */        
            wdetail.post  .      /*ZIPCODE     */    
    
    END.  /* repeat  */
    FOR EACH wdetail .
        IF wdetail.recordID = "REC_ID"  THEN DELETE wdetail.
    END.
    FOR EACH wdetail .
        ASSIGN  wdetail.recordID   = trim(wdetail.recordID)    
            wdetail.Account_no = trim(wdetail.Account_no)   
            wdetail.client_no  = trim(wdetail.client_no)    
            wdetail.preaccno   = trim(wdetail.preaccno)     
            wdetail.notino     = trim(wdetail.notino)       
            wdetail.stk        = trim(wdetail.stk)          
            wdetail.policyno   = "RTIS70" + trim(wdetail.chasno)     
            wdetail.chasno     = trim(wdetail.chasno)       
            wdetail.vehreg     = trim(wdetail.vehreg)       
            wdetail.re_country = trim(wdetail.re_country)   
            wdetail.not_office = trim(wdetail.not_office)   
            wdetail.name_insur = trim(wdetail.name_insur)   
            wdetail.tiname     = trim(wdetail.tiname)       
            wdetail.insnam     = trim(wdetail.insnam)       
            wdetail.name2      = trim(wdetail.name2)        
            wdetail.idno       = trim(wdetail.idno)         
            wdetail.dup_pol    = trim(wdetail.dup_pol)      
            wdetail.ori_pol    = trim(wdetail.ori_pol)      
            wdetail.mail_add1  = trim(wdetail.mail_add1)   
            wdetail.mail_add2  = trim(wdetail.mail_add2)    
            wdetail.tambon     = trim(wdetail.tambon)      
            wdetail.amper      = trim(wdetail.amper)        
            wdetail.country    = trim(wdetail.country)      
            wdetail.post       = trim(wdetail.post) .
        IF wdetail.mail_add2 = "" THEN DO:
            ASSIGN wdetail.addr1   = SUBSTR(wdetail.mail_add1,1,LENGTH(wdetail.mail_add1))
                wdetail.tambon     = SUBSTR(wdetail.tambon,1,LENGTH(wdetail.tambon))  
                wdetail.amper      = SUBSTR(wdetail.amper,1,LENGTH(wdetail.amper))
                wdetail.country    = SUBSTR(wdetail.country,1,LENGTH(wdetail.country))
                wdetail.post       = SUBSTR(wdetail.post,1,LENGTH(wdetail.post)) .
            IF (INDEX(wdetail.country,"กทม") <> 0 ) OR (INDEX(wdetail.country,"กรุงเทพ") <> 0 ) THEN
                wdetail.addr2      =  "เขต" +  wdetail.tambon + " " + 
                "แขวง" +  wdetail.amper + " " + 
                wdetail.country + " " + wdetail.post.  
            ELSE  wdetail.addr2      = "ตำบล"    + wdetail.tambon  + " " + 
                "อำเภอ"   + wdetail.amper   + " " + 
                "จังหวัด" + wdetail.country + " " + wdetail.post.  
        END.
        ELSE ASSIGN  wdetail.addr1 = SUBSTR(wdetail.mail_add1,1,LENGTH(wdetail.mail_add1))
            wdetail.addr2 = SUBSTR(wdetail.mail_add2,1,LENGTH(wdetail.tambon)) .
    END.
    *************************/
RUN  proc_imp70. 
RUN  proc_imp72.
/*RUN  Pro_matchfile_tlt.*/
Run  Pro_createfile.
Message "Export data Complete"  View-as alert-box.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok2 C-Win
ON CHOOSE OF bu_ok2 IN FRAME fr_main /* Ok */
DO:
     /*nv_daily   =  "". */
    ASSIGN 
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wdetail2:
        DELETE  wdetail2.
    END.
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    IF ra_matchpol = 1 THEN RUN proc_impmatpol1.  /*Add A56-0104*/
    ELSE RUN proc_impmatpol2.                     /*Add A56-0104*/
    /*comment BY Kridtiya i. A56-0104....
    INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.Pro_off   
            wdetail.cmr_code  
            wdetail.comcode   
            wdetail.policyno  
            wdetail.caryear   
            wdetail.eng       
            wdetail.chasno            
            wdetail.engcc                     
            wdetail.power                     
            wdetail.colorcode                 
            wdetail.vehreg 
            wdetail.garage                    
            wdetail.fleetper                  
            wdetail.ncb                       
            wdetail.orthper                   
            wdetail.vehuse                    
            wdetail.comdat                     
            wdetail.si                        
            wdetail.name_insur              
            wdetail.not_office              
            wdetail.entdat                 
            wdetail.enttim                  
            wdetail.not_code               
            wdetail.premt                  
            wdetail.comp_prm               
            wdetail.stk                    
            wdetail.brand                  
            wdetail.mail_add1              
            wdetail.tambon    
            wdetail.amper     
            wdetail.country   
            wdetail.tiname                 
            wdetail.insnam               
            /*wdetail.name2 */                 
            wdetail.benname                
            wdetail.remark                 
            wdetail.Account_no                  
            wdetail.client_no                   
            wdetail.expdat                       
            wdetail.gap 
            wdetail.re_country  
            wdetail.RECP_NAME 
            wdetail.agent        
            wdetail.prev_insur   
            wdetail.prepol
            wdetail.drivnam1
            wdetail.driag1  
            wdetail.drivnam2
            wdetail.driag2  
            wdetail.deduct 
            wdetail.branch 
            wdetail.prempa 
            wdetail.tp1    
            wdetail.tp2    
            wdetail.tp3    
            wdetail.covcod .
    END.   /* repeat  */
    FOR EACH wdetail .
        IF index(wdetail.Pro_off,"บริษัท")   <> 0  THEN DELETE wdetail.
        ELSE IF index(wdetail.Pro_off,"Pro") <> 0  THEN DELETE wdetail.
        ELSE IF wdetail.Pro_off  = "" THEN DELETE wdetail.
        ELSE DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = wdetail.Account_no  AND 
                sicuw.uwm100.poltyp = "V" + SUBSTR(wdetail.policyno,3,2)   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN wdetail.pol70 = sicuw.uwm100.policy.
                IF sicuw.uwm100.poltyp = "V70"  THEN DO:
                    FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                        brstat.tlt.cha_no  =  wdetail.chasno AND              
                        brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.     
                    IF AVAIL brstat.tlt THEN DO:
                        IF INDEX(tlt.releas,"yes") = 0 THEN ASSIGN tlt.releas =  "yes".
                    END.
                    RELEASE brstat.tlt.
                END.
            END.
            ELSE ASSIGN wdetail.pol70 = "".
            /*IF wdetail.pol72 = "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                    WHERE sicuw.uwm100.cedpol = wdetail.Account_no AND 
                    sicuw.uwm100.poltyp = "V72"              NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN 
                    ASSIGN wdetail.pol72 = sicuw.uwm100.policy
                    wdetail.pol70 = sicuw.uwm100.cr_2.
                ELSE ASSIGN wdetail.pol70 = ""
                    wdetail.pol72 = "".
            END.*/
        END.
    END.
    Run  Pro_createfilepol.
    Message "Export data Complete"  View-as alert-box.
    end...comment BY Kridtiya i. A56-0104....*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agbkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agbkcode C-Win
ON LEAVE OF fi_agbkcode IN FRAME fr_main
DO:
  fi_agbkcode = INPUT fi_agbkcode.
  DISP fi_agbkcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent83
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent83 C-Win
ON LEAVE OF fi_agent83 IN FRAME fr_main
DO:
  fi_agent83 = INPUT fi_agent83.
  DISP fi_agent83 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentCIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentCIR C-Win
ON LEAVE OF fi_agentCIR IN FRAME fr_main
DO:
  fi_agentCIR = INPUT fi_agentCIR.
  DISP fi_agentCIR WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentf2y
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentf2y C-Win
ON LEAVE OF fi_agentf2y IN FRAME fr_main
DO:
  fi_agentf2y = INPUT fi_agentf2y.
  DISP fi_agentf2y WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentford
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentford C-Win
ON LEAVE OF fi_agentford IN FRAME fr_main
DO:
  fi_agentford = INPUT fi_agentford.
  DISP fi_agentford WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agenthv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agenthv C-Win
ON LEAVE OF fi_agenthv IN FRAME fr_main
DO:
  fi_agentf2y = INPUT fi_agentf2y.
  DISP fi_agentf2y WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentis C-Win
ON LEAVE OF fi_agentis IN FRAME fr_main
DO:
  fi_agentis = INPUT fi_agentis.
  DISP fi_agentis WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentMI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentMI C-Win
ON LEAVE OF fi_agentMI IN FRAME fr_main
DO:
  fi_agentMI = INPUT fi_agentMI.
  DISP fi_agentMI WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentNCIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentNCIR C-Win
ON LEAVE OF fi_agentNCIR IN FRAME fr_main
DO:
  fi_agentNCIR = INPUT fi_agentNCIR.
  DISP fi_agentNCIR WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentnewfo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentnewfo C-Win
ON LEAVE OF fi_agentnewfo IN FRAME fr_main
DO:
  fi_agentnewfo = INPUT fi_agentnewfo.
  DISP fi_agentnewfo WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentnewfo2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentnewfo2 C-Win
ON LEAVE OF fi_agentnewfo2 IN FRAME fr_main
DO:
  fi_agentnewfo2 = INPUT fi_agentnewfo2.
  DISP fi_agentnewfo2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentnewtis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentnewtis C-Win
ON LEAVE OF fi_agentnewtis IN FRAME fr_main
DO:
  fi_agentnewtis = INPUT fi_agentnewtis.
  DISP fi_agentnewtis WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentno83
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentno83 C-Win
ON LEAVE OF fi_agentno83 IN FRAME fr_main
DO:
    fi_agentno83 = INPUT fi_agentno83.
    DISP fi_agentno83 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentns
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentns C-Win
ON LEAVE OF fi_agentns IN FRAME fr_main
DO:
  fi_agentns = INPUT fi_agentns.
  DISP fi_agentns WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentns2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentns2 C-Win
ON LEAVE OF fi_agentns2 IN FRAME fr_main
DO:
  fi_agentns2 = INPUT fi_agentns2.
  DISP fi_agentns2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agentTF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agentTF C-Win
ON LEAVE OF fi_agentTF IN FRAME fr_main
DO:
  fi_agentTF = INPUT fi_agentTF.
  DISP fi_agentTF WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agtkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agtkcode C-Win
ON LEAVE OF fi_agtkcode IN FRAME fr_main
DO:
  fi_agtkcode = INPUT fi_agtkcode.
  DISP fi_agtkcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename.
  nv_file1     =  fi_filename .
  Disp  fi_filename  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename2 C-Win
ON LEAVE OF fi_filename2 IN FRAME fr_main
DO:
  fi_filename2  =  Input  fi_filename2.
  nv_file2      =  fi_filename2.
  Disp  fi_filename2  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outload
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload C-Win
ON LEAVE OF fi_outload IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_packcom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packcom C-Win
ON LEAVE OF fi_packcom IN FRAME fr_main
DO:
    fi_packcom =  Input  fi_packcom.
    Disp  fi_packcom  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pdbkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pdbkcode C-Win
ON LEAVE OF fi_pdbkcode IN FRAME fr_main
DO:
  fi_pdbkcode = INPUT fi_pdbkcode.
  DISP fi_pdbkcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pdtkcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pdtkcode C-Win
ON LEAVE OF fi_pdtkcode IN FRAME fr_main
DO:
  fi_pdtkcode = INPUT fi_pdtkcode.
  DISP fi_pdtkcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premcomp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premcomp C-Win
ON LEAVE OF fi_premcomp IN FRAME fr_main
DO:
    fi_premcomp =  Input  fi_premcomp.
    Disp  fi_premcomp  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer83
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer83 C-Win
ON LEAVE OF fi_producer83 IN FRAME fr_main
DO:
    fi_producer83 = INPUT fi_producer83.
    DISP fi_producer83 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerCIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerCIR C-Win
ON LEAVE OF fi_producerCIR IN FRAME fr_main
DO:
    fi_producerCIR = INPUT fi_producerCIR.
    DISP fi_producerCIR WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerf2y
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerf2y C-Win
ON LEAVE OF fi_producerf2y IN FRAME fr_main
DO:
  fi_producerf2y = INPUT fi_producerf2y.
  DISP fi_producerf2y WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerford
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerford C-Win
ON LEAVE OF fi_producerford IN FRAME fr_main
DO:
  fi_producerford = INPUT fi_producerford.
  DISP fi_producerford WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerhv
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerhv C-Win
ON LEAVE OF fi_producerhv IN FRAME fr_main
DO:
  fi_producerf2y = INPUT fi_producerf2y.
  DISP fi_producerf2y WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_produceris
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_produceris C-Win
ON LEAVE OF fi_produceris IN FRAME fr_main
DO:
  fi_produceris = INPUT fi_produceris.
  DISP fi_produceris WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerMI
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerMI C-Win
ON LEAVE OF fi_producerMI IN FRAME fr_main
DO:
    fi_producerMI = INPUT fi_producerMI.
    DISP fi_producerMI WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerNCIR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerNCIR C-Win
ON LEAVE OF fi_producerNCIR IN FRAME fr_main
DO:
  fi_producerNCIR = INPUT fi_producerNCIR.
  DISP fi_producerNCIR WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producernewf
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producernewf C-Win
ON LEAVE OF fi_producernewf IN FRAME fr_main
DO:
  fi_producernewf = INPUT fi_producernewf.
  DISP fi_producernewf WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producernewf2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producernewf2 C-Win
ON LEAVE OF fi_producernewf2 IN FRAME fr_main
DO:
  fi_producernewf2 = INPUT fi_producernewf2.
  DISP fi_producernewf2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producernewtis
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producernewtis C-Win
ON LEAVE OF fi_producernewtis IN FRAME fr_main
DO:
  fi_producernewtis = INPUT fi_producernewtis.
  DISP fi_producernewtis WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerno83
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerno83 C-Win
ON LEAVE OF fi_producerno83 IN FRAME fr_main
DO:
    fi_producerno83 = INPUT fi_producerno83.
    DISP fi_producerno83 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerns
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerns C-Win
ON LEAVE OF fi_producerns IN FRAME fr_main
DO:
    fi_producerns = INPUT fi_producerns.
    DISP fi_producerns WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerns2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerns2 C-Win
ON LEAVE OF fi_producerns2 IN FRAME fr_main
DO:
    fi_producerns2 = INPUT fi_producerns2.
    DISP fi_producerns2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerTF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerTF C-Win
ON LEAVE OF fi_producerTF IN FRAME fr_main
DO:
    fi_producerTF = INPUT fi_producerTF.
    DISP fi_producerTF WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year C-Win
ON LEAVE OF fi_year IN FRAME fr_main
DO:
   fi_year = INPUT fi_year.
   DISP fi_year WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_matchpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_matchpol C-Win
ON VALUE-CHANGED OF ra_matchpol IN FRAME fr_main
DO:
  ra_matchpol = INPUT ra_matchpol .
  DISP ra_matchpol WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_matpoltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_matpoltyp C-Win
ON VALUE-CHANGED OF ra_matpoltyp IN FRAME fr_main
DO:
    ra_matpoltyp = INPUT ra_matpoltyp.
    DISP ra_matpoltyp WITH FRAM fr_main.
  
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
  
   /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  ASSIGN 
      ra_matchpol       = 1
      ra_matpoltyp      = 1
      gv_prgid          = "WGWPUTE2"
      /*fi_producernewf   = "B3M0032" */  /*A59-0618 */
      /* comment by : A64-0092...
      fi_producernewf   = "B3M0002"       /*A59-0618 */ 
      fi_producernewf2  = "B3M0032"       /*A59-0618 */ 
      fi_agentnewfo2    = "B3M0002"       /*A59-0618 */ 
      fi_agentnewfo     = "B3M0002" 
      fi_producernewtis = "B3M0003" 
      fi_agentnewtis    = "B3M0002" 
      fi_producerford   = "B3M0033"
      fi_producerno83   = "A0M2008"
      fi_producer83     = "A0M2012"
     /* fi_agentford      = "B3M0002"  */ /*A61-0313*/
     /* fi_agentno83      = "B3M0002"  */ /*A61-0313*/
     /* fi_agent83        = "B3M0002"  */ /*A61-0313*/
     /* comment by A62-0386......
      fi_producerma     = "B3M0043"    /*A59-0618 */
      fi_agentma        = "B3M0002"    /*A59-0618 */
      fi_producermar    = "B3M0044"    /*A59-0618 */
      ...end A62-0386*/
      /*fi_agentmar       = "B3M0002" */  /*A59-0618 */ /*A61-0313*/
      fi_produceris     = "B3M0029"    /*A59-0618 */  
      fi_agentis        = "B3M0002"   /*A59-0618 */  
     /* fi_producerMPI    = "A0M1046"   /*A60-0225*/ */ /*A62-0386 */
     /* fi_agentMPI       = "B3M0002"   /*A60-0225*/ */ /*A62-0386 */
      /*fi_producerMI     = "A0M1046"*/    /*A60-0225*/  /*A61-0313*/
      /*fi_agentMI        = "B3M0002"*/    /*A60-0225*/  /*A61-0313*/
      fi_producerNCIR   = "A0M2010"   /*A60-0225*/
      fi_agentNCIR      = "B3M0002"   /*A60-0225*/
      fi_producerCIR    = "A0M2010"   /*A60-0225*/
      /*fi_agentCIR       = "B3M0002" */  /*A60-0225*/ /*A61-0313*/
      fi_year           = STRING(YEAR(TODAY),"9999")  /*a60-0095*/
       /* A61-0313 */
      fi_agentford      = "B3M0035"     
      fi_agentno83      = "B3M0035"   
      fi_agent83        = "B3M0035"  
      /*fi_agentmar       = "B3M0035" */ /*A62-0386 */
      /*fi_producerMI     = "B3M0044"*/ /*a62-0386*/
      fi_producerMI     = "A0M2012"     /*a62-0386*/
      fi_agentMI        = "B3M0035"
      fi_agentCIR       = "B3M0035" .
      ... end A64-0092...*/
      /* end A61-0313 */
       /* add by : A64-0092 */
      fi_producernewf   = "B3M0002"     
      /*fi_producernewf2  = "B3M0032" */ /*A64-0092*/
      fi_producernewf2  = "B3M0002"  /*A64-0092*/
      fi_agentnewfo2    = "B3M0002"     
      fi_agentnewfo     = "B3M0002" 
      fi_producernewtis = "B3MLTIS201"   /*"B3M0003"*/ 
      fi_agentnewtis    = "B3MLTIS200"   /*"B3M0002" */
      fi_producerford   = "B3M0033"      
      fi_producerno83   = "B3MLTIS101"   /*"A0M2008"*/
      fi_producer83     = "B3MLTIS104"   /*"A0M2012"*/
      fi_produceris     = "B3MLTIS204"   /*"B3M0029"*/      
      fi_agentis        = "B3MLTIS200"   /*"B3M0002"*/      
      fi_producerNCIR   = "B3MLTIS102"   /*"A0M2010"*/   
      fi_agentNCIR      = "B3MLTIS100"   /*"B3M0002" */  
      fi_producerCIR    = "B3MLTIS102"   /*"A0M2010"*/   
      fi_year           = STRING(YEAR(TODAY),"9999")  
      fi_agentford      = "B3M0035"     
      fi_agentno83      = "B3MLTIS100"   /*"B3M0035" */  
      fi_agent83        = "B3MLTIS100"   /*"B3M0035"*/    
      fi_producerMI     = "B3MLTIS104"   /*"A0M2012"*/    
      fi_agentMI        = "B3MLTIS100"   /*"B3M0035"*/
      fi_agentCIR       = "B3MLTIS100"   /*"B3M0035" */
      fi_pdbkcode       = "B3MLTIS203"   /*B3M0028*/
      fi_agbkcode       = "B3MLTIS200"   
      fi_pdtkcode       = "B3MLTIS202"   /*B3M0007*/
      fi_agtkcode       = "B3MLTIS200"       
      /*... end A64-0092...*/
      fi_producerTF  = "B3MLTIS103"   /* โอนย้าย ป.2 3 A64-0271*/
      fi_agentTF     = "B3MLTIS100"   /* โอนย้าย ป.2 3 A64-0271*/
      fi_producerf2y  = "B3DM000004"
      fi_agentf2y     = "B3M0002"
      fi_producerhv   = "B3DM000004"
      fi_agenthv      = "B3M0002"
      fi_producerns   = "B3DM000002"
      fi_agentns      = "B3M0035" 
      fi_producerns2  = "B3DM000003"
      fi_agentns2     = "B3M0035" .


  gv_prog  = "Import Text File Confirm (TISCO) to Excel ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  RUN proc_createpack.
  OPEN QUERY br_comp FOR EACH wcomp.
      DISP ra_matchpol      fi_producerford   fi_producerno83  fi_producer83    fi_year /*A60-0095*/
           fi_agentford     fi_agentno83      fi_agent83       fi_producernewf   
           fi_agentnewfo    fi_producernewtis fi_agentnewtis   ra_matpoltyp WITH FRAM fr_main.   
      DISP /*fi_producerma    fi_agentma fi_producermar    fi_agentmar*/ /*A62-0386 */
           fi_produceris  fi_agentis 
           fi_producernewf2 fi_agentnewfo2 /*A60-0225*/ /*fi_producerMPI   fi_agentMPI */  fi_producerMI   
           fi_agentMI   fi_producerNCIR     fi_agentNCIR     fi_producerCIR  fi_agentCIR /*A60-0225*/
           fi_pdbkcode  fi_agbkcode         fi_pdtkcode      fi_agtkcode /*A64-0092*/
           fi_producerTF    fi_agentTF   /*A64-0271*/
          fi_producerf2y fi_agentf2y   fi_producerhv fi_agenthv    
    fi_producerns fi_agentns    fi_producerns2 fi_agentns2

          WITH FRAM fr_main. /* A59-0618 */ 

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-proc_impmatpol1 C-Win 
PROCEDURE 00-proc_impmatpol1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.Pro_off   
            wdetail.cmr_code  
            wdetail.comcode   
            wdetail.policyno  
            wdetail.caryear   
            wdetail.eng       
            wdetail.chasno            
            wdetail.engcc                     
            wdetail.power                     
            wdetail.colorcode                 
            wdetail.vehreg 
            wdetail.garage                    
            wdetail.fleetper                  
            wdetail.ncb                       
            wdetail.orthper                   
            wdetail.vehuse                    
            wdetail.comdat                     
            wdetail.si                        
            wdetail.name_insur              
            wdetail.not_office              
            wdetail.entdat                 
            wdetail.enttim                  
            wdetail.not_code               
            wdetail.premt                  
            wdetail.comp_prm               
            wdetail.stk                    
            wdetail.brand                  
            wdetail.mail_add1              
            wdetail.tambon    
            wdetail.amper     
            wdetail.country   
            wdetail.tiname                 
            wdetail.insnam               
            /*wdetail.name2 */                 
            wdetail.benname                
            wdetail.remark                 
            wdetail.Account_no                  
            wdetail.client_no                   
            wdetail.expdat                       
            wdetail.gap 
            wdetail.re_country  
            wdetail.RECP_NAME 
            wdetail.agent        
            wdetail.prev_insur   
            wdetail.prepol
            wdetail.drivnam1
            wdetail.driag1  
            wdetail.drivnam2
            wdetail.driag2  
            wdetail.deduct 
            wdetail.branch 
            wdetail.prempa 
            wdetail.name2      /*A57-0017 add seat */
            wdetail.tp1    
            wdetail.tp2    
            wdetail.tp3    
            wdetail.covcod 
            nnproducer     /*Producer */
            nnagent        /*Agent    */
            nnbranch       /*Branch   */
            nntyppol       /*typepol  */
            npid70         /*A57-0262*/
            npid70br       /*A57-0262*/
            npid72         /*A57-0262*/
            npid72br    .
        FIND LAST wdetail2 WHERE wdetail2.nppolicy = trim(wdetail.policyno) NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail2 THEN DO:
            CREATE wdetail2.     /*A57-0242*/
            ASSIGN 
                wdetail2.nppolicy     = trim(wdetail.policyno) 
                wdetail2.nnproducer   = trim(nnproducer)  
                wdetail2.nnagent      = trim(nnagent) 
                wdetail2.nnbranch     = trim(nnbranch) 
                wdetail2.nntyppol     = trim(nntyppol)    /*A57-0262*/
                wdetail2.npid70       = trim(npid70)      /*A57-0262*/
                wdetail2.npid70br     = trim(npid70br)    /*A57-0262*/
                wdetail2.npid72       = trim(npid72)      /*A57-0262*/
                wdetail2.npid72br     = trim(npid72br) .  /*A57-0262*/
        END.
        ASSIGN 
            nnproducer   = "" 
            nnagent      = "" 
            nnbranch     = "" 
            nntyppol     = ""   /*A57-0262*/
            npid70       = ""   /*A57-0262*/
            npid70br     = ""   /*A57-0262*/
            npid72       = ""   /*A57-0262*/
            npid72br     = "" .  /*A57-0262*/
    END.   /* repeat  */
    FOR EACH wdetail .
        IF index(wdetail.Pro_off,"บริษัท")   <> 0  THEN DELETE wdetail.
        ELSE IF index(wdetail.Pro_off,"Pro") <> 0  THEN DELETE wdetail.
        ELSE IF wdetail.Pro_off  = "" THEN DELETE wdetail.
        ELSE DO:
            
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no)  AND 
                sicuw.uwm100.poltyp = "V" + SUBSTR(wdetail.policyno,3,2)   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                
                ASSIGN wdetail.pol70 = sicuw.uwm100.policy.
                IF sicuw.uwm100.poltyp = "V70"  THEN DO:
                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   
                        brstat.tlt.cha_no  =  trim(wdetail.chasno)  AND              
                        brstat.tlt.genusr  =  "TISCO"               NO-ERROR NO-WAIT.     
                    IF AVAIL brstat.tlt THEN DO:
                        IF INDEX(brstat.tlt.releas,"yes") = 0 THEN ASSIGN brstat.tlt.releas =  "yes".
                    END.
                    RELEASE brstat.tlt.
                END.
            END.
            ELSE ASSIGN wdetail.pol70 = "".
            /*IF wdetail.pol72 = "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                    WHERE sicuw.uwm100.cedpol = wdetail.Account_no AND 
                    sicuw.uwm100.poltyp = "V72"              NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN 
                    ASSIGN wdetail.pol72 = sicuw.uwm100.policy
                    wdetail.pol70 = sicuw.uwm100.cr_2.
                ELSE ASSIGN wdetail.pol70 = ""
                    wdetail.pol72 = "".
            END.*/
        END.
    END.
    Run  Pro_createfilepol.
    Message "Export data Complete"  View-as alert-box.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE 00-Pro_createfilepol C-Win 
PROCEDURE 00-Pro_createfilepol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ." 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "Processing Office "  /* wdetail.Pro_off   */  
    "CMR  code"           /* wdetail.cmr_code  */  
    "Insur.comp "         /* wdetail.comcode   */  
    "notify number"       /* wdetail.policyno  */ 
    "กรมธรรม์PREMIUM"     /* wdetail.policyno  */  
    "Caryear "            /* wdetail.caryear   */  
    "Engine "             /* wdetail.eng       */  
    "Chassis  "           /* wdetail.chasno    */  
    "Weight"              /* wdetail.engcc     */  
    "Power"               /* wdetail.power     */  
    "Color "              /* wdetail.colorcode */  
    "licence no"          /* wdetail.vehreg    */ 
    "garage "             /* wdetail.garage    */  
    "fleet disc. "        /* wdetail.fleetper  */  
    "ncb disc. "          /* wdetail.ncb       */  
    "other disc. "        /* wdetail.orthper   */  
    "vehuse "             /* wdetail.vehuse    */  
    "comdat  "            /* wdetail.comdat    */  
    "sum si "             /* wdetail.si        */ 
    "รหัสเจ้าหน้าที่แจ้งประกัน "  /* wdetail.not_office */ 
    "ชื่อเจ้าหน้าที่ประกัน  "     /* wdetail.name_insur */ 
    "วันที่แจ้งประกัน  "   /* wdetail.entdat     */  
    "เวลาแจ้งประกัน "      /* wdetail.enttim     */  
    "รหัสแจ้งงาน"          /* wdetail.not_code   */  
    "prem.1"               /* wdetail.premt      */  
    "comp.prm "            /* wdetail.comp_prm   */  
    "sticker "             /* wdetail.stk        */  
    "brand "               /* wdetail.brand      */  
    "address1"             /* wdetail.mail_add1  */  
    "address2"             /* wdetail.tambon     */  
    "address3"             /* wdetail.amper      */  
    "address4"             /* wdetail.country    */  
    "title name  "         /* wdetail.tiname     */  
    "first name "          /* wdetail.insnam     */  
   /* "last name"          /* wdetail.name2      */ */ 
    "beneficiary "         /* wdetail.benname    */  
    "remark. "             /* wdetail.remark     */  
    "account no. "         /* wdetail.Account_no */  
    "client No. "          /* wdetail.client_no  */  
    "expiry date "         /* wdetail.expdat     */  
    "insurance amt.  "     /* wdetail.gap        */ 
    "province "            /* wdetail.re_country */  
    "receipt name  "          /* wdetail.RECP_NAME  */ 
    "agent code "             /* wdetail.agent      */    
    "บริษัทประกันภัยเดิม "    /* wdetail.prev_insur    */    
    "กรมธรรม์ต่ออายุ"         /* wdetail.prepol        */ 
    /*A63-0210
    "ชื่อผู้ขับขี่1"            
    "วันเกิด1"                
    "ชื่อผู้ขับขี่2"            
    "วันเกิด2"                
    "deduct disc.  "            /* wdetail.deduct        */    
    "สาขา"                      /* wdetail.branch        */    
    "แพคเกจ"                    /* wdetail.prempa        */    
    "จำนวนที่นั่ง"
    "ความเสียหายต่อคน"          /* wdetail.tp1           */    
    "ความเสียหายต่อครั้ง"       /* wdetail.tp2           */    
    "ความเสียหายต่อทรัพย์สิน"   /* wdetail.tp3            */ 
    "ประเภทความคุ้มครอง"        /* wdetail.covcod .  */ 
    "Producer"                              /*A57-0262*/        
    "Agent"                                 /*A57-0262*/        
    "ประเภทกรมธรรม์"                        /*A57-0262*/        
    "comment"                               /*A57-0262*/        
    "Receipt ID. Number "                   /*A57-0262*/        
    "Receipt Branch NAME"                   /*A57-0262*/        
    "Receipt Compulsory ID. Number"         /*A57-0262*/        
    "Receipt Compulsory Branch Name"        /*A57-0262*/
    "วันที่คุ้มครอง พรบ. "
    "วันที่สิ้นสุดความคุ้มครอง พรบ."
    "ทุนสูญหายและไฟไหม้"
    "รหัสรถ"
    "ลักษณะการใช้รถ"
    "ReceiptName72"         .
    A63-0210 */
    "deduct disc."   
    "ที่อยู่หน้าตาราง70"   
    "ที่อยู่หน้าตาราง70 กรณีไม่แยกที่อยู่"   
    "ตำบล"   
    "อำเภอ"   
    "จังหวัด    "   
    "รหัสไปรษณีย์"   
    "ที่อยู่หน้าตาราง72 "   
    "ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่"   
    "ตำบล"   
    "อำเภอ"   
    "จังหวัด"   
    "รหัสไปรษณีย์"   
    "Applicationtype"   
    "Applicationcode"   
    "Blank"   
    "แพคเกจ"   
    "จำนวนที่นั่ง"   
    "ความเสียหายต่อคน"   
    "ความเสียหายต่อครั้ง"   
    "ความเสียหายต่อทรัพย์สิน"   
    "ประเภทความคุ้มครอง"   
    "Producer"   
    "Agent"   
    "สาขา"   
    "ประเภทกรมธรรม์"   
    "Redbook"   
    "Price_Ford"   
    "Yea"   
    "Brand_Model"   
    "Receipt ID. Number"   
    "Receipt Branch NAME"   
    "Receipt Compulsory ID. Number"   
    "Receipt Compulsory Branch Name"   
    "วันที่คุ้มครอง พรบ."   
    "วันที่สิ้นสุดความคุ้มครอง พรบ."   
    "ทุนสูญหายและไฟไหม้"   
    "รหัสรถ"   
    "ลักษณะการใช้รถ"   
    "ลำดับผู้ขับขี่คนที่ 1"   
    "ชื่อผู้ขับขี่1"   
    "วันเกิด1"   
    "อาชีพผู้ขับขี่คนที่ 1"   
    "ตำแหน่งงานผู้ขับขี่คนที่ 1"        
    "ลำดับผู้ขับขี่คนที่ 2"   
    "ชื่อผู้ขับขี่2"   
    "วันเกิด2"   
    "อาชีพผู้ขับขี่คนที่ 2"   
    "ตำแหน่งงานผู้ขับขี่คนที่ 2"        
    "ลำดับผู้ขับขี่คนที่ 3"   
    "ชื่อผู้ขับขี่คนที่ 3"   
    "วันเดือนปีเกิดผู้ขับขี่คนที่ 3"            
    "อาชีพผู้ขับขี่คนที่ 3"   
    "ตำแหน่งงานผู้ขับขี่คนที่ 3"        
    "BLANK"   
    "ชื่อที่ใช้บนใบเสร็จ(พรบ.)"       
    "อุปกรณ์เสริมพิเศษ"   
    "ReceiptName72"   
    "ReceiptAddr1"   
    "comment" 
    /* A67-0087 */
    "ช่องทางการขาย    "               
    "รถยนต์ไฟฟ้า Y/N  "               
    "ลำดับผู้ขับขี่คนที่ 4 "          
    "ชื่อผู้ขับขี่คนที่ 4  "          
    "วันเดือนปีเกิดผู้ขับขี่คนที่4"   
    "อาชีพผู้ขับขี่คนที่ 4 "          
    "ตำแหน่งงานผู้ขับขี่คนที่ 4   "   
    "ลำดับผู้ขับขี่คนที่ 5 "          
    "ชื่อผู้ขับขี่คนที่ 5  "          
    "วันเดือนปีเกิดผู้ขับขี่คนที่5"   
    "อาชีพผู้ขับขี่คนที่ 5 "          
    "ตำแหน่งงานผู้ขับขี่คนที่ 5   "   
    "แคมเปญ     "                     
    "ส่งรูปแทนการตรวจสภาพรถY/N   "    
    "จำนวนเลขเครื่อง  "               
    "หมายเลขเครื่องยนต์ 2  "          
    "หมายเลขเครื่องยนต์ 3  "          
    "หมายเลขเครื่องยนต์ 4  "          
    "หมายเลขเครื่องยนต์ 5  "          
    "รหัส พ.ร.บ."                     
    "ยี่ห้อรถ   "   .

FOR EACH wdetail no-lock.
     FIND LAST wdetail2 WHERE wdetail2.nppolicy = trim(wdetail.policyno) NO-LOCK NO-ERROR NO-WAIT.
     IF  AVAIL wdetail2 THEN DO:
            RUN Pro_Receipt72. /*A60-0095*/
          /* comment by a60-0095...
           IF INDEX(wdetail.remark,"ดีลเลอร์แถมพ") <> 0 THEN DO:
           ASSIGN                      /* ดีลเลอร์ */
               nv_72Reciept = SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/") + 1,LENGTH(wdetail.remark)).
               IF INDEX(nv_72Reciept,"จำกัด") <> 0  THEN  ASSIGN
                  nv_72Reciept = SUBSTR(nv_72Reciept,1,R-INDEX(nv_72Reciept,"จำกัด") + 4). 
           ELSE ASSIGN wdetail.reciept72 = nv_72Reciept .
           END.   
           ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์แถมเบี้ยและพ") <> 0 THEN   DO:            /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
               ASSIGN            
               nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมพ.ร.บ.") <> 0 THEN    DO:                     /* ประกัน */
              ASSIGN    
              nv_72Reciept  =  "ธนาคารทิสโก้ จำกัด (มหาชน) ".                             /*"ธนาคารทิสโก้ จำกัด (มหาชน) "*/
            END.
           ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมเบี้ยและพ") <> 0 THEN   DO:              /* ทิสโก้ เบี้ย/พ.ร.บ.  */
              ASSIGN             
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมเบี้ย และพ") <> 0 THEN   DO:              /* ทิสโก้ เบี้ย (วรรค)/พ.ร.บ.  */
              ASSIGN             
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ประกันแถมพ") <> 0 THEN    DO:                    /* ประกัน */
               ASSIGN            
               nv_72Reciept =  TRIM(wdetail.tiname) + TRIM(wdetail.insnam).    /*ชื่อลูกค้า-*/
           END.                 
           ELSE IF INDEX(wdetail.remark,"ประกันแถมเบี้ยและพ") <> 0 THEN     DO:           /* ประกัน */
               ASSIGN            
               nv_72Reciept =  TRIM(wdetail.tiname) + TRIM(wdetail.insnam).     /*ชื่อลูกค้า-*/
            END.
           ELSE IF INDEX(wdetail.remark,"พ.ร.บ.ลูกค้าจ่าย") <> 0 THEN   DO:                     /* ลูกค้า */
              ASSIGN             
              nv_72Reciept =  TRIM(wdetail.tiname) + TRIM(wdetail.insnam).
            END.
           ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่ายเบี้ยและพ") <> 0 THEN    DO:            /* ลูกค้า เบี้ย/พ.ร.บ. */
              ASSIGN              
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่าย 2 ") <> 0 THEN    DO:            /* ลูกค้า เบี้ย/พ.ร.บ. */
                 ASSIGN              
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE nv_72Reciept = " ".
           .....end a60-0095....*/
         EXPORT DELIMITER "|" 
             wdetail.Pro_off   
             wdetail.cmr_code  
             wdetail.comcode   
             wdetail.policyno  
             /*wdetail.pol70  --A59-0618 --*/
             IF ra_matpoltyp = 2 THEN wdetail.pol70 ELSE IF ra_matpoltyp = 3 THEN wdetail.pol72 ELSE IF SUBSTR(wdetail.policyno,3,2) = "70" THEN wdetail.pol70 ELSE wdetail.pol72  /*--A59-0618 --*/
             wdetail.caryear   
             wdetail.eng       
             wdetail.chasno            
             wdetail.engcc                     
             wdetail.power                     
             wdetail.colorcode                 
             wdetail.vehreg 
             wdetail.garage                    
             wdetail.fleetper                  
             wdetail.ncb                       
             wdetail.orthper                   
             wdetail.vehuse                    
             wdetail.comdat                     
             wdetail.si                        
             wdetail.name_insur              
             wdetail.not_office              
             wdetail.entdat                 
             wdetail.enttim                  
             wdetail.not_code               
             wdetail.premt                  
             wdetail.comp_prm               
             wdetail.stk                    
             wdetail.brand                  
             wdetail.mail_add1              
             wdetail.tambon    
             wdetail.amper     
             wdetail.country   
             wdetail.tiname                 
             wdetail.insnam                
             wdetail.benname                
             wdetail.remark                 
             wdetail.Account_no                  
             wdetail.client_no                   
             wdetail.expdat                       
             wdetail.gap 
             wdetail.re_country  
             wdetail.RECP_NAME 
             wdetail.agent        
             wdetail.prev_insur   
             wdetail.prepol
                 /********
             wdetail.drivnam1
             wdetail.driag1  
             wdetail.drivnam2
             wdetail.driag2  
             wdetail.deduct 
             wdetail.branch 
             wdetail.prempa      
             wdetail.name2    /*A57-0017 add seat */
             wdetail.tp1    
             wdetail.tp2    
             wdetail.tp3    
             wdetail.covcod       /*  64  covcod  */ 
             wdetail2.nnproducer  /*  65  Producer    */                        
             wdetail2.nnagent     /*  66  Agent   */                            
             wdetail2.nnbranch    /*  67  Branch  */    
             wdetail2.nntyppol    /*  68  NEW/RENEW   */ 
             wdetail2.npid70      /*A57-0262*/   
             wdetail2.npid70br    /*A57-0262*/      
             wdetail2.npid72      /*A57-0262*/     
             wdetail2.npid72br    /*A57-0262*/ 
             wdetail2.npComdat             
             wdetail2.npExpdat             
             wdetail2.np_fi                
             wdetail2.npCode               
             wdetail2.npCaruse 
             /*nv_72Reciept*/   /*A60-0095*/
             wdetail.Reciept72 . /*A60-0095*/
             ******/    
             wdetail.deduct 
             wdetail2.np_add70 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             ""
             ""
             ""
             wdetail2.np_remark   
             wdetail.prempa
             wdetail.name2
             wdetail.tp1
             wdetail.tp2
             wdetail.tp3
             wdetail.covcod
             wdetail2.nnproducer
             wdetail2.nnagent
             wdetail.branch
             "" 
             "" 
             "" 
             ""
             ""
             wdetail2.npid70     
             wdetail2.npid70br      
             wdetail2.npid72       
             wdetail2.npid72br   
             wdetail2.npComdat             
             wdetail2.npExpdat             
             wdetail2.np_fi                
             wdetail2.npCode               
             wdetail2.npCaruse 
             ""
             wdetail.drivnam1
             wdetail.driag1
             "" 
             "" 
             ""
             wdetail.drivnam2
             wdetail.driag2  
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             wdetail2.np_remark
             wdetail2.np_Rec_name72
             wdetail2.np_remark
             wdetail2.np_Rec_name72
             wdetail2.np_Rec_add1
             wdetail2.nntyppol.
    END.
END.   */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK-Pro_matchfile_tlt C-Win 
PROCEDURE BK-Pro_matchfile_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by : A64-0271...
DEF VAR package AS CHAR FORMAT "x(5)" INIT "" .
DEF VAR nv_blank AS CHAR FORMAT "x(150)" INIT "" .   /*A64-0092*/
DEF VAR nv_acc   AS CHAR FORMAT "X(150)" INIT "" .    /*A64-0092*/
FOR EACH wdetail WHERE wdetail.chasno  <> " "  NO-LOCK.
    ASSIGN 
        nnid70    = ""   /*A57-0262*/    nv_blank  =  "" /*A64-0092*/
        nnidbr70  = ""   /*A57-0262*/    nv_acc    =  "" /*A64-0092*/
        nnid72    = ""   /*A57-0262*/    nnidbr72  = ""   /*A57-0262*/ 
        producer_mat    = ""             agent_mat       = "" 
        nv_messag       = ""             package         = ""
        n_compdat       = ""             n_exppdat       = ""
        n_fi            = ""             n_vehus         = ""
        n_class         = "" 
        nv_72Reciept    = "" 
        n_product       = ""  .  /*a61-0313*/
    FIND LAST wdetail3 WHERE 
        wdetail3.policyid  = wdetail.chasno   AND 
        wdetail3.poltyp    = wdetail.npoltyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wdetail3 THEN DO:
        IF wdetail3.poltyp = "v70" THEN
            ASSIGN 
            nnid70   = trim(wdetail3.ID_NO1)  
            nnidbr70 = trim(wdetail3.CLIENT_BRANCH)  .
        ELSE ASSIGN  
            nnid72    = trim(wdetail3.ID_NO1)         
            nnidbr72  = trim(wdetail3.CLIENT_BRANCH)
            nv_72Reciept = TRIM(wdetail3.RECEIPT_72)
            n_compdat    = wdetail3.comppdat
            n_exppdat    = wdetail3.exppdat
            n_comprem    = wdetail3.com_prem .
    END.  /* A55-0267 */
    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE                    /*kridtiya i. A54-0216 */
        /*brstat.tlt.cha_no =  wdetail.chasno   NO-ERROR NO-WAIT.*//*kridtiya i. A55-0184 */
        brstat.tlt.cha_no  =  wdetail.chasno AND                   /*kridtiya i. A55-0184 */
        brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.     /*kridtiya i. A55-0184 */
    IF AVAIL brstat.tlt THEN DO:
        ASSIGN 
            /* add A64-0092 */
            nv_acc        = IF index(brstat.tlt.filler2,"acc:") <> 0 THEN TRIM(Substr(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"acc:") + 4 )) 
                           ELSE IF index(brstat.tlt.filler2,"คค.") <> 0 THEN TRIM(Substr(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"คค."))) 
                           ELSE IF index(brstat.tlt.filler2,"||")  <> 0 THEN TRIM(Substr(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"||") + 2))
                           ELSE "" 
            /* end A64-0092 */
            nv_remark     = trim(brstat.tlt.filler2)
            nv_Rec        = brstat.tlt.comp_usr_ins
            nv_remark     = IF index(nv_remark,"//") = 0 THEN "" ELSE              /*A57-0262*/
                           trim(SUBSTR(nv_remark,index(nv_remark,"//") + 2 ))   /*A57-0262*/
            /*nv_remark    = REPLACE(nv_remark,"//","")     */
            nv_remark     = REPLACE(nv_remark,"r2:","")
            nv_remark     = REPLACE(nv_remark,"r3:","")                                  
            nv_remark     = REPLACE(nv_remark,"r4:","")                                
            nv_Rec_name72 = SUBSTR(nv_Rec,1,INDEX(nv_Rec,"a1:") - 1 )                               
            nv_Rec_add1   = SUBSTR(nv_Rec,INDEX(nv_Rec,"a1:") + 3 )                                 
            nv_Rec_add1   = REPLACE(nv_Rec_add1,"a2:","").

        IF trim(wdetail.prepol) <> "" AND trim(brstat.tlt.filler1) <> trim(wdetail.prepol) THEN 
            nv_messag = "เบอร์ต่ออายุไม่ตรงกัน กรุณาตรวจสอบข้อมูลอีกครั้ง !!" . /*a60-0095*/
        ELSE DO:  /*a60-0095*/
            ASSIGN nv_messag = "found by cha_no"  /* A55-0267 */
                   n_fi       = (SUBSTR(brstat.tlt.model,51,10))  
                   n_vehus    = (SUBSTR(brstat.tlt.expotim,5,4))    
                   n_class    = (SUBSTR(brstat.tlt.expousr,7,3))  .  
           
            IF (INDEX(brstat.tlt.releas,"yes") <> 0 ) THEN ASSIGN nv_messag = "stat Yes".
            /*ELSE DO:*/  /*A56-0012 ...*/
            IF  wdetail.npoltyp    = "v72" THEN DO:
                FIND FIRST wcomp WHERE wcomp.premcomp = brstat.tlt.comp_grprm NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN ASSIGN package = wcomp.package .
                ELSE package = "".
                IF index(brstat.tlt.brand,"ISUZU") <> 0 AND index(brstat.tlt.expotim,"210") <> 0 THEN package = "140A". /*A60-0095*/
            END.
            ELSE package = "".
        END. /*a60-0095*/
        RUN  proc_matchagent. /*A60-0095*/
        RUN  proc_addrtis. /*A64-0271*/
      
        EXPORT DELIMITER "|" 
            trim(brstat.tlt.rec_addr3)    
            trim(brstat.tlt.rec_addr4)    
            trim(brstat.tlt.subins)       
            wdetail.policyno  
            trim(brstat.tlt.lince2)           
            trim(brstat.tlt.eng_no)           
            trim(wdetail.chasno)                   
            trim(string(brstat.tlt.cc_weight))                
            trim(string(brstat.tlt.rencnt))                   
            trim(brstat.tlt.colorcod)                         
            IF wdetail.vehreg = "" THEN trim(brstat.tlt.lince1) ELSE TRIM(wdetail.vehreg)           
            trim(brstat.tlt.stat)                              
            trim(string(brstat.tlt.lotno))                     
            trim(string(brstat.tlt.seqno))                     
            trim(string(brstat.tlt.endcnt))                    
            IF INDEX(wdetail.policyno,"TC70") <> 0 THEN SUBSTR(brstat.tlt.model,1,50) ELSE "" /*SUBSTR(brstat.tlt.model,1,10)  -- A60-0118--*/
            IF wdetail.comdat = "" THEN STRING(brstat.tlt.nor_effdat) ELSE substr(trim(wdetail.comdat),7,2) + "/" + substr(trim(wdetail.comdat),5,2) + "/" + substr(trim(wdetail.comdat),1,4)             /*trim(string(brstat.tlt.gendat))  */ /*A57-0262  comdat */      
            trim(string(brstat.tlt.nor_coamt))                 
            wdetail.idno  /*trim(tlt.nor_usr_ins) */  /*A55-0365*/                  
            trim(brstat.tlt.nor_usr_tlt)                     
            /*trim(string(brstat.tlt.entdat))*/  /*A61-0410*/              
            /*trim(string(brstat.tlt.enttim))*/  /*A61-0410*/
            trim(string(tlt.datesent))           /*A61-0410*/  
            trim(string(tlt.gentim))             /*A61-0410*/  
            trim(string(brstat.tlt.comp_usr_tlt))            
            trim(string(brstat.tlt.nor_grprm))               
            trim(string(brstat.tlt.comp_grprm))             
            IF wdetail.stk = "" THEN trim(brstat.tlt.comp_sck) ELSE TRIM(wdetail.stk)                       
            trim(brstat.tlt.brand)                           
            wdetail.mail_add1              
            wdetail.tambon    
            wdetail.amper     
            wdetail.country
            /*trim(wdetail.tambon) + " " + trim(wdetail.amper) + " " + trim(wdetail.country)*/
            trim(wdetail.tiname)              
            trim(wdetail.insnam)        
            /*wdetail.name2 */ 
            trim(brstat.tlt.safe1)                             
            (trim(brstat.tlt.filler2) + " [" + trim(nv_file1) + " : " + trim(nv_file2) + "]"   )                      
            wdetail.Account_no    /*trim(tlt.safe2) */  /*A55-0365*/                           
            trim(brstat.tlt.safe3) 
            IF wdetail.expdat = "" THEN string(brstat.tlt.comp_effdat) ELSE substr(trim(wdetail.EXPdat),7,2) + "/" + substr(trim(wdetail.EXPdat),5,2) + "/" + substr(trim(wdetail.EXPdat),1,4)   /*trim(string(brstat.tlt.expodat)) */ /*A57-0262expidat */ 
            trim(string(brstat.tlt.comp_coamt))  
            wdetail.re_country  
            wdetail.RECP_NAME 
            trim(brstat.tlt.recac)                          
            trim(brstat.tlt.rec_addr2)                
            replace(trim(brstat.tlt.rec_addr5),"*","")
            trim(brstat.tlt.endno)  
            /* str A63-0210
            brstat.tlt.dri_name1                      
            IF brstat.tlt.dri_no1 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no1)                       
            brstat.tlt.dri_name2                      
            IF brstat.tlt.dri_no2 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no2)
            trim(brstat.tlt.endno)                    
            trim(brstat.tlt.EXP)                      
            /*IF INDEX(brstat.tlt.rec_addr2,"SAFETY") <> 0 THEN "" ELSE IF package = "" THEN substr(trim(brstat.tlt.expotim),1,5) ELSE package */ /*A60-0095*/
            substr(trim(brstat.tlt.expotim),1,5) /*A60-0095*/
            brstat.tlt.sentcnt             /*A57-0017*/
            trim(brstat.tlt.old_eng)                  
            trim(brstat.tlt.old_cha)                  
            trim(brstat.tlt.comp_pol)                 
            substr(trim(brstat.tlt.expousr),1,3)                  
            trim(tlt.comp_sub)        /*trim(producer_mat) */  /*A60-0095*/              
            trim(tlt.comp_noti_ins)   /*TRIM(agent_mat)    */  /*A60-0095*/             
            IF brstat.tlt.flag = "n" THEN "NEW" ELSE "RENEW" 
            nv_messag
            nnid70       /*A57-0262*/  
            nnidbr70     /*A57-0262*/  
            nnid72       /*A57-0262*/  
            nnidbr72 
            IF brstat.tlt.nor_effdat = ?  THEN ""  ELSE STRING(brstat.tlt.nor_effdat,"99/99/9999")     /* คุ้มครอง พรบ. */
            IF brstat.tlt.comp_effdat = ? THEN "" ELSE STRING(brstat.tlt.comp_effdat,"99/99/9999")            /* สิ้นสุดคุ้มครอง พรบ. */
            (SUBSTR(brstat.tlt.model,51,10))
            (SUBSTR(brstat.tlt.expotim,5,4))
            (SUBSTR(brstat.tlt.expousr,7,3))
            ""    /*nv_72Reciept */ /*A60-0095*/  
            nv_remark    
            nv_Rec_name72
            nv_Rec_add1 
            End A63-0210 */ 
            brstat.tlt.ins_addr3
            ""
            ""
            ""
            ""
            ""
            brstat.tlt.ins_addr4
            ""
            ""
            ""
            ""
            ""
            brstat.tlt.ins_addr5     
            brstat.tlt.comp_noti_tlt 
            nv_remark    
            substr(trim(brstat.tlt.expotim),1,5)  
            brstat.tlt.sentcnt                    
            trim(brstat.tlt.old_eng)                  
            trim(brstat.tlt.old_cha)                  
            trim(brstat.tlt.comp_pol)                 
            substr(trim(brstat.tlt.expousr),1,3)                  
            trim(tlt.comp_sub)                  
            trim(tlt.comp_noti_ins)            
            trim(brstat.tlt.EXP)                      
            IF brstat.tlt.flag = "n" THEN "NEW" ELSE "RENEW" 
            ""                           
            ""
            ""
            ""
            nnid70       
            nnidbr70     
            nnid72       
            nnidbr72 
            IF brstat.tlt.nor_effdat = ?  THEN ""  ELSE STRING(brstat.tlt.nor_effdat,"99/99/9999")   
            IF brstat.tlt.comp_effdat = ? THEN "" ELSE STRING(brstat.tlt.comp_effdat,"99/99/9999")   
            (SUBSTR(brstat.tlt.model,51,10))
            (SUBSTR(brstat.tlt.expotim,5,4))
            (SUBSTR(brstat.tlt.expousr,7,3))
            ""
            brstat.tlt.dri_name1                      
            IF brstat.tlt.dri_no1 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no1)                       
            ""
            ""
            ""
            brstat.tlt.dri_name2                      
            IF brstat.tlt.dri_no2 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no2)
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            nv_acc  /*nv_remark */  /*A64-0092*/
            nv_Rec_name72
            nv_acc  /*nv_remark  */ /*A64-0092*/  
            nv_Rec_name72
            nv_Rec_add1  
            nv_messag
             .
                   
        /*END.*/ /*A56-0012 */
    END.
    IF nv_messag = "" THEN RUN pro_matchfile_tlt1.  /*by name    *//* A55-0267 */
    IF (nv_messag = "") 
        /*OR (nv_messag = "stat Yes")*/ THEN DO:                      /*not found  *//* A55-0267 */
        /*RUN pro_matchfile_tltyes.*/
        EXPORT DELIMITER "|" 
             /*wdetail.Pro_off   
             wdetail.cmr_code     
             wdetail.comcode     
             wdetail.policyno  
             wdetail.caryear    
             wdetail.eng       
             wdetail.chasno        
             wdetail.engcc                 
             wdetail.power                 
             wdetail.colorcode             
             wdetail.vehreg    
             wdetail.garage                 
             wdetail.fleetper               
             wdetail.ncb                    
             wdetail.orthper                
             wdetail.vehuse                 
             wdetail.comdat                  
             wdetail.si                     
             wdetail.idno                /*wdetail.name_insur */           
             wdetail.not_office            
             wdetail.entdat              
             wdetail.enttim               
             wdetail.not_code              
             wdetail.premt                
             wdetail.comp_prm             
             wdetail.stk                  
             wdetail.brand                
             wdetail.mail_add1              
             wdetail.tambon    
             wdetail.amper     
             wdetail.country   
             wdetail.tiname                 
             wdetail.insnam               
             /*wdetail.name2 */                 
             wdetail.benname                   
             (wdetail.remark + " " + trim(nv_file1) + "_" + trim(nv_file2))                    
             wdetail.Account_no                 
             wdetail.client_no                  
             wdetail.expdat                      
             wdetail.gap          
             wdetail.re_country  
             wdetail.RECP_NAME 
             wdetail.agent        
             wdetail.prev_insur   
             wdetail.prepol       
             wdetail.drivnam1     
             wdetail.driag1       
             wdetail.drivnam2     
             wdetail.driag2       
             wdetail.deduct       
             wdetail.branch       
             substr(wdetail.prempa,1,5)
             "" 
             wdetail.tp1          
             wdetail.tp2          
             wdetail.tp3          
             substr(wdetail.covcod,1,3)       
             ""    
             ""        
             ""           /*wdetail.typpol  */ /*A57-0282*/
             nv_messag     
             nnid70       /*A57-0262*/  
             nnidbr70     /*A57-0262*/  
             nnid72       /*A57-0262*/  
             nnidbr72     /*A57-0262*/
             IF n_compdat = ? OR n_compdat = "" THEN "" ELSE n_compdat 
             IF n_exppdat = ? OR n_exppdat = "" THEN "" ELSE n_exppdat 
             n_fi    
             n_vehus 
             n_class*/
             /*nv_72Reciept*/  /*A60-0095*/
            wdetail.Pro_off   
            wdetail.cmr_code     
            wdetail.comcode     
            wdetail.policyno  
            wdetail.caryear    
            wdetail.eng       
            wdetail.chasno        
            wdetail.engcc                 
            wdetail.power                 
            wdetail.colorcode             
            wdetail.vehreg    
            wdetail.garage                 
            wdetail.fleetper               
            wdetail.ncb                    
            wdetail.orthper                
            wdetail.vehuse                 
            wdetail.comdat                  
            wdetail.si                     
            wdetail.idno                        
            wdetail.not_office            
            wdetail.entdat              
            wdetail.enttim               
            wdetail.not_code              
            wdetail.premt                
            wdetail.comp_prm             
            wdetail.stk                  
            wdetail.brand                
            wdetail.mail_add1              
            wdetail.tambon   
            wdetail.amper   
            wdetail.country    
            wdetail.tiname                 
            wdetail.insnam               
            /*""*/
            wdetail.benname                   
            (wdetail.remark + " " + trim(nv_file1) + "_" + trim(nv_file2))                    
            wdetail.Account_no                 
            wdetail.client_no                  
            wdetail.expdat                      
            wdetail.gap          
            wdetail.re_country  
            wdetail.RECP_NAME 
            wdetail.agent        
            wdetail.prev_insur   
            wdetail.prepol       
            wdetail.deduct       
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            substr(wdetail.prempa,1,5)
            ""
            wdetail.tp1          
            wdetail.tp2          
            wdetail.tp3          
            substr(wdetail.covcod,1,3)       
            ""
            ""
            wdetail.branch       
            ""
            ""
            ""
            ""
            ""
            nnid70      
            nnidbr70    
            nnid72      
            nnidbr72    
            IF n_compdat = ? OR n_compdat = "" THEN "" ELSE n_compdat 
            IF n_exppdat = ? OR n_exppdat = "" THEN "" ELSE n_exppdat 
            n_fi    
            n_vehus 
            n_class
            ""
            wdetail.drivnam1     
            wdetail.driag1       
            ""
            ""
            ""
            wdetail.drivnam2     
            wdetail.driag2       
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            nv_messag .   
    END.
    ASSIGN nv_messag = "".
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK-pro_matchfile_tlt1 C-Win 
PROCEDURE BK-pro_matchfile_tlt1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A64-0271..
DEF VAR nv_blank AS CHAR FORMAT "x(150)" INIT "" .   /*A64-0092*/
DEF VAR nv_acc   AS CHAR FORMAT "X(150)" INIT "" .    /*A64-0092*/

FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
    brstat.tlt.ins_name = Trim(wdetail.insnam) AND             
    brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.     
IF AVAIL brstat.tlt THEN DO:
    IF trim(wdetail.prepol) <> "" AND trim(brstat.tlt.filler1) <> trim(wdetail.prepol) THEN 
        nv_messag = "เบอร์ต่ออายุไม่ตรงกัน กรุณาตรวจสอบข้อมูลอีกครั้ง !!" . /*a60-0095*/
    ELSE ASSIGN nv_messag = "found by name".
     
    ASSIGN  nv_acc        =  "" /*A64-0092*/  
            /*A64-0092*/
            nv_acc        = IF INDEX(brstat.tlt.filler2,"r4:") <> 0 THEN SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"r4:") + 3) 
                            ELSE IF INDEX(brstat.tlt.filler2,"คค.") <> 0 THEN SUBSTR(brstat.tlt.filler2,INDEX(brstat.tlt.filler2,"คค."),LENGTH(brstat.tlt.filler2))  
                            ELSE "" 
            /* end A64-0092 */
            nv_remark     = trim(brstat.tlt.filler2)
            nv_Rec        = brstat.tlt.comp_usr_ins
            nv_remark     = IF index(nv_remark,"//") = 0 THEN "" ELSE              /*A57-0262*/
                            trim(SUBSTR(nv_remark,index(nv_remark,"//") + 2 ))   /*A57-0262*/
            /*nv_remark    = REPLACE(nv_remark,"//","")     */
            nv_remark     = REPLACE(nv_remark,"r2:","")
            nv_remark     = REPLACE(nv_remark,"r3:","")                                  
            nv_remark     = REPLACE(nv_remark,"r4:","")                                
            nv_Rec_name72 = SUBSTR(nv_Rec,1,INDEX(nv_Rec,"a1:") - 1 )                               
            nv_Rec_add1   = SUBSTR(nv_Rec,INDEX(nv_Rec,"a1:") + 3 )                                 
            nv_Rec_add1   = REPLACE(nv_Rec_add1,"a2:","").

       /* nv_chaidrep  = ""
        nv_chaidrep  = tlt.comp_usr_tlt .
    ASSIGN 
        nnidbr72       = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72br:") + 7 ))   /*A57-0262*/
        nv_chaidrep    = IF index(nv_chaidrep,"ID72br:") = 0 THEN "" ELSE              /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72br:") - 1 ))  /*A57-0262*/ 
        nnid72         = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                                                           /*A57-0262*/  
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID72:") + 5 ))      /*A57-0262*/
        nv_chaidrep    = IF index(nv_chaidrep,"ID72:") = 0 THEN "" ELSE                 /*A57-0262*/
                         trim(SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID72:") - 1 ))    /*A57-0262*/
        nnidbr70       = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE 
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70br:") + 7 ))    /*A57-0262*/ 
        nv_chaidrep    = IF index(nv_chaidrep,"ID70br:") = 0 THEN "" ELSE               /*A57-0262*/
                         trim( SUBSTR(nv_chaidrep,1,index(nv_chaidrep,"ID70br:") - 1 )) /*A57-0262*/
        nnid70         = IF index(nv_chaidrep,"ID70:") = 0 THEN "" ELSE 
                         trim(SUBSTR(nv_chaidrep,index(nv_chaidrep,"ID70:") + 5 ))  .    /*A57-0262*/ */
    /*IF INDEX(tlt.releas,"yes") = 0 THEN DO: 
    IF tlt.releas = "" THEN
            ASSIGN tlt.releas =  "yes".
        ELSE DO:  
            IF INDEX(tlt.releas,"cancel") = 0 THEN 
                ASSIGN tlt.releas = "yes".
            ELSE ASSIGN tlt.releas = "cancel/yes".
        END.
    END.*/
    /* comment by A60-0095...........
    IF      (brstat.tlt.flag = "n") AND (INDEX(trim(brstat.tlt.brand),"Ford Ranger") <> 0 )  THEN 
        ASSIGN producer_mat  = fi_producernewf   agent_mat = fi_agentnewfo  .
    /* start : A59-0618*/
    ELSE IF (brstat.tlt.flag = "n") AND (INDEX(trim(brstat.tlt.brand),"Ford") <> 0 )  THEN 
            ASSIGN producer_mat  = fi_producernewf2   agent_mat = fi_agentnewfo2  .
    ELSE IF (brstat.tlt.flag = "n") AND (INDEX(trim(brstat.tlt.brand),"Mazda") <> 0 )  THEN  
        ASSIGN producer_mat  = fi_producerma   agent_mat = fi_agentma .
    ELSE IF (brstat.tlt.flag = "n") AND (INDEX(trim(brstat.tlt.brand),"ISUZU SPARK 1.9") <> 0 )  THEN 
            ASSIGN producer_mat  = fi_producernewtis agent_mat = fi_agentnewtis.
    ELSE IF (brstat.tlt.flag = "n") AND (INDEX(trim(brstat.tlt.brand),"ISUZU") <> 0 )  THEN 
        ASSIGN producer_mat  = fi_produceris   agent_mat = fi_agentis  .
    /* end : A59-0618*/
    ELSE IF (brstat.tlt.flag = "n")  THEN ASSIGN producer_mat  = fi_producernewtis agent_mat = fi_agentnewtis .
    ELSE IF (INDEX(trim(brstat.tlt.brand),"Ford") <> 0 )        THEN ASSIGN producer_mat  = fi_producerford   agent_mat = fi_agentford .
    ELSE IF (INDEX(trim(brstat.tlt.brand),"Mazda") <> 0 )       THEN ASSIGN producer_mat  = fi_producermar    agent_mat = fi_agentmar.  /*A59-0618*/
    ELSE IF INDEX(trim(trim(brstat.tlt.safe1)),"ระบุ 8.3") <> 0 THEN ASSIGN producer_mat  = fi_producer83     agent_mat = fi_agent83  .
    ELSE ASSIGN producer_mat  = fi_producerno83   agent_mat     = fi_agentno83  .
    ...end A60-0095....*/
    /*IF (INDEX(brstat.tlt.releas,"yes") <> 0 )  THEN ASSIGN nv_messag   = nv_messag + "stat Yes".*/  /*A60-0095*/
    RUN  proc_matchagent. /*A60-0095*/
    RUN  proc_addrtis.    /*A64-0271*/
    IF (INDEX(brstat.tlt.releas,"yes") <> 0 )  THEN ASSIGN nv_messag   = IF nv_messag = "" THEN "stat Yes" ELSE nv_messag + "/ stat Yes". /*A60-0095*/
    ELSE DO:
        EXPORT DELIMITER "|" 
            trim(brstat.tlt.rec_addr3)    
            trim(brstat.tlt.rec_addr4)    
            trim(brstat.tlt.subins)       
            wdetail.policyno  
            trim(brstat.tlt.lince2)           
            trim(brstat.tlt.eng_no)           
            trim(wdetail.chasno)                   
            trim(string(brstat.tlt.cc_weight))                
            trim(string(brstat.tlt.rencnt))                   
            trim(brstat.tlt.colorcod)                         
            IF wdetail.vehreg = "" THEN trim(brstat.tlt.lince1) ELSE TRIM(wdetail.vehreg)           
            trim(brstat.tlt.stat)                              
            trim(string(brstat.tlt.lotno))                     
            trim(string(brstat.tlt.seqno))                     
            trim(string(brstat.tlt.endcnt))                    
            IF INDEX(wdetail.policyno,"TC70") <> 0 THEN SUBSTR(brstat.tlt.model,1,50) ELSE "" /*SUBSTR(brstat.tlt.model,1,10)  -- A60-0118--*/
            IF wdetail.comdat = "" THEN STRING(brstat.tlt.nor_effdat) ELSE substr(trim(wdetail.comdat),7,2) + "/" + substr(trim(wdetail.comdat),5,2) + "/" + substr(trim(wdetail.comdat),1,4)             /*trim(string(brstat.tlt.gendat))  */ /*A57-0262  comdat */      
            trim(string(brstat.tlt.nor_coamt))                 
            wdetail.idno  /*trim(tlt.nor_usr_ins) */  /*A55-0365*/                  
            trim(brstat.tlt.nor_usr_tlt)                     
            /*trim(string(brstat.tlt.entdat))*/  /*A61-0410*/              
            /*trim(string(brstat.tlt.enttim))*/  /*A61-0410*/
            trim(string(tlt.datesent))           /*A61-0410*/  
            trim(string(tlt.gentim))             /*A61-0410*/  
            trim(string(brstat.tlt.comp_usr_tlt))            
            trim(string(brstat.tlt.nor_grprm))               
            trim(string(brstat.tlt.comp_grprm))             
            IF wdetail.stk = "" THEN trim(brstat.tlt.comp_sck) ELSE TRIM(wdetail.stk)                       
            trim(brstat.tlt.brand)                           
            wdetail.mail_add1              
            /*wdetail.tambon  str A63-0210  
            wdetail.amper     
            wdetail.country   end A63-0210*/
            trim(wdetail.tambon) 
            trim(wdetail.amper) 
            trim(wdetail.country)
            trim(wdetail.tiname)              
            trim(wdetail.insnam)        
            /*wdetail.name2 */ 
           /* ""   */
            trim(brstat.tlt.safe1)                             
            (trim(brstat.tlt.filler2) + " [" + trim(nv_file1) + " : " + trim(nv_file2) + "]"   )                      
            wdetail.Account_no    /*trim(tlt.safe2) */  /*A55-0365*/                           
            trim(brstat.tlt.safe3) 
            IF wdetail.expdat = "" THEN string(brstat.tlt.comp_effdat) ELSE substr(trim(wdetail.EXPdat),7,2) + "/" + substr(trim(wdetail.EXPdat),5,2) + "/" + substr(trim(wdetail.EXPdat),1,4)   /*trim(string(brstat.tlt.expodat)) */ /*A57-0262expidat */ 
            trim(string(brstat.tlt.comp_coamt))  
            wdetail.re_country  
            wdetail.RECP_NAME 
            trim(brstat.tlt.recac)                          
            trim(brstat.tlt.rec_addr2)                
            replace(trim(brstat.tlt.rec_addr5),"*","")
            trim(brstat.tlt.endno)   
            /* str A63-0210
            brstat.tlt.dri_name1                      
            IF brstat.tlt.dri_no1 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no1)                       
            brstat.tlt.dri_name2                      
            IF brstat.tlt.dri_no2 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no2)
            trim(brstat.tlt.endno)                    
            trim(brstat.tlt.EXP)                      
            /*IF INDEX(brstat.tlt.rec_addr2,"SAFETY") <> 0 THEN "" ELSE IF package = "" THEN substr(trim(brstat.tlt.expotim),1,5) ELSE package */ /*A60-0095*/
            substr(trim(brstat.tlt.expotim),1,5) /*A60-0095*/
            brstat.tlt.sentcnt             /*A57-0017*/
            trim(brstat.tlt.old_eng)                  
            trim(brstat.tlt.old_cha)                  
            trim(brstat.tlt.comp_pol)                 
            substr(trim(brstat.tlt.expousr),1,3)                  
            trim(tlt.comp_sub)        /*trim(producer_mat) */  /*A60-0095*/              
            trim(tlt.comp_noti_ins)   /*TRIM(agent_mat)    */  /*A60-0095*/             
            IF brstat.tlt.flag = "n" THEN "NEW" ELSE "RENEW" 
            nv_messag
            nnid70       /*A57-0262*/  
            nnidbr70     /*A57-0262*/  
            nnid72       /*A57-0262*/  
            nnidbr72 
            IF brstat.tlt.nor_effdat = ?  THEN ""  ELSE STRING(brstat.tlt.nor_effdat,"99/99/9999")     /* คุ้มครอง พรบ. */
            IF brstat.tlt.comp_effdat = ? THEN "" ELSE STRING(brstat.tlt.comp_effdat,"99/99/9999")            /* สิ้นสุดคุ้มครอง พรบ. */
            (SUBSTR(brstat.tlt.model,51,10))
            (SUBSTR(brstat.tlt.expotim,5,4))
            (SUBSTR(brstat.tlt.expousr,7,3))
            ""    /*nv_72Reciept */ /*A60-0095*/  
            nv_remark    
            nv_Rec_name72
            nv_Rec_add1 
            end A63-0210 */ 
            brstat.tlt.ins_addr3
            ""
            ""
            ""
            ""
            ""
            brstat.tlt.ins_addr4
            ""
            ""
            ""
            ""
            ""
            brstat.tlt.ins_addr5     
            brstat.tlt.comp_noti_tlt 
            nv_remark    
            substr(trim(brstat.tlt.expotim),1,5)  
            brstat.tlt.sentcnt                    
            trim(brstat.tlt.old_eng)                  
            trim(brstat.tlt.old_cha)                  
            trim(brstat.tlt.comp_pol)                 
            substr(trim(brstat.tlt.expousr),1,3)                  
            trim(tlt.comp_sub)                  
            trim(tlt.comp_noti_ins)            
            trim(brstat.tlt.EXP)                      
            IF brstat.tlt.flag = "n" THEN "NEW" ELSE "RENEW" 
            ""                           
            ""
            ""
            ""
            nnid70       
            nnidbr70     
            nnid72       
            nnidbr72 
            IF brstat.tlt.nor_effdat = ?  THEN ""  ELSE STRING(brstat.tlt.nor_effdat,"99/99/9999")   
            IF brstat.tlt.comp_effdat = ? THEN "" ELSE STRING(brstat.tlt.comp_effdat,"99/99/9999")   
            (SUBSTR(brstat.tlt.model,51,10))
            (SUBSTR(brstat.tlt.expotim,5,4))
            (SUBSTR(brstat.tlt.expousr,7,3))
            ""
            brstat.tlt.dri_name1                      
            IF brstat.tlt.dri_no1 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no1)                       
            ""
            ""
            ""
            brstat.tlt.dri_name2                      
            IF brstat.tlt.dri_no2 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no2)
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            nv_acc /*nv_remark   */ /*A64-0092*/
            nv_Rec_name72
            nv_acc /*nv_remark   */ /*a64-0092*/
            nv_Rec_name72
            nv_Rec_add1  
            nv_messag .
    END.
END.
...end A64-0271...*/
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
  DISPLAY fi_year ra_matpoltyp fi_producernewf fi_agentnewfo fi_producernewtis 
          fi_agentnewtis fi_producerford fi_agentford fi_producerno83 
          fi_agentno83 fi_producer83 fi_agent83 fi_filename fi_filename2 
          fi_outfile ra_matchpol fi_packcom fi_loadname fi_outload fi_premcomp 
          fi_produceris fi_agentis fi_producernewf2 fi_agentnewfo2 fi_producerMI 
          fi_agentMI fi_producerNCIR fi_agentNCIR fi_producerCIR fi_agentCIR 
          fi_pdtkcode fi_agtkcode fi_pdbkcode fi_agbkcode fi_producerTF 
          fi_agentTF fi_producerf2y fi_agentf2y fi_producerhv fi_agenthv 
          fi_producerns fi_agentns fi_producerns2 fi_agentns2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_year ra_matpoltyp fi_producernewf fi_agentnewfo fi_producernewtis 
         fi_agentnewtis fi_producerford fi_agentford fi_producerno83 
         fi_agentno83 fi_producer83 fi_agent83 fi_filename fi_filename2 
         fi_outfile br_comp ra_matchpol bu_add bu_del fi_packcom fi_loadname 
         bu_ok bu_exit bu_file bu_file2 fi_outload bu_file-3 bu_ok2 bu_exit-2 
         fi_premcomp fi_produceris fi_agentis fi_producernewf2 fi_agentnewfo2 
         fi_producerMI fi_agentMI fi_producerNCIR fi_agentNCIR fi_producerCIR 
         fi_agentCIR fi_pdtkcode fi_agtkcode fi_pdbkcode fi_agbkcode 
         fi_producerTF fi_agentTF fi_producerf2y fi_agentf2y fi_producerhv 
         fi_agenthv fi_producerns fi_agentns fi_producerns2 fi_agentns2 RECT-76 
         RECT-77 RECT-381 RECT-382 RECT-383 RECT-384 RECT-385 RECT-386 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addrtis C-Win 
PROCEDURE proc_addrtis :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length   AS INT.

DO:
        ASSIGN
         n_build    = "" 
         n_tambon   = ""          
         n_amper    = ""          
         n_country  = ""          
         n_post     = "".  

       IF      INDEX(n_address,"บมจ." ) <> 0 THEN n_address = REPLACE(n_address,"บมจ.","บมก.") . /*A65-0035*/
       ELSE IF INDEX(n_address,"บจ." )  <> 0 THEN n_address = REPLACE(n_address,"บจ.","บก.") .   /*A65-0035*/

       IF INDEX(n_address,"จ." ) <> 0 THEN DO: 
           ASSIGN 
           n_country  =  TRIM(SUBSTR(n_address,INDEX(n_address,"จ."),LENGTH(n_address)))
           n_length   =  LENGTH(n_country)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
       
           n_country  =  IF index(n_country,"จ. ") <> 0 THEN  trim(REPLACE(n_country,"จ. ","จ.")) ELSE TRIM(n_country)
           n_length   =  LENGTH(n_country)
           n_post     =  IF INDEX(n_country," ")  <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
           n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
       
           n_country  =  trim(REPLACE(n_country,"จ.","จังหวัด")) .
       END.
       ELSE IF INDEX(n_address,"จังหวัด" ) <> 0  AND n_country = "" THEN DO: 
           ASSIGN 
           n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address)))
           n_length   =  LENGTH(n_country)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
           n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post))).
       END.
       ELSE IF INDEX(n_address,"กทม" ) <> 0 AND n_country = "" THEN DO: 
           ASSIGN 
           n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address)))
           n_length   =  LENGTH(n_country)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
           n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post)))
           n_country  =  "กรุงเทพมหานคร".
       END.
       ELSE IF INDEX(n_address,"กรุงเทพ" ) <> 0 AND n_country = "" THEN DO: 
           ASSIGN 
           n_country  =  trim(SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address)))
           n_length   =  LENGTH(n_country)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
           n_country  =  trim(SUBSTR(n_country,1,n_length - LENGTH(n_post)))
           n_country  =  "กรุงเทพมหานคร".
       END.
       ELSE IF INDEX(n_address," " ) <> 0 AND n_country = "" THEN DO: 
           ASSIGN 
           n_post     =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
           n_length   =  LENGTH(n_post)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_country  =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
           n_length   =  LENGTH(n_country)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_country  =  "จังหวัด" + (n_country).
       END.
       
       IF INDEX(n_address,"อ." ) <> 0 THEN DO: 
           ASSIGN 
           n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"อ."),LENGTH(n_address)))
           n_length   =  LENGTH(n_amper)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_amper    =  trim(REPLACE(n_amper,"อ.","อำเภอ")).
       END.
       ELSE IF INDEX(n_address,"อำเภอ" ) <> 0  AND n_amper  = "" THEN DO: 
           ASSIGN 
           n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"อำเภอ"),LENGTH(n_address)))
           n_length   =  LENGTH(n_amper)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
       END.
       ELSE IF INDEX(n_address,"เขต" ) <> 0  AND n_amper  = "" THEN DO: 
           ASSIGN 
           n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"เขต"),LENGTH(n_address)))
           n_length   =  LENGTH(n_amper)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
       END.
       ELSE IF INDEX(n_address,"ข." ) <> 0 AND n_amper  = "" THEN DO: 
           ASSIGN 
           n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address,"ข."),LENGTH(n_address)))
           n_length   =  LENGTH(n_amper)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_amper    =  trim(REPLACE(n_amper,"ข.","เขต")).
       END.
       ELSE IF INDEX(n_address," " ) <> 0 AND n_amper  = "" THEN DO: 
           ASSIGN 
           n_amper    =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
           n_length   =  LENGTH(n_amper)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_amper    =  IF index(n_country,"กรุงเทพ") <> 0 THEN  "เขต" + (n_amper) ELSE "อำเภอ" + trim(n_amper).
       END.
       
       IF INDEX(n_address,"ต." ) <> 0 THEN DO: 
           ASSIGN 
           n_tambon   =  trim(SUBSTR(n_address,R-INDEX(n_address,"ต."),LENGTH(n_address)))
           n_length   =  LENGTH(n_tambon)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_tambon   =  trim(REPLACE(n_tambon,"ต.","ตำบล")).
       END.
       ELSE IF INDEX(n_address,"ตำบล" ) <> 0 AND n_tambon  =  "" THEN DO: 
           ASSIGN 
           n_tambon   =  trim(SUBSTR(n_address,R-INDEX(n_address,"ตำบล"),LENGTH(n_address)))
           n_length   =  LENGTH(n_tambon)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
       END.
       ELSE IF INDEX(n_address,"แขวง" ) <> 0  AND n_tambon  =  "" THEN DO: 
           ASSIGN 
           n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address)))
           n_length   =  LENGTH(n_tambon)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length)).
       END.
       ELSE IF INDEX(n_address,"ขว." ) <> 0 AND n_tambon  =  "" THEN DO: 
           ASSIGN 
           n_tambon   =  trim(SUBSTR(n_address,INDEX(n_address,"ขว."),LENGTH(n_address)))
           n_length   =  LENGTH(n_tambon)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_tambon   =  trim(REPLACE(n_tambon,"ขว.","แขวง")).
       END.
       ELSE IF INDEX(n_address," " ) <> 0  AND n_tambon  = ""  THEN DO: 
           ASSIGN 
           n_tambon   =  trim(SUBSTR(n_address,R-INDEX(n_address," ")))
           n_length   =  LENGTH(n_tambon)
           n_address  =  trim(SUBSTR(n_address,1,LENGTH(n_address) - n_length))
           n_tambon   =  IF index(n_country,"กรุงเทพ") <> 0 THEN  "แขวง" + (n_tambon) ELSE "ตำบล" + trim(n_tambon).
       END.
       ASSIGN  n_build   = trim(n_address).
       IF INDEX(n_build,"บมก.") <> 0 THEN n_build = REPLACE(n_build,"บมก.","บมจ.") .  /*A65-0035*/
       IF INDEX(n_build,"บก.")  <> 0 THEN n_build = REPLACE(n_build,"บก.","บจ.") .    /*A65-0035*/

    
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createfile2 C-Win 
PROCEDURE proc_createfile2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE(fi_outfile).
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ." 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    /*
    "Processing Office "                /* wdetail.Pro_off   */  
    "CMR  code"                         /* wdetail.cmr_code  */  
    "Insur.comp "                       /* wdetail.comcode   */  
    "notify number"                     /* wdetail.policyno  */  
    "Caryear "                          /* wdetail.caryear   */  
    "Engine "                           /* wdetail.eng       */  
    "Chassis  "                         /* wdetail.chasno    */  
    "Weight"                            /* wdetail.engcc     */  
    "Power"                             /* wdetail.power     */  
    "Color "                            /* wdetail.colorcode */  
    "licence no"                        /* wdetail.vehreg    */ 
    "garage "                           /* wdetail.garage    */  
    "fleet disc. "                      /* wdetail.fleetper  */  
    "ncb disc. "                        /* wdetail.ncb       */  
    "other disc. "                      /* wdetail.orthper   */  
    /*"vehuse " */    /*A60-118*/       /* wdetail.vehuse    */ 
    "Inspection no."  /*A60-118*/       /* wdetail.vehuse    */ 
    "comdat  "                          /* wdetail.comdat    */  
    "sum si "                           /* wdetail.si        */ 
    "รหัสเจ้าหน้าที่แจ้งประกัน "        /* wdetail.not_office */ 
    "ชื่อเจ้าหน้าที่ประกัน  "           /* wdetail.name_insur */ 
    "วันที่แจ้งประกัน  "                /* wdetail.entdat     */  
    "เวลาแจ้งประกัน "                   /* wdetail.enttim     */  
    "รหัสแจ้งงาน"                       /* wdetail.not_code   */  
    "prem.1"                            /* wdetail.premt      */  
    "comp.prm "                         /* wdetail.comp_prm   */  
    "sticker "                          /* wdetail.stk        */  
    "brand "                            /* wdetail.brand      */  
    "address1"                          /* wdetail.mail_add1  */  
    "address2"                          /* wdetail.tambon     */  
    "address3"                          /* wdetail.amper      */  
    "address4"                          /* wdetail.country    */  
    "title name  "                      /* wdetail.tiname     */  
    "first name "                       /* wdetail.insnam     */ /* "last name" */                      /* wdetail.name2      */  
    "beneficiary "                      /* wdetail.benname    */  
    "remark. "                          /* wdetail.remark     */  
    "account no. "                      /* wdetail.Account_no */  
    "client No. "                       /* wdetail.client_no  */  
    "expiry date "                      /* wdetail.expdat     */  
    "insurance amt.  "                  /* wdetail.gap        */ 
    "province "                         /* wdetail.re_country */  
    "receipt name  "                    /* wdetail.RECP_NAME  */ 
    "agent code "                       /* wdetail.agent      */    
    "บริษัทประกันภัยเดิม "              /* wdetail.prev_insur    */    
    "กรมธรรม์ต่ออายุ"                   /* wdetail.prepol        */ 
    "ชื่อผู้ขับขี่1"                    
    "วันเกิด1"                          
    "ชื่อผู้ขับขี่2"                    
    "วันเกิด2"                          
    "deduct disc.  "                    /* wdetail.deduct        */    
    "สาขา"                              /* wdetail.branch        */    
    "แพคเกจ"                            /* wdetail.prempa        */    
    "จำนวนที่นั่ง"                      /* A57-0017*/
    "ความเสียหายต่อคน"                  /* wdetail.tp1           */    
    "ความเสียหายต่อครั้ง"               /* wdetail.tp2           */    
    "ความเสียหายต่อทรัพย์สิน"           /* wdetail.tp3            */ 
    "ประเภทความคุ้มครอง"                /* wdetail.covcod .  */ 
    "Producer"                           
    "Agent"                              
    "ประเภทกรมธรรม์"
    "comment "
    "Receipt ID. Number "               /*A57-0262*/      
    "Receipt Branch NAME"               /*A57-0262*/      
    "Receipt Compulsory ID. Number"     /*A57-0262*/      
    "Receipt Compulsory Branch Name"    /*A57-0262*/ 
    "วันที่คุ้มครอง พรบ."                   /* A59-0178 */
    "วันที่สิ้นสุดความคุ้มครอง พรบ."        /* A59-0178 */
    "ทุนสูญหายและไฟไหม้"                    /* A59-0178 */
    "รหัสรถ"                                /* A59-0178 */
    "ลักษณะการใช้รถ"                        /* A59-0178 */
    "ReceiptName72"                        /* A59-0178 */
    "อุปกรณ์เสริมพิเศษ"                  /*A63-00210*/
    "ReceiptName72"
    "ReceiptAddr1"                      /*A63-00210*/
    */
    "Processing Office"         
    "CMR  code"         
    "Insur.comp"         
    "notify number"         
    "Caryear"
    "Engine"
    "Chassis"
    "Weight"
    "Power"
    "Color"
    "licence no"         
    "garage"
    "fleet disc."         
    "ncb disc."
    "other disc."         
    "Inspection no."         
    "comdat"         
    "sum si"         
    "รหัสเจ้าหน้าที่แจ้งประกัน"         
    "ชื่อเจ้าหน้าที่ประกัน"         
    "วันที่แจ้งประกัน"         
    "เวลาแจ้งประกัน"         
    "รหัสแจ้งงาน"         
    "prem.1"         
    "comp.prm"         
    "sticker"         
    "brand"         
    "address1"         
    "address2" 
    "address3"
    "address4"
    "titlename"         
    "firstname"         
    "beneficiary"         
    "remark."         
    "account no."         
    "client No."         
    "expiry date"         
    "insurance amt."         
    "province"         
    "receipt name "         
    "agent code"         
    "บริษัทประกันภัยเดิม"         
    "กรมธรรม์ต่ออายุ"         
    "deduct disc."         
    "ที่อยู่หน้าตาราง70"                  
    "ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่"
    "ตำบล"                  
    "อำเภอ"                  
    "จังหวัด"                  
    "รหัสไปรษณีย์"                  
    "ที่อยู่หน้าตาราง72"                  
    "ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่"
    "ตำบล"                  
    "อำเภอ"                  
    "จังหวัด"                  
    "รหัสไปรษณีย์"                  
    "Applicationtype"                  
    "Applicationcode"                  
    "Blank"                  
    "แพคเกจ"         
    "จำนวนที่นั่ง"         
    "ความเสียหายต่อคน"         
    "ความเสียหายต่อครั้ง"         
    "ความเสียหายต่อทรัพย์สิน"         
    "ประเภทความคุ้มครอง"         
    "Producer"         
    "Agent"         
    "สาขา"         
    "ประเภทกรมธรรม์"         
    "Redbook"                  
    "Price_Ford"                  
    "Yea"                  
    "Brand_Model"                  
    "Receipt ID. Number"         
    "Receipt Branch NAME"         
    "Receipt Compulsory ID. Number"         
    "Receipt Compulsory Branch Name"         
    "วันที่คุ้มครอง พรบ."         
    "วันที่สิ้นสุดความคุ้มครอง พรบ."         
    "ทุนสูญหายและไฟไหม้"         
    "รหัสรถ"         
    "ลักษณะการใช้รถ"         
    "ลำดับผู้ขับขี่คนที่ 1"
    "ชื่อผู้ขับขี่1"         
    "วันเกิด1"         
    "อาชีพผู้ขับขี่คนที่ 1"                  
    "ตำแหน่งงานผู้ขับขี่คนที่ 1"                  
    "ลำดับผู้ขับขี่คนที่ 2"                  
    "ชื่อผู้ขับขี่2"         
    "วันเกิด2"         
    "อาชีพผู้ขับขี่คนที่ 2"                  
    "ตำแหน่งงานผู้ขับขี่คนที่ 2"                  
    "ลำดับผู้ขับขี่คนที่ 3"                  
    "ชื่อผู้ขับขี่คนที่ 3"                  
    "วันเดือนปีเกิดผู้ขับขี่คนที่ 3"                  
    "อาชีพผู้ขับขี่คนที่ 3"                  
    "ตำแหน่งงานผู้ขับขี่คนที่ 3"                  
    "BLANK"
    "ชื่อที่ใช้บนใบเสร็จ(พรบ.)"                  
    "อุปกรณ์เสริมพิเศษ"         
    "ReceiptName72"         
    "ReceiptAddr1"         
    "comment" 
    "วันเกิดผู้เอาประกัน"   /*A65-0356*/
    /* Add by : A67-0087 */
    " ช่องทางการขาย        "            
    " รถยนต์ไฟฟ้า Y/N      "            
    " ลำดับผู้ขับขี่คนที่ 4"            
    " ชื่อผู้ขับขี่คนที่ 4 "            
    " วันเดือนปีเกิดผู้ขับขี่คนที่4"    
    " อาชีพผู้ขับขี่คนที่ 4 "           
    " ตำแหน่งงานผู้ขับขี่คนที่ 4   "    
    " ลำดับผู้ขับขี่คนที่ 5 "           
    " ชื่อผู้ขับขี่คนที่ 5  "           
    " วันเดือนปีเกิดผู้ขับขี่คนที่5"    
    " อาชีพผู้ขับขี่คนที่ 5 "           
    " ตำแหน่งงานผู้ขับขี่คนที่ 5   "    
    " แคมเปญ  "                         
    " ส่งรูปแทนการตรวจสภาพรถ Y/N"       
    " จำนวนเลขเครื่อง     "             
    " หมายเลขเครื่องยนต์ 2"             
    " หมายเลขเครื่องยนต์ 3"             
    " หมายเลขเครื่องยนต์ 4"             
    " หมายเลขเครื่องยนต์ 5"             
    " รหัส พ.ร.บ."                      
    " ยี่ห้อรถ   "                      
     /* end : A67-0087 */ .
RUN  Pro_matchfile_tlt      .               

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_createpack C-Win 
PROCEDURE proc_createpack :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcomp.
    DELETE wcomp.
END.
CREATE wcomp.
ASSIGN wcomp.package   = "110"
       wcomp.premcomp  = 645.21.
CREATE wcomp.
ASSIGN wcomp.package   = "140A"
       wcomp.premcomp  = 967.28.
CREATE wcomp.
ASSIGN wcomp.package   = "120A"
       wcomp.premcomp  = 1182.35.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Definition C-Win 
PROCEDURE Proc_Definition :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*modify by    : Kridtiya i. A55-0184 เพิ่มไฟล์แสดงกรมธรรม์ที่นำเข้าระบบแล้ว*/
/*modify by    : Kridtiya i. A55-0267 เพิ่มการค้นหาข้อมูลด้วย ชื่อลูกค้า    */
/*modify by    : kridtiya i. A56-0106 เพิ่มส่วนการแปลงค่าเลขกรมธรรม์ พรบ.   */
/*modify by   : Kridtiya i. A57-0017 add column seat , first date       */
/*modify by   : Manop G. A59-0178 add Receipt72  แก้เงื่อนไขค้นหากรมธรรม์ที่ต่ออายุ      */
/*modify by   : Ranu I. A59-0618  เพิ่มการเก็บเบอร์กรมธรรม์ใหม่เข้า tlt 
                และปรับเงื่อนไขการแสดงข้อมูลออกไฟล์ของงานต่ออายุ    */
/*modify by : Ranu I. A60-0095 ปิด loop การเช็ค Producer/Agent ให้ดึงจากข้อมูลใน tlt */
/*modify by : Ranu I. A60-0118 แก้ไขชื่อช่อง vehuse เป็น inspection no.  */
/*modify by : Ranu I. A60-0225 Producer code Mazda ,cir ,cin  */
/*modify by : Ranu I. A61-0045 Match policy72 ให้เช็ควันที่จาก wdetail2.npcomdat  */
/*Modify By : Ranu I. A61-0313 แก้ไขงานต่ออายุ Agent code  และ Prducer code งาน MI */
/*Modify By : Ranu I. A61-0410 แก้ไขงาน Prducer code งาน MI แก้ไขวันที่แจ้งงาน 
              ให้ดึงข้อมูลจากช่อง Notify date และ notify time ในหน้าคิวรี Detail */
/*Modify by : Ranu I. A62-0386 28/08/2019   ปิดการใช้งานโค้ด Mazda ของงานป้ายแดง
             แก้ไขโค้ดงาน MPI งานต่ออายุเป็น A0M2012 */
/*modify by : Sarinya C. A63-0210 เปลี่ยนแปลง Layout Text โดยเพิ่ม field  ต่อท้ายจากเดิม  */
/*Modify by : Ranu I. A64-0095 แก้ไข Producer/Agent เพิ่มเงื่อนไขการเช็คยี่ห้อรุ่นรถเพิ่ม */
/*Modify by : Ranu I. A64-0223 แก้เงื่อนไขการเช็คงานต่ออายุของ Ford */
/*Modify by : Ranu I. A64-0271 แก้ไขการเช็คข้อมูลงานต่ออายุของ Ford */
/*Modify by : Sarinya C. A64-0431 การเช็คข้อมูลรถบรรทุก ISUZU, HINO ให้เข้าโค๊ด B3MLTIS202/B3MLTIS200 */
/*Modify by : Kridtiya i. A65-0361 ปรับส่วนการ ให้ค่า Producer and AgentCode         */
/*Modify by   : Kridtiya i. A65-0356 Date. 07/01/2023 ขยายช่อง เลขเครื่องเลขถัง ทะเบียน สี */
/*Modify by  : Kridtiya i. A66-0140 Date. 01/07/2023 เพิ่ม งาน 2ปี GWM */
/*Modify by  : Ranu I. A67-0087 เพิ่มข้อมูลรถไฟฟ้า                    */
/*Modify by  : Ranu I. A67-0114 แก้ไขข้อมูลให้ตรงช่อง                   */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_imp70 C-Win 
PROCEDURE proc_imp70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_file1     =  fi_filename .
IF nv_file1 <> "" THEN DO:
    INPUT FROM VALUE (nv_file1) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.recordID            /*REC_ID           */      
            wdetail.app_code            /*APP_CODE         */      
            wdetail.Account_no          /*ACCOUNT_NO       */      
            wdetail.client_no           /*CLIENT_NO        */      
            wdetail.preaccno            /*PRE_ACC_NO       */      
            wdetail.notino              /*NOTIFIED_NO      */      
            wdetail.NOTIFIED_DATE       /*NOTIFIED_DATE    */     
            wdetail.stk                 /*STICKER_NO       */      
            wdetail.policyno            /*POLICY_NO        */      
            wdetail.chasno              /*CHASSIS_NO       */      
            wdetail.vehreg              /*LICENCE          */          
            wdetail.re_country          /*PROVINCE_REG     */      
            wdetail.not_office          /*OFFICE_CODE      */      
            wdetail.name_insur          /*OFFICE_NAME      */      
            wdetail.tiname              /*TITLE_NAME       */      
            wdetail.insnam              /*FIRST_NAME       */      
            wdetail.name2               /*LAST_NAME        */      
            wdetail.idno                /*ID_NO            */      
          /*wdetail.comdat             /*EFF_DATE         */      /*A57-0262*/    
            wdetail.EXPdat              /*EXP_DATE         */  */ /*A57-0262*/   
            wdetail.si                  /*COVERAGE_AMT     */     /*A57-0262*/    
            wdetail.premt               /*GROSS_PREM       */     /*A57-0262*/  
            wdetail.dup_pol             /*DUP_POLICY       */      
            wdetail.ori_pol             /*ORI_POLICY       */      
            wdetail.PREM_REC            /*PREM_REC         */      
            wdetail.REC_DATE            /*REC_DATE         */      
            wdetail.RECP_NAME           /*RECP_NAME        */      
            wdetail.RECP_ADD1           /*RECP_ADD1        */      
            wdetail.RECP_ADD2           /*RECP_ADD2        */ 
            wdetail.mail_add1           /*MAIL_ADD1        */       
            wdetail.mail_add2           /*MAIL_ADD2        */  
            wdetail.tambon              /*DISTRICT         */      
            wdetail.amper               /*AMPHUR           */      
            wdetail.country             /*PROVINCE         */      
            wdetail.post                /*ZIPCODE          */      
            wdetail.CHQ_ADDR            /*CHQ_ADDR         */                       
            wdetail.APP_TYPE            /*APP_TYPE         */                       
            wdetail.RECP_MAIL1          /*RECP_MAIL1       */                       
            wdetail.RECP_MAIL2          /*RECP_MAIL2       */                       
            /*wdetail.NOTIFIED_EFF_DATE /*NOTIFIED_EFF_DATE*/     /*A57-0262*/             
            wdetail.NOTIFIED_EXP_DATE   /*NOTIFIED_EXP_DATE*/ */  /*A57-0262*/
            wdetail.comdat                                        /*A57-0262*/
            wdetail.EXPdat                                        /*A57-0262*/
            ID_NO1        
            CLIENT_BRANCH 
            CLIENT_Birthdate  .  /*A65-0XXX   */

        FIND LAST wdetail3 WHERE 
            wdetail3.policyid = wdetail.chasno  AND 
            wdetail3.poltyp   = "V70"           NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail3 THEN DO:
            CREATE wdetail3.
            ASSIGN 
                wdetail3.policyid         = wdetail.chasno
                wdetail3.poltyp           = "V70" 
                wdetail3.ID_NO1           = ID_NO1       
                wdetail3.CLIENT_RANCH     = CLIENT_BRANCH
                wdetail3.CLIENT_Birthdate = CLIENT_Birthdate  .
        END.
        ASSIGN 
            ID_NO1        = ""
            CLIENT_BRANCH = "" 
            CLIENT_Birthdate = ""
            wdetail.npoltyp  = "v70".
    END.  /* repeat  */
    FOR EACH wdetail .
        IF index(wdetail.recordID,"REC_ID") <> 0  THEN DELETE wdetail.
    END.
    FOR EACH wdetail .
        ASSIGN wdetail.npoltyp  = "v70".
        /* comment by : A64-0271 ....
        IF wdetail.mail_add2    = "" THEN DO:
            IF (INDEX(wdetail.country,"กทม") <> 0 ) OR (INDEX(wdetail.country,"กรุงเทพ") <> 0 ) THEN DO:
                ASSIGN wdetail.tambon     = IF trim(wdetail.tambon)  = "" THEN "" ELSE "แขวง" + trim(wdetail.tambon)  
                       wdetail.amper      = IF trim(wdetail.amper)   = "" THEN "" ELSE "เขต"  + trim(wdetail.amper)
                       wdetail.country    = IF trim(wdetail.country) = "" THEN "" ELSE trim(wdetail.country) + " " + trim(wdetail.post).
            END.
            ELSE DO:
                /* Create by A59-0618 */
                 ASSIGN 
                 wdetail.tambon  = IF trim(wdetail.tambon)  = "" THEN "" 
                                   ELSE IF INDEX(wdetail.tambon,"ต.") = 0 THEN "ต." + trim(wdetail.tambon) 
                                   ELSE IF INDEX(wdetail.tambon,"ตำบล") = 0 THEN "ตำบล" + trim(wdetail.tambon) 
                                   ELSE trim(wdetail.tambon) 
                 wdetail.amper   = IF trim(wdetail.amper)   = "" THEN "" 
                                   ELSE IF index(wdetail.amper,"อ.") = 0 THEN  "อ." + trim(wdetail.amper) 
                                   ELSE IF index(wdetail.amper,"อำเภอ") = 0 THEN  "อำเภอ" + trim(wdetail.amper)
                                   ELSE  trim(wdetail.amper)                    
                 wdetail.country = IF trim(wdetail.country) = "" THEN "" 
                                   ELSE IF index(wdetail.country,"จ.") = 0 THEN  "จ." + trim(wdetail.country) + " " + trim(wdetail.post) 
                                   ELSE IF index(wdetail.country,"จังหวัด") = 0 THEN  "จังหวัด" + trim(wdetail.country) + " " + trim(wdetail.post) 
                                   ELSE trim(wdetail.country) + " " + trim(wdetail.post) .
                                   
                /* end A59-0618 */
                /* Comment by A59-0618 ...........
                IF trim(wdetail.tambon)  <> "" THEN  wdetail.tambon  = "ต." + trim(wdetail.tambon).                      
                IF trim(wdetail.amper)   <> "" THEN  wdetail.amper   = "อ." + trim(wdetail.amper).                       
                IF trim(wdetail.country) <> "" THEN  wdetail.country = "จ." + trim(wdetail.country) + " " + trim(wdetail.post). end a59-0618 */ 
            END.
        END.
        ELSE DO: 
            /*country */
            ASSIGN  
                wdetail.mail_add1 = trim(wdetail.mail_add1)  + " " + trim(wdetail.mail_add2) .
            IF r-INDEX(wdetail.mail_add1,"กทม") <> 0  THEN DO:
                ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กทม"))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กทม") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"กรุงเทพ") <> 0  THEN DO:
                ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กรุงเทพ"))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กรุงเทพ") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"จ.") <> 0  THEN DO:
                ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"จ."))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"จ.") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"จังหวัด") <> 0  THEN DO:
                ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"จ."))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"จ.") - 1 ).
            END.
            /*Amper */
            IF r-INDEX(wdetail.mail_add1,"อ.") <> 0  THEN DO:
                ASSIGN wdetail.amper   = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"อ."))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"อ.") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ") <> 0  THEN DO:
                ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ"))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"อำเภอ") <> 0  THEN DO:
                ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"อำเภอ"))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"อำเภอ") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"เขต") <> 0  THEN DO:
                ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"เขต"))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"เขต") - 1 ).
            END.
            /*tambon*/
            IF r-INDEX(wdetail.mail_add1,"ต.") <> 0  THEN DO:
                ASSIGN wdetail.tambon   = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"ต."))
                    wdetail.mail_add1   = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"ต.") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"ตำบล") <> 0  THEN DO:
                ASSIGN wdetail.tambon = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"ตำบล"))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"ตำบล") - 1 ).
            END.
            ELSE IF r-INDEX(wdetail.mail_add1,"แขวง") <> 0  THEN DO:
                ASSIGN wdetail.tambon = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"แขวง"))
                    wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"แขวง") - 1 ).
            END.
        END.  /*else wdetail.mail_add2 <> ""*/
        ... end A64-0271...*/
        RUN proc_vehreg.     /*A60-0095*/
        RUN proc_poladdress. /*A64-0271*/
        ASSIGN 
            wdetail.recordID    = trim(wdetail.recordID)    
            wdetail.Account_no  = trim(wdetail.Account_no)   
            wdetail.client_no   = trim(wdetail.client_no)    
            wdetail.preaccno    = trim(wdetail.preaccno)     
            wdetail.notino      = trim(wdetail.notino)       
            wdetail.stk         = trim(wdetail.stk) 
            wdetail.prepol      = TRIM(wdetail.policyno) /*a60-0095*/
            /*wdetail.policyno    = "TC70" + trim(wdetail.Account_no) */    /*kridtiya i. A55-0184*/
            wdetail.policyno    = IF wdetail.notino = "" THEN "TC70" + IF trim(wdetail.Account_no) = "" THEN  trim(wdetail.preaccno)  ELSE trim(wdetail.Account_no)   /*A55-0184*/
                                  ELSE IF SUBSTR(wdetail.notino,1,5) = "TISTY" THEN "TC70" + SUBSTR(wdetail.notino,6) 
                                  ELSE IF SUBSTR(wdetail.notino,1,5) = "TISTW" THEN "TC70" + SUBSTR(wdetail.notino,6)
                                  ELSE wdetail.notino
            wdetail.chasno      = trim(wdetail.chasno)       
            wdetail.vehreg      = trim(wdetail.vehreg)       
            wdetail.re_country  = trim(wdetail.re_country)   
            wdetail.not_office  = trim(wdetail.not_office)   
            wdetail.name_insur  = trim(wdetail.name_insur)   
            wdetail.tiname      = trim(wdetail.tiname)       
            wdetail.insnam      = trim(trim(wdetail.insnam) + " " + trim(wdetail.name2))
            wdetail.name2       = ""     
            wdetail.idno        = trim(wdetail.idno)         
            wdetail.dup_pol     = trim(wdetail.dup_pol)      
            wdetail.ori_pol     = trim(wdetail.ori_pol)      
            /*wdetail.mail_add1   = trim(wdetail.mail_add1)   
            wdetail.mail_add2   = trim(wdetail.mail_add2)    
            wdetail.tambon      = trim(wdetail.tambon)      
            wdetail.amper       = trim(wdetail.amper)        
            wdetail.country     = trim(wdetail.country)      
            wdetail.post        = trim(wdetail.post) */
            wdetail.RECP_ADD1   = TRIM(wdetail.RECP_ADD1) + " " + trim(wdetail.RECP_ADD2) 
            wdetail.delerbr     = IF wdetail.notino = "" THEN "" 
                                  ELSE IF INDEX(wdetail.notino,",") <> 0 THEN SUBSTR(wdetail.notino,INDEX(wdetail.notino,",") + 1)
                                  ELSE "".
        
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_imp72 C-Win 
PROCEDURE proc_imp72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_file2     =  fi_filename2 .
IF nv_file2 <> "" THEN DO:
    INPUT FROM VALUE (nv_file2) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.recordID            /*REC_ID            */      
            wdetail.app_code            /*APP_CODE          */      
            wdetail.Account_no          /*ACCOUNT_NO        */      
            wdetail.client_no           /*CLIENT_NO         */      
            wdetail.preaccno            /*PRE_ACC_NO        */      
            wdetail.notino              /*NOTIFIED_NO       */      
            wdetail.NOTIFIED_DATE       /*NOTIFIED_DATE     */     
            wdetail.stk                 /*STICKER_NO        */      
            wdetail.policyno            /*POLICY_NO         */      
            wdetail.chasno              /*CHASSIS_NO        */      
            wdetail.vehreg              /*LICENCE           */          
            wdetail.re_country          /*PROVINCE_REG      */      
            wdetail.not_office          /*OFFICE_CODE       */      
            wdetail.name_insur          /*OFFICE_NAME       */      
            wdetail.tiname              /*TITLE_NAME        */      
            wdetail.insnam              /*FIRST_NAME        */      
            wdetail.name2               /*LAST_NAME         */      
            wdetail.idno                /*ID_NO             */      
          /*wdetail.comdat              /*EFF_DATE          */      
            wdetail.EXPdat              /*EXP_DATE          */ */ 
            wdetail.si                  /*COVERAGE_AMT     */  /*A57-0262*/    
            wdetail.premt               /*GROSS_PREM       */  /*A57-0262*/  
            wdetail.dup_pol             /*DUP_POLICY        */      
            wdetail.ori_pol             /*ORI_POLICY        */      
            wdetail.PREM_REC            /*PREM_REC          */      
            wdetail.REC_DATE            /*REC_DATE          */      
            wdetail.RECP_NAME           /*RECP_NAME         */      
            wdetail.RECP_ADD1           /*RECP_ADD1         */      
            wdetail.RECP_ADD2           /*RECP_ADD2         */ 
            wdetail.mail_add1           /*MAIL_ADD1         */       
            wdetail.mail_add2           /*MAIL_ADD2         */  
            wdetail.tambon              /*DISTRICT          */      
            wdetail.amper               /*AMPHUR            */      
            wdetail.country             /*PROVINCE          */      
            wdetail.post                /*ZIPCODE           */      
            wdetail.CHQ_ADDR            /*CHQ_ADDR          */                       
            wdetail.APP_TYPE            /*APP_TYPE          */                       
            wdetail.RECP_MAIL1          /*RECP_MAIL1        */                       
            wdetail.RECP_MAIL2          /*RECP_MAIL2        */                       
          /*wdetail.NOTIFIED_EFF_DATE   /*NOTIFIED_EFF_DATE */  /*A57-0262*/                 
            wdetail.NOTIFIED_EXP_DATE   /*NOTIFIED_EXP_DATE */*//*A57-0262*/ 
            wdetail.comdat                                      /*A57-0262*/ 
            wdetail.EXPdat                                      /*A57-0262*/ 
            ID_NO1        
            CLIENT_BRANCH
            CLIENT_Birthdate  .
        FIND LAST wdetail3 WHERE 
            wdetail3.policyid  = wdetail.chasno  AND 
            wdetail3.poltyp    = "V72"           NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail3 THEN DO:
            CREATE wdetail3.
            ASSIGN 
                wdetail3.policyid      = wdetail.chasno
                wdetail3.poltyp        = "V72" 
                wdetail3.ID_NO1        = ID_NO1       
                wdetail3.CLIENT_RANCH  = CLIENT_BRANCH
                wdetail3.RECEIPT_72    = wdetail.RECP_NAME 
                wdetail3.comppdat      = wdetail.comdat
                wdetail3.exppdat       = wdetail.expdat 
                wdetail3.com_prem      = wdetail.premt
                wdetail3.CLIENT_Birthdate = CLIENT_Birthdate .   
        END.
        ASSIGN 
            ID_NO1        = ""
            CLIENT_BRANCH = "" 
            CLIENT_Birthdate = ""
            wdetail.npoltyp = "v72".
    END.  /* repeat  */
    FOR EACH wdetail .
        IF index(wdetail.recordID,"REC_ID") <> 0  THEN DELETE wdetail.
    END.
   /* FOR EACH wdetail WHERE INDEX(wdetail.policyno,"TC70") = 0 .*/
    FOR EACH wdetail WHERE wdetail.npoltyp  <> "v70" .
        RUN proc_vehreg. /*A60-0095*/
        RUN proc_poladdress. /*A64-0271*/
        ASSIGN  
            wdetail.npoltyp    = "v72"
            wdetail.recordID   = trim(wdetail.recordID)    
            wdetail.Account_no = trim(wdetail.Account_no)   
            wdetail.client_no  = trim(wdetail.client_no)    
            wdetail.preaccno   = trim(wdetail.preaccno)     
            wdetail.notino     = trim(wdetail.notino)       
            wdetail.stk        = trim(wdetail.stk)          
            /*wdetail.policyno   = "TC72" + trim(wdetail.Account_no)  */ /*A55-0184*/
            wdetail.policyno   = IF wdetail.notino = "" THEN 
                                  "TC72" + IF trim(wdetail.Account_no) = "" THEN  trim(wdetail.preaccno)  ELSE trim(wdetail.Account_no)   /*A55-0184*/
                                 ELSE IF SUBSTR(wdetail.notino,1,5) = "TISTY" THEN "TC72" + SUBSTR(wdetail.notino,6) 
                                 ELSE IF SUBSTR(wdetail.notino,1,5) = "TISTW" THEN "TC72" + SUBSTR(wdetail.notino,6)
                                 ELSE "TC72" + trim(wdetail.notino)
            wdetail.chasno     = trim(wdetail.chasno)        
            wdetail.vehreg     = trim(wdetail.vehreg)       
            wdetail.re_country = trim(wdetail.re_country)   
            wdetail.not_office = trim(wdetail.not_office)   
            wdetail.name_insur = trim(wdetail.name_insur)   
            wdetail.tiname     = trim(wdetail.tiname)
            wdetail.insnam     = trim(trim(wdetail.insnam) + " " + trim(wdetail.name2))
            wdetail.name2      = ""    
            wdetail.idno       = trim(wdetail.idno)   
            wdetail.dup_pol    = trim(wdetail.dup_pol)      
            wdetail.ori_pol    = trim(wdetail.ori_pol)      
            wdetail.mail_add1  = trim(wdetail.mail_add1)   
            wdetail.mail_add2  = trim(wdetail.mail_add2)    
            wdetail.tambon     = trim(wdetail.tambon)      
            wdetail.amper      = trim(wdetail.amper)        
            wdetail.country    = trim(wdetail.country)      
            wdetail.post       = trim(wdetail.post) 
            wdetail.RECP_ADD1  = TRIM(wdetail.RECP_ADD1) + " " + trim(wdetail.RECP_ADD2) 
            wdetail.delerbr    = IF wdetail.notino = "" THEN "" 
                                 ELSE IF INDEX(wdetail.notino,",") <> 0 THEN SUBSTR(wdetail.notino,INDEX(wdetail.notino,",") + 1)
                                 ELSE "".
       /* comment by : A64-0271... 
       IF wdetail.mail_add2    = "" THEN DO:
           IF (INDEX(wdetail.country,"กทม") <> 0 ) OR (INDEX(wdetail.country,"กรุงเทพ") <> 0 ) THEN
               ASSIGN  wdetail.tambon = IF trim(wdetail.tambon)  = "" THEN "" ELSE "แขวง" + trim(wdetail.tambon)
                   wdetail.amper      = IF trim(wdetail.amper)   = "" THEN "" ELSE "เขต"  + trim(wdetail.amper)
                   wdetail.country    = IF trim(wdetail.country) = "" THEN "" ELSE trim(wdetail.country) + " " + trim(wdetail.post).
           ELSE 
               ASSIGN
                   wdetail.tambon   = IF trim(wdetail.tambon)  = "" THEN ""                                                                                
                                      ELSE IF INDEX(wdetail.tambon,"ต.") = 0 THEN "ต." + trim(wdetail.tambon)                                              
                                      ELSE IF INDEX(wdetail.tambon,"ตำบล") = 0 THEN "ตำบล" + trim(wdetail.tambon)                                          
                                      ELSE trim(wdetail.tambon)                                                                                            
                   wdetail.amper    = IF trim(wdetail.amper)   = "" THEN ""                                                                                
                                      ELSE IF index(wdetail.amper,"อ.") = 0 THEN  "อ." + trim(wdetail.amper)                                               
                                      ELSE IF index(wdetail.amper,"อำเภอ") = 0 THEN  "อำเภอ" + trim(wdetail.amper)                                         
                                      ELSE  trim(wdetail.amper)                                                                                            
                   wdetail.country  = IF trim(wdetail.country) = "" THEN ""                                                                                
                                      ELSE IF index(wdetail.country,"จ.") = 0 THEN  "จ." + trim(wdetail.country) + " " + trim(wdetail.post)                
                                      ELSE IF index(wdetail.country,"จังหวัด") = 0 THEN  "จังหวัด" + trim(wdetail.country) + " " + trim(wdetail.post)      
                                      ELSE trim(wdetail.country) + " " + trim(wdetail.post) .                                                              
       END.
       ELSE DO: 
           /*country */
           ASSIGN  
               wdetail.mail_add1 = trim(wdetail.mail_add1)  + " " + trim(wdetail.mail_add2) .
           IF r-INDEX(wdetail.mail_add1,"กทม") <> 0  THEN DO:
               ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กทม"))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กทม") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"กรุงเทพ") <> 0  THEN DO:
               ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กรุงเทพ"))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กรุงเทพ") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"จ.") <> 0  THEN DO:
               ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"จ."))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"จ.") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"จังหวัด") <> 0  THEN DO:
               ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"จ."))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"จ.") - 1 ).
           END.
           /*Amper */
           IF r-INDEX(wdetail.mail_add1,"อ.") <> 0  THEN DO:
               ASSIGN wdetail.amper   = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"อ."))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"อ.") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ") <> 0  THEN DO:
               ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ"))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"อำเภอ") <> 0  THEN DO:
               ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"อำเภอ"))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"อำเภอ") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"เขต") <> 0  THEN DO:
               ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"เขต"))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"เขต") - 1 ).
           END.
           /*tambon*/
           IF r-INDEX(wdetail.mail_add1,"ต.") <> 0  THEN DO:
               ASSIGN wdetail.tambon   = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"ต."))
                   wdetail.mail_add1   = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"ต.") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"ตำบล") <> 0  THEN DO:
               ASSIGN wdetail.tambon = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"ตำบล"))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"ตำบล") - 1 ).
           END.
           ELSE IF r-INDEX(wdetail.mail_add1,"แขวง") <> 0  THEN DO:
               ASSIGN wdetail.tambon = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"แขวง"))
                   wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"แขวง") - 1 ).
           END.
        END.  /*else wdetail.mail_add2 <> ""*/
        ...end A64-0271..*/
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1 C-Win 
PROCEDURE proc_impmatpol1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.Pro_off   
            wdetail.cmr_code  
            wdetail.comcode   
            wdetail.policyno  
            wdetail.caryear   
            wdetail.eng       
            wdetail.chasno            
            wdetail.engcc                     
            wdetail.power                     
            wdetail.colorcode                 
            wdetail.vehreg 
            wdetail.garage                    
            wdetail.fleetper                  
            wdetail.ncb                       
            wdetail.orthper                   
            wdetail.vehuse                    
            wdetail.comdat                     
            wdetail.si                        
            wdetail.name_insur              
            wdetail.not_office              
            wdetail.entdat                 
            wdetail.enttim                  
            wdetail.not_code               
            wdetail.premt                  
            wdetail.comp_prm               
            wdetail.stk                    
            wdetail.brand                  
            wdetail.mail_add1              
            wdetail.tambon    
            wdetail.amper     
            wdetail.country   
            wdetail.tiname                 
            wdetail.insnam               
            /*wdetail.name2 */                 
            wdetail.benname                
            wdetail.remark                 
            wdetail.Account_no                  
            wdetail.client_no                   
            wdetail.expdat                       
            wdetail.gap 
            wdetail.re_country  
            wdetail.RECP_NAME 
            wdetail.agent        
            wdetail.prev_insur   
            wdetail.prepol
            /**** A63-0210
            wdetail.drivnam1
            wdetail.driag1  
            wdetail.drivnam2
            wdetail.driag2  
            wdetail.deduct 
            wdetail.branch 
            wdetail.prempa 
            wdetail.name2      /*A57-0017 add seat */
            wdetail.tp1    
            wdetail.tp2    
            wdetail.tp3    
            wdetail.covcod 
            nnproducer                                 /*Producer */
            nnagent                                    /*Agent    */
            nnbranch                                   /*Branch   */
            nntyppol                                   /*typepol  */
            npid70                                     /*A57-0262*/
            npid70br                                   /*A57-0262*/
            npid72                                     /*A57-0262*/
            npid72br                                
            npComdat                                /* Comp  Com */
            npExpdat                                /* Comp Exp*/
            np_fi                                   /* FI */
            npCode    
            npCaruse.
            *******A63-0210 */
            wdetail.deduct
            np_add70
            np_INIT 
            np_INIT 
            np_INIT 
            np_INIT 
            np_INIT 
            np_add72
            np_INIT
            np_INIT
            np_INIT
            np_INIT
            np_INIT
            np_INIT
            np_INIT
            np_remark 
            wdetail.prempa
            wdetail.name2
            wdetail.tp1
            wdetail.tp2
            wdetail.tp3
            wdetail.covcod
            nnproducer
            nnagent
            wdetail.branch
            nnbranch
            np_INIT
            np_INIT
            np_INIT
            np_INIT
            npid70   
            npid70br 
            npid72   
            npid72br 
            npComdat
            npExpdat
            np_fi
            npCode
            npCaruse
            np_INIT
            wdetail.drivnam1
            wdetail.driag1  
            wdetail.driocc1 /*np_INIT*/ /*A67-0087*/
            wdetail.dripos1 /*A67-0114*/   
            np_INIT
            wdetail.drivnam2
            wdetail.driag2
            wdetail.driocc2 /*np_INIT*/ /*A67-0087*/
            wdetail.dripos2 /*A67-0114*/ 
            np_INIT
            wdetail.drivnam3  /*np_INIT*/ /*A67-0087*/
            wdetail.driag3    /*np_INIT*/ /*A67-0087*/
            wdetail.driocc3   /*np_INIT*/ /*A67-0087*/
            wdetail.dripos3 /*A67-0114*/ 
            np_remark    
            np_Rec_name72
            np_remark    
            np_Rec_name72
            np_Rec_add1
            nntyppol
            /* A67-0087 */
            np_init
            wdetail.Schanel    
            wdetail.bev        
            np_INIT            
            wdetail.drivnam4   
            wdetail.driag4     
            wdetail.driocc4    
            wdetail.dripos4 /*A67-0114*/             
            np_INIT            
            wdetail.drivnam5   
            wdetail.driag5     
            wdetail.driocc5    
            wdetail.dripos5 /*A67-0114*/             
            wdetail.campagin   
            wdetail.inspic     
            wdetail.engcount   
            wdetail.engno2     
            wdetail.engno3     
            wdetail.engno4     
            wdetail.engno5     
            wdetail.classcomp  
            wdetail.carbrand   .
        /* A67-0087 */
       FIND LAST wdetail2 WHERE wdetail2.nppolicy = trim(wdetail.policyno) NO-ERROR NO-WAIT.
       IF NOT AVAIL wdetail2 THEN DO:
            CREATE wdetail2.     /*A57-0242*/
            ASSIGN 
                wdetail2.nppolicy     = trim(wdetail.policyno) 
                wdetail2.nnproducer   = trim(nnproducer)  
                wdetail2.nnagent      = trim(nnagent) 
                wdetail2.nnbranch     = trim(nnbranch) 
                wdetail2.nntyppol     = trim(nntyppol)    /*A57-0262*/
                wdetail2.npid70       = trim(npid70)      /*A57-0262*/
                wdetail2.npid70br     = trim(npid70br)    /*A57-0262*/
                wdetail2.npid72       = trim(npid72)      /*A57-0262*/
                wdetail2.npid72br     = trim(npid72br)    /*A57-0262*/
                wdetail2.npComdat     = trim(npComdat) 
                wdetail2.npExpdat     = trim(npExpdat) 
                wdetail2.np_fi        = trim(np_fi)    
                wdetail2.npCode       = trim(npCode)   
                wdetail2.npCaruse     = trim(npCaruse) 
                /*A63-0210*/          
                wdetail2.np_add70       = trim(np_add70) 
                wdetail2.np_add72       = trim(np_add72) 
                wdetail2.np_remark      = trim(np_remark) 
                wdetail2.np_Rec_name72  = trim(np_Rec_name72) 
                wdetail2.np_Rec_add1    = trim(np_Rec_add1) .
        END.
        ASSIGN 
            nnproducer   = "" 
            nnagent      = "" 
            nnbranch     = "" 
            nntyppol     = ""   /*A57-0262*/
            npid70       = ""   /*A57-0262*/
            npid70br     = ""   /*A57-0262*/
            npid72       = ""   /*A57-0262*/
            npid72br     = ""    /*A57-0262*/
            npComdat     = ""   
            npExpdat     = ""
            np_fi        = ""
            npCode       = ""
            npCaruse     = ""
            /**/
            np_add70        = ""
            np_add72        = ""
            np_remark       = ""
            np_Rec_name72   = ""
            np_Rec_add1     = "".
    END.   /* repeat  */ 

    FOR EACH wdetail .
        
        IF index(wdetail.Pro_off,"บริษัท")   <> 0  THEN DELETE wdetail.
        ELSE IF index(wdetail.Pro_off,"Pro") <> 0  THEN DELETE wdetail.
        ELSE IF wdetail.Pro_off  = "" THEN DELETE wdetail.
        ELSE DO:
            
            /*-  Comment A59-0178
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no)  AND 
                sicuw.uwm100.poltyp = "V" + SUBSTR(wdetail.policyno,3,2)   NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:      -*/
              /* comment by A59-0618 ...
               FOR EACH  sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                         sicuw.uwm100.cedpol = TRIM(wdetail.Account_no) AND 
                         sicuw.uwm100.poltyp = "V" + SUBSTR(wdetail.policyno,3,2) NO-LOCK .
                        
                        IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                        ELSE DO:        
                            ASSIGN 
                               n_comdat = ""                                                 
                               n_comdat = STRING(sicuw.uwm100.comdat,"99/99/9999").

                            IF sicuw.uwm100.poltyp = "V70" THEN DO:
                               IF DATE(n_comdat) = DATE(wdetail.comdat) THEN DO:                    
                                    ASSIGN wdetail.pol70 = sicuw.uwm100.policy.                      
                               END.  
                               ELSE ASSIGN wdetail.pol70 = "".
                            END.
                            ELSE IF sicuw.uwm100.poltyp = "V72" THEN DO:
                                IF DATE(n_comdat) = DATE(wdetail2.npComdat) THEN DO:                    
                                   /* ASSIGN wdetail.pol70 = sicuw.uwm100.policy. -- A59-0618 --*/
                                    ASSIGN wdetail.pol72 = sicuw.uwm100.policy. /*-- A59-0618 --*/
                               END.  
                               ELSE /*ASSIGN wdetail.pol70 = "".-- A59-0618 --*/
                                   ASSIGN wdetail.pol72 = "" . /*-- A59-0618 --*/
                            END.
                                IF sicuw.uwm100.poltyp = "V70"  THEN DO:
                                    FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                                        brstat.tlt.cha_no  =  wdetail.chasno AND              
                                        brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.     
                                    IF AVAIL brstat.tlt THEN DO:
                                        IF INDEX(brstat.tlt.releas,"yes") = 0 THEN ASSIGN brstat.tlt.releas =  "yes".
                                        ASSIGN tlt.nor_noti_ins  = wdetail.pol70.  /*A59-0618 */
                                    END.
                                    RELEASE brstat.tlt.
                                END.
                        END. /*- else */
               END. /** for each */
              /*- ELSE ASSIGN wdetail.pol70 = "".
                IF wdetail.pol72 = "" THEN DO:
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                    WHERE sicuw.uwm100.cedpol = wdetail.Account_no AND 
                    sicuw.uwm100.poltyp = "V72"              NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN 
                    ASSIGN wdetail.pol72 = sicuw.uwm100.policy
                    wdetail.pol70 = sicuw.uwm100.cr_2.
                ELSE ASSIGN wdetail.pol70 = ""
                    wdetail.pol72 = "".
                END.  -*/
        END.
        ... End A59-0618 ..........*/
            
            FOR EACH  sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                 sicuw.uwm100.cedpol = TRIM(wdetail.Account_no) AND 
                 sicuw.uwm100.poltyp = "V" + SUBSTR(trim(wdetail.policyno),3,2) NO-LOCK .

                OUTPUT TO "d:\temp\log_mattisco_RE.txt" APPEND.
                PUT "001 Found:" trim(wdetail.Account_no)  FORMAT "X(50)" 
                    sicuw.uwm100.poltyp  FORMAT "X(15)" SKIP
                    sicuw.uwm100.policy  FORMAT "X(15)" SKIP.
                OUTPUT CLOSE.
                
                IF ra_matpoltyp = 2 AND sicuw.uwm100.poltyp = "V72" THEN NEXT.
                IF ra_matpoltyp = 3 AND sicuw.uwm100.poltyp = "V70" THEN NEXT.
                
                IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY)  THEN NEXT.
                ELSE DO:
                  IF sicuw.uwm100.poltyp = "V70" THEN DO:
                     ASSIGN  n_comdat = ""                                                 
                             n_comdat = STRING(sicuw.uwm100.comdat,"99/99/9999").
                    IF YEAR(DATE(n_comdat)) <> YEAR(DATE(wdetail.comdat)) THEN NEXT.
                    ELSE DO:
                        
                        IF n_comdat = trim(wdetail.comdat) THEN DO:                    
                             ASSIGN wdetail.pol70 = sicuw.uwm100.policy.                      
                             
                        END.  
                        ELSE ASSIGN wdetail.pol70 = "".
                    END.
                  END.

                  IF sicuw.uwm100.poltyp = "V72" THEN DO:
                      ASSIGN n_comdat = ""                                                 
                             n_comdat = STRING(sicuw.uwm100.comdat,"99/99/9999").
                      
                      IF YEAR(DATE(n_comdat)) <> YEAR(DATE(wdetail.comdat)) THEN NEXT.
                      ELSE DO:
                        IF n_comdat = trim(wdetail.comdat) THEN DO:
                             ASSIGN wdetail.pol72 = sicuw.uwm100.policy.
                        END.  
                        ELSE ASSIGN wdetail.pol72 = "" .
                      END.
                  END.
                  IF sicuw.uwm100.poltyp = "V70"  THEN DO:
                      OUTPUT TO "d:\temp\log_mattisco_RE.txt" APPEND.
                      PUT "002 Found:" trim(wdetail.chasno)  FORMAT "X(50)" 
                          sicuw.uwm100.poltyp  FORMAT "X(15)" SKIP
                          sicuw.uwm100.policy  FORMAT "X(15)" SKIP.
                      OUTPUT CLOSE. 
                      FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   
                          brstat.tlt.cha_no  =  trim(wdetail.chasno) AND              
                          brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.     
                      IF AVAIL brstat.tlt THEN DO:
                          OUTPUT TO "d:\temp\log_mattisco_RE.txt" APPEND.
                          PUT "003 Found:" trim(wdetail.chasno)  FORMAT "X(50)" 
                              brstat.tlt.releas        FORMAT "X(30)" SKIP
                              brstat.tlt.nor_noti_ins  FORMAT "X(30)"
                              brstat.tlt.ndate1 SKIP.
                          OUTPUT CLOSE.
                          IF INDEX(brstat.tlt.releas,"yes") = 0 THEN ASSIGN brstat.tlt.releas =  "yes".
                          ASSIGN brstat.tlt.nor_noti_ins  = wdetail.pol70   /*A59-0618 */
                              brstat.tlt.ndate1 = TODAY.  /*A65-0356 */
                      END.
                      ELSE DO:
                          OUTPUT TO "d:\temp\log_mattisco_RE.txt" APPEND.
                          PUT "004Not_Found:" trim(wdetail.chasno)  FORMAT "X(50)" 
                              sicuw.uwm100.poltyp  FORMAT "X(15)" SKIP
                              sicuw.uwm100.policy  FORMAT "X(15)" SKIP.
                          OUTPUT CLOSE.
                          RUN proc_updatetlt (INPUT wdetail.chasno).
                      END.
                      RELEASE brstat.tlt.
                  END.
                END. /*- else */
            END. /** for each */
            RELEASE sicuw.uwm100.
        END. /* else */
        
    END. /* repate */
    Run  Pro_createfilepol.
    Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol2 C-Win 
PROCEDURE proc_impmatpol2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.Pro_off         /*  1   Processing Office   */                
            wdetail.cmr_code        /*  2   CMR  code   */                        
            wdetail.comcode         /*  3   Insur.comp  */                        
            wdetail.policyno        /*  4   notify number   */                    
            wdetail.caryear         /*  5   Car year    */                        
            wdetail.eng             /*  6   engine  */                            
            wdetail.chasno          /*  7   chassis */                            
            wdetail.engcc           /*  8   weight  */                                  
            wdetail.power           /*  9   power   */                                  
            wdetail.colorcode       /*  10  color   */                                  
            wdetail.vehreg          /*  11  licence no*/                        
            wdetail.garage          /*  12  Garage  */                                  
            wdetail.fleetper        /*  13  fleet disc. */                              
            wdetail.ncb             /*  14  ncb disc.   */                              
            wdetail.orthper         /*  15  other disc. */                              
            wdetail.vehuse          /*  16  vehuse  */                                  
            wdetail.comdat          /*  17  Comdat  */                                   
            wdetail.si              /*  18  ทุนประกัน   */                              
            wdetail.name_insur      /*  19  รหัสเจ้าหน้าที่แจ้งประกัน   */            
            wdetail.not_office      /*  20  ชื่อเจ้าหน้าที่ประกัน   */                
            wdetail.entdat          /*  21  วันที่แจ้งประกัน    */                   
            wdetail.enttim          /*  22  เวลาแจ้งประกัน  */                        
            wdetail.not_code        /*  23  รหัสแจ้งงาน */                           
            wdetail.premt           /*  24  prem.1  */                               
            wdetail.comp_prm        /*  25  comp.prm    */                           
            wdetail.stk             /*  26  sticker */                               
            wdetail.brand           /*  27  brand   */                               
            wdetail.mail_add1       /*  28  address1    */ 
            wdetail.mail_add2       /*  29  address2    */                        
            wdetail.tiname          /*  30  title name  */                        
            wdetail.insnam          /*  31  first name  */                        
            wdetail.name2           /*  32  last name   */                           
            wdetail.benname         /*  33  beneficiary */                         
            wdetail.remark          /*  34  remark. */                                   
            wdetail.Account_no      /*  35  account no. */                           
            wdetail.client_no       /*  36  client No.  */                           
            wdetail.expdat          /*  37  expiry date     */                            
            wdetail.gap             /*  38  insurance amt.  */                            
            wdetail.re_country      /*  39  province    */                                 
            wdetail.RECP_NAME       /*  40  receipt name    */                    
            wdetail.agent           /*  41  agent code  */                        
            wdetail.prev_insur      /*  42  บริษัทประกันภัยเดิม */                
            wdetail.prepol          /*  43  old policy  */                        
            wdetail.drivnam1        /*  44  deduct disc.    */                    
            wdetail.driag1          /*  45  ที่อยู่หน้าตาราง70  */                
            wdetail.drivnam2        /*  46  ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่ */
            tambon70                /*  47  ตำบล    */                            
            amper70                 /*  48  อำเภอ   */                            
            country70               /*  49  จังหวัด */                            
            post70                  /*  50  รหัสไปรษณีย์    */          /*  50  รหัสไปรษณีย์    */                    
            wdetail.RECP_MAIL1      /*  51  ที่อยู่หน้าตาราง72  */                
            wdetail.RECP_MAIL2      /*  52  ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่ */
            wdetail.tambon          /*  53  ตำบล    */                            
            wdetail.amper           /*  54  อำเภอ   */                            
            wdetail.country         /*  55  จังหวัด */                            
            wdetail.post            /*  56  รหัสไปรษณีย์    */                    
            wdetail.CHQ_ADDR        /*  57  Applicationtype */                    
            wdetail.APP_TYPE        /*  58  Applicationcode */                    
            wdetail.delerbr         /*  59  Blank   */                             
            wdetail.prempa          /*  60  package */                            
            wdetail.recordID        /*  A57-0017    add seat */
            wdetail.tp1             /*  61  TPBI/Person */                        
            wdetail.tp2             /*  62  TPBI/Per Acciden    */                
            wdetail.tp3             /*  63  TPPD/Per Acciden    */                
            wdetail.covcod          /*  64  covcod  */                            
            wdetail.npoltyp         /*  65  Producer    */                        
            /*wdetail.agent         /*      Agent   */                            
            wdetail.branch          /*      Branch  */    
            wdetail.typpol */       /*      NEW/RENEW   */ 
            nnagent                 /*  66  Agent   */     
            nnbranch                /*  67  Branch  */     
            nntyppol                /*  68  NEW/RENEW   */ 
            npRedbook           /*A57-0262*/
            npPrice_Ford     /*A57-0262*/
            npYear           /*A57-0262*/
            npBrand_Mo       /*A57-0262*/
            npid70           /*A57-0262*/
            npid70br         /*A57-0262*/
            npid72           /*A57-0262*/
            npid72br          /*A59-0178*/
            npComdat          /*A59-0178*/
            npExpdat          /*A59-0178*/
            np_fi             /*A59-0178*/
            npCode            /*A59-0178*/
            npCaruse          /*A59-0178*/
            npdrino1          /*A59-0178*/
            npdrinam1         /*A59-0178*/
            npdridat1         /*A59-0178*/
            npdriocc1         /*A59-0178*/
            npdripos1         /*A59-0178*/
            npdrino2          /*A59-0178*/
            npdrinam2         /*A59-0178*/
            npdridat2         /*A59-0178*/
            npdriocc2         /*A59-0178*/
            npdripos2         /*A59-0178*/
            npdrino3          /*A59-0178*/
            npdrinam3         /*A59-0178*/
            npdridat3         /*A59-0178*/
            npdriocc3         /*A59-0178*/
            npdripos3         /*A59-0178*/ 
            /* A67-0087 */
            wdetail.nblank    
            wdetail.Reciept72 
            wdetail.caracc    
            wdetail.Rec_name72
            wdetail.Rec_add1  
            wdetail.Rec_add2  
            wdetail.insbdate
            wdetail.comment
            wdetail.Schanel    
            wdetail.bev        
            wdetail.drino4            
            wdetail.drivnam4   
            wdetail.driag4     
            wdetail.driocc4    
            wdetail.dripos4             
            wdetail.drino5              
            wdetail.drivnam5   
            wdetail.driag5     
            wdetail.driocc5    
            wdetail.dripos5            
            wdetail.campagin   
            wdetail.inspic     
            wdetail.engcount   
            wdetail.engno2     
            wdetail.engno3     
            wdetail.engno4     
            wdetail.engno5     
            wdetail.classcomp  
            wdetail.carbrand   .

        FIND LAST wdetail2 WHERE wdetail2.nppolicy = trim(wdetail.chasno) NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail2 THEN DO:
            CREATE wdetail2.     /*A57-0242*/
            ASSIGN 
                wdetail2.nppolicy     = trim(wdetail.chasno) 
                wdetail2.tambon70     = trim(tambon70) 
                wdetail2.amper70      = trim(amper70)  
                wdetail2.country70    = trim(country70)
                wdetail2.post70       = trim(post70)
                wdetail2.nnagent      = trim(nnagent)  
                wdetail2.nnbranch     = trim(nnbranch) 
                wdetail2.nntyppol     = trim(nntyppol) 
                wdetail2.npRedbook    = trim(npRedbook)        /*A57-0262*/
                wdetail2.npPrice_Ford = trim(npPrice_Ford)     /*A57-0262*/
                wdetail2.npYear       = trim(npYear)           /*A57-0262*/
                wdetail2.npBrand_Mo   = trim(npBrand_Mo)       /*A57-0262*/
                wdetail2.npid70       = trim(npid70)           /*A57-0262*/
                wdetail2.npid70br     = trim(npid70br)         /*A57-0262*/
                wdetail2.npid72       = trim(npid72)           /*A57-0262*/
                wdetail2.npid72br     = trim(npid72br)         
                wdetail2.npComdat     = trim(npComdat)          
                wdetail2.npExpdat     = trim(npExpdat)         
                wdetail2.np_fi        = trim(np_fi)            
                wdetail2.npCode       = trim(npCode)           
                wdetail2.npCaruse     = trim(npCaruse)          /*-A59-0178*/
                wdetail2.npdrino1     = trim(npdrino1)          /*-A59-0178*/
                wdetail2.npdrinam1    = trim(npdrinam1)         /*-A59-0178*/
                wdetail2.npdridat1    = trim(npdridat1)         /*-A59-0178*/
                wdetail2.npdriocc1    = trim(npdriocc1)         /*-A59-0178*/
                wdetail2.npdripos1    = trim(npdripos1)         /*-A59-0178*/
                wdetail2.npdrino2     = trim(npdrino2 )         /*-A59-0178*/
                wdetail2.npdrinam2    = trim(npdrinam2)         /*-A59-0178*/
                wdetail2.npdridat2    = trim(npdridat2)         /*-A59-0178*/
                wdetail2.npdriocc2    = trim(npdriocc2)         /*-A59-0178*/
                wdetail2.npdripos2    = trim(npdripos2)         /*-A59-0178*/
                wdetail2.npdrino3     = trim(npdrino3 )         /*-A59-0178*/
                wdetail2.npdrinam3    = trim(npdrinam3)         /*-A59-0178*/
                wdetail2.npdridat3    = trim(npdridat3)         /*-A59-0178*/
                wdetail2.npdriocc3    = trim(npdriocc3)         /*-A59-0178*/
                wdetail2.npdripos3    = trim(npdripos3)  .  
  
        END.
        ASSIGN 
            tambon70     = "" 
            amper70      = "" 
            country70    = "" 
            post70       = "" 
            nnagent      = "" 
            nnbranch     = "" 
            nntyppol     = "" 
            npRedbook    = ""   /*A57-0262*/
            npPrice_Ford = ""  /*A57-0262*/
            npYear       = ""  /*A57-0262*/
            npBrand_Mo   = ""  /*A57-0262*/
            npid70       = ""  /*A57-0262*/
            npid70br     = ""  /*A57-0262*/
            npid72       = ""  /*A57-0262*/
            npid72br     = ""  
            npComdat     = "" 
            npExpdat     = "" 
            np_fi        = "" 
            npCode       = "" 
            npCaruse     = "" 
            npdrino1     = "" 
            npdrinam1    = "" 
            npdridat1    = "" 
            npdriocc1    = "" 
            npdripos1    = "" 
            npdrino2     = "" 
            npdrinam2    = "" 
            npdridat2    = "" 
            npdriocc2    = "" 
            npdripos2    = "" 
            npdrino3     = ""
            npdrinam3    = ""
            npdridat3    = ""
            npdriocc3    = ""
            npdripos3    = ""  
            .
    END.   /* repeat  */
    FOR EACH wdetail .
        IF index(wdetail.Pro_off,"บริษัท")     <> 0  THEN DELETE wdetail.
        ELSE IF index(wdetail.Pro_off,"Pro")   <> 0  THEN DELETE wdetail.
        ELSE IF index(wdetail.Pro_off,"Total") <> 0  THEN DELETE wdetail.
        ELSE IF wdetail.Pro_off  = "" THEN DELETE wdetail.
        ELSE DO:
            IF (ra_matpoltyp = 3 )  THEN ASSIGN wdetail.pol70 = "".  /* mat 70 only */
            ELSE DO:
                /*-FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                    WHERE sicuw.uwm100.cedpol = TRim(wdetail.Account_no)  AND 
                    sicuw.uwm100.poltyp       = "V70"               NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:  -*/
                /*2 Year */
                IF INDEX(wdetail.remark,"_2Y") <> 0 THEN DO:
                    n_policy01y = "".
                    n_policy02y = "".
                    FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
                        sicuw.uwm100.cedpol =  trim(wdetail.Account_no) AND
                        sicuw.uwm100.rencnt =  0                  AND
                        sicuw.uwm100.poltyp =  "V70"              NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        wdetail.pol70      = trim(n_policy01y) .
                        FIND LAST buwm100 USE-INDEX uwm10002     WHERE
                            buwm100.cedpol =  trim(wdetail.Account_no) AND
                            buwm100.rencnt =  1                  AND
                            buwm100.poltyp =  "V70"              NO-ERROR NO-WAIT.
                        IF AVAIL buwm100 THEN  
                            ASSIGN 
                            buwm100.prvpol      =  trim(sicuw.uwm100.policy)  /*กรมก่อนหน้า*/
                            sicuw.uwm100.renpol =  trim(buwm100.policy)       /*กรมปีหน้า*/
                            n_policy01y =  trim(sicuw.uwm100.policy)
                            n_policy02y =  trim(buwm100.policy)  .

                        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE                  /*A66-0140*/  
                            brstat.tlt.cha_no  =  trim(wdetail.chasno) AND    
                            brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.    
                        IF AVAIL brstat.tlt THEN DO:
                            IF INDEX(brstat.tlt.releas,"yes") = 0 THEN ASSIGN brstat.tlt.releas =  "yes".
                            ASSIGN 
                                brstat.tlt.nor_noti_ins  = trim(n_policy01y)   /*A59-0618 */
                                brstat.tlt.note6         = trim(n_policy02y)
                                brstat.tlt.ndate1        = TODAY   /*A65-0356 */
                                wdetail.pol70      = trim(n_policy01y) 
                                wdetail.policy2y70 = trim(n_policy02y)  . 
                            
                        END.
                        ELSE DO:
                            
                            RUN proc_updatetlt (INPUT wdetail.chasno).
                        END.
                        RELEASE brstat.tlt.
                    END.
                    FIND LAST sicuw.uwm100  USE-INDEX uwm10002    WHERE
                        sicuw.uwm100.cedpol =  trim(wdetail.Account_no) AND
                        sicuw.uwm100.rencnt =  0                  AND
                        sicuw.uwm100.poltyp =  "V72"              NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        FIND LAST buwm100 USE-INDEX uwm10002     WHERE
                            buwm100.cedpol =  trim(wdetail.Account_no) AND
                            buwm100.rencnt =  1                  AND
                            buwm100.poltyp =  "V72"              NO-ERROR NO-WAIT.
                        IF AVAIL buwm100 THEN  
                            ASSIGN 
                            buwm100.prvpol      =  trim(sicuw.uwm100.policy)  /*กรมก่อนหน้า*/
                            sicuw.uwm100.renpol =  trim(buwm100.policy)      /*กรมปีหน้า*/
                            wdetail.policy2y72  =  trim(buwm100.policy) .
                    END.
                END.
                /*2 Year */
                ELSE DO:
                    FOR EACH  sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                        sicuw.uwm100.cedpol = TRIM(wdetail.Account_no) NO-LOCK:
                        IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                        /*ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT. A59-0618*/
                        ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY)  THEN NEXT.  /*-A59-0618-*/
                        ELSE DO:
                            ASSIGN n_comdat = ""
                                n_comdat = STRING(sicuw.uwm100.comdat,"99/99/9999").
                            IF YEAR(DATE(n_comdat)) <> YEAR(DATE(wdetail.comdat)) THEN NEXT. /*-A59-0618-*/
                            ELSE DO:
                                /*IF DATE(n_comdat) = DATE(wdetail.comdat) THEN DO:*/  /*-A59-0618-*/
                                IF trim(n_comdat) = TRIM(wdetail.comdat) THEN DO:  /*-A59-0618-*/
                                    ASSIGN wdetail.pol70 = sicuw.uwm100.policy.
                                END.
                                ELSE ASSIGN wdetail.pol70 = "".
                            END.
                            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE      /*A66-0140*/ 
                                brstat.tlt.cha_no  =  trim(wdetail.chasno) AND    
                                brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.    
                            IF AVAIL brstat.tlt THEN DO:
                                IF INDEX(brstat.tlt.releas,"yes") = 0 THEN ASSIGN brstat.tlt.releas =  "yes".
                                ASSIGN brstat.tlt.nor_noti_ins  = trim(wdetail.pol70)   /*A59-0618 */
                                    brstat.tlt.ndate1 = TODAY.  /*A65-0356 */
                            END.
                            ELSE DO:
                                RUN proc_updatetlt (INPUT wdetail.chasno).
                            END.
                            RELEASE brstat.tlt.
                        END.
                    END.  /*-ELSE ASSIGN wdetail.pol70 = "".-*/
                    
                END.
            END.
        END. /*(ra_matpoltyp = 1 ) OR (ra_matpoltyp = 2 )*/
        RELEASE sicuw.uwm100.
    END.
    FOR EACH wdetail2.
        IF INDEX(wdetail2.nppolicy,"chassis") <> 0 THEN DELETE wdetail2.
        ELSE IF wdetail2.nppolicy = ""  THEN DELETE wdetail2.
    END. 
    Run  Pro_createfilepol72.
    Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchagent C-Win 
PROCEDURE proc_matchagent :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--------Comment by Kridtiya i .A65-0361 Date. 29/11/2022 ปิด เพื่อใช้ถังพัก ข้อมูลถุกแล้ว
IF brstat.tlt.flag = "n" THEN DO:
    IF brstat.tlt.comp_sub = "A0M2010" OR brstat.tlt.comp_sub = "B3MLTIS102"  THEN DO:  /*A64-0092*/
        /* ใช้โค้ดเดิม */
        ASSIGN brstat.tlt.comp_sub = "B3MLTIS102". /*A64-0092*/
    END.
    /* Add : A64-0271 */
    ELSE IF  index(brstat.tlt.brand,"FORD") <> 0 THEN DO:
        ASSIGN brstat.tlt.comp_sub      = fi_producernewf 
              brstat.tlt.comp_noti_ins = fi_agentnewfo .
        IF index(tlt.filler2,"_2Y") <> 0 THEN 
            ASSIGN brstat.tlt.comp_sub = fi_producerf2y
              brstat.tlt.comp_noti_ins = fi_agentf2y  .
    END.
    ELSE IF  index(brstat.tlt.brand,"HAVAL") <> 0 THEN DO:
            ASSIGN brstat.tlt.comp_sub = fi_producerhv
              brstat.tlt.comp_noti_ins = fi_agenthv  . 
    END.
    /* Add : A64-0271 */
    ELSE DO:
        IF  index(brstat.tlt.brand,"ISUZU") <> 0 THEN DO:   /*case : ISUZU */
            /* start : A64-0092  รถบรรทุก */
            IF index(brstat.tlt.brand,"Wheels") <> 0 OR index(brstat.tlt.brand,"Trailer") <> 0
            OR index(brstat.tlt.brand,"TRUCK")  <> 0 /*A64-0431*/ THEN DO: 
                 ASSIGN brstat.tlt.comp_sub      = fi_pdtkcode   
                        brstat.tlt.comp_noti_ins = fi_agtkcode .
            END.
            /* end A64-0092*/
             /*--- A60-0225-----*/
            ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                           brstat.tlt.comp_noti_ins = fi_agentNCIR .
            END.
            /*-- end : A60-0225--*/
            /* start : A64-0092  รถเล็ก */
            ELSE IF brstat.tlt.lince2 = trim(fi_year) THEN DO: 
                ASSIGN brstat.tlt.comp_sub         = fi_produceris
                       brstat.tlt.comp_noti_ins    = fi_agentis.
            END.
            /* end A64-0092*/
            ELSE 
                ASSIGN  brstat.tlt.comp_sub     = fi_producernewtis              
                       brstat.tlt.comp_noti_ins = fi_agentnewtis .
        END.
        /*--- A60-0225-----*/
        ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                       brstat.tlt.comp_noti_ins = fi_agentNCIR .
        END.
        /*-- end : A60-0225--*/
         /* A64-0092 */
        ELSE IF index(brstat.tlt.brand,"HINO")  <> 0 OR index(brstat.tlt.brand,"Trailer") <> 0
             OR index(brstat.tlt.brand,"TRUCK") <> 0 /*A64-0431*/ THEN DO: /*รถบรรทุก */
            ASSIGN brstat.tlt.comp_sub      = fi_pdtkcode   
                   brstat.tlt.comp_noti_ins = fi_agtkcode .
        END.
        ELSE IF index(brstat.tlt.brand,"YAMAHA") <> 0 OR index(brstat.tlt.brand,"TRIUMPH") <> 0 OR index(brstat.tlt.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                       brstat.tlt.comp_noti_ins = fi_agbkcode .
        END.
        ELSE IF (index(brstat.tlt.brand,"SUZUKI") <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) OR 
                (index(brstat.tlt.brand,"HONDA")  <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) AND
                (index(brstat.tlt.filler2,"Deduct") <> 0 OR index(brstat.tlt.filler2,"DD") <> 0 ) THEN DO: /* bigbike*/
                ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                       brstat.tlt.comp_noti_ins = fi_agbkcode .
        END.
        /* end A64-0092 */
        ELSE ASSIGN  brstat.tlt.comp_sub        = fi_producernewtis              
                     brstat.tlt.comp_noti_ins   = fi_agentnewtis .
        
        IF trim(SUBSTR(brstat.tlt.expousr,1,3)) <> "1" AND index(brstat.tlt.nor_noti_tlt,"TISTY") <> 0  THEN DO:
             /*--- A60-0225-----*/
            IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                           brstat.tlt.comp_noti_ins = fi_agentNCIR .
            END.
            /*-- end : A60-0225--*/
            /* A64-0092 */
            ELSE IF index(brstat.tlt.brand,"HINO") <> 0 OR index(brstat.tlt.brand,"Trailer") <> 0 THEN DO: /*รถบรรทุก */
                ASSIGN brstat.tlt.comp_sub      = fi_pdtkcode   
                       brstat.tlt.comp_noti_ins = fi_agtkcode .
            END.
            ELSE IF index(brstat.tlt.brand,"YAMAHA") <> 0 OR index(brstat.tlt.brand,"TRIUMPH") <> 0 OR index(brstat.tlt.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                    ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                           brstat.tlt.comp_noti_ins = fi_agbkcode .
            END.
            ELSE IF (index(brstat.tlt.brand,"SUZUKI") <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) OR 
                    (index(brstat.tlt.brand,"HONDA")  <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) AND
                    (index(brstat.tlt.filler2,"Deduct") <> 0 OR index(brstat.tlt.filler2,"DD") <> 0 ) THEN DO: /* bigbike*/
                    ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                           brstat.tlt.comp_noti_ins = fi_agbkcode .
            END.
            /* end A64-0092 */
            ELSE IF brstat.tlt.rec_addr3 <> "17" THEN DO:
                ASSIGN brstat.tlt.comp_sub         = "B3MLTIS103"  /*"A0M2011"*/ /*A64-0092*/ 
                       brstat.tlt.comp_noti_ins    = "B3MLTIS100"  /*"B3M0002"*/ /*A64-0092*/ .
            END.
            ELSE 
                ASSIGN brstat.tlt.comp_sub         = fi_producernewtis
                       brstat.tlt.comp_noti_ins    = fi_agentnewtis.
        END.
    END.
END.
ELSE DO: /* renew*/
    IF  index(brstat.tlt.brand,"FORD")  <> 0 THEN DO:
         ASSIGN brstat.tlt.comp_sub       = fi_producerford
                brstat.tlt.comp_noti_ins  = fi_agentford  .
    END.
    ELSE IF  index(brstat.tlt.brand,"NISSAN")  <> 0 THEN DO:
       /* A65-0035...
       FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
            sicuw.uwm100.policy = trim(tlt.filler1) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO: 
            IF sicuw.uwm100.acno1 = "B3W0020" OR sicuw.uwm100.acno1 = "B3MF100340" OR
               sicuw.uwm100.acno1 = "B3W0016" THEN /*A65-0043*/
                ASSIGN brstat.tlt.comp_sub       = fi_producerns
                       brstat.tlt.comp_noti_ins  = fi_agentns.
            ELSE ASSIGN brstat.tlt.comp_sub      = fi_producerns2
                       brstat.tlt.comp_noti_ins  = fi_agentns2  .
        END.
        ..end A65-0035...*/
        /* A65-0035 */
        IF INDEX(brstat.tlt.rec_addr2,"SAFETY INSURANCE") <> 0 THEN DO:
            FIND LAST sicuw.uwm301 Use-index uwm30121 Where 
                      sicuw.uwm301.cha_no             = trim(brstat.tlt.cha_no) AND
                      substr(sicuw.uwm301.policy,3,2) = "70"  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm301 THEN DO:
                    Find LAST sicuw.uwm100 Use-index uwm10001       Where
                        sicuw.uwm100.policy = sicuw.uwm301.policy   and
                        sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and 
                        sicuw.uwm100.poltyp = "V70"  No-lock no-error no-wait.
                    If avail sicuw.uwm100 Then DO:
                      IF sicuw.uwm100.acno1 = "B3W0020" OR sicuw.uwm100.acno1 = "B3MF100340" OR
                         sicuw.uwm100.acno1 = "B3W0016" THEN /*A65-0043*/
                          ASSIGN brstat.tlt.comp_sub       = fi_producerns
                                 brstat.tlt.comp_noti_ins  = fi_agentns.
                     /* ELSE 
                          ASSIGN brstat.tlt.comp_sub      = fi_producerns2
                                 brstat.tlt.comp_noti_ins = fi_agentns2  .*/
                    END.
                    ELSE ASSIGN brstat.tlt.comp_sub       = fi_producerns
                                brstat.tlt.comp_noti_ins  = fi_agentns.
                END.
                ELSE ASSIGN brstat.tlt.comp_sub      = fi_producerns2
                            brstat.tlt.comp_noti_ins = fi_agentns2  .
        END.
        ELSE ASSIGN brstat.tlt.comp_sub      = fi_producerns2
                    brstat.tlt.comp_noti_ins = fi_agentns2  .
        /* end : A65-0035 */
    END.
    ELSE IF brstat.tlt.comp_sub = "A0M2010" OR brstat.tlt.comp_sub = "B3MLTIS102"   THEN DO:   /*A64-0092*/
        /* ใช้โค้ดเดิม */
        ASSIGN brstat.tlt.comp_sub = "B3MLTIS102".  /*A64-0092*/
    END.
    ELSE DO:
        IF INDEX(brstat.tlt.rec_addr2,"SAFETY INSURANCE") <> 0 THEN DO:
            IF INDEX(brstat.tlt.safe1,"ระบุ 8.3") <> 0 AND INDEX(brstat.tlt.safe1,"ไม่ระบุ 8.3") = 0  THEN DO:   /*case : add 8.3 */
                IF  index(brstat.tlt.brand,"MAZDA")     <> 0   AND
                    INDEX(brstat.tlt.filler2,"MPI")     <> 0   THEN DO:   /*A61-0313*/
                    ASSIGN  brstat.tlt.comp_sub   = fi_producerMI
                        brstat.tlt.comp_noti_ins  = fi_agentMI
                        n_product                 = "MPI" .     /*A61-0313*/  
                END.
                ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                      ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                             brstat.tlt.comp_noti_ins = fi_agentCIR .
                END.
                /*-- end : A60-0225---*/
                ELSE                                 
                    ASSIGN brstat.tlt.comp_sub       = fi_producer83      
                           brstat.tlt.comp_noti_ins  = fi_agent83.
            END.
            ELSE DO:
                IF index(brstat.tlt.brand,"MAZDA")   <> 0   AND 
                   INDEX(brstat.tlt.filler2,"MPI")   <> 0   THEN DO: /*A61-0313*/
                   ASSIGN  brstat.tlt.comp_sub       = fi_producerMI
                           brstat.tlt.comp_noti_ins  = fi_agentMI.
                END.
                ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                      ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                             brstat.tlt.comp_noti_ins = fi_agentCIR .
                END.
                ELSE                                  
                    ASSIGN brstat.tlt.comp_sub        = fi_producerno83      
                           brstat.tlt.comp_noti_ins   = fi_agentno83.
            END.
        END.
        ELSE DO:
            IF index(brstat.tlt.brand,"MAZDA")   <> 0   AND 
                 INDEX(brstat.tlt.filler2,"MPI")   <> 0   THEN DO: 
                 ASSIGN  brstat.tlt.comp_sub       = fi_producerMI
                         brstat.tlt.comp_noti_ins  = fi_agentMI.
            END.
            ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                  ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                         brstat.tlt.comp_noti_ins = fi_agentCIR .
            END.
            ELSE IF (trim(SUBSTR(brstat.tlt.expousr,1,3)) = "1") AND INDEX(brstat.tlt.safe1,"ระบุ 8.3") <> 0 AND 
                 INDEX(brstat.tlt.safe1,"ไม่ระบุ 8.3") = 0 THEN DO:
                  ASSIGN brstat.tlt.comp_sub      = fi_producer83
                         brstat.tlt.comp_noti_ins = fi_agent83.
            END.
            ELSE IF (trim(SUBSTR(brstat.tlt.expousr,1,3)) <> "1") AND (INDEX(brstat.tlt.rec_addr2,"SAFETY INSURANCE") = 0 ) THEN DO:
                IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                      ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                             brstat.tlt.comp_noti_ins = fi_agentCIR .
                END.
                ELSE 
                    ASSIGN   brstat.tlt.exp             =  "ML" 
                             brstat.tlt.comp_sub        =  fi_producerTF   /* "B3MLTIS103" A64-0092*/
                             brstat.tlt.comp_noti_ins   =  fi_agentTF .    /* "B3MLTIS100" A64-0092*/
            END.
        END.
    END. /* <> A0M2010 */
    
END.
End....Comment by Kridtiya i .A65-0361 Date. 29/11/2022 ปิด เพื่อใช้ถังพัก ข้อมูลถุกแล้ว-- --------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchagent-01 C-Win 
PROCEDURE proc_matchagent-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : a64-0271 
IF brstat.tlt.flag = "n" THEN DO:
    /*IF brstat.tlt.comp_sub = "A0M2010" THEN DO: */ /*A64-0092*/
    IF brstat.tlt.comp_sub = "A0M2010" OR brstat.tlt.comp_sub = "B3MLTIS102"  THEN DO:  /*A64-0092*/
        /* ใช้โค้ดเดิม */
        ASSIGN brstat.tlt.comp_sub = "B3MLTIS102". /*A64-0092*/
    END.
    ELSE DO:
        IF  index(brstat.tlt.brand,"FORD RANGER") <> 0 THEN DO:
            IF brstat.tlt.lince2 = trim(fi_year) THEN DO: /* A60-0095 */
                ASSIGN brstat.tlt.comp_sub      = fi_producernewf 
                       brstat.tlt.comp_noti_ins = fi_agentnewfo .
            END.
            /*A62-0092*/
            ELSE IF INDEX(brstat.tlt.filler2,"FE2+") <> 0 THEN DO:  
                 ASSIGN brstat.tlt.comp_sub      = fi_producernewf 
                       brstat.tlt.comp_noti_ins = fi_agentnewfo .
            END.
            /* end A64-0092 */
            /*--A60-0225---*/
            ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                       brstat.tlt.comp_noti_ins = fi_agentNCIR .
            END.
            /*-- end : A60-0225---*/
            ELSE 
                ASSIGN  brstat.tlt.comp_sub      = fi_producernewtis              
                        brstat.tlt.comp_noti_ins = fi_agentnewtis .
        END.
        /*-- start : A59-0618 --*/
        ELSE IF index(brstat.tlt.brand,"FORD") <> 0 THEN DO:
            IF brstat.tlt.lince2 = trim(fi_year) THEN DO:  /* A60-0095 */
            ASSIGN brstat.tlt.comp_sub      =  fi_producernewf2
                   brstat.tlt.comp_noti_ins =  fi_agentnewfo2 .
            END.
            /*A62-0092*/
            ELSE IF INDEX(brstat.tlt.filler2,"FE2+") <> 0 THEN DO:  
                 ASSIGN brstat.tlt.comp_sub      = fi_producernewf 
                       brstat.tlt.comp_noti_ins = fi_agentnewfo .
            END.
            /* end A64-0092 */
            /*--A60-0225---*/
            ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                       brstat.tlt.comp_noti_ins = fi_agentNCIR .
            END.
            /*-- end : A60-0225---*/
            ELSE 
               ASSIGN  brstat.tlt.comp_sub      = fi_producernewtis              
                       brstat.tlt.comp_noti_ins = fi_agentnewtis .
        END.
        /* comment by A62-0386 .....
        ELSE IF  index(brstat.tlt.brand,"MAZDA") <> 0 THEN DO:   /*case : Mazda */
            IF brstat.tlt.lince2 = trim(fi_year) THEN DO: /* A60-0095 */
                /*--A60-0225---*/
                IF ((brstat.tlt.nor_grprm = 17148.89  OR brstat.tlt.nor_grprm = 18986.08 OR
                     brstat.tlt.nor_grprm = 16536.85  OR brstat.tlt.nor_grprm = 17760.93 OR 
                     brstat.tlt.nor_grprm = 46546.07  OR brstat.tlt.nor_grprm = 51445.60 )) THEN DO:
                    ASSIGN brstat.tlt.comp_sub      = fi_producerMPI
                           brstat.tlt.comp_noti_ins = fi_agentMPI .
                END.
                ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                           brstat.tlt.comp_noti_ins = fi_agentNCIR .
                END.
                /*-- end : A60-0225---*/
                ELSE 
                ASSIGN brstat.tlt.comp_sub      = fi_producerma
                       brstat.tlt.comp_noti_ins = fi_agentma .
            END.
            /*--- A60-0225-----*/
            ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                           brstat.tlt.comp_noti_ins = fi_agentNCIR .
            END.
            /*-- end : A60-0225---*/
            ELSE 
                ASSIGN  brstat.tlt.comp_sub      = fi_producermar 
                        brstat.tlt.comp_noti_ins = fi_agentmar . 
        END.
        ... end A62-0386....*/
        ELSE IF  index(brstat.tlt.brand,"ISUZU") <> 0 THEN DO:   /*case : ISUZU */
            /* comment by : Ranu I. A64-0092 ไม่เช็คเบี้ยแล้ว ....
            IF brstat.tlt.lince2 = trim(fi_year)  AND  (brstat.tlt.comp_coamt = 17355.40  OR  
               brstat.tlt.comp_coamt  = 17033.33  OR   brstat.tlt.comp_coamt  = 20855.37  OR  
               brstat.tlt.comp_coamt = 21566.22 )  THEN DO: /* A60-0095 */
                ASSIGN brstat.tlt.comp_sub         = fi_produceris
                       brstat.tlt.comp_noti_ins    = fi_agentis.
            END.
            ... end A64-0092 ..*/
            /* start : A64-0092  รถบรรทุก */
            IF index(brstat.tlt.brand,"Wheels") <> 0 OR index(brstat.tlt.brand,"Trailer") <> 0 THEN DO: 
                 ASSIGN brstat.tlt.comp_sub      = fi_pdtkcode   
                        brstat.tlt.comp_noti_ins = fi_agtkcode .
            END.
            /* end A64-0092*/
             /*--- A60-0225-----*/
            ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                           brstat.tlt.comp_noti_ins = fi_agentNCIR .
            END.
            /*-- end : A60-0225--*/
            /* start : A64-0092  รถเล็ก */
            ELSE IF brstat.tlt.lince2 = trim(fi_year) THEN DO: 
                ASSIGN brstat.tlt.comp_sub         = fi_produceris
                       brstat.tlt.comp_noti_ins    = fi_agentis.
            END.
            /* end A64-0092*/
            ELSE 
                ASSIGN  brstat.tlt.comp_sub     = fi_producernewtis              
                       brstat.tlt.comp_noti_ins = fi_agentnewtis .
        END.
        /*--- A60-0225-----*/
        ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                       brstat.tlt.comp_noti_ins = fi_agentNCIR .
        END.
        /*-- end : A60-0225--*/
         /* A64-0092 */
        ELSE IF index(brstat.tlt.brand,"HINO") <> 0 OR index(brstat.tlt.brand,"Trailer") <> 0 THEN DO: /*รถบรรทุก */
            ASSIGN brstat.tlt.comp_sub      = fi_pdtkcode   
                   brstat.tlt.comp_noti_ins = fi_agtkcode .
        END.
        ELSE IF index(brstat.tlt.brand,"YAMAHA") <> 0 OR index(brstat.tlt.brand,"TRIUMPH") <> 0 OR index(brstat.tlt.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                       brstat.tlt.comp_noti_ins = fi_agbkcode .
        END.
        ELSE IF (index(brstat.tlt.brand,"SUZUKI") <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) OR 
                (index(brstat.tlt.brand,"HONDA")  <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) AND
                (index(brstat.tlt.filler2,"Deduct") <> 0 OR index(brstat.tlt.filler2,"DD") <> 0 ) THEN DO: /* bigbike*/
                ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                       brstat.tlt.comp_noti_ins = fi_agbkcode .
        END.
        /* end A64-0092 */
        ELSE ASSIGN  brstat.tlt.comp_sub        = fi_producernewtis              
                     brstat.tlt.comp_noti_ins   = fi_agentnewtis .
        
        IF trim(SUBSTR(brstat.tlt.expousr,1,3)) <> "1" AND index(brstat.tlt.nor_noti_tlt,"TISTY") <> 0  THEN DO:
             /*--- A60-0225-----*/
            IF INDEX(brstat.tlt.nor_usr_tlt,"CIN(FEET)") <> 0 THEN DO:
                    ASSIGN brstat.tlt.comp_sub      = fi_producerNCIR   
                           brstat.tlt.comp_noti_ins = fi_agentNCIR .
            END.
            /*-- end : A60-0225--*/
            /* A64-0092 */
            ELSE IF index(brstat.tlt.brand,"HINO") <> 0 OR index(brstat.tlt.brand,"Trailer") <> 0 THEN DO: /*รถบรรทุก */
                ASSIGN brstat.tlt.comp_sub      = fi_pdtkcode   
                       brstat.tlt.comp_noti_ins = fi_agtkcode .
            END.
            ELSE IF index(brstat.tlt.brand,"YAMAHA") <> 0 OR index(brstat.tlt.brand,"TRIUMPH") <> 0 OR index(brstat.tlt.brand,"KAWASAKI") <> 0 THEN DO:  /* bigbike*/
                    ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                           brstat.tlt.comp_noti_ins = fi_agbkcode .
            END.
            ELSE IF (index(brstat.tlt.brand,"SUZUKI") <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) OR 
                    (index(brstat.tlt.brand,"HONDA")  <> 0 AND DECI(brstat.tlt.rencnt) < 1000 ) AND
                    (index(brstat.tlt.filler2,"Deduct") <> 0 OR index(brstat.tlt.filler2,"DD") <> 0 ) THEN DO: /* bigbike*/
                    ASSIGN brstat.tlt.comp_sub      = fi_pdbkcode   
                           brstat.tlt.comp_noti_ins = fi_agbkcode .
            END.
            /* end A64-0092 */
            ELSE IF brstat.tlt.rec_addr3 <> "17" THEN DO:
                ASSIGN brstat.tlt.comp_sub         = "B3MLTIS103"  /*"A0M2011"*/ /*A64-0092*/ 
                       brstat.tlt.comp_noti_ins    = "B3MLTIS100"  /*"B3M0002"*/ /*A64-0092*/ .
            END.
            ELSE 
                ASSIGN brstat.tlt.comp_sub         = fi_producernewtis
                       brstat.tlt.comp_noti_ins    = fi_agentnewtis.
        END.
    END.
END.
ELSE DO: /* renew*/
    /*IF brstat.tlt.comp_sub = "A0M2010"   THEN DO:  /*A61-0410 */ */ /*A64-0092*/
    IF brstat.tlt.comp_sub = "A0M2010" OR brstat.tlt.comp_sub = "B3MLTIS102"   THEN DO:   /*A64-0092*/
        /* ใช้โค้ดเดิม */
        ASSIGN brstat.tlt.comp_sub = "B3MLTIS102".  /*A64-0092*/
    END.
    ELSE DO:
        IF INDEX(brstat.tlt.rec_addr2,"SAFETY INSURANCE") <> 0 THEN DO:
            IF INDEX(brstat.tlt.safe1,"ระบุ 8.3") <> 0 AND INDEX(brstat.tlt.safe1,"ไม่ระบุ 8.3") = 0  THEN DO:   /*case : add 8.3 */
                IF  index(brstat.tlt.brand,"FORD")          <> 0  AND
                    index(brstat.tlt.filler2,"FORD ENSURE") <> 0  OR
                    INDEX(brstat.tlt.filler2,"FD")          <> 0  OR
                    INDEX(brstat.tlt.filler2,"FE2+")        <> 0  OR   /*A62-0092*/
                    SUBSTRING(brstat.tlt.filler1,7,1)     = "F"  /*AND 
                    brstat.tlt.stat                        = "0"  AND   /*A64-0223*/
                    brstat.tlt.expousr                     = "1" )  -- A64-0271 --*/ /*A64-0223*/
                    THEN DO: /*case : Ford  */
                    ASSIGN brstat.tlt.comp_sub       = fi_producerford
                           brstat.tlt.comp_noti_ins  = fi_agentford  .
                END.
                /*--A60-0225---*/
                ELSE IF  index(brstat.tlt.brand,"MAZDA")     <> 0   AND 
                         /*SUBSTRING(brstat.tlt.filler1,7,2)  = "MI"  OR */ /*A62-0386*/
                         INDEX(brstat.tlt.filler2,"MPI")    <> 0   THEN DO:   /*A61-0313*/
                          ASSIGN  brstat.tlt.comp_sub       = fi_producerMI
                                  brstat.tlt.comp_noti_ins  = fi_agentMI
                                  n_product                 = "MPI" .     /*A61-0313*/  
                END.
                ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                      ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                             brstat.tlt.comp_noti_ins = fi_agentCIR .
                END.
                /*-- end : A60-0225---*/
                ELSE                                 
                    ASSIGN brstat.tlt.comp_sub       = fi_producer83      
                           brstat.tlt.comp_noti_ins  = fi_agent83.
            END.
            ELSE DO:
                IF  index(brstat.tlt.brand,"FORD")          <> 0 AND 
                    index(brstat.tlt.filler2,"FORD ENSURE") <> 0 OR
                    INDEX(brstat.tlt.filler2,"FD")          <> 0 OR
                    INDEX(brstat.tlt.filler2,"FE2+")        <> 0 OR   /*A62-0092*/
                    SUBSTRING(brstat.tlt.filler1,7,1)     = "F"  /*AND 
                    brstat.tlt.stat                        = "0"  AND               /*A64-0223*/
                    brstat.tlt.expousr                     = "1" )-- A64-0271 --*/  /*A64-0223*/
                    THEN DO:
                     ASSIGN brstat.tlt.comp_sub       = fi_producerford
                            brstat.tlt.comp_noti_ins  = fi_agentford  .
                END.
                /* create by A61-0410 */
                ELSE IF index(brstat.tlt.brand,"MAZDA")   <> 0   AND 
                     /*SUBSTRING(brstat.tlt.filler1,7,2) = "MI" OR */ /*A62-0386*/
                     INDEX(brstat.tlt.filler2,"MPI")   <> 0   THEN DO: /*A61-0313*/
                     ASSIGN  brstat.tlt.comp_sub       = fi_producerMI
                             brstat.tlt.comp_noti_ins  = fi_agentMI.
                END.
                /* end A61-0410 */
                /*---A60-0225--*/
                ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                      ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                             brstat.tlt.comp_noti_ins = fi_agentCIR .
                END.
                /*-- end : A60-0225---*/
                ELSE                                  
                    ASSIGN brstat.tlt.comp_sub        = fi_producerno83      
                           brstat.tlt.comp_noti_ins   = fi_agentno83.
            END.
            /* add 02/09/2020 */
            IF (trim(SUBSTR(brstat.tlt.expousr,1,3)) = "2.2") THEN DO:
                ASSIGN   brstat.tlt.comp_sub       =  "B3M0033"
                         brstat.tlt.comp_noti_ins  =  "B3M0035".  

            END.
            /* add 02/09/2020 */

            /*IF  index(wdetail.brand,"MAZDA") <> 0 THEN DO:   */      /*case : Mazda */ /*A61-0313*/
            /* comment by A61-0410.....
            IF  index(brstat.tlt.brand,"MAZDA") <> 0 THEN DO:         /*case : Mazda */ /*A61-0313*/
                 /*--A60-0225---*/
               IF index(brstat.tlt.brand,"MAZDA")   <> 0   AND 
                  SUBSTRING(brstat.tlt.filler1,7,2) = "MI" OR 
                  INDEX(brstat.tlt.filler2,"MPI")   <> 0   THEN DO: /*A61-0313*/
                  ASSIGN  brstat.tlt.comp_sub       = fi_producerMI
                          brstat.tlt.comp_noti_ins  = fi_agentMI.
                END.
                ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                      ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                             brstat.tlt.comp_noti_ins = fi_agentCIR .
                END.
                /*-- end : A60-0225---*/
                ELSE 
                    ASSIGN brstat.tlt.comp_sub         =  fi_producermar
                           brstat.tlt.comp_noti_ins    =  fi_agentmar  .
            END.
            ...end A61-0410.. */
        END.
        ELSE DO:
            /* Create by : A61-0410*/
            IF  index(brstat.tlt.brand,"FORD")          <> 0 AND 
                index(brstat.tlt.filler2,"FORD ENSURE") <> 0 OR
                INDEX(brstat.tlt.filler2,"FD")          <> 0 OR
                INDEX(brstat.tlt.filler2,"FE2+")        <> 0 OR   /*A62-0092*/
                SUBSTRING(brstat.tlt.filler1,7,1)     = "F"  /*AND 
                brstat.tlt.stat                        = "0"  AND  /*A64-0223*/
                brstat.tlt.expousr                     = "1" ) -- A64-0271 --*/ /*A64-0223*/
                THEN DO:
                 ASSIGN brstat.tlt.comp_sub       = fi_producerford
                        brstat.tlt.comp_noti_ins  = fi_agentford  .
            END.
            ELSE IF index(brstat.tlt.brand,"MAZDA")   <> 0   AND 
                 /*SUBSTRING(brstat.tlt.filler1,7,2) = "MI" OR */ /*a62-0386*/
                 INDEX(brstat.tlt.filler2,"MPI")   <> 0   THEN DO: 
                 ASSIGN  brstat.tlt.comp_sub       = fi_producerMI
                         brstat.tlt.comp_noti_ins  = fi_agentMI.
            END.
            /* end A61-0410 */
            /*---A60-0225--*/
            ELSE IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                  ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                         brstat.tlt.comp_noti_ins = fi_agentCIR .
            END.
            /*-- end : A60-0225---*/
            /* comment by : A61-0410 ....
            ELSE IF (trim(SUBSTR(brstat.tlt.expousr,1,3)) = "1") AND INDEX(brstat.tlt.safe1,"ระบุ 8.3") <> 0 
                  AND index(brstat.tlt.brand,"MAZDA") <> 0 THEN DO:
                  ASSIGN brstat.tlt.comp_sub      = fi_producermar 
                         brstat.tlt.comp_noti_ins = fi_agentmar  . 
            END.
            .... end A61-0410 */                                  
            /*ELSE DO:    */ /*a61-0410*/
            ELSE IF INDEX(brstat.tlt.safe1,"ระบุ 8.3") <> 0 THEN DO:
                  ASSIGN brstat.tlt.comp_sub      = fi_producer83
                         brstat.tlt.comp_noti_ins = fi_agent83.
            END.
            ELSE /*A64-0271*/
                IF (trim(SUBSTR(brstat.tlt.expousr,1,3)) <> "1") AND (INDEX(brstat.tlt.rec_addr2,"SAFETY INSURANCE") = 0 ) THEN DO:
                /*---A60-0225--*/
                IF INDEX(brstat.tlt.nor_usr_tlt,"CIR(RETAIL)") <> 0 THEN DO:
                      ASSIGN brstat.tlt.comp_sub      = fi_producerCIR   
                             brstat.tlt.comp_noti_ins = fi_agentCIR .
                END.
                /* add 02/09/2020 */
                ELSE IF (trim(SUBSTR(brstat.tlt.expousr,1,3)) = "2.2") THEN DO:
                    ASSIGN   brstat.tlt.comp_sub       =  "B3M0033"
                             brstat.tlt.comp_noti_ins  =  "B3M0035".  

                END.
                /* end 02/09/2020*/
                /*-- end : A60-0225---*/
                ELSE 
                    ASSIGN   /*brstat.tlt.exp             =  "M"*/
                             brstat.tlt.exp             =  "ML" 
                             /*brstat.tlt.comp_sub      =  "A0M2011"*/      /*A64-0092*/
                             brstat.tlt.comp_sub        =  "B3MLTIS103"     /*A64-0092*/
                             brstat.tlt.comp_noti_ins   =  "B3MLTIS100".    /*A64-0092*/
                             /*brstat.tlt.comp_noti_ins =  "B3M0002".*/     /*A61-0313*/
                             /*brstat.tlt.comp_noti_ins   =  "B3M0035". */  /*A61-0313*/   /*A64-0092*/
            END.
        END.
    END. /* <> A0M2010 */
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_poladdress C-Win 
PROCEDURE proc_poladdress :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
/* add by : A64-0271 */
IF wdetail.mail_add2  = "" THEN DO:
    IF (INDEX(wdetail.country,"กทม") <> 0 ) OR (INDEX(wdetail.country,"กรุงเทพ") <> 0 ) THEN DO:
        ASSIGN wdetail.tambon     = IF trim(wdetail.tambon)  = "" THEN "" ELSE "แขวง" + trim(wdetail.tambon)  
               wdetail.amper      = IF trim(wdetail.amper)   = "" THEN "" ELSE "เขต"  + trim(wdetail.amper)
               wdetail.country    = "กรุงเทพมหานคร" 
               wdetail.country    = IF trim(wdetail.country) = "" THEN "" ELSE trim(wdetail.country) + " " + trim(wdetail.post).
    END.
    ELSE DO:
        /* Create by A59-0618 */
         ASSIGN 
         wdetail.tambon  = IF trim(wdetail.tambon)  = "" THEN "" 
                           ELSE IF INDEX(wdetail.tambon,"ตำบล") = 0 THEN "ตำบล" + trim(wdetail.tambon) 
                           ELSE trim(wdetail.tambon) 
         wdetail.amper   = IF trim(wdetail.amper)   = "" THEN "" 
                           ELSE IF index(wdetail.amper,"อำเภอ") = 0 THEN  "อำเภอ" + trim(wdetail.amper)
                           ELSE  trim(wdetail.amper)                    
         wdetail.country = IF trim(wdetail.country) = "" THEN "" 
                           ELSE IF index(wdetail.country,"จังหวัด") = 0 THEN  "จังหวัด" + trim(wdetail.country) + " " + trim(wdetail.post) 
                           ELSE trim(wdetail.country) + " " + trim(wdetail.post) .
         
    END.
END.
ELSE DO: 
    /*country */
    ASSIGN  
        wdetail.mail_add1 = trim(wdetail.mail_add1)  + " " + trim(wdetail.mail_add2) .
    IF index(wdetail.mail_add1,"ธนาคารทิสโก้") <> 0  THEN DO:
        
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"กทม") <> 0  THEN DO:
        ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กทม"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กทม") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"กรุงเทพ") <> 0  THEN DO:
        ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กรุงเทพ"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กรุงเทพ") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"จ.") <> 0  THEN DO:
        ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"จ."))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"จ.") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"จังหวัด") <> 0  THEN DO:
        ASSIGN wdetail.country = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"จังหวัด"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"จังหวัด") - 1 ).
    END.
    /*Amper */
    IF r-INDEX(wdetail.mail_add1,"อ.") <> 0  THEN DO:
        ASSIGN wdetail.amper   = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"อ."))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"อ.") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ") <> 0  THEN DO:
        ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"กิ่งอำเภอ") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"อำเภอ") <> 0  THEN DO:
        ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"อำเภอ"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"อำเภอ") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"เขต") <> 0  THEN DO:
        ASSIGN wdetail.amper = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"เขต"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"เขต") - 1 ).
    END.
    /*tambon*/
    IF r-INDEX(wdetail.mail_add1,"ต.") <> 0  THEN DO:
        ASSIGN wdetail.tambon   = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"ต."))
            wdetail.mail_add1   = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"ต.") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"ตำบล") <> 0  THEN DO:
        ASSIGN wdetail.tambon = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"ตำบล"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"ตำบล") - 1 ).
    END.
    ELSE IF r-INDEX(wdetail.mail_add1,"แขวง") <> 0  THEN DO:
        ASSIGN wdetail.tambon = SUBSTR(wdetail.mail_add1,r-INDEX(wdetail.mail_add1,"แขวง"))
            wdetail.mail_add1  = SUBSTR(wdetail.mail_add1,1,r-INDEX(wdetail.mail_add1,"แขวง") - 1 ).
    END.
END.  /*else wdetail.mail_add2 <> ""*/

if index(wdetail.tambon,"ต.")  <> 0 THEN ASSIGN wdetail.tambon  = REPLACE(wdetail.tambon,"ต.","ตำบล").
IF index(wdetail.amper,"อ.")   <> 0 THEN ASSIGN wdetail.amper   = REPLACE(wdetail.amper,"อ.","อำเภอ").
if index(wdetail.country,"จ.") <> 0 THEN ASSIGN wdetail.country = REPLACE(wdetail.country,"จ.","จังหวัด") .
/*... end A64-0271...*/
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
 IF INDEX(wdetail.re_country,".") <> 0 THEN REPLACE(wdetail.re_country,".","").

 IF      wdetail.re_country = "ANG THONG"          THEN wdetail.re_country = "อท".
 ELSE IF wdetail.re_country = "ANGTHONG"           THEN wdetail.re_country = "อท".
 ELSE IF wdetail.re_country = "ANG-THONG"          THEN wdetail.re_country = "อท".
 ELSE IF wdetail.re_country = "AYUTTHAYA"          THEN wdetail.re_country = "อย".
 ELSE IF wdetail.re_country = "BKK"                THEN wdetail.re_country = "กท". /*-A59-0503-*/ /* open A60-0095*/
 ELSE IF wdetail.re_country = "BANGKOK"            THEN wdetail.re_country = "กท".
 ELSE IF wdetail.re_country = "BURIRAM"            THEN wdetail.re_country = "บร".
 ELSE IF wdetail.re_country = "CHAI NAT"           THEN wdetail.re_country = "ชน".
 ELSE IF wdetail.re_country = "CHAI-NAT"           THEN wdetail.re_country = "ชน".
 ELSE IF wdetail.re_country = "CHANTHABURI"        THEN wdetail.re_country = "จบ".
 ELSE IF wdetail.re_country = "CHIANG MAI"         THEN wdetail.re_country = "ชม".
 ELSE IF wdetail.re_country = "CHIANGMAI"          THEN wdetail.re_country = "ชม".
 ELSE IF wdetail.re_country = "CHONBURI"           THEN wdetail.re_country = "ชบ".
 ELSE IF wdetail.re_country = "KALASIN"            THEN wdetail.re_country = "กส".
 ELSE IF wdetail.re_country = "KANCHANABURI"       THEN wdetail.re_country = "กจ".
 ELSE IF wdetail.re_country = "KHON KAEN"          THEN wdetail.re_country = "ขก".
 ELSE IF wdetail.re_country = "KHONKAEN"           THEN wdetail.re_country = "ขก".
 ELSE IF wdetail.re_country = "KRABI"              THEN wdetail.re_country = "กบ".
 ELSE IF wdetail.re_country = "LOPBURI"            THEN wdetail.re_country = "ลบ".
 ELSE IF wdetail.re_country = "NAKHON NAYOK"       THEN wdetail.re_country = "นย".
 ELSE IF wdetail.re_country = "NAKHONNAYOK"        THEN wdetail.re_country = "นย".
 ELSE IF wdetail.re_country = "NAKHON PATHOM"      THEN wdetail.re_country = "นฐ".
 ELSE IF wdetail.re_country = "NAKHONPATHOM"       THEN wdetail.re_country = "นฐ".
 ELSE IF wdetail.re_country = "NAKHON RATCHASIMA"  THEN wdetail.re_country = "นม".
 ELSE IF wdetail.re_country = "NAKHONRATCHASIMA"   THEN wdetail.re_country = "นม".
 ELSE IF wdetail.re_country = "NAKHON SITHAMMARAT" THEN wdetail.re_country = "นศ".
 ELSE IF wdetail.re_country = "NAKHONSITHAMMARAT"  THEN wdetail.re_country = "นศ".
 ELSE IF wdetail.re_country = "NONTHABURI"         THEN wdetail.re_country = "นบ".
 ELSE IF wdetail.re_country = "PHETCHABURI"        THEN wdetail.re_country = "พบ".
 ELSE IF wdetail.re_country = "PHUKET"             THEN wdetail.re_country = "ภก".
 ELSE IF wdetail.re_country = "PHITSANULOK"        THEN wdetail.re_country = "พล".
 ELSE IF wdetail.re_country = "PRACHINBURI"        THEN wdetail.re_country = "ปจ".
 ELSE IF wdetail.re_country = "RATCHABURI"         THEN wdetail.re_country = "รบ".
 ELSE IF wdetail.re_country = "RAYONG"             THEN wdetail.re_country = "รย".
 ELSE IF wdetail.re_country = "ROI ET"             THEN wdetail.re_country = "รอ".
 ELSE IF wdetail.re_country = "ROI-ET"             THEN wdetail.re_country = "รอ".
 ELSE IF wdetail.re_country = "ROIET"              THEN wdetail.re_country = "รอ".
 ELSE IF wdetail.re_country = "SARABURI"           THEN wdetail.re_country = "สบ".
 ELSE IF wdetail.re_country = "SRISAKET"           THEN wdetail.re_country = "ศก".
 ELSE IF wdetail.re_country = "SONGKHLA"           THEN wdetail.re_country = "สข".
 ELSE IF wdetail.re_country = "SA KAEO"            THEN wdetail.re_country = "สก".
 ELSE IF wdetail.re_country = "SAKAEO"             THEN wdetail.re_country = "สก".
 ELSE IF wdetail.re_country = "SUPHANBURI"         THEN wdetail.re_country = "สพ".
/* ELSE IF wdetail.re_country = "SURAT THANI"        THEN wdetail.re_country = "สฏ".
 ELSE IF wdetail.re_country = "SURATTHANI"         THEN wdetail.re_country = "สฏ".   A63-0210 */
 ELSE IF wdetail.re_country = "SURAT THANI"        THEN wdetail.re_country = "สฎ".  
 ELSE IF wdetail.re_country = "SURATTHANI"         THEN wdetail.re_country = "สฎ".   /* A63-0210 */ 
 ELSE IF wdetail.re_country = "TRANG"              THEN wdetail.re_country = "ตง".
 ELSE IF wdetail.re_country = "UBON RATCHATHANI"   THEN wdetail.re_country = "อบ".
 ELSE IF wdetail.re_country = "UBONRATCHATHANI"    THEN wdetail.re_country = "อบ".
 ELSE IF wdetail.re_country = "UDON THANI"         THEN wdetail.re_country = "อด".
 ELSE IF wdetail.re_country = "UDONTHANI"          THEN wdetail.re_country = "อด".
 ELSE IF wdetail.re_country = "AMNAT CHAROEN"      THEN wdetail.re_country = "อจ".
 ELSE IF wdetail.re_country = "AMNATCHAROEN"       THEN wdetail.re_country = "อจ".
 ELSE IF wdetail.re_country = "CHAIYAPHUM"         THEN wdetail.re_country = "ชย".
 ELSE IF wdetail.re_country = "CHIANG RAI"         THEN wdetail.re_country = "ชร".
 ELSE IF wdetail.re_country = "CHIANGRAI"          THEN wdetail.re_country = "ชร".
 ELSE IF wdetail.re_country = "CHUMPHON"           THEN wdetail.re_country = "ชพ".
 ELSE IF wdetail.re_country = "KAMPHAENG PHET"     THEN wdetail.re_country = "กพ".
 ELSE IF wdetail.re_country = "KAMPHAENGPHET"      THEN wdetail.re_country = "กพ".
 ELSE IF wdetail.re_country = "LAMPANG"            THEN wdetail.re_country = "ลป".
 ELSE IF wdetail.re_country = "LAMPHUN"            THEN wdetail.re_country = "ลพ".
 ELSE IF wdetail.re_country = "NAKHON SAWAN"       THEN wdetail.re_country = "นว".
 ELSE IF wdetail.re_country = "NAKHONSAWAN"        THEN wdetail.re_country = "นว".
 ELSE IF wdetail.re_country = "NONG KHAI"          THEN wdetail.re_country = "นค".
 ELSE IF wdetail.re_country = "NONGKHAI"           THEN wdetail.re_country = "นค".
 ELSE IF wdetail.re_country = "PATHUM THANI"       THEN wdetail.re_country = "ปท".
 ELSE IF wdetail.re_country = "PATHUMTHANI"        THEN wdetail.re_country = "ปท".
 ELSE IF wdetail.re_country = "PATTANI"            THEN wdetail.re_country = "ปน".
 ELSE IF wdetail.re_country = "PHATTHALUNG"        THEN wdetail.re_country = "พท".
 ELSE IF wdetail.re_country = "PHETCHABUN"         THEN wdetail.re_country = "พช".
 ELSE IF wdetail.re_country = "SAKON NAKHON"       THEN wdetail.re_country = "สน".
 ELSE IF wdetail.re_country = "SING BURI"          THEN wdetail.re_country = "สห".
 ELSE IF wdetail.re_country = "SINGBURI"           THEN wdetail.re_country = "สห".
 ELSE IF wdetail.re_country = "SURIN"              THEN wdetail.re_country = "สร".
 ELSE IF wdetail.re_country = "YASOTHON"           THEN wdetail.re_country = "ยส".
 ELSE IF wdetail.re_country = "YALA"               THEN wdetail.re_country = "ยล".
 ELSE IF wdetail.re_country = "BAYTONG"            THEN wdetail.re_country = "บต".
 ELSE IF wdetail.re_country = "CHACHOENGSAO"       THEN wdetail.re_country = "ฉช".
 ELSE IF wdetail.re_country = "LOEI"               THEN wdetail.re_country = "ลย".
 ELSE IF wdetail.re_country = "MAE HONG SON"       THEN wdetail.re_country = "มส".
 ELSE IF wdetail.re_country = "MAEHONGSON"         THEN wdetail.re_country = "มส".
 ELSE IF wdetail.re_country = "MAHA SARAKHAM"      THEN wdetail.re_country = "มค".
 ELSE IF wdetail.re_country = "MAHASARAKHAM"       THEN wdetail.re_country = "มค".
 ELSE IF wdetail.re_country = "MUKDAHAN"           THEN wdetail.re_country = "มห".
 ELSE IF wdetail.re_country = "NAN"                THEN wdetail.re_country = "นน".
 ELSE IF wdetail.re_country = "NARATHIWAT"         THEN wdetail.re_country = "นธ".
 ELSE IF wdetail.re_country = "NONG BUA LAMPHU"    THEN wdetail.re_country = "นภ".
 ELSE IF wdetail.re_country = "NONGBUALAMPHU"      THEN wdetail.re_country = "นภ".
 ELSE IF wdetail.re_country = "PHAYAO"             THEN wdetail.re_country = "พย".  
 ELSE IF wdetail.re_country = "PHANG NGA"          THEN wdetail.re_country = "พง".
 ELSE IF wdetail.re_country = "PHANGNGA"           THEN wdetail.re_country = "พง".
 ELSE IF wdetail.re_country = "PHRAE"              THEN wdetail.re_country = "พร".
 ELSE IF wdetail.re_country = "PHICHIT"            THEN wdetail.re_country = "พจ".
 ELSE IF wdetail.re_country = "PRACHUAP KHIRIKHAN" THEN wdetail.re_country = "ปข".
 ELSE IF wdetail.re_country = "PRACHUAPKHIRIKHAN"  THEN wdetail.re_country = "ปข".
 ELSE IF wdetail.re_country = "RANONG"             THEN wdetail.re_country = "รน".
 ELSE IF wdetail.re_country = "SAMUT PRAKAN"       THEN wdetail.re_country = "สป".
 ELSE IF wdetail.re_country = "SAMUT SAKHON"       THEN wdetail.re_country = "สค". 
 ELSE IF wdetail.re_country = "SAMUT SONGKHRAM"    THEN wdetail.re_country = "สส".
 ELSE IF wdetail.re_country = "SAMUTPRAKAN"        THEN wdetail.re_country = "สป".  
 ELSE IF wdetail.re_country = "SAMUTSAKHON"        THEN wdetail.re_country = "สค".  
 ELSE IF wdetail.re_country = "SAMUTSONGKHRAM"     THEN wdetail.re_country = "สส".  
 ELSE IF wdetail.re_country = "SATUN"              THEN wdetail.re_country = "สต".
 ELSE IF wdetail.re_country = "SUKHOTHAI"          THEN wdetail.re_country = "สท".
 ELSE IF wdetail.re_country = "TAK"                THEN wdetail.re_country = "ตก".
 ELSE IF wdetail.re_country = "TRAT"               THEN wdetail.re_country = "ตร".
 ELSE IF wdetail.re_country = "UTHAI THANI"        THEN wdetail.re_country = "อน".
 ELSE IF wdetail.re_country = "UTHAITHANI"         THEN wdetail.re_country = "อน".
 ELSE IF wdetail.re_country = "UTTARADIT"          THEN wdetail.re_country = "อต".
 ELSE IF wdetail.re_country = "NAKHON PHANOM"      THEN wdetail.re_country = "นพ". 
 ELSE IF wdetail.re_country = "NAKHONPHANOM"       THEN wdetail.re_country = "นพ". 
 ELSE IF wdetail.re_country = "BUENG KAN"          THEN wdetail.re_country = "บก".
 ELSE IF wdetail.re_country = "BUENGKAN"           THEN wdetail.re_country = "บก". 
 ELSE IF wdetail.re_country = "กทม"                THEN wdetail.re_country = "กท".  /*a60-0095*/
 ELSE DO:
    FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
         brstat.insure.compno = "999" AND 
         brstat.insure.FName  = TRIM(wdetail.re_country) NO-LOCK NO-WAIT NO-ERROR.
     IF AVAIL brstat.insure THEN   
         ASSIGN wdetail.re_country = Insure.LName.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_updatetlt C-Win 
PROCEDURE proc_updatetlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_chano01 AS CHAR.


FIND LAST brstat.tlt   WHERE   
    brstat.tlt.cha_no  =  trim(nv_chano01) AND    
    brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.    
IF AVAIL brstat.tlt THEN DO:
    IF INDEX(brstat.tlt.releas,"yes") = 0 THEN ASSIGN brstat.tlt.releas =  "yes".
    ASSIGN 
        brstat.tlt.nor_noti_ins  = trim(wdetail.pol70)   
        brstat.tlt.ndate1        = TODAY. 

    OUTPUT TO "d:\temp\log_mattisco.txt" APPEND.
    PUT "005Found:"  brstat.tlt.cha_no    FORMAT "X(50)" 
        brstat.tlt.releas
        SKIP.
    OUTPUT CLOSE.
END.
ELSE DO:
    OUTPUT TO "d:\temp\log_mattisco.txt" APPEND.
    PUT "006Not Found:" trim(nv_chano01)  FORMAT "X(50)"   SKIP.
    OUTPUT CLOSE. 
END.
RELEASE brstat.tlt .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_vehreg C-Win 
PROCEDURE proc_vehreg :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: create by A60-0095      
------------------------------------------------------------------------------*/
DEF VAR nv_num AS CHAR INIT "".
DEF VAR nv_lengt AS INT INIT 0.
IF wdetail.vehreg  <> "" THEN DO:
    ASSIGN nv_num = ""  
           nv_lengt = 0.

    IF INDEX(wdetail.vehreg,"-") <> 0 THEN DO:
        ASSIGN wdetail.vehreg = REPLACE(wdetail.vehreg,"-"," ") .
    END.
    ELSE IF INDEX(wdetail.vehreg,"ป้ายแดง") <> 0 THEN ASSIGN wdetail.vehreg = "ป้ายแดง".
    ELSE DO:
        IF INDEX(wdetail.vehreg,"  ") <> 0  THEN ASSIGN wdetail.vehreg = REPLACE(wdetail.vehreg,"  ","") .
        IF INDEX(wdetail.vehreg," ")  <> 0  THEN ASSIGN wdetail.vehreg = REPLACE(wdetail.vehreg," ","") .

        nv_num   = trim(SUBSTR(wdetail.vehreg,1,1)).
        IF index("01234756890",nv_num) <> 0 THEN DO:
           ASSIGN wdetail.vehreg = trim(SUBSTR(wdetail.vehreg,1,3)) + " " + 
                                   trim(SUBSTR(wdetail.vehreg,4,LENGTH(wdetail.vehreg))).
        END.
        ELSE DO: 
            ASSIGN wdetail.vehreg = trim(SUBSTR(wdetail.vehreg,1,2)) + " " + 
                                    trim(SUBSTR(wdetail.vehreg,3,LENGTH(wdetail.vehreg))).
        END.
    END.
    RUN proc_province.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_cnt    =   0
    nv_row    =  1
    ind_f1    = r-index(nv_file1,"\") + 1
    nv_file1  = SUBSTR(nv_file1,ind_f1)
    nv_file1  = SUBSTR(nv_file1,1,R-INDEX(nv_file1,".") - 1 )
    ind_f1    = r-index(nv_file2,"\") + 1
    nv_file2 = SUBSTR(nv_file2,ind_f1) 
    nv_file2 = SUBSTR(nv_file1,1,R-INDEX(nv_file2,".") - 1 ).

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
RUN proc_createfile2.
RELEASE brstat.tlt.
/*OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ."  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' string(TODAY)  '"' SKIP.

nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Processing Office "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' "CMR  code"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' "Insur.comp "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' "notify number" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' "year "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' "engine "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' "chassis  "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' "weight" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' "power  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "color "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "licence no"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "garage "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "fleet disc. " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ncb disc. " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "other disc. "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "vehuse "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "comdat  "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "sum si " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "ชื่อเจ้าหน้าที่ประกัน  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "รหัสเจ้าหน้าที่แจ้งประกัน " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "วันที่แจ้งประกัน  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "เวลาแจ้งประกัน "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "รหัสแจ้งงาน"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' " prem.1"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "comp.prm " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "sticker "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "brand "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "address1  "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "address2" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "address3" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "address4" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "title name  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "first name "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "last name"  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "beneficiary "    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "remark. " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "account no. " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "client No. "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "expiry date "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "insurance amt.  "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "province " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "receipt name  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "agent code " '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "บริษัทประกันภัยเดิม  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "old policy  "  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "deduct disc.  "  '"' SKIP.
for each wdetail WHERE wdetail.chasno  <> " "  no-lock.
    nv_cnt  =  nv_cnt  + 1.
    nv_row  =  nv_row + 1.
    wdetail.remark = wdetail.remark + nv_file1 + "_" + nv_file2.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail.Pro_off   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.cmr_code  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.comcode   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.policyno  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.caryear   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.eng       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.chasno    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.engcc     '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.power     '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.colorcode '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.vehreg    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.garage    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.fleetper  '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.ncb       '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.orthper   '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.vehuse    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.comdat    '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.si        '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.name_insur  '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.not_office  '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.entdat     '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.enttim      '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.not_code   '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.premt      '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.comp_prm   '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.stk        '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.brand      '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.mail_add1  '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.tambon     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.amper      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.country    '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.tiname     '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.insnam     '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.name2      '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.benname    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.remark     '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.Account_no   '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.client_no    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.expdat       '"' SKIP.                  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.gap          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.re_country   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.RECP_NAME '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.agent        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.prev_insur   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.prepol       '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.deduct       '"' SKIP. 
END.  /*  end  wdetail  */
nv_row  =  nv_row  + 1.  /*
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' " Total "   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' String(nv_cnt,"99999")  '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' " รายการ  "    '"' SKIP.*/

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfilepol C-Win 
PROCEDURE pro_createfilepol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ." 
    string(TODAY)   .
EXPORT DELIMITER "|" 
    "Processing Office "  /* wdetail.Pro_off   */  
    "CMR  code"           /* wdetail.cmr_code  */  
    "Insur.comp "         /* wdetail.comcode   */  
    "notify number"       /* wdetail.policyno  */ 
    "กรมธรรม์PREMIUM"     /* wdetail.policyno  */  
    "Caryear "            /* wdetail.caryear   */  
    "Engine "             /* wdetail.eng       */  
    "Chassis  "           /* wdetail.chasno    */  
    "Weight"              /* wdetail.engcc     */  
    "Power"               /* wdetail.power     */  
    "Color "              /* wdetail.colorcode */  
    "licence no"          /* wdetail.vehreg    */ 
    "garage "             /* wdetail.garage    */  
    "fleet disc. "        /* wdetail.fleetper  */  
    "ncb disc. "          /* wdetail.ncb       */  
    "other disc. "        /* wdetail.orthper   */  
    "vehuse "             /* wdetail.vehuse    */  
    "comdat  "            /* wdetail.comdat    */  
    "sum si "             /* wdetail.si        */ 
    "รหัสเจ้าหน้าที่แจ้งประกัน "  /* wdetail.not_office */ 
    "ชื่อเจ้าหน้าที่ประกัน  "     /* wdetail.name_insur */ 
    "วันที่แจ้งประกัน  "   /* wdetail.entdat     */  
    "เวลาแจ้งประกัน "      /* wdetail.enttim     */  
    "รหัสแจ้งงาน"          /* wdetail.not_code   */  
    "prem.1"               /* wdetail.premt      */  
    "comp.prm "            /* wdetail.comp_prm   */  
    "sticker "             /* wdetail.stk        */  
    "brand "               /* wdetail.brand      */  
    "address1"             /* wdetail.mail_add1  */  
    "address2"             /* wdetail.tambon     */  
    "address3"             /* wdetail.amper      */  
    "address4"             /* wdetail.country    */  
    "title name  "         /* wdetail.tiname     */  
    "first name "          /* wdetail.insnam     */  
   /* "last name"          /* wdetail.name2      */ */ 
    "beneficiary "         /* wdetail.benname    */  
    "remark. "             /* wdetail.remark     */  
    "account no. "         /* wdetail.Account_no */  
    "client No. "          /* wdetail.client_no  */  
    "expiry date "         /* wdetail.expdat     */  
    "insurance amt.  "     /* wdetail.gap        */ 
    "province "            /* wdetail.re_country */  
    "receipt name  "          /* wdetail.RECP_NAME  */ 
    "agent code "             /* wdetail.agent      */    
    "บริษัทประกันภัยเดิม "    /* wdetail.prev_insur    */    
    "กรมธรรม์ต่ออายุ"         /* wdetail.prepol        */ 
    "deduct disc."   
    "ที่อยู่หน้าตาราง70"   
    "ที่อยู่หน้าตาราง70 กรณีไม่แยกที่อยู่"   
    "ตำบล"   
    "อำเภอ"   
    "จังหวัด    "   
    "รหัสไปรษณีย์"   
    "ที่อยู่หน้าตาราง72 "   
    "ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่"   
    "ตำบล"   
    "อำเภอ"   
    "จังหวัด"   
    "รหัสไปรษณีย์"   
    "Applicationtype"   
    "Applicationcode"   
    "Blank"   
    "แพคเกจ"   
    "จำนวนที่นั่ง"   
    "ความเสียหายต่อคน"   
    "ความเสียหายต่อครั้ง"   
    "ความเสียหายต่อทรัพย์สิน"   
    "ประเภทความคุ้มครอง"   
    "Producer"   
    "Agent"   
    "สาขา"   
    "ประเภทกรมธรรม์"   
    "Redbook"   
    "Price_Ford"   
    "Yea"   
    "Brand_Model"   
    "Receipt ID. Number"   
    "Receipt Branch NAME"   
    "Receipt Compulsory ID. Number"   
    "Receipt Compulsory Branch Name"   
    "วันที่คุ้มครอง พรบ."   
    "วันที่สิ้นสุดความคุ้มครอง พรบ."   
    "ทุนสูญหายและไฟไหม้"   
    "รหัสรถ"   
    "ลักษณะการใช้รถ"   
    "ลำดับผู้ขับขี่คนที่ 1"   
    "ชื่อผู้ขับขี่1"   
    "วันเกิด1"   
    "อาชีพผู้ขับขี่คนที่ 1"   
    "ตำแหน่งงานผู้ขับขี่คนที่ 1"        
    "ลำดับผู้ขับขี่คนที่ 2"   
    "ชื่อผู้ขับขี่2"   
    "วันเกิด2"   
    "อาชีพผู้ขับขี่คนที่ 2"   
    "ตำแหน่งงานผู้ขับขี่คนที่ 2"        
    "ลำดับผู้ขับขี่คนที่ 3"   
    "ชื่อผู้ขับขี่คนที่ 3"   
    "วันเดือนปีเกิดผู้ขับขี่คนที่ 3"            
    "อาชีพผู้ขับขี่คนที่ 3"   
    "ตำแหน่งงานผู้ขับขี่คนที่ 3"        
    "BLANK"   
    "ชื่อที่ใช้บนใบเสร็จ(พรบ.)"       
    "อุปกรณ์เสริมพิเศษ"   
    "ReceiptName72"   
    "ReceiptAddr1"   
    "comment" 
    /* A67-0087 */
    "ช่องทางการขาย    "               
    "รถยนต์ไฟฟ้า Y/N  "               
    "ลำดับผู้ขับขี่คนที่ 4 "          
    "ชื่อผู้ขับขี่คนที่ 4  "          
    "วันเดือนปีเกิดผู้ขับขี่คนที่4"   
    "อาชีพผู้ขับขี่คนที่ 4 "          
    "ตำแหน่งงานผู้ขับขี่คนที่ 4   "   
    "ลำดับผู้ขับขี่คนที่ 5 "          
    "ชื่อผู้ขับขี่คนที่ 5  "          
    "วันเดือนปีเกิดผู้ขับขี่คนที่5"   
    "อาชีพผู้ขับขี่คนที่ 5 "          
    "ตำแหน่งงานผู้ขับขี่คนที่ 5   "   
    "แคมเปญ     "                     
    "ส่งรูปแทนการตรวจสภาพรถY/N   "    
    "จำนวนเลขเครื่อง  "               
    "หมายเลขเครื่องยนต์ 2  "          
    "หมายเลขเครื่องยนต์ 3  "          
    "หมายเลขเครื่องยนต์ 4  "          
    "หมายเลขเครื่องยนต์ 5  "          
    "รหัส พ.ร.บ."                     
    "ยี่ห้อรถ   "   .
/* end : A67-0087 */

FOR EACH wdetail no-lock.
     FIND LAST wdetail2 WHERE wdetail2.nppolicy = trim(wdetail.policyno) NO-LOCK NO-ERROR NO-WAIT.
     IF  AVAIL wdetail2 THEN DO:
            RUN Pro_Receipt72. /*A60-0095*/
          /* comment by a60-0095...
           IF INDEX(wdetail.remark,"ดีลเลอร์แถมพ") <> 0 THEN DO:
           ASSIGN                      /* ดีลเลอร์ */
               nv_72Reciept = SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/") + 1,LENGTH(wdetail.remark)).
               IF INDEX(nv_72Reciept,"จำกัด") <> 0  THEN  ASSIGN
                  nv_72Reciept = SUBSTR(nv_72Reciept,1,R-INDEX(nv_72Reciept,"จำกัด") + 4). 
           ELSE ASSIGN wdetail.reciept72 = nv_72Reciept .
           END.   
           ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์แถมเบี้ยและพ") <> 0 THEN   DO:            /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
               ASSIGN            
               nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมพ.ร.บ.") <> 0 THEN    DO:                     /* ประกัน */
              ASSIGN    
              nv_72Reciept  =  "ธนาคารทิสโก้ จำกัด (มหาชน) ".                             /*"ธนาคารทิสโก้ จำกัด (มหาชน) "*/
            END.
           ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมเบี้ยและพ") <> 0 THEN   DO:              /* ทิสโก้ เบี้ย/พ.ร.บ.  */
              ASSIGN             
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมเบี้ย และพ") <> 0 THEN   DO:              /* ทิสโก้ เบี้ย (วรรค)/พ.ร.บ.  */
              ASSIGN             
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ประกันแถมพ") <> 0 THEN    DO:                    /* ประกัน */
               ASSIGN            
               nv_72Reciept =  TRIM(wdetail.tiname) + TRIM(wdetail.insnam).    /*ชื่อลูกค้า-*/
           END.                 
           ELSE IF INDEX(wdetail.remark,"ประกันแถมเบี้ยและพ") <> 0 THEN     DO:           /* ประกัน */
               ASSIGN            
               nv_72Reciept =  TRIM(wdetail.tiname) + TRIM(wdetail.insnam).     /*ชื่อลูกค้า-*/
            END.
           ELSE IF INDEX(wdetail.remark,"พ.ร.บ.ลูกค้าจ่าย") <> 0 THEN   DO:                     /* ลูกค้า */
              ASSIGN             
              nv_72Reciept =  TRIM(wdetail.tiname) + TRIM(wdetail.insnam).
            END.
           ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่ายเบี้ยและพ") <> 0 THEN    DO:            /* ลูกค้า เบี้ย/พ.ร.บ. */
              ASSIGN              
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่าย 2 ") <> 0 THEN    DO:            /* ลูกค้า เบี้ย/พ.ร.บ. */
                 ASSIGN              
              nv_72Reciept =  wdetail.RECP_NAME.
           END.
           ELSE nv_72Reciept = " ".
           .....end a60-0095....*/
         EXPORT DELIMITER "|" 
             wdetail.Pro_off   
             wdetail.cmr_code  
             wdetail.comcode   
             wdetail.policyno  
             /*wdetail.pol70  --A59-0618 --*/
             IF ra_matpoltyp = 2 THEN wdetail.pol70 ELSE IF ra_matpoltyp = 3 THEN wdetail.pol72 ELSE IF SUBSTR(wdetail.policyno,3,2) = "70" THEN wdetail.pol70 ELSE wdetail.pol72  /*--A59-0618 --*/
             wdetail.caryear   
             wdetail.eng       
             wdetail.chasno            
             wdetail.engcc                     
             wdetail.power                     
             wdetail.colorcode                 
             wdetail.vehreg 
             wdetail.garage                    
             wdetail.fleetper                  
             wdetail.ncb                       
             wdetail.orthper                   
             wdetail.vehuse                    
             wdetail.comdat                     
             wdetail.si                        
             wdetail.name_insur              
             wdetail.not_office              
             wdetail.entdat                 
             wdetail.enttim                  
             wdetail.not_code               
             wdetail.premt                  
             wdetail.comp_prm               
             wdetail.stk                    
             wdetail.brand                  
             wdetail.mail_add1              
             wdetail.tambon    
             wdetail.amper     
             wdetail.country   
             wdetail.tiname                 
             wdetail.insnam                
             wdetail.benname                
             wdetail.remark                 
             wdetail.Account_no                  
             wdetail.client_no                   
             wdetail.expdat                       
             wdetail.gap 
             wdetail.re_country  
             wdetail.RECP_NAME 
             wdetail.agent        
             wdetail.prev_insur   
             wdetail.prepol
             wdetail.deduct 
             wdetail2.np_add70 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             "" 
             ""
             ""
             ""
             wdetail2.np_remark   
             wdetail.prempa
             wdetail.name2
             wdetail.tp1
             wdetail.tp2
             wdetail.tp3
             wdetail.covcod
             wdetail2.nnproducer
             wdetail2.nnagent
             wdetail.branch
             "" 
             "" 
             "" 
             ""
             ""
             wdetail2.npid70     
             wdetail2.npid70br      
             wdetail2.npid72       
             wdetail2.npid72br   
             wdetail2.npComdat             
             wdetail2.npExpdat             
             wdetail2.np_fi                
             wdetail2.npCode               
             wdetail2.npCaruse 
             ""
             wdetail.drivnam1
             wdetail.driag1
             wdetail.driocc1 /*A67-0087*/
             wdetail.dripos1 /*A67-0114*/
             ""
             wdetail.drivnam2
             wdetail.driag2  
             wdetail.driocc2 /*A67-0087*/ 
             wdetail.dripos2 /*A67-0114*/
             "" 
             wdetail2.npdrinam3  /*A67-0087*/
             wdetail2.npdridat3  /*A67-0087*/
             wdetail2.npdriocc3 /*A67-0087*/  
             wdetail2.npdripos3 /*A67-0114*/ 
             wdetail2.np_remark
             wdetail2.np_Rec_name72
             wdetail2.np_remark
             wdetail2.np_Rec_name72
             wdetail2.np_Rec_add1
             wdetail2.nntyppol
             /* A67-0087 */
             wdetail.Schanel  
             wdetail.bev      
             ""          
             wdetail.drivnam4 
             wdetail.driag4   
             wdetail.driocc4  
             wdetail.dripos4 /*A67-0114*/        
             ""          
             wdetail.drivnam5 
             wdetail.driag5   
             wdetail.driocc5  
             wdetail.dripos5 /*A67-0114*/          
             wdetail.campagin 
             wdetail.inspic   
             wdetail.engcount 
             wdetail.engno2   
             wdetail.engno3   
             wdetail.engno4   
             wdetail.engno5   
             wdetail.classcomp
             wdetail.carbrand .
            /* A67-0087 */
    END.
END.    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfilepol72 C-Win 
PROCEDURE Pro_createfilepol72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   /*A56-0323*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "บริษัทเงินทุน ทิสโก้ จำกัด (มหาชน) ."  string(TODAY)   .
EXPORT DELIMITER "|" 
    "Processing Office"             /*  1       Processing Office       */
    "CMR  code"                     /*  2       CMR  code       */
    "Insur.comp"                    /*  3       Insur.comp      */
    "notify number"                 /*  4       notify number   */
    "Policy70"                          
    "Policy72"   /*Add A56-0323 */
    "Car year"                      /*  5       Car year        */
    "engine"                        /*  6       engine  */
    "chassis"                       /*  7       chassis */
    "weight"                        /*  8       weight  */
    "power"                         /*  9       power   */
    "color"                         /*  10      color   */
    "licence no"                    /*  11      licence no      */
    "Garage     "                   /*  12      Garage  */
    "fleet disc."                   /*  13      fleet disc.     */
    "ncb disc."                     /*  14      ncb disc.       */
    "other disc."                   /*  15      other disc.     */
    "vehuse"                        /*  16      vehuse  */
    "Comdat"                        /*  17      Comdat  */
    "ทุนประกัน"                     /*  18      ทุนประกัน       */
    "รหัสเจ้าหน้าที่แจ้งประกัน"     /*  19      รหัสเจ้าหน้าที่แจ้งประกัน       */
    "ชื่อเจ้าหน้าที่ประกัน"         /*  20      ชื่อเจ้าหน้าที่ประกัน   */
    "วันที่แจ้งประกัน"              /*  21      วันที่แจ้งประกัน        */
    "เวลาแจ้งประกัน"                /*  22      เวลาแจ้งประกัน  */
    "รหัสแจ้งงาน"                   /*  23      รหัสแจ้งงาน     */
    "prem.1"                        /*  24      prem.1  */
    "comp.prm"                      /*  25      comp.prm        */
    "sticker"                       /*  26      sticker */
    "brand"                         /*  27      brand   */
    "address1"                      /*  28      address1        */
    "address2"                      /*  29      address2        */
    "title name"                    /*  30      title name      */
    "first name"                    /*  31      first name      */
    "last name"                     /*  32      last name       */
    "beneficiary"                   /*  33      beneficiary     */
    "remark."                       /*  34      remark. */
    "account no."                   /*  35      account no.     */
    "client No."                    /*  36      client No.      */
    "expiry date"                   /*  37      expiry date     */
    "insurance amt."                /*  38      insurance amt.  */
    "province"                      /*  39      province        */
    "receipt name"                  /*  40      receipt name    */
    "agent code"                    /*  41      agent code      */
    "บริษัทประกันภัยเดิม"           /*  42      บริษัทประกันภัยเดิม     */
    "old policy"                    /*  43      old policy      */
    "deduct disc."                              /*   44      deduct disc.    */
    "ที่อยู่หน้าตาราง70"                        /*   45      ที่อยู่หน้าตาราง70      */
    "ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่"       /*   46      ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่     */
    "ตำบล"                                      /*   47      ตำบล    */
    "อำเภอ"                                     /*   48      อำเภอ   */
    "จังหวัด"                                   /*   49      จังหวัด */
    "รหัสไปรษณีย์"                              /*   50      รหัสไปรษณีย์    */
    "ที่อยู่หน้าตาราง72"                        /*   51      ที่อยู่หน้าตาราง72      */
    "ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่"       /*   52      ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่     */
    "ตำบล"                                      /*   53      ตำบล    */
    "อำเภอ"                                     /*   54      อำเภอ   */
    "จังหวัด"                                   /*   55      จังหวัด */
    "รหัสไปรษณีย์"                              /*   56      รหัสไปรษณีย์    */
    "Applicationtype"                           /*   57      Applicationtype */
    "Applicationcode"                           /*   58      Applicationcode */
    "Blank"                                     /*   59      Blank   */
    "package"                                   /*   60      package */
    "Seat/จำนวนที่นั่ง"                         /*A57-0017*/
    "TPBI/Person"                               /*   61      TPBI/Person     */
    "TPBI/Per Acciden"                          /*   62      TPBI/Per Acciden        */
    "TPPD/Per Acciden"                          /*   63      TPPD/Per Acciden        */
    "covcod"                                    /*   64      covcod  */
    "Producer"                                  /*   65      Producer        */
    "Agent"                                     /*   66      Agent   */
    "Branch"                                    /*   67      Branch  */
    "NEW/RENEW"                                 /*   68      NEW/RENEW*/
    "Redbook"                                /*A57-0262*/      
    "Price_Ford"                             /*A57-0262*/      
    "Year"                                   /*A57-0262*/      
    "Brand_Model"                            /*A57-0262*/      
    "Receipt ID. Number "                    /*A57-0262*/      
    "Receipt Branch NAME"                    /*A57-0262*/      
    "Receipt Compulsory ID. Number"          /*A57-0262*/      
    "Receipt Compulsory Branch Name"         /*A57-0262*/ 
    "วันที่คุ้มครอง พรบ."                    /*A59-0178*/
    "วันที่สิ้นสุดความคุ้มครอง พรบ."         /*A59-0178*/
    "ทุนสูญหายและไฟไหม้"                     /*A59-0178*/
    "รหัสรถ"                                 /*A59-0178*/
    "ลักษณะการใช้รถ"                         /*A59-0178*/
    "ลำดับผู้ขับขี่คนที่ 1"                  /*A59-0178*/ 
    "ชื่อผู้ขับขี่คนที่ 1"                   /*A59-0178*/
    "วันเดือนปีเกิดผู้ขับขี่คนที่ 1"         /*A59-0178*/ 
    "อาชีพผู้ขับขี่คนที่ 1"                  /*A59-0178*/ 
    "ตำแหน่งงานผู้ขับขี่คนที่ 1"             /*A59-0178*/ 
    "ลำดับผู้ขับขี่คนที่ 2"                  /*A59-0178*/ 
    "ชื่อผู้ขับขี่คนที่ 2"                   /*A59-0178*/ 
    "วันเดือนปีเกิดผู้ขับขี่คนที่ 2"         /*A59-0178*/
    "อาชีพผู้ขับขี่คนที่ 2"                  /*A59-0178*/ 
    "ตำแหน่งงานผู้ขับขี่คนที่ 2"             /*A59-0178*/
    "ลำดับผู้ขับขี่คนที่ 3"                  /*A59-0178*/
    "ชื่อผู้ขับขี่คนที่ 3"                   /*A59-0178*/   
    "วันเดือนปีเกิดผู้ขับขี่คนที่ 3"         /*A59-0178*/   
    "อาชีพผู้ขับขี่คนที่ 3"                  /*A59-0178*/   
    "ตำแหน่งงานผู้ขับขี่คนที่ 3"             /*A59-0178*/   
    "BLANK"                                  /*A59-0178*/  
    "ReceiptName72"                         /*A59-0178*/
      /* A67-0087 */
    "ช่องทางการขาย    "               
    "รถยนต์ไฟฟ้า Y/N  "               
    "ลำดับผู้ขับขี่คนที่ 4 "          
    "ชื่อผู้ขับขี่คนที่ 4  "          
    "วันเดือนปีเกิดผู้ขับขี่คนที่4"   
    "อาชีพผู้ขับขี่คนที่ 4 "          
    "ตำแหน่งงานผู้ขับขี่คนที่ 4   "   
    "ลำดับผู้ขับขี่คนที่ 5 "          
    "ชื่อผู้ขับขี่คนที่ 5  "          
    "วันเดือนปีเกิดผู้ขับขี่คนที่5"   
    "อาชีพผู้ขับขี่คนที่ 5 "          
    "ตำแหน่งงานผู้ขับขี่คนที่ 5   "   
    "แคมเปญ     "                     
    "ส่งรูปแทนการตรวจสภาพรถY/N   "    
    "จำนวนเลขเครื่อง  "               
    "หมายเลขเครื่องยนต์ 2  "          
    "หมายเลขเครื่องยนต์ 3  "          
    "หมายเลขเครื่องยนต์ 4  "          
    "หมายเลขเครื่องยนต์ 5  "          
    "รหัส พ.ร.บ."                     
    "ยี่ห้อรถ   "   .
/* end : A67-0087 */

FOR EACH wdetail   no-lock.
    FOR EACH wdetail2 WHERE wdetail2.nppolicy = trim(wdetail.chasno) NO-LOCK .
    /*-IF   AVAIL wdetail2 THEN DO:-*/
        IF (ra_matpoltyp = 2 )  THEN ASSIGN wdetail.pol72 = "".  /*match 70 only ....*/
        ELSE DO: 
            /*- 
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 
                WHERE sicuw.uwm100.cedpol = wdetail.Account_no  AND 
                        sicuw.uwm100.poltyp       = "V72"               NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO: 
                 IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY) THEN  ASSIGN pol72 = "" .
                 ELSE ASSIGN pol72 = sicuw.uwm100.policy
                             wdetail.Reciept72 = sicuw.uwm100.name2 .   
            END.
            ELSE  pol72 = "".
            IF  index(wdetail.Reciept72,"และ/หรือ") <> 0  THEN wdetail.Reciept72 = REPLACE(wdetail.Reciept72,"และ/หรือ","").
             -*/ 
            /*-wdetail.remark  -*/ 
        
            FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                     sicuw.uwm100.cedpol = TRIM(wdetail.Account_no)  NO-LOCK .
                     IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                     /*ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT. A59-0618 */
                     ELSE IF YEAR(sicuw.uwm100.expdat) < YEAR(TODAY)  THEN NEXT. /* A59-0618 */
                     ELSE DO:
                        ASSIGN     n_comdat = ""
                                   n_comdat = STRING(sicuw.uwm100.comdat,"99/99/9999").
                                   /*IF YEAR(DATE(n_comdat)) <> YEAR(DATE(wdetail.Comdat)) THEN NEXT. /*-A59-0618-*/ */ /*A61-0045*/
                                   IF YEAR(DATE(n_comdat)) <> YEAR(DATE(wdetail2.npComdat)) THEN NEXT. /*-A61-0045-*/
                                   ELSE DO:
                                      /*IF DATE(n_comdat) = DATE(wdetail2.npComdat)  THEN DO: */ /*-A59-0618-*/
                                      IF TRIM(n_comdat) = TRIM(wdetail2.npComdat)  THEN DO:  /*-A59-0618-*/
                                       ASSIGN wdetail.pol72     = sicuw.uwm100.policy 
                                              wdetail.Reciept72 = sicuw.uwm100.name2 .
                                      END.
                                      ELSE ASSIGN wdetail.pol72 = "".
                                   END.
                     END.
                     IF  index(wdetail.Reciept72,"และ/หรือ") <> 0  THEN wdetail.Reciept72 = REPLACE(wdetail.Reciept72,"และ/หรือ","").

            END.  /*FOR EACH*/
            RELEASE sicuw.uwm100.
        END.  /* ELSE DO:  */

    IF wdetail.reciept72 = ""  THEN  DO:  /*- Reciept72 -*/ 
        RUN Pro_Receipt72.
        /*- Receipt72 -*/
    END.  /*Reciept72*/ 

    EXPORT DELIMITER "|" 
        wdetail.Pro_off         /*  1   Processing Office   */                
        wdetail.cmr_code        /*  2   CMR  code   */                        
        wdetail.comcode         /*  3   Insur.comp  */                        
        wdetail.policyno        /*  4   notify number   */ 
        wdetail.pol70
        wdetail.pol72                   /*Add A56-0323 */
        wdetail.caryear         /*  5   Car year    */                        
        wdetail.eng             /*  6   engine  */                            
        wdetail.chasno          /*  7   chassis */                            
        wdetail.engcc           /*  8   weight  */                                  
        wdetail.power           /*  9   power   */                                  
        wdetail.colorcode       /*  10  color   */                                  
        wdetail.vehreg          /*  11  licence no*/                        
        wdetail.garage          /*  12  Garage  */                                  
        wdetail.fleetper        /*  13  fleet disc. */                              
        wdetail.ncb             /*  14  ncb disc.   */                              
        wdetail.orthper         /*  15  other disc. */                              
        wdetail.vehuse          /*  16  vehuse  */                                  
        wdetail.comdat          /*  17  Comdat  */                                   
        wdetail.si              /*  18  ทุนประกัน   */                              
        wdetail.name_insur      /*  19  รหัสเจ้าหน้าที่แจ้งประกัน   */            
        wdetail.not_office      /*  20  ชื่อเจ้าหน้าที่ประกัน   */                
        wdetail.entdat          /*  21  วันที่แจ้งประกัน    */                   
        wdetail.enttim          /*  22  เวลาแจ้งประกัน  */                        
        wdetail.not_code        /*  23  รหัสแจ้งงาน */                           
        wdetail.premt           /*  24  prem.1  */                               
        wdetail.comp_prm        /*  25  comp.prm    */                           
        wdetail.stk             /*  26  sticker */                               
        wdetail.brand           /*  27  brand   */                               
        wdetail.mail_add1       /*  28  address1    */ 
        wdetail.mail_add2       /*  29  address2    */                        
        wdetail.tiname          /*  30  title name  */                        
        wdetail.insnam          /*  31  first name  */                        
        wdetail.name2           /*  32  last name   */                           
        wdetail.benname         /*  33  beneficiary */                         
        wdetail.remark          /*  34  remark. */                                   
        wdetail.Account_no      /*  35  account no. */                           
        wdetail.client_no       /*  36  client No.  */                           
        wdetail.expdat          /*  37  expiry date     */                            
        wdetail.gap             /*  38  insurance amt.  */                            
        wdetail.re_country      /*  39  province    */                                 
        wdetail.RECP_NAME       /*  40  receipt name    */                    
        wdetail.agent           /*  41  agent code  */                        
        wdetail.prev_insur      /*  42  บริษัทประกันภัยเดิม */                
        wdetail.prepol          /*  43  old policy  */                        
        wdetail.drivnam1        /*  44  deduct disc.    */                    
        wdetail.driag1          /*  45  ที่อยู่หน้าตาราง70  */                
        wdetail.drivnam2        /*  46  ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่ */
        wdetail2.tambon70       /*  47  ตำบล    */                            
        wdetail2.amper70        /*  48  อำเภอ   */                            
        wdetail2.country70      /*  49  จังหวัด */                            
        wdetail2.post70         /*  50  รหัสไปรษณีย์    */                    
        wdetail.RECP_MAIL1      /*  51  ที่อยู่หน้าตาราง72  */                
        wdetail.RECP_MAIL2      /*  52  ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่ */
        wdetail.tambon          /*  53  ตำบล    */                            
        wdetail.amper           /*  54  อำเภอ   */                            
        wdetail.country         /*  55  จังหวัด */                            
        wdetail.post            /*  56  รหัสไปรษณีย์    */                    
        wdetail.CHQ_ADDR        /*  57  Applicationtype */                    
        wdetail.APP_TYPE        /*  58  Applicationcode */                    
        wdetail.delerbr         /*  59  Blank   */                             
        wdetail.prempa          /*  60  package */ 
        wdetail.recordID        /*  A57-0017    add seat */
        wdetail.tp1             /*  61  TPBI/Person */                        
        wdetail.tp2             /*  62  TPBI/Per Acciden    */                
        wdetail.tp3             /*  63  TPPD/Per Acciden    */                
        wdetail.covcod          /*  64  covcod  */                            
        wdetail.npoltyp         /*  65  Producer    */                        
        wdetail2.nnagent        /*  66  Agent   */                            
        wdetail2.nnbranch       /*  67  Branch  */    
        wdetail2.nntyppol       /*  68  NEW/RENEW   */ 
        wdetail2.npRedbook      /*  A57-0262*/
        wdetail2.npPrice_Ford   /*  A57-0262*/
        wdetail2.npYear         /*  A57-0262*/
        wdetail2.npBrand_Mo     /*  A57-0262*/
        wdetail2.npid70         /*  A57-0262*/
        wdetail2.npid70br       /*  A57-0262*/
        wdetail2.npid72         /*  A57-0262*/
        wdetail2.npid72br       /*  A57-0262*/ 
        wdetail2.npComdat       /*  A59-0178*/     
        wdetail2.npExpdat       /*  A59-0178*/     
        wdetail2.np_fi          /*  A59-0178*/     
        wdetail2.npCode         /*  A59-0178*/     
        wdetail2.npCaruse       /*  A59-0178*/     
        wdetail2.npdrino1       /*  A59-0178*/     
        wdetail2.npdrinam1      /*  A59-0178*/     
        wdetail2.npdridat1      /*  A59-0178*/     
        wdetail2.npdriocc1      /*  A59-0178*/     
        wdetail2.npdripos1      /*  A59-0178*/     
        wdetail2.npdrino2       /*  A59-0178*/     
        wdetail2.npdrinam2      /*  A59-0178*/     
        wdetail2.npdridat2      /*  A59-0178*/     
        wdetail2.npdriocc2      /*  A59-0178*/     
        wdetail2.npdripos2      /*  A59-0178*/     
        wdetail2.npdrino3       /*  A59-0178*/     
        wdetail2.npdrinam3      /*  A59-0178*/     
        wdetail2.npdridat3      /*  A59-0178*/     
        wdetail2.npdriocc3      /*  A59-0178*/     
        wdetail2.npdripos3      /*  A59-0178*/    
        wdetail.delerbr         /*  BLANK*/
        wdetail.Reciept72       /*  A59-0178*/
        /* A67-0087 */
        wdetail.Schanel  
        wdetail.bev      
        ""          
        wdetail.drivnam4 
        wdetail.driag4   
        wdetail.driocc4  
        wdetail.dripos4 /*A67-0114*/          
        ""          
        wdetail.drivnam5 
        wdetail.driag5   
        wdetail.driocc5  
        wdetail.dripos5 /*A67-0114*/          
        wdetail.campagin 
        wdetail.inspic   
        wdetail.engcount 
        wdetail.engno2   
        wdetail.engno3   
        wdetail.engno4   
        wdetail.engno5   
        wdetail.classcomp
        wdetail.carbrand .
        /* A67-0087 */
    IF INDEX(wdetail.remark,"_2Y") <> 0 THEN RUN Pro_createfilepoly2.
     
        
    END.
END.            


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfilepoly2 C-Win 
PROCEDURE Pro_createfilepoly2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    EXPORT DELIMITER "|" 
        wdetail.Pro_off         /*  1   Processing Office   */                
        wdetail.cmr_code        /*  2   CMR  code   */                        
        wdetail.comcode         /*  3   Insur.comp  */                        
        wdetail.policyno        /*  4   notify number   */ 
        wdetail.policy2y70
        wdetail.policy2y72                  /*Add A56-0323 */
        wdetail.caryear         /*  5   Car year    */                        
        wdetail.eng             /*  6   engine  */                            
        wdetail.chasno          /*  7   chassis */                            
        wdetail.engcc           /*  8   weight  */                                  
        wdetail.power           /*  9   power   */                                  
        wdetail.colorcode       /*  10  color   */                                  
        wdetail.vehreg          /*  11  licence no*/                        
        wdetail.garage          /*  12  Garage  */                                  
        wdetail.fleetper        /*  13  fleet disc. */                              
        wdetail.ncb             /*  14  ncb disc.   */                              
        wdetail.orthper         /*  15  other disc. */                              
        wdetail.vehuse          /*  16  vehuse  */                                  
        wdetail.comdat          /*  17  Comdat  */                                   
        wdetail.si              /*  18  ทุนประกัน   */                              
        wdetail.name_insur      /*  19  รหัสเจ้าหน้าที่แจ้งประกัน   */            
        wdetail.not_office      /*  20  ชื่อเจ้าหน้าที่ประกัน   */                
        wdetail.entdat          /*  21  วันที่แจ้งประกัน    */                   
        wdetail.enttim          /*  22  เวลาแจ้งประกัน  */                        
        wdetail.not_code        /*  23  รหัสแจ้งงาน */                           
        wdetail.premt           /*  24  prem.1  */                               
        wdetail.comp_prm        /*  25  comp.prm    */                           
        wdetail.stk             /*  26  sticker */                               
        wdetail.brand           /*  27  brand   */                               
        wdetail.mail_add1       /*  28  address1    */ 
        wdetail.mail_add2       /*  29  address2    */                        
        wdetail.tiname          /*  30  title name  */                        
        wdetail.insnam          /*  31  first name  */                        
        wdetail.name2           /*  32  last name   */                           
        wdetail.benname         /*  33  beneficiary */                         
        wdetail.remark          /*  34  remark. */                                   
        wdetail.Account_no      /*  35  account no. */                           
        wdetail.client_no       /*  36  client No.  */                           
        wdetail.expdat          /*  37  expiry date     */                            
        wdetail.gap             /*  38  insurance amt.  */                            
        wdetail.re_country      /*  39  province    */                                 
        wdetail.RECP_NAME       /*  40  receipt name    */                    
        wdetail.agent           /*  41  agent code  */                        
        wdetail.prev_insur      /*  42  บริษัทประกันภัยเดิม */                
        wdetail.prepol          /*  43  old policy  */                        
        wdetail.drivnam1        /*  44  deduct disc.    */                    
        wdetail.driag1          /*  45  ที่อยู่หน้าตาราง70  */                
        wdetail.drivnam2        /*  46  ที่อยู่หน้าตาราง70กรณีไม่แยกที่อยู่ */
        wdetail2.tambon70       /*  47  ตำบล    */                            
        wdetail2.amper70        /*  48  อำเภอ   */                            
        wdetail2.country70      /*  49  จังหวัด */                            
        wdetail2.post70         /*  50  รหัสไปรษณีย์    */                    
        wdetail.RECP_MAIL1      /*  51  ที่อยู่หน้าตาราง72  */                
        wdetail.RECP_MAIL2      /*  52  ที่อยู่หน้าตาราง72กรณีไม่แยกที่อยู่ */
        wdetail.tambon          /*  53  ตำบล    */                            
        wdetail.amper           /*  54  อำเภอ   */                            
        wdetail.country         /*  55  จังหวัด */                            
        wdetail.post            /*  56  รหัสไปรษณีย์    */                    
        wdetail.CHQ_ADDR        /*  57  Applicationtype */                    
        wdetail.APP_TYPE        /*  58  Applicationcode */                    
        wdetail.delerbr         /*  59  Blank   */                             
        wdetail.prempa          /*  60  package */ 
        wdetail.recordID        /*  A57-0017    add seat */
        wdetail.tp1             /*  61  TPBI/Person */                        
        wdetail.tp2             /*  62  TPBI/Per Acciden    */                
        wdetail.tp3             /*  63  TPPD/Per Acciden    */                
        wdetail.covcod          /*  64  covcod  */                            
        wdetail.npoltyp         /*  65  Producer    */                        
        wdetail2.nnagent        /*  66  Agent   */                            
        wdetail2.nnbranch       /*  67  Branch  */    
        wdetail2.nntyppol       /*  68  NEW/RENEW   */ 
        wdetail2.npRedbook      /*  A57-0262*/
        wdetail2.npPrice_Ford   /*  A57-0262*/
        wdetail2.npYear         /*  A57-0262*/
        wdetail2.npBrand_Mo     /*  A57-0262*/
        wdetail2.npid70         /*  A57-0262*/
        wdetail2.npid70br       /*  A57-0262*/
        wdetail2.npid72         /*  A57-0262*/
        wdetail2.npid72br       /*  A57-0262*/ 
        wdetail2.npComdat       /*  A59-0178*/     
        wdetail2.npExpdat       /*  A59-0178*/     
        wdetail2.np_fi          /*  A59-0178*/     
        wdetail2.npCode         /*  A59-0178*/     
        wdetail2.npCaruse       /*  A59-0178*/     
        wdetail2.npdrino1       /*  A59-0178*/     
        wdetail2.npdrinam1      /*  A59-0178*/     
        wdetail2.npdridat1      /*  A59-0178*/     
        wdetail2.npdriocc1      /*  A59-0178*/     
        wdetail2.npdripos1      /*  A59-0178*/     
        wdetail2.npdrino2       /*  A59-0178*/     
        wdetail2.npdrinam2      /*  A59-0178*/     
        wdetail2.npdridat2      /*  A59-0178*/     
        wdetail2.npdriocc2      /*  A59-0178*/     
        wdetail2.npdripos2      /*  A59-0178*/     
        wdetail2.npdrino3       /*  A59-0178*/     
        wdetail2.npdrinam3      /*  A59-0178*/     
        wdetail2.npdridat3      /*  A59-0178*/     
        wdetail2.npdriocc3      /*  A59-0178*/     
        wdetail2.npdripos3      /*  A59-0178*/    
        wdetail.delerbr         /*  BLANK*/
        wdetail.Reciept72       /*  A59-0178*/  
        /* A67-0087 */
        wdetail.Schanel  
        wdetail.bev      
        ""          
        wdetail.drivnam4 
        wdetail.driag4   
        wdetail.driocc4  
        wdetail.dripos4 /*A67-0114*/          
        ""          
        wdetail.drivnam5 
        wdetail.driag5   
        wdetail.driocc5  
        wdetail.dripos5 /*A67-0114*/          
        wdetail.campagin 
        wdetail.inspic   
        wdetail.engcount 
        wdetail.engno2   
        wdetail.engno3   
        wdetail.engno4   
        wdetail.engno5   
        wdetail.classcomp
        wdetail.carbrand .
        /* A67-0087 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matchfile_tlt C-Win 
PROCEDURE pro_matchfile_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: update by : A64-0271      
------------------------------------------------------------------------------*/
DEF VAR package AS CHAR FORMAT "x(5)" INIT "" .
DEF VAR nv_blank AS CHAR FORMAT "x(150)" INIT "" .   /*A64-0092*/
DEF VAR nv_acc   AS CHAR FORMAT "X(150)" INIT "" .    /*A64-0092*/
FOR EACH wdetail WHERE wdetail.chasno  <> " "  NO-LOCK.
    ASSIGN 
        nnid70    = ""   /*A57-0262*/    nv_blank  =  "" /*A64-0092*/
        nnidbr70  = ""   /*A57-0262*/    nv_acc    =  "" /*A64-0092*/
        nnid72    = ""   /*A57-0262*/    nnidbr72  = ""   /*A57-0262*/ 
        producer_mat    = ""             agent_mat       = "" 
        nv_messag       = ""             package         = ""
        n_compdat       = ""             n_exppdat       = ""
        n_fi            = ""             n_vehus         = ""
        n_class         = ""             nnBirthdate     = ""   /*A65-0356*/
        nv_72Reciept    = "" 
        n_product       = ""  .  /*a61-0313*/
    FIND LAST wdetail3 WHERE 
        wdetail3.policyid  = wdetail.chasno   AND 
        wdetail3.poltyp    = wdetail.npoltyp  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wdetail3 THEN DO:
        IF wdetail3.poltyp = "v70" THEN
            ASSIGN 
            nnid70   = trim(wdetail3.ID_NO1)  
            nnidbr70 = trim(wdetail3.CLIENT_RANCH ) 
            nnBirthdate = TRIM(wdetail3.CLIENT_Birthdate) .  /*A65-0356*/
        ELSE ASSIGN  
            nnid72    = trim(wdetail3.ID_NO1)         
            nnidbr72  = trim(wdetail3.CLIENT_RANCH )
            nv_72Reciept = TRIM(wdetail3.RECEIPT_72)
            n_compdat    = wdetail3.comppdat
            n_exppdat    = wdetail3.exppdat
            n_comprem    = wdetail3.com_prem
            nnBirthdate = TRIM(wdetail3.CLIENT_Birthdate) .  /*A65-0356*/

    END.  /* A55-0267 */
    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE                   
        brstat.tlt.cha_no  =  trim(wdetail.chasno) AND                  
        brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.    
    IF AVAIL brstat.tlt THEN DO:
        ASSIGN 
            brstat.tlt.ndate1 = TODAY  /*A65-0356 */
            /* add A64-0092 */
            nv_acc        = IF index(brstat.tlt.filler2,"acc:") <> 0 THEN TRIM(Substr(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"acc:") + 4 )) 
                           ELSE IF index(brstat.tlt.filler2,"คค.") <> 0 THEN TRIM(Substr(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"คค."))) 
                           ELSE IF index(brstat.tlt.filler2,"||")  <> 0 THEN TRIM(Substr(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"||") + 2))
                           ELSE "" 
            /* end A64-0092 */
            nv_remark     = trim(brstat.tlt.filler2)
            nv_Rec        = brstat.tlt.comp_usr_ins
            nv_remark     = IF index(nv_remark,"//") = 0 THEN "" ELSE              /*A57-0262*/
                           trim(SUBSTR(nv_remark,index(nv_remark,"//") + 2 ))   /*A57-0262*/
            nv_remark     = REPLACE(nv_remark,"r2:","")
            nv_remark     = REPLACE(nv_remark,"r3:","")                                  
            nv_remark     = REPLACE(nv_remark,"r4:","")                                
            nv_Rec_name72 = SUBSTR(nv_Rec,1,INDEX(nv_Rec,"a1:") - 1 )                               
            nv_Rec_add1   = SUBSTR(nv_Rec,INDEX(nv_Rec,"a1:") + 3 )                                 
            nv_Rec_add1   = REPLACE(nv_Rec_add1,"a2:","").

        IF trim(wdetail.prepol) <> "" AND trim(brstat.tlt.filler1) <> trim(wdetail.prepol) THEN 
            nv_messag = "เบอร์ต่ออายุไม่ตรงกัน กรุณาตรวจสอบข้อมูลอีกครั้ง !!" . /*a60-0095*/
        ELSE DO:  /*a60-0095*/
            ASSIGN nv_messag = "found by cha_no"  /* A55-0267 */
                   n_fi       = (SUBSTR(brstat.tlt.model,51,10))  
                   n_vehus    = (SUBSTR(brstat.tlt.expotim,5,4))    
                   n_class    = (SUBSTR(brstat.tlt.expousr,7,3))  .  
           
            IF (INDEX(brstat.tlt.releas,"yes") <> 0 ) THEN ASSIGN nv_messag = "stat Yes".
            /*ELSE DO:*/  /*A56-0012 ...*/
            IF  wdetail.npoltyp    = "v72" THEN DO:
                FIND FIRST wcomp WHERE wcomp.premcomp = brstat.tlt.comp_grprm NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL wcomp THEN ASSIGN package = wcomp.package .
                ELSE package = "".
                IF index(brstat.tlt.brand,"ISUZU") <> 0 AND index(brstat.tlt.expotim,"210") <> 0 THEN package = "140A". /*A60-0095*/
            END.
            ELSE package = "".
        END. /*a60-0095*/
        RUN  proc_matchagent. /*A60-0095*/
        /* A64-0271 : check Address  */
        IF wdetail.mail_add1  = "TISCO" THEN DO: 
            ASSIGN n_address = ""
                   n_address = brstat.tlt.ins_addr3 .
            IF n_address <> "" THEN RUN  proc_addrtis. /*A64-0271*/
            ASSIGN   
              wdetail.mail_add1 = trim(n_build)
              wdetail.tambon    = trim(n_tambon)
              wdetail.amper     = trim(n_amper)
              wdetail.country   = trim(n_country) + " " + trim(n_post) .
            IF index(brstat.tlt.filler2,"จัดส่งทิสโก้")  = 0  THEN DO:
                ASSIGN nv_remark            = nv_remark + " จัดส่งทิสโก้ " 
                       brstat.tlt.filler2   = "จัดส่งทิสโก้ " + tlt.filler2 .
            END.
        END.
        ELSE IF INDEX(wdetail.mail_add1,"ธนาคารทิสโก้") <> 0  THEN DO:
            IF index(brstat.tlt.filler2,"จัดส่งทิสโก้")  = 0  THEN DO:
                ASSIGN nv_remark            = nv_remark + " จัดส่งทิสโก้ " 
                       brstat.tlt.filler2   = "จัดส่งทิสโก้ " + tlt.filler2 .
            END.
        END.
        
        IF brstat.tlt.ins_addr3 <> "" THEN DO:
            ASSIGN n_address =  IF INDEX(brstat.tlt.ins_addr3,"ธนาคารทิสโก้") <> 0 THEN  "" ELSE brstat.tlt.ins_addr3 .
            IF n_address <> "" THEN RUN  proc_addrtis.
            ASSIGN wdetail.addr1_70      = trim(n_build)  
                  wdetail.addr2_70       = ""
                  wdetail.nsub_dist70    = trim(n_tambon) 
                  wdetail.ndirection70   = trim(n_amper)  
                  wdetail.nprovin70      = trim(n_country)
                  wdetail.zipcode70      = trim(n_post) .
        END.
        
        IF brstat.tlt.ins_addr4 <> ""  THEN DO:
            ASSIGN n_address =  brstat.tlt.ins_addr4 .
            IF n_address <> "" THEN RUN  proc_addrtis.   
            ASSIGN wdetail.addr1_72      = trim(n_build)  
                  wdetail.addr2_72       = ""
                  wdetail.nsub_dist72    = trim(n_tambon) 
                  wdetail.ndirection72   = trim(n_amper)  
                  wdetail.nprovin72      = trim(n_country)
                  wdetail.zipcode72      = trim(n_post) .
        END.
        /* end : check Address  */
        EXPORT DELIMITER "|" 
            trim(brstat.tlt.rec_addr3)    
            trim(brstat.tlt.rec_addr4)    
            trim(brstat.tlt.subins)       
            wdetail.policyno  
            trim(brstat.tlt.lince2)           
            trim(brstat.tlt.eng_no)           
            trim(wdetail.chasno)                   
            trim(string(brstat.tlt.cc_weight))                
            trim(string(brstat.tlt.rencnt))                   
            trim(brstat.tlt.colorcod)                         
            IF wdetail.vehreg = "" THEN trim(brstat.tlt.lince1) ELSE TRIM(wdetail.vehreg)           
            trim(brstat.tlt.stat)                              
            trim(string(brstat.tlt.lotno))                     
            trim(string(brstat.tlt.seqno))                     
            trim(string(brstat.tlt.endcnt))                    
            IF INDEX(wdetail.policyno,"TC70") <> 0 THEN SUBSTR(brstat.tlt.model,1,50) ELSE "" /*SUBSTR(brstat.tlt.model,1,10)  -- A60-0118--*/
            IF wdetail.comdat = "" THEN STRING(brstat.tlt.nor_effdat) ELSE substr(trim(wdetail.comdat),7,2) + "/" + substr(trim(wdetail.comdat),5,2) + "/" + substr(trim(wdetail.comdat),1,4)             /*trim(string(brstat.tlt.gendat))  */ /*A57-0262  comdat */      
            trim(string(brstat.tlt.nor_coamt))                 
            wdetail.idno                   
            trim(brstat.tlt.nor_usr_tlt)                     
            trim(string(tlt.datesent))           /*A61-0410*/  
            trim(string(tlt.gentim))             /*A61-0410*/  
            trim(string(brstat.tlt.comp_usr_tlt))            
            trim(string(brstat.tlt.nor_grprm))               
            trim(string(brstat.tlt.comp_grprm))             
            IF wdetail.stk = "" THEN trim(brstat.tlt.comp_sck) ELSE TRIM(wdetail.stk)                       
            trim(brstat.tlt.brand)                           
            wdetail.mail_add1              
            wdetail.tambon    
            wdetail.amper     
            wdetail.country
            trim(wdetail.tiname)              
            trim(wdetail.insnam)        
            trim(brstat.tlt.safe1)                             
            (trim(brstat.tlt.filler2) + " [" + trim(nv_file1) + " : " + trim(nv_file2) + "]"   )                      
            wdetail.Account_no                               
            trim(brstat.tlt.safe3) 
            IF wdetail.expdat = "" THEN string(brstat.tlt.comp_effdat) ELSE substr(trim(wdetail.EXPdat),7,2) + "/" + substr(trim(wdetail.EXPdat),5,2) + "/" + substr(trim(wdetail.EXPdat),1,4)   /*trim(string(brstat.tlt.expodat)) */ /*A57-0262expidat */ 
            trim(string(brstat.tlt.comp_coamt))  
            wdetail.re_country  
            wdetail.RECP_NAME 
            trim(brstat.tlt.recac)                          
            trim(brstat.tlt.rec_addr2)                
            replace(trim(brstat.tlt.rec_addr5),"*","")
            trim(brstat.tlt.endno)  
            wdetail.addr1_70   /*brstat.tlt.ins_addr3*/
            wdetail.addr2_70    
            wdetail.nsub_dist70 
            wdetail.ndirection70
            wdetail.nprovin70   
            wdetail.zipcode70   
            wdetail.addr1_72   /*brstat.tlt.ins_addr4*/
            wdetail.addr2_72    
            wdetail.nsub_dist72 
            wdetail.ndirection72
            wdetail.nprovin72   
            wdetail.zipcode72   
            brstat.tlt.ins_addr5     
            brstat.tlt.comp_noti_tlt 
            nv_remark    
            trim(substr(trim(brstat.tlt.expotim),1,4))  /*substr(trim(brstat.tlt.expotim),1,5) A67-0114 */ 
            brstat.tlt.sentcnt                    
            trim(brstat.tlt.old_eng)                  
            trim(brstat.tlt.old_cha)                  
            trim(brstat.tlt.comp_pol)                 
            substr(trim(brstat.tlt.expousr),1,3)                  
            trim(tlt.comp_sub)                  
            trim(tlt.comp_noti_ins)            
            trim(brstat.tlt.EXP)                      
            IF brstat.tlt.flag = "n" THEN "NEW" ELSE "RENEW" 
            ""                           
            ""
            ""
            ""
            nnid70       
            nnidbr70     
            nnid72       
            nnidbr72 
            IF brstat.tlt.nor_effdat = ?  THEN ""  ELSE STRING(brstat.tlt.nor_effdat,"99/99/9999")   
            IF brstat.tlt.comp_effdat = ? THEN "" ELSE STRING(brstat.tlt.comp_effdat,"99/99/9999")   
            (SUBSTR(brstat.tlt.model,51,10))
            (SUBSTR(brstat.tlt.expotim,5,4))
            (SUBSTR(brstat.tlt.expousr,7,3))
            ""
            brstat.tlt.dri_name1                      
            IF brstat.tlt.dri_no1 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no1)                       
            brstat.tlt.dir_occ1 /*A67-0087*/
            TRIM(brstat.tlt.dri_lic1) + "/" + TRIM(brstat.tlt.dri_ic1) /*A67-0114*/
            ""
            brstat.tlt.dri_name2                      
            IF brstat.tlt.dri_no2 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no2)
            brstat.tlt.dri_occ2 /*A67-0087*/
            TRIM(brstat.tlt.dri_lic2) + "/" + TRIM(brstat.tlt.dri_ic2) /*A67-0114*/
            ""
            brstat.tlt.dri_name3           /*A67-0087*/                                       
            IF brstat.tlt.dri_no3 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no3) /*A67-0087*/    
            brstat.tlt.dir_occ3 /*A67-0087*/                                     
            TRIM(brstat.tlt.dri_lic3) + "/" + TRIM(brstat.tlt.dri_ic3) /*A67-0114*/
            nv_acc  /*nv_remark */  /*A64-0092*/
            nv_Rec_name72
            nv_acc  /*nv_remark  */ /*A64-0092*/  
            nv_Rec_name72
            nv_Rec_add1  
            nv_messag 
            nnBirthdate     /*A65-0356*/
            /* Add by : A67-0087 */
            brstat.tlt.note7    
            brstat.tlt.note8    
            ""                  
            brstat.tlt.dri_name4
            brstat.tlt.dri_no4  
            brstat.tlt.dri_occ4 
            TRIM(brstat.tlt.dri_lic4) + "/" + TRIM(brstat.tlt.dri_ic4) /*A67-0114*/                  
            ""                  
            brstat.tlt.dri_name5
            brstat.tlt.dri_no5  
            brstat.tlt.dri_occ5 
            TRIM(brstat.tlt.dri_lic5) + "/" + TRIM(brstat.tlt.dri_ic5) /*A67-0114*/                  
            brstat.tlt.campaign 
            brstat.tlt.ispflg   
            brstat.tlt.ndeci1   
            brstat.tlt.eng_no2  
            brstat.tlt.note9    
            brstat.tlt.note10   
            brstat.tlt.note11   
            brstat.tlt.subclass 
            brstat.tlt.car_type .
            /* end : A67-0087 */
        /*END.*/ /*A56-0012 */
    END.
    IF nv_messag = "" THEN RUN pro_matchfile_tlt1. /*by name    *//* A55-0267 */
    IF (nv_messag = "") THEN DO:                   /*not found  *//* A55-0267 */
        EXPORT DELIMITER "|" 
            wdetail.Pro_off   
            wdetail.cmr_code     
            wdetail.comcode     
            wdetail.policyno  
            wdetail.caryear    
            wdetail.eng       
            wdetail.chasno        
            wdetail.engcc                 
            wdetail.power                 
            wdetail.colorcode             
            wdetail.vehreg    
            wdetail.garage                 
            wdetail.fleetper               
            wdetail.ncb                    
            wdetail.orthper                
            wdetail.vehuse                 
            wdetail.comdat                  
            wdetail.si                     
            wdetail.idno                        
            wdetail.not_office            
            wdetail.entdat              
            wdetail.enttim               
            wdetail.not_code              
            wdetail.premt                
            wdetail.comp_prm             
            wdetail.stk                  
            wdetail.brand                
            wdetail.mail_add1              
            wdetail.tambon   
            wdetail.amper   
            wdetail.country    
            wdetail.tiname                 
            wdetail.insnam               
            /*""*/
            wdetail.benname                   
            (wdetail.remark + " " + trim(nv_file1) + "_" + trim(nv_file2))                    
            wdetail.Account_no                 
            wdetail.client_no                  
            wdetail.expdat                      
            wdetail.gap          
            wdetail.re_country  
            wdetail.RECP_NAME 
            wdetail.agent        
            wdetail.prev_insur   
            wdetail.prepol       
            wdetail.deduct       
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            substr(wdetail.prempa,1,5)
            ""
            wdetail.tp1          
            wdetail.tp2          
            wdetail.tp3          
            substr(wdetail.covcod,1,3)       
            ""
            ""
            wdetail.branch       
            ""
            ""
            ""
            ""
            ""
            nnid70      
            nnidbr70    
            nnid72      
            nnidbr72    
            IF n_compdat = ? OR n_compdat = "" THEN "" ELSE n_compdat 
            IF n_exppdat = ? OR n_exppdat = "" THEN "" ELSE n_exppdat 
            n_fi    
            n_vehus 
            n_class
            ""
            wdetail.drivnam1     
            wdetail.driag1       
            wdetail.driocc1  /*A67-0087*/ 
            ""
            ""
            wdetail.drivnam2     
            wdetail.driag2       
            wdetail.driocc2  /*A67-0087*/ 
            ""
            ""
            wdetail.drivnam3              
            wdetail.driag3                 
            wdetail.driocc3  /*A67-0087*/  
            ""
            ""
            ""
            ""
            ""
            ""
            nv_messag 
            nnBirthdate    /*A65-0356*/
            /* Add by : A67-0087 */
            wdetail.Schanel   
            wdetail.bev       
            ""                  
            wdetail.drivnam4 
            wdetail.driag4   
            wdetail.driocc4  
            ""                  
            ""                  
            wdetail.drivnam5   
            wdetail.driag5     
            wdetail.driocc5    
            ""                  
            wdetail.campagin 
            wdetail.inspic   
            wdetail.engcount 
            wdetail.engno2   
            wdetail.engno3   
            wdetail.engno4   
            wdetail.engno5   
            wdetail.classcomp
            wdetail.carbrand .
            /* end : A67-0087 */
    END.
    ASSIGN nv_messag = "".
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matchfile_tlt1 C-Win 
PROCEDURE pro_matchfile_tlt1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: update by A64-0271       
------------------------------------------------------------------------------*/
DEF VAR nv_blank AS CHAR FORMAT "x(150)" INIT "" .   /*A64-0092*/
DEF VAR nv_acc   AS CHAR FORMAT "X(150)" INIT "" .    /*A64-0092*/

/*FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   */
FIND LAST brstat.tlt USE-INDEX tlt05  WHERE  
    brstat.tlt.ins_name = Trim(wdetail.insnam) AND             
    brstat.tlt.genusr  =  "TISCO"        NO-ERROR NO-WAIT.     
IF AVAIL brstat.tlt THEN DO:
    IF trim(wdetail.prepol) <> "" AND trim(brstat.tlt.filler1) <> trim(wdetail.prepol) THEN 
        nv_messag = "เบอร์ต่ออายุไม่ตรงกัน กรุณาตรวจสอบข้อมูลอีกครั้ง !!" . /*a60-0095*/
    ELSE ASSIGN nv_messag = "found by name".
     
    ASSIGN  nv_acc        =  "" /*A64-0092*/  
            brstat.tlt.ndate1 = TODAY  /*A65-0356 */
            /*A64-0092*/
            nv_acc        = IF INDEX(brstat.tlt.filler2,"r4:") <> 0 THEN SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"r4:") + 3) 
                            ELSE IF INDEX(brstat.tlt.filler2,"คค.") <> 0 THEN SUBSTR(brstat.tlt.filler2,INDEX(brstat.tlt.filler2,"คค."),LENGTH(brstat.tlt.filler2))  
                            ELSE "" 
            /* end A64-0092 */
            nv_remark     = trim(brstat.tlt.filler2)
            nv_Rec        = brstat.tlt.comp_usr_ins
            nv_remark     = IF index(nv_remark,"//") = 0 THEN "" ELSE              /*A57-0262*/
                            trim(SUBSTR(nv_remark,index(nv_remark,"//") + 2 ))   /*A57-0262*/
            /*nv_remark    = REPLACE(nv_remark,"//","")     */
            nv_remark     = REPLACE(nv_remark,"r2:","")
            nv_remark     = REPLACE(nv_remark,"r3:","")                                  
            nv_remark     = REPLACE(nv_remark,"r4:","")                                
            nv_Rec_name72 = SUBSTR(nv_Rec,1,INDEX(nv_Rec,"a1:") - 1 )                               
            nv_Rec_add1   = SUBSTR(nv_Rec,INDEX(nv_Rec,"a1:") + 3 )                                 
            nv_Rec_add1   = REPLACE(nv_Rec_add1,"a2:","").

    RUN  proc_matchagent. /*A60-0095*/
    /* A64-0271 : check Address  */
    IF wdetail.mail_add1  = "TISCO" THEN DO: 
        ASSIGN n_address = ""
               n_address = brstat.tlt.ins_addr3 .
        IF n_address <> "" THEN RUN  proc_addrtis. /*A64-0271*/
        ASSIGN   
          wdetail.mail_add1 = trim(n_build)
          wdetail.tambon    = trim(n_tambon)
          wdetail.amper     = trim(n_amper)
          wdetail.country   = trim(n_country) + " " + trim(n_post) .
        IF index(brstat.tlt.filler2,"จัดส่งทิสโก้")  = 0  THEN DO:
            ASSIGN nv_remark            = nv_remark + " จัดส่งทิสโก้ " 
                   brstat.tlt.filler2   = "จัดส่งทิสโก้ " + tlt.filler2 .
        END.
    END.
    ELSE IF index(wdetail.mail_add1,"ธนาคารทิสโก้") <> 0 THEN DO: 
        IF index(brstat.tlt.filler2,"จัดส่งทิสโก้")  = 0  THEN DO:
            ASSIGN nv_remark            = nv_remark + " จัดส่งทิสโก้ " 
                   brstat.tlt.filler2   = "จัดส่งทิสโก้ " + tlt.filler2 .
        END.
    END.
    
    IF brstat.tlt.ins_addr3 <> ""  THEN DO:
        ASSIGN n_address =  IF INDEX(brstat.tlt.ins_addr3,"ธนาคารทิสโก้") <> 0 THEN "" ELSE brstat.tlt.ins_addr3 .
        IF n_address <> "" THEN RUN  proc_addrtis.
        ASSIGN wdetail.addr1_70      = trim(n_build)  
               wdetail.addr2_70       = ""
               wdetail.nsub_dist70    = trim(n_tambon) 
               wdetail.ndirection70   = trim(n_amper)  
               wdetail.nprovin70      = trim(n_country)
               wdetail.zipcode70      = trim(n_post) .
    END.
    IF brstat.tlt.ins_addr4 <> ""  THEN DO:
        ASSIGN n_address =  brstat.tlt.ins_addr4 .
        IF n_address <> "" THEN RUN  proc_addrtis.   
        ASSIGN wdetail.addr1_72      = trim(n_build)  
              wdetail.addr2_72       = ""
              wdetail.nsub_dist72    = trim(n_tambon) 
              wdetail.ndirection72   = trim(n_amper)  
              wdetail.nprovin72      = trim(n_country)
              wdetail.zipcode72      = trim(n_post) .
    END.
    /* end : check Address  */
    
    IF (INDEX(brstat.tlt.releas,"yes") <> 0 )  THEN ASSIGN nv_messag   = IF nv_messag = "" THEN "stat Yes" ELSE nv_messag + "/ stat Yes". /*A60-0095*/
    ELSE DO:
        EXPORT DELIMITER "|" 
            trim(brstat.tlt.rec_addr3)    
            trim(brstat.tlt.rec_addr4)    
            trim(brstat.tlt.subins)       
            wdetail.policyno  
            trim(brstat.tlt.lince2)           
            trim(brstat.tlt.eng_no)           
            trim(wdetail.chasno)                   
            trim(string(brstat.tlt.cc_weight))                
            trim(string(brstat.tlt.rencnt))                   
            trim(brstat.tlt.colorcod)                         
            IF wdetail.vehreg = "" THEN trim(brstat.tlt.lince1) ELSE TRIM(wdetail.vehreg)           
            trim(brstat.tlt.stat)                              
            trim(string(brstat.tlt.lotno))                     
            trim(string(brstat.tlt.seqno))                     
            trim(string(brstat.tlt.endcnt))                    
            IF INDEX(wdetail.policyno,"TC70") <> 0 THEN SUBSTR(brstat.tlt.model,1,50) ELSE "" /*SUBSTR(brstat.tlt.model,1,10)  -- A60-0118--*/
            IF wdetail.comdat = "" THEN STRING(brstat.tlt.nor_effdat) ELSE substr(trim(wdetail.comdat),7,2) + "/" + substr(trim(wdetail.comdat),5,2) + "/" + substr(trim(wdetail.comdat),1,4)             /*trim(string(brstat.tlt.gendat))  */ /*A57-0262  comdat */      
            trim(string(brstat.tlt.nor_coamt))                 
            wdetail.idno  /*trim(tlt.nor_usr_ins) */  /*A55-0365*/                  
            trim(brstat.tlt.nor_usr_tlt)                     
            trim(string(tlt.datesent))           /*A61-0410*/  
            trim(string(tlt.gentim))             /*A61-0410*/  
            trim(string(brstat.tlt.comp_usr_tlt))            
            trim(string(brstat.tlt.nor_grprm))               
            trim(string(brstat.tlt.comp_grprm))             
            IF wdetail.stk = "" THEN trim(brstat.tlt.comp_sck) ELSE TRIM(wdetail.stk)                       
            trim(brstat.tlt.brand)                           
            wdetail.mail_add1              
            trim(wdetail.tambon) 
            trim(wdetail.amper) 
            trim(wdetail.country)
            trim(wdetail.tiname)              
            trim(wdetail.insnam) 
            trim(brstat.tlt.safe1)                             
            (trim(brstat.tlt.filler2) + " [" + trim(nv_file1) + " : " + trim(nv_file2) + "]"   )                      
            wdetail.Account_no    /*trim(tlt.safe2) */  /*A55-0365*/                           
            trim(brstat.tlt.safe3) 
            IF wdetail.expdat = "" THEN string(brstat.tlt.comp_effdat) ELSE substr(trim(wdetail.EXPdat),7,2) + "/" + substr(trim(wdetail.EXPdat),5,2) + "/" + substr(trim(wdetail.EXPdat),1,4)   /*trim(string(brstat.tlt.expodat)) */ /*A57-0262expidat */ 
            trim(string(brstat.tlt.comp_coamt))  
            wdetail.re_country  
            wdetail.RECP_NAME 
            trim(brstat.tlt.recac)                          
            trim(brstat.tlt.rec_addr2)                
            replace(trim(brstat.tlt.rec_addr5),"*","")
            trim(brstat.tlt.endno) 
            wdetail.addr1_70    /*brstat.tlt.ins_addr3*/
            wdetail.addr2_70    
            wdetail.nsub_dist70 
            wdetail.ndirection70
            wdetail.nprovin70   
            wdetail.zipcode70   
            wdetail.addr1_72    /*brstat.tlt.ins_addr4*/
            wdetail.addr2_72    
            wdetail.nsub_dist72 
            wdetail.ndirection72
            wdetail.nprovin72   
            wdetail.zipcode72   
            brstat.tlt.ins_addr5     
            brstat.tlt.comp_noti_tlt 
            nv_remark    
            trim(substr(trim(brstat.tlt.expotim),1,4))  /*substr(trim(brstat.tlt.expotim),1,5) A67-0114 */ 
            brstat.tlt.sentcnt                    
            trim(brstat.tlt.old_eng)                  
            trim(brstat.tlt.old_cha)                  
            trim(brstat.tlt.comp_pol)                 
            substr(trim(brstat.tlt.expousr),1,3)                  
            trim(tlt.comp_sub)                  
            trim(tlt.comp_noti_ins)            
            trim(brstat.tlt.EXP)                      
            IF brstat.tlt.flag = "n" THEN "NEW" ELSE "RENEW" 
            ""                           
            ""
            ""
            ""
            nnid70       
            nnidbr70     
            nnid72       
            nnidbr72 
            IF brstat.tlt.nor_effdat = ?  THEN ""  ELSE STRING(brstat.tlt.nor_effdat,"99/99/9999")   
            IF brstat.tlt.comp_effdat = ? THEN "" ELSE STRING(brstat.tlt.comp_effdat,"99/99/9999")   
            (SUBSTR(brstat.tlt.model,51,10))
            (SUBSTR(brstat.tlt.expotim,5,4))
            (SUBSTR(brstat.tlt.expousr,7,3))
            ""
            brstat.tlt.dri_name1                      
            IF brstat.tlt.dri_no1 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no1)                       
            brstat.tlt.dir_occ1 /*A67-0087*/
            TRIM(brstat.tlt.dri_lic1) + "/" + TRIM(brstat.tlt.dri_ic1) /*A67-0114*/
            ""
            brstat.tlt.dri_name2                      
            IF brstat.tlt.dri_no2 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no2)
            brstat.tlt.dri_occ2 /*A67-0087*/
            TRIM(brstat.tlt.dri_lic2) + "/" + TRIM(brstat.tlt.dri_ic2) /*A67-0114*/
            ""
            brstat.tlt.dri_name3          /*A67-0087*/                                       
            IF brstat.tlt.dri_no3 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no3)  /*A67-0087*/ 
            brstat.tlt.dir_occ3 /*A67-0087*/                                     
            TRIM(brstat.tlt.dri_lic3) + "/" + TRIM(brstat.tlt.dri_ic3) /*A67-0114*/
            nv_acc /*nv_remark   */ /*A64-0092*/
            nv_Rec_name72
            nv_acc /*nv_remark   */ /*a64-0092*/
            nv_Rec_name72
            nv_Rec_add1  
            nv_messag 
            /* Add by : A67-0087 */                          
            nnBirthdate     /*A65-0356*/  
            brstat.tlt.note7                      
            brstat.tlt.note8                      
            ""                                    
            brstat.tlt.dri_name4                  
            IF brstat.tlt.dri_no4 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no4)  /*A67-0087*/                   
            brstat.tlt.dri_occ4                   
            TRIM(brstat.tlt.dri_lic4) + "/" + TRIM(brstat.tlt.dri_ic4) /*A67-0114*/                                   
            ""                                    
            brstat.tlt.dri_name5                  
            IF brstat.tlt.dri_no5 = ? THEN "" ELSE  STRING(brstat.tlt.dri_no5)  /*A67-0087*/                  
            brstat.tlt.dri_occ5                   
            TRIM(brstat.tlt.dri_lic5) + "/" + TRIM(brstat.tlt.dri_ic5) /*A67-0114*/                                    
            brstat.tlt.campaign                   
            brstat.tlt.ispflg                     
            brstat.tlt.ndeci1                     
            brstat.tlt.eng_no2                    
            brstat.tlt.note9                      
            brstat.tlt.note10                     
            brstat.tlt.note11                     
            brstat.tlt.subclass                   
            brstat.tlt.car_type .                 
            /* end : A67-0087 */  
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Receipt72 C-Win 
PROCEDURE Pro_Receipt72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

       /*IF INDEX(wdetail.remark,"ดีลเลอร์แถมพ") <> 0 THEN DO:*/ /*A60-0095*/
       IF INDEX(wdetail.remark,"ดีลเลอร์แถมพ")  <> 0  OR        /*A60-0095*/
          INDEX(wdetail.remark,"ดีลเลอร์แถม พ") <> 0 OR        /*A60-0095*/
          INDEX(wdetail.remark,"ดีลเลอร์ แถมพ") <> 0 THEN DO:  /*A60-0095*/
            ASSIGN                      /* ดีลเลอร์ */
                nv_72Reciept = SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/") + 1,LENGTH(wdetail.remark)).
            IF INDEX(nv_72Reciept,"จำกัด") <> 0  THEN  ASSIGN
              wdetail.reciept72 = SUBSTR(nv_72Reciept,1,R-INDEX(nv_72Reciept,"จำกัด") + 4). 
            ELSE ASSIGN wdetail.reciept72 = nv_72Reciept .
       END.
       ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์แถมเบี้ยและพ") <> 0 THEN   DO:            /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
           ASSIGN            
           wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       /*--A60-0095--*/
       ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์แถมเบี้ยและ พ") <> 0 THEN   DO:            /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
           ASSIGN            
           wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์แถมเบี้ย และพ") <> 0 THEN   DO:            /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
           ASSIGN            
           wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์ แถมเบี้ยและพ") <> 0 THEN   DO:            /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
           ASSIGN            
           wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์ แถมเบี้ย และพ") <> 0 THEN   DO:            /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
           ASSIGN            
           wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์แถม2") <> 0 THEN   DO:                   /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
           ASSIGN            
           wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       /*-- end : A60-0095--*/
       ELSE IF INDEX(wdetail.remark ,"ดีลเลอร์แถม 2") <> 0 THEN   DO:                   /* ดีลเลอร์ เบี้ย/พ.ร.บ. */ 
           ASSIGN            
           wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมพ.ร.บ.") <> 0 THEN    DO:                     /* ประกัน */
          ASSIGN    
          wdetail.Reciept72  =  "ธนาคารทิสโก้ จำกัด (มหาชน) ".                             /*"ธนาคารทิสโก้ จำกัด (มหาชน) "*/
       END.
       /*--A60-0095---*/
       ELSE IF INDEX(wdetail.remark,"ทิสโก้แถม พ") <> 0 THEN    DO:                     /* ประกัน */
          ASSIGN    
          wdetail.Reciept72  =  "ธนาคารทิสโก้ จำกัด (มหาชน) ".                             /*"ธนาคารทิสโก้ จำกัด (มหาชน) "*/
       END.
        ELSE IF INDEX(wdetail.remark,"ทิสโก้ แถมพ") <> 0 THEN    DO:                     /* ประกัน */
          ASSIGN    
          wdetail.Reciept72  =  "ธนาคารทิสโก้ จำกัด (มหาชน) ".                             /*"ธนาคารทิสโก้ จำกัด (มหาชน) "*/
       END.
       ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมเบี้ยและ พ") <> 0 THEN   DO:              /* ทิสโก้ เบี้ย/พ.ร.บ.  */
          ASSIGN             
          wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       /*-- end : A60-0095--*/
       ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมเบี้ยและพ") <> 0 THEN   DO:              /* ทิสโก้ เบี้ย/พ.ร.บ.  */
          ASSIGN             
          wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE IF INDEX(wdetail.remark,"ทิสโก้แถมเบี้ย และพ") <> 0 THEN   DO:              /* ทิสโก้ เบี้ย (วรรค)/พ.ร.บ.  */
          ASSIGN             
          wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE IF INDEX(wdetail.remark,"ประกันแถมพ") <> 0 THEN    DO:                    /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).    /*ชื่อลูกค้า-*/
       END. 
       /*--A60-0095---*/
       ELSE IF INDEX(wdetail.remark,"ประกันแถม พ") <> 0 THEN    DO:                    /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).    /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"ประกัน แถมพ") <> 0 THEN    DO:                    /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).    /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"บ.ประกันแถมพ") <> 0 THEN    DO:                    /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).    /*ชื่อลูกค้า-*/
       END. 
       ELSE IF INDEX(wdetail.remark,"บ.ประกันแถม พ") <> 0 THEN    DO:                    /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).    /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"บ.ประกัน แถมพ") <> 0 THEN    DO:                    /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).    /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"บ.ประกันแถมเบี้ยและพ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"บ.ประกันแถมเบี้ย และพ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"บ.ประกัน แถมเบี้ยและพ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"บ.ประกันแถมเบี้ยและ พ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"ประกันแถมเบี้ย และพ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"ประกัน แถมเบี้ยและพ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"ประกันแถมเบี้ยและ พ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       /*--end : A60-0095---*/
       ELSE IF INDEX(wdetail.remark,"ประกันแถมเบี้ยและพ") <> 0 THEN     DO:           /* ประกัน */
           ASSIGN            
           wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).     /*ชื่อลูกค้า-*/
       END.
       ELSE IF INDEX(wdetail.remark,"พ.ร.บ.ลูกค้าจ่าย") <> 0 THEN   DO:                     /* ลูกค้า */
          ASSIGN             
          wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).
       END.
       /*--A60-0095--*/
       ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่ายพ.ร.บ.") <> 0 THEN   DO:                     /* ลูกค้า */
          ASSIGN             
          wdetail.Reciept72 =  TRIM(wdetail.tiname) + " " + TRIM(wdetail.insnam) + " " + TRIM(wdetail.name2).
       END.
       ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่ายเบี้ย และพ") <> 0 THEN    DO:    /* ลูกค้า เบี้ย/พ.ร.บ. */
          ASSIGN                                                                
          wdetail.Reciept72 =  wdetail.RECP_NAME.                               
       END.                                                                     
       ELSE IF INDEX(wdetail.remark,"ลูกค้า จ่ายเบี้ยและพ") <> 0 THEN    DO:    /* ลูกค้า เบี้ย/พ.ร.บ. */
          ASSIGN                                                                
          wdetail.Reciept72 =  wdetail.RECP_NAME.                               
       END.                                                                     
       ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่ายเบี้ยและ พ") <> 0 THEN    DO:    /* ลูกค้า เบี้ย/พ.ร.บ. */
          ASSIGN                                                                
          wdetail.Reciept72 =  wdetail.RECP_NAME.                               
       END.                                                                     
       ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่าย2 ") <> 0 THEN    DO:            /* ลูกค้า เบี้ย/พ.ร.บ. */
         ASSIGN                                                                 
         wdetail.Reciept72 =  wdetail.RECP_NAME.                                
       END.                                                                     
       /*--end A60-0095--*/                                                     
       ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่ายเบี้ยและพ") <> 0 THEN    DO:     /* ลูกค้า เบี้ย/พ.ร.บ. */
          ASSIGN                                                                
          wdetail.Reciept72 =  wdetail.RECP_NAME.                               
       END.                                                                     
       ELSE IF INDEX(wdetail.remark,"ลูกค้าจ่าย 2 ") <> 0 THEN    DO:           /* ลูกค้า เบี้ย/พ.ร.บ. */
         ASSIGN                                                                 
         wdetail.Reciept72 =  wdetail.RECP_NAME.
       END.
       ELSE wdetail.Reciept72 = " ".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

