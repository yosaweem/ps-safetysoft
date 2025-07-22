&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS W-Win 
/*------------------------------------------------------------------------

  File: 

  Description: from cntnrwin.w - ADM SmartWindow Template

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  History: 
          
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */
def buffer bfacm001 for acm001.
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE SmartWindow

&Scoped-define ADM-CONTAINER WINDOW

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME F-Main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS frm_acno to_acno nv_branch BUTTON-10 
&Scoped-Define DISPLAYED-OBJECTS frm_acno to_acno nv_branch nv_text ~
nv_text1 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR W-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BUTTON-10 
     LABEL "Calculate Aging" 
     SIZE 18.5 BY 1.14.

DEFINE VARIABLE nv_branch AS CHARACTER FORMAT "X(256)":U 
     LABEL "Branch" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "HO","All","North","0","1","2","3","4","5","6","7","8","E","J","K","S","m","n","l","u","v","w" 
     SIZE 16 BY 1 NO-UNDO.

DEFINE VARIABLE frm_acno AS CHARACTER FORMAT "X(8)":U INITIAL "A000000" 
     LABEL "From acno" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE nv_text AS CHARACTER FORMAT "X(256)":U 
     LABEL "nv_text" 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1 NO-UNDO.

DEFINE VARIABLE nv_text1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "nv_text" 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1 NO-UNDO.

DEFINE VARIABLE to_acno AS CHARACTER FORMAT "X(8)":U INITIAL "A000000" 
     LABEL "To acno" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME F-Main
     frm_acno AT ROW 2.43 COL 12.5 COLON-ALIGNED
     to_acno AT ROW 2.43 COL 38.5 COLON-ALIGNED
     nv_branch AT ROW 4.1 COL 12.5 COLON-ALIGNED
     BUTTON-10 AT ROW 6 COL 27.5
     nv_text AT ROW 7.91 COL 13 COLON-ALIGNED
     nv_text1 AT ROW 9.33 COL 13 COLON-ALIGNED
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 80 BY 17.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: SmartWindow
   Allow: Basic,Browse,DB-Fields,Query,Smart,Window
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW W-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "<insert SmartWindow title>"
         HEIGHT             = 16.91
         WIDTH              = 80
         MAX-HEIGHT         = 17
         MAX-WIDTH          = 80
         VIRTUAL-HEIGHT     = 17
         VIRTUAL-WIDTH      = 80
         RESIZE             = no
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME


/* ***************  Runtime Attributes and UIB Settings  ************** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW W-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME F-Main
                                                                        */
/* SETTINGS FOR FILL-IN nv_text IN FRAME F-Main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN nv_text1 IN FRAME F-Main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
THEN W-Win:HIDDEN = yes.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _INCLUDED-LIB W-Win 
/* ************************* Included-Libraries *********************** */

{src/adm/method/containr.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME




/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME W-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON END-ERROR OF W-Win /* <insert SmartWindow title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL W-Win W-Win
ON WINDOW-CLOSE OF W-Win /* <insert SmartWindow title> */
DO:
  /* This ADM code must be left here in order for the SmartWindow
     and its descendents to terminate properly on exit. */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BUTTON-10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BUTTON-10 W-Win
ON CHOOSE OF BUTTON-10 IN FRAME F-Main /* Calculate Aging */
DO:

def var nv_cnf as char.
def var nv_acno as char.

nv_acno = frm_acno.

loop_cnf:
do while nv_cnf <> "*":
  find first bfacm001 
     where bfacm001.acno >= nv_acno no-error.
  if not available bfacm001 then do:
    nv_cnf = "*".
    next loop_cnf.
  end. /* if not available bfacm001 */
  if bfacm001.acno > to_acno then do:
  
    nv_cnf = "*".
    next loop_cnf.

  end. /* if bfacm001.acno > to_acno */
  
  nv_acno = bfacm001.acno.
for each acm001 no-lock use-index acm00102
    where acm001.acno = nv_acno
      and acm001.curcod = "bht"
      and acm001.trangp < "z"
      and (acm001.trnty1 = "m" or acm001.trnty1 = "r")

      and acm001.baloc <> 0.
      
    nv_text:screen-value = acm001.acno + " / " + acm001.trnty1 + "-" + acm001.docno.
    run updateaging (input acm001.trnty1, input acm001.docno).
      
end. /* for each acm001 */

find first bfacm001 
     where bfacm001.acno > nv_acno no-error.
  if not available bfacm001 then do:
    nv_cnf = "*".
    next loop_cnf.
  end. /* if not available bfacm001 */

    nv_acno = bfacm001.acno.

end.
 message "Process Completed".
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME frm_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL frm_acno W-Win
ON LEAVE OF frm_acno IN FRAME F-Main /* From acno */
DO:
 assign frm_acno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME nv_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL nv_branch W-Win
ON VALUE-CHANGED OF nv_branch IN FRAME F-Main /* Branch */
DO:
  assign nv_branch.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_acno W-Win
ON LEAVE OF to_acno IN FRAME F-Main /* To acno */
DO:
  assign to_acno.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK W-Win 


/* ***************************  Main Block  *************************** */

/* Include custom  Main Block code for SmartWindows. */
{src/adm/template/windowmn.i}

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-create-objects W-Win _ADM-CREATE-OBJECTS
PROCEDURE adm-create-objects :
/*------------------------------------------------------------------------------
  Purpose:     Create handles for all SmartObjects used in this procedure.
               After SmartObjects are initialized, then SmartLinks are added.
  Parameters:  <none>
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE adm-row-available W-Win _ADM-ROW-AVAILABLE
PROCEDURE adm-row-available :
/*------------------------------------------------------------------------------
  Purpose:     Dispatched to this procedure when the Record-
               Source has a new row available.  This procedure
               tries to get the new row (or foriegn keys) from
               the Record-Source and process it.
  Parameters:  <none>
------------------------------------------------------------------------------*/

  /* Define variables needed by this internal procedure.             */
  {src/adm/template/row-head.i}

  /* Process the newly available records (i.e. display fields,
     open queries, and/or pass records on to any RECORD-TARGETS).    */
  {src/adm/template/row-end.i}

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE CalByAcno W-Win 
PROCEDURE CalByAcno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

def var ip_acno like acm001.acno.
for each acm001 no-lock use-index acm00102
    where acm001.acno = ip_acno
      and acm001.curcod = "bht"
      and acm001.trangp < "z"
      and acm001.trnty1 = "m".
      
    nv_text  = acm001.trnty1 + acm001.trnty2 + "-" + acm001.docno.
    run updateaging (input acm001.trnty1, input acm001.docno).
      
end.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE CalDueDate W-Win 
PROCEDURE CalDueDate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

def input parameter n_trndat as date.
def input parameter n_creday as integer.
def output parameter n_duedat as date.
def     var   nn_trndat       as date format "99/99/9999".
def     var   n_trndd         as inte format "99".
def     var   n_trnmm         as inte format "99".
def     var   n_trnyy         as inte format "9999".
ASSIGN
      n_trndd = day (n_trndat)
      n_trnmm = month (n_trndat)
      n_trnyy = year (n_trndat).

    if day (n_trndat) <> 01 then do:
       ASSIGN
         n_trndd = 01
         n_trnmm = month(n_trndat) + 1
         n_trnyy = year(n_trndat).

       if n_trnmm > 12 then 
          ASSIGN
            n_trnyy = n_trnyy + 1
            n_trnmm = 01.
    end.

    ASSIGN
      nn_trndat = DATE (n_trnmm,n_trndd,n_trnyy)
      n_duedat     = nn_trndat + n_creday.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI W-Win _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(W-Win)
  THEN DELETE WIDGET W-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI W-Win _DEFAULT-ENABLE
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
  DISPLAY frm_acno to_acno nv_branch nv_text nv_text1 
      WITH FRAME F-Main IN WINDOW W-Win.
  ENABLE frm_acno to_acno nv_branch BUTTON-10 
      WITH FRAME F-Main IN WINDOW W-Win.
  {&OPEN-BROWSERS-IN-QUERY-F-Main}
  VIEW W-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-exit W-Win 
PROCEDURE local-exit :
/* -----------------------------------------------------------
  Purpose:  Starts an "exit" by APPLYing CLOSE event, which starts "destroy".
  Parameters:  <none>
  Notes:    If activated, should APPLY CLOSE, *not* dispatch adm-exit.   
-------------------------------------------------------------*/
   APPLY "CLOSE":U TO THIS-PROCEDURE.
   
   RETURN.
       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE local-initialize W-Win 
PROCEDURE local-initialize :
/*------------------------------------------------------------------------------
  Purpose:     Override standard ADM method
  Notes:       
------------------------------------------------------------------------------*/

  /* Code placed here will execute PRIOR to standard behavior. */

  /* Dispatch standard ADM method.                             */
  RUN dispatch IN THIS-PROCEDURE ( INPUT 'initialize':U ) .

  /* Code placed here will execute AFTER standard behavior.    */


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE send-records W-Win _ADM-SEND-RECORDS
PROCEDURE send-records :
/*------------------------------------------------------------------------------
  Purpose:     Send record ROWID's for all tables used by
               this file.
  Parameters:  see template/snd-head.i
------------------------------------------------------------------------------*/

  /* SEND-RECORDS does nothing because there are no External
     Tables specified for this SmartWindow, and there are no
     tables specified in any contained Browse, Query, or Frame. */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE state-changed W-Win 
PROCEDURE state-changed :
/* -----------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------------------------------*/
  DEFINE INPUT PARAMETER p-issuer-hdl AS HANDLE NO-UNDO.
  DEFINE INPUT PARAMETER p-state AS CHARACTER NO-UNDO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE UpdateAging W-Win 
PROCEDURE UpdateAging :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def input parameter in_trnty1 like acm001.trnty1.
def input parameter in_docno like acm001.docno.

def var nv_dockey as char.
def var nv_duedat as date.

nv_dockey = in_trnty1 + in_docno.

def var  chNotesSession     As  Com-Handle.
Def  Var  chNotesDataBase  As  Com-Handle.
Def  Var  chNotesView           As  Com-Handle .
Def  Var  chNavView              As  Com-Handle .
Def  Var  chViewEntry            As  Com-Handle .
Def  Var  chDocument            As  Com-Handle .
Def  Var  chItem                      As  Com-Handle .

Def  Var nv_status As Int Initial 0.


Def  Var   nv_server     As  Char.
Def  Var   nv_branch    As  Char.
Def  Var   nv_acno       As  Char.
Def  Var   nv_tmp         As  char .

nv_server = "Safety_NotesServer/Safety".
nv_tmp         =  "safety\ac\aging.nsf" . 
   

         Create "Notes.NotesSession"  chNotesSession.
         chNotesDatabase  = chNotesSession:GetDatabase (nv_server , nv_tmp).
         
          If chNotesDatabase:IsOpen()  = No Then Do :
               Message "Can not open database" Skip 
                                 "Please Check database and serve" View-As Alert-Box.
               /*Apply "Entry" To button-read.                                 
               Return No-Apply.          */
          End.
    
         chNotesView           = chNotesDatabase:GetView("By Document").
         chNavView              = chNotesView:CreateViewNav.
        /*chViewEntry            = chNavView:GetFirstDocument().*/
        chDocument           = chNotesView:GetDocumentByKey(nv_dockey).
        
         
         If VALID-HANDLE(chDocument) = No  Then  Do :
         chDocument  = chNotesDatabase:CreateDocument.
         chDocument:Save( True, True ).
     

         chItem   = chDocument:replaceItemValue( "Form",   "aging").

    chItem   = chDocument:replaceItemValue( "dockey",  nv_dockey).
     
         End.
         
     chItem   = chDocument:replaceItemValue( "Asdate",  today).
     chItem   = chDocument:replaceItemValue( "AsTime",  string(time,"HH:MM:SS")).

  chItem   = chDocument:replaceItemValue( "branch",  substr(acm001.policy,2,1)).
       
 
 chItem   = chDocument:replaceItemValue( "trnty1",  acm001.trnty1).
 
chItem   = chDocument:replaceItemValue( "trnty2",  acm001.trnty2).

   chItem   = chDocument:replaceItemValue( "docno",  acm001.docno).
    chItem   = chDocument:replaceItemValue( "policy",  acm001.policy).
    chItem   = chDocument:replaceItemValue( "recno",  acm001.recno).

    chItem   = chDocument:replaceItemValue( "trndat",  acm001.trndat).
       chItem   = chDocument:replaceItemValue( "duedat",  nv_duedat).
    
    chItem   = chDocument:replaceItemValue( "prem",  acm001.prem).
    chItem   = chDocument:replaceItemValue( "tax",  acm001.tax).
    chItem   = chDocument:replaceItemValue( "stamp",  acm001.stamp).
    chItem   = chDocument:replaceItemValue( "comm",  acm001.comm).

    chItem   = chDocument:replaceItemValue( "netloc",  acm001.netloc).
    chItem   = chDocument:replaceItemValue( "baloc",  acm001.baloc).
    chItem   = chDocument:replaceItemValue( "acno",  acm001.acno).
    chItem   = chDocument:replaceItemValue( "gpstcs",  acm001.gpstcs).
   chItem   = chDocument:replaceItemValue( "gpage",  acm001.gpage).
   chItem   = chDocument:replaceItemValue( "gpstmt",  acm001.gpstmt).
   chItem   = chDocument:replaceItemValue( "agent",  acm001.agent).
  
 
if substr(acm001.policy,2,1)  = "0" then do:
 chItem   = chDocument:replaceItemValue( "AssignTo",  "Wongsiri Kaewjing").

end.

else  
if substr(acm001.policy,2,1)  = "m" then do:
 chItem   = chDocument:replaceItemValue( "AssignTo",  "Suttipong Sriroj,Jaruwan Saetang").

end.

  find xmm600 no-lock
    where xmm600.acno = acm001.acno no-error.
  if available xmm600 then do:
  
   chItem   = chDocument:replaceItemValue( "gpstcs",  xmm600.gpstcs).
   chItem   = chDocument:replaceItemValue( "gpage",  xmm600.gpage).
   chItem   = chDocument:replaceItemValue( "gpstmt",  xmm600.gpstmt).
     chItem   = chDocument:replaceItemValue( "exec",  xmm600.exec).
     run CalDueDate (input acm001.trndat,
                  input xmm600.crper,
                  output nv_duedat).
 
  chItem   = chDocument:replaceItemValue( "duedat",  nv_duedat).
    
  end.  
  
  
  

 




     /* loop for lotus notes closed file */  

            chDocument:Save( True, True ).

        
         Release Object    chItem. 
         Release Object   chDocument.
         /*Release Object   chViewEntry .*/
         Release Object   chNavView.
         Release Object   chNotesView.
         Release Object   chNotesDataBase.
         Release Object   chNotesSession.

/*
 end. /*  If chDocument:IsValid Then Do : */
*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


