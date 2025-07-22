&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wacrfac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wacrfac 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 
/************************************************************************/  
/* WACRFAC.W    : REPORT FAC. OUT BY RI COMPANY                         */  
/* Copyright    : Safety Insurance Public Company Limited               */  
/*                            บริษัท ประกันคุ้มภัย จำกัด (มหาชน)        */  
/* CREATE BY    : Amparat C.   ASSIGN A53-0316  DATE 08/10/2010         */  
/************************************************************************/  

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
DEF BUFFER buwm130 FOR uwm130.
DEF BUFFER cuwm130 FOR uwm130.

DEF VAR nv_Company      AS CHAR.
DEF VAR nv_poltyp       AS CHAR.
DEF VAR nv_recid        AS RECID NO-UNDO.
DEF VAR n_304id         AS RECID.
DEF VAR nv_recid304     AS RECID.

DEF VAR nv_policy       LIKE uwm100.policy.
DEF VAR nv_rencnt       LIKE uwm100.rencnt.
DEF VAR nv_endcnt       LIKE uwm100.endcnt.

DEF VAR n_fptr          AS RECID.
DEF VAR nv_txtuwd102    AS CHAR INIT "".
DEF VAR nv_agent        AS CHAR INIT "" FORMAT "x(100)". /*Suthida t. A52-0028*/

DEF VAR n_locn          AS CHAR FORMAT "X(500)".
DEF VAR n_distn         AS CHAR FORMAT "X(2)".
DEF VAR n_provn         AS CHAR FORMAT "X(2)".
DEF VAR n_bloks         AS CHAR FORMAT "X(6)".
DEF VAR n_ownten        AS CHAR INIT "" FORMAT "X(1)".
DEF VAR n_attpr         AS LOGI INIT NO.
DEF VAR n_fire          AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_other         AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_fedi          AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_tot           AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_tot1          AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_tot2          AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_tot3          AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_grand         AS DEC  FORMAT ">>,>>>,>>9.99-".
DEF VAR n_grant         AS DEC  FORMAT ">,>>>,>>>,>>9.99-".
DEF VAR n_total         AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_uom1          AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_uom2          AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_uom3          AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_uom4          AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_uom5          AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_sigr          AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_date1         AS CHAR FORMAT "X(10)". 
DEF VAR n_comdat        AS CHAR FORMAT "X(10)".
DEF VAR n_expdat        AS CHAR FORMAT "X(10)".
DEF VAR n_trndat        AS CHAR FORMAT "X(10)".
DEF VAR n_accdat        AS CHAR FORMAT "X(10)".

DEF VAR n_uom1v         LIKE uwm130.uom1_v.
DEF VAR n_sitot         LIKE uwm120.sigr.
DEF VAR n_cotot         LIKE uwm120.sico.

DEF VAR n_mrisk      AS LOGI INIT NO.

DEF VAR n_storey  AS CHAR FORMAT "X(2)".
DEF VAR n_wall    AS CHAR FORMAT "X(20)".
DEF VAR n_floor   AS CHAR FORMAT "X(20)".
DEF VAR n_beam    AS CHAR FORMAT "X(20)".
DEF VAR n_roof    AS CHAR FORMAT "X(20)".
DEF VAR n_nohong  AS CHAR FORMAT "X(2)".
DEF VAR n_area    AS CHAR FORMAT ">>9".
DEF VAR n_front   AS INTE FORMAT ">>9".
DEF VAR n_rear    AS INTE FORMAT ">>9".
DEF VAR n_left    AS INTE FORMAT ">>9".
DEF VAR n_right   AS INTE FORMAT ">>9".
DEF VAR n_front2  AS CHAR FORMAT "X(4)".
DEF VAR n_rear2   AS CHAR FORMAT "X(4)".
DEF VAR n_left2   AS CHAR FORMAT "X(4)".
DEF VAR n_right2  AS CHAR FORMAT "X(4)".
DEF VAR n_occupy  AS CHAR FORMAT "X(40)".
DEF VAR n_occupn  AS CHAR FORMAT "X(6)".
DEF VAR n_distct  AS CHAR FORMAT "X(4)".
DEF VAR n_constr  AS CHAR FORMAT "X(2)".

DEF VAR n_ratea   LIKE uwd132.rate .
DEF VAR n_ratec1    LIKE uwd132.rate .
DEF VAR n_rateb   LIKE uwd132.rate .
DEF VAR n_ratec   LIKE uwd132.rate .
DEF VAR n_rated   LIKE uwd132.rate .
DEF VAR n_ratee   LIKE uwd132.rate .
DEF VAR n_ratef   LIKE uwd132.rate .
DEF VAR n_rateg   LIKE uwd132.rate .
DEF VAR n_rateh   LIKE uwd132.rate .

DEF VAR n_rad2    AS CHAR FORMAT "X(10)".
DEF VAR n_rbd2    AS CHAR FORMAT "X(10)".
DEF VAR n_fird2   AS CHAR FORMAT "X(20)".
DEF VAR n_rcd2    AS CHAR FORMAT "X(10)".
DEF VAR n_rdd2    AS CHAR FORMAT "X(10)".
DEF VAR n_othd2   AS CHAR FORMAT "X(20)".

DEF VAR n_rtax_t  AS DECI.
DEF VAR n_rstp_t  AS DECI.
DEF VAR n_pstp    AS DECI.

DEF VAR n_ctext   AS CHAR FORMAT "x(78)" EXTENT 100
                           INIT [" "," "," "," "," "].
DEF VAR n_utext   AS CHAR FORMAT "x(78)" EXTENT 100
                                         INIT [" "," "," "," "," "," "," "," "," "," "," "].
DEF VAR n_tline     AS INTE FORMAT ">>9" INIT 0.
DEF VAR n_cline     AS INTE FORMAT ">>9" INIT 0.
DEF VAR n_utext1  AS CHAR. 
DEF VAR n_utext2  AS CHAR. 
DEF VAR n_ctext1  AS CHAR FORMAT "X(4000)". 

DEF VAR n_etext   AS CHAR FORMAT "x(78)" EXTENT 100
                                         INIT [" "," "," "," "," "," "," "," "," "," "," "].
DEF VAR n_etext1  AS CHAR. 


DEF VAR n_name1   AS CHAR FORMAT "x(4)" . 
DEF VAR n_name2   AS CHAR FORMAT "x(4)" . 
DEF VAR n_poltyp  AS CHAR FORMAT "x(3)" . 
DEF VAR n_bacnam  AS CHAR FORMAT "x(100)" .
DEF VAR n_text    AS CHAR FORMAT "x(5)" . 

DEF VAR n_csftq  AS CHAR.
DEF VAR n_rico   AS CHAR.
DEF VAR n_coins  AS CHAR.
DEF VAR n_TRCode AS CHAR.
DEF VAR n_fcal   AS CHAR.
DEF VAR SUBPOL   AS CHAR.
DEF VAR SUBPOL2   AS CHAR.
DEF VAR n_name   AS CHAR.
DEF VAR n_addr   AS CHAR.
DEF VAR n_column  AS CHAR.
DEF VAR fi_sumsi AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR fi_tprem AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR fi_com1  AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR fi_com2  AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".

DEF VAR nv_Prmrat  AS DEC  FORMAT ">>9.99999-".
DEF VAR nv_surcrat AS DEC  FORMAT ">>9.99999-".
DEF VAR nv_ferat   AS DEC  FORMAT ">>9.99999-".
DEF VAR nv_gap_c   AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_nap      AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_dl1per  AS DECI FORMAT ">>9.99999-".
DEF VAR nv_EndSi   AS DEC  FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR nv_uwm130  AS RECID.
DEF VAR n_endcnt   AS INT.

DEFINE WORKFILE tempfl
       FIELD tpolicy  LIKE uwm200.policy
       FIELD trencnt  LIKE uwm200.rencnt
       FIELD tendcnt  LIKE uwm200.endcnt
       FIELD tc_enct  LIKE uwm200.c_enct
       FIELD t_rico   LIKE uwd200.rico
       FIELD tcsftq   LIKE uwm200.csftq
       FIELD t_abname AS CHAR FORMAT "x(15)"
       FIELD t_si     LIKE uwd200.risi
       FIELD t_sip    LIKE uwd200.risi_p
       FIELD t_pr     LIKE uwd200.ripr FORMAT ">>,>>>,>>9.99-"
       FIELD t_c1     LIKE uwd200.ric1 FORMAT ">>,>>>,>>9.99-"
       FIELD t_c2     LIKE uwd200.ric2 FORMAT ">>,>>>,>>9.99-" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_disp fi_poltyp fi_DateFr fi_DateTo ~
fi_fileName bu_Ok bu_Exit bu_poltyp RECT-604 RECT-605 RECT-607 RECT-608 ~
RECT-629 
&Scoped-Define DISPLAYED-OBJECTS fi_disp fi_poltyp fi_poldes fi_DateFr ~
fi_DateTo fi_fileName 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wacrfac AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_Exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.52
     FONT 6.

DEFINE BUTTON bu_Ok 
     LABEL "OK" 
     SIZE 15 BY 1.52
     FONT 6.

DEFINE BUTTON bu_poltyp 
     IMAGE-UP FILE "Wimage\help":U
     LABEL "" 
     SIZE 3.5 BY 1.05.

DEFINE VARIABLE fi_DateFr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_DateTo AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_disp AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 48.5 BY 1.29
     FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_fileName AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 59 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poldes AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 41.83 BY 1
     BGCOLOR 19 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltyp AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 7.17 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-604
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 84.5 BY 4.76
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-605
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 84.5 BY 2.52
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-607
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.5 BY 2.33
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-608
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.5 BY 2.33
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-629
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 84.5 BY 1.91
     BGCOLOR 3 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_Main
     fi_disp AT ROW 10.67 COL 2 NO-LABEL
     fi_poltyp AT ROW 3.48 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_poldes AT ROW 3.52 COL 35.67 COLON-ALIGNED NO-LABEL
     fi_DateFr AT ROW 4.86 COL 24.67 COLON-ALIGNED NO-LABEL
     fi_DateTo AT ROW 6.24 COL 24.83 COLON-ALIGNED NO-LABEL
     fi_fileName AT ROW 8.29 COL 24.5 COLON-ALIGNED NO-LABEL
     bu_Ok AT ROW 10.43 COL 52.83
     bu_Exit AT ROW 10.43 COL 70.33
     bu_poltyp AT ROW 3.48 COL 33.83
     "Policy Type" VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 3.48 COL 13.33
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Output To File" VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 8.29 COL 10
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Transection Date From" VIEW-AS TEXT
          SIZE 22.67 BY .95 AT ROW 4.91 COL 2.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Report Fire fac. out Thai-Re" VIEW-AS TEXT
          SIZE 36 BY 1.19 AT ROW 1.48 COL 24
          BGCOLOR 3 FGCOLOR 7 FONT 23
     "To" VIEW-AS TEXT
          SIZE 3.17 BY .95 AT ROW 6.19 COL 21.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-604 AT ROW 2.91 COL 2
     RECT-605 AT ROW 7.57 COL 2
     RECT-607 AT ROW 10.05 COL 51.5
     RECT-608 AT ROW 10.05 COL 69
     RECT-629 AT ROW 1 COL 1.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 86.83 BY 11.81.


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
  CREATE WINDOW wacrfac ASSIGN
         HIDDEN             = YES
         TITLE              = "Report Fire fac.out Thai-Re"
         HEIGHT             = 11.81
         WIDTH              = 86.5
         MAX-HEIGHT         = 44.67
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 44.67
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

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT wacrfac:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wacrfac
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_Main
   Custom                                                               */
/* SETTINGS FOR FILL-IN fi_disp IN FRAME fr_Main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_poldes IN FRAME fr_Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacrfac)
THEN wacrfac:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wacrfac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacrfac wacrfac
ON END-ERROR OF wacrfac /* Report Fire fac.out Thai-Re */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wacrfac wacrfac
ON WINDOW-CLOSE OF wacrfac /* Report Fire fac.out Thai-Re */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Exit wacrfac
ON CHOOSE OF bu_Exit IN FRAME fr_Main /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Ok wacrfac
ON CHOOSE OF bu_Ok IN FRAME fr_Main /* OK */
DO:
  IF fi_filename = "" THEN DO:
       MESSAGE "กรุณาระบุชื่อไฟล์" VIEW-AS ALERT-BOX ERROR.
       APPLY "ENTRY" TO fi_filename  IN FRAME fr_main.
       RETURN NO-APPLY.
  END.
  FOR EACH sym003 WHERE sym003.co = "00" NO-LOCK.
      IF sym003.scrhdr BEGINS "ประกันคุ้มภัย"   THEN 
           nv_Company = "2002".
      ELSE nv_Company = "2048".
   END.
   OUTPUT TO VALUE(fi_fileName) .
     EXPORT DELIMITER "|"
     /* 1  */   "Record status"
     /* 2  */   "Coding Code"
     /* 3  */   "Policy no"
     /* 4  */   "sub-policy no."
     /* 5  */   "endorsement no."
     /* 6  */   "transaction code"      
     /* 7  */   "co-insure code"
     /* 8  */   "insured name"
     /* 9  */   "location"
     /* 10 */   "amphoe code"
     /* 11 */   "province code" 
     /* 12 */    "block"
     /* 13 */    "IR/Non-IR"
     /* 14 */    "transaction date"
     /* 15 */    "effective date"
     /* 16 */    "expire date"
     /* 17 */    "original S/I"
     /* 18 */    "premium rate"
     /* 19 */    "surcharge rate"
     /* 20 */    "F.E.discount"
     /* 21 */    "extended premium"
     /* 22 */    "net premium"
     /* 23 */    "special discount"
     /* 24 */    "flag calculate"
     /* 25 */    "tax code"
     /* 26 */    "insurance type"
     /* 27 */    "S/I building"
     /* 28 */    "S/I machinery"
     /* 29 */    "S/I furniture"
     /* 30 */    "S/I stock"
     /* 31 */    "S/I others"
     /* 32 */    "owner/tenant no."
     /* 33 */    "storeys"
     /* 34 */    "occupancy code"
     /* 35 */    "risk code"
     /* 36 */    "class of building"
     /* 37 */    "S/I co-insure"
     /* 38 */    "attachment"
     /* 39 */    "mjrclass"
     /* 40 */    "column"
     /* 41 */    "beam"
     /* 42 */    "floor"
     /* 43 */    "wall"
     /* 44 */    "filler".                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
   OUTPUT CLOSE.
   
  
   RUN PDProcess.

   DISP ""  @ fi_disp WITH FRAME fr_Main. 
   MESSAGE "Export Complete" VIEW-AS ALERT-BOX.
   
   APPLY "ENTRY" TO bu_exit IN FRAME fr_main.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_poltyp wacrfac
ON CHOOSE OF bu_poltyp IN FRAME fr_Main
DO:
   Def   Var    nv_poltyp        As      Char.
   Def   Var    nv_poldes       As      Char.
  
   RUN  Whp\Whpptyp1(INPUT-OUTPUT nv_poltyp , INPUT-OUTPUT nv_poldes).
          fi_poltyp    =  CAPS(nv_poltyp). 
          fi_poldes  =  nv_poldes .          
      DISP  fi_poltyp fi_poldes WITH FRAME fr_main.
      APPLY "ENTRY" TO fi_poltyp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_DateFr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_DateFr wacrfac
ON LEAVE OF fi_DateFr IN FRAME fr_Main
DO:
  fi_datefr = INPUT fi_datefr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_DateTo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_DateTo wacrfac
ON LEAVE OF fi_DateTo IN FRAME fr_Main
DO:
  fi_dateto = INPUT fi_dateto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fileName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fileName wacrfac
ON LEAVE OF fi_fileName IN FRAME fr_Main
DO:
  fi_filename = INPUT fi_filename.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltyp wacrfac
ON LEAVE OF fi_poltyp IN FRAME fr_Main
DO:
  fi_poltyp = CAPS(INPUT  fi_poltyp).   
  DISP fi_poltyp WITH FRAME fr_main.
  nv_poltyp = SUBSTRING(fi_poltyp,2,2).

  FIND poltyp_fil USE-INDEX poltyp01 WHERE poltyp_fil.poltyp =  fi_poltyp NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE poltyp_fil THEN DO:
       ASSIGN 
         fi_poldes  = poltyp_fil.poldes.
       DISPLAY     fi_poldes WITH FRAME  fr_Main.    
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wacrfac 


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
  
  gv_prgid = "WACRFAC".
  gv_prog  = "Report Fac. Out by RI Company".
  RUN  WUT\WUTWICEN (WACRFAC:HANDLE).      
  RUN  WUT\WUTHEAD (WACRFAC:HANDLE,gv_prgid,gv_prog). 
  SESSION:DATA-ENTRY-RETURN   = YES.
/*********************************************************************/ 
  ASSIGN
  fi_DateFr = TODAY
  fi_DateTo = TODAY
  fi_poltyp = "F10"
  nv_poltyp = "10".

  DISP fi_poltyp fi_DateFr fi_DateTo WITH FRAME fr_main.

  FIND poltyp_fil USE-INDEX poltyp01 WHERE poltyp_fil.poltyp =  fi_poltyp NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE poltyp_fil THEN DO:
       ASSIGN 
         fi_poldes  = poltyp_fil.poldes.
       DISPLAY  fi_poldes WITH FRAME  fr_Main.    
    END.

     IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wacrfac  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wacrfac)
  THEN DELETE WIDGET wacrfac.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wacrfac  _DEFAULT-ENABLE
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
  DISPLAY fi_disp fi_poltyp fi_poldes fi_DateFr fi_DateTo fi_fileName 
      WITH FRAME fr_Main IN WINDOW wacrfac.
  ENABLE fi_disp fi_poltyp fi_DateFr fi_DateTo fi_fileName bu_Ok bu_Exit 
         bu_poltyp RECT-604 RECT-605 RECT-607 RECT-608 RECT-629 
      WITH FRAME fr_Main IN WINDOW wacrfac.
  {&OPEN-BROWSERS-IN-QUERY-fr_Main}
  VIEW wacrfac.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcess wacrfac 
PROCEDURE PDProcess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN FRAME fr_main fi_poltyp.

nv_poltyp = SUBSTRING(fi_poltyp,2,2).

FOR EACH uwm100 USE-INDEX uwm10008 
   WHERE uwm100.trndat >=  fi_DateFr 
     AND uwm100.trndat <=  fi_DateTo 
     AND uwm100.Poltyp  =  fi_poltyp
     AND uwm100.releas  = YES NO-LOCK
      BY uwm100.policy 
      BY uwm100.RenCnt
      BY uwm100.Endcnt.

      ASSIGN
       nv_policy = uwm100.policy
       nv_rencnt = uwm100.RenCnt
       nv_endcnt = uwm100.Endcnt.
     /*--- เฉพาะงาน  D = Direct ---*/
     IF SUBSTRING(uwm100.policy,3,2) <> nv_poltyp THEN NEXT.             
     IF SUBSTRING(uwm100.policy,1,1) = "I" OR SUBSTRING(uwm100.policy,1,1) = "C" THEN NEXT.

     fi_disp = "Policy No. " + uwm100.Policy +
               "R/E.Cnt "  + STRING(uwm100.rencnt,"999") + "/" +  STRING(uwm100.endcnt,"999").
     DISP fi_disp  WITH FRAME fr_Main. 

     /*--- Agent ---*/
     FIND FIRST xmm600 WHERE xmm600.acno = uwm100.agent NO-LOCK NO-ERROR.
       IF AVAIL xmm600 THEN nv_agent = TRIM(xmm600.ntitle) + " " + TRIM(xmm600.NAME).
       ELSE nv_agent = " ".
              
     FIND xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = uwm100.acno1 NO-LOCK NO-ERROR.
       IF AVAILABLE xmm600 THEN n_bacnam = xmm600.name.
       ELSE n_bacnam = "".
            
     ASSIGN 
       n_name = ""  
       n_addr = "" 
       SUBPOL = ""
       fi_sumsi = 0 
       nv_EndSi = 0
       nv_dl1per = 0.
     /*--Uwm120--*/
     FOR EACH uwm120  USE-INDEX uwm12001 WHERE
              uwm120.policy = uwm100.policy AND 
              uwm120.RenCnt = uwm100.RenCnt AND 
              uwm120.Endcnt = uwm100.Endcnt NO-LOCK
         BY uwm120.riskno.


         SUBPOL = STRING(uwm120.RiskNO,"9999").  /*---#4----*/
         n_nap    = 0.
         n_nap    = uwm120.gap_r + uwm120.dl1_r + uwm120.dl2_r + uwm120.dl3_r.

         /*--START buwm130---*/
         ASSIGN
           nv_EndSi = 0
           fi_sumsi   = 0   
           nv_gap_c   = 0
           nv_Prmrat  = 0
           nv_surcrat = 0
           nv_ferat   = 0.
         /*--Uwm130--*/
         FOR EACH uwm130 USE-INDEX uwm13001 WHERE
                  uwm130.policy = uwm120.policy  AND
                  uwm130.rencnt = uwm120.RenCnt  AND
                  uwm130.endcnt = uwm120.Endcnt  AND 
                  uwm130.riskno = uwm120.riskno  NO-LOCK         
             BY uwm130.RiskNo
             BY uwm130.ItemNo.
             /*---#6 #7---*/
             IF uwm100.coins = YES THEN DO:      
                n_trcode = "3N".   
                n_coins  = "1".
                IF uwm100.rencnt <> 0 THEN n_trcode = "3R".
                ELSE IF uwm100.endcnt <> 0 THEN n_trcode = "31".
             END.
             ELSE DO:
                IF uwm120.fptr02 <> 0 THEN do:
                    n_trcode = "3N".   
                    n_coins  = "1".
                    IF uwm100.rencnt <> 0 THEN n_trcode = "3R".
                    ELSE IF uwm100.endcnt <> 0 THEN n_trcode = "31".
                END.
                ELSE DO: n_coins = "".
                    IF uwm130.Riskno <> 1 THEN DO:         
                       IF uwm100.rencnt <> 0 THEN n_trcode = "2R".
                       ELSE n_trcode = "2N".
                    END.
                    ELSE DO:
                       IF uwm100.rencnt <> 0 THEN n_trcode = "1R".
                       ELSE IF uwm100.endcnt <> 0 THEN n_trcode = "11".
                       ELSE n_trcode = "1N".
                    END.
                END.
             END.
             
             IF uwm100.dl1cod = "D" THEN  nv_dl1per = uwm130.dl1per.
             ELSE nv_dl1per = 0.

             IF uwm100.poltyp = "M11" THEN n_poltyp = "I". 
             ELSE IF uwm100.poltyp = "M20" THEN n_poltyp = "I". 
             ELSE  n_poltyp = "N".

             ASSIGN
                 n_trndat = ""
                 n_comdat = ""
                 n_expdat = ""
                 n_name   = ""
                 n_addr   = "".
             ASSIGN
                 n_trndat = SUBSTRING(STRING(YEAR(uwm100.trndat) + 543),3,2)  +  STRING(MONTH(uwm100.trndat),"99") +  STRING(DAY(uwm100.trndat),"99")
                 n_comdat = SUBSTRING(STRING(YEAR(uwm100.Comdat) + 543),3,2)  +  STRING(MONTH(uwm100.Comdat),"99") +  STRING(DAY(uwm100.Comdat),"99")
                 n_expdat = SUBSTRING(STRING(YEAR(uwm100.Expdat) + 543),3,2)  +  STRING(MONTH(uwm100.Expdat),"99") +  STRING(DAY(uwm100.Expdat),"99")
                 n_name   = TRIM(uwm100.ntitle + " " +  uwm100.fname + " " + uwm100.name1)
                 n_addr   = TRIM(uwm100.addr1 + " " + uwm100.addr2 + " " + uwm100.addr3 + " " + uwm100.addr4) .

             IF YEAR(uwm100.Expdat) - YEAR(uwm100.Comdat) = 1 THEN n_fcal   = "0".
             ELSE n_fcal   = "1".

             /*--buwm130--*/
             FIND FIRST buwm130 USE-INDEX uwm13001 WHERE
                        buwm130.policy = uwm130.policy  AND
                        buwm130.rencnt = uwm130.rencnt  AND
                        buwm130.endcnt = uwm130.endcnt  AND
                        buwm130.riskno = uwm130.riskno  AND
                        buwm130.itemno = uwm130.itemno  NO-LOCK NO-ERROR.
               IF AVAIL buwm130 THEN DO:
                  IF buwm130.endcnt > 0  THEN DO:
                      n_endcnt = buwm130.endcnt - 1 .
                      FIND FIRST cuwm130 USE-INDEX uwm13001 WHERE
                                 cuwm130.policy = buwm130.policy  AND
                                 cuwm130.rencnt = buwm130.rencnt  AND
                                 cuwm130.endcnt = n_endcnt        AND
                                 cuwm130.riskno = buwm130.riskno  AND
                                 cuwm130.itemno = buwm130.itemno  NO-LOCK NO-ERROR.
                       IF AVAIL cuwm130 THEN DO:
                          IF cuwm130.uom1_c = "SI" THEN  nv_EndSi = nv_EndSi +  cuwm130.uom1_v.
                       END.
                  END.
                  
                  IF buwm130.uom1_c = "SI" THEN  fi_sumsi = fi_sumsi +  buwm130.uom1_v.
                                    

                  IF buwm130.i_text = "F01"  THEN n_uom1 = buwm130.uom1_v.
                  ELSE IF buwm130.i_text = "F02" THEN n_uom2 = buwm130.uom1_v.
                  ELSE IF buwm130.i_text = "F03" THEN n_uom3 = buwm130.uom1_v.
                  ELSE IF buwm130.i_text = "F04" THEN n_uom4 = buwm130.uom1_v.
                  ELSE n_uom5 = buwm130.uom1_v.

                  IF buwm130.fptr03 <> 0 THEN DO:
                     FIND uwd132 WHERE RECID(uwd132) = buwm130.fptr03 NO-ERROR.
                          REPEAT :
                             n_fptr = uwd132.fptr.                   
                             IF buwm130.itemno = 1 THEN DO:
                                IF uwd132.bencod = "FIRE" THEN nv_Prmrat = uwd132.rate.
                                IF uwd132.bencod = "SURC" THEN nv_surcrat =  uwd132.rate .
                                IF uwd132.bencod = "FEDI" THEN nv_ferat =   uwd132.rate .
                             END.
                             IF uwd132.bencod = "FIRE" THEN  DO:
                                n_ratea = n_ratea + uwd132.rate .
                                nv_gap_c = nv_gap_c + uwd132.gap_c.
                             END.

                             IF n_fptr = 0 THEN LEAVE.
                             FIND uwd132 WHERE RECID(uwd132) = n_fptr NO-ERROR.

                          END. /*--Repeat--*/
                  END. /*--buwm130.fptr03--*/   

                  IF nv_gap_c < 400 THEN   nv_Prmrat = 0.

               END. /*--Avail buwm130--*/
               
             ASSIGN
               n_mrisk  = NO
               n_storey = ""
               n_wall   = ""
               n_floor  = ""
               n_beam   = ""
               n_roof   = ""
               n_nohong = ""
               n_area   = ""
               n_front  = 0
               n_rear   = 0
               n_left   = 0
               n_right  = 0
               n_occupy = ""
               n_occupn = ""
               n_distct = ""
               n_constr = ""
               n_rad2   = ""
               n_rbd2   = ""
               n_fird2  = ""
               n_rcd2   = ""
               n_rdd2   = ""
               n_othd2  = "".
             /*--uwm304--*/
             FIND FIRST uwm304 USE-INDEX uwm30401 WHERE
                        uwm304.policy = uwm130.policy AND
                        uwm304.rencnt = uwm130.rencnt AND
                        uwm304.endcnt = uwm130.endcnt AND
                        uwm304.riskgp = 0             AND
                        uwm304.riskno = uwm130.riskno NO-LOCK  NO-ERROR.
               IF AVAIL uwm304 THEN DO:                  
                  IF uwm304.ownten = "O" THEN n_ownten = "O".
                  ELSE  n_ownten = "T".     
                  
                  ASSIGN
                    n_locn = uwm304.locn1 + " " +
                             uwm304.locn2 + " " +
                             uwm304.locn3.

                  IF uwm304.fptr02 <> 0 THEN DO:
                     FIND uwd141 WHERE RECID(uwd141) = uwm304.fptr02 NO-LOCK NO-ERROR.
                       IF AVAIL uwd141 THEN DO:
                          n_distn = uwd141.dist_n. 
                          n_provn = uwd141.prov_n. 
                          n_bloks = SUBSTRING(uwd141.blok_n,1,4) + "/" + uwd141.sblok_n.
                       END.  /*uwd141*/
                  END.  /*uwm304.fptr02*/
                  ASSIGN
                    n_storey = uwm304.storey
                    n_wall   = uwm304.wall  
                    n_floor  = uwm304.floor 
                    n_beam   = uwm304.beam  
                    n_roof   = uwm304.roof 
                    n_column = ""
                    n_occupy = uwm304.occupy 
                    n_occupn = uwm304.occupn 
                    n_distct = uwm304.distct 
                    n_constr = uwm304.constr  .

                  IF n_constr = "1"  THEN n_column = "1".
                  ELSE n_column = "3".

               END. /*---Avail uwm304---*/            

         END. /*---uwm130---*/

         /*MESSAGE uwm120.policy uwm120.riskno fi_sumsi nv_endsi VIEW-AS ALERT-BOX.*/

         fi_sumsi = fi_sumsi - nv_EndSi. 
         /*--Export DATA--*/    
         OUTPUT TO VALUE(fi_filename) APPEND .  
         EXPORT DELIMITER "|"  
           /* 1  */  ""                   /* Record status        */   
           /* 2  */  nv_Company           /* Coding Code          */   
           /* 3  */  TRIM(uwm100.Policy)  /* Policy no            */   
           /* 4  */  SUBPOL               /* sub-policy no.       */   
           /* 5  */  uwm100.endno         /* endorsement no.      */   
           /* 6  */  TRIM(n_trcode)       /* transaction code     */     
           /* 7  */  n_coins              /* co-insure code       */   
           /* 8  */  n_name               /* insured name         */   
           /* 9  */  n_addr               /* location             */   
           /* 10 */  n_distn              /* amphoe code          */       
           /* 11 */  n_provn              /* province code        */       
           /* 12 */  n_bloks              /* block                */       
           /* 13 */  ""                   /* IR = "I"/Non-IR = "N"*/       
           /* 14 */  n_trndat             /* transaction date     */   
           /* 15 */  n_comdat             /* effective date       */   
           /* 16 */  n_expdat             /* expire date          */   
           /* 17 */  fi_sumsi             /* original S/I         */                        
           /* 18 */  nv_Prmrat             /* premium rate         */   
           /* 19 */  nv_surcrat             /* surcharge rate       */   
           /* 20 */  nv_ferat             /* F.E.discount         */   
           /* 21 */  ""                   /* extended premium  : Prm. amount for extended perils   */   
           /* 22 */   uwm120.prem_r /*n_nap */               /* net premium          */   
           /* 23 */  nv_dl1per                   /* special discount     */   
           /* 24 */  ""                   /* flag calculate       */   
           /* 25 */  0                    /*n_fcal               /* tax code             */   */
           /* 26 */  ""                   /* insurance type       */   
           /* 27 */  0                    /*n_uom1               /* S/I building         */   */
           /* 28 */  0                    /*n_uom4               /* S/I machinery        */   */
           /* 29 */  0                    /*n_uom2               /* S/I furniture        */   */
           /* 30 */  0                    /*n_uom3               /* S/I stock            */   */
           /* 31 */  0                    /*n_uom5               /* S/I others           */   */
           /* 32 */  n_ownten             /* owner/tenant no.     */   
           /* 33 */  ""                   /*n_storey             /* storeys              */   */
           /* 34 */  n_occupn             /* occupancy code       */   
           /* 35 */  ""                    /* risk code            */   
           /* 36 */  n_constr             /* Construction. class of building    */   
           /* 37 */  0                    /*uwm100.sigr_p        /* S/I co-insure        */   */
           /* 38 */  ""                   /* attachment           */   
           /* 39 */  "F"                  /* mjrclass             */   
           /* 40 */  n_column             /* Construction.. 1=1 , 3 column               */   
           /* 41 */  n_beam               /* beam                 */   
           /* 42 */  n_floor              /* floor                */   
           /* 43 */  n_wall               /* wall                 */   
           /* 44 */  ""  .                /* filler.              */   

           OUTPUT CLOSE. 
     END. /*--For Each uwm120--*/

END. /*--For Each uwm100--*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

