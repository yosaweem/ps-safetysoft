&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME WACTRVAT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS WACTRVAT 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: Amparat c. A56-0038 Transfer Vat จากสาขาเข้าสนญ  
           เงื่อนไข 
              - เลือกได้ทีละหลายสาขา
              - ใส่ User & Password ครั้งเดียว  สามารถ Connect ได้ทุกสาขาที่เลือก
              - Trasfer by entdate & inv.date              
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
DEFINE VAR nv_pwd    AS CHAR NO-UNDO.
DEFINE VAR nv_usrid  AS CHAR NO-UNDO.


DEF WORKFILE wbrbran NO-UNDO
    FIELD wBranch    AS CHAR
    FIELD wbr_desc   AS CHAR
    FIELD wPhy_name  AS CHAR
    FIELD wlog_name  AS CHAR
    FIELD wConnect   AS CHAR .

DEFINE BUFFER bf_wbrbran FOR wbrbran.

DEF WorkFile wVatHo NO-UNDO
    FIELD Ho_Bran     AS CHAR 
    FIELD Ho_brDesc   AS CHAR 
    FIELD Ho_Connect  AS CHAR
    FIELD Ho_status   AS CHAR.
/* Local Variable Definitions ---                                       */
DEF VAR nv_bran AS CHAR.
DEF VAR nv_desc AS CHAR.



DEFINE VAR nv_brfr AS CHAR.
DEFINE VAR nv_brto AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frMain
&Scoped-define BROWSE-NAME br_dbbran

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wbrbran wVatHo

/* Definitions for BROWSE br_dbbran                                     */
&Scoped-define FIELDS-IN-QUERY-br_dbbran wBranch wbr_desc wPhy_name wlog_name wConnect   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_dbbran   
&Scoped-define SELF-NAME br_dbbran
&Scoped-define QUERY-STRING-br_dbbran FOR EACH wbrbran
&Scoped-define OPEN-QUERY-br_dbbran OPEN QUERY br_dbbran FOR EACH wbrbran.
&Scoped-define TABLES-IN-QUERY-br_dbbran wbrbran
&Scoped-define FIRST-TABLE-IN-QUERY-br_dbbran wbrbran


/* Definitions for BROWSE br_HO                                         */
&Scoped-define FIELDS-IN-QUERY-br_HO Ho_Bran Ho_brDesc Ho_Connect Ho_status   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_HO   
&Scoped-define SELF-NAME br_HO
&Scoped-define QUERY-STRING-br_HO FOR EACH wVatHo
&Scoped-define OPEN-QUERY-br_HO OPEN QUERY br_Broker FOR EACH wVatHo.
&Scoped-define TABLES-IN-QUERY-br_HO wVatHo
&Scoped-define FIRST-TABLE-IN-QUERY-br_HO wVatHo


/* Definitions for FRAME frMain                                         */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS cb_region ra_select ra_seldate fi_brfr ~
fi_brto bu_Process bu_Exit fi_datefr fi_dateto br_dbbran br_HO fi_brfrdecs ~
fi_brtodecs fi_Process fi_Process2 RECT-650 RECT-651 RECT-652 
&Scoped-Define DISPLAYED-OBJECTS cb_region ra_select ra_seldate fi_brfr ~
fi_brto fi_datefr fi_dateto fi_brfrdecs fi_brtodecs fi_Process fi_Process2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR WACTRVAT AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_Exit 
     LABEL "Exit" 
     SIZE 14.5 BY 1.29
     FONT 6.

DEFINE BUTTON bu_Process 
     LABEL "Transfer" 
     SIZE 14.5 BY 1.29
     FONT 6.

DEFINE VARIABLE cb_region AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Head Office","Northern","Central","Northeastern","Southern" 
     DROP-DOWN-LIST
     SIZE 31 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brfrdecs AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 35.67 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brtodecs AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 37.33 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_datefr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_dateto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Process AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 64.33 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_Process2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 64.33 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_seldate AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Entry Date", 1,
"Inv.  Date", 2
     SIZE 14.5 BY 2.62
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_select AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Region", 1,
"Branch   From", 2
     SIZE 16.5 BY 2.62
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-650
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 112 BY 4
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-651
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 2
     BGCOLOR 1 FGCOLOR 1 .

DEFINE RECTANGLE RECT-652
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 19.5 BY 2
     BGCOLOR 4 FGCOLOR 1 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_dbbran FOR 
      wbrbran SCROLLING.

DEFINE QUERY br_HO FOR 
      wVatHo SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_dbbran
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_dbbran WACTRVAT _FREEFORM
  QUERY br_dbbran DISPLAY
      wBranch     COLUMN-LABEL  "สาขา"        FORMAT "X(8)"
 wbr_desc    COLUMN-LABEL  "ชื่อสาขา"    FORMAT "X(35)"
 wPhy_name   COLUMN-LABEL  "db name"     FORMAT "X(8)"
 wlog_name   COLUMN-LABEL  "ld name"     FORMAT "X(8)"
 wConnect    COLUMN-LABEL  "db Connect"  FORMAT "X(35)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 64 BY 18.67 ROW-HEIGHT-CHARS .52 FIT-LAST-COLUMN.

DEFINE BROWSE br_HO
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_HO WACTRVAT _FREEFORM
  QUERY br_HO DISPLAY
      Ho_Bran    COLUMN-LABEL  "สาขา"    FORMAT "x(4)"
 Ho_brDesc  COLUMN-LABEL  "ชื่อสาขา"  FORMAT "X(30)"
 Ho_Connect COLUMN-LABEL  "Connect"   FORMAT "X(25)"
 Ho_status  COLUMN-LABEL  "Status"    FORMAT "X(10)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 64.5 BY 18.71 ROW-HEIGHT-CHARS .6 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     cb_region AT ROW 1.24 COL 19.33 COLON-ALIGNED NO-LABEL WIDGET-ID 4
     ra_select AT ROW 1.24 COL 3 NO-LABEL
     ra_seldate AT ROW 2.19 COL 68.67 NO-LABEL
     fi_brfr AT ROW 2.67 COL 19 COLON-ALIGNED NO-LABEL
     fi_brto AT ROW 3.76 COL 19 COLON-ALIGNED NO-LABEL
     bu_Process AT ROW 1.38 COL 115.5
     bu_Exit AT ROW 3.43 COL 115.5
     fi_datefr AT ROW 2.43 COL 89.17 COLON-ALIGNED NO-LABEL
     fi_dateto AT ROW 3.71 COL 89.17 COLON-ALIGNED NO-LABEL
     br_dbbran AT ROW 6.14 COL 1.5
     br_HO AT ROW 6.1 COL 67.33
     fi_brfrdecs AT ROW 2.67 COL 25.83 COLON-ALIGNED NO-LABEL
     fi_brtodecs AT ROW 3.76 COL 25.67 COLON-ALIGNED NO-LABEL
     fi_Process AT ROW 5.05 COL 1.17 NO-LABEL
     fi_Process2 AT ROW 5.05 COL 67.33 NO-LABEL
     "From" VIEW-AS TEXT
          SIZE 5.5 BY .62 AT ROW 2.67 COL 85.17
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Transfer Data Vat By" VIEW-AS TEXT
          SIZE 21 BY .62 AT ROW 1.24 COL 69.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.5 BY .62 AT ROW 3.86 COL 86.67
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "To" VIEW-AS TEXT
          SIZE 3.5 BY .62 AT ROW 4 COL 15.5
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-650 AT ROW 1 COL 1
     RECT-651 AT ROW 1.05 COL 113
     RECT-652 AT ROW 3.1 COL 113
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 131.5 BY 23.86.


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
  CREATE WINDOW WACTRVAT ASSIGN
         HIDDEN             = YES
         TITLE              = "Transfer  Vat100  Form BR To Ho"
         HEIGHT             = 23.86
         WIDTH              = 131.5
         MAX-HEIGHT         = 30.19
         MAX-WIDTH          = 149.33
         VIRTUAL-HEIGHT     = 30.19
         VIRTUAL-WIDTH      = 149.33
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
IF NOT WACTRVAT:LOAD-ICON("Wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: Wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW WACTRVAT
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frMain
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_dbbran fi_dateto frMain */
/* BROWSE-TAB br_HO br_dbbran frMain */
/* SETTINGS FOR FILL-IN fi_Process IN FRAME frMain
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_Process2 IN FRAME frMain
   ALIGN-L                                                              */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACTRVAT)
THEN WACTRVAT:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_dbbran
/* Query rebuild information for BROWSE br_dbbran
     _START_FREEFORM
OPEN QUERY br_dbbran FOR EACH wbrbran.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_dbbran */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_HO
/* Query rebuild information for BROWSE br_HO
     _START_FREEFORM
OPEN QUERY br_Broker FOR EACH wVatHo.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_HO */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME WACTRVAT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACTRVAT WACTRVAT
ON END-ERROR OF WACTRVAT /* Transfer  Vat100  Form BR To Ho */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL WACTRVAT WACTRVAT
ON WINDOW-CLOSE OF WACTRVAT /* Transfer  Vat100  Form BR To Ho */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_dbbran
&Scoped-define SELF-NAME br_dbbran
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_dbbran WACTRVAT
ON DELETE-CHARACTER OF br_dbbran IN FRAME frMain
DO:

  FIND FIRST wbrbran  WHERE wbrbran.wBranch = nv_bran NO-ERROR.
  IF AVAIL wbrbran THEN DO:
     DELETE wbrbran.

     OPEN QUERY br_dbbran 
     FOR EACH wbrbran NO-LOCK BY  wbrbran.wBranch.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_dbbran WACTRVAT
ON LEFT-MOUSE-CLICK OF br_dbbran IN FRAME frMain
DO:
/*   ASSIGN                           */
/*       nv_policy = wbrbran.wPolicy. */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_dbbran WACTRVAT
ON VALUE-CHANGED OF br_dbbran IN FRAME frMain
DO:
  nv_bran =   wbrbran.wBranch.
  
  

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_HO
&Scoped-define SELF-NAME br_HO
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_HO WACTRVAT
ON ROW-DISPLAY OF br_HO IN FRAME frMain
DO:
   IF wVatHo.Ho_status = "NOT COMPLATE"  THEN DO:
      wVatHo.Ho_Bran   :FGCOLOR IN BROWSE br_ho = 12 no-error.
      wVatHo.Ho_brDesc :FGCOLOR IN BROWSE br_ho = 12 no-error.
      wVatHo.Ho_Connect :FGCOLOR IN BROWSE br_ho = 12 no-error.
      wVatHo.Ho_status :FGCOLOR IN BROWSE br_ho = 12 no-error.
     
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Exit WACTRVAT
ON CHOOSE OF bu_Exit IN FRAME frMain /* Exit */
DO:
   APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_Process
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_Process WACTRVAT
ON CHOOSE OF bu_Process IN FRAME frMain /* Transfer */
DO:
  DEF VAR nv_i AS INT.
  DEF VAR nv_connects  AS CHAR.
  DEF VAR nv_Status    AS  CHAR.
  DEF VAR  br_Connect AS CHAR.
   ASSIGN  nv_usrid = ""
           nv_pwd  = "" 
           nv_connects = ""
           nv_Status = ""
           nv_i  = 0.
   FOR EACH wVatHo. DELETE  wVatHo. END.

   RUN WTM\WtmContr (OUTPUT nv_usrid,OUTPUT nv_pwd). 

   IF nv_usrid <> "" AND nv_pwd <> "" THEN DO:
       FOR EACH bf_wbrbran.
           nv_bran = bf_wbrbran.wbranch.
           nv_desc = bf_wbrbran.wbr_desc.
           nv_connects = "".
           br_Connect  = "".
           nv_Status = "".
           IF CONNECTED ("brstat") THEN DISCONNECT brstat.
           IF NOT CONNECTED ("brstat") THEN DO:
              nv_connects = " -db " + TRIM(wbrbran.wPhy_name) + " " + TRIM(wbrbran.wConnect) + " -ld " + TRIM(wbrbran.wlog_name).
              CONNECT VALUE(nv_connects) -U VALUE(nv_usrid) -P VALUE(nv_pwd) NO-ERROR. 
              
             /*CONNECT stat -ld brstat   -H 16.90.55.1 -S 4600 -N TCP -U pdmgr0 -P pdmgr0 NO-ERROR.*/

              IF NOT CONNECTED ("brstat") THEN DO:
                 nv_Status = "NOT COMPLATE".                 
                 br_Connect = "DB Not Connect".
                 ASSIGN fi_Process = "Can't connected to database brstat !  " + nv_bran .
                 fi_process2 = "".
                 DISP fi_Process fi_process2 WITH FRAME frMain.
              END.
              ELSE DO:
                 nv_Status = "COMPLATE".
                 br_Connect = "DB Connect ".
                 ASSIGN fi_process = "connected to database brstat !  "  + nv_bran
                        fi_process2 = "please wait..!!  Gen. Data Vat100 "  + nv_bran + " TO Ho. ".
                 DISP fi_Process fi_process2 WITH FRAME frMain.

                 IF ra_seldate = 1  THEN  RUN WCV\WCVAT116.P(nv_bran,fi_datefr,fi_dateto).
                 ELSE  RUN WCV\WCVAT117(nv_bran,fi_datefr,fi_dateto). 

                 DISCONNECT brstat.
                 nv_connects = "".              
              END.

              FIND FIRST wVatHo WHERE wVatHo.Ho_Bran = nv_bran NO-LOCK NO-ERROR.
              IF NOT AVAIL wVatHo THEN DO:
                CREATE wVatHo.
                ASSIGN
                Ho_Bran   = nv_bran
                Ho_brDesc = nv_desc
                Ho_status = nv_Status
                Ho_Connect  = br_Connect.
              END.

              FIND FIRST wbrbran WHERE wbrbran.wbranch = nv_bran NO-ERROR.
              IF AVAIL wbrbran THEN DO:
                 DELETE wbrbran.
              END.
              OPEN QUERY br_dbbran 
                   FOR EACH wbrbran NO-LOCK BY  wbrbran.wBranch.
              OPEN QUERY br_HO 
                   FOR EACH  wVatHo NO-LOCK BY   wVatHo.Ho_Bran.
           END.
       END.
   END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cb_region
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cb_region WACTRVAT
ON VALUE-CHANGED OF cb_region IN FRAME frMain
DO:
   cb_region = INPUT cb_region .
   DISP cb_region  WITH FRAME frMain.
   FOR EACH wvatho.
    DELETE wvatho.
   END.
   
   FOR EACH wbrbran.
       DELETE wbrbran.
   END.
   IF cb_region = "Head Office" THEN DO:
      
      loop_cvm006:
      FOR EACH  cvm006 
          WHERE SUBSTRING(cvm006.branch,1,1) = "1" NO-LOCK.
          
          IF cvm006.iisbrn = "0"  OR cvm006.iisbrn = "M" OR
             cvm006.iisbrn = "L"  OR cvm006.iisbrn = "W" OR 
             cvm006.iisbrn = "WS" OR SUBSTRING(cvm006.iisbrn,1,1) = "9"  OR 
             cvm006.iisbrn = "19" THEN NEXT loop_cvm006.

          FOR EACH db_bran 
              WHERE db_bran.branch = cvm006.iisbrn + "S" NO-LOCK.
              
              IF SUBSTRING(db_bran.branch,2,1) = "S" OR            
                 SUBSTRING(db_bran.branch,3,1) = "S" THEN DO:

                 CREATE wbrbran.
                 ASSIGN
                    wBranch    =  db_bran.branch   
                    wbr_desc   =  db_bran.br_desc  
                    wPhy_name  =  db_bran.phy_name
                    wlog_name  =  db_bran.log_name  
                    wConnect   =  db_bran.oth_para.        

              END.
          END.
      END.
   END.
   ELSE IF cb_region = "Northern" THEN DO:
        
        FOR EACH cvm006 
            WHERE SUBSTRING(cvm006.branch,1,1) = "2" NO-LOCK.
            
            FOR EACH db_bran 
                WHERE db_bran.branch = cvm006.iisbrn + "S" NO-LOCK.
                
                IF SUBSTRING(db_bran.branch,2,1) = "S" OR            
                   SUBSTRING(db_bran.branch,3,1) = "S" THEN DO:
            
                   CREATE wbrbran.
                   ASSIGN
                      wBranch    =  db_bran.branch   
                      wbr_desc   =  db_bran.br_desc  
                      wPhy_name  =  db_bran.phy_name
                      wlog_name  =  db_bran.log_name  
                      wConnect   =  db_bran.oth_para.        
            
                END.
            END.
        END.
   END.
   ELSE IF cb_region = "Central" THEN DO:
        FOR EACH cvm006 
            WHERE SUBSTRING(cvm006.branch,1,1) = "3" NO-LOCK.
            FOR EACH db_bran
                 WHERE db_bran.branch = cvm006.iisbrn + "S" NO-LOCK.

                IF SUBSTRING(db_bran.branch,2,1) = "S" OR            
                   SUBSTRING(db_bran.branch,3,1) = "S" THEN DO:
        
                   CREATE wbrbran.
                   ASSIGN
                      wBranch    =  db_bran.branch   
                      wbr_desc   =  db_bran.br_desc  
                      wPhy_name  =  db_bran.phy_name
                      wlog_name  =  db_bran.log_name  
                      wConnect   =  db_bran.oth_para.        
        
                END.
            END.
        END.
   END.
   ELSE IF cb_region = "Northeastern" THEN DO:
        FOR EACH cvm006 
            WHERE SUBSTRING(cvm006.branch,1,1) = "4" NO-LOCK.
            FOR EACH db_bran 
                 WHERE db_bran.branch = cvm006.iisbrn + "S" NO-LOCK.

                IF SUBSTRING(db_bran.branch,2,1) = "S" OR            
                   SUBSTRING(db_bran.branch,3,1) = "S" THEN DO:
        
                   CREATE wbrbran.
                   ASSIGN
                      wBranch    =  db_bran.branch   
                      wbr_desc   =  db_bran.br_desc  
                      wPhy_name  =  db_bran.phy_name
                      wlog_name  =  db_bran.log_name  
                      wConnect   =  db_bran.oth_para.        
        
                END.
            END.
        END.
   END.
   ELSE IF cb_region = "Southern" THEN DO:
        FOR EACH cvm006 
            WHERE SUBSTRING(cvm006.branch,1,1) = "5" NO-LOCK.
            FOR EACH db_bran 
                 WHERE db_bran.branch = cvm006.iisbrn + "S" NO-LOCK.

                IF SUBSTRING(db_bran.branch,2,1) = "S" OR            
                   SUBSTRING(db_bran.branch,3,1) = "S" THEN DO:
        
                   CREATE wbrbran.
                   ASSIGN
                      wBranch    =  db_bran.branch   
                      wbr_desc   =  db_bran.br_desc  
                      wPhy_name  =  db_bran.phy_name
                      wlog_name  =  db_bran.log_name  
                      wConnect   =  db_bran.oth_para.        
        
                END.
            END.
        END.
   END.

   OPEN QUERY br_dbbran 
        FOR EACH wbrbran NO-LOCK BY  wbrbran.wBranch.
   OPEN QUERY br_HO 
        FOR EACH  wVatHo NO-LOCK BY   wVatHo.Ho_Bran.


  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brfr WACTRVAT
ON LEAVE OF fi_brfr IN FRAME frMain
DO:
  fi_brfr = INPUT fi_brfr.
  fi_brfrdecs = "".
  IF fi_brfr <> "" THEN DO:
     FIND FIRST db_bran WHERE db_bran.branch = fi_brfr NO-LOCK NO-ERROR.
     IF AVAIL db_bran THEN DO:
        fi_brfrdecs =  db_bran.br_desc .       
     END.        
  END.
  DISP fi_brfrdecs WITH FRAME frMain.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brto WACTRVAT
ON LEAVE OF fi_brto IN FRAME frMain
DO:
  fi_brto = INPUT fi_brto.
  fi_brtodecs = "".
  IF fi_brto <> "" THEN DO:
     IF fi_brto  < fi_brfr THEN DO:
        APPLY "ENTRY" TO fi_brto  IN FRAME frMain.
        RETURN NO-APPLY.
     END.

     FIND FIRST db_bran WHERE db_bran.branch = fi_brto NO-LOCK NO-ERROR.
     IF AVAIL db_bran THEN DO:
        fi_brtodecs =  db_bran.br_desc .       
     END.        

  END.
  DISP fi_brtodecs WITH FRAME frMain.

  RUN PDUpdateQ.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_datefr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_datefr WACTRVAT
ON LEAVE OF fi_datefr IN FRAME frMain
DO:
  fi_datefr =INPUT fi_datefr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dateto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dateto WACTRVAT
ON LEAVE OF fi_dateto IN FRAME frMain
DO:
  fi_dateto = INPUT fi_dateto.
  IF fi_dateto < fi_datefr THEN DO:
     APPLY "ENTRY" TO fi_dateto IN FRAME frMain.
     RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_seldate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_seldate WACTRVAT
ON VALUE-CHANGED OF ra_seldate IN FRAME frMain
DO:
  ra_seldate = INPUT ra_seldate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_select
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_select WACTRVAT
ON VALUE-CHANGED OF ra_select IN FRAME frMain
DO:
  ra_select = INPUT ra_select.

  IF ra_select = 1 THEN DO:
     fi_brfr = "".
     fi_brto = "".
     DISP fi_brfr fi_brto cb_region WITH FRAME frMain.
     DISABLE fi_brfr fi_brto WITH FRAME frMain.
     ENABLE cb_region  WITH FRAME frMain.
    /* RUN PDUpdateQ. */
  END.
  ELSE DO:
     fi_brfr = "".
     fi_brto = "".
     DISP fi_brfr fi_brto WITH FRAME frMain.
     DISABLE cb_region  WITH FRAME frMain.
     ENABLE fi_brfr fi_brto WITH FRAME frMain.
     RUN PDUpdateQ.
  END.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_dbbran
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK WACTRVAT 


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

  gv_prgid = "WACTRVAT.w".
  gv_prog  = "TRANSFER VAT BR TO HO".
  RUN WUT\WUTHEAD  ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  RUN WUT\WUTWICEN ({&WINDOW-NAME}:HANDLE).
  SESSION:DATA-ENTRY-RETURN = YES.
/*********************************************************************/
  ASSIGN ra_select    = 1
         ra_seldate   = 1
         fi_datefr = TODAY
         fi_dateto = TODAY
         cb_region = "Head Office". /*--- suthida t. A58-0236--*/

  DISP ra_select     
       ra_seldate   
       fi_datefr 
       fi_dateto
       cb_region /*--- suthida t. A58-0236--*/
  WITH FRAM frmain.
  DISABLE fi_brfr fi_brto WITH FRAME frMain.

  /*RUN PDUpdateQ. */

  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI WACTRVAT  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(WACTRVAT)
  THEN DELETE WIDGET WACTRVAT.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI WACTRVAT  _DEFAULT-ENABLE
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
  DISPLAY cb_region ra_select ra_seldate fi_brfr fi_brto fi_datefr fi_dateto 
          fi_brfrdecs fi_brtodecs fi_Process fi_Process2 
      WITH FRAME frMain IN WINDOW WACTRVAT.
  ENABLE cb_region ra_select ra_seldate fi_brfr fi_brto bu_Process bu_Exit 
         fi_datefr fi_dateto br_dbbran br_HO fi_brfrdecs fi_brtodecs fi_Process 
         fi_Process2 RECT-650 RECT-651 RECT-652 
      WITH FRAME frMain IN WINDOW WACTRVAT.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  VIEW WACTRVAT.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDUpdateQ WACTRVAT 
PROCEDURE PDUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wvatho.
    DELETE wvatho.
END.

FOR EACH wbrbran.
    DELETE wbrbran.
END.
IF ra_select = 1 THEN DO:
    FOR EACH db_bran WHERE 
        SUBSTRING(db_bran.branch,2,1) = "S" OR            
        SUBSTRING(db_bran.branch,3,1) = "S" NO-LOCK.   
        CREATE wbrbran.
        ASSIGN
          wBranch    =  db_bran.branch   
          wbr_desc   =  db_bran.br_desc  
          wPhy_name  =  db_bran.phy_name
          wlog_name  =  db_bran.log_name
          wConnect   =  db_bran.oth_para.        
    END.
END.
ELSE DO:
    ASSIGN nv_brfr = fi_brfr  
           nv_brto = fi_brto + "S".
    IF  fi_brfr <> "" AND fi_brto <> "" THEN DO:    
        FOR EACH db_bran WHERE 
                 db_bran.branch >= nv_brfr AND
                 db_bran.branch <= nv_brto NO-LOCK.   
            
            IF SUBSTRING(db_bran.branch,2,1) = "S" OR            
               SUBSTRING(db_bran.branch,3,1) = "S" THEN DO:

              CREATE wbrbran.
              ASSIGN
                  wBranch    =  db_bran.branch   
                  wbr_desc   =  db_bran.br_desc  
                  wPhy_name  =  db_bran.phy_name
                  wlog_name  =  db_bran.log_name  
                  wConnect   =  db_bran.oth_para.        

            END.
        END.
    END.
END.

OPEN QUERY br_dbbran 
     FOR EACH wbrbran NO-LOCK BY  wbrbran.wBranch.
OPEN QUERY br_HO 
     FOR EACH  wVatHo NO-LOCK BY   wVatHo.Ho_Bran.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdVAT116 WACTRVAT 
PROCEDURE pdVAT116 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
MESSAGE "pdVAT116".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdVAT117 WACTRVAT 
PROCEDURE pdVAT117 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
MESSAGE "pdVAT117".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

