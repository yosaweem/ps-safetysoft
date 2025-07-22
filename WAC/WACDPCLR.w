&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
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
  
         Manop G.  A62-0291    15/06/2019
     Check and Clear Dupplicate Match Data in Account (ACD001)  

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
DEF SHARED VAR n_user     AS CHAR .
DEF SHARED VAR n_passwrd  AS CHAR .
DEF VAR nv_jnlno  AS CHARACTER .

DEF VAR nv_policy       AS CHAR .
DEF VAR nv_endno        AS CHAR .
DEF VAR nv_rencnt       AS INT  . 
DEF VAR nv_endcnt       AS INT  .
                        
DEF TEMP-TABLE  wacd    
    FIELD policy        AS CHAR 
    FIELD endorse       AS CHAR
    FIELD rencnt        AS CHAR
    FIELD endcnt        AS CHAR
    FIELD trnty         AS CHAR
    FIELD docno         AS CHAR
    FIELD cjono         AS CHAR    
    FIELD ctrty1        AS CHAR 
    FIELD cdocno        AS CHAR 
    FIELD RecACD        AS RECID
    FIELD memo          AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_acd

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wacd

/* Definitions for BROWSE br_acd                                        */
&Scoped-define FIELDS-IN-QUERY-br_acd policy IF rencnt <> "" THEN rencnt + "/" + endcnt ELSE " " endorse trnty docno cjono cdocno memo   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_acd   
&Scoped-define SELF-NAME br_acd
&Scoped-define QUERY-STRING-br_acd FOR EACH wacd NO-LOCK
&Scoped-define OPEN-QUERY-br_acd OPEN QUERY br_acd FOR EACH wacd NO-LOCK .
&Scoped-define TABLES-IN-QUERY-br_acd wacd
&Scoped-define FIRST-TABLE-IN-QUERY-br_acd wacd


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_acd}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_jnlno fi_updoc fi_upcjo fi_upcdoc br_acd ~
bu_Ok bu_Cancel fi_updocS fi_upcjos fi_upcdocS bu_updat RECT-325 RECT-326 ~
RECT-327 
&Scoped-Define DISPLAYED-OBJECTS fi_jnlno fi_updoc fi_upcjo fi_upcdoc ~
fi_updocS fi_upcjos fi_upcdocS fi_user fi_endat fi_time 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 14.67 BY 1.43
     FONT 6.

DEFINE BUTTON bu_Ok 
     LABEL "OK" 
     SIZE 14.67 BY 1.43
     FONT 6.

DEFINE BUTTON bu_updat 
     LABEL "Clear" 
     SIZE 15.33 BY 1.38
     FONT 6.

DEFINE VARIABLE fi_endat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE fi_jnlno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY .95
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE fi_upcdoc AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_upcdocS AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_upcjo AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_upcjos AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_updoc AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_updocS AS CHARACTER FORMAT "X":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     FONT 2 NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 8  NO-UNDO.

DEFINE RECTANGLE RECT-325
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 103.33 BY 4.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-326
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 103.33 BY 6.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-327
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 103.33 BY 1.43
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_acd FOR 
      wacd SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_acd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_acd C-Win _FREEFORM
  QUERY br_acd DISPLAY
      policy          COLUMN-LABEL "       Policy No."        FORMAT "X(14)"       
     
IF rencnt <> "" THEN rencnt + "/" + endcnt         
ELSE " "        COLUMN-LABEL "  R/E Cnt.  "       FORMAT "X(6)"   
endorse         COLUMN-LABEL "  Ren/End/Cl"       FORMAT "X(13)" 

trnty           COLUMN-LABEL "Trnty"                 FORMAT "X(3)" 
docno           COLUMN-LABEL "    Doc No."           FORMAT "X(11)"
cjono           COLUMN-LABEL "   Journal No."         FORMAT "X(11)"
cdocno          COLUMN-LABEL "   C Doc No."          FORMAT "X(11)"
memo            COLUMN-LABEL "                  Error"        FORMAT "X(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 103 BY 7.91 ROW-HEIGHT-CHARS .7 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_jnlno AT ROW 4.38 COL 43 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_updoc AT ROW 16.43 COL 51.17 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_upcjo AT ROW 17.71 COL 51.17 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_upcdoc AT ROW 19.05 COL 51.17 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     br_acd AT ROW 7.52 COL 3 WIDGET-ID 200
     bu_Ok AT ROW 4.19 COL 67 WIDGET-ID 10
     bu_Cancel AT ROW 4.19 COL 84.5 WIDGET-ID 14
     fi_updocS AT ROW 16.43 COL 43.67 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_upcjos AT ROW 17.71 COL 43.67 COLON-ALIGNED NO-LABEL WIDGET-ID 46
     fi_upcdocS AT ROW 19.05 COL 43.67 COLON-ALIGNED NO-LABEL WIDGET-ID 48
     bu_updat AT ROW 18.62 COL 78.17 WIDGET-ID 22
     fi_user AT ROW 20.52 COL 53.33 COLON-ALIGNED NO-LABEL WIDGET-ID 38
     fi_endat AT ROW 20.52 COL 70.33 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_time AT ROW 20.52 COL 86.17 COLON-ALIGNED NO-LABEL WIDGET-ID 42
     "     Clear Doc No." VIEW-AS TEXT
          SIZE 21.67 BY .95 AT ROW 16.43 COL 21.5 WIDGET-ID 20
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "     Clear Journal No." VIEW-AS TEXT
          SIZE 21.67 BY .95 AT ROW 17.71 COL 21.5 WIDGET-ID 28
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "     Clear C Doc No." VIEW-AS TEXT
          SIZE 21.67 BY .95 AT ROW 19.05 COL 21.5 WIDGET-ID 30
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "    Journal No. :" VIEW-AS TEXT
          SIZE 17.5 BY 1.19 AT ROW 4.29 COL 22.5 WIDGET-ID 4
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "Check and Clear Dupplicate Data in Account (ACD001)" VIEW-AS TEXT
          SIZE 64 BY 1.19 AT ROW 1.62 COL 28.5 WIDGET-ID 8
          BGCOLOR 1 FGCOLOR 15 FONT 6
     RECT-325 AT ROW 3 COL 3 WIDGET-ID 32
     RECT-326 AT ROW 15.76 COL 3 WIDGET-ID 34
     RECT-327 AT ROW 1.48 COL 3 WIDGET-ID 36
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 108.5 BY 21.33 WIDGET-ID 100.


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
         HEIGHT             = 21.33
         WIDTH              = 108.5
         MAX-HEIGHT         = 22.33
         MAX-WIDTH          = 134.83
         VIRTUAL-HEIGHT     = 22.33
         VIRTUAL-WIDTH      = 134.83
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_acd fi_upcdoc fr_main */
/* SETTINGS FOR FILL-IN fi_endat IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_time IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_user IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_acd
/* Query rebuild information for BROWSE br_acd
     _START_FREEFORM
OPEN QUERY br_acd FOR EACH wacd NO-LOCK .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_acd */
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


&Scoped-define BROWSE-NAME br_acd
&Scoped-define SELF-NAME br_acd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_acd C-Win
ON MOUSE-SELECT-DBLCLICK OF br_acd IN FRAME fr_main
DO:
  GET CURRENT br_acd.
    FIND CURRENT wacd NO-LOCK .
     IF wacd.memo <> " " THEN DO:
       ASSIGN 
         fi_updoc   = wacd.docno
         fi_upcjo   = wacd.cjono
         fi_upcdoc  = wacd.cdocno.
       
       ENABLE fi_updocs fi_upcjos fi_upcdocs bu_updat WITH FRAME fr_main. 
     END.
         
    
DISP fi_updoc  fi_upcjo fi_upcdoc   
     fi_updocs  fi_upcjos fi_upcdocs  WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Cancel C-Win
ON CHOOSE OF bu_Cancel IN FRAME fr_main /* Cancel */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Ok C-Win
ON CHOOSE OF bu_Ok IN FRAME fr_main /* OK */
DO:
  fi_jnlno = TRIM(INPUT fi_jnlno).
  nv_policy  = " ". 
  nv_endno   = " ".
  nv_rencnt  = 0 .
  nv_endcnt  = 0 .


  FOR EACH wacd .
      DELETE wacd.
  END.

  IF fi_jnlno = ""  THEN DO:
      MESSAGE "Journal No. Not Available"   VIEW-AS ALERT-BOX.
      RETURN NO-APPLY.
  END.

  FIND FIRST acd001 USE-INDEX acd00101 WHERE acd001.cjono = fi_jnlno NO-LOCK NO-ERROR.
  IF NOT AVAIL acd001 THEN DO:
     MESSAGE "Journal No.  Not Found"   VIEW-AS ALERT-BOX.
     RETURN NO-APPLY.
  END.

    FOR EACH acd001 USE-INDEX acd00101 WHERE acd001.cjono = fi_jnlno .
      FIND FIRST acm001 USE-INDEX acm00101 NO-LOCK 
           WHERE acm001.trnty1 = acd001.trnty1
             AND acm001.docno   = acd001.docno
             AND acm001.fptr01  = RECID(acd001)  NO-ERROR.

      IF AVAILABLE acm001 THEN DO:
          nv_policy   =  acm001.policy     .  
          nv_endno    =  acm001.recno      .  
          nv_rencnt   =  acm001.rencnt     .  
          nv_endcnt   =  acm001.endcnt     .  

          CREATE   wacd.
          ASSIGN
              wacd.policy   = nv_policy 
              wacd.endorse  = nv_endno  
              wacd.rencnt   = STRING(nv_rencnt,"99")
              wacd.endcnt   = STRING(nv_endcnt,"999" )
              wacd.trnty    = acd001.trnty1 
              wacd.docno    = acd001.docno
              wacd.cjono    = acd001.cjono 
              wacd.ctrty1   = acd001.ctrty1 
              wacd.cdocno   = acd001.cdocno
              wacd.recACD   = RECID(acd001) 
              wacd.memo     = "".
      END.
      ELSE DO:
          CREATE   wacd.
          ASSIGN
              wacd.policy   = nv_policy               /*- acm001.policy          -*/
              wacd.endorse  = nv_endno                /*- acm001.recno           -*/
              wacd.rencnt   = STRING(nv_rencnt,"99")        /*- STRING(acm001.rencnt)  -*/
              wacd.endcnt   = STRING(nv_endcnt,"999" )      /*- STRING(acm001.endcnt)  -*/
              wacd.trnty    = acd001.trnty1 
              wacd.docno    = acd001.docno
              wacd.cjono    = acd001.cjono 
              wacd.ctrty1   = acd001.ctrty1 
              wacd.cdocno   = acd001.cdocno
              wacd.recACD   = RECID(acd001) 
              wacd.memo     = "Duplicate ACD001" .
      END.

      OPEN QUERY br_acd FOR EACH wacd NO-LOCK.
    
      ASSIGN         
      fi_updoc   =   "" 
      fi_upcjo   =   "" 
      fi_upcdoc  =   "" .

    

    END.  /* FOr each */


    
  DISABLE fi_updocs fi_upcjos  fi_upcdocs fi_updoc fi_upcjo fi_upcdoc 
          bu_updat fi_user fi_endat fi_time  WITH FRAME fr_main. 

  DISP fi_jnlno bu_updat fi_updoc fi_upcjo fi_upcdoc 
        fi_user fi_endat fi_time  WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_updat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_updat C-Win
ON CHOOSE OF bu_updat IN FRAME fr_main /* Clear */
DO:
    fi_updoc = INPUT fi_updoc.
    fi_upcjo = INPUT fi_upcjo.
    fi_upcdoc = INPUT fi_upcdoc.

    MESSAGE "คุณต้องการยืนยันการเคลียร์ข้อมูลหรือไม่ ?"   VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL    
        TITLE "" UPDATE lChoice AS LOGICAL.  
    CASE lChoice:    
            WHEN TRUE THEN /* Yes */ DO:   

               FOR EACH  acd001 USE-INDEX acd00101 WHERE cjono = fi_jnlno.
                    FIND acm001 USE-INDEX acm00101 NO-LOCK 
                         WHERE acm001.trnty1 = acd001.trnty1
                           AND acm001.docno  = acd001.docno
                           AND acm001.fptr01 = RECID(acd001) NO-ERROR.
                    IF NOT AVAILABLE acm001 THEN DO:
                         ASSIGN     
                             acd001.docno   = fi_updocs  +  fi_updoc        
                             acd001.cjono   = fi_upcjos  +  fi_upcjo       
                             acd001.cdocno  = fi_upcdocs +  fi_upcdoc .    
                    END.    /* FIND */
                    

                    FOR EACH wacd WHERE wacd.cjono  = fi_jnlno  AND 
                                        wacd.cdocno = fi_upcdoc AND 
                                        wacd.docno  = fi_updoc  AND
                                        wacd.recACD = RECID(acd001)   NO-LOCK.
                        DELETE wacd.
                    END.
                        OPEN QUERY br_acd FOR EACH wacd NO-LOCK.  
                    
               END.  /* for each */                   

                    fi_updoc     = "" .
                    fi_upcjo     = "" .
                    fi_upcdoc    = "" .
                             
                    DISABLE fi_updocs fi_upcjos fi_upcdocs bu_updat fi_user 
                            fi_endat fi_time fi_updocs fi_upcjos fi_upcdocs WITH FRAME fr_main.
                   
                MESSAGE  "Clear Data Complete "  VIEW-AS ALERT-BOX.

            END.  /* YES */
            /*----------------------*/
            WHEN FALSE THEN /* No */ DO:      
            END.   /* NO */ 
             
    END CASE.

    DISP br_acd  fi_user fi_endat fi_time bu_updat
         fi_updocs  fi_upcjos  fi_upcdocs
         fi_updoc  fi_upcjo  fi_upcdoc bu_updat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_endat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_endat C-Win
ON LEAVE OF fi_endat IN FRAME fr_main
DO:
  DISP fi_endat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_jnlno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_jnlno C-Win
ON LEAVE OF fi_jnlno IN FRAME fr_main
DO:
  nv_jnlno = INPUT fi_jnlno .


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_jnlno C-Win
ON RETURN OF fi_jnlno IN FRAME fr_main
DO:
  fi_jnlno = INPUT fi_jnlno.

  IF fi_jnlno = ""  THEN DO:
      MESSAGE "Journal No.  Not Available"   VIEW-AS ALERT-BOX.
      RETURN NO-APPLY.
  END.

  FIND FIRST acd001 USE-INDEX acd00101 WHERE acd001.cjono = fi_jnlno NO-LOCK NO-ERROR.
  IF NOT AVAIL acd001 THEN DO:
     MESSAGE "Journal No. Not Found"   VIEW-AS ALERT-BOX.
     RETURN NO-APPLY.
  END.

  DISP fi_jnlno  WITH FRAME fr_main.
  APPLY "ENTRY" TO bu_ok .
  RETURN NO-APPLY.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_upcdoc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_upcdoc C-Win
ON LEAVE OF fi_upcdoc IN FRAME fr_main
DO:
  fi_upcdoc = INPUT fi_upcdoc.
  DISP fi_updoc WITH FRAME fr_main.
      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_upcdoc C-Win
ON RETURN OF fi_upcdoc IN FRAME fr_main
DO:
    fi_upcdoc = INPUT fi_upcdoc.
    DISP fi_updoc WITH FRAME fr_main.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_upcjo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_upcjo C-Win
ON LEAVE OF fi_upcjo IN FRAME fr_main
DO:
  fi_upcjo = INPUT fi_upcjo.
  DISP fi_upcjo WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_upcjo C-Win
ON RETURN OF fi_upcjo IN FRAME fr_main
DO:
    fi_upcjo = INPUT fi_upcjo.
    DISP fi_upcjo WITH FRAME fr_main.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_updoc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_updoc C-Win
ON LEAVE OF fi_updoc IN FRAME fr_main
DO:
  fi_updoc = INPUT fi_updoc.
  DISP fi_updoc WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_updoc C-Win
ON RETURN OF fi_updoc IN FRAME fr_main
DO:
    fi_updoc = INPUT fi_updoc.
  DISP fi_updoc WITH FRAME fr_main.
  
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

  DEF  VAR  gv_prgid   AS   CHAR.
DEF  VAR  gv_prog    AS   CHAR.

gv_prgid = "WACDPCLR".
gv_prog  = "Check and Clear Dupplicate Match Data (ACD001)".
RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

  FOR EACH wacd .
      DELETE wacd.
  END.

  ASSIGN
    fi_updocs    =  "S"
    fi_upcjos    =  "S"
    fi_upcdocs   =  "S"
    fi_user      =  USERID(LDBNAME(1))                
    fi_endat     =  TODAY                           
    fi_time      =  STRING(TIME, "HH:MM:SS") 
     .



  DISABLE fi_updoc fi_upcjo fi_upcdoc bu_updat fi_user 
          fi_endat fi_time fi_updocs fi_upcjos fi_upcdocs WITH FRAME fr_main.

  DISP fi_jnlno bu_Ok  bu_cancel fi_updoc fi_upcjo fi_upcdoc bu_updat 
       fi_updocs fi_upcjos fi_upcdocs 
       fi_user fi_endat fi_time WITH FRAME fr_main.



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
  DISPLAY fi_jnlno fi_updoc fi_upcjo fi_upcdoc fi_updocS fi_upcjos fi_upcdocS 
          fi_user fi_endat fi_time 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_jnlno fi_updoc fi_upcjo fi_upcdoc br_acd bu_Ok bu_Cancel fi_updocS 
         fi_upcjos fi_upcdocS bu_updat RECT-325 RECT-326 RECT-327 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

