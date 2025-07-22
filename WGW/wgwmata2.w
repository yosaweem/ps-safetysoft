&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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

  Created: 
  
  /*Program name     : Match Text file Aycal Compulsory to excel file             */  
/*create by        : Kridtiya il. A57-0005 08/01/2014                           */ 
/*DataBase connect : GW_SAFE -LD SIC_BRAN, GW_STAT -LD BRSTAT,SICSYAC,SICUW stat*/ 

 Modify By : Porntiwa P.  A59-0069  10/03/2016
           : ปรับ Format การนำเข้าเพิ่ม Producer Code ; Agent Code ; Model Code
           
Modify       : Jiraporn P. [A59-0342]   date 13/07/2016
             : แก้ไขการนำเข้า พรบ. ดึงข้อมูลลุกค้าจาก File พรบ.และโหลดเข้าระบบได้อย่างถูกต้องและครบถ้วน
Modify       : Jiraphon P. [A59-0451]   date 03/09/2016
             : แก้ไขการนำเข้า พรบ. ดึงข้อมูลลุกค้าจาก File พรบ. เพิ่มคอลัมภ์ที่อยู่   */          
/* Modify by : Ranu I. A60-0542 date 18/12/2017 เพิ่มช่อง Campaign CJ       */
/*------------------------------------------------------------------------*/
/*          This .W file was created with the Progress UIB.             */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.
/* ***************************  Definitions  **************************         */
/* Parameters Definitions ---                                                   */  
/*Local Variable Definitions ---                                                */   

DEF  stream  ns1.
DEFINE VAR   nv_daily        AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_reccnt       AS  INT  INIT  0.
DEFINE VAR   nv_completecnt  AS   INT   INIT  0.
DEFINE VAR   nv_enttim       AS  CHAR          INIT  "".
def    var   nv_export       as  date  init  ""  format "99/99/9999".
def  stream  ns2.
DEFINE VAR   nv_file1        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
DEFINE VAR   nv_file2        AS CHARACTER FORMAT "X(100)"     INITIAL ""  NO-UNDO.
/*--------------------------สำหรับข้อมูลกรมธรรม์  -------------------------*/
DEFINE  WORKFILE wdetail NO-UNDO
    FIELD branch      AS CHAR FORMAT "X(2)"   INIT ""                                    
    FIELD policy      AS CHAR FORMAT "X(12)"  INIT ""   
    FIELD stk         AS CHAR FORMAT "X(15)"  INIT ""                                       
    FIELD docno       AS CHAR FORMAT "X(10)"  INIT ""                                    
    FIELD remark      AS CHAR FORMAT "X(150)" INIT "" 
    FIELD SEQ               AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD INSURANCECODE     AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD CONTRACTNO        AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD BRANCHCODE        AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD BRANCHNO          AS CHAR FORMAT "X(150)" INIT "" 
    FIELD STICKERNO         AS CHAR FORMAT "X(50)"  INIT "" 
    FIELD CUSTOMERNAME      AS CHAR FORMAT "X(100)" INIT "" 
    FIELD ADDRESS           AS CHAR FORMAT "X(50)" INIT "" 
    /*Add Jiraphon A59-0451*/
    FIELD ADDRESS2           AS CHAR FORMAT "X(50)" INIT "" 
    FIELD ADDRESS3           AS CHAR FORMAT "X(50)" INIT "" 
    FIELD ADDRESS4           AS CHAR FORMAT "X(50)" INIT "" 
    FIELD ADDRESS5           AS CHAR FORMAT "X(50)" INIT "" 
    /*End Jiraphon A59-0451*/
    FIELD CARNO             AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD MODCOD            AS CHAR FORMAT "X(10)"  INIT ""   /*A59-0069*/
    FIELD BRAND             AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD MODEL             AS CHAR FORMAT "X(60)"  INIT "" 
    FIELD CC                AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD REGISTRATION      AS CHAR FORMAT "X(11)"  INIT "" 
    FIELD PROVINCE          AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD BODY              AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD ENGINE            AS CHAR FORMAT "X(30)"  INIT "" 
    FIELD STARTDATE         AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD ENDDATE           AS CHAR FORMAT "X(10)"  INIT "" 
    FIELD NETINCOME         AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD TOTALINCOME       AS CHAR FORMAT "X(20)"  INIT "" 
    FIELD CARDID            AS CHAR FORMAT "X(15)"  INIT ""
    FIELD PRODUCER          AS CHAR FORMAT "X(10)"  INIT ""  /*A59-0069*/
    FIELD AGENT             AS CHAR FORMAT "X(10)"  INIT ""  /*A59-0069*/
    FIELD nstatus           AS CHAR FORMAT "X(15)"  INIT "" 
    FIELD camp_cj           AS CHAR FORMAT "x(50)"  INIT "" . /*A60-0542*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_filename fi_outfile bu_ok bu_exit bu_file ~
fi_process RECT-76 RECT-77 
&Scoped-Define DISPLAYED-OBJECTS fi_filename fi_outfile fi_process 

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
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY 1.05.

DEFINE BUTTON bu_ok 
     LABEL "Ok" 
     SIZE 7.5 BY 1.05
     FONT 6.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outfile AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 70 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1.05
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 89.5 BY 8.57
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-77
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 1.57
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_filename AT ROW 3.52 COL 12.83 COLON-ALIGNED NO-LABEL
     fi_outfile AT ROW 4.81 COL 12.83 COLON-ALIGNED NO-LABEL
     bu_ok AT ROW 6.43 COL 61.83
     bu_exit AT ROW 6.43 COL 71.5
     bu_file AT ROW 3.52 COL 85.33
     fi_process AT ROW 6.43 COL 6 NO-LABEL
     "Input File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 3.52 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "Output File :" VIEW-AS TEXT
          SIZE 12 BY 1.05 AT ROW 4.81 COL 2.5
          BGCOLOR 29 FGCOLOR 2 FONT 6
     "                Match Text File AYCAL COMPULSORY" VIEW-AS TEXT
          SIZE 82 BY 1.67 AT ROW 1.48 COL 2.5
          BGCOLOR 18 FGCOLOR 2 FONT 2
     RECT-76 AT ROW 1 COL 1
     RECT-77 AT ROW 6.19 COL 60.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 90.33 BY 8.76
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
         TITLE              = "Match Text File AYCL COMPULSORY"
         HEIGHT             = 8.71
         WIDTH              = 89.83
         MAX-HEIGHT         = 18.76
         MAX-WIDTH          = 117.67
         VIRTUAL-HEIGHT     = 18.76
         VIRTUAL-WIDTH      = 117.67
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
   FRAME-NAME Custom                                                    */
ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_process IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Match Text File AYCL COMPULSORY */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Match Text File AYCL COMPULSORY */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close" to this-procedure.
  Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
        FILTERS    /*"Text Documents" "*.txt",*/
                    "Text Documents" "*.csv",
                            "Data Files (*.*)"     "*.*"
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fi_filename = cvData.
         fi_outfile  = SUBSTR(cvData,1,LENGTH(cvData) - 4 ) + "_Pol" +
                       STRING(DAY(TODAY),"99")      + 
                       STRING(MONTH(TODAY),"99")    + 
                       STRING(YEAR(TODAY),"9999")   +  ".csv".
         DISP fi_filename fi_outfile WITH FRAME fr_main.     
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok C-Win
ON CHOOSE OF bu_ok IN FRAME fr_main /* Ok */
DO:
    ASSIGN nv_reccnt  =  0.
    FOR EACH  wdetail:
        DELETE  wdetail.
    END.
    INPUT FROM VALUE (fi_filename) .   /*create in TEMP-TABLE wImport*/
    REPEAT:    
        CREATE wdetail.
        IMPORT DELIMITER "|" 
            wdetail.SEQ            /*  1   SEQ             */              
            wdetail.INSURANCECODE  /*  2   INSURANCECODE   */  
            wdetail.CONTRACTNO     /*  3   CONTRACTNO      */      
            wdetail.BRANCHCODE     /*  4   BRANCHCODE      */      
            wdetail.BRANCHNO       /*  5   BRANCHNO        */      
            wdetail.policy
            wdetail.branch
            wdetail.STICKERNO      /*  6   STICKERNO       */      
            wdetail.CUSTOMERNAME   /*  7   CUSTOMERNAME    */      
            wdetail.ADDRESS        /*  8   ADDRESS         */
            /*Add Jirahon A59-0451*/
            wdetail.ADDRESS2        /*   ADDRESS 2        */
            wdetail.ADDRESS3        /*   ADDRESS 3        */
            wdetail.ADDRESS4        /*   ADDRESS 4        */
            wdetail.ADDRESS5        /*   ADDRESS 5        */
            /*END Jirahon A59-0451*/
            wdetail.CARNO          /*  9   CARNO           */    
            wdetail.MODCOD         /*A59-0069*/
            wdetail.BRAND          /*  10  BRAND           */          
            wdetail.MODEL          /*  11  MODEL           */          
            wdetail.CC             /*  12  CC              */              
            wdetail.REGISTRATION   /*  13  REGISTRATION    */  
            wdetail.PROVINCE       /*  14  PROVINCE        */      
            wdetail.BODY           /*  15  BODY            */          
            wdetail.ENGINE         /*  16  ENGINE          */          
            wdetail.STARTDATE      /*  17  STARTDATE       */      
            wdetail.ENDDATE        /*  18  ENDDATE         */          
            wdetail.NETINCOME      /*  19  NETINCOME       */      
            wdetail.TOTALINCOME    /*  20  TOTALINCOME     */      
            wdetail.CARDID         /*  21  CARDID          */  
            wdetail.PRODUCER       /*A59-0069*/
            wdetail.AGENT          /*A59-0069*/
            wdetail.camp_cj        /*A60-0542*/
            wdetail.nstatus
            wdetail.remark.        /* Jiraporn A59-0342*/
    END.    /* repeat  */
    FOR EACH wdetail.
        IF      index(wdetail.SEQ,"Match") <> 0 THEN DELETE wdetail.
        ELSE IF index(wdetail.SEQ,"SEQ")   <> 0 THEN DELETE wdetail.
        ELSE IF       wdetail.SEQ          = "" THEN DELETE wdetail.
    END.
    RUN  Pro_matchfile_prem.
    Run  Pro_createfile.
    Message "Export data Complete"  View-as alert-box.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_filename
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_filename C-Win
ON LEAVE OF fi_filename IN FRAME fr_main
DO:
  fi_filename  =  Input  fi_filename.
  Disp  fi_filename  with frame  fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outfile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outfile C-Win
ON LEAVE OF fi_outfile IN FRAME fr_main
DO:
  fi_outfile  =  Input  fi_outfile.
  Disp  fi_outfile with frame  fr_main.
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
  
   /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  ASSIGN fi_process = "Match file Policy Compulsory and Update Status "
  
      gv_prgid = "WGWMATA2.W".
  gv_prog  = "Match Text File AYCL COMPULSORY".
  DISP fi_process WITH FRAM fr_main.
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  /*ASSIGN ra_report =  1.*/
  /*DISP ra_report WITH FRAM fr_main.*/
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
  DISPLAY fi_filename fi_outfile fi_process 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_filename fi_outfile bu_ok bu_exit bu_file fi_process RECT-76 
         RECT-77 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_createfile C-Win 
PROCEDURE Pro_createfile :
/*------------------------------------------------------------------------------
Purpose:     
Parameters:  <none>
Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
If  substr(fi_outfile,length(fi_outfile) - 3,4) <>  ".slk"  THEN 
    fi_outfile  =  Trim(fi_outfile) + ".slk"  .
ASSIGN 
    n_record =  0
    nv_cnt   =  0
    nv_row   =  1 .
OUTPUT STREAM ns2 TO VALUE(fi_outfile).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"' "Export data by Aycl Compulsory."  '"' SKIP.
nv_row  =  nv_row + 1.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "SEQ"               '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "INSURANCECODE"     '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "CONTRACTNO"        '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "BRANCHCODE"        '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "BRANCHNO "         '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "POLICY_COMP"       '"' SKIP.        
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "Branch"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "STICKERNO"         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "CUSTOMERNAME"      '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "ADDRESS"           '"' SKIP. 
/*Add Jiraphon A59-0451*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "ADDRESS2"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "ADDRESS3"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ADDRESS4"           '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "ADDRESS5"           '"' SKIP.
/*End Jiraphon A59-0451*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "CARNO"             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "BRAND"             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "MODEL"             '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "CC"                '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "REGISTRATION "     '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "PROVINCE"          '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "BODY"              '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "ENGINE"            '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "STARTDATE"         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "ENDDATE"           '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "NETINCOME"         '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "TOTALINCOME"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "CARDID"            '"' SKIP.
/*Add Jiraporn A59-0342*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "PRODUCER CODE"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "AGENT CODE"          '"' SKIP.
/*End Jiraporn A59-0342*/
/*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "STATUS"            '"' SKIP. Comment Jiraporn A59-0342*/
/*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "REMARK"            '"' SKIP.*/ /*Jiraporn A59-0342*//*A60-0542*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "Campaign CJ"       '"' SKIP. /*A60-0542*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "REMARK"            '"' SKIP. /*A60-0542*/

FOR EACH wdetail  NO-LOCK  .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'   wdetail.SEQ            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'   wdetail.INSURANCECODE  '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'   wdetail.CONTRACTNO     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'   wdetail.BRANCHCODE     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'   wdetail.BRANCHNO       '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'   wdetail.policy         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'   wdetail.branch         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'   wdetail.STICKERNO      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'   wdetail.CUSTOMERNAME   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  wdetail.ADDRESS        '"' SKIP.
    /*Add Jiraphon A59-0451*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  wdetail.ADDRESS2       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  wdetail.ADDRESS3       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  wdetail.ADDRESS4       '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  wdetail.ADDRESS5       '"' SKIP.
    /*End Jiraphon A59-0451*/    
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  wdetail.CARNO          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  wdetail.BRAND          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  wdetail.MODEL          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  wdetail.CC             '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  wdetail.REGISTRATION   '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  wdetail.PROVINCE       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  wdetail.BODY           '"' SKIP.          
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  wdetail.ENGINE         '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  wdetail.STARTDATE      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  wdetail.ENDDATE        '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  wdetail.NETINCOME      '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.TOTALINCOME    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  wdetail.CARDID         '"' SKIP. 
    /*Add Jiraporn A59-0342*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  wdetail.PRODUCER       '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  wdetail.AGENT          '"' SKIP.
    /*End Jiraporn A59-0342*/
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  wdetail.nstatus        '"' SKIP. Comment Jiraporn A59-0342 */
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.remark         '"' SKIP.  /*Jiraporn A59-0342*/*/ /*A60-0542*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  wdetail.camp_cj        '"' SKIP. /*A60-0542*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  wdetail.remark         '"' SKIP. /*A60-0542*/
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Pro_matchfile_prem C-Win 
PROCEDURE Pro_matchfile_prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FOR EACH wdetail .
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE  
        sicuw.uwm100.policy  =  TRIM(wdetail.policy)  NO-LOCK NO-ERROR.
    /*Add Jiraporn A59-0342*/
        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE
            sicuw.uwm301.policy  =  TRIM(brstat.tlt.nor_noti_tlt) NO-LOCK NO-ERROR.
    /*End Jiraporn A59-0342*/
    IF AVAIL sicuw.uwm100 THEN do: 
        ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.policy) .
        DISP fi_process WITH FRAM fr_main.
        FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
            brstat.tlt.cha_no         = trim(wdetail.STICKERNO) AND 
            brstat.tlt.genusr         = "aycal72"               NO-ERROR NO-WAIT .
        IF AVAIL brstat.tlt THEN DO:
           /* ASSIGN  brstat.tlt.releas   = "Yes"  . */ /*A59-0342*/
            IF brstat.tlt.nor_noti_tlt = "" THEN ASSIGN brstat.tlt.nor_noti_tlt = sicuw.uwm100.policy.
            IF brstat.tlt.comp_usr_tlt = "" THEN ASSIGN brstat.tlt.comp_usr_tlt = sicuw.uwm100.branch.

             MESSAGE 
                    brstat.tlt.nor_noti_tlt "=" sicuw.uwm100.policy.
                    
/*
            /*Add Jiraporn A59-0342*/
            IF brstat.tlt.nor_noti_tlt = sicuw.uwm100.policy THEN DO:
                IF brstat.tlt.comp_sck = sicuw.uwm301.cha_no THEN ASSIGN brstat.tlt.releas = "YES".
                ELSE ASSIGN brstat.tlt.releas = "NO"
                     wdetail.remark = "Please Check Policy and ChaNo.".
                MESSAGE 
                    brstat.tlt.nor_noti_tlt "=" sicuw.uwm100.policy SKIP
                    brstat.tlt.comp_sck "=" sicuw.uwm301.cha_no.
            END.
            /*End Jiraporn A59-0342*/
*/
        END.
        
        RELEASE brstat.tlt.
    END.

END.      /* wdetail*/
*/
DEF BUFFER bftlt FOR brstat.tlt. /*A64-0060*/
FOR EACH wdetail .
    FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE  
        sicuw.uwm100.policy  =  TRIM(wdetail.policy)  NO-LOCK NO-ERROR.
    IF AVAIL sicuw.uwm100 THEN do: 
       
        FIND LAST sicuw.uwm301 USE-INDEX /*uwm30103*/ uwm30121 WHERE /*Edit Jiraphon A59-0342*/
            sicuw.uwm301.policy  =  sicuw.uwm100.policy AND
            sicuw.uwm301.rencnt  =  sicuw.uwm100.rencnt AND
            sicuw.uwm301.endcnt  =  sicuw.uwm100.endcnt AND
            wdetail.BODY  =  sicuw.uwm301.cha_no NO-LOCK NO-ERROR.
       
        IF AVAIL sicuw.uwm301 THEN DO: 
            ASSIGN fi_process = "Match file Policy and Update Status " + TRIM(wdetail.policy) .
            DISP fi_process WITH FRAM fr_main.

            FIND LAST brstat.tlt USE-INDEX tlt06 WHERE 
                brstat.tlt.cha_no         = trim(wdetail.STICKERNO) AND 
                brstat.tlt.genusr         = "aycal72"               NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN DO:
               /* ASSIGN  brstat.tlt.releas   = "Yes"  . */ /*A59-0342*/
                IF brstat.tlt.nor_noti_tlt = "" THEN ASSIGN brstat.tlt.nor_noti_tlt = sicuw.uwm100.policy.
                IF brstat.tlt.comp_usr_tlt = "" THEN ASSIGN brstat.tlt.comp_usr_tlt = sicuw.uwm100.branch.
                IF wdetail.body = sicuw.uwm301.cha_no THEN brstat.tlt.releas = "Yes".
                ELSE wdetail.remark = "Check Policy and Sticker no.".
                /* Add by : Ranu I. A64-0060 */
                FIND FIRST bftlt USE-INDEX tlt06         WHERE   
                index(bftlt.cha_no,brstat.tlt.cha_no ) <> 0    AND 
                bftlt.nor_noti_tlt = sicuw.uwm100.policy AND 
                bftlt.genusr   <> "AYCAL72"    NO-ERROR NO-WAIT .
                IF  AVAIL bftlt THEN DO: 
                    ASSIGN
                        bftlt.nor_noti_tlt   = CAPS(sicuw.uwm100.policy)   /* 3 เลขกรมธรรม์   */ 
                        bftlt.safe2          = TRIM(sicuw.uwm100.docno1)   /* 5 เลขที่ใบเสร็จ */ 
                        bftlt.comp_usr_tlt   = TRIM(sicuw.uwm100.branch) 
                        bftlt.releas         = IF index(bftlt.releas,"NO") <> 0 THEN REPLACE(bftlt.releas,"NO","YES") ELSE bftlt.releas 
                        bftlt.filler2        = IF index(bftlt.filler2,"Use by") <> 0 THEN bftlt.filler2 + "/Up Release By AYCAL72" 
                                               ELSE IF index(bftlt.filler2,"Release") = 0 THEN bftlt.filler2 + "/Up Release By AYCAL72" 
                                               ELSE bftlt.filler2 . /* 6  หมายเหตุ       */ 
                    wdetail.remark = wdetail.remark + "/Up Sticker BU3 Release".
                END.
                /* end : A64-0060*/
            END.  
            RELEASE brstat.tlt.
        END.
    END.
END.      /* wdetail*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

