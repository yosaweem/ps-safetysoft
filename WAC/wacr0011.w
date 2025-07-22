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

  Created: Benjaporn J. [A60-0162] date 04/04/2017 
        -  เพื่อใช้สำหรับทำรายงานของ QS(BH)  

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
/* Modify By :  Saowapa U. A61-0460 [25/09/2018]   */    
/*           : ขอเพิ่มcolumn com.date (วันเริ่มคุ้มครอง)ในทะเบียนเคลม  */
/* Modify By : Jiraphon P. A63-0524  Date : 24/12/2020
             : เพิ่มจำนวนหลักเลข REQ.NO. เป็น 10 หลัก */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---    
                                   */
DEF VAR vFirstTime  AS CHAR  INIT "".
DEF VAR vLastTime   AS CHAR  INIT "".
DEF VAR nv_poltyp   AS CHAR  FORMAT "X(1)".
DEF VAR nv_poltype  AS CHAR  FORMAT "x(15)" .
DEF VAR nv_branfr   AS CHAR  FORMAT "x(2)".
DEF VAR nv_branto   AS CHAR  FORMAT "x(2)".
DEF VAR nv_datefr   AS DATE  FORMAT "99/99/9999".
DEF VAR nv_dateto   AS DATE  FORMAT "99/99/9999".
DEF VAR nv_output   AS CHAR  FORMAT "X(20)".

DEF VAR n_releas   AS CHAR FORMAT "X(5)".
DEF VAR n_bdes     AS CHAR FORMAT "X(25)".
DEF VAR n_poltyp   AS CHAR FORMAT "X(1)".
DEF VAR n_claim    AS CHAR FORMAT "x(17)".
DEF VAR n_seq      AS INT  FORMAT ">>9".
DEF VAR n_losamt   AS DECI FORMAT ">>>,>>>,>>9.99-" .

DEF VAR n_vat      AS DECI FORMAT "->>,>>>,>>9.99" .   /*-- vat --*/
DEF VAR n_netvat   AS DECI FORMAT "->,>>>,>>>,>>>,>>>,>>9.99".  /*--netvat --*/
DEF VAR n_tax      AS DECI FORMAT "->,>>>,>>>,>>>,>>9.99" .     /*-- tax --*/
DEF VAR n_netamt   AS DECI FORMAT "->>,>>>,>>9.99".
DEF VAR n_vtype    AS CHAR INIT   "VR".
DEF VAR n_paycd    AS CHAR FORMAT "x(2)".
DEF VAR n_vatrate  AS DECI.
DEF VAR n_taxrate  AS DECI.

DEF VAR n_gpamt    AS DECI FORMAT ">,>>>,>>>,>>9.99-" .
DEF VAR n_epamt    AS DECI FORMAT ">,>>>,>>>,>>9.99-" .
DEF VAR n_totlos   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" .
DEF VAR n_status   AS CHAR FORMAT "x(1)".
DEF VAR n_policy   AS CHAR FORMAT "x(9)".
DEF VAR n_losdat   AS CHAR FORMAT "X(10)".
DEF VAR n_paddat   AS CHAR FORMAT "X(10)".
DEF VAR n_entdat   AS CHAR FORMAT "X(10)".
DEF VAR n_insnam   AS CHAR FORMAT "X(35)".  /* insured  */
DEF VAR n_recnam   AS CHAR FORMAT "X(10)".  /* receive  */    
DEF VAR n_detail   AS CHAR FORMAT "X(70)".  /* Cheque receiver detail*/   
DEF VAR n_adjnam   AS CHAR FORMAT "X(20)".  /* surveyor */
DEF VAR n_agtnam   AS CHAR FORMAT "X(35)".  /* Producer */
DEF VAR n_nature   AS CHAR FORMAT "X(30)".  /* Nature   */
DEF VAR n_loss     AS CHAR FORMAT "X(105)". /* Cause of Loss */ 

DEF VAR n_acno     AS CHAR FORMAT "X(10)".
DEF VAR n_acno1    AS CHAR FORMAT "X(10)".
DEF VAR n_refno    AS CHAR FORMAT "X(10)".
DEF VAR n_intref   AS CHAR FORMAT "X(10)".

/*DEF VAR n_prtdoc   AS CHAR FORMAT "X(9)".  comment A63-0524*/
DEF VAR n_prtdoc   AS CHAR FORMAT "X(12)".   /*Add Jiraphon P. A63-0524*/
DEF VAR n_padby    AS CHAR FORMAT "X(14)".
DEF VAR n_action   AS CHAR FORMAT "X(13)".
DEF VAR n_langug   AS CHAR FORMAT "X(1)".
DEF VAR n_moddes   AS CHAR FORMAT "X(30)".
DEF VAR n_vehreg   AS CHAR FORMAT "X(20)".
DEF VAR n_clmveh   AS CHAR FORMAT "X(30)".
DEF VAR n_prtadj   AS CHAR FORMAT "X(36)".
DEF VAR n_recadd   AS CHAR FORMAT "X(100)".
DEF VAR n_remark   AS CHAR FORMAT "X(30)".
DEF VAR n_flag     LIKE    clm200.releas.

DEF VAR nv_clicod  AS CHAR FORMAT "X(2)"  INIT "".
DEF VAR nv_head1   AS CHAR FORMAT "X(75)" INIT "".
DEF VAR nv_head2   AS CHAR FORMAT "X(75)" INIT "".
DEF VAR nv_head3   AS CHAR FORMAT "X(75)" INIT "".

DEF VAR nv_branch  AS   CHAR FORMAT "X(2)" INIT "".
DEF VAR nv_line    AS   INT           INIT 0.
DEF VAR nv_total   LIKE clm130.netl_d INIT 0.
DEF VAR n_cheque   AS CHAR FORMAT "X(30)".
DEF VAR n_paydet1  AS CHAR FORMAT "X(50)".
DEF VAR nv_row     AS INTE INIT 1.
DEF VAR nv_br      AS CHAR FORMAT "X(2)".
DEF VAR n_dir_ri   AS CHAR FORMAT "X".  
DEF VAR n_retper   LIKE clm300.risi_p.
DEF VAR n_retamt   LIKE clm131.res.  

DEF VAR n_facri        AS DECI  FORMAT "->>>,>>>,>>>,>>9.99".   
DEF VAR nv_policstno   AS CHAR  FORMAT "x(10)" INIT "".         
DEF VAR nv_policstnam  AS CHAR  FORMAT "x(60)" INIT "".         
DEF VAR nv_Naturest    AS CHAR  FORMAT "x"     INIT "".   
DEF VAR nv_rvdat       AS CHAR  FORMAT "x(80)"  .
DEF VAR nv_rvno        AS CHAR  FORMAT "x(80)"  .

DEF STREAM ns1.                              

DEFINE WORKFILE wclm130 NO-UNDO
  FIELD pay         AS   CHAR FORMAT "X"
  FIELD clicod      LIKE xmm600.clicod
  FIELD acno        LIKE clm200.acno
  FIELD branch      LIKE uwm100.branch
  FIELD paddat      LIKE clm130.trndat
  FIELD trnty1      LIKE clm130.trnty1
  FIELD docno       LIKE clm130.docno
  FIELD claim       LIKE clm130.claim
  FIELD clmant      LIKE clm130.clmant
  FIELD clitem      LIKE clm130.clitem
  FIELD cpc_cd      LIKE clm130.cpc_cd.

DEFINE WORKFILE sumbrn NO-UNDO
  FIELD branch      LIKE uwm100.branch
  FIELD totnet      LIKE clm130.netl_d.

DEF VAR nr_trandat  AS DATE  FORMAT "99/99/9999". /*fai*/
DEF VAR nr_comdate  AS DATE  FORMAT "99/99/9999". 
DEF VAR nr_agent1   AS CHAR  FORMAT "X(30)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frmain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_branfr fi_branto fi_datefr fi_dateto ~
fi_poltyp fi_output bt_ok bt_cancel fi_disp RECT-4 RecOK RECT-5 RECT-7 ~
RECT-8 
&Scoped-Define DISPLAYED-OBJECTS fi_branfr fi_branto fi_datefr fi_dateto ~
fi_poltyp fi_output fi_disp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt_cancel 
     LABEL "CANCEL" 
     SIZE 15 BY 1.52
     FONT 2.

DEFINE BUTTON bt_ok 
     LABEL "OK" 
     SIZE 15 BY 1.52
     FGCOLOR 7 FONT 2.

DEFINE VARIABLE fi_branfr AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_branto AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_datefr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_dateto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_disp AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 26.5 BY 1
     BGCOLOR 18 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 33.67 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(1)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 36 BY 2.71
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 33.33 BY 4.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 60.5 BY 3.95
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 60.5 BY 2.14
     BGCOLOR 32 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 47 BY 2.71
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     fi_branfr AT ROW 4.95 COL 44 COLON-ALIGNED NO-LABEL
     fi_branto AT ROW 6.29 COL 44 COLON-ALIGNED NO-LABEL
     fi_datefr AT ROW 9.38 COL 39.83 COLON-ALIGNED NO-LABEL
     fi_dateto AT ROW 10.62 COL 39.83 COLON-ALIGNED NO-LABEL
     fi_poltyp AT ROW 12.71 COL 35.17 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 15.81 COL 12.17 COLON-ALIGNED NO-LABEL
     bt_ok AT ROW 15.19 COL 53.33
     bt_cancel AT ROW 15.19 COL 70.67
     fi_disp AT ROW 17.67 COL 31.17 NO-LABEL
     "   Branch :" VIEW-AS TEXT
          SIZE 12.5 BY .76 AT ROW 3.76 COL 28.33
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "From :" VIEW-AS TEXT
          SIZE 9.5 BY 1.19 AT ROW 4.91 COL 36
          BGCOLOR 3 FONT 2
     "  Output :" VIEW-AS TEXT
          SIZE 11.33 BY .76 AT ROW 14.86 COL 3.17
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "To :" VIEW-AS TEXT
          SIZE 6.5 BY 1.19 AT ROW 15.71 COL 7.33
          BGCOLOR 3 FGCOLOR 0 FONT 2
     "             CLAIM RECOVERY BY ENTRY DATE FOR ACCOUNT" VIEW-AS TEXT
          SIZE 89 BY 1.52 AT ROW 1.48 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 2
     "1 = Motor , 2 = Non motor , 3 = all" VIEW-AS TEXT
          SIZE 28 BY 1.19 AT ROW 12.67 COL 47.83
          BGCOLOR 32 FGCOLOR 0 
     "Policy Type :" VIEW-AS TEXT
          SIZE 18.5 BY 1.19 AT ROW 12.67 COL 17.67
          BGCOLOR 32 FGCOLOR 0 FONT 2
     "From :" VIEW-AS TEXT
          SIZE 9.17 BY 1.19 AT ROW 9.38 COL 32.33
          BGCOLOR 32 FGCOLOR 0 FONT 2
     " To :" VIEW-AS TEXT
          SIZE 7.17 BY 1.19 AT ROW 10.57 COL 33.67
          BGCOLOR 32 FGCOLOR 0 FONT 2
     "   Entry Date :" VIEW-AS TEXT
          SIZE 15 BY .76 AT ROW 8.52 COL 15.5
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 7.5 BY 1.19 AT ROW 6.19 COL 37.33
          BGCOLOR 3 FONT 2
     RECT-4 AT ROW 3.38 COL 28.67
     RecOK AT ROW 14.57 COL 51.5
     RECT-5 AT ROW 8.14 COL 15.83
     RECT-7 AT ROW 12.14 COL 15.83
     RECT-8 AT ROW 14.57 COL 3.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 89.17 BY 18.24
         BGCOLOR 18 .


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
         HEIGHT             = 18.19
         WIDTH              = 88.83
         MAX-HEIGHT         = 45.81
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.81
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
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_disp IN FRAME frmain
   ALIGN-L                                                              */
ASSIGN 
       fi_disp:HIDDEN IN FRAME frmain           = TRUE.

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


&Scoped-define SELF-NAME bt_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_cancel C-Win
ON CHOOSE OF bt_cancel IN FRAME frmain /* CANCEL */
DO:
    RUN  WAC\WACDISFN .

    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_ok C-Win
ON CHOOSE OF bt_ok IN FRAME frmain /* OK */
DO:

  IF fi_branfr = "" THEN DO:
     MESSAGE " ** Please Enter Branch From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_branfr IN FRAM frmain.
     RETURN NO-APPLY.
  END.


  IF fi_branto = "" THEN DO:
     MESSAGE " ** Please Enter Branch To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_branto IN FRAM frmain.
     RETURN NO-APPLY.
  END.


  IF fi_datefr = ? THEN DO:
     MESSAGE " ** Please Enter Trandate From. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_datefr IN FRAM frmain.
     RETURN NO-APPLY.
  END.


  IF fi_dateto = ? THEN DO:
     MESSAGE " ** Please Enter Trandate To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_dateto IN FRAM frmain.
     RETURN NO-APPLY.
  END.


  IF fi_poltyp <> "1" AND   
     fi_poltyp <> "2" AND   
     fi_poltyp <> "3" THEN DO:
     MESSAGE " ** Please Enter Policy Type. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_poltyp IN FRAM frmain.
     RETURN NO-APPLY.
  END.
  

  IF fi_output = "" THEN DO:
     MESSAGE " ** Please Enter Output To. ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_output IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF fi_poltyp = "1" THEN nv_poltype = "Motor" .
  IF fi_poltyp = "2" THEN nv_poltype = "Non Motor" .
  IF fi_poltyp = "3" THEN nv_poltype = "Motor & Non Motor" .


  MESSAGE "CLAIM RECOVERY FOR ACCOUNT"     SKIP(1)
          "วันที่ : " STRING(fi_datefr,"99/99/9999")     SKIP(1)
          "ถึงวันที่ : " STRING(fi_dateto,"99/99/9999")  SKIP(1)
          "Policy Type : " nv_poltype

  VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
  UPDATE CHOICE AS LOGICAL.
  CASE CHOICE:
       WHEN TRUE THEN DO:

           fi_disp = "   Processing  ...! " .
           DISP  fi_disp  WITH FRAME frmain . 

           RUN PD_head .
         
           fi_disp = "   .. complete ..  ".
           DISP  fi_disp  WITH FRAME frmain .
           
         MESSAGE ".. Complete .."  SKIP(1)
             "Time  : "  vFirstTime "  -  " vLastTime VIEW-AS ALERT-BOX.

       END.

       WHEN FALSE THEN DO:
       RETURN NO-APPLY.

       END.
  END CASE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branfr C-Win
ON LEAVE OF fi_branfr IN FRAME frmain
DO:
  fi_branfr = CAPS(INPUT fi_branfr).
    nv_branfr = fi_branfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branto C-Win
ON LEAVE OF fi_branto IN FRAME frmain
DO:
  fi_branto = CAPS(INPUT fi_branto).
    nv_branto = fi_branto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datefr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datefr C-Win
ON LEAVE OF fi_datefr IN FRAME frmain
DO:
  fi_datefr = INPUT fi_datefr.
    nv_datefr = fi_datefr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dateto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dateto C-Win
ON LEAVE OF fi_dateto IN FRAME frmain
DO:
  fi_dateto = INPUT fi_dateto.
    nv_dateto = fi_dateto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME frmain
DO:
  fi_output = INPUT fi_output.
    nv_output = fi_output.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp C-Win
ON LEAVE OF fi_poltyp IN FRAME frmain
DO:
  fi_poltyp = INPUT fi_poltyp.
    nv_poltyp = fi_poltyp.
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

  DEF VAR gv_prog  AS CHAR FORMAT "x(30)".
  DEF VAR gv_prgid AS CHAR FORMAT "x(15)".

  gv_prgid = "WACR0011".
  gv_prog  = "Claim Recovery By Entry Date For Account".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
  RUN  wac\wacconfn .
 
  DO WITH FRAME frmain :

     ASSIGN fi_branfr = "0"
            fi_branto = "Z"
            fi_poltyp = "3"
            fi_datefr = TODAY
            fi_dateto = TODAY .
     
     DISP fi_poltyp fi_branfr fi_branto
          fi_datefr fi_dateto .
     
     ASSIGN  nv_branfr  = fi_branfr
             nv_branto  = fi_branto
             nv_poltyp  = fi_poltyp
             nv_datefr  = fi_datefr
             nv_dateto  = fi_dateto .
  END.

  SESSION:DATA-ENTRY-RETURN = YES.

  RUN enable_UI.

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
  DISPLAY fi_branfr fi_branto fi_datefr fi_dateto fi_poltyp fi_output fi_disp 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE fi_branfr fi_branto fi_datefr fi_dateto fi_poltyp fi_output bt_ok 
         bt_cancel fi_disp RECT-4 RecOK RECT-5 RECT-7 RECT-8 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Claimant C-Win 
PROCEDURE PD_Claimant :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_remark = "".
  FIND FIRST acm001  USE-INDEX acm00104       WHERE
             acm001.policy  = clm100.policy   AND
             acm001.trnty1  = "M"             NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL acm001  THEN DO:
      n_cheque = TRIM(acm001.cheque) . 
    IF acm001.netloc  = acm001.baloc  THEN
            n_remark  =  STRING(MONTH(acm001.trndat)) + "/"  +
                         STRING(YEAR(acm001.trndat)).
    ELSE DO:
      IF acm001.baloc = 0 THEN 
            n_remark  = "R".
      ELSE  n_remark  = "P" + STRING(MONTH(acm001.trndat)) + "/" +
                              STRING(YEAR(acm001.trndat)).
    END.
  END. 

  n_nature = "" .
  FIND sym100 USE-INDEX sym10001     WHERE
       sym100.tabcod = "U078"        AND
       sym100.itmcod = clm130.patycd NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL sym100 THEN n_nature = sym100.itmdes.

  n_adjnam = "".      

  /* surveyor */
  FIND FIRST xtm600 USE-INDEX xtm60001  WHERE
             xtm600.acno = n_intref     NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL xtm600 THEN  n_adjnam = TRIM(TRIM(xtm600.ntitle) + " " + 
                                        TRIM(xtm600.name)).
  ELSE DO:
    FIND FIRST xmm600 USE-INDEX xmm60001  WHERE
               xmm600.acno = n_intref     NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xmm600 THEN n_adjnam = TRIM(TRIM(xmm600.ntitle) + " " + 
                                         TRIM(xmm600.name)).
  END.

  /* end Surveyor */
  IF   clm100.s_no <> " " THEN
       n_prtadj = STRING(TRIM(n_adjnam) + "(" + clm100.s_no + ")" ).
  ELSE n_prtadj = n_adjnam.

  ASSIGN
  n_langug = "T"
  n_acno1  = ""
  nr_trandat = ?. 
  nr_comdate = ?. 

  FIND FIRST uwm100 USE-INDEX  uwm10001       WHERE
             uwm100.policy   = clm100.policy  AND
             uwm100.rencnt   = clm100.rencnt  AND
             uwm100.endcnt   = clm100.endcnt  NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL uwm100 THEN DO:
     n_langug = uwm100.langug.
     n_acno1  = uwm100.acno1.
     nr_trandat = uwm100.trndat. /*fai*/
     nr_comdate = uwm100.comdat.
  END.

  n_agtnam = "". 

  /* Producer */
  IF n_langug = "" THEN DO:
    FIND FIRST xmm600 USE-INDEX xmm60001  WHERE
               xmm600.acno = n_acno1      NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xmm600 THEN n_agtnam = TRIM(TRIM(xmm600.ntitle) + " " +
                                         TRIM(xmm600.name)).
    ELSE DO:
      FIND FIRST xtm600 USE-INDEX xtm60001  WHERE
                 xtm600.acno = n_acno1      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xtm600 THEN n_agtnam = TRIM(TRIM(xtm600.ntitle) + " " +
                                           TRIM(xtm600.name)).
    END.
  END.

  ELSE DO:
    FIND FIRST xtm600 USE-INDEX xtm60001  WHERE
               xtm600.acno = n_acno1      NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL xtm600 THEN n_agtnam = TRIM(TRIM(xtm600.ntitle) + " " +
                                         TRIM(xtm600.name)).
    ELSE DO:
      FIND FIRST xmm600 USE-INDEX xmm60001  WHERE
                 xmm600.acno = n_acno1      NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL xmm600 THEN n_agtnam = TRIM(TRIM(xmm600.ntitle) + " " +
                                           TRIM(xmm600.name)).
    END.
  END.  /* Producer */

   /*--Saowapa--*/     
   nr_agent1  = "".
   FIND FIRST xmm600 USE-INDEX xmm60001  WHERE xmm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT.     
   IF AVAIL xmm600 THEN DO:                                                                             
       nr_agent1  = uwm100.agent.                                                                       
   END.                                                                                                 
   ELSE DO:                                                                                             
       FIND FIRST xtm600 USE-INDEX xtm60001  WHERE xtm600.acno = uwm100.acno1 NO-LOCK NO-ERROR NO-WAIT. 
       IF AVAIL xtm600 THEN DO:                                                                         
           nr_agent1  = uwm100.agent.                                                                   
       END.                                                                                             
   END.                                                                                                 



  n_padby = "".

  IF      clm130.padby  = "CS" THEN n_padby  = "CASH".
  ELSE IF clm130.padby  = "CQ" THEN n_padby  = "CHEQUE".
  ELSE IF clm130.padby  = "CV" THEN n_padby  = "CounterService".  
  ELSE IF clm130.padby  = "AN" THEN n_padby  = "ADMITTANCE NOTE".
  ELSE                              n_padby  = "NOT CODE ".

  n_moddes = "".
  n_vehreg = "".

  FIND FIRST uwm301 USE-INDEX uwm30101      WHERE
             uwm301.policy = clm100.policy  AND
             uwm301.rencnt = clm100.rencnt  AND
             uwm301.endcnt = clm100.endcnt  AND
             uwm301.riskgp = clm100.riskgp  AND
             uwm301.riskno = clm100.riskno  AND
             uwm301.itemno = clm100.itemno  NO-LOCK NO-WAIT NO-ERROR.
  IF AVAIL uwm301 THEN DO:
     n_moddes = uwm301.moddes.
     n_vehreg = uwm301.vehreg.
  END.

  n_clmveh = "".   

  /* Claimant Details */
  FIND FIRST clm110 USE-INDEX clm11001    WHERE
             clm110.claim  = clm130.claim AND
             clm110.clmant = 002          NO-LOCK NO-WAIT NO-ERROR.
  IF AVAIL clm110 THEN  n_clmveh = clm110.clmveh.

  ASSIGN
  n_losamt = clm130.netl_d
  n_totlos = n_totlos + clm130.netl_d
  n_paddat = STRING(clm130.trndat,"99/99/9999")
  n_entdat = STRING(clm130.entdat,"99/99/9999").

  IF nv_clicod = "GA" OR
     nv_clicod = "GN" OR
     nv_clicod = "SP" THEN
        n_gpamt = n_gpamt + n_losamt.
  ELSE
        n_epamt = n_epamt + n_losamt.

  FIND FIRST clm300 USE-INDEX clm30001   WHERE
             clm300.claim = clm130.claim AND
             clm300.csftq = "T"          AND
             clm300.rico  = "0RET"       NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL clm300 THEN DO:
     ASSIGN  n_retper = clm300.risi_p.
  END.
  
  FOR EACH xmm031 USE-INDEX xmm03101 WHERE SUBSTR(xmm031.poltyp,2,2) = SUBSTR(clm130.claim,3,2)  NO-LOCK.   
      IF xmm031.dept = "G" OR xmm031.dept = "M" THEN DO: 
          IF n_retper = 0 THEN n_retper  = 100.                                           
      END.
  END.  
  
  n_retamt = n_losamt * n_retper / 100.

  n_facri = 0.

  FOR EACH  CLM300  USE-INDEX CLM30001  
      WHERE CLM300.CLAIM = CLM130.CLAIM NO-LOCK :
      /* FAC RI */
      IF Clm300.csftq = "F" THEN DO:
         n_facri = n_facri + (Clm300.risi_p * n_netvat) / 100.  
      END. 
  END. 

  ASSIGN
   n_paydet1 = TRIM(clm130.paydet) 
   n_seq     = n_seq + 1
   nv_row    = nv_row + 1.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_clm130 C-Win 
PROCEDURE PD_clm130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
n_totlos = 0
n_seq    = 0.

loop_130:   /* Claim Payment/Receipt Detail */
FOR EACH  clm130 USE-INDEX clm13003   WHERE
          clm130.trndat >= nv_datefr  AND
          clm130.entdat >= nv_datefr  AND
          clm130.entdat <= nv_dateto  AND
          clm130.trnty1  = "W"        AND 
          clm130.cpc_cd  = "ERC"      NO-LOCK
 BREAK BY clm130.claim .

   DISP clm130.claim WITH NO-LABEL TITLE "Printing Report..."  FRAME a VIEW-AS DIALOG-BOX.

   nv_br  = "".
   IF (SUBSTR(clm130.claim,1,1) = "D"   OR   /*Ex: D07050000001*/
       SUBSTR(clm130.claim,1,1) = "I")  THEN DO:

       IF SUBSTR(clm130.claim,1,1) = "I" THEN DO:
            IF (SUBSTR(clm130.claim,2,1)) >= "1" AND (SUBSTR(clm130.claim,2,1)) <= "8" THEN
                ASSIGN nv_br = "9"  + (SUBSTR(clm130.claim,2,1))
                       n_dir_ri = SUBSTR(clm130.claim,1,1).
            ELSE ASSIGN nv_br = SUBSTRING(clm130.claim,1,2) 
                        n_dir_ri = SUBSTRING(clm130.claim,1,1).
       END.
       ELSE ASSIGN nv_br = SUBSTRING(clm130.claim,2,1) 
                   n_dir_ri = SUBSTRING(clm130.claim,1,1).
       
       IF nv_br < nv_branfr OR
          nv_br > nv_branto THEN NEXT loop_130.
   END.
   ELSE IF (SUBSTR(clm130.claim,1,1) = "F"   OR 
            SUBSTR(clm130.claim,1,1) = "Z"   OR 
            SUBSTR(clm130.claim,1,1) = "N"   OR
            SUBSTR(clm130.claim,1,1) = "A"   OR
            SUBSTR(clm130.claim,1,1) = "B"   OR
            SUBSTR(clm130.claim,1,1) = "H")  THEN DO:
            IF LENGTH(clm130.claim)  = 11 THEN DO:  /*Ex: N1050000001*/
                nv_br   = SUBSTR(clm130.claim,2,2).
                IF nv_br < nv_branfr  OR
                   nv_br > nv_branto  THEN NEXT loop_130.
            END.                                                
            ELSE DO: /*Ex: N050000001*/                         
                nv_br   = SUBSTR(clm130.claim,2,1).             
                IF nv_br < nv_branfr  OR
                   nv_br > nv_branto  THEN NEXT loop_130.
            END.
   END.
   ELSE DO: /*Ex: 107050000001*/
       nv_br   = SUBSTR(clm130.claim,1,2).
       IF nv_br < nv_branfr  OR
          nv_br > nv_branto  THEN NEXT loop_130.
   END.

   IF clm130.netl_d = 0 OR clm130.netl_d = ? THEN NEXT loop_130.

  /* "1=Motor 2=Non Motor 3=ALL"  POLICY TYPE */
  IF nv_poltyp = "1" THEN DO:
    IF SUBSTRING(clm130.claim,3,2) <> "70" AND
       SUBSTRING(clm130.claim,3,2) <> "72" THEN NEXT loop_130.
  END.
  IF nv_poltyp = "2" THEN DO:
    IF SUBSTRING(clm130.claim,3,2) =  "70" OR
       SUBSTRING(clm130.claim,3,2) =  "72" THEN NEXT loop_130.
  END.

  ASSIGN
  nv_clicod = ""
  n_refno   = ""
  n_acno    = "" .

  /* Claim RECOVERY Header */
  FIND clm200 USE-INDEX clm20001      WHERE
       clm200.trnty1 =  clm130.trnty1 AND
       clm200.docno  =  clm130.docno  NO-LOCK NO-WAIT NO-ERROR.
  IF NOT AVAIL clm200 THEN NEXT.


  FIND xmm600 USE-INDEX xmm60001  WHERE
       xmm600.acno = clm200.acno
  NO-LOCK NO-ERROR NO-WAIT.
  IF NOT AVAIL xmm600 THEN NEXT.

  CREATE wclm130.
  ASSIGN
    wclm130.clicod   = xmm600.clicod
    wclm130.acno     = clm200.acno
    wclm130.branch   = nv_br  
    wclm130.paddat   = clm130.trndat
    wclm130.trnty1   = clm130.trnty1
    wclm130.docno    = clm130.docno
    wclm130.claim    = clm130.claim 
    wclm130.clmant   = clm130.clmant
    wclm130.clitem   = clm130.clitem
    wclm130.cpc_cd   = clm130.cpc_cd  .

END.  /*  FOR EACH clm130 */
    
RUN PD_WCLM130 .


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Head C-Win 
PROCEDURE PD_Head :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
vFirstTime =  STRING(TIME, "HH:MM AM").

    ASSIGN
    
    n_releas  = "All"
    nv_head3  = "AS AT : " + STRING(TODAY,"99/99/9999") + " " +  STRING(TIME,"HH:MM")
    
    nv_output = nv_output + ".slk".
    
    OUTPUT STREAM ns1 TO VALUE(nv_output).
    PUT  STREAM  ns1  "ID;PND"  SKIP.
    
    /*-------Header------*/
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"' "BRANCH : "    nv_branfr                       '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"' "To Branch : " nv_branto                       '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"' "THE SAFETY INSURANCE PUBLIC COMPANY LIMITED"  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"' "SYS : "                                       '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"  '"' "PAGE : "  PAGE-NUMBER(ns1) FORMAT ">>>9"      '"' SKIP.

    nv_row = nv_row + 1.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"' "CLAIM RECOVERY BY ENTRY DATE FOR ACCOUNT"  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"' nv_head3                        '"' SKIP.
    
    nv_row = nv_row + 1.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"' "ENTRY DATE FROM : " nv_datefr " TO : " nv_dateto  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"' "RELEASE : " n_releas           '"' SKIP.
    
    /*-----End Header-----*/
    /*---------Column Header---------*/
    nv_row = nv_row + 2.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"' "CLAIM NO."                '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"' "Tran Date กรมธรรม์"       '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"' "Com Date กรมธรรม์"        '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"' "LOSS DATE"                '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"  '"' "REQ. NO."                 '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"  '"' "POL. NO."                 '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"  '"' "INSURED"                  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"  '"' "THROUGH"                  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"  '"' "CHEQUE RECEIVER"          '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K"  '"' "CHEQUE RECEIVER DETAIL"   '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K"  '"' "NATURE"                   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K" '"' "CAUSE OF LOSS"            '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K" '"' "AMOUNT"                   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"' "NET VAT"                  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"' "VAT"                      '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"' "TAX 3%"                   '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"' "Ret %"                    '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"' "Ret. Amount"              '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K" '"' "FAC RI."                  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K" '"' "RELEASE"                  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K" '"' "REC. DATE"                '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K" '"' "SURVEYOR"                 '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K" '"' "PRODUCER"                 '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K" '"' "REC.BY"                   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K" '"' "MAKE & LICENCE OF INS."   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K" '"' "MAKE & LICENCE OF TP."    '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K" '"' "ENTRY DATE"               '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K" '"' "STATUS"                   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K" '"' "REMARK"                   '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K" '"' "RECEIPT NO."              '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K" '"' "User Id"                  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K" '"' "Police Station"           '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K" '"' "Police Name"              '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K" '"' "Nature status."           '"' SKIP. 
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K" '"' "RV PV JV NO."             '"' SKIP.  
    PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K" '"' "RV PV JV Date"            '"' SKIP. 
    
    RUN PD_clm130 .



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_PrintDetail C-Win 
PROCEDURE PD_PrintDetail :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  FIND FIRST acm001  USE-INDEX acm00101      WHERE  
             acm001.trnty1  = clm130.trnty1  AND
             acm001.docno   = clm130.docno   NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL acm001  THEN DO:
    n_cheque = TRIM(acm001.cheque) . 
  END.

  ASSIGN nv_policstnam = " " .
  IF nv_policstno <> ""  THEN DO:
      FIND FIRST  xmm600 USE-INDEX xmm60001  WHERE
                  xmm600.acno =  nv_policstno  NO-LOCK NO-ERROR.
      IF NOT AVAIL xmm600 THEN   nv_policstnam = " " .
      ELSE   nv_policstnam = xmm600.name.
  END.

  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X1;K"  '"' n_claim                 '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X2;K"  '"' nr_trandat              '"' SKIP.  /*fai*/
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X3;K"  '"' nr_comdate              '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X4;K"  '"' n_losdat                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X5;K"  '"' n_prtdoc                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X6;K"  '"' n_policy "" n_remark    '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X7;K"  '"' n_insnam FORMAT "X(30)" '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X8;K"  '"' n_action                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X9;K"  '"' n_recnam                '"' SKIP. /* Cheque Receiver */
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X10;K" '"' n_detail                '"' SKIP. /* Cheque Receiver detail */
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X11;K" '"' n_nature                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X12;K" '"' n_loss                  '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X13;K" '"' n_losamt                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X14;K" '"' n_netvat                '"' SKIP. 
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X15;K" '"' n_vat                   '"' SKIP. 
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X16;K" '"' n_tax                   '"' SKIP. 
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X17;K" '"' n_retper FORMAT ">>9.99" '"' SKIP. 
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X18;K" '"' n_retamt FORMAT "->>>,>>>,>>9.99" '"' SKIP. 
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X19;K" '"' n_facri                 '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X20;K" '"' n_flag                  '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X21;K" '"' n_paddat                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X22;K" '"' n_prtadj                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X23;K" '"' n_agtnam FORMAT "X(30)" '"' SKIP.
  
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X24;K" '"' n_padby                 '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X25;K" '"' n_moddes  " " n_vehreg  '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X26;K" '"' n_clmveh                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K" '"' n_entdat                '"' SKIP.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K" '"' n_status                '"' SKIP.

  IF  clm130.action = "AM" THEN DO:
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X27;K"  '"' n_entdat  '"' SKIP. 
       PUT STREAM ns1 "C;Y" STRING(nv_row) ";X28;K"  '"' n_status  '"' SKIP. 
  END.
  ELSE DO:
     n_paydet1 = TRIM(clm130.paydet) .
     
     PUT STREAM ns1 "C;Y" STRING(nv_row) ";X29;K"  '"' n_paydet1   '"' SKIP. 
     PUT STREAM ns1 "C;Y" STRING(nv_row) ";X30;K"  '"' n_cheque    '"' SKIP. 
     PUT STREAM ns1 "C;Y" STRING(nv_row) ";X31;K"  '"' TRIM(clm130.entid)   '"' SKIP. 
  END.
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X32;K"  '"' nv_policstno   '"' SKIP.    
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X33;K"  '"' nv_policstnam  '"' SKIP.   
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X34;K"  '"' nv_Naturest    '"' SKIP.   
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X35;K"  '"' nv_rvno        '"' SKIP.  
  PUT STREAM ns1 "C;Y" STRING(nv_row) ";X36;K"  '"' nv_rvdat       '"' SKIP.

  FIND FIRST sumbrn WHERE 
             sumbrn.branch = SUBSTRING(wclm130.claim,1,2) NO-ERROR NO-WAIT.
  IF NOT AVAIL sumbrn THEN DO:
 
    CREATE sumbrn.
    ASSIGN sumbrn.totnet = clm130.netl_d.

    IF (SUBSTR(wclm130.claim,1,1) = "D"   OR   /*Ex: D07050000001*/
        SUBSTR(wclm130.claim,1,1) = "I")  THEN DO:
       IF SUBSTR(wclm130.claim,1,1) = "I" THEN DO:
            IF (SUBSTR(wclm130.claim,2,1)) >= "1" AND (SUBSTR(wclm130.claim,2,1)) <= "8" THEN
                ASSIGN sumbrn.branch = "9"  + (SUBSTR(wclm130.claim,2,1)).
                       
            ELSE ASSIGN sumbrn.branch = SUBSTRING(wclm130.claim,1,2) .
                        
       END.
       ELSE ASSIGN sumbrn.branch = SUBSTRING(wclm130.claim,1,2) .
    END.
    ELSE IF (SUBSTR(wclm130.claim,1,1) = "F"   OR 
             SUBSTR(wclm130.claim,1,1) = "Z"   OR 
             SUBSTR(wclm130.claim,1,1) = "N"   OR
             SUBSTR(wclm130.claim,1,1) = "A"   OR
             SUBSTR(wclm130.claim,1,1) = "B"   OR
             SUBSTR(wclm130.claim,1,1) = "H")  THEN DO:
            IF LENGTH(wclm130.claim)  = 11 THEN DO:  /*Ex: N1050000001*/
                sumbrn.branch = SUBSTR(wclm130.claim,2,2).
            END.
            ELSE DO: /*Ex: N050000001*/
                sumbrn.branch = SUBSTR(wclm130.claim,2,1).  
            END.
    END.
    ELSE DO: /*Ex: 107050000001*/
       nv_br   = SUBSTR(wclm130.claim,1,2).
    END.
  END. /* not sumbrn */

  ASSIGN
  n_gpamt  = 0
  n_epamt  = 0  
  nv_rvno  = ""
  nv_rvdat = "" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_WCLM130 C-Win 
PROCEDURE PD_WCLM130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wclm130 NO-LOCK 
    BREAK BY wclm130.clicod
          BY wclm130.acno
          BY wclm130.paddat
          BY wclm130.claim   :

    DISP wclm130.claim WITH NO-LABEL TITLE "Printing Report..."  FRAME a VIEW-AS DIALOG-BOX.

   /* Claim Payment/Receipt Detail */
  FIND  clm130 USE-INDEX clm13001       WHERE
        clm130.trnty1  = wclm130.trnty1 AND
        clm130.docno   = wclm130.docno  AND
        clm130.claim   = wclm130.claim  AND
        clm130.clmant  = wclm130.clmant AND
        clm130.clitem  = wclm130.clitem /* AND
        clm130.cpc_cd  = wclm130.cpc_cd */ NO-LOCK NO-ERROR NO-WAIT.
  IF NOT AVAILABLE clm130 THEN NEXT.
                                                              /* Claim Header */
  FIND clm100 USE-INDEX clm10001      WHERE
       clm100.claim  =  clm130.claim  NO-LOCK NO-WAIT NO-ERROR.
  IF NOT AVAIL clm100 THEN NEXT.

  ASSIGN n_claim  = ""      n_insnam = ""    n_action = ""
         n_remark = ""      n_recnam = ""    n_detail = "" 
         n_losamt = 0       n_retper = 0     n_retamt = 0  
         n_totlos = 0  .

  ASSIGN
  nv_clicod = ""
  n_refno   = ""
  n_acno    = "" 
  n_losamt  = clm130.netl_d
  n_totlos  = n_totlos + clm130.netl_d  .

 /* Claim Payment / Receipt Header */
  FIND clm200 USE-INDEX clm20001      WHERE
       clm200.trnty1 =  clm130.trnty1 AND
       clm200.docno  =  clm130.docno  NO-LOCK NO-WAIT NO-ERROR.
  IF NOT AVAIL clm200 THEN NEXT.

   n_refno   = clm200.acno.

  /* Paid give Who */
  FIND xmm600 USE-INDEX xmm60001  WHERE
       xmm600.acno = clm200.acno  NO-LOCK NO-ERROR NO-WAIT.
  IF NOT AVAIL xmm600 THEN NEXT.

  ASSIGN 
  nv_clicod = xmm600.clicod  /* Client Type */
  n_netvat  = 0  
  n_vat     = 0  
  n_tax     = 0  
  n_netamt  = 0
  n_vatrate = 0 
  n_taxrate = 0
  n_paycd   = "".

  FOR EACH acd001 USE-INDEX acd00191       WHERE 
           acd001.trnty1  = wclm130.trnty1 AND  
           acd001.docno   = wclm130.docno  NO-LOCK .

      IF nv_rvdat = "" THEN nv_rvdat = STRING(DAY(acd001.cjodat),"99")   + "/" +
                                       STRING(MONTH(acd001.cjodat),"99") + "/" +
                                       STRING(YEAR(acd001.cjodat),"9999").
      ELSE nv_rvdat = nv_rvdat + "," + STRING(DAY(acd001.cjodat),"99")  + "/" +
                                       STRING(MONTH(acd001.cjodat),"99")+ "/" + 
                                       STRING(YEAR(acd001.cjodat),"9999").  

      FOR EACH acm001 USE-INDEX acm00101     WHERE 
               acm001.trnty1 = acd001.ctrty1 AND
               acm001.docno  = acd001.cdocno NO-LOCK .
          
         IF nv_rvno = "" THEN nv_rvno = TRIM(SUBSTR(acm001.ref,7,22)).
         ELSE nv_rvno = TRIM(nv_rvno + "," + SUBSTR(acm001.ref,7,22)).
      END.
  END.

  FIND FIRST  arm012 USE-INDEX arm01201    WHERE     
              arm012.type     = n_vtype    AND
              arm012.prjcode  = nv_clicod  NO-LOCK NO-ERROR.
  IF AVAIL    arm012  THEN
  ASSIGN
      n_vatrate = INT(arm012.text1)  /*--อัตรา VAT--*/
      n_taxrate = INT(arm012.text2)  /*--อัตรา TAX--*/
      n_paycd   = TRIM(arm012.text3).
  ELSE DO:
      ASSIGN   n_vatrate = 0
               n_taxrate = 0
               n_paycd   = "".
  END.

  /*คำนวนค่า  vat tax netvat ก่อนเก็บ   ตาม rate ใน ARM120  "VR" */
  ASSIGN
      n_netvat = DEC( ( n_totlos / ((100 + n_vatrate) * 0.01) ) * 100 ) / 100     /* n_amount / 1.07 */
      n_vat    = n_totlos - n_netvat
      n_tax    = IF  n_totlos < 1000  THEN  0 ELSE DEC( (n_netvat * ( n_taxrate * 0.01)) * 100) / 100   /* (n_netvat  * 3 ) / 100 */
      n_netamt = n_totlos - n_tax.

  IF  clm200.ntitle <> " " THEN DO:
        n_recnam = n_refno.
        n_detail = TRIM(TRIM(clm200.ntitle) + " " + TRIM(clm200.name)). 
  END.
  ELSE DO:
       n_recnam = n_refno.
       n_detail  = clm200.NAME.
  END.

  ASSIGN
  n_recadd    = TRIM(n_recnam) + ":" +
                TRIM(TRIM(clm200.addr1) + " " + TRIM(clm200.addr2)) + " " +
                TRIM(TRIM(clm200.addr3) + " " + TRIM(clm200.addr4))
              
  n_acno      = "(" + TRIM(clm200.acno) + ")" 
  n_flag      = clm200.releas

  nv_Naturest = "" 
  n_intref    = "".                                                

  /* Claim Item */
  FIND FIRST clm120 USE-INDEX clm12001      WHERE
             clm120.claim  = clm130.claim   AND
             clm120.clmant = clm130.clmant  AND
             clm120.clitem = clm130.clitem  NO-LOCK NO-WAIT NO-ERROR.
  IF AVAIL clm120 THEN 
      ASSIGN 
      nv_Naturest  = SUBSTRING(TRIM(clm120.styp20),1,1)  
      n_intref     = clm120.intref           /* TP= Third Party */
      n_claim      = clm130.claim 
      n_status     = clm100.padsts
      n_losdat     = STRING(clm100.losdat,"99/99/9999")
      n_loss       = clm100.loss1 + clm100.loss2 + clm100.loss3
      n_prtdoc     = clm130.trnty1 + "-" + clm130.docno
      n_policy     = SUBSTRING(clm100.policy,5,2) + "/" + SUBSTRING(clm100.policy,7,7)
      nv_policstno = clm100.d_post .  

  IF   clm100.ntitle <> "" THEN
       n_insnam = TRIM(clm100.ntitle) + " " +
                  TRIM(TRIM(clm100.name1)  + " " + TRIM(clm100.name2)).
  ELSE n_insnam = TRIM(TRIM(clm100.name1)  + " " + TRIM(clm100.name2)).

  n_action = "".

  IF      clm130.action = "SV" THEN n_action  = "SURVEYOR".
  ELSE IF clm130.action = "PN" THEN n_action  = "PERSONAL".
  ELSE IF clm130.action = "SA" THEN n_action  = "SALVAGE".
  ELSE IF clm130.action = "IL" THEN n_action  = "INSIDE LAWYER".
  ELSE IF clm130.action = "KK" THEN n_action  = "KNOCK FOR KNOCK".
  ELSE IF clm130.action = "AD" THEN n_action  = "ADJUSTER".
  ELSE IF clm130.action = "DD" THEN n_action  = "DEDUCTIVITY".
  ELSE IF clm130.action = "DP" THEN n_action  = "DEPRECIATION".
  ELSE IF clm130.action = "OL" THEN n_action  = "OUTSIDE LAWYER".
  ELSE IF clm130.action = "CC" THEN n_action  = "CLOSE WITHOUT COLLECT".
  ELSE IF clm130.action = "IN" THEN n_action  = "INSURANCE".
  ELSE IF clm130.action = "RE" THEN n_action  = "REFUND".
  ELSE IF clm130.action = "RC" THEN n_action  = "REFUND CHEQUE".  
  ELSE IF clm130.action = "TH" THEN n_action  = "THEFT".
  ELSE IF clm130.action = "CN" THEN n_action  = "NO CLAIM FOR CO".
  ELSE IF clm130.action = "SO" THEN n_action  = "ขาย...ได้คืน ".
  ELSE IF clm130.action = "RL" THEN n_action  = "คืนค่าแรง".
  ELSE IF clm130.action = "RZ" THEN n_action  = "คืนค่าอะไหล่".
  ELSE IF clm130.action = "RX" THEN n_action  = "คืนค่าใช้จ่ายอื่นๆ".
                                              
  ELSE IF clm130.action = "UC" THEN n_action  = "Uncollected". 
  ELSE IF clm130.action = "RV" THEN n_action  = "Recovery".    
  ELSE IF clm130.action = "OD" THEN n_action  = "Owner Damage".
  ELSE                              n_action  = "NOT CODE".


  RUN  PD_Claimant .
  RUN  PD_PrintDetail .

END.  /* for each wclm130 */

OUTPUT STREAM ns1 CLOSE.

vLastTime = STRING(TIME, "HH:MM AM").

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

