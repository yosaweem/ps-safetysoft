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
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
/*++++++++++++++++++++++++++++++++++++++++++++++
 WGWQHCT3.w :  Quey & Update data notify Add in table  tlt  
  Create  by    : Kridtiya I. A64-0414 Date 27/11/2021
  Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
  modify by : Kridtiya i. A66-0266 เพิ่มการบันทึกข้อมูล

+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR . 
DEF  VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
DEF  VAR n_date AS CHAR FORMAT "x(15)" INIT "" .
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_save bu_exit bu_detail2 bu_detail1 ~
fi_companyfull1 fi_brcomreceip1 fi_receipticno1 fi_userup fi_receiptaddr1 ~
fi_premt1 fi_companyfull2 fi_brcomreceip2 fi_receiptaddr2 fi_receipticno2 ~
fi_premt2 fi_companyfull3 fi_brcomreceip3 fi_receiptaddr3 fi_receipticno3 ~
fi_premt3 fi_campaigncode fi_typofpay bu_detail-3 fi_producer fi_agent ~
fi_branch fi_ispno fi_policyno fi_susspect fi_statuspol RECT-335 RECT-465 ~
RECT-503 
&Scoped-Define DISPLAYED-OBJECTS fi_companyfull1 fi_brcomreceip1 ~
fi_receipticno1 fi_userup fi_receiptaddr1 fi_premt1 fi_companyfull2 ~
fi_brcomreceip2 fi_receiptaddr2 fi_receipticno2 fi_premt2 fi_companyfull3 ~
fi_brcomreceip3 fi_receiptaddr3 fi_receipticno3 fi_premt3 fi_campaigncode ~
fi_typofpay fi_producer fi_agent fi_branch fi_ispno fi_policyno fi_susspect ~
fi_statuspol 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_detail-3 
     LABEL "หน้า3" 
     SIZE 15 BY 1.52
     BGCOLOR 7 FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_detail1 
     LABEL "หน้า1" 
     SIZE 15 BY 1.52
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_detail2 
     LABEL "หน้า2" 
     SIZE 15 BY 1.52
     BGCOLOR 7 FGCOLOR 0 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1.14
     BGCOLOR 6 FGCOLOR 15 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.83 BY 1.14
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brcomreceip1 AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brcomreceip2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_brcomreceip3 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_campaigncode AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_companyfull1 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_companyfull2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_companyfull3 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 76 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 38 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_policyno AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premt1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premt2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_premt3 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_receiptaddr1 AS CHARACTER FORMAT "X(250)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_receiptaddr2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_receiptaddr3 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 100 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_receipticno1 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_receipticno2 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_receipticno3 AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_statuspol AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_susspect AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 112 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_typofpay AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_userup AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-335
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 130.5 BY 21.86
     BGCOLOR 19 FGCOLOR 0 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 127.5 BY 12.71
     BGCOLOR 19 FGCOLOR 2 .

DEFINE RECTANGLE RECT-503
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 22.5 BY 1.67
     BGCOLOR 10 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_save AT ROW 1.24 COL 110
     bu_exit AT ROW 1.24 COL 119
     bu_detail2 AT ROW 1.1 COL 16.83
     bu_detail1 AT ROW 1.1 COL 1.67
     fi_companyfull1 AT ROW 4.1 COL 27 COLON-ALIGNED NO-LABEL
     fi_brcomreceip1 AT ROW 4.1 COL 109 COLON-ALIGNED NO-LABEL
     fi_receipticno1 AT ROW 6.29 COL 27 COLON-ALIGNED NO-LABEL
     fi_userup AT ROW 1.24 COL 74.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_receiptaddr1 AT ROW 5.19 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_premt1 AT ROW 6.29 COL 68 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_companyfull2 AT ROW 7.67 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_brcomreceip2 AT ROW 7.67 COL 109.33 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_receiptaddr2 AT ROW 8.76 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 48
     fi_receipticno2 AT ROW 9.86 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_premt2 AT ROW 9.86 COL 68.83 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fi_companyfull3 AT ROW 11.1 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fi_brcomreceip3 AT ROW 11 COL 109.17 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_receiptaddr3 AT ROW 12.19 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 68
     fi_receipticno3 AT ROW 13.33 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 72
     fi_premt3 AT ROW 13.33 COL 68.83 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     fi_campaigncode AT ROW 14.52 COL 27 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     fi_typofpay AT ROW 14.52 COL 69 COLON-ALIGNED NO-LABEL WIDGET-ID 84
     bu_detail-3 AT ROW 1.1 COL 32.17 WIDGET-ID 88
     fi_producer AT ROW 16.24 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 90
     fi_agent AT ROW 17.38 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 94
     fi_branch AT ROW 18.48 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     fi_ispno AT ROW 22 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 102
     fi_policyno AT ROW 19.62 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 106
     fi_susspect AT ROW 23.19 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fi_statuspol AT ROW 20.81 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 114
     "เลขที่ผู้เสียภาษี3" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 13.29 COL 4 WIDGET-ID 74
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สาขา" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 11 COL 105.67 WIDGET-ID 66
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อัตราเบี้ยตามใบกำกับ3" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 13.38 COL 50 WIDGET-ID 78
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อบริษัทเต็มบนใบกำกับภาษี1" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 4.1 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Producer" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 16.29 COL 4 WIDGET-ID 92
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "สาขา" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 4.1 COL 105.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่แคมเปญ" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 14.52 COL 4 WIDGET-ID 82
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทการชำระเบี้ย" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 14.52 COL 49.83 WIDGET-ID 86
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "สาขา" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 7.67 COL 105.83 WIDGET-ID 46
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Status" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 20.91 COL 4 WIDGET-ID 116
          BGCOLOR 19 FGCOLOR 2 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "  ใบเสร็จ" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 2.81 COL 3.67
          BGCOLOR 19 FGCOLOR 6 FONT 6
     "Policy" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 19.67 COL 4 WIDGET-ID 108
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "เลขที่ผู้เสียภาษี2" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 9.76 COL 4 WIDGET-ID 54
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่ผู้เสียภาษี1" VIEW-AS TEXT
          SIZE 23.5 BY .91 AT ROW 6.29 COL 4
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อัตราเบี้ยตามใบกำกับ2" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 9.86 COL 50.17 WIDGET-ID 58
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Agent" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 17.43 COL 4 WIDGET-ID 96
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Branch" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 18.52 COL 4 WIDGET-ID 100
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ที่อยู่บนใบกำกับภาษี2" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 8.67 COL 4 WIDGET-ID 50
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Inspection NO" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 22 COL 4 WIDGET-ID 104
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ชื่อบริษัทเต็มบนใบกำกับภาษี2" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 7.67 COL 4 WIDGET-ID 42
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Susspect !!!" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 23.19 COL 4 WIDGET-ID 112
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "ที่อยู่บนใบกำกับภาษี3" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 12.19 COL 4 WIDGET-ID 70
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อบริษัทเต็มบนใบกำกับภาษี3" VIEW-AS TEXT
          SIZE 24 BY .91 AT ROW 11.1 COL 4 WIDGET-ID 62
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่อยู่บนใบกำกับภาษี1" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 5.19 COL 4 WIDGET-ID 34
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Update By :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 1.24 COL 64.5 WIDGET-ID 12
          FGCOLOR 15 FONT 6
     "อัตราเบี้ยตามใบกำกับ1" VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 6.29 COL 50 WIDGET-ID 38
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-335 AT ROW 2.71 COL 2.5
     RECT-465 AT ROW 3.29 COL 3.17
     RECT-503 AT ROW 1 COL 107.5 WIDGET-ID 18
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 31 FGCOLOR 2 .


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
         TITLE              = "Update Data Notify AYCAL"
         HEIGHT             = 24.05
         WIDTH              = 132.67
         MAX-HEIGHT         = 37.76
         MAX-WIDTH          = 178
         VIRTUAL-HEIGHT     = 37.76
         VIRTUAL-WIDTH      = 178
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
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
       fi_userup:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Notify AYCAL */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Notify AYCAL */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_detail1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail1 C-Win
ON CHOOSE OF bu_detail1 IN FRAME fr_main /* หน้า1 */
DO:
     nv_recidtlt  =  Recid(tlt).
    
    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\WGWQHCT1(Input  nv_recidtlt).
    Apply "Close"  To this-procedure.
    Return no-apply.
    {&WINDOW-NAME}:hidden  =  No. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_detail2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail2 C-Win
ON CHOOSE OF bu_detail2 IN FRAME fr_main /* หน้า2 */
DO:
  nv_recidtlt  =  Recid(tlt).
    
    {&WINDOW-NAME}:hidden  =  Yes. 
    
    Run  wgw\WGWQHCT2(Input  nv_recidtlt).
    Apply "Close"  To this-procedure.
    Return no-apply.
    {&WINDOW-NAME}:hidden  =  No. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close"  To this-procedure.
  Return no-apply.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                Assign
                brstat.tlt.acno1      =  fi_producer   
                brstat.tlt.agent      =  fi_agent      
                brstat.tlt.ins_brins  =  fi_branch     
                brstat.tlt.policy     =  fi_policyno   
                brstat.tlt.id_typ     =  fi_ispno      
                brstat.tlt.filler1    =  fi_susspect 
                brstat.tlt.releas     =  fi_statuspol .
                   
            END.                                                    
            /*Apply "Close" to this-procedure.
            Return no-apply.*/
             APPLY "entry" TO fi_producer.
            RETURN NO-APPLY. 
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_producer.
            RETURN NO-APPLY.
        END.
        END CASE.
Disp  fi_producer with  frame  fr_main.
RELEASE brstat.tlt.
 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
  fi_agent = INPUT fi_agent.
  DISP fi_agent WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
   fi_branch = INPUT fi_branch .
    DISP fi_branch WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ispno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ispno C-Win
ON LEAVE OF fi_ispno IN FRAME fr_main
DO:
    fi_ispno = INPUT fi_ispno.
    DISP fi_ispno WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policyno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policyno C-Win
ON LEAVE OF fi_policyno IN FRAME fr_main
DO:
    fi_policyno = INPUT fi_policyno .
    DISP fi_policyno WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    DISP fi_producer WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_statuspol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_statuspol C-Win
ON LEAVE OF fi_statuspol IN FRAME fr_main
DO:
    fi_statuspol = INPUT fi_statuspol .
    DISP fi_statuspol WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_susspect
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_susspect C-Win
ON LEAVE OF fi_susspect IN FRAME fr_main
DO:
  fi_susspect  = INPUT fi_susspect.
  DISP fi_susspect WITH FRAM fr_main.
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
  
  gv_prgid = "WGWQHCT3".
  gv_prog  = "Query & Update Notify (HCT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
 
  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      Assign
          

          fi_companyfull1      =    brstat.tlt.safe3            
          fi_brcomreceip1      =    brstat.tlt.sex              
          fi_receiptaddr1      =    brstat.tlt.stat             
          fi_receipticno1      =    brstat.tlt.subins           
          fi_premt1            =    brstat.tlt.tel 
          fi_companyfull2      =    brstat.tlt.tel2             
          fi_brcomreceip2      =    brstat.tlt.tel3             
          fi_receiptaddr2      =    brstat.tlt.usrid            
          fi_receipticno2      =    brstat.tlt.usrsent          
          fi_premt2            =    brstat.tlt.ln_product 
          fi_companyfull3      =    brstat.tlt.ln_pronme        
          fi_brcomreceip3      =    brstat.tlt.ln_rate          
          fi_receiptaddr3      =    brstat.tlt.ln_st            
          fi_receipticno3      =    brstat.tlt.lotno            
          fi_premt3            =    brstat.tlt.maritalsts       
          fi_campaigncode      =    brstat.tlt.campaign         
          fi_typofpay          =    brstat.tlt.mobile
          fi_branch            =    brstat.tlt.ins_brins       
          fi_producer          =    brstat.tlt.acno1              
          fi_agent             =    brstat.tlt.agent
          fi_policyno          =    brstat.tlt.policy
          fi_ispno             =    brstat.tlt.id_typ 
          fi_susspect          =    brstat.tlt.filler1
          fi_statuspol         =    brstat.tlt.releas
          .          
      /*RUN proc_assignfi .*/

      DISP    fi_companyfull1       
          fi_brcomreceip1  fi_receiptaddr1  fi_receipticno1  fi_premt1  fi_companyfull2    fi_brcomreceip2       
          fi_receiptaddr2  fi_receipticno2  fi_premt2   fi_companyfull3   fi_brcomreceip3   fi_receiptaddr3  
          fi_branch         fi_producer     fi_agent    fi_policyno   fi_ispno    fi_susspect   fi_statuspol
          fi_receipticno3  fi_premt3   fi_campaigncode  fi_typofpay   bu_detail1        bu_save       bu_exit WITH frame  fr_main. 
          bu_detail2:BGCOLOR = 19.
          bu_detail2:FGCOLOR = 6. 
          /*DISABLE bu_detail2 WITH FRAME fr_main.*/

  End.
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
  DISPLAY fi_companyfull1 fi_brcomreceip1 fi_receipticno1 fi_userup 
          fi_receiptaddr1 fi_premt1 fi_companyfull2 fi_brcomreceip2 
          fi_receiptaddr2 fi_receipticno2 fi_premt2 fi_companyfull3 
          fi_brcomreceip3 fi_receiptaddr3 fi_receipticno3 fi_premt3 
          fi_campaigncode fi_typofpay fi_producer fi_agent fi_branch fi_ispno 
          fi_policyno fi_susspect fi_statuspol 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_save bu_exit bu_detail2 bu_detail1 fi_companyfull1 fi_brcomreceip1 
         fi_receipticno1 fi_userup fi_receiptaddr1 fi_premt1 fi_companyfull2 
         fi_brcomreceip2 fi_receiptaddr2 fi_receipticno2 fi_premt2 
         fi_companyfull3 fi_brcomreceip3 fi_receiptaddr3 fi_receipticno3 
         fi_premt3 fi_campaigncode fi_typofpay bu_detail-3 fi_producer fi_agent 
         fi_branch fi_ispno fi_policyno fi_susspect fi_statuspol RECT-335 
         RECT-465 RECT-503 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi C-Win 
PROCEDURE proc_assignfi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    /*
    ASSIGN 
        /*-- อุปกรณ์ตกแต่ง ---*/
        fi_accpric5  = INT(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        fi_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        fi_accpric4  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        fi_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        fi_accpric3  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        fi_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        fi_accpric2  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        fi_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        fi_accpric1  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        fi_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        fi_inspdate  = brstat.tlt.nor_effdat   
        fi_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"InspDe:") + 7 ))
        fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))    /* Car Inspection Phone            */
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))  
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))                            /* Car Inspection Name             */                                   
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))                          
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))                            /* Car Inspection Location         */

        fi_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))
        fi_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        fi_lang      = TRIM(brstat.tlt.exp).
        */
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi-bp C-Win 
PROCEDURE proc_assignfi-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    ASSIGN 
        /*-- อุปกรณ์ตกแต่ง ---*/
        fi_accpric5  = INT(substr(brstat.tlt.filler1,R-INDEX(brstat.tlt.filler1,"Acp5:") + 5))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler1,1,R-INDEX(brstat.tlt.filler1,"Acp5:") - 2 ))
        fi_accdet5   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd5:") - 2))
        /*fi_accr5     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc5:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc5:") - 2 ))*/
        fi_accpric4  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp4:") - 2 ))
        fi_accdet4   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd4:") - 2 ))
        /*fi_accr4     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc4:") + 5 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc4:") - 2 ))*/
        fi_accpric3  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp3:") - 2 ))
        fi_accdet3   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd3:") - 2 )) 
        /*fi_accr3     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc3:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc3:") - 2 ))*/
        fi_accpric2  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp2:") - 2 ))
        fi_accdet2   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd2:") - 2 ))
        /*fi_accr2     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc2:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acc2:") - 2 ))*/
        fi_accpric1  = INT(SUBSTR(n_char,R-INDEX(n_char,"Acp1:") + 5 )) 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acp1:") - 2 ))  
        fi_accdet1   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acd1:") + 5 )) 
        /*n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Acd1:") - 2 ))
        fi_accr1     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Acc1:") + 5 ))*/
        fi_inspdate  = brstat.tlt.nor_effdat   
        /*fi_appdate   = brstat.tlt.comp_effdat */
        fi_inspres   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,8,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") - 8))
        /*fi_inspdet   = TRIM(SUBSTR(brstat.tlt.nor_noti_tlt,R-INDEX(brstat.tlt.nor_noti_tlt,"Inspde:") + 7))*/
       /* fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bcode:") + 6 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bcode:") - 2 ))
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Blice:") + 6 ))*/

        fi_brocod    = TRIM(SUBSTR(brstat.tlt.old_eng,R-INDEX(brstat.tlt.old_eng,"Bloca:") + 6 ))    /* Car Inspection Phone            */
        n_char       = TRIM(SUBSTR(brstat.tlt.old_eng,1,R-INDEX(brstat.tlt.old_eng,"Bloca:") - 2 ))  
        fi_bronam    = TRIM(SUBSTR(n_char,R-INDEX(n_char,"bname:") + 6 ))                            /* Car Inspection Name             */                                   
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"bname:") - 2 ))                          
        fi_brolincen = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Bphon:") + 6 ))                            /* Car Inspection Location         */

        fi_remark    = TRIM(SUBSTR(brstat.tlt.filler2,R-INDEX(brstat.tlt.filler2,"Remark:") + 7 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.filler2,1,R-INDEX(brstat.tlt.filler2,"Remark:") - 2 ))
        /*fi_gift      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai4:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Detai4:") - 2 ))*/
        fi_remarksend = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai3:") + 7 ))
        /*n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai3:") - 2 ))
        fi_polsend   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai2:") + 7 ))
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"detai2:") - 2 ))
        fi_lang      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Detai1:") + 7 ))*/ 
        fi_lang      = TRIM(brstat.tlt.exp).
END.*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

