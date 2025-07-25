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
wgwimtis.w :  Import text file from  ICBCTL  to create new policy Add in table tlt( brstat)  
Program Import Text File    - File detail insured 
                            -  File detail Driver
Create  by   : Ranu i.  [A59-288]  date. 26/09/2016
copy program : wgwimicb.w  
Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)
Modify by    : Ranu I. A60-0263 Date 12/06/2017 ��������红�������໭ �ҡ���ҹ����ᴧ
modify by    : Ranu I. A61-0221 date 17/05/2018 ����������� Family (���ö)    
Modigy by    : Ranu I. A62-0445 date 01/10/2019 ����������ҧ���ͧ��Ǩ��Ҿ ����� suspect  
Modify by    : Kridtiya i. A64-0137  27/03/2021 ���� ���ʵ��᷹���˹�� �������ö���͡�� 
                                                ��� ���� ���ͼ���Ѻ�Ż���ª�� �ó� ʶҹТ���� ��� Active
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
DEFINE VAR nv_updatecnt   AS INT  INIT  0.
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD n_no          AS CHAR FORMAT "X(3)"   INIT ""  /*No         */          
    FIELD Pro_off       AS CHAR FORMAT "X(10)"  INIT ""  /*InsComp    */          
    FIELD branch        AS CHAR FORMAT "X(20)"  INIT ""  /*OffCde     */          
    FIELD safe_no       AS CHAR FORMAT "X(70)"  INIT ""  /*InsuranceReceivedNo  */          
    FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""  /*ApplNo     */          
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""  /*CustName   */          
    FIELD icno          AS CHAR FORMAT "X(13)"  INIT ""  /*IDNo       */          
    FIELD garage        AS CHAR FORMAT "X(10)"  INIT ""  /*RepairType */          
    FIELD CustAge       AS CHAR FORMAT "X(2)"   INIT ""  /*CustAge    */          
    FIELD Category      AS CHAR FORMAT "X(50)"  INIT ""  /*Category   */          
    FIELD CarType       AS CHAR FORMAT "X(30)"  INIT ""  /*CarType    */          
    FIELD brand         AS CHAR FORMAT "X(30)"  INIT ""  /*Brand      */          
    FIELD Brand_Model   AS CHAR FORMAT "X(30)"  INIT ""  /*Model      */          
    FIELD CC            AS CHAR FORMAT "X(10)"  INIT ""  /*CC         */   
    FIELD weigth        AS CHAR FORMAT "x(5)"   INIT "0"              
    FIELD yrmanu        AS CHAR FORMAT "X(5)"   INIT ""  /*CarYear    */          
    FIELD RegisDate     AS CHAR FORMAT "X(15)"  INIT ""  /*RegisDate  */          
    FIELD engine        AS CHAR FORMAT "X(15)"  INIT ""  /*EngineNo   */          
    FIELD chassis       AS CHAR FORMAT "X(15)"  INIT ""  /*ChassisNo  */          
    FIELD RegisNo       AS CHAR FORMAT "X(13)"  INIT ""  /*RegisNo    */          
    FIELD RegisProv     AS CHAR FORMAT "X(25)"  INIT ""  /*RegisProv  */          
    FIELD n_class       AS CHAR FORMAT "X(5)"   INIT ""  /*InsLicTyp  */          
    FIELD InsTyp        AS CHAR FORMAT "X(30)"  INIT ""  /*InsTyp     */          
    FIELD CovTyp        AS CHAR FORMAT "X(30)"  INIT ""  /*CovTyp     */          
    FIELD SI            AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceAmt (crash) */          
    FIELD FI            AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceAmt (loss)  */          
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceStartDate   */          
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceExpireDate  */          
    FIELD netprem       AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceNetFee  */          
    FIELD totalprem     AS CHAR FORMAT "X(15)"  INIT ""  /*InsuranceFee     */          
    FIELD comtyp        AS CHAR FORMAT "X(10)"  INIT ""  /*�ú. ��/�����  */          
    FIELD ben_name      AS CHAR FORMAT "X(100)" INIT ""  /*Beneficiary      */          
    FIELD CMRName       AS CHAR FORMAT "X(50)"  INIT ""  /*CMRName          */          
    FIELD sckno         AS CHAR FORMAT "X(13)"  INIT ""  /*InsurancePolicyNo*/          
    FIELD comdat72      AS CHAR FORMAT "X(15)"  INIT ""  /*LawInsStartDate  */          
    FIELD expdat72      AS CHAR FORMAT "X(15)"  INIT ""  /*LawInsEndDate    */          
    FIELD comp_prm      AS CHAR FORMAT "X(10)"  INIT ""  /*LawInsFee        */          
    FIELD Remark        AS CHAR FORMAT "X(255)" INIT ""  /*Other            */          
    FIELD DealerName    AS CHAR FORMAT "X(60)"  INIT ""  /*DealerName       */          
    FIELD CustAddress   AS CHAR FORMAT "X(150)" INIT ""  /*CustAddress      */          
    FIELD CustTel       AS CHAR FORMAT "X(30)"  INIT ""  /*CustTel          */  
    FIELD prevpol       AS CHAR FORMAT "x(13)"  INIT ""  
    FIELD DD            AS CHAR FORMAT "X(15)"  INIT ""  /*��ǹŴ����ѵ����� */           
    FIELD fleetper      AS CHAR FORMAT "X(15)"  INIT ""  /*��ǹŴ�����       */           
    FIELD ncbper        AS CHAR FORMAT "X(15)"  INIT ""  /*����ѵԴ�         */           
    FIELD othper        AS CHAR FORMAT "x(15)"  INIT ""  /*��� �            */           
    FIELD pol_addr1     as char format "x(150)" init ""  /*��������١���     */ 
    FIELD pol_title     as char format "x(15)"  init ""  
    FIELD pol_fname     as char format "x(150)"  init ""
    FIELD pol_lname     as char format "x(50)"  init ""
    FIELD not_time      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD branch_saf    AS CHAR FORMAT "x(2)"   INIT ""
    FIELD comp_prmtotal AS CHAR FORMAT "x(10)"  INIT ""
    FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD n_class70     AS CHAR FORMAT "x(5)"   INIT ""
    FIELD otherins      AS CHAR FORMAT "x(100)" INIT ""
    FIELD campaign      AS CHAR FORMAT "x(20)"  INIT ""
    FIELD compno        AS CHAR FORMAT "x(13)"  INIT ""
    FIELD saleid        AS CHAR FORMAT "x(15)"  INIT ""
    FIELD taxname       AS CHAR FORMAT "x(50)"  INIT ""
    FIELD taxno         AS CHAR FORMAT "x(15)"  INIT ""
    FIELD n_color       AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD accsor        as CHAR FORMAT "X(120)" INIT ""
    FIELD accsor_price  as CHAR FORMAT "X(15)"  INIT ""
    FIELD drivname1     as char format "x(60)"  init ""
    FIELD drivdate1     as char format "x(15)"  init ""
    FIELD drivid1       as char format "x(15)"  init ""
    FIELD drivname2     as char format "x(60)"  init ""
    FIELD drivdate2     as char format "x(15)"  init ""
    FIELD drivid2       as char format "x(15)"  init ""
    FIELD pack          AS CHAR FORMAT "x(2)"   INIT ""
    FIELD agent         AS CHAR FORMAT "x(10)"  INIT ""
    FIELD vatcode       AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD inspect       AS CHAR FORMAT "x(15)"  INIT ""
    FIELD cartyp        as char format "x(50)" init "" 
    FIELD typins        as char format "x(20)" init "" 
    FIELD bdate         as char format "x(15)" init "" 
    FIELD expbdate      as char format "x(15)" init "" 
    FIELD occup         as char format "x(100)" init "" 
    FIELD company       as char format "x(100)" init ""
    FIELD addr1         as char format "x(250)" init "" 
    FIELD addr2         as char format "x(50)" init "" 
    FIELD addr3         as char format "x(50)" init "" 
    FIELD addr4         as char format "x(50)" init "" 
    FIELD addr5         as char format "x(25)" init "" 
    FIELD pol_addr2     as char format "x(50)" init "" 
    FIELD pol_addr3     as char format "x(50)" init "" 
    FIELD pol_addr4     as char format "x(50)" init "" 
    FIELD pol_addr5     as char format "x(50)" init "" 
    FIELD phone         as char format "x(25)" init "" 
    FIELD drivno        as char format "x(30)" init "" 
    FIELD drivgen1      as char format "x(10)" init "" 
    FIELD drivocc1      as char format "x(50)" init "" 
    FIELD drivgen2      as char format "x(10)" init "" 
    FIELD drivocc2      as char format "x(50)" init "" 
    FIELD stk           as char format "x(15)" init "" 
    FIELD policy        AS CHAR FORMAT "x(15)" INIT ""   
    FIELD sts           AS CHAR FORMAT "x(20)" INIT "" 
    FIELD pass          AS CHAR FORMAT "x(5)" INIT "". 

DEFINE NEW SHARED TEMP-TABLE wtlt NO-UNDO
    FIELD trndat        AS CHAR FORMAT "x(15)"  INIT ""
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*�Ţ����Ѻ��         */           
    FIELD branch        AS CHAR FORMAT "X(20)"   INIT ""   /*�Ң�                  */           
    FIELD Account_no    AS CHAR FORMAT "X(12)"  INIT ""   /*�Ţ����ѭ��           */           
    FIELD prev_pol      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ�������������    */           
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""   /*���ͼ����һ�Сѹ���   */           
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ��������������ͧ   */           
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ�������ش������ͧ */           
    FIELD comdat72      AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ�������������ͧ�ú */           
    FIELD expdat72      AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ�������ش������ͧ�ú*/         
    FIELD licence       AS CHAR FORMAT "X(11)"  INIT ""   /*�Ţ����¹            */           
    FIELD province      AS CHAR FORMAT "X(30)"  INIT ""   /*�ѧ��Ѵ               */           
    FIELD ins_amt       AS CHAR FORMAT "X(15)"  INIT ""   /*�ع��Сѹ             */           
    FIELD prem1         AS CHAR FORMAT "X(15)"  INIT ""   /*���»�Сѹ���        */           
    FIELD comp_prm      AS CHAR FORMAT "X(15)"  INIT ""   /*���¾ú���           */           
    FIELD gross_prm     AS CHAR FORMAT "X(15)"  INIT ""   /*�������              */           
    FIELD compno        AS CHAR FORMAT "X(13)"  INIT ""   /*�Ţ��������ú        */           
    FIELD sckno         AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���ʵ������ */           
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ����Ѻ��         */           
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""   /*���ͻ�Сѹ���         */           
    FIELD not_name      AS CHAR FORMAT "X(50)"  INIT ""   /*�����               */           
    FIELD brand         AS CHAR FORMAT "X(15)"  INIT ""   /*������                */           
    FIELD Brand_Model   AS CHAR FORMAT "X(35)"  INIT ""   /*���                  */           
    FIELD yrmanu        AS CHAR FORMAT "X(10)"  INIT ""   /*��                    */           
    FIELD weight        AS CHAR FORMAT "X(10)"  INIT ""   /*��Ҵ����ͧ           */           
    FIELD engine        AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����ͧ            */           
    FIELD chassis       AS CHAR FORMAT "X(20)"  INIT ""    /*�Ţ�ѧ                */
    FIELD camp          AS CHAR FORMAT "x(10)"  INIT ""
    FIELD campaign      AS CHAR FORMAT "x(20)"  INIT "". /*A60-0263*/
/*------------------------------�����ż��Ѻ��� -------------------------*/
/*DEFINE WORKFILE  wdriver NO-UNDO
    FIELD RecordID     AS CHAR FORMAT "X(02)"   INIT ""     /*1 Detail Record "D"*/
    FIELD Pro_off      AS CHAR FORMAT "X(20)"   INIT ""     /*2 �����Ңҷ������һ�Сѹ�Դ�ѭ��    */
    FIELD chassis      AS CHAR FORMAT "X(25)"   INIT ""     /*3 �����Ţ��Ƕѧ    */
    FIELD dri_no       AS CHAR FORMAT "X(02)"   INIT ""     /*4 �ӴѺ��褹�Ѻ  */
    FIELD dri_name     AS CHAR FORMAT "X(40)"   INIT ""     /*5 ���ͤ��Ѻ   */
    FIELD Birthdate    AS CHAR FORMAT "X(10)"   INIT ""     /*6 �ѹ��͹���Դ  */
    FIELD occupn       AS CHAR FORMAT "X(75)"   INIT ""     /*7 �Ҫվ*/
    FIELD position     AS CHAR FORMAT "X(40)"   INIT ""  .  /*8 ���˹觧ҹ */*/
DEF  STREAM nfile.  
DEF VAR nv_accdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_comdat72   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
DEF VAR nv_expdat72   AS DATE   FORMAT "99/99/9999"   NO-UNDO.
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
DEF VAR nv_len      AS INTE INIT 0.

/* add by A62-0445  */
DEF VAR nv_ispstatus AS CHAR.
DEF VAR chSession       AS COM-HANDLE.
DEF VAR chWorkSpace     AS COM-HANDLE.
DEF VAR chName          AS COM-HANDLE.
DEF VAR chDatabase      AS COM-HANDLE.
DEF VAR chView          AS COM-HANDLE.
DEF VAR chViewEntry     AS COM-HANDLE.
DEF VAR chViewNavigator AS COM-HANDLE.
DEF VAR chDocument      AS COM-HANDLE.
DEF VAR chUIDocument    AS COM-HANDLE.
DEF VAR NotesServer  AS CHAR.
DEF VAR NotesApp     AS CHAR.
DEF VAR NotesView    AS CHAR.
DEF VAR nv_chknotes  AS CHAR.
DEF VAR nv_chkdoc    AS LOG.
DEF VAR nv_year      AS CHAR.
DEF VAR nv_msgbox    AS CHAR.   
DEF VAR nv_name      AS CHAR.
DEF VAR nv_datim     AS CHAR.
DEF VAR nv_branch    AS CHAR.
DEF VAR nv_brname    AS CHAR.
DEF VAR nv_pattern   AS CHAR.
DEF VAR nv_count     AS INT.
DEF VAR nv_text1     AS CHAR.
DEF VAR nv_text2     AS CHAR.
DEF VAR nv_chktext   AS INT.
DEF VAR nv_model     AS CHAR.
DEF VAR nv_modelcode AS CHAR.
DEF VAR nv_makdes    AS CHAR.
DEF VAR nv_licence1  AS CHAR.
DEF VAR nv_licence2  AS CHAR.
/**/
DEF VAR nv_cha_no  AS CHAR.
DEF VAR nv_doc_num AS INT.
DEF VAR nv_licen1  AS CHAR.
DEF VAR nv_licen2  AS CHAR.
DEF VAR nv_key1    AS CHAR.
DEF VAR nv_key2    AS CHAR.
DEF VAR nv_surcl   AS CHAR.
DEF VAR nv_docno   AS CHAR.

DEF VAR nv_brdesc AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR nv_brcode AS CHAR FORMAT "x(3)" INIT "" .
DEF VAR nv_comco AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_producer AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_agent AS CHAR FORMAT "x(10)" INIT "" .
DEF VAR nv_char AS CHAR FORMAT "x(225)" INIT "" .
DEF VAR nv_length AS INT INIT 0.
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
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
Def var nv_acctotal      as char format "x(100)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".  
DEF VAR nv_date          AS CHAR FORMAT "x(15)" .
DEF VAR nv_damdetail     AS LONGCHAR .
DEF VAR nv_sumsi         AS DECI INIT 0 .
DEF VAR n_day AS INT INIT 0.
DEF VAR nv_insi AS DECI INIT 0.
DEF VAR nv_provin AS CHAR FORMAT "x(10)" .
DEF VAR nv_key3 AS CHAR FORMAT "x(35)" .
DEF VAR nv_susupect AS CHAR FORMAT "x(255)" .

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
&Scoped-define INTERNAL-TABLES wtlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt wtlt.trndat /*wtlt.Notify_no wtlt.branch */ wtlt.Account_no wtlt.prev_pol wtlt.name_insur wtlt.comdat wtlt.comdat72 wtlt.licence wtlt.province wtlt.ins_amt wtlt.prem1 wtlt.comp_prm /* wtlt.gross_prm wtlt.compno */ wtlt.not_date /* wtlt.not_office wtlt.not_name wtlt.brand */ wtlt.Brand_Model wtlt.yrmanu wtlt.weight wtlt.engine wtlt.chassis   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt   
&Scoped-define SELF-NAME br_imptxt
&Scoped-define QUERY-STRING-br_imptxt FOR EACH wtlt NO-LOCK
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY {&SELF-NAME} FOR EACH wtlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_imptxt wtlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt wtlt


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_imptxt}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_imptxt tg_tmsth cb_producer rs_type ~
fi_loaddat fi_compa fi_filename bu_ok bu_exit bu_file fi_agent RECT-1 ~
RECT-79 RECT-80 RECT-380 
&Scoped-Define DISPLAYED-OBJECTS tg_tmsth cb_producer rs_type fi_loaddat ~
fi_compa fi_filename fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet ~
fi_agent 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE cb_producer AS CHARACTER 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "B3MLSCB101","B3MLSCB101",
                     "B3MLSCB102","B3MLSCB102",
                     "B3MLSCB103","B3MLSCB103",
                     "B3MLSCB104","B3MLSCB104",
                     "A0M2016","A0M2016",
                     "B3M0009","B3M0009",
                     "B3M0010","B3M0010"
     DROP-DOWN
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dir_cnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dri_complet AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "�駧ҹẺ�����´", 1,
"�駧ҹẺ���", 2
     SIZE 49.83 BY .91
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.81
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128.5 BY 7.19
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-80
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.5 BY 1.91
     BGCOLOR 4 .

DEFINE VARIABLE tg_tmsth AS LOGICAL INITIAL no 
     LABEL "Data EMP" 
     VIEW-AS TOGGLE-BOX
     SIZE 13 BY .81
     BGCOLOR 10 FGCOLOR 1  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      wtlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _FREEFORM
  QUERY br_imptxt NO-LOCK DISPLAY
      wtlt.trndat       COLUMN-LABEL "�ѹ�����Ŵ������"    FORMAT "x(15)"
      /*wtlt.Notify_no    COLUMN-LABEL "�Ţ����Ѻ��"       FORMAT "x(20)"
      wtlt.branch       COLUMN-LABEL "�Ң�"                FORMAT "XX"  */             
      wtlt.Account_no   COLUMN-LABEL "�Ţ����ѭ��"         FORMAT "x(18)"            
      wtlt.prev_pol     COLUMN-LABEL "�Ţ�������������"  FORMAT "x(15)"            
      wtlt.name_insur   COLUMN-LABEL "���ͼ����һ�Сѹ���" FORMAT "X(50)"       
      wtlt.comdat       COLUMN-LABEL "�ѹ��������ͧ 70 "      FORMAT "X(15)"       
      wtlt.comdat72     COLUMN-LABEL "�ѹ��������ͧ 72 "       FORMAT "X(15)"  
      wtlt.licence      COLUMN-LABEL "�Ţ����¹"          FORMAT "x(25)"            
      wtlt.province     COLUMN-LABEL "�ѧ��Ѵ"             FORMAT "X(20)"            
      wtlt.ins_amt      COLUMN-LABEL "�ع��Сѹ"           FORMAT "X(15)"                     
      wtlt.prem1        COLUMN-LABEL "���»�Сѹ���"      FORMAT "X(15)"                              
      wtlt.comp_prm     COLUMN-LABEL "���¾ú���"         FORMAT "X(15)"                 
     /* wtlt.gross_prm    COLUMN-LABEL "�������"            FORMAT "X(15)"                    
      wtlt.compno       COLUMN-LABEL "�Ţ��������ú"      FORMAT "x(15)"  */
      wtlt.not_date     COLUMN-LABEL "�ѹ����Ѻ��"       FORMAT "x(15)"   
     /* wtlt.not_office   COLUMN-LABEL "���ͻ�Сѹ���"       FORMAT "x(20)"     
      wtlt.not_name     COLUMN-LABEL "�����"             FORMAT "x(30)"      
      wtlt.brand        COLUMN-LABEL "������"              FORMAT "x(20)" */                   
      wtlt.Brand_Model  COLUMN-LABEL "���"                FORMAT "x(20)"                        
      wtlt.yrmanu       COLUMN-LABEL "��"                  FORMAT "X(4)"          
      wtlt.weight       COLUMN-LABEL "��Ҵ����ͧ"         FORMAT "X(10)"       
      wtlt.engine       COLUMN-LABEL "�Ţ����ͧ"          FORMAT "x(20)"                                                                               
      wtlt.chassis      COLUMN-LABEL "�Ţ�ѧ"              FORMAT "x(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 15.48
         BGCOLOR 19 FGCOLOR 2 FONT 4 ROW-HEIGHT-CHARS .76 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_imptxt AT ROW 9.1 COL 3.17
     tg_tmsth AT ROW 3.62 COL 92 WIDGET-ID 18
     cb_producer AT ROW 2.57 COL 38 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     rs_type AT ROW 3.67 COL 40.17 NO-LABEL WIDGET-ID 12
     fi_loaddat AT ROW 1.48 COL 38 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.48 COL 72 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 4.67 COL 38 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.24 COL 100.5
     bu_exit AT ROW 6.33 COL 110.83
     bu_file AT ROW 4.71 COL 116.33
     fi_impcnt AT ROW 5.81 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 5.81 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 6.91 COL 38.33 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 6.91 COL 75.17 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 2.52 COL 72.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 5.81 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.48 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 5.81 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "������к���  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 5.81 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "    Agent Code :" VIEW-AS TEXT
          SIZE 16.17 BY 1 AT ROW 2.52 COL 57.33 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "           ��سһ�͹����������� :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.62 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " �������駻�Сѹ����ҷ�����  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 5.71 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "  ��������´������" VIEW-AS TEXT
          SIZE 128.5 BY .81 AT ROW 8.29 COL 2.83
          FGCOLOR 7 FONT 6
     "                   �ѹ�������駧ҹ :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.48 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "        �����ż��Ѻ������ҷ�����  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6.81 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                       Notify Type  :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 3.57 COL 10.5 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.91 COL 52.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                  Producer Code  :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 2.52 COL 10.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "������к���  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 6.91 COL 61.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 6.91 COL 89.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1
     RECT-79 AT ROW 5 COL 98
     RECT-80 AT ROW 5 COL 109.83
     RECT-380 AT ROW 1.19 COL 3
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "Hold Data Text file SCB RENEW"
         HEIGHT             = 24
         WIDTH              = 132.33
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
IF NOT C-Win:LOAD-ICON("I:/Safety/WALP10/WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: I:/Safety/WALP10/WIMAGE/safety.ico"
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
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dir_cnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_complet IN FRAME fr_main
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
OPEN QUERY {&SELF-NAME} FOR EACH wtlt NO-LOCK.
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Hold Data Text file SCB RENEW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Hold Data Text file SCB RENEW */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
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
        fi_filename  = cvData.
        DISP fi_filename WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    ASSIGN 
        nv_daily   =  ""
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wtlt:
        DELETE  wtlt.
    END.
    IF cb_producer = ""  THEN DO:
        MESSAGE "Producer code �繤����ҧ " VIEW-AS ALERT-BOX.
        APPLY "entry" TO cb_producer .
        RETURN NO-APPLY.
    END.
    ELSE IF fi_agent = ""  THEN DO:
        MESSAGE "Agent code �繤����ҧ " VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_agent .
        RETURN NO-APPLY.
    END.
    ELSE IF fi_filename = ""  THEN DO:
        MESSAGE "������Ң����� �繤����ҧ " VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_filename .
        RETURN NO-APPLY.
    END.
    ELSE DO:
        IF rs_type = 1 THEN Run  Import_file.
        ELSE RUN IMPORT_file2.
    END.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_producer C-Win
ON VALUE-CHANGED OF cb_producer IN FRAME fr_main
DO:
    cb_producer = INPUT cb_producer .
    DISP cb_producer WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
     fi_agent =  INPUT  fi_agent.
    Disp  fi_agent   WITH Frame  fr_main.                 

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


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp fi_loaddat  with frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type .
    DISP rs_type WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME tg_tmsth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_tmsth C-Win
ON MOUSE-SELECT-CLICK OF tg_tmsth IN FRAME fr_main /* Data EMP */
DO:
    tg_tmsth = INPUT tg_tmsth .
    DISP tg_tmsth WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL tg_tmsth C-Win
ON VALUE-CHANGED OF tg_tmsth IN FRAME fr_main /* Data EMP */
DO:
    tg_tmsth = INPUT tg_tmsth .
    DISP tg_tmsth WITH FRAME fr_main.
  
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
  
  gv_prgid = "wgwimscbr".
  gv_prog  = "Hold Text File SCB RENEW".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  /*RECT-4:MOVE-TO-TOP().
  RECT-75:MOVE-TO-TOP().  */
 
  Hide Frame  fr_gen  .
  ASSIGN  
      rs_type      = 1
      fi_loaddat   =  today
      fi_compa     = "SCBRE"
      /*cb_producer  = "A0M2016"
      fi_agent     = "B3M0009"*/
      cb_producer  = "B3MLSCB101"
      fi_agent     = "B3MLSCB100"
      tg_tmsth     = NO .
     
  disp rs_type  fi_loaddat fi_agent cb_producer fi_compa tg_tmsth with  frame  fr_main.
  
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
  DISPLAY tg_tmsth cb_producer rs_type fi_loaddat fi_compa fi_filename fi_impcnt 
          fi_completecnt fi_dir_cnt fi_dri_complet fi_agent 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_imptxt tg_tmsth cb_producer rs_type fi_loaddat fi_compa fi_filename 
         bu_ok bu_exit bu_file fi_agent RECT-1 RECT-79 RECT-80 RECT-380 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_file C-Win 
PROCEDURE import_file :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"   
            wdetail.n_no            /*�ӴѺ���   */                             
            wdetail.RegisDate       /*�ѹ���     */                             
            wdetail.CMRName         /*�������˹�ҷ�����駻�Сѹ���*/         
            Wdetail.company         /*���ͺ���ѷ        */                      
            wdetail.pol_fname       /*���ͼ����һ�Сѹ  */                      
            wdetail.prevpol         /*�����������      */                      
            wdetail.cartyp          /*������ö          */                      
            wdetail.Brand_Model     /*������ö/���     */                      
            wdetail.yrmanu          /*�����            */                      
            wdetail.RegisNo         /*����¹ö         */                      
            wdetail.RegisProv       /*�ѧ��Ѵ           */                      
            wdetail.CC              /*��Ҵ              */                      
            wdetail.weigth          /*���˹ѡ           */ 
            wdetail.chassis         /*�Ţ����ͧ¹��    */  
            wdetail.engine          /*�Ţ��Ƕѧ         */      
            wdetail.CovTyp          /*��������û�Сѹ���*/                      
            wdetail.comdat          /*�ѹ��������ͧ    */                      
            wdetail.totalprem       /*������»�Сѹ��� */                      
            wdetail.SI              /*�ع��Сѹ         */                      
            wdetail.garage          /*ʶҹ������       */                      
            wdetail.typins          /*������            */                      
            Wdetail.ncbper          /*%NCB              */                      
            wdetail.DD              /*������������ǹ�á */                      
            wdetail.drivno          /*�кؼ��Ѻ���     */                      
            wdetail.drivid1         /*�Ţ�ѵ�㺢Ѻ���   */                      
            wdetail.accsor          /*�ػ�ó��������  */                      
            wdetail.comdat72        /*�ѹ������ͧ�ú.   */                      
            wdetail.comp_prmtotal   /*������¾ú.  */                          
            /*wdetail.stk     */        /*ʵԡ����     */                          
            wdetail.sts             /*Status        */                          
            wdetail.icno            /*ID            */                          
            wdetail.not_time        /*�����觧ҹ    */                          
            wdetail.account_no      /*�Ţ����ѭ��   */                          
            wdetail.pol_addr1       /*�������㹡�����͡���*/                   
            wdetail.pol_addr2       /*�������   */                              
            wdetail.pol_addr3       /*�������   */                              
            wdetail.pol_addr4       /*�������   */                              
            wdetail.pol_addr5       /*�������   */                              
            wdetail.Remark   .       /*�����˵�  */                              
        IF INDEX(wdetail.n_no,"�ӴѺ") <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.n_no,"���")   <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.n_no,"No")    <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.n_no               = "" THEN  DELETE wdetail.
    END.  /* repeat  */
    ASSIGN nv_reccnt    = 0
        nv_completecnt  = 0 . 

   /* RUN proc_chkdata.*/

    Run proc_Create_tlt.
    
    If  nv_completecnt  <>  0  Then do:
        Enable br_imptxt With frame fr_main.
    End. 
    
    fi_completecnt  =  nv_completecnt.
    fi_impcnt       =  nv_reccnt.
    
    Disp fi_completecnt   fi_impcnt with frame  fr_main.
    Message "Load  Data Complete"  View-as alert-box.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_file2 C-Win 
PROCEDURE import_file2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"  
            wdetail.account_no      /*�Ţ����ѭ��   */
            wdetail.pol_fname       /*���ͼ����һ�Сѹ  */
            wdetail.typins          /*������            */
            wdetail.RegisNo         /*����¹ö         */
            wdetail.prevpol         /*�����������      */                      
            wdetail.garage          /*ʶҹ������       */     
            wdetail.comdat          /*�ѹ��������ͧ    */  
            wdetail.SI              /*�ع��Сѹ         */                      
            wdetail.totalprem       /*������»�Сѹ��� */
            wdetail.comp_prmtotal   /*������¾ú.  */ 
            wdetail.CMRName         /*�������˹�ҷ�����駻�Сѹ���*/                      
            wdetail.icno            /*ID            */  .                             
        IF INDEX(wdetail.n_no,"���")        <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.n_no,"No")    <> 0 THEN  DELETE wdetail.
        ELSE IF TRIM(wdetail.n_no)          <> "" THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.account_no,"�Ţ") <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.account_no         = "" THEN  DELETE wdetail.
    END.  /* repeat  */
    ASSIGN  nv_reccnt       = 0
            nv_completecnt  = 0 . 

    Run proc_Create_tlt.
    
    If  nv_completecnt  <>  0  Then do:
        Enable br_imptxt With frame fr_main.
    End. 
    
    fi_completecnt  =  nv_completecnt.
    fi_impcnt       =  nv_reccnt.
    
    Disp fi_completecnt   fi_impcnt with frame  fr_main.
    Message "Load  Data Complete"  View-as alert-box.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_GETISP C-Win 
PROCEDURE PD_GETISP :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A62-0445 Date 01/10/2019       
------------------------------------------------------------------------------*/
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.
DEF VAR n_agent     AS CHAR FORMAT "x(10)" INIT "".
DEF VAR n_repair    AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam       AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil    AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag    AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair   AS CHAR FORMAT "x(30)" init "".
DO:
      chitem       = chDocument:Getfirstitem("ConsiderDate").      /*�ѹ���Դ����ͧ*/
      IF chitem <> 0 THEN nv_date = chitem:TEXT. 
      ELSE nv_date = "".

      chitem       = chDocument:Getfirstitem("docno").      /*�Ţ��Ǩ��Ҿ*/
      IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
      ELSE nv_docno = "".
      
      chitem       = chDocument:Getfirstitem("SurveyClose").    /* �൵�ʻԴ����ͧ */
      IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
      ELSE nv_survey = "".

      chitem       = chDocument:Getfirstitem("SurveyResult").  /*�š�õ�Ǩ*/
      IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
      ELSE nv_detail = "".

      IF nv_detail = "�Դ�ѭ��" THEN DO:
          chitem       = chDocument:Getfirstitem("DamageC").    /*�����š�õԴ�ѭ�� */
          IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
          ELSE nv_damage = "".
      END.
      IF nv_detail = "�դ����������"  THEN DO:
          chitem       = chDocument:Getfirstitem("DamageList").  /* ��¡�ä���������� */
          IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
          ELSE nv_damlist = "".
         /* chitem       = chDocument:Getfirstitem("TotalExpensive").  /* �ҤҤ���������� */
          IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
          ELSE nv_totaldam = "".*/

          IF nv_damlist <> "" THEN DO: 
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = " " + nv_damlist + " ��¡�� " .
          END.
          /*IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "�������������·����� " + nv_totaldam + " �ҷ " .*/
          
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
                    /*chitem       = chDocument:Getfirstitem(n_repair).
                    IF chitem <> 0 THEN  nv_repair = chitem:TEXT. 
                    ELSE nv_repair = "".*/

                    IF nv_damag <> "" THEN  
                        ASSIGN nv_damdetail = trim(nv_damdetail + STRING(n_count) + "." + nv_damag /*+ " " + nv_repair*/ + ", ") .
                        
                    n_count = n_count + 1.
                END.
                ELSE LEAVE loop_damage.
            END.
          END.
      END.
      /*-- ��������� � ---*/
     /* chitem       = chDocument:Getfirstitem("SurveyData").
      IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
      ELSE nv_surdata = "".
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "���������� :"  +  nv_surdata .*/
      
     /*-- �ػ�ó������ --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
         /* chitem       = chDocument:Getfirstitem("PricesTotal").  /* �Ҥ�����ػ�ó������ */
          IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
          ELSE nv_acctotal = "".*/
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
          
          nv_device = "" .
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
          nv_device   = " �ػ�ó������ :" + TRIM(nv_device).
          /*nv_acctotal = " �Ҥ�����ػ�ó������ " + nv_acctotal + " �ҷ " .*/

      END.

END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_address C-Win 
PROCEDURE proc_address :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
  
------------------------------------------------------------------------------*/
/*IF rs_type = 1 THEN DO:  /* ���á */*/
   ASSIGN wdetail.CustAddress = trim(wdetail.pol_addr1) + " " + TRIM(wdetail.pol_addr2) + " " +
                                trim(wdetail.pol_addr3) + " " + TRIM(wdetail.pol_addr4) + " " +
                                trim(wdetail.pol_addr5) .

    IF TRIM(wdetail.CustAddress) <> " " THEN DO:
        DO WHILE INDEX(wdetail.CustAddress,"  ") <> 0 :
            ASSIGN wdetail.CustAddress = REPLACE(wdetail.CustAddress,"  "," ").
        END.
        ASSIGN wdetail.addr1 = ""
               wdetail.addr2 = ""
               wdetail.addr3 = ""
               wdetail.addr4 = ""
               wdetail.addr1 = TRIM(wdetail.CustAddress).
    END.

IF LENGTH(wdetail.addr1) > 35  THEN DO:
    loop_add01:
    DO WHILE LENGTH(wdetail.addr1) > 35 :
        IF r-INDEX(wdetail.addr1," ") <> 0 THEN DO:
            ASSIGN 
                wdetail.addr2  = trim(SUBSTR(wdetail.addr1,r-INDEX(wdetail.addr1," "))) + " " + wdetail.addr2
                wdetail.addr1  = trim(SUBSTR(wdetail.addr1,1,r-INDEX(wdetail.addr1," "))).
        END.
        ELSE LEAVE loop_add01.
    END.
    loop_add02:
    DO WHILE LENGTH(wdetail.addr2) > 35 :
        IF r-INDEX(wdetail.addr2," ") <> 0 THEN DO:
            ASSIGN 
                wdetail.addr3  = trim(SUBSTR(wdetail.addr2,r-INDEX(wdetail.addr2," "))) + " " + wdetail.addr3
                wdetail.addr2  = trim(SUBSTR(wdetail.addr2,1,r-INDEX(wdetail.addr2," "))).
        END.
        ELSE LEAVE loop_add02.
    END.
    loop_add03:
    DO WHILE LENGTH(wdetail.addr3) > 35 :
        IF r-INDEX(wdetail.addr3 ," ") <> 0 THEN DO:
            ASSIGN 
                wdetail.addr4 = trim(SUBSTR(wdetail.addr3,r-INDEX(wdetail.addr3," "))) + " " + wdetail.addr4
                wdetail.addr3 = trim(SUBSTR(wdetail.addr3,1,r-INDEX(wdetail.addr3," "))).
        END.
        ELSE LEAVE loop_add03.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "�բ����š���駧ҹ��Өӹǹ " nv_updatecnt " ��¡�� �зӡ���Ѿഷ����������������� ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "�Ѿഷ����駧ҹ" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH wdetail WHERE wdetail.pass = "N" .
                   ASSIGN  wdetail.engine = REPLACE(wdetail.engine,"*","").
                   IF ( wdetail.chassis = "" ) THEN 
                       MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
                   ELSE DO:
                       /* ------------------------check policy  Duplicate--------------------------------------*/ 
                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
                        brstat.tlt.cha_no  = trim(wdetail.chassis)     AND
                        brstat.tlt.eng_no  = TRIM(wdetail.engine)      AND
                        brstat.tlt.safe2   = TRIM(wdetail.account_no)  AND
                        brstat.tlt.genusr  = fi_compa                  NO-ERROR NO-WAIT .
                       IF AVAIL brstat.tlt THEN DO: 
                           nv_completecnt  =  nv_completecnt + 1.
                           RUN Proc_Create_tlt2.
                           ASSIGN wdetail.pass = "Y" .
                       END.
                   END.  /*wdetail.Notify_no <> "" */
            END. /*if avail wdetail */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    Run proc_Open_tlt.            
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkinspec C-Win 
PROCEDURE proc_chkinspec :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A62-0445 Date 01/10/2019 
------------------------------------------------------------------------------*/
DEF VAR nv_expdat AS CHAR FORMAT "x(15)".
DEF VAR nv_fname  AS CHAR FORMAT "x(50)" .
DEF VAR nv_lname  AS CHAR FORMAT "x(50)".
DO:
    ASSIGN              
        nv_year      = STRING(YEAR(TODAY))
        nv_year      = SUBSTR(nv_year,3,2) 
        /* real database */
        NotesServer  = "Safety_NotesServer/Safety"
        NotesApp     = "safety\uw\inspect" + nv_year + ".nsf"
        /**/
        /* test database 
        NotesServer  = ""
        NotesApp     = "D:\Lotus\Notes\Data\inspect" + nv_year + ".nsf" */

        NotesView    = "chassis_no" /* ��ǫ�͹�ͧ�Ţ��Ƕѧ */ 
        nv_chkdoc    = NO             
        nv_msgbox    = ""
        nv_name      = ""
        nv_datim     = ?
        nv_branch    = ""
        nv_brname    = ""
        nv_pattern   = ""
        nv_count     = 0
        nv_text1     = ""
        nv_text2     = ""
        nv_chktext   = 0
        nv_model     = ""
        nv_modelcode = ""
        nv_makdes    = ""
        nv_licence1  = ""
        nv_licence2  = ""
        nv_provin    = "" 
        nv_key1      = "" 
        nv_key2      = "" 
        nv_key3      = "" 
        nv_fname     = ""
        nv_lname     = ""
        nv_expdat    = ""
        nv_lname     = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(brstat.tlt.ins_name," ") + 1))
        nv_fname     = trim(SUBSTR(brstat.tlt.ins_name,1,LENGTH(brstat.tlt.ins_name) - LENGTH(nv_lname) - 1 ))
        nv_fname     = trim(SUBSTR(nv_fname,R-INDEX(nv_fname," ")))
        nv_expdat    = STRING(brstat.tlt.gendat,"99/99/9999")
        nv_expdat    = SUBSTR(nv_expdat,1,6) + STRING(INT(SUBSTR(nv_expdat,7,4)) + 1) 
        nv_cha_no    = TRIM(brstat.tlt.cha_no).
                                                                                                                                           
    nv_licence1 = trim(brstat.tlt.lince1).
    
    IF TRIM(nv_licence1) = ""
    OR TRIM(nv_cha_no)   = "" THEN DO:
        MESSAGE "����¹ö ���� �Ţ��Ƕѧ �繤����ҧ" SKIP
                "��س��кآ��������ú��ǹ !" 
        VIEW-AS ALERT-BOX ERROR.
        RETURN NO-APPLY.
    END.

    IF TRIM(brstat.tlt.lince3) <> "" THEN DO:
        FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(brstat.tlt.lince3) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN nv_provin = brstat.Insure.LName.
            ELSE ASSIGN nv_provin = TRIM(brstat.tlt.lince3).
    END.
    
    nv_licence2 = trim(nv_licence1) .
    IF trim(nv_licence2) <> "" THEN DO:
       ASSIGN nv_licence2 = REPLACE(nv_licence2," ","").

       IF INDEX("0123456789",SUBSTR(nv_licence2,1,1)) <> 0 THEN DO:
          IF LENGTH(nv_licence2) = 4 THEN 
             ASSIGN nv_Pattern = "yxx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,1).
          ELSE IF LENGTH(nv_licence2) = 5 THEN
              ASSIGN nv_Pattern = "yxx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,2).
          ELSE IF LENGTH(nv_licence2) = 6 THEN DO:
              IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yy-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "yx-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4).
              ELSE 
                  ASSIGN nv_Pattern = "yxx-yyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,3). 
          END.
          ELSE 
              ASSIGN nv_Pattern = "yxx-yyyy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,3) + " " + SUBSTR(nv_licence2,4,4).
       END.
       ELSE DO:
           IF LENGTH(nv_licence2) = 3 THEN 
             ASSIGN nv_Pattern = "xx-y-xx"
                    nv_licence2    = SUBSTR(nv_licence2,1,2) + " "  + SUBSTR(nv_licence2,3,1) .
           ELSE IF LENGTH(nv_licence2) = 4 THEN
              ASSIGN nv_Pattern = "xx-yy-xx"
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,2) .
           ELSE IF LENGTH(nv_licence2) = 6 THEN
              IF INDEX("0123456789",SUBSTR(nv_licence2,3,1)) <> 0 THEN
              ASSIGN nv_Pattern = "xx-yyyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
              ELSE ASSIGN nv_Pattern = "xxx-yyy-xx" 
                     nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,4) .
           ELSE IF LENGTH(nv_licence2) = 5 THEN DO:
               IF INDEX("0123456789",SUBSTR(nv_licence2,2,1)) <> 0 THEN
                  ASSIGN nv_Pattern = "x-yyyy-xx"
                         nv_licence2    = SUBSTR(nv_licence2,1,1) + " " + SUBSTR(nv_licence2,2,4).
               ELSE 
                  ASSIGN nv_Pattern = "xx-yyy-xx" 
                         nv_licence2    = SUBSTR(nv_licence2,1,2) + " " + SUBSTR(nv_licence2,3,3).
           END.
       END.
    END.
    
    CREATE "Notes.NotesSession" chSession.                              
    CREATE "Notes.NotesUIWorkSpace" chWorkSpace.    
    chDatabase = chSession:GetDatabase(NotesServer,NotesApp).    
    
    IF chDatabase:isOpen = NO THEN DO: 
        MESSAGE "Can not open Database !" VIEW-AS ALERT-BOX.
        RETURN NO-APPLY.
    END.
    ELSE DO: 
       chName   = chSession:CreateName(chSession:UserName).        
        nv_name  = chName:Abbreviated.
        nv_datim = STRING(TODAY,"99/99/9999") + " " + STRING(TIME,"HH:MM:SS").
       
        /* nv_brname */
        FIND FIRST sicsyac.xmm600                               
             WHERE sicsyac.xmm600.acno = trim(brstat.tlt.comp_sub)  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600 THEN nv_brname = sicsyac.xmm600.NAME.
        /*----------*/
        
        /* Check Record Duplication */        
        chWorkspace:OpenDatabase(NotesServer,NotesApp,NotesView,"",FALSE,FALSE).
        chView = chDatabase:GetView(NotesView).        

        IF VALID-HANDLE(chView) = NO THEN DO:
            nv_chkdoc = NO.
            nv_msgbox = "Can not Connect View !".
        END.
        ELSE DO:                
            chViewNavigator = chView:CreateViewNavFromCategory(nv_cha_no).            
            nv_doc_num      = chViewNavigator:COUNT.      
                                            
            IF nv_doc_num = 0 THEN DO:                
                nv_chkdoc = YES.
            END.                
            ELSE DO:                                                  
                chViewEntry = chViewNavigator:GetFirstDocument.
                IF VALID-HANDLE(chViewEntry) = NO THEN 
                    nv_chkdoc  = YES.                                                                      
                ELSE chDocument = chViewEntry:Document. 

                loop_chkrecord:
                REPEAT:
                    IF VALID-HANDLE(chDocument) = NO THEN DO:
                        nv_chkdoc = YES.
                        LEAVE loop_chkrecord.
                    END.
                    ELSE DO:                    
                        nv_licen1 = chDocument:GetFirstItem("LicenseNo_1"):TEXT.
                        nv_licen2 = chDocument:GetFirstItem("LicenseNo_2"):TEXT.  
          
                        nv_key1   = nv_licen1 + IF nv_licen2 = "" THEN "" ELSE " " + nv_licen2. /* Notes */
                        nv_key3   = nv_licence1 + " " + nv_provin .          /* PM */

                        IF INDEX(nv_key1," ") <> 0 THEN nv_key1 = REPLACE(nv_key1," ","") .
                        IF INDEX(nv_key3," ") <> 0 THEN nv_key3 = REPLACE(nv_key3," ","") .
                        
                        IF nv_key1 = nv_key3 THEN DO:
                            
                            chitem       = chDocument:Getfirstitem("SurveyClose").    /* �൵�ʻԴ����ͧ */
                            IF chitem <> 0 THEN nv_surcl   = chitem:TEXT. 
                            ELSE nv_surcl  = "".
                           
                            IF nv_surcl = "" THEN DO:                            
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                nv_chkdoc = NO.
                                /*nv_msgbox = "�բ������Ţ��Ƕѧ�Ѻ�Ţ����¹㹡��ͧ �ѧ���Դ����ͧ " + nv_docno .*/
                                LEAVE loop_chkrecord.
                            END.
                            ELSE DO:
                                
                                chitem       = chDocument:Getfirstitem("ConsiderDate").      /*�ѹ���Դ����ͧ*/
                                IF chitem <> 0 THEN nv_date = chitem:TEXT. 
                                ELSE nv_date = "".
                                nv_docno  = chDocument:GetFirstItem("docno"):TEXT.
                                /*nv_msgbox = "�բ������Ţ��Ƕѧ�Ѻ�Ţ����¹㹡��ͧ �Դ����ͧ���� " + nv_docno .*/
                               
                                nv_chkdoc = NO.
                                LEAVE loop_chkrecord.
                            END.
                        END.
                        ELSE DO:
                            chViewEntry = chViewNavigator:GetNextDocument(chViewEntry). 
                            IF VALID-HANDLE(chViewEntry) = NO THEN DO:                 
                                nv_chkdoc = YES.                                       
                                LEAVE loop_chkrecord.                                  
                            END.                                                       
                            ELSE DO:                                                   
                                chDocument = chViewEntry:Document.                     
                                NEXT loop_chkrecord.                                   
                            END. 
                        END.
                    END. /*  else  */
                END. /* end repeate */
            END.  
            /* End Check */
                
            IF nv_chkdoc = NO THEN DO:
                ASSIGN 
                   nv_surdata  = "" 
                   nv_damlist  = "" 
                   nv_damage   = "" 
                   nv_detail   = "" 
                   nv_device   = "" 
                   nv_acctotal = ""
                   nv_damdetail = ""   .
                IF nv_surcl <> "" THEN  RUN PD_getisp.
                IF nv_docno <> ""  THEN DO:
                     ASSIGN 
                     brstat.tlt.rec_addr1  = "ISP:" + trim(nv_docno) + " " +
                                             "RES:" + trim(nv_detail + " " + nv_damage + " " + nv_damlist + " " + nv_damdetail + " " + nv_device) .
                                                   /*+ " " + nv_surdata + " " + nv_device + " " + nv_acctotal*/   /* �ŵ�Ǩ��Ҿ*/
                END.
                /*RELEASE brstat.tlt. */       
                
            END.
           /* ELSE DO:
                
                chDocument = chDatabase:CreateDocument.
                ASSIGN
                    chDocument:FORM        = "Inspection"                        
                    chDocument:createdBy   = nv_name                             
                    chDocument:createdOn   = nv_datim                            
                    chDocument:dateS       = brstat.tlt.gendat                            
                    chDocument:dateE       = nv_expdat                           
                    chDocument:ReqType_sub = "�١���/���᷹/���˹���繼�����ٻ��Ǩ��Ҿ"
                    chDocument:BranchReq   = "Business Unit 3"                           
                    chDocument:Tname       = "�ؤ��"                             
                    chDocument:Fname       = nv_fname                         
                    chDocument:Lname       = nv_lname                        
                    chDocument:phone1      = ""    
                    chDocument:PolicyNo    = ""                          
                    chDocument:agentCode   = trim(brstat.tlt.comp_sub)                         
                    chDocument:agentName   = nv_brname                           
                    chDocument:Premium     = brstat.tlt.comp_coamt                          
                    chDocument:model       = brstat.tlt.model                       
                    chDocument:modelCode   = ""                         
                    chDocument:Year        = brstat.tlt.lince2                            
                    chDocument:carCC       = nv_cha_no                           
                    chDocument:LicenseType = "ö��/��к�/��÷ء"               
                    chDocument:PatternLi1  = nv_pattern                          
                    chDocument:LicenseNo_1 = nv_licence1                       
                    chDocument:LicenseNo_2 = nv_provin 
                    chDocument:garage      = trim(wdetail.garage)
                    chDocument:App         = 0                                   
                    chDocument:Chk         = 0                                   
                    chDocument:StList      = 0                                   
                    chDocument:stHide      = 0                                   
                    chDocument:SendTo      = ""                                  
                    chDocument:SendCC      = ""                                  
                    chDocument:SendClose   = ""
                    chDocument:SurveyClose = ""                    
                    chDocument:docno       = "".       
            
                /*chDocument:SAVE(TRUE,FALSE).*/ 
                chDocument:SAVE(TRUE,TRUE).  
                chWorkSpace:ViewRefresh.  
                chUIDocument = chWorkSpace:CurrentDocument.                                         
                chUIDocument = chWorkSpace:EditDocument(FALSE,chDocument) NO-ERROR.
            END.  */                                      
        END.
    END.

    RELEASE OBJECT chSession       NO-ERROR.
    RELEASE OBJECT chWorkSpace     NO-ERROR.
    RELEASE OBJECT chName          NO-ERROR.
    RELEASE OBJECT chDatabase      NO-ERROR.
    RELEASE OBJECT chView          NO-ERROR.
    RELEASE OBJECT chViewEntry     NO-ERROR.    
    RELEASE OBJECT chViewNavigator NO-ERROR.
    RELEASE OBJECT chDocument      NO-ERROR.
    RELEASE OBJECT chUIDocument    NO-ERROR.    
    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chksuspect C-Win 
PROCEDURE proc_chksuspect :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A62-0445      
------------------------------------------------------------------------------*/
DEF VAR n_name AS CHAR FORMAT "x(150)" .
DO:
    ASSIGN nv_susupect = "" 
           n_name = TRIM(wdetail.pol_fname).

    IF index(n_name," ") <> 0 THEN DO: 
        ASSIGN  wdetail.pol_lname = trim(SUBSTR(n_name,R-INDEX(n_name," ") + 1))   
                n_name            = trim(SUBSTR(n_name,1,LENGTH(n_name) - LENGTH(wdetail.pol_lname)))  
                wdetail.pol_fname = trim(SUBSTR(n_name,R-INDEX(n_name," ") + 1))  
                wdetail.pol_title = trim(SUBSTR(n_name,1,INDEX(n_name," ") - 1)) . 
    END.
    
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03 WHERE trim(uzsusp.fname)   = trim(wdetail.pol_fname) AND 
                                                    trim(uzsusp.lname)   = trim(wdetail.pol_lname) AND
                                                    (TRIM(uzsusp.suscod) = "25"   OR                        /* �Դ ���. */
                                                    TRIM(uzsusp.suscod)  = "26" ) NO-LOCK NO-ERROR NO-WAIT. /* �Դ ���. */
            IF AVAIL sicuw.uzsusp THEN DO:
                ASSIGN  nv_susupect = trim(uzsusp.fname) + " " + trim(uzsusp.lname) + " Pol:" + trim(uzsusp.text1) + " " + " Code:" + trim(uzsusp.suscod) + " Remark:" + trim(uzsusp.note) .
            END.                            
            ELSE DO:
                FIND LAST sicuw.uzsusp USE-INDEX uzsusp03 WHERE trim(uzsusp.fname) = trim(wdetail.pol_fname) AND
                                                                trim(uzsusp.lname) = trim(wdetail.pol_lname) AND
                                                                (INDEX(uzsusp.text2,"V70") <> 0   OR
                                                                INDEX(uzsusp.text2,"V72")  <> 0   OR 
                                                                INDEX(uzsusp.text2,"All")  <> 0 ) NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sicuw.uzsusp THEN DO:
                                ASSIGN  nv_susupect = trim(uzsusp.fname) + " " + trim(uzsusp.lname) + " Pol:" + trim(uzsusp.text1) + " " + " Code:" + trim(uzsusp.suscod) + " Remark:" + trim(uzsusp.note) .
                            END.
            END.

    IF wdetail.chassis <> "" AND nv_susupect = "" THEN DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp05 WHERE uzsusp.cha_no = trim(wdetail.chassis) AND TRIM(uzsusp.text2) <> ""  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uzsusp THEN DO:
                ASSIGN  nv_susupect = trim(uzsusp.fname) + " " + trim(uzsusp.lname) + " Pol:" + trim(uzsusp.text1) + " " + " Code:" + trim(uzsusp.suscod) + " Remark:" + trim(uzsusp.note) .

            END.
    END.

    ASSIGN wdetail.pol_fname = trim(wdetail.pol_title) + " " + trim(wdetail.pol_fname) + " " + TRIM(wdetail.pol_lname).
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt C-Win 
PROCEDURE proc_create_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
    IF wdetail.account_no = ""  THEN DELETE wdetail.  /*a61-0234*/
    ELSE DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
        IF wdetail.chassis = "" AND rs_type = 1 THEN 
            MESSAGE "�Ţ��Ƕѧ�繤����ҧ..." VIEW-AS ALERT-BOX.
        ELSE DO:
            RUN proc_cutchassic.
            RUN proc_cutchar.
            RUN proc_cutpol.
           
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.
            /*IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat = STRING(SUBSTR(wdetail.comdat,1,6) + STRING(INT(SUBSTR(wdetail.comdat,7,4)) + 544 )) .
            ELSE ASSIGN nv_expdat  = ?.*/
            IF (wdetail.comdat72 <>  ""  AND index(wdetail.comdat72,"�ú") = 0 ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72).
            ELSE ASSIGN nv_comdat72 = ?.
        
            IF (wdetail.regisdate <> "")  THEN ASSIGN nv_accdat = DATE(wdetail.regisdate).
            ELSE ASSIGN nv_accdat = ?.
           /* --------------------------------------------- INS_AMT  CHR(11) �ع��Сѹö¹�� --- */
            IF INDEX(wdetail.si,"�") <> 0 THEN nv_insamt3 = 0.
            ELSE nv_insamt3 = DECIMAL(wdetail.si).   
             
            RUN proc_address.
            RUN proc_chksuspect . 
            IF rs_type = 2  THEN DO:
                FIND LAST brstat.tlt WHERE brstat.tlt.safe2  = TRIM(wdetail.account_no) AND
                          index(wdetail.RegisNo,brstat.tlt.lince1) <> 0 AND
                          brstat.tlt.ins_name    =  trim(wdetail.pol_fname) NO-ERROR NO-WAIT.
                IF NOT AVAIL brstat.tlt THEN DO:
                    CREATE brstat.tlt.
                        nv_completecnt  =  nv_completecnt + 1.
                        ASSIGN                                                 
                            brstat.tlt.entdat       =   TODAY                            /* �ѹ�����Ŵ */                          
                            brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")          /* ������Ŵ   */                          
                            brstat.tlt.trndat       =   fi_loaddat                       /* �ѹ���ҡ˹�Ҩ�*/
                            brstat.tlt.safe2        =   caps(trim(wdetail.Account_no))   /*�Ţ����ѭ��   */ 
                            brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)            /*�����       */ 
                            brstat.tlt.comp_usr_tlt =   IF trim(wdetail.typins) = "5" THEN "2.2" ELSE TRIM(wdetail.typins) /*����������������ͧ   */          
                            brstat.tlt.gendat       =   nv_comdat                        /*�ѹ��������������ͧ  */
                            brstat.tlt.ins_name     =   trim(wdetail.pol_fname)          /*���ͼ����һ�Сѹ��� */           
                            brstat.tlt.ins_addr5    =   trim(wdetail.icno)        /*IDCARD              */  
                            brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*�Ţ����¹ */ 
                            brstat.tlt.stat         =   trim(wdetail.garage)              /*ʶҹ������ */ 
                            brstat.tlt.nor_coamt    =   nv_insamt3                        /*�ع��Сѹ   */    
                                       
                            brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*������� ��.  */ 
                            brstat.tlt.comp_grprm   =   IF Wdetail.comp_prmtotal <> "-" AND Wdetail.comp_prmtotal <> "" 
                                                        THEN DECI(Wdetail.comp_prmtotal)  ELSE 0     /*������� �ú. */  
                            brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*����������*/ 
                            brstat.tlt.flag         =   "R"  /* �������ҹ N = �ҹ���� R = ������� */ 
                            brstat.tlt.genusr       =   "SCBRE"                                                     
                            brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
                            brstat.tlt.imp          =   IF tg_tmsth = NO THEN "ORA" ELSE "EMP"        /*owner Data type*/                          
                            brstat.tlt.releas       =   "No"                                      
                            brstat.tlt.comp_sub     =   TRIM(cb_producer)      
                            brstat.tlt.comp_noti_ins =  TRIM(fi_agent) 
                            brstat.tlt.nor_noti_ins =   "" /*TRIM(trim(wdetail.safe_no))  */       /*�������� */            
                            brstat.tlt.comp_pol     =   "" /*trim(wdetail.compno)         */       /*���� �ú.  */  
                            brstat.tlt.dat_ins_noti =   ?                                /*�ѹ����͡�ҹ */
                            brstat.tlt.expotim      =  nv_susupect .   /* suspect */
                END.
                ELSE DO:
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                            brstat.tlt.entdat       =   TODAY                            /* �ѹ�����Ŵ */                          
                            brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")          /* ������Ŵ   */                          
                            brstat.tlt.trndat       =   fi_loaddat                       /* �ѹ���ҡ˹�Ҩ�*/
                            brstat.tlt.safe2        =   caps(trim(wdetail.Account_no))   /*�Ţ����ѭ��   */ 
                            brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)            /*�����       */ 
                            brstat.tlt.comp_usr_tlt =   IF trim(wdetail.typins) = "5" THEN "2.2" ELSE TRIM(wdetail.typins)  /*����������������ͧ   */          
                            brstat.tlt.gendat       =   nv_comdat                        /*�ѹ��������������ͧ  */
                            brstat.tlt.ins_name     =   trim(wdetail.pol_fname)          /*���ͼ����һ�Сѹ��� */           
                            brstat.tlt.ins_addr5    =   trim(wdetail.icno)        /*IDCARD              */  
                            brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*�Ţ����¹ */ 
                            brstat.tlt.stat         =   trim(wdetail.garage)              /*ʶҹ������ */ 
                            brstat.tlt.nor_coamt    =   nv_insamt3                        /*�ع��Сѹ   */    
                                       
                            brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*������� ��.  */ 
                            brstat.tlt.comp_grprm   =   IF Wdetail.comp_prmtotal <> "-" AND Wdetail.comp_prmtotal <> "" 
                                                        THEN DECI(Wdetail.comp_prmtotal)  ELSE 0     /*������� �ú. */  
                            brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*����������*/ 
                            brstat.tlt.flag         =   "R"  /* �������ҹ N = �ҹ���� R = ������� */  
                            brstat.tlt.genusr       =   "SCBRE"                                                     
                            brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
                            brstat.tlt.imp          =   IF tg_tmsth = NO THEN "ORA" ELSE "EMP"        /*owner Data type*/                            
                            brstat.tlt.releas       =   "No"                                      
                            brstat.tlt.comp_sub     =   TRIM(cb_producer)      
                            brstat.tlt.comp_noti_ins =  TRIM(fi_agent) 
                            brstat.tlt.nor_noti_ins =   "" /*TRIM(trim(wdetail.safe_no))  */       /*�������� */            
                            brstat.tlt.comp_pol     =   "" /*trim(wdetail.compno)         */       /*���� �ú.  */  
                            brstat.tlt.dat_ins_noti =   ?                                /*�ѹ����͡�ҹ */
                            brstat.tlt.expotim      =  nv_susupect .   /* suspect */
                END.
            END.
            ELSE DO:
                FIND LAST brstat.tlt WHERE brstat.tlt.safe2  = TRIM(wdetail.account_no) AND
                          index(brstat.tlt.lince1,wdetail.RegisNo) <> 0 AND
                          brstat.tlt.ins_name    =  trim(wdetail.pol_fname) NO-ERROR NO-WAIT.
                IF NOT AVAIL brstat.tlt THEN DO:
                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
                        brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                        brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                        brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
                    IF NOT AVAIL brstat.tlt THEN DO:
                       CREATE brstat.tlt.
                            nv_completecnt  =  nv_completecnt + 1.
                            ASSIGN                                                 
                                brstat.tlt.entdat       =   TODAY                            /* �ѹ�����Ŵ */                          
                                brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")          /* ������Ŵ   */                          
                                brstat.tlt.trndat       =   fi_loaddat                       /* �ѹ���ҡ˹�Ҩ�*/
                                brstat.tlt.datesent     =   nv_accdat                        /* �ѹ�������駧ҹ */
                                brstat.tlt.trntim       =   TRIM(wdetail.not_time)           /* �����駧ҹ*/
                                brstat.tlt.safe2        =   caps(trim(wdetail.Account_no))   /*�Ţ����ѭ��   */ 
                                brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)            /*�����       */
                                brstat.tlt.colorcod     =   TRIM(wdetail.CovTyp)             /*������ö��Сѹ*/ 
                                brstat.tlt.old_cha      =   TRIM(wdetail.cartyp )            /* ������ö */
                                brstat.tlt.comp_usr_tlt =   IF trim(wdetail.typins) = "5" THEN "2.2" ELSE TRIM(wdetail.typins)   /*����������������ͧ   */ 
                                brstat.tlt.old_eng      =   TRIM(wdetail.weigth)             /* �ú . ��/����� */
                                brstat.tlt.gendat       =   nv_comdat                        /*�ѹ��������������ͧ  */ 
                                brstat.tlt.ins_name     =   trim(wdetail.pol_fname)          /*���ͼ����һ�Сѹ��� */           
                                brstat.tlt.ins_addr5    =   trim(wdetail.icno)               /*IDCARD              */
                                brstat.tlt.nor_usr_tlt  =   TRIM(wdetail.company)            /* ���ͺ���ѷ */
                                brstat.tlt.ins_addr1    =   trim(wdetail.pol_addr1)          /*��������١��� */          
                                brstat.tlt.ins_addr2    =   trim(wdetail.pol_addr2)          
                                brstat.tlt.ins_addr3    =   trim(wdetail.pol_addr3)                        
                                brstat.tlt.ins_addr4    =   trim(wdetail.pol_addr4)  + " " + trim(wdetail.pol_addr5) 
                                brstat.tlt.endno        =   TRIM(wdetail.drivno)           /* �кؼ��Ѻ��� */
                                brstat.tlt.dri_no1      =   TRIM(wdetail.drivid1)          
                                brstat.tlt.model        =   trim(wdetail.Brand_Model)      /*���        */
                                brstat.tlt.eng_no       =   trim(wdetail.engine)           /*�Ţ����ͧ  */          
                                brstat.tlt.cha_no       =   trim(wdetail.chassis)          /*�Ţ�ѧ      */ 
                                brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)            /*��Ҵ����ͧ */  
                                brstat.tlt.lince2       =   trim(wdetail.yrmanu)           /*��          */ 
                                brstat.tlt.lince1       =   trim(wdetail.RegisNo)          /*�Ţ����¹ */          
                                brstat.tlt.lince3       =   trim(wdetail.RegisProv)        /*�ѧ��Ѵ    */ 
                                brstat.tlt.stat         =   trim(wdetail.garage)           /*ʶҹ������ */ 
                                brstat.tlt.nor_coamt    =   nv_insamt3                     /*�ع��Сѹ   */     
                        
                                brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)        /*������� ��.  */ 
                                brstat.tlt.comp_effdat  =   nv_comdat72                    
                                brstat.tlt.comp_grprm   =   IF INDEX(Wdetail.comdat72,"���") = 0  THEN DECI(Wdetail.comp_prmtotal)  ELSE 0     /*������� �ú. */  
                                brstat.tlt.comp_sck     =   TRIM(wdetail.stk)                /* ʵ������ */  
                                brstat.tlt.rec_addr5    =   "NCB:" + TRIM(wdetail.ncbper) +  /* ncb */
                                                            " DD:" + TRIM(wdetail.DD)        /*Deduct */ 
                                brstat.tlt.safe1        =   TRIM(wdetail.accsor)             /*�ػ�ó쵡��*/ 
                                brstat.tlt.filler2      =   trim(wdetail.remark)             
                                brstat.tlt.filler1      =   TRIM(wdetail.prevpol)            /*����������*/ 
                                brstat.tlt.lotno        =   TRIM(wdetail.sts)    /* status */
                                brstat.tlt.flag         =   "R"  /* �������ҹ N = �ҹ���� R = ������� */  
                                brstat.tlt.genusr       =   "SCBRE"                         
                                brstat.tlt.usrid        =   USERID(LDBNAME(1))              /*User Load Data */                      
                                brstat.tlt.imp          =   IF tg_tmsth = NO THEN "ORA" ELSE "EMP"        /*owner Data type*/                           
                                brstat.tlt.releas       =   "No"                                      
                                brstat.tlt.comp_sub     =   TRIM(cb_producer)      
                                brstat.tlt.comp_noti_ins =  TRIM(fi_agent) 
                                brstat.tlt.dri_name1    =   ""   /*  ���ͼ��Ѻ��� 1 */
                                brstat.tlt.dri_name2    =   ""   /*  ���ͼ��Ѻ��� 2 */ 
                                brstat.tlt.dri_no2      =   ""   /* �Ţ㺢Ѻ��� 2 */
                                brstat.tlt.rec_addr1    =   "ISP: RES: "   /* isp no */
                                /*brstat.tlt.rec_addr2  =   "BEN: CAM: "   /* ����Ѻ�Ż���ª��  + ��໭ */*/
                                brstat.tlt.rec_addr2    =  IF wdetail.sts = "Active" THEN "BEN:��Ҥ���¾ҳԪ�� �ӡѴ(��Ҫ�) CAM:" 
                                                           ELSE "BEN: CAM:"
                                brstat.tlt.rec_addr3    =   ""   /* User ID �����䢢����� */
                                brstat.tlt.nor_noti_ins =   ""   /*�������� */            
                                brstat.tlt.comp_pol     =   ""   /*���� �ú.  */  
                                brstat.tlt.dat_ins_noti =   ?    /*�ѹ����͡�ҹ */
                                brstat.tlt.expotim      =  nv_susupect .   /* suspect */
                              
                    END.
                    ELSE DO:
                        nv_updatecnt = nv_updatecnt + 1 .
                        ASSIGN wdetail.pass = "N".
                       /* nv_completecnt  =  nv_completecnt + 1.                      
                        RUN proc_Create_tlt2.*/
                    END.
                END.
                ELSE DO:
                    nv_updatecnt = nv_updatecnt + 1 .
                    ASSIGN wdetail.pass = "N".
                    /*nv_completecnt  =  nv_completecnt + 1.                      
                    RUN proc_Create_tlt2.*/
                END.
                RUN proc_chkinspec.
            END.
        END.
    END.
END.
IF nv_updatecnt <> 0 THEN RUN proc_chkdata.
Run proc_Open_tlt.                           
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt-bp C-Win 
PROCEDURE proc_create_tlt-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR n AS INT INIT 0.
LOOP_wdetail:
FOR EACH wdetail .
   /*IF  wdetail.Account_no = "" THEN  DELETE wdetail. */ /*a61-0234*/
    IF wdetail.account_no = "" /*AND deci(wdetail.comp_prm) = 0*/ THEN DELETE wdetail.  /*a61-0234*/
    ELSE DO:
    ASSIGN   
            nv_policy    = ""   nv_oldpol    = ""
            nv_comdat    = ?    nv_expdat    = ?  
            nv_comdat72  = ?    nv_expdat72  = ?    nv_accdat  =  ?
            nv_comchr  = ""     nv_addr    = ""     nv_name1   =  ""     
            nv_ntitle  = ""     nv_titleno = 0      nv_policy  =  ""
            nv_dd      = 0      nv_mm      = 0      nv_yy      =  0
            nv_cpamt1  = 0      nv_cpamt2  = 0      nv_cpamt3  =  0
            nv_coamt1  = 0      nv_coamt2  = 0      nv_coamt3  =  0         
            nv_insamt1 = 0      nv_insamt2 = 0      nv_insamt3 =  0
            nv_premt1  = 0      nv_premt2  = 0      nv_premt3  =  0
            nv_newpol  = ""     nv_reccnt  = nv_reccnt + 1
            wdetail.engine = REPLACE(wdetail.engine,"*","").
        IF LENGTH(trim(wdetail.remark)) > 85  THEN RUN proc_cutremak.    /* A56-0399 */
        ELSE ASSIGN nn_remark1  = trim(wdetail.remark)
            nn_remark2  = ""
            nn_remark3 = "".
        IF wdetail.safe_no = "" THEN 
            MESSAGE "���Ţ�Ѻ���繤����ҧ..." VIEW-AS ALERT-BOX.
        ELSE DO:
            RUN proc_cutchassic.
            RUN proc_cutchar.
            RUN proc_cutpol.
            /* ------------------------check policy  Duplicate--------------------------------------*/ 
            IF (wdetail.comdat <>  "" ) THEN ASSIGN nv_comdat  = DATE(wdetail.comdat).
            ELSE ASSIGN nv_comdat = ?.

            IF (wdetail.expdat <>  "" ) THEN ASSIGN nv_expdat  = DATE(wdetail.expdat).
            ELSE ASSIGN nv_expdat  = ?.
        
            IF (wdetail.regisdate <> "")  THEN ASSIGN nv_accdat = DATE(wdetail.regisdate).
            ELSE ASSIGN nv_accdat = ?.

          /* IF (wdetail.comdat72 <>  "" ) THEN ASSIGN nv_comdat72  = DATE(wdetail.comdat72). 
            ELSE ASSIGN nv_comdat72 = ?.
            IF (wdetail.expdat72 <>  "" ) THEN ASSIGN nv_expdat72  = DATE(wdetail.expdat72).
            ELSE ASSIGN nv_expdat72 = ?.*/
           /* --------------------------------------------- INS_AMT  CHR(11) �ع��Сѹö¹�� --- */
            IF INDEX(wdetail.si,"�") <> 0 THEN nv_insamt3 = 0.
            ELSE nv_insamt3 = DECIMAL(wdetail.si).   
            /* -------------------------- PREM1 CHR(11)   �����Ҥ��Ѥ�㨺ǡ���պǡ�ҡ� --- */
            /*nv_premt1 = DECIMAL(SUBSTRING(wdetail.netprem,1,9)).
            IF nv_premt1 < 0 THEN
                nv_premt2 = (DECIMAL(SUBSTRING(wdetail.netprem,10,2)) * -1) / 100.
            ELSE
                nv_premt2 = DECIMAL(SUBSTRING(wdetail.netprem,10,2)) / 100.
            nv_premt3 = nv_premt1 + nv_premt2.
            /* --------------------------------------------- COMP_PEM CHR(09)  ���¾ú.��� --- */
            nv_cpamt3 = DECIMAL(wdetail.comp_prm) .  
            /* -------------------------- GROSS_PRM CHR(11)   ��������Ҥ��Ѥ�㨺ǡ������� �ú. --- */
            nv_coamt1 = DECIMAL(SUBSTRING(wdetail.totalprem,1,9)).
            IF nv_coamt1 < 0 THEN
                nv_coamt2 = (DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) * -1) / 100.
            ELSE
                nv_coamt2 = DECIMAL(SUBSTRING(wdetail.totalprem,10,2)) / 100.
            nv_coamt3 = nv_coamt1 + nv_coamt2.
           /*---------------------------------------------------------------------------------------*/*/
            RUN proc_address.
            IF TRIM(wdetail.name_insur) <> " " THEN DO:
                ASSIGN n = 0
                       wdetail.name_insur = TRIM(wdetail.name_insur).
                       IF INDEX(wdetail.name_insur,"���") <> 0 THEN
                           ASSIGN wdetail.pol_title = "���"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"���","")).
                       ELSE IF INDEX(wdetail.name_insur,"�ҧ���") <> 0 THEN
                           ASSIGN wdetail.pol_title = "�ҧ���"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"�ҧ���","")).
                       ELSE IF INDEX(wdetail.name_insur,"�ҧ") <> 0 THEN
                           ASSIGN wdetail.pol_title = "�ҧ"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"�ҧ","")).
                       ELSE IF INDEX(wdetail.name_insur,"�.�.") <> 0 THEN
                           ASSIGN wdetail.pol_title = "�.�."
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"�.�.","")).
                       ELSE IF INDEX(wdetail.name_insur,"�س") <> 0 THEN
                           ASSIGN wdetail.pol_title = "�س"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"�س","")).
                       ELSE IF INDEX(wdetail.name_insur,"����ѷ") <> 0 THEN
                           ASSIGN wdetail.pol_title = "����ѷ"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"����ѷ","")).
                       ELSE IF INDEX(wdetail.name_insur,"���.") <> 0 THEN
                           ASSIGN wdetail.pol_title = "���."
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"���.","")).
                       ELSE IF INDEX(wdetail.name_insur,"��ҧ�����ǹ") <> 0 THEN
                           ASSIGN wdetail.pol_title = "��ҧ�����ǹ"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"��ҧ�����ǹ","")).
                       ELSE IF INDEX(wdetail.name_insur,"˨�.") <> 0 THEN
                           ASSIGN wdetail.pol_title = "˨�."
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"˨�.","")).
                       ELSE IF INDEX(wdetail.name_insur,"��ŹԸ�") <> 0 THEN
                           ASSIGN wdetail.pol_title = "��ŹԸ�"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"��ŹԸ�","")).
                       ELSE IF INDEX(wdetail.name_insur,"�ç���¹") <> 0 THEN
                           ASSIGN wdetail.pol_title = "�ç���¹"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"�ç���¹","")).
                       ELSE IF INDEX(wdetail.name_insur,"�ç��Һ��") <> 0 THEN
                           ASSIGN wdetail.pol_title = "�ç��Һ��"
                                  wdetail.pol_fname = trim(REPLACE(wdetail.name_insur,"�ç��Һ��","")).
                       ELSE ASSIGN wdetail.pol_title = ""
                                  wdetail.pol_fname = trim(wdetail.name_insur).
            END.
           /* comment by Ranu : A61-0221...........
            IF trim(wdetail.Brand_Model) <> ""  THEN DO:
                IF INDEX(wdetail.brand_model," ") <> 0  THEN 
                    ASSIGN wdetail.brand       = trim(SUBSTR(wdetail.brand_model,1,INDEX(wdetail.brand_model," ")))
                           wdetail.brand_model = TRIM(SUBSTR(wdetail.brand_model,INDEX(wdetail.brand_model," "),LENGTH(wdetail.brand_model))).
                ELSE 
                    ASSIGN wdetail.brand       = TRIM(wdetail.brand_model)
                           wdetail.brand_model = "".
            END.*/

            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail.chassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail.engine)    AND
                brstat.tlt.genusr       = fi_compa                NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
               CREATE brstat.tlt.
                    nv_completecnt  =  nv_completecnt + 1.
                    ASSIGN                                                 
                        brstat.tlt.entdat       =   TODAY                             /* �ѹ�����Ŵ */                          
                        brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")           /* ������Ŵ   */                          
                        brstat.tlt.trndat       =   fi_loaddat                        /* �ѹ���ҡ˹�Ҩ�*/
                        brstat.tlt.datesent     =   nv_accdat                         /* �ѹ�������駧ҹ */
                        brstat.tlt.trntim       =   TRIM(wdetail.not_time)            /* �����駧ҹ*/
                        brstat.tlt.exp          =   "M"                               /*�Ң�                 */           
                        brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)             /*�Ţ����Ѻ��        */           
                        brstat.tlt.safe2        =   trim(wdetail.Account_no)          /*�Ţ����ѭ��          */           
                        brstat.tlt.rec_name     =   trim(wdetail.pol_title)           /*�ӹ�˹�Ҫ��ͼ����һ�Сѹ��� */          
                        brstat.tlt.ins_name     =   trim(wdetail.pol_fname)           /*���ͼ����һ�Сѹ��� */           
                        brstat.tlt.ins_addr5    =   trim(wdetail.icno)                /*IDCARD              */           
                        brstat.tlt.stat         =   trim(wdetail.garage)              /*ʶҹ������         */           
                        brstat.tlt.colorcod     =   TRIM(wdetail.n_color)             /*��ö            */           
                        brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"  /* �������ҹ N = �ҹ���� R = ������� */   
                        brstat.tlt.brand        =   trim(wdetail.brand)               /*������      */          
                        brstat.tlt.model        =   trim(wdetail.Brand_Model)         /*���        */          
                        brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)               /*��Ҵ����ͧ */          
                        brstat.tlt.lince2       =   trim(wdetail.yrmanu)              /*��          */          
                        brstat.tlt.eng_no       =   trim(wdetail.engine)              /*�Ţ����ͧ  */          
                        brstat.tlt.cha_no       =   trim(wdetail.chassis)             /*�Ţ�ѧ      */          
                        brstat.tlt.old_cha      =   TRIM(wdetail.accsor) +            /*�ػ�ó쵡�� */ 
                                                    " PRICE:" +  TRIM(wdetail.accsor_price)   /*�Ҥ��ػ�ó쵡�� */ 
                        brstat.tlt.comp_usr_tlt =   trim(wdetail.CovTyp)            /*��������Сѹ    */
                        brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*�Ţ����¹ */          
                        brstat.tlt.lince3       =   trim(wdetail.RegisProv)           /*�ѧ��Ѵ    */          
                        brstat.tlt.safe3        =   ""                                /*pack + class70 */  
                        brstat.tlt.expousr      =   trim(wdetail.instyp)              /* ��Сѹ��/�����*/ 
                        brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)              /* �ú . ��/����� */
                        brstat.tlt.nor_coamt    =   nv_insamt3                        /*�ع��Сѹ   */          
                        brstat.tlt.nor_usr_tlt  =   "TAX:" + TRIM(wdetail.Taxno) +    /*�Ţ������������� */ 
                                                    " ID:"  + TRIM(wdetail.saleid) +  /*�Ţ����¹��ä��*/
                                                    " BR:"  + TRIM(wdetail.branch)    
                        brstat.tlt.gendat       =   nv_comdat                         /*�ѹ��������������ͧ  */          
                        brstat.tlt.expodat      =   nv_expdat                         /*�ѹ�������ش������ͧ*/          
                        brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)             /*�����ط��*/              
                        brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*�������  */  
                        brstat.tlt.safe1        =   TRIM(wdetail.ben_name) + " Delear:" + trim(wdetail.DealerName) /*��������    */ 
                        brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)               /*�����           */          
                        brstat.tlt.comp_sck     =   ""                                  
                        /*brstat.tlt.comp_effdat  = nv_comdat72                         /*�ѹ�������������ͧ�ú */     
                        brstat.tlt.nor_effdat   = nv_expdat72                           /*�ѹ�������ش������ͧ�ú   */ */
                        brstat.tlt.rec_addr4    =   string(DECI(wdetail.comp_prm))      /*�����ط�Ծú. */ 
                        brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)         /*��������ú. */ 
                        brstat.tlt.filler2      =   trim(wdetail.remark)                /*�����˵�    */        
                        brstat.tlt.ins_addr1    =   trim(wdetail.addr1)                 /*��������١��� */          
                        brstat.tlt.ins_addr2    =   trim(wdetail.addr2)                        
                        brstat.tlt.ins_addr3    =   trim(wdetail.addr3)                        
                        brstat.tlt.ins_addr4    =   trim(wdetail.addr4)                 
                        brstat.tlt.rec_addr3    =   TRIM(wdetail.inspect)               /*��Ǩ��Ҿ*/
                        brstat.tlt.genusr       =   "ORICO"                                                     
                        brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
                        brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
                        brstat.tlt.releas       =   "No"                                                         
                        brstat.tlt.recac        =   ""                                  /* �Ҫվ */                                                                      
                        brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0M0130" ELSE "A0M0129"               
                        brstat.tlt.comp_noti_ins =  "B300303"                 
                        brstat.tlt.rec_addr1     =  IF INDEX(wdetail.taxname,"������") <> 0 THEN "MC38462" ELSE "" /* vat code */
                        brstat.tlt.rec_addr2    =   trim(wdetail.taxname)               /* Recepit name */
                        brstat.tlt.rec_addr5    =   TRIM(Wdetail.pol_addr1)             /*��������͡����� */ 
                        brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) + " ID1:" + TRIM(wdetail.drivid1)                             
                        brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)                             
                        brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) + " ID2:" + TRIM(wdetail.drivid2)                            
                        brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)
                        brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*����������*/
                        brstat.tlt.nor_noti_ins =   TRIM(trim(wdetail.safe_no))         /*�������� */            
                        brstat.tlt.comp_pol     =   trim(wdetail.compno)                /*���� �ú.  */  
                        brstat.tlt.dat_ins_noti =   ?                                   /*�ѹ����͡�ҹ */
                        brstat.tlt.lotno        =   IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                                    ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                                    ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                                    ELSE "".             /*��໭*/
            END.                      
            ELSE DO:                  
                nv_completecnt  =  nv_completecnt + 1.
                RUN proc_Create_tlt2.
            END.
        END.
    END.
END.
Run proc_Open_tlt.     */                      
                            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt2 C-Win 
PROCEDURE proc_create_tlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:   
      ASSIGN                            
             brstat.tlt.entdat       =   TODAY                            /* �ѹ�����Ŵ */                          
             brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")          /* ������Ŵ   */                          
             brstat.tlt.trndat       =   fi_loaddat                       /* �ѹ���ҡ˹�Ҩ�*/
             brstat.tlt.datesent     =   nv_accdat                        /* �ѹ�������駧ҹ */
             brstat.tlt.trntim       =   TRIM(wdetail.not_time)           /* �����駧ҹ*/
             brstat.tlt.safe2        =   caps(trim(wdetail.Account_no))   /*�Ţ����ѭ��   */ 
             brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)            /*�����       */
             brstat.tlt.colorcod     =   TRIM(wdetail.CovTyp)             /*������ö��Сѹ*/ 
             brstat.tlt.old_cha      =   TRIM(wdetail.cartyp )            /* ������ö */
             brstat.tlt.comp_usr_tlt =   IF trim(wdetail.typins) = "5" THEN "2.2" ELSE TRIM(wdetail.typins)    /*����������������ͧ   */ 
             brstat.tlt.old_eng      =   TRIM(wdetail.weigth)             /* �ú . ��/����� */
             brstat.tlt.gendat       =   nv_comdat                        /*�ѹ��������������ͧ  */ 
             brstat.tlt.ins_name     =   trim(wdetail.pol_fname)          /*���ͼ����һ�Сѹ��� */           
             brstat.tlt.ins_addr5    =   trim(wdetail.icno)               /*IDCARD              */
             brstat.tlt.nor_usr_tlt  =   TRIM(wdetail.company)            /* ���ͺ���ѷ */
             brstat.tlt.ins_addr1    =   trim(wdetail.pol_addr1)          /*��������١��� */          
             brstat.tlt.ins_addr2    =   trim(wdetail.pol_addr2)          
             brstat.tlt.ins_addr3    =   trim(wdetail.pol_addr3)                        
             brstat.tlt.ins_addr4    =   trim(wdetail.pol_addr4)  + " " + trim(wdetail.pol_addr5) 
             brstat.tlt.endno        =   TRIM(wdetail.drivno)           /* �кؼ��Ѻ��� */
             brstat.tlt.dri_no1      =   TRIM(wdetail.drivid1)          
             brstat.tlt.model        =   trim(wdetail.Brand_Model)      /*���        */
             brstat.tlt.eng_no       =   trim(wdetail.engine)           /*�Ţ����ͧ  */          
             brstat.tlt.cha_no       =   trim(wdetail.chassis)          /*�Ţ�ѧ      */ 
             brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)            /*��Ҵ����ͧ */  
             brstat.tlt.lince2       =   trim(wdetail.yrmanu)           /*��          */ 
             brstat.tlt.lince1       =   trim(wdetail.RegisNo)          /*�Ţ����¹ */          
             brstat.tlt.lince3       =   trim(wdetail.RegisProv)        /*�ѧ��Ѵ    */ 
             brstat.tlt.stat         =   trim(wdetail.garage)           /*ʶҹ������ */ 
             brstat.tlt.nor_coamt    =   nv_insamt3                     /*�ع��Сѹ   */     
   
             brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)        /*������� ��.  */ 
             brstat.tlt.comp_effdat  =   nv_comdat72                    
             brstat.tlt.comp_grprm   =   IF INDEX(Wdetail.comdat72,"���") = 0  THEN DECI(Wdetail.comp_prmtotal)  ELSE 0     /*������� �ú. */  
             brstat.tlt.comp_sck     =   TRIM(wdetail.stk)                /* ʵ������ */  
             brstat.tlt.rec_addr5    =   "NCB:" + TRIM(wdetail.ncbper) +  /* ncb */
                                       " DD:" + TRIM(wdetail.DD)        /*Deduct */ 
             brstat.tlt.safe1        =   TRIM(wdetail.accsor)             /*�ػ�ó쵡��*/ 
             brstat.tlt.filler2      =   trim(wdetail.remark)             
             brstat.tlt.filler1      =   TRIM(wdetail.prevpol)            /*����������*/ 
             brstat.tlt.lotno        =   TRIM(wdetail.sts)    /* status */
             brstat.tlt.flag         =   "R"  /* �������ҹ N = �ҹ���� R = ������� */  
             brstat.tlt.genusr       =   "SCBRE"                         
             brstat.tlt.usrid        =   USERID(LDBNAME(1))              /*User Load Data */                      
             brstat.tlt.imp          =   IF tg_tmsth = NO THEN "ORA" ELSE "EMP"        /*owner Data type*/                            
             brstat.tlt.releas       =   "No"                                      
             brstat.tlt.comp_sub     =   TRIM(cb_producer)      
             brstat.tlt.comp_noti_ins =  TRIM(fi_agent) 
             brstat.tlt.dri_name1    =   ""   /*  ���ͼ��Ѻ��� 1 */
             brstat.tlt.dri_name2    =   ""   /*  ���ͼ��Ѻ��� 2 */ 
             brstat.tlt.dri_no2      =   ""   /* �Ţ㺢Ѻ��� 2 */
             brstat.tlt.rec_addr1    =   "ISP: RES: "   /* isp no + �ŵ�Ǩ��Ҿ */  
             /*brstat.tlt.rec_addr2    =   "BEN: CAM: "   /* ����Ѻ�Ż���ª��  + ��໭ */*/
             brstat.tlt.rec_addr2    =  IF wdetail.sts = "Active" THEN "BEN:��Ҥ���¾ҳԪ�� �ӡѴ(��Ҫ�) CAM:" 
                                        ELSE "BEN: CAM:"
             brstat.tlt.rec_addr3    =   ""   /* User ID �����䢢����� */
             brstat.tlt.nor_noti_ins =   ""   /*�������� */            
             brstat.tlt.comp_pol     =   ""   /*���� �ú.  */  
             brstat.tlt.dat_ins_noti =   ?    /*�ѹ����͡�ҹ */
             brstat.tlt.expotim      =  nv_susupect .   /* suspect */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create_tlt2-bp C-Win 
PROCEDURE proc_create_tlt2-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    ASSIGN                                   
          brstat.tlt.entdat       =   TODAY                             /* �ѹ�����Ŵ */                          
          brstat.tlt.enttim       =   STRING(TIME,"HH:MM:SS")           /* ������Ŵ   */                          
          brstat.tlt.trndat       =   fi_loaddat                        /* �ѹ���ҡ˹�Ҩ�*/
          brstat.tlt.datesent     =   nv_accdat                         /* �ѹ�������駧ҹ */
          brstat.tlt.trntim       =   TRIM(wdetail.not_time)            /* �����駧ҹ*/
          brstat.tlt.exp          =   "M"                               /*�Ң�                 */           
          brstat.tlt.nor_noti_tlt =   trim(wdetail.safe_no)             /*�Ţ����Ѻ��        */           
          brstat.tlt.safe2        =   trim(wdetail.Account_no)          /*�Ţ����ѭ��          */           
          brstat.tlt.rec_name     =   trim(wdetail.pol_title)           /*�ӹ�˹�Ҫ��ͼ����һ�Сѹ��� */          
          brstat.tlt.ins_name     =   trim(wdetail.pol_fname)           /*���ͼ����һ�Сѹ��� */           
          brstat.tlt.ins_addr5    =   trim(wdetail.icno)                /*IDCARD              */           
          brstat.tlt.stat         =   trim(wdetail.garage)              /*ʶҹ������         */           
          brstat.tlt.colorcod     =   TRIM(wdetail.n_color)             /*��ö            */           
          brstat.tlt.flag         =   IF rs_type = 1 THEN "N" ELSE "R"  /* �������ҹ N = �ҹ���� R = ������� */   
          brstat.tlt.brand        =   trim(wdetail.brand)               /*������      */          
          brstat.tlt.model        =   trim(wdetail.Brand_Model)         /*���        */          
          brstat.tlt.cc_weight    =   INTEGER(wdetail.cc)               /*��Ҵ����ͧ */          
          brstat.tlt.lince2       =   trim(wdetail.yrmanu)              /*��          */          
          brstat.tlt.eng_no       =   trim(wdetail.engine)              /*�Ţ����ͧ  */          
          brstat.tlt.cha_no       =   trim(wdetail.chassis)             /*�Ţ�ѧ      */          
          brstat.tlt.old_cha      =   TRIM(wdetail.accsor) +            /*�ػ�ó쵡�� */ 
                                      " PRICE:" +  TRIM(wdetail.accsor_price)   /*�Ҥ��ػ�ó쵡�� */ 
          brstat.tlt.comp_usr_tlt =   trim(wdetail.CovTyp)            /*��������Сѹ    */
          brstat.tlt.lince1       =   trim(wdetail.RegisNo)             /*�Ţ����¹ */          
          brstat.tlt.lince3       =   trim(wdetail.RegisProv)           /*�ѧ��Ѵ    */          
          brstat.tlt.safe3        =   ""                                /*pack + class70 */  
          brstat.tlt.expousr      =   trim(wdetail.instyp)              /* ��Сѹ��/�����*/  
          brstat.tlt.old_eng      =   TRIM(wdetail.comtyp)              /* �ú . ��/����� */
          brstat.tlt.nor_coamt    =   nv_insamt3                        /*�ع��Сѹ   */          
          brstat.tlt.nor_usr_tlt  =   "TAX:" + TRIM(wdetail.Taxno) +    /*�Ţ������������� */ 
                                      " ID:"  + TRIM(wdetail.saleid) +  /*�Ţ����¹��ä��*/
                                      " BR:"  + TRIM(wdetail.branch)    
          brstat.tlt.gendat       =   nv_comdat                         /*�ѹ��������������ͧ  */          
          brstat.tlt.expodat      =   nv_expdat                         /*�ѹ�������ش������ͧ*/          
          brstat.tlt.nor_grprm    =   DECI(wdetail.netprem)             /*�����ط��*/              
          brstat.tlt.comp_coamt   =   DECI(wdetail.totalprem)           /*�������  */  
          brstat.tlt.safe1        =   TRIM(wdetail.ben_name) + " Delear:" + trim(wdetail.DealerName) /*��������    */ 
          brstat.tlt.nor_usr_ins  =   trim(wdetail.CMRName)               /*�����           */          
          brstat.tlt.comp_sck     =   ""                                  
          /*brstat.tlt.comp_effdat  = nv_comdat72                         /*�ѹ�������������ͧ�ú */     
          brstat.tlt.nor_effdat   = nv_expdat72                           /*�ѹ�������ش������ͧ�ú   */ */
          brstat.tlt.rec_addr4    =   string(DECI(wdetail.comp_prm))      /*�����ط�Ծú. */ 
          brstat.tlt.comp_grprm   =   DECI(Wdetail.comp_prmtotal)         /*��������ú. */ 
          brstat.tlt.filler2      =   trim(wdetail.remark)                /*�����˵�    */        
          brstat.tlt.ins_addr1    =   trim(wdetail.addr1)                 /*��������١��� */          
          brstat.tlt.ins_addr2    =   trim(wdetail.addr2)                        
          brstat.tlt.ins_addr3    =   trim(wdetail.addr3)                        
          brstat.tlt.ins_addr4    =   trim(wdetail.addr4)                 
          brstat.tlt.rec_addr3    =   TRIM(wdetail.inspect)               /*��Ǩ��Ҿ*/
          brstat.tlt.genusr       =   "ORICO"                                                     
          brstat.tlt.usrid        =   USERID(LDBNAME(1))                  /*User Load Data */                      
          brstat.tlt.imp          =   "IM"                                /*Import Data*/                          
          brstat.tlt.releas       =   "No"                                                         
          brstat.tlt.recac        =   ""                                   /* �Ҫվ */                                                                    
          brstat.tlt.comp_sub     =   IF rs_type = 1 THEN "A0M0130" ELSE "A0M0129"               
          brstat.tlt.comp_noti_ins =  "B300303"                 
          brstat.tlt.rec_addr1     =  IF INDEX(wdetail.taxname,"������") <> 0 THEN "MC38462" ELSE "" /* vat code */
          brstat.tlt.rec_addr2    =   trim(wdetail.taxname)               /* Recepit name */
          brstat.tlt.rec_addr5    =   TRIM(Wdetail.pol_addr1)             /*��������͡����� */ 
          brstat.tlt.dri_name1    =   TRIM(wdetail.drivname1) + " ID1:" + TRIM(wdetail.drivid1)                             
          brstat.tlt.dri_no1      =   TRIM(wdetail.drivdate1)                             
          brstat.tlt.dri_name2    =   TRIM(wdetail.drivname2) + " ID2:" + TRIM(wdetail.drivid2)                            
          brstat.tlt.dri_no2      =   TRIM(wdetail.drivdate2)
          brstat.tlt.filler1      =   TRIM(wdetail.prevpol)               /*����������*/
          brstat.tlt.nor_noti_ins =   TRIM(trim(wdetail.safe_no))         /*�������� */            
          brstat.tlt.comp_pol     =   trim(wdetail.compno)                /*���� �ú.  */  
          brstat.tlt.dat_ins_noti =   ?                                   /*�ѹ����͡�ҹ */
           brstat.tlt.lotno        =  IF index(wdetail.CovTyp,"1") <> 0 THEN TRIM(fi_camp) 
                                      ELSE IF INDEX(wdetail.covtyp,"2+") <> 0 THEN TRIM(fi_camp2) 
                                      ELSE IF INDEX(wdetail.covtyp,"3+") <> 0 THEN TRIM(fi_camp3)
                                      ELSE "".             /*��໭*/
END.                      
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchar C-Win 
PROCEDURE proc_cutchar :
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
nv_c = wdetail.prevpol.
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
ASSIGN
    wdetail.prevpol = nv_c .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutchassic C-Win 
PROCEDURE proc_cutchassic :
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
IF wdetail.chassis <> "" THEN DO:
    nv_c = wdetail.chassis.
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
    ASSIGN
        wdetail.chassis = nv_c .
    IF trim(wdetail.chassis) <> "" THEN DO:  
         FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail.chassis)) AND 
                                                          sicuw.uwm301.tariff = "X" NO-LOCK  NO-ERROR NO-WAIT.
              IF AVAIL sicuw.uwm301 THEN DO:
                  ASSIGN wdetail.prevpol   = sicuw.uwm301.policy .
              END.
     END.
    RELEASE sicuw.uwm301.
END.

IF wdetail.engine <> ""  THEN DO:
    nv_c = wdetail.engine.
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
    ASSIGN
        wdetail.engine = nv_c .
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpol C-Win 
PROCEDURE proc_cutpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
IF wdetail.safe_no <> ""  THEN DO:  /* 70*/
    nv_c = wdetail.safe_no.
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
    ASSIGN
        wdetail.safe_no = nv_c .
END.

IF wdetail.compno <> ""  THEN DO:  /*72*/
    nv_c = wdetail.compno.
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
    ASSIGN
        wdetail.compno = nv_c .

END.*/



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutremak C-Win 
PROCEDURE proc_cutremak :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*wdetail.remark*/ 
ASSIGN  nn_remark1 = ""
        nn_remark2 = ""
        nn_remark3 = "".
IF      R-INDEX(wdetail.remark,"/����ѷ") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/����ѷ"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/����ѷ") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 85 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,86 )) 
            nn_remark2 = trim(substr(nn_remark2,1,85)).
    END.
END.
ELSE IF      R-INDEX(wdetail.remark,"/���") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/���"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/���") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE IF      R-INDEX(wdetail.remark,"/��ҧ") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark,"/��ҧ"))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark,"/��ҧ") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".
    IF LENGTH(nn_remark1) > 110 THEN DO:
        IF R-INDEX(nn_remark1," ") <> 0  THEN
            ASSIGN  
            nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
        ELSE ASSIGN 
            nn_remark2 = trim(substr(nn_remark1,110 )) + " " + nn_remark2
            nn_remark1 = trim(substr(nn_remark1,1,110)).
    END.
    IF LENGTH(nn_remark2) > 110 THEN DO:
        IF R-INDEX(nn_remark2," ") <> 0  THEN
            ASSIGN  
            nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," ")))
            nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
        ELSE ASSIGN 
            nn_remark3 = trim(substr(nn_remark2,111 )) 
            nn_remark2 = trim(substr(nn_remark2,1,110)).
    END.
END.
ELSE DO:
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail.remark,R-INDEX(wdetail.remark," "))) 
        nn_remark1 = trim(SUBSTR(wdetail.remark,1,R-INDEX(wdetail.remark," ") - 1 )) .
    IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
        ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
               nn_remark2 = "".  
    loop_chk0:
    REPEAT:
        IF LENGTH(nn_remark1) > 110 THEN DO:
            IF R-INDEX(nn_remark1," ") <> 0  THEN
                ASSIGN  
                nn_remark2 = trim(substr(nn_remark1,R-INDEX(nn_remark1," "))) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,R-INDEX(nn_remark1," "))).
            ELSE ASSIGN 
                nn_remark2 = trim(substr(nn_remark1,111)) + " " + nn_remark2
                nn_remark1 = trim(substr(nn_remark1,1,110)) .
        END.
        ELSE IF LENGTH(nn_remark2) > 85 THEN DO:
            IF R-INDEX(nn_remark2," ") <> 0  THEN
                ASSIGN  
                nn_remark3 = trim(substr(nn_remark2,R-INDEX(nn_remark2," "))) 
                nn_remark2 = trim(substr(nn_remark2,1,R-INDEX(nn_remark2," "))).
            ELSE ASSIGN 
                nn_remark3 = trim(substr(nn_remark2,86)) 
                nn_remark2 = trim(substr(nn_remark2,1,85)).
        END.
        ELSE LEAVE loop_chk0.
    END.
END.
loop_chk1:
REPEAT:
    IF INDEX(nn_remark1,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark1).
        nn_remark1 = SUBSTRING(nn_remark1,1,INDEX(nn_remark1,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark1,INDEX(nn_remark1,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nn_remark2,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark2).
        nn_remark2 = SUBSTRING(nn_remark2,1,INDEX(nn_remark2,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark2,INDEX(nn_remark2,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nn_remark3,"  ") <> 0 THEN DO:
        nv_len = LENGTH(nn_remark3).
        nn_remark3 = SUBSTRING(nn_remark3,1,INDEX(nn_remark3,"  ") - 2 ) + " " +
            trim(SUBSTRING(nn_remark3,INDEX(nn_remark3,"  "), nv_len )) .
    END.
    ELSE LEAVE loop_chk3.
END.
IF LENGTH(nn_remark2 + " " + nn_remark3 ) <= 85 THEN 
    ASSIGN nn_remark2 = nn_remark2 + " " + nn_remark3  
           nn_remark3 = "".
IF LENGTH(nn_remark1 + " " + nn_remark2) <= 110 THEN 
    ASSIGN nn_remark1 = nn_remark1 + " " + nn_remark2
           nn_remark2 = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Open_tlt C-Win 
PROCEDURE proc_Open_tlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
For each brstat.tlt  Use-index tlt01         where
         brstat.tlt.trndat   =  fi_loaddat   and
         brstat.tlt.genusr   =  fi_compa     NO-LOCK .
    CREATE wtlt.
    ASSIGN 
       wtlt.trndat      =   STRING(tlt.trndat,"99/99/9999")    
      /* wtlt.Notify_no   =   tlt.nor_noti_tlt
       wtlt.branch      =   tlt.exp     */
       wtlt.Account_no  =   tlt.safe2   
       wtlt.prev_pol    =   tlt.filler1 
       wtlt.name_insur  =   tlt.ins_name
       wtlt.comdat      =   IF tlt.gendat       <> ? THEN string(tlt.gendat,"99/99/9999")       ELSE ""    
       wtlt.comdat72    =   IF tlt.comp_effdat  <> ? THEN string(tlt.comp_effdat,"99/99/9999")  ELSE ""
       wtlt.licence     =   tlt.lince1 
       wtlt.province    =   tlt.lince3 
       wtlt.ins_amt     =   string(tlt.nor_coamt) 
       wtlt.prem1       =   string(tlt.comp_coamt) 
       wtlt.comp_prm    =   string(tlt.comp_grprm)
       /*wtlt.gross_prm   =   STRING(tlt.comp_grprm)*/
       /*wtlt.compno      =   tlt.comp_pol */ 
       /*wtlt.not_date    =   STRING(tlt.datesent)   
       wtlt.not_office  =   tlt.nor_noti_tlt
       wtlt.not_name    =   tlt.nor_usr_ins
       wtlt.brand       =   tlt.brand  */    
       wtlt.Brand_Model =   tlt.model      
       wtlt.yrmanu      =   tlt.lince2   
       wtlt.weight      =   STRING(tlt.cc_weight)  
       wtlt.engine      =   tlt.eng_no    
       wtlt.chassis     =   tlt.cha_no 
       wtlt.camp        =   tlt.genusr.
END.
OPEN QUERY br_imptxt FOR EACH wtlt NO-LOCK.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

