&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
sic_test         PROGRESS  */
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
     by this procedure. This is a good DEFINEault which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/* ***************************  DEFINEinitions  ************************** */
/*programid   : wgwtdlsu.w                                                           */ 
/*programname : load text file ป้ายแดง ของอีซูซู สยามซิตี้                           */ 
/* Copyright  : Safety Insurance Public Company Limited                              */
/*              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                                   */
/*create by   : Kridtiya i. A57-0009  20/01/2014            
                ปรับโปรแกรมให้สามารถนำเข้า text file ป้ายแดง ของอีซูซู สยามซิตี้     */ 
/*----------------------------------------------------------------------*/
SESSION:MULTITASKING-INTERVAL = 1 .                                        
DEF VAR gv_id AS CHAR FORMAT "X(15)" NO-UNDO.     /*A53-0220*/
DEF VAR nv_pwd AS CHAR  FORMAT "x(15)" NO-UNDO.   /*A53-0220*/
{wgw\wgwmtbyd.i}      /*ประกาศตัวแปร*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_brpara fi_tpbip fi_tpbiac fi_tppda ~
fi_ap01 fi_ap02 fi_producer fi_agent fi_filename bu_file buok bu_exit ~
bu_hpacno1 bu_hpagent fi_output1 fi_pack fi_ap03 fi_vatcode RECT-370 ~
RECT-372 RECT-379 
&Scoped-Define DISPLAYED-OBJECTS fi_brpara fi_tpbip fi_tpbiac fi_tppda ~
fi_ap01 fi_ap02 fi_producer fi_agent fi_filename fi_proname fi_agtname ~
fi_output1 fi_pack fi_ap03 fi_vatcode 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ap01 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ap02 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ap03 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brpara AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 19.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 75 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tpbiac AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tpbip AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 31.17 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tppda AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 31.33 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 19.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 110 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 109 BY 12.86
     BGCOLOR 19 FGCOLOR 1 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 87 BY 3.81
     BGCOLOR 10 FGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_brpara AT ROW 5.05 COL 24 COLON-ALIGNED NO-LABEL
     fi_tpbip AT ROW 7.14 COL 19.83 COLON-ALIGNED NO-LABEL
     fi_tpbiac AT ROW 8.1 COL 19.67 COLON-ALIGNED NO-LABEL
     fi_tppda AT ROW 9.05 COL 19.67 COLON-ALIGNED NO-LABEL
     fi_ap01 AT ROW 6.95 COL 62 COLON-ALIGNED NO-LABEL
     fi_ap02 AT ROW 7.91 COL 62 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 2.91 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 3.95 COL 18.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 10.52 COL 24.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 10.52 COL 102.17
     buok AT ROW 13.14 COL 39.5
     bu_exit AT ROW 13.14 COL 57
     fi_proname AT ROW 2.91 COL 39 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 2.91 COL 36.67
     fi_agtname AT ROW 3.95 COL 39 COLON-ALIGNED NO-LABEL
     bu_hpagent AT ROW 3.95 COL 36.67
     fi_output1 AT ROW 11.57 COL 24.5 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 5.05 COL 52.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_ap03 AT ROW 8.86 COL 62 COLON-ALIGNED NO-LABEL WIDGET-ID 12
     fi_vatcode AT ROW 5.05 COL 69.17 COLON-ALIGNED NO-LABEL WIDGET-ID 46
     "TPBI/Per :" VIEW-AS TEXT
          SIZE 11.33 BY .91 AT ROW 7.14 COL 10.17
     " Input File Name Match :" VIEW-AS TEXT
          SIZE 23.5 BY .95 AT ROW 10.52 COL 3
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "42 :" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 7.91 COL 59
     "TPPD/Acc :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 9.05 COL 10
     " Output Data File Load :" VIEW-AS TEXT
          SIZE 23.17 BY .95 AT ROW 11.57 COL 3
          BGCOLOR 8 FGCOLOR 1 
     "Parameter BR-Dealer :" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 5.1 COL 4
          BGCOLOR 8 FGCOLOR 1 
     "43 :" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 8.86 COL 59 WIDGET-ID 16
     "    Agent Code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 3.95 COL 4
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Coverage :" VIEW-AS TEXT
          SIZE 15.5 BY .62 AT ROW 6.19 COL 3.33 WIDGET-ID 44
          BGCOLOR 10 
     "TPBI/Acc :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 8.1 COL 10
     " MATCH FILE BYD TO FILE LOAD STD TEMPLTE" VIEW-AS TEXT
          SIZE 108.17 BY .95 AT ROW 1.33 COL 2.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.91 COL 4
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "41:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 6.95 COL 59
     " Pack :" VIEW-AS TEXT
          SIZE 7.17 BY .95 AT ROW 5.05 COL 47 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Vat Code :" VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 5.05 COL 60.33 WIDGET-ID 48
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.67 COL 1.5
     RECT-379 AT ROW 6.48 COL 3 WIDGET-ID 42
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 111.33 BY 14.71
         BGCOLOR 3 FONT 6.


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
  CREATE WINDOW c-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Match File BYD To STD (WGWMATBYD.W)"
         HEIGHT             = 14.67
         WIDTH              = 110
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Match File BYD To STD (WGWMATBYD.W) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Match File BYD To STD (WGWMATBYD.W) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
   IF fi_filename = "" THEN DO:
      MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_filename.
      RETURN NO-APPLY.
   END.
   IF fi_output1 = "" THEN DO:
      MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
      APPLY "Entry" TO fi_output1.
      RETURN NO-APPLY.
   END.
   For each  wdetail :
     DELETE  wdetail.
   END.
   RUN proc_assign.
   MESSAGE "Match file complete" VIEW-AS ALERT-BOX.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "Text Documents" "*.csv"*/
       "CSV (Comma Delimited)"   "*.csv"   /*,
                            "Data Files (*.dat)"     "*.dat",
                    "Text Files (*.txt)" "*.txt"*/
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         /***--- 08/11/2006 ---***/
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  + "_Load" + no_add + ".csv".
            

         DISP fi_filename fi_output1  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output1.
         RETURN NO-APPLY.
    END.

    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 c-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent c-Win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600.."  View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.  
        END.
        ELSE   
            ASSIGN  
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent) .   
    END.
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ap01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ap01 c-Win
ON LEAVE OF fi_ap01 IN FRAME fr_main
DO:
    fi_ap01 = INPUT fi_ap01.
    DISP fi_ap01 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ap02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ap02 c-Win
ON LEAVE OF fi_ap02 IN FRAME fr_main
DO:
  fi_ap02 = INPUT fi_ap02 .
  DISP fi_ap02 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ap03
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ap03 c-Win
ON LEAVE OF fi_ap03 IN FRAME fr_main
DO:
  fi_ap03 = INPUT fi_ap03 .
  DISP fi_ap03 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brpara
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brpara c-Win
ON LEAVE OF fi_brpara IN FRAME fr_main
DO:
    fi_brpara = INPUT fi_brpara.
    DISP fi_brpara WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output1 c-Win
ON LEAVE OF fi_output1 IN FRAME fr_main
DO:
    fi_output1 = INPUT fi_output1 .
    DISP fi_output1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output1 c-Win
ON VALUE-CHANGED OF fi_output1 IN FRAME fr_main
DO:
    fi_output1 = INPUT fi_output1 .
    DISP fi_output1 WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack c-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    fi_pack = caps(INPUT fi_pack) .
    IF  Input fi_pack  =  ""  Then do:
        Message "กรุณาระบุ Pack Code ." View-as alert-box.
        Apply "Entry"  To  fi_pack.
    END.
    Disp fi_pack  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.    /*note add on 10/11/2005*/
        END.
        ELSE 
            ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer)  /*note modi 08/11/05*/
                /*nv_producer = fi_producer*/    .       /*note add  08/11/05*/
         
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tpbiac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tpbiac c-Win
ON LEAVE OF fi_tpbiac IN FRAME fr_main
DO:
    fi_tpbiac = INPUT fi_tpbiac.
    DISP fi_tpbiac WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tpbip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tpbip c-Win
ON LEAVE OF fi_tpbip IN FRAME fr_main
DO:
    fi_tpbip = INPUT fi_tpbip.
    DISP fi_tpbip WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tppda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tppda c-Win
ON LEAVE OF fi_tppda IN FRAME fr_main
DO:
  fi_tppda = INPUT fi_tppda .
  DISP fi_tppda WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode c-Win
ON LEAVE OF fi_vatcode IN FRAME fr_main
DO:
    fi_vatcode = caps(INPUT fi_vatcode) .
    IF  fi_vatcode <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_vatcode   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_vatcode.
            RETURN NO-APPLY.    /*note add on 10/11/2005*/
        END.
        ELSE 
            ASSIGN
               fi_vatcode =  caps(INPUT  fi_vatcode)  .
         
    END.
    Disp fi_vatcode  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode c-Win
ON VALUE-CHANGED OF fi_vatcode IN FRAME fr_main
DO:
    fi_vatcode = INPUT fi_vatcode .
    Disp  fi_vatcode  WITH Frame  fr_main.  
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.
/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.
 
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
   RUN enable_UI.
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)"  NO-UNDO.
  ASSIGN 
      gv_prgid = "wgwmtbyd.w"
      gv_prog  = "Match File BYD to File Load STD Templet" .
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  
  ASSIGN
      fi_brpara  = "BYD_BR"
      fi_tpbip    = 1000000
      fi_tpbiac   = 10000000
      fi_tppda    = 5000000
      fi_ap01     = 200000
      fi_ap02     = 200000
      fi_ap03     = 200000
      /*fi_tpbip2   = 1000000   
      fi_tpbiac2  = 10000000 
      fi_tppda2   = 5000000  
      fi_ap1      = 200000    
      fi_ap2      = 200000    
      fi_ap3      = 200000  */
         
      fi_pack       = "T"      
      fi_producer  = ""  
      fi_agent     = "" .

  DISP fi_tpbip    fi_tpbiac  fi_tppda  fi_ap01    fi_ap02    fi_ap03  fi_producer  fi_brpara  fi_pack 
       /*fi_tpbip2       fi_tpbiac2      fi_tppda2   fi_ap1     fi_ap2    fi_ap3 */    fi_agent  WITH FRAME fr_main.
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
  THEN DELETE WIDGET c-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-Win  _DEFAULT-ENABLE
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
  DISPLAY fi_brpara fi_tpbip fi_tpbiac fi_tppda fi_ap01 fi_ap02 fi_producer 
          fi_agent fi_filename fi_proname fi_agtname fi_output1 fi_pack fi_ap03 
          fi_vatcode 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE fi_brpara fi_tpbip fi_tpbiac fi_tppda fi_ap01 fi_ap02 fi_producer 
         fi_agent fi_filename bu_file buok bu_exit bu_hpacno1 bu_hpagent 
         fi_output1 fi_pack fi_ap03 fi_vatcode RECT-370 RECT-372 RECT-379 
      WITH FRAME fr_main IN WINDOW c-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  A67-0029   
------------------------------------------------------------------------------*/
DO:
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        CREATE wdetail.
        IMPORT DELIMITER "|"   
            wdetail.riskno         /* No                   */
            wdetail.memo1          /* Contract Date        */
            wdetail.prepol         /* Policy Renew / New   */ 
            wdetail.comdat         /* Com Date(ประกัน)     */
            wdetail.expdat         /* Expiry Date(ประกัน)  */
            wdetail.comdat72       /* Com Date(พ.ร.บ.)     */
            wdetail.expdat72       /* Expiry Date(พ.ร.บ.)  */
            wdetail.appenno        /* Contract Number      */
            wdetail.memo2          /* Dealer Code          */
            wdetail.memo3          /* Showroom Name        */
            wdetail.tiname         /* Title Name           */
            wdetail.insnam         /* First name           */
            wdetail.lastname       /* Last name            */
            wdetail.icno           /* เลขที่บัตรประชาชน    */
            wdetail.gender         /* เพศ                  */
            wdetail.bdate          /* วัน/เดือน/ปีเกิด     */
            wdetail.nation         /* Nationality          */
            wdetail.mail1          /* Email                */
            wdetail.tele1          /* เบอร์โทรศัพท์ลูกค้า  */
            wdetail.addr           /* Address1             */
            wdetail.tambon         /* Address2             */
            wdetail.amper          /* Address3             */
            wdetail.post           /* รหัสไปรษณีย์         */
            wdetail.brand          /* Brand                */
            wdetail.model          /* Model                */
            wdetail.yrmanu        /* Car Year             */
            wdetail.eng            /* Engine               */
            wdetail.engcc          /* CC                   */
            wdetail.chasno         /* Chassis / Vin (1)    */
            wdetail.eng_no2        /* Chassis / Vin (2)    */
            wdetail.maksi          /* ราคารถ (Market Value)*/
            wdetail.weight         /* Weight               */
            wdetail.colorcar       /* Color                */
            wdetail.vehreg         /* Licence no           */
            wdetail.seat           /* Seat/จำนวนที่นั่ง    */
            wdetail.txt1           /* Motor Type           */
            wdetail.txt2           /* Motor Power          */
            wdetail.txt3           /* Motor Torque         */
            wdetail.watt           /* Motor Horse Power    */
            wdetail.txt4           /* Electrical Motor Serial No     */
            wdetail.txt5           /* Battery Type                   */
            wdetail.txt6           /* Battery Capacity               */
            wdetail.battyr         /* Battery Year No                */
            wdetail.txt7           /* Battery Serial No              */
            wdetail.drivername1    /* ชื่อ-นามสกุล ผู้ขับขี่คนที่ 1  */
            wdetail.dbirth         /* วันเดือนปีเกิดผู้ขับขี่คนที่ 1 */
            wdetail.dgender1       /* Gender 1                       */
            wdetail.dicno          /* ID No1                         */
            wdetail.ddriveno       /* License No 1                   */
            wdetail.doccup         /* อาชีพผู้ขับขี่คนที่ 1          */
            wdetail.drivername2    /* ชื่อ-นามสกุล ผู้ขับขี่คนที่ 2  */
            wdetail.ddbirth        /* วันเดือนปีเกิดผู้ขับขี่คนที่ 2 */
            wdetail.dgender2       /* Gender 2                       */
            wdetail.ddicno         /* ID No2                         */
            wdetail.dddriveno      /* License No 2                   */
            wdetail.ddoccup        /* อาชีพผู้ขับขี่คนที่ 2          */
            wdetail.dname3         /* ชื่อ-นามสกุล ผู้ขับขี่คนที่ 3  */
            wdetail.dbirth3        /* วันเดือนปีเกิดผู้ขับขี่คนที่ 3 */
            wdetail.dgender3       /* Gender 3                       */
            wdetail.dicno3         /* ID No3                         */
            wdetail.ddriveno3      /* LicenseNo 3                    */
            wdetail.doccup3        /* อาชีพผู้ขับขี่คนที่ 3          */
            wdetail.dname4         /* ชื่อ-นามสกุล ผู้ขับขี่คนที่ 4  */
            wdetail.dbirth4        /* วันเดือนปีเกิดผู้ขับขี่คนที่ 4 */
            wdetail.dgender4       /* Gender 4                       */
            wdetail.dicno4         /* ID No4                         */
            wdetail.ddriveno4      /* License No 4                   */
            wdetail.doccup4        /* อาชีพผู้ขับขี่คนที่ 4          */
            wdetail.dname5         /* ชื่อ-นามสกุล ผู้ขับขี่คนที่ 5  */
            wdetail.dbirth5        /* วันเดือนปีเกิดผู้ขับขี่คนที่ 5 */
            wdetail.dgender5       /* Gender 5                       */
            wdetail.dicno5         /* ID No5                         */
            wdetail.ddriveno5      /* LicenseNo 5                    */
            wdetail.doccup5        /* อาชีพผู้ขับขี่คนที่ 5          */
            wdetail.covcod         /* ประเภทกรมธรรม์                 */
            wdetail.class70        /* รหัสรถ                         */
            wdetail.garage         /* Garage                         */
            wdetail.vehuse         /* ลักษณะการใช้รถ                 */
            wdetail.tpfire         /* ทุนประกันภัย                   */
            wdetail.premt          /* เบี้ยสุทธิ                     */
            wdetail.rstp_t         /* Stamp Duty                     */
            wdetail.rtax_t         /* VAT                            */
            wdetail.prmtotal70     /* เบี้ยรวม กธ.                   */
            wdetail.premt72        /* Comp.Prem                      */
            wdetail.rstp_t72       /* Stamp Duty                     */    
            wdetail.rtax_t72       /* VAT                            */  
            wdetail.prmtotal72     /* เบี้ยรวม พรบ.                  */ 
            wdetail.barcode        /* Sticker No                     */
            wdetail.product        /* Campaign                       */
            wdetail.benname        /* Beneficiary                    */
            wdetail.memo4          /*ชื่อการออกใบเสร็จ-ใบกำกับ        */ 
            wdetail.accdata1       /*อุปกรณ์ตกแต่งเพิ่มเติม           */
            wdetail.accdata2       /*อุปกรณ์ตกแต่งเพิ่มเติม           */
            wdetail.accdata3       /*อุปกรณ์ตกแต่งเพิ่มเติม           */ 
            wdetail.memo5          /*ข้อมูลเพิ่มเติมอื่นๆ             */ 
            wdetail.policyno       /*Policy No.  (กรมธรรม์ภาคสมัครใจ) */ 
            wdetail.compolusory    /*Policy No.  (กรมธรรม์ภาคบังคับ)  */ 
            wdetail.producer       /*Producer Code                    */ 
            wdetail.agent          /*Agent Code                       */ 
            wdetail.comper70       /*Commission                       */ 
            wdetail.vatcode        /*Vat Code                         */ 
            wdetail.packcod        /*Product (Campaign )              */ 
            wdetail.memo6          /*Text f7 (ช่องที่ 1)              */  
            wdetail.memo7          /*Text f7 (ช่องที่ 2)              */  
            wdetail.memo8          /*Text f7 (ช่องที่ 3)              */  
            wdetail.memo9          /*Text f7 (ช่องที่ 4)              */  
            wdetail.txt8           /*Text f5 (ช่องที่ 1)              */ 
            wdetail.txt9           /*Text f5 (ช่องที่ 1)              */ 
            wdetail.txt10 .        /*Text f5 (ช่องที่ 1)              */ 
    END.
    RUN proc_assign2.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2 c-Win 
PROCEDURE proc_assign2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def VAR n_dname AS CHAR INIT "" .     
def var n_title AS CHAR init "" .                     
def var n_name  AS CHAR init "" .                     
def var n_lname AS CHAR init "" . 
DEF VAR n_drivno AS INTE INIT 0 .
DO:
    FOR EACH wdetail .
        IF       trim(wdetail.riskno) = "" THEN DELETE wdetail.
        ELSE IF index(TRIM(wdetail.riskno),"no")     <> 0 THEN DELETE wdetail.
        ELSE IF index(TRIM(wdetail.riskno),"เลขที่") <> 0 THEN DELETE wdetail.
        ELSE IF index(TRIM(wdetail.riskno),"risk")   <> 0 THEN DELETE wdetail.
        ELSE DO:
            /* Producer , Agent ,coverage */
            ASSIGN 
               n_drivno = 0 
               wdetail.TYPE     = IF wdetail.prepol = "" THEN "Y" ELSE "N"
               wdetail.producer = if wdetail.producer = "" then trim(fi_producer) else trim(wdetail.producer)   
               wdetail.agent    = if wdetail.agent    = "" then trim(fi_agent) else trim(wdetail.agent)   
               wdetail.vatcode  = if wdetail.vatcode  = "" then trim(fi_vatcode) else trim(wdetail.vatcode) 
               wdetail.comper   = string(fi_tpbip)   
               wdetail.comacc   = string(fi_tpbiac)   
               wdetail.deductpd = string(fi_tppda)   
               wdetail.NO_41    = string(fi_ap01)   
               wdetail.ac4      = string(fi_ap01)  
               wdetail.ac6      = IF INTE(wdetail.seat) <> 0 THEN STRING(INTE(wdetail.seat) - 1) ELSE "0"
               wdetail.NO_42    = string(fi_ap02)   
               wdetail.NO_43    = string(fi_ap03)
               wdetail.garage   = IF TRIM(wdetail.garage) = "ซ่อมห้าง" THEN "G" ELSE ""  
               wdetail.comper70 = IF INDEX(wdetail.comper70,"%") <> 0 THEN TRIM(REPLACE(wdetail.comper70,"%","")) ELSE wdetail.comper70  .

          IF DECI(wdetail.premt72) <> 0 THEN DO:
            ASSIGN wdetail.compul   = IF DECI(wdetail.premt72) <> 0  THEN "Y" ELSE "N" 
                   wdetail.class72  = IF      trim(wdetail.class70) = "E11" THEN "110E" 
                                      ELSE IF TRIM(wdetail.class70) = "E12" THEN "210E"
                                      ELSE IF TRIM(wdetail.class70) = "120" THEN "210" 
                                      ELSE "110" . 
          END.
          /* ดีลเลอร์โค้ด , สาขา */
          IF wdetail.memo2 <> "" THEN DO:
              FIND LAST stat.insure WHERE stat.insure.compno = fi_brpara AND
                                          stat.Insure.Addr3  = TRIM(wdetail.memo2)  NO-LOCK NO-ERROR NO-WAIT .
                  IF AVAIL stat.insure THEN DO:
                      ASSIGN wdetail.n_branch    = stat.insure.branch     
                             wdetail.n_delercode = stat.insure.insno.  
                  END.
                  ELSE DO:
                      ASSIGN wdetail.n_branch    =  ""
                             wdetail.n_delercode =  "" .
                  END.
          END.
          ELSE DO:
               ASSIGN wdetail.n_branch    =  ""
                      wdetail.n_delercode =  "" .
          END.
          /* ทะเบียนรถ */
          IF TRIM(wdetail.vehreg) <> "" AND INDEX(wdetail.vehreg," ") <> 0 THEN DO:
              ASSIGN wdetail.re_country   = TRIM(SUBSTR(wdetail.vehreg,R-INDEX(wdetail.vehreg," ")))  
                     wdetail.vehreg       = TRIM(SUBSTR(wdetail.vehreg,1,R-INDEX(wdetail.vehreg," "))) .
          END.

          /* Driver name */
          ASSIGN n_dname = ""  n_title = ""   n_name = ""  n_lname = "" .
          IF wdetail.drivername1 <> "" THEN DO:
             ASSIGN n_dname  = TRIM(wdetail.drivername1)
                    n_lname  = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                    n_dname  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_lname))
                    n_name   = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                    n_title  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_name)) 
                    wdetail.ntitle1      = trim(n_title)
                    wdetail.drivername1  = trim(n_name) 
                    wdetail.dname2       = trim(n_lname) 
                    n_drivno             = n_drivno + 1    .
             ASSIGN  n_dname = ""  n_title = ""   n_name = ""  n_lname = "" .
          END.

          IF wdetail.drivername2 <> "" THEN DO:
              ASSIGN n_dname  = TRIM(wdetail.drivername2)
                     n_lname  = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_dname  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_lname))
                     n_name   = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_title  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_name))
                     wdetail.ntitle2     = trim(n_title)   
                     wdetail.drivername2 = trim(n_name)    
                     wdetail.ddname1     = trim(n_lname)
                     n_drivno            = n_drivno + 1    . 
              ASSIGN n_dname = ""  n_title = ""   n_name = ""  n_lname = "" .
          END.

          IF wdetail.dname3 <> "" THEN DO:
              ASSIGN n_dname  = TRIM(wdetail.dname3)
                     n_lname  = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_dname  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_lname))
                     n_name   = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_title  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_name))
                     wdetail.ntitle3  = trim(n_title)  
                     wdetail.dname3   = trim(n_name)   
                     wdetail.dlname3  = trim(n_lname) 
                     n_drivno         = n_drivno + 1    .
              ASSIGN n_dname = ""  n_title = ""   n_name = ""  n_lname = "" .
          END.

          IF wdetail.dname4 <> "" THEN DO:
              ASSIGN n_dname  = TRIM(wdetail.dname4)
                     n_lname  = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_dname  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_lname))
                     n_name   = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_title  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_name))
                     wdetail.ntitle4 = trim(n_title)    
                     wdetail.dname4  = trim(n_name)     
                     wdetail.dlname4 = trim(n_lname) 
                     n_drivno        = n_drivno + 1    .
              ASSIGN n_dname = ""  n_title = ""   n_name = ""  n_lname = "" .
          END.

          IF wdetail.dname5 <> "" THEN DO:
              ASSIGN n_dname  = TRIM(wdetail.dname5)
                     n_lname  = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_dname  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_lname))
                     n_name   = if index(n_dname," ") <> 0 then substr(n_dname,R-INDEX(n_dname," ")) ELSE ""
                     n_title  = SUBSTR(n_dname,1,LENGTH(n_dname) - LENGTH(n_name))
                     wdetail.ntitle5 = trim(n_title)    
                     wdetail.dname5  = trim(n_name)     
                     wdetail.dlname5 = trim(n_lname) 
                     n_drivno        = n_drivno + 1    .
              ASSIGN n_dname = ""  n_title = ""   n_name = ""  n_lname = "" . 
          END.
          
          /* Text ,Memo */
          ASSIGN 
            wdetail.drivnam  = string(n_drivno) 
            wdetail.memo1 = IF TRIM(wdetail.memo1) <> "" THEN "Contract Date: " + trim(wdetail.memo1) ELSE ""               
            wdetail.memo2 = IF TRIM(wdetail.memo2) <> "" THEN "Dealer Code: "   + TRIM(wdetail.memo2) ELSE ""  
            wdetail.memo3 = IF TRIM(wdetail.memo3) <> "" THEN "Showroom Name: " + TRIM(wdetail.memo3) ELSE ""    
            wdetail.txt1  = IF TRIM(wdetail.txt1 ) <> "" THEN "Motor Type: "    + TRIM(wdetail.txt1)  ELSE ""
            wdetail.txt2  = IF TRIM(wdetail.txt2 ) <> "" THEN "Motor Power: "   + TRIM(wdetail.txt2)  ELSE "" 
            wdetail.txt3  = IF TRIM(wdetail.txt3 ) <> "" THEN "Motor Torque: "  + TRIM(wdetail.txt3)  ELSE ""  
            wdetail.txt4  = IF TRIM(wdetail.txt4 ) <> "" THEN "Electrical Motor Serial No:" + TRIM(wdetail.txt4) ELSE "" 
            wdetail.txt5  = IF TRIM(wdetail.txt5 ) <> "" THEN "Battery Type: "  + TRIM(wdetail.txt5) ELSE ""  
            wdetail.txt6  = IF TRIM(wdetail.txt6 ) <> "" THEN "Battery Capacity: "  + TRIM(wdetail.txt6) ELSE "" 
            wdetail.txt7  = IF TRIM(wdetail.txt7 ) <> "" THEN "Battery Serial No: " + TRIM(wdetail.txt7) ELSE "" 
            wdetail.memo4 = IF TRIM(wdetail.memo4) <> "" THEN "ชื่อการออกใบเสร็จ-ใบกำกับ: " + TRIM(wdetail.memo4) ELSE ""  
            wdetail.memo5 = IF TRIM(wdetail.memo5) <> "" THEN "ข้อมูลเพิ่มเติมอื่นๆ: " + TRIM(wdetail.memo5) ELSE ""   
            wdetail.memo6 = IF TRIM(wdetail.memo6) <> "" THEN "Memo1: " + TRIM(wdetail.memo6) else ""
            wdetail.memo7 = IF TRIM(wdetail.memo7) <> "" THEN "Memo2: " + TRIM(wdetail.memo7) else ""
            wdetail.memo8 = IF TRIM(wdetail.memo8) <> "" THEN "Memo3: " + TRIM(wdetail.memo8) else ""
            wdetail.memo9 = IF TRIM(wdetail.memo9) <> "" THEN "Memo4: " + TRIM(wdetail.memo9) else ""
            wdetail.txt8  = IF TRIM(wdetail.txt8 ) <> "" THEN "Text1: " + TRIM(wdetail.txt8 ) else ""
            wdetail.txt9  = IF TRIM(wdetail.txt9 ) <> "" THEN "Text2: " + TRIM(wdetail.txt9 ) else ""
            wdetail.txt10 = IF TRIM(wdetail.txt10) <> "" THEN "Text3: " + TRIM(wdetail.txt10) else "" .
         
          IF wdetail.colorcar <> ""  THEN RUN proc_carcolors .
        END. /* end else do: */
    END. /* end for wdetail*/
    RUN proc_report.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_carcolors c-Win 
PROCEDURE proc_carcolors :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_colorcode AS CHAR INIT "".
np_colorcode = "".
IF wdetail.colorcar <> "" THEN DO:
        FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
            sym100.tabcod = "U118"  AND 
            sym100.itmcod = trim(wdetail.colorcar)  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
        ELSE DO:
            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                sym100.tabcod = "U118"  AND 
                sym100.itmdes = trim(wdetail.colorcar) 
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
            ELSE DO:
                FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                    sym100.tabcod = "U118"  AND 
                    index(sym100.itmdes,trim(wdetail.colorcar)) <> 0  
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                ELSE DO:
                    FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
                        sym100.tabcod = "U119"  AND 
                        sym100.itmcod = trim(wdetail.colorcar)  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                    ELSE DO:
                        FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                            sym100.tabcod = "U119"  AND 
                            sym100.itmdes = trim(wdetail.colorcar)  
                            NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                        ELSE DO:
                            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                                sym100.tabcod = "U119"  AND 
                                index(sym100.itmdes,trim(wdetail.colorcar)) <> 0  
                                NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                        END.
                    END.
                END.
            END.
        END.
END.
wdetail.colorcar = IF trim(np_colorcode) <> "" THEN np_colorcode ELSE wdetail.colorcar.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report c-Win 
PROCEDURE proc_report :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    OUTPUT STREAM ns1 TO value(fi_output1).
    PUT STREAM ns1
        "Risk No. "       "|"
        "Item No. "       "|"
        "Policy No (เลขที่กรมธรรม์ภาคสมัครใจ)"   "|"
        "Branch (สาขา) "                "|" 
        "Agent Code (รหัสตัวแทน)    "   "|" 
        "Producer Code "                "|" 
        "Dealer Code (รหัสดีเลอร์)  "   "|" 
        "Finance Code (รหัสไฟแนนซ์) "   "|" 
        "Notification Number (เลขที่รับแจ้ง) "   "|"
        "Notification Name (ชื่อผู้แจ้ง)     "   "|"
        "Short Rate    "                "|"
        "Effective Date(วันที่เริ่มความคุ้มครอง)"  "|"
        "Expiry Date (วันที่สิ้นสุดความคุ้มครอง) " "|"
        "Agree Date    "               "|"         
        "First Date    "               "|"
        "Package Code  "               "|"
        "Campaign Code (รหัสแคมเปญ) "  "|"
        "Campaign Text "               "|"
        "Spec Con      "               "|"
        "Product Type  "               "|"
        "Promotion Code"               "|"
        "Renew Count   "               "|"
        "Previous Policy (เลขทีกรมธรรม์ภาคสมัครใจเดิม)"   "|"
        "Policy Text 1 "        "|" 
        "Policy Text 2 "        "|" 
        "Policy Text 3 "        "|" 
        "Policy Text 4 "        "|" 
        "Policy Text 5 "        "|" 
        "Policy Text 6 "        "|" 
        "Policy Text 7 "        "|" 
        "Policy Text 8 "        "|" 
        "Policy Text 9 "        "|" 
        "Policy Text 10"        "|" 
        "Memo Text 1   "        "|" 
        "Memo Text 2   "        "|" 
        "Memo Text 3   "        "|" 
        "Memo Text 4   "        "|" 
        "Memo Text 5   "        "|" 
        "Memo Text 6   "        "|" 
        "Memo Text 7   "        "|" 
        "Memo Text 8   "        "|" 
        "Memo Text 9   "        "|" 
        "Memo Text 10  "        "|" 
        "Accessory Text 1 "     "|" 
        "Accessory Text 2 "     "|" 
        "Accessory Text 3 "     "|" 
        "Accessory Text 4 "     "|" 
        "Accessory Text 5 "     "|" 
        "Accessory Text 6 "     "|" 
        "Accessory Text 7 "     "|" 
        "Accessory Text 8 "     "|" 
        "Accessory Text 9 "     "|" 
        "Accessory Text 10"     "|" 
        "กรมธรรม์ซื้อควบ (Y/N)" "|" 
        "Insured Code         " "|" 
        "ประเภทบุคคล          " "|" 
        "ภาษาที่ใช้สร้าง Cilent Code"  "|"
        "คำนำหน้า"                     "|"
        "ชื่อ    "                     "|"
        "นามสกุล "                     "|"
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "   "|"
        "ลำดับที่สาขา        "       "|"
        "อาชีพ               "       "|"
        "ที่อยู่บรรทัดที่ 1  "       "|"
        "ที่อยู่บรรทัดที่ 2  "       "|"
        "ที่อยู่บรรทัดที่ 3  "       "|"
        "ที่อยู่บรรทัดที่ 4  "       "|"
        "รหัสไปรษณีย์        "       "|"
        "province code       "       "|"
        "district code       "       "|"
        "sub district code   "       "|"
        "AE Code             "       "|"
        "Japanese Team       "       "|"
        "TS Code             "       "|" 
        "Gender (Male/Female/Other)  "  "|" 
        "Telephone 1   "       "|"      
        "Telephone 2   "       "|"      
        "E-Mail 1      "       "|"      
        "E-Mail 2      "       "|"      
        "E-Mail 3      "       "|"      
        "E-Mail 4      "       "|"      
        "E-Mail 5      "       "|"      
        "E-Mail 6      "       "|"      
        "E-Mail 7      "       "|"      
        "E-Mail 8      "       "|"      
        "E-Mail 9      "       "|"      
        "E-Mail 10     "       "|"      
        "Fax           "       "|"      
        "Line ID       "       "|"      
        "CareOf1       "       "|"      
        "CareOf2       "       "|"      
        "Benefit Name  "       "|"      
        "Payer Code    "       "|"      
        "VAT Code      "       "|"      
        "Client Code   "       "|"      
        "ประเภทบุคคล   "       "|"      
        "คำนำหน้า      "       "|"      
        "ชื่อ          "       "|"      
        "นามสกุล       "       "|"              
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "  "|" 
        "ลำดับที่สาขา       "        "|"        
        "ที่อยู่บรรทัดที่ 1 "        "|"
        "ที่อยู่บรรทัดที่ 2 "        "|"
        "ที่อยู่บรรทัดที่ 3 "        "|"
        "ที่อยู่บรรทัดที่ 4 "        "|"
        "รหัสไปรษณีย์       "        "|"
        "province code      "        "|"
        "district code      "        "|"
        "sub district code  "        "|"
        "เบี้ยก่อนภาษีอากร  "        "|"
        "อากร               "        "|"
        "ภาษี               "        "|"
        "คอมมิชชั่น 1       "        "|"
        "คอมมิชชั่น 2 (co-broker)"   "|"
        "Client Code        "        "|"
        "ประเภทบุคคล        "        "|"
        "คำนำหน้า           "        "|"
        "ชื่อ               "        "|"
        "นามสกุล            "        "|"
        "เลขที่บัตรประชาชน / เลขที่นิติบุคคล "  "|"
        "ลำดับที่สาขา       "        "|"
        "ที่อยู่บรรทัดที่ 1 "        "|"
        "ที่อยู่บรรทัดที่ 2 "        "|"
        "ที่อยู่บรรทัดที่ 3 "        "|"
        "ที่อยู่บรรทัดที่ 4 "        "|"
        "รหัสไปรษณีย์       "        "|"
        "province code      "        "|"
        "district code      "        "|"
        "sub district code  "        "|"
        "เบี้ยก่อนภาษีอากร  "        "|"
        "อากร               "        "|"
        "ภาษี               "        "|"
        "คอมมิชชั่น 1       "        "|"
        "คอมมิชชั่น 2 (co-broker)  " "|"
        "Client Code        "        "|"
        "ประเภทบุคคล        "        "|"
        "คำนำหน้า           "        "|" 
        "ชื่อ               "        "|" 
        "นามสกุล            "        "|" 
        "เลขที่บัตรประชาชน/เลขที่นิติบุคคล   "  "|" 
        "ลำดับที่สาขา      "      "|"           
        "ที่อยู่บรรทัดที่ 1"      "|"           
        "ที่อยู่บรรทัดที่ 2"      "|"           
        "ที่อยู่บรรทัดที่ 3"      "|"           
        "ที่อยู่บรรทัดที่ 4"      "|"           
        "รหัสไปรษณีย์      "      "|"           
        "province code     "      "|"           
        "district code     "      "|"           
        "sub district code "      "|"           
        "เบี้ยก่อนภาษีอากร "      "|"           
        "อากร              "      "|"           
        "ภาษี              "      "|"           
        "คอมมิชชั่น 1      "      "|"           
        "คอมมิชชั่น 2 (co-broker)  "            "|" 
        "Cover Type (ประเภทความคุ้มครอง)     "  "|" 
        "Garage (ประเภทการซ่อม ซ่อมอู่/ซ่อมห้าง)"  "|"
        "Spacial Equipment Flag (A/Blank)  "       "|"
        "Inspection       "               "|"
        "รหัสรถภาคสมัครใจ (110/120/320)"  "|"
        "ลักษณะการใช้รถ        "   "|"
        "Redbook               "   "|"
        "ยี่ห้อรถ              "   "|"
        "ชื่อรุ่นรถ            "   "|"
        "ชื่อรุ่นย่อยรถ        "   "|"
        "ปีรุ่นรถ              "   "|"
        "หมายเลขตัวถัง         "   "|"
        "หมายเลขเครื่อง        "   "|"
        "หมายเลขเครื่อง2       "   "|"
        "จำนวนที่นั่ง (รวมผู้ขับขี่)   "  "|"
        "ปริมาตรกระบอกสูบ (CC) "   "|"
        "น้ำหนัก               "   "|"
        "Kilowatt              "   "|"
        "รหัสแบบตัวถัง         "   "|"
        "ป้ายแดง (Y/N)         "   "|"
        "ปีที่จดทะเบียน        "   "|"
        "เลขทะเบียนรถ          "   "|"
        "จังหวัดที่จดทะเบียน   "   "|"
        "Group Car (กลุ่มรถ)    "  "|"
        "Color (สี)             "  "|"
        "Fule (เชื้อเพลิง)      "  "|"
        "Driver Number          "  "|"
        "คำนำหน้า               "  "|"
        "ชื่อ                   "  "|"
        "นามสกุล                "  "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ                    "  "|"
        "วันเกิด                "  "|"
        "ชื่ออาชีพ              "  "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า   "              "|"
        "ชื่อ       "              "|"
        "นามสกุล    "              "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ        "              "|"
        "วันเกิด    "              "|"
        "ชื่ออาชีพ  "              "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า   "              "|"
        "ชื่อ       "              "|"
        "นามสกุล    "              "|"
        "เลขที่บัตรประชาชน      "  "|"
        "เพศ        "              "|"
        "วันเกิด    "              "|"
        "ชื่ออาชีพ  "              "|"
        "เลขที่ใบอนุญาตขับขี่   "  "|"
        "วันที่ใบอนุญาต หมดอายุ "  "|"
        "consent ผู้ขับขี่      "  "|"
        "ระดับพฤติกรรมการขับขี่ "  "|"
        "คำนำหน้า  "         "|"
        "ชื่อ      "         "|"
        "นามสกุล   "         "|"
        "เลขที่บัตรประชาชน " "|"
        "เพศ       "         "|"
        "วันเกิด   "         "|"
        "ชื่ออาชีพ "         "|"
        "เลขที่ใบอนุญาตขับขี่   " "|"
        "วันที่ใบอนุญาต หมดอายุ " "|"
        "consent ผู้ขับขี่      " "|"
        "ระดับพฤติกรรมการขับขี่ " "|"
        "คำนำหน้า   "             "|"
        "ชื่อ       "             "|"
        "นามสกุล    "             "|"
        "เลขที่บัตรประชาชน "      "|"
        "เพศ        "             "|"
        "วันเกิด    "             "|"
        "ชื่ออาชีพ  "             "|"
        "เลขที่ใบอนุญาตขับขี่   " "|"
        "วันที่ใบอนุญาต หมดอายุ " "|"
        "consent ผู้ขับขี่ "      "|"
        "ระดับพฤติกรรมการขับขี่ " "|"
        "Base Premium Plus "   "|"
        "Sum Insured Plus  "   "|"
        "RS10 Amount       "   "|"
        "TPBI / person     "   "|"
        "TPBI / occurrence "   "|"
        "TPPD              "   "|"
        "Deduct / OD       "   "|"
        "Deduct /Add OD    "   "|"
        "Deduct / PD       "   "|"
        "Market Value EV   "   "|"
        "วงเงินทุนประกัน   "   "|"
        "PA1.1 / driver    "   "|"
        "PA1.1 no.of passenger  " "|"
        "PA1.1 / passenger "      "|"
        "PA1.2 / driver    "      "|"
        "PA1.2 no.of passenger  " "|"
        "PA1.2 / passenger"       "|"
        "PA2    "         "|"
        "PA3    "         "|"
        "Base Premium "   "|"
        "Unname "         "|"
        "Name   "         "|"
        "TPBI / person Amount   " "|"
        "TPBI / Accident Amount " "|"
        "TPPD Amount   "         "|"
        "Deduct / OD Amount  "   "|"
        "Add / OD Amount     "   "|"
        "Deduct / PD Amount  "   "|"
        "RY01 Amount     "       "|"
        "RY01 Amount (412)   "   "|"
        "RY01 Amount (413)   "   "|"
        "RY01 Amount (414)   "   "|"
        "RY02 Amount   "         "|"
        "RY03 Amount   "         "|"
        "Fleet%        "         "|"
        "NCB%          "         "|"
        "Load Claim%   "         "|"
        "Other Disc.%  "         "|"
        "CCTV%         "         "|"
        "Walkin Disc.% "         "|"
        "Fleet Amount  "         "|"
        "NCB Amount    "         "|"
        "Load Claim Amount   "   "|"
        "Other Disc. Amount  "   "|"
        "CCTV Amount   "         "|"
        "Walk in Disc. Amount"   "|"
        "เบี้ยสุทธิ    "         "|"
        "Stamp Duty    "         "|"
        "VAT           "         "|"
        "Commission %  "         "|"
        "Commission Amount   "   "|"
        "Agent Code co-broker (รหัสตัวแทน) "  "|"
        "Commission % co-broker      "  "|" 
        "Commission Amount co-broker "  "|" 
        "Package (Attach Coverage)   "  "|" 
        "Dangerous Object 1  "          "|" 
        "Dangerous Object 2  "          "|" 
        "Sum Insured    "               "|" 
        "Rate%          "               "|" 
        "Fleet%         "               "|" 
        "NCB%           "               "|" 
        "Discount%      "               "|" 
        "Walkin Disc.%  "               "|" 
        "Premium Attach Coverage"       "|" 
        "Discount Fleet "               "|" 
        "Discount NCB   "               "|" 
        "Other Discount "               "|" 
        "Walk in Disc. Amount"          "|" 
        "Net Premium    "               "|" 
        "Stamp Duty     "               "|" 
        "VAT            "               "|" 
        "Commission Amount   "          "|" 
        "Commission Amount co-broker "  "|" 
        "Claim Text         "           "|" 
        "Claim Amount       "           "|" 
        "Claim Count Fault  "           "|" 
        "Claim Count Fault Amount"      "|" 
        "Claim Count Good        "      "|" 
        "Claim Count Good Amount "      "|" 
        "Loss Ratio % (Not TP)   "      "|" 
        "Compulsory Policy Number (เลขที่กรมธรรม์ พรบ.) " "|"
        "Effective Date (วันที่เริ่มความคุ้มครอง พรบ.)  " "|"
        "Expiry Date (วันที่สิ้นสุดความคุ้มครอง พรบ.)   " "|"
        "Barcode No.                       "        "|" 
        "Compulsory Class (รหัส พรบ.)      "        "|" 
        "Compulsory Walk In Discount %     "        "|" 
        "Compulsory Walk In Discount Amount"        "|" 
        "เบี้ยสุทธิ พ.ร.บ. กรณี กรมธรรม์ซื้อควบ  "  "|" 
        "Stamp Duty   "          "|"
        "VAT          "          "|"
        "Commission % "          "|"
        "Commission Amount  "    "|"
        "เลขที่แบตเตอรี่    "    "|"
        "ปีแบตฯ       "          "|"
        "ราคาแบตฯ     "          "|"
        "ทุนประกันแบตฯ"          "|"
        "Rate         "          "|"
        "Premium      "          "|"
        "เลขที่เครื่องชาร์จ "    "|"
        "ราคาเครื่องชาร์จ   "    "|"
        "Rate         "          "|"
        "Premium      "          SKIP .
      RUN proc_report_2.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report_2 c-Win 
PROCEDURE proc_report_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wdetail NO-LOCK .
   PUT STREAM ns1                    
        wdetail.riskno         "|"    /*A64-0355*/
        wdetail.itemno         "|"
        wdetail.policyno       FORMAT "x(12)"  "|"
        wdetail.n_branch       "|"
        wdetail.agent          "|"
        wdetail.producer       "|"
        wdetail.n_delercode    "|"
        wdetail.fincode        "|"
        wdetail.appenno        "|"
        wdetail.salename       "|"
        wdetail.srate          "|"
        wdetail.comdat         "|"
        wdetail.expdat         "|"
        wdetail.agreedat       "|"
        wdetail.firstdat       "|"
        wdetail.packcod        "|"
        wdetail.camp_no        "|"
        wdetail.campen         "|"
        wdetail.specon         "|"
        wdetail.product        "|"
        wdetail.promo          "|"
        wdetail.rencnt         "|"
        wdetail.prepol         "|"
        wdetail.txt1       FORMAT  "x(100)"   "|"
        wdetail.txt2       FORMAT  "x(100)"   "|"
        wdetail.txt3       FORMAT  "x(100)"   "|"
        wdetail.txt4       FORMAT  "x(100)"   "|"
        wdetail.txt5       FORMAT  "x(100)"   "|"
        wdetail.txt6       FORMAT  "x(100)"   "|"
        wdetail.txt7       FORMAT  "x(100)"   "|"
        wdetail.txt8       FORMAT  "x(100)"   "|"
        wdetail.txt9       FORMAT  "x(100)"   "|"
        wdetail.txt10      FORMAT  "x(100)"   "|"
        wdetail.memo1      FORMAT  "x(100)"   "|"
        wdetail.memo2      FORMAT  "x(100)"   "|"
        wdetail.memo3      FORMAT  "x(100)"   "|"
        wdetail.memo4      FORMAT  "x(100)"   "|"
        wdetail.memo5      FORMAT  "x(100)"   "|"
        wdetail.memo6      FORMAT  "x(100)"   "|"
        wdetail.memo7      FORMAT  "x(100)"   "|"
        wdetail.memo8      FORMAT  "x(100)"   "|"
        wdetail.memo9      FORMAT  "x(100)"   "|"
        wdetail.memo10     FORMAT  "x(100)"   "|"
        wdetail.accdata1   FORMAT  "x(100)"   "|"
        wdetail.accdata2   FORMAT  "x(100)"   "|"
        wdetail.accdata3   FORMAT  "x(100)"   "|"
        wdetail.accdata4   FORMAT  "x(100)"   "|"
        wdetail.accdata5   FORMAT  "x(100)"   "|"
        wdetail.accdata6   FORMAT  "x(100)"   "|"
        wdetail.accdata7   FORMAT  "x(100)"   "|"
        wdetail.accdata8   FORMAT  "x(100)"   "|"
        wdetail.accdata9   FORMAT  "x(100)"   "|"
        wdetail.accdata10  FORMAT  "x(100)"   "|"
        wdetail.compul     "|"
        wdetail.insref     "|" /* A64-0355*/
        wdetail.instyp     "|"
        wdetail.inslang    "|"
        wdetail.tiname     "|"
        wdetail.insnam    format "x(100)"   "|"
        wdetail.lastname  format "x(100)"   "|"
        wdetail.icno         "|"
        wdetail.insbr        "|"
        wdetail.occup        "|"
        wdetail.addr      format "x(60)"   "|"
        wdetail.tambon    format "x(60)"   "|"
        wdetail.amper     format "x(60)"   "|"
        wdetail.country   format "x(60)"   "|"
        wdetail.post         "|"
        wdetail.provcod      "|"
        wdetail.distcod      "|"
        wdetail.sdistcod     "|"
        wdetail.jpae         "|"  /*A64-0355*/      
        wdetail.jpjtl        "|"  /*A64-0355*/      
        wdetail.jpts         "|"  /*A64-0355*/      
        wdetail.gender       "|"
        wdetail.tele1        "|"
        wdetail.tele2        "|"
        wdetail.mail1    format "x(50)"    "|"
        wdetail.mail2    format "x(50)"    "|"
        wdetail.mail3    format "x(50)"    "|"
        wdetail.mail4    format "x(50)"    "|"
        wdetail.mail5    format "x(50)"    "|"
        wdetail.mail6    format "x(50)"    "|"
        wdetail.mail7    format "x(50)"    "|"
        wdetail.mail8    format "x(50)"    "|"
        wdetail.mail9    format "x(50)"    "|"
        wdetail.mail10   format "x(50)"    "|"
        wdetail.fax       "|"
        wdetail.lineID   FORMAT "x(50)"    "|"
        wdetail.name2    format "x(70)"   "|"
        wdetail.name3    format "x(70)"   "|"
        wdetail.benname  format "x(70)"   "|"
        wdetail.payercod     "|"
        wdetail.vatcode      "|"
        wdetail.instcod1     "|"
        wdetail.insttyp1     "|"
        wdetail.insttitle1   "|"
        wdetail.instname1   format "X(50)"  "|"
        wdetail.instlname1  format "X(50)"  "|"
        wdetail.instic1      "|"
        wdetail.instbr1      "|"
        wdetail.instaddr11 format "X(50)"   "|"
        wdetail.instaddr21 format "X(50)"   "|"
        wdetail.instaddr31 format "X(50)"  "|"
        wdetail.instaddr41 format "X(50)"   "|"
        wdetail.instpost1     "|"
        wdetail.instprovcod1  "|"
        wdetail.instdistcod1  "|"
        wdetail.instsdistcod1 "|"
        wdetail.instprm1      "|"
        wdetail.instrstp1     "|"
        wdetail.instrtax1     "|"
        wdetail.instcomm01    "|"
        wdetail.instcomm12    "|"
        wdetail.instcod2      "|"
        wdetail.insttyp2      "|"
        wdetail.insttitle2    "|"
        wdetail.instname2     format "X(50)"   "|"
        wdetail.instlname2    format "X(50)"   "|"
        wdetail.instic2       "|"
        wdetail.instbr2       "|"
        wdetail.instaddr12  format "X(50)"   "|"
        wdetail.instaddr22  format "X(50)"   "|"
        wdetail.instaddr32  format "X(50)"   "|"
        wdetail.instaddr42  format "X(50)"   "|"
        wdetail.instpost2     "|"
        wdetail.instprovcod2  "|"
        wdetail.instdistcod2  "|"
        wdetail.instsdistcod2 "|"
        wdetail.instprm2      "|"
        wdetail.instrstp2     "|"
        wdetail.instrtax2     "|"
        wdetail.instcomm02    "|"
        wdetail.instcomm22    "|"
        wdetail.instcod3      "|"
        wdetail.insttyp3      "|"
        wdetail.insttitle3    "|"
        wdetail.instname3     format "X(50)"   "|"
        wdetail.instlname3    format "X(50)"   "|"
        wdetail.instic3       "|"
        wdetail.instbr3       "|"
        wdetail.instaddr13    format "X(50)"   "|"
        wdetail.instaddr23    format "X(50)"   "|"
        wdetail.instaddr33    format "X(50)"   "|"
        wdetail.instaddr43    format "X(50)"   "|"
        wdetail.instpost3     "|"
        wdetail.instprovcod3  "|"
        wdetail.instdistcod3  "|"
        wdetail.instsdistcod3 "|"
        wdetail.instprm3     "|"
        wdetail.instrstp3    "|"
        wdetail.instrtax3    "|"
        wdetail.instcomm03   "|"
        wdetail.instcomm23   "|"
        wdetail.covcod       "|"
        wdetail.garage       "|"
        wdetail.special      "|"
        wdetail.inspec       "|"
        wdetail.class70      "|"
        wdetail.vehuse       "|"  /*A64-0355*/
        wdetail.redbook      "|"  /*A65-0079*/
        wdetail.brand     format "X(50)"     "|"
        wdetail.model     format "X(50)"     "|"
        wdetail.submodel  format "X(50)"     "|"
        wdetail.yrmanu      "|"
        wdetail.chasno      "|"
        wdetail.eng         "|"
        wdetail.eng_no2     "|" /*A67-0029*/
        wdetail.seat        "|"
        wdetail.engcc       "|"
        wdetail.weight      "|"
        wdetail.watt        "|"
        wdetail.body        "|"
        wdetail.type        "|"
        wdetail.re_year      "|"
        wdetail.vehreg       "|"
        wdetail.re_country   "|"
        wdetail.cargrp       "|"
        wdetail.colorcar     "|"
        wdetail.fule         "|"
        wdetail.drivnam      "|"
        wdetail.ntitle1      "|"
        wdetail.drivername1 format "X(50)"  "|"
        wdetail.dname2      format "X(50)"  "|"
        wdetail.dicno       "|" 
        wdetail.dgender1    "|" 
        wdetail.dbirth      "|" 
        wdetail.doccup      format "X(50)"  "|"
        wdetail.ddriveno    "|" 
        wdetail.drivexp1    "|" 
        wdetail.dconsen1    "|" 
        wdetail.dlevel1     "|" 
        wdetail.ntitle2     "|" 
        wdetail.drivername2 format "X(50)"  "|"
        wdetail.ddname1     format "X(50)"  "|"
        wdetail.ddicno       "|"
        wdetail.dgender2     "|"
        wdetail.ddbirth      "|"
        wdetail.ddoccup     format "X(50)"  "|"
        wdetail.dddriveno    "|"
        wdetail.drivexp2     "|"
        wdetail.dconsen2     "|"
        wdetail.dlevel2      "|"
        wdetail.ntitle3      "|"
        wdetail.dname3     format "X(50)"   "|"
        wdetail.dlname3    format "X(50)"   "|"
        wdetail.dicno3       "|"
        wdetail.dgender3     "|"
        wdetail.dbirth3      "|"
        wdetail.doccup3    format "X(50)"   "|"
        wdetail.ddriveno3    "|"
        wdetail.drivexp3     "|"
        wdetail.dconsen3     "|"
        wdetail.dlevel3      "|"
        wdetail.ntitle4      "|"
        wdetail.dname4     format "X(50)"   "|"
        wdetail.dlname4    format "X(50)"   "|"
        wdetail.dicno4       "|"
        wdetail.dgender4     "|"
        wdetail.dbirth4      "|"
        wdetail.doccup4    format "X(50)"   "|"
        wdetail.ddriveno4    "|"
        wdetail.drivexp4     "|"
        wdetail.dconsen4     "|"
        wdetail.dlevel4      "|"
        wdetail.ntitle5      "|"
        wdetail.dname5     format "X(50)"   "|"
        wdetail.dlname5    format "X(50)"   "|"
        wdetail.dicno5       "|"
        wdetail.dgender5     "|"
        wdetail.dbirth5      "|"
        wdetail.doccup5    format "X(50)"   "|"
        wdetail.ddriveno5    "|"
        wdetail.drivexp5     "|"
        wdetail.dconsen5     "|"
        wdetail.dlevel5      "|"
        wdetail.baseplus     "|"
        wdetail.siplus       "|"
        wdetail.rs10         "|"
        wdetail.comper       "|"
        wdetail.comacc       "|"
        wdetail.deductpd     "|"
        wdetail.DOD          "|"
        wdetail.DOD1         "|"
        wdetail.DPD          "|" 
        wdetail.maksi        "|"
        wdetail.tpfire       "|"
        wdetail.NO_41        "|"
        wdetail.ac2          "|"
        wdetail.ac4          "|"
        wdetail.ac5          "|"
        wdetail.ac6          "|"
        wdetail.ac7          "|"
        wdetail.NO_42        "|"
        wdetail.NO_43        "|"
        wdetail.base         "|"
        wdetail.unname       "|"
        wdetail.nname        "|"
        wdetail.tpbi         "|"
        wdetail.bi2          "|"
        wdetail.tppd         "|"
        wdetail.dodamt       "|"
        wdetail.dod1amt      "|"
        wdetail.dpdamt       "|"
        wdetail.ry01         "|"
        wdetail.ry412        "|"
        wdetail.ry413        "|"
        wdetail.ry414        "|"
        wdetail.ry02         "|"
        wdetail.ry03         "|"
        wdetail.fleet        "|"
        wdetail.ncb          "|"
        wdetail.claim        "|"
        wdetail.dspc         "|"
        wdetail.cctv         "|"
        wdetail.dstf         "|"
        wdetail.fleetprem    "|"   
        wdetail.ncbprem      "|"   
        wdetail.clprem       "|"
        wdetail.dspcprem     "|"
        wdetail.cctvprem     "|"
        wdetail.dstfprem     "|"
        wdetail.premt        "|"
        wdetail.rstp_t       "|"
        wdetail.rtax_t       "|"
        wdetail.comper70     "|"
        wdetail.comprem70    "|"
        wdetail.agco70       "|"
        wdetail.comco_per70  "|"
        wdetail.comco_prem70 "|"
        wdetail.dgpackge     "|"
        wdetail.danger1      "|"
        wdetail.danger2      "|"
        wdetail.dgsi         "|"
        wdetail.dgrate       "|"
        wdetail.dgfeet       "|"
        wdetail.dgncb        "|"
        wdetail.dgdisc       "|"
        wdetail.dgwdisc      "|"
        wdetail.dgatt        "|"
        wdetail.dgfeetprm    "|"
        wdetail.dgncbprm     "|"
        wdetail.dgdiscprm    "|"
        wdetail.dgWdiscprm   "|"
        wdetail.dgprem       "|"
        wdetail.dgrstp_t     "|"
        wdetail.dgrtax_t     "|"
        wdetail.dgcomper     "|"
        wdetail.dgcomprem    "|"
        wdetail.cltxt        "|"
        wdetail.clamount     "|" 
        wdetail.faultno      "|"
        wdetail.faultprm     "|" 
        wdetail.goodno       "|"
        wdetail.goodprm      "|"
        wdetail.loss         "|"
        wdetail.compolusory  "|"
        wdetail.comdat72     "|"
        wdetail.expdat72     "|"
        wdetail.barcode      "|"
        wdetail.class72      "|"
        wdetail.dstf72       "|"
        wdetail.dstfprem72   "|"
        wdetail.premt72      "|"
        wdetail.rstp_t72     "|"
        wdetail.rtax_t72     "|"
        wdetail.comper72     "|"
        wdetail.comprem72    "|"
        wdetail.battno       "|"
        wdetail.battyr       "|"
        wdetail.battprice    "|"
        wdetail.battsi       "|" 
        wdetail.battrate     "|" 
        wdetail.battprm      "|" 
        wdetail.chargno      "|" 
        wdetail.chargsi      "|" 
        wdetail.chargrate    "|" 
        wdetail.chargprm     SKIP.
    END.            
    OUTPUT STREAM ns1 CLOSE.
                    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

