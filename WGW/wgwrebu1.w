&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME wgwrebu1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS wgwrebu1 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
  wgwrebu1.w    : Export Data GW to Excel File
  Copyright     : Safety Insurance Public Company Limited
                  บริษัท ประกันคุ้มภัย จำกัด (มหาชน)
 Database       : sicsyac  , gw_safe  -ld sic_bran 
 ------------------------------------------------------------------------
 CREATE BY      : Kridtiya i.     ASSIGN:   DATE:10/12/2015  
                  เพื่อใช้เรียกข้อมูลระบบ GW เพื่อตรวจเช็คข้อมูล
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
/* Create by Nipawadee R. 18/16/2010 */

/* Program Export Excel file TIL */
/*----------------------------------------------------------------*/
/* Modify By : Eakkapong  15/09/2014 A57-0341                     */
/*            - แก้ไขโปรแกรมสำหรับดึงรายงานงานต่ออายุ 
                  และงาน New ของศรีกรุง โบรคเกอร์                 */
/*----------------------------------------------------------------*/
DEFINE VAR nv_acno     AS CHAR FORMAT "X(100)"  INIT "".            
DEFINE VAR nv_row     AS INT  INIT 0.                                
DEFINE VAR nv_count   AS INT  INIT 0.                                 
DEFINE VAR nv_output  AS CHAR FORMAT "X(45)".                         
DEFINE VAR nv_tdate   AS DATE FORMAT "99/99/9999".                  
DEFINE VAR nv_fdate   AS DATE FORMAT "99/99/9999".                   
DEFINE VAR n_name      AS CHAR FORMAT "x(50)".                       
DEFINE VAR n_chkname   As Char format "x(1)".                        
DEFINE NEW SHARED VAR n_agent1   AS CHAR FORMAT "X(10)".             
DEF TEMP-TABLE TExport      /*RUN DATA*/
    FIELD       nbatch        AS CHAR FORMAT "X(25)"  
    FIELD       nTrandat          AS CHAR FORMAT "X(10)"  
    FIELD       nPolicy       AS CHAR FORMAT "X(16)"  
    FIELD       nREcnt        AS CHAR FORMAT "X(7)"  
    FIELD       nBranch       AS CHAR FORMAT "X(2)"  
    FIELD       nCPolno       AS CHAR FORMAT "X(16)"  
    FIELD       nPrev         AS CHAR FORMAT "X(16)"  
    FIELD       nProduct          AS CHAR FORMAT "X(20)"  
    FIELD       nProm         AS CHAR FORMAT "X(20)"  
    FIELD       nAppend       AS CHAR FORMAT "X(16)"  
    FIELD       nInsd         AS CHAR FORMAT "X(10)"  
    FIELD       nName         AS CHAR FORMAT "X(80)"  
    FIELD       nAddr         AS CHAR FORMAT "X(150)"  
    FIELD       nicno         AS CHAR FORMAT "X(15)"  
    FIELD       nProducer     AS CHAR FORMAT "X(10)"  
    FIELD       nAgent        AS CHAR FORMAT "X(10)"  
    FIELD       nComm         AS CHAR FORMAT "X(10)"  
    FIELD       nExpiry       AS CHAR FORMAT "X(10)"  
    FIELD       nClass        AS CHAR FORMAT "X(5)"  
    FIELD       nCover        AS CHAR FORMAT "X(5)"  
    FIELD       nGarage       AS CHAR FORMAT "X(5)"  
    FIELD       nMakeModel        AS CHAR FORMAT "X(10)"  
    FIELD       nbrand        AS CHAR FORMAT "X(30)"  
    FIELD       nmodel        AS CHAR FORMAT "X(40)"  
    FIELD       nBody         AS CHAR FORMAT "X(20)"  
    FIELD       nEngine       AS CHAR FORMAT "X(10)"  
    FIELD       nTonnage          AS CHAR FORMAT "X(10)"  
    FIELD       nSeats        AS CHAR FORMAT "X(5)" 
    FIELD       nSeats41          AS CHAR FORMAT "X(5)"  
    FIELD       nVeh_group    AS CHAR FORMAT "X(3)"  
    FIELD       nRegistration AS CHAR FORMAT "X(15)"  
    FIELD       nEngine_no    AS CHAR FORMAT "X(30)"  
    FIELD       nChassis_no   AS CHAR FORMAT "X(30)"  
    FIELD       nYearManuf    AS CHAR FORMAT "X(5)"  
    FIELD       nVehusage     AS CHAR FORMAT "X(2)"  
    FIELD       nBenificiary  AS CHAR FORMAT "X(100)"  
    FIELD       nTPBIPer      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nTPBIPerAcc   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nTPPDPerAcc   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nOwnDamage        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nFITheft          AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nbase         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       n411PA        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       n412          AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       n42PA         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       n43BAIL       AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nDeductOD         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nPD           AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nFleet        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nNCB          AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nDSPC         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nLoad_Claim       AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nstsf         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nNAP          AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nPDnet        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nCommAPer         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nCommAPRM         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nStmp         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nVAT          AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0
    FIELD       nNETPRM       AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0.
def var nv_policy      AS CHAR FORMAT "X(16)" .                                                
def var nv_cedpol      AS CHAR FORMAT "X(16)" .  
def var nv_comdat      AS CHAR FORMAT "X(10)" .                                               
def var nv_vehreg      AS CHAR FORMAT "X(15)" .                                               
def var nv_n_class     AS CHAR FORMAT "X(5)"  .                                              
def var nv_brand       AS CHAR FORMAT "X(30)" .                                               
def var nv_model       AS CHAR FORMAT "X(50)" . 
def var nv_caryear     AS CHAR FORMAT "X(5)"   .                                                
def var nv_engcc       AS CHAR FORMAT "X(10)"  .                                                 
def var nv_cha_no      AS CHAR FORMAT "X(30)"  .                                                 
def var nv_engno       AS CHAR FORMAT "X(30)"  .                                                 
def var nv_cover       AS CHAR FORMAT "X(5)"   .                                               
def var nv_icno        AS CHAR FORMAT "X(20)"  .                                                  
def var nv_n_title     AS CHAR FORMAT "X(30)"  .                                    
def var nv_fname       AS CHAR FORMAT "X(35)"  .                                     
def var nv_lname       AS CHAR FORMAT "X(45)"  .               
def var nv_address     AS CHAR FORMAT "X(150)" .                 
/*def var nv_prem_com    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .   */           
def var nv_stmp        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .              
def var nv_vat         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .              
def var nv_prem_t      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0   .   
/*def var nv_vat_name    AS CHAR FORMAT "X(60)"  .    */                                           
/*def var nv_vat_addr    AS CHAR FORMAT "X(150)"  .     */     
def var nv_trandat     AS CHAR FORMAT "X(10)"   . 
def var nv_renewend    AS CHAR FORMAT "X(10)"  . 
def var nv_branch      AS CHAR FORMAT "X(3)"  . 
def var nv_prepol      AS CHAR FORMAT "X(16)"  . 
def var nv_Product     AS CHAR FORMAT "X(16)"   . 
def var nv_Prom        AS CHAR FORMAT "X(20)"  . 
def var nv_Append      AS CHAR FORMAT "X(16)"  . 
def var nv_Insef       AS CHAR FORMAT "X(10)"  . 
def var nv_producer    AS CHAR FORMAT "X(10)"  . 
def var nv_agent       AS CHAR FORMAT "X(10)" . 
def var nv_expdat      AS CHAR FORMAT "X(10)"   . 
def var nv_garage      AS CHAR FORMAT "X(5)"  . 
def var nv_redbook     AS CHAR FORMAT "X(10)"  . 
def var nv_body        AS CHAR FORMAT "X(30)"  . 
def var nv_tons        AS CHAR FORMAT "X(5)"   . 
def var nv_seats       AS CHAR FORMAT "X(2)"  . 
def var nv_seat41      AS CHAR FORMAT "X(2)"  . 
def var nv_vehgroup    AS CHAR FORMAT "X(2)"  .
def var nv_Vehusage    AS CHAR FORMAT "X(2)"  . 
def var nv_Benificiary AS CHAR FORMAT "X(100)"  . 
def var nv_TPBIPer     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_TPBIPerAcc  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_TPPDPerAcc  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_OwnDamage   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .   
def var nv_FI_Theft    AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
DEF VAR np_baseprm     AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_411PA       AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_412PA       AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_42PA        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_43BAIL      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_Deduct_OD   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_PD          AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_Fleet       AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_NCB         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_DSPC        AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_Load_Claim  AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
DEF VAR np_stf         AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .   
def var nv_napnet      AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_PDnet       AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_commisper   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_commispmt   AS DECI FORMAT ">>,>>>,>>>,>>9.99-" INIT 0 .  
def var nv_Batch       AS CHAR FORMAT "X(30)"  . 
DEF VAR nv_mome  AS CHAR INIT "".
/*
DEFINE VAR sv_fptr   AS RECID no-undo.
DEFINE VAR sv_bptr   AS RECID no-undo.
DEFINE VAR nvw_bptr  AS RECID.
DEFINE VAR nvw_fptr  AS RECID.
DEFINE VAR nv_fptr   AS RECID.
DEFINE VAR nv_ltext  AS CHARACTER FORMAT "X(248)".
DEF VAR i       AS INTE INIT 0.*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_process fi_fdate fi_tdate fi_producerfr ~
fi_producerto fi_branfr fi_branto fi_output ra_typpolicy ra_producer ~
bu_grpacc bu_ok bu_cel bu_hpbrn1 bu_hpbrn2 bu_grpacc-2 fi_name1 fi_name2 ~
RECT-476 RECT-474 
&Scoped-Define DISPLAYED-OBJECTS fi_process fi_fdate fi_tdate fi_producerfr ~
fi_producerto fi_branfr fi_branto fi_output ra_typpolicy ra_producer ~
fi_brndesfr fi_brndesto fi_name1 fi_name2 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR wgwrebu1 AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cel 
     LABEL "EXIT" 
     SIZE 10 BY 1.52
     FGCOLOR 6 FONT 6.

DEFINE BUTTON bu_grpacc 
     LABEL "..." 
     SIZE 4 BY 1
     FONT 6.

DEFINE BUTTON bu_grpacc-2 
     LABEL "..." 
     SIZE 4 BY 1
     FONT 6.

DEFINE BUTTON bu_hpbrn1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_hpbrn2 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 5 BY 1.

DEFINE BUTTON bu_ok 
     LABEL "OK" 
     SIZE 10 BY 1.52
     FONT 6.

DEFINE VARIABLE fi_branfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 174 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_branto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 103 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_brndesfr AS CHARACTER FORMAT "X(40)":U 
      VIEW-AS TEXT 
     SIZE 49 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brndesto AS CHARACTER FORMAT "X(40)":U 
      VIEW-AS TEXT 
     SIZE 49 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_fdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name1 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 38 BY 1
     BGCOLOR 19 FGCOLOR 3 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_name2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 38 BY 1
     BGCOLOR 19 FGCOLOR 3 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(45)":U 
     VIEW-AS FILL-IN 
     SIZE 61.67 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 90 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_producerfr AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_producerto AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_tdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_producer AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Group Producer", 1,
"Producer", 2
     SIZE 67 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typpolicy AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "V70", 1,
"V72", 2,
"All", 3
     SIZE 59.5 BY .95
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-474
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 94 BY 16.91
     BGCOLOR 18 .

DEFINE RECTANGLE RECT-476
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 94 BY 2.86
     BGCOLOR 8 FGCOLOR 8 .

DEFINE RECTANGLE RECT-477
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 14.33 BY 2.38
     BGCOLOR 1 FGCOLOR 2 .

DEFINE RECTANGLE RECT-479
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 14.33 BY 2.38
     BGCOLOR 153 FGCOLOR 2 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_process AT ROW 15.05 COL 3 COLON-ALIGNED NO-LABEL
     fi_fdate AT ROW 4.81 COL 25 COLON-ALIGNED NO-LABEL
     fi_tdate AT ROW 4.81 COL 50.83 COLON-ALIGNED NO-LABEL
     fi_producerfr AT ROW 7.33 COL 25 COLON-ALIGNED NO-LABEL
     fi_producerto AT ROW 8.57 COL 25 COLON-ALIGNED NO-LABEL
     fi_branfr AT ROW 9.95 COL 25 COLON-ALIGNED NO-LABEL
     fi_branto AT ROW 11.14 COL 25 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 13.81 COL 25 COLON-ALIGNED NO-LABEL
     ra_typpolicy AT ROW 12.48 COL 5 NO-LABEL
     ra_producer AT ROW 6.1 COL 5 NO-LABEL
     fi_brndesfr AT ROW 9.95 COL 35.83 COLON-ALIGNED NO-LABEL
     bu_grpacc AT ROW 7.33 COL 44.67
     bu_ok AT ROW 16.91 COL 41.67
     fi_brndesto AT ROW 11.14 COL 35.83 COLON-ALIGNED NO-LABEL
     bu_cel AT ROW 16.91 COL 56.17
     bu_hpbrn1 AT ROW 9.95 COL 32.5
     bu_hpbrn2 AT ROW 11.14 COL 32.67
     bu_grpacc-2 AT ROW 8.57 COL 44.67
     fi_name1 AT ROW 7.33 COL 49 NO-LABEL
     fi_name2 AT ROW 8.57 COL 49 NO-LABEL
     "To  :" VIEW-AS TEXT
          SIZE 4.5 BY 1 AT ROW 4.81 COL 47.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                                         Export Data GW to Excel File" VIEW-AS TEXT
          SIZE 88.5 BY 1.67 AT ROW 1.71 COL 6
          BGCOLOR 3 FGCOLOR 7 FONT 17
     "     TranDate From    :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 4.81 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     ".SLK" VIEW-AS TEXT
          SIZE 5.67 BY 1 AT ROW 13.81 COL 89.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Branch  To         :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 11.14 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer Code To  :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 8.57 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "         Output to File  :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 13.81 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer Code Form :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 7.33 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "      Branch From       :" VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 9.95 COL 5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-476 AT ROW 1.24 COL 3
     RECT-474 AT ROW 4.33 COL 3
     RECT-477 AT ROW 16.52 COL 39.5
     RECT-479 AT ROW 16.52 COL 54
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS THREE-D 
         AT COL 1 ROW 1
         SIZE 97.5 BY 20.62
         BGCOLOR 32 FGCOLOR 5 .


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
  CREATE WINDOW wgwrebu1 ASSIGN
         HIDDEN             = YES
         TITLE              = "WGWREBU1.W-Export Data GW to Excel File"
         HEIGHT             = 20.48
         WIDTH              = 97.17
         MAX-HEIGHT         = 33.71
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.71
         VIRTUAL-WIDTH      = 170.67
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
IF NOT wgwrebu1:LOAD-ICON("WIMAGE/safety.ico":U) THEN
    MESSAGE "Unable to load icon: WIMAGE/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW wgwrebu1
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME UNDERLINE Custom                                          */
ASSIGN 
       FRAME fr_main:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN fi_brndesfr IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brndesto IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_name1 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR FILL-IN fi_name2 IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR RECTANGLE RECT-477 IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR RECTANGLE RECT-479 IN FRAME fr_main
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwrebu1)
THEN wgwrebu1:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME wgwrebu1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwrebu1 wgwrebu1
ON END-ERROR OF wgwrebu1 /* WGWREBU1.W-Export Data GW to Excel File */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL wgwrebu1 wgwrebu1
ON WINDOW-CLOSE OF wgwrebu1 /* WGWREBU1.W-Export Data GW to Excel File */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cel wgwrebu1
ON CHOOSE OF bu_cel IN FRAME fr_main /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_grpacc
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_grpacc wgwrebu1
ON CHOOSE OF bu_grpacc IN FRAME fr_main /* ... */
DO:
   n_chkname = "1". 

   RUN Whp\WhpAgent(input-output n_name,
                    input-output n_chkname).
   ASSIGN     
        fi_producerfr = n_agent1
        fi_name1 = n_name.

   DISP fi_producerfr fi_name1 WITH FRAME fr_main.
        n_agent1 =  fi_producerfr .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_grpacc-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_grpacc-2 wgwrebu1
ON CHOOSE OF bu_grpacc-2 IN FRAME fr_main /* ... */
DO:
   n_chkname = "1". 

   RUN Whp\WhpAgent(input-output n_name,
                    input-output n_chkname).
   ASSIGN     
        fi_producerto = n_agent1
        fi_name1 = n_name.

   DISP fi_producerto fi_name1 WITH FRAME fr_main.
        n_agent1 =  fi_producerto .
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn1 wgwrebu1
ON CHOOSE OF bu_hpbrn1 IN FRAME fr_main
DO:
   RUN whp\whpbrn01(INPUT-OUTPUT fi_branfr,
                    INPUT-OUTPUT fi_brndesfr).
                                     
   DISP  fi_branfr  fi_brndesfr WITH FRAME  fr_main.                                     
   APPLY "Entry" TO fi_branto.
   RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn2 wgwrebu1
ON CHOOSE OF bu_hpbrn2 IN FRAME fr_main
DO:
   RUN  whp\whpbrn01(Input-output   fi_branto,
                     Input-output   fi_brndesto).
                                     
   DISP  fi_branto  fi_brndesto WITH FRAME  fr_main.    
   APPLY "ENTRY" TO fi_branto IN FRAME fr_main.      
   RETURN NO-APPLY.                                 

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_ok wgwrebu1
ON CHOOSE OF bu_ok IN FRAME fr_main /* OK */
DO:
   ASSIGN 
      FRAME fr_main fi_producerfr
      FRAME fr_main fi_producerto
      FRAME fr_main fi_fdate 
      FRAME fr_main fi_tdate         
      FRAME fr_main fi_branfr
      FRAME fr_main fi_branto        
      /*FRAME fr_main fi_report   */                                  
      FRAME fr_main fi_output.
   
   IF fi_producerfr = "" THEN DO: 
      MESSAGE "Please check Data Producer code...!" 
      VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fi_producerfr IN FRAME fr_main.
      RETURN NO-APPLY.
   END. /*--Check Agent--*/
   ELSE 
   IF string(fi_fdate) = ""  OR STRING(fi_fdate) = ? THEN DO:
      MESSAGE "Please check From Tran Date ..."
      VIEW-AS ALERT-BOX WARNING.      
      APPLY "Entry" TO fi_fdate IN FRAME fr_main.     
      RETURN NO-APPLY.
   END. /*-- Check formDate --*/
   ELSE 
   IF string(fi_tdate) = ""  OR STRING(fi_tdate) = ? THEN DO:
      MESSAGE "Please check data Tran date To..."
      VIEW-AS ALERT-BOX WARNING.      
      APPLY "Entry" TO fi_tdate IN FRAME fr_main.     
      RETURN NO-APPLY.
   END. /*--check Trandate to--*/
   ELSE
   IF fi_branfr = "" Then Do:
      Message "Please Check Data Branch form..."  
      VIEW-AS ALERT-BOX WARNING.
      APPLY "Entry" TO fi_branfr IN FRAME fr_main.
      RETURN NO-APPLY.
   END. /*--Check Branch form--*/
   ELSE 
   IF fi_branto = "" Then Do:
      Message "Please Check Data Branch To..."  
      VIEW-AS ALERT-BOX WARNING.
      APPLY "Entry" TO fi_branto IN FRAME fr_main.
      RETURN NO-APPLY.
   END. /*--Check branch to--*/ 
   /*ELSE
   IF string(fi_report) <> "1" AND string(fi_report) <> "2" THEN DO:
      MESSAGE "Please Input 'Report Type'...!" 
      VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fi_report IN FRAME fr_main.
      RETURN NO-APPLY.
   END. /*Check Report Type*/
   ELSE*/
   IF fi_output = "" THEN DO:
      MESSAGE "Please Input 'file name' for Output to file " 
      VIEW-AS ALERT-BOX WARNING.
      APPLY "ENTRY" TO fi_output IN FRAME fr_main.
      RETURN NO-APPLY.
   END. /*Check output*/
   ELSE DO:
       IF ra_producer= 1  THEN RUN PDProcessGp. /*by Group producer */ 
       ELSE RUN PDProcess.    

       RUN PDExport.  
       
       ASSIGN
           nv_row           = 0 
           nv_count         = 0 
           nv_acno          = ""
           fi_producerfr    = ""
           /*fi_poldes  = ""*/
           fi_name1         = ""
           fi_producerto    = ""
           fi_name2         = ""
           fi_branto        = ""
           fi_branfr        = ""
           fi_output        = "".
 
       DISP fi_producerfr fi_name1 fi_producerto fi_name2 fi_branfr  fi_branto fi_output WITH FRAME fr_main.
       DISP "" @ fi_name1 WITH FRAME fr_main.
       RUN PDCleardata.


       /*FOR EACH tproducer.           
           DELETE tproducer.
       END.
       **/  /*take*/
       HIDE FRAME fr_disp.
       MESSAGE "Process To File Complete!!" VIEW-AS ALERT-BOX.
       APPLY "ENTRY" TO fi_fdate IN FRAME fr_main.
       RETURN NO-APPLY.
   END. /*--else do*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branfr wgwrebu1
ON LEAVE OF fi_branfr IN FRAME fr_main
DO:
  fi_branfr = INPUT fi_branfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branfr wgwrebu1
ON RETURN OF fi_branfr IN FRAME fr_main
DO:
  fi_branfr = INPUT fi_branfr.
  FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
       sicsyac.xmm023.branch   =  Input  fi_branfr 
       NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
               Message  "Not on Description Master File xmm023" 
               View-as alert-box.
               Apply "Entry"  To  fi_branfr.
               RETURN NO-APPLY.
        END.
      fi_branfr    =  CAPS(Input fi_branfr) .
      fi_brndesfr  =  sicsyac.xmm023.bdes.
  Disp fi_branfr fi_brndesfr With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branto wgwrebu1
ON LEAVE OF fi_branto IN FRAME fr_main
DO:
    fi_branto = INPUT fi_branto.
    FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
        sicsyac.xmm023.branch   =  Input  fi_branto 
        NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAIL  sicsyac.xmm023 THEN DO: 
          ASSIGN  fi_branto = "".
          Message  "Not on Description Master File xmm023"      
          View-as alert-box.                                    
          Apply "Entry" To fi_branto.  
          RETURN NO-APPLY.
      END.

      ELSE DO:
        IF fi_branto < fi_branfr THEN DO:
           MESSAGE "Branch To: must more than or equal to Branch From!!" VIEW-AS ALERT-BOX.
           APPLY "Entry" TO fi_branto.
           RETURN NO-APPLY.
        END.
        ASSIGN
        fi_branto    =  CAPS(Input fi_branto) 
        fi_brndesto  =  sicsyac.xmm023.bdes.
        Disp fi_branto fi_brndesto With FRAME fr_main.

    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_fdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_fdate wgwrebu1
ON LEAVE OF fi_fdate IN FRAME fr_main
DO:
    ASSIGN 
        fi_fdate   = INPUT fi_fdate
        fi_tdate   = INPUT fi_tdate

        nv_tdate   = fi_fdate
        nv_tdate   = fi_tdate.
    IF STRING(fi_tdate) = "" OR STRING(fi_tdate) = ? THEN DO:         
        ASSIGN
            fi_tdate = nv_fdate
            nv_tdate = nv_fdate.
        DISP fi_tdate WITH FRAME fr_main.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output wgwrebu1
ON LEAVE OF fi_output IN FRAME fr_main
DO:
  fi_output = CAPS(INPUT fi_output).
  DISP fi_output WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerfr wgwrebu1
ON LEAVE OF fi_producerfr IN FRAME fr_main
DO:

  fi_producerfr = CAPS(INPUT fi_producerfr).
  fi_producerto = CAPS(INPUT fi_producerfr).

  DISP CAPS(fi_producerfr) @ fi_producerfr WITH FRAME fr_main.

  IF fi_producerfr <> " "  THEN DO:
     FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                sicsyac.xmm600.acno = fi_producerfr NO-LOCK NO-ERROR NO-WAIT. /* 15/07/10--Edit Xmm600.gpstmt*/
     IF NOT AVAIL sicsyac.xmm600 THEN DO: 
        fi_producerfr = " ".
        fi_name1:Screen-value IN FRAME {&FRAME-NAME} = " Duplicat Data Group producer..! ".
        
        MESSAGE " Not Found Data Group producer..!" VIEW-AS ALERT-BOX  WARNING  TITLE "Confirm" .
        DISP "" @ fi_name1 WITH FRAME fr_main.
        DISP "" @ fi_producerfr WITH FRAME fr_main.
        APPLY "ENTRY" TO fi_producerfr IN FRAME fr_main.
     END.
     ELSE DO:
        fi_name1:SCREEN-VALUE IN FRAME {&FRAME-NAME} = sicsyac.xmm600.name.
        fi_name2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = sicsyac.xmm600.name.
     END.
     IF ra_producer   = 1 THEN DO:
        fi_producerto = fi_producerfr.
        DISABLE fi_producerto WITH FRAME {&FRAME-NAME}.
     END.
        ELSE ENABLE fi_producerto WITH FRAME {&FRAME-NAME}.
     
     fi_producerfr = CAPS(INPUT fi_producerfr).
     DISP fi_producerfr  fi_producerto WITH FRAME fr_main.

  END.

  DISP CAPS (fi_producerfr) @ fi_producerfr fi_producerto WITH FRAME fr_main.
 
  APPLY "ENTRY" TO fi_output IN FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producerto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producerto wgwrebu1
ON LEAVE OF fi_producerto IN FRAME fr_main
DO:

  fi_producerto = CAPS(INPUT fi_producerto).

  DISP CAPS(fi_producerto) @ fi_producerto WITH FRAME fr_main.

  IF fi_producerto <> " "  THEN DO:
     FIND FIRST sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                sicsyac.xmm600.acno = fi_producerto NO-LOCK NO-ERROR NO-WAIT. /* 15/07/10--Edit Xmm600.gpstmt*/
     IF NOT AVAIL sicsyac.xmm600 THEN DO: 
        fi_producerto = " ".
        fi_name2:Screen-value IN FRAME {&FRAME-NAME} = " Duplicat Data Group producer..! ".
        MESSAGE " Not Found Data Group producer..!" VIEW-AS ALERT-BOX  WARNING  TITLE "Confirm" .
        DISP "" @ fi_name2 WITH FRAME fr_main.
        DISP "" @ fi_producerto WITH FRAME fr_main.
        APPLY "ENTRY" TO fi_producerto IN FRAME fr_main.
     END.
     ELSE DO:
        fi_name2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = sicsyac.xmm600.name.
     END.
     
     fi_producerto = CAPS(INPUT fi_producerto).
     DISP fi_producerto WITH FRAME fr_main.
  END.

  DISP CAPS (fi_producerto) @ fi_producerto WITH FRAME fr_main.
 
  APPLY "ENTRY" TO fi_output IN FRAME fr_main.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tdate wgwrebu1
ON LEAVE OF fi_tdate IN FRAME fr_main
DO:
    ASSIGN
        fi_tdate = INPUT fi_tdate
        nv_tdate = fi_tdate.
    IF nv_tdate < nv_fdate THEN DO:
        MESSAGE "trniry date To: can't less than trniry date From!! " VIEW-AS ALERT-BOX.
        APPLY "Entry"  TO  fi_tdate. 
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_producer wgwrebu1
ON VALUE-CHANGED OF ra_producer IN FRAME fr_main
DO:
  ra_producer = INPUT ra_producer.
  DISP ra_producer WITH FRAM fr_main.
    IF ra_producer = 2 THEN ENABLE fi_producerto WITH FRAME {&FRAME-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typpolicy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typpolicy wgwrebu1
ON VALUE-CHANGED OF ra_typpolicy IN FRAME fr_main
DO:
    ra_typpolicy = INPUT ra_typpolicy .
    DISP ra_typpolicy WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK wgwrebu1 


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
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  ASSIGN 
       
      gv_prgid = "WGWREBU1.W"
      gv_prog  = "Export Data GW to Excel File"
      ra_producer  = 1
      ra_typpolicy = 3
       .

  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN ({&WINDOW-NAME}:handle).

/*********************************************************************/ 
  SESSION:DATA-ENTRY-RETURN = YES.
    
   fi_tdate = TODAY.  
   fi_fdate = TODAY.  

  DISP ra_typpolicy   ra_producer fi_fdate fi_tdate WITH FRAME fr_main.

  APPLY "ENTRY" TO fi_fdate IN FRAME fr_main.
  
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI wgwrebu1  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(wgwrebu1)
  THEN DELETE WIDGET wgwrebu1.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI wgwrebu1  _DEFAULT-ENABLE
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
  DISPLAY fi_process fi_fdate fi_tdate fi_producerfr fi_producerto fi_branfr 
          fi_branto fi_output ra_typpolicy ra_producer fi_brndesfr fi_brndesto 
          fi_name1 fi_name2 
      WITH FRAME fr_main IN WINDOW wgwrebu1.
  ENABLE fi_process fi_fdate fi_tdate fi_producerfr fi_producerto fi_branfr 
         fi_branto fi_output ra_typpolicy ra_producer bu_grpacc bu_ok bu_cel 
         bu_hpbrn1 bu_hpbrn2 bu_grpacc-2 fi_name1 fi_name2 RECT-476 RECT-474 
      WITH FRAME fr_main IN WINDOW wgwrebu1.
  VIEW FRAME fr_main IN WINDOW wgwrebu1.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW wgwrebu1.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDClearData wgwrebu1 
PROCEDURE PDClearData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   /* ASSIGN
        nv_comdat   = ?
        nv_expdat   = ?
        nv_trndat   = ?  
        nv_vehreg   = ""
        nv_cedpol   = ""
        nv_name1    = ""
        nv_policy   = ""
        nv_vehuse   = ""
        nv_sumis    = 0
        nv_netprm   = 0
        nv_total    = 0    
        nv_sumprm   = 0 
        nv_compt    = 0 
        nv_endcnt   = 0 
        nv_color    = ""
        nv_dealer   = ""  
        nv_finnam   = "".  */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDExport wgwrebu1 
PROCEDURE PDExport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_number AS DECI INIT 0.
ASSIGN 
    nv_number = nv_number + 1
    nv_output = fi_output.  
IF INDEX(nv_output,".slk") = 0 THEN  nv_output = nv_output + ".slk".

OUTPUT TO VALUE(nv_output).

EXPORT DELIMITER "|"
    "รายงานข้อมูล กรมธรรม  วันที่  " +  STRING(fi_fdate,"99/99/9999") + " - " +  STRING(fi_tdate,"99/99/9999") .

RUN PdHeadOutput.
FOR EACH TExport :
    EXPORT DELIMITER "|" 
        nv_number
        TExport.nbatch        
        TExport.nTrandat  
        TExport.nPolicy   
        TExport.nREcnt    
        TExport.nBranch   
        TExport.nCPolno   
        TExport.nPrev     
        TExport.nProduct  
        TExport.nProm     
        TExport.nAppend   
        TExport.nInsd     
        TExport.nName     
        TExport.nAddr     
        TExport.nicno     
        TExport.nProducer 
        TExport.nAgent    
        TExport.nComm     
        TExport.nExpiry   
        TExport.nClass    
        TExport.nCover    
        TExport.nGarage   
        TExport.nMakeModel
        TExport.nbrand    
        TExport.nmodel    
        TExport.nBody     
        TExport.nEngine   
        TExport.nTonnage  
        TExport.nSeats    
        TExport.nSeats41  
        TExport.nVeh_group           
        TExport.nRegistration        
        TExport.nEngine_no           
        TExport.nChassis_no  
        TExport.nYearManuf   
        TExport.nVehusage    
        TExport.nBenificiary 
        TExport.nTPBIPer      FORMAT ">>,>>>,>>>,>>9.99-"   
        TExport.nTPBIPerAcc   FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nTPPDPerAcc   FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nOwnDamage    FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nFITheft      FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nbase         FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.n411PA        FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.n412          FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.n42PA         FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.n43BAIL       FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nDeductOD     FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nPDnet        FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nFleet        FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nNCB          FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nDSPC         FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nLoad_Claim   FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nstsf         FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nNAP          FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nPD           FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nCommAPer     FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nCommAPRM     FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nStmp         FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nVAT          FORMAT ">>,>>>,>>>,>>9.99-" 
        TExport.nNETPRM       FORMAT ">>,>>>,>>>,>>9.99-" .
    nv_number = nv_number + 1.
END. 

EXPORT DELIMITER "|" 
     "จำนวนข้อมูลทั้งหมด : " + STRING( nv_number - 1) .
OUTPUT CLOSE. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdHeadOutput wgwrebu1 
PROCEDURE PdHeadOutput :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/*EXPORT DELIMITER "|"
    "รายงานข้อมูล กรมธรรม  วันที่ "  + string(nv_fdate)  + "-" + string(nv_tdate) .*/
                                        
EXPORT DELIMITER "|"    
    "ลำดับที่            "          /* 1  ลำดับที่            */  
    "Batch no."
    "TranDate."
    "เลขกรมธรรม์"
    "R/E cnt.  "
    "สาขา"
    "เลขที่สัญญา"
    "เลขกรมธรรม์เดิม"
    "Product"
    "Promotion"
    "Append."
    "รหัสลูกค้า"
    "ชื่อลูกค้า"
    "ที่อยู่"
    "เลขที่บัตร"
    "Producer"
    "Agent"
    "วันเริ่มคุ้มครอง"
    "วันที่สิ้นสุด"
    "Class.."
    "ประเภท"
    "การซ่อม Garage"
    "เรดบุ๊ค"
    "ยี่ห้อ"
    "รุ่น"
    "Body.."
    "Engine CC"
    "Tonnage"
    "Seats"
    "Seats41"
    "Veh.group."
    "Registration."
    "Engine no."
    "Chassis no."
    "Year Manuf."
    "Veh.usage."
    "Benificiary:"
    "2.1 TPBI/Person"
    "2.1 TPBI/Per Acciden"
    "2.3 TPPD/Per Acciden"
    "Own Damage"
    "FI & Theft"
    "Base"
    "411PA."
    "412PA."
    "42PA."
    "43BAIL"
    "Deduct OD:"
    "PD:"
    "Fleet(%):"
    "NCB(%):"
    "DSPC(%):"
    "Load Claim(%):"
    "stsf"
    "NAP"
    "PD"
    "CommA. %"
    "CommA. PRM"
    "Stmp."
    "VAT"
    "NET PRM"  .

       
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcess wgwrebu1 
PROCEDURE PDProcess :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF   BUFFER bxmm600 FOR sicsyac.xmm600. 

/*FOR EACH xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = fi_producerfr NO-LOCK .*/
    FOR EACH sic_bran.uwm100 USE-INDEX uwm10008 WHERE
        sic_bran.uwm100.trndat >= fi_fdate            AND  
        sic_bran.uwm100.trndat <= fi_tdate            AND  
        sic_bran.uwm100.acno1  >= fi_producerfr       AND
        sic_bran.uwm100.acno1  <= fi_producerto       AND
        sic_bran.uwm100.branch >= fi_branfr           AND
        sic_bran.uwm100.branch <= fi_branto           NO-LOCK 
        BREAK BY sic_bran.uwm100.branch :    

        IF       (ra_typpolicy = 1 ) AND (sic_bran.uwm100.poltyp <> "V70") THEN NEXT .
        ELSE IF  (ra_typpolicy = 2 ) AND (sic_bran.uwm100.poltyp <> "V72") THEN NEXT .
        /*
        IF      ( ra_typreleas = 1 ) AND (sic_bran.uwm100.releas = NO )    THEN NEXT .
        ELSE IF ( ra_typreleas = 2 ) AND (sic_bran.uwm100.releas = YES )   THEN NEXT .*/

        /*VIEW FRAME fr_disp.
        DISP  "Policy : "        sic_bran.uwm100.policy  SKIP
              "Producer Code : " sic_bran.uwm100.acno1   WITH NO-LABEL FRAME fr_disp.   */
        RUN PD_initdata.
        ASSIGN
            fi_process      =  "Policy : "    +     sic_bran.uwm100.policy +
                               "Producer Code : " + sic_bran.uwm100.acno1 
            nv_Batch        = string(sic_bran.uwm100.bchyr,"9999") + "/" +
                              trim(sic_bran.uwm100.bchno)          + "/" +
                              string(sic_bran.uwm100.bchcnt,"99")
            nv_trandat      = string(sic_bran.uwm100.trndat,"99/99/9999")                    /* 1       Tran..  */
            nv_policy       = sic_bran.uwm100.policy                                         /* 2       Policy  */
            nv_renewend     = string(uwm100.rencnt,"99") + "/" + STRING(sic_bran.uwm100.endcnt,"999") /* 3      R/E cnt.*/ 
            nv_branch       = sic_bran.uwm100.branch    /* 4    Branch  */
            nv_cedpol       = sic_bran.uwm100.cedpol    /* 5    C.Pol.no        */
            nv_prepol       = sic_bran.uwm100.prvpol    /* 6    Prev..  */
            nv_Product      = sic_bran.uwm100.cr_1      /* 7    Product */
            nv_Prom         = sic_bran.uwm100.opnpol    /* 8    Prom..  */
            nv_Append       = sic_bran.uwm100.cr_2      /* 9    Append. */
            nv_Insef        = sic_bran.uwm100.insref     /* 10  Insd..  */
            nv_n_title      = sic_bran.uwm100.ntitle      /*  11        Name..  */
            nv_fname        = sic_bran.uwm100.name1     
            nv_address      = sic_bran.uwm100.addr1  + " " +  /*  12    Addr..  */
                              sic_bran.uwm100.addr2  + " " +
                              sic_bran.uwm100.addr3  + " " +
                              sic_bran.uwm100.addr4  + " " +
                              sic_bran.uwm100.postcd 
            nv_icno         = sic_bran.uwm100.anam2
            nv_producer     = sic_bran.uwm100.acno1   /* 16     Producer        */
            nv_agent        = sic_bran.uwm100.agent   /* 17        Agent   */
            nv_comdat       = string(sic_bran.uwm100.comdat,"99/99/9999")    /* 18      Comm..  */
            nv_expdat       = string(sic_bran.uwm100.expdat,"99/99/9999")    /* 19      Expiry  */
            nv_n_class      = ""   /* 20        Class.. */
            nv_cover        = ""   /* 21        Cover   */
            nv_garage       = ""   /* 22        Garage  */
            nv_redbook      = ""   /* 23        Make/Model.     */
            nv_brand        = ""   /* 24        brand   */
            nv_model        = ""   /* 25        model   */
            nv_body         = ""   /* 26        Body..  */
            nv_engcc        = ""   /* 27        Engine CC's..   */
            nv_tons         = ""   /* 28        Tonnage....     */
            nv_seats        = ""   /* 29        Seats.. */
            nv_seat41       = ""   /* 30        Veh.group.      */
            nv_vehgroup     = ""
            nv_vehreg       = ""   /*   31      Registration.   */
            nv_engno        = ""   /*   32      Engine no...    */
            nv_cha_no       = ""   /*   33      Chassis no...   */
            nv_caryear      = ""   /*   34      Year Manuf.     */
            nv_Vehusage     = ""   /* 35        Veh.usage....   */
            nv_Benificiary  = ""   /* 36        Benificiary:    */
            nv_TPBIPer      = 0   /* 37 2.1 TPBI/Person */
            nv_TPBIPerAcc   = 0   /* 38 2.1 TPBI/Per Acciden    */
            nv_TPPDPerAcc   = 0   /* 39 2.3 TPPD/Per Acciden    */
            nv_OwnDamage    = 0   /* 40 Own Damage      */
            nv_FI_Theft     = 0   /* 41 FI & Theft      */
            np_baseprm      = 0 
            nv_411PA        = 0   /* 42 41PA. 1 FOR DRIVER      */
            nv_412PA        = 0 
            nv_42PA         = 0   /* 43 42PA. 2 MEDICAL EXPENSE */
            nv_43BAIL       = 0   /* 44 43BAIL BOND     */
            nv_Deduct_OD    = 0   /* 45 Deduct  OD:     */
            nv_PD           = 0   /* 46 PD: */
            nv_Fleet        = 0   /* 47 Fleet(%):       */
            nv_NCB          = 0   /* 48 NCB(%): */
            nv_DSPC         = 0   /* 49 DSPC(%):        */
            nv_Load_Claim   = 0   /* 50 Load Claim(%):  */
            np_stf          = 0   
            nv_napnet       = 0   /*  51        NAP */
            nv_PDnet        = 0   /*  52        PD  */
            nv_commisper    = 0   /*  53        CommA. %        */
            nv_commispmt    = 0   /*  54        CommA. PRM      */
            nv_stmp         = 0   /*  55        Stmp.   */
            nv_vat          = 0   /*  57        VAT */
            nv_prem_t       = 0   /*  58        NET PRM */   .
        DISP fi_process WITH FRAM fr_main.
        IF nv_icno = ""  THEN DO:
            FIND bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = sic_bran.uwm100.insref NO-LOCK NO-ERROR.
            IF AVAILABLE bxmm600 THEN  ASSIGN nv_icno = bxmm600.icno.
        END.
        FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
            sic_bran.uwm120.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm120.bchyr  = sic_bran.uwm100.bchyr   AND
            sic_bran.uwm120.bchno  = sic_bran.uwm100.bchno   AND
            sic_bran.uwm120.bchcnt = sic_bran.uwm100.bchcnt  NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm120 THEN DO:
            ASSIGN 
                nv_n_class      = sic_bran.uwm120.CLASS
                nv_napnet       = sic_bran.uwm120.gap_r + sic_bran.uwm120.dl1_r + sic_bran.uwm120.dl2_r + sic_bran.uwm120.dl3_r  /*  51        NAP */
                nv_PDnet        = sic_bran.uwm120.prem_r   /*  52        PD  */
                nv_commisper    = sic_bran.uwm120.com1p   /*  53        CommA. %        */
                nv_commispmt    = sic_bran.uwm120.com1_r   /*  54        CommA. PRM      */
                nv_stmp         = sic_bran.uwm120.rstp_r   /*  55        Stmp.   */
                nv_vat          = sic_bran.uwm120.rtax_r  /*  57        VAT */
                nv_prem_t       = sic_bran.uwm120.prem_r  + sic_bran.uwm120.rstp_r + sic_bran.uwm120.rtax_r .  /*  58        NET PRM */     
        END.
        ELSE nv_n_class = "".
        FIND FIRST sic_bran.uwm130  USE-INDEX uwm13001     WHERE
            sic_bran.uwm130.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm130.bchyr  = sic_bran.uwm100.bchyr   AND
            sic_bran.uwm130.bchno  = sic_bran.uwm100.bchno   AND
            sic_bran.uwm130.bchcnt = sic_bran.uwm100.bchcnt  NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm130 THEN
            ASSIGN 
            nv_TPBIPer      = sic_bran.uwm130.uom1_v 
            nv_TPBIPerAcc   = sic_bran.uwm130.uom2_v
            nv_TPPDPerAcc   = sic_bran.uwm130.uom3_v 
            nv_OwnDamage    = sic_bran.uwm130.uom6_v 
            nv_FI_Theft     = sic_bran.uwm130.uom7_v.
        FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101  WHERE
            sic_bran.uwm301.policy  = sic_bran.uwm100.policy  AND
            sic_bran.uwm301.rencnt  = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm301.endcnt  = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm301.bchyr   = sic_bran.uwm100.bchyr   AND                    
            sic_bran.uwm301.bchno   = sic_bran.uwm100.bchno   AND                    
            sic_bran.uwm301.bchcnt  = sic_bran.uwm100.bchcnt  NO-LOCK NO-ERROR.      
        IF AVAIL sic_bran.uwm301 THEN DO:
            ASSIGN
                nv_cover      = sic_bran.uwm301.covcod
                nv_garage     = sic_bran.uwm301.garage 
                nv_redbook    = sic_bran.uwm301.modcod 
                nv_brand      = IF INDEX(sic_bran.uwm301.moddes," ") <> 0 THEN 
                                  trim(SUBSTR(sic_bran.uwm301.moddes,1,INDEX(sic_bran.uwm301.moddes," "))) 
                                ELSE trim(sic_bran.uwm301.moddes)                                  
                nv_model       = IF INDEX(sic_bran.uwm301.moddes," ") <> 0 THEN 
                                   trim(SUBSTR(sic_bran.uwm301.moddes,INDEX(sic_bran.uwm301.moddes," "))) 
                                ELSE ""   
                nv_body         = sic_bran.uwm301.body
                nv_engcc        = string(sic_bran.uwm301.engine)    
                nv_tons         = string(sic_bran.uwm301.tons)
                nv_seats        = string(sic_bran.uwm301.seats)
                nv_seat41       = string(uwm301.mv41seat)
                nv_vehgroup     = sic_bran.uwm301.vehgrp
                nv_vehreg       = trim(sic_bran.uwm301.vehreg)     
                nv_engno        = sic_bran.uwm301.eng_no 
                nv_cha_no       = sic_bran.uwm301.cha_no  
                nv_caryear      = string(sic_bran.uwm301.yrmanu,"9999")   
                nv_Vehusage     = sic_bran.uwm301.vehuse
                nv_Benificiary  = sic_bran.uwm301.mv_ben83    .
            FOR EACH sic_bran.uwd132 USE-INDEX uwd13201  WHERE
                sic_bran.uwd132.policy   =  sic_bran.uwm301.policy AND
                sic_bran.uwd132.rencnt   =  sic_bran.uwm301.rencnt AND
                sic_bran.uwd132.endcnt   =  sic_bran.uwm301.endcnt AND
                sic_bran.uwd132.riskno   =  sic_bran.uwm301.riskno AND
                sic_bran.uwd132.itemno   =  sic_bran.uwm301.itemno AND
                sic_bran.uwd132.bchyr    =  sic_bran.uwm301.bchyr   AND                    
                sic_bran.uwd132.bchno    =  sic_bran.uwm301.bchno   AND                    
                sic_bran.uwd132.bchcnt   =  sic_bran.uwm301.bchcnt  NO-LOCK .
                IF      sic_bran.uwd132.bencod = "base"         THEN ASSIGN np_baseprm    = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "411"          THEN ASSIGN nv_411PA      = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                ELSE IF sic_bran.uwd132.bencod = "412"          THEN ASSIGN nv_412PA      = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                ELSE IF sic_bran.uwd132.bencod = "42"           THEN ASSIGN nv_42PA       = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "43"           THEN ASSIGN nv_43BAIL     = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dod"          THEN ASSIGN nv_Deduct_OD  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dod2"         THEN ASSIGN nv_Deduct_OD  = nv_Deduct_OD  +  
                                                                                            DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dpd"          THEN ASSIGN nv_PD         = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "flet"         THEN ASSIGN nv_Fleet      = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "ncb"          THEN ASSIGN nv_NCB        = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dspc"         THEN ASSIGN nv_DSPC       = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dstf"         THEN ASSIGN np_stf        = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF index(sic_bran.uwd132.bencod,"cl") <> 0 THEN ASSIGN nv_Load_Claim = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
            END. /*uwd132*/
        END.  /*uwm301*/
        CREATE TExport.                                  
        ASSIGN   
            TExport.nbatch        =   trim(nv_batch)              
            TExport.nTrandat      =   trim(nv_trandat)         
            TExport.nPolicy       =   trim(nv_policy)          
            TExport.nREcnt        =   trim(nv_renewend)        
            TExport.nBranch       =   trim(nv_branch)          
            TExport.nCPolno       =   trim(nv_cedpol)          
            TExport.nPrev         =   trim(nv_prepol)         
            TExport.nProduct      =   trim(nv_Product)         
            TExport.nProm         =   trim(nv_Prom)            
            TExport.nAppend       =   trim(nv_Append)          
            TExport.nInsd         =   trim(nv_Insef)           
            TExport.nName         =   trim(nv_n_title)   + " " + trim(nv_fname)
            TExport.nAddr         =   trim(nv_address)         
            TExport.nicno         =   trim(nv_icno)            
            TExport.nProducer     =   trim(nv_producer)        
            TExport.nAgent        =   trim(nv_agent)           
            TExport.nComm         =   trim(nv_comdat)          
            TExport.nExpiry       =   trim(nv_expdat)          
            TExport.nClass        =   trim(nv_n_class)         
            TExport.nCover        =   trim(nv_cover)           
            TExport.nGarage       =   trim(nv_garage)          
            TExport.nMakeModel    =   trim(nv_redbook)        
            TExport.nbrand        =   trim(nv_brand)           
            TExport.nmodel        =   trim(nv_model)           
            TExport.nBody         =   trim(nv_body)            
            TExport.nEngine       =   trim(nv_engcc)           
            TExport.nTonnage      =   trim(nv_tons)            
            TExport.nSeats        =   trim(nv_seats)           
            TExport.nSeats41      =   trim(nv_seat41)          
            TExport.nVeh_group    =   trim(nv_vehgroup)        
            TExport.nRegistration =   trim(nv_vehreg)          
            TExport.nEngine_no    =   trim(nv_engno)           
            TExport.nChassis_no   =   trim(nv_cha_no)          
            TExport.nYearManuf    =   trim(nv_caryear)         
            TExport.nVehusage     =   trim(nv_Vehusage)        
            TExport.nBenificiary  =   trim(nv_Benificiary)  
            TExport.nTPBIPer      =   nv_TPBIPer         
            TExport.nTPBIPerAcc   =   nv_TPBIPerAcc      
            TExport.nTPPDPerAcc   =   nv_TPPDPerAcc      
            TExport.nOwnDamage    =   nv_OwnDamage       
            TExport.nFITheft      =   nv_FI_Theft        
            TExport.nbase         =   np_baseprm         
            TExport.n411PA        =   nv_411PA           
            TExport.n412          =   nv_412PA           
            TExport.n42PA         =   nv_42PA            
            TExport.n43BAIL       =   nv_43BAIL          
            TExport.nDeductOD     =   nv_Deduct_OD       
            TExport.nPDnet        =   nv_PD              
            TExport.nFleet        =   nv_Fleet           
            TExport.nNCB          =   nv_NCB             
            TExport.nDSPC         =   nv_DSPC            
            TExport.nLoad_Claim   =   nv_Load_Claim      
            TExport.nstsf         =   np_stf             
            TExport.nNAP          =   nv_napnet          
            TExport.nPD           =   nv_PDnet           
            TExport.nCommAPer     =   nv_commisper       
            TExport.nCommAPRM     =   nv_commispmt       
            TExport.nStmp         =   nv_stmp            
            TExport.nVAT          =   nv_vat             
            TExport.nNETPRM       =   nv_prem_t      .    
    END.  /*For uwm100 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDProcessGp wgwrebu1 
PROCEDURE PDProcessGp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF   BUFFER bxmm600 FOR sicsyac.xmm600. 
    
FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE 
    sicsyac.xmm600.gpstmt = fi_producerfr NO-LOCK .
    FOR EACH sic_bran.uwm100 USE-INDEX uwm10008 WHERE
        sic_bran.uwm100.trndat >= fi_fdate            AND  
        sic_bran.uwm100.trndat <= fi_tdate            AND  
        sic_bran.uwm100.acno1   = sicsyac.xmm600.acno AND 
        sic_bran.uwm100.branch >= fi_branfr           AND
        sic_bran.uwm100.branch <= fi_branto           NO-LOCK 
        BREAK BY sic_bran.uwm100.branch :    

        IF       (ra_typpolicy = 1 ) AND (sic_bran.uwm100.poltyp <> "V70") THEN NEXT .
        ELSE IF  (ra_typpolicy = 2 ) AND (sic_bran.uwm100.poltyp <> "V72") THEN NEXT .
        /*
        IF      ( ra_typreleas = 1 ) AND (sic_bran.uwm100.releas = NO )    THEN NEXT .
        ELSE IF ( ra_typreleas = 2 ) AND (sic_bran.uwm100.releas = YES )   THEN NEXT .*/

        /*VIEW FRAME fr_disp.
        DISP  "Policy : "        sic_bran.uwm100.policy  SKIP
              "Producer Code : " sic_bran.uwm100.acno1   WITH NO-LABEL FRAME fr_disp.   */
        RUN PD_initdata.
        ASSIGN fi_process =  "Policy : "        + sic_bran.uwm100.policy +
                             "Producer Code : " + sic_bran.uwm100.acno1 .


        DISP fi_process WITH FRAM fr_main.
        ASSIGN
            nv_Batch        = string(sic_bran.uwm100.bchyr,"9999") + "/" +
                              trim(sic_bran.uwm100.bchno)          + "/" +
                              string(sic_bran.uwm100.bchcnt,"99")
            nv_trandat      = string(sic_bran.uwm100.trndat,"99/99/9999")                    /* 1       Tran..  */
            nv_policy       = sic_bran.uwm100.policy                                         /* 2       Policy  */
            nv_renewend     = string(uwm100.rencnt,"99") + "/" + STRING(sic_bran.uwm100.endcnt,"999") /* 3      R/E cnt.*/ 
            nv_branch       = sic_bran.uwm100.branch    /* 4    Branch  */
            nv_cedpol       = sic_bran.uwm100.cedpol    /* 5    C.Pol.no        */
            nv_prepol       = sic_bran.uwm100.prvpol    /* 6    Prev..  */
            nv_Product      = sic_bran.uwm100.cr_1      /* 7    Product */
            nv_Prom         = sic_bran.uwm100.opnpol    /* 8    Prom..  */
            nv_Append       = sic_bran.uwm100.cr_2      /* 9    Append. */
            nv_Insef        = sic_bran.uwm100.insref     /* 10  Insd..  */
            nv_n_title      = sic_bran.uwm100.ntitle      /*  11        Name..  */
            nv_fname        = sic_bran.uwm100.name1     
            nv_address      = sic_bran.uwm100.addr1  + " " +  /*  12    Addr..  */
                              sic_bran.uwm100.addr2  + " " +
                              sic_bran.uwm100.addr3  + " " +
                              sic_bran.uwm100.addr4  + " " +
                              sic_bran.uwm100.postcd 
            nv_icno         = sic_bran.uwm100.anam2
            nv_producer     = sic_bran.uwm100.acno1   /* 16     Producer        */
            nv_agent        = sic_bran.uwm100.agent   /* 17        Agent   */
            nv_comdat       = string(sic_bran.uwm100.comdat,"99/99/9999")    /* 18      Comm..  */
            nv_expdat       = string(sic_bran.uwm100.expdat,"99/99/9999")    /* 19      Expiry  */
            nv_n_class      = ""   /* 20        Class.. */
            nv_cover        = ""   /* 21        Cover   */
            nv_garage       = ""   /* 22        Garage  */
            nv_redbook      = ""   /* 23        Make/Model.     */
            nv_brand        = ""   /* 24        brand   */
            nv_model        = ""   /* 25        model   */
            nv_body         = ""   /* 26        Body..  */
            nv_engcc        = ""   /* 27        Engine CC's..   */
            nv_tons         = ""   /* 28        Tonnage....     */
            nv_seats        = ""   /* 29        Seats.. */
            nv_seat41       = ""   /* 30        Veh.group.      */
            nv_vehgroup     = ""
            nv_vehreg       = ""   /*   31      Registration.   */
            nv_engno        = ""   /*   32      Engine no...    */
            nv_cha_no       = ""   /*   33      Chassis no...   */
            nv_caryear      = ""   /*   34      Year Manuf.     */
            nv_Vehusage     = ""   /* 35        Veh.usage....   */
            nv_Benificiary  = ""   /* 36        Benificiary:    */
            nv_TPBIPer      = 0   /* 37 2.1 TPBI/Person */
            nv_TPBIPerAcc   = 0   /* 38 2.1 TPBI/Per Acciden    */
            nv_TPPDPerAcc   = 0   /* 39 2.3 TPPD/Per Acciden    */
            nv_OwnDamage    = 0   /* 40 Own Damage      */
            nv_FI_Theft     = 0   /* 41 FI & Theft      */
            np_baseprm      = 0 
            nv_411PA        = 0   /* 42 41PA. 1 FOR DRIVER      */
            nv_412PA        = 0 
            nv_42PA         = 0   /* 43 42PA. 2 MEDICAL EXPENSE */
            nv_43BAIL       = 0   /* 44 43BAIL BOND     */
            nv_Deduct_OD    = 0   /* 45 Deduct  OD:     */
            nv_PD           = 0   /* 46 PD: */
            nv_Fleet        = 0   /* 47 Fleet(%):       */
            nv_NCB          = 0   /* 48 NCB(%): */
            nv_DSPC         = 0   /* 49 DSPC(%):        */
            nv_Load_Claim   = 0   /* 50 Load Claim(%):  */
            np_stf          = 0   
            nv_napnet       = 0   /*  51        NAP */
            nv_PDnet        = 0   /*  52        PD  */
            nv_commisper    = 0   /*  53        CommA. %        */
            nv_commispmt    = 0   /*  54        CommA. PRM      */
            nv_stmp         = 0   /*  55        Stmp.   */
            nv_vat          = 0   /*  57        VAT */
            nv_prem_t       = 0   /*  58        NET PRM */   .
        IF nv_icno = ""  THEN DO:
            FIND bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = sic_bran.uwm100.insref NO-LOCK NO-ERROR.
            IF AVAILABLE bxmm600 THEN  ASSIGN nv_icno = bxmm600.icno.
        END.
        FIND FIRST sic_bran.uwm120 USE-INDEX uwm12001 WHERE
            sic_bran.uwm120.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm120.bchyr  = sic_bran.uwm100.bchyr   AND
            sic_bran.uwm120.bchno  = sic_bran.uwm100.bchno   AND
            sic_bran.uwm120.bchcnt = sic_bran.uwm100.bchcnt  NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm120 THEN DO:
            ASSIGN 
                nv_n_class      = sic_bran.uwm120.CLASS
                nv_napnet       = sic_bran.uwm120.gap_r + sic_bran.uwm120.dl1_r + sic_bran.uwm120.dl2_r + sic_bran.uwm120.dl3_r  /*  51        NAP */
                nv_PDnet        = sic_bran.uwm120.prem_r   /*  52        PD  */
                nv_commisper    = sic_bran.uwm120.com1p   /*  53        CommA. %        */
                nv_commispmt    = sic_bran.uwm120.com1_r   /*  54        CommA. PRM      */
                nv_stmp         = sic_bran.uwm120.rstp_r   /*  55        Stmp.   */
                nv_vat          = sic_bran.uwm120.rtax_r  /*  57        VAT */
                nv_prem_t       = sic_bran.uwm120.prem_r  + sic_bran.uwm120.rstp_r + sic_bran.uwm120.rtax_r .  /*  58        NET PRM */     
        END.
        ELSE nv_n_class = "".
        FIND FIRST sic_bran.uwm130  USE-INDEX uwm13001     WHERE
            sic_bran.uwm130.policy = sic_bran.uwm100.policy  AND
            sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm130.bchyr  = sic_bran.uwm100.bchyr   AND
            sic_bran.uwm130.bchno  = sic_bran.uwm100.bchno   AND
            sic_bran.uwm130.bchcnt = sic_bran.uwm100.bchcnt  NO-LOCK NO-ERROR.
        IF AVAIL sic_bran.uwm130 THEN
            ASSIGN 
            nv_TPBIPer      = sic_bran.uwm130.uom1_v 
            nv_TPBIPerAcc   = sic_bran.uwm130.uom2_v
            nv_TPPDPerAcc   = sic_bran.uwm130.uom3_v 
            nv_OwnDamage    = sic_bran.uwm130.uom6_v 
            nv_FI_Theft     = sic_bran.uwm130.uom7_v.
        FIND FIRST sic_bran.uwm301 USE-INDEX uwm30101  WHERE
            sic_bran.uwm301.policy  = sic_bran.uwm100.policy  AND
            sic_bran.uwm301.rencnt  = sic_bran.uwm100.rencnt  AND
            sic_bran.uwm301.endcnt  = sic_bran.uwm100.endcnt  AND
            sic_bran.uwm301.bchyr   = sic_bran.uwm100.bchyr   AND                    
            sic_bran.uwm301.bchno   = sic_bran.uwm100.bchno   AND                    
            sic_bran.uwm301.bchcnt  = sic_bran.uwm100.bchcnt  NO-LOCK NO-ERROR.      
        IF AVAIL sic_bran.uwm301 THEN DO:
            ASSIGN
                nv_cover      = sic_bran.uwm301.covcod
                nv_garage     = sic_bran.uwm301.garage 
                nv_redbook    = sic_bran.uwm301.modcod 
                nv_brand      = IF INDEX(sic_bran.uwm301.moddes," ") <> 0 THEN 
                                  trim(SUBSTR(sic_bran.uwm301.moddes,1,INDEX(sic_bran.uwm301.moddes," "))) 
                                ELSE trim(sic_bran.uwm301.moddes)                                  
                nv_model       = IF INDEX(sic_bran.uwm301.moddes," ") <> 0 THEN 
                                   trim(SUBSTR(sic_bran.uwm301.moddes,INDEX(sic_bran.uwm301.moddes," "))) 
                                ELSE ""   
                nv_body         = sic_bran.uwm301.body
                nv_engcc        = string(sic_bran.uwm301.engine)    
                nv_tons         = string(sic_bran.uwm301.tons)
                nv_seats        = string(sic_bran.uwm301.seats)
                nv_seat41       = string(uwm301.mv41seat)
                nv_vehgroup     = sic_bran.uwm301.vehgrp
                nv_vehreg       = trim(sic_bran.uwm301.vehreg)     
                nv_engno        = sic_bran.uwm301.eng_no 
                nv_cha_no       = sic_bran.uwm301.cha_no  
                nv_caryear      = string(sic_bran.uwm301.yrmanu,"9999")   
                nv_Vehusage     = sic_bran.uwm301.vehuse
                nv_Benificiary  = sic_bran.uwm301.mv_ben83    .
            FOR EACH sic_bran.uwd132 USE-INDEX uwd13201  WHERE
                sic_bran.uwd132.policy   =  sic_bran.uwm301.policy AND
                sic_bran.uwd132.rencnt   =  sic_bran.uwm301.rencnt AND
                sic_bran.uwd132.endcnt   =  sic_bran.uwm301.endcnt AND
                sic_bran.uwd132.riskno   =  sic_bran.uwm301.riskno AND
                sic_bran.uwd132.itemno   =  sic_bran.uwm301.itemno AND
                sic_bran.uwd132.bchyr    =  sic_bran.uwm301.bchyr   AND                    
                sic_bran.uwd132.bchno    =  sic_bran.uwm301.bchno   AND                    
                sic_bran.uwd132.bchcnt   =  sic_bran.uwm301.bchcnt  NO-LOCK .
                IF      sic_bran.uwd132.bencod = "base"         THEN ASSIGN np_baseprm    = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "411"          THEN ASSIGN nv_411PA      = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                ELSE IF sic_bran.uwd132.bencod = "412"          THEN ASSIGN nv_412PA      = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).  
                ELSE IF sic_bran.uwd132.bencod = "42"           THEN ASSIGN nv_42PA       = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "43"           THEN ASSIGN nv_43BAIL     = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dod"          THEN ASSIGN nv_Deduct_OD  = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dod2"         THEN ASSIGN nv_Deduct_OD  = nv_Deduct_OD  +  
                                                                                            DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dpd"          THEN ASSIGN nv_PD         = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "flet"         THEN ASSIGN nv_Fleet      = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "ncb"          THEN ASSIGN nv_NCB        = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dspc"         THEN ASSIGN nv_DSPC       = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF sic_bran.uwd132.bencod = "dstf"         THEN ASSIGN np_stf        = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
                ELSE IF index(sic_bran.uwd132.bencod,"cl") <> 0 THEN ASSIGN nv_Load_Claim = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)).
            END. /*uwd132*/
        END.  /*uwm301*/
        CREATE TExport.                                  
        ASSIGN   
            TExport.nbatch        =   trim(nv_batch)              
            TExport.nTrandat      =   trim(nv_trandat)         
            TExport.nPolicy       =   trim(nv_policy)          
            TExport.nREcnt        =   trim(nv_renewend)        
            TExport.nBranch       =   trim(nv_branch)          
            TExport.nCPolno       =   trim(nv_cedpol)          
            TExport.nPrev         =   trim(nv_prepol)         
            TExport.nProduct      =   trim(nv_Product)         
            TExport.nProm         =   trim(nv_Prom)            
            TExport.nAppend       =   trim(nv_Append)          
            TExport.nInsd         =   trim(nv_Insef)           
            TExport.nName         =   trim(nv_n_title)   + " " + trim(nv_fname)
            TExport.nAddr         =   trim(nv_address)         
            TExport.nicno         =   trim(nv_icno)            
            TExport.nProducer     =   trim(nv_producer)        
            TExport.nAgent        =   trim(nv_agent)           
            TExport.nComm         =   trim(nv_comdat)          
            TExport.nExpiry       =   trim(nv_expdat)          
            TExport.nClass        =   trim(nv_n_class)         
            TExport.nCover        =   trim(nv_cover)           
            TExport.nGarage       =   trim(nv_garage)          
            TExport.nMakeModel    =   trim(nv_redbook)        
            TExport.nbrand        =   trim(nv_brand)           
            TExport.nmodel        =   trim(nv_model)           
            TExport.nBody         =   trim(nv_body)            
            TExport.nEngine       =   trim(nv_engcc)           
            TExport.nTonnage      =   trim(nv_tons)            
            TExport.nSeats        =   trim(nv_seats)           
            TExport.nSeats41      =   trim(nv_seat41)          
            TExport.nVeh_group    =   trim(nv_vehgroup)        
            TExport.nRegistration =   trim(nv_vehreg)          
            TExport.nEngine_no    =   trim(nv_engno)           
            TExport.nChassis_no   =   trim(nv_cha_no)          
            TExport.nYearManuf    =   trim(nv_caryear)         
            TExport.nVehusage     =   trim(nv_Vehusage)        
            TExport.nBenificiary  =   trim(nv_Benificiary)  
            TExport.nTPBIPer      =   nv_TPBIPer         
            TExport.nTPBIPerAcc   =   nv_TPBIPerAcc      
            TExport.nTPPDPerAcc   =   nv_TPPDPerAcc      
            TExport.nOwnDamage    =   nv_OwnDamage       
            TExport.nFITheft      =   nv_FI_Theft        
            TExport.nbase         =   np_baseprm         
            TExport.n411PA        =   nv_411PA           
            TExport.n412          =   nv_412PA           
            TExport.n42PA         =   nv_42PA            
            TExport.n43BAIL       =   nv_43BAIL          
            TExport.nDeductOD     =   nv_Deduct_OD       
            TExport.nPDnet        =   nv_PD              
            TExport.nFleet        =   nv_Fleet           
            TExport.nNCB          =   nv_NCB             
            TExport.nDSPC         =   nv_DSPC            
            TExport.nLoad_Claim   =   nv_Load_Claim      
            TExport.nstsf         =   np_stf             
            TExport.nNAP          =   nv_napnet          
            TExport.nPD           =   nv_PDnet           
            TExport.nCommAPer     =   nv_commisper       
            TExport.nCommAPRM     =   nv_commispmt       
            TExport.nStmp         =   nv_stmp            
            TExport.nVAT          =   nv_vat             
            TExport.nNETPRM       =   nv_prem_t      .    
    END.  /*For uwm100 */
END.  /* xmmm600 */
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PD_initdata wgwrebu1 
PROCEDURE PD_initdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_Batch = ""
            nv_trandat      = ""  /* 1  Tran..  */
            nv_policy       = ""   /* 2 Policy  */
            nv_renewend     = ""   /* 3 R/E cnt.        */
            nv_branch       = ""   /* 4 Branch  */
            nv_cedpol       = ""   /* 5 C.Pol.no        */
            nv_prepol       = ""   /* 6 Prev..  */
            nv_Product      = ""   /* 7 Product */
            nv_Prom         = ""   /* 8 Prom..  */
            nv_Append       = ""   /* 9 Append. */
            nv_Insef        = ""   /* 10        Insd..  */
            nv_n_title      = ""   /*  11       Name..  */
            nv_fname        = ""   
            nv_lname        = ""   
            nv_address      = ""   /*  12       Addr..  */
            nv_icno         = ""
            nv_producer     = ""   /* 16        Producer        */
            nv_agent        = ""   /* 17        Agent   */
            nv_comdat       = ""   /* 18        Comm..  */
            nv_expdat       = ""   /* 19        Expiry  */
            nv_n_class      = ""   /* 20        Class.. */
            nv_cover        = ""   /* 21        Cover   */
            nv_garage       = ""   /* 22        Garage  */
            nv_redbook      = ""   /* 23        Make/Model.     */
            nv_brand        = ""   /* 24        brand   */
            nv_model        = ""   /* 25        model   */
            nv_body         = ""   /* 26        Body..  */
            nv_engcc        = ""   /* 27        Engine CC's..   */
            nv_tons         = ""   /* 28        Tonnage....     */
            nv_seats        = ""   /* 29        Seats.. */
            nv_seat41       = ""   /* 30        Veh.group.      */
            nv_vehgroup     = ""
            nv_vehreg       = ""   /*   31      Registration.   */
            nv_engno        = ""   /*   32      Engine no...    */
            nv_cha_no       = ""   /*   33      Chassis no...   */
            nv_caryear      = ""   /*   34      Year Manuf.     */
            nv_Vehusage     = ""   /* 35        Veh.usage....   */
            nv_Benificiary  = ""   /* 36        Benificiary:    */
            nv_TPBIPer      = 0   /* 37 2.1 TPBI/Person */
            nv_TPBIPerAcc   = 0   /* 38 2.1 TPBI/Per Acciden    */
            nv_TPPDPerAcc   = 0   /* 39 2.3 TPPD/Per Acciden    */
            nv_OwnDamage    = 0   /* 40 Own Damage      */
            nv_FI_Theft     = 0   /* 41 FI & Theft      */
            np_baseprm      = 0 
            nv_411PA        = 0   /* 42 41PA. 1 FOR DRIVER      */
            nv_412PA        = 0 
            nv_42PA         = 0   /* 43 42PA. 2 MEDICAL EXPENSE */
            nv_43BAIL       = 0   /* 44 43BAIL BOND     */
            nv_Deduct_OD    = 0   /* 45 Deduct  OD:     */
            nv_PD           = 0   /* 46 PD: */
            nv_Fleet        = 0   /* 47 Fleet(%):       */
            nv_NCB          = 0   /* 48 NCB(%): */
            nv_DSPC         = 0   /* 49 DSPC(%):        */
            nv_Load_Claim   = 0   /* 50 Load Claim(%):  */
            np_stf          = 0   
            nv_napnet       = 0   /*  51        NAP */
            nv_PDnet        = 0   /*  52        PD  */
            nv_commisper    = 0   /*  53        CommA. %        */
            nv_commispmt    = 0   /*  54        CommA. PRM      */
            nv_stmp         = 0   /*  55        Stmp.   */
            nv_vat          = 0   /*  57        VAT */
            nv_prem_t       = 0   /*  58        NET PRM */           .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

