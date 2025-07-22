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
/*Local Variable Definitions ---                                            */   
/*Program name     : Match Text file KK to excel file                       */  
/*create by        : Ranu I. A61-0335  10/07/2018                           */  
/*                   Match file �駧ҹ �ú. ����Ѻ�觡�Ѻ KK �����excel */  
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */ 
/*Modify by        : Kridtiya i. A63-0472 ��� ��ä����Ţ����ѭ�� ���� kkapp*/

DEF  stream  ns1.
DEFINE VAR   nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_reccnt       AS  INT  INIT  0.
DEFINE VAR   nv_completecnt  AS   INT   INIT  0.
DEFINE VAR   nv_enttim       AS  CHAR          INIT  "".
def    var   nv_export       as  date  init  ""  format "99/99/9999".
def  stream  ns2.
DEFINE VAR   nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*--------------------------����Ѻ�����š�������  -------------------------*/
DEFINE NEW SHARED WORKFILE wdetail2 NO-UNDO   /* Renew */
    FIELD id               AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD br_nam           AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD number           AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD polstk           AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD idbranch         AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD branchname       AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD recivedat        AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD cedpol           AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD insurnam         AS CHAR FORMAT "x(60)"  INIT "" 
    FIELD idno             AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD vehreg           AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD brand            AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD model            AS CHAR FORMAT "x(50)"  INIT "" 
    FIELD notifyno         AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD namnotify        AS CHAR FORMAT "x(50)"  INIT "" 
    FIELD chassis          AS CHAR FORMAT "x(30)"  INIT "" 
    FIELD comp             AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD premt            AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD comdat           AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD expdat           AS CHAR FORMAT "x(20)"  INIT "" 
    /*FIELD memmo            AS CHAR FORMAT "x(40)"  INIT ""*/ /*A57-0434*/
    FIELD memmo            AS CHAR FORMAT "x(200)"  INIT ""    /*A57-0434*/
    FIELD adr_no1          AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ��ҹ�Ţ���*/     
    FIELD adr_mu           AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ����     */         
    FIELD adr_muban        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �����ҹ */     
    FIELD adr_build        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �Ҥ��    */         
    FIELD adr_soy          AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ���      */             
    FIELD adr_road         AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ���      */             
    FIELD adr_tambon       AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �Ӻ�/�ǧ*/     
    FIELD adr_amper        AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �����/ࢵ*/     
    FIELD adr_country      AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 �ѧ��Ѵ  */         
    FIELD adr_post         AS CHAR FORMAT "x(50)" INIT ""  /* add A56-0309 ������ɳ���*/ 
    FIELD ad11             AS CHAR FORMAT "x(150)" INIT "" 
    FIELD ad12             AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD ad13             AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD ad14             AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD veh_country      AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD branch           AS CHAR FORMAT "x(3)"   INIT "" 
    FIELD class            AS CHAR FORMAT "x(4)"   INIT "" 
    FIELD companame        AS CHAR FORMAT "x(50)"  INIT "" 
    FIELD titlenam         AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD sername          AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD telephone        AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD birdthday        AS CHAR FORMAT "x(10)"  INIT "" 
    FIELD occoup           AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD nstatus          AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD idvatno          AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD titlenam01       AS CHAR FORMAT "x(20)"  INIT "" 
    FIELD name01           AS CHAR FORMAT "x(35)"  INIT "" 
    FIELD sernam01         AS CHAR FORMAT "x(40)"  INIT "" 
    FIELD idnonam01        AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD titlenam02       AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD name02           AS CHAR FORMAT "x(35)"  INIT ""  
    FIELD sernam02         AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD idnonam02        AS CHAR FORMAT "x(15)"  INIT "" 
    FIELD titlenam03       AS CHAR FORMAT "x(20)"  INIT ""  
    FIELD name03           AS CHAR FORMAT "x(35)"  INIT ""  
    FIELD sernam03         AS CHAR FORMAT "x(40)"  INIT ""  
    FIELD idnonam03        AS CHAR FORMAT "x(15)"  INIT "" 
    field nsend            as char format "x(50)" init ""  /*A61-0335*/
    field sendname         as char format "x(50)" init ""  /*A61-0335*/
    field kkapp            as char format "x(30)" init ""  /*A61-0335*/
    FIELD stk              AS CHAR FORMAT "x(15)"  INIT "" .   /*A60-0232*/


DEFINE NEW SHARED WORKFILE wdetail NO-UNDO /* new */
    FIELD createdat    AS CHAR FORMAT "X(10)"  INIT ""  /*1   Create Date               */                                    
    FIELD createdat2   AS CHAR FORMAT "X(10)"  INIT ""  /*2   �ѹ������                */                                    
    FIELD compno       AS CHAR FORMAT "X(50)"  INIT ""  /*3   ��ª��ͺ���ѷ��Сѹ���    */                            
    FIELD brno         AS CHAR FORMAT "X(10)"  INIT ""  /*4   �����Ң� KK               */                            
    FIELD brname       AS CHAR FORMAT "X(30)"  INIT ""  /*5   �Ң� KK                   */                            
    FIELD cedno        AS CHAR FORMAT "X(25)"  INIT ""  /*6   �Ţ����ѭ����ҫ���       */                            
    FIELD prevpol      AS CHAR FORMAT "X(25)"  INIT ""  /*7   �Ţ�������������        */                            
    FIELD cedpol       AS CHAR FORMAT "X(30)"  INIT ""  /*8   �Ţ����Ѻ��             */                            
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
    FIELD kkapp        AS CHAR FORMAT "x(30)"  INIT ""   /*A61-0335*/
    FIELD policy       AS CHAR FORMAT "x(15)"  INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_type fi_filename fi_outfile bu_ok bu_exit ~
bu_file RECT-76 RECT-77 RECT-656 
&Scoped-Define DISPLAYED-OBJECTS rs_type fi_filename fi_outfile 

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
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "New", 1,
"Renew", 2
     SIZE 51 BY 1
     BGCOLOR 10 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-656
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 61 BY 1.19
     BGCOLOR 10 .

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 7.62
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_type AT ROW 2.76 COL 24.17 NO-LABEL WIDGET-ID 4
     fi_filename AT ROW 4.05 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 5.33 COL 12.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.95 COL 61.83
     bu_exit AT ROW 6.95 COL 71.5
     bu_file AT ROW 4.05 COL 100.83
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 4.05 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 5.33 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "  Match Text File (�ú.) Send KK" VIEW-AS TEXT
          SIZE 77 BY 1.19 AT ROW 1.29 COL 2.5
          BGCOLOR 18 FGCOLOR 2 FONT 2
     "������駧ҹ�ͧ KK  Match Policy no." VIEW-AS TEXT
          SIZE 33 BY 1.05 AT ROW 6.67 COL 15 WIDGET-ID 2
          BGCOLOR 19 FGCOLOR 12 FONT 1
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 6.71 COL 60.5
     RECT-656 AT ROW 2.67 COL 15 WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 106 BY 7.91
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
         TITLE              = "Match Policy Send To KK"
         HEIGHT             = 7.95
         WIDTH              = 105.83
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 114.33
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 114.33
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
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match Policy Send To KK */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Policy Send To KK */
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
    DEF VAR NO_add AS CHAR FORMAT "x(20)" .
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
        ASSIGN 
         no_add =    STRING(MONTH(TODAY),"99")    + 
                     STRING(DAY(TODAY),"99")      + 
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
        IF rs_type = 1 THEN ASSIGN fi_outfile  = SUBSTRING(cvData,1,R-INDEX(fi_filename,"\")) + "FileSend_KK72New_" + no_add + ".slk".
        ELSE ASSIGN fi_outfile  = SUBSTRING(cvData,1,R-INDEX(fi_filename,"\")) + "FileSend_KK72ReNew_" + no_add + ".slk".
        DISP fi_filename fi_outfile WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "Please import file match ! " VIEW-AS ALERT-BOX.
        RETURN NO-APPLY.
        APPLY "entry" TO fi_filename.
    END.
    
    IF rs_type = 1 THEN DO:
        RUN  pro_matfilenew.
        RUN  Pro_matchfile_prem.
        Run  Pro_createfilenew.
    END.
    ELSE DO:
        RUN  pro_matfilerenew.
        RUN  Pro_matchfile_prem.
        Run  Pro_createfile.
    END.
    Message "Export data Complete"  View-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename  =  Input  fi_filename.
    Disp  fi_filename  with frame  fr_main.
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


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type.
    DISP rs_type WITH FRAME fr_main.
  
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
  
      gv_prgid = "WGWMATK2.W".
  gv_prog  = "Match Policy 72 send to KK ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  ASSIGN rs_type = 1.
  DISP rs_type WITH FRAME fr_main.

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN ra_report =  1.*/
  /*DISP ra_report WITH FRAM fr_main.*/

  
  
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
  DISPLAY rs_type fi_filename fi_outfile 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE rs_type fi_filename fi_outfile bu_ok bu_exit bu_file RECT-76 RECT-77 
         RECT-656 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
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
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
DEF VAR   n_name   AS CHAR FORMAT "x(100)" INIT "" .


If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ��Ҥ�����õԹҤԹ �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ���       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "����ѷ��Сѹ   "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�Ţ���������� "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "�����Ң�       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ң� KK        "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "�Ţ����ѭ��    "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "�ӹ�˹�Ҫ���   "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "���ͼ����һ�Сѹ"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "���ʡ�ż����һ�Сѹ"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "�Ţ����Ѻ��  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "�ѹ����͡�Ţ����Ѻ��"     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "�Ţ����¹     "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "������ö       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "�Ţ���ö       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "���˹�ҷ�� MKT"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "���˹�ҷ�����"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "����������������ͧ "        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "��������ë���  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�ع��Сѹ      "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "���������������ҡ�"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�ѹ������� �ú"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�ѹ����ش �ú "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "���ͼ���Ѻ "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "��ҹ�Ţ��� "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "����       "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "�����ҹ   "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "�Ҥ��      "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "���        "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "���        "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "�Ӻ�/�ǧ  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "�����/ࢵ  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "�ѧ��Ѵ    "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "������ɳ���  "             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "�����˵�   "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "����Դ���"                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�Ѵ���͡��÷���Ң�"        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "���ͼ���Ѻ�͡���   "        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "KK ApplicationNo.  "        '"' SKIP. 

    FOR EACH wdetail2 WHERE wdetail2.chassis <> "" no-lock.
        ASSIGN 
            n_name = ""
            n_name   = trim(wdetail2.titlenam) + " " + trim(wdetail2.insurnam) + " " + trim(wdetail2.sername)
            n_record =  n_record + 1
            nv_cnt   =  nv_cnt  + 1 
            nv_row   =  nv_row  + 1.
    
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record             '"' SKIP.
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail2.companame   '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail2.polstk      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail2.idbranch    '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail2.branchname  '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail2.cedpol      '"' SKIP. 
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail2.titlenam    '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail2.insurnam    '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail2.sername     '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail2.notifyno    '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  ""                   '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail2.vehreg      '"' SKIP.               
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail2.brand       '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail2.chassis     '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail2.namnotify   '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  ""                   '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  "�ú."               '"' SKIP.          
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  ""                   '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  "0"                  '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail2.premt       '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail2.comdat      '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail2.expdat      '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  n_name               '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail2.adr_no1     '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail2.adr_mu      '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail2.adr_muban   '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail2.adr_build   '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail2.adr_soy     '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail2.adr_road    '"' SKIP.    
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail2.adr_tambon  '"' SKIP.    
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail2.adr_amper   '"' SKIP.    
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail2.adr_country '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail2.adr_post    '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail2.memmo       '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail2.telephone   '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail2.nsend       '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail2.sendname    '"' SKIP.         
        PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail2.kkapp       '"' SKIP.         
        
    END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfilenew C-Win 
PROCEDURE pro_createfilenew :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
DEF VAR   n_licen  AS CHAR FORMAT "x(50)" INIT "" .
DEF VAR   n_name   AS CHAR FORMAT "x(100)" INIT "" .
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ��Ҥ�����õԹҤԹ �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ���       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "����ѷ��Сѹ   "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�Ţ���������� "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "�����Ң�       "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ң� KK        "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "�Ţ����ѭ��    "            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "�ӹ�˹�Ҫ���   "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "���ͼ����һ�Сѹ"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "���ʡ�ż����һ�Сѹ"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "�Ţ����Ѻ��  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "�ѹ����͡�Ţ����Ѻ��"     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "�Ţ����¹     "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "������ö       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "�Ţ���ö       "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "���˹�ҷ�� MKT"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "���˹�ҷ�����"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "����������������ͧ "        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "��������ë���  "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�ع��Сѹ      "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "���������������ҡ�"        '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�ѹ������� �ú"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�ѹ����ش �ú "            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "���ͼ���Ѻ "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "��ҹ�Ţ��� "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "����       "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "�����ҹ   "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "�Ҥ��      "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "���        "                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "���        "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "�Ӻ�/�ǧ  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "�����/ࢵ  "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "�ѧ��Ѵ    "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "������ɳ���  "             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "�����˵�   "                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "����Դ���"                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�Ѵ���͡��÷���Ң�"        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "���ͼ���Ѻ�͡���   "        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "KK ApplicationNo.  "        '"' SKIP. 

FOR EACH wdetail WHERE wdetail.compprm <> "" AND deci(wdetail.compprm) <> 0 no-lock.
    ASSIGN 
        n_licen  = ""   n_name = ""
        n_licen  = trim(wdetail.vehreg) + " " + trim(wdetail.veh_country) 
        n_name   = trim(wdetail.titlenam) + " " + trim(wdetail.name1) + " " + trim(wdetail.name2)
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
                                                                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'    n_record            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'    wdetail.compno      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'    wdetail.policy      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'    wdetail.brno        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'    wdetail.brname      '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'    wdetail.cedno       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'    wdetail.titlenam    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'    wdetail.name1       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'    wdetail.name2       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'   wdetail.cedpol      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'   wdetail.createdat   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'   n_licen             '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'   wdetail.brand       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'   wdetail.chassis     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'   wdetail.notifynam   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'   ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'   "�ú"               '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'   ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'   "0"                 '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'   wdetail.compprm     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'   wdetail.compdatco   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'   wdetail.expdatco    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'   n_name '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'   wdetail.ad11        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'   wdetail.ad12        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'   IF index(wdetail.ad13,"�����ҹ") <> 0 THEN TRIM(wdetail.ad13) ELSE "" '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'   IF index(wdetail.ad13,"�Ҥ��") <> 0 THEN TRIM(wdetail.ad13) ELSE ""    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'   wdetail.ad14        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'   wdetail.ad15        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'   wdetail.ad21        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'   wdetail.ad22        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'   wdetail.ad3         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'   wdetail.post        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'   wdetail.memmo       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'   ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'   ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'   ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'   wdetail.kkapp       '"' SKIP.         
    
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem C-Win 
PROCEDURE Pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF rs_type = 2 THEN DO: /*re New */
    FOR EACH wdetail2 .
        IF wdetail2.cedpol <> "" THEN DO:
            /* A59-0590 : �ҡ������� 72 */
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                /*sicuw.uwm100.cedpol = trim(wdetail2.cedpol) AND */ /*A63-00472 */
                sicuw.uwm100.cedpol = trim(wdetail2.kkapp) AND        /*A63-00472 */
                sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail2.comdat) THEN DO: 
                    ASSIGN  wdetail2.polstk = sicuw.uwm100.policy .
                END.
            END.
            ELSE DO: 
                 FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                     sicuw.uwm100.cedpol = trim(wdetail2.cedpol) AND     /*A63-00472 */ 
                    /*sicuw.uwm100.cedpol = trim(wdetail2.kkapp) AND */   /*A63-00472 */
                    sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        IF sicuw.uwm100.expdat >  date(wdetail2.comdat) THEN DO: 
                            ASSIGN  wdetail2.polstk = sicuw.uwm100.policy .
                        END.
                    END.
                    ELSE ASSIGN wdetail2.polstk = "".
            END.
            /* End A59-0590*/
        END.
        ELSE DO: 
             FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail2.kkapp) AND 
                sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL sicuw.uwm100 THEN DO:
                 IF sicuw.uwm100.expdat >  date(wdetail2.comdat) THEN DO: 
                     ASSIGN  wdetail2.polstk = sicuw.uwm100.policy .
                 END.
             END.
             ELSE ASSIGN wdetail2.polstk = "".
        END.
    
    END.      /* wdetail2*/

END.
ELSE DO:    /* new */
    FOR EACH wdetail WHERE wdetail.compprm <> "" AND DECI(wdetail.compprm) <> 0 .
        IF wdetail.cedpol <> "" THEN DO:
            /* A59-0590 : �ҡ������� 72 */
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                /*sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND */  /*A63-00472 */ 
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND        /*A63-00472 */ 
                sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail.compdatco) THEN DO: 
                    ASSIGN  wdetail.policy = sicuw.uwm100.policy .
                END.
            END.
            ELSE DO: 
                 FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    /*sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND */   /*A63-00472 */ 
                    sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND       /*A63-00472 */ 
                    sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sicuw.uwm100 THEN DO:
                        IF sicuw.uwm100.expdat >  date(wdetail.compdatco) THEN DO: 
                            ASSIGN  wdetail.policy = sicuw.uwm100.policy .
                        END.
                    END.
                    ELSE ASSIGN wdetail.policy = "".
            END.
            /* End A59-0590*/
        END.
        ELSE DO: 
             FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL sicuw.uwm100 THEN DO:
                 IF sicuw.uwm100.expdat >  date(wdetail.compdatco) THEN DO: 
                     ASSIGN  wdetail.policy = sicuw.uwm100.policy .
                 END.
             END.
             ELSE ASSIGN wdetail.policy = "".
        END.
    
    END.      /* wdetail*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matfilenew C-Win 
PROCEDURE pro_matfilenew :
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

        IF index(wdetail.createdat,"Create") <> 0  THEN DELETE wdetail.
        ELSE IF wdetail.createdat = ""  THEN DELETE wdetail.
        ELSE IF deci(wdetail.compprm) = 0  THEN DELETE wdetail.
        
    END. 
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_matfilerenew C-Win 
PROCEDURE pro_matfilerenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
     For each  wdetail2:
            DELETE  wdetail2.
     END.
     INPUT FROM VALUE(fi_FileName).
     REPEAT:
         CREATE wdetail2.
         IMPORT DELIMITER "|" 
             wdetail2.id            /*  1   �ӴѺ���    */                                      
             wdetail2.companame     /*  2   ����ѷ��Сѹ    */                 
             wdetail2.polstk        /*  3   �Ţ����������.�.�.    */         
             wdetail2.idbranch      /*  4   �����Ң�    */                     
             wdetail2.branchname    /*  5   �Ң� KK */                         
             wdetail2.cedpol        /*  6   �Ţ����ѭ��     */                 
             wdetail2.titlenam      /*  7   �ӹ�˹�Ҫ���    */                 
             wdetail2.insurnam      /*  8   ���ͼ����һ�Сѹ    */             
             wdetail2.sername       /*  9   ���ʡ�ż����һ�Сѹ */             
             wdetail2.vehreg        /*  10  �Ţ����¹  */                     
             wdetail2.brand         /*  11  ������ö    */                     
             wdetail2.notifyno      /*  12  �Ţ����Ѻ��   */                 
             wdetail2.namnotify     /*  13  �������˹�ҷ�� MKT */             
             wdetail2.chassis       /*  14  �Ţ���ö    */                     
             wdetail2.comp          /*  15  �����ط��  */                     
             wdetail2.premt         /*  16  ���»�Сѹ��������ҡ�  */         
             wdetail2.comdat        /*  17  �ѹ������� �.�.�.  */             
             wdetail2.expdat        /*  18  �ѹ����ش �.�.�.   */             
             wdetail2.adr_no1       /*  19  ������� */                         
             wdetail2.adr_mu        /*  ����    */                             
             wdetail2.adr_muban     /*  �����ҹ    */                         
             wdetail2.adr_build     /*  �Ҥ��   */                             
             wdetail2.adr_soy       /*  ��� */                                 
             wdetail2.adr_road      /*  ��� */                                 
             wdetail2.adr_tambon    /*  �Ӻ�/�ǧ   */                         
             wdetail2.adr_amper     /*  �����/ࢵ   */                         
             wdetail2.adr_country   /*  �ѧ��Ѵ */                             
             wdetail2.adr_post      /*  ������ɳ���    */                     
             wdetail2.memmo         /*  20  �����˵�    */                     
             wdetail2.telephone     /*  21  ����Դ��� */                     
             wdetail2.idno          /*  22  �Ţ���ѵû�ЪҪ�   */             
             wdetail2.titlenam01    /*  27  �ӹ�˹�Ҫ���1   */                    
             wdetail2.name01        /*  28  ���͡������1    */                    
             wdetail2.sernam01      /*  29  ���ʡ�š������1 */                    
             wdetail2.idnonam01     /*  30  �Ţ���ѵû�ЪҪ��������1   */        
             wdetail2.titlenam02    /*  31  �ӹ�˹�Ҫ���2   */                    
             wdetail2.name02        /*  32  ���͡������2    */                    
             wdetail2.sernam02      /*  33  ���ʡ�š������2 */                    
             wdetail2.idnonam02     /*  34  �Ţ���ѵû�ЪҪ��������2   */        
             wdetail2.titlenam03    /*  35  �ӹ�˹�Ҫ���3   */                 
             wdetail2.name03        /*  36  ���ͼ��������3 */                          
             wdetail2.sernam03      /*  37  ���ʡ�š������3 */                       
             wdetail2.idnonam03     /*  38  �Ţ���ѵû�ЪҪ��������3   */ 
             wdetail2.nsend         /* A61-0335*/
             wdetail2.sendname      /* A61-0335*/
             wdetail2.kkapp .       /* A61-0335*/
         
         IF index(wdetail2.id,"�ӴѺ")  <> 0 THEN DELETE wdetail2.
         ELSE IF index(wdetail2.id,"���") <> 0 THEN DELETE wdetail2.
         ELSE IF wdetail2.id = "" THEN DELETE wdetail2.
     END.    /* repeat  */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

