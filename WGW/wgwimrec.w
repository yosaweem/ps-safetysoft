&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sic_bran         PROGRESS
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

/* CREATE By Chutikarn Date 08/01/2010 Assign: A53-0015 : IMPORT Receipt Date */


DEFINE NEW SHARED WORKFILE wgenerage NO-UNDO
/*    FIELD trndat    AS DATE FORMAT "99/99/9999"                   /*Tran.date (Trandate)*/  */   
   FIELD policy    AS CHAR FORMAT "X(16)"               INIT ""  /*Policy*/
   FIELD prem      AS DECI FORMAT "->>>,>>>,>>>,>>>,>>>,>>9.99" INIT 0 /*Prem*/
   FIELD endern    AS DATE FORMAT "99/99/9999"          INIT ""  /*Receipt Date*/
/*    FIELD endno     AS CHAR FORMAT "X(8)"                INIT ""  /*End No*/     */
/*    FIELD trty11    AS CHAR FORMAT "X(2)"                INIT ""  /*Tran.type*/  */
/*    FIELD docno1    AS CHAR FORMAT "X(7)"                INIT ""  /*Doc.No*/     */
   FIELD rencnt    AS INTE FORMAT ">9"                  INIT 0   /*Renew Count*/
   FIELD endcnt    AS INTE FORMAT "999"                 INIT 0   /*Endcnt Count*/
   FIELD comdat    AS DATE FORMAT "99/99/9999"                   /*Inception (Comdate)*/  
   FIELD expdat    AS DATE FORMAT "99/99/9999"                   /*Expiry (Expdate)*/  
   FIELD insname   AS CHAR FORMAT "X(20)"               INIT ""  /*Insured Name*/
   FIELD rec100    AS RECID                             INIT 0 .
   
DEFINE WORKFILE wdelimi NO-UNDO
   FIELD txt AS CHARACTER FORMAT "X(1000)" INITIAL "".

DEFINE VAR n_hptyp1    AS CHAR.
DEFINE VAR n_hpDestyp1 AS CHAR.

DEFINE STREAM nfile.
DEFINE STREAM nerror.   
DEFINE STREAM nnoterror.
DEFINE STREAM nbatch.   

DEFINE VAR nv_trndat AS DATE      FORMAT "99/99/9999"  INITIAL TODAY NO-UNDO.
DEFINE VAR nv_enttim AS CHARACTER FORMAT "X(08)".

/*DEFINE VAR nv_acno1  AS CHARACTER FORMAT "X(07)"       INITIAL "" NO-UNDO. == Comment By Chutikarn A53-0015 ==*/
DEFINE VAR nv_acno1  AS CHARACTER FORMAT "X(10)"       INITIAL "" NO-UNDO. /*== Add By Chutikarn A53-0015 ==*/
DEFINE VAR nv_line   AS INTEGER   INITIAL 0            NO-UNDO.

DEFINE VAR nv_docno1    AS CHARACTER FORMAT "X(7)"      INITIAL ""  NO-UNDO.
DEFINE VAR nv_branch    AS CHARACTER FORMAT "X(02)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_policy    AS CHARACTER FORMAT "X(12)"     INITIAL ""  NO-UNDO.
DEFINE VAR nv_rencnt    AS INTEGER   FORMAT "99"        INITIAL 0   NO-UNDO.
DEFINE VAR nv_endcnt    AS INTEGER   FORMAT "999"       INITIAL 0   NO-UNDO.
DEFINE VAR nv_delimiter AS LOGICAL                      NO-UNDO.
DEFINE VAR nv_delimitxt AS CHAR FORMAT "X(25)"  INIT "" NO-UNDO.

DEFINE VAR n_count     AS INTEGER.     /*Number Record For Excel*/
DEFINE VAR n_sum       AS INTE INIT 0. /*Nuber Record All is Import*/

/*---- Wantanee A49-0165 28/09/2006 ----*/
DEFINE VAR nv_texterror   AS CHAR FORMAT "X(200)" INIT "". 
DEFINE VAR nv_Bchyr       AS INT  FORMAT "9999"                 INITIAL 0.
/*DEFINE VAR nv_Bchno     AS CHARACTER FORMAT "X/(12)"            INITIAL ""  NO-UNDO. == Comment By Chutikarn A53-0015 ==*/
DEFINE VAR nv_Bchno       AS CHARACTER FORMAT "X(16)"           INITIAL ""  NO-UNDO. /*== Add By Chutikarn A53-0015 ==*/
DEFINE VAR nv_Bchcnt      AS INT FORMAT "99"                    INITIAL 0.

DEFINE VAR nv_poltotal    AS INTEGER                            INITIAL 0   NO-UNDO.
DEFINE VAR nv_polsuccess  AS INTEGER                            INITIAL 0   NO-UNDO.
DEFINE VAR nv_polerror    AS INTEGER                            INITIAL 0   NO-UNDO.

DEFINE VAR  nv_batflg     AS LOG  INIT NO.  /*uzm701.*/
DEFINE VAR  nv_polflg     AS LOG  INIT NO.  /*uwm100.Sucflg*/
DEFINE VAR  nv_txtmsg     AS CHAR FORMAT "X(50)" INIT "".
DEFINE VAR  nv_reccount   AS INTE INIT 0.  

DEFINE VAR  nv_dattime    AS CHAR INIT "". /*8/11/2006*/

DEFINE VAR  nv_acmprem    AS DECI FORMAT "->>>,>>>,>>>,>>>,>>>,>>9.99" INIT 0.
DEFINE VAR  nv_uwmprem    AS DECI FORMAT "->>>,>>>,>>>,>>>,>>>,>>9.99" INIT 0.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_main

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wgenerage

/* Definitions for BROWSE br_main                                       */
&Scoped-define FIELDS-IN-QUERY-br_main policy rencnt endcnt prem comdat expdat endern insname   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_main   
&Scoped-define SELF-NAME br_main
&Scoped-define QUERY-STRING-br_main FOR EACH wgenerage NO-LOCK
&Scoped-define OPEN-QUERY-br_main OPEN QUERY br_main FOR EACH wgenerage NO-LOCK.
&Scoped-define TABLES-IN-QUERY-br_main wgenerage
&Scoped-define FIRST-TABLE-IN-QUERY-br_main wgenerage


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_trndat fi_bran fi_acno1 bu_acno1 ~
fi_prvbatch fi_Bchyr fi_input bu_open fi_output1 fi_output2 fi_output3 ~
fi_policyinput bu_ok bu_exit br_main RECT-1 RECT-2 RECT-262 RECT-263 ~
RECT-264 RECT-266 RECT-267 
&Scoped-Define DISPLAYED-OBJECTS fi_trndat fi_bran fi_brandesc fi_acno1 ~
fi_acdesc fi_prvbatch fi_Bchyr fi_input fi_output1 fi_output2 fi_output3 ~
fi_policyinput fi_policytotal fi_policysuccess fi_batch 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_acno1 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "" 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 14.5 BY 1.14.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 14.5 BY 1.14.

DEFINE BUTTON bu_open 
     LABEL "..." 
     SIZE 4 BY .91.

DEFINE VARIABLE fi_acdesc AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 53.17 BY .91
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_batch AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 32 BY 1.19
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_Bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7.5 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_bran AS CHARACTER FORMAT "XX":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brandesc AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY .91
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_input AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 67.33 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policyinput AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_policysuccess AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_policytotal AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 19 FGCOLOR 2 FONT 36 NO-UNDO.

DEFINE VARIABLE fi_prvbatch AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 23.83 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_trndat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 130 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 130 BY 9.62
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-262
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 128 BY 1.1
     BGCOLOR 1 FGCOLOR 1 .

DEFINE RECTANGLE RECT-263
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 16.5 BY 1.57
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-264
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 16.5 BY 1.57
     BGCOLOR 13 .

DEFINE RECTANGLE RECT-266
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 130 BY 8.1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-267
     EDGE-PIXELS 8  
     SIZE 130 BY 3.86
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_main FOR 
      wgenerage SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_main
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_main C-Win _FREEFORM
  QUERY br_main DISPLAY
      policy    COLUMN-LABEL "Policy"       FORMAT "X(17)"        
rencnt    COLUMN-LABEL "Rencnt"                             
endcnt    COLUMN-LABEL "Endcnt"       
prem      COLUMN-LABEL "Premium" 
comdat    COLUMN-LABEL "Comm.Date"  
expdat    COLUMN-LABEL "Exp.Date"     
endern    COLUMN-LABEL "Receipt Date"
insname   COLUMN-LABEL "Insured Name"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-BOX SEPARATORS SIZE 126 BY 7.14
         BGCOLOR 15 FONT 6.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_trndat AT ROW 3.19 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_bran AT ROW 4.14 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_brandesc AT ROW 4.14 COL 33.67 COLON-ALIGNED NO-LABEL
     fi_acno1 AT ROW 5.1 COL 28.67 COLON-ALIGNED NO-LABEL
     bu_acno1 AT ROW 5.1 COL 48.67
     fi_acdesc AT ROW 5.1 COL 50.67 COLON-ALIGNED NO-LABEL
     fi_prvbatch AT ROW 6.05 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_Bchyr AT ROW 6.05 COL 74.67 COLON-ALIGNED NO-LABEL
     fi_input AT ROW 7 COL 28.67 COLON-ALIGNED NO-LABEL
     bu_open AT ROW 7.19 COL 98.33
     fi_output1 AT ROW 7.95 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 8.91 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 9.86 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_policyinput AT ROW 10.81 COL 28.67 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 4.43 COL 113.5
     bu_exit AT ROW 6.48 COL 113.67
     br_main AT ROW 12.91 COL 4
     fi_policytotal AT ROW 21.48 COL 72.17 COLON-ALIGNED NO-LABEL
     fi_policysuccess AT ROW 22.43 COL 72.17 COLON-ALIGNED NO-LABEL
     fi_batch AT ROW 21.86 COL 16.5 COLON-ALIGNED NO-LABEL
     "IMPORT RECEIPT DATE (วันที่รับเงินจากลูกค้า)" VIEW-AS TEXT
          SIZE 49 BY .57 AT ROW 1.76 COL 5.5
          BGCOLOR 1 FGCOLOR 15 
     "Trandate :" VIEW-AS TEXT
          SIZE 10.5 BY .57 AT ROW 3.48 COL 18.67
          BGCOLOR 8 FGCOLOR 1 
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .57 AT ROW 7.19 COL 6.83
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 13 BY .57 AT ROW 6.24 COL 62.5
          BGCOLOR 8 FGCOLOR 1 
     "Previous Batch No :" VIEW-AS TEXT
          SIZE 19.5 BY .57 AT ROW 6.19 COL 9.67
          BGCOLOR 8 FGCOLOR 1 
     "Branch :" VIEW-AS TEXT
          SIZE 8.5 BY .57 AT ROW 4.43 COL 20.67
          BGCOLOR 8 FGCOLOR 1 
     "Screen Output To File :" VIEW-AS TEXT
          SIZE 23.5 BY .57 AT ROW 10 COL 6
          BGCOLOR 8 FGCOLOR 1 
     "Policy Import Total :" VIEW-AS TEXT
          SIZE 19 BY .57 AT ROW 10.95 COL 9.5
          BGCOLOR 8 FGCOLOR 1 
     "Record Total :" VIEW-AS TEXT
          SIZE 13.5 BY .57 AT ROW 21.67 COL 59.67
          BGCOLOR 8 FGCOLOR 1 
     "Batch No. :" VIEW-AS TEXT
          SIZE 13.33 BY 1.19 AT ROW 21.86 COL 5.17
          BGCOLOR 8 FGCOLOR 1 FONT 36
     "File Completed :" VIEW-AS TEXT
          SIZE 16.33 BY .57 AT ROW 8.1 COL 13
          BGCOLOR 8 FGCOLOR 1 
     "Record Success :" VIEW-AS TEXT
          SIZE 16.67 BY .57 AT ROW 22.62 COL 56.5
          BGCOLOR 8 FGCOLOR 1 
     "File Not Completed :" VIEW-AS TEXT
          SIZE 20.17 BY .57 AT ROW 9.05 COL 9.17
          BGCOLOR 8 FGCOLOR 1 
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .57 AT ROW 5.38 COL 13.17
          BGCOLOR 8 FGCOLOR 1 
     RECT-1 AT ROW 1.24 COL 2
     RECT-2 AT ROW 3.14 COL 3
     RECT-262 AT ROW 1.48 COL 3
     RECT-263 AT ROW 4.19 COL 112.5
     RECT-264 AT ROW 6.24 COL 112.67
     RECT-266 AT ROW 12.43 COL 2
     RECT-267 AT ROW 20.48 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132 BY 23.57
         BGCOLOR 3 FGCOLOR 0 FONT 6.


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
         TITLE              = "Wgwimrec : Import Receipt Date (GwTransfer)"
         HEIGHT             = 23.57
         WIDTH              = 132
         MAX-HEIGHT         = 24
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24
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
/* SETTINGS FOR FRAME fr_main
   Custom                                                               */
/* BROWSE-TAB br_main bu_exit fr_main */
/* SETTINGS FOR FILL-IN fi_acdesc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_batch IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brandesc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policysuccess IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_policytotal IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_main
/* Query rebuild information for BROWSE br_main
     _START_FREEFORM
OPEN QUERY br_main FOR EACH wgenerage NO-LOCK.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Wgwimrec : Import Receipt Date (GwTransfer) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Wgwimrec : Import Receipt Date (GwTransfer) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_acno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_acno1 C-Win
ON CHOOSE OF bu_acno1 IN FRAME fr_main
DO:
   DEF VAR n_acno  AS CHAR.
   DEF VAR n_agent AS CHAR.    
     
   CURRENT-WINDOW:SENSITIVE = NO.  
   RUN whp\whpacno1(OUTPUT n_acno,
                    OUTPUT n_agent).
   CURRENT-WINDOW:SENSITIVE = YES. 
                                          
   IF n_acno <> "" THEN fi_acno1 =  n_acno.      
   Disp  fi_acno1 WITH FRAME  fr_main.
   APPLY "Entry" TO fi_acno1.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   APPLY "Close" TO THIS-PROCEDURE.
   RETURN NO-APPLY.    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
  IF INPUT fi_trndat = ? OR  INPUT fi_trndat = "" THEN DO:
      MESSAGE "Plese Input Trandate...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_trndat.
      RETURN NO-APPLY.
  END.
  
  IF INPUT fi_bran <> "" THEN DO:
      FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE 
                 sicsyac.xmm023.branch = INPUT fi_bran NO-LOCK NO-ERROR.
      IF AVAILABLE sicsyac.xmm023 THEN DO:
          ASSIGN
            fi_bran     = CAPS(INPUT fi_bran)
            fi_brandesc = sicsyac.xmm023.bdes.
          DISPLAY fi_bran fi_brandesc WITH FRAME {&FRAME-NAME}.
      END.
      ELSE DO :
          MESSAGE " Not on Parameters by branch file sicsyac.xmm023...!!!" VIEW-AS ALERT-BOX ERROR.
          APPLY "ENTRY" TO fi_bran.
          RETURN NO-APPLY.
      END.
  END.    
  ELSE DO:
      MESSAGE "Plese Input Branch...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_bran.
      RETURN NO-APPLY.
  END.  

  IF INPUT fi_acno1 <> "" THEN DO:
      fi_acno1 = CAPS(INPUT fi_acno1).
      FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
           sicsyac.xmm600.acno = INPUT fi_acno1  NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL sicsyac.xmm600 THEN DO:
        MESSAGE "Not on Name & Address Master file sicsyac.xmm600...!!!" VIEW-AS ALERT-BOX ERROR.
        DISPLAY fi_acno1  WITH FRAME fr_main.
        APPLY "Entry" TO fi_acno1.
        RETURN NO-APPLY.
      END.
      fi_acdesc = TRIM(TRIM(sicsyac.xmm600.ntitle) + " " + TRIM(sicsyac.xmm600.name)).
      DISPLAY fi_acno1  fi_acdesc  WITH FRAME fr_main.
  END.
  ELSE DO:
      MESSAGE "Plese Input Producer Code...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_acno1.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_prvbatch <> "" THEN DO:
    FIND LAST uzm701 USE-INDEX uzm70102 WHERE
              uzm701.Bchno = INPUT fi_prvbatch NO-LOCK NO-ERROR.
    IF NOT AVAIL uzm701 THEN DO:
       MESSAGE "Not found Batch File Master on file uzm701...!!!" VIEW-AS ALERT-BOX ERROR.
       APPLY "Entry" TO fi_prvbatch.
       RETURN NO-APPLY.
    END.
    ELSE DO: 
       IF uzm701.Bchyr <> INPUT fi_Bchyr THEN DO:
          MESSAGE "Not found Batch File Master on file uzm701 (Year)...!!!" VIEW-AS ALERT-BOX ERROR.
          PAUSE 5 NO-MESSAGE.
          APPLY "Entry" TO fi_Bchyr.
          RETURN NO-APPLY.
       END.
    END.
  END.

  IF INPUT fi_Bchyr <= 0 THEN DO:
      MESSAGE "Batch Year Error...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_Bchyr.
      RETURN NO-APPLY.
  END.                                            

  IF INPUT fi_input <> "" THEN DO:
    IF SEARCH(INPUT fi_input) = ? THEN DO:
      MESSAGE "ไม่พบแฟ้มข้อมูลนี้...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_input.
      RETURN NO-APPLY.
    END.
  END.
  ELSE DO:
      MESSAGE "Plese Input File name Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_input.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_output1 = "" THEN DO:
      MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output1.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_output2 = "" THEN DO:
      MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output2.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_output3 = "" THEN DO:
      MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output3.
      RETURN NO-APPLY.
  END.

  IF INPUT fi_policyinput = 0 THEN DO:
      MESSAGE "Plese Input Policy Import Total...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_policyinput.
      RETURN NO-APPLY.
  END.
  /*------------------*/

  MESSAGE "กด Yes เพื่อ Confirm Process Data  " SKIP
           VIEW-AS ALERT-BOX INFORMATION BUTTONS YES-NO
           TITLE "Information Message" UPDATE choice AS LOGICAL.
  IF NOT choice THEN DO:  
    MESSAGE "ยกเลิกการ Process Data...!!!" VIEW-AS ALERT-BOX INFORMATION.
    NEXT.
  END.
  ELSE DO:
    RUN pd_Process.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_open
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_open C-Win
ON CHOOSE OF bu_open IN FRAME fr_main /* ... */
DO:
   DEFINE VARIABLE nv_cvData    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE nv_OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE nv_cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    "Excel (*.csv)" "*.csv"
                   /*"Excel (*.er)" "*.er",
                   "Text Files (*.txt)" "*.txt",
                   "Data Files (*." + Company.ABName + ")"   "*." + Company.ABName*/
                   
        MUST-EXIST
        USE-FILENAME
        UPDATE nv_OKpressed.
      

   ASSIGN  /*--8/11/2006---*/
       nv_dattime = ""
       nv_dattime = STRING(MONTH(TODAY),"99")    +
                    STRING(DAY(TODAY),"99")      +
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                    SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2).


    IF nv_OKpressed = TRUE THEN DO:
         ASSIGN
            fi_input   = nv_cvData 
            /*--8/11/2006---
            fi_output1 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + "SUCCESS" + ".txt" 
            fi_output2 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + "ERROR"   + ".err" 
            fi_output3 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + "SCREEN"  + ".txt". 
            --8/11/2006--*/           
            fi_output1 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".fuw" 
            fi_output2 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".err" 
            fi_output3 = SUBSTRING(nv_cvData,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".sce".

         DISP fi_output1 fi_output2 fi_output3 fi_input WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno1 C-Win
ON RETURN OF fi_acno1 IN FRAME fr_main
DO:
    ASSIGN fi_acno1.

    IF INPUT fi_acno1 <> "" THEN DO:
        fi_acno1 = CAPS(INPUT fi_acno1).
        FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
             sicsyac.xmm600.acno = INPUT fi_acno1  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
          MESSAGE "Not on Name & Address Master file sicsyac.xmm600" VIEW-AS ALERT-BOX ERROR.
          DISPLAY fi_acno1  WITH FRAME fr_main.
          APPLY "Entry" TO fi_acno1.
          RETURN NO-APPLY.
        END.
        fi_acdesc = TRIM(TRIM(sicsyac.xmm600.ntitle) + " " + TRIM(sicsyac.xmm600.name)).

    END.

    DISPLAY fi_acno1 fi_acdesc  WITH FRAME fr_main.

    APPLY "Entry" TO fi_prvbatch.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bran
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bran C-Win
ON RETURN OF fi_bran IN FRAME fr_main
DO:
  ASSIGN fi_bran.

  fi_bran = CAPS(INPUT fi_bran).
  DISP fi_bran WITH FRAME {&FRAME-NAME}.
  
    IF INPUT fi_bran <> "" THEN DO:
        FIND FIRST sicsyac.xmm023 USE-INDEX xmm02301 WHERE 
                   sicsyac.xmm023.branch = INPUT fi_bran NO-LOCK NO-ERROR.
        IF AVAILABLE sicsyac.xmm023 THEN DO:
             fi_brandesc = sicsyac.xmm023.bdes.
             DISPLAY fi_bran fi_brandesc WITH FRAME {&FRAME-NAME}.
             APPLY "ENTRY" TO fi_acno1.
             RETURN NO-APPLY. 
        END. 
        ELSE DO :
             MESSAGE " Not on Parameters by branch file sicsyac.xmm023 " VIEW-AS ALERT-BOX ERROR.
             APPLY "ENTRY" TO fi_bran.
             RETURN NO-APPLY.
        END.
    END.    
    ELSE DO:
        ASSIGN 
          fi_bran     = "" 
          fi_brandesc = "".
        DISP fi_bran fi_brandesc WITH FRAME {&FRAME-NAME}.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_input
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_input C-Win
ON RETURN OF fi_input IN FRAME fr_main
DO:
    ASSIGN fi_input.
    
    ASSIGN  /*--8/11/2006---*/
        nv_dattime = ""
        nv_dattime = STRING(MONTH(TODAY),"99")    +
                     STRING(DAY(TODAY),"99")      +
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
                     SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2).


    IF INPUT fi_input <> "" THEN DO:
      IF SEARCH(INPUT fi_input) = ? THEN DO:
        MESSAGE "ไม่พบแฟ้มข้อมูลนี้ .." VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_input.
        RETURN NO-APPLY.
      END.
      ELSE DO:
        /*--8/11/2006---
        ASSIGN                              
          fi_output1 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + "SUCCESS" + ".txt"
          fi_output2 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + "ERROR"   + ".err"
          fi_output3 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + "SCREEN"  + ".txt".
        --8/11/2006---*/

        ASSIGN                              
          fi_output1 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".fuw"
          fi_output2 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".err"
          fi_output3 = SUBSTRING(INPUT fi_input,1,(LENGTH(fi_input) - 4)) + nv_dattime + ".sce".

        DISP fi_output1 fi_output2 fi_output3 WITH FRAME fr_main.
        APPLY "Entry" TO fi_output1.
        RETURN NO-APPLY.
      END.
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prvbatch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prvbatch C-Win
ON LEAVE OF fi_prvbatch IN FRAME fr_main
DO:  
    ASSIGN fi_prvbatch = CAPS(INPUT fi_prvbatch).
    DISP fi_prvbatch WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_main
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

/********************  T I T L E   F O R  C - W I N  ***************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wgwimrec".
  gv_prog  = "Load Policy Inward Non-Motor (Biz)".
  RUN  WUT\WUTHEAD (C-Win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (C-Win:handle). 
/********************************************************************/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN
    fi_trndat  = TODAY
    fi_bran    = ""
    fi_Bchyr   = YEAR(TODAY)
    fi_batch   = ""
    fi_acno1   = ""  . 

  DISP fi_trndat fi_bran fi_Bchyr fi_batch fi_acno1  WITH FRAME fr_main.

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
  DISPLAY fi_trndat fi_bran fi_brandesc fi_acno1 fi_acdesc fi_prvbatch fi_Bchyr 
          fi_input fi_output1 fi_output2 fi_output3 fi_policyinput 
          fi_policytotal fi_policysuccess fi_batch 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_trndat fi_bran fi_acno1 bu_acno1 fi_prvbatch fi_Bchyr fi_input 
         bu_open fi_output1 fi_output2 fi_output3 fi_policyinput bu_ok bu_exit 
         br_main RECT-1 RECT-2 RECT-262 RECT-263 RECT-264 RECT-266 RECT-267 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Batch C-Win 
PROCEDURE Pd_Batch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main:
    /***------------ update ข้อมูลที่  uzm701 ------------***/
  
    nv_txtmsg = "".

    IF nv_reccount > 0 THEN DO:
       nv_batflg = NO.
       nv_txtmsg = "have record error..!!".
    END.
    ELSE DO:
        /*--- Check Record ---*/
        IF INPUT fi_policyinput <> nv_poltotal   OR
           INPUT fi_policyinput <> nv_polsuccess OR
           nv_poltotal          <> nv_polsuccess THEN DO: 
           nv_batflg = NO.
           nv_txtmsg = "have batch file error..!!".
        END.
        ELSE nv_batflg = YES.
    END.
    
    
    FIND LAST uzm701 USE-INDEX uzm70102
        WHERE uzm701.Bchyr  = nv_Bchyr  AND
              uzm701.Bchno  = nv_Bchno  AND
              uzm701.Bchcnt = nv_Bchcnt 
    NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
          uzm701.recsuc       = nv_polsuccess 
          uzm701.premsuc      = 0
          uzm701.stampsuc     = 0 /*nv_stmpsuc*/
          uzm701.taxsuc       = 0 /*nv_taxsuc */
          uzm701.com1suc      = 0


          uzm701.rectot       = nv_poltotal
          uzm701.premtot      = 0
          uzm701.stamptot     = 0 /*nv_stmptot*/
          uzm701.taxtot       = 0 /*nv_taxtot */
          uzm701.com1tot      = 0

          uzm701.impflg      = nv_batflg
          uzm701.cnfflg      = nv_batflg
          uzm701.trfflg      = NO
          uzm701.impendtim   = STRING(TIME,"HH:MM:SS").

           /* YES  สามารถนำเข้าข้อมูลได้หมด ไม่มี error  
              NO   นำเข้าข้อมูลได้ไม่ได้ไม่หมด  */         
    END.
      /***---------- END update ข้อมูลที่  uzm701 ---------***/
  END.
  END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Create C-Win 
PROCEDURE Pd_Create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main:

      DO TRANSACTION: 

          DISP "Process Policy : " wgenerage.policy " R/E : " nv_rencnt "/" nv_endcnt 
               WITH COLOR BLACK/WHITE NO-LABEL TITLE "PROCESS..." WIDTH 100 FRAME AMain VIEW-AS DIALOG-BOX.

          /*--------------------BEGIN GENERATE----------------------*/
          RUN pd_uwm100.  /*--UWM100--*/ 
          /*--------------------END GENERATE----------------------*/
          
      END. /*End Transaction*/   
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pd_Import C-Win 
PROCEDURE Pd_Import :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_sum = 0.
DO WITH FRAME fr_main:

    FOR EACH wgenerage:
        DELETE wgenerage.
    END.
    
    IF INPUT fi_output1 <> "" THEN DO:
        /*OUTPUT STREAM nfile TO VALUE(INPUT fi_output1).
        OUTPUT STREAM nfile CLOSE. */
        ASSIGN
         nv_line        = 0 
         fi_batch       = ""
         nv_poltotal    = 0
         nv_polsuccess  = 0
         nv_polerror    = 0

         nv_Bchyr       = 0
         nv_Bchyr       = INPUT fi_Bchyr
         nv_acno1       = INPUT fi_acno1
         nv_branch      = INPUT fi_bran
         n_count        = 0. /*Count Record*/
    END.
/*
    FOR EACH wdelimi:
        DELETE wdelimi.
    END.

    INPUT STREAM nfile FROM VALUE(INPUT fi_input).
    REPEAT:
        CREATE wdelimi.
        IMPORT STREAM nfile wdelimi.
        LEAVE.
    END.    
    INPUT STREAM nfile CLOSE.

    FIND FIRST wdelimi NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE wdelimi THEN DO:
        HIDE MESSAGE NO-PAUSE.
        MESSAGE " Not found data" VIEW-AS ALERT-BOX ERROR.
        NEXT.
        LEAVE.
    END.

    ASSIGN
        nv_line      = 0
        nv_delimiter = NO
        nv_delimitxt = wdelimi.txt.    

    REPEAT:
        IF INDEX(nv_delimitxt,",") <> 0 THEN DO:
            IF nv_line = 0 THEN
                nv_delimitxt = SUBSTRING(wdelimi.txt,INDEX(nv_delimitxt,",") + 1,256).
            ELSE DO:
                nv_delimiter = YES.
                LEAVE.
            END.
            
            nv_line = nv_line + 1.
        END.
        ELSE
            LEAVE.
    END.
    /* END Check data DELIMITER "," */
*/    

    /*IF nv_delimiter = YES THEN DO:*/
        INPUT STREAM nfile FROM VALUE(INPUT fi_input).    
        REPEAT :            
            CREATE wgenerage.
            IMPORT STREAM nfile DELIMITER "," wgenerage.
            n_sum = n_sum + 1.
        END.     
        INPUT STREAM nfile CLOSE.    
    /*END.*/
    
    FIND FIRST wgenerage NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE wgenerage THEN DO:
        MESSAGE " Not found data..." VIEW-AS ALERT-BOX ERROR.
        NEXT.
        LEAVE.
    END.
    ELSE DO:
        /*-- Running Batch file Master , Update field, Trasaction batch no.--*/
        RUN wgw\wgwbatch.p(INPUT        nv_trndat   ,             /* DATE  */
                           INPUT        nv_Bchyr  ,             /* INT   */
                           INPUT        nv_acno1    ,             /* CHAR  */ 
                           INPUT        (INPUT fi_bran)     ,     /* CHAR  */
                           INPUT        (INPUT fi_prvbatch) ,     /* CHAR  */
                           INPUT        "WGWIMPREC"  ,             /* CHAR  */
                           INPUT-OUTPUT nv_Bchno  ,             /* CHAR  */
                           INPUT-OUTPUT nv_Bchcnt   ,             /* INT   */
                           INPUT        (INPUT fi_policyinput)  , /* INT   */
                           INPUT        (0) /*(INPUT fi_preminput) 08/01/2009*/      /* DECI  */
                           ).

        fi_batch = CAPS(nv_Bchno + "." + STRING(nv_Bchcnt,"99")).
        DISP fi_batch WITH FRAME fr_main.
    END.   
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_Process C-Win 
PROCEDURE pd_Process :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME fr_main:

    ASSIGN
     nv_line        = 0 
     fi_batch       = ""
     nv_poltotal    = 0
     nv_polsuccess  = 0
     nv_polerror    = 0     
     
     nv_Bchyr       = 0
     nv_Bchyr       = INPUT fi_Bchyr
     nv_acno1       = INPUT fi_acno1
     nv_branch      = INPUT fi_bran
     n_count        = 0    /*Count record*/
     nv_reccount    = 0 .  /*Count Record Error*/ 
                                           
    RUN Pd_Import. /*IMPORT DATA*/

    OUTPUT STREAM nnoterror TO VALUE(INPUT fi_output1). 
    OUTPUT STREAM nerror    TO VALUE(INPUT fi_output2).    

    PUT STREAM nnoterror   
      "ลำดับที่"     ";"
      "Policy"       ";"
      "Ren.Cnt"      ";"
      "End.cnt"      ";"
      "Premium"      ";"
      "Com Date"     ";"
      "Expiry Date"  ";"
      "Receipt Date" ";"
      "Insured Name" ";"
    SKIP.

    PUT STREAM nerror
      "ลำดับที่"         ";"
      "Policy"           ";"
      "End.cnt"          ";"
      "Premium"          ";"
      "Receipt Date"     ";"
      "รายการข้อผิดพลาด" ";" 
    SKIP.      

    Loop_main:
    FOR EACH wgenerage NO-LOCK:
      ASSIGN
       nv_texterror = ""
       nv_polflg    = YES
       n_count      = n_count + 1. 
      
      IF n_count > n_sum THEN NEXT.
      DISP " Please Wait.... Check Data No. : " TRIM(STRING(n_count)  + "/" + STRING(n_sum))
             WITH COLOR BLACK/WHITE NO-LABEL TITLE "PROCESS..." WIDTH 100 FRAME AAMain VIEW-AS DIALOG-BOX.

      ASSIGN
        nv_policy    = ""
        nv_rencnt    = 0
        nv_endcnt    = 0
        nv_acmprem   = 0
        nv_uwmprem   = 0
        nv_trndat    = TODAY
        nv_enttim    = STRING(TIME,"HH:MM:SS").

      IF wgenerage.policy = "" AND  
         wgenerage.endern = ?  AND 
         wgenerage.prem   = 0  THEN NEXT Loop_main.    /*Last Record*/               

      IF wgenerage.policy = "" THEN DO:
         IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
         nv_texterror = nv_texterror + "Policy No EQ Blank".
      END.

      IF wgenerage.endern = ? THEN DO:
         IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
         nv_texterror = nv_texterror + "Receipt Date EQ Blank".
      END.

      IF wgenerage.prem = 0 THEN DO:
         IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
         nv_texterror = nv_texterror + "Premium EQ Zero (=0)".
      END.

      nv_line = nv_line + 1.
      ASSIGN nv_poltotal  = nv_poltotal  + 1.
      
      /* Direct */
      IF  SUBSTR(wgenerage.policy,1,1) = "D"    OR 
         (SUBSTR(wgenerage.policy,1,2) >= "10"  AND 
          SUBSTR(wgenerage.policy,1,2) <= "99") THEN DO:
          FIND FIRST sicsyac.acm001 USE-INDEX acm00108 WHERE
                     sicsyac.acm001.policy  = TRIM(wgenerage.policy) AND 
                     sicsyac.acm001.rencnt >= 0                      AND
                     sicsyac.acm001.endcnt  = 0                      AND
                     sicsyac.acm001.trnty1  = "M"                    AND
                    (sicsyac.acm001.trnty2  = "N"                    OR
                     sicsyac.acm001.trnty2  = "R")
          NO-LOCK NO-ERROR .
      END.
      ELSE DO: /* Inward */
          FIND FIRST sicsyac.acm001 USE-INDEX acm00108 WHERE
                     sicsyac.acm001.policy  = TRIM(wgenerage.policy) AND
                     sicsyac.acm001.rencnt >= 0                      AND
                     sicsyac.acm001.endcnt  = 0                      AND
                     sicsyac.acm001.trnty1  = "O"                    AND
                    (sicsyac.acm001.trnty2  = "N"                    OR
                     sicsyac.acm001.trnty2  = "R")
          NO-LOCK NO-ERROR .
      END.

      IF AVAIL sicsyac.acm001 THEN DO:
            nv_acmprem = acm001.prem + acm001.stamp + acm001.tax.

            IF nv_acmprem = wgenerage.prem THEN DO:

                FIND FIRST sicuw.uwm100 USE-INDEX uwm10001 WHERE
                           sicuw.uwm100.policy = sicsyac.acm001.policy AND
                           sicuw.uwm100.rencnt = sicsyac.acm001.rencnt AND
                           sicuw.uwm100.endcnt = sicsyac.acm001.endcnt
                NO-LOCK NO-ERROR.
                IF AVAIL sicuw.uwm100 THEN DO:
                    IF sicuw.uwm100.endern = ? THEN
                       ASSIGN nv_policy = sicuw.uwm100.policy
                              nv_rencnt = sicuw.uwm100.rencnt 
                              nv_endcnt = sicuw.uwm100.endcnt.
                    ELSE DO:
                        IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
                        nv_texterror = nv_texterror + "Found Policy In Account & Underwrite, But 'Receipt Date Form Customer' Not Blank ".
                    END.
                END. 
            END.
            ELSE DO:
                IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
                nv_texterror = nv_texterror + "Found Policy In Account, But Column 'Premium' Not Equal Premium System".
            END.
      END.
      ELSE DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10090 WHERE
                      sicuw.uwm100.policy = TRIM(wgenerage.policy) AND                      
                      sicuw.uwm100.endcnt = 0                                
            NO-LOCK NO-ERROR.

            IF AVAIL sicuw.uwm100 THEN DO:
                nv_uwmprem = uwm100.prem_t + uwm100.rstp_t + uwm100.rtax_t.

                IF nv_uwmprem = wgenerage.prem THEN DO: 
                    IF sicuw.uwm100.endern = ? THEN
                       ASSIGN nv_policy = sicuw.uwm100.policy
                              nv_rencnt = sicuw.uwm100.rencnt 
                              nv_endcnt = sicuw.uwm100.endcnt.
                    ELSE DO:
                        IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
                        nv_texterror = nv_texterror + "Found Policy In Underwrite, But 'Receipt Date Form Customer' Not Blank".
                    END.
                END.
                ELSE DO:
                    IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
                    nv_texterror = nv_texterror + "Found Policy In Underwrite, But Column 'Premium' Not Equal Premium System".
                END.
            END.
      END.

      IF nv_policy <> "" THEN DO:
          FIND FIRST sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
                     sic_bran.uwm100.policy  = nv_policy  AND
                     sic_bran.uwm100.rencnt  = nv_rencnt  AND
                     sic_bran.uwm100.endcnt  = nv_endcnt  AND
                     sic_bran.uwm100.Bchyr   = nv_Bchyr   AND
                     sic_bran.uwm100.Bchno   = nv_Bchno   AND
                     sic_bran.uwm100.Bchcnt  = nv_Bchcnt
          NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE sic_bran.uwm100 THEN DO:
             IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
             nv_texterror = nv_texterror + "พบข้อมูลมีอยู่แล้วที่ Gwtransfer:Policy Master (uwm100)".
          END.
          ELSE  RUN Pd_Create.  /*Create Data To Database*/
      END.
      ELSE DO:
             IF nv_texterror <> "" THEN nv_texterror = nv_texterror + "/".
             nv_texterror = nv_texterror + "Not Found Policy In Premium".
      END.


      IF nv_texterror <> "" THEN DO:
          ASSIGN
            nv_polflg    = NO
            nv_reccount  = nv_reccount + 1.
      END.
      ELSE nv_polflg    = YES.               

      IF nv_texterror <> "" THEN DO:
          PUT STREAM nerror
              n_count ";"
              wgenerage.policy ";"
              wgenerage.endcnt ";"
              wgenerage.prem   ";"
              wgenerage.endern ";"
              nv_texterror ";"
          SKIP.  

          ASSIGN nv_polerror  = nv_polerror  + 1.
      END.
      ELSE DO:
          PUT STREAM nnoterror
              n_count ";"
              wgenerage.policy ";"
              wgenerage.rencnt ";"
              wgenerage.endcnt ";"
              wgenerage.prem   ";"
              wgenerage.comdat ";"
              wgenerage.expdat ";"
              wgenerage.endern ";"
              wgenerage.insname ";"
          SKIP.

          ASSIGN nv_polsuccess  = nv_polsuccess  + 1.
      END.
       
    END. /*For each wgenerage*/     

    OPEN QUERY br_main FOR EACH wgenerage WHERE 
                                wgenerage.policy <> "" AND wgenerage.rec100 <> 0 NO-LOCK.

    /*---A49-0165----*/
    ASSIGN
      fi_policytotal   = nv_poltotal
      fi_policysuccess = nv_polsuccess.  
    DISP fi_policytotal  fi_policysuccess  WITH FRAME fr_main.

    RUN Pd_Batch. /* Create uzm701.*/
    
    /*
    /*--------Sum Si & Prem Error------------*/
    PUT STREAM nerror
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        "Total" ";"
        /*nv_premerror ";"*/
        " " ";"
        /*nv_sierror ";"*/
        " " ";"
    SKIP. 

    /*--------Sum Si & Prem Success------------*/
    PUT STREAM nnoterror
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        " " ";"
        "Total" ";"
        /*nv_premsuccess ";"*/
        " " ";"
        /*nv_sisuccess ";"*/
    SKIP. 
    */

    /*----------------- Screen Data.-------------*/
    OUTPUT STREAM nbatch TO VALUE(INPUT fi_output3).
    PUT STREAM nbatch

    "--------------- GWTRANSFER : IMPORT RECEIPT DATE ----------------" SKIP
    "             Trandate : " INPUT fi_trndat                          SKIP
    "               Branch : " INPUT fi_bran   "  " INPUT fi_brandesc   SKIP
    "        Producer Code : " INPUT fi_acno1  "  " INPUT fi_acdesc     SKIP
    "    Previous Batch No : " INPUT fi_prvbatch                        SKIP
    "           Batch Year : " INPUT fi_Bchyr                           SKIP
    " Input file name Load : " INPUT fi_input                           SKIP
    "       File Completed : " INPUT fi_output1                         SKIP                
    "    File Not Complete : " INPUT fi_output2                         SKIP         
    "Screen Output To File : " INPUT fi_output3                         SKIP     
    "  Policy Import Total : " INPUT fi_policyinput                     SKIP
    "            Batch No. : " INPUT fi_batch                           SKIP(1)
    "         Record Total : " INPUT fi_policytotal                     SKIP
    "       Record Success : " INPUT fi_policysuccess                   SKIP.

    OUTPUT STREAM nerror    CLOSE.
    OUTPUT STREAM nnoterror CLOSE.
    OUTPUT STREAM nbatch    CLOSE.

    IF nv_batflg = NO AND n_count <> 0 THEN DO:  
        ASSIGN
            fi_policysuccess:FGCOLOR = 6
            fi_batch:FGCOLOR         = 6. 
        DISP fi_policysuccess  WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_Bchyr)     SKIP
                "Batch No.   : " nv_Bchno             SKIP
                "Batch Count : " STRING(nv_Bchcnt,"99") SKIP(1)
                TRIM(nv_txtmsg)                         SKIP
                "Please check Data again."      
        VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES AND n_count <> 0 THEN DO: 
        ASSIGN
            fi_policysuccess:FGCOLOR = 2
            fi_batch:FGCOLOR         = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
        DISP fi_policysuccess  fi_batch WITH FRAME fr_main.        
    END.

 END. /*End do with frame fr_main*/                                      
 END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_uwm100 C-Win 
PROCEDURE pd_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_usrid  AS CHARACTER FORMAT "X(8)"  INITIAL 0.
DEF VAR nv_undyr  AS CHARACTER FORMAT "X(4)"  INITIAL "".

nv_usrid  = USERID(LDBNAME("sic_bran")).

FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE
          sicuw.uwm100.policy = nv_policy AND
          sicuw.uwm100.rencnt = nv_rencnt AND
          sicuw.uwm100.endcnt = nv_endcnt.
NO-LOCK NO-ERROR.
IF AVAIL sicuw.uwm100 THEN DO:

    /* CREATE NEW : Policy Header */
    CREATE sic_bran.uwm100.
    ASSIGN
      sic_bran.uwm100.curbil = sicuw.uwm100.curbil    /*Currency of Billing*/
      sic_bran.uwm100.curate = sicuw.uwm100.curate    /*Currency rate for Billing*/
      sic_bran.uwm100.branch = sicuw.uwm100.branch    /*Branch Code (of Transaction)*/
      sic_bran.uwm100.dir_ri = sicuw.uwm100.dir_ri    /*Direct/RI Code (D/R)*/
      sic_bran.uwm100.dept   = sicuw.uwm100.dept      /*Department code*/
      sic_bran.uwm100.policy = sicuw.uwm100.policy    /*Policy No.*/
      sic_bran.uwm100.rencnt = sicuw.uwm100.rencnt    /*Renewal Count*/
      sic_bran.uwm100.renno  = sicuw.uwm100.renno     /*Renewal No.*/
      sic_bran.uwm100.endcnt = sicuw.uwm100.endcnt    /*Endorsement Count*/
      sic_bran.uwm100.endno  = sicuw.uwm100.endno     /*Endorsement No.*/
      sic_bran.uwm100.cntry  = sicuw.uwm100.cntry     /*Country where risk is situated*/
      sic_bran.uwm100.agent  = sicuw.uwm100.agent     /*Agent's Ref. No.*/
      sic_bran.uwm100.poltyp = sicuw.uwm100.poltyp    /*Policy Type*/
      sic_bran.uwm100.insref = sicuw.uwm100.insref    /*Insured's Ref. No.*/
      sic_bran.uwm100.opnpol = sicuw.uwm100.opnpol    /*Open Cover/Master Policy No.*/
      sic_bran.uwm100.ntitle = sicuw.uwm100.ntitle    /*Title for Name Mr/Mrs/etc*/
      sic_bran.uwm100.fname  = sicuw.uwm100.fname     /*First Name*/
      sic_bran.uwm100.name1  = sicuw.uwm100.name1     /*Name of Insured Line 1*/
      sic_bran.uwm100.name2  = sicuw.uwm100.name2     /*Name of Insured Line 2*/
      sic_bran.uwm100.name3  = sicuw.uwm100.name3     /*Name of Insured Line 3*/
      sic_bran.uwm100.addr1  = sicuw.uwm100.addr1     /*Address 1*/
      sic_bran.uwm100.addr2  = sicuw.uwm100.addr2     /*Address 2*/
      sic_bran.uwm100.postcd = sicuw.uwm100.postcd    /*Postal Code*/
      sic_bran.uwm100.occupn = sicuw.uwm100.occupn .  /*Occupation Description*/

    ASSIGN                              
      sic_bran.uwm100.comdat = sicuw.uwm100.comdat     /*Cover Commencement Date*/
      sic_bran.uwm100.expdat = sicuw.uwm100.expdat     /*Expiry Date*/
      sic_bran.uwm100.accdat = sicuw.uwm100.accdat     /*Acceptance Date*/
      sic_bran.uwm100.trndat = sicuw.uwm100.trndat     /*Transaction Date*/
      sic_bran.uwm100.rendat = sicuw.uwm100.rendat     /*Date Renewal Notice Printed*/
      sic_bran.uwm100.terdat = sicuw.uwm100.terdat     /*Termination Date*/
      sic_bran.uwm100.cn_dat = sicuw.uwm100.cn_dat     /*Cover Note Date*/
      sic_bran.uwm100.cn_no  = sicuw.uwm100.cn_no      /*Cover Note No.*/
      sic_bran.uwm100.tranty = sicuw.uwm100.tranty     /*Transaction Type (N/R/E/C/T)*/
      sic_bran.uwm100.undyr  = sicuw.uwm100.undyr      /*Underwriting Year*/
      sic_bran.uwm100.acno1  = sicuw.uwm100.acno1      /*Account no. 1*/
      sic_bran.uwm100.acno2  = sicuw.uwm100.acno2      /*Account no. 2*/
      sic_bran.uwm100.acno3  = sicuw.uwm100.acno3      /*Account no. 3*/
      sic_bran.uwm100.instot = sicuw.uwm100.instot     /*Total No. of Instalments*/
      sic_bran.uwm100.pstp   = sicuw.uwm100.pstp       /*Policy Level Stamp*/
      sic_bran.uwm100.pfee   = sicuw.uwm100.pfee       /*Policy Level Fee*/
      sic_bran.uwm100.ptax   = sicuw.uwm100.ptax       /*Policy Level Tax*/
      sic_bran.uwm100.rstp_t = sicuw.uwm100.rstp_t     /*Risk Level Stamp, Tran. Total*/
      sic_bran.uwm100.rfee_t = sicuw.uwm100.rfee_t     /*Risk Level Fee, Tran. Total*/
      sic_bran.uwm100.rtax_t = sicuw.uwm100.rtax_t     /*Risk Level Tax, Tran. Total*/
      sic_bran.uwm100.prem_t = sicuw.uwm100.prem_t     /*Premium Due, Tran. Total*/
      sic_bran.uwm100.pdco_t = sicuw.uwm100.pdco_t     /*PD Coinsurance, Tran. Total*/
      sic_bran.uwm100.pdst_t = sicuw.uwm100.pdst_t     /*PD Statutory, Tran. total*/
      sic_bran.uwm100.pdfa_t = sicuw.uwm100.pdfa_t     /*PD Facultative, Tran. Total*/
      sic_bran.uwm100.pdty_t = sicuw.uwm100.pdty_t     /*PD Treaty, Tran. Total*/
      sic_bran.uwm100.pdqs_t = sicuw.uwm100.pdqs_t     /*PD Quota Share, Tran. Total*/
      sic_bran.uwm100.com1_t = sicuw.uwm100.com1_t     /*Commission 1, Tran. Total*/
      sic_bran.uwm100.com2_t = sicuw.uwm100.com2_t     /*Commission 2, Tran. Total*/
      sic_bran.uwm100.com3_t = sicuw.uwm100.com3_t     /*Commission 3, Tran. Total*/
      sic_bran.uwm100.com4_t = sicuw.uwm100.com4_t     /*Commission 4, Tran. Total*/
      sic_bran.uwm100.coco_t = sicuw.uwm100.coco_t     /*Comm. Coinsurance, Tran Total*/
      sic_bran.uwm100.cost_t = sicuw.uwm100.cost_t     /*Comm. Statutory, Tran. Total*/
      sic_bran.uwm100.cofa_t = sicuw.uwm100.cofa_t     /*Comm. Facultative, Tran. To*/
      sic_bran.uwm100.coty_t = sicuw.uwm100.coty_t     /*Comm. Treaty, Tran. Total*/
      sic_bran.uwm100.coqs_t = sicuw.uwm100.coqs_t     /*Comm. Quota Share, Tran. Total*/
      sic_bran.uwm100.reduc1 = sicuw.uwm100.reduc1     /*Reducing Balance 1 (Y/N)*/
      sic_bran.uwm100.reduc2 = sicuw.uwm100.reduc2     /*Reducing Balance 2 (Y/N)*/
      sic_bran.uwm100.reduc3 = sicuw.uwm100.reduc3 .   /*Reducing Balance 3 (Y/N)*/

    ASSIGN                              
      sic_bran.uwm100.gap_p  = sicuw.uwm100.gap_p       /*Gross Annual Prem, Pol. Total*/
      sic_bran.uwm100.dl1_p  = sicuw.uwm100.dl1_p       /*Discount/Loading 1, Pol. Total*/
      sic_bran.uwm100.dl2_p  = sicuw.uwm100.dl2_p       /*Discount/Loading 2, Pol. Total*/
      sic_bran.uwm100.dl3_p  = sicuw.uwm100.dl3_p       /*Discount/Loading 3, Pol. Total*/
      sic_bran.uwm100.dl2red = sicuw.uwm100.dl2red      /*Disc./Load 2 Red. Balance Y/N*/
      sic_bran.uwm100.dl3red = sicuw.uwm100.dl3red      /*Disc./Load 3 Red. Balance Y/N*/
      sic_bran.uwm100.dl1sch = sicuw.uwm100.dl1sch      /*Disc./Load 1 Prt on Sched. Y/N*/
      sic_bran.uwm100.dl2sch = sicuw.uwm100.dl2sch      /*Disc./Load 2 Prt on Sched. Y/N*/
      sic_bran.uwm100.dl3sch = sicuw.uwm100.dl3sch      /*Disc./Load 3 Prt on Sched. Y/N*/
      sic_bran.uwm100.drnoae = sicuw.uwm100.drnoae      /*Dr/Cr Note No. (A/E)*/
      sic_bran.uwm100.insddr = sicuw.uwm100.insddr      /*Print Insd. Name on DrN*/
      sic_bran.uwm100.trty11 = sicuw.uwm100.trty11      /*Tran. Type (1), A/C No. 1*/
      sic_bran.uwm100.trty12 = sicuw.uwm100.trty12      /*Tran. Type (1), A/C No. 2*/
      sic_bran.uwm100.trty13 = sicuw.uwm100.trty13      /*Tran. Type (1), A/C No. 3*/
      sic_bran.uwm100.docno1 = sicuw.uwm100.docno1      /*Document No., A/C No. 1*/
      sic_bran.uwm100.docno2 = sicuw.uwm100.docno2      /*Document No., A/C No. 2*/
      sic_bran.uwm100.docno3 = sicuw.uwm100.docno3      /*Document No., A/C No. 3*/
      sic_bran.uwm100.no_sch = sicuw.uwm100.no_sch      /*No. to print, Schedule*/
      sic_bran.uwm100.no_dr  = sicuw.uwm100.no_dr       /*No. to print, Dr/Cr Note*/
      sic_bran.uwm100.no_ri  = sicuw.uwm100.no_ri       /*No. to print, RI Appln*/
      sic_bran.uwm100.no_cer = sicuw.uwm100.no_cer      /*No. to print, Certificate*/
      sic_bran.uwm100.li_sch = sicuw.uwm100.li_sch      /*Print Later/Imm., Schedule*/
      sic_bran.uwm100.li_dr  = sicuw.uwm100.li_dr       /*Print Later/Imm., Dr/Cr Note*/
      sic_bran.uwm100.li_ri  = sicuw.uwm100.li_ri       /*Print Later/Imm., RI Appln,*/
      sic_bran.uwm100.li_cer = sicuw.uwm100.li_cer      /*Print Later/Imm., Certificate*/
      sic_bran.uwm100.scform = sicuw.uwm100.scform      /*Schedule Format*/
      sic_bran.uwm100.enform = sicuw.uwm100.enform      /*Endt. Format (Full/Abbr/Blank)*/
      sic_bran.uwm100.apptax = sicuw.uwm100.apptax      /*Apply risk level tax (Y/N)*/
      sic_bran.uwm100.dl1cod = sicuw.uwm100.dl1cod      /*Discount/Loading Type Code 1*/
      sic_bran.uwm100.dl2cod = sicuw.uwm100.dl2cod      /*Discount/Loading Type Code 2*/
      sic_bran.uwm100.dl3cod = sicuw.uwm100.dl3cod      /*Discount/Loading Type Code 3*/
      sic_bran.uwm100.styp20 = sicuw.uwm100.styp20      /*Statistic Type Codes (4 x 20)*/
      sic_bran.uwm100.sval20 = sicuw.uwm100.sval20      /*Statistic Value Codes (4 x 20)*/
      sic_bran.uwm100.finint = sicuw.uwm100.finint      /*Financial Interest Ref. No.*/
      sic_bran.uwm100.cedco  = sicuw.uwm100.cedco       /*Ceding Co. No.*/
      sic_bran.uwm100.cedsi  = sicuw.uwm100.cedsi       /*Ceding Co. Sum Insured*/
      sic_bran.uwm100.cedpol = sicuw.uwm100.cedpol      /*Open Cover/Master Policy No.*/      
      sic_bran.uwm100.cedces = sicuw.uwm100.cedces      /*Ceding Co. Cession No.*/
      sic_bran.uwm100.recip  = sicuw.uwm100.recip       /*Reciprocal (Y/N/C)*/
      sic_bran.uwm100.short  = sicuw.uwm100.short       /*Short Term Rates*/
      sic_bran.uwm100.receit = sicuw.uwm100.receit.     /*Receipt No.*/

    ASSIGN                              
      sic_bran.uwm100.fptr01 = sicuw.uwm100.fptr01      /*First uwd100 Policy Upper Text*/
      sic_bran.uwm100.bptr01 = sicuw.uwm100.bptr01      /*Last  uwd100 Policy Upper Text*/
      sic_bran.uwm100.fptr02 = sicuw.uwm100.fptr02      /*First uwd102 Policy Memo Text*/
      sic_bran.uwm100.bptr02 = sicuw.uwm100.bptr02      /*Last  uwd102 Policy Memo Text*/
      sic_bran.uwm100.fptr03 = sicuw.uwm100.fptr03      /*First uwd105 Policy Clauses*/
      sic_bran.uwm100.bptr03 = sicuw.uwm100.bptr03      /*Last  uwd105 Policy Clauses*/
      sic_bran.uwm100.fptr04 = sicuw.uwm100.fptr04      /*First uwd103 Policy Ren. Text*/
      sic_bran.uwm100.bptr04 = sicuw.uwm100.bptr04      /*Last uwd103 Policy Ren. Text*/
      sic_bran.uwm100.fptr05 = sicuw.uwm100.fptr05      /*First uwd104 Policy Endt. Text*/
      sic_bran.uwm100.bptr05 = sicuw.uwm100.bptr05      /*Last uwd104 Policy Endt. Text*/
      sic_bran.uwm100.fptr06 = sicuw.uwm100.fptr06      /*First uwd106 Pol.Endt.Clauses*/
      sic_bran.uwm100.bptr06 = sicuw.uwm100.bptr06      /*Last uwd106 Pol. Endt. Clauses*/
      sic_bran.uwm100.coins  = sicuw.uwm100.coins       /*Is this Coinsurance (Y/N)*/
      sic_bran.uwm100.billco = sicuw.uwm100.billco      /*Bill Coinsurer's Share (Y/N)*/
      sic_bran.uwm100.pmhead = sicuw.uwm100.pmhead      /*Premium Headings on Schedule*/
      sic_bran.uwm100.usridr = sicuw.uwm100.usridr      /*Release User Id*/
      sic_bran.uwm100.reldat = sicuw.uwm100.reldat      /*Release Date*/
      sic_bran.uwm100.reltim = sicuw.uwm100.reltim      /*Release Time*/
      sic_bran.uwm100.polsta = sicuw.uwm100.polsta      /*Policy Status*/
      sic_bran.uwm100.rilate = sicuw.uwm100.rilate      /*RI to Enter Later*/
      sic_bran.uwm100.releas = sicuw.uwm100.releas      /*Transaction Released*/
      sic_bran.uwm100.sch_p  = sicuw.uwm100.sch_p       /*Schedule Printed*/
      sic_bran.uwm100.drn_p  = sicuw.uwm100.drn_p       /*Dr/Cr Note Printed*/
      sic_bran.uwm100.ri_p   = sicuw.uwm100.ri_p        /*RI Application Printed*/
      sic_bran.uwm100.cert_p = sicuw.uwm100.cert_p      /*Certificate Printed*/
      sic_bran.uwm100.dreg_p = sicuw.uwm100.dreg_p      /*Daily Prem. Reg. Printed*/
      sic_bran.uwm100.langug = sicuw.uwm100.langug.     /*Language*/

    ASSIGN    
      sic_bran.uwm100.sigr_p = sicuw.uwm100.sigr_p      /*SI Gross Pol. Total*/
      sic_bran.uwm100.sico_p = sicuw.uwm100.sico_p      /*SI Coinsurance Pol. Total*/
      sic_bran.uwm100.sist_p = sicuw.uwm100.sist_p      /*SI Statutory Pol. Total*/
      sic_bran.uwm100.sifa_p = sicuw.uwm100.sifa_p      /*SI Facultative Pol. Total*/
      sic_bran.uwm100.sity_p = sicuw.uwm100.sity_p      /*SI Treaty Pol. Total*/
      sic_bran.uwm100.siqs_p = sicuw.uwm100.siqs_p      /*SI Quota Share Pol. Total*/
      sic_bran.uwm100.co_per = sicuw.uwm100.co_per      /*Coinsurance %*/
      sic_bran.uwm100.acctim = sicuw.uwm100.acctim      /*Acceptance Time*/
      sic_bran.uwm100.agtref = sicuw.uwm100.agtref      /*Agents Closing Reference*/
      sic_bran.uwm100.sckno  = sicuw.uwm100.sckno       /*sticker no.*/
      sic_bran.uwm100.anam1  = sicuw.uwm100.anam1       /*Alternative Insured Name 1*/
      sic_bran.uwm100.sirt_p = sicuw.uwm100.sirt_p      /*SI RETENTION Pol. total*/
      sic_bran.uwm100.anam2  = sicuw.uwm100.anam2       /*Alternative Insured Name 2*/
      sic_bran.uwm100.gstrat = sicuw.uwm100.gstrat      /*GST Rate %*/
      sic_bran.uwm100.prem_g = sicuw.uwm100.prem_g      /*Premium GST*/
      sic_bran.uwm100.com1_g = sicuw.uwm100.com1_g      /*Commission 1 GST*/
      sic_bran.uwm100.com3_g = sicuw.uwm100.com3_g      /*Commission 3 GST*/
      sic_bran.uwm100.com4_g = sicuw.uwm100.com4_g      /*Commission 4 GST*/
      sic_bran.uwm100.gstae  = sicuw.uwm100.gstae       /*GST A/E*/
      sic_bran.uwm100.nr_pol = sicuw.uwm100.nr_pol      /*New Policy No. (Y/N)*/
      sic_bran.uwm100.issdat = sicuw.uwm100.issdat      /*Issue date*/
      sic_bran.uwm100.issdat = sicuw.uwm100.issdat      /*Issue date*/
      sic_bran.uwm100.cr_1   = sicuw.uwm100.cr_1        /*A/C 1 cash(C)/credit(R) agent*/
      sic_bran.uwm100.cr_2   = sicuw.uwm100.cr_2        /*Appened กรมธรรม์ พ่วง */
      sic_bran.uwm100.cr_3   = sicuw.uwm100.cr_3        /*A/C 3 cash(C)/credit(R) agent*/
      sic_bran.uwm100.rt_er  = sicuw.uwm100.rt_er       /*Batch Release*/      
      sic_bran.uwm100.prvpol = sicuw.uwm100.prvpol      /*Prvpol Policy No.*/
      sic_bran.uwm100.enddat = sicuw.uwm100.enddat      /*Endorsement Date*/
      sic_bran.uwm100.fstdat = sicuw.uwm100.fstdat      /*First Issue Date of Policy*/
      sic_bran.uwm100.renpol = sicuw.uwm100.renpol      /*Renewal Policy No.*/
      sic_bran.uwm100.usrid  = nv_usrid                 /*User Id*/
      sic_bran.uwm100.entdat = nv_trndat                /*Entered Date*/
      sic_bran.uwm100.enttim = nv_enttim                /*Entered Time*/
      sic_bran.uwm100.prog   = "WGWIMREC"               /*Program Id that input record*/  
      sic_bran.uwm100.endern = wgenerage.endern.        /*End Date of Earned Premium*/  

    ASSIGN
      sic_bran.uwm100.bchyr     = nv_Bchyr         /*Batch Year */  
      sic_bran.uwm100.bchno     = nv_Bchno         /*Batch No.  */  
      sic_bran.uwm100.bchcnt    = nv_Bchcnt        /*Batch Count*/  
      sic_bran.uwm100.impflg    = nv_polflg        /*Policy Flag*/
      sic_bran.uwm100.imperr    = nv_texterror     /*Detail Error*/
      sic_bran.uwm100.impusrid  = nv_usrid
      sic_bran.uwm100.impdat    = TODAY
      sic_bran.uwm100.imptim    = STRING(TIME,"HH:MM:SS").

    ASSIGN 
      wgenerage.rencnt  = sicuw.uwm100.rencnt
      wgenerage.endcnt  = sicuw.uwm100.endcnt
      wgenerage.comdat  = sicuw.uwm100.comdat
      wgenerage.expdat  = sicuw.uwm100.expdat
      wgenerage.insname = sicuw.uwm100.name1
      wgenerage.rec100  = RECID(sic_bran.uwm100).
END.

          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

