&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          tid              PROGRESS
*/
&Scoped-define WINDOW-NAME WUWSKGEN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WUWSKGEN 
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
DEFINE VAR chr_sticker  AS CHAR     FORMAT "X(15)".
DEFINE VAR nvw_sticker AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
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
DEFINE VAR  nv_year     AS CHAR     FORMAT "X(04)" INIT "".


DEF STREAM ns1.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_STKNO

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES sckyear

/* Definitions for BROWSE br_STKNO                                      */
&Scoped-define FIELDS-IN-QUERY-br_STKNO sckyear.sckno sckyear.stat ~
sckyear.flag sckyear.entdat sckyear.sckyr sckyear.usrid 
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_STKNO 
&Scoped-define QUERY-STRING-br_STKNO FOR EACH sckyear NO-LOCK INDEXED-REPOSITION
&Scoped-define OPEN-QUERY-br_STKNO OPEN QUERY br_STKNO FOR EACH sckyear NO-LOCK INDEXED-REPOSITION.
&Scoped-define TABLES-IN-QUERY-br_STKNO sckyear
&Scoped-define FIRST-TABLE-IN-QUERY-br_STKNO sckyear


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_STKNO}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-682 RECT-683 RECT-684 RECT-685 RECT-8 ~
fi_stknoF fi_stknoT Brn_Ok Cb_type Brn_Ext-2 fi_docF br_STKNO fi_sumstk ~
fi_type fi_docT fi_pro fi_Dstk fi_prostk fi_Ddoc fi_prodoc fi_user 
&Scoped-Define DISPLAYED-OBJECTS fi_stknoF fi_stknoT Cb_type fi_docF ~
fi_sumstk fi_type fi_docT fi_pro fi_Dstk fi_prostk fi_Ddoc fi_prodoc ~
fi_user 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WUWSKGEN AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON Brn_Ext-2 
     LABEL "Exit" 
     SIZE 11.67 BY 1.29
     FONT 6.

DEFINE BUTTON Brn_Ok 
     LABEL "OK" 
     SIZE 11.67 BY 1.29
     FONT 6.

DEFINE VARIABLE Cb_type AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "1P","1S","2P","2S","4P","4S" 
     DROP-DOWN-LIST
     SIZE 7.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_Ddoc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 13 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE VARIABLE fi_docF AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_docT AS INTEGER FORMAT ">>>>>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 13 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_Dstk AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 16.83 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE VARIABLE fi_pro AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 11 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE VARIABLE fi_prodoc AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 10.33 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE VARIABLE fi_prostk AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 16 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 3 NO-UNDO.

DEFINE VARIABLE fi_stknoF AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_stknoT AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_sumstk AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 8 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_type AS CHARACTER FORMAT "X(100)":U 
      VIEW-AS TEXT 
     SIZE 25 BY 1
     BGCOLOR 8 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 1 FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-682
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 31.17 BY 7.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-683
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 67.83 BY 7.71
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-684
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 99 BY 1.67
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-685
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 99 BY 1.33
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-8
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13.67 BY 3.48
     BGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_STKNO FOR 
      sckyear SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_STKNO
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_STKNO WUWSKGEN _STRUCTURED
  QUERY br_STKNO NO-LOCK DISPLAY
      sckyear.sckno COLUMN-LABEL "Sticker NO." FORMAT "x(15)":U
      sckyear.stat COLUMN-LABEL "Receipt No." FORMAT "x(8)":U
      sckyear.flag COLUMN-LABEL "Type Document" FORMAT "x(2)":U
      sckyear.entdat COLUMN-LABEL "Entry Date" FORMAT "99/99/9999":U
      sckyear.sckyr COLUMN-LABEL "Year STK" FORMAT "x(4)":U
      sckyear.usrid FORMAT "x(8)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 99 BY 12.1
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_stknoF AT ROW 3.33 COL 32.67 COLON-ALIGNED NO-LABEL 
     fi_stknoT AT ROW 4.86 COL 32.67 COLON-ALIGNED NO-LABEL 
     Brn_Ok AT ROW 7.1 COL 87.17 
     Cb_type AT ROW 7.33 COL 32.83 COLON-ALIGNED NO-LABEL 
     Brn_Ext-2 AT ROW 8.62 COL 87.17 
     fi_docF AT ROW 8.91 COL 32.83 COLON-ALIGNED NO-LABEL 
     br_STKNO AT ROW 11.71 COL 1.5 
     fi_sumstk AT ROW 6.1 COL 33.17 COLON-ALIGNED NO-LABEL
     fi_type AT ROW 7.33 COL 43.17 COLON-ALIGNED NO-LABEL 
     fi_docT AT ROW 8.91 COL 55.33 COLON-ALIGNED NO-LABEL 
     fi_pro AT ROW 10.52 COL 4.5 NO-LABEL 
     fi_Dstk AT ROW 10.52 COL 14.17 COLON-ALIGNED NO-LABEL
     fi_prostk AT ROW 10.52 COL 33.5 NO-LABEL 
     fi_Ddoc AT ROW 10.52 COL 55.17 COLON-ALIGNED NO-LABEL 
     fi_prodoc AT ROW 10.52 COL 71.83 NO-LABEL
     fi_user AT ROW 10.57 COL 82.83 COLON-ALIGNED NO-LABEL 
     " Generate Sticker No.  And  Receipt No. To File Sckyear" VIEW-AS TEXT
          SIZE 63.67 BY 1 AT ROW 1.33 COL 16.67 
          BGCOLOR 3 FGCOLOR 7 FONT 23
     "Type document of Sticker :" VIEW-AS TEXT
          SIZE 27 BY 1 AT ROW 7.33 COL 3.17 
          BGCOLOR 8 FONT 6
     "Sum of Sticker :" VIEW-AS TEXT
          SIZE 27 BY 1 AT ROW 6.1 COL 3.5 
          BGCOLOR 8 FONT 6
     "Sticker No. To.:" VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 4.86 COL 3.5 
          BGCOLOR 8 FONT 6
     "To.:" VIEW-AS TEXT
          SIZE 5.5 BY 1 AT ROW 8.91 COL 51
          BGCOLOR 8 FONT 6
     "Sticker No. From.:" VIEW-AS TEXT
          SIZE 27 BY 1 AT ROW 3.33 COL 3.33 
          BGCOLOR 8 FONT 6
     "Receipt No. From.:" VIEW-AS TEXT
          SIZE 27 BY 1 AT ROW 8.91 COL 4 
          BGCOLOR 8 FONT 6
     RECT-682 AT ROW 2.67 COL 1.5 
     RECT-683 AT ROW 2.67 COL 32.67 
     RECT-684 AT ROW 1 COL 1.5 
     RECT-685 AT ROW 10.38 COL 1.5
     RECT-8 AT ROW 6.71 COL 86.17 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.33 ROW 1
         SIZE 100.17 BY 23
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
  CREATE WINDOW WUWSKGEN ASSIGN
         HIDDEN             = YES
         TITLE              = " Generate Sticker No. & Receipt No. to File Sckyear"
         HEIGHT             = 22.95
         WIDTH              = 100.67
         MAX-HEIGHT         = 23.52
         MAX-WIDTH          = 133
         VIRTUAL-HEIGHT     = 23.52
         VIRTUAL-WIDTH      = 133
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
/* SETTINGS FOR WINDOW WUWSKGEN
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME                                                           */
/* BROWSE-TAB br_STKNO fi_docF fr_main */
/* SETTINGS FOR FILL-IN fi_pro IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_prodoc IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_prostk IN FRAME fr_main
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKGEN)
THEN WUWSKGEN:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_STKNO
/* Query rebuild information for BROWSE br_STKNO
     _TblList          = "tid.sckyear"
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _FldNameList[1]   > tid.sckyear.sckno
"sckyear.sckno" "Sticker NO." "x(15)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[2]   > tid.sckyear.stat
"sckyear.stat" "Receipt No." ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[3]   > tid.sckyear.flag
"sckyear.flag" "Type Document" "x(2)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[4]   > tid.sckyear.entdat
"sckyear.entdat" "Entry Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[5]   > tid.sckyear.sckyr
"sckyear.sckyr" "Year STK" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" "" "" "" "" "" 0 no 0 no no
     _FldNameList[6]   = tid.sckyear.usrid
     _Query            is OPENED
*/  /* BROWSE br_STKNO */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WUWSKGEN
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKGEN WUWSKGEN
ON END-ERROR OF WUWSKGEN /*  Generate Sticker No.  Receipt No. to File Sckyear */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WUWSKGEN WUWSKGEN
ON WINDOW-CLOSE OF WUWSKGEN /*  Generate Sticker No.  Receipt No. to File Sckyear */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Brn_Ext-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Brn_Ext-2 WUWSKGEN
ON CHOOSE OF Brn_Ext-2 IN FRAME fr_main /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Brn_Ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Brn_Ok WUWSKGEN
ON CHOOSE OF Brn_Ok IN FRAME fr_main /* OK */
DO:

   nv_year = STRING(YEAR(TODAY),"9999").
   IF (fi_stknoF >= "170000001"  AND fi_stknoF <= "199999999") OR
      (fi_stknoF >= "270000001"  AND fi_stknoF <= "299999999") OR 
      (fi_stknoF  = "000000000") AND 
      (fi_stknoT >= "170000001"  AND fi_stknoT <= "199999999") OR
      (fi_stknoT >= "270000001"  AND fi_stknoT<= "299999999") OR 
      (fi_stknoT  = "000000000") THEN 
         ASSIGN nv_sticker1 = INT (fi_stknoF)
                nv_sticker2 = INT (fi_stknoT)   
                nv_sckno = nv_sticker1.
  
     ELSE DO:
       
        nv_sticker1 = LENGTH(fi_stknoF) - 1.
        nv_sticker2 = LENGTH(fi_stknoT) - 1.

        nv_sckno = nv_sticker1.
     END.

     ASSIGN 
       nv_crep      = fi_docF 
       /*nv_line      = 0*/
       nv_first     = YES
       CHR_sticker  = fi_stknoF
       nv_count02   = fi_sumstk
       fi_pro       = "Process : "
       fi_Ddoc      = "Receipt No. :"
       fi_Dstk      = "Sticker No.  :" 
       fi_user      = USERID(LDBNAME(1)).

     DISPLAY  fi_pro fi_Ddoc fi_Dstk fi_user WITH FRAME fr_main.
     
     loop_sub:
     REPEAT WHILE nv_count02 <= fi_sumstk AND nv_count02 <> 0 : 
        nvw_sticker = nv_sckno.
        
        IF (STRING(nvw_sticker) >= "170000001"  AND STRING(nvw_sticker) <= "199999999") 
        OR (STRING(nvw_sticker) >= "270000001"  AND string(nvw_sticker) <= "299999999") 
        THEN nvsck = STRING(nvw_sticker). 

        IF nv_first = NO AND nv_count02 > 0 THEN DO: /*  RUNNING STICKER NO. */
           
           ASSIGN
             nv_sck_no  = chr_sticker
             nv_count01 = LENGTH(nv_sck_no) - 1
             nv_sck_no  = SUBSTRING(nv_sck_no,1,nv_count01).

           IF SUBSTRING(CHR_sticker,1,1) = "0" THEN chr_sticker = "0" + STRING(DECI(nv_sck_no) + 1).
           ELSE chr_sticker = STRING(DECI(nv_sck_no) + 1).

           RUN PD_cremod.
           
           ASSIGN nv_sck_no = CHR_sticker.

           RUN PD_chkmod.

           IF nv_sck_no <> chr_sticker THEN DO:
                
                MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." nv_sck_no
                        "ที่ถูกต้อง->" chr_sticker VIEW-AS ALERT-BOX.
                LEAVE loop_sub.
           END.
        END. /*IF nv_first = NO AND nv_count02 > 0 */

        nvsck = chr_sticker.
        nvrep = STRING(nv_crep,"9999999").

        FIND FIRST sckyear USE-INDEX sckyear 
             WHERE sckyear.sckno = nvsck NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAILABLE sckyear THEN DO:
          
          ASSIGN 
             fi_prostk = nvsck
             fi_prodoc = IF nv_crep = 0 THEN "" ELSE nvrep.

          CREATE sckyear.
          ASSIGN
                 sckyear.sckyr  = nv_year
                 sckyear.sckno  = nvsck
                 sckyear.entdat = TODAY
                 Sckyear.flag   = Cb_type 
                 sckyear.stat   = IF nv_crep = 0 THEN "" ELSE nvrep
                 sckyear.usrid  = USERID(LDBNAME(1)).
          nv_first = NO.
          nv_count02 = nv_count02 - 1. 
        END.  
        ELSE DO:
            IF sckyear.stat <> "" AND
               sckyear.stat <> STRING(nv_crep,"9999999") THEN DO:              
                
                MESSAGE  "มีการ Create Sticker No." nvsck 
                         " แต่มี Receipt No.:" sckyear.stat "ในระบบแล้ว !!!" SKIP
                         "ซึ่งไม่ตรงกับ Running Receipt No.:" nvrep VIEW-AS ALERT-BOX.
                LEAVE loop_sub.
            END.
            ELSE DO:
                HIDE MESSAGE NO-PAUSE.
                MESSAGE "มีการ Create Sticker No." nvsck 
                        " Receipt No.:" nvrep "ในระบบแล้ว !!!" VIEW-AS ALERT-BOX.
                LEAVE loop_sub.
            END.
        END.
        nv_sckno = nv_sckno + 1.
        
        nv_crep  = IF nv_crep = 0 THEN nv_crep ELSE nv_crep  + 1. /*-- A50-0185 --*/
      
        DISPLAY   fi_prostk fi_prodoc WITH FRAME fr_main.
     END. /*REPEAT WHILE fi_sumstk */

     MESSAGE "CREATE Sticker no. Complete" VIEW-AS ALERT-BOX.

     OPEN QUERY br_STKNO
     FOR EACH sckyear 
         WHERE sckyear.sckno >= fi_stknoF  
         AND   sckyear.sckno <= fi_stknoT NO-LOCK BY sckyear.sckno.




    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Cb_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Cb_type WUWSKGEN
ON VALUE-CHANGED OF Cb_type IN FRAME fr_main
DO:

  Cb_type = INPUT Cb_type.
  IF      Cb_type =  "1P" THEN fi_type = "1 Part(web) : 201-028" . /*201-015-5*/
  ELSE IF Cb_type =  "1S" THEN fi_type = "1 Part(Web) : 201-024-1". /*พี่บีศรีกรุง*/
  ELSE IF Cb_type =  "2P" THEN fi_type = "2 Part : 201-029" .    /*201-016-3*/
  ELSE IF Cb_type =  "4S" THEN fi_type = "4 Part (web) : 201-027" .  /*201-015-4"*/
  ELSE IF Cb_type =  "4P" THEN fi_type = "4 Part : 201-026" .  /*201-015-3*/

  DISP Cb_type fi_type WITH FRAM fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_docF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_docF WUWSKGEN
ON LEAVE OF fi_docF IN FRAME fr_main
DO:
  fi_docF = INPUT fi_docF.
  IF fi_docF = 0 THEN DO:
      MESSAGE "Please input Document NO." VIEW-AS ALERT-BOX.
      APPLY "ENTRY" TO fi_docF.
      RETURN NO-APPLY.

  END.
  fi_docT = fi_docF + (nv_count - 1).
  /*fi_docT = fi_docF + (nv_count - 1). */



  DISP fi_docF fi_docT WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stknoF
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stknoF WUWSKGEN
ON LEAVE OF fi_stknoF IN FRAME fr_main
DO:       
     fi_stknoF = INPUT fi_stknoF.

     IF fi_stknoF = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_stknoF.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_stknoF) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character".
         APPLY "ENTRY" TO fi_stknoF.
         RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stknoF).

     RUN PD_chkmod.

     IF  fi_stknoF <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stknoF
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_stknoF.
         RETURN NO-APPLY.
     END.
     fi_stknoT = fi_stknoF.
     DISP fi_stknoF fi_stknoT WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stknoT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stknoT WUWSKGEN
ON LEAVE OF fi_stknoT IN FRAME fr_main
DO:
     fi_stknoT = INPUT fi_stknoT.

     IF fi_stknoT = "" THEN DO:
         MESSAGE "Sticker No. Not Blank !" VIEW-AS ALERT-BOX.
         APPLY "ENTRY" TO fi_stknoT.
         RETURN NO-APPLY.
    
     END.
     
     IF  LENGTH(fi_stknoT) > 13 THEN DO:
         MESSAGE "LENGTH Sticker Mor than 13 Character".
         APPLY "ENTRY" TO fi_stknoT.
         RETURN NO-APPLY.
     END.

     IF  fi_stknoT < fi_stknoF THEN DO:
          MESSAGE "Sticker No. To Must Be Greater Or Equal".
          APPLY "ENTRY" TO fi_stknoT.
          RETURN NO-APPLY.
     END.

     chr_sticker = "". 
     chr_sticker = TRIM(fi_stknoT).

     RUN PD_chkmod.

     IF  fi_stknoT <> chr_sticker THEN DO:
         MESSAGE "ข้อมูลเบอร์ Sticker no.ไม่ถูกต้อง." fi_stknoT
                 "ที่ถูกต้อง->" chr_sticker.
         APPLY "ENTRY" TO fi_stknoT.
         RETURN NO-APPLY.
     END.
     nv_cnt01 = LENGTH(fi_stknoT) - 1.
     nv_cnt02 = LENGTH(fi_stknoF) - 1.
     nv_count = (DECIMAL(SUBSTRING(fi_stknoT,1,nv_cnt01)) - DECIMAL(SUBSTRING(fi_stknoF,1,nv_cnt02)) ) + 1. 
     fi_sumstk = nv_count.
     
     DISP fi_stknoT fi_sumstk WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_STKNO
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WUWSKGEN 


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
  /*RUN  WUT\WUTWICEN (WTILOGMN:HANDLE).  */
  SESSION:DATA-ENTRY-RETURN = YES.
  ASSIGN
     Cb_type = "1P"
     fi_type = "1 Part(web) : 201-015-5". 

  OPEN QUERY br_STKNO
     FOR EACH sckyear 
         WHERE sckyear.sckno >= fi_stknoF  
         AND   sckyear.sckno <= fi_stknoT NO-LOCK BY sckyear.sckno. 

  DISP Cb_type fi_type WITH FRAME fr_main.


  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WUWSKGEN  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WUWSKGEN)
  THEN DELETE WIDGET WUWSKGEN.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WUWSKGEN  _DEFAULT-ENABLE
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
  DISPLAY fi_stknoF fi_stknoT Cb_type fi_docF fi_sumstk fi_type fi_docT fi_pro 
          fi_Dstk fi_prostk fi_Ddoc fi_prodoc fi_user 
      WITH FRAME fr_main IN WINDOW WUWSKGEN.
  ENABLE RECT-682 RECT-683 RECT-684 RECT-685 RECT-8 fi_stknoF fi_stknoT Brn_Ok 
         Cb_type Brn_Ext-2 fi_docF br_STKNO fi_sumstk fi_type fi_docT fi_pro 
         fi_Dstk fi_prostk fi_Ddoc fi_prodoc fi_user 
      WITH FRAME fr_main IN WINDOW WUWSKGEN.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW WUWSKGEN.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_chkmod WUWSKGEN 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_cremod WUWSKGEN 
PROCEDURE PD_cremod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

nv_cnt1 = LENGTH(chr_sticker).
nv_cnt2 = nv_cnt1.

IF SUBSTRING(CHR_sticker,1,1) = "0" THEN DO:
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
    Chk_mod2 = DEC(SUBSTRING(STRING( Chk_mod1 / 7 ),1,nv_cnt2)) * 7.
    nv_modulo = Chk_mod1 - Chk_mod2.    
    chr_sticker = SUBSTRING(STRING(Chk_mod1),1,nv_cnt2) + STRING(nv_modulo).
END.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

