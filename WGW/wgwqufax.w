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
program id       : wgwqufax.w
program name     : Query & Update data fax 
Create  by       : Kridtiya i. A56-0024  date. 31/01/2013
Connect          : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT ,SICSYAC  ,SICUW 
+++++++++++++++++++++++++++++++++++++++++++++++*/
DEFINE  VAR nv_rectlt    as recid  init  0.
DEFINE  VAR nv_recidtlt  as recid  init  0.
def  stream  ns2.           
DEFINE  VAR nv_cnt       as int  init   1.
DEFINE  VAR nv_row       as int  init   0.
DEFINE  VAR n_record     AS INTE INIT   0.
DEFINE  VAR n_comname    AS CHAR INIT  "".
DEFINE  VAR n_asdat      AS CHAR.
DEFINE  VAR vAcProc_fil  AS CHAR.
DEFINE  VAR vAcProc_fil2 AS CHAR.
DEFINE  VAR n_asdat2     AS CHAR.

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
&Scoped-define FIELDS-IN-QUERY-br_tlt tlt.genusr tlt.releas ~
tlt.nor_noti_tlt tlt.lotno tlt.policy tlt.comp_pol tlt.ins_name tlt.lince1 ~
tlt.cha_no tlt.nor_effdat tlt.expodat tlt.nor_usr_ins tlt.comp_noti_tlt ~
tlt.expousr 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_tlt 
&Scoped-define QUERY-STRING-br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt
&Scoped-define OPEN-QUERY-br_tlt OPEN QUERY br_tlt FOR EACH tlt NO-LOCK ~
    BY tlt.comp_noti_tlt.
&Scoped-define TABLES-IN-QUERY-br_tlt tlt
&Scoped-define FIRST-TABLE-IN-QUERY-br_tlt tlt


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_trndatfr fi_trndatto fi_polfr fi_polto ~
bu_ok cb_search fi_searchcom fi_search bu_sch fi_comname cb_report ~
fi_reportdata fi_filename bu_reok br_tlt fi_report bu_exit RECT-332 ~
RECT-333 RECT-338 RECT-340 RECT-341 RECT-343 RECT-344 RECT-346 
&Scoped-Define DISPLAYED-OBJECTS fi_trndatfr fi_trndatto fi_polfr fi_polto ~
cb_search fi_searchcom fi_search fi_comname cb_report fi_reportdata ~
fi_filename fi_report 

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
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 8 BY 1
     FONT 6.

DEFINE BUTTON bu_reok 
     LABEL "OK" 
     SIZE 5.5 BY 1.

DEFINE BUTTON bu_sch 
     LABEL "Search" 
     SIZE 7 BY 1.

DEFINE VARIABLE cb_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "�Ң�" 
     DROP-DOWN-LIST
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE cb_search AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "�����١���" 
     DROP-DOWN-LIST
     SIZE 39 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_comname AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polfr AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polto AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_report AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 11 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_reportdata AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_search AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 40 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_searchcom AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-332
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132.5 BY 6.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-333
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 11 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-338
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 56 BY 4.52
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-340
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 106 BY 1.52
     BGCOLOR 31 .

DEFINE RECTANGLE RECT-341
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 11 BY 1.52
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-343
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 73 BY 4.52
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-344
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 8.5 BY 1.76
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-346
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 10 BY 1.52
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_tlt FOR 
      tlt SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_tlt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_tlt c-wins _STRUCTURED
  QUERY br_tlt NO-LOCK DISPLAY
      tlt.genusr COLUMN-LABEL "SYSTEM" FORMAT "x(5)":U
      tlt.releas FORMAT "x(6)":U WIDTH 7
      tlt.nor_noti_tlt COLUMN-LABEL "�Ţ�Ѻ��FAX" FORMAT "x(15)":U
            WIDTH 18
      tlt.lotno COLUMN-LABEL "Company" FORMAT "x(10)":U WIDTH 9
      tlt.policy FORMAT "x(13)":U WIDTH 16.33
      tlt.comp_pol FORMAT "x(13)":U WIDTH 16.83
      tlt.ins_name FORMAT "x(50)":U WIDTH 30
      tlt.lince1 COLUMN-LABEL "����¹" FORMAT "x(30)":U WIDTH 22
      tlt.cha_no FORMAT "x(25)":U
      tlt.nor_effdat COLUMN-LABEL "Comdate." FORMAT "99/99/9999":U
            WIDTH 11
      tlt.expodat COLUMN-LABEL "Expydate." FORMAT "99/99/9999":U
            WIDTH 11
      tlt.nor_usr_ins COLUMN-LABEL "���ͼ����" FORMAT "x(50)":U
            WIDTH 23.83
      tlt.comp_noti_tlt COLUMN-LABEL "�Ţ����ѭ��" FORMAT "x(25)":U
      tlt.expousr COLUMN-LABEL "����Ѻ��" FORMAT "x(30)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132.5 BY 16.71
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .62.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_trndatfr AT ROW 1.52 COL 17.17 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 1.52 COL 37 COLON-ALIGNED NO-LABEL
     fi_polfr AT ROW 1.52 COL 67.17 COLON-ALIGNED NO-LABEL
     fi_polto AT ROW 1.52 COL 88 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 1.52 COL 111.17
     cb_search AT ROW 3.14 COL 16 NO-LABEL
     fi_searchcom AT ROW 4.24 COL 16 NO-LABEL
     fi_search AT ROW 5.33 COL 3 NO-LABEL
     bu_sch AT ROW 4.91 COL 45.83
     fi_comname AT ROW 4.29 COL 74 COLON-ALIGNED NO-LABEL
     cb_report AT ROW 5.29 COL 69.17 COLON-ALIGNED NO-LABEL
     fi_reportdata AT ROW 5.33 COL 111.83 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 6.38 COL 69 COLON-ALIGNED NO-LABEL
     bu_reok AT ROW 5.95 COL 123.17
     br_tlt AT ROW 7.95 COL 1
     fi_report AT ROW 5.33 COL 100.17 COLON-ALIGNED NO-LABEL
     bu_exit AT ROW 1.52 COL 122.17
     "Report File:" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 3.24 COL 60
          BGCOLOR 5 FGCOLOR 1 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 1.52 COL 34.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Transdate From :" VIEW-AS TEXT
          SIZE 15.83 BY .95 AT ROW 1.52 COL 3
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 1.52 COL 84.83
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Company name :" VIEW-AS TEXT
          SIZE 15.5 BY .95 AT ROW 4.29 COL 60
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "By Company:" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 4.29 COL 3
          BGCOLOR 5 FONT 6
     "Report By :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 5.33 COL 60
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Policy From :" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 1.52 COL 54.67
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Search  By :" VIEW-AS TEXT
          SIZE 12.5 BY .95 AT ROW 3.24 COL 3
          BGCOLOR 5 FONT 6
     "File name :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 6.38 COL 60
          BGCOLOR 2 FGCOLOR 7 FONT 6
     RECT-332 AT ROW 1.1 COL 1
     RECT-333 AT ROW 1.29 COL 109.5
     RECT-338 AT ROW 3 COL 2
     RECT-340 AT ROW 1.29 COL 2
     RECT-341 AT ROW 1.29 COL 120.67
     RECT-343 AT ROW 3 COL 58.33
     RECT-344 AT ROW 5.57 COL 121.5
     RECT-346 AT ROW 4.67 COL 44.33
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
  CREATE WINDOW c-wins ASSIGN
         HIDDEN             = YES
         TITLE              = "Query && Update [DATA BY FAX..]  wgwqufax.w"
         HEIGHT             = 23.91
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
         FONT               = 6
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-wins:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
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
/* BROWSE-TAB br_tlt bu_reok fr_main */
/* SETTINGS FOR COMBO-BOX cb_search IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_search IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_searchcom IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-wins)
THEN c-wins:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_tlt
/* Query rebuild information for BROWSE br_tlt
     _TblList          = "brstat.tlt"
     _Options          = "NO-LOCK"
     _OrdList          = "brstat.tlt.comp_noti_tlt|yes"
     _FldNameList[1]   > brstat.tlt.genusr
"genusr" "SYSTEM" "x(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > brstat.tlt.releas
"releas" ? "x(6)" "character" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" ""
     _FldNameList[3]   > brstat.tlt.nor_noti_tlt
"nor_noti_tlt" "�Ţ�Ѻ��FAX" "x(15)" "character" ? ? ? ? ? ? no ? no no "18" yes no no "U" "" ""
     _FldNameList[4]   > brstat.tlt.lotno
"lotno" "Company" "x(10)" "character" ? ? ? ? ? ? no ? no no "9" yes no no "U" "" ""
     _FldNameList[5]   > brstat.tlt.policy
"policy" ? "x(13)" "character" ? ? ? ? ? ? no ? no no "16.33" yes no no "U" "" ""
     _FldNameList[6]   > brstat.tlt.comp_pol
"comp_pol" ? "x(13)" "character" ? ? ? ? ? ? no ? no no "16.83" yes no no "U" "" ""
     _FldNameList[7]   > brstat.tlt.ins_name
"ins_name" ? ? "character" ? ? ? ? ? ? no ? no no "30" yes no no "U" "" ""
     _FldNameList[8]   > brstat.tlt.lince1
"lince1" "����¹" "x(30)" "character" ? ? ? ? ? ? no ? no no "22" yes no no "U" "" ""
     _FldNameList[9]   > brstat.tlt.cha_no
"cha_no" ? "x(25)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[10]   > brstat.tlt.nor_effdat
"nor_effdat" "Comdate." ? "date" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" ""
     _FldNameList[11]   > brstat.tlt.expodat
"expodat" "Expydate." "99/99/9999" "date" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" ""
     _FldNameList[12]   > brstat.tlt.nor_usr_ins
"nor_usr_ins" "���ͼ����" ? "character" ? ? ? ? ? ? no ? no no "23.83" yes no no "U" "" ""
     _FldNameList[13]   > brstat.tlt.comp_noti_tlt
"comp_noti_tlt" "�Ţ����ѭ��" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[14]   > brstat.tlt.expousr
"expousr" "����Ѻ��" "x(30)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE br_tlt */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-wins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON END-ERROR OF c-wins /* Query  Update [DATA BY FAX..]  wgwqufax.w */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-wins c-wins
ON WINDOW-CLOSE OF c-wins /* Query  Update [DATA BY FAX..]  wgwqufax.w */
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
    
    Run  wgw\wgwqufa1(Input  nv_recidtlt).

    {&WINDOW-NAME}:hidden  =  No.                                               

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_tlt c-wins
ON VALUE-CHANGED OF br_tlt IN FRAME fr_main
DO:
     Get  current  br_tlt.
     nv_rectlt =  recid(tlt).
     /*fi_name   =  tlt.ins_name.
     disp  fi_name  with frame  fr_main.*/
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


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok c-wins
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    IF (fi_polfr = "") AND (fi_polto = "") THEN DO:
        Open Query br_tlt 
            For each tlt Use-index  tlt01  Where
            tlt.trndat  >=   fi_trndatfr   And
            tlt.trndat  <=   fi_trndatto   And
            tlt.genusr   =  "fax"          no-lock.  
                Apply "Entry"  to br_tlt.
                Return no-apply.                             
    END.
    ELSE DO:
        IF fi_polto < fi_polfr THEN DO:
            Apply "Entry"  to fi_polto.
            Return no-apply.   
        END.
        ELSE DO:
            Open Query br_tlt 
                For each tlt Use-index  tlt01  Where
                tlt.trndat  >=   fi_trndatfr   And
                tlt.trndat  <=   fi_trndatto   And
                tlt.policy  >=   fi_polfr      And 
                tlt.policy  <=   fi_polto      And 
                tlt.genusr   =  "fax"          no-lock.  
                    Apply "Entry"  to br_tlt.
                    Return no-apply.   
        END. 
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_reok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_reok c-wins
ON CHOOSE OF bu_reok IN FRAME fr_main /* OK */
DO:
    IF fi_filename = ""  THEN DO:
        MESSAGE "��س��ʪ������!!!"  VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_filename.
        Return no-apply.
    END.
    ELSE RUN proc_report.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_sch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_sch c-wins
ON CHOOSE OF bu_sch IN FRAME fr_main /* Search */
DO:
    IF trim(fi_searchcom)  = "" THEN DO:
        If  cb_search =  "�����١���"  Then do:               /* name  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01            Where
                tlt.trndat         >=  fi_trndatfr       And
                tlt.trndat         <=  fi_trndatto       And
                tlt.genusr          =  "FAX"             And
                index(tlt.ins_name,trim(fi_search)) <> 0 no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "��������"  Then do:        /* policy */  
            Open Query br_tlt                      
                For each tlt Use-index  tlt01        Where
                tlt.trndat        >=  fi_trndatfr    And 
                tlt.trndat        <=  fi_trndatto    And 
                tlt.genusr         =  "FAX"          And 
                tlt.policy         = trim(fi_search) no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "�Ң�"  Then do:                    /* "�Ң�" *//*A55-0257*/
            Open Query br_tlt                      
                For each tlt Use-index  tlt01         Where
                tlt.trndat        >=  fi_trndatfr     And 
                tlt.trndat        <=  fi_trndatto     And 
                tlt.genusr         =  "FAX"           And 
                tlt.colorcod       =  trim(fi_search) no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "����¹ö"  Then do:                /* "����¹ö" *//*A55-0257*/
            Open Query br_tlt                                       
                For each tlt Use-index  tlt01      Where            
                tlt.trndat        >=  fi_trndatfr  And              
                tlt.trndat        <=  fi_trndatto  And              
                tlt.genusr         =  "FAX"        And                
                index(tlt.lince1,trim(fi_search)) <> 0     no-lock. 
                    Apply "Entry"  to br_tlt.                       
                    Return no-apply.                                
        END.
        ELSE If  cb_search  =  "company"  Then do:                  /* company  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt06      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"     And
                tlt.lotno          =  trim(fi_search)  no-lock.
                    Apply "Entry"  to  br_tlt.     
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "Chassis"  Then do:                  /* chassis...*/
            Open Query br_tlt                                       
                For each tlt Use-index  tlt01       Where            
                tlt.trndat         >=  fi_trndatfr     And              
                tlt.trndat         <=  fi_trndatto     And              
                tlt.genusr          =  "FAX"           And                
                tlt.cha_no          =  trim(fi_search) no-lock.     
                    Apply "Entry"  to br_tlt.                       
                    Return no-apply.                                
        END.
        ELSE If  cb_search  =  "Complete"  Then do:                 /* complete..*/
            Open Query br_tlt                                       
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"     And
                INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.    
        ELSE If  cb_search  =  "Not complete"  Then do:             /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"       And
                INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Release Yes" Then do:               /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"       And
                tlt.releas          =  "Yes"       no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.     
        END.
        ELSE If  cb_search  =  "Release No"  Then do:               /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"     And
                tlt.releas          =  "No"       no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        Else DO:
            Apply "Entry"  to  fi_search.
            Return no-apply.
        END.
    END.
    ELSE DO:
        If  cb_search =  "�����١���"  Then do:                   /* name  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.genusr          =  "FAX"      And
                tlt.lotno           =  trim(fi_searchcom) AND  
                index(tlt.ins_name,trim(fi_search)) <> 0 no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.            
        END.
        ELSE If  cb_search  =  "��������"  Then do:               /* policy */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01       Where
                tlt.trndat        >=  fi_trndatfr         AND 
                tlt.trndat        <=  fi_trndatto         And 
                tlt.genusr         =  "FAX"               And 
                tlt.lotno          =  trim(fi_searchcom)  AND  
                tlt.policy         =  trim(fi_search)     no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "�Ң�"  Then do:             /* "�Ң�" */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01             Where
                  tlt.trndat        >=  fi_trndatfr         And 
                  tlt.trndat        <=  fi_trndatto         And 
                  tlt.genusr         =  "FAX"               And 
                  tlt.lotno          =  trim(fi_searchcom)  AND 
                  tlt.colorcod       =  trim(fi_search)     no-lock.
                      Apply "Entry"  to br_tlt.      
                      Return no-apply.               
          END. 
          ELSE If  cb_search  =  "����¹ö"  Then do:         /* "����¹ö" *//*A55-0257*/
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01      Where
                  tlt.trndat        >=  fi_trndatfr  And 
                  tlt.trndat        <=  fi_trndatto  And 
                  tlt.genusr         =  "FAX"      And 
                  tlt.lotno          =  trim(fi_searchcom)  AND 
                  index(tlt.lince1,trim(fi_search)) <> 0     no-lock.
                      Apply "Entry"  to br_tlt.      
                      Return no-apply.               
          END.  
          ELSE If  cb_search  =  "company"  Then do:         /* company  */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt06      Where
                  tlt.trndat         >=  fi_trndatfr And
                  tlt.trndat         <=  fi_trndatto And
                  tlt.genusr          =  "FAX"       And
                  tlt.lotno           =  trim(fi_searchcom)   no-lock.
                      Apply "Entry"  to  br_tlt.     
                      Return no-apply.               
          END.
          ELSE If  cb_search  =  "Chassis"  Then do:         /* chassis...*/
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "FAX"      And
                  tlt.lotno           =  trim(fi_searchcom) AND  
                  tlt.cha_no          =  trim(fi_search) no-lock.
                      Apply "Entry"  to br_tlt.  
                      Return no-apply.           
          END.
          ELSE If  cb_search  =  "Complete"  Then do:         /* complete..*/
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "FAX"        And
                  tlt.lotno           =  trim(fi_searchcom) AND  
                  INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                      Apply "Entry"  to br_tlt.      
                      Return no-apply.               
          END.
          ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr        And
                  tlt.trndat         <=  fi_trndatto        And
                  tlt.genusr          =  "FAX"              And
                  tlt.lotno           =  trim(fi_searchcom) AND  
                  INDEX(tlt.OLD_eng,"not")  <> 0            no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.
          ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01             Where
                  tlt.trndat         >=  fi_trndatfr        And
                  tlt.trndat         <=  fi_trndatto        And
                  tlt.genusr          =  "FAX"              And
                  tlt.lotno           =  trim(fi_searchcom) AND  
                  tlt.releas          =  "Yes"              no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.
          ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr        And
                  tlt.trndat         <=  fi_trndatto        And
                  tlt.genusr          =  "FAX"              And
                  tlt.lotno           =  trim(fi_searchcom) AND 
                  tlt.releas          =  "No"               no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.                          
          Else DO:
              Apply "Entry"  to  fi_search.
              Return no-apply.
          END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_report
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_report c-wins
ON LEAVE OF cb_report IN FRAME fr_main
DO:
    cb_report = INPUT cb_report.
    n_asdat2  = INPUT cb_report.
    IF n_asdat2 = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
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
    cb_report =  INPUT cb_report.
    n_asdat2  = (INPUT cb_report).
    IF      cb_report = "�Ң�"               THEN DO:  
        ASSIGN fi_report = "�Ң�"  .  
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.
    ELSE IF cb_report = "����������������ͧ" THEN DO:  
        ASSIGN fi_report = "������" .   
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_reportdata .
        RETURN NO-APPLY.
    END.
    ELSE DO:
        ASSIGN fi_report  = ""
            fi_reportdata = "" .   
        DISP fi_report WITH FRAM fr_main.
        APPLY "ENTRY" TO fi_filename .
        RETURN NO-APPLY.
    END.
    IF n_asdat2 = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_search c-wins
ON LEAVE OF cb_search IN FRAME fr_main
DO:
    cb_search = INPUT cb_search.
    n_asdat   = INPUT cb_search.

    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��سҵ�Ǩ�ͺ��� Process ������" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
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
    n_asdat   = (INPUT cb_search).
    IF n_asdat = "" THEN DO:
        MESSAGE "��辺������ ��ä�" VIEW-AS ALERT-BOX WARNING.
        RETURN NO-APPLY.
    END.
    /*APPLY "ENTRY" TO fi_comdatF IN FRAME {&FRAME-NAME}.
    RETURN NO-APPLY.*/
    /*-------------p*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comname c-wins
ON LEAVE OF fi_comname IN FRAME fr_main
DO:
    fi_comname = trim( INPUT fi_comname ).
    n_comname  = fi_comname.
    Disp  fi_comname  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename c-wins
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
    fi_filename = INPUT fi_filename.
    DISP fi_filename WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polfr c-wins
ON LEAVE OF fi_polfr IN FRAME fr_main
DO:
    fi_polfr  =  Input  fi_polfr.
    Disp  fi_polfr  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polto c-wins
ON LEAVE OF fi_polto IN FRAME fr_main
DO:
    fi_polto = INPUT fi_polto.
    If  Input  fi_polto  <  fi_polfr  Then  fi_polto  =  fi_polfr.
    Else  fi_polto  =  Input fi_polto.
    Disp  fi_polto  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reportdata
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reportdata c-wins
ON LEAVE OF fi_reportdata IN FRAME fr_main
DO:
    fi_reportdata = trim( INPUT fi_reportdata ).
    Disp  fi_reportdata  with frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_search c-wins
ON LEAVE OF fi_search IN FRAME fr_main
DO:
    fi_search     =  Input  fi_search .
    Disp fi_search  with frame fr_main.
    IF trim(fi_searchcom)  = "" THEN DO:
        If  cb_search =  "�����١���"  Then do:                     /* name  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"       And
                index(tlt.ins_name,trim(fi_search)) <> 0 no-lock. 
                    Apply "Entry"  to br_tlt.
                    Return no-apply.           
        END.
        ELSE If  cb_search  =  "��������"  Then do:                 /* policy */  
            Open Query br_tlt                      
                For each tlt Use-index  tlt01          Where
                tlt.trndat        >=  fi_trndatfr      And 
                tlt.trndat        <=  fi_trndatto      And 
                tlt.genusr         =  "FAX"            And 
                index(tlt.policy,trim(fi_search)) <> 0 NO-LOCK.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "�Ң�"  Then do:                     /* "�Ң�" */ 
            Open Query br_tlt                      
                For each tlt Use-index  tlt01         Where
                tlt.trndat        >=  fi_trndatfr     And 
                tlt.trndat        <=  fi_trndatto     And 
                tlt.genusr         =  "FAX"           And 
                tlt.colorcod       =  trim(fi_search) no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "����¹ö"  Then do:                /* "����¹ö" */ 
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat        >=  fi_trndatfr  And 
                tlt.trndat        <=  fi_trndatto  And 
                tlt.genusr         =  "FAX"        And 
                index(tlt.lince1,trim(fi_search)) <> 0     no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "company"  Then do:                  /* company  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt06      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"     And
                tlt.lotno           =  trim(fi_search)   no-lock.
                    Apply "Entry"  to  br_tlt.     
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "Chassis"  Then do:                 /* chassis...*/
            Open Query br_tlt                      
                For each tlt Use-index  tlt01          Where
                tlt.trndat         >=  fi_trndatfr     And
                tlt.trndat         <=  fi_trndatto     And
                tlt.genusr          =  "FAX"           And
                tlt.cha_no          =  trim(fi_search) no-lock.
                    Apply "Entry"  to br_tlt.  
                    Return no-apply.           
        END.
        ELSE If  cb_search  =  "Complete"  Then do:             /* complete..*/
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"     And
                INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"       And
                INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"     And
                tlt.releas          =  "Yes"       no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"       And
                tlt.releas          =  "No"        no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        Else DO:
            Apply "Entry"  to  fi_searchcom .
            Return no-apply.
        END.
    END.
    ELSE DO:   /*by company ....*/
        If  cb_search =  "�����١���"  Then do:               /* name  */
                Open Query br_tlt                      
                    For each tlt Use-index  tlt01       Where
                    tlt.trndat         >=  fi_trndatfr  And
                    tlt.trndat         <=  fi_trndatto  And
                    tlt.genusr          =  "FAX"      And
                    tlt.lotno           =  trim(fi_searchcom)  AND  
                    index(tlt.ins_name,trim(fi_search)) <> 0 no-lock.
                        Apply "Entry"  to br_tlt.
                        Return no-apply.            
        END.
        ELSE If  cb_search  =  "��������"  Then do:         /* policy */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01           Where
                tlt.trndat        >= fi_trndatfr          And 
                tlt.trndat        <= fi_trndatto          And 
                tlt.genusr         = "FAX"                And 
                tlt.lotno          = trim(fi_searchcom)   AND  
                tlt.policy         = trim(fi_search)      no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "�Ң�"  Then do:             /* "�Ң�" */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01      Where
                tlt.trndat        >= fi_trndatfr  And 
                tlt.trndat        <= fi_trndatto  And 
                tlt.genusr         = "FAX"      And 
                tlt.lotno          = trim(fi_searchcom)   AND  
                tlt.colorcod       = trim(fi_search)    no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "����¹ö"  Then do:         /* "����¹ö" */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01       Where
                tlt.trndat        >= fi_trndatfr          And 
                tlt.trndat        <= fi_trndatto          And 
                tlt.lotno          = trim(fi_searchcom)   AND 
                tlt.genusr         = "FAX"      And 
                index(tlt.lince1,trim(fi_search)) <> 0     no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.  
        ELSE If  cb_search  =  "company"  Then do:         /* company  */
            Open Query br_tlt                      
                For each tlt Use-index  tlt06      Where
                tlt.trndat         >=  fi_trndatfr And
                tlt.trndat         <=  fi_trndatto And
                tlt.genusr          =  "FAX"     And
                tlt.lotno           = trim(fi_searchcom)    no-lock.
                    Apply "Entry"  to  br_tlt.     
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "Chassis"  Then do:         /* chassis...*/
            Open Query br_tlt                      
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.genusr          =  "FAX"      And
                tlt.lotno           = trim(fi_searchcom) AND  
                tlt.cha_no          = trim(fi_search)    no-lock.
                    Apply "Entry"  to br_tlt.  
                    Return no-apply.           
        END.
        ELSE If  cb_search  =  "Complete"  Then do:         /* complete..*/
            Open Query br_tlt                      
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.genusr          =  "FAX"        And
                tlt.lotno           = trim(fi_searchcom)   AND 
                INDEX(tlt.OLD_eng,"not") = 0       no-lock.
                    Apply "Entry"  to br_tlt.      
                    Return no-apply.               
        END.
        ELSE If  cb_search  =  "Not complete"  Then do:         /* not ..complete... */
            Open Query br_tlt                      
                For each tlt Use-index  tlt01       Where
                tlt.trndat         >=  fi_trndatfr  And
                tlt.trndat         <=  fi_trndatto  And
                tlt.genusr          =  "FAX"      And
                tlt.lotno          = trim(fi_searchcom)   AND   
                INDEX(tlt.OLD_eng,"not")  <> 0     no-lock.
                    Apply "Entry"  to br_tlt.
                    Return no-apply.                             
        END.
        ELSE If  cb_search  =  "Release Yes" Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "FAX"      And
                  tlt.lotno          = trim(fi_searchcom)   AND 
                  tlt.releas          =  "Yes"       no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.
          ELSE If  cb_search  =  "Release No"  Then do:         /* not ..complete... */
              Open Query br_tlt                      
                  For each tlt Use-index  tlt01       Where
                  tlt.trndat         >=  fi_trndatfr  And
                  tlt.trndat         <=  fi_trndatto  And
                  tlt.genusr          =  "FAX"      And
                  tlt.lotno          = trim(fi_searchcom)   AND  
                  tlt.releas          =  "No"       no-lock.
                      Apply "Entry"  to br_tlt.
                      Return no-apply.                             
          END.                          
          Else DO:
              Apply "Entry"  to  fi_searchcom .
              Return no-apply.
          END.
          END.
           
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_searchcom
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_searchcom c-wins
ON LEAVE OF fi_searchcom IN FRAME fr_main
DO:
    fi_searchcom     =  INPUT fi_searchcom.
    Disp fi_searchcom  with frame fr_main.
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
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto c-wins
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
  If  Input  fi_trndatto  <  fi_trndatfr  Then  fi_trndatto  =  fi_trndatfr.
  Else  fi_trndatto =  Input  fi_trndatto  .
  Disp  fi_trndatto  with frame fr_main.
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
    ASSIGN 
        gv_prgid = "wgwqufax"
        gv_prog  = "Query & Update DATA Detail By FAX..." .
    RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
    ASSIGN 
        fi_trndatfr = TODAY
        fi_trndatto = TODAY 
        fi_polfr    = ""
        fi_polto    = ""  
        vAcProc_fil = vAcProc_fil   + "�����١���"   + "," 
                                    + "��������"     + "," 
                                    + "�Ң�"         + ","    
                                    + "����¹ö"    + ","   
                                    + "company"      + "," 
                                    + "Chassis"      + "," 
                                    + "Complete"     + "," 
                                    + "Not complete" + "," 
                                    + "Release Yes"  + "," 
                                    + "Release No"   + "," 
                                    
        cb_search:LIST-ITEMS = vAcProc_fil
        cb_search = ENTRY(1,vAcProc_fil)
        vAcProc_fil2 = vAcProc_fil2 + "�Ң�"         + ","    
                                    + "����������������ͧ"    + ","    
                                    + "Complete"     + "," 
                                    + "Not complete" + "," 
                                    + "Release Yes"  + "," 
                                    + "Release No"   + ","
                                    + "All"          + ","
        cb_report:LIST-ITEMS = vAcProc_fil2
        cb_report = ENTRY(1,vAcProc_fil2)
        fi_report =  "�Ң�"   .

    Disp cb_search cb_report fi_trndatfr  fi_trndatto  fi_polfr  fi_polto fi_report    with frame fr_main.
    /*********************************************************************/ 
    /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
    /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
    SESSION:DATA-ENTRY-RETURN = YES.
    
    Rect-333:Move-to-top().
    Rect-338:Move-to-top().  
    RECT-346:Move-to-top(). 
   /* Rect-339:Move-to-top().   */ 
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
  DISPLAY fi_trndatfr fi_trndatto fi_polfr fi_polto cb_search fi_searchcom 
          fi_search fi_comname cb_report fi_reportdata fi_filename fi_report 
      WITH FRAME fr_main IN WINDOW c-wins.
  ENABLE fi_trndatfr fi_trndatto fi_polfr fi_polto bu_ok cb_search fi_searchcom 
         fi_search bu_sch fi_comname cb_report fi_reportdata fi_filename 
         bu_reok br_tlt fi_report bu_exit RECT-332 RECT-333 RECT-338 RECT-340 
         RECT-341 RECT-343 RECT-344 RECT-346 
      WITH FRAME fr_main IN WINDOW c-wins.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-wins.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname1 c-wins 
PROCEDURE proc_ficomname1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH tlt Use-index  tlt01     Where
    tlt.trndat   >=   fi_trndatfr And
    tlt.trndat   <=   fi_trndatto And
    tlt.genusr    =  "FAX"        no-lock.  
    IF      (cb_report = "�Ң�" ) AND (tlt.colorcod <> trim(fi_reportdata))           THEN NEXT.
    ELSE IF (cb_report = "����������������ͧ") AND (tlt.safe3 <> trim(fi_reportdata)) THEN NEXT.
    ELSE IF (cb_report = "Complete" ) AND (index(tlt.OLD_eng,"not") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Not complete") AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "Yes" )         THEN NEXT. 
    ASSIGN  n_record =  n_record + 1.
    EXPORT DELIMITER "|" 
        n_record                                        /*"�ӴѺ���"      */            
        string(tlt.trndat,"99/99/9999") FORMAT "x(10)"  /*"�ѹ����Ѻ��" */        
        string(tlt.trntime)             FORMAT "x(10)"  /*"�����Ѻ��"   */         
        trim(tlt.nor_noti_tlt)          FORMAT "x(50)"  /*"�Ţ�Ѻ�駧ҹ" */       
        trim(tlt.lotno)                 FORMAT "x(20)"  /*"���ʺ��ѷ" */           
        trim(tlt.nor_usr_ins)           FORMAT "x(40)"  /*"�������˹�ҷ�� MKT"*/ 
        trim(tlt.nor_usr_tlt)           FORMAT "x(10)"  /*"�����Ң�"             */             
        trim(tlt.nor_noti_ins)          FORMAT "x(35)"  /*"Code: "               */                       
        trim(tlt.colorcod)              FORMAT "x(2)"   /*"�����Ң�_STY "*/               
        trim(tlt.comp_sub)              FORMAT "x(20)"  /*"Producer." */           
        trim(tlt.recac)                 FORMAT "x(20)"  /*"Agent." */  
        TRIM(tlt.rec_addr4)             FORMAT "x(20)"  /*Deler */
        trim(tlt.subins)                FORMAT "x(30)"  /* "Campaign no." */ 
        tlt.safe1                                       /*"��������Сѹ"*/
        tlt.safe2                                       /*"������ö"*/          
        tlt.safe3                                       /*"����������������ͧ"*/
        tlt.stat
        tlt.filler1                                     /*"��Сѹ ��/�����"*/ 
        tlt.filler2                                     /*"�ú.   ��/�����"*/
        tlt.nor_effdat                                  /*"�ѹ�����������ͧ"       */
        tlt.expodat                                     /*"�ѹ����ش����������ͧ" */
        tlt.dri_no2                                     /*  A55-0046.....*/
        tlt.policy                                      /*"�Ţ��������70"*/    
        tlt.comp_pol                                    /*"�Ţ��������72"*/   
        substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 ) FORMAT "x(20)" /*"�ӹ�˹�Ҫ���"*/     
        substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1 )  FORMAT "x(35)"  /*"���ͼ����һ�Сѹ"*/ 
        trim(tlt.endno)                                                                /*id no */
        IF tlt.dat_ins_noti = ? THEN "" ELSE trim(string(tlt.dat_ins_noti))            /*birth of date. */
        IF tlt.entdat = ?       THEN "" ELSE TRIM(STRING(tlt.entdat))
        trim(tlt.flag)            /*occup */
        trim(tlt.usrsent)         /*Name drirect */
        trim(tlt.ins_addr1)       /*"��ҹ�Ţ���" */      
        trim(tlt.ins_addr2)       /*"�Ӻ�/�ǧ" */
        trim(tlt.ins_addr3)       /*"�����/ࢵ"*/        
        trim(tlt.ins_addr4)       /*"�ѧ��Ѵ" */
        trim(tlt.ins_addr5)       /*"������ɳ���"*/         
        tlt.comp_noti_ins         /*"�������Ѿ��" */ 
        IF tlt.dri_name1 = "" THEN "����кؼ��Ѻ���" ELSE "�кؼ��Ѻ���"
     /*drivname  "���Ѻ��褹���1"1*/    IF tlt.dri_name1 = "" THEN  "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
     /*sex       "��"            1*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "�ѹ�Դ"        1*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "�ҪѾ"          1*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "�Ţ���㺢Ѻ���" 1*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.dri_no1)
     /*drivname "���Ѻ��褹���2" 2*/    IF tlt.dri_name1 = "" THEN  "" ELSE  SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
     /*sex      "��"             2*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"�ѹ�Դ"         2*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "�ҪѾ"           2*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )   
     /*id driv  "�Ţ���㺢Ѻ���"  2*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.expotim) 
        tlt.brand                                                       /*"����������ö"*/         
        tlt.model                                                       /*"���ö" */              
        tlt.eng_no                                                      /*"�Ţ����ͧ¹��" */
        tlt.cha_no                                                      /*"�Ţ��Ƕѧ" */           
        tlt.cc_weight                                                   /*"�ի�" */               
        tlt.lince2                                                      /*"��ö¹��"*/            
        substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(8)"  /*"�Ţ����¹"   *//*A54-0112*/
        substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1) FORMAT "x(30)"   /*"�ѧ��Ѵ��訴����¹"*/ 
        tlt.lince3                      /*"ᾤࡨ"*/
        tlt.exp                         /*"��ë���" */                                 
        tlt.nor_coamt                   /*"�ع��Сѹ"*/  
        tlt.dri_name2  FORMAT "x(30)"
        tlt.nor_grprm                   /*"���»�Сѹ" */                             
        tlt.comp_coamt                  /*"���¾ú." */      
        tlt.comp_grprm                  /*"�������"*/        
        tlt.comp_sck                    /*"�Ţʵ������" */  
        tlt.comp_noti_tlt               /*"�ŢReferance no."*/
        tlt.rec_name                    /*"�͡�����㹹��"*/ 
        tlt.comp_usr_tlt                /*"Vatcode " */
        tlt.expousr                     /*"����Ѻ��"             */
        tlt.comp_usr_ins                /*"����Ѻ�Ż���ª��"       */
        tlt.OLD_cha                     /*"�����˵�"               */
        tlt.OLD_eng                     /*"complete/not complete"  */ 
        tlt.releas.                     
END.                                    /*  end  wdetail  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_ficomname2 c-wins 
PROCEDURE proc_ficomname2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH tlt Use-index  tlt01  Where
    tlt.trndat        >=   fi_trndatfr   And
    tlt.trndat        <=   fi_trndatto   And
    tlt.lotno          =   n_comname     AND
    tlt.genusr         =  "fax"          no-lock.  
    IF      (cb_report = "�Ң�" ) AND (tlt.colorcod <> trim(fi_reportdata))           THEN NEXT.
    ELSE IF (cb_report = "����������������ͧ") AND (tlt.safe3 <> trim(fi_reportdata)) THEN NEXT.
    ELSE IF (cb_report = "Complete" ) AND (index(tlt.OLD_eng,"not") = 0 )  THEN NEXT.
    ELSE IF (cb_report = "Not complete") AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release Yes" ) AND (tlt.releas = "No" )          THEN NEXT.
    ELSE IF (cb_report = "Release No"  ) AND (tlt.releas = "Yes")          THEN NEXT. 
    ASSIGN 
        n_record =  n_record + 1.
    EXPORT DELIMITER "|" 
    n_record                                        /*"�ӴѺ���"      */            
    string(tlt.trndat,"99/99/9999") FORMAT "x(10)"  /*"�ѹ����Ѻ��" */        
    string(tlt.trntime)             FORMAT "x(10)"  /*"�����Ѻ��"   */         
    trim(tlt.nor_noti_tlt)          FORMAT "x(50)"  /*"�Ţ�Ѻ�駧ҹ" */       
    trim(tlt.lotno)                 FORMAT "x(20)"  /*"���ʺ��ѷ" */           
    trim(tlt.nor_usr_ins)           FORMAT "x(40)"  /*"�������˹�ҷ�� MKT"*/ 
    trim(tlt.nor_usr_tlt)           FORMAT "x(10)"  /*"�����Ң�"             */             
    trim(tlt.nor_noti_ins)          FORMAT "x(35)"  /*"Code: "               */                       
    trim(tlt.colorcod)              FORMAT "x(2)"   /*"�����Ң�_STY "*/               
    trim(tlt.comp_sub)              FORMAT "x(20)"  /*"Producer." */           
    trim(tlt.recac)                 FORMAT "x(20)"  /*"Agent." */              
    TRIM(tlt.rec_addr4)             FORMAT "x(20)"  /*Deler */
    trim(tlt.subins)                FORMAT "x(30)"  /* "Campaign no." */ 
    tlt.safe1                                       /*"��������Сѹ"*/
    tlt.safe2                                       /*"������ö"*/          
    tlt.safe3                                       /*"����������������ͧ"*/
    tlt.stat
    tlt.filler1                                     /*"��Сѹ ��/�����"*/ 
    tlt.filler2                                     /*"�ú.   ��/�����"*/
    tlt.nor_effdat            /*"�ѹ�����������ͧ"       */
    tlt.expodat               /*"�ѹ����ش����������ͧ" */
    tlt.dri_no2               /*  A55-0046.....*/
    tlt.policy                /*"�Ţ��������70"*/    
    tlt.comp_pol              /*"�Ţ��������72"*/   
    substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 ) FORMAT "x(20)"       /*"�ӹ�˹�Ҫ���"*/     
    substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1 )  FORMAT "x(35)"        /*"���ͼ����һ�Сѹ"*/ 
    trim(tlt.endno)            /*id no */                                               
    IF tlt.dat_ins_noti = ? THEN "" ELSE trim(string(tlt.dat_ins_noti))  /*birth of date. */
    IF tlt.entdat = ?       THEN "" ELSE TRIM(STRING(tlt.entdat))        /*birth of date. */
    trim(tlt.flag)            /*occup */
    trim(tlt.usrsent)         /*Name drirect */
    trim(tlt.ins_addr1)       /*"��ҹ�Ţ���" */      
    trim(tlt.ins_addr2)       /*"�Ӻ�/�ǧ" */
    trim(tlt.ins_addr3)       /*"�����/ࢵ"*/        
    trim(tlt.ins_addr4)       /*"�ѧ��Ѵ" */
    trim(tlt.ins_addr5)       /*"������ɳ���"*/         
    tlt.comp_noti_ins         /*"�������Ѿ��" */  
    IF tlt.dri_name1 = "" THEN "����кؼ��Ѻ���" ELSE "�кؼ��Ѻ���"
     /*drivname  "���Ѻ��褹���1"1*/    IF tlt.dri_name1 = "" THEN  "" ELSE SUBSTR(tlt.dri_name1,1,INDEX(tlt.dri_name1,"sex:") - 1 )
     /*sex       "��"            1*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.dri_name1,INDEX(tlt.dri_name1,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day "�ѹ�Դ"        1*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.dri_name1,INDEX(tlt.dri_name1,"hbd:") + 4 ,10))
     /*occup     "�ҪѾ"          1*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.dri_name1,INDEX(tlt.dri_name1,"occ:") + 4 )   
     /*id driv   "�Ţ���㺢Ѻ���" 1*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.dri_no1)
     /*drivname "���Ѻ��褹���2" 2*/    IF tlt.dri_name1 = "" THEN  "" ELSE  SUBSTR(tlt.enttim,1,INDEX(tlt.enttim,"sex:") - 1 )
     /*sex      "��"             2*/    IF tlt.dri_name1 = "" THEN  "" ELSE IF trim(substr(tlt.enttim,INDEX(tlt.enttim,"sex:") + 4,1)) =  "2" THEN "FEMALE" ELSE "MALE"
     /*birth day"�ѹ�Դ"         2*/    IF tlt.dri_name1 = "" THEN  "" ELSE (SUBSTR(tlt.enttim,INDEX(tlt.enttim,"hbd:") + 4 ,10)) 
     /*occup    "�ҪѾ"           2*/    IF tlt.dri_name1 = "" THEN  "" ELSE substr(tlt.enttim,INDEX(tlt.enttim,"occ:") + 4 )   
     /*id driv  "�Ţ���㺢Ѻ���"  2*/    IF tlt.dri_name1 = "" THEN  "" ELSE trim(tlt.expotim)   
    tlt.brand                 /*"����������ö"*/         
    tlt.model                 /*"���ö" */              
    tlt.eng_no                /*"�Ţ����ͧ¹��" */
    tlt.cha_no                /*"�Ţ��Ƕѧ" */           
    tlt.cc_weight             /*"�ի�" */               
    tlt.lince2                /*"��ö¹��"*/            
    /*substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(7)"  /*"�Ţ����¹"  */*//*A54-0112*/ 
    substr(tlt.lince1,1,R-INDEX(tlt.lince1," ") - 1) FORMAT "x(8)"  /*"�Ţ����¹"  *//*A54-0112*/
    substr(tlt.lince1,R-INDEX(tlt.lince1," ") + 1) FORMAT "x(30)"    /*"�ѧ��Ѵ��訴����¹"*/ 
    tlt.lince3                /*"ᾤࡨ"*/
    tlt.exp                   /*"��ë���" */                                 
    tlt.nor_coamt             /*"�ع��Сѹ"*/  
    tlt.dri_name2  FORMAT "x(30)"
    tlt.nor_grprm             /*"���»�Сѹ" */                             
    tlt.comp_coamt            /*"���¾ú." */      
    tlt.comp_grprm            /*"�������"*/        
    tlt.comp_sck              /*"�Ţʵ������" */  
    tlt.comp_noti_tlt         /*"�ŢReferance no."*/
    tlt.rec_name              /*"�͡�����㹹��"*/ 
    tlt.comp_usr_tlt          /*"Vatcode " */
    tlt.expousr               /*"����Ѻ��"             */
    tlt.comp_usr_ins          /*"����Ѻ�Ż���ª��"       */
    tlt.OLD_cha               /*"�����˵�"               */
    tlt.OLD_eng               /*"complete/not complete"  */ 
    tlt.releas. 
END.                         /*  end  wdetail  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report c-wins 
PROCEDURE proc_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
/*OUTPUT STREAM ns2 TO VALUE(fi_filename).*/
OUTPUT TO VALUE(fi_filename). 
EXPORT DELIMITER "|" 
    "�����ŧҹ�Ѻ��Сѹ��·ҧῡ�� ." .
EXPORT DELIMITER "|" 
    "�ӴѺ���"   
    "�ѹ����Ѻ��" 
    "�����Ѻ��" 
    "�Ţ�Ѻ�駧ҹ"  
    "���ʺ��ѷ" 
    "�������˹�ҷ�� MKT"  
    "�����Ң�" 
    "Code: "
    "�����Ң�_STY "
    "Producer."
    "Agent."
    "Deler"
    "Campaign no."                         
    "��������Сѹ"                     
    "������ö" 
    "����������������ͧ"  
    "Product Type"
    "��Сѹ ��/�����" 
    "�ú.   ��/�����" 
    "�ѹ�����������ͧ"   
    "�ѹ����ش����������ͧ" 
    "�Ţ��Ǩ��Ҿ"            /*A55-0046*/
    "�Ţ��������70"  
    "�Ţ��������72"    
    "�ӹ�˹�Ҫ���"                     
    "���ͼ����һ�Сѹ" 
    "�Ţ���ѵû�ЪҪ�"     /*id no */
    "�ѹ�Դ"               /*birth of date. */
    "�ѹ���ѵ��������"
    "�Ҫվ"                 /*occup */
    "���͡������"           /*Name drirect */
    "��ҹ�Ţ���"                       
    "�Ӻ�/�ǧ"                        
    "�����/ࢵ"                        
    "�ѧ��Ѵ"                          
    "������ɳ���"  
    "�������Ѿ��" 
    "�кؼ��Ѻ���/����кؼ��Ѻ���" 
    "���Ѻ��褹���1"                  /*drivname  1*/
    "��"                              /*sex       1*/
    "�ѹ�Դ"                          /*birth day 1*/
    "�ҪѾ"                            /*occup     1*/
    "�Ţ���㺢Ѻ���"                   /*id driv   1*/
    "���Ѻ��褹���1"                  /*drivname  2*/
    "��"                              /*sex       2*/
    "�ѹ�Դ"                          /*birth day 2*/
    "�ҪѾ"                            /*occup     2*/
    "�Ţ���㺢Ѻ���"                   /*id driv   2*/
    "����������ö"                     
    "���ö" 
    "�Ţ����ͧ¹��"
    "�Ţ��Ƕѧ" 
    "�ի�" 
    "��ö¹��"            
    "�Ţ����¹"  
    "�ѧ��Ѵ��訴����¹"
    "ᾤࡨ"
    "��ë���"
    "�ع��Сѹ" 
    "�����ط��"
    "���»�Сѹ" 
    "���¾ú."
    "�������" 
    "�Ţʵ������"   
    "�ŢReferance no." 
    "�͡�����㹹��" 
    "Vatcode "  
    "����Ѻ��"
    "����Ѻ�Ż���ª��" 
    "�����˵�"                           
    "complete/not complete"
    "Yes/No" .  
IF n_comname = "" THEN RUN proc_ficomname1.
ELSE RUN proc_ficomname2.

Message "Export data Complete"  View-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-wins 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .
If  substr(fi_filename,length(fi_filename) - 3,4) <>  ".csv"  THEN 
    fi_filename  =  Trim(fi_filename) + ".csv"  .

ASSIGN nv_cnt  =  0
       nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_filename).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "����ѷ�Թ�ع ��Ҥ�����õԹҤԹ �ӡѴ (��Ҫ�) ."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "�ӴѺ���"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "�ѹ����Ѻ��"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "�ѹ����Ѻ�Թ������»�Сѹ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "��ª��ͺ���ѷ��Сѹ���"             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "�Ţ����ѭ����ҫ���"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "�Ţ�������������"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "�����Ң�"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "�Ң� KK"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "�Ţ�Ѻ���"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "Campaign"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Sub Campaign"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "�ؤ��/�ԵԺؤ��"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "�ӹ�˹�Ҫ���"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "���ͼ����һ�Сѹ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "���ʡ�ż����һ�Сѹ"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "��ҹ�Ţ���"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "�Ӻ�/�ǧ"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "�����/ࢵ"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "�ѧ��Ѵ"                            '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "������ɳ���"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "����������������ͧ"                 '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "��������ë���"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "�ѹ�����������ͧ"                   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "�ѹ����ش������ͧ"                 '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "����ö"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "��������Сѹ���ö¹��"              '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "����������ö"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "���ö"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "New/Used"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "�Ţ����¹"                         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "�Ţ��Ƕѧ"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "�Ţ����ͧ¹��"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "��ö¹��"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "�ի�"                               '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K"  '"' "���˹ѡ/�ѹ"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K"  '"' "�ع��Сѹ�� 1 "                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K"  '"' "����������������ҡû� 1"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K"  '"' "�ع��Сѹ�� 2"                      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K"  '"' "����������������ҡû� 2"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K"  '"' "�����Ѻ���"                       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K"  '"' "�������˹�ҷ�� MKT"                '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K"  '"' "�����˵�"                           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K"  '"' "���Ѻ����� 1 �����ѹ�Դ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K"  '"' "���Ѻ����� 2 �����ѹ�Դ"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K"  '"' "�ӹ�˹�Ҫ��� (�����/㺡ӡѺ����)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K"  '"' "���� (�����/㺡ӡѺ����)"         '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K"  '"' "���ʡ�� (�����/㺡ӡѺ����)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K"  '"' "��ҹ�Ţ��� (�����/㺡ӡѺ����)"   '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K"  '"' "�Ӻ�/�ǧ (�����/㺡ӡѺ����)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K"  '"' "�����/ࢵ (�����/㺡ӡѺ����)"    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K"  '"' "�ѧ��Ѵ (�����/㺡ӡѺ����)"      '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K"  '"' "������ɳ��� (�����/㺡ӡѺ����)" '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K"  '"' "��ǹŴ����ѵԴ�"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K"  '"' "��ǹŴ�ҹ Fleet"                    '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K"  '"' "Remak1"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K"  '"' "Remak2"                             '"' SKIP.

FOR EACH tlt Use-index  tlt01  Where
        tlt.trndat        >=   fi_trndatfr   And
        tlt.trndat        <=   fi_trndatto   And
        /*tlt.comp_noti_tlt >=   fi_polfr      And
        tlt.comp_noti_tlt <=   fi_polto      And*/
        tlt.genusr   =  "phone"                no-lock.  
    /*IF      (ra_report = 1) AND (tlt.lotno <> fi_comname ) THEN NEXT.
    ELSE IF (ra_report = 2) AND (index(tlt.OLD_eng,"not")  <> 0 ) THEN NEXT.
    ELSE IF (ra_report = 3) AND (index(tlt.OLD_eng,"not") = 0 )   THEN NEXT.*/
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' n_record                                            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"' string(tlt.trndat,"99/99/9999")      FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"' string(tlt.dat_ins_not,"99/99/9999") FORMAT "x(10)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"' trim(tlt.nor_usr_ins)                FORMAT "x(50)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"' trim(tlt.nor_noti_tlt)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"' trim(tlt.nor_noti_ins)               FORMAT "x(20)" '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"' trim(tlt.nor_usr_tlt)                FORMAT "x(10)" '"' SKIP.        
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"' trim(tlt.comp_usr_tl)                FORMAT "x(35)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"' trim(tlt.comp_noti_tlt)              FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"' trim(tlt.dri_no1)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"' trim(tlt.dri_no2)                    FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"' trim(tlt.safe2)                      FORMAT "x(30)" '"' SKIP.      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"' substr(trim(tlt.ins_name),1,INDEX(trim(tlt.ins_name)," ") - 1 )         FORMAT "x(20)" '"' SKIP.                
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"' substr(trim(tlt.ins_name),INDEX(trim(tlt.ins_name)," ") + 1,r-INDEX(trim(tlt.ins_name)," ") - INDEX(trim(tlt.ins_name)," "))  FORMAT "x(35)" '"' SKIP.                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"' substr(trim(tlt.ins_name),r-INDEX(trim(tlt.ins_name)," ") + 1 )         FORMAT "x(35)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"' trim(tlt.ins_addr1)                 FORMAT "x(80)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"' trim(tlt.ins_addr2)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"' trim(tlt.ins_addr3)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"' trim(tlt.ins_addr4)                 FORMAT "x(40)" '"' SKIP.                   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"' trim(tlt.ins_addr5)                 FORMAT "x(15)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"' trim(tlt.safe3)                                    '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"' trim(tlt.stat)                      FORMAT "x(30)" '"' SKIP.     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"' string(tlt.nor_effdat,"99/99/9999") FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"' string(tlt.expodat,"99/99/9999")    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"' trim(tlt.subins)                    FORMAT "x(10)" '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"' trim(tlt.filler2)                   FORMAT "x(40)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"' trim(tlt.brand)                     FORMAT "x(30)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"' trim(tlt.model)                     FORMAT "x(45)" '"' SKIP.              
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"' trim(tlt.filler1)                   FORMAT "x(20)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"' trim(tlt.lince1)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"' trim(tlt.cha_no)                    FORMAT "x(30)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"' trim(tlt.eng_no)                    FORMAT "x(30)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"' trim(tlt.lince2)                    FORMAT "x(10)" '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"' string(tlt.cc_weight)               FORMAT "x(10)" '"' SKIP.               
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"' trim(tlt.colorcod)                  FORMAT "x(10)" '"' SKIP.                 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"' string(tlt.comp_coamt)              '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"' string(tlt.comp_grprm)              '"' SKIP.                                    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"' string(tlt.nor_coamt)               '"' SKIP.                                     
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"' string(tlt.nor_grprm)               '"' SKIP.                                      
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"' string(tlt.gentim)                  FORMAT "x(10)"     '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"' trim(tlt.comp_usr_in)               FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"' trim(tlt.safe1)                     FORMAT "x(100)"     '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"' trim(tlt.dri_name1)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"' trim(tlt.dri_name2)                 FORMAT "x(50)"     '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"' trim(tlt.rec_name)             '"' SKIP.                            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"' ""                             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"' ""                             '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"' trim(tlt.rec_addr1)            '"' SKIP.            
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"' trim(tlt.rec_addr2)            '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"' trim(tlt.rec_addr3)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"' trim(tlt.rec_addr4)            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"' trim(tlt.rec_addr5)            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"' string(tlt.seqno)              '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"' tlt.lotno                      '"' SKIP.    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"' trim(tlt.OLD_eng)       FORMAT "x(100)"  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"' trim(tlt.OLD_cha)       FORMAT "x(100)"  '"' SKIP.
END.   /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".

OUTPUT STREAM ns2 CLOSE.  

Message "Export data Complete"  View-as alert-box.

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
    For each tlt Use-index  tlt01 NO-LOCK 
    WHERE 
    tlt.trndat         >=  fi_trndatfr   And
    tlt.trndat         <=  fi_trndatto   And
    tlt.comp_noti_tlt  >=  fi_polfr      And
    tlt.comp_noti_tlt  <=  fi_polto      And
    tlt.genusr   =  "fax"         .
        
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

