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
/*---------------------------------------------------------------------*/

/*Created : Kirtsadang p. A62-0143   14/03/2019
            - Transfer AG/BR Address To Lotus ให้มีการดึงข้อมูลเลขประจำตัวผู้เสียภาษี
              เข้าไปเก็บเพิ่มในกล่อง System parameter Agent/Broker  */
            
/*          This .W file was created with the Progress AppBuilder.      */                      
------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------*/ 


/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEF     SHARED VAR n_User    AS CHAR.
DEF     SHARED VAR n_Passwd  AS CHAR.
/* Local Variable Definitions ---                                       */
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .

Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .
def  var nv_extref       as char.

DEF VAR nv_sumam  AS DEC FORMAT "->,>>>,>>>,>>9.99" INIT 0.
DEF VAR nv_acno   AS CHAR FORMAT "X(10)".
DEF VAR nv_acnos  AS CHAR FORMAT "X(10)".
DEF VAR n_ac1 AS CHAR FORMAT "x(10)".
DEF VAR n_ac2 AS CHAR FORMAT "x(10)".
DEF VAR nv_ac1 AS CHAR FORMAT "x(10)".
DEF VAR nv_ac2 AS CHAR FORMAT "x(10)".

DEF VAR n_year AS INT.

DEFINE VAR nv_char1    AS CHAR.
DEFINE VAR nv_char2    AS CHAR.
DEFINE VAR nv_char3    AS CHAR.
DEFINE VAR nv_char4    AS CHAR.
DEFINE VAR nv_vehreg1  AS CHAR.
DEFINE VAR nv_vehreg2  AS CHAR.
DEFINE VAR nv_licen    AS CHAR.


DEFINE VAR nv_ToMail   AS CHAR.
DEFINE VAR nv_CCMail   AS CHAR.
DEFINE VAR nv_bcc      AS CHAR INIT "". 
DEF VAR nv_groupmail   AS CHAR.

DEF VAR nv_name  AS CHAR FORMAT "X(50)".   /*Name (EN)*/
DEF VAR nv_name2 AS CHAR FORMAT "X(50)".  /*Name2 (EN)*/
DEF VAR nv_name3 AS CHAR FORMAT "X(50)".  /*Name3 (EN)*/
DEF VAR nv_nameT AS CHAR FORMAT "X(50)".  /*Name (EN)*/
DEF VAR nv_nameT2 AS CHAR FORMAT "X(50)". /*Name2 (TH)*/
DEF VAR nv_nameT3 AS CHAR FORMAT "X(50)". /*Name3 (TH)*/
DEF VAR nv_addr1 AS CHAR FORMAT "X(50)".  /*Addr1 (TH)*/
DEF VAR nv_addr2 AS CHAR FORMAT "X(50)".  /*Addr2 (EN)*/
DEF VAR nv_addr3 AS CHAR FORMAT "X(50)".  /*Addr3 (EN)*/
DEF VAR nv_addr4 AS CHAR FORMAT "X(50)".  /*Addr4 (EN)*/
DEF VAR nv_addrT1 AS CHAR FORMAT "X(50)". /*Addr1 (TH)*/
DEF VAR nv_addrT2 AS CHAR FORMAT "X(50)". /*Addr2 (TH)*/
DEF VAR nv_addrT3 AS CHAR FORMAT "X(50)". /*Addr3 (TH)*/
DEF VAR nv_addrT4 AS CHAR FORMAT "X(50)". /*Addr4 (TH)*/

/*
DEF VAR nv_Telno  AS CHAR FORMAT "X(50)". /*Phone*/
DEF VAR nv_fax AS CHAR FORMAT "X(50)".    /*FAX*/
*/
DEF VAR nv_con AS LOGICAL INIT NO.
DEF VAR nvL_addr1  AS CHAR FORMAT "X(50)".  /*Addr1 (TH) on Notes*/
DEF VAR nvL_addr2  AS CHAR FORMAT "X(50)".  /*Addr2 (EN) on Notes*/
DEF VAR nvL_addr3  AS CHAR FORMAT "X(50)".  /*Addr3 (EN) on Notes*/
DEF VAR nvL_addr4  AS CHAR FORMAT "X(50)".  /*Addr4 (EN) on Notes*/
DEF VAR nvL_addrT1 AS CHAR FORMAT "X(50)". /*Addr1 (TH) on Notes*/
DEF VAR nvL_addrT2 AS CHAR FORMAT "X(50)". /*Addr2 (TH) on Notes*/
DEF VAR nvL_addrT3 AS CHAR FORMAT "X(50)". /*Addr3 (TH) on Notes*/
DEF VAR nvL_addrT4 AS CHAR FORMAT "X(50)". /*Addr4 (TH) on Notes*/
DEF VAR nvL_sumamt AS DECI  FORMAT "->,>>>,>>>,>>9.99". /*Addr4 (TH) on Notes*/
DEF VAR nv_taxno LIKE xmm600.taxno  FORMAT "x(20)".  


DEF TEMP-TABLE ttax100 /*LIKE tax100.  */
    FIELD grptyp  AS LOGICAL 
    FIELD taxtyp  AS CHAR 
    FIELD branch  AS CHAR 
    FIELD taxyr   AS INT 
    FIELD acno   AS CHAR   
    FIELD taxcod  AS CHAR   
    FIELD taxsta  AS LOGICAL
    FIELD amount  AS DECIMAL INIT 0
    INDEX ttax1001 IS PRIMARY acno.

DEF VAR nv_chk AS LOGICAL INIT NO.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_Transfer RECT-1 RECT-298 RECT-299 ~
RECT-300 RECT-301 bu_acnohp fi_acno fi_acno2 bu_acnohp2 bu_exit fi_name ~
fi_name2 fi_Nbranch 
&Scoped-Define DISPLAYED-OBJECTS fi_acno fi_acno2 fi_name fi_name2 ~
fi_Nbranch 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_acnohp 
     IMAGE-UP FILE "wimage\help":U
     LABEL "" 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_acnohp2 
     IMAGE-UP FILE "wimage\help":U
     LABEL "" 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 18 BY 1.52
     FONT 6.

DEFINE BUTTON bu_Transfer  NO-FOCUS
     LABEL "Transfer" 
     SIZE 18 BY 1.52
     BGCOLOR 159 FONT 6.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY .95
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 41.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 41.5 BY .95
     BGCOLOR 19 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Nbranch AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 18.5 BY .95
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 79.5 BY 2.57
     BGCOLOR 97 FGCOLOR 7 .

DEFINE RECTANGLE RECT-298
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 78 BY 7.38
     BGCOLOR 31 FGCOLOR 0 .

DEFINE RECTANGLE RECT-299
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 1.95
     BGCOLOR 170 .

DEFINE RECTANGLE RECT-300
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 20 BY 1.95
     BGCOLOR 177 .

DEFINE RECTANGLE RECT-301
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 78.5 BY 2.19
     BGCOLOR 1 FGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_Transfer AT ROW 13.14 COL 18.67
     bu_acnohp AT ROW 6.91 COL 31.83
     fi_acno AT ROW 6.95 COL 14.83 COLON-ALIGNED NO-LABEL
     fi_acno2 AT ROW 9.1 COL 14.67 COLON-ALIGNED NO-LABEL
     bu_acnohp2 AT ROW 9.1 COL 31.83
     bu_exit AT ROW 13.14 COL 46.17
     fi_name AT ROW 7 COL 34.33 COLON-ALIGNED NO-LABEL
     fi_name2 AT ROW 9.1 COL 34.17 COLON-ALIGNED NO-LABEL
     fi_Nbranch AT ROW 10.33 COL 23.67 COLON-ALIGNED NO-LABEL
     "Transfer Agent/Broker's Address to Lotus Notes" VIEW-AS TEXT
          SIZE 62.33 BY 1.52 AT ROW 1.71 COL 10
          BGCOLOR 1 FGCOLOR 6 FONT 2
     "ACNO FROM :" VIEW-AS TEXT
          SIZE 13.67 BY 1.43 AT ROW 6.71 COL 3
          FGCOLOR 15 FONT 6
     "ACNO TO :" VIEW-AS TEXT
          SIZE 11.17 BY .95 AT ROW 9.1 COL 5.5
          FGCOLOR 15 FONT 6
     " ข้อมูล Account code" VIEW-AS TEXT
          SIZE 20.5 BY .95 AT ROW 4.48 COL 6
          FGCOLOR 7 FONT 6
     RECT-1 AT ROW 1.24 COL 1.17
     RECT-298 AT ROW 4.81 COL 2
     RECT-299 AT ROW 12.91 COL 17.5
     RECT-300 AT ROW 12.91 COL 45
     RECT-301 AT ROW 1.43 COL 1.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 16
         BGCOLOR 31 .


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
         TITLE              = "wactinsp.w - Transfer Code to Lotus Notes"
         HEIGHT             = 16
         WIDTH              = 80
         MAX-HEIGHT         = 16
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 16
         VIRTUAL-WIDTH      = 80
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
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wactinsp.w - Transfer Code to Lotus Notes */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wactinsp.w - Transfer Code to Lotus Notes */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_acnohp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_acnohp C-Win
ON CHOOSE OF bu_acnohp IN FRAME fr_main
DO:
  
   Run  whp\whpacno1(OUTPUT fi_acno,
                     OUTPUT fi_name).
                                        
  DISP fi_acno  fi_name WITH FRAME fr_main.   
  APPLY  "Entry" TO fi_acno.
  RETURN NO-APPLY.
                                      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_acnohp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_acnohp2 C-Win
ON CHOOSE OF bu_acnohp2 IN FRAME fr_main
DO:
  
   Run  whp\whpacno1(OUTPUT fi_acno2,
                     OUTPUT fi_name2).
                                        
  DISP fi_acno2  fi_name2 WITH FRAME fr_main.   
  APPLY  "Entry" TO fi_acno2.
  RETURN NO-APPLY.
                                      
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
   APPLY "CLOSE":U TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Transfer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Transfer C-Win
ON CHOOSE OF bu_Transfer IN FRAME fr_main /* Transfer */
DO :
  /*RUN whp\whprinsp1(INPUT fi_acno).*/
  DO WITH FRAME fr_main:
       IF fi_acno = "" THEN DO:
             Message "Please insert ACNO !! " VIEW-AS ALERT-BOX ERROR. 
             APPLY "Entry" To  fi_acno.
             RETURN NO-APPLY.   
        END.
        IF fi_acno2 = "" THEN DO:
               Message "Please insert ACNO !! " VIEW-AS ALERT-BOX ERROR. 
               APPLY "Entry" To  fi_acno2.
               RETURN NO-APPLY.   
        END.
      /*  IF fi_branch = "" THEN DO:
               Message "Please insert Branch !! " VIEW-AS ALERT-BOX ERROR. 
               APPLY "Entry" To  fi_branch.
               RETURN NO-APPLY.   
        END.
        IF fi_taxyr = 0 OR fi_taxyr > YEAR(TODAY) THEN DO:
               Message "Please insert year !! " VIEW-AS ALERT-BOX ERROR. 
               APPLY "Entry" To  fi_taxyr.
               RETURN NO-APPLY.   
        END.  */ 
        MESSAGE "Confirm update data address " fi_acno " - " fi_acno2 " to Lotus Note ? " VIEW-AS ALERT-BOX QUESTION
                   BUTTONS YES-NO TITLE "CONFRIM UPDATE"   UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
               WHEN TRUE THEN DO:
                    nv_con = YES.
                    IF n_User <> ? AND n_Passwd <> ?   THEN
                    RUN pdupdateINBR.
                    ELSE APPLY "CLOSE".
       
               END.
                WHEN FALSE THEN DO:
                    nv_con = NO.
                    RETURN NO-APPLY.   
                END.
        END. /*-case -*/
   END.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON LEAVE OF fi_acno IN FRAME fr_main
DO:
  ASSIGN fi_acno = CAPS (INPUT fi_acno)
         nv_ac1  = CAPS (INPUT fi_acno).
  DISP fi_acno  WITH FRAME fr_main.
  /*MESSAGE nv_ac1 VIEW-AS ALERT-BOX.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON RETURN OF fi_acno IN FRAME fr_main
DO:
  
  ASSIGN fi_acno = CAPS (INPUT fi_acno).
         
  FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
             xtm600.acno = (INPUT fi_acno) NO-LOCK NO-ERROR.
  IF NOT AVAIL xtm600 THEN  DO:
     FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                                 xmm600.acno = (INPUT fi_acno) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN DO:
         MESSAGE "This Code " CAPS (INPUT fi_acno) "is not on file xmm600" VIEW-AS ALERT-BOX.
         APPLY "Entry" to  fi_acno.
         /*RETURN NO-APPLY.*/
     END.
     fi_name  =  xmm600.name.
  END.
  Else fi_name  =  xtm600.name.
  
  DISP fi_acno fi_name WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno2 C-Win
ON LEAVE OF fi_acno2 IN FRAME fr_main
DO:
  ASSIGN fi_acno2 = CAPS (INPUT fi_acno2)
         nv_ac2   = CAPS (INPUT fi_acno2).
  DISP fi_acno2 WITH FRAME fr_main.  
  /*MESSAGE nv_ac2 VIEW-AS ALERT-BOX.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno2 C-Win
ON RETURN OF fi_acno2 IN FRAME fr_main
DO:
  
  ASSIGN fi_acno2 = CAPS (INPUT fi_acno2).

  FIND FIRST xtm600 USE-INDEX xtm60001 WHERE
             xtm600.acno = (INPUT fi_acno2) NO-LOCK NO-ERROR.
  IF NOT AVAIL xtm600 THEN  DO:
     FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                                 xmm600.acno = (INPUT fi_acno2) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN DO:
         MESSAGE "This Code " CAPS (INPUT  fi_acno2) "is not on file xmm600" VIEW-AS ALERT-BOX.
         APPLY "Entry" to  fi_acno2.
         RETURN NO-APPLY.
     END.
     fi_name2  =  xmm600.name.
  END.
  Else fi_name2  =  xtm600.name.
  
  DISP fi_acno2 fi_name2 WITH FRAME fr_main.

/*  APPLY "Entry" to  fi_branch.  
  RETURN NO-APPLY. */          

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

  ASSIGN       n_ac1 = "a000000"            
               n_ac2 = "b999999999".  
    
  DO WITH FRAME fr_main:

  /*  IF n_ac1 = "" THEN DO:
        FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno <> "" NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm600  THEN
        ASSIGN  n_ac1 = xmm600.acno 
                fi_name = sicsyac.xmm600.NAME.
    END.
    IF n_ac2 <> "" THEN DO:
        FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = n_ac2 NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN ASSIGN  fi_name2 = sicsyac.xmm600.NAME.
    END.   */  

    ASSIGN
            fi_acno  = n_ac1
            fi_acno2 = n_ac2 .
           /* fi_branch = "0"
            fi_taxyr  = 0. */ 
    
     DISP fi_acno fi_acno2 fi_name fi_name2.  /*fi_branch fi_taxyr.*/ 
     APPLY "ENTRY" TO fi_acno.

  END.
  
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
  DISPLAY fi_acno fi_acno2 fi_name fi_name2 fi_Nbranch 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_Transfer RECT-1 RECT-298 RECT-299 RECT-300 RECT-301 bu_acnohp 
         fi_acno fi_acno2 bu_acnohp2 bu_exit fi_name fi_name2 fi_Nbranch 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCalsumamt C-Win 
PROCEDURE pdCalsumamt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: หาค่าที่ปรึกษา      
------------------------------------------------------------------------------*/
/*
ASSIGN 
    nv_acnos = ""
    nv_sumam   = 0.

IF nv_acno <> "" THEN DO:  
    FOR EACH ttax100:
        DELETE ttax100.
    END.
    
    FOR EACH tax100  USE-INDEX tax10014  WHERE  
                        tax100.grptyp    = YES         AND 
                        tax100.taxtyp    = "T01"       AND
                        tax100.branch    = fi_branch   AND
                        tax100.taxyr     = fi_taxyr   /* AND
                        tax100.acno      = nv_acno     AND
                        tax100.taxcod    = "45"        AND
                        tax100.taxsta    = YES    */     NO-LOCK.
        IF tax100.acno <> nv_acno THEN NEXT.
        IF tax100.taxcod <> "45" THEN NEXT.
        IF tax100.taxsta <> YES THEN NEXT.

          IF tax100.taxyr = fi_taxyr  THEN DO:
               FIND FIRST ttax100 USE-INDEX ttax1001 WHERE ttax100.acno = tax100.acno NO-ERROR.
                IF NOT AVAIL ttax100 THEN CREATE ttax100. 
                    ASSIGN
                       ttax100.grptyp   = tax100.grptyp  
                       ttax100.taxtyp   = tax100.taxtyp  
                       ttax100.branch   = tax100.branch  
                       ttax100.taxyr    = tax100.taxyr   
                       ttax100.acno     = tax100.acno 
                       ttax100.taxcod   = tax100.taxcod  
                       ttax100.taxsta   = tax100.taxsta
                       ttax100.amount   = ttax100.amount + tax100.amount.
                       nv_acno        = ttax100.acno  
           END.
           ELSE DO:
              CREATE ttax100. 
                   ASSIGN
                       ttax100.grptyp   = tax100.grptyp  
                       ttax100.taxtyp   = tax100.taxtyp  
                       ttax100.branch   = tax100.branch  
                       ttax100.taxyr    = tax100.taxyr   
                       ttax100.acno     = ttax100.acno 
                       ttax100.taxcod   = tax100.taxcod  
                       ttax100.taxsta   = tax100.taxsta
                       ttax100.amount   = 0.
                       nv_acno     = ttax100.acno 
           END.
           nv_sumam         = ttax100.amount. 
    END.
    
END. 
RELEASE tax100.  */ 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateINBR C-Win 
PROCEDURE pdUpdateINBR :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  i   AS INT.
DEF VAR nv_accod  AS CHAR FORMAT "x(3)".
DEF VAR nv_clicod AS CHAR FORMAT "x(3)".  
DEF VAR nv_today  AS CHAR.
DEF VAR nv_time   AS CHAR.
DEF VAR nv_taxno LIKE xmm600.taxno  FORMAT "x(20)".   

ASSIGN nv_acno = ""
       nv_taxno = ""   
       nv_chk  = NO.
      
/*---- comment : -----------
ASSIGN           
           nv_acno =   ""
        /*----อังกฤษ----*/
           nv_name =   ""
           nv_name2 =  ""
           nv_name3 =  ""
           nv_addr1 =  ""
           nv_addr2 =  ""
           nv_addr3 =  ""
           nv_addr4 =  ""
           nv_accod =  ""
        /*-----ไทย------*/
           nv_nameT  = "" 
           nv_nameT2 = "" 
           nv_nameT3 = "" 
           nv_addrT1 = "" 
           nv_addrT2 = "" 
           nv_addrT3 = ""
           nv_addrT4 = "".

FOR EACH sicsyac.xmm600 USE-INDEX xmm60001 WHERE  xmm600.acno >= nv_ac1 AND xmm600.acno <= nv_ac2  
    AND xmm600.acno <> "" AND (xmm600.closed = ? AND  clicod <> "IN" AND clicod <> "PS")
    AND (xmm600.acccod = "AG" OR xmm600.acccod = "BR" OR xmm600.acccod = "DE" OR xmm600.acccod = "FI") NO-LOCK.
-------------------------------- ---------------------------------------------------*/ 

FOR EACH xmm600 USE-INDEX xmm60001 WHERE  (xmm600.acno >= nv_ac1 AND xmm600.acno <= nv_ac2)  NO-LOCK.
    /*--- 
    IF (xmm600.acccod <> "AG" AND xmm600.acccod <> "BR" AND xmm600.acccod <> "DE" AND xmm600.acccod <> "FI") THEN NEXT.
    IF (xmm600.clicod = "IN" OR xmm600.clicod = "PS" OR xmm600.clicod = "RS" OR xmm600.clicod = "OT" OR xmm600.clicod = "PL" ) THEN NEXT.
    ----- end : ------------*/
    /*---------- -----------*/
    IF (xmm600.acccod <> "AG" AND xmm600.acccod <> "BR" AND xmm600.acccod <> "DE" AND xmm600.acccod <> "DI"
        AND xmm600.acccod <> "FI" AND xmm600.acccod <> "FN") THEN NEXT.
    IF (xmm600.clicod <> "AG" AND xmm600.clicod <> "BR" AND xmm600.clicod <> "FI" AND xmm600.clicod <> "FN") THEN NEXT.
    /*------- end: ---------*/
    IF (xmm600.closed <> ?) THEN NEXT.
   /*MESSAGE acno clicod acccod opened closed.*/
    /*------ -------*/
    ASSIGN           
           nv_acno =   ""
        /*----อังกฤษ----*/
           nv_name =   ""
           nv_name2 =  ""
           nv_name3 =  ""
           nv_addr1 =  ""
           nv_addr2 =  ""
           nv_addr3 =  ""
           nv_addr4 =  ""
           nv_accod =  ""
        /*-----ไทย------*/
           nv_nameT  = ""
           nv_nameT2 = ""
           nv_nameT3 = ""
           nv_addrT1 = "" 
           nv_addrT2 = "" 
           nv_addrT3 = ""
           nv_addrT4 = ""
           nv_taxno =  "". 
   
       ASSIGN
              nv_acno =  xmm600.acno
              nv_name =  xmm600.ntitle + xmm600.name 
              nv_name2 =  ""                        
              nv_name3 =  ""                      
              nv_addr1 = xmm600.addr1       
              nv_addr2 = xmm600.addr2       
              nv_addr3 = xmm600.addr3       
              nv_addr4 = xmm600.addr4       
              nv_accod = xmm600.acccod      
              nv_clicod = xmm600.clicod    
              nv_taxno = xmm600.taxno.   
   
        FIND FIRST xtm600 USE-INDEX xtm60001
                             WHERE  xtm600.acno = xmm600.acno NO-LOCK NO-ERROR.
        IF AVAIL xtm600 THEN DO:
                ASSIGN 
                  nv_nameT  = xtm600.ntitle + xtm600.NAME  
                  nv_nameT2 = ""                         
                  nv_nameT3 = ""                         
                  nv_addrT1 = xtm600.addr1
                  nv_addrT2 = xtm600.addr2
                  nv_addrT3 = xtm600.addr3
                  nv_addrT4 = xtm600.addr4.
                
          
             END.  
   
    /*   RUN pdCalsumamt. */
/*----------------------------- Transfer Data to Lotusnote -----------------------------------------*/
       IF nv_acno <> "" THEN DO:  
          ASSIGN 
            nv_today = STRING(TODAY,"99/99/9999")
            nv_time  = STRING(TIME,"HH:MM:SS").
                                
       /*--------- Server Real ----------*/
        nv_server = "Safety_NotesServer/Safety".
        nv_tmp   = "public\Sm_agent.nsf".  
       /* -------------------------------*/  
       /* 
        /*---------- Server test local -------*/
        nv_server = "".
        nv_tmp    = "D:\Lotus\Notes\Data\Sm_agent.nsf" . */
        /*-----------------------------*/
        /*/*---------- Server test -------*/
        nv_server = "Safety_NGT/Safety".
        nv_tmp    = "public\Sm_agent.nsf" .
        /*-----------------------------*/*/
      
        CREATE "Notes.NotesSession"  chNotesSession.
        chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
             
        IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
           MESSAGE "Can not open database" SKIP  
                   "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
           END.
          
        chNotesView    = chNotesDatabase:GetView("Type2").
        chNavView      = chNotesView:CreateViewNav.
        chDocument     = chNotesView:GetDocumentByKey(nv_acno).
      
            
           IF VALID-HANDLE(chDocument) = YES   THEN   DO: /* เจอข้อมูลเดิม */          
             chDocument:NAME    =  nv_name.
             chDocument:name2   =  nv_name2.   
             chDocument:name3   =  nv_name3.   
             chDocument:nameT   =  nv_nameT.
             chDocument:nameT2  =  nv_nameT2. 
             chDocument:nameT3  =  nv_nameT3. 
             chDocument:addr1   =  nv_addr1.
             chDocument:addr2   =  nv_addr2.
             chDocument:addr3   =  nv_addr3.
             chDocument:addr4   =  nv_addr4.
             chDocument:addrT1  =  nv_addrT1.
             chDocument:addrT2  =  nv_addrT2.
             chDocument:addrT3  =  nv_addrT3.
             chDocument:addrT4  =  nv_addrT4. 
           /*  chDocument:sumamt  =  nv_sumam.  */ 
             chDocument:tax_id  = nv_taxno.   
             chDocument:UPDATE  = "แก้ไขโดย " + chNotesSession:UserName + " วันที่ " + nv_today + " " + nv_time.
             chDocument:SAVE( TRUE, TRUE).
             
              DISP "Updating ACNO to Lotus Notes......." SKIP 
              nv_acno  nv_accod nv_clicod nv_taxno WITH NO-LABEL TITLE "Process Data to Lotus Note" FRAME b VIEW-AS DIALOG-BOX.
             
             RELEASE  OBJECT    chItem NO-ERROR.     
             RELEASE  OBJECT    chDocument.          
             RELEASE  OBJECT    chNavView NO-ERROR.  
             RELEASE  OBJECT    chNotesView.         
             RELEASE  OBJECT    chNotesDataBase.     
             RELEASE  OBJECT    chNotesSession. 
             nv_chk = YES.
           END.
           ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO: /*- เพิ่มข้อมูลใหม่ -*/
                chDocument = chNotesDatabase:CreateDocument.
                chDocument:AppendItemValue( "Form", "fr_agent1").
                chDocument:AppendItemValue( "acno",nv_acno).
                chDocument:AppendItemValue( "createdBy",chNotesSession:UserName).
                chDocument:AppendItemValue( "createdOn",nv_today + " " + nv_time).
                chDocument:AppendItemValue( "name",nv_name).
                chDocument:AppendItemValue( "name2",nv_name2).    
                chDocument:AppendItemValue( "name3",nv_name3).    
                chDocument:AppendItemValue( "nameT",nv_nameT). 
                chDocument:AppendItemValue( "nameT2",nv_nameT2).  
                chDocument:AppendItemValue( "nameT3",nv_nameT3).  
                chDocument:AppendItemValue( "addr1",nv_addr1).
                chDocument:AppendItemValue( "addr2",nv_addr2).
                chDocument:AppendItemValue( "addr3",nv_addr3).           
                chDocument:AppendItemValue( "addr4",nv_addr4).
                chDocument:AppendItemValue( "addrT1",nv_addrT1).
                chDocument:AppendItemValue( "addrT2",nv_addrT2).
                chDocument:AppendItemValue( "addrT3",nv_addrT3).
                chDocument:AppendItemValue( "addrT4",nv_addrT4).
             /*   chDocument:AppendItemValue( "sumamt",nv_sumam). */ 
                chDocument:AppendItemValue( "tax_id",nv_taxno).   
                chDocument:SAVE( TRUE, TRUE).
      
                DISP "Add ACNO to Lotus Notes......." SKIP 
                nv_acno  nv_accod nv_clicod nv_taxno WITH NO-LABEL TITLE "Process Data to Lotus Note" FRAME a VIEW-AS DIALOG-BOX.
               
                RELEASE  OBJECT    chDocument NO-ERROR.          
                RELEASE  OBJECT    chNotesDataBase NO-ERROR.     
                RELEASE  OBJECT    chNotesSession NO-ERROR. 
                nv_chk = YES.
        END. 
  END.      

  ELSE NEXT.
  
END. /*--for each--*/
RELEASE xmm600.
RELEASE xtm600.

IF nv_chk = YES THEN MESSAGE "Update address Acno complete..." VIEW-AS ALERT-BOX.
/*
FIND FIRST ttax100 NO-LOCK NO-ERROR.
    IF AVAIL ttax100 THEN DO:
        FOR EACH ttax100 USE-INDEX ttax1001 BREAK BY ttax100.acno:
            DELETE ttax100.
        END.
    END.  */  

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateINBR_O C-Win 
PROCEDURE pdUpdateINBR_O :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DEF VAR  i   AS INT.
DEF VAR nv_accod AS CHAR.
DEF VAR nv_today AS CHAR.

ASSIGN nv_acno = ""
       nv_chk = NO.
MESSAGE nv_ac1 nv_ac2 VIEW-AS ALERT-BOX.
FOR EACH sicsyac.xmm600 USE-INDEX xmm60001 WHERE  xmm600.acno >= nv_ac1 AND xmm600.acno <= nv_ac2 AND 
         xmm600.acccod <> "IN" AND xmm600.acccod <> "AP"  AND xmm600.acccod <> "BD" AND xmm600.acccod <> "BM"  AND
         xmm600.acccod <> "BS" AND xmm600.acccod <> "C1"  AND xmm600.acccod <> "C2" AND xmm600.acccod <> "C3"  AND
         xmm600.acccod <> "C4" AND xmm600.acccod <> "CB"  AND xmm600.acccod <> "CD" AND xmm600.acccod <> "CF"  AND
         xmm600.acccod <> "CL" AND xmm600.acccod <> "CN"  AND xmm600.acccod <> "CO" AND xmm600.acccod <> "CR"  AND 
         xmm600.acccod <> "CT" AND xmm600.acccod <> "CU"  AND xmm600.acccod <> "CV" AND xmm600.acccod <> "EN"  AND 
         xmm600.acccod <> "ES" AND xmm600.acccod <> "ET"  AND xmm600.acccod <> "EV" AND xmm600.acccod <> "EX"  AND 
         xmm600.acccod <> "FC" AND xmm600.acccod <> "FE"  AND xmm600.acccod <> "GA" AND xmm600.acccod <> "GN"  AND 
         xmm600.acccod <> "HB" AND xmm600.acccod <> "HN"  AND xmm600.acccod <> "HT" AND xmm600.acccod <> "IV"  AND 
         xmm600.acccod <> "IX" AND xmm600.acccod <> "LA"  AND xmm600.acccod <> "MC" AND xmm600.acccod <> "PL"  AND
         xmm600.acccod <> "PN" AND xmm600.acccod <> "PR"  AND xmm600.acccod <> "PV" AND xmm600.acccod <> "RA"  AND 
         xmm600.acccod <> "RB" AND xmm600.acccod <> "RC"  AND xmm600.acccod <> "RD" AND xmm600.acccod <> "RF"  AND 
         xmm600.acccod <> "GA" AND xmm600.acccod <> "GN"  AND xmm600.acccod <> "SE" AND xmm600.acccod <> "SF"  AND 
         xmm600.acccod <> "SO" AND xmm600.acccod <> "SP"  AND xmm600.acccod <> "SV" AND xmm600.acccod <> "T1"  AND 
         xmm600.acccod <> "TN" AND xmm600.acccod <> "TP"  AND xmm600.acccod <> "TV" AND xmm600.acccod <> "TX"  AND
         xmm600.acccod <> ""  NO-LOCK.

    /*IF AVAIL sicsyac.xmm600 THEN DO:*/
       ASSIGN
              nv_acno =  sicsyac.xmm600.acno
              nv_name =  sicsyac.xmm600.NAME  
              nv_name2 = sicsyac.xmm600.name
              nv_name3 = sicsyac.xmm600.abname 
              nv_addr1 = sicsyac.xmm600.addr1
              nv_addr2 = sicsyac.xmm600.addr2
              nv_addr3 = sicsyac.xmm600.addr3
              nv_addr4 = sicsyac.xmm600.addr4
              nv_accod = sicsyac.xmm600.acccod.
   /*END.*/
        FIND FIRST sicsyac.xtm600 USE-INDEX xtm60001
             WHERE  sicsyac.xtm600.acno = sicsyac.xmm600.acno NO-LOCK NO-ERROR.
             IF AVAIL sicsyac.xtm600 THEN DO:
                ASSIGN 
                  nv_nameT  = sicsyac.xtm600.NAME
                  nv_nameT2 = sicsyac.xtm600.name
                  nv_nameT3 = sicsyac.xtm600.abname
                  nv_addrT1 = sicsyac.xtm600.addr1
                  nv_addrT2 = sicsyac.xtm600.addr2
                  nv_addrT3 = sicsyac.xtm600.addr3
                  nv_addrT4 = sicsyac.xtm600.addr4.
          
             END.
             /*
             ELSE DO:
                 MESSAGE nv_acno " could not br found on xmm600" VIEW-AS ALERT-BOX.
                 NEXT.
             END. 
             */
   /* MESSAGE "Before cal " nv_acno VIEW-AS ALERT-BOX.*/

    RUN pdCalsumamt.
    
    /*MESSAGE "After" nv_acno VIEW-AS ALERT-BOX.*/
    ASSIGN 
        i = 0
        nv_today = STRING(TODAY,"99/99/9999").
    /*--------- Server Real ----------*/
    /*nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "public\Sm_agent.nsf".*/
    /*-------------------------------*/
          
    /*---------- Server test -------*/
    nv_server = "Safety_NGT/Safety".
    nv_tmp   = "public\Sm_agent.nsf".
    /*-----------------------------*/

    CREATE "Notes.NotesSession"  chNotesSession.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp).
         
    IF  chNotesDatabase:IsOpen()  = NO  THEN  DO:
       MESSAGE "Can not open database" SKIP  
               "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
       /*Apply "Entry" To button-read.                                 
       Return No-Apply.          */
    END.

   MESSAGE nv_acno nv_sumam VIEW-AS ALERT-BOX.  /*aaa*/

   IF nv_acno <> " " THEN
    chNotesView    = chNotesDatabase:GetView("Type2").
    chNavView      = chNotesView:CreateViewNav.
    chDocument     = chNotesView:GetDocumentByKey(nv_acno).
            
    IF VALID-HANDLE(chDocument) = YES   THEN   DO: /* เจอข้อมูลเดิม */
       /*ASSIGN   nvL_addr1   = ""
                nvL_addr2   = ""
                nvL_addr3   = ""
                nvL_addr4   = ""
                nvL_addrT1  = ""
                nvL_addrT2  = ""
                nvL_addrT3  = ""
                nvL_addrT4  = "".
                /*nvL_sumamt  = 0.*/
       chitem   = chDocument:Getfirstitem("addr1") .
       nvL_addr1  = chitem:TEXT. 
       chitem     = chDocument:Getfirstitem("addr2") .
       nvL_addr2  = chitem:TEXT.
       chitem     = chDocument:Getfirstitem("addr3") .
       nvL_addr3  = chitem:TEXT.
       chitem     = chDocument:Getfirstitem("addr4") .
       nvL_addr4  = chitem:TEXT.
       chitem     = chDocument:Getfirstitem("addrT1") . 
       nvL_addrT1 = chitem:TEXT.
       chitem     = chDocument:Getfirstitem("addrT2") .
       nvL_addrT2 = chitem:TEXT.
       chitem     = chDocument:Getfirstitem("addrT3") .
       nvL_addrT3 = chitem:TEXT.
       chitem     = chDocument:Getfirstitem("addrT4") .
       nvL_addrT4  = chitem:TEXT.
       /*chitem     = chDocument:Getfirstitem("sumamt") . 
       nvL_sumamt  = chitem:TEXT.*/

       IF nvL_addr1 = "" THEN chDocument:addr1   =  nv_addr1.     ELSE chDocument:addr1  =  nvL_addr1.
       IF nvL_addr2 = "" THEN chDocument:addr2   =  nv_addr2.     ELSE chDocument:addr2  =  nvL_addr2.
       IF nvL_addr3 = "" THEN chDocument:addr3   =  nv_addr3.     ELSE chDocument:addr3  =  nvL_addr3.
       IF nvL_addr4 = "" THEN chDocument:addr4   =  nv_addr4.     ELSE chDocument:addr4  =  nvL_addr4.
       IF nvL_addrT1 = "" THEN chDocument:addrT1  =  nv_addrT1.  ELSE chDocument:addrT1  =  nvL_addrT1.
       IF nvL_addrT2 = "" THEN chDocument:addrT2  =  nv_addrT2.  ELSE chDocument:addrT2  =  nvL_addrT2.
       IF nvL_addrT3 = "" THEN chDocument:addrT3  =  nv_addrT3.  ELSE chDocument:addrT3  =  nvL_addrT3. 
       IF nvL_addrT4 = "" THEN chDocument:addrT4  =  nv_addrT4.  ELSE chDocument:addrT4  =  nvL_addrT4. */

       chDocument:name2   =  nv_name2. 
       chDocument:name3   =  nv_name3.
       chDocument:nameT2  =  nv_nameT2.
       chDocument:nameT3  =  nv_nameT3.
       chDocument:addr1   =  nv_addr1.
       chDocument:addr2   =  nv_addr2.
       chDocument:addr3   =  nv_addr3.
       chDocument:addr4   =  nv_addr4.
       chDocument:addrT1  =  nv_addrT1.
       chDocument:addrT2  =  nv_addrT2.
       chDocument:addrT3  =  nv_addrT3.
       chDocument:addrT4  =  nv_addrT4. 
       chDocument:sumamt  =  nv_sumam. 

       chDocument:SAVE( TRUE, TRUE).

        DISP "Updating ACNO to Lotus Notes......." SKIP 
             nv_acno nv_sumam nv_accod WITH NO-LABEL TITLE "Process Data to Lotus Note" FRAME a VIEW-AS DIALOG-BOX.

       RELEASE  OBJECT    chItem NO-ERROR.     
       RELEASE  OBJECT    chDocument.          
       RELEASE  OBJECT    chNavView NO-ERROR.  
       RELEASE  OBJECT    chNotesView.         
       RELEASE  OBJECT    chNotesDataBase.     
       RELEASE  OBJECT    chNotesSession. 
       nv_chk = YES.
       END.
       ELSE IF VALID-HANDLE(chDocument) = NO  THEN DO: 
                  
                  chDocument = chNotesDatabase:CreateDocument .
                  chDocument:AppendItemValue( "Form", "fr_agent1").
                  chDocument:AppendItemValue( "createBy",chNotesSession:UserName).
                  chDocument:AppendItemValue( "createOn",nv_today).
                  chDocument:AppendItemValue( "acno",nv_acno).
                  chDocument:AppendItemValue( "name",nv_name).
                  chDocument:AppendItemValue( "name2",nv_name2). 
                  chDocument:AppendItemValue( "name3",nv_name3). 
                  chDocument:AppendItemValue( "nameT",nv_nameT). 
                  chDocument:AppendItemValue( "nameT2",nv_nameT2).
                  chDocument:AppendItemValue( "nameT3",nv_nameT3).
                  chDocument:AppendItemValue( "addr1",nv_addr1).
                  chDocument:AppendItemValue( "addr2",nv_addr2).
                  chDocument:AppendItemValue( "addr3",nv_addr3).           
                  chDocument:AppendItemValue( "addr4",nv_addr4).
                  chDocument:AppendItemValue( "addrT1",nv_addrT1).
                  chDocument:AppendItemValue( "addrT2",nv_addrT2).
                  chDocument:AppendItemValue( "addrT3",nv_addrT3).
                  chDocument:AppendItemValue( "addrT4",nv_addrT4).
                  chDocument:AppendItemValue( "sumamt",nv_sumam).

       chDocument:SAVE( TRUE, TRUE).

       DISP "Updating ACNO to Lotus Notes......." SKIP 
             nv_acno nv_sumam  WITH NO-LABEL TITLE "Process Data to Lotus Note" FRAME a VIEW-AS DIALOG-BOX.

       RELEASE  OBJECT    chItem NO-ERROR.     
       RELEASE  OBJECT    chDocument.          
       RELEASE  OBJECT    chNavView NO-ERROR.  
       RELEASE  OBJECT    chNotesView.         
       RELEASE  OBJECT    chNotesDataBase.     
       RELEASE  OBJECT    chNotesSession. 

       nv_chk = YES.
    END. 

END. /*--for each--*/

IF nv_chk = YES THEN MESSAGE "Update address Acno complete..." VIEW-AS ALERT-BOX.

FIND FIRST ttax100 NO-LOCK NO-ERROR.
    IF AVAIL ttax100 THEN DO:
        FOR EACH ttax100 USE-INDEX ttax1001 BREAK BY ttax100.acno:
            DELETE ttax100.
        END.
    END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

