&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
          sicfn            PROGRESS
*/
/*----------------------------------------------------------------------
     Modify By: Saharat S.  A62-0279  03/02/2020
      -เปลี่ยนหัว เป็น TMSTH
----------------------------------------------------------------------*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
CREATE WIDGET-POOL.
/* ***************************  Definitions  ************************** */
DEF     SHARED VAR n_User               AS CHAR.
DEF     SHARED VAR n_Passwd         AS CHAR.
DEF     VAR   nv_User     AS CHAR NO-UNDO. 
DEF     VAR   nv_pwd    LIKE _password NO-UNDO.

/* Definitons  Report -------                                               */
DEF  VAR report-library AS CHAR INIT "wAC/wprl/wac_sm01A.prl".
DEF  VAR report-name  AS CHAR INIT "Statement of Account By Trandate".

DEF  VAR RB-DB-CONNECTION AS CHAR INIT "".
DEF  VAR RB-INCLUDE-RECORDS AS CHAR INIT "O". /*Can Override Filter*/
DEF  VAR RB-FILTER AS CHAR INIT "".
DEF  VAR RB-MEMO-FILE AS CHAR INIT "".
DEF  VAR RB-PRINT-DESTINATION AS CHAR INIT "?". /*Direct to Screen*/
DEF  VAR RB-PRINTER-NAME AS CHAR INIT "".
DEF  VAR RB-PRINTER-PORT AS CHAR INIT "".
DEF  VAR RB-OUTPUT-FILE AS CHAR INIT "".
DEF  VAR RB-NUMBER-COPIES AS INTE INIT 1.
DEF  VAR RB-BEGIN-PAGE AS INTE INIT 0.
DEF  VAR RB-END-PAGE AS INTE INIT 0.
DEF  VAR RB-TEST-PATTERN AS LOG INIT no.
DEF  VAR RB-WINDOW-TITLE AS CHAR INIT "".
DEF  VAR RB-DISPLAY-ERRORS AS LOG INIT yes.
DEF  VAR RB-DISPLAY-STATUS AS LOG INIT yes.
DEF  VAR RB-NO-WAIT AS LOG INIT no.
DEF  VAR RB-OTHER-PARAMETERS AS CHAR INIT "".

/* Parameters Definitions ---                                           */
DEF NEW SHARED VAR n_agent1   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_agent2   AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR n_branch   AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_branch2  AS CHAR FORMAT "x(2)".
DEF NEW SHARED VAR n_tabcod   AS CHAR FORMAT "X(4)"    INIT "U021".   /* Table-Code  sym100*/
DEF NEW SHARED VAR n_itmcod   AS CHAR FORMAT "X(4)".

Def   Var    n_name     As Char Format "x(50)".     /*acno name*/
Def   Var    n_chkname  As Char format "x(1)".        /* Acno-- chk button 1-2 */
Def   Var    n_bdes     As Char Format "x(50)".     /*branch name*/
Def   Var    n_chkBname As Char format "x(1)".        /* branch-- chk button 1-2 */
Def   Var    n_itmdes   As Char Format "x(40)".     /*Table-Code Description*/
                        
/* Local Variable Definitions ---                                       */

DEF VAR nv_asmth        AS INTE INIT 0.
DEF VAR nv_frmth        AS INTE INIT 0.
DEF VAR nv_tomth        AS INTE INIT 0.
DEF VAR cv_mthlistT     AS CHAR INIT "มกราคม,กุมภาพันธ์,มีนาคม,เมษายน,พฤษภาคม,มิถุนายน,กรกฎาคม,สิงหาคม,กันยายน,ตุลาคม,พฤศจิกายน,ธันวาคม".
DEF VAR cv_mthListE     AS CHAR INIT "January, February, March, April, May, June, July, August, September, October, November, December".

DEF VAR n_asdat         AS DATE FORMAT "99/99/9999".
DEF VAR n_frbr          AS CHAR   FORMAT "x(2)".
DEF VAR n_tobr          AS CHAR   FORMAT "x(2)".
DEF VAR n_frac          AS CHAR   FORMAT "x(7)".
DEF VAR n_toac          AS CHAR   FORMAT "x(7)".
DEF VAR n_typ           AS CHAR   FORMAT "X".
DEF VAR n_typ1          AS CHAR   FORMAT "X".
DEF VAR n_trndatto      AS DATE FORMAT "99/99/9999".

DEF VAR n_chkCopy       AS INTEGER.
DEF VAR n_OutputTo      AS INTEGER.
DEF VAR n_OutputFile    AS Char.
DEF VAR n_OutputFile2   AS Char.

DEF VAR vCliCod         AS CHAR.
DEF VAR vCliCodAll      AS CHAR.
DEF VAR vCountRec       AS INT.
DEF VAR vAcProc_fil     AS CHAR.

/*--------------------------------------- A46-0019 -----------------------------*/
DEF VAR nv_ProcessDate AS DATE FORMAT "99/99/9999".
DEF VAR nv_Trntyp1  AS CHAR INIT "M,R,A,B,C,Y,Z,O,T".

DEF VAR nv_typ1     AS CHAR.
DEF VAR nv_typ2     AS CHAR.
DEF VAR nv_typ3     AS CHAR.
DEF VAR nv_typ4     AS CHAR.
DEF VAR nv_typ5     AS CHAR.
DEF VAR nv_typ6     AS CHAR.
DEF VAR nv_typ7     AS CHAR.
DEF VAR nv_typ8     AS CHAR.
DEF VAR nv_typ9     AS CHAR.
DEF VAR nv_typ10    AS CHAR.
DEF VAR nv_typ11    AS CHAR.
DEF VAR nv_typ12    AS CHAR.
DEF VAR nv_typ13    AS CHAR.
DEF VAR nv_typ14    AS CHAR.
DEF VAR nv_typ15    AS CHAR.

/******************** output to file*******************/
DEF VAR n_net    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".
DEF VAR n_wcr    AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF VAR n_damt   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF VAR n_odue   AS DECI FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR n_odue1  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 1-3 months*/
DEF VAR n_odue2  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 3-6 months*/
DEF VAR n_odue3  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 6-9 months*/
DEF VAR n_odue4  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 9-12 months*/
DEF VAR n_odue5  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue over 12 months*/

DEF VAR n_odmonth1  AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth2  AS INT.
DEF VAR n_odmonth3  AS INT.
DEF VAR n_odmonth4  AS INT.

DEF VAR n_odDay1    AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay2    AS INT.
DEF VAR n_odDay3    AS INT.
DEF VAR n_odDay4    AS INT.

DEF VAR n_odat1     AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat2     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat3     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat4     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat5     AS  DATE FORMAT "99/99/9999".

/* TOTAL */
DEF  VAR nv_tot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_tot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".

DEF  VAR nv_tot_wcr       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_tot_damt      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_tot_odue      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /* overdue*/
                         
DEF  VAR nv_tot_odue1     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue2     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue3     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue4     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue5     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
                         
/* GRAND TOTAL */
DEF  VAR nv_gtot_prem      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_prem_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_stamp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_tax       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_gross     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm      AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_comm_comp AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_net       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".
DEF  VAR nv_gtot_bal       AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".

DEF  VAR nv_gtot_wcr     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*with in credit*/
DEF  VAR nv_gtot_damt    AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*due amount */
DEF  VAR nv_gtot_odue    AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
                            
DEF  VAR nv_gtot_odue1   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue2   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue3   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue4   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue5   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF VAR nv_asdatAging    AS DATE FORMAT "99/99/9999".

/************  field in atc00701.p ***************/
DEF VAR n_insur   AS CHAR FORMAT "x(100)".
DEF VAR n_acbrn   AS CHAR FORMAT "X(7)".
DEF VAR n_clityp  AS CHAR FORMAT "X(2)".
DEF VAR n_expdat  AS DATE FORMAT "99/99/9999".
DEF VAR n_campol  AS CHAR FORMAT "X(16)".  /* uwm100.opnpol */
DEF VAR n_dealer  AS CHAR FORMAT "X(100)".

DEF VAR n_veh     AS CHAR FORMAT "X(10)".
                  
DEF VAR n_chano   AS CHAR FORMAT "X(20)".
DEF VAR n_moddes  AS CHAR FORMAT "X(40)".
DEF VAR n_cedpol  AS CHAR FORMAT "X(16)".    /* uwm100.cedpol */

DEF NEW SHARED VAR n_sckno     AS CHAR   FORMAT "X(16)"   INIT ""     NO-UNDO.  /*umm301.sckno */
DEF NEW SHARED VAR nvw_sticker AS INTEGER  FORMAT "9999999999" INIT 0 NO-UNDO.
DEF NEW SHARED VAR nv_sticker  AS INTEGER  FORMAT "9999999999".
DEF NEW SHARED VAR chr_sticker AS CHAR     FORMAT "X(11)".
DEF NEW SHARED VAR nv_modulo   AS INT      FORMAT "9".
DEF NEW SHARED VAR nv_chkmod   AS CHAR     FORMAT "X".

DEF BUFFER bxmm600 FOR xmm600.

DEF VAR n_gpstmt AS CHAR FORMAT "X(7)".
DEF VAR n_opened AS DATE FORMAT "99/99/9999".
DEF VAR n_closed AS DATE FORMAT "99/99/9999".

/* A470142 */
DEF VAR n_prnVat AS CHAR.
DEF VAR n_linePA AS CHAR INIT "60,61,62,63,64,67".

/* A48-0250*/
DEF VAR nv_res      LIKE clm131.res.
DEF VAR nv_paid     LIKE clm130.netl_d.
DEF VAR nv_outres   LIKE clm131.res.
DEF VAR tt_res      LIKE clm131.res.
DEF VAR tt_paid     LIKE clm130.netl_d.
DEF VAR tt_outres   LIKE clm131.res.
DEF VAR nv_fptr     AS RECID.
DEF VAR n_benname AS CHAR. /* Piyachat p. A51-0203 */

/*A53-0159*/
DEF VAR n_type     AS CHAR FORMAT "X(10)" INIT "".
DEF VAR vFirstTime AS CHAR INIT "".
DEF VAR vLastTime AS CHAR INIT "".
DEF VAR nv_filter1 AS CHAR INIT "".
DEF VAR nv_filter2 AS CHAR INIT "".
DEF VAR nv_filter3 AS CHAR INIT "".
DEF VAR vAcno AS CHAR INIT "".


DEF VAR nv_grptyp      AS CHAR FORMAT "X(3)".
DEF VAR nv_type      AS CHAR FORMAT "X(1)".

DEF VAR nv_insref AS CHAR FORMAT "X" INIT "".
DEF VAR nv_dir    AS CHAR FORMAT "X(3)" INIT "".
DEF VAR nv_polgrp AS CHAR FORMAT "X(6)" INIT "".
DEF VAR nv_polgrpdes AS CHAR FORMAT "X(30)" INIT "".
DEF VAR nv_grptypdes AS CHAR FORMAT "X(30)" INIT "".
DEF VAR nv_repdetail AS CHAR FORMAT "X(10)" INIT "".

/*---A53-0159---*/
DEF VAR n_odue6  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 1-3 months*/
DEF VAR n_odue7  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 3-6 months*/
DEF VAR n_odue8  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 6-9 months*/
DEF VAR n_odue9  AS DECI FORMAT ">>,>>>,>>9.99-".  /*overdue 9-12 months*/

DEF VAR n_odmonth6  AS INT. /*month  not over  12   เดือนที่  เพื่อนำไปหาจำนวนวันในแต่ละเดือน */
DEF VAR n_odmonth7  AS INT.
DEF VAR n_odmonth8  AS INT.
DEF VAR n_odmonth9  AS INT.

DEF VAR n_odDay6    AS INT. /*count num day in over due 1 - 3   จำนวนวัน ที่เกิน ระยะเวลาให้ credit  3 เดือน */
DEF VAR n_odDay7    AS INT.
DEF VAR n_odDay8    AS INT.
DEF VAR n_odDay9    AS INT.

DEF VAR n_odat6     AS  DATE FORMAT "99/99/9999". /* วันที่ ที่เกินจากระยะเวลาให้ credit  เกินไป 3 เดือน*/
DEF VAR n_odat7     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat8     AS  DATE FORMAT "99/99/9999".
DEF VAR n_odat9     AS  DATE FORMAT "99/99/9999".

DEF  VAR nv_tot_odue6     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue7     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue8     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_tot_odue9     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF  VAR nv_gtot_odue6   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue7   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue8   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/
DEF  VAR nv_gtot_odue9   AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-".  /*overdue*/

DEF TEMP-TABLE wtagtprm_fil 
    FIELD wtacno          AS   CHAR   FORMAT "X(10)"
    FIELD wtgrp           AS   CHAR   FORMAT "X(10)"
    FIELD wtprem          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtprem_comp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtstamp         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wttax           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtgross         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtcomm          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtcomm_comp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtnet           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtbal           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtwcr           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtdamt          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue1         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue2         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue3         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue4         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue5         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue6         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue7         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue8         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtodue9         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    INDEX  wtagtprm_fil01 wtacno wtgrp.

DEF TEMP-TABLE wtGagtprm_fil 
    FIELD wtGgrp           AS   CHAR   FORMAT "X(10)"
    FIELD wtGprem          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGprem_comp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGstamp         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGtax           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGgross         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGcomm          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGcomm_comp     AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGnet           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGbal           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGwcr           AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGdamt          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue          AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue1         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue2         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue3         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue4         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue5         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue6         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue7         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue8         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    FIELD wtGodue9         AS   DECI   FORMAT ">>,>>>,>>>,>>9.99-"
    INDEX  wtGagtprm_fil01  wtGgrp.

DEF VAR nv_poltyp AS CHAR FORMAT "X(255)".
DEF VAR mday AS INT INIT 0.   /*A55-0231*/
DEF VAR n_credit AS INT INIT 0.    /*-- A55-0231--*/
DEF VAR n_credittxt AS CHAR INIT " ".  /*-- A55-0231--*/
/*ADD Saharat S. A62-0279*/
{wuw\wuwppic00a.i NEW}. 
{wuw\wuwppic01a.i}
{wuw\wuwppic02a.i}
/*END Saharat S. A62-0279*/
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brAcproc_fil

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES acproc_fil

/* Definitions for BROWSE brAcproc_fil                                  */
&Scoped-define FIELDS-IN-QUERY-brAcproc_fil acproc_fil.asdat ~
acproc_fil.type IF (acproc_fil.type = "01") THEN ("Monthly") ELSE ("Daily") ~
acproc_fil.entdat acproc_fil.enttim SUBSTRING (acproc_fil.enttim,10,3) ~
acproc_fil.trndatfr acproc_fil.trndatto acproc_fil.typdesc 
&Scoped-define ENABLED-FIELDS-IN-QUERY-brAcproc_fil 
&Scoped-define QUERY-STRING-brAcproc_fil FOR EACH acproc_fil NO-LOCK
&Scoped-define OPEN-QUERY-brAcproc_fil OPEN QUERY brAcproc_fil FOR EACH acproc_fil NO-LOCK.
&Scoped-define TABLES-IN-QUERY-brAcproc_fil acproc_fil
&Scoped-define FIRST-TABLE-IN-QUERY-brAcproc_fil acproc_fil


/* Definitions for FRAME frST                                           */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-21 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuMaxday C-Win 
FUNCTION fuMaxday RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumMonth C-Win 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE )  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE IMAGE IMAGE-21
     FILENAME "wimage\wallpape":U CONVERT-3D-COLORS
     SIZE 132.5 BY 24.

DEFINE IMAGE IMAGE-23
     FILENAME "wimage\bgc01":U CONVERT-3D-COLORS
     SIZE 118.5 BY 22.19.

DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE BUTTON Btn_OK AUTO-GO 
     LABEL "OK" 
     SIZE 13 BY 1.76
     BGCOLOR 8 FONT 6.

DEFINE RECTANGLE RECT2
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 18.5 BY 4.43
     BGCOLOR 1 .

DEFINE VARIABLE cbPrtList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 10
     LIST-ITEMS "cbPrtList" 
     DROP-DOWN-LIST
     SIZE 28 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiFile-Name2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 21.5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE rsOutput AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Item 1", 1,
"Item 2", 2,
"Item 3", 3,
"Item 4", 4
     SIZE 18 BY 4.19
     BGCOLOR 3 FGCOLOR 15  NO-UNDO.

DEFINE BUTTON buAcno1 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAcno2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัส Producer"
     FONT 6.

DEFINE BUTTON buAdd 
     LABEL "Add" 
     SIZE 8 BY .95 TOOLTIP "เพิ่ม Client Type Code".

DEFINE BUTTON buBranch 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buBranch2 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "รหัสสาขา"
     FONT 6.

DEFINE BUTTON buClicod 
     LABEL "..." 
     SIZE 3 BY .95 TOOLTIP "Client Type Code".

DEFINE BUTTON buDel 
     LABEL "Delete" 
     SIZE 8 BY .95 TOOLTIP "ลบ Client Type Code".

DEFINE VARIABLE cbRptList AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "wac_sm01.prl" 
     DROP-DOWN-LIST
     SIZE 33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno1 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiacno2 AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 12 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiAsdat AS DATE FORMAT "99/99/9999":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 14 BY 1
     BGCOLOR 3 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fibdes AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29.5 BY .95
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fibdes2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 29.5 BY .95
     BGCOLOR 3 FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE fiBranch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiBranch2 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiCcode1 AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95 TOOLTIP "Client Type Code"
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fiInclude AS CHARACTER FORMAT "X(256)":U 
     LABEL "Fill 1" 
      VIEW-AS TEXT 
     SIZE 19.5 BY 1
     BGCOLOR 1 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE finame1 AS CHARACTER FORMAT "X(256)":U 
     LABEL "" 
      VIEW-AS TEXT 
     SIZE 47 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE finame2 AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 47 BY .95
     BGCOLOR 8 FONT 6 NO-UNDO.

DEFINE VARIABLE fiProcess AS CHARACTER FORMAT "X(256)":U 
     LABEL "fiProcess" 
      VIEW-AS TEXT 
     SIZE 37 BY .95
     BGCOLOR 8 FGCOLOR 0 FONT 1 NO-UNDO.

DEFINE VARIABLE fiProcessDate AS DATE FORMAT "99/99/9999":U 
      VIEW-AS TEXT 
     SIZE 12 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 1 NO-UNDO.

DEFINE VARIABLE fiTyp1 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp10 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp11 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp12 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp13 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp14 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp15 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp2 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp3 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp4 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp5 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp6 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp7 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp8 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiTyp9 AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE raReportTyp AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "AG/BR", 1,
"FI/Dealer", 2,
"LS", 3,
"ALL", 4
     SIZE 38 BY 1.29
     BGCOLOR 19 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE rstype AS INTEGER 
     VIEW-AS RADIO-SET VERTICAL
     RADIO-BUTTONS 
          "Motor", 1,
"Non", 2,
"All", 3
     SIZE 9 BY 4.05
     BGCOLOR 19 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-86
     EDGE-PIXELS 2 GRAPHIC-EDGE  
     SIZE 38.5 BY 6.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-95
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 10.17 BY 4.43.

DEFINE RECTANGLE RECT1
     EDGE-PIXELS 4 GRAPHIC-EDGE  NO-FILL 
     SIZE 114 BY 14.71.

DEFINE RECTANGLE RECT11
     EDGE-PIXELS 3 GRAPHIC-EDGE  
     SIZE 72.5 BY 3.38
     BGCOLOR 8 .

DEFINE RECTANGLE RECT12
     EDGE-PIXELS 3 GRAPHIC-EDGE  NO-FILL 
     SIZE 26 BY 5.76.

DEFINE RECTANGLE reReprots
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL 
     SIZE 72.5 BY 7.67
     BGCOLOR 8 .

DEFINE VARIABLE seCliCod AS CHARACTER 
     VIEW-AS SELECTION-LIST MULTIPLE SORT SCROLLBAR-VERTICAL 
     SIZE 11.5 BY 4.71
     BGCOLOR 15  NO-UNDO.

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brAcproc_fil FOR 
      acproc_fil SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brAcproc_fil C-Win _STRUCTURED
  QUERY brAcproc_fil DISPLAY
      acproc_fil.asdat FORMAT "99/99/9999":U COLUMN-FONT 1 LABEL-FONT 1
      acproc_fil.type COLUMN-LABEL "Ty" FORMAT "X(2)":U
      IF (acproc_fil.type = "01") THEN ("Monthly") ELSE ("Daily") COLUMN-LABEL "Detail"
      acproc_fil.entdat COLUMN-LABEL "Process Date" FORMAT "99/99/9999":U
      acproc_fil.enttim COLUMN-LABEL "Time" FORMAT "X(8)":U
      SUBSTRING (acproc_fil.enttim,10,3) COLUMN-LABEL "Sta" FORMAT "X(1)":U
      acproc_fil.trndatfr COLUMN-LABEL "TranDate Fr" FORMAT "99/99/9999":U
      acproc_fil.trndatto COLUMN-LABEL "TranDate To" FORMAT "99/99/9999":U
      acproc_fil.typdesc FORMAT "X(60)":U
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 69 BY 4.24
         BGCOLOR 15 FGCOLOR 0 FONT 1.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     IMAGE-21 AT ROW 1 COL 1.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24.04
         BGCOLOR 18 .

DEFINE FRAME frMain
     IMAGE-23 AT ROW 1 COL 1
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 8 ROW 2.04
         SIZE 119 BY 22.44.

DEFINE FRAME frST
     rstype AT ROW 4.86 COL 103.83 NO-LABEL
     fiBranch AT ROW 2.57 COL 23 COLON-ALIGNED NO-LABEL
     fiBranch2 AT ROW 3.76 COL 23 COLON-ALIGNED NO-LABEL
     fiacno1 AT ROW 6.24 COL 7.5 COLON-ALIGNED NO-LABEL
     fiacno2 AT ROW 7.24 COL 7.5 COLON-ALIGNED NO-LABEL
     raReportTyp AT ROW 2.29 COL 76 NO-LABEL
     fiTyp1 AT ROW 11.19 COL 81.5 COLON-ALIGNED NO-LABEL
     fiTyp2 AT ROW 11.19 COL 86.5 COLON-ALIGNED NO-LABEL
     fiTyp3 AT ROW 11.19 COL 91.5 COLON-ALIGNED NO-LABEL
     fiTyp4 AT ROW 11.19 COL 96.5 COLON-ALIGNED NO-LABEL
     fiTyp5 AT ROW 11.19 COL 101.5 COLON-ALIGNED NO-LABEL
     fiTyp6 AT ROW 12.48 COL 81.5 COLON-ALIGNED NO-LABEL
     fiTyp7 AT ROW 12.48 COL 86.5 COLON-ALIGNED NO-LABEL
     fiTyp8 AT ROW 12.48 COL 91.5 COLON-ALIGNED NO-LABEL
     fiTyp9 AT ROW 12.48 COL 96.5 COLON-ALIGNED NO-LABEL
     fiTyp10 AT ROW 12.48 COL 101.5 COLON-ALIGNED NO-LABEL
     fiTyp11 AT ROW 13.76 COL 81.5 COLON-ALIGNED NO-LABEL
     fiTyp12 AT ROW 13.76 COL 86.5 COLON-ALIGNED NO-LABEL
     fiTyp13 AT ROW 13.76 COL 91.5 COLON-ALIGNED NO-LABEL
     fiTyp14 AT ROW 13.76 COL 96.5 COLON-ALIGNED NO-LABEL
     fiTyp15 AT ROW 13.76 COL 101.5 COLON-ALIGNED NO-LABEL
     buBranch AT ROW 2.67 COL 30
     buBranch2 AT ROW 3.76 COL 30
     seCliCod AT ROW 4.67 COL 78.5 NO-LABEL
     buAcno1 AT ROW 6.24 COL 21.5
     buAcno2 AT ROW 7.24 COL 21.5
     fiCcode1 AT ROW 4.67 COL 90 COLON-ALIGNED NO-LABEL
     buClicod AT ROW 4.67 COL 97
     buAdd AT ROW 6.48 COL 92
     buDel AT ROW 7.76 COL 92
     cbRptList AT ROW 9.33 COL 18 COLON-ALIGNED NO-LABEL
     brAcproc_fil AT ROW 11.95 COL 3
     fibdes AT ROW 2.57 COL 31 COLON-ALIGNED NO-LABEL
     fibdes2 AT ROW 3.76 COL 31.5 COLON-ALIGNED NO-LABEL
     finame1 AT ROW 6.24 COL 23 COLON-ALIGNED
     finame2 AT ROW 7.24 COL 23 COLON-ALIGNED NO-LABEL
     fiInclude AT ROW 9.86 COL 92.5 COLON-ALIGNED
     fiAsdat AT ROW 10.67 COL 18 COLON-ALIGNED
     fiProcessDate AT ROW 10.67 COL 45.5 COLON-ALIGNED NO-LABEL
     fiProcess AT ROW 15.1 COL 76.5
     "                                              PRINT PREMIUM STATEMENT (A4) (CBC)":150 VIEW-AS TEXT
          SIZE 114 BY .95 AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
     "From":40 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "Account No. From" AT ROW 6.24 COL 4
          BGCOLOR 8 
     " Producer Code":40 VIEW-AS TEXT
          SIZE 15 BY .76 TOOLTIP "ตัวแทน" AT ROW 5.19 COL 2
          BGCOLOR 1 FGCOLOR 7 
     " As of Date":30 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 10.67 COL 3
          BGCOLOR 1 FGCOLOR 7 
     " Process Date":30 VIEW-AS TEXT
          SIZE 12 BY 1 TOOLTIP "วันที่ออกรายงาน" AT ROW 10.67 COL 35
          BGCOLOR 1 FGCOLOR 7 
     " Client Type Code":50 VIEW-AS TEXT
          SIZE 15 BY .76 TOOLTIP "Client Type Code" AT ROW 3.86 COL 76
          BGCOLOR 1 FGCOLOR 7 
     " Include Type All":50 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 9.86 COL 76
          BGCOLOR 1 FGCOLOR 7 
     "To":20 VIEW-AS TEXT
          SIZE 5 BY .95 TOOLTIP "รหัสตัวแทนถึง" AT ROW 7.24 COL 4
          BGCOLOR 8 
     "Branch From":25 VIEW-AS TEXT
          SIZE 11 BY .95 TOOLTIP "ตั้งแต่สาขา" AT ROW 2.57 COL 10
          BGCOLOR 3 FGCOLOR 15 
     "Branch To":10 VIEW-AS TEXT
          SIZE 10.5 BY .95 TOOLTIP "ถึงสาขา" AT ROW 3.76 COL 10
          BGCOLOR 3 FGCOLOR 15 
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.52
         SIZE 114.5 BY 15.91
         BGCOLOR 3 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME frST
     " Type Of Reports":50 VIEW-AS TEXT
          SIZE 16 BY .95 TOOLTIP "ประเภทรายงาน" AT ROW 9.33 COL 3
          BGCOLOR 1 FGCOLOR 7 
     RECT-86 AT ROW 9.86 COL 75.5
     RECT1 AT ROW 2 COL 1
     RECT11 AT ROW 5.19 COL 2
     RECT12 AT ROW 3.86 COL 76
     reReprots AT ROW 8.81 COL 2
     RECT-95 AT ROW 4.67 COL 103.17
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         NO-LABELS SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 4 ROW 1.52
         SIZE 114.5 BY 15.91
         BGCOLOR 3 .

DEFINE FRAME frOK
     Btn_OK AT ROW 1.71 COL 5.5
     Btn_Cancel AT ROW 3.62 COL 5.5
     RECT2 AT ROW 1.24 COL 2.5
    WITH DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 95 ROW 17.5
         SIZE 21 BY 5
         BGCOLOR 3 .

DEFINE FRAME frOutput
     rsOutput AT ROW 2.05 COL 2.5 NO-LABEL
     cbPrtList AT ROW 3.1 COL 19.5 COLON-ALIGNED NO-LABEL
     fiFile-Name AT ROW 4.19 COL 19.5 COLON-ALIGNED NO-LABEL
     fiFile-Name2 AT ROW 5.19 COL 19.5 COLON-ALIGNED NO-LABEL
     " Output To":40 VIEW-AS TEXT
          SIZE 49 BY .95 TOOLTIP "การแสดงผล" AT ROW 1 COL 1
          BGCOLOR 1 FGCOLOR 15 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE 
         AT COL 4 ROW 17.52
         SIZE 49 BY 5.39
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
         TITLE              = "wacr12 - PRINT PREMIUM STATEMENT (A4) (CBC)"
         HEIGHT             = 24.05
         WIDTH              = 133.33
         MAX-HEIGHT         = 24.05
         MAX-WIDTH          = 133.33
         VIRTUAL-HEIGHT     = 24.05
         VIRTUAL-WIDTH      = 133.33
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
ASSIGN FRAME frMain:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME frOK:FRAME = FRAME frMain:HANDLE
       FRAME frOutput:FRAME = FRAME frMain:HANDLE
       FRAME frST:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
                                                                        */
/* SETTINGS FOR FRAME frMain
                                                                        */
/* SETTINGS FOR FRAME frOK
                                                                        */
ASSIGN 
       FRAME frOK:SCROLLABLE       = FALSE.

/* SETTINGS FOR FRAME frOutput
                                                                        */
/* SETTINGS FOR FRAME frST
   Custom                                                               */
/* BROWSE-TAB brAcproc_fil cbRptList frST */
/* SETTINGS FOR FILL-IN fiAsdat IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN fiInclude IN FRAME frST
   LABEL "Fill 1:"                                                      */
/* SETTINGS FOR FILL-IN finame1 IN FRAME frST
   LABEL ":"                                                            */
/* SETTINGS FOR FILL-IN fiProcess IN FRAME frST
   ALIGN-L LABEL "fiProcess:"                                           */
ASSIGN 
       fiProcess:HIDDEN IN FRAME frST           = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brAcproc_fil
/* Query rebuild information for BROWSE brAcproc_fil
     _TblList          = "sicfn.acproc_fil"
     _FldNameList[1]   > sicfn.acproc_fil.asdat
"acproc_fil.asdat" ? ? "date" ? ? 1 ? ? 1 no ? no no ? yes no no "U" "" ""
     _FldNameList[2]   > sicfn.acproc_fil.type
"acproc_fil.type" "Ty" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[3]   > "_<CALC>"
"IF (acproc_fil.type = ""01"") THEN (""Monthly"") ELSE (""Daily"")" "Detail" ? ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[4]   > sicfn.acproc_fil.entdat
"acproc_fil.entdat" "Process Date" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[5]   > sicfn.acproc_fil.enttim
"acproc_fil.enttim" "Time" ? "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[6]   > "_<CALC>"
"SUBSTRING (acproc_fil.enttim,10,3)" "Sta" "X(1)" ? ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[7]   > sicfn.acproc_fil.trndatfr
"acproc_fil.trndatfr" "TranDate Fr" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[8]   > sicfn.acproc_fil.trndatto
"acproc_fil.trndatto" "TranDate To" ? "date" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _FldNameList[9]   > sicfn.acproc_fil.typdesc
"acproc_fil.typdesc" ? "X(60)" "character" ? ? ? ? ? ? no ? no no ? yes no no "U" "" ""
     _Query            is NOT OPENED
*/  /* BROWSE brAcproc_fil */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wacr12 - PRINT PREMIUM STATEMENT (A4) (CBC) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wacr12 - PRINT PREMIUM STATEMENT (A4) (CBC) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brAcproc_fil
&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME brAcproc_fil
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brAcproc_fil C-Win
ON VALUE-CHANGED OF brAcproc_fil IN FRAME frST
DO:
/*  
    IF NOT CAN-FIND (FIRST docno_fil WHERE poltyp BEGINS "R")THEN DO:
       DISABLE ALL WITH FRAME frDetail.
    END.
    ELSE DO:
      FIND CURRENT docno_fil NO-LOCK.
      RUN ProcDisp IN THIS-PROCEDURE.
    END.
*/

DO WITH FRAME frST:
    IF NOT CAN-FIND(FIRST acproc_fil WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" )) THEN DO:
        ASSIGN
            fiasdat = ?
            fiProcessdate = ?
            n_trndatto = ?
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate.
    END.
    ELSE DO:
        FIND CURRENT acproc_fil NO-LOCK.
        ASSIGN
            fiasdat = acproc_fil.asdat
            fiProcessdate = acproc_fil.entdat
            n_trndatto = acproc_fil.trndatto
            n_asdat = fiasdat.
        DISP fiasdat fiProcessdate .
    END.
END. /**/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOK
&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel C-Win
ON CHOOSE OF Btn_Cancel IN FRAME frOK /* Cancel */
DO:
    Apply "Close" To This-Procedure.
    Return No-Apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK C-Win
ON CHOOSE OF Btn_OK IN FRAME frOK /* OK */
DO:
   DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST fibranch fibranch
            FRAME frST fibranch2 fibranch2
            FRAME frST fiacno1 fiacno1
            FRAME frST fiacno2 fiacno2
            FRAME frST seCliCod seCliCod
            FRAME frST rsType   rsType     /*A53-0159*/
            FRAME frST cbRptList cbRptList
            FRAME frST fiAsdat fiAsdat
            FRAME frST raReportTyp raReportTyp
            FRAME frST fityp1   fityp1
            FRAME frST fityp2   fityp2
            FRAME frST fityp3   fityp3
            FRAME frST fityp4   fityp4
            FRAME frST fityp5   fityp5
            FRAME frST fityp6   fityp6
            FRAME frST fityp7   fityp7
            FRAME frST fityp8   fityp8
            FRAME frST fityp9   fityp9
            FRAME frST fityp10 fityp10
            FRAME frST fityp11 fityp11
            FRAME frST fityp12 fityp12
            FRAME frST fityp13 fityp13
            FRAME frST fityp14 fityp14
            FRAME frST fityp15 fityp15
            FRAME frOutput rsOutput rsOutput
            FRAME frOutput cbPrtList cbPrtList
            FRAME frOutput fiFile-Name fiFile-Name
            FRAME frOutput fiFile-Name2 fiFile-Name2
            n_branch  = fiBranch
            n_branch2  = fiBranch2
            n_frac       =  fiAcno1
            n_toac      =  fiAcno2 
            n_asdat    = fiasdat /*DATE( INPUT cbAsDat) */
            vCliCod    = IF seCliCod:List-items = ? THEN vCliCodAll ELSE seCliCod:List-items
            n_OutputTo    =  rsOutput
            n_OutputFile  =  fiFile-Name
            n_OutputFile2  =  fiFile-Name2
            /*---A54-0270---
            n_type       = IF rsType = 1 THEN "Motor" ELSE "Non"      /*A53-0159*/
            ------------*/
            nv_typ1     = fityp1
            nv_typ2     = fityp2
            nv_typ3     = fityp3
            nv_typ4     = fityp4
            nv_typ5     = fityp5
            nv_typ6     = fityp6
            nv_typ7     = fityp7
            nv_typ8     = fityp8
            nv_typ9     = fityp9
            nv_typ10   = fityp10
            nv_typ11   = fityp11
            nv_typ12   = fityp12
            nv_typ13   = fityp13
            nv_typ14   = fityp14
            nv_typ15   = fityp15
            nv_trntyp1 = IF fityp1 <> "" THEN fityp1 ELSE ""
            nv_trntyp1 = IF fityp2 <> "" THEN nv_trntyp1 + "," + fityp2 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp3 <> "" THEN nv_trntyp1 + "," + fityp3 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp4 <> "" THEN nv_trntyp1 + "," + fityp4 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp5 <> "" THEN nv_trntyp1 + "," + fityp5 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp6 <> "" THEN nv_trntyp1 + "," + fityp6 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp7 <> "" THEN nv_trntyp1 + "," + fityp7 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp8 <> "" THEN nv_trntyp1 + "," + fityp8 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp9 <> "" THEN nv_trntyp1 + "," + fityp9 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp10 <> "" THEN nv_trntyp1 + "," + fityp10 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp11 <> "" THEN nv_trntyp1 + "," + fityp11 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp12 <> "" THEN nv_trntyp1 + "," + fityp12 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp13 <> "" THEN nv_trntyp1 + "," + fityp13 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp14 <> "" THEN nv_trntyp1 + "," + fityp14 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp15 <> "" THEN nv_trntyp1 + "," + fityp15 ELSE nv_trntyp1.            /* nv_trntyp1 = REPLACE(nv_trntyp1,", ","")*/

    ASSIGN  nv_filter1 = IF fityp1 <> "" THEN "(agtprm_fil.trntyp BEGINS '" + fityp1 + "') "  ELSE ""
            nv_filter1 = IF fityp2 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp2 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp3 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp3 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp4 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp4 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp5 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp5 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp6 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp6 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp7 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp7 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp8 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp8 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp9 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp9 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp10 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp10 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp11 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp11 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp12 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp12 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp13 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp13 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp14 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp14 + "') "  ELSE nv_filter1
            nv_filter1 = IF fityp15 <> "" THEN nv_filter1 + " OR (agtprm_fil.trntyp BEGINS '" + fityp15 + "') "  ELSE nv_filter1.
    ASSIGN  nv_filter2 = REPLACE(  vClicod,  ","  , "') OR (agtprm_fil.acno_clicod = '" )
            nv_filter2 = "(agtprm_fil.acno_clicod = '" + nv_filter2  + "')".

    /*---A54-0270---*/
    IF  rsType = 1 THEN ASSIGN n_type   = "Motor"
                               mday = 15.
    ELSE IF rsType = 2 THEN ASSIGN n_type = "Non"
                                   mday = 0. 
    ELSE n_type = "All".
    /*------------*/
    

   END.
   IF  n_frac = "" THEN  n_frac   = "A000000".
   IF  n_toac = "" THEN n_toac = "B999999".

   IF ( n_branch > n_branch2)   THEN DO:
         Message "ข้อมูลรหัสสาขาผิดพลาด" SKIP
                          "รหัสสาขาเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fibranch.
         RETURN NO-APPLY.
   END.
   IF ( n_frac > n_toac)   THEN DO:
         Message "ข้อมูลตัวแทนผิดพลาด" SKIP
                          "รหัสตัวแทนเริ่มต้นต้องมากกว่ารหัสสุดท้าย" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To fiacno1.
         RETURN NO-APPLY.
   END.
   IF n_OutputTo = 3 And n_OutputFile = ""    THEN DO:
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFile-Name .
         RETURN NO-APPLY.
   END.
   IF n_OutputTo = 4 And n_OutputFile2 = ""    THEN DO:
         Message "กรุณาใส่ชื่อไฟล์" VIEW-AS ALERT-BOX WARNING . 
         Apply "Entry" To  fiFile-Name2.
         RETURN NO-APPLY.
   END.
/* kan connect sicfn ---*/
      FIND FIRST dbtable WHERE dbtable.phyname = "form"  OR dbtable.phyname = "sicfn"
                                            NO-LOCK NO-ERROR NO-WAIT.
      IF AVAIL dbtable THEN DO:
          IF dbtable.phyname = "form" THEN DO:
                 ASSIGN
                     nv_User  = "?"
                     nv_pwd = "?".
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + nv_user + " -P " + nv_pwd.
          END.
          ELSE DO:
                     RB-DB-CONNECTION = dbtable.unixpara +  " -U " + n_user + " -P " + n_passwd. /*--A49-0139--*/
          END.
      END.
/*---kan*/
    IF n_asdat = ?   THEN DO:
            MESSAGE "ไม่พบข้อมูล  กรุณาตรวจสอบการ Process ข้อมูล" VIEW-AS ALERT-BOX WARNING.
    END.
    ELSE DO:
        MESSAGE "สาขา                      : "  n_Branch " ถึง " n_Branch2 SKIP(1)
                            "ตัวแทน/นายหน้า  : "  n_frac " ถึง " n_toac  SKIP(1)
                            "ข้อมูลวันที่             : " STRING(n_asdat,"99/99/9999") SKIP(1)
                            "Include Type       : " nv_trntyp1 SKIP(1)
                            "พิมพ์รายงาน        : " cbRptList VIEW-AS ALERT-BOX QUESTION
        BUTTONS YES-NO
        TITLE "Confirm"    UPDATE CHOICE AS LOGICAL.
        CASE CHOICE:
        WHEN TRUE THEN    DO:
            ASSIGN
                    nv_User   =   n_user
                    nv_pwd    =   n_passwd
              report-name     =  cbRptList.

            vFirstTime =  STRING(TIME, "HH:MM AM").

            IF rstype = 1 THEN nv_repdetail = "Motor".
            ELSE IF rstype = 2 THEN nv_repdetail = "Non Motor".
            ELSE nv_repdetail = "All".
            
            RUN pdOutput.   /* A53-0159 */

                DISP "" @ fiProcess WITH FRAME  frST.
                    vLastTime =  STRING(TIME, "HH:MM AM").

            MESSAGE "As of Date     : " STRING(n_asdat,"99/99/9999")  SKIP (1)
                   "ตัวแทน          : "  n_frac " ถึง " n_toac SKIP (1)
                   "เวลา  " vFirstTime "  -  " vLastTime   VIEW-AS ALERT-BOX INFORMATION.
        END.
        WHEN FALSE THEN    DO:
                RETURN NO-APPLY.
        END.
        END CASE.
        
    END.   /* IF  asdat  <> ? */

END.

/*******************************************************/
/*
            nv_trntyp1 = IF fityp1 <> "" THEN fityp1 ELSE ""
            nv_trntyp1 = IF fityp2 <> "" THEN nv_trntyp1 + "," + fityp2 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp3 <> "" THEN nv_trntyp1 + "," + fityp3 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp4 <> "" THEN nv_trntyp1 + "," + fityp4 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp5 <> "" THEN nv_trntyp1 + "," + fityp5 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp6 <> "" THEN nv_trntyp1 + "," + fityp6 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp7 <> "" THEN nv_trntyp1 + "," + fityp7 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp8 <> "" THEN nv_trntyp1 + "," + fityp8 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp9 <> "" THEN nv_trntyp1 + "," + fityp9 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp10 <> "" THEN nv_trntyp1 + "," + fityp10 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp11 <> "" THEN nv_trntyp1 + "," + fityp11 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp12 <> "" THEN nv_trntyp1 + "," + fityp12 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp13 <> "" THEN nv_trntyp1 + "," + fityp13 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp14 <> "" THEN nv_trntyp1 + "," + fityp14 ELSE nv_trntyp1
            nv_trntyp1 = IF fityp15 <> "" THEN nv_trntyp1 + "," + fityp15 ELSE nv_trntyp1.            /* nv_trntyp1 = REPLACE(nv_trntyp1,", ","")*/


    IF raReportTyp = 1 OR  raReportTyp = 2 THEN DO:
        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                    STRING (MONTH (n_asdat)) + "/" + 
                                    STRING (DAY (n_asdat)) + "/" + 
                                    STRING (YEAR (n_asdat)) + 
                                    " AND " + 
                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                    " AND " +
                                    "LOOKUP (agtprm_fil.acno_clicod," + '"' + TRIM (vCliCod) + '"' + ")" + "  <> 0 "  +
                                    " AND " +
                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                    " AND " +
                                    "LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) ," + '"' + nv_trntyp1 + '"' + ")" + "  <> 0 " .

    END.
    ELSE DO:  /* ALL*/
        RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                    STRING (MONTH (n_asdat)) + "/" + 
                                    STRING (DAY (n_asdat)) + "/" + 
                                    STRING (YEAR (n_asdat)) + 
                                    " AND " + 
                                    "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                    "agtprm_fil.acno <= '" + n_toac + "'" +
                                    " AND " +
                                    "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                    "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                    " AND " +
                                    "LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) ," + '"' + nv_trntyp1 + '"' + ")" + "  <> 0 " .
    END.


*/

/* filter ทั้งหมด */
/*              RB-FILTER            = 'agtprm_fil.asdat = ' + 
 *                                                     STRING (MONTH (n_asdat)) + "/" + 
 *                                                     STRING (DAY (n_asdat)) + "/" + 
 *                                                     STRING (YEAR (n_asdat)) + 
 *                                                     " AND " +
 *                                                     "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
 *                                                     "agtprm_fil.polbran <= '" + n_branch2 + "'" +
 *                                                     " AND " + 
 *                                                     "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
 *                                                     "agtprm_fil.acno <= '" + n_toac + "'" +
 *                                                     " AND " +
 *                                                     "LOOKUP (agtprm_fil.acno_clicod," + '"' + TRIM (vCliCod) + '"' + ")" + "  <> 0 " +
 *                                                     " AND " +
 *                                                     "( SUBSTRING(agtprm_fil.trntyp,1,1) = 'M' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'A' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'R' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'B' " + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = 'C' " + " OR " +                                                     
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ + "'" + " OR " + 
 *                                                     "SUBSTRING(agtprm_fil.trntyp,1,1) = '" + n_typ1 + "' )" */
                                                    
/*                                                      " AND " +
 *                                                     "(agtprm_fil.trntyp <>  ''  OR  agtprm_fil.trntyp begins  '" + n_typ   +  
 *                                                     "' OR agtprm_fil.trntyp begins  '" + n_typ1 + "' )" */

/****************/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME buAcno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno1 C-Win
ON CHOOSE OF buAcno1 IN FRAME frST /* ... */
DO:
   n_chkname = "1". 
  RUN Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno1 = n_agent1
        finame1 = n_name.
       
  Disp fiacno1 finame1  with Frame {&Frame-Name}      .
 
 n_agent1 =  fiacno1 .

  Return NO-APPLY.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAcno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAcno2 C-Win
ON CHOOSE OF buAcno2 IN FRAME frST /* ... */
DO:
  n_chkname = "2". 
  run Whp\WhpAcno(input-output  n_name,input-output n_chkname).
  
  Assign    
        fiacno2 = n_agent2
        finame2 = n_name.
       
  Disp fiacno2 finame2 with Frame {&Frame-Name}      .
   
  n_agent2 =  fiacno2 .
  
  Return NO-APPLY.
 
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buAdd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buAdd C-Win
ON CHOOSE OF buAdd IN FRAME frST /* Add */
DO:
DEF VAR vChkFirstAdd AS INT.

    vCliCod = seCliCod:List-items.        
    vChkFirstAdd = IF vCliCod = ? THEN 1 ELSE 0 .

/*---------------- Check Client Type code ------------------*/
    FIND FIRST sym100 USE-INDEX sym10001          WHERE
               sym100.tabcod = "U021"              AND
               sym100.itmcod = INPUT fiCcode1
         NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL sym100 THEN DO:
       IF fiCcode1 <> "" THEN DO:
           MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบ ! Client Code" VIEW-AS ALERT-BOX ERROR. 
           APPLY "ENTRY" TO fiCcode1.            
           RETURN NO-APPLY.
       END.
   END.

    IF fiCcode1 = ""  THEN DO:
        MESSAGE "ข้อมูลผิดพลาด  กรุณาตรวจสอบ ! " VIEW-AS ALERT-BOX ERROR.
        APPLY "ENTRY" TO fiCcode1.            
        RETURN NO-APPLY.
    END.
        
    IF vChkFirstAdd = 1 THEN DO:
        DO WITH FRAME  frST :
               ASSIGN  fiCcode1.
                    seCliCod:Add-first(fiCcode1).
                    seCliCod = seCliCod:SCREEN-VALUE .
        END.  
    END.
    ELSE DO:          /* เพิ่มข้อมูลต่อ */
   
        IF LookUp(fiCcode1,vCliCod) <> 0 THEN DO: 
              MESSAGE "ข้อมูลซ้ำ กรุณาตรวจสอบ ! " VIEW-AS ALERT-BOX ERROR.
              APPLY "ENTRY" TO fiCcode1.            
              RETURN NO-APPLY.
        END.
        ELSE DO:               /* ข้อมูลไม่ซ้ำเพิ่มได้  */
              DO WITH FRAME  frST :
                   ASSIGN  fiCcode1.
                        seCliCod:Add-first(fiCcode1).
                        seCliCod = seCliCod:SCREEN-VALUE .
              END.  
        END.

    END.
        
        APPLY "ENTRY" TO fiCcode1.    
        vCliCod = seCliCod:List-items.    

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch C-Win
ON CHOOSE OF buBranch IN FRAME frST /* ... */
DO:

   n_chkBName = "1". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch = n_branch
        fibdes   = n_bdes.
       
  Disp fibranch fibdes  with Frame {&Frame-Name}      .
 
 n_branch =  fibranch .

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buBranch2 C-Win
ON CHOOSE OF buBranch2 IN FRAME frST /* ... */
DO:
   n_chkBName = "2". 
  RUN Whp\Whpbran(input-output  n_bdes,input-output n_chkBName).
  
  Assign    
        fibranch2 = n_branch2
        fibdes2   = n_bdes.
       
  Disp fibranch2 fibdes2  with Frame {&Frame-Name}      .
 
 n_branch2 =  fibranch2.

  Return NO-APPLY.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buClicod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buClicod C-Win
ON CHOOSE OF buClicod IN FRAME frST /* ... */
DO:
  
  RUN Whp\WhpClico( input-output n_itmdes).
  
  Assign    
        fiCcode1 = n_itmcod.
        
  Disp fiCcode1 with Frame {&Frame-Name}      .
 
  Return NO-APPLY.

/*     
/* input-output  n_tabcod,input-output n_itmcod, */
n_itmdes   = n_itmdes.
*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buDel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buDel C-Win
ON CHOOSE OF buDel IN FRAME frST /* Delete */
DO:
    DO WITH FRAME  frST :
        ASSIGN   seCliCod.
               seCliCod:Delete(seCliCod).
               seCliCod = seCliCod:SCREEN-VALUE .
    END.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbRptList
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList C-Win
ON RETURN OF cbRptList IN FRAME frST
DO:
    APPLY "ENTRY" TO fiTyp1 IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbRptList C-Win
ON VALUE-CHANGED OF cbRptList IN FRAME frST
DO:
  DO WITH FRAME {&FRAME-NAME} :
        ASSIGN  
            FRAME frST cbRptList cbRptList.

    IF cbRptList <> "Statement of Account By Trandate" THEN DO:
       rstype = 3.
       DISP rstype.
       DISABLE rstype .
    END.
    ELSE DO:
      ENABLE rstype.
    END.
  END.

  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON LEAVE OF fiacno1 IN FRAME frST
DO:
    Assign
        fiacno1 = input fiacno1
        n_agent1  = fiacno1.
    
    DISP CAPS(fiacno1) @ fiacno1 WITH FRAME frST.
            
    IF Input  FiAcno1 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno1 = "".
              finame1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    End.    
    DISP CAPS (fiAcno1) @ fiAcno1 WITH FRAME frST.
    DISP CAPS (fiAcno1) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno1 C-Win
ON RETURN OF fiacno1 IN FRAME frST
DO:
/*    Assign
 *   fiacno1 = input fiacno1
 *   n_agent1  = fiacno1.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent1  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname1:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiacno2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON LEAVE OF fiacno2 IN FRAME frST
DO:
    Assign
        fiacno2 = input fiacno2
        n_agent2  = fiacno2.

    DISP CAPS(fiacno2) @ fiacno2 WITH FRAME frST.        
        
    IF Input  FiAcno2 <> "" Then Do :        
        FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
        IF AVAILABLE xmm600 THEN DO:
              finame2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.name.
        END.        
        ELSE DO:
              fiAcno2 = "".
              finame2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
              MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
        END.
    END.
    DISP CAPS (fiAcno2) @ fiAcno2 WITH FRAME frST.
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiacno2 C-Win
ON RETURN OF fiacno2 IN FRAME frST
DO:
/*      Assign
 *   fiacno2 = input fiacno2
 *   n_agent2  = fiacno2.
 *   
 *     FIND   xmm600 WHERE xmm600.acno = n_agent2  NO-ERROR.
 *   IF AVAILABLE xmm600 THEN DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = xmm600.abname.
 *   END.        
 *   ELSE DO:
 *           fiabname2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
 *           MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
 *   END.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON LEAVE OF fiBranch IN FRAME frST
DO:
  Assign
         fibranch = input fibranch
         n_branch = fibranch.

    DISP CAPS(fibranch) @ fibranch WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch C-Win
ON RETURN OF fiBranch IN FRAME frST
DO:
  Assign
    fibranch = input fibranch
    n_branch  = fibranch.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
  END.        
  ELSE DO:
          fibdes:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiBranch2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON LEAVE OF fiBranch2 IN FRAME frST
DO:
     Assign
         fibranch2 = input fibranch2
         n_branch2  = fibranch2.
    DISP CAPS(fibranch2)@ fibranch2 WITH FRAME frST.         
             
     Apply "Entry" To fiAcno1.           
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiBranch2 C-Win
ON RETURN OF fiBranch2 IN FRAME frST
DO:
  Assign
  fibranch2 = input fibranch2
  n_branch2  = fibranch2.
  
    FIND   xmm023 WHERE xmm023.branch = n_branch2  NO-ERROR.
  IF AVAILABLE xmm023 THEN DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = xmm023.bdes.
  END.        
  ELSE DO:
          fibdes2:Screen-value IN FRAME {&FRAME-NAME} = "Not Found !".
          MESSAGE "ไม่พบข้อมูล" VIEW-AS ALERT-BOX  warning TITLE "Confirm" .
  END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiCcode1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiCcode1 C-Win
ON LEAVE OF fiCcode1 IN FRAME frST
DO:
    ASSIGN fiCcode1.
    DISP CAPS (fiCcode1) @ fiCcode1 WITH FRAME frST.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME fiFile-Name
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name C-Win
ON RETURN OF fiFile-Name IN FRAME frOutput
DO:
          APPLY "ENTRY" TO btn_OK IN FRAME frOK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiFile-Name2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiFile-Name2 C-Win
ON RETURN OF fiFile-Name2 IN FRAME frOutput
DO:
          APPLY "ENTRY" TO btn_OK IN FRAME frOK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME fiTyp1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp1 C-Win
ON LEAVE OF fiTyp1 IN FRAME frST
DO:
    fiTyp1 = CAPS(INPUT fiTyp1).
    DISP fiTyp1 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp10
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp10 C-Win
ON LEAVE OF fiTyp10 IN FRAME frST
DO:
    fiTyp10 = CAPS(INPUT fiTyp10).
    DISP fiTyp10 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp11
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp11 C-Win
ON LEAVE OF fiTyp11 IN FRAME frST
DO:
    fiTyp11 = CAPS(INPUT fiTyp11).
    DISP fiTyp11 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp12
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp12 C-Win
ON LEAVE OF fiTyp12 IN FRAME frST
DO:
    fiTyp12 = CAPS(INPUT fiTyp12).
    DISP fiTyp12 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp13
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp13 C-Win
ON LEAVE OF fiTyp13 IN FRAME frST
DO:
    fiTyp13 = CAPS(INPUT fiTyp13).
    DISP fiTyp13 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp14
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp14 C-Win
ON LEAVE OF fiTyp14 IN FRAME frST
DO:
    fiTyp14 = CAPS(INPUT fiTyp14).
    DISP fiTyp14 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp15
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp15 C-Win
ON LEAVE OF fiTyp15 IN FRAME frST
DO:
    fiTyp15 = CAPS(INPUT fiTyp15).
    DISP fiTyp15 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp2 C-Win
ON LEAVE OF fiTyp2 IN FRAME frST
DO:
    fiTyp2 = CAPS(INPUT fiTyp2).
    DISP fiTyp2 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp3 C-Win
ON LEAVE OF fiTyp3 IN FRAME frST
DO:
    fiTyp3 = CAPS(INPUT fiTyp3).
    DISP fiTyp3 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp4
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp4 C-Win
ON LEAVE OF fiTyp4 IN FRAME frST
DO:
    fiTyp4 = CAPS(INPUT fiTyp4).
    DISP fiTyp4 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp5
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp5 C-Win
ON LEAVE OF fiTyp5 IN FRAME frST
DO:
    fiTyp5 = CAPS(INPUT fiTyp5).
    DISP fiTyp5 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp6
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp6 C-Win
ON LEAVE OF fiTyp6 IN FRAME frST
DO:
    fiTyp6 = CAPS(INPUT fiTyp6).
    DISP fiTyp6 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp7
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp7 C-Win
ON LEAVE OF fiTyp7 IN FRAME frST
DO:
    fiTyp7 = CAPS(INPUT fiTyp7).
    DISP fiTyp7 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp8
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp8 C-Win
ON LEAVE OF fiTyp8 IN FRAME frST
DO:
    fiTyp8 = CAPS(INPUT fiTyp8).
    DISP fiTyp8 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTyp9
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTyp9 C-Win
ON LEAVE OF fiTyp9 IN FRAME frST
DO:
    fiTyp9 = CAPS(INPUT fiTyp9).
    DISP fiTyp9 WITH FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME raReportTyp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReportTyp C-Win
ON RETURN OF raReportTyp IN FRAME frST
DO:
      APPLY "ENTRY" TO seClicod IN FRAME frST.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL raReportTyp C-Win
ON VALUE-CHANGED OF raReportTyp IN FRAME frST
DO:
    raReportTyp = INPUT raReportTyp.
    
/*DO WITH FRAME frST:
 * /*    seClicod:IS-SELECTED(seClicod).*/
 *     seCliCod:Delete(seClicod).
 *     seCliCod = seCliCod:SCREEN-VALUE .
 * END.*/

    RUN pdClicod.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frOutput
&Scoped-define SELF-NAME rsOutput
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rsOutput C-Win
ON VALUE-CHANGED OF rsOutput IN FRAME frOutput
DO:
  ASSIGN {&SELF-NAME}.
  
  CASE rsOutput:
        WHEN 1 THEN  /* Screen */
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = No
            fiFile-Name2:SENSITIVE = No

            fiFile-Name = ""
            fiFile-Name2 = "".
        WHEN 2 THEN  /* Printer */
          ASSIGN
            cbPrtList:SENSITIVE   = Yes
            fiFile-Name:SENSITIVE = No
            fiFile-Name2:SENSITIVE = No

            fiFile-Name = ""
            fiFile-Name2 = "".

        WHEN 3 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = Yes
            fiFile-Name2:SENSITIVE = No

            fiFile-Name2 = "".
          APPLY "ENTRY" TO fiFile-Name.
        END.
        WHEN 4 THEN  /* File */ 
        DO:
          ASSIGN
            cbPrtList:SENSITIVE   = No
            fiFile-Name:SENSITIVE = No
            fiFile-Name2:SENSITIVE = Yes
            
            fiFile-Name = "". 
          APPLY "ENTRY" TO fiFile-Name2.
        END.
        
  END CASE.

        DISP fiFile-Name fiFile-Name2  WITH FRAME frOutput.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frST
&Scoped-define SELF-NAME rstype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rstype C-Win
ON VALUE-CHANGED OF rstype IN FRAME frST
DO:
  ASSIGN {&SELF-NAME}.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/************   Program   **************
/* CREATE BY :  Kanchana C.        A44-0233  */
Wac
        -Wacr02.w        /*PRINT PREMIUM STATEMENT (A4)*/
        -wacr02f1.i       /* File for FN         A46-0019 */
        -wacr02f2.i       /* File for FN Full  A46-0019 */ 

WPrl
        -Wac_sm01.prl
Whp
        -WhpBran.w
        -WhpAcno.w
        -WhpClico.w
Wut
        -WutDiCen.p
        -WutWiCen.p
        
/* Modify : Kanchana C.  31/10/2002  
                แก้ไข  ออก text file ให้ออกเป็น text file คั่นด้วย ";"  แล้วจึงนำเข้า Excel   */

/* Modify By : Kanchana C.             A46-0019    13/01/2003
    1. ดึงงาน เฉพาะ AG/BK เท่านั้น  ออกกระดาษ A4
        ระบุ ประเภทตัวแทน  ที่จะให้พิมพ์ จาก Client type ดังนี้  AG AM BD BM BR PS RS ST(STAFF)
        output --> Report Builder  เป็นกระดาษส่ง
        
    2. ดึงเฉพาะ xmm600.Clicod  = ที่เป็นรหัส DE  ,  FN  ,OT  
        เพิ่ม Filed จาก  Statment เดิม  คือ  Credit days  Overdue date  Overdue days 
                 Make   Model  Chassis  Sticker   
                    Output เหมือน Statement to excel  ATC00701.P
        ระบุ ประเภทตัวแทน  ที่จะให้พิมพ์ จาก Client type ดังนี้   DE FI  FN  OT
        output --> ออก text    เข้า File Excel  
*/

/* Modify By : Kanchana C.             A46-0218    27/06/2003
    ระบุ ประเภทตัวแทน  ที่จะให้พิมพ์ จาก Client type 
    ช่อง AG/BR        เพิ่ม OT
           FI/Dealer    เพิ่ม DI  ,  ย้าย  OT
*/

/* Modify : Kanchana C.  21/04/2004    Assign No.  :   A47-0142
    - ปรับ การออกรายงาน Statement A4
    1. เพิ่ม Column ที่มีการ Print VAT แล้ว จะให้ พิมพ์ อักษร  V   ออกมาในรายงาน
    2. เพิ่ม   หมวด client type      LS  (Law  Suit)
    3. เพิ่ม report output to excel ให้แบ่งการ  sort  เป็น 2 ส่วน
      3.1  by transaction
      3.2  by policy
*/


/* Modify : Kanchana C.  12/05/2005    Assign No.  :   A48-0250
    - ขอเพิ่ม Column ข้อมูลใน Statement บน Safety Soft  to Excel File 
    ให้เหมือนกับ Statement บน Premium โดยเฉพาะให้มี Column "Agent Code"
    
*/
/* Modify By Wantanee.S A49-0139  Date 11/08/2006 Lock Database Sicfn 
   - Lock ไม่ให้ User Blank เข้าใช้ database */

------------------------------------------------------------------------- 
 Modify By : TANTAWAN C.   09/11/2007   [A500178]
             ปรับ format branch เพื่อรองรับการขยายสาขา
             ยขยาย format fiacno1 จาก "X(7)" เป็น  Char "X(10)"
                          fiacno2 จาก "X(7)" เป็น  Char "X(10)"
-------------------------------------------------------------------------
/*
 Modify : Piyachat P. 12/09/2008 Assign No. : A51-0203 
   - ขอเพิ่ม Column ข้อมูลของผู้รับผลประโยชน์
*/

Modify By : Sayamol N.   23/04/2010   (A53-0159)
           1) แยก Motor / Non Motor
           2) Motor Credit Term ให้นับตาม CBC 
           3) Non-Motor  Credit Term  ตามระบบโดยนับตาม Comdate   

Modify By : Sayamol N.  12/09/2011  (A54-0270)
           - ปรับคอลัมน์ให้ถูกต้อง (ตัดคอลัมน์ Overdue ที่เกินมาออก)
           - overdue day = As date - Due Date
             เดิม Today - Due Date
Modify By : Sayamol N.  17/07/2012 (A55-0231)
     - Sum Due Day ใหม่ เนื่องจากระบบเก็บข้อมูลแบบ 1-3 เดือน, 4-6 เดือน,...
       เป็น 1-30 วัน, 31-60 วัน,...
             

*****************************************/    

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
  
  gv_prgid = "wacr12".
  gv_prog  = "PRINT STATEMENT A4 for CBC".
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).

/*********************************************************************/  

 
  CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.  
/*    RUN Wut\Wutwicen.p (C-Win:HANDLE).*/

  SESSION:DATA-ENTRY-RETURN = YES.
  
    DO WITH FRAME frST :
        /*reY:MOVE-TO-TOP() .
         *     reZ:MOVE-TO-TOP() .*/
          
        APPLY "ENTRY" TO fiBranch IN FRAME frST.
        
        RUN ProcGetRptList.
        RUN ProcGetPrtList.  
        
           ASSIGN   
                fiacno1    = ""
                fiacno2    = ""
                fiAsdat  = ?
                raReportTyp = 1
                
                fiInclude =  nv_Trntyp1
                fityp1 = "M"
                fityp2 = "R"
                fityp3 = "A"
                fityp4 = "B"
                fityp5 = "C"
                rsType = 1.    /*A53-0159*/
/*                fityp1 = "Y"
 *                 fityp2 = "Z"
 *                 fityp3 = "O"
 *                 fityp4 = "T".*/
                
            DISPLAY  fiacno1 fiacno2 fiasdat raReportTyp
                            fiInclude   fityp1 fityp2 fityp3 fityp4 fityp5
                     rsType.   /*A53-0159*/
        
        RUN pdInitData.  
        RUN pdSym100.
        RUN pdUpdateQ.
        RUN pdClicod.


    END.    
    DO WITH FRAME frTranDate:
         ASSIGN  
           rsOutput:Radio-Buttons = "Screen, 1,Printer, 2,File for FN, 3,File for FN Full, 4" /*"หน้าจอ, 1,เครื่องพิมพ์, 2, File, 3" */
           rsOutput = 2
            
           cbPrtList:SENSITIVE    = Yes
           fiFile-Name:SENSITIVE  = No.
        DISPLAY rsOutput WITH FRAME frOutput .    
          
/*          RUN pdAcProc_fil.*/
    END.

           
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
  ENABLE IMAGE-21 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY rstype fiBranch fiBranch2 fiacno1 fiacno2 raReportTyp fiTyp1 fiTyp2 
          fiTyp3 fiTyp4 fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 
          fiTyp12 fiTyp13 fiTyp14 fiTyp15 seCliCod fiCcode1 cbRptList fibdes 
          fibdes2 finame1 finame2 fiInclude fiAsdat fiProcessDate fiProcess 
      WITH FRAME frST IN WINDOW C-Win.
  ENABLE rstype fiBranch fiBranch2 fiacno1 fiacno2 raReportTyp fiTyp1 fiTyp2 
         fiTyp3 fiTyp4 fiTyp5 fiTyp6 fiTyp7 fiTyp8 fiTyp9 fiTyp10 fiTyp11 
         fiTyp12 fiTyp13 fiTyp14 fiTyp15 buBranch buBranch2 seCliCod buAcno1 
         buAcno2 fiCcode1 buClicod buAdd buDel cbRptList brAcproc_fil fibdes 
         fibdes2 finame1 finame2 fiInclude fiAsdat fiProcessDate fiProcess 
         RECT-86 RECT1 RECT11 RECT12 reReprots RECT-95 
      WITH FRAME frST IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frST}
  ENABLE IMAGE-23 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  ENABLE RECT2 Btn_OK Btn_Cancel 
      WITH FRAME frOK IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOK}
  DISPLAY rsOutput cbPrtList fiFile-Name fiFile-Name2 
      WITH FRAME frOutput IN WINDOW C-Win.
  ENABLE rsOutput cbPrtList fiFile-Name fiFile-Name2 
      WITH FRAME frOutput IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frOutput}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCalDueDate C-Win 
PROCEDURE pdCalDueDate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----A53-0159---*/
        ASSIGN
           n_odat1 = agtprm_fil.duedat  + 15   /* ได้วันที่วันสุดท้ายในช่วง*/
           n_odat2 = agtprm_fil.duedat  + 30
           n_odat3 = agtprm_fil.duedat  + 45
           n_odat4 = agtprm_fil.duedat  + 60
           n_odat5 = agtprm_fil.duedat  + 90 
           n_odat6 = agtprm_fil.duedat  + 180
           n_odat7 = agtprm_fil.duedat  + 270
           n_odat8 = agtprm_fil.duedat  + 365.
        
     /*================== เปรียบเทียบวันที่ As Date กับ duedat & odat1-4 (over due date) ===*/
            IF /*n_day <> 0  AND*/ n_asdat <= (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat) + mday) THEN DO:  /* เทียบ asdate กับ  วันทีสุดท้าย  ก่อนเดือนสุดท้าย*/
                n_wcr = n_wcr + agtprm_fil.bal .                  /* with in credit  ไม่ครบกำหนดชำระ */
            END.
            IF n_asdat > (agtprm_fil.duedat - fuMaxDay(agtprm_fil.duedat) + mday) AND n_asdat <= agtprm_fil.duedat THEN DO:   /*เทียบ asdate กับวันที่ในช่วงเดือนสุดท้าย*/
                n_damt = n_damt + agtprm_fil.bal .             /* due Amout  ครบกำหนดชำระ*/
            END.
           /*-------------------------------*/ 
            IF n_asdat > agtprm_fil.duedat AND n_asdat <= n_odat1 THEN 
                    n_odue1 = n_odue1 +  agtprm_fil.bal.         /* 1-15 days */  /* เดิม  overdue 1- 3 months*/
            
            IF n_asdat > n_odat1 AND n_asdat <= n_odat2 THEN 
                    n_odue2 = n_odue2 +  agtprm_fil.bal.         /* 16-30 days */  /* เดิม overdue 3 - 6 months*/
            
            IF n_asdat > n_odat2 AND n_asdat <= n_odat3 THEN 
                    n_odue3 = n_odue3 +  agtprm_fil.bal.         /* 31-45 days*/   /* เดิม overdue 6 - 9 months*/
            
            IF n_asdat > n_odat3 AND n_asdat <= n_odat4 THEN 
                    n_odue4 = n_odue4 +  agtprm_fil.bal.        /* 46-60 days */   /* เดิม overdue 9 - 12 months*/

            IF n_asdat > n_odat4 AND n_asdat <= n_odat5 THEN 
                    n_odue5 = n_odue5 +  agtprm_fil.bal.       /* 61-90 days */   /* เดิม over 12  months*/

            IF n_asdat > n_odat5 AND n_asdat <= n_odat6 THEN 
                    n_odue6 = n_odue6 +  agtprm_fil.bal.       /* 91-180 days */   /* เดิม over 12  months*/

            IF n_asdat > n_odat6 AND n_asdat <= n_odat7 THEN 
                    n_odue7 = n_odue7 +  agtprm_fil.bal.       /* 181-270 days */   /* เดิม over 12  months*/

            IF n_asdat > n_odat7 AND n_asdat <= n_odat8 THEN 
                    n_odue8 = n_odue8 +  agtprm_fil.bal.       /* 270-365 days */   /* เดิม over 12  months*/

            IF n_asdat > n_odat8 THEN 
                    n_odue9 = n_odue9 +  agtprm_fil.bal.       /* over 365 days */   /* เดิม over 12  months*/
            
            n_odue = n_odue1 + n_odue2 + n_odue3 + n_odue4 + n_odue5 +
                     n_odue6 + n_odue7 + n_odue8 + n_odue9.
            
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdClicod C-Win 
PROCEDURE pdClicod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  i AS INT INIT 1.
/*message "(" + vClicod + ")" view-as alert-box.*/

DO WITH FRAME frST:
        seCliCod:DELETE("AG,AM,BD,BM,BR,PS,RS,ST,DI,DE,FI,FN,OT,LS,").
        seCliCod = seCliCod:SCREEN-VALUE .

    IF raReportTyp = 1 THEN DO:
        vClicod = "AG,AM,BD,BM,BR,PS,RS,ST,OT".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE IF raReportTyp = 2 THEN DO:
        vClicod = "DE,FI,FN,DI".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE IF raReportTyp = 3 THEN DO:
        vClicod = "LS".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.
    ELSE DO:
        vClicod = "".
        seCliCod:ADD-FIRST(vClicod).
        seCliCod = seCliCod:SCREEN-VALUE .
    END.

END. /**/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCLSValue C-Win 
PROCEDURE pdCLSValue :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN
            n_wcr   = 0
            n_damt  = 0
            n_odue  = 0
            n_odue1 = 0
            n_odue2 = 0
            n_odue3 = 0
            n_odue4 = 0
            n_odue5 = 0

            n_odmonth1 = 0  n_odmonth2 = 0  n_odmonth3 = 0  n_odmonth4 = 0
            n_odDay1   = 0  n_odDay2   = 0  n_odDay3   = 0  n_odDay4   = 0
            n_odat1    = ?  n_odat2    = ?  n_odat3    = ?  n_odat4    = ?
            
            n_prnVat  = ""     /* A47-0142*/
            n_benname = "" /* A51-0203 */
            /*---A53-0159---*/
            n_odue6 = 0
            n_odue7 = 0
            n_odue8 = 0
            n_odue9 = 0

            n_odmonth6 = 0  n_odmonth7 = 0  n_odmonth8 = 0  n_odmonth9 = 0
            n_odDay6   = 0  n_odDay7   = 0  n_odDay8   = 0  n_odDay9   = 0
            n_odat6    = ?  n_odat7    = ?  n_odat8    = ?  n_odat9    = ?
            .

      /*------------------ หา  ใน  uwm100  ---------------*/
        ASSIGN
            n_expdat = ?
            n_campol = ""
            n_cedpol = ""
            n_dealer = ""
            n_gpstmt = ""
            n_opened = ?
            n_closed = ?
            n_insur  = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdCredit C-Win 
PROCEDURE pdCredit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
n_credit = 0.

 FIND  xmm600 USE-INDEX xmm60001 WHERE
       xmm600.acno  = agtprm_fil.acno NO-LOCK NO-ERROR.
 IF NOT AVAIL xmm600 THEN n_credit = 0.
 ELSE ASSIGN n_credit = xmm600.crper.

 IF SUBSTR(nv_polgrp,1,3) = "MOT" THEN n_credittxt = "CBC".
 ELSE n_credittxt = STRING(n_credit).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdDeptGrp C-Win 
PROCEDURE pdDeptGrp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_dir = ""
       nv_polgrp = ""
       nv_grptypdes = ""
       nv_insref = "".

FIND FIRST xmm031 WHERE xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
IF AVAIL xmm031 THEN DO:

   IF xmm031.dept = "G" OR xmm031.dept = "M" THEN DO:   /*Motor*/
      ASSIGN nv_polgrp = "MOT".


      FIND FIRST acm001 USE-INDEX acm00101 WHERE 
                 acm001.trnty1 = SUBSTR(agtprm_fil.trntyp,1,1) AND
                 acm001.docno  = agtprm_fil.docno NO-LOCK NO-ERROR.
      IF AVAIL acm001 THEN DO:
   
         IF SUBSTR((acm001.insref),2,1) = "C" OR 
            SUBSTR((acm001.insref),3,1) = "C" THEN
            nv_insref = "C".   /*Customer Type = Corperate */
         ELSE nv_insref = "P".   /*Customer Type = Personal */

         FIND FIRST xmm600 USE-INDEX xmm60001      WHERE 
                   xmm600.acno   =  acm001.agent  NO-LOCK  NO-ERROR  NO-WAIT.
         IF NOT AVAIL xmm600 THEN NEXT.
         ELSE DO:
            /*--- -- Aging Day ---*/
              IF xmm600.autoap = YES THEN DO:     /* -- Direct */
        
                 IF nv_insref = "P" THEN 
                     ASSIGN  nv_dir = "DiP"   /* CBC------------*/
                             nv_grptypdes = "บุคคลธรรมดา".
                 ELSE  ASSIGN nv_dir = "DiC"         /* ---------*/
                              nv_grptypdes = "นิติบุคคล".
              END.
              ELSE DO:              /* -- Broker */
                  IF nv_insref = "P" THEN 
                     ASSIGN nv_dir = "BrP"   /* -----------*/
                            nv_grptypdes = "บุคคลธรรมดา".
                  ELSE ASSIGN nv_dir = "BrC"     /* ---------*/    
                               nv_grptypdes = "นิติบุคคล".
              END.
             
         END.   /*end find first*/

      END.  /*end acm001*/

      nv_polgrp = nv_polgrp + nv_dir.

   END.   /* end xmm031.dept = "G" - Motor */
   /*---A55-0231---
   ELSE IF xmm031.dept = "M" THEN       /*Compulsory*/
      ASSIGN nv_polgrp = "CMP"
             nv_dir    = "CMP"
             nv_polgrp = nv_polgrp + nv_dir
             nv_grptypdes = "Compulsory". 
   -----------------*/             
   ELSE    /*Non-Motor*/
       ASSIGN nv_dir = "NON"
              nv_polgrp = "NON" 
              nv_polgrp = nv_polgrp + nv_dir
              nv_grptypdes = "Non Motor".  
END.   /* end xmm031*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpDataF1 C-Win 
PROCEDURE pdExpDataF1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    agtprm_fil.acno
                    agtprm_fil.ac_name
                    agtprm_fil.credit
                    agtprm_fil.trndat   FORMAT "99/99/9999"
                    agtprm_fil.trntyp 
                    "'" + agtprm_fil.docno
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat FORMAT "99/99/9999"
                    agtprm_fil.agent
                    n_insur          /* agtprm_fil.insure */
                    agtprm_fil.prem
                    agtprm_fil.prem_comp
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    agtprm_fil.gross
                    
                    agtprm_fil.comm
                    agtprm_fil.comm_comp
                    n_net
                    agtprm_fil.bal

                    n_veh           /* ทะเบียนรถ */
                    n_sckno         /* sticker no.*/
                    n_chano         /* เลขตัวถัง */
                    n_dealer
                    n_cedpol        /* leasing NO.*/
                    tt_paid         /* claim paid*/
                    tt_outres       /* o/s claim */
                    n_campol        /* campaign Pol.*/
                    SUBSTRING(agtprm_fil.poltyp,2,2)

                    agtprm_fil.duedat FORMAT "99/99/9999"
                    n_benname  /* A51-0203 */
                    /*---A53-0159---*/
                    SUBSTR(nv_polgrp,1,3)
                    SUBSTR(nv_dir,3,1).
                OUTPUT CLOSE.
                 /*----A53-0159---*/
            FIND FIRST wtagtprm_fil WHERE wtagtprm_fil.wtacno  = agtprm_fil.acno AND 
                              wtagtprm_fil.wtgrp = SUBSTR(nv_polgrp,1,3)  NO-ERROR.
                IF NOT AVAIL wtagtprm_fil THEN DO:
                    CREATE wtagtprm_fil.
                    ASSIGN wtagtprm_fil.wtacno  = agtprm_fil.acno 
                           wtagtprm_fil.wtgrp = SUBSTR(nv_polgrp,1,3).
                    ASSIGN 
                        wtagtprm_fil.wtprem        =      agtprm_fil.prem       
                        wtagtprm_fil.wtprem_comp   =      agtprm_fil.prem_comp  
                        wtagtprm_fil.wtstamp       =      agtprm_fil.stamp      
                        wtagtprm_fil.wttax         =      agtprm_fil.tax        
                        wtagtprm_fil.wtgross       =      agtprm_fil.gross      
                        wtagtprm_fil.wtcomm        =      agtprm_fil.comm      
                        wtagtprm_fil.wtcomm_comp   =      agtprm_fil.comm_comp  
                        wtagtprm_fil.wtnet         =      n_net                 
                        wtagtprm_fil.wtbal         =      agtprm_fil.bal        
                        wtagtprm_fil.wtwcr         =      n_wcr                 
                        wtagtprm_fil.wtdamt        =      n_damt                
                        wtagtprm_fil.wtodue        =      n_odue                
                        wtagtprm_fil.wtodue1       =      n_odue1               
                        wtagtprm_fil.wtodue2       =      n_odue2               
                        wtagtprm_fil.wtodue3       =      n_odue3               
                        wtagtprm_fil.wtodue4       =      n_odue4               
                        wtagtprm_fil.wtodue5       =      n_odue5               
                        wtagtprm_fil.wtodue6       =      n_odue6               
                        wtagtprm_fil.wtodue7       =      n_odue7               
                        wtagtprm_fil.wtodue8       =      n_odue8               
                        wtagtprm_fil.wtodue9       =      n_odue9.  
                END.
                ELSE DO:
                     ASSIGN 
                        wtagtprm_fil.wtprem        =    wtagtprm_fil.wtprem        +      agtprm_fil.prem       
                        wtagtprm_fil.wtprem_comp   =    wtagtprm_fil.wtprem_comp   +      agtprm_fil.prem_comp  
                        wtagtprm_fil.wtstamp       =    wtagtprm_fil.wtstamp       +      agtprm_fil.stamp      
                        wtagtprm_fil.wttax         =    wtagtprm_fil.wttax         +      agtprm_fil.tax        
                        wtagtprm_fil.wtgross       =    wtagtprm_fil.wtgross       +      agtprm_fil.gross      
                        wtagtprm_fil.wtcomm        =    wtagtprm_fil.wtcomm        +      agtprm_fil.comm      
                        wtagtprm_fil.wtcomm_comp   =    wtagtprm_fil.wtcomm_comp   +      agtprm_fil.comm_comp  
                        wtagtprm_fil.wtnet         =    wtagtprm_fil.wtnet         +      n_net                 
                        wtagtprm_fil.wtbal         =    wtagtprm_fil.wtbal         +      agtprm_fil.bal        
                        wtagtprm_fil.wtwcr         =    wtagtprm_fil.wtwcr         +      n_wcr                 
                        wtagtprm_fil.wtdamt        =    wtagtprm_fil.wtdamt        +      n_damt                
                        wtagtprm_fil.wtodue        =    wtagtprm_fil.wtodue        +      n_odue                
                        wtagtprm_fil.wtodue1       =    wtagtprm_fil.wtodue1       +      n_odue1               
                        wtagtprm_fil.wtodue2       =    wtagtprm_fil.wtodue2       +      n_odue2               
                        wtagtprm_fil.wtodue3       =    wtagtprm_fil.wtodue3       +      n_odue3               
                        wtagtprm_fil.wtodue4       =    wtagtprm_fil.wtodue4       +      n_odue4               
                        wtagtprm_fil.wtodue5       =    wtagtprm_fil.wtodue5       +      n_odue5               
                        wtagtprm_fil.wtodue6       =    wtagtprm_fil.wtodue6       +      n_odue6               
                        wtagtprm_fil.wtodue7       =    wtagtprm_fil.wtodue7       +      n_odue7               
                        wtagtprm_fil.wtodue8       =    wtagtprm_fil.wtodue8       +      n_odue8               
                        wtagtprm_fil.wtodue9       =    wtagtprm_fil.wtodue9       +      n_odue9.  
                END.
                
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExpDataF2 C-Win 
PROCEDURE pdExpDataF2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                    agtprm_fil.trndat
                    agtprm_fil.policy
                    agtprm_fil.endno
                    agtprm_fil.comdat
                    agtprm_fil.trntyp
                    "'" + agtprm_fil.docno
                    agtprm_fil.agent
                    n_insur          /* agtprm_fil.insure */
                    agtprm_fil.prem
                    agtprm_fil.prem_comp
                    agtprm_fil.stamp
                    agtprm_fil.tax
                    agtprm_fil.gross
                    agtprm_fil.comm + agtprm_fil.comm_comp
                    n_net          
                    agtprm_fil.bal 
                    n_veh
                    n_prnvat
                    agtprm_fil.acno
                /***** สิ้นสุด สำหรับตัดเบี้ย ***/
                    agtprm_fil.ac_name                        
                    n_sckno         /* sticker no.*/
                    n_expdat
                    n_chano 
                    n_moddes
                    agtprm_fil.polbran
                    agtprm_fil.acno_clicod
                    /*agtprm_fil.credit      ---by A55-0231*/
                    n_credittxt   /*A55-0231*/
                    agtprm_fil.duedat
                    agtprm_fil.asdat
                    /*---By A54-0270---
                    IF agtprm_fil.duedat >= TODAY THEN 0 ELSE TODAY - agtprm_fil.duedat /* overdue day */
                    ---------------*/
                    /*IF agtprm_fil.duedat >= n_trndatto THEN 0 ELSE n_trndatto - agtprm_fil.duedat /* overdue day */   /*---A54-0270---*/   A55-0231*/
                    IF agtprm_fil.duedat >= n_asdat THEN 0 ELSE n_asdat - agtprm_fil.duedat /* overdue day */
                    SUBSTRING(agtprm_fil.poltyp,2,2)
                    n_campol        /* campaign Pol.*/
                    n_dealer        /* dealer */
                    agtprm_fil.comm     
                    agtprm_fil.comm_comp
                    tt_paid         /* claim paid*/
                    tt_outres       /* o/s claim */
                    n_cedpol        /* leasing NO.*/
                    n_wcr   
                    n_damt  
                    n_odue  
                    n_odue1 
                    n_odue2 
                    n_odue3 
                    n_odue4 
                    n_odue5
                    n_odue6 
                    n_odue7 
                    n_odue8 
                    n_odue9
                    n_benname  /* A51-0203 */
                    /*---A53-0159---*/
                    SUBSTR(nv_polgrp,1,3)
                    SUBSTR(nv_dir,3,1).
                    OUTPUT CLOSE.
/* A48-0250 END ---*/

            /*----A53-0159---*/
            FIND FIRST wtagtprm_fil WHERE wtagtprm_fil.wtacno  = agtprm_fil.acno AND 
                              wtagtprm_fil.wtgrp = SUBSTR(nv_polgrp,1,3) NO-ERROR.
                IF NOT AVAIL wtagtprm_fil THEN DO:
                    CREATE wtagtprm_fil.
                    ASSIGN wtagtprm_fil.wtacno  = agtprm_fil.acno 
                           wtagtprm_fil.wtgrp = SUBSTR(nv_polgrp,1,3).
                    ASSIGN 
                        wtagtprm_fil.wtprem        =      agtprm_fil.prem       
                        wtagtprm_fil.wtprem_comp   =      agtprm_fil.prem_comp  
                        wtagtprm_fil.wtstamp       =      agtprm_fil.stamp      
                        wtagtprm_fil.wttax         =      agtprm_fil.tax        
                        wtagtprm_fil.wtgross       =      agtprm_fil.gross      
                        wtagtprm_fil.wtcomm        =      agtprm_fil.comm      
                        wtagtprm_fil.wtcomm_comp   =      agtprm_fil.comm_comp  
                        wtagtprm_fil.wtnet         =      n_net                 
                        wtagtprm_fil.wtbal         =      agtprm_fil.bal        
                        wtagtprm_fil.wtwcr         =      n_wcr                 
                        wtagtprm_fil.wtdamt        =      n_damt                
                        wtagtprm_fil.wtodue        =      n_odue                
                        wtagtprm_fil.wtodue1       =      n_odue1               
                        wtagtprm_fil.wtodue2       =      n_odue2               
                        wtagtprm_fil.wtodue3       =      n_odue3               
                        wtagtprm_fil.wtodue4       =      n_odue4               
                        wtagtprm_fil.wtodue5       =      n_odue5               
                        wtagtprm_fil.wtodue6       =      n_odue6               
                        wtagtprm_fil.wtodue7       =      n_odue7               
                        wtagtprm_fil.wtodue8       =      n_odue8               
                        wtagtprm_fil.wtodue9       =      n_odue9.  
                END.
                ELSE DO:
                     ASSIGN 
                        wtagtprm_fil.wtprem        =    wtagtprm_fil.wtprem        +      agtprm_fil.prem       
                        wtagtprm_fil.wtprem_comp   =    wtagtprm_fil.wtprem_comp   +      agtprm_fil.prem_comp  
                        wtagtprm_fil.wtstamp       =    wtagtprm_fil.wtstamp       +      agtprm_fil.stamp      
                        wtagtprm_fil.wttax         =    wtagtprm_fil.wttax         +      agtprm_fil.tax        
                        wtagtprm_fil.wtgross       =    wtagtprm_fil.wtgross       +      agtprm_fil.gross      
                        wtagtprm_fil.wtcomm        =    wtagtprm_fil.wtcomm        +      agtprm_fil.comm      
                        wtagtprm_fil.wtcomm_comp   =    wtagtprm_fil.wtcomm_comp   +      agtprm_fil.comm_comp  
                        wtagtprm_fil.wtnet         =    wtagtprm_fil.wtnet         +      n_net                 
                        wtagtprm_fil.wtbal         =    wtagtprm_fil.wtbal         +      agtprm_fil.bal        
                        wtagtprm_fil.wtwcr         =    wtagtprm_fil.wtwcr         +      n_wcr                 
                        wtagtprm_fil.wtdamt        =    wtagtprm_fil.wtdamt        +      n_damt                
                        wtagtprm_fil.wtodue        =    wtagtprm_fil.wtodue        +      n_odue                
                        wtagtprm_fil.wtodue1       =    wtagtprm_fil.wtodue1       +      n_odue1               
                        wtagtprm_fil.wtodue2       =    wtagtprm_fil.wtodue2       +      n_odue2               
                        wtagtprm_fil.wtodue3       =    wtagtprm_fil.wtodue3       +      n_odue3               
                        wtagtprm_fil.wtodue4       =    wtagtprm_fil.wtodue4       +      n_odue4               
                        wtagtprm_fil.wtodue5       =    wtagtprm_fil.wtodue5       +      n_odue5               
                        wtagtprm_fil.wtodue6       =    wtagtprm_fil.wtodue6       +      n_odue6               
                        wtagtprm_fil.wtodue7       =    wtagtprm_fil.wtodue7       +      n_odue7               
                        wtagtprm_fil.wtodue8       =    wtagtprm_fil.wtodue8       +      n_odue8               
                        wtagtprm_fil.wtodue9       =    wtagtprm_fil.wtodue9       +      n_odue9.  
                END.
                /*-------end A53-0159------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExportF1 C-Win 
PROCEDURE pdExportF1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

FOR EACH wtagtprm_fil:
    DELETE wtagtprm_fil.
END.
FOR EACH wtGagtprm_fil:
    DELETE wtGagtprm_fil.
END.


ASSIGN
    nv_gtot_prem  = 0
    nv_gtot_prem_comp = 0
    nv_gtot_stamp = 0
    nv_gtot_tax   = 0
    nv_gtot_gross = 0
    nv_gtot_comm  = 0
    nv_gtot_comm_comp = 0
    nv_gtot_net   = 0
    nv_gtot_bal   = 0
    nv_gtot_wcr   = 0
    nv_gtot_damt  = 0
    nv_gtot_odue1 = 0
    nv_gtot_odue2 = 0
    nv_gtot_odue3 = 0
    nv_gtot_odue4 = 0
    nv_gtot_odue5 = 0.
        
IF rsOutput = 3 THEN fiFile-Name = fiFile-Name.
                ELSE fiFile-Name = fiFile-Name2.

/********************** Page Header *********************/           
OUTPUT TO VALUE (STRING(fiFile-Name) ) NO-ECHO.
    IF vCount = 0 THEN DO:
    END.
OUTPUT CLOSE.
OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
      EXPORT DELIMITER ";"
            "Statment A4 : " + nv_repdetail.
 OUTPUT CLOSE.
/********************** END Page Header *********************/  

 nv_poltyp = "".

IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.

/********************** DETAIL  *********************/  
IF raReportTyp = 1 OR  raReportTyp = 2 OR  raReportTyp = 3 THEN DO:     /* A47-0142   ดึงข้อมูล เฉพาะ บาง  client type code */

    IF report-name = "Statement of Account By Trandate" THEN DO :
          /*--A53-0159--*/
      
       FOR EACH  agtprm_fil USE-INDEX by_acno   WHERE
                 agtprm_fil.asdat       = n_asdat  AND
                (agtprm_fil.acno       >= n_frac   AND agtprm_fil.acno     <= n_toac  )      AND
                (agtprm_fil.polbran    >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
                (LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                (LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 ) NO-LOCK 
               BREAK BY agtprm_fil.acno
                     BY agtprm_fil.trndat
                     BY agtprm_fil.policy
                     BY agtprm_fil.endno
                     BY agtprm_fil.docno . 
           
           
            IF FIRST-OF(agtprm_fil.acno)  THEN  RUN pdGrpHeader.

             DISP  /*agtprm_fil.acno-- A500178 --*/
                         agtprm_fil.acno   FORMAT "X(10)"
                         agtprm_fil.trndat
                         agtprm_fil.policy
                         agtprm_fil.trntyp
                         agtprm_fil.docno
                    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess10 VIEW-AS DIALOG-BOX
                    TITLE  "  Processing ...".
        /*-- end A53-0159 --*/

             {wac\wacr12f1.i}
              
    END. /* for each agtprm_fil*/

END.  /*  By Trandate */
ELSE DO:  /* report-name = "Statement of Account By Policy" */
/*--A53-0159--*/
  FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat    = n_asdat    AND
             (agtprm_fil.acno    >= n_frac     AND agtprm_fil.acno    <= n_toac  )   AND
             (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
             (agtprm_fil.polbran >= n_branch   AND agtprm_fil.polbran <= n_branch2 ) AND
             ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
             ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 ) NO-LOCK 
      BREAK BY agtprm_fil.asdat
            BY agtprm_fil.acno
            BY agtprm_fil.poltyp
            BY agtprm_fil.policy
            BY agtprm_fil.endno. 
  

        IF FIRST-OF(agtprm_fil.acno)  THEN  RUN pdGrpHeader.

             DISP  /*agtprm_fil.acno-- A500178 --*/
                         agtprm_fil.acno   FORMAT "X(10)"
                         agtprm_fil.trndat
                         agtprm_fil.policy
                         agtprm_fil.trntyp
                         agtprm_fil.docno
                    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess11p VIEW-AS DIALOG-BOX
                    TITLE  "  Processing ...".
        /*-- end A53-0159 --*/

             {wac\wacr12f1.i}

    END. /* for each agtprm_fil*/   

END. /* By Policy */

END.
ELSE DO:     /* ดึงข้อมูล ทุก client type code */

IF report-name = "Statement of Account By Trandate" THEN DO :
   /*--A53-0159--*/
   FOR EACH agtprm_fil USE-INDEX by_acno            WHERE
            agtprm_fil.asdat    = n_asdat  AND
            (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac )    AND
            (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
            (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
            ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) NO-LOCK
   BREAK BY agtprm_fil.acno
         BY agtprm_fil.trndat
         BY agtprm_fil.policy
         BY agtprm_fil.endno.
         
            IF FIRST-OF(agtprm_fil.acno)  THEN  RUN pdGrpHeader.

             DISP  /*agtprm_fil.acno-- A500178 --*/
                         agtprm_fil.acno   FORMAT "X(10)"
                         agtprm_fil.trndat
                         agtprm_fil.policy
                         agtprm_fil.trntyp
                         agtprm_fil.docno
                    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess12 VIEW-AS DIALOG-BOX
                    TITLE  "  Processing ...".
        /*-- end A53-0159 --*/

             {wac\wacr12f1.i}
          END.  /*each agtprm_fil*/
            
       
END.  /*  By Trandate */
ELSE DO: /* report-name = "Statement of Account By Policy" */
     /*--A53-0159--*/
  FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
              agtprm_fil.asdat    = n_asdat  AND
             (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
             (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
             (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
             ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) NO-LOCK
       BREAK BY agtprm_fil.asdat
             BY agtprm_fil.acno
             BY agtprm_fil.poltyp
             BY agtprm_fil.policy
             BY agtprm_fil.endno. 

        IF FIRST-OF(agtprm_fil.acno)  THEN  RUN pdGrpHeader.

             DISP  /*agtprm_fil.acno-- A500178 --*/
                         agtprm_fil.acno   FORMAT "X(10)"
                         agtprm_fil.trndat
                         agtprm_fil.policy
                         agtprm_fil.trntyp
                         agtprm_fil.docno
                    WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess12p VIEW-AS DIALOG-BOX
                    TITLE  "  Processing ...".
        /*-- end A53-0159 --*/

             {wac\wacr12f1.i}

    END. /* for each agtprm_fil*/


END. /* By Policy */
    
END.
/********************** END DETAIL  *********************/

/********************** Page Footer *********************/
OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
        EXPORT DELIMITER ";"
            "".
        EXPORT DELIMITER ";"
            "GRAND TOTAL : "
            " "    " "   " "     " " 
            " "    " "   " "   " "
            ""  ""
            nv_gtot_prem
            nv_gtot_prem_comp
            nv_gtot_stamp
            nv_gtot_tax
            nv_gtot_gross
            nv_gtot_comm
            nv_gtot_comm_comp
            nv_gtot_net
            nv_gtot_bal.

OUTPUT CLOSE.
/*---A53-0159---*/
                FOR EACH wtGagtprm_fil NO-LOCK BREAK BY wtGagtprm_fil.wtGgrp.
                    OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                     "GRAND TOTAL : " +  wtGagtprm_fil.wtGgrp
                     " "    " "   " "     " " 
                     " "    " "   " "   " "
                     ""  ""
                    wtGagtprm_fil.wtGprem      
                    wtGagtprm_fil.wtGprem_comp 
                    wtGagtprm_fil.wtGstamp     
                    wtGagtprm_fil.wtGtax       
                    wtGagtprm_fil.wtGgross     
                    wtGagtprm_fil.wtGcomm    
                    wtGagtprm_fil.wtGcomm_comp 
                    wtGagtprm_fil.wtGnet       
                    wtGagtprm_fil.wtGbal.
                OUTPUT CLOSE.
                END.
     

          
END PROCEDURE.

/***
    EXPORT DELIMITER ";"
        "รหัสตัวแทน"    "ชื่อ" "เครดิต" "วันที่  " "วันครบกำหนด" "เลขที่ใบแจ้งหนี้ " "กรมธรรม์" "สลักหลัง" "วันเริ่มคุ้มครอง"  "ชื่อผู้เอาประกัน "
        "เบี้ยประกัน"  "พ.ร.บ. "   "อากร"  "ภาษี"   "ยอดรวม"  "ค่านายหน้า"  "ค่านายหน้า พรบ." "ยอดรวม หัก ค่านายหน้า(รวม)" "ยอดค้างชำระ".  
***/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdExportF2 C-Win 
PROCEDURE pdExportF2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR  vCount AS INT INIT 0.
DEF VAR  i AS INT.

FOR EACH wtagtprm_fil:
    DELETE wtagtprm_fil.
END.
FOR EACH wtGagtprm_fil:
    DELETE wtGagtprm_fil.
END.

ASSIGN
    nv_gtot_prem    = 0
    nv_gtot_prem_comp = 0
    nv_gtot_stamp   = 0
    nv_gtot_tax     = 0
    nv_gtot_gross   = 0
    nv_gtot_comm    = 0
    nv_gtot_comm_comp = 0
    nv_gtot_net     = 0
    nv_gtot_bal     = 0

    nv_gtot_wcr     = 0
    nv_gtot_damt    = 0
    nv_gtot_odue    = 0
    
    nv_gtot_odue1   = 0
    nv_gtot_odue2   = 0
    nv_gtot_odue3   = 0
    nv_gtot_odue4   = 0
    nv_gtot_odue5   = 0
    nv_gtot_odue6   = 0
    nv_gtot_odue7   = 0
    nv_gtot_odue8   = 0
    nv_gtot_odue9   = 0.

    IF rsOutput = 3 THEN fiFile-Name = fiFile-Name.
    ELSE fiFile-Name = fiFile-Name2.
    
/********************** Page Header *********************/    
        OUTPUT TO VALUE (STRING(fiFile-Name) ) NO-ECHO.
            IF vCount = 0 THEN DO:
            END.
        OUTPUT CLOSE.

         OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
             
                EXPORT DELIMITER ";" 
                    "Statment A4 (File for FN Full): " + nv_repdetail.
          OUTPUT CLOSE.
/********************** END Page Header *********************/  

nv_poltyp = "".

IF rstype = 1 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept = "M" OR 
                                   xmm031.dept = "G" 
     BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
 END.
 ELSE IF rstype = 2 THEN DO:
    FOR EACH xmm031 NO-LOCK WHERE xmm031.dept <> "M" OR 
                                  xmm031.dept <> "G" 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END.
END.
ELSE DO:
    FOR EACH xmm031 NO-LOCK 
    BREAK BY xmm031.poltyp:
        IF nv_poltyp = "" THEN ASSIGN nv_poltyp = xmm031.poltyp.
        ELSE ASSIGN nv_poltyp = nv_poltyp + "," + xmm031.poltyp .
    END. 

END.

/********************** DETAIL  *********************/  
 IF raReportTyp = 1 OR  raReportTyp = 2 OR  raReportTyp = 3 THEN DO:     /* A47-0142   ดึงข้อมูล เฉพาะ บาง  client type code */

     IF report-name = "Statement of Account By Trandate" THEN DO :

        /*--A53-0159--*/
         
         FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                   agtprm_fil.asdat    = n_asdat  AND
                  (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                  (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)   AND
                  (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                  ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                  ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 )
              NO-LOCK
             BREAK BY agtprm_fil.acno
                    BY agtprm_fil.trndat
                    BY agtprm_fil.poltyp  /*--A53-0159--*/
                    BY agtprm_fil.policy
                    BY agtprm_fil.endno
                    BY agtprm_fil.docno.
             
             RUN pdmDay.
         

            IF FIRST-OF(agtprm_fil.acno)  THEN   /**/
               RUN pdGrpHeaderF2.

             DISP  /*agtprm_fil.acno-- A500178 --*/
                  agtprm_fil.acno   FORMAT "X(10)"
                  agtprm_fil.trndat
                  agtprm_fil.policy
                  agtprm_fil.trntyp
                  agtprm_fil.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess20 VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".
        /*-- end A53-0159 --*/
            

            {wac\wacr12f2.i}

        END. /* for each agtprm_fil*/
             
    END.  /*  By Trandate */
    ELSE DO: /* report-name = "Statement of Account By Policy" */
     /*--A53-0159--*/
         FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                  agtprm_fil.asdat   = n_asdat   AND
                 (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                 (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
                 (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                 ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) AND
                 ( LOOKUP (agtprm_fil.acno_clicod, vCliCod) <> 0 ) NO-LOCK 
             BREAK BY agtprm_fil.asdat
                   BY agtprm_fil.acno
                   BY agtprm_fil.poltyp
                   BY agtprm_fil.policy
                   BY agtprm_fil.endno. 
             
             RUN pdmDay.

             IF FIRST-OF(agtprm_fil.acno)  THEN   /**/
                RUN pdGrpHeaderF2.

            DISP  /*agtprm_fil.acno-- A500178 --*/
                  agtprm_fil.acno   FORMAT "X(10)"
                  agtprm_fil.trndat
                  agtprm_fil.policy
                  agtprm_fil.trntyp
                  agtprm_fil.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess21p VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".
        /*-- end A53-0159 --*/

            {wac\wacr12f2.i}
                
          END. /* for each agtprm_fil*/
                      
     END. /* By Policy */
 END.
 
 ELSE DO:     /* ดึงข้อมูล ทุก client type code */

    IF report-name = "Statement of Account By Trandate" THEN DO :

       /*--A53-0159--*/
       
       FOR EACH agtprm_fil USE-INDEX by_acno            WHERE
             agtprm_fil.asdat   = n_asdat   AND 
            (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
            (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
            (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
            ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) NO-LOCK
            BREAK BY agtprm_fil.acno
                  BY agtprm_fil.trndat
                  BY agtprm_fil.policy
                  BY agtprm_fil.endno.

           RUN pdmDay.

           IF FIRST-OF(agtprm_fil.acno)  THEN   /**/
              RUN pdGrpHeaderF2.
           
             DISP  /*agtprm_fil.acno-- A500178 --*/
                  agtprm_fil.acno   FORMAT "X(10)"
                  agtprm_fil.trndat
                  agtprm_fil.policy
                  agtprm_fil.trntyp
                  agtprm_fil.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess24 VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".
        /*-- end A53-0159 --*/

            {wac\wacr12f2.i}
       END.   /* for each agtprm_fil*/
           
 END.  /*  By Trandate */
 ELSE DO: /* report-name = "Statement of Account By Policy" */
          /*--A53-0159--*/
           FOR EACH  agtprm_fil USE-INDEX by_acno            WHERE
                   agtprm_fil.asdat   = n_asdat   AND
                  (agtprm_fil.acno    >= n_frac   AND agtprm_fil.acno    <= n_toac  )   AND
                  (LOOKUP(agtprm_fil.poltyp,nv_poltyp) <> 0)    AND
                  (agtprm_fil.polbran >= n_branch AND agtprm_fil.polbran <= n_branch2 ) AND
                  ( LOOKUP (SUBSTRING(agtprm_fil.trntyp,1,1) , nv_trntyp1) <> 0 ) NO-LOCK 
              BREAK BY agtprm_fil.asdat
                     BY agtprm_fil.acno
                     BY agtprm_fil.poltyp
                     BY agtprm_fil.policy
                     BY agtprm_fil.endno. 

               RUN pdmDay.

               IF FIRST-OF(agtprm_fil.acno)  THEN   /**/
              RUN pdGrpHeaderF2.
           
             DISP  /*agtprm_fil.acno-- A500178 --*/
                  agtprm_fil.acno   FORMAT "X(10)"
                  agtprm_fil.trndat
                  agtprm_fil.policy
                  agtprm_fil.trntyp
                  agtprm_fil.docno
            WITH COLOR BLACK/WHITE NO-LABEL FRAME frProcess25 VIEW-AS DIALOG-BOX
            TITLE  "  Processing ...".
        /*-- end A53-0159 --*/

            {wac\wacr12f2.i}

           END.   /* for each agtprm_fil*/

     END. /* By Policy */

 END.   /*else do*/
 
/********************** Page Footer *********************/
     OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
             EXPORT DELIMITER ";"
                 "".    
             /*--- A48-0250 */
             EXPORT DELIMITER ";"
                 "GRAND TOTAL : "
                 ""  ""  ""  ""  ""
                 ""  ""   
                 nv_gtot_prem      
                 nv_gtot_prem_comp 
                 nv_gtot_stamp     
                 nv_gtot_tax       
                 nv_gtot_gross     
                 nv_gtot_comm + nv_gtot_comm_comp 
                 nv_gtot_net       
                 nv_gtot_bal       
                 ""  ""

                 ""  ""  ""  ""  ""  ""  ""  ""  ""  ""    
                 ""  ""  ""  ""  ""  ""  ""  ""  ""  "" 

                 nv_gtot_wcr   
                 nv_gtot_damt  
                 nv_gtot_odue  

                 nv_gtot_odue1 
                 nv_gtot_odue2 
                 nv_gtot_odue3 
                 nv_gtot_odue4 
                 nv_gtot_odue5
                 nv_gtot_odue6 
                 nv_gtot_odue7
                 nv_gtot_odue8 
                 nv_gtot_odue9.
                 
/*A48-0250 END. ---*/
     OUTPUT CLOSE.

     /*---A53-0159---*/
                FOR EACH wtGagtprm_fil NO-LOCK BREAK BY wtGagtprm_fil.wtGgrp.
                    OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                     "GRAND TOTAL : " +  wtGagtprm_fil.wtGgrp
                     ""  ""  ""  ""  ""
                     ""  ""   
                    wtGagtprm_fil.wtGprem      
                    wtGagtprm_fil.wtGprem_comp 
                    wtGagtprm_fil.wtGstamp     
                    wtGagtprm_fil.wtGtax       
                    wtGagtprm_fil.wtGgross     
                    wtGagtprm_fil.wtGcomm    + wtGagtprm_fil.wtGcomm_comp 
                    wtGagtprm_fil.wtGnet       
                    wtGagtprm_fil.wtGbal       
                    ""  "" 

                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""    
                    ""  ""  ""  ""  ""  ""  ""  ""  ""  ""
                    wtGagtprm_fil.wtGwcr      
                    wtGagtprm_fil.wtGdamt     
                    wtGagtprm_fil.wtGodue     
                    wtGagtprm_fil.wtGodue1    
                    wtGagtprm_fil.wtGodue2    
                    wtGagtprm_fil.wtGodue3    
                    wtGagtprm_fil.wtGodue4    
                    wtGagtprm_fil.wtGodue5    
                    wtGagtprm_fil.wtGodue6    
                    wtGagtprm_fil.wtGodue7    
                    wtGagtprm_fil.wtGodue8    
                    wtGagtprm_fil.wtGodue9    
                    .
                OUTPUT CLOSE.
                END.
     

/********************** Page Footer *********************/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdGrpHeader C-Win 
PROCEDURE pdGrpHeader :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/********************** Group Header *********************/    
/*---A48-0250
                EXPORT DELIMITER ";"
                    "Acno : " + agtprm_fil.acno
                    agtprm_fil.ac_name
                    "Credit day : " +  STRING(agtprm_fil.credit)
                    "Credit Limit " + STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99")    /*xmm600.ltamt   Credit Limit*/
                    agtprm_fil.acno_clicod
                    "Type : " + agtprm_fil.type.
A48-0250---*/
               OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
                EXPORT DELIMITER ";"
                            /*"Statment A4 : " + nv_repdetail.*/
                    "".

                 EXPORT DELIMITER ";"
                     "Account No."  " Name  " "Credit"  "Trans Date"   "Tran Type" "Doc No."  " Policy No."  " Endt No."  "Com Date "  
                     "Agent " "Insured Name "
                     "Premium"  "Compulsory"  "Stamp"  "Tax"  "Total"  "Comm"  "Comm comp"  "Net amount" "Balance O/S"
                     "Vehicle Reg."  "Sticker No."  "Chassis No." "Dealer" "Leasing No."  "Claim Paid"  "O/S Claim" "Campaign Pol"  "Pol Type"
                     "Due Date"  
                     "Benificiary name"   /*A51-0203*/
                     "Group"              /*A53-0159*/
                     "Customer Type"      /*A53-0159*/
                     .
                 OUTPUT CLOSE.
                    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdGrpHeaderF2 C-Win 
PROCEDURE pdGrpHeaderF2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/********************** Group Header *********************/    
        OUTPUT TO VALUE (STRING(fiFile-Name) ) APPEND NO-ECHO.
             
                EXPORT DELIMITER ";" 
                    "".
                    

                EXPORT DELIMITER ";"
                    "Acno : " + agtprm_fil.acno
                    agtprm_fil.ac_name
                    "Credit day : " +  STRING(agtprm_fil.credit)
                    "Credit Limit " + STRING(agtprm_fil.odue6,"->>>,>>>,>>>,>>9.99")    /*xmm600.ltamt   Credit Limit*/
                    agtprm_fil.acno_clicod
                    "Type : " + agtprm_fil.type.

                EXPORT DELIMITER ";"
                    "Trans Date  "      
                    "Policy      "      
                    "Endt No.    "      
                    "Com Date    "      
                    "Tran type   "      
                    "Doc No.     "      
                    "Agent       "      
                    "Customer    " 

                    "Premium     "      
                    "Compulsory  "     
                    "Stamp       "     
                    "Tax         "     
                    "Total       "     
                    "Comm  "     
                    "Net Amount  "     
                    "Balance O/S "     
                    "Vehicle Reg."     
                    "Print Vat   "     
                    "Producer       "  
                 /***** สิ้นสุด สำหรับตัดเบี้***/

                    "Producer Name  "  
                    "Sticker No.    "  
                    "Exp Date       "
                    "Chassis No.    "  
                    "Model Desc     "  
    
                    "Pol Bran      "  
                    "Producer Type  "  
                    "Credit Term    "  
                    "Due Date       "  
                    "As Date        "  
                    "Overdue Day    "  
                    "Pol Type       "  
                    "Campaign Pol   "  
                    "Dealer         "  
                    "Comm Motor     "  
                    "Comm Compulsory"  
                    "Claim Paid     "  
                    "O/S Claim      "  
                    
                    "Leasing No.    "  
                    "Within"  "Due amount "  "Overdue"  
                    "1-15 days"  "16-30 days"  "31-45 days"  "46-60 days"  "61-90 days"
                    "91-180 days"  "181-270 days"  "271-365 days"  "over 365 days" 
                    "Benificiary name"  /* A51-0203 */ 
                    "Group"              /*A53-0159*/
                    "Customer Type"      /*A53-0159*/
                    .
                OUTPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdInitData C-Win 
PROCEDURE pdInitData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch  = xmm023.branch
                fibdes     = xmm023.bdes.
             DISP fiBranch fibdes .
         END.
    END.     

FIND Last  xmm023 NO-ERROR.
    IF AVAIL xmm023  THEN  DO:
        DO WITH FRAME frST :
            ASSIGN 
                fiBranch2  = xmm023.branch
                fibdes2     = xmm023.bdes.
             DISP fiBranch2 fibdes2 .
         END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdmDay C-Win 
PROCEDURE pdmDay :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST xmm031 WHERE xmm031.poltyp = agtprm_fil.poltyp NO-LOCK NO-ERROR.
IF AVAIL xmm031 THEN DO:

   IF xmm031.dept = "G" OR xmm031.dept = "M" THEN    /*Motor*/
      mday = 15.
   ELSE mday = 0.
   
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdOutput C-Win 
PROCEDURE pdOutput :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       - Add by A53-0159 move from Triggers-btn_OK เนื่องจาก source code เต็ม
               - แยก Print งาน Motor และ Non Motor
------------------------------------------------------------------------------*/
/******************/
            IF rsOutput = 1 OR  rsOutput = 2 THEN DO:     /* report builder */
               IF raReportTyp = 1 OR  raReportTyp = 2 OR  raReportTyp = 3 THEN DO:    /*--AG/BR , FI/Dealer, LS--*/
                       IF n_type = "Motor" THEN DO:   /*---By A53-0159---*/
                          RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                          STRING (MONTH (n_asdat)) + "/" + 
                                          STRING (DAY (n_asdat)) + "/" + 
                                          STRING (YEAR (n_asdat)) + 
                                          " AND " + 
                                          "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                          "agtprm_fil.acno <= '" + n_toac + "'" +
                                          " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +    /*A53-0159*/
                                          " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                          "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                          "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                          " AND ( " + nv_filter1 + " )".    /* trntyp */
                       END. /*--end Motor--*/
                       ELSE DO:
                         IF n_type = "Non" THEN DO: 
                            /*---Non---*/
                            RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                             STRING (MONTH (n_asdat)) + "/" + 
                                             STRING (DAY (n_asdat)) + "/" + 
                                             STRING (YEAR (n_asdat)) + 
                                             " AND " + 
                                             "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                             "agtprm_fil.acno <= '" + n_toac + "'" +
                                             " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  /*A53-0159*/
                                             " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                             "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                             "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                             " AND ( " + nv_filter1 + " )".    /* trntyp */
                         END.   /*--end non--*/
                         ELSE DO:   /*ALL*/
                            
                             /*---Non---*/
                            RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                             STRING (MONTH (n_asdat)) + "/" + 
                                             STRING (DAY (n_asdat)) + "/" + 
                                             STRING (YEAR (n_asdat)) + 
                                             " AND " + 
                                             "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                             "agtprm_fil.acno <= '" + n_toac + "'" +
                                             " AND ( " + nv_filter2 + " )" +  " AND " +   /* client type */
                                             "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                             "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                             " AND ( " + nv_filter1 + " )".    /* trntyp */

                         END.   /*--end all--*/
                       END.  /*---else do---*/
                    END.     /* end raReportTyp  */

                    ELSE DO:  /*raReportTyp = ALL*/
                        IF n_type = "Motor" THEN DO:   /*---By A53-0159---*/
                            RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                            STRING (MONTH (n_asdat)) + "/" + 
                                            STRING (DAY (n_asdat)) + "/" + 
                                            STRING (YEAR (n_asdat)) + 
                                            " AND " + 
                                            "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                            "agtprm_fil.acno <= '" + n_toac + "'" +
                                            " AND (" + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +    /*A53-0159*/
                                            " AND " +
                                            "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                            "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                            " AND ( " + nv_filter1 + " )".
                        END.
                        ELSE DO:
                            IF n_type = "Non" THEN DO:
                               RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                            STRING (MONTH (n_asdat)) + "/" + 
                                            STRING (DAY (n_asdat)) + "/" + 
                                            STRING (YEAR (n_asdat)) + 
                                            " AND " + 
                                            "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                            "agtprm_fil.acno <= '" + n_toac + "'" +
                                            " AND ( not " + "agtprm_fil.poltyp BEGINS '" + "V7" + "' ) " +  /*A53-0159*/
                                            " AND " +
                                            "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                            "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                            " AND ( " + nv_filter1 + " )".
                            END. /*--end non--*/
                            ELSE DO:
                                RB-FILTER    = 'agtprm_fil.asdat = ' + 
                                            STRING (MONTH (n_asdat)) + "/" + 
                                            STRING (DAY (n_asdat)) + "/" + 
                                            STRING (YEAR (n_asdat)) + 
                                            " AND " + 
                                            "agtprm_fil.acno >= '" + n_frac + "'" + " AND " + 
                                            "agtprm_fil.acno <= '" + n_toac + "'" +
                                            " AND " +
                                            "agtprm_fil.polbran >= '" + n_branch   + "'" + " AND " + 
                                            "agtprm_fil.polbran <= '" + n_branch2 + "'" +
                                            " AND ( " + nv_filter1 + " )".
                                
                            END.   /*end All*/
                        END.   /*end else do*/
                    END.  /*---end raReportTyp = All---*/

                    ASSIGN
                        /* RB-DB-CONNECTION  = "-H alpha4 -S stat" +  " -U " + nv_user + " -P " + nv_pwd */
                         /*RB-DB-CONNECTION  = "-H brpy -S stattest" +  " -U " + nv_user + " -P " + nv_pwd */
                        
                        RB-INCLUDE-RECORDS = "O"
        
                        RB-PRINT-DESTINATION = SUBSTR ("D A", rsOutput, 1)
                        RB-PRINTER-NAME     = IF rsOutput = 2 THEN cbPrtList ELSE " "
                        RB-OUTPUT-FILE      = IF rsOutput = 3 THEN fiFile-Name ELSE " "
                        RB-NO-WAIT          = No
                        RB-OTHER-PARAMETERS =  "rb_vCliCod     = " + STRING(vCliCod) + CHR(10) +  
                                               "rb_n_trndatto  = " + STRING(n_trndatto,"99/99/9999") + CHR(10) +
                                               "rb_pich        = " + nv_a4a_07.  /*ADD Saharat S. A62-0279*/

                    IF rsOutput = 1 OR rsOutput = 2 THEN DO:
                        ASSIGN
                            report-library = "wAC/wprl/wac_sm01.prl"
                            report-name  = cbRptList.

                        RUN pdRunRB.
                        
                    END.
            END.
            ELSE IF rsOutput = 3 THEN DO:   /* to excel  for FN*/
            /* A46-0019   report-bulider 
                ASSIGN
                    report-library = "wAC/wprl/wac_sm04.prl"
                    report-name  = "Statement By Trandate to Excel".
                RUN pdRunRB.
            */
                    RUN pdExportF1.
            END.
            ELSE IF rsOutput = 4 THEN DO:  /* to excel  for FN Full */
                    RUN pdExportF2.
            END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdRunRB C-Win 
PROCEDURE pdRunRB :
/*------------------------------------------------------------------------------
  Purpose:     record
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
            RUN aderb\_printrb(report-library, 
                           report-name,
                           RB-DB-CONNECTION,
                           RB-INCLUDE-RECORDS,
                           RB-FILTER,
                           RB-MEMO-FILE,
                           RB-PRINT-DESTINATION,
                           RB-PRINTER-NAME,
                           RB-PRINTER-PORT,
                           RB-OUTPUT-FILE,
                           RB-NUMBER-COPIES,
                           RB-BEGIN-PAGE,
                           RB-END-PAGE,
                           RB-TEST-PATTERN,
                           RB-WINDOW-TITLE,
                           RB-DISPLAY-ERRORS,
                           RB-DISPLAY-STATUS,
                           RB-NO-WAIT,
                           RB-OTHER-PARAMETERS).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdSym100 C-Win 
PROCEDURE pdSym100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  vCliCodAll = "" .
  FOR EACH sym100 USE-INDEX sym10001  WHERE sym100.tabcod = "U021"  :
        vCliCodAll = vCliCodAll + sym100.itmcod  + ",".
  END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pdUpdateQ C-Win 
PROCEDURE pdUpdateQ :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY brAcproc_fil
    FOR EACH Acproc_fil  WHERE (acproc_fil.type = "01" OR acproc_fil.type = "05" ) AND
             SUBSTRING(acProc_fil.enttim,10,3) <>  "NO"
             BY acproc_fil.asdat DESC  .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetPrtList C-Win 
PROCEDURE ProcGetPrtList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  def var printer-list  as character no-undo.
  def var port-list     as character no-undo.
  def var printer-count as integer no-undo.
  def var printer       as character no-undo format "x(32)".
  def var port          as character no-undo format "x(20)".

  run aderb/_prlist.p (output printer-list, output port-list,
                 output printer-count).

  ASSIGN
    cbPrtList:List-Items IN FRAME frOutput = printer-list
    cbPrtList = ENTRY (1, printer-list).
    
  DISP cbPrtList WITH FRAME frOutput.
  RB-PRINTER-NAME = cbPrtList:SCREEN-VALUE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ProcGetRptList C-Win 
PROCEDURE ProcGetRptList :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR report-list   AS CHARACTER.
DEF VAR report-count  AS INTEGER.
DEF VAR report-number AS INTEGER.

  RUN _getname (SEARCH (report-library), OUTPUT report-list,        /* aderb/_getname.p */
    OUTPUT report-count).
  
  IF report-count = 0 THEN RETURN NO-APPLY.

  DO WITH FRAME frST :
        ASSIGN
          cbRptList:List-Items = report-list
          report-number = LOOKUP (report-name,report-list)
          cbRptList     = IF report-number > 0 THEN ENTRY (report-number,report-list)
                                  ELSE ENTRY (1, report-list).    
  
       DISP cbRptList . 
  END.
  
/*     message  "cbRptList" report-library  skip (1) 
 *                  cbRptList view-as alert-box.*/
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuLeapYear C-Win 
FUNCTION fuLeapYear RETURNS LOGICAL
  ( /* parameter-definitions */ y AS int) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR vLeapYear  AS LOGICAL.

vLeapYear = IF (y MOD 4 = 0) AND ((y MOD 100 <> 0) OR (y MOD 400 = 0)) 
                       THEN True ELSE False.


  RETURN vLeapYear.   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuMaxday C-Win 
FUNCTION fuMaxday RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR tday        AS INT FORMAT "99".
DEF VAR tmon       AS INT FORMAT "99".
DEF VAR tyear      AS INT FORMAT "9999".
DEF VAR maxday AS INT FORMAT "99".
  
ASSIGN 
                tday = DAY(vDate)
               tmon = MONTH(vDate)
               tyear = YEAR(vDate).
               /*  ให้ค่าวันที่สูงสุดของเดือนแก่ตัวแปร*/
               maxday = DAY(     DATE(tmon,28,tyear) + 4  - DAY(DATE(tmon,28,tyear) + 4)    ).
               
               
  RETURN maxday .   /* Function return value.  MaxDay*/

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumMonth C-Win 
FUNCTION fuNumMonth RETURNS INTEGER
  (INPUT vMonth AS INT ,vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  fuNumMonth
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF vMonth = 1   OR  vMonth = 3    OR
        vMonth = 5   OR  vMonth = 7    OR
        vMonth = 8   OR  vMonth = 10   OR
        vMonth = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  vMonth = 4   OR  vMonth = 6    OR
         vMonth = 9   OR  vMonth = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  vMonth = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fuNumYear C-Win 
FUNCTION fuNumYear RETURNS INTEGER
  (INPUT vDate AS DATE ) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
  DEF VAR vNum AS INT.
  ASSIGN  vNum = 0.
  
    IF  MONTH(vDate) = 1   OR  MONTH(vDate) = 3    OR
        MONTH(vDate) = 5   OR  MONTH(vDate) = 7    OR
        MONTH(vDate) = 8   OR  MONTH(vDate) = 10   OR
        MONTH(vDate) = 12 THEN DO:
        ASSIGN
            vNum = 31.       
        
   END.
   
    IF  MONTH(vDate) = 4   OR  MONTH(vDate) = 6    OR
         MONTH(vDate) = 9   OR  MONTH(vDate) = 11   THEN DO:
        ASSIGN
            vNum = 30.          
   
   END.     
   
   IF  MONTH(vDate) = 2 THEN DO:
        IF fuLeapYear(YEAR(vDate)) = TRUE THEN vNum = 29. ELSE vNum = 28. 
   END.

  RETURN vNum .   /* Function return value. */

END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

