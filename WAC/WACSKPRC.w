&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME WUWSKPRC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWSKPRC 
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
DEFINE VAR nv_cnt1      AS INTEGER. 
DEFINE VAR nv_cnt2      AS INTEGER.
DEFINE VAR chr_sticker  AS CHAR     FORMAT "X(15)".
DEFINE VAR Chk_mod1     AS DEC. 
DEFINE VAR Chk_mod2     AS DEC. 
DEFINE VAR nv_modulo    AS INTEGER  FORMAT "9".
DEFINE VAR nv_cnt01     AS INTEGER.  
DEFINE VAR nv_cnt02     AS INTEGER.
DEFINE VAR nv_count     AS INTEGER.
DEFINE VAR nv_line      AS INTEGER.
DEFINE VAR nv_status    AS CHARACTER.
DEFINE VAR chr_status   AS CHARACTER FORMAT "x(35)".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-685 RECT-688 RECT-689 RECT-692 RECT-686 ~
RECT-695 RECT-696 RECT-697 rs_type fi_stknoF fi_stknoT bnt_ok fi_stklos ~
co_proc fi_datelos fi_polist fi_datepols bnt_oklos btn_exit fi_user ~
fi_sumstk fi_tot fi_year fi_dateprint fi_user2 fi_brn fi_prod fi_datopen ~
fi_userido 
&Scoped-Define DISPLAYED-OBJECTS rs_type fi_stknoF fi_stknoT fi_stklos ~
co_proc fi_datelos fi_polist fi_datepols fi_user fi_sumstk fi_tot fi_year ~
fi_dateprint fi_user2 fi_brn fi_prod fi_datopen fi_userido 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWSKPRC AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bnt_ok 
     LABEL "OK" 
     SIZE 11.5 BY 1.19
     FONT 6.

DEFINE BUTTON bnt_oklos 
     LABEL "OK" 
     SIZE 12.67 BY 1.48
     FONT 6.

DEFINE BUTTON btn_exit 
     LABEL "Exit" 
     SIZE 14 BY 1.43
     FONT 6.

DEFINE VARIABLE co_proc AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "ชำรุด","สูญหาย","ยกเลิกโดยผู้เอาประกันบอกเลิก","ยกเลิกโดยบริษัทบอกเลิก" 
     DROP-DOWN-LIST
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brn AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 6 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datelos AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datepols AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dateprint AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datopen AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_polist AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prod AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 13 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stklos AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_stknoF AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_stknoT AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_sumstk AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8 BY 1
     FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_tot AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8 BY 1
     FGCOLOR 6 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_user2 AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userido AS CHARACTER FORMAT "X(15)":U 
      VIEW-AS TEXT 
     SIZE 15 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_year AS CHARACTER FORMAT "X(4)":U 
      VIEW-AS TEXT 
     SIZE 9 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Process Sticker ยอดใช้ไป", 1,
"Process Sticker สูญหาย/ชำรุด", 2
     SIZE 68 BY 1
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-685
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 120 BY 2
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-686
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 120 BY 2.14
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-688
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 120 BY 4.29
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-689
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 120 BY 12.14
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-692
     EDGE-PIXELS 3 GRAPHIC-EDGE    
     SIZE 120 BY 1.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-695
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 14.83 BY 1.95
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-696
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.67 BY 1.76
     BGCOLOR 6 .

DEFINE RECTANGLE RECT-697
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.67
     BGCOLOR 1 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     rs_type AT ROW 3.76 COL 4.33 NO-LABEL 
     fi_stknoF AT ROW 6.71 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_stknoT AT ROW 6.71 COL 71.5 COLON-ALIGNED NO-LABEL 
     bnt_ok AT ROW 7.52 COL 107.67 
     fi_stklos AT ROW 11.24 COL 31.33 COLON-ALIGNED NO-LABEL
     co_proc AT ROW 12.62 COL 31.33 COLON-ALIGNED NO-LABEL
     fi_datelos AT ROW 14.1 COL 85 COLON-ALIGNED NO-LABEL 
     fi_polist AT ROW 15.62 COL 31 COLON-ALIGNED NO-LABEL 
     fi_datepols AT ROW 15.62 COL 85 COLON-ALIGNED NO-LABEL 
     bnt_oklos AT ROW 20 COL 106.5
     btn_exit AT ROW 22.57 COL 105
     fi_user AT ROW 3.71 COL 105.5 COLON-ALIGNED NO-LABEL 
     fi_sumstk AT ROW 8.19 COL 26.33 COLON-ALIGNED NO-LABEL
     fi_tot AT ROW 8.19 COL 71.5 COLON-ALIGNED NO-LABEL
     fi_year AT ROW 14.1 COL 31.17 COLON-ALIGNED NO-LABEL 
     fi_dateprint AT ROW 17.14 COL 85 COLON-ALIGNED NO-LABEL 
     fi_user2 AT ROW 17.29 COL 31 COLON-ALIGNED NO-LABEL 
     fi_brn AT ROW 18.86 COL 31 COLON-ALIGNED NO-LABEL 
     fi_prod AT ROW 18.86 COL 85.33 COLON-ALIGNED NO-LABEL  AUTO-RETURN 
     fi_datopen AT ROW 20.29 COL 31.17 COLON-ALIGNED NO-LABEL 
     fi_userido AT ROW 20.29 COL 85.17 COLON-ALIGNED NO-LABEL 
     "ปี พ.ศ.สติ๊กเกอร์  :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 14.1 COL 10 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "ฉบับ" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 8.19 COL 37.83 
          FGCOLOR 1 FONT 6
     "จำนวนสติ๊กเกอร์ใช้ไป  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 8.19 COL 49.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "จำนวนสติ๊กเกอร์ทั้งหมด  :" VIEW-AS TEXT
          SIZE 23 BY 1 AT ROW 8.19 COL 3.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "To. :" VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 6.81 COL 65.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "User ID ที่เบิก  :" VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 20.29 COL 66.5 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "User ID  :" VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 17.29 COL 17 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 18.86 COL 71 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "สถานะของสติ๊กเกอร์  :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 12.43 COL 7.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "วันที่เบิก  :" VIEW-AS TEXT
          SIZE 13.33 BY 1 AT ROW 20.24 COL 17.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Process สูญหาย/ชำรุด" VIEW-AS TEXT
          SIZE 119 BY .95 AT ROW 9.95 COL 2.33 
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "สน.ที่แจ้งความ  :" VIEW-AS TEXT
          SIZE 16.83 BY 1 AT ROW 15.62 COL 11.5 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "วันที่สูญหาย  :" VIEW-AS TEXT
          SIZE 13.67 BY 1 AT ROW 14.1 COL 68.67 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "วันที่แจ้งความ  :" VIEW-AS TEXT
          SIZE 15.5 BY 1 AT ROW 15.71 COL 66.83 
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 121.83 BY 23.52
         BGCOLOR 8  .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Process Sticker" VIEW-AS TEXT
          SIZE 25.5 BY .95 AT ROW 1.67 COL 49 
          BGCOLOR 3 FGCOLOR 7 FONT 23
     "Sticker No.From.  :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 11.33 COL 8.5 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Process Sticker ยอดใช้ไป" VIEW-AS TEXT
          SIZE 119 BY .95 AT ROW 5.48 COL 2.33
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "วันที่พิมพ์  :" VIEW-AS TEXT
          SIZE 13.33 BY 1 AT ROW 17.14 COL 70.33 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "ฉบับ" VIEW-AS TEXT
          SIZE 5 BY 1 AT ROW 8.19 COL 84 
          FGCOLOR 1 FONT 6
     "Sticker No.From.  :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 6.71 COL 8.17 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "สาขาที่เบิก  :" VIEW-AS TEXT
          SIZE 12.17 BY 1 AT ROW 18.86 COL 15.83 
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-685 AT ROW 1.19 COL 1.83 
     RECT-688 AT ROW 5.29 COL 1.83 
     RECT-689 AT ROW 9.81 COL 1.83 
     RECT-692 AT ROW 3.38 COL 1.83 
     RECT-686 AT ROW 22.19 COL 1.83
     RECT-695 AT ROW 19.76 COL 105.33
     RECT-696 AT ROW 22.38 COL 104.17
     RECT-697 AT ROW 7.29 COL 106.83 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 121.83 BY 23.52
         BGCOLOR 8  .


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
  CREATE WINDOW WUWSKPRC ASSIGN
         HIDDEN             = YES
         TITLE              = "Process Sticker"
         HEIGHT             = 23.52
         WIDTH              = 121.83
         MAX-HEIGHT         = 28.05
         MAX-WIDTH          = 141.83
         VIRTUAL-HEIGHT     = 28.05
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WUWSKPRC
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKPRC)
THEN WUWSKPRC:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWSKPRC
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKPRC WUWSKPRC
ON END-ERROR OF WUWSKPRC /* Process Sticker */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKPRC WUWSKPRC
ON WINDOW-CLOSE OF WUWSKPRC /* Process Sticker */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bnt_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bnt_ok WUWSKPRC
ON CHOOSE OF bnt_ok IN FRAME fr_main /* OK */
DO: 
    nv_line =  0.
    FOR EACH sckyear USE-INDEX sckyear  WHERE
             sckyear.sckno  >= fi_stknoF AND
             sckyear.sckno  <= fi_stknoT :
        
        FIND FIRST detaitem USE-INDEX detaitem11  WHERE
                 detaitem.serailno = sckyear.sckno NO-LOCK  NO-ERROR  NO-WAIT.
        IF AVAIL detaitem THEN DO:           
           FIND  uwm100 USE-INDEX uwm10001    WHERE            
                 uwm100.policy = detaitem.policy  AND            
                 uwm100.rencnt = detaitem.rencnt  AND            
                 uwm100.endcnt = detaitem.endcnt  NO-LOCK  NO-ERROR  NO-WAIT.                         
           IF AVAIL uwm100 THEN DO:                                             
              ASSIGN                                           
                  sckyear.policy   = detaitem.policy             
                  sckyear.rencnt   = detaitem.rencnt             
                  sckyear.endcnt   = detaitem.endcnt             
                  sckyear.riskno   = detaitem.riskno             
                  sckyear.itemno   = detaitem.itemno             
                  sckyear.expdat   = uwm100.expdat             
                  sckyear.releas   = uwm100.releas             
                  sckyear.trandat  = TODAY.  
              nv_line    = nv_line + 1.    
                  
           END.  
        END. /*--Avail detaitem---*/ 
    END.

     
     fi_tot = nv_line.
    MESSAGE " Process Sticker ยอดที่ใช้ไป Complete" VIEW-AS ALERT-BOX.
    DISP fi_tot WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bnt_oklos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bnt_oklos WUWSKPRC
ON CHOOSE OF bnt_oklos IN FRAME fr_main /* OK */
DO:
 FIND FIRST sckyear 
      WHERE sckyear.sckno = TRIM(fi_stklos) NO-LOCK NO-ERROR.
 IF AVAILABLE sckyear THEN DO:

     FIND FIRST notstk
          WHERE notstk.pol_mark = sckyear.sckno  NO-ERROR.
     IF AVAILABLE notstk THEN DO :
        ASSIGN
          notstk.stk_year       = fi_year   
          notstk.lost_dat       = fi_datelos
          notstk.notify_dat     = fi_datepols
          notstk.stk_sta        = nv_status
          notstk.police_station = fi_polist
          notstk.ent_dat        = fi_dateprint
          notstk.usrid          = fi_user2.
     END.
     ELSE DO:
         CREATE NOTSTK.
         ASSIGN
            notstk.ent_dat        =  fi_dateprint
            notstk.lost_dat       =  fi_datelos
            notstk.notify_dat     =  fi_datepols
            notstk.police_station =  fi_polist
            notstk.pol_mark       =  sckyear.sckno
            notstk.stk_sta        =  nv_status
            notstk.stk_year       =  fi_year
            notstk.usrid          =  fi_user2.
     END.

 END.
 MESSAGE  "Process สูญเสีย/ชำรุด Complete "  VIEW-AS ALERT-BOX.

 ASSIGN
   fi_dateprint  =  ?   
   fi_datelos    =  ?   
   fi_datepols   =  ?   
   fi_polist     =  ""  
   fi_stklos     =  ""  
   fi_year       =  ""  
   fi_stklos     =  ""  
   fi_brn        =  ""  
   fi_prod       =  ""  
   fi_dateprint  =  ?   
   fi_userido    =  ""   
   fi_datopen    =  ?   
   fi_user2      =  ""  
   fi_stklos     =  ""
   co_proc       = "ชำรุด". 
                    

    DISP fi_dateprint fi_datelos fi_datepols fi_polist fi_stklos 
         fi_year      fi_stklos  fi_brn      fi_prod   fi_dateprint 
         fi_userido   fi_datopen fi_user2    fi_stklos co_proc WITH FRAME fr_main.
            
           
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_exit WUWSKPRC
ON CHOOSE OF btn_exit IN FRAME fr_main /* Exit */
DO:
   APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME co_proc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL co_proc WUWSKPRC
ON VALUE-CHANGED OF co_proc IN FRAME fr_main
DO:
  co_proc = INPUT co_proc.


       IF co_proc  = "ชำรุด"   THEN nv_status = "2".
  ELSE IF co_proc  = "สูญหาย"  THEN nv_status = "3".
  ELSE IF co_proc  = "ยกเลิกโดยผู้เอาประกันบอกเลิก"  THEN nv_status = "4".
  ELSE IF co_proc  = "ยกเลิกโดยบริษัทบอกเลิก"        THEN nv_status = "5".

  DISP co_proc WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brn WUWSKPRC
ON LEAVE OF fi_brn IN FRAME fr_main
DO:
  fi_brn = INPUT fi_brn.
  DISP fi_brn WITH FRAME fi_brn.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datelos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datelos WUWSKPRC
ON LEAVE OF fi_datelos IN FRAME fr_main
DO:
  fi_datelos = INPUT fi_datelos.
  IF INTEGER(YEAR(input fi_datelos)) < 2500 THEN DO:
    
     MESSAGE " กรุณาใส่ปีเป็น พ.ศ." VIEW-AS ALERT-BOX WARNING .
     APPLY "ENTRY" TO fi_datelos.
  END.




  DISP fi_datelos WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datepols
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datepols WUWSKPRC
ON LEAVE OF fi_datepols IN FRAME fr_main
DO:
  fi_datepols = INPUT fi_datepols.

  IF INTEGER(YEAR(input fi_datepols )) < 2500 THEN DO:
     MESSAGE " กรุณาใส่ปีเป็น พ.ศ." VIEW-AS ALERT-BOX WARNING .
     APPLY "ENTRY" TO fi_datepols .
  END.



  DISP fi_datepols WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dateprint
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dateprint WUWSKPRC
ON LEAVE OF fi_dateprint IN FRAME fr_main
DO:
  fi_dateprint = INPUT fi_dateprint.
  DISP fi_dateprint WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datopen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datopen WUWSKPRC
ON LEAVE OF fi_datopen IN FRAME fr_main
DO:
  fi_datopen = INPUT fi_datopen.
  DISP fi_datopen WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_polist
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_polist WUWSKPRC
ON LEAVE OF fi_polist IN FRAME fr_main
DO:
  fi_polist = INPUT fi_polist.
  DISP fi_polist WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prod WUWSKPRC
ON LEAVE OF fi_prod IN FRAME fr_main
DO:
  fi_prod = INPUT fi_prod.
  DISP fi_prod WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stklos
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stklos WUWSKPRC
ON LEAVE OF fi_stklos IN FRAME fr_main
DO:
  fi_stklos = INPUT fi_stklos.

  IF fi_stklos = "" THEN DO:
     MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX ERROR.
     APPLY "ENTRY" TO fi_stklos.
  END.

  IF  LENGTH(fi_stklos) > 13 THEN DO:
        MESSAGE "LENGTH Sticker Mor than 13 Character" VIEW-AS ALERT-BOX WARNING .
        APPLY "ENTRY" TO fi_stklos .
  END.
  chr_sticker = "". 
  chr_sticker = TRIM(fi_stklos).

  RUN PD_chkmod.
  IF  fi_stklos <> chr_sticker THEN DO:
      MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stklos
              "ที่ถูกต้อง->" chr_sticker VIEW-AS ALERT-BOX WARNING .
      APPLY "ENTRY" TO fi_stklos.
  END.

  FIND FIRST sckyear USE-INDEX sckyear 
       WHERE sckyear.sckno = TRIM(fi_stklos) NO-LOCK NO-ERROR NO-WAIT.
  IF NOT AVAILABLE sckyear THEN DO:
     MESSAGE "ไม่มีการ Generate Sticker No.:" TRIM(fi_stklos) "เข้าระบบ" VIEW-AS ALERT-BOX WARNING .
     APPLY "ENTRY" TO fi_stklos .
  END.
  ELSE DO:
      IF sckyear.branch = "" THEN DO:
          MESSAGE  "ไม่มีการเบิก Sticker No:" TRIM(fi_stklos) " ไปใช้ ไม่สามารถแจ้งชำรุด/สูญหาย ได้" VIEW-AS ALERT-BOX WARNING .
          APPLY "ENTRY" TO fi_stklos .
      END.
      FIND FIRST notstk
           WHERE notstk.pol_mark = TRIM(fi_stklos) NO-LOCK NO-ERROR.
      IF AVAILABLE notstk THEN DO :
         ASSIGN
         fi_year       =   notstk.stk_year        
         fi_datelos    =   notstk.lost_dat        
         fi_datepols   =   notstk.notify_dat      
         nv_status     =   notstk.stk_sta         
         fi_polist     =   notstk.police_station  
         fi_dateprint  =   notstk.ent_dat      
         fi_user2      =   notstk.usrid  .  
   
              IF nv_status = "2"  THEN co_proc = "ชำรุด".
         ELSE IF nv_status = "3"  THEN co_proc = "สูญหาย" .
         ELSE IF nv_status = "4"  THEN co_proc = "ยกเลิกโดยผู้เอาประกันบอกเลิก".
         ELSE IF nv_status = "5"  THEN co_proc = "ยกเลิกโดยบริษัทบอกเลิก" .

         MESSAGE "พบข้อมูลการคีย์ชำรุด/สูญหายของ Sticker no."
                 TRIM(fi_stklos)  VIEW-AS ALERT-BOX WARNING .
         APPLY "ENTRY" TO fi_stklos .
      END.

      ASSIGN
         fi_brn      = sckyear.branch
         fi_prod     = sckyear.acno
         fi_userido  = sckyear.usrid
         fi_datopen  = sckyear.opndat
         fi_year     = STRING(INTE(sckyear.sckyr) + 543).

      fi_dateprint = DATE(MONTH(TODAY),DAY(TODAY),YEAR(TODAY) + 543).
      IF fi_user2  =  ""   THEN fi_user2  = fi_user.
         
  END.


  DISP fi_stklos    fi_year       fi_datelos  fi_brn     fi_prod
       fi_polist    fi_dateprint  fi_user     fi_userido fi_datopen 
       fi_dateprint fi_user2      co_proc     WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stknoF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stknoF WUWSKPRC
ON LEAVE OF fi_stknoF IN FRAME fr_main
DO:
  fi_stknoF = INPUT fi_stknoF.

  IF fi_stknoF = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX ERROR.
         APPLY "ENTRY" TO fi_stknoF.
     END.
     
     IF  LENGTH(fi_stknoF) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character" VIEW-AS ALERT-BOX WARNING .
         APPLY "ENTRY" TO fi_stknoF.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stknoF).

     RUN PD_chkmod.

     IF  fi_stknoF <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stknoF
                 "ที่ถูกต้อง->" chr_sticker VIEW-AS ALERT-BOX WARNING .
         APPLY "ENTRY" TO fi_stknoF.
     END.
     fi_stknoT = fi_stknoF.


  DISP fi_stknoF WITH FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stknoT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stknoT WUWSKPRC
ON LEAVE OF fi_stknoT IN FRAME fr_main
DO:
   fi_stknoT = INPUT fi_stknoT.

     IF fi_stknoT = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX ERROR.
         APPLY "ENTRY" TO fi_stknoT.
     END.
     
     IF  LENGTH(fi_stknoT) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character" VIEW-AS ALERT-BOX WARNING .
         APPLY "ENTRY" TO fi_stknoT.
     END.

     IF  fi_stknoT < fi_stknoF THEN DO:
          MESSAGE "Sticker No. To Must Be Greater Or Equal" VIEW-AS ALERT-BOX WARNING .
          APPLY "ENTRY" TO fi_stknoT.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stknoT).

     RUN PD_chkmod.

     IF  fi_stknoT <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stknoT
                 "ที่ถูกต้อง->" chr_sticker VIEW-AS ALERT-BOX WARNING .
         APPLY "ENTRY" TO fi_stknoT.
     END.
     nv_cnt01 = LENGTH(fi_stknoT) - 1.
     nv_cnt02 = LENGTH(fi_stknoF) - 1.
     nv_count = (DECIMAL(SUBSTRING(fi_stknoT,1,nv_cnt01)) - DECIMAL(SUBSTRING(fi_stknoF,1,nv_cnt02)) ) + 1. 
     fi_sumstk = nv_count.
     
     DISP fi_stknoT fi_sumstk WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_userido
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_userido WUWSKPRC
ON LEAVE OF fi_userido IN FRAME fr_main
DO:
  fi_datopen = INPUT fi_datopen.
  DISP fi_datopen WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_year
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_year WUWSKPRC
ON LEAVE OF fi_year IN FRAME fr_main
DO:
  fi_year = INPUT fi_year.
  DISP fi_year WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type WUWSKPRC
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
  rs_type = INPUT rs_type.

  IF  rs_type = 1 THEN DO:
      DISABLE co_proc fi_stklos  fi_datelos fi_polist   fi_brn 
              fi_prod fi_datopen fi_year    fi_datepols fi_dateprint 
              bnt_oklos WITH FRAME fr_main.
      ENABLE fi_stknoF fi_stknoT bnt_ok WITH FRAME fr_main.

  END.
  ELSE DO:

      ENABLE co_proc fi_stklos  fi_datelos fi_polist   fi_brn 
              fi_prod fi_datopen fi_year    fi_datepols fi_dateprint 
              bnt_oklos WITH FRAME fr_main.
      DISABLE fi_stknoF fi_stknoT bnt_ok WITH FRAME fr_main.


  END.


  DISP rs_type WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWSKPRC 


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
     rs_type = 1
     co_proc = "ชำรุด"
     fi_user = USERID(LDBNAME(1)).

  DISABLE co_proc fi_stklos  fi_datelos fi_polist   fi_brn 
          fi_prod fi_datopen fi_year    fi_datepols fi_dateprint 
          bnt_oklos WITH FRAME fr_main.

  DISP fi_user rs_type co_proc WITH FRAME fr_main. 
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWSKPRC  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKPRC)
  THEN DELETE WIDGET WUWSKPRC.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWSKPRC  _DEFAULT-ENABLE
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
  DISPLAY rs_type fi_stknoF fi_stknoT fi_stklos co_proc fi_datelos fi_polist 
          fi_datepols fi_user fi_sumstk fi_tot fi_year fi_dateprint fi_user2 
          fi_brn fi_prod fi_datopen fi_userido 
      WITH FRAME fr_main IN WINDOW WUWSKPRC.
  ENABLE RECT-685 RECT-688 RECT-689 RECT-692 RECT-686 RECT-695 RECT-696 
         RECT-697 rs_type fi_stknoF fi_stknoT bnt_ok fi_stklos co_proc 
         fi_datelos fi_polist fi_datepols bnt_oklos btn_exit fi_user fi_sumstk 
         fi_tot fi_year fi_dateprint fi_user2 fi_brn fi_prod fi_datopen 
         fi_userido 
      WITH FRAME fr_main IN WINDOW WUWSKPRC.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WUWSKPRC.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_chkmod WUWSKPRC 
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

