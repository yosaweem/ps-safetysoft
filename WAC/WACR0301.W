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

/************   Program   **************
Wac
        -Wacr02.w            /*PRINT PREMIUM STATEMENT (A4)*/
WPrl
        -Wac_sm01.prl
Whp
        -WhpBran.w
        -WhpAcno.w
        -WhpClico.w
Wut
        -WutDiCen.p
        -WutWiCen.p

/* Modify : Kanchana C.  31/10/2002  
                แก้ไข  ออก text file ให้ออกเป็น text file คั่นด้วย ";"  แล้วจึงนำเข้า Excel   */


*****************************************/    
/* ***************************  Definitions  ************************** */
DEF     SHARED VAR n_User               AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.  
DEF      VAR   nv_User     AS CHAR NO-UNDO. 
DEF      VAR   nv_pwd    LIKE _password NO-UNDO.

/* Definitons  Report -------                                               */
DEF  VAR report-library AS CHAR INIT "wAC/wprl/wac_0201.prl".
DEF  VAR report-name  AS CHAR INIT "CHECK LIST ST (A4) <11".

DEF  VAR RB-DB-CONNECTION AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS AS CHAR INIT "O". /*Can Override Filter*/
DEF  VAR RB-FILTER AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE AS INTE INIT 0.
DEF  VAR RB-END-PAGE AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN AS LOG INIT no.
DEF  VAR RB-WINDOW-TITLE AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS AS LOG INIT yes.
DEF  VAR RB-DISPLAY-STATUS AS LOG INIT yes.
DEF  VAR RB-NO-WAIT AS LOG INIT no.
DEF  VAR RB-OTHER-PARAMETERS AS CHAR INIT "".

/* Parameters Definitions ---                                           */
DEF NEW SHARED VAR n_agent1      AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2      AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_branch      AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2    AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod      AS CHAR FORMAT "X(4)"    INIT "U021".   /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod       AS CHAR FORMAT "X(4)".

Def   Var    n_name            As Char Format "x(50)".     /*acno name*/
Def   Var    n_chkname      As Char format "x(1)".        /* Acno-- chk button 1-2 */
Def   Var    n_bdes             As Char Format "x(50)".     /*branch name*/
Def   Var    n_chkBname    As Char format "x(1)".        /* branch-- chk button 1-2 */
Def   Var    n_itmdes          As Char Format "x(40)".     /*Table-Code Description*/

/* Local Variable Definitions ---                                       */

DEF VAR nv_asmth   AS INTE INIT 0.
DEF VAR nv_frmth   AS INTE INIT 0.
DEF VAR nv_tomth   AS INTE INIT 0.
DEF VAR cv_mthlistT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_asdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr      AS   CHAR   FORMAT "x(2)".
DEF VAR n_tobr     AS   CHAR   FORMAT "x(2)".
DEF VAR n_frac     AS   CHAR   FORMAT "x(7)".
DEF VAR n_toac    AS   CHAR   FORMAT "x(7)".
DEF VAR n_typ      AS   CHAR   FORMAT "X".
DEF VAR n_typ1     AS   CHAR   FORMAT "X".
DEF VAR n_trndatto  AS DATE FORMAT "99/99/9999".

DEF VAR n_chkCopy     AS INTEGER.
DEF VAR n_OutputTo    AS INTEGER.
DEF VAR n_OutputFile  AS Char.

DEF VAR vCliCod        AS CHAR.
DEF VAR vCliCodAll   AS CHAR.
DEF VAR vCountRec   AS INT.
DEF VAR vzAcproc_fil  AS CHAR.

DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "I:/SAFETY/WALP83/WIMAGE\wallpape":U CONVERT-3D-COLORS
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-23
     FILENAME "I:/SAFETY/WALP83/WIMAGE\bgc01":U CONVERT-3D-COLORS
     SIZE 93.5 BY 20.09.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.78
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.78
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 18.5 BY 4.44
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS " "
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .96
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item 1", 1,
"Item 2", 2,
"Item 3", 3
     SIZE 12.5 BY 3
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE cbAsDat AS CHARACTER FORMAT "X(256)":U INITIAL ? 
     LABEL "cbAsDat" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "item 1" 
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE cbRptList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "wac_0201.prl" 
     SIZE 33 BY .96
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE raY AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          " No", 1,
" Yes", 2
     SIZE 12.5 BY 2
     FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE raZ AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          " No", 1,
" Yes", 2
     SIZE 12 BY 2
     FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 86.5 BY 11.91.

DEFINE RECTANGLE reReprots
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 67 BY 5.22
     BGCOLOR 8 .

DEFINE RECTANGLE reType
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 43 BY 4.96
     BGCOLOR 8 .

DEFINE RECTANGLE reY
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 15 BY 3.13
     BGCOLOR 3 .

DEFINE RECTANGLE reZ
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 15 BY 3.13
     BGCOLOR 3 .


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
         AT COL 19.5 ROW 2.7
         SIZE 94 BY 20.35.

DEFINE FRAME frOutput
     rsOutput AT ROW 2.3 COL 2.5 NO-LABEL
     cbPrtList AT ROW 3.35 COL 17.5 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 4.44 COL 17.5 COLON-ALIGNED NO-LABEL
     " Output To":40 VIEW-AS TEXT
          SIZE 49 BY .96 TOOLTIP "การแสดงผล" AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 4 ROW 15.5
         SIZE 49 BY 5
         BGCOLOR 3 .

DEFINE FRAME frST
     cbRptList AT ROW 3.35 COL 36.5 COLON-ALIGNED NO-LABEL
     cbAsDat AT ROW 4.91 COL 37 COLON-ALIGNED
     raY AT ROW 10.91 COL 28.5 NO-LABEL
     raZ AT ROW 10.91 COL 48 NO-LABEL
     fiProcessDate AT ROW 6.48 COL 37 COLON-ALIGNED NO-LABEL
     reZ AT ROW 9.87 COL 46.5
     " Print Type  Z":20 VIEW-AS TEXT
          SIZE 14.5 BY .96 TOOLTIP "Print Z" AT ROW 9.87 COL 46.83
          BGCOLOR 1 FGCOLOR 7 
     " Print Type Y":20 VIEW-AS TEXT
          SIZE 14.5 BY .96 TOOLTIP "Print Y" AT ROW 9.87 COL 27.33
          BGCOLOR 1 FGCOLOR 7 
     RECT1 AT ROW 2.04 COL 1
     reReprots AT ROW 2.83 COL 11
     " As of Date":30 VIEW-AS TEXT
          SIZE 17.5 BY .96 TOOLTIP "วันที่ออกรายงาน" AT ROW 4.91 COL 17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Type Of Reports":50 VIEW-AS TEXT
          SIZE 17.5 BY .96 TOOLTIP "ประเภทรายงาน" AT ROW 3.35 COL 17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     " Process Date":30 VIEW-AS TEXT
          SIZE 17.5 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 6.48 COL 17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                                                CHECK LIST STATEMENT (A4)":160 VIEW-AS TEXT
          SIZE 86.5 BY .96 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     " Include Type" VIEW-AS TEXT
          SIZE 43 BY .96 AT ROW 8.57 COL 24
          BGCOLOR 1 FGCOLOR 7 FONT 6
     reType AT ROW 8.57 COL 24
     reY AT ROW 9.87 COL 27
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.74
         SIZE 87 BY 13.09
         BGCOLOR 3 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.7 COL 5.5
     Btn_Cancel AT ROW 3.61 COL 5.5
     RECT2 AT ROW 1.26 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 70 ROW 15.5
         SIZE 21 BY 5
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
         TITLE              = "wacr0301 - CHECK LIST STATEMENT (A4) <11"
         HEIGHT             = 24.04
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.04
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.04
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frOutput
                                                                        */
/* SETTINGS FOR FRAME frST
                                                                        */
/* SETTINGS FOR COMBO-BOX cbAsDat IN FRAME frST
   LABEL "cbAsDat:"                                                     */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacr0301 - CHECK LIST STATEMENT (A4) <11 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacr0301 - CHECK LIST STATEMENT (A4) <11 */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
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

   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST raY
            FRAME frST raZ
            FRAME frST cbRptList cbRptList
                                
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name

            n_asdat    =  DATE( INPUT cbAsDat)            
            n_typ        =  IF raY = 1 THEN "" ELSE "Y"
            n_typ1      =  IF raZ = 1 THEN "" ELSE "Z"
            
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name  .        
    
   END.
        
    FIND LAST zAcproc_fil USE-INDEX by_type_asdat  
                        WHERE (zAcproc_fil.type = "01" AND zAcproc_fil.asdat = n_asdat)  NO-ERROR .
    IF AVAIL zAcproc_fil THEN DO:
            n_trndatto   = zAcproc_fil.trndatto.
    END.

   If  n_frac = "" Then  n_frac   = "A000000".
   If  n_toac = "" Then  n_toac = "B999999".
  
   IF n_OutputTo = 3 And n_OutputFile = ""    THEN DO:
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFile-Name .
         Return No-Apply.       
   END.
 
/* kan connect sicfn ---*/
      FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "stat"
                                            NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL dbtable THEN DO:
             IF dbtable.phyname = "form" THEN 
                    ASSIGN 
                        nv_User  = "?"
                        nv_pwd = "?".
/*dbtable.phyname = "stat"*/
         ELSE      
                   ASSIGN 
                        nv_User   =   n_user
                        nv_pwd    =   n_passwd.
                         RB-DB-CONNECTION  = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
      END.
/*---kan*/

    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE  "ตัวแทน/นายหน้า  : "  n_frac " ถึง " n_toac skip (1)
                            "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") skip (1)
                            "พิมพ์รายงาน        : " cbRptList VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
            ASSIGN  
                    nv_User   =   n_user               
                    nv_pwd    =   n_passwd                 
              report-name  =  cbRptList

              /* RB-DB-CONNECTION  = "-H alpha4 -S stat" +  " -U " + nv_user + " -P " + nv_pwd */
               /*RB-DB-CONNECTION  = "-H brpy -S stattest" +  " -U " + nv_user + " -P " + nv_pwd */
              
              RB-INCLUDE-RECORDS = "O"
              RB-FILTER            = 'zagtprm_fil.asdat = ' + 
                                                    STRING (MONTH (n_asdat)) + "/" + 
                                                    STRING (DAY (n_asdat)) + "/" + 
                                                    STRING (YEAR (n_asdat)) + 
                                                    " AND " +
                                                    "zagtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                                    "zagtprm_fil.acno <= '" + n_toac + "'" +
                                                    " AND " +
                                                    "( SUBSTRING(zagtprm_fil.trntyp,1,1) = 'M' " + " OR " + 
                                                    "SUBSTRING(zagtprm_fil.trntyp,1,1) = 'A' " + " OR " + 
                                                    "SUBSTRING(zagtprm_fil.trntyp,1,1) = 'R' " + " OR " + 
                                                    "SUBSTRING(zagtprm_fil.trntyp,1,1) = 'B' " + " OR " + 
                                                    "SUBSTRING(zagtprm_fil.trntyp,1,1) = 'C' " + " OR " +                                                     
                                                    "SUBSTRING(zagtprm_fil.trntyp,1,1) = '" + n_typ + "'" + " OR " + 
                                                    "SUBSTRING(zagtprm_fil.trntyp,1,1) = '" + n_typ1 + "' )" 
                                                    
                                                                                                                                                                                                                    
              RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
              RB-PRINTER-NAME   = IF rsOutput = 2 THEN cbPrtList ELSE " "
              RB-OUTPUT-FILE       = IF rsOutput = 3 THEN fiFile-Name ELSE " "
              RB-NO-WAIT               = No
              RB-OTHER-PARAMETERS =  "rb_vCliCod     = " + STRING(vCliCod) + CHR(10) +  
                                                                  "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") .
            IF rsOutput = 3 THEN DO:
                ASSIGN
                    report-library = "wAC/wprl/wac_0201.prl"
                    report-name  = "Check List ST (A4) to Excel <11".
            END.
            ELSE DO:
                ASSIGN
                    report-library = "wAC/wprl/wac_0201.prl"
                    report-name  = cbRptList.
            END.
              
            RUN aderb\_printrb(report-library, 
                           report-name,
                           RB-DB-CONNECTION,
                           RB-INCLUDE-RECORDS,
                           RB-FILTER,
                           RB-MEMO-FILE,
                           RB-PRINT-DESTINATION,
                           RB-PRINTER-NAME,
                           RB-PRINTER-PORT,
                           RB-OUTPUT-FILE,
                           RB-NUMBER-COPIES,
                           RB-BEGIN-PAGE,
                           RB-END-PAGE,
                           RB-TEST-PATTERN,
                           RB-WINDOW-TITLE,
                           RB-DISPLAY-ERRORS,
                           RB-DISPLAY-STATUS,
                           RB-NO-WAIT,
                           RB-OTHER-PARAMETERS).
                           
            MESSAGE " As of Date : " STRING(n_asdat,"99/99/9999")  
                                VIEW-AS ALERT-BOX INFORMATION.

        END.
        WHEN FALSE THEN    DO:
        
                RETURN NO-APPLY. 
        END.
        END CASE.    
        
    END.   /* IF  asdat  <> ? */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME cbAsDat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbAsDat C-Win
ON VALUE-CHANGED OF cbAsDat IN FRAME frST /* cbAsDat */
DO:
      FIND LAST zAcproc_fil WHERE zAcproc_fil.type   = "01" AND 
                                                         zAcproc_fil.asdat = DATE(INPUT cbAsdat)   NO-LOCK NO-ERROR.
    IF AVAIL zAcproc_fil THEN  nv_ProcessDate = zAcproc_fil.entdat.   

    fiProcessDate = nv_ProcessDate.

    DISP fiProcessDate WITH FRAME frST.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput C-Win
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
  CASE rsOutput:
        WHEN 1 THEN  /* Screen */
          ASSIGN
           cbPrtList:SENSITIVE   = No
           fiFile-Name:SENSITIVE = No.
        WHEN 2 THEN  /* Printer */
          ASSIGN
           cbPrtList:SENSITIVE   = Yes
           fiFile-Name:SENSITIVE = No.
        WHEN 3 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = Yes. 
          APPLY "ENTRY" TO fiFile-Name.
        END.
  END CASE.
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
  
  DO WITH FRAME frST :
    reY:MOVE-TO-TOP() .
    reZ:MOVE-TO-TOP() .

  RUN ProcGetRptList.
  RUN ProcGetPrtList.  

       ASSIGN   
            cbAsdat  = vzAcproc_fil.
        DISPLAY cbAsdat.

    RUN pdInitData.  
    RUN pdSym100.
  END.    
  DO WITH FRAME frTranDate:
       ASSIGN  
         rsOutput:Radio-Buttons = "Screen, 1,Printer, 2, File, 3" /*"หน้าจอ, 1,เครื่องพิมพ์, 2, File, 3" */
         rsOutput = 2
          
         cbPrtList:SENSITIVE    = Yes
         fiFile-Name:SENSITIVE  = No.
      DISPLAY rsOutput WITH FRAME frOutput .    
        
        RUN pdzAcproc_fil.
  END.

           
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win _DEFAULT-DISABLE
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win _DEFAULT-ENABLE
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
  DISPLAY cbRptList cbAsDat raY raZ fiProcessDate 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE reZ RECT1 reReprots reType reY cbRptList cbAsDat raY raZ fiProcessDate 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  ENABLE IMAGE-23 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE rsOutput cbPrtList fiFile-Name 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData C-Win 
PROCEDURE pdInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FIND FIRST  xmm023 NO-ERROR.
 *     IF AVAIL xmm023  THEN  DO:
 *         DO WITH FRAME frST :
 *             ASSIGN 
 *                 fiBranch  = xmm023.branch
 *                 fibdes     = xmm023.bdes.
 *              DISP fiBranch fibdes .
 *          END.
 *     END.     
 * 
 * FIND Last  xmm023 NO-ERROR.
 *     IF AVAIL xmm023  THEN  DO:
 *         DO WITH FRAME frST :
 *             ASSIGN 
 *                 fiBranch2  = xmm023.branch
 *                 fibdes2     = xmm023.bdes.
 *              DISP fiBranch2 fibdes2 .
 *          END.
 *     END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSym100 C-Win 
PROCEDURE pdSym100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  vCliCodAll = "" .
  FOR EACH sym100 USE-INDEX sym10001  WHERE sym100.tabcod = "U021"  :
        vCliCodAll = vCliCodAll + sym100.itmcod  + ",".
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdzAcproc_fil C-Win 
PROCEDURE pdzAcproc_fil :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  vzAcproc_fil = "" .
  FOR EACH zAcproc_fil USE-INDEX by_type_asdat  WHERE zAcproc_fil.type = "01"
                                         BY asdat DESC  :
        ASSIGN
            vzAcproc_fil = vzAcproc_fil + STRING( zAcproc_fil.asdat,"99/99/9999")  + ",".
  END.

  ASSIGN
    cbAsDat:List-Items IN FRAME frST = vzAcproc_fil
    cbAsDat = ENTRY (1, vzAcproc_fil).
    
  DISP cbAsDat WITH FRAME frST .
  
    FIND LAST zAcproc_fil WHERE zAcproc_fil.type   = "01" AND 
                                                         zAcproc_fil.asdat = DATE(INPUT cbAsdat)   NO-LOCK NO-ERROR.
    IF AVAIL zAcproc_fil THEN  nv_ProcessDate = zAcproc_fil.entdat.   
    
    fiProcessDate = nv_ProcessDate.
    
    DISP fiProcessDate WITH FRAME frST.  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetPrtList C-Win 
PROCEDURE ProcGetPrtList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  def var printer-list  as character no-undo.
  def var port-list     as character no-undo.
  def var printer-count as integer no-undo.
  def var printer       as character no-undo format "x(32)".
  def var port          as character no-undo format "x(20)".

  run aderb/_prlist.p (output printer-list, output port-list,
                 output printer-count).

  ASSIGN
    cbPrtList:List-Items IN FRAME frOutput = printer-list
    cbPrtList = ENTRY (1, printer-list).
    
  DISP cbPrtList WITH FRAME frOutput.
  RB-PRINTER-NAME = cbPrtList:SCREEN-VALUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetRptList C-Win 
PROCEDURE ProcGetRptList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR report-list   AS CHARACTER.
DEF VAR report-count  AS INTEGER.
DEF VAR report-number AS INTEGER.

  RUN _getname (SEARCH (report-library), OUTPUT report-list,        /* aderb/_getname.p */
    OUTPUT report-count).
  
  IF report-count = 0 THEN RETURN NO-APPLY.

  DO WITH FRAME frST :
        ASSIGN
          cbRptList:List-Items = report-list
          report-number = LOOKUP (report-name,report-list)
          cbRptList     = IF report-number > 0 THEN ENTRY (report-number,report-list)
                                  ELSE ENTRY (1, report-list).    
  
       DISP cbRptList . 
  END.
  
/*     message  "cbRptList" report-library  skip (1) 
 *                  cbRptList view-as alert-box.*/
 
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


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
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


