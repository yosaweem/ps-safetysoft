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
program id    : wgwimkk2.w   [Import text file from  KK  to create  new policy Add in table tlt( brstat)]  
Program name  : Import Text File KK
Create  by    : Kridtiya i.  [A55-0055]  date. 13/02/2012
copy program  : wgwimkk1.w  
Connect       : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW (not connect: dbstat)
modify by     : Kridtiya i. A55-0280 ��Ѻ����Ѻ����Ţ��Ƕѧ�Ѵ����ͧ���� + - / . , �͡��͹��úѹ�֡
modity by     : Kridtiya i. A57-0274 �������������ʴ�����Ѻ��Сѹ��� �ú.
modify by     : Ranu I. A61-0335 Date 11/07/2018 ���������� kk App ��� ���¡��ԡ�������� 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE VAR nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.  
DEFINE VAR nv_reccnt      AS INT  INIT  0.                                       
DEFINE VAR nv_completecnt AS INT  INIT  0.  
DEFINE VAR nv_error       AS INT  INIT  0.      
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail NO-UNDO
    FIELD createdat    AS CHAR FORMAT "X(10)"  INIT ""  /*1   Create Date               */                                    
    FIELD createdat2   AS CHAR FORMAT "X(10)"  INIT ""  /*2   �ѹ������                */                                    
    FIELD compno       AS CHAR FORMAT "X(50)"  INIT ""  /*3   ��ª��ͺ���ѷ��Сѹ���    */                            
    FIELD brno         AS CHAR FORMAT "X(10)"  INIT ""  /*4   �����Ң� KK               */                            
    FIELD brname       AS CHAR FORMAT "X(30)"  INIT ""  /*5   �Ң� KK                   */                            
    FIELD cedno        AS CHAR FORMAT "X(25)"  INIT ""  /*6   �Ţ����ѭ����ҫ���       */                            
    FIELD prevpol      AS CHAR FORMAT "X(25)"  INIT ""  /*7   �Ţ�������������        */                            
    FIELD cedpol       AS CHAR FORMAT "X(25)"  INIT ""  /*8   �Ţ����Ѻ��             */                            
    FIELD campaign     AS CHAR FORMAT "X(40)"  INIT ""  /*9   Campaign                  */                            
    FIELD subcam       AS CHAR FORMAT "X(100)" INIT ""  /*10  Sub Campaign              */                            
    FIELD free         AS CHAR FORMAT "X(50)"  INIT ""  /*11  �����������              */                            
    FIELD typeins      AS CHAR FORMAT "X(20)"  INIT ""  /*12  �ؤ��/�ԵԺؤ��           */                            
    FIELD titlenam     AS CHAR FORMAT "X(30)"  INIT ""  /*13  �ӹ�˹�Ҫ��ͼ����һ�Сѹ  */                          
    FIELD name1        AS CHAR FORMAT "X(40)"  INIT ""  /*14  ���ͼ����һ�Сѹ          */                              
    FIELD name2        AS CHAR FORMAT "X(40)"  INIT ""  /*15  ���ʡ�ż����һ�Сѹ       */                              
    FIELD ad11         AS CHAR FORMAT "X(20)"  INIT ""  /*16  ��ҹ�Ţ���                */                              
    FIELD ad12         AS CHAR FORMAT "X(10)"  INIT ""  /*17  ������                   */                              
    FIELD ad13         AS CHAR FORMAT "X(40)"  INIT ""  /*18  �Ҥ��/  �����ҹ          */                              
    FIELD ad14         AS CHAR FORMAT "X(30)"  INIT ""  /*19  ���                       */                              
    FIELD ad15         AS CHAR FORMAT "X(30)"  INIT ""  /*20  ���                       */                              
    FIELD ad21         AS CHAR FORMAT "X(30)"  INIT ""  /*21  �Ӻ�/�ǧ                 */                              
    FIELD ad22         AS CHAR FORMAT "X(30)"  INIT ""  /*22  �����/ ࢵ                */                              
    FIELD ad3          AS CHAR FORMAT "X(30)"  INIT ""  /*23  �ѧ��Ѵ                   */                                
    FIELD post         AS CHAR FORMAT "X(10)"  INIT ""  /*24  ������ɳ���              */                              
    FIELD covcod       AS CHAR FORMAT "X(20)"  INIT ""  /*25  ����������������ͧ        */                              
    FIELD garage       AS CHAR FORMAT "X(20)"  INIT ""  /*26  ��������ë���             */                              
    FIELD comdat       AS CHAR FORMAT "X(10)"  INIT ""  /*27  �ѹ��������ͧ�������    */                            
    FIELD expdat       AS CHAR FORMAT "X(10)"  INIT ""  /*28  �ѹ��������ͧ����ش     */                            
    FIELD class        AS CHAR FORMAT "X(10)"  INIT ""  /*29  ����ö                    */                            
    FIELD typecar      AS CHAR FORMAT "X(40)"  INIT ""  /*30  ��������Сѹ���ö¹��     */                            
    FIELD brand        AS CHAR FORMAT "X(20)"  INIT ""  /*31  ����������ö              */                            
    FIELD model        AS CHAR FORMAT "X(50)"  INIT ""  /*32  ���ö                    */                            
    FIELD typenam      AS CHAR FORMAT "X(10)"  INIT ""  /*33  New/      Used            */                            
    FIELD vehreg       AS CHAR FORMAT "X(45)"  INIT ""  /*34  �Ţ����¹                */                            
    FIELD veh_country  AS CHAR FORMAT "X(30)"  INIT ""  /*35  �ѧ��Ѵ����͡�Ţ����¹   */                           
    FIELD chassis      AS CHAR FORMAT "X(30)"  INIT ""  /*36  �Ţ����Ƕѧ              */                            
    FIELD engno        AS CHAR FORMAT "X(30)"  INIT ""  /*37  �Ţ�������ͧ¹��         */                            
    FIELD caryear      AS CHAR FORMAT "X(10)"  INIT ""  /*38  ��ö¹��                  */                            
    FIELD cc           AS CHAR FORMAT "X(30)"  INIT ""  /*39  �ի�                      */                            
    FIELD weigth       AS CHAR FORMAT "X(30)"  INIT ""  /*40  ���˹ѡ/      �ѹ         */                            
    FIELD si           AS CHAR FORMAT "X(20)"  INIT ""  /*41  �ع��Сѹ�� 1 /�������    */                            
    FIELD prem         AS CHAR FORMAT "X(20)"  INIT ""  /*42  ���������������ҡû� 1 /�������  */                  
    FIELD si2          AS CHAR FORMAT "X(20)"  INIT ""  /*43  �ع��Сѹ�� 2                     */                  
    FIELD prem2        AS CHAR FORMAT "X(10)"  INIT ""  /*44  ���������������ҡû� 2           */                  
    FIELD timeno       AS CHAR FORMAT "X(20)"  INIT ""  /*45  �����Ѻ��                       */                      
    FIELD stk          AS CHAR FORMAT "X(30)"  INIT ""  /*46  �Ţ����ͧ���µ�� �.�.�.          */                  
    FIELD compdatco    AS CHAR FORMAT "X(10)"  INIT ""  /*47  �ѹ������ͧ(�.�.�)�������        */                 
    FIELD expdatco     AS CHAR FORMAT "X(10)"  INIT ""  /*48  �ѹ������ͧ(�.�.�)����ش         */                  
    FIELD compprm      AS CHAR FORMAT "X(20)"  INIT ""  /*49  ���������������ҡ� (�.�.�)       */                    
    FIELD notifynam    AS CHAR FORMAT "X(50)"  INIT ""  /*50   �������˹�ҷ���Ѻ��           */                  
    FIELD memmo        AS CHAR FORMAT "X(100)" INIT ""  /*51  �����˵� / ���������ʹ�������   */                  
    FIELD drivnam1     AS CHAR FORMAT "X(40)"  INIT ""  /*52  ���Ѻ����� 1                    */                  
    FIELD birdth1      AS CHAR FORMAT "X(15)"  INIT ""  /*53  �ѹ�Դ���Ѻ����� 1             */                  
    FIELD drivnam2     AS CHAR FORMAT "X(40)"  INIT ""  /*54  ���Ѻ����� 2                    */                  
    FIELD birdth2      AS CHAR FORMAT "X(15)"  INIT ""  /*55  �ѹ�Դ���Ѻ����� 2             */                  
    FIELD invoice      AS CHAR FORMAT "X(50)"  INIT ""  /*56  ���� - ʡ�� (�����/㺡ӡѺ����) */                 
    FIELD addinvoice   AS CHAR FORMAT "X(100)" INIT ""  /*57  ������� (�����/㺡ӡѺ����)     */                 
    FIELD emtry        AS CHAR FORMAT "X(100)" INIT ""  /*58                                    */
    FIELD datasystem   AS CHAR FORMAT "X(10)"  INIT ""  /*59 �����Ũҡ�к�                      */
    FIELD data_blank   AS CHAR FORMAT "X(10)"  INIT ""  /*A57-0274 */
    FIELD dataidno     AS CHAR FORMAT "X(15)"  INIT ""  /*A57-0274 */
    FIELD kkapp        AS CHAR FORMAT "x(30)"  INIT ""  . /*A61-0335*/

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
&Scoped-define INTERNAL-TABLES tlt

/* Definitions for BROWSE br_imptxt                                     */
&Scoped-define FIELDS-IN-QUERY-br_imptxt tlt.comp_noti_tlt tlt.nor_noti_tlt ~
tlt.ins_name tlt.old_eng tlt.nor_effdat tlt.expodat tlt.lince1 ~
tlt.nor_usr_ins tlt.comp_usr_ins tlt.trndat 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_imptxt tlt.lince1 
&Scoped-define ENABLED-TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-ENABLED-TABLE-IN-QUERY-br_imptxt tlt
&Scoped-define QUERY-STRING-br_imptxt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_imptxt OPEN QUERY br_imptxt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_imptxt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_imptxt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_type fi_loaddat fi_compano fi_producer ~
fi_agent fi_filename bu_file bu_ok bu_exit br_imptxt bu_hpacno1 bu_hpacno-2 ~
fi_output RECT-1 RECT-78 RECT-79 RECT-80 
&Scoped-Define DISPLAYED-OBJECTS rs_type fi_loaddat fi_compano fi_producer ~
fi_agent fi_filename fi_proname fi_impcnt fi_completecnt fi_dir_cnt ~
fi_dri_complet fi_agename fi_error fi_dri_fi_error fi_output 

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
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpacno-2 
     IMAGE-UP FILE "I:/SAFETY/WALP83/WIMAGE\help":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "I:/SAFETY/WALP83/WIMAGE\help":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 8.5 BY 1
     FONT 6.

DEFINE VARIABLE fi_agename AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1.05
     BGCOLOR 18 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_compano AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dir_cnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dri_complet AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dri_fi_error AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1.05
     BGCOLOR 4 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_error AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1.05
     BGCOLOR 4 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 63 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1.05
     BGCOLOR 18 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "����駻�Сѹ���", 1,
"���¡��ԡ��������", 2
     SIZE 91.5 BY 1
     BGCOLOR 29 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 23.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-78
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 9.71
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-79
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-80
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 11.5 BY 1.91
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_imptxt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_imptxt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_imptxt C-Win _STRUCTURED
  QUERY br_imptxt NO-LOCK DISPLAY
      tlt.comp_noti_tlt COLUMN-LABEL "�Ţ����Ѻ��� KK." FORMAT "x(25)":U
            WIDTH 14.5
      tlt.nor_noti_tlt COLUMN-LABEL "�Ţ����ѭ��" FORMAT "x(25)":U
            WIDTH 13.33
      tlt.ins_name FORMAT "x(50)":U WIDTH 23
      tlt.old_eng COLUMN-LABEL "�к�" FORMAT "x(20)":U WIDTH 12
      tlt.nor_effdat COLUMN-LABEL "�ѹ��������ͧ" FORMAT "99/99/9999":U
            WIDTH 9.67
      tlt.expodat COLUMN-LABEL "�ѹ����������" FORMAT "99/99/99":U
      tlt.lince1 COLUMN-LABEL "����¹ö" FORMAT "x(30)":U WIDTH 15
      tlt.nor_usr_ins COLUMN-LABEL "���ͼ���Ѻ��Ϣͧ�.��Сѹ���MRK" FORMAT "x(50)":U
            WIDTH 22.67
      tlt.comp_usr_ins FORMAT "x(50)":U WIDTH 30
      tlt.trndat COLUMN-LABEL "�ѹ����������" FORMAT "99/99/9999":U
  ENABLE
      tlt.lince1
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 129.5 BY 13.29
         BGCOLOR 15  ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_type AT ROW 5.05 COL 11.5 NO-LABEL WIDGET-ID 2
     fi_loaddat AT ROW 1.48 COL 28 COLON-ALIGNED NO-LABEL
     fi_compano AT ROW 1.48 COL 61.83 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 2.67 COL 28 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.86 COL 28 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 6.14 COL 33.67 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 6.14 COL 99
     bu_ok AT ROW 6.62 COL 117.5
     bu_exit AT ROW 8.52 COL 117.5
     br_imptxt AT ROW 11.24 COL 2.67
     fi_proname AT ROW 2.67 COL 47.33 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 8.48 COL 33.67 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 8.48 COL 66.17 COLON-ALIGNED NO-LABEL
     fi_dir_cnt AT ROW 9.62 COL 33.67 COLON-ALIGNED NO-LABEL
     fi_dri_complet AT ROW 9.62 COL 66.17 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 2.67 COL 45.17
     fi_agename AT ROW 3.86 COL 47.33 COLON-ALIGNED NO-LABEL
     bu_hpacno-2 AT ROW 3.86 COL 45.17
     fi_error AT ROW 8.48 COL 94 COLON-ALIGNED NO-LABEL
     fi_dri_fi_error AT ROW 9.62 COL 94 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 7.33 COL 33.67 COLON-ALIGNED NO-LABEL
     "�ѹ��� Load  ������  :":25 VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 1.48 COL 11.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 8.48 COL 104.5
          BGCOLOR 20 FGCOLOR 1 FONT 6
     " �������駻�Сѹ����ҷ�����  :":50 VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 8.48 COL 5.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "        �����ż��Ѻ������ҷ����� :":50 VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 9.62 COL 5.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "���� Producer  :" VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 2.67 COL 11.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 9.62 COL 46
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "DATA NEW" VIEW-AS TEXT
          SIZE 15.83 BY 1.1 AT ROW 1.48 COL 116 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 6 FONT 23
     "������к���  :":60 VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 9.62 COL 53.67
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 9.62 COL 78.33
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 8.48 COL 46
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 8.48 COL 78.33
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "������к���  :":60 VIEW-AS TEXT
          SIZE 14 BY 1.05 AT ROW 8.48 COL 53.67
          BGCOLOR 20 FGCOLOR 1 FONT 6
     "           ����ʴ������žú. :" VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 7.33 COL 5.83
          BGCOLOR 5 FGCOLOR 7 FONT 6
     "COMPANY NAME :" VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 1.48 COL 45.17
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "           ��سһ�͹����������� :" VIEW-AS TEXT
          SIZE 29 BY 1.05 AT ROW 6.14 COL 5.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "���� Agent      :" VIEW-AS TEXT
          SIZE 18 BY 1.05 AT ROW 3.86 COL 11.5
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "ERROR :":60 VIEW-AS TEXT
          SIZE 10 BY 1.05 AT ROW 8.48 COL 85.67
          BGCOLOR 20 FGCOLOR 4 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ERROR :":60 VIEW-AS TEXT
          SIZE 10 BY 1.05 AT ROW 9.62 COL 85.67
          BGCOLOR 20 FGCOLOR 4 FONT 6
     "��¡��" VIEW-AS TEXT
          SIZE 7 BY 1.05 AT ROW 9.62 COL 104.5
          BGCOLOR 20 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.1 COL 1.33
     RECT-78 AT ROW 1.29 COL 2
     RECT-79 AT ROW 6.14 COL 116.17
     RECT-80 AT ROW 8.05 COL 116.17
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
         TITLE              = "Import text file KK (����ᴧ)"
         HEIGHT             = 24
         WIDTH              = 133
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 170.67
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
IF NOT C-Win:LOAD-ICON("I:/SAFETY/WALP83/WIMAGE\safety":U) THEN
    MESSAGE "Unable to load icon: I:/SAFETY/WALP83/WIMAGE\safety"
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
/* BROWSE-TAB br_imptxt bu_exit fr_main */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agename IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dir_cnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_complet IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dri_fi_error IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_error IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_imptxt
/* Query rebuild information for BROWSE br_imptxt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _OrdList          = "brstat.tlt.comp_noti_tlt|yes"
     _FldNameList[1]   > brstat.tlt.comp_noti_tlt
"tlt.comp_noti_tlt" "�Ţ����Ѻ��� KK." ? "character" ? ? ? ? ? ? no ? no no "14.5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > brstat.tlt.nor_noti_tlt
"tlt.nor_noti_tlt" "�Ţ����ѭ��" ? "character" ? ? ? ? ? ? no ? no no "13.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > brstat.tlt.ins_name
"tlt.ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "23" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > brstat.tlt.old_eng
"tlt.old_eng" "�к�" ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > brstat.tlt.nor_effdat
"tlt.nor_effdat" "�ѹ��������ͧ" ? "date" ? ? ? ? ? ? no ? no no "9.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > brstat.tlt.expodat
"tlt.expodat" "�ѹ����������" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > brstat.tlt.lince1
"tlt.lince1" "����¹ö" "x(30)" "character" ? ? ? ? ? ? yes ? no no "15" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > brstat.tlt.nor_usr_ins
"tlt.nor_usr_ins" "���ͼ���Ѻ��Ϣͧ�.��Сѹ���MRK" ? "character" ? ? ? ? ? ? no ? no no "22.67" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > brstat.tlt.comp_usr_ins
"tlt.comp_usr_ins" ? ? "character" ? ? ? ? ? ? no ? no no "30" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > brstat.tlt.trndat
"tlt.trndat" "�ѹ����������" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _Query            is NOT OPENED
*/  /* BROWSE br_imptxt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Import text file KK (����ᴧ) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Import text file KK (����ᴧ) */
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
    DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
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
        fi_output    = IF cvdata <> "" THEN trim(SUBSTR(cvdata,1,INDEX(cvdata,".csv") - 1 )) + "_pol72.csv" ELSE "".
        DISP fi_filename fi_output WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno-2 C-Win
ON CHOOSE OF bu_hpacno-2 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                                      output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN 
        nv_daily     =  ""
        nv_reccnt    =  0 .
    FOR EACH  wdetail:
        DELETE  wdetail.
    END.
    IF rs_type = 1 THEN Run Import_notification1.
    ELSE IF rs_type = 2 THEN RUN IMPORT_cancel .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent =  INPUT  fi_agent .
    If Input  fi_agent  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001   WHERE
        xmm600.acno  =  Input fi_agent       NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
        Apply "Entry" To  fi_agent.
        Return no-apply.
    END.
    ASSIGN 
        fi_agename =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
        fi_agent   =  INPUT  fi_agent .
    Disp  fi_agent  fi_agename  WITH Frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_compano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_compano C-Win
ON LEAVE OF fi_compano IN FRAME fr_main
DO:
    fi_compano =  INPUT  fi_compano.
    Disp  fi_compano  WITH Frame  fr_main.
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


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_main
DO:
    fi_output  =  Input  fi_output .
    Disp  fi_output with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer  =  Input  fi_producer.
    If Input  fi_producer  =  ""  Then do:
        Apply "Choose"  to  bu_hpacno1.
        Return no-apply.
    END.
    FIND sicsyac.xmm600 USE-INDEX xmm60001    WHERE
        xmm600.acno  =  Input fi_producer     NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sicsyac.xmm600 THEN DO:
        Message  "Not on Name & Address Master File xmm600" View-as alert-box.
        Apply "Entry" To  fi_producer.
        Return no-apply.
    END.
    ASSIGN
        fi_proname =  TRIM(xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
        fi_producer =  INPUT  fi_producer.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    ASSIGN rs_type = INPUT rs_type.
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
    gv_prgid = "wgwimkk2".
    gv_prog  = "Import Text File to KK(��Ҥ�����õԹҤԹ) ".
    RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
    /*********************************************************************/ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    /*RECT-4:MOVE-TO-TOP().
    RECT-75:MOVE-TO-TOP().  */
    Hide Frame  fr_gen  .
    ASSIGN  
        rs_type     = 1     /*A61-0335*/
        fi_loaddat  = today
        fi_producer = "A0M1053"
        fi_compano  = "KK-NEW"
        fi_agent    = "B3M0006" .
    DISP  fi_loaddat  fi_producer fi_agent fi_compano rs_type with  frame  fr_main.
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE CREATE_output72 C-Win 
PROCEDURE CREATE_output72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* fi_output */
IF INDEX(fi_output,".csv") = 0  THEN 
    fi_output = fi_output + ".csv".

OUTPUT TO VALUE(fi_output).    /*out put file full policy */
EXPORT DELIMITER "|" 
    "�ӴѺ���                  "                                       
    "�Ң�                      "  
    "�Ţ����������.�.�.      "                          
    "�Ţ���ʵ������.�.�.    "                                 
    "�ѹ��� �Ѻ���Ф�Ҿú.     "                     
    "�Ţ����ѭ��               "                      
    "���� - ���ʡ��            "                   
    "�Ţ���ѵû�ЪҪ��١���"     
    "�Ţ����¹             "   
    "������ö               "   
    "���ö                 "     
    "�Ţ����Ѻ��          "    
    "����� (Mkt)          "                   
    "�Ţ��Ƕѧö            "    
    "�����ط��             "                     
    "�������               "                     
    "��������ѹ���         "                       
    "�ѹ�������ش          "                      
    "������� 1              "   
    "������� 2              "   
    "������� 3              "   
    "������� 4              " 
    "KK Application no      "  . /*A61-0335*/
/*FOR EACH wdetail WHERE wdetail.stk <> ""   .*/    /*A61-0335*/
FOR EACH wdetail WHERE wdetail.stk <> "" OR deci(wdetail.compprm) <> 0 . /*A61-0335*/
    ASSIGN  
    wdetail.ad21 = IF wdetail.ad21 = "" THEN "" ELSE "�Ӻ�"    + TRIM(wdetail.ad21)  /*21  �Ӻ�/�ǧ */  /*22  �����/ ࢵ          */                         
    wdetail.ad22 = IF wdetail.ad22 = "" THEN "" ELSE "�����"   + trim(wdetail.ad22)  /*22  �����/ ࢵ*/  /*23  �ѧ��Ѵ           */                           
    wdetail.ad3  = IF wdetail.ad3  = "" THEN "" ELSE "�ѧ��Ѵ" + TRIM(wdetail.ad3).  /*23  �ѧ��Ѵ   */     
    IF wdetail.post <> "" THEN ASSIGN wdetail.ad3 = TRIM(wdetail.ad3) + " " + TRIM(wdetail.post).       /*24  ������ɳ���        */  
           
    EXPORT DELIMITER "|"  
        wdetail.brno       
        wdetail.brname     
        ""  
        wdetail.stk        
        wdetail.createdat  
        wdetail.cedpol       
        trim(trim(wdetail.titlenam) + " " + trim(wdetail.name1) + " " + trim(wdetail.name2))     
        wdetail.dataidno  
        IF TRIM(wdetail.vehreg)  = "����ᴧ" THEN "" ELSE TRIM(wdetail.vehreg)  
        wdetail.brand      
        wdetail.model      
        ""
        wdetail.notifynam  
        wdetail.chassis    
        ""
        wdetail.compprm
        wdetail.compdatco  
        wdetail.expdatco 
        wdetail.ad11
        wdetail.ad21
        wdetail.ad22    
        wdetail.ad3 
        wdetail.kkapp  . /*A61-0335*/
            
END.
OUTPUT CLOSE.
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
LOOP_wdetail:
FOR EACH wdetail :
    IF wdetail.ad11 <> "" THEN wdetail.ad11  = "�Ţ��� "   + trim(wdetail.ad11) + " " .            
    IF wdetail.ad12 <> "" THEN wdetail.ad11  = wdetail.ad11 + "���� "     + trim(wdetail.ad12) + " " .
    IF wdetail.ad13 <> "" THEN wdetail.ad11  = wdetail.ad11 + "�����ҹ " + trim(wdetail.ad13) + " " .
    IF wdetail.ad14 <> "" THEN wdetail.ad11  = wdetail.ad11 + "��� "      + trim(wdetail.ad14) + " " .
    IF wdetail.ad15 <> "" THEN wdetail.ad11  = wdetail.ad11 + "��� "      + trim(wdetail.ad15) + " " .
    IF wdetail.ad21 <> "" THEN wdetail.ad21  = trim(wdetail.ad21).  
    IF wdetail.ad22 <> "" THEN wdetail.ad22  = trim(wdetail.ad22).            
    IF wdetail.ad3  <> "" THEN wdetail.ad3   = trim(wdetail.ad3).  
    IF wdetail.post <> "" THEN wdetail.post  = trim(wdetail.post).   
    IF INDEX(wdetail.cc,"2") <> 0 THEN wdetail.cc = SUBSTR(wdetail.cc,INDEX(wdetail.cc,"2"),4).
    ELSE IF INDEX(wdetail.cc,"1") <> 0 THEN wdetail.cc = SUBSTR(wdetail.cc,INDEX(wdetail.cc,"1"),4).
    ELSE  wdetail.cc = "0".
    IF trim(wdetail.chassis) <> "" THEN RUN proc_cutcha_no.
    /* ------------------------check policy  Duplicate--------------------------------------*/
    FIND FIRST tlt    WHERE 
        tlt.cha_no         = trim(wdetail.chassis) AND
        tlt.genusr         = fi_compano            NO-ERROR NO-WAIT .
    IF NOT AVAIL tlt THEN DO:    
        CREATE tlt.
        ASSIGN
            nv_completecnt     = nv_completecnt + 1 
            tlt.entdat         = TODAY
            tlt.enttim         = STRING(TIME,"HH:MM:SS")
            tlt.trntime        = STRING(TIME,"HH:MM:SS")
            tlt.trndat         = fi_loaddat
            tlt.datesent       = date(wdetail.createdat)        /*1  Create Date              */                  
            tlt.dat_ins_noti   = date(wdetail.createdat2)       /*2  �ѹ������               */                  
            tlt.nor_usr_ins    = trim(wdetail.compno)           /*3  ��ª��ͺ���ѷ��Сѹ���   */  
            tlt.nor_usr_tlt    = trim(wdetail.brno)             /*4  �����Ң� KK              */          
            tlt.comp_usr_tlt   = trim(wdetail.brname)           /*5  �Ң� KK                  */  
            tlt.nor_noti_tlt   = trim(wdetail.cedno)            /*6  �Ţ����ѭ����ҫ���      */          
            tlt.nor_noti_ins   = trim(wdetail.prevpol)          /*7  �Ţ�������������       */  
            tlt.comp_noti_tlt  = trim(wdetail.cedpol)           /*8  �Ţ����Ѻ��            */          
            tlt.lotno          = trim(wdetail.campaign)         /*9  Campaign                 */  
            tlt.lince3         = trim(wdetail.subcam)           /*10 Sub Campaign             */  
            tlt.comp_pol       = TRIM(wdetail.free)             /*11 �����������             */  
            tlt.safe2          = trim(wdetail.typeins)          /*12 �ؤ��/�ԵԺؤ��          */         
            tlt.ins_name       = trim(wdetail.titlenam) + " " + /*13 �ӹ�˹�Ҫ��ͼ����һ�Сѹ */       
                                 trim(wdetail.name1 ) + " " +   /*14 ���ͼ����һ�Сѹ         */         
                                 trim(wdetail.name2 )           /*15 ���ʡ�ż����һ�Сѹ      */    
            tlt.ins_addr1      = trim(wdetail.ad11)             /*16 ��ҹ�Ţ���+17 ������+18 �Ҥ��/�����ҹ+19 ���+20 ���*/     
            tlt.ins_addr2      = trim(wdetail.ad21)             /*21 �Ӻ�/�ǧ                */                   
            tlt.ins_addr3      = trim(wdetail.ad22)             /*22 �����/ ࢵ               */                   
            tlt.ins_addr4      = trim(wdetail.ad3 )             /*23 �ѧ��Ѵ                  */                         
            tlt.ins_addr5      = trim(wdetail.post)             /*24 ������ɳ���             */
            tlt.safe3          = wdetail.covcod                 /*25 ����������������ͧ       */   
            tlt.stat           = wdetail.garage                 /*26 ��������ë���            */                        
            tlt.nor_effdat     = date(wdetail.comdat)           /*27 �ѹ�����������ͧ         */                    
            tlt.expodat        = date(wdetail.expdat)           /*28 �ѹ����ش������ͧ       */                    
            tlt.subins         = trim(wdetail.class)            /*29 ����ö                   */                                
            tlt.filler2        = trim(wdetail.typecar)          /*30 ��������Сѹ���ö¹��    */                
            tlt.brand          = trim(wdetail.brand)            /*31 ����������ö             */                        
            tlt.model          = trim(wdetail.model)            /*32 ���ö                   */
            tlt.filler1        = trim(wdetail.typenam)          /*33 New/Used                 */                            
            tlt.lince1         = trim(wdetail.vehreg)  + " " +  /*34�Ţ����¹                */ 
                                      wdetail.veh_country       /*35 �ѧ��Ѵ����͡�Ţ����¹  */ 
            tlt.cha_no         = trim(wdetail.chassis)          /*36 �Ţ����Ƕѧ             */                         
            tlt.eng_no         = trim(wdetail.engno)            /*37 �Ţ�������ͧ¹��        */                     
            tlt.lince2         = trim(wdetail.caryear)          /*38 ��ö¹��                 */                         
            tlt.cc_weight      = deci(wdetail.cc )              /*39 �ի�                     */                         
            tlt.colorcod       = trim(wdetail.weigth)           /*40 ���˹ѡ/      �ѹ        */                     
            tlt.comp_coamt     = deci(wdetail.si)               /*41 �ع��Сѹ�� 1 /�������   */                 
            tlt.comp_grprm     = deci(wdetail.prem)             /*42 ���������������ҡû� 1 /�������*/       
            tlt.nor_coamt      = deci(wdetail.si2)              /*43 �ع��Сѹ�� 2                   */       
            tlt.nor_grprm      = deci(wdetail.prem2)            /*44 ���������������ҡû� 2         */
            tlt.gentim         = trim(wdetail.timeno)           /*45 �����Ѻ��                     */    
            tlt.comp_sck       = trim(wdetail.stk)              /*46 �Ţ����ͧ���µ�� �.�.�.        */
            tlt.comp_effdat    = date(TRIM(wdetail.compdatco))  /*47 �ѹ������ͧ(�.�.�)�������      */             
            tlt.gendat         = date(trim(wdetail.expdatco))   /*48 �ѹ������ͧ(�.�.�)����ش       */
            tlt.comp_noti_ins  = Trim(wdetail.compprm)          /*49 ���������������ҡ� (�.�.�)     */               
            tlt.comp_usr_ins   = trim(wdetail.notifynam)        /*50 �������˹�ҷ���Ѻ��          */             
            tlt.old_cha        = trim(wdetail.memmo)            /*51 �����˵� / ���������ʹ������� */             
            tlt.dri_name1      = trim(wdetail.drivnam1)         /*52 ���Ѻ����� 1                  */             
            tlt.dri_no1        = trim(wdetail.birdth1)          /*53 �ѹ�Դ���Ѻ����� 1           */             
            tlt.dri_name2      = trim(wdetail.drivnam2)         /*54 ���Ѻ����� 2                  */             
            tlt.dri_no2        = trim(wdetail.birdth2)          /*55 �ѹ�Դ���Ѻ����� 2           */             
            tlt.rec_name       = trim(wdetail.invoice)          /*56 ���� - ʡ�� (�����/㺡ӡѺ����)*/            
            tlt.rec_addr1      = trim(wdetail.addinvoice)       /*57 ������� (�����/㺡ӡѺ����)    */ 
            tlt.safe1          = trim(wdetail.emtry)                 
            tlt.OLD_eng        = trim(wdetail.datasystem)       /*59 �����Ũҡ�к�  */  
            tlt.flag           = "R"                            
            tlt.comp_sub       = trim(fi_producer)              
            tlt.recac          = trim(fi_agent)                 
            tlt.genusr         = trim(fi_compano)               
            tlt.endno          = USERID(LDBNAME(1))             /*User Load Data */
            tlt.imp            = "IM"                           /*Import Data    */
            tlt.releas         = "No"  
            tlt.expotim        = trim(wdetail.KKapp)  .             /* KK App */                 /* A61-0335 */

    END.
    ELSE DO:
        nv_completecnt  =  nv_completecnt + 1.
        RUN Create_tltup.
    END.
END.   /* FOR EACH wdetail NO-LOCK: */
RUN CREATE_output72.  /* A57-0274 */
Run Open_tlt.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tlt1 C-Win 
PROCEDURE create_tlt1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Create by A61-0335     
------------------------------------------------------------------------------*/
LOOP_wdetail:
FOR EACH wdetail :
    IF wdetail.cedpol <> ""  THEN DO:
         FIND FIRST tlt    WHERE 
              tlt.cha_no         = trim(wdetail.chassis) AND
              tlt.comp_noti_tlt  = TRIM(wdetail.cedpol)  AND
              tlt.genusr         = fi_compano            NO-ERROR NO-WAIT .
         IF AVAIL tlt THEN DO:  
             IF trim(tlt.RELEAS) = "NO"   THEN DO:
                 nv_completecnt  =  nv_completecnt + 1.
                 ASSIGN  tlt.trndat     = fi_loaddat
                         tlt.releas     = "NO/CA"
                         tlt.OLD_eng    = TRIM(wdetail.memmo) .
             END.
             ELSE IF trim(tlt.RELEAS) = "YES"   THEN DO:
                 nv_completecnt  =  nv_completecnt + 1.
                 ASSIGN  tlt.trndat     = fi_loaddat
                         tlt.releas     = "YES/CA"
                         tlt.OLD_eng    = TRIM(wdetail.memmo) .
             END.
             ELSE DO:
                  MESSAGE "���Ţ��Ƕѧ: " + wdetail.chassis  + " /�Ţ�Ѻ��: " wdetail.cedpol " ¡��ԡ��������к� TLT ���� " VIEW-AS ALERT-BOX.
             END.
         END.
         ELSE DO:
             MESSAGE "��辺 �Ţ��Ƕѧ " wdetail.chassis " /�Ţ�Ѻ��: " wdetail.cedpol " ��к� TLT " VIEW-AS ALERT-BOX.
             ASSIGN  nv_error   = nv_error + 1.
         END.
    END.
    ELSE DO:
         FIND FIRST tlt    WHERE 
              tlt.cha_no         = trim(wdetail.chassis) AND
              tlt.expotim        = trim(wdetail.KKapp)   AND
              tlt.genusr         = fi_compano            NO-ERROR NO-WAIT .
         IF AVAIL tlt THEN DO:  
             IF trim(tlt.RELEAS) = "NO"   THEN DO:
                 nv_completecnt  =  nv_completecnt + 1.
                 ASSIGN  tlt.trndat     = fi_loaddat
                         tlt.releas     = "NO/CA"
                         tlt.OLD_eng    = TRIM(wdetail.memmo) .
             END.
             ELSE IF trim(tlt.RELEAS) = "YES"   THEN DO:
                 nv_completecnt  =  nv_completecnt + 1.
                 ASSIGN  tlt.trndat     = fi_loaddat
                         tlt.releas     = "YES/CA"
                         tlt.OLD_eng    = TRIM(wdetail.memmo) .
             END.
             ELSE DO:
                  MESSAGE "���Ţ��Ƕѧ: " + wdetail.chassis  + " /�Ţ�Ѻ��: " + wdetail.cedpol + " ¡��ԡ��������к� TLT ���� " VIEW-AS ALERT-BOX.
             END.
         END.
         ELSE DO:
             MESSAGE "��辺 �Ţ��Ƕѧ " + wdetail.chassis + " /�Ţ�Ѻ��: " + wdetail.cedpol + " ��к� TLT " VIEW-AS ALERT-BOX.
             ASSIGN  nv_error   = nv_error + 1.
         END.
    END.
END. 
Run Open_tlt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE create_tltup C-Win 
PROCEDURE create_tltup :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
            tlt.entdat         = TODAY
            tlt.enttim         = STRING(TIME,"HH:MM:SS")
            tlt.trntime        = STRING(TIME,"HH:MM:SS")
            tlt.trndat         = fi_loaddat
            tlt.datesent       = date(wdetail.createdat)        /*1  Create Date              */                  
            tlt.dat_ins_noti   = date(wdetail.createdat2)       /*2  �ѹ������               */                  
            tlt.nor_usr_ins    = trim(wdetail.compno)           /*3  ��ª��ͺ���ѷ��Сѹ���   */  
            tlt.nor_usr_tlt    = trim(wdetail.brno)             /*4  �����Ң� KK              */          
            tlt.comp_usr_tlt   = trim(wdetail.brname)           /*5  �Ң� KK                  */  
            tlt.nor_noti_tlt   = trim(wdetail.cedno)            /*6  �Ţ����ѭ����ҫ���      */          
            tlt.nor_noti_ins   = trim(wdetail.prevpol)          /*7  �Ţ�������������       */  
            tlt.comp_noti_tlt  = trim(wdetail.cedpol)           /*8  �Ţ����Ѻ��            */          
            tlt.lotno          = trim(wdetail.campaign)         /*9  Campaign                 */  
            tlt.lince3         = trim(wdetail.subcam)           /*10 Sub Campaign             */  
            tlt.comp_pol       = TRIM(wdetail.free)             /*11 �����������             */  
            tlt.safe2          = trim(wdetail.typeins)          /*12 �ؤ��/�ԵԺؤ��          */         
            tlt.ins_name       = trim(wdetail.titlenam) + " " + /*13 �ӹ�˹�Ҫ��ͼ����һ�Сѹ */       
                                 trim(wdetail.name1 ) + " " +   /*14 ���ͼ����һ�Сѹ         */         
                                 trim(wdetail.name2 )           /*15 ���ʡ�ż����һ�Сѹ      */    
            tlt.ins_addr1      = trim(wdetail.ad11)             /*16 ��ҹ�Ţ���+17 ������+18 �Ҥ��/�����ҹ+19 ���+20 ���*/     
            tlt.ins_addr2      = trim(wdetail.ad21)             /*21 �Ӻ�/�ǧ                */                   
            tlt.ins_addr3      = trim(wdetail.ad22)             /*22 �����/ ࢵ               */                   
            tlt.ins_addr4      = trim(wdetail.ad3 )             /*23 �ѧ��Ѵ                  */                         
            tlt.ins_addr5      = trim(wdetail.post)             /*24 ������ɳ���             */
            tlt.safe3          = wdetail.covcod                 /*25 ����������������ͧ       */   
            tlt.stat           = wdetail.garage                 /*26 ��������ë���            */                        
            tlt.nor_effdat     = date(wdetail.comdat)           /*27 �ѹ�����������ͧ         */                    
            tlt.expodat        = date(wdetail.expdat)           /*28 �ѹ����ش������ͧ       */                    
            tlt.subins         = trim(wdetail.class)            /*29 ����ö                   */                                
            tlt.filler2        = trim(wdetail.typecar)          /*30 ��������Сѹ���ö¹��    */                
            tlt.brand          = trim(wdetail.brand)            /*31 ����������ö             */                        
            tlt.model          = trim(wdetail.model)            /*32 ���ö                   */
            tlt.filler1        = trim(wdetail.typenam)          /*33 New/Used                 */                            
            tlt.lince1         = trim(wdetail.vehreg)  + " " +  /*34�Ţ����¹                */ 
                                      wdetail.veh_country       /*35 �ѧ��Ѵ����͡�Ţ����¹  */ 
            tlt.cha_no         = trim(wdetail.chassis)          /*36 �Ţ����Ƕѧ             */                         
            tlt.eng_no         = trim(wdetail.engno)            /*37 �Ţ�������ͧ¹��        */                     
            tlt.lince2         = trim(wdetail.caryear)          /*38 ��ö¹��                 */                         
            tlt.cc_weight      = deci(wdetail.cc )              /*39 �ի�                     */                         
            tlt.colorcod       = trim(wdetail.weigth)           /*40 ���˹ѡ/      �ѹ        */                     
            tlt.comp_coamt     = deci(wdetail.si)               /*41 �ع��Сѹ�� 1 /�������   */                 
            tlt.comp_grprm     = deci(wdetail.prem)             /*42 ���������������ҡû� 1 /�������*/       
            tlt.nor_coamt      = deci(wdetail.si2)              /*43 �ع��Сѹ�� 2                   */       
            tlt.nor_grprm      = deci(wdetail.prem2)            /*44 ���������������ҡû� 2         */
            tlt.gentim         = trim(wdetail.timeno)           /*45 �����Ѻ��                     */    
            tlt.comp_sck       = trim(wdetail.stk)              /*46 �Ţ����ͧ���µ�� �.�.�.        */
            tlt.comp_effdat    = date(TRIM(wdetail.compdatco))  /*47 �ѹ������ͧ(�.�.�)�������      */             
            tlt.gendat         = date(trim(wdetail.expdatco))   /*48 �ѹ������ͧ(�.�.�)����ش       */
            tlt.comp_noti_ins  = Trim(wdetail.compprm)          /*49 ���������������ҡ� (�.�.�)     */               
            tlt.comp_usr_ins   = trim(wdetail.notifynam)        /*50 �������˹�ҷ���Ѻ��          */             
            tlt.old_cha        = trim(wdetail.memmo)            /*51 �����˵� / ���������ʹ������� */             
            tlt.dri_name1      = trim(wdetail.drivnam1)         /*52 ���Ѻ����� 1                  */             
            tlt.dri_no1        = trim(wdetail.birdth1)          /*53 �ѹ�Դ���Ѻ����� 1           */             
            tlt.dri_name2      = trim(wdetail.drivnam2)         /*54 ���Ѻ����� 2                  */             
            tlt.dri_no2        = trim(wdetail.birdth2)          /*55 �ѹ�Դ���Ѻ����� 2           */             
            tlt.rec_name       = trim(wdetail.invoice)          /*56 ���� - ʡ�� (�����/㺡ӡѺ����)*/            
            tlt.rec_addr1      = trim(wdetail.addinvoice)       /*57 ������� (�����/㺡ӡѺ����)    */ 
            tlt.safe1          = trim(wdetail.emtry)                 
            tlt.OLD_eng        = trim(wdetail.datasystem)       /*59 �����Ũҡ�к�  */  
            tlt.flag           = "R"                            
            tlt.comp_sub       = trim(fi_producer)              
            tlt.recac          = trim(fi_agent)                 
            tlt.genusr         = trim(fi_compano)               
            tlt.endno          = USERID(LDBNAME(1))             /*User Load Data */
            tlt.imp            = "IM"                           /*Import Data    */
            tlt.releas         = "No"  
            tlt.expotim        = trim(wdetail.KKapp)  .             /* KK App */                 /* A61-0335 */

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
  DISPLAY rs_type fi_loaddat fi_compano fi_producer fi_agent fi_filename 
          fi_proname fi_impcnt fi_completecnt fi_dir_cnt fi_dri_complet 
          fi_agename fi_error fi_dri_fi_error fi_output 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_type fi_loaddat fi_compano fi_producer fi_agent fi_filename bu_file 
         bu_ok bu_exit br_imptxt bu_hpacno1 bu_hpacno-2 fi_output RECT-1 
         RECT-78 RECT-79 RECT-80 
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
  Notes: Create by A61-0335      
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.createdat    /*1   Create Date   */                               
        wdetail.createdat2   /*2   �ѹ������    */                               
        wdetail.compno       /*3   ��ª��ͺ���ѷ��Сѹ���*/                       
        wdetail.brno         /*4   �����Ң� KK           */                       
        wdetail.brname       /*5   �Ң� KK               */                       
        wdetail.cedno        /*6   �Ţ����ѭ����ҫ���   */                       
        wdetail.prevpol      /*7   �Ţ�������������    */                       
        wdetail.cedpol       /*8 �Ţ����Ѻ��           */                       
        wdetail.campaign     /*9   Campaign              */                       
        wdetail.subcam       /*10  Sub Campaign          */                       
        wdetail.free         /*11  �����������          */                       
        wdetail.typeins      /*12  �ؤ��/�ԵԺؤ��       */                       
        wdetail.titlenam     /*13  �ӹ�˹�Ҫ��ͼ����һ�Сѹ*/                     
        wdetail.name1        /*14  ���ͼ����һ�Сѹ    */                         
        wdetail.name2        /*15  ���ʡ�ż����һ�Сѹ */                         
        wdetail.ad11         /*16  ��ҹ�Ţ���          */                         
        wdetail.ad12         /*17  ������             */                         
        wdetail.ad13         /*18  �Ҥ��/  �����ҹ    */                         
        wdetail.ad14         /*19  ���                 */                         
        wdetail.ad15         /*20  ���                 */                         
        wdetail.ad21         /*21  �Ӻ�/�ǧ           */                         
        wdetail.ad22         /*22  �����/ ࢵ          */                         
        wdetail.ad3          /*23  �ѧ��Ѵ           */                           
        wdetail.post         /*24  ������ɳ���        */                         
        wdetail.covcod       /*25  ����������������ͧ  */                         
        wdetail.garage       /*26  ��������ë���       */                         
        wdetail.comdat       /*27  �ѹ��������ͧ�������*/                       
        wdetail.expdat       /*28  �ѹ��������ͧ����ش */                       
        wdetail.class        /*29  ����ö                */                       
        wdetail.typecar      /*30  ��������Сѹ���ö¹�� */                       
        wdetail.brand        /*31  ����������ö          */                       
        wdetail.model        /*32  ���ö                */                       
        wdetail.typenam      /*33  New/      Used        */                       
        wdetail.vehreg       /*34  �Ţ����¹            */                       
        wdetail.veh_country  /*35  �ѧ��Ѵ����͡�Ţ����¹*/                      
        wdetail.chassis      /*36  �Ţ����Ƕѧ          */                       
        wdetail.engno        /*37  �Ţ�������ͧ¹��     */                       
        wdetail.caryear      /*38  ��ö¹��              */                       
        wdetail.cc           /*39  �ի�                  */                       
        wdetail.weigth       /*40  ���˹ѡ/      �ѹ     */                       
        wdetail.si           /*41  �ع��Сѹ�� 1 /�������*/                       
        wdetail.prem         /*42  ���������������ҡû� 1 /�������*/             
        wdetail.si2          /*43  �ع��Сѹ�� 2                   */             
        wdetail.prem2        /*44  ���������������ҡû� 2         */             
        wdetail.timeno       /*45  �����Ѻ��                 */                 
        wdetail.stk          /*46  �Ţ����ͧ���µ�� �.�.�.        */             
        wdetail.compdatco     /*47  �ѹ������ͧ(�.�.�)�������      */             
        wdetail.expdatco     /*48  �ѹ������ͧ(�.�.�)����ش       */             
        wdetail.compprm      /*49  ���������������ҡ� (�.�.�)   */               
        wdetail.notifynam    /*50  �������˹�ҷ���Ѻ��          */             
        wdetail.memmo        /*51  �����˵� / ���������ʹ������� */             
        wdetail.drivnam1     /*52  ���Ѻ����� 1                  */             
        wdetail.birdth1      /*53  �ѹ�Դ���Ѻ����� 1           */             
        wdetail.drivnam2     /*54  ���Ѻ����� 2                  */             
        wdetail.birdth2      /*55  �ѹ�Դ���Ѻ����� 2           */             
        wdetail.invoice      /*56  ���� - ʡ�� (�����/㺡ӡѺ����)*/            
        wdetail.addinvoice   /*57  ������� (�����/㺡ӡѺ����)    */            
        wdetail.emtry
        wdetail.datasystem    /*58 �����Ũҡ�к�  */  
        wdetail.data_blank    /*a57-0274*/
        wdetail.dataidno     /*a57-0274*/
        wdetail.kkapp    .   /*A61-0335*/ /*KK App */
END. 
ASSIGN  nv_error   = 0   
        nv_completecnt = 0 . 
FOR EACH wdetail.
    IF index(wdetail.chassis,"��Ƕѧ") <> 0  THEN DELETE wdetail.   /*A61-0335*/
    ELSE IF wdetail.chassis  = "" THEN DO:
        /*Message "���Ţ��Ƕѧ�繤����ҧ : " wdetail.cedpol  View-as alert-box. */
        DELETE wdetail.    
    END.
END.

Run  Create_tlt1.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error 
    nv_completecnt  =  0
    fi_impcnt       =  nv_reccnt .

Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

MESSAGE "Update Data Cancel Complete" VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Import_notification1 C-Win 
PROCEDURE Import_notification1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH  wdetail :
    DELETE  wdetail.
END.
INPUT FROM VALUE(fi_FileName).
REPEAT:
    CREATE wdetail.
    IMPORT DELIMITER "|" 
        wdetail.createdat    /*1   Create Date   */                               
        wdetail.createdat2   /*2   �ѹ������    */                               
        wdetail.compno       /*3   ��ª��ͺ���ѷ��Сѹ���*/                       
        wdetail.brno         /*4   �����Ң� KK           */                       
        wdetail.brname       /*5   �Ң� KK               */                       
        wdetail.cedno        /*6   �Ţ����ѭ����ҫ���   */                       
        wdetail.prevpol      /*7   �Ţ�������������    */                       
        wdetail.cedpol       /*8 �Ţ����Ѻ��           */                       
        wdetail.campaign     /*9   Campaign              */                       
        wdetail.subcam       /*10  Sub Campaign          */                       
        wdetail.free         /*11  �����������          */                       
        wdetail.typeins      /*12  �ؤ��/�ԵԺؤ��       */                       
        wdetail.titlenam     /*13  �ӹ�˹�Ҫ��ͼ����һ�Сѹ*/                     
        wdetail.name1        /*14  ���ͼ����һ�Сѹ    */                         
        wdetail.name2        /*15  ���ʡ�ż����һ�Сѹ */                         
        wdetail.ad11         /*16  ��ҹ�Ţ���          */                         
        wdetail.ad12         /*17  ������             */                         
        wdetail.ad13         /*18  �Ҥ��/  �����ҹ    */                         
        wdetail.ad14         /*19  ���                 */                         
        wdetail.ad15         /*20  ���                 */                         
        wdetail.ad21         /*21  �Ӻ�/�ǧ           */                         
        wdetail.ad22         /*22  �����/ ࢵ          */                         
        wdetail.ad3          /*23  �ѧ��Ѵ           */                           
        wdetail.post         /*24  ������ɳ���        */                         
        wdetail.covcod       /*25  ����������������ͧ  */                         
        wdetail.garage       /*26  ��������ë���       */                         
        wdetail.comdat       /*27  �ѹ��������ͧ�������*/                       
        wdetail.expdat       /*28  �ѹ��������ͧ����ش */                       
        wdetail.class        /*29  ����ö                */                       
        wdetail.typecar      /*30  ��������Сѹ���ö¹�� */                       
        wdetail.brand        /*31  ����������ö          */                       
        wdetail.model        /*32  ���ö                */                       
        wdetail.typenam      /*33  New/      Used        */                       
        wdetail.vehreg       /*34  �Ţ����¹            */                       
        wdetail.veh_country  /*35  �ѧ��Ѵ����͡�Ţ����¹*/                      
        wdetail.chassis      /*36  �Ţ����Ƕѧ          */                       
        wdetail.engno        /*37  �Ţ�������ͧ¹��     */                       
        wdetail.caryear      /*38  ��ö¹��              */                       
        wdetail.cc           /*39  �ի�                  */                       
        wdetail.weigth       /*40  ���˹ѡ/      �ѹ     */                       
        wdetail.si           /*41  �ع��Сѹ�� 1 /�������*/                       
        wdetail.prem         /*42  ���������������ҡû� 1 /�������*/             
        wdetail.si2          /*43  �ع��Сѹ�� 2                   */             
        wdetail.prem2        /*44  ���������������ҡû� 2         */             
        wdetail.timeno       /*45  �����Ѻ��                 */                 
        wdetail.stk          /*46  �Ţ����ͧ���µ�� �.�.�.        */             
        wdetail.compdatco     /*47  �ѹ������ͧ(�.�.�)�������      */             
        wdetail.expdatco     /*48  �ѹ������ͧ(�.�.�)����ش       */             
        wdetail.compprm      /*49  ���������������ҡ� (�.�.�)   */               
        wdetail.notifynam    /*50  �������˹�ҷ���Ѻ��          */             
        wdetail.memmo        /*51  �����˵� / ���������ʹ������� */             
        wdetail.drivnam1     /*52  ���Ѻ����� 1                  */             
        wdetail.birdth1      /*53  �ѹ�Դ���Ѻ����� 1           */             
        wdetail.drivnam2     /*54  ���Ѻ����� 2                  */             
        wdetail.birdth2      /*55  �ѹ�Դ���Ѻ����� 2           */             
        wdetail.invoice      /*56  ���� - ʡ�� (�����/㺡ӡѺ����)*/            
        wdetail.addinvoice   /*57  ������� (�����/㺡ӡѺ����)    */            
        wdetail.emtry
        wdetail.datasystem    /*58 �����Ũҡ�к�  */  
        wdetail.data_blank    /*a57-0274*/
        wdetail.dataidno     /*a57-0274*/
        wdetail.kkapp    .   /*A61-0335*/ /*KK App */
END. 
ASSIGN  nv_error   = 0   
        nv_completecnt = 0 . 
FOR EACH wdetail.
    ASSIGN nv_error = nv_error + 1 .
    IF index(wdetail.chassis,"��Ƕѧ") <> 0 THEN DELETE wdetail. /*A61-0335*/
    ELSE IF wdetail.chassis  = "" THEN DO:
        /*Message "���Ţ��Ƕѧ�繤����ҧ : " wdetail.cedpol  View-as alert-box. */
        DELETE wdetail. 
    END.
END.

Run  Create_tlt.

If  nv_completecnt  <>  0  Then do:
    Enable br_imptxt       With frame fr_main.
END.
ASSIGN 
    nv_error        =  nv_error - 1
    fi_completecnt  =  nv_completecnt 
    fi_error        =  nv_error - nv_completecnt   
    nv_completecnt  =  0
    fi_impcnt       =  nv_reccnt .

Disp fi_completecnt   fi_impcnt  fi_error  with frame  fr_main.

Run Open_tlt.

Message "Load  Data Complete "  View-as alert-box.  

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
Open Query br_imptxt  For each tlt  Use-index tlt01  where
           tlt.trndat     =  fi_loaddat   and
           tlt.comp_sub   =  fi_producer  and
           tlt.genusr     =  fi_compano   .
         

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutcha_no C-Win 
PROCEDURE proc_cutcha_no :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_chassis AS CHAR FORMAT "x(40)" INIT "".
DEF VAR nv_i             AS INTE INIT 0.
DEF VAR nv_l             AS INTE INIT 0.
DEF VAR ind              AS INTE INIT 0.

ASSIGN 
    nv_chassis = trim(wdetail.chassis)  
    nv_i = 0 
    ind  = 0
    nv_l = LENGTH(nv_chassis).
DO WHILE nv_i <= nv_l:
    ind = 0.
    ind = INDEX(nv_chassis,"/").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis,"\").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis,"-").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis,".").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    ind = INDEX(nv_chassis," ").
    IF ind <> 0 THEN DO:
        nv_chassis = TRIM (SUBSTRING(nv_chassis,1,ind - 1) + SUBSTRING(nv_chassis,ind + 1, nv_l)).
    END.
    nv_i = nv_i + 1.
END.
ASSIGN 
    wdetail.chassis = nv_chassis.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

