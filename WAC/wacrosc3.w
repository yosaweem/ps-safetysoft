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

  Created: Benjaporn J. A59-0007 Date 22/03/2016
         : ใช้เปรียบเทียบผลต่างระหว่างเดือน       
  
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

DEF VAR nv_mth1   AS INT  FORMAT ">9".
DEF VAR nv_mth2   AS INT  FORMAT ">9".
DEF VAR nv_yr1    AS INT  FORMAT ">>>9".
DEF VAR nv_yr2    AS INT  FORMAT ">>>9".
DEF VAR nv_mthbef AS INT  FORMAT ">9".
DEF VAR nv_yrbef  AS INT  FORMAT ">>>9".
DEF VAR nv_macc   AS CHAR FORMAT "X(10)".
DEF VAR nv_sacc1  AS CHAR FORMAT "X(3)".
DEF VAR nv_sacc2  AS CHAR FORMAT "X(3)".

DEF BUFFER bfnm002 FOR fnm002.
DEF WORKFILE wfos 
    /*---เดือนแรก---*/
    FIELD wtype1    AS CHAR FORMAT "X(4)"
    FIELD wbranch1  AS CHAR FORMAT "X(2)"
    FIELD wpoltyp1  AS CHAR FORMAT "X(4)"
    FIELD wmacc1    AS CHAR FORMAT "X(10)"
    FIELD wsacc11   AS CHAR FORMAT "X(3)"
    FIELD wsacc21   AS CHAR FORMAT "X(3)"
    FIELD wgross1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wrec1     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wnet1     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wpadind1  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wrecind1  AS DECI FORMAT "->>,>>>,>>>,>>9.99"

     /*---เดือนสอง---*/
    FIELD wtype2    AS CHAR FORMAT "X(4)"
    FIELD wbranch2  AS CHAR FORMAT "X(2)"
    FIELD wpoltyp2  AS CHAR FORMAT "X(4)"
    FIELD wmacc2    AS CHAR FORMAT "X(10)"
    FIELD wsacc12   AS CHAR FORMAT "X(3)"
    FIELD wsacc22   AS CHAR FORMAT "X(3)"
    FIELD wgross2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wrec2     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wnet2     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wpadind2  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wrecind2  AS DECI FORMAT "->>,>>>,>>>,>>9.99"

    /*--ผลต่าง--*/
    FIELD wtype    AS CHAR FORMAT "X(4)"
    FIELD wbranch  AS CHAR FORMAT "X(2)"
    FIELD wpoltyp  AS CHAR FORMAT "X(4)"
    FIELD wmacc    AS CHAR FORMAT "X(10)"
    FIELD wsacc1   AS CHAR FORMAT "X(3)"
    FIELD wsacc2   AS CHAR FORMAT "X(3)"
    FIELD wgross   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wrec     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wnet     AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wpadind  AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wrecind  AS DECI FORMAT "->>,>>>,>>>,>>9.99".

/*---Input Parameter ---*/
DEF VAR nv_amount AS DECI FORMAT "->>,>>>,>>>,>>9.99".
DEF VAR nv_bran   AS CHAR FORMAT "x(2)".
DEF VAR nv_prgrp  AS INT  FORMAT "9".
DEF VAR nv_gldat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_jvdat  AS DATE FORMAT "99/99/9999".
DEF VAR nv_source AS CHAR FORMAT "x(2)".
/*---end input parameter--*/

DEF VAR n_ac1     AS CHAR.
DEF VAR n_ac2     AS CHAR.
DEF VAR n_ac3     AS CHAR. 
DEF VAR nv_dc     AS LOGICAL.

DEF VAR nv_output AS CHAR FORMAT "x(30)".
DEF VAR jv_output AS CHAR FORMAT "x(30)".

DEF VAR n_mth1     AS CHAR FORMAT "X(6)".
DEF VAR n_mth2     AS CHAR FORMAT "X(6)".
DEF VAR nn_poltyp  AS CHAR FORMAT "X(2)".

DEF VAR n_gross2   AS DEC.
DEF VAR n_rec2     AS DEC.
DEF VAR n_net2     AS DEC.
DEF VAR n_padind2  AS DEC.
DEF VAR n_recind2  AS DEC.

/*--------------- test -------------------*/
DEF WORKFILE wftbl 
    FIELD wtype    AS CHAR FORMAT "X(4)"
    FIELD wbranch  AS CHAR FORMAT "X(2)"
    FIELD wpoltyp  AS CHAR FORMAT "X(4)"   
    FIELD wosyr    AS INT  FORMAT ">>>9"
    FIELD wosmth   AS INT  FORMAT ">9"  
    FIELD wsacc1   AS CHAR FORMAT "X(3)"
    FIELD wsacc2   AS CHAR FORMAT "X(3)"
    FIELD wgross   AS DECI FORMAT "->>,>>>,>>>,>>9.99"
    FIELD wgross1  AS DECI FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wgross2  AS DECI FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wrec1    AS DECI FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wrec2    AS DECI FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wnet1    AS DECI FORMAT "->>,>>>,>>>,>>9.99" 
    FIELD wnet2    AS DECI FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wpadind  AS DECI FORMAT "->>,>>>,>>>,>>9.99"  
    FIELD wrecind  AS DECI FORMAT "->>,>>>,>>>,>>9.99". 


DEF  VAR  nv_sacc11    AS CHAR FORMAT "X(3)"                .
DEF  VAR  nv_sacc21    AS CHAR FORMAT "X(3)"                .
DEF  VAR  nv_gross1    AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_rec1      AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_net1      AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_padind1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_recind1   AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
                                                            
DEF  VAR  nv_sacc12    AS CHAR FORMAT "X(3)"                .
DEF  VAR  nv_sacc22    AS CHAR FORMAT "X(3)"                .
DEF  VAR  nv_gross2    AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_rec2      AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_net2      AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_padind2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .
DEF  VAR  nv_recind2   AS DECI FORMAT "->>,>>>,>>>,>>9.99"  .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frmain

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_jvdat fi_month1 fi_year1 fi_month2 ~
fi_year2 fi_output bt_ok bt_cancel recOutput-7 RecOK-4 RecOK-5 recOutput-9 ~
recOutput-11 recOutput-12 
&Scoped-Define DISPLAYED-OBJECTS fi_jvdat fi_month1 fi_year1 fi_month2 ~
fi_year2 fi_output 

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

DEFINE VARIABLE fi_jvdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_month1 AS INTEGER FORMAT ">>":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_month2 AS INTEGER FORMAT ">>":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_year1 AS INTEGER FORMAT ">>>>":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_year2 AS INTEGER FORMAT ">>>>":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE RECTANGLE RecOK-4
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RecOK-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.5 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE recOutput-11
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 27 BY 3.52
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-12
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 27 BY 3.52
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-7
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 62 BY 1.81
     BGCOLOR 8 .

DEFINE RECTANGLE recOutput-9
     EDGE-PIXELS 4 GRAPHIC-EDGE    
     SIZE 44 BY 1.81
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frmain
     fi_jvdat AT ROW 4.1 COL 33.67 COLON-ALIGNED NO-LABEL
     fi_month1 AT ROW 7.48 COL 18 COLON-ALIGNED NO-LABEL
     fi_year1 AT ROW 8.86 COL 18 COLON-ALIGNED NO-LABEL
     fi_month2 AT ROW 7.48 COL 53 COLON-ALIGNED NO-LABEL
     fi_year2 AT ROW 8.91 COL 52.83 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 11.14 COL 24.5 COLON-ALIGNED NO-LABEL
     bt_ok AT ROW 13.14 COL 17.33
     bt_cancel AT ROW 13.14 COL 40.67
     " Output To  :" VIEW-AS TEXT
          SIZE 17.17 BY 1.19 AT ROW 11.1 COL 7.83
          BGCOLOR 8 FONT 2
     "  Data Betaween" VIEW-AS TEXT
          SIZE 21.5 BY 1.19 AT ROW 5.67 COL 25.17
          BGCOLOR 3 FGCOLOR 15 FONT 2
     " And" VIEW-AS TEXT
          SIZE 6.5 BY 1.19 AT ROW 8.19 COL 33
          BGCOLOR 3 FGCOLOR 15 FONT 2
     " Year2 :" VIEW-AS TEXT
          SIZE 11.33 BY 1.19 AT ROW 8.81 COL 42.67
          BGCOLOR 8 FONT 2
     " Month2 :" VIEW-AS TEXT
          SIZE 11.83 BY 1.19 AT ROW 7.38 COL 41.33
          BGCOLOR 8 FONT 2
     "            AUTO POST JV O/S CLAIM TO G/L" VIEW-AS TEXT
          SIZE 70.17 BY 1.52 AT ROW 1.62 COL 1
          BGCOLOR 1 FGCOLOR 7 FONT 2
     " Year1 :" VIEW-AS TEXT
          SIZE 11.5 BY 1.19 AT ROW 8.76 COL 7.17
          BGCOLOR 8 FONT 2
     " Month1 :" VIEW-AS TEXT
          SIZE 12 BY 1.19 AT ROW 7.38 COL 6
          BGCOLOR 8 FONT 2
     "JV DATE  :" VIEW-AS TEXT
          SIZE 13.83 BY 1.19 AT ROW 4.05 COL 19.33
          BGCOLOR 8 FONT 2
     recOutput-7 AT ROW 10.76 COL 6
     RecOK-4 AT ROW 12.95 COL 39.83
     RecOK-5 AT ROW 12.95 COL 16.5
     recOutput-9 AT ROW 3.67 COL 14.33
     recOutput-11 AT ROW 6.91 COL 5.33
     recOutput-12 AT ROW 6.91 COL 40.17
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 70.33 BY 14.62
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
         TITLE              = ""
         HEIGHT             = 14.43
         WIDTH              = 70
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
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win
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

    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bt_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_ok C-Win
ON CHOOSE OF bt_ok IN FRAME frmain /* OK */
DO:

  IF nv_jvdat = ? THEN DO:
     MESSAGE " ** Please Enter JV Date ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_jvdat IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF nv_mth1 = 0  OR 
     nv_mth1 > 12 THEN DO:
     MESSAGE " ** Please Enter Month ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_month1 IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF nv_mth2 = 0  OR 
     nv_mth2 > 12 THEN DO:
     MESSAGE " ** Please Enter Month ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_month2 IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF nv_yr1 = 0     OR 
     nv_yr1 < 1988  THEN DO:
     MESSAGE "** Please Enter Year ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_year1 IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  IF nv_yr2 = 0     OR 
     nv_yr2 < 1988  THEN DO:
     MESSAGE "** Please Enter Year ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_year2 IN FRAM frmain.
     RETURN NO-APPLY.
  END.
 
  IF nv_output = "" THEN DO:
     MESSAGE "** Please Enter File Name ** " VIEW-AS ALERT-BOX.
     APPLY "ENTRY" TO fi_output IN FRAM frmain.
     RETURN NO-APPLY.
  END.

  /* --------- end check data ----------- */  

  RUN PD_Process .

    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_jvdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_jvdat C-Win
ON LEAVE OF fi_jvdat IN FRAME frmain
DO:

  ASSIGN fi_jvdat = INPUT fi_jvdat 
         nv_jvdat = fi_jvdat .

  DISP fi_jvdat WITH FRAM frmain .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_month1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_month1 C-Win
ON LEAVE OF fi_month1 IN FRAME frmain
DO:

  ASSIGN fi_month1 = INPUT fi_month1 
         nv_mth1   = fi_month1 .

  DISP fi_month1 WITH FRAM frmain .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_month2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_month2 C-Win
ON LEAVE OF fi_month2 IN FRAME frmain
DO:
     ASSIGN fi_month2 = INPUT fi_month2 
            nv_mth2   = fi_month2 .

  DISP fi_month2 WITH FRAM frmain .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME frmain
DO:
  ASSIGN 
      fi_output  = INPUT fi_output
      nv_output  = fi_output .

  DISP fi_output WITH FRAM frmain .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year1 C-Win
ON LEAVE OF fi_year1 IN FRAME frmain
DO:
    ASSIGN
        fi_year1 = INPUT fi_year1 
        nv_yr1   = fi_year1.

     DISP fi_year1 WITH FRAM frmain .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year2 C-Win
ON LEAVE OF fi_year2 IN FRAME frmain
DO:
    ASSIGN
     fi_year2 = INPUT fi_year2 
     nv_yr2   = fi_year2.

     DISP fi_year2 WITH FRAM frmain .
       
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

  gv_prgid = "WACROSC3".
  gv_prog  = "Auto Post JV O/S Claim".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  ASSIGN
      fi_jvdat  = TODAY .
      /*rsProcTyp = 1    .*/

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
  DISPLAY fi_jvdat fi_month1 fi_year1 fi_month2 fi_year2 fi_output 
      WITH FRAME frmain IN WINDOW C-Win.
  ENABLE fi_jvdat fi_month1 fi_year1 fi_month2 fi_year2 fi_output bt_ok 
         bt_cancel recOutput-7 RecOK-4 RecOK-5 recOutput-9 recOutput-11 
         recOutput-12 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_Createwfos C-Win 
PROCEDURE pd_Createwfos :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_process C-Win 
PROCEDURE pd_process :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH wfos :
    DELETE wfos.
END.

/*--หาข้อมูล---*/
ASSIGN nv_macc   = ""
       nv_sacc1  = ""
       nv_sacc2  = ""

       /*---input parameter--*/
       nv_jvdat  = fi_jvdat
       nv_mth1   = fi_month1
       nv_yr1    = fi_year1
    
       jv_output = nv_output + ".SLK" 
      
       nv_mthbef = nv_mth2
       nv_yrbef  = nv_yr2.  


/*---เคลียร์ค่า azr516 ก่อน ----*/

FOR EACH azr516 USE-INDEX azr51601  WHERE 
            MONTH(azr516.gldat)   = nv_mth1  AND
            YEAR(azr516.gldat)    = nv_yr1   AND
            (azr516.source        = "C6"     OR 
             azr516.source        = "C7") .
      DELETE azr516.
END.
/*---------------------------*/

RUN pd_Createwfos.   /*---Create Workfile for All Branch , All Poltyp ---*/

FOR EACH fnm002 USE-INDEX fnm00202 WHERE 
         fnm002.osmth  = nv_mth1   AND
         fnm002.osyr   = nv_yr1    NO-LOCK 
    
     BREAK BY fnm002.TYPE  
           BY fnm002.branch
           BY fnm002.poltyp . 
    
    FIND FIRST wfos WHERE  wfos.wtype     = fnm002.TYPE    AND 
                           wfos.wbranch   = fnm002.branch  AND
                           wfos.wpoltyp   = fnm002.poltyp  NO-LOCK NO-ERROR .
    
    IF NOT AVAIL wfos THEN DO:
    
      CREATE wfos.
      ASSIGN wfos.wtype    = fnm002.TYPE
             wfos.wbranch  = fnm002.branch
             wfos.wpoltyp  = fnm002.poltyp  .
    END.
END.

/*-------------------- mth 2 -------------------------*/
FOR EACH fnm002 USE-INDEX fnm00202 WHERE 
         fnm002.osmth  = nv_mth2   AND
         fnm002.osyr   = nv_yr2    NO-LOCK 
  
    BREAK BY fnm002.TYPE  
          BY fnm002.branch
          BY fnm002.poltyp . 
   
   FIND FIRST wfos WHERE  wfos.wtype     =  fnm002.TYPE    AND 
                          wfos.wbranch   =  fnm002.branch  AND
                          wfos.wpoltyp   =  fnm002.poltyp  NO-LOCK NO-ERROR .

   IF NOT AVAIL wfos THEN DO:

        CREATE wfos.
        ASSIGN wfos.wtype    = fnm002.TYPE
               wfos.wbranch  = fnm002.branch
               wfos.wpoltyp  = fnm002.poltyp .
   END.
END.

 /*--------------------------------*/

FIND FIRST cvm002 WHERE cvm002.branch = wfos.wbranch NO-ERROR.
    IF AVAIL cvm002 THEN DO:
      ASSIGN nv_sacc1 = cvm002.class
             nv_sacc2 = cvm002.tariff.
    END.
                   
FOR EACH wfos NO-LOCK .
    
    FIND FIRST  fnm002 WHERE fnm002.TYPE        = wfos.wtype    AND 
                             fnm002.branch      = wfos.wbranch  AND 
                             fnm002.poltyp      = wfos.wpoltyp  AND 
                             fnm002.osyr        = nv_yr1        AND
                             fnm002.osmth       = nv_mth1       NO-LOCK NO-ERROR .
    IF AVAIL fnm002 THEN DO:
       ASSIGN   nv_sacc11     = nv_sacc1
                nv_sacc21     = nv_sacc2      
                nv_gross1     = fnm002.gross                                                
                nv_rec1       = fnm002.trtamt + fnm002.facamt  /*+ fnm002.amt1 */
                /*nv_net1       = fnm002.gross - (fnm002.trtamt + fnm002.facamt + fnm002.amt1)*/
                nv_net1       = nv_gross1 - nv_rec1 .
              /*  nv_padind1    = fnm002.gross                                                
                nv_recind1    = fnm002.trtamt + fnm002.facamt + fnm002.amt1.    */ 
                
    END.
    ELSE DO:
              ASSIGN nv_gross1       = 0
                     nv_rec1         = 0
                     nv_net1         = 0.
    END.

    FIND FIRST  fnm002 WHERE fnm002.TYPE        = wfos.wtype     AND 
                             fnm002.branch      = wfos.wbranch   AND 
                             fnm002.poltyp      = wfos.wpoltyp   AND 
                             fnm002.osyr        = nv_yr2         AND
                             fnm002.osmth       = nv_mth2        NO-LOCK NO-ERROR .
    IF AVAIL fnm002 THEN DO:
       ASSIGN    nv_sacc12     = nv_sacc1      
                 nv_sacc22     = nv_sacc2      
                 nv_gross2     = fnm002.gross                                                
                 nv_rec2       = fnm002.trtamt + fnm002.facamt  /*+ fnm002.amt1 */
                 /*nv_net2       = fnm002.gross - (fnm002.trtamt + fnm002.facamt + fnm002.amt1)*/
                 nv_net2       = nv_gross2 - nv_rec2 .
               /*  nv_padind2    = fnm002.gross                                                
                 nv_recind2    = fnm002.trtamt + fnm002.facamt + fnm002.amt1.  */
    END. 
    ELSE DO:
              ASSIGN nv_gross2       = 0
                     nv_rec2         = 0
                     nv_net2         = 0.
    END.

   /* FIND FIRST cvm002 WHERE cvm002.branch = wfos.wbranch NO-ERROR.
    IF AVAIL cvm002 THEN DO:
      ASSIGN nv_sacc1 = cvm002.class
             nv_sacc2 = cvm002.tariff.
    END.  */

    ASSIGN          
    wfos.wsacc1    =   nv_sacc1
    wfos.wsacc2    =   nv_sacc2
    wfos.wgross1   =   nv_gross1   
    wfos.wgross2   =   nv_gross2 
    wfos.wrec1     =   nv_rec1     
    wfos.wrec2     =   nv_rec2   
    wfos.wnet1     =   nv_net1     
    wfos.wnet2     =   nv_net2   
    /*wfos.wpadind   =   nv_padind1  -  nv_padind2
    wfos.wrecind   =   nv_recind1  -  nv_recind2 . */
    wfos.wpadind   =   wfos.wgross1   -  wfos.wgross2
    wfos.wrecind   =   wfos.wrec1  -  wfos.wrec2 .
   
END.

ASSIGN
       nv_sacc1    = ""        nv_sacc2    = ""
       nv_sacc11   = ""        nv_sacc12   = ""
       nv_sacc21   = ""        nv_sacc22   = ""
       nv_gross1   = 0         nv_gross2   = 0
       nv_rec1     = 0         nv_rec2     = 0
       nv_net1     = 0         nv_net2     = 0  .
     /*  nv_padind1  = 0         nv_padind2  = 0
       nv_recind1  = 0         nv_recind2  = 0 .  */


   ASSIGN n_mth1 = STRING(fi_month1) + "/" + STRING(fi_year1)
          n_mth2 = STRING(fi_month2) + "/" + STRING(fi_year2).

/*--แสดงรายงาน--*/
OUTPUT TO VALUE (jv_output) NO-ECHO .
EXPORT DELIMITER ";"
    "Type " 
    "Branch " 
    "Group " 
    "Sub acc1 " 
    "Sub acc2 "
    "ค้างจ่าย " + n_mth1
    "ค้างรับ " + n_mth1
    "Net " + n_mth1   
    
    "ค้างจ่าย เพิ่มลด"
    "ค้างรับ เพิ่มลด " 
    
    "ค้างจ่าย " + n_mth2
    "ค้างรับ " + n_mth2   
    "Net " + n_mth2.  

OUTPUT CLOSE.

FOR EACH wfos NO-LOCK BREAK BY wfos.wtype
                            BY wfos.wbranch
                            BY wfos.wpoltyp : 

   /*IF wfos.wgross1 = 0  AND 
      wfos.wrec1   = 0  AND 
      wfos.wnet1   = 0  AND 
      wfos.wgross2 = 0  AND 
      wfos.wrec2   = 0  AND 
      wfos.wnet2   = 0  THEN NEXT . */

    IF wfos.wgross1 = 0  OR  
       wfos.wrec1   = 0  OR  
       wfos.wgross2 = 0  OR  
       wfos.wrec2   = 0  THEN NEXT .

   OUTPUT TO VALUE (jv_output)  APPEND NO-ECHO .
   EXPORT DELIMITER ";"
    
    wfos.wtype                                  
    wfos.wbranch                                
    wfos.wpoltyp                                
    "'" + wfos.wsacc1                          
    "'" + wfos.wsacc2                          
    wfos.wgross1       /*  ค้างจ่าย  */          
    wfos.wrec1         /*  ค้างรับ  */           
    wfos.wnet1 

    wfos.wpadind       /*  ค้างจ่าย เพิ่มลด  */
    wfos.wrecind       /*  ค้างรับ เพิ่มลด  */
                       
    wfos.wgross2       /*  ค้างจ่าย  */          
    wfos.wrec2         /*  ค้างรับ  */           
    wfos.wnet2 .       
                
OUTPUT CLOSE.

    /*----------------------------------------------------*/

           
/*---   ค้างจ่ายขึ้นต้นด้วย 2 GROSS  201000xx (DI)   dr-   cr+ 
                                  201100xx (RI)    dr-   cr+     ----*/
     ASSIGN 
     n_ac1 = "201".

     IF wfos.wtype = "D" THEN ASSIGN n_ac2     = "000"
                                     nv_source = "C6".
     ELSE ASSIGN n_ac2     = "100"
                 nv_source = "C7".

     n_ac3     = wfos.wpoltyp.
     nv_macc   = n_ac1 + n_ac2 + n_ac3.
     nv_amount = wfos.wgross.

     IF wfos.wgross > 0  AND nv_source = "C6" THEN nv_dc = NO.
     ELSE nv_dc = YES.

     RUN wac\wacazr (INPUT wfos.wgross, wfos.wbranch, 2, nv_macc, 
                     wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 

/*--- ค้างจ่ายเพิ่ม/ลด ขึ้นต้นด้วย 6 padind 6xx40000 (DI)   dr+   cr- 
                                           6xx41000 (I)    dr+   cr-     ---*/

     IF wfos.wpadind <> 0 THEN DO:
        ASSIGN 
        n_ac1   = "6"
        n_ac2   = wfos.wpoltyp.

        IF wfos.wtype = "D" THEN ASSIGN n_ac3     = "40000"
                                        nv_source = "C6".
        ELSE ASSIGN n_ac3     = "41000"
                    nv_source = "C7".

        nv_macc   = n_ac1 + n_ac2 + n_ac3.
        nv_amount = wfos.wpadind.

        IF wfos.wpadind > 0  THEN nv_dc = YES.
        ELSE nv_dc = NO.

        RUN wac\wacazr2 (INPUT wfos.wpadind, wfos.wbranch, 2, nv_macc, 
                         wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 
     END.

   
/*---  ค้างรับขึ้นต้นด้วย 1 GROSS  105400xx (DI)   dr+   cr- 
                                  105410xx (I)    dr+   cr-   ----*/
    
     IF wfos.wrec <> 0 THEN DO:

        ASSIGN 
        n_ac1 = "105".

        IF wfos.wtype = "D" THEN ASSIGN n_ac2     = "400"
                                        nv_source = "C6".
        ELSE ASSIGN n_ac2     = "410"
                    nv_source = "C7".

        n_ac3     = wfos.wpoltyp.
        nv_macc   = n_ac1 + n_ac2 + n_ac3.
        nv_amount = wfos.wrec.

        IF wfos.wrec > 0  THEN nv_dc = YES.
        ELSE nv_dc = NO.

        RUN wac\wacazr2 (INPUT wfos.wrec, wfos.wbranch, 2, nv_macc, 
                         wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 
     END.

/*---   ค้างรับ เพิ่ม/ลด ขึ้นต้นด้วย 6 recind 6xx50000 (DI)   dr-   cr+ 
                                           6xx51000 (I)    dr-   cr+    ----*/
     IF wfos.wrecind <> 0 THEN DO:

        ASSIGN  n_ac1  = "6"
                n_ac2  = wfos.wpoltyp.

        IF wfos.wtype  = "D" THEN ASSIGN n_ac3     = "50000"
                                         nv_source = "C6".
        ELSE ASSIGN n_ac3     = "51000"
                    nv_source = "C7".

        nv_macc   = n_ac1 + n_ac2 + n_ac3.
        nv_amount = wfos.wrecind.

        IF wfos.wrecind > 0  THEN nv_dc = NO.
        ELSE nv_dc = YES.

        RUN wac\wacazr (INPUT wfos.wrecind, wfos.wbranch, 2, nv_macc, 
                        wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 
     END.

END.

MESSAGE ".. Process Complete .. " VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Process_org C-Win 
PROCEDURE PD_Process_org :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wfos :
    DELETE wfos.
END.

/*--หาข้อมูล---*/
ASSIGN nv_macc   = ""
       nv_sacc1  = ""
       nv_sacc2  = ""

       /*---input parameter--*/
       nv_jvdat  = fi_jvdat
       nv_mth1   = fi_month1
       nv_yr1    = fi_year1
    
       jv_output = nv_output + ".SLK" 
      
       nv_mthbef = nv_mth2
       nv_yrbef  = nv_yr2.  


/*---เคลียร์ค่า azr516 ก่อน ----*/

FOR EACH azr516 USE-INDEX azr51601  WHERE 
            MONTH(azr516.gldat)   = nv_mth1  AND
            YEAR(azr516.gldat)    = nv_yr1   AND
            (azr516.source        = "C6"     OR 
             azr516.source        = "C7") .
      DELETE azr516.
END.
/*---------------------------*/

/*-----------jj
FOR EACH xmm005 NO-LOCK :  /*---Poltyp---*/

    ASSIGN nn_poltyp = SUBSTR(xmm005.poltyp,2,2) .
end jj-------------*/

    FOR EACH fnm002 USE-INDEX fnm00202 WHERE 
             fnm002.osmth  = nv_mth1   AND
             fnm002.osyr   = nv_yr1    /*AND
             fnm002.poltyp = nn_poltyp*/ NO-LOCK 
      
        BREAK BY fnm002.TYPE  
              BY fnm002.branch
              BY fnm002.poltyp . 
         
       FIND FIRST cvm002 WHERE cvm002.branch = fnm002.branch NO-ERROR.
       IF AVAIL cvm002 THEN DO:
          ASSIGN nv_sacc1 = cvm002.class
                 nv_sacc2 = cvm002.tariff.
       END.
      
       FIND FIRST wfos WHERE  wfos.wtype     = fnm002.TYPE    AND 
                              wfos.wbranch   = fnm002.branch  AND
                              wfos.wpoltyp   = fnm002.poltyp  NO-LOCK NO-ERROR .

       IF NOT AVAIL wfos THEN DO:

            CREATE wfos.
            ASSIGN wfos.wtype1    = fnm002.TYPE
                   wfos.wbranch1  = fnm002.branch
                   wfos.wpoltyp1  = fnm002.poltyp
                   wfos.wsacc11   = nv_sacc1 
                   wfos.wsacc21   = nv_sacc2 
                   wfos.wgross1   = fnm002.gross                                       
                   wfos.wrec1     = fnm002.trtamt + fnm002.facamt + fnm002.amt1
                   wfos.wnet1     = fnm002.gross - (fnm002.trtamt + fnm002.facamt + fnm002.amt1)                      
                   wfos.wpadind1  = fnm002.gross 
                   wfos.wrecind1  = fnm002.trtamt + fnm002.facamt + fnm002.amt1. 

            FIND FIRST bfnm002 USE-INDEX fnm00201 WHERE 
                       bfnm002.TYPE   = fnm002.TYPE   AND
                       bfnm002.branch = fnm002.branch AND
                       bfnm002.poltyp = fnm002.poltyp AND
                       bfnm002.osyr   = nv_yrbef      AND
                       bfnm002.osmth  = nv_mthbef     NO-LOCK  NO-ERROR.

            IF AVAIL bfnm002 THEN DO:
               ASSIGN n_gross2       =  0
                      n_rec2         =  0
                      n_net2         =  0
                      n_padind2      =  0
                      n_recind2      =  0

                      n_gross2       = bfnm002.gross
                      n_rec2         = bfnm002.trtamt + bfnm002.facamt + bfnm002.amt1
                      n_net2         = bfnm002.gross - (bfnm002.trtamt + bfnm002.facamt + bfnm002.amt1)          
                      n_padind2      = bfnm002.gross                                              
                      n_recind2      = bfnm002.trtamt + bfnm002.facamt + bfnm002.amt1 . 
                  
            END.     /*---- end find first bfnm002 ----*/ 
          
            ASSIGN wfos.wtype2    = fnm002.TYPE
                   wfos.wbranch2  = fnm002.branch
                   wfos.wpoltyp2  = fnm002.poltyp
                   wfos.wsacc12   = nv_sacc1 
                   wfos.wsacc22   = nv_sacc2 
                   wfos.wgross2   = n_gross2      
                   wfos.wrec2     = n_rec2        
                   wfos.wnet2     = n_net2        
                   wfos.wpadind2  = n_padind2     
                   wfos.wrecind2  = n_recind2 .   
            /* june */
           /* ASSIGN wfos.wtype    = fnm002.TYPE
                   wfos.wbranch  = fnm002.branch
                   wfos.wpoltyp  = xmm005.anlyc2
                   wfos.wsacc1   = nv_sacc1 
                   wfos.wsacc2   = nv_sacc2 
                   wfos.wgross   = fnm002.gross - bfnm002.gross                                        
                   wfos.wrec     = (fnm002.trtamt + fnm002.facamt) - (bfnm002.trtamt + bfnm002.facamt)
                   wfos.wnet     = (fnm002.gross - (fnm002.trtamt + fnm002.facamt)) - (bfnm002.gross - (bfnm002.trtamt + bfnm002.facamt)) 
                   wfos.wpadind  = fnm002.gross - bfnm002.gross
                   wfos.wrecind  = (fnm002.trtamt + fnm002.facamt) - (bfnm002.trtamt + bfnm002.facamt). */ /* june */
                  
                /* june */
             ASSIGN wfos.wtype    = fnm002.TYPE
                    wfos.wbranch  = fnm002.branch
                    wfos.wpoltyp  = fnm002.poltyp
                    wfos.wsacc1   = nv_sacc1 
                    wfos.wsacc2   = nv_sacc2 
                    wfos.wgross   = wfos.wgross1  - wfos.wgross2                                        
                    wfos.wrec     = wfos.wrec1    - wfos.wrec2
                    wfos.wnet     = wfos.wnet1    - wfos.wnet2 
                    wfos.wpadind  = wfos.wpadind1 - wfos.wpadind2
                    wfos.wrecind  = wfos.wrecind1 - wfos.wrecind2 . 
       END.  /* IF NOT AVAIL wfos */

            ASSIGN n_gross2       =  0
                   n_rec2         =  0
                   n_net2         =  0
                   n_padind2      =  0
                   n_recind2      =  0 .

    END.   /*---end each fnm002---*/  
/*---jj
END.  /*---eand each xmm005 ---*/
-------------*/

ASSIGN n_mth1 = STRING(fi_month1) + "/" + STRING(fi_year1)
       n_mth2 = STRING(fi_month2) + "/" + STRING(fi_year2).

/*--แสดงรายงาน--*/
OUTPUT TO VALUE (jv_output) NO-ECHO .
EXPORT DELIMITER ";"
    "Type " 
    "Branch " 
    "Group " 
    "Sub acc1 " 
    "Sub acc2 "
    "ค้างจ่าย " + n_mth1
    "ค้างรับ " + n_mth1
    "Net " + n_mth1   
    
    "ค้างจ่าย เพิ่มลด"
    "ค้างรับ เพิ่มลด " 
    
    "ค้างจ่าย " + n_mth2
    "ค้างรับ " + n_mth2   
    "Net " + n_mth2.  

OUTPUT CLOSE.

FOR EACH wfos NO-LOCK BREAK BY wfos.wtype
                            BY wfos.wbranch1: 
   OUTPUT TO VALUE (jv_output)  APPEND NO-ECHO .
   EXPORT DELIMITER ";"
    
    wfos.wtype1                                  
    wfos.wbranch1                                
    wfos.wpoltyp1                                
    "'" + wfos.wsacc11                           
    "'" + wfos.wsacc21                           
    wfos.wgross1       /*  ค้างจ่าย  */          
    wfos.wrec1         /*  ค้างรับ  */           
    wfos.wnet1                                   
      
    wfos.wpadind       /*  ค้างจ่าย เพิ่มลด  */
    wfos.wrecind       /*  ค้างรับ เพิ่มลด  */
                            
    wfos.wgross2       /*  ค้างจ่าย  */          
    wfos.wrec2         /*  ค้างรับ  */           
    wfos.wnet2 .       
                
OUTPUT CLOSE.

/*---   ค้างจ่ายขึ้นต้นด้วย 2 GROSS  201000xx (DI)   dr-   cr+ 
                                  201100xx (RI)    dr-   cr+     ----*/
     ASSIGN 
     n_ac1 = "201".

     IF wfos.wtype = "D" THEN ASSIGN n_ac2     = "000"
                                     nv_source = "C6".
     ELSE ASSIGN n_ac2     = "100"
                 nv_source = "C7".

     n_ac3     = wfos.wpoltyp.
     nv_macc   = n_ac1 + n_ac2 + n_ac3.
     nv_amount = wfos.wgross.

     IF wfos.wgross > 0  AND nv_source = "C6" THEN nv_dc = NO.
     ELSE nv_dc = YES.

     RUN wac\wacazr (INPUT wfos.wgross, wfos.wbranch, 2, nv_macc, 
                     wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 

/*--- ค้างจ่ายเพิ่ม/ลด ขึ้นต้นด้วย 6 padind 6xx40000 (DI)   dr+   cr- 
                                           6xx41000 (I)    dr+   cr-     ---*/

     IF wfos.wpadind <> 0 THEN DO:
        ASSIGN 
        n_ac1   = "6"
        n_ac2   = wfos.wpoltyp.

        IF wfos.wtype = "D" THEN ASSIGN n_ac3     = "40000"
                                        nv_source = "C6".
        ELSE ASSIGN n_ac3     = "41000"
                    nv_source = "C7".

        nv_macc   = n_ac1 + n_ac2 + n_ac3.
        nv_amount = wfos.wpadind.

        IF wfos.wpadind > 0  THEN nv_dc = YES.
        ELSE nv_dc = NO.

        RUN wac\wacazr2 (INPUT wfos.wpadind, wfos.wbranch, 2, nv_macc, 
                         wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 
     END.

   
/*---  ค้างรับขึ้นต้นด้วย 1 GROSS  105400xx (DI)   dr+   cr- 
                                  105410xx (I)    dr+   cr-   ----*/
    
     IF wfos.wrec <> 0 THEN DO:

        ASSIGN 
        n_ac1 = "105".

        IF wfos.wtype = "D" THEN ASSIGN n_ac2     = "400"
                                        nv_source = "C6".
        ELSE ASSIGN n_ac2     = "410"
                    nv_source = "C7".

        n_ac3     = wfos.wpoltyp.
        nv_macc   = n_ac1 + n_ac2 + n_ac3.
        nv_amount = wfos.wrec.

        IF wfos.wrec > 0  THEN nv_dc = YES.
        ELSE nv_dc = NO.

        RUN wac\wacazr2 (INPUT wfos.wrec, wfos.wbranch, 2, nv_macc, 
                         wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 
     END.

/*---   ค้างรับ เพิ่ม/ลด ขึ้นต้นด้วย 6 recind 6xx50000 (DI)   dr-   cr+ 
                                           6xx51000 (I)    dr-   cr+    ----*/
     IF wfos.wrecind <> 0 THEN DO:

        ASSIGN  n_ac1  = "6"
                n_ac2  = wfos.wpoltyp.

        IF wfos.wtype  = "D" THEN ASSIGN n_ac3     = "50000"
                                         nv_source = "C6".
        ELSE ASSIGN n_ac3     = "51000"
                    nv_source = "C7".

        nv_macc   = n_ac1 + n_ac2 + n_ac3.
        nv_amount = wfos.wrecind.

        IF wfos.wrecind > 0  THEN nv_dc = NO.
        ELSE nv_dc = YES.

        RUN wac\wacazr (INPUT wfos.wrecind, wfos.wbranch, 2, nv_macc, 
                        wfos.wsacc1, wfos.wsacc2, nv_jvdat, nv_source). 
     END.
END.

MESSAGE ".. Process Complete .. " VIEW-AS ALERT-BOX.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

