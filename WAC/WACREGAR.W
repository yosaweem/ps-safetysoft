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

  Created: Narin L  Assign A57-0429        21/11/2014 
           โปรแกรมเรียก Report ข้อมูล Agent & Broker 
           
         :  Benjaporn J.  Assign A58-0195   12/06/2015
          เพิ่มคอลัม Date License Expire  >> xmm600.regdate
          
/*Modify by   :  Sarinya C. A59-0439 15/09/2016                          */
/*               เพิ่มข้อมูล ชื่อ ตัวแทน/นายหน้า                         */
/*Modify By   : Watsana K. [A60-0113] Date. 01/03/2017 
                แก้ไขชื่อ ช่อง Name  ให้เป็นภาษาไทย                     */   
/*Modify By   : Natchaya R.[A61-0047] Date. 29/01/2018 
                เพิ่ง ช่อง  Column 1.Group A/C for statistic. ,
                2.Group A/C for statement. และ 3.Cr.limit amount        */   
/*Modify By   : Natchaya R.[A61-0245] Date. 24/05/2018 
                เพิ่ง ช่อง  Column 1. Add.                              */
                เพิ่มช่อง   Column 1. Tel.                                                                
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


DEF VAR nv_find   AS CHAR FORMAT "X(10)".
DEF VAR nv_out    AS CHAR .
DEF VAR nv_type   AS CHAR .
DEF VAR nv_desc   AS CHAR FORMAT "X(30)".
DEF VAR nv_out2   AS CHAR .
DEF VAR nv_count  AS INT  INIT 0.
DEF VAR nv_count2 AS INT  INIT 0.
DEF VAR nv_index  AS INT  INIT 0.
DEF VAR nv_name   AS CHAR FORMAT "x(120)" . /* Add Watsana K. [A60-0113] */

DEF STREAM ns1.

DEF TEMP-TABLE txmm600 LIKE xmm600.
DEF VAR n_code AS CHAR FORMAT "x(250)" INIT "".
DEF VAR nv_acno AS CHAR FORMAT "x(10)" INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-99 RECT-101 RECT-102 fi_acnof fi_acnot ~
fi_export cmpoybu_export bu_exit 
&Scoped-Define DISPLAYED-OBJECTS fi_acnof fi_acnot fi_export fi_status ~
fi_acdesf fi_acdest 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 12.5 BY 1.19
     BGCOLOR 6 FGCOLOR 15 FONT 6.

DEFINE BUTTON cmpoybu_export 
     LABEL "Export" 
     SIZE 12.5 BY 1.19
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE VARIABLE fi_acdesf AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 30.5 BY .91
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acdest AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 30.5 BY .91
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acnof AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_acnot AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_export AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 51.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_status AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 46 BY 1.19
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-101
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 79.5 BY 8.33
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-102
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 76 BY 7.14
     BGCOLOR 180 .

DEFINE RECTANGLE RECT-99
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 79.5 BY 2
     BGCOLOR 18 FGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_acnof AT ROW 4.76 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_acnot AT ROW 5.95 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_export AT ROW 7.19 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_status AT ROW 9.33 COL 3.5 COLON-ALIGNED NO-LABEL
     cmpoybu_export AT ROW 9.33 COL 52.5
     bu_exit AT ROW 9.33 COL 65.5
     fi_acdesf AT ROW 4.81 COL 45.5 COLON-ALIGNED NO-LABEL
     fi_acdest AT ROW 6 COL 45.5 COLON-ALIGNED NO-LABEL
     "Account Code From :" VIEW-AS TEXT
          SIZE 20.5 BY 1.19 AT ROW 4.57 COL 5.5
          BGCOLOR 180 FONT 6
     "Account Code To    :" VIEW-AS TEXT
          SIZE 20 BY 1.19 AT ROW 5.76 COL 5.5
          BGCOLOR 180 FONT 6
     "Report Garage Code" VIEW-AS TEXT
          SIZE 20.83 BY 1.19 AT ROW 1.81 COL 29.33
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "Export To               :" VIEW-AS TEXT
          SIZE 20.5 BY 1.19 AT ROW 6.95 COL 5.5
          BGCOLOR 180 FONT 6
     RECT-99 AT ROW 1.38 COL 2
     RECT-101 AT ROW 3.62 COL 2
     RECT-102 AT ROW 4.33 COL 3.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 81.83 BY 11.19
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
         TITLE              = "Report Garage Code"
         HEIGHT             = 11.19
         WIDTH              = 81.83
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
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
IF NOT C-Win:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fi_acdesf IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_acdest IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_status IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Report Garage Code */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Report Garage Code */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME DEFAULT-FRAME /* Exit */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cmpoybu_export
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cmpoybu_export C-Win
ON CHOOSE OF cmpoybu_export IN FRAME DEFAULT-FRAME /* Export */
DO:
    ASSIGN
        fi_status = "".
    DISP fi_status WITH FRAME fr_input.

    IF INPUT fi_acnof > INPUT fi_acnot AND INPUT fi_acnot <> "" THEN DO:

        MESSAGE "Accout Code From > Account Code To" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_acnof IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.

    IF INPUT fi_acnot = "" THEN DO:
        MESSAGE "Accout Code To is not Mandatory Field!!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_acnot IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.

    IF INPUT fi_export= "" THEN DO:
        MESSAGE "File name to Exportt is not Mandatory Field!!!" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_export IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.
    ASSIGN
        fi_status = "Please Wait to Process"
        fi_acnof  = INPUT fi_acnof
        fi_acnot  = INPUT fi_acnot
        fi_export = INPUT fi_export.
    DISP fi_status WITH FRAME {&FRAME-NAME}.
   
    fi_status = "Please Wait To Export File!!!".
    DISP fi_status WITH FRAME {&FRAME-NAME}.

    OUTPUT STREAM ns1  TO VALUE(fi_export).

    ASSIGN n_code = "CN,CT,CV,EN,EV,EX,GA,GN,GV,HN,HT,IN,IV,PN,PV,SP,TN,TP,TT,TV,TX" .

    nv_count = 0.
    FOR EACH xmm600 USE-INDEX xmm60001 WHERE
             xmm600.acno  >= fi_acnof   AND
             xmm600.acno  <= fi_acnot   NO-LOCK:

        
        IF xmm600.clicod = "IN" THEN DO:
            nv_acno = trim(xmm600.acno).
            IF LENGTH(nv_acno) > 4  THEN NEXT.
            ELSE IF nv_acno = "COMP" THEN NEXT.
        END.

        IF LOOKUP(xmm600.clicod,n_code) = 0 THEN NEXT .

        fi_status = "Process Code : " + xmm600.acno.
        DISP fi_status WITH FRAME {&FRAME-NAME}.

        nv_name     =   "" .  
        nv_name = TRIM(xmm600.ntitle) + " " + (TRIM(xmm600.fname) + " " + TRIM(xmm600.NAME)) .
        IF nv_count = 0 THEN DO:
            PUT STREAM ns1
                "รหัสตัวแทน/นายหน้า"              "|"  
                "NAME"                            "|"  
                "Client Type"                     "|"
                "Account Type"                    "|"
                "Tax No"                          "|" 
                "Branch "                         skip.
        END.
        nv_count = nv_count + 1.   

        PUT STREAM ns1                                          
          xmm600.acno   FORMAT "X(10)"      "|"           
          nv_name       FORMAT "x(100)"     "|"           
          xmm600.clicod FORMAT "X(2)"       "|"           
          xmm600.acccod FORMAT "X(2)"       "|"           
          xmm600.taxno  FORMAT "X(20)"      "|" 
          xmm600.homebr FORMAT "x(2)"       SKIP.         
    END.
    OUTPUT STREAM ns1 CLOSE.

    fi_status = "Export Data Complete!!!".
    DISP fi_status WITH FRAME {&FRAME-NAME}.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acnof
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acnof C-Win
ON LEAVE OF fi_acnof IN FRAME DEFAULT-FRAME
DO:
    ASSIGN
        fi_status = "".

    DISP fi_status WITH FRAME {&FRAME-NAME}.

    IF fi_acnof <> INPUT fi_acnof  THEN DO:

        ASSIGN
            fi_acdesf = ""
            fi_acnof  = TRIM(CAPS(INPUT fi_acnof))
            nv_find   = fi_acnof .
        DISP fi_acnof  fi_acdesf WITH FRAME {&FRAME-NAME}.

        RUN pd_xmm600.

        fi_acdesf = nv_desc.

        DISP fi_acdesf WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acnot
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acnot C-Win
ON LEAVE OF fi_acnot IN FRAME DEFAULT-FRAME
DO:
    ASSIGN
        fi_status = "".
    DISPLAY fi_status WITH FRAME {&FRAME-NAME}.

    IF INPUT fi_acnof > INPUT fi_acnot  THEN DO:
        ASSIGN
            fi_acdest = "".
        DISPLAY fi_acdest WITH FRAME {&FRAME-NAME}.

        MESSAGE "Accout Code To < Account Code From" VIEW-AS ALERT-BOX INFORMATION.
        APPLY "ENTRY" TO fi_acnot IN FRAME {&FRAME-NAME}.
        RETURN NO-APPLY.
    END.

    IF fi_acnot <> INPUT fi_acnot  THEN DO:
        ASSIGN
            fi_acdest = ""
            fi_acnot  = TRIM(CAPS(INPUT fi_acnot))
            nv_find   = fi_acnot .
        DISPLAY fi_acnot fi_acdest WITH FRAME {&FRAME-NAME}.

        RUN pd_xmm600.
        fi_acdest = nv_desc.
        DISPLAY fi_acdest WITH FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */

DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(50)"  NO-UNDO.

gv_prgid = "wacregar".
gv_prog  = "Report Garage Code ".

RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).
 /* Assign by Narin ให้  Program  อยู่ตรงกลางของ  Windows */
RUN  WUT\WUTWICEN (c-win:handle).  


/* CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED. */
SESSION:DATA-ENTRY-RETURN = YES.


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

     ASSIGN
         fi_acnof  = "0C"
         fi_acnot  = "Z"
         fi_export = "D:\TEMP\R" + STRING(TODAY,"999999") + ".csv".
     DISPLAY fi_acnof fi_acnot fi_export WITH FRAME {&FRAME-NAME}.

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
  DISPLAY fi_acnof fi_acnot fi_export fi_status fi_acdesf fi_acdest 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE RECT-99 RECT-101 RECT-102 fi_acnof fi_acnot fi_export cmpoybu_export 
         bu_exit 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_xmm600 C-Win 
PROCEDURE pd_xmm600 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

nv_desc = "".
FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_find NO-LOCK NO-ERROR.
IF AVAIL xmm600 THEN DO:
    nv_desc = xmm600.NAME.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

