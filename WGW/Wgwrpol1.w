&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          ctxstat          PROGRESS
*/
&Scoped-define WINDOW-NAME Wgwrpol1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Wgwrpol1 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  
 Created by   : Kridtiya i. A64-0187 Date. 19/04/2021
 Program id   : Wgwrpol1.W
 Program name : Parameter Setup Policy Running 
               เป็นโปรแกรมสำหรับ set policy running สำหรับแต่ละบริษัท

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
DEF VAR n_compno AS CHAR.
DEF VAR n_branch AS CHAR.
/* Local Variable Definitions ---                                       */

DEF VAR nv_Branch       AS CHAR.
DEF VAR nv_bdes         AS CHAR.
DEF VAR nv_poltyp       AS CHAR.
DEF VAR nv_poldes       AS CHAR.
DEF VAR nv_Flag         AS CHAR.
DEF VAR n_agent         AS CHAR.
DEF VAR nv_type         AS CHAR.
DEF VAR nv_Branch_Old   AS CHAR.
DEF VAR nv_poltyp_Old   AS CHAR.
DEF VAR nv_Year_Old     AS CHAR.
DEF VAR nv_dir_ri       AS LOGICAL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frCommand
&Scoped-define BROWSE-NAME br_RunPol

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES RunPol_fil

/* Definitions for BROWSE br_RunPol                                     */
&Scoped-define FIELDS-IN-QUERY-br_RunPol RunPol_fil.CompNo ~
RunPol_fil.branch RunPol_fil.poltyp RunPol_fil.undyr RunPol_fil.dir_ri ~
RunPol_fil.start_no RunPol_fil.nextno 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_RunPol 
&Scoped-define QUERY-STRING-br_RunPol FOR EACH RunPol_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_RunPol OPEN QUERY br_RunPol FOR EACH RunPol_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_RunPol RunPol_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_RunPol RunPol_fil


/* Definitions for FRAME frCommand                                      */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_Company fi_Compno fi_branch fi_PolTyp ~
fi_type fi_typeDesc fi_PolYear fi_PreFit fi_RunNo but_SAVE butPoltyp ~
br_RunPol fi_name_branch fi_name_typ fi_SearchCompno but_Cancel RECT-2 ~
RECT-3 RECT-4 RECT-409 RECT-410 RECT-413 RECT-5 RECT-8 RECT-9 RECT-7 RECT-6 
&Scoped-Define DISPLAYED-OBJECTS fi_Company fi_Compno fi_branch fi_PolTyp ~
fi_type fi_typeDesc fi_PolYear fi_PreFit fi_RunNo fi_name_branch fi_Ex ~
fi_name_typ fi_SearchCompno 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR Wgwrpol1 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON butPoltyp 
     LABEL "..." 
     SIZE 3 BY 1.05.

DEFINE BUTTON but_Cancel 
     LABEL "CANCEL" 
     SIZE 13 BY 1.14
     FONT 6.

DEFINE BUTTON but_SAVE 
     LABEL "SAVE" 
     SIZE 13 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Company AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 40 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Compno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Ex AS CHARACTER FORMAT "XX-XX-XX/XXXXXX":U 
      VIEW-AS TEXT 
     SIZE 23.5 BY 1
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name_branch AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 45 BY 1
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name_typ AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 41.5 BY 1
     BGCOLOR 8 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PolTyp AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PolYear AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_PreFit AS CHARACTER FORMAT "X(6)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RunNo AS CHARACTER FORMAT "X(6)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_SearchCompno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_type AS LOGICAL FORMAT "D/I":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_typeDesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 42 BY .95
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 1.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 55 BY 1.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-409
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 1.67
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-410
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 55 BY 1.67
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-413
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 28.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 55 BY 5
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 1.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 55 BY 1.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 4.76
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 55 BY 4.76
     BGCOLOR 8 .

DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY 1 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON but_Add 
     LABEL "ADD" 
     SIZE 13 BY 1.14
     FONT 6.

DEFINE BUTTON but_Delete 
     LABEL "DELETE" 
     SIZE 13 BY 1.14
     FONT 6.

DEFINE BUTTON but_Edit 
     LABEL "EDIT" 
     SIZE 13 BY 1.14
     FONT 6.

DEFINE BUTTON but_Exit 
     LABEL "EXIT" 
     SIZE 13 BY 1.14
     FONT 6.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130 BY 2.14
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-406
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 42 BY 2.1
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-415
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.67 BY 2.1
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_RunPol FOR 
      RunPol_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_RunPol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_RunPol Wgwrpol1 _STRUCTURED
  QUERY br_RunPol NO-LOCK DISPLAY
      RunPol_fil.CompNo COLUMN-LABEL "Com.No." FORMAT "X(6)":U
            WIDTH 7
      RunPol_fil.branch FORMAT "x(5)":U
      RunPol_fil.poltyp COLUMN-LABEL "Pol.Type" FORMAT "x(5)":U
            WIDTH 6
      RunPol_fil.undyr COLUMN-LABEL "Year" FORMAT "x(6)":U
      RunPol_fil.dir_ri COLUMN-LABEL "D/I" FORMAT "D/I":U WIDTH 5
      RunPol_fil.start_no COLUMN-LABEL "PreFix" FORMAT "x(6)":U
      RunPol_fil.nextno FORMAT ">>>>>9":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 53 BY 17.86
         BGCOLOR 15  ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     buAcno1 AT ROW 13.05 COL 86.67
     but_Delete AT ROW 23.14 COL 75.33
     but_Add AT ROW 23.14 COL 90.67
     but_Edit AT ROW 23.14 COL 104.17
     but_Exit AT ROW 23.14 COL 117.5
     "PARAMETER SETUP POLICY - RUNNING" VIEW-AS TEXT
          SIZE 54 BY 1.19 AT ROW 1.48 COL 35.5
          BGCOLOR 3 FGCOLOR 7 FONT 23
     RECT-1 AT ROW 1.05 COL 1.5
     RECT-406 AT ROW 22.62 COL 89.5
     RECT-415 AT ROW 22.62 COL 74
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.67 BY 23.95
         BGCOLOR 90 .

DEFINE FRAME frCommand
     fi_Company AT ROW 1.91 COL 85.33 COLON-ALIGNED NO-LABEL
     fi_Compno AT ROW 1.91 COL 74.5 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_branch AT ROW 3.86 COL 74.33 COLON-ALIGNED NO-LABEL
     fi_PolTyp AT ROW 5.76 COL 74 COLON-ALIGNED NO-LABEL
     fi_type AT ROW 7.19 COL 74 COLON-ALIGNED NO-LABEL
     fi_typeDesc AT ROW 7.19 COL 85.67 COLON-ALIGNED NO-LABEL
     fi_PolYear AT ROW 10.57 COL 74 COLON-ALIGNED NO-LABEL
     fi_PreFit AT ROW 12.05 COL 74 COLON-ALIGNED NO-LABEL
     fi_RunNo AT ROW 13.48 COL 74 COLON-ALIGNED NO-LABEL
     but_SAVE AT ROW 18.05 COL 95
     butPoltyp AT ROW 5.76 COL 83.83
     br_RunPol AT ROW 1.71 COL 1.5
     fi_name_branch AT ROW 3.86 COL 81.5 COLON-ALIGNED NO-LABEL
     fi_Ex AT ROW 15.52 COL 73.5 COLON-ALIGNED NO-LABEL
     fi_name_typ AT ROW 5.76 COL 85.5 COLON-ALIGNED NO-LABEL
     fi_SearchCompno AT ROW 18.05 COL 75.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     but_Cancel AT ROW 18.05 COL 108.5 WIDGET-ID 14
     "~{ ระบุปี  พ.ศ.}" VIEW-AS TEXT
          SIZE 14 BY .95 AT ROW 10.71 COL 89.83
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "Ex." VIEW-AS TEXT
          SIZE 3.5 BY 1.19 AT ROW 15.29 COL 56.5
          BGCOLOR 8 FGCOLOR 4 FONT 6
     "POLICY PREFIT" VIEW-AS TEXT
          SIZE 17 BY 1.19 AT ROW 12 COL 56.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "UW.  YEAR" VIEW-AS TEXT
          SIZE 13.67 BY 1.19 AT ROW 10.43 COL 56.67
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "BRANCH" VIEW-AS TEXT
          SIZE 9.5 BY 1.19 AT ROW 3.67 COL 56.33
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "COMPANY NO" VIEW-AS TEXT
          SIZE 18 BY 1.19 AT ROW 1.81 COL 56 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "SEARCH COMP. NO." VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 18.05 COL 56 WIDGET-ID 12
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "POLICY TYPE" VIEW-AS TEXT
          SIZE 14 BY 1.19 AT ROW 5.67 COL 56.17
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "RUNNING" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 13.38 COL 56.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     RECT-2 AT ROW 3.38 COL 55
     RECT-3 AT ROW 3.38 COL 75
     RECT-4 AT ROW 10.05 COL 55
     RECT-409 AT ROW 15.05 COL 55
     RECT-410 AT ROW 15.05 COL 75
     RECT-413 AT ROW 17.67 COL 94
     RECT-5 AT ROW 10.1 COL 75
     RECT-8 AT ROW 5.29 COL 55
     RECT-9 AT ROW 5.29 COL 75
     RECT-7 AT ROW 1.43 COL 75
     RECT-6 AT ROW 1.43 COL 55 WIDGET-ID 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.83 ROW 3.43
         SIZE 130 BY 19.


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
  CREATE WINDOW Wgwrpol1 ASSIGN
         HIDDEN             = YES
         TITLE              = "Wgwrpol1 : Parameter Setup Policy Running No."
         HEIGHT             = 23.91
         WIDTH              = 131.5
         MAX-HEIGHT         = 35.24
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.24
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
IF NOT Wgwrpol1:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW Wgwrpol1
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frCommand:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME frCommand
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_RunPol butPoltyp frCommand */
/* SETTINGS FOR FILL-IN fi_Ex IN FRAME frCommand
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frMain
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Wgwrpol1)
THEN Wgwrpol1:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_RunPol
/* Query rebuild information for BROWSE br_RunPol
     _TblList          = "CTXSTAT.RunPol_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > CTXSTAT.RunPol_fil.CompNo
"RunPol_fil.CompNo" "Com.No." "X(6)" "character" ? ? ? ? ? ? no ? no no "7" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > CTXSTAT.RunPol_fil.branch
"RunPol_fil.branch" ? "x(5)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > CTXSTAT.RunPol_fil.poltyp
"RunPol_fil.poltyp" "Pol.Type" "x(5)" "character" ? ? ? ? ? ? no ? no no "6" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > CTXSTAT.RunPol_fil.undyr
"RunPol_fil.undyr" "Year" "x(6)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > CTXSTAT.RunPol_fil.dir_ri
"RunPol_fil.dir_ri" "D/I" ? "logical" ? ? ? ? ? ? no ? no no "5" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > CTXSTAT.RunPol_fil.start_no
"RunPol_fil.start_no" "PreFix" "x(6)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   = CTXSTAT.RunPol_fil.nextno
     _Query            is NOT OPENED
*/  /* BROWSE br_RunPol */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Wgwrpol1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Wgwrpol1 Wgwrpol1
ON END-ERROR OF Wgwrpol1 /* Wgwrpol1 : Parameter Setup Policy Running No. */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Wgwrpol1 Wgwrpol1
ON WINDOW-CLOSE OF Wgwrpol1 /* Wgwrpol1 : Parameter Setup Policy Running No. */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_RunPol
&Scoped-define SELF-NAME br_RunPol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_RunPol Wgwrpol1
ON VALUE-CHANGED OF br_RunPol IN FRAME frCommand
DO:
   
   FIND CURRENT CTXSTAT.RunPol_Fil NO-LOCK NO-ERROR.  
   IF AVAIL CTXSTAT.RunPol_Fil THEN DO:     

       FIND FIRST CTXSTAT.Company WHERE CTXSTAT.Company.Compno = CTXSTAT.RunPol_Fil.CompNo NO-LOCK NO-ERROR.
       IF AVAIL CTXSTAT.Company THEN fi_Company = CTXSTAT.Company.NAME.
       ELSE fi_Company = "NOT FOUND COMPANY NAME...!!!".

       DISP fi_Company WITH FRAME frcommand.  

       ASSIGN
        FRAME frCommand fi_Compno
        FRAME frCommand fi_Company
        FRAME frCommand fi_branch
        FRAME frCommand fi_name_branch
        FRAME frCommand fi_PolTyp
        FRAME frCommand fi_PolYear
        FRAME frCommand fi_PreFit
        FRAME frCommand fi_RunNo.

      IF LENGTH(CTXSTAT.RunPol_Fil.Start_no) = 2 THEN DO:

         IF LENGTH(CTXSTAT.RunPol_Fil.branch) = 1 THEN DO:
             ASSIGN fi_Runno = string(CTXSTAT.RunPol_Fil.nextno,"9999")
                    fi_Ex = "D" + CTXSTAT.RunPol_Fil.branch + SUBSTRING(CTXSTAT.RunPol_Fil.poltyp,2,2) + SUBSTRING(CTXSTAT.RunPol_Fil.undyr,3,2) +
                    CTXSTAT.RunPol_Fil.Start_no    + STRING(INT(CTXSTAT.RunPol_Fil.nextno ), "9999").
             DISP fi_ex WITH FRAME frcommand.
         END.
         ELSE DO:
             ASSIGN fi_Runno = string(CTXSTAT.RunPol_Fil.nextno,"9999")
                    fi_Ex    = CTXSTAT.RunPol_Fil.branch                + 
                               SUBSTRING(CTXSTAT.RunPol_Fil.poltyp,2,2) + 
                               SUBSTRING(CTXSTAT.RunPol_Fil.undyr,3,2)  +
                               CTXSTAT.RunPol_Fil.Start_no              + 
                               STRING(INT(RunPol_Fil.nextno ), "9999").
             DISP fi_ex WITH FRAME frcommand.
         END.
      END.

      IF LENGTH(CTXSTAT.RunPol_Fil.Start_no) = 1 THEN DO:
          IF LENGTH(CTXSTAT.RunPol_Fil.branch) = 1 THEN DO:
              ASSIGN fi_Runno = string(CTXSTAT.RunPol_Fil.nextno,"99999")
                     fi_Ex    = "D" + RunPol_Fil.branch + 
                                SUBSTRING(CTXSTAT.RunPol_Fil.poltyp,2,2) + 
                                SUBSTRING(RunPol_Fil.undyr,3,2)          +
                                CTXSTAT.RunPol_Fil.Start_no              + 
                                STRING(INT(CTXSTAT.RunPol_Fil.nextno ), "99999").
              DISP fi_ex WITH FRAME frcommand.
          END.
          ELSE DO:
              ASSIGN fi_Runno = string(CTXSTAT.RunPol_Fil.nextno,"99999")
                    fi_Ex = CTXSTAT.RunPol_Fil.branch + SUBSTRING(CTXSTAT.RunPol_Fil.poltyp,2,2) + SUBSTRING(CTXSTAT.RunPol_Fil.undyr,3,2) +
                    CTXSTAT.RunPol_Fil.Start_no    + STRING(INT(CTXSTAT.RunPol_Fil.nextno ), "99999").
              DISP fi_ex WITH FRAME frcommand.
          END.
      END.

      DISP CTXSTAT.RunPol_Fil.CompNo   @ fi_CompNo
           CTXSTAT.RunPol_Fil.Branch   @ fi_branch
           CTXSTAT.RunPol_Fil.poltyp   @ fi_Poltyp 
           CTXSTAT.RunPol_fil.Dir_ri   @ fi_type
           CTXSTAT.RunPol_Fil.undyr    @ fi_polYear                   
           CTXSTAT.RunPol_Fil.Start_no @ fi_PreFit           
           fi_RunNo   
      WITH FRAME frCommand.
      
      FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = fi_poltyp  NO-LOCK NO-ERROR.
      IF AVAIL sicsyac.xmm031 THEN DO:      
         ASSIGN fi_name_Typ  =  sicsyac.xmm031.poldes.
         DISP fi_name_typ WITH FRAME frcommand.
      END.

      IF fi_poltyp = "C90" THEN DO:
         fi_typeDesc = " D = Policy / I = Certificate".
      END.
      ELSE DO:
         fi_typeDesc = " D = Direct / I = RI Code (D/R)".
      END.
         DISP fi_typeDesc  WITH FRAME {&FRAME-NAME}.

   END.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME butPoltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL butPoltyp Wgwrpol1
ON CHOOSE OF butPoltyp IN FRAME frCommand /* ... */
DO:

RUN wctx\WctxH908(INPUT-OUTPUT nv_poltyp , INPUT-OUTPUT nv_poldes).

IF nv_poltyp <> ""  THEN DO:
  fi_poltyp = nv_poltyp.
  DISP fi_poltyp WITH FRAME {&FRAME-NAME}.
END.
IF nv_poldes <> ""  THEN DO:
   fi_name_typ = nv_poldes.
   DISP fi_name_typ WITH FRAME {&FRAME-NAME}.
END.

IF nv_poltyp = "C90" THEN DO:
    fi_typeDesc = " D = Policy / I = Certificate".
END.
ELSE DO:
    fi_typeDesc = " D = Direct / I = RI Code (D/R)".
END.
DISP fi_typeDesc  WITH FRAME {&FRAME-NAME}.

APPLY "Entry" TO fi_Poltyp IN FRAME frCommand.
RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&Scoped-define SELF-NAME but_Add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Add Wgwrpol1
ON CHOOSE OF but_Add IN FRAME frMain /* ADD */
DO:
    ASSIGN
    nv_Flag = "ADD".

    RUN PDClearData.

    APPLY "ENTRY" TO fi_Compno IN FRAME frCommand.

    ENABLE ALL WITH FRAME frCommand.
    DISABLE br_RunPol WITH FRAME frCommand.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frCommand
&Scoped-define SELF-NAME but_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Cancel Wgwrpol1
ON CHOOSE OF but_Cancel IN FRAME frCommand /* CANCEL */
DO:
    ASSIGN
    nv_Flag = "".

   RUN PDClearData.

   APPLY "VALUE-CHANGED" TO br_RunPol IN FRAME frCommand.
   DISABLE ALL WITH FRAME frCommand.
   ENABLE br_RunPol WITH FRAME frCommand.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&Scoped-define SELF-NAME but_Delete
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Delete Wgwrpol1
ON CHOOSE OF but_Delete IN FRAME frMain /* DELETE */
DO:
    DEF VAR logAns      AS LOGI INIT No.  
    logAns = No.

    FIND CURRENT CTXSTAT.RunPol_Fil EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL CTXSTAT.RunPol_Fil THEN DO:
        IF LOCKED CTXSTAT.RunPol_Fil THEN DO:

           MESSAGE "Record on CTXSTAT.RunPol_Fil is LOCKED...!" VIEW-AS ALERT-BOX WARNING.
           LEAVE.

        END.

    END.
    IF AVAIL CTXSTAT.RunPol_Fil THEN DO:

        MESSAGE "ต้องการลบข้อมูลรายการ Paramete " + CTXSTAT.RunPol_Fil.undyr + "...?"
              UPDATE logAns 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "ยืนยันการลบข้อมูล".   
         
        IF logAns THEN DO:  
           GET CURRENT br_RunPol EXCLUSIVE-LOCK.
           DELETE CTXSTAT.RunPol_Fil.
           MESSAGE "ลบข้อมูลเรียบร้อย ..." 
           VIEW-AS ALERT-BOX INFORMATION.  
        END.

    END.

    RUN PDClearData.
    RUN PDUpdateQ.
    APPLY "VALUE-CHANGED" TO br_RunPol IN FRAME frCommand.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME but_Edit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Edit Wgwrpol1
ON CHOOSE OF but_Edit IN FRAME frMain /* EDIT */
DO:

  ASSIGN
      FRAME frCommand fi_PolTyp
      FRAME frCommand fi_PolYear
      FRAME frCommand fi_PreFit
      FRAME frCommand fi_RunNo
      nv_Flag = "EDIT".
  ENABLE ALL WITH FRAME frCommand.
  DISABLE br_RunPol WITH FRAME frCommand.

  APPLY "ENTRY" TO fi_Compno IN FRAME frCommand.

  ASSIGN
    nv_Branch_Old = fi_branch
    nv_poltyp_Old = fi_PolTyp
    nv_Year_Old   = fi_PolYear .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME but_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_Exit Wgwrpol1
ON CHOOSE OF but_Exit IN FRAME frMain /* EXIT */
DO:
     APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frCommand
&Scoped-define SELF-NAME but_SAVE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL but_SAVE Wgwrpol1
ON CHOOSE OF but_SAVE IN FRAME frCommand /* SAVE */
DO:

DEF VAR logAns      AS LOGI INIT No.  

  ASSIGN
    FRAME frCommand fi_branch
    FRAME frCommand fi_type
    FRAME frCommand fi_PolTyp
    FRAME frCommand fi_PolYear 
    FRAME frCommand fi_PreFit
    FRAME frCommand fi_RunNo.      

    logAns = No.
    
     
    IF nv_flag = "ADD" THEN  DO:
      /*
      p : RunPol01 6 + CompNo + dir_ri + poltyp + branch + undyr + nextno */

        FIND LAST CTXSTAT.RunPol_Fil USE-INDEX Runpol01 WHERE 
                  CTXSTAT.RunPol_Fil.CompNo = fi_CompNo AND         
                  CTXSTAT.RunPol_Fil.DIR_ri = fi_type   AND
                  CTXSTAT.RunPol_Fil.PolTyp = fi_PolTyp AND
                  CTXSTAT.RunPol_Fil.branch = fi_branch AND                   
                  CTXSTAT.RunPol_Fil.undyr  = fi_PolYear EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
        IF AVAIL CTXSTAT.RunPol_Fil THEN DO:
    
           MESSAGE  "ข้อมูลซ้า ! ไม่สามารถเพิ่มข้อมูลได้, กรุณาตรวจสอบข้อมูล" 
           VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลผิดพลาด ".
           APPLY "ENTRY" TO fi_Branch IN FRAME frcommand.
           RETURN NO-APPLY.
    
        END.
        ELSE DO:
    
          IF LOCKED CTXSTAT.RunPol_Fil THEN DO:
    
             MESSAGE "Record on CTXSTAT.RunPol_Fil is LOCKED...! (CREATE)" VIEW-AS ALERT-BOX WARNING.
             LEAVE.
    
          END.
    
          CREATE CTXSTAT.RunPol_Fil.
          ASSIGN
            CTXSTAT.RunPol_Fil.CompNo   = fi_CompNo
            CTXSTAT.RunPol_Fil.Dir_ri   = fi_type
            CTXSTAT.RunPol_Fil.branch   = fi_branch
            CTXSTAT.RunPol_Fil.brn_pol  = fi_branch
            CTXSTAT.RunPol_Fil.PolTyp   = fi_PolTyp
            CTXSTAT.RunPol_Fil.undyr    = fi_PolYear
            CTXSTAT.RunPol_Fil.Start_no = fi_PreFit
            CTXSTAT.RunPol_Fil.Nextno   = INT(fi_RunNo).                    
        END.           
    END.
    
    IF nv_flag = "EDIT" THEN DO:    
    
       FIND CURRENT  CTXSTAT.RunPol_Fil EXCLUSIVE-LOCK NO-ERROR NO-WAIT.
       IF NOT AVAIL CTXSTAT.RunPol_Fil THEN DO:
    
          MESSAGE "Record on CTXSTAT.RunPol_Fil is LOCKED...! (EDIT)" VIEW-AS ALERT-BOX WARNING.
          LEAVE.
       END.
       IF AVAIL CTXSTAT.RunPol_Fil THEN DO:
    
         ASSIGN
           CTXSTAT.RunPol_Fil.Dir_ri   = fi_type
           CTXSTAT.RunPol_Fil.branch   = fi_branch
           CTXSTAT.RunPol_Fil.brn_pol  = fi_branch
           CTXSTAT.RunPol_Fil.PolTyp   = fi_PolTyp
           CTXSTAT.RunPol_Fil.undyr    = fi_PolYear
           CTXSTAT.RunPol_Fil.Start_no = fi_PreFit
           CTXSTAT.RunPol_Fil.Nextno   = INT(fi_RunNo).
       END.        
    END.
       
    MESSAGE  "บันทึกข้อมูลเรียบรอ้ยแล้ว" 
    VIEW-AS  ALERT-BOX INFORMATION TITLE "Save Complate".
    
    RUN PDUpdateQ.

    APPLY "ENTRY" TO but_Exit IN FRAME frMain.
    DISABLE ALL EXCEPT fi_SearchCompno WITH FRAME frcommand.
    ENABLE br_RunPol WITH FRAME frCommand.
    
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch Wgwrpol1
ON LEAVE OF fi_branch IN FRAME frCommand
DO:
  fi_branch = INPUT fi_branch.

    ASSIGN 
        fi_branch = CAPS(INPUT fi_branch).           
    
    DISP fi_branch  WITH FRAME frCommand.   
    
    FIND sicsyac.xmm023 WHERE sicsyac.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm023 THEN DO:      
        ASSIGN fi_name_branch  = sicsyac.xmm023.bdes.
    END.  
    ELSE DO:
       MESSAGE  "ไม่พบข้อมูล Policy Type ที่ระบุ ! , กรุณาตรวจสอบข้อมูล" 
       VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลผิดพลาด ".
       APPLY "ENTRY" TO fi_branch IN FRAME frcommand.
    END.
    
    DISP  fi_name_branch WITH FRAME {&FRAME-NAME}.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Company
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Company Wgwrpol1
ON LEAVE OF fi_Company IN FRAME frCommand
DO:
  fi_Company = INPUT fi_Company.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Compno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Compno Wgwrpol1
ON LEAVE OF fi_Compno IN FRAME frCommand
DO:
    fi_CompNo = INPUT fi_CompNo.
    
    DISP  fi_company WITH FRAME {&FRAME-NAME}.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Compno Wgwrpol1
ON RETURN OF fi_Compno IN FRAME frCommand
DO:
    ASSIGN 
        fi_CompNo = CAPS(INPUT fi_CompNo).           
    
    DISP fi_CompNo  WITH FRAME frCommand.   
    
    FIND CTXSTAT.Company WHERE CTXSTAT.Company.compno = fi_CompNo NO-LOCK NO-ERROR.
    IF AVAIL CTXSTAT.Company THEN DO:      
        ASSIGN fi_company  = CTXSTAT.Company.name.
    END.  
    ELSE DO:
       MESSAGE  "ไม่พบข้อมูล Company ที่ระบุ ! , กรุณาตรวจสอบข้อมูล" 
       VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลผิดพลาด ".
       APPLY "ENTRY" TO fi_CompNo IN FRAME frcommand.
    END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_PolTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_PolTyp Wgwrpol1
ON RETURN OF fi_PolTyp IN FRAME frCommand
DO:

DEF VAR logAns AS LOGI INIT No.  

  ASSIGN fi_Poltyp = CAPS(INPUT fi_Poltyp).
  DISP fi_Poltyp  WITH FRAME frCommand.   

  FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = fi_Poltyp NO-LOCK NO-ERROR.
  IF AVAIL sicsyac.xmm031 THEN DO:      
      ASSIGN fi_name_Typ  =  sicsyac.xmm031.poldes.
  END.  
  ELSE DO:

     /*
     MESSAGE  "ไม่พบข้อมูล Policy Type ที่ระบุ ! , กรุณาตรวจสอบข้อมูล" 
     VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลผิดพลาด ".
     APPLY "ENTRY" TO fi_poltyp IN FRAME frcommand.
     RETURN NO-APPLY.
     */

     logAns = No.
    
     MESSAGE "ไม่พรบข้อมูล Policy Type นี้, กรุณายืนยันข้อมูล"
           UPDATE logAns 
     VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
     TITLE "ยืนยันข้อมูล".   
         
     IF logAns THEN DO:  
         fi_typedesc = "NOT FOUND POLICY TYPE...!!!".
     END.
     ELSE DO:
         MESSAGE  "ไม่พบข้อมูล Policy Type ที่ระบุ ! , กรุณาตรวจสอบข้อมูล" 
         VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลผิดพลาด ".
         APPLY "ENTRY" TO fi_poltyp IN FRAME frcommand.
         RETURN NO-APPLY.
     END.

  END.  

  IF fi_Poltyp = "C90" THEN DO:
      fi_typeDesc = " D = Policy / I = Certificate".      
  END.
  ELSE DO:
      fi_typeDesc = " D = Direct / I = RI Code (D/R)".
  END.

  DISP fi_typeDesc  fi_name_typ WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_PolYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_PolYear Wgwrpol1
ON LEAVE OF fi_PolYear IN FRAME frCommand
DO:
   ASSIGN 
        fi_Polyear = INPUT fi_PolYear.

    IF fi_PolYear = "" THEN DO:
      MESSAGE  "ไม่มีการระบุข้อมูล ! , กรุณาตรวจสอบข้อมูล" 
            VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลผิดพลาด ".
            APPLY "ENTRY" TO fi_PolYear IN FRAME frcommand.
            RETURN NO-APPLY.
   END.
   IF  nv_Flag = "Edit" AND (fi_branch  <> nv_Branch_Old  OR
       fi_PolTyp  <> nv_poltyp_Old  OR
       fi_PolYear <> nv_Year_Old)    THEN DO:         
       FIND LAST RunPol_Fil  WHERE
                 Runpol_fil.Compno = n_compno AND
                 RunPol_Fil.branch = n_branch AND
                 RunPol_Fil.PolTyp = fi_PolTyp AND
                 RunPol_Fil.undyr  = fi_PolYear  NO-ERROR.
         IF AVAIL RunPol_Fil THEN DO:
              MESSAGE 
                  "Company Code   :" n_Compno SKIP
                  "Running Policy : Branch " + n_Branch SKIP
                  "Policy Type    : " + fi_Poltyp  SKIP
                  "Policy Year    : " + fi_PolYear SKIP 
                  " มีอยู่แล้วในระบบ , กรุณาตรวจสอบข้อมูล"
              VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลซ้า ! ".              
              APPLY "ENTRY" TO fi_PolYear IN FRAME frcommand.
              RETURN NO-APPLY.
           END.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_PreFit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_PreFit Wgwrpol1
ON LEAVE OF fi_PreFit IN FRAME frCommand
DO:
  ASSIGN 
        fi_PreFit = CAPS(INPUT fi_PreFit).
   DISP fi_PreFit  WITH FRAME frCommand.   
   IF fi_PreFit = "" THEN DO:
      MESSAGE  "ไม่มีการระบุข้อมูล ! , กรุณาตรวจสอบข้อมูล" 
            VIEW-AS  ALERT-BOX ERROR TITLE "ข้อมูลผิดพลาด ".
            APPLY "ENTRY" TO fi_PreFit IN FRAME frcommand.
            RETURN NO-APPLY.
   END.
   
   END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_RunNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_RunNo Wgwrpol1
ON LEAVE OF fi_RunNo IN FRAME frCommand
DO:
  ASSIGN
      FRAME frCommand fi_branch
      FRAME frCommand fi_PolTyp
      FRAME frCommand fi_PolYear
      FRAME frCommand fi_PreFit
      FRAME frCommand fi_RunNo fi_Runno.
      

    IF TRIM(fi_Runno) = "" THEN DO:
       MESSAGE "กรุณากำหนด  Running No.... !" SKIP(1)
               "ข้อมูลผิดพลาด  , กรุณาตรวจสอบข้อมูล"  VIEW-AS ALERT-BOX  ERROR TITLE "".
       APPLY "ENTRY" TO fi_RunNo IN FRAME frCommand.
       RETURN NO-APPLY.
    END.
    ELSE DO: 
        fi_RunNo = INPUT fi_Runno.
        
        IF  LENGTH(fi_Prefit) = 2 THEN DO:
            IF LENGTH(fi_branch) = 1 THEN DO:
                IF LENGTH(fi_RunNo) > 4 THEN DO:
                    MESSAGE "สามารถกำหนด  Running No ได้เพียง 4 หลัก เท่านั้น !" SKIP(1)
                            "ข้อมูลผิดพลาด  , กรุณาตรวจสอบข้อมูล"  VIEW-AS ALERT-BOX  ERROR TITLE "Policy Prefit 2 หลัก".
                    APPLY "ENTRY" TO fi_RunNo IN FRAME frCommand.
                   RETURN NO-APPLY.
                END.
                ELSE DO:                                 
                     fi_Ex = nv_type + fi_branch + SUBSTRING(fi_PolTyp,2,2) + SUBSTRING(fi_PolYear,3,2) + 
                             fi_Prefit +  STRING(INT(fi_RunNo), "9999").                                  
                     DISP fi_ex WITH FRAME frcommand.
                END.
            END.
            ELSE DO:
                IF LENGTH(fi_RunNo) > 4 THEN DO:
                    MESSAGE "สามารถกำหนด  Running No ได้เพียง 4 หลัก เท่านั้น !" SKIP(1)
                            "ข้อมูลผิดพลาด  , กรุณาตรวจสอบข้อมูล"  VIEW-AS ALERT-BOX  ERROR TITLE "Policy Prefit 2 หลัก".
                    APPLY "ENTRY" TO fi_RunNo IN FRAME frCommand.
                   RETURN NO-APPLY.
                END.
                ELSE DO:                                 
                     fi_Ex = fi_branch + SUBSTRING(fi_PolTyp,2,2) + SUBSTRING(fi_PolYear,3,2) + 
                             fi_Prefit +  STRING(INT(fi_RunNo), "9999").                                  
                     DISP fi_ex WITH FRAME frcommand.
                END.
            END.
        END.    


        IF LENGTH(fi_Prefit) = 1 THEN DO:
           IF LENGTH(fi_branch) = 1 THEN DO:
               IF LENGTH(fi_RunNo) < 5 THEN DO:
                  MESSAGE "กรุณากำหนด  Running No ไห้ครบ 5 หลัก...!" SKIP(1)
                          "ข้อมูลผิดพลาด  , กรุณาตรวจสอบข้อมูล"  VIEW-AS ALERT-BOX  ERROR TITLE "Policy Prefit 1 หลัก".
                  APPLY "ENTRY" TO fi_RunNo IN FRAME frCommand.
                  RETURN NO-APPLY.
               END.
               ELSE DO:
                  fi_Ex = nv_type + fi_branch + SUBSTRING(fi_PolTyp,2,2) + SUBSTRING(fi_PolYear,3,2) + 
                          fi_Prefit +  STRING(INT(fi_RunNo), "99999").                                  

                  DISP fi_ex WITH FRAME frcommand.
               END.
           END.
           ELSE DO:
               IF LENGTH(fi_RunNo) < 5 THEN DO:
                   MESSAGE "กรุณากำหนด  Running No ไห้ครบ 5 หลัก...!" SKIP(1)
                           "ข้อมูลผิดพลาด  , กรุณาตรวจสอบข้อมูล"  VIEW-AS ALERT-BOX  ERROR TITLE "Policy Prefit 1 หลัก".
                   APPLY "ENTRY" TO fi_RunNo IN FRAME frCommand.
                   RETURN NO-APPLY.
                END.
                ELSE DO:
                   fi_Ex = fi_branch + SUBSTRING(fi_PolTyp,2,2) + SUBSTRING(fi_PolYear,3,2) + 
                           fi_Prefit +  STRING(INT(fi_RunNo), "99999").                                  
                
                   DISP fi_ex WITH FRAME frcommand.
                END.
           END.
        END.

    END.
    
     

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_SearchCompno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_SearchCompno Wgwrpol1
ON LEAVE OF fi_SearchCompno IN FRAME frCommand
DO:

  fi_searchcompno = INPUT fi_searchcompno.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_SearchCompno Wgwrpol1
ON VALUE-CHANGED OF fi_SearchCompno IN FRAME frCommand
DO:
  
    fi_searchcompno = INPUT fi_searchcompno.

    OPEN QUERY br_RunPol  
        FOR EACH RunPol_Fil NO-LOCK 
           WHERE RunPol_Fil.compno  >=  FRAME frCommand fi_searchcompno .  

    APPLY "VALUE-CHANGED" TO br_RunPol.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_type Wgwrpol1
ON LEAVE OF fi_type IN FRAME frCommand
DO:
  fi_type = INPUT fi_type.


  IF  LENGTH(TRIM(fi_branch)) = 2 THEN DO: 
      nv_type = TRIM(fi_branch).
  END.
  ELSE DO:  
      IF fi_PolTyp = "C90" THEN DO:
         IF fi_type = YES THEN nv_type = "D".
         ELSE nv_type = "C".
      END.
      ELSE DO:
         IF fi_type = YES THEN nv_type = "D".
         ELSE nv_type = "I".
      END.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Wgwrpol1 


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
  
  gv_prgid = "Wgwrpol1.W".
  gv_prog  = "Parameter Setup Policy Running No.".

  /*RUN  WSU\WSUHDExt (WSURPOL:handle,gv_prgid,gv_prog).*/
  RUN  WUT\WUTHEAD (Wgwrpol1:handle,gv_prgid,gv_prog). /*28/11/2006*/
  /*RUN  WUT\WUTWICEN (WSURPOL:handle). */
  /*
  RUN  WSU\WSUHDExt ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:handle). 
  */
/*********************************************************************/    
  SESSION:DATA-ENTRY-RETURN = Yes.   
  
  DISABLE ALL EXCEPT br_RunPol fi_searchcompno WITH FRAME frCommand.

  /*ENABLE br_RunPol WITH FRAME frCommand.*/
  
/*  
  FIND FIRST Company USE-INDEX Company01
       WHERE Company.Compno = n_Compno NO-LOCK NO-ERROR.
    IF AVAIL Company THEN DO:
       fi_Company = Company.Compno + "  :  " + Company.NAME.
    END.

  fi_branch  = n_branch.
  FIND xmm023 WHERE xmm023.branch = n_branch NO-LOCK NO-ERROR.
   IF AVAIL xmm023 THEN DO:      
      ASSIGN 
          fi_name_branch  = xmm023.bdes.
   END.  

  DISP fi_Company fi_branch fi_name_branch WITH FRAME frCommand.
*/

  RUN PDUpdateQ.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Wgwrpol1  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(Wgwrpol1)
  THEN DELETE WIDGET Wgwrpol1.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Wgwrpol1  _DEFAULT-ENABLE
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
  ENABLE RECT-1 RECT-406 RECT-415 buAcno1 but_Delete but_Add but_Edit but_Exit 
      WITH FRAME frMain IN WINDOW Wgwrpol1.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fi_Company fi_Compno fi_branch fi_PolTyp fi_type fi_typeDesc 
          fi_PolYear fi_PreFit fi_RunNo fi_name_branch fi_Ex fi_name_typ 
          fi_SearchCompno 
      WITH FRAME frCommand IN WINDOW Wgwrpol1.
  ENABLE fi_Company fi_Compno fi_branch fi_PolTyp fi_type fi_typeDesc 
         fi_PolYear fi_PreFit fi_RunNo but_SAVE butPoltyp br_RunPol 
         fi_name_branch fi_name_typ fi_SearchCompno but_Cancel RECT-2 RECT-3 
         RECT-4 RECT-409 RECT-410 RECT-413 RECT-5 RECT-8 RECT-9 RECT-7 RECT-6 
      WITH FRAME frCommand IN WINDOW Wgwrpol1.
  {&OPEN-BROWSERS-IN-QUERY-frCommand}
  VIEW Wgwrpol1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClearData Wgwrpol1 
PROCEDURE PDClearData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   ASSIGN            
      FRAME frCommand fi_Compno         fi_Compno   = ""
      FRAME frCommand fi_Company        fi_Company  = ""
      FRAME frCommand fi_Branch         fi_Branch   = ""
      FRAME frCommand fi_PolTyp         fi_PolTyp   = ""
      FRAME frCommand fi_name_Typ       fi_name_Typ = ""
      FRAME frCommand fi_PolYear        fi_PolYear  = ""
      FRAME frCommand fi_PreFit         fi_PreFit   = ""
      FRAME frCommand fi_RunNo          fi_RunNo    = ""      
      FRAME frCommand fi_Ex             fi_Ex       = "" 
      FRAME frCommand fi_type           fi_type     = YES
      FRAME frCommand fi_SearchCompNo   fi_SearchCompNo = "".
      
    DISP 
      fi_Compno
      fi_Company
      fi_Branch
      fi_type 
      fi_PolTyp  
      fi_name_Typ
      fi_PolYear 
      fi_PreFit  
      fi_RunNo      
      fi_Ex 
      fi_SearchCompNo
    WITH FRAME frCommand.    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateQ Wgwrpol1 
PROCEDURE PDUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 OPEN QUERY br_RunPol
          FOR EACH RunPol_fil  /*WHERE RunPol_fil.CompNo = n_compno AND
              RunPol_fil.Branch = n_branch*/ NO-LOCK.
              /*
              BY Runpol_fil.Compno
              BY RunPol_fil.Poltyp
              BY Runpol_fil.undyr.*/

APPLY "VALUE-CHANGED" TO br_RunPol IN FRAME frCommand.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

