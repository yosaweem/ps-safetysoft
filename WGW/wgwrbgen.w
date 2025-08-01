&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
sic_test         PROGRESS  */
File: 
Description: 
Input Parameters:
<none>
Output Parameters:
<none>
Author: 
Created: 
/*programid   : wgwrbgen.w                                              */  
/*programname : Load Text & Generate text file Rabbit                   */  
/*Copyright   : Safety Insurance Public Company Limited                 */  
/*              ����ѷ ��Сѹ������� �ӡѴ (��Ҫ�)                      */  
/*create by   : Kridtiya i. A64-0325 date. 21/08/2021                  
                ��Ѻ������������ö����� Load Text & Generate data    */ 
/************************************************************************/
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
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
/************************************************************************/   
DEF SHARED Var n_User         As CHAR .
DEF SHARED Var n_PassWd       As CHAR .
{wgw\wgwrbgen.i}                                   /*��С�ȵ����*/
DEF VAR        nv_daily       AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEF VAR        nv_reccnt      AS INT   INIT  0.          
DEF VAR        nv_completecnt AS INT   INIT  0.          
DEF VAR        gv_id          AS CHAR  FORMAT "X(15)" NO-UNDO.
DEF VAR        nv_pwd         AS CHAR  FORMAT "X(15)" NO-UNDO.
DEF VAR        s_riskgp       AS INTE  FORMAT ">9".
DEF VAR        s_riskno       AS INTE  FORMAT "999".
DEF VAR        s_itemno       AS INTE  FORMAT "999". 
DEF VAR        nv_undyr       as char  init  ""       format   "X(4)".
DEF VAR        n_rencnt       as int   init  0. 
DEF VAR        nv_index       as int   init  0. 
DEF VAR        n_endcnt       as int   init  0. 
DEFINE STREAM  ns1. 
DEFINE STREAM  ns2.
DEFINE STREAM  ns3.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_wdetail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdetail

/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.ContractNumber wdetail.BranchCd wdetail.EffectiveDt wdetail.ExpirationDt wdetail.PolicyTypeCd wdetail.RateGroup wdetail.CMIEffectiveDt wdetail.CMIExpirationDt wdetail.CMIPolicyTypeCd wdetail.CMIVehTypeCd   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y"
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_wdetail fi_company fi_loaddat fi_branch ~
fi_producer fi_agent bu_file fi_filename fi_output1 fi_output2 fi_output3 ~
fi_usrcnt bu_hpbrn bu_hpacno1 bu_hpagent buok bu_exit fi_process fi_usrprem ~
RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_company fi_loaddat fi_branch ~
fi_producer fi_agent fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt ~
fi_brndes fi_proname fi_agtname fi_process fi_usrprem fi_impcnt ~
fi_completecnt fi_premtot fi_premsuc 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 5 BY .91.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .81.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .81.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 5 BY .81.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .81
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY .81
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_company AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .81
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY .81
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .81
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .81
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 80 BY .81
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY .81
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .81
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11 BY .81
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .81
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 107 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 107 BY 10.81
     BGCOLOR 18 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 107 BY 5.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 107 BY 2.62
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 105 BY 2.24
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.67
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.ContractNumber  COLUMN-LABEL "ContractNumber " 
      wdetail.BranchCd        COLUMN-LABEL "BranchCd       "  
      wdetail.EffectiveDt     COLUMN-LABEL "EffectiveDt    "   
      wdetail.ExpirationDt    COLUMN-LABEL "ExpirationDt   " 
      wdetail.PolicyTypeCd    COLUMN-LABEL "PolicyTypeCd   " 
      wdetail.RateGroup       COLUMN-LABEL "RateGroup      " 
      wdetail.CMIEffectiveDt  COLUMN-LABEL "CMIEffectiveDt " 
      wdetail.CMIExpirationDt COLUMN-LABEL "CMIExpirationDt" 
      wdetail.CMIPolicyTypeCd COLUMN-LABEL "CMIPolicyTypeCd" 
      wdetail.CMIVehTypeCd    COLUMN-LABEL "CMIVehTypeCd   "
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 105 BY 4.71
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_wdetail AT ROW 13.76 COL 2
     fi_company AT ROW 2.76 COL 23.5 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_loaddat AT ROW 3.67 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4.57 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.48 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.38 COL 23.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 7.33 COL 86.33
     fi_filename AT ROW 7.33 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_output1 AT ROW 8.24 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 9.14 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 10.05 COL 23.5 COLON-ALIGNED NO-LABEL
     fi_usrcnt AT ROW 11 COL 23.5 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 4.57 COL 31.17
     fi_brndes AT ROW 4.57 COL 34.33 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 5.48 COL 43
     bu_hpagent AT ROW 6.38 COL 43
     fi_proname AT ROW 5.48 COL 45.83 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 6.38 COL 45.83 COLON-ALIGNED NO-LABEL
     buok AT ROW 8.81 COL 88.17
     bu_exit AT ROW 10.52 COL 88.17
     fi_process AT ROW 12.14 COL 2.5 NO-LABEL
     fi_usrprem AT ROW 11 COL 61.17 NO-LABEL
     fi_impcnt AT ROW 19.43 COL 43.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_completecnt AT ROW 20.33 COL 43.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 19.43 COL 78.5 NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 20.33 COL 76.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     ":���ʺ���ѷ RABBIT" VIEW-AS TEXT
          SIZE 26 BY .95 AT ROW 2.71 COL 43 WIDGET-ID 20
          BGCOLOR 18 
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .81 AT ROW 19.43 COL 44 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "         Producer Code :" VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 5.48 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "               Load Date :":35 VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 3.67 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 22 BY .81 AT ROW 19.43 COL 77 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 11 COL 24 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 8.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .81 AT ROW 20.33 COL 97.17
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 9.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY .81 AT ROW 11 COL 80.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .81 AT ROW 20.33 COL 44 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "                 Company :":35 VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 2.76 COL 2.5 WIDGET-ID 16
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "              Agent Code :" VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 6.38 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 10.05 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 108 BY 21
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 7.33 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 09/01/2022" VIEW-AS TEXT
          SIZE 18.5 BY .95 AT ROW 12.19 COL 86.5 WIDGET-ID 22
          BGCOLOR 18 
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22 BY .81 AT ROW 20.33 COL 77 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 24 BY .81 AT ROW 11 COL 59.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "LOAD TEXT FILE MOTOR RABBIT" VIEW-AS TEXT
          SIZE 103 BY .81 AT ROW 1.33 COL 2.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .81 AT ROW 19.43 COL 97.17
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "                    Branch :" VIEW-AS TEXT
          SIZE 22.5 BY .81 AT ROW 4.57 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1
     RECT-373 AT ROW 13.48 COL 1
     RECT-374 AT ROW 19 COL 1
     RECT-375 AT ROW 19.14 COL 2
     RECT-377 AT ROW 8.48 COL 86.5
     RECT-378 AT ROW 10.24 COL 86.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 108 BY 21
         BGCOLOR 3 FONT 6.


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
  CREATE WINDOW c-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "LOAD TEXT FILE MOTOR RABBIT"
         HEIGHT             = 21
         WIDTH              = 108
         MAX-HEIGHT         = 34.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 34.33
         VIRTUAL-WIDTH      = 170.67
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_wdetail 1 fr_main */
ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brndes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtot IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 22.5 BY .81 AT ROW 11 COL 24 RIGHT-ALIGNED               */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 24 BY .81 AT ROW 11 COL 59.83 RIGHT-ALIGNED              */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .81 AT ROW 19.43 COL 44 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 22 BY .81 AT ROW 19.43 COL 77 RIGHT-ALIGNED              */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .81 AT ROW 20.33 COL 44 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22 BY .81 AT ROW 20.33 COL 77 RIGHT-ALIGNED              */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* LOAD TEXT FILE MOTOR RABBIT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* LOAD TEXT FILE MOTOR RABBIT */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail c-Win
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    /*IF WDETAIL.WARNING <> "" THEN DO:*/
        wdetail.ContractNumber :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.BranchCd       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.EffectiveDt    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.ExpirationDt   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.PolicyTypeCd   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.RateGroup      :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.CMIEffectiveDt :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.CMIExpirationDt:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CMIPolicyTypeCd:BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.CMIVehTypeCd   :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        
        wdetail.ContractNumber :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.BranchCd       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.EffectiveDt    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.ExpirationDt   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.PolicyTypeCd   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.RateGroup      :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.CMIEffectiveDt :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.CMIExpirationDt:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.CMIPolicyTypeCd:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.CMIVehTypeCd   :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 

    /*END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    ASSIGN
        fi_process             = "LOAD TEXT FILE MOTOR TESCO LOTUS"
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_premtot             = 0
        fi_impcnt              = 0.
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
    IF fi_branch = " " THEN DO: 
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_producer = " " THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer.
        RETURN NO-APPLY.
    END.
    IF fi_agent = " " THEN DO:
        MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_Agent.
        RETURN NO-APPLY.
    END.
    IF fi_loaddat = ? THEN DO:
        MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_loaddat.
        RETURN NO-APPLY.
    END.
    ASSIGN
        fi_output1 = INPUT fi_output1
        fi_output2 = INPUT fi_output2
        fi_output3 = INPUT fi_output3.
    IF fi_output1 = "" THEN DO:
        MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output1.
        RETURN NO-APPLY.
    END.
    IF fi_output2 = "" THEN DO:
        MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output2.
        RETURN NO-APPLY.
    END.
    IF fi_output3 = "" THEN DO:
        MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output3.
        RETURN NO-APPLY.
    END.
    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
        fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
        nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
        nv_tmppolrun = 0                    nv_daily        = "" 
        nv_reccnt    = 0                    nv_completecnt  = 0
        nv_netprm_t  = 0                    nv_netprm_s     = 0
        nv_batbrn    = fi_branch .
    
    For each  wdetail :
        DELETE  wdetail.
    END.
    RUN proc_assignVMI.  /* ������  */
    FOR EACH wdetail :
        IF wdetail.CMIPolicyTypeCd  = "�ú"     OR wdetail.PolicyTypeCd  <> "" THEN DO:
            ASSIGN 
                nv_reccnt      =  nv_reccnt   + 1  
                wdetail.pass   = "Y". 
            IF   wdetail.PolicyTypeCd  = "1"   OR 
                 wdetail.PolicyTypeCd  = "2"   OR
                 wdetail.PolicyTypeCd  = "3"   OR
                 wdetail.PolicyTypeCd  = "2.1" OR
                 wdetail.PolicyTypeCd  = "2.2" OR
                 wdetail.PolicyTypeCd  = "3.1" OR
                 wdetail.PolicyTypeCd  = "3.2"   THEN 
                 nv_netprm_t    =  nv_netprm_t + decimal(wdetail.CurrentTermAmt).
            ELSE nv_netprm_t    =  nv_netprm_t + decimal(wdetail.CMICurrentTermAmt).
        END.
        ELSE DELETE WDETAIL.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    RUN proc_chktest1. 
    FOR EACH wdetail  NO-LOCK.
        IF wdetail.pass = "y" THEN DO:
            nv_batflg = YES .
            ASSIGN nv_completecnt = nv_completecnt + 1.
            IF   wdetail.PolicyTypeCd  <> "" THEN 
                 nv_netprm_s    =  nv_netprm_s + decimal(wdetail.CurrentTermAmt).       
            ELSE nv_netprm_s    =  nv_netprm_s + decimal(wdetail.CMICurrentTermAmt).    
        END.
        ELSE nv_batflg = NO.
    END.
    nv_rectot = nv_reccnt .      
    nv_recsuc = nv_completecnt . 
    IF   nv_netprm_t <> nv_netprm_s THEN nv_batflg = NO.
    ELSE nv_batflg = YES.
    IF nv_rectot <> nv_recsuc   THEN nv_batflg = NO.
    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .
    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6   . 
        fi_process = "Please check Data again." .
        DISP fi_completecnt fi_premsuc fi_process WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
            "Batch No.   : " nv_batchno             SKIP
            "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
            TRIM(nv_txtmsg)                         SKIP
            "Please check Data again."      
            VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2  .
        fi_process = "Process Complete"    .
        DISP fi_process WITH FRAM fr_main.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    IF CONNECTED("BUInt") THEN DISCONNECT BUInt.
    RUN proc_open.   
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  . 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "Text Documents" "*.csv"*/
       "CSV (Comma Delimited)"   "*.csv"   /*,
                            "Data Files (*.dat)"     "*.dat",
                    "Text Files (*.txt)" "*.txt"*/
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 c-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent c-Win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
    Run  whp\whpbrn01(Input-output  fi_branch,   
                      Input-output  fi_brndes).
    Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
    Apply "Entry"  To  fi_producer.
    Return no-apply.                            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600.."  View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.  
        END.
        ELSE   
            ASSIGN  
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent) .   
    END.
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch c-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
    fi_branch = caps(INPUT fi_branch) .
    IF  Input fi_branch  =  ""  Then do:
        Message "��س��к� Branch Code ." View-as alert-box.
        Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            sicsyac.xmm023.branch   = TRIM(Input fi_branch)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023" View-as alert-box.
            Apply "Entry"  To  fi_branch.
            RETURN NO-APPLY.
        END.
        ELSE 
            ASSIGN fi_branch  =  CAPS(Input fi_branch) 
                fi_brndes  =  sicsyac.xmm023.bdes.
    END.    /*else do:*/
    Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_company
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_company c-Win
ON LEAVE OF fi_company IN FRAME fr_main
DO:
    fi_company = caps(INPUT fi_company) .
    
    Disp fi_company  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat c-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp  fi_loaddat with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.    /*note add on 10/11/2005*/
        END.
        ELSE 
            ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer)   .
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt c-Win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem c-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.
/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)"  NO-UNDO.
  ASSIGN 
      gv_prgid   = "wgwrbgen.w"
      gv_prog    = "LOAD TEXT FILE MOTOR RABBIT" .
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). 
  ASSIGN
      fi_company  = "502"
      fi_loaddat  = TODAY 
      fi_producer = "B3W0057"
      fi_agent    = "B3W0057"
      fi_branch   = "W"
      
      fi_process  = "LOAD TEXT FILE MOTOR Rabbit Insurance".
  DISP 
      fi_company 
      fi_loaddat 
      fi_producer
      fi_agent   
      fi_branch  
       
      fi_process  
      WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
  THEN DELETE WIDGET c-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-Win  _DEFAULT-ENABLE
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
  DISPLAY fi_company fi_loaddat fi_branch fi_producer fi_agent fi_filename 
          fi_output1 fi_output2 fi_output3 fi_usrcnt fi_brndes fi_proname 
          fi_agtname fi_process fi_usrprem fi_impcnt fi_completecnt fi_premtot 
          fi_premsuc 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_wdetail fi_company fi_loaddat fi_branch fi_producer fi_agent 
         bu_file fi_filename fi_output1 fi_output2 fi_output3 fi_usrcnt 
         bu_hpbrn bu_hpacno1 bu_hpagent buok bu_exit fi_process fi_usrprem 
         RECT-370 RECT-372 RECT-373 RECT-374 RECT-375 RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW c-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignCMI c-Win 
PROCEDURE proc_assignCMI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------------------------*/
/*
DO: 
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        RUN proc_initdata.
        IMPORT DELIMITER "|" 
          nv_applicationdat             /* 1   application date        */ 
          nv_applicationsigndat         /* 2   application sign date   */ 
          nv_applicationno              /* 3   application no          */ 
          nv_dcchanel                   /* 4   dc chanel               */ 
          nv_branchname                 /* 5   branch name             */ 
          nv_saleagent                  /* 6   sale agent              */ 
          nv_applicationstatus          /* 7   application status      */ 
          nv_temp_receipt_no            /* 8   temp_receipt_no         */ 
          nv_producttype                /* 9   product type            */ 
          nv_productsubtype             /* 10  product sub type        */ 
          nv_plateno                    /* 11  plate no.               */ 
          nv_oicprovince                /* 12  oic province            */ 
          nv_thaiprovince               /* 13  thai province           */ 
          nv_year                       /* 14  year                    */ 
          nv_makedescription1           /* 15  make description1       */ 
          nv_modeldescription           /* 16  model description       */ 
          nv_chassis                    /* 17  chassis                 */ 
          nv_engine                     /* 18  engine                  */ 
          nv_cc                         /* 19  cc                      */ 
          nv_seat                       /* 20  seat                    */ 
          nv_tonnage                    /* 21  tonnage                 */ 
          nv_usecode                    /* 22  use code                */ 
          nv_vehiclegroup               /* 23  vehicle group           */ 
          nv_policyid                   /* 24  policy id               */ 
          nv_barcodeno                  /* 25  barcode no              */ 
          nv_beneficiary                /* 26  beneficiary             */ 
          nv_packagecode                /* 27  package code            */ 
          nv_packagename                /* 28  package name            */ 
          nv_subpackagecode             /* 29  sub package code        */ 
          nv_subpackagename             /* 30  sub package name        */ 
          nv_suminsured                 /* 31  sum insured             */ 
          nv_effectivedate              /* 32  effective date          */ 
          nv_expireddate                /* 33  expired date            */ 
          nv_garagetype                 /* 34  garage type             */ 
          nv_garagetypedescription      /* 35  garage type description */ 
          nv_usetype                    /* 36  use type                */      
          nv_drivertype                 /* 37  driver type             */      
          nv_namefirst                  /* 38  name first              */      
          nv_birthdatefirst             /* 39  birth date first        */ 
          nv_occupationdescfirst        /* 40  occupation desc first   */ 
          nv_drivernofirst              /* 41  driver no first         */      
          nv_identificationnofirst      /* 42  identification no first */ 
          nv_agefirst                   /* 43  age first               */ 
          nv_namesecond                 /* 44  name second             */ 
          nv_birthdatesecond            /* 45  birth date second       */ 
          nv_occupationdescsecond       /* 46  occupation desc second  */ 
          nv_drivernosecond             /* 47  driver no second        */ 
          nv_identificationnosecond     /* 48  identification no second*/
          nv_agesecond                  /* 49  age second              */
          nv_policymanualno             /* 50  policy manual no        */ 
          nv_applicationmanualno        /* 51  application manual no   */ 
          nv_receivemanualno            /* 52  receive manual no       */ 
          nv_promotionticketno          /* 53  promotion ticket no     */ 
          nv_modeofpayment              /* 54  mode of payment         */ 
          nv_netpremium                 /* 55  net premium             */ 
          nv_grosspremium               /* 56  gross premium           */ 
          nv_vat                        /* 57  vat                     */ 
          nv_stamp                      /* 58  stamp                   */ 
          nv_discount_amount            /* 59  discount_amount         */
          nv_paymentchannel             /* 60  payment channel         */
          nv_creditcardno               /* 61  credit card no          */
          nv_slipnoappovalcode          /* 62  slip no/appoval code    */ 
          nv_purchasetype               /* 63  purchase type           */
          nv_purchaseheadOfficebranch   /* 64  purchase headOffice branch */
          nv_purchasebranchcode         /* 65  purchase branch code    */
          nv_purchasetitlename          /* 66  purchase title name     */
          nv_purchasename               /* 67  purchase name           */
          nv_purchasesurname            /* 68  purchase surname        */
          nv_purchasehomephoneno        /* 69  purchase home phone no  */
          nv_purchaseext                /* 70  purchase ext            */
          nv_purchasemobile1            /* 71  purchase mobile1        */
          nv_purchasemobile2            /* 72  purchase mobile2        */
          nv_insuredtype                /* 73  insured type            */
          nv_insuredheadOfficebranch    /* 74  insured headOffice branch       */
          nv_insuredbranchcode          /* 75  insured branch code            */
          nv_relation                   /* 76  relation               */  
          nv_sex                        /* 77  sex                    */  
          nv_insuredtitlename           /* 78  insured title name     */  
          nv_insuredname                /* 79  insured name           */  
          nv_insuredlastname            /* 80  insured lastname       */  
          nv_insureddateofbirth         /* 81  insured date of birth  */  
          nv_insurednationality         /* 82  insured nationality    */  
          nv_insuredorigin              /* 83  insured origin         */     
          nv_insuredmoobarn             /* 84  insured moobarn        */     
          nv_insuredroomnumber          /* 85  insured room number    */  
          nv_insuredhomenumber          /* 86  insured home number    */  
          nv_insuredmoo                 /* 87  insured moo            */  
          nv_insuredsoi                 /* 88  insured soi            */  
          nv_insuredroad                /* 89  insured road           */  
          nv_insuredtumbolid            /* 90  insured tumbol id      */  
          nv_insuredtumbol              /* 91  insured tumbol         */     
          nv_insuredamphurid            /* 92  insured amphur id      */  
          nv_insuredamphur              /* 93  insured amphur         */     
          nv_insuredprovinceid          /* 94  insured province id    */  
          nv_insuredprovince            /* 95  insured province       */  
          nv_insuredpostcode            /* 96  insured post code      */  
          nv_insuredhomephoneno         /* 97  insured home phone no  */  
          nv_insuredext                 /* 98  insured ext            */     
          nv_insuredmobile              /* 99  insured mobile         */     
          nv_insuredmobile2             /* 100 insured mobile2        */     
          nv_insuredfax                 /* 101 insured fax            */     
          nv_insuredcardtype            /* 102 insured card type      */  
          nv_insuredidcardno            /* 103 insured id card no     */  
          nv_namesurnamebilling         /* 104 name surname billing   */  
          nv_billingmoobarn             /* 105 billing moobarn        */     
          nv_billingroomnumber          /* 106 billing room number    */  
          nv_billinghomenumber          /* 107 billing home number    */  
          nv_billingmoo                 /* 108 billing moo            */  
          nv_billingsoi                 /* 109 billing soi            */  
          nv_billingroad                /* 110 billing road           */  
          nv_billingtumbol              /* 111 billing tumbol         */  
          nv_billingamphur              /* 112 billing amphur         */  
          nv_billingprovince            /* 113 billing province       */  
          nv_billingpostcode            /* 114 billing post code      */  
          nv_ws_type                    /* 115 ws_type                */  
          nv_ws_status                  /* 116 ws_status              */  
          nv_ws_error_msg               /* 117 ws_error_msg           */  
          nv_ws_req_date                /* 118 ws_req_date            */  
          nv_ws_req_time                /* 119 ws_req_time            */  
          nv_ws_respone_date            /* 120 ws_respone_date        */  
          nv_ws_respone_time            /* 121 ws_respone_time        */  
          nv_status_print               /* 122 status_print           */  
          nv_print_date                 /* 123 print_date             */  
          nv_print_time                 /* 124 print_time             */
          nv_remark .                   /* 124 remark   100      */ 
          

        IF ( ra_typload = 1 ) AND nv_producttype = "CMI" THEN DO:
            IF            TRIM(nv_applicationno)                   = ""  THEN RUN proc_initdata.
            ELSE IF index(TRIM(nv_applicationno),"application no") <> 0  THEN RUN proc_initdata.
            ELSE  RUN proc_create72.
        END.
        ELSE IF nv_producttype = "product type" THEN RUN proc_initdata.
        ELSE DO:
            RUN proc_initdata.
            MESSAGE "Please check file Load CMI Or VMI select Type Againt !!!" VIEW-AS ALERT-BOX.
        END.
    END.   /* repeat   */
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignVMI c-Win 
PROCEDURE proc_assignVMI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO: 
    For each  wdetail :
        DELETE  wdetail.
    END.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        RUN proc_initdata.
        IMPORT DELIMITER "|" 
            nv_agentname
            nv_short_id
            nv_PolicyStatus                
            nv_PreviousPolicyNumber        
            nv_Renewyr                     
            nv_ContractNumber              
            nv_InsuredType                 
            nv_InsuredBranch               
            nv_InsuredCd                   
            nv_InsuredUniqueID             
            nv_InsuredUniqueIDExpDt        
            nv_License                     
            nv_BirthDt                     
            nv_InsuredTitle               
            nv_InsuredName                 
            nv_InsuredSurname              
            nv_Addr                        
            nv_SubDistrict                 
            nv_District                    
            nv_Province                    
            nv_PostalCode                  
            nv_OccupationDesc              
            nv_MobilePhoneNumber           
            nv_PhoneNumber                 
            nv_OfficePhoneNumber           
            nv_EmailAddr                   
            nv_ReceiptName                 
            nv_ReceiptAddr                 
            nv_VehGroup                    
            nv_Manufacturer                
            nv_Model                       
            nv_ModelYear                   
            nv_VehBodyTypeDesc             
            nv_SeatingCapacity             
            nv_Displacement                
            nv_GrossVehOrCombinedWeight    
            nv_Colour                      
            nv_ChassisSerialNumber         
            nv_EngineSerialNumber          
            nv_Registration                
            nv_RegisteredProvCd            
            nv_RegisteredYear              
            nv_PolicyTypeCd                
            nv_RateGroup                   
            nv_EffectiveDt                 
            nv_ExpirationDt                
            nv_DocumentUID                 
            nv_SumInsureAmt                
            nv_COLLAmtAccident             
            nv_DeductibleCOLLAmtAccident   
            nv_FTAmt                       
            nv_OptionValueDesc             
            nv_GarageTypeCd                
            nv_InsuredTitle1               
            nv_InsuredName1                
            nv_InsuredSurname1             
            nv_BirthDt1                    
            nv_InsuredUniqueID1            
            nv_InsuredTitle2               
            nv_InsuredName2                
            nv_InsuredSurname2               
            nv_BirthDt2                    
            nv_InsuredUniqueID2            
            nv_WrittenAmt                  
            nv_RevenueStampAmt             
            nv_VatAmt                      
            nv_CurrentTermAmt              
            nv_Beneficiaries               
            nv_VehicleUse                  
            nv_CMIPolicyTypeCd             
            nv_CMIVehTypeCd                
            nv_CMIApplicationNumber           
            nv_CMIEffectiveDt                 
            nv_CMIExpirationDt                
            nv_CMIAmtPerson                   
            nv_CMIAmtAccident                 
            nv_CMIWrittenAmt                       
            nv_CMIRevenueStampAmt                          
            nv_CMIVatAmt                                           
            nv_CMICurrentTermAmt                   
            nv_PromptText                              
            nv_MsgStatusCd                         
            nv_AgencyEmployee                  
            nv_RemarkText    
            nv_loadtype   .                   
        IF            TRIM(nv_short_id)             = ""  THEN RUN proc_initdata.
        ELSE IF index(TRIM(nv_short_id),"short_id") <> 0  THEN RUN proc_initdata.
        ELSE  RUN proc_create70.
    END.   /* repeat   */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 c-Win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
DEF VAR nv_count1   AS DECI INIT 0.  
ASSIGN np_chkErr  = NO .             
ASSIGN
    s_riskgp   = 0                   
    s_riskno   = 1 
    s_itemno   = 1                    
    nv_undyr   = String(Year(today),"9999")   
    n_rencnt   = 0                 
    n_endcnt   = 0 .
/*
LOOP_WDETAIL:
FOR EACH wdetail NO-LOCK .
    IF  wdetail.ContractNumber  = ""  THEN NEXT.
    ASSIGN 
        n_rencnt   = 0
        n_endcnt   = 0
        fi_process = "Check data to create " +  wdetail.ContractNumber  .

    DISP fi_process WITH FRAM fr_main.

    IF wdetail.PolicyTypeCd <> ""  THEN DO:
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol   =  wdetail.ContractNumber  AND                   
            sicuw.uwm100.poltyp   =  "V70"   NO-LOCK NO-ERROR NO-WAIT.             
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.expdat > DATE(wdetail.EffectiveDt)   THEN DO: 
                OUTPUT TO Out_wgwtltgb-ERROR.TXT APPEND.
                PUT "Error ���Ţ����ѭ�� ��к� 70:" wdetail.ContractNumber  FORMAT "X(100)" SKIP.
                OUTPUT CLOSE.
            END.
        END.
    END.
    ELSE DO:
        FIND LAST sicuw.uwm100  USE-INDEX uwm10002 WHERE
            sicuw.uwm100.cedpol   =  wdetail.ContractNumber  AND                   
            sicuw.uwm100.poltyp   =  "V72"   NO-LOCK NO-ERROR NO-WAIT.             
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.expdat > DATE(wdetail.CMIExpirationDt)   THEN DO: 
                OUTPUT TO Out_wgwtltgb-ERROR.TXT APPEND.
                PUT "Error ���Ţ����ѭ�� ��к� 72:" wdetail.ContractNumber  FORMAT "X(100)" SKIP.
                OUTPUT CLOSE.
            END.
        END.
    END.
END.      /*for each*/
*/
IF np_chkErr        = NO  THEN DO:
    DEF VAR number_sic AS INTE INIT 0.
    IF NOT CONNECTED("BUInt") THEN DO:
        loop_sic:
        REPEAT:
            number_sic = number_sic + 1 .
            RUN proc_conBUInt.
            IF  CONNECTED("BUInt") THEN LEAVE loop_sic.
            ELSE IF number_sic > 3 THEN DO:
                MESSAGE "User not connect system BUInt !!! >>>" number_sic  VIEW-AS ALERT-BOX.
                LEAVE loop_sic.
            END.
        END.
    END.
    IF  CONNECTED("BUInt") THEN DO:
        DEFINE  VARIABLE  nv_URL             AS CHARACTER NO-UNDO.  /*1 Parameter URL & Database Name*/
        DEFINE  VARIABLE  nv_node-nameHeader AS CHARACTER NO-UNDO.
        DEFINE  VARIABLE  ResponseResult     AS LONGCHAR  NO-UNDO.
        DEFINE  VARIABLE  nv_policyno        AS CHAR INIT "".
        DEFINE  VARIABLE  nv_SavetoFile      AS CHARACTER NO-UNDO.
        FOR EACH wdetail   /*NO-LOCK */
            BREAK BY   wdetail.ContractNumber .  
            ASSIGN 
                wdetail.pass       = "y"
                nv_node-nameHeader = "SendReqPolicy"
                nv_policyno        = wdetail.ContractNumber .
            fi_process = "Process Data : " +  wdetail.ContractNumber  .

            DISP fi_process WITH FRAM fr_main.

            ASSIGN nv_count1 = nv_count1 + 1.

            RUN  wgw\wgwgxml3   (INPUT nv_URL,               
                                 nv_node-nameHeader,    
                                 nv_policyno,     
                                 OUTPUT ResponseResult,    
                                 OUTPUT nv_SavetoFile).
            PAUSE 5 NO-MESSAGE.   
        END.
    END.
END.
ELSE MESSAGE "���������� ERROR ��سҵ�Ǩ�ͺ����͹������к� !!!" VIEW-AS ALERT-BOX. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_conBUInt c-Win 
PROCEDURE proc_conBUInt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF NOT CONNECTED("BUInt") THEN DO: 
    /*RUN wuw\wuwlogbu.*/
    /*CONNECT -db BUInt -H tmsth -S buint -N TCP NO-ERROR.    */         /*Real*/  
    CONNECT -db BUInt -H ctxdb -S buint -N TCP NO-ERROR.        /*Real DPA Add by Kridtiya i.A64-0186 */ 
    
    /*CONNECT -db BUInt -H wsbuint -S buint -N TCP NO-ERROR.               /*Real*/ *//*Comment A62-0105*/
    /*connect BUInt -H 16.90.20.216 -S 5502 -N TCP -U pdmgr0 -P 95mJbWF.   /*Test*/ */  
    /*CONNECT BUInt -H 16.90.20.201 -S 5022 -N TCP -U pdmgr0 -P pdmgr0. */ /*Test   */  
/*      connect BUInt -H 10.35.176.37  -S 5502 -N TCP -U pdmgr0 -P 95mJbWF.   /*Test*/  */
   /*   connect BUInt -H 10.35.176.37  -S 5502 -N TCP -U pdmgr0 -P 95mJbWF. */

END.
IF NOT CONNECTED("BUInt") THEN DO: 
    MESSAGE "Can not Connect Database BUInt !!!"  VIEW-AS ALERT-BOX.
    RETURN.
END.

/*
FORM
    gv_id  LABEL " User Id " colon 35 SKIP
    nv_pwd LABEL " Password" colon 35 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
    TITLE   " Connect DB BUInt System"  . 
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
        END.  /*REPEAT:*/
        ASSIGN n_user = gv_id.
        IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
            /*connect BUInt  -H 16.90.20.203 -S 61760  -N TCP -U value(gv_id) -P value(nv_pwd) NO-ERROR. /*HO STY*/ */
            connect BUInt  -H 16.90.20.201  -S 5022  -N TCP -U value(gv_id) -P value(nv_pwd) NO-ERROR.  /*TEST 1 PC        */ 
            /*connect BUInt  -H 16.90.20.216  -S 5502 -N TCP -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*TEST 2 Internet  */*/  
            /*CONNECT  -db BUINT -H WSBUINT -S BUINT -N TCP -U value(gv_id) -P value(nv_pwd) .*/
            CLEAR FRAME nf00.
            HIDE FRAME nf00.
            RETURN. 
        END.
END.
*/
/*ELSE RUN wuw\wuwvcnqd.*//*Comment Phorn*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create70 c-Win 
PROCEDURE proc_create70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_nametxt  AS CHAR INIT "".
/* table title
FIND FIRST brstat.insure USE-INDEX Insure05   WHERE   /*use-index fname */
    brstat.insure.compno = "999" AND
    brstat.insure.FName  = TRIM(nv_thaiprovince) NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.insure THEN nv_thaiprovince = trim(Insure.LName).
*/
ASSIGN 
    nv_nametxt = ""
    nv_nametxt = trim(nv_InsuredTitle   +
                      nv_InsuredName    + " " +
                      nv_InsuredSurname)  
    nv_PreviousPolicyNumber = REPLACE(nv_PreviousPolicyNumber,"-","")
    nv_PreviousPolicyNumber = REPLACE(nv_PreviousPolicyNumber,"/","") 
    nv_PolicyTypeCd         = IF      nv_PolicyTypeCd = "Type 1"   OR nv_PolicyTypeCd = "1"   THEN "1" 
                              ELSE IF nv_PolicyTypeCd = "Type 2"   OR nv_PolicyTypeCd = "2"   THEN "2" 
                              ELSE IF nv_PolicyTypeCd = "Type 3"   OR nv_PolicyTypeCd = "3"   THEN "3" 
                              ELSE IF nv_PolicyTypeCd = "Type 2.2" OR nv_PolicyTypeCd = "2.2" THEN "2.2" 
                              ELSE IF nv_PolicyTypeCd = "Type 3.2" OR nv_PolicyTypeCd = "3.2" THEN "3.2" 
                              ELSE  nv_PolicyTypeCd.
/*  match title name  
RUN wgw/wgwrbge1 (INPUT        nv_nametxt         
                 ,INPUT-OUTPUT nv_InsuredTitle   
                 ,INPUT-OUTPUT nv_InsuredName    
                 ,INPUT-OUTPUT nv_InsuredSurname).*/

IF nv_loadtype = "" OR index(nv_loadtype,"VMI") <> 0 THEN DO:
FIND FIRST wdetail WHERE wdetail.ContractNumber = TRIM(nv_ContractNumber)     NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.Username                  = ""  
        wdetail.Password                  = ""  
        wdetail.CompanyCode               = trim(fi_company)                  
        wdetail.BranchCd                  = ""                         
        wdetail.InsurerId                 = "STY"     
        wdetail.PolicyStatus              = IF trim(nv_PreviousPolicyNumber) = "" THEN "N" ELSE "R"                                                                                            
        wdetail.PreviousPolicyNumber      = trim(nv_PreviousPolicyNumber)                                                         
        wdetail.Renewyr                   = nv_Renewyr                                                                                                
        wdetail.ContractNumber            = TRIM(nv_ContractNumber)         /*"QNOG322000-001"*/                                        
        wdetail.ContractDt                = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99")                  
        wdetail.ContractTime              = STRING(TIME,"HH:MM:SS")                                                               
        wdetail.CampaignNumber            = nv_CampaignNumber                                                                     
        wdetail.InsuredType               = nv_InsuredType                                                                                
        wdetail.InsuredBranch             = nv_InsuredBranch                                                                   
        wdetail.InsuredCd                 = nv_InsuredCd                                                                       
        wdetail.InsuredUniqueID           = TRIM(nv_InsuredUniqueID)                                         
        wdetail.InsuredUniqueIDExpDt      = nv_InsuredUniqueIDExpDt                                          
        wdetail.License                   = nv_License                                       
        wdetail.BirthDt                   = nv_BirthDt                                       
        wdetail.InsuredTitle              = nv_InsuredTitle                           
        wdetail.InsuredName               = nv_InsuredName                            
        wdetail.InsuredSurname            = nv_InsuredSurname      
        wdetail.Addr                      = nv_Addr                                 
        wdetail.SubDistrict               = nv_SubDistrict                            
        wdetail.District                  = nv_District                               
        wdetail.Province                  = nv_Province                               
        wdetail.PostalCode                = nv_PostalCode 
        wdetail.OccupationDesc            = nv_OccupationDesc                         
        wdetail.MobilePhoneNumber         = nv_MobilePhoneNumber                      
        wdetail.PhoneNumber               = nv_PhoneNumber                                             
        wdetail.OfficePhoneNumber         = nv_OfficePhoneNumber                      
        wdetail.EmailAddr                 = nv_EmailAddr                              
        wdetail.ReceiptName               = nv_ReceiptName                         
        wdetail.ReceiptAddr               = nv_ReceiptAddr                         
        wdetail.VehGroup                  = nv_VehGroup                            
        wdetail.Manufacturer              = nv_Manufacturer                        
        wdetail.Model                     = nv_Model                               
        wdetail.ModelYear                 = nv_ModelYear                           
        wdetail.VehBodyTypeDesc           = nv_VehBodyTypeDesc                     
        wdetail.SeatingCapacity           = nv_SeatingCapacity                     
        wdetail.Displacement              = nv_Displacement                        
        wdetail.GrossVehOrCombinedWeight  = nv_GrossVehOrCombinedWeight          
        wdetail.Colour                    = nv_Colour                                 
        wdetail.ChassisSerialNumber       = nv_ChassisSerialNumber                              
        wdetail.EngineSerialNumber        = nv_EngineSerialNumber                               
        wdetail.Registration              = nv_Registration                                                
        wdetail.RegisteredProvCd          = nv_RegisteredProvCd                                                         
        wdetail.RegisteredYear            = nv_RegisteredYear                                                       
        wdetail.PolicyTypeCd              = nv_PolicyTypeCd                                                    
        wdetail.RateGroup                 = nv_RateGroup  
        wdetail.EffectiveDt               = nv_EffectiveDt
        wdetail.ExpirationDt              = nv_ExpirationDt
        wdetail.DocumentUID               = ""                                             
        wdetail.SumInsureAmt              = nv_SumInsureAmt                                
        wdetail.COLLAmtAccident           = nv_COLLAmtAccident                  
        wdetail.DeductibleCOLLAmtAccident = nv_DeductibleCOLLAmtAccident      
        wdetail.FTAmt                     = nv_FTAmt                            
        wdetail.OptionValueDesc           = nv_OptionValueDesc                            
        wdetail.GarageTypeCd              = nv_GarageTypeCd                               
        wdetail.InsuredTitle1             = nv_InsuredTitle1                       
        wdetail.InsuredName1              = nv_InsuredName1                                          
        wdetail.InsuredSurname1           = nv_InsuredSurname1                                       
        wdetail.BirthDt1                  = nv_BirthDt1                                              
        wdetail.InsuredUniqueID1          = nv_InsuredUniqueID1                                            
        wdetail.InsuredTitle2             = nv_InsuredTitle2                                               
        wdetail.InsuredName2              = nv_InsuredName2                                                
        wdetail.InsuredSurname2           = nv_InsuredSurname2                                             
        wdetail.BirthDt2                  = nv_BirthDt2                                                    
        wdetail.InsuredUniqueID2          = nv_InsuredUniqueID2                                            
        wdetail.WrittenAmt                = nv_WrittenAmt                                                         
        wdetail.RevenueStampAmt           = nv_RevenueStampAmt                                 
        wdetail.VatAmt                    = nv_VatAmt                                          
        wdetail.CurrentTermAmt            = nv_CurrentTermAmt                                 
        wdetail.Beneficiaries             = nv_Beneficiaries                                        
        wdetail.VehicleUse                = "����ǹ�ؤ�� ������Ѻ��ҧ����������"      /* nv_VehicleUse  */                         
        wdetail.CMIPolicyTypeCd           = ""             /*nv_CMIPolicyTypeCd      */                                                    
        wdetail.CMIVehTypeCd              = ""             /*nv_CMIVehTypeCd         */                                                    
        wdetail.CMIApplicationNumber      = ""             /*nv_CMIApplicationNumber */                                                    
        wdetail.CMIEffectiveDt            = ""             /*nv_CMIEffectiveDt       */                                                    
        wdetail.CMIExpirationDt           = ""             /*nv_CMIExpirationDt      */                                                                              
        wdetail.CMIDocumentUID            = ""             /*""                      */                                                           
        wdetail.CMIBarCodeNumber          = ""             /*""                      */                                                           
        wdetail.CMIAmtPerson              = ""             /*nv_CMIAmtPerson         */                                                                           
        wdetail.CMIAmtAccident            = ""             /*nv_CMIAmtAccident       */                                                                           
        wdetail.CMIWrittenAmt             = ""             /*nv_CMIWrittenAmt        */                                                                      
        wdetail.CMIRevenueStampAmt        = ""             /*nv_CMIRevenueStampAmt   */
        wdetail.CMIVatAmt                 = ""             /*nv_CMIVatAmt            */
        wdetail.CMICurrentTermAmt         = ""             /*nv_CMICurrentTermAmt    */
        wdetail.PromptText                = nv_PromptText          
        wdetail.MsgStatusCd               = "NEW"          /*nv_MsgStatusCd   */ 
        wdetail.AgencyEmployee            = nv_AgencyEmployee        
        wdetail.RemarkText                = nv_RemarkText      .
END.
END.
IF   nv_loadtype = "" OR index(nv_loadtype,"CMI") <> 0 THEN DO: 
    IF  /*nv_CMIPolicyTypeCd  <> "" AND */
        nv_CMIVehTypeCd     <> "" AND
        nv_CMIEffectiveDt   <> "" AND 
        nv_CMIExpirationDt  <> "" AND 
        nv_CMIWrittenAmt    <> "" AND 
        DECI(nv_CMIWrittenAmt) > 0 THEN RUN proc_create72.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create72 c-Win 
PROCEDURE proc_create72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail WHERE wdetail.ContractNumber    = TRIM(nv_ContractNumber) + "CMI"    NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.Username                  = ""                                                                               
        wdetail.Password                  = ""  
        wdetail.CompanyCode               = trim(fi_company)                  
        wdetail.BranchCd                  = ""                         
        wdetail.InsurerId                 = "STY"     
        wdetail.PolicyStatus              = "N"   /*trim(nv_PolicyStatus)*/                                                                                        
        wdetail.PreviousPolicyNumber      = ""    /*trim(nv_PreviousPolicyNumber)*/                                                         
        wdetail.Renewyr                   = nv_Renewyr                                                                                                
        wdetail.ContractNumber            = TRIM(nv_ContractNumber) + "CMI"        /*"QNOG322000-001"*/                                        
        wdetail.ContractDt                = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99")                  
        wdetail.ContractTime              = STRING(TIME,"HH:MM:SS")                                                               
        wdetail.CampaignNumber            = nv_CampaignNumber                                                                     
        wdetail.InsuredType               = nv_InsuredType                                                                                
        wdetail.InsuredBranch             = nv_InsuredBranch                                                                   
        wdetail.InsuredCd                 = nv_InsuredCd                                                                       
        wdetail.InsuredUniqueID           = TRIM(nv_InsuredUniqueID)                                         
        wdetail.InsuredUniqueIDExpDt      = nv_InsuredUniqueIDExpDt                                          
        wdetail.License                   = nv_License                                       
        wdetail.BirthDt                   = nv_BirthDt                                       
        wdetail.InsuredTitle              = nv_InsuredTitle                           
        wdetail.InsuredName               = nv_InsuredName                            
        wdetail.InsuredSurname            = nv_InsuredSurname      
        wdetail.Addr                      = nv_Addr                                 
        wdetail.SubDistrict               = nv_SubDistrict                            
        wdetail.District                  = nv_District                               
        wdetail.Province                  = nv_Province                               
        wdetail.PostalCode                = nv_PostalCode 
        wdetail.OccupationDesc            = nv_OccupationDesc                         
        wdetail.MobilePhoneNumber         = nv_MobilePhoneNumber                      
        wdetail.PhoneNumber               = nv_PhoneNumber                                             
        wdetail.OfficePhoneNumber         = nv_OfficePhoneNumber                      
        wdetail.EmailAddr                 = nv_EmailAddr                              
        wdetail.ReceiptName               = nv_ReceiptName                         
        wdetail.ReceiptAddr               = nv_ReceiptAddr                         
        wdetail.VehGroup                  = nv_VehGroup                            
        wdetail.Manufacturer              = nv_Manufacturer                        
        wdetail.Model                     = nv_Model                               
        wdetail.ModelYear                 = nv_ModelYear                           
        wdetail.VehBodyTypeDesc           = nv_VehBodyTypeDesc                     
        wdetail.SeatingCapacity           = nv_SeatingCapacity                     
        wdetail.Displacement              = nv_Displacement                        
        wdetail.GrossVehOrCombinedWeight  = nv_GrossVehOrCombinedWeight          
        wdetail.Colour                    = nv_Colour                                 
        wdetail.ChassisSerialNumber       = nv_ChassisSerialNumber                              
        wdetail.EngineSerialNumber        = nv_EngineSerialNumber                               
        wdetail.Registration              = nv_Registration                                                
        wdetail.RegisteredProvCd          = nv_RegisteredProvCd                                                         
        wdetail.RegisteredYear            = nv_RegisteredYear   
        wdetail.PolicyTypeCd              = ""                                                  
        wdetail.RateGroup                 = ""                                              
        wdetail.EffectiveDt               = ""  
        wdetail.ExpirationDt              = ""  
        wdetail.DocumentUID               = ""                     
        wdetail.SumInsureAmt              = ""                     
        wdetail.COLLAmtAccident           = ""          
        wdetail.DeductibleCOLLAmtAccident = ""        
        wdetail.FTAmt                     = ""          
        wdetail.OptionValueDesc           = ""                    
        wdetail.GarageTypeCd              = ""                    
        wdetail.InsuredTitle1             = ""             
        wdetail.InsuredName1              = ""                               
        wdetail.InsuredSurname1           = ""                               
        wdetail.BirthDt1                  = ""                               
        wdetail.InsuredUniqueID1          = ""                                     
        wdetail.InsuredTitle2             = ""                                     
        wdetail.InsuredName2              = ""                                     
        wdetail.InsuredSurname2           = ""                                     
        wdetail.BirthDt2                  = ""                                     
        wdetail.InsuredUniqueID2          = ""                                     
        wdetail.WrittenAmt                = ""                                            
        wdetail.RevenueStampAmt           = ""                         
        wdetail.VatAmt                    = ""                         
        wdetail.CurrentTermAmt            = ""                        
        wdetail.Beneficiaries             = ""                              
        wdetail.VehicleUse                = "����ǹ�ؤ�� ������Ѻ��ҧ����������"      /* nv_VehicleUse  */                         
        wdetail.CMIPolicyTypeCd           = "�ú"                                                            
        wdetail.CMIVehTypeCd              = nv_CMIVehTypeCd                                                               
        wdetail.CMIApplicationNumber      = nv_CMIApplicationNumber                                                       
        wdetail.CMIEffectiveDt            = nv_CMIEffectiveDt                                                             
        wdetail.CMIExpirationDt           = nv_CMIExpirationDt                                                                                      
        wdetail.CMIDocumentUID            = ""                                                                                   
        wdetail.CMIBarCodeNumber          = ""                                                                                   
        wdetail.CMIAmtPerson              = nv_CMIAmtPerson                                                                                      
        wdetail.CMIAmtAccident            = nv_CMIAmtAccident                                                                                    
        wdetail.CMIWrittenAmt             = nv_CMIWrittenAmt                                                                                
        wdetail.CMIRevenueStampAmt        = nv_CMIRevenueStampAmt    
        wdetail.CMIVatAmt                 = nv_CMIVatAmt             
        wdetail.CMICurrentTermAmt         = nv_CMICurrentTermAmt     
        wdetail.PromptText                = nv_PromptText            
        wdetail.MsgStatusCd               = "NEW"                  
        wdetail.AgencyEmployee            = nv_AgencyEmployee        
        wdetail.RemarkText                = nv_RemarkText       .
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_initdata c-Win 
PROCEDURE proc_initdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_short_id                       = ""
    nv_PolicyStatus                   = ""
    nv_PreviousPolicyNumber           = ""  
    nv_Renewyr                        = ""  
    nv_ContractNumber                 = ""  
    nv_InsuredType                    = "" 
    nv_InsuredBranch                  = "" 
    nv_InsuredCd                      = "" 
    nv_InsuredUniqueID                = "" 
    nv_InsuredUniqueIDExpDt           = "" 
    nv_License                        = ""  
    nv_BirthDt                        = ""  
    nv_InsuredTitle                   = ""  
    nv_InsuredName                    = ""  
    nv_InsuredSurname                 = "" 
    nv_Addr                           = ""  
    nv_SubDistrict                    = ""  
    nv_District                       = ""  
    nv_Province                       = ""  
    nv_PostalCode                     = ""  
    nv_OccupationDesc                 = ""  
    nv_MobilePhoneNumber              = ""  
    nv_PhoneNumber                    = ""  
    nv_OfficePhoneNumber              = "" 
    nv_EmailAddr                      = ""    
    nv_ReceiptName                    = ""    
    nv_ReceiptAddr                    = ""    
    nv_VehGroup                       = ""  
    nv_Manufacturer                   = ""
    nv_Model                          = ""  
    nv_ModelYear                      = ""  
    nv_VehBodyTypeDesc                = ""  
    nv_SeatingCapacity                = ""  
    nv_Displacement                   = ""  
    nv_GrossVehOrCombinedWeight       = ""  
    nv_Colour                         = ""  
    nv_ChassisSerialNumber            = ""  
    nv_EngineSerialNumber             = ""
    nv_Registration                   = "" 
    nv_RegisteredProvCd               = ""     
    nv_RegisteredYear                 = ""     
    nv_PolicyTypeCd                   = ""
    nv_RateGroup                      = ""
    nv_EffectiveDt                    = "" 
    nv_ExpirationDt                   = ""  
    nv_DocumentUID                    = ""  
    nv_SumInsureAmt                   = ""  
    nv_COLLAmtAccident                = ""  
    nv_DeductibleCOLLAmtAccident      = ""  
    nv_FTAmt                          = "" 
    nv_OptionValueDesc                = ""  
    nv_GarageTypeCd                   = "" 
    nv_InsuredTitle1                  = "" 
    nv_InsuredName1                   = ""        
    nv_InsuredSurname1                = ""    
    nv_BirthDt1                       = ""
    nv_InsuredUniqueID1               = ""
    nv_InsuredTitle2                  = ""
    nv_InsuredName2                   = ""
    nv_InsuredSurname2                = ""    
    nv_BirthDt2                       = ""  
    nv_InsuredUniqueID2               = ""  
    nv_WrittenAmt                     = ""  
    nv_RevenueStampAmt                = ""  
    nv_VatAmt                         = ""  
    nv_CurrentTermAmt                 = ""  
    nv_Beneficiaries                  = ""  
    nv_VehicleUse                     = ""  
    nv_CMIPolicyTypeCd                = ""  
    nv_CMIVehTypeCd                   = ""  
    nv_CMIApplicationNumber           = ""  
    nv_CMIEffectiveDt                 = "" 
    nv_CMIExpirationDt                = "" 
    nv_CMIAmtPerson                   = ""
    nv_CMIAmtAccident                 = ""
    nv_CMIWrittenAmt                  = "" 
    nv_CMIRevenueStampAmt             = ""         
    nv_CMIVatAmt                      = ""         
    nv_CMICurrentTermAmt              = ""         
    nv_PromptText                     = ""         
    nv_MsgStatusCd                    = ""         
    nv_AgencyEmployee                 = ""         
    nv_RemarkText                     = ""   . 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mattitle c-Win 
PROCEDURE proc_mattitle :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Match on Web services

IF trim(nv_insuredtitlename) = "���" THEN = 
 
    MR.                     N   ���     �ؤ��
MRS.                    N       ˭ԧ    �ؤ��
MISS                    N       ˭ԧ    �ؤ��
Ms                          N   ˭ԧ    �ؤ��
���͡                   N       ���     �ؤ��
���                    N       ���     �ؤ��
�ŵ��                   N       ���     �ؤ��
�ѹ�͡ (�����)          N       ���     �ؤ��
�ѹ�͡                  N       ���     �ؤ��
�ѹ�                   N       ���     �ؤ��
�ѹ���                  N       ���     �ؤ��
�����͡                 N       ���     �ؤ��
�����                  N       ���     �ؤ��
���µ��                 N       ���     �ؤ��
�.�.�.                  N       ���     �ؤ��
�.�.�.                  N       ���     �ؤ��
�.�.                    N       ���     �ؤ��
�.�.                    N       ���     �ؤ��
�.�.                    N       ���     �ؤ��
���                         N   ���     �ؤ��
�������͡                   N   ���     �ؤ��
�������                    N   ���     �ؤ��
�����͵��                   N   ���     �ؤ��
�����͡ (�����)         N       ���     �ؤ��
�����͡                 N       ���     �ؤ��
�����                  N       ���     �ؤ��
���ҵ��                 N       ���     �ؤ��
�����͡                 N       ���     �ؤ��
�����                  N       ���     �ؤ��
���͵��                 N       ���     �ؤ��
�.�.�.                  N       ���     �ؤ��
�.�.�.                  N       ���     �ؤ��
�.�.�.                  N       ���     �ؤ��
�.�.                    N       ���     �ؤ��
�.�.                    N       ���     �ؤ��
�.�.                    N       ���     �ؤ��
���ҡ���͡                  N   ���     �ؤ��
���ҡ���                   N   ���     �ؤ��
���ҡ�ȵ��                  N   ���     �ؤ��
�.�.(�����)                 N   ���     �ؤ��
�����ҡ���͡        N   ���     �ؤ��
�����ҡ���                 N   ���     �ؤ��
�����ҡ�ȵ��        N   ���     �ؤ��
�����ҡ���͡        N   ���     �ؤ��
�����ҡ���                 N   ���     �ؤ��
�����ҡ�ȵ��        N   ���     �ؤ��
�.�.�.                  N   ��� �ؤ��
�.�.�.                  N   ��� �ؤ��
�.�.�.                  N   ��� �ؤ��
�ŵ��Ǩ�͡                  N   ���     �ؤ��
�ŵ��Ǩ�                   N   ���     �ؤ��
�ŵ��Ǩ���                  N   ���     �ؤ��
�.�.�.(�����)       N   ���     �ؤ��
�ѹ���Ǩ�͡                 N   ���     �ؤ��
�ѹ���Ǩ���                 N   ���     �ؤ��
���µ��Ǩ�͡        N   ���     �ؤ��
���µ��Ǩ�                 N   ���     �ؤ��
���µ��Ǩ���        N   ���     �ؤ��
�.�.                    N   ��� �ؤ��
�.�.�.                  N   ��� �ؤ��
�.�.�.                  N   ��� �ؤ��
�.�.�.                  N   ��� �ؤ��
�ŵ��˭ԧ               N   ˭ԧ        �ؤ��
�.�.(�����)˭ԧ         N   ˭ԧ        �ؤ��
�ѹ�͡˭ԧ                  N   ˭ԧ    �ؤ��
�ѹ�˭ԧ                   N   ˭ԧ    �ؤ��
�ѹ���˭ԧ                  N   ˭ԧ    �ؤ��
�����͡˭ԧ                 N   ˭ԧ    �ؤ��
�����˭ԧ                  N   ˭ԧ    �ؤ��
���µ��˭ԧ                 N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
��� ˭ԧ                    N   ˭ԧ    �ؤ��
�����͵��˭ԧ       N   ˭ԧ    �ؤ��
�.�.(�����)˭ԧ     N   ˭ԧ    �ؤ��
�����͡˭ԧ             N       ˭ԧ    �ؤ��
�����˭ԧ              N       ˭ԧ    �ؤ��
���ҵ��˭ԧ             N       ˭ԧ    �ؤ��
�����͡˭ԧ             N       ˭ԧ    �ؤ��
�����˭ԧ              N       ˭ԧ    �ؤ��
���͵��˭ԧ             N       ˭ԧ    �ؤ��
�.�.�.˭ԧ              N       ˭ԧ    �ؤ��
�.�.�.˭ԧ              N       ˭ԧ    �ؤ��
�.�.�.˭ԧ              N       ˭ԧ    �ؤ��
�.�.˭ԧ                N       ˭ԧ    �ؤ��
�.�.˭ԧ                N   ˭ԧ        �ؤ��
�.�.˭ԧ                N   ˭ԧ        �ؤ��
���ҡ�ȵ��˭ԧ      N   ˭ԧ    �ؤ��
�.�.(�����)˭ԧ     N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�ŵ��Ǩ�͡˭ԧ          N   ˭ԧ        �ؤ��
�ŵ��Ǩ�˭ԧ           N   ˭ԧ        �ؤ��
�ŵ��Ǩ���˭ԧ          N       ˭ԧ    �ؤ��
�.�.�.(�����)�.         N       ˭ԧ    �ؤ��
�ѹ���Ǩ�͡˭ԧ         N       ˭ԧ    �ؤ��
�ѹ���Ǩ�˭ԧ          N       ˭ԧ    �ؤ��
�ѹ���Ǩ���˭ԧ         N       ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.˭ԧ                    N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.                N   ���     �ؤ��
�.�.                N   ˭ԧ    �ؤ��
ᾷ��               N   ���     �ؤ��
�����               N   ���     �ؤ��
�.�.                N   ���     �ؤ��
�.�.�.              N   ���     �ؤ��
�.�.                N   ���     �ؤ��
�.                          N   ���     �ؤ��
��.                         N   ���     �ؤ��
��.                         N   ���     �ؤ��
��ҷ�� �.�.˭ԧ         N       ˭ԧ    �ؤ��
��ҷ�� �.�.                 N   ���     �ؤ��
��ҷ�� �.�.˭ԧ         N       ˭ԧ    �ؤ��
��ҷ�� �.�.                 N   ���     �ؤ��
��ҷ�� �.�.˭ԧ         N       ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�.�.�.˭ԧ                  N   ˭ԧ    �ؤ��
�س˭ԧ                 N       ˭ԧ    �ؤ��
�.�.�.�.�.                  N   ˭ԧ    �ؤ��
��ҷ�� �ѹ���           N       ���     �ؤ��
���.                    N       ���     �ؤ��
���͡˭ԧ                   N   ˭ԧ    �ؤ��
���˭ԧ                    N   ˭ԧ    �ؤ��
���.                    N       ���     �ؤ��
���.                    N       ���     �ؤ��
��ҹ���˭ԧ                 N   ˭ԧ    �ؤ��
��ҷ�� �.�.�.           N       ���     �ؤ��
�.��.                   N       ���     �ؤ��
�.��.                   N       ���     �ؤ��
�.��.                   N       ˭ԧ    �ؤ��
��ҷ��.�.�.(�)         N       ˭ԧ    �ؤ��
�.�.�.                  N       ���     �ؤ��
�ѹ���Ǩ�                  N   ���     �ؤ��
��.     DR.                 Y           �ؤ��
����                   Other   Y               
���     MR.                 Y   ���     �ؤ��
�ҧ     MRS.             Y      ˭ԧ    �ؤ��
�ҧ���  MISS        Y   ˭ԧ    �ؤ��
�.�.    MASTER      Y   ���     �ؤ��
�.�.    MISS        Y   ˭ԧ    �ؤ��
����ѷ                  Y               �ԵԺؤ��
��ҧ�����ǹ�ӡѴ       Y               �ԵԺؤ��
����ѷ�Թ�ع           Y               �ԵԺؤ��
���.                    Y               �ԵԺؤ��
���.                    Y               �ԵԺؤ��
˨�.                    Y               �ԵԺؤ��
��ҷ�� �.�.                         Acting Sub Lt.      Y               �ؤ��
�س     Other                   Y               �ؤ��

*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-Win 
PROCEDURE proc_open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-Win 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.
FOR EACH wdetail  WHERE wdetail.PASS <> "Y"  NO-LOCK :
    NOT_pass = NOT_pass + 1.
END.
IF NOT_pass > 0 THEN DO:
    OUTPUT STREAM ns1 TO value(fi_output2).
    PUT STREAM ns1
        "Username"               ","                            
        "Password"               ","                
        "CompanyCode "           ","                
        "BranchCd"               ","                
        "InsurerId   "           ","                
        "PolicyStatus"           ","                
        "PreviousPolicyNumber"   ","                
        "Renewyr "               ","                
        "ContractNumber "        ","                
        "ContractDt     "        ","                
        "ContractTime   "        ","                
        "CampaignNumber "        ","                
        "InsuredType    "        ","                
        "InsuredBranch  "        ","                
        "InsuredCd      "        ","                
        "InsuredUniqueID"        ","                  
        "InsuredUniqueIDExpDt"   ","                
        "License "        ","                     
        "BirthDt "        ","                
        "InsuredTitle        "        ","                                
        "InsuredName         "        ","                
        "InsuredSurname      "        ","                   
        "Addr    "        ","                
        "SubDistrict         "        ","                
        "District"        ","                
        "Province"        ","                
        "PostalCode          "        ","                
        "OccupationDesc      "        ","                
        "MobilePhoneNumber   "        ","                             
        "PhoneNumber         "        ","                                     
        "OfficePhoneNumber   "        ","                
        "EmailAddr           "        ","                
        "ReceiptName         "        ","                                       
        "ReceiptAddr         "        ","                
        "VehGroup"        ","                
        "Manufacturer        "        ","                
        "Model   "        ","                
        "ModelYear           "        ","                
        "VehBodyTypeDesc     "        ","                
        "SeatingCapacity     "        ","                
        "Displacement        "        ","
        "GrossVehOrCombinedWeight "     ","                
        "Colour             "     ","                
        "ChassisSerialNumber"     ","                
        "EngineSerialNumber "     ","                
        "Registration       "     ","                
        "RegisteredProvCd   "     ","                
        "RegisteredYear     "     ","                
        "PolicyTypeCd       "     ","                           
        "RateGroup          "     ","                
        "EffectiveDt        "     ","                
        "ExpirationDt       "     ","                
        "DocumentUID        "     ","                
        "SumInsureAmt       "     ","                
        "COLLAmtAccident    "     ","                
        "DeductibleCOLLAmtAccident"     ","                
        "FTAmt             "     ","                 
        "OptionValueDesc   "     ","                
        "GarageTypeCd      "     ","                
        "InsuredTitle1     "     ","                
        "InsuredName1      "     ","                
        "InsuredSurname1   "     ","                
        "BirthDt1          "     ","                
        "InsuredUniqueID1  "     ","                
        "InsuredTitle2     "     ","                
        "InsuredName2      "     ","                
        "InsuredSurname2   "     ","                
        "BirthDt2          "     ","                
        "InsuredUniqueID2  "     "," 
        "WrittenAmt        "     "," 
        "RevenueStampAmt   "     "," 
        "VatAmt            "     "," 
        "CurrentTermAmt    "     "," 
        "Beneficiaries     "     "," 
        "VehicleUse        "     "," 
        "CMIPolicyTypeCd   "     "," 
        "CMIVehTypeCd      "     "," 
        "CMIApplicationNumber"   "," 
        "CMIEffectiveDt    "     "," 
        "CMIExpirationDt   "     "," 
        "CMIDocumentUID    "     "," 
        "CMIBarCodeNumber  "     "," 
        "CMIAmtPerson      "     "," 
        "CMIAmtAccident    "     ","  
        "CMIWrittenAmt     "     ","  
        "CMIRevenueStampAmt"     "," 
        "CMIVatAmt         "     ","  
        "CMICurrentTermAmt "     ","  
        "PromptText        "     ","  
        "MsgStatusCd       "     ","  
        "AgencyEmployee    "     ","  
        "RemarkText"          SKIP.  
    FOR EACH  wdetail  WHERE wdetail.PASS <> "Y" NO-LOCK:   
        PUT STREAM ns1 
            wdetail.Username                   ","                            
            wdetail.Password                  ","                
            wdetail.CompanyCode               ","                
            wdetail.BranchCd                  ","                
            wdetail.InsurerId                 ","                
            wdetail.PolicyStatus              ","                
            wdetail.PreviousPolicyNumber      ","                
            wdetail.Renewyr                   ","                
            wdetail.ContractNumber            ","                
            wdetail.ContractDt                ","                
            wdetail.ContractTime              ","                
            wdetail.CampaignNumber            ","                
            wdetail.InsuredType               ","                
            wdetail.InsuredBranch             ","                
            wdetail.InsuredCd                 ","                
            wdetail.InsuredUniqueID           ","                  
            wdetail.InsuredUniqueIDExpDt      ","                
            wdetail.License                   ","                     
            wdetail.BirthDt                   ","                
            wdetail.InsuredTitle              ","                                
            wdetail.InsuredName               ","                
            wdetail.InsuredSurname            ","                   
            wdetail.Addr                      ","                
            wdetail.SubDistrict               ","                
            wdetail.District                  ","                
            wdetail.Province                  ","                
            wdetail.PostalCode                ","                
            wdetail.OccupationDesc            ","                
            wdetail.MobilePhoneNumber         ","                             
            wdetail.PhoneNumber               ","                                     
            wdetail.OfficePhoneNumber         ","                
            wdetail.EmailAddr                 ","                
            wdetail.ReceiptName               ","                                       
            wdetail.ReceiptAddr               ","                
            wdetail.VehGroup                  ","                
            wdetail.Manufacturer              ","                
            wdetail.Model                     ","                
            wdetail.ModelYear                 ","                
            wdetail.VehBodyTypeDesc           ","                
            wdetail.SeatingCapacity           ","                
            wdetail.Displacement              ","                
            wdetail.GrossVehOrCombinedWeight  ","                
            wdetail.Colour                    ","                
            wdetail.ChassisSerialNumber       ","                
            wdetail.EngineSerialNumber        ","                
            wdetail.Registration              ","                
            wdetail.RegisteredProvCd          ","                
            wdetail.RegisteredYear            ","                
            wdetail.PolicyTypeCd              ","                           
            wdetail.RateGroup                 ","                
            wdetail.EffectiveDt               ","                
            wdetail.ExpirationDt              ","                
            wdetail.DocumentUID               ","                
            wdetail.SumInsureAmt              ","                
            wdetail.COLLAmtAccident           ","                
            wdetail.DeductibleCOLLAmtAccident ","                
            wdetail.FTAmt                     ","                 
            wdetail.OptionValueDesc           ","                
            wdetail.GarageTypeCd              ","                
            wdetail.InsuredTitle1             ","                
            wdetail.InsuredName1              ","                
            wdetail.InsuredSurname1           ","                
            wdetail.BirthDt1                  ","                
            wdetail.InsuredUniqueID1          ","                
            wdetail.InsuredTitle2             ","                
            wdetail.InsuredName2              ","                
            wdetail.InsuredSurname2           ","                
            wdetail.BirthDt2                  ","                
            wdetail.InsuredUniqueID2          "," 
            wdetail.WrittenAmt                "," 
            wdetail.RevenueStampAmt           "," 
            wdetail.VatAmt                    "," 
            wdetail.CurrentTermAmt            "," 
            wdetail.Beneficiaries             "," 
            wdetail.VehicleUse                "," 
            wdetail.CMIPolicyTypeCd           "," 
            wdetail.CMIVehTypeCd              "," 
            wdetail.CMIApplicationNumber      "," 
            wdetail.CMIEffectiveDt            "," 
            wdetail.CMIExpirationDt           "," 
            wdetail.CMIDocumentUID            "," 
            wdetail.CMIBarCodeNumber          "," 
            wdetail.CMIAmtPerson              "," 
            wdetail.CMIAmtAccident            ","  
            wdetail.CMIWrittenAmt             ","  
            wdetail.CMIRevenueStampAmt        ","  
            wdetail.CMIVatAmt                 ","  
            wdetail.CMICurrentTermAmt         ","  
            wdetail.PromptText                ","  
            wdetail.MsgStatusCd               ","  
            wdetail.AgencyEmployee            ","  
            wdetail.RemarkText        SKIP.        
    END.
END.
OUTPUT STREAM ns1 CLOSE.     
                                                  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 c-Win 
PROCEDURE PROC_REPORT2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
    pass = pass + 1.
END.
IF pass > 0 THEN DO:
    OUTPUT STREAM ns2 TO value(fi_output1).
    PUT STREAM NS2
        "Username"                  ","                            
        "Password"                  ","                
        "CompanyCode "              ","                
        "BranchCd"                  ","       
        "InsurerId "                ","                
        "PolicyStatus "             ","                
        "PreviousPolicyNumber"      ","                
        "Renewyr "                  ","       
        "ContractNumber      "      ","                
        "ContractDt          "      ","                
        "ContractTime        "      ","                
        "CampaignNumber      "      ","                
        "InsuredType         "      ","                
        "InsuredBranch       "      ","                
        "InsuredCd           "      ","                
        "InsuredUniqueID     "      ","                  
        "InsuredUniqueIDExpDt"      ","                
        "License "                  ","       
        "BirthDt "                  ","       
        "InsuredTitle        "      ","                                
        "InsuredName         "      ","                
        "InsuredSurname      "      ","                   
        "Addr    "                  ","       
        "SubDistrict         "      ","                
        "District"                  ","       
        "Province"                  ","       
        "PostalCode          "      ","                
        "OccupationDesc      "      ","                
        "MobilePhoneNumber   "      ","                             
        "PhoneNumber         "      ","                                     
        "OfficePhoneNumber   "      ","                
        "EmailAddr           "      ","                
        "ReceiptName         "      ","                                       
        "ReceiptAddr         "      ","                
        "VehGroup"                  ","       
        "Manufacturer        "      ","                
        "Model   "                  ","       
        "ModelYear           "      ","                
        "VehBodyTypeDesc     "      ","                
        "SeatingCapacity     "      ","                
        "Displacement        "      "," 
        "GrossVehOrCombinedWeight"  ","                
        "Colour             "       ","                
        "ChassisSerialNumber"       ","                
        "EngineSerialNumber "       ","                
        "Registration       "       ","                
        "RegisteredProvCd   "       ","                
        "RegisteredYear     "       ","                
        "PolicyTypeCd       "       ","                           
        "RateGroup          "       ","                
        "EffectiveDt        "       ","                
        "ExpirationDt       "       ","                
        "DocumentUID        "       ","                
        "SumInsureAmt       "       ","                
        "COLLAmtAccident    "       ","                
        "DeductibleCOLLAmtAccident" ","                
        "FTAmt             "        ","                 
        "OptionValueDesc   "        ","                
        "GarageTypeCd      "        ","                
        "InsuredTitle1     "        ","                
        "InsuredName1      "        ","                
        "InsuredSurname1   "        ","                
        "BirthDt1          "        ","                
        "InsuredUniqueID1  "        ","                
        "InsuredTitle2     "        ","                
        "InsuredName2      "        ","                
        "InsuredSurname2   "        ","                
        "BirthDt2          "        ","                
        "InsuredUniqueID2  "        "," 
        "WrittenAmt        "        "," 
        "RevenueStampAmt   "        "," 
        "VatAmt            "        "," 
        "CurrentTermAmt    "        "," 
        "Beneficiaries     "        "," 
        "VehicleUse        "        "," 
        "CMIPolicyTypeCd   "        "," 
        "CMIVehTypeCd      "        "," 
        "CMIApplicationNumber"      "," 
        "CMIEffectiveDt"            "," 
        "CMIExpirationDt"           "," 
        "CMIDocumentUID"            ","  
        "CMIBarCodeNumber"          ","  
        "CMIAmtPerson"              ","  
        "CMIAmtAccident"            ","  
        "CMIWrittenAmt"             ","  
        "CMIRevenueStampAmt"        ","  
        "CMIVatAmt"                 ","  
        "CMICurrentTermAmt "        ","  
        "PromptText"                ","  
        "MsgStatusCd"               ","  
        "AgencyEmployee"            ","  
        "RemarkText"                SKIP.  
    FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        PUT STREAM ns2
            wdetail.Username                  ","                            
            wdetail.Password                  ","                
            wdetail.CompanyCode               ","                
            wdetail.BranchCd                  ","                
            wdetail.InsurerId                 ","                
            wdetail.PolicyStatus              ","                
            wdetail.PreviousPolicyNumber      ","                
            wdetail.Renewyr                   ","                
            wdetail.ContractNumber            ","                
            wdetail.ContractDt                ","                
            wdetail.ContractTime              ","                
            wdetail.CampaignNumber            ","                
            wdetail.InsuredType               ","                
            wdetail.InsuredBranch             ","                
            wdetail.InsuredCd                 ","                
            wdetail.InsuredUniqueID           ","                  
            wdetail.InsuredUniqueIDExpDt      ","                
            wdetail.License                   ","                     
            wdetail.BirthDt                   ","                
            wdetail.InsuredTitle              ","                                
            wdetail.InsuredName               ","                
            wdetail.InsuredSurname            ","                   
            wdetail.Addr                      ","                
            wdetail.SubDistrict               ","                
            wdetail.District                  ","                
            wdetail.Province                  ","                
            wdetail.PostalCode                ","                
            wdetail.OccupationDesc            ","                
            wdetail.MobilePhoneNumber         ","                             
            wdetail.PhoneNumber               ","                                     
            wdetail.OfficePhoneNumber         ","                
            wdetail.EmailAddr                 ","                
            wdetail.ReceiptName               ","                                       
            wdetail.ReceiptAddr               ","                
            wdetail.VehGroup                  ","                
            wdetail.Manufacturer              ","                
            wdetail.Model                     ","                
            wdetail.ModelYear                 ","                
            wdetail.VehBodyTypeDesc           ","                
            wdetail.SeatingCapacity           ","                
            wdetail.Displacement              ","                
            wdetail.GrossVehOrCombinedWeight  ","                
            wdetail.Colour                    ","                
            wdetail.ChassisSerialNumber       ","                
            wdetail.EngineSerialNumber        ","                
            wdetail.Registration              ","                
            wdetail.RegisteredProvCd          ","                
            wdetail.RegisteredYear            ","                
            wdetail.PolicyTypeCd              ","                           
            wdetail.RateGroup                 ","                
            wdetail.EffectiveDt               ","                
            wdetail.ExpirationDt              ","                
            wdetail.DocumentUID               ","                
            wdetail.SumInsureAmt              ","                
            wdetail.COLLAmtAccident           ","                
            wdetail.DeductibleCOLLAmtAccident ","                
            wdetail.FTAmt                     ","                 
            wdetail.OptionValueDesc           ","                
            wdetail.GarageTypeCd              ","                
            wdetail.InsuredTitle1             ","                
            wdetail.InsuredName1              ","                
            wdetail.InsuredSurname1           ","                
            wdetail.BirthDt1                  ","                
            wdetail.InsuredUniqueID1          ","                
            wdetail.InsuredTitle2             ","                
            wdetail.InsuredName2              ","                
            wdetail.InsuredSurname2           ","                
            wdetail.BirthDt2                  ","                
            wdetail.InsuredUniqueID2          "," 
            wdetail.WrittenAmt                "," 
            wdetail.RevenueStampAmt           "," 
            wdetail.VatAmt                    "," 
            wdetail.CurrentTermAmt            "," 
            wdetail.Beneficiaries             "," 
            wdetail.VehicleUse                "," 
            wdetail.CMIPolicyTypeCd           "," 
            wdetail.CMIVehTypeCd              "," 
            wdetail.CMIApplicationNumber      "," 
            wdetail.CMIEffectiveDt            "," 
            wdetail.CMIExpirationDt           "," 
            wdetail.CMIDocumentUID            "," 
            wdetail.CMIBarCodeNumber          "," 
            wdetail.CMIAmtPerson              "," 
            wdetail.CMIAmtAccident            ","  
            wdetail.CMIWrittenAmt             ","  
            wdetail.CMIRevenueStampAmt        ","  
            wdetail.CMIVatAmt                 ","  
            wdetail.CMICurrentTermAmt         ","  
            wdetail.PromptText                ","  
            wdetail.MsgStatusCd               ","  
            wdetail.AgencyEmployee            ","  
            wdetail.RemarkText        SKIP. 
    END.
    OUTPUT STREAM ns2 CLOSE.                                                           
END.  /*pass > 0*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen c-Win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail :
    DELETE wdetail.
END.
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
"IMPORT TEXT FILE TESCO LOTUS " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer   SKIP
"          Agent Code : " fi_agent      SKIP
"Input File Name Load : " fi_filename   SKIP
"    Output Data Load : " fi_output1    SKIP
"Output Data Not Load : " fi_output1    SKIP
"     Batch File Name : " fi_output1    SKIP
" policy Import Total : " fi_usrcnt    "Total Net Premium Imp : " fi_usrprem " BHT." SKIP
SKIP
SKIP
SKIP
"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP

"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy c-Win 
PROCEDURE proc_TempPolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
nv_tmppol    = ""
nv_tmppolrun = nv_tmppolrun + 1
nv_tmppol    = nv_batchno + string(nv_tmppolrun, "999") .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var c-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   = 0                   
    s_riskno   = 1 
    s_itemno   = 1                    
    nv_undyr   = String(Year(today),"9999")   
    n_rencnt   = 0                 
    n_endcnt   = 0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

