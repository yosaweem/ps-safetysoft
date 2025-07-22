&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME WUWSKREP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWSKREP 
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
DEFINE VAR nv_pattle    AS INTEGER.
DEFINE VAR nv_line      AS INTEGER.
DEFINE VAR nv_line2     AS INTEGER.
DEFINE VAR nv_line3     AS INTEGER.
DEFINE VAR nv_line4     AS INTEGER.
DEFINE VAR nv_countl    AS INTEGER.
DEFINE VAR nv_report    AS INTEGER.
DEFINE VAR nv_des       AS CHAR     INIT "".
DEFINE VAR nv_acnam     AS CHAR     FORMAT "X(100)".
DEFINE VAR chr_sticker  AS CHAR     FORMAT "X(15)".
DEFINE VAR nvw_sticker  AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEFINE VAR nv_cnt1      AS INT. 
DEFINE VAR nv_cnt2      AS INT. 
DEFINE VAR Chk_mod1     AS DEC. 
DEFINE VAR Chk_mod2     AS DEC. 
DEFINE VAR nv_modulo    AS INTEGER  FORMAT "9".
DEFINE VAR nv_cnt01     AS INTEGER.  
DEFINE VAR nv_cnt02     AS INTEGER.
DEFINE VAR nv_count     AS INTEGER                      INIT 0. 
DEFINE VAR nv_sticker1  AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEFINE VAR nv_sticker2  AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEFINE VAR nv_sckno     AS INTEGER  FORMAT "99999999999".    
DEFINE VAR nv_crep      AS INTEGER  FORMAT "9999999"    INIT 0. 
DEFINE VAR nv_first     AS LOGICAL.
DEFINE VAR nvsck        AS CHAR     FORMAT "X(16)".
DEFINE VAR nv_sck_no    AS CHAR     FORMAT "X(15)"      INITIAL "" NO-UNDO. /*by amparat c. a51-0253--*/
DEFINE VAR nv_count01   AS INTEGER.
DEFINE VAR nv_count02   AS INTEGER.
DEFINE VAR nvrep        AS CHAR     FORMAT "9999999". /*-- A50-0185 --*/
DEFINE VAR nv_flag1P    AS INTEGER. 
DEFINE VAR nv_flag1S    AS INTEGER. 
DEFINE VAR nv_flag2P    AS INTEGER. 
DEFINE VAR nv_flag4S    AS INTEGER. 
DEFINE VAR nv_flag4P    AS INTEGER. 
DEFINE VAR nv_remain    AS INTEGER. 
DEFINE STREAM ns1.
DEFINE STREAM ns2.
DEFINE STREAM ns3.
DEFINE WORKFILE wsumstk NO-UNDO  
       FIELD branch LIKE sckyear.branch         
       FIELD typ    AS CHAR     FORMAT "X(50)"   
       FIELD sflag  AS INTEGER 
       FIELD reptyp AS CHAR     FORMAT "X(5)"   
       FIELD totsum AS INTEGER 
       FIELD usesum AS INTEGER 
       FIELD wloss  AS INTEGER .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS rs_check cb_pattle fi_stickerfr fi_stickerto ~
Btn_OK fi_output Cb_type fi_brnfr fi_brnto fi_opendatfr fi_opendatto ~
fi_stkbrnfr fi_stkbrnto fi_outputbrn fi_brndisto Btn_OKbrn fi_brndisfr ~
Btn_exit fi_type RECT-1 RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 ~
RECT-9 to_detail to_sum to_sumall 
&Scoped-Define DISPLAYED-OBJECTS rs_check cb_pattle fi_stickerfr ~
fi_stickerto fi_output Cb_type fi_brnfr fi_brnto fi_opendatfr fi_opendatto ~
fi_stkbrnfr fi_stkbrnto fi_outputbrn fi_brndisto fi_brndisfr fi_type ~
to_detail to_sum to_sumall 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWSKREP AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_exit 
     LABEL "Exit" 
     SIZE 12.83 BY 1.38
     FONT 6.

DEFINE BUTTON Btn_OK 
     LABEL "OK" 
     SIZE 9.5 BY 1.38
     FONT 6.

DEFINE BUTTON Btn_OKbrn 
     LABEL "OK" 
     SIZE 9.5 BY 1.38
     FONT 6.

DEFINE VARIABLE cb_pattle AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "On file","Not on file","All" 
     DROP-DOWN-LIST
     SIZE 21.17 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE Cb_type AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "1P","1S","2P","2S","4P","4S","Blank" 
     DROP-DOWN-LIST
     SIZE 10.17 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndisfr AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndisto AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brnfr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brnto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_opendatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_opendatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_outputbrn AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 38.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stickerfr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stickerto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stkbrnfr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stkbrnto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 25 BY 1
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE rs_check AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Nomal", 1,
"By Branch", 2
     SIZE 31.5 BY 1.19
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-1
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 80.83 BY 2.1
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-2
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 24.83 BY 1.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-3
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 56 BY 1.91
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-4
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 80.83 BY 2.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-5
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 56 BY 5.95
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-6
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 24.83 BY 5.95
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-7
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 56 BY 10.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 24.83 BY 10.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-9
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14.5 BY 1.81
     BGCOLOR 6 .

DEFINE VARIABLE to_detail AS LOGICAL INITIAL no 
     LABEL "Detail" 
     VIEW-AS TOGGLE-BOX
     SIZE 12 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE to_sum AS LOGICAL INITIAL no 
     LABEL "Summary" 
     VIEW-AS TOGGLE-BOX
     SIZE 14 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE to_sumall AS LOGICAL INITIAL no 
     LABEL "Summary All" 
     VIEW-AS TOGGLE-BOX
     SIZE 18.83 BY .95
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_check AT ROW 3.57 COL 30.17 NO-LABEL 
     cb_pattle AT ROW 6.91 COL 27 COLON-ALIGNED NO-LABEL 
     fi_stickerfr AT ROW 8.24 COL 27 COLON-ALIGNED NO-LABEL 
     fi_stickerto AT ROW 8.24 COL 55.5 COLON-ALIGNED NO-LABEL 
     Btn_OK AT ROW 9.33 COL 70.5 
     fi_output AT ROW 9.48 COL 26.83 COLON-ALIGNED NO-LABEL
     Cb_type AT ROW 14.24 COL 26.83 COLON-ALIGNED NO-LABEL 
     fi_brnfr AT ROW 15.67 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_brnto AT ROW 15.62 COL 56 COLON-ALIGNED NO-LABEL 
     fi_opendatfr AT ROW 17.14 COL 26.83 COLON-ALIGNED NO-LABEL
     fi_opendatto AT ROW 17.14 COL 56.17 COLON-ALIGNED NO-LABEL
     fi_stkbrnfr AT ROW 18.67 COL 26.83 COLON-ALIGNED NO-LABEL 
     fi_stkbrnto AT ROW 18.67 COL 56.17 COLON-ALIGNED NO-LABEL 
     fi_outputbrn AT ROW 20.29 COL 26.67 COLON-ALIGNED NO-LABEL
     fi_brndisto AT ROW 15.62 COL 62.5 COLON-ALIGNED NO-LABEL 
     Btn_OKbrn AT ROW 19.91 COL 71 
     fi_brndisfr AT ROW 15.62 COL 33 COLON-ALIGNED NO-LABEL 
     Btn_exit AT ROW 22.33 COL 67.5 
     fi_type AT ROW 14.1 COL 38.67 COLON-ALIGNED NO-LABEL 
     to_detail AT ROW 12.86 COL 29 
     to_sum AT ROW 12.81 COL 43.17 
     to_sumall AT ROW 12.81 COL 60.17 
     "To.:" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 17.14 COL 52.17 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "To.:" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 18.57 COL 52.17 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Output To :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 9.57 COL 12 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "    By Branch" VIEW-AS TEXT
          SIZE 80.17 BY 1 AT ROW 11.67 COL 2.33 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "To.:" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 15.76 COL 52 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Sticker No. From :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 18.76 COL 5.5 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "    Nomal" VIEW-AS TEXT
          SIZE 80.17 BY 1 AT ROW 5.43 COL 2.33 
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "เช็คข้อมูลแบบ ... :" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 3.67 COL 4 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Report   Sticker ยอดใช้ไป/คงเหลือ" VIEW-AS TEXT
          SIZE 34.67 BY 1.33 AT ROW 1.57 COL 24.67 
          BGCOLOR 3 FGCOLOR 7 FONT 13
     "Report Type :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 12.81 COL 9.33 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Branch  From. :" VIEW-AS TEXT
          SIZE 17.33 BY 1 AT ROW 15.71 COL 8 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "เช็คข้อมูลแบบ ... :" VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 6.91 COL 6.83
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Sticker No. From :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 8.24 COL 5.5 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Output To :" VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 20.24 COL 12 
          BGCOLOR 8 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.1
         SIZE 83.17 BY 23.38
         BGCOLOR 1 FGCOLOR 7  .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "To.:" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 8.29 COL 52.17 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Type document  :" VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 14.24 COL 5.67 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "Open Date  From  :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 17.24 COL 4.5 
          BGCOLOR 8 FGCOLOR 2 FONT 6
     RECT-1 AT ROW 1.14 COL 1.83 
     RECT-2 AT ROW 3.19 COL 1.83 
     RECT-3 AT ROW 3.19 COL 26.67
     RECT-4 AT ROW 21.95 COL 1.83
     RECT-5 AT ROW 5.29 COL 26.83
     RECT-6 AT ROW 5.29 COL 2 
     RECT-7 AT ROW 11.43 COL 26.83 
     RECT-8 AT ROW 11.43 COL 2 
     RECT-9 AT ROW 22.1 COL 66.5 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1.1
         SIZE 83.17 BY 23.38
         BGCOLOR 1 FGCOLOR 7.


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
  CREATE WINDOW WUWSKREP ASSIGN
         HIDDEN             = YES
         TITLE              = "Report   Sticker ยอดใช้ไป/คงเหลือ"
         HEIGHT             = 23.57
         WIDTH              = 82.83
         MAX-HEIGHT         = 26.67
         MAX-WIDTH          = 120.33
         VIRTUAL-HEIGHT     = 26.67
         VIRTUAL-WIDTH      = 120.33
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
/* SETTINGS FOR WINDOW WUWSKREP
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKREP)
THEN WUWSKREP:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWSKREP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKREP WUWSKREP
ON END-ERROR OF WUWSKREP /* Report   Sticker ยอดใช้ไป/คงเหลือ */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKREP WUWSKREP
ON WINDOW-CLOSE OF WUWSKREP /* Report   Sticker ยอดใช้ไป/คงเหลือ */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_exit WUWSKREP
ON CHOOSE OF Btn_exit IN FRAME fr_main /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK WUWSKREP
ON CHOOSE OF Btn_OK IN FRAME fr_main /* OK */
DO:
   
  OUTPUT STREAM ns1 TO VALUE (fi_output).
   
   IF  nv_pattle = 1  OR nv_pattle =  3 THEN DO:
       PUT STREAM ns1
            "Line|"         
            "Sticker No.|"  
            "Rec No.|"      
            "Policy No.|"   
            "Ren|"          
            "Ent|"   
            "Document Type|"
            "Risk|"         
            "Item|"         
            "Ent.Date|"     
            "Exp.Date|"     
            "BR.|"          
            "Acc No.|" 
            "Acc Name|" 
            "User Id|"      
            "User Name|"    
            "Open Date|"    
            "Tran.Date|"    
            "Remark|"  SKIP.      
   END.
   ELSE DO:
       PUT STREAM ns1
         "Line|"         
         "Sticker No.|" 
         "Document Type|"
         "Rec No.|"      
         "BR.|"          
         "Acc No.|" 
         "Acc Name|" 
         "User Id|"      
         "User Name|"    
         "Open Date|"    
         "Remark|"  SKIP.  
   END.

   FOR EACH  sckyear  USE-INDEX sckyear 
       WHERE sckyear.sckno >= fi_stickerfr 
       AND   sckyear.sckno <= fi_stickerto  NO-LOCK:
       nv_acnam   =  "".
       IF  nv_pattle = 1 THEN DO:
           IF sckyear.policy  <> "" OR sckyear.scklost <> "" THEN DO:
               nv_line    = nv_line + 1.
               IF sckyear.acno <> " " THEN DO:
                   FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                              xmm600.ACNO = sckyear.acno NO-LOCK NO-ERROR.
                   IF AVAIL xmm600 THEN nv_acnam   = xmm600.name.
               END.
               PUT STREAM ns1
                   nv_line           "|"
                   sckyear.sckno  FORMAT "X(30)"   "|"                    
                   sckyear.stat      "|"
                   sckyear.policy    "|"                    
                   sckyear.rencnt    "|"                    
                   sckyear.endcnt    "|"                    
                   sckyear.riskno    "|"                    
                   sckyear.itemno    "|"
                   sckyear.flag      "|"
                   sckyear.entdat    "|"                    
                   sckyear.expdat    "|"
                   sckyear.branch    "|"
                   sckyear.acno      "|"
                   nv_acnam          "|"
                   sckyear.usrid     "|"
                   sckyear.usrnam    "|"
                   sckyear.opndat    "|"
                   sckyear.trandat   "|"  
                   sckyear.remark    "|"  SKIP.  
           END. /*sckyear.policy  <> ""*/

       END. /*nv_pattle = 1 on file**/
       ELSE IF  nv_pattle = 2 THEN DO:
           IF sckyear.policy  = "" AND sckyear.scklost = "" THEN DO:
               nv_line2    = nv_line2 + 1.
                IF sckyear.acno <> " " THEN DO:
                   FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                              xmm600.ACNO = sckyear.acno NO-LOCK NO-ERROR.
                   IF AVAIL xmm600 THEN nv_acnam   = xmm600.name.
               END.

               PUT STREAM ns1
                   nv_line2          "|"
                   sckyear.sckno FORMAT "X(30)"     "|"  
                   sckyear.flag      "|"
                   sckyear.stat      "|"
                   sckyear.branch    "|"
                   sckyear.acno      "|"
                   nv_acnam          "|"
                   sckyear.usrid     "|"
                   sckyear.usrnam    "|"
                   sckyear.opndat    "|"
                   sckyear.remark    "|"  SKIP.  
           END. /*sckyear.policy  <> ""*/

       END. /*nv_pattle = 2 Not on file*/
       ELSE DO:
               IF sckyear.acno <> " " THEN DO:
                   FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                              xmm600.ACNO = sckyear.acno NO-LOCK NO-ERROR.
                   IF AVAIL xmm600 THEN nv_acnam   = xmm600.name.
               END.

               nv_line3    = nv_line3 + 1.
               
               PUT STREAM ns1
                   nv_line3          "|"
                   sckyear.sckno  FORMAT "X(30)"    "|"                    
                   sckyear.stat      "|"
                   sckyear.policy    "|"                    
                   sckyear.rencnt    "|"                    
                   sckyear.endcnt    "|" 
                   sckyear.flag      "|"
                   sckyear.riskno    "|"                    
                   sckyear.itemno    "|"                    
                   sckyear.entdat    "|"                    
                   sckyear.expdat    "|"
                   sckyear.branch    "|"
                   sckyear.acno      "|"
                   nv_acnam          "|"
                   sckyear.usrid     "|"
                   sckyear.usrnam    "|"
                   sckyear.opndat    "|"
                   sckyear.trandat   "|"  
                   sckyear.remark    "|"  SKIP.  

       END. /*nv_pattle = 3 All */

   END.
   MESSAGE "Report   Sticker ยอดใช้ไป /คงเหลือ Nomal  Complete" VIEW-AS ALERT-BOX.

   OUTPUT STREAM ns1 CLOSE.
   
   

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OKbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OKbrn WUWSKREP
ON CHOOSE OF Btn_OKbrn IN FRAME fr_main /* OK */
DO:
  
   IF to_detail  THEN DO: 
       
      OUTPUT STREAM ns2 TO VALUE (fi_outputbrn + "Detail.txt").
      PUT STREAM ns2
         "Line|"
         "BR.|" 
         "Branch  discreption|"
         "Open Dat|"      
         "Sticker No.|" 
         "Document Type|"
         "Rec No.|"       
         "Policy No.|"    
         "Acc No.|"       
         "Acc Name|"      
         "User Id|"        SKIP.

   END.
   IF to_sum OR  to_sumall THEN DO: 
       
       OUTPUT STREAM ns3 TO VALUE (fi_outputbrn + "Summary.txt").
   END.

   IF to_sumall THEN DO:
      
      RUN PD_Sumall.

   END.


   nv_line4  = 0.
   nv_countl = 0.

   IF to_detail OR to_sum THEN DO:
   
      FOR EACH  sckyear   USE-INDEX sckyr03
          WHERE  sckyear.branch >= fi_brnfr 
           AND   sckyear.branch <= fi_brnto 
           AND   sckyear.sckno  >= fi_stkbrnfr 
           AND   sckyear.sckno  <= fi_stkbrnto   
           AND   sckyear.opndat >= fi_opendatfr
           AND   sckyear.opndat <= fi_opendatto 
           AND   sckyear.flag    = Cb_type      NO-LOCK
       BREAK BY sckyear.branch:
      
           nv_line4  = nv_line4  + 1.
           nv_countl = nv_countl  + 1.
           FIND FIRST xmm023 USE-INDEX xmm02301
                WHERE xmm023.branch = sckyear.branch NO-LOCK NO-ERROR.
           IF AVAIL xmm023 THEN nv_des = xmm023.bdes.
      
           IF sckyear.acno <> " " THEN DO:
               FIND FIRST xmm600 USE-INDEX xmm60001 WHERE
                          xmm600.ACNO = sckyear.acno NO-LOCK NO-ERROR.
               IF AVAIL xmm600 THEN nv_acnam   = xmm600.name.
           END.
                IF  Cb_type = "1P" THEN nv_flag1P =  nv_flag1P + 1.
           ELSE IF  Cb_type = "1S" THEN nv_flag1S =  nv_flag1S + 1.
           ELSE IF  Cb_type = "2P" THEN nv_flag2P =  nv_flag2P + 1.
           ELSE IF  Cb_type = "4S" THEN nv_flag4S =  nv_flag4S + 1.
           ELSE IF  Cb_type = "4P" THEN nv_flag4P =  nv_flag4P + 1.
      
           IF to_detail  THEN DO: 
               IF nv_countl >= 60000  THEN  DO:
                   nv_countl = 0.                                         
                   nv_report = nv_report + 1.
                   fi_outputbrn = fi_outputbrn + "Detail" + STRING(nv_report).
               
                   OUTPUT STREAM ns2 TO CLOSE.
                   OUTPUT STREAM ns2 TO VALUE (fi_outputbrn).
                     
                   PUT STREAM ns2
                      "Line|"
                      "BR.|" 
                      "Branch  discreption|"
                      "Open Dat|"      
                      "Sticker No.|" 
                      "Document Type|"
                      "Rec No.|"       
                      "Policy No.|"    
                      "Acc No.|"       
                      "Acc Name|"      
                      "User Id|"        SKIP.
               
               END.
               
               PUT STREAM ns2
                   nv_line4                                "|" 
                   sckyear.branch                          "|" 
                   nv_des            FORMAT "x(30)"        "|" 
                   sckyear.opndat                          "|" 
                   sckyear.sckno     FORMAT "x(30)"        "|" 
                   sckyear.stat                            "|" 
                   sckyear.flag                            "|"
                   sckyear.policy                          "|" 
                   sckyear.acno                            "|" 
                   nv_acnam                                "|" 
                   sckyear.usrid                           "|"
                   sckyear.remark                          "|" SKIP.
           
              IF LAST-OF(sckyear.branch) THEN DO:
                  nv_line4 = 0.
              
                       IF  Cb_type = "1P" THEN  PUT STREAM ns2 "Branch : |"  sckyear.branch "|"  Cb_type + " "  + fi_type FORMAT "X(50)" "|" nv_flag1P  "|" SKIP.
                  ELSE IF  Cb_type = "1S" THEN  PUT STREAM ns2 "Branch : |"  sckyear.branch "|"  Cb_type + " "  + fi_type FORMAT "X(50)" "|" nv_flag1S  "|" SKIP.
                  ELSE IF  Cb_type = "2P" THEN  PUT STREAM ns2 "Branch : |"  sckyear.branch "|"  Cb_type + " "  + fi_type FORMAT "X(50)" "|" nv_flag2P  "|" SKIP.
                  ELSE IF  Cb_type = "4S" THEN  PUT STREAM ns2 "Branch : |"  sckyear.branch "|"  Cb_type + " "  + fi_type FORMAT "X(50)" "|" nv_flag4S  "|" SKIP.
                  ELSE IF  Cb_type = "4P" THEN  PUT STREAM ns2 "Branch : |"  sckyear.branch "|"  Cb_type + " "  + fi_type FORMAT "X(50)" "|" nv_flag4P  "|" SKIP.
              END.
           END.
      
           FIND FIRST wsumstk
                WHERE wsumstk.branch = sckyear.branch
                AND   wsumstk.reptyp = Cb_type           NO-ERROR.
           IF NOT AVAIL wsumstk  THEN DO:
               CREATE wsumstk.
               ASSIGN
                 wsumstk.branch = sckyear.branch 
                 wsumstk.typ    = fi_type
                 wsumstk.reptyp = Cb_type  
                 wsumstk.totsum = wsumstk.totsum + 1.
                 IF sckyear.policy <> "" THEN wsumstk.usesum = wsumstk.usesum + 1.
                 FIND FIRST notstk
                      WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
                 IF AVAILABLE notstk THEN wsumstk.wloss = wsumstk.wloss + 1. 
      
           END.
           ELSE DO:
               ASSIGN
                 wsumstk.branch = sckyear.branch
                 wsumstk.typ    = fi_type
                 wsumstk.reptyp = Cb_type  
                 wsumstk.totsum = wsumstk.totsum + 1.
                 IF sckyear.policy <> "" THEN wsumstk.usesum = wsumstk.usesum + 1.
                 FIND FIRST notstk
                      WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
                 IF AVAILABLE notstk THEN wsumstk.wloss = wsumstk.wloss + 1. 
      
           END.
          
       END.
   END.

  IF to_sum OR to_sumall    THEN DO:

     PUT STREAM ns3
         "Branch |" 
         "ประเภทเอกสาร |"
         "ทั้งหมด |"
         "ใช้ไป |"
         "ชำรุด |"
         "คงเหลือ |" SKIP.
    
     FOR EACH wsumstk
         WHERE wsumstk.branch >= fi_brnfr
         AND   wsumstk.branch <= fi_brnto NO-LOCK.
    
         nv_remain = wsumstk.totsum - wsumstk.usesum - wsumstk.wloss.
         PUT STREAM ns3
             wsumstk.branch                  "|"   
             wsumstk.reptyp + wsumstk.typ    "|"
             wsumstk.totsum                  "|"
             wsumstk.usesum                  "|"
             wsumstk.wloss                   "|" SKIP.
     END.
  END.

  IF to_detail              THEN OUTPUT STREAM ns2 CLOSE.
  IF to_sum   OR to_sumall  THEN OUTPUT STREAM ns3 CLOSE.
  
  MESSAGE "Report   Sticker ยอดใช้ไป /คงเหลือ By Branch  Complete" VIEW-AS ALERT-BOX.
    
    
    
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_pattle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_pattle WUWSKREP
ON VALUE-CHANGED OF cb_pattle IN FRAME fr_main
DO:
  cb_pattle = INPUT cb_pattle.
 
       IF cb_pattle = "On file"     THEN nv_pattle = 1.
  ELSE IF cb_pattle = "Not on file" THEN nv_pattle = 2.
  ELSE IF cb_pattle = "All" THEN nv_pattle = 3.

  DISP cb_pattle WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cb_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cb_type WUWSKREP
ON VALUE-CHANGED OF Cb_type IN FRAME fr_main
DO:

   Cb_type = INPUT Cb_type.
  IF      Cb_type =  "1P" THEN fi_type = "1 Part(web) : 201-028" . /*201-015-5*/
  ELSE IF Cb_type =  "1S" THEN fi_type = "1 Part(Web) : 201-024-1". /*พี่บีศรีกรุง*/
  ELSE IF Cb_type =  "2P" THEN fi_type = "2 Part : 201-029" .    /*201-016-3*/
  ELSE IF Cb_type =  "4S" THEN fi_type = "4 Part (web) : 201-027" .  /*201-015-4"*/
  ELSE IF Cb_type =  "4P" THEN fi_type = "4 Part : 201-026" .  /*201-015-3*/

  IF Cb_type = "Blank" THEN Cb_type = "".

  DISP Cb_type fi_type WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brnfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brnfr WUWSKREP
ON LEAVE OF fi_brnfr IN FRAME fr_main
DO:
  fi_brnfr = INPUT fi_brnfr.
  FIND FIRST xmm023 USE-INDEX xmm02301
       WHERE xmm023.branch =  fi_brnfr NO-LOCK NO-ERROR.
  IF AVAIL xmm023  THEN DO:

      fi_brndisfr = xmm023.bdes.

  END.


  DISP fi_brnfr fi_brndisfr WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brnto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brnto WUWSKREP
ON LEAVE OF fi_brnto IN FRAME fr_main
DO:
  fi_brnto = INPUT fi_brnto.
  FIND FIRST xmm023 USE-INDEX xmm02301
       WHERE xmm023.branch =  fi_brnto NO-LOCK NO-ERROR.
  IF AVAIL xmm023  THEN DO:

      fi_brndisto = xmm023.bdes.

  END.

  DISP fi_brnto fi_brndisto WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_opendatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_opendatfr WUWSKREP
ON LEAVE OF fi_opendatfr IN FRAME fr_main
DO:
  fi_opendatfr = INPUT fi_opendatfr.
  DISP fi_opendatfr WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_opendatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_opendatto WUWSKREP
ON LEAVE OF fi_opendatto IN FRAME fr_main
DO:
    fi_opendatto = INPUT fi_opendatto.
    DISP fi_opendatto WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output WUWSKREP
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_output = INPUT fi_output.
  DISP fi_output WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_outputbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_outputbrn WUWSKREP
ON LEAVE OF fi_outputbrn IN FRAME fr_main
DO:
  fi_outputbrn = INPUT fi_outputbrn.
  DISP fi_outputbrn WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stickerfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stickerfr WUWSKREP
ON LEAVE OF fi_stickerfr IN FRAME fr_main
DO:
   fi_stickerfr = INPUT fi_stickerfr.

     IF fi_stickerfr = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_stickerfr.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_stickerfr) <> 11 AND LENGTH(fi_stickerfr)<> 13 THEN DO:
         MESSAGE "Sticker No. = 11  OR  13 Character".
         APPLY "ENTRY" TO fi_stickerfr.
         RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stickerfr).

     RUN PD_chkmod.

     IF  fi_stickerfr <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stickerfr
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_stickerfr.
         RETURN NO-APPLY.
     END.
     fi_stickerto = fi_stickerfr.
     DISP fi_stickerfr fi_stickerto  WITH FRAME fr_main.



END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stickerto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stickerto WUWSKREP
ON LEAVE OF fi_stickerto IN FRAME fr_main
DO:
    fi_stickerto = INPUT fi_stickerto.

     IF fi_stickerto = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_stickerto.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_stickerto) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character".
         APPLY "ENTRY" TO fi_stickerto.
         RETURN NO-APPLY.
     END.

     IF  fi_stickerto < fi_stickerfr THEN DO:
          MESSAGE "Sticker No. To Must Be Greater Or Equal".
          APPLY "ENTRY" TO fi_stickerto.
          RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stickerto).

     RUN PD_chkmod.

     IF  fi_stickerto <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stickerto
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_stickerto.
         RETURN NO-APPLY.
     END.
    
     
     DISP fi_stickerto  WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stkbrnfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stkbrnfr WUWSKREP
ON LEAVE OF fi_stkbrnfr IN FRAME fr_main
DO:
    fi_stkbrnfr = INPUT fi_stkbrnfr.

     IF fi_stkbrnfr = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_stkbrnfr.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_stkbrnfr) <> 11 AND LENGTH(fi_stkbrnfr)<> 13 THEN DO:
         MESSAGE "Sticker No. = 11  OR  13 Character".
         APPLY "ENTRY" TO fi_stkbrnfr.
         RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stkbrnfr).

     RUN PD_chkmod.

     IF  fi_stkbrnfr <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stkbrnfr
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_stkbrnfr.
         RETURN NO-APPLY.
     END.
    fi_stkbrnto = fi_stkbrnfr.
     DISP fi_stkbrnfr fi_stkbrnto  WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stkbrnto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stkbrnto WUWSKREP
ON LEAVE OF fi_stkbrnto IN FRAME fr_main
DO:
    fi_stkbrnto = INPUT fi_stkbrnto.

     IF fi_stkbrnto = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_stkbrnto.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_stkbrnto) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character".
         APPLY "ENTRY" TO fi_stkbrnto.
         RETURN NO-APPLY.
     END.

     IF  fi_stkbrnto < fi_stkbrnfr  THEN DO:
          MESSAGE "Sticker No. To Must Be Greater Or Equal".
          APPLY "ENTRY" TO fi_stkbrnto.
          RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stkbrnto).

     RUN PD_chkmod.

     IF  fi_stkbrnto <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stkbrnto
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_stkbrnto.
         RETURN NO-APPLY.
     END.
    
     
     DISP fi_stkbrnto  WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_check
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_check WUWSKREP
ON VALUE-CHANGED OF rs_check IN FRAME fr_main
DO:
  rs_check = INPUT rs_check.
  Cb_type  = "1P".
  fi_type  = "1 Part(web) : 201-028" .

  IF rs_check = 1 THEN DO: 
      DISABLE Cb_type fi_brnfr fi_brnto fi_stkbrnfr fi_stkbrnto 
              fi_outputbrn Btn_OKbrn    fi_opendatfr fi_opendatto 
              to_detail    to_sum       to_sumall                    WITH FRAME fr_main.
      ENABLE  cb_pattle fi_stickerfr fi_stickerto fi_output Btn_OK   WITH FRAME fr_main.
  END.
  ELSE DO:
      DISABLE  cb_pattle fi_stickerfr fi_stickerto fi_output Btn_OK  WITH FRAME fr_main.
      ENABLE   Cb_type fi_brnfr fi_brnto fi_stkbrnfr fi_stkbrnto 
               fi_outputbrn Btn_OKbrn  fi_opendatfr  fi_opendatto 
               to_detail    to_sum     to_sumall                     WITH FRAME fr_main.
  END.

  DISP rs_check Cb_type fi_type WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_detail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_detail WUWSKREP
ON VALUE-CHANGED OF to_detail IN FRAME fr_main /* Detail */
DO:
  to_detail = INPUT to_detail .
  DISABLE  to_sumall           WITH FRAME fr_main. 
  ENABLE   Cb_type             WITH FRAME fr_main. 
  DISP     to_detail Cb_type   WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_sum
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_sum WUWSKREP
ON VALUE-CHANGED OF to_sum IN FRAME fr_main /* Summary */
DO:
  to_sum = INPUT to_sum.
  DISABLE  to_sumall           WITH FRAME fr_main. 
  ENABLE   Cb_type             WITH FRAME fr_main. 
  DISP to_sum Cb_type           WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME to_sumall
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL to_sumall WUWSKREP
ON VALUE-CHANGED OF to_sumall IN FRAME fr_main /* Summary All */
DO:
  to_sumall = INPUT to_sumall.
  
  DISABLE  Cb_type  to_detail to_sum WITH FRAME fr_main. 

  DISP to_sumall  WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWSKREP 


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
  ASSIGN 
    rs_check   = 1
    nv_pattle  = 1
    cb_pattle  = "On file".

  IF rs_check = 1 THEN DO: 
      DISABLE Cb_type fi_brnfr fi_brnto fi_stkbrnfr fi_stkbrnto 
              fi_outputbrn Btn_OKbrn fi_opendatfr fi_opendatto 
              to_detail to_sum       to_sumall                       WITH FRAME fr_main.
      ENABLE  cb_pattle fi_stickerfr fi_stickerto fi_output Btn_OK   WITH FRAME fr_main.
  END.
  ELSE DO:
      DISABLE  cb_pattle fi_stickerfr fi_stickerto fi_output Btn_OK   WITH FRAME fr_main.
      ENABLE   Cb_type      fi_brnfr   fi_brnto    fi_stkbrnfr    fi_stkbrnto 
               fi_outputbrn Btn_OKbrn  fi_opendatfr fi_opendatto  to_detail 
               to_sum       to_sumall                                 WITH FRAME fr_main.
  END.

  DISP rs_check cb_pattle WITH FRAME fr_main.


  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWSKREP  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKREP)
  THEN DELETE WIDGET WUWSKREP.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWSKREP  _DEFAULT-ENABLE
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
  DISPLAY rs_check cb_pattle fi_stickerfr fi_stickerto fi_output Cb_type 
          fi_brnfr fi_brnto fi_opendatfr fi_opendatto fi_stkbrnfr fi_stkbrnto 
          fi_outputbrn fi_brndisto fi_brndisfr fi_type to_detail to_sum 
          to_sumall 
      WITH FRAME fr_main IN WINDOW WUWSKREP.
  ENABLE rs_check cb_pattle fi_stickerfr fi_stickerto Btn_OK fi_output Cb_type 
         fi_brnfr fi_brnto fi_opendatfr fi_opendatto fi_stkbrnfr fi_stkbrnto 
         fi_outputbrn fi_brndisto Btn_OKbrn fi_brndisfr Btn_exit fi_type RECT-1 
         RECT-2 RECT-3 RECT-4 RECT-5 RECT-6 RECT-7 RECT-8 RECT-9 to_detail 
         to_sum to_sumall 
      WITH FRAME fr_main IN WINDOW WUWSKREP.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WUWSKREP.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_chkmod WUWSKREP 
PROCEDURE PD_chkmod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

nv_cnt1 = LENGTH(chr_sticker).
nv_cnt2 = nv_cnt1 - 1.

IF  nv_cnt1  = 0 THEN NEXT .
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
      chr_sticker = "0" + SUBSTRING(STRING(Chk_mod1),1,nv_cnt2) + STRING(nv_modulo).      
      
      
 END.
 ELSE DO: 
     ASSIGN  
     Chk_mod1 = DEC(SUBSTRING(chr_sticker,1,nv_cnt2)).      
     Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7),1,nv_cnt2)) * 7.
     nv_modulo = Chk_mod1 - Chk_mod2.         
     chr_sticker = SUBSTRING(STRING(Chk_mod1),1,nv_cnt2) + STRING(nv_modulo).
 END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_Sumall WUWSKREP 
PROCEDURE PD_Sumall :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH   sckyear   USE-INDEX sckyr03
    WHERE  sckyear.branch >= fi_brnfr 
     AND   sckyear.branch <= fi_brnto 
     AND   sckyear.sckno  >= fi_stkbrnfr 
     AND   sckyear.sckno  <= fi_stkbrnto   
     AND   sckyear.opndat >= fi_opendatfr
     AND   sckyear.opndat <= fi_opendatto  NO-LOCK
    BREAK BY sckyear.branch:

    FIND FIRST wsumstk
         WHERE wsumstk.branch = sckyear.branch   
         AND   wsumstk.reptyp = sckyear.flag    NO-ERROR.
    IF NOT AVAIL wsumstk  THEN DO:
        CREATE wsumstk.
        ASSIGN
          wsumstk.branch = sckyear.branch 
          wsumstk.typ    = fi_type
          wsumstk.reptyp = sckyear.flag  
          wsumstk.totsum = wsumstk.totsum + 1.
          IF sckyear.policy <> "" THEN wsumstk.usesum = wsumstk.usesum + 1.
          FIND FIRST notstk
               WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
          IF AVAILABLE notstk THEN wsumstk.wloss = wsumstk.wloss + 1. 

    END.
    ELSE DO:
        ASSIGN
          wsumstk.branch = sckyear.branch
          wsumstk.typ    = fi_type
          wsumstk.reptyp = sckyear.flag  
          wsumstk.totsum = wsumstk.totsum + 1.
          IF sckyear.policy <> "" THEN wsumstk.usesum = wsumstk.usesum + 1.
          FIND FIRST notstk
               WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
          IF AVAILABLE notstk THEN wsumstk.wloss = wsumstk.wloss + 1. 

    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

