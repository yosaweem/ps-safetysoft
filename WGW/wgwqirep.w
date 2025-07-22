&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          buint            PROGRESS
*/
&Scoped-define WINDOW-NAME wgwqirep
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwqirep 
/*************************************************************************
 wgwqirep   : Send  Data  (Job Queue) Back To LockTon
 Copyright  : Safety Insurance Public Company Limited
              บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 ------------------------------------------------------------------------                 
 Database   : BUINT
 ------------------------------------------------------------------------                
 CREATE BY  : Watsana K.   ASSIGN: A56-0299       DATE: 15/10/2013
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

DEF SHARED VAR nv_user     AS CHARACTER.
DEF SHARED VAR nv_error    AS CHARACTER.

/* Local Variable Definitions ---                                       */
Def    var  nv_rectlt    as recid  init  0.
DEFINE VARIABLE nv_search         AS INTEGER                  NO-UNDO.
DEFINE VARIABLE nv_sort           AS INTEGER                  NO-UNDO.
DEFINE VARIABLE my-datetime       AS CHARACTER FORMAT "X(23)" NO-UNDO. 
DEFINE VARIABLE nv_seqno          AS INTEGER                  NO-UNDO.
DEFINE VARIABLE nv_SelectStatus   AS CHARACTER                NO-UNDO.
DEFINE VARIABLE nv_ProcessStatus  AS CHARACTER                NO-UNDO.
DEFINE VARIABLE nv_ZProcessStatus AS CHARACTER                NO-UNDO.
DEFINE STREAM  ns2.

/* ---------------------- */
/* -------------------------------------------------------------------- */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME br_Browse

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES IntPolicy

/* Definitions for BROWSE br_Browse                                     */
&Scoped-define FIELDS-IN-QUERY-br_Browse IntPolicy.TrnFromIntDate ~
IntPolicy.GenPolicyText IntPolicy.ProcessStatus IntPolicy.CompanyCode ~
IntPolicy.PolicyNumber IntPolicy.StickerNumber IntPolicy.ContractNumber ~
IntPolicy.EffectiveDt IntPolicy.VehicleTypeCode IntPolicy.ChassisVINNumber ~
IntPolicy.EngineSerialNumber IntPolicy.Model IntPolicy.InsuredUniqueID ~
IntPolicy.InsuredTitle IntPolicy.InsuredName IntPolicy.InsuredSurname ~
IntPolicy.GenPolicyDt IntPolicy.GenPolicy IntPolicy.GenPolicyTime 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_Browse 
&Scoped-define QUERY-STRING-br_Browse FOR EACH IntPolicy ~
      WHERE IntPolicy.CompanyCode = "LOCKTON" ~
 AND IntPolicy.ProcessStatus = "X" NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_Browse OPEN QUERY br_Browse FOR EACH IntPolicy ~
      WHERE IntPolicy.CompanyCode = "LOCKTON" ~
 AND IntPolicy.ProcessStatus = "X" NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_Browse IntPolicy
&Scoped-define FIRST-TABLE-IN-QUERY-br_Browse IntPolicy


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-br_Browse}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_Fromcompany cb_Search fi_From fi_To ~
fi_DateFrom fi_DateTo buOK br_Browse fi_output bu_exp buCANCEL RECT-379 ~
RECT-380 
&Scoped-Define DISPLAYED-OBJECTS fi_Fromcompany cb_Search fi_From fi_To ~
fi_DateFrom fi_DateTo fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwqirep AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buCANCEL 
     LABEL "Cancel" 
     SIZE 12 BY 1.29
     BGCOLOR 27 FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 12 BY 1.29
     BGCOLOR 27 FONT 6.

DEFINE BUTTON bu_exp 
     LABEL "EXPORT" 
     SIZE 10.5 BY 1.19
     BGCOLOR 27 FONT 6.

DEFINE VARIABLE cb_Search AS CHARACTER FORMAT "X(256)":U 
     LABEL "เลือกรายการค้นหา" 
     VIEW-AS COMBO-BOX INNER-LINES 2
     LIST-ITEMS "Policy Number","Transfer Date" 
     DROP-DOWN-LIST
     SIZE 30 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_DateFrom AS DATE FORMAT "99/99/9999":U 
     LABEL "วันที่ เริ่มต้นจาก" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_DateTo AS DATE FORMAT "99/99/9999":U 
     LABEL " ถึงวันที่ สิ้นสุด" 
     VIEW-AS FILL-IN 
     SIZE 14 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_From AS CHARACTER FORMAT "X(25)":U 
     LABEL "ระบุข้อมูล เริ่มต้นจาก" 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Fromcompany AS CHARACTER FORMAT "X(25)":U 
     LABEL "ค้นข้อมูล" 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(100)":U 
     LABEL "  รายงานข้อมูล" 
     VIEW-AS FILL-IN 
     SIZE 58 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_To AS CHARACTER FORMAT "X(25)":U 
     LABEL "ถึงข้อมูล สิ้นสุด" 
     VIEW-AS FILL-IN 
     SIZE 30 BY .91
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.38
     BGCOLOR 28 .

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 6.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 90.5 BY 1.52
     BGCOLOR 28 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_Browse FOR 
      IntPolicy SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_Browse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_Browse wgwqirep _STRUCTURED
  QUERY br_Browse NO-LOCK DISPLAY
      IntPolicy.TrnFromIntDate FORMAT "99/99/9999":U
      IntPolicy.GenPolicyText FORMAT "x(50)":U WIDTH 31.33
      IntPolicy.ProcessStatus FORMAT "x(2)":U WIDTH 11
      IntPolicy.CompanyCode FORMAT "x(10)":U WIDTH 12
      IntPolicy.PolicyNumber FORMAT "x(12)":U WIDTH 14
      IntPolicy.StickerNumber FORMAT "x(15)":U
      IntPolicy.ContractNumber FORMAT "x(20)":U WIDTH 16
      IntPolicy.EffectiveDt FORMAT "x(10)":U
      IntPolicy.VehicleTypeCode FORMAT "x(11)":U WIDTH 14
      IntPolicy.ChassisVINNumber FORMAT "x(25)":U
      IntPolicy.EngineSerialNumber FORMAT "x(25)":U
      IntPolicy.Model FORMAT "x(50)":U
      IntPolicy.InsuredUniqueID FORMAT "x(15)":U
      IntPolicy.InsuredTitle FORMAT "x(15)":U
      IntPolicy.InsuredName FORMAT "x(35)":U
      IntPolicy.InsuredSurname FORMAT "x(35)":U
      IntPolicy.GenPolicyDt FORMAT "99/99/9999":U
      IntPolicy.GenPolicy FORMAT "yes/no":U
      IntPolicy.GenPolicyTime FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 132 BY 15.95
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     fi_Fromcompany AT ROW 2.52 COL 24.5 COLON-ALIGNED
     cb_Search AT ROW 3.57 COL 24.5 COLON-ALIGNED
     fi_From AT ROW 4.71 COL 24.5 COLON-ALIGNED
     fi_To AT ROW 4.71 COL 67.67 COLON-ALIGNED
     fi_DateFrom AT ROW 5.81 COL 24.5 COLON-ALIGNED
     fi_DateTo AT ROW 5.81 COL 67.67 COLON-ALIGNED
     buOK AT ROW 3.48 COL 116.5
     br_Browse AT ROW 8.91 COL 1.5
     fi_output AT ROW 7.19 COL 24.5 COLON-ALIGNED
     bu_exp AT ROW 7.1 COL 86.5
     buCANCEL AT ROW 5 COL 116.5
     "  Send  Data  (Job Queue) Back To LockTon" VIEW-AS TEXT
          SIZE 52 BY 1.19 AT ROW 1.05 COL 36.67
          BGCOLOR 28 FGCOLOR 0 FONT 23
     RECT-2 AT ROW 1 COL 1
     RECT-379 AT ROW 2.33 COL 1
     RECT-380 AT ROW 6.91 COL 9
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 8  DROP-TARGET.


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
  CREATE WINDOW wgwqirep ASSIGN
         HIDDEN             = YES
         TITLE              = "Safety Insurance Public Company Limited"
         HEIGHT             = 24.05
         WIDTH              = 133.17
         MAX-HEIGHT         = 44.48
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 44.48
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
IF NOT wgwqirep:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwqirep
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_Browse buOK DEFAULT-FRAME */
ASSIGN 
       br_Browse:SEPARATOR-FGCOLOR IN FRAME DEFAULT-FRAME      = 0.

/* SETTINGS FOR RECTANGLE RECT-2 IN FRAME DEFAULT-FRAME
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwqirep)
THEN wgwqirep:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_Browse
/* Query rebuild information for BROWSE br_Browse
     _TblList          = "buint.IntPolicy"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Where[1]         = "buint.IntPolicy.CompanyCode = ""LOCKTON""
 AND buint.IntPolicy.ProcessStatus = ""X"""
     _FldNameList[1]   = buint.IntPolicy.TrnFromIntDate
     _FldNameList[2]   > buint.IntPolicy.GenPolicyText
"IntPolicy.GenPolicyText" ? ? "character" ? ? ? ? ? ? no ? no no "31.33" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > buint.IntPolicy.ProcessStatus
"IntPolicy.ProcessStatus" ? "x(2)" "character" ? ? ? ? ? ? no ? no no "11" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > buint.IntPolicy.CompanyCode
"IntPolicy.CompanyCode" ? ? "character" ? ? ? ? ? ? no ? no no "12" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > buint.IntPolicy.PolicyNumber
"IntPolicy.PolicyNumber" ? "x(12)" "character" ? ? ? ? ? ? no ? no no "14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   > buint.IntPolicy.StickerNumber
"IntPolicy.StickerNumber" ? "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[7]   > buint.IntPolicy.ContractNumber
"IntPolicy.ContractNumber" ? ? "character" ? ? ? ? ? ? no ? no no "16" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[8]   > buint.IntPolicy.EffectiveDt
"IntPolicy.EffectiveDt" ? "x(10)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[9]   > buint.IntPolicy.VehicleTypeCode
"IntPolicy.VehicleTypeCode" ? "x(11)" "character" ? ? ? ? ? ? no ? no no "14" yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[10]   > buint.IntPolicy.ChassisVINNumber
"IntPolicy.ChassisVINNumber" ? "x(25)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[11]   > buint.IntPolicy.EngineSerialNumber
"IntPolicy.EngineSerialNumber" ? "x(25)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[12]   = buint.IntPolicy.Model
     _FldNameList[13]   > buint.IntPolicy.InsuredUniqueID
"IntPolicy.InsuredUniqueID" ? "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[14]   = buint.IntPolicy.InsuredTitle
     _FldNameList[15]   > buint.IntPolicy.InsuredName
"IntPolicy.InsuredName" ? "x(35)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[16]   > buint.IntPolicy.InsuredSurname
"IntPolicy.InsuredSurname" ? "x(35)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[17]   = buint.IntPolicy.GenPolicyDt
     _FldNameList[18]   = buint.IntPolicy.GenPolicy
     _FldNameList[19]   = buint.IntPolicy.GenPolicyTime
     _Query            is OPENED
*/  /* BROWSE br_Browse */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwqirep
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwqirep wgwqirep
ON END-ERROR OF wgwqirep /* Safety Insurance Public Company Limited */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwqirep wgwqirep
ON WINDOW-CLOSE OF wgwqirep /* Safety Insurance Public Company Limited */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buCANCEL
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCANCEL wgwqirep
ON CHOOSE OF buCANCEL IN FRAME DEFAULT-FRAME /* Cancel */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.  /* ปิดโปรแกรม */
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK wgwqirep
ON CHOOSE OF buOK IN FRAME DEFAULT-FRAME /* OK */
DO:
    ASSIGN
        fi_From     = INPUT fi_From
        fi_To       = INPUT fi_To
        fi_DateFrom = INPUT fi_DateFrom
        fi_DateTo   = INPUT fi_DateTo   .
    DISPLAY  fi_From  fi_To  fi_DateFrom  fi_DateTo  /*fi_notfound  fi_count*/
        WITH FRAME DEFAULT-FRAME.  
    /* ---------------------------------------- */
    IF nv_Search  = 1 THEN DO:
        IF (fi_From = "" AND fi_To = "") /*OR (fi_DateFrom = ? AND fi_DateTo = ?)*/  THEN DO:
            MESSAGE " โปรดระบุ ข้อมูลที่ใช้ค้นหา" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_From.
            RETURN NO-APPLY.
        END.
        Open Query br_Browse 
        For each buint.intpolicy  NO-LOCK  Where
            buint.IntPolicy.PolicyNumber  >= fi_From   AND
            buint.IntPolicy.PolicyNumber  <= fi_To     AND  
            buint.IntPolicy.CompanyCode    = fi_Fromcompany AND   
            buint.intPolicy.ProcessStatus  = "X"      
            BY buint.IntPolicy.PolicyNumber.
            /*nv_rectlt =  recid(buint.intpolicy). */
            Apply "Entry"  to br_Browse.
            Return no-apply.  
    END.
    IF nv_Search = 2  THEN DO:
        IF fi_DateFrom = ? THEN DO:
            MESSAGE " โปรดระบุ วันที่เริ่มต้นจาก"  VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateFrom.
            RETURN NO-APPLY.
        END.
        IF fi_DateTo = ? THEN DO:
            MESSAGE " โปรดระบุ ถึงวันที่สิ้นสุด" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateTo.
            RETURN NO-APPLY.
        END.
        IF fi_DateFrom > fi_DateTo THEN DO:
            MESSAGE " วันที่เริ่มต้น มากกว่า วันที่สิ้นสุด"  " โปรดระบุใหม่"  VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateFrom.
            RETURN NO-APPLY.
        END.
        Open Query br_Browse 
        For each buint.intpolicy NO-LOCK   Where
            buint.IntPolicy.TrnFromIntDate  >= fi_DateFrom  AND 
            buint.IntPolicy.TrnFromIntDate  <= fi_DateTo    AND 
            buint.IntPolicy.CompanyCode      = fi_Fromcompany   AND   
            buint.intPolicy.ProcessStatus    = "X"         
            BY buint.IntPolicy.TrnFromIntDate.
            /*nv_rectlt =  recid(buint.intpolicy). */
            Apply "Entry"  to br_Browse.
            Return no-apply. 
    END.
    
    /*IF  nv_Search = 3 THEN DO:
        Open Query br_Browse 
        For each buint.intpolicy    Where
            buint.IntPolicy.CompanyCode      = fi_Fromcompany   AND   
            buint.intPolicy.ProcessStatus    = "X"              no-lock.  
            /*nv_rectlt =  recid(buint.intpolicy). */
            Apply "Entry"  to br_Browse.
            Return no-apply.  
    END.*/
    
    /*{&OPEN-QUERY-br_Browse}*/
        /* */

END. /* DO: */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exp wgwqirep
ON CHOOSE OF bu_exp IN FRAME DEFAULT-FRAME /* EXPORT */
DO:
    IF fi_output = "" THEN DO:
        MESSAGE " โปรดระบุ ไฟล์รายงานที่ต้องการ"   VIEW-AS ALERT-BOX.
        Apply "Entry"  to fi_output.
        Return no-apply.
    END.
    ASSIGN
        fi_From     = INPUT fi_From
        fi_To       = INPUT fi_To
        fi_DateFrom = INPUT fi_DateFrom
        fi_DateTo   = INPUT fi_DateTo .
    DISPLAY  fi_From  fi_To  fi_DateFrom  fi_DateTo   WITH FRAME DEFAULT-FRAME.  
    /* ---------------------------------------- */
    IF nv_Search  = 1 THEN DO:
        IF (fi_From = "" AND fi_To = "")  /*OR (fi_DateFrom = ? AND fi_DateTo = ?)*/  THEN DO:
            MESSAGE " โปรดระบุ ข้อมูลที่ใช้ค้นหา" SKIP(1)
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_From.
            RETURN NO-APPLY.
        END.
        RUN proc_reportpolicy.

    END.
    ELSE IF nv_Search = 2  THEN DO:
        IF fi_DateFrom = ? THEN DO:
            MESSAGE " โปรดระบุ วันที่เริ่มต้นจาก" SKIP(1)  
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateFrom.
            RETURN NO-APPLY.
        END.
        IF fi_DateTo = ? THEN DO:
            MESSAGE " โปรดระบุ ถึงวันที่สิ้นสุด" SKIP(1)  
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateTo.
            RETURN NO-APPLY.
        END.
        IF fi_DateFrom > fi_DateTo THEN DO:
            MESSAGE " วันที่เริ่มต้น มากกว่า วันที่สิ้นสุด" SKIP(1)
                " โปรดระบุใหม่"
                VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_DateFrom.
            RETURN NO-APPLY.
        END.
        RUN proc_reporttrandat.
    END.
    /*ELSE IF  nv_Search = 3 THEN RUN proc_reportlockton.*/
    MESSAGE "Export file Complete" VIEW-AS ALERT-BOX.
  /*  Apply "Entry"  to br_Browse.
    Return no-apply.  */
    /* --------------------------------------------------- */
    /*{&OPEN-QUERY-br_Browse}*/
        /* */

END. /* DO: */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_Search
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_Search wgwqirep
ON VALUE-CHANGED OF cb_Search IN FRAME DEFAULT-FRAME /* เลือกรายการค้นหา */
DO:
    nv_Search = 0.
    cb_Search = INPUT cb_Search.
    IF      cb_Search = "Policy Number"    THEN nv_Search = 1.
    ELSE IF cb_Search = "Transfer Date"    THEN nv_Search = 2.
    /*ELSE IF cb_Search = "Company Code"     THEN nv_Search = 3.*/
    ELSE DO:
        ASSIGN 
            cb_Search = "Policy Number" 
            nv_Search = 1.
    END.
    DISPLAY cb_Search WITH FRAME DEFAULT-FRAME.
    /* -- */
    IF nv_Search = 0 THEN DO:
        MESSAGE " Please Check error Search list (cb_Search)" SKIP(1)
            nv_Search cb_Search
            VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO cb_Search.
        RETURN NO-APPLY.
    END.
    IF nv_Search  = 1    THEN DO:
        /*
        fi_DateFrom = ?.
        fi_DateTo   = ?.
        */
        ASSIGN 
            fi_From     = "" 
            fi_To       = "" 
            fi_DateFrom =  ?  
            fi_DateTo   =  ?. 
        ENABLE  fi_From          fi_To        WITH FRAME DEFAULT-FRAME.
        /*DISPLAY fi_From fi_To  /*fi_DateFrom fi_DateTo*/ WITH FRAME DEFAULT-FRAME.*/
        DISABLE  /*fi_From fi_To*/ fi_DateFrom fi_DateTo WITH FRAME DEFAULT-FRAME. 
        DISPLAY fi_From fi_To fi_DateFrom fi_DateTo  WITH FRAME DEFAULT-FRAME.
        APPLY "ENTRY" TO fi_From.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        IF nv_Search  = 2 THEN DO:
            ASSIGN 
            fi_From     = "" 
            fi_To       = "" 
            fi_DateFrom = TODAY 
            fi_DateTo   = TODAY.
            ENABLE   fi_DateFrom fi_DateTo WITH FRAME DEFAULT-FRAME.
            /*DISPLAY fi_DateFrom      fi_DateTo  /*fi_From          fi_To*/          WITH FRAME DEFAULT-FRAME.*/
            DISABLE  fi_From fi_To         WITH FRAME DEFAULT-FRAME. 
            DISPLAY  fi_DateFrom fi_DateTo fi_From fi_To  WITH FRAME DEFAULT-FRAME.
            
            /*DISPLAY fi_From fi_To fi_DateFrom fi_DateTo WITH FRAME DEFAULT-FRAME.
            DISABLE    fi_From        fi_To             WITH FRAME DEFAULT-FRAME.
            ENABLE     fi_DateFrom    fi_DateTo         WITH FRAME DEFAULT-FRAME.*/
            APPLY "ENTRY" TO fi_DateFrom.
            RETURN NO-APPLY.
        END.
    END.
    /*IF   nv_Search = 3  THEN DO:
        /*
        fi_DateFrom = ?.
        fi_DateTo   = ?.
        */
        fi_From     = "".
        fi_To       = "".
        fi_DateFrom = TODAY.
        fi_DateTo   = TODAY.
        DISPLAY fi_From fi_To fi_DateFrom fi_DateTo WITH FRAME DEFAULT-FRAME.
        ENABLE  fi_DateFrom      fi_DateTo
            fi_From          fi_To          WITH FRAME DEFAULT-FRAME.
        APPLY "ENTRY" TO fi_From.
        RETURN NO-APPLY.
    END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_Fromcompany
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_Fromcompany wgwqirep
ON LEAVE OF fi_Fromcompany IN FRAME DEFAULT-FRAME /* ค้นข้อมูล */
DO:
  fi_Fromcompany = INPUT fi_Fromcompany.
  DISP fi_Fromcompany WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output wgwqirep
ON LEAVE OF fi_output IN FRAME DEFAULT-FRAME /*   รายงานข้อมูล */
DO:
    fi_output = INPUT fi_output .
    DISP fi_output WITH FRAM DEFAULT-FRAME.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_Browse
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwqirep 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
    THIS-PROCEDURE:CURRENT-WINDOW    = {&WINDOW-NAME}.
/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
    RUN disable_UI.
/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.
/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
/* --- */

CLEAR  ALL     NO-PAUSE.
STATUS INPUT   OFF.
HIDE   MESSAGE NO-PAUSE.
/* --- */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
    ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
    /********************  T I T L E   F O R  C - W I N  ****************/
    DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"  NO-UNDO.
    DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
    gv_prgid = "wgwqirep".
    gv_prog  = " Send  Data  (Job Queue) Back To LockTon".
 
    RUN  wgw\wgwHDExt (wgwqirep:handle,gv_prgid,gv_prog).
    RUN  WUT\WUTWICEN (wgwqirep:handle).   
    /*********************************************************************/
    /* */
    SESSION:DATA-ENTRY-RETURN = YES.      /* รับค่าปุ่ม ENTER */
    ASSIGN 
        fi_Fromcompany = "LOCKTON"
        cb_Search = "Policy Number" 
        nv_Search = 1 
          .
    RUN enable_UI.
 
    DISABLE fi_DateFrom fi_DateTo WITH FRAME DEFAULT-FRAME. 
    DISPLAY fi_From fi_To  WITH FRAME DEFAULT-FRAME.
    
    /* */
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* ----------------------------------------------------------------- */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwqirep  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwqirep)
  THEN DELETE WIDGET wgwqirep.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwqirep  _DEFAULT-ENABLE
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
  DISPLAY fi_Fromcompany cb_Search fi_From fi_To fi_DateFrom fi_DateTo fi_output 
      WITH FRAME DEFAULT-FRAME IN WINDOW wgwqirep.
  ENABLE fi_Fromcompany cb_Search fi_From fi_To fi_DateFrom fi_DateTo buOK 
         br_Browse fi_output bu_exp buCANCEL RECT-379 RECT-380 
      WITH FRAME DEFAULT-FRAME IN WINDOW wgwqirep.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW wgwqirep.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportlockton wgwqirep 
PROCEDURE proc_reportlockton :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_output,length(fi_output) - 3,4) <>  ".slk"  THEN 
    fi_output  =  Trim(fi_output) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_output).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "NO"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับข้อมูล         "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "เวลาที่รับข้อมูล        "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "InsuranceCd             "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "PolicyNumber            "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "BarCodeNumber           "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "ContractNumber          "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "EffectiveDt             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "PlateNumber             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "VehicleTypeCode         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Manufacturer            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Model                   "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ModelTypeName           "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Colour                  "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ModelYear               "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "Displacement            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "GrossVehOrCombinedWeight"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "SeatingCapacity         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "ChassisVINNumber        "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "EngineSerialNumber      "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "InsuredType             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "InsuredUniqueID         "       '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "InsuredTitle            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "InsuredName             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "InsuredSurname          "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "Addr                    "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "WrittenAmt              "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "RevenueStampAmt         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "VatAmt                  "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "ShowroomID              "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "ShowroomName            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "RemarkText              "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ReceiptName             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ReceiptAddr             "       '"' SKIP. 

For each buint.intpolicy  no-lock
    WHERE 
    buint.IntPolicy.CompanyCode         = "LOCKTON" AND   
    buint.intPolicy.ProcessStatus       = "X"       
    BY buint.intpolicy.PolicyNumber . 
    
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  n_record                           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  intpolicy.TrnFromIntDate           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  IntPolicy.TrnFromIntTime           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  intpolicy.InsuranceCd              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  IntPolicy.PolicyNumber             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  IntPolicy.StickerNumber            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  intPolicy.ContractNumber           '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  IntPolicy.EffectiveDt              '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  IntPolicy.PlateNumber              '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  intPolicy.VehicleTypeCode          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  IntPolicy.Manufacturer             '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  IntPolicy.Model                    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  intPolicy.ModelTypeName            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  IntPolicy.Colour                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  IntPolicy.ModelYear                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  intPolicy.Displacement             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  IntPolicy.GrossVehOrCombinedWeight '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  IntPolicy.SeatingCapacity          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  intPolicy.ChassisVINNumber         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  IntPolicy.EngineSerialNumber       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  IntPolicy.InsuredType              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  intPolicy.InsuredUniqueID          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  IntPolicy.InsuredTitle             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  IntPolicy.InsuredName              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  intPolicy.InsuredSurname           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  IntPolicy.Addr                     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  IntPolicy.WrittenAmt               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  intPolicy.RevenueStampAmt          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  IntPolicy.VatAmt                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  IntPolicy.ShowroomID               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  intPolicy.ShowroomName             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  IntPolicy.RemarkText               '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  IntPolicy.ReceiptName              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  intPolicy.ReceiptAddr              '"' SKIP. 

     
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reportpolicy wgwqirep 
PROCEDURE proc_reportpolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_output,length(fi_output) - 3,4) <>  ".slk"  THEN 
    fi_output  =  Trim(fi_output) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_output).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "NO"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับข้อมูล         "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "เวลาที่รับข้อมูล        "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "InsuranceCd             "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "PolicyNumber            "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "BarCodeNumber           "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "ContractNumber          "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "EffectiveDt             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "PlateNumber             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "VehicleTypeCode         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Manufacturer            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Model                   "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ModelTypeName           "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Colour                  "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ModelYear               "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "Displacement            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "GrossVehOrCombinedWeight"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "SeatingCapacity         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "ChassisVINNumber        "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "EngineSerialNumber      "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "InsuredType             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "InsuredUniqueID         "       '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "InsuredTitle            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "InsuredName             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "InsuredSurname          "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "Addr                    "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "WrittenAmt              "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "RevenueStampAmt         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "VatAmt                  "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "ShowroomID              "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "ShowroomName            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "RemarkText              "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ReceiptName             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ReceiptAddr             "       '"' SKIP. 

For each buint.intpolicy  no-lock
    WHERE buint.IntPolicy.PolicyNumber >= fi_From   AND
    buint.IntPolicy.PolicyNumber       <= fi_To     AND  
    buint.IntPolicy.CompanyCode         = fi_Fromcompany AND   
    buint.intPolicy.ProcessStatus       = "X"       
    BREAK BY buint.intpolicy.PolicyNumber 
    BY buint.intpolicy.TrnFromIntDate 
    BY buint.IntPolicy.TrnFromIntTime .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  n_record                           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  intpolicy.TrnFromIntDate           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  IntPolicy.TrnFromIntTime           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  intpolicy.InsuranceCd              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  IntPolicy.PolicyNumber             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  IntPolicy.StickerNumber            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  intPolicy.ContractNumber           '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  IntPolicy.EffectiveDt              '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  IntPolicy.PlateNumber              '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  intPolicy.VehicleTypeCode          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  IntPolicy.Manufacturer             '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  IntPolicy.Model                    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  intPolicy.ModelTypeName            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  IntPolicy.Colour                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  IntPolicy.ModelYear                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  intPolicy.Displacement             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  IntPolicy.GrossVehOrCombinedWeight '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  IntPolicy.SeatingCapacity          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  intPolicy.ChassisVINNumber         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  IntPolicy.EngineSerialNumber       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  IntPolicy.InsuredType              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  intPolicy.InsuredUniqueID          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  IntPolicy.InsuredTitle             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  IntPolicy.InsuredName              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  intPolicy.InsuredSurname           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  IntPolicy.Addr                     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  IntPolicy.WrittenAmt               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  intPolicy.RevenueStampAmt          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  IntPolicy.VatAmt                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  IntPolicy.ShowroomID               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  intPolicy.ShowroomName             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  IntPolicy.RemarkText               '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  IntPolicy.ReceiptName              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  intPolicy.ReceiptAddr              '"' SKIP. 
   
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_reporttrandat wgwqirep 
PROCEDURE proc_reporttrandat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR   nv_cnt   as  int  init   1.
DEF VAR   nv_row   as  int  init   0.
DEF VAR   n_record AS  INTE INIT   0.
ASSIGN 
    n_record = 0
    nv_cnt   = 0
    nv_row   = 1  .

If  substr(fi_output,length(fi_output) - 3,4) <>  ".slk"  THEN 
    fi_output  =  Trim(fi_output) + ".slk"  .

ASSIGN nv_cnt =  0
    nv_row    =  1 .

OUTPUT STREAM ns2 TO VALUE(fi_output).
PUT STREAM ns2 "ID;PND" SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"' "NO"                             '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"' "วันที่รับข้อมูล         "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"' "เวลาที่รับข้อมูล        "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"' "InsuranceCd             "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"' "PolicyNumber            "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"' "BarCodeNumber           "       '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"' "ContractNumber          "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"' "EffectiveDt             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"' "PlateNumber             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"' "VehicleTypeCode         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"' "Manufacturer            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"' "Model                   "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"' "ModelTypeName           "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"' "Colour                  "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"' "ModelYear               "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"' "Displacement            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"' "GrossVehOrCombinedWeight"       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"' "SeatingCapacity         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"' "ChassisVINNumber        "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"' "EngineSerialNumber      "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"' "InsuredType             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"' "InsuredUniqueID         "       '"' SKIP.     
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"' "InsuredTitle            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"' "InsuredName             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"' "InsuredSurname          "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"' "Addr                    "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"' "WrittenAmt              "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"' "RevenueStampAmt         "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"' "VatAmt                  "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"' "ShowroomID              "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"' "ShowroomName            "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"' "RemarkText              "       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"' "ReceiptName             "       '"' SKIP.         
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"' "ReceiptAddr             "       '"' SKIP. 

For each buint.intpolicy  NO-LOCK   Where
    buint.IntPolicy.TrnFromIntDate  >= fi_DateFrom AND
    buint.IntPolicy.TrnFromIntDate  <= fi_DateTo   AND 
    buint.IntPolicy.CompanyCode      = fi_Fromcompany   AND   
    buint.intPolicy.ProcessStatus    = "X"         
    BREAK BY buint.IntPolicy.TrnFromIntDate 
    BY buint.IntPolicy.TrnFromIntTime
    BY buint.Intpolicy.policyNumber  .
    ASSIGN 
        n_record =  n_record + 1
        nv_cnt   =  nv_cnt  + 1 
        nv_row   =  nv_row  + 1.
   PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"   '"'  n_record                           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"   '"'  intpolicy.TrnFromIntDate           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"   '"'  IntPolicy.TrnFromIntTime           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"   '"'  intpolicy.InsuranceCd              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"   '"'  IntPolicy.PolicyNumber             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"   '"'  IntPolicy.StickerNumber            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"   '"'  intPolicy.ContractNumber           '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"   '"'  IntPolicy.EffectiveDt              '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"   '"'  IntPolicy.PlateNumber              '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K"  '"'  intPolicy.VehicleTypeCode          '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K"  '"'  IntPolicy.Manufacturer             '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K"  '"'  IntPolicy.Model                    '"' SKIP.         
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K"  '"'  intPolicy.ModelTypeName            '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K"  '"'  IntPolicy.Colour                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K"  '"'  IntPolicy.ModelYear                '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K"  '"'  intPolicy.Displacement             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K"  '"'  IntPolicy.GrossVehOrCombinedWeight '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K"  '"'  IntPolicy.SeatingCapacity          '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K"  '"'  intPolicy.ChassisVINNumber         '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K"  '"'  IntPolicy.EngineSerialNumber       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K"  '"'  IntPolicy.InsuredType              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K"  '"'  intPolicy.InsuredUniqueID          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K"  '"'  IntPolicy.InsuredTitle             '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K"  '"'  IntPolicy.InsuredName              '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K"  '"'  intPolicy.InsuredSurname           '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K"  '"'  IntPolicy.Addr                     '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K"  '"'  IntPolicy.WrittenAmt               '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K"  '"'  intPolicy.RevenueStampAmt          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K"  '"'  IntPolicy.VatAmt                   '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K"  '"'  IntPolicy.ShowroomID               '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K"  '"'  intPolicy.ShowroomName             '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K"  '"'  IntPolicy.RemarkText               '"' SKIP. 
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K"  '"'  IntPolicy.ReceiptName              '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K"  '"'  intPolicy.ReceiptAddr              '"' SKIP. 
END.    /*  end  wdetail  */
nv_row  =  nv_row  + 1. 
PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

