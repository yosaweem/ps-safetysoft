&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME WUWSKBRN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWSKBRN 
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
DEFINE VAR chr_sticker  AS CHAR FORMAT "XXXXXXXXXXXXX".
DEFINE VAR Chr_stk2     AS CHAR FORMAT "X(15)".
DEFINE VAR nv_sck_no    AS CHAR FORMAT "X(13)".
DEFINE VAR nv_count01   AS INT.
DEFINE VAR nv_count02   AS INT.
DEFINE VAR nv_sticker   AS CHAR FORMAT "XXXXXXXXXXXXX".
DEFINE VAR Chr_stk1     AS CHAR FORMAT "X(15)".
DEFINE VAR nv_modulo    AS INT  FORMAT "9".
DEFINE VAR Chk_mod1     AS DECI.
DEFINE VAR Chk_mod2     AS DECI.
DEFINE VAR nv_cnt1      AS INT.
DEFINE VAR nv_cnt2      AS INT.
DEFINE VAR nv_count     AS INTE   INIT   0.
DEFINE VAR nv_cnt01     AS INT.  
DEFINE VAR nv_cnt02     AS INT.
DEFINE VAR nv_status    AS CHAR.
DEFINE VAR nv_coutstk   AS INT. 
DEFINE VAR nv_coutuse   AS INT. 
 
DEFINE WORKFILE wsckyear NO-UNDO   /*--workfile for data sckyear  --*/
       FIELD wscknost    LIKE sckyear.sckno 
       FIELD wscknoen    LIKE sckyear.sckno 
       FIELD wdocst      LIKE sckyear.stat  
       FIELD wdocen      LIKE sckyear.stat 
       FIELD wopndat     LIKE sckyear.opndat  
       FIELD wflag       LIKE sckyear.flag 
       FIELD wacno       LIKE sckyear.acno
       FIELD winuse      AS INTEGER
       FIELD wsumstk     AS INTEGER
       FIELD wloss       AS INTEGER.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_sckyear

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wsckyear

/* Definitions for BROWSE br_sckyear                                    */
&Scoped-define FIELDS-IN-QUERY-br_sckyear wsckyear.wopndat wsckyear.wscknost wsckyear.wscknoen wsckyear.winuse wsckyear.wsumstk   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_sckyear   
&Scoped-define SELF-NAME br_sckyear
&Scoped-define QUERY-STRING-br_sckyear FOR EACH wsckyear NO-LOCK
&Scoped-define OPEN-QUERY-br_sckyear OPEN QUERY {&SELF-NAME} FOR EACH wsckyear NO-LOCK .
&Scoped-define TABLES-IN-QUERY-br_sckyear wsckyear
&Scoped-define FIRST-TABLE-IN-QUERY-br_sckyear wsckyear


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_sckyear}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-1 RECT-2 RECT-5 RECT-11 RECT-10 RECT-12 ~
RECT-17 RECT-18 RECT-6 RECT-7 RECT-8 RECT-694 br_sckyear fi_brn fi_prod ~
Cb_type fi_SckNo_fr fi_SckNo_to fi_Usern fi_remark bu_Save bu_Cancel ~
bu_CheckUse bu_Add bu_Edit bu_Exit fi_Branch fi_User fi_dicbrn fi_disprod ~
fi_distyp fi_RecStr fi_RecEnd fi_RecSum fi_RecUse fi_loss fi_RecTotal 
&Scoped-Define DISPLAYED-OBJECTS fi_brn fi_prod Cb_type fi_SckNo_fr ~
fi_SckNo_to fi_Usern fi_remark fi_Branch fi_User fi_dicbrn fi_disprod ~
fi_distyp fi_RecStr fi_RecEnd fi_RecSum fi_RecUse fi_loss fi_RecTotal 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWSKBRN AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_Add 
     LABEL "เพิ่ม" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE BUTTON bu_Cancel 
     LABEL "ยกเลิก" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE BUTTON bu_CheckUse 
     LABEL "..." 
     SIZE 5.33 BY 1
     FONT 6.

DEFINE BUTTON bu_Edit 
     LABEL "แก้ไข" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE BUTTON bu_Exit 
     LABEL "ออก" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE BUTTON bu_Save 
     LABEL "บันทีก" 
     SIZE 15 BY 1.29
     FONT 6.

DEFINE VARIABLE Cb_type AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "1P","1S","2P","2S","4P","4S" 
     DROP-DOWN-LIST
     SIZE 7.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Branch AS CHARACTER FORMAT "X(150)":U 
      VIEW-AS TEXT 
     SIZE 32 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brn AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 5.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dicbrn AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 28.5 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_disprod AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 27.5 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_distyp AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 25 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loss AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 10.5 BY 1
     BGCOLOR 19 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prod AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RecEnd AS INTEGER FORMAT "9999999":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RecStr AS INTEGER FORMAT "9999999":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RecSum AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 14.5 BY 1
     BGCOLOR 19 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RecTotal AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 10.5 BY 1
     BGCOLOR 19 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_RecUse AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 10.5 BY 1
     BGCOLOR 19 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_SckNo_fr AS DECIMAL FORMAT "9999999999999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_SckNo_to AS DECIMAL FORMAT "9999999999999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18.67 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_User AS CHARACTER FORMAT "X(30)":U 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Usern AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 44.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 1.52
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-10
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.83 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-11
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49 BY 15.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-12
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.83 BY 1.91
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-17
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 23.5 BY 3.1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 49 BY 3.1
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 1.33
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 23.5 BY 15.19
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.83 BY 1.91
     BGCOLOR 4 .

DEFINE RECTANGLE RECT-694
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 2.19
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.83 BY 1.91
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 16.83 BY 1.91
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_sckyear FOR 
      wsckyear SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_sckyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_sckyear WUWSKBRN _FREEFORM
  QUERY br_sckyear NO-LOCK DISPLAY
      wsckyear.wopndat   FORMAT "99/99/9999" COLUMN-LABEL "วันที่เบิก"
wsckyear.wscknost  FORMAT "X(13)"      COLUMN-LABEL "Sticker เริ่มต้น"
wsckyear.wscknoen  FORMAT "X(13)"      COLUMN-LABEL "Sticker สิ้นสุด"
wsckyear.winuse    FORMAT "99999"      COLUMN-LABEL "เอกสารใช้ไป"
wsckyear.wsumstk   FORMAT "99999"      COLUMN-LABEL "เอกสารทั้งหมด"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS DROP-TARGET SIZE 57.67 BY 18.1
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_sckyear AT ROW 3.95 COL 1.83 
     fi_brn AT ROW 4.57 COL 83.17 COLON-ALIGNED NO-LABEL 
     fi_prod AT ROW 6.38 COL 83.17 COLON-ALIGNED NO-LABEL
     Cb_type AT ROW 7.81 COL 83.67 COLON-ALIGNED NO-LABEL
     fi_SckNo_fr AT ROW 9.38 COL 102.83 RIGHT-ALIGNED NO-LABEL 
     fi_SckNo_to AT ROW 10.86 COL 83.17 COLON-ALIGNED NO-LABEL 
     fi_Usern AT ROW 13.86 COL 82.83 COLON-ALIGNED NO-LABEL 
     fi_remark AT ROW 15.38 COL 82.83 COLON-ALIGNED NO-LABEL
     bu_Save AT ROW 17.29 COL 97.17 
     bu_Cancel AT ROW 17.33 COL 114.33 
     bu_CheckUse AT ROW 20.76 COL 100 
     bu_Add AT ROW 22.67 COL 27.17 
     bu_Edit AT ROW 22.67 COL 44 
     bu_Exit AT ROW 22.67 COL 116 
     fi_Branch AT ROW 2.67 COL 10.5 COLON-ALIGNED NO-LABEL
     fi_User AT ROW 2.67 COL 115.5 COLON-ALIGNED NO-LABEL 
     fi_dicbrn AT ROW 4.57 COL 91.5 COLON-ALIGNED NO-LABEL
     fi_disprod AT ROW 6.38 COL 98.83 COLON-ALIGNED NO-LABEL 
     fi_distyp AT ROW 7.81 COL 94 COLON-ALIGNED NO-LABEL 
     fi_RecStr AT ROW 9.38 COL 115.83 COLON-ALIGNED NO-LABEL 
     fi_RecEnd AT ROW 10.86 COL 115.83 COLON-ALIGNED NO-LABEL
     fi_RecSum AT ROW 12.38 COL 83.33 COLON-ALIGNED NO-LABEL 
     fi_RecUse AT ROW 19.57 COL 83 COLON-ALIGNED NO-LABEL 
     fi_loss AT ROW 19.57 COL 116.17 COLON-ALIGNED NO-LABEL 
     fi_RecTotal AT ROW 20.81 COL 82.83 COLON-ALIGNED NO-LABEL 
     "ฉบับ" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 12.29 COL 102.17 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "ประเภทเอกสาร  :" VIEW-AS TEXT
          SIZE 16.67 BY 1 AT ROW 7.91 COL 65.5 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Receipt No :" VIEW-AS TEXT
          SIZE 12.17 BY 1 AT ROW 10.86 COL 104.67 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "หมายเลขเอกสารคงเหลือ :" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 20.71 COL 61 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "สาขา :" VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 2.71 COL 5.17 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "User Name :" VIEW-AS TEXT
          SIZE 11.33 BY 1 AT ROW 13.81 COL 69 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Sticker No. From. :" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 9.33 COL 62.33 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Remark    :" VIEW-AS TEXT
          SIZE 11.17 BY 1 AT ROW 15.38 COL 70.17 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "จำนวนเอกสารทั้งสิ้น  :" VIEW-AS TEXT
          SIZE 19.33 BY 1 AT ROW 12.38 COL 61 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "To  :" VIEW-AS TEXT
          SIZE 4.67 BY 1 AT ROW 10.86 COL 75.83 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "สาขา :" VIEW-AS TEXT
          SIZE 5.67 BY .95 AT ROW 4.57 COL 74.67 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Receipt No :" VIEW-AS TEXT
          SIZE 12.67 BY 1 AT ROW 9.38 COL 104.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132 BY 23.51
         BGCOLOR 1  .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "เอกสารชำรุด/สูญหาย  :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 19.57 COL 96.5 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "คีย์เบิก / จ่าย  Sticker" VIEW-AS TEXT
          SIZE 34 BY 1.19 AT ROW 1.24 COL 53.33 
          BGCOLOR 3 FGCOLOR 7 FONT 17
     "Producer  :" VIEW-AS TEXT
          SIZE 11.33 BY 1 AT ROW 6.33 COL 69.83 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "หมายเลขเอกสารทึ่ใช้ไป  :" VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 19.57 COL 61.33 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-1 AT ROW 1 COL 1.83 
     RECT-2 AT ROW 2.52 COL 1.83 
     RECT-5 AT ROW 3.86 COL 59.83
     RECT-11 AT ROW 3.86 COL 83.33 
     RECT-10 AT ROW 16.95 COL 96.33
     RECT-12 AT ROW 16.95 COL 113.17 
     RECT-17 AT ROW 19.05 COL 59.83 
     RECT-18 AT ROW 19.05 COL 83.33 
     RECT-6 AT ROW 22.33 COL 115 
     RECT-7 AT ROW 22.33 COL 26.33 
     RECT-8 AT ROW 22.33 COL 43 
     RECT-694 AT ROW 22.14 COL 1.83 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132 BY 23.51
         BGCOLOR 1  .


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
  CREATE WINDOW WUWSKBRN ASSIGN
         HIDDEN             = YES
         TITLE              = "คีย์เบิก / จ่าย  Sticker"
         HEIGHT             = 23.48
         WIDTH              = 132.33
         MAX-HEIGHT         = 26.95
         MAX-WIDTH          = 134.17
         VIRTUAL-HEIGHT     = 26.95
         VIRTUAL-WIDTH      = 134.17
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WUWSKBRN
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* BROWSE-TAB br_sckyear RECT-694 fr_main */
ASSIGN 
       br_sckyear:SEPARATOR-FGCOLOR IN FRAME fr_main      = 15.

/* SETTINGS FOR FILL-IN fi_SckNo_fr IN FRAME fr_main
   ALIGN-R                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKBRN)
THEN WUWSKBRN:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_sckyear
/* Query rebuild information for BROWSE br_sckyear
     _START_FREEFORM
OPEN QUERY {&SELF-NAME} FOR EACH wsckyear NO-LOCK .
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE br_sckyear */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWSKBRN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKBRN WUWSKBRN
ON END-ERROR OF WUWSKBRN /* คีย์เบิก / จ่าย  Sticker */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKBRN WUWSKBRN
ON WINDOW-CLOSE OF WUWSKBRN /* คีย์เบิก / จ่าย  Sticker */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_sckyear
&Scoped-define SELF-NAME br_sckyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_sckyear WUWSKBRN
ON VALUE-CHANGED OF br_sckyear IN FRAME fr_main
DO:

   FIND CURRENT wsckyear  NO-LOCK NO-ERROR.
   IF AVAIL wsckyear  THEN DO:
     
      DISP  DECIMAL(wsckyear.wscknost) @ fi_SckNo_fr
            DECIMAL(wsckyear.wscknoen) @ fi_SckNo_to
            wsckyear.wdocst   @ fi_RecStr
            wsckyear.wdocen   @ fi_RecEnd
            wsckyear.wacno    @ fi_prod
            wsckyear.winuse   @ fi_RecUse
            wsckyear.wsumstk  @ fi_RecSum
            wsckyear.wloss    @ fi_loss
      WITH FRAME fr_main.








      fi_RecTotal = wsckyear.wsumstk - wsckyear.winuse - wsckyear.wloss.
      chr_stk1    = wsckyear.wscknost.
      chr_stk2    = wsckyear.wscknoen.

      Cb_type    = wsckyear.wflag .
   END.

   IF      Cb_type =  "1P" THEN fi_distyp = "1 Part(web) : 201-015-5" .
   ELSE IF Cb_type =  "1S" THEN fi_distyp = "1 Part(Web) : 201-024 ".
   ELSE IF Cb_type =  "2P" THEN fi_distyp = "2 Part : 201-016-3" .
   ELSE IF Cb_type =  "4S" THEN fi_distyp = "4 Part (web) : 201-015-4" .
   ELSE IF Cb_type =  "4P" THEN fi_distyp = "4 Part : 201-015-3" .

   DISP Cb_type fi_RecTotal fi_distyp WITH FRAME fr_main. 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Add
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Add WUWSKBRN
ON CHOOSE OF bu_Add IN FRAME fr_main /* เพิ่ม */
DO:
    ENABLE  fi_SckNo_fr fi_SckNo_to fi_RecStr fi_RecEnd fi_prod fi_RecUse fi_RecTotal 
            Cb_type   fi_Usern    fi_remark bu_Save   bu_Cancel WITH FRAME fr_main.
    DISABLE bu_Add bu_Edit WITH FRAME fr_main.

    ASSIGN
        fi_SckNo_fr = 0
        fi_SckNo_to = 0
        fi_RecStr   = 0
        fi_RecEnd   = 0
        fi_prod     = ""
        fi_RecUse   = 0
        fi_RecTotal = 0
        Cb_type     = "1P"
        fi_Usern    = ""
        fi_remark   = ""
        fi_RecSum   = 0 .
        
        
    DISP    fi_SckNo_fr fi_SckNo_to fi_RecStr fi_RecEnd fi_prod fi_RecUse fi_RecTotal 
            Cb_type  fi_Usern    fi_remark fi_RecSum WITH FRAME fr_main.







END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Cancel WUWSKBRN
ON CHOOSE OF bu_Cancel IN FRAME fr_main /* ยกเลิก */
DO:
  DISABLE  fi_SckNo_fr fi_SckNo_to fi_RecStr fi_RecEnd fi_prod fi_RecUse fi_RecTotal 
            Cb_type   fi_Usern    fi_remark bu_Save   bu_Cancel WITH FRAME fr_main.
  ENABLE  bu_Add bu_Edit WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_CheckUse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_CheckUse WUWSKBRN
ON CHOOSE OF bu_CheckUse IN FRAME fr_main /* ... */
DO:
    RUN WAC\WACSKQBN (chr_stk1 , chr_stk2 ,fi_User ,fi_Branch ).
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Edit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Edit WUWSKBRN
ON CHOOSE OF bu_Edit IN FRAME fr_main /* แก้ไข */
DO:
  ENABLE  fi_SckNo_fr fi_SckNo_to fi_RecStr fi_RecEnd fi_prod fi_RecUse fi_RecTotal 
            Cb_type   fi_Usern    fi_remark bu_Save   bu_Cancel WITH FRAME fr_main.
    DISABLE bu_Add bu_Edit WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Exit WUWSKBRN
ON CHOOSE OF bu_Exit IN FRAME fr_main /* ออก */
DO:
  
  APPLY "CLOSE" TO THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Save WUWSKBRN
ON CHOOSE OF bu_Save IN FRAME fr_main /* บันทีก */
DO:
   loop_sckyear:
   FOR EACH   sckyear  
       WHERE  sckyear.sckno >= chr_stk1
       AND    sckyear.sckno <= chr_stk2 :

       IF sckyear.branch = ""  AND
          sckyear.acno   = ""  /*AND
          sckyear.usrid  = ""   */ THEN DO:
          ASSIGN
            sckyear.branch  = TRIM(fi_brn)   
            sckyear.acno    = TRIM(fi_prod)  
            sckyear.usrid   = TRIM(fi_User)
            sckyear.usrnam  = TRIM(fi_Usern)
            sckyear.opndat  = TODAY     
            sckyear.remark  = TRIM(fi_remark)
            sckyear.flag    = TRIM(Cb_type).   
       END.
       ELSE DO:
           MESSAGE "พบข้อมูลการเบิก Sticker no." sckyear.sckno
                   "ไปใช้โดย Branch:" sckyear.branch  sckyear.usrid VIEW-AS ALERT-BOX ERROR.
           LEAVE loop_sckyear.
       END.



   END.

   MESSAGE "เบิก Sticker no. จาก " chr_stk1 "ถึง" chr_stk2 "เรียบร้อยแล้ว" VIEW-AS ALERT-BOX .
   FOR EACH wsckyear .
       DELETE wsckyear.
   END.


   FOR EACH sckyear USE-INDEX sckyr03
      WHERE sckyear.branch = TRIM(fi_brn) NO-LOCK.

      FIND FIRST wsckyear
           WHERE wsckyear.wopndat = sckyear.opndat
           AND   wsckyear.wflag   = sckyear.flag 
           AND   wsckyear.wacno   = sckyear.acno  NO-ERROR.
      IF NOT AVAIL wsckyear THEN DO:
          CREATE wsckyear.
          ASSIGN
              wsckyear.wscknost = sckyear.sckno
              wsckyear.wopndat  = sckyear.opndat
              wsckyear.wflag    = sckyear.flag 
              wsckyear.wacno    = sckyear.acno
              wsckyear.wscknoen = sckyear.sckno.
              IF  sckyear.policy <> "" THEN wsckyear.winuse   = wsckyear.winuse + 1  . 
              wsckyear.wsumstk  = wsckyear.wsumstk + 1.  
         FIND FIRST notstk
              WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
         IF AVAILABLE notstk THEN wsckyear.wloss = wsckyear.wloss + 1.

      END.
      ELSE DO:
      
          ASSIGN
            wsckyear.wscknoen = sckyear.sckno
            wsckyear.wsumstk  = wsckyear.wsumstk + 1.
            IF  sckyear.policy <> "" THEN wsckyear.winuse   = wsckyear.winuse + 1 . 
          FIND FIRST notstk
              WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
         IF AVAILABLE notstk THEN wsckyear.wloss = wsckyear.wloss + 1.
           
      END.

  END.
  OPEN QUERY br_sckyear                                          
       FOR EACH  wsckyear 
           WHERE wsckyear.wopndat <> ? NO-LOCK
      BY wsckyear.wopndat DESC.






  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cb_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cb_type WUWSKBRN
ON VALUE-CHANGED OF Cb_type IN FRAME fr_main
DO:

  Cb_type = INPUT Cb_type.
  IF      Cb_type =  "1P" THEN fi_distyp = "1 Part(web) : 201-015-5" .
  ELSE IF Cb_type =  "1S" THEN fi_distyp = "1 Part(Web) : 201-024 ".
  ELSE IF Cb_type =  "2P" THEN fi_distyp = "2 Part : 201-016-3" .
  ELSE IF Cb_type =  "4S" THEN fi_distyp = "4 Part (web) : 201-015-4" .
  ELSE IF Cb_type =  "4P" THEN fi_distyp = "4 Part : 201-015-3" .

  DISP Cb_type fi_distyp WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brn WUWSKBRN
ON LEAVE OF fi_brn IN FRAME fr_main
DO:
  fi_brn = INPUT fi_brn.

  IF fi_brn = "" THEN DO:
      MESSAGE "Please Input Branch !" VIEW-AS ALERT-BOX.
      APPLY "ENTRY" TO fi_brn.
     RETURN NO-APPLY.
  END.
  FIND FIRST xmm023 USE-INDEX xmm02301
       WHERE xmm023.branch = fi_brn NO-LOCK NO-ERROR.
  IF AVAIL xmm023 THEN DO:
      ASSIGN
       fi_Branch = xmm023.bdes
       fi_dicbrn = xmm023.bdes.
  END.
  FOR EACH sckyear USE-INDEX sckyr03
      WHERE sckyear.branch = TRIM(fi_brn) NO-LOCK.

      FIND FIRST wsckyear
           WHERE wsckyear.wopndat = sckyear.opndat
           AND   wsckyear.wflag   = sckyear.flag 
           AND   wsckyear.wacno   = sckyear.acno  NO-ERROR.
      IF NOT AVAIL wsckyear THEN DO:
          CREATE wsckyear.
          ASSIGN
              wsckyear.wscknost = sckyear.sckno
              wsckyear.wopndat  = sckyear.opndat
              wsckyear.wflag    = sckyear.flag 
              wsckyear.wacno    = sckyear.acno
              wsckyear.wscknoen = sckyear.sckno
              wsckyear.wdocst   = sckyear.stat
              wsckyear.wdocen   = sckyear.stat.
              IF  sckyear.policy <> "" THEN wsckyear.winuse   = wsckyear.winuse + 1  . 
              wsckyear.wsumstk  = wsckyear.wsumstk + 1.  
              FIND FIRST notstk
                   WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
              IF AVAILABLE notstk THEN wsckyear.wloss = wsckyear.wloss + 1. 


      END.
      ELSE DO:
      
          ASSIGN
            wsckyear.wscknoen = sckyear.sckno
            wsckyear.wdocen   = sckyear.stat
            wsckyear.wsumstk  = wsckyear.wsumstk + 1.
            IF  sckyear.policy <> "" THEN wsckyear.winuse   = wsckyear.winuse + 1 . 
            FIND FIRST notstk
                 WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
              IF AVAILABLE notstk THEN wsckyear.wloss = wsckyear.wloss + 1. 

           
      END.

  END.
  OPEN QUERY br_sckyear                                          
       FOR EACH  wsckyear 
           WHERE wsckyear.wopndat <> ? NO-LOCK
      BY wsckyear.wopndat DESC.
  
  DISP fi_brn fi_dicbrn fi_Branch WITH FRAME fr_main.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prod WUWSKBRN
ON LEAVE OF fi_prod IN FRAME fr_main
DO:
  fi_prod = INPUT fi_prod.
  IF fi_prod <> "" THEN DO:
       FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                    xmm600.ACNO = INPUT fi_prod NO-LOCK NO-ERROR.
         IF NOT AVAIL xmm600 THEN DO:
            
            MESSAGE "Not on Agent Code Parameters file xmm600".
            APPLY "ENTRY" TO fi_prod IN FRAME fr_main.
            RETURN NO-APPLY.
            
         END.
         ELSE  fi_disprod = xmm600.name.
  END.
  
  DISP fi_prod fi_disprod WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_RecStr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_RecStr WUWSKBRN
ON LEAVE OF fi_RecStr IN FRAME fr_main
DO:
  fi_RecStr = INPUT fi_RecStr.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark WUWSKBRN
ON LEAVE OF fi_remark IN FRAME fr_main
DO:
  fi_remark = INPUT fi_remark.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_SckNo_fr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_SckNo_fr WUWSKBRN
ON LEAVE OF fi_SckNo_fr IN FRAME fr_main
DO:
    fi_sckno_fr = INPUT fi_sckno_fr.
    IF fi_sckno_fr <> 0 THEN DO:
       ASSIGN chr_sticker = STRING(fi_sckno_fr,"9999999999999").
       ASSIGN
           nv_sck_no  = chr_sticker
           nv_count01 = LENGTH(nv_sck_no) - 1.
           chr_sticker  = SUBSTRING(nv_sck_no,1,nv_count01).
       
       
       RUN PDCheckMod.
       
       IF  nv_sck_no <> nv_sticker THEN DO:         
           MESSAGE "Sticker no is not Match" chr_sticker " <> (MOD) " nv_sticker
           VIEW-AS ALERT-BOX ERROR.
           APPLY "ENTRY" TO fi_sckno_fr IN FRAME fr_main.
           RETURN NO-APPLY.
       END.  
       ELSE chr_stk1 = nv_sticker.
    END.
    FIND FIRST sckyear USE-INDEX sckyear 
         WHERE sckyear.sckno = chr_stk1 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sckyear THEN DO:
       ASSIGN
        fi_RecStr = INTEGER(sckyear.stat)
        Cb_type   = Sckyear.flag.
    END.
    ELSE DO:
        MESSAGE  "ไม่มีการ Generate Sticker No.:" chr_stk1 "เข้าระบบ" VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fi_sckno_fr IN FRAME fr_main.
        RETURN NO-APPLY.

    END.
    ASSIGN
       fi_SckNo_to = fi_sckno_fr
       fi_RecEnd   = fi_RecStr.
    IF      Cb_type =  "1P" THEN fi_distyp = "1 Part(web) : 201-015-5" .
    ELSE IF Cb_type =  "1S" THEN fi_distyp = "1 Part(Web) : 201-024 ".
    ELSE IF Cb_type =  "2P" THEN fi_distyp = "2 Part : 201-016-3" .
    ELSE IF Cb_type =  "4S" THEN fi_distyp = "4 Part (web) : 201-015-4" .
    ELSE IF Cb_type =  "4P" THEN fi_distyp = "4 Part : 201-015-3" .
    
    DISP fi_sckno_fr fi_SckNo_to fi_RecStr fi_RecEnd Cb_type fi_distyp WITH FRAME fr_main.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_SckNo_to
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_SckNo_to WUWSKBRN
ON LEAVE OF fi_SckNo_to IN FRAME fr_main
DO:
    fi_sckno_to = INPUT fi_sckno_to.
    IF fi_sckno_to <> 0 THEN DO:
        ASSIGN chr_sticker = STRING(fi_sckno_to,"9999999999999").
         ASSIGN
            nv_sck_no  = chr_sticker
            nv_count01 = LENGTH(nv_sck_no) - 1.
            chr_sticker  = SUBSTRING(nv_sck_no,1,nv_count01).
        
        RUN PDCheckMod.
        
        IF   nv_sck_no <> nv_sticker THEN DO:         
            MESSAGE "Sticker no is not Match" chr_sticker " <> (MOD) " nv_sticker
            VIEW-AS ALERT-BOX ERROR.
            APPLY "ENTRY" TO fi_sckno_to IN FRAME fr_main.
            RETURN NO-APPLY.
        END.
        ELSE chr_stk2 = nv_sticker.
    END.
    FIND FIRST sckyear USE-INDEX sckyear 
         WHERE sckyear.sckno = chr_stk2 NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sckyear THEN DO:
       fi_RecEnd  = INTEGER(sckyear.stat).
          
    END.
    ELSE DO:
        MESSAGE  "ไม่มีการ Generate Sticker No.:" chr_stk2 "เข้าระบบ" VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fi_sckno_fr IN FRAME fr_main.
        RETURN NO-APPLY.

    END.
    fi_RecSum  = fi_RecEnd - fi_RecStr.
    fi_RecSum  = fi_RecSum  + 1.
    
    DISP fi_SckNo_to fi_RecEnd fi_RecSum WITH FRAME fr_main.


  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWSKBRN 


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

  SESSION:DATA-ENTRY-RETURN = YES.

  fi_user      = USERID(LDBNAME(1)).

  DISABLE fi_SckNo_fr fi_SckNo_to fi_RecStr fi_RecEnd fi_prod fi_RecUse fi_RecTotal 
          fi_distyp   fi_Usern    fi_remark bu_Save   bu_Cancel WITH FRAME fr_main.

  
  DISP fi_user WITH FRAME fr_main.

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWSKBRN  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKBRN)
  THEN DELETE WIDGET WUWSKBRN.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWSKBRN  _DEFAULT-ENABLE
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
  DISPLAY fi_brn fi_prod Cb_type fi_SckNo_fr fi_SckNo_to fi_Usern fi_remark 
          fi_Branch fi_User fi_dicbrn fi_disprod fi_distyp fi_RecStr fi_RecEnd 
          fi_RecSum fi_RecUse fi_loss fi_RecTotal 
      WITH FRAME fr_main IN WINDOW WUWSKBRN.
  ENABLE RECT-1 RECT-2 RECT-5 RECT-11 RECT-10 RECT-12 RECT-17 RECT-18 RECT-6 
         RECT-7 RECT-8 RECT-694 br_sckyear fi_brn fi_prod Cb_type fi_SckNo_fr 
         fi_SckNo_to fi_Usern fi_remark bu_Save bu_Cancel bu_CheckUse bu_Add 
         bu_Edit bu_Exit fi_Branch fi_User fi_dicbrn fi_disprod fi_distyp 
         fi_RecStr fi_RecEnd fi_RecSum fi_RecUse fi_loss fi_RecTotal 
      WITH FRAME fr_main IN WINDOW WUWSKBRN.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WUWSKBRN.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckMod WUWSKBRN 
PROCEDURE PDCheckMod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_cnt2 = LENGTH(chr_sticker).

IF SUBSTRING (CHR_sticker,1,1) = "0"  THEN DO:
   ASSIGN  
   Chk_mod1 = DEC(SUBSTRING(chr_sticker,1,nv_cnt2)).            
      
   IF nv_cnt2 = 14 THEN DO:
      Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"99999999999999.999"  ),1,nv_cnt2)) * 7.
   END.
   ELSE IF nv_cnt2 = 12 THEN DO:
      Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"999999999999.999"  ),1,nv_cnt2)) * 7.
   END.
   ELSE IF nv_cnt2 = 10 THEN DO:
      Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"9999999999.999"  ),1,nv_cnt2)) * 7.
   END.
   ELSE IF nv_cnt2 = 8 THEN DO:
      Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7,"99999999.999"  ),1,nv_cnt2)) * 7.
   END.

   nv_modulo = Chk_mod1 - Chk_mod2.  
   nv_sticker = "0" + SUBSTRING(STRING(Chk_mod1),1,nv_cnt2) + STRING(nv_modulo).     

 END.
 ELSE DO: 
     ASSIGN  
     Chk_mod1 = DEC(SUBSTRING(chr_sticker,1,nv_cnt2)).      
     Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7),1,nv_cnt2)) * 7.
     nv_modulo = Chk_mod1 - Chk_mod2.         
     nv_sticker = SUBSTRING(STRING(Chk_mod1),1,nv_cnt2) + STRING(nv_modulo).
 END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

