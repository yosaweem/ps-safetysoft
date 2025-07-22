&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
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
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEF INPUT PARAMETER nv_recid AS RECID.
DEF OUTPUT PARAMETER nv_cam AS CHAR.
/* Local Variable Definitions ---                                       */
DEF VAR  n_tarif           AS CHAR.

DEF VAR n_tmp1  AS CHAR INIT "".
DEF VAR n_tmp2  AS CHAR INIT "".
DEF VAR n_tmp3  AS CHAR INIT "".
DEF VAR n_tmp4  AS CHAR INIT "".
DEF VAR n_tmp5  AS CHAR INIT "".
DEF VAR n_tmp6  AS CHAR INIT "".
DEF VAR n_tmp7  AS CHAR INIT "".
DEF VAR n_tmp8  AS CHAR INIT "".
DEF VAR n_tmp9  AS CHAR INIT "".
DEF VAR n_tmp10 AS CHAR INIT "".
DEF VAR n_tmp11 AS CHAR INIT "".
DEF VAR n_tmp12 AS CHAR INIT "".
DEF VAR n_check AS LOGICAL INIT NO .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bt_update bt_exit 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON bt_exit AUTO-END-KEY 
     LABEL "EXIT" 
     SIZE 15 BY 1.62
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bt_update 
     LABEL "UPDATE" 
     SIZE 15 BY 1.62
     BGCOLOR 23 FGCOLOR 15 FONT 6.

DEFINE VARIABLE fi_pol AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51.83 BY 1
     FGCOLOR 2 FONT 2 NO-UNDO.

DEFINE BUTTON bt_check 
     LABEL "Check Premium" 
     SIZE 19 BY 1.62
     BGCOLOR 5 FONT 6.

DEFINE VARIABLE fi_gar AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEM-PAIRS "ซ่อมอู่","ซ่อมอู่",
                     "ซ่อมห้าง","ซ่อมห้าง",
                     "ซ่อมห้าง(H)","ซ่อมห้าง(H)"
     DROP-DOWN-LIST
     SIZE 19.33 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 16.67 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_camdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 51.5 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_camp AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.67 BY 1 NO-UNDO.

DEFINE VARIABLE fi_class AS CHARACTER FORMAT "X(5)":U 
      VIEW-AS TEXT 
     SIZE 10.67 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_coverage AS CHARACTER FORMAT "X(5)":U 
      VIEW-AS TEXT 
     SIZE 10.67 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_cst AS CHARACTER FORMAT "X(20)":U 
      VIEW-AS TEXT 
     SIZE 22 BY 1 NO-UNDO.

DEFINE VARIABLE fi_cst2 AS INTEGER FORMAT ">>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 16.67 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_cyear AS INTEGER FORMAT ">9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 7.17 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_gp AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.67 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 44 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_np AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.67 BY 1
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_si AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19.67 BY 1 TOOLTIP "* จะอัพเดทก็ต่อเมื่อมีการเปลี่ยนแปลงเบี้ยเท่านั้น"
     FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehicle AS CHARACTER FORMAT "X(1)":U 
      VIEW-AS TEXT 
     SIZE 10.67 BY 1
     FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_vehiclegr AS CHARACTER FORMAT "X(1)":U 
      VIEW-AS TEXT 
     SIZE 10.67 BY 1
     FGCOLOR 2  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     bt_update AT ROW 4.14 COL 101.67 WIDGET-ID 2
     bt_exit AT ROW 6.1 COL 101.67 WIDGET-ID 4
     SPACE(0.65) SKIP(10.22)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 53 
         TITLE "wgwetcam - Update Memo Text" WIDGET-ID 100.

DEFINE FRAME fr_head
     fi_pol AT ROW 2.67 COL 16.67 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     "Update Premium Campaign" VIEW-AS TEXT
          SIZE 38 BY 1.43 AT ROW 1.14 COL 39 WIDGET-ID 2
          FONT 27
     "Policy No." VIEW-AS TEXT
          SIZE 15.33 BY .95 AT ROW 2.67 COL 2.17 WIDGET-ID 6
          FONT 2
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 1.14
         SIZE 115.5 BY 2.86 WIDGET-ID 200.

DEFINE FRAME fr_txt
     fi_camp AT ROW 1.24 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 26
     bt_check AT ROW 3.14 COL 78 WIDGET-ID 54
     fi_gar AT ROW 6 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fi_si AT ROW 9.57 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 22
     fi_np AT ROW 10.71 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_gp AT ROW 10.71 COL 64 COLON-ALIGNED NO-LABEL WIDGET-ID 30
     fi_model AT ROW 11.81 COL 52.83 COLON-ALIGNED NO-LABEL WIDGET-ID 86
     fi_camdes AT ROW 1.24 COL 45 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_class AT ROW 2.43 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 62
     fi_coverage AT ROW 3.62 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 66
     fi_vehiclegr AT ROW 4.86 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     fi_vehicle AT ROW 4.86 COL 73 RIGHT-ALIGNED NO-LABEL WIDGET-ID 70
     fi_cst AT ROW 7.19 COL 2 NO-LABEL WIDGET-ID 72
     fi_cst2 AT ROW 7.19 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     fi_cyear AT ROW 8.38 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_brand AT ROW 11.81 COL 24.33 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     "*" VIEW-AS TEXT
          SIZE 1.83 BY 1 AT ROW 11.81 COL 52.83 WIDGET-ID 98
          FONT 2
     "( * ) ไม่สามารถเปลี่ยนแปลงได้ สำหรับค้นหา" VIEW-AS TEXT
          SIZE 41.5 BY 1 AT ROW 13.67 COL 56.83 WIDGET-ID 96
          FONT 6
     "Class:" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 2.43 COL 2 WIDGET-ID 60
          FONT 6
     "Vehicle group:" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 4.81 COL 2 WIDGET-ID 68
          FONT 6
     "Car Year:" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 8.38 COL 2 WIDGET-ID 76
          FONT 6
     "Model:" VIEW-AS TEXT
          SIZE 6.67 BY 1 AT ROW 11.81 COL 44.83 WIDGET-ID 84
          FONT 6
     "Net Premium:" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 10.71 COL 2 WIDGET-ID 6
          FONT 6
     "Gross Premium:" VIEW-AS TEXT
          SIZE 15.83 BY .95 AT ROW 10.71 COL 49 WIDGET-ID 8
          FONT 6
     "Brand:" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 11.81 COL 2 WIDGET-ID 80
          FONT 6
     "Coverage:" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 3.62 COL 2 WIDGET-ID 64
          FONT 6
     "Campaign:" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 1.24 COL 2 WIDGET-ID 20
          FONT 6
     "Sum Insurance:" VIEW-AS TEXT
          SIZE 22 BY .95 AT ROW 9.62 COL 2 WIDGET-ID 58
          FONT 6
     "Garage:" VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 6 COL 2 WIDGET-ID 48
          FONT 6
     "*" VIEW-AS TEXT
          SIZE 1.83 BY 1 AT ROW 9.67 COL 24.17 WIDGET-ID 88
          FGCOLOR 6 FONT 2
     "( * ) จะอัพเดทก็ต่อเมื่อมีการเปลี่ยนแปลงเบี้ยเท่านั้น" VIEW-AS TEXT
          SIZE 42.83 BY 1 AT ROW 12.86 COL 56.83 WIDGET-ID 90
          FGCOLOR 6 FONT 6
     "Vehicle use:" VIEW-AS TEXT
          SIZE 13 BY 1 AT ROW 4.86 COL 49 WIDGET-ID 94
          FONT 6
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 4.05
         SIZE 99.5 BY 13.86
         FONT 6 WIDGET-ID 300.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* REPARENT FRAME */
ASSIGN FRAME fr_head:FRAME = FRAME Dialog-Frame:HANDLE
       FRAME fr_txt:FRAME = FRAME Dialog-Frame:HANDLE.

/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME                                                           */

DEFINE VARIABLE XXTABVALXX AS LOGICAL NO-UNDO.

ASSIGN XXTABVALXX = FRAME fr_txt:MOVE-BEFORE-TAB-ITEM (bt_update:HANDLE IN FRAME Dialog-Frame)
       XXTABVALXX = FRAME fr_head:MOVE-BEFORE-TAB-ITEM (FRAME fr_txt:HANDLE)
/* END-ASSIGN-TABS */.

ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FRAME fr_head
                                                                        */
/* SETTINGS FOR FRAME fr_txt
                                                                        */
/* SETTINGS FOR FILL-IN fi_cst IN FRAME fr_txt
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_vehicle IN FRAME fr_txt
   ALIGN-R                                                              */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* wgwetcam - Update Memo Text */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_txt
&Scoped-define SELF-NAME bt_check
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_check Dialog-Frame
ON CHOOSE OF bt_check IN FRAME fr_txt /* Check Premium */
DO:
    RUN pd_genprm("check").
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME Dialog-Frame
&Scoped-define SELF-NAME bt_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bt_update Dialog-Frame
ON CHOOSE OF bt_update IN FRAME Dialog-Frame /* UPDATE */
DO:
    DEF VAR n_text AS CHAR  FORMAT "x(20)"  INIT "" .
    IF n_check = YES THEN DO:

     MESSAGE "Would you like to update premiums?" 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        TITLE "" UPDATE lChoice AS LOGICAL.
    
        n_text = "     Waiting update ".

    END.
    ELSE n_text = "     Waiting update text  ".

    DISP  n_text  FONT 27 BGCOLOR 34 FGCOLOR 2 WITH FRAME msgbox NO-LABEL VIEW-AS DIALOG-BOX
    TITLE "Update Text" .
    PAUSE 1 NO-MESSAGE.

    IF lChoice THEN RUN pd_genprm("update").

    RUN pd_update.
    
    n_text = "     Update Complete ".
    DISP n_text WITH FRAME  msgbox.
    PAUSE 1 NO-MESSAGE.
    CLEAR FRAME msgbox.
    HIDE FRAME msgbox.

    IF n_check = YES THEN RUN pd_request.


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_txt
&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand Dialog-Frame
ON LEAVE OF fi_brand IN FRAME fr_txt
DO:
    fi_model = INPUT fi_model.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_camp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_camp Dialog-Frame
ON LEAVE OF fi_camp IN FRAME fr_txt
DO:
    fi_camp = INPUT fi_camp.
    fi_camdes = "".
    IF fi_camp <> "" THEN DO:
        FIND FIRST stat.campaign_fil USE-INDEX campfil01 WHERE stat.campaign_fil.camcod =  fi_camp  NO-LOCK NO-ERROR.
        IF AVAIL stat.campaign_fil THEN DO: 
            fi_camdes:FGCOLOR IN FRAME fr_txt = 2.
            fi_camdes = stat.campaign_fil.camnam .
        END.
        ELSE DO: 
            fi_camdes:FGCOLOR IN FRAME fr_txt = 6.
            fi_camdes = "Not found campaign code in system".
        END.
    END.
    DISP fi_camdes WITH FRAME fr_txt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_class
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_class Dialog-Frame
ON LEAVE OF fi_class IN FRAME fr_txt
DO:
    fi_class = INPUT fi_class.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_coverage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_coverage Dialog-Frame
ON LEAVE OF fi_coverage IN FRAME fr_txt
DO:
    fi_coverage = INPUT fi_coverage.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cst
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cst Dialog-Frame
ON LEAVE OF fi_cst IN FRAME fr_txt
DO:
    fi_cst2 = INPUT fi_cst2.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cst2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cst2 Dialog-Frame
ON LEAVE OF fi_cst2 IN FRAME fr_txt
DO:
    fi_cst2 = INPUT fi_cst2.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cyear Dialog-Frame
ON LEAVE OF fi_cyear IN FRAME fr_txt
DO:
    fi_cyear = INPUT fi_cyear.
   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gar
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gar Dialog-Frame
ON VALUE-CHANGED OF fi_gar IN FRAME fr_txt
DO:
    fi_gar = INPUT fi_gar.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_gp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_gp Dialog-Frame
ON LEAVE OF fi_gp IN FRAME fr_txt
DO:
    fi_gp = INPUT fi_gp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model Dialog-Frame
ON LEAVE OF fi_model IN FRAME fr_txt
DO:
    fi_model = INPUT fi_model.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_np
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_np Dialog-Frame
ON LEAVE OF fi_np IN FRAME fr_txt
DO:
    fi_gp = INPUT fi_gp.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_head
&Scoped-define SELF-NAME fi_pol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pol Dialog-Frame
ON LEAVE OF fi_pol IN FRAME fr_head
DO:
    fi_pol = INPUT fi_pol.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME fr_txt
&Scoped-define SELF-NAME fi_si
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_si Dialog-Frame
ON LEAVE OF fi_si IN FRAME fr_txt
DO:
    fi_si = INPUT fi_si.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehicle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehicle Dialog-Frame
ON LEAVE OF fi_vehicle IN FRAME fr_txt
DO:
    fi_vehicle = INPUT fi_vehicle.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehiclegr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehiclegr Dialog-Frame
ON LEAVE OF fi_vehiclegr IN FRAME fr_txt
DO:
    fi_vehiclegr = INPUT fi_vehiclegr.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME Dialog-Frame
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  SESSION:DATA-ENTRY-RETURN = YES.
  DISABLE fi_camp WITH FRAME fr_txt.
  RUN pd_request.

  WAIT-FOR CLOSE OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
  HIDE FRAME fr_head.
  HIDE FRAME fr_txt.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  ENABLE bt_update bt_exit 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
  DISPLAY fi_pol 
      WITH FRAME fr_head.
  ENABLE fi_pol 
      WITH FRAME fr_head.
  {&OPEN-BROWSERS-IN-QUERY-fr_head}
  DISPLAY fi_camp fi_gar fi_si fi_np fi_gp fi_model fi_camdes fi_class 
          fi_coverage fi_vehiclegr fi_vehicle fi_cst fi_cst2 fi_cyear fi_brand 
      WITH FRAME fr_txt.
  ENABLE fi_camp bt_check fi_gar fi_si fi_np fi_gp fi_model fi_camdes fi_class 
         fi_coverage fi_vehiclegr fi_vehicle fi_cst fi_cst2 fi_cyear fi_brand 
      WITH FRAME fr_txt.
  {&OPEN-BROWSERS-IN-QUERY-fr_txt}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_genprm Dialog-Frame 
PROCEDURE pd_genprm :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_mode AS CHAR INIT "".
    DEF VAR  n_PromotionNumber AS CHAR.
    DEF VAR  n_class           AS CHAR.
    DEF VAR  n_covcod          AS CHAR.
    DEF VAR  n_vehgrp          AS CHAR.
    DEF VAR  n_vehuse          AS CHAR.
    DEF VAR  n_garage          AS CHAR.
    DEF VAR  n_seate           AS INTE.
    DEF VAR  n_engine          AS INTE.
    DEF VAR  n_tons            AS INTE.
    DEF VAR  n_yrmanu          AS INTE.
    DEF VAR  n_uom6_u          AS DECI.
    DEF VAR  n_Brand           AS CHAR.
    DEF VAR  n_Model           AS CHAR.
    DEF VAR  n_tarif           AS CHAR.
    DEF VAR  n_messe           AS CHAR.
    DEF VAR  n_writtenAmt      AS DECI FORMAT "->>>>>>>>>.99". 
    DEF VAR  n_currentTermAmt  AS DECI FORMAT "->>>>>>>>>.99". 

    IF TRIM(fi_gar) = "ซ่อมอู่" THEN n_garage = "".
    ELSE IF TRIM(fi_gar) = "ซ่อมห้าง" THEN n_garage = "G".
    ELSE IF TRIM(fi_gar) = "ซ่อมห้าง(H)" THEN n_garage = "H".
    n_check = NO.
    RUN wgw\wgwetrprm(INPUT  nv_mode        ,   
                      INPUT  fi_pol         ,          
                      INPUT  fi_camp        ,   
                      INPUT  fi_class       ,   
                      INPUT  fi_coverage    , 
                      INPUT  fi_vehiclegr   ,
                      INPUT  fi_vehicle     ,   
                      INPUT  n_garage       ,   
                      INPUT  fi_cst2        ,   
                      INPUT  fi_cyear       ,   
                      INPUT  fi_si          ,   
                      INPUT  fi_np          ,   
                      INPUT  fi_gp          ,   
                      INPUT  fi_brand       ,   
                      INPUT  fi_model       ,   
                      INPUT  n_tarif        ,   
                      OUTPUT n_messe        ).  

    IF n_messe <> "" THEN DO:
        MESSAGE n_messe  VIEW-AS ALERT-BOX INFORMATION TITLE "ไม่พบข้อมูล Campaign !!!".
    END.
    ELSE n_check = YES.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_request Dialog-Frame 
PROCEDURE pd_request :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DISP "     Waitingt load text     " FONT 27 BGCOLOR 34 FGCOLOR 2 WITH FRAME msgbox NO-LABEL VIEW-AS DIALOG-BOX
    TITLE "load Text" .
    PAUSE 1 NO-MESSAGE.
DEF VAR nv_fptr AS RECID .
DEF VAR fi_model2 AS CHAR INIT "".
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_recid NO-LOCK NO-ERROR.
IF AVAILA sic_bran.uwm100 THEN DO:

    fi_pol = sic_bran.uwm100.policy.
    DISP fi_pol WITH FRAME fr_head.

    nv_fptr = sic_bran.uwm100.fptr02 .
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
      FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr NO-LOCK NO-ERROR.
      IF AVAILABLE sic_bran.uwd102 THEN DO:
          IF INDEX(sic_bran.uwd102.ltext,"Campaign") <> 0 THEN DO:
              ENABLE fi_camp WITH FRAME fr_txt.
              fi_camp = TRIM(ENTRY(2,sic_bran.uwd102.ltext,":")).
              nv_cam = TRIM(fi_camp).
              n_tmp3 = TRIM(fi_camp).
          END.
          ELSE IF INDEX(sic_bran.uwd102.ltext,"นำเข้า เบี้ยสุทธิ") <> 0 THEN DO:
              fi_np = TRIM(ENTRY(2,sic_bran.uwd102.ltext,":")).
              fi_np = SUBSTRIN(fi_np,1,INDEX(fi_np," ")).
              fi_gp = TRIM(ENTRY(3,sic_bran.uwd102.ltext,":")).
              n_tmp4 = fi_np.
              n_tmp5 = fi_gp.
          END.
          ELSE IF INDEX(sic_bran.uwd102.ltext,"Garage") <> 0 THEN DO:
              n_tmp12 = TRIM(ENTRY(2,sic_bran.uwd102.ltext,":")).
              fi_gar = ENTRY (1, n_tmp12).
              DISP fi_gar WITH FRAME fr_txt.
          END.
          nv_fptr = sic_bran.uwd102.fptr.
      END.
      ELSE LEAVE.
    END.

    FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE 
              sic_bran.uwm120.policy = sic_bran.uwm100.Policy AND 
              sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND 
              sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt NO-LOCK NO-ERROR.
    IF AVAIL sic_bran.uwm120 THEN DO: 
        ASSIGN
            fi_class = sic_bran.uwm120.CLASS.
        FIND LAST sic_bran.uwm130 USE-INDEX uwm13001 WHERE 
                       sic_bran.uwm130.policy = sic_bran.uwm120.policy AND
                       sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt AND          
                       sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt NO-LOCK NO-ERROR.
        IF AVAILA sic_bran.uwm130 THEN DO:
            ASSIGN
                fi_si = DECI(sic_bran.uwm130.uom6_v) NO-ERROR.
            FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101 WHERE 
                sic_bran.uwm301.policy = sic_bran.uwm130.policy AND 
                sic_bran.uwm301.rencnt = sic_bran.uwm130.rencnt AND 
                sic_bran.uwm301.endcnt = sic_bran.uwm130.endcnt NO-LOCK NO-ERROR.
            IF AVAIL sic_bran.uwm301 THEN DO:
                ASSIGN
                    n_tarif  = sic_bran.uwm301.tariff
                    fi_coverage = sic_bran.uwm301.covcod 
                    fi_vehicle = sic_bran.uwm301.vehuse
                    fi_vehiclegr = sic_bran.uwm301.vehgrp
                    fi_brand  = CAPS(TRIM(ENTRY(1,uwm301.moddes," ")))
                    fi_model  = CAPS(TRIM(ENTRY(2,uwm301.moddes," "))).
                    fi_cyear =  (YEAR(TODAY) - sic_bran.uwm301.yrmanu) + 1.

                    IF  INDEX(sic_bran.uwm120.CLASS,"110") <> 0 THEN DO: 
                        IF SUBSTRING(sic_bran.uwm120.CLASS,LENGTH(sic_bran.uwm120.CLASS),1) = "E" THEN DO:
                            fi_cst2 = sic_bran.uwm301.watts.
                            fi_cst  = "KW Engine:".
                        END.
                        ELSE DO:
                            fi_cst2 = sic_bran.uwm301.engine.
                            fi_cst  = "CC Engine:".
                        END.
                    END.
                    ELSE IF INDEX(sic_bran.uwm120.CLASS,"210") <> 0 THEN DO:
                        fi_cst2 =  sic_bran.uwm301.seats.
                        fi_cst    = "Seate:".
                    END.
                    ELSE IF INDEX(sic_bran.uwm120.CLASS,"320") <> 0 THEN DO: 
                        fi_cst2  =  sic_bran.uwm301.tons.
                        fi_cst   = "Tons:".
                    END.

            END.
        END.
    END.
END.
IF fi_camp <> "" THEN DO:
    FIND FIRST stat.campaign_fil USE-INDEX campfil01 WHERE stat.campaign_fil.camcod =  fi_camp  NO-LOCK NO-ERROR.
    IF AVAIL campaign_fil THEN DO:  
        fi_camdes:FGCOLOR IN FRAME fr_txt = 2.
        fi_camdes = stat.campaign_fil.camnam .

    END.
    ELSE DO: 
        fi_camdes:FGCOLOR IN FRAME fr_txt = 6.
        fi_camdes = "Not found campaign code in system".
    END.
END.

DISP fi_camp fi_camdes fi_class fi_coverage fi_vehiclegr fi_vehicle fi_gar fi_cst fi_cst2 fi_cyear fi_si fi_np fi_gp
    fi_brand fi_model WITH FRAME fr_txt.
CLEAR FRAME msgbox.
HIDE FRAME msgbox.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_update Dialog-Frame 
PROCEDURE pd_update :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_fptr AS RECID .
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_recid NO-LOCK NO-ERROR.
IF AVAILA sic_bran.uwm100 THEN DO:
    nv_fptr = sic_bran.uwm100.fptr02 .
    DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
      FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr NO-ERROR.
      IF AVAILABLE sic_bran.uwd102 THEN DO:
          IF INDEX(sic_bran.uwd102.ltext,"Campaign") <> 0 AND n_tmp3 <> fi_camp  THEN DO:
              IF n_tmp3 <> "" OR n_tmp3 <> " " THEN sic_bran.uwd102.ltext = REPLACE(sic_bran.uwd102.ltext,n_tmp3,fi_camp).
              ELSE sic_bran.uwd102.ltext = sic_bran.uwd102.ltext + " " + fi_camp.
              nv_cam = fi_camp.
          END.
          ELSE IF INDEX(sic_bran.uwd102.ltext,"นำเข้า เบี้ยสุทธิ") <> 0 AND (n_tmp4 <> fi_np OR n_tmp5 <> fi_gp )THEN DO:

               IF n_tmp4 <> "" OR n_tmp4 <> " " THEN sic_bran.uwd102.ltext = REPLACE(sic_bran.uwd102.ltext,n_tmp4,fi_np) .
               ELSE sic_bran.uwd102.ltext = sic_bran.uwd102.ltext + " " + fi_np.

               IF n_tmp5 <> "" OR n_tmp5 <> " " THEN sic_bran.uwd102.ltext = REPLACE(sic_bran.uwd102.ltext,n_tmp5,fi_gp) .
               ELSE sic_bran.uwd102.ltext = sic_bran.uwd102.ltext + " " + fi_gp.

              
          END.
          ELSE IF INDEX(sic_bran.uwd102.ltext,"Garage") <> 0 AND n_tmp12 <> fi_gar THEN DO:
              IF n_tmp12 <> ""  OR n_tmp12 <> " " THEN sic_bran.uwd102.ltext = REPLACE(sic_bran.uwd102.ltext,n_tmp12,fi_gar) .
              ELSE sic_bran.uwd102.ltext = sic_bran.uwd102.ltext + " " + fi_gar.
          END.
          nv_fptr = sic_bran.uwd102.fptr.
      END.
      ELSE LEAVE.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

