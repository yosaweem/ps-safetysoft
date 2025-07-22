&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
File: Process  PREW-FILE
Description: Filter Data จาก uwm200, uwm100, uwd200 มาเก็บไว้ที่ ucrein
Input Parameters:  
          Trans.Date From...To...
Output Parameters:
          Output oto Excel File....
Author:   By Sayamol.N Assign No: A49-0158
Created:  01/12/2006

Modify By : TANTAWAN C.   26/01/2008   [A500178]
             ปรับ FORMAT branch เพื่อรองรับการขยายสาขา
             ปรับให้มาใช้ branch   ที่  uwm100.branch   เดิม  substring(uwm100.policy,2,1)
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
/* Program Name:  Process Reinsurance for PREW                          */
/* Program By: A49-0158 Sayamol                                         */ 
/* Date: 13/09/2006                                                     */
/* Date; 28/05/2007         Add Branch for                              */

DEF VAR n_chkprocess AS LOGIC INIT NO.
DEF VAR nv_type      AS CHAR .  /* "PROCESS PREW-FILE" (11,12,13,14)*/
DEF VAR n_usrid      AS CHAR FORMAT "X(7)".
DEF VAR n_user       AS CHAR FORMAT "X(7)".

DEF VAR n_asdat    AS DATE FORMAT "99/99/9999".   /* = Today = acProc_fil.entdat*/
DEF VAR fr_trndat  AS DATE FORMAT "99/99/9999" LABEL "Trans.Date From: ".
DEF VAR to_trndat  AS DATE FORMAT "99/99/9999" LABEL "Trans.Date To: ".

DEF VAR n_prodat   AS CHAR FORMAT "X(6)".    /* YYYYMM from As of Date (Process) */
DEF VAR n_point    AS CHAR FORMAT "X(15)".   /* YYYYMMBRXXXXXXX                    */
DEF VAR n_poltyp   AS INT  FORMAT 999.       /* Policy Type                      */
DEF VAR n_uwyr     AS CHAR FORMAT "X(2)".    /* Underwrite Year                  */
DEF VAR n_prem     AS DEC  FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR n_type     AS CHAR FORMAT "X(3)".   /*Di/Ri Pol & End*/
DEF VAR n_rico     LIKE uwd200.rico.
DEF VAR nv_gstrat  AS INT  FORMAT  9.
DEF VAR n_line     AS CHAR FORMAT "X(3)".
DEF VAR n_vat      AS CHAR  FORMAT "9".
DEF VAR n_br       AS CHAR FORMAT "X(2)".
DEF VAR n_poltypfr AS CHAR FORMAT "X(2)".
DEF VAR n_poltypto AS CHAR FORMAT "X(2)".
DEF VAR n_hpPol1      AS   CHAR.
DEF VAR n_hpDesPol1   AS   CHAR.
DEF VAR n_hpPol2      AS   CHAR.
DEF VAR n_hpDesPol2   AS   CHAR.
DEF VAR n_hptyp1      AS   CHAR.
DEF VAR n_hpDestyp1   AS   CHAR.
 
DEF VAR n_proctyp      AS INT INIT 0.   /*D/I*/
DEF VAR nv_frm_policy AS CHAR FORMAT "X(16)".
DEF VAR nv_to_policy  AS CHAR FORMAT "X(16)".
DEF VAR n_fr_pol AS CHAR FORMAT "X".
DEF VAR n_bran   AS CHAR FORMAT "X(2)" init "0".
DEF VAR n_brto   AS CHAR FORMAT "X(2)" init "Z".
DEF VAR n_br1    AS CHAR FORMAT "X".
DEF VAR typ      AS CHAR FORMAT "X(3)".

DEF VAR nv_ripr    AS DEC.

DEF VAR s_recid      AS RECID.
DEF VAR nv_output AS CHAR FORMAT "X(30)".
def VAR nt_stat_pr   like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_ret_pr    like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_0q_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_0t_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_0s_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_f1_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_f2_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_f3_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_f4_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99". /* A450055*/
def VAR nt_0rq_pr    like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_0ps_pr    like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_btr_pr    like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_otr_pr    like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".
def VAR nt_ftr_pr    like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".  /* A450055*/
def VAR nt_s8_pr     like  uwd200.ripr FORMAT "->>,>>>,>>>,>>9.99".

DEF VAR nv_brn_line  AS CHAR.
DEF VAR nt_sigr      LIKE uwm100.sigr_p.
DEF VAR nt_prem      LIKE uwm100.prem_t.
DEF VAR nt_com       LIKE uwm100.com1_t.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "Cancel" 
     SIZE 13.83 BY 1.91
     FONT 36.

DEFINE BUTTON bu_hptyp 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "Btn 2" 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_hptyp-2 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "Btn 2" 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 14.17 BY 1.91
     FONT 36.

DEFINE VARIABLE fi_asdat AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 13.5 BY .95
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltypfr AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltypfr1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 31 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltypto AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_poltypto1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 61.5 BY 1
     BGCOLOR 31 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-289
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 32 BY 2.67
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-290
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 78.5 BY 8.33
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-291
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 75 BY 7.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-292
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 94.83 BY 3.38.

DEFINE RECTANGLE RECT-293
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 112.5 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 112.5 BY 19.76
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.19
         SIZE 119.83 BY 21.62
         BGCOLOR 3 FGCOLOR 0 .

DEFINE FRAME fr_prem
     fi_trndatfr AT ROW 3.33 COL 26.67 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 3.38 COL 74 COLON-ALIGNED NO-LABEL
     fi_poltypfr AT ROW 5.19 COL 26.67 COLON-ALIGNED NO-LABEL
     fi_asdat AT ROW 15 COL 55.17 COLON-ALIGNED
     bu_hptyp AT ROW 5.19 COL 35.67
     fi_poltypto AT ROW 6.57 COL 26.67 COLON-ALIGNED NO-LABEL
     bu_hptyp-2 AT ROW 6.57 COL 35.67
     fi_poltypfr1 AT ROW 5.24 COL 39.17 COLON-ALIGNED NO-LABEL
     fi_poltypto1 AT ROW 6.62 COL 39.17 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 18.05 COL 43.67
     bu_cancel AT ROW 18.05 COL 59.17
     "Trans.Date From:" VIEW-AS TEXT
          SIZE 17.5 BY .95 AT ROW 3.33 COL 10.17
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "D/I:" VIEW-AS TEXT
          SIZE 4.67 BY .95 AT ROW 10.81 COL 52
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Policy Type From:" VIEW-AS TEXT
          SIZE 17.67 BY .95 AT ROW 5.24 COL 10
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Branch From:" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 12.14 COL 43.17
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Relase:" VIEW-AS TEXT
          SIZE 7.67 BY .95 AT ROW 13.57 COL 48.67
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "PROCESS REINSURANCE FOR PREW-FILE" VIEW-AS TEXT
          SIZE 42.83 BY 1.38 AT ROW 1.19 COL 35.83
          BGCOLOR 1 FGCOLOR 15 FONT 6
     " 0" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 12.19 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Policy and Endorsement" VIEW-AS TEXT
          SIZE 24.17 BY .95 AT ROW 9.48 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " Direct and Inward" VIEW-AS TEXT
          SIZE 18.67 BY .95 AT ROW 10.71 COL 57.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "To:" VIEW-AS TEXT
          SIZE 4.17 BY .95 AT ROW 12.14 COL 62.83
          BGCOLOR 8 FGCOLOR 0 FONT 6
     " Z" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 12.19 COL 66.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     " YES" VIEW-AS TEXT
          SIZE 5.17 BY .95 AT ROW 13.62 COL 57.33
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Process:" VIEW-AS TEXT
          SIZE 9 BY .95 AT ROW 9.43 COL 47.5
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Trans.Date To:" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 3.38 COL 60.67
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "As of Date:" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 15 COL 45.17
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Policy Type To:" VIEW-AS TEXT
          SIZE 15.33 BY .95 AT ROW 6.62 COL 12.33
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Policy Type To:" VIEW-AS TEXT
          SIZE 15.33 BY .95 AT ROW 6.62 COL 12.33
          BGCOLOR 8 FGCOLOR 0 FONT 6
     RECT-84 AT ROW 1 COL 1
     RECT-289 AT ROW 17.62 COL 42.33
     RECT-290 AT ROW 8.62 COL 18.33
     RECT-291 AT ROW 9.1 COL 20
     RECT-292 AT ROW 4.76 COL 9.17
     RECT-293 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4.33 ROW 1.81
         SIZE 113.17 BY 20
         BGCOLOR 15 FGCOLOR 2 FONT 6.


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
         HEIGHT             = 21.81
         WIDTH              = 119.83
         MAX-HEIGHT         = 21.81
         MAX-WIDTH          = 119.83
         VIRTUAL-HEIGHT     = 21.81
         VIRTUAL-WIDTH      = 119.83
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
ASSIGN FRAME fr_prem:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME fr_prem
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_asdat IN FRAME fr_prem
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN fi_poltypfr1 IN FRAME fr_prem
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_poltypto1 IN FRAME fr_prem
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
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
&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME fr_prem /* Cancel */
DO:
     APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hptyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hptyp C-Win
ON CHOOSE OF bu_hptyp IN FRAME fr_prem /* Btn 2 */
DO:   
  CURRENT-WINDOW:SENSITIVE = NO.   
  RUN Whp\WhpPtyp1(INPUT-OUTPUT n_hptyp1,INPUT-OUTPUT n_hpdestyp1).
  CURRENT-WINDOW:SENSITIVE = Yes. 
  ASSIGN  
    fi_poltypfr = n_hptyp1 
    fi_poltypfr1 = n_hpDestyp1
    n_poltypfr = fi_poltypfr.
  DISP fi_poltypfr fi_poltypfr1 WITH FRAME {&FRAME-NAME}.
       Apply "Entry" To fi_poltypfr.
       Return No-Apply.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hptyp-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hptyp-2 C-Win
ON CHOOSE OF bu_hptyp-2 IN FRAME fr_prem /* Btn 2 */
DO:   
  CURRENT-WINDOW:SENSITIVE = NO.   
  RUN Whp\WhpPtyp1(INPUT-OUTPUT n_hptyp1,INPUT-OUTPUT n_hpdestyp1).
  CURRENT-WINDOW:SENSITIVE = Yes. 
  ASSIGN  
    fi_poltypto = n_hptyp1 
    fi_poltypto1 = n_hpDestyp1.
    n_poltypto = fi_poltypto.
  DISP fi_poltypto fi_poltypto1 WITH FRAME {&FRAME-NAME}.
       APPLY  "Entry" TO fi_poltypto.
       RETURN  NO-APPLY.  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_prem /* OK */
DO:

  DEF VAR vFirstTime AS CHAR INIT "".
  DEF VAR vLastTime  AS CHAR INIT "".

  ASSIGN n_usrid = USERID(LDBNAME(1))
         n_user  = n_usrid
         nv_type = "11". 
 

  RUN pdChkProcess01.  /* ตรวจสอบว่า เคยมีการ process ใน type 11,12 หรือไม่ ถ้าซ้ำ จะไม่ process ให้ */

  IF n_chkprocess = YES THEN DO:

     vFirstTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
     
     RUN Processpol.   /* Create Data on TABLE-UCREIN */

     RUN pdProcessYes. /* ถ้า process เสร็จให้ Process complete = YES  elapsed*/
     
     vLastTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
     MESSAGE "วันที่ออกรายงาน : " STRING(n_asdat,"99/99/9999")  SKIP (1)
             "วันที่เริ่มต้น : "  STRING(fr_trndat,"99/99/9999") " ถึง "
                                  STRING(to_trndat,"99/99/9999")  SKIP (1)
             "เวลา  " SUBSTR(vFirstTime,1,18) "  -  " 
                      SUBSTR(vLastTime,1,18) " น."
     VIEW-AS ALERT-BOX INFORMATION.

     /* ประมวลผลเสร็จออกจากโปรแกรมทันที*/
     MESSAGE "ประมวลผลเรียบร้อย"  VIEW-AS ALERT-BOX INFORMATION.
    
  END.

  ELSE DO:
     MESSAGE "ไม่สามารถ Process ได้ เนื่องจาก"  SKIP (1)
             "มีการ Process ใน As date นี้แล้ว" 
     VIEW-AS ALERT-BOX ERROR.
     RETURN NO-APPLY.
  END.  /*n_chkprocess = yes*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltypfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltypfr C-Win
ON LEAVE OF fi_poltypfr IN FRAME fr_prem
DO:
  fi_poltypfr = INPUT fi_poltypfr.

  IF INPUT fi_poltypfr <> "" THEN DO:

      FIND FIRST xmm031 USE-INDEX xmm03101        WHERE
             xmm031.poltyp = INPUT fi_poltypfr  NO-LOCK NO-ERROR.
      IF NOT AVAILABLE xmm031 THEN DO:
         MESSAGE  "Not on Policy Type Parameter file xmm031" VIEW-AS ALERT-BOX ERROR.
         APPLY "ENTRY" TO fi_poltypfr.
      END.
      ELSE DO :   
         fi_poltypfr   =  CAPS( INPUT fi_poltypfr).
         fi_poltypfr1  =  xmm031.poldes.
         DISPLAY  fi_poltypfr fi_poltypfr1 WITH FRAME {&FRAME-NAME}.
      END.   
  END.
  ELSE DO:
        ASSIGN 
             fi_poltypfr  = "" 
             fi_poltypfr1 = "".
        DISP fi_poltypfr  fi_poltypfr1 WITH FRAME {&FRAME-NAME}.
  END.  

  ASSIGN n_poltypfr = fi_poltypfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltypto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltypto C-Win
ON LEAVE OF fi_poltypto IN FRAME fr_prem
DO:
  fi_poltypto = INPUT fi_poltypto.

  IF INPUT fi_poltypto <> "" THEN DO:

      FIND FIRST xmm031 USE-INDEX xmm03101        WHERE
                 xmm031.poltyp = INPUT fi_poltypto  NO-LOCK NO-ERROR.
      IF NOT AVAILABLE xmm031 THEN DO:
         MESSAGE  "Not on Policy Type Parameter file xmm031" VIEW-AS ALERT-BOX ERROR.
         APPLY "ENTRY" TO fi_poltypto.
      END.
      ELSE DO :   
         IF SUBSTR(fi_poltypto,2,2) < SUBSTR(fi_poltypfr,2,2) THEN DO:
            fi_poltypto = "".
            DISP fi_poltypto WITH FRAME {&FRAME-NAME}.
            MESSAGE "Please Put Policy Type To:  >=  Policy Type From:"  VIEW-AS ALERT-BOX INFORMATION.
            APPLY "ENTRY" TO fi_poltypto.
         END.
         ELSE DO:
             fi_poltypto   =  CAPS( INPUT fi_poltypto).
             fi_poltypto1  =  xmm031.poldes.
             DISPLAY  fi_poltypto fi_poltypto1 WITH FRAME {&FRAME-NAME}.
         END.
      END.  
  END.
  ELSE DO:
        ASSIGN 
             fi_poltypto  = "" 
             fi_poltypto1 = "".
        DISP fi_poltypto  fi_poltypto1 WITH FRAME {&FRAME-NAME}.
  END.  

  ASSIGN n_poltypto = fi_poltypto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr C-Win
ON LEAVE OF fi_trndatfr IN FRAME fr_prem
DO:
  ASSIGN fr_trndat = INPUT fi_trndatfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto C-Win
ON LEAVE OF fi_trndatto IN FRAME fr_prem
DO:
  ASSIGN to_trndat = INPUT fi_trndatto.


  IF to_trndat = ?  THEN
     MESSAGE  "Please, Key In To Date"
     VIEW-AS ALERT-BOX INFORMATION.

  IF to_trndat < fr_trndat THEN DO:
     MESSAGE "Trans.Date To ต้องมากกว่าหรือเท่ากับ Trans.Date From" 
     VIEW-AS ALERT-BOX INFORMATION.
     APPLY "ENTRY" TO fi_trndatto.
     RETURN NO-APPLY.
  END.

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
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  gv_prgid = "WACPREW".
  gv_prog  = "(Reinsurance) Process for PREW-File ".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:handle).
  Session:data-Entry-Return = Yes.
  
  ASSIGN 
    fr_trndat   = TODAY
    to_trndat   = TODAY
    n_asdat     = TODAY
    n_poltypfr  = "F10"
    n_poltypto  = "C91"
    nv_type     = "11".   /*Default=Policy*/
       
         
          

  DISP fr_trndat @ fi_trndatfr WITH FRAME fr_prem.
  DISP to_trndat @ fi_trndatto WITH FRAME fr_prem.
  DISP n_asdat @ fi_asdat WITH FRAME fr_prem.
  DISP n_poltypfr @ fi_poltypfr WITH FRAME fr_prem.
  DISP n_poltypto @ fi_poltypto WITH FRAME fr_prem.

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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fi_trndatfr fi_trndatto fi_poltypfr fi_asdat fi_poltypto fi_poltypfr1 
          fi_poltypto1 
      WITH FRAME fr_prem IN WINDOW C-Win.
  ENABLE fi_trndatfr fi_trndatto fi_poltypfr fi_asdat bu_hptyp fi_poltypto 
         bu_hptyp-2 bu_ok bu_cancel RECT-84 RECT-289 RECT-290 RECT-291 RECT-292 
         RECT-293 
      WITH FRAME fr_prem IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_prem}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess01 C-Win 
PROCEDURE pdChkProcess01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_chkprocess = NO.

FIND LAST acProc_fil  USE-INDEX by_type_asdat  WHERE
         (acProc_fil.asdat = n_asdat AND 
          acProc_fil.type  = nv_type) OR
         (acProc_fil.asdat = n_asdat AND 
          acProc_fil.type  = nv_type AND
   SUBSTR(acProc_fil.enttim,10,3)  = "YES") NO-ERROR.
IF AVAIL acProc_fil THEN DO:
  n_chkprocess = NO.  
END.
ELSE DO:
       n_chkprocess = YES.  /*ไม่พบ  11  สามารถ process ได้*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCrt11 C-Win 
PROCEDURE pdCrt11 :
/*------------------------------------------------------------------------------
  Purpose:   Create acProc_fil with type = "11" (DIRECT Policy&Endorse)  
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
           acProc_fil.type  = "11"    AND 
           acProc_fil.asdat = n_asdat NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
           CREATE acProc_fil.
           ASSIGN
               acProc_fil.type     = "11"
               acProc_fil.typdesc  = "Process PREW-File(Direct Pol.)"
               acProc_fil.asdat    = n_asdat
               acProc_fil.trndatfr = fr_trndat
               acProc_fil.trndatto = to_trndat
               acProc_fil.entdat   = TODAY
               acProc_fil.enttim   = STRING(TIME, "HH:MM:SS") + ":NO"
               acProc_fil.usrid    = n_user.
    END.
    IF AVAIL acProc_fil THEN DO:
       ASSIGN
           acProc_fil.type     = "11"
           acProc_fil.typdesc  = "Process PREW-File(Direct Pol.)"
           acProc_fil.asdat    = n_asdat
           acProc_fil.trndatfr = fr_trndat
           acProc_fil.trndatto = to_trndat
           acProc_fil.entdat   = TODAY
           acProc_fil.enttim   = STRING(TIME, "HH:MM:SS") + ":NO"
           acProc_fil.usrid    = n_user.
    END.                       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessYes C-Win 
PROCEDURE pdProcessYes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND LAST acProc_fil  USE-INDEX by_type_asdat  WHERE
          acProc_fil.asdat = n_asdat  AND
          acProc_fil.type  = nv_type  NO-ERROR.
   
IF AVAIL acProc_fil THEN 
   ASSIGN SUBSTR(acProc_fil.enttim,10,3)  = "YES".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdReport_H C-Win 
PROCEDURE pdReport_H :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/**************  Report & Table HEADER  ***************/
ASSIGN nv_output = "C:\Temp\Treaty.txt".
OUTPUT TO VALUE (nv_output) NO-ECHO.
EXPORT DELIMITER ";" 
  "*--Total Treaty Policy by Line--*" ";".
EXPORT DELIMITER ";"
  "Trans.Date From: " fr_trndat  "to: " to_trndat.
EXPORT DELIMITER ";".
EXPORT DELIMITER ";"
     "LINE" "SUM INSURED" 
     "RETENTION" 
     "QBAHT" 
     "1ST" 
     "2ND" 
     "TFP" 
     "FO1" 
     "FO2" 
     "FO3" 
     "FO4" 
     "Q/S" 
     "MPS" 
     "BTR" 
     "OTR" 
     "FTR" 
     "S8"  .

OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcessPol C-Win 
PROCEDURE ProcessPol :
/*------------------------------------------------------------------------------
  Purpose:    Process for Policy 
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN pdCrt11.  /*Create acproc_fil.type = "11"*/

ASSIGN n_prodat = STRING(YEAR(to_trndat)) + STRING(MONTH(to_trndat),"99").   /*-YYYYMM = ทุกสิ้นเดือน-*/

  FOR EACH UCREIN USE-INDEX UCREIN01 WHERE SUBSTR(UCREIN.POINT,1,6) = n_prodat.
      DELETE UCREIN.
  END.

  FIND FIRST xmm024 NO-LOCK NO-ERROR.
 
  FOR EACH uwm100 USE-INDEX uwm10008 WHERE
           uwm100.trndat >= fr_trndat AND
           uwm100.trndat <= to_trndat AND
           uwm100.releas  = YES       AND
          (uwm100.dir_ri  = YES       OR 
           uwm100.dir_ri  = NO)       AND 
          /*--- A500178 ---
           SUBSTR(uwm100.policy,2,1) >= n_bran AND 
           SUBSTR(uwm100.policy,2,1) <= n_brto 
           ------*/
           uwm100.branch >= n_bran AND
           uwm100.branch <= n_brto
         /*--- A500178 ---*/
  NO-LOCK 
     
  BREAK BY uwm100.trndat
        BY uwm100.poltyp
        BY uwm100.policy:
        
        IF uwm100.endcnt = 000 THEN typ = "pol".
        ELSE IF uwm100.endcnt > 000 THEN typ = "end".

      IF SUBSTR(uwm100.policy,3,2) = "70" OR
         SUBSTR(uwm100.policy,3,2) = "72" OR 
         SUBSTR(uwm100.policy,3,2) = "73" or
         SUBSTR(uwm100.policy,3,2) = "74" THEN NEXT.
  
      FOR EACH uwm200 USE-INDEX uwm20001    WHERE     
               uwm200.policy >= uwm100.policy AND 
               uwm200.policy <= uwm100.policy AND
               uwm200.rencnt  = uwm100.rencnt AND
               uwm200.endcnt  = uwm100.endcnt AND
               uwm200.csftq  <> "C"       NO-LOCK   
      BREAK BY uwm200.policy 
            BY uwm200.csftq:

      DISPLAY uwm100.trndat uwm100.policy SUBSTR(uwm100.policy,3,2) uwm100.branch /*--- SUBSTR(uwm100.policy,2,1) --- A500178 ---*/
      WITH COLOR blue/withe NO-LABEL 
      TITLE "Process Data..For PREW-File" WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
      PAUSE 0.
      
            FOR EACH uwd200 USE-INDEX uwd20001 WHERE 
                     uwd200.policy = uwm200.policy AND
                     uwd200.rencnt = uwm200.rencnt AND
                     uwd200.endcnt = uwm200.endcnt AND
                     uwd200.csftq  = uwm200.csftq  AND
                     uwd200.rico   = uwm200.rico   AND
                     uwd200.c_enct = uwm200.c_enct NO-LOCK 
            BREAK BY uwd200.rico.
                
                  IF uwm100.endcnt = 000 THEN    /* For Policy */
                      ASSIGN typ    = "pol"
                             n_type = "Prmp".
                   ELSE IF uwm100.endcnt > 000 THEN   /* For Endorse */
                      ASSIGN typ    = "end"
                             n_type = "Prme".

            /*--- index = ucrein.point = 200612Prmp0df04 ----- for Pol.
                  index = ucrein.point = 200612Prme0df04 ----- for End. ---*/
                  ASSIGN n_point  = n_prodat + n_type + uwd200.rico  /*200612Prmp0dfo4*/
                         n_line   = SUBSTR(uwd200.policy,3,2)        /* Line  */
                         n_uwyr   = SUBSTR(uwd200.policy,5,2)        /* 49,48,.. */
                         n_rico   = uwd200.rico.                     /* 0dfo4 */

                  /*--- Find VAT ---*/
                  IF uwm100.poltyp  = "M31"    OR 
                     uwm100.poltyp  = "C90"    OR 
                     uwm100.poltyp  = "C90C"   OR 
                     uwm100.poltyp  = "C90Q"   OR 
                     uwm100.poltyp  = "C92"    THEN  ASSIGN nv_gstrat = uwm100.gstrat.
                  ELSE ASSIGN nv_gstrat = 0.

                  n_vat = STRING (nv_gstrat).
                  /*--- End VAT ---*/

                  n_poltyp = INT(n_line + n_vat).   /*---VAT 0% ="100" or VAT 7% ="107"---*/ 


                  FIND FIRST uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwd200.policy
                        AND  uwm120.rencnt = uwd200.rencnt
                        AND  uwm120.endcnt = uwd200.endcnt
                        AND  uwm120.riskgp = uwd200.riskgp
                        AND  uwm120.riskno = uwd200.riskno NO-LOCK NO-ERROR.
                 IF NOT AVAIL uwm120 THEN DO:
                     DISPLAY "  uwd120 invalid ".
                     PAUSE 0.
                 END.
                 

                 FIND FIRST ucrein USE-INDEX ucrein01 WHERE ucrein.point  = n_point  AND
                                   ucrein.endcnt = n_poltyp AND 
                                   ucrein.cedref = n_uwyr   NO-ERROR.
                 IF NOT AVAIL ucrein THEN DO:
                    CREATE ucrein.
                    ASSIGN ucrein.point  = n_point             /* ประเภทสัญญา   */
                           ucrein.endcnt = INT(n_poltyp)       /* Policy Type   */
                           ucrein.cedref = n_uwyr              /* underwrt year */
                           ucrein.recprl = n_vat
                           ucrein.cedpol = n_rico             /* ชื่อสัญญา     */
                           ucrein.cedsi  = ucrein.cedsi + uwd200.ripr
                           ucrein.cedces = typ.               /* Pol. or End.  */
                  END.
                  ELSE DO:
                          ucrein.cedsi  = ucrein.cedsi + uwd200.ripr.
                  END.

            END. /* each uwd200 */


            IF FIRST-OF (uwm200.policy) THEN DO:  
                /*--- for Prem. รวมทุกสัญญา ---*/
                FIND FIRST ucrein USE-INDEX ucrein01 WHERE 
                    SUBSTR(ucrein.point,7,9) = "TotalPrem" AND 
                           ucrein.endcnt = n_poltyp  AND 
                           ucrein.cedref = n_uwyr    AND 
                           ucrein.cedces = typ       NO-ERROR.
                IF NOT AVAIL ucrein THEN DO:
                  CREATE ucrein.
                  ASSIGN ucrein.point  = n_prodat + n_type + "Total"
                         ucrein.endcnt = n_poltyp 
                         ucrein.cedref = n_uwyr
                         ucrein.recprl = ""
                         ucrein.cedpol = "TotalPrem"
                         ucrein.cedces = typ.
                END.
                ASSIGN ucrein.cedsi = ucrein.cedsi + uwm100.prem_t.
            END. /* first-of */

            /*--- Clear Value ---*/
            ASSIGN n_vat    = ""
                   n_poltyp = 0.

      END.  /*EACH uwm200*/
  END. /* Each uwm100 */
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

