&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
  File: WACTPFAC.W 
  Description: รายงานทะเบียน OUTWARD FAC  LOCAL/FOREIGN
  Created: By Sayamol 
  Copy From: UZN009.P   (Policy)
             UZN010.P   (Endorse.)                  
------------------------------------------------------------------------*/
CREATE WIDGET-POOL.

DEF VAR n_proc    AS INT.
DEF VAR n_report  AS CHAR FORMAT "X(2)".
DEF VAR n_type    AS CHAR FORMAT "X(03)" init "C90".
DEF VAR n_type_to AS CHAR FORMAT "X(03)" init "M85".
DEF VAR nv_dir2   AS LOGI FORMAT "D/R" INIT "D".
DEF VAR n_date_fr AS DATE FORMAT "99/99/9999".
DEF VAR n_date_to AS DATE FORMAT "99/99/9999".
DEF VAR n_rel     AS CHAR FORMAT "X(1)".
DEF VAR n_bran    AS CHAR FORMAT "X(02)" init "0".
DEF VAR n_bran_to AS CHAR FORMAT "X(02)" init "Z".    
DEF VAR n_apppol  AS CHAR  FORMAT "X".
DEF VAR n_write   AS CHAR  FORMAT "X(8)".
DEF VAR n_write1  AS CHAR  FORMAT "X(12)".
DEF VAR n_write2  AS CHAR  FORMAT "X(12)".
DEF VAR nv_output AS CHAR  FORMAT "X(12)".
DEF VAR nv_output2 AS CHAR  FORMAT "X(12)".
DEF VAR nv_datetop AS CHAR FORMAT "x(50)".
DEF VAR nv_mbsi  LIKE  uwm100.sigr_p.
DEF VAR n_no1  AS CHAR  FORMAT  "x(7)".
DEF VAR nv_sum     AS DEC FORMAT ">>>>>>>>>>>9.99-" INIT 0.
DEF VAR nvprint     AS LOG.
DEF VAR n_net       AS DECI.
/*DEF VAR w_name      LIKE xmm101.name INITIAL[""].*/
DEF VAR n_cnt       AS INT.
DEF VAR n_cnt1      AS INT.
DEF VAR n_cnt2      AS INT.
DEF VAR w_etime     AS CHAR.
DEF VAR w_dtime     AS CHAR.
DEF VAR n_etime     AS INT.
DEF VAR n_dtime     AS INT.

DEF VAR n_altno     AS CHAR  FORMAT "x(13)".
DEF VAR n_appno     AS CHAR  FORMAT "x(13)".
DEF VAR n_year      AS CHAR  FORMAT "x(4)".
DEF VAR n_no        AS CHAR  FORMAT "x(7)".

DEF VAR nv_exch     LIKE uwm120.siexch.
DEF VAR n_0d        AS   LOGIC.
DEF VAR n_0f        AS   LOGIC.
DEF VAR n_acccod    LIKE xmm600.acccod.

DEF VAR n_insur     AS CHAR FORMAT "X(50)".
DEF VAR n_insur2    AS CHAR FORMAT "X(50)".
DEF VAR nv_rett     AS INT  FORMAT "999".
DEF VAR nv_code     LIKE   uwm120.sicurr.
DEF VAR n_riskgp    LIKE   uwd120.riskgp.

DEF VAR n_branch    LIKE uwm100.branch.
DEF VAR n_bdes      LIKE xmm023.bdes.
DEF VAR n_dir       LIKE uwm100.dir_ri.

/** 0D **/
DEF VAR nv_0d_si    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0d_pr    AS  DEC  FORMAT  ">>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0d_cm    AS  DEC  FORMAT  ">>>>>>>>>9.99-" INIT  0.
                                     
DEF VAR nv_lto_si   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.  /* Line */
DEF VAR nv_lto_pr   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_lto_cm   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
                    
DEF VAR nv_bto_si   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0. /* Branch */
DEF VAR nv_bto_pr   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_bto_cm   AS  DEC   FORMAT ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR nv_gto_si   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0. /* Grand Total */
DEF VAR nv_gto_pr   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_gto_cm   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

/** 0F **/
DEF VAR nv_0f_si      AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0f_pr      AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_0f_cm      AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_0f_sibht   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0f_40      AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.

DEF VAR nv_0a_si      AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0a_pr      AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_0a_cm      AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_0a_sibht   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0a_40      AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR nv_0b_si      AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0b_pr      AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
def VAR nv_0b_cm      AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_0b_sibht   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_0b_40      AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR nv_t0f_pr     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_t0f_si     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_t0f_cm     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_t0f_sibht  AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_t0f_40     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR nv_b0a_si     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_b0a_pr     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_b0a_cm     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_b0a_sibht  AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_b0a_40     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR nv_b0b_si     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_b0b_pr     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_b0b_cm     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_b0b_sibht  AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_b0b_40     AS   DEC FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR nv_bt0f_pr    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_bt0f_si    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_bt0f_cm    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_bt0f_sibht AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_bt0f_40    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR nv_g0a_si     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.  
DEF VAR nv_g0a_pr     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0. 
DEF VAR nv_g0a_cm     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.  
DEF VAR nv_g0a_sibht  AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0. 
DEF VAR nv_g0a_40     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.  

DEF VAR nv_g0b_si     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_g0b_pr     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_g0b_cm     AS  DEC  FORMAT  ">>>>>>>>>9.99-"   INIT  0.
DEF VAR nv_g0b_sibht  AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_g0b_40     AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
                                                            
DEF VAR nv_gt0f_pr    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_gt0f_si    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_gt0f_cm    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_gt0f_sibht AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR nv_gt0f_40    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR n_pol_type    AS  CHAR.

DEF BUFFER buwm120    FOR uwm120.
DEF BUFFER buwm200    FOR uwm200.
DEF BUFFER buwm307    FOR uwm307.
DEF BUFFER BUWD200    FOR UWD200.

DEF VAR  nv_tot_pr    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-".
DEF VAR  nv_tot_si    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-".
DEF VAR  nv_tot_cm    AS  DEC  FORMAT  ">>>>>>>>>>>9.99-".

DEF VAR  nvexch       LIKE uwm120.siexch.
DEF VAR  n_endcnt     LIKE uwm100.endcnt.

DEF VAR  s_recid      AS  RECID NO-UNDO.

DEF VAR  nv_ltot_si   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.  
DEF VAR  nv_ltot_pr   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR  nv_ltot_cm   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
                      
DEF VAR  nv_btot_si   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0. 
DEF VAR  nv_btot_pr   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR  nv_btot_cm   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
                      
DEF VAR  nv_gtot_si   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR  nv_gtot_pr   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.
DEF VAR  nv_gtot_cm   AS  DEC  FORMAT  ">>>>>>>>>>>9.99-" INIT  0.

DEF VAR  wrk_si       AS  DEC  FORMAT  ">>>>>>>>>>>>9.99-" INIT  0.
DEF VAR  Bwrk_si      AS  DEC  FORMAT  ">>>>>>>>>>>>9.99-" INIT  0.
DEF VAR  wrk2_si      AS  DEC  FORMAT  ">>>>>>>>>>>>9.99-" INIT  0.
DEF VAR  Bwrk2_si     AS  DEC  FORMAT  ">>>>>>>>>>>>9.99-" INIT  0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_proctyp fi_poltyp fi_poltyp_to fi_dir ~
fi_datfr fi_datto fi_brfr fi_brto fi_output czjovtwiBu_ok Bu_Cancel ~
IMAGE-24 RECT-303 RECT-304 RECT-305 
&Scoped-Define DISPLAYED-OBJECTS fi_proctyp fi_poltyp fi_poltyp_to fi_dir ~
fi_datfr fi_datto fi_brfr fi_brto fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Bu_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE BUTTON czjovtwiBu_ok AUTO-END-KEY 
     LABEL "OK" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE VARIABLE fi_brfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brto AS CHARACTER FORMAT "X(7)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.33 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_datto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dir AS LOGICAL FORMAT "D/I":U INITIAL NO 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 29.67 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp_to AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_proctyp AS INTEGER FORMAT "9":U INITIAL 2 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .95
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-24
     FILENAME "WIMAGE\bgc01":U
     SIZE 88.5 BY 17.14.

DEFINE RECTANGLE RECT-303
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 84.5 BY 14.29
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-304
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 81 BY 2.38.

DEFINE RECTANGLE RECT-305
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 84 BY .24.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_proctyp AT ROW 3.19 COL 33 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 4.57 COL 32.83 COLON-ALIGNED NO-LABEL
     fi_poltyp_to AT ROW 4.57 COL 63.67 COLON-ALIGNED NO-LABEL
     fi_dir AT ROW 6.05 COL 33 COLON-ALIGNED NO-LABEL
     fi_datfr AT ROW 7.48 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_datto AT ROW 7.43 COL 63.83 COLON-ALIGNED NO-LABEL
     fi_brfr AT ROW 9.1 COL 27.17 COLON-ALIGNED NO-LABEL
     fi_brto AT ROW 9.19 COL 64 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 10.62 COL 26.83 COLON-ALIGNED NO-LABEL
     czjovtwiBu_ok AT ROW 16.05 COL 28
     Bu_Cancel AT ROW 16.1 COL 49.5
     IMAGE-24 AT ROW 1 COL 1
     RECT-303 AT ROW 1.48 COL 3
     RECT-304 AT ROW 12.91 COL 5
     RECT-305 AT ROW 12.43 COL 3.33
     "                        รายงานทะเบียน OUTWARD FAC   Local/Foreign" VIEW-AS TEXT
          SIZE 83.83 BY .95 AT ROW 1.95 COL 3.5
          BGCOLOR 1 FGCOLOR 15 FONT 36
     "1 = Policy , 2 = Endorse." VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 3.24 COL 41
          BGCOLOR 3 FGCOLOR 4 FONT 6
     "Direct = D , Inward = I  :" VIEW-AS TEXT
          SIZE 23.5 BY 1.19 AT ROW 6 COL 11
          BGCOLOR 3 FONT 6
     "Transaction Date From  :" VIEW-AS TEXT
          SIZE 23.5 BY 1.19 AT ROW 7.48 COL 5
          BGCOLOR 3 FONT 6
     "Transaction Date to  :" VIEW-AS TEXT
          SIZE 21.17 BY 1.19 AT ROW 7.48 COL 44.5
          BGCOLOR 3 FONT 6
     "Release  :  YES" VIEW-AS TEXT
          SIZE 15.5 BY .71 AT ROW 6.24 COL 55.33
          BGCOLOR 3 FGCOLOR 8 FONT 6
     "Policy Type To  :" VIEW-AS TEXT
          SIZE 17 BY 1.19 AT ROW 4.57 COL 49
          BGCOLOR 3 FONT 6
     "Branch From  :" VIEW-AS TEXT
          SIZE 14 BY 1.19 AT ROW 9.1 COL 14.5
          BGCOLOR 3 FONT 6
     "Branch To  :" VIEW-AS TEXT
          SIZE 11.67 BY 1.19 AT ROW 9.14 COL 53.5
          BGCOLOR 3 FONT 6
     "App  [P]  Outward Policy/Endorse.  Local      =  *POD" VIEW-AS TEXT
          SIZE 51 BY .71 AT ROW 13.38 COL 19.5
          BGCOLOR 3 FGCOLOR 8 FONT 6
     "App  [P]  Outward Policy/Endorse.  Foreign   =  *POF" VIEW-AS TEXT
          SIZE 51 BY .71 AT ROW 14.14 COL 19.5
          BGCOLOR 3 FGCOLOR 8 FONT 6
     "โปรดสังเกต :" VIEW-AS TEXT
          SIZE 12.5 BY 1.19 AT ROW 13.1 COL 7.17
          BGCOLOR 3 FGCOLOR 8 FONT 6
     "Policy Type From  :" VIEW-AS TEXT
          SIZE 18 BY 1.19 AT ROW 4.57 COL 16
          BGCOLOR 3 FONT 6
     "Output To  :" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 10.62 COL 16.5
          BGCOLOR 3 FONT 6
     "PROCESS FOR  :" VIEW-AS TEXT
          SIZE 16.5 BY 1.19 AT ROW 3.14 COL 17.5
          BGCOLOR 3 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.5 BY 17.29
         BGCOLOR 10 .


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
         TITLE              = "รายงานทะเบียน - WACTBLNN.W"
         HEIGHT             = 17.29
         WIDTH              = 88.5
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   Custom                                                               */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* รายงานทะเบียน - WACTBLNN.W */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* รายงานทะเบียน - WACTBLNN.W */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_Cancel C-Win
ON CHOOSE OF Bu_Cancel IN FRAME DEFAULT-FRAME /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME czjovtwiBu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL czjovtwiBu_ok C-Win
ON CHOOSE OF czjovtwiBu_ok IN FRAME DEFAULT-FRAME /* OK */
DO:
    ASSIGN  nv_output  = TRIM(n_write) + "P0D.PRN"
            nv_output2 = TRIM(n_write) + "P0F.PRN".

    IF n_proc = 1  THEN RUN ProcPol.
    ELSE RUN ProcEnd.

    MESSAGE "Process Data Complete!!" VIEW-AS ALERT-BOX INFORMATION.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brfr C-Win
ON LEAVE OF fi_brfr IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_brfr = CAPS (INPUT FRAME {&FRAME-NAME} fi_brfr)
           n_bran  = fi_brfr.

    DISP   fi_brfr WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brto C-Win
ON LEAVE OF fi_brto IN FRAME DEFAULT-FRAME
DO:
  ASSIGN  fi_brto = CAPS (INPUT FRAME {&FRAME-NAME} fi_brto)
          n_bran_to  = fi_brto.

  DISP fi_brto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datfr C-Win
ON LEAVE OF fi_datfr IN FRAME DEFAULT-FRAME
DO:
  ASSIGN fi_datfr = INPUT FRAME {&FRAME-NAME} fi_datfr.

  IF fi_datto = ? THEN fi_datto = fi_datfr.

  IF fi_datfr = ? AND fi_datto = ? THEN 
     MESSAGE "Please, Key In From Date" 
     VIEW-AS ALERT-BOX INFORMATION.

  ASSIGN n_date_fr = INPUT fi_datfr.

  DISP fi_datfr fi_datto WITH FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datto C-Win
ON LEAVE OF fi_datto IN FRAME DEFAULT-FRAME
DO:
  ASSIGN 
     fi_datto = INPUT FRAME {&FRAME-NAME} fi_datto
     n_date_to  = fi_datto.

  IF fi_datto = ?  THEN
     MESSAGE  "Please, Key In To Date"
     VIEW-AS ALERT-BOX INFORMATION.

  IF fi_datto < fi_datfr THEN
     MESSAGE "DATE TO ต้องมากกว่าหรือเท่ากับ DATE FROM"
     VIEW-AS ALERT-BOX INFORMATION.

  DISP fi_datto WITH FRAME {&FRAME-NAME}.

  ASSIGN   nv_datetop = " "
           nv_datetop = "ประจำวันที่ : " + string(n_date_fr,"99/99/9999")
           nv_datetop = nv_datetop + " - " + string(n_date_to,"99/99/9999").

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dir
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dir C-Win
ON LEAVE OF fi_dir IN FRAME DEFAULT-FRAME
DO:
  ASSIGN 
    fi_dir  = INPUT fi_dir
    nv_dir2 = fi_dir.

  IF nv_dir2 = YES THEN n_report = "D".
  ELSE n_report = "I".

  DISP   fi_dir  WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME DEFAULT-FRAME
DO:
  ASSIGN  fi_output = INPUT FRAME {&FRAME-NAME} fi_output.

  IF fi_output <> "" THEN  n_write = CAPS(INPUT fi_output).

  DISP fi_output WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp C-Win
ON LEAVE OF fi_poltyp IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_poltyp = CAPS (INPUT FRAME {&FRAME-NAME} fi_poltyp).
    
    FIND  xmm031  USE-INDEX xmm03101  WHERE xmm031.poltyp = INPUT fi_poltyp
    NO-LOCK NO-ERROR.
       IF NOT AVAILABLE  xmm031  THEN DO:
          BELL.
          MESSAGE "Policy type not on file xmm031.".
          NEXT-PROMPT  fi_poltyp   WITH FRAME {&FRAME-NAME}.
          NEXT.
       END.

       n_type  =  CAPS(INPUT fi_poltyp).
       DISP fi_poltyp WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp_to C-Win
ON LEAVE OF fi_poltyp_to IN FRAME DEFAULT-FRAME
DO:
    ASSIGN fi_poltyp_to = CAPS (INPUT FRAME {&FRAME-NAME} fi_poltyp_to).
    
    FIND  xmm031  USE-INDEX xmm03101  WHERE xmm031.poltyp = INPUT fi_poltyp_to
    NO-LOCK NO-ERROR.
       IF NOT AVAILABLE  xmm031  THEN DO:
          BELL.
          MESSAGE "Policy type not on file xmm031.".
          NEXT-PROMPT  fi_poltyp_to   WITH FRAME {&FRAME-NAME}.
          NEXT.
       END.
        IF INPUT fi_poltyp_to < INPUT fi_poltyp  THEN DO:
            BELL.
            MESSAGE "Policy Type To  must be equal or greater than Policy Type From". PAUSE .
            NEXT-PROMPT  fi_poltyp_to   WITH FRAME {&FRAME-NAME}.
            NEXT.
        END.
       
     ASSIGN n_type_to  = CAPS(INPUT fi_poltyp_to).
     DISP   fi_poltyp_to WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_proctyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_proctyp C-Win
ON LEAVE OF fi_proctyp IN FRAME DEFAULT-FRAME
DO:
  ASSIGN  n_proc = INPUT fi_proctyp.
  DISP    fi_dir  WITH FRAME {&FRAME-NAME}.
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

  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN fi_proctyp   = 1
         fi_poltyp    = "C90"
         fi_poltyp_to = "M85"
         fi_dir       = YES
         fi_datfr     = TODAY
         fi_datto     = TODAY
         fi_brfr      = "0"
         fi_brto      = "Z".

  DISP fi_proctyp fi_poltyp fi_poltyp_to fi_dir fi_datfr fi_datto 
       fi_brfr fi_brto WITH FRAME {&FRAME-NAME}.
  

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
  WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailEnd_D C-Win 
PROCEDURE DetailEnd_D :
/*------------------------------------------------------------------------------
  Purpose:  พิมพ์ Detail งาน Endorse. นปท.   
  Parameters:  <none>
  Notes:  Copy from UZN01001.P     
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    n_altno       
    uwm100.endno  
    n_insur                   
    nv_0d_si      
    nv_0d_pr
    n_appno       
    uwm200.ricomm 
    uwm200.riexp 
    ""
    uwm200.rip1 
    nv_0d_cm.
EXPORT DELIMITER ";"
    ""      uwm100.policy.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailEnd_F C-Win 
PROCEDURE DetailEnd_F :
/*------------------------------------------------------------------------------
  Purpose:  พิมพ์ Detail งาน Endorse. ตปท.   
  Parameters:  <none>
  Notes:  Copy from UZN01001.P        
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    n_altno        
    uwm100.endno   
    n_insur2    
    nv_0f_sibht    
    nv_0f_si       
    nv_0f_pr         
    n_appno        
    uwm200.ricomm  
    uwm200.riexp  
    uwm200.rip1 
    nv_0f_cm       
    nv_0f_40.
EXPORT DELIMITER ";" 
    ""  uwm100.policy.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailPol_D C-Win 
PROCEDURE DetailPol_D :
/*------------------------------------------------------------------------------
  Purpose:  พิมพ์ Detail งาน Policy. นปท.   
  Parameters:  <none>
  Notes:  Copy from UZN00901.P      
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    n_appno        uwm100.policy    n_insur  
    nv_0d_si       nv_0d_pr         
    ""             uwm200.ricomm  uwm200.riexp   
    uwm200.rip1    nv_0d_cm.
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE DetailPol_F C-Win 
PROCEDURE DetailPol_F :
/*------------------------------------------------------------------------------
  Purpose:  พิมพ์ Detail งาน Policy. ตปท.   
  Parameters:  <none>
  Notes:  Copy from UZN00901.P        
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    n_appno         uwm100.policy       n_insur2    
    nv_0f_sibht     nv_0f_si            nv_0f_pr      
    ""              uwm200.ricomm       uwm200.riexp   
    uwm200.rip1     nv_0f_cm            nv_0f_40.
OUTPUT CLOSE.
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
  DISPLAY fi_proctyp fi_poltyp fi_poltyp_to fi_dir fi_datfr fi_datto fi_brfr 
          fi_brto fi_output 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE fi_proctyp fi_poltyp fi_poltyp_to fi_dir fi_datfr fi_datto fi_brfr 
         fi_brto fi_output czjovtwiBu_ok Bu_Cancel IMAGE-24 RECT-303 RECT-304 
         RECT-305 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnColumn_D C-Win 
PROCEDURE prnColumn_D :
/*------------------------------------------------------------------------------
  Purpose: พิมพ์หัว Column งาน Policy นปท.    
  Parameters:  <none>
  Notes:   Copy From UZN00901.P    
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "บริษัทประกันคุ้มภัย จำกัด (มหาชน)" ""  ""  "" "" "" "" 
    "วันที่พิมพ์: " + STRING(TODAY).  
EXPORT DELIMITER ";"
    "สาขา: "  N_BRANCH  n_bdes  ""  ""  
    "สมุดทะเบียนการประกันภัยต่อเฉพาะรายในประเทศ"  "" 
    "RELEASE:  YES".
EXPORT DELIMITER ";"
    "ประกันตรง/ต่อ"     n_report   ""  ""  ""  NV_DATETOP "" "" ""
    "เวลาพิมพ์:" + STRING(n_eTIME,"hh:mm:ss")  "  Program Id.: WACTPFAC ".                          .
EXPORT DELIMITER ";"
    "ประเภท  "   n_pol_type  ""     ""      ""     "กรมธรรม์"  ""   
    "กรมธรรม์ ป.ต.4 (ท.บ.2.1)". 
EXPORT DELIMITER ";" "".
EXPORT DELIMITER ";"
    "เลขที่คำขอ "                   
    "เลขที่กรมธรรม์"                
    "ผู้รับประกันภัยต่อ"            
    "จำนวนเงิน "                    
    "เบี้ยประกันภัยต่อ "            
    "วัน เดือน ปี  "                
    "กรมธรรม์"
    "ประกันภัย"
    "ต่อ "                      
    "อัตราค่าบำเหน็จ "          
    "หมายเหตุ".
EXPORT DELIMITER ";"
    "เอาประกันภัยต่อ"             
    "ประกันภัยเดิม"               
    ""
    "เอาประกันภัยต่อ"             
    "จ่ายเบี้ย"                   
    "เลขที่"                       
    "เริ่มต้น"                     
    "สิ้นสุด "                     
    "หรือส่วนลดการเอาประกันภัยต่อ".
EXPORT DELIMITER ";"
    "" "" "" "" "" 
    "อัตรา"                        
    "จำนวนเงิน".                   
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prnColumn_F C-Win 
PROCEDURE prnColumn_F :
/*------------------------------------------------------------------------------
  Purpose: พิมพ์หัว Column งาน Policy ตปท.    
  Parameters:  <none>
  Notes:   Copy From UZN00901.P        
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "บริษัทประกันคุ้มภัย จำกัด (มหาชน)" ""  ""  "" "" "" "" 
    "วันที่พิมพ์:" + STRING (TODAY).
EXPORT DELIMITER ";"
    "สาขา: "  N_BRANCH  n_bdes  ""  ""  
    "สมุดทะเบียนการประกันภัยต่อเฉพาะรายในประเทศ"  "" 
    "RELEASE:  YES" .
EXPORT DELIMITER ";"
    "ประกันตรง/ต่อ"     n_report   ""  ""  ""  NV_DATETOP "" "" ""
    "เวลาพิมพ์:" + STRING(n_eTIME,"hh:mm:ss")  "  Program Id.: WACTPFAC ".                          .
EXPORT DELIMITER ";"
    "ประเภท  "   n_pol_type  ""     ""      ""     "กรมธรรม์"  ""   
    "กรมธรรม์ ป.ต.4 (ท.บ.2.2)". 
EXPORT DELIMITER ";" "".
EXPORT DELIMITER ";"
    "เลขที่คำขอ "                   
    "เลขที่กรมธรรม์"                
    "ผู้รับประกันภัยต่อ"            
    "จำนวนเงินเอาประกันภัย"         
    "เบี้ยประกันภัยต่อ " 
    ""
    "กรมธรรม์"
    "ประกันภัย"
    "ต่อ "         
    "อัตราค่าบำเหน็จ"               
    "เงินสำรอง".                    
EXPORT DELIMITER ";"
    "เอาประกันภัยต่อ"               
    "ประกันภัยเดิม"                 
    ""
    "กรมธรรม์เดิม"                  
    "กรมธรรม์ต่อ" 
    ""
    "เลขที่"                        
    "เริ่มต้น"                      
    "สิ้นสุด "                      
    "/ส่วนลดประกันภัยต่อ"           
    "เบี้ยประกันภัยต่อ".            
EXPORT DELIMITER ";"
    "" "" "" "" "" ""
    "อัตรา %"                      
    "จำนวนเงิน"     
    ""
    "วัตถุที่เอาประกัน".           
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prn_ECol_D C-Win 
PROCEDURE prn_ECol_D :
/*------------------------------------------------------------------------------
  Purpose: พิมพ์หัว Column งาน Endorse. นปท.    
  Parameters:  <none>
  Notes:   Copy From UZN01001.P      
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "บริษัทประกันคุ้มภัย จำกัด (มหาชน)" ""  ""  "" "" "" "" 
    "วันที่พิมพ์: " + STRING(TODAY).  
EXPORT DELIMITER ";"
    "สาขา: "  N_BRANCH  n_bdes  ""  ""  
    "สมุดทะเบียนการประกันภัยต่อเฉพาะรายในประเทศ"  "" 
    "RELEASE:  YES".
EXPORT DELIMITER ";"
    "ประกันตรง/ต่อ"     n_dir   ""  ""  ""  NV_DATETOP "" "" ""
    "เวลาพิมพ์:" + STRING(n_eTIME,"hh:mm:ss")  "  Program Id.: WACTPFAC ".                          .
EXPORT DELIMITER ";"
    "ประเภท  "   n_pol_type  ""     ""      ""     "สลักหลัง"  ""   
    "สลักหลัง ป.ต.4 (ท.บ.2.1)". 
EXPORT DELIMITER ";" "".
EXPORT DELIMITER ";"
    "เลขที่ใบแจ้ง"                   
    "เลขที่สลักหลัง"                
    "ผู้รับประกันภัยต่อ"            
    "จำนวนเงิน "                    
    "เบี้ยประกันภัยต่อ "            
    "วัน เดือน ปี  "                
    "กรมธรรม์"
    "ประกันภัย"
    "ต่อ "                      
    "อัตราค่าบำเหน็จ "          
    "หมายเหตุ".
EXPORT DELIMITER ";"
    "เปลี่ยนแปลง" 
    "เลขที่กรมธรรม์"
    ""
    "เอาประกันภัยต่อ"           
    "จ่ายเบี้ย"                   
    "เลขที่"                       
    "เริ่มต้น"                     
    "สิ้นสุด "                     
    "หรือส่วนลดการเอาประกันภัยต่อ".
EXPORT DELIMITER ";"
    "เอาประกันภัยต่อ"
    "ประกันภัยเดิม"  
    "" "" "" ""  
    "อัตรา"                        
    "จำนวนเงิน".                   
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE prn_ECol_F C-Win 
PROCEDURE prn_ECol_F :
/*------------------------------------------------------------------------------
  Purpose: พิมพ์หัว Column งาน Endorse. ตปท.    
  Parameters:  <none>
  Notes:   Copy From UZN01001.P        
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "บริษัทประกันคุ้มภัย จำกัด (มหาชน)" ""  ""  "" "" "" "" 
    "วันที่พิมพ์:" + STRING (TODAY).
EXPORT DELIMITER ";"
    "สาขา: "  N_BRANCH  n_bdes  ""  ""  
    "สมุดทะเบียนการประกันภัยต่อเฉพาะรายในประเทศ"  "" 
    "RELEASE:  YES" .
EXPORT DELIMITER ";"
    "ประกันตรง/ต่อ"     n_dir   ""  ""  ""  NV_DATETOP "" "" ""
    "เวลาพิมพ์:" + STRING(n_eTIME,"hh:mm:ss")  "  Program Id.: WACTPFAC ".                          .
EXPORT DELIMITER ";"
    "ประเภท  "   n_pol_type  ""     ""      ""     "สลักหลัง"  ""   
    "สลักหลัง (ท.บ.2.2)". 
EXPORT DELIMITER ";" "".
EXPORT DELIMITER ";"
    "เลขที่ใบแจ้ง"                   
    "เลขที่สลักหลัง"                
    "ผู้รับประกันภัยต่อ"            
    "จำนวนเงินเอาประกันภัย" 
    ""
    "เบี้ยประกันภัยต่อ " 
    "กรมธรรม์"
    "ประกันภัย"
    "ต่อ "         
    "อัตราค่าบำเหน็จ"               
    "เงินสำรอง".                    
EXPORT DELIMITER ";"
    "เปลี่ยนแปลง"    
    "เลขที่กรมธรรม์" 
    ""
    "กรมธรรม์เดิม"
    "กรมธรรม์ต่อ"
    ""
    "เลขที่"                        
    "เริ่มต้น"                      
    "สิ้นสุด "                      
    "/ส่วนลดประกันภัยต่อ"           
    "เบี้ยประกันภัยต่อ".            
EXPORT DELIMITER ";"
    "เอาประกันภัยต่อ" 
    "ประกันภัยเดิม"   
    "" "" "" "" "" "" "" 
    "อัตรา %"                      
    "จำนวนเงิน"  
    "วัตถุที่เอาประกัน".           
OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcEnd C-Win 
PROCEDURE ProcEnd :
/*------------------------------------------------------------------------------
  Purpose:   Process Outward FAC Endose. งานนปท. และตปท.  
  Parameters:  <none>
  Notes:    Copy From UZN01001.p   
------------------------------------------------------------------------------*/
ASSIGN  nv_output  = TRIM(n_write) + "EFD.PRN"
        nv_output2 = TRIM(n_write) + "EFF.PRN".

ASSIGN  n_cnt   = 0
        n_cnt1  = 0
        n_cnt2  = 0
        n_etime = time.

FIND FIRST xmm024 NO-LOCK NO-ERROR.

FOR EACH uwm100 USE-INDEX uwm10008 NO-LOCK WHERE
         uwm100.trndat >= n_date_fr  AND 
         uwm100.trndat <= n_date_to  AND 
         uwm100.poltyp >= n_type     AND
         uwm100.poltyp <= n_type_to  AND 
         uwm100.branch >= n_bran     AND 
         uwm100.branch <= n_bran_to  AND 
         uwm100.endcnt <> 0          AND 
         uwm100.dir_ri  = nv_dir2    AND 
         uwm100.RELEAS  = YES 
BREAK BY uwm100.branch  
      BY uwm100.poltyp 
      BY uwm100.policy:

    IF FIRST-OF (Uwm100.branch) THEN DO:
       FIND FIRST xmm023 USE-INDEX xmm02301 WHERE 
                  xmm023.branch = uwm100.branch NO-LOCK NO-ERROR.
            ASSIGN  n_branch = uwm100.branch
                    n_bdes   = xmm023.bdes
                    n_dir    = uwm100.dir_ri.
            RUN prn_ECol_D.   /*---- พิมพ์หัว Column นปท. ----*/
            RUN prn_ECol_F.   /*---- พิมพ์หัว Column ตปท. ----*/

    END. /* FIRST-OF (Uwm100.branch) */

    IF FIRST-OF (uwm100.poltyp) THEN DO:
       FIND FIRST Xmm031 WHERE Xmm031.poltyp = Uwm100.poltyp NO-LOCK NO-ERROR.
            n_pol_type = IF AVAIL Xmm031 THEN Xmm031.poltyp + " " + Xmm031.poldes
                         ELSE Uwm100.poltyp.

            ASSIGN  nv_tot_si       = 0        nv_tot_pr   = 0      
                    nv_tot_cm       = 0
                                    
                    nv_0a_sibht     = 0        nv_0a_si    = 0
                    nv_0a_pr        = 0        nv_0a_cm    = 0     
                    nv_0a_40        = 0
                                    
                    nv_0b_sibht     = 0        nv_0b_si    = 0
                    nv_0b_pr        = 0        nv_0b_cm    = 0     
                    nv_0b_40        = 0
                                    
                    nv_t0f_sibht    = 0        nv_t0f_si   = 0
                    nv_t0f_pr       = 0        nv_t0f_cm   = 0     
                    nv_t0f_40       = 0.
    END. /*--- FIRST-OF (Uwm100.poltyp) ---*/

    FOR EACH uwm200  USE-INDEX uwm20001      WHERE
             UWM200.POLICY = UWM100.POLICY     AND
             UWM200.RENCNT = UWM100.RENCNT     AND
             UWM200.ENDCNT = UWM100.ENDCNT     AND
             uwm200.csftq  =  "F"              AND
            (SUBSTR(uwm200.rico,1,2) = "0D"    OR
             SUBSTR(uwm200.rico,1,2) = "0F")   NO-LOCK.
    
        n_cnt = n_cnt + 1.
        PAUSE 0.
    
    DISP  uwm100.policy  n_cnt  n_cnt1  
    WITH COLOR blue/withe NO-LABEL 
    TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
    PAUSE 0.
    
    ASSIGN  n_insur  = ""
            n_insur2 = ""
            n_acccod = "".
    
    FIND Xmm600 WHERE Xmm600.acno = Uwm200.rico NO-LOCK NO-ERROR.
    IF NOT AVAILABLE Xmm600 THEN  DO:
       ASSIGN  n_insur  = "       NOT FOUND " + Uwm200.rico
               n_insur2 = "       NOT FOUND " + Uwm200.rico.
    END.
    ELSE DO: 
       ASSIGN  n_insur  = xmm600.name
               n_acccod = xmm600.acccod
               n_insur2 = "(" + n_acccod + ") " + Xmm600.name.
    END.

    ASSIGN n_appno = " "
           n_no    = STRING(uwm200.c_no,"9999999")
           n_altno = " "                          
           n_no1   = STRING(uwm200.c_enno,"9999999")
           n_year  = STRING(uwm200.c_year,"9999")
           n_appno = SUBSTR(uwm200.policy,1,4) + SUBSTR(n_year,3,2) + n_no
           n_altno = SUBSTR(uwm200.policy,1,4) + SUBSTR(n_year,3,2) + n_no1
           s_recid = RECID(uwm200).

    IF SUBSTR(uwm200.rico,1,2) = "0D" THEN DO:
       IF UWM100.TRANTY <> "C" THEN DO:
          RUN Proc_NCan.
       END.
       ELSE DO:
          RUN Proc_Can.    
       END.

       ASSIGN   nv_0d_pr   = nv_0d_pr * (-1) 
                nv_0d_cm   = nv_0d_cm * (-1) 
                n_cnt1     = n_cnt1 + 1.   

       RUN DetailEnd_D.  /*--- พิมพ์ Detail นปท. ---*/

       ASSIGN   nv_tot_si = nv_tot_si + nv_0d_si
                nv_tot_pr = nv_tot_pr + nv_0d_pr
                nv_tot_cm = nv_tot_cm + nv_0d_cm
       
                nv_0d_si  = 0
                nv_0d_pr  = 0
                nv_0d_cm  = 0.
                  
    END. /* IF 0D */
    ELSE IF SUBSTR(uwm200.rico,1,2) = "0F" THEN DO:
       FIND FIRST uwm120 USE-INDEX uwm12001 WHERE 
                  uwm120.policy = uwm200.policy AND
                  uwm120.rencnt = uwm200.rencnt AND
                  uwm120.endcnt = uwm200.endcnt NO-LOCK NO-ERROR.
       IF AVAIL uwm120 THEN DO:
          IF SUBSTRI(uwm120.policy,3,2) <> "90" THEN nvexch = uwm120.siexch.
          ELSE nvexch  =   1.
       END.
       
       n_endcnt = uwm100.endcnt - 1.

       IF UWM100.TRANTY  = "C" THEN DO:
          RUN Proc_ENCan.
       END.
       ELSE DO:
          RUN Proc_ECan.
       END.
 
       ASSIGN   nv_sum  = nv_sum * nvexch
                s_recid = RECID(uwm200).
       
       IF UWM100.TRANTY <> "C" THEN DO:
          RUN Proc_NCan2.
       END.
       ELSE DO:
          RUN Proc_Can2.
       END.

       IF SUBSTR(Uwm200.policy,3,2)  <>  "90"  THEN DO:
          ASSIGN  nv_0f_40   =  nv_0f_pr * (0.4)
                  nv_0f_40   =  TRUNC(nv_0f_40,0).
       END.
       ELSE DO:
          nv_0f_40   =  0.
       END.
  
       ASSIGN   nv_0f_sibht = ROUND(nv_sum, 2)
                nv_0f_pr    = nv_0f_pr  * -1
                nv_0f_cm    = nv_0f_cm  * -1
           
                n_cnt2 = n_cnt2 + 1.
       
       RUN DetailEnd_F.       /*--- พิมพ์ Detail ตปท. ---*/

       IF n_acccod = "RA" THEN  DO:
          ASSIGN  nv_0a_si    = nv_0a_si     + nv_0f_si
                  nv_0a_pr    = nv_0a_pr     + nv_0f_pr
                  nv_0a_cm    = nv_0a_cm     + nv_0f_cm
                  nv_0a_40    = nv_0a_40     + nv_0f_40.
                  nv_0a_sibht = nv_0a_sibht  + nv_0f_sibht.
          END.
          ELSE DO:
            ASSIGN  nv_0b_si    = nv_0b_si     + nv_0f_si
                    nv_0b_pr    = nv_0b_pr     + nv_0f_pr
                    nv_0b_cm    = nv_0b_cm     + nv_0f_cm
                    nv_0b_40    =  nv_0b_40    + nv_0f_40
                    nv_0b_sibht =  nv_0b_sibht + nv_0f_sibht.
          END.
  
          ASSIGN  nv_t0f_si    = nv_t0f_si    + nv_0f_si
                  nv_t0f_pr    = nv_t0f_pr    + nv_0f_pr
                  nv_t0f_cm    = nv_t0f_cm    + nv_0f_cm
                  nv_t0f_sibht = nv_t0f_sibht + nv_0f_sibht
                  nv_t0f_40    = nv_t0f_40    + nv_0f_40.

          ASSIGN  nv_sum       =  0         nv_0f_si     =  0
                  nv_0f_pr     =  0         nv_0f_cm     =  0
                  nv_0f_40     =  0         nv_0f_sibht  =  0.
    END. /* 0F */
  END. /* UWM200*/ 

  IF LAST-OF (Uwm100.poltyp) THEN  DO:   /*sum by Line*/
     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
        ""  "รวม Policy Type : " + Uwm100.poltyp
        ""  nv_tot_si   nv_tot_pr
        ""  ""  ""  ""  ""  nv_tot_cm.
     EXPORT DELIMITER ";" "".
     OUTPUT CLOSE.

     /* Summary to Branch */
     ASSIGN   nv_btot_si = nv_btot_si + nv_tot_si
              nv_btot_pr = nv_btot_pr + nv_tot_pr 
              nv_btot_cm = nv_btot_cm + nv_tot_cm
               
              nv_tot_si = 0     nv_tot_pr = 0      nv_tot_cm = 0. 

     OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
         "" "ยอดรวม Policy Type : " +  Uwm100.poltyp.
     EXPORT DELIMITER ";"
         "" ""  "ยอดรวมอาเซียน......" ""
         nv_0a_sibht 
         nv_0a_si
         nv_0a_pr  
         "" "" "" ""
         nv_0a_cm   
         nv_0a_40. 
     EXPORT DELIMITER ";"
         "" "" "ยอดรวมต่างประเทศ...." ""
         nv_0b_sibht  
         nv_0b_si     
         nv_0b_pr 
         "" "" "" ""
         nv_0b_cm     
         nv_0b_40.
     EXPORT DELIMITER ";"
         "" "" "ยอดรวมทั้งสิ้น......." ""
         nv_t0f_sibht 
         nv_t0f_si    
         nv_t0f_pr  
         "" "" "" ""
         nv_t0f_cm    
         nv_t0f_40.
     EXPORT DELIMITER ";" "".
     OUTPUT CLOSE.

     /* Summary to Branch */
     ASSIGN  nv_b0a_si     = nv_b0a_si     + nv_0a_si
             nv_b0a_pr     = nv_b0a_pr     + nv_0a_pr
             nv_b0a_cm     = nv_b0a_cm     + nv_0a_cm
             nv_b0a_40     = nv_b0a_40     + nv_0a_40
             nv_b0a_sibht  = nv_b0a_sibht  + nv_0a_sibht

             nv_b0b_si     = nv_b0b_si     + nv_0b_si
             nv_b0b_pr     = nv_b0b_pr     + nv_0b_pr
             nv_b0b_cm     = nv_b0b_cm     + nv_0b_cm
             nv_b0b_40     = nv_b0b_40     + nv_0b_40
             nv_b0b_sibht  = nv_b0b_sibht  + nv_0b_sibht

             nv_bt0f_si    = nv_bt0f_si    + nv_t0f_si
             nv_bt0f_pr    = nv_bt0f_pr    + nv_t0f_pr
             nv_bt0f_cm    = nv_bt0f_cm    + nv_t0f_cm
             nv_bt0f_sibht = nv_bt0f_sibht + nv_t0f_sibht
             nv_bt0f_40    = nv_bt0f_40    + nv_t0f_40
  
             nv_0a_sibht = 0        nv_0a_si    = 0
             nv_0a_pr    = 0        nv_0a_cm    = 0
             nv_0a_40    = 0
    
             nv_0b_sibht = 0        nv_0b_si    = 0
             nv_0b_pr    = 0        nv_0b_cm    = 0
             nv_0b_40    = 0
      
             nv_t0f_sibht= 0        nv_t0f_si   = 0
             nv_t0f_pr   = 0        nv_t0f_cm   = 0
             nv_t0f_40   = 0. 
            
  END. /* LAST-OF (Uwm100.poltyp) */

END. /* UWM100 */
            
ASSIGN  n_dtime  = TIME - n_etime
        n_etime  = TIME
        w_etime  = STRING(n_etime, "HH:MM:SS")
        w_dtime  = STRING(n_dtime, "HH:MM:SS").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcPol C-Win 
PROCEDURE ProcPol :
/*------------------------------------------------------------------------------
  Purpose:   Process Outward FAC Policy. งานนปท. และตปท.  
  Parameters:  <none>
  Notes:    Copy From UZN00901.p        
------------------------------------------------------------------------------*/
    ASSIGN  n_cnt   = 0
            n_cnt1  = 0
            n_cnt2  = 0
            n_etime = TIME.

    FOR EACH uwm100 USE-INDEX uwm10008 NO-LOCK WHERE
             uwm100.trndat >= n_date_fr  AND 
             uwm100.trndat <= n_date_to  AND 
             uwm100.poltyp >= n_type     AND 
             uwm100.poltyp <= n_type_to  AND 
             uwm100.branch >= n_bran     AND 
             uwm100.branch <= n_bran_to  AND 
             uwm100.endcnt  = 000        AND 
             uwm100.dir_ri  = nv_dir2    AND 
             uwm100.releas  = YES
    BREAK BY uwm100.branch BY uwm100.poltyp BY uwm100.policy :
  
    IF FIRST-OF (Uwm100.poltyp) THEN DO:
       FIND FIRST Xmm031 WHERE Xmm031.poltyp = Uwm100.poltyp NO-LOCK NO-ERROR.
       n_pol_type = IF AVAIL Xmm031 THEN Xmm031.poltyp + " " + Xmm031.poldes
                    ELSE Uwm100.poltyp + " Not found!".
    END. /*--- FIRST-OF (Uwm100.poltyp) ---*/

    IF FIRST-OF (Uwm100.branch) THEN DO:
       FIND FIRST Xmm023 USE-INDEX Xmm02301 WHERE Xmm023.branch = Uwm100.branch
       NO-LOCK NO-ERROR.
            ASSIGN n_branch = uwm100.branch
                   n_bdes   = IF AVAIL Xmm023 THEN Xmm023.bdes 
                              ELSE "Not found " + Uwm100.branch
                   n_dir    = Uwm100.dir_ri.
            RUN prnColumn_D.
            RUN prnColumn_F.
    END.  /* FIRST-OF (Uwm100.branch) */

    FOR EACH Uwm200 USE-INDEX Uwm20001    WHERE 
             UWM200.POLICY = UWM100.POLICY  AND     
             UWM200.RENCNT = UWM100.RENCNT  AND   
             UWM200.ENDCNT = UWM100.ENDCNT  AND   
             UWM200.csftq  =  "F"           AND   
            (SUBSTRING (Uwm200.rico,1,2) = "0D"  OR
             SUBSTRING (Uwm200.rico,1,2) = "0F") NO-LOCK:

            n_cnt = n_cnt + 1.
            PAUSE 0.
   
       DISPLAY  Uwm100.policy  n_cnt  n_cnt1  
       WITH COLOR blue/withe NO-LABEL 
       TITLE "Process Data.." WIDTH 60 FRAME amain VIEW-AS DIALOG-BOX.
       PAUSE 0.

            ASSIGN  n_insur  = ""
                    n_acccod = "".

            FIND Xmm600 WHERE Xmm600.acno = Uwm200.rico NO-LOCK NO-ERROR.
            IF NOT AVAILABLE  Xmm600 THEN  DO:
               n_insur = "       NOT FOUND " + uwm200.rico.
            END.
            ELSE DO:
               ASSIGN  n_acccod = xmm600.acccod.
                       n_insur  = "(" + n_acccod + ") " + xmm600.name.
                       n_insur2 = "(" + n_acccod + ") " + xmm600.name.
            END.
    
            FIND FIRST uwd200 USE-INDEX Uwd20001     WHERE 
                       uwd200.policy = uwm200.policy AND
                       uwd200.rencnt = uwm200.rencnt AND
                       uwd200.endcnt = uwm200.endcnt AND
                       uwd200.c_enct = uwm200.c_enct AND
                       uwd200.csftq  = uwm200.csftq  AND
                       uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
         
            IF AVAILABLE uwd200 THEN DO:
               REPEAT WHILE AVAIL uwd200:
                    nv_exch = 1.
                    FIND  Uwm120 USE-INDEX Uwm12001 
                    WHERE Uwm120.policy = Uwm200.policy 
                    AND   Uwm120.rencnt = Uwm200.rencnt 
                    AND   Uwm120.endcnt = Uwm200.endcnt 
                    AND   Uwm120.riskgp = Uwd200.riskgp 
                    AND   Uwm120.riskno = Uwd200.riskno NO-LOCK NO-ERROR.
                    IF AVAILABLE Uwm120 THEN DO:
                       IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nv_exch = 1.
                       ELSE nv_exch = uwm120.siexch.
                    END.

                    IF SUBSTR (uwd200.rico,1,2) = "0D"  THEN DO:
                       ASSIGN 
                          n_0d = Yes.
                          nv_0d_si   = nv_0d_si  + (uwd200.risi * nv_exch).
                          nv_0d_pr   = nv_0d_pr  + (uwd200.ripr * nv_exch).
                          nv_0d_cm   = nv_0d_cm  + (uwd200.ric1 * nv_exch).

                          nv_lto_si  = nv_lto_si + (uwd200.risi * nv_exch).
                          nv_lto_pr  = nv_lto_pr + (uwd200.ripr * nv_exch).
                          nv_lto_cm  = nv_lto_cm + (uwd200.ric1 * nv_exch).
                       END.
                       ELSE IF SUBSTR (uwd200.rico,1,2) = "0F"  THEN DO:
                            n_0f = Yes.

                            IF n_acccod = "RA" THEN DO:
                               ASSIGN
                               nv_0a_si = nv_0a_si + (uwd200.risi * nv_exch)
                               nv_0a_pr = nv_0a_pr + (uwd200.ripr * nv_exch)
                               nv_0a_cm = nv_0a_cm + (uwd200.ric1 * nv_exch).
                            END.
                            ELSE DO:
                               ASSIGN
                               nv_0b_si = nv_0b_si + (uwd200.risi * nv_exch)
                               nv_0b_pr = nv_0b_pr + (uwd200.ripr * nv_exch)
                               nv_0b_cm = nv_0b_cm + (uwd200.ric1 * nv_exch).
                            END.

                            ASSIGN
                            nv_0f_si  = nv_0f_si + (uwd200.risi * nv_exch)
                            nv_0f_pr  = nv_0f_pr + (uwd200.ripr * nv_exch)
                            nv_0f_cm  = nv_0f_cm + (uwd200.ric1 * nv_exch)
                            
                            nv_t0f_si = nv_t0f_si + (uwd200.risi * nv_exch)
                            nv_t0f_pr = nv_t0f_pr + (uwd200.ripr * nv_exch)
                            nv_t0f_cm = nv_t0f_cm + (uwd200.ric1 * nv_exch).
                       END.  /*--- 0F ---*/
        
                       FIND NEXT Uwd200 USE-INDEX Uwd20001     WHERE 
                                 Uwd200.policy = Uwm200.policy AND
                                 Uwd200.rencnt = Uwm200.rencnt AND
                                 Uwd200.endcnt = Uwm200.endcnt AND
                                 Uwd200.c_enct = Uwm200.c_enct AND
                                 Uwd200.csftq  = Uwm200.csftq  AND
                                 Uwd200.rico   = Uwm200.rico   NO-LOCK NO-ERROR.
                       
               END. /* repeat */

               ASSIGN  n_appno = " "
                       n_no    = STRING(uwm200.c_no,"9999999")
                       n_year  = STRING(uwm200.c_year,"9999")
                       n_appno = SUBSTR(uwm200.policy,1,4) + SUBSTR(n_year,3,2) + n_no.

               IF n_0d THEN DO:
                  ASSIGN   n_0d     = No
                           nv_0d_pr = nv_0d_pr * (-1)
                           nv_0d_cm = nv_0d_cm * (-1)
                           n_cnt1   = n_cnt1 + 1.

                  RUN DetailPol_D.   /*--- PRINT 0D นปท.*/

                  ASSIGN   nv_0d_si  = 0
                           nv_0d_pr  = 0
                        nv_0d_cm  = 0.
               END. /* 0d */
      
               IF n_0f THEN DO:
                  ASSIGN n_0f   = NO
                         n_cnt2 = n_cnt2 + 1.
         
               IF SUBSTR(Uwm200.policy,3,2)  <>  "90"  THEN DO:
                  ASSIGN nv_0f_40   =  nv_0f_pr * (0.4)
                         nv_0f_40   =  trunc(nv_0f_40,0).
               END.

               ASSIGN nv_0f_sibht = 0
                      nv_sum = 0.

               RUN ProSI120.

               ASSIGN  nv_0f_sibht = ROUND ((nv_sum) * nv_exch,2)
                       nv_0f_pr    = nv_0f_pr * (-1)
                       nv_0f_cm    = nv_0f_cm * (-1).

               RUN DetailPol_F.      /*--- PRINT 0F ตปท.*/

               IF n_acccod = "RA" THEN DO:
                  ASSIGN  nv_0a_sibht = nv_0a_sibht + nv_0f_sibht
                          nv_0a_40    = nv_0a_40 + nv_0f_40.
               END.
               ELSE DO:
                  ASSIGN nv_0b_sibht  = nv_0b_sibht + nv_0f_sibht
                         nv_0b_40     = nv_0b_40 + nv_0f_40.
               END.
        
               ASSIGN nv_t0f_sibht    = nv_t0f_sibht + nv_0f_sibht
                      nv_t0f_40       = nv_t0f_40 + nv_0f_40
                     
                      nv_0f_si    = 0              nv_0f_pr    = 0
                      nv_0f_cm    = 0              nv_0f_40    = 0
                      nv_0f_sibht = 0.             
               END. /* 0f */
       
        END. /* IF AVAIL UWD200 */ 
    
  END. /*--- FOR EACH UWM200 -------------------------------------------------*/

  IF LAST-OF (Uwm100.poltyp) THEN DO:      /*sum by Line (ns1)*/
     ASSIGN  nv_lto_pr = nv_lto_pr * (-1)
             nv_lto_cm = nv_lto_cm * (-1).

     OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
     EXPORT DELIMITER ";"
            ""      "ยอดรวม Line  " + Uwm100.poltyp     
            ""       nv_lto_si      nv_lto_pr      
            ""      ""      ""      ""
            nv_lto_cm.
     EXPORT DELIMITER ";" "".
     OUTPUT CLOSE.

     /*Summary TO branch */
     ASSIGN   nv_bto_si = nv_bto_si + nv_lto_si
              nv_bto_pr = nv_bto_pr + nv_lto_pr
              nv_bto_cm = nv_bto_cm + nv_lto_cm
              
              nv_lto_si = 0
              nv_lto_pr = 0
              nv_lto_cm = 0

              nv_0a_pr  = nv_0a_pr  * (-1)
              nv_0a_cm  = nv_0a_cm  * (-1)

              nv_0b_pr  = nv_0b_pr  * (-1)
              nv_0b_cm  = nv_0b_cm  * (-1)

              nv_t0f_pr = nv_t0f_pr * (-1)
              nv_t0f_cm = nv_t0f_cm * (-1).

      OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
      EXPORT DELIMITER ";" 
          "ยอดรวม Policy Type : "  Uwm100.poltyp.
      EXPORT DELIMITER ";"
          ""    "ยอดรวมอาเซี่ยน...."  ""
          nv_0a_sibht   
          nv_0a_si      
          nv_0a_pr
          "" "" "" ""
          nv_0a_cm     
          nv_0a_40.
      EXPORT DELIMITER ";"
           ""    "ยอดรวมต่างประเทศ...."  ""       
           nv_0b_sibht  
           nv_0b_si     
           nv_0b_pr  
           "" "" "" ""
           nv_0b_cm     
           nv_0b_40.    
       EXPORT DELIMITER ";"
          ""   "ยอดรวมทั้งสิ้น...."    ""
          nv_t0f_sibht 
          nv_t0f_si    
          nv_t0f_pr 
          "" "" "" ""
          nv_t0f_cm    
          nv_t0f_40.
       EXPORT DELIMITER ";" "".
       OUTPUT CLOSE.
                    
       /* Summary to Branch */
       ASSIGN  nv_b0a_sibht  = nv_b0a_sibht  + nv_0a_sibht
               nv_b0a_si     = nv_b0a_si     + nv_0a_si
               nv_b0a_pr     = nv_b0a_pr     + nv_0a_pr
               nv_b0a_cm     = nv_b0a_cm     + nv_0a_cm
               nv_b0a_40     = nv_b0a_40     + nv_0a_40
                                            
               nv_b0b_sibht  = nv_b0b_sibht  + nv_0b_sibht
               nv_b0b_si     = nv_b0b_si     + nv_0b_si
               nv_b0b_pr     = nv_b0b_pr     + nv_0b_pr
               nv_b0b_cm     = nv_b0b_cm     + nv_0b_cm
               nv_b0b_40     = nv_b0b_40     + nv_0b_40
    
               nv_bt0f_sibht = nv_bt0f_sibht + nv_t0f_sibht
               nv_bt0f_si    = nv_bt0f_si    + nv_t0f_si
               nv_bt0f_pr    = nv_bt0f_pr    + nv_t0f_pr
               nv_bt0f_cm    = nv_bt0f_cm    + nv_t0f_cm
               nv_bt0f_40    = nv_bt0f_40    + nv_t0f_40
             
               nv_0a_sibht  = 0         nv_0a_si     = 0
               nv_0a_pr     = 0         nv_0a_cm     = 0
               nv_0a_40     = 0         

               nv_0b_sibht  = 0         nv_0b_si     = 0
               nv_0b_pr     = 0         nv_0b_cm     = 0
               nv_0b_40     = 0
    
               nv_t0f_sibht = 0         nv_t0f_si    = 0
               nv_t0f_pr    = 0         nv_t0f_cm    = 0
               nv_t0f_40    = 0.
     
       END. /* last-of uwm100.poltyp */

END. /* FOR EACH UWM100 */

ASSIGN    n_dtime  = time - n_etime
          n_etime  = TIME
          w_etime  = STRING(n_etime, "HH:MM:SS")
          w_dtime  = STRING(n_dtime, "HH:MM:SS").

OUTPUT TO VALUE (nv_output) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "End of Report" 
    "End Time "       STRING(n_etime,"HH:MM:SS") 
    "Elapsed Time "  STRING(n_dtime,"HH:MM:SS") 
    "No. of Records Processed "  n_cnt1.
OUTPUT CLOSE.
  
OUTPUT TO VALUE (nv_output2) APPEND NO-ECHO.
EXPORT DELIMITER ";"
    "End of Report" 
    "End Time "      STRING(n_etime,"HH:MM:SS") 
    "Elapsed Time "  STRING(n_dtime,"HH:MM:SS") 
    "No. of Records Processed "    n_cnt2.
OUTPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Can C-Win 
PROCEDURE Proc_Can :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Copy From UZN01003.P     
------------------------------------------------------------------------------*/
FIND FIRST xmm024 NO-LOCK  NO-ERROR.
FIND UWM200 WHERE RECID(UWM200) = s_recid NO-WAIT NO-ERROR.
FIND FIRST uwd200 USE-INDEX uwd20001 WHERE 
           uwd200.policy = uwm200.policy AND
           uwd200.rencnt = uwm200.rencnt AND
           uwd200.endcnt = uwm200.endcnt AND
           uwd200.c_enct = uwm200.c_enct AND
           uwd200.csftq  = uwm200.csftq  AND
           uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
IF NOT AVAIL uwd200 THEN DO:
   DISPLAY  " *** UWD200 INVALID *** ".
END.
ELSE DO:
  REPEAT:
    nvexch = 1.
    FIND FIRST uwm120 USE-INDEX uwm12001    WHERE 
               uwm120.policy = uwd200.policy AND 
               uwm120.rencnt = uwd200.rencnt AND 
               uwm120.endcnt = uwd200.endcnt AND 
               uwm120.riskgp = uwd200.riskgp AND 
               uwm120.riskno = uwd200.riskno NO-LOCK NO-ERROR.
    IF AVAILABLE uwm120 THEN DO:
       IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
       ELSE nvexch = uwm120.siexch.
    END.

    IF SUBSTR(uwd200.rico,1,2) = "0D"  THEN DO:
       ASSIGN  nv_0d_si  = nv_0d_si  + ((uwd200.risi * -1) * nvexch)
               nv_0d_pr  = nv_0d_pr  + (uwd200.ripr        * nvexch)
               nv_0d_cm  = nv_0d_cm  + (uwd200.ric1        * nvexch).
    END.

    FIND NEXT uwd200 USE-INDEX uwd20001    WHERE 
              uwd200.policy = uwm200.policy AND
              uwd200.rencnt = uwm200.rencnt AND
              uwd200.endcnt = uwm200.endcnt AND
              uwd200.c_enct = uwm200.c_enct AND
              uwd200.csftq  = uwm200.csftq  AND
              uwd200.rico   = uwm200.rico  NO-LOCK NO-ERROR.
    IF NOT AVAIL UWD200 THEN  LEAVE.

  END. /* repeat */
END. /* ELSE */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Can2 C-Win 
PROCEDURE Proc_Can2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    Copy From UZN01005.P     
------------------------------------------------------------------------------*/
FIND FIRST  xmm024 NO-LOCK  NO-ERROR.
FIND UWM200 WHERE RECID(UWM200) = s_recid NO-WAIT NO-ERROR.
FIND FIRST uwd200 USE-INDEX uwd20001    WHERE 
           uwd200.policy = uwm200.policy AND
           uwd200.rencnt = uwm200.rencnt AND
           uwd200.endcnt = uwm200.endcnt AND
           uwd200.c_enct = uwm200.c_enct AND
           uwd200.csftq  = uwm200.csftq  AND
           uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
IF NOT AVAIL uwd200 THEN DO:
      DISP  " *** UWD200 INVALID *** ".
END.
ELSE DO:
   REPEAT:
        FIND FIRST uwm120 USE-INDEX uwm12001     WHERE  
                   uwm120.policy = uwd200.policy AND 
                   uwm120.rencnt = uwd200.rencnt AND 
                   uwm120.endcnt = uwd200.endcnt AND 
                   uwm120.riskgp = uwd200.riskgp AND 
                   uwm120.riskno = uwd200.riskno NO-LOCK  NO-ERROR. 
        IF AVAILABLE uwm120 THEN DO:
           IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
           ELSE nvexch = uwm120.siexch.
        END.
        IF SUBSTR(uwd200.rico,1,2) = "0F" THEN DO:
           ASSIGN nv_0f_si  = nv_0f_si + ((uwd200.risi * -1) * nvexch)
                  nv_0f_pr  = nv_0f_pr + (uwd200.ripr * nvexch)
                  nv_0f_cm  = nv_0f_cm + (uwd200.ric1 * nvexch).
        END.
        FIND NEXT uwd200 USE-INDEX uwd20001     WHERE 
                  uwd200.policy = uwm200.policy AND
                  uwd200.rencnt = uwm200.rencnt AND
                  uwd200.endcnt = uwm200.endcnt AND
                  uwd200.c_enct = uwm200.c_enct AND
                  uwd200.csftq  = uwm200.csftq  AND
                  uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
        IF NOT AVAIL UWD200 THEN  LEAVE.
   END. /* repeat */
END. /* ELSE */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ECan C-Win 
PROCEDURE Proc_ECan :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Copy From UZN01002.i     
------------------------------------------------------------------------------*/
IF uwm100.poltyp = "M60" OR 
   uwm100.poltyp = "M61" OR
   uwm100.poltyp = "M62" THEN  DO:
   IF uwm100.endcnt > 000 THEN DO:
      FOR EACH uwm307 USE-INDEX uwm30701 WHERE 
               uwm307.policy = uwm100.policy AND 
               uwm307.rencnt = uwm100.rencnt AND 
               uwm307.endcnt = uwm100.endcnt NO-LOCK .
          nv_mbsi = 0.
          FIND Buwm307 use-index uwm30701 WHERE
               Buwm307.policy = uwm307.policy AND 
               Buwm307.rencnt = uwm307.rencnt AND 
               Buwm307.riskgp = uwm307.riskgp AND 
               Buwm307.riskno = uwm307.riskno AND 
               Buwm307.itemno = uwm307.itemno AND 
               Buwm307.endcnt = uwm307.endcnt NO-LOCK NO-ERROR.
          IF AVAIL Buwm307 THEN  DO:
             nv_mbsi  =  uwm307.mbsi[1].
             FIND  PREV Buwm307  use-index uwm30701 WHERE
                Buwm307.policy = uwm307.policy AND 
                Buwm307.rencnt = uwm307.rencnt NO-LOCK NO-ERROR.
             IF AVAIL Buwm307 THEN  DO:
                IF Buwm307.riskgp = uwm307.riskgp  AND 
                   Buwm307.riskno = uwm307.riskno  AND 
                   Buwm307.itemno = uwm307.itemno  THEN DO:
                   nv_sum  = nv_sum  + (nv_mbsi - Buwm307.mbsi[1]).
                END.
             END.
             ELSE DO:
                nv_sum  = nv_sum  + nv_mbsi.
             END.
          END. /* if BUWM307 */
      END. /* for each */
   END. /* if endcnt > 0 */
   ELSE DO:
     FOR EACH uwm307 USE-INDEX uwm30701 WHERE
        uwm307.policy = uwm100.policy and
        uwm307.rencnt = uwm100.rencnt and
        uwm307.endcnt = uwm100.endcnt
        NO-LOCK .
        nv_sum  = nv_sum  + uwm307.mbsi[1].
     END. /* for each */
   END. /* else */
END. /* if poltyp */
ELSE DO:
  FOR EACH uwm120 USE-INDEX uwm12002 WHERE 
     uwm120.policy = uwm100.policy AND 
     uwm120.rencnt = uwm100.rencnt AND
     uwm120.endcnt = uwm100.endcnt NO-LOCK.
     FIND Buwm120 WHERE Buwm120.policy = uwm100.policy AND 
                        Buwm120.rencnt = uwm100.rencnt AND 
                        Buwm120.riskgp = uwm120.riskgp AND 
                        Buwm120.riskno = uwm120.riskno AND 
                        Buwm120.endcnt = n_endcnt      NO-LOCK NO-ERROR.
     IF AVAIL Buwm120 THEN  DO:
        nv_sum  = nv_sum + ((uwm120.sigr - uwm120.sico) - 
                            (Buwm120.sigr - Buwm120.sico)).
     END.
     ELSE DO:
        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
     END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_ENCan C-Win 
PROCEDURE Proc_ENCan :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Copy From UZN01000.i    
------------------------------------------------------------------------------*/
IF uwm100.poltyp = "M60" OR 
   uwm100.poltyp = "M61" OR  
   uwm100.poltyp = "M62" THEN  DO:
  FOR EACH uwm307 USE-INDEX uwm30701 WHERE uwm307.policy = uwm100.policy AND 
                                           uwm307.rencnt = uwm100.rencnt AND 
                                           uwm307.endcnt = uwm100.endcnt NO-LOCK .

        IF AVAIL uwm307 THEN  DO:
           nv_sum  = nv_sum  + uwm307.mbsi[1].
        END.
        ELSE DO:
             DISP  "ERROR UWM307 NOT AVAIL" UWM307.POLICY.
             PAUSE 5.
        END.

  END.
END.
ELSE DO:
  FOR EACH uwm120 USE-INDEX uwm12001 WHERE uwm120.policy = uwm100.policy AND 
                                           uwm120.rencnt = uwm100.rencnt AND 
                                           uwm120.endcnt = uwm100.endcnt
                                           NO-LOCK.

     IF AVAIL uwm120 THEN  DO:
        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
     END.

  END.

END.
  nv_sum = nv_sum * -1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_NCan C-Win 
PROCEDURE Proc_NCan :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Copy From UZN01002.P    
------------------------------------------------------------------------------*/
FIND FIRST xmm024 NO-LOCK NO-ERROR.

FIND UWM200 WHERE RECID(UWM200) = s_recid NO-WAIT NO-ERROR.


FIND FIRST uwd200 USE-INDEX uwd20001 WHERE 
           uwd200.policy = uwm200.policy AND
           uwd200.rencnt = uwm200.rencnt AND
           uwd200.endcnt = uwm200.endcnt AND
           uwd200.c_enct = uwm200.c_enct AND
           uwd200.csftq  = uwm200.csftq  AND
           uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
IF NOT AVAIL uwd200 THEN DO:
   DISP  "*** uwd200 invalid ***".
END.
ELSE DO:
  REPEAT:
     wrk_si  = 0.  bwrk_si = 0.
     FIND FIRST Buwd200 WHERE 
       Buwd200.policy = uwm200.policy AND
       Buwd200.rencnt = uwm200.rencnt AND
       Buwd200.endcnt = n_endcnt      AND
       Buwd200.c_enct = uwm200.c_enct AND
       Buwd200.csftq  = uwm200.csftq  AND
       Buwd200.rico   = uwm200.rico   AND
       Buwd200.riskgp = uwd200.riskgp AND
       Buwd200.riskno = uwd200.riskno NO-LOCK NO-ERROR.
     IF NOT AVAIL buwd200 THEN DO :
       wrk_si  = uwd200.risi.
     END.                       
     ELSE DO:
        ASSIGN bwrk_si = buwd200.risi
               wrk_si  = uwd200.risi - bwrk_si.
     END.

     FIND FIRST uwm120 USE-INDEX uwm12001 WHERE  
                uwm120.policy = uwd200.policy AND 
                uwm120.rencnt = uwd200.rencnt AND 
                uwm120.endcnt = uwd200.endcnt AND 
                uwm120.riskgp = uwd200.riskgp AND 
                uwm120.riskno = uwd200.riskno NO-LOCK NO-ERROR.
     IF AVAILABLE uwm120 THEN DO:
        IF SUBSTRING(uwm120.policy,3,2) = "90" THEN nvexch = 1.
        ELSE nvexch = uwm120.siexch.
     END.

     IF SUBSTR(uwd200.rico,1,2) = "0D"  THEN DO:
        ASSIGN nv_0d_si  = nv_0d_si  + ((uwd200.risi - bwrk_si) * nvexch)
               nv_0d_pr  = nv_0d_pr  + (uwd200.ripr             * nvexch)
               nv_0d_cm  = nv_0d_cm  + (uwd200.ric1             * nvexch).
     END.

     FIND NEXT uwd200 USE-INDEX uwd20001    WHERE 
               uwd200.policy = uwm200.policy AND
               uwd200.rencnt = uwm200.rencnt AND
               uwd200.endcnt = uwm200.endcnt AND
               uwd200.c_enct = uwm200.c_enct AND
               uwd200.csftq  = uwm200.csftq  AND
               uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
     IF  NOT AVAIL  uwd200 THEN  LEAVE.

  END. /* repeat */
END. /* ELSE */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_NCan2 C-Win 
PROCEDURE Proc_NCan2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    Copy From UZN01004.P  
------------------------------------------------------------------------------*/
FIND FIRST  xmm024 NO-LOCK  NO-ERROR .
FIND UWM200 WHERE RECID(UWM200) = s_recid NO-WAIT NO-ERROR.
FIND FIRST uwd200 USE-INDEX uwd20001 WHERE 
           uwd200.policy = uwm200.policy AND
           uwd200.rencnt = uwm200.rencnt AND
           uwd200.endcnt = uwm200.endcnt AND
           uwd200.c_enct = uwm200.c_enct AND
           uwd200.csftq  = uwm200.csftq  AND
           uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
IF NOT AVAIL uwd200 THEN DO:
   DISP   "*** uwd200 invalid ***".
END.
ELSE DO:
  REPEAT:
     wrk2_si  = 0.  bwrk2_si = 0.
     FIND FIRST Buwd200 WHERE 
                Buwd200.policy = uwm200.policy AND
                Buwd200.rencnt = uwm200.rencnt AND
                Buwd200.endcnt = n_endcnt      AND
                Buwd200.c_enct = uwm200.c_enct AND
                Buwd200.csftq  = uwm200.csftq  AND
                Buwd200.rico   = uwm200.rico   AND
                Buwd200.riskgp = uwd200.riskgp AND
                Buwd200.riskno = uwd200.riskno NO-LOCK NO-ERROR.
     IF NOT AVAIL buwd200 THEN DO:
        wrk2_si  = uwd200.risi.
     END.
     ELSE DO:
       bwrk2_si = buwd200.risi.
       wrk2_si  = uwd200.risi - bwrk2_si.
     END.

     FIND FIRST uwm120 USE-INDEX uwm12001 WHERE   
                uwm120.policy = uwd200.policy AND 
                uwm120.rencnt = uwd200.rencnt AND 
                uwm120.endcnt = uwd200.endcnt AND 
                uwm120.riskgp = uwd200.riskgp AND 
                uwm120.riskno = uwd200.riskno NO-LOCK  NO-ERROR.
     IF AVAILABLE uwm120 THEN DO:
        IF SUBSTR(uwm120.policy,3,2) = "90" THEN nvexch = 1.
        ELSE nvexch = uwm120.siexch.
     END.

     IF SUBSTR(uwd200.rico,1,2) = "0F"  THEN  DO:
        ASSIGN  nv_0f_si  = nv_0f_si + ((uwd200.risi - bwrk2_si) * nvexch)
                nv_0f_pr  = nv_0f_pr + (uwd200.ripr * nvexch)
                nv_0f_cm  = nv_0f_cm + (uwd200.ric1 * nvexch).
     END.

     FIND NEXT uwd200 USE-INDEX uwd20001    WHERE
               uwd200.policy = uwm200.policy AND
               uwd200.rencnt = uwm200.rencnt AND
               uwd200.endcnt = uwm200.endcnt AND
               uwd200.c_enct = uwm200.c_enct AND
               uwd200.csftq  = uwm200.csftq  AND
               uwd200.rico   = uwm200.rico   NO-LOCK NO-ERROR.
     IF NOT  AVAIL  uwd200 THEN  LEAVE.
  END. /* repeat */
END. /* ELSE */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProSI120 C-Win 
PROCEDURE ProSI120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   Copy From UZSSI120.I    
------------------------------------------------------------------------------*/
IF   uwm100.poltyp   = "M60" OR  uwm100.poltyp = "M61" OR
     uwm100.poltyp   = "M62" OR  uwm100.poltyp = "M63" OR
     uwm100.poltyp   = "M64" OR  uwm100.poltyp = "M67" THEN DO:

     FOR EACH uwm307 USE-INDEX uwm30701     WHERE 
              uwm307.policy = uwm100.policy AND 
              uwm307.rencnt = uwm100.rencnt AND 
              uwm307.endcnt = uwm100.endcnt NO-LOCK .
              nv_sum  = nv_sum  + uwm307.mbsi[1].
     END.
END.
ELSE DO:
     FOR EACH uwm120 USE-INDEX uwm12001     WHERE 
              uwm120.policy = uwm100.policy AND 
              uwm120.rencnt = uwm100.rencnt AND 
              uwm120.endcnt = uwm100.endcnt NO-LOCK.
     IF AVAIL uwm120 THEN  DO:
        nv_sum  = nv_sum + (uwm120.sigr - uwm120.sico).
     END.
     END.
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

