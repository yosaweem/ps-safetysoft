&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
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
DEF SHARED VAR n_User    AS CHAR.
DEF SHARED VAR n_Passwd  AS CHAR.
DEF        VAR nv_User   AS CHAR NO-UNDO.
DEF        VAR nv_pwd    AS CHAR NO-UNDO.

DEFINE TEMP-TABLE wclaim 
    FIELD w_no AS INTE
    FIELD w_policy AS CHAR FORMAT "X(16)"
    FIELD w_claim AS CHAR FORMAT "X(16)"
    FIELD w_ins AS CHAR FORMAT "X(60)"
    FIELD w_coins AS INTE
    FIELD w_occ AS CHAR
    FIELD w_sum_tot AS DECI
    FIELD w_add AS CHAR FORMAT "X(150)"
    FIELD w_dist_t AS CHAR FORMAT "X(20)"
    FIELD w_prov AS CHAR FORMAT "X(20)"
    FIELD w_loss_dat AS DATE
    FIELD w_build AS CHAR
    FIELD w_furni AS CHAR
    FIELD w_machi AS CHAR
    FIELD w_stock AS CHAR
    FIELD w_other AS CHAR.

DEFINE VAR nv_output AS CHAR FORMAT "X(50)".
DEFINE VAR nv_policy AS CHAR FORMAT "X(16)".
DEFINE VAR nv_claim  AS CHAR FORMAT "X(16)".
DEFINE VAR nv_insure AS CHAR FORMAT "X(70)".
DEFINE VAR nv_locate AS CHAR FORMAT "X(150)".

DEF NEW SHARED WORKFILE Wclm130 NO-UNDO
    FIELD BRANCH    AS    CHAR FORMAT "XX"
    FIELD DIR_RI    AS    CHAR FORMAT "X"
    FIELD POLICY    LIKE  CLM100.POLICY
    FIELD POLTYP    LIKE  CLM100.POLTYP
    FIELD GROUPTYP  LIKE  S0M005.KEY1
    FIELD NETL_D    LIKE  CLM130.NETL_D
    FIELD ENTDAT    LIKE  CLM130.ENTDAT
    FIELD TRNDAT    LIKE  CLM130.TRNDAT
    FIELD CLAIM     LIKE  CLM130.CLAIM
    FIELD TRNTY1    LIKE  CLM130.TRNTY1
    FIELD DOCNO     LIKE  CLM130.DOCNO
    FIELD CLITEM    LIKE  CLM130.CLITEM
    FIELD CLMANT    LIKE  CLM130.CLMANT
    FIELD CPC_CD    LIKE  CLM130.CPC_CD
    FIELD RELEAS    LIKE  CLM130.RELEAS.

DEFINE VAR nv_br  AS CHAR FORMAT "X(2)".
DEFINE VAR nv_brh AS CHAR FORMAT "X(2)".
DEF STREAM ns1.
DEF VAR   nv_losdat     LIKE CLM100.LOSDAT.
DEF VAR   nv_intref     LIKE CLM120.INTREF.
DEF VAR   nv_coins      LIKE uwm100.coins.
DEF VAR   nv_coper      LIKE uwm100.co_per.
DEF VAR   nv_nature     AS CHAR    FORMAT "X(2)" .
DEF VAR   nv_pol30      AS CHAR    FORMAT "X(16)".
DEF VAR   nv_acno1      AS CHAR    FORMAT "X(10)" .
DEF VAR   nv_poltyp     AS CHAR    FORMAT "X(4)".
DEF VAR   nv_group      AS CHAR    FORMAT "X(10)".
DEF VAR   nv_req        AS CHAR    FORMAT "X(10)".
DEF VAR   nv_userid     LIKE CLM100.ENTID FORMAT "x(8)" . /*--A50-0178 --*/
DEF VAR   nv_sts        LIKE CLM100.PADSTS.
DEF VAR   nv_releas     LIKE CLM130.RELEAS.

DEF VAR nv_facri    AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_1st      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_2nd      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_qs5      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_tfp      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_eng      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_mar      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_ret      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_xol      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_rq       AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_mps      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_btr      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_otr      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_fo1      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_fo2      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_fo3      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_fo4      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_ftr      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_gros     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_1stl     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_1stf     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_1sta     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_2ndl     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_2ndf     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_2nda     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_engl     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_engf     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_enga     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_facl     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_facf     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_faca     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_facerr   AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_res      LIKE clm131.res.
DEF VAR nv_paid     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR n_epaid     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR n_bpaid     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR n_paid_d    AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_os       AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_eos      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_bos      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_os_d     AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-". 
DEF VAR nv_comdat   AS DATE    FORMAT "99/99/9999".
DEF VAR nv_trandat  AS DATE    FORMAT "99/99/9999".
DEF VAR nv_co_per   AS DECIMAL FORMAT "99.99".
DEF VAR nv_si       AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEF VAR n_provi     AS CHAR    FORMAT "X(20)".
DEF VAR n_distct    AS CHAR    FORMAT "X(20)".
DEF VAR n_stat      AS DECIMAL FORMAT ">>9.99".
DEF VAR n_fptr01    AS RECID.
DEF VAR nv_ltxt1    AS INTE.
DEF VAR nv_ltxt2    AS INTE.
DEF VAR n_ltext     AS CHAR    FORMAT "X(70)".
DEF VAR n_occupy    AS CHAR    FORMAT "X(40)".
DEF VAR n_no        AS INTE.
DEF VAR n_si        AS DECI    FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEF VAR nv_status   AS CHAR.
DEF VAR n_paid_t    AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR n_os_t      AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-".
DEF VAR nv_row      AS INT.
DEFINE VAR nv_sico    AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_sigr    AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-".
DEFINE VAR n_line     AS INTE.
DEFINE VAR n_subclass AS CHAR FORMAT "X(10)".
DEFINE VAR n_fptr     AS RECID.
DEFINE VAR nv_text    AS CHAR FORMAT "X(60)".
DEFINE VAR nv_paid_a  AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_os_a    AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-". 
DEFINE VAR nv_paid_b  AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEFINE VAR nv_os_b    AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-". 
DEFINE VAR n_t_paid   AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEFINE VAR n_t_os     AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEFINE VAR n_t_epaid  AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEFINE VAR n_t_eos    AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEFINE VAR n_t_bpaid  AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".
DEFINE VAR n_t_bos    AS DECIMAL FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-".

DEF VAR   nv_total     AS DECIMAL    FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR   nv_etotal    AS DECIMAL    FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR   nv_fex      AS  LOGICAL.
DEF VAR   nv_vat      AS DECIMAL    FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR   nv_netvat   AS DECIMAL    FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR   nv_tax      AS DECIMAL    FORMAT "->>>,>>>,>>>,>>9.99".
DEF VAR   nv_netamt   AS DECIMAL    FORMAT "->>>,>>>,>>>,>>9.99".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frmain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-6 RECT-7 RECT-8 RECT-9 RECT-10 RECT-11 ~
fireport fitype filine fibranch_fr fibranch_to fidate_fr fidate_to fioutput ~
buexit buok fibdes_fr fibdes_to fidetail fiuser fidate fitime 
&Scoped-Define DISPLAYED-OBJECTS fireport fitype filine fibranch_fr ~
fibranch_to fidate_fr fidate_to fioutput fibdes_fr fibdes_to fidetail ~
fiuser fidate fitime 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexit 
     LABEL "EXIT" 
     SIZE 9.5 BY 1.19
     FONT 2.

DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 10.5 BY 1.19
     FONT 2.

DEFINE VARIABLE fibdes_fr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 33 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fibdes_to AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 33.33 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fibranch_fr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fibranch_to AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fidate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12 BY .95
     BGCOLOR 3 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE VARIABLE fidate_fr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fidate_to AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13.67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fidetail AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 75.5 BY .95
     BGCOLOR 3  NO-UNDO.

DEFINE VARIABLE filine AS CHARACTER FORMAT "X(2)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fioutput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fireport AS CHARACTER FORMAT "X(2)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fitime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY .95
     BGCOLOR 3 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE VARIABLE fitype AS CHARACTER FORMAT "X(2)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fiuser AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 11.5 BY .95
     BGCOLOR 3 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 23.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 77 BY 4.43.

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 86.5 BY 20.95
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 77 BY 9.57
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 27.5 BY 9.38.

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 48.5 BY 9.38.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     fireport AT ROW 3.81 COL 27.83 COLON-ALIGNED NO-LABEL 
     fitype AT ROW 5.05 COL 27.83 COLON-ALIGNED NO-LABEL 
     filine AT ROW 6.38 COL 27.83 COLON-ALIGNED NO-LABEL 
     fibranch_fr AT ROW 8.91 COL 35.83 COLON-ALIGNED NO-LABEL 
     fibranch_to AT ROW 10.33 COL 35.83 COLON-ALIGNED NO-LABEL 
     fidate_fr AT ROW 11.67 COL 35.83 COLON-ALIGNED NO-LABEL 
     fidate_to AT ROW 13.05 COL 35.83 COLON-ALIGNED NO-LABEL 
     fioutput AT ROW 14.48 COL 35.83 COLON-ALIGNED NO-LABEL 
     buexit AT ROW 19.43 COL 72.5 
     buok AT ROW 19.48 COL 60.83 
     fibdes_fr AT ROW 8.91 COL 42.5 COLON-ALIGNED NO-LABEL 
     fibdes_to AT ROW 10.33 COL 42.5 COLON-ALIGNED NO-LABEL 
     fidetail AT ROW 17.76 COL 5.17 COLON-ALIGNED NO-LABEL 
     fiuser AT ROW 20.67 COL 5.17 COLON-ALIGNED NO-LABEL 
     fidate AT ROW 20.67 COL 18.17 COLON-ALIGNED NO-LABEL 
     fitime AT ROW 20.67 COL 31.67 COLON-ALIGNED NO-LABEL 
     "1. TE    2. FD   3. ALL" VIEW-AS TEXT
          SIZE 35 BY .62 AT ROW 5.24 COL 37.33 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "REPORTS LINE :" VIEW-AS TEXT
          SIZE 18.5 BY .62 AT ROW 6.57 COL 9 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "REPORTS  :" VIEW-AS TEXT
          SIZE 18.5 BY .62 AT ROW 5.24 COL 9 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "1.FIRE  2.IAR  3.MISC  4.ALL NON" VIEW-AS TEXT
          SIZE 44.67 BY .62 AT ROW 6.62 COL 37.33 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "ENTRY DATE TO :" VIEW-AS TEXT
          SIZE 20 BY .62 AT ROW 13.24 COL 9.5 
          BGCOLOR 14 FGCOLOR 2 FONT 6
     "1.Red Shirt  2.Flood" VIEW-AS TEXT
          SIZE 35 BY .62 AT ROW 4 COL 37.33 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "BRANCH TO :" VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 10.52 COL 9.5 
          BGCOLOR 14 FGCOLOR 2 FONT 6
     "BRANCH FROM :" VIEW-AS TEXT
          SIZE 18.5 BY .62 AT ROW 9.14 COL 9.5 
          BGCOLOR 14 FGCOLOR 2 FONT 6
     "ENTRY DATE FROM :" VIEW-AS TEXT
          SIZE 23 BY .62 AT ROW 11.91 COL 9.5 
          BGCOLOR 14 FGCOLOR 2 FONT 6
     "OUTPUT TO :" VIEW-AS TEXT
          SIZE 15 BY .62 AT ROW 14.67 COL 9.5 
          BGCOLOR 14 FGCOLOR 2 FONT 6
     "    Red Shirt for Stat and Treaty Non-Motor" VIEW-AS TEXT
          SIZE 52.17 BY 1.24 AT ROW 1.71 COL 20.33 
          BGCOLOR 1 FGCOLOR 7 FONT 23
     "[FILE.CSV]" VIEW-AS TEXT
          SIZE 13.5 BY .95 AT ROW 15.62 COL 37.83 
          BGCOLOR 14 FGCOLOR 3 FONT 6
     "REPORTS TYPE :" VIEW-AS TEXT
          SIZE 18.5 BY .62 AT ROW 4 COL 9 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     RECT-6 AT ROW 1.24 COL 1.83 
     RECT-7 AT ROW 8.05 COL 6.5 
     RECT-8 AT ROW 8.14 COL 7 
     RECT-9 AT ROW 8.14 COL 34.5 
     RECT-10 AT ROW 19.1 COL 59.67 
     RECT-11 AT ROW 3.38 COL 6.5 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 88.33 BY 21.24 .


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
         TITLE              = "WACREF01"
         HEIGHT             = 21.24
         WIDTH              = 88.33
         MAX-HEIGHT         = 46.1
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 46.1
         VIRTUAL-WIDTH      = 213.33
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
/* SETTINGS FOR FRAME frmain
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WACREF01 */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WACREF01 */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit C-Win
ON CHOOSE OF buexit IN FRAME frmain /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME frmain /* OK */
DO:
  
   IF fidate_to < fidate_fr THEN DO:
       MESSAGE "ช่วงวันที่เรียกข้อมูลไม่ถูกต้อง" VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fidate_to IN FRAME frmain.
       RETURN NO-APPLY.
   END.
   IF fioutput = "" THEN DO:
       MESSAGE "กรุณาคีย์ Output" VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fioutput IN FRAME frmain.
       RETURN NO-APPLY.
   END.

   nv_output = fioutput + ".SLK".

   n_no = 0.
   IF fireport = "1" THEN DO:
       RUN PDREDShirt.
   END.
   ELSE IF fireport = "2" THEN DO:
       RUN PDFLOOD.
   END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fibranch_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranch_fr C-Win
ON LEAVE OF fibranch_fr IN FRAME frmain
DO:
  fibranch_fr = CAPS(INPUT fibranch_fr).

  IF fibranch_fr = "" THEN DO:
      MESSAGE "Mandatory Field Branch" VIEW-AS ALERT-BOX.
      APPLY "ENTRY" TO fibranch_fr.
  END.
  ELSE DO:
      FIND FIRST xmm023 WHERE xmm023.branch = fibranch_fr NO-LOCK NO-ERROR.
      IF NOT AVAIL xmm023 THEN DO:
          MESSAGE "Not Found Claim Branch On File xmm023" 
          VIEW-AS ALERT-BOX.
          APPLY "ENTRY" TO fibranch_fr.
      END.
      ELSE DO:
          fibdes_fr = xmm023.bdes.
      END.
      DISP fibdes_fr WITH FRAME frmain.
  END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fibranch_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fibranch_to C-Win
ON LEAVE OF fibranch_to IN FRAME frmain
DO:
  fibranch_to = CAPS(INPUT fibranch_to).

  IF fibranch_to = "" THEN DO:
      MESSAGE "Mandatory Field Branch" VIEW-AS ALERT-BOX.
      APPLY "ENTRY" TO fibranch_to .
  END.
  ELSE DO:
      FIND FIRST xmm023 WHERE xmm023.branch = fibranch_to NO-LOCK NO-ERROR.
      IF NOT AVAIL xmm023 THEN DO:
          MESSAGE "Not Found Claim Branch On File xmm023" 
          VIEW-AS ALERT-BOX.
          APPLY "ENTRY" TO fibranch_to .
      END.
      ELSE DO:
          fibdes_to = xmm023.bdes.
      END.
      DISP fibdes_to WITH FRAME frmain.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fidate_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidate_fr C-Win
ON LEAVE OF fidate_fr IN FRAME frmain
DO:
  fidate_fr = INPUT fidate_fr.

  IF fidate_fr = ? THEN DO:
      fidate_fr = TODAY.
  END.
  DISP fidate_fr WITH FRAME frmain.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fidate_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fidate_to C-Win
ON LEAVE OF fidate_to IN FRAME frmain
DO:
  fidate_to = INPUT fidate_to.

  IF fidate_to = ? THEN DO:
      fidate_to = TODAY.
  END.
  DISP fidate_to WITH FRAME frmain.

  IF fidate_to < fidate_fr THEN DO:
      MESSAGE "ช่วงวันที่ในการเรียกรายงานไม่ถูกต้อง" SKIP
              "รบกวนตรวจสอบด้วยคะ"
      VIEW-AS ALERT-BOX.
      APPLY "ENTRY" TO fidate_to IN FRAME frmain.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME filine
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filine C-Win
ON LEAVE OF filine IN FRAME frmain
DO:
  filine = INPUT filine.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL filine C-Win
ON RETURN OF filine IN FRAME frmain
DO:
  filine = INPUT filine.

  IF filine <> "1" THEN 
      IF filine <> "2" THEN
          IF filine <> "3" THEN
              IF filine <> "4" THEN DO:
                  MESSAGE "Mandatory to line..." SKIP
                          "Please select line 1 to 4 only.." VIEW-AS ALERT-BOX.
                  APPLY "ENTRY" TO filine IN FRAME frmain.
              END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fioutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fioutput C-Win
ON LEAVE OF fioutput IN FRAME frmain
DO:
  fioutput = INPUT fioutput.
  nv_output = fioutput.

  IF fioutput = "" THEN DO:
      MESSAGE "กรุณาคีย์ Output" VIEW-AS ALERT-BOX TITLE "WARNING".
      APPLY "ENTRY" TO fioutput IN FRAME frmain.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fireport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fireport C-Win
ON LEAVE OF fireport IN FRAME frmain
DO:
  fireport = INPUT fireport.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fireport C-Win
ON RETURN OF fireport IN FRAME frmain
DO:
  fireport = INPUT fireport.

  IF fireport <> "1" THEN DO:
      IF fireport <> "2" THEN DO:
          MESSAGE "Mandatory to type !!! " SKIP
                  "Please select type 1 or 2 ..." VIEW-AS ALERT-BOX.
          APPLY "ENTRY" TO fireport IN FRAME frmain.
      END.
  END.
  /*
  IF fireport <> "1" OR fireport <> "2" THEN DO:
      MESSAGE "Mandatory to type 1 OR 2 " VIEW-AS ALERT-BOX.
      RETURN NO-APPLY.
  END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fitype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fitype C-Win
ON LEAVE OF fitype IN FRAME frmain
DO:
  fiType = INPUT fiType.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fitype C-Win
ON RETURN OF fitype IN FRAME frmain
DO:
  fiType = INPUT fiType.

  IF fiType <> "1" THEN DO:
      IF fiType <> "2" THEN DO:
          IF fiType <> "3" THEN DO:
              MESSAGE "Mandatory to type !!! " SKIP
                      "Please select type 1 or 2 ..." VIEW-AS ALERT-BOX.
              APPLY "ENTRY" TO fireport IN FRAME frmain.
          END.
      END.
  END.
  /*
  IF fireport <> "1" OR fireport <> "2" THEN DO:
      MESSAGE "Mandatory to type 1 OR 2 " VIEW-AS ALERT-BOX.
      RETURN NO-APPLY.
  END.*/
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
  DEF   VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF   VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WACREF01".
  gv_prog  = "REPORT CLAIM NON-MOTOR".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  /*********************************************************************/  

  RUN  WUT\WUTWICEN (c-win:handle).    

  ASSIGN
      fidate   = TODAY
      fitime   = STRING(TIME,"HH:MM:SS")
      fiuser   = CAPS(n_User)
      fireport = "1" 
      fiType   = "1"
      filine   = "4".
      
  DISPLAY fidate fitime fiuser fireport fiType filine WITH FRAME frmain.

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
  DISPLAY fireport fitype filine fibranch_fr fibranch_to fidate_fr fidate_to 
          fioutput fibdes_fr fibdes_to fidetail fiuser fidate fitime 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE RECT-6 RECT-7 RECT-8 RECT-9 RECT-10 RECT-11 fireport fitype filine 
         fibranch_fr fibranch_to fidate_fr fidate_to fioutput buexit buok 
         fibdes_fr fibdes_to fidetail fiuser fidate fitime 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClaim C-Win 
PROCEDURE PDClaim :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*FOR EACH clm130 USE-INDEX clm13003 WHERE
         clm130.trndat >= fidate_fr AND
         clm130.ENTdat >= fidate_fr AND
         clm130.entdat <= fidate_to AND
         clm130.trnty   = "X"       AND
         clm130.releas  = YES       NO-LOCK :

    nv_br = "".
    IF (SUBSTRING(clm130.claim,1,1) = "D"  OR
        SUBSTRING(clm130.claim,1,1) = "I") THEN DO:  /*Ex: D07050000001*/
        nv_br = SUBSTRING(clm130.claim,2,1).
    END.
    ELSE IF (SUBSTRING(clm130.claim,1,1) = "F" OR
             SUBSTRING(clm130.claim,1,1) = "Z" OR
             SUBSTRING(clm130.claim,1,1) = "N" OR
             SUBSTRING(clm130.claim,1,1) = "A" OR
             SUBSTRING(clm130.claim,1,1) = "B" OR
             SUBSTRING(clm130.claim,1,1) = "H") THEN DO:
        IF LENGTH(clm130.claim) = 11 THEN DO:  /*Ex: N1050000001*/
            nv_br = SUBSTRING(clm130.claim,2,2).
        END.
        ELSE DO:  /*Ex: N050000001*/
            nv_br = SUBSTRING(clm130.claim,2,1).
        END.
    END.

    IF clm130.netl_d = 0 OR clm130.netl_d = ? THEN NEXT.

    FIND FIRST xmm031 USE-INDEX xmm03101 WHERE
               SUBSTRING(xmm031.poltyp,2,2) = SUBSTRING(clm130.claim,3,2) NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
        IF xmm031.dept = "G" OR
           xmm031.dept = "M" THEN NEXT.
    END.

    fidetail = "Process.. " + STRING(clm130.entdat) + " " + clm130.claim.
    DISPLAY fidetail WITH FRAME frmain.

    FIND clm100 USE-INDEX clm10001 WHERE
         clm100.claim = clm130.claim NO-LOCK NO-ERROR.
    IF AVAIL clm100 THEN DO:
        CREATE WCLM130.
        ASSIGN
            WCLM130.BRANCH = nv_br
            WCLM130.POLICY = CLM100.POLICY      
            WCLM130.CLAIM  = CLM130.CLAIM
            WCLM130.ENTDAT = CLM130.ENTDAT
            WCLM130.TRNDAT = CLM130.TRNDAT
            WCLM130.TRNTY1 = CLM130.TRNTY1
            WCLM130.DOCNO  = CLM130.DOCNO
            WCLM130.CLITEM = CLM130.CLITEM
            WCLM130.CLMANT = CLM130.CLMANT
            WCLM130.CPC_CD = CLM130.CPC_CD
            WCLM130.NETL_D = CLM130.NETL_D
            WCLM130.RELEAS = CLM130.RELEAS.

        IF LENGTH(nv_br) = 2 THEN 
             WCLM130.DIR_RI = "D".
        ELSE WCLM130.DIR_RI = SUBSTRING(CLM100.POLICY,1,1).

        FIND FIRST uwm100 WHERE
                   uwm100.policy = clm100.policy NO-LOCK NO-ERROR.
        IF AVAIL uwm100 THEN DO:
            WCLM130.POLTYP = uwm100.poltyp.
        END.

        FIND S0M005 USE-INDEX S0M00501    WHERE
             S0M005.KEY2 = WCLM130.POLTYP NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE S0M005 THEN
           WCLM130.GROUPTYP = S0M005.KEY1.
    END.

END. /*FOR EACH CLM130*/

OUTPUT STREAM ns1 TO VALUE(nv_output).

PUT STREAM ns1 "แบบฟอร์มการเรียกเก็บค่าสินไหมทดแทนงานตามข้อตกลงของตลาดจากเหตุการณ์น้ำท่วมช่วงเดือนมิถุนายน - พฤศจิกายน 2554" SKIP.
PUT STREAM ns1 "บริษัท ประกันคุ้มภัย(มหาชน) จำกัด" SKIP.
PUT STREAM ns1 "ข้อมูลประกอบ   งบบัญชีประจำเดือนมีนาคม 2556" SKIP.
PUT STREAM ns1 "สำหรับสัญญาประกันภัยต่ออัคคีภัยแบบอัตราส่วน (CLASS FIRE)" SKIP(1). 
PUT STREAM ns1 ";" ";" ";" ";" ";" ";" ";" ";" "Location of Loss" ";" ";" 
               ";" ";" ";" ";" ";" ";" "Paid" ";" ";" ";" ";" 
               ";" "Original Loss 100%" ";" ";" ";" "O/S" ";" ";" ";" ";" ";" SKIP.
PUT STREAM ns1 "No." ";"
               "Original Policy No." ";"
               "Claim No." ";"
               "Insured Name" ";"
               "%CO-INS" ";"
               "Occupancy" ";"
               "Sum Insured 100% Total" ";"
               "Address" ";"
               "District" ";" 
               "Province" ";"
               "Industrial Estate" ";"
               "D.O.L [Loss Date]" ";"
               "Building" ";"
               "Furniture" ";"
               "Machinery" ";"
               "Stock" ";"
               "Other" ";" 
               "BI" ";" 
               "Survey Fee" ";"
               "Total" ";"
               "Building" ";" 
               "Furniture" ";" 
               "Machinery" ";"
               "Stock" ";"
               "Other" ";"
               "BI" ";"
               "Survey Fee" ";"
               "Total" ";"
               "% SHARE" ";"
               "Paid" ";"
               "O/S" ";"
               "Com.Date" ";"
               "Tran.Date" ";"
               "1st TREATY" ";"
               "2nd TREATY" ";"
               "FAC.RI." ";"
               "Q.S. 5%" ";"
               "TFP" ";"
               "MPS" ";"
               "ENG.FAC." ";"
               "MARINE O/P" ";"
               "R.Q." ";"
               "BTR" ";"
               "OTR" ";"
               "FTR" ";"
               "F/O I" ";" 
               "F/O II" ";"
               "F/O III" ";"
               "F/O IV" ";"
    SKIP(2).

FOR EACH wclm130 NO-LOCK:

    FIND clm100 USE-INDEX clm10001 WHERE
         clm100.claim = wclm130.claim NO-LOCK NO-ERROR.
    IF NOT AVAIL clm100 THEN NEXT.

    ASSIGN
        nv_pol30 = ""
        nv_coins = NO.

    FIND LAST uwm100 USE-INDEX uwm10001 WHERE
              uwm100.policy = clm100.policy NO-LOCK NO-ERROR.
    IF AVAIL uwm100 THEN DO:
        nv_coins = uwm100.coins.
        nv_acno1 = uwm100.acno1.

        IF uwm100.coins = YES AND
           uwm100.co_per <> 0 THEN  DO:
            nv_coper = 100 - uwm100.co_per.

            IF UWM100.POLTYP = "M01" OR UWM100.POLTYP = "M04" THEN
               nv_pol30 =  " (" + CAPS(TRIM(UWM100.CR_2)) + ")".
        END.
    END.

    IF WCLM130.POLTYP = "M01" OR WCLM130.POLTYP = "M04" THEN
         nv_policy = TRIM(WCLM130.POLICY) + nv_pol30.
    ELSE nv_policy = TRIM(WCLM130.POLICY).

    ASSIGN
       nv_poltyp = WCLM130.POLTYP
       nv_group  = WCLM130.GROUPTYP
       nv_insure = CLM100.NAME1
       nv_req    = WCLM130.TRNTY1 + "-" + WCLM130.DOCNO
       nv_userid = CLM100.ENTID
       nv_releas = WCLM130.RELEAS
       nv_sts    = CLM100.PADSTS
       nv_losdat = CLM100.LOSDAT.

    FIND clm120 USE-INDEX clm12001 WHERE
         clm120.claim  = wclm130.claim AND
         clm120.clmant = wclm130.clmant AND
         clm120.clitem = wclm130.clitem NO-LOCK NO-ERROR.
    IF NOT AVAIL clm120 THEN NEXT.
    IF AVAIL clm120 THEN DO:
        nv_nature = clm120.loss.
        nv_intref = clm120.intref.
    END.


 END. /*FOR EACH wclm130*/

OUTPUT STREAM ns1 CLOSE.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClear02 C-Win 
PROCEDURE PDClear02 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    n_no       = 0
    nv_policy  = ""
    nv_claim   = ""
    nv_insure  = ""
    nv_co_per  = 0
    n_occupy   = ""
    n_si       = 0
    nv_locate  = ""
    n_distct   = ""
    n_provi    = ""
    n_ltext    = ""
    nv_losdat  = ?
    nv_paid    = 0
    n_bpaid    = 0
    n_epaid    = 0
    n_paid_d   = 0
    nv_os      = 0
    nv_bos     = 0
    nv_eos     = 0
    nv_os_d    = 0
    n_stat     = 0
    n_paid_t   = 0
    n_os_t     = 0
    nv_comdat  = ?
    nv_trandat = ?
    nv_1st     = 0
    nv_2nd     = 0
    nv_facri   = 0
    nv_qs5     = 0
    nv_tfp     = 0
    nv_mps     = 0
    nv_eng     = 0
    nv_mar     = 0
    nv_rq      = 0
    nv_btr     = 0
    nv_otr     = 0
    nv_ftr     = 0
    nv_fo1     = 0
    nv_fo2     = 0
    nv_fo3     = 0
    nv_fo4     = 0
    nv_poltyp  = ""
    nv_group   = "" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCLM300 C-Win 
PROCEDURE PDCLM300 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH clm300 USE-INDEX clm30001 WHERE
         clm300.claim = wclm130.claim NO-LOCK:

    /*----- เช็คเงื่อนไขการคำนาณเงิน แต่ละ Reinsurer -------
   1. กรณีที่ค่า netvat = 0   จะเอาค่า total ไปคิดคำนวณ
   2. กรณีที่ค่า netvat <> 0  จะเอาค่า netvat ไปคิดคำนวณ
   --------------------------------------------------*/

    IF nv_fex = NO THEN DO:
        IF nv_netvat <> 0 THEN DO: /* nv_netvat <> 0 */
            
            RUN PDCLM30001.

        END.  /* END nv_netvat <> 0 */
        ELSE DO: /* nv_netvat = 0 */

            RUN PDCLM30002.

        END.  /* nv_netvat = 0 */
    END.
    ELSE DO:  /*nv_fex = NO*/
        IF nv_netvat <> 0 THEN DO:
            
            RUN PDCLM30001.

        END.  /*nv_netvat <> 0*/
        ELSE DO:

            RUN PDCLM30003.

        END.  /* nv_netvat = 0 */
    END.

END.  /*clm300*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCLM30001 C-Win 
PROCEDURE PDCLM30001 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    /*FAC RI*/
    IF clm300.csftq = "F" THEN DO:
        nv_facri = nv_facri + (clm300.risi_p * nv_netvat) / 100.
    
        IF SUBSTRING(clm300.rico,1,2) = "0F" THEN DO:
            FIND xmm600 USE-INDEX xmm60001 WHERE
                 xmm600.acno = clm300.rico NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL xmm600 THEN DO:
                nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.  /* Fac. Error */
            END.
            ELSE DO:
                IF xmm600.acccod = "RA" THEN
                    nv_faca = nv_faca + (clm300.risi_p * nv_netvat) / 100.  /* Fac. Asian */
                ELSE IF XMM600.ACCCOD = "RF" THEN
                    nv_facf = nv_facf + (clm300.risi_p * nv_netvat) / 100.  /* Fac. Foreign */
                ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_netvat) / 100.
            END.  /*AVALIABLE XMM600*/
        END.  /*"OF"*/
    
        IF SUBSTRING(clm300.rico,1,2) = "0D" THEN
            nv_facl = nv_facl + (clm300.risi_p * nv_netvat) / 100.
    END.  /*clm300.csftq = "F"*/
    
    /* 1st Surplus */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "01"
    THEN  nv_1st   = (Clm300.risi_p * nv_netvat) / 100.
    
    /* 2nd Surplus */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "02" AND
       NOT (WCLM130.POLTYP = "M80"  OR WCLM130.POLTYP = "M81" OR
            WCLM130.POLTYP = "M82"  OR WCLM130.POLTYP = "M83" OR
            WCLM130.POLTYP = "M84"  OR WCLM130.POLTYP = "M85" OR
            WCLM130.POLTYP = "C90")
    THEN  nv_2nd    = (Clm300.risi_p * nv_netvat) / 100.
    
    /* THAI RI */
    IF SUBSTRING (Clm300.rico,1,4) = "STAT"
    THEN  nv_qs5  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* TFP */
    IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
    THEN  nv_tfp  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* ENG. FAC */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "02" AND
       (WCLM130.POLTYP = "M80" OR WCLM130.POLTYP = "M81"  OR
        WCLM130.POLTYP = "M82" OR WCLM130.POLTYP = "M83"  OR
        WCLM130.POLTYP = "M84" OR WCLM130.POLTYP = "M85")
    THEN  nv_eng  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* MARINE O/P */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "02" AND
       WCLM130.POLTYP = "C90"
    THEN  nv_mar   = (Clm300.risi_p * nv_netvat) / 100.
    
    /* RET. */
    IF SUBSTRING (Clm300.rico,1,4) = "0RET"
    THEN  nv_ret  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* R.Q. */
    IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
    THEN  nv_rq   = (Clm300.risi_p * nv_netvat) / 100.
    
    /* F/O I */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F1"
    THEN  nv_fo1  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* F/O II */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F2"
    THEN  nv_fo2  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* F/O III */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F3"
    THEN DO:
          IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
          THEN
              /*--- บวกเพิ่มเข้าใน Engineer ---*/
              nv_eng  = nv_eng + (Clm300.risi_p * nv_netvat) / 100.
          ELSE
              /*--- FO3 ไม่รวม Engineer ---*/
              nv_fo3  = (Clm300.risi_p * nv_netvat) / 100.
    END.
    
    /* F/O IV */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F4"
    THEN  nv_fo4  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* FTR */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "FT"
    THEN  nv_ftr  = (Clm300.risi_p * nv_netvat) / 100.
    
    /* MPS */
    IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
       SUBSTRING(clm300.rico,6,2) = "01"
    THEN  nv_mps  = (clm300.risi_p * nv_netvat) / 100.
    
    /* BTR */
    IF SUBSTRING(clm300.rico,1,2) = "0T" AND
       SUBSTRING(clm300.rico,6,2) = "FB"
    THEN  nv_btr  = (clm300.risi_p * nv_netvat) / 100.
    
    /* OTR */
    IF SUBSTRING(clm300.rico,1,2) = "0T" AND
       SUBSTRING(clm300.rico,6,2) = "FO"
    THEN  nv_otr  = (clm300.risi_p * nv_netvat) / 100.
    
    /* GROSS RET. */
    nv_gros = (nv_netvat - nv_facri
                         - nv_1st
                         - nv_2nd
                         - nv_qs5
                         - nv_tfp
                         - nv_eng
                         - nv_mar
                         - nv_rq
                         - nv_fo1
                         - nv_fo2
                         - nv_fo3
                         - nv_fo4
                         - nv_ftr
                         - nv_mps
                         - nv_btr
                         - nv_otr).
    
    /* XOL. */
    IF nv_gros > 5000000 THEN
       ASSIGN
          nv_xol  = nv_gros - 5000000
          nv_gros = 5000000.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCLM30002 C-Win 
PROCEDURE PDCLM30002 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    /*FAC RI*/
   IF clm300.csftq = "F" THEN DO:
       
       nv_facri = nv_facri + (Clm300.risi_p * nv_total) / 100.

       IF SUBSTRING(clm300.rico,1,2) = "0F" THEN DO:
           FIND xmm600 USE-INDEX xmm60001 WHERE
                xmm600.acno = clm300.rico NO-LOCK NO-ERROR NO-WAIT.
           IF NOT AVAIL xmm600 THEN DO:
               nv_facerr = nv_facerr + (clm300.risi_p * nv_total) / 100.     /* Fac. Error */
           END.
           ELSE DO:
               IF xmm600.acccod = "RA" THEN
                   nv_faca = nv_faca + (clm300.risi_p * nv_total) / 100.   /* Fac. Asian */
               ELSE IF xmm600.acccod = "RF" THEN
                   nv_facf = nv_facf + (clm300.risi_p * nv_total) / 100.   /* Fac. Foreign */
               ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_total) / 100.
           END. /*FIND XMM600*/
       END.  /*0F*/
   END.  /*clm300.csftq = "F"*/

   /* 1st Surplus */
   IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
      SUBSTRING (Clm300.rico,6,2) = "01" THEN  nv_1st   = (Clm300.risi_p * nv_total) / 100.

   /* 2nd Surplus */
   IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
      SUBSTRING (Clm300.rico,6,2) = "02" AND
      NOT (WCLM130.POLTYP = "M80"  OR WCLM130.POLTYP = "M81" OR
           WCLM130.POLTYP = "M82"  OR WCLM130.POLTYP = "M83" OR
           WCLM130.POLTYP = "M84"  OR WCLM130.POLTYP = "M85" OR
           WCLM130.POLTYP = "C90") THEN  nv_2nd = (Clm300.risi_p * nv_total) / 100.

   /* THAI RI */
   IF SUBSTRING (Clm300.rico,1,4) = "STAT"
   THEN  nv_qs5  = (Clm300.risi_p * nv_total) / 100.

   /* TFP */
   IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
   THEN  nv_tfp  = (Clm300.risi_p * nv_total) / 100.

   /* ENG. FAC */
   IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
      SUBSTRING (Clm300.rico,6,2) = "02" AND
      (WCLM130.POLTYP = "M80" OR WCLM130.POLTYP = "M81"  OR
       WCLM130.POLTYP = "M82" OR WCLM130.POLTYP = "M83"  OR
       WCLM130.POLTYP = "M84" OR WCLM130.POLTYP = "M85")
   THEN  nv_eng  = (Clm300.risi_p * nv_total) / 100.

   /* MARINE O/P */
   IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
      SUBSTRING (Clm300.rico,6,2) = "02" AND
      WCLM130.POLTYP = "C90"
   THEN  nv_mar   = (Clm300.risi_p * nv_total) / 100.

   /* RET. */
   IF SUBSTRING (Clm300.rico,1,4) = "0RET"
   THEN  nv_ret  = (Clm300.risi_p * nv_total) / 100.

   /* R.Q. */
   IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
   THEN  nv_rq   = (Clm300.risi_p * nv_total) / 100.

   /* F/O I */
   IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
      SUBSTRING(Clm300.rico,6,2) = "F1"
   THEN  nv_fo1  = (Clm300.risi_p * nv_total) / 100.

   /* F/O II */
   IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
      SUBSTRING(Clm300.rico,6,2) = "F2"
   THEN  nv_fo2  = (Clm300.risi_p * nv_total) / 100.

   /* F/O III */
   IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
      SUBSTRING(Clm300.rico,6,2) = "F3"
   THEN DO:
         IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
         THEN
             /*--- บวกเพิ่มเข้าใน Engineer ---*/
             nv_eng  = nv_eng + (Clm300.risi_p * nv_total) / 100.
         ELSE
             /*--- FO3 ไม่รวม Engineer ---*/
             nv_fo3  = (Clm300.risi_p * nv_total) / 100.
   END.

   /* F/O IV */
   IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
      SUBSTRING(Clm300.rico,6,2) = "F4"
   THEN  nv_fo4  = (Clm300.risi_p * nv_total) / 100.

   /* FTR */
   IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
      SUBSTRING(Clm300.rico,6,2) = "FT"
   THEN  nv_ftr  = (Clm300.risi_p * nv_total) / 100.

   /* MPS */
   IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
      SUBSTRING(clm300.rico,6,2) = "01"
   THEN  nv_mps  = (clm300.risi_p * nv_total) / 100.

   /* BTR */
   IF SUBSTRING(clm300.rico,1,2) = "0T" AND
      SUBSTRING(clm300.rico,6,2) = "FB"
   THEN  nv_btr  = (clm300.risi_p * nv_total) / 100.

   /* OTR */
   IF SUBSTRING(clm300.rico,1,2) = "0T" AND
      SUBSTRING(clm300.rico,6,2) = "FO"
   THEN  nv_otr  = (clm300.risi_p * nv_total) / 100.

   /* GROSS RET. */
   nv_gros = (nv_total  - nv_facri
                        - nv_1st
                        - nv_2nd
                        - nv_qs5
                        - nv_tfp
                        - nv_eng
                        - nv_mar
                        - nv_rq
                        - nv_fo1
                        - nv_fo2
                        - nv_fo3
                        - nv_fo4
                        - nv_ftr
                        - nv_mps
                        - nv_btr
                        - nv_otr).
   
   /* XOL. */
   IF nv_gros > 5000000 THEN
      ASSIGN
         nv_xol  = nv_gros - 5000000
         nv_gros = 5000000.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCLM30003 C-Win 
PROCEDURE PDCLM30003 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    /* FAC RI */
    IF Clm300.csftq = "F" THEN DO:
       nv_facri = nv_facri + (Clm300.risi_p * nv_etotal) / 100.
    
       IF SUBSTRING (Clm300.rico,1,2) = "0F" THEN DO:
          FIND XMM600 USE-INDEX XMM60001 WHERE
               XMM600.ACNO = Clm300.rico NO-LOCK NO-ERROR NO-WAIT.
          IF NOT AVAILABLE XMM600 THEN DO:
             nv_facerr = nv_facerr + (clm300.risi_p * nv_etotal) / 100.      /* Fac. Error */
          END.
          ELSE DO:
             IF XMM600.ACCCOD  = "RA" THEN
                nv_faca = nv_faca + (clm300.risi_p * nv_etotal) / 100.    /* Fac. Asian */
             ELSE IF XMM600.ACCCOD = "RF" THEN
                nv_facf = nv_facf + (clm300.risi_p * nv_etotal) / 100.    /* Fac. Foreign */
             ELSE nv_facerr = nv_facerr + (clm300.risi_p * nv_etotal) / 100.
          END. /* find xmm600 */
       END. /* clm130.rico = "0F" */
    
       IF SUBSTRING (Clm300.rico,1,2) = "0D" THEN
          nv_facl = nv_facl + (clm300.risi_p * nv_etotal) / 100.
    
    END. /* clm300.csftq = "F" */
    
    /* 1st Surplus */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "01"
    THEN  nv_1st   = (Clm300.risi_p * nv_etotal) / 100.
    
    /* 2nd Surplus */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "02" AND
       NOT (WCLM130.POLTYP = "M80"  OR WCLM130.POLTYP = "M81" OR
            WCLM130.POLTYP = "M82"  OR WCLM130.POLTYP = "M83" OR
            WCLM130.POLTYP = "M84"  OR WCLM130.POLTYP = "M85" OR
            WCLM130.POLTYP = "C90")
    THEN  nv_2nd    = (Clm300.risi_p * nv_etotal) / 100.
    
    /* THAI RI */
    IF SUBSTRING (Clm300.rico,1,4) = "STAT"
    THEN  nv_qs5  = (Clm300.risi_p * nv_etotal) / 100.
    
    /* TFP */
    IF SUBSTRING (Clm300.rico,1,3)  = "0QA"
    THEN  nv_tfp  = (Clm300.risi_p * nv_etotal) / 100.
    
    /* ENG. FAC */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "02" AND
       (WCLM130.POLTYP = "M80" OR WCLM130.POLTYP = "M81"  OR
        WCLM130.POLTYP = "M82" OR WCLM130.POLTYP = "M83"  OR
        WCLM130.POLTYP = "M84" OR WCLM130.POLTYP = "M85")
    THEN  nv_eng  = (Clm300.risi_p * nv_etotal) / 100.
    
    /* MARINE O/P */
    IF SUBSTRING (Clm300.rico,1,2) = "0T" AND
       SUBSTRING (Clm300.rico,6,2) = "02" AND
       WCLM130.POLTYP = "C90"
    THEN  nv_mar   = (Clm300.risi_p * nv_etotal) / 100.
    
    /* RET. */
    IF SUBSTRING (Clm300.rico,1,4) = "0RET"
    THEN  nv_ret  = (Clm300.risi_p * nv_etotal) / 100.
    
    
    /* R.Q. */
    IF SUBSTRING (Clm300.rico,1,3) = "0RQ"
    THEN  nv_rq   = (Clm300.risi_p * nv_etotal) / 100.
    
    /* F/O I */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F1"
    THEN  nv_fo1  = (Clm300.risi_p * nv_etotal) / 100.
    
    /* F/O II */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F2"
    THEN  nv_fo2  = (Clm300.risi_p * nv_etotal) / 100.
    
    /* F/O III */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F3"
    THEN DO:
          IF LOOKUP (WCLM130.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0
          THEN
              /*--- บวกเพิ่มเข้าใน Engineer ---*/
              nv_eng  = nv_eng + (Clm300.risi_p * nv_etotal) / 100.
          ELSE
              /*--- FO3 ไม่รวม Engineer ---*/
              nv_fo3  = (Clm300.risi_p * nv_etotal) / 100.
    END.
    
    /* F/O IV */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "F4"
    THEN  nv_fo4  = (Clm300.risi_p * nv_etotal) / 100.
    
    /* FTR */
    IF SUBSTRING(Clm300.rico,1,2) = "0T" AND
       SUBSTRING(Clm300.rico,6,2) = "FT"
    THEN  nv_ftr  = (Clm300.risi_p * nv_etotal) / 100.
    
    /* MPS */
    IF SUBSTRING(clm300.rico,1,3) = "0PS" AND
       SUBSTRING(clm300.rico,6,2) = "01"
    THEN  nv_mps  = (clm300.risi_p * nv_etotal) / 100.
    
    /* BTR */
    IF SUBSTRING(clm300.rico,1,2) = "0T" AND
       SUBSTRING(clm300.rico,6,2) = "FB"
    THEN  nv_btr  = (clm300.risi_p * nv_etotal) / 100.
    
    /* OTR */
    IF SUBSTRING(clm300.rico,1,2) = "0T" AND
       SUBSTRING(clm300.rico,6,2) = "FO"
    THEN  nv_otr  = (clm300.risi_p * nv_etotal) / 100.
    
    /* GROSS RET. */
    nv_gros = (nv_etotal - nv_facri
                         - nv_1st
                         - nv_2nd
                         - nv_qs5
                         - nv_tfp
                         - nv_eng
                         - nv_mar
                         - nv_rq
                         - nv_fo1
                         - nv_fo2
                         - nv_fo3
                         - nv_fo4
                         - nv_ftr
                         - nv_mps
                         - nv_btr
                         - nv_otr).
    
    /* XOL. */
    IF nv_gros > 5000000 THEN
       ASSIGN
          nv_xol  = nv_gros - 5000000
          nv_gros = 5000000.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDFLOOD C-Win 
PROCEDURE PDFLOOD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_row = 0.
OUTPUT STREAM ns1 TO VALUE(nv_output).

PUT STREAM ns1 "ID;PND" SKIP.
/*----
nv_row = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   "แบบฟอร์มการเรียกเก็บค่าสินไหมทดแทนงานตามข้อตกลงของตลาดจากเหตุการณ์น้ำท่วมช่วงเดือนมิถุนายน - พฤศจิกายน 2554"  '"' SKIP
nv_row = nv_row + 1.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   "บริษัท ประกันคุ้มภัย(มหาชน) จำกัด" '"' SKIP.
nv_row = nv_row + 1.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   "ข้อมูลประกอบ   งบบัญชีประจำเดือนมีนาคม 2556" '"' SKIP.
---*/
nv_row = nv_row + 1.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   "สำหรับสัญญาประกันภัยต่ออัคคีภัยแบบอัตราส่วน (CLASS FIRE)" '"' SKIP.
nv_row = nv_row + 1.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   "Original Loss 100 %"        '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X32;K"    '"'   "Thai Re Share (Amount)ภายใต้สัญญาแบบอัตราส่วน 5%"   '"' SKIP. 
nv_row = nv_row + 1.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K"    '"'   "Location of Loss"           '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K"    '"'   "Paid"                       '"' SKIP.    
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X27;K"    '"'   "O/S"                        '"' SKIP.
nv_row = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   "No."                        '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'   "Policy Type"                '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K"     '"'   "Group Type"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K"     '"'   "Nature"                     '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K"     '"'   "Original Policy No."        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K"     '"'   "Claim No.  "                '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K"     '"'   "Insured Name"               '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K"     '"'   "%CO-INS"                    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K"     '"'   "Occupancy"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K"    '"'   "Sum Insured 100% Total"     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K"    '"'   "Address"                    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K"    '"'   "District"                   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K"    '"'   "Province"                   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K"    '"'   "Industrial Estate"          '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K"    '"'   "D.O.L [Loss Date]"          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K"    '"'   "Building"                   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'   "Furniture"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K"    '"'   "Machinery"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K"    '"'   "Stock"                      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   "Other"                      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'   "BI"                         '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'   "Survey Fee"                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K"    '"'   "Total"                      '"' SKIP.   
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K"    '"'   "Building"                   '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K"    '"'   "Furniture"                  '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X26;K"    '"'   "Machinery"                  '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X27;K"    '"'   "Stock"                      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X28;K"    '"'   "Other"                      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X29;K"    '"'   "BI"                         '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X30;K"    '"'   "Survey Fee"                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X31;K"    '"'   "Total"                      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X32;K"    '"'   "% SHARE"                    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X33;K"    '"'   "Paid"                       '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X34;K"    '"'   "O/S"                        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X35;K"    '"'   "Com.Date"                   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X36;K"    '"'   "Tran.Date"                  '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X37;K"    '"'   "Total Claim"                '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X38;K"    '"'   "SURVEY FEE"                 '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X39;K"    '"'   "NET VAT"                    '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X40;K"    '"'   "VAT"                        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X41;K"    '"'   "Tax 3%"                     '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X42;K"    '"'   "NETAMT"                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X43;K"    '"'   "1st TREATY"                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X44;K"    '"'   "2nd TREATY"                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X45;K"    '"'   "FAC.RI."                    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X46;K"    '"'   "Q.S. 5%"                    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X47;K"    '"'   "TFP"                        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X48;K"    '"'   "MPS"                        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X49;K"    '"'   "ENG.FAC."                   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X50;K"    '"'   "MARINE O/P"                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X51;K"    '"'   "R.Q."                       '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X52;K"    '"'   "BTR"                        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X53;K"    '"'   "OTR"                        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X54;K"    '"'   "FTR"                        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X55;K"    '"'   "F/O I"                      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X56;K"    '"'   "F/O II"                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X57;K"    '"'   "F/O III"                    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X58;K"    '"'   "F/O IV"                     '"' SKIP.                                     
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X59;K"    '"'   "RET."                       '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X60;K"    '"'   "GROSS RET."                 '"' SKIP.  

IF fiType = "2" OR fiType = "3" THEN RUN PDReportFD.
ELSE DO: 
    MESSAGE "Not Found Reports for FLOOD..." SKIP
            "Report = FD or ALL only " VIEW-AS ALERT-BOX WARNING.
    APPLY "ENTRY" TO fiType IN FRAME frmain.
    RETURN NO-APPLY.
END.

nv_row = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'   "TOTAL"                                               '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   n_t_paid     FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'   n_t_bpaid    FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'   n_t_epaid    FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K"    '"'   nv_paid_a    FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X28;K"    '"'   n_t_os       FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X29;K"    '"'   n_t_bos      FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X30;K"    '"'   n_t_eos      FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X31;K"    '"'   nv_os_a      FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X33;K"    '"'   nv_paid_b    FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X34;K"    '"'   nv_os_b      FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP.


ASSIGN
    n_t_paid   = 0
    n_t_bpaid  = 0
    n_t_epaid  = 0
    nv_paid_a  = 0
    nv_paid_b  = 0
    n_t_os     = 0
    n_t_bos    = 0
    n_t_eos    = 0
    nv_os_a    = 0
    nv_os_b    = 0.

   
PUT STREAM ns1 "E".
OUTPUT STREAM ns1 CLOSE.


MESSAGE "Process 'FLOOD' Complete" VIEW-AS ALERT-BOX TITLE "INFORMATION".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDRECORD1 C-Win 
PROCEDURE PDRECORD1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    n_no   = n_no + 1.
    nv_row = nv_row + 1.
/*------
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'  n_no                                                    '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'  nv_poltyp                                               '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K"     '"'  nv_group                                                '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K"     '"'  nv_policy                                               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K"     '"'  nv_claim                                                '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K"     '"'  nv_insure                                               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K"     '"'  n_subclass                                              '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K"     '"'  nv_co_per                                               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K"     '"'  nv_locate                                               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K"    '"'  n_distct                                                '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K"    '"'  n_provi                                                 '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K"    '"'  nv_losdat                                               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K"    '"'  n_si           FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K"    '"'  nv_nature                                               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K"    '"'  nv_text                                                 '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K"    '"'  n_epaid                                                 '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'  n_bpaid                                                 '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K"    '"'  nv_os                                                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K"    '"'  n_stat                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'  n_paid_t       FORMAT ">>>,>>>,>>>,>>9.99-"             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'  n_paid_d       FORMAT ">>>,>>>,>>>,>>9.99-"             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'  n_os_t         FORMAT ">>>,>>>,>>>,>>9.99-"             '"' SKIP.   
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K"    '"'  nv_comdat                                               '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K"    '"'  nv_trandat                                              '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K"    '"'  nv_1st                                                  '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X26;K"    '"'  nv_2nd                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X27;K"    '"'  nv_facri                                                '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X28;K"    '"'  nv_qs5                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X29;K"    '"'  nv_tfp                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X30;K"    '"'  nv_mps                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X31;K"    '"'  nv_eng                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X32;K"    '"'  nv_mar                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X33;K"    '"'  nv_rq                                                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X34;K"    '"'  nv_btr                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X35;K"    '"'  nv_otr                                                  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X36;K"    '"'  nv_ftr                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X37;K"    '"'  nv_fo1                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X38;K"    '"'  nv_fo2                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X39;K"    '"'  nv_fo3                                                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X40;K"    '"'  nv_fo4                                                  '"' SKIP.
    ------*/

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   n_no                     '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'   WCLM130.POLTYP           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K"     '"'   WCLM130.GROUPTYP         '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K"     '"'   WCLM130.POLICY           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K"     '"'   WCLM130.CLAIM            '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K"     '"'   nv_insure                '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K"     '"'   n_subclass               '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K"     '"'   nv_coper                 '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K"     '"'   nv_locate                '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K"    '"'   n_distct                 '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K"    '"'   n_provi                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K"    '"'   nv_losdat                '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K"    '"'   n_si           FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-"    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K"    '"'   nv_nature                '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K"    '"'   nv_text                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K"    '"'   n_epaid                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'   n_bpaid                  '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K"    '"'   nv_os                    '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K"    '"'   n_stat                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   n_paid_t       FORMAT ">>>,>>>,>>>,>>9.99-"   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'   n_paid_d       FORMAT ">>>,>>>,>>>,>>9.99-"   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'   n_os_t         FORMAT ">>>,>>>,>>>,>>9.99-"   '"' SKIP.   
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K"    '"'   nv_comdat                '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K"    '"'   WCLM130.TRNDAT           '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K"    '"'   nv_total                 '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X26;K"    '"'   nv_etotal                '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X27;K"    '"'   nv_netvat                '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X28;K"    '"'   nv_vat                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X29;K"    '"'   nv_tax                   '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X30;K"    '"'   nv_netamt                '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X31;K"    '"'   nv_1st                   '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X32;K"    '"'   nv_2nd                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X33;K"    '"'   nv_facri                 '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X34;K"    '"'   nv_qs5                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X35;K"    '"'   nv_tfp                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X36;K"    '"'   nv_mps                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X37;K"    '"'   nv_eng                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X38;K"    '"'   nv_mar                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X39;K"    '"'   nv_rq                    '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X40;K"    '"'   nv_btr                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X41;K"    '"'   nv_otr                   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X42;K"    '"'   nv_ftr                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X43;K"    '"'   nv_fo1                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X44;K"    '"'   nv_fo2                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X45;K"    '"'   nv_fo3                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X46;K"    '"'   nv_fo4                   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X47;K"    '"'   nv_ret                   '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X48;K"    '"'   nv_gros                  '"' SKIP. 
    
    n_t_epaid  = n_t_epaid + n_epaid.
    n_t_bpaid  = n_t_bpaid + n_bpaid.
    n_t_os     = n_t_os    + nv_os.
    nv_paid_b  = nv_paid_b + n_paid_t.
    nv_paid_a  = nv_paid_a + n_paid_d.  
    nv_os_b    = nv_os_b   + n_os_t.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDRECORD2 C-Win 
PROCEDURE PDRECORD2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    n_no   = n_no + 1.
    nv_row = nv_row + 1.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   n_no               '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'   nv_poltyp          '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K"     '"'   nv_group           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K"     '"'   nv_nature          '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K"     '"'   WCLM130.POLICY     '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K"     '"'   WCLM130.CLAIM      '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K"     '"'   nv_insure          '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K"     '"'   nv_coper           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K"     '"'   n_occupy           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K"    '"'   n_si               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K"    '"'   nv_locate          '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K"    '"'   n_distct           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K"    '"'   n_provi            '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K"    '"'   n_ltext            '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K"    '"'   nv_losdat          '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K"    '"'   0.00               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'   0.00               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K"    '"'   0.00               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K"    '"'   0.00               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   nv_total           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'   n_bpaid            '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'   n_epaid            '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K"    '"'   n_paid_d           '"' SKIP.   
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K"    '"'   0.00               '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K"    '"'   0.00               '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X26;K"    '"'   0.00               '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X27;K"    '"'   0.00               '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X28;K"    '"'   nv_os              '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X29;K"    '"'   nv_bos             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X30;K"    '"'   nv_eos             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X31;K"    '"'   nv_os_d            '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X32;K"    '"'   nv_qs5             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X33;K"    '"'   n_paid_t           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X34;K"    '"'   n_os_t             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X35;K"    '"'   nv_comdat          '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X36;K"    '"'   WCLM130.TRNDAT     '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X37;K"    '"'   nv_total           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X38;K"    '"'   nv_etotal          '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X39;K"    '"'   nv_netvat          '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X40;K"    '"'   nv_vat             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X41;K"    '"'   nv_tax             '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X42;K"    '"'   nv_netamt          '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X43;K"    '"'   nv_1st             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X44;K"    '"'   nv_2nd             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X45;K"    '"'   nv_facri           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X46;K"    '"'   nv_qs5             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X47;K"    '"'   nv_tfp             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X48;K"    '"'   nv_mps             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X49;K"    '"'   nv_eng             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X50;K"    '"'   nv_mar             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X51;K"    '"'   nv_rq              '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X52;K"    '"'   nv_btr             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X53;K"    '"'   nv_otr             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X54;K"    '"'   nv_ftr             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X55;K"    '"'   nv_fo1             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X56;K"    '"'   nv_fo2             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X57;K"    '"'   nv_fo3             '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X58;K"    '"'   nv_fo4             '"' SKIP.                                     
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X59;K"    '"'   nv_ret             '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X60;K"    '"'   nv_gros            '"' SKIP. 

/*----
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   n_no           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'   nv_poltyp      '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K"     '"'   nv_group       '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K"     '"'   nv_policy      '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K"     '"'   nv_claim       '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K"     '"'   nv_insure      '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K"     '"'   nv_co_per   FORMAT ">>,>>>,>>>,>>>,>>>,>>9.99-" '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K"     '"'   n_occupy       '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K"     '"'   n_si           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K"    '"'   nv_locate      '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K"    '"'   n_distct       '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K"    '"'   n_provi        '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K"    '"'   n_ltext        '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K"    '"'   nv_losdat      '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K"    '"'   0.00           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K"    '"'   0.00           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'   0.00           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K"    '"'   0.00           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K"    '"'   nv_paid        '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   n_bpaid        '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'   n_epaid        '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'   n_paid_d       '"' SKIP.   
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K"    '"'   0.00           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K"    '"'   0.00           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K"    '"'   0.00           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X26;K"    '"'   0.00           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X27;K"    '"'   nv_os          '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X28;K"    '"'   nv_bos         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X29;K"    '"'   nv_eos         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X30;K"    '"'   nv_os_d     FORMAT ">>>,>>>,>>>,>>9.99-"   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X31;K"    '"'   n_stat      FORMAT ">>>,>>>,>>>,>>9.99-"   '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X32;K"    '"'   n_paid_t       '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X33;K"    '"'   n_os_t         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X34;K"    '"'   nv_comdat      '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X35;K"    '"'   nv_trandat     '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X36;K"    '"'   nv_1st         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X37;K"    '"'   nv_2nd         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X38;K"    '"'   nv_facri       '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X39;K"    '"'   nv_qs5         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X40;K"    '"'   nv_tfp         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X41;K"    '"'   nv_mps         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X42;K"    '"'   nv_eng         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X43;K"    '"'   nv_mar         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X44;K"    '"'   nv_rq          '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X45;K"    '"'   nv_btr         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X46;K"    '"'   nv_otr         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X47;K"    '"'   nv_ftr         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X48;K"    '"'   nv_fo1         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X49;K"    '"'   nv_fo2         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X50;K"    '"'   nv_fo3         '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X51;K"    '"'   nv_fo4         '"' SKIP.  
----*/

    n_t_paid   = n_t_paid  + nv_paid.
    n_t_bpaid  = n_t_bpaid + n_bpaid.
    n_t_epaid  = n_t_epaid + n_epaid.
    nv_paid_a  = nv_paid_a + n_paid_d. 
    nv_paid_b  = nv_paid_b + n_paid_t.
    n_t_os     = n_t_os  + nv_os.
    n_t_bos    = n_t_bos + nv_bos.
    n_t_eos    = n_t_eos + nv_eos.
    nv_os_a    = nv_os_a + nv_os_d.
    nv_os_b    = nv_os_b + n_os_t.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDREDShirt C-Win 
PROCEDURE PDREDShirt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_row = 0.
OUTPUT STREAM ns1 TO VALUE(nv_output).
PUT STREAM ns1 "ID;PND" SKIP.
nv_row = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K"     '"'   "สถานที่เกิดเหตุ"                         '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'   "ค่าสินไหมทดแทนที่เกิดขึ้นของท่าน"        '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   "ค่าสินไหมทดแทนที่เกิดขึ้นส่วนของสัญญา"   '"' SKIP.

PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K"     '"'   "ลำดับ"                                   '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'   "Policy Type"                             '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K"     '"'   "Group Type"                              '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K"     '"'   "เลขที่กรมธรรม์"                          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K"     '"'   "เลขที่เคลม"                              '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K"     '"'   "ชื่อผู้เอาประกันภัย"                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K"     '"'   "Sub Class"                               '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K"     '"'   "%CO-INS"                                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K"     '"'   "สถานที่ตั้ง"                             '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K"    '"'   "อำเภอ"                                   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K"    '"'   "จังหวัด"                                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K"    '"'   "วันที่เกิดเหตุ"                          '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K"    '"'   "ทุนเอาประกันภัยของบริษัทท่าน"            '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K"    '"'   "ประเภทความเสียหาย"                       '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K"    '"'   "สถานะของความเสียหาย"                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K"    '"'   "ค่าสินไหมทดแทนที่จ่ายสะสมถึงงวดนี้"      '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'   "ค่าสินไหมทดแทนที่จ่ายงวดนี้"             '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K"    '"'   "ค่าสินไหมทดแทนค้างจ่าย"                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K"    '"'   "สัดส่วนที่เข้าสัญญา (%)"                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'   "ค่าสินไหมทดแทนที่จ่ายสะสมถึงก่อนงวดนี้"  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'   "ค่าสินไหมทดแทนที่จ่ายงวดนี้"             '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'   "ค่าสินไหมทดแทนค้างจ่าย"                  '"' SKIP.   
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K"    '"'   "Com.Date"                                '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K"    '"'   "Tran.Date"                               '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K"    '"'   "Total Claim"                             '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X26;K"    '"'   "SURVEY FEE"                              '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X27;K"    '"'   "NET VAT"                                 '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X28;K"    '"'   "VAT"                                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X29;K"    '"'   "Tax 3%"                                  '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X30;K"    '"'   "NETAMT"                                  '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X31;K"    '"'   "1st TREATY"                              '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X32;K"    '"'   "2nd TREATY"                              '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X33;K"    '"'   "FAC.RI."                                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X34;K"    '"'   "Q.S. 5%"                                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X35;K"    '"'   "TFP"                                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X36;K"    '"'   "MPS"                                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X37;K"    '"'   "ENG.FAC."                                '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X38;K"    '"'   "MARINE O/P"                              '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X39;K"    '"'   "R.Q."                                    '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X40;K"    '"'   "BTR"                                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X41;K"    '"'   "OTR"                                     '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X42;K"    '"'   "FTR"                                     '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X43;K"    '"'   "F/O I"                                   '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X44;K"    '"'   "F/O II"                                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X45;K"    '"'   "F/O III"                                 '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X46;K"    '"'   "F/O IV"                                  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X47;K"    '"'   "RET."                                    '"' SKIP.  
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X48;K"    '"'   "GROSS RET."                              '"' SKIP.  

IF fiType = "1" OR fiType = "3" THEN RUN PDReportTE.
ELSE DO: 
    MESSAGE "Not Found Reports for RedShirt..." SKIP
            "Report = TE or ALL only " VIEW-AS ALERT-BOX WARNING.
    APPLY "ENTRY" TO fiType IN FRAME frmain.
    RETURN NO-APPLY.
END.


nv_row = nv_row + 1.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K"     '"'  "TOTAL"                                    '"' SKIP.
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K"    '"'  n_t_epaid    FORMAT ">>>,>>>,>>>,>>>,>>9.99-"  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K"    '"'  n_t_bpaid    FORMAT ">>>,>>>,>>>,>>>,>>9.99-"  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K"    '"'  n_t_os       FORMAT ">>>,>>>,>>>,>>>,>>9.99-"  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K"    '"'  nv_paid_b    FORMAT ">>>,>>>,>>>,>>>,>>9.99-"  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K"    '"'  nv_paid_a    FORMAT ">>>,>>>,>>>,>>>,>>9.99-"  '"' SKIP. 
PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K"    '"'  nv_os_b      FORMAT ">>>,>>>,>>>,>>>,>>9.99-"  '"' SKIP.

ASSIGN
    n_t_epaid = 0
    n_t_bpaid = 0
    n_t_os    = 0
    nv_paid_b = 0
    nv_paid_a = 0
    nv_os_b   = 0.
   
PUT STREAM ns1 "E".
OUTPUT STREAM ns1 CLOSE.


MESSAGE "Process 'RED SHIRT' Complete" VIEW-AS ALERT-BOX TITLE "INFORMATION".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDReportFD C-Win 
PROCEDURE PDReportFD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH clm130 USE-INDEX clm13020 WHERE
         clm130.entdat >= fidate_fr AND
         clm130.entdat <= fidate_to /*AND
         clm130.trnty1  = "X"       AND
         clm130.releas  = YES     */  NO-LOCK:

    /*--- Check Branch ---*/
    nv_br = "".
    IF (SUBSTR(clm130.claim,1,1) = "D"   OR   /*Ex: D07050000001*/
        SUBSTR(clm130.claim,1,1) = "I")  THEN DO:
        nv_br  = SUBSTR(clm130.claim,2,1).
        IF nv_br < fiBranch_fr OR
           nv_br > fibranch_to THEN NEXT.
    END.
    ELSE IF (SUBSTR(clm130.claim,1,1) = "F"   OR 
             SUBSTR(clm130.claim,1,1) = "Z"   OR 
             SUBSTR(clm130.claim,1,1) = "N"   OR
             SUBSTR(clm130.claim,1,1) = "A"   OR
             SUBSTR(clm130.claim,1,1) = "B"   OR
             SUBSTR(clm130.claim,1,1) = "H")  THEN DO:
             IF LENGTH(clm130.claim)  = 11 THEN DO:  /*Ex: N1050000001*/
                 nv_br  = SUBSTR(clm130.claim,2,2).
                 IF nv_br < fibranch_fr OR
                    nv_br > fibranch_to THEN NEXT.
             END.
             ELSE DO: /*Ex: N050000001*/
                 nv_br  = SUBSTR(clm130.claim,2,1).  
                 IF nv_br < fibranch_fr AND
                    nv_br > fibranch_to THEN NEXT.
             END.
    END.
    ELSE DO: /*Ex: 107050000001*/
        nv_br  = SUBSTR(clm130.claim,1,2).
        IF nv_br < fibranch_fr OR
           nv_br > fibranch_to THEN NEXT.
    END.

    IF CLM130.NETL_D = 0  OR CLM130.NETL_D = ? THEN NEXT.

    /*--- Check Group Type ---*/
    FIND FIRST xmm031 USE-INDEX xmm03101 WHERE
               SUBSTRING(xmm031.poltyp,2,2) = SUBSTRING(clm130.claim,3,2) 
    NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
        IF filine = "1" THEN DO:       /*-- FIRE --*/
            IF xmm031.dept <> "A" THEN NEXT.
        END.
        ELSE IF filine = "2" THEN DO:  /*-- IAR --*/
            IF xmm031.dept <> "K" THEN NEXT.
        END.
        ELSE IF filine = "4" THEN DO:  /*-- ALL --*/
            IF xmm031.dept = "M" OR 
               xmm031.dept = "G" THEN NEXT.
        END.
    END.
    ELSE DO:
        IF filine = "3" THEN  DO:     /*-- MISC --*/
            FOR EACH s0m005 WHERE s0m005.key1 = "MISC" NO-LOCK:
                IF SUBSTRING(s0m005.key2,1,2) <> SUBSTRING(clm130.claim,3,2) THEN NEXT.
            END.
        END.
    END.

    IF fiType = "2" THEN DO:
        FIND clm120 USE-INDEX clm12001 WHERE
             clm120.claim  = clm130.claim  AND
             clm120.clmant = clm130.clmant AND
             clm120.clitem = clm130.clitem NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL clm120 THEN DO:
            IF clm120.loss <> "FD" THEN NEXT.
        END.
    END.

    FIND clm100 USE-INDEX clm10001 WHERE
         clm100.claim = clm130.claim NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm100 THEN DO:
        CREATE wclm130.
        ASSIGN
            WCLM130.BRANCH = nv_br 
            WCLM130.POLICY = CLM100.POLICY      
            WCLM130.CLAIM  = CLM130.CLAIM
            WCLM130.ENTDAT = CLM130.ENTDAT
            WCLM130.TRNDAT = CLM130.TRNDAT
            WCLM130.TRNTY1 = CLM130.TRNTY1
            WCLM130.DOCNO  = CLM130.DOCNO
            WCLM130.CLITEM = CLM130.CLITEM
            WCLM130.CLMANT = CLM130.CLMANT
            WCLM130.CPC_CD = CLM130.CPC_CD
            WCLM130.NETL_D = CLM130.NETL_D
            WCLM130.RELEAS = CLM130.RELEAS.

        IF LENGTH(nv_br) = 2 THEN 
             WCLM130.DIR_RI = "D".
        ELSE WCLM130.DIR_RI = SUBSTRING(CLM100.POLICY,1,1).

        /* WCLM130.POLTYP */
        FIND FIRST UWM100   WHERE
                   UWM100.POLICY = CLM100.POLICY NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE UWM100 THEN
           WCLM130.POLTYP = UWM100.POLTYP.
        
        /* WCLM130.GROUPTYP */
        FIND S0M005 USE-INDEX S0M00501    WHERE
             S0M005.KEY2 = WCLM130.POLTYP NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE S0M005 THEN
           WCLM130.GROUPTYP = S0M005.KEY1.

    END. /*clm100*/

END. /*clm130*/

FIND FIRST WCLM130 NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE WCLM130 THEN DO:
  
  MESSAGE "Not found Data Process" VIEW-AS ALERT-BOX INFORMATION.
  RETURN.

END.

FOR EACH wclm130 NO-LOCK BREAK BY wclm130.DIR_ri
                               BY wclm130.branch
                               BY SUBSTRING(wclm130.poltyp,2,2)
                               BY wclm130.policy
                               BY wclm130.entdat:

    FIND FIRST clm100 WHERE clm100.claim = wclm130.claim NO-LOCK NO-ERROR.

    ASSIGN
        nv_coins  = NO
        nv_coper  = 0
        nv_comdat = ?
        nv_policy = ""
        nv_claim  = ""
        nv_poltyp = ""
        nv_group  = ""
        nv_insure = ""
        nv_locate = ""
        nv_losdat = ?.

    FIND LAST uwm100 USE-INDEX uwm10001 WHERE
              uwm100.policy = clm100.policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm100 THEN DO:
        nv_coins = uwm100.coins.

        IF uwm100.coins  =  YES AND
           uwm100.co_per <> 0   THEN
            nv_coper = 100 - uwm100.co_per.

        nv_comdat = uwm100.comdat.
    END.

    ASSIGN
        nv_policy  = wclm130.policy
        nv_claim   = wclm130.claim
        nv_poltyp  = wclm130.poltyp
        nv_group   = wclm130.grouptyp
        nv_insure  = clm100.ntitle + clm100.name1
        nv_locate  = TRIM(TRIM(clm100.losloc1) + " " + TRIM(clm100.losloc2))
        nv_losdat  = clm100.losdat.

    /*-- SUB CLASS --*/
    n_subclass = "".
    FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
               uwm120.policy = clm100.policy AND
               uwm120.rencnt = clm100.rencnt AND
               uwm120.endcnt = clm100.endcnt AND 
               uwm120.riskgp = clm100.riskgp AND
               uwm120.riskno = clm100.riskno NO-LOCK NO-ERROR.
    IF AVAIL uwm120 THEN DO:
        n_subclass = uwm120.CLASS.
    END.

    /*--- หาอำเภอ จังหวัด ---*/
    ASSIGN
        n_occupy = ""
        n_distct = ""
        n_provi  = ""
        n_ltext  = "".

    FIND FIRST uwm304 USE-INDEX uwm30401 WHERE
               uwm304.policy = uwm100.policy AND
               uwm304.rencnt = uwm100.rencnt AND
               uwm304.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
    IF AVAIL uwm304 THEN DO:
    
        n_occupy = uwm304.occupy.
    
        IF uwm304.fptr02 <> 0 THEN DO:
            FIND uwd141 WHERE RECID(uwd141) = uwm304.fptr02 NO-LOCK NO-ERROR.
            IF AVAIL uwd141 THEN DO:
                IF uwd141.prov_n <> "" THEN DO:
                    FIND uwm500 USE-INDEX uwm50001 WHERE 
                         uwm500.prov_n = uwd141.prov_n NO-LOCK NO-ERROR.
                    IF AVAIL uwm500 THEN DO:
                        n_provi = uwm500.prov_d.
                    END.
                END.
                
                IF uwd141.dist_n <> "" THEN DO:
                    FIND uwm501 USE-INDEX uwm50101 WHERE 
                         uwm501.prov_n = uwd141.prov_n AND
                         uwm501.dist_n = uwd141.dist_n NO-LOCK NO-ERROR.
                    IF AVAIL uwm501 THEN DO:
                        n_distct = uwm501.dist_d.
                    END.
                END.
            END. /*AVAIL uwd141*/    
        END.  /*uwm304.fptr02 <> 0*/
    
        IF uwm304.fptr01 <> 0 THEN DO:
            FIND uwd140 WHERE RECID(uwd140) = uwm304.fptr01 NO-LOCK NO-ERROR.
            REPEAT:
                n_fptr01 = uwd140.fptr.
                n_ltext  = uwd140.ltext.
                IF INDEX(uwd140.ltext,"Estate Code :") <> 0 THEN DO:
                    nv_ltxt1 = INDEX(uwd140.ltext , "Estate Code :") + 13.
                    nv_ltxt2 = LENGTH(n_ltext) - nv_ltxt1. 
                    n_ltext  = TRIM(SUBSTRING(uwd140.ltext,nv_ltxt1,nv_ltxt2 + 1)).
                END.
    
                IF n_fptr01 = 0 THEN LEAVE.
                FIND uwd140 WHERE RECID(uwd140) = n_fptr01 NO-ERROR.
            END. /*REPEAT*/
        END.
    END. /*AVAIL uwm304*/

    /*---- หา status ----*/
    ASSIGN
        n_line = 0
        nv_text = "".

    FIND FIRST clm110 USE-INDEX clm11001 WHERE
               clm110.claim  = clm100.claim NO-LOCK NO-ERROR.
    IF AVAIL clm110 THEN DO:
        IF clm110.fptr01 <> 0 AND clm110.fptr01 <> ? THEN DO:
            FIND cld110 WHERE RECID(cld110) = clm110.fptr01 NO-LOCK NO-ERROR.
            REPEAT:
                n_fptr = cld110.fptr.
                IF n_line <= 3 THEN nv_text = nv_text + cld110.ltext.
                IF cld110.fptr = 0 OR n_line = 3 THEN LEAVE.
                n_line = n_line + 1.
                FIND cld110 WHERE RECID(cld110) = n_fptr NO-LOCK NO-ERROR.
            END.
        END.
    END.

    n_si = 0.
    n_epaid = 0.
    n_bpaid = 0.
    nv_paid = 0.
    nv_eos  = 0.
    nv_bos  = 0.

    FIND clm120 USE-INDEX clm12001 WHERE
         clm120.claim  = wclm130.claim  AND
         clm120.clmant = wclm130.clmant AND
         clm120.clitem = wclm130.clitem NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL clm120 THEN NEXT.
    ELSE DO:
        nv_nature = clm120.loss.
        n_si      = clm120.si.
        nv_status = SUBSTRING(TRIM(clm120.styp20),1,1).

        IF wclm130.cpc_cd = "EPD" AND wclm130.trnty1 = "X" THEN DO:
            IF clm120.loss = "FE" OR clm120.loss = "EX" THEN DO:
                IF wclm130.netl_d <> ? THEN
                    n_epaid = n_epaid + wclm130.netl_d. /*FEE Nature FE EX*/
            END.
            ELSE IF clm120.loss = "BU" THEN DO:
                IF wclm130.netl_d <> ? THEN
                    n_bpaid = n_bpaid + wclm130.netl_d.  /*BI Nature BU*/
            END.
            ELSE DO:
                IF wclm130.netl_d <> ? THEN
                    nv_paid  = nv_paid + wclm130.netl_d.  /* Paid Not Nature BU FE EX */
            END.
        END.
        ELSE DO:
            IF clm120.loss = "FE" OR clm120.loss = "EX" THEN DO:
                IF wclm130.netl_d <> ? THEN
                    nv_eos = nv_eos + wclm130.netl_d. /*FEE OS Nature FE EX*/
            END.
            ELSE IF clm120.loss = "BU" THEN DO:
                IF wclm130.netl_d <> ? THEN
                    nv_bos = nv_bos + wclm130.netl_d.  /*BI OS Nature BU*/
            END.
        END.
    END.

    ASSIGN
        nv_total  = 0
        nv_etotal = 0.

    IF clm120.loss = "FE" OR clm120.loss = "EX" THEN DO:
        nv_etotal  = WCLM130.NETL_D.  /* Fee & Expense */
        nv_fex     = YES.
    END.
    ELSE DO:
        nv_total   = WCLM130.NETL_D.  /* Paid */
        nv_fex     = NO.
    END.

    /*--- PAID ---*/
    nv_res   = 0.

    FOR EACH clm131 USE-INDEX clm13101 WHERE
             clm131.claim  = wclm130.claim  AND
             clm131.clmant = wclm130.clmant AND
             clm131.clitem = wclm130.clitem AND
             clm131.cpc_cd = "EPD"         NO-LOCK:

        IF clm131.res <> ? THEN DO:
            nv_res = nv_res + clm131.res.
        END.

    END.

    /*--- OS ---*/
    ASSIGN
        nv_os     = 0
        n_paid_d  = 0
        nv_os_d   = 0.

    IF nv_status = "F"  THEN nv_os = 0. 
    ELSE nv_os = nv_res - nv_paid.
    IF clm100.padsts = "F"  THEN nv_OS = 0.

    n_paid_d = n_epaid + n_bpaid + nv_paid.
    nv_os_d  = nv_eos + nv_bos + nv_os.

    FIND clm200 USE-INDEX clm20001 WHERE
         clm200.trnty1  = wclm130.trnty1 AND
         clm200.docno   = wclm130.docno   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm200 THEN DO:
        FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                   xmm600.acno = clm200.acno NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm600 THEN DO:
            ASSIGN
                nv_netvat = 0
                nv_vat    = 0
                nv_tax    = 0
                nv_netamt = 0.

            IF nv_fex = NO THEN DO:
                CASE xmm600.clicod:
                    WHEN "EX" THEN DO:  /* EX : External Survey */
                        IF nv_total < 1000 THEN
                            ASSIGN
                                nv_netvat  = nv_total / (1.07)
                                nv_vat     = nv_total - nv_netvat
                                nv_tax     = 0
                                nv_netamt  = nv_total.
                        ELSE 
                            ASSIGN
                                nv_netvat  = nv_total / (1.07)
                                nv_vat     = nv_total - nv_netvat
                                nv_tax     = nv_netvat * (0.03)
                                nv_netamt  = nv_total - nv_tax.
                    END. /*"EX"*/
                    WHEN "HN" THEN DO:
                        IF nv_total < 1000 THEN
                            ASSIGN
                                nv_vat     = 0
                                nv_tax     = 0
                                nv_netamt  = nv_total.
                        ELSE
                            ASSIGN
                                nv_tax     = nv_total * (0.03)
                                nv_netamt  = nv_total - nv_tax.
                    END. /*"HN"*/
                    OTHERWISE nv_netamt = nv_total. /*--- ค่าที่ออกยอดเต็ม ---*/
                END CASE.
            END. /*nv_fex = NO*/
            ELSE DO:
                CASE xmm600.clicod :
                    WHEN "EX" THEN DO:  /* EX : External Survey */
                        IF nv_etotal < 1000 THEN
                            ASSIGN
                                nv_netvat  = nv_etotal / (1.07)
                                nv_vat     = nv_etotal - nv_netvat
                                nv_tax     = 0
                                nv_netamt  = nv_etotal.
                        ELSE
                            ASSIGN
                                nv_netvat  = nv_etotal / (1.07)
                                nv_vat     = nv_etotal - nv_netvat
                                nv_tax     = nv_netvat * (0.03)
                                nv_netamt  = nv_etotal - nv_tax.
                    END.
                    WHEN "HN" THEN DO:  /* HN : Hospital With TAX */
                        IF nv_etotal < 1000 THEN
                            ASSIGN
                                nv_vat     = 0
                                nv_tax     = 0
                                nv_netamt  = nv_etotal.
                        ELSE
                            ASSIGN
                                nv_tax     = nv_etotal * (0.03)
                                nv_netamt  = nv_etotal - nv_tax.
                    END.
                    OTHERWISE nv_netamt = nv_etotal. /*--- ค่าที่ออกยอดเต็ม ---*/
                END CASE.
            END.
        END.  /*FIND XMM600*/
    END.  /*FIND CLM200*/

    /*------------   Find  Reinsurance   -------------*/
    ASSIGN
        nv_facri   = 0    nv_1st    = 0
        nv_2nd     = 0    nv_qs5    = 0
        nv_tfp     = 0    nv_eng    = 0
        nv_mar     = 0    nv_ret    = 0
        nv_xol     = 0    nv_rq     = 0

        nv_fo1     = 0    nv_fo2    = 0
        nv_fo3     = 0    nv_fo4    = 0
        nv_ftr     = 0

        nv_mps     = 0    nv_btr    = 0
        nv_otr     = 0    nv_gros   = 0

        nv_facl    = 0
        nv_facf    = 0
        nv_faca    = 0
        nv_facerr  = 0 .

    RUN PDCLM300.


    IF nv_netvat <> 0 THEN DO:  /*ถ้ามี Vat ช่อง Ret และ Gross Ret  คือ  Net Vat*/
        ASSIGN
          nv_ret  = nv_netvat
          nv_gros = nv_netvat.
    END.
    ELSE IF nv_netvat = 0 THEN DO:   /*ถ้าไม่มี vat ช่อง Ret  และ Gross Ret  คือ  total claim*/
        ASSIGN
          nv_ret  = nv_total
          nv_gros = nv_total. 
    END.

    n_paid_t = ((nv_rq * nv_paid) / 100).
    n_os_t   = ((nv_rq * nv_os) / 100).

    RUN PDRECORD2.

END. /*FOR EACH wclm130*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDReportTE C-Win 
PROCEDURE PDReportTE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH clm130 USE-INDEX clm13020 WHERE
         clm130.entdat >= fidate_fr AND
         clm130.entdat <= fidate_to /*AND
         clm130.trnty1  = "X"       AND
         clm130.releas  = YES     */  NO-LOCK:

    /*--- Check Branch ---*/
    nv_br = "".
    IF (SUBSTR(clm130.claim,1,1) = "D"   OR   /*Ex: D07050000001*/
        SUBSTR(clm130.claim,1,1) = "I")  THEN DO:
        nv_br  = SUBSTR(clm130.claim,2,1).
        IF nv_br < fiBranch_fr OR
           nv_br > fibranch_to THEN NEXT.
    END.
    ELSE IF (SUBSTR(clm130.claim,1,1) = "F"   OR 
             SUBSTR(clm130.claim,1,1) = "Z"   OR 
             SUBSTR(clm130.claim,1,1) = "N"   OR
             SUBSTR(clm130.claim,1,1) = "A"   OR
             SUBSTR(clm130.claim,1,1) = "B"   OR
             SUBSTR(clm130.claim,1,1) = "H")  THEN DO:
             IF LENGTH(clm130.claim)  = 11 THEN DO:  /*Ex: N1050000001*/
                 nv_br  = SUBSTR(clm130.claim,2,2).
                 IF nv_br < fibranch_fr OR
                    nv_br > fibranch_to THEN NEXT.
             END.
             ELSE DO: /*Ex: N050000001*/
                 nv_br  = SUBSTR(clm130.claim,2,1).  
                 IF nv_br < fibranch_fr AND
                    nv_br > fibranch_to THEN NEXT.
             END.
    END.
    ELSE DO: /*Ex: 107050000001*/
        nv_br  = SUBSTR(clm130.claim,1,2).
        IF nv_br < fibranch_fr OR
           nv_br > fibranch_to THEN NEXT.
    END.

    IF CLM130.NETL_D = 0  OR CLM130.NETL_D = ? THEN NEXT.

    /*--- Check Group Type ---*/
    FIND FIRST xmm031 USE-INDEX xmm03101 WHERE
               SUBSTRING(xmm031.poltyp,2,2) = SUBSTRING(clm130.claim,3,2) 
    NO-LOCK NO-ERROR.
    IF AVAIL xmm031 THEN DO:
        IF filine = "1" THEN DO:       /*-- FIRE --*/
            IF xmm031.dept <> "A" THEN NEXT.
        END.
        ELSE IF filine = "2" THEN DO:  /*-- IAR --*/
            IF xmm031.dept <> "K" THEN NEXT.
        END.
        ELSE IF filine = "4" THEN DO:  /*-- ALL --*/
            IF xmm031.dept = "M" OR 
               xmm031.dept = "G" THEN NEXT.
        END.
    END.
    ELSE DO:
        IF filine = "3" THEN  DO:     /*-- MISC --*/
            FOR EACH s0m005 WHERE s0m005.key1 = "MISC" NO-LOCK:
                IF SUBSTRING(s0m005.key2,1,2) <> SUBSTRING(clm130.claim,3,2) THEN NEXT.
            END.
        END.
    END.

    IF fiType = "1" THEN DO:
        FIND clm120 USE-INDEX clm12001 WHERE
             clm120.claim  = clm130.claim  AND
             clm120.clmant = clm130.clmant AND
             clm120.clitem = clm130.clitem NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL clm120 THEN DO:
            IF clm120.loss <> "TE" THEN NEXT.
        END.
    END.

    FIND clm100 USE-INDEX clm10001 WHERE
         clm100.claim = clm130.claim NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm100 THEN DO:
        CREATE wclm130.
        ASSIGN
            WCLM130.BRANCH = nv_br 
            WCLM130.POLICY = CLM100.POLICY      
            WCLM130.CLAIM  = CLM130.CLAIM
            WCLM130.ENTDAT = CLM130.ENTDAT
            WCLM130.TRNDAT = CLM130.TRNDAT
            WCLM130.TRNTY1 = CLM130.TRNTY1
            WCLM130.DOCNO  = CLM130.DOCNO
            WCLM130.CLITEM = CLM130.CLITEM
            WCLM130.CLMANT = CLM130.CLMANT
            WCLM130.CPC_CD = CLM130.CPC_CD
            WCLM130.NETL_D = CLM130.NETL_D
            WCLM130.RELEAS = CLM130.RELEAS.

        IF LENGTH(nv_br) = 2 THEN 
             WCLM130.DIR_RI = "D".
        ELSE WCLM130.DIR_RI = SUBSTRING(CLM100.POLICY,1,1).

        /* WCLM130.POLTYP */
        FIND FIRST UWM100   WHERE
                   UWM100.POLICY = CLM100.POLICY NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE UWM100 THEN
           WCLM130.POLTYP = UWM100.POLTYP.
        
        /* WCLM130.GROUPTYP */
        FIND S0M005 USE-INDEX S0M00501    WHERE
             S0M005.KEY2 = WCLM130.POLTYP NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE S0M005 THEN
           WCLM130.GROUPTYP = S0M005.KEY1.

    END. /*clm100*/

END. /*clm130*/

FIND FIRST WCLM130 NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE WCLM130 THEN DO:
  
  MESSAGE "Not found Data Process" VIEW-AS ALERT-BOX INFORMATION.
  RETURN.

END.

FOR EACH wclm130 NO-LOCK BREAK BY wclm130.DIR_ri
                               BY wclm130.branch
                               BY SUBSTRING(wclm130.poltyp,2,2)
                               BY wclm130.policy
                               BY wclm130.entdat:

    FIND FIRST clm100 WHERE clm100.claim = wclm130.claim NO-LOCK NO-ERROR.

    ASSIGN
        nv_coins  = NO
        nv_coper  = 0.

    FIND LAST uwm100 USE-INDEX uwm10001 WHERE
              uwm100.policy = clm100.policy NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm100 THEN DO:
        nv_coins = uwm100.coins.

        IF uwm100.coins  =  YES AND
           uwm100.co_per <> 0   THEN
            nv_coper = 100 - uwm100.co_per.

        nv_comdat = uwm100.comdat.
    END.

    ASSIGN
        nv_policy  = wclm130.policy
        nv_claim   = wclm130.claim
        nv_poltyp  = wclm130.poltyp
        nv_group   = wclm130.grouptyp
        nv_insure  = clm100.ntitle + clm100.name1
        nv_locate  = TRIM(TRIM(clm100.losloc1) + " " + TRIM(clm100.losloc2))
        nv_losdat  = clm100.losdat.

    /*-- SUB CLASS --*/
    FIND FIRST uwm120 USE-INDEX uwm12001 WHERE
               uwm120.policy = clm100.policy AND
               uwm120.rencnt = clm100.rencnt AND
               uwm120.endcnt = clm100.endcnt AND 
               uwm120.riskgp = clm100.riskgp AND
               uwm120.riskno = clm100.riskno NO-LOCK NO-ERROR.
    IF AVAIL uwm120 THEN DO:
        n_subclass = uwm120.CLASS.
    END.

    /*--- หาจังหวัด ----*/
    FIND FIRST uwm304 USE-INDEX uwm30401 WHERE
               uwm304.policy = clm100.policy AND
               uwm304.rencnt = clm100.rencnt AND
               uwm304.endcnt = clm100.endcnt AND
               uwm304.riskgp = clm100.riskgp AND
               uwm304.riskno = clm100.riskno NO-LOCK NO-ERROR.
    IF AVAIL uwm304 THEN DO:
        FIND uwd141 WHERE RECID(uwd141) = uwm304.fptr02 NO-LOCK NO-ERROR.
        IF AVAIL uwd141 THEN DO:
            IF uwd141.prov_n <> "" THEN DO:
                FIND uwm500 USE-INDEX uwm50001 WHERE 
                     uwm500.prov_n = uwd141.prov_n NO-LOCK NO-ERROR.
                IF AVAIL uwm500 THEN DO:
                    n_provi = uwm500.prov_d.
                END.
            END.
            
            IF uwd141.dist_n <> "" THEN DO:
                FIND uwm501 USE-INDEX uwm50101 WHERE 
                     uwm501.prov_n = uwd141.prov_n AND
                     uwm501.dist_n = uwd141.dist_n NO-LOCK NO-ERROR.
                IF AVAIL uwm501 THEN DO:
                    n_distct = uwm501.dist_d.
                END.
            END.
            
        END.
    END.

    /*---- หา status ----*/
    ASSIGN
        n_line = 0
        nv_text = "".

    FIND FIRST clm110 USE-INDEX clm11001 WHERE
               clm110.claim  = clm100.claim NO-LOCK NO-ERROR.
    IF AVAIL clm110 THEN DO:
        IF clm110.fptr01 <> 0 AND clm110.fptr01 <> ? THEN DO:
            FIND cld110 WHERE RECID(cld110) = clm110.fptr01 NO-LOCK NO-ERROR.
            REPEAT:
                n_fptr = cld110.fptr.
                IF n_line <= 3 THEN nv_text = nv_text + cld110.ltext.
                IF cld110.fptr = 0 OR n_line = 3 THEN LEAVE.
                n_line = n_line + 1.
                FIND cld110 WHERE RECID(cld110) = n_fptr NO-LOCK NO-ERROR.
            END.
        END.
    END.

    FIND clm120 USE-INDEX clm12001 WHERE
         clm120.claim  = wclm130.claim  AND
         clm120.clmant = wclm130.clmant AND
         clm120.clitem = wclm130.clitem NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL clm120 THEN NEXT.
    ELSE DO:
        nv_nature = clm120.loss.
        n_si      = clm120.si.
        nv_status = SUBSTRING(TRIM(clm120.styp20),1,1).
    END.

    ASSIGN
        nv_total  = 0
        nv_etotal = 0.

    IF clm120.loss = "FE" OR clm120.loss = "EX" THEN DO:
        nv_etotal  = WCLM130.NETL_D.  /* Fee & Expense */
        nv_fex     = YES.
    END.
    ELSE DO:
        nv_total   = WCLM130.NETL_D.  /* Paid */
        nv_fex     = NO.
    END.

    /*--- PAID ---*/
    n_bpaid  = 0.
    n_epaid  = 0.
    nv_bos   = 0.
    nv_eos   = 0.
    nv_res   = 0.

    FOR EACH clm131 USE-INDEX clm13101 WHERE
             clm131.claim  = clm130.claim  AND
             clm131.clmant = clm130.clmant AND
             clm131.clitem = clm130.clitem AND
             clm131.cpc_cd = "EPD"         NO-LOCK:

        IF clm131.res <> ? THEN DO:
            nv_res = nv_res + clm131.res.
        END.
 
        IF clm130.netl_d <> ? THEN DO:
            IF STRING(MONTH(clm130.entdat)) = STRING(MONTH(fiDate_to)) AND
               STRING(YEAR(clm130.entdat))  = STRING(YEAR(fiDate_to))  THEN DO:
                n_bpaid = n_bpaid  + clm130.netl_d.   /* Paid Amount ณ.เดือนที่เรียก */
            END.
            ELSE DO:
                n_epaid = n_epaid  + clm130.netl_d.   /* Paid Amount ก่อนหน้าเดือนที่เรียก*/
            END.
        END.  
    END.

    /*--- OS ---*/
    IF nv_status = "F"  THEN nv_os = 0. 
    ELSE nv_os = nv_res - n_epaid - n_bpaid.
    IF clm100.padsts = "F"  THEN nv_OS = 0.

    FIND clm200 USE-INDEX clm20001 WHERE
         clm200.trnty1  = wclm130.trnty1 AND
         clm200.docno   = wclm130.docno   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL clm200 THEN DO:
        FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                   xmm600.acno = clm200.acno NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL xmm600 THEN DO:
            ASSIGN
                nv_netvat = 0
                nv_vat    = 0
                nv_tax    = 0
                nv_netamt = 0.

            IF nv_fex = NO THEN DO:
                CASE xmm600.clicod:
                    WHEN "EX" THEN DO:  /* EX : External Survey */
                        IF nv_total < 1000 THEN
                            ASSIGN
                                nv_netvat  = nv_total / (1.07)
                                nv_vat     = nv_total - nv_netvat
                                nv_tax     = 0
                                nv_netamt  = nv_total.
                        ELSE 
                            ASSIGN
                                nv_netvat  = nv_total / (1.07)
                                nv_vat     = nv_total - nv_netvat
                                nv_tax     = nv_netvat * (0.03)
                                nv_netamt  = nv_total - nv_tax.
                    END. /*"EX"*/
                    WHEN "HN" THEN DO:
                        IF nv_total < 1000 THEN
                            ASSIGN
                                nv_vat     = 0
                                nv_tax     = 0
                                nv_netamt  = nv_total.
                        ELSE
                            ASSIGN
                                nv_tax     = nv_total * (0.03)
                                nv_netamt  = nv_total - nv_tax.
                    END. /*"HN"*/
                    OTHERWISE nv_netamt = nv_total. /*--- ค่าที่ออกยอดเต็ม ---*/
                END CASE.
            END. /*nv_fex = NO*/
            ELSE DO:
                CASE xmm600.clicod :
                    WHEN "EX" THEN DO:  /* EX : External Survey */
                        IF nv_etotal < 1000 THEN
                            ASSIGN
                                nv_netvat  = nv_etotal / (1.07)
                                nv_vat     = nv_etotal - nv_netvat
                                nv_tax     = 0
                                nv_netamt  = nv_etotal.
                        ELSE
                            ASSIGN
                                nv_netvat  = nv_etotal / (1.07)
                                nv_vat     = nv_etotal - nv_netvat
                                nv_tax     = nv_netvat * (0.03)
                                nv_netamt  = nv_etotal - nv_tax.
                    END.
                    WHEN "HN" THEN DO:  /* HN : Hospital With TAX */
                        IF nv_etotal < 1000 THEN
                            ASSIGN
                                nv_vat     = 0
                                nv_tax     = 0
                                nv_netamt  = nv_etotal.
                        ELSE
                            ASSIGN
                                nv_tax     = nv_etotal * (0.03)
                                nv_netamt  = nv_etotal - nv_tax.
                    END.
                    OTHERWISE nv_netamt = nv_etotal. /*--- ค่าที่ออกยอดเต็ม ---*/
                END CASE.
            END.
        END.  /*FIND XMM600*/
    END.  /*FIND CLM200*/

    /*------------   Find  Reinsurance   -------------*/
    ASSIGN
        nv_facri   = 0    nv_1st    = 0
        nv_2nd     = 0    nv_qs5    = 0
        nv_tfp     = 0    nv_eng    = 0
        nv_mar     = 0    nv_ret    = 0
        nv_xol     = 0    nv_rq     = 0

        nv_fo1     = 0    nv_fo2    = 0
        nv_fo3     = 0    nv_fo4    = 0
        nv_ftr     = 0

        nv_mps     = 0    nv_btr    = 0
        nv_otr     = 0    nv_gros   = 0

        nv_facl    = 0
        nv_facf    = 0
        nv_faca    = 0
        nv_facerr  = 0 .

    RUN PDCLM300.

    IF nv_netvat <> 0 THEN DO:  /*ถ้ามี Vat ช่อง Ret และ Gross Ret  คือ  Net Vat*/
        ASSIGN
          nv_ret  = nv_netvat
          nv_gros = nv_netvat.
    END.
    ELSE IF nv_netvat = 0 THEN DO:   /*ถ้าไม่มี vat ช่อง Ret  และ Gross Ret  คือ  total claim*/
        ASSIGN
          nv_ret  = nv_total
          nv_gros = nv_total. 
    END.

    RUN PDRECORD1.

END. /*FOR EACH wclm130*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

