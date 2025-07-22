&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
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

 Modify By : TANTAWAN C.   26/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
               
 ขยาย FORMAT fiacno1 จาก "X(7)" เป็น  Char "X(10)"  
             fiacno2 จาก "X(7)" เป็น  Char "X(10)"
/*----------------------------------------------------------------------*/             
/*Modify by : Yosawee M.  ASSIGN : A67-0066  DATE : 17/06/2025
              Issue โปรแกรมบนระบบ Safety's Soft ขึ้น Error Image was not found  */          

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/************   Program   **************
/* CREATE BY :  Kanchana C.        A46-0015  */
        ทำการลบข้อมูลตาม asdat ที่เลือก

Wac
        -wactas4.w  
Whp
        -WhpAcno.w
Wut
        -WutDiCen.p
        -WutWiCen.p

*****************************************/    
/* ***************************  Definitions  ************************** */
DEF SHARED VAR n_User    AS CHAR.
DEF SHARED VAR n_Passwd  AS CHAR.  
/*DEF  VAR   nv_User     AS CHAR NO-UNDO. 
* DEF  VAR   nv_pwd    LIKE _password NO-UNDO.*/

/* Parameters Definitions ---                                           */
/*--- A500178 ---
DEF NEW SHARED VAR n_agent1  AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2  AS CHAR FORMAT "x(7)".
------*/
DEF NEW SHARED VAR n_agent1  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_agent2  AS CHAR FORMAT "x(10)".
DEF NEW SHARED VAR n_branch  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2 AS CHAR FORMAT "x(2)".

Def Var n_name     As Char Format "x(50)".     /*acno name*/
Def Var n_chkname  As Char format "x(1)".        /* Acno-- chk button 1-2 */
Def Var n_bdes     As Char Format "x(50)".     /*branch name*/
Def Var n_chkBname As Char format "x(1)".        /* branch-- chk button 1-2 */

/* Local Variable Definitions ---        */

DEF VAR nv_asmth   AS INTE INIT 0.
DEF VAR nv_frmth   AS INTE INIT 0.
DEF VAR nv_tomth   AS INTE INIT 0.
DEF VAR cv_mthListT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT " January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_frdate   AS DATE FORMAT "99/99/9999".
DEF VAR n_todate   AS DATE FORMAT "99/99/9999".
DEF VAR n_asdat    AS DATE FORMAT "99/99/9999".
DEF VAR n_trndatto AS DATE FORMAT "99/99/9999".

DEF VAR n_chkCopy  AS INTEGER.
DEF VAR n_OutputTo AS INTEGER.
DEF VAR n_OutputFile  AS Char.
DEF VAR vCountRec  AS INT.

/* --------------------- Define Var use in process ---------------------------*/
DEF VAR n_frbr  AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr  AS   CHAR   FORMAT "x(2)".
/*--- A500178 ---
DEF VAR n_frac  AS   CHAR   FORMAT "x(7)".
DEF VAR n_toac  AS   CHAR   FORMAT "x(7)".
------*/
DEF VAR n_frac  AS   CHAR   FORMAT "x(10)".
DEF VAR n_toac  AS   CHAR   FORMAT "x(10)".

DEF VAR n_recid AS RECID.

DEF VAR vAcProc_fil  AS CHAR.
DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
DEF VAR nv_type  AS CHAR.
DEF VAR nv_typdesc  AS CHAR FORMAT "x(100)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAcproc_fil

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE brAcproc_fil                                  */
&Scoped-define FIELDS-IN-QUERY-brAcproc_fil acproc_fil.asdat ~
acproc_fil.type acproc_fil.entdat acproc_fil.typdesc acproc_fil.enttim ~
SUBSTRING (acproc_fil.enttim,10,3) acproc_fil.trndatfr acproc_fil.trndatto 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcproc_fil 
&Scoped-define QUERY-STRING-brAcproc_fil FOR EACH acproc_fil NO-LOCK
&Scoped-define OPEN-QUERY-brAcproc_fil OPEN QUERY brAcproc_fil FOR EACH acproc_fil NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brAcproc_fil acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-brAcproc_fil acproc_fil


/* Definitions for FRAME frST                                           */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxDay C-Win 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumDay C-Win 
FUNCTION fuNumDay RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth C-Win 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "WIMAGE\wallpape":U CONVERT-3D-COLORS  /*----EDIT TO Yosawee M. A67-0066 17/06/2025----*/
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-23
     FILENAME "WIMAGE\bgc01":U CONVERT-3D-COLORS  /*----EDIT TO Yosawee M. A67-0066 17/06/2025----*/
     SIZE 106.5 BY 20.1.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 18.5 BY 4.43
     BGCOLOR 1 .

DEFINE BUTTON buAcno1 
     IMAGE-UP FILE "WIMAGE\help":U  /*----EDIT TO Yosawee M. A67-0066 17/06/2025----*/
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     IMAGE-UP FILE "WIMAGE\help":U  /*----EDIT TO Yosawee M. A67-0066 17/06/2025----*/
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiCount AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     FGCOLOR 15 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 51 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51.5 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE RECTANGLE RECT-94
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 99.5 BY 12.52.

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 4 GRAPHIC-EDGE  
     SIZE 93.5 BY 3.91
     BGCOLOR 8 .

DEFINE VARIABLE fiTypdesc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 56.5 BY 1
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fiType AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 9.5 BY 1
     FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-95
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 60 BY 4.91.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcproc_fil FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcproc_fil C-Win _STRUCTURED
  QUERY brAcproc_fil DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U COLUMN-FONT 1 LABEL-FONT 1
      acproc_fil.type COLUMN-LABEL "Type" FORMAT "X(2)":U
      acproc_fil.entdat COLUMN-LABEL "Process Date" FORMAT "99/99/9999":U
      acproc_fil.typdesc FORMAT "X(55)":U
      acproc_fil.enttim FORMAT "X(8)":U
      SUBSTRING (acproc_fil.enttim,10,3) COLUMN-LABEL "STA" FORMAT "X(3)":U
      acproc_fil.trndatfr COLUMN-LABEL "TranDate Fr" FORMAT "99/99/9999":U
      acproc_fil.trndatto COLUMN-LABEL "TranDate To" FORMAT "99/99/9999":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 95.5 BY 5.48
         BGCOLOR 15 FGCOLOR 0 FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.04
         BGCOLOR 18 .

DEFINE FRAME frMain
     IMAGE-23 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 13 ROW 3
         SIZE 107 BY 20.39.

DEFINE FRAME frOK
     Btn_OK AT ROW 1.71 COL 5.5
     Btn_Cancel AT ROW 3.62 COL 5.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 83.5 ROW 15.7
         SIZE 21.5 BY 4.96
         BGCOLOR 3 .

DEFINE FRAME frST
     buAcno1 AT ROW 3.86 COL 27.5
     fiacno1 AT ROW 3.91 COL 13.5 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 4.91 COL 13.5 COLON-ALIGNED NO-LABEL
     buAcno2 AT ROW 4.91 COL 27.5
     fiCount AT ROW 7 COL 75.5 COLON-ALIGNED NO-LABEL
     brAcproc_fil AT ROW 8.57 COL 3
     finame1 AT ROW 3.86 COL 29 COLON-ALIGNED
     finame2 AT ROW 4.91 COL 29 COLON-ALIGNED NO-LABEL
     fiProcessDate AT ROW 7 COL 49.5 COLON-ALIGNED NO-LABEL
     fiAsdat AT ROW 7.05 COL 22 COLON-ALIGNED
     " Producer Code":40 VIEW-AS TEXT
          SIZE 15 BY .76 TOOLTIP "รหัสตัวแทน" AT ROW 2.62 COL 4
          BGCOLOR 1 FGCOLOR 7 FONT 1
     "                                               Delete Data From Export Text":100 VIEW-AS TEXT
          SIZE 99.5 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "From":40 VIEW-AS TEXT
          SIZE 6.5 BY .95 TOOLTIP "รหัสตัวแทนเริ่มตั้งแต่" AT ROW 3.91 COL 9
          BGCOLOR 8 
     " As of Date":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 7 COL 7
          BGCOLOR 1 FGCOLOR 7 
     " Process Date":30 VIEW-AS TEXT
          SIZE 12 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 7 COL 39
          BGCOLOR 1 FGCOLOR 7 
     "To":20 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 4.95 COL 9
          BGCOLOR 8 
     RECT-94 AT ROW 2.05 COL 1
     RECT11 AT ROW 2.57 COL 4
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5 ROW 1.52
         SIZE 100 BY 13.83
         BGCOLOR 3 .

DEFINE FRAME frTranDate
     fiType AT ROW 1.76 COL 10 COLON-ALIGNED NO-LABEL
     fiTypdesc AT ROW 4.38 COL 3 NO-LABEL
     "Type" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 1.76 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Description":50 VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 3.33 COL 3
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-95 AT ROW 1 COL 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 5 ROW 15.7
         SIZE 60.5 BY 4.96
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
         TITLE              = "wactas4 - Delete Data From Export Text"
         HEIGHT             = 24.05
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.33
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
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE
       FRAME frTranDate:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frST
                                                                        */
/* BROWSE-TAB brAcproc_fil fiCount frST */
/* SETTINGS FOR FILL-IN fiAsdat IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FRAME frTranDate
                                                                        */
/* SETTINGS FOR FILL-IN fiTypdesc IN FRAME frTranDate
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sicfn.acproc_fil.type
"type" "Type" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > sicfn.acproc_fil.entdat
"entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.typdesc
"typdesc" ? "X(55)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   = sicfn.acproc_fil.enttim
     _FldNameList[6]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "STA" "X(3)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sicfn.acproc_fil.trndatfr
"trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sicfn.acproc_fil.trndatto
"trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wactas4 - Delete Data From Export Text */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wactas4 - Delete Data From Export Text */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAcproc_fil
&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil C-Win
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:

DO WITH FRAME frST:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE 
                         (acproc_fil.type = "02" OR 
                          acproc_fil.type = "03" OR 
                          acproc_fil.type = "04" ) ) THEN DO:
        ASSIGN
            fiasdat = ?
            fiProcessdate = ?
            n_asdat       = ?
            nv_type       = ""
            nv_typdesc = "".
        DISP fiasdat fiProcessdate.
        
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            n_asdat       = fiasdat
            nv_type       = acproc_fil.type
            nv_typdesc = STRING(acproc_fil.typdesc,"x(100)").

        DISP fiasdat fiProcessdate .
    END.

  DISP nv_type @ fiType 
            nv_typdesc @ fiTypdesc WITH FRAME frTrandate.

END. /**/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
DEF VAR vAcno AS CHAR INIT "".
DEF VAR vFirstTime AS CHAR INIT "".
DEF VAR vLastTime AS CHAR INIT "".

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2
            FRAME frST fiasdat fiasdat
            FRAME frST fiProcessdate fiProcessdate

            n_frac     =   fiacno1
            n_toac    =   fiacno2
            n_asdat    = fiasdat
            nv_processdate = fiProcessdate 
            fiCount    = "".
   END.

   IF ( n_frac > n_toac)   THEN DO:
         Message "ข้อมูลตัวแทนผิดพลาด" SKIP
         "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fiacno1  .
         RETURN NO-APPLY.     
   END.
   IF ( n_asdat = ?  OR nv_processdate = ? )   THEN DO:
         Message "Asdat หรือ Process date ผิดพลาด" SKIP
         "โปรดระบุ" VIEW-AS ALERT-BOX WARNING . 
         RETURN NO-APPLY.
   END.
      

    MESSAGE "ทำการลบข้อมูล ! " SKIP (1)
            "ตัวแทน/นายหน้า : " n_frac     " ถึง " n_toac  SKIP (1)
            "Asdate                 : " STRING(n_asdat,"99/99/9999") SKIP (1)
            "Process Date      : " STRING(nv_processdate,"99/99/9999") SKIP (1)
            "Type                   : " nv_Type + " - " + STRING(nv_typdesc,"X(50)" )
    VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
    UPDATE CHOICE AS LOGICAL. 
    CASE CHOICE:
        WHEN TRUE THEN DO:
            vFirstTime =  STRING(TIME, "HH:MM AM").

            RUN pdDel  IN THIS-PROCEDURE.

            vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "ตัวแทน           : "  n_frac " ถึง " n_toac SKIP (1)
                    "Asdate            : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                    "ลบข้อมูลทั้งสิ้น  " fiCount   " รายการ"  SKIP (1)
                    "เวลา  " vFirstTime "  -  " vLastTime " น."  VIEW-AS ALERT-BOX INFORMATION.

            RUN pdUpdateQ.

            ASSIGN
                n_asdat    = ?
                nv_processdate = ?
                fiasdat = ?
                fiProcessdate = ?
                fiCount    = "".
            
            DISP fiasdat fiProcessdate  fiCount  WITH FRAME frst.
            
        END.
        WHEN FALSE THEN DO:
                    RETURN NO-APPLY.
        END.
    END CASE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 C-Win
ON CHOOSE OF buAcno1 IN FRAME frST /* ... */
DO:
   n_chkname = "1". 
  RUN Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  Disp fiacno1 finame1  with Frame {&Frame-Name}      .
 
 n_agent1 =  fiacno1 .

  Return NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 C-Win
ON CHOOSE OF buAcno2 IN FRAME frST /* ... */
DO:
  n_chkname = "2". 
  run Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno2 = n_agent2
        finame2 = n_name.
       
  Disp fiacno2 finame2 with Frame {&Frame-Name}      .
   
  n_agent2 =  fiacno2 .
  
  Return NO-APPLY.
 
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON LEAVE OF fiacno1 IN FRAME frST
DO:
    Assign
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME frST.
        
    IF Input  FiAcno1 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno1 = "".
              finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    End.    
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON RETURN OF fiacno1 IN FRAME frST
DO:
/*    Assign
 *   fiacno1 = input fiacno1
 *   n_agent1  = fiacno1.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON LEAVE OF fiacno2 IN FRAME frST
DO:
    Assign
        fiacno2 = input fiacno2
        n_agent2  = fiacno2.
     DISP CAPS(fiacno2) @ fiacno2 WITH FRAME frST.
            
    IF Input  FiAcno2 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno2 = "".
              finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON RETURN OF fiacno2 IN FRAME frST
DO:
/*      Assign
 *   fiacno2 = input fiacno2
 *   n_agent2  = fiacno2.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
 
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.  
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/
  
  SESSION:DATA-ENTRY-RETURN = YES.
/*  APPLY "ENTRY" TO fiToDay.*/


/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "wactas4".
  gv_prog  = "DELETE PROCESS PREMIUM STATEMENT (A4)".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTDICEN (c-win:HANDLE).

/*********************************************************************/  


DISABLE ALL EXCEPT  bracproc_fil WITH FRAME frST.    

    DO WITH FRAME frST:
        /*reProducer:MOVE-TO-TOP() .   */ 
       ASSIGN   
           fiacno1 = "A000000"
           fiacno2 = "B999999999". 

        DISPLAY fiacno1 fiacno2 fiProcessDate.

/*        RUN pdAcProc_fil.*/
        RUN pdUpdateQ.
    END.    
  
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
  ENABLE IMAGE-21 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiacno1 fiacno2 fiCount finame1 finame2 fiProcessDate fiAsdat 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE RECT-94 RECT11 buAcno1 fiacno1 fiacno2 buAcno2 fiCount brAcproc_fil 
         finame1 finame2 fiProcessDate fiAsdat 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  ENABLE IMAGE-23 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiType fiTypdesc 
      WITH FRAME frTranDate IN WINDOW C-Win.
  ENABLE RECT-95 fiType fiTypdesc 
      WITH FRAME frTranDate IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frTranDate}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdAcproc_fil C-Win 
PROCEDURE pdAcproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
  ASSIGN
    nv_ProcessDate = ?
    vAcProc_fil = "" 
    nv_type = ""
    nv_typdesc = "".
  FOR EACH AcProc_fil USE-INDEX by_type_asdat  
                                        WHERE (acproc_fil.type   = "01" OR acproc_fil.type   = "05")
                                        BY asdat DESC  :
        ASSIGN
            vAcProc_fil = vAcProc_fil + STRING( AcProc_fil.asdat,"99/99/9999")  + ",".
  END.

  ASSIGN
    cbAsDat:List-Items IN FRAME frST = vAcProc_fil
    cbAsDat = ENTRY (1, vAcProc_fil).
   
    FIND LAST acproc_fil WHERE (acproc_fil.type   = "01" OR acproc_fil.type   = "05") AND
                                                         acproc_fil.asdat = DATE(cbAsdat)   NO-LOCK NO-ERROR.
    IF AVAIL acproc_fil THEN DO:
        ASSIGN
            n_asdat      = acproc_fil.asdat
            n_trndatto   = acproc_fil.trndatto
            nv_ProcessDate = acproc_fil.entdat
            nv_type       = acproc_fil.type
            nv_typdesc = STRING(acproc_fil.typdesc,"x(100)").
    END.

    fiProcessDate = nv_ProcessDate.

  DISP cbAsDat fiProcessDate  WITH FRAME frST .
  
  DISP nv_type @ fiType 
            nv_typdesc @ fiTypdesc WITH FRAME frTrandate.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel C-Win 
PROCEDURE pdDel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR vCountOld AS INT.
                
    FOR  EACH  billing  WHERE 
              (billing.asdat   = n_asdat) OR
              (billing.trndat  = n_asdat  AND  billing.asdat <> ? )
    BREAK BY  billing.asdat :
               
        ACCUM  1 (count).

        DISP  nv_type  FORMAT "X(2)" 
                   billing.acno  billing.policy  billing.trnty1 billing.docno
          WITH COLOR BLACK/WHITE  NO-LABEL  FRAME frProcess VIEW-AS DIALOG-BOX  TITLE "Delete data ... " . 
                
        DELETE billing.
        
        
        IF  LAST-OF(billing.asdat) THEN DO:

                FIND LAST acProc_fil  USE-INDEX by_type_asdat  WHERE
                          acproc_fil.asdat  = n_asdat AND
                          acproc_fil.entdat = nv_ProcessDate AND
                          acproc_fil.type   = nv_type NO-ERROR.
                IF AVAIL acProc_fil THEN DO:
                        DELETE acProc_fil.
                END. 

        END.    /* acproc_fil */

    END.    /*billing */

    fiCount = "Delete = " +  STRING(ACCUM count 1 ) .
    
    DISP fiCount WITH FRAME frST.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ C-Win 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OPEN QUERY brAcproc_fil
    FOR EACH Acproc_fil   WHERE 
            (acproc_fil.type = "02" OR   /* "PROCESS STATEMENT BILLING(TAS)" */
             acproc_fil.type = "03" OR   /* "PROCESS STATEMENT BILLING(TISCO) IN CREDIT 60" */
             acproc_fil.type = "04" )    /* "PROCESS STATEMENT BILLING(TISCO) OUTSTRANDING" */
    BY acproc_fil.asdat DESC  .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR vLeapYear  AS LOGICAL.

vLeapYear = IF (y MOD 4 = 0) AND ((y MOD 100 <> 0) OR (y MOD 400 = 0)) 
                       THEN True ELSE False.


  RETURN vLeapYear.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxDay C-Win 
FUNCTION fuMaxDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR tday        AS INT FORMAT "99".
DEF VAR tmon       AS INT FORMAT "99".
DEF VAR tyear      AS INT FORMAT "9999".
DEF VAR maxday AS INT FORMAT "99".
  
ASSIGN 
                tday = DAY(vDate)
               tmon = MONTH(vDate)
               tyear = YEAR(vDate).
               /*  ให้ค่าวันที่สูงสุดของเดือนแก่ตัวแปร*/
               maxday = DAY(     DATE(tmon,28,tyear) + 4  - DAY(DATE(tmon,28,tyear) + 4)    ).
               
               
  RETURN maxday .   /* Function return value.  MaxDay*/

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumDay C-Win 
FUNCTION fuNumDay RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF  MONTH(vDate) = 1   OR  MONTH(vDate) = 3    OR
        MONTH(vDate) = 5   OR  MONTH(vDate) = 7    OR
        MONTH(vDate) = 8   OR  MONTH(vDate) = 10   OR
        MONTH(vDate) = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  MONTH(vDate) = 4   OR  MONTH(vDate) = 6    OR
         MONTH(vDate) = 9   OR  MONTH(vDate) = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  MONTH(vDate) = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth C-Win 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF vMonth = 1   OR  vMonth = 3    OR
        vMonth = 5   OR  vMonth = 7    OR
        vMonth = 8   OR  vMonth = 10   OR
        vMonth = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  vMonth = 4   OR  vMonth = 6    OR
         vMonth = 9   OR  vMonth = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  vMonth = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

