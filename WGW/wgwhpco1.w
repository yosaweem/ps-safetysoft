&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicsyac          PROGRESS
*/
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/
/* Program id       :  wgwhpco1.w 
   program name     :  Coverage to v70 in by phone.  
   Create  by       :  Kridtiya i. A55-0073 On   06/03/2012
   Database Connect :  sicsyac , stat*/
/**/
/* ***************************  Definitions  ************************** */
DEF  SHARED VAR  n_agent1   As   Char    Format    "x(35)".
DEF  SHARED VAR  n_agent2    As   Char    Format    "x(35)".
/* Parameters Definitions ---                                           */
Def   Input-Output Parameter     n_name1  As   Char    Format    "x(35)".
/*Def    Input-Output Parameter    n_chkname  As   Char    Format    "x(35)".*/
/* Local Variable Definitions ---                                       */

Def var n_agent As   Char    Format    "x(35)".
Def Var nv_fill As Char Format "x(50)".
Def Var n_find  As logi Initial Yes.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME bracno

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES sym100

/* Definitions for BROWSE bracno                                        */
&Scoped-define FIELDS-IN-QUERY-bracno sym100.itmcod sym100.itmdes 
&Scoped-define ENABLED-FIELDS-IN-QUERY-bracno 
&Scoped-define QUERY-STRING-bracno FOR EACH sym100 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-bracno OPEN QUERY bracno FOR EACH sym100 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-bracno sym100
&Scoped-define FIRST-TABLE-IN-QUERY-bracno sym100


/* Definitions for DIALOG-BOX Dialog-Frame                              */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fisearch Btn_OK bracno IMAGE-22 RECT-1 
&Scoped-Define DISPLAYED-OBJECTS fisearch 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "ตกลง" 
     SIZE 8.5 BY 1
     BGCOLOR 8 .

DEFINE VARIABLE fisearch AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1 NO-UNDO.

DEFINE IMAGE IMAGE-22
     FILENAME "wimage\bgc01":U
     SIZE 48.5 BY 14.29.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 46 BY 1.52
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY bracno FOR 
      sym100 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE bracno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS bracno Dialog-Frame _STRUCTURED
  QUERY bracno NO-LOCK DISPLAY
      sym100.itmcod FORMAT "x(4)":U WIDTH 6.33
      sym100.itmdes FORMAT "x(40)":U WIDTH 34.83
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 46 BY 11.14 ROW-HEIGHT-CHARS .95.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     fisearch AT ROW 2.48 COL 9.17 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 2.48 COL 36.83
     bracno AT ROW 3.81 COL 2.5
     "ค้นหา" VIEW-AS TEXT
          SIZE 46 BY .95 TOOLTIP "Search" AT ROW 1.19 COL 2.5
          BGCOLOR 1 FGCOLOR 14 FONT 6
     " ค้นหา :" VIEW-AS TEXT
          SIZE 7 BY 1 AT ROW 2.48 COL 3.83
     IMAGE-22 AT ROW 1 COL 1
     RECT-1 AT ROW 2.19 COL 2.5
     SPACE(0.99) SKIP(11.57)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Coverage in V70 by phone"
         DEFAULT-BUTTON Btn_OK.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: DIALOG-BOX
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   Custom                                                               */
/* BROWSE-TAB bracno Btn_OK Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

ASSIGN 
       RECT-1:HIDDEN IN FRAME Dialog-Frame           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE bracno
/* Query rebuild information for BROWSE bracno
     _TblList          = "sicsyac.sym100"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sicsyac.sym100.itmcod
"sym100.itmcod" ? ? "character" ? ? ? ? ? ? no ? no no "6.33" yes no no "U" "" ""
     _FldNameList[2]   > sicsyac.sym100.itmdes
"sym100.itmdes" ? ? "character" ? ? ? ? ? ? no ? no no "34.83" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE bracno */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Coverage in V70 by phone */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME bracno
&Scoped-define SELF-NAME bracno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bracno Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF bracno IN FRAME Dialog-Frame
DO:
  APPLY "RETURN" TO brAcno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bracno Dialog-Frame
ON RETURN OF bracno IN FRAME Dialog-Frame
DO:
   GET CURRENT brAcno.
   FIND CURRENT sicsyac.sym100  NO-LOCK.
        /*DISPLAY sicsyac.sym100.acno @ fisearch WITH FRAME {&FRAME-NAME}. */
        n_name1 = sicsyac.sym100.itmcod.
        /*n_name  = sicsyac.sym100.itmdes  .*/

   APPLY "GO" TO FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bracno Dialog-Frame
ON VALUE-CHANGED OF bracno IN FRAME Dialog-Frame
DO:

   GET CURRENT brAcno.
   FIND CURRENT sicsyac.sym100  NO-LOCK.
 
        /*DISPLAY sicsyac.sym100.acno @ fisearch WITH FRAME {&FRAME-NAME}. */
        n_name1 = sicsyac.sym100.itmcod.
        /*n_name  = sicsyac.sym100.itmdes.*/


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fisearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisearch Dialog-Frame
ON ANY-KEY OF fisearch IN FRAME Dialog-Frame
DO:
     /*IF Input ra_sort = 1 Then Do :
        nv_fill =  fisearch:Screen-Value  +   Chr(Lastkey) .*/
    fisearch = INPUT fisearch.
    DISP fisearch WITH FRAM fr_main.
    nv_fill =  fisearch:Screen-Value  +   Chr(Lastkey) .
    Find first  sicsyac.sym100 Where 
        sicsyac.sym100.tabcod = "u013" AND
        sicsyac.sym100.itmcod   Begins nv_fill No-lock No-error .
        If  Avail sicsyac.sym100 Then Do :                              
            bracno:SET-REPOSITIONED-ROW (5).
            REPOSITION bracno TO Recid  Recid(sicsyac.sym100).
            bracno:SELECT-FOCUSED-ROW ().
    
            n_name1 = sicsyac.sym100.itmcod.
            /*n_name  = sicsyac.sym100.itmdes.*/
            n_find  = Yes.

        End.       
        Else Do:
            n_name1 = "".
            /*n_name  = sicsyac.sym100.itmdes.*/
                                         
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
            return no-apply.
    
            n_find  = No.
        End.     
    
   /***
   OPEN QUERY brAcno FOR EACH sicsyac.sym100 use-index sym10001 
        WHERE sicsyac.sym100.tabcod  = "u013" /*AND
        sicsyac.sym100.itmcod = INPUT fisearch */          NO-LOCK .
          
        If  Avail sicsyac.sym100 Then Do :                              
            n_name1 = sicsyac.sym100.itmcod.
            /*n_name  = sicsyac.sym100.itmdes.*/
            n_find  = Yes.
            
        End.       
        Else Do:
            n_name1 = "    ".
            /*n_name  = "  " .*/
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
            return no-apply.
    
            n_find  = No.
        End.     
    */
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisearch Dialog-Frame
ON BACKSPACE OF fisearch IN FRAME Dialog-Frame
DO:
    nv_fill = substring(nv_fill,1,length(nv_fill) - 1 ).
    Find first  sicsyac.sym100 Where 
        sicsyac.sym100.tabcod = "u013" AND
        sicsyac.sym100.itmcod   Begins nv_fill No-lock No-error .
    If  Avail sicsyac.sym100 Then Do :                              
        bracno:SET-REPOSITIONED-ROW (5).
        REPOSITION bracno TO Recid  Recid(sicsyac.sym100).
        bracno:SELECT-FOCUSED-ROW ().
        n_name1 = sicsyac.sym100.itmcod.
        /*n_name  = sicsyac.sym100.itmdes.*/
        n_find  = Yes.
        
    END.
    Else Do:
        n_name1  = "    ".
        MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        return no-apply.
        n_find  = No.
    END.

    
End.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisearch Dialog-Frame
ON LEAVE OF fisearch IN FRAME Dialog-Frame
DO:
    fisearch  = INPUT fisearch .
    DISP fisearch WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fisearch Dialog-Frame
ON RETURN OF fisearch IN FRAME Dialog-Frame
DO:

  APPLY "GO" TO FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */
/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
    THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
    RECT-1:move-to-top().  
    IF NOT CAN-FIND (FIRST sicsyac.sym100)THEN DO:
     MESSAGE "ไม่พบข้อมูลประเภทประกันภัย"
       VIEW-AS ALERT-BOX ERROR.
     RETURN NO-APPLY.
  END.
  
  OPEN QUERY brAcno FOR EACH sicsyac.sym100 use-index sym10001 
      WHERE sicsyac.sym100.tabcod  = "u013"  NO-LOCK .
  
  IF CAN-FIND (sicsyac.sym100 use-index sym10001 ) THEN DO:
     brAcno:SET-REPOSITIONED-ROW (5).
     REPOSITION brAcno TO Recid  Recid(sicsyac.sym100).
     brAcno:SELECT-FOCUSED-ROW ().
     APPLY "ENTRY" TO bracno.  
  END.

  RUN Wut\WutDiCen(FRAME Dialog-frame:HANDLE).

  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
n_agent1 = n_agent. 
     /*if n_chkname = "1" and n_agent <> ""  then do:
             n_agent1 = n_agent. 
     end.
     else if n_chkname = "2" and n_agent <> "" then do:
             n_agent2 = n_agent.
     end.  */ 
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY fisearch 
      WITH FRAME Dialog-Frame.
  ENABLE fisearch Btn_OK bracno IMAGE-22 RECT-1 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

