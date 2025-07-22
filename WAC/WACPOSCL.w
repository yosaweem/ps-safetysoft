&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: Process Outstanding Claim (for Auditor and JV OS Claim)

  Description: Process for Motor and Non motor

  Input Parameters: 
     - Trans.Date From: (Lock - 01/01/1988)
     - Trans.Date To: (Input - ทุกสิ้นเดือน)
  Output Parameters:
      <none>

  Author: 

  Created:  A49-0173  N.Sayamol   
  
  Modify By: A50-0223 N.Sayamol 
             Edit Summary for Account
             
  Modify By :  Lukkana M.  Date : 22/07/2010
  Assign No :  A53-0139  เพิ่มคอลัมน์ servey fee , total gross และแก้เงื่อนไข
               ให้แสดงข้อมูลทุก clmant    
  Modify by :  kridtiya i. A57-0343 date.30/12/2014 ปรับการให้ค่า Servey Fee                      
  Modify by : Nattanicha K. A63-0081  03/06/2020 
  Add new branch for Empire   
  
  Modify By : Nattanicha K. A63-0417 02/04/2021 
             - แยกค่าแรงค่าอะไหล่
             - คิด Vat
             
  Modify By : Nattanicha K. A64-0383 30/06/2022
             - เพิ่ม Code FV เคลมอาสา และให้ดึงโค้ดผ่าน Parameter (FE,EX,FV)
             
  Modify By : Nattanicha K. A68-0026 10/04/2025 
             - งาน Motor ให้คิด OS รวมค่า FEE and Expense เพิ่มเข้ามาในรายงานเพื่อบันทึกบัญชี GL
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
DEF VAR nv_type     AS CHAR INIT "10".  /* "PROCESS O/S Claim" */

DEF VAR nv_asmth    AS INTE INIT 0.
DEF VAR nv_frmth    AS INTE INIT 0.
DEF VAR nv_tomth    AS INTE INIT 0.

DEF VAR nv_mth      AS INTE INIT 0.

DEF VAR cv_mthListT AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR trndat_fr AS DATE FORMAT "99/99/9999". 
DEF VAR trndat_to AS DATE FORMAT "99/99/9999".
DEF VAR n_asdat   AS DATE FORMAT "99/99/9999".
DEF VAR n_procdat AS DATE FORMAT "99/99/9999".
DEF VAR n_frdate  AS DATE FORMAT "99/99/9999".
DEF VAR n_todate  AS DATE FORMAT "99/99/9999".


DEF VAR n_claim   LIKE clm100.claim.
DEF VAR poltyp    LIKE clm100.poltyp.
DEF VAR n_poltyp  AS INT INIT 0.
DEF VAR n_ostyp   AS INT INIT 0.

DEF VAR n_chkprocess AS LOGIC INIT NO.

DEF VAR n_group   AS CHAR FORMAT "X(50)".
DEF VAR n_entdat  LIKE clm102.entdat.
DEF VAR n_notdat  LIKE clm100.notdat.
DEF VAR n_policy  LIKE clm100.policy.
DEF VAR n_rencnt  LIKE clm100.rencnt.
DEF VAR n_endcnt  LIKE clm100.endcnt.
DEF VAR n_riskno  LIKE clm100.riskno.
DEF VAR n_itemno  LIKE clm100.itemno.
DEF VAR n_losdat  LIKE clm100.losdat.
DEF VAR n_vehreg  AS CHAR FORMAT "X(10)".

DEF VAR nt_os    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_os     AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_res    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_paid   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_os1    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. /*Lukkana M. A53-0139 30/08/2010*/
DEF VAR n_resfe  AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. /*Lukkana M. A53-0139 30/08/2010*/
DEF VAR n_paidfe AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. /*Lukkana M. A53-0139 30/08/2010*/
DEF VAR n_fe     AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. /*Lukkana M. A53-0139 30/08/2010*/
DEF VAR n_totos  AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. /*Lukkana M. A53-0139 30/08/2010*/

DEF VAR n_paiddat LIKE clm130.trndat.

DEF VAR n_facri AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_1st   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR n_2nd   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_qs5   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_tfp   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_eng   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_mar   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_xol   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_rq    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo1   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo2   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo3   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo4   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_ftr   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_mps   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_btr   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_otr   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_net   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.

DEF VAR n_coper AS DECI FORMAT ">>9.99".
DEF VAR n_sico  AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-"  INIT 0.
DEF VAR n_sigr  AS DECI FORMAT ">,>>>,>>>,>>>,>>9.99-"  INIT 0. 

DEF VAR n_usrid AS CHAR FORMAT "X(7)".
DEF VAR n_user  AS CHAR FORMAT "X(7)".

DEF VAR n_comppaid AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_compres  AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.

DEF VAR n_intref   AS CHAR FORMAT "X(7)".

DEF VAR n_docst    AS CHAR FORMAT "X(3)".

DEF VAR n_clmant   AS INT FORMAT ">>9".
DEF VAR n_clitem   AS INT FORMAT "99".

DEF VAR n_loss     AS CHAR FORMAT "X(20)".

DEFINE WORKFILE wclm120
    FIELD wclaim   AS CHAR FORMAT "X(12)"
    FIELD wloss    AS CHAR FORMAT "X(30)".

DEFINE VAR nv_br  AS CHAR FORMAT "X(2)" INIT "". /*-- A50-0178 --*/
DEF VAR n_resfe2  AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. /*Lukkana M. A53-0139 30/08/2010*/
DEF VAR n_paidfe2 AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. /*Lukkana M. A53-0139 30/08/2010*/

/*---A63-0417---*/
DEF VAR nt_os_nvat    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_os_nvat     AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_os_vat     AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_res_vat    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_res_nvat    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_paid_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_paidamt_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_paidamt_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_os1_vat    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR n_os1_nvat    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_resfe_nvat  AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_paidfe_nvat AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fe_nvat     AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.

DEF VAR n_totos_nvat  AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. 

DEF VAR n_facri_vat AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_1st_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR n_2nd_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_qs5_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_tfp_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_eng_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_mar_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_xol_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_rq_vat    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo1_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo2_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo3_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo4_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_ftr_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_mps_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_btr_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_otr_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_net_vat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.

DEF VAR n_facri_nvat AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_1st_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0. 
DEF VAR n_2nd_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_qs5_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_tfp_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_eng_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_mar_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_xol_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_rq_nvat    AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo1_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo2_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo3_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_fo4_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_ftr_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_mps_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_btr_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_otr_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEF VAR n_net_nvat   AS DECI FORMAT ">>,>>>,>>>,>>>,>>9.99-" INIT 0.
DEFINE VAR nv_rescod    AS CHAR FORMAT "X(8)".  
DEFINE VAR nv_descod    AS CHAR FORMAT "X(50)". 
DEFINE VAR nv_resref    AS CHAR FORMAT "X(10)". 
DEFINE VAR nv_desref    AS CHAR FORMAT "X(50)". 

DEF VAR nv_flgfee AS LOGICAL INIT NO.
/*-----end A63-0417-----------*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 IMAGE-23 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage/wallpape.bmp":U CONVERT-3D-COLORS
     SIZE 132.33 BY 23.86.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage/bgc01.bmp":U CONVERT-3D-COLORS
     SIZE 96 BY 18.33.

DEFINE BUTTON buCancel 
     LABEL "Cancel" 
     SIZE 16.5 BY 2.38
     FONT 6.

DEFINE BUTTON buOK 
     LABEL "OK" 
     SIZE 16.5 BY 2.38
     FONT 6.

DEFINE RECTANGLE RecOK
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 45.5 BY 3.38
     BGCOLOR 1 .

DEFINE VARIABLE cbToMth AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "Item 1" 
     DROP-DOWN-LIST
     SIZE 13.5 BY 1
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAsday AS INTEGER FORMAT ">9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 4 BY .95
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAsMth AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12.5 BY .95
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiAsYear AS INTEGER FORMAT "9999":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 4.5 BY .95
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiFrDay AS INTEGER FORMAT ">9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 4 BY 1
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiFrMth AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12.5 BY 1
     BGCOLOR 8  NO-UNDO.

DEFINE VARIABLE fiFrYear AS INTEGER FORMAT "9999":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 5.5 BY 1
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcday AS INTEGER FORMAT ">9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 4 BY .95
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcMth AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 12.5 BY .95
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcYear AS INTEGER FORMAT "9999":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 4.5 BY .95
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiToDay AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1.1
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE VARIABLE fiToYear AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5.5 BY 1.1
     BGCOLOR 8 FONT 1 NO-UNDO.

DEFINE RECTANGLE RecAsDate
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 31.5 BY 2.86.

DEFINE RECTANGLE RecDate
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 80 BY 3.67.

DEFINE RECTANGLE RecOS
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 85 BY 8.1.

DEFINE RECTANGLE recProcDat
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL   
     SIZE 31.33 BY 2.86.

DEFINE RECTANGLE RECT-106
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 25 BY 1.52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1.17
     IMAGE-23 AT ROW 3.62 COL 19
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 132.67 BY 23.86.

DEFINE FRAME frProcOS
     fiFrMth AT ROW 4.52 COL 16.33 COLON-ALIGNED NO-LABEL
     fiFrDay AT ROW 4.52 COL 11.67 COLON-ALIGNED NO-LABEL
     fiFrYear AT ROW 4.52 COL 29.5 COLON-ALIGNED NO-LABEL
     fiToDay AT ROW 4.43 COL 53 COLON-ALIGNED NO-LABEL
     cbToMth AT ROW 4.48 COL 57.5 COLON-ALIGNED NO-LABEL
     fiToYear AT ROW 4.43 COL 71.5 COLON-ALIGNED NO-LABEL
     fiAsday AT ROW 8.38 COL 8.67 COLON-ALIGNED NO-LABEL
     fiAsMth AT ROW 8.38 COL 13.33 COLON-ALIGNED NO-LABEL
     fiAsYear AT ROW 8.38 COL 26.5 COLON-ALIGNED NO-LABEL
     fiProcday AT ROW 8.38 COL 54 COLON-ALIGNED NO-LABEL
     fiProcMth AT ROW 8.38 COL 58.67 COLON-ALIGNED NO-LABEL
     fiProcYear AT ROW 8.38 COL 71.83 COLON-ALIGNED NO-LABEL
     "                                      PROCESS FOR OUTSTANDING CLAIM" VIEW-AS TEXT
          SIZE 86 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "  Transaction Date:" VIEW-AS TEXT
          SIZE 79 BY .71 AT ROW 2.81 COL 4.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "              Process Date:" VIEW-AS TEXT
          SIZE 30 BY .76 AT ROW 7.19 COL 51.5
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "                As of Date:" VIEW-AS TEXT
          SIZE 30 BY .76 AT ROW 7.19 COL 6.83
          BGCOLOR 1 FGCOLOR 7 FONT 6
     "From:" VIEW-AS TEXT
          SIZE 6.83 BY .95 AT ROW 4.33 COL 5.67
          FGCOLOR 7 FONT 2
     "To:" VIEW-AS TEXT
          SIZE 4.5 BY .95 AT ROW 4.33 COL 50.17
          FGCOLOR 7 FONT 2
     RecOS AT ROW 2.19 COL 1.5
     RecDate AT ROW 2.57 COL 4
     RecAsDate AT ROW 6.86 COL 6
     recProcDat AT ROW 6.86 COL 50.83
     RECT-106 AT ROW 4.24 COL 12.83
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 24 ROW 5.57
         SIZE 86.5 BY 9.76
         BGCOLOR 3 .

DEFINE FRAME frOK
     buOK AT ROW 1.95 COL 25.83
     buCancel AT ROW 1.95 COL 46.17
     RecOK AT ROW 1.43 COL 21.5
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 24 ROW 15.57
         SIZE 86.5 BY 5
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
         TITLE              = "<insert window title>"
         HEIGHT             = 23.86
         WIDTH              = 132.67
         MAX-HEIGHT         = 35.33
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 35.33
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
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* REPARENT FRAME */
ASSIGN FRAME frOK:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frProcOS:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME frOK
                                                                        */
/* SETTINGS FOR FRAME frProcOS
   Custom                                                               */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME buCancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buCancel C-Win
ON CHOOSE OF buCancel IN FRAME frOK /* Cancel */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buOK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buOK C-Win
ON CHOOSE OF buOK IN FRAME frOK /* OK */
DO:
  DEF VAR vFirstTime AS CHAR INIT "".
  DEF VAR vLastTime  AS CHAR INIT "".

  ASSIGN n_usrid = USERID(LDBNAME(1))
         n_user  = n_usrid.

  DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frProcOS fiFrDay  fiFrDay
            FRAME frProcOS fiFrMth  fiFrMth
            FRAME frProcOS fiToDay  fiToDay
            FRAME frProcOS cbToMth  cbToMth
            FRAME frProcOS fiFrYear fiFrYear
            FRAME frProcOS fiToYear fiToYear
            nv_frmth  = 1  
            nv_tomth  = LOOKUP (cbToMth, cv_mthlistE) 
            n_frdate  = DATE (nv_frmth, fiFrDay, fiFrYear)
            n_todate  = DATE (nv_tomth, fiToDay, fiToYear)
            n_asdat   = TODAY.
            
   END.
   
   IF (n_frdate > n_todate) OR n_frdate  = ? OR n_todate = ? THEN DO:
         MESSAGE "ข้อมูลวันที่ผิดพลาด" SKIP 
         "วันที่เริ่มต้นต้องมากกว่าวันที่สุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         APPLY "Entry" TO fiFrDay .
         RETURN NO-APPLY.       
   END.

   MESSAGE "ทำการประมวลผลข้อมูล ! " SKIP (1)
           "วันที่ทำการประมวลผล   : " STRING(n_asdat,"99/99/9999")  SKIP (1)
           "กรมธรรม์ตั้งแต่วันที่ : " STRING(n_frdate,"99/99/9999") " ถึง " STRING(n_todate,"99/99/9999") SKIP (1)
           "Type                        : " nv_Type + " - " + "PROCESS OUTSTANDING CLAIM FOR AC "
   VIEW-AS ALERT-BOX QUESTION  BUTTONS YES-NO
   
   UPDATE CHOICE AS LOGICAL. 

   CASE CHOICE:
        WHEN TRUE THEN DO:
   
            RUN pdChkProcess01.  /* ตรวจสอบว่า เคยมีการ process ใน type  10 ไหม  ถ้าซ้ำ  จะไม่ process ให้ */
                
            IF n_chkprocess = YES THEN DO:
               vFirstTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).

                 /*RUN pdProcess.  Lukkana M. A53-0139 30/08/2010*/
                 RUN pdProcess1.          /*Lukkana M. A53-0139 30/08/2010*/
                 RUN pdProcessYes.        /* ถ้า process เสร็จให้ Process complete = YES  elapsed*/

               vLastTime =  STRING(TODAY,"99/99/9999") +  STRING(TIME, "HH:MM AM") + " " + STRING(ETIME).
               MESSAGE "วันที่ออกรายงาน : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                       "วันที่เริ่มต้น : "  STRING(n_frdate,"99/99/9999") " ถึง "
                                            STRING(n_todate,"99/99/9999")  SKIP (1)
                       "เวลา  " SUBSTR(vFirstTime,1,18) "  -  " 
                                SUBSTR(vLastTime,1,18) " น."
               VIEW-AS ALERT-BOX INFORMATION.

               /* ประมวลผลเสร็จออกจากโปรแกรมทันที*/
               MESSAGE "ประมวลผลเรียบร้อย"  VIEW-AS ALERT-BOX INFORMATION.
               APPLY "CHOOSE" TO buCancel.
            END.

            ELSE DO:
               MESSAGE "ไม่สามารถ Process ได้ เนื่องจาก"  SKIP (1)
                       "มีการ Process ใน As date นี้แล้ว" 
               VIEW-AS ALERT-BOX ERROR.
               RETURN NO-APPLY.
            END. /*  n_chkprocess = yes*/
        END.
        WHEN FALSE THEN DO:
        RETURN NO-APPLY.    
        END.
   END CASE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frProcOS
&Scoped-define SELF-NAME cbToMth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbToMth C-Win
ON VALUE-CHANGED OF cbToMth IN FRAME frProcOS
DO:
    ASSIGN cbtoMth = INPUT cbtoMth.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToDay
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToDay C-Win
ON VALUE-CHANGED OF fiToDay IN FRAME frProcOS
DO:
  ASSIGN fiToDay  = INPUT fiToDay.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiToYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiToYear C-Win
ON VALUE-CHANGED OF fiToYear IN FRAME frProcOS
DO:
  ASSIGN fiToYear = INPUT fiToYear.
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

SESSION:DATA-ENTRY-RETURN = YES.

/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "WACPOSCL".
  gv_prog  = "PROCESS OUTSTANDING CLAIM".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
   DO WITH FRAME frProcOS:
      ASSIGN  
        cbToMth:List-Items  = cv_mthlistE 
        fiFrDay     = 1      
        fiFrMth     = "    January" 
        fiFrYear    = 1988
        
        fiToDay     = DAY (TODAY) 
        cbToMth     = ENTRY(MONTH (TODAY),  cv_mthlistE) 
        fiToYear    = YEAR (TODAY)
        fiAsDay     = fiToDay
        fiAsMth     = cbToMth
        fiAsYear    = fiToYear
        fiProcDay   = DAY (TODAY)
        fiProcMth   = cbToMth
        fiProcYear  = YEAR (TODAY)
        n_poltyp    = 1
        n_ostyp     = 1.
      
      CASE fiAsMth:
          WHEN "1"  THEN 
               ASSIGN nv_mth = 1 
                      fiAsMth = "มกราคม".
          WHEN "2"  THEN 
               ASSIGN nv_mth = 2
                      fiAsMth = "กุมภาพันธ์".
          WHEN "3"  THEN 
               ASSIGN nv_mth = 3
                      fiAsMth = "มีนาคม".
          WHEN "4"  THEN 
               ASSIGN nv_mth = 4
                      fiAsMth = "เมษายน".
          WHEN "5"  THEN 
               ASSIGN nv_mth = 5 
                      fiAsMth = "พฤษภาคม".
          WHEN "6"  THEN 
               ASSIGN nv_mth = 6
                      fiAsMth = "มิถุนายน".
          WHEN "7"  THEN 
               ASSIGN nv_mth = 7
                      fiAsMth = "กรกฎาคม".
          WHEN "8"  THEN 
               ASSIGN nv_mth = 8
                      fiAsMth = "สิงหาคม".
          WHEN "9"  THEN 
               ASSIGN nv_mth = 9
                      fiAsMth = "กันยายน".
          WHEN "10" THEN 
               ASSIGN nv_mth = 10
                      fiAsMth = "ตุลาคม".
          WHEN "11" THEN 
               ASSIGN nv_mth = 11
                      fiAsMth = "พฤศจิกายน".
          WHEN "12" THEN 
               ASSIGN nv_mth = 12
                      fiAsMth = "ธันวาคม".
      END CASE.

      DISPLAY fiFrDay   fiFrMth   fiFrYear
              fiToDay   cbToMth   fiToYear
              fiAsDay   fiAsMth   fiAsYear
              fiProcDay fiProcMth fiProcYear
      WITH FRAME frProcOS .

      APPLY "ENTRY" TO fiToDay.
  
    END.
/*-------------*/

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
  ENABLE IMAGE-21 IMAGE-23 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY fiFrMth fiFrDay fiFrYear fiToDay cbToMth fiToYear fiAsday fiAsMth 
          fiAsYear fiProcday fiProcMth fiProcYear 
      WITH FRAME frProcOS IN WINDOW C-Win.
  ENABLE fiFrMth fiFrDay fiFrYear fiToDay cbToMth fiToYear fiAsday fiAsMth 
         fiAsYear fiProcday fiProcMth fiProcYear RecOS RecDate RecAsDate 
         recProcDat RECT-106 
      WITH FRAME frProcOS IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frProcOS}
  ENABLE RecOK buOK buCancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdChkProcess01 C-Win 
PROCEDURE pdChkProcess01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    n_chkprocess = NO.

    FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
              (acProc_fil.asdat = n_asdat AND acProc_fil.type = "10") OR
              (acProc_fil.asdat = n_asdat AND 
               acProc_fil.type = "10" AND
               SUBSTR(acProc_fil.enttim,10,3)  = "YES") NO-ERROR.
    IF AVAIL acProc_fil THEN DO:
       n_chkprocess = NO.  
    END.
    ELSE DO:
        n_chkprocess = YES.  /*ไม่พบ  10  สามารถ process ได้*/
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdclear C-Win 
PROCEDURE pdclear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    n_os     = 0   nt_os    = 0     n_res    = 0  n_paid = 0  n_facri  = 0    
    n_1st    = 0   n_2nd    = 0     n_qs5    = 0  n_tfp  = 0  n_eng    = 0  
    n_mar    = 0   n_xol    = 0     n_rq     = 0  n_fo1  = 0  n_fo2    = 0   
    n_fo3    = 0   n_fo4    = 0     n_ftr    = 0  n_mps  = 0  n_btr    = 0    
    n_otr    = 0   n_net    = 0     n_coper  = 0  n_sico = 0  n_sigr   = 0  
    n_intref = ""  n_docst  = "".
ASSIGN
    n_os_nvat     = 0   nt_os_nvat    = 0     n_res_nvat    = 0  n_paid_nvat = 0  n_facri_nvat  = 0    
    n_1st_nvat    = 0   n_2nd_nvat    = 0     n_qs5_nvat    = 0  n_tfp_nvat  = 0  n_eng_nvat    = 0  
    n_mar_nvat    = 0   n_xol_nvat    = 0     n_rq_nvat     = 0  n_fo1_nvat  = 0  n_fo2_nvat    = 0   
    n_fo3_nvat    = 0   n_fo4_nvat    = 0     n_ftr_nvat    = 0  n_mps_nvat  = 0  n_btr_nvat    = 0    
    n_otr_nvat    = 0   n_net_nvat    = 0 .

/*---A63-0417---*/
ASSIGN n_os_vat  = 0 
       n_res_vat = 0
       n_paidamt_vat  = 0
       n_os_nvat = 0
       n_res_nvat = 0
       n_paidamt_nvat = 0.
/*-----------------*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdczm100 C-Win 
PROCEDURE pdczm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN czm100.ASDAT   =  n_asdat
       czm100.POLTYP  =  CLM100.POLTYP
       czm100.GRPTYP  =  n_group
       czm100.BRANCH  =  nv_br
       czm100.CLAIM   =  CLM100.CLAIM
       czm100.ENTDAT  =  CLM102.ENTDAT
       czm100.NOTDAT  =  CLM100.NOTDAT
       czm100.POLICY  =  CLM100.POLICY
       czm100.RENCNT  =  CLM100.RENCNT
       czm100.ENDCNT  =  CLM100.ENDCNT
       czm100.RISKNO  =  CLM100.RISKNO
       czm100.ITEMNO  =  CLM100.ITEMNO
       czm100.VEHREG  =  n_vehreg
       czm100.LOSS    =  n_loss
       czm100.LOSDAT  =  CLM100.LOSDAT.
       /*---A66-0048---
       czm100.os      =  czm100.os + czd101.osres
       czm100.os_netvat = czm100.os_netvat + czd101.osres_netvat
       czm100.os_vat  =  czm100.os_vat + czd101.osres_vat.  
       ----*/
       /*---A66-0048---*/
       IF nv_flgfee = NO THEN DO:
          ASSIGN czm100.os      =  czm100.os + czd101.osres.
       END.
       ASSIGN  czm100.os_netvat = czm100.os_netvat + czd101.osres_netvat
               czm100.os_vat  =  czm100.os_vat + czd101.osres_vat.
       

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdczm100_1 C-Win 
PROCEDURE pdczm100_1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN czm100.AMT[1]  =  n_1st
       czm100.AMT[2]  =  n_2nd
       czm100.AMT[3]  =  n_facri
       czm100.AMT[4]  =  n_qs5
       czm100.AMT[5]  =  n_tfp  
       czm100.AMT[6]  =  n_mps
       czm100.AMT[7]  =  n_eng
       czm100.AMT[8]  =  n_mar
       czm100.AMT[9]  =  n_rq
       czm100.AMT[10] =  n_btr
       czm100.AMT[11] =  n_otr
       czm100.AMT[12] =  n_ftr
       czm100.AMT[13] =  n_fo1
       czm100.AMT[14] =  n_fo2
       czm100.AMT[15] =  n_fo3
       czm100.AMT[16] =  n_fo4
       czm100.AMT[17] =  n_net
       czm100.AMT[18] =  n_xol
       czm100.AMT[19] =  n_fe     /*Lukkana M. A53-0139 30/08/2010*/
       czm100.AMT[20] =  n_totos  /*Lukkana M. A53-0139 30/08/2010*/
       czm100.intref  =  n_intref
       czm100.COPER   =  n_coper
       czm100.SICO    =  n_sico
       czm100.USRID   =  n_usrid
       czm100.DOCST   =  IF clm120.prdlos = 0 THEN "NO" ELSE "YES"
       /* A63-0417 */
       czm100.AMOUNT_NETVAT[1]  =  n_1st_nvat
       czm100.AMOUNT_NETVAT[2]  =  n_2nd_nvat
       czm100.AMOUNT_NETVAT[3]  =  n_facri_nvat
       czm100.AMOUNT_NETVAT[4]  =  n_qs5_nvat
       czm100.AMOUNT_NETVAT[5]  =  n_tfp_nvat  
       czm100.AMOUNT_NETVAT[6]  =  n_mps_nvat
       czm100.AMOUNT_NETVAT[7]  =  n_eng_nvat
       czm100.AMOUNT_NETVAT[8]  =  n_mar_nvat
       czm100.AMOUNT_NETVAT[9]  =  n_rq_nvat
       czm100.AMOUNT_NETVAT[10] =  n_btr_nvat
       czm100.AMOUNT_NETVAT[11] =  n_otr_nvat
       czm100.AMOUNT_NETVAT[12] =  n_ftr_nvat
       czm100.AMOUNT_NETVAT[13] =  n_fo1_nvat
       czm100.AMOUNT_NETVAT[14] =  n_fo2_nvat
       czm100.AMOUNT_NETVAT[15] =  n_fo3_nvat
       czm100.AMOUNT_NETVAT[16] =  n_fo4_nvat
       czm100.AMOUNT_NETVAT[17] =  n_net_nvat
       czm100.AMOUNT_NETVAT[18] =  n_xol_nvat
       czm100.AMOUNT_NETVAT[19] =  n_fe_nvat    
       czm100.AMOUNT_NETVAT[20] =  n_totos_nvat . 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDel01 C-Win 
PROCEDURE pdDel01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
           acProc_fil.type  = "10"    AND 
           acProc_fil.asdat = n_asdat NO-ERROR.
    IF NOT AVAIL acProc_fil THEN DO:
           CREATE acProc_fil.
           ASSIGN
               acProc_fil.type     = "10"
               acProc_fil.typdesc  = "Process Outstanding Claim"
               acProc_fil.asdat    = n_asdat
               acProc_fil.trndatfr = n_frdate
               acProc_fil.trndatto = n_todate
               acProc_fil.entdat   = TODAY
               acProc_fil.enttim   = STRING(TIME, "HH:MM:SS") + ":NO"
               acProc_fil.usrid    = n_user.
    END.
    IF AVAIL acProc_fil THEN DO:
       ASSIGN
           acProc_fil.type     = "10"
           acProc_fil.typdesc  = "Process Outstanding Claim"
           acProc_fil.asdat    = n_asdat
           acProc_fil.trndatfr = n_frdate
           acProc_fil.trndatto = n_todate
           acProc_fil.entdat   = TODAY
           acProc_fil.enttim   = STRING(TIME, "HH:MM:SS") + ":NO"
           acProc_fil.usrid    = n_user.
    END.                            

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess C-Win 
PROCEDURE pdProcess :
/*------------------------------------------------------------------------------
  Purpose: Process Data For Outstanding Claim    
  Parameters:  <none>
  Notes: Assign No. A49-0173 By Sayamol 28/11/2006      
------------------------------------------------------------------------------*/
RUN pdDel01.  /*"01" Delete agtprm_fil  &  Create acproc_fil "10"*/ 

/*DISP "กำลัง Process.... ข้อมูลอยู่ " WITH NO-LABEL CENTER FRAME frWait.*/
n_os = 0.

Loop_clm100:
FOR EACH clm102 USE-INDEX  clm10202 WHERE
         clm102.entdat >= n_frdate  AND
         clm102.entdat <= n_todate  NO-LOCK:

    ASSIGN n_entdat = clm102.entdat.

    FIND FIRST clm100 USE-INDEX clm10001    WHERE
               clm100.claim = clm102.claim  NO-LOCK NO-ERROR.
    IF AVAIL clm100 THEN DO:

       ASSIGN poltyp = clm100.poltyp
              n_notdat = clm100.notdat
              n_policy = clm100.policy
              n_rencnt = clm100.rencnt
              n_endcnt = clm100.endcnt
              n_riskno = clm100.riskno
              n_itemno = clm100.itemno
              n_losdat = clm100.losdat.
     
       /*---------- A63-0081 Nattanicha ------------------
       /*---------- Add chutikarn A50-0178 -------------*/
       /*----
       IF SUBSTR(clm100.claim,1,1)  <> "D"  AND
          SUBSTR(clm100.claim,1,1)  <> "I"  THEN NEXT loop_clm100.
       ----*/
       IF (SUBSTR(clm100.claim,1,1) <> "D"  AND SUBSTRING(clm100.claim,1,1) <> "I") AND 
          (SUBSTR(clm100.claim,1,2) < "10"  AND SUBSTRING(clm100.claim,1,2) > "99") THEN NEXT loop_clm100.
       /*---------- End chutikarn A50-0178 -------------*/
       ---------------------------end A63-0081-----*/

       /*------A63-0081----*/
       IF (SUBSTR(clm100.claim,1,1) <> "D"  AND SUBSTRING(clm100.claim,1,1) <> "I"  AND
           SUBSTR(clm100.claim,1,1) <> "G"  AND SUBSTRING(clm100.claim,1,1) <> "M") AND 
          (SUBSTR(clm100.claim,1,2) < "10"  AND SUBSTRING(clm100.claim,1,2) > "99") THEN NEXT loop_clm100.
       /*-------------------*/

       IF clm100.poltyp  = " " THEN NEXT loop_clm100.

       IF Clm100.padsts <> " "    AND  /* Check paid status is close or open */
          Clm100.padsts <> "O"    AND
          Clm100.padsts <> "P"    THEN NEXT loop_clm100.

        FIND FIRST S0M005 USE-INDEX S0M00501   WHERE /*--- Group Type ---*/
                   S0M005.key2 = CLM100.POLTYP NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL s0m005 THEN n_group = s0m005.key1.
        
        Loop_clm120:
        FOR EACH clm120 USE-INDEX clm12001     WHERE
                 clm120.claim  = clm100.claim  NO-LOCK
        BREAK BY clm120.claim BY clm120.clmant BY clm120.clitem:

        DISP "..กำลัง Process ข้อมูลอยู่.." SKIP
              clm120.claim WITH NO-LABEL TITLE "Process O/S Claim Monthly" FRAME a
        VIEW-AS DIALOG-BOX.
       
        //IF (Clm120.loss <> 'FE' AND Clm120.loss <> 'EX') THEN DO:   ---A64-0383---
        FIND FIRST sym100 USE-INDEX sym10001 WHERE
           sym100.tabcod = "CMLO"         AND
           sym100.itmcod = clm120.loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
        IF NOT AVAIL sym100 THEN DO:   /*A64-0383*/
           IF (Clm120.styp20 <> 'X' AND    /* X : Claim Without Paid */
               Clm120.styp20 <> 'F' AND    /* F : Final (complete paid) */
               Clm120.styp20 <> 'R')       /* R : Re-open */
           THEN DO:

           IF SUBSTR(clm120.claim,3,1) = "7" THEN n_loss = clm120.loss.
           ELSE DO:
              IF FIRST-OF (CLM120.CLMANT) THEN DO:     /*--- หาค่า Nature  ของ Claim แต่ละ Clmant  ซึ่งจะนำไปใช้ในการออก Report  คอลัมน์ Nature of Loss ---*/
                 //IF CLM120.LOSS <> 'FE'  AND CLM120.LOSS  <>  'EX' THEN DO:    --A68-0026---
                  FIND FIRST sym100 USE-INDEX sym10001 WHERE
                     sym100.tabcod = "CMLO"         AND
                     sym100.itmcod = clm120.loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
                  IF NOT AVAIL sym100 THEN DO:   /*A64-0383*/
                    /*--- Create ลง Workfile เพื่อเก็บ Nature ของแต่ละ Clmant กรณีที่ Claim 1 Claim มีหลาย Clmant ---*/
                    FIND FIRST    WCLM120    WHERE    WCLM120.WCLAIM   =   CLM120.CLAIM  NO-ERROR.                                                               
                    IF NOT AVAILABLE WCLM120 THEN DO:
                       CREATE  WCLM120.
                       ASSIGN  WCLM120.WCLAIM = CLM120.CLAIM
                               WCLM120.WLOSS  = " ".
                    END.
                    IF WCLM120.WLOSS =  " " THEN DO:
                       IF CLM120.LOSS <> " " THEN WCLM120.WLOSS = CAPS(CLM120.LOSS).
                    END.
                    ELSE DO:
                       IF CLM120.LOSS <> " " THEN WCLM120.WLOSS = TRIM(WCLM120.WLOSS) + "," + CAPS(CLM120.LOSS). 
                    END.
                    /*--- ตัวอย่างเช่น Nature of Loss ของ Claim ที่ได้ --->   "DH, DA"  กรณีที่ Claim 1 Claim มีหลาย Clmant ---*/ 
                 END. /* "FE" & "EX" */
              END. /* first-of clm120.clmant */    
              n_loss = WCLM120.WLOSS.
           END.  

           IF LAST-OF(clm120.clitem) THEN DO:
              FOR EACH clm131 USE-INDEX clm13101       WHERE
                       clm131.claim   = clm100.claim   AND
                       clm131.clmant  = clm120.clmant  AND
                       clm131.clitem  = clm120.clitem  AND
                       clm131.cpc_cd  = "EPD"          AND 
                       clm131.trndat  >= n_frdate      AND 
                       clm131.trndat  <= n_todate      NO-LOCK:
                  IF clm131.res <> ? THEN DO:
                     ASSIGN n_res = n_res + clm131.res
                            n_intref = clm120.intref
                            /*---A63-0417---*/
                            n_res_nvat = n_res_nvat + clm131.dec1
                            n_res_vat  = n_res_vat + clm131.dec2.
                            /*---end A63-0417---*/
                  END.
              
              n_paid = 0.

              Loop_130:
              FOR EACH clm130 USE-INDEX clm13002      WHERE
                       clm130.claim   = clm100.claim  AND
                       clm130.clmant  = clm120.clmant AND
                       clm130.clitem  = clm120.clitem AND
                       clm130.cpc_cd  = 'EPD'         AND 
                       clm130.trnty1  = "X"           AND 
                       clm130.netl_d  <> ?            AND 
                       clm130.entdat  >= n_frdate     AND 
                       clm130.entdat  <= n_todate     NO-LOCK,

                  FIRST clm200 USE-INDEX clm20001     WHERE
                        clm200.trnty1 = clm130.trnty1 AND
                        clm200.docno  = clm130.docno  AND
                        clm200.releas = YES           NO-LOCK:

                  IF AVAIL Clm200 THEN
                    IF Clm200.releas <>  YES THEN NEXT loop_130.

                  IF clm130.netl_d <> ? THEN DO:
                     ASSIGN n_paid = n_paid + clm130.netl_d.
                            
                     IF clm130.trndat <> ? THEN n_paiddat = clm130.trndat.
                  END.
              END. /* FOR EACH clm130 */

              END. /* END clm131 */
                 
             IF n_res > 0 AND n_res > n_paid THEN
              ASSIGN n_os = n_res - n_paid
                     /*---A63-0417---*/
                     n_os_vat  = n_res_vat  - n_paidamt_vat
                     n_os_nvat = n_res_nvat - n_paidamt_nvat.
                     /*--end A63-0417-----------*/

              IF n_os < 0 THEN ASSIGN n_os = 0 
                               n_os_nvat = 0
                               n_os_vat = 0.

              IF SUBSTR(clm100.claim,1,1) = "I" THEN n_intref = clm100.agent.

              FIND LAST uwm100 USE-INDEX uwm10001     WHERE
                        uwm100.policy = clm100.policy NO-LOCK NO-ERROR NO-WAIT.
              IF AVAIL  uwm100 THEN DO:
                 IF uwm100.coins = Yes THEN DO:
                    n_coper = 100 - uwm100.co_per.

                    FOR EACH uwm120 USE-INDEX uwm12001     WHERE
                             uwm120.policy = uwm100.policy AND
                             uwm120.rencnt = uwm100.rencnt AND
                             uwm120.endcnt = uwm100.endcnt NO-LOCK:
                             ASSIGN n_sico = n_sico + uwm120.sico
                                    n_sigr = n_sigr + uwm120.sigr.
                    END. /*uwm120*/
                    n_sico = n_sigr - n_sico.
                 END. /*If UWM100.COINS = Yes*/
              END. /*If Avail uwm100 (Find Last) */

              /*--- find Vehicle Reg. No. ---*/
              IF SUBSTR(clm100.poltyp,2,1) = "7" THEN DO:
                 FIND FIRST UWM301 USE-INDEX UWM30101 WHERE
                            UWM301.POLICY = CLM100.POLICY AND
                            UWM301.RENCNT = CLM100.RENCNT AND
                            UWM301.ENDCNT = CLM100.ENDCNT AND 
                            UWM301.RISKNO = CLM100.RISKNO AND 
                            UWM301.ITEMNO = CLM100.ITEMNO NO-LOCK NO-ERROR NO-WAIT.
                 IF AVAIL UWM301 THEN n_vehreg = UWM301.VEHREG.
              END.
              ELSE ASSIGN n_vehreg = "".
              /*-----------------------------*/ 

              FIND FIRST czd101 USE-INDEX czd10101 WHERE
                         czd101.asdat = n_asdat AND
                         czd101.claim = clm100.claim AND
                         czd101.clmant = clm120.clmant AND 
                         czd101.clitem = clm120.clitem NO-ERROR.
              IF NOT AVAIL czd101 THEN DO:
                 CREATE czd101.
                 ASSIGN czd101.asdat = n_asdat
                        czd101.claim = clm100.claim
                        czd101.clmant = clm120.clmant
                        czd101.clitem = clm120.clitem
                        czd101.paidamt = n_paid
                        czd101.paiddat = n_paiddat
                        czd101.osres  =  n_os.
                   
              FIND FIRST czm100 USE-INDEX czm10001 WHERE 
                         czm100.asdat = n_asdat AND
                         czm100.claim = clm100.claim NO-ERROR.
              IF NOT AVAIL czm100 THEN DO: 
                 CREATE czm100.
              END.

              nv_br = "".
              IF SUBSTR(clm100.policy,1,2) >= "10" AND      
                 SUBSTR(clm100.policy,1,2) <= "99" THEN 
                   nv_br = SUBSTR(clm100.policy,1,2). /*Policy Branch 2 หลัก*/
              ELSE IF SUBSTR(clm100.policy,1,2) = "G" OR  
                      SUBSTR(clm100.policy,1,2) = "M" THEN nv_br = SUBSTR(clm100.policy,1,2). 
              ELSE     nv_br = SUBSTR(clm100.policy,2,1). /*Policy Branch 1 หลัก*/
            
              ASSIGN czm100.ASDAT   =  n_asdat
                     czm100.POLTYP  =  CLM100.POLTYP
                     czm100.GRPTYP  =  n_group
                     /*czm100.BRANCH  =  SUBSTR(CLM100.POLICY,2,1) A51-0178---*/
                     czm100.BRANCH  =  nv_br
                     czm100.CLAIM   =  CLM100.CLAIM
                     czm100.ENTDAT  =  CLM102.ENTDAT
                     czm100.NOTDAT  =  CLM100.NOTDAT
                     czm100.POLICY  =  CLM100.POLICY
                     czm100.RENCNT  =  CLM100.RENCNT
                     czm100.ENDCNT  =  CLM100.ENDCNT
                     czm100.RISKNO  =  CLM100.RISKNO
                     czm100.ITEMNO  =  CLM100.ITEMNO
                     czm100.VEHREG  =  n_vehreg
                     czm100.LOSS    =  n_loss
                     czm100.LOSDAT  =  CLM100.LOSDAT
                     czm100.OS      =  czm100.os + czd101.osres
                     /*---A63-0417---*/
                     czm100.os_vat     = czm100.os_vat  + czd101.osres_vat
                     czm100.os_netvat  = czm100.os_netvat  + czd101.osres_netvat
                     czm100.amt_vat    = czm100.amt_vat  + czd101.paidamt_vat
                     czm100.amt_netvat = czm100.amt_netvat + czd101.paidamt_netvat
                     /*------End A63-0417 -----*/
                     .



                 /*--- Reinsurance ---*/
                 RUN pdProcess_RI.
                 /*--- End Reinsurance ---*/
             
                 n_net =   (czm100.os - n_facri - n_1st - n_2nd   - n_qs5
                                      - n_tfp   - n_eng - n_mar   - n_rq
                                      - n_fo1   - n_fo2 - n_fo3   - n_fo4   
                                      - n_ftr   - n_mps - n_btr   - n_otr).

                 n_net_nvat =   (czm100.os_netvat - n_facri_nvat - n_1st_nvat - n_2nd_nvat   - n_qs5_nvat
                                      - n_tfp_nvat  - n_eng_nvat - n_mar_nvat   - n_rq_nvat
                                      - n_fo1_nvat  - n_fo2_nvat - n_fo3_nvat   - n_fo4_nvat   
                                      - n_ftr_nvat  - n_mps_nvat - n_btr_nvat   - n_otr_nvat).
             
                 IF n_net > 5000000 THEN 
                    ASSIGN n_xol = n_net - 5000000
                           n_net = 5000000.

                 IF n_net_nvat > 5000000 THEN 
                    ASSIGN n_xol_nvat = n_net_nvat - 5000000
                           n_net_nvat = 5000000.

                 ASSIGN czm100.AMT[1]  =  n_1st
                        czm100.AMT[2]  =  n_2nd
                        czm100.AMT[3]  =  n_facri
                        czm100.AMT[4]  =  n_qs5
                        czm100.AMT[5]  =  n_tfp  
                        czm100.AMT[6]  =  n_mps
                        czm100.AMT[7]  =  n_eng
                        czm100.AMT[8]  =  n_mar
                        czm100.AMT[9]  =  n_rq
                        czm100.AMT[10] =  n_btr
                        czm100.AMT[11] =  n_otr
                        czm100.AMT[12] =  n_ftr
                        czm100.AMT[13] =  n_fo1
                        czm100.AMT[14] =  n_fo2
                        czm100.AMT[15] =  n_fo3
                        czm100.AMT[16] =  n_fo4
                        czm100.AMT[17] =  n_net
                        czm100.AMT[18] =  n_xol
                        czm100.intref  =  n_intref
                        czm100.COPER   =  n_coper
                        czm100.SICO    =  n_sico
                        czm100.USRID   =  n_usrid
                        czm100.DOCST   =  IF clm120.prdlos = 0 THEN "NO" ELSE "YES". 

             ASSIGN czm100.AMOUNT_NETVAT[1]  =  n_1st_nvat  
                    czm100.AMOUNT_NETVAT[2]  =  n_2nd_nvat  
                    czm100.AMOUNT_NETVAT[3]  =  n_facri_nvat
                    czm100.AMOUNT_NETVAT[4]  =  n_qs5_nvat  
                    czm100.AMOUNT_NETVAT[5]  =  n_tfp_nvat  
                    czm100.AMOUNT_NETVAT[6]  =  n_mps_nvat  
                    czm100.AMOUNT_NETVAT[7]  =  n_eng_nvat  
                    czm100.AMOUNT_NETVAT[8]  =  n_mar_nvat  
                    czm100.AMOUNT_NETVAT[9]  =  n_rq_nvat  
                    czm100.AMOUNT_NETVAT[10] =  n_btr_nvat  
                    czm100.AMOUNT_NETVAT[11] =  n_otr_nvat  
                    czm100.AMOUNT_NETVAT[12] =  n_ftr_nvat  
                    czm100.AMOUNT_NETVAT[13] =  n_fo1_nvat  
                    czm100.AMOUNT_NETVAT[14] =  n_fo2_nvat  
                    czm100.AMOUNT_NETVAT[15] =  n_fo3_nvat  
                    czm100.AMOUNT_NETVAT[16] =  n_fo4_nvat  
                    czm100.AMOUNT_NETVAT[17] =  n_net_nvat  
                    czm100.AMOUNT_NETVAT[18] =  n_xol_nvat.
                
             ASSIGN
                n_os    = 0    nt_os    = 0    n_res  = 0    n_paid = 0
                n_facri = 0    n_1st    = 0    n_2nd  = 0    n_qs5  = 0
                n_tfp   = 0    n_eng    = 0    n_mar  = 0    n_xol  = 0
                n_rq    = 0                           
                n_fo1   = 0    n_fo2    = 0    n_fo3  = 0    n_fo4  = 0
                n_ftr   = 0    n_mps    = 0    n_btr  = 0    n_otr  = 0 
                n_net   = 0    n_coper  = 0    n_sico = 0    n_sigr = 0
                n_intref = ""  n_docst  = "". 

             ASSIGN 
                n_os_nvat    = 0    nt_os_nvat    = 0    n_res_nvat  = 0    n_paid_nvat = 0
                n_facri_nvat = 0    n_1st_nvat    = 0    n_2nd_nvat  = 0    n_qs5_nvat  = 0
                n_tfp_nvat   = 0    n_eng_nvat    = 0    n_mar_nvat  = 0    n_xol_nvat  = 0
                n_rq_nvat   = 0                           
                n_fo1_nvat   = 0    n_fo2_nvat    = 0    n_fo3_nvat  = 0    n_fo4_nvat  = 0
                n_ftr_nvat   = 0    n_mps_nvat    = 0    n_btr_nvat  = 0    n_otr_nvat  = 0 
                n_net_nvat   = 0.
              
             END. /*czd100*/ 

           END. /*last-of clm120*/
           END.
        END. /*clm120.loss*/

        END. /*clm120*/  

    END. /*find first clm100*/

END. /*each clm102*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdprocess1 C-Win 
PROCEDURE pdprocess1 :
/*------------------------------------------------------------------------------
  Purpose: Process Data For Outstanding Claim    
  Parameters:  <none>
  Notes: เปลี่ยน loop pdprocess มาใช้ pdprocess1 แทน เพื่อเพิ่มข้อมูลค่า 
         servey fee , total gross Lukkana M. A53-0139 02/09/2010
------------------------------------------------------------------------------*/
RUN pdDel01.  /*"01" Delete agtprm_fil  &  Create acproc_fil "10"*/ 
ASSIGN n_os      = 0
       n_os1     = 0  
       n_fe      = 0  
       n_totos   = 0  
       n_resfe   = 0  
       n_paidfe  = 0 
       n_os_vat  = 0 
       n_os_nvat = 0
       n_res_vat = 0
       n_res_nvat = 0
       n_paidamt_vat  = 0
       n_paidamt_nvat = 0
       n_totos_nvat = 0.
       nv_flgfee = NO.
Loop_clm100:
FOR EACH clm102 USE-INDEX  clm10202 WHERE
         clm102.entdat >= n_frdate  AND
         clm102.entdat <= n_todate NO-LOCK:
    ASSIGN n_entdat = clm102.entdat.
    FIND FIRST clm100 USE-INDEX clm10001    WHERE
               clm100.claim = clm102.claim  NO-LOCK NO-ERROR.
    IF AVAIL clm100 THEN DO:
       ASSIGN poltyp   = clm100.poltyp
              n_notdat = clm100.notdat
              n_policy = clm100.policy
              n_rencnt = clm100.rencnt
              n_endcnt = clm100.endcnt
              n_riskno = clm100.riskno
              n_itemno = clm100.itemno
              n_losdat = clm100.losdat.
       /*------A63-0081----*/
       IF (SUBSTR(clm100.claim,1,1) <> "D"  AND SUBSTRING(clm100.claim,1,1) <> "I"  AND
           SUBSTR(clm100.claim,1,1) <> "G"  AND SUBSTRING(clm100.claim,1,1) <> "M") AND 
          (SUBSTR(clm100.claim,1,2) < "10"  AND SUBSTRING(clm100.claim,1,2) > "99") THEN NEXT loop_clm100.
       /*-------------------*/
       IF clm100.poltyp  = " " THEN NEXT loop_clm100.
       IF Clm100.padsts <> " "    AND  /* Check paid status is close or open */
          Clm100.padsts <> "O"    AND
          Clm100.padsts <> "P"    THEN NEXT loop_clm100.
       ASSIGN n_os1     = 0 
              n_fe      = 0 
              n_totos   = 0 
              n_resfe   = 0 
              n_paidfe  = 0 
              n_resfe2   = 0  
              n_paidfe2  = 0  
              n_totos_nvat = 0.   /*A63-0417*/
        FIND FIRST S0M005 USE-INDEX S0M00501   WHERE /*--- Group Type ---*/
                   S0M005.key2 = CLM100.POLTYP NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL s0m005 THEN n_group = s0m005.key1.
        Loop_clm120:
        FOR EACH clm120 USE-INDEX clm12001     WHERE
                 clm120.claim  = clm100.claim  NO-LOCK
        BREAK BY clm120.claim BY clm120.clmant BY clm120.clitem:

            DISP "..กำลัง Process ข้อมูลอยู่.." SKIP
                  clm120.claim WITH NO-LABEL TITLE "Process O/S Claim Monthly" FRAME a
            VIEW-AS DIALOG-BOX.

            IF SUBSTR(clm120.claim,3,1) = "7" THEN n_loss = clm120.loss.
            ELSE DO:
               IF FIRST-OF (CLM120.CLMANT) THEN DO:     /*--- หาค่า Nature  ของ Claim แต่ละ Clmant  ซึ่งจะนำไปใช้ในการออก Report  คอลัมน์ Nature of Loss ---*/
                  ASSIGN n_res_vat = 0
                         n_res_nvat = 0.
                     /*--- Create ลง Workfile เพื่อเก็บ Nature ของแต่ละ Clmant กรณีที่ Claim 1 Claim มีหลาย Clmant ---*/
                     FIND FIRST    WCLM120    WHERE    WCLM120.WCLAIM   =   CLM120.CLAIM  NO-ERROR.                                                               
                     IF NOT AVAILABLE WCLM120 THEN DO:
                        CREATE  WCLM120.
                        ASSIGN  WCLM120.WCLAIM = CLM120.CLAIM
                                WCLM120.WLOSS  = " ".
                     END.
                     IF WCLM120.WLOSS =  " " THEN DO:
                        IF CLM120.LOSS <> " " THEN WCLM120.WLOSS = CAPS(CLM120.LOSS).
                     END.
                     ELSE DO:
                        IF CLM120.LOSS <> " " THEN WCLM120.WLOSS = TRIM(WCLM120.WLOSS) + "," + CAPS(CLM120.LOSS). 
                     END.
                     /*--- ตัวอย่างเช่น Nature of Loss ของ Claim ที่ได้ --->   "DH, DA"  กรณีที่ Claim 1 Claim มีหลาย Clmant ---*/ 
                  /*END. /* "FE" & "EX" */ Lukkana M. A53-0139 01/09/2010*/
               END. /* first-of clm120.clmant */    
               n_loss = WCLM120.WLOSS.
            END. 
            RUN pd_flgfee.
            IF nv_flgfee <> YES /*(Clm120.loss <> 'FE' AND Clm120.loss <> 'EX')*/ THEN DO:
               IF (Clm120.styp20 <> 'X' AND    /* X : Claim Without Paid */
                   Clm120.styp20 <> 'F' AND    /* F : Final (complete paid) */
                   Clm120.styp20 <> 'R') THEN DO:      /* R : Re-open */
                   IF LAST-OF(clm120.clitem) THEN DO:
                      FOR EACH clm131 USE-INDEX clm13101       WHERE
                               clm131.claim   = clm100.claim   AND
                               clm131.clmant  = clm120.clmant  AND
                               clm131.clitem  = clm120.clitem  AND
                               clm131.cpc_cd  = "EPD"          AND 
                               clm131.trndat  >= n_frdate      AND 
                               clm131.trndat  <= n_todate      NO-LOCK:
                          IF clm131.res <> ? THEN DO:
                             ASSIGN n_res = n_res + clm131.res
                                    n_intref = clm120.intref.
                                    IF clm131.dec1 = 0 THEN ASSIGN n_res_nvat = n_res_nvat + clm131.res
                                                                   n_res_vat  = 0.
                                    ELSE ASSIGN n_res_nvat = n_res_nvat + clm131.dec1
                                                n_res_vat  = n_res_vat  + clm131.dec2.
                          END.
                          n_paid = 0.
                          Loop_130:
                          FOR EACH clm130 USE-INDEX clm13002      WHERE
                                   clm130.claim   = clm100.claim  AND
                                   clm130.clmant  = clm120.clmant AND
                                   clm130.clitem  = clm120.clitem AND
                                   clm130.cpc_cd  = 'EPD'         AND 
                                   clm130.trnty1  = "X"           AND 
                                   clm130.netl_d  <> ?            AND 
                                   clm130.entdat  >= n_frdate     AND 
                                   clm130.entdat  <= n_todate     NO-LOCK,
                              FIRST clm200 USE-INDEX clm20001     WHERE
                                    clm200.trnty1 = clm130.trnty1 AND
                                    clm200.docno  = clm130.docno  AND
                                    clm200.releas = YES           NO-LOCK:
                              IF AVAIL Clm200 THEN IF Clm200.releas <>  YES THEN NEXT loop_130.
                              IF clm130.netl_d <> ? THEN DO:
                                 ASSIGN n_paid = n_paid + clm130.netl_d.
                                 IF clm130.dec1 = 0 THEN ASSIGN n_paidamt_nvat = n_paidamt_nvat + clm130.netl_d
                                                                n_paidamt_vat  = 0. 
                                 ELSE ASSIGN n_paidamt_nvat = n_paidamt_nvat + clm130.dec1
                                             n_paidamt_vat  = n_paidamt_vat + clm130.dec2.
                                 IF clm130.trndat <> ? THEN n_paiddat = clm130.trndat.
                              END.
                          END. /* FOR EACH clm130 */
                          /*Add A63-0417*/
                          ASSIGN nv_rescod = ""
                                 nv_descod = ""
                                 nv_resref = ""
                                 nv_desref = "" 
                                 nv_rescod = Caps(Trim(clm131.rescod))
                                 nv_resref = Caps(Trim(clm131.resref)).
                              IF nv_rescod <> "" THEN DO:
                                  FIND FIRST sym100 USE-INDEX sym10001 WHERE sym100.tabcod = "CMTY" AND   
                                                                             sym100.itmcod = nv_rescod  NO-LOCK NO-ERROR. /* LB / SP / XH */
                                  IF AVAIL sym100 THEN nv_descod = sym100.itmdes.
                              END.
                              FIND FIRST xmm600 USE-INDEX xmm60001  WHERE xmm600.acno = nv_resref NO-LOCK NO-ERROR NO-WAIT.
                              IF AVAIL xmm600 THEN nv_desref = TRIM(xmm600.name).
                              ELSE nv_desref = " ".  
                          /*End A63-0417*/ 

                      END. /* END clm131 */
                   END. /*last-of clm120*/
               END.
            END. /*clm120.loss*/
            ELSE DO:   /* nv_flgfee = Yes */
               IF (Clm120.styp20 <> 'X' AND    /* X : Claim Without Paid */
                   Clm120.styp20 <> 'F' AND    /* F : Final (complete paid) */
                   Clm120.styp20 <> 'R') THEN DO:      /* R : Re-open */
               /*IF LAST-OF(clm120.clitem) THEN DO:*/
                  FOR EACH clm131 USE-INDEX clm13101       WHERE
                           clm131.claim   = clm100.claim   AND
                           clm131.clmant  = clm120.clmant  AND
                           clm131.clitem  = clm120.clitem  AND
                           clm131.cpc_cd  = "EPD"          AND 
                           clm131.trndat  >= n_frdate      AND 
                           clm131.trndat  <= n_todate      NO-LOCK:
                      IF clm131.res <> ? THEN DO:              
                         ASSIGN n_resfe = n_resfe + clm131.res.
                                n_intref = clm120.intref.
                      END.
                  END. /* END clm131 */
                  /*ADD by kridtiya i. A57-0343.....*/
                  Loop_130:
                  FOR EACH clm130 USE-INDEX clm13002      WHERE
                           clm130.claim   = clm100.claim  AND
                           clm130.clmant  = clm120.clmant AND
                           clm130.clitem  = clm120.clitem AND
                           clm130.cpc_cd  = 'EPD'         AND 
                           clm130.trnty1  = "X"           AND 
                           clm130.netl_d  <> ?            AND 
                           clm130.entdat  >= n_frdate     AND 
                           clm130.entdat  <= n_todate     NO-LOCK,
                      FIRST clm200 USE-INDEX clm20001     WHERE
                      clm200.trnty1 = clm130.trnty1 AND
                      clm200.docno  = clm130.docno  AND
                      clm200.releas = YES           NO-LOCK:
                      IF AVAIL Clm200 THEN
                          IF Clm200.releas <>  YES THEN NEXT loop_130.
                      IF clm130.netl_d <> ? THEN DO:
                          ASSIGN n_paidfe = n_paidfe + clm130.netl_d.
                          IF clm130.trndat <> ? THEN n_paiddat = clm130.trndat.
                      END.
                  END. /* FOR EACH clm130 */
                   IF n_resfe > 0 AND n_resfe < n_paidfe THEN  /*kridtiya i.*/
                       ASSIGN n_resfe  = 0       /*kridtiya i.*/
                              n_paidfe = 0 .     /*kridtiya i.*/
                   ELSE ASSIGN n_resfe2  = n_resfe2  + n_resfe         /*kridtiya i.*/
                               n_paidfe2 = n_paidfe2 + n_paidfe      /*kridtiya i.*/
                               n_resfe  = 0       /*kridtiya i.*/
                               n_paidfe = 0 .     /*kridtiya i.*/
                  /*ADD by kridtiya i. A57-0343.....*/
               END.
            END.
            IF n_res > 0 AND n_res > n_paid THEN ASSIGN n_os  = n_res - n_paid.
            ELSE ASSIGN n_os = 0.
            n_os_nvat = n_os - n_os_vat. 
            n_os1 = n_os1 + n_os.       
            IF n_resfe2 > 0 AND n_resfe2 > n_paidfe2 THEN ASSIGN n_fe = n_resfe2 - n_paidfe2.  
            n_totos = n_os1 + n_fe.    
            IF n_os < 0 THEN n_os = 0.
            IF n_fe < 0 THEN n_fe = 0. 
            IF SUBSTR(clm100.claim,1,1) = "I" THEN n_intref = clm100.agent.
            RUN pduwm100.
            /*--- find Vehicle Reg. No. ---*/
            IF SUBSTR(clm100.poltyp,2,1) = "7" THEN DO:
               FIND FIRST UWM301 USE-INDEX UWM30101 WHERE
                          UWM301.POLICY = CLM100.POLICY AND
                          UWM301.RENCNT = CLM100.RENCNT AND
                          UWM301.ENDCNT = CLM100.ENDCNT AND 
                          UWM301.RISKNO = CLM100.RISKNO AND 
                          UWM301.ITEMNO = CLM100.ITEMNO NO-LOCK NO-ERROR NO-WAIT.
               IF AVAIL UWM301 THEN n_vehreg = UWM301.VEHREG.
            END.
            ELSE ASSIGN n_vehreg = "".
            /*-----------------------------*/ 
            FIND FIRST czd101 USE-INDEX czd10101 WHERE
                       czd101.asdat  = n_asdat AND
                       czd101.claim  = clm100.claim  AND
                       czd101.clmant = clm120.clmant AND 
                       czd101.clitem = clm120.clitem NO-ERROR.
            IF NOT AVAIL czd101 THEN DO:
               CREATE czd101.
               ASSIGN czd101.asdat   = n_asdat
                      czd101.claim   = clm100.claim
                      czd101.clmant  = clm120.clmant
                      czd101.clitem  = clm120.clitem
                      czd101.paidamt = n_paid
                      czd101.paiddat = n_paiddat
                      czd101.paidamt_vat    = n_paidamt_vat
                      czd101.paidamt_netvat = n_paidamt_nvat
                      czd101.rescod         = nv_rescod
                      czd101.repref         = nv_resref
                      /* A68-0026 */
                      czd101.loss           = clm120.loss. 
               IF nv_flgfee = YES THEN DO: 
                  ASSIGN nv_resref = ""
                         nv_rescod = "".
                  FIND LAST clm131 NO-LOCK WHERE clm131.claim    = clm100.claim 
                                             AND clm131.clmant   = clm120.clmant
                                             AND clm131.clitem   = clm120.clitem
                                             AND clm131.cpc_cd   = "EPD"
                                             AND clm131.trndat   <= n_asdat NO-ERROR.
                  IF AVAIL clm131 THEN DO:
                     ASSIGN nv_rescod = Caps(Trim(clm131.rescod))
                            nv_resref = Caps(Trim(clm131.resref)).
                  END.

                  RUN pd_osfee.   
                  /*---- A68-0026 ----*/
               END.
               ELSE DO: 
                   czd101.osres  =  n_os .
                   IF nv_resref = ""  THEN DO: 
                      ASSIGN czd101.osres_vat      = 0
                             czd101.osres_netvat   = n_os.
                   END.
                   ELSE DO:
                       FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_resref NO-LOCK NO-ERROR.
                       IF NOT AVAIL xmm600 THEN DO:
                          ASSIGN czd101.osres_vat      = 0
                                 czd101.osres_netvat   = n_os.
                       END.
                       ELSE DO:
                          FIND FIRST arm012 WHERE arm012.TYPE = "VR" 
                                              AND arm012.prjcod = xmm600.clicod NO-LOCK NO-ERROR.
                          IF NOT AVAIL arm012 THEN DO:
                             ASSIGN czd101.osres_vat   = 0
                                    czd101.osres_netvat   = n_os.
                          END.
                          ELSE DO:
                              IF DEC(arm012.text1) = 0 THEN DO:
                                 ASSIGN czd101.osres_vat      = 0
                                        czd101.osres_netvat   = n_os.
                              END.
                              ELSE DO:
                                 ASSIGN czd101.osres_vat  = (n_os * DEC(arm012.text1)) / (100 + DEC(arm012.text1))
                                        czd101.osres_netvat = n_os - ((n_os * DEC(arm012.text1)) / (100 + DEC(arm012.text1))).
                              END.
                          END.
                       END.
                   END. 
                   n_os_nvat = czd101.osres_netvat.
                   n_os_vat  = czd101.osres_vat.
                   n_os1_nvat = n_os1_nvat + n_os_nvat.
               END.
               FIND FIRST czm100 USE-INDEX czm10001 WHERE 
                          czm100.asdat = n_asdat AND
                          czm100.claim = clm100.claim NO-ERROR.
               IF NOT AVAIL czm100 THEN DO: 
                  CREATE czm100.
               END.
               /*--------- Add chutikarn A50-0178 ---------*/
               nv_br = "".
               IF SUBSTR(clm100.policy,1,2) >= "10" AND      
                  SUBSTR(clm100.policy,1,2) <= "99" THEN 
                    nv_br = SUBSTR(clm100.policy,1,2). /*Policy Branch 2 หลัก*/
               ELSE IF SUBSTR(clm100.policy,1,1) = "I" THEN DO:
                   IF      SUBSTR(clm100.policy,1,2) = "I1" THEN nv_br = "91" .
                   ELSE IF SUBSTR(clm100.policy,1,2) = "I2" THEN nv_br = "92" .
                   ELSE IF SUBSTR(clm100.policy,1,2) = "I3" THEN nv_br = "93" .
                   ELSE IF SUBSTR(clm100.policy,1,2) = "I4" THEN nv_br = "94" .
                   ELSE IF SUBSTR(clm100.policy,1,2) = "I5" THEN nv_br = "95" .
                   ELSE IF SUBSTR(clm100.policy,1,2) = "I6" THEN nv_br = "96" .
                   ELSE IF SUBSTR(clm100.policy,1,2) = "I7" THEN nv_br = "97" .
                   ELSE IF SUBSTR(clm100.policy,1,2) = "I8" THEN nv_br = "98" .
                   ELSE  nv_br = SUBSTR(clm100.policy,2,1).   /*Policy Branch 1 หลัก*/ 
               END.
               ELSE IF SUBSTR(clm100.policy,1,1) = "G" OR SUBSTR(clm100.policy,1,1) = "M" THEN 
                    nv_br = SUBSTR(clm100.policy,1,2). /*Policy Branch 2 หลัก*/
               ELSE nv_br = SUBSTR(clm100.policy,2,1). /*Policy Branch 1 หลัก*/ /*Kridtiya i. */
               /*--------- End chutikarn A50-0178 ---------*/
               RUN pdczm100.
               RUN pdreinsur.
               n_net =   (czm100.os - n_facri - n_1st - n_2nd   - n_qs5
                                    - n_tfp   - n_eng - n_mar   - n_rq
                                    - n_fo1   - n_fo2 - n_fo3   - n_fo4   
                                    - n_ftr   - n_mps - n_btr   - n_otr).
                n_net_nvat =   (czm100.os_netvat - n_facri_nvat - n_1st_nvat - n_2nd_nvat   - n_qs5_nvat
                                    - n_tfp_nvat  - n_eng_nvat - n_mar_nvat   - n_rq_nvat
                                    - n_fo1_nvat  - n_fo2_nvat - n_fo3_nvat   - n_fo4_nvat   
                                    - n_ftr_nvat  - n_mps_nvat - n_btr_nvat   - n_otr_nvat).
               IF n_net > 5000000 THEN 
                  ASSIGN n_xol = n_net - 5000000
                         n_net = 5000000.
               IF n_net_nvat > 5000000 THEN 
                  ASSIGN n_xol_nvat = n_net_nvat - 5000000
                         n_net_nvat = 5000000.
               RUN pdczm100_1.
               RUN pdclear.
            END. /*czd100*/ 
            RUN pdclear. /*kridtiya i. A57-0343. */
        END. /*clm120*/
    END. /*find first clm100*/
END. /*each clm102*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcessYes C-Win 
PROCEDURE pdProcessYes :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST  acProc_fil  USE-INDEX by_type_asdat  WHERE
           acProc_fil.asdat = n_asdat  AND
           acProc_fil.type  = nv_type  NO-ERROR.
    
IF AVAIL acProc_fil THEN 
   ASSIGN SUBSTR(acProc_fil.enttim,10,3)  = "YES".
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdProcess_RI C-Win 
PROCEDURE pdProcess_RI :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    /*--- End Reinsurance ---*/
    FOR EACH CLM300 USE-INDEX CLM30001 WHERE
                          CLM300.CLAIM = CLM100.CLAIM NO-LOCK:
                          
                     IF CLM300.CSFTQ = "F" THEN
                        ASSIGN n_facri      = n_facri + (CLM300.RISI_p * czm100.os) / 100
                               n_facri_nvat = n_facri_nvat + (CLM300.RISI_p * czm100.os_netvat) / 100.
                   
                     IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                        SUBSTR(CLM300.RICO,6,2) = "01" THEN
                        ASSIGN n_1st = (CLM300.RISI_P * czm100.os) / 100
                               n_1st_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
                             SUBSTR(CLM300.RICO,6,2) = "02" AND
                             NOT (CLM100.POLTYP = "M80"  OR CLM100.POLTYP = "M81" OR
                                  CLM100.POLTYP = "M82"  OR CLM100.POLTYP = "M83" OR
                                  CLM100.POLTYP = "M84"  OR CLM100.POLTYP = "M85" OR
                                  CLM100.POLTYP = "C90") THEN
                          ASSIGN n_2nd = (CLM300.RISI_P * czm100.os) / 100
                                 n_2nd_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,4) = "STAT" THEN 
                             ASSIGN n_qs5 = (CLM300.RISI_P * czm100.os) / 100
                                    n_qs5_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,3)  = "0QA" THEN 
                             ASSIGN n_tfp = (CLM300.RISI_P * czm100.os) / 100
                                    n_tfp_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                             SUBSTR(CLM300.RICO,6,2) = "02" AND
                            (CLM100.POLTYP = "M80"  OR CLM100.POLTYP = "M81" OR
                             CLM100.POLTYP = "M82"  OR CLM100.POLTYP = "M83" OR
                             CLM100.POLTYP = "M84"  OR CLM100.POLTYP = "M85") THEN
                             ASSIGN n_eng = (CLM300.RISI_P * czm100.os) / 100
                                    n_eng_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
                             SUBSTR(CLM300.RICO,6,2) = "02" AND
                             CLM100.poltyp = "C90"  THEN
                             ASSIGN n_mar = (CLM300.RISI_P * czm100.os) / 100
                                    n_mar_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,3) = "0RQ" THEN 
                          ASSIGN n_rq = (CLM300.RISI_p * czm100.os) / 100
                                 n_rq_nvat = (CLM300.RISI_p * czm100.os_netvat) / 100.
                   
                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                             SUBSTR(CLM300.RICO,6,2) = "F1" THEN 
                             ASSIGN n_fo1 = (CLM300.RISI_P * czm100.os) / 100
                                    n_fo1_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                             SUBSTR(CLM300.RICO,6,2) = "F2" THEN 
                             ASSIGN n_fo2 = (CLM300.RISI_P * czm100.os) / 100
                                    n_fo2_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                             SUBSTR(CLM300.RICO,6,2) = "F3" THEN DO:
                          IF LOOKUP (CLM100.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0 THEN
                              /*--- บวกเพิ่มเข้าใน Engineer ---*/
                              ASSIGN n_eng = n_eng + (CLM300.RISI_P * czm100.os) / 100
                                     n_eng_nvat = n_eng_nvat + (CLM300.RISI_P * czm100.os_netvat) / 100.
                          ELSE
                              /*--- FO3 ไม่รวม Engineer ---*/
                              ASSIGN n_fo3 = (CLM300.RISI_P * czm100.os) / 100
                                     n_fo3_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.
                      END.
                    
                     /* FO4 */
                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
                             SUBSTR(CLM300.RICO,6,2) = "F4" THEN 
                             ASSIGN n_fo4 = (CLM300.RISI_P * czm100.os) / 100
                                    n_fo4_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.
                     /* FTR */     
                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                             SUBSTR(CLM300.RICO,6,2) = "FT" THEN 
                             ASSIGN n_ftr = (CLM300.RISI_P * czm100.os) / 100
                                    n_ftr_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.
                     /*------------------------------------------------------------------*/
                   
                     ELSE IF SUBSTR(CLM300.RICO,1,3) = "0PS" AND
                             SUBSTR(CLM300.RICO,6,2) = "01"  THEN 
                             ASSIGN n_mps = (CLM300.RISI_P * czm100.os) / 100
                                    n_mps_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                             SUBSTR(CLM300.RICO,6,2) = "FB" THEN 
                             ASSIGN n_btr = (CLM300.RISI_P * czm100.os) / 100
                                    n_btr_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

                     ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
                             SUBSTR(CLM300.RICO,6,2) = "FO" THEN 
                             ASSIGN n_otr = (CLM300.RISI_P * czm100.os) / 100
                                    n_otr_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.
                 END.  /*--- FOR EACH Clm300 ---*/
                   
                 /*--- End Reinsurance ---*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdReinsur C-Win 
PROCEDURE pdReinsur :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:    /*--- Reinsurance ---*/   
------------------------------------------------------------------------------*/

FOR EACH CLM300 USE-INDEX CLM30001 WHERE
         CLM300.CLAIM = CLM100.CLAIM NO-LOCK:
       
  IF CLM300.CSFTQ = "F" THEN ASSIGN n_facri      = n_facri + (CLM300.RISI_p * czm100.os) / 100
                                    n_facri_nvat = n_facri_nvat + (CLM300.RISI_p * czm100.os_netvat) / 100.

  IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
     SUBSTR(CLM300.RICO,6,2) = "01" THEN
     ASSIGN n_1st      = (CLM300.RISI_P * czm100.os) / 100
            n_1st_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
          SUBSTR(CLM300.RICO,6,2) = "02" AND
          NOT (CLM100.POLTYP = "M80"  OR CLM100.POLTYP = "M81" OR
               CLM100.POLTYP = "M82"  OR CLM100.POLTYP = "M83" OR
               CLM100.POLTYP = "M84"  OR CLM100.POLTYP = "M85" OR
               CLM100.POLTYP = "C90") THEN ASSIGN n_2nd      = (CLM300.RISI_P * czm100.os) / 100
                                                  n_2nd_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,4) = "STAT" THEN 
          ASSIGN n_qs5      = (CLM300.RISI_P * czm100.os) / 100
                 n_qs5_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,3)  = "0QA" THEN 
          ASSIGN n_tfp      = (CLM300.RISI_P * czm100.os) / 100
                 n_tfp_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
          SUBSTR(CLM300.RICO,6,2) = "02" AND
         (CLM100.POLTYP = "M80"  OR CLM100.POLTYP = "M81" OR
          CLM100.POLTYP = "M82"  OR CLM100.POLTYP = "M83" OR
          CLM100.POLTYP = "M84"  OR CLM100.POLTYP = "M85") THEN
          ASSIGN n_eng      = (CLM300.RISI_P * czm100.os) / 100
                 n_eng_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
          SUBSTR(CLM300.RICO,6,2) = "02" AND
          CLM100.poltyp = "C90"  THEN
          ASSIGN n_mar      = (CLM300.RISI_P * czm100.os) / 100
                 n_mar_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,3) = "0RQ" THEN 
       ASSIGN n_rq      = (CLM300.RISI_p * czm100.os) / 100
              n_rq_nvat = (CLM300.RISI_p * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
          SUBSTR(CLM300.RICO,6,2) = "F1" THEN 
          ASSIGN n_fo1      = (CLM300.RISI_P * czm100.os) / 100
                 n_fo1_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
          SUBSTR(CLM300.RICO,6,2) = "F2" THEN 
          ASSIGN n_fo2      = (CLM300.RISI_P * czm100.os) / 100
                 n_fo2_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
          SUBSTR(CLM300.RICO,6,2) = "F3" THEN DO:
       IF LOOKUP (CLM100.POLTYP,"M80,M81,M82,M83,M84,M85") <> 0 THEN
           /*--- บวกเพิ่มเข้าใน Engineer ---*/
           ASSIGN n_eng      = n_eng + (CLM300.RISI_P * czm100.os) / 100
                  n_eng_nvat = n_eng_nvat + (CLM300.RISI_P * czm100.os_netvat) / 100.
       /*--- FO3 ไม่รวม Engineer ---*/
       ELSE ASSIGN n_fo3 = (CLM300.RISI_P * czm100.os) / 100
                   n_fo3_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.
   END.
 
  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND 
          SUBSTR(CLM300.RICO,6,2) = "F4" THEN 
          ASSIGN n_fo4      = (CLM300.RISI_P * czm100.os) / 100
                 n_fo4_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.
  /* FTR */     
  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
          SUBSTR(CLM300.RICO,6,2) = "FT" THEN 
          ASSIGN n_ftr      = (CLM300.RISI_P * czm100.os) / 100
                 n_ftr_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,3) = "0PS" AND
          SUBSTR(CLM300.RICO,6,2) = "01"  THEN 
          ASSIGN n_mps      = (CLM300.RISI_P * czm100.os) / 100
                 n_mps_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
          SUBSTR(CLM300.RICO,6,2) = "FB" THEN 
          ASSIGN n_btr      = (CLM300.RISI_P * czm100.os) / 100
                 n_btr_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.

  ELSE IF SUBSTR(CLM300.RICO,1,2) = "0T" AND
          SUBSTR(CLM300.RICO,6,2) = "FO" THEN 
          ASSIGN n_otr      = (CLM300.RISI_P * czm100.os) / 100
                 n_otr_nvat = (CLM300.RISI_P * czm100.os_netvat) / 100.
END.  /*--- FOR EACH Clm300 ---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pduwm100 C-Win 
PROCEDURE pduwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST uwm100 USE-INDEX uwm10001     WHERE
          uwm100.policy = clm100.policy NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  uwm100 THEN DO:
  IF uwm100.coins = Yes THEN DO:
    n_coper = 100 - uwm100.co_per.

    FOR EACH uwm120 USE-INDEX uwm12001     WHERE
             uwm120.policy = uwm100.policy AND
             uwm120.rencnt = uwm100.rencnt AND
             uwm120.endcnt = uwm100.endcnt NO-LOCK:
             ASSIGN n_sico = n_sico + uwm120.sico
                    n_sigr = n_sigr + uwm120.sigr.
    END. /*uwm120*/
    n_sico = n_sigr - n_sico.
  END. /*If UWM100.COINS = Yes*/
END. /*If Avail uwm100 (Find Last) */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_flgfee C-Win 
PROCEDURE pd_flgfee :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       -----A68-0026----
------------------------------------------------------------------------------*/
FIND FIRST sym100 USE-INDEX sym10001 WHERE
           sym100.tabcod = "CMLO"         AND
           sym100.itmcod = clm120.loss NO-LOCK NO-ERROR.  /*Nature FE EX FV*/
IF AVAIL sym100 THEN  nv_flgfee = YES.
ELSE nv_flgfee = NO.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_osfee C-Win 
PROCEDURE pd_osfee :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:      ------A68-0026---------  
------------------------------------------------------------------------------*/
czd101.osres = n_fe.
IF nv_resref = ""  THEN DO: 
  ASSIGN czd101.osres_vat      = 0
         czd101.osres_netvat   = n_fe.
END.
ELSE DO:
   FIND FIRST xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = nv_resref NO-LOCK NO-ERROR.
   IF NOT AVAIL xmm600 THEN DO:
      ASSIGN czd101.osres_vat      = 0
             czd101.osres_netvat   = n_fe.
   END.
   ELSE DO:
      FIND FIRST arm012 WHERE arm012.TYPE = "VR" 
                          AND arm012.prjcod = xmm600.clicod NO-LOCK NO-ERROR.
      IF NOT AVAIL arm012 THEN DO:
         ASSIGN czd101.osres_vat   = 0
                czd101.osres_netvat   = n_fe.
      END.
      ELSE DO:
          IF DEC(arm012.text1) = 0 THEN DO:
             ASSIGN czd101.osres_vat      = 0
                    czd101.osres_netvat   = n_fe.
          END.
          ELSE DO:
             ASSIGN czd101.osres_vat  = (n_fe * DEC(arm012.text1)) / (100 + DEC(arm012.text1))
                    czd101.osres_netvat = n_fe - ((n_os * DEC(arm012.text1)) / (100 + DEC(arm012.text1))).
          END.
      END.
   END.
END. 
n_os_nvat = czd101.osres_netvat.
n_os_vat  = czd101.osres_vat.
n_os1_nvat = n_os1_nvat + n_os_nvat.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

