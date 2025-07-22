&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
  File: WacRNTL1.W    Report Match file Statement STY and NTL
          
  Description:       โปรแกรมสำหรับ Import file statement sty and ntl เพื่อ Match ข้อมูลด้วยเลข Chassis
  
  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author:   Tantawan Ch. 

  Created:   A61-0124    @05/03/2018 
---------------------------------------------------------------------------*/
/***************************************************************************/
CREATE WIDGET-POOL.                                                        
/* ***************************  Definitions  **************************    */
/* Parameters Definitions ---                                              */

/* Local Variable Definitions ---                                          */
DEFINE TEMP-TABLE wBill1
    FIELD wSeq          AS INT  FORMAT ">>>9"
    FIELD wAcno         AS CHAR FORMAT "X(10)"         /* 1 */
    FIELD wPolicy       AS CHAR FORMAT "X(20)"         /* 2 */
    FIELD wEndno        AS CHAR FORMAT "X(10)"         /* 3 */
    FIELD wComdat       AS CHAR FORMAT "x(10)"         /* 4 */
    FIELD wTrnty        AS CHAR FORMAT "X(2)"          /* 5 */
    FIELD wDocno        AS CHAR FORMAT "X(10)"         /* 6 */
    FIELD wInsure       AS CHAR FORMAT "X(45)"         /* 7 */
    FIELD wVehicle      AS CHAR FORMAT "X(30)"         /* 8 */
    FIELD wChassis      AS CHAR FORMAT "X(30)"         /* 9 */
    FIELD wLeasingNo    AS CHAR FORMAT "X(25)"         /* 10*/
    FIELD wcovcod       AS CHAR FORMAT "X(5)"          /* 11*/
    FIELD wPrem         AS DECI FORMAT "->>>,>>9.99"
    FIELD wsInc         AS DECI FORMAT "->>,>>9.99"

    INDEX wBill101 IS UNIQUE PRIMARY wPolicy wEndno wTrnty wDocno ASCENDING
    INDEX wBill102 wPolicy  wEndNo
    INDEX wBill103 wChassis .


DEFINE TEMP-TABLE wBill3
    FIELD wSeq          AS INT  FORMAT ">>>9"
    FIELD wAcno         AS CHAR FORMAT "X(10)"         /* 1 */
    FIELD wPolicy       AS CHAR FORMAT "X(20)"         /* 2 */
    FIELD wEndno        AS CHAR FORMAT "X(10)"         /* 3 */
    FIELD wComdat       AS CHAR FORMAT "x(10)"         /* 4 */
    FIELD wTrnty        AS CHAR FORMAT "X(2)"          /* 5 */
    FIELD wDocno        AS CHAR FORMAT "X(10)"         /* 6 */
    FIELD wInsure       AS CHAR FORMAT "X(45)"         /* 7 */
    FIELD wVehicle      AS CHAR FORMAT "X(30)"         /* 8 */
    FIELD wChassis      AS CHAR FORMAT "X(30)"         /* 9 */
    FIELD wLeasingNo    AS CHAR FORMAT "X(25)"         /* 10*/
    FIELD wcovcod       AS CHAR FORMAT "X(5)"          /* 11*/
    FIELD wPrem         AS DECI FORMAT "->>>,>>9.99"
    FIELD wsInc         AS DECI FORMAT "->>,>>9.99"

    INDEX wBill301 IS UNIQUE PRIMARY wPolicy wEndno wTrnty wDocno ASCENDING
    INDEX wBill302 wPolicy  wEndNo
    INDEX wBill303 wChassis .

DEFINE TEMP-TABLE wBill2
    FIELD wSeq          AS INT  FORMAT ">>>9"
    FIELD wDataDate     AS CHAR FORMAT "X(10)"   
    FIELD wNUMBER       AS CHAR FORMAT "x(15)"  
    FIELD wCompCode     AS CHAR FORMAT "x(3)"  
    FIELD wBRShort      AS CHAR FORMAT "x(2)"   
    FIELD wBRName       AS CHAR FORMAT "x(45)"   
    FIELD wArea         AS CHAR FORMAT "x(10)"
    FIELD wPart         AS CHAR FORMAT "x(25)"    
    FIELD wCustomer     AS CHAR FORMAT "X(45)" 
    FIELD wTotalPrm     AS DECI FORMAT "->>,>>9.999999"
    FIELD wClass        AS CHAR FORMAT "X(5)"
    FIELD wRegist       AS CHAR FORMAT "X(15)"                  
    FIELD wPolicySTY    AS CHAR FORMAT "X(20)" 
    FIELD wBodyNo       AS CHAR FORMAT "X(30)" 
    FIELD wCInsure      AS CHAR FORMAT "X(30)" 
    FIELD wAutoType     AS CHAR FORMAT "X(20)" 
    FIELD wPrem         AS DECI FORMAT "->>>,>>9.99"
    FIELD wIncentive    AS DECI FORMAT "->>,>>9.99"

    INDEX wBill201 IS UNIQUE PRIMARY wBodyNo ASCENDING
    INDEX wBill202 wPolicySTY .

DEFINE TEMP-TABLE wBill4
    FIELD wSeq          AS INT  FORMAT ">>>9"
    FIELD wDataDate     AS CHAR FORMAT "X(10)"   
    FIELD wNUMBER       AS CHAR FORMAT "x(15)"  
    FIELD wCompCode     AS CHAR FORMAT "x(3)"  
    FIELD wBRShort      AS CHAR FORMAT "x(2)"   
    FIELD wBRName       AS CHAR FORMAT "x(45)"   
    FIELD wArea         AS CHAR FORMAT "x(10)"
    FIELD wPart         AS CHAR FORMAT "x(25)"    
    FIELD wCustomer     AS CHAR FORMAT "X(45)" 
    FIELD wTotalPrm     AS DECI FORMAT "->>,>>9.999999"
    FIELD wClass        AS CHAR FORMAT "X(5)"
    FIELD wRegist       AS CHAR FORMAT "X(15)"                  
    FIELD wPolicySTY    AS CHAR FORMAT "X(20)" 
    FIELD wBodyNo       AS CHAR FORMAT "X(30)" 
    FIELD wCInsure      AS CHAR FORMAT "X(30)" 
    FIELD wAutoType     AS CHAR FORMAT "X(20)" 
    FIELD wIncentive    AS DECI FORMAT "->>,>>9.99"

    INDEX wBill401 IS UNIQUE PRIMARY wBodyNo ASCENDING
    INDEX wBill402 wPolicySTY .


DEFINE STREAM filebill1.
DEFINE STREAM filebill2.
DEFINE STREAM filebill3.

DEF VAR nv_Acno         AS CHAR FORMAT "X(10)".  
DEF VAR nv_Policy       AS CHAR FORMAT "X(20)".  
DEF VAR nv_Endno        AS CHAR FORMAT "X(10)".  
DEF VAR nv_Comdat       AS CHAR FORMAT "x(8)" .  
DEF VAR nv_Trnty        AS CHAR FORMAT "X(2)" .                       
DEF VAR nv_Docno        AS CHAR FORMAT "X(10)".                       
DEF VAR nv_Insure       AS CHAR FORMAT "X(45)".        
DEF VAR nv_Vehicle      AS CHAR FORMAT "X(30)".        
DEF VAR nv_Chassis      AS CHAR FORMAT "X(30)".        
DEF VAR nv_LeasingNo    AS CHAR FORMAT "X(25)".        
DEF VAR nv_covcod       AS CHAR FORMAT "X(5)" . 
DEF VAR nv_prem         AS DECI FORMAT "->>>,>>9.99".
DEF VAR nv_sInc         AS DECI FORMAT "->>,>>9.99".    

DEF VAR nv_DataDate     AS CHAR FORMAT "X(10)".            
DEF VAR nv_NUMBER       AS CHAR FORMAT "x(15)".            
DEF VAR nv_CompCode     AS CHAR FORMAT "x(3)" .            
DEF VAR nv_BRShort      AS CHAR FORMAT "x(2)" .            
DEF VAR nv_BRName       AS CHAR FORMAT "x(45)".            
DEF VAR nv_Area         AS CHAR FORMAT "x(10)".            
DEF VAR nv_Part         AS CHAR FORMAT "x(25)".            
DEF VAR nv_Customer     AS CHAR FORMAT "X(45)".            
DEF VAR nv_TotalPrm     AS DECI FORMAT "->>,>>9.999999".
DEF VAR nv_Class        AS CHAR FORMAT "X(5)" .            
DEF VAR nv_Regist       AS CHAR FORMAT "X(15)".            
DEF VAR nv_PolicySTY    AS CHAR FORMAT "X(20)".            
DEF VAR nv_BodyNo       AS CHAR FORMAT "X(30)".            
DEF VAR nv_CInsure      AS CHAR FORMAT "X(30)".            
DEF VAR nv_AutoType     AS CHAR FORMAT "X(20)".            
DEF VAR nv_Incentive    AS DECI FORMAT "->>,>>9.99".    


DEF VAR nv_cnt     AS INT.
DEF VAR nv_cntdup  AS INT.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_Query1

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wBill1 wBill2

/* Definitions for BROWSE br_Query1                                     */
&Scoped-define FIELDS-IN-QUERY-br_Query1 wBill1.wSeq wBill1.wAcno wBill1.wPolicy wBill1.wEndno wBill1.wComdat wBill1.wTrnty wBill1.wDocno wBill1.wInsure wBill1.wPrem wBill1.wVehicle wBill1.wChassis wBill1.wLeasingNo wBill1.wcovcod wBill1.wsInc   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Query1   
&Scoped-define SELF-NAME br_Query1
&Scoped-define QUERY-STRING-br_Query1 FOR EACH wBill1 BY wBill1.wSeq
&Scoped-define OPEN-QUERY-br_Query1 OPEN QUERY {&SELF-NAME} FOR EACH wBill1 BY wBill1.wSeq.
&Scoped-define TABLES-IN-QUERY-br_Query1 wBill1
&Scoped-define FIRST-TABLE-IN-QUERY-br_Query1 wBill1


/* Definitions for BROWSE br_Query2                                     */
&Scoped-define FIELDS-IN-QUERY-br_Query2 wBill2.wSeq wBill2.wDataDate wBill2.wPolicySTY wBill2.wRegist wBill2.wBodyNo wBill2.wClass wBill2.wIncentive wBill2.wTotalPrm wBill2.wCustomer wBill2.wNUMBER wBill2.wCompCode wBill2.wBRShort wBill2.wBRName wBill2.wArea wBill2.wPart wBill2.wCInsure wBill2.wAutoType   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Query2   
&Scoped-define SELF-NAME br_Query2
&Scoped-define QUERY-STRING-br_Query2 FOR EACH wBill2  BY wBill2.wSeq
&Scoped-define OPEN-QUERY-br_Query2 OPEN QUERY {&SELF-NAME} FOR EACH wBill2  BY wBill2.wSeq.
&Scoped-define TABLES-IN-QUERY-br_Query2 wBill2
&Scoped-define FIRST-TABLE-IN-QUERY-br_Query2 wBill2


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_Query1}~
    ~{&OPEN-QUERY-br_Query2}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_Query1 fiFile-Nameinput bu_file Btn_Match ~
Btn_Exit bu_ok1 fiFile-Nameinput2 bu_file-2 bu_ok-2 RECT-5 RECT-6 RECT-7 ~
RECT-8 RECT-3 RECT-615 RECT-616 br_Query2 
&Scoped-Define DISPLAYED-OBJECTS fiFile-Nameinput fiFile-Nameinput2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Exit AUTO-END-KEY 
     LABEL "Exit" 
     SIZE 10 BY 1
     BGCOLOR 8 FONT 2.

DEFINE BUTTON Btn_Match AUTO-GO 
     LABEL "Match File" 
     SIZE 16.17 BY 1
     BGCOLOR 8 FONT 2.

DEFINE BUTTON bu_file 
     LABEL "...." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_file-2 
     LABEL "...." 
     SIZE 3.5 BY 1.

DEFINE BUTTON bu_ok-2 AUTO-GO 
     LABEL "OK" 
     SIZE 10.5 BY 1
     BGCOLOR 8 FONT 2.

DEFINE BUTTON bu_ok1 AUTO-GO 
     LABEL "OK" 
     SIZE 10.5 BY 1
     BGCOLOR 8 FONT 2.

DEFINE VARIABLE fiFile-Nameinput AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Nameinput2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 58.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21 BY 1.57
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 5 GRAPHIC-EDGE    
     SIZE 132.5 BY 22
     BGCOLOR 173 FGCOLOR 0 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.5 BY 1.67
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-615
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 19.76
     BGCOLOR 14 .

DEFINE RECTANGLE RECT-616
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18.5 BY 1.52
     BGCOLOR 2 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 12.67 BY 1.52
     BGCOLOR 155 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.57
     BGCOLOR 19 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_Query1 FOR 
      wBill1 SCROLLING.

DEFINE QUERY br_Query2 FOR 
      wBill2 SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_Query1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Query1 C-Win _FREEFORM
  QUERY br_Query1 DISPLAY
      wBill1.wSeq        COLUMN-LABEL "Seq.No"      FORMAT ">>>9"
wBill1.wAcno       COLUMN-LABEL "Acno"        FORMAT "x(10)"
wBill1.wPolicy     COLUMN-LABEL "Policy No"   FORMAT "x(15)"
wBill1.wEndno      COLUMN-LABEL "Endors. No"  FORMAT "x(10)"
wBill1.wComdat     COLUMN-LABEL "Com.Date"    FORMAT "x(12)"
wBill1.wTrnty      COLUMN-LABEL "Type"        FORMAT "x(4)"
wBill1.wDocno      COLUMN-LABEL "Doc. No"     FORMAT "x(10)"
wBill1.wInsure     COLUMN-LABEL "Insure Name" FORMAT "x(35)"
wBill1.wPrem       COLUMN-LABEL "Premium"     FORMAT "->>,>>9.99"
wBill1.wVehicle    COLUMN-LABEL "Vehicle"     FORMAT "x(15)"
wBill1.wChassis    COLUMN-LABEL "Chassis"     FORMAT "x(25)" 
wBill1.wLeasingNo  COLUMN-LABEL "Leasing No"  FORMAT "x(15)"
wBill1.wcovcod     COLUMN-LABEL "Cov.Code"    FORMAT "x(8)"
wBill1.wsInc       COLUMN-LABEL "Incentive"   FORMAT "->>9"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 8.1
         FGCOLOR 14  ROW-HEIGHT-CHARS .52.

DEFINE BROWSE br_Query2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Query2 C-Win _FREEFORM
  QUERY br_Query2 DISPLAY
      wBill2.wSeq       COLUMN-LABEL "Seq.No"        FORMAT ">>>9"
wBill2.wDataDate  COLUMN-LABEL "DATA DATE"     FORMAT "X(10)" 
wBill2.wPolicySTY COLUMN-LABEL "POLICY NO"     FORMAT "X(15)"         
wBill2.wRegist    COLUMN-LABEL "REG."          FORMAT "X(10)"         
wBill2.wBodyNo    COLUMN-LABEL "BODY NO"       FORMAT "X(25)"         
wBill2.wClass     COLUMN-LABEL "CLASS"         FORMAT "X(5)"           
wBill2.wIncentive COLUMN-LABEL "INCENTIVE"     FORMAT "->>,>>9.99"    
wBill2.wTotalPrm  COLUMN-LABEL "PREMIUM"       FORMAT "->>,>>9.999999" 
wBill2.wCustomer  COLUMN-LABEL "CUSTOMER NAME" FORMAT "X(35)"         
wBill2.wNUMBER    COLUMN-LABEL "Re.NUMBER"     FORMAT "x(15)"         
wBill2.wCompCode  COLUMN-LABEL "COMP.CODE"     FORMAT "x(3)"          
wBill2.wBRShort   COLUMN-LABEL "BR.SHORT"      FORMAT "x(2)"          
wBill2.wBRName    COLUMN-LABEL "BR.NAME"       FORMAT "x(45)"         
wBill2.wArea      COLUMN-LABEL "AREA"          FORMAT "x(10)"         
wBill2.wPart      COLUMN-LABEL "PART"          FORMAT "x(25)"         
wBill2.wCInsure   COLUMN-LABEL "INSURER NO"    FORMAT "X(30)"         
wBill2.wAutoType  COLUMN-LABEL "AUTO TYPE"     FORMAT "X(20)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 128 BY 8.1
         BGCOLOR 14 FGCOLOR 1  ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_Query1 AT ROW 4.57 COL 3.5 WIDGET-ID 100
     fiFile-Nameinput AT ROW 3.48 COL 31.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 3.43 COL 92.5
     Btn_Match AT ROW 23.14 COL 3.67
     Btn_Exit AT ROW 23.14 COL 121.33
     bu_ok1 AT ROW 3.43 COL 97.17 WIDGET-ID 14
     fiFile-Nameinput2 AT ROW 13.43 COL 32.5 COLON-ALIGNED NO-LABEL WIDGET-ID 30
     bu_file-2 AT ROW 13.38 COL 93.5 WIDGET-ID 28
     bu_ok-2 AT ROW 13.38 COL 98.17 WIDGET-ID 34
     br_Query2 AT ROW 14.57 COL 4 WIDGET-ID 200
     "** Input file ที่เป็นรูปแบบ  .CSV (Comma delimeted)":100 VIEW-AS TEXT
          SIZE 43.33 BY .62 AT ROW 23.62 COL 75.67 WIDGET-ID 22
          BGCOLOR 7 FGCOLOR 6 
     "1. Input File Statment STY :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 3.48 COL 3.5
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "2. Input File NTL :" VIEW-AS TEXT
          SIZE 29 BY 1 AT ROW 13.43 COL 4.5 WIDGET-ID 32
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "                         Import CSV File File STY and NTL  For Match Chassis" VIEW-AS TEXT
          SIZE 83.5 BY 1 AT ROW 1.29 COL 22.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     RECT-5 AT ROW 2.67 COL 1.17
     RECT-6 AT ROW 5.33 COL 92.83
     RECT-7 AT ROW 22.86 COL 120
     RECT-8 AT ROW 1 COL 1
     RECT-3 AT ROW 5.29 COL 4
     RECT-615 AT ROW 3.14 COL 2.5 WIDGET-ID 4
     RECT-616 AT ROW 22.91 COL 2.5 WIDGET-ID 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
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
         TITLE              = "WACRNTL1 - Import & Match File STY and NTL"
         HEIGHT             = 24
         WIDTH              = 133.17
         MAX-HEIGHT         = 26.67
         MAX-WIDTH          = 153.33
         VIRTUAL-HEIGHT     = 26.67
         VIRTUAL-WIDTH      = 153.33
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
IF NOT C-Win:LOAD-ICON("i:/safety/walp10/wimage/iconhead.ico":U) THEN
    MESSAGE "Unable to load icon: i:/safety/walp10/wimage/iconhead.ico"
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
/* BROWSE-TAB br_Query1 1 fr_main */
/* BROWSE-TAB br_Query2 RECT-616 fr_main */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Query1
/* Query rebuild information for BROWSE br_Query1
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wBill1 BY wBill1.wSeq.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_Query1 */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Query2
/* Query rebuild information for BROWSE br_Query2
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wBill2  BY wBill2.wSeq.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_Query2 */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* WACRNTL1 - Import  Match File STY and NTL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* WACRNTL1 - Import  Match File STY and NTL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Exit C-Win
ON CHOOSE OF Btn_Exit IN FRAME fr_main /* Exit */
DO:
    APPLY "Close" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Match
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Match C-Win
ON CHOOSE OF Btn_Match IN FRAME fr_main /* Match File */
DO:
    DEF VAR nv_cnt1 AS INT.
    DEF VAR nv_cnt2 AS INT.
    DEF VAR nv_cnt3 AS INT.

nv_cnt1  = 0.
nv_cnt2  = 0.  
nv_cnt3  = 0.
    
    OUTPUT STREAM filebill1 TO D:\Temp\UPLOAD-File.txt.
    OUTPUT STREAM filebill2 TO D:\Temp\DELETESTY-File.txt.
    OUTPUT STREAM filebill3 TO D:\Temp\DELETENTL-File.txt.

    PUT STREAM filebill1
        "Producer|Policy|Endno|ComDate|Trn.Type|Docno|Insure|Premium|Vehicle|Chassis|LeasingNo|CovCode|Incentive" SKIP.
    PUT STREAM filebill2
        "Producer|Policy|Endno|ComDate|Trn.Type|Docno|Insure|Premium|Vehicle|Chassis|LeasingNo|CovCode|Incentive" SKIP.
    PUT STREAM filebill3
        "DATA_DATE|REQUEST_NUMBER|INSURANCE_COMPANY_CODE|BR_Short|BR_Name|Area|Part|CUSTOMER_NAME|TOTAL_PREMIUM|class|AUTO_REGISTRATION|POLICY_NO|AUTO_BODY_NO|CONFIRM_INSURER_NO|Auto_Type_Name_Thai|Incentive" SKIP.

    FOR EACH wBill1 USE-INDEX wBill101 BREAK BY wChassis .

        IF wBill1.wAcno <> "B3M0040" AND wBill1.wAcno <> "B3M0047" THEN DO:  /* นอกเหนือจาก 2 code นี้ไม่ต้องนำไป match */

            nv_cnt2 = nv_cnt2 + 1.

            PUT STREAM filebill2
                wBill1.wAcno        FORMAT "x(10)"   "|"
                wBill1.wPolicy      FORMAT "x(15)"   "|"
                wBill1.wEndno       FORMAT "x(10)"   "|"
                wBill1.wComdat      FORMAT "x(12)"   "|"
                wBill1.wTrnty       FORMAT "x(10)"   "|"
                wBill1.wDocno       FORMAT "x(10)"   "|"
                wBill1.wInsure      FORMAT "x(35)"   "|"
                wBill1.wPrem        FORMAT "->>,>>9.99" "|"
                wBill1.wVehicle     FORMAT "x(22)"   "|"
                wBill1.wChassis     FORMAT "x(22)"   "|"
                wBill1.wLeasingNo   FORMAT "x(15)"   "|"
                wBill1.wcovcod      FORMAT "x(8)"    "|"
                wBill1.wsInc        FORMAT "->>9"    SKIP.

            /* put data แล้ว delete ข้อมูลออกจาก Temp */
            DELETE wBill1.
        END.
        ELSE DO:

            FIND LAST wBill2 WHERE wBill2.wBody = wBill1.wChassis NO-ERROR.
            IF AVAIL wBill2 THEN DO:
    
                nv_cnt1 = nv_cnt1 + 1.
    
                PUT STREAM filebill1
                    wBill1.wAcno        FORMAT "x(10)"   "|"
                    wBill1.wPolicy      FORMAT "x(15)"   "|"
                    wBill1.wEndno       FORMAT "x(10)"   "|"
                    wBill1.wComdat      FORMAT "x(12)"   "|"
                    wBill1.wTrnty       FORMAT "x(10)"   "|"
                    wBill1.wDocno       FORMAT "x(10)"   "|"
                    wBill1.wInsure      FORMAT "x(35)"   "|"
                    wBill1.wPrem        FORMAT "->>,>>9.99" "|"
                    wBill1.wVehicle     FORMAT "x(22)"   "|"
                    wBill1.wChassis     FORMAT "x(22)"   "|"
                    wBill1.wLeasingNo   FORMAT "x(15)"   "|"
                    wBill1.wcovcod      FORMAT "x(8)"    "|"
                    wBill1.wsInc        FORMAT "->>9"    SKIP.
        
                /* put data แล้ว delete ข้อมูลออกจาก Temp */
                IF LAST-OF (wBill1.wChassis) THEN DELETE wBill2.  /* กรณี chassis ฝั่ง STY มีหลายเรคคอร์ด จึงต้องเก็บข้อมูลไว้เทียบก่อน */
                DELETE wBill1.
    
            END.
            ELSE DO: /* put แยกไปอีกไฟลื เพื่อใช้ตรวจสอบ */
    
                nv_cnt2 = nv_cnt2 + 1.
                PUT STREAM filebill2
                    wBill1.wAcno        FORMAT "x(10)"   "|"
                    wBill1.wPolicy      FORMAT "x(15)"   "|"
                    wBill1.wEndno       FORMAT "x(10)"   "|"
                    wBill1.wComdat      FORMAT "x(12)"   "|"
                    wBill1.wTrnty       FORMAT "x(10)"   "|"
                    wBill1.wDocno       FORMAT "x(10)"   "|"
                    wBill1.wInsure      FORMAT "x(35)"   "|"
                    wBill1.wPrem        FORMAT "->>,>>9.99" "|"
                    wBill1.wVehicle     FORMAT "x(22)"   "|"
                    wBill1.wChassis     FORMAT "x(22)"   "|"
                    wBill1.wLeasingNo   FORMAT "x(15)"   "|"
                    wBill1.wcovcod      FORMAT "x(8)"    "|"
                    wBill1.wsInc        FORMAT "->>9"    SKIP.
    
                /* put data แล้ว delete ข้อมูลออกจาก Temp */
                DELETE wBill1.
            END.
        END.
    END.

    /* put ข้อมูลฝั่ง NTL ที่มีมากกว่าฝั่ง STY */
    FOR EACH wBill2 USE-INDEX wBill201 BREAK BY wBody.
        FIND LAST wBill1 WHERE wBill1.wChassis = wBill2.wBody NO-ERROR.
        IF AVAIL wBill1 THEN DO:
            DELETE wBill2.
        END.
        ELSE DO:
            nv_cnt3 = nv_cnt3 + 1.

            PUT STREAM filebill3    
                wBill2.wDataDate    FORMAT "X(10)"           "|"
                wBill2.wNUMBER      FORMAT "x(15)"           "|"
                wBill2.wCompCode    FORMAT "x(3)"            "|"
                wBill2.wBRShort     FORMAT "x(2)"            "|"
                wBill2.wBRName      FORMAT "x(45)"           "|"
                wBill2.wArea        FORMAT "x(10)"           "|"
                wBill2.wPart        FORMAT "x(25)"           "|"
                wBill2.wCustomer    FORMAT "X(45)"           "|"
                wBill2.wTotalPrm    FORMAT "->>,>>9.999999"  "|"
                wBill2.wClass       FORMAT "X(5)"            "|"
                wBill2.wRegist      FORMAT "X(15)"           "|"
                wBill2.wPolicySTY   FORMAT "X(20)"           "|"
                wBill2.wBodyNo      FORMAT "X(30)"           "|"
                wBill2.wCInsure     FORMAT "X(30)"           "|"
                wBill2.wAutoType    FORMAT "X(20)"           "|"
                wBill2.wIncentive   FORMAT "->>,>>9.99"        SKIP.

            DELETE wBill2.
        END.

    END.

    OUTPUT STREAM filebill1 CLOSE.
    OUTPUT STREAM filebill2 CLOSE.
    OUTPUT STREAM filebill3 CLOSE.


   OPEN QUERY br_Query1
   FOR EACH wBill1 NO-LOCK BY wBill1.wSeq.

   OPEN QUERY br_Query2
   FOR EACH wBill2 NO-LOCK BY wBill2.wSeq.

   MESSAGE "Match Data Complete" SKIP(1)
           "พบข้อมูลที่ Chassis ตรงกัน : " nv_cnt1 " เรคคอร์ด " SKIP(1)
           "มีข้อมูลเฉพาะฝั่ง STY : " nv_cnt2 " เรคคอร์ด" SKIP(1)
           "มีข้อมูลเฉพาะฝั่ง NTL : " nv_cnt3 " เรคคอร์ด" SKIP(2)
           "Data Export to file : " SKIP(1)
           "D:\Temp\UPLOAD-File.txt    " skip
           "D:\Temp\DELETESTY-File.txt " skip
           "D:\Temp\DELETENTL-File.txt " skip
            VIEW-AS ALERT-BOX INFORMATION.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* .... */
DO:
  DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
     
        SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
            FILTERS 
            "Text .csv" "*.csv" ,
            "Text file" "*"
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.

    IF OKpressed = TRUE THEN DO:
        fiFile-Nameinput  = cvData.
        DISP fiFile-Nameinput WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file-2 C-Win
ON CHOOSE OF bu_file-2 IN FRAME fr_main /* .... */
DO:
  DEFINE VARIABLE cvData     AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed  AS LOGICAL INITIAL TRUE.
     
        SYSTEM-DIALOG GET-FILE cvData
            TITLE      "Choose Data File to Import ..."
            FILTERS 
            "Text .csv" "*.csv" ,
            "Text file" "*"
            MUST-EXIST
            USE-FILENAME
            UPDATE OKpressed.

    IF OKpressed = TRUE THEN DO:
        fiFile-Nameinput2  = cvData.
        DISP fiFile-Nameinput2 WITH FRAME fr_main.     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok-2 C-Win
ON CHOOSE OF bu_ok-2 IN FRAME fr_main /* OK */
DO:

    IF fiFile-Nameinput2 = "" THEN MESSAGE "กรุณาระบุ Path และ File ของบริษัทเงินติดล้อ ที่ต้องการจะนำเข้า" VIEW-AS ALERT-BOX WARNING.
    ELSE DO:

        RUN PD_ImportNLT.

        MESSAGE "Import Data Total : " nv_cnt " record" SKIP(1)
                "Data Duplicate : " nv_cntdup " record" SKIP(1)   VIEW-AS ALERT-BOX INFORMATION.

        OPEN QUERY br_Query2
            FOR EACH wBill2 NO-LOCK BY wBill2.wSeq.
            
    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok1 C-Win
ON CHOOSE OF bu_ok1 IN FRAME fr_main /* OK */
DO:

    IF fiFile-Nameinput = "" THEN MESSAGE "กรุณาระบุ Path และ File Statement STY ที่ต้องการจะนำเข้า" VIEW-AS ALERT-BOX WARNING.
    ELSE DO:

        RUN PD_ImportSTY.
    
        MESSAGE "Import Data Total : " nv_cnt " record" SKIP(1)
                "Data Duplicate : " nv_cntdup " record" SKIP(1) VIEW-AS ALERT-BOX INFORMATION.

        OPEN QUERY br_Query1
            FOR EACH wBill1 NO-LOCK BY wBill1.wSeq.

    END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Nameinput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Nameinput C-Win
ON LEAVE OF fiFile-Nameinput IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiFile-Nameinput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Nameinput C-Win
ON RETURN OF fiFile-Nameinput IN FRAME fr_main
DO:
    fiFile-Nameinput = TRIM(CAPS(INPUT fiFile-Nameinput)).
    DISPLAY fiFile-Nameinput WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Nameinput2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Nameinput2 C-Win
ON LEAVE OF fiFile-Nameinput2 IN FRAME fr_main
DO:
    APPLY "RETURN" TO fiFile-Nameinput2.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Nameinput2 C-Win
ON RETURN OF fiFile-Nameinput2 IN FRAME fr_main
DO:
    fiFile-Nameinput = TRIM(CAPS(INPUT fiFile-Nameinput)).
    DISPLAY fiFile-Nameinput WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_Query1
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
    gv_prgid = "WACRNTL1".
    gv_prog  = "WACRNTL1 - Report Match file Statement STY and NTL".

    RUN  WUT\WUTHEAD (c-win:HANDLE,gv_prgid,gv_prog).
    RUN  WUT\WUTDICEN (c-win:HANDLE).
    /*********************************************************************/
    
    SESSION:DATA-ENTRY-RETURN = YES.
    SESSION:DATE-FORMAT  = "DMY".
    
    RECT-3:MOVE-TO-TOP( ).

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
  DISPLAY fiFile-Nameinput fiFile-Nameinput2 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_Query1 fiFile-Nameinput bu_file Btn_Match Btn_Exit bu_ok1 
         fiFile-Nameinput2 bu_file-2 bu_ok-2 RECT-5 RECT-6 RECT-7 RECT-8 RECT-3 
         RECT-615 RECT-616 br_Query2 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_ImportNLT C-Win 
PROCEDURE PD_ImportNLT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cntdup = 0.
nv_cnt = 0.

    FOR EACH wBill2. DELETE wBill2. END. 

    INPUT FROM VALUE (fiFile-Nameinput2) .                                   
    REPEAT: 
        IMPORT DELIMITER ","
            nv_DataDate   
            nv_NUMBER     
            nv_CompCode   
            nv_BRShort    
            nv_BRName     
            nv_Area       
            nv_Part       
            nv_Customer   
            nv_TotalPrm             
            nv_Class      
            nv_Regist     
            nv_PolicySTY  
            nv_BodyNo     
            nv_CInsure    
            nv_AutoType   
            nv_Incentive  .

        FIND LAST wBill2 WHERE wBill2.wBodyNo = nv_BodyNo NO-LOCK NO-ERROR.
        IF NOT AVAIL wBill2 THEN DO:

            nv_cnt = nv_cnt + 1.

            CREATE wBill2.
            ASSIGN 
              wBill2.wSeq        =  nv_cnt
              wBill2.wDataDate   =  nv_DataDate  
              wBill2.wNUMBER     =  nv_NUMBER    
              wBill2.wCompCode   =  nv_CompCode  
              wBill2.wBRShort    =  nv_BRShort   
              wBill2.wBRName     =  nv_BRName    
              wBill2.wArea       =  nv_Area      
              wBill2.wPart       =  nv_Part      
              wBill2.wCustomer   =  nv_Customer  
              wBill2.wTotalPrm   =  nv_TotalPrm  
              wBill2.wClass      =  nv_Class     
              wBill2.wRegist     =  nv_Regist    
              wBill2.wPolicySTY  =  nv_PolicySTY 
              wBill2.wBodyNo     =  nv_BodyNo    
              wBill2.wCInsure    =  nv_CInsure   
              wBill2.wAutoType   =  nv_AutoType  
              wBill2.wIncentive  =  nv_Incentive 
              .
        END.                                                    
        ELSE DO: nv_cntdup = nv_cntdup + 1. NEXT . END.

        ASSIGN
            nv_DataDate  = ""
            nv_NUMBER    = ""
            nv_CompCode  = ""
            nv_BRShort   = ""
            nv_BRName    = ""
            nv_Area      = ""
            nv_Part      = ""
            nv_Customer  = ""
            nv_TotalPrm  = 0
            nv_Class     = ""
            nv_Regist    = ""
            nv_PolicySTY = ""
            nv_BodyNo    = ""
            nv_CInsure   = ""
            nv_AutoType  = ""
            nv_Incentive = 0.


    END.  /* repeat  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_ImportSTY C-Win 
PROCEDURE PD_ImportSTY :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_Inc AS INT.
nv_Inc    = 0.
nv_cntdup = 0.
nv_cnt    = 0.

    FOR EACH wBill1. DELETE wBill1. END. 

    INPUT FROM VALUE (fiFile-Nameinput) .                                   
    REPEAT: 
        IMPORT DELIMITER ","
            nv_Acno                      
            nv_Policy     
            nv_Endno    
            nv_Comdat   
            nv_Trnty    
            nv_Docno    
            nv_Insure   
            nv_prem
            nv_Vehicle  
            nv_Chassis   
            nv_LeasingNo  
            nv_covcod    .

        FIND LAST wBill1 WHERE wBill1.wPolicy = nv_Policy 
                         AND   wBill1.wEndno  = nv_Endno
                         AND   wBill1.wTrnty  = nv_Trnty 
                         AND   wBill1.wDocno  = nv_Docno NO-LOCK NO-ERROR.  
        IF NOT AVAIL wBill1 THEN DO:

            nv_Inc = 0.

                 IF nv_covcod = "3"   THEN  nv_Inc = 200.
            ELSE IF nv_covcod = "3.2" THEN  nv_Inc = 300.
            ELSE IF nv_covcod = "2" OR nv_covcod = "2.2" THEN  nv_Inc = 500.

            IF nv_Trnty BEGINS "R" THEN nv_Inc = nv_Inc * -1.
        
            nv_cnt = nv_cnt + 1.
    
              CREATE wBill1.
              ASSIGN 
                wBill1.wSeq       = nv_cnt
                wBill1.wAcno      = nv_Acno     
                wBill1.wPolicy    = nv_Policy   
                wBill1.wEndno     = nv_Endno    
                wBill1.wComdat    = nv_Comdat   
                wBill1.wTrnty     = nv_Trnty    
                wBill1.wDocno     = nv_Docno    
                wBill1.wInsure    = nv_Insure   
                wBill1.wPrem      = nv_prem
                wBill1.wVehicle   = nv_Vehicle  
                wBill1.wChassis   = nv_Chassis  
                wBill1.wLeasingNo = nv_LeasingNo
                wBill1.wcovcod    = nv_covcod 
                wBill1.wsInc      = nv_Inc .  
        END.
        ELSE DO : nv_cntdup = nv_cntdup + 1. NEXT . END.

        ASSIGN
            nv_Acno      = ""
            nv_Policy    = ""
            nv_Endno     = ""
            nv_Comdat    = ""
            nv_Trnty     = ""
            nv_Docno     = ""
            nv_Insure    = ""
            nv_Vehicle   = ""
            nv_Chassis   = ""
            nv_LeasingNo = ""
            nv_covcod    = ""
            nv_prem      = 0.

    END.  /* repeat  */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

