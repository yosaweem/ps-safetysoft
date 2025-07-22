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
/*program id       :  wgwhppro.w 
  program name     :  Product PA + Motor 
  Create  by       :  Kridtiya i. A55-0073 On   06/03/2012
  Database Connect :  sicuw , stat                                      */
/* ***************************  Definitions  ************************** */

DEF  SHARED VAR  n_agent1    As   Char    Format    "x(35)".
DEF  SHARED VAR  n_agent2    As   Char    Format    "x(35)".

/* Parameters Definitions ---                                           */

DEF Input-Output Parameter     n_name1  As   Char    Format    "x(35)".
DEF VAR n_agent As Char    Format    "x(35)".
DEF VAR nv_fill As Char Format "x(50)".
DEF VAR n_find  As logi Initial Yes.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE DIALOG-BOX
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define BROWSE-NAME brproduct

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES xcpara49

/* Definitions for BROWSE brproduct                                     */
&Scoped-define FIELDS-IN-QUERY-brproduct xcpara49.type[1] xcpara49.type[7] ~
xcpara49.type[9] 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brproduct 
&Scoped-define QUERY-STRING-brproduct FOR EACH xcpara49 NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-brproduct OPEN QUERY brproduct FOR EACH xcpara49 NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-brproduct xcpara49
&Scoped-define FIRST-TABLE-IN-QUERY-brproduct xcpara49


/* Definitions for DIALOG-BOX Dialog-Frame                              */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS brproduct fisearch Btn_OK IMAGE-22 RECT-1 
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
     SIZE 8.5 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE fisearch AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1 NO-UNDO.

DEFINE IMAGE IMAGE-22
     FILENAME "wimage\bgc01":U
     SIZE 60 BY 15.24.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 58.17 BY 2
     BGCOLOR 3 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brproduct FOR 
      xcpara49 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brproduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brproduct Dialog-Frame _STRUCTURED
  QUERY brproduct NO-LOCK DISPLAY
      xcpara49.type[1] COLUMN-LABEL "Product Type" FORMAT "x(15)":U
            WIDTH 12.5
      xcpara49.type[7] COLUMN-LABEL "Description" FORMAT "x(30)":U
            WIDTH 14.83
      xcpara49.type[9] COLUMN-LABEL "Coverage" FORMAT "x(30)":U
            WIDTH 25.33
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 58.17 BY 11.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     brproduct AT ROW 4.33 COL 1.83
     fisearch AT ROW 2.71 COL 9.5 COLON-ALIGNED NO-LABEL
     Btn_OK AT ROW 2.71 COL 50.33
     "       ค้นหา" VIEW-AS TEXT
          SIZE 58.17 BY .95 TOOLTIP "Search" AT ROW 1.19 COL 1.83
          BGCOLOR 1 FGCOLOR 14 FONT 6
     " ค้นหา:" VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 2.71 COL 3
     IMAGE-22 AT ROW 1 COL 1
     RECT-1 AT ROW 2.24 COL 1.83
     SPACE(1.00) SKIP(12.08)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Product PA + Motor"
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
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB brproduct 1 Dialog-Frame */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

ASSIGN 
       RECT-1:HIDDEN IN FRAME Dialog-Frame           = TRUE.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brproduct
/* Query rebuild information for BROWSE brproduct
     _TblList          = "sicsyac.xcpara49"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > sicsyac.xcpara49.type[1]
"xcpara49.type[1]" "Product Type" "x(15)" "character" ? ? ? ? ? ? no ? no no "12.5" yes no no "U" "" ""
     _FldNameList[2]   > sicsyac.xcpara49.type[7]
"xcpara49.type[7]" "Description" "x(30)" "character" ? ? ? ? ? ? no ? no no "14.83" yes no no "U" "" ""
     _FldNameList[3]   > sicsyac.xcpara49.type[9]
"xcpara49.type[9]" "Coverage" "x(30)" "character" ? ? ? ? ? ? no ? no no "25.33" yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brproduct */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Product PA + Motor */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brproduct
&Scoped-define SELF-NAME brproduct
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brproduct Dialog-Frame
ON MOUSE-SELECT-DBLCLICK OF brproduct IN FRAME Dialog-Frame
DO:
  APPLY "RETURN" TO brproduct.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brproduct Dialog-Frame
ON return OF brproduct IN FRAME Dialog-Frame
DO:

  
   GET CURRENT brproduct.
   FIND CURRENT sicsyac.xcpara49  NO-LOCK.

        /*DISPLAY xmm023.branch @ fisearch WITH FRAME {&FRAME-NAME}.    */
        n_name1 = sicsyac.xcpara49.typ[1].
         
   APPLY "GO" TO FRAME {&FRAME-NAME}.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brproduct Dialog-Frame
ON VALUE-CHANGED OF brproduct IN FRAME Dialog-Frame
DO:
  GET CURRENT brproduct.
   FIND CURRENT sicsyac.xcpara49  NO-LOCK.
      n_name1 = sicsyac.xcpara49.typ[1].
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
    Find first  sicsyac.xcpara49 Where 
        sicsyac.xcpara49.type[3]  = "v70" AND 
        sicsyac.xcpara49.type[1]  Begins nv_fill No-lock No-error .
        If  Avail sicsyac.xcpara49 Then Do :                              
            brproduct:SET-REPOSITIONED-ROW (5).
            REPOSITION brproduct TO Recid  Recid(sicsyac.xcpara49).
            brproduct:SELECT-FOCUSED-ROW ().
    
            n_name1 = sicsyac.xcpara49.type[1]  .
            /*n_name  = sicsyac.xcpara49.itmdes.*/
            n_find  = Yes.

        End.       
        Else Do:
            n_name1 = "".
            /*n_name  = sicsyac.xcpara49.itmdes.*/
                                         
            MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
            return no-apply.
    
            n_find  = No.
        End.     
    
   /***
   OPEN QUERY brproduct FOR EACH sicsyac.xcpara49 use-index sym10001 
        WHERE sicsyac.xcpara49.tabcod  = "u013" /*AND
        sicsyac.xcpara49.itmcod = INPUT fisearch */          NO-LOCK .
          
        If  Avail sicsyac.xcpara49 Then Do :                              
            n_name1 = sicsyac.xcpara49.itmcod.
            /*n_name  = sicsyac.xcpara49.itmdes.*/
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
    Find first  sicsyac.xcpara49 Where 
        sicsyac.xcpara49.type[3]  = "v70" AND 
        sicsyac.xcpara49.type[1]  Begins nv_fill No-lock No-error .
    If  Avail sicsyac.xcpara49 Then Do :                              
        brproduct:SET-REPOSITIONED-ROW (5).
        REPOSITION brproduct TO Recid  Recid(sicsyac.xcpara49).
        brproduct:SELECT-FOCUSED-ROW ().
        n_name1 = sicsyac.xcpara49.type[1]  .
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
    ASSIGN fisearch .  
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
    IF NOT CAN-FIND (FIRST sicsyac.xcpara49)THEN DO:
     MESSAGE "ไม่พบข้อมูล Product Type "
       VIEW-AS ALERT-BOX ERROR.
     RETURN NO-APPLY.
  END. 
  
  OPEN QUERY brproduct FOR EACH sicsyac.xcpara49 use-index xcpara4901
      WHERE sicsyac.xcpara49.type[3]  = "v70"  NO-LOCK . 
  IF CAN-FIND (sicsyac.xcpara49 use-index xcpara4901 ) THEN DO:
     brproduct:SET-REPOSITIONED-ROW (5).
     REPOSITION brproduct TO Recid  Recid(sicsyac.xcpara49).
     brproduct:SELECT-FOCUSED-ROW ().
     APPLY "ENTRY" TO brproduct.  
  END. 

  RUN Wut\WutDiCen(FRAME Dialog-frame:HANDLE).

  WAIT-FOR GO OF FRAME {&FRAME-NAME}.
END.
ASSIGN n_agent1 = n_agent. 
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
  ENABLE brproduct fisearch Btn_OK IMAGE-22 RECT-1 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

