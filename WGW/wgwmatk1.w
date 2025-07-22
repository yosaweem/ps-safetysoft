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
/*create by        : Kridtiya il. A55-0055  17/02/2012                      */  
/*                   Match file confirm to file Load Text �����excel     */  
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW */ 
/*modify by        : Kridtiya i. A56-0021  ������������ѹ�Դ����Ţ�ѵû�ЪҪ��١���*/
/*modify by        : Ranu I. A59-0590 �������͹䢡�� match V72 ���������ͧ �ú.���§ҹ*/
/*modify by        : Ranu I. A61-0335 ��������红����� kk app */
/*-----------------------------------------------------------------*/

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
DEFINE NEW SHARED TEMP-TABLE wdetail
    FIELD createdat    AS CHAR FORMAT "X(15)"  INIT ""  /*1   Create Date   */                                    
    FIELD createdat2   AS CHAR FORMAT "X(15)"  INIT ""  /*2   �ѹ������    */                                    
    FIELD compno       AS CHAR FORMAT "X(50)"  INIT ""  /*3   ��ª��ͺ���ѷ��Сѹ���*/                            
    FIELD brno         AS CHAR FORMAT "X(10)"  INIT ""  /*4   �����Ң� KK           */                            
    FIELD brname       AS CHAR FORMAT "X(30)"  INIT ""  /*5   �Ң� KK               */                            
    FIELD cedno        AS CHAR FORMAT "X(25)"  INIT ""  /*6   �Ţ����ѭ����ҫ���   */                            
    FIELD prevpol      AS CHAR FORMAT "X(25)"  INIT ""  /*7   �Ţ�������������    */                            
    FIELD cedpol       AS CHAR FORMAT "X(25)"  INIT ""  /*8   �Ţ����Ѻ��         */                            
    FIELD campaign     AS CHAR FORMAT "X(100)"  INIT ""  /*9   Campaign              */                            
    FIELD subcam       AS CHAR FORMAT "X(250)" INIT ""  /*10  Sub Campaign          */                            
    FIELD free         AS CHAR FORMAT "X(100)"  INIT ""  /*11  �����������          */                            
    FIELD typeins      AS CHAR FORMAT "X(25)"  INIT ""  /*12  �ؤ��/�ԵԺؤ��       */                            
    FIELD titlenam     AS CHAR FORMAT "X(30)"  INIT ""  /*13  �ӹ�˹�Ҫ��ͼ����һ�Сѹ*/                          
    FIELD name1        AS CHAR FORMAT "X(40)"  INIT ""  /*14  ���ͼ����һ�Сѹ    */                              
    FIELD name2        AS CHAR FORMAT "X(40)"  INIT ""  /*15  ���ʡ�ż����һ�Сѹ */                              
    FIELD ad11         AS CHAR FORMAT "X(20)"  INIT ""  /*16  ��ҹ�Ţ���          */                              
    FIELD ad12         AS CHAR FORMAT "X(40)"  INIT ""  /*17  �Ҥ��/  �����ҹ             */                              
    FIELD ad13         AS CHAR FORMAT "X(10)"  INIT ""  /*18  ������ */                              
    FIELD ad14         AS CHAR FORMAT "X(40)"  INIT ""  /*19  ���                 */                              
    FIELD ad15         AS CHAR FORMAT "X(40)"  INIT ""  /*20  ���                 */                              
    FIELD ad21         AS CHAR FORMAT "X(40)"  INIT ""  /*21  �Ӻ�/�ǧ           */                              
    FIELD ad22         AS CHAR FORMAT "X(40)"  INIT ""  /*22  �����/ ࢵ          */                              
    FIELD ad3          AS CHAR FORMAT "X(40)"  INIT ""  /*23  �ѧ��Ѵ           */                                
    FIELD post         AS CHAR FORMAT "X(10)"  INIT ""  /*24  ������ɳ���        */                              
    FIELD covcod       AS CHAR FORMAT "X(20)"  INIT ""  /*25  ����������������ͧ  */                              
    FIELD garage       AS CHAR FORMAT "X(20)"  INIT ""  /*26  ��������ë���       */                              
    FIELD comdat       AS CHAR FORMAT "X(15)"  INIT ""  /*27  �ѹ��������ͧ�������*/                            
    FIELD expdat       AS CHAR FORMAT "X(15)"  INIT ""  /*28  �ѹ��������ͧ����ش */                            
    FIELD class        AS CHAR FORMAT "X(10)"  INIT ""  /*29  ����ö                */                            
    FIELD typecar      AS CHAR FORMAT "X(40)"  INIT ""  /*30  ��������Сѹ���ö¹�� */                            
    FIELD brand        AS CHAR FORMAT "X(20)"  INIT ""  /*31  ����������ö          */                            
    FIELD model        AS CHAR FORMAT "X(50)"  INIT ""  /*32  ���ö                */                            
    FIELD typenam      AS CHAR FORMAT "X(10)"  INIT ""  /*33  New/      Used        */                            
    FIELD vehreg       AS CHAR FORMAT "X(45)"  INIT ""  /*34  �Ţ����¹            */                            
    FIELD veh_country  AS CHAR FORMAT "X(30)"  INIT ""  /*35  �ѧ��Ѵ����͡�Ţ����¹*/                           
    FIELD chassis      AS CHAR FORMAT "X(30)"  INIT ""  /*36  �Ţ����Ƕѧ          */                            
    FIELD engno        AS CHAR FORMAT "X(30)"  INIT ""  /*37  �Ţ�������ͧ¹��     */                            
    FIELD caryear      AS CHAR FORMAT "X(10)"  INIT ""  /*38  ��ö¹��              */                            
    FIELD cc           AS CHAR FORMAT "X(30)"  INIT ""  /*39  �ի�                  */                            
    FIELD weigth       AS CHAR FORMAT "X(30)"  INIT ""  /*40  ���˹ѡ/      �ѹ     */                            
    FIELD si           AS CHAR FORMAT "X(20)"  INIT ""  /*41  �ع��Сѹ�� 1 /�������*/                            
    FIELD prem         AS CHAR FORMAT "X(20)"  INIT ""  /*42  ���������������ҡû� 1 /�������*/                  
    FIELD si2          AS CHAR FORMAT "X(20)"  INIT ""  /*43  �ع��Сѹ�� 2                   */                  
    FIELD prem2        AS CHAR FORMAT "X(15)"  INIT ""  /*44  ���������������ҡû� 2         */                  
    FIELD timeno       AS CHAR FORMAT "X(20)"  INIT ""  /*45  �����Ѻ��                 */                      
    FIELD stk          AS CHAR FORMAT "X(30)"  INIT ""  /*46  �Ţ����ͧ���µ�� �.�.�.        */                  
    FIELD compdatco    AS CHAR FORMAT "X(15)"  INIT ""  /*47  �ѹ������ͧ(�.�.�)�������      */                 
    FIELD expdatco     AS CHAR FORMAT "X(15)"  INIT ""  /*48  �ѹ������ͧ(�.�.�)����ش       */                  
    FIELD compprm      AS CHAR FORMAT "X(20)"  INIT ""  /*49  ���������������ҡ� (�.�.�)   */                    
    FIELD notifynam    AS CHAR FORMAT "X(50)"  INIT ""  /*50   �������˹�ҷ���Ѻ��          */                  
    FIELD memmo        AS CHAR FORMAT "X(100)" INIT ""  /*51  �����˵� / ���������ʹ������� */                  
    FIELD drivnam1     AS CHAR FORMAT "X(40)"  INIT ""  /*52  ���Ѻ����� 1                  */                  
    FIELD birdth1      AS CHAR FORMAT "X(15)"  INIT ""  /*53  �ѹ�Դ���Ѻ����� 1           */                  
    FIELD drivnam2     AS CHAR FORMAT "X(40)"  INIT ""  /*54  ���Ѻ����� 2                  */                  
    FIELD birdth2      AS CHAR FORMAT "X(15)"  INIT ""  /*55  �ѹ�Դ���Ѻ����� 2           */                  
    FIELD invoice      AS CHAR FORMAT "X(50)"  INIT ""  /*56  ���� - ʡ�� (�����/㺡ӡѺ����)*/                 
    FIELD addinvoice   AS CHAR FORMAT "X(100)" INIT ""  /*57  ������� (�����/㺡ӡѺ����)    */                 
    FIELD emtry        AS CHAR FORMAT "X(100)" INIT ""  /*58  */
    FIELD datasystem   AS CHAR FORMAT "X(15)"  INIT ""    /*59 �����Ũҡ�к�  */
    FIELD n_policy     AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD n_policy72   AS CHAR FORMAT "x(20)"  INIT ""  /*A59-0590*/
    FIELD BIRTHDAY         AS CHAR FORMAT "x(15)"  INIT ""  /* 29 Drive_lic2      *//* A56-0021 */
    FIELD CARD_ID          AS CHAR FORMAT "x(15)"  INIT ""  /* 30 Drive_hbd1      *//* A56-0021 */
    FIELD CARD_TYPE        AS CHAR FORMAT "x(30)"  INIT ""  /* 31 Drive_hbd2      *//* A56-0021 */
    FIELD ADDR_CON_ADDR    AS CHAR FORMAT "x(40)"  INIT ""  /* 32 Driver_type     *//* A56-0021 */
    FIELD ADDR_HOUSE       AS CHAR FORMAT "x(15)"  INIT ""  /* 33 Benefit_name    *//* A56-0021 */
    FIELD ADDR_VILLAGE     AS CHAR FORMAT "x(20)"  INIT ""  /* 34 Type_ins        *//* A56-0021 */
    FIELD ADDR_BUILDING    AS CHAR FORMAT "x(30)"  INIT ""  /* 35 Receive_name    *//* A56-0021 */
    FIELD ADDR_FLOOR       AS CHAR FORMAT "x(10)"  INIT ""  /* 36 Net_prem        *//* A56-0021 */
    FIELD ADDR_MOO         AS CHAR FORMAT "x(5)"   INIT ""  /* 37 Net_prem_DigF   *//* A56-0021 */
    FIELD ADDR_SOI         AS CHAR FORMAT "x(30)"  INIT ""  /* 38 Stamp           *//* A56-0021 */
    FIELD ADDR_STREET      AS CHAR FORMAT "x(30)"  INIT ""  /* 39 stamp_dig       *//* A56-0021 */
    FIELD ADDR_TAMBOL      AS CHAR FORMAT "x(40)"  INIT ""  /* 40 vat_amt         *//* A56-0021 */
    FIELD ADDR_AMPHUR      AS CHAR FORMAT "x(40)"  INIT ""  /* 41 vat_amt_dig     *//* A56-0021 */
    FIELD ADDR_PROVINCE    AS CHAR FORMAT "x(30)"  INIT ""  /* 42 Tax_amt         *//* A56-0021 */
    FIELD ADDR_ZIP         AS CHAR FORMAT "x(5)"   INIT ""   /* 43 Tax_amt_dig   *//* A56-0021 */
    FIELD kkapp            AS CHAR FORMAT "x(20)"   INIT "" .  /* 43 Tax_amt_dig   *//* A56-0021 */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_exit bu_file ~
fi_outfile2 RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_outfile2 

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

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 62.33 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile2 AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 65 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 83.5 BY 8.33
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.52 COL 13.17 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 4.81 COL 12.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 7.76 COL 61.83
     bu_exit AT ROW 7.76 COL 71.5
     bu_file AT ROW 3.52 COL 78.67
     fi_outfile2 AT ROW 6.05 COL 12.83 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 3.52 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 4.81 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "File Load New Match Policy no." VIEW-AS TEXT
          SIZE 33 BY 1.05 AT ROW 7.19 COL 25.33 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "  Match Text File (KK- ����ᴧ) to GW and Premium[Policy]" VIEW-AS TEXT
          SIZE 80.5 BY 1.67 AT ROW 1.48 COL 2.5
          BGCOLOR 18 FGCOLOR 2 FONT 2
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 6.05 COL 2.5 WIDGET-ID 4
          BGCOLOR 29 FGCOLOR 2 FONT 6
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 7.52 COL 60.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 83.67 BY 8.48
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
         TITLE              = "Match Text File Policy (KK-����ᴧ)"
         HEIGHT             = 8.48
         WIDTH              = 84.17
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 103.83
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 103.83
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
ON END-ERROR OF C-Win /* Match Text File Policy (KK-����ᴧ) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File Policy (KK-����ᴧ) */
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
    DEF  VAR NO_add AS CHAR FORMAT "x(50)" .

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
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) 
         fi_outfile  = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4)) + no_add + ".slk" /*.csv*/
         fi_outfile2 = SUBSTRING(cvData,1,R-INDEX(fi_filename,"\")) + "FileSend_KKNew_" + no_add + ".slk".
    END.
    DISP fi_filename fi_outfile fi_outfile2 WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    ASSIGN nv_reccnt  =  0.
    For each  wdetail:
        DELETE  wdetail.
    END.
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
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
            wdetail.ad12         /*18  �Ҥ��/  �����ҹ    */                           
            wdetail.ad13         /*17  ������             */                       
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
            wdetail.datasystem 
            wdetail.BIRTHDAY       /*Add A56_0021*/   
            wdetail.CARD_ID        /*Add A56_0021*/  
            wdetail.CARD_TYPE      /*Add A56_0021*/ 
            wdetail.ADDR_CON_ADDR  /*Add A56_0021*/ 
            wdetail.ADDR_HOUSE     /*Add A56_0021*/ 
            wdetail.ADDR_VILLAGE   /*Add A56_0021*/ 
            wdetail.ADDR_BUILDING  /*Add A56_0021*/ 
            wdetail.ADDR_FLOOR     /*Add A56_0021*/ 
            wdetail.ADDR_MOO       /*Add A56_0021*/ 
            wdetail.ADDR_SOI       /*Add A56_0021*/ 
            wdetail.ADDR_STREET    /*Add A56_0021*/ 
            wdetail.ADDR_TAMBOL    /*Add A56_0021*/ 
            wdetail.ADDR_AMPHUR    /*Add A56_0021*/ 
            wdetail.ADDR_PROVINCE  /*Add A56_0021*/ 
            wdetail.ADDR_ZIP       /*Add A56_0021*/
            wdetail.kkapp .      /*A61-0335*/
    END.    /* repeat  */
    FOR EACH wdetail.
        IF index(wdetail.createdat,"����ѷ")     <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.createdat,"create") <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.createdat,"���") <> 0 THEN DELETE wdetail.
    END.
    RUN  Pro_matchfile_prem.
    Run  Pro_createfile.
    RUN  pro_createfileKK.

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


&Scoped-define SELF-NAME fi_outfile2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile2 C-Win
ON LEAVE OF fi_outfile2 IN FRAME fr_main
DO:
    fi_outfile2  =  Input  fi_outfile2.
    Disp  fi_outfile2 with frame  fr_main.
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
  
      gv_prgid = "WGWMATK1.W".
  gv_prog  = "Import Text && OUTPUT File Confirm (KK-����ᴧ) to Excel".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

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
  DISPLAY fi_filename fi_outfile fi_outfile2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file fi_outfile2 RECT-76 
         RECT-77 
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
ASSIGN n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN fi_outfile  =  Trim(fi_outfile) + ".slk"  .

OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ��Ҥ�����õԹҤԹ �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ѹ����Ѻ��"               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "�ѹ����Ѻ�Թ������»�Сѹ" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "��ª��ͺ���ѷ��Сѹ���"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "�����Ң�"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ң� KK"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "�Ţ����ѭ����ҫ���"         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "������������"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "�Ţ�ú.����"                 '"' SKIP.   /*A59-0590*/      
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "�Ţ�������������"          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "�Ţ�Ѻ���"                 '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Campaign"                    '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Sub Campaign"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "�����������"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "�ؤ��/�ԵԺؤ��"             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "�ӹ�˹�Ҫ���"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "���ͼ����һ�Сѹ"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "���ʡ�ż����һ�Сѹ"         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "��ҹ�Ţ���"                  '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�Ҥ��/�����ҹ"              '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "������"                     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "���"                         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "���"                         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "�Ӻ�/�ǧ"                   '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "�����/ ࢵ"                  '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "�ѧ��Ѵ"                     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "������ɳ���"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "����������������ͧ"          '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "��������ë���"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "�ѹ�����������ͧ"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "�ѹ����ش������ͧ"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "����ö"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "��������Сѹ���ö¹��"       '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "����������ö"                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "���ö"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "New/Used  "                  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�Ţ����¹"                  '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "�ѧ��Ѵ����͡�Ţ����¹"     '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "�Ţ����Ƕѧ"                '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "�Ţ�������ͧ¹��"           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "��ö¹��"                    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "�ի�"                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "���˹ѡ/�ѹ"                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "�ع��Сѹ�� 1 /�������"             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "���������������ҡû� 1/�������"    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "�ع��Сѹ�� 2"                      '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "���������������ҡû� 2"            '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "�����Ѻ��"                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "�Ţ����ͧ���µ�� �.�.�."           '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "�ѹ������ͧ(�.�.�)�������"         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "�ѹ������ͧ(�.�.�)����ش "         '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "���������������ҡ� (�.�.�)"        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "�������˹�ҷ���Ѻ��     "        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "�����˵� / ���������ʹ�������"    '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "���Ѻ����� 1       "              '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "�ѹ�Դ���Ѻ����� 1"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "���Ѻ����� 2       "              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"' "�ѹ�Դ���Ѻ����� 2"              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"' "���� - ʡ�� (�����/㺡ӡѺ����)"  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"' "������� (�����/㺡ӡѺ����)"      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"' " "                                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"' "�����Ũҡ�к�"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"' "�ѹ�Դ"                            '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"' "�Ţ�ѵû�ЪҪ�"                     '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"' "��Դ�ѵ�"                           '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"' "�Ҫվ     "                         '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"' "�Ţ����ҹ"                         '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"' "�����ҹ"                           '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"' "�Ҥ��"                              '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"' "���"                               '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"' "����"                               '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"' "���"                                '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"' "���"                                '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"' "�Ӻ�"                               '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"' "�����"                              '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"' "�ѧ��Ѵ"                            '"' SKIP.     /*Add A56_0021*/ 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"' "���� "                              '"' SKIP.      /*Add A56_0021*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"' "KK Application"                     '"' SKIP.      /*Add A61-0335*/ 

FOR EACH wdetail WHERE  wdetail.chassis <> ""   no-lock.
    ASSIGN  n_record =  n_record + 1                   
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  wdetail.createdat    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  wdetail.createdat2   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  wdetail.compno       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  wdetail.brno         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  wdetail.brname       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  wdetail.cedno        '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  wdetail.n_policy     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  wdetail.n_policy72   '"' SKIP. /* A59-0590*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  wdetail.prevpol      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.cedpol       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.campaign     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.subcam       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.free         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.typeins      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.titlenam     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.name1        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.name2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.ad11         '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.ad12         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.ad13         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.ad14         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.ad15         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.ad21         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.ad22         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.ad3          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.post         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.covcod       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.garage       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  string(date(wdetail.comdat),"99/99/9999") FORMAT "x(15)" '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  string(date(wdetail.expdat),"99/99/9999") FORMAT "x(15)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.class        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.typecar      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.brand        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  wdetail.model        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  wdetail.typenam      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  wdetail.vehreg       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  wdetail.veh_country  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.chassis      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"'  wdetail.engno        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"'  wdetail.caryear      '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"'  wdetail.cc           '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"'  wdetail.weigth       '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"'  wdetail.si           '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"'  wdetail.prem         '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"'  wdetail.si2          '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"'  wdetail.prem2        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"'  wdetail.timeno FORMAT "x(10)"      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"'  wdetail.stk          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"'  wdetail.compdatco    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"'  wdetail.expdatco     '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"'  wdetail.compprm      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"'  wdetail.notifynam    '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"'  wdetail.memmo        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"'  wdetail.drivnam1     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"'  wdetail.birdth1      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"'  wdetail.drivnam2     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K"  '"'  wdetail.birdth2      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X58;K"  '"'  wdetail.invoice      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X59;K"  '"'  wdetail.addinvoice   '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X60;K"  '"'  wdetail.emtry        '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X61;K"  '"'  wdetail.datasystem   '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X62;K"  '"'  wdetail.BIRTHDAY       '"' SKIP.     /*Add A56_0021*/   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X63;K"  '"'  wdetail.CARD_ID        '"' SKIP.     /*Add A56_0021*/  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X64;K"  '"'  wdetail.CARD_TYPE      '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X65;K"  '"'  wdetail.ADDR_CON_ADDR  '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X66;K"  '"'  wdetail.ADDR_HOUSE     '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X67;K"  '"'  wdetail.ADDR_VILLAGE   '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X68;K"  '"'  wdetail.ADDR_BUILDING  '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X69;K"  '"'  wdetail.ADDR_FLOOR     '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X70;K"  '"'  wdetail.ADDR_MOO       '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X71;K"  '"'  wdetail.ADDR_SOI       '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X72;K"  '"'  wdetail.ADDR_STREET    '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X73;K"  '"'  wdetail.ADDR_TAMBOL    '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X74;K"  '"'  wdetail.ADDR_AMPHUR    '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X75;K"  '"'  wdetail.ADDR_PROVINCE  '"' SKIP.     /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X76;K"  '"'  wdetail.ADDR_ZIP       '"' SKIP.      /*Add A56_0021*/ 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X77;K"  '"'  wdetail.kkapp          '"' SKIP.      /*Add A56_0021*/
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_createfileKK C-Win 
PROCEDURE pro_createfileKK :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
def var   n_licen  as char format "x(50)" init "" .
def var   n_name   as char format "x(100)" init "" .
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_outfile2,length(fi_outfile2) - 3,4) <>  ".slk"  THEN 
    fi_outfile2  =  Trim(fi_outfile2) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_outfile2).
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
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "�ѹ�������"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "�ѹ����ش "            '"' SKIP.         
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

FOR EACH wdetail WHERE wdetail.chassis <> "" no-lock.
    ASSIGN n_name = ""   n_licen = ""
           n_name   = TRIM(trim(wdetail.titlenam) + " " + trim(wdetail.name1) + " " + trim(wdetail.name2))
           n_licen  = TRIM(wdetail.vehreg) + " " + trim(wdetail.veh_country) 
           n_record =  n_record + 1
           nv_cnt   =  nv_cnt  + 1 
           nv_row   =  nv_row  + 1.
    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   n_record             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.compno       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.n_policy     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.brno         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.brname       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.cedno        '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.titlenam     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.name1        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.name2        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.cedpol       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.createdat    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  n_licen       '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.brand       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.chassis     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.notifynam    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  ""                  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.covcod      '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.garage      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.si       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.prem     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  string(date(wdetail.comdat),"99/99/9999") format "x(15)"  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  string(date(wdetail.expdat),"99/99/9999") format "x(15)"  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  n_name          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.ad11    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.ad13    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  IF index(wdetail.ad12,"�����ҹ") <> 0 THEN TRIM(wdetail.ad12) ELSE ""   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  IF index(wdetail.ad12,"�Ҥ��") <> 0 THEN TRIM(wdetail.ad12) ELSE ""    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.ad14    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.ad15    '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.ad21    '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.ad22    '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  wdetail.ad3     '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  wdetail.post  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  ""  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"'  ""  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"'  ""  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"'  ""  '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"'  wdetail.KKapp  FORMAT "x(20)"     '"' SKIP.         
    
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
FOR EACH wdetail .
    IF wdetail.chassis = ""  THEN NEXT.
    ELSE DO:
        IF wdetail.cedno = "" THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = substr(trim(wdetail.cedpol),2) + "-" + SUBSTR(trim(wdetail.brno),2) AND 
                sicuw.uwm100.poltyp = "V70"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                    ASSIGN  wdetail.n_policy = sicuw.uwm100.policy .
                    FIND LAST brstat.tlt  WHERE    
                            brstat.tlt.cha_no     = wdetail.chassis    AND
                            tlt.genusr            = "kk-new"          NO-ERROR NO-WAIT.
                    IF AVAIL brstat.tlt THEN DO:
                        IF INDEX(tlt.releas,"YES") <> 0  THEN ASSIGN tlt.releas =  tlt.releas.
                        ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas =  "YES".
                        ELSE ASSIGN tlt.releas =  "YES/CA".
                    END.
                END.
            END.
            ELSE DO:
                /* create by A61-0335*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = TRIM(wdetail.kkapp) AND 
                    sicuw.uwm100.poltyp = "V70"    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy = sicuw.uwm100.policy .
                        FIND LAST brstat.tlt  WHERE    
                                brstat.tlt.cha_no     = wdetail.chassis    AND
                                tlt.genusr            = "kk-new"          NO-ERROR NO-WAIT.
                        IF AVAIL brstat.tlt THEN DO:
                            IF INDEX(tlt.releas,"YES") <> 0  THEN ASSIGN tlt.releas =  tlt.releas.
                            ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas =  "YES".
                            ELSE ASSIGN tlt.releas =  "YES/CA".
                        END.
                    END.
                END.
                /* end A61-0335*/
                ELSE ASSIGN wdetail.n_policy = "". 
            END.

            /* A59-0590 : �ҡ������� 72 */
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.cedpol) AND 
                sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                    ASSIGN  wdetail.n_policy72 = sicuw.uwm100.policy .
                END.
            END.
            ELSE DO:  
                /* create by A61-0335*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                    sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy72 = sicuw.uwm100.policy .
                    END.
                END.
                /*end A61-0335*/
                ELSE ASSIGN wdetail.n_policy72 = "".

            END.
            /* End A59-0590*/
        END. 
        ELSE DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
            sicuw.uwm100.cedpol = trim(wdetail.cedno) AND 
            sicuw.uwm100.poltyp = "V70"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                    ASSIGN  wdetail.n_policy = sicuw.uwm100.policy .
                    FIND LAST brstat.tlt  WHERE    
                        brstat.tlt.cha_no     = wdetail.chassis    AND
                        tlt.genusr            = "kk-new"          NO-ERROR NO-WAIT.
                    IF AVAIL brstat.tlt THEN DO:
                        IF INDEX(tlt.releas,"YES") <> 0  THEN ASSIGN tlt.releas =  tlt.releas.
                        ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas =  "YES".
                        ELSE ASSIGN tlt.releas =  "YES/CA".
                    END.
                END.
            END.
            ELSE DO:  
                 /* create by A61-0335*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = TRIM(wdetail.kkapp) AND 
                    sicuw.uwm100.poltyp = "V70"    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy = sicuw.uwm100.policy .
                        FIND LAST brstat.tlt  WHERE    
                                brstat.tlt.cha_no     = wdetail.chassis    AND
                                tlt.genusr            = "kk-new"          NO-ERROR NO-WAIT.
                        IF AVAIL brstat.tlt THEN DO:
                            IF INDEX(tlt.releas,"YES") <> 0  THEN ASSIGN tlt.releas =  tlt.releas.
                            ELSE IF tlt.releas = "NO" THEN ASSIGN tlt.releas =  "YES".
                            ELSE ASSIGN tlt.releas =  "YES/CA".
                        END.
                    END.
                END.
                /* end A61-0335*/
                ELSE ASSIGN wdetail.n_policy = "".
            END.

            /* A59-0590 : �ҡ������� 72 */
            FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                sicuw.uwm100.cedpol = trim(wdetail.cedno) AND 
                sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm100 THEN DO:
                IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                    ASSIGN  wdetail.n_policy72 = sicuw.uwm100.policy .
                END.
            END.
            ELSE DO: 
                 /* create by A61-0335*/
                FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE  
                    sicuw.uwm100.cedpol = trim(wdetail.kkapp) AND 
                    sicuw.uwm100.poltyp = "V72"    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.expdat >  date(wdetail.comdat) THEN DO: 
                        ASSIGN  wdetail.n_policy72 = sicuw.uwm100.policy .
                    END.
                END.
                /*end A61-0335*/
                ELSE ASSIGN wdetail.n_policy72 = "".
            END.
        END. /* End A59-0590*/
    END.
END.      /* wdetail*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

