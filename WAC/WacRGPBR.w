&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File:               WacRGrpBR.W

Description:        เป็นโปรแกรมเรียกรายงาน Premium โดยจัดรูปแบบรายงานเป็น
                    Group Region , Group Branch , Group BU
                    - ลำดับการ Gen ข้อมูลเป็นการ fix program ถ้ามี branch ใหม่ต้องปรับโปรแกรม
                    หรือถ้ามีการจัด Group ใหม่ก็ต้องปรับโปรแกรม
                    
Input Parameters:
<none>
Output Parameters:
<none>

Author:             Tantawan Ch. 

Created:            A61-0143  DATE : 14/03/2018
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
DEF VAR n_write   AS CHAR FORMAT "X(20)".
DEF VAR nv_write   AS CHAR FORMAT "X(20)".
DEF VAR nv_errfile AS CHAR FORMAT "X(20)".
DEF VAR n_type     AS CHAR FORMAT "X" INIT "9".
DEF VAR n_report   AS CHAR FORMAT "X" INIT "1".
DEF VAR nv_row     AS INT  FORMAT ">>>>9". /*INIT 1.*/

DEF VAR frm_trndat AS DATE FORMAT "99/99/9999" LABEL " From Trans.date  :  ".
DEF VAR to_trndat  AS DATE FORMAT "99/99/9999" LABEL " To                             :  ".
DEF VAR frm_bran   LIKE uwm100.branch LABEL " From Branch        :  ".
DEF VAR to_bran    LIKE uwm100.branch LABEL "To                            :  ".


DEF VAR n_bran   LIKE acm001.branch .
DEF VAR n_poltyp AS CHAR FORMAT "X(2)".
DEF VAR nv_output  AS CHAR FORMAT "x(20)" LABEL "Output to :  ".
DEF VAR nv_output2 AS CHAR FORMAT "x(20)" LABEL "Output to :  ".

DEF VAR nv_comp  LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Prem Comp".
DEF VAR nv_pa    LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Prem PA". 
DEF VAR nv_vol   LIKE uwd132.prem_c FORMAT "->>,>>>,>>>,>>9.99" LABEL "Prem motor". 
DEF VAR pol_prem LIKE uwm100.prem_t FORMAT "->>,>>>,>>>,>>9.99" LABEL "Policy Prem".

DEF VAR nv_reccnt    AS INT.
DEF VAR nv_brdes     AS CHAR.
DEF VAR nv_brdes1    AS CHAR.

DEF TEMP-TABLE wfByLine
    FIELD wfReg     AS CHAR FORMAT "X(5)"    
    FIELD wfGrp1    AS CHAR FORMAT "X(2)"
    FIELD wfGrp2    AS INT
    FIELD wfGLine   AS CHAR FORMAT "X(10)"
    FIELD wfpoltyp  AS CHAR FORMAT "X(05)"
    FIELD wfbran    AS CHAR FORMAT "X(02)"
    FIELD wfbdesc   AS CHAR FORMAT "X(35)"    
    FIELD wfdesc    AS CHAR FORMAT "X(15)"    
    FIELD wfprem    LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99" 
    FIELD wfpremp   LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99" 
    FIELD wfpremm   LIKE UWD132.PREM_C FORMAT "->>,>>>,>>>,>>9.99" 
          
    INDEX wfByLine01 IS UNIQUE PRIMARY wfReg  wfGrp1  wfGLine  wfpoltyp wfbran wfdesc ASCENDING.
    

DEF VAR n_desbr      AS  CHAR FORMAT "X(25)".
DEF VAR np_prem   LIKE UWD132.PREM_C.                   
DEF VAR ns_prem   LIKE UWD132.PREM_C.                   
DEF VAR nb_prem   LIKE UWD132.PREM_C.                   

DEF STREAM ns1.
DEF STREAM ns2.

DEF VAR n_ri       AS LOGICAL. /*--Yes = InwTreaty, No = InwFAC.--A51-0078--*/

DEFINE TEMP-TABLE wGrpReg
    FIELD wReg     AS CHAR FORMAT "X(5)"    
    FIELD wGrp1    AS CHAR FORMAT "X(2)"
    FIELD wGrp2    AS INT
    FIELD wBranch  AS CHAR FORMAT "X(5)"    
    FIELD wBrDesc  AS CHAR FORMAT "X(15)"   
    INDEX wGrpReg01 IS UNIQUE PRIMARY wBranch ASCENDING
    INDEX wGrpReg02 wReg.

DEF VAR n_HSln1    AS CHAR FORMAT "X(110)".
DEF VAR n_HSln2    AS CHAR FORMAT "X(110)".
DEF VAR n_HSln3    AS CHAR FORMAT "X(110)".

DEF VAR nv_reg     AS CHAR.
DEF VAR nv_grp1    AS CHAR.
DEF VAR nv_grp2    AS INT.

/* Region Group */
DEF VAR nv_GrpBR1  AS CHAR INIT "L,M,R,T,W,0,11,12,14,15,19,34,X,Y,V,17,". /* Active = 12 branchs */
DEF VAR nv_GrpBR2  AS CHAR INIT "90,91,92,93,94,95,96,97,98,99".

/* Branch Sequence -- INIT มีผลต่อการลำดับการแสดงของ branch ใน report */
DEF VAR nv_01BU1   AS CHAR INIT "0".
DEF VAR nv_02BU2   AS CHAR INIT "W,L".
DEF VAR nv_03BU3   AS CHAR INIT "M,19".
DEF VAR nv_04BU4   AS CHAR INIT "R,11,34,12,T,15,14". /* Ratchapluek,Rungsit,Ayuthaya,Suksawat,Theparuk,Onnut,Navamin*/
DEF VAR nv_05SP5   AS CHAR INIT "Y".  /* Special Product */
DEF VAR nv_06NZI   AS CHAR INIT "90,91,92,93,94,95,96,97,98,99".
DEF VAR nv_07NOR   AS CHAR INIT "1,2,H,61,G,65,62,63,64".   /*ยังไม่มีกรมธรรม์ 62,63,64 @2018-05-17 */
DEF VAR nv_08SOU   AS CHAR INIT "4,D,86,7,9,81,8,84,B,83,C,E,85,N,82,89,88".
DEF VAR nv_09NOE   AS CHAR INIT "3,6,K,S,71,73,72,76,77,74,75,79,78,51".
DEF VAR nv_10WES   AS CHAR INIT "44,A,41,I,33,U,31,32".
DEF VAR nv_11EAS   AS CHAR INIT "42,F,43,37,J,P,5,36,38,39,35".           
DEF VAR nv_12OTH   AS CHAR .     

DEF VAR nv_1Motor   AS CHAR INIT "70,71,72,73,74,70PA".
DEF VAR nv_2Fire    AS CHAR INIT "10,11,12,14,15,16,17,18,19,20,32,33,34,35,36,39".
DEF VAR nv_3Marine  AS CHAR INIT "90,91,92,93".
DEF VAR nv_4PA      AS CHAR INIT "60,62,63,64,67,68,69".
DEF VAR nv_5Misc    AS CHAR INIT "21,22,23,24,25,26,37,38,40,41,42,43,44,45,46,47,48,49,61,65,66,80,81,82,83,84,85,86".
DEF VAR nv_6Inno    AS CHAR INIT "4,04,30".
DEF VAR nv_7Other   AS CHAR .

DEF VAR nv_GLine    AS CHAR .
DEF VAR nv_CBrn     AS INT.

DEF VAR nv_wReg     AS CHAR.
DEF VAR nv_wGrp1    AS CHAR.
DEF VAR nv_wGrp2    AS INT.
DEF VAR nv_GBranch  AS CHAR.
DEF VAR nv_bdesc    AS CHAR FORMAT "X(35)".
DEF VAR n_source AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_grprp

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wGrpReg

/* Definitions for BROWSE br_grprp                                      */
&Scoped-define FIELDS-IN-QUERY-br_grprp wGrpReg.wReg wGrpReg.wGrp1 wGrpReg.wGrp2 wGrpReg.wBranch wGrpReg.wBrDesc   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_grprp   
&Scoped-define SELF-NAME br_grprp
&Scoped-define QUERY-STRING-br_grprp FOR EACH wGrpReg
&Scoped-define OPEN-QUERY-br_grprp OPEN QUERY {&SELF-NAME} FOR EACH wGrpReg.
&Scoped-define TABLES-IN-QUERY-br_grprp wGrpReg
&Scoped-define FIRST-TABLE-IN-QUERY-br_grprp wGrpReg


/* Definitions for FRAME fr_prem                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_prem ~
    ~{&OPEN-QUERY-br_grprp}

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
     SIZE 12.5 BY 1.29
     FONT 36.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 12.5 BY 1.29
     FONT 36.

DEFINE VARIABLE fi_datfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_datto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_frbrn AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 35.33 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_outputdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 52.5 BY .62
     BGCOLOR 3 FGCOLOR 137 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tobrn AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1.05
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE ra_poltyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Direct", 1,
"Inward Fac", 2
     SIZE 30 BY .95 NO-UNDO.

DEFINE VARIABLE ra_reptype AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Group Summary", 1,
"Detail", 2
     SIZE 35 BY .95 NO-UNDO.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119.5 BY 16.1
     BGCOLOR 3 FGCOLOR 15 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_grprp FOR 
      wGrpReg SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_grprp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_grprp C-Win _FREEFORM
  QUERY br_grprp DISPLAY
      wGrpReg.wReg        COLUMN-LABEL "Region"      FORMAT "x(5)"
wGrpReg.wGrp1       COLUMN-LABEL "Grp1"        FORMAT "X(10)"
wGrpReg.wGrp2       COLUMN-LABEL "Grp2"        FORMAT ">9"
wGrpReg.wBranch     COLUMN-LABEL "Br."         FORMAT "x(4)"
wGrpReg.wBrDesc     COLUMN-LABEL "Branch Desc."      FORMAT "x(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 59.33 BY 14.29
         FONT 6 ROW-HEIGHT-CHARS .71.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 124 BY 17.91.

DEFINE FRAME fr_prem
     br_grprp AT ROW 1.71 COL 119.5 RIGHT-ALIGNED WIDGET-ID 100
     ra_poltyp AT ROW 7.19 COL 24 NO-LABEL WIDGET-ID 8
     fi_datfr AT ROW 1.95 COL 21.83 COLON-ALIGNED NO-LABEL
     fi_datto AT ROW 3.24 COL 21.83 COLON-ALIGNED NO-LABEL
     fi_frbrn AT ROW 4.57 COL 21.83 COLON-ALIGNED NO-LABEL
     fi_tobrn AT ROW 5.86 COL 21.83 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 9.76 COL 21.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 13 COL 23.83
     bu_exit AT ROW 13 COL 39.83
     fi_outputdesc AT ROW 11.19 COL 4.33 COLON-ALIGNED NO-LABEL
     ra_reptype AT ROW 8.48 COL 24 NO-LABEL WIDGET-ID 12
     "To :" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 3.24 COL 18.67
          BGCOLOR 3 FGCOLOR 15 FONT 36
     " หมายเหตุ :  หากมีสาขาเพิ่มและมีการออกรมธรรม์ BU. ต้องขอปรับโปรแกรม" VIEW-AS TEXT
          SIZE 58.5 BY .81 AT ROW 16.24 COL 3 WIDGET-ID 2
          BGCOLOR 7 FGCOLOR 6 FONT 1
     " เพื่อเพิ่มการจัดกลุ่มของสาขาใหม่ด้วยทุกครั้ง..." VIEW-AS TEXT
          SIZE 59 BY .81 AT ROW 16.24 COL 61.5 WIDGET-ID 4
          BGCOLOR 7 FGCOLOR 6 FONT 1
     "DI / INW :" VIEW-AS TEXT
          SIZE 10.5 BY 1.05 AT ROW 7.1 COL 12.33 WIDGET-ID 6
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Report Type :" VIEW-AS TEXT
          SIZE 14.83 BY 1.05 AT ROW 8.38 COL 8 WIDGET-ID 16
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Data Gen Group Line >> C:~\temp~\GroupLineBranch.txt" VIEW-AS TEXT
          SIZE 57.33 BY .81 AT ROW 15.29 COL 3.17 WIDGET-ID 18
          BGCOLOR 3 FGCOLOR 0 FONT 1
     "Branch From :" VIEW-AS TEXT
          SIZE 15.5 BY 1.05 AT ROW 4.57 COL 7.67
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "To :" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 5.86 COL 18.83
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Trans Date From :" VIEW-AS TEXT
          SIZE 20.5 BY 1.05 AT ROW 1.95 COL 3.17
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Output to File :" VIEW-AS TEXT
          SIZE 15.67 BY 1.05 AT ROW 9.76 COL 7
          BGCOLOR 3 FGCOLOR 15 FONT 36
     RECT-17 AT ROW 1.24 COL 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 1.1
         SIZE 122.5 BY 17.52
         BGCOLOR 8 FGCOLOR 2 FONT 6
         TITLE BGCOLOR 15 FGCOLOR 1 "Summary Premium by Branch and by Region".


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
         TITLE              = "<insert window title>"
         HEIGHT             = 17.86
         WIDTH              = 123.83
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME fr_prem:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME fr_prem
   Custom                                                               */
/* BROWSE-TAB br_grprp 1 fr_prem */
/* SETTINGS FOR BROWSE br_grprp IN FRAME fr_prem
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_grprp
/* Query rebuild information for BROWSE br_grprp
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wGrpReg.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_grprp */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_prem
&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_prem /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_prem /* OK */
DO:
/*--Lukkana 24/07/2008--*/
ASSIGN nv_output  = ""
       nv_output2 = "".


FOR EACH wfbyline.
    DELETE wfbyline.
END.

/*--Lukkana 24/07/2008--*/

ASSIGN frm_trndat = fi_datfr
       to_trndat  = fi_datto
       frm_bran   = fi_frbrn
       to_bran    = fi_tobrn.

    IF fi_output <> ""  THEN DO: 
        nv_output = nv_write.

        IF ra_poltyp = 1 THEN RUN Proc_DetailsD.
                         ELSE RUN Proc_DetailsI.

        VIEW fi_outputdesc.
        DISP fi_outputdesc WITH FRAME {&FRAME-NAME}. 

        MESSAGE "Process Data Complete!!!" VIEW-AS ALERT-BOX INFORMATION
        TITLE "Premium By Branch and Group Region To Excel".

    END.
    ELSE MESSAGE "โปรดระบุชื่อไฟล์ OUTPUT" VIEW-AS ALERT-BOX WARNING.

    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datfr C-Win
ON LEAVE OF fi_datfr IN FRAME fr_prem
DO:
    ASSIGN
        fi_datfr = INPUT FRAME {&FRAME-NAME} fi_datfr.

        IF fi_datto = ? THEN fi_datto = fi_datfr.
        IF fi_datfr = ? AND fi_datto = ? THEN 
            MESSAGE "Please, Key In From Date" 
            VIEW-AS ALERT-BOX INFORMATION.

        DISP fi_datfr fi_datto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datto C-Win
ON LEAVE OF fi_datto IN FRAME fr_prem
DO:
  ASSIGN 
     fi_datto = INPUT FRAME {&FRAME-NAME} fi_datto
     to_trndat  = fi_datto.

  IF fi_datto = ?  THEN
     MESSAGE  "Please, Key In To Date"
     VIEW-AS ALERT-BOX INFORMATION.

  IF fi_datto < fi_datfr THEN
     MESSAGE "DATE TO ต้องมากกว่าหรือเท่ากับ DATE FROM"
     VIEW-AS ALERT-BOX INFORMATION.

  DISP fi_datto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_frbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_frbrn C-Win
ON LEAVE OF fi_frbrn IN FRAME fr_prem
DO:
ASSIGN fi_frbrn = CAPS (INPUT FRAME {&FRAME-NAME} fi_frbrn).
DISP fi_frbrn WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_prem
DO:
   ASSIGN n_write    = ""
          nv_write   = ""
          nv_errfile = "".
   HIDE fi_outputdesc.
   ASSIGN  fi_output = INPUT fi_output.
   IF fi_output <> "" THEN DO:
      ASSIGN  n_write = CAPS(INPUT fi_output)
              nv_write   = n_write   
              nv_errfile = n_write + ".ERR". 
   END.

  DISP fi_output WITH FRAME {&FRAME-NAME}.
   

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tobrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tobrn C-Win
ON LEAVE OF fi_tobrn IN FRAME fr_prem
DO:
  ASSIGN  fi_tobrn = CAPS (INPUT FRAME {&FRAME-NAME} fi_tobrn).
  DISP fi_tobrn WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_poltyp C-Win
ON VALUE-CHANGED OF ra_poltyp IN FRAME fr_prem
DO:
  ra_poltyp = INPUT ra_poltyp.
  DISP ra_poltyp WITH FRAME fr_prem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_reptype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_reptype C-Win
ON VALUE-CHANGED OF ra_reptype IN FRAME fr_prem
DO:
  ra_reptype = INPUT ra_reptype.
  DISP ra_reptype WITH FRAME fr_prem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_grprp
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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  gv_prgid = "WacRGPBR".
  gv_prog  = "Summary Premium by Branch and by Region".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:handle).
  Session:data-Entry-Return = Yes.

  ASSIGN  
          n_report = "1"
          nv_grp1   = ""
          nv_grp2   = 0
          nv_reg    = "" .

  APPLY "Entry" TO fi_datfr .

  ASSIGN fi_datfr  = TODAY
         fi_datto  = TODAY
         fi_frbrn  = "0"
         fi_tobrn  = "Z" 
         ra_poltyp = 1
         ra_reptype = 1.

  DISP  fi_datfr fi_datto fi_frbrn fi_tobrn ra_poltyp ra_reptype WITH FRAME fr_prem.

  RUN pd_AddGpReport. /* จัดกลุ่ม branch ตาม default เริ่มต้นก่อน */

  IF NOT THIS-PROCEDURE:PERSISTENT THEN 
  WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ClearValue C-Win 
PROCEDURE ClearValue :
/*------------------------------------------------------------------------------
  Purpose:  Clear ค่าตัวแปรต่างๆ   
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
   nv_comp  = 0  nv_vol   = 0  nv_pa    = 0 pol_prem = 0  
   np_prem  = 0  nb_prem  = 0  .

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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY ra_poltyp fi_datfr fi_datto fi_frbrn fi_tobrn fi_output fi_outputdesc 
          ra_reptype 
      WITH FRAME fr_prem IN WINDOW C-Win.
  ENABLE br_grprp ra_poltyp fi_datfr fi_datto fi_frbrn fi_tobrn fi_output bu_ok 
         bu_exit fi_outputdesc ra_reptype RECT-17 
      WITH FRAME fr_prem IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_prem}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdBrn C-Win 
PROCEDURE pdBrn :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* ---By Sayamol A54-0244 ---- */
ASSIGN
  nv_brdes  = ""
  nv_brdes1 = "".
FOR EACH xmm023 USE-INDEX xmm02301 WHERE
         xmm023.branch >= frm_bran   AND
         xmm023.branch <= to_bran    NO-LOCK.

   IF LENGTH(xmm023.branch)     = 2 THEN DO:
       IF SUBSTRING(xmm023.branch,1,1) = "9"  AND SUBSTRING(xmm023.branch,2,1) <> "0"  
           THEN ASSIGN nv_brdes  = nv_brdes  + "," + SUBSTRING(xmm023.branch,2,1)
                       nv_brdes  = nv_brdes  + "," + xmm023.branch 
                       nv_brdes1 = nv_brdes1 + "," + xmm023.branch .
       ELSE nv_brdes = nv_brdes + "," + xmm023.branch   .
   END.
   ELSE IF LENGTH(xmm023.branch)     = 1 THEN nv_brdes = nv_brdes + "," + xmm023.branch .
END.
/* --- end A54-0244 ---- */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_AddGpReport C-Win 
PROCEDURE pd_AddGpReport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  nv_reg  = "". 
  nv_CBrn = 0.

  FOR EACH wGrpReg . DELETE wGrpReg. END.

  FOR EACH xmm023 USE-INDEX xmm02301 WHERE
           xmm023.branch >= fi_frbrn   AND
           xmm023.branch <= fi_tobrn   NO-LOCK.

      IF LOOKUP(xmm023.branch,"17,V,X") > 0 THEN NEXT.

      /* Group Region */
           IF LOOKUP(xmm023.branch,nv_GrpBR1) > 0 THEN nv_Reg = "1HO" .  /* HEAD OFFICE */
      ELSE IF LOOKUP(xmm023.branch,nv_GrpBR2) > 0 THEN nv_Reg = "3PB" .  /* New Petchburi - NZI */
      ELSE nv_reg = "2BR" .                                              /* BRANCH */

      /* Sequence Branch on each Region */
      /* HO Region */
           IF LOOKUP(xmm023.branch,nv_01BU1) > 0 THEN DO: 
          nv_grp1 = "01BU1".
          nv_grp2 = LOOKUP(xmm023.branch,nv_01BU1) NO-ERROR.
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_02BU2) > 0 THEN DO: 
          nv_grp1 = "02BU2".
          nv_grp2 = LOOKUP(xmm023.branch,nv_02BU2) NO-ERROR .
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_03BU3) > 0 THEN DO: 
          nv_grp1 = "03BU3".
          nv_grp2 = LOOKUP(xmm023.branch,nv_03BU3) NO-ERROR .
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_04BU4) > 0 THEN DO: 
          nv_grp1 = "04BU4".
          nv_grp2 = LOOKUP(xmm023.branch,nv_04BU4) NO-ERROR .
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_05SP5) > 0 THEN DO: 
          nv_grp1 = "05SPECIAL PRODUCT".
          nv_grp2 = LOOKUP(xmm023.branch,nv_05SP5) NO-ERROR .
      END.
      /* NZI */
      ELSE IF LOOKUP(xmm023.branch,nv_06NZI) > 0 THEN DO: 
          nv_grp1 = "06PHETCHABURI(NEW)".   
          nv_grp2 = LOOKUP(xmm023.branch,nv_06NZI) NO-ERROR .
      END.
      /* BRN Region */
      ELSE IF LOOKUP(xmm023.branch,nv_07NOR) > 0 THEN DO: 
          nv_grp1 = "07NORTH".   
          nv_grp2 = LOOKUP(xmm023.branch,nv_07NOR) NO-ERROR .
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_08SOU) > 0 THEN DO: 
          nv_grp1 = "08SOUTH".   
          nv_grp2 = LOOKUP(xmm023.branch,nv_08SOU) NO-ERROR .
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_09NOE) > 0 THEN DO: 
          nv_grp1 = "09NORTH EAST".   
          nv_grp2 = LOOKUP(xmm023.branch,nv_09NOE) NO-ERROR .
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_10WES) > 0 THEN DO: 
          nv_grp1 = "10WEST".   
          nv_grp2 = LOOKUP(xmm023.branch,nv_10WES) NO-ERROR .
      END.
      ELSE IF LOOKUP(xmm023.branch,nv_11EAS) > 0 THEN DO: 
          nv_grp1 = "11EAST".   
          nv_grp2 = LOOKUP(xmm023.branch,nv_11EAS) NO-ERROR .
      END.
      ELSE DO: 
          nv_CBrn = nv_CBrn + 1.

          nv_grp1 = "12OTHER".
          nv_grp2 = nv_CBrn NO-ERROR .
      END.

      FIND LAST wGrpReg WHERE wGrpReg.wBranch = xmm023.branch NO-LOCK NO-ERROR.
      IF NOT AVAIL wGrpReg THEN DO:
          CREATE wGrpReg.
          ASSIGN
            wGrpReg.wReg     =  nv_Reg          /* 1HO , 2BR , 3PB */
            wGrpReg.wGrp1    =  nv_grp1         /* 1BU1 , 2BU2 , 3BU3 , 4BU4 , 5BRN , 6NZI  */
            wGrpReg.wGrp2    =  nv_grp2         /* Seq.No ของ Grp1 */
            wGrpReg.wBranch  =  trim(xmm023.branch)
            wGrpReg.wBrDesc  =  IF xmm023.branch = "Y" THEN "SPECIAL PRODUCT" ELSE xmm023.bdes.
      END.

  END.

  OPEN QUERY br_grprp
      FOR EACH wGrpReg BY wGrpReg.wReg BY wGrpReg.wGrp1  BY wGrpReg.wGrp2.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_GenGlineOther C-Win 
PROCEDURE pd_GenGlineOther :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER  pv_wReg    AS CHAR .  /* 1HO  */
DEF INPUT PARAMETER  pv_wGrp1   AS CHAR .  /* 1BU1 */
DEF INPUT PARAMETER  pv_wGrp2   AS INT  .  /* 1,2,3...*/
DEF INPUT PARAMETER  pv_GBranch AS CHAR .  /* 0 , W , L , M , 4 .....*/
DEF INPUT PARAMETER  pv_bdesc   AS CHAR .  /* Branch Description */

    FIND FIRST wfByLine 
        WHERE wfReg    = pv_wReg  
        AND   wfGrp1   = pv_wGrp1
        AND   wfGrp2   = pv_wGrp2
        AND   wfGLine  = "1Motor" 
        AND   wfpoltyp = "70"
        AND   wfbran   = nv_GBranch 
        AND   wfdesc   = "prem + " NO-LOCK NO-ERROR.
    IF NOT AVAIL wfByLine THEN DO:
        CREATE wfByLine.
        ASSIGN
          wfReg    = pv_wReg     
          wfGrp1   = pv_wGrp1    
          wfGrp2   = pv_wGrp2
          wfGLine  = "1Motor" 
          wfpoltyp = "70"    
          wfbran   = pv_GBranch
          wfbdesc  = pv_bdesc
          wfdesc   = "prem + "  
          wfpremp  = 0 
          wfpremm  = 0 .
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "New Gen : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.
    ELSE DO:
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "Found   : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.

    FIND FIRST wfByLine 
        WHERE wfReg    = pv_wReg  
        AND   wfGrp1   = pv_wGrp1
        AND   wfGrp2   = pv_wGrp2
        AND   wfGLine  = "2Fire" 
        AND   wfpoltyp = "10"
        AND   wfbran   = nv_GBranch 
        AND   wfdesc   = "prem + " NO-LOCK NO-ERROR.
    IF NOT AVAIL wfByLine THEN DO:
        CREATE wfByLine.
        ASSIGN
          wfReg    = pv_wReg     
          wfGrp1   = pv_wGrp1    
          wfGrp2   = pv_wGrp2
          wfGLine  = "2Fire" 
          wfpoltyp = "10"   
          wfbran   = pv_GBranch
          wfbdesc  = pv_bdesc
          wfdesc   = "prem + "  
          wfpremp  = 0 
          wfpremm  = 0 .
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "New Gen : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.
    ELSE DO:
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "Found   : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.

    
    FIND FIRST wfByLine 
        WHERE wfReg    = pv_wReg  
        AND   wfGrp1   = pv_wGrp1
        AND   wfGrp2   = pv_wGrp2
        AND   wfGLine  = "3Marine" 
        AND   wfpoltyp = "90"     
        AND   wfbran   = nv_GBranch 
        AND   wfdesc   = "prem + " NO-LOCK NO-ERROR.
    IF NOT AVAIL wfByLine THEN DO:
        CREATE wfByLine.
        ASSIGN
          wfReg    = pv_wReg     
          wfGrp1   = pv_wGrp1    
          wfGrp2   = pv_wGrp2
          wfGLine  = "3Marine" 
          wfpoltyp = "90"     
          wfbran   = pv_GBranch
          wfbdesc  = pv_bdesc
          wfdesc   = "prem + "  
          wfpremp  = 0 
          wfpremm  = 0 .
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "New Gen : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.
    ELSE DO:
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
PUT "Found   : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.

    FIND FIRST wfByLine 
        WHERE wfReg    = pv_wReg  
        AND   wfGrp1   = pv_wGrp1
        AND   wfGrp2   = pv_wGrp2
        AND   wfGLine  = "4PA" 
        AND   wfpoltyp = "60"
        AND   wfbran   = nv_GBranch 
        AND   wfdesc   = "prem + " NO-LOCK NO-ERROR.
    IF NOT AVAIL wfByLine THEN DO:
        CREATE wfByLine.
        ASSIGN
          wfReg    = pv_wReg     
          wfGrp1   = pv_wGrp1    
          wfGrp2   = pv_wGrp2
          wfGLine  = "4PA" 
          wfpoltyp = "60" 
          wfbran   = pv_GBranch
          wfbdesc  = pv_bdesc
          wfdesc   = "prem + "  
          wfpremp  = 0 
          wfpremm  = 0 .
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "New Gen : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.

    END.
    ELSE DO:
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "Found   : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.

    
    FIND FIRST wfByLine 
        WHERE wfReg    = pv_wReg  
        AND   wfGrp1   = pv_wGrp1
        AND   wfGrp2   = pv_wGrp2
        AND   wfGLine  = "5Misc" 
        AND   wfpoltyp = "21"
        AND   wfbran   = nv_GBranch 
        AND   wfdesc   = "prem + " NO-LOCK NO-ERROR.
    IF NOT AVAIL wfByLine THEN DO:
        CREATE wfByLine.
        ASSIGN
          wfReg    = pv_wReg     
          wfGrp1   = pv_wGrp1    
          wfGrp2   = pv_wGrp2
          wfGLine  = "5Misc" 
          wfpoltyp = "21"   
          wfbran   = pv_GBranch
          wfbdesc  = pv_bdesc
          wfdesc   = "prem + "  
          wfpremp  = 0 
          wfpremm  = 0 .
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "New Gen : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.

    END.
    ELSE DO:
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "Found   : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.

    
    FIND FIRST wfByLine 
        WHERE wfReg    = pv_wReg  
        AND   wfGrp1   = pv_wGrp1
        AND   wfGrp2   = pv_wGrp2
        AND   wfGLine  = "6Inno" 
        AND   wfpoltyp = "30"
        AND   wfbran   = nv_GBranch 
        AND   wfdesc   = "prem + " NO-LOCK NO-ERROR.
    IF NOT AVAIL wfByLine THEN DO:
        CREATE wfByLine.
        ASSIGN
          wfReg    = pv_wReg     
          wfGrp1   = pv_wGrp1    
          wfGrp2   = pv_wGrp2
          wfGLine  = "6Inno"
          wfpoltyp = "30"   
          wfbran   = pv_GBranch
          wfbdesc  = pv_bdesc
          wfdesc   = "prem + "  
          wfpremp  = 0 
          wfpremm  = 0 .
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "New Gen : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.
    ELSE DO:
OUTPUT TO C:\temp\GroupLineBranch.txt APPEND.
    PUT "Found   : " wfReg    wfGrp2   wfGLine  wfpoltyp wfbran SKIP.
OUTPUT CLOSE.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Detail C-Win 
PROCEDURE Proc_Detail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

  OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
    EXPORT DELIMITER ";"
        "Group Region"
        "Group BU."
        "Group Line"
        "Branch"
        "Pol.type"
        "Desc"
        "Prem +"
        "Prem -".
  OUTPUT CLOSE.     

  FOR EACH wfByLine 
      BREAK BY wfReg 
            BY wfGrp1 
            BY wfGrp2 
            BY wfGLine
            BY wfBran:
      
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
      EXPORT DELIMITER ";"
          trim(substring(wfReg,2))      /* 1HO , 2BR , 3PB */
          trim(substring(wfGrp1,3))     /* 01BU1 , 02BU2 , 03BU3 , 04BU4 , 05SPECIAL PRODUCT ...*/
          /*wfGrp2     /* 1 , 2 */*/
          trim(substring(wfGLine,2))    /* 1Motor , 2Fire , 3Marine , 4PA , 5Misc , 6Inno , 7Other ...*/
          wfbran     /* 0 , M , L , W , ...*/ 
          wfpoltyp   /* 70 , 70PA , 72 , 73 , 74 , 10 , 11 , 90 ...*/
          wfdesc     /* prem + , prem - */
          wfpremm    /* premium due + */  /* ยอด + ไม่ put */
          wfprem     /* premium due - */.
          
          /*wfbdesc    /*   */*/
      OUTPUT CLOSE.

   END.  /* FOR EACH wfbyline */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_DetailsD C-Win 
PROCEDURE Proc_DetailsD :
/*------------------------------------------------------------------------------
  Purpose:      Process Detail to Workfile (Direct)
  Parameters:  <None>
  Notes:   
------------------------------------------------------------------------------*/
DEF VAR nv_cnt AS INTE.
nv_reccnt = 0.
  
/*nv_output2 = nv_output + STRING(nv_next) + "Sum.SLK".*/
IF ra_reptype = 1 THEN nv_output2 = nv_output + "Sum.SLK".
                  ELSE nv_output2 = nv_output + "Det.SLK".
ASSIGN fi_outputdesc = nv_output2.

loop_acm001:
FOR EACH acm001 NO-LOCK USE-INDEX acm00191 WHERE  acm001.trndat >= frm_trndat 
         AND  acm001.trndat <= to_trndat  
         AND (acm001.trnty1  = "A" OR acm001.trnty1  = "B" OR
              acm001.trnty1  = "M" OR acm001.trnty1  = "R" OR
              acm001.trnty1  = "O" OR acm001.trnty1  = "T" OR
              acm001.trnty1  = "Q" OR acm001.trnty1  = "V" )
         AND (SUBSTR(acm001.policy,1,1) = "D" OR
             (SUBSTR(acm001.policy,1,2) >= "10" AND SUBSTRING(acm001.policy,1,2) <= "99"))
         AND acm001.branch >= frm_bran
         AND acm001.branch <= to_bran
BREAK 
      BY acm001.branch
      BY SUBSTR(acm001.policy,3,2) 
      BY acm001.recno
      BY acm001.policy   
      BY acm001.rencnt
      BY acm001.endcnt
      BY acm001.trndat. 
    /*---A50-0178----*/
    n_ri = NO.
    
    ASSIGN
     n_bran     = TRIM(acm001.branch)
     n_poltyp   = SUBSTR(acm001.policy,3,2).
     
     
     FIND FIRST uwm100 USE-INDEX uwm10090 WHERE
                   uwm100.trty11 = acm001.trnty1 AND
                   uwm100.docno1 = acm001.docno  AND
                   uwm100.policy = acm001.policy AND   
                   uwm100.releas = YES NO-LOCK NO-ERROR.
     IF NOT AVAILABLE uwm100 THEN NEXT loop_acm001.
        DISP uwm100.policy uwm100.trty11 uwm100.trndat FORMAT 99/99/9999 
        WITH COLOR blue/withe NO-LABEL 
        TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
     IF acm001.prem <> uwm100.prem_t THEN DO:   /*Prem.AC. กับ UW ไม่เท่ากัน*/
        OUTPUT TO VALUE (nv_errfile) APPEND NO-ECHO.
            EXPORT DELIMITER ";" "policy        =" uwm100.policy.
            EXPORT DELIMITER ";" "rencnt        =" uwm100.rencnt.
            EXPORT DELIMITER ";" "endcnt        =" uwm100.endcnt.
            EXPORT DELIMITER ";" "Com date      =" uwm100.comdat.
            EXPORT DELIMITER ";" "Tran date     =" uwm100.trndat.
            EXPORT DELIMITER ";" "uwm100.prem_t =" uwm100.prem_t.
            EXPORT DELIMITER ";" "acm001.prem   =" acm001.prem.
            EXPORT DELIMITER ";" "acm001.netloc =" acm001.netloc.
            EXPORT DELIMITER ";" "".
            EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.
     END.

     /* จัดกลุ่ม Line */
          IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_1Motor)  > 0 THEN nv_GLine = "1Motor".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_2Fire)   > 0 THEN nv_GLine = "2Fire".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_3Marine) > 0 THEN nv_GLine = "3Marine".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_4PA)     > 0 THEN nv_GLine = "4PA".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_5Misc)   > 0 THEN nv_GLine = "5Misc".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_6Inno)   > 0 THEN nv_GLine = "6Inno".
                                                                 ELSE nv_GLine = "7Other".
     ASSIGN
       nv_wReg      = ""
       nv_wGrp1     = ""
       nv_wGrp2     = 0
       nv_GBranch   = ""
       nv_bdesc     = "".
     
     FIND FIRST wGrpReg WHERE wGrpReg.wBranch = n_bran NO-LOCK NO-ERROR.
     IF AVAIL wGrpReg THEN 
          ASSIGN 
            nv_wReg    = wGrpReg.wReg  
            nv_wGrp1   = wGrpReg.wGrp1 
            nv_wGrp2   = wGrpReg.wGrp2 
            nv_GBranch = wGrpReg.wBranch
            nv_bdesc   = wGrpReg.wBrDesc.
     ELSE ASSIGN
            nv_wReg    = "NOT FOUND"
            nv_wGrp1   = "NOT FOUND"
            nv_wGrp2   = 0
            nv_GBranch = "ERROR" + n_bran .

     /*---------- Motor ---------*/
     IF (SUBSTRING(acm001.policy,3,2) = "70" OR SUBSTRING(acm001.policy,3,2) = "72" OR 
         SUBSTRING(acm001.policy,3,2) = "73" OR SUBSTRING(acm001.policy,3,2) = "74")  THEN DO:
         ASSIGN  nv_comp = 0         
                 nv_pa   = 0.
         FOR EACH uwd132 NO-LOCK 
             WHERE uwd132.policy = uwm100.policy
               AND uwd132.rencnt = uwm100.rencnt
               AND uwd132.endcnt = uwm100.endcnt
               AND uwd132.prem_c <> ?.
    
                  IF uwd132.bencod = "comp" THEN nv_comp = nv_comp + uwd132.prem_c.
             ELSE IF uwd132.bencod = "pa"   THEN nv_pa   = nv_pa   + uwd132.prem_c.        
             
         END. /*EACH UWD132*/  
                    
         nv_vol   = uwm100.prem_t - nv_comp - nv_pa.
         pol_prem = nv_vol  + nv_comp  + nv_pa.   /*PREMIUM*/

         RUN pro_motor.

     END. 
     /*----------- Non Motor -------------*/
     ELSE DO:
         ASSIGN  nv_comp = 0  
                 nv_pa   = 0. 

         FOR EACH uwd132 NO-LOCK 
             WHERE uwd132.policy = uwm100.policy
              AND uwd132.rencnt = uwm100.rencnt
              AND uwd132.endcnt = uwm100.endcnt
              AND uwd132.prem_c <> ?.
    
                  IF uwd132.bencod = "comp" THEN nv_comp = nv_comp + uwd132.prem_c.
             ELSE IF uwd132.bencod = "pa"   THEN nv_pa   = nv_pa   + uwd132.prem_c.
              
             nv_vol   = uwm100.prem_t    - nv_comp   -   nv_pa.
             pol_prem = nv_vol  + nv_comp  + nv_pa .   /* PREMIUM  */
                 
         END.   /*Each uwd132*/
       
         IF SUBSTR(acm001.policy,1,2) = "IY" AND acm001.acno = "0APTHAI" THEN 
             ASSIGN n_ri = YES
                    n_poltyp = SUBSTR(acm001.policy,3,2) + "T".
         ELSE n_ri = NO.
     
         RUN pro_Nonmotor.
     
     END.  /*--- End Non Motor ---*/ 
     ASSIGN 
         nv_vol   = 0   nv_comp     = 0   
         nv_pa    = 0   pol_prem    = 0.
    
     IF LAST-OF (acm001.branch) THEN DO:

         OUTPUT TO C:\temp\GroupLineBranch.txt .
           PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SKIP. 
         OUTPUT CLOSE.

         RUN pd_GenGlineOther (INPUT nv_wReg   , /* 1HO  */
                                     nv_wGrp1  , /* 1BU1 */
                                     nv_wGrp2  , /* 1,2,3...*/
                                     n_bran    , /* 0 , W , L , M , 4 .....*/
                                     nv_bdesc  ). /* Branch Description */
     END.
 END.
 
 IF ra_reptype = 1 THEN RUN Proc_SumTotalD.
                   ELSE RUN Proc_Detail.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_DetailsI C-Win 
PROCEDURE Proc_DetailsI :
/*------------------------------------------------------------------------------
  Purpose:      Process Detail to Workfile (Direct)
  Parameters:  <None>
  Notes:   
------------------------------------------------------------------------------*/
DEF VAR nv_cnt AS INTE.
nv_reccnt = 0.

IF ra_reptype = 1 THEN nv_output2 = nv_output + "Sum.SLK".
                  ELSE nv_output2 = nv_output + "Det.SLK".
ASSIGN fi_outputdesc = nv_output2.

RUN pdBrn.

loop_acm001:
FOR EACH acm001 NO-LOCK USE-INDEX acm00191 WHERE  acm001.trndat >= frm_trndat 
         AND  acm001.trndat <= to_trndat  
         AND (acm001.trnty1  = "A" OR acm001.trnty1  = "B" OR
              acm001.trnty1  = "M" OR acm001.trnty1  = "R" OR
              acm001.trnty1  = "O" OR acm001.trnty1  = "T" OR
              acm001.trnty1  = "Q" OR acm001.trnty1  = "V" ) AND
         (SUBSTRING(acm001.policy,1,1) = "I" AND INDEX(nv_brdes, "," + acm001.branch) <> 0 ) 
         AND acm001.branch >= frm_bran
         AND acm001.branch <= to_bran
BREAK 
      BY acm001.branch
      BY SUBSTR(acm001.policy,3,2) 
      BY acm001.recno
      BY acm001.policy   
      BY acm001.rencnt
      BY acm001.endcnt
      BY acm001.trndat. 
    /*---A50-0178----*/
    n_ri = NO.
    
    ASSIGN
     n_bran     = TRIM(acm001.branch)
     n_poltyp   = SUBSTR(acm001.policy,3,2).
     

    IF SUBSTR(acm001.policy,1,1) = "I" THEN DO:
        IF nv_brdes1 = ""  THEN NEXT loop_acm001.  
        IF INDEX(nv_brdes1,",9" + SUBSTRING(acm001.policy,2,1)) <> 0 THEN n_bran = "9" + SUBSTRING(acm001.policy,2,1). 
           /*Policy Branch 91 : I17061000001 
                           92 : I27061000001  */
     END.
     
     FIND FIRST uwm100 USE-INDEX uwm10090 WHERE
                   uwm100.trty11 = acm001.trnty1 AND
                   uwm100.docno1 = acm001.docno  AND
                   uwm100.policy = acm001.policy AND   
                   uwm100.releas = YES NO-LOCK NO-ERROR.
     IF NOT AVAILABLE uwm100 THEN NEXT loop_acm001.
        DISP uwm100.policy uwm100.trty11 uwm100.trndat FORMAT 99/99/9999 
        WITH COLOR blue/withe NO-LABEL 
        TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
     IF acm001.prem <> uwm100.prem_t THEN DO:   /*Prem.AC. กับ UW ไม่เท่ากัน*/
        OUTPUT TO VALUE (nv_errfile) APPEND NO-ECHO.
            EXPORT DELIMITER ";" "policy        =" uwm100.policy.
            EXPORT DELIMITER ";" "rencnt        =" uwm100.rencnt.
            EXPORT DELIMITER ";" "endcnt        =" uwm100.endcnt.
            EXPORT DELIMITER ";" "Com date      =" uwm100.comdat.
            EXPORT DELIMITER ";" "Tran date     =" uwm100.trndat.
            EXPORT DELIMITER ";" "uwm100.prem_t =" uwm100.prem_t.
            EXPORT DELIMITER ";" "acm001.prem   =" acm001.prem.
            EXPORT DELIMITER ";" "acm001.netloc =" acm001.netloc.
            EXPORT DELIMITER ";" "".
            EXPORT DELIMITER ";" "".
        OUTPUT CLOSE.
     END.

     /* จัดกลุ่ม Line */
          IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_1Motor)  > 0 THEN nv_GLine = "1Motor".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_2Fire)   > 0 THEN nv_GLine = "2Fire".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_3Marine) > 0 THEN nv_GLine = "3Marine".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_4PA)     > 0 THEN nv_GLine = "4PA".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_5Misc)   > 0 THEN nv_GLine = "5Misc".
     ELSE IF LOOKUP(SUBSTRING(acm001.policy,3,2),nv_6Inno)   > 0 THEN nv_GLine = "6Inno".
                                                                 ELSE nv_GLine = "7Other".
     ASSIGN
       nv_wReg      = ""
       nv_wGrp1     = ""
       nv_wGrp2     = 0
       nv_GBranch   = ""
       nv_bdesc     = "".
     
     FIND FIRST wGrpReg WHERE wGrpReg.wBranch = n_bran NO-LOCK NO-ERROR.
     IF AVAIL wGrpReg THEN 
          ASSIGN 
            nv_wReg    = wGrpReg.wReg  
            nv_wGrp1   = wGrpReg.wGrp1 
            nv_wGrp2   = wGrpReg.wGrp2 
            nv_GBranch = wGrpReg.wBranch
            nv_bdesc   = wGrpReg.wBrDesc.
     ELSE ASSIGN
            nv_wReg    = "NOT FOUND"
            nv_wGrp1   = "NOT FOUND"
            nv_wGrp2   = 0
            nv_GBranch = "ERROR" + n_bran .

     /*---------- Motor ---------*/
     IF (SUBSTRING(acm001.policy,3,2) = "70" OR SUBSTRING(acm001.policy,3,2) = "72" OR 
         SUBSTRING(acm001.policy,3,2) = "73" OR SUBSTRING(acm001.policy,3,2) = "74")  THEN DO:
         ASSIGN  nv_comp = 0         
                 nv_pa   = 0.
         FOR EACH uwd132 NO-LOCK 
             WHERE uwd132.policy = uwm100.policy
               AND uwd132.rencnt = uwm100.rencnt
               AND uwd132.endcnt = uwm100.endcnt
               AND uwd132.prem_c <> ?.
    
                  IF uwd132.bencod = "comp" THEN nv_comp = nv_comp + uwd132.prem_c.
             ELSE IF uwd132.bencod = "pa"   THEN nv_pa   = nv_pa   + uwd132.prem_c.        
             
         END. /*EACH UWD132*/  
    
         nv_vol   = uwm100.prem_t - nv_comp - nv_pa.
         pol_prem = nv_vol  + nv_comp  + nv_pa.   /*PREMIUM*/

         RUN pro_motor.

     END. 
     /*----------- Non Motor -------------*/
     ELSE DO:
         ASSIGN  nv_comp = 0  
                 nv_pa   = 0. 

         FOR EACH uwd132 NO-LOCK 
             WHERE uwd132.policy = uwm100.policy
              AND uwd132.rencnt = uwm100.rencnt
              AND uwd132.endcnt = uwm100.endcnt
              AND uwd132.prem_c <> ?.
    
                  IF uwd132.bencod = "comp" THEN nv_comp = nv_comp + uwd132.prem_c.
             ELSE IF uwd132.bencod = "pa"   THEN nv_pa   = nv_pa   + uwd132.prem_c.
              
             nv_vol   = uwm100.prem_t    - nv_comp   -   nv_pa.
             pol_prem = nv_vol  + nv_comp  + nv_pa .   /* PREMIUM  */
                 
         END.   /*Each uwd132*/
       
         IF SUBSTR(acm001.policy,1,2) = "IY" AND acm001.acno = "0APTHAI" THEN 
             ASSIGN n_ri = YES
                    n_poltyp = SUBSTR(acm001.policy,3,2) + "T".
         ELSE n_ri = NO.
     
         RUN pro_Nonmotor.
     
     END.  /*--- End Non Motor ---*/ 
     ASSIGN 
         nv_vol   = 0   nv_comp     = 0   
         nv_pa    = 0   pol_prem    = 0.
    
     IF LAST-OF (acm001.branch) THEN DO:

         OUTPUT TO C:\temp\GroupLineBranch.txt .
           PUT TODAY FORMAT "99/99/9999" " " STRING(TIME,"HH:MM:SS") "." SKIP. 
         OUTPUT CLOSE.

         RUN pd_GenGlineOther (INPUT nv_wReg   , /* 1HO  */
                                     nv_wGrp1  , /* 1BU1 */
                                     nv_wGrp2  , /* 1,2,3...*/
                                     n_bran    , /* 0 , W , L , M , 4 .....*/
                                     nv_bdesc  ). /* Branch Description */
     END.
 END.
 
 IF ra_reptype = 1 THEN RUN Proc_SumTotalI.
                   ELSE RUN Proc_Detail.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_SumTotalD C-Win 
PROCEDURE Proc_SumTotalD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_Sump       AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Line   + */       
DEF VAR nv_Sum        AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Line   - */
DEF VAR nv_TBrnSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Branch + */
DEF VAR nv_TBrnSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Branch - */
DEF VAR nv_TGBUSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group BU. +    */
DEF VAR nv_TGBUSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group BU. -    */

/* Total Sum Group Region ของและละ Group Line */
DEF VAR nv_TGRegMtSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Motor) */ 
DEF VAR nv_TGRegMtSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Motor) */ 
DEF VAR nv_TGRegFiSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Fire)  */ 
DEF VAR nv_TGRegFiSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Fire)  */ 
DEF VAR nv_TGRegMaSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Marine)*/ 
DEF VAR nv_TGRegMaSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Marine)*/ 
DEF VAR nv_TGRegPaSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (PA)    */ 
DEF VAR nv_TGRegPaSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (PA)    */ 
DEF VAR nv_TGRegMiSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Misc)  */ 
DEF VAR nv_TGRegMiSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Misc)  */ 
DEF VAR nv_TGRegInSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Inno)  */ 
DEF VAR nv_TGRegInSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Inno)  */ 
DEF VAR nv_TGRegOtSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Other) */ 
DEF VAR nv_TGRegOtSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Other) */ 

DEF VAR nv_TLGRegSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Last Group Region +  */ 
DEF VAR nv_TLGRegSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Last Group Region -  */ 

OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
  EXPORT DELIMITER ";"
      "Department"
      "Premium Befor Endorsement"
      "Premium Befor Endorsement(Detail)"  /* PUT Detail ออกมาเพื่อให้เช็คได้ว่ายอดก่อน Sum เป็นเท่าไหร่ */
      "Actual".
OUTPUT CLOSE.     

ASSIGN
  nv_Sump      = 0     nv_Sum      = 0
  nv_TBrnSump  = 0     nv_TBrnSum  = 0
  nv_TGBUSump  = 0     nv_TGBUSum  = 0  
  
  nv_TGRegMtSump  =  0  nv_TGRegMtSum  =  0  
  nv_TGRegFiSump  =  0  nv_TGRegFiSum  =  0  
  nv_TGRegMaSump  =  0  nv_TGRegMaSum  =  0  
  nv_TGRegPaSump  =  0  nv_TGRegPaSum  =  0  
  nv_TGRegMiSump  =  0  nv_TGRegMiSum  =  0  
  nv_TGRegInSump  =  0  nv_TGRegInSum  =  0  
  nv_TGRegOtSump  =  0  nv_TGRegOtSum  =  0

  nv_TLGRegSump   =  0  nv_TLGRegSum   =  0.

  FOR EACH wfByLine 
      BREAK BY wfReg 
            BY wfGrp1 
            BY wfGrp2 
            BY wfGLine
            BY wfBran:
      
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
      /* ใช้ wfdesc  เป็นตัวเช็ค เพราะ  prem +  จะมีทั้งยอด + และยอด - ( งาน V72,V73,V74 )*/
      IF wfdesc = "prem + " THEN DO:
          ASSIGN
            nv_Sump     =  nv_Sump     + wfpremm + wfprem
            nv_TBrnSump =  nv_TBrnSump + wfpremm + wfprem
            nv_TGBUSump =  nv_TGBUSump + wfpremm + wfprem.

               IF wfGLine = "1Motor"  THEN nv_TGRegMtSump  =  nv_TGRegMtSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "2Fire"   THEN nv_TGRegFiSump  =  nv_TGRegFiSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "3Marine" THEN nv_TGRegMaSump  =  nv_TGRegMaSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "4PA"     THEN nv_TGRegPaSump  =  nv_TGRegPaSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "5Misc"   THEN nv_TGRegMiSump  =  nv_TGRegMiSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "6Inno"   THEN nv_TGRegInSump  =  nv_TGRegInSump   + wfpremm + wfprem.
                                      ELSE nv_TGRegOtSump  =  nv_TGRegOtSump   + wfpremm + wfprem.
      END.
      ELSE DO:
          ASSIGN 
            nv_Sum      =  nv_Sum      + wfprem + wfpremm
            nv_TBrnSum  =  nv_TBrnSum  + wfprem + wfpremm
            nv_TGBUSum  =  nv_TGBUSum  + wfprem + wfpremm.

               IF wfGLine = "1Motor"  THEN nv_TGRegMtSum  =  nv_TGRegMtSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "2Fire"   THEN nv_TGRegFiSum  =  nv_TGRegFiSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "3Marine" THEN nv_TGRegMaSum  =  nv_TGRegMaSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "4PA"     THEN nv_TGRegPaSum  =  nv_TGRegPaSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "5Misc"   THEN nv_TGRegMiSum  =  nv_TGRegMiSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "6Inno"   THEN nv_TGRegInSum  =  nv_TGRegInSum   + wfpremm + wfprem.
                                      ELSE nv_TGRegOtSum  =  nv_TGRegOtSum   + wfpremm + wfprem.
      END.
      /*------------------------------------------------------------------------------------*/
      
      /* 1 */
      IF FIRST-OF (wfGrp2) THEN DO:
          EXPORT DELIMITER ";" " - " + wfbdesc + "(" + wfbran + ")".
      END.

      /* 2 - Last ของแต่ละกลุ่ม Line  (Motor,Fire,Marine,PA,Misc,Inno,Other) */
      IF LAST-OF (wfGLine) THEN DO:
          EXPORT DELIMITER ";" "          " + TRIM(SUBSTRING(wfGLine,2))       "" nv_Sump  nv_Sump + nv_Sum .
          ASSIGN nv_Sump = 0  nv_Sum = 0.  /* PUT แล้ว Clear ค่า */
      END.

      /* 3 - Last ของแต่ละ Branch */
      IF LAST-OF (wfGrp2) THEN DO: 
          IF wfbran <> "0" AND wfbran <> "Y" THEN DO: /* Branch '0' กับ 'Y' ไม่ต้อง PUT  บรรทัดนี้ */
              EXPORT DELIMITER ";" " TOTAL - " + wfbdesc                       nv_TBrnSump ""  nv_TBrnSump + nv_TBrnSum .
          END.
          ASSIGN nv_TBrnSump = 0  nv_TBrnSum = 0. /* PUT แล้ว Clear ค่า */
      END.    

      /* 4 - Last ของแต่กลุ่ม BU. (BU1,BU2,BU3,BU4,SPECIAL PRODUCT,PHETCHABURI(NEW),NORTH,SOUTH,NORTH EAST,WEST,EAST)*/
      IF LAST-OF (wfGrp1) THEN DO: 
          EXPORT DELIMITER ";" " TOTAL - " + TRIM(SUBSTRING(wfGrp1,3))         nv_TGBUSump ""  nv_TGBUSump + nv_TGBUSum .
          ASSIGN nv_TGBUSump = 0  nv_TGBUSum = 0. /* PUT แล้ว Clear ค่า */
      END.

      /* 5 - Last ของแต่ละ Region - Sum ของแต่ละ Group Line (Motor ,Fire ,Marine ,PA ,Misc Inno ,Other) */
      IF LAST-OF (wfReg) THEN DO:
        /* Heading Sum Region */
             IF wfReg = "1HO" THEN EXPORT DELIMITER ";" " - TOTAL BEFORE INW.TREATY"  "" "".
        ELSE IF wfReg = "2BR" THEN EXPORT DELIMITER ";" " - TOTAL ALL BRANCH"         "" "".
        ELSE IF wfReg = "3PB" THEN EXPORT DELIMITER ";" " - TOTAL PHETCHABURI(NEW)"   "" "".
        /*--------------*/

        EXPORT DELIMITER ";" "          Motor"  ""  nv_TGRegMtSump    nv_TGRegMtSump + nv_TGRegMtSum.    /* Motor  */
        EXPORT DELIMITER ";" "          Fire"   ""  nv_TGRegFiSump    nv_TGRegFiSump + nv_TGRegFiSum.    /* Fire   */
        EXPORT DELIMITER ";" "          Marine" ""  nv_TGRegMaSump    nv_TGRegMaSump + nv_TGRegMaSum.    /* Marine */
        EXPORT DELIMITER ";" "          PA"     ""  nv_TGRegPaSump    nv_TGRegPaSump + nv_TGRegPaSum.    /* Pa     */
        EXPORT DELIMITER ";" "          Misc"   ""  nv_TGRegMiSump    nv_TGRegMiSump + nv_TGRegMiSum.    /* Misc   */
        EXPORT DELIMITER ";" "          Inno"   ""  nv_TGRegInSump    nv_TGRegInSump + nv_TGRegInSum.    /* Inno   */
        EXPORT DELIMITER ";" "          Other"  ""  nv_TGRegOtSump    nv_TGRegOtSump + nv_TGRegOtSum.    /* Oter   */

        nv_TLGRegSump = nv_TGRegMtSump + nv_TGRegFiSump + nv_TGRegMaSump + nv_TGRegPaSump + nv_TGRegMiSump + nv_TGRegInSump + nv_TGRegOtSump.
        nv_TLGRegSum  = nv_TGRegMtSump + nv_TGRegMtSum  + nv_TGRegFiSump + nv_TGRegFiSum  + nv_TGRegMaSump + nv_TGRegMaSum  +
                        nv_TGRegPaSump + nv_TGRegPaSum  + nv_TGRegMiSump + nv_TGRegMiSum  + nv_TGRegInSump + nv_TGRegInSum  +
                        nv_TGRegOtSump + nv_TGRegOtSum.

        /* Sum ALL Group Line ของแต่ละ Regino */
             IF wfReg = "1HO" THEN EXPORT DELIMITER ";" " TOTAL BEFORE INW.TREATY"  nv_TLGRegSump "" nv_TLGRegSum.
        ELSE IF wfReg = "2BR" THEN EXPORT DELIMITER ";" " TOTAL ALL BRANCH"         nv_TLGRegSump "" nv_TLGRegSum.
        ELSE IF wfReg = "3PB" THEN EXPORT DELIMITER ";" " TOTAL PHETCHABURI(NEW)"   nv_TLGRegSump "" nv_TLGRegSum.

        /* PUT แล้ว Clear ค่า */
        ASSIGN nv_TGRegMtSump = 0  nv_TGRegMtSum = 0
               nv_TGRegFiSump = 0  nv_TGRegFiSum = 0
               nv_TGRegMaSump = 0  nv_TGRegMaSum = 0
               nv_TGRegPaSump = 0  nv_TGRegPaSum = 0
               nv_TGRegMiSump = 0  nv_TGRegMiSum = 0
               nv_TGRegInSump = 0  nv_TGRegInSum = 0
               nv_TGRegOtSump = 0  nv_TGRegOtSum = 0
               nv_TLGRegSump  = 0  nv_TLGRegSum  = 0 .
      END.

      OUTPUT CLOSE.

   END.  /* FOR EACH wfbyline */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_SumTotalI C-Win 
PROCEDURE Proc_SumTotalI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_Sump       AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Line   + */       
DEF VAR nv_Sum        AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Line   - */
DEF VAR nv_TBrnSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Branch + */
DEF VAR nv_TBrnSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Branch - */
DEF VAR nv_TGBUSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group BU. +    */
DEF VAR nv_TGBUSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group BU. -    */

/* Total Sum Group Region ของและละ Group Line */
DEF VAR nv_TGRegMtSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Motor) */ 
DEF VAR nv_TGRegMtSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Motor) */ 
DEF VAR nv_TGRegFiSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Fire)  */ 
DEF VAR nv_TGRegFiSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Fire)  */ 
DEF VAR nv_TGRegMaSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Marine)*/ 
DEF VAR nv_TGRegMaSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Marine)*/ 
DEF VAR nv_TGRegPaSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (PA)    */ 
DEF VAR nv_TGRegPaSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (PA)    */ 
DEF VAR nv_TGRegMiSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Misc)  */ 
DEF VAR nv_TGRegMiSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Misc)  */ 
DEF VAR nv_TGRegInSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Inno)  */ 
DEF VAR nv_TGRegInSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Inno)  */ 
DEF VAR nv_TGRegOtSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region + (Other) */ 
DEF VAR nv_TGRegOtSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Group Region - (Other) */ 

DEF VAR nv_TLGRegSump   AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Last Group Region +  */ 
DEF VAR nv_TLGRegSum    AS DECI FORMAT "->>>,>>>,>>>,>>9.99".   /* Total Last Group Region -  */ 


OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
  EXPORT DELIMITER ";"
      "Department"
      "Premium Befor Endorsement"
      "Premium Befor Endorsement(Detail)"  /* PUT Detail ออกมาเพื่อให้เช็คได้ว่ายอดก่อน Sum เป็นเท่าไหร่ */
      "Actual".
OUTPUT CLOSE.     

ASSIGN
  nv_Sump      = 0     nv_Sum      = 0
  nv_TBrnSump  = 0     nv_TBrnSum  = 0
  nv_TGBUSump  = 0     nv_TGBUSum  = 0  
  
  nv_TGRegMtSump  =  0  nv_TGRegMtSum  =  0  
  nv_TGRegFiSump  =  0  nv_TGRegFiSum  =  0  
  nv_TGRegMaSump  =  0  nv_TGRegMaSum  =  0  
  nv_TGRegPaSump  =  0  nv_TGRegPaSum  =  0  
  nv_TGRegMiSump  =  0  nv_TGRegMiSum  =  0  
  nv_TGRegInSump  =  0  nv_TGRegInSum  =  0  
  nv_TGRegOtSump  =  0  nv_TGRegOtSum  =  0

  nv_TLGRegSump   =  0  nv_TLGRegSum   =  0.

  FOR EACH wfByLine 
      BREAK BY wfReg 
            BY wfGrp1 
            BY wfGrp2 
            BY wfGLine
            BY wfBran:
      
      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.   
      /* ใช้ wfdesc  เป็นตัวเช็ค เพราะ  prem +  จะมีทั้งยอด + และยอด - ( งาน V72,V73,V74 )*/
      IF wfdesc = "prem + " THEN DO:
          ASSIGN
            nv_Sump     =  nv_Sump     + wfpremm + wfprem
            nv_TBrnSump =  nv_TBrnSump + wfpremm + wfprem
            nv_TGBUSump =  nv_TGBUSump + wfpremm + wfprem.

               IF wfGLine = "1Motor"  THEN nv_TGRegMtSump  =  nv_TGRegMtSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "2Fire"   THEN nv_TGRegFiSump  =  nv_TGRegFiSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "3Marine" THEN nv_TGRegMaSump  =  nv_TGRegMaSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "4PA"     THEN nv_TGRegPaSump  =  nv_TGRegPaSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "5Misc"   THEN nv_TGRegMiSump  =  nv_TGRegMiSump   + wfpremm + wfprem.
          ELSE IF wfGLine = "6Inno"   THEN nv_TGRegInSump  =  nv_TGRegInSump   + wfpremm + wfprem.
                                      ELSE nv_TGRegOtSump  =  nv_TGRegOtSump   + wfpremm + wfprem.
      END.
      ELSE DO:
          ASSIGN 
            nv_Sum      =  nv_Sum      + wfprem + wfpremm
            nv_TBrnSum  =  nv_TBrnSum  + wfprem + wfpremm
            nv_TGBUSum  =  nv_TGBUSum  + wfprem + wfpremm.

               IF wfGLine = "1Motor"  THEN nv_TGRegMtSum  =  nv_TGRegMtSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "2Fire"   THEN nv_TGRegFiSum  =  nv_TGRegFiSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "3Marine" THEN nv_TGRegMaSum  =  nv_TGRegMaSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "4PA"     THEN nv_TGRegPaSum  =  nv_TGRegPaSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "5Misc"   THEN nv_TGRegMiSum  =  nv_TGRegMiSum   + wfpremm + wfprem.
          ELSE IF wfGLine = "6Inno"   THEN nv_TGRegInSum  =  nv_TGRegInSum   + wfpremm + wfprem.
                                      ELSE nv_TGRegOtSum  =  nv_TGRegOtSum   + wfpremm + wfprem.
      END.
      /*------------------------------------------------------------------------------------*/

      /* 1 */
      IF FIRST-OF (wfGrp2) THEN DO:
        EXPORT DELIMITER ";" " - " + wfbdesc + "(" + wfbran + ")".
      END.

      /* 2 - Last ของแต่ละกลุ่ม Line  (Motor,Fire,Marine,PA,Misc,Inno,Other) */
      IF LAST-OF (wfGLine) THEN DO:
          EXPORT DELIMITER ";" "          " + TRIM(SUBSTRING(wfGLine,2))  "" nv_Sump  nv_Sump + nv_Sum .
          ASSIGN nv_Sump = 0  nv_Sum = 0.  /* PUT แล้ว Clear ค่า */
      END.

      /* 3 - Last ของแต่ละ Branch */
      IF LAST-OF (wfGrp2) THEN DO: 
          EXPORT DELIMITER ";" " TOTAL - " + wfbdesc                       nv_TBrnSump ""  nv_TBrnSump + nv_TBrnSum .
          ASSIGN nv_TBrnSump = 0  nv_TBrnSum = 0. /* PUT แล้ว Clear ค่า */
      END.    

      /*--- Inward ไม่ต้อง PUT  --- 
      /* 4 - Last ของแต่กลุ่ม BU. (BU1,BU2,BU3,BU4,SPECIAL PRODUCT,PHETCHABURI(NEW),NORTH,SOUTH,NORTH EAST,WEST,EAST)*/
      IF LAST-OF (wfGrp1) THEN DO: 
        EXPORT DELIMITER ";"
            " TOTAL - " + TRIM(SUBSTRING(wfGrp1,3))         nv_TGBUSump ""  nv_TGBUSump + nv_TGBUSum .
        ASSIGN nv_TGBUSump = 0  nv_TGBUSum = 0. /* PUT แล้ว Clear ค่า */
      END.
      */

      /* 5 - Last ของแต่ละ Region - Sum ของแต่ละ Group Line (Motor ,Fire ,Marine ,PA ,Misc Inno ,Other) */
      IF LAST-OF (wfReg) THEN DO:
        /* Heading Sum Region */
             IF wfReg = "1HO" THEN EXPORT DELIMITER ";" " - TOTAL INW.TREATY(HO) "  "" "".
        ELSE IF wfReg = "2BR" THEN EXPORT DELIMITER ";" " - TOTAL INW. ALL BRANCH"  "" "".
        ELSE IF wfReg = "3PB" THEN EXPORT DELIMITER ";" " - TOTAL Inward -PHETCHABURI(NEW)"  "" "".
        /*--------------*/

        EXPORT DELIMITER ";" "          Motor"    "" nv_TGRegMtSump  nv_TGRegMtSump + nv_TGRegMtSum.    /* Motor  */
        EXPORT DELIMITER ";" "          Fire"     "" nv_TGRegFiSump  nv_TGRegFiSump + nv_TGRegFiSum.    /* Fire   */
        EXPORT DELIMITER ";" "          Marine"   "" nv_TGRegMaSump  nv_TGRegMaSump + nv_TGRegMaSum.    /* Marine */
        EXPORT DELIMITER ";" "          PA"       "" nv_TGRegPaSump  nv_TGRegPaSump + nv_TGRegPaSum.    /* Pa     */
        EXPORT DELIMITER ";" "          Misc"     "" nv_TGRegMiSump  nv_TGRegMiSump + nv_TGRegMiSum.    /* Misc   */
        EXPORT DELIMITER ";" "          Inno"     "" nv_TGRegInSump  nv_TGRegInSump + nv_TGRegInSum.    /* Inno   */
        EXPORT DELIMITER ";" "          Other"    "" nv_TGRegOtSump  nv_TGRegOtSump + nv_TGRegOtSum.    /* Oter   */

        nv_TLGRegSump = nv_TGRegMtSump + nv_TGRegFiSump + nv_TGRegMaSump + nv_TGRegPaSump + nv_TGRegMiSump + nv_TGRegInSump + nv_TGRegOtSump.
        nv_TLGRegSum  = nv_TGRegMtSump + nv_TGRegMtSum  + nv_TGRegFiSump + nv_TGRegFiSum  + nv_TGRegMaSump + nv_TGRegMaSum  +
                        nv_TGRegPaSump + nv_TGRegPaSum  + nv_TGRegMiSump + nv_TGRegMiSum  + nv_TGRegInSump + nv_TGRegInSum  +
                        nv_TGRegOtSump + nv_TGRegOtSum.

        /* Sum ALL Group Line ของแต่ละ Regino */
             IF wfReg = "1HO" THEN EXPORT DELIMITER ";" " TOTAL INW.TREATY(HO)"        nv_TLGRegSump "" nv_TLGRegSum.
        ELSE IF wfReg = "2BR" THEN EXPORT DELIMITER ";" " TOTAL INW. ALL BRANCH"       nv_TLGRegSump "" nv_TLGRegSum.
        ELSE IF wfReg = "3PB" THEN EXPORT DELIMITER ";" " TOTAL INW-PHETCHABURI(NEW)"  nv_TLGRegSump "" nv_TLGRegSum.

        /* PUT แล้ว Clear ค่า */
        ASSIGN nv_TGRegMtSump = 0  nv_TGRegMtSum = 0
               nv_TGRegFiSump = 0  nv_TGRegFiSum = 0
               nv_TGRegMaSump = 0  nv_TGRegMaSum = 0
               nv_TGRegPaSump = 0  nv_TGRegPaSum = 0
               nv_TGRegMiSump = 0  nv_TGRegMiSum = 0
               nv_TGRegInSump = 0  nv_TGRegInSum = 0
               nv_TGRegOtSump = 0  nv_TGRegOtSum = 0
               nv_TLGRegSump  = 0  nv_TLGRegSum  = 0 .
      END.

      OUTPUT CLOSE.

   END.  /* FOR EACH wfbyline */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_motor C-Win 
PROCEDURE pro_motor :
/*------------------------------------------------------------------------------
  Purpose: Create Workfile For Motor (70, 70PA, 71, 72, 73, 74) to Summary Report  
  Parameters:  <none>  
  Notes:       
------------------------------------------------------------------------------*/
IF SUBSTR(acm001.policy,3,2) = "70" THEN DO:

    IF nv_vol > 0 THEN DO:
        FIND FIRST wfbyline 
            WHERE wfpoltyp = "70"  
            AND wfbran   = n_bran
            AND wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "70" 
                wfbran   = n_bran
                wfdesc   = "prem + "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfpremm   = wfpremm + nv_vol.
    END.  /*End if nv_vol > 0*/
    ELSE DO: 
        FIND FIRST wfbyline WHERE wfpoltyp = "70"      
            AND wfbran   = n_bran    
            AND wfdesc   = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "70" 
                wfbran   = n_bran 
                wfdesc   = "prem - "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfprem   = wfprem + nv_vol. 
    END.

    IF  nv_comp  > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = "71"      AND
            wfbran   = n_bran    AND
            wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "71" 
                wfbran   = n_bran
                wfdesc   = "prem + "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfpremm   = wfpremm + nv_comp.
    END.
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = "71"       AND
            wfbran    = n_bran     AND
            wfdesc    = "prem - "  NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "71" 
                wfbran   = n_bran
                wfdesc   = "prem - "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfprem   = wfprem + nv_comp.
    END.

    IF  nv_pa  > 0  THEN  DO:
        FIND FIRST wfbyline WHERE wfpoltyp = "70PA" 
            AND wfbran   = n_bran
            AND wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "70PA"
                wfbran   = n_bran 
                wfdesc   = "prem + "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfpremm   = wfpremm + nv_pa.
    END.
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = "70PA"    AND
            wfbran    = n_bran    AND
            wfdesc    = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = "70PA"
                wfbran   = n_bran 
                wfdesc   = "prem - "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfprem   = wfprem + nv_pa.
    END.
END.     /*---if "70"---*/
ELSE DO:        /*-- 72,73,74 --*/

    IF  nv_comp  > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  AND
            wfbran   =  n_bran    AND
            wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   = n_bran
                wfdesc   = "prem + "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfpremm   = wfpremm + nv_comp.     
    END.
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp  = SUBSTR(acm001.policy,3,2) AND
            wfbran    = n_bran     AND
            wfdesc    = "prem - "  NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2)
                wfbran   = n_bran
                wfdesc   = "prem - "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfprem   = wfprem + nv_comp.
    END.
    
    /* V72-V74  จะเป็นเบี้ย หักส่วนลดแล้ว จึงต้องกลับเครื่องหมาย */
    IF nv_vol > 0 THEN DO:
        FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  AND
            wfbran   =  n_bran    AND
            wfdesc   = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   =  n_bran
                wfdesc   = "prem - "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfpremm   = wfpremm + nv_vol .   
    END.  /*End if nv_vol > 0*/
    ELSE DO:
        FIND FIRST wfbyline WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  AND
            wfbran   =  n_bran    AND
            wfdesc   = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   =  n_bran
                wfdesc   = "prem + "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.
        ASSIGN wfprem   = wfprem + nv_vol  . 
    END.
    
END.   /*End else 72,73,74 */

ASSIGN  nv_vol      = 0     nv_comp     = 0 nv_pa   = 0  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pro_Nonmotor C-Win 
PROCEDURE pro_Nonmotor :
/*------------------------------------------------------------------------------
  Purpose: Create Workfile For Non motor to Summary Report    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF n_ri = YES THEN DO:       /*---Inward Treaty  A51-0078---*/
   IF acm001.prem  > 0 THEN  DO:
      FIND FIRST wfbyline 
          WHERE wfpoltyp = SUBSTR(acm001.policy,3,2)  + "T" AND   
                wfbran   = n_bran    AND
                wfdesc   = "prem + " NO-ERROR.
      IF NOT AVAIL wfbyline THEN DO:
         CREATE wfbyline.
         ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) + "T"
              wfbran   = n_bran
              wfdesc   = "prem + "
              wfReg    = nv_wReg 
              wfGrp1   = nv_wGrp1
              wfGrp2   = nv_wGrp2
              wfGLine  = nv_GLine
              wfbdesc  = nv_bdesc.
      END.
      wfpremm = wfpremm + pol_prem.
   END.
   ELSE DO:
        FIND FIRST wfbyline 
            WHERE wfpoltyp  = SUBSTR(acm001.policy,3,2)  + "T"  AND
                  wfbran    = n_bran    AND
                  wfdesc    = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
           CREATE wfbyline.
           ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2)  + "T" 
                wfbran   = n_bran
                wfdesc   = "prem - "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.    
        wfprem = wfprem + pol_prem.
    END.
    
END.
ELSE DO:    /*Non Motor อื่นๆ*/
    IF acm001.prem  > 0 THEN  DO:
        FIND FIRST wfbyline 
            WHERE wfpoltyp  = n_poltyp  AND
                  wfbran    = n_bran    AND
                  wfdesc    = "prem + " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
           CREATE wfbyline.
           ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   = n_bran
                wfdesc   = "prem + "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.  
        wfpremm = wfpremm + pol_prem.
    END.   /* Prem > 0 */
    ELSE DO:
        FIND FIRST wfbyline 
            WHERE wfpoltyp  = substr(acm001.policy,3,2)  AND
                  wfbran    = n_bran    AND
                  wfdesc    = "prem - " NO-ERROR. 
        IF NOT AVAILABLE wfbyline THEN DO:
           CREATE wfbyline.
           ASSIGN wfpoltyp = SUBSTR(acm001.policy,3,2) 
                wfbran   = n_bran
                wfdesc   = "prem - "
                wfReg    = nv_wReg 
                wfGrp1   = nv_wGrp1
                wfGrp2   = nv_wGrp2
                wfGLine  = nv_GLine
                wfbdesc  = nv_bdesc. 
        END.    
        wfprem = wfprem + pol_prem.
    END.
END.
n_ri = NO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

