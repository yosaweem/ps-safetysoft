&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: wgwkksen.w

  Description: Export Data Issue policy send to KK

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author:  

  Created: Ranu I. A63-0230 date:20/05/2020

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.
/* ***************************  Definitions  **************************  */
/* Modify By : Ranu I. A63-0299 เพิ่มการดึงข้อมูลสลักหลัง                */
/* Modify By : Kridtiya i.A63-00472 Date. 01/01/2021 เพิ่ม สาขา ML       */
/* Modify By : Tontawan S. A64-0104 01/03/2021 
               แก้ไขจาก 1.5% เป็น 3% // trnty1  = "R"                    */
/*-----------------------------------------------------------------------*/
/* Parameters Definitions ---                                            */

/* Local Variable Definitions ---                                        */

DEF  SHARED VAR n_User     AS  CHAR.
DEF  SHARED VAR n_PassWd   AS  CHAR.

DEFINE VAR   n_hptyp1        AS CHAR.
DEFINE VAR   n_hpDestyp1     AS CHAR.

DEF VAR nv_branchfr AS CHAR FORMAT "x(2)" INIT "".
DEF VAR nv_branchto AS CHAR FORMAT "x(2)" INIT "".
DEF VAR nv_poltypfr AS CHAR FORMAT "x(3)" INIT "".
DEF VAR nv_poltypto AS CHAR FORMAT "x(3)" INIT "".
DEF VAR nv_acno     AS CHAR FORMAT "x(10)".
DEF VAR nv_agent    AS CHAR FORMAT "x(10)".
DEF VAR nv_trndatfr AS DATE FORMAT "99/99/9999" INIT ?.
DEF VAR nv_trndatto AS DATE FORMAT "99/99/9999" INIT ?.
DEF NEW SHARED VAR nv_output   AS CHAR FORMAT "X(50)" INIT "".


DEF VAR nv_runno    AS INTE FORMAT "9999"  INIT 0. 
DEF VAR nv_date     AS DATE .

/***--- Note Variable ---***/

DEF VAR nvw_fptr        AS RECID.
DEF Var nv_fptr         As RECID   Initial    0.
DEF Var nv_bptr         As RECID   Initial    0.
/*
DEF VAR nv_doddis       AS DECI FORMAT ">>>>>>>9.99-".
DEF VAR nv_do2dis       AS DECI FORMAT ">>>>>>>9.99-".
DEF VAR nv_dpddis       AS DECI FORMAT ">>>>>>>9.99-".
DEF VAR nv_fltdis       AS DECI FORMAT ">>>>>>>9.99-".
DEF VAR nv_ncbdis       AS DECI FORMAT ">>>>>>>9.99-".*/

DEF VAR nv_company      AS CHAR FORMAT "x(30)".
DEF VAR n_moddes        AS CHAR.
DEF VAR n_moddes1       AS CHAR.
DEF VAR n_moddes2       AS CHAR.
DEF VAR n_class         AS CHAR.
DEF VAR nv_net          AS DECIMAL FORMAT ">>>,>>>,>>9.99". 
DEF VAR nv_total        AS DECIMAL FORMAT ">>>,>>>,>>9.99" .
DEF VAR nv_count        AS INTEGER INIT 0.
DEF VAR nv_chano        AS CHAR    INIT "".
DEF VAR nv_vehno        AS CHAR    INIT "".
DEF VAR nv_engno        AS CHAR    INIT "".
DEF VAR nv_outpol       AS CHAR.
DEF VAR nv_outend       AS CHAR.
DEF VAR nv_dateprocess  AS CHAR FORMAT "x(8)".
DEF VAR nv_cpol         AS INTEGER INIT 0.
DEF VAR nv_cend         AS INTEGER INIT 0.
DEF VAR nv_back         AS CHAR FORMAT "X".
DEF VAR nv_index        AS INTEGER .
DEF BUFFER buwm100 FOR sicuw.uwm100.
DEF BUFFER bxmm600 FOR sicsyac.xmm600.
DEF VAR n_month    AS INT INIT 0 .
DEF VAR n_monthtxt AS CHAR .
DEF VAR n_month01    AS INT INIT 0 .
DEF VAR n_monthtxt01 AS CHAR .
DEF VAR n_month02    AS INT INIT 0 .
DEF VAR n_monthtxt02 AS CHAR .
DEF VAR n_month03    AS INT INIT 0 .
DEF VAR n_monthtxt03 AS CHAR .
DEF VAR n_month04    AS INT INIT 0 .
DEF VAR n_monthtxt04 AS CHAR .
DEF NEW SHARED STREAM ns1.
DEF NEW SHARED STREAM ns2.
DEF new shared VAR nv_row        AS INT INIT 0.
DEF new shared VAR nv_column     AS INT INIT 0.
DEF VAR n_length  AS INT INIT 0.
DEF VAR nv_length AS CHAR  INIT "" .
DEFINE VAR nvw_dl          AS INTEGER INITIAL[14].       
DEFINE VAR nvw_index       AS INTEGER.                   
DEFINE VAR nvw_prev        AS RECID INITIAL[0].          
DEFINE VAR nvw_next        AS RECID INITIAL[0]. 
/*add Kridtiya i. A54-0336*/

DEFINE VAR nv_dept         AS CHAR INIT "". /*-
---Add End check policy Type  by chaiyong w. A55-01110 26/03/2012*/

DEFINE NEW SHARED TEMP-TABLE wdetail NO-UNDO
    field ReferenceNo                   as char format "x(15)" 
    field TransactionDateTime           as char format "x(20)" 
    field PayerCardType                 as char format "x(5)" 
    field PayerCardNo                   as char format "x(15)" 
    field PayerTypeGroup                as char format "x(2)" 
    field PayerTitleName                as char format "x(25)" 
    field PayerFirstName                as char format "x(100)" 
    field PayerLastName                 as char format "x(100)" 
    field PayerBirthday                 as char format "x(15)" 
    field PayerAge                      as char format "x(3)" 
    field PayerGender                   as char format "x(2)" 
    field PayerMobileNo                 as char format "x(10)" 
    field PayerOccupation               as char format "x(25)" 
    field InsuredCardType               as char format "x(5)" 
    field InsuredCardNo                 as char format "x(15)" 
    field InsuredType                   as char format "x(3)" 
    field InsuredTitleName              as char format "x(25)" 
    field InsuredFirstName              as char format "x(100)" 
    field InsuredLastName               as char format "x(100)" 
    field InsuredBirthday               as char format "x(15)" 
    field InsuredAge                    as char format "x(3)" 
    field InsuredGender                 as char format "x(2)" 
    field InsuredMobileNo               as char format "x(10)" 
    field InsuredOccupation             as char format "x(25)" 
    field InsuredMaritalStatus          as char format "x(25)" 
    field AddressContact                as char format "x(10)" 
    field AddressTemplateContact        as char format "x(2)" 
    field UnstructureAddressContact     as char format "x(150)" 
    field AddressNoContact              as char format "x(10)" 
    field MooContact                    as char format "x(10)" 
    field VillageBuildingContact        as char format "x(50)" 
    field FloorContact                  as char format "x(10)" 
    field RoomNumberContact             as char format "x(10)" 
    field SoiContact                    as char format "x(50)" 
    field StreetContact                 as char format "x(50)" 
    field SubDistrictContact            as char format "x(50)" 
    field DistrictContact               as char format "x(50)" 
    field ProvinceContact               as char format "x(50)" 
    field CountryContact                as char format "x(50)" 
    field ZipCodeContact                as char format "x(5)" 
    field AddressTax                    as char format "x(5)" 
    field AddressTemplateTax            as char format "x(2)" 
    field UnstructureAddressTax         as char format "x(150)" 
    field AddressNoTax                  as char format "x(10)" 
    field MooTax                        as char format "x(10)" 
    field VillageBuildingTax            as char format "x(50)" 
    field FloorTax                      as char format "x(10)" 
    field RoomNumberTax                 as char format "x(10)" 
    field SoiTax                        as char format "x(50)" 
    field StreetTax                     as char format "x(50)" 
    field SubDistrictTax                as char format "x(50)" 
    field DistrictTax                   as char format "x(50)" 
    field ProvinceTax                   as char format "x(50)" 
    field CountryTax                    as char format "x(50)" 
    field ZipCodeTax                    as char format "x(5)"  
    field KKInsApplicationNo            as char format "x(20)" 
    field TransactionType               as char format "x(2)" 
    field InsuranceCompanyCode          as char INIT ""
    field PolicyType                    as char INIT "P" 
    field MainAppNo                     as char format "x(20)" 
    field InsurerApplicationNo          as char format "x(20)" 
    field PolicyNo                      as char format "x(15)" 
    field ApproveDate                   as char format "x(15)" 
    field ApplicationDate               as char format "x(15)" 
    field EffectiveDate                 as char format "x(15)" 
    field ExpireDate                    as char format "x(15)" 
    field Packagecode                   as char format "x(15)" 
    field FreelookExpired               as char format "x(15)" 
    field MaturityAMT                   as char format "x(10)" 
    field SumInsure                     as deci format "->>>,>>>,>>9.99"  
    field PremiumAmount                 as deci format "->>,>>>,>>9.99" 
    field NetPremium                    as deci format "->>,>>>,>>9.99" 
    field CommRate                      as deci format "->>,>>>,>>9.99" 
    field CommNet                       as deci format "->>,>>>,>>9.99" 
    field CommFix                       as deci format "->>,>>>,>>9.99" 
    field CommVAT                       as deci format "->>,>>>,>>9.99" 
    field CommWHT                       as deci format "->>,>>>,>>9.99" 
    field CommAmt                       as deci format "->>,>>>,>>9.99" 
    field OVRate                        as deci format "->>,>>>,>>9.99" 
    field OVNet                         as deci format "->>,>>>,>>9.99" 
    field OVFix                         as deci format "->>,>>>,>>9.99" 
    field OVVAT                         as deci format "->>,>>>,>>9.99" 
    field OVWHT                         as deci format "->>,>>>,>>9.99" 
    field OVAmt                         as deci format "->>,>>>,>>9.99" 
    field BeneficiaryType               as char format "x(5)" 
    field BeneficiaryName               as char format "x(100)" 
    field Remark                        as char format "x(150)" 
    field CarType                       as char format "x(50)" 
    field CarBrand                      as char format "x(50)" 
    field CarLicenseNo                  as char format "x(50)" 
    field CarLicenseIssue               as char format "x(50)" 
    field ChassisNo                     as char format "x(50)" 
    field EngineNo                      as char format "x(50)" 
    field ModelYear                     as char format "x(50)" 
    field Maintenance                   as char format "x(50)" 
    field NotifiedNO                    as char format "x(50)"
    FIELD covcod                        AS CHAR FORMAT "x(3)"
    FIELD producer                      AS CHAR FORMAT "X(10)"
    FIELD poltyp                        AS CHAR FORMAT "x(5)"
    /* a63-0299 */
    FIELD endcnt                        AS CHAR FORMAT "x(5)"  
    field SystemCode                    as char format "x(50)"
    field PaymentMode                   as char format "x(1)"
    field PaymentPeriod                 as char format "x(1)" 
    field VATPremium                    as DECI format "->>,>>>,>>9.99" 
    field StampPremium                  as DECI format "->>,>>>,>>9.99" 
    field GrossPremium                  as DECI format "->>,>>>,>>9.99" 
    field WHTPremium                    as DECI format "->>,>>>,>>9.99" 
    field yr                            as char format "->>,>>>,>>9.99"
    FIELD reasoncode                    AS CHAR FORMAT "x(2)" 
    .


DEF VAR nv_txt5         AS CHAR FORMAT "x(750)".
DEF VAR nv_f5           AS CHAR FORMAT "x(750)".
DEF NEW SHARED VAR nv_type AS INT INIT 0.
/* End a63-0299*/

/*-- Add By Tontawan S. A64-0104 01/03/2021 --*/
DEF VAR n_rate          AS DECI FORMAT ">>>>9.999".
DEF VAR n_wht           AS DECI FORMAT ">>>>9.999".
/*-- End Add By Tontawan S. A64-0104 01/03/2021 --*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS ra_s rs_type fi_branchfr bu_hpbrnfr ~
fi_branchto bu_hpbrnto fi_poltypfr bu_typhpfr fi_poltypto bu_typhpto ~
ra_typproducer fi_acno bu_hpacno1 fi_agent ra_release bu_hpagent ~
fi_trndatfr fi_trndatto fi_output Bu_ok bu_cancel RECT-18 RECT-372 RECT-373 ~
RECT-374 
&Scoped-Define DISPLAYED-OBJECTS ra_s rs_type fi_branchfr fi_brndesfr ~
fi_branchto fi_brndesto fi_poltypfr fi_poltypdesfr fi_poltypto ~
fi_poltypdesto ra_typproducer fi_acno fi_proname fi_agent ra_release ~
fi_agtname fi_trndatfr fi_trndatto fi_output 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME


/* ************************  Function Prototypes ********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION-FORWARD fn-month C-Win 
FUNCTION fn-month RETURNS CHARACTER
  (ip_month AS INTEGER)  FORWARD.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 13 .

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpbrnfr 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_hpbrnto 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON Bu_ok 
     LABEL "OK" 
     SIZE 15 BY 1.14.

DEFINE BUTTON bu_typhpfr 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE BUTTON bu_typhpto 
     IMAGE-UP FILE "WIMAGE\help":U
     LABEL "" 
     SIZE 4 BY 1.05.

DEFINE VARIABLE fi_acno AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1.05
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branchfr AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branchto AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brndesfr AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brndesto AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_output AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 69.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_poltypdesfr AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltypdesto AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_poltypfr AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_poltypto AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 49 BY 1
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndatfr AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndatto AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_release AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Release", 1,
"Not release", 2,
"All", 3
     SIZE 50.17 BY .95
     BGCOLOR 18 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_s AS INTEGER INITIAL 2 
     VIEW-AS RADIO-SET HORIZONTAL EXPAND 
     RADIO-BUTTONS 
          "Old", 1,
"New", 2,
"Payment ", 3
     SIZE 32.5 BY 1.57
     BGCOLOR 19  NO-UNDO.

DEFINE VARIABLE ra_typproducer AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Group Producer Code", 1,
"Producer Code", 2
     SIZE 61 BY 1
     BGCOLOR 8 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE rs_type AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Policy ISSUE", 1,
"Endorsements ISSUE", 2
     SIZE 50 BY .91
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE RECTANGLE RECT-18
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 102 BY 18.81
     BGCOLOR 19 FGCOLOR 1 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.52
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 62.5 BY 1.19
     BGCOLOR 8 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     ra_s AT ROW 1.71 COL 65 NO-LABEL WIDGET-ID 10
     rs_type AT ROW 3.57 COL 39 NO-LABEL WIDGET-ID 2
     fi_branchfr AT ROW 5.29 COL 30.17 COLON-ALIGNED NO-LABEL
     bu_hpbrnfr AT ROW 5.29 COL 38.67
     fi_brndesfr AT ROW 5.29 COL 44.67 COLON-ALIGNED NO-LABEL
     fi_branchto AT ROW 6.33 COL 30.17 COLON-ALIGNED NO-LABEL
     bu_hpbrnto AT ROW 6.33 COL 38.67
     fi_brndesto AT ROW 6.33 COL 44.67 COLON-ALIGNED NO-LABEL
     fi_poltypfr AT ROW 7.38 COL 30.17 COLON-ALIGNED NO-LABEL
     bu_typhpfr AT ROW 7.38 COL 38.67
     fi_poltypdesfr AT ROW 7.38 COL 44.67 COLON-ALIGNED NO-LABEL
     fi_poltypto AT ROW 8.43 COL 30.17 COLON-ALIGNED NO-LABEL
     bu_typhpto AT ROW 8.43 COL 38.67
     fi_poltypdesto AT ROW 8.43 COL 44.67 COLON-ALIGNED NO-LABEL
     ra_typproducer AT ROW 9.86 COL 14.5 NO-LABEL
     fi_acno AT ROW 11.1 COL 30.17 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 11.05 COL 47.83
     fi_proname AT ROW 11.1 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 12.14 COL 30.17 COLON-ALIGNED NO-LABEL
     ra_release AT ROW 13.33 COL 32.33 NO-LABEL
     bu_hpagent AT ROW 12.14 COL 47.83
     fi_agtname AT ROW 12.14 COL 51.33 COLON-ALIGNED NO-LABEL
     fi_trndatfr AT ROW 14.38 COL 30.17 COLON-ALIGNED NO-LABEL
     fi_trndatto AT ROW 15.43 COL 30.17 COLON-ALIGNED NO-LABEL
     fi_output AT ROW 16.48 COL 30 COLON-ALIGNED NO-LABEL
     Bu_ok AT ROW 18.05 COL 67.67
     bu_cancel AT ROW 18.05 COL 85
     "Output  To :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 16.48 COL 18.33
          BGCOLOR 19 FGCOLOR 1 
     "Report File ISSUE Send To KK" VIEW-AS TEXT
          SIZE 39 BY 1 AT ROW 1.71 COL 18
          BGCOLOR 19 FGCOLOR 2 FONT 36
     "Trans Date  From :" VIEW-AS TEXT
          SIZE 19 BY 1 AT ROW 14.38 COL 12.5
          BGCOLOR 19 FGCOLOR 1 
     "  Status Pol :" VIEW-AS TEXT
          SIZE 13.5 BY 1.05 AT ROW 13.24 COL 17.83
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Report Type :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 3.57 COL 17.5 WIDGET-ID 6
          BGCOLOR 19 FGCOLOR 1 
     "Branch From :" VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 5.29 COL 17.83
          BGCOLOR 19 FGCOLOR 1 
     "Branch To :" VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 6.33 COL 19.83
          BGCOLOR 19 FGCOLOR 1 
     "Policy Type To :" VIEW-AS TEXT
          SIZE 16.5 BY 1 AT ROW 8.43 COL 15
          BGCOLOR 19 FGCOLOR 1 
     "Trans Date  To :" VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 15.43 COL 14.33
          BGCOLOR 19 FGCOLOR 1 
     "Agent Code :" VIEW-AS TEXT
          SIZE 13.5 BY 1.05 AT ROW 12.14 COL 18
          BGCOLOR 19 FGCOLOR 1 FONT 6
     "Policy Type From :" VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 7.38 COL 13.17
          BGCOLOR 19 FGCOLOR 1 
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY 1.05 AT ROW 11.1 COL 15
          BGCOLOR 19 FGCOLOR 1 FONT 6
     RECT-18 AT ROW 1.24 COL 5
     RECT-372 AT ROW 17.86 COL 66.5
     RECT-373 AT ROW 17.86 COL 84
     RECT-374 AT ROW 3.43 COL 32.83 WIDGET-ID 8
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 110.83 BY 19.43
         BGCOLOR 29 FONT 6.


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
         TITLE              = "wgwkksen.w : Export file ISSUE To KK"
         HEIGHT             = 19.52
         WIDTH              = 110
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
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
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_agtname:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_brndesfr IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_brndesfr:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_brndesto IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_brndesto:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_poltypdesfr IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_poltypdesfr:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_poltypdesto IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_poltypdesto:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_proname:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fr_main
/* Query rebuild information for FRAME fr_main
     _Query            is NOT OPENED
*/  /* FRAME fr_main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* wgwkksen.w : Export file ISSUE To KK */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* wgwkksen.w : Export file ISSUE To KK */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_cancel C-Win
ON CHOOSE OF bu_cancel IN FRAME fr_main /* Cancel */
DO:
  APPLY "close" TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 C-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                    output  n_agent).
                                          
     If  n_acno  <>  ""  THEN DO:  
         fi_acno     =  n_acno.
         fi_proname  =  n_agent.
     END.
     
     disp  fi_acno fi_proname with frame  fr_main.

     Apply "Entry"  to  fi_acno.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent C-Win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrnfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrnfr C-Win
ON CHOOSE OF bu_hpbrnfr IN FRAME fr_main
DO:
   Run  whp\whpbrn01(Input-output  fi_branchfr,
                     Input-output  fi_brndesfr). 
                                     
   Disp  fi_branchfr  fi_brndesfr  with frame  fr_main.                                     
   Apply "Entry"  To  fi_branchfr.
   Return no-apply.                            
                                        

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrnto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrnto C-Win
ON CHOOSE OF bu_hpbrnto IN FRAME fr_main
DO:
   Run  whp\whpbrn01(Input-output  fi_branchto,
                     Input-output  fi_brndesto).
                                     
   Disp  fi_branchto  fi_brndesto  with frame  fr_main.                                     
   Apply "Entry"  To  fi_branchto.
   Return no-apply.                            
                                        

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Bu_ok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Bu_ok C-Win
ON CHOOSE OF Bu_ok IN FRAME fr_main /* OK */
DO:
    ASSIGN
      nv_output   = ""
      nv_type     = 0
      nv_type     = rs_type    /*A63-0299*/
      nv_branchfr = INPUT fi_branchfr 
      nv_branchto = INPUT fi_branchto 
      nv_poltypfr = INPUT fi_poltypfr 
      nv_poltypto = INPUT fi_poltypto 
      nv_trndatfr = INPUT fi_trndatfr 
      nv_trndatto = INPUT fi_trndatto
      nv_acno     = INPUT fi_acno
      nv_output   = INPUT fi_output  
      fi_acno     = INPUT fi_acno    /*-- add by chaiyong w. A64-0135 15/06/2021*/
      ra_release  = INPUT ra_release  /*-- add by chaiyong w. A64-0135 15/06/2021*/
      rs_type     = INPUT rs_type /*-- add by chaiyong w. A64-0135 15/06/2021*/ 
      ra_s        = INPUT ra_s    /*-- add by chaiyong w. A64-0135 15/06/2021*/ 
        .

    IF nv_branchfr = "" THEN DO:
        MESSAGE "Branch From: Can't Be Blank" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_branchfr.
        RETURN NO-APPLY.
    END.
    IF nv_branchto = "" THEN DO:
        MESSAGE "Branch To: Can't Be Blank" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_branchto.
        RETURN NO-APPLY.
    END.
    IF nv_poltypfr = "" THEN DO:
        MESSAGE "Policy Type From: Can't Be Blank" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_poltypfr.
        RETURN NO-APPLY.
    END.
    IF nv_poltypto = "" THEN DO:
        MESSAGE "Policy Type To: Can't Be Blank" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_poltypto.
        RETURN NO-APPLY.
    END.
    IF nv_trndatfr = ? THEN DO:
        MESSAGE "Trans Date From: Can't Be Blank" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_trndatfr.
        RETURN NO-APPLY.
    END.
    IF nv_trndatto = ? THEN DO:
        MESSAGE "Trans Date to: Can't Be Blank" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_trndatto.
        RETURN NO-APPLY.
    END.
    
    /***--- Clear temp table ---***/
    FOR EACH wdetail:
        DELETE wdetail.
    END.

    IF ra_s = 1 THEN DO: /*-- add by chaiyong w. A64-0135 15/06/2021*/
    /* create by Ranu I. A60-0426 */
        IF ra_typproducer = 1 THEN DO:
            IF nv_acno = "" THEN DO:
                MESSAGE "Producer code : Can't Be Blank" VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_acno.
                RETURN NO-APPLY.
            END.
            RUN proc_create2.
        END.
        ELSE DO:
            IF nv_acno = "" THEN DO:
                MESSAGE "Producer code : Can't Be Blank" VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_acno.
                RETURN NO-APPLY.
            END.
            IF nv_agent = "" THEN DO:
                MESSAGE "Agent code : Can't Be Blank" VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_agent.
                RETURN NO-APPLY.
            END.
            RUN proc_create.
        END.
        
       /* nv_back = IF SUBSTRING(nv_output,LENGTH(TRIM(nv_output)) - 1 ,1) = "\" 
                  THEN TRIM(nv_output) 
                  ELSE TRIM(nv_output) + "\".
        ASSIGN
            nv_output = nv_back  + "KKISSUE_POLICY" + STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99") + ".CSV"
            fi_output = nv_output .
        DISP fi_output WITH FRAME fr_main .*/
    
        RUN proc_export1.

    /*-- Begin by chaiyong w. A64-0135 15/06/2021*/
    END.
    ELSE DO:
        IF nv_acno = "" THEN DO:
            MESSAGE "Producer code : Can't Be Blank" VIEW-AS ALERT-BOX.
            APPLY "entry" TO fi_acno.
            RETURN NO-APPLY.
        END.
        IF ra_typproducer = 2 THEN DO:
            IF nv_agent = "" THEN DO:
                MESSAGE "Agent code : Can't Be Blank" VIEW-AS ALERT-BOX.
                APPLY "entry" TO fi_agent.
                RETURN NO-APPLY.
            END.
        END.
        IF rs_type = 1 AND ra_s = 2 THEN RUN proc_create3.
        ELSE RUN proc_create4.
    END.
    /*End by chaiyong w. A64-0135 15/06/2021-----*/
    MESSAGE "Process Complete" VIEW-AS ALERT-BOX.
   


END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_typhpfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_typhpfr C-Win
ON CHOOSE OF bu_typhpfr IN FRAME fr_main
DO:
 /* CURRENT-WINDOW:WINDOW-STAT=WINDOW-MINIMIZED .*/
  CURRENT-WINDOW:SENSITIVE = NO.   
  RUN Whp\WhpPtyp1(INPUT-OUTPUT n_hptyp1,INPUT-OUTPUT n_hpdestyp1).
  CURRENT-WINDOW:SENSITIVE = Yes. 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.  */
  ASSIGN  
    fi_poltypfr    = n_hptyp1 
    fi_poltypdesfr = n_hpDestyp1.
  DISP fi_poltypfr fi_poltypdesfr WITH FRAME {&FRAME-NAME}.
       Apply "Entry" To fi_poltypfr.
       Return No-Apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_typhpto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_typhpto C-Win
ON CHOOSE OF bu_typhpto IN FRAME fr_main
DO:
 /* CURRENT-WINDOW:WINDOW-STAT=WINDOW-MINIMIZED .*/
  CURRENT-WINDOW:SENSITIVE = NO.   
  RUN Whp\WhpPtyp1(INPUT-OUTPUT n_hptyp1,INPUT-OUTPUT n_hpdestyp1).
  CURRENT-WINDOW:SENSITIVE = Yes. 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-NORMAL.  */
  ASSIGN  
    fi_poltypto    = n_hptyp1 
    fi_poltypdesto = n_hpDestyp1.
  DISP fi_poltypto fi_poltypdesto WITH FRAME {&FRAME-NAME}.
       Apply "Entry" To fi_poltypto.
       Return No-Apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_acno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON LEAVE OF fi_acno IN FRAME fr_main
DO:
  ASSIGN
      fi_acno = INPUT fi_acno
      nv_acno = INPUT fi_acno.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_acno C-Win
ON RETURN OF fi_acno IN FRAME fr_main
DO:
    fi_acno = INPUT fi_acno.

    IF  INPUT fi_acno <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
                     xmm600.acno  =  Input fi_acno  
        NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_acno.
            RETURN NO-APPLY. 
        END.
        ELSE DO:
            ASSIGN
            fi_proname =  TRIM(xmm600.ntitle) + "  "  + TRIM(xmm600.name)
            fi_acno    =  CAPS(INPUT fi_acno) 
            nv_acno    =  fi_acno
            fi_agent   =  INPUT fi_acno.
        END.
    END.
    IF ra_typproducer = 1 THEN ASSIGN fi_agent   =  "" . /*a60-0426*/
    Disp  fi_acno  fi_proname fi_agent WITH Frame  fr_main.   
    APPLY "entry" TO fi_agent.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    ASSIGN
      fi_agent = INPUT fi_agent
      nv_agent = INPUT fi_agent.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON RETURN OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
    FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
              xmm600.acno  =  Input fi_agent  
    NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL xmm600 THEN DO:
             Message  "Not on Name & Address Master File xmm600" 
             View-as alert-box.
             Apply "Entry" To  fi_agent.
             RETURN NO-APPLY. 
        END.
        ELSE DO: 
            ASSIGN
            fi_agtname =  TRIM(xmm600.ntitle) + "  "  + TRIM(xmm600.name)
            fi_agent =  caps(INPUT  fi_agent)
            nv_agent =  fi_agent. 
            
        END. /*end note 10/11/2005*/
    END. /*Then fi_agent <> ""*/
    
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.     
    APPLY "entry" TO fi_trndatfr.
    RETURN NO-APPLY.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchfr C-Win
ON LEAVE OF fi_branchfr IN FRAME fr_main
DO:
  ASSIGN
    fi_branchfr = Input fi_branchfr
    nv_branchfr = Input fi_branchfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchfr C-Win
ON RETURN OF fi_branchfr IN FRAME fr_main
DO:
  fi_branchfr = Input fi_branchfr.
  IF  Input fi_branchfr  =  ""  Then do:
       Message "กรุณาระบุ Branch Code ." View-as alert-box.
       Apply "Entry"  To  fi_branchfr.
  END.
  Else do:
      FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
           xmm023.branch   =  Input  fi_branchfr 
           NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAIL  xmm023 THEN DO:
                   Message  "Not on Description Master File xmm023" 
                   View-as alert-box.
                   Apply "Entry"  To  fi_branchfr.
                   RETURN NO-APPLY.
            END.
      ASSIGN
          fi_branchfr  =  CAPS(Input fi_branchfr) 
          fi_brndesfr  =  xmm023.bdes
          fi_branchto  =  INPUT fi_branchfr.
  End. /*else do:*/

  Disp fi_branchfr  fi_brndesfr  fi_branchto With Frame  fr_main.   
  Apply "Entry"  To  fi_branchto.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branchto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchto C-Win
ON LEAVE OF fi_branchto IN FRAME fr_main
DO:
  ASSIGN
      fi_branchto = Input fi_branchto
      nv_branchto = Input fi_branchto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branchto C-Win
ON RETURN OF fi_branchto IN FRAME fr_main
DO:
  fi_branchto = Input fi_branchto.
  IF  Input fi_branchto  =  ""  Then do:
       Message "กรุณาระบุ Branch Code ." View-as alert-box.
       Apply "Entry"  To  fi_branchto.
  END.
  Else do:
       IF fi_branchto < fi_branchfr THEN DO:
           MESSAGE "Branch To: Can't less Than Branch From:" VIEW-AS ALERT-BOX.
           APPLY "entry" TO fi_branchto.
           RETURN NO-APPLY.
       END.
       FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            xmm023.branch   =  Input  fi_branchto
       NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  xmm023 THEN DO:
               Message  "Not on Description Master File xmm023" 
               View-as alert-box.
               Apply "Entry"  To  fi_branchto.
               RETURN NO-APPLY.
        END.
  fi_branchto  =  CAPS(Input fi_branchto) .
  fi_brndesto  =  xmm023.bdes.
  End. /*else do:*/

  Disp fi_branchto  fi_brndesto  With Frame  fr_main.    
  
  APPLY  "entry" TO fi_poltypfr.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_output
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_output C-Win
ON LEAVE OF fi_output IN FRAME fr_main
DO:
    fi_output = INPUT fi_output .
    DISP fi_output WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltypfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltypfr C-Win
ON LEAVE OF fi_poltypfr IN FRAME fr_main
DO:
    ASSIGN
     fi_poltypfr = INPUT fi_poltypfr
     nv_poltypfr = INPUT fi_poltypfr.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltypfr C-Win
ON RETURN OF fi_poltypfr IN FRAME fr_main
DO:
  fi_poltypfr = INPUT fi_poltypfr.
  IF INPUT fi_poltypfr <> "" THEN DO:

      FIND FIRST sicsyac.xmm031 USE-INDEX xmm03101        WHERE
                 xmm031.poltyp = INPUT fi_poltypfr  NO-LOCK NO-ERROR.
      IF NOT AVAILABLE xmm031 THEN DO:
         MESSAGE  "Not on Policy Type Parameter file xmm031" VIEW-AS ALERT-BOX ERROR.
         APPLY "ENTRY" TO fi_poltypfr.
      END.
      ELSE DO :   
         ASSIGN
           fi_poltypfr    =  CAPS( INPUT fi_poltypfr)
           fi_poltypdesfr =  xmm031.poldes
           fi_poltypto    =  fi_poltypfr.
         DISPLAY  fi_poltypfr fi_poltypto fi_poltypdesfr WITH FRAME {&FRAME-NAME}.
         APPLY "entry" TO fi_poltypto.
         RETURN NO-APPLY.
      END.   
  END.
  ELSE DO:
        ASSIGN 
             fi_poltypfr    = "" 
             fi_poltypdesfr = ""
             fi_poltypto    =  fi_poltypfr.
        DISP fi_poltypfr  fi_poltypto fi_poltypdesfr WITH FRAME {&FRAME-NAME}.
        APPLY "ENTRY" TO fi_poltypfr.
        RETURN NO-APPLY.
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_poltypto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltypto C-Win
ON LEAVE OF fi_poltypto IN FRAME fr_main
DO:
  ASSIGN
      fi_poltypto = INPUT fi_poltypto
      nv_poltypto = INPUT fi_poltypto.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_poltypto C-Win
ON RETURN OF fi_poltypto IN FRAME fr_main
DO:  
    fi_poltypto = INPUT fi_poltypto.
    IF INPUT fi_poltypto <> "" THEN DO:
        IF fi_poltypto < fi_poltypfr THEN DO:
            MESSAGE "Policy Type From: Can't Less Than Policy Type To:" VIEW-AS ALERT-BOX.
            APPLY "ENTRY" TO fi_poltypto.
            RETURN NO-APPLY.
        END.

        FIND FIRST sicsyac.xmm031 USE-INDEX xmm03101        WHERE
                   xmm031.poltyp = INPUT fi_poltypto  NO-LOCK NO-ERROR.
        IF NOT AVAILABLE xmm031 THEN DO:
           MESSAGE  "Not on Policy Type Parameter file xmm031" VIEW-AS ALERT-BOX ERROR.
           APPLY "ENTRY" TO fi_poltypto.
           RETURN NO-APPLY.
        END.
        ELSE DO :   
           fi_poltypto    =  CAPS( INPUT fi_poltypto).
           fi_poltypdesto =  xmm031.poldes.
           DISPLAY  fi_poltypto fi_poltypdesto WITH FRAME {&FRAME-NAME}.
           APPLY "entry" TO fi_acno.
           RETURN NO-APPLY.
        END.   
    END.
    ELSE DO:
          ASSIGN 
               fi_poltypto    = "" 
               fi_poltypdesto = "".
          DISP fi_poltypto  fi_poltypdesto WITH FRAME {&FRAME-NAME}.
          APPLY "ENTRY" TO fi_poltypto.
          RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatfr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr C-Win
ON LEAVE OF fi_trndatfr IN FRAME fr_main
DO:
  fi_trndatfr = INPUT fi_trndatfr.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatfr C-Win
ON RETURN OF fi_trndatfr IN FRAME fr_main
DO:
  ASSIGN
     fi_trndatfr = INPUT fi_trndatfr.
     fi_trndatto = fi_trndatfr.

  DISP fi_trndatfr fi_trndatto WITH FRAME fr_main.
  APPLY "entry" TO fi_trndatto.
  RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_trndatto
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto C-Win
ON LEAVE OF fi_trndatto IN FRAME fr_main
DO:
    fi_trndatto = INPUT fi_trndatto.
    IF INPUT fi_trndatto < INPUT fi_trndatfr THEN DO:
        MESSAGE "Trans Date To Can't Less Than Trans Date From" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_trndatto.
        RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_trndatto C-Win
ON RETURN OF fi_trndatto IN FRAME fr_main
DO:
    fi_trndatto = INPUT fi_trndatto.
    IF fi_trndatto < fi_trndatfr THEN DO:
        MESSAGE "Trans Date To Can't Less Than Trans Date From" VIEW-AS ALERT-BOX.
        APPLY "entry" TO fi_trndatto.
        RETURN NO-APPLY.
    END.

    APPLY "entry" TO fi_output.
    RETURN NO-APPLY.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_release
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_release C-Win
ON VALUE-CHANGED OF ra_release IN FRAME fr_main
DO:
    ra_release = INPUT ra_release.
    DISP ra_release WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typproducer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typproducer C-Win
ON VALUE-CHANGED OF ra_typproducer IN FRAME fr_main
DO:
  ra_typproducer = INPUT ra_typproducer .
  DISP ra_typproducer WITH FRAM fr_main.
  /*A60-0426*/
  IF ra_typproducer = 1 THEN DO:
      DISABLE fi_agent bu_hpagent WITH FRAME fr_main.
  END.
  ELSE DO:
      ENABLE fi_agent bu_hpagent WITH FRAME fr_main.
  END.
  /* end A60-0426*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME rs_type
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL rs_type C-Win
ON VALUE-CHANGED OF rs_type IN FRAME fr_main
DO:
    rs_type = INPUT rs_type.
    DISP rs_type WITH FRAME fr_main.
  
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

/********************  T I T L E   F O R  C - W I N  ***************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "wgwkksen.w".
  gv_prog  = "Export file Issue policy to KK".
  RUN  WUT\WUTHEAD (C-Win:handle,gv_prgid,gv_prog).
  RUN  WUT\WUTWICEN (C-Win:handle). 
/********************************************************************/
  SESSION:DATA-ENTRY-RETURN = YES.

  ASSIGN 
      fi_branchfr = TRIM(SUBSTRING(n_User,6,2))
      fi_trndatfr = TODAY
      ra_release  = 1 
      rs_type     = 1 /* A63-0299*/

      fi_acno     =   "B3MLKK0100" /*--Add by Chaiyong W. A64-0135 22/07/2021*/
      ra_typproducer = 1 .          /*kridtiya i . A56-0120*/
  IF ra_typproducer = 1 THEN DISABLE fi_agent bu_hpagent WITH FRAME fr_main. /*A60-0426*/
  DISP fi_branchfr fi_trndatfr ra_release ra_typproducer 
       fi_acno   /*--Add by Chaiyong W. A64-0135 22/07/2021*/  
      
      WITH FRAME fr_main.

  /*---begin add out put to path by Chaiyong W. A55-0233 17/07/2012*/
  fi_output = "" .
       
  DISP fi_output WITH FRAME fr_main.
  /*End add out put to path by Chaiyong W. A55-0233 17/07/2012-----*/

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
  DISPLAY ra_s rs_type fi_branchfr fi_brndesfr fi_branchto fi_brndesto 
          fi_poltypfr fi_poltypdesfr fi_poltypto fi_poltypdesto ra_typproducer 
          fi_acno fi_proname fi_agent ra_release fi_agtname fi_trndatfr 
          fi_trndatto fi_output 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE ra_s rs_type fi_branchfr bu_hpbrnfr fi_branchto bu_hpbrnto fi_poltypfr 
         bu_typhpfr fi_poltypto bu_typhpto ra_typproducer fi_acno bu_hpacno1 
         fi_agent ra_release bu_hpagent fi_trndatfr fi_trndatto fi_output Bu_ok 
         bu_cancel RECT-18 RECT-372 RECT-373 RECT-374 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_ems C-Win 
PROCEDURE pd_ems :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 Def  Var chNotesSession  As Com-Handle.
    Def  Var chNotesDataBase As Com-Handle.
    Def  Var chDocument      As Com-Handle.
    Def  Var chNotesView     As Com-Handle .
    Def  Var chNavView       As Com-Handle .
    Def  Var chItem          As Com-Handle .
    DEF VAR nv_server AS CHAR INIT "".
    DEF VAR nv_tmp    AS CHAR INIT "".
nv_server = "Safety_NotesServer/Safety".
 nv_tmp   = "safety\fi\" + "postdocument" + SUBSTR(string(year(uwm100.trndat)),3,2) + ".nsf".
    CREATE "Notes.NotesSession"  chNotesSession NO-ERROR.
    chNotesDatabase  = chNotesSession:GetDatabase (nv_server,nv_tmp) NO-ERROR.
    chNotesView    = chNotesDatabase:GetView("By PolicyNo") NO-ERROR.
    chNavView      = chNotesView:CreateViewNav NO-ERROR.
    chDocument     = chNotesView:GetDocumentByKey(uwm100.policy) NO-ERROR.
    IF VALID-HANDLE(chDocument) = YES THEN DO:
        chitem       = chDocument:Getfirstitem("EmsNo").      /*เลข Ems */
        IF chitem <> 0 THEN wdetail.reasoncode    = chitem:TEXT. 
        ELSE wdetail.reasoncode     = "".
    END.
    release object chNotesSession   no-error.
    release object chNotesDataBase  no-error.
    release object chDocument       no-error.
    release object chNotesView      no-error.
    release object chNavView        no-error.
    release object chItem           no-error.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_put C-Win 
PROCEDURE pd_put :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF INPUT PARAMETER nv_row    AS INT INIT 0.
DEF INPUT PARAMETER nv_col    AS INT INIT 0.
DEF INPUT PARAMETER nv_text   AS CHAR INIT "".
DEF VAR nv_length AS INT INIT 0.
nv_text  = TRIM(nv_text).
nv_length = LENGTH(nv_text) NO-ERROR.
IF nv_length <> 0 AND nv_text <> ? THEN DO:
     PUT STREAM ns1 "C;Y" STRING(nv_row) ";X" STRING(nv_col) ";K" '"' nv_text  FORMAT "x(" + STRING(nv_length) + ")"  '"' SKIP.  
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr C-Win 
PROCEDURE proc_addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_addr AS CHAR FORMAT "x(255)" INIT "".
def var n_address  as char format "x(50)".
def var n_banno    as char format "x(50)".
def var n_moo      as char format "x(50)".
def var n_floor    as char format "x(50)".
def var n_room     as char format "x(50)".
def var n_build    as char format "x(50)".
def var n_mu       as char format "x(50)".
def var n_soi      as char format "x(50)".
def var n_road     as char format "x(50)".
def var n_tambon   as char format "x(50)".
def var n_amper    as char format "x(50)".
def var n_country  as char format "x(50)".
def var n_post     as char format "x(50)".
DEF VAR n_length   AS INT.

DO:
     ASSIGN  n_length   = 0      n_address  = ""
             n_banno    = ""     n_mu       = ""    
             n_floor    = ""     n_room     = "" 
             n_build    = ""     n_road     = ""   n_soi  = ""      
             n_tambon   = ""     n_amper    = ""          
             n_country  = ""     n_post     = ""
             n_address  = "" .

    IF trim(wdetail.UnstructureAddressContact) <> "" THEN DO:
        ASSIGN  n_address  = TRIM(wdetail.UnstructureAddressContact) .      
           
            IF INDEX(n_address,"จ." ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"จ."),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
            END.
            ELSE IF INDEX(n_address,"จังหวัด" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
            END.
            ELSE IF INDEX(n_address,"กทม" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
            END.
            ELSE IF INDEX(n_address,"กรุงเทพ" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
            END.
            IF index(n_country,"จ.")      <> 0 THEN n_country = trim(REPLACE(n_country,"จ.","")) .
            IF index(n_country,"จังหวัด") <> 0 THEN n_country = trim(REPLACE(n_country,"จังหวัด","")) .
        
            IF INDEX(n_address,"อ.") <> 0 AND index(n_country,"กทม") = 0 AND index(n_country,"กรุงเทพ") = 0 THEN DO:
                ASSIGN 
                n_amper  =  SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address))
                n_length   =  LENGTH(n_amper)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_amper,"อ.") <> 0 THEN n_amper = trim(REPLACE(n_amper,"อ.","")) .
            END.
            ELSE IF INDEX(n_address,"อำเภอ" ) <> 0 THEN DO: 
                ASSIGN 
                n_amper  =  SUBSTR(n_address,INDEX(n_address,"อำเภอ"),LENGTH(n_address))
                n_length   =  LENGTH(n_amper)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_amper,"อำเภอ") <> 0 THEN n_amper = trim(REPLACE(n_amper,"อำเภอ","")) .
            END.
            ELSE IF INDEX(n_address,"เขต" ) <> 0 THEN DO: 
                ASSIGN 
                n_amper  =  SUBSTR(n_address,INDEX(n_address,"เขต"),LENGTH(n_address))
                n_length   =  LENGTH(n_amper)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                 IF index(n_amper,"เขต") <> 0 THEN n_amper = trim(REPLACE(n_amper,"เขต","")) .
            END.
        
            IF INDEX(n_address,"ต." ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ต."),LENGTH(n_address))
                n_length   =  LENGTH(n_tambon)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_tambon,"ต.") <> 0 THEN n_tambon = trim(REPLACE(n_tambon,"ต.","")) .
            END.
            ELSE IF INDEX(n_address,"ตำบล" ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ตำบล"),LENGTH(n_address))
                n_length   =  LENGTH(n_tambon)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_tambon,"ตำบล") <> 0 THEN  n_tambon = trim(REPLACE(n_tambon,"ตำบล","")) .
            END.
            ELSE IF INDEX(n_address,"แขวง" ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon  =  SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address))
                n_length   =  LENGTH(n_tambon)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_tambon,"แขวง") <> 0 THEN n_tambon = trim(REPLACE(n_tambon,"แขวง","")) .
            END.
        
            IF INDEX(n_address,"ถ." ) <> 0 THEN DO: 
                ASSIGN 
                n_road  =  SUBSTR(n_address,INDEX(n_address,"ถ."),LENGTH(n_address))
                n_length   =  LENGTH(n_road)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"ถนน" ) <> 0 THEN DO: 
                ASSIGN 
                n_road  =  SUBSTR(n_address,INDEX(n_address,"ถนน"),LENGTH(n_address))
                n_length   =  LENGTH(n_road)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"ซ." ) <> 0 THEN DO: 
                ASSIGN 
                n_soi  =  SUBSTR(n_address,INDEX(n_address,"ซ."),LENGTH(n_address))
                n_length   =  LENGTH(n_soi)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"ซอย" ) <> 0 THEN DO: 
                ASSIGN 
                n_soi  =  SUBSTR(n_address,INDEX(n_address,"ซอย"),LENGTH(n_address))
                n_length   =  LENGTH(n_soi)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"ชั้น" ) <> 0 THEN DO: 
                ASSIGN 
                n_floor   =  SUBSTR(n_address,INDEX(n_address,"ชั้น"),LENGTH(n_address))
                n_length   =  LENGTH(n_floor)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"ห้อง" ) <> 0 THEN DO: 
                ASSIGN 
                n_room  =  SUBSTR(n_address,INDEX(n_address,"ห้อง"),LENGTH(n_address))
                n_length   =  LENGTH(n_room)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"อาคาร" ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"อาคาร"),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"อ." ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"หมู่บ้าน" ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"หมู่บ้าน"),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"บ้าน" ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"บ้าน"),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"หมู่ที่" ) <> 0 THEN DO: 
                ASSIGN 
                n_mu  =  SUBSTR(n_address,INDEX(n_address,"หมู่ที่"),LENGTH(n_address))
                n_length   =  LENGTH(n_mu)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"หมู่" ) <> 0 THEN DO: 
                ASSIGN 
                n_mu  =  SUBSTR(n_address,INDEX(n_address,"หมู่"),LENGTH(n_address))
                n_length   =  LENGTH(n_mu)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"ม." ) <> 0 THEN DO: 
                ASSIGN 
                n_mu  =  SUBSTR(n_address,INDEX(n_address,"ม."),LENGTH(n_address))
                n_length   =  LENGTH(n_mu)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"เลขที่" ) <> 0 THEN DO: 
                ASSIGN 
                n_banno  =  SUBSTR(n_address,INDEX(n_address,"เลขที่"),LENGTH(n_address))
                n_length   =  LENGTH(n_banno)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE ASSIGN  n_banno   = trim(n_address).
            ASSIGN 
                /*wdetail.UnstructureAddressContact = "" */ /*A63-0299*/
                wdetail.AddressNoContact        =  TRIM(n_banno) 
                wdetail.MooContact              =  TRIM(n_mu) 
                wdetail.VillageBuildingContact  =  TRIM(n_build) 
                wdetail.FloorContact            =  TRIM(n_floor) 
                wdetail.RoomNumberContact       =  trim(n_room) 
                wdetail.SoiContact              =  trim(n_soi) 
                wdetail.StreetContact           =  trim(n_road) 
                wdetail.SubDistrictContact      =  TRIM(n_tambon) 
                wdetail.DistrictContact         =  trim(n_amper) 
                wdetail.ProvinceContact         =  trim(n_country) 
                /*wdetail.CountryContact          =  "ไทย" */
                wdetail.ZipCodeContact          =  trim(n_post) .
    END.

    
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_addr2 C-Win 
PROCEDURE proc_addr2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_addr AS CHAR FORMAT "x(255)" INIT "".
def var n_address  as char format "x(550)".
def var n_banno    as char format "x(50)".
def var n_moo      as char format "x(50)".
def var n_floor    as char format "x(50)".
def var n_room     as char format "x(50)".
def var n_build    as char format "x(50)".
def var n_mu       as char format "x(50)".
def var n_soi      as char format "x(50)".
def var n_road     as char format "x(50)".
def var n_tambon   as char format "x(50)".
def var n_amper    as char format "x(50)".
def var n_country  as char format "x(50)".
def var n_post     as char format "x(50)".
DEF VAR n_length   AS INT.

DO:
     ASSIGN  n_length   = 0      n_address  = ""
             n_banno    = ""     n_mu       = ""    
             n_floor    = ""     n_room     = "" 
             n_build    = ""     n_road     = ""   n_soi  = ""      
             n_tambon   = ""     n_amper    = ""          
             n_country  = ""     n_post     = ""
             n_address  = "" .
    IF TRIM(wdetail.UnstructureAddressTax) <> ""  THEN DO:
        ASSIGN  n_address  = TRIM(wdetail.UnstructureAddresstax) .      
           
            IF INDEX(n_address,"จ." ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"จ."),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
                IF index(n_country,"จ.") <> 0 THEN n_country = trim(REPLACE(n_country,"จ.","")) .
            END.
            ELSE IF INDEX(n_address,"จังหวัด" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"จังหวัด"),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length)  ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
                IF index(n_country,"จังหวัด") <> 0 THEN n_country = trim(REPLACE(n_country,"จังหวัด","")) .
            END.
            ELSE IF INDEX(n_address,"กทม" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"กทม"),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
            END.
            ELSE IF INDEX(n_address,"กรุงเทพ" ) <> 0 THEN DO: 
                ASSIGN 
                n_country  =  SUBSTR(n_address,INDEX(n_address,"กรุงเทพ"),LENGTH(n_address))
                n_length   =  LENGTH(n_country)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length)
                n_post     =  IF INDEX(n_country," ") <> 0 THEN SUBSTR(n_country,INDEX(n_country," ") + 1,n_length) ELSE ""
                n_country  =  SUBSTR(n_country,1,n_length - LENGTH(n_post)).
            END.
        
            IF INDEX(n_address,"อ.") <> 0 AND index(n_country,"กทม") = 0 AND index(n_country,"กรุงเทพ") = 0 THEN DO:
                ASSIGN 
                n_amper  =  SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address))
                n_length   =  LENGTH(n_amper)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_amper,"อ.") <> 0 THEN n_amper = trim(REPLACE(n_amper,"อ.","")) .
            END.
            ELSE IF INDEX(n_address,"อำเภอ" ) <> 0 THEN DO: 
                ASSIGN 
                n_amper  =  SUBSTR(n_address,INDEX(n_address,"อำเภอ"),LENGTH(n_address))
                n_length   =  LENGTH(n_amper)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_amper,"อำเภอ") <> 0 THEN n_amper = trim(REPLACE(n_amper,"อำเภอ","")) .
            END.
            ELSE IF INDEX(n_address,"เขต" ) <> 0 THEN DO: 
                ASSIGN 
                n_amper  =  SUBSTR(n_address,INDEX(n_address,"เขต"),LENGTH(n_address))
                n_length   =  LENGTH(n_amper)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                 IF index(n_amper,"เขต") <> 0 THEN n_amper = trim(REPLACE(n_amper,"เขต","")) .
            END.
        
            IF INDEX(n_address,"ต." ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ต."),LENGTH(n_address))
                n_length   =  LENGTH(n_tambon)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_tambon,"ต.") <> 0 THEN n_tambon = trim(REPLACE(n_tambon,"ต.","")) .
            END.
            ELSE IF INDEX(n_address,"ตำบล" ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon  =  SUBSTR(n_address,INDEX(n_address,"ตำบล"),LENGTH(n_address))
                n_length   =  LENGTH(n_tambon)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_tambon,"ตำบล") <> 0 THEN n_tambon = trim(REPLACE(n_tambon,"ตำบล","")) .
            END.
            ELSE IF INDEX(n_address,"แขวง" ) <> 0 THEN DO: 
                ASSIGN 
                n_tambon  =  SUBSTR(n_address,INDEX(n_address,"แขวง"),LENGTH(n_address))
                n_length   =  LENGTH(n_tambon)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
                IF index(n_tambon,"แขวง") <> 0 THEN n_tambon = trim(REPLACE(n_tambon,"แขวง","")) .
            END.
        
            IF INDEX(n_address,"ถ." ) <> 0 THEN DO: 
                ASSIGN 
                n_road  =  SUBSTR(n_address,INDEX(n_address,"ถ."),LENGTH(n_address))
                n_length   =  LENGTH(n_road)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"ถนน" ) <> 0 THEN DO: 
                ASSIGN 
                n_road  =  SUBSTR(n_address,INDEX(n_address,"ถนน"),LENGTH(n_address))
                n_length   =  LENGTH(n_road)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"ซ." ) <> 0 THEN DO: 
                ASSIGN 
                n_soi  =  SUBSTR(n_address,INDEX(n_address,"ซ."),LENGTH(n_address))
                n_length   =  LENGTH(n_soi)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"ซอย" ) <> 0 THEN DO: 
                ASSIGN 
                n_soi  =  SUBSTR(n_address,INDEX(n_address,"ซอย"),LENGTH(n_address))
                n_length   =  LENGTH(n_soi)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"ชั้น" ) <> 0 THEN DO: 
                ASSIGN 
                n_floor   =  SUBSTR(n_address,INDEX(n_address,"ชั้น"),LENGTH(n_address))
                n_length   =  LENGTH(n_floor)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"ห้อง" ) <> 0 THEN DO: 
                ASSIGN 
                n_room  =  SUBSTR(n_address,INDEX(n_address,"ห้อง"),LENGTH(n_address))
                n_length   =  LENGTH(n_room)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"อาคาร" ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"อาคาร"),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"อ." ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"อ."),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"หมู่บ้าน" ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"หมู่บ้าน"),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"บ้าน" ) <> 0 THEN DO: 
                ASSIGN 
                n_build  =  SUBSTR(n_address,INDEX(n_address,"บ้าน"),LENGTH(n_address))
                n_length   =  LENGTH(n_build)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"หมู่ที่" ) <> 0 THEN DO: 
                ASSIGN 
                n_mu  =  SUBSTR(n_address,INDEX(n_address,"หมู่ที่"),LENGTH(n_address))
                n_length   =  LENGTH(n_mu)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"หมู่" ) <> 0 THEN DO: 
                ASSIGN 
                n_mu  =  SUBSTR(n_address,INDEX(n_address,"หมู่"),LENGTH(n_address))
                n_length   =  LENGTH(n_mu)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE IF INDEX(n_address,"ม." ) <> 0 THEN DO: 
                ASSIGN 
                n_mu  =  SUBSTR(n_address,INDEX(n_address,"ม."),LENGTH(n_address))
                n_length   =  LENGTH(n_mu)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
        
            IF INDEX(n_address,"เลขที่" ) <> 0 THEN DO: 
                ASSIGN 
                n_banno  =  SUBSTR(n_address,INDEX(n_address,"เลขที่"),LENGTH(n_address))
                n_length   =  LENGTH(n_banno)
                n_address  =  SUBSTR(n_address,1,LENGTH(n_address) - n_length).
            END.
            ELSE ASSIGN  n_banno   = trim(n_address).
        
            ASSIGN 
                /*wdetail.UnstructureAddresstax = ""  */ /*A63-0299*/
                wdetail.AddressNotax        =  TRIM(n_banno) 
                wdetail.Mootax              =  TRIM(n_mu) 
                wdetail.VillageBuildingtax  =  TRIM(n_build) 
                wdetail.Floortax            =  TRIM(n_floor) 
                wdetail.RoomNumbertax       =  trim(n_room) 
                wdetail.Soitax              =  trim(n_soi) 
                wdetail.Streettax           =  trim(n_road) 
                wdetail.SubDistricttax      =  trim(n_tambon) 
                wdetail.Districttax         =  trim(n_amper) 
                wdetail.Provincetax         =  trim(n_country) 
                /*wdetail.Countrytax          =  "ไทย" */
                wdetail.ZipCodetax          =  trim(n_post) .
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chklength C-Win 
PROCEDURE proc_chklength :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    IF TRIM(nv_length) <> "" THEN  n_length = LENGTH(nv_length). ELSE n_length = 0.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create C-Win 
PROCEDURE proc_create :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_runno = 2
    nv_dateprocess = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99")
    nv_cpol  = 0
    nv_cend  = 0.

FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE (uwm100.trndat   >= nv_trndatfr  AND
                                                uwm100.trndat   <= nv_trndatto) AND
                                                uwm100.acno1     = nv_acno      AND
                                                uwm100.agent     = nv_agent     AND
                                               (uwm100.poltyp   >= nv_poltypfr  AND
                                                uwm100.poltyp   <= nv_poltypto) AND
                                               (uwm100.branch   >= nv_branchfr  AND
                                                uwm100.branch   <= nv_branchto) NO-LOCK :

    IF (ra_release = 1 ) AND (uwm100.releas    = NO) THEN NEXT.       
    ELSE IF (ra_release = 2 ) AND (uwm100.releas    = YES ) THEN NEXT.
    
     IF nv_type = 1 AND uwm100.endcnt > 0  THEN NEXT.  /*A63-0299*/
     IF nv_type = 2 AND uwm100.endcnt < 1  THEN NEXT.  /*A63-0299*/
       
        DISP " Process Data : " uwm100.trndat " " uwm100.policy
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 60 FRAME AAMain VIEW-AS DIALOG-BOX.

        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy   AND
                                                        uwm301.rencnt = uwm100.rencnt   AND
                                                        uwm301.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
        IF AVAIL uwm301 THEN DO: 
            FIND LAST wdetail WHERE wdetail.ReferenceNo = trim(uwm100.policy) NO-ERROR NO-WAIT .
            IF NOT AVAIL wdetail THEN DO:
                CREATE wdetail.
                ASSIGN 
                  wdetail.ReferenceNo               = TRIM(uwm100.policy)
                  n_month                           = MONTH(uwm100.trndat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.TransactionDateTime       = TRIM(STRING(DAY(uwm100.trndat),"99") + "-" +  n_monthtxt  + "-" + STRING(YEAR(uwm100.trndat),"9999"))
                  wdetail.KKInsApplicationNo        = TRIM(uwm100.cedpol)
                  wdetail.InsuredTitleName          = TRIM(uwm100.ntitle)
                  wdetail.InsuredFirstName          = TRIM(uwm100.name1)
                  wdetail.InsuredLastName           = TRIM(uwm100.name2)
                  /* wdetail.UnstructureAddressContact = trim(uwm100.addr1 + " " + uwm100.addr2 + " " + uwm100.addr3 + " " + uwm100.addr4 ) */ /*A63-0299*/
                  wdetail.UnstructureAddressContact = TRIM(uwm100.addr1 + " " + uwm100.addr2 + " " + uwm100.addr3 + " " + uwm100.addr4 + " " + uwm100.postcd)   /*A63-0299*/
                  wdetail.Policyno                  = TRIM(uwm100.policy)
                  wdetail.PayerGender               = ""
                  wdetail.InsuredGender             = ""
                  wdetail.AddressContact            = "Contact"
                  wdetail.AddressTemplateContact    = "U"
                  wdetail.AddressTax                = "Tax"
                  wdetail.AddressTemplateTax        = "U"
                  wdetail.UnstructureAddressTax     = TRIM(uwm100.bs_cd) /* A63-0299*/
                  n_month                           = MONTH(uwm100.accdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.ApproveDate               = TRIM(STRING(DAY(uwm100.accdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.accdat),"9999")) 
                  n_month                           = MONTH(uwm100.accdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.ApplicationDate           = TRIM(STRING(DAY(uwm100.accdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.accdat),"9999")) 
                  n_month                           = MONTH(uwm100.comdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.EffectiveDate             = TRIM(STRING(DAY(uwm100.comdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.comdat),"9999")) 
                  n_month                           = MONTH(uwm100.expdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.ExpireDate                = TRIM(STRING(DAY(uwm100.expdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.expdat),"9999")) 
                  wdetail.FreelookExpired           = wdetail.EffectiveDate
                  wdetail.NetPremium                = uwm100.prem_t
                  wdetail.PremiumAmount             = (uwm100.prem_t + uwm100.rtax_t  + uwm100.rstp_t )
                  wdetail.ChassisNo                 = TRIM(uwm301.cha_no)
                  wdetail.EngineNo                  = TRIM(uwm301.eng_no)
                  wdetail.modelyear                 = STRING(uwm301.yrmanu)
                  wdetail.BeneficiaryName           = TRIM(uwm301.mv_ben83)
                  wdetail.covcod                    = TRIM(uwm301.covcod)
                  wdetail.poltyp                    = TRIM(uwm100.poltyp) 
                  wdetail.producer                  = TRIM(uwm100.acno1) 
                  wdetail.endcnt                    = STRING(uwm100.endcnt,"999") /*A63-0299*/ 
                  wdetail.CountryContact            = "ไทย" /*uwm100.cntry */
                  wdetail.Countrytax                = "ไทย" /*uwm100.cntry */
                  wdetail.NotifiedNO                = ""
                  wdetail.carbrand                  = IF INDEX(uwm301.moddes," ") <> 0 THEN TRIM(SUBSTR(uwm301.moddes,1,INDEX(uwm301.moddes," "))) ELSE ""
                  wdetail.CarLicenseIssue           = IF INDEX(uwm301.vehreg," ") <> 0 THEN TRIM(SUBSTR(uwm301.vehreg,R-INDEX(uwm301.vehreg," "))) ELSE "" 
                  wdetail.CarLicenseNo              = IF INDEX(uwm301.vehreg," ") <> 0 THEN TRIM(SUBSTR(uwm301.vehreg,1,LENGTH(uwm301.vehreg) - LENGTH(wdetail.CarLicenseIssue)))
                                                      ELSE TRIM(uwm301.vehreg)
                  wdetail.CarType                   = "" 
                  wdetail.MaturityAMT               = "0"
                  wdetail.PayerAge                  = ""
                  wdetail.InsuredAge                = "".

               IF SUBSTRING(uwm100.insref,2,1) = "C"            OR SUBSTRING(uwm100.insref,3,1) = "C"   OR 
                      TRIM (uwm100.ntitle)     = "บริษัท"       OR TRIM(uwm100.ntitle) = "บมจ."         OR TRIM(uwm100.ntitle) = "บรรษัท"   OR
                      TRIM (uwm100.ntitle)     = "ห้างหุ้นส่วน" OR TRIM(uwm100.ntitle) = "หจก."         OR TRIM(uwm100.ntitle) = "โรงเรียน" OR 
                      TRIM (uwm100.ntitle)     = "โรงเรียน"     OR TRIM(uwm100.ntitle) = "โรงพยาบาล"    OR TRIM(uwm100.ntitle) = "มูลนิธิ"  THEN  
                   ASSIGN  
                        wdetail.InsuredFirstName       = TRIM(TRIM(uwm100.name1) + " " + TRIM(uwm100.name2))
                        wdetail.InsuredLastName        = "" 
                        wdetail.InsuredCardType        = "003"
                        wdetail.PayerCardType          = "003"
                        wdetail.InsuredType            = "N".
               ELSE DO:
                   nv_index = INDEX(uwm100.name1," ").
                   IF nv_index <> 0 THEN  
                       ASSIGN
                            wdetail.InsuredFirstName = TRIM(SUBSTRING(uwm100.name1,1,nv_index - 1))
                            wdetail.InsuredLastName  = TRIM(SUBSTRING(uwm100.name1,nv_index + 1 ,LENGTH(uwm100.name1) - nv_index)) /*+ " " + uwm100.name2*/
                            wdetail.InsuredCardType  = "001"
                            wdetail.PayerCardType    = "001"
                            wdetail.InsuredType      = "Y".
               END.

               IF wdetail.CarLicenseIssue  <> ""  THEN DO:
                  FIND LAST  brstat.insure USE-INDEX Insure05 WHERE brstat.insure.compno        = "999" AND    /*use-index fname */
                                                              INDEX(brstat.insure.insno,"til")  <> 0    AND 
                                                                    brstat.insure.LName         = TRIM(wdetail.CarLicenseIssue) NO-LOCK NO-ERROR .
                  IF AVAIL brstat.insure THEN
                          ASSIGN  wdetail.CarLicenseIssue = insure.FName 
                                  wdetail.CarLicenseIssue = REPLACE(wdetail.CarLicenseIssue,"til","").

                  FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE INDEX(uwm500.prov_d,wdetail.CarLicenseIssue) <> 0  NO-LOCK NO-ERROR .
                  IF AVAIL uwm500 THEN ASSIGN  wdetail.CarLicenseIssue = uwm500.prov_n .
               END.
               
               FIND LAST bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = uwm100.insref NO-LOCK NO-ERROR .
               IF AVAIL bxmm600 THEN DO:
                   ASSIGN wdetail.InsuredCardNo         = TRIM(bxmm600.icno)
                          wdetail.PayerCardNo           = TRIM(bxmm600.icno).
                          /*wdetail.UnstructureAddressTax = TRIM(trim(bxmm600.naddr1) + " " + trim(bxmm600.naddr2)  + " " + 
                                                          trim(bxmm600.naddr3) + " " + trim(bxmm600.naddr4)) */ /*A63-0299*/ 
                   IF wdetail.UnstructureAddressTax = "" THEN 
                      ASSIGN  wdetail.UnstructureAddressTax = TRIM(TRIM(bxmm600.naddr1) + " " + TRIM(bxmm600.naddr2)  + " " + 
                                                              TRIM(bxmm600.naddr3) + " " + TRIM (bxmm600.naddr4) + " " + TRIM(bxmm600.npostcd)) . /*A63-0299*/
               END.
               /* add by A63-0299 address TAX */
               IF TRIM(wdetail.UnstructureAddressTax) <> "" THEN DO: /* มี VAT CODE */
                   FIND LAST bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = TRIM(wdetail.UnstructureAddressTax) NO-LOCK NO-ERROR .
                   IF AVAIL bxmm600 THEN 
                       ASSIGN wdetail.UnstructureAddressTax  = TRIM(TRIM(bxmm600.addr1) + " " + TRIM(bxmm600.addr2)  + " " + 
                                                               TRIM(bxmm600.addr3) + " " + TRIM(bxmm600.addr4) + " " + TRIM(bxmm600.postcd)) .

               END.
               IF wdetail.UnstructureAddressTax = ""  THEN  ASSIGN  wdetail.UnstructureAddressTax = wdetail.UnstructureAddressContact .
               /* end A63-0299 */

               IF uwm100.poltyp = "V72"  THEN DO:
                   FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                                 insure.branch  = "9"           AND
                                                 insure.icaddr2 = uwm100.acno1  AND
                                                 insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
                   IF AVAIL brstat.insure THEN 
                       ASSIGN wdetail.Packagecode          = TRIM(insure.text4)
                              wdetail.OVRate               = DECI(insure.addr2)
                              wdetail.commrate             = DECI(insure.lname)
                              wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
               END.
               ELSE DO:
                   FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                                 insure.branch  = "X"           AND
                                                 insure.icaddr2 = uwm100.acno1  AND
                                                 insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
                   IF AVAIL brstat.insure THEN
                       ASSIGN wdetail.Packagecode          = TRIM(insure.text4)
                              wdetail.OVRate               = DECI(insure.addr2)
                              wdetail.commrate             = DECI(insure.lname)
                              wdetail.InsuranceCompanyCode = TRIM(insure.text5) .


                   FIND LAST brstat.insure WHERE insure.vatcode = "WHT" NO-LOCK NO-ERROR.
                   IF AVAIL brstat.insure THEN
                       ASSIGN
                          n_rate = DECI(insure.lname)
                          n_wht  = (n_rate * 10 / 1000 ).
 
               END.
               /* A63-0299*/
               IF rs_type = 2 AND wdetail.NetPremium = 0  THEN DO:
                   FOR EACH buwm100 WHERE buwm100.policy = uwm100.policy  NO-LOCK .
                       ASSIGN 
                           wdetail.NetPremium    = wdetail.NetPremium + buwm100.prem_t
                           wdetail.PremiumAmount = wdetail.PremiumAmount + (buwm100.prem_t + buwm100.rtax_t  + buwm100.rstp_t) .
                   END.
               END.
               /* End A63-0299 */


               /*---------- Add By Tontawan S. A64-0104 01/03/2021 ----------*/
               FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                             insure.vatcode = "WHT"         NO-LOCK NO-ERROR.
               IF AVAIL brstat.insure THEN
                       ASSIGN
                          n_rate = DECI(insure.lname)
                          n_wht  = (n_rate * 10 / 1000 ).
               /*-------- End Add By Tontawan S. A64-0104 01/03/2021 -------*/

               ASSIGN /*wdetail.commnet = ROUND(((wdetail.NetPremium * 100 / 107 ) * wdetail.commrate) / 100,2 )*/ /*comment 26/12/2019*/
                      wdetail.commnet   = ROUND((wdetail.NetPremium) * (wdetail.commrate / 100),2 ) 
                      wdetail.commfix   = 0
                      wdetail.commvat   = ROUND((wdetail.commnet * 0.07),2 )
                      /*wdetail.commwht = ROUND((wdetail.commnet * 0.03),2 )      ---------- แก้ไขจาก 3% เป็น 1.5%  25/05/2020 */ 
                      /*wdetail.commwht = ROUND((wdetail.commnet * 0.015),2 )   /*---------- แก้ไขจาก 3% เป็น 1.5%*/ -- Comment By Tontawan S. A64-0104 01/03/2021 */
                      wdetail.commwht   = ROUND((wdetail.commnet * n_wht),2 )   /*---------- Add By Tontawan S. A64-0104 01/03/2021 */
                      wdetail.commamt   = ((wdetail.commnet + wdetail.commvat) - wdetail.commwht )
                      /*wdetail.ovnet   = ROUND(((wdetail.NetPremium * 100 / 107 ) * wdetail.OVRate) / 100,2 )*/ /*comment 26/12/2019*/
                      wdetail.ovnet     = ROUND((wdetail.NetPremium) * (wdetail.OVRate / 100),2 ) 
                      wdetail.ovfix     = 0 
                      wdetail.ovvat     = ROUND((wdetail.ovnet * 0.07),2 )
                      /*wdetail.ovwht   = ROUND((wdetail.ovnet * 0.03),2 )        ----------  แก้ไขจาก 3% เป็น 1.5%  25/05/2020 */ 
                      /*wdetail.ovwht   = ROUND((wdetail.ovnet * 0.015),2 )     /*---------- แก้ไขจาก 3% เป็น 1.5%*/  -- Comment By Tontawan S. A64-0104 01/03/2021 */  
                      wdetail.ovwht     = ROUND((wdetail.ovnet * n_wht),2 )     /*---------- Add By Tontawan S. A64-0104 01/03/2021 */
                      wdetail.ovamt     = ((wdetail.ovnet +  wdetail.ovvat ) - wdetail.ovwht)
                      /*wdetail.PremiumAmount  = ROUND((wdetail.PremiumAmount - wdetail.commwht),2)*/.
                
               FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE 
                         uwm130.policy = uwm301.policy   AND
                         uwm130.rencnt = uwm301.rencnt   AND
                         uwm130.endcnt = uwm301.endcnt   AND
                         uwm130.riskgp = uwm301.riskgp   AND
                         uwm130.riskno = uwm301.riskno   AND
                         uwm130.itemno = uwm301.itemno   NO-LOCK NO-ERROR.
               IF AVAIL uwm130 THEN DO:
                    ASSIGN 
                        wdetail.SumInsure = IF uwm130.uom6_v <> 0 THEN uwm130.uom6_v ELSE uwm130.uom7_v. 
               END.

               RUN proc_addr.
               RUN proc_addr2.
                
               IF nv_type = 2 THEN RUN proc_endors. /* A63-0299 */

               FIND LAST brstat.tlt  USE-INDEX tlt06 WHERE TRIM(tlt.cha_no)      = TRIM(uwm301.cha_no) AND 
                                                          INDEX(tlt.genusr,"KK") <> 0                  AND 
                                                              ((tlt.nor_effdat)  = uwm100.comdat       OR
                                                               (tlt.comp_effdat) = uwm100.comdat)      NO-LOCK NO-ERROR NO-WAIT .
               IF AVAIL brstat.tlt THEN DO:
                   ASSIGN 
                       wdetail.NotifiedNO   = IF uwm100.poltyp = "V72" THEN "" ELSE TRIM(brstat.tlt.comp_noti_tlt)
                       wdetail.CarType      = TRIM(brstat.tlt.filler2) .
               END.
            END. /* not avail */
        END. /* end uwm130 */
       
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create2 C-Win 
PROCEDURE proc_create2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_runno = 2
    nv_dateprocess = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99")
    nv_cpol  = 0
    nv_cend  = 0.

FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = TRIM(fi_acno) NO-LOCK.
    /*IF xmm600.homebr <> "M"   THEN NEXT.*/                        /*A63-00472*/
    IF xmm600.homebr <> "M" AND xmm600.homebr <> "ML" THEN NEXT.    /*A63-00472*/
    FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE (uwm100.trndat   >= nv_trndatfr  AND
                                                    uwm100.trndat   <= nv_trndatto) AND
                                                    uwm100.acno1     = xmm600.acno  AND
                                                   (uwm100.poltyp   >= nv_poltypfr  AND
                                                    uwm100.poltyp   <= nv_poltypto) AND
                                                   (uwm100.branch   >= nv_branchfr  AND
                                                    uwm100.branch   <= nv_branchto) NO-LOCK :

        IF      (ra_release = 1 ) AND (uwm100.releas    = NO)   THEN NEXT.      
        ELSE IF (ra_release = 2 ) AND (uwm100.releas    = YES ) THEN NEXT.  

       /* IF uwm100.endcnt > 0  THEN NEXT.*/ /*A63-0222*/
        IF rs_type = 1 AND uwm100.endcnt > 0  THEN NEXT.  /*A63-0299*/
        IF rs_type = 2 AND uwm100.endcnt < 1  THEN NEXT.  /*A63-0299*/
       
        DISP " Process Data : " uwm100.trndat " " uwm100.policy
        WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 60 FRAME AAMain VIEW-AS DIALOG-BOX.

        FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy   AND
                                                        uwm301.rencnt = uwm100.rencnt   AND
                                                        uwm301.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
        IF AVAIL uwm301 THEN DO: 
                CREATE wdetail.
                ASSIGN 
                  wdetail.ReferenceNo               = TRIM(uwm100.policy)
                  n_month                           = MONTH(uwm100.trndat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.TransactionDateTime       = TRIM(STRING(DAY(uwm100.trndat),"99") + "-" +  n_monthtxt  + "-" + STRING(YEAR(uwm100.trndat),"9999"))
                  wdetail.KKInsApplicationNo        = TRIM(uwm100.cedpol)
                  wdetail.InsuredTitleName          = TRIM(uwm100.ntitle)
                  wdetail.InsuredFirstName          = TRIM(uwm100.name1)
                  wdetail.InsuredLastName           = TRIM(uwm100.name2)
                 /* wdetail.UnstructureAddressContact = trim(uwm100.addr1 + " " + uwm100.addr2 + " " + uwm100.addr3 + " " + uwm100.addr4 ) */ /*A63-0299*/
                  wdetail.UnstructureAddressContact = TRIM(uwm100.addr1 + " " + uwm100.addr2 + " " + uwm100.addr3 + " " + uwm100.addr4 + " " + uwm100.postcd)   /*A63-0299*/
                  wdetail.Policyno                  = TRIM(uwm100.policy)
                  wdetail.PayerGender               = ""
                  wdetail.InsuredGender             = ""
                  wdetail.AddressContact            = "Contact"
                  wdetail.AddressTemplateContact    = "U"
                  wdetail.AddressTax                = "Tax"
                  wdetail.AddressTemplateTax        = "U"         
                  wdetail.UnstructureAddressTax     = TRIM(uwm100.bs_cd) /* A63-0299*/
                  n_month                           = MONTH(uwm100.accdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.ApproveDate               = TRIM(STRING(DAY(uwm100.accdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.accdat),"9999")) 
                  n_month                           = MONTH(uwm100.accdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.ApplicationDate           = TRIM(STRING(DAY(uwm100.accdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.accdat),"9999")) 
                  n_month                           = MONTH(uwm100.comdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.EffectiveDate             = TRIM(STRING(DAY(uwm100.comdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.comdat),"9999")) 
                  n_month                           = MONTH(uwm100.expdat)
                  n_monthtxt                        = TRIM(fn-month(n_month))
                  wdetail.ExpireDate                = TRIM(STRING(DAY(uwm100.expdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.expdat),"9999")) 
                  wdetail.FreelookExpired           = wdetail.EffectiveDate
                  wdetail.NetPremium                = uwm100.prem_t
                  wdetail.PremiumAmount             = (uwm100.prem_t + uwm100.rtax_t  + uwm100.rstp_t )
                  wdetail.ChassisNo                 = TRIM(uwm301.cha_no)
                  wdetail.EngineNo                  = TRIM(uwm301.eng_no)
                  wdetail.modelyear                 = STRING(uwm301.yrmanu)
                  wdetail.BeneficiaryName           = TRIM(uwm301.mv_ben83)
                  wdetail.covcod                    = TRIM(uwm301.covcod)
                  wdetail.poltyp                    = TRIM(uwm100.poltyp)
                  wdetail.producer                  = TRIM(uwm100.acno1) 
                  wdetail.endcnt                    = STRING(uwm100.endcnt,"999") /*A63-0299*/ 
                  wdetail.CountryContact            = "ไทย" /*uwm100.cntry */
                  wdetail.Countrytax                = "ไทย" /*uwm100.cntry */
                  wdetail.NotifiedNO                = ""
                  wdetail.carbrand                  = IF INDEX(uwm301.moddes," ") <> 0 THEN TRIM(SUBSTR(uwm301.moddes,1,INDEX(uwm301.moddes," "))) ELSE ""
                  wdetail.CarLicenseIssue           = IF INDEX(uwm301.vehreg," ") <> 0 THEN TRIM(SUBSTR(uwm301.vehreg,R-INDEX(uwm301.vehreg," "))) ELSE "" 
                  wdetail.CarLicenseNo              = IF INDEX(uwm301.vehreg," ") <> 0 THEN TRIM(SUBSTR(uwm301.vehreg,1,LENGTH(uwm301.vehreg) - LENGTH(wdetail.CarLicenseIssue)))
                                                      ELSE TRIM(uwm301.vehreg)
                  wdetail.CarType                   = "" 
                  wdetail.MaturityAMT               = "0"
                  wdetail.PayerAge                  = ""
                  wdetail.InsuredAge                = "" .              

               IF SUBSTRING(uwm100.insref,2,1) = "C"            OR SUBSTRING(uwm100.insref,3,1) = "C"         OR 
                       TRIM(uwm100.ntitle)     = "บริษัท"       OR TRIM(uwm100.ntitle)          = "บมจ."      OR TRIM(uwm100.ntitle) = "บรรษัท"   OR
                       TRIM(uwm100.ntitle)     = "ห้างหุ้นส่วน" OR TRIM(uwm100.ntitle)          = "หจก."      OR TRIM(uwm100.ntitle) = "โรงเรียน" OR
                       TRIM(uwm100.ntitle)     = "โรงเรียน"     OR TRIM(uwm100.ntitle)          = "โรงพยาบาล" OR TRIM(uwm100.ntitle) = "มูลนิธิ"  THEN  

                   ASSIGN  
                        wdetail.InsuredFirstName = TRIM(TRIM(uwm100.name1) + " " + TRIM(uwm100.name2))
                        wdetail.InsuredLastName  = "" 
                        wdetail.InsuredCardType  = "003"
                        wdetail.PayerCardType    = "003"
                        wdetail.InsuredType      = "N".
               ELSE DO:
                   nv_index = INDEX(uwm100.name1," ").
                   IF nv_index <> 0 THEN  
                       ASSIGN
                            wdetail.InsuredFirstName = TRIM(SUBSTRING(uwm100.name1,1,nv_index - 1))
                            wdetail.InsuredLastName  = TRIM(SUBSTRING(uwm100.name1,nv_index + 1 ,LENGTH(uwm100.name1) - nv_index)) /*+ " " + uwm100.name2*/
                            wdetail.InsuredCardType  = "001"
                            wdetail.PayerCardType    = "001"
                            wdetail.InsuredType      = "Y".
               END.

               IF wdetail.CarLicenseIssue  <> ""  THEN DO:
                  FIND LAST  brstat.insure USE-INDEX Insure05 WHERE brstat.insure.compno        = "999"                         AND /*use-index fname */
                                                              INDEX(brstat.insure.insno,"til") <> 0                             AND 
                                                                    brstat.insure.LName         = TRIM(wdetail.CarLicenseIssue) NO-LOCK NO-ERROR .
                  IF AVAIL brstat.insure THEN
                          ASSIGN  wdetail.CarLicenseIssue = insure.FName 
                                  wdetail.CarLicenseIssue = REPLACE(wdetail.CarLicenseIssue,"til","").

                  FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE index(uwm500.prov_d,wdetail.CarLicenseIssue) <> 0 NO-LOCK NO-ERROR .
                  IF AVAIL uwm500 THEN ASSIGN wdetail.CarLicenseIssue = uwm500.prov_n.
               END.
               
               FIND LAST bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = uwm100.insref NO-LOCK NO-ERROR .
               IF AVAIL bxmm600 THEN DO:
                   ASSIGN wdetail.InsuredCardNo         = TRIM(bxmm600.icno)
                          wdetail.PayerCardNo           = TRIM(bxmm600.icno) .
                          /*wdetail.UnstructureAddressTax = TRIM(trim(bxmm600.naddr1) + " " + trim(bxmm600.naddr2)  + " " + 
                                                          trim(bxmm600.naddr3) + " " + trim(bxmm600.naddr4))  .*/ /*A63-0299*/
                   IF wdetail.UnstructureAddressTax = "" THEN 
                      ASSIGN  wdetail.UnstructureAddressTax = TRIM(TRIM(bxmm600.naddr1) + " " + TRIM(bxmm600.naddr2)  + " " + 
                                                              TRIM(bxmm600.naddr3) + " " + TRIM(bxmm600.naddr4) + " " + TRIM(bxmm600.npostcd)) . /*A63-0299*/
               END.
               /* add by A63-0299 address TAX */
               IF TRIM(wdetail.UnstructureAddressTax) <> "" THEN DO: /* มี VAT CODE */
                   FIND LAST bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = TRIM(wdetail.UnstructureAddressTax) NO-LOCK NO-ERROR .
                   IF AVAIL bxmm600 THEN 
                        ASSIGN wdetail.UnstructureAddressTax  = TRIM(TRIM(bxmm600.addr1) + " " + TRIM(bxmm600.addr2)  + " " + 
                                                                TRIM(bxmm600.addr3) + " " + TRIM(bxmm600.addr4) + " " + TRIM(bxmm600.postcd)) . 
               END.
               IF wdetail.UnstructureAddressTax = ""  THEN ASSIGN wdetail.UnstructureAddressTax = wdetail.UnstructureAddressContact .
               /* end A63-0299 */

               IF uwm100.poltyp = "V72"  THEN DO:
                   FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                                 insure.branch  = "9"           AND
                                                 insure.icaddr2 = uwm100.acno1  AND
                                                 insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
                   IF AVAIL brstat.insure THEN 
                       ASSIGN 
                            wdetail.Packagecode          = TRIM(insure.text4)
                            wdetail.OVRate               = DECI(insure.addr2)
                            wdetail.commrate             = DECI(insure.lname) 
                            wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
               END.
               ELSE DO:
                   FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                                 insure.branch  = "X"           AND
                                                 insure.icaddr2 = uwm100.acno1  AND
                                                 insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
                   IF AVAIL brstat.insure THEN
                       ASSIGN 
                            wdetail.Packagecode          = TRIM(insure.text4)
                            wdetail.OVRate               = DECI(insure.addr2)
                            wdetail.commrate             = DECI(insure.lname) 
                            wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
               END.
                /* a63-0299*/
               IF rs_type = 2 AND wdetail.NetPremium = 0  THEN DO:
                   FOR EACH buwm100 WHERE buwm100.policy = uwm100.policy NO-LOCK .
                       ASSIGN 
                            wdetail.NetPremium     =  wdetail.NetPremium + buwm100.prem_t
                            wdetail.PremiumAmount  =  wdetail.PremiumAmount + (buwm100.prem_t + buwm100.rtax_t  + buwm100.rstp_t) .
                   END.
               END.
               /* end A63-0299 */

               /*---------- Add By Tontawan S. A64-0104 01/03/2021 ----------*/
               FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                             insure.vatcode = "WHT"         NO-LOCK NO-ERROR.
               IF AVAIL brstat.insure THEN
                      ASSIGN
                         n_rate = DECI(insure.lname)
                         n_wht  = (n_rate * 10 / 1000 ).
               /*-------- End Add By Tontawan S. A64-0104 01/03/2021 -------*/

               ASSIGN /*wdetail.commnet = ROUND(((wdetail.NetPremium * 100 / 107 ) * wdetail.commrate) / 100,2 ) */ /*comment 26/12/2019*/
                    wdetail.commnet     = ROUND((wdetail.NetPremium) * (wdetail.commrate / 100),2 ) 
                    wdetail.commfix     = 0                                                                          
                    wdetail.commvat     = ROUND((wdetail.commnet * 0.07),2 )                                         
                    /*wdetail.commwht   = ROUND((wdetail.commnet * 0.03),2 )    ---------- แก้ไขจาก 3% เป็น 1.5% */    
                    /*wdetail.commwht   = ROUND((wdetail.commnet * 0.015),2 )   ---------- Comment By Tontawan S. A64-0104 01/03/2021 */
                    wdetail.commwht     = ROUND((wdetail.commnet * n_wht),2 ) /*---------- Add By Tontawan S. A64-0104 01/03/2021 */
                    wdetail.commamt     = ((wdetail.commnet + wdetail.commvat) - wdetail.commwht )                   
                    /*wdetail.ovnet     = ROUND(((wdetail.NetPremium * 100 / 107 ) * wdetail.OVRate) / 100,2 ) */ /*comment 26/12/2019*/
                    wdetail.ovnet       = ROUND((wdetail.NetPremium) * (wdetail.OVRate / 100),2 ) 
                    wdetail.ovfix       = 0                                                                          
                    wdetail.ovvat       = ROUND((wdetail.ovnet * 0.07),2 )                                           
                    /*wdetail.ovwht     = ROUND((wdetail.ovnet * 0.03),2 )      ---------- แก้ไขจาก 3% เป็น 1.5% */ 
                    /*wdetail.ovwht     = ROUND((wdetail.ovnet * 0.015),2 )     ---------- Comment By Tontawan S. A64-0104 01/03/2021 */
                    wdetail.ovwht       = ROUND((wdetail.ovnet * n_wht),2 )   /*---------- Add By Tontawan S. A64-0104 01/03/2021 */
                    wdetail.ovamt       = ((wdetail.ovnet +  wdetail.ovvat ) - wdetail.ovwht)                        
                    /*wdetail.PremiumAmount  = ROUND((wdetail.PremiumAmount - wdetail.commwht),2)*/ .

               FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE uwm130.policy = uwm301.policy AND
                                                               uwm130.rencnt = uwm301.rencnt AND
                                                               uwm130.endcnt = uwm301.endcnt AND
                                                               uwm130.riskgp = uwm301.riskgp AND
                                                               uwm130.riskno = uwm301.riskno AND
                                                               uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR.
               IF AVAIL uwm130 THEN DO:
                    ASSIGN 
                        wdetail.SumInsure = IF uwm130.uom6_v <> 0 THEN uwm130.uom6_v ELSE uwm130.uom7_v . 
               END.

               RUN proc_addr.
               RUN proc_addr2.

               IF rs_type = 2 THEN RUN proc_endors. /* a63-0299 */

               FIND LAST brstat.tlt  USE-INDEX tlt06 WHERE TRIM(tlt.cha_no)      = TRIM(uwm301.cha_no) AND
                                                          INDEX(tlt.genusr,"KK") <> 0                  AND 
                                                              ((tlt.nor_effdat)  = (uwm100.comdat)     OR
                                                               (tlt.comp_effdat) = (uwm100.comdat))    NO-LOCK NO-ERROR NO-WAIT .
               IF AVAIL brstat.tlt THEN DO:
                   ASSIGN
                      wdetail.NotifiedNO = IF uwm100.poltyp = "V72" THEN "" ELSE TRIM(brstat.tlt.comp_noti_tlt)
                      wdetail.CarType    = TRIM(brstat.tlt.filler2) .
               END.
        END.
    END.  /*uwm100*/
END.      /* xmm600 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create3 C-Win 
PROCEDURE proc_create3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_lacno AS CHAR INIT "".
ASSIGN
    nv_runno = 2
    nv_dateprocess = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99")
    nv_cpol  = 0
    nv_cend  = 0.
 IF INDEX(nv_output,".csv") = 0 THEN nv_output = nv_output + ".xls".
  ELSE nv_output = REPLACE(nv_output,".csv",".XLS").
IF ra_typproducer = 1 THEN DO:
    FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = TRIM(fi_acno) NO-LOCK.
        
        /*IF xmm600.homebr <> "M"   THEN NEXT.*/                        /*A63-00472*/
        IF xmm600.homebr <> "M" AND xmm600.homebr <> "ML" THEN NEXT.    /*A63-00472*/
        IF nv_lacno = "" THEN nv_lacno = xmm600.acno.
        ELSE nv_lacno =  nv_lacno + "," + xmm600.acno.
    END.
    IF  nv_lacno <> "" THEN DO:
        loop_for1:
        FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE (uwm100.trndat   >= nv_trndatfr  AND
                                                        uwm100.trndat   <= nv_trndatto) AND
                                                        LOOKUP(uwm100.acno1,nv_lacno) <> 0  AND
                                                       (uwm100.poltyp   >= nv_poltypfr  AND
                                                        uwm100.poltyp   <= nv_poltypto) AND
                                                       (uwm100.branch   >= nv_branchfr  AND
                                                        uwm100.branch   <= nv_branchto) AND 
                                                        uwm100.endcnt    = 0  NO-LOCK:
            IF      (ra_release = 1 ) AND (uwm100.releas    = NO)   THEN NEXT.      
            ELSE IF (ra_release = 2 ) AND (uwm100.releas    = YES ) THEN NEXT.  
    
           /* IF uwm100.endcnt > 0  THEN NEXT.*/ /*A63-0222*/
            IF rs_type = 1 AND uwm100.endcnt > 0  THEN NEXT.  /*A63-0299*/
            IF rs_type = 2 AND uwm100.endcnt < 1  THEN NEXT.  /*A63-0299*/
           
            DISP " Process Data : " uwm100.trndat " " uwm100.policy
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 60 FRAME AAMain3 VIEW-AS DIALOG-BOX.
    
    
          
            
            
            
            FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy   AND
                                                        uwm301.rencnt = uwm100.rencnt   AND
                                                        uwm301.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
            IF AVAIL uwm301 THEN DO:
                
                 IF ra_s = 2 THEN DO: 
                     IF rs_type = 1 THEN RUN proc_create31.
                     ELSE RUN proc_create33.
                 END.
                 ELSE RUN proc_create32.
                 
            END.
     
            
        END.  /*uwm100*/
    END.

END.
ELSE DO:
    FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE (uwm100.trndat   >= nv_trndatfr  AND
                                                    uwm100.trndat   <= nv_trndatto) AND
                                                    uwm100.acno1     = nv_acno      AND
                                                    uwm100.agent     = nv_agent     AND
                                                   (uwm100.poltyp   >= nv_poltypfr  AND
                                                    uwm100.poltyp   <= nv_poltypto) AND
                                                   (uwm100.branch   >= nv_branchfr  AND
                                                    uwm100.branch   <= nv_branchto)  AND 
                                                        uwm100.endcnt    = 0         NO-LOCK :
    
        IF (ra_release = 1 ) AND (uwm100.releas    = NO) THEN NEXT.       
        ELSE IF (ra_release = 2 ) AND (uwm100.releas    = YES ) THEN NEXT.
        
         IF nv_type = 1 AND uwm100.endcnt > 0  THEN NEXT.  /*A63-0299*/
         IF nv_type = 2 AND uwm100.endcnt < 1  THEN NEXT.  /*A63-0299*/
           
            DISP " Process Data : " uwm100.trndat " " uwm100.policy
                WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 60 FRAME AAMain4 VIEW-AS DIALOG-BOX.
         
         FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy   AND
                                                     uwm301.rencnt = uwm100.rencnt   AND
                                                     uwm301.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
         IF AVAIL uwm301 THEN DO:
             IF ra_s = 2 THEN DO:
                 IF rs_type = 1 THEN RUN proc_create31.
                 ELSE RUN proc_create33.
             END.
             ELSE RUN proc_create32.
         END.
      
    END.
END.
IF ra_s = 2 THEN DO:
    IF rs_type = 1 THEN RUN proc_export2.
    ELSE RUN proc_export4.
END.
ELSE RUN proc_export3.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create31 C-Win 
PROCEDURE proc_create31 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_stype AS CHAR INIT "".

        CREATE wdetail.
        ASSIGN 
          wdetail.ReferenceNo               = ""
          wdetail.TransactionDateTime       = ""
          wdetail.InsuredCardType           = ""
          wdetail.InsuredCardNo             = ""
          wdetail.KKInsApplicationNo        = TRIM(uwm100.cedpol)
          wdetail.InsuranceCompanyCode      = ""
          wdetail.Policyno                  = TRIM(uwm100.policy)
          n_month                           = MONTH(uwm100.accdat)
          n_monthtxt                        = TRIM(fn-month(n_month))
          wdetail.ApproveDate               = TRIM(STRING(DAY(uwm100.accdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.accdat),"9999")) 
          n_month                           = MONTH(uwm100.comdat)
          n_monthtxt                        = TRIM(fn-month(n_month))
          wdetail.EffectiveDate             = TRIM(STRING(DAY(uwm100.comdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.comdat),"9999")) 
          n_month                           = MONTH(uwm100.expdat)
          n_monthtxt                        = TRIM(fn-month(n_month))
          wdetail.ExpireDate                = TRIM(STRING(DAY(uwm100.expdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.expdat),"9999")) 
          wdetail.Packagecode               = ""
          wdetail.CommFix                   = 0
          wdetail.CommNet                   = 0
          wdetail.CommAmt                   = 0
          /**/
          wdetail.reasoncode                = "" /*ems*/
          wdetail.NotifiedNO                = ""
          wdetail.ChassisNo                 = TRIM(uwm301.cha_no)
          wdetail.NetPremium                = uwm100.prem_t
          wdetail.PremiumAmount             = (uwm100.prem_t + uwm100.rtax_t  + uwm100.rstp_t )
          wdetail.TransactionDateTime       = TRIM(STRING(DAY(uwm100.trndat),"99") + "-" +  n_monthtxt  + "-" + STRING(YEAR(uwm100.trndat),"9999"))

           wdetail.NotifiedNO   = uwm100.s_tel[1]
           wdetail.ReferenceNo  = uwm100.s_tel[2].

        IF SUBSTRING(uwm100.insref,2,1) = "C"            OR SUBSTRING(uwm100.insref,3,1) = "C"         OR 
               TRIM(uwm100.ntitle)     = "บริษัท"       OR TRIM(uwm100.ntitle)          = "บมจ."      OR TRIM(uwm100.ntitle) = "บรรษัท"   OR
               TRIM(uwm100.ntitle)     = "ห้างหุ้นส่วน" OR TRIM(uwm100.ntitle)          = "หจก."      OR TRIM(uwm100.ntitle) = "โรงเรียน" OR
               TRIM(uwm100.ntitle)     = "โรงเรียน"     OR TRIM(uwm100.ntitle)          = "โรงพยาบาล" OR TRIM(uwm100.ntitle) = "มูลนิธิ"  THEN  
           ASSIGN  
                wdetail.InsuredCardType  = "003".
        ELSE DO:
           nv_index = INDEX(uwm100.name1," ").
           IF nv_index <> 0 THEN  
               ASSIGN
                    wdetail.InsuredCardType  = "001"
                   .
        END.
       
       FIND LAST bxmm600 USE-INDEX xmm60001 WHERE bxmm600.acno = uwm100.insref NO-LOCK NO-ERROR .
       IF AVAIL bxmm600 THEN DO:
           ASSIGN wdetail.InsuredCardNo         = TRIM(bxmm600.icno).
              
       END.

       
       IF uwm100.poltyp <> "V70"  THEN DO:
           nv_stype = "บัง".
           FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                         insure.branch  = "9"           AND
                                         insure.icaddr2 = uwm100.acno1  AND
                                         insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
           IF AVAIL brstat.insure THEN 
               ASSIGN 
                    wdetail.Packagecode          = TRIM(insure.text4)
                    wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
       END.
       ELSE DO:
           nv_stype = "เภท".
           FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                         insure.branch  = "X"           AND
                                         insure.icaddr2 = uwm100.acno1  AND
                                         insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
           IF AVAIL brstat.insure THEN
               ASSIGN 
                    wdetail.Packagecode          = TRIM(insure.text4)
                    wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
       END.
      
       IF rs_type = 2 AND wdetail.NetPremium = 0  THEN DO:
           FOR EACH buwm100 WHERE buwm100.policy = uwm100.policy NO-LOCK .
               ASSIGN 
                    wdetail.NetPremium     =  wdetail.NetPremium + buwm100.prem_t
                    wdetail.PremiumAmount  =  wdetail.PremiumAmount + (buwm100.prem_t + buwm100.rtax_t  + buwm100.rstp_t) .
           END.
       END.


       FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE uwm130.policy = uwm301.policy AND
                                                       uwm130.rencnt = uwm301.rencnt AND
                                                       uwm130.endcnt = uwm301.endcnt AND
                                                       uwm130.riskgp = uwm301.riskgp AND
                                                       uwm130.riskno = uwm301.riskno AND
                                                       uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR.
       IF AVAIL uwm130 THEN DO:
            ASSIGN 
                wdetail.SumInsure = IF uwm130.uom6_v <> 0 THEN uwm130.uom6_v ELSE uwm130.uom7_v . 
       END.

       IF rs_type = 2 THEN RUN proc_endors. /* a63-0299 */


  


       /*--
       FIND LAST brstat.tlt  USE-INDEX tlt06 WHERE TRIM(tlt.cha_no)      = TRIM(uwm301.cha_no) AND
                                                  INDEX(tlt.genusr,"KK") <> 0                  AND 
                                                      ((tlt.nor_effdat)  = (uwm100.comdat)     OR
                                                       (tlt.comp_effdat) = (uwm100.comdat))    AND

                                                        (tlt.expotim      = wdetail.KKInsApplicationNo OR
                                                         index(tlt.covcod, nv_stype) <> 0  )  NO-LOCK NO-ERROR NO-WAIT .
       IF AVAIL brstat.tlt THEN DO:
           ASSIGN
              wdetail.NotifiedNO              = TRIM(brstat.tlt.comp_noti_tlt)
              wdetail.ReferenceNo             = tlt.note2 
              wdetail.TransactionDateTime     = tlt.note26 
              wdetail.CommFix                 = tlt.comp_coamt 
              wdetail.CommNet                 = tlt.comp_grprm 
              wdetail.CommAmt                 = tlt.prem_amt 
              wdetail.Packagecode             = tlt.pack.
           IF wdetail.KKInsApplicationNo  <>  tlt.expotim AND
               tlt.expotim <> "" THEN DO:
               IF index(tlt.expotim,wdetail.KKInsApplicationNo) <> 0 THEN wdetail.KKInsApplicationNo = tlt.expotim.
           END.
              
       END.--*/
       RUN pd_ems.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create32 C-Win 
PROCEDURE proc_create32 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR  nv_stype  AS CHAR INIT "".
       FIND FIRST acm001 USE-INDEX acm00101 WHERE acm001.trnty1 = uwm100.trty11 AND
                                                  acm001.docno  = uwm100.docno1 AND
                                                  acm001.policy = uwm100.policy AND
                                                  acm001.rencnt = uwm100.rencnt AND
                                                  acm001.endcnt = uwm100.endcnt NO-LOCK NO-ERROR.
       IF AVAIL acm001 THEN DO:
           IF acm001.bal = 0   THEN DO:
               FIND LAST wdetail WHERE  wdetail.Policyno                  = TRIM(uwm100.policy) NO-ERROR NO-WAIT.
               IF NOT AVAIL wdetail THEN  DO :
                   CREATE wdetail.
                
                    ASSIGN 
                      wdetail.KKInsApplicationNo        = TRIM(uwm100.cedpol)
                      wdetail.InsuranceCompanyCode      = ""
                      wdetail.Policyno                  = TRIM(uwm100.policy)
                        wdetail.PremiumAmount           =   acm001.prem  + 
                                                            acm001.tax   + 
                                                            ACM001.stamp .

                    ASSIGN
                        wdetail.EffectiveDate              = STRING(YEAR(acm001.latdat),"9999")
                        n_month                           = MONTH(acm001.latdat)
                        n_monthtxt                        = TRIM(fn-month(n_month))
                        wdetail.ApproveDate               = TRIM(STRING(DAY(acm001.latdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(acm001.latdat),"9999")) 
                        wdetail.InsuredCardType  =  uwm100.s_tel[3]  /*KK Quotation No*/   
                        wdetail.InsuredCardNo    =  uwm100.s_tel[4]  /*RiderNo*/    
                       wdetail.PaymentMode    = "F" 
                       wdetail.PaymentPeriod  = "Y" 
                       wdetail.yr             = STRING( 1)   .  
    
                   IF uwm100.poltyp <> "V70"  THEN DO:
                       nv_stype = "บัง".
                       FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                                     insure.branch  = "9"           AND
                                                     insure.icaddr2 = uwm100.acno1  AND
                                                     insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
                       IF AVAIL brstat.insure THEN 
                           ASSIGN 
                                wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
                   END.
                   ELSE DO:
                       nv_stype = "เภท".
                       FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                                     insure.branch  = "X"           AND
                                                     insure.icaddr2 = uwm100.acno1  AND
                                                     insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
                       IF AVAIL brstat.insure THEN
                           ASSIGN 
                                wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
                   END.
               END.
               ELSE DO:
                    wdetail.PremiumAmount           =   wdetail.PremiumAmount +  acm001.netamt.
               END.

           END.
        END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create33 C-Win 
PROCEDURE proc_create33 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nv_stype AS CHAR INIT "".

        CREATE wdetail.
        ASSIGN
            wdetail.KKInsApplicationNo        = TRIM(uwm100.cedpol)
            wdetail.NotifiedNO                = trim(uwm100.s_tel[4]  )  /*rider no*/
            wdetail.InsuranceCompanyCode      = ""
            wdetail.InsuredTitleName          = trim(uwm100.ntitle    )
            wdetail.InsuredFirstName          = trim(uwm100.firstname )
            wdetail.InsuredLastName           = trim(uwm100.lastname  )
            wdetail.BeneficiaryType           = ""
            wdetail.BeneficiaryName           = TRIM(uwm301.mv_ben83)
            wdetail.Policyno                  = TRIM(uwm100.policy)
            n_month                           = MONTH(uwm100.comdat)
            n_monthtxt                        = TRIM(fn-month(n_month))
            wdetail.EffectiveDate             = TRIM(STRING(DAY(uwm100.comdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.comdat),"9999")) 
            n_month                           = MONTH(uwm100.expdat)
            n_monthtxt                        = TRIM(fn-month(n_month))
            wdetail.ExpireDate                = TRIM(STRING(DAY(uwm100.expdat),"99") + "-" +  n_monthtxt + "-" + STRING(YEAR(uwm100.expdat),"9999")) 
/*Year
PaymentPeriod*/



            wdetail.SumInsure                 = 0
            wdetail.NetPremium                = uwm100.prem_t

            wdetail.PremiumAmount             = (uwm100.prem_t + uwm100.rtax_t  + uwm100.rstp_t )

            .
        InsuredCardNo  = "".
        FIND xmm600 WHERE xmm600.acno = uwm100.insref NO-LOCK NO-ERROR.
        IF AVAIL xmm600 THEN wdetail.InsuredCardNo  = xmm600.icno.
        IF TRIM(uwm100.firstname + uwm100.lastname) = "" THEN DO:
            wdetail.InsuredFirstName = uwm100.name1.
            IF INDEX(uwm100.name1," ") <> 0 THEN DO:
                ASSIGN
                    wdetail.InsuredFirstName  = trim(substr(uwm100.name1,1,INDEX(uwm100.name1," ")) )
                    wdetail.InsuredLastName   = trim(substr(uwm100.name1,INDEX(uwm100.name1," "))   ) .
            END.
        END.

        wdetail.BeneficiaryType  = "".
       /*--
        IF      index(wdetail.beneficiaryname,    "บริษัท"       )  = 1 or
                index(wdetail.beneficiaryname,    "บมจ."         )  = 1 or
                index(wdetail.beneficiaryname,    "บรรษัท"       )  = 1 or
                index(wdetail.beneficiaryname,    "ห้างหุ้นส่วน" )  = 1 or
                index(wdetail.beneficiaryname,    "หจก"          )  = 1   or
                index(wdetail.beneficiaryname,    "โรงเรียน"     )  = 1 or
                index(wdetail.beneficiaryname,    "โรงพยาบาล"    )  = 1  or
                index(wdetail.beneficiaryname,    "มูลนิธิ"      )  = 1  or
                index(wdetail.beneficiaryname,    "Company"      ) <> 0   or
                index(wdetail.beneficiaryname,    "Co."          ) <> 0   or
                index(wdetail.beneficiaryname,    "Limited"      ) <> 0   or
                index(wdetail.beneficiaryname,    "Ltd."         ) <> 0   or
                index(wdetail.beneficiaryname,    "Shop"         ) <> 0   or
                index(wdetail.beneficiaryname,    "ธนาคาร"         ) <> 0   or
                index(wdetail.beneficiaryname,    "ร้าน"         ) = 1   THEN wdetail.BeneficiaryType  = "N".
        ELSE  IF      index(wdetail.beneficiaryname,    "นาย"       )  = 1 OR 
             index(wdetail.beneficiaryname,    "นาง"       )  = 1 OR
             index(wdetail.beneficiaryname,    "คุณ "       )  = 1 THEN wdetail.BeneficiaryType  = "Y".  */

        FIND LAST sicuw.uwm130 USE-INDEX uwm13001 WHERE uwm130.policy = uwm301.policy AND
                                                       uwm130.rencnt = uwm301.rencnt AND
                                                       uwm130.endcnt = uwm301.endcnt AND
                                                       uwm130.riskgp = uwm301.riskgp AND
                                                       uwm130.riskno = uwm301.riskno AND
                                                       uwm130.itemno = uwm301.itemno NO-LOCK NO-ERROR.
       IF AVAIL uwm130 THEN DO:
            ASSIGN 
                wdetail.SumInsure = IF uwm130.uom6_v <> 0 THEN uwm130.uom6_v ELSE uwm130.uom7_v . 
       END.

       IF uwm100.poltyp <> "V70"  THEN DO:
           nv_stype = "บัง".
           FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                         insure.branch  = "9"           AND
                                         insure.icaddr2 = uwm100.acno1  AND
                                         insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
           IF AVAIL brstat.insure THEN 
               ASSIGN 
                    wdetail.OVRate               = DECI(insure.addr2)
                    wdetail.commrate             = DECI(insure.lname)
                    wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
       END.
       ELSE DO:
           nv_stype = "เภท".
           FIND LAST brstat.insure WHERE insure.compno  = "CAMCODE_KK"  AND 
                                         insure.branch  = "X"           AND
                                         insure.icaddr2 = uwm100.acno1  AND
                                         insure.vatcode = uwm301.covcod NO-LOCK NO-ERROR.
           IF AVAIL brstat.insure THEN
               ASSIGN 
                    wdetail.OVRate               = DECI(insure.addr2)
                    wdetail.commrate             = DECI(insure.lname)
                    wdetail.InsuranceCompanyCode = TRIM(insure.text5) .
       END.
      
       IF rs_type = 2 AND wdetail.NetPremium = 0  THEN DO:
           FOR EACH buwm100 WHERE buwm100.policy = uwm100.policy NO-LOCK .
               ASSIGN 
                    wdetail.NetPremium     =  wdetail.NetPremium + buwm100.prem_t
                    wdetail.PremiumAmount  =  wdetail.PremiumAmount + (buwm100.prem_t + buwm100.rtax_t  + buwm100.rstp_t) .
           END.
       END.
       IF SUBSTRING(uwm100.insref,2,1) = "C"            OR SUBSTRING(uwm100.insref,3,1) = "C"   OR 
                     TRIM (uwm100.ntitle)     = "บริษัท"       OR TRIM(uwm100.ntitle) = "บมจ."         OR TRIM(uwm100.ntitle) = "บรรษัท"   OR
                     TRIM (uwm100.ntitle)     = "ห้างหุ้นส่วน" OR TRIM(uwm100.ntitle) = "หจก."         OR TRIM(uwm100.ntitle) = "โรงเรียน" OR 
                     TRIM (uwm100.ntitle)     = "โรงเรียน"     OR TRIM(uwm100.ntitle) = "โรงพยาบาล"    OR TRIM(uwm100.ntitle) = "มูลนิธิ"  THEN   DO:

           ASSIGN
               n_rate = DECI(insure.lname)
               n_wht  = (n_rate * 10 / 1000 ).

       END.
       ELSE 
           ASSIGN
               n_rate = 0
               n_wht  = 0 .
       IF rs_type = 2 THEN RUN proc_endors. /* a63-0299 */

wdetail.yr             = STRING(1)   .
  


       /*--
       FIND LAST brstat.tlt  USE-INDEX tlt06 WHERE TRIM(tlt.cha_no)      = TRIM(uwm301.cha_no) AND
                                                  INDEX(tlt.genusr,"KK") <> 0                  AND 
                                                      ((tlt.nor_effdat)  = (uwm100.comdat)     OR
                                                       (tlt.comp_effdat) = (uwm100.comdat))    AND

                                                        (tlt.expotim      = wdetail.KKInsApplicationNo OR
                                                         index(tlt.covcod, nv_stype) <> 0  )  NO-LOCK NO-ERROR NO-WAIT .
       IF AVAIL brstat.tlt THEN DO:
           ASSIGN
              wdetail.NotifiedNO              = TRIM(brstat.tlt.comp_noti_tlt)
              wdetail.ReferenceNo             = tlt.note2 
              wdetail.TransactionDateTime     = tlt.note26 
              wdetail.CommFix                 = tlt.comp_coamt 
              wdetail.CommNet                 = tlt.comp_grprm 
              wdetail.CommAmt                 = tlt.prem_amt 
              wdetail.Packagecode             = tlt.pack.
           IF wdetail.KKInsApplicationNo  <>  tlt.expotim AND
               tlt.expotim <> "" THEN DO:
               IF index(tlt.expotim,wdetail.KKInsApplicationNo) <> 0 THEN wdetail.KKInsApplicationNo = tlt.expotim.
           END.
              
       END.--*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create4 C-Win 
PROCEDURE proc_create4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_lacno AS CHAR INIT "".
ASSIGN
    nv_runno = 2
    nv_dateprocess = STRING(YEAR(TODAY),"9999") + STRING(MONTH(TODAY),"99") + STRING(DAY(TODAY),"99")
    nv_cpol  = 0
    nv_cend  = 0.
 IF INDEX(nv_output,".csv") = 0 THEN nv_output = nv_output + ".xls".
  ELSE nv_output = REPLACE(nv_output,".csv",".XLS").
IF ra_typproducer = 1 THEN DO:
    FOR EACH sicsyac.xmm600 USE-INDEX xmm60009 WHERE xmm600.gpstmt = TRIM(fi_acno) NO-LOCK.
        
        /*IF xmm600.homebr <> "M"   THEN NEXT.*/                        /*A63-00472*/
        IF xmm600.homebr <> "M" AND xmm600.homebr <> "ML" THEN NEXT.    /*A63-00472*/
        IF nv_lacno = "" THEN nv_lacno = xmm600.acno.
        ELSE nv_lacno =  nv_lacno + "," + xmm600.acno.
    END.
    IF  nv_lacno <> "" THEN DO:
        loop_for1:
        FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE (uwm100.trndat   >= nv_trndatfr  AND
                                                        uwm100.trndat   <= nv_trndatto) AND
                                                        LOOKUP(uwm100.acno1,nv_lacno) <> 0  AND
                                                       (uwm100.poltyp   >= nv_poltypfr  AND
                                                        uwm100.poltyp   <= nv_poltypto) AND
                                                       (uwm100.branch   >= nv_branchfr  AND
                                                        uwm100.branch   <= nv_branchto) NO-LOCK BY uwm100.policy BY uwm100.trndat:
            IF      (ra_release = 1 ) AND (uwm100.releas    = NO)   THEN NEXT.      
            ELSE IF (ra_release = 2 ) AND (uwm100.releas    = YES ) THEN NEXT.  
    
           /* IF uwm100.endcnt > 0  THEN NEXT.*/ /*A63-0222*/
            IF rs_type = 1 AND uwm100.endcnt > 0  THEN NEXT.  /*A63-0299*/
            IF rs_type = 2 AND uwm100.endcnt < 1  THEN NEXT.  /*A63-0299*/
           
            DISP " Process Data : " uwm100.trndat " " uwm100.policy
            WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 60 FRAME AAMain5 VIEW-AS DIALOG-BOX.
    
    
            IF ra_s = 2 THEN DO:
                FIND LAST wdetail WHERE wdetail.Policyno = TRIM(uwm100.policy) NO-LOCK NO-ERROR NO-WAIT .
                IF AVAIL wdetail THEN NEXT loop_for1.
            END.
            
          
            
            FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy   AND
                                                        uwm301.rencnt = uwm100.rencnt   AND
                                                        uwm301.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
            IF AVAIL uwm301 THEN DO:
                  
                
                 IF ra_s = 2 THEN DO: 
                     RUN proc_create33.
                 END.
                 ELSE RUN proc_create32.
                 
            END.
     
            
        END.  /*uwm100*/
    END.

END.
ELSE DO:
    loop_for2:
    FOR EACH sicuw.uwm100 USE-INDEX uwm10008 WHERE (uwm100.trndat   >= nv_trndatfr  AND
                                                    uwm100.trndat   <= nv_trndatto) AND
                                                    uwm100.acno1     = nv_acno      AND
                                                    uwm100.agent     = nv_agent     AND
                                                   (uwm100.poltyp   >= nv_poltypfr  AND
                                                    uwm100.poltyp   <= nv_poltypto) AND
                                                   (uwm100.branch   >= nv_branchfr  AND
                                                    uwm100.branch   <= nv_branchto) NO-LOCK BY uwm100.policy BY uwm100.trndat :
    
        IF (ra_release = 1 ) AND (uwm100.releas    = NO) THEN NEXT.       
        ELSE IF (ra_release = 2 ) AND (uwm100.releas    = YES ) THEN NEXT.
        
         IF nv_type = 1 AND uwm100.endcnt > 0  THEN NEXT.  /*A63-0299*/
         IF nv_type = 2 AND uwm100.endcnt < 1  THEN NEXT.  /*A63-0299*/
           
            DISP " Process Data : " uwm100.trndat " " uwm100.policy
                WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 60 FRAME AAMain6 VIEW-AS DIALOG-BOX.
         
         IF ra_s = 2 THEN DO:
             FIND LAST wdetail WHERE wdetail.Policyno = TRIM(uwm100.policy) NO-LOCK NO-ERROR NO-WAIT .
             IF AVAIL wdetail THEN NEXT loop_for2.
         END.
         FIND LAST sicuw.uwm301 USE-INDEX uwm30101 WHERE uwm301.policy = uwm100.policy   AND
                                                     uwm301.rencnt = uwm100.rencnt   AND
                                                     uwm301.endcnt = uwm100.endcnt   NO-LOCK NO-ERROR.
         IF AVAIL uwm301 THEN DO:
             IF ra_s = 2 THEN DO:
                  RUN proc_create33.
             END.
             ELSE RUN proc_create32.
         END.
      
    END.
END.
IF ra_s = 2 THEN DO:
   RUN proc_export4.
END.
ELSE RUN proc_export3.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_endors C-Win 
PROCEDURE proc_endors :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: add by A63-0299      
------------------------------------------------------------------------------*/
def var nv_NetPremium    as deci.
def var nv_VATPremium    as deci.
def var nv_StampPremium  as deci.
def var nv_GrossPremium  as deci.
def var nv_WHTPremium    as deci.
def var nv_PremiumAmount as deci.

DO:
    ASSIGN wdetail.NetPremium     = 0
           wdetail.VATPremium     = 0
           wdetail.StampPremium   = 0
           wdetail.GrossPremium   = 0
           wdetail.WHTPremium     = 0
           wdetail.PremiumAmount  = 0
           wdetail.SystemCode     = IF sicuw.uwm100.rencnt > 0 THEN "OBT" ELSE "CBS-HP"
           wdetail.PaymentMode    = "F" 
           wdetail.PaymentPeriod  = "Y" 
           wdetail.yr             = STRING(sicuw.uwm100.rencnt + 1)   
           wdetail.reasoncode     = IF sicuw.uwm100.polsta = "CA" THEN "01" ELSE "16"  . 

    nv_txt5 = "" .
    ASSIGN
        nv_txt5 = ""
        nv_f5   = ""
        nv_fptr = 0
        nv_bptr = 0
        nv_fptr = sicuw.uwm100.fptr05
        nv_bptr = sicuw.uwm100.bptr05.
    IF nv_fptr <> 0 Or nv_fptr <> ? THEN DO:  
        DO WHILE nv_fptr  <>  0 :
            
            FIND sicuw.uwd104  WHERE RECID(uwd104) = nv_fptr NO-LOCK NO-ERROR.
            IF AVAIL uwd104 THEN DO:
                nv_f5 = trim(SUBSTRING(uwd104.ltext,1,LENGTH(uwd104.ltext))).
                nv_fptr  =  uwd104.fptr.
                IF nv_f5 = ? THEN nv_f5 = "" .
            END.
            ELSE DO: 
                nv_fptr  = 0.
            END. 
            nv_txt5 = nv_txt5 + nv_f5.
            IF nv_fptr = 0 THEN LEAVE.
        END.
    END.
    ASSIGN wdetail.remark = nv_txt5 .
    RELEASE uwd104.
   
   FOR EACH  sicsyac.acm001 USE-INDEX acm00108 WHERE 
              acm001.policy  = uwm100.policy   AND
              acm001.rencnt  = uwm100.rencnt   AND 
              (acm001.trnty1 = "M"             OR
              acm001.trnty1  = "R")            NO-LOCK . /* Add "R" By Tontawan S. A64-0104 01/03/2021 */
       IF acm001.bal = 0  THEN NEXT. 
       ASSIGN wdetail.NetPremium     = wdetail.NetPremium   +  acm001.prem  
              wdetail.VATPremium     = wdetail.VATPremium   +  acm001.tax   
              wdetail.StampPremium   = wdetail.StampPremium +  ACM001.stamp .
      /* ASSIGN nv_NetPremium     = nv_NetPremium   +  acm001.prem 
              nv_VATPremium     = nv_VATPremium   +  acm001.tax    
              nv_StampPremium   = nv_StampPremium +  ACM001.stamp .*/
   END.
    ASSIGN wdetail.GrossPremium  = (wdetail.NetPremium + wdetail.VATPremium + wdetail.StampPremium) 
           wdetail.WHTPremium    = 0
           wdetail.PremiumAmount = wdetail.GrossPremium .

  /* ASSIGN  nv_GrossPremium    =  (nv_NetPremium + nv_VATPremium + nv_StampPremium)       
           nv_WHTPremium      =  0                                                                      
           nv_PremiumAmount   =  nv_GrossPremium .                                             

   IF nv_grosspremium > 0 THEN DO: 
      ASSIGN wdetail.NetPremium    = nv_NetPremium  
             wdetail.VATPremium    = nv_VATPremium  
             wdetail.StampPremium  = nv_StampPremium
             wdetail.GrossPremium  = nv_GrossPremium 
             wdetail.WHTPremium    = nv_WHTPremium   
             wdetail.PremiumAmount = nv_PremiumAmount.
   END.*/

  

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_export1 C-Win 
PROCEDURE proc_export1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
  DISP " Export Data ... Please Wait !!!" 
  WITH COLOR BLACK/WHITE NO-LABEL TITLE "Please Wait...." WIDTH 50 FRAME BBMain VIEW-AS DIALOG-BOX.

  IF INDEX(nv_output,".csv") = 0 THEN nv_output = nv_output + ".xls".
  ELSE nv_output = REPLACE(nv_output,".csv",".XLS").
  /*RUN wgw\wgwkkfile.*/ 
  IF rs_type = 1 THEN RUN wgw\wgwkkfile. 
  ELSE DO: 
      RUN wgw\wgwkkend.
      RUN proc_resoncode.
  END.

END.
 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_export2 C-Win 
PROCEDURE proc_export2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_column AS INT INIT 0.
DEF VAR nv_count  AS INT INIT 0.
    

    nv_count = nv_count + 1.
    IF nv_count = 1 THEN DO:
        OUTPUT STREAM ns1 TO VALUE(nv_output) .
        PUT STREAM ns1 "ID;PND" SKIP.        
        nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"ReferenceNo          " ).   nv_column = nv_column + 1.  
        run pd_put(input nv_count,nv_column,"TransactionDateTime  " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"InsuredCardType      " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"InsuredCardNo        " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"KKInsApplicationNo   " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"InsuranceCompanyCode " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"PolicyNo             " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"ApproveDate          " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"EffectiveDate        " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"ExpireDate           " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"Packagecode          " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"SumInsure            " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"NetPremium           " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"GrossPremium         " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"Remark               " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"EMS                  " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"NotifiedNo           " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"ChassisNo            " ).   nv_column = nv_column + 1.    /*
        run pd_put(input nv_count,nv_column,"SumInsure(Pol)       " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"NetPremium(Pol)      " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"GrossPremium(Pol)    " ).   nv_column = nv_column + 1.  */
        OUTPUT STREAM ns1 CLOSE.
    END.
    
    OUTPUT STREAM ns1 TO VALUE(nv_output) APPEND . 
    FOR EACH wdetail NO-LOCK:
        ASSIGN
            nv_column  = 1
            nv_count   = nv_count + 1.
        run pd_put(input nv_count,nv_column,wdetail.ReferenceNo                        ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.TransactionDateTime                ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.InsuredCardType                    ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.InsuredCardNo                      ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.KKInsApplicationNo                 ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.InsuranceCompanyCode               ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.Policyno                           ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.ApproveDate                        ) no-error.   nv_column = nv_column + 1.                    
        run pd_put(input nv_count,nv_column,wdetail.EffectiveDate                      ) no-error.   nv_column = nv_column + 1.                    
        run pd_put(input nv_count,nv_column,wdetail.ExpireDate                         ) no-error.   nv_column = nv_column + 1.           
        run pd_put(input nv_count,nv_column,wdetail.Packagecode                        ) no-error.   nv_column = nv_column + 1.   
        run pd_put(input nv_count,nv_column,string(wdetail.SumInsure    ,">>>>>>>>>>>>>>9.99-") ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,string(wdetail.NetPremium   ,">>>>>>>>>>>>>>9.99-") ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,string(wdetail.PremiumAmount,">>>>>>>>>>>>>>9.99-") ) no-error.   nv_column = nv_column + 1.
                                                                                                     
                                                                                                     
                                                                                                     
                                                                                                     /*         
        run pd_put(input nv_count,nv_column,string(wdetail.CommFix,">>>,>>>,>>9.99-")  ) no-error.   nv_column = nv_column + 1.            
        run pd_put(input nv_count,nv_column,string(wdetail.CommNet,">>>,>>>,>>9.99-")  ) no-error.   nv_column = nv_column + 1.      
        run pd_put(input nv_count,nv_column,string(wdetail.CommAmt,">>>,>>>,>>9.99-")  ) no-error.   nv_column = nv_column + 1. */  
        IF wdetail.reasoncode = "" THEN run pd_put(input nv_count,nv_column,"อยู่ระหว่างการจัดส่ง"                                        ) no-error.
        ELSE run pd_put(input nv_count,nv_column," "                                        ) no-error.   
        nv_column = nv_column + 1.         
        run pd_put(input nv_count,nv_column,wdetail.reasoncode                         ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.NotifiedNO                         ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.ChassisNo                          ) no-error.   nv_column = nv_column + 1.   /*
        run pd_put(input nv_count,nv_column,wdetail.SumInsure                          ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.NetPremium                         ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.PremiumAmount                      ) no-error.   nv_column = nv_column + 1. */


    END.
    PUT STREAM ns1 "E" SKIP.
    OUTPUT STREAM ns1 CLOSE.                                                                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_export3 C-Win 
PROCEDURE proc_export3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_column AS INT INIT 0.
DEF VAR nv_count  AS INT INIT 0.
    

    nv_count = nv_count + 1.
    IF nv_count = 1 THEN DO:
        OUTPUT STREAM ns1 TO VALUE(nv_output) .
        PUT STREAM ns1 "ID;PND" SKIP.        
        nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"KK_APP_NO     " ).   nv_column = nv_column + 1.  
        run pd_put(input nv_count,nv_column,"QUOTATION_NO  " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"RIDER_NO      " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"INSURER_CODE  " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"YEAR          " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"INSTALLMENT_NO" ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"RECEIVE_AMT   " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"PAYMENT_DATE  " ).   nv_column = nv_column + 1.
        OUTPUT STREAM ns1 CLOSE.
    END.
    
    OUTPUT STREAM ns1 TO VALUE(nv_output) APPEND . 
    FOR EACH wdetail NO-LOCK:
        ASSIGN
            nv_column  = 1
            nv_count   = nv_count + 1.
        run pd_put(input nv_count,nv_column,wdetail.KKInsApplicationNo                                   ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.InsuredCardType                                      ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.InsuredCardNo                                        ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.InsuranceCompanyCode                                 ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.EffectiveDate                                        ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,wdetail.yr                                                   ) no-error.   nv_column = nv_column + 1.     
        run pd_put(input nv_count,nv_column,string(wdetail.PremiumAmount,">>>>>>>>9.99-")              ) no-error.   nv_column = nv_column + 1.                    
        run pd_put(input nv_count,nv_column,wdetail.ApproveDate                                          ) no-error.   nv_column = nv_column + 1.              

    END.
    PUT STREAM ns1 "E" SKIP.
    OUTPUT STREAM ns1 CLOSE.                                                                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_export4 C-Win 
PROCEDURE proc_export4 PRIVATE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_column AS INT INIT 0.
DEF VAR nv_count  AS INT INIT 0.



    IF nv_count = 0 THEN DO:
        OUTPUT STREAM ns1 TO VALUE(nv_output) .
        PUT STREAM ns1 "ID;PND" SKIP. 
        nv_count   = nv_count + 1.
        nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"KK_APP_NO              " ).   nv_column = nv_column + 1.  
        run pd_put(input nv_count,nv_column,"RIDER_NO               " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"INSURER_CODE           " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"PRIORITY_NO            " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"INSURED_CARD_NO        " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"INSURED_TITLE_NAME     " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"INSURED_FIRST_NAME     " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"INSURED_LAST_NAME      " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"BENEFICIARY_TYPE       " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"BENEFICIARY_NAME       " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"POLICY_NO              " ).   nv_column = nv_column + 1. 
        run pd_put(input nv_count,nv_column,"POLICY_EFF_DATE        " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"POLICY_EXP_DATE        " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"YEAR                   " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"PAYMENT_PERIOD         " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"SUM_INSURE             " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"PREMIUM_NET            " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"PREMIUM_STAMP          " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"PREMIUM_VAT            " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"PREMIUM_GROSS          " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"PREMIUM_WHT            " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"PREMIUM_AMT            " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"FIRSTINST_PREMIUM_NET  " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"FIRSTINST_PREMIUM_STAMP" ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"FIRSTINST_PREMIUM_VAT  " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"FIRSTINST_PREMIUM_GROSS" ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"FIRSTINST_PREMIUM_WHT  " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"FIRSTINST_PREMIUM_AMT  " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"NEXTINST_PREMIUM_NET   " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"NEXTINST_PREMIUM_STAMP " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"NEXTINST_PREMIUM_VAT   " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"NEXTINST_PREMIUM_GROSS " ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,"NEXTINST_PREMIUM_WHT   " ).   nv_column = nv_column + 1. 
        run pd_put(input nv_count,nv_column,"NEXTINST_PREMIUM_AMT   " ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"REMARK                 " ).   nv_column = nv_column + 1.
                                                                                       




        OUTPUT STREAM ns1 CLOSE.
    END.
    
    OUTPUT STREAM ns1 TO VALUE(nv_output) APPEND . 
    FOR EACH wdetail NO-LOCK:
        ASSIGN
            nv_column  = 1
            nv_count   = nv_count + 1.
        run pd_put(input nv_count,nv_column,wdetail.KKInsApplicationNo                     ).   nv_column = nv_column + 1.  
        run pd_put(input nv_count,nv_column,wdetail.NotifiedNO                             ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.InsuranceCompanyCode                   ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,"1"                                            ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.InsuredCardNo                          ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.InsuredTitleName                       ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.InsuredFirstName                       ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.InsuredLastName                        ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.BeneficiaryType                        ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.BeneficiaryName                        ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.Policyno                               ).   nv_column = nv_column + 1.
        run pd_put(input nv_count,nv_column,wdetail.EffectiveDate                          ).   nv_column = nv_column + 1. 
        run pd_put(input nv_count,nv_column,wdetail.ExpireDate                             ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,wdetail.yr                                     ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,wdetail.PaymentPeriod                          ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,string(wdetail.SumInsure     ,">>>>>>>>>>>>>>9.99-")  ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,string(wdetail.NetPremium    ,">>>>>>>>>>>>>>9.99-")  ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,string(wdetail.StampPremium  ,">>>>>>>>>>>>>>9.99-")  ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,string(wdetail.VATPremium    ,">>>>>>>>>>>>>>9.99-")  ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,string(wdetail.GrossPremium  ,">>>>>>>>>>>>>>9.99-")  ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,string(wdetail.WHTPremium    ,">>>>>>>>>>>>>>9.99-")  ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column,string(wdetail.PremiumAmount ,">>>>>>>>>>>>>>9.99-")  ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1.                                
        run pd_put(input nv_count,nv_column," "                                            ).   nv_column = nv_column + 1. 
        run pd_put(input nv_count,nv_column,wdetail.remark                                 ).   nv_column = nv_column + 1.         
        
    END.
    PUT STREAM ns1 "E" SKIP.
    OUTPUT STREAM ns1 CLOSE.                                                                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_resoncode C-Win 
PROCEDURE proc_resoncode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF INDEX(nv_output,".XLS") = 0 THEN nv_output = nv_output + "_resoncod.txt".
ELSE nv_output = REPLACE(nv_output,".XLS","_resoncod.txt").
OUTPUT TO VALUE(nv_output) NO-ECHO APPEND.
  /***--- Control Record---***/
  PUT STREAM ns2  
    " 01 " "|" "ยกเลิกกรมธรรม์                           " skip 
    " 02 " "|" "คำนวนค่าบำเหน็จ และค่าบริการผิดพลาด      " skip 
    " 03 " "|" "ลูกค้าตรวจสุขภาพไม่ผ่าน                  " skip 
    " 04 " "|" "ลูกค้าไม่มีการชำระเงินงวดต่อตามที่กำหนด  " skip 
    " 05 " "|" "การกู้กรมธรรม์อัตโนมัติ                  " skip 
    " 06 " "|" "มูลค่าขยายเวลา                           " skip 
    " 07 " "|" "มูลค่าใช้เงินสำเร็จ                      " skip 
    " 08 " "|" "ลูกค้าขอยกเลิกการขอทำประกัน  ในขณะที่กรมธรรม์ยังอยู่ในช่วง Pending " SKIP
    " 09 " "|" "ปฎิเสธการขอรับประกัน                 " skip
    " 10 " "|" "ลูกค้าขอยกเลิกภายใน Free Look Period " skip
    " 11 " "|" "เวนคืนกรมธรรม์          " skip
    " 12 " "|" "เสียชีวิต               " skip
    " 13 " "|" "บันทึกข้อมูลผิด         " skip
    " 14 " "|" "เปลี่ยนตัวแทน           " skip
    " 15 " "|" "ต้องการเปลี่ยนแบบประกัน " skip
    " 16 " "|" "อื่นๆ                   " skip
    " 17 " "|" "ลูกค้าให้เอกสารหรือข้อมูลที่ทาง GT ร้องขอ ไม่ครบถ้วนหรือสมบูรณ์" SKIP 
    " 18 " "|" "ลูกค้าให้เอกสารหรือข้อมูลที่ทาง GT ร้องขอ ไม่ครบถ้วนหรือสมบูรณ์ และไม่มีการตอบสนองต่อการร้องขอของ บริษัทประกัน " SKIP
    " 19 " "|" "ทีมพิจารณารับประกัน ขอเลื่อนการจารณารับประกันเนื่องจากลูกค้าอาจมีโรคบางอย่างที่ไม่ร้ายแรง แต่ต้องรอดูก่อนว่าจะรับประกันหรือไม่" SKIP
    " 20 " "|" "Claw back of Migration Data" skip
    " 21 " "|" "รอยืนยันการชำระเงิน        " skip
    " 22 " "|" "รอการพิจารณารับประกัน      " skip
    " 23 " "|" "มีผลบังคับในการรับประกัน   " skip
    " 24 " "|" "เบี้ยไม่ตรงกับบริษัทประกัน " skip
    " 25 " "|" "ทุนประกันไม่ถูกต้อง        " skip
    " 26 " "|" "วันที่เริ่มต้น/สิ้นสุดความคุ้มครองไม่ถูกต้อง" SKIP 
    " 27 " "|" "ติดปัญหาอื่นๆ ระบุใน " SKIP.

  OUTPUT STREAM ns2 CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

/* ************************  Function Implementations ***************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _FUNCTION fn-month C-Win 
FUNCTION fn-month RETURNS CHARACTER
  (ip_month AS INTEGER) :
/*------------------------------------------------------------------------------
  Purpose:  
    Notes:  
------------------------------------------------------------------------------*/
DEF VAR n_month AS CHAR NO-UNDO INIT "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC".
    IF ip_month LT 1 OR ip_month GT 12 THEN
        RETURN "".

   RETURN ENTRY(ip_month,n_month).

/*RETURN "". */ /* Function return value. */
END FUNCTION.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

