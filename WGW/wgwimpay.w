&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
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
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
/*wgwimpay.w :  Import noitfy ,inspection and payment  file on table tlt( brstat)  
Program Import Text File    - File detail notify - file Inspection -  File detail payment
Create  by   : Ranu I. A61-0573 Date 16/10/2017
copy program : wgwimscb.w  
Connect      : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect dbstat)*/
/*------------------------------------------------------------------------------------------------------------*/
/* Modify by  : Kridtiya i. A63-0052 Date . 17/02/2020 ��䢪��� ��� KPI  �������¹������  TMS           */
/*------------------------------------------------------------------------------------------------------------*/
/* Modify by : Ranu I. A63-0448 date.14/10/2020                                                              */
/*            ��������¡��§ҹ�Ң�������� �Ѻ�áҹ��                                                       */ 
/*Modify by : Ranu I. A65-0115 �������͹䢡�ô֧ Producer code ,Dealer code �ҡ���͹ ����������� AY */
/*Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 ���� ��ö��� brstat.tlt.note1 = ��ö*/
/*Modify by : Ranu I. A67-0162 ��������红�����ö俿�� �����䢪����Ңҡ�͹ŧ���ͧ��Ǩ��Ҿ   */
/*-----------------------------------------------------------------------------------------------------------*/
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
{wgw\wgwimpay.i}
DEF     SHARED VAR n_User    AS CHAR.  
DEF     SHARED VAR n_Passwd  AS CHAR.  
DEF VAR gv_id  AS CHAR FORMAT "X(12)" NO-UNDO. 
DEF VAR nv_pwd AS CHAR FORMAT "x(15)" NO-UNDO. 
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_reccnt      AS INT  INIT  0.
DEFINE VAR nv_dri_cnt     AS INT  INIT  0.
DEFINE VAR nv_completecnt AS INT  INIT  0.
DEFINE VAR nv_updatecnt   AS INT  INIT  0.
DEFINE VAR nv_dri_complet AS INT  INIT  0.
DEFINE VAR nv_enttim      AS CHAR INIT  "".
DEFINE VAR nv_Load        AS LOGIC  INIT   Yes.
DEF    VAR nv_type        AS CHAR FORMAT "x(5)" INIT "".
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE TEMP-TABLE wdetail NO-UNDO
    field cmr_code      as CHAR FORMAT "X(50)"     init ""   /*���ʺ���ѷ��Сѹ��� */                                
    field comp_code     as CHAR FORMAT "X(50)"     init ""   /*���ͺ���ѷ��Сѹ��� */                             
    field campcode      as CHAR FORMAT "X(50)"     init ""   /*������໭          */                             
    field campname      as CHAR FORMAT "X(50)"     init ""   /*������໭          */                             
    field procode       as CHAR FORMAT "X(50)"     init ""   /*���ʼ�Ե�ѳ��       */                             
    field proname       as CHAR FORMAT "X(50)"     init ""   /*���ͼ�Ե�ѳ��ͧ��Сѹ���*/                        
    field packname      as CHAR FORMAT "X(50)"     init ""   /*����ᾤࡨ          */                             
    field packcode      as CHAR FORMAT "X(50)"     init ""   /*����ᾤࡨ          */                             
    field instype       as CHAR FORMAT "X(5)"      init ""   /*����������͡�������*/                             
    field pol_title     as CHAR FORMAT "X(20)"     init ""   /*�ӹ�˹�Ҫ��� ����͡�������     */                 
    field pol_fname     as CHAR FORMAT "X(100)"    init ""   /*���ͼ����һ�Сѹ����͡�������  */                 
    field pol_lname     as CHAR FORMAT "X(100)"    init ""   /*���ʡ�ż����һ�Сѹ ����͡�������   */            
   /* field pol_title_eng as CHAR FORMAT "X(20)"     init ""   /*�ӹ�˹�Ҫ��� ����͡������� �����ѧ��� */          
    field pol_fname_eng as CHAR FORMAT "X(50)"     init ""   /*�������� �ѧ���    */                              
    field pol_lname_eng as CHAR FORMAT "X(50)"     init ""   /*���ʡ������ �ѧ��� */ */                             
    field icno          as CHAR FORMAT "X(20)"     init ""   /*�Ţ���ѵ�         */                              
    field sex           as CHAR FORMAT "X(1) "     init ""   /*�� ����͡������� */                              
    field bdate         as CHAR FORMAT "X(10)"     init ""   /*�ѹ��͹���Դ ( DD/MM/YYYY) ����͡������� */     
    field occup         as CHAR FORMAT "X(50)"     init ""   /*�Ҫվ ����͡�������            */                 
    field tel           as CHAR FORMAT "X(20)"     init ""   /*���Ѿ��-��ҹ-����͡�������    */                 
    field phone         as CHAR FORMAT "X(20)"     init ""   /*���������Ѿ��-��ҹ-����͡������� */            
    field teloffic      as CHAR FORMAT "X(20)"     init ""   /*���Ѿ��-���ӧҹ ����͡�������*/                 
    field telext        as CHAR FORMAT "X(20)"     init ""   /*���������Ѿ��-���ӧҹ ����͡�������   */      
    field moblie        as CHAR FORMAT "X(20)"     init ""   /*���Ѿ��-��Ͷ��  ����͡������� */                 
    field mobliech      as CHAR FORMAT "X(20)"     init ""   /*���Ѿ��-��Ͷ��  㹡óշ������¹������Ͷ��*/     
    field mail          as CHAR FORMAT "X(40)"     init ""   /*email-����͡������� */                            
    field lineid        as CHAR FORMAT "X(100)"    init ""   /*Line ID              */                            
    field addr1_70      as CHAR FORMAT "X(20)"     init ""   /*������� �Ţ����ҹ-����͡�������  */              
    field addr2_70      as CHAR FORMAT "X(100)"    init ""   /*������� �����ҹ - ����͡�������  */              
    field addr3_70      as CHAR FORMAT "X(100)"    init ""   /*������� ����-����͡�������     */                 
    field addr4_70      as CHAR FORMAT "X(100)"    init ""   /*������� ��͡ ���-����͡������� */                 
    field addr5_70      as CHAR FORMAT "X(40)"     init ""   /*������� ���-����͡�������      */                 
    field nsub_dist70   as CHAR FORMAT "X(20)"     init ""   /*������� �����ǧ-����͡������� */                 
    field ndirection70  as CHAR FORMAT "X(20)"     init ""   /*������� ࢵ/�����-����͡�������*/                 
    field nprovin70     as CHAR FORMAT "X(20)"     init ""   /*������� �ѧ��Ѵ-����͡�������  */                 
    field zipcode70     as CHAR FORMAT "X(10)"     init ""   /*������� ������ɳ���-����͡�������        */      
    field addr1_72      as CHAR FORMAT "X(20)"     init ""   /*������� �Ţ����ҹ-�������㹡�èѴ���͡���*/      
    field addr2_72      as CHAR FORMAT "X(100)"    init ""   /*������� �����ҹ - �������㹡�èѴ���͡���*/      
    field addr3_72      as CHAR FORMAT "X(100)"    init ""   /*������� ����-�������㹡�èѴ���͡���      */      
    field addr4_72      as CHAR FORMAT "X(100)"    init ""   /*������� ��͡ ���-�������㹡�èѴ���͡���  */      
    field addr5_72      as CHAR FORMAT "X(40)"     init ""   /*������� ���-�������㹡�èѴ���͡���       */      
    field nsub_dist72   as CHAR FORMAT "X(20)"     init ""   /*������� �����ǧ-�������㹡�èѴ���͡���  */      
    field ndirection72  as CHAR FORMAT "X(20)"     init ""   /*������� ࢵ/�����-�������㹡�èѴ���͡��� */      
    field nprovin72     as CHAR FORMAT "X(20)"     init ""   /*������� �ѧ��Ѵ-�������㹡�èѴ���͡���   */      
    field zipcode72     as CHAR FORMAT "X(10)"     init ""   /*������� ������ɳ���-�������㹡�èѴ���͡��� */   
    field paytype       as CHAR FORMAT "X(1) "     init ""   /*������(����ѷ,�ؤ��) �������Թ��������*/         
    field paytitle      as CHAR FORMAT "X(20)"     init ""   /*�ӹ�˹�Ҫ������   �������Թ��������  */         
    field payname       as CHAR FORMAT "X(100)"    init ""   /*���ͼ����һ�Сѹ   �������Թ��������  */         
    field paylname      as CHAR FORMAT "X(100)"    init ""   /*���ʡ�ż����һ�Сѹ  �������Թ��������*/         
    field payicno       as CHAR FORMAT "X(20)"     init ""   /*�Ţ���ѵû�ЪҪ������һ�Сѹ        */            
    field payaddr1      as CHAR FORMAT "X(10)"     init ""   /*������� �Ţ����ҹ-����Ѻ�͡�����  */            
    field payaddr2      as CHAR FORMAT "X(100)"    init ""   /*������� �����ҹ - ����Ѻ�͡�����  */            
    field payaddr3      as CHAR FORMAT "X(100)"    init ""   /*������� ����-����Ѻ�͡�����        */            
    field payaddr4      as CHAR FORMAT "X(100)"    init ""   /*������� ��͡ ���-����Ѻ�͡�����    */            
    field payaddr5      as CHAR FORMAT "X(40)"     init ""   /*������� ���-����Ѻ�͡�����         */            
    field payaddr6      as CHAR FORMAT "X(20)"     init ""   /*������� �ǧ-����Ѻ�͡�����        */            
    field payaddr7      as CHAR FORMAT "X(20)"     init ""   /*������� ࢵ/�����-����Ѻ�͡�����   */            
    field payaddr8      as CHAR FORMAT "X(20)"     init ""   /*������� �ѧ��Ѵ-����Ѻ�͡�����     */            
    field payaddr9      as CHAR FORMAT "X(10)"     init ""   /*������� ������ɳ���-����Ѻ�͡�����*/            
    field branch        as CHAR FORMAT "X(10)"     init ""   /*�ӹѡ�ҹ�˭������Ң�       */                      
    field ben_title     as CHAR FORMAT "X(10)"     init ""   /*�ӹ�˹�Ҫ��� ����Ѻ�Ż���ª�� */                   
    field ben_name      as CHAR FORMAT "X(50)"     init ""   /*���ͼ���Ѻ�Ż���ª��          */                   
    field ben_lname     as CHAR FORMAT "X(50)"     init ""   /*���ʡ�� ����Ѻ�Ż���ª��      */                   
    field pmentcode     as CHAR FORMAT "X(10)"     init ""   /*���ʻ�������ê������»�Сѹ  */                   
    field pmenttyp      as CHAR FORMAT "X(20)"     init ""   /*��������ê������»�Сѹ      */                   
    field pmentcode1    as CHAR FORMAT "X(20)"     init ""   /*���ʪ�ͧ�ҧ����������       */                   
    field pmentcode2    as CHAR FORMAT "X(50)"     init ""   /*��ͧ�ҧ�����Ф������        */                   
    field pmentbank     as CHAR FORMAT "X(20)"     init ""   /*��Ҥ�÷���������            */                   
    field pmentdate     as CHAR FORMAT "X(10)"     init ""   /*�ѹ�����Ф������            */                   
    field pmentsts      as CHAR FORMAT "X(10)"     init ""   /*ʶҹС�ê�������             */                   
    field driver        as CHAR FORMAT "X(10)"     init ""   /*����кت��ͼ��Ѻ             */                   
    field drivetitle1   as CHAR FORMAT "X(10)"     init ""   /*�ӹ�˹�Ҫ��� ���Ѻ��� 1      */                   
    field drivename1    as CHAR FORMAT "X(50)"     init ""   /*���ͼ��Ѻ��� 1               */                   
    field drivelname1   as CHAR FORMAT "X(50)"     init ""   /*���ʡ�� ���Ѻ��� 1           */                   
    field driveno1      as CHAR FORMAT "X(20)"     init ""   /*�Ţ���ѵû�ЪҪ����Ѻ��� 1  */                   
    field occupdriv1    as CHAR FORMAT "X(30)"     init ""   /*Driver1Occupation             */                   
    field sexdriv1      as CHAR FORMAT "X(1) "     init ""   /*�� ���Ѻ��� 1               */                   
    field bdatedriv1    as CHAR FORMAT "X(10)"     init ""   /*�ѹ��͹���Դ ���Ѻ��� 1    */                   
    field drivetitle2   as CHAR FORMAT "X(10)"     init ""   /*�ӹ�˹�Ҫ��� ���Ѻ��� 2      */                   
    field drivename2    as CHAR FORMAT "X(50)"     init ""   /*���ͼ��Ѻ��� 2               */                   
    field drivelname2   as CHAR FORMAT "X(50)"     init ""   /*���ʡ�� ���Ѻ��� 2           */                   
    field driveno2      as CHAR FORMAT "X(20)"     init ""   /*�Ţ���ѵû�ЪҪ����Ѻ��� 2  */                   
    field occupdriv2    as CHAR FORMAT "X(50)"     init ""   /*Driver2Occupation             */                   
    field sexdriv2      as CHAR FORMAT "X(1) "     init ""   /*�� ���Ѻ��� 2               */                   
    field bdatedriv2    as CHAR FORMAT "X(10)"     init ""   /*�ѹ��͹���Դ ���Ѻ��� 2    */                   
    field chassis       as CHAR FORMAT "X(50)"     init ""  
    field covcod        as CHAR FORMAT "X(10)"     init "" 
    field covtyp        as CHAR FORMAT "X(20)"     init "" .

DEF BUFFER bfwdetail FOR wdetail.
DEF BUFFER bfwdetail01 FOR wdetail01.
DEF BUFFER bfwinsp FOR winsp.
DEF BUFFER bfwpaid FOR wpaid.
DEF BUFFER bfwcancel FOR wcancel.
DEF VAR n_trndat AS DATE INIT ? .
DEF VAR nv_producer AS CHAR FORMAT "x(12)" INIT "".
DEF VAR nv_agent    AS CHAR FORMAT "x(12)" INIT "" .
DEF VAR nv_formold  AS INT INIT 0.
DEF VAR nv_formnew  AS INT INIT 0.
DEFINE VAR n_datesent AS DATE.
DEFINE VAR company AS CHAR FORMAT "X(50)".
DEF VAR nv_output AS CHAR FORMAT "(250)" .
def var nv_branch    as char format "x(3)" . /*A65-0115*/
def var nv_dealer   as char format "x(12)" . /*A65-0115*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_detail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_detail                                     */
&Scoped-define FIELDS-IN-QUERY-br_detail tlt.cha_no tlt.nor_noti_ins ~
tlt.old_cha tlt.rec_addr5 tlt.ins_name tlt.rec_addr3 tlt.nor_coamt ~
tlt.rec_addr1 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_detail 
&Scoped-define QUERY-STRING-br_detail FOR EACH tlt NO-LOCK
&Scoped-define OPEN-QUERY-br_detail OPEN QUERY br_detail FOR EACH tlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_detail tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_detail tlt


/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt ~
IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN (substr(tlt.ins_name,index(tlt.ins_name,":") + 1 ))  ELSE (tlt.ins_name) ~
tlt.lince1 tlt.cha_no tlt.expodat ~
IF (tlt.flag <> "Paid") THEN (tlt.brand) ELSE (string(brstat.tlt.comp_coamt)) ~
IF (tlt.flag <> "Paid") THEN (tlt.model) ELSE (brstat.tlt.exp) ~
IF (tlt.flag = "V70" or tlt.flag = "V72") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,":") + 1 )) ELSE  IF (tlt.flag = "Paid") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt) ~
if (tlt.flag = "V70" or tlt.flag = "V72") then (substr(tlt.nor_noti_tlt,r-index(tlt.nor_noti_tlt,":") )) else (tlt.nor_noti_tlt) 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt 
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_detail fi_loaddat fi_compa ra_txttyp ~
fi_filename bu_file bu_ok bu_exit br_imptxt cb_agent fi_insp ra_typfile ~
RECT-1 RECT-387 RECT-388 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_compa ra_txttyp fi_filename ~
fi_impcnt fi_completecnt fi_proname2 cb_agent fi_insp ra_typfile 

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
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE cb_agent AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "","",
                     "B3MLAY0100","B3MLAY0100",
                     "B3W0100","B3W0100",
                     "B3M0039","B3M0039"
     DROP-DOWN-LIST
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_compa AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 64.83 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY 1
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_insp AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 15 FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proname2 AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 45.67 BY 1
     BGCOLOR 20 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE ra_txttyp AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "����駧ҹ", 1,
"����駧ҹ��Ǩ��Ҿ", 2,
"����駢����źѵ��ôԵ", 3,
"���¡��ԡ", 4
     SIZE 89.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typfile AS INTEGER INITIAL 1 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "���Ẻ���", 1,
"���Ẻ����", 2
     SIZE 43.5 BY .95
     BGCOLOR 20 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.76
     BGCOLOR 20 .

DEFINE RECTANGLE RECT-387
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 1.29
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-388
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 10.17 BY 1.29
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_detail FOR 
      tlt SCROLLING.

DEFINE QUERY br_imptxt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_detail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_detail C-Win _STRUCTURED
  QUERY br_detail NO-LOCK DISPLAY
      tlt.cha_no COLUMN-LABEL "�Ţ�����ҧ�ԧ" FORMAT "x(20)":U
            WIDTH 15.83
      tlt.nor_noti_ins COLUMN-LABEL "�����Ţ��ê���" FORMAT "x(25)":U
            WIDTH 16.33
      tlt.old_cha COLUMN-LABEL "��Ҥ�âͧ�ѵ�" FORMAT "x(50)":U
            WIDTH 21.33
      tlt.rec_addr5 COLUMN-LABEL "��������ê���" FORMAT "x(35)":U
            WIDTH 22.33
      tlt.ins_name COLUMN-LABEL "�Ըժ���" FORMAT "x(50)":U WIDTH 25.5
      tlt.rec_addr3 COLUMN-LABEL "���ͼ���ͺѵ�" FORMAT "x(50)":U
            WIDTH 26.83
      tlt.nor_coamt COLUMN-LABEL "�ʹ����" FORMAT "->,>>>,>>>,>>9.99":U
      tlt.rec_addr1 COLUMN-LABEL "�շ��ѵ��������" FORMAT "x(15)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.5 BY 14.43
         BGCOLOR 15 FGCOLOR 2 .

DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      IF (tlt.flag = "V70"  OR  tlt.flag = "V72") THEN (substr(tlt.ins_name,index(tlt.ins_name,":") + 1 ))  ELSE (tlt.ins_name) COLUMN-LABEL "���ͼ����һ�Сѹ" FORMAT "X(70)":U
            WIDTH 28.67
      tlt.lince1 FORMAT "x(12)":U WIDTH 14.17
      tlt.cha_no FORMAT "x(25)":U WIDTH 19.33
      tlt.expodat COLUMN-LABEL "�ѹ����������" FORMAT "99/99/9999":U
            WIDTH 12.5
      IF (tlt.flag <> "Paid") THEN (tlt.brand) ELSE (string(brstat.tlt.comp_coamt)) COLUMN-LABEL "������/�������" FORMAT "X(15)":U
            WIDTH 15.17
      IF (tlt.flag <> "Paid") THEN (tlt.model) ELSE (brstat.tlt.exp) COLUMN-LABEL "���ö/ �ʹ������" FORMAT "X(30)":U
            WIDTH 15.83
      IF (tlt.flag = "V70" or tlt.flag = "V72") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,":") + 1 )) ELSE  IF (tlt.flag = "Paid") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt) COLUMN-LABEL "��õ�Ǩ��Ҿ/ �����˵�" FORMAT "X(30)":U
      if (tlt.flag = "V70" or tlt.flag = "V72") then (substr(tlt.nor_noti_tlt,r-index(tlt.nor_noti_tlt,":") )) else (tlt.nor_noti_tlt) COLUMN-LABEL "��������´��Ǩ��Ҿ" FORMAT "X(50)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.17 BY 14.33
         BGCOLOR 15  ROW-HEIGHT-CHARS .81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_detail AT ROW 9.52 COL 3 WIDGET-ID 100
     fi_loaddat AT ROW 1.43 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_compa AT ROW 1.43 COL 71.5 COLON-ALIGNED NO-LABEL
     ra_txttyp AT ROW 2.57 COL 37.5 NO-LABEL
     fi_filename AT ROW 6.67 COL 35.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.67 COL 102.33
     bu_ok AT ROW 7.29 COL 108.83
     bu_exit AT ROW 7.29 COL 119.67
     br_imptxt AT ROW 9.57 COL 3.33
     fi_impcnt AT ROW 7.76 COL 35.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 7.76 COL 72.33 COLON-ALIGNED NO-LABEL
     fi_proname2 AT ROW 4.52 COL 55.17 COLON-ALIGNED NO-LABEL
     cb_agent AT ROW 4.48 COL 35.5 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     fi_insp AT ROW 5.57 COL 35.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     ra_typfile AT ROW 3.52 COL 37.5 NO-LABEL WIDGET-ID 12
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.76 COL 49.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   �ѹ�����Ŵ��� :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 1.43 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Company Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 1.43 COL 56.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 7.76 COL 86.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                  ���ͧ��Ǩ��Ҿ :" VIEW-AS TEXT
          SIZE 29.17 BY 1 AT ROW 5.57 COL 7.67 WIDGET-ID 8
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " �շ�����������������Ţͧ���ͧ Inspection" VIEW-AS TEXT
          SIZE 34.83 BY .71 AT ROW 5.76 COL 49 WIDGET-ID 10
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "������к���  :":60 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 7.76 COL 58.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "          ��سһ�͹����������� :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 6.67 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "               �����Ź���ҷ�����  :":50 VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 7.76 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                      Agent Code  :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 4.48 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                   ���͡�����Ź����  :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 2.43 COL 7.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "                  ������������� :" VIEW-AS TEXT
          SIZE 29 BY .95 AT ROW 3.48 COL 7.67 WIDGET-ID 16
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.05 COL 1.5
     RECT-387 AT ROW 7.14 COL 108
     RECT-388 AT ROW 7.14 COL 118.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 23.86
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
         TITLE              = "Import text file AYCAL"
         HEIGHT             = 23.86
         WIDTH              = 133
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
/* BROWSE-TAB br_detail 1 fr_main */
/* BROWSE-TAB br_imptxt bu_exit fr_main */
ASSIGN 
       br_detail:SEPARATOR-FGCOLOR IN FRAME fr_main      = 20.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname2 IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_detail
/* Query rebuild information for BROWSE br_detail
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > brstat.tlt.cha_no
"tlt.cha_no" "�Ţ�����ҧ�ԧ" ? "character" ? ? ? ? ? ? no ? no no "15.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.nor_noti_ins
"tlt.nor_noti_ins" "�����Ţ��ê���" ? "character" ? ? ? ? ? ? no ? no no "16.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.old_cha
"tlt.old_cha" "��Ҥ�âͧ�ѵ�" "x(50)" "character" ? ? ? ? ? ? no ? no no "21.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.rec_addr5
"tlt.rec_addr5" "��������ê���" "x(35)" "character" ? ? ? ? ? ? no ? no no "22.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.ins_name
"tlt.ins_name" "�Ըժ���" ? "character" ? ? ? ? ? ? no ? no no "25.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.rec_addr3
"tlt.rec_addr3" "���ͼ���ͺѵ�" "x(50)" "character" ? ? ? ? ? ? no ? no no "26.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.nor_coamt
"tlt.nor_coamt" "�ʹ����" ? "decimal" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.rec_addr1
"tlt.rec_addr1" "�շ��ѵ��������" "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_detail */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK"
     _FldNameList[1]   > "_<CALC>"
"IF (tlt.flag = ""V70""  OR  tlt.flag = ""V72"") THEN (substr(tlt.ins_name,index(tlt.ins_name,"":"") + 1 ))  ELSE (tlt.ins_name)" "���ͼ����һ�Сѹ" "X(70)" ? ? ? ? ? ? ? no ? no no "28.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.lince1
"tlt.lince1" ? "x(12)" "character" ? ? ? ? ? ? no ? no no "14.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.cha_no
"tlt.cha_no" ? "x(25)" "character" ? ? ? ? ? ? no ? no no "19.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.expodat
"tlt.expodat" "�ѹ����������" "99/99/9999" "date" ? ? ? ? ? ? no ? no no "12.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > "_<CALC>"
"IF (tlt.flag <> ""Paid"") THEN (tlt.brand) ELSE (string(brstat.tlt.comp_coamt))" "������/�������" "X(15)" ? ? ? ? ? ? ? no ? no no "15.17" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > "_<CALC>"
"IF (tlt.flag <> ""Paid"") THEN (tlt.model) ELSE (brstat.tlt.exp)" "���ö/ �ʹ������" "X(30)" ? ? ? ? ? ? ? no ? no no "15.83" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > "_<CALC>"
"IF (tlt.flag = ""V70"" or tlt.flag = ""V72"") THEN (substr(tlt.nor_noti_tlt,index(tlt.nor_noti_tlt,"":"") + 1 )) ELSE  IF (tlt.flag = ""Paid"") THEN (tlt.filler2) ELSE (tlt.nor_noti_tlt)" "��õ�Ǩ��Ҿ/ �����˵�" "X(30)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > "_<CALC>"
"if (tlt.flag = ""V70"" or tlt.flag = ""V72"") then (substr(tlt.nor_noti_tlt,r-index(tlt.nor_noti_tlt,"":"") )) else (tlt.nor_noti_tlt)" "��������´��Ǩ��Ҿ" "X(50)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import text file AYCAL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import text file AYCAL */
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
    DEFINE VARIABLE cvData   AS CHARACTER NO-UNDO.
    DEFINE VARIABLE no_add   AS CHARACTER NO-UNDO.
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

        no_add = STRING(MONTH(TODAY),"99")    + 
                 STRING(DAY(TODAY),"99")      + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        
        nv_output = "".
        IF ra_txttyp = 4 THEN ASSIGN nv_output  = SUBSTR(fi_filename,1,R-INDEX(fi_filename,".") - 1 ) + "_Cancel_" + NO_add .
        DISP fi_filename WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_daily     = ""
        nv_reccnt    = 0
        nv_updatecnt = 0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    
    IF ra_txttyp = 1 Then DO:  /*����駧ҹ ��������*/
        IF cb_agent = ""  THEN DO:
            MESSAGE "Agent code is Null ! " VIEW-AS ALERT-BOX.
            Apply "choose" To  cb_agent.
            Return no-apply.
        END.
        HIDE br_detail. 
        DISP br_imptxt WITH FRAME fr_main.
        IF ra_typfile = 1 THEN DO: 
            RUN IMPORT_notifi_old . /* ���Ẻ��� */
        END.
        ELSE DO: 
            Run  Import_notification.  /* ���Ẻ���� */  
        END.
    END.
    ELSE IF ra_txttyp = 2 THEN DO:
        IF cb_agent = ""  THEN DO:
            MESSAGE "Agent code is Null ! " VIEW-AS ALERT-BOX.
            Apply "choose" To  cb_agent.
            Return no-apply.
        END.
        HIDE br_detail. 
        DISP br_imptxt WITH FRAME fr_main.
        Run  Import_inspection. 
    END.
    Else IF ra_txttyp = 3 THEN DO:   /*����駢����źѵ��ôԵ*/
         HIDE br_imptxt. 
         DISP br_detail WITH FRAME fr_main.
         Run Import_payment. 
    END.
    Else IF ra_txttyp = 4 THEN DO:   /*����駢����źѵ��ôԵ*/
        HIDE br_detail. 
        DISP br_imptxt WITH FRAME fr_main.
        Run  Import_cancel. 
    END.
    RELEASE brstat.tlt.
    IF CONNECTED("sic_exp") THEN DISCONNECT sic_exp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_agent C-Win
ON VALUE-CHANGED OF cb_agent IN FRAME fr_main
DO:
    ASSIGN 
    cb_agent = INPUT cb_agent 
    nv_agent = cb_agent .

    If nv_agent = ""  Then do:
        Apply "choose" To  cb_agent.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  = nv_agent    NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" 
            View-as alert-box.
        Apply "choose" To  cb_agent.
        Return no-apply.
    END.
    ELSE 
        ASSIGN fi_proname2 =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
        nv_agent =  CAPS(cb_agent).
    Disp  cb_agent  fi_proname2  WITH Frame  fr_main.    
  
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
    fi_insp = INPUT fi_insp.
    IF fi_insp > STRING(YEAR(TODAY),"9999")  THEN DO:
        MESSAGE "�շ���к��ҡ���һջѨ�غѹ !! " VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO fi_insp.
        RETURN NO-APPLY.
    END.
    DISP fi_insp WITH FRAME fr_main.
  
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


&Scoped-define SELF-NAME ra_txttyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON ENTER OF ra_txttyp IN FRAME fr_main
DO:
  Apply "Entry" to cb_agent.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_txttyp C-Win
ON VALUE-CHANGED OF ra_txttyp IN FRAME fr_main
DO:
  ra_txttyp  =  Input  ra_txttyp.
  Disp  ra_txttyp  with  frame fr_main.

  IF ra_txttyp = 1 THEN  DO:
      ENABLE cb_agent ra_typfile WITH FRAME fr_main.
      cb_agent:BGCOLOR = 15.
      DISABLE fi_insp WITH FRAME fr_main.
      fi_insp:BGCOLOR = 19.
      HIDE br_detail.
      DISP br_imptxt ra_typfile WITH FRAME fr_main.
  END.
  ELSE IF ra_txttyp = 2 THEN DO:
      ENABLE fi_insp cb_agent WITH FRAME fr_main.
      fi_insp:BGCOLOR = 15.
      cb_agent:BGCOLOR = 15.
      DISABLE ra_typfile WITH FRAME fr_main.
      HIDE br_detail.
      DISP br_imptxt ra_typfile WITH FRAME fr_main.
  END.
  ELSE IF ra_txttyp = 3 THEN DO:
      ENABLE  ra_typfile WITH FRAME fr_main. /*A63-0448*/
      DISABLE  fi_insp cb_agent /*ra_typfile*/ WITH FRAME fr_main.
      fi_insp:BGCOLOR = 19.
      cb_agent:BGCOLOR = 19.
      HIDE br_imptxt.
      DISP br_detail ra_typfile WITH FRAME fr_main.
  END.
  ELSE IF ra_txttyp = 4 THEN DO:
      DISABLE  fi_insp cb_agent ra_typfile WITH FRAME fr_main.
      fi_insp:BGCOLOR = 19.
      cb_agent:BGCOLOR = 19.
      HIDE br_detail.
      DISP br_imptxt ra_typfile WITH FRAME fr_main.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typfile C-Win
ON ENTER OF ra_typfile IN FRAME fr_main
DO:
  Apply "Entry" to cb_agent.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typfile C-Win
ON VALUE-CHANGED OF ra_typfile IN FRAME fr_main
DO:
  ra_typfile  =  Input  ra_typfile.
  Disp  ra_typfile  with  frame fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_detail
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
  
  gv_prgid = "wgwimpay".
  gv_prog  = "Import Text File data AYCAL ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 

  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
  DISABLE fi_insp WITH FRAME fr_main.
  Hide Frame  fr_gen  .
  ASSIGN  
      /*tg_br       =  NO    /*A63-0448*/  A65-0115 */
      fi_loaddat  =  today
      fi_compa    = "AYCAL"
      fi_insp     = string(YEAR(TODAY),"9999")
      nv_producer = ""   
      nv_agent    = ""   
      ra_txttyp   = 1 
      ra_typfile  = 2.
      disp  fi_loaddat  fi_insp ra_txttyp fi_compa cb_agent ra_typfile with  frame  fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt_insp C-Win 
PROCEDURE Create_tlt_insp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bftlt FOR brstat.tlt. /*A65-0115*/
LOOP_Insp:
FOR EACH winsp .
    IF index(winsp.n_no,"Line") <> 0 THEN  DELETE winsp.
    ELSE  IF index(winsp.n_no,"�ӴѺ") <> 0 THEN  DELETE winsp.
    ELSE IF winsp.n_no  = "" THEN DELETE winsp.
    ELSE IF (winsp.chassis = "" ) THEN 
        MESSAGE "���Ţ��Ƕѧ�繤����ҧ..." VIEW-AS ALERT-BOX.
    ELSE DO:
        winsp.chassis = CAPS(winsp.chassis).
        nv_reccnt  = nv_reccnt + 1.
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no    = trim(winsp.chassis)  AND
            /*brstat.tlt.eng_no    = TRIM(winsp.engine)   AND */ /*A65-0115*/ 
            index(winsp.engine,brstat.tlt.eng_no) <> 0  AND  /*A65-0115*/ 
            brstat.tlt.flag      = "INSPEC"             AND 
            brstat.tlt.genusr    = trim(fi_compa)       NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO:    /*  kridtiya i. A54-0216 ....*/
            CREATE brstat.tlt.
            nv_completecnt  =  nv_completecnt + 1.
            ASSIGN                                                 
                brstat.tlt.trndat        = TODAY                           /* date  99/99/9999  */
                brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
                brstat.tlt.genusr        = TRIM(fi_compa)                  /* AYCAL*/                    
                brstat.tlt.usrid         = USERID(LDBNAME(1))              /*User Load Data */
                brstat.tlt.releas        = "NO"
                brstat.tlt.flag          = "INSPEC"                        /* ��������� ��Ǩ��Ҿ */
                brstat.tlt.subins        = "" /*TRIM(fi_producer) */ 
                brstat.tlt.policy        = "" /* ��������������� */
                brstat.tlt.recac         = nv_agent
                brstat.tlt.nor_usr_ins   = trim(winsp.inscode)                                  /*�Ţ��� Prospect       */  
                brstat.tlt.lotno         = "CamCode:" + trim(winsp.campcode)  + " " +           /*������໭            */  
                                           "CamName:" + trim(winsp.campname)                    /*������໭            */  
                brstat.tlt.usrsent       = "ProCode:" + trim(winsp.procode) + " " +             /*���ʼ�Ե�ѳ��         */  
                                           "ProName:" + trim(winsp.proname) + " " +             /*���ͼ�Ե�ѳ��         */  
                                           "PlanCod:" + trim(winsp.packcode) + " " +            /*�������¼�Ե�ѳ��     */  
                                           "PlanNam:" + trim(winsp.packnam)                     /*�����������¼�Ե�ѳ�� */  
                brstat.tlt.nor_noti_ins  = trim(winsp.Refno)                                    /*�Ţ���㺤Ӣ�          */  
                brstat.tlt.ins_name      = trim(winsp.pol_fname) + " " + TRIM(winsp.pol_lname)  /*���ͼ����һ�Сѹ      */  
                brstat.tlt.ins_addr5     = trim(winsp.pol_tel)                                  /*�������Ѿ������һ�Сѹ */
                brstat.tlt.imp           = trim(winsp.instype)                                  /*�����������һ�Сѹ        */
                brstat.tlt.nor_effdat    = DATE(winsp.inspdate)                                /*�ѹ�չѴ��Ǩ��Ҿö¹��    */
                brstat.tlt.old_eng       = trim(winsp.insptime)                                 /*���ҷ��Ѵ��Ǩ��Ҿö¹��  */
                brstat.tlt.ins_addr1     = trim(winsp.inspcont)                                 /*���ͼ����Դ���          */
                brstat.tlt.ins_addr2     = "InspTel:" + trim(winsp.insptel) + " " +             /*�������Ѿ����Դ���    */
                                           "InspLin:" + trim(winsp.lineid) + " " +              /*Line ID                   */
                                           "InspMal:" + TRIM(winsp.mail)                        /*email-���Դ���           */
                brstat.tlt.ins_addr3     = trim(winsp.inspaddr)                                 /*�������㹡�õ�Ǩ��Ҿö¹��*/
                brstat.tlt.brand         = TRIM(winsp.brand)                                    /*������ö                  */
                brstat.tlt.model         = trim(winsp.Model)                                    /*�������ö                */
                brstat.tlt.expotim       = trim(winsp.class)                                    /*����ö (MotorCode)        */
                brstat.tlt.sentcnt       = INT(winsp.seatenew)                                  /*�ӹǹ�����              */
                brstat.tlt.rencnt        = deci(winsp.power)                                    /*��Ҵ �� ��                */
                brstat.tlt.cc_weight     = deci(winsp.weight)                                   /*���˹ѡ                   */
                brstat.tlt.lince2        = trim(winsp.province)                                 /*�ѧ��Ѵ��訴����¹       */
                brstat.tlt.gentim        = trim(winsp.yrmanu)                                   /*�շ�訴����¹            */
                brstat.tlt.lince1        = trim(winsp.licence)                                  /*����¹ö                 */
                brstat.tlt.cha_no        = CAPS(trim(winsp.chassis))                           /*�����Ţ��Ƕѧ             */
                /*brstat.tlt.eng_no        = CAPS(trim(winsp.engine))  */ /*A65-0115*/         /*�����Ţ����ͧ            */
                brstat.tlt.eng_no        = IF SUBSTR(winsp.engine,1,1)  = "'" THEN CAPS(trim(replace(winsp.engine,"'",""))) 
                                           ELSE CAPS(TRIM(winsp.engine))    /*A65-0115*/
                brstat.tlt.gendat        = date(winsp.comdat)                                  /*�ѹ��������������ͧ       */
                brstat.tlt.expodat       = date(winsp.expdat)                                  /*�ѹ�������ش������ͧ     */
                brstat.tlt.nor_coamt     = deci(winsp.ins_amt)                                  /*�ع��Сѹ���              */
                brstat.tlt.comp_coamt    = deci(winsp.premtotal)                                /*������»�Сѹ���         */
                brstat.tlt.filler1       = "Acc1:" + trim(winsp.acc1)       + " " +             /*���� �ػ�ó�1  */   
                                           "Acd1:" + trim(winsp.accdetail1) + " " +             /*��������´1    */    
                                           "Acp1:" + STRING(DECI(winsp.accprice1))  + " " +     /*�Ҥ��ػ�ó�1   */    
                                           "Acc2:" + trim(winsp.acc2)       + " " +             /*���� �ػ�ó�2  */    
                                           "Acd2:" + trim(winsp.accdetail2) + " " +             /*��������´2    */    
                                           "Acp2:" + STRING(DECI(winsp.accprice2))  + " " +     /*�Ҥ��ػ�ó�2   */    
                                           "Acc3:" + trim(winsp.acc3)       + " " +             /*���� �ػ�ó�3  */    
                                           "Acd3:" + trim(winsp.accdetail3) + " " +             /*��������´3    */    
                                           "Acp3:" + STRING(DECI(winsp.accprice3))  + " " +     /*�Ҥ��ػ�ó�3   */    
                                           "Acc4:" + trim(winsp.acc4)       + " " +             /*���� �ػ�ó�4  */    
                                           "Acd4:" + trim(winsp.accdetail4) + " " +             /*��������´ 4   */    
                                           "Acp4:" + STRING(DECI(winsp.accprice4))  + " " +     /*�Ҥ��ػ�ó�4   */    
                                           "Acc5:" + trim(winsp.acc5)       + " " +             /*���� �ػ�ó�5  */    
                                           "Acd5:" + TRIM(winsp.accdetail5) + " " +             /*��������´ 5   */    
                                           "Acp5:" + STRING(DECI(winsp.accprice5))              /*�Ҥ��ػ�ó�5     */
               brstat.tlt.rec_addr1      = trim(winsp.custcode)
               brstat.tlt.rec_addr2      = trim(winsp.tmp1)
               brstat.tlt.rec_addr3      = trim(winsp.tmp2)
               brstat.tlt.nor_noti_tlt   = ""           /*�Ţ����Ǩ��Ҿ */  
               brstat.tlt.safe1          = ""           /* ����������� */
               brstat.tlt.safe2          = ""           /*��¡�ä���������� */
               brstat.tlt.safe3          = ""           /*��������´�ػ�ó������ */
               brstat.tlt.filler2        = ""           /*��������´���� */
               brstat.tlt.datesent       = ?           /*�ѹ���Դ����ͧ */
               brstat.tlt.stat           = "No"        /*�觢�������� SCBPT*/   
               brstat.tlt.entdat         = ?     .     /*�ѹ�������§ҹ */
               /*brstat.tlt.enttim         = IF tg_br = YES THEN "EMP" ELSE "ORA" . /*a63-0448*/ A65-0115*/

            RUN Proc_inspection.
            ASSIGN winsp.pass = "Y" .
        END.
        ELSE DO:
             nv_updatecnt = nv_updatecnt + 1 .
             ASSIGN winsp.pass = "N".
        END.
        /* Add by : A65-0115 */
        FIND LAST bftlt USE-INDEX tlt06  WHERE         
            bftlt.cha_no    = trim(brstat.tlt.cha_no)  AND
            bftlt.eng_no    = TRIM(brstat.tlt.eng_no)  AND  
            bftlt.flag      = "V70"                    AND 
            bftlt.genusr    = trim(fi_compa)       NO-ERROR NO-WAIT .
        IF AVAIL bftlt THEN DO: 
            ASSIGN brstat.tlt.subins  = bftlt.subins
                   brstat.tlt.recac   = bftlt.recac 
                   brstat.tlt.enttim  = bftlt.ins_addr1 .
        END.
        /* end : A65-0115*/
    END.  /*winsp.Notify_no <> "" */
END.   /* FOR EACH winsp NO-LOCK: */
Run Open_tlt.
RELEASE winsp.
RELEASE brstat.tlt.

IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "�բ����š�õ�Ǩ��Ҿ��Өӹǹ " nv_updatecnt " ��¡�� �зӡ���Ѿഷ����������������� ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "�Ѿഷ��õ�Ǩ��Ҿ" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH winsp WHERE winsp.pass = "N" .
               FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                    brstat.tlt.cha_no    = trim(winsp.chassis)  AND
                     /*brstat.tlt.eng_no    = TRIM(winsp.engine)   AND */ /*A65-0115*/ 
                    index(winsp.engine,brstat.tlt.eng_no) <> 0  AND  /*A65-0115*/   
                    brstat.tlt.flag      = "INSPEC"             AND 
                    brstat.tlt.genusr    = trim(fi_compa)       NO-ERROR NO-WAIT .
                IF AVAIL brstat.tlt THEN DO:   
                    nv_completecnt  =  nv_completecnt + 1.
                    RUN Create_tlt_insp2.
                    ASSIGN winsp.pass = "Y" .

                    /* Add by : A65-0115 */
                    FIND LAST bftlt USE-INDEX tlt06  WHERE         
                        bftlt.cha_no    = trim(brstat.tlt.cha_no)  AND
                        bftlt.eng_no    = TRIM(brstat.tlt.eng_no)  AND  
                        bftlt.flag      = "V70"                    AND 
                        bftlt.genusr    = trim(fi_compa)       NO-ERROR NO-WAIT .
                    IF AVAIL bftlt THEN DO: 
                        ASSIGN brstat.tlt.subins  = bftlt.subins
                               brstat.tlt.recac   = bftlt.recac 
                               brstat.tlt.enttim  = bftlt.ins_addr1 .
                    END.
                    /* end : A65-0115*/

                END.
            END. /*if avail wdetail2 */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    Run Open_tlt.   
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt_insp2 C-Win 
PROCEDURE Create_tlt_insp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN                                           
          brstat.tlt.trndat        = TODAY                           /* date  99/99/9999  */
          brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
          brstat.tlt.genusr        = TRIM(fi_compa)                  /* SCBPT*/                    
          brstat.tlt.usrid         = USERID(LDBNAME(1))              /*User Load Data */
          brstat.tlt.releas        = "NO" 
          brstat.tlt.flag          = "INSPEC"                        /* ��������� ��Ǩ��Ҿ */   
          brstat.tlt.subins        = "" /*TRIM(fi_producer) */ 
          brstat.tlt.policy        = "" /* ��������������� */
          brstat.tlt.recac         = nv_agent
          brstat.tlt.nor_usr_ins   = trim(winsp.inscode)                                  /*�Ţ��� Prospect*/  
          brstat.tlt.lotno         = "CamCode:" + trim(winsp.campcode)  + " " +           /*������໭     */  
                                     "CamName:" + trim(winsp.campname)                    /*������໭     */  
          brstat.tlt.usrsent       = "ProCode:" + trim(winsp.procode) + " " +             /*���ʼ�Ե�ѳ��  */  
                                     "ProName:" + trim(winsp.proname) + " " +             /*���ͼ�Ե�ѳ��  */  
                                     "PlanCod:" + trim(winsp.packcode) + " " +            /*�������¼�Ե�ѳ��     */  
                                     "PlanNam:" + trim(winsp.packnam)                     /*�����������¼�Ե�ѳ�� */  
          brstat.tlt.nor_noti_ins  = trim(winsp.Refno)                                    /*�Ţ���㺤Ӣ�     */  
          brstat.tlt.ins_name      = trim(winsp.pol_fname) + " " + TRIM(winsp.pol_lname)  /*���ͼ����һ�Сѹ */  
          brstat.tlt.ins_addr5     = trim(winsp.pol_tel)                                  /*�������Ѿ������һ�Сѹ */
          brstat.tlt.imp           = trim(winsp.instype)                                  /*�����������һ�Сѹ     */
          brstat.tlt.nor_effdat    = date(winsp.inspdate)                                       /*�ѹ�չѴ��Ǩ��Ҿö¹�� */
          brstat.tlt.old_eng       = trim(winsp.insptime)                                 /*���ҷ��Ѵ��Ǩ��Ҿö¹��*/
          brstat.tlt.ins_addr1     = trim(winsp.inspcont)                                 /*���ͼ����Դ���       */
          brstat.tlt.ins_addr2     = "InspTel:" + trim(winsp.insptel) + " " +             /*�������Ѿ����Դ��� */
                                     "InspLin:" + trim(winsp.lineid) + " " +              /*Line ID                */
                                     "InspMal:" + TRIM(winsp.mail)                        /*email-���Դ���        */
          brstat.tlt.ins_addr3     = trim(winsp.inspaddr)                                 /*�������㹡�õ�Ǩ��Ҿö¹��*/
          brstat.tlt.brand         = TRIM(winsp.brand)                                    /*������ö             */ 
          brstat.tlt.model         = trim(winsp.Model)                                    /*�������ö           */ 
          brstat.tlt.expotim       = trim(winsp.class)                                    /*����ö (MotorCode)   */ 
          brstat.tlt.sentcnt       = INT(winsp.seatenew)                                  /*�ӹǹ�����         */ 
          brstat.tlt.rencnt        = deci(winsp.power)                                    /*��Ҵ �� ��           */ 
          brstat.tlt.cc_weight     = deci(winsp.weight)                                   /*���˹ѡ              */ 
          brstat.tlt.lince2        = trim(winsp.province)                                 /*�ѧ��Ѵ��訴����¹  */ 
          brstat.tlt.gentim        = trim(winsp.yrmanu)                                   /*�շ�訴����¹       */ 
          brstat.tlt.lince1        = trim(winsp.licence)                                  /*����¹ö            */ 
          brstat.tlt.cha_no        = CAPS(trim(winsp.chassis))                            /*�����Ţ��Ƕѧ        */ 
          /*brstat.tlt.eng_no        = CAPS(trim(winsp.engine))  */ /*A65-0115*/         /*�����Ţ����ͧ            */
          brstat.tlt.eng_no        = IF SUBSTR(winsp.engine,1,1)  = "'" THEN CAPS(trim(replace(winsp.engine,"'",""))) 
                                     ELSE CAPS(TRIM(winsp.engine))    /*A65-0115*/ 
          brstat.tlt.gendat        = date(winsp.comdat)                                   /*�ѹ��������������ͧ  */ 
          brstat.tlt.expodat       = date(winsp.expdat)                                   /*�ѹ�������ش������ͧ*/ 
          brstat.tlt.nor_coamt     = deci(winsp.ins_amt)                                  /*�ع��Сѹ���         */ 
          brstat.tlt.comp_coamt    = deci(winsp.premtotal)                                /*������»�Сѹ���    */ 
          brstat.tlt.filler1       = "Acc1:" + trim(winsp.acc1)       + " " +             /*���� �ػ�ó�1  */   
                                     "Acd1:" + trim(winsp.accdetail1) + " " +             /*��������´1    */    
                                     "Acp1:" + STRING(DECI(winsp.accprice1))  + " " +     /*�Ҥ��ػ�ó�1   */    
                                     "Acc2:" + trim(winsp.acc2)       + " " +             /*���� �ػ�ó�2  */    
                                     "Acd2:" + trim(winsp.accdetail2) + " " +             /*��������´2    */    
                                     "Acp2:" + STRING(DECI(winsp.accprice2))  + " " +     /*�Ҥ��ػ�ó�2   */    
                                     "Acc3:" + trim(winsp.acc3)       + " " +             /*���� �ػ�ó�3  */    
                                     "Acd3:" + trim(winsp.accdetail3) + " " +             /*��������´3    */    
                                     "Acp3:" + STRING(DECI(winsp.accprice3))  + " " +     /*�Ҥ��ػ�ó�3   */    
                                     "Acc4:" + trim(winsp.acc4)       + " " +             /*���� �ػ�ó�4  */    
                                     "Acd4:" + trim(winsp.accdetail4) + " " +             /*��������´ 4   */    
                                     "Acp4:" + STRING(DECI(winsp.accprice4))  + " " +     /*�Ҥ��ػ�ó�4   */    
                                     "Acc5:" + trim(winsp.acc5)       + " " +             /*���� �ػ�ó�5  */    
                                     "Acd5:" + TRIM(winsp.accdetail5) + " " +             /*��������´ 5   */    
                                     "Acp5:" + STRING(DECI(winsp.accprice5))              /*�Ҥ��ػ�ó�5     */
          brstat.tlt.rec_addr1      = trim(winsp.custcode)
          brstat.tlt.rec_addr2      = trim(winsp.tmp1)
          brstat.tlt.rec_addr3      = trim(winsp.tmp2)
          brstat.tlt.nor_noti_tlt   = ""      /*�Ţ����Ǩ��Ҿ */  
          brstat.tlt.safe1          = ""      /* ����������� */
          brstat.tlt.safe2          = ""      /*��¡�ä���������� */
          brstat.tlt.safe3          = ""      /*��������´�ػ�ó������ */
          brstat.tlt.filler2        = ""      /*��������´���� */
          brstat.tlt.datesent       = ?       /*�ѹ���Դ����ͧ */
          brstat.tlt.stat           = "No"    /*�觢�������� SCBPT*/ 
          brstat.tlt.entdat         = ? .      /*�ѹ�������§ҹ */
          /*brstat.tlt.enttim         = IF tg_br = YES THEN "EMP" ELSE "ORA" ./*a63-0448*/  A65-0115 */ 
          RUN Proc_inspection.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt_noti C-Win 
PROCEDURE create_tlt_noti :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: �礢���������駧ҹẺ����      
------------------------------------------------------------------------------*/
DEF BUFFER bftlt FOR brstat.tlt.
LOOP_wdetail2:
FOR EACH wdetail2 .
    IF INDEX(wdetail2.chassis,"Chassis") <> 0  THEN DELETE wdetail2.
    ELSE IF wdetail2.chassis = ""  THEN DELETE wdetail2.
    ELSE DO:
        FIND FIRST wdetail WHERE wdetail.chassis = wdetail2.chassis AND
                                 wdetail.covtyp  = wdetail2.covtyp  NO-ERROR.
        IF AVAIL wdetail THEN DO:
            n_trndat = date(wdetail2.not_date) .

            IF INDEX(wdetail.chassis,"Chassis") <> 0 THEN DELETE wdetail.
            ELSE IF wdetail.chassis = "" THEN DELETE wdetail. 
            ELSE DO:
                ASSIGN
                    nv_type   = "" 
                    nv_reccnt  = nv_reccnt + 1
                    wdetail2.engine = trim(REPLACE(wdetail2.engine,"*",""))
                    wdetail2.engine = trim(REPLACE(wdetail2.engine,"'","")).
               IF ( wdetail2.chassis = "" ) THEN 
                    MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
                ELSE DO:
                    /* ------------------------check policy  Duplicate--------------------------------------*/ 
                    IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
                    ELSE ASSIGN nv_type = "V70" .

                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                        brstat.tlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                        /*brstat.tlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                        index(wdetail2.engine,brstat.tlt.eng_no) <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                        INDEX(brstat.tlt.lince1,trim(wdetail2.licence)) <> 0  AND   /* ����¹ */
                        brstat.tlt.flag          <> "INSPEC"               AND
                        brstat.tlt.flag          = trim(nv_type)           AND  /* ������ v70 ,v72 */
                        brstat.tlt.genusr        = trim(fi_compa)          NO-LOCK NO-ERROR NO-WAIT .
                    IF NOT AVAIL brstat.tlt THEN DO: 
                        FIND LAST bftlt USE-INDEX tlt06  WHERE         
                        bftlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                        bftlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */
                        INDEX(bftlt.lince1,trim(wdetail2.licence)) <> 0  AND   /* ����¹ */
                        bftlt.flag          <> "INSPEC"               AND
                        bftlt.genusr        = trim(fi_compa)          NO-LOCK NO-ERROR NO-WAIT .
                        IF AVAIL bftlt THEN DO:
                             ASSIGN nv_updatecnt  = nv_updatecnt  + 1
                                    nv_formold = nv_formold + 1
                                    wdetail2.ftype = "1"
                                    wdetail2.pass  = "N". 
                        END.
                    END.
                    ELSE DO:
                        ASSIGN nv_updatecnt   = nv_updatecnt  + 1
                               nv_formnew     = nv_formnew + 1
                               wdetail2.ftype = "2"
                               wdetail2.pass  = "N". 
                    END.
                   
                END.  /*wdetail2.chassis <> "" */
            END. /* else do: */
        END. /* if avail wdetail*/
    END. /*if avail wdetail2 */ 
END.   /* FOR EACH wdetail2 NO-LOCK: */
RELEASE wdetail.
RELEASE wdetail2.
RELEASE brstat.tlt.
/*Run Open_tlt.*/
FOR EACH wdetail2 WHERE wdetail2.pass = " " .
    FIND FIRST wdetail WHERE wdetail.chassis = wdetail2.chassis AND
                             wdetail.covtyp  = wdetail2.covtyp  NO-ERROR.
    IF AVAIL wdetail THEN DO:
       ASSIGN  
           n_trndat = date(wdetail2.not_date)
           nv_type = "" 
           wdetail2.engine = REPLACE(wdetail2.engine,"*","").
       IF ( wdetail2.chassis = "" ) THEN 
           MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
       ELSE DO:
           IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
           ELSE ASSIGN nv_type = "V70" .

           RUN proc_chkexp. /* A65-0115*/
           
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                brstat.tlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                /*brstat.tlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                index(wdetail2.engine,brstat.tlt.eng_no) <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                INDEX(brstat.tlt.lince1,trim(wdetail2.licence)) <> 0   AND   /* ����¹ */
                brstat.tlt.flag          = nv_type                 AND
                brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO:
                CREATE brstat.tlt.
                nv_completecnt  =  nv_completecnt + 1.
                RUN Proc_Adddatatlt.
                RUN Proc_AddDatatlt2.
                ASSIGN wdetail2.pass = "Y" .
            END.
       END.
    END.
END.
RELEASE wdetail.
RELEASE wdetail2.
RELEASE brstat.tlt.
                  
IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "�բ����š���駧ҹ��Өӹǹ " nv_updatecnt " ��¡�� " SKIP 
            "�����Ũҡ����駧ҹẺ����: " nv_formnew  " ��¡�� " SKIP
            "�����Ũҡ����駧ҹẺ��� : " nv_formold  " ��¡�� " SKIP
            " �зӡ���Ѿഷ����������������� ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "�Ѿഷ����駧ҹ" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH wdetail2 WHERE wdetail2.pass = "N" .
                FIND FIRST wdetail WHERE wdetail.chassis = wdetail2.chassis AND
                                         wdetail.covtyp  = wdetail2.covtyp  NO-ERROR.
                IF AVAIL wdetail THEN DO:
                   ASSIGN  
                       n_trndat = date(wdetail2.not_date)
                       nv_type = "" 
                       wdetail2.engine = REPLACE(wdetail2.engine,"*","").
                   IF ( wdetail2.chassis = "" ) THEN 
                       MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
                   ELSE DO:
                      IF int(wdetail2.ftype) <> ra_typfile THEN DO:  /* �ٻẺ������������ç�Ѻ�ͧ������������к� */
                          /*  delete data Duplicate */
                          FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                              brstat.tlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                              /*brstat.tlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                              index(wdetail2.engine,brstat.tlt.eng_no) <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                              INDEX(brstat.tlt.lince1,trim(wdetail2.licence)) <> 0       AND   /* ����¹ */
                              brstat.tlt.flag          <> "INSPEC"               AND
                              brstat.tlt.flag          <> "V70"                  AND
                              brstat.tlt.flag          <> "V72"                  AND 
                              brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
                          IF AVAIL brstat.tlt THEN DO: 
                              DELETE brstat.tlt.
                          END.
                          RELEASE brstat.tlt.
                          /* create data New */ 
                          IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
                          ELSE ASSIGN nv_type = "V70" .

                          RUN proc_chkexp. /* A65-0115*/

                          FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                                brstat.tlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                                /*brstat.tlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                                index(wdetail2.engine,brstat.tlt.eng_no) <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                                INDEX(brstat.tlt.lince1,trim(wdetail2.licence)) <> 0       AND   /* ����¹ */
                                brstat.tlt.flag          = trim(nv_type)           AND  /* ������ 70 ,72 */
                                brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
                            IF NOT AVAIL brstat.tlt THEN DO: 
                                CREATE brstat.tlt.
                                nv_completecnt  =  nv_completecnt + 1.
                                RUN Proc_Adddatatlt.
                                RUN Proc_AddDatatlt2.
                                ASSIGN wdetail2.pass = "Y" .
                            END.
                       END.
                       ELSE DO:
                         IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
                         ELSE ASSIGN nv_type = "V70" .

                         RUN proc_chkexp. /* A65-0115*/

                         FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                                   brstat.tlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                                   /*brstat.tlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                                   index(wdetail2.engine,brstat.tlt.eng_no) <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                                   INDEX(brstat.tlt.lince1,trim(wdetail2.licence)) <> 0       AND   /* ����¹ */
                                   brstat.tlt.flag          = trim(nv_type)           AND  /* ������ 70 ,72 */
                                   brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
                            IF AVAIL brstat.tlt THEN DO: 
                                nv_completecnt  =  nv_completecnt + 1.
                                RUN Proc_Updatatlt.
                                RUN Proc_Updatatlt2.
                                ASSIGN wdetail2.pass = "Y" .
                            END.
                            ELSE DO:
                               CREATE brstat.tlt.
                               nv_completecnt  =  nv_completecnt + 1.
                               RUN Proc_Adddatatlt.
                               RUN Proc_AddDatatlt2.
                               ASSIGN wdetail2.pass = "Y" .
                            END.
                       END.
                   END.  /*wdetail.Notify_no <> "" */
                END. /* if avail wdetail*/
            END. /*if avail wdetail2 */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    /*Run Open_tlt.   */         
END.
RELEASE wdetail.
RELEASE wdetail2.
RELEASE brstat.tlt.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt_noti-bp C-Win 
PROCEDURE create_tlt_noti-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*LOOP_wdetail2:
FOR EACH wdetail2 .
    IF INDEX(wdetail2.chassis,"Chassis") <> 0  THEN DELETE wdetail2.
    ELSE IF wdetail2.chassis = ""  THEN DELETE wdetail2.
    ELSE DO:
        FIND FIRST wdetail WHERE wdetail.chassis = wdetail2.chassis AND
                                 wdetail.covtyp  = wdetail2.covtyp  NO-ERROR.
        IF AVAIL wdetail THEN DO:
            n_trndat = date(wdetail2.not_date) .

            IF INDEX(wdetail.chassis,"Chassis") <> 0 THEN DELETE wdetail.
            ELSE IF wdetail.chassis = "" THEN DELETE wdetail. 
            ELSE DO:
                ASSIGN  
                    nv_type = "" 
                    nv_reccnt  = nv_reccnt + 1
                    wdetail2.engine = REPLACE(wdetail2.engine,"*","").
               IF ( wdetail2.chassis = "" ) THEN 
                    MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
                ELSE DO:
                    /* ------------------------check policy  Duplicate--------------------------------------*/ 
                    IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
                    ELSE ASSIGN nv_type = "V70" .

                    FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                        brstat.tlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                        brstat.tlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */
                         brstat.tlt.nor_noti_ins  = trim(wdetail2.cedcode)  and   /* �Ţ�����ҧ�ԧ*/ 
                        brstat.tlt.nor_usr_ins   = trim(wdetail2.inscode)  and  /* �Ţ����١��� */
                        brstat.tlt.flag          = trim(nv_type)           AND  /* ������ 70 ,72 */
                        brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
                    IF NOT AVAIL brstat.tlt THEN DO: 
                        CREATE brstat.tlt.
                        nv_completecnt  =  nv_completecnt + 1.
                        RUN Proc_Adddatatlt.
                        RUN Proc_AddDatatlt2.
                        ASSIGN wdetail2.pass = "Y" .
                    END.
                    ELSE DO:
                        nv_updatecnt = nv_updatecnt + 1 .
                        ASSIGN wdetail2.pass = "N".
                    END.
                END.  /*wdetail.Notify_no <> "" */
            END. /* else do: */
        END. /* if avail wdetail*/
    END. /*if avail wdetail2 */
END.   /* FOR EACH wdetail2 NO-LOCK: */
RELEASE wdetail.
RELEASE wdetail2.
RELEASE brstat.tlt.
/*Run Open_tlt.*/

IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "�բ����š���駧ҹ��Өӹǹ " nv_updatecnt " ��¡�� �зӡ���Ѿഷ����������������� ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "�Ѿഷ����駧ҹ" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH wdetail2 WHERE wdetail2.pass = "N" .
                FIND FIRST wdetail WHERE wdetail.chassis = wdetail2.chassis AND
                                         wdetail.covtyp  = wdetail2.covtyp  NO-ERROR.
                IF AVAIL wdetail THEN DO:
                   ASSIGN  
                       n_trndat = date(wdetail2.not_date)
                       nv_type = "" 
                       wdetail2.engine = REPLACE(wdetail2.engine,"*","").
                   IF ( wdetail2.chassis = "" ) THEN 
                       MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
                   ELSE DO:
                       /* ------------------------check policy  Duplicate--------------------------------------*/ 
                       IF index(wdetail2.covtyp,"CMI") <> 0 THEN ASSIGN nv_type = "V72" .
                       ELSE ASSIGN nv_type = "V70" .
                       FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                                 brstat.tlt.cha_no        = trim(wdetail2.chassis)  AND   /* �Ţ�ѧ */
                                 brstat.tlt.eng_no        = TRIM(wdetail2.engine)   AND   /* �Ţ����ͧ */
                                 brstat.tlt.nor_noti_ins  = trim(wdetail2.cedcode)  and   /* �Ţ�����ҧ�ԧ*/ 
                                 brstat.tlt.nor_usr_ins   = trim(wdetail2.inscode)  and   /* �Ţ����١��� */
                                 brstat.tlt.flag          = trim(nv_type)           AND   /* ������ 70 ,72 */
                                 brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
                       IF AVAIL brstat.tlt THEN DO: 
                           nv_completecnt  =  nv_completecnt + 1.
                           RUN Proc_Updatatlt.
                           RUN Proc_Updatatlt2.
                           ASSIGN wdetail2.pass = "Y" .
                       END.
                   END.  /*wdetail.Notify_no <> "" */
                END. /* if avail wdetail*/
            END. /*if avail wdetail2 */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    /*Run Open_tlt.   */         
END.
RELEASE wdetail.
RELEASE wdetail2.
RELEASE brstat.tlt.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt_noti_old C-Win 
PROCEDURE create_tlt_noti_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: �礢���������駧ҹẺ���      
------------------------------------------------------------------------------*/
LOOP_wdetail01:
FOR EACH wdetail01 .
    IF INDEX(wdetail01.chassis,"�Ţ��Ƕѧ") <> 0  THEN DELETE wdetail01.
    ELSE IF wdetail01.chassis = ""  THEN DELETE wdetail01.
    ELSE DO:
        ASSIGN  
            nv_type = "" 
            wdetail01.engno = REPLACE(wdetail01.engno,"*","").
       IF ( wdetail01.chassis = "" ) THEN 
            MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
        ELSE DO:
            nv_reccnt  = nv_reccnt + 1 .
            ASSIGN
            np_addr1  = "" 
            np_addr2  = "" 
            np_addr3  = "" 
            np_addr4  = "" 
            np_addr5  = ""   /*Add Jiraphon A59-0451*/
            nv_prov   = ""  
            nv_amp    = ""
            nv_tum    = ""
            np_addrall   = TRIM(wdetail01.addr1) + " " +                      
                           TRIM(wdetail01.addr2) + " " +                       
                           TRIM(wdetail01.addr3) + " " +
                           TRIM(wdetail01.addr4) .

            RUN proc_chkaddr.
            /* ------------------------check data Duplicate--------------------------------------*/ 
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                /*brstat.tlt.eng_no        = TRIM(wdetail01.engno)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                index(wdetail01.engno,brstat.tlt.eng_no)  <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                INDEX(brstat.tlt.lince1,wdetail01.vehreg) <> 0      AND   /* ����¹ */
                brstat.tlt.genusr        = trim(fi_compa)           AND 
                brstat.tlt.flag          <> "INSPEC"                NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO: 
                CREATE brstat.tlt.
                nv_completecnt  =  nv_completecnt + 1.
                RUN Proc_Addtlt_old.
                ASSIGN wdetail01.pass = "Y" .
            END.
            ELSE DO:
                nv_updatecnt = nv_updatecnt + 1 .
                IF brstat.tlt.flag = "V70" THEN DO: 
                    ASSIGN nv_formnew    = nv_formnew + 1
                           wdetail01.ftype = "2" .
                END.
                ELSE IF brstat.tlt.flag = "V72" THEN DO: 
                    ASSIGN nv_formnew    = nv_formnew + 1
                           wdetail01.ftype = "2" .
                END.
                ELSE DO: 
                    ASSIGN nv_formold      = nv_formold + 1
                           brstat.tlt.EXP  = "OLD"
                           wdetail01.ftype = "1".
                END.
                ASSIGN wdetail01.pass = "N".
            END.
        END.  /*wdetail.Notify_no <> "" */
 
    END. /*if avail wdetail01 */
END.   /* FOR EACH wdetail01 NO-LOCK: */
RELEASE wdetail.
RELEASE wdetail01.
RELEASE brstat.tlt.
/*Run Open_tlt.*/

IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "�բ����š���駧ҹ��Өӹǹ " nv_updatecnt " ��¡�� " SKIP 
            "�����Ũҡ����駧ҹẺ����: " nv_formnew  " ��¡�� " SKIP
            "�����Ũҡ����駧ҹẺ��� : " nv_formold  " ��¡�� " SKIP
            " �зӡ���Ѿഷ����������������� ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "�Ѿഷ����駧ҹ" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH wdetail01 WHERE wdetail01.pass = "N" .
                   ASSIGN  
                       nv_type = "" 
                       wdetail01.engno = REPLACE(wdetail01.engno,"*","").
                   IF ( wdetail01.chassis = "" ) THEN 
                       MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
                   ELSE DO:
                        
                       IF int(wdetail01.ftype) <> ra_typfile THEN DO:  /* �ٻẺ������������ç�Ѻ�ͧ������������к� */
                           /* Delete Data */
                       
                         FOR EACH brstat.tlt USE-INDEX tlt06  WHERE
                             brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                             /*brstat.tlt.eng_no        = TRIM(wdetail01.engno)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                             index(wdetail01.engno,brstat.tlt.eng_no)  <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                             INDEX(brstat.tlt.lince1,trim(wdetail01.vehreg)) <> 0       AND   /* ����¹ */
                             brstat.tlt.flag          <> "INSPEC"                AND
                             brstat.tlt.genusr        = trim(fi_compa)    .    
                             DELETE brstat.tlt.
                         END.
                         RELEASE brstat.tlt.
                         /* create data */
                         FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                            brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                            /*brstat.tlt.eng_no        = TRIM(wdetail01.engno)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                            index(wdetail01.engno,brstat.tlt.eng_no)  <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                            INDEX(brstat.tlt.lince1,wdetail01.vehreg) <> 0      AND   /* ����¹ */
                            brstat.tlt.EXP           =  "OLD"                   AND   /* ����駧ҹẺ��� */
                            brstat.tlt.genusr        = trim(fi_compa)           NO-ERROR NO-WAIT .
                         IF NOT AVAIL brstat.tlt THEN DO: 
                             CREATE brstat.tlt.
                             nv_completecnt  =  nv_completecnt + 1.
                             RUN Proc_Addtlt_old.
                             ASSIGN wdetail01.pass = "Y" .
                         END.

                       END.
                       ELSE DO:   /* �ٻẺ��������ҵç�Ѻ�ͧ������������к� */
                            /* update Data */
                            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                                      brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                                      /*brstat.tlt.eng_no        = TRIM(wdetail01.engno)   AND   /* �Ţ����ͧ */*//*A65-0115*/
                                      index(wdetail01.engno,brstat.tlt.eng_no)  <> 0      AND   /* �Ţ����ͧ */ /*A65-0115*/
                                      INDEX(brstat.tlt.lince1,trim(wdetail01.vehreg)) <> 0  AND
                                      tlt.EXP                  = "OLD"                    AND   /* ����駧ҹẺ��� */
                                      brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
                            IF AVAIL brstat.tlt THEN DO: 
                                nv_completecnt  =  nv_completecnt + 1.
                                RUN Proc_Uptlt_old.
                                ASSIGN wdetail01.pass = "Y" .
                            END.
                       END.
                   END.  /*wdetail.Notify_no <> "" */
                
            END. /*if avail wdetail01 */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    /*Run Open_tlt.   */         
END.
RELEASE wdetail.
RELEASE wdetail01.
RELEASE brstat.tlt.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt_noti_old-bp C-Win 
PROCEDURE create_tlt_noti_old-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: �礢���������駧ҹẺ���      
------------------------------------------------------------------------------*/
LOOP_wdetail01:
FOR EACH wdetail01 .
    IF INDEX(wdetail01.chassis,"�Ţ��Ƕѧ") <> 0  THEN DELETE wdetail01.
    ELSE IF wdetail01.chassis = ""  THEN DELETE wdetail01.
    ELSE DO:
        ASSIGN  
            nv_type = "" 
            wdetail01.engno = REPLACE(wdetail01.engno,"*","").
       IF ( wdetail01.chassis = "" ) THEN 
            MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
        ELSE DO:
            nv_reccnt  = nv_reccnt + 1 .
            ASSIGN
            np_addr1  = "" 
            np_addr2  = "" 
            np_addr3  = "" 
            np_addr4  = "" 
            np_addr5  = ""   /*Add Jiraphon A59-0451*/
            nv_prov   = ""  
            nv_amp    = ""
            nv_tum    = ""
            np_addrall   = TRIM(wdetail01.addr1) + " " +                      
                           TRIM(wdetail01.addr2) + " " +                       
                           TRIM(wdetail01.addr3) + " " +
                           TRIM(wdetail01.addr4) .

            RUN proc_chkaddr.
            /* ------------------------check data Duplicate--------------------------------------*/ 
            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                brstat.tlt.eng_no        = TRIM(wdetail01.engno)    AND   /* �Ţ����ͧ */
                INDEX(brstat.tlt.lince1,wdetail01.vehreg) <> 0      AND   /* ����¹ */
                brstat.tlt.genusr        = trim(fi_compa)           AND 
                brstat.tlt.flag          <> "INSPEC"                NO-ERROR NO-WAIT .
            IF NOT AVAIL brstat.tlt THEN DO: 
                CREATE brstat.tlt.
                nv_completecnt  =  nv_completecnt + 1.
                RUN Proc_Addtlt_old.
                ASSIGN wdetail01.pass = "Y" .
            END.
            ELSE DO:
                nv_updatecnt = nv_updatecnt + 1 .
                IF brstat.tlt.flag = "V70" THEN DO: 
                    ASSIGN nv_formnew    = nv_formnew + 1
                           wdetail01.ftype = "2" .
                END.
                ELSE IF brstat.tlt.flag = "V72" THEN DO: 
                    ASSIGN nv_formnew    = nv_formnew + 1
                           wdetail01.ftype = "2" .
                END.
                ELSE DO: 
                    ASSIGN nv_formold      = nv_formold + 1
                           wdetail01.ftype = "1".
                END.
                ASSIGN wdetail01.pass = "N".
            END.
        END.  /*wdetail.Notify_no <> "" */
 
    END. /*if avail wdetail01 */
END.   /* FOR EACH wdetail01 NO-LOCK: */
RELEASE wdetail.
RELEASE wdetail01.
RELEASE brstat.tlt.
/*Run Open_tlt.*/

IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "�բ����š���駧ҹ��Өӹǹ " nv_updatecnt " ��¡�� " SKIP 
            "�����Ũҡ����駧ҹẺ����: " nv_formnew  " ��¡�� " SKIP
            "�����Ũҡ����駧ҹẺ��� : " nv_formold  " ��¡�� " SKIP
            " �зӡ���Ѿഷ����������������� ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "�Ѿഷ����駧ҹ" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH wdetail01 WHERE wdetail01.pass = "N" .
                   ASSIGN  
                       nv_type = "" 
                       wdetail01.engno = REPLACE(wdetail01.engno,"*","").
                   IF ( wdetail01.chassis = "" ) THEN 
                       MESSAGE "���Ţ��Ƕѧ�����ҧ..." VIEW-AS ALERT-BOX.
                   ELSE DO:
                        
                       IF int(wdetail01.ftype) <> ra_typfile THEN DO:  /* �ٻẺ������������ç�Ѻ�ͧ������������к� */
                           /* Delete Data */
                        /* FIND LAST brstat.tlt USE-INDEX tlt06  WHERE   */
                         FOR EACH brstat.tlt USE-INDEX tlt06  WHERE
                             brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                             brstat.tlt.eng_no        = TRIM(wdetail01.engno)    AND   /* �Ţ����ͧ */
                             INDEX(brstat.tlt.lince1,trim(wdetail01.vehreg)) <> 0       AND   /* ����¹ */
                             brstat.tlt.flag          <> "INSPEC"                AND
                             brstat.tlt.genusr        = trim(fi_compa)    .     /* NO-ERROR NO-WAIT .
                         IF AVAIL brstat.tlt THEN DO: */
                             DELETE brstat.tlt.
                         END.
                         RELEASE brstat.tlt.
                         /* create data */
                         FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                            brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                            brstat.tlt.eng_no        = TRIM(wdetail01.engno)    AND   /* �Ţ����ͧ */
                            INDEX(brstat.tlt.lince1,wdetail01.vehreg) <> 0      AND   /* ����¹ */
                            /*brstat.tlt.EXP           =  "OLD"                   AND */  /* ����駧ҹẺ��� */
                            brstat.tlt.genusr        = trim(fi_compa)           NO-ERROR NO-WAIT .
                         IF NOT AVAIL brstat.tlt THEN DO: 
                             CREATE brstat.tlt.
                             nv_completecnt  =  nv_completecnt + 1.
                             RUN Proc_Addtlt_old.
                             ASSIGN wdetail01.pass = "Y" .
                         END.

                       END.
                       ELSE DO:   /* �ٻẺ��������ҵç�Ѻ�ͧ������������к� */
                            /* update Data */
                            FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                                      brstat.tlt.cha_no        = trim(wdetail01.chassis)  AND   /* �Ţ�ѧ */
                                      brstat.tlt.eng_no        = TRIM(wdetail01.engno)    AND   /* �Ţ����ͧ */
                                      INDEX(brstat.tlt.lince1,trim(wdetail01.vehreg)) <> 0  AND
                                      /*tlt.EXP                  = "OLD"                    AND  */ /* ����駧ҹẺ��� */
                                      brstat.tlt.genusr        = trim(fi_compa)          NO-ERROR NO-WAIT .
                            IF AVAIL brstat.tlt THEN DO: 
                                nv_completecnt  =  nv_completecnt + 1.
                                RUN Proc_Uptlt_old.
                                ASSIGN wdetail01.pass = "Y" .
                            END.
                       END.
                   END.  /*wdetail.Notify_no <> "" */
                
            END. /*if avail wdetail01 */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
    /*Run Open_tlt.   */         
END.
RELEASE wdetail.
RELEASE wdetail01.
RELEASE brstat.tlt.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Create_tlt_payment C-Win 
PROCEDURE Create_tlt_payment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
LOOP_Paid:
FOR EACH wpaid .
    IF index(wpaid.refno,"RefNo") <> 0 THEN  DELETE wpaid.
    ELSE IF wpaid.refno  = "" THEN DELETE wpaid.
    ELSE IF (wpaid.refno = "" ) THEN DO:
        MESSAGE " X-RefNo.�繤����ҧ..." VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        nv_reccnt  = nv_reccnt + 1.
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no          = TRIM(wpaid.refno)   AND
            brstat.tlt.nor_noti_ins    = trim(wpaid.pay_no)  AND  
            brstat.tlt.flag            = "Payment"           AND 
            brstat.tlt.genusr          = trim(fi_compa)      NO-ERROR NO-WAIT .
        IF NOT AVAIL brstat.tlt THEN DO:   
            CREATE brstat.tlt.
            nv_completecnt  =  nv_completecnt + 1.
            ASSIGN                                                 
                brstat.tlt.trndat        = TODAY                          /* date  99/99/9999  */
                brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")        /* char  x(8)        */
                brstat.tlt.genusr        = TRIM(fi_compa)                 /* AYCAL*/                    
                brstat.tlt.usrid         = USERID(LDBNAME(1))             /*User Load Data */
                brstat.tlt.flag          = "Payment"                      /* ��������� �����Թ */ 
                brstat.tlt.cha_no        = TRIM(wpaid.refno)     
                brstat.tlt.nor_usr_ins   = trim(wpaid.company_cod)  
                brstat.tlt.lotno         = trim(wpaid.company_nam)  
                brstat.tlt.nor_noti_ins  = trim(wpaid.pay_no)
                brstat.tlt.rec_addr2     = TRIM(wpaid.trntyp)
                brstat.tlt.rec_addr5     = TRIM(wpaid.pay_mode)     
                brstat.tlt.ins_name      = trim(wpaid.pay_type)  
                brstat.tlt.rec_name      = trim(wpaid.card_no)  
                brstat.tlt.lince1        = trim(wpaid.card_type) 
                brstat.tlt.rec_addr1     = TRIM(wpaid.card_exp)  
                brstat.tlt.rec_addr3     = trim(wpaid.card_Hname)  
                brstat.tlt.old_cha       = trim(wpaid.card_bank)  
                brstat.tlt.gendat        = Date(wpaid.pay_due_date)  
                brstat.tlt.nor_coamt     = deci(wpaid.due_amount)  
                brstat.tlt.safe3         = trim(wpaid.promo_code)      
                brstat.tlt.safe2         = trim(wpaid.product_code) 
               /* comment by A63-0448
                brstat.tlt.policy        = ""
                brstat.tlt.datesent      = ?         /*Payment Date */
                brstat.tlt.rec_addr4     = ""        /*PaymentTrans */ 
                brstat.tlt.exp           = ""        /*Payment Amount   */
                brstat.tlt.safe1         = ""        /*Result           */
                brstat.tlt.comp_sub     = ""        /*ApprovalCode     */
                end a63-0448....*/
                /* add by A63-0448*/
                brstat.tlt.recac         = TRIM(wpaid.holdername)
                brstat.tlt.subins        = TRIM(wpaid.CustNo)
                brstat.tlt.policy        = TRIM(wpaid.policy)
                brstat.tlt.datesent      = IF trim(wpaid.PayDate) = "" THEN ? ELSE DATE(wpaid.paydate)         /*Payment Date */
                brstat.tlt.rec_addr4     = ""        /*PaymentTrans */ 
                brstat.tlt.exp           = trim(wpaid.PayAmount)         /*Payment Amount   */
                brstat.tlt.safe1         = trim(wpaid.nResult)           /*Result           */
                brstat.tlt.comp_sub      = TRIM(wpaid.ApproveNo)         /*ApprovalCode     */
                /* end a63-0448*/
                brstat.tlt.dat_ins_noti  = ?         /* �ѹ��� Match �ŵѴ�ѵ� */ 
                brstat.tlt.releas        = "NO"     /* yes = Match file �駼ŵѴ�ѵ�����, no  = �ѧ���Match file �駼ŵѴ�ѵ����� */ 
                brstat.tlt.filler1       = ""        /* �����˵� */
                brstat.tlt.imp           = ""        /* User update*/
                /*brstat.tlt.enttim        = IF tg_br = YES THEN "EMP" ELSE "ORA" . /*a63-0448*/*/ /*A65-0115*/
                wpaid.remark = "YES" .
        END.
        ELSE DO: 
            IF brstat.tlt.releas = "Yes"  THEN DO:
                MESSAGE "�����Ţ��ҧ�ԧ : " wpaid.refno " �����Ţ��ê��� : " wpaid.pay_no " �ռš�õѴ�ѵ��ôԵ���º�������� " VIEW-AS ALERT-BOX.
                wpaid.remark = "YES" .
            END.
            ELSE DO:
                ASSIGN nv_updatecnt   = nv_updatecnt  + 1
                       wpaid.remark   = "NO" .
                /*nv_completecnt  =  nv_completecnt + 1.
                RUN Create_tlt_payment2.*/
            END.
        END.
    END.  /*wpaid.refno <> "" */
END.   /* for wpaif */
RELEASE brstat.tlt.
RELEASE wpaid.
IF nv_updatecnt <> 0 THEN DO:
    MESSAGE "�բ����š�õѴ�ѵ��ôԵ�ӹǹ " nv_updatecnt " ��¡�� �зӡ���Ѿഷ����������������� ? " 
    VIEW-AS ALERT-BOX QUESTION BUTTON YES-NO TITLE "�Ѿഷ��õѴ�ѵ�" UPDATE choic AS LOGICAL.
    CASE choic:
        WHEN TRUE THEN DO:
            FOR EACH wpaid WHERE wpaid.remark = "NO" .
                FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         
                          brstat.tlt.cha_no          = TRIM(wpaid.refno)   AND
                          brstat.tlt.nor_noti_ins    = trim(wpaid.pay_no)  AND  
                          brstat.tlt.flag            = "Payment"           AND 
                          brstat.tlt.genusr          = trim(fi_compa)      NO-ERROR NO-WAIT .
                      IF AVAIL brstat.tlt THEN DO: 
                          nv_completecnt  =  nv_completecnt + 1.
                          RUN Create_tlt_payment2.
                      END. /* if avail tlt*/
            END. /* end wpaid */
        END.
        WHEN FALSE THEN DO:
            RETURN NO-APPLY.
        END.
    END CASE.
END.
RELEASE brstat.tlt.
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt_payment2 C-Win 
PROCEDURE create_tlt_payment2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN 
       brstat.tlt.trndat        = TODAY                          /* date  99/99/9999  */
       brstat.tlt.trntim        = STRING(TIME,"HH:MM:SS")        /* char  x(8)        */
       brstat.tlt.genusr        = TRIM(fi_compa)                 /* AYCAL*/                    
       brstat.tlt.usrid         = USERID(LDBNAME(1))             /*User Load Data */
       brstat.tlt.flag          = "Payment"                      /* ��������� �����Թ */ 
       brstat.tlt.cha_no        = TRIM(wpaid.refno) 
       brstat.tlt.rec_addr2     = TRIM(wpaid.trntyp)
       brstat.tlt.nor_usr_ins   = trim(wpaid.company_cod)  
       brstat.tlt.lotno         = trim(wpaid.company_nam)  
       brstat.tlt.nor_noti_ins  = trim(wpaid.pay_no)
       brstat.tlt.rec_addr5     = TRIM(wpaid.pay_mode)     
       brstat.tlt.ins_name      = trim(wpaid.pay_type)  
       brstat.tlt.rec_name      = trim(wpaid.card_no)  
       brstat.tlt.lince1        = trim(wpaid.card_type) 
       brstat.tlt.rec_addr1     = TRIM(wpaid.card_exp)  
       brstat.tlt.rec_addr3     = trim(wpaid.card_Hname)  
       brstat.tlt.old_cha       = trim(wpaid.card_bank)  
       brstat.tlt.gendat        = Date(wpaid.pay_due_date)  
       brstat.tlt.nor_coamt     = deci(wpaid.due_amount)  
       brstat.tlt.safe3         = trim(wpaid.promo_code)      
       brstat.tlt.safe2         = trim(wpaid.product_code)   
       /* comment by A63-0448
       brstat.tlt.policy        = ""
       brstat.tlt.datesent      = ?         /*Payment Date */
       brstat.tlt.rec_addr4     = ""        /*PaymentTrans */ 
       brstat.tlt.exp           = ""        /*Payment Amount   */
       brstat.tlt.safe1         = ""        /*Result           */
       brstat.tlt.comp_sub     = ""        /*ApprovalCode     */
       end a63-0448....*/
       /* add by A63-0448*/
       brstat.tlt.recac         = TRIM(wpaid.holdername)
       brstat.tlt.subins        = TRIM(wpaid.CustNo)
       brstat.tlt.policy        = TRIM(wpaid.policy)
       brstat.tlt.datesent      = IF trim(wpaid.PayDate) = "" THEN ? ELSE DATE(wpaid.paydate)         /*Payment Date */
       brstat.tlt.rec_addr4     = ""        /*PaymentTrans */ 
       brstat.tlt.exp           = trim(wpaid.PayAmount)         /*Payment Amount   */
       brstat.tlt.safe1         = trim(wpaid.nResult)           /*Result           */
       brstat.tlt.comp_sub      = TRIM(wpaid.ApproveNo)         /*ApprovalCode     */
       /* end a63-0448*/
       brstat.tlt.dat_ins_noti  = ?         /* �ѹ��� Match �ŵѴ�ѵ� */ 
       brstat.tlt.releas        = "NO"      /* yes = Match file �駼ŵѴ�ѵ�����, no  = �ѧ���Match file �駼ŵѴ�ѵ����� */
       brstat.tlt.filler1       = ""   /* �����˵� */
       brstat.tlt.imp           = ""  .     /* User update*/
       /*brstat.tlt.enttim        = IF tg_br = YES THEN "EMP" ELSE "ORA" . /*a63-0448*/*/ /*A65-0115*/
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
  DISPLAY fi_loaddat fi_compa ra_txttyp fi_filename fi_impcnt fi_completecnt 
          fi_proname2 cb_agent fi_insp ra_typfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_detail fi_loaddat fi_compa ra_txttyp fi_filename bu_file bu_ok 
         bu_exit br_imptxt cb_agent fi_insp ra_typfile RECT-1 RECT-387 RECT-388 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_cancel C-Win 
PROCEDURE import_cancel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH  wcancel :
    DELETE  wcancel.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wcancel.
    IMPORT DELIMITER "|"
      wcancel.recno     
      /*wcancel.Company   *//*comment by Kridtiya i. A63-0052*/
      wcancel.Product   
      wcancel.Branch    
      wcancel.contract  
      wcancel.comname   
      wcancel.licence   
      wcancel.chassis   
      wcancel.notify    
      wcancel.name      
      wcancel.comdate   
      /*wcancel.sale    *//*comment by Kridtiya i. A63-0052*/  
      wcancel.remark  .
      IF index(wcancel.recno,"�ӴѺ") <> 0 THEN DELETE wcancel.
      ELSE IF index(wcancel.recno,"no") <> 0 THEN DELETE wcancel. 
      ELSE IF wcancel.recno  = "" THEN  DELETE wcancel.

END.  /* repeat  */ 
FIND FIRST bfwcancel WHERE TRIM(bfwcancel.remark) <> ""  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL bfwcancel THEN DO:
        ASSIGN nv_reccnt       = 0
               nv_completecnt  = 0 
               nv_updatecnt    = 0. 
        Run  proc_chktlt_CA. 
    END.
    ELSE DO: 
       MESSAGE " Format ���¡��ԡ���١��ͧ " VIEW-AS ALERT-BOX.
       FOR EACH wcancel:
           DELETE wcancel.
       END.
       RETURN NO-APPLY.
    END.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.
Run Open_tlt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Match Cancel complete "  View-as alert-box.  


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_Inspection C-Win 
PROCEDURE Import_Inspection :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  winsp :
    DELETE  winsp.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE winsp.
    IMPORT DELIMITER "|"
        winsp.n_no       
        winsp.inscode     
        winsp.campcode    
        winsp.campname    
        winsp.procode     
        winsp.proname     
        winsp.packcode    
        winsp.packname    
        winsp.Refno       
        winsp.custcode
        winsp.pol_fname   
        winsp.pol_lname   
        winsp.pol_tel     
        winsp.tmp1
        winsp.tmp2
        winsp.instype     
        winsp.inspdate    
        winsp.insptime    
        winsp.inspcont    
        winsp.insptel     
        winsp.lineid      
        winsp.mail        
        winsp.inspaddr    
        winsp.brand       
        winsp.Model       
        winsp.class       
        winsp.seatenew    
        winsp.power       
        winsp.weight      
        winsp.province    
        winsp.yrmanu      
        winsp.licence     
        winsp.chassis     
        winsp.engine      
        winsp.comdat      
        winsp.expdat      
        winsp.ins_amt     
        winsp.premtotal   
        winsp.acc1        
        winsp.accdetail1  
        winsp.accprice1   
        winsp.acc2        
        winsp.accdetail2  
        winsp.accprice2   
        winsp.acc3        
        winsp.accdetail3  
        winsp.accprice3   
        winsp.acc4        
        winsp.accdetail4  
        winsp.accprice4   
        winsp.acc5        
        winsp.accdetail5  
        winsp.accprice5 . 

      IF index(winsp.n_no,"line") <> 0 THEN DELETE winsp.
      ELSE IF index(winsp.n_no,"no") <> 0 THEN DELETE winsp. 
      ELSE IF index(winsp.n_no,"num") <> 0 THEN DELETE winsp.
      ELSE IF winsp.n_no  = "" THEN  DELETE winsp.

END.  /* repeat  */ 
FIND FIRST bfwinsp WHERE index("0123456789",bfwinsp.n_no) <> 0 AND INDEX(bfwinsp.inscode,"�������") = 0  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL bfwinsp THEN DO:
        ASSIGN nv_reccnt       = 0
               nv_completecnt  = 0 
               nv_updatecnt    = 0. 
        Run  Create_tlt_insp. 
    END.
    ELSE DO: 
       MESSAGE " Format ����Ǩ��Ҿ���١��ͧ " VIEW-AS ALERT-BOX.
       FOR EACH winsp:
           DELETE winsp.
       END.
       RETURN NO-APPLY.
    END.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
    Run Open_tlt.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.


Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Inspection Finnish "  View-as alert-box.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_notification C-Win 
PROCEDURE import_notification :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
FOR EACH  wdetail2 :
    DELETE  wdetail2.
END.
RUN Proc_Cleardata.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|"
        n_cmr_code        /*InsuranceCode                    */ 
        n_campcode        /*CampaignCode                     */ 
        n_campname        /*CampaignName                     */ 
        n_proname         /*ProductName                      */ 
        n_packcode        /*ProspectID                       */ 
        n_pol_title       /*Holder_title                     */ 
        n_pol_fname       /*Holder_fname_thai                */ 
        n_pol_lname       /*Holder_sname_thai                */ 
        n_icno            /*Holder_id/Company                */ 
        n_sex             /*Holder_sex                       */ 
        n_bdate           /*Holder_birth_date                */ 
        n_moblie          /*Holder_mobile                    */ 
        n_addr1_72        /*Holder_Billing_address_line1     */ 
        n_addr2_72        /*Holder_Billing_address_line2     */ 
        n_addr3_72        /*Holder_Billing_address_line3     */ 
        n_addr4_72        /*Holder_Billing_address_line4     */ 
        n_addr5_72        /*Holder_Billing_address_line5     */ 
        n_nsub_dist72     /*Holder_Billing_Tambon            */ 
        n_ndirection72    /*Holder_Billing_District          */ 
        n_nprovin72       /*Holder_Billing_province          */ 
        n_zipcode72       /*Holder_Repost_code               */ 
        n_paytitle        /*Payer_title_name                 */ 
        n_payname         /*Payer_fname                      */ 
        n_paylname        /*Payer_sname                      */ 
        n_payicno         /*Payer_id_code                    */ 
        n_payaddr1        /*Holder_address_line1             */ 
        n_payaddr2        /*Holder_address_line2             */ 
        n_payaddr3        /*Holder_address_line3             */ 
        n_payaddr4        /*Holder_address_line4             */ 
        n_payaddr5        /*Holder_address_line5             */ 
        n_payaddr6        /*Holder_address_line6             */ 
        n_payaddr7        /*Holder_amp_code                  */ 
        n_payaddr8        /*Holder_prov_code                 */ 
        n_payaddr9        /*Holder_postcode                  */ 
        n_ben_title       /*Beneficiary_title_code           */ 
        n_ben_name        /*Beneficiary_fname                */ 
        n_ben_lname       /*Beneficiary_sname                */ 
        n_pmenttyp        /*payment_mode_Desc                */ 
        n_pmentcode2      /*payment_Channel                  */ 
        n_driver          /*Drivee_Status                    */ 
        n_drivetitle1     /*Driver1_title_code               */ 
        n_drivename1      /*Driver1_fname                    */ 
        n_drivelname1     /*Driver1_sname                    */ 
        n_driveno1        /*Driver1_id_code                  */ 
        n_occupdriv1      /*Driver1_Occupation               */ 
        n_sexdriv1        /*Driver1_Gender                   */ 
        n_bdatedriv1      /*Driver1_birth_date               */ 
        n_drivetitle2     /*Driver2_title_code               */ 
        n_drivename2      /*Driver2_fname                    */ 
        n_drivelname2     /*Driver2_sname                    */ 
        n_driveno2        /*Driver2_id_code                  */ 
        n_occupdriv2      /*Driver2_Occupation               */ 
        n_sexdriv2        /*Driver2_Gender                   */ 
        n_bdatedriv2      /*Driver2_birth_date               */ 
        n_brand           /*Brand                            */ 
        n_Model           /*Model                            */ 
        n_body            /*BodyType                         */ 
        n_licence         /*License_Plate                    */ 
        n_province        /*License_Prov_Code                */ 
        n_chassis         /*Chassis_No                       */ 
        n_engine          /*Engine No.                       */ 
        n_yrmanu          /*Model_Year                       */ 
        n_power           /*CC                               */ 
        n_class           /*Use Car Type                     */ 
        n_garage_cd       /*Garage_Code                      */ 
        n_colorcode       /*Color                            */ 
        n_covcod          /*Insurance_Type                   */ 
        n_comdat          /*term_Date_From                   */ 
        n_expdat          /*term_Date_To                     */ 
        n_ins_amt         /*Sum_Insured                      */ 
        n_prem1           /*Premium rate for Main Coveragtes */ 
        n_gross_prm       /*Net Premium                      */ 
        n_stamp           /*stamp_vmi                        */ 
        n_vat             /*tax_amt_vmi                      */ 
        n_premtotal       /*total_prem_vmi                   */ 
        n_deduct          /*Deduct_own_damage                */ 
        n_fleet           /*Amount Fleet Discount            */ 
        n_ncb             /*Amount No Claim Bonus            */ 
        n_drivdis         /*Amount Discount for Driver       */ 
        n_oth             /*Amount Other Discount            */ 
        n_cctv            /*Amount Car DashCam Discount      */ 
        n_Surchar         /*Amount Surcharge                 */ 
        n_Surchardetail   /*Surcharge Detail                 */ 
        n_accdetail1      /*accessory_remarks_01             */ 
        n_accprice1       /*accessory_suminsured_01          */ 
        n_accdetail2      /*accessory_remarks_02             */ 
        n_accprice2       /*accessory_suminsured_02          */ 
        n_accdetail3      /*accessory_remarks_03             */ 
        n_accprice3       /*accessory_suminsured_03          */ 
        n_accdetail4      /*accessory_remarks_04             */ 
        n_accprice4       /*accessory_suminsured_04          */ 
        n_accdetail5      /*accessory_remarks_05             */ 
        n_accprice5       /*accessory_suminsured_05          */ 
        n_inspdate        /*Car Inspection Date              */ 
        n_inspname        /*Car Inspection Name              */ 
        n_inspphone       /*Car Inspection Phone             */ 
        n_insploca        /*Car Inspection Location          */ 
        n_inspdetail      /*Detail Car Inspection            */ 
        n_not_date        /*Sale Date                        */ 
        n_delidetail      /*Delivery Remark Varchar          */ 
        n_cedcode         /*X-RefNo from Midas               */ 
        n_inscode         /*Cust.Code No                     */ 
        n_policy          /*Policy No                        */ 
        n_agentname       /*AgentName                        */
        /* add by : A67-0162 */
        n_tyeeng         /*EngineTypeGroup */              
        n_typMC          /*MCAutoTypeGroup */              
        n_watt           /*WATT            */              
        n_evmotor1       /*EVMotorNo1      */              
        n_evmotor2       /*EVMotorNo2      */              
        n_evmotor3       /*EVMotorNo3      */              
        n_evmotor4       /*EVMotorNo4      */              
        n_evmotor5       /*EVMotorNo5      */              
        n_evmotor6       /*EVMotorNo6      */              
        n_evmotor7       /*EVMotorNo7      */              
        n_evmotor8       /*EVMotorNo8      */              
        n_evmotor9       /*EVMotorNo9      */              
        n_evmotor10      /*EVMotorNo10     */              
        n_evmotor11      /*EVMotorNo11     */              
        n_evmotor12      /*EVMotorNo12     */              
        n_evmotor13      /*EVMotorNo13     */              
        n_evmotor14      /*EVMotorNo14     */              
        n_evmotor15      /*EVMotorNo15     */              
        n_carprice       /*CarPrice        */              
        n_drivlicen1     /*Driver1_DrivingLicenseNo */     
        n_drivcardexp1   /*Driver1_CardExpiryDate   */     
        n_drivcartyp1    /*Driver1_CardType         */     
        n_drivlicen2     /*Driver2_DrivingLicenseNo */     
        n_drivcardexp2   /*Driver2_CardExpiryDate   */     
        n_drivcartyp2    /*Driver2_CardType         */     
        n_drivetitle3    /*Driver3_title_code       */     
        n_drivename3     /*Driver3_fname            */     
        n_drivelname3    /*Driver3_sname            */     
        n_bdatedriv3     /*Driver3_birth_date       */     
        n_sexdriv3       /*Driver3_Gender           */     
        n_drivcartyp3    /*Driver3_CardType         */     
        n_driveno3       /*Driver3_id_code          */     
        n_drivlicen3     /*Driver3_DrivingLicenseNo */     
        n_drivcardexp3   /*Driver3_CardExpiryDate   */     
        n_occupdriv3     /*Driver3_Occupation       */     
        n_drivetitle4    /*Driver4_title_code       */     
        n_drivename4     /*Driver4_fname            */     
        n_drivelname4    /*Driver4_sname            */     
        n_bdatedriv4     /*Driver4_birth_date       */     
        n_sexdriv4       /*Driver4_Gender           */     
        n_drivcartyp4    /*Driver4_CardType         */     
        n_driveno4       /*Driver4_id_code          */     
        n_drivlicen4     /*Driver4_DrivingLicenseNo */     
        n_drivcardexp4   /*Driver4_CardExpiryDate   */     
        n_occupdriv4     /*Driver4_Occupation       */     
        n_drivetitle5    /*Driver5_title_code       */     
        n_drivename5     /*Driver5_fname            */     
        n_drivelname5    /*Driver5_sname            */     
        n_bdatedriv5     /*Driver5_birth_date       */     
        n_sexdriv5       /*Driver5_Gender           */     
        n_drivcartyp5    /*Driver5_CardType         */     
        n_driveno5       /*Driver5_id_code          */     
        n_drivlicen5     /*Driver5_DrivingLicenseNo */     
        n_drivcardexp5   /*Driver5_CardExpiryDate   */     
        n_occupdriv5     /*Driver5_Occupation       */     
        n_battflag       /*ChangeBattFlag           */     
        n_battyr         /*BattYear                 */     
        n_battdate       /*BattPurchaseDate         */     
        n_battprice      /*BattPrice                */     
        n_battno         /*BattSerialNo             */     
        n_battsi         /*BattRepSumInsured        */     
        n_chagreno       /*WallChargeNo             */     
        n_chagrebrand .  /*WallChargeBrand          */     
        /* end : A67-0167 */
       IF n_cmr_code   = "" THEN  NEXT.
       ELSE IF index(n_cmr_code,"Code") <> 0 THEN NEXT.
       /*ELSE IF trim(n_cmr_code) <> "KPI" THEN NEXT. */  /*Kridtiya i. A63-00052 */
       ELSE IF INDEX(n_cmr_code,"TMS") = 0 AND INDEX(n_cmr_code,"KPI") = 0 THEN NEXT.      /*Kridtiya i. A63-00052 */
       ELSE DO:
           RUN proc_create.
           RUN proc_cleardata.
       END.
END.  /* repeat  */ 

FIND FIRST bfwdetail WHERE /*INDEX(bfwdetail.comp_code,"�������") <> 0 AND */
                           /*trim(bfwdetail.cmr_code) = "KPI"  AND *//*Kridtiya i. A63-00052 */ 
                          (trim(bfwdetail.cmr_code) = "TMS"   OR     /*Kridtiya i. A63-00052 */ 
                           trim(bfwdetail.cmr_code) = "KPI")  AND    /*Kridtiya i. A63-00052 */ 
                           trim(bfwdetail.chassis)  <> ""    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL bfwdetail THEN DO:
         ASSIGN nv_reccnt       = 0
                nv_completecnt  = 0 
                nv_formold      = 0
                nv_formnew      = 0. 
           Run  Create_tlt_noti. 
    END.
    ELSE DO: 
        MESSAGE " Format ����駧ҹ���١��ͧ (���Ẻ����) " VIEW-AS ALERT-BOX.
       FOR EACH wdetail:
           DELETE wdetail.
       END.
       FOR EACH wdetail2:
           DELETE wdetail2.
       END.
       RETURN NO-APPLY.
   END.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
    Run Open_tlt.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Finnish "  View-as alert-box.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification-bp C-Win 
PROCEDURE Import_notification-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH  wdetail :
    DELETE  wdetail.
END.
FOR EACH  wdetail2 :
    DELETE  wdetail2.
END.
RUN Proc_Cleardata.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|"
        n_cmr_code     
        n_comp_code    
        n_campcode     
        n_campname     
        n_procode      
        n_proname      
        n_packname     
        n_packcode     
        n_instype      
        n_pol_title    
        n_pol_fname    
        n_pol_lname    
        n_pol_title_eng
        n_pol_fname_eng
        n_pol_lname_eng
        n_icno         
        n_sex          
        n_bdate        
        n_occup        
        n_tel          
        n_phone        
        n_teloffic     
        n_telext       
        n_moblie       
        n_mobliech     
        n_mail         
        n_lineid       
        n_addr1_70          /*�Ţ����ҹ   */  
        n_addr2_70          /*�����ҹ     */ 
        n_addr3_70          /*����         */ 
        n_addr4_70          /*���          */ 
        n_addr5_70          /*���          */ 
        n_nsub_dist70       /*�����ǧ     */ 
        n_ndirection70      /*ࢵ/�����    */ 
        n_nprovin70         /*�ѧ��Ѵ      */ 
        n_zipcode70         /*������ɳ��� */ 
        n_addr1_72          /*�Ţ����ҹ   �Ѵ�� */ 
        n_addr2_72          /*�����ҹ     �Ѵ�� */ 
        n_addr3_72          /*����         �Ѵ�� */ 
        n_addr4_72          /*���          �Ѵ�� */ 
        n_addr5_72          /*���          �Ѵ�� */ 
        n_nsub_dist72       /*�����ǧ     �Ѵ�� */ 
        n_ndirection72      /*ࢵ/�����    �Ѵ�� */ 
        n_nprovin72         /*�ѧ��Ѵ      �Ѵ�� */ 
        n_zipcode72         /*������ɳ��� �Ѵ�� */ 
        n_paytype         
        n_paytitle     
        n_payname      
        n_paylname     
        n_payicno      
        n_payaddr1          /*�Ţ����ҹ   �����Թ */      
        n_payaddr2          /*�����ҹ     �����Թ */   
        n_payaddr3          /*����         �����Թ */   
        n_payaddr4          /*���          �����Թ */   
        n_payaddr5          /*���          �����Թ */   
        n_payaddr6          /*�����ǧ     �����Թ */   
        n_payaddr7          /*ࢵ/�����    �����Թ */   
        n_payaddr8          /*�ѧ��Ѵ      �����Թ */   
        n_payaddr9          /*������ɳ��� �����Թ */   
        n_branch       
        n_ben_title    
        n_ben_name     
        n_ben_lname    
        n_pmentcode    
        n_pmenttyp     
        n_pmentcode1   
        n_pmentcode2   
        n_pmentbank    
        n_pmentdate    
        n_pmentsts     
        n_driver       
        n_drivetitle1  
        n_drivename1   
        n_drivelname1  
        n_driveno1     
        n_occupdriv1   
        n_sexdriv1     
        n_bdatedriv1   
        n_drivetitle2  
        n_drivename2   
        n_drivelname2  
        n_driveno2     
        n_occupdriv2   
        n_sexdriv2     
        n_bdatedriv2   
        n_brand        
        n_brand_cd     
        n_Model        
        n_Model_cd     
        n_body         
        n_body_cd      
        n_licence      
        n_province     
        n_chassis      
        n_engine       
        n_yrmanu       
        n_seatenew     
        n_power        
        n_weight       
        n_class        
        n_garage_cd    
        n_garage       
        n_colorcode    
        n_covcod       
        n_covtyp       
        n_covtyp1      
        n_covtyp2      
        n_covtyp3      
        n_comdat       
        n_expdat       
        n_ins_amt      
        n_prem1        
        n_gross_prm    
        n_stamp        
        n_vat          
        n_premtotal    
        n_deduct       
        n_fleetper     
        n_fleet        
        n_ncbper       
        n_ncb          
        n_drivper      
        n_drivdis      
        n_othper       
        n_oth          
        n_cctvper      
        n_cctv         
        n_Surcharper   
        n_Surchar      
        n_Surchardetail
        n_acc1         
        n_accdetail1   
        n_accprice1    
        n_acc2         
        n_accdetail2   
        n_accprice2    
        n_acc3         
        n_accdetail3   
        n_accprice3    
        n_acc4         
        n_accdetail4   
        n_accprice4    
        n_acc5         
        n_accdetail5   
        n_accprice5    
        n_inspdate     
        n_inspdate_app 
        n_inspsts      
        n_inspdetail   
        n_not_date     
        n_paydate      
        n_paysts       
        n_licenBroker  
        n_brokname     
        n_brokcode     
        n_lang         
        n_deli         
        n_delidetail   
        n_gift         
        n_cedcode      
        n_inscode      
        n_remark 
        n_policy .
        
       IF n_cmr_code   = "" THEN  NEXT.
       ELSE IF index(n_cmr_code,"Code") <> 0 THEN NEXT.
       ELSE IF trim(n_cmr_code) <> "KPI" THEN NEXT.
       ELSE DO:
           RUN proc_create.
           RUN proc_cleardata.
       END.
END.  /* repeat  */ 

FIND FIRST bfwdetail WHERE INDEX(bfwdetail.comp_code,"�������") <> 0 AND 
                           trim(bfwdetail.cmr_code) = "KPI"  AND 
                           trim(bfwdetail.chassis)  <> ""    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL bfwdetail THEN DO:
         ASSIGN nv_reccnt       = 0
                nv_completecnt  = 0 . 
           Run  Create_tlt_noti. 
    END.
    ELSE DO: 
        MESSAGE " Format ����駧ҹ���١��ͧ " VIEW-AS ALERT-BOX.
       FOR EACH wdetail:
           DELETE wdetail.
       END.
       FOR EACH wdetail2:
           DELETE wdetail2.
       END.
       RETURN NO-APPLY.
   END.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Finnish "  View-as alert-box.  
Run Open_tlt.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE import_notifi_old C-Win 
PROCEDURE import_notifi_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR n_undyr     AS CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE VAR n_notifyno  AS CHARACTER FORMAT "X(20)" NO-UNDO.
DEFINE VAR nv_message  AS CHARACTER                NO-UNDO.
DEFINE VAR n_running   AS INTE.
DEFINE VAR n_polno     AS CHAR FORMAT "X(8)".
DEFINE VAR nv_err      AS LOGICAL.
DEFINE VAR nv_complete AS INTE.
DEFINE VAR nv_ncomplete AS INTE.

FOR EACH wdetail01:
    DELETE wdetail01.
END.

INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail01.
    IMPORT DELIMITER "|"
        wdetail01.Company            /* 1   COMPANY CODE              */                   
        wdetail01.Porduct            /* 2   PRODUCT CODE              */  
        wdetail01.Branch             /* 3   BRANCH CODE               */  
        wdetail01.Contract           /* 4   CONTRACT NO.              */  
        wdetail01.nTITLE             /* 5   CUSTOMER THAI TITLE       */  
        wdetail01.name1              /* 6   FIRST NAME - THAI         */  
        wdetail01.name2              /* 7   LAST NAME  - THAI         */  
        wdetail01.idno               /* 8   CARD NO.                  */  
        wdetail01.addr1              /* 9   REGISTER ADDRESS LINE 1   */  
        wdetail01.addr2              /* 10  REGISTER ADDRESS LINE 2   */  
        wdetail01.addr3              /* 11  REGISTER ADDRESS LINE 3   */  
        wdetail01.addr4              /* 12  REGISTER ZIP.CODE         */  
        wdetail01.brand              /* 13  ������                    */  
        wdetail01.model              /* 14  ���                      */  
        wdetail01.coler              /* 15  ��ö                      */  
        wdetail01.vehreg             /* 16  ����¹ö                 */  
        wdetail01.provin             /* 17  �ѧ��Ѵ                   */  
        wdetail01.caryear            /* 18  ��ö                      */  
        wdetail01.cc                 /* 19  CC                        */  
        wdetail01.chassis            /* 20  �Ţ��Ƕѧ                 */  
        wdetail01.engno              /* 21  �Ţ����ͧ                */  
        wdetail01.notifyno           /* 22  CODE �����              */  
        wdetail01.AgencyEmployee     /* 23  ���ͼ���駧ҹ            */  
        wdetail01.covcod             /* 24  INSURANCE TYPE            */  
        wdetail01.Codecompany        /* 25  INSURANCE CODE            */  
        wdetail01.prepol             /* 26  �Ţ�����������           */  
        wdetail01.comdat70           /* 27  �ѹ������ͧ��.            */  
        wdetail01.expdat70           /* 28  �ѹ������ء�.             */  
        wdetail01.si                 /* 29  �ع��Сѹ                 */  
        wdetail01.siIns              /* 30  ���»�Сѹ�Ѻ�ҡ�١���   */  
        wdetail01.premt              /* 31  �����ط��                */  
        wdetail01.premtnet           /* 32  �����������              */  
        wdetail01.renew              /* 33  �ջ�Сѹ                  */  
        wdetail01.policy             /* 34  �Ţ����Ѻ��             */  
        wdetail01.notifydate         /* 35  �ѹ�駧ҹ                */  
        wdetail01.Deduct             /* 36  DEDUCT AMOUNT             */  
        wdetail01.InsCTP             /* 37  INSURER CTP               */  
        wdetail01.comdat72           /* 38  �ѹ��������ͧ �ú        */  
        wdetail01.expdat72           /* 39  �ѹ������ �ú             */  
        wdetail01.comp               /* 40  ������� �ú.             */  
        wdetail01.driverno           /* 41  �кؼ��Ѻ��������      */  
        wdetail01.drivername1        /* 42  ���Ѻ��褹��� 1          */  
        wdetail01.driverbrith1       /* 43  �ѹ��͹���Դ 1          */  
        wdetail01.drivericno1        /* 44  �����Ţ�ѵ� 1             */
        wdetail01.driverCard1        /* 45  DRIVER CARD 1             */
        wdetail01.driverexp1         /* 46  DRIVER CARD EXPIRE 1      */  
        wdetail01.drivername2        /* 47  ���Ѻ��褹��� 2          */  
        wdetail01.driverbrith2       /* 48  �ѹ��͹���Դ 2          */  
        wdetail01.drivericno2        /* 49  �����Ţ�ѵ� 2             */ 
        wdetail01.driverCard2        /* 50  DRIVER CARD 2             */
        wdetail01.driverexp2         /* 51  DRIVER CARD EXPIRE 2      */  
        wdetail01.garage             /* 52  ������ҧ                  */  
        wdetail01.InspectName        /* 53  ���ͼ���Ǩö             */  
        wdetail01.InspectPhoneNo     /* 54  �������Ѿ�����Ǩö    */  
        wdetail01.access             /* 55  ������ͧ�ػ�ó��������  */  
        wdetail01.Benefic            /* 56  ����Ѻ�Ż���ª��          */  
        wdetail01.Plus12             /* 57  FLAG FOR 12PLUS           */  .
END.
     
ASSIGN nv_reccnt       = 0
       nv_completecnt  = 0 
       nv_formold      = 0
       nv_formnew      = 0. 

FIND FIRST bfwdetail01 WHERE /*INDEX(bfwdetail.comp_code,"�������") <> 0 AND */
                           trim(bfwdetail01.branch) = "BRANCH CODE"  AND 
                           trim(bfwdetail01.chassis)  <> ""    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL bfwdetail01 THEN DO:
         ASSIGN nv_reccnt       = 0
                nv_completecnt  = 0 
                nv_formold      = 0
                nv_formnew      = 0. 
           RUN CREATE_tlt_noti_old.
    END.
    ELSE DO: 
        MESSAGE " Format ����駧ҹ���١��ͧ (���Ẻ���) " VIEW-AS ALERT-BOX.
        FOR EACH wdetail01:
            DELETE wdetail01.
        END.
        RETURN NO-APPLY.
   END.
If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt  With frame fr_main.
    Run Open_tlt.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Finnish "  View-as alert-box.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE IMPORT_Payment C-Win 
PROCEDURE IMPORT_Payment :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wpaid :
    DELETE  wpaid.
END.
IF ra_typfile = 1 THEN DO:
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wpaid.
        IMPORT DELIMITER "|"
            wpaid.company_cod        
            wpaid.company_nam        
            wpaid.RefNo          
            wpaid.Pay_no 
            wpaid.trntyp 
            wpaid.Pay_mode       
            wpaid.Pay_type       
            wpaid.card_no        
            wpaid.card_type      
            wpaid.card_exp       
            wpaid.card_Hname     
            wpaid.Card_bank      
            wpaid.Pay_due_date   
            wpaid.Due_Amount     
            wpaid.promo_code     
            wpaid.product_code   .
           IF index(wpaid.company_cod,"Insurance") <> 0  THEN DELETE wpaid.
           ELSE IF trim(wpaid.company_cod) = "" THEN DELETE wpaid.
    END.  /* repeat  */ 
    RELEASE wpaid .
END.
/* a63-0448*/
ELSE DO:
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wpaid.
        IMPORT DELIMITER "|"
            wpaid.company_cod        
            wpaid.company_nam 
            wpaid.holdername
            wpaid.RefNo          
            wpaid.Pay_no 
            wpaid.trntyp 
            wpaid.Pay_mode       
            wpaid.Pay_type       
            wpaid.card_no        
            wpaid.card_type      
            wpaid.card_exp       
            wpaid.card_Hname     
            wpaid.Card_bank      
            wpaid.Pay_due_date   
            wpaid.Due_Amount     
            wpaid.promo_code     
            wpaid.product_code  
            wpaid.CustNo    
            wpaid.PayDate   
            wpaid.PayAmount 
            wpaid.ApproveNo 
            wpaid.nResult   
            wpaid.PolicyNo .
           IF index(wpaid.company_cod,"Insurance") <> 0  THEN DELETE wpaid.
           ELSE IF trim(wpaid.company_cod) = "" THEN DELETE wpaid.
    END.  /* repeat  */ 
    RELEASE wpaid .
END.
/* end A63-0448*/
FIND FIRST bfwpaid WHERE index(bfwpaid.trntyp,"MI") <> 0 AND INDEX(bfwpaid.company_nam,"�������") <> 0 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL bfwpaid THEN DO:
        ASSIGN 
              nv_updatecnt    = 0
              nv_reccnt       = 0
              nv_completecnt  = 0 . 
        Run  Create_tlt_payment. 
    END.
    ELSE DO: 
        MESSAGE " Format ����駵Ѵ�ѵ��ôԵ���١��ͧ " VIEW-AS ALERT-BOX.
        FOR EACH wpaid:
            DELETE wpaid.
        END.
        RETURN NO-APPLY.
   END.

If  nv_completecnt  <>  0  Then do:
    Enable br_detail  With frame fr_main.
End. 

fi_completecnt  =  nv_completecnt.
fi_impcnt       =  nv_reccnt.

Disp fi_completecnt   fi_impcnt with frame  fr_main.
Message "Load  Data Payment Complete"  View-as alert-box.  
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
IF ra_txttyp = 1  THEN DO:
    IF ra_typfile = 2 THEN DO:
        Open Query br_imptxt  For each tlt  where
                   tlt.entdat     = TODAY       AND
                   tlt.genusr     = TRIM(fi_compa)   AND
                   (tlt.flag       = "V70"       OR  
                   tlt.flag       = "V72" )      NO-LOCK .
        
        DISP br_imptxt WITH FRAME fr_main.
        HIDE br_detail.
     END.
     ELSE DO:
         Open Query br_imptxt  For each tlt  where
                   tlt.entdat     = TODAY      AND
                   tlt.genusr     = trim(fi_compa)  AND
                  ( tlt.flag       <> "V70"     AND 
                   tlt.flag       <> "V72"     AND
                   tlt.flag       <> "INSPEC"  AND
                   tlt.flag       <> "Payment" ) NO-LOCK .
        DISP br_imptxt WITH FRAME fr_main.
        HIDE br_detail.
     END.

END.
ELSE IF ra_txttyp = 2  THEN DO:
    Open Query br_imptxt  For each tlt  Use-index tlt01  where
               tlt.trndat     = TODAY       AND
               (tlt.flag       = "INSPEC" )   AND
               tlt.genusr     =  fi_compa   NO-LOCK .
    
    DISP br_imptxt WITH FRAME fr_main.
    HIDE br_detail.
END.
ELSE IF ra_txttyp = 3 THEN do: 
    Open Query br_detail  For each tlt  Use-index tlt01  where
               tlt.trndat     =  TODAY        and
               (tlt.flag       = "Payment" )     AND
               tlt.genusr     =  fi_compa     NO-LOCK .
        
        DISP br_detail WITH FRAME fr_main .
        HIDE br_imptxt.
END.
ELSE DO:
  /*  Open Query br_imptxt  For each tlt  Use-index tlt01  where
                   tlt.entdat     = TODAY      AND 
                   tlt.flag       = "V70"      OR  
                   tlt.flag       = "V72"      OR 
                   tlt.flag       = "OLD"      AND
                   INDEX(tlt.releas,"CA")  <> 0 AND
                   tlt.genusr     =  fi_compa  NO-LOCK .
        DISP br_imptxt WITH FRAME fr_main.
        HIDE br_detail.*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adddatatlt C-Win 
PROCEDURE proc_adddatatlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN   brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
             brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
             brstat.tlt.trndat        = date(wdetail2.not_date)
             brstat.tlt.genusr        = "AYCAL"        
             brstat.tlt.usrid         = USERID(LDBNAME(1))          
             brstat.tlt.flag          = IF index(wdetail2.covtyp,"CMI") <> 0 THEN "V72" ELSE "V70"         
             brstat.tlt.policy        = ""       
             brstat.tlt.releas        = "NO"        
             /*brstat.tlt.subins        = "" */ /* A65-0115*/
             brstat.tlt.subins        = TRIM(nv_producer)  /* A65-0115*/
             brstat.tlt.recac         = TRIM(nv_agent)
             brstat.tlt.lotno         = "InsCode:" + trim(wdetail.cmr_code)  + " " +   /*���ʺ���ѷ��Сѹ��� */    
                                        "CamCode:" + trim(wdetail.campcode)  + " " +   /*������໭    */                   
                                        "CamName:" + trim(wdetail.campname)            /*������໭    */                   
             brstat.tlt.usrsent       = "ProName:" + trim(wdetail.proname ) + " " +          /*���ͼ�Ե�ѳ�� */                   
                                        "PackCod:" + trim(wdetail.packcode)            /*����ᾤࡨ    */              
             brstat.tlt.imp           = "Pol:" + TRIM(wdetail2.policy)                 /*�������������� */             
             brstat.tlt.ins_name      = "NameTha:" + trim(wdetail.pol_title) + " "     /*�ӹ�˹�Ҫ���  */                   
                                                   + trim(wdetail.pol_fname) + " "     /*���ͼ����һ�Сѹ    */                   
                                                   + trim(wdetail.pol_lname)          /*���ʡ�ż����һ�Сѹ */                   
                                                  
             brstat.tlt.rec_addr5     = "ICNo:"  + trim(wdetail.icno)  + " " +         /*�Ţ���ѵû�ЪҪ�/�Ţ������������   */  
                                        "Sex:"   + trim(wdetail.sex)   + " " +         /*��                          */          
                                        "Birth:" + trim(wdetail.bdate)                  /*�ѹ��͹���Դ ( DD/MM/YYYY) */        
                                               
             brstat.tlt.ins_addr5     = "Phone:" + TRIM(wdetail.phone)         /*�����ú�ҹ ���ӧҹ ��Ͷ��*/                 /*Line_ID */    
            /* brstat.tlt.ins_addr1     = trim(wdetail.addr1_70) + " " + trim(wdetail.addr2_70)  + " " +        /*�������١���*/    
                                        trim(wdetail.addr3_70) + " " + trim(wdetail.addr4_70)  + " " +        
                                        trim(wdetail.addr5_70)                                                
             brstat.tlt.ins_addr2     = trim(wdetail.nsub_dist70) + " " + trim(wdetail.ndirection70) + " " +  
                                        trim(wdetail.nprovin70) + " " + trim(wdetail.zipcode70) */              
             brstat.tlt.ins_addr3     = trim(wdetail.addr1_72) + " " + trim(wdetail.addr2_72) + " " +         /*�����٨Ѵ��*/        
                                        trim(wdetail.addr3_72) + " " + TRIM(wdetail.addr4_72) + " " +         
                                        trim(wdetail.addr5_72)                                                
             brstat.tlt.ins_addr4     = trim(wdetail.nsub_dist72) + " " + trim(wdetail.ndirection72) + " " +  
                                        trim(wdetail.nprovin72) + " " + TRIM(wdetail.zipcode72)               
             /*brstat.tlt.exp           = "PayTyp:" + TRIM(wdetail.paytype) + " " +                             /*������ �������Թ*/
                                        "Branch:" + TRIM(wdetail.branch) */                                     /*�Ң�*/
             brstat.tlt.rec_name      = trim(wdetail.paytitle) + " " + trim(wdetail.payname) + " " + TRIM(wdetail.paylname) /* ���� - ʡ�� �������Թ*/
             brstat.tlt.comp_sub      = trim(wdetail.payicno)                                                               /* �Ţ�ѵ� ���. �������Թ*/
             brstat.tlt.rec_addr1     = trim(wdetail.payaddr1) + " " + TRIM(wdetail.payaddr2) + " " +        /*��������͡����� */
                                        trim(wdetail.payaddr3) + " " + trim(wdetail.payaddr4) + " " + 
                                        trim(wdetail.payaddr5)
             brstat.tlt.rec_addr2     = trim(wdetail.payaddr6) + " " + TRIM(wdetail.payaddr7) + " " +
                                        trim(wdetail.payaddr8) + " " + trim(wdetail.payaddr9)
             brstat.tlt.safe1         = trim(wdetail.ben_title) + " " + TRIM(wdetail.ben_name) + " " + trim(wdetail.ben_lname) /*���� - ʡ�� ����Ѻ�Ż���ª��*/
             brstat.tlt.safe2         = /*"PaymentMD:"   + trim(wdetail.pmentcode)  + " " +*/ /*���ʻ�������ê������»�Сѹ*/  
                                        "PaymentMDTy:" + TRIM(wdetail.pmenttyp)   + " " + /*��������ê������»�Сѹ    */  
                                       /* "PaymentTyCd:" + trim(wdetail.pmentcode1) + " " + *//*���ʪ�ͧ�ҧ����������*/ 
                                        "Paymentty:"   + trim(wdetail.pmentcode2)         /*��ͧ�ҧ�����Ф������ */  
             /*brstat.tlt.safe3         = TRIM(wdetail.pmentbank) */                          /*��Ҥ�÷���������*/  
             /*brstat.tlt.rec_addr4     = "Paydat:" + trim(wdetail.pmentdate) + " " +       /*�ѹ�����Ф������*/  
                                        "PaySts:" + trim(wdetail.pmentsts)  + " " +       /*ʶҹС�ê������� */  
                                        "Paid:"   + trim(wdetail2.paysts)  */               /*ʶҹС�è����Թ*/
             brstat.tlt.datesent      = date(wdetail2.not_date)                           /*�ѹ�����       */
             /*brstat.tlt.dat_ins_noti  = date(wdetail2.paydate) */                           /*�ѹ����Ѻ�����Թ */  
             brstat.tlt.endcnt        = INT(wdetail.driver)                               /*����кت��ͼ��Ѻ */                                                                   
             brstat.tlt.dri_name1     = "Drinam1:" + trim(wdetail.drivetitle1) + " " +    /*�ӹ�˹�Ҫ��� ���Ѻ��� 1  */ 
                                                     trim(wdetail.drivename1)  + " " +    /*���ͼ��Ѻ��� 1 */    
                                                     trim(wdetail.drivelname1) + " " +    /*���ʡ�� ���Ѻ��� 1   */  
                                        "DriId1:"  + trim(wdetail.driveno1)               /*�Ţ���ѵü��Ѻ��� 1 */  
             brstat.tlt.dri_no1       = "DriOcc1:" + trim(wdetail.occupdriv1) + " " +     /*Driver1Occupation  */  
                                        "DriSex1:" + TRIM(wdetail.sexdriv1)   + " " +     /*�� ���Ѻ��� 1 */ 
                                        "DriBir1:" + trim(wdetail.bdatedriv1)             /*�ѹ��͹���Դ���Ѻ��� 1 */ 
             brstat.tlt.dri_name2     = "Drinam2:" + trim(wdetail.drivetitle2) + " " +    /*�ӹ�˹�Ҫ��� ���Ѻ��� 2  */ 
                                                     trim(wdetail.drivename2)  + " " +    /*���ͼ��Ѻ��� 2    */ 
                                                     trim(wdetail.drivelname2) + " " +    /*���ʡ�� ���Ѻ��� 2*/
                                        "DriId2:"  + trim(wdetail.driveno2)               /*�Ţ���ѵü��Ѻ���2 */ 
             brstat.tlt.dri_no2       = "DriOcc2:" + trim(wdetail.occupdriv2) + " " +     /*Driver2Occupation  */
                                        "DriSex2:" + TRIM(wdetail.sexdriv2)   + " " +      /*�� ���Ѻ��� 2    */
                                        "DriBir2:" + trim(wdetail.bdatedriv2)  .           /*�ѹ��͹���Դ���Ѻ��� 2 */
             
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adddatatlt2 C-Win 
PROCEDURE proc_adddatatlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN 
           brstat.tlt.brand         = TRIM(wdetail2.brand)           /*����ö¹��         */                                    
           brstat.tlt.model         = trim(wdetail2.Model)           /*�������ö¹��     */                                    
           brstat.tlt.expousr       = trim(wdetail2.body)            /*Ẻ��Ƕѧ          */                                    
           brstat.tlt.lince1        = trim(wdetail2.licence)         /*����¹ö          */                                    
           brstat.tlt.lince2        = trim(wdetail2.province)        /*�ѧ��Ѵ��訴����¹*/                                    
           brstat.tlt.cha_no        = CAPS(trim(wdetail2.chassis))   /*�Ţ��Ƕѧ          */                                    
           /*brstat.tlt.eng_no        = CAPS(trim(wdetail2.engine)) */ /*A65-0115*/    /*�Ţ����ͧ¹��     */
           brstat.tlt.eng_no        = IF SUBSTR(wdetail2.engine,1,1)  = "'" THEN CAPS(trim(replace(wdetail2.engine,"'",""))) 
                                      ELSE CAPS(TRIM(wdetail2.engine))    /*A65-0115*/
           brstat.tlt.gentim        = trim(wdetail2.yrmanu)          /*�ը�����¹ö      */                                    
           /*brstat.tlt.sentcnt       = INT(wdetail2.seatenew) */        /*�ӹǹ�����       */                                    
           brstat.tlt.rencnt        = INT(wdetail2.power)            /*��Ҵ����ͧ¹��    */                                    
           /*brstat.tlt.cc_weight     = INT(wdetail2.weight)  */         /*���˹ѡ            */                                    
           brstat.tlt.expotim       = trim(wdetail2.class)           /*���ʡ����ö¹��   */                                    
           brstat.tlt.old_cha       = "GarCd:" + trim(wdetail2.garage_cd)  /*���ʡ�ë���        */                 
                                     /* "GarTy:" + trim(wdetail2.garage)   */         /*��������ë���      */                 
           brstat.tlt.colorcod      = "" /* contact no , branch �ҡ���͹����� */                                             
           brstat.tlt.rec_addr3     = "CovCod:" + trim(wdetail2.covcod)  + " " +        /*�������ͧ��Сѹ���        */    
                                      "CovTcd:" + trim(wdetail2.covtyp)          /*���ʻ������ͧ��Сѹ���    */    
                                     /* "CovTyp:" + trim(wdetail2.covtyp1) + " " +        /*�������ͧ����������ͧ     */    
                                      "CovTy1:" + trim(wdetail2.covtyp2) + " " +        /*���������¢ͧ����������ͧ */    
                                      "CovTy2:" + trim(wdetail2.covtyp3) */               /*��������´����������ͧ    */    
           brstat.tlt.gendat        = date(wdetail2.comdat)                             /*�ѹ���������������ͧ      */    
           brstat.tlt.expodat       = DATE(wdetail2.expdat)                             /*�ѹ�������ش����������ͧ */    
           brstat.tlt.nor_coamt     = DECI(wdetail2.ins_amt)                            /*�ع��Сѹ                 */    
           brstat.tlt.nor_grprm     = DECI(wdetail2.prem1)                              /*�����ط�ԡ�͹�ѡ��ǹŴ   */    
           brstat.tlt.comp_grprm    = DECI(wdetail2.gross_prm)                          /*�����ط����ѧ�ѡ��ǹŴ   */    
           brstat.tlt.stat          = "Stm:" + STRING(deci(wdetail2.stamp)) + " " +     /*�ӹǹ�ҡ������       */    
                                      "Vat:" + STRING(DECI(wdetail2.vat))               /*�ӹǹ���� SBT/Vat     */    
           brstat.tlt.comp_coamt    = deci(wdetail2.premtotal)                          /*������� ����-�ҡ�    */    
           brstat.tlt.endno         = string(DECI(wdetail2.deduct))                     /*��Ҥ������������ǹ�á */    
           brstat.tlt.comp_sck      = /*"fetP:" + STRING(DECI(wdetail2.fleetper)) + " " +*/ /*% ��ǹŴ�����         */    
                                      "felA:" + STRING(DECI(wdetail2.fleet))            /*�ӹǹ��ǹŴ�����      */    
           brstat.tlt.comp_noti_tlt = /*"NcbP:" + string(DECI(wdetail2.ncbper)) + " " + */  /*% ��ǹŴ����ѵԴ�     */    
                                      "NcbA:" + string(DECI(wdetail2.ncb))              /*�ӹǹ��ǹŴ����ѵԴ�  */    
           brstat.tlt.comp_usr_tlt  = /*"DriP:" + string(DECI(wdetail2.drivper)) + " " +*/  /*% ��ǹŴ�óռ��Ѻ��� */    
                                      "DriA:" + string(DECI(wdetail2.drivdis))          /*�ӹǹ��ǹŴ�óռ��Ѻ���  */    
           brstat.tlt.comp_noti_ins = /*"OthP:" + string(DECI(wdetail2.othper)) + " " +*/   /*%�ǹŴ����           */    
                                      "OthA:" + string(DECI(wdetail2.oth))              /*�ӹǹ��ǹŴ����      */    
           brstat.tlt.comp_usr_ins  = /*"CTVP:" + string(DECI(wdetail2.cctvper)) + " " +*/  /*%�ǹŴ���ͧ           */    
                                      "CTVA:" + string(DECI(wdetail2.cctv))             /*�ӹǹ��ǹŴ���ͧ      */    
           brstat.tlt.comp_pol      = /*"SurP:" + string(DECI(wdetail2.Surcharper)) + " " + */ /*%��ǹŴ����        */   
                                      "SurA:" + string(DECI(wdetail2.Surchar))    + " " + /*�ӹǹ��ǹŴ����    */    
                                      "SurD:" + trim(wdetail2.Surchardetail)              /*��������´��ǹ���� */    
           brstat.tlt.filler1       = /*"Acc1:" + trim(wdetail2.acc1)       + " " +   */      /*���� �ػ�ó�1  */   
                                      "Acd1:" + trim(wdetail2.accdetail1) + " " +         /*��������´1    */    
                                      "Acp1:" + STRING(DECI(wdetail2.accprice1))  + " " + /*�Ҥ��ػ�ó�1   */    
                                      /*"Acc2:" + trim(wdetail2.acc2)       + " " +   */      /*���� �ػ�ó�2  */    
                                      "Acd2:" + trim(wdetail2.accdetail2) + " " +         /*��������´2    */    
                                      "Acp2:" + STRING(DECI(wdetail2.accprice2))  + " " + /*�Ҥ��ػ�ó�2   */    
                                     /* "Acc3:" + trim(wdetail2.acc3)       + " " +    */     /*���� �ػ�ó�3  */    
                                      "Acd3:" + trim(wdetail2.accdetail3) + " " +         /*��������´3    */    
                                      "Acp3:" + STRING(DECI(wdetail2.accprice3))  + " " + /*�Ҥ��ػ�ó�3   */    
                                     /* "Acc4:" + trim(wdetail2.acc4)       + " " +    */     /*���� �ػ�ó�4  */    
                                      "Acd4:" + trim(wdetail2.accdetail4) + " " +         /*��������´ 4   */    
                                      "Acp4:" + STRING(DECI(wdetail2.accprice4))  + " " + /*�Ҥ��ػ�ó�4   */    
                                    /*  "Acc5:" + trim(wdetail2.acc5)       + " " +    */     /*���� �ػ�ó�5  */    
                                      "Acd5:" + TRIM(wdetail2.accdetail5) + " " +        /*��������´ 5   */    
                                      "Acp5:" + STRING(deci(wdetail2.accprice5))         /*�Ҥ��ػ�ó�5     */    
           brstat.tlt.nor_effdat    = date(wdetail2.inspdate)                           /*�ѹ����Ǩ��Ҿö */    
           /*brstat.tlt.comp_effdat   = date(wdetail2.inspdate_app)       */                /*�ѹ���͹��ѵԵ�Ǩ��Ҿö   */    
           brstat.tlt.nor_noti_tlt  = /*"InspSt:" + trim(wdetail2.inspsts) + " " +   */     /*�š�õ�Ǩ��Ҿö           */    
                                       "InspDe:" + trim(wdetail2.inspdetail)             /*��������´��õ�Ǩ��Ҿö   */    
           /*brstat.tlt.old_eng       = "BLice:"  + trim(wdetail2.licenBroker) + " " +    /*�Ţ����͹حҵ���˹��   */      
                                      "Bname:"  + trim(wdetail2.brokname) + " " +       /*���ͺ���ѷ���˹��       */      
                                      "Bcode:"  + trim(wdetail2.brokcode)     */          /*�����ä����           */ 
           wdetail2.colorcode       = IF trim(wdetail2.colorcode) = "" THEN "" ELSE  "��ö:" + trim(wdetail2.colorcode) /*��ö¹��  */
           brstat.tlt.filler2       = /*"Detai1:" + trim(wdetail2.lang) + " " +           /*����㹡���͡��������    */      
                                      "Detai2:" + trim(wdetail2.deli) + " " +   */        /*��ͧ�ҧ��èѴ��        */      
                                      "Detai3:" + trim(wdetail2.delidetail) + " " +     /*�����˵ء�èѴ��       */      
                                     /* "Detai4:" + trim(wdetail2.gift) + " " +    */       /*�ͧ��                  */      
                                      "Remark:" + trim(wdetail2.remark) /* + wdetail2.colorcode*/    /*�����˵�                */    /*��ö¹��  */  
           brstat.tlt.note1         = trim(wdetail2.colorcode)  /*A66-0160 */ 
           brstat.tlt.nor_noti_ins  = trim(wdetail2.cedcode)                            /*�Ţ�����ҧ�ԧ ����������ͧ*/    
           brstat.tlt.nor_usr_ins   = trim(wdetail2.inscode)                           /*Cust.Code No              */ 
           brstat.tlt.old_eng       = "Bphon:"  + trim(wdetail2.inspphone) + " " +   /* Car Inspection Phone            */
                                      "Bname:"  + trim(wdetail2.inspname) + " " +   /* Car Inspection Name             */         
                                      "Bloca:"  + trim(wdetail2.insploca)            /* Car Inspection Location         */
           brstat.tlt.exp           = TRIM(wdetail2.agname)  
           /*brstat.tlt.ins_addr1     = IF tg_br = YES THEN "EMP" ELSE "ORA" . /*A63-0448*/*/ /*A65-0115*/
           brstat.tlt.ins_addr1     = TRIM(nv_branch)  /*A65-0115*/
           brstat.tlt.dealer        = TRIM(nv_dealer).  /*A65-0115*/ 
          /* Add by : A67-0162 */
           ASSIGN 
           brstat.tlt.note2         = trim(wdetail2.tyeeng)   
           brstat.tlt.note3         = trim(wdetail2.typMC)   
           brstat.tlt.watts         = DECI(wdetail2.watt)   
           brstat.tlt.note4         = trim(wdetail2.evmotor1)
           brstat.tlt.note5         = trim(wdetail2.evmotor2)
           brstat.tlt.note6         = trim(wdetail2.evmotor3)
           brstat.tlt.note7         = trim(wdetail2.evmotor4)
           brstat.tlt.note8         = trim(wdetail2.evmotor5)
           brstat.tlt.note9         = trim(wdetail2.evmotor6)
           brstat.tlt.note10        = trim(wdetail2.evmotor7)
           brstat.tlt.note11        = trim(wdetail2.evmotor8)
           brstat.tlt.note12        = trim(wdetail2.evmotor9)
           brstat.tlt.note13        = trim(wdetail2.evmotor10)
           brstat.tlt.note14        = trim(wdetail2.evmotor11)
           brstat.tlt.note15        = trim(wdetail2.evmotor12)
           brstat.tlt.note16        = trim(wdetail2.evmotor13)
           brstat.tlt.note17        = trim(wdetail2.evmotor14)
           brstat.tlt.note18        = trim(wdetail2.evmotor15)
           brstat.tlt.maksi         = DECI(wdetail2.carprice)
           brstat.tlt.dri_lic1      = trim(wdetail2.drivlicen1)  
           brstat.tlt.dri_licenexp1 = trim(wdetail2.drivcardexp1) 
           brstat.tlt.dri_ic1       = trim(wdetail2.drivcartyp1)  
           brstat.tlt.dri_lic2      = trim(wdetail2.drivlicen2)  
           brstat.tlt.dri_licenexp2 = trim(wdetail2.drivcardexp2) 
           brstat.tlt.dri_ic2       = trim(wdetail2.drivcartyp2)  
           brstat.tlt.dri_title3    = trim(wdetail2.drivetitle3)  
           brstat.tlt.dri_fname3    = trim(wdetail2.drivename3)  
           brstat.tlt.dri_lname3    = trim(wdetail2.drivelname3)  
           brstat.tlt.dri_birth3    = trim(wdetail2.bdatedriv3)  
           brstat.tlt.dri_gender3   = trim(wdetail2.sexdriv3)  
           brstat.tlt.dri_ic3       = trim(wdetail2.drivcartyp3)  
           brstat.tlt.dri_no3       = trim(wdetail2.driveno3)  
           brstat.tlt.dri_lic3      = trim(wdetail2.drivlicen3)  
           brstat.tlt.dri_licenexp3 = trim(wdetail2.drivcardexp3) 
           brstat.tlt.dir_occ3      = trim(wdetail2.occupdriv3)  
           brstat.tlt.dri_title4    = trim(wdetail2.drivetitle4)  
           brstat.tlt.dri_fname4    = trim(wdetail2.drivename4)  
           brstat.tlt.dri_lname4    = trim(wdetail2.drivelname4)  
           brstat.tlt.dri_birth4    = trim(wdetail2.bdatedriv4)  
           brstat.tlt.dri_gender4   = trim(wdetail2.sexdriv4)  
           brstat.tlt.dri_ic4       = trim(wdetail2.drivcartyp4) 
           brstat.tlt.dri_no4       = trim(wdetail2.driveno4)  
           brstat.tlt.dri_lic4      = trim(wdetail2.drivlicen4)  
           brstat.tlt.dri_licenexp4 = trim(wdetail2.drivcardexp4) 
           brstat.tlt.dri_occ4      = trim(wdetail2.occupdriv4)  
           brstat.tlt.dri_title5    = trim(wdetail2.drivetitle5)  
           brstat.tlt.dri_fname5    = trim(wdetail2.drivename5)  
           brstat.tlt.dri_lname5    = trim(wdetail2.drivelname5)  
           brstat.tlt.dri_birth5    = trim(wdetail2.bdatedriv5)   
           brstat.tlt.dri_gender5   = trim(wdetail2.sexdriv5)   
           brstat.tlt.dri_ic5       = trim(wdetail2.drivcartyp5)  
           brstat.tlt.dri_no5       = trim(wdetail2.driveno5)   
           brstat.tlt.dri_lic5      = trim(wdetail2.drivlicen5)   
           brstat.tlt.dri_licenexp5 = trim(wdetail2.drivcardexp5) 
           brstat.tlt.dri_occ5      = trim(wdetail2.occupdriv5)   
           brstat.tlt.battflg       = IF trim(wdetail2.battflag) = "Y" THEN YES ELSE NO  
           brstat.tlt.battyr        = trim(wdetail2.battyr)   
           brstat.tlt.ndate1        = IF trim(wdetail2.battdate) <> "" THEN DATE(wdetail2.battdate) ELSE ?  
           brstat.tlt.battprice     = DECI(wdetail2.battprice)   
           brstat.tlt.battno        = trim(wdetail2.battno)   
           brstat.tlt.battsi        = DECI(wdetail2.battsi)   
           brstat.tlt.chargno       = trim(wdetail2.chagreno)   
           brstat.tlt.note19        = trim(wdetail2.chagrebrand) .
          /* end : A67-0162 */

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addtlt_old C-Win 
PROCEDURE proc_addtlt_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bftlt FOR brstat.tlt.
DEFINE VAR n_undyr      AS CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE VAR n_notifyno   AS CHARACTER FORMAT "X(20)" NO-UNDO.
DEFINE VAR nv_message   AS CHARACTER                NO-UNDO.
DEFINE VAR n_running    AS INTE.
DEFINE VAR n_polno      AS CHAR FORMAT "X(8)".
DEFINE VAR nv_err       AS LOGICAL.
DEFINE VAR nv_complete  AS INTE.
DEFINE VAR nv_ncomplete AS INTE.
DEFINE VAR Choice       AS LOGICAL   INIT NO NO-UNDO.
DEFINE VAR nv_update    AS LOGICAL INIT NO.
DO:
    ASSIGN  n_undyr          = STRING(YEAR(TODAY) + 543 ,"9999")
            nv_message       = "" .
            running_polno: /*-- Running --*/
            REPEAT:
                n_running = n_running + 1.
                RUN wgw\wgwpolay (INPUT        YES,
                                  INPUT        "V70", 
                                  INPUT        "STY", 
                                  INPUT        n_undyr,
                                  INPUT        "A0M0061",
                                  INPUT-OUTPUT n_notifyno,   
                                  INPUT-OUTPUT nv_message). 
                IF nv_message <> "" THEN DO:
                    IF n_running > 10 THEN DO: 
                        n_notifyno = "".
                        LEAVE running_polno.
                    END.
                END.
                FIND LAST bftlt WHERE bftlt.genusr       = "aycal"    AND
                                    bftlt.nor_noti_tlt   = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                IF NOT AVAIL bftlt THEN LEAVE running_polno.
            END.   

            IF n_notifyno = "" THEN DO:
                n_polno    = SUBSTR(wdetail01.Contract,1,8).
                n_notifyno = "STY" + SUBSTR(STRING(YEAR(TODAY)),3,2) + STRING(n_polno,"99999999").

                FIND LAST bftlt WHERE bftlt.genusr       = "aycal"    AND
                                      bftlt.nor_noti_tlt = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL bftlt THEN DO:
                    MESSAGE "���Ţ�Ѻ�� " n_notifyno " ��к����� " VIEW-AS ALERT-BOX.
                    nv_err     = YES.
                    nv_ncomplete = nv_ncomplete + 1.
                END.
            END.
           IF nv_err = NO THEN DO: 
                /*CREATE tlt.*/
                ASSIGN
                    brstat.tlt.entdat            = TODAY                                                  
                    brstat.tlt.enttim            = STRING(TIME,"HH:MM:SS")                            
                    brstat.tlt.trntime           = STRING(TIME,"HH:MM:SS")                            
                    brstat.tlt.trndat            = TODAY                   
                    brstat.tlt.genusr            = "AYCAL"                       /* 1   COMPANY CODE              */                   
                    brstat.tlt.flag              = trim(wdetail01.Porduct)         /* 2   PRODUCT CODE              */  
                    brstat.tlt.comp_usr_tlt      = trim(wdetail01.Branch)          /* 3   BRANCH CODE               */  
                    brstat.tlt.recac             = trim(wdetail01.Contract)        /* 4   CONTRACT NO.              */  
                    brstat.tlt.ins_name          = trim(wdetail01.nTITLE) + " " +  /* 5   CUSTOMER THAI TITLE       */  
                                                   trim(wdetail01.name1)  + " " +  /* 6   FIRST NAME - THAI         */  
                                                   trim(wdetail01.name2)           /* 7   LAST NAME  - THAI         */  
                    brstat.tlt.safe2             = trim(wdetail01.idno)            /* 8   CARD NO.                  */  
                    brstat.tlt.ins_addr1         = TRIM(np_addr1)                /* 9   REGISTER ADDRESS LINE 1   */  
                    brstat.tlt.ins_addr2         = TRIM(np_addr2)                /* 10  REGISTER ADDRESS LINE 2   */  
                    brstat.tlt.ins_addr3         = TRIM(np_addr3)                /* 11  REGISTER ADDRESS LINE 3   */  
                    brstat.tlt.ins_addr4         = TRIM(np_addr4)                /* 12  REGISTER ADDRESS LINE 4   */  
                    brstat.tlt.ins_addr5         = TRIM(np_addr5)                /* 12  REGISTER ZIP.CODE         */ 
                    brstat.tlt.brand             = TRIM(wdetail01.brand)           /* 13  ������                    */  
                    brstat.tlt.model             = TRIM(wdetail01.model)           /* 14  ���                      */  
                    brstat.tlt.lince1            = TRIM(wdetail01.vehreg) + " " +  /* 16  ����¹ö                 */  
                                                   TRIM(wdetail01.provin)          /* 17  �ѧ��Ѵ                   */  
                    brstat.tlt.lince2            = TRIM(wdetail01.caryear)         /* 18  ��ö                      */  
                    brstat.tlt.cc_weight         = DECI(wdetail01.cc)              /* 19  CC                        */  
                    brstat.tlt.cha_no            = TRIM(wdetail01.chassis)         /* 20  �Ţ��Ƕѧ                 */  
                    brstat.tlt.eng_no            = TRIM(wdetail01.engno)           /* 21  �Ţ����ͧ                */  
                    brstat.tlt.comp_noti_tlt     = TRIM(wdetail01.notifyno)        /* 22  CODE �����              */  
                    brstat.tlt.safe3             = TRIM(wdetail01.covcod)          /* 24  INSURANCE TYPE            */  
                    brstat.tlt.nor_usr_ins       = TRIM(wdetail01.Codecompany)     /* 25  INSURANCE CODE            */  
                    brstat.tlt.nor_noti_ins      = TRIM(wdetail01.prepol)          /* 26  �Ţ�����������           */     
                    brstat.tlt.nor_effdat        = DATE(SUBSTR(TRIM(wdetail01.comdat70),5,2) + "/" +
                                                   SUBSTR(TRIM(wdetail01.comdat70),3,2) + "/" +
                                                   STRING(DECI("25" + SUBSTR(TRIM(wdetail01.comdat70),1,2)) - 543))  /* 27  �ѹ������ͧ��.  */  
                    brstat.tlt.expodat           = DATE(SUBSTR(TRIM(wdetail01.expdat70),5,2) + "/" +                                        
                                                   SUBSTR(TRIM(wdetail01.expdat70),3,2) + "/" +                                             
                                                   STRING(DECI("25" + SUBSTR(TRIM(wdetail01.expdat70),1,2)) - 543))  /* 28  �ѹ������ء�.   */  
                    brstat.tlt.comp_coamt        = IF DECI(wdetail01.si) = 0 THEN 0 ELSE DECI(wdetail01.si)     /* 29  �ع��Сѹ       */ 
                    brstat.tlt.sentcnt           = DECI(wdetail01.siIns)         /* 30  ���»�Сѹ�Ѻ�ҡ�١��� */                            
                    brstat.tlt.dri_name2         = STRING(DECI(wdetail01.premt)) /* 31  �����ط��              */  
                    brstat.tlt.nor_grprm         = DECI(wdetail01.premtnet)      /* 32  �����������            */  
                    brstat.tlt.rencnt            = DECI(wdetail01.renew)         /* 33  �ջ�Сѹ                */  
                                                                        /* 32  �Ţ�Ѻ��   tlt.nor_noti_tlt   = trim(wdetail01.policy) */ 
                    brstat.tlt.nor_noti_tlt      = n_notifyno
                    brstat.tlt.datesent          = IF TRIM(wdetail01.notifydate) = "" THEN ? 
                                                   ELSE DATE(SUBSTR(TRIM(wdetail01.notifydate),5,2) + "/" +         /*33  �ѹ�����*/                                                                     
                                                   SUBSTR(TRIM(wdetail01.notifydate),3,2) + "/" +
                                                   STRING(DECI("25" + SUBSTR(TRIM(wdetail01.notifydate),1,2)) - 543))  
                    brstat.tlt.seqno             = DECI(wdetail01.Deduct)          /* 36  DEDUCT AMOUNT             */  
                    brstat.tlt.comp_effdat       = IF wdetail01.comdat72 = "" THEN ? 
                                                   ELSE IF wdetail01.comdat72 = "0" THEN ?
                                                   ELSE DATE(SUBSTR(TRIM(wdetail01.comdat72),5,2) + "/" +         /*36  �ѹ������ͧ�ú.*/ 
                                                   SUBSTR(TRIM(wdetail01.comdat72),3,2) + "/" +
                                                   STRING(DECI("25" + SUBSTR(TRIM(wdetail01.comdat72),1,2)) - 543))
                    brstat.tlt.dat_ins_noti      = IF wdetail01.expdat72 = "" THEN ? 
                                                   ELSE IF wdetail01.expdat72 = "0" THEN ?
                                                   ELSE DATE(SUBSTR(TRIM(wdetail01.expdat72),5,2) + "/" +        /*37  �ѹ����ú.*/ 
                                                   SUBSTR(TRIM(wdetail01.expdat72),3,2) + "/" +
                                                   STRING(DECI("25" + SUBSTR(TRIM(wdetail01.expdat72),1,2)) - 543))
                    brstat.tlt.dri_no1           = TRIM(wdetail01.comp)            /* 40  ������� �ú.             */  
                    brstat.tlt.dri_name1         = IF TRIM(wdetail01.driverno) = "" THEN "1" ELSE "2" /* 41  �кؼ��Ѻ��������      */  
                    brstat.tlt.dri_no2           = "N1:"  + trim(wdetail01.drivername1)  + " " +       /* 42 ���Ѻ��褹��� 1     */    
                                                   "B1:"  + trim(wdetail01.driverbrith1) + " " +       /* 43 �ѹ��͹���Դ 1     */    
                                                   "IC1:" + trim(wdetail01.drivericno1)  + " " +       /* 44 �����Ţ�ѵ� 1        */   
                                                   "DC1:" + trim(wdetail01.driverCard1)  + " " +       /* 45 DRIVER CARD 1        */   
                                                   "EP1:" + trim(wdetail01.driverexp1)   + " " +       /* 46 DRIVER CARD EXPIRE 1 */    
                                                   "N2:"  + trim(wdetail01.drivername2)  + " " +       /* 47 ���Ѻ��褹��� 2     */    
                                                   "B2:"  + trim(wdetail01.driverbrith2) + " " +       /* 48 �ѹ��͹���Դ 2     */    
                                                   "IC2:" + trim(wdetail01.drivericno2)  + " " +       /* 49 �����Ţ�ѵ� 1        */    
                                                   "DC2:" + trim(wdetail01.driverCard2)  + " " +       /* 50 DRIVER CARD 2        */ 
                                                   "EP2:" + trim(wdetail01.driverexp2)   + " " +       /* 51 DRIVER CARD EXPIRE 2 */     
                                                   "AG:"  + TRIM(wdetail01.AgencyEmployee) + " " +     /* 23  ���ͼ���駧ҹ      */                     
                                                   "CTP:" + TRIM(wdetail01.InsCTP)                    /* 37  INSURER CTP         */ 
                    brstat.tlt.stat               = TRIM(wdetail01.garage)                            /* 52  ������ҧ            */  
                    brstat.tlt.usrsent            = "IN:"  + trim(wdetail01.InspectName)  + " " +      /* 53  ���ͼ���Ǩö       */  
                                                    "IP:"  + trim(wdetail01.InspectPhoneNo)            /* 54  �������Ѿ�����Ǩö */    
                    brstat.tlt.safe1              = TRIM(wdetail01.access) /* 53  ������ͧ�ػ�ó��������  */  
                    brstat.tlt.filler2            = trim(wdetail01.Plus12) /* 55  FLAG FOR 12PLUS           */  
                    brstat.tlt.OLD_eng            = "complete"           
                    brstat.tlt.endno              = USERID(LDBNAME(1))   /*User Load Data */
                    /*brstat.tlt.imp                = "IM"                 /*Import Data    */*/ /*A63-0448*/
                    /*brstat.tlt.imp                = IF tg_br = YES THEN "EMP" ELSE "ORA"  */ /*A63-0448*/ /*A65-0115*/
                    brstat.tlt.releas             = "NO"                 
                    brstat.tlt.rec_addr4          = nv_agent            /*Agent code*/   
                    brstat.tlt.usrid              = ""                   /*User Edit Data*/ /*add By Sarinya C A61-0349 23/07/2018*/
                    brstat.tlt.EXP                = "OLD" 
                    brstat.tlt.OLD_cha            = ""                  /* �����˵� */
                    brstat.tlt.lotno              = ""                  /* �����˵�¡��ԡ*/
                    brstat.tlt.comp_usr_ins       = trim(wdetail01.Benefic).

                   /* company  = trim(wdetail01.Company).
                    IF company = "AYCAL" THEN ASSIGN brstat.tlt.comp_usr_ins = "���.��ظ�� ᤻�Ե�� ���� ���" .
                    ELSE IF company = "BAY" THEN ASSIGN brstat.tlt.comp_usr_ins = "��Ҥ�á�ا�����ظ�� �ӡѴ (��Ҫ�)" .
                    ELSE brstat.tlt.comp_usr_ins = "¡��ԡ 8.3" .*/
               nv_complete = nv_complete + 1.
            END.        
       
END.
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
     IF ra_typfile = 2 THEN DO:
        DEF VAR n AS CHAR INIT "".
        /*------------------------------------ �������ͧ����駧ҹ���� ---------------------------------------*/
            /*--- ������˹�ҵ��ҧ----*/
           /* IF n_addr2_70   <> ""  THEN DO: 
                IF INDEX(n_addr2_70,"�Ҥ��")     <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70). 
                ELSE IF INDEX(n_addr2_70,"�֡")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF INDEX(n_addr2_70,"��ҹ") <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF index(n_addr2_70,"���")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF index(n_addr2_70,"˨�")  <> 0    THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF index(n_addr2_70,"����ѷ")  <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF index(n_addr2_70,"��ҧ")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF index(n_addr2_70,"��ŹԸ�") <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF index(n_addr2_70,"���")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE IF index(n_addr2_70,"��ͧ")    <> 0 THEN ASSIGN n_addr2_70 = trim(n_addr2_70).
                ELSE ASSIGN n_addr2_70 = trim(n_addr2_70).
            END.
            IF n_addr3_70  <> ""  THEN DO: 
                IF INDEX(n_addr3_70,"����")      <> 0      THEN n_addr3_70 = REPLACE(n_addr3_70,"����","�.").
                ELSE IF INDEX(n_addr3_70,"�.")   <> 0      THEN n_addr3_70 = trim(n_addr3_70).
                ELSE IF INDEX(n_addr3_70,"��ҹ") <> 0      THEN n_addr3_70 = trim(n_addr3_70). 
                ELSE IF INDEX(n_addr3_70,"�����ҹ") <> 0  THEN n_addr3_70 = trim(n_addr3_70).
                ELSE IF INDEX(n_addr3_70,"���")  <> 0      THEN n_addr3_70 = trim(n_addr3_70).
                ELSE DO:
                    ASSIGN  n = ""  
                        n = SUBSTR(TRIM(n_addr3_70),1,1).
                        IF INDEX("0123456789",n) <> 0 THEN n_addr3_70 = "�." + trim(n_addr3_70).
                        ELSE n_addr3_70 = trim(n_addr3_70).
                END.
            END.
            IF n_addr4_70 <> ""  THEN DO:
                IF      INDEX(n_addr4_70,"�.")  <> 0 THEN n_addr4_70 = trim(n_addr4_70) .
                ELSE IF INDEX(n_addr4_70,"���") <> 0 THEN n_addr4_70 = REPLACE(n_addr4_70,"���","�.").
                ELSE n_addr4_70 = "�." + trim(n_addr4_70) .
            END.
            IF n_addr5_70 <> ""  THEN DO: 
                IF INDEX(n_addr5_70,"�.")       <> 0 THEN n_addr5_70 = trim(n_addr5_70).
                ELSE IF INDEX(n_addr5_70,"���") <> 0 THEN n_addr5_70 = REPLACE(n_addr5_70,"���","�.").
                ELSE n_addr5_70 = "�." + trim(n_addr5_70) .
            END.    
            IF n_nprovin70 <> ""  THEN DO:
                IF (index(n_nprovin70,"���") <> 0 ) OR (index(n_nprovin70,"��ا෾") <> 0 ) THEN DO:
                    ASSIGN 
                    n_nsub_dist70  = IF index(n_nsub_dist70,"�ǧ") <> 0 THEN trim(n_nsub_dist70) ELSE "�ǧ" + trim(n_nsub_dist70)
                    n_ndirection70 = IF index(n_ndirection70,"ࢵ") <> 0 THEN trim(n_ndirection70) ELSE "ࢵ" + trim(n_ndirection70)
                    n_nprovin70    = trim(n_nprovin70)
                    n_zipcode70    = trim(n_zipcode70). 
                END.
                ELSE DO:
                    ASSIGN 
                    n_nsub_dist70  = IF index(n_nsub_dist70,"�.") <> 0 THEN trim(n_nsub_dist70) 
                                     ELSE IF index(n_nsub_dist70,"�Ӻ�") <> 0 THEN REPLACE(n_nsub_dist70,"�Ӻ�","�.")
                                     ELSE "�." + trim(n_nsub_dist70)
                    n_ndirection70 = IF index(n_ndirection70,"�.") <> 0 THEN trim(n_ndirection70) 
                                     ELSE IF index(n_ndirection70,"�����") <> 0  THEN REPLACE(n_ndirection70,"�����","�.")
                                     ELSE "�." + trim(n_ndirection70)
                    n_nprovin70    = IF index(n_nprovin70,"�ѧ��Ѵ") <> 0 OR INDEX(n_nprovin70,"�.") <> 0 THEN TRIM(n_nprovin70)
                                     ELSE "�." + TRIM(n_nprovin70)
                    n_zipcode70    = trim(n_zipcode70).
                END.
            END.*/
        
            /*--- ������Ѵ��----*/
            IF n_addr2_72   <> ""  THEN DO: 
                IF INDEX(n_addr2_72,"�Ҥ��")     <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72). 
                ELSE IF INDEX(n_addr2_72,"�֡")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF INDEX(n_addr2_72,"��ҹ") <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF index(n_addr2_72,"���")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF index(n_addr2_72,"˨�")  <> 0    THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF index(n_addr2_72,"����ѷ")  <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF index(n_addr2_72,"��ҧ")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF index(n_addr2_72,"��ŹԸ�") <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF index(n_addr2_72,"���")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE IF index(n_addr2_72,"��ͧ")    <> 0 THEN ASSIGN n_addr2_72 = trim(n_addr2_72).
                ELSE ASSIGN n_addr2_72 = trim(n_addr2_72).
            END.
            IF n_addr3_72  <> ""  THEN DO: 
                IF INDEX(n_addr3_72,"����")      <> 0      THEN n_addr3_72 = REPLACE(n_addr3_72,"����","�.").
                ELSE IF INDEX(n_addr3_72,"�.")   <> 0      THEN n_addr3_72 = trim(n_addr3_72).
                ELSE IF INDEX(n_addr3_72,"��ҹ") <> 0      THEN n_addr3_72 = trim(n_addr3_72). 
                ELSE IF INDEX(n_addr3_72,"�����ҹ") <> 0  THEN n_addr3_72 = trim(n_addr3_72).
                ELSE IF INDEX(n_addr3_72,"���")  <> 0      THEN n_addr3_72 = trim(n_addr3_72).
                ELSE DO:
                    ASSIGN  n = ""  
                        n = SUBSTR(TRIM(n_addr3_72),1,1).
                        IF INDEX("0123456789",n) <> 0 THEN n_addr3_72 = "�." + trim(n_addr3_72).
                        ELSE n_addr3_72 = trim(n_addr3_72).
                END.
            END.
            IF n_addr4_72 <> ""  THEN DO:
                IF INDEX(n_addr4_72,"�.")       <> 0 THEN n_addr4_72 = trim(n_addr4_72) .
                ELSE IF INDEX(n_addr4_72,"���") <> 0 THEN n_addr4_72 = REPLACE(n_addr4_72,"���","�.").
                ELSE n_addr4_72 = "�." + trim(n_addr4_72) .
            END.
            IF n_addr5_72 <> ""  THEN DO: 
                IF INDEX(n_addr5_72,"�.")       <> 0 THEN n_addr5_72 = trim(n_addr5_72) .
                ELSE IF INDEX(n_addr5_72,"���") <> 0 THEN n_addr5_72 = REPLACE(n_addr5_72,"���","�.").
                ELSE n_addr5_72 = "�." + trim(n_addr5_72) .
            END.    
            IF n_nprovin72 <> ""  THEN DO:
                IF (index(n_nprovin72,"���") <> 0 ) OR (index(n_nprovin72,"��ا෾") <> 0 ) THEN DO:
                    ASSIGN 
                    n_nsub_dist72  = IF index(n_nsub_dist72,"�ǧ") <> 0 THEN trim(n_nsub_dist72) ELSE "�ǧ" + trim(n_nsub_dist72)
                    n_ndirection72 = IF index(n_ndirection72,"ࢵ") <> 0 THEN trim(n_ndirection72) ELSE "ࢵ" + trim(n_ndirection72)
                    n_nprovin72    = trim(n_nprovin72)
                    n_zipcode72    = trim(n_zipcode72). 
                END.
                ELSE DO:
                    ASSIGN 
                    n_nsub_dist72  = IF index(n_nsub_dist72,"�Ӻ�")    <> 0 THEN REPLACE(n_nsub_dist72,"�Ӻ�","�.")
                                     ELSE IF index(n_nsub_dist72,"�.") <> 0 THEN trim(n_nsub_dist72) 
                                     ELSE "�." + trim(n_nsub_dist72)
                    n_ndirection72 = IF index(n_ndirection72,"�����")   <> 0 THEN REPLACE(n_ndirection72,"�����","�.") 
                                     ELSE IF index(n_ndirection72,"�.") <> 0 THEN trim(n_ndirection72) 
                                     ELSE "�." + trim(n_ndirection72)
                    n_nprovin72    = IF index(n_nprovin72,"�ѧ��Ѵ")    <> 0 THEN REPLACE(n_nprovin72,"�ѧ��Ѵ","�.") 
                                     ELSE IF INDEX(n_nprovin72,"�.")    <> 0 THEN TRIM(n_nprovin72)
                                     ELSE "�." + TRIM(n_nprovin72)
                    n_zipcode72    = trim(n_zipcode72).
                END.
            END.
        
            /*--- ����������Թ----*/
            IF n_payaddr2   <> ""  THEN DO: 
                IF INDEX(n_payaddr2,"�Ҥ��")     <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2). 
                ELSE IF INDEX(n_payaddr2,"�֡")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF INDEX(n_payaddr2,"��ҹ") <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF index(n_payaddr2,"���")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF index(n_payaddr2,"˨�")  <> 0    THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF index(n_payaddr2,"����ѷ")  <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF index(n_payaddr2,"��ҧ")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF index(n_payaddr2,"��ŹԸ�") <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF index(n_payaddr2,"���")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE IF index(n_payaddr2,"��ͧ")    <> 0 THEN ASSIGN n_payaddr2 = trim(n_payaddr2).
                ELSE ASSIGN n_payaddr2 = trim(n_payaddr2).
            END.
            IF n_payaddr3  <> ""  THEN DO: 
                IF INDEX(n_payaddr3,"����")      <> 0      THEN n_payaddr3 = REPLACE(n_payaddr3,"����","�.").
                ELSE IF INDEX(n_payaddr3,"�.")   <> 0      THEN n_payaddr3 = trim(n_payaddr3).
                ELSE IF INDEX(n_payaddr3,"��ҹ") <> 0      THEN n_payaddr3 = trim(n_payaddr3). 
                ELSE IF INDEX(n_payaddr3,"�����ҹ") <> 0  THEN n_payaddr3 = trim(n_payaddr3).
                ELSE IF INDEX(n_payaddr3,"���")  <> 0      THEN n_payaddr3 = trim(n_payaddr3).
                ELSE DO:
                    ASSIGN  n = ""  
                        n = SUBSTR(TRIM(n_payaddr3),1,1).
                        IF INDEX("0123456789",n) <> 0 THEN n_payaddr3 = "�." + trim(n_payaddr3).
                        ELSE n_payaddr3 = trim(n_payaddr3).
                END.
            END.
            IF n_payaddr4 <> ""  THEN DO:
                IF INDEX(n_payaddr4,"�.") <> 0  THEN n_payaddr4 = trim(n_payaddr4) .
                ELSE IF INDEX(n_payaddr4,"���") <> 0 THEN n_payaddr4 = REPLACE(n_payaddr4,"���","�.").
                ELSE n_payaddr4 = "�." + trim(n_payaddr4) .
            END.
            IF n_payaddr5 <> ""  THEN DO: 
                IF INDEX(n_payaddr5,"�.") <> 0 THEN n_payaddr5 = trim(n_payaddr5) .
                ELSE IF INDEX(n_payaddr5,"���") <> 0  THEN n_payaddr5 = REPLACE(n_payaddr5,"���","�.").
                ELSE n_payaddr5 = "�." + trim(n_payaddr5) .
            END.    
            IF n_payaddr8 <> ""  THEN DO:
                IF (index(n_payaddr8,"���") <> 0 ) OR (index(n_payaddr8,"��ا෾") <> 0 ) THEN DO:
                    ASSIGN 
                    n_payaddr6 = IF index(n_payaddr6,"�ǧ") <> 0 THEN trim(n_payaddr6) ELSE "�ǧ" + trim(n_payaddr6)
                    n_payaddr7 = IF index(n_payaddr7,"ࢵ") <> 0 THEN trim(n_payaddr7) ELSE "ࢵ" + trim(n_payaddr7)
                    n_payaddr8 = trim(n_payaddr8)
                    n_payaddr9 = trim(n_payaddr9). 
                END.           
                ELSE DO:       
                    ASSIGN     
                    n_payaddr6 = IF index(n_payaddr6,"�Ӻ�")    <> 0 THEN REPLACE(n_payaddr6,"�Ӻ�","�.") 
                                 ELSE IF index(n_payaddr6,"�.") <> 0 THEN trim(n_payaddr6) 
                                 ELSE "�." + trim(n_payaddr6)
                    n_payaddr7 = IF index(n_payaddr7,"�����")   <> 0 THEN REPLACE(n_payaddr7,"�����","�.")
                                 ELSE IF index(n_payaddr7,"�.") <> 0 THEN trim(n_payaddr7)
                                 ELSE "�." + trim(n_payaddr7)
                    n_payaddr8 = IF index(n_payaddr8,"�ѧ��Ѵ") <> 0 THEN REPLACE(n_payaddr8,"�ѧ��Ѵ","�.")
                                 ELSE IF INDEX(n_payaddr8,"�.") <> 0 THEN TRIM(n_payaddr8)
                                 ELSE "�." + TRIM(n_payaddr8)
                    n_payaddr9 = trim(n_payaddr9).
                END.
            END.
     END.
     /*--------------------------- �������ͧ����駧ҹ��� --------------------------------------*/ 
     ELSE DO: 
         IF TRIM(wdetail01.notifydate) = "" THEN n_datesent = ?.
         ELSE DO:
             n_datesent = DATE(SUBSTR(TRIM(wdetail01.notifydate),5,2) + "/" +
                               SUBSTR(TRIM(wdetail01.notifydate),3,2) + "/" +
                               STRING(DECI("25" + SUBSTR(TRIM(wdetail01.notifydate),1,2)) - 543)).
         END.

        IF np_addrall <> ""  THEN DO:
           IF (R-INDEX(np_addrall,"���")  <> 0 ) THEN DO:
               ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"���") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"���") - 1 )).
           END.
           ELSE IF (R-INDEX(np_addrall,"��ا")  <> 0 )  THEN DO:
               ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"��ا") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"��ا") - 1 )).
           END.
           ELSE IF (R-INDEX(np_addrall,"�.")  <> 0 )  THEN DO:
               ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"�.") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"�.") - 1 )).
           END.
           ELSE IF (R-INDEX(np_addrall,"�ѧ��Ѵ")  <> 0 )  THEN DO:
               ASSIGN np_addr4  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"�ѧ��Ѵ") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"�ѧ��Ѵ") - 1 )).
           END.
           IF (R-INDEX(np_addrall,"ࢵ")  <> 0 )  THEN DO:
               ASSIGN nv_amp  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"ࢵ") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"ࢵ") - 1 )).
           END.
           IF (R-INDEX(np_addrall,"�����")  <> 0 )  THEN DO:
               ASSIGN nv_amp  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"�����") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"�����") - 1 )).
           END.
           /*Add Jiraphon A59-0451*/
           IF (R-INDEX(np_addrall,"�.")  <> 0 )  THEN DO:
               ASSIGN nv_amp  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"�.") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"�.") - 1 )).
           END.
           /*End Jiraphon A59-0451*/
           IF (R-INDEX(np_addrall,"�ǧ")  <> 0 )  THEN DO:
               ASSIGN nv_tum  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"�ǧ") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"�ǧ") - 1 )).
           END.
           IF (R-INDEX(np_addrall,"�Ӻ�")  <> 0 )  THEN DO:
               ASSIGN nv_tum  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"�Ӻ�") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"�Ӻ�") - 1 )).
           END.
          /*Add Jiraphon A59-0451*/    
           IF (R-INDEX(np_addrall,"�.")  <> 0 )  THEN DO:
               ASSIGN nv_tum  =  trim(SUBSTR(np_addrall,R-INDEX(np_addrall,"�.") - 1 ))
                   np_addr1     =  trim(SUBSTR(np_addrall,1,R-INDEX(np_addrall,"�.") - 1 )).
           END.
           
        
           np_addr2 = SUBSTR(nv_tum,1,INDEX(nv_tum, " ")).
           np_addr3 = SUBSTR(nv_amp,1,INDEX(nv_amp, " ")).
           
           
           nv_prov = trim(SUBSTR(np_addrall,INDEX(np_addrall,np_addr3) + LENGTH(np_addr3),20)).
           np_addr4 = trim(SUBSTR(nv_prov,1,INDEX(nv_prov," "))).
           np_addr5 = trim(SUBSTR(nv_prov,R-INDEX(nv_prov, " "))).
        END.
     END.
END.
    
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkbr C-Win 
PROCEDURE proc_chkbr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_bray AS CHAR INIT "" .
DO:
    ASSIGN  n_bray      = ""   
            n_inspbr    = "" .  /* A67-0162*/
    IF      INDEX(winsp.custcode,"NPOS") <> 0 THEN ASSIGN n_inspbr = "ML (Bank & Finance)" .
    ELSE IF INDEX(winsp.custcode,"LINE") <> 0 THEN ASSIGN n_inspbr = "ML (Bank & Finance)" .
    ELSE IF INDEX(winsp.custcode,"MC")   <> 0 THEN ASSIGN n_inspbr = "MNM-Team 2" .
    ELSE DO:
        ASSIGN n_bray = trim(SUBSTR(winsp.custcode,10,2)).
        IF      n_bray = "22" then Assign n_inspbr = "����Ҫ����"  .                         
        ELSE IF n_bray = "24" then Assign n_inspbr = "�غ��Ҫ�ҹ�" .                          
        ELSE IF n_bray = "27" then Assign n_inspbr = "�������"    .                       
        ELSE IF n_bray = "28" then Assign n_inspbr = "���Թ���"    .                       
        ELSE IF n_bray = "61" then Assign n_inspbr = "����Ҫ����"  .                         
        ELSE IF n_bray = "62" then Assign n_inspbr = "��ʸ�"       .                    
        ELSE IF n_bray = "65" then Assign n_inspbr = "�������"     .                      
        ELSE IF n_bray = "76" then Assign n_inspbr = "��ط��Ҥ�"   .                        
        ELSE IF n_bray = "31" then Assign n_inspbr = "�Ҵ�˭�"     .                        
        ELSE IF n_bray = "32" then Assign n_inspbr = "����ɯ��ҹ�" .                         
        ELSE IF n_bray = "33" THEN ASSIGN n_inspbr = "��ѧ"        .                 
        ELSE IF n_bray = "34" THEN ASSIGN n_inspbr = "����"      .                   
        ELSE IF n_bray = "35" THEN ASSIGN n_inspbr = "�����ո����Ҫ" .                         
        ELSE IF n_bray = "38" THEN ASSIGN n_inspbr = "��к��"      .                      
        ELSE IF n_bray = "41" THEN ASSIGN n_inspbr = "����Ҫ�"     .                       
        ELSE IF n_bray = "40" THEN ASSIGN n_inspbr = "�ѷ��"       .                     
        ELSE IF n_bray = "43" THEN ASSIGN n_inspbr = "���ͧ"       .                     
        ELSE IF n_bray = "45" THEN ASSIGN n_inspbr = "��Ҩչ����"  .                          
        ELSE IF n_bray = "46" THEN ASSIGN n_inspbr = "���ԧ���"  .                          
        ELSE IF n_bray = "47" THEN ASSIGN n_inspbr = "�ѹ�����"    .                        
        ELSE IF n_bray = "49" THEN ASSIGN n_inspbr = "������"     .                       
        ELSE IF n_bray = "83" THEN ASSIGN n_inspbr = "��к���"     .                       
        ELSE IF n_bray = "51" THEN ASSIGN n_inspbr = "��§����"   .                         
        ELSE IF n_bray = "52" THEN ASSIGN n_inspbr = "��ɳ��š"    .                        
        ELSE IF n_bray = "53" THEN ASSIGN n_inspbr = "������ä�"   .                         
        ELSE IF n_bray = "54" THEN ASSIGN n_inspbr = "�ӻҧ"       .                     
        ELSE IF n_bray = "55" THEN ASSIGN n_inspbr = "��§���"    .                        
        ELSE IF n_bray = "56" THEN ASSIGN n_inspbr = "��ᾧྪ�"   .                         
        ELSE IF n_bray = "21" THEN ASSIGN n_inspbr = "�͹��"     .                       
        ELSE IF n_bray = "23" THEN ASSIGN n_inspbr = "�شøҹ�"    .                        
        ELSE IF n_bray = "25" THEN ASSIGN n_inspbr = "�������"    .                        
        ELSE IF n_bray = "26" THEN ASSIGN n_inspbr = "ʡŹ��"      .                      
        ELSE IF n_bray = "57" THEN ASSIGN n_inspbr = "ྪú�ó�"   .                         
        ELSE IF n_bray = "63" THEN ASSIGN n_inspbr = "�ء�����"    .                        
        ELSE IF n_bray = "64" THEN ASSIGN n_inspbr = "˹ͧ���"     .                       
        ELSE IF n_bray = "66" THEN ASSIGN n_inspbr = "����Թ���"   .                         
        ELSE IF n_bray = "67" THEN ASSIGN n_inspbr = "���"         .                   
        ELSE IF n_bray = "37" THEN ASSIGN n_inspbr = "�����"       .                     
        ELSE IF n_bray = "42" THEN ASSIGN n_inspbr = "��û��"      .                      
        ELSE IF n_bray = "44" THEN ASSIGN n_inspbr = "��ҳ����"    .                        
        ELSE IF n_bray = "48" THEN ASSIGN n_inspbr = "�ҭ������"   .                         
        ELSE IF n_bray = "84" THEN ASSIGN n_inspbr = "��ظ��"      .                      
        ELSE IF n_bray = "85" THEN ASSIGN n_inspbr = "�ؾ�ó����"  .                          
        ELSE IF n_bray = "39" THEN ASSIGN n_inspbr = "����"        .
        ELSE ASSIGN n_inspbr = "ML (Bank & Finance)" .
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkexp C-Win 
PROCEDURE proc_chkexp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by : A65-0115      
------------------------------------------------------------------------------*/
IF NOT CONNECTED("sic_exp") THEN DO:
    loop_conexp:
    REPEAT:
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
        
          IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
             CONNECT expiry -H TMSTH -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.        /*HO*/ 
             /*CONNECT expiry -H devserver -S expiry  -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.*/  /*db test.*/  
             
              CLEAR FRAME nf00.
              HIDE FRAME nf00.
              /*RETURN.*/ 
              IF NOT CONNECTED("sic_exp") THEN NEXT loop_conexp.
              ELSE DO:
                   LEAVE loop_conexp.
                   RETURN.
              END.
           END.
           IF FRAME-FIELD = "gv_id" OR FRAME-FIELD = "nv_pwd" AND LASTKEY = KEYCODE("F4") THEN DO:
                CLEAR FRAME nf00.
                HIDE FRAME nf00.
                LEAVE loop_conexp.
                RETURN.
           END.
        END.
    END.
END.

ASSIGN 
  nv_branch   = "" 
  nv_producer = "" 
  nv_dealer   = "" .
IF wdetail2.policy <> ""  THEN DO:
    FIND LAST sicuw.uwm100 WHERE uwm100.policy = wdetail2.policy NO-LOCK NO-ERROR .
        IF AVAIL sicuw.uwm100 THEN DO:
            IF CONNECTED("sic_exp") THEN 
                RUN wgw/wgwexchkay (INPUT  wdetail2.policy,
                                    OUTPUT nv_branch ,
                                    OUTPUT nv_producer,
                                    OUTPUT nv_dealer ).
            IF index(wdetail.pmenttyp,"Cash Advance") <> 0 AND index(wdetail.pmentcode2,"Cash Advance") <> 0  THEN ASSIGN nv_producer = "B3MLAY0108" .
            ELSE IF TRIM(nv_producer) = "B3MLAY0106"  THEN ASSIGN nv_producer = "B3MLAY0107" .
            ELSE IF INDEX(nv_producer,"B3MLAY") = 0   THEN ASSIGN nv_producer = "B3MLAY0101" .

            IF nv_branch = "MF" THEN ASSIGN nv_branch = "ML".
            ELSE IF nv_branch = "M" THEN ASSIGN nv_branch = "ML".
            
        END.
        ELSE DO:
            IF INDEX(wdetail.pmenttyp,"Cash Advance") <> 0  AND index(wdetail.pmentcode2,"Cash Advance") <> 0  THEN ASSIGN nv_producer = "B3MLAY0108" .
            ELSE ASSIGN  nv_producer = "B3MLAY0107" .
        END.
END.
ELSE DO:
    IF index(wdetail.pmenttyp,"Cash Advance") <> 0  AND  index(wdetail.pmentcode2,"Cash Advance") <> 0  THEN ASSIGN nv_producer = "B3MLAY0108" .
    ELSE ASSIGN nv_producer = "B3MLAY0107" .
END.

/* end A65-0115 */ 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktlt_CA C-Win 
PROCEDURE proc_chktlt_CA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_comdat AS CHAR FORMAT "x(15)" .
DEF VAR n_file AS CHAR FORMAT "x(50)" .
LOOP_Paid:
FOR EACH wcancel .
    IF (wcancel.chassis  = "" ) THEN DELETE wcancel.
    ELSE DO:
        
        IF wcancel.comdate <> "" THEN ASSIGN nv_comdat = trim(SUBSTR(wcancel.comdate,1,INDEX(wcancel.comdat,"-") - 2)).
        IF LENGTH(nv_comdat) < 8  THEN DO:
          ASSIGN nv_comdat = SUBSTR(TRIM(nv_comdat),1,1) + "/" +
                 SUBSTR(TRIM(nv_comdat),3,2) + "/" +
                 STRING(DECI("25" + SUBSTR(TRIM(nv_comdat),6,2)) - 543).  /* 27  �ѹ������ͧ��.  */  
        END.
        ELSE DO:
            ASSIGN nv_comdat = SUBSTR(TRIM(nv_comdat),1,2) + "/" +
                 SUBSTR(TRIM(nv_comdat),4,2) + "/" +
                 STRING(DECI("25" + SUBSTR(TRIM(nv_comdat),7,2)) - 543).  /* 27  �ѹ������ͧ��.  */  
        END.
        
        nv_reccnt  = nv_reccnt + 1.
        FOR EACH brstat.tlt USE-INDEX tlt06  WHERE         
            brstat.tlt.cha_no          = TRIM(wcancel.chassis)   AND
            INDEX(wcancel.licence,brstat.tlt.lince1) <> 0  AND   /* ����¹ */
            brstat.tlt.flag            <> "INSPEC"               AND 
            brstat.tlt.genusr          = trim(fi_compa)          .  

            IF brstat.tlt.gendat <> date(nv_comdat) AND brstat.tlt.nor_effdat <> date(nv_comdat) THEN DO: 
                ASSIGN wcancel.comment   = "�ѹ��������ͧ����Ѻ��к����ç�ѹ" .
                NEXT.
            END.
            ELSE DO:
                IF INDEX(fi_filename,"\") <> 0 THEN DO: 
                    n_file = SUBSTR(fi_filename,R-INDEX(fi_filename,"\") + 1) .
                END.
                IF INDEX(n_file,".csv") <> 0 THEN DO: 
                    n_file = trim(REPLACE(n_file,".csv","")).
                END.
                IF INDEX(brstat.tlt.releas,"CA") = 0 THEN DO:
                    nv_completecnt = nv_completecnt + 1 .
                    ASSIGN brstat.tlt.releas = "CA/" + brstat.tlt.releas .
                    IF brstat.tlt.flag = "V70" THEN DO:
                        ASSIGN wcancel.comment   = "Complete" 
                               brstat.tlt.filler2 =  brstat.tlt.filler2  +  " /" + trim(wcancel.remark) + " " + n_file.
                    END.
                    ELSE IF brstat.tlt.flag = "V72" THEN DO:
                        ASSIGN wcancel.comment   = "Complete" 
                               brstat.tlt.filler2 = brstat.tlt.filler2  +  " /" + trim(wcancel.remark) + " " + n_file. 
                    END.
                    ELSE DO:
                        ASSIGN wcancel.comment    = "Complete" 
                               brstat.tlt.lotno  =   trim(wcancel.remark) + " " + n_file .
                    END.
                END.
                ELSE DO:
                    ASSIGN wcancel.comment = "�ա�� Cancel ����������� " .
                END.
            END.
        END.
        RELEASE brstat.tlt.
        IF wcancel.comment = ""  THEN ASSIGN wcancel.comment = "��辺������㹶ѧ�ѡ" .
    END.  /*winsp.Notify_no <> "" */
END.   /* FOR EACH winsp NO-LOCK: */
RUN proc_reportmat_CA.
/*Run Open_tlt.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Cleardata C-Win 
PROCEDURE Proc_Cleardata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN n_cmr_code         = ""         /* A67-0162 */
       n_comp_code        = ""         n_tyeeng       = "" 
       n_campcode         = ""         n_typMC        = "" 
       n_campname         = ""         n_watt         = "" 
       n_procode          = ""         n_evmotor1     = "" 
       n_proname          = ""         n_evmotor2     = "" 
       n_packname         = ""         n_evmotor3     = "" 
       n_packcode         = ""         n_evmotor4     = "" 
       n_instype          = ""         n_evmotor5     = "" 
       n_pol_title        = ""         n_evmotor6     = "" 
       n_pol_fname        = ""         n_evmotor7     = "" 
       n_pol_lname        = ""         n_evmotor8     = "" 
       n_pol_title_eng    = ""         n_evmotor9     = "" 
       n_pol_fname_eng    = ""         n_evmotor10    = "" 
       n_pol_lname_eng    = ""         n_evmotor11    = "" 
       n_icno             = ""         n_evmotor12    = "" 
       n_sex              = ""         n_evmotor13    = "" 
       n_bdate            = ""         n_evmotor14    = "" 
       n_occup            = ""         n_evmotor15    = "" 
       n_tel              = ""         n_carprice     = "" 
       n_phone            = ""         n_drivlicen1   = "" 
       n_teloffic         = ""         n_drivcardexp1 = "" 
       n_telext           = ""         n_drivcartyp1  = "" 
       n_moblie           = ""         n_drivlicen2   = "" 
       n_mobliech         = ""         n_drivcardexp2 = "" 
       n_mail             = ""         n_drivcartyp2  = "" 
       n_lineid           = ""         n_drivetitle3  = "" 
       n_addr1_70         = ""         n_drivename3   = "" 
       n_addr2_70         = ""         n_drivelname3  = "" 
       n_addr3_70         = ""         n_bdatedriv3   = "" 
       n_addr4_70         = ""         n_sexdriv3     = "" 
       n_addr5_70         = ""         n_drivcartyp3  = "" 
       n_nsub_dist70      = ""         n_driveno3     = "" 
       n_ndirection70     = ""         n_drivlicen3   = "" 
       n_nprovin70        = ""         n_drivcardexp3 = "" 
       n_zipcode70        = ""         n_occupdriv3   = "" 
       n_addr1_72         = ""         n_drivetitle4  = "" 
       n_addr2_72         = ""         n_drivename4   = "" 
       n_addr3_72         = ""         n_drivelname4  = "" 
       n_addr4_72         = ""         n_bdatedriv4   = "" 
       n_addr5_72         = ""         n_sexdriv4     = "" 
       n_nsub_dist72      = ""         n_drivcartyp4  = "" 
       n_ndirection72     = ""         n_driveno4     = "" 
       n_nprovin72        = ""         n_drivlicen4   = "" 
       n_zipcode72        = ""         n_drivcardexp4 = "" 
       n_paytype          = ""         n_occupdriv4   = "" 
       n_paytitle         = ""         n_drivetitle5  = "" 
       n_payname          = ""         n_drivename5   = "" 
       n_paylname         = ""         n_drivelname5  = "" 
       n_payicno          = ""         n_bdatedriv5   = "" 
       n_payaddr1         = ""         n_sexdriv5     = "" 
       n_payaddr2         = ""         n_drivcartyp5  = "" 
       n_payaddr3         = ""         n_driveno5     = "" 
       n_payaddr4         = ""         n_drivlicen5   = "" 
       n_payaddr5         = ""         n_drivcardexp5 = "" 
       n_payaddr6         = ""         n_occupdriv5   = "" 
       n_payaddr7         = ""         n_battflag     = "" 
       n_payaddr8         = ""         n_battyr       = "" 
       n_payaddr9         = ""         n_battdate     = "" 
       n_branch           = ""         n_battprice    = "" 
       n_ben_title        = ""         n_battno       = "" 
       n_ben_name         = ""         n_battsi       = "" 
       n_ben_lname        = ""         n_chagreno     = "" 
       n_pmentcode        = ""         n_chagrebrand  = "" 
       n_pmenttyp         = ""       /* end A67-0162 */  
       n_pmentcode1       = ""         
       n_pmentcode2       = ""         
       n_pmentbank        = ""         
       n_pmentdate        = ""         
       n_pmentsts         = ""         
       n_driver           = ""         
       n_drivetitle1      = ""         
       n_drivename1       = ""         
       n_drivelname1      = ""         
       n_driveno1         = ""         
       n_occupdriv1       = ""         
       n_sexdriv1         = ""         
       n_bdatedriv1       = ""         
       n_drivetitle2      = ""         
       n_drivename2       = ""         
       n_drivelname2      = ""         
       n_driveno2         = ""         
       n_occupdriv2       = ""         
       n_sexdriv2         = ""         
       n_bdatedriv2       = ""         
       n_brand            = ""         
       n_brand_cd         = ""         
       n_Model            = ""         
       n_Model_cd         = ""         
       n_body             = ""         
       n_body_cd          = ""         
       n_licence          = ""         
       n_province         = ""         
       n_chassis          = ""         
       n_engine           = ""         
       n_yrmanu           = ""         
       n_seatenew         = ""         
       n_power            = ""         
       n_weight           = ""         
       n_class            = ""         
       n_garage_cd        = ""         
       n_garage           = ""         
       n_colorcode        = ""         
       n_covcod           = ""         
       n_covtyp           = ""         
       n_covtyp1          = ""         
       n_covtyp2          = ""         
       n_covtyp3          = ""         
       n_comdat           = ""         
       n_expdat           = ""         
       n_ins_amt          = ""         
       n_prem1            = ""         
       n_gross_prm        = ""         
       n_stamp            = ""         
       n_vat              = ""         
       n_premtotal        = ""         
       n_deduct           = ""         
       n_fleetper         = ""         
       n_fleet            = ""         
       n_ncbper           = ""         
       n_ncb              = ""         
       n_drivper          = ""         
       n_drivdis          = ""         
       n_othper           = ""         
       n_oth              = ""         
       n_cctvper          = ""         
       n_cctv             = ""         
       n_Surcharper       = ""         
       n_Surchar          = ""         
       n_Surchardetail    = ""         
       n_acc1             = ""         
       n_accdetail1       = ""         
       n_accprice1        = ""         
       n_acc2             = ""         
       n_accdetail2       = ""         
       n_accprice2        = ""         
       n_acc3             = ""         
       n_accdetail3       = ""         
       n_accprice3        = ""         
       n_acc4             = ""         
       n_accdetail4       = ""         
       n_accprice4        = ""         
       n_acc5             = ""         
       n_accdetail5       = ""         
       n_accprice5        = ""         
       n_inspdate         = ""         
       n_inspdate_app     = ""         
       n_inspsts          = ""         
       n_inspdetail       = ""         
       n_not_date         = ""         
       n_paydate          = ""         
       n_paysts           = ""         
       n_licenBroker      = ""         
       n_brokname         = ""         
       n_brokcode         = ""         
       n_lang             = ""         
       n_deli             = ""         
       n_delidetail       = ""         
       n_gift             = ""         
       n_cedcode          = ""         
       n_inscode          = ""         
       n_remark           = "" 
       n_policy           = ""
       n_inspname         = ""
       n_inspphone        = ""
       n_insploca         = ""
       n_agentname        = "" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create C-Win 
PROCEDURE proc_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INDEX(n_covcod,"������ 1") <> 0 THEN ASSIGN n_covtyp = "1" .
ELSE IF INDEX(n_covcod,"������ 2 ����") <> 0 THEN ASSIGN n_covtyp = "2+" .
ELSE IF INDEX(n_covcod,"������ 2") <> 0 THEN ASSIGN n_covtyp = "2" .
ELSE IF INDEX(n_covcod,"������ 3") <> 0 THEN ASSIGN n_covtyp = "3" .
ELSE IF INDEX(n_covcod,"�Ҥ�ѧ�Ѻ") <> 0 THEN ASSIGN n_covtyp = "CMI" .
/* Add by : A67-0162*/
IF n_covtyp <> "CMI" THEN DO:
    IF index(n_proname,"EV") <> 0 THEN  n_class = "E" + SUBSTR(n_class,1,2) .
    ELSE IF trim(n_evmotor1) <> "" THEN n_class = "E" + SUBSTR(n_class,1,2) .
END.
ELSE DO:
    IF index(n_proname,"EV") <> 0 THEN  n_class = trim(n_class) + "E".
    ELSE IF trim(n_evmotor1) <> "" THEN n_class = trim(n_class) + "E".
END.
/* end : A67-0162 */

FIND FIRST wdetail WHERE wdetail.chassis = trim(n_chassis) AND
                         wdetail.covtyp  = trim(n_covtyp)  NO-LOCK NO-ERROR.
IF NOT AVAIL wdetail THEN DO:
    RUN proc_chkaddr.
    CREATE wdetail.
    ASSIGN 
        wdetail.chassis         = trim(n_chassis) 
        wdetail.covcod          = TRIM(n_covcod)
        wdetail.covtyp          = trim(n_covtyp)
        wdetail.cmr_code        = trim(n_cmr_code)
        wdetail.campcode        = trim(n_campcode)     
        wdetail.campname        = trim(n_campname)  
        wdetail.proname         = trim(n_proname) 
        wdetail.packcode        = trim(n_packcode)
        wdetail.pol_title       = trim(n_pol_title)     
        wdetail.pol_fname       = trim(n_pol_fname)     
        wdetail.pol_lname       = IF index(n_pol_lname," ") <> 0 THEN TRIM(REPLACE(n_pol_lname," ","")) ELSE TRIM(n_pol_lname)    
        wdetail.icno            = trim(n_icno)         
        wdetail.sex             = trim(n_sex)         
        wdetail.bdate           = STRING(DATE(n_bdate),"99/99/9999")   
        wdetail.moblie          = trim(n_moblie) 
        wdetail.addr1_72        = trim(n_addr1_72)  
        wdetail.addr2_72        = trim(n_addr2_72)  
        wdetail.addr3_72        = trim(n_addr3_72)  
        wdetail.addr4_72        = trim(n_addr4_72)  
        wdetail.addr5_72        = trim(n_addr5_72)  
        wdetail.nsub_dist72     = trim(n_nsub_dist72)  
        wdetail.ndirection72    = trim(n_ndirection72) 
        wdetail.nprovin72       = trim(n_nprovin72)  
        wdetail.zipcode72       = trim(n_zipcode72) 
        wdetail.paytitle        = trim(n_paytitle)  
        wdetail.payname         = trim(n_payname)  
        wdetail.paylname        = trim(n_paylname)  
        wdetail.payicno         = trim(n_payicno)  
        wdetail.payaddr1        = trim(n_payaddr1)  
        wdetail.payaddr2        = trim(n_payaddr2)  
        wdetail.payaddr3        = trim(n_payaddr3)  
        wdetail.payaddr4        = trim(n_payaddr4)  
        wdetail.payaddr5        = trim(n_payaddr5)  
        wdetail.payaddr6        = trim(n_payaddr6)  
        wdetail.payaddr7        = trim(n_payaddr7)  
        wdetail.payaddr8        = trim(n_payaddr8)  
        wdetail.payaddr9        = trim(n_payaddr9)
        wdetail.ben_title       = trim(n_ben_title)  
        wdetail.ben_name        = trim(n_ben_name)
        wdetail.ben_lname       = trim(n_ben_lname) 
        wdetail.pmenttyp        = trim(n_pmenttyp)
        wdetail.pmentcode2      = trim(n_pmentcode2)  
        wdetail.driver          = trim(n_driver)  
        wdetail.drivetitle1     = trim(n_drivetitle1)  
        wdetail.drivename1      = trim(n_drivename1)  
        wdetail.drivelname1     = trim(n_drivelname1)  
        wdetail.driveno1        = trim(n_driveno1)  
        wdetail.occupdriv1      = trim(n_occupdriv1)  
        wdetail.sexdriv1        = trim(n_sexdriv1)  
        wdetail.bdatedriv1      = STRING(DATE(n_bdatedriv1),"99/99/9999")  
        wdetail.drivetitle2     = trim(n_drivetitle2)  
        wdetail.drivename2      = trim(n_drivename2)  
        wdetail.drivelname2     = trim(n_drivelname2)  
        wdetail.driveno2        = trim(n_driveno2)  
        wdetail.occupdriv2      = trim(n_occupdriv2)  
        wdetail.sexdriv2        = trim(n_sexdriv2)  
        wdetail.bdatedriv2      = string(DATE(n_bdatedriv2),"99/99/9999") . 
    CREATE wdetail2.
    ASSIGN
        wdetail2.covtyp          = trim(n_covtyp)
        wdetail2.brand           = trim(n_brand) 
        wdetail2.Model           = trim(n_Model) 
        wdetail2.body            = trim(n_body)
        wdetail2.licence         = trim(n_licence)    
        wdetail2.province        = trim(n_province)    
        wdetail2.chassis         = trim(n_chassis)    
        wdetail2.engine          = trim(n_engine)    
        wdetail2.yrmanu          = trim(n_yrmanu)    
        wdetail2.power           = trim(n_power)    
        wdetail2.weight          = trim(n_weight)    
        wdetail2.class           = trim(n_class)    
        wdetail2.garage_cd       = trim(n_garage_cd)    
        wdetail2.colorcode       = trim(n_colorcode)    
        wdetail2.covcod          = trim(n_covcod) 
        wdetail2.comdat          = trim(n_comdat)    
        wdetail2.expdat          = trim(n_expdat)    
        wdetail2.ins_amt         = trim(n_ins_amt)    
        wdetail2.prem1           = trim(n_prem1)    
        wdetail2.gross_prm       = trim(n_gross_prm)    
        wdetail2.stamp           = trim(n_stamp)    
        wdetail2.vat             = trim(n_vat)    
        wdetail2.premtotal       = trim(n_premtotal)    
        wdetail2.deduct          = trim(n_deduct) 
        wdetail2.fleet           = trim(n_fleet)
        wdetail2.ncb             = trim(n_ncb )
        wdetail2.drivdis         = trim(n_drivdis) 
        wdetail2.oth             = trim(n_oth )
        wdetail2.cctv            = trim(n_cctv)
        wdetail2.Surchar         = trim(n_Surchar)
        wdetail2.Surchardetail   = trim(n_Surchardetail)
        wdetail2.accdetail1      = trim(n_accdetail1)   
        wdetail2.accprice1       = trim(n_accprice1)
        wdetail2.accdetail2      = trim(n_accdetail2)   
        wdetail2.accprice2       = trim(n_accprice2)
        wdetail2.accdetail3      = trim(n_accdetail3)   
        wdetail2.accprice3       = trim(n_accprice3)
        wdetail2.accdetail4      = trim(n_accdetail4)   
        wdetail2.accprice4       = trim(n_accprice4)
        wdetail2.accdetail5      = trim(n_accdetail5)   
        wdetail2.accprice5       = trim(n_accprice5)
        wdetail2.inspdate        = STRING(DATE(n_inspdate),"99/99/9999")
        wdetail2.inspsts         = trim(n_inspsts)
        wdetail2.inspname        = trim(n_inspname) 
        wdetail2.inspphone       = trim(n_inspphone)
        wdetail2.insploca        = trim(n_insploca) 
        wdetail2.inspdetail      = trim(n_inspdetail)
        wdetail2.not_date        = string(DATE(n_not_date),"99/99/9999")
        wdetail2.delidetail      = trim(n_delidetail)
        wdetail2.cedcode         = trim(n_cedcode)  
        wdetail2.inscode         = trim(n_inscode)  
        wdetail2.policy          = TRIM(n_policy)
        wdetail2.agname          = trim(n_agentname) 
        /* add : A67-0162 */
        wdetail2.tyeeng         = trim(n_tyeeng)   
        wdetail2.typMC          = trim(n_typMC )  
        wdetail2.watt           = trim(n_watt  )  
        wdetail2.evmotor1       = trim(n_evmotor1)  
        wdetail2.evmotor2       = trim(n_evmotor2)  
        wdetail2.evmotor3       = trim(n_evmotor3)  
        wdetail2.evmotor4       = trim(n_evmotor4)  
        wdetail2.evmotor5       = trim(n_evmotor5)  
        wdetail2.evmotor6       = trim(n_evmotor6)  
        wdetail2.evmotor7       = trim(n_evmotor7)  
        wdetail2.evmotor8       = trim(n_evmotor8)  
        wdetail2.evmotor9       = trim(n_evmotor9)  
        wdetail2.evmotor10      = trim(n_evmotor10)  
        wdetail2.evmotor11      = trim(n_evmotor11)  
        wdetail2.evmotor12      = trim(n_evmotor12)  
        wdetail2.evmotor13      = trim(n_evmotor13)  
        wdetail2.evmotor14      = trim(n_evmotor14)  
        wdetail2.evmotor15      = trim(n_evmotor15)  
        wdetail2.carprice       = trim(n_carprice)  
        wdetail2.drivlicen1     = trim(n_drivlicen1)  
        wdetail2.drivcardexp1   = trim(n_drivcardexp1)  
        wdetail2.drivcartyp1    = trim(n_drivcartyp1 )  
        wdetail2.drivlicen2     = trim(n_drivlicen2)  
        wdetail2.drivcardexp2   = trim(n_drivcardexp2)  
        wdetail2.drivcartyp2    = trim(n_drivcartyp2)   
        wdetail2.drivetitle3    = trim(n_drivetitle3)   
        wdetail2.drivename3     = trim(n_drivename3)
        wdetail2.drivelname3    = trim(n_drivelname3)   
        wdetail2.bdatedriv3     = string(DATE(n_bdatedriv3),"99/99/9999")  
        wdetail2.sexdriv3       = trim(n_sexdriv3)   
        wdetail2.drivcartyp3    = trim(n_drivcartyp3)  
        wdetail2.driveno3       = trim(n_driveno3)  
        wdetail2.drivlicen3     = trim(n_drivlicen3)  
        wdetail2.drivcardexp3   = trim(n_drivcardexp3)  
        wdetail2.occupdriv3     = trim(n_occupdriv3)
        wdetail2.drivetitle4    = trim(n_drivetitle4)  
        wdetail2.drivename4     = trim(n_drivename4)
        wdetail2.drivelname4    = trim(n_drivelname4)  
        wdetail2.bdatedriv4     = STRING(DATE(n_bdatedriv4),"99/99/9999")  
        wdetail2.sexdriv4       = trim(n_sexdriv4)   
        wdetail2.drivcartyp4    = trim(n_drivcartyp4)  
        wdetail2.driveno4       = trim(n_driveno4)   
        wdetail2.drivlicen4     = trim(n_drivlicen4)  
        wdetail2.drivcardexp4   = trim(n_drivcardexp4)  
        wdetail2.occupdriv4     = trim(n_occupdriv4)   
        wdetail2.drivetitle5    = trim(n_drivetitle5)   
        wdetail2.drivename5     = trim(n_drivename5)   
        wdetail2.drivelname5    = trim(n_drivelname5)   
        wdetail2.bdatedriv5     = STRING(DATE(n_bdatedriv5),"99/99/9999")   
        wdetail2.sexdriv5       = trim(n_sexdriv5) 
        wdetail2.drivcartyp5    = trim(n_drivcartyp5)   
        wdetail2.driveno5       = trim(n_driveno5)  
        wdetail2.drivlicen5     = trim(n_drivlicen5)   
        wdetail2.drivcardexp5   = trim(n_drivcardexp5)  
        wdetail2.occupdriv5     = trim(n_occupdriv5)  
        wdetail2.battflag       = trim(n_battflag)   
        wdetail2.battyr         = trim(n_battyr)   
        wdetail2.battdate       = trim(n_battdate)   
        wdetail2.battprice      = trim(n_battprice)  
        wdetail2.battno         = trim(n_battno)   
        wdetail2.battsi         = trim(n_battsi)   
        wdetail2.chagreno       = trim(n_chagreno)   
        wdetail2.chagrebrand    = trim(n_chagrebrand) .
END.                                             

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutpolicy C-Win 
PROCEDURE proc_cutpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT .
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind  AS INT.
ASSIGN 
    nv_c = trim(wdetail01.policy)
    nv_i = 0
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
ASSIGN
    wdetail01.policy  = nv_c . 

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
/*wdetail2.remark*/ 
ASSIGN  nn_remark1 = ""
        nn_remark2 = ""
        nn_remark3 = "".
IF      R-INDEX(wdetail2.remark,"/����ѷ") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark,"/����ѷ"))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark,"/����ѷ") - 1 )) .
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
ELSE IF      R-INDEX(wdetail2.remark,"/���") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark,"/���"))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark,"/���") - 1 )) .
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
ELSE IF      R-INDEX(wdetail2.remark,"/��ҧ") <> 0 THEN DO: 
    ASSIGN 
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark,"/��ҧ"))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark,"/��ҧ") - 1 )) .
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
        nn_remark2 = trim(SUBSTR(wdetail2.remark,R-INDEX(wdetail2.remark," "))) 
        nn_remark1 = trim(SUBSTR(wdetail2.remark,1,R-INDEX(wdetail2.remark," ") - 1 )) .
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
/*
DISP LENGTH(nn_remark1)
     nn_remark1 FORMAT "x(65)"
     nn_remark2 FORMAT "x(65)"  
     nn_remark3 FORMAT "x(65)" .*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Getdatainsp C-Win 
PROCEDURE proc_Getdatainsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
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
          chitem       = chDocument:Getfirstitem("TotalExpensive").  /* �ҤҤ���������� */
          IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
          ELSE nv_totaldam = "".

          IF nv_damlist <> "" THEN DO: 
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = "�ӹǹ����������� " + nv_damlist + " ��¡�� " .
          END.
          IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "�������������·����� " + nv_totaldam + " �ҷ " .
          
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
                        ASSIGN nv_damdetail = nv_damdetail + STRING(n_count) + "." + nv_damag + " " + nv_repair + " , " .
                        
                    n_count = n_count + 1.
                END.
                ELSE LEAVE loop_damage.
            END.
          END.
      END.
      /*-- ��������� � ---*/
      chitem       = chDocument:Getfirstitem("SurveyData").
      IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
      ELSE nv_surdata = "".
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "���������� :"  +  nv_surdata .
      
      chitem       = chDocument:Getfirstitem("agentCode").      /*agentCode*/
      IF chitem <> 0 THEN n_agent = chitem:TEXT. 
      ELSE n_agent = "".
      
      IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " �鴵��᷹: " + n_agent.

      /*-- �ػ�ó������ --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
          chitem       = chDocument:Getfirstitem("PricesTotal").  /* �Ҥ�����ػ�ó������ */
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
          nv_acctotal = " �Ҥ�����ػ�ó������ " + nv_acctotal + " �ҷ " .
      END.

END.

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
ASSIGN  nv_nameT    = ""   nv_agentname = ""  nv_brand    = ""   nv_model     = ""   nv_licentyp = ""   nv_licen     = ""  
        nv_pattern1 = ""   nv_pattern4  = ""  nv_today    = ""   nv_time      = ""   nv_docno    = ""   nv_survey    = ""  
        nv_detail   = ""   nv_remark1   = ""  nv_remark2  = ""   nv_damlist   = ""   nv_damage   = ""   nv_totaldam  = ""  
        nv_attfile  = ""   nv_device    = ""  nv_acc1     = ""   nv_acc2      = ""   nv_acc3     = ""   nv_acc4      = ""   
        nv_acc5     = ""   nv_acc6      = ""  nv_acc7     = ""   nv_acc8      = ""   nv_acc9     = ""   nv_acc10     = ""   
        nv_acc11    = ""   nv_acc12    = ""   nv_acctotal  = ""  nv_surdata   = ""   nv_date     = ""   nv_damdetail = ""   n_inspbr    = ""   /* A67-0162*/
        nv_tmp      = "Inspect" + SUBSTR(fi_insp,3,2) + ".nsf" 
        nv_today    = STRING(DAY(TODAY),"99") + "/" + STRING(MONTH(TODAY),"99") + "/" + STRING(YEAR(TODAY),"9999")
        nv_time     = STRING(TIME,"HH:MM:SS")
        nv_remark1  = IF trim(winsp.inspcont) <> ""  THEN "�Դ��� : " + trim(winsp.inspcont) ELSE ""
        nv_remark1  = IF trim(winsp.insptel)  <> ""  THEN trim(nv_remark1) + " ������: " + trim(winsp.insptel) ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.lineid)   <> ""  THEN trim(nv_remark1) + " LineID: " + trim(winsp.lineid)    ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.mail)     <> ""  THEN trim(nv_remark1) + " Email: "  + trim(winsp.mail)      ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.insptime) <> ""  THEN trim(nv_remark1) + " ����: "   + trim(winsp.insptime)  ELSE trim(nv_remark1)
        nv_remark1  = IF trim(winsp.inspaddr) <> ""  THEN trim(nv_remark1) + " ʶҹ���: " + trim(winsp.inspaddr) ELSE trim(nv_remark1)
        nv_remark2  = IF trim(winsp.acc1) <> "" OR TRIM(winsp.accdetail1) <> "" THEN "�ػ�ó������ : " + trim(winsp.acc1) + " " 
                    + TRIM(winsp.accdetail1) + "�Ҥ� : " + trim(winsp.accprice1) ELSE ""
        nv_remark2  = IF trim(winsp.acc2) <> "" OR TRIM(winsp.accdetail2) <> "" THEN trim(nv_remark2) + " �ػ�ó������ : " + trim(winsp.acc2) + " " 
                    + TRIM(winsp.accdetail2) + "�Ҥ� : " + trim(winsp.accprice2) ELSE trim(nv_remark2)
        nv_remark2  = IF trim(winsp.acc3) <> "" OR TRIM(winsp.accdetail3) <> "" THEN trim(nv_remark2) + " �ػ�ó������ : " + trim(winsp.acc3) + " " 
                    + TRIM(winsp.accdetail3) + "�Ҥ� : " + trim(winsp.accprice3) ELSE trim(nv_remark2)
        nv_remark2  = IF trim(winsp.acc4) <> "" OR TRIM(winsp.accdetail4) <> "" THEN trim(nv_remark2) + " �ػ�ó������ : " + trim(winsp.acc2) + " " 
                    + TRIM(winsp.accdetail4) + "�Ҥ� : " + trim(winsp.accprice4) ELSE trim(nv_remark2)
        nv_remark2  = IF trim(winsp.acc5) <> "" OR TRIM(winsp.accdetail5) <> "" THEN trim(nv_remark2) + " �ػ�ó������ : " + trim(winsp.acc2) + " " 
                    + TRIM(winsp.accdetail5) + "�Ҥ� : " + trim(winsp.accprice5) ELSE trim(nv_remark2).
IF INDEX(winsp.pol_fname,"�س")               <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"�س","")    nv_nameT = "�ؤ��".
ELSE IF INDEX(winsp.pol_fname,"���")          <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"���","")    nv_nameT = "�ؤ��".
ELSE IF INDEX(winsp.pol_fname,"�ҧ���")       <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"�ҧ���","") nv_nameT = "�ؤ��".
ELSE IF INDEX(winsp.pol_fname,"�ҧ")          <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"�ҧ","")    nv_nameT = "�ؤ��".
ELSE IF INDEX(winsp.pol_fname,"�.�.")         <> 0 THEN ASSIGN winsp.pol_fname = REPLACE(winsp.pol_fname,"�.�.","")   nv_nameT = "�ؤ��".
ELSE IF INDEX(winsp.pol_fname,"��ҧ�����ǹ") <> 0 THEN ASSIGN nv_nameT = "��ҧ�����ǹ�ӡѴ / ��ҧ�����ǹ".
ELSE IF INDEX(winsp.pol_fname,"˨�")          <> 0 THEN ASSIGN nv_nameT = "��ҧ�����ǹ�ӡѴ / ��ҧ�����ǹ".
ELSE IF INDEX(winsp.pol_fname,"����ѷ")       <> 0 THEN ASSIGN nv_nameT = "����ѷ".
ELSE IF INDEX(winsp.pol_fname,"���")          <> 0 THEN ASSIGN nv_nameT = "����ѷ".
ELSE IF INDEX(winsp.pol_fname,"��ŹԸ�")      <> 0 THEN ASSIGN nv_nameT = "��ŹԸ�".
ELSE IF INDEX(winsp.pol_fname,"�ç���")       <> 0 THEN ASSIGN nv_nameT = "�ç���".
ELSE IF INDEX(winsp.pol_fname,"�ç���¹")     <> 0 THEN ASSIGN nv_nameT = "�ç���¹".
ELSE IF INDEX(winsp.pol_fname,"�.�.")         <> 0 THEN ASSIGN nv_nameT = "�ç���¹".
ELSE IF INDEX(winsp.pol_fname,"�ç��Һ��")    <> 0 THEN ASSIGN nv_nameT = "�ç��Һ��".
ELSE IF INDEX(winsp.pol_fname,"�ԵԺؤ���Ҥ�êش") <> 0 THEN ASSIGN nv_nameT = "�ԵԺؤ���Ҥ�êش".
ELSE ASSIGN nv_nameT = "����".
ASSIGN nv_brand = trim(winsp.brand) nv_model = TRIM(winsp.model).
IF trim(winsp.licence) <> "" AND trim(winsp.province) <> "" THEN DO:
    ASSIGN nv_licentyp = "ö��/��к�/��÷ء".
    RUN proc_province.
END.
ELSE DO: 
    ASSIGN nv_licentyp = "ö����ѧ����շ���¹"
           nv_pattern4 = "/ZZZZZZZZZ" 
           winsp.licence = "/" + SUBSTR(winsp.chassis,LENGTH(winsp.chassis) - 8,LENGTH(winsp.chassis)) 
           winsp.province = "".
END.
IF trim(nv_agent) <> "" THEN DO:
 FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
      xmm600.acno  =  trim(nv_agent) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        FIND sicsyac.xtm600 USE-INDEX xtm60001  WHERE xtm600.acno  =  trim(nv_agent) NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xtm600 THEN 
            ASSIGN nv_agentname = TRIM(sicsyac.xtm600.ntitle) + "  "  + TRIM(sicsyac.xtm600.name) .
        ELSE ASSIGN nv_agentname = "".
    END.
    ELSE ASSIGN nv_agentname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name) .
END.
IF trim(winsp.licence) <> "" THEN DO:
   ASSIGN nv_licen = REPLACE(winsp.licence," ","").
   IF INDEX("0123456789",SUBSTR(winsp.licence,1,1)) <> 0 THEN DO:
       IF LENGTH(nv_licen) = 4 THEN 
          /*ASSIGN nv_Pattern1 = "y-xx-y-xx"   nv_licen = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,1). */ /*A63-0448*/
           ASSIGN nv_Pattern1 = "yxx-y-xx"     nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,1).   /*A63-0448*/
       ELSE IF LENGTH(nv_licen) = 5 THEN
          /* ASSIGN nv_Pattern1 = "y-xx-yy-xx" nv_licen = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,2).*/ /*A63-0448*/
           ASSIGN nv_Pattern1 = "yxx-yy-xx"    nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,2).     /*A63-0448*/
       ELSE IF LENGTH(nv_licen) = 6 THEN DO:
           IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yy-yyyy-xx"  nv_licen  = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           ELSE IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "yx-yyyy-xx"  nv_licen  = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4).
           /*ELSE  ASSIGN nv_Pattern1 = "y-xx-yyy-xx"   nv_licen = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,3). */ /*A63-0448*/
           ELSE  ASSIGN nv_Pattern1 = "yxx-yyy-xx"   nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3).  /*A63-0448*/
       END.
       /*ELSE ASSIGN nv_Pattern1 = "y-xx-yyyy-xx"   nv_licen = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,2) + " " + SUBSTR(nv_licen,4,4).*/ /*A63-0448*/
       ELSE ASSIGN nv_Pattern1 = "yxx-yyyy-xx"   nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,4).  /*A63-0448*/
    END.
    ELSE DO:
        IF      LENGTH(nv_licen) = 3 THEN  ASSIGN nv_Pattern1 = "xx-y-xx"   nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,1) .
        ELSE IF LENGTH(nv_licen) = 4 THEN  ASSIGN nv_Pattern1 = "xx-yy-xx"  nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,2) .
        ELSE IF LENGTH(nv_licen) = 6 THEN DO:
          IF INDEX("0123456789",SUBSTR(nv_licen,3,1)) <> 0 THEN  /*A63-0448*/
              ASSIGN nv_Pattern1 = "xx-yyyy-xx"  nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,4) .
          ELSE ASSIGN nv_Pattern1 = "xxx-yyy-xx"  nv_licen = SUBSTR(nv_licen,1,3) + " " + SUBSTR(nv_licen,4,3). /*A63-0448*/
        END.
        ELSE IF LENGTH(nv_licen) = 5 THEN DO:
            IF INDEX("0123456789",SUBSTR(nv_licen,2,1)) <> 0 THEN
               ASSIGN nv_Pattern1 = "x-yyyy-xx"  nv_licen = SUBSTR(nv_licen,1,1) + " " + SUBSTR(nv_licen,2,4).
            ELSE ASSIGN nv_Pattern1 = "xx-yyy-xx"   nv_licen = SUBSTR(nv_licen,1,2) + " " + SUBSTR(nv_licen,3,3).
        END.
    END.
END.
RUN proc_chkbr.
/*--------- Server Real ----------*/
nv_server = "Safety_NotesServer/Safety".
nv_tmp   = "safety\uw\" + nv_tmp .
/*-------------------------------*/
/*---------- Server test local -----------
nv_server = "".     nv_tmp    = "D:\Lotus\Notes\Data\ranui\" + nv_tmp .
---------------------------------------*/
CREATE "Notes.NotesSession"  chNotesSession.
chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
  IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
     MESSAGE "Can not open database" SKIP  
             "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
  END.
  chNotesView    = chNotesDatabase:GetView("chassis_no").
  chNavView      = chNotesView:CreateViewNavFromCategory(brstat.tlt.cha_no).
  chViewEntry    = chNavView:GetLastDocument.
 IF chViewEntry <> 0 THEN DO: 
     chDocument = chViewEntry:Document.
     IF VALID-HANDLE(chDocument) = YES THEN DO:
        RUN Proc_Getdatainsp.
        IF nv_docno <> ""  THEN DO:
            IF nv_survey <> "" THEN DO:
                IF nv_detail = "�Դ�ѭ��" THEN DO:
                    ASSIGN brstat.tlt.releas         = "YES" 
                           brstat.tlt.nor_noti_tlt   = nv_docno                      /*�Ţ����Ǩ��Ҿ */  
                           brstat.tlt.safe1          = nv_detail + " : " + nv_damage /* ����������� */
                           brstat.tlt.safe2          = nv_damdetail                  /*��¡�ä���������� */
                           brstat.tlt.safe3          = nv_device + nv_acctotal       /*��������´�ػ�ó������ */
                           brstat.tlt.filler2        = nv_surdata                    /*��������´���� */
                           brstat.tlt.datesent       = DATE(nv_date) .
                END.
                ELSE IF nv_detail = "�դ����������"  THEN DO:
                    ASSIGN brstat.tlt.releas         = "YES"
                           brstat.tlt.nor_noti_tlt   = nv_docno                      /*�Ţ����Ǩ��Ҿ */  
                           brstat.tlt.safe1          = nv_detail + " : " + nv_damlist + nv_totaldam /* ����������� */
                           brstat.tlt.safe2          = nv_damdetail                  /*��¡�ä���������� */
                           brstat.tlt.safe3          = nv_device + nv_acctotal       /*��������´�ػ�ó������ */
                           brstat.tlt.filler2        = nv_surdata                    /*��������´���� */
                           brstat.tlt.datesent       = DATE(nv_date) .
                END.
                ELSE DO:
                    ASSIGN brstat.tlt.releas      = "YES" 
                           brstat.tlt.nor_noti_tlt   = nv_docno                      /*�Ţ����Ǩ��Ҿ */  
                           brstat.tlt.safe1          = nv_detail                     /* ����������� */
                           brstat.tlt.safe2          = nv_damdetail                  /*��¡�ä���������� */
                           brstat.tlt.safe3          = nv_device + nv_acctotal       /*��������´�ػ�ó������ */
                           brstat.tlt.filler2        = nv_surdata                    /*��������´���� */
                           brstat.tlt.datesent     = DATE(nv_date) .
                END.
            END.
            ELSE 
              ASSIGN brstat.tlt.releas        = "NO"
                     brstat.tlt.nor_noti_tlt  = nv_docno                   /*�Ţ����Ǩ��Ҿ */          
                     brstat.tlt.safe1         = nv_detail                   /* ����������� */            
                     brstat.tlt.safe2         = ""                          /*��¡�ä���������� */       
                     brstat.tlt.safe3         = nv_device + nv_acctotal     /*��������´�ػ�ó������ */  
                     brstat.tlt.filler2       = nv_surdata .                /*��������´���� */ 
        END. /* end docno <> "" */
        ELSE DO:
            ASSIGN  brstat.tlt.releas       = "NO"
                    brstat.tlt.nor_noti_tlt = ""     /*�Ţ����Ǩ��Ҿ */          
                    brstat.tlt.safe1        = ""     /* ����������� */            
                    brstat.tlt.safe2        = ""     /*��¡�ä���������� */       
                    brstat.tlt.safe3        = ""     /*��������´�ػ�ó������ */  
                    brstat.tlt.filler2      = "".    /*��������´���� */   
        END.
        RELEASE  OBJECT chitem          NO-ERROR.
        RELEASE  OBJECT chDocument      NO-ERROR.          
        RELEASE  OBJECT chNotesDataBase NO-ERROR.     
        RELEASE  OBJECT chNotesSession  NO-ERROR.
     END. /* end chDocument = yes */
     ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO:
           chDocument = chNotesDatabase:CreateDocument.
           chDocument:AppendItemValue( "Form", "Inspection").
           chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
           chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
           chDocument:AppendItemValue( "App", 0 ).
           chDocument:AppendItemValue( "Chk", 0 ).
           chDocument:AppendItemValue( "dateS", brstat.tlt.gendat).
           chDocument:AppendItemValue( "dateE", brstat.tlt.expodat).
           chDocument:AppendItemValue( "ReqType_sub", "��Ǩ��Ҿ����").
           chDocument:AppendItemValue( "BranchReq", n_inspbr /*"Business Unit 3" --A67-0162--*/ ).
           chDocument:AppendItemValue( "Tname", nv_nameT).
           chDocument:AppendItemValue( "Fname", winsp.pol_fname).    
           chDocument:AppendItemValue( "Lname", winsp.pol_lname).
           chDocument:AppendItemValue( "Phone1", winsp.pol_tel).
           chDocument:AppendItemValue( "Phone2", winsp.insptel ).
           chDocument:AppendItemValue( "dateMeet", winsp.inspdate).    
           chDocument:AppendItemValue( "placeMeet", nv_remark1).
           chDocument:AppendItemValue( "PolicyNo", ""). 
           chDocument:AppendItemValue( "agentCode",trim(nv_agent)).  
           chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
           chDocument:AppendItemValue( "model", nv_brand).
           chDocument:AppendItemValue( "modelCode", nv_model).
           chDocument:AppendItemValue( "carCC", trim(winsp.chassis)).
           chDocument:AppendItemValue( "Year", trim(winsp.yrmanu)).           
           chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
           chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
           chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
           chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
           chDocument:AppendItemValue( "LicenseNo_2", trim(winsp.province)).
           chDocument:AppendItemValue( "commentMK", "�ع��Сѹ " + winsp.ins_amt + " ���� " + winsp.premtotal + " " + trim(nv_remark2)).
           chDocument:AppendItemValue( "Premium", winsp.premtotal ).
           chDocument:AppendItemValue( "StList",0 ).                                  
           chDocument:AppendItemValue( "stHide",0 ).                                  
           chDocument:AppendItemValue( "SendTo", "" ).                                 
           chDocument:AppendItemValue( "SendCC", "" ).
           chDocument:SAVE(TRUE,TRUE).
         RELEASE  OBJECT chitem          NO-ERROR.
         RELEASE  OBJECT chDocument      NO-ERROR.          
         RELEASE  OBJECT chNotesDataBase NO-ERROR.     
         RELEASE  OBJECT chNotesSession  NO-ERROR.
        ASSIGN  brstat.tlt.releas       = "NO"
                brstat.tlt.nor_noti_tlt = ""     /*�Ţ����Ǩ��Ҿ */          
                brstat.tlt.safe1        = ""     /* ����������� */            
                brstat.tlt.safe2        = ""     /*��¡�ä���������� */       
                brstat.tlt.safe3        = ""     /*��������´�ػ�ó������ */  
                brstat.tlt.filler2      = "".    /*��������´���� */ 
     END. /* end chDocument = NO  */
 END.
 ELSE DO: /* entry view = 0 */
        chDocument = chNotesDatabase:CreateDocument.
        chDocument:AppendItemValue( "Form", "Inspection").
        chDocument:AppendItemValue( "createdBy", chNotesSession:UserName).
        chDocument:AppendItemValue( "createdOn", nv_today + " " + nv_time).
        chDocument:AppendItemValue( "App", 0 ).
        chDocument:AppendItemValue( "Chk", 0 ).
        chDocument:AppendItemValue( "dateS", brstat.tlt.gendat).
        chDocument:AppendItemValue( "dateE", brstat.tlt.expodat).
        chDocument:AppendItemValue( "ReqType_sub", "��Ǩ��Ҿ����").
        chDocument:AppendItemValue( "BranchReq", n_inspbr /*"Business Unit 3" --A67-0162--*/ ).
        chDocument:AppendItemValue( "Tname", nv_nameT).
        chDocument:AppendItemValue( "Fname", winsp.pol_fname).    
        chDocument:AppendItemValue( "Lname", winsp.pol_lname).
        chDocument:AppendItemValue( "Phone1", winsp.pol_tel).
        chDocument:AppendItemValue( "Phone2", winsp.insptel ).
        chDocument:AppendItemValue( "dateMeet", winsp.inspdate).    
        chDocument:AppendItemValue( "placeMeet", nv_remark1).
        chDocument:AppendItemValue( "PolicyNo", ""). 
        chDocument:AppendItemValue( "agentCode",trim(nv_agent)).  
        chDocument:AppendItemValue( "Agentname",TRIM(nv_agentname)).
        chDocument:AppendItemValue( "model", nv_brand).
        chDocument:AppendItemValue( "modelCode", nv_model).
        chDocument:AppendItemValue( "carCC", trim(winsp.chassis)).
        chDocument:AppendItemValue( "Year", trim(winsp.yrmanu)).           
        chDocument:AppendItemValue( "LicenseType", trim(nv_licentyp)).
        chDocument:AppendItemValue( "PatternLi1", trim(nv_Pattern1)).
        chDocument:AppendItemValue( "PatternLi4", trim(nv_Pattern4)).
        chDocument:AppendItemValue( "LicenseNo_1", trim(nv_licen)).
        chDocument:AppendItemValue( "LicenseNo_2", trim(winsp.province)).
        chDocument:AppendItemValue( "commentMK", "�ع��Сѹ " + winsp.ins_amt + " ���� " + winsp.premtotal + " " + trim(nv_remark2)).
        chDocument:AppendItemValue( "Premium", winsp.premtotal ).
        chDocument:AppendItemValue( "StList",0 ).                                  
        chDocument:AppendItemValue( "stHide",0 ).
        chDocument:AppendItemValue( "SendTo", "" ).                                 
        chDocument:AppendItemValue( "SendCC", "" ).
        chDocument:SAVE(TRUE,TRUE).
      RELEASE  OBJECT chitem          NO-ERROR.
      RELEASE  OBJECT chDocument      NO-ERROR.          
      RELEASE  OBJECT chNotesDataBase NO-ERROR.     
      RELEASE  OBJECT chNotesSession  NO-ERROR.
     ASSIGN  brstat.tlt.releas       = "NO"
             brstat.tlt.nor_noti_tlt = ""     /*�Ţ����Ǩ��Ҿ */          
             brstat.tlt.safe1        = ""     /* ����������� */            
             brstat.tlt.safe2        = ""     /*��¡�ä���������� */       
             brstat.tlt.safe3        = ""     /*��������´�ػ�ó������ */  
             brstat.tlt.filler2      = "".    /*��������´���� */ 
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
       IF INDEX(winsp.province,".") <> 0 THEN REPLACE(winsp.province,".","").
        IF winsp.province = "���"  THEN winsp.province = "��".
        ELSE IF index(winsp.province,"��ا෾") <> 0  THEN winsp.province = "��". 
        ELSE DO:
           FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
                brstat.insure.compno = "999" AND 
                brstat.insure.FName  = TRIM(winsp.province) NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.insure THEN  ASSIGN winsp.province = brstat.Insure.LName.
        END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportmat_CA C-Win 
PROCEDURE proc_reportmat_CA :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
If  substr(nv_output,length(nv_output) - 3,4) <>  ".slk"  THEN 
    nv_output  =  Trim(nv_output) + ".slk"  .
OUTPUT TO VALUE(nv_output).
EXPORT DELIMITER "|" 
    "Report Match Cancel :" string(TODAY,"99/99/9999")   .
EXPORT DELIMITER "|" 
   " �ӴѺ        "
   " Company      "
   " Product      "
   " Branch       "
   " �Ţ�ѭ��     "
   " ����ѷ       "
   " ����¹ö    "
   " �Ţ��Ƕѧ    "
   " �Ţ�Ѻ��   "
   " ����         "
   " �ѹ������ͧ  "
   " ���� Slae    "
   " �����˵�     "
   " �š��¡��ԡ  " .
   
 FOR EACH wcancel NO-LOCK.
     EXPORT DELIMITER "|"
      wcancel.recno     
      wcancel.Company   
      wcancel.Product   
      wcancel.Branch    
      wcancel.contract  
      wcancel.comname   
      wcancel.licence   
      wcancel.chassis   
      wcancel.notify    
      wcancel.name      
      wcancel.comdate   
      wcancel.sale      
      wcancel.remark
      wcancel.comment  .
 END.
 OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_updatatlt C-Win 
PROCEDURE proc_updatatlt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
 ASSIGN  brstat.tlt.entdat        = TODAY                           /* date  99/99/9999  */
         brstat.tlt.enttim        = STRING(TIME,"HH:MM:SS")         /* char  x(8)        */
         brstat.tlt.trndat        = date(wdetail2.not_date)
         brstat.tlt.genusr        = "AYCAL"        
         brstat.tlt.usrid         = USERID(LDBNAME(1))          
         brstat.tlt.flag          = IF index(wdetail2.covtyp,"CMI") <> 0 THEN "V72" ELSE "V70"         
         brstat.tlt.policy        = ""       
         brstat.tlt.releas        = "NO"        
         /*brstat.tlt.subins        = "" */ /* A65-0115*/
         brstat.tlt.subins        = TRIM(nv_producer)  /* A65-0115*/       
         brstat.tlt.recac         = TRIM(nv_agent)
         brstat.tlt.lotno         = "InsCode:" + trim(wdetail.cmr_code)  + " " + /*���ʺ���ѷ��Сѹ��� */    
                                     "CamCode:" + trim(wdetail.campcode)  + " " +   /*������໭    */                   
                                     "CamName:" + trim(wdetail.campname)            /*������໭    */                   
         brstat.tlt.usrsent       = "ProName:" + trim(wdetail.proname )  + " " +    /*���ͼ�Ե�ѳ�� */                   
                                    "PackCod:" + trim(wdetail.packcode)          /*����ᾤࡨ    */        
         brstat.tlt.imp           = "Pol:" + TRIM(wdetail2.policy)               /*�������������� */             
         brstat.tlt.ins_name      = "NameTha:" + trim(wdetail.pol_title) + " "   /*�ӹ�˹�Ҫ���  */                   
                                             + trim(wdetail.pol_fname) + " "     /*���ͼ����һ�Сѹ    */                   
                                             + trim(wdetail.pol_lname)           /*���ʡ�ż����һ�Сѹ */                   
                                                                                 
         brstat.tlt.rec_addr5     = "ICNo:"  + trim(wdetail.icno)  + " " +       /*�Ţ���ѵû�ЪҪ�/�Ţ������������   */  
                                  "Sex:"   + trim(wdetail.sex)   + " " +         /*��                          */          
                                  "Birth:" + trim(wdetail.bdate)                 /*�ѹ��͹���Դ ( DD/MM/YYYY) */        
                                                                                 
         brstat.tlt.ins_addr5     = "Phone:" + TRIM(wdetail.phone)         /*�����ú�ҹ ���ӧҹ ��Ͷ��*/                 /*Line_ID */    
         /* brstat.tlt.ins_addr1     = trim(wdetail.addr1_70) + " " + trim(wdetail.addr2_70)  + " " +        /*�������١���*/    
                                  trim(wdetail.addr3_70) + " " + trim(wdetail.addr4_70)  + " " +        
                                  trim(wdetail.addr5_70)                                                
         brstat.tlt.ins_addr2     = trim(wdetail.nsub_dist70) + " " + trim(wdetail.ndirection70) + " " +  
                                  trim(wdetail.nprovin70) + " " + trim(wdetail.zipcode70) */              
         brstat.tlt.ins_addr3     = trim(wdetail.addr1_72) + " " + trim(wdetail.addr2_72) + " " +         /*�����٨Ѵ��*/        
                                  trim(wdetail.addr3_72) + " " + TRIM(wdetail.addr4_72) + " " +         
                                  trim(wdetail.addr5_72)                                                
         brstat.tlt.ins_addr4     = trim(wdetail.nsub_dist72) + " " + trim(wdetail.ndirection72) + " " +  
                                  trim(wdetail.nprovin72) + " " + TRIM(wdetail.zipcode72)               
         /*brstat.tlt.exp           = "PayTyp:" + TRIM(wdetail.paytype) + " " +                             /*������ �������Թ*/
                                  "Branch:" + TRIM(wdetail.branch) */                                     /*�Ң�*/
         brstat.tlt.rec_name      = trim(wdetail.paytitle) + " " + trim(wdetail.payname) + " " + TRIM(wdetail.paylname) /* ���� - ʡ�� �������Թ*/
         brstat.tlt.comp_sub      = trim(wdetail.payicno)                                                               /* �Ţ�ѵ� ���. �������Թ*/
         brstat.tlt.rec_addr1     = trim(wdetail.payaddr1) + " " + TRIM(wdetail.payaddr2) + " " +        /*��������͡����� */
                                  trim(wdetail.payaddr3) + " " + trim(wdetail.payaddr4) + " " + 
                                  trim(wdetail.payaddr5)
         brstat.tlt.rec_addr2     = trim(wdetail.payaddr6) + " " + TRIM(wdetail.payaddr7) + " " +
                                  trim(wdetail.payaddr8) + " " + trim(wdetail.payaddr9)
         brstat.tlt.safe1         = trim(wdetail.ben_title) + " " + TRIM(wdetail.ben_name) + " " + trim(wdetail.ben_lname) /*���� - ʡ�� ����Ѻ�Ż���ª��*/
         brstat.tlt.safe2         = /*"PaymentMD:"   + trim(wdetail.pmentcode)  + " " +*/ /*���ʻ�������ê������»�Сѹ*/  
                                  "PaymentMDTy:" + TRIM(wdetail.pmenttyp)   + " " + /*��������ê������»�Сѹ    */  
                                 /* "PaymentTyCd:" + trim(wdetail.pmentcode1) + " " + *//*���ʪ�ͧ�ҧ����������*/ 
                                  "Paymentty:"   + trim(wdetail.pmentcode2)         /*��ͧ�ҧ�����Ф������ */  
         /*brstat.tlt.safe3         = TRIM(wdetail.pmentbank) */                          /*��Ҥ�÷���������*/  
         /*brstat.tlt.rec_addr4     = "Paydat:" + trim(wdetail.pmentdate) + " " +       /*�ѹ�����Ф������*/  
                                  "PaySts:" + trim(wdetail.pmentsts)  + " " +       /*ʶҹС�ê������� */  
                                  "Paid:"   + trim(wdetail2.paysts)  */               /*ʶҹС�è����Թ*/
         brstat.tlt.datesent      = date(wdetail2.not_date)                           /*�ѹ�����       */
         /*brstat.tlt.dat_ins_noti  = date(wdetail2.paydate) */                           /*�ѹ����Ѻ�����Թ */  
         brstat.tlt.endcnt        = INT(wdetail.driver)                               /*����кت��ͼ��Ѻ */                                                                   
         brstat.tlt.dri_name1     = "Drinam1:" + trim(wdetail.drivetitle1) + " " +    /*�ӹ�˹�Ҫ��� ���Ѻ��� 1  */ 
                                               trim(wdetail.drivename1)  + " " +    /*���ͼ��Ѻ��� 1 */    
                                               trim(wdetail.drivelname1) + " " +    /*���ʡ�� ���Ѻ��� 1   */  
                                  "DriId1:"  + trim(wdetail.driveno1)               /*�Ţ���ѵü��Ѻ��� 1 */  
         brstat.tlt.dri_no1       = "DriOcc1:" + trim(wdetail.occupdriv1) + " " +     /*Driver1Occupation  */  
                                  "DriSex1:" + TRIM(wdetail.sexdriv1)   + " " +     /*�� ���Ѻ��� 1 */ 
                                  "DriBir1:" + trim(wdetail.bdatedriv1)             /*�ѹ��͹���Դ���Ѻ��� 1 */ 
         brstat.tlt.dri_name2     = "Drinam2:" + trim(wdetail.drivetitle2) + " " +    /*�ӹ�˹�Ҫ��� ���Ѻ��� 2  */ 
                                               trim(wdetail.drivename2)  + " " +    /*���ͼ��Ѻ��� 2    */ 
                                               trim(wdetail.drivelname2) + " " +    /*���ʡ�� ���Ѻ��� 2*/
                                  "DriId2:"  + trim(wdetail.driveno2)               /*�Ţ���ѵü��Ѻ���2 */ 
         brstat.tlt.dri_no2       = "DriOcc2:" + trim(wdetail.occupdriv2) + " " +     /*Driver2Occupation  */
                                  "DriSex2:" + TRIM(wdetail.sexdriv2)   + " " +      /*�� ���Ѻ��� 2    */
                                  "DriBir2:" + trim(wdetail.bdatedriv2).              /*�ѹ��͹���Դ���Ѻ��� 2 */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_updatatlt2 C-Win 
PROCEDURE proc_updatatlt2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    ASSIGN 
           brstat.tlt.brand         = TRIM(wdetail2.brand)           /*����ö¹��         */                                    
           brstat.tlt.model         = trim(wdetail2.Model)           /*�������ö¹��     */                                    
           brstat.tlt.expousr       = trim(wdetail2.body)            /*Ẻ��Ƕѧ          */                                    
           brstat.tlt.lince1        = trim(wdetail2.licence)         /*����¹ö          */                                    
           brstat.tlt.lince2        = trim(wdetail2.province)        /*�ѧ��Ѵ��訴����¹*/                                    
           brstat.tlt.cha_no        = CAPS(trim(wdetail2.chassis))   /*�Ţ��Ƕѧ          */                                    
           /*brstat.tlt.eng_no        = CAPS(trim(wdetail2.engine)) */    /*�Ţ����ͧ¹��     */     /*A65-0115*/ 
           brstat.tlt.eng_no        = IF SUBSTR(wdetail2.engine,1,1)  = "'" THEN CAPS(trim(replace(wdetail2.engine,"'",""))) 
                                      ELSE CAPS(TRIM(wdetail2.engine))    /*A65-0115*/
           brstat.tlt.gentim        = trim(wdetail2.yrmanu)          /*�ը�����¹ö      */                                    
           /*brstat.tlt.sentcnt       = INT(wdetail2.seatenew) */        /*�ӹǹ�����       */                                    
           brstat.tlt.rencnt        = INT(wdetail2.power)            /*��Ҵ����ͧ¹��    */                                    
           /*brstat.tlt.cc_weight     = INT(wdetail2.weight)  */         /*���˹ѡ            */                                    
           brstat.tlt.expotim       = trim(wdetail2.class)           /*���ʡ����ö¹��   */                                    
           brstat.tlt.old_cha       = "GarCd:" + trim(wdetail2.garage_cd)  /*���ʡ�ë���        */                 
                                     /* "GarTy:" + trim(wdetail2.garage)   */         /*��������ë���      */                 
           brstat.tlt.colorcod      = "" /* contact no , branch �ҡ���͹����� */                                             
           brstat.tlt.rec_addr3     = "CovCod:" + trim(wdetail2.covcod)  + " " +        /*�������ͧ��Сѹ���        */    
                                      "CovTcd:" + trim(wdetail2.covtyp)          /*���ʻ������ͧ��Сѹ���    */    
                                     /* "CovTyp:" + trim(wdetail2.covtyp1) + " " +        /*�������ͧ����������ͧ     */    
                                      "CovTy1:" + trim(wdetail2.covtyp2) + " " +        /*���������¢ͧ����������ͧ */    
                                      "CovTy2:" + trim(wdetail2.covtyp3) */               /*��������´����������ͧ    */    
           brstat.tlt.gendat        = date(wdetail2.comdat)                             /*�ѹ���������������ͧ      */    
           brstat.tlt.expodat       = DATE(wdetail2.expdat)                             /*�ѹ�������ش����������ͧ */    
           brstat.tlt.nor_coamt     = DECI(wdetail2.ins_amt)                            /*�ع��Сѹ                 */    
           brstat.tlt.nor_grprm     = DECI(wdetail2.prem1)                              /*�����ط�ԡ�͹�ѡ��ǹŴ   */    
           brstat.tlt.comp_grprm    = DECI(wdetail2.gross_prm)                          /*�����ط����ѧ�ѡ��ǹŴ   */    
           brstat.tlt.stat          = "Stm:" + STRING(deci(wdetail2.stamp)) + " " +     /*�ӹǹ�ҡ������       */    
                                      "Vat:" + STRING(DECI(wdetail2.vat))               /*�ӹǹ���� SBT/Vat     */    
           brstat.tlt.comp_coamt    = deci(wdetail2.premtotal)                          /*������� ����-�ҡ�    */    
           brstat.tlt.endno         = string(DECI(wdetail2.deduct))                     /*��Ҥ������������ǹ�á */    
           brstat.tlt.comp_sck      = /*"fetP:" + STRING(DECI(wdetail2.fleetper)) + " " +*/ /*% ��ǹŴ�����         */    
                                      "felA:" + STRING(DECI(wdetail2.fleet))            /*�ӹǹ��ǹŴ�����      */    
           brstat.tlt.comp_noti_tlt = /*"NcbP:" + string(DECI(wdetail2.ncbper)) + " " + */  /*% ��ǹŴ����ѵԴ�     */    
                                      "NcbA:" + string(DECI(wdetail2.ncb))              /*�ӹǹ��ǹŴ����ѵԴ�  */    
           brstat.tlt.comp_usr_tlt  = /*"DriP:" + string(DECI(wdetail2.drivper)) + " " +*/  /*% ��ǹŴ�óռ��Ѻ��� */    
                                      "DriA:" + string(DECI(wdetail2.drivdis))          /*�ӹǹ��ǹŴ�óռ��Ѻ���  */    
           brstat.tlt.comp_noti_ins = /*"OthP:" + string(DECI(wdetail2.othper)) + " " +*/   /*%�ǹŴ����           */    
                                      "OthA:" + string(DECI(wdetail2.oth))              /*�ӹǹ��ǹŴ����      */    
           brstat.tlt.comp_usr_ins  = /*"CTVP:" + string(DECI(wdetail2.cctvper)) + " " +*/  /*%�ǹŴ���ͧ           */    
                                      "CTVA:" + string(DECI(wdetail2.cctv))             /*�ӹǹ��ǹŴ���ͧ      */    
           brstat.tlt.comp_pol      = /*"SurP:" + string(DECI(wdetail2.Surcharper)) + " " + */ /*%��ǹŴ����        */   
                                      "SurA:" + string(DECI(wdetail2.Surchar))    + " " + /*�ӹǹ��ǹŴ����    */    
                                      "SurD:" + trim(wdetail2.Surchardetail)              /*��������´��ǹ���� */    
           brstat.tlt.filler1       = /*"Acc1:" + trim(wdetail2.acc1)       + " " +   */      /*���� �ػ�ó�1  */   
                                      "Acd1:" + trim(wdetail2.accdetail1) + " " +         /*��������´1    */    
                                      "Acp1:" + STRING(DECI(wdetail2.accprice1))  + " " + /*�Ҥ��ػ�ó�1   */    
                                      /*"Acc2:" + trim(wdetail2.acc2)       + " " +   */      /*���� �ػ�ó�2  */    
                                      "Acd2:" + trim(wdetail2.accdetail2) + " " +         /*��������´2    */    
                                      "Acp2:" + STRING(DECI(wdetail2.accprice2))  + " " + /*�Ҥ��ػ�ó�2   */    
                                     /* "Acc3:" + trim(wdetail2.acc3)       + " " +    */     /*���� �ػ�ó�3  */    
                                      "Acd3:" + trim(wdetail2.accdetail3) + " " +         /*��������´3    */    
                                      "Acp3:" + STRING(DECI(wdetail2.accprice3))  + " " + /*�Ҥ��ػ�ó�3   */    
                                     /* "Acc4:" + trim(wdetail2.acc4)       + " " +    */     /*���� �ػ�ó�4  */    
                                      "Acd4:" + trim(wdetail2.accdetail4) + " " +         /*��������´ 4   */    
                                      "Acp4:" + STRING(DECI(wdetail2.accprice4))  + " " + /*�Ҥ��ػ�ó�4   */    
                                    /*  "Acc5:" + trim(wdetail2.acc5)       + " " +    */     /*���� �ػ�ó�5  */    
                                      "Acd5:" + TRIM(wdetail2.accdetail5) + " " +        /*��������´ 5   */    
                                      "Acp5:" + STRING(deci(wdetail2.accprice5))         /*�Ҥ��ػ�ó�5     */    
           brstat.tlt.nor_effdat    = date(wdetail2.inspdate)                           /*�ѹ����Ǩ��Ҿö */    
           /*brstat.tlt.comp_effdat   = date(wdetail2.inspdate_app)       */                /*�ѹ���͹��ѵԵ�Ǩ��Ҿö   */    
           brstat.tlt.nor_noti_tlt  = /*"InspSt:" + trim(wdetail2.inspsts) + " " +   */     /*�š�õ�Ǩ��Ҿö           */    
                                      "InspDe:" + trim(wdetail2.inspdetail)             /*��������´��õ�Ǩ��Ҿö   */    
           /*brstat.tlt.old_eng       = "BLice:"  + trim(wdetail2.licenBroker) + " " +    /*�Ţ����͹حҵ���˹��   */      
                                      "Bname:"  + trim(wdetail2.brokname) + " " +       /*���ͺ���ѷ���˹��       */      
                                      "Bcode:"  + trim(wdetail2.brokcode)     */          /*�����ä����           */ 
           wdetail2.colorcode       = IF trim(wdetail2.colorcode) = "" THEN "" ELSE  "��ö:" + trim(wdetail2.colorcode) /*��ö¹��  */
           brstat.tlt.filler2       = /*"Detai1:" + trim(wdetail2.lang) + " " +           /*����㹡���͡��������    */      
                                      "Detai2:" + trim(wdetail2.deli) + " " +   */        /*��ͧ�ҧ��èѴ��        */      
                                      "Detai3:" + trim(wdetail2.delidetail) + " " +     /*�����˵ء�èѴ��       */      
                                     /* "Detai4:" + trim(wdetail2.gift) + " " +  */         /*�ͧ��                  */      
                                      "Remark:" + trim(wdetail2.remark) + wdetail2.colorcode    /*�����˵�                */    /*��ö¹��  */ 
           brstat.tlt.nor_noti_ins  = trim(wdetail2.cedcode)                            /*�Ţ�����ҧ�ԧ ����������ͧ*/    
           brstat.tlt.nor_usr_ins   = trim(wdetail2.inscode)                           /*Cust.Code No              */ 
           brstat.tlt.old_eng       = "Bphon:"  + trim(wdetail2.inspphone) + " " +   /* Car Inspection Phone            */
                                      "Bname:"  + trim(wdetail2.inspname) + " " +   /* Car Inspection Name             */         
                                      "Bloca:"  + trim(wdetail2.insploca)            /* Car Inspection Location         */
           brstat.tlt.exp           = TRIM(wdetail2.agname)   
           /*brstat.tlt.ins_addr1     = IF tg_br = YES THEN "EMP" ELSE "ORA" . /*A63-0448*/*/ /*A65-0115*/
           brstat.tlt.ins_addr1     = TRIM(nv_branch)  /*A65-0115*/
           brstat.tlt.dealer        = TRIM(nv_dealer) . /*A65-0115*/
           /* Add by : A67-0162 */
       ASSIGN 
           brstat.tlt.note2         = trim(wdetail2.tyeeng)   
           brstat.tlt.note3         = trim(wdetail2.typMC)   
           brstat.tlt.watts         = DECI(wdetail2.watt)   
           brstat.tlt.note4         = trim(wdetail2.evmotor1)
           brstat.tlt.note5         = trim(wdetail2.evmotor2)
           brstat.tlt.note6         = trim(wdetail2.evmotor3)
           brstat.tlt.note7         = trim(wdetail2.evmotor4)
           brstat.tlt.note8         = trim(wdetail2.evmotor5)
           brstat.tlt.note9         = trim(wdetail2.evmotor6)
           brstat.tlt.note10        = trim(wdetail2.evmotor7)
           brstat.tlt.note11        = trim(wdetail2.evmotor8)
           brstat.tlt.note12        = trim(wdetail2.evmotor9)
           brstat.tlt.note13        = trim(wdetail2.evmotor10)
           brstat.tlt.note14        = trim(wdetail2.evmotor11)
           brstat.tlt.note15        = trim(wdetail2.evmotor12)
           brstat.tlt.note16        = trim(wdetail2.evmotor13)
           brstat.tlt.note17        = trim(wdetail2.evmotor14)
           brstat.tlt.note18        = trim(wdetail2.evmotor15)
           brstat.tlt.maksi         = DECI(wdetail2.carprice)
           brstat.tlt.dri_lic1      = trim(wdetail2.drivlicen1)  
           brstat.tlt.dri_licenexp1 = trim(wdetail2.drivcardexp1) 
           brstat.tlt.dri_ic1       = trim(wdetail2.drivcartyp1)  
           brstat.tlt.dri_lic2      = trim(wdetail2.drivlicen2)  
           brstat.tlt.dri_licenexp2 = trim(wdetail2.drivcardexp2) 
           brstat.tlt.dri_ic2       = trim(wdetail2.drivcartyp2)  
           brstat.tlt.dri_title3    = trim(wdetail2.drivetitle3)  
           brstat.tlt.dri_fname3    = trim(wdetail2.drivename3)  
           brstat.tlt.dri_lname3    = trim(wdetail2.drivelname3)  
           brstat.tlt.dri_birth3    = trim(wdetail2.bdatedriv3)  
           brstat.tlt.dri_gender3   = trim(wdetail2.sexdriv3)  
           brstat.tlt.dri_ic3       = trim(wdetail2.drivcartyp3)  
           brstat.tlt.dri_no3       = trim(wdetail2.driveno3)  
           brstat.tlt.dri_lic3      = trim(wdetail2.drivlicen3)  
           brstat.tlt.dri_licenexp3 = trim(wdetail2.drivcardexp3) 
           brstat.tlt.dir_occ3      = trim(wdetail2.occupdriv3)  
           brstat.tlt.dri_title4    = trim(wdetail2.drivetitle4)  
           brstat.tlt.dri_fname4    = trim(wdetail2.drivename4)  
           brstat.tlt.dri_lname4    = trim(wdetail2.drivelname4)  
           brstat.tlt.dri_birth4    = trim(wdetail2.bdatedriv4)  
           brstat.tlt.dri_gender4   = trim(wdetail2.sexdriv4)  
           brstat.tlt.dri_ic4       = trim(wdetail2.drivcartyp4) 
           brstat.tlt.dri_no4       = trim(wdetail2.driveno4)  
           brstat.tlt.dri_lic4      = trim(wdetail2.drivlicen4)  
           brstat.tlt.dri_licenexp4 = trim(wdetail2.drivcardexp4) 
           brstat.tlt.dri_occ4      = trim(wdetail2.occupdriv4)  
           brstat.tlt.dri_title5    = trim(wdetail2.drivetitle5)  
           brstat.tlt.dri_fname5    = trim(wdetail2.drivename5)  
           brstat.tlt.dri_lname5    = trim(wdetail2.drivelname5)  
           brstat.tlt.dri_birth5    = trim(wdetail2.bdatedriv5)   
           brstat.tlt.dri_gender5   = trim(wdetail2.sexdriv5)   
           brstat.tlt.dri_ic5       = trim(wdetail2.drivcartyp5)  
           brstat.tlt.dri_no5       = trim(wdetail2.driveno5)   
           brstat.tlt.dri_lic5      = trim(wdetail2.drivlicen5)   
           brstat.tlt.dri_licenexp5 = trim(wdetail2.drivcardexp5) 
           brstat.tlt.dri_occ5      = trim(wdetail2.occupdriv5)   
           brstat.tlt.battflg       = IF trim(wdetail2.battflag) = "Y" THEN YES ELSE NO  
           brstat.tlt.battyr        = trim(wdetail2.battyr)   
           brstat.tlt.ndate1        = IF trim(wdetail2.battdate) <> "" THEN DATE(wdetail2.battdate) ELSE ?  
           brstat.tlt.battprice     = DECI(wdetail2.battprice)   
           brstat.tlt.battno        = trim(wdetail2.battno)   
           brstat.tlt.battsi        = DECI(wdetail2.battsi)   
           brstat.tlt.chargno       = trim(wdetail2.chagreno)   
           brstat.tlt.note19        = trim(wdetail2.chagrebrand) .
          /* end : A67-0162 */

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uptlt_old C-Win 
PROCEDURE proc_uptlt_old :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_comdat AS DATE .
DEF BUFFER bftlt FOR brstat.tlt.
DEFINE VAR n_undyr      AS CHARACTER FORMAT "X(4)"  NO-UNDO.
DEFINE VAR n_notifyno   AS CHARACTER FORMAT "X(20)" NO-UNDO.
DEFINE VAR nv_message   AS CHARACTER                NO-UNDO.
DEFINE VAR n_running    AS INTE.
DEFINE VAR n_polno      AS CHAR FORMAT "X(8)".
DEFINE VAR nv_err       AS LOGICAL.
DEFINE VAR nv_complete  AS INTE.
DEFINE VAR nv_ncomplete AS INTE.
DEFINE VAR Choice       AS LOGICAL   INIT NO NO-UNDO.
DEFINE VAR nv_update    AS LOGICAL INIT NO.
DO:
    ASSIGN n_comdat = ? 
           n_comdat = DATE(SUBSTR(TRIM(wdetail01.comdat70),5,2) + "/" +
                      SUBSTR(TRIM(wdetail01.comdat70),3,2) + "/" +
                      STRING(DECI("25" + SUBSTR(TRIM(wdetail01.comdat70),1,2)) - 543)).  /* 27  �ѹ������ͧ��.  */  

    IF tlt.nor_effdat <> n_comdat THEN DO:
        ASSIGN  n_undyr          = STRING(YEAR(TODAY) + 543 ,"9999")
                nv_message       = "" .
                running_polno: /*-- Running --*/
                REPEAT:
                    n_running = n_running + 1.
                    RUN wgw\wgwpolay (INPUT        YES,
                                      INPUT        "V70", 
                                      INPUT        "STY", 
                                      INPUT        n_undyr,
                                      INPUT        "A0M0061",
                                      INPUT-OUTPUT n_notifyno,   
                                      INPUT-OUTPUT nv_message). 
                    IF nv_message <> "" THEN DO:
                        IF n_running > 10 THEN DO: 
                            n_notifyno = "".
                            LEAVE running_polno.
                        END.
                    END.
                    FIND LAST bftlt WHERE bftlt.genusr       = "aycal"    AND
                                        bftlt.nor_noti_tlt = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                    IF NOT AVAIL bftlt THEN LEAVE running_polno.
                END.    
                IF n_notifyno = "" THEN DO:
                    n_polno    = SUBSTR(wdetail01.Contract,1,8).
                    n_notifyno = "STY" + SUBSTR(STRING(YEAR(TODAY)),3,2) + STRING(n_polno,"99999999").
        
                    FIND LAST bftlt WHERE bftlt.genusr       = "aycal"    AND
                                        bftlt.nor_noti_tlt = n_notifyno NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL bftlt THEN DO:
                        MESSAGE "���Ţ�Ѻ�� " n_notifyno " ��к����� " VIEW-AS ALERT-BOX.
                        nv_err     = YES.
                        nv_ncomplete = nv_ncomplete + 1.
                    END.
                END.
    END.

    IF nv_err = NO THEN DO: 
        /*CREATE tlt.*/
        ASSIGN
            tlt.entdat            = TODAY                                                  
            tlt.enttim            = STRING(TIME,"HH:MM:SS")                            
            tlt.trntime           = STRING(TIME,"HH:MM:SS")                            
            tlt.trndat            = TODAY                   
            tlt.genusr            = "AYCAL"                       /* 1   COMPANY CODE              */                   
            tlt.flag              = trim(wdetail01.Porduct)         /* 2   PRODUCT CODE              */  
            tlt.comp_usr_tlt      = trim(wdetail01.Branch)          /* 3   BRANCH CODE               */  
            tlt.recac             = trim(wdetail01.Contract)        /* 4   CONTRACT NO.              */  
            tlt.ins_name          = trim(wdetail01.nTITLE) + " " +  /* 5   CUSTOMER THAI TITLE       */  
                                    trim(wdetail01.name1)  + " " +  /* 6   FIRST NAME - THAI         */  
                                    trim(wdetail01.name2)           /* 7   LAST NAME  - THAI         */  
            tlt.safe2             = trim(wdetail01.idno)            /* 8   CARD NO.                  */  
            tlt.ins_addr1         = TRIM(np_addr1)                /* 9   REGISTER ADDRESS LINE 1   */  
            tlt.ins_addr2         = TRIM(np_addr2)                /* 10  REGISTER ADDRESS LINE 2   */  
            tlt.ins_addr3         = TRIM(np_addr3)                /* 11  REGISTER ADDRESS LINE 3   */  
            tlt.ins_addr4         = TRIM(np_addr4)                /* 12  REGISTER ADDRESS LINE 4   */  
            tlt.ins_addr5         = TRIM(np_addr5)                /* 12  REGISTER ZIP.CODE         */ 
            tlt.brand             = TRIM(wdetail01.brand)           /* 13  ������                    */  
            tlt.model             = TRIM(wdetail01.model)           /* 14  ���                      */  
            tlt.lince1            = TRIM(wdetail01.vehreg) + " " +  /* 16  ����¹ö                 */  
                                    TRIM(wdetail01.provin)          /* 17  �ѧ��Ѵ                   */  
            tlt.lince2            = TRIM(wdetail01.caryear)         /* 18  ��ö                      */  
            tlt.cc_weight         = DECI(wdetail01.cc)              /* 19  CC                        */  
            tlt.cha_no            = TRIM(wdetail01.chassis)         /* 20  �Ţ��Ƕѧ                 */  
            tlt.eng_no            = TRIM(wdetail01.engno)           /* 21  �Ţ����ͧ                */  
            tlt.comp_noti_tlt     = TRIM(wdetail01.notifyno)        /* 22  CODE �����              */  
            tlt.safe3             = TRIM(wdetail01.covcod)          /* 24  INSURANCE TYPE            */  
            tlt.nor_usr_ins       = TRIM(wdetail01.Codecompany)     /* 25  INSURANCE CODE            */  
            tlt.nor_noti_ins      = TRIM(wdetail01.prepol)          /* 26  �Ţ�����������           */     
            tlt.nor_effdat        = DATE(SUBSTR(TRIM(wdetail01.comdat70),5,2) + "/" +
                                    SUBSTR(TRIM(wdetail01.comdat70),3,2) + "/" +
                                    STRING(DECI("25" + SUBSTR(TRIM(wdetail01.comdat70),1,2)) - 543))  /* 27  �ѹ������ͧ��.  */  
            tlt.expodat           = DATE(SUBSTR(TRIM(wdetail01.expdat70),5,2) + "/" +                                        
                                    SUBSTR(TRIM(wdetail01.expdat70),3,2) + "/" +                                             
                                    STRING(DECI("25" + SUBSTR(TRIM(wdetail01.expdat70),1,2)) - 543))  /* 28  �ѹ������ء�.   */  
            tlt.comp_coamt        = IF DECI(wdetail01.si) = 0 THEN 0 ELSE DECI(wdetail01.si)     /* 29  �ع��Сѹ       */ 
            tlt.sentcnt           = DECI(wdetail01.siIns)         /* 30  ���»�Сѹ�Ѻ�ҡ�١��� */                            
            tlt.dri_name2         = STRING(DECI(wdetail01.premt)) /* 31  �����ط��              */  
            tlt.nor_grprm         = DECI(wdetail01.premtnet)      /* 32  �����������            */  
            tlt.rencnt            = DECI(wdetail01.renew)         /* 33  �ջ�Сѹ                */  
                                                                /* 32  �Ţ�Ѻ��   tlt.nor_noti_tlt   = trim(wdetail01.policy) */ 
            tlt.nor_noti_tlt      = IF trim(n_notifyno) = "" THEN tlt.nor_noti_tlt ELSE trim(n_notifyno)
            tlt.datesent          = IF TRIM(wdetail01.notifydate) = "" THEN ? 
                                    ELSE DATE(SUBSTR(TRIM(wdetail01.notifydate),5,2) + "/" +         /*33  �ѹ�����*/                                                                     
                                    SUBSTR(TRIM(wdetail01.notifydate),3,2) + "/" +
                                    STRING(DECI("25" + SUBSTR(TRIM(wdetail01.notifydate),1,2)) - 543))  
            tlt.seqno             = DECI(wdetail01.Deduct)          /* 36  DEDUCT AMOUNT             */  
            tlt.comp_effdat       = IF wdetail01.comdat72 = "" THEN ? 
                                    ELSE IF wdetail01.comdat72 = "0" THEN ?
                                    ELSE DATE(SUBSTR(TRIM(wdetail01.comdat72),5,2) + "/" +         /*36  �ѹ������ͧ�ú.*/ 
                                    SUBSTR(TRIM(wdetail01.comdat72),3,2) + "/" +
                                    STRING(DECI("25" + SUBSTR(TRIM(wdetail01.comdat72),1,2)) - 543))
            tlt.dat_ins_noti      = IF wdetail01.expdat72 = "" THEN ? 
                                    ELSE IF wdetail01.expdat72 = "0" THEN ?
                                    ELSE DATE(SUBSTR(TRIM(wdetail01.expdat72),5,2) + "/" +        /*37  �ѹ����ú.*/ 
                                    SUBSTR(TRIM(wdetail01.expdat72),3,2) + "/" +
                                    STRING(DECI("25" + SUBSTR(TRIM(wdetail01.expdat72),1,2)) - 543))
            tlt.dri_no1           = TRIM(wdetail01.comp)            /* 40  ������� �ú.             */  
            tlt.dri_name1         = IF TRIM(wdetail01.driverno) = "" THEN "1" ELSE "2" /* 41  �кؼ��Ѻ��������      */  
            tlt.dri_no2           = "N1:"  + trim(wdetail01.drivername1)  + " " +       /* 42 ���Ѻ��褹��� 1     */    
                                    "B1:"  + trim(wdetail01.driverbrith1) + " " +       /* 43 �ѹ��͹���Դ 1     */    
                                    "IC1:" + trim(wdetail01.drivericno1)  + " " +       /* 44 �����Ţ�ѵ� 1        */   
                                    "DC1:" + trim(wdetail01.driverCard1)  + " " +       /* 45 DRIVER CARD 1        */   
                                    "EP1:" + trim(wdetail01.driverexp1)   + " " +       /* 46 DRIVER CARD EXPIRE 1 */    
                                    "N2:"  + trim(wdetail01.drivername2)  + " " +       /* 47 ���Ѻ��褹��� 2     */    
                                    "B2:"  + trim(wdetail01.driverbrith2) + " " +       /* 48 �ѹ��͹���Դ 2     */    
                                    "IC2:" + trim(wdetail01.drivericno2)  + " " +       /* 49 �����Ţ�ѵ� 1        */    
                                    "DC2:" + trim(wdetail01.driverCard2)  + " " +       /* 50 DRIVER CARD 2        */ 
                                    "EP2:" + trim(wdetail01.driverexp2)   + " " +       /* 51 DRIVER CARD EXPIRE 2 */     
                                    "AG:"  + TRIM(wdetail01.AgencyEmployee) + " " +     /* 23  ���ͼ���駧ҹ      */                     
                                    "CTP:" + TRIM(wdetail01.InsCTP)                    /* 37  INSURER CTP         */ 
            tlt.stat               = TRIM(wdetail01.garage)                            /* 52  ������ҧ            */  
            tlt.usrsent            = "IN:"  + trim(wdetail01.InspectName)  + " " +      /* 53  ���ͼ���Ǩö       */  
                                     "IP:"  + trim(wdetail01.InspectPhoneNo)            /* 54  �������Ѿ�����Ǩö */    
            tlt.safe1              = TRIM(wdetail01.access) /* 53  ������ͧ�ػ�ó��������  */  
            tlt.filler2            = trim(wdetail01.Plus12) /* 55  FLAG FOR 12PLUS           */  
            tlt.OLD_eng            = "complete"           
            tlt.endno              = USERID(LDBNAME(1))   /*User Load Data */
            /*tlt.imp                = "IM"                 /*Import Data    */*/ /*A63-0448*/
            /*brstat.tlt.imp                = IF tg_br = YES THEN "EMP" ELSE "ORA"   /*A63-0448*/*/ /*A65-0115*/
            tlt.releas             = "NO"                 
            tlt.rec_addr4          = nv_agent            /*Agent code*/   
            tlt.usrid              = ""                   /*User Edit Data*/ /*add By Sarinya C A61-0349 23/07/2018*/
            brstat.tlt.EXP         = "OLD" 
            brstat.tlt.OLD_cha     = ""                  /* �����˵� */
            brstat.tlt.lotno       = ""                  /* �����˵�¡��ԡ */
            brstat.tlt.comp_usr_ins = trim(wdetail01.Benefic).
            /*
            company  = trim(wdetail01.Company).
            IF company = "AYCAL" THEN ASSIGN tlt.comp_usr_ins = "���.��ظ�� ᤻�Ե�� ���� ���" .
            ELSE IF company = "BAY" THEN ASSIGN tlt.comp_usr_ins = "��Ҥ�á�ا�����ظ�� �ӡѴ (��Ҫ�)" .
            ELSE tlt.comp_usr_ins = "¡��ԡ 8.3" .*/
       nv_complete = nv_complete + 1.
    END.        
       
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

