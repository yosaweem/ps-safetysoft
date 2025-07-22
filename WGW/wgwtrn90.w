&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          brstat           PROGRESS
*/
&Scoped-define WINDOW-NAME wgwtrn90
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwtrn90 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: A54-0004 Amparat c. 

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

DEF VAR nv_Recuwm100 AS RECID.
DEF VAR n_insref  AS CHAR.

DEF SHARED VAR n_user     AS   CHAR.
DEF SHARED VAR nv_recid     AS RECID . 
DEF SHARED VAR nv_recid1    AS RECID . 

DEF VAR nv_recPolmst AS RECID.

DEF VAR nv_Polno     AS CHAR.
DEF VAR nv_renno     AS INT.
DEF VAR nv_endno     AS INT.

DEF VAR nv_total     AS CHAR.
DEF VAR nv_start     AS CHAR.
DEF VAR nv_timestart AS INT.
DEF VAR nv_timeend   AS INT.
DEF VAR nv_polmst    AS CHAR.
DEF VAR nv_brnfile   AS CHAR. 
DEF VAR nv_duprec    AS CHAR. 
DEF VAR nv_Insno     AS CHAR.

DEF VAR nv_Policy   AS CHAR.
DEF VAR nv_RenCnt   AS INT.
DEF VAR nv_EndCnt   AS INT.

DEF VAR nv_Branch   AS CHAR.
DEF VAR nv_next     AS LOGICAL.
DEF VAR nv_message  AS CHAR FORMAT "X(200)".
DEF VAR putchr      AS CHAR FORMAT "X(100)" INIT "" NO-UNDO.
DEF VAR putchr1     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR textchr     AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.
DEF VAR nv_trferr   AS CHAR FORMAT "X(80)"  INIT "" NO-UNDO.


DEF VAR nv_errfile AS CHAR FORMAT "X(30)"  INIT "" NO-UNDO.
DEF VAR nv_error   AS LOGICAL    INIT NO     NO-UNDO.

DEF BUFFER bf_PolMst FOR brstat.Polmst_fil.
DEF NEW SHARED STREAM ns1.
DEF NEW SHARED STREAM ns2.
DEF NEW SHARED STREAM ns3.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_PolMst

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES polmst_fil

/* Definitions for BROWSE br_PolMst                                     */
&Scoped-define FIELDS-IN-QUERY-br_PolMst polmst_fil.trndat ~
polmst_fil.policy name1 + "" + name2 polmst_fil.fstdat polmst_fil.trty11 ~
polmst_fil.docno1 polmst_fil.agent polmst_fil.acno1 polmst_fil.releas 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_PolMst 
&Scoped-define QUERY-STRING-br_PolMst FOR EACH polmst_fil NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_PolMst OPEN QUERY br_PolMst FOR EACH polmst_fil NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_PolMst polmst_fil
&Scoped-define FIRST-TABLE-IN-QUERY-br_PolMst polmst_fil


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_descfr fi_fileName fi_Policyfr ~
fi_Policyto bu_refresh bu_Transfer fi_brnfile fi_TranPol fi_dupfile ~
fi_strTime fi_time fi_TotalTime fi_File bu_Export bu_exit fi_descto RECT-1 ~
RECT-636 br_PolMst RECT-640 RECT-648 RECT-649 RECT-650 RECT-2 RECT-651 
&Scoped-Define DISPLAYED-OBJECTS fi_descfr fi_fileName fi_Policyfr ~
fi_Policyto fi_brnfile fi_TranPol fi_dupfile fi_strTime fi_time ~
fi_TotalTime fi_File fi_descto 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwtrn90 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.19
     FONT 6.

DEFINE BUTTON bu_Export 
     LABEL "OK" 
     SIZE 9.5 BY 1.1
     FONT 6.

DEFINE BUTTON bu_refresh 
     IMAGE-UP FILE "wimage/flipu.bmp":U
     LABEL "" 
     SIZE 15.17 BY 1.19.

DEFINE BUTTON bu_Transfer 
     LABEL "TRANSFER TO MARINE SYSTEM" 
     SIZE 60.5 BY 1.14
     FONT 6.

DEFINE VARIABLE fi_brnfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 49 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_descfr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_descto AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dupfile AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 49 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_File AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 49 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_fileName AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 43.67 BY 1 NO-UNDO.

DEFINE VARIABLE fi_Policyfr AS CHARACTER FORMAT "XX-XX-XX/XXXXXX":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Policyto AS CHARACTER FORMAT "XX-XX-XX/XXXXXX":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_strTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TotalTime AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 11 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_TranPol AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 49 BY .95
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 97.67 BY 1.62
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.17 BY 1.62
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-636
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 132 BY 22.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-640
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 17.17 BY 1.62
     BGCOLOR 34 .

DEFINE RECTANGLE RECT-648
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 64.5 BY 8.57.

DEFINE RECTANGLE RECT-649
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 66 BY 6.19.

DEFINE RECTANGLE RECT-650
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 63 BY 1.67
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-651
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 66 BY 2.29
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_PolMst FOR 
      polmst_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_PolMst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_PolMst wgwtrn90 _STRUCTURED
  QUERY br_PolMst NO-LOCK DISPLAY
      polmst_fil.trndat COLUMN-LABEL "Tran.Date" FORMAT "99/99/9999":U
            WIDTH 12
      polmst_fil.policy FORMAT "x(16)":U
      name1 + "" + name2 COLUMN-LABEL "Insured" FORMAT "x(35)":U
      polmst_fil.fstdat COLUMN-LABEL "Inv.Date" FORMAT "99/99/9999":U
            WIDTH 12
      polmst_fil.trty11 COLUMN-LABEL "Type" FORMAT "x":U
      polmst_fil.docno1 COLUMN-LABEL "Inv.No" FORMAT "x(10)":U
      polmst_fil.agent FORMAT "x(12)":U
      polmst_fil.acno1 FORMAT "x(12)":U
      polmst_fil.releas COLUMN-LABEL "Released" FORMAT "yes/no":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 13.14 ROW-HEIGHT-CHARS .6 EXPANDABLE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_descfr AT ROW 17.67 COL 100.33 COLON-ALIGNED NO-LABEL
     fi_fileName AT ROW 23.52 COL 12.17 COLON-ALIGNED NO-LABEL
     fi_Policyfr AT ROW 17.62 COL 79.83 COLON-ALIGNED NO-LABEL
     fi_Policyto AT ROW 18.81 COL 79.83 COLON-ALIGNED NO-LABEL
     bu_refresh AT ROW 1.29 COL 100
     bu_Transfer AT ROW 20.91 COL 70.17
     fi_brnfile AT ROW 17.29 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_TranPol AT ROW 18.29 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_dupfile AT ROW 20.29 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_strTime AT ROW 21.29 COL 16.5 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 21.29 COL 34.5 COLON-ALIGNED NO-LABEL
     fi_TotalTime AT ROW 21.29 COL 54.5 COLON-ALIGNED NO-LABEL
     fi_File AT ROW 19.29 COL 16.5 COLON-ALIGNED NO-LABEL
     bu_Export AT ROW 23.52 COL 58
     bu_exit AT ROW 1.29 COL 117.33
     fi_descto AT ROW 18.86 COL 100.33 COLON-ALIGNED NO-LABEL
     br_PolMst AT ROW 3 COL 2.33
     "    Show Detail Transfer" VIEW-AS TEXT
          SIZE 66.33 BY .95 AT ROW 16.24 COL 2.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "Policy No. Dup. to file" VIEW-AS TEXT
          SIZE 15 BY .95 AT ROW 20.29 COL 3.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Transfer policy" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 18.24 COL 3.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Write to file" VIEW-AS TEXT
          SIZE 11.67 BY .95 AT ROW 17.29 COL 6.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Start Time" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 21.29 COL 7.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Total" VIEW-AS TEXT
          SIZE 5.83 BY .95 AT ROW 21.29 COL 49.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "End" VIEW-AS TEXT
          SIZE 4 BY .95 AT ROW 21.33 COL 31.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "   Policy Transfer" VIEW-AS TEXT
          SIZE 64.83 BY .95 AT ROW 16.24 COL 68.17
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "แสดงข้อมูล และ โอนข้อมูล  กรมธรรม์ Marine 90 GateWay To Marine System" VIEW-AS TEXT
          SIZE 80 BY .91 AT ROW 1.38 COL 11
          BGCOLOR 1 FGCOLOR 7 FONT 17
     "Output To :" VIEW-AS TEXT
          SIZE 10.67 BY .95 AT ROW 23.52 COL 3
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "สำหรับเรียกรายงานข้อมูลที่ยังไม่มีการโอนเข้า Marine Premium ออกเป็นไฟล์  .XLS" VIEW-AS TEXT
          SIZE 63.5 BY .62 AT ROW 22.71 COL 3.17
          BGCOLOR 8 FGCOLOR 4 
     "Policy From :" VIEW-AS TEXT
          SIZE 12.17 BY .95 AT ROW 17.67 COL 69
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Policy To :" VIEW-AS TEXT
          SIZE 10.5 BY .95 AT ROW 18.86 COL 70.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Update File" VIEW-AS TEXT
          SIZE 11 BY .95 AT ROW 19.33 COL 6.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1.05 COL 1.33
     RECT-636 AT ROW 2.81 COL 1.33
     RECT-640 AT ROW 1.05 COL 99
     RECT-648 AT ROW 16.24 COL 68.17
     RECT-649 AT ROW 16.29 COL 2
     RECT-650 AT ROW 20.62 COL 68.83
     RECT-2 AT ROW 1.05 COL 132.34 RIGHT-ALIGNED
     RECT-651 AT ROW 22.52 COL 2
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.


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
  CREATE WINDOW wgwtrn90 ASSIGN
         HIDDEN             = YES
         TITLE              = "wgwtrn90 : Query and Transfer Policy Line90 To Marine"
         HEIGHT             = 24
         WIDTH              = 133
         MAX-HEIGHT         = 29
         MAX-WIDTH          = 141.83
         VIRTUAL-HEIGHT     = 29
         VIRTUAL-WIDTH      = 141.83
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
IF NOT wgwtrn90:LOAD-ICON("wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/iconhead.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwtrn90
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   Custom                                                               */
/* BROWSE-TAB br_PolMst RECT-636 fr_main */
/* SETTINGS FOR RECTANGLE RECT-2 IN FRAME fr_main
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrn90)
THEN wgwtrn90:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_PolMst
/* Query rebuild information for BROWSE br_PolMst
     _TblList          = "brstat.polmst_fil"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > brstat.polmst_fil.trndat
"polmst_fil.trndat" "Tran.Date" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" ""
     _FldNameList[2]   = brstat.polmst_fil.policy
     _FldNameList[3]   > "_<CALC>"
"name1 + """" + name2" "Insured" "x(35)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > brstat.polmst_fil.fstdat
"polmst_fil.fstdat" "Inv.Date" ? "date" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" ""
     _FldNameList[5]   > brstat.polmst_fil.trty11
"polmst_fil.trty11" "Type" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > brstat.polmst_fil.docno1
"polmst_fil.docno1" "Inv.No" "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > brstat.polmst_fil.agent
"polmst_fil.agent" ? "x(12)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > brstat.polmst_fil.acno1
"polmst_fil.acno1" ? "x(12)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > brstat.polmst_fil.releas
"polmst_fil.releas" "Released" ? "logical" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE br_PolMst */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwtrn90
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrn90 wgwtrn90
ON END-ERROR OF wgwtrn90 /* wgwtrn90 : Query and Transfer Policy Line90 To Marine */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwtrn90 wgwtrn90
ON WINDOW-CLOSE OF wgwtrn90 /* wgwtrn90 : Query and Transfer Policy Line90 To Marine */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit wgwtrn90
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
APPLY  "CLOSE"  TO THIS-PROCEDURE.
RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Export
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Export wgwtrn90
ON CHOOSE OF bu_Export IN FRAME fr_main /* OK */
DO:
   DEF VAR nv_count AS INT.
    nv_count  = 0.
   IF fi_fileName  = "" THEN DO:
      MESSAGE "Output To Filename is Blank....!"
      VIEW-AS ALERT-BOX ERROR.
      APPLY "entry" TO fi_fileName.
      RETURN NO-APPLY.
  END.
  ELSE DO:

  OUTPUT TO  VALUE(fi_fileName).
  EXPORT DELIMITER "|"
    "รายงานกรมธรรม์ Marine GateWay ที่ยังไม่มีการโอนงานเข้าระบบ Premium".
  EXPORT DELIMITER "|"
    "No."            
    "Trans Date"     
    "Policy No."     
    "Doc No."        
    "Code Insure"    
    "Name Insure"    
    "On Board"       
    "Vessel (1)"           
    "At and From (1)"
    "Vessel (2)"  
    "At and From (2)"
    "Premium"        
    "Tax"            
    "Stamp"          
    "Trip"           
    "Commission"     
    "Net.Prem."
    "Agent"
    "Producer".
 
  FOR EACH  brStat.polmst_fil USE-INDEX Polmst01
      WHERE brstat.polmst_fil.Poltyp = "C90"
        AND brStat.polmst_fil.releas = NO NO-LOCK.
       FIND FIRST marine_fil USE-INDEX marine01
            WHERE marine_fil.policy = polmst_fil.policy NO-LOCK NO-ERROR NO-WAIT.
       IF AVAIL marine_fil THEN DO:
          nv_count = nv_count + 1.
      
            EXPORT DELIMITER "|"
            nv_count           
            polmst_fil.trndat  
            polmst_fil.policy  
            polmst_fil.docno1  
            polmst_fil.insref  
            polmst_fil.name1   
            marine_fil.voydat  
            marine_fil.vessel              
            marine_fil.voyage  
            marine_fil.vessel2 
            marine_fil.voyage2 
            polmst_fil.prem_t  
            polmst_fil.rtax_t  
            polmst_fil.rstp_t  
            polmst_fil.pstp    
            polmst_fil.com1_t  
            polmst_fil.sigr_p
            Polmst_Fil.Agent
            Polmst_fil.acno1.
       END.
  END.









MESSAGE "Output Data To File OK." VIEW-AS ALERT-BOX INFORMATION.


  END.
  OUTPUT CLOSE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_refresh
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_refresh wgwtrn90
ON CHOOSE OF bu_refresh IN FRAME fr_main
DO:
  RUN PDUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Transfer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Transfer wgwtrn90
ON CHOOSE OF bu_Transfer IN FRAME fr_main /* TRANSFER TO MARINE SYSTEM */
DO:
/* Transfer Data Marine gw To Marine Premium 
   connect db : gw_safet -ld sic_bran
                gw_stat  -ld brStat 
*/
 IF fi_PolicyTo < fi_Policyfr THEN DO:
     MESSAGE "Policy From > Policy to "  VIEW-AS ALERT-BOX ERROR.
     APPLY "ENTRY" TO fi_Policyto IN FRAME fr_main.
     RETURN NO-APPLY.
 END.

 ASSIGN
  fi_brnfile   = ""
  fi_TranPol   = ""
  fi_File      = ""
  fi_dupfile   = "" 
  fi_strTime   = "" 
  fi_time      = "" 
  fi_TotalTime = ""
  nv_Insno   = ""
  nv_total     = ""
  nv_start     = STRING(TIME,"HH:MM:SS")
  fi_strTime   = STRING(TIME,"HH:MM:SS")
  nv_timestart = TIME
  nv_timeend   = TIME.
  nv_polmst    = "".
  nv_errfile   = "C:\GWTRANF\" +                    
                        STRING(MONTH(TODAY),"99")    + 
                        STRING(DAY(TODAY),"99")      + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".err".
 nv_brnfile   = "C:\GWTRANF\" + 
                        STRING(MONTH(TODAY),"99")    +
                        STRING(DAY(TODAY),"99")      +
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) +
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".fuw".
 nv_duprec    = "C:\GWTRANF\" +                  
                        STRING(MONTH(TODAY),"99")    + 
                        STRING(DAY(TODAY),"99")      + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
              SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) + ".dup".    

 OUTPUT STREAM ns1 TO VALUE(nv_errfile).
 OUTPUT STREAM ns2 TO VALUE(nv_brnfile).
 OUTPUT STREAM ns3 TO VALUE(nv_duprec). 
 /*---Header Err---*/
 PUT STREAM ns1
     "Transfer Error  "
     "Transfer Date : " TODAY  FORMAT "99/99/9999"
     "  Time : " STRING(TIME,"HH:MM:SS")  SKIP.
 PUT STREAM ns1 FILL("-",90) FORMAT "X(90)" SKIP.
 PUT STREAM ns1 "Policy No.       R / E   Error " SKIP.
 /*---Header fuw---*/
 PUT STREAM ns2
     "Transfer Complete   "
     "Transfer Date : " TODAY  FORMAT "99/99/9999"
     "  Time : " STRING(TIME,"HH:MM:SS") SKIP.
 PUT STREAM ns2 FILL("-",100) FORMAT "X(100)" SKIP.
 PUT STREAM ns2 "Ceding Pol.       R/E    Policy No.        R/E    Trn.Date    Ent.Date    UserID   Insure Name " SKIP.
 /*---Header Dup---*/
 PUT STREAM ns3
 "Transfer Duplicate   "
 "Transfer Date : " TODAY  FORMAT "99/99/9999"
 "  Time : " STRING(TIME,"HH:MM:SS") SKIP.
 PUT STREAM ns3 FILL("-",100) FORMAT "X(100)" SKIP.
 PUT STREAM ns3 "Ceding Pol.       R/E    Policy No.        R/E    Trn.Date    Ent.Date    UserID    Insure Name " SKIP.
 /*----------------*/

 fi_brnfile = nv_brnfile.
 fi_dupfile = nv_duprec.
 DISP fi_brnfile fi_dupfile  fi_strTime WITH FRAME fr_main.

 FOR EACH  brstat.Polmst_fil USE-INDEX Polmst01
     WHERE brstat.Polmst_fil.Policy >= fi_Policyfr 
       AND brstat.Polmst_fil.Policy <= fi_PolicyTo
        BY brstat.Polmst_fil.Policy:

    ASSIGN nv_policy = brStat.Polmst_fil.Policy
           nv_rencnt = brStat.Polmst_fil.rencnt
           nv_endcnt = brStat.Polmst_fil.endcnt
           nv_recPolmst = RECID(brstat.Polmst_fil)
           nv_error  = NO

    fi_TranPol =  STRING(nv_Policy,"XX-XX-XX/XXXXXX") + " " + 
                        STRING(nv_RenCnt,"99") + "/" +
                        STRING(nv_EndCnt,"999")
     fi_time = STRING(TIME,"HH:MM:SS").
     nv_timeend   = TIME.
      
     DISP  fi_TranPol fi_time WITH FRAME fr_main.

    RUN PDCheckNs1.

    IF nv_error = NO THEN DO:
      /*--Comment by amparat c. A54-0004---
       FIND bran_off.trnpol WHERE
            bran_off.trnpol.policy = nv_Policy AND
            bran_off.trnpol.rencnt = nv_RenCnt AND
            bran_off.trnpol.endcnt = nv_EndCnt NO-ERROR.
       IF NOT AVAILABLE bran_off.trnpol THEN DO:
              CREATE bran_off.trnpol.
       END.
       ASSIGN 
          bran_off.trnpol.policy = nv_Policy
          bran_off.trnpol.rencnt = nv_RenCnt
          bran_off.trnpol.endcnt = nv_EndCnt
          bran_off.trnpol.trndat = TODAY
          bran_off.trnpol.releas = brstat.Polmst_fil.releas.
          bran_off.trnpol.startim = STRING(TIME,"HH:MM:SS").
      -----------------*/
          DISPLAY  "Polmst_fil" @ fi_File WITH FRAME fr_main.          
          RUN wgw\wgwMar01 (INPUT nv_Policy,INPUT nv_RenCnt,INPUT nv_EndCnt). /*--PolMst_fil--*/       

       ASSIGN
        brstat.Polmst_fil.releas     =  YES
        brstat.Polmst_fil.usrrel     =  n_user 
        brstat.Polmst_fil.reldat     =  TODAY
        brStat.Polmst_fil.reltim = STRING(TIME,"HH:MM:SS") .

      /*---Comment by amparat c. A54-0004---
         ASSIGN
         bran_off.trnpol.transfer  = YES
         bran_off.trnpol.date_trn  = TODAY
         bran_off.trnpol.endtime   = TRIM(USERID(LDBNAME(1)))
                                   + SUBSTR(STRING(TIME,"HH:MM:SS"),1,2)
                                   + SUBSTR(STRING(TIME,"HH:MM:SS"),4,2)
                                   + SUBSTR(STRING(TIME,"HH:MM:SS"),7,2).
       ------*/
       IF nv_error = NO THEN DO:
          PUT STREAM ns2   
          nv_policy FORMAT "X(16)" " "
          nv_rencnt "/" nv_endcnt "  "

          brStat.Polmst_fil.trndat "  "
          brStat.Polmst_fil.entdat "  "
          brStat.Polmst_fil.usrid "   " 
          TRIM(TRIM(brStat.Polmst_fil.ntitle) + " " + 
          TRIM(brStat.Polmst_fil.name1) + " " +
          TRIM(brStat.Polmst_fil.name2)) FORMAT "x(60)" SKIP.
       END.

    END. /*--Error--*/

 END.  /*--For Each--*/
OUTPUT STREAM ns1 close.
OUTPUT STREAM ns2 close.
OUTPUT STREAM ns3 close.

MESSAGE "Transfer Data Complete" VIEW-AS ALERT-BOX INFORMATION.
ASSIGN fi_Policyfr = ""
       fi_Policyto = "".
DISP fi_Policyfr fi_Policyto WITH FRAME fr_Main.


APPLY "CHOOSE" TO bu_refresh IN FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fileName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fileName wgwtrn90
ON LEAVE OF fi_fileName IN FRAME fr_main
DO:
  fi_fileName = INPUT fi_fileName.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyfr wgwtrn90
ON LEAVE OF fi_Policyfr IN FRAME fr_main
DO:
  fi_Policyfr = CAPS (INPUT fi_Policyfr).
  DISP fi_policyfr WITH FRAME fr_main.
  IF fi_PolicyFr <> ""  THEN DO:
     FIND FIRST brStat.Polmst_fil USE-INDEX Polmst01
          WHERE brStat.Polmst_fil.Policy = fi_policyfr
            AND brStat.Polmst_fil.rencnt = 0
            AND brStat.Polmst_fil.endcnt = 0 NO-LOCK NO-ERROR.
     IF AVAIL brStat.Polmst_fil THEN DO:
        fi_descfr = brStat.Polmst_fil.ntitle + " " + brStat.Polmst_fil.name1 + " " + brStat.Polmst_fil.Name2.
     END.
            
  END.
  DISP fi_descfr WITH FRAME fr_main.
  IF fi_policyto = "" THEN DO:
     fi_policyto = fi_policyfr.
     fi_descto   = fi_descfr.
     DISP fi_policyto fi_descto WITH FRAME fr_main.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Policyto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Policyto wgwtrn90
ON LEAVE OF fi_Policyto IN FRAME fr_main
DO:
  fi_Policyto = CAPS (INPUT fi_Policyto).
  DISP fi_policyto WITH FRAME fr_main.

  IF fi_PolicyTo < fi_Policyfr THEN DO:
     MESSAGE "Policy From > Policy to "  VIEW-AS ALERT-BOX ERROR.
     APPLY "ENTRY" TO fi_Policyto IN FRAME fr_main.
     RETURN NO-APPLY.
  END.
  ELSE DO:
   IF fi_Policyto <> ""  THEN DO:
     FIND FIRST brStat.Polmst_fil USE-INDEX Polmst01
          WHERE brStat.Polmst_fil.Policy = fi_policyto
            AND brStat.Polmst_fil.rencnt = 0
            AND brStat.Polmst_fil.endcnt = 0 NO-LOCK NO-ERROR.
     IF AVAIL brStat.Polmst_fil THEN DO:
        fi_descto = brStat.Polmst_fil.ntitle + " " + brStat.Polmst_fil.name1 + " " + brStat.Polmst_fil.Name2.
     END.
            
  END.
  DISP fi_descto WITH FRAME fr_main.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_PolMst
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwtrn90 


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WGWQBAT1".
  gv_prog  = "Query Batch No Transfer Motor Policy To Premium".  
  /*RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).*/
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE). 
  SESSION:DATA-ENTRY-RETURN = YES.
/*********************************************************************/ 
/*MESSAGE
  PDBNAME (1) LDBNAME(1) SKIP
  PDBNAME (2) LDBNAME(2) SKIP
  PDBNAME (3) LDBNAME(3) SKIP 
  PDBNAME (4) LDBNAME(4) SKIP   
  PDBNAME (5) LDBNAME(5) SKIP
  PDBNAME (6) LDBNAME(6) SKIP  
  VIEW-AS ALERT-BOX.

  ASSIGN nv_branch = TRIM(SUBSTRING(n_user,6,2)).
         fi_branch = nv_branch.
  DISP fi_branch WITH FRAME fr_main.

  FIND FIRST sic_bran.xmm023 WHERE sic_bran.xmm023.branch = fi_branch NO-LOCK NO-ERROR.
      IF AVAIL sic_bran.xmm023 THEN DO:
         fi_brdesc = sic_bran.xmm023.bdes.
         DISP fi_brdesc WITH FRAME fr_Main.

         RUN pdUpdateQ.
         ENABLE  br_Uwm100 WITH FRAME fr_main.
      END.

  
      */
  APPLY "CHOOSE" TO bu_refresh IN FRAME fr_main.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwtrn90  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwtrn90)
  THEN DELETE WIDGET wgwtrn90.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwtrn90  _DEFAULT-ENABLE
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
  DISPLAY fi_descfr fi_fileName fi_Policyfr fi_Policyto fi_brnfile fi_TranPol 
          fi_dupfile fi_strTime fi_time fi_TotalTime fi_File fi_descto 
      WITH FRAME fr_main IN WINDOW wgwtrn90.
  ENABLE fi_descfr fi_fileName fi_Policyfr fi_Policyto bu_refresh bu_Transfer 
         fi_brnfile fi_TranPol fi_dupfile fi_strTime fi_time fi_TotalTime 
         fi_File bu_Export bu_exit fi_descto RECT-1 RECT-636 br_PolMst RECT-640 
         RECT-648 RECT-649 RECT-650 RECT-2 RECT-651 
      WITH FRAME fr_main IN WINDOW wgwtrn90.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwtrn90.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckNs1 wgwtrn90 
PROCEDURE PDCheckNs1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
ASSIGN putchr  = ""
       putchr1 = ""
       textchr = STRING(TRIM(nv_policy),"x(16)") + " " +
                 STRING(nv_rencnt,"99") + "/" + STRING(nv_endcnt,"999").

FIND LAST bf_PolMst WHERE RECID(bf_PolMst) = nv_RecPolmst.
IF NOT AVAIL wk_uwm100 THEN DO:
   ASSIGN
    putchr1 = "Not Found Record on sic_bran.uwm100" .
    putchr  = textchr  + "  " + TRIM(putchr1).
   PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
   nv_message = putchr1.
   nv_error = YES.
 /*NEXT.*/
END.
ELSE DO:
  IF wk_uwm100.poltyp = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Policy Type"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.branch = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Branch"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.comdat = ? THEN DO:
     ASSIGN 
       putchr1 = "ไม่มีค่า Comdate"
       putchr  = textchr + "  " + TRIM(putchr1).
      PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
      nv_message = putchr1.
      nv_error = YES.
    /*NEXT.*/
  END.
  IF wk_uwm100.expdat = ? THEN DO:
     ASSIGN
       putchr1 = "ไม่มีค่า Expiry Date"
       putchr  = textchr + "  " + TRIM(putchr1).
      PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
      nv_message = putchr1.
      nv_error = YES.
    /*NEXT.*/
  END.
  IF wk_uwm100.name1 = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Name Of Insured"
      putchr  = textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.prem_t = 0 THEN DO:
     ASSIGN
      putchr1 = "ไม่มีค่า Premium"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.tranty = "" THEN DO:
     ASSIGN
      putchr1 = "ไม่สามารถระบุประเภทงานได้"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.policy = "" THEN DO:
     ASSIGN
      putchr1 = "Policy No. is blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.RenCnt <> 0 THEN DO:
     ASSIGN
      putchr1 = "Renewal Count error"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.EndCnt <> 0 THEN DO:
     ASSIGN
      putchr1 = "Endorsement Count error"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.agent = "" OR wk_uwm100.acno1 = "" THEN DO:
     ASSIGN
      putchr1 = "Producer, Agent are blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF wk_uwm100.insref = "" THEN DO:
     ASSIGN
      putchr1 = "Insured Code is blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF TRIM(wk_uwm100.Addr1) + TRIM(wk_uwm100.Addr2) +
     TRIM(wk_uwm100.Addr3) + TRIM(wk_uwm100.Addr4) = "" THEN DO:
     ASSIGN
      putchr1 = "Address is blank"
      putchr  = textchr + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.   
  /*UWM120*/
  FIND LAST sic_bran.uwm120 USE-INDEX uwm12001
      WHERE sic_bran.uwm120.policy = wk_uwm100.policy
        AND sic_bran.uwm120.rencnt = wk_uwm100.rencnt
        AND sic_bran.uwm120.endcnt = wk_uwm100.endcnt
        AND sic_bran.uwm120.riskgp = 0
        AND sic_bran.uwm120.riskno = 1
        AND sic_bran.uwm120.bchyr  = nv_batchyr
        AND sic_bran.uwm120.bchno  = nv_batchno
        AND sic_bran.uwm120.bchcnt = nv_batcnt NO-LOCK NO-ERROR.
 IF NOT AVAIL sic_bran.uwm120 THEN DO:
    ASSIGN
     putchr1 = "Not Found Record on sic_bran.uwm120".
     putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.
 /*UWM130*/
 FIND LAST sic_bran.uwm130 USE-INDEX uwm13001
     WHERE sic_bran.uwm130.policy = wk_uwm100.policy
       AND sic_bran.uwm130.rencnt = wk_uwm100.rencnt
       AND sic_bran.uwm130.endcnt = wk_uwm100.endcnt
       AND sic_bran.uwm130.riskgp = 0
       AND sic_bran.uwm130.riskno = 1
       AND sic_bran.uwm130.itemno = 1
       AND sic_bran.uwm130.bchyr = nv_batchyr 
       AND sic_bran.uwm130.bchno = nv_batchno 
       AND sic_bran.uwm130.bchcnt  = nv_batcnt NO-LOCK NO-ERROR.
 IF NOT AVAIL  sic_bran.uwm130 THEN DO:
    ASSIGN
     putchr1 = "Not Found Record on sic_bran.uwm130" .
     putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.
 /*UWM301*/
 FIND LAST sic_bran.uwm301 USE-INDEX uwm30101
     WHERE sic_bran.uwm301.policy  = wk_uwm100.policy
       AND sic_bran.uwm301.rencnt  = wk_uwm100.rencnt
       AND sic_bran.uwm301.endcnt  = wk_uwm100.endcnt
       AND sic_bran.uwm301.riskgp  = 0
       AND sic_bran.uwm301.riskno  = 1
       AND sic_bran.uwm301.itemno  = 1
       AND sic_bran.uwm301.bchno   = nv_batchno
       AND sic_bran.uwm301.bchcnt  = nv_batcnt
       AND sic_bran.uwm301.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
 IF NOT AVAIL  sic_bran.uwm301 THEN DO:
    ASSIGN
      putchr1 = "Not Found Record on sic_bran.uwm301" .
      putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.
 ELSE DO:
  IF LENGTH(sic_bran.uwm301.vehreg) > 11 THEN DO:
     ASSIGN
      putchr1 = "Warning : Vehicle Register More Than 11 Characters".    
      putchr  =  textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF sic_bran.uwm301.vehreg = "" THEN DO:
     ASSIGN
      putchr1 = "Vehicle Register is mandatory field.".
      putchr  =  textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
  IF sic_bran.uwm301.modcod = "" THEN DO:
     ASSIGN
      putchr1 = "Redbook Code เป็นค่าว่าง ".
      putchr  =  textchr  + "  " + TRIM(putchr1).
     PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
     nv_message = putchr1.
     nv_error = YES.
   /*NEXT.*/
  END.
 END. /*ELSE DO:*/
 /*UWD132*/
 FIND LAST sic_bran.uwd132 USE-INDEX uwd13201
     WHERE sic_bran.uwd132.policy  = wk_uwm100.policy
       AND sic_bran.uwd132.rencnt  = wk_uwm100.rencnt
       AND sic_bran.uwd132.endcnt  = wk_uwm100.endcnt
       AND sic_bran.uwd132.riskgp  = 0
       AND sic_bran.uwd132.riskno  = 1
       AND sic_bran.uwd132.itemno  = 1
       AND sic_bran.uwd132.bchno   = nv_batchno
       AND sic_bran.uwd132.bchcnt  = nv_batcnt
       AND sic_bran.uwd132.bchyr   = nv_batchyr NO-LOCK NO-ERROR.
 IF NOT AVAIL  sic_bran.uwd132 THEN DO:
    ASSIGN
     putchr1 = "Not Found Record on sic_bran.uwd132" .
     putchr  =  textchr  + "  " + TRIM(putchr1).
    PUT STREAM ns1 putchr FORMAT "x(200)" SKIP.
    nv_message = putchr1.
    nv_error = YES.
  /*NEXT.*/
 END.

END. /*--WK_UWM100--*/
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCreMarine wgwtrn90 
PROCEDURE PDCreMarine :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateQ wgwtrn90 
PROCEDURE PDUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_PolMst
FOR EACH  brStat.Polmst_fil 
    WHERE brStat.Polmst_fil.Poltyp = "C90"
      AND brStat.Polmst_fil.releas = NO NO-LOCK
    BY brstat.Polmst_fil.Policy.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

