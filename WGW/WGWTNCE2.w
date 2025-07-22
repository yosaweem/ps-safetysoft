&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*Program name : Match Text File Confirm (THANACHAT)                       */
/*create by    : Ranu i. A59-0316   ����� match file ������ظ��ҵ        */
/*               Match file confirm , match policy , match file cancel         */
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */
/*---------------------------------------------------------------------------*/
/*Modify by   : Ranu i. A59-0471   �Դ Procedured match policy ��䢵�����͡��  */
/*              Match file confirm , match file cancel , match No Confirm  */  
/*Modify By   : Ranu I. A60-0383 date. 05/09/2017 ��������礢����Ž�����͹ ��д֧������
                Class ��л����������ҹ �ҡ����������                     */
/*Modify by : Ranu I. A60-0545 Date: 20/12/2017
            : ����¹ format File �駧ҹ����ᴧ    */    
/*Modify by : Ranu I. a61-0512 date 02/11/2018 
            : ����¹����������͹����� �������������������Ŵ ������ŧ�������� */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/* Modify by: Ranu I. A64-0205 ����Ң� ��������ҹ������� TM */
/* Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 Add color */
/*-------------------------------------------------------------------------*/
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO.  /* A60-0383 */
DEF VAR n_user  AS CHAR FORMAT "X(12)" NO-UNDO.  /* A60-0383 */
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO.  /* A60-0383 */
DEF  stream ns1.
DEFINE VAR  nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR  nv_reccnt      AS  INT  INIT  0.
DEFINE VAR  nv_completecnt AS   INT   INIT  0.
DEFINE VAR  nv_enttim      AS  CHAR          INIT  "".
DEFINE VAR  nv_export      as  date  init  ""  format "99/99/9999".
DEF stream  ns2.
DEFINE VAR nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
{ wgw\wgwtnce2.i }
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    FIELD Pro_off       AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����Ѻ������Ң�  */           
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*�Ţ����Ѻ��         */           
    FIELD branch        AS CHAR FORMAT "X(4)"   INIT ""   /*�Ң�                  */           
    FIELD Account_no    AS CHAR FORMAT "X(12)"  INIT ""   /*�Ţ����ѭ��           */           
    FIELD prev_pol      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ�������������    */           
    FIELD company       AS CHAR FORMAT "X(50)"  INIT ""   /*����ѷ��Сѹ���      */           
    FIELD name_insur    AS CHAR FORMAT "X(100)" INIT ""   /*���ͼ����һ�Сѹ���   */           
    FIELD ben_name      AS CHAR FORMAT "X(50)"  INIT ""   /*����Ѻ�Ż���ª��      */           
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
    FIELD sckno         AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���ʵ������      */           
    FIELD not_code      AS CHAR FORMAT "X(75)"  INIT ""   /*���ʼ����           */           
    FIELD remark        AS CHAR FORMAT "X(225)" INIT ""   /*�����˵�              */           
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ����Ѻ��         */           
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""   /*���ͻ�Сѹ���         */           
    FIELD not_name      AS CHAR FORMAT "X(50)"  INIT ""   /*�����               */           
    FIELD brand         AS CHAR FORMAT "X(15)"  INIT ""   /*������                */           
    FIELD Brand_Model   AS CHAR FORMAT "X(35)"  INIT ""   /*���                  */           
    FIELD yrmanu        AS CHAR FORMAT "X(10)"  INIT ""   /*��                    */           
    FIELD weight        AS CHAR FORMAT "X(10)"  INIT ""   /*��Ҵ����ͧ           */           
    FIELD engine        AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����ͧ            */           
    FIELD chassis       AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ�ѧ                */           
    FIELD pattern       AS CHAR FORMAT "X(75)"  INIT ""   /*Pattern Rate          */           
    FIELD covcod        AS CHAR FORMAT "X(3)"   INIT ""   /*��������Сѹ          */           
    FIELD vehuse        AS CHAR FORMAT "X(50)"  INIT ""   /*������ö              */           
    FIELD garage        AS CHAR FORMAT "X(30)"  INIT ""   /*ʶҹ������           */ 
    FIELD drivename1    AS CHAR FORMAT "X(50)"  INIT ""   /*�кؼ��Ѻ���1        */           
    FIELD driveid1      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���㺢Ѻ���1       */           
    FIELD driveic1      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���ѵû�ЪҪ�1    */           
    FIELD drivedate1    AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ��͹���Դ1       */           
    FIELD drivname2     AS CHAR FORMAT "X(50)"  INIT ""   /*�кؼ��Ѻ���2        */           
    FIELD driveid2      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���㺢Ѻ���2       */           
    FIELD driveic2      AS CHAR FORMAT "X(15)"  INIT ""   /*�Ţ���ѵû�ЪҪ�2    */           
    FIELD drivedate2    AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ��͹���Դ2       */           
    FIELD cl            AS CHAR FORMAT "X(15)"  INIT ""   /*��ǹŴ����ѵ�����     */           
    FIELD fleetper      AS CHAR FORMAT "X(15)"  INIT ""   /*��ǹŴ�����           */           
    FIELD ncbper        AS CHAR FORMAT "X(15)"  INIT ""   /*����ѵԴ�             */           
    FIELD othper        AS CHAR FORMAT "x(15)"  INIT ""   /*��� �                */           
    FIELD pol_addr1     as char format "x(150)" init ""   /*��������١���         */           
    FIELD icno          as char format "x(13)"  init ""   /*IDCARD                */           
    FIELD icno_st       as char format "x(15)"  init ""   /*DateCARD_S            */           
    FIELD icno_ex       as char format "x(15)"  init ""   /*DateCARD_E            */           
    FIELD paid          as char format "x(50)"  init ""   /*Type_Paid_1           */ 
    FIELD drivename     AS CHAR FORMAT "X"      INIT ""   /*�кؼ��Ѻ���        */
    FIELD name2         AS CHAR FORMAT "X(50)" INIT ""   /*���ͼ����һ�Сѹ���   */
    field comp          as char format "x(2)"   init ""
    field age1          as char format "x(2)"   init ""
    field age2          as char format "x(2)"   init ""
    field Prempa        as char format "x(2)"   init ""
    field class         as char format "x(4)"   init ""
    field Redbook       as char format "x(10)"  init ""
    field opnpol        as char format "x(20)"  init ""
    field bandet        as char format "x(50)"  init ""
    field branch_safe   as char format "x(2)"  init ""
    field vatcode       as char format "x(10)"  init ""
    FIELD pol70         AS CHAR FORMAT "x(15)" INIT ""
    FIELD policy        AS CHAR FORMAT "X(15)"  INIT ""
    FIELD addr1         as char format "x(35)"  init ""                                        
    FIELD addr2         as char format "x(35)"  init ""
    FIELD addr3         as char format "x(35)"  init ""
    FIELD addr4         as char format "x(35)"  init ""
    FIELD pol_title     as char format "x(15)"  init ""
    FIELD pol_fname     as char format "x(50)"  init ""
    FIELD pol_lname     as char format "x(50)"  init ""
    FIELD not_time      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD pol_type      as char format "x(5)"  init ""
    FIELD agent         AS char format "x(10)"  init ""
    FIELD producer      AS CHAR FORMAT "x(10)"  INIT ""
    FIELD finit_code    AS CHAR FORMAT "X(10)"   INIT ""
    FIELD CODE_rebate   AS CHAR FORMAT "x(15)" INIT ""
    field ton           as char format "x(5)" init ""
    field Seat          as char format "x(2)" init ""
    field Body          as char format "x(15)" init ""
    field Vehgrp        as char format "x(2)" init ""
    field comment       as char format "X(30)"  INIT ""
    field pass          as char format "X(2)" INIT "" 
    FIELD campaign      AS CHAR FORMAT "x(20)" INIT ""  
    FIELD ispno         AS CHAR FORMAT "x(20)" INIT ""  /*A61-0512*/ 
    FIELD typ_paid      AS CHAR FORMAT "X(25)" INIT ""  /*A61-0512*/ 
    FIELD paid_date     AS CHAR FORMAT "x(15)" INIT ""  /*A61-0512*/ 
    FIELD conf_date     AS CHAR FORMAT "X(15)" INIT ""   /*A61-0512*/ 
    FIELD ncolor        as char format "x(50)"  init ""  /*A66-0160*/
    FIELD ACCESSORY     as char format "x(250)"  init "". /*A66-0160*/
/* comment by A61-0512 .....
DEFINE NEW SHARED TEMP-TABLE wrec NO-UNDO
    FIELD not_date      AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ����Ѻ��           */
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""    /*�Ţ����Ѻ��           */
    FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""    /*�Ң� � �Ţ����ѭ�� */  
    FIELD not_office    AS CHAR FORMAT "X(35)"  INIT ""    /*���ͻ�Сѹ���         *//*���ͼ����һ�Сѹ���*/    
    FIELD ctype         AS CHAR FORMAT "X(15)"  INIT ""    /*��Ѥ��/�ú.            */
    FIELD comdat        AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ��������������ͧ*/      
    FIELD expdat        AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ�������ش           */
    FIELD prem          AS CHAR FORMAT "X(15)"  INIT ""    /*������»�Сѹ������*/     
    FIELD paydate       AS CHAR FORMAT "X(15)"  INIT ""    /*�ѹ����١��Ҫ������¤����ش����*/
    FIELD prevpol       AS CHAR FORMAT "x(15)"  INIT ""    /*A60-0383*/
    FIELD loss          AS CHAR FORMAT "x(10)"  INIT ""    /*A60-0383*/
    FIELD remark        AS CHAR FORMAT "X(15)"  INIT "" .
    .. end A61-0512.....*/
DEFINE NEW SHARED TEMP-TABLE wcancel NO-UNDO
    FIELD n_no          AS CHAR FORMAT "x(3)" INIT ""     /* �ӴѺ��� */            /*A60-0383*/
    FIELD Notify_end     AS CHAR FORMAT "X(18)"  INIT ""  /* �Ţ�����ѡ��ѧ    */                   
    FIELD Notify_no     AS CHAR FORMAT "X(18)"  INIT ""   /*�Ţ����Ѻ��      */                   
    FIELD enddate       AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ������ѡ��ѧ   */ 
    FIELD notidate      AS CHAR FORMAT "x(15)" INIT ""    /*�ѹ����駧ҹ */          /*A60-0383*/  
    FIELD pol_no        AS CHAR FORMAT "X(20)"  INIT ""   /*�Ţ����������/�ú.*/                   
    FIELD licence       AS CHAR FORMAT "X(11)"  INIT ""   /*����¹            */                   
    FIELD province      AS CHAR FORMAT "X(30)"  INIT ""   /*�ѧ��Ѵ            */                   
    FIELD Account_no    AS CHAR FORMAT "X(20)"  INIT ""   /*�Ң�-�Ţ������   */                   
    FIELD ins_name      AS CHAR FORMAT "X(35)"  INIT ""   /*���ͼ����һ�Сѹ   */                   
    FIELD typ_end       AS CHAR FORMAT "X(15)"  INIT ""   /*��Ǣ�ͷ�����     */                   
    FIELD ctype         AS CHAR FORMAT "X(15)"  INIT ""   /*��������ѡ��ѧ     */                   
    FIELD olddata       AS CHAR FORMAT "X(30)"  INIT ""   /*���������         */                   
    FIELD newdata       AS CHAR FORMAT "X(30)"  INIT ""   /*����������         */                   
    FIELD remark_main   AS CHAR FORMAT "X(50)"  INIT ""   /*�˵ؼ���ѡ         */                   
    FIELD remark_sub    AS CHAR FORMAT "X(50)"  INIT ""   /*�˵ؼ�����         */                   
    FIELD payby         AS CHAR FORMAT "X(15)"  INIT ""   /*������            */                   
    FIELD nbank         AS CHAR FORMAT "X(15)"  INIT ""   /*��Ҥ��             */                   
    FIELD paydate       AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ����١����Ѻ�������¤����ش����*/  
    FIELD remark        AS CHAR FORMAT "X(50)"  INIT ""   /*�����˵�           */                   
    FIELD cust_date     AS CHAR FORMAT "X(15)"  INIT ""   /*�ѹ����Ѻ��������  */ 
    FIELD datastatus    AS CHAR FORMAT "X(15)"  INIT "".
 DEF VAR  ID_NO1        AS CHAR FORMAT "x(15)"  INIT "" /*A57-0262*/ .
DEF VAR  CLIENT_BRANCH AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ .
DEFINE TEMP-TABLE wdetail3 NO-UNDO
    FIELD policyid      AS CHAR FORMAT "x(30)" INIT ""
    FIELD poltyp        AS CHAR FORMAT "x(3)" INIT ""
    FIELD ID_NO1        AS CHAR FORMAT "x(15)"  INIT "" /*A57-0262*/  
    FIELD CLIENT_BRANCH AS CHAR FORMAT "x(30)"  INIT "" /*A57-0262*/ .
DEFINE TEMP-TABLE wdetail2 NO-UNDO
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
    FIELD npid72br     AS CHAR FORMAT "x(20)" INIT ""     .    /*A57-0262*/
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
/*------------------------------�����ż��Ѻ��� -------------------------*/
DEFINE WORKFILE  wdriver NO-UNDO
FIELD RecordID     AS CHAR FORMAT "X(02)"    INIT ""            /*1 Detail Record "D"*/
FIELD Pro_off      AS CHAR FORMAT "X(02)"    INIT ""            /*2 �����Ңҷ������һ�Сѹ�Դ�ѭ��    */
FIELD chassis      AS CHAR FORMAT "X(25)"    INIT ""            /*3 �����Ţ��Ƕѧ    */
FIELD dri_no       AS CHAR FORMAT "X(02)"    INIT ""            /*4 �ӴѺ��褹�Ѻ  */
FIELD dri_name     AS CHAR FORMAT "X(40)"    INIT ""            /*5 ���ͤ��Ѻ   */
FIELD Birthdate    AS CHAR FORMAT "X(8)"     INIT ""            /*6 �ѹ��͹���Դ  */
FIELD occupn       AS CHAR FORMAT "X(75)"    INIT ""            /*7 �Ҫվ*/
FIELD position     AS CHAR FORMAT "X(40)"    INIT ""  .         /*8 ���˹觧ҹ */
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
DEF VAR nv_type     AS CHAR FORMAT "x(5)" INIT "".
DEF VAR nv_name     AS CHAR FORMAT "x(70)" INIT "".
def var nv_index    as char format "x(3)" init "".
def var n_addr5     as char format "x(100)" init "".
def var n_length    as INT  init 0.
def var n_exp       as char format "x(15)" init "".
def var n_com       as char format "x(15)" init "".
def var n_ic        as char format "x(15)" init "".
DEF VAR nv_oldpol  AS CHAR FORMAT "x(15)" INIT "".
DEF VAR nv_output   AS CHAR FORMAT "x(60)" INIT "".
DEF VAR nv_access  AS CHAR format "x(500)" init "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_matchpol fi_loadname fi_outload bu_file-3 ~
bu_ok bu_exit-2 fi_outload2 fi_outload3 fi_para fi_date RECT-381 RECT-382 ~
RECT-383 RECT-384 
&Scoped-Define DISPLAYED-OBJECTS ra_matchpol fi_loadname fi_outload ~
fi_outload2 fi_outload3 fi_para fi_date 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit-2 
     LABEL "Exit" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file-3 
     LABEL "..." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_date AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loadname AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload2 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_outload3 AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_para AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_matchpol AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Match File Confirm Receipt ", 1,
"Match File Cancel ", 2,
"Match File No Confirm ", 3
     SIZE 95.5 BY 1
     BGCOLOR 14 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 12.38
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
     SIZE 98.5 BY 1.43
     BGCOLOR 14 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_matchpol AT ROW 4.05 COL 6.33 NO-LABEL
     fi_loadname AT ROW 8.19 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_outload AT ROW 9.33 COL 29.5 COLON-ALIGNED NO-LABEL
     bu_file-3 AT ROW 8.24 COL 92.5
     bu_ok AT ROW 13.33 COL 66.33
     bu_exit-2 AT ROW 13.33 COL 76.5
     fi_outload2 AT ROW 10.43 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_outload3 AT ROW 11.52 COL 29.5 COLON-ALIGNED NO-LABEL
     fi_para AT ROW 5.67 COL 29.67 COLON-ALIGNED NO-LABEL
     fi_date AT ROW 7.1 COL 29.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "OUTPUT FILE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 9.29 COL 14.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "OUTPUT FILE ERROR :" VIEW-AS TEXT
          SIZE 24 BY 1 AT ROW 11.48 COL 7
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "IMPORT FILE :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 8.19 COL 15.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "OUTPUT FILE LOAD :" VIEW-AS TEXT
          SIZE 21.67 BY 1 AT ROW 10.38 COL 8.67
          BGCOLOR 8 FGCOLOR 2 FONT 6
     " MATCH FILE CONFIRM  AND POLICY (THANACHAT) RENEW" VIEW-AS TEXT
          SIZE 105 BY 2.14 AT ROW 1.1 COL 1.17
          BGCOLOR 10 FGCOLOR 4 FONT 2
     "PARAMETER TYPE :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 5.62 COL 10
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "** ��������������Ż�����ö ���� ��л����������ҹ**" VIEW-AS TEXT
          SIZE 49 BY 1 AT ROW 5.62 COL 51.83
          BGCOLOR 8 FGCOLOR 0 FONT 1
     "MATCH DATE :" VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 7.05 COL 15 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 2 FONT 6
     RECT-381 AT ROW 3.38 COL 1
     RECT-382 AT ROW 12.91 COL 75.17
     RECT-383 AT ROW 12.91 COL 65.17
     RECT-384 AT ROW 3.81 COL 4.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 105.5 BY 14.76
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
         TITLE              = "Match text  File Confirm Recepit (THANACHAT)"
         HEIGHT             = 14.76
         WIDTH              = 105.5
         MAX-HEIGHT         = 29.81
         MAX-WIDTH          = 123.67
         VIRTUAL-HEIGHT     = 29.81
         VIRTUAL-WIDTH      = 123.67
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
ASSIGN 
       bu_file-3:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match text  File Confirm Recepit (THANACHAT) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match text  File Confirm Recepit (THANACHAT) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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


&Scoped-define SELF-NAME bu_file-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-3 C-Win
ON CHOOSE OF bu_file-3 IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE no_add        AS CHARACTER NO-UNDO.
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
        no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        fi_loadname  = cvData.
        nv_output = "".
        IF ra_matchpol = 1 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_receipt" + NO_add
                                       fi_outload2  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Load" + NO_add
                                       fi_outload3  = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Error" + NO_add.
        ELSE IF ra_matchpol = 2 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_Cancel" + NO_add.
        ELSE IF ra_matchpol = 3 THEN ASSIGN fi_outload   = SUBSTR(fi_loadname,1,R-INDEX(fi_loadname,".") - 1 ) + "_NoConfirm" + NO_add.
        DISP fi_loadname fi_outload fi_outload2 fi_outload3  WITH FRAME fr_main .     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    For each  wrec:
        DELETE  wrec.
    END.
    For each  wcancel:
        DELETE  wcancel.
    END.
    IF fi_outload = "" THEN DO:
        MESSAGE "File name output not Empty..!!!" SKIP
            "Insert file name Output file...!!!"      VIEW-AS ALERT-BOX.
        APPLY "Entry" TO fi_outload.
        RETURN NO-APPLY.
    END.
    IF ra_matchpol = 1 THEN RUN proc_impmatpol1.      /* �������Թ */
   /* ELSE IF ra_matchpol = 2  THEN RUN proc_impmatpol2.   /* �������� */
    ELSE IF ra_matchpol = 3  THEN RUN proc_impmatpol3.   /* ���cancel */*/
    ELSE IF ra_matchpol = 2  THEN RUN proc_impmatpol3.   /*���cancel */
    ELSE IF ra_matchpol = 3  THEN RUN proc_impmatpol4.   /*���No confirm */
    IF CONNECTED("sic_exp") THEN  DISCONNECT sic_exp. 
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_date
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_date C-Win
ON LEAVE OF fi_date IN FRAME fr_main
DO:
   fi_date = INPUT fi_date.
   DISP fi_date WITH FRAM fr_main.
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


&Scoped-define SELF-NAME fi_outload2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload2 C-Win
ON LEAVE OF fi_outload2 IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outload3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outload3 C-Win
ON LEAVE OF fi_outload3 IN FRAME fr_main
DO:
  fi_outload = INPUT fi_outload.
  DISP fi_outload WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_para
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_para C-Win
ON LEAVE OF fi_para IN FRAME fr_main
DO:
  fi_para = INPUT fi_para.
  DISP fi_para WITH FRAM fr_main.
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
      /*ra_matpoltyp      = 1*/
      fi_date           = TODAY     /*A61-0512*/
      gv_prgid          = "WGWTNCE2"
      fi_para           = "TNC_TYPE". /*a60-0383*/
    
  gv_prog  = "Match Text File Confirm (THANACHAT)".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  /*RUN proc_createpack.*/
  OPEN QUERY br_comp FOR EACH wcomp.
      DISP ra_matchpol   fi_para   fi_date WITH FRAM fr_main.
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
  DISPLAY ra_matchpol fi_loadname fi_outload fi_outload2 fi_outload3 fi_para 
          fi_date 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ra_matchpol fi_loadname fi_outload bu_file-3 bu_ok bu_exit-2 
         fi_outload2 fi_outload3 fi_para fi_date RECT-381 RECT-382 RECT-383 
         RECT-384 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ACCESSORY C-Win 
PROCEDURE proc_ACCESSORY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER nv_prepolacc AS CHAR.
ASSIGN nv_access = "".
IF nv_prepolacc <> "" THEN DO:
    FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE 
        sicuw.uwm301.policy = TRIM(nv_prepolacc) NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm301 THEN ASSIGN  nv_access = trim(sicuw.uwm301.prmtxt).
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
DEF VAR nv_vehreg AS CHAR FORMAT "x(35)".
DEF VAR nv_cartyp AS CHAR FORMAT "x(50)". /*A60-03838*/
DEF VAR nv_i      AS INT INIT 0.
DEFINE VAR nv_year  AS INTE.
DEFINE VAR nv_day   AS INTE.
DEFINE VAR nv_month AS INTE.
/*FOR EACH wdetail.*/
    ASSIGN nv_vehreg = ""       nv_cartyp = "" /*A60-03838*/
           nv_i      = 0        nv_year   = 0 
           nv_day    = 0        nv_month  = 0 .
          /* wdetail.pass = "".*/ /*A60-0383*/
    nv_i = nv_i + 1.
    wdetail.policy = wdetail.pol_typ + STRING(nv_i) + wdetail.Account_no.

    /*IF wdetail.ben_name = "NB" THEN DO:*/  /*A60-0545*/
    /* Create by A60-0545...*/
    IF trim(wdetail.ben_name) = "NB"          AND 
       (INDEX(wdetail.pol_title,"���") <> 0   OR 
       INDEX(wdetail.pol_title,"�.�")  <> 0   OR 
       INDEX(wdetail.pol_title,"�ҧ")  <> 0   OR
       INDEX(wdetail.pol_title,"�س")  <> 0 ) THEN DO:  /*A60-0545*/
    /*...end A60-0545...*/
         FIND FIRST stat.company WHERE stat.company.compno = wdetail.ben_name NO-LOCK NO-ERROR.
         IF AVAIL stat.company THEN DO:
             ASSIGN wdetail.addr1     = stat.Company.addr1
                    wdetail.addr2     = stat.Company.addr2
                    wdetail.addr3     = stat.Company.addr3
                    wdetail.addr4     = stat.Company.addr4
                    wdetail.ben_name =  stat.Company.Name .
         END.
    END.
   /* ELSE DO: 
        ASSIGN wdetail.addr1    = wdetail.addr1   
               wdetail.addr2    = wdetail.addr2   
               wdetail.addr3    = wdetail.addr3   
               wdetail.addr4    = wdetail.addr4   
               wdetail.ben_name = wdetail.ben_name.
    END.*/
    /*--- ���Ţ����¹ö ---*/
    IF wdetail.licence <> "" AND wdetail.province <> "" THEN DO:
        nv_vehreg = wdetail.province.
        FOR EACH brstat.insure WHERE brstat.Insure.Compno = "999" NO-LOCK:
            IF INDEX(nv_vehreg,brstat.Insure.Fname) <> 0 THEN DO: 
                ASSIGN
                    nv_vehreg = brstat.insure.Lname.
            END.
        END.
        wdetail.licence = wdetail.licence + " " + nv_vehreg.
    END.
    /*---- ����������� -----------*/
    IF wdetail.prev_pol <> "" THEN RUN proc_chkoldpol. 
     /*-- �Ң� ----*/
    /* comment by : A64-0205 .... 
    IF wdetail.prev_pol <> ""  THEN DO:
        IF INDEX(wdetail.prev_pol,"D") <> 0 THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1). 
        ELSE IF INDEX(wdetail.prev_pol,"I") <> 0 THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1). 
        ELSE wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,1,2).
    END.
    ... end A64-0205...*/ 
    /* add : A64-0205 */
    IF wdetail.prev_pol <> "" AND LENGTH(wdetail.PREV_pol) = 12  THEN DO: /* A64-0205 */
        IF SUBSTR(wdetail.prev_pol,1,1) = "D" THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1). 
        ELSE IF SUBSTR(wdetail.prev_pol,1,1) = "I" THEN wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,2,1).
        ELSE wdetail.branch_safe = SUBSTRING(wdetail.prev_pol,1,2).
        IF wdetail.branch_safe = "MF" THEN wdetail.branch_safe = "ML".  /*A66-0160*/
    END.
    /* end : A64-0205 */
    ELSE DO:
        IF wdetail.covcod = "3" AND wdetail.prev_pol = ""  THEN wdetail.branch_safe = "ML". /*wdetail.branch_safe = "M".*/ /*A64-0205*/
        ELSE DO:
            FIND FIRST stat.Insure WHERE stat.Insure.Compno = "NB" AND
                                         stat.Insure.Insno  = TRIM(wdetail.branch) NO-LOCK NO-ERROR.
            IF AVAIL stat.Insure THEN DO:
                wdetail.branch_safe = stat.Insure.Branch.
            END.
            ELSE wdetail.branch_safe = "".
        END.
        ASSIGN wdetail.bandet = "����ѷ��Сѹ������ : " + wdetail.company + " " + "�Ţ��� : " + nv_oldpol.
    END.
   /*---- �ѹ��������ͧ , ������� ------*/
    IF wdetail.pol_typ = "70" THEN DO:  
         ASSIGN nv_year   = 0 
                nv_day    = 0 
                nv_month  = 0. 
        /*--- Comdate ---*/
        nv_year   = (YEAR(DATE(wdetail.comdat)) - 543).
        nv_day    = DAY(DATE(wdetail.comdat)).
        nv_month  = MONTH(DATE(wdetail.comdat)).
        wdetail.comdat = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
        /*--- Expdate ---*/
        nv_year   = (YEAR(DATE(wdetail.expdat)) - 543).
        nv_day    = DAY(DATE(wdetail.expdat)).
        nv_month  = MONTH(DATE(wdetail.expdat)).
        wdetail.expdat  = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
    ELSE DO:
        ASSIGN nv_year   = 0 
               nv_day    = 0 
               nv_month  = 0.
        /*--- Comdate1 ---*/
        nv_year   = (YEAR(DATE(wdetail.comdat72)) - 543).
        nv_day    = DAY(DATE(wdetail.comdat72)).
        nv_month  = MONTH(DATE(wdetail.comdat72)).
        wdetail.comdat72 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
        /*--- comExpdate ---*/
        nv_year   = (YEAR(DATE(wdetail.expdat72)) - 543).
        nv_day    = DAY(DATE(wdetail.expdat72)).
        nv_month  = MONTH(DATE(wdetail.expdat72)).
        wdetail.expdat72 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
   /*-----���Ѻ��� ----------*/
    IF wdetail.drivename1 <> ""  THEN ASSIGN wdetail.drivename = "Y".
    ELSE ASSIGN wdetail.drivename = "N".
    /*--- Driver Birth Date 1 ---*/
    IF wdetail.drivename1 <> "" AND  wdetail.drivedate1 <> "" THEN DO:
        ASSIGN nv_year   = 0 
               nv_day    = 0 
               nv_month  = 0.
        nv_year    = (YEAR(DATE(wdetail.drivedate1)) - 543).
        nv_day     = DAY(DATE(wdetail.drivedate1)).
        nv_month   = MONTH(DATE(wdetail.drivedate1)).
        wdetail.drivedate1  = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
    /*--- Driver Birth Date 2 ---*/
    IF wdetail.drivname2 <> "" AND  wdetail.drivedate2 <> "" THEN DO:
        ASSIGN nv_year   = 0 
               nv_day    = 0 
               nv_month  = 0.
        nv_year    = (YEAR(DATE(wdetail.drivedate2)) - 543).
        nv_day     = DAY(DATE(wdetail.drivedate2)).
        nv_month   = MONTH(DATE(wdetail.drivedate2)).
        wdetail.drivedate2 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
    END.
    /*--- �ѹ����Ѻ�� ---*/
   IF wdetail.not_date <> "" THEN DO:
       ASSIGN nv_year   = 0 
              nv_day    = 0 
              nv_month  = 0.
        nv_year  = (YEAR(DATE(wdetail.not_date)) - 543).
        nv_day   = DAY(DATE(wdetail.not_date)).
        nv_month = MONTH(DATE(wdetail.not_date)).
        wdetail.not_date  = STRING(nv_day) + "/" + STRING(nv_month) + "/" + STRING(nv_year).
    END.
    /*--- Class , Pack -----------*/
    IF INDEX(wdetail.vehuse," ")  <> 0 THEN ASSIGN nv_cartyp = REPLACE(wdetail.vehuse," ","") .
    ELSE ASSIGN nv_cartyp = TRIM(wdetail.vehuse).

    FIND LAST brstat.insure USE-INDEX Insure03 WHERE brstat.insure.compno = TRIM(fi_para) AND
                                                     brstat.insure.insno  = TRIM(fi_para) AND 
                                                     brstat.insure.text2  = trim(nv_cartyp) NO-LOCK NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN wdetail.vehuse = brstat.insure.text1
               wdetail.CLASS  = brstat.insure.text3.
    END.
    ELSE  ASSIGN wdetail.vehuse = ""
                 wdetail.CLASS  = "".

    /* comment by : A60-0383
    IF wdetail.vehuse <> "" THEN DO:
        IF INDEX(wdetail.vehuse,"��") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"����ͧ") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.     
        ELSE IF INDEX(wdetail.vehuse,"������") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.    
        ELSE IF INDEX(wdetail.vehuse,"�ؤ�� (�� 1)") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"��÷ء") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "320"
                   wdetail.vehuse = "3" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"�����") <> 0  THEN DO:
            ASSIGN wdetail.CLASS = "210"
                   wdetail.vehuse = "2" .
        END.
        ELSE IF INDEX(wdetail.vehuse,"ö�����") <> 0  THEN DO:
             ASSIGN wdetail.CLASS = "210"
                   wdetail.vehuse = "2" .
        END.
        ELSE DO:
            ASSIGN wdetail.CLASS = "110"
                   wdetail.vehuse = "1" .
        END.
    END.
    ----- end. A60-0383----*/
    IF wdetail.covcod = "1" OR wdetail.covcod = "2" THEN wdetail.prempa = "G".
    /*ELSE IF wdetail.covcod = "2+" THEN wdetail.prempa = "C".*/  /*A60-0383*/
    /* start : A60-0383*/
    ELSE IF wdetail.covcod = "2+" OR wdetail.covcod = "3+" THEN DO: 
        IF DATE(wdetail.comdat)  < 10/01/2017  THEN ASSIGN wdetail.prempa = "Z". 
        ELSE ASSIGN wdetail.prempa = "C". 
    END.
    /* end : A60-0383*/
    ELSE ASSIGN wdetail.prempa   = "R"  .
                /*wdetail.ben_name = "".*/ /*A60-0383*/ /*--- �ҹ������بҡ�����蹤�����ͧ 3 ����� BenName --*/

    RUN proc_chkredbook.
    RUN proc_chktext.
/*END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkoldpol C-Win 
PROCEDURE proc_chkoldpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_len AS INTE.
ASSIGN  
  nv_oldpol = " "
  nv_oldpol = wdetail.prev_pol.

loop_chko1:
REPEAT:
    IF INDEX(nv_oldpol,"-") <> 0 THEN DO:
        nv_len    = LENGTH(nv_oldpol).
        nv_oldpol = TRIM(SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"-") - 1)) +
                    TRIM(SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"-") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko1.
END.
loop_chko2:
REPEAT:
    IF INDEX(nv_oldpol,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_oldpol).
        nv_oldpol = TRIM(SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"/") - 1)) +
                    TRIM(SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"/") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko2.
END.

/*IF LENGTH(nv_oldpol) <> 12 THEN nv_oldpol = "".
ELSE */
    /*IF INDEX(wdetail.company,"��Сѹ�������") <> 0 THEN wdetail.prev_pol = nv_oldpol.*/ /*A64-0205 */
    /* Add by : A64-0205 */
    IF INDEX(wdetail.company,"��Сѹ�������") <> 0 OR INDEX(wdetail.company,"������������") <> 0 OR   
       INDEX(wdetail.company,"��������չ") <> 0 THEN wdetail.prev_pol = nv_oldpol. 
    /* end : A64-0205 */
    ELSE wdetail.prev_pol = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkredbook C-Win 
PROCEDURE proc_chkredbook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_model  AS CHAR FORMAT "X(20)".
DEFINE VAR nv_model1 AS CHAR FORMAT "X(20)".

IF wdetail.pol_typ = "70" THEN DO:
    FIND FIRST stat.makdes31 WHERE stat.makdes31.makdes = "X" AND stat.makdes31.moddes = wdetail.Prempa + wdetail.CLASS NO-LOCK NO-ERROR.    
    IF AVAIL stat.makdes31 THEN DO:
       FIND FIRST stat.maktab_fil  WHERE  
                  stat.maktab_fil.makdes = TRIM(wdetail.brand)  AND
                  INDEX(stat.maktab_fil.moddes,TRIM(wdetail.Brand_Model)) <> 0  AND
                  stat.maktab_fil.makyea = INTEGER(wdetail.yrmanu)              AND
                  stat.maktab_fil.engine >= INTEGER(wdetail.weight)             AND
                  stat.maktab_fil.sclass = wdetail.class                        AND
                  (stat.maktab_fil.si - (stat.maktab_fil.si * makdes31.si_theft_p / 100) LE INTE(wdetail.ins_amt) AND
                  stat.maktab_fil.si + (stat.maktab_fil.si * makdes31.Load_p / 100) GE INTE(wdetail.ins_amt))
                  NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL stat.maktab_fil THEN DO:
           ASSIGN
               wdetail.Redbook = stat.maktab_fil.modcod
               wdetail.ton     = STRING(stat.maktab_fil.tons)
               wdetail.Seat    = STRING(stat.maktab_fil.seats)
               wdetail.Body    = stat.maktab_fil.body
               wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
       END.
       ELSE DO:
           ASSIGN
               wdetail.Redbook = ""
               wdetail.ton     = ""
               wdetail.Seat    = "7"
               wdetail.Body    = ""
               wdetail.Vehgrp  = "".  /*A59-0070*/
       END.  
    END.

    IF wdetail.Redbook = "" THEN DO:
        IF INDEX(wdetail.brand_model," ") <> 0 THEN DO:
            nv_model  = SUBSTR(wdetail.Brand_Model,1,INDEX(wdetail.Brand_Model," ")).
            nv_model1 = TRIM(SUBSTR(wdetail.Brand_Model,LENGTH(nv_model) + 1,LENGTH(wdetail.Brand_Model))).
            nv_model1 = SUBSTR(nv_model1,1,INDEX(nv_model1," ")).
        END.
        ELSE nv_model = TRIM(wdetail.brand_model).

        IF TRIM(nv_model) = "HILUX" THEN nv_model = TRIM(nv_model) + " " + TRIM(nv_model1).
        IF INDEX(nv_Model,"D-MAX") <> 0 THEN nv_model = "D-MAX".
        IF INDEX(nv_Model,"YARIS") <> 0 THEN nv_model = "YARIS".

        FOR EACH stat.maktab_fil WHERE
                   stat.maktab_fil.makdes = TRIM(wdetail.brand)      AND
             INDEX(stat.maktab_fil.moddes,TRIM(nv_model)) <> 0 AND
                   stat.maktab_fil.makyea = INTEGER(wdetail.yrmanu)   AND
                   stat.maktab_fil.engine >= INTEGER(wdetail.weight)  AND
                   stat.maktab_fil.sclass = wdetail.CLASS           AND
                  (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(wdetail.ins_amt) AND
                   stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(wdetail.ins_amt)) NO-LOCK:
            ASSIGN
               wdetail.Redbook = stat.maktab_fil.modcod
               wdetail.ton     = STRING(stat.maktab_fil.tons)
               wdetail.Seat    = STRING(stat.maktab_fil.seats)
               wdetail.Body    = stat.maktab_fil.body
               wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
    
        END.
        IF wdetail.Redbook = "" THEN DO:
           FOR EACH stat.maktab_fil WHERE
                       stat.maktab_fil.makdes = trim(wdetail.brand)  AND
                 INDEX(stat.maktab_fil.moddes,TRIM(nv_model1)) <> 0  AND
                       stat.maktab_fil.makyea = INTEGER(wdetail.yrmanu) AND
                       stat.maktab_fil.engine >= INTEGER(wdetail.weight) AND
                       stat.maktab_fil.sclass = wdetail.CLASS AND
                      (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(wdetail.ins_amt) AND
                       stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(wdetail.ins_amt)) NO-LOCK:
                ASSIGN
                   wdetail.Redbook = stat.maktab_fil.modcod
                   wdetail.ton     = STRING(stat.maktab_fil.tons)
                   wdetail.Seat    = STRING(stat.maktab_fil.seats)
                   wdetail.Body    = stat.maktab_fil.body
                   wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
            END.
        END.
        IF wdetail.Redbook = "" THEN DO:
          FIND FIRST stat.maktab_fil WHERE
                       stat.maktab_fil.makdes = trim(wdetail.brand)    AND
                 INDEX(stat.maktab_fil.moddes,TRIM(nv_model)) <> 0  AND
                       stat.maktab_fil.makyea  = INTEGER(wdetail.yrmanu) AND
                       stat.maktab_fil.engine >= INTEGER(wdetail.weight)  AND
                      (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(wdetail.ins_amt) AND
                       stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(wdetail.ins_amt)) NO-LOCK NO-ERROR.
          IF AVAIL stat.maktab_fil THEN DO:
                ASSIGN
                   wdetail.Redbook = stat.maktab_fil.modcod
                   wdetail.ton     = STRING(stat.maktab_fil.tons)
                   wdetail.Seat    = STRING(stat.maktab_fil.seats)
                   wdetail.Body    = stat.maktab_fil.body
                   wdetail.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
          END.
        END.
    
    END.
END.
ELSE DO:
    FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = trim(wdetail.brand) + " " + trim(wdetail.brand_model) AND 
                             sicsyac.xmm102.engine  >= INTE(wdetail.weight) NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                wdetail.ton          = STRING(sicsyac.xmm102.tons)  
                wdetail.seat         = STRING(sicsyac.xmm102.seats)
                wdetail.redbook      = sicsyac.xmm102.modcod
                wdetail.body         = sicsyac.xmm102.body
                wdetail.Vehgrp       = sicsyac.xmm102.vehgrp.
                
        END.
        ELSE DO:
             FIND LAST sicsyac.xmm102 WHERE sicsyac.xmm102.modest = trim(wdetail.brand) AND
                             sicsyac.xmm102.engine  >= INTE(wdetail.weight) NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm102  THEN DO:
                    ASSIGN
                    wdetail.ton          = STRING(sicsyac.xmm102.tons)  
                    wdetail.seat         = STRING(sicsyac.xmm102.seats)
                    wdetail.redbook      = sicsyac.xmm102.modcod
                    wdetail.body         = sicsyac.xmm102.body
                    wdetail.Vehgrp       = sicsyac.xmm102.vehgrp.
                END.
                ELSE DO:
                   ASSIGN
                       wdetail.Redbook = ""
                       wdetail.ton     = ""
                       wdetail.Seat    = "7"
                       wdetail.Body    = ""
                       wdetail.Vehgrp  = "".  
                END.
       END.  
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktext C-Win 
PROCEDURE proc_chktext :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----- Comment A53-0111 Edit Vol.1 --*/
/*-- ���ͼ����һ�Сѹ --*/
IF wdetail.pol_fname = "" THEN DO:
    ASSIGN wdetail.comment = "| ���ͼ����һ�Сѹ�繤����ҧ " 
           wdetail.pass    = "N".
END.
/*-- �ѹ��������������ͧ/�ѹ�������ش����������ͧ --*/
IF wdetail.pol_type = "70" THEN DO:
    IF wdetail.Comdat = "" THEN DO:
        ASSIGN wdetail.comment = "| �ѹ��������������ͧ ��.�繤����ҧ " 
               wdetail.pass    = "N".
    END.
    IF wdetail.Expdat = "" THEN DO:
        ASSIGN wdetail.comment = "| �ѹ�������ش����������ͧ ��.�繤����ҧ " 
               wdetail.pass    = "N".
    END.
END.
ELSE DO:
    IF wdetail.Comdat72 = "" OR wdetail.Expdat72 /*Imexpdate*/ = "" THEN DO:
        ASSIGN wdetail.comment = "| �ѹ��������������ͧ �ú. �繤����ҧ " 
               wdetail.pass    = "N".
    END.
    IF wdetail.Comdat72 = "" OR wdetail.Expdat72 /*Imexpdate*/ = "" THEN DO:
        ASSIGN wdetail.comment = "| �ѹ�������ش����������ͧ �ú.�繤����ҧ " 
               wdetail.pass    = "N".
    END.

END.
/*-- ������ö --*/
IF wdetail.Brand = "" THEN DO:
    ASSIGN wdetail.comment = "| ������ö�繤����ҧ "
           wdetail.pass    = "N".
END.
/*-- ���ö ---*/
IF wdetail.Brand_Model = "" THEN DO:
    ASSIGN wdetail.comment = "| ���ö�繤����ҧ "
           wdetail.pass    = "N".
END.
/*-- �շ���Ե --*/
IF wdetail.yrmanu = "" THEN DO:
    ASSIGN wdetail.comment = "| �շ���Ե�繤����ҧ "
           wdetail.pass    = "N".
END.
/*-- CC --*/
IF /*Imcc*/ wdetail.weight = "" THEN DO:
    ASSIGN wdetail.comment = "| CC �繤����ҧ " 
           wdetail.pass    = "N".
END.
/*-- �Ţ����ͧ --*/
IF wdetail.Engine = "" THEN DO:
    ASSIGN wdetail.comment = "| �Ţ����ͧ¹���繤����ҧ " 
           wdetail.pass    = "N" .
END.
/*-- �Ţ��Ƕѧ --*/
IF wdetail.chassis = "" THEN DO:
    ASSIGN wdetail.comment = "| �Ţ��Ƕѧ�繤����ҧ " 
           wdetail.pass    = "N".
END.
/*-- Driver Name ---*/
IF wdetail.drivename = "Y" THEN DO:
    IF (wdetail.drivename1 = "" AND wdetail.drivedate1 = "") THEN
        ASSIGN wdetail.comment = "| ���ͼ��Ѻ�������ѹ�Դ�繤����ҧ " 
               wdetail.pass    = "N".
END.
/*-- �ӹ�˹�Ҫ��� --*/
IF wdetail.pol_title = "" THEN DO:
    ASSIGN wdetail.comment = "| �ӹ�˹�Ҫ����繤����ҧ "
           wdetail.pass    = "N".
END.
/*-- Branch --*/
IF wdetail.Branch_safe = "" THEN DO:
    ASSIGN wdetail.comment = "| Branch �繤����ҧ ��سҵ�Ǩ�ͺ Branch"
           wdetail.pass    = "N".
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1 C-Win 
PROCEDURE proc_impmatpol1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: /* Create by A61-0512 ....*/      
------------------------------------------------------------------------------*/
DO:
    INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wrec.
          IMPORT DELIMITER "|" 
                wrec.Notify_no                  /*�Ţ����Ѻ��           */     
                wrec.Account_no                 /*�Ţ����ѭ��             */     
                wrec.prevpol                   /*�Ţ�������������      */     
                wrec.company                    /*����ѷ��Сѹ���        */     
                wrec.not_office                 /*���ͼ����һ�Сѹ���     */     
                wrec.ben_name                   /*����Ѻ�Ż���ª��        */     
                wrec.comdat                     /*�ѹ��������������ͧ     */     
                wrec.expdat                     /*�ѹ�������ش������ͧ   */     
                wrec.licence                    /*�Ţ����¹              */     
                wrec.province                   /*�ѧ��Ѵ                 */     
                wrec.ctype                      /*��Ѥ��/�ú.            */     
                wrec.ins_amt                    /*�ع��Сѹ               */     
                wrec.prem1                      /*���»�Сѹ�ط��        */     
                wrec.prem                       /*���»�Сѹ������       */     
                wrec.remark                     /*�����˵�                */     
                wrec.not_date                   /*�ѹ����Ѻ��           */     
                wrec.not_name                   /*���ͻ�Сѹ���           */     
                wrec.brand                      /*������                  */     
                wrec.Brand_Model                /*���                    */     
                wrec.yrmanu                     /*��                      */     
                wrec.weight                     /*��Ҵ����ͧ             */     
                wrec.engine                     /*�Ţ����ͧ              */     
                wrec.chassis                    /*�Ţ�ѧ                  */     
                wrec.pattern                    /*Pattern Rate            */     
                wrec.covcod                     /*��������Сѹ            */     
                wrec.vehuse                     /*������ö                */     
                wrec.sclass                     /*����ö                  */     
                wrec.garage                     /*ʶҹ������             */     
                wrec.drivename1                 /*�кؼ��Ѻ���1          */     
                wrec.driveid1                   /*�Ţ���㺢Ѻ���1         */     
                wrec.driveic1                   /*�Ţ���ѵû�ЪҪ�1      */     
                wrec.drivedate1                 /*�ѹ��͹���Դ1         */     
                wrec.drivname2                  /*�кؼ��Ѻ���2          */     
                wrec.driveid2                   /*�Ţ���㺢Ѻ���2         */     
                wrec.driveic2                   /*�Ţ���ѵû�ЪҪ�2      */     
                wrec.drivedate2                 /*�ѹ��͹���Դ2         */     
                wrec.cl                         /*��ǹŴ����ѵ�����       */     
                wrec.fleetper                   /*��ǹŴ�����             */     
                wrec.ncbper                     /*����ѵԴ�               */     
                wrec.othper                     /*��� �                  */     
                wrec.pol_addr1                  /*��������١���           */     
                wrec.icno                       /*IDCARD                  */     
                wrec.icno_st                    /*DateCARD_S              */     
                wrec.icno_ex                    /*DateCARD_E              */     
                wrec.bdate                      /*Birth Date              */     
                wrec.paidtyp                    /*Type_Paid_1             */     
                wrec.paydate                    /*Paid_Date               */     
                wrec.paid                       /*Paid_Amount             */     
                wrec.prndate                    /*�ѹ������� �ú.        */     
                wrec.sckno                     /*�Ţʵԡ���� / �Ţ ��.  */ 
                wrec.nCOLOR        /*A66-0160*/
                wrec.mobile        /*A66-0160*/
                wrec.receipaddr    /*A66-0160*/
                wrec.sendaddr      /*A66-0160*/
                wrec.notifycode    /*A66-0160*/
                wrec.salenotify .  /*A66-0160*/
               







          IF INDEX(wrec.NOT_date,"�ѹ���") <> 0 THEN DELETE wrec.
          ELSE IF wrec.not_date = "" THEN DELETE wrec.
    END.   /* repeat  */
    RUN proc_impmatpol1_01.
END.

    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1_01 C-Win 
PROCEDURE proc_impmatpol1_01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_length AS INT.
DEF VAR n_notdate AS DATE INIT ? .
DEF VAR n_year    AS INT .
DO:
  FOR EACH wrec .
    IF wrec.not_date  = "" THEN DELETE wrec.
    ELSE DO:
        ASSIGN   nv_type   = ""     n_length = 0    n_notdate = ?      n_year   = 0.
        IF (YEAR(date(wrec.NOT_date)) = YEAR(TODAY)) OR (YEAR(date(wrec.NOT_date)) = (YEAR(TODAY) - 1)) THEN DO: /*A60-0545*/
            ASSIGN  n_notdate = DATE(STRING(DATE(wrec.NOT_date),"99/99/9999"))
                n_year    = INT(YEAR(n_notdate)) + 543
                wrec.NOT_date = STRING(DAY(n_notdate),"99") + "/" + STRING(MONTH(n_notdate),"99") + "/" + string(n_year,"9999").
        END.
        IF INDEX(wrec.ctype,"�ú") <> 0 THEN ASSIGN nv_type = "V72".
        ELSE IF INDEX(wrec.ctype,"�ѧ�Ѻ") <> 0 THEN ASSIGN nv_type = "V72". /*A61-0512 */
        ELSE ASSIGN nv_type = "V70".
        /* start : A60-0383*/
        IF wrec.not_office <> "" THEN DO:
            ASSIGN  n_length = LENGTH(wrec.not_office)
                nv_name  = SUBSTR(TRIM(wrec.NOT_office),INDEX(wrec.NOT_office," ") + 1,n_length).
        END.
        /* end : A60-0383*/
        FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
          brstat.tlt.datesent     = DATE(wrec.not_date)   AND    /*�ѹ����駧ҹ */           
          brstat.tlt.nor_noti_tlt = TRIM(wrec.Notify_no)  AND    /*�Ţ����Ѻ�� */
          /*brstat.tlt.ins_name     = TRIM(nv_name)         AND*/  /*A60-0383 */
          index(wrec.not_office,trim(brstat.tlt.ins_name)) <> 0 AND     /*A60-0383 */ /*���� -ʡ�� */
          brstat.tlt.genusr       = "THANACHAT"           AND     
          brstat.tlt.subins       = TRIM(nv_type)         NO-ERROR NO-WAIT.    /* ������ V70 ,V72 */   
        IF AVAIL brstat.tlt THEN DO:
          IF brstat.tlt.releas = "NO" THEN DO:
              IF brstat.tlt.recac = "" THEN                             
                  ASSIGN brstat.tlt.recac = "������������"             
                  /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
                  brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
                  wrec.remark = "Complete".                      
              ELSE ASSIGN wrec.remark = "�ա�� confirm �����" .
              IF brstat.tlt.subins = "V70" THEN ASSIGN brstat.tlt.nor_grprm = deci(wrec.prem).   /*A60-0383*/
              ELSE ASSIGN brstat.tlt.comp_grprm = deci(wrec.prem).                               /*A60-0383*/
              ASSIGN wrec.prevpol = brstat.tlt.filler1                                           /*A60-0383*/
                  wrec.loss    = string(brstat.tlt.sentcnt) .                                 /*A60-0383*/
              RUN proc_ACCESSORY (INPUT brstat.tlt.filler1).  
              FIND LAST wdetail WHERE wdetail.Notify_no = trim(wrec.Notify_no)  AND 
                  wdetail.not_date  = trim(wrec.not_date)   AND
                  wdetail.pol_typ   = substr(nv_type,2,2) NO-ERROR NO-WAIT.
              IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN
                wdetail.Pro_off     =    brstat.tlt.rec_addr3                                                                    /*�Ţ����Ѻ������Ң�      */                                                    
                wdetail.Notify_no   =    brstat.tlt.nor_noti_tlt                                                                 /*�Ţ����Ѻ��             */  
                wdetail.branch      =    brstat.tlt.EXP                                                                          /*�Ң�                      */  
                wdetail.Account_no  =    brstat.tlt.safe2                                                                        /*�Ţ����ѭ��               */  
                wdetail.prev_pol    =    brstat.tlt.filler1                                                                      /*�Ţ�������������        */  
                wdetail.company     =    brstat.tlt.rec_addr4                                                                    /*����ѷ��Сѹ���          */  
                wdetail.pol_title   =    brstat.tlt.rec_name                                                                     /*�ӹ�˹�Ҫ���              */  
                wdetail.pol_fname   =    brstat.tlt.ins_name                                                                     /*���ͼ����һ�Сѹ���       */  
                /*wdetail.pol_lname   =    ""                                                                                      /*���ʡ��                   */ */ 
                wdetail.ben_name    =    brstat.tlt.safe1                                                                        /*����Ѻ�Ż���ª��          */  
                wdetail.comdat      =    string(brstat.tlt.gendat,"99/99/9999")                                                  /*�ѹ��������������ͧ       */            
                wdetail.expdat      =    string(brstat.tlt.expodat,"99/99/9999")                                                 /*�ѹ�������ش������ͧ     */            
                wdetail.comdat72    =    string(brstat.tlt.comp_effdat,"99/99/9999")                                             /*�ѹ�������������ͧ�ú     */            
                wdetail.expdat72    =    string(brstat.tlt.nor_effdat,"99/99/9999")                                              /*�ѹ�������ش������ͧ�ú  */            
                wdetail.licence     =    brstat.tlt.lince1                                                                       /*�Ţ����¹                */  
                wdetail.province    =    brstat.tlt.lince3                                                                       /*�ѧ��Ѵ                   */  
                wdetail.ins_amt     =    string(brstat.tlt.nor_coamt)                                                            /*�ع��Сѹ                 */  
                wdetail.prem1       =    string(brstat.tlt.nor_grprm)                                                            /*���»�Сѹ���            */  
                wdetail.comp_prm    =    string(brstat.tlt.comp_grprm)                                                           /*���¾ú���               */  
                wdetail.gross_prm   =    string(brstat.tlt.comp_coamt)                                                           /*�������                  */  
                wdetail.compno      =    brstat.tlt.comp_pol                                                                     /*�Ţ��������ú            */  
                wdetail.sckno       =    brstat.tlt.comp_sck                                                                     /*�Ţ���ʵ������          */  
                wdetail.not_code    =    brstat.tlt.comp_usr_tlt                                                                 /*���ʼ����               */  
                wdetail.remark      =    brstat.tlt.filler2                                                                      /*�����˵�                  */  
                wdetail.not_date    =    string(brstat.tlt.datesent,"99/99/9999")                                               /*�ѹ����Ѻ��             */             
                wdetail.not_office  =    brstat.tlt.nor_usr_tlt                                                                  /*���ͻ�Сѹ���             */  
                wdetail.not_name    =    brstat.tlt.nor_usr_ins                                                                  /*�����                   */  
                wdetail.brand       =    brstat.tlt.brand                                                                        /*������                    */  
                wdetail.Brand_Model =    brstat.tlt.model                                                                        /*���                      */  
                wdetail.yrmanu      =    brstat.tlt.lince2                                                                       /*��                        */  
                wdetail.weight      =    string(brstat.tlt.cc_weight)                                                            /*��Ҵ����ͧ               */  
                wdetail.engine      =    brstat.tlt.eng_no                                                                       /*�Ţ����ͧ                */  
                wdetail.chassis     =    brstat.tlt.cha_no                                                                       /*�Ţ�ѧ                    */  
                wdetail.pattern     =    brstat.tlt.old_cha                                                                      /*Pattern Rate              */  
                wdetail.covcod      =    brstat.tlt.expousr                                                                      /*��������Сѹ              */  
                wdetail.vehuse      =    brstat.tlt.old_eng                                                                      /*������ö                  */  
                /*wdetail.garage      =    IF trim(brstat.tlt.stat) = "�������" THEN "G" ELSE ""  */ /*A60-0383*/                /*ʶҹ������               */  
                wdetail.garage      =    IF trim(brstat.tlt.expousr) = "1" AND trim(brstat.tlt.stat) = "������ҧ" THEN "G" ELSE ""       /*A60-0383*/
                wdetail.drivename1  =    IF LENGTH(brstat.tlt.dri_name1) <> 0  THEN SUBSTR(brstat.tlt.dri_name1,1,60)  ELSE ""   /*�кؼ��Ѻ���1            */  
                wdetail.driveid1    =    IF length(brstat.tlt.dri_name1) > 60 THEN SUBSTR(brstat.tlt.dri_name1,61,20)  ELSE ""   /*�Ţ���㺢Ѻ���1           */  
                wdetail.driveic1    =    IF length(brstat.tlt.dri_name1) > 80 THEN SUBSTR(brstat.tlt.dri_name1,81,20)  ELSE ""   /*�Ţ���ѵû�ЪҪ�1        */  
                wdetail.drivedate1  =    brstat.tlt.dri_no1                                                                      /*�ѹ��͹���Դ1           */      
                wdetail.drivname2   =    IF LENGTH(brstat.tlt.dri_name2) <> 0  THEN SUBSTR(brstat.tlt.dri_name2,1,60)  else ""   /*�кؼ��Ѻ���2            */  
                wdetail.driveid2    =    IF length(brstat.tlt.dri_name2) > 60 THEN SUBSTR(brstat.tlt.dri_name2,61,20)  else ""   /*�Ţ���㺢Ѻ���2           */  
                wdetail.driveic2    =    IF length(brstat.tlt.dri_name2) > 80 THEN SUBSTR(brstat.tlt.dri_name2,81,20)  else ""   /*�Ţ���ѵû�ЪҪ�2        */  
                wdetail.drivedate2  =    brstat.tlt.dri_no2                                                                      /*�ѹ��͹���Դ2           */      
                wdetail.cl          =    STRING(brstat.tlt.endno)                                                                /*��ǹŴ����ѵ�����         */  
                wdetail.fleetper    =    STRING(brstat.tlt.lotno)                                                                /*��ǹŴ�����               */  
                wdetail.ncbper      =    string(brstat.tlt.seqno)                                                                /*����ѵԴ�                 */  
                wdetail.othper      =    string(brstat.tlt.endcnt)                                                               /*��� �                    */  
                wdetail.addr1       =    brstat.tlt.ins_addr1                                                                    /*��������١���             */  
                wdetail.addr2       =    brstat.tlt.ins_addr2                                                                    /*��������١���             */  
                wdetail.addr3       =    brstat.tlt.ins_addr3                                                                    /*��������١���             */  
                wdetail.addr4       =    brstat.tlt.ins_addr4                                                                    /*��������١���             */  
                wdetail.icno        =    "" /*brstat.tlt.ins_addr5*/                                                             /*IDCARD                    */  
                wdetail.icno_st     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_S                */  
                wdetail.icno_ex     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_E                */  
                wdetail.paid        =    brstat.tlt.safe3                                                                        /*Type_Paid_1               */  
                wdetail.pol_typ     =    substr(brstat.tlt.subins,2,2)                                                                       /*������ ��.                */  
                wdetail.agent       =    brstat.tlt.comp_noti_ins                                                                /*agent                     */  
                wdetail.producer    =    brstat.tlt.comp_sub                                                                     /*producer                  */
                wdetail.pass        =    "Y"
                wdetail.ACCESSORY   =    nv_access            /*A66-0160*/
                wdetail.ncolor      =    wrec.ncolor           /*A66-0160*/
                wdetail.campaign    =    brstat.tlt.rec_addr2  /*A60-0383*/   /*campaign*/   
                wdetail.ispno       =    brstat.tlt.rec_addr5. /*A61-0512 */ /*ISPNO */
                IF wdetail.icno = "" THEN DO:
                  ASSIGN n_length            = 0
                  n_addr5             = ""
                  n_exp               = ""
                  n_com               = ""
                  n_ic                = ""
                  n_addr5             = TRIM(brstat.tlt.ins_addr5)
                  n_length            = LENGTH(n_addr5)                                   
                  n_exp               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Exp:") + 4,n_length)  
                  n_addr5             = SUBSTR(n_addr5,1,R-INDEX(n_addr5," "))             
                  n_length            = LENGTH(n_addr5)                                     
                  n_com               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Comm:") + 5,n_length)
                  /*n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 6) */ /*a60-0383*/
                  n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 5)      /*A60-0383*/
                  wdetail.icno        = TRIM(n_ic)
                  wdetail.icno_st     = IF trim(n_com) <> "" THEN SUBSTR(n_com,7,2) + "/" + SUBSTR(n_com,5,2) + "/" + SUBSTR(n_com,1,4) ELSE ""
                  wdetail.icno_ex     = IF trim(n_exp) <> "" THEN SUBSTR(n_exp,7,2) + "/" + SUBSTR(n_exp,5,2) + "/" + SUBSTR(n_exp,1,4) ELSE "".
                END.
                /* comment by A61-0512 ....
                /*A60-0383*/
                IF      trim(wdetail.pol_title) = "���"     THEN ASSIGN  wdetail.pol_title = "�س".
                ELSE IF trim(wdetail.pol_title) = "�ҧ"     THEN ASSIGN  wdetail.pol_title = "�س".
                ELSE IF trim(wdetail.pol_title) = "�.�."    THEN ASSIGN  wdetail.pol_title = "�س".
                ELSE IF trim(wdetail.pol_title) = "�ҧ���"  THEN ASSIGN  wdetail.pol_title = "�س".
                /* end A60-0383*/
                ... end A61-0512 */
                /* create : A61-0512 */
                IF trim(wdetail.pol_title) = "�س"  THEN  ASSIGN wdetail.pol_title =  SUBSTR(wrec.NOT_office,1,INDEX(wrec.NOT_office," ")) .
                ASSIGN 
                n_year            =  0
                n_year            =  YEAR(fi_date) + 543
                wdetail.typ_paid   =  wrec.paidtyp
                wdetail.paid_date  =  wrec.paydate
                wdetail.conf_date  =  STRING(fi_date,"99/99/9999")
                wdetail.conf_date  = SUBSTR(wdetail.conf_date,1,6) + STRING(n_year,"9999").
              END.
              RUN proc_chkdata.
          END.
          ELSE IF brstat.tlt.releas = "YES" THEN DO:
              IF brstat.tlt.recac = "" THEN ASSIGN brstat.tlt.recac = "������������"   
              /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
              brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
              wrec.remark =  IF brstat.tlt.subins = "V70" THEN wrec.remark + "COMPLETE/�͡������������� " + brstat.tlt.nor_noti_ins 
              ELSE wrec.remark + "COMPLETE/�͡������������� " + brstat.tlt.comp_pol. 
              ELSE ASSIGN wrec.remark = IF brstat.tlt.subins = "V70" THEN  wrec.remark + "�͡������������� " + brstat.tlt.nor_noti_ins 
              ELSE wrec.remark +  "�͡������������� " + brstat.tlt.comp_pol.
          END.
          ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN wrec.remark = wrec.remark + "�ա��¡��ԡ�Ţ����Ѻ�駹������ ".
        END.
        /*ELSE ASSIGN wrec.remark = "Not Complete" .*/
        ELSE ASSIGN wrec.remark = wrec.remark + "��辺������㹶ѧ�ѡ " .
        RELEASE brstat.tlt.
    END.
  END.
IF NOT CONNECTED("sic_exp")  THEN RUN proc_sic_exp.
/*IF CONNECTED("sic_exp") AND nv_type = "V70" THEN RUN wgw\wgwtnchk1.*/ /*A60-0545*/
IF CONNECTED("sic_exp") THEN RUN wgw\wgwtnchk1. /*A60-0545*/
Run Pro_reportreceipt.
Message "Export data Complete"  View-as alert-box.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol1_old C-Win 
PROCEDURE proc_impmatpol1_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: /* comment by A61-0512 ....*/      
------------------------------------------------------------------------------*/
/*DEF VAR n_length AS INT.
DEF VAR n_notdate AS DATE INIT ? .
DEF VAR n_year    AS INT .
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wrec.
          IMPORT DELIMITER "|" 
                wrec.not_date       /*�ѹ����Ѻ��         */             
                wrec.Notify_no      /*�Ţ����Ѻ��         */             
                wrec.Account_no     /*�Ң� � �Ţ����ѭ��    */             
                wrec.not_office     /*���ͼ����һ�Сѹ���   */             
                wrec.ctype          /*��Ѥ��/�ú.          */             
                wrec.comdat         /*�ѹ��������������ͧ   */             
                wrec.expdat         /*�ѹ�������ش         */             
                wrec.prem           /* ������»�Сѹ������ */             
                wrec.paydate .      /*�ѹ����١��Ҫ������¤����ش����*/  
          IF INDEX(wrec.NOT_date,"�ѹ���") <> 0 THEN DELETE wrec.
          ELSE IF wrec.not_date = "" THEN DELETE wrec.
    END.   /* repeat  */
    FOR EACH wrec .
        IF wrec.not_date  = "" THEN DELETE wrec.
        ELSE DO:
            ASSIGN   nv_type   = ""     n_length = 0    n_notdate = ?      n_year   = 0.
            IF (YEAR(date(wrec.NOT_date)) = YEAR(TODAY)) OR (YEAR(date(wrec.NOT_date)) = (YEAR(TODAY) - 1)) THEN DO: /*A60-0545*/
                ASSIGN  n_notdate = DATE(STRING(DATE(wrec.NOT_date),"99/99/9999"))
                        n_year    = INT(YEAR(n_notdate)) + 543
                        wrec.NOT_date = STRING(DAY(n_notdate),"99") + "/" + STRING(MONTH(n_notdate),"99") + "/" + string(n_year,"9999").
            END.
            IF INDEX(wrec.ctype,"�ú") <> 0 THEN ASSIGN nv_type = "V72".
            ELSE ASSIGN nv_type = "V70".
            /* start : A60-0383*/
            IF wrec.not_office <> "" THEN DO:
                ASSIGN  n_length = LENGTH(wrec.not_office)
                        nv_name  = SUBSTR(TRIM(wrec.NOT_office),INDEX(wrec.NOT_office," ") + 1,n_length).
            END.
            /* end : A60-0383*/
            FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
                      brstat.tlt.datesent     = DATE(wrec.not_date)   AND    /*�ѹ����駧ҹ */           
                      brstat.tlt.nor_noti_tlt = TRIM(wrec.Notify_no)  AND    /*�Ţ����Ѻ�� */
                      /*brstat.tlt.ins_name     = TRIM(nv_name)         AND*/  /*A60-0383 */
                      index(wrec.not_office,trim(brstat.tlt.ins_name)) <> 0 AND     /*A60-0383 */ /*���� -ʡ�� */
                      brstat.tlt.genusr       = "THANACHAT"           AND     
                      brstat.tlt.subins       = TRIM(nv_type)         NO-ERROR NO-WAIT.    /* ������ V70 ,V72 */   
                    IF AVAIL brstat.tlt THEN DO:
                       IF brstat.tlt.releas = "NO" THEN DO:
                         IF brstat.tlt.recac = "" THEN                             
                            ASSIGN brstat.tlt.recac = "������������"             
                                   /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
                                    brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
                                   wrec.remark = "Complete".                      
                         ELSE ASSIGN wrec.remark = "�ա�� confirm �����" .
                         
                         IF brstat.tlt.subins = "V70" THEN ASSIGN brstat.tlt.nor_grprm = deci(wrec.prem).   /*A60-0383*/
                         ELSE ASSIGN brstat.tlt.comp_grprm = deci(wrec.prem).                               /*A60-0383*/
                         ASSIGN wrec.prevpol = brstat.tlt.filler1                                           /*A60-0383*/
                                wrec.loss    = string(brstat.tlt.sentcnt) .                                 /*A60-0383*/
                        
                         FIND LAST wdetail WHERE wdetail.Notify_no = trim(wrec.Notify_no)  AND 
                                                 wdetail.not_date  = trim(wrec.not_date)   AND
                                                 wdetail.pol_typ   = substr(nv_type,2,2) NO-ERROR NO-WAIT.
                         IF NOT AVAIL wdetail THEN DO:
                             CREATE wdetail.
                             ASSIGN
                               wdetail.Pro_off     =    brstat.tlt.rec_addr3                                                                    /*�Ţ����Ѻ������Ң�      */                                                    
                               wdetail.Notify_no   =    brstat.tlt.nor_noti_tlt                                                                 /*�Ţ����Ѻ��             */  
                               wdetail.branch      =    brstat.tlt.EXP                                                                          /*�Ң�                      */  
                               wdetail.Account_no  =    brstat.tlt.safe2                                                                        /*�Ţ����ѭ��               */  
                               wdetail.prev_pol    =    brstat.tlt.filler1                                                                      /*�Ţ�������������        */  
                               wdetail.company     =    brstat.tlt.rec_addr4                                                                    /*����ѷ��Сѹ���          */  
                               wdetail.pol_title   =    brstat.tlt.rec_name                                                                     /*�ӹ�˹�Ҫ���              */  
                               wdetail.pol_fname   =    brstat.tlt.ins_name                                                                     /*���ͼ����һ�Сѹ���       */  
                               /*wdetail.pol_lname   =    ""                                                                                      /*���ʡ��                   */ */ 
                               wdetail.ben_name    =    brstat.tlt.safe1                                                                        /*����Ѻ�Ż���ª��          */  
                               wdetail.comdat      =    string(brstat.tlt.gendat,"99/99/9999")                                                  /*�ѹ��������������ͧ       */            
                               wdetail.expdat      =    string(brstat.tlt.expodat,"99/99/9999")                                                 /*�ѹ�������ش������ͧ     */            
                               wdetail.comdat72    =    string(brstat.tlt.comp_effdat,"99/99/9999")                                             /*�ѹ�������������ͧ�ú     */            
                               wdetail.expdat72    =    string(brstat.tlt.nor_effdat,"99/99/9999")                                              /*�ѹ�������ش������ͧ�ú  */            
                               wdetail.licence     =    brstat.tlt.lince1                                                                       /*�Ţ����¹                */  
                               wdetail.province    =    brstat.tlt.lince3                                                                       /*�ѧ��Ѵ                   */  
                               wdetail.ins_amt     =    string(brstat.tlt.nor_coamt)                                                            /*�ع��Сѹ                 */  
                               wdetail.prem1       =    string(brstat.tlt.nor_grprm)                                                            /*���»�Сѹ���            */  
                               wdetail.comp_prm    =    string(brstat.tlt.comp_grprm)                                                           /*���¾ú���               */  
                               wdetail.gross_prm   =    string(brstat.tlt.comp_coamt)                                                           /*�������                  */  
                               wdetail.compno      =    brstat.tlt.comp_pol                                                                     /*�Ţ��������ú            */  
                               wdetail.sckno       =    brstat.tlt.comp_sck                                                                     /*�Ţ���ʵ������          */  
                               wdetail.not_code    =    brstat.tlt.comp_usr_tlt                                                                 /*���ʼ����               */  
                               wdetail.remark      =    brstat.tlt.filler2                                                                      /*�����˵�                  */  
                               wdetail.not_date    =    string(brstat.tlt.datesent,"99/99/9999")                                               /*�ѹ����Ѻ��             */             
                               wdetail.not_office  =    brstat.tlt.nor_usr_tlt                                                                  /*���ͻ�Сѹ���             */  
                               wdetail.not_name    =    brstat.tlt.nor_usr_ins                                                                  /*�����                   */  
                               wdetail.brand       =    brstat.tlt.brand                                                                        /*������                    */  
                               wdetail.Brand_Model =    brstat.tlt.model                                                                        /*���                      */  
                               wdetail.yrmanu      =    brstat.tlt.lince2                                                                       /*��                        */  
                               wdetail.weight      =    string(brstat.tlt.cc_weight)                                                            /*��Ҵ����ͧ               */  
                               wdetail.engine      =    brstat.tlt.eng_no                                                                       /*�Ţ����ͧ                */  
                               wdetail.chassis     =    brstat.tlt.cha_no                                                                       /*�Ţ�ѧ                    */  
                               wdetail.pattern     =    brstat.tlt.old_cha                                                                      /*Pattern Rate              */  
                               wdetail.covcod      =    brstat.tlt.expousr                                                                      /*��������Сѹ              */  
                               wdetail.vehuse      =    brstat.tlt.old_eng                                                                      /*������ö                  */  
                               /*wdetail.garage      =    IF trim(brstat.tlt.stat) = "�������" THEN "G" ELSE ""  */ /*A60-0383*/                /*ʶҹ������               */  
                               wdetail.garage      =    IF trim(brstat.tlt.expousr) = "1" AND trim(brstat.tlt.stat) = "������ҧ" THEN "G" ELSE ""       /*A60-0383*/
                               wdetail.drivename1  =    IF LENGTH(brstat.tlt.dri_name1) <> 0  THEN SUBSTR(brstat.tlt.dri_name1,1,60)  ELSE ""   /*�кؼ��Ѻ���1            */  
                               wdetail.driveid1    =    IF length(brstat.tlt.dri_name1) > 60 THEN SUBSTR(brstat.tlt.dri_name1,61,20)  ELSE ""   /*�Ţ���㺢Ѻ���1           */  
                               wdetail.driveic1    =    IF length(brstat.tlt.dri_name1) > 80 THEN SUBSTR(brstat.tlt.dri_name1,81,20)  ELSE ""   /*�Ţ���ѵû�ЪҪ�1        */  
                               wdetail.drivedate1  =    brstat.tlt.dri_no1                                                                      /*�ѹ��͹���Դ1           */      
                               wdetail.drivname2   =    IF LENGTH(brstat.tlt.dri_name2) <> 0  THEN SUBSTR(brstat.tlt.dri_name2,1,60)  else ""   /*�кؼ��Ѻ���2            */  
                               wdetail.driveid2    =    IF length(brstat.tlt.dri_name2) > 60 THEN SUBSTR(brstat.tlt.dri_name2,61,20)  else ""   /*�Ţ���㺢Ѻ���2           */  
                               wdetail.driveic2    =    IF length(brstat.tlt.dri_name2) > 80 THEN SUBSTR(brstat.tlt.dri_name2,81,20)  else ""   /*�Ţ���ѵû�ЪҪ�2        */  
                               wdetail.drivedate2  =    brstat.tlt.dri_no2                                                                      /*�ѹ��͹���Դ2           */      
                               wdetail.cl          =    STRING(brstat.tlt.endno)                                                                /*��ǹŴ����ѵ�����         */  
                               wdetail.fleetper    =    STRING(brstat.tlt.lotno)                                                                /*��ǹŴ�����               */  
                               wdetail.ncbper      =    string(brstat.tlt.seqno)                                                                /*����ѵԴ�                 */  
                               wdetail.othper      =    string(brstat.tlt.endcnt)                                                               /*��� �                    */  
                               wdetail.addr1       =    brstat.tlt.ins_addr1                                                                    /*��������١���             */  
                               wdetail.addr2       =    brstat.tlt.ins_addr2                                                                    /*��������١���             */  
                               wdetail.addr3       =    brstat.tlt.ins_addr3                                                                    /*��������١���             */  
                               wdetail.addr4       =    brstat.tlt.ins_addr4                                                                    /*��������١���             */  
                               wdetail.icno        =    "" /*brstat.tlt.ins_addr5*/                                                             /*IDCARD                    */  
                               wdetail.icno_st     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_S                */  
                               wdetail.icno_ex     =    "" /*brstat.tlt.ins_addr5*/                                                             /*DateCARD_E                */  
                               wdetail.paid        =    brstat.tlt.safe3                                                                        /*Type_Paid_1               */  
                               wdetail.pol_typ     =    substr(brstat.tlt.subins,2,2)                                                                       /*������ ��.                */  
                               wdetail.agent       =    brstat.tlt.comp_noti_ins                                                                /*agent                     */  
                               wdetail.producer    =    brstat.tlt.comp_sub                                                                     /*producer                  */
                               wdetail.pass        =    "Y"
                               wdetail.campaign    =    brstat.tlt.rec_addr2. /*A60-0383*/   /*campaign*/                           
                               IF wdetail.icno = "" THEN DO:
                                   ASSIGN n_length            = 0
                                          n_addr5             = ""
                                          n_exp               = ""
                                          n_com               = ""
                                          n_ic                = ""
                                          n_addr5             = TRIM(brstat.tlt.ins_addr5)
                                          n_length            = LENGTH(n_addr5)                                   
                                          n_exp               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Exp:") + 4,n_length)  
                                          n_addr5             = SUBSTR(n_addr5,1,R-INDEX(n_addr5," "))             
                                          n_length            = LENGTH(n_addr5)                                     
                                          n_com               = SUBSTR(n_addr5,R-INDEX(n_addr5,"Comm:") + 5,n_length)
                                          /*n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 6) */ /*a60-0383*/
                                          n_ic                = SUBSTR(n_addr5,1 + 3,R-INDEX(n_addr5,"Comm:") - 5)      /*A60-0383*/
                                          wdetail.icno        = TRIM(n_ic)
                                          wdetail.icno_st     = IF trim(n_com) <> "" THEN SUBSTR(n_com,7,2) + "/" + SUBSTR(n_com,5,2) + "/" + SUBSTR(n_com,1,4) ELSE ""
                                          wdetail.icno_ex     = IF trim(n_exp) <> "" THEN SUBSTR(n_exp,7,2) + "/" + SUBSTR(n_exp,5,2) + "/" + SUBSTR(n_exp,1,4) ELSE "".
                               END.
                               /*A60-0383*/
                                IF      trim(wdetail.pol_title) = "���"     THEN ASSIGN  wdetail.pol_title = "�س".
                                ELSE IF trim(wdetail.pol_title) = "�ҧ"     THEN ASSIGN  wdetail.pol_title = "�س".
                                ELSE IF trim(wdetail.pol_title) = "�.�."    THEN ASSIGN  wdetail.pol_title = "�س".
                                ELSE IF trim(wdetail.pol_title) = "�ҧ���"  THEN ASSIGN  wdetail.pol_title = "�س".
                                /* end A60-0383*/
                         END.
                         RUN proc_chkdata. 
                       END.
                       ELSE IF brstat.tlt.releas = "YES" THEN DO:
                            IF brstat.tlt.recac = "" THEN                             
                                ASSIGN brstat.tlt.recac = "������������"             
                                       /*brstat.tlt.dat_ins_noti =  DATE(wrec.paydate) */ /*A60-0383*/
                                       brstat.tlt.dat_ins_noti =  TODAY  /*A60-0383*/
                                       wrec.remark =  IF brstat.tlt.subins = "V70" THEN wrec.remark + "COMPLETE/�͡������������� " + brstat.tlt.nor_noti_ins 
                                                      ELSE wrec.remark + "COMPLETE/�͡������������� " + brstat.tlt.comp_pol. 
                            ELSE ASSIGN wrec.remark = IF brstat.tlt.subins = "V70" THEN  wrec.remark + "�͡������������� " + brstat.tlt.nor_noti_ins 
                                                      ELSE wrec.remark +  "�͡������������� " + brstat.tlt.comp_pol.
                       END.
                       ELSE IF INDEX(brstat.tlt.releas,"Cancel") <> 0 THEN wrec.remark = wrec.remark + "�ա��¡��ԡ�Ţ����Ѻ�駹������ ".
                    END.
                    /*ELSE ASSIGN wrec.remark = "Not Complete" .*/
                    ELSE ASSIGN wrec.remark = wrec.remark + "��辺������㹶ѧ�ѡ " .
                    RELEASE brstat.tlt.
        END.
    END.
IF NOT CONNECTED("sic_exp")  THEN RUN proc_sic_exp.
/*IF CONNECTED("sic_exp") AND nv_type = "V70" THEN RUN wgw\wgwtnchk1.*/ /*A60-0545*/
IF CONNECTED("sic_exp") THEN RUN wgw\wgwtnchk1. /*A60-0545*/
Run Pro_reportreceipt.
Message "Export data Complete"  View-as alert-box.*/
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
/* comment by A59-0471
DEF VAR np_expdat AS CHAR FORMAT "x(15)".
DEF VAR np_year AS INT INIT 0.
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|"        
           wdetail.pol_typ          
           wdetail.policy           
           wdetail.Account_no       
           wdetail.prev_pol         
           wdetail.comp             
           wdetail.comdat           
           wdetail.expdat           
           wdetail.pol_title        
           wdetail.pol_fname        
           wdetail.name2            
           wdetail.addr1            
           wdetail.addr2            
           wdetail.addr3            
           wdetail.addr4            
           wdetail.Prempa           
           wdetail.class            
           wdetail.Brand            
           wdetail.brand_Model      
           wdetail.Weight           
           wdetail.ton              
           wdetail.vehgrp           
           wdetail.Seat             
           wdetail.Body             
           wdetail.licence          
           wdetail.province         
           wdetail.engine           
           wdetail.chassis          
           wdetail.yrmanu           
           wdetail.vehuse           
           wdetail.garage           
           wdetail.sckno            
           wdetail.covcod           
           wdetail.ins_amt          
           wdetail.prem1            
           wdetail.comp_prm         
           wdetail.gross_prm        
           wdetail.ben_name         
           wdetail.drivename        
           wdetail.drivename1       
           wdetail.drivedate1       
           wdetail.age1             
           wdetail.drivname2        
           wdetail.drivedate2       
           wdetail.age1             
           wdetail.redbook          
           wdetail.not_name         
           wdetail.bandet           
           wdetail.not_date         
           wdetail.pattern          
           wdetail.branch_safe      
           wdetail.vatcode          
           wdetail.Pro_off          
           wdetail.remark           
           wdetail.icno 
           wdetail.Finit_code                  
           wdetail.CODE_Rebate.
        IF INDEX(wdetail.pol_typ,"Type")   <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.pol_typ,"�Ţ���") <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.pol_typ   = "" THEN  DELETE wdetail.
    END.
    FOR EACH wdetail .
       IF wdetail.pol_typ  = "" THEN DELETE wdetail.
       ELSE DO:
           IF wdetail.pol_typ = "70" THEN DO:
               /* ASSIGN np_year   = 0
                       np_year   = (YEAR(DATE(wdetail.expdat)) - 543 )
                       wdetail.expdat = SUBSTR(wdetail.expdat,1,R-INDEX(wdetail.expdat,"/")) + STRING(np_year).*/
                FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING.
                  IF sicuw.uwm100.poltyp <> "V70" THEN NEXT.
                  ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                  ELSE DO:
                    ASSIGN np_expdat = ""
                           np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                          IF DATE(np_expdat) = DATE(wdetail.expdat) THEN DO:
                              ASSIGN  wdetail.policy  = sicuw.uwm100.policy.
                              FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                                  brstat.tlt.cha_no  =  trim(wdetail.chassis) AND              
                                  brstat.tlt.genusr  =  "THANACHAT"           AND
                                  brstat.tlt.subins  =  "V70"                 /*AND
                                  brstat.tlt.releas  =  "NO"   */               NO-ERROR NO-WAIT.     
                                  IF AVAIL brstat.tlt THEN DO:
                                      ASSIGN brstat.tlt.releas = "YES".
                                      IF brstat.tlt.nor_noti_ins = ""  THEN ASSIGN brstat.tlt.nor_noti_ins = wdetail.policy.
                                  END.
                                  RELEASE brstat.tlt.
                          END.
                          ELSE ASSIGN wdetail.policy  = "".
                  END.
               END.
               RELEASE sicuw.uwm100.
           END.
           IF wdetail.pol_typ = "72" THEN DO:
                 /* ASSIGN np_year  = 0
                         np_year  = (YEAR(DATE(wdetail.expdat)) - 543 )
                         wdetail.expdat = SUBSTR(wdetail.expdat,1,R-INDEX(wdetail.expdat,"/")) + STRING(np_year).*/
                  FOR EACH sicuw.uwm100 USE-INDEX uwm10002 WHERE sicuw.uwm100.cedpol = trim(wdetail.Account_no) NO-LOCK BREAK BY sicuw.uwm100.expdat DESCENDING. 
                        IF sicuw.uwm100.poltyp <> "V72" THEN NEXT.
                        ELSE IF YEAR(sicuw.uwm100.expdat) <= YEAR(TODAY)  THEN NEXT.
                        ELSE DO:
                            ASSIGN np_expdat = ""
                                   np_expdat = STRING(sicuw.uwm100.expdat,"99/99/9999").
                            IF DATE(np_expdat) = DATE(wdetail.expdat) THEN DO:
                                ASSIGN  wdetail.policy  = sicuw.uwm100.policy.
                                FIND LAST brstat.tlt USE-INDEX tlt05  WHERE   
                                    brstat.tlt.cha_no  =  trim(wdetail.chassis) AND              
                                    brstat.tlt.genusr  =  "THANACHAT"           AND
                                    brstat.tlt.subins  =  "V72"                 /*AND
                                    brstat.tlt.releas  =  "NO" */                 NO-ERROR NO-WAIT.     
                                    IF AVAIL brstat.tlt THEN DO:
                                        ASSIGN brstat.tlt.releas = "YES".
                                        IF brstat.tlt.comp_pol     = ""  THEN ASSIGN brstat.tlt.comp_pol  = wdetail.policy.
                                    END.
                                    RELEASE brstat.tlt.
                            END.
                            ELSE ASSIGN wdetail.policy = "".
                        END.
                 END.
                 RELEASE sicuw.uwm100.
           END.
       END. /* else do */
    END. /*wdetail */
Run Pro_reportpolicy.
Message "Export data Complete"  View-as alert-box.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol3 C-Win 
PROCEDURE proc_impmatpol3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_branch AS CHAR.                   /*A60-0383*/
DEF VAR n_accno  AS CHAR FORMAT "x(15)".    /*A60-0383*/
DEF VAR n_length AS INT.
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wcancel.
          IMPORT DELIMITER "|" 
               wcancel.n_no                 /*�ӴѺ */                  /*A60-0383*/
               wcancel.Notify_end         /* �Ţ�����ѡ��ѧ    */                     
               wcancel.Notify_no          /*�Ţ����Ѻ��      */                     
               wcancel.enddate           /*�ѹ������ѡ��ѧ   */ 
               wcancel.notidate           /*�ѹ����駧ҹ */             /*a60-0383*/
               wcancel.pol_no             /*�Ţ����������/�ú.*/                     
               wcancel.licence            /*����¹            */                     
               wcancel.province           /*�ѧ��Ѵ            */                     
               wcancel.Account_no         /*�Ң�-�Ţ������   */                     
               wcancel.ins_name           /*���ͼ����һ�Сѹ   */                     
               wcancel.typ_end            /*��Ǣ�ͷ�����     */                     
               wcancel.ctype              /*��������ѡ��ѧ     */                     
               wcancel.olddata            /*���������         */                     
               wcancel.newdata            /*����������         */                     
               wcancel.remark_main        /*�˵ؼ���ѡ         */                     
               wcancel.remark_sub         /*�˵ؼ�����         */                     
               wcancel.payby              /*������            */                     
               wcancel.nbank              /*��Ҥ��             */                     
               wcancel.paydate            /*�ѹ����١����Ѻ�������¤����ش����*/    
               wcancel.remark             /*�����˵�           */                     
               wcancel.cust_date   .      /*�ѹ����Ѻ��������  */                    
          IF INDEX(wcancel.Notify_end,"�Ţ���") <> 0 THEN DELETE wcancel.
          ELSE IF INDEX(wcancel.Notify_end,"�ӴѺ") <> 0 THEN DELETE wcancel. /*60-0383*/
          ELSE IF wcancel.Notify_end = "" THEN DELETE wcancel.
    END.   /* repeat  */
    FOR EACH wcancel .
        IF wcancel.Notify_end  = "" THEN DELETE wcancel.
        ELSE DO:
            ASSIGN   nv_type   = ""     n_length = 0
                     n_branch  = ""     n_accno  = "" . /*A60-0383*/

            IF INDEX(wcancel.ctype,"�ú") <> 0 THEN ASSIGN nv_type = "V72".
            ELSE ASSIGN nv_type = "V70".
            /* Create by A60-0383 */
            IF wcancel.Account_no <> "" THEN DO:
               IF INDEX(wcancel.account_no,"-") <> 0 THEN ASSIGN n_accno  = REPLACE(wcancel.account_no,"-","").
               ELSE ASSIGN n_accno  = TRIM(wcancel.account_no).
            END.
            /* comment by A59-0471.....
            IF wcancel.ins_name <> "" THEN DO:
                ASSIGN  n_length = LENGTH(wcancel.ins_name)
                        nv_name  = SUBSTR(TRIM(wcancel.ins_name),INDEX(wcancel.ins_name," ") + 1,n_length).
            END.
            ...end A59-0471...*/
            /* comment by A60-0383 ..........
            IF wcancel.pol_no <> "" THEN DO:
                IF INDEX(wcancel.pol_no,"-") <> 0 THEN ASSIGN wcancel.pol_no = REPLACE(wcancel.pol_no,"-","").
                IF INDEX(wcancel.pol_no,"/") <> 0 THEN ASSIGN wcancel.pol_no = REPLACE(wcancel.pol_no,"/","").
            END.
            .... end A60-0383...*/
            FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
                      brstat.tlt.datesent     <> ?   AND              
                      brstat.tlt.nor_noti_tlt = TRIM(wcancel.Notify_no)  AND  /*�Ţ�Ѻ��*/ 
                      /*brstat.tlt.ins_name   = TRIM(nv_name)            AND  /*���� */ --A59-0471--*/
                      brstat.tlt.genusr       = "THANACHAT"              AND 
                      brstat.tlt.subins       = TRIM(nv_type)            AND  /*type*/
                      brstat.tlt.safe2        = trim(n_accno)            NO-ERROR NO-WAIT.  /*A60-0383*/
                      /*(brstat.tlt.nor_noti_ins = TRIM(wcancel.pol_no)     OR*/                              /*a60-0383*/
                      /* brstat.tlt.comp_pol     = TRIM(wcancel.pol_no)) NO-ERROR NO-WAIT.*/   /*������*/   /*a60-0383*/
                    IF AVAIL brstat.tlt THEN DO:
                       IF brstat.tlt.releas = "NO" THEN 
                           ASSIGN brstat.tlt.releas = "Cancel/No"
                                  brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                        wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " +
                                                        wcancel.remark_sub + " " + wcancel.remark                                 
                                  wcancel.datastatus = "Complete".
                       ELSE IF brstat.tlt.releas = "YES" THEN 
                           ASSIGN brstat.tlt.releas = "Cancel/Yes"
                                  brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                        wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " + 
                                                        wcancel.remark_sub + " " + wcancel.remark 
                                  wcancel.datastatus = "Complete".
                       ELSE IF index(brstat.tlt.releas,"Cancel") <> 0  THEN
                           ASSIGN wcancel.datastatus = "�ա��¡��ԡ�����".
                       /*-- A59-0471 ---*/
                       ELSE IF INDEX(brstat.tlt.releas,"No_Confirm") <> 0 THEN
                           ASSIGN wcancel.datastatus = "�ա�� Match No_Confirm ����"
                                  brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " +       /*A60-0383*/
                                                        wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " +     /*A60-0383*/
                                                        wcancel.remark_sub + " " + wcancel.remark .                                      /*A60-0383*/
                       /*-- end. A59-0471 ---*/
                    END.
                    ELSE ASSIGN wcancel.datastatus = "��辺������".
                    RELEASE brstat.tlt.
        END.
    END.
    RUN proc_reportcancel.
    Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_impmatpol4 C-Win 
PROCEDURE proc_impmatpol4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A59-0471     
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fi_loadname) .  /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|"  
            wdetail.pol_typ
            wdetail.Pro_off
            wdetail.notify_no 
            wdetail.branch
            wdetail.Account_no
            wdetail.prev_pol
            wdetail.policy
            wdetail.comp
            wdetail.pol_title
            wdetail.pol_fname
            wdetail.ben_name
            wdetail.comdat
            wdetail.expdat
            wdetail.comdat72
            wdetail.expdat72
            wdetail.licence
            wdetail.province
            wdetail.ins_amt
            wdetail.prem1
            wdetail.comp_prm
            wdetail.gross_prm
            wdetail.compno
            wdetail.sckno
            wdetail.not_code
            wdetail.remark
            wdetail.not_date
            wdetail.company
            wdetail.not_name
            wdetail.Brand
            wdetail.brand_Model
            wdetail.yrmanu
            wdetail.Weight
            wdetail.engine
            wdetail.chassis
            wdetail.pattern
            wdetail.covcod
            wdetail.vehuse
            wdetail.garage
            wdetail.drivename1
            wdetail.driveid1   
            wdetail.driveic1   
            wdetail.drivedate1 
            wdetail.drivname2  
            wdetail.driveid2   
            wdetail.driveic2   
            wdetail.drivedate2 
            wdetail.cl        
            wdetail.fleetper  
            wdetail.ncbper    
            wdetail.othper    
            wdetail.addr1
            wdetail.addr2
            wdetail.addr3
            wdetail.addr4
            wdetail.icno     
            wdetail.icno_st  
            wdetail.icno_ex  
            wdetail.paid.     
        IF INDEX(wdetail.pol_typ,"Export")   <> 0 THEN  DELETE wdetail.
        ELSE IF INDEX(wdetail.pol_typ,"������") <> 0 THEN  DELETE wdetail.
        ELSE IF  wdetail.pol_typ   = "" THEN  DELETE wdetail.
    END.
    FOR EACH wdetail .
       IF wdetail.pol_typ  = "" THEN DELETE wdetail.
       ELSE DO:
         /*IF wdetail.pol_fname <> "" THEN DO:
            ASSIGN  n_length = LENGTH(wdetail.pol_fname)
                    nv_name  = SUBSTR(TRIM(wdetail.pol_fname),INDEX(wdetail.pol_fname," ") + 1,n_length).
         END.*/
         
         FIND LAST brstat.tlt USE-INDEX tlt04  WHERE   
                   brstat.tlt.datesent     <> ?   AND              
                   brstat.tlt.nor_noti_tlt = TRIM(wdetail.notify_no)  AND  /*�Ţ�Ѻ��*/ 
                   brstat.tlt.ins_name     = TRIM(wdetail.pol_fname)            AND  /*���� */
                   brstat.tlt.genusr       = "THANACHAT"              AND 
                   brstat.tlt.subins       = TRIM(wdetail.pol_typ)    /*type*/
                   NO-ERROR NO-WAIT.   /*������*/  
                   IF AVAIL brstat.tlt THEN DO:
                      IF brstat.tlt.releas = "NO" THEN 
                          ASSIGN brstat.tlt.releas = "No_Confirm/No"
                                 /*brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                       wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " + wcancel.remark  */                               
                                 wdetail.comment = "Complete".
                      ELSE IF brstat.tlt.releas = "YES" THEN 
                          ASSIGN brstat.tlt.releas = "No_Confirm/Yes"
                                 /*brstat.tlt.filler2 =  brstat.tlt.filler2 + "/" + wcancel.typ_end + " " + wcancel.enddate + " " + 
                                                       wcancel.licence + " " + wcancel.province + " " + wcancel.remark_main + " " + wcancel.remark  */
                                 wdetail.comment = "Complete".
                      ELSE IF index(brstat.tlt.releas,"Cancel") <> 0  THEN
                          ASSIGN wdetail.comment = "�ա�� Cancel �����".
                      ELSE IF index(brstat.tlt.releas,"No_Confirm") <> 0  THEN
                          ASSIGN wdetail.comment = "����� Status No_Confirm �����".

                   END.
                   ELSE ASSIGN wdetail.comment = "��辺������".
                   RELEASE brstat.tlt.
                   END.
              
    END. /*wdetail */
Run Pro_reportnocon.
Message "Export data Complete"  View-as alert-box.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportcancel C-Win 
PROCEDURE proc_reportcancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "Report Cancel Thanachat Date : " string(TODAY)   .
EXPORT DELIMITER "|"  
     " �ӴѺ                "           /*A60-03838*/
     " �Ţ�����ѡ��ѧ        "                        
     " �Ţ����Ѻ��         "                        
     " �ѹ������ѡ��ѧ      " 
     " �ѹ����駧ҹ         "          /*A60-03838*/
     " �Ţ����������/�ú.   "                        
     " ����¹               "                        
     " �ѧ��Ѵ               "                        
     " �Ң�-�Ţ����ѭ��      "                        
     " ���ͼ����һ�Сѹ      "                        
     " ��Ǣ�ͷ�����        "                        
     " ��������ѡ��ѧ        "                        
     " ���������            "                        
     " ����������            "                        
     " �˵ؼ���ѡ            "                        
     " �˵ؼ�����            "                        
     " ������               "                        
     " ��Ҥ��                "                        
     " �ѹ����١����Ѻ�������¤����ش���� "       
     " �����˵�           "                        
     " �ѹ����Ѻ��������  " 
     " �����š��¡��ԡ "  .
FOR EACH wcancel   no-lock.
    EXPORT DELIMITER "|" 
        wcancel.n_no            /*A60-03838*/
        wcancel.Notify_end           
        wcancel.Notify_no            
        wcancel.enddate 
        wcancel.notidate        /*A60-03838*/
        wcancel.pol_no               
        wcancel.licence              
        wcancel.province             
        wcancel.Account_no           
        wcancel.ins_name             
        wcancel.typ_end              
        wcancel.ctype                
        wcancel.olddata              
        wcancel.newdata              
        wcancel.remark_main          
        wcancel.remark_sub           
        wcancel.payby                
        wcancel.nbank                
        wcancel.paydate              
        wcancel.remark               
        wcancel.cust_date           
        wcancel.datastatus.
END. 
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reporterror C-Win 
PROCEDURE proc_reporterror :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
DEF VAR nv_row AS INTE INIT 1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.

FOR EACH wdetail WHERE 
        wdetail.PASS = "N" NO-LOCK:
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
If  substr(fi_outload3,length(fi_outload3) - 3,4) <>  ".SLK"  THEN 
    fi_outload3  =  Trim(fi_outload3) + ".SLK"  .
    OUTPUT TO VALUE(fi_outload3).
        EXPORT DELIMITER "|"
            "Type of Policy"                                     /*1. Policy Type (70/72)*/                                                                                       
            "�Ţ����������"                                     /*2. �Ţ���������� (70)*/                     
            "�Ţ����ѭ��"                                        /*3. �Ţ����ѭ�� (�Ҩҡ�Ţ����Ѻ��)*/        
            "�Ţ��������������"                                 /*4. �Ţ����������������*/                   
            "Compulsory"                                         /*5. Check (Y/N) ��ǧ 72 �������*/             
            "�ѹ��������������ͧ"                                /*6. �ѹ��������������ͧ*/                     
            "�ѹ�������ش����������ͧ"                          /*7. �ѹ�������ش����������ͧ*/               
            "�ӹ�˹�Ҫ���"                                       /*8. �ӹ�˹�Ҫ���*/                            
            "���ͼ����һ�Сѹ"                                   /*9. ���ͼ����һ�Сѹ���*/                     
            "���/����"                                           /*10. ���/����*/                               
            "������� 1"                                          /*11. ������� 1*/                              
            "������� 2"                                          /*12. ������� 2*/                              
            "������� 3"                                          /*13. ������� 4*/                              
            "������� 4"                                          /*14. ������� 5*/                              
            "Pack"                                               /*15. Premium Pack*/                           
            "Class"                                              /*16. Class (110)*/                            
            "Brand"                                              /*17. ������ö*/                               
            "Model"                                              /*18. ���ö*/                                 
            "CC"                                                 /*19. ��Ҵ����ͧ¹��*/                        
            "Weight"                                             /*20. ���˹ѡö*/                              
            "vehgrp"                                               /* ����� */                                    
            "Seat"                                               /*21. �����*/                                
            "Body"                                               /*22. */                                       
            "����¹ö"                                          /*23. �Ţ����¹ö*/                           
            "�ѧ��Ѵ"                                            /*24. �ѧ��Ѵ*/                                
            "�Ţ����ͧ¹��"                                     /*25. �Ţ����ͧ¹��*/                         
            "�Ţ��Ƕѧ"                                          /*26. �Ţ��Ƕѧ*/                              
            "�շ���Ե"                                          /*27. �շ���Ե*/                              
            "�����������"                                       /*28. ������*/                                 
            "���������ҧ/������"                                 /*29. ������� ��ҧ(G)/������(H)*/              
            "�Ţ���ʵԡ����"                                    /*30. �Ţʵԡ����*/                           
            "����������������ͧ"                                 /*31. ����������������ͧ*/                     
            "�ع��Сѹ���"                                       /*32. �ع��Сѹ�ѹ*/                           
            "���»�Сѹ���"                                     /*33. �������*/                               
            "���� �ú. ���"                                     /*34. ���� �ú. ���*/                         
            "������� + �ú."                                    /*35. ������� �ú.*/                          
            "����Ѻ�Ż���ª��"                                   /*36. ����Ѻ�Ż���ª��*/                       
            "�кؼ��Ѻ���"                                      /*37. �кؼ��Ѻ��� (Y/N)*/                    
            "���ͼ��Ѻ��� 1"                                    /*38. ���ͼ��Ѻ��� 1*/                        
            "�ѹ/��͹/���Դ1"                                  /*39. �ѹ�Դ���Ѻ��� 1*/                     
            "���� 1"                                             /*40. ���ؼ��Ѻ��� 1*/                        
            "���ͼ��Ѻ��� 2"                                    /*38. ���ͼ��Ѻ��� 2*/                        
            "�ѹ/��͹/���Դ2"                                  /*39. �ѹ�Դ���Ѻ��� 2*/                     
            "���� 2"                                             /*40. ���ؼ��Ѻ��� 2*/                        
            "Redbook"                                            /*41. ���� redbook*/                           
            "�����"                                            /*42. ���ͼ����*/                            
            "�Ңҵ�Ҵ"                                           /*43. ��Ҵ�Ң�*/                               
            "�ѹ����Ѻ��"                                      /*44. �ѹ����Ѻ��*/                          
            "ATTERN RATE"                                        /*45. Attrate*/                                
            "Branch"                                             /*46. Branch*/                                 
            "Vat Code"                                           /*47. Vat Code*/                               
            "Text1"                                              /*48. Text �ѧ���*/                           
            "Text2"                                              /*49. Text ��Ǩ��Ҿ*/                          
            "ICNO"                                               /*50. �Ţ���ѵû�ЪҪ�*/                      
            "Comment"  .                                         /* Error */ 
        FOR EACH wdetail WHERE wdetail.pass = "N" NO-LOCK.
          EXPORT DELIMITER "|"                                              
                  wdetail.pol_typ                                                                /*1. Policy Type (70/72)*/                                 
                  wdetail.policy                                                                 /*2. �Ţ���������� (70)*/                                 
                  wdetail.Account_no                                                             /*3. �Ţ����ѭ�� (�Ҩҡ�Ţ����Ѻ��)*/                    
                  wdetail.prev_pol                                                               /*4. �Ţ����������������*/                               
                  "N"                                                                            /*5. Check (Y/N) ��ǧ 72 �������*/                         
                  IF wdetail.pol_typ = "70" THEN wdetail.comdat  ELSE wdetail.comdat72           /*6. �ѹ��������������ͧ*/                                 
                  IF wdetail.pol_typ = "70" THEN wdetail.expdat  ELSE wdetail.expdat72           /*7. �ѹ�������ش����������ͧ*/                           
                  wdetail.pol_title                                                              /*8. �ӹ�˹�Ҫ���*/                                        
                  wdetail.pol_fname                                                              /*9. ���ͼ����һ�Сѹ���*/                                 
                  ""                                                                             /*10. ���/����*/                                           
                  wdetail.addr1                                                                  /*11. ������� 1*/                                          
                  wdetail.addr2                                                                  /*12. ������� 2*/                                          
                  wdetail.addr3                                                                  /*13. ������� 4*/                                          
                  wdetail.addr4                                                                  /*14. ������� 5*/                                          
                  wdetail.Prempa                                                                 /*15. Premium Pack*/                                       
                  wdetail.class                                                                  /*16. Class (110)*/                                        
                  wdetail.Brand                                                                  /*17. ������ö*/                                           
                  wdetail.brand_Model                                                            /*18. ���ö*/                                             
                  wdetail.Weight                                                                 /*19. ��Ҵ����ͧ¹��*/                                    
                  wdetail.ton                                                                    /*20. ���˹ѡö*/                                          
                  wdetail.vehgrp                                                                 /* ����� */                       
                  wdetail.Seat                                                                   /*21. �����*/                                            
                  wdetail.Body                                                                   /*22. */                                                   
                  wdetail.licence                                                                /*23. �Ţ����¹ö*/                                       
                  wdetail.province                                                               /*24. �ѧ��Ѵ*/                                            
                  wdetail.engine                                                                 /*25. �Ţ����ͧ¹��*/                                     
                  wdetail.chassis                                                                /*26. �Ţ��Ƕѧ*/                                          
                  wdetail.yrmanu                                                                 /*27. �շ���Ե*/                                          
                  wdetail.vehuse                                                                 /*28. ������*/                                             
                  wdetail.garage                                                                 /*29. ������� ��ҧ(G)/������(H)*/                          
                  wdetail.sckno                                                                  /*30. �Ţʵԡ����*/                                       
                  wdetail.covcod                                                                 /*31. ����������������ͧ*/                                 
                  wdetail.ins_amt                                                                /*32. �ع��Сѹ�ѹ*/                                       
                  wdetail.prem1                                                                  /*33. �������*/                                           
                  wdetail.comp_prm                                                               /*34. ���� �ú. ���*/                                     
                  wdetail.gross_prm                                                              /*35. ������� �ú.*/                                      
                  wdetail.ben_name                                                               /*36. ����Ѻ�Ż���ª��*/                                   
                  wdetail.drivename                                                              /*37. �кؼ��Ѻ��� (Y/N)*/                                
                  wdetail.drivename1                                                             /*38. ���ͼ��Ѻ��� 1*/                                    
                  wdetail.drivedate1                                                             /*39. �ѹ�Դ���Ѻ��� 1*/                                 
                  ""                                                                             /*40. ���ؼ��Ѻ��� 1*/                                    
                  wdetail.drivname2                                                              /*38. ���ͼ��Ѻ��� 2*/                                    
                  wdetail.drivedate2                                                             /*39. �ѹ�Դ���Ѻ��� 2*/                                 
                  ""                                                                             /*40. ���ؼ��Ѻ��� 2*/                                    
                  wdetail.redbook                                                                /*41. ���� redbook*/                                       
                  wdetail.not_name                                                               /*42. ���ͼ����*/                                        
                  wdetail.bandet                                                                 /*43. ��Ҵ�Ң�*/                                           
                  wdetail.not_date                                                               /*44. �ѹ����Ѻ��*/                                      
                  wdetail.pattern                                                                /*45. Attrate*/                                            
                  wdetail.branch_safe                                                            /*46. Branch*/                                             
                  wdetail.vatcode                                                                /*47. Vat Code*/                                           
                  wdetail.Pro_off                                                                /*48. Text �ѧ���*/                                       
                  wdetail.remark                                                                 /*49. Text ��Ǩ��Ҿ*/                                      
                  wdetail.icno                                                                   /*50. �Ţ���ѵû�ЪҪ�*/           
                  wdetail.comment.                                                               /* Error */
        END.
    OUTPUT CLOSE.
END. /*pass > 0*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportloadgw C-Win 
PROCEDURE proc_reportloadgw :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(fi_outload2,length(fi_outload2) - 3,4) <>  ".CSV"  THEN 
    fi_outload2  =  Trim(fi_outload2) + ".CSV"  .
ASSIGN nv_cnt =  0
       nv_row  =  1.
OUTPUT TO VALUE(fi_outload2).
EXPORT DELIMITER "|" 
    "Type of Policy"     
    "�Ţ����������"     
    "�Ţ����ѭ��"        
    "�Ţ��������������" 
    "Compulsory"         
    "�ѹ��������������ͧ"
    "�ѹ�������ش����������ͧ"
    "�ӹ�˹�Ҫ���"       
    "���ͼ����һ�Сѹ"   
    "���/����"           
    "������� 1"          
    "������� 2"          
    "������� 3"          
    "������� 4"          
    "Pack"               
    "Class"              
    "Brand"              
    "Model"              
    "CC"                 
    "Weight"             
    "vehgrp"             
    "Seat"               
    "Body"               
    "����¹ö"          
    "�ѧ��Ѵ"            
    "�Ţ����ͧ¹��"     
    "�Ţ��Ƕѧ"          
    "�շ���Ե"          
    "�����������"       
    "���������ҧ/������" 
    "�Ţ���ʵԡ����"    
    "����������������ͧ" 
    "�ع��Сѹ���"       
    "���»�Сѹ���"     
    "���� �ú. ���"     
    "������� + �ú."    
    "����Ѻ�Ż���ª��"   
    "�кؼ��Ѻ���"      
    "���ͼ��Ѻ��� 1"    
    "�ѹ/��͹/���Դ1" 
    "�Ţ���ѵ� ���. 1 "  /*A60-0545*/
    "�Ţ���㺢Ѻ��� 1 "   /*A60-0545*/
    "���� 1"             
    "���ͼ��Ѻ��� 2"    
    "�ѹ/��͹/���Դ2" 
    "�Ţ���ѵ� ���. 2 " /*A60-0545*/ 
    "�Ţ���㺢Ѻ��� 2 "  /*A60-0545*/ 
    "���� 2"             
    "Redbook"            
    "�����"            
    "�Ңҵ�Ҵ"           
    "�ѹ����Ѻ��"      
    "ATTERN RATE"        
    "Branch"             
    "Vat Code"           
    "Text1"              
    "Text2"              
    "ICNO" 
    "Finit Code"                  
    "Code Rebate"
    "Agent    "          /*A60-0383*/
    "Producer "          /*A60-0383*/
    "Campaign "         /*A60-0383*/
    "���͡������"       /*A60-0545*/
    "�Ţ����Ǩ��Ҿ"                 /* A61-0512*/ 
    "��������è��� "                 /* A61-0512*/ 
    "�ѹ������"                     /* A61-0512*/ 
    "�ѹ������������Թ�ú"       /* A61-0512*/ 
    "�Ҫվ"       /*A66-0160*/
    "��ö"        /*A66-0160*/
    "ACCESSORY" .

FOR EACH wdetail WHERE wdetail.pass <> "N" NO-LOCK.
     nv_row  =  nv_row + 1.
    EXPORT DELIMITER "|" 
     wdetail.pol_typ                                                                         
     wdetail.policy                                                                          
     wdetail.Account_no                                                                      
     wdetail.prev_pol                                                                        
     IF wdetail.pol_typ = "70" THEN "N"   ELSE "Y"                                                                                          
     IF wdetail.pol_typ = "70" THEN wdetail.comdat  ELSE wdetail.comdat72                            
     IF wdetail.pol_typ = "70" THEN wdetail.expdat  ELSE wdetail.expdat72                            
     wdetail.pol_title                                                                               
     wdetail.pol_fname                                                                               
     ""                                                                                              
     wdetail.addr1                                                                                   
     wdetail.addr2                                                                                   
     wdetail.addr3                                                                                   
     wdetail.addr4                                                                                   
     wdetail.Prempa                                                                                  
     wdetail.class                                                                                   
     wdetail.Brand                                                                                   
     wdetail.brand_Model                                                                             
     wdetail.Weight                                                                                  
     wdetail.ton                                                                                     
     wdetail.vehgrp                                                                                  
     wdetail.Seat                                                                                    
     wdetail.Body                                                                                    
     wdetail.licence                                                                                 
     wdetail.province                                                                                
     wdetail.engine                                                                                  
     wdetail.chassis                                                                                 
     wdetail.yrmanu                                                                                  
     wdetail.vehuse                                                                                  
     wdetail.garage                                                                                  
     wdetail.sckno                                                                                   
     wdetail.covcod                                                                                  
     wdetail.ins_amt                                                                                 
     wdetail.prem1                                                                                   
     wdetail.comp_prm                                                                                
     wdetail.gross_prm                                                                               
     wdetail.ben_name                                                                                
     wdetail.drivename                                                                               
     wdetail.drivename1                                                                              
     wdetail.drivedate1 
     wdetail.driveic1   /*A60-0545*/
     wdetail.driveid1   /*A60-0545*/
     ""                                                                                              
     wdetail.drivname2                                                                               
     wdetail.drivedate2 
     wdetail.driveic2   /*A60-0545*/ 
     wdetail.driveid2   /*A60-0545*/ 
     ""                                                                                              
     wdetail.redbook                                                                                 
     wdetail.not_name                                                                                
     wdetail.bandet                                                                                  
     wdetail.not_date                                                                                
     wdetail.pattern                                                                                 
     wdetail.branch_safe                                                                             
     wdetail.vatcode                                                                                 
     wdetail.Pro_off                                                                                 
     wdetail.remark                                                                                  
     wdetail.icno 
     ""
     ""
     wdetail.agent      /*A60-0383*/
     wdetail.producer   /*A60-0383*/
     wdetail.campaign  /*A60-0383*/   
     ""
     wdetail.ispno      /* A61-0512*/
     wdetail.typ_paid   /* A61-0512*/
     wdetail.paid_date  /* A61-0512*/
     wdetail.conf_date  /* A61-0512*/
     ""                 /*A66-0160*/
     wdetail.ncolor     /*A66-0160*/
     wdetail.ACCESSORY.
END.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp C-Win 
PROCEDURE proc_sic_exp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  create by Ranu i. A60-0383     
------------------------------------------------------------------------------*/
FORM
    gv_id  LABEL " User Id " colon 35 SKIP
    nv_pwd LABEL " Password" colon 35 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
    TITLE   " Connect DB Expiry System"  . 
STATUS INPUT OFF.
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

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
      CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.
     /* CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*//*Comment A62-0105*/
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
      /*CONNECT expiry -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/
      IF NOT CONNECTED("sic_exp") THEN DO:
         MESSAGE "Not Connect DB Expiry ld sic_exp".
         NEXT-PROMPT gv_id WITH FRAME nf00.
         NEXT.
      END. 
      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

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

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_reportnocon C-Win 
PROCEDURE pro_reportnocon :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A59-0471     
------------------------------------------------------------------------------*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "Report Match File No Confirm Thanachat Date: "  string(TODAY)   .
EXPORT DELIMITER "|" 
   " ��������������          "
   " �Ţ����Ѻ������Ң�    "
   " �Ţ����Ѻ��           "
   " �Ң�                    "
   " �Ţ����ѭ��             "
   " �Ţ�������������      "
   " �Ţ��������������      "
   " ����ѷ��Сѹ���        "
   " �ӹ�˹�Ҫ���            "
   " ���ͼ����һ�Сѹ���     "
   " ����Ѻ�Ż���ª��        "
   " �ѹ��������������ͧ     "
   " �ѹ�������ش������ͧ   "
   " �ѹ�������������ͧ�ú   "
   " �ѹ�������ش������ͧ�ú"
   " �Ţ����¹              "
   " �ѧ��Ѵ                 "
   " �ع��Сѹ               "
   " ���»�Сѹ���          "
   " ���¾ú���             "
   " �������                "
   " �Ţ��������ú          "
   " �Ţ���ʵ������        "
   " ���ʼ����             "
   " �����˵�                "
   " �ѹ����Ѻ��           "
   " ���ͻ�Сѹ���           "
   " �����                 "
   " ������                  "
   " ���                    "
   " ��                      "
   " ��Ҵ����ͧ             "
   " �Ţ����ͧ              "
   " �Ţ�ѧ                  "
   " Pattern Rate            "
   " ��������Сѹ            "
   " ������ö                "
   " ʶҹ������             "
   " �����˵�                ".
FOR EACH wdetail no-lock.
  EXPORT DELIMITER "|" 
      wdetail.pol_typ          
      wdetail.Pro_off        
      wdetail.notify_no      
      wdetail.branch         
      wdetail.Account_no     
      wdetail.prev_pol       
      wdetail.policy         
      wdetail.comp           
      wdetail.pol_title      
      wdetail.pol_fname      
      wdetail.ben_name       
      wdetail.comdat         
      wdetail.expdat         
      wdetail.comdat72       
      wdetail.expdat72       
      wdetail.licence        
      wdetail.province       
      wdetail.ins_amt        
      wdetail.prem1          
      wdetail.comp_prm       
      wdetail.gross_prm      
      wdetail.compno         
      wdetail.sckno          
      wdetail.not_code       
      wdetail.remark         
      wdetail.not_date       
      wdetail.company        
      wdetail.not_name       
      wdetail.Brand          
      wdetail.brand_Model    
      wdetail.yrmanu         
      wdetail.Weight         
      wdetail.engine         
      wdetail.chassis        
      wdetail.pattern        
      wdetail.covcod         
      wdetail.vehuse         
      wdetail.garage 
      wdetail.comment.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportpolicy C-Win 
PROCEDURE Pro_reportpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : A59-0471
DEF VAR pol72 AS CHAR FORMAT "x(12)" INIT "" .   /*A56-0323*/
If  substr(fi_outload,length(fi_outload) - 3,4) <>  ".slk"  THEN 
    fi_outload  =  Trim(fi_outload) + ".slk"  .
ASSIGN nv_cnt =  0
    nv_row  =  1.
OUTPUT TO VALUE(fi_outload).
EXPORT DELIMITER "|" 
    "Report Match policy Thanachat(RENEW) Date: "  string(TODAY)   .
EXPORT DELIMITER "|" 
      "Policy NEW "             
      "�Ţ����ѭ��"                     
      "Policy Renew"                    
      "Policy Type"                 
      "Com. Date"                   
      "Exp. Date"                       
      "Title Name"                      
      "Insure name"                     
      "���/����"                        
      "����稻�Сѹ"                   
      "����� �ú."                    
      "Address1"                        
      "Address2"                        
      "Address3"                        
      "Address4"                        
      "Package"                         
      "Class"                           
      "Brand"                       
      "Model"                           
      "CC"                              
      "Weigth"                          
      "Seat"                            
      "Body"                            
      "�Ţ����¹ö"                    
      "�ѧ��Ѵ"                         
      "Engine No."                      
      "Chaiss No."                      
      "Car Year"                        
      "Veh.Use"                         
      "Garage"                          
      "Sticker"                         
      "Cover Code"                      
      "IS"                              
      "Premium Total"                   
      "Premium Compulsory"              
      "Total"                           
      "Bennifit Name"                   
      "Driver Name [Y/N]"               
      "Driver Name1"                    
      "Birthday1"                       
      "Age1"                            
      "Driver Name2"                    
      "Birthday2"                       
      "Age2"                            
      "Redbook No."                     
      "Opnpol"                          
      "Branch Market"                   
      "Date"                            
      "Att.Rate"                        
      "Branch"                          
      "Vat Code"                        
      "Text1"                       
      "Text2"                       
      "ICNO"                        
      "Finit Code"                  
      "Code Rebate".     
FOR EACH wdetail no-lock.
  EXPORT DELIMITER "|" 
      wdetail.policy                    /*Policy NEW */   
      wdetail.Account_no                /*�Ţ����ѭ��  */                                                           
      wdetail.prev_pol                  /*Policy Renew */                                                           
      wdetail.pol_typ                   /*Policy Type  */                                                           
      wdetail.comdat                    /*Com. Date    */     
      wdetail.expdat                    /*Exp. Date    */             
      wdetail.pol_title                 /*Title Name   */                                                                   
      wdetail.pol_fname                 /*Insure name  */                                                                   
      wdetail.name2                     /*���/����     */     
      ""                                /*����稻�Сѹ*/     
      ""                                /*����� �ú. */     
      wdetail.addr1                     /*Address1     */                                                                   
      wdetail.addr2                     /*Address2     */                                                                   
      wdetail.addr3                     /*Address3     */                                                                   
      wdetail.addr4                     /*Address4     */                                                                   
      wdetail.Prempa                    /*Package      */                                                                   
      wdetail.class                     /*Class        */                                                                   
      wdetail.Brand                     /*Brand        */                                                                   
      wdetail.brand_Model               /*Model        */                                                                   
      wdetail.Weight                    /*CC           */                                                                   
      wdetail.ton                       /*Weigth       */                                                                   
      wdetail.Seat                      /*Seat         */                                                                   
      wdetail.Body                      /*Body         */                                                                   
      wdetail.licence                   /*�Ţ����¹ö */                                                                   
      wdetail.province                  /*�ѧ��Ѵ      */                                                                   
      wdetail.engine                    /*Engine No.   */                                                                   
      wdetail.chassis                   /*Chaiss No.   */                                                                   
      wdetail.yrmanu                    /*Car Year     */                                                                   
      wdetail.vehuse                    /*Veh.Use      */                                                                   
      wdetail.garage                    /*Garage       */                                                                   
      wdetail.sckno                     /*Sticker      */                                                                   
      wdetail.covcod                    /*Cover Code   */                                                                   
      wdetail.ins_amt                   /*IS           */                                                                   
      wdetail.prem1                     /*Premium Total*/                                                                   
      wdetail.comp_prm                  /*Premium Compulsory*/                                                              
      wdetail.gross_prm                 /*Total             */                                                              
      wdetail.ben_name                  /*Bennifit Name     */                                                              
      wdetail.drivename                 /*Driver Name [Y/N] */                                                              
      wdetail.drivename1                /*Driver Name1      */                                                              
      wdetail.drivedate1                /*Birthday1         */                                                              
      wdetail.age1                      /*Age1              */
      wdetail.drivname2                 /*Driver Name2      */                                                              
      wdetail.drivedate2                /*Birthday2         */                                                              
      wdetail.age2                      /*Age2              */
      wdetail.redbook                   /*Redbook No.       */                                                              
      wdetail.not_name                  /*Opnpol            */                                                              
      wdetail.bandet                    /*Branch Market     */                                                              
      wdetail.not_date                  /*Date              */                                                              
      wdetail.pattern                   /*Att.Rate          */                                                              
      wdetail.branch_safe               /*Branch            */                                                              
      wdetail.vatcode                   /*Vat Code          */                                                              
      wdetail.Pro_off                   /*Text1             */                                                              
      wdetail.remark                    /*Text2             */                                                              
      wdetail.icno                      /*ICNO              */                                                              
      ""                                /*Finit Code        */
      ""    .                            /*Code Rebate       */

END.  */
                              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_reportreceipt C-Win 
PROCEDURE Pro_reportreceipt :
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
    "Report Match Recepit Thanachat Date : " string(TODAY)   .
EXPORT DELIMITER "|" 
    " �ѹ����Ѻ��        "            
    " �Ţ����Ѻ��        "            
    " �Ң� � �Ţ����ѭ��   "
    " ��������������    "  /*A60-0383*/
    " ���ͼ����һ�Сѹ���  "            
    " ��Ѥ��/�ú.         "            
    " �ѹ��������������ͧ  "            
    " �ѹ�������ش        "            
    " ������»�Сѹ������ "          
    " �ѹ����١��Ҫ������¤����ش���� "
    " �����˵� "
    " �����ط��".
FOR EACH wrec   no-lock.
    EXPORT DELIMITER "|" 
         wrec.not_date       /*�ѹ����Ѻ��         */                 
         wrec.Notify_no      /*�Ţ����Ѻ��         */                 
         wrec.Account_no     /*�Ң� � �Ţ����ѭ��    */ 
         wrec.prevpol        /*���������� */
         wrec.not_office     /*���ͼ����һ�Сѹ���   */                 
         wrec.ctype          /*��Ѥ��/�ú.          */                 
         wrec.comdat         /*�ѹ��������������ͧ   */                 
         wrec.expdat         /*�ѹ�������ش         */                 
         wrec.prem           /* ������»�Сѹ������ */                 
         wrec.paydate        /*�ѹ����١��Ҫ������¤����ش����*/ 
         wrec.remark 
         wrec.prem1 .
END. 
OUTPUT CLOSE.
RUN proc_reportloadgw.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

