&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
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

DEFINE NEW SHARED VAR nv_compno AS CHAR FORMAT "X(3)" INITIAL "" NO-UNDO.
DEFINE NEW SHARED VAR nv_branch AS CHAR FORMAT "X(2)" INITIAL "" NO-UNDO.

DEFINE  SHARED VAR   n_user    AS  CHAR.
DEFINE  SHARED VAR   n_passwd  AS  CHAR.

DEFINE VAR nv_connect AS CHAR FORMAT "X(60)" INITIAL "" NO-UNDO.
DEFINE VAR nv_logname AS CHAR FORMAT "X(12)" INITIAL "" NO-UNDO.

DEFINE VAR nv_Check AS LOGICAL.
DEF VAR vComp     AS CHAR.
DEF VAR vCarNO    AS CHAR.
DEF VAR vModNo    AS CHAR.
DEF VAR vTarNo    AS CHAR.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE RECTANGLE RECT-269
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 74.5 BY 1.67
     BGCOLOR 1 .

DEFINE BUTTON bucancel 
     LABEL "Cancel" 
     SIZE 11 BY 1.43
     FONT 6.

DEFINE BUTTON buexit 
     LABEL "Exit" 
     SIZE 11 BY 1.43
     FONT 6.

DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 11 BY 1.43
     FONT 6.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiCompNo AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY 1
     BGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiDisp AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 45 BY .62
     FGCOLOR 4  NO-UNDO.

DEFINE RECTANGLE RECT-270
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 47 BY 7.38.

DEFINE RECTANGLE RECT-271
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 23.5 BY 7.38.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 77.17 BY 12.14
         BGCOLOR 3 .

DEFINE FRAME frmain
     "Transfer Parameter Tariff & Model Form Premium To GW" VIEW-AS TEXT
          SIZE 68 BY .62 AT ROW 1.71 COL 6.33
          BGCOLOR 1 FGCOLOR 7 FONT 23
     RECT-269 AT ROW 1.24 COL 1.67
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.5 ROW 1.14
         SIZE 76 BY 10.81.

DEFINE FRAME frmain1
     fiDisp AT ROW 7.52 COL 1.67 COLON-ALIGNED NO-LABEL
     fiCompNo AT ROW 3.67 COL 28.33 COLON-ALIGNED NO-LABEL
     fiBranch AT ROW 5.57 COL 28.33 COLON-ALIGNED NO-LABEL
     buok AT ROW 2.71 COL 56.33
     bucancel AT ROW 4.43 COL 56.33
     buexit AT ROW 6.24 COL 56.33
     "Company No." VIEW-AS TEXT
          SIZE 14 BY .62 AT ROW 3.86 COL 13.5
          FGCOLOR 7 FONT 6
     "Branch" VIEW-AS TEXT
          SIZE 8 BY .62 AT ROW 5.86 COL 13.5
          FGCOLOR 7 FONT 6
     RECT-270 AT ROW 1.48 COL 2.5
     RECT-271 AT ROW 1.48 COL 49.83
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.67 ROW 3
         SIZE 74.33 BY 8.48
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
         TITLE              = "wgwtrfpr - Transfer Parameter Form Premium To GW"
         HEIGHT             = 11.05
         WIDTH              = 77
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 170.67
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 3
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT C-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frmain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frmain1:FRAME = FRAME frmain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frmain
                                                                        */
/* SETTINGS FOR FRAME frmain1
   Custom                                                               */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wgwtrfpr - Transfer Parameter Form Premium To GW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wgwtrfpr - Transfer Parameter Form Premium To GW */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frmain1
&Scoped-define SELF-NAME bucancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bucancel C-Win
ON CHOOSE OF bucancel IN FRAME frmain1 /* Cancel */
DO:
    ASSIGN
        nv_Compno = ""
        nv_branch = ""
        fiCompno  = ""
        fibranch  = "".

    DISP fiCompno fibranch WITH FRAME frmain1.

    APPLY "ENTRY" TO ficompno IN FRAME frmain1.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit C-Win
ON CHOOSE OF buexit IN FRAME frmain1 /* Exit */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME frmain1 /* OK */
DO:
  FIND FIRST stat.company USE-INDEX company03 
       WHERE stat.company.branch = nv_Branch AND
             stat.company.compno = nv_Compno NO-LOCK NO-ERROR.
  IF NOT AVAIL stat.company THEN DO:
      MESSAGE " Not found Company No. : " ficompno " ON stat " SKIP
              " กรุณาตรวจสอบ Compno and Branch ใหม่ "
      VIEW-AS ALERT-BOX ERROR.
      APPLY "ENTRY" TO ficompno IN FRAME frmain1.
      RETURN NO-APPLY.
  END.
  ELSE DO:
      FOR EACH brstat.Model WHERE brstat.Model.Compno = nv_compno.
          DELETE brstat.Model.
      END.
      FOR EACH brstat.Tariff WHERE brstat.Tariff.Compno = nv_Compno.
          DELETE brstat.Tariff.
      END.
      RUN PDTransfer.
      RUN PDModel.
      RUN PDTariff.
      MESSAGE "Update Parameter Tariff And Model Complete"
      VIEW-AS ALERT-BOX INFORMATION.
      {&WINDOW-NAME}:Hidden = Yes.  
      RUN wgw\wgwpar02 (vComp ,INPUT-OUTPUT vTarno, vCarno).
      {&WINDOW-NAME}:Hidden = NO.
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME frmain1
DO:
  fibranch = CAPS(INPUT fibranch).
  ASSIGN nv_Branch = fiBranch. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCompNo
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCompNo C-Win
ON LEAVE OF fiCompNo IN FRAME frmain1
DO:
  ficompno = INPUT ficompno.
  ASSIGN nv_compno = fiCompno. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
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
  RUN  WUT\WUTWICEN (C-Win:handle).
  /********************  T I T L E   F O R  C - W I N  ***************/
 /* DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wgwtrfpr".
  gv_prog  = "Transfer Parameter Form Premium To GW..".
  RUN  WUT\WUTHEAD (C-Win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (C-Win:handle). */
/********************************************************************/

  SESSION:DATA-ENTRY-RETURN = YES.

  /*ASSIGN rapara = 1.*/

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
  VIEW FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  ENABLE RECT-269 
      WITH FRAME frmain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain}
  DISPLAY fiDisp fiCompNo fiBranch 
      WITH FRAME frmain1 IN WINDOW C-Win.
  ENABLE fiDisp fiCompNo fiBranch buok bucancel buexit RECT-270 RECT-271 
      WITH FRAME frmain1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frmain1}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDModel C-Win 
PROCEDURE PDModel :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
      FOR EACH Stat.Model USE-INDEX Model01
        WHERE Stat.Model.Compno = nv_Compno /*AND
              Stat.Model.Branch = nv_Branch BREAK BY Stat.Model.Branch*/:
        FIND FIRST brstat.Model USE-INDEX Model01
             WHERE brstat.Model.Compno = Stat.Model.Compno AND
                   brstat.Model.ModNo  = stat.Model.ModNo  AND
                   brstat.Model.class  = stat.Model.Class  /*AND
                   brstat.Model.branch = stat.Model.Branch*/ NO-ERROR.
        IF NOT AVAIL brstat.Model THEN DO:
            CREATE  brstat.Model.
            ASSIGN
                brstat.Model.CompNo     =  stat.Model.CompNo
                brstat.Model.Branch     =  stat.Model.Branch
                brstat.Model.TarNo      =  stat.Model.TarNo
                brstat.Model.ModNo      =  stat.Model.ModNo
                brstat.Model.Brand      =  stat.Model.Brand
                brstat.Model.Class      =  stat.Model.Class
                brstat.Model.CC         =  stat.Model.CC
                brstat.Model.Price      =  stat.Model.Price
                brstat.Model.SI         =  stat.Model.SI
                brstat.Model.ISRate     =  stat.Model.ISRate
                brstat.Model.Premium    =  stat.Model.Premium
                brstat.Model.PAPrm      =  stat.Model.PAPrm
                brstat.Model.ExtPrm     =  stat.Model.ExtPrm
                brstat.Model.UserNo     =  n_User
                brstat.Model.UDate      =  TODAY
                brstat.Model.MarketName =  stat.Model.MarketName
                brstat.Model.PreEng     =  stat.Model.PreEng
                brstat.Model.PreBody    =  stat.Model.PreBody
                brstat.Model.TarNo1     =  stat.Model.TarNo1
                brstat.Model.TarNo2     =  stat.Model.TarNo2
                brstat.Model.Yrmnu      =  stat.Model.Yrmnu
                brstat.Model.CrPrm      =  stat.Model.CrPrm
                brstat.Model.Stat       =  stat.Model.Stat
                brstat.Model.Flag       =  stat.Model.Flag
                brstat.Model.Deci1      =  stat.Model.Deci1
                brstat.Model.Deci2      =  stat.Model.Deci2
                brstat.Model.Date1      =  stat.Model.Date1
                brstat.Model.Date2      =  stat.Model.Date2
                brstat.Model.PreDate1   =  stat.Model.PreDate1
                brstat.Model.PreDate2   =  stat.Model.PreDate2
                brstat.Model.PreDate3   =  stat.Model.PreDate3
                brstat.Model.Text1      =  stat.Model.Text1
                brstat.Model.Text2      =  stat.Model.Text2
                brstat.Model.Text3      =  stat.Model.Text3
                brstat.Model.Text4      =  stat.Model.Text4
                brstat.Model.Text5      =  stat.Model.Text5.
        END.
        ELSE DO:
            ASSIGN
                brstat.Model.Branch     =  stat.Model.Branch
                brstat.Model.TarNo      =  stat.Model.TarNo
                brstat.Model.Brand      =  stat.Model.Brand
                brstat.Model.Class      =  stat.Model.Class
                brstat.Model.CC         =  stat.Model.CC
                brstat.Model.Price      =  stat.Model.Price
                brstat.Model.SI         =  stat.Model.SI
                brstat.Model.ISRate     =  stat.Model.ISRate
                brstat.Model.Premium    =  stat.Model.Premium
                brstat.Model.PAPrm      =  stat.Model.PAPrm
                brstat.Model.ExtPrm     =  stat.Model.ExtPrm
                brstat.Model.UserNo     =  n_User
                brstat.Model.UDate      =  TODAY
                brstat.Model.MarketName =  stat.Model.MarketName
                brstat.Model.PreEng     =  stat.Model.PreEng
                brstat.Model.PreBody    =  stat.Model.PreBody
                brstat.Model.TarNo1     =  stat.Model.TarNo1
                brstat.Model.TarNo2     =  stat.Model.TarNo2
                brstat.Model.Yrmnu      =  stat.Model.Yrmnu
                brstat.Model.CrPrm      =  stat.Model.CrPrm
                brstat.Model.Stat       =  stat.Model.Stat
                brstat.Model.Flag       =  stat.Model.Flag
                brstat.Model.Deci1      =  stat.Model.Deci1
                brstat.Model.Deci2      =  stat.Model.Deci2
                brstat.Model.Date1      =  stat.Model.Date1
                brstat.Model.Date2      =  stat.Model.Date2
                brstat.Model.PreDate1   =  stat.Model.PreDate1
                brstat.Model.PreDate2   =  stat.Model.PreDate2
                brstat.Model.PreDate3   =  stat.Model.PreDate3
                brstat.Model.Text1      =  stat.Model.Text1
                brstat.Model.Text2      =  stat.Model.Text2
                brstat.Model.Text3      =  stat.Model.Text3
                brstat.Model.Text4      =  stat.Model.Text4
                brstat.Model.Text5      =  stat.Model.Text5.
        END.
        ASSIGN
            fidisp = "Compno : " + brstat.Model.Compno + " Branch : " + brstat.Model.Branch 
                     + " Brand : " + brstat.Model.Brand.
        DISP fidisp WITH FRAME frmain1.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDTariff C-Win 
PROCEDURE PDTariff :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FOR EACH Stat.Tariff USE-INDEX Tariff01 WHERE
         Stat.Tariff.Compno = nv_Compno AND
         Stat.Tariff.Branch = nv_Branch BREAK BY Stat.Tariff.Branch .
    FIND FIRST brstat.Tariff USE-INDEX Tariff01
         WHERE brstat.Tariff.Compno   = Stat.Tariff.Compno   AND
               brstat.Tariff.GrpClass = Stat.Tariff.GrpClass AND
               brstat.Tariff.EffDate  = Stat.Tariff.EffDate  AND
               brstat.Tariff.Branch   = Stat.Tariff.Branch   NO-ERROR.
    IF NOT AVAIL brstat.Tariff THEN DO:
        CREATE brstat.Tariff.
        ASSIGN
            brstat.Tariff.Tarno      = stat.Tariff.Tarno   
            brstat.Tariff.GrpClass   = stat.Tariff.GrpClass
            brstat.Tariff.CompNo     = stat.Tariff.CompNo  
            brstat.Tariff.Branch     = stat.Tariff.Branch  
            brstat.Tariff.PreTarNo   = stat.Tariff.PreTarNo
            brstat.Tariff.YearNo     = stat.Tariff.YearNo  
            brstat.Tariff.SIMin      = stat.Tariff.SIMin   
            brstat.Tariff.SIMax      = stat.Tariff.SIMax   
            brstat.Tariff.Premium    = stat.Tariff.Premium 
            brstat.Tariff.Stamp      = stat.Tariff.Stamp   
            brstat.Tariff.Tax        = stat.Tariff.Tax     
            brstat.Tariff.NetPrm     = stat.Tariff.NetPrm  
            brstat.Tariff.PAPrm      = stat.Tariff.PAPrm   
            brstat.Tariff.ExtPrm     = stat.Tariff.ExtPrm  
            brstat.Tariff.CamCode    = stat.Tariff.CamCode 
            brstat.Tariff.EffDate    = stat.Tariff.EffDate 
            brstat.Tariff.UserNo     = n_User 
            brstat.Tariff.UDate      = TODAY
            brstat.Tariff.Stat       = stat.Tariff.Stat    
            brstat.Tariff.PreDate1   = stat.Tariff.PreDate1
            brstat.Tariff.PreDate2   = stat.Tariff.PreDate2
            brstat.Tariff.PreDate3   = stat.Tariff.PreDate3
            brstat.Tariff.Deci1      = stat.Tariff.Deci1   
            brstat.Tariff.Deci2      = stat.Tariff.Deci2   
            brstat.Tariff.Deci3      = stat.Tariff.Deci3   
            brstat.Tariff.Deci4      = stat.Tariff.Deci4   
            brstat.Tariff.Deci5      = stat.Tariff.Deci5   
            brstat.Tariff.Date1      = stat.Tariff.Date1   
            brstat.Tariff.Date2      = stat.Tariff.Date2   
            brstat.Tariff.Text1      = stat.Tariff.Text1   
            brstat.Tariff.Text2      = stat.Tariff.Text2   
            brstat.Tariff.Text3      = stat.Tariff.Text3   
            brstat.Tariff.Text4      = stat.Tariff.Text4   
            brstat.Tariff.Text5      = stat.Tariff.Text5   .
    END.
    ELSE DO:
        ASSIGN
            brstat.Tariff.Tarno      = stat.Tariff.Tarno
            brstat.Tariff.Branch     = stat.Tariff.Branch
            brstat.Tariff.PreTarNo   = stat.Tariff.PreTarNo
            brstat.Tariff.YearNo     = stat.Tariff.YearNo
            brstat.Tariff.SIMin      = stat.Tariff.SIMin
            brstat.Tariff.SIMax      = stat.Tariff.SIMax
            brstat.Tariff.Premium    = stat.Tariff.Premium
            brstat.Tariff.Stamp      = stat.Tariff.Stamp
            brstat.Tariff.Tax        = stat.Tariff.Tax
            brstat.Tariff.NetPrm     = stat.Tariff.NetPrm
            brstat.Tariff.PAPrm      = stat.Tariff.PAPrm
            brstat.Tariff.ExtPrm     = stat.Tariff.ExtPrm
            brstat.Tariff.CamCode    = stat.Tariff.CamCode

            brstat.Tariff.UserNo     = n_User
            brstat.Tariff.UDate      = TODAY
            brstat.Tariff.Stat       = stat.Tariff.Stat
            brstat.Tariff.PreDate1   = stat.Tariff.PreDate1
            brstat.Tariff.PreDate2   = stat.Tariff.PreDate2
            brstat.Tariff.PreDate3   = stat.Tariff.PreDate3
            brstat.Tariff.Deci1      = stat.Tariff.Deci1
            brstat.Tariff.Deci2      = stat.Tariff.Deci2
            brstat.Tariff.Deci3      = stat.Tariff.Deci3
            brstat.Tariff.Deci4      = stat.Tariff.Deci4
            brstat.Tariff.Deci5      = stat.Tariff.Deci5
            brstat.Tariff.Date1      = stat.Tariff.Date1
            brstat.Tariff.Date2      = stat.Tariff.Date2
            brstat.Tariff.Text1      = stat.Tariff.Text1
            brstat.Tariff.Text2      = stat.Tariff.Text2
            brstat.Tariff.Text3      = stat.Tariff.Text3
            brstat.Tariff.Text4      = stat.Tariff.Text4
            brstat.Tariff.Text5      = stat.Tariff.Text5 .
    END.
    ASSIGN
           fidisp = "Compno : " + brstat.tariff.Compno + " Branch : " + brstat.tariff.Branch + " Tarno : " + brstat.tariff.Tarno.
    DISP fidisp WITH FRAME frmain1.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDTransfer C-Win 
PROCEDURE PDTransfer :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    FIND FIRST brStat.Company USE-INDEX company01 WHERE /*Company03 WHERE
               brStat.Company.Branch = Stat.Company.Branch AND*/
               brStat.Company.Compno = Stat.Company.Compno NO-ERROR.
    IF AVAIL brstat.company THEN DO:
        ASSIGN
           brstat.company.Branch         =  stat.company.Branch
           brstat.company.Name           =  stat.company.Name
           brstat.company.Name2          =  stat.company.Name2
           brstat.company.Addr1          =  stat.company.Addr1
           brstat.company.Addr2          =  stat.company.Addr2
           brstat.company.Addr3          =  stat.company.Addr3
           brstat.company.Addr4          =  stat.company.Addr4
           brstat.company.TelNo          =  stat.company.TelNo
           brstat.company.FaxNo          =  stat.company.FaxNo
           brstat.company.EMail          =  stat.company.EMail
           brstat.company.Internet       =  stat.company.Internet
           brstat.company.PrePol         =  stat.company.PrePol
           brstat.company.ABName         =  stat.company.ABName
           brstat.company.RunNo          =  stat.company.RunNo
           brstat.company.UserNo         =  n_user
           brstat.company.UDate          =  TODAY
           brstat.company.InsNoStr       =  stat.company.InsNoStr
           brstat.company.InsNoEnd       =  stat.company.InsNoEnd
           brstat.company.InsNoPrf       =  stat.company.InsNoPrf
           brstat.company.WorkHour       =  stat.company.WorkHour
           brstat.company.ContractName   =  stat.company.ContractName
           brstat.company.ConAddr1       =  stat.company.ConAddr1
           brstat.company.ConAddr2       =  stat.company.ConAddr2
           brstat.company.ConAddr3       =  stat.company.ConAddr3
           brstat.company.ConAddr4       =  stat.company.ConAddr4
           brstat.company.ConText        =  stat.company.ConText
           brstat.company.PowerName      =  stat.company.PowerName
           brstat.company.Pol2Yr         =  stat.company.Pol2Yr
           brstat.company.Over1Yr        =  stat.company.Over1Yr
           brstat.company.FlagName       =  stat.company.FlagName
           brstat.company.Tariff         =  stat.company.Tariff
           brstat.company.Class          =  stat.company.Class
           brstat.company.Flag           =  stat.company.Flag
           brstat.company.NTitle         =  stat.company.NTitle
           brstat.company.Acno1          =  stat.company.Acno1
           brstat.company.Agent          =  stat.company.Agent
           brstat.company.RenPolNo       =  stat.company.RenPolNo
           brstat.company.RenInsNo       =  stat.company.RenInsNo
           brstat.company.NextPolNo      =  stat.company.NextPolNo
           brstat.company.PrvPolNo       =  stat.company.PrvPolNo
           brstat.company.LeasNo         =  stat.company.LeasNo
           brstat.company.CashNo         =  stat.company.CashNo
           brstat.company.ProType        =  stat.company.ProType
           brstat.company.PolType        =  stat.company.PolType
           brstat.company.MaxYear        =  stat.company.MaxYear
           brstat.company.CompBen        =  stat.company.CompBen
           brstat.company.DealerFlg      =  stat.company.DealerFlg
           brstat.company.PNameFlag      =  stat.company.PNameFlag
           brstat.company.NextPolFlg     =  stat.company.NextPolFlg
           brstat.company.Stat           =  stat.company.Stat
           brstat.company.Deci1          =  stat.company.Deci1
           brstat.company.Deci2          =  stat.company.Deci2
           brstat.company.Date1          =  stat.company.Date1
           brstat.company.Date2          =  stat.company.Date2
           brstat.company.Date3          =  stat.company.Date3
           brstat.company.Date4          =  stat.company.Date4
           brstat.company.Text1          =  stat.company.Text1
           brstat.company.Text2          =  stat.company.Text2
           brstat.company.Text3          =  stat.company.Text3
           brstat.company.Text4          =  stat.company.Text4
           brstat.company.Text5          =  stat.company.Text5
           brstat.company.Text6          =  stat.company.Text6
           brstat.company.Text7          =  stat.company.Text7
           brstat.company.Text8          =  stat.company.Text8  .
        nv_Check = YES.
    END.      
    IF NOT AVAIL brStat.Company THEN DO:
        CREATE brStat.Company.
        ASSIGN
           brstat.company.CompNo         =  stat.company.CompNo
           brstat.company.Branch         =  stat.company.Branch
           brstat.company.Name           =  stat.company.Name
           brstat.company.Name2          =  stat.company.Name2
           brstat.company.Addr1          =  stat.company.Addr1
           brstat.company.Addr2          =  stat.company.Addr2
           brstat.company.Addr3          =  stat.company.Addr3
           brstat.company.Addr4          =  stat.company.Addr4
           brstat.company.TelNo          =  stat.company.TelNo
           brstat.company.FaxNo          =  stat.company.FaxNo
           brstat.company.EMail          =  stat.company.EMail
           brstat.company.Internet       =  stat.company.Internet
           brstat.company.PrePol         =  stat.company.PrePol
           brstat.company.ABName         =  stat.company.ABName
           brstat.company.RunNo          =  stat.company.RunNo
           brstat.company.UserNo         =  n_user
           brstat.company.UDate          =  TODAY
           brstat.company.InsNoStr       =  stat.company.InsNoStr
           brstat.company.InsNoEnd       =  stat.company.InsNoEnd
           brstat.company.InsNoPrf       =  stat.company.InsNoPrf
           brstat.company.WorkHour       =  stat.company.WorkHour
           brstat.company.ContractName   =  stat.company.ContractName
           brstat.company.ConAddr1       =  stat.company.ConAddr1
           brstat.company.ConAddr2       =  stat.company.ConAddr2
           brstat.company.ConAddr3       =  stat.company.ConAddr3
           brstat.company.ConAddr4       =  stat.company.ConAddr4
           brstat.company.ConText        =  stat.company.ConText
           brstat.company.PowerName      =  stat.company.PowerName
           brstat.company.Pol2Yr         =  stat.company.Pol2Yr
           brstat.company.Over1Yr        =  stat.company.Over1Yr
           brstat.company.FlagName       =  stat.company.FlagName
           brstat.company.Tariff         =  stat.company.Tariff
           brstat.company.Class          =  stat.company.Class
           brstat.company.Flag           =  stat.company.Flag
           brstat.company.NTitle         =  stat.company.NTitle
           brstat.company.Acno1          =  stat.company.Acno1
           brstat.company.Agent          =  stat.company.Agent
           brstat.company.RenPolNo       =  stat.company.RenPolNo
           brstat.company.RenInsNo       =  stat.company.RenInsNo
           brstat.company.NextPolNo      =  stat.company.NextPolNo
           brstat.company.PrvPolNo       =  stat.company.PrvPolNo
           brstat.company.LeasNo         =  stat.company.LeasNo
           brstat.company.CashNo         =  stat.company.CashNo
           brstat.company.ProType        =  stat.company.ProType
           brstat.company.PolType        =  stat.company.PolType
           brstat.company.MaxYear        =  stat.company.MaxYear
           brstat.company.CompBen        =  stat.company.CompBen
           brstat.company.DealerFlg      =  stat.company.DealerFlg
           brstat.company.PNameFlag      =  stat.company.PNameFlag
           brstat.company.NextPolFlg     =  stat.company.NextPolFlg
           brstat.company.Stat           =  stat.company.Stat
           brstat.company.Deci1          =  stat.company.Deci1
           brstat.company.Deci2          =  stat.company.Deci2
           brstat.company.Date1          =  stat.company.Date1
           brstat.company.Date2          =  stat.company.Date2
           brstat.company.Date3          =  stat.company.Date3
           brstat.company.Date4          =  stat.company.Date4
           brstat.company.Text1          =  stat.company.Text1
           brstat.company.Text2          =  stat.company.Text2
           brstat.company.Text3          =  stat.company.Text3
           brstat.company.Text4          =  stat.company.Text4
           brstat.company.Text5          =  stat.company.Text5
           brstat.company.Text6          =  stat.company.Text6
           brstat.company.Text7          =  stat.company.Text7
           brstat.company.Text8          =  stat.company.Text8  .
        nv_Check = NO.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

