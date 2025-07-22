&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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
/* Modify By : Porntiwa P. A53-0039  24/01/2011
             : ปรับ running endorse จาก 5 เป็น 6 หลกั */
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

DEFINE NEW SHARED VAR n_frbr    LIKE  uwm100.branch INIT "0".
DEFINE NEW SHARED VAR n_tobr    LIKE  uwm100.branch INIT "Z".

DEFINE NEW SHARED VAR n_frdate  AS DATE FORMAT "99/99/9999". 
DEFINE NEW SHARED VAR n_todate  AS DATE FORMAT "99/99/9999". 
DEFINE            VAR n_write   AS CHAR FORMAT "X(12)".

DEFINE NEW SHARED VAR nv_write  AS CHAR FORMAT "X(20)".                                                                      
 
DEFINE NEW SHARED VAR n_type    AS CHAR FORMAT "X" INIT "9".

DEFINE NEW SHARED VAR n_reptyp  AS INTE FORMAT "9" INITIAL 1.

DEFINE NEW SHARED VAR n_report  AS CHAR FORMAT "X" INIT "1".

DEFINE NEW SHARED VAR n_prvpol  LIKE uwm100.prvpol.

/* DEFINE NEW SHARED VAR nv_sbt  LIKE acm001.Tax. */


DEF STREAM  ns1.

DEF VAR   frm_trndat AS DATE FORMAT  "99/99/9999"  LABEL " From Trans.date  :  ".
DEF VAR   to_trndat  AS DATE FORMAT  "99/99/9999"  LABEL " To                             :  ".
DEF VAR   frm_bran   LIKE uwm100.branch            LABEL " From Branch        :  ".
DEF VAR   to_bran    LIKE uwm100.branch            LABEL "To                            :  ".
DEF VAR   frm_poltyp AS CHAR FORMAT "X(2)".
DEF VAR   to_poltyp  AS CHAR FORMAT "X(2)".

DEF VAR   n_bran     LIKE acm001.branch .
DEF VAR   n_poltyp   AS CHAR FORMAT "X(2)".
/* DEF SHARED VAR   frm_poltyp AS CHAR FORMAT "X(2)"         LABEL "Policy Type           :  ". */
/* DEF SHARED VAR   to_poltyp  AS CHAR FORMAT "X(2)"         LABEL "Policy Type           :  ". */
DEF        VAR   nv_output  AS CHAR FORMAT "x(20)"        LABEL "Output to :  ".


DEF WORKFILE wfbyline
    FIELD wfseq    as int format  "9"
    
    FIELD wfdesc   as char format "x(15)"
    FIELD wfpoltyp AS CHAR FORMAT "x(03)" 

    FIELD wfprem LIKE UWD132.PREM_C
    FIELD wfvat  LIKE UWD132.PREM_C
    FIELD wfsbt  LIKE UWD132.PREM_C
    FIELD wfstp  LIKE UWD132.PREM_C
    FIELD wfcomm LIKE UWD132.PREM_C.

CREATE wfbyline.
ASSIGN wfseq = 1
       wfdesc = "+ Vol".
 CREATE wfbyline.
ASSIGN wfseq = 2
       wfdesc = "+ Comp".
     
 CREATE wfbyline.
ASSIGN wfseq = 3
       wfdesc = "+ pa".
     
 CREATE wfbyline.
ASSIGN wfseq = 4
       wfdesc = "- Vol".
     
 CREATE wfbyline.
ASSIGN wfseq = 5
       wfdesc = "- Comp".
     
 CREATE wfbyline.
ASSIGN wfseq = 6
       wfdesc = "- PA".


   /*---    
  create wfbyline.
assign wfseq = 7
       wfdesc = "Total".
    -----*/ 

  CREATE wfbyline.
ASSIGN wfseq = 8
       wfdesc = "+ Prem".

 CREATE wfbyline.
ASSIGN wfseq = 9
       wfdesc = "- Prem".

DEF VAR nv_seq as int.
DEF VAR nv_comp LIKE uwd132.prem_c LABEL "Prem Comp".
DEF VAR nv_pa   LIKE uwd132.prem_c LABEL "Prem PA". 
DEF VAR nv_vol  LIKE uwd132.prem_c LABEL "Prem motor".

DEF VAR tot_comp LIKE uwd132.prem_c LABEL "Tot Prem Comp".
DEF VAR tot_pa   LIKE uwd132.prem_c LABEL "Tot Prem PA". 
DEF VAR tot_vol  LIKE uwd132.prem_c LABEL "Tot Prem motor".
DEF VAR tot_prem LIKE uwd132.prem_c LABEL "Tot Prem".

DEF VAR com_comp LIKE uwm100.prem_t LABEL "Com Comp".
DEF VAR com_pa   LIKE uwm100.prem_t LABEL "Com PA". 
DEF VAR com_vol  LIKE uwm100.prem_t LABEL "Com motor".

DEF VAR tot_com_comp LIKE uwd132.prem_c LABEL "Tot Comm Comp  ".
DEF VAR tot_com_pa   LIKE uwd132.prem_c LABEL "Tot Comm PA    ". 
DEF VAR tot_com_vol  LIKE uwd132.prem_c LABEL  "Tot Comm motor ".
DEF VAR tot_com      LIKE uwd132.prem_c LABEL "Tot Comm".

DEF VAR tot_stp LIKE uwm100.rstp_t.
DEF VAR tot_fee LIKE uwm100.rfee_t.
      
DEF VAR tot_pa_stp   LIKE uwm100.rstp_t  LABEL "PA stamp   ".
DEF VAR tot_comp_stp LIKE uwm100.rstp_t  LABEL "Comp Stamp ".
DEF VAR tot_vol_stp  LIKE uwm100.rstp_t  LABEL "Vol  stamp ". 

DEF VAR tot_vat_comp LIKE uwd132.prem_c  LABEL "Tot Vat Comp  ".

DEF VAR tot_vat_pa   LIKE uwd132.prem_c  LABEL "Tot Vat PA    ". 
DEF VAR tot_vat_vol  LIKE uwd132.prem_c  LABEL "Tot Vat motor ".
DEF VAR tot_vat      LIKE uwd132.prem_c  LABEL "Tot Vat".


DEF VAR nv_stp      LIKE uwm100.prem_t LABEL "Stamp".
DEF VAR nv_pa_stp   LIKE uwm100.prem_t LABEL "Pa stamp".
DEF VAR nv_comp_stp LIKE uwm100.prem_t LABEL "Comp Stamp".

DEF VAR nv_vol_stp  LIKE uwm100.prem_t LABEL "Vol Stamp".

DEF VAR nv_vat      LIKE uwm100.prem_t LABEL "Vat".
DEF VAR nv_pa_vat   LIKE uwm100.prem_t LABEL "Pa Vat".
DEF VAR nv_comp_vat LIKE uwm100.prem_t LABEL "Comp Vat".

DEF VAR nv_vol_vat  LIKE uwm100.prem_t LABEL "Vol Vat".
      
DEF VAR pol_prem    LIKE uwm100.prem_t LABEL "Policy Prem".
DEF VAR com_per     AS INT.

DEF VAR nv_comm     LIKE uwm100.com1_t.
DEF VAR n_stp       LIKE uwm100.rstp_t.
DEF VAR n_stptrunc  LIKE uwm100.rstp_t.
DEF VAR n_stpcom    LIKE uwm100.rstp_t.
DEF VAR n_stppa     LIKE uwm100.rstp_t.

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
DEFINE BUTTON BUTTON-4 
     LABEL "EXIT" 
     SIZE 11 BY 1.29
     FONT 36.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 11 BY 1.29
     FONT 36.

DEFINE VARIABLE fi_datfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1.05
     FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_datto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1.05
     FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_frbrn AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1.05
     FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_reptyp AS CHARACTER FORMAT "X(1)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1.05
     FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_tobrn AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1.05
     FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 69 BY 10.95
     BGCOLOR 3 FGCOLOR 15 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 81 BY 18.83.

DEFINE FRAME fr_prem
     fi_datfr AT ROW 3.62 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_datto AT ROW 4.91 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_frbrn AT ROW 6.24 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_tobrn AT ROW 7.52 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_reptyp AT ROW 8.81 COL 27.5 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 10.14 COL 27.5 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 13.76 COL 45
     BUTTON-4 AT ROW 13.76 COL 60
     "Branch From:" VIEW-AS TEXT
          SIZE 15.5 BY 1.05 AT ROW 6.24 COL 13
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Report Type:" VIEW-AS TEXT
          SIZE 16 BY 1.05 AT ROW 8.81 COL 12.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "1 = Details ,  2 = Summary" VIEW-AS TEXT
          SIZE 32.5 BY 1.05 AT ROW 8.81 COL 36.5
          BGCOLOR 3 FGCOLOR 7 FONT 36
     "Trans date From:" VIEW-AS TEXT
          SIZE 20.5 BY 1.05 AT ROW 3.62 COL 8
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "To:" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 4.91 COL 24
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "Output to File:" VIEW-AS TEXT
          SIZE 16.5 BY 1.05 AT ROW 10.14 COL 12.5
          BGCOLOR 3 FGCOLOR 15 FONT 36
     "To:" VIEW-AS TEXT
          SIZE 4 BY 1.05 AT ROW 7.52 COL 24
          BGCOLOR 3 FGCOLOR 15 FONT 36
     RECT-17 AT ROW 2.05 COL 3.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.78
         SIZE 75 BY 15.91
         TITLE "ยอดสรุป Premium By Line To Execl".


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
         HEIGHT             = 17.38
         WIDTH              = 81
         MAX-HEIGHT         = 19.52
         MAX-WIDTH          = 81
         VIRTUAL-HEIGHT     = 19.52
         VIRTUAL-WIDTH      = 81
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
                                                                        */
/* SETTINGS FOR FRAME fr_prem
                                                                        */
/* SETTINGS FOR FILL-IN fi_reptyp IN FRAME fr_prem
   NO-DISPLAY                                                           */
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
&Scoped-define SELF-NAME BUTTON-4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-4 C-Win
ON CHOOSE OF BUTTON-4 IN FRAME fr_prem /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_prem /* OK */
DO:

DEF  VAR n_write     AS CHAR FORMAT "X(12)".
DEF  VAR n_write1    AS CHAR FORMAT "X(20)" LABEL "Output to file ".

ASSIGN
      frm_trndat = fi_datfr
      to_trndat  = fi_datto
      frm_bran   = fi_frbrn
      to_bran    = fi_tobrn
/*       frm_poltyp = fi_frpol */
/*       to_poltyp  = fi_topol */
      n_report   = fi_reptyp.

    IF fi_output <> ""  THEN DO:  
    
     MESSAGE "fi" fi_datfr fi_datto fi_frbrn fi_tobrn 
              fi_reptyp fi_output.

     MESSAGE "ค่าที่รับได้" frm_trndat to_trndat frm_bran to_bran 
             n_report fi_output
             VIEW-AS ALERT-BOX.
       ASSIGN 
           nv_output = fi_output
           n_write1  = nv_output.
          MESSAGE "nv_output" nv_output VIEW-AS ALERT-BOX QUESTION.
    END.

     IF fi_reptyp = "1"   THEN DO:
        RUN Pro_NewDetails.
     END.
  
     ELSE IF fi_reptyp = "2" THEN DO:
        RUN Pro_summary.
     END.

     MESSAGE "Process Data Complete"  VIEW-AS ALERT-BOX QUESTION.
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

        IF fi_datfr = ? THEN 
            MESSAGE "Please, Key In From Date" 
            VIEW-AS ALERT-BOX INFORMATION.

        IF fi_datto = ? THEN DO:
            fi_datto = fi_datfr.
        END.
        DISP fi_datfr fi_datto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datto C-Win
ON LEAVE OF fi_datto IN FRAME fr_prem
DO:
  ASSIGN 
     fi_datto = INPUT FRAME {&FRAME-NAME} fi_datto.

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


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_prem
DO:
   ASSIGN 
      fi_output = INPUT FRAME {&FRAME-NAME} fi_output.

  IF fi_output = ""  THEN DO:
     MESSAGE "Output to 'Printer' Or 'file name'." 
     VIEW-AS ALERT-BOX INFORMATION.
     APPLY "ENTRY"  TO fi_output.
  END.
  ELSE DO:
  
    ASSIGN
 
        n_write = CAPS(INPUT fi_output)
        nv_write = n_write + ".SLK".
  END.
/*    MESSAGE "Output" nv_write VIEW-AS ALERT-BOX. */

  DISP nv_write @ fi_output WITH FRAME {&FRAME-NAME}. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_reptyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_reptyp C-Win
ON LEAVE OF fi_reptyp IN FRAME fr_prem
DO:

 
  ASSIGN 
    fi_reptyp  = INPUT fi_reptyp .
  
  IF fi_reptyp <> "1"  AND fi_reptyp <> "2" THEN DO:
     MESSAGE "Mandatory to Report Type."
     VIEW-AS ALERT-BOX INFORMATION.
  END.
  
  
  DISP fi_reptyp WITH FRAME {&FRAME-NAME}.
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
  
  gv_prgid = "wacmotpo".
  gv_prog  = "ยอดสรุป Premium by Line TO Excel".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).
  Session:data-Entry-Return = Yes.

  ASSIGN
      n_frbr      = "0"
      n_tobr      = "Z"
      n_report    = "1".

     DISP n_frbr   @ fi_frbrn    WITH FRAME fr_prem.
     DISP n_tobr   @ fi_tobrn    WITH FRAME fr_prem.
     DISP n_report @ fi_reptyp   WITH FRAME fr_prem.

  APPLY "Entry" TO fi_datfr .
  
  ASSIGN
      fi_frbrn  = "0"
      fi_tobrn  = "Z"
      fi_reptyp = "1".


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
  DISPLAY fi_datfr fi_datto fi_frbrn fi_tobrn fi_output 
      WITH FRAME fr_prem IN WINDOW C-Win.
  ENABLE RECT-17 fi_datfr fi_datto fi_frbrn fi_tobrn fi_reptyp fi_output bu_ok 
         BUTTON-4 
      WITH FRAME fr_prem IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_prem}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Details C-Win 
PROCEDURE Pro_Details :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF  VAR n_write     AS CHAR FORMAT "X(12)".
DEF  VAR n_write1    AS CHAR FORMAT "X(20)" LABEL "Output to file ".

IF    n_write  <> "PRINTER"  THEN
      n_write1 = SUBSTR (n_write,1,8) + ".SLK". 
ELSE  n_write1 = n_write.
*/
DEFINE VAR n_bran    LIKE acm001.branch.
DEFINE VAR n_poltyp  AS CHAR FORMAT "X(2)".
DEFINE VAR n_policy  LIKE acm001.policy.
DEFINE VAR n_rencnt  AS INTE FORMAT ">9" .                 
DEFINE VAR n_endcnt  AS INTE FORMAT "999".
/*DEFINE VAR n_endno   AS CHAR FORMAT "X(8)". *//*Comment A53-0039*/
DEFINE VAR n_endno   AS CHAR FORMAT "X(9)".  /*Add A53-0039*/
DEFINE VAR n_trndat  LIKE acm001.trndat.

DEFINE VAR nv_sbt     AS DECI FORMAT "->>>>>>>>9.99".
/* DEFINE VAR n_netloc  AS DECI FORMAT ">>,>>>,>>>,>>9.99". */

DEFINE VAR n_com2p   LIKE uwm120.com2p FORMAT ">9".

DEFINE VAR nv_row    AS INTEGER FORMAT ">>>>9" INIT 1. 
DEFINE VAR n_prnvat  AS CHAR FORMAT "X(1)".

OUTPUT STREAM  ns1  TO VALUE (nv_output). 
 
PUT  STREAM  ns1  "ID;PND"  SKIP.
 
nv_row  = 0.

nv_row = nv_row + 3.

    MESSAGE "put date in line!!!!"  nv_row VIEW-AS ALERT-BOX.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' "Branch " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' "Poltyp " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' "Policy " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' "Rencnt " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' "Endcnt " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' "Endt.No. " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' "Trans.date" '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' "Stamp " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' "Prem " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' "SBT " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' "COMM " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K" '"' "COMM % " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K" '"' "n_prnvat " '"' SKIP.
/*     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K" '"' "Error premium" '"' SKIP.  */

    MESSAGE "loop:" frm_trndat to_trndat frm_bran to_bran 
              VIEW-AS ALERT-BOX INFORMATION.
    
/*     ASSIGN                 */
/*         frm_poltyp = "70". */
        
   
    FOR EACH acm001 :
        ASSIGN 
           frm_poltyp = SUBSTR(acm001.policy,3,2).
    END.
    
 loop_acm001:
 FOR EACH acm001 NO-LOCK USE-INDEX acm00191 
          WHERE acm001.trndat >= frm_trndat 
          AND   acm001.trndat <= to_trndat          
          AND  (acm001.trnty1  = "M"  OR
                acm001.trnty1  = "R")

          AND SUBSTR(acm001.policy,2,1)  >=  frm_bran
          AND SUBSTR(acm001.policy,2,1)  <=  to_bran
/*           AND SUBSTR(acm001.poltyp,2,2)  >=  frm_poltyp */
          AND SUBSTR(acm001.policy,3,2)   =  frm_poltyp . 
/*         AND acm001.recno = "". */

         MESSAGE "loop_acm001:" frm_trndat to_trndat frm_bran to_bran frm_poltyp     
                 VIEW-AS ALERT-BOX INFORMATION.
            /*---
            break by acm001.policy.
            ----*/
        ASSIGN 
            n_bran   = acm001.branch
            n_poltyp = SUBSTR(acm001.policy,3,2)
            n_policy = acm001.policy.

/*                DISP  "Process... " acm001.trndat  acm001.branch acm001.policy */
/*                   WITH FRAME b .                                              */
/*               PAUSE 0.                                                        */

  FIND uwm100 NO-LOCK
       WHERE uwm100.policy = acm001.policy
         AND uwm100.trty11 = acm001.trnty1
         AND uwm100.docno1 = acm001.docno
         AND uwm100.endno  = acm001.recno
         NO-ERROR.

      IF NOT AVAILABLE uwm100 THEN DO:
         PUT STREAM ns1 
                  acm001.policy  " "
                  acm001.recno " "
                  "Error"  " "
                  acm001.trnty1 " "
                  acm001.docno " "
                  acm001.netloc SKIP .
           NEXT loop_acm001.

      END.
             
     IF acm001.prem <> uwm100.prem_t THEN
     
         PUT STREAM ns1   "Error premium" 
                acm001.netloc SKIP.
/*         ASSIGN                        */
/*             n_netloc = acm001.netloc. */
     /*
         PUT STREAM ns1 
             uwm100.policy  "  "
             uwm100.rencnt  "  "
             uwm100.endcnt  " "
             uwm100.endno   " " 
             uwm100.trndat SKIP.  
             
          MESSAGE "put stream:" uwm100.policy uwm100.rencnt uwm100.endcnt  
                                uwm100.endno uwm100.trndat
                  VIEW-AS ALERT-BOX QUESTION. 
      */
       
      ASSIGN
                 n_rencnt = uwm100.rencnt
                 n_endcnt = uwm100.endcnt
                 n_endno  = uwm100.endno
                 n_trndat = uwm100.trndat.
  
       MESSAGE "disp:" n_policy  SKIP
                       n_rencnt  skip
                       n_endcnt  SKIP
                       n_endno   SKIP
                       n_trndat  VIEW-AS ALERT-BOX QUESTION.
       
     nv_comp = 0.
     nv_pa = 0.
     FOR EACH uwd132 NO-LOCK
         WHERE uwd132.policy = uwm100.policy
           AND uwd132.rencnt = uwm100.rencnt
           AND uwd132.endcnt = uwm100.endcnt
           AND uwd132.prem_c <> ?.


         IF uwd132.bencod = "comp" THEN DO:
             nv_comp = nv_comp + uwd132.prem_c.

            IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                   N_STP         = (UWD132.PREM_C * 0.4) / 100.
                   N_STPCOM      = TRUNCATE(n_stp,0).
                   n_stptrunc    = n_stp - n_stpcom.
               if    n_stptrunc    > 0  THEN  n_stpcom = n_stpcom + 1.
               ELSE  IF n_stptrunc < 0  THEN  n_stpcom = n_stpcom - 1.

               nv_comp_stp    = nv_comp_stp + n_stpcom.

               n_stpcom   = 0.  n_stptrunc  = 0.

            END.

         END.


         ELSE         IF uwd132.bencod = "pa" THEN  DO:
            nv_pa = nv_pa + uwd132.prem_c.

            IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                   N_STP         = (UWD132.PREM_C * 0.4) / 100.
                   N_STPPA       = TRUNCATE(n_stp,0).
                   n_stptrunc    = n_stp - n_stppa.
               IF    n_stptrunc    > 0  THEN n_stppa = n_stppa + 1.
               ELSE  IF n_stptrunc < 0  THEN n_stppa = n_stppa - 1.

               nv_pa_stp    = nv_pa_stp + n_stppa.

               n_stppa  = 0.  n_stptrunc  = 0.

            END.

         END.

     END.  

     nv_vol = uwm100.prem_t - nv_comp - nv_pa. 


     nv_stp = uwm100.rstp + uwm100.pstp.     /* policy stamp */

     /*----keng---
      /* calculate stamp */

     nv_pa_stp = truncate(nv_pa * 0.004 , 0).

     if nv_pa_stp  <> nv_pa * 0.004  then
        nv_pa_stp = nv_pa_stp + 1.

      nv_comp_stp = truncate(nv_comp * 0.004 , 0).

     if nv_comp_stp <> nv_comp * 0.004  then
        nv_comp_stp = nv_comp_stp + 1.

    -------------------------*/

     nv_vol_stp = (uwm100.pstp + uwm100.rstp_t ) - nv_pa_stp - nv_comp_stp.
     tot_pa_stp = tot_pa_stp + nv_pa_stp.
     tot_comp_stp = tot_comp_stp + nv_comp_stp. 
     tot_vol_stp = tot_vol_stp + nv_vol_stp.

           /* Calculate VAT */

      IF uwm100.rtax_t <> 0 THEN 
          nv_pa_vat = (nv_pa + nv_pa_stp) * uwm100.gstrat / 100.


      IF uwm100.rtax_t <> 0 THEN 
        nv_comp_vat = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.



     nv_vol_vat = uwm100.rtax_t - nv_pa_vat - nv_comp_vat.

     tot_vat_pa = tot_vat_pa + nv_pa_vat.
     tot_vat_comp = tot_vat_comp + nv_comp_vat.
     tot_vat_vol = tot_vat_vol + nv_vol_vat. 

    /*------------------------------------------------------------*/

     com_per = 0.
     FIND FIRST uwm120 NO-LOCK
         WHERE uwm120.policy = uwm100.policy
           AND uwm120.rencnt = uwm100.rencnt
           AND uwm120.endcnt = uwm100.endcnt.

      IF  AVAIL  uwm120  THEN DO:
         IF com_per = 0 THEN com_per = uwm120.com1p.                            
         com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0).
         com_pa  = - com_pa.

         n_com2p = uwm120.com2p. 
      END.
          

    /*----
     com_pa = - nv_pa * com_per / 100.
     -------*/

     com_vol = uwm100.com1_t - com_pa.
     com_comp = uwm100.com2_t.

     tot_com_pa = tot_com_pa + com_pa.
     tot_com_vol = tot_com_vol + com_vol.
     tot_com_comp = tot_com_comp + com_comp.


     nv_vat  = uwm100.rtax_t.

     nv_stp = uwm100.rstp_t + uwm100.pstp.

     pol_prem = nv_vol + nv_comp + nv_pa.

     nv_comm  = com_vol + com_comp + com_pa.
     /******
     PUT STREAM ns1 
          nv_comp    "  "
          nv_comp_vat   " "
          nv_comp_stp   " "
          com_comp SKIP
          nv_vol    " "  
          nv_vol_vat  "  "
          nv_vol_stp  " "
          com_vol SKIP
          nv_pa  "  "
          nv_pa_vat   " "
          nv_pa_stp   " "
          com_pa SKIP
          "   =======================================================" SKIP
          pol_prem   nv_vat nv_stp  nv_comm  SKIP
          "   =======================================================" SKIP.
     ******/
     /*----check Print VAT ------*/
         IF (SUBSTR(acm001.policy,5,2)  = "99"    OR
             SUBSTR(acm001.policy,5,2) >= "43")   AND
             SUBSTR(acm001.policy,3,2) <> "60"    AND
             SUBSTR(acm001.policy,3,2) <> "61"    AND
             SUBSTR(acm001.policy,3,2) <> "62"    AND
             SUBSTR(acm001.policy,3,2) <> "63"    AND
             SUBSTR(acm001.policy,3,2) <> "64"    AND
             SUBSTR(acm001.policy,3,2) <> "67"    THEN DO:

             FIND FIRST vat100 NO-LOCK  USE-INDEX vat10002 WHERE
                        vat100.policy = acm001.policy      AND
                        vat100.trnty1 = acm001.trnty1      AND
                        vat100.refno  = acm001.docno       NO-ERROR.
             IF AVAIL vat100  THEN
                   n_prnvat  = "V".
             ELSE  n_prnvat  = " ".

         END.
      /*--------------------------*/ 
  /****  sum ยอดรวม  *****/
  /********
     nv_row = nv_row + 1.

     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' n_bran  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' n_poltyp  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' n_policy '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' n_Rencnt  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' n_Endcnt  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' n_endno  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' n_Trndat '"' SKIP.

     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' nv_stp  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' pol_Prem  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' n_SBT  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' nv_COMM  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K" '"' com_per /*n_com1p*/  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K" '"' n_prnvat '"' SKIP.
   ********/   
/*      PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K" '"' n_netloc '"' SKIP. */
/******  nv_vol   nv_comp   nv_pa ********/   

IF nv_comp <> 0 THEN DO:
    /*  nv_comp      nv_comp_vat      nv_comp_stp       com_comp */
   nv_row = nv_row + 1.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' n_bran  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' n_poltyp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' n_policy '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' n_Rencnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' n_Endcnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' n_endno  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' n_Trndat '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' nv_comp_stp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' nv_comp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' nv_SBT  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' com_comp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K" '"' n_com2p  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K" '"' n_prnvat '"' SKIP.
END.

IF nv_vol <> 0 THEN DO:
     /*  nv_vol     nv_vol_vat      nv_vol_stp      com_vol  */
    nv_row = nv_row + 1.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' n_bran  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' n_poltyp  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' n_policy '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' n_Rencnt  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' n_Endcnt  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' n_endno  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' n_Trndat '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' nv_vol_stp  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' nv_vol  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' nv_SBT  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' com_vol  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K" '"' com_per  '"' SKIP.
     PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K" '"' n_prnvat '"' SKIP.
END.

IF nv_pa <> 0 THEN DO:
    /*  nv_pa        nv_pa_vat       nv_pa_stp       com_pa  */
    nv_row = nv_row + 1.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' n_bran  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' n_poltyp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' n_policy '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' n_Rencnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' n_Endcnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' n_endno  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' n_Trndat '"' SKIP.
    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' nv_pa_stp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' nv_pa  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' nv_SBT  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' com_pa  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K" '"' com_per  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K" '"' n_prnvat '"' SKIP.
END.
    /******  nv_vol   nv_comp   nv_pa ********/   

     MESSAGE "!!!PUT!!!" nv_comp  nv_comp_vat nv_comp_stp com_comp SKIP
                         nv_vol   nv_vol_vat  nv_vol_stp  com_vol  SKIP
                         nv_pa    nv_pa_vat   nv_pa_stp   com_pa   SKIP(2)
                         pol_prem nv_vat      nv_stp      nv_comm
              VIEW-AS ALERT-BOX INFORMATION.

     MESSAGE "44444:" n_bran frm_poltyp n_policy.

      IF nv_vol > 0 THEN nv_seq = 1.
      ELSE nv_seq = 4.

      FIND FIRST wfbyline WHERE wfseq = nv_seq NO-ERROR.
         IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfseq = nv_seq.
         END.    

      wfprem = wfprem + nv_vol.
      wfvat  = wfvat + nv_vol_vat.
      wfstp  = wfstp + nv_vol_stp.
      wfcomm = wfcomm + com_vol.

      IF nv_comp > 0 THEN nv_seq = 2.
      ELSE nv_seq = 5.
      FIND FIRST wfbyline WHERE wfseq = nv_seq NO-ERROR.

         IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfseq = nv_seq.
         END.    

      wfprem = wfprem + nv_comp.
      wfvat  = wfvat + nv_comp_vat.
      wfstp  = wfstp + nv_comp_stp.
      wfcomm = wfcomm + com_comp.


     IF nv_pa > 0 THEN nv_seq = 3.
      ELSE nv_seq = 6.
      FIND FIRST wfbyline WHERE wfseq = nv_seq NO-ERROR.
         IF NOT AVAILABLE wfbyline THEN do:
            CREATE wfbyline.
            ASSIGN wfseq = nv_seq.
         END.    

      wfprem = wfprem + nv_pa.
      wfvat  = wfvat + nv_pa_vat.
      wfstp  = wfstp + nv_pa_stp.
      wfcomm = wfcomm + com_pa.


     tot_vol = tot_vol + nv_vol.
     tot_pa = tot_pa + nv_pa.
     tot_comp = tot_comp + nv_comp.
     tot_prem = tot_prem + uwm100.prem_t.

     tot_vat = tot_vat + uwm100.rtax_t.

     tot_stp = tot_stp + uwm100.rstp_t + uwm100.pstp.

          nv_comp         = 0. 
          nv_comp_stp     = 0. 
          nv_comp_vat     = 0. 
          com_comp        = 0. 
          nv_vol          = 0.   
          nv_vol_stp      = 0.
          nv_vol_vat      = 0. 
          com_vol         = 0. 
          nv_pa           = 0.
          nv_pa_stp       = 0.
          nv_pa_vat       = 0.
          com_pa          = 0.
          pol_prem        = 0.
          nv_stp          = 0.
          nv_vat          = 0.
          nv_comm         = 0.
   
 END.  /* end each acm001 */

 tot_com = tot_com_pa + tot_com_comp + tot_com_vol.


      FIND FIRST wfbyline WHERE wfseq = 7 NO-ERROR.
         IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfseq = 7. 
         END.    

      wfdes   = "Total ".
      wfprem  = tot_prem. 
      wfvat   = tot_vat. 
      wfstp   = tot_stp.
      wfcomm  = tot_com.  



 FOR EACH wfbyline BREAK BY wfseq.
   /*
     PUT STREAM ns1 

         wfseq    "  " 

         wfdesc    FORMAT "x(10)" 
         wfprem    FORMAT ">>,>>>,>>>,>>9.99-"   " "

         wfvat     FORMAT   ">>>>,>>9.99-"  " "

         wfstp     FORMAT ">>>>,>>9.99-"  " "

         wfcomm    FORMAT ">>>>,>>>,>>9.99-"    SKIP.
     */   
    nv_row = nv_row + 2.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' wfseq  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' wfdesc  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' wfprem  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' wfvat  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' wfstp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' wfcomm  '"' SKIP.
   
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_NewDetails C-Win 
PROCEDURE Pro_NewDetails :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEFINE VAR n_bran    LIKE acm001.branch.
DEFINE VAR n_poltyp  AS CHAR FORMAT "X(2)".
DEFINE VAR n_policy  LIKE acm001.policy.
DEFINE VAR n_rencnt  AS INTE FORMAT ">9" .                 
DEFINE VAR n_endcnt  AS INTE FORMAT "999".
/*DEFINE VAR n_endno   AS CHAR FORMAT "X(8)".*//*Comment A53-0039*/
DEFINE VAR n_endno   AS CHAR FORMAT "X(9)".  /*Add A53-0039*/
DEFINE VAR n_trndat  LIKE acm001.trndat.

DEFINE VAR nv_sbt AS DECI FORMAT "->,>>>,>>9.99".


DEFINE VAR n_com2p   LIKE uwm120.com2p FORMAT ">9".

DEFINE VAR nv_row    AS INTEGER FORMAT ">>>>9" INIT 1. 
DEFINE VAR n_prnvat  AS CHAR FORMAT "X(1)".

OUTPUT STREAM  ns1  TO VALUE (nv_output). 
 
PUT  STREAM  ns1  "ID;PND"  SKIP.
 
nv_row  = 0.

nv_row = nv_row + 3.

   
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' "BRANCH " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' "POL.LINE " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' "POLICY " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' "RENCNT " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' "ENDCNT " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' "ENDT.NO. " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' "TRANS.DATE" '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' "PREMIUM " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' "COMPULSORY " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' "PA " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' "TOTAL PREMIUM " '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K" '"' "STAMP " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K" '"' "STAMP COMPULSORY " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K" '"' "STAMP PA" '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K" '"' "TOTAL STAMP " '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K" '"' "VAT " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K" '"' "VAT COMPULSORY " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K" '"' "VAT PA" '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K" '"' "TOTAL VAT  " '"' SKIP.


    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K" '"' "SBT " '"' SKIP.
    
    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K" '"' "COMM.  " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K" '"' "COMM. COMPULSORY   " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K" '"' "COMM. PA  " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K" '"' "Total COMM.  " '"' SKIP.

   
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K" '"' "PRNVAT " '"' SKIP.

    MESSAGE "loop:" frm_trndat to_trndat frm_bran to_bran 
              VIEW-AS ALERT-BOX INFORMATION.
    

   
loop_acm001:
 FOR EACH acm001 NO-LOCK USE-INDEX acm00191 
          WHERE acm001.trndat >= frm_trndat 
          AND   acm001.trndat <= to_trndat          
          AND  (acm001.trnty1  = "M"  OR
                acm001.trnty1  = "R")

          AND SUBSTR(acm001.policy,2,1)  >=  frm_bran
          AND SUBSTR(acm001.policy,2,1)  <=  to_bran.


    
        ASSIGN 
            n_bran   = acm001.branch
            n_poltyp = SUBSTR(acm001.policy,3,2)
            n_policy = acm001.policy.

            MESSAGE "DATA" n_bran n_poltyp n_policy 
                    VIEW-AS ALERT-BOX INFORMATION.

     FIND uwm100 NO-LOCK
       WHERE uwm100.policy = acm001.policy
         AND uwm100.trty11 = acm001.trnty1
         AND uwm100.docno1 = acm001.docno
         AND uwm100.endno  = acm001.recno
         NO-ERROR.

      IF NOT AVAILABLE uwm100 THEN DO:

       /*----
         PUT STREAM ns1 
                  acm001.policy  " "
                  acm001.recno " "
                  "Error"  " "
                  acm001.trnty1 " "
                  acm001.docno " "
                  acm001.netloc SKIP .
          -----------*/

           NEXT loop_acm001.

      END.

             
     IF acm001.prem <> uwm100.prem_t THEN
         /*---
         PUT STREAM ns1   "Error premium" 
                acm001.netloc SKIP.

         ------*/     
       
      ASSIGN
          n_rencnt = uwm100.rencnt
          n_endcnt = uwm100.endcnt
          n_endno  = uwm100.endno
          n_trndat = uwm100.trndat.
  
      


   IF  SUBSTRING(acm001.policy,3,2) = "70"  THEN DO:

        nv_comp = 0.
        nv_pa = 0.

      FOR EACH uwd132 NO-LOCK
           WHERE uwd132.policy = uwm100.policy
           AND uwd132.rencnt = uwm100.rencnt
           AND uwd132.endcnt = uwm100.endcnt
           AND uwd132.prem_c <> ?.


         IF uwd132.bencod = "comp" THEN DO:
             nv_comp = nv_comp + uwd132.prem_c.

             IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                   N_STP         = (UWD132.PREM_C * 0.4) / 100.
                   N_STPCOM      = TRUNCATE(n_stp,0).
                   n_stptrunc    = n_stp - n_stpcom.
                if    n_stptrunc    > 0  THEN  n_stpcom = n_stpcom + 1.
                ELSE  IF n_stptrunc < 0  THEN  n_stpcom = n_stpcom - 1.

               nv_comp_stp    = nv_comp_stp + n_stpcom.

               n_stpcom   = 0.  n_stptrunc  = 0.

             END.  /* RSTP_T  <> 0 */

         END.    /* BENCOD = COMP */


         ELSE   
           IF uwd132.bencod = "pa" THEN  DO:
              nv_pa = nv_pa + uwd132.prem_c.

              IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                   N_STP         = (UWD132.PREM_C * 0.4) / 100.
                   N_STPPA       = TRUNCATE(n_stp,0).
                   n_stptrunc    = n_stp - n_stppa.
               IF    n_stptrunc    > 0  THEN n_stppa = n_stppa + 1.
               ELSE  IF n_stptrunc < 0  THEN n_stppa = n_stppa - 1.

               nv_pa_stp    = nv_pa_stp + n_stppa.

               n_stppa  = 0.  n_stptrunc  = 0.

              END.  /* RSTP_T <> 0 */

         END.  /* BENCOD = PA  */

      END.  /* EACH UWD132 */

       

     nv_vol = uwm100.prem_t - nv_comp - nv_pa. 


     nv_stp = uwm100.rstp + uwm100.pstp.     /* policy stamp */

     

     nv_vol_stp = (uwm100.pstp + uwm100.rstp_t ) - nv_pa_stp - nv_comp_stp.
     
    
     tot_pa_stp = tot_pa_stp + nv_pa_stp.
     tot_comp_stp = tot_comp_stp + nv_comp_stp. 
     tot_vol_stp = tot_vol_stp + nv_vol_stp.

           /* Calculate VAT */

      IF uwm100.rtax_t <> 0 THEN 
          nv_pa_vat = (nv_pa + nv_pa_stp) * uwm100.gstrat / 100.


      IF uwm100.rtax_t <> 0 THEN 
        nv_comp_vat = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.



     nv_vol_vat = uwm100.rtax_t - nv_pa_vat - nv_comp_vat.

     tot_vat_pa = tot_vat_pa + nv_pa_vat.
     tot_vat_comp = tot_vat_comp + nv_comp_vat.
     tot_vat_vol = tot_vat_vol + nv_vol_vat. 

    /*------------------------------------------------------------*/

     com_per = 0.
     
     FIND FIRST uwm120 NO-LOCK
         WHERE uwm120.policy = uwm100.policy
           AND uwm120.rencnt = uwm100.rencnt
           AND uwm120.endcnt = uwm100.endcnt.

      IF  AVAIL  uwm120  THEN DO:
         IF com_per = 0 THEN com_per = uwm120.com1p.                            
         com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0).
         com_pa  = - com_pa.

         n_com2p = uwm120.com2p. 
      END.
          

    /*----
     com_pa = - nv_pa * com_per / 100.
     -------*/

     com_vol = uwm100.com1_t - com_pa.
     com_comp = uwm100.com2_t.

     tot_com_pa = tot_com_pa + com_pa.
     tot_com_vol = tot_com_vol + com_vol.
     tot_com_comp = tot_com_comp + com_comp.


     nv_vat  = uwm100.rtax_t.    

     nv_stp = uwm100.rstp_t + uwm100.pstp.

     pol_prem = nv_vol + nv_comp + nv_pa.   /* PREMIUM  */

     nv_comm  = com_vol + com_comp + com_pa.   /* COMMISSION */


     
     /*----check Print VAT ------*/
         IF (SUBSTR(acm001.policy,5,2)  = "99"    OR
             SUBSTR(acm001.policy,5,2) >= "43")   AND
             SUBSTR(acm001.policy,3,2) <> "60"    AND
             SUBSTR(acm001.policy,3,2) <> "61"    AND
             SUBSTR(acm001.policy,3,2) <> "62"    AND
             SUBSTR(acm001.policy,3,2) <> "63"    AND
             SUBSTR(acm001.policy,3,2) <> "64"    AND
             SUBSTR(acm001.policy,3,2) <> "67"    THEN DO:

             FIND FIRST vat100 NO-LOCK  USE-INDEX vat10002 WHERE
                        vat100.policy = acm001.policy      AND
                        vat100.trnty1 = acm001.trnty1      AND
                        vat100.refno  = acm001.docno       NO-ERROR.
             IF AVAIL vat100  THEN
                   n_prnvat  = "V".
             ELSE  n_prnvat  = " ".

         END.
      /*-------------------------*/ 
   
  /****  sum ยอดรวม  *****/
  
  nv_row = nv_row + 1.
    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' n_bran  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' n_poltyp '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' n_policy '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' n_Rencnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' n_Endcnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' n_endno  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' n_Trndat '"' SKIP.


    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' nv_vol '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' nv_comp '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' nv_pa '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' pol_prem '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X12;K" '"' nv_vol_stp '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X13;K" '"' nv_comp_stp '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X14;K" '"' nv_pa_stp '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K" '"' nv_stp '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X16;K" '"' nv_vol_vat '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X17;K" '"' nv_comp_vat '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X18;K" '"' nv_pa_vat '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K" '"' nv_vat '"' SKIP.


    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K" '"' nv_sbt '"' SKIP.
                                              
    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X21;K" '"' com_vol '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X22;K" '"' com_comp '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X23;K" '"' com_pa '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K" '"' nv_comm '"' SKIP.

    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K" '"' n_prnvat  '"' SKIP.

          nv_comp         = 0. 
          nv_comp_stp     = 0. 
          nv_comp_vat     = 0. 
          com_comp        = 0. 
          nv_vol          = 0.   
          nv_vol_stp      = 0.
          nv_vol_vat      = 0. 
          com_vol         = 0. 
          nv_pa           = 0.
          nv_pa_stp       = 0.
          nv_pa_vat       = 0.
          com_pa          = 0.
          pol_prem        = 0.
          nv_stp          = 0.
          nv_vat          = 0.
          nv_comm         = 0.

   END.   /* if poltyp = "70"  */
   ELSE DO:   /* non motor  */

       
         
         IF  SUBSTR(acm001.policy,3,2) <> "60"    AND
             SUBSTR(acm001.policy,3,2) <> "61"    AND
             SUBSTR(acm001.policy,3,2) <> "62"    AND
             SUBSTR(acm001.policy,3,2) <> "63"    AND
             SUBSTR(acm001.policy,3,2) <> "64"    AND
             SUBSTR(acm001.policy,3,2) <> "67"    THEN 

             nv_vat  = acm001.tax.

         ELSE nv_sbt = acm001.tax.


       nv_row = nv_row + 1.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' n_bran  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' n_poltyp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' n_policy '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' n_Rencnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' n_Endcnt  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' n_endno  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' n_Trndat '"' SKIP.


    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' acm001.prem '"' SKIP.

    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X15;K" '"' acm001.stamp  '"' SKIP.

    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X19;K" '"' nv_vat '"' SKIP.


    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X20;K" '"' nv_sbt '"' SKIP.
                                              
    
    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X24;K" '"' acm001.comm  '"' SKIP.

    
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X25;K" '"' n_prnvat  '"' SKIP.

     nv_vat  = 0.  nv_sbt  = 0.  n_prnvat  = " ". 

 

   END.  /* non-motor  */

   
 END.  /* end each acm001 */

 

PUT STREAM  ns1  "E"  SKIP.
OUTPUT STREAM ns1 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_Summary C-Win 
PROCEDURE Pro_Summary :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEF  VAR n_write     AS CHAR FORMAT "X(12)".
DEF  VAR n_write1    AS CHAR FORMAT "X(20)" LABEL "Output to file ".

IF    n_write  <> "PRINTER"  THEN
      n_write1 = SUBSTR (n_write,1,8) + ".SLK". 
ELSE  n_write1 = n_write.
*/
DEFINE VAR n_bran    LIKE acm001.branch.
DEFINE VAR n_poltyp  AS CHAR FORMAT "X(2)".
DEFINE VAR n_policy  LIKE acm001.policy.
DEFINE VAR n_rencnt  AS INTE FORMAT ">9" .                 
DEFINE VAR n_endcnt  AS INTE FORMAT "999".
/*DEFINE VAR n_endno   AS CHAR FORMAT "X(8)". *//*Comment A53-0039*/
DEFINE VAR n_endno   AS CHAR FORMAT "X(9)". /*Add A53-0039*/
DEFINE VAR n_trndat  LIKE acm001.trndat.

DEFINE VAR n_sbt     AS DECI FORMAT "->>>>>>>>9.99".
/* DEFINE VAR n_netloc  AS DECI FORMAT ">>,>>>,>>>,>>9.99". */

DEFINE VAR n_com2p   LIKE uwm120.com2p FORMAT ">9".

DEFINE VAR nv_row    AS INTEGER FORMAT ">>>>9" INIT 1. 
DEFINE VAR n_prnvat  AS CHAR FORMAT "X(1)".

OUTPUT STREAM  ns1  TO VALUE (nv_output) . 
 
PUT  STREAM  ns1  "ID;PND"  SKIP.
 
nv_row  = 0.

nv_row = nv_row + 3.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' "NUMBER " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' "CALCULA " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' "POL.LINE " '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' "PREM " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' "STAMP " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' "VAT " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' "SBT " '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' "PREM + VAT " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' "PREM - SBT " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' "COMM " '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' "NETAMT " '"' SKIP.

 loop_acm001:
 FOR EACH acm001 NO-LOCK USE-INDEX acm00191 
          WHERE acm001.trndat >= frm_trndat 
          AND   acm001.trndat <= to_trndat          
          AND  (acm001.trnty1  = "M"  OR
                acm001.trnty1  = "R")

          AND SUBSTR(acm001.policy,2,1)  >=  frm_bran
          AND SUBSTR(acm001.policy,2,1)  <=  to_bran.

       
        ASSIGN 
            n_bran   = acm001.branch
            n_poltyp = SUBSTR(acm001.policy,3,2)
            n_policy = acm001.policy.

        MESSAGE "DATA" n_bran n_poltyp n_policy
                VIEW-AS ALERT-BOX INFORMATION.

    FIND uwm100 NO-LOCK
       WHERE uwm100.policy = acm001.policy
         AND uwm100.trty11 = acm001.trnty1
         AND uwm100.docno1 = acm001.docno
         AND uwm100.endno  = acm001.recno
         NO-ERROR.

      IF NOT AVAILABLE uwm100 THEN DO:
         
           NEXT loop_acm001.

      END.
             
     IF acm001.prem <> uwm100.prem_t THEN
     
         PUT STREAM ns1   "Error premium" 
                acm001.netloc SKIP.
/*         ASSIGN                        */
/*             n_netloc = acm001.netloc. */
     /*
         PUT STREAM ns1 
             uwm100.policy  "  "
             uwm100.rencnt  "  "
             uwm100.endcnt  " "
             uwm100.endno   " " 
             uwm100.trndat SKIP.  
             
          MESSAGE "put stream:" uwm100.policy uwm100.rencnt uwm100.endcnt  
                                uwm100.endno uwm100.trndat
                  VIEW-AS ALERT-BOX QUESTION. 
      */
       
      ASSIGN
                 n_rencnt = uwm100.rencnt
                 n_endcnt = uwm100.endcnt
                 n_endno  = uwm100.endno
                 n_trndat = uwm100.trndat.
  

   IF  SUBSTR(ACM001.POLICY,3,2)  = "70" THEN DO:
  
     
     nv_comp = 0.
     nv_pa = 0.
     FOR EACH uwd132 NO-LOCK
         WHERE uwd132.policy = uwm100.policy
           AND uwd132.rencnt = uwm100.rencnt
           AND uwd132.endcnt = uwm100.endcnt
           AND uwd132.prem_c <> ?.


         IF uwd132.bencod = "comp" THEN DO:
             nv_comp = nv_comp + uwd132.prem_c.

            IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                   N_STP         = (UWD132.PREM_C * 0.4) / 100.
                   N_STPCOM      = TRUNCATE(n_stp,0).
                   n_stptrunc    = n_stp - n_stpcom.
               if    n_stptrunc    > 0  THEN  n_stpcom = n_stpcom + 1.
               ELSE  IF n_stptrunc < 0  THEN  n_stpcom = n_stpcom - 1.

               nv_comp_stp    = nv_comp_stp + n_stpcom.

               n_stpcom   = 0.  n_stptrunc  = 0.

            END.

         END.


         ELSE         IF uwd132.bencod = "pa" THEN  DO:
            nv_pa = nv_pa + uwd132.prem_c.

            IF UWM100.PSTP <> 0 OR UWM100.RSTP_T <> 0 THEN DO:
                   N_STP         = (UWD132.PREM_C * 0.4) / 100.
                   N_STPPA       = TRUNCATE(n_stp,0).
                   n_stptrunc    = n_stp - n_stppa.
               IF    n_stptrunc    > 0  THEN n_stppa = n_stppa + 1.
               ELSE  IF n_stptrunc < 0  THEN n_stppa = n_stppa - 1.

               nv_pa_stp    = nv_pa_stp + n_stppa.

               n_stppa  = 0.  n_stptrunc  = 0.

            END.

         END.

     END.  

     nv_vol = uwm100.prem_t - nv_comp - nv_pa. 


     nv_stp = uwm100.rstp + uwm100.pstp.     /* policy stamp */

     

     nv_vol_stp = (uwm100.pstp + uwm100.rstp_t ) - nv_pa_stp - nv_comp_stp.
     tot_pa_stp = tot_pa_stp + nv_pa_stp.
     tot_comp_stp = tot_comp_stp + nv_comp_stp. 
     tot_vol_stp = tot_vol_stp + nv_vol_stp.

           /* Calculate VAT */

      IF uwm100.rtax_t <> 0 THEN 
          nv_pa_vat = (nv_pa + nv_pa_stp) * uwm100.gstrat / 100.


      IF uwm100.rtax_t <> 0 THEN 
        nv_comp_vat = (nv_comp + nv_comp_stp) * uwm100.gstrat / 100.



     nv_vol_vat = uwm100.rtax_t - nv_pa_vat - nv_comp_vat.

     tot_vat_pa = tot_vat_pa + nv_pa_vat.
     tot_vat_comp = tot_vat_comp + nv_comp_vat.
     tot_vat_vol = tot_vat_vol + nv_vol_vat. 

    /*------------------------------------------------------------*/

     com_per = 0.
     FIND FIRST uwm120 NO-LOCK
         WHERE uwm120.policy = uwm100.policy
           AND uwm120.rencnt = uwm100.rencnt
           AND uwm120.endcnt = uwm100.endcnt.

      IF  AVAIL  uwm120  THEN DO:
         IF com_per = 0 THEN com_per = uwm120.com1p.                            
         com_pa  = TRUNCATE((nv_pa * uwm120.com1p / 100),0).
         com_pa  = - com_pa.

         n_com2p = uwm120.com2p. 
      END.
          

   

     com_vol = uwm100.com1_t - com_pa.
     com_comp = uwm100.com2_t.

     tot_com_pa = tot_com_pa + com_pa.
     tot_com_vol = tot_com_vol + com_vol.
     tot_com_comp = tot_com_comp + com_comp.


     nv_vat  = uwm100.rtax_t.

     nv_stp = uwm100.rstp_t + uwm100.pstp.

     pol_prem = nv_vol + nv_comp + nv_pa.

     nv_comm  = com_vol + com_comp + com_pa.
     


    
      IF nv_vol > 0 THEN nv_seq = 1.
      ELSE nv_seq = 4.

      FIND FIRST wfbyline WHERE wfseq     = nv_seq and
                                wfpoltyp  = "70"
          NO-ERROR.
         IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfseq = nv_seq
                   wfpoltyp = "70".
         END.    

      wfprem = wfprem + nv_vol.
      wfvat  = wfvat + nv_vol_vat.
      wfstp  = wfstp + nv_vol_stp.
      wfcomm = wfcomm + com_vol.

      IF nv_comp > 0 THEN nv_seq = 2.
      ELSE nv_seq = 5.
      FIND FIRST wfbyline WHERE wfseq     = nv_seq  AND
                                wfpoltyp  = "71"
                              
          NO-ERROR.

         IF NOT AVAILABLE wfbyline THEN DO:
            CREATE wfbyline.
            ASSIGN wfseq = nv_seq
                   wfpoltyp = "71". 
         END.    

      wfprem = wfprem + nv_comp.
      wfvat  = wfvat + nv_comp_vat.
      wfstp  = wfstp + nv_comp_stp.
      wfcomm = wfcomm + com_comp.


     IF nv_pa > 0 THEN nv_seq = 3.
      ELSE nv_seq = 6.
      FIND FIRST wfbyline WHERE wfseq = nv_seq  AND
                                wfpoltyp  = "70"
           
          NO-ERROR.
         IF NOT AVAILABLE wfbyline THEN do:
            CREATE wfbyline.
            ASSIGN wfseq = nv_seq
                   wfpoltyp = "70". 
         END.    

      wfprem = wfprem + nv_pa.
      wfvat  = wfvat + nv_pa_vat.
      wfstp  = wfstp + nv_pa_stp.
      wfcomm = wfcomm + com_pa.

      
          nv_comp         = 0. 
          nv_comp_stp     = 0. 
          nv_comp_vat     = 0. 
          com_comp        = 0. 
          nv_vol          = 0.   
          nv_vol_stp      = 0.
          nv_vol_vat      = 0. 
          com_vol         = 0. 
          nv_pa           = 0.
          nv_pa_stp       = 0.
          nv_pa_vat       = 0.
          com_pa          = 0.
          pol_prem        = 0.
          nv_stp          = 0.
          nv_vat          = 0.
          nv_comm         = 0.


   END.   /* IF "70"  */
   ELSE DO:   /* NON MOTOR  */

     IF acm001.prem  > 0 THEN nv_seq = 8.
     ELSE nv_seq = 9.
     
          FIND FIRST wfbyline WHERE 
                     wfseq     = nv_seq  AND
                     wfpoltyp  = substr(acm001.policy,3,2) 

              NO-ERROR.
                IF NOT AVAILABLE wfbyline THEN do:
                   CREATE wfbyline.
                   ASSIGN wfseq = nv_seq
                          wfpoltyp = SUBSTR(acm001.policy,3,2).
                         
                END.    

             wfprem = wfprem + acm001.prem.
             
             
             
          IF SUBSTR(acm001.policy,3,2) <> "60"    AND
             SUBSTR(acm001.policy,3,2) <> "61"    AND
             SUBSTR(acm001.policy,3,2) <> "62"    AND
             SUBSTR(acm001.policy,3,2) <> "63"    AND
             SUBSTR(acm001.policy,3,2) <> "64"    AND
             SUBSTR(acm001.policy,3,2) <> "67"    THEN 

               wfvat   = wfvat + acm001.tax.

         ELSE  wfsbt   = wfsbt + acm001.tax.

             wfstp  = wfstp + acm001.stamp. 
             wfcomm = wfcomm + acm001.comm. 



   END.   /* non-motor  */
   
 END.  /* end each acm001 */

 
     

 FOR EACH wfbyline BREAK BY wfseq BY wfpoltyp.
   
    nv_row = nv_row + 1.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X1;K" '"' wfseq  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X2;K" '"' wfdesc  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X3;K" '"' wfpoltyp  '"' SKIP.

    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X4;K" '"' wfprem  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X5;K" '"' wfstp  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X6;K" '"' wfvat  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X7;K" '"' wfsbt '"' SKIP.
   
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X8;K" '"' wfprem + wfvat '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X9;K" '"' wfprem - wfsbt '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X10;K" '"' wfcomm  '"' SKIP.
    PUT STREAM ns1 "C;Y" STRING(nv_row)  ";X11;K" '"' wfprem + wfvat + wfstp - wfcomm '"' SKIP.
   END.

PUT STREAM  ns1  "E"  SKIP.
OUTPUT STREAM ns1 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

