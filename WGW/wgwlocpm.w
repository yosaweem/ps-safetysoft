&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wgwlocpm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwlocpm 
/*************************************************************************
 wgwlocpm.w : LOQ IN เข้าเมนูRun Queue LockTon
 Copyright  : Safety Insurance Public Company Limited
               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------                 
 Database   : BUINT;SICUW;SICSYAC;STAT;GW_SAFE -LD SIC_BRAN ;GW_STAT -LD BRSTAT
 ------------------------------------------------------------------------               
 CREATE BY  : WATSANA K.   ASSIGN: A56-0299   DATE: 21/10/2013
 Modify By  : Porntiwa T.  A62-0105  Date: 19/07/2019
            : Change Host Alpha4 => TMSth (SICUW,SICFN,SICSYAC,UNDERWRT9)
 Modify By  : Porntiwa T. A62-0105  30/07/2019
            : Change Host => TMSth (SICCL,STAT,FORMTMP)          
Modify By   : Sarinya C. A64-0217  20/05/2021
            : Change host => TMPMWSDBIP01             
 *************************************************************************/
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

Def  New Global Shared Var n_user      As    Char.
Def  New Global Shared Var n_passwd    As    Char.

DEF VAR nv_error    AS CHARACTER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-4 RECT-5 RECT-6 RECT-7 fi_username1 ~
fi_password1 fi_username2 fi_password2 fi_username3 fi_password3 bu_OK ~
bu_cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_text1 fi_username1 fi_password1 ~
fi_text2 fi_username2 fi_password2 fi_text3 fi_username3 fi_password3 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwlocpm AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "CANCEL" 
     SIZE 10.5 BY 1.43
     FONT 6.

DEFINE BUTTON bu_OK 
     LABEL "OK" 
     SIZE 10.5 BY 1.43
     FONT 6.

DEFINE VARIABLE fi_password1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_password2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_password3 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_text1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 8 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE fi_text2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 8 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE fi_text3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     BGCOLOR 8 FGCOLOR 12  NO-UNDO.

DEFINE VARIABLE fi_username1 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_username2 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_username3 AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 50 BY 5.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 50 BY 2.19
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 50 BY 5.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 50 BY 5.29
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_text1 AT ROW 2.62 COL 2.67 NO-LABEL WIDGET-ID 44
     fi_username1 AT ROW 3.76 COL 22 COLON-ALIGNED NO-LABEL
     fi_password1 AT ROW 5.14 COL 22 COLON-ALIGNED NO-LABEL BLANK  DEBLANK 
     fi_text2 AT ROW 7.86 COL 2.33 NO-LABEL WIDGET-ID 42
     fi_username2 AT ROW 9 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_password2 AT ROW 10.38 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 26 BLANK  DEBLANK 
     fi_text3 AT ROW 13.14 COL 2.5 NO-LABEL WIDGET-ID 20
     fi_username3 AT ROW 14.33 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_password3 AT ROW 15.71 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 34 BLANK  DEBLANK 
     bu_OK AT ROW 17.48 COL 13.83
     bu_cancel AT ROW 17.48 COL 26.83
     "User name :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 9 COL 10 WIDGET-ID 30
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Password  :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 15.71 COL 10 WIDGET-ID 40
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "Password  :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 5.14 COL 10
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "User name :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 3.76 COL 10
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "                            LOGIN - BUINT" VIEW-AS TEXT
          SIZE 49 BY .95 AT ROW 12.1 COL 2 WIDGET-ID 48
          BGCOLOR 28 FGCOLOR 0 FONT 6
     "Password  :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 10.38 COL 10 WIDGET-ID 32
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "User name :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 14.33 COL 10 WIDGET-ID 38
          BGCOLOR 8 FGCOLOR 0 FONT 6
     "                     LOGIN - PREMIUM" VIEW-AS TEXT
          SIZE 49 BY .95 AT ROW 1.43 COL 2.5
          BGCOLOR 28 FGCOLOR 0 FONT 6
     "                            LOGIN - GW" VIEW-AS TEXT
          SIZE 49 BY .95 AT ROW 6.71 COL 2.17 WIDGET-ID 46
          BGCOLOR 28 FGCOLOR 0 FONT 6
     RECT-4 AT ROW 1.19 COL 1.67
     RECT-5 AT ROW 17.19 COL 1.5
     RECT-6 AT ROW 6.48 COL 1.5 WIDGET-ID 22
     RECT-7 AT ROW 11.81 COL 1.5 WIDGET-ID 24
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 51.17 BY 18.57
         BGCOLOR 10 .


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
  CREATE WINDOW wgwlocpm ASSIGN
         HIDDEN             = YES
         TITLE              = "LOGIN - PREMIUM AND GW AND BUINT <Wgwlocpm.w>"
         HEIGHT             = 18.57
         WIDTH              = 51.17
         MAX-HEIGHT         = 24.57
         MAX-WIDTH          = 80.33
         VIRTUAL-HEIGHT     = 24.57
         VIRTUAL-WIDTH      = 80.33
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
IF NOT wgwlocpm:LOAD-ICON("adeicon/progress.ico":U) THEN
    MESSAGE "Unable to load icon: adeicon/progress.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwlocpm
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fi_text1 IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_text2 IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_text3 IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwlocpm)
THEN wgwlocpm:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwlocpm
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwlocpm wgwlocpm
ON END-ERROR OF wgwlocpm /* LOGIN - PREMIUM AND GW AND BUINT <Wgwlocpm.w> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwlocpm wgwlocpm
ON WINDOW-CLOSE OF wgwlocpm /* LOGIN - PREMIUM AND GW AND BUINT <Wgwlocpm.w> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel wgwlocpm
ON CHOOSE OF bu_cancel IN FRAME fr_main /* CANCEL */
DO:
  APPLY "Close" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_OK wgwlocpm
ON CHOOSE OF bu_OK IN FRAME fr_main /* OK */
DO:
    ASSIGN
        fi_password1 = INPUT fi_password1                              
        fi_username1 = INPUT fi_username1

        fi_password2 = INPUT fi_password2                              
        fi_username2 = INPUT fi_username2

        fi_password3 = INPUT fi_password3                              
        fi_username3 = INPUT fi_username3.
  

    IF CONNECTED ("BUInt") THEN DISCONNECT BUInt . 
  /*  CONNECT  -db buint -H 16.90.20.203 -S 61760 -N TCP -U VALUE(fi_username3) -P VALUE(fi_password3).  -- Test */
    /*CONNECT -db BUInt     -H 16.90.20.202 -S 5022   -N tcp -U VALUE(fi_username) -P VALUE(fi_password). TEST */

       /*CONNECT  -db BUINT -H WSBUINT -S BUINT -N TCP -U VALUE(fi_username3) -P VALUE(fi_password3).*//*Comment A62-0105*/
    /*CONNECT  -db BUINT -H TMSTH -S BUINT -N TCP -U VALUE(fi_username3) -P VALUE(fi_password3).*/   /*Comment A64-0217*/   
    CONNECT  -db BUINT -H TMPMWSDBIP01 -S BUINT -N TCP -U VALUE(fi_username3) -P VALUE(fi_password3).       /*add A64-0217*/       

   
    IF CONNECTED ("BUInt") THEN DO:
        fi_text3 = "Connect Database BUINT Complete" .
        DISP fi_text3  WITH FRAME fr_main.
         wgwlocpm:HIDDEN = YES.
        RUN wgw\wgwtltgn (INPUT fi_username3).  
    END.
   
    IF CONNECTED ("SICUW")    THEN DISCONNECT SICUW.
    IF CONNECTED ("SICSYAC")  THEN DISCONNECT SICSYAC.
    IF CONNECTED ("STAT")     THEN DISCONNECT STAT.
    IF CONNECTED ("sic_bran") THEN DISCONNECT sic_bran.
    IF CONNECTED ("brstat")   THEN DISCONNECT brstat.
    IF CONNECTED ("BUInt")    THEN DISCONNECT BUInt .

    ASSIGN
        fi_password1 = ""
        fi_username1 = ""
        fi_text1     = ""  
        fi_password2 = ""
        fi_username2 = ""
        fi_text2     = ""  
        fi_password3 = ""
        fi_username3 = ""
        fi_text3     = ""  .
    DISP fi_password1 fi_username1 fi_text1
         fi_password2 fi_username2 fi_text2
         fi_password3 fi_username3 fi_text3
    WITH FRAME fr_main.
    wgwlocpm:HIDDEN = NO.
    APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_password1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_password1 wgwlocpm
ON LEAVE OF fi_password1 IN FRAME fr_main
DO:

  fi_password1 = INPUT fi_password1.
  DISP fi_password1 WITH FRAME fr_main.

  IF CONNECTED ("SICUW")   OR  
     CONNECTED ("SICSYAC") OR 
     CONNECTED ("STAT")    THEN DO:
     fi_text1 = "Connect Database Premium Complete" .
     DISP fi_text1 WITH FRAME fr_main.
       

  END.
  ELSE DO: 
      RUN PDCONNECTPM. 
      
   /*   ENABLE bu_OK  WITH FRAME fr_main.*/
  END.

  DISP fi_text1 fi_username1 fi_password1
       bu_ok  
 WITH FRAME fr_main.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_password2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_password2 wgwlocpm
ON LEAVE OF fi_password2 IN FRAME fr_main
DO:
  fi_password2 = INPUT fi_password2.
  DISP fi_password2 WITH FRAME fr_main.
  
  IF CONNECTED ("sic_bran")   OR  
     CONNECTED ("brstat")   THEN DO:
     fi_text2 = "Connect Database GW Complete" .
     DISP fi_text2 WITH FRAME fr_main.

  END.
  ELSE DO: 
      RUN PDCONNECTGW. 
      ENABLE bu_OK  WITH FRAME fr_main.
  END.

DISP fi_text2 fi_username2 fi_password2  WITH FRAME fr_main.
  



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_password3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_password3 wgwlocpm
ON LEAVE OF fi_password3 IN FRAME fr_main
DO:
  fi_password3 = INPUT fi_password3.
  DISP fi_password3 WITH FRAME fr_main.
  /*
  IF CONNECTED ("SICUW")   OR  
     CONNECTED ("SICSYAC") OR 
     CONNECTED ("STAT")    THEN DO:
     fi_text = "Connect Database Premium Complete" .
     DISP fi_text WITH FRAME fr_main.
       

  END.
  ELSE DO: 
      RUN PDCONNECTPM. 
      fi_username = "".
      fi_password = "".
      ENABLE bu_OK  WITH FRAME fr_main.
  END.
*/
  DISP fi_text3 fi_username3 fi_password3 bu_ok  WITH FRAME fr_main.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_username1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_username1 wgwlocpm
ON LEAVE OF fi_username1 IN FRAME fr_main
DO:
  fi_username1 = INPUT fi_username1.
  DISP fi_username1 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_username2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_username2 wgwlocpm
ON LEAVE OF fi_username2 IN FRAME fr_main
DO:
  fi_username2 = INPUT fi_username2.
  DISP fi_username2 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_username3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_username3 wgwlocpm
ON LEAVE OF fi_username3 IN FRAME fr_main
DO:
  fi_username3 = INPUT fi_username3.
  DISP fi_username3 WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwlocpm 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
/*ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.**/

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    RUN enable_UI.
    
    DISABLE bu_OK         WITH FRAME fr_main.

    SESSION:DATA-ENTRY-RETURN = YES.      /* รับค่าปุ่ม ENTER */
    RUN  WUT\WUTWICEN (wgwlocpm:HANDLE).  
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwlocpm  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwlocpm)
  THEN DELETE WIDGET wgwlocpm.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwlocpm  _DEFAULT-ENABLE
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
  DISPLAY fi_text1 fi_username1 fi_password1 fi_text2 fi_username2 fi_password2 
          fi_text3 fi_username3 fi_password3 
      WITH FRAME fr_main IN WINDOW wgwlocpm.
  ENABLE RECT-4 RECT-5 RECT-6 RECT-7 fi_username1 fi_password1 fi_username2 
         fi_password2 fi_username3 fi_password3 bu_OK bu_cancel 
      WITH FRAME fr_main IN WINDOW wgwlocpm.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwlocpm.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCONNECTGW wgwlocpm 
PROCEDURE PDCONNECTGW :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

IF CONNECTED ("sic_bran") THEN DISCONNECT sic_bran.
   CONNECT -db GW_SAFE  -ld SIC_BRAN  -H TMSTH -S GW_SAFE   -N tcp -U VALUE(fi_username2) -P VALUE(fi_password2).

IF CONNECTED ("brstat") THEN DISCONNECT brstat.
   CONNECT -db GW_STAT  -ld BRSTAT   -H TMSTH -S GW_STAT  -N tcp -U VALUE(fi_username2) -P VALUE(fi_password2).

/*-- Comment A62-0105 --
IF CONNECTED ("sic_bran") THEN DISCONNECT sic_bran.
   CONNECT -db GW_SAFE  -ld SIC_BRAN  -H gwtransfer -S GW_SAFE   -N tcp -U VALUE(fi_username2) -P VALUE(fi_password2).

IF CONNECTED ("brstat") THEN DISCONNECT brstat.
   CONNECT -db GW_STAT  -ld BRSTAT   -H gwtransfer -S GW_STAT  -N tcp -U VALUE(fi_username2) -P VALUE(fi_password2).
-- End Comment A62-0105 --*/   

/*
 IF CONNECTED ("sic_bran") THEN DISCONNECT sic_bran.
    CONNECT -db GW_SAFE  -ld sic_bran  -H 16.90.55.11 -S GW_SAFE   -N tcp -U VALUE(fi_username2) -P VALUE(fi_password2).

 IF CONNECTED ("brstat") THEN DISCONNECT brstat.
    CONNECT -db GW_STAT  -ld brstat   -H 16.90.55.11 -S GW_STAT  -N tcp -U VALUE(fi_username2) -P VALUE(fi_password2).
*/
IF CONNECTED ("sic_bran")   OR  
   CONNECTED ("BRSTAT")   THEN DO:

   fi_text2 = "Connect Database GW Complete" .
   DISP fi_text2 WITH FRAME fr_main.
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCONNECTPM wgwlocpm 
PROCEDURE PDCONNECTPM :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 
IF CONNECTED ("SICUW") THEN DISCONNECT SICUW.
   CONNECT -db SICUW     -H TMSth -S SICUW  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).
   /*CONNECT -db SICUW     -H alpha4 -S SICUW  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).*//*Comment A62-0105*/

IF CONNECTED ("SICSYAC") THEN DISCONNECT SICSYAC.
   CONNECT -db SICSYAC   -H TMSth -S SICSYAC  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).
   /*CONNECT -db SICSYAC   -H alpha4 -S SICSYAC  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).*//*Comment A62-0105*/

IF CONNECTED ("STAT") THEN DISCONNECT STAT.
   CONNECT -db STAT      -H TMSth -S STAT  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).
   /*CONNECT -db STAT      -H alpha4 -S STAT  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).*//*Comment A62-0105*/

/*
 IF CONNECTED ("SICUW") THEN DISCONNECT SICUW.
    CONNECT -db SICUW     -H 16.90.55.11 -S SICUW  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).

 IF CONNECTED ("SICSYAC") THEN DISCONNECT SICSYAC.
    CONNECT -db SICSYAC   -H 16.90.55.11 -S SICSYAC  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).

 IF CONNECTED ("STAT") THEN DISCONNECT STAT.
    CONNECT -db STAT      -H 16.90.55.11 -S STAT  -N tcp -U VALUE(fi_username1) -P VALUE(fi_password1).
*/
 IF CONNECTED ("SICUW")   OR  
    CONNECTED ("SICSYAC") OR 
    CONNECTED ("STAT")    THEN DO:

    fi_text1 = "Connect Database Premium Complete" .
    DISP fi_text1 WITH FRAME fr_main.
 END.

  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

