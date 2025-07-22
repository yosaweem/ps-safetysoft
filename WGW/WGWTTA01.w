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
/*----------------------------------------------------------------------*/
  Modify By : Porntiwa P.  A53-0111 Edit Vol.1  Date : 04/10/2010
            : ปรับการดึงค่าข้อมูลที่ Parameter     
            : Duplicate Form WUWTAIMP.W ---> WGWTAIMP.W
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A54-0076   15/03/2011
           : ปรับการ Put File Excel เพื่อนำเข้า GW ให้ Put ออกทั้ง 70 + 72 
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A55-0235  20/08/2012
           : ปรับงาน new Thanachat เพิ่มคอลัมภ์ "ธนาครแถม"  
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A54-0112  26/11/2012
           : ขยายทะเบียนรถจาก 10 เป็น 11 หลัก                   
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A56-0250  14/10/2013
           : ปรับ Format การนำเข้าใหม่เนื่องจากมีการเพิ่มเติม IcNO.   
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A59-0070  04/04/2016
           : ปรับ Format การนำเข้า text file thanacaht         
-------------------------------------------------------------------------
 Modify By : Ranu I. A60-0545 date 21/12/2017   แก้ไข format นำเข้าไฟล์แจ้งงานป้ายแดง 
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
/*DEFINE     SHARED VAR s_progid  AS CHAR FORMAT "x(8)" NO-UNDO.*/
DEFINE WORKFILE wImport NO-UNDO
    FIELD Poltyp     AS CHAR FORMAT "X(3)"                INIT ""
    FIELD Policy     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD CedPol     AS CHAR FORMAT "X(20)"               INIT ""
    FIELD Renpol     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Compol     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Comdat     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD Expdat     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD Tiname     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD Insnam     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD name2      AS CHAR FORMAT "X(50)"               INIT ""
    FIELD dealer     AS CHAR FORMAT "x(70)"               INIT "" /*A60-0545*/
    FIELD name70     AS CHAR FORMAT "X(50)"               INIT ""
    FIELD name72     AS CHAR FORMAT "X(50)"               INIT ""
    FIELD iaddr1     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD iaddr2     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD iaddr3     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD iaddr4     AS CHAR FORMAT "X(20)"               INIT ""
    FIELD Prempa     AS CHAR FORMAT "X"                   INIT ""
    FIELD class      AS CHAR FORMAT "X(3)"                INIT ""
    FIELD Brand      AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Model      AS CHAR FORMAT "X(15)"               INIT ""
    FIELD CC         AS CHAR FORMAT "X(5)"                INIT ""
    FIELD Weight     AS CHAR FORMAT "X(5)"                INIT ""
    FIELD Seat       AS CHAR FORMAT "X(2)"                INIT ""
    FIELD Body       AS CHAR FORMAT "X(25)"               INIT "" 
    /*FIELD Vehreg     AS CHAR FORMAT "X(10)"               INIT ""*//*Comment A54-0112*/
    FIELD Vehreg     AS CHAR FORMAT "X(11)"               INIT "" /*A54-0112*/
    FIELD CarPro     AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Engno      AS CHAR FORMAT "X(20)"               INIT ""
    FIELD Chano      AS CHAR FORMAT "X(20)"               INIT ""
    FIELD yrmanu     AS CHAR FORMAT "X(2)"                INIT ""
    FIELD Vehuse     AS CHAR FORMAT "X"                   INIT ""
    FIELD garage     AS CHAR FORMAT "X(2)"                INIT ""
    FIELD stkno      AS CHAR FORMAT "X(15)"               INIT ""
    FIELD covcod     AS CHAR FORMAT "X"                   INIT ""
    FIELD si         AS CHAR FORMAT "X(15)"               INIT ""
    FIELD Prem_t     AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0 
    FIELD Prem_c     AS DECI FORMAT ">>>,>>9.99-"         INIT 0 
    FIELD Prem_r     AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0 
    FIELD Bennam     AS CHAR FORMAT "X(35)"               INIT ""
    FIELD drivnam    AS CHAR FORMAT "X"                   INIT ""
    FIELD drivnam1   AS CHAR FORMAT "X(35)"               INIT ""
    FIELD drivbir1   AS CHAR FORMAT "X(10)"               INIT ""
    FIELD drivic1    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/
    FIELD drivid1    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/
    FIELD drivage1   AS CHAR FORMAT "X(3)"                INIT ""
    FIELD drivnam2   AS CHAR FORMAT "X(35)"               INIT ""
    FIELD drivbir2   AS CHAR FORMAT "X(10)"               INIT ""
    FIELD drivic2    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/  
    FIELD drivid2    AS CHAR FORMAT "X(13)"               INIT "" /*A60-0545*/ 
    FIELD drivage2   AS CHAR FORMAT "X(3)"                INIT ""
    FIELD Redbook    AS CHAR FORMAT "X(10)"               INIT ""
    FIELD opnpol     AS CHAR FORMAT "X(20)"               INIT ""
    FIELD bandet     AS CHAR /*FORMAT "X(20)" */          INIT ""
    FIELD tltdat     AS CHAR FORMAT "X(10)"               INIT ""
    FIELD attrate    AS CHAR FORMAT "X(25)"               INIT ""
    FIELD branch     AS CHAR FORMAT "X(2)"                INIT ""
    FIELD fleet      AS CHAR FORMAT "x(10)"               INIT ""   /*fleet*/
    FIELD ncb        AS CHAR FORMAT "x(10)"               INIT "" 
    FIELD loadclm    AS CHAR FORMAT "x(10)"               INIT "" /*load claim*/
    FIELD deductda   AS CHAR FORMAT "x(10)"               INIT "" /*deduct da*/
    FIELD deductpd   AS CHAR FORMAT "x(10)"               INIT ""
    FIELD ICNO       AS CHAR FORMAT "X(13)"               INIT ""
    FIELD vatcode    AS CHAR FORMAT "X(10)"               INIT "" 
    FIELD text1      AS CHAR /*FORMAT "X(85)"*/           INIT ""
    FIELD text2      AS CHAR /*FORMAT "X(85)"*/           INIT ""
    FIELD text3      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD text4      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD text5      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD text6      AS CHAR FORMAT "X(85)"               INIT ""
    FIELD finit      AS CHAR FORMAT "X(10)"               INIT ""
    FIELD comment    AS CHAR
    FIELD pass       AS CHAR INIT "Y"
    FIELD Rebate     AS CHAR INIT ""   /*A55-0235*/
    FIELD name3      AS CHAR FORMAT "X(75)"                INIT "" .  /*A60-0545*/
    /*FIELD            AS CHAR FORMAT "X(5)"                INIT ""*/
    /*FIELD            AS CHAR FORMAT "X(5)"                INIT ""*/
    /*FIELD            AS CHAR FORMAT "X(30)"               INIT ""*/
    /*FIELD            AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0*/
    /*FIELD            AS CHAR FORMAT "X(5)"                INIT ""*/
    /*FIELD            AS CHAR FORMAT "X(17)"               INIT ""*/
    /*FIELD            AS CHAR FORMAT "9999"                INIT ""*/

DEFINE VAR Imidno      AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imtltdat    AS CHAR FORMAT "99/99/9999"          INIT "". 
DEFINE VAR Imcomcod    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imstkno     AS CHAR FORMAT "X(15)"               INIT "". 
DEFINE VAR Imstkno1    AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imyrcomp    AS CHAR FORMAT "9999"                INIT "". 
DEFINE VAR Impolcomp   AS CHAR FORMAT "X(15)"               INIT "".
DEFINE VAR Imcomnam    AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Imcedpol    AS CHAR FORMAT "X(17)"               INIT "". 
DEFINE VAR Imbandet    AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imbancode   AS CHAR FORMAT "X(2)"                INIT "". 
DEFINE VAR Imopnpol    AS CHAR FORMAT "X(16)"               INIT "". 
DEFINE VAR Imcodgrp    AS CHAR FORMAT "X(5)"                INIT "".
DEFINE VAR Imtiname    AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Iminsnam    AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imnfadd     AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Iminadd     AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imdeadd     AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imiadd1     AS CHAR FORMAT "X(100)"              INIT "". 
DEFINE VAR Imiadd2     AS CHAR FORMAT "X(100)"              INIT "". 
DEFINE VAR Imiadd3     AS CHAR FORMAT "X(100)"               INIT "". 
DEFINE VAR Imiadd4     AS CHAR FORMAT "X(100)"               INIT "".
DEFINE VAR Immadd1     AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Immadd2     AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Immadd3     AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imsi        AS CHAR FORMAT "x(25)"               INIT "". 
/*DEFINE VAR Imgrossi    AS INTE FORMAT ">>>,>>>,>>>,>>>,>>9" INIT 0 . */ /*A60-0545*/
/*DEFINE VAR Imprem      AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0 . */ /*A60-0545*/
/*DEFINE VAR Imnetprem   AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0 . */ /*A60-0545*/
/*DEFINE VAR Imcomp      AS DECI FORMAT ">>>,>>9.99-"         INIT 0 . */ /*A60-0545*/
/*DEFINE VAR Imnetcomp   AS DECI FORMAT ">>>,>>9.99-"         INIT 0 . */ /*A60-0545*/
/*DEFINE VAR Impremtot   AS DECI FORMAT ">>>,>>>,>>9.99-"     INIT 0 . */ /*A60-0545*/
DEFINE VAR Imgrossi    AS Char FORMAT ">>>,>>>,>>>,>>>,>>9" INIT "" .  /*A60-0545*/
DEFINE VAR Imprem      AS Char FORMAT ">>>,>>>,>>9.99-"     INIT "" .  /*A60-0545*/
DEFINE VAR Imnetprem   AS Char FORMAT ">>>,>>>,>>9.99-"     INIT "" .  /*A60-0545*/
DEFINE VAR Imcomp      AS Char FORMAT ">>>,>>9.99-"         INIT "" .  /*A60-0545*/
DEFINE VAR Imnetcomp   AS Char FORMAT ">>>,>>9.99-"         INIT "" .  /*A60-0545*/
DEFINE VAR Impremtot   AS Char FORMAT ">>>,>>>,>>9.99-"     INIT "" .  /*A60-0545*/
DEFINE VAR Immodel     AS CHAR FORMAT "X(50)"               INIT "". 
DEFINE VAR Imbrand     AS CHAR FORMAT "X(150)"              INIT "". 
DEFINE VAR Imyrmanu    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imcarcol    AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imvehreg    AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imcc        AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imengno     AS CHAR FORMAT "X(30)"               INIT "". 
DEFINE VAR Imchasno    AS CHAR FORMAT "X(30)"               INIT "". 
DEFINE VAR Imother1    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother2    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother3    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imandor1    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother4    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imandor2    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imandor3    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imother5    AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imattrate   AS CHAR FORMAT "X(45)"               INIT "".
/*DEFINE VAR Imcarpri    AS INTE FORMAT ">>>,>>>,>>>,>>>,>>9" INIT 0 . */ /*A60-0545*/
DEFINE VAR Imcarpri    AS CHAR FORMAT ">>>,>>>,>>>,>>>,>>9" INIT "" .  /*A60-0545*/
DEFINE VAR Imdealernam AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imsalenam   AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imcovcod    AS CHAR FORMAT "X"                   INIT "". 
DEFINE VAR Imvghgrp1   AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imvghgrp2   AS CHAR FORMAT "X(5)"                INIT "". 
DEFINE VAR Imdrivnam1  AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imdrivbir1  AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imidno1     AS CHAR FORMAT "X(13)"               INIT "". 
DEFINE VAR Imlicen1    AS CHAR FORMAT "X(15)"               INIT "". 
DEFINE VAR Imdrivnam2  AS CHAR FORMAT "X(60)"               INIT "". 
DEFINE VAR Imdrivbir2  AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imidno2     AS CHAR FORMAT "X(13)"               INIT "". 
DEFINE VAR Imlicen2    AS CHAR FORMAT "X(15)"               INIT "". 
DEFINE VAR Imcomdate   AS CHAR FORMAT "X(10)"               INIT "".
DEFINE VAR Imexpdate   AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Imvehuse1   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse2   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse3   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse4   AS CHAR                              INIT "". 
DEFINE VAR Imvehuse5   AS CHAR                              INIT "". 
DEFINE VAR Imothvehuse AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imcodecar   AS CHAR FORMAT "X(4)"                INIT "". 
DEFINE VAR Imdetrge1   AS CHAR                              INIT "". 
DEFINE VAR Imdetrge2   AS CHAR                              INIT "". 
DEFINE VAR Imbody1     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imbody2     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imbody3     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imbody4     AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR Imothbody   AS CHAR FORMAT "X(20)"               INIT "". 
DEFINE VAR Imgarage1   AS CHAR                              INIT "". 
DEFINE VAR Imgarage2   AS CHAR                              INIT "". 
DEFINE VAR Imcodereb   AS CHAR FORMAT "X(10)"               INIT "". 
DEFINE VAR Impolicy    AS CHAR FORMAT "X(16)"               INIT "".
DEFINE VAR Imbranch    AS CHAR FORMAT "X(2)"                INIT "".

DEFINE VAR Imtltno     AS CHAR FORMAT "X(17)" .
DEFINE VAR Imtltno1    AS CHAR FORMAT "X(17)" .
DEFINE VAR Imrenpol    AS CHAR FORMAT "X(20)".
DEFINE VAR Imcomdat1   AS CHAR FORMAT "X(10)".
DEFINE VAR Imexpdat1   AS CHAR FORMAT "X(10)".
DEFINE VAR Imvehreg1   AS CHAR FORMAT "X(30)". 
DEFINE VAR Imdetail    AS CHAR FORMAT "X(100)".
DEFINE VAR Imcomnam1   AS CHAR FORMAT "X(35)".
DEFINE VAR Imdeductda  AS CHAR FORMAT "X(30)".
DEFINE VAR Imncb       AS CHAR FORMAT "X(30)".
DEFINE VAR Imdeductpd  AS CHAR FORMAT "X(30)".
DEFINE VAR Imother     AS CHAR FORMAT "X(100)".
DEFINE VAR Imaddr      AS CHAR FORMAT "X(150)".
DEFINE VAR Imicno      AS CHAR FORMAT "X(15)".
DEFINE VAR Imiccomdat  AS CHAR FORMAT "X(10)".
DEFINE VAR Imicexpdat  AS CHAR FORMAT "X(10)".
DEFINE VAR Imtypaid    AS CHAR FORMAT "X(20)".
DEFINE VAR Imbennam    AS CHAR FORMAT "X(60)".
DEFINE VAR Imcomment1  AS CHAR FORMAT "X(10)".
DEFINE VAR Imcomment2  AS CHAR FORMAT "X(10)".
DEFINE VAR Imcomment   AS CHAR FORMAT "X(10)".
DEFINE VAR Imvatcode   AS CHAR FORMAT "X(10)".
DEFINE VAR Imseat      AS CHAR FORMAT "X(2)".
DEFINE VAR ImFinint    AS CHAR FORMAT "X(10)".   /*A56-0250*/
DEFINE VAR ImRemark1   AS CHAR FORMAT "X(100)".  /*A56-0250*/
DEFINE VAR ImRemark2   AS CHAR FORMAT "X(100)".  /*A56-0250*/
DEFINE VAR Imdoctyp    AS CHAR FORMAT "X(50)".   /*A59-0070*/
DEFINE VAR Imdocdetail AS CHAR FORMAT "X(50)".   /*A59-0070*/
DEFINE VAR Imbranins   AS CHAR.                  /*A59-0070*/
DEFINE VAR Imicno1     AS CHAR FORMAT "X(15)".   /*A59-0070*/
define var imnotino    as char format "x(20)".   /*A60-0545*/
define var imname2     as char format "x(70)".   /*A60-0545*/

DEFINE VAR nv_name2    AS CHAR FORMAT "X(50)"               INIT "".
DEFINE VAR nv_name70   AS CHAR FORMAT "X(50)"               INIT "".
DEFINE VAR nv_name72   AS CHAR FORMAT "X(50)"               INIT "".
DEFINE VAR nv_vehreg   AS CHAR FORMAT "X(35)"               INIT "". 
DEFINE VAR nv_vehreg1  AS CHAR FORMAT "X(15)"               INIT "".
DEFINE VAR nv_vehreg2  AS CHAR FORMAT "X(15)"               INIT "".
DEFINE VAR n_vehuse    AS CHAR FORMAT "X(2)"                INIT "".
DEFINE VAR n_body      AS CHAR FORMAT "X(5)"                INIT "".
DEFINE VAR nv_poltyp   AS CHAR FORMAT "X(3)"                INIT "".
DEFINE VAR nv_tinam    AS CHAR FORMAT "X(10)"               INIT "".
DEFINE VAR nv_policy   AS CHAR FORMAT "X(16)"               INIT "".
DEFINE VAR nv_carpro   AS CHAR FORMAT "X(35)"               INIT "".
DEFINE VAR nv_body     AS CHAR FORMAT "X(35)"               INIT "".
DEFINE VAR nv_oldpol   AS CHAR FORMAT "X(16)"               INIT "".
DEFINE VAR nv_drivnam  AS CHAR FORMAT "X(3)"                INIT "".
DEFINE VAR nv_ExpName  AS CHAR FORMAT "X(150)".
DEFINE VAR nv_Message  AS CHAR FORMAT "X(512)"              INIT "".
DEFINE VAR nv_cancel   AS CHAR FORMAT "X(2)"                INIT "N".
DEFINE VAR nv_pass     AS CHAR FORMAT "X(2)"                INIT "Y".
DEFINE VAR nv_tltdat   AS CHAR FORMAT "99/99/9999"          INIT "".
DEFINE VAR nv_len      AS INTE.
DEFINE VAR nv_cedpol   AS CHAR.
DEFINE VAR nv_prempa   AS CHAR.
DEFINE VAR nv_title1   AS CHAR.
DEFINE VAR nv_title2   AS CHAR.
DEFINE VAR nv_i        AS INTE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buexit 
     LABEL "EXIT" 
     SIZE 12.5 BY 1.43
     FONT 6.

DEFINE BUTTON buok 
     LABEL " OK" 
     SIZE 12.5 BY 1.43
     FONT 6.

DEFINE BUTTON butFile 
     LABEL " ..." 
     SIZE 3.5 BY 1.1.

DEFINE VARIABLE fiExpName AS CHARACTER FORMAT "X(150)":U 
     VIEW-AS FILL-IN 
     SIZE 50.83 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE fiImpName AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 47.33 BY 1
     BGCOLOR 15 FONT 2 NO-UNDO.

DEFINE VARIABLE ra_data AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2
     SIZE 34.5 BY 1
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73 BY 5.95
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-380
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 91 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-381
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.33 BY 2.29
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-382
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 15.33 BY 2.29
     BGCOLOR 4 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 92.67 BY 8.76.

DEFINE FRAME fr_main
     fiImpName AT ROW 4.05 COL 21.17 COLON-ALIGNED NO-LABEL
     ra_data AT ROW 5.48 COL 25.33 NO-LABEL
     fiExpName AT ROW 6.81 COL 21.17 COLON-ALIGNED NO-LABEL
     butFile AT ROW 4.05 COL 70.5
     buok AT ROW 4.29 COL 78
     buexit AT ROW 6.62 COL 78
     " Export File Name :" VIEW-AS TEXT
          SIZE 19.5 BY .62 AT ROW 7 COL 3.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Match Excel File For Thanachat" VIEW-AS TEXT
          SIZE 40.83 BY 1.19 AT ROW 1.48 COL 27
          BGCOLOR 1 FGCOLOR 7 FONT 23
     "(.CSV)" VIEW-AS TEXT
          SIZE 6 BY .62 AT ROW 7.76 COL 13.67
          BGCOLOR 3 FGCOLOR 15 FONT 6
     " Import File Name :" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 4.24 COL 3.17
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RECT-379 AT ROW 3.14 COL 2.17
     RECT-380 AT ROW 1.24 COL 1.67
     RECT-381 AT ROW 3.86 COL 76.5
     RECT-382 AT ROW 6.19 COL 76.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 92.33 BY 8.52.


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
         HEIGHT             = 8.62
         WIDTH              = 92.5
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
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
ASSIGN FRAME fr_main:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
/* SETTINGS FOR FRAME fr_main
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


&Scoped-define FRAME-NAME fr_main
&Scoped-define SELF-NAME buexit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buexit C-Win
ON CHOOSE OF buexit IN FRAME fr_main /* EXIT */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /*  OK */
DO:
    IF ra_data = 1 THEN DO: 
        RUN PdImpNew.
    END.
    ELSE DO: 
        RUN PdImpRenew.
    END.
  
    RUN PdCheckPol.
    RUN PdExport.
    RUN PDReports.

    FOR EACH wImport:
        DELETE wImport.
    END.

    MESSAGE "Output File Name : " fiExpName " complete"
    VIEW-AS ALERT-BOX.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME butFile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL butFile C-Win
ON CHOOSE OF butFile IN FRAME fr_main /*  ... */
DO:
   DEFINE VARIABLE no_add    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cvData    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE cvText    AS CHARACTER NO-UNDO.
   DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

   SYSTEM-DIALOG GET-FILE cvData
        TITLE     "Choose Data File to Import ..."
        FILTERS   "Text Files (*.*)" "*.*",
                  "Excel (*.csv)" "*.csv",
                  "Excel (*.slk)" "*.slk",
                  "Text Files (*.txt)" "*.txt"              
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         fiImpName = cvData. 
         /*fiExpName = "C:\Thanachat\".*//*Comment A53-0111*/
         /*-- Add Renew A53-0111 ---*/
         /*comment by ranu i. A60-0545 .....
         cvtext = TRIM(SUBSTRING(cvData,INDEX(cvdata,"\") + 1,LENGTH(cvdata))).
         fiExpName = SUBSTRING(cvData,1,INDEX(cvdata,"\")) +
                     SUBSTRING(cvtext,1,INDEX(cvtext,"\")).
         ..........end A60-0545..............*/
          /*A60-0545*/
         no_add = STRING(MONTH(TODAY),"99")    + 
                  STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
         fiexpname = SUBSTR(fiImpName,1,R-INDEX(fiImpName,".") - 1 ) + "_policy" + NO_add. 
         /* end : A60-0545*/
         /*-- End Add ---*/
         DISP fiImpName fiExpName WITH FRAME {&FRAME-NAME}.   
         APPLY "ENTRY" TO ra_data IN FRAME {&FRAME-NAME}.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiExpName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiExpName C-Win
ON LEAVE OF fiExpName IN FRAME fr_main
DO:
  fiExpName = INPUT fiExpName.
  nv_ExpName = CAPS(fiExpName + ".ERR").
  fiExpName = CAPS(fiExpName + ".csv").
  DISP fiExpName WITH FRAME fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiImpName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiImpName C-Win
ON LEAVE OF fiImpName IN FRAME fr_main
DO:
  fiImpName = CAPS(INPUT fiImpName).
  DISP fiImpName WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_data
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_data C-Win
ON VALUE-CHANGED OF ra_data IN FRAME fr_main
DO:
  ra_data = INPUT ra_data.
  
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

  /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "WGWTTA01".
  IF gv_prgid  = "WGWTTA01" THEN gv_prog  = "Match Excel File For Thanachat".
  ELSE gv_prog  = "Translation Excel File For Thanachat".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:HANDLE).
  SESSION:DATA-ENTRY-RETURN = YES.

  APPLY "ENTRY" TO fiImpname IN FRAME fr_main.
  ra_data = 1.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPdImpNew C-Win 
PROCEDURE BKPdImpNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fiImpName).
    REPEAT:
        IMPORT DELIMITER ","
            /*1*/   Imidno      
            /*2*/   Imtltdat    
            /*3*/   Imcomcod    
            /*4*/   Imstkno     
            /*5*/   Imstkno1    
            /*6*/   Imyrcomp    
            /*7*/   Impolcomp   
            /*8*/   Imcomnam    
            /*9*/   Imcedpol    
            /*10*/  Imbandet    
            /*11*/  Imbancode   
            /*12*/  Imopnpol    
            /*13*/  Imcodgrp    
            /*14*/  Imtiname    
            /*15*/  Iminsnam    
            /*16*/  ImICNo     /*A56-0250*/
            /*17*/  Imnfadd                              
            /*18*/  Iminadd                              
            /*19*/  Imdeadd                              
            /*20*/  Imiadd1                              
            /*21*/  Imiadd2                              
            /*22*/  Imiadd3                              
            /*23*/  Immadd1                              
            /*24*/  Immadd2                              
            /*25*/  Immadd3                              
            /*26*/  Imsi                                 
            /*27*/  Imgrossi                             
            /*28*/  Imprem                               
            /*29*/  Imnetprem                            
            /*30*/  Imcomp                               
            /*31*/  Imnetcomp                            
            /*32*/  Impremtot                            
            /*33*/  Imbrand                              
            /*34*/  Immodel                              
            /*35*/  Imyrmanu                             
            /*36*/  Imcarcol                             
            /*37*/  Imvehreg                             
            /*38*/  Imcc                                 
            /*39*/  Imengno                              
            /*40*/  Imchasno                             
            /*41*/  Imother1                             
            /*42*/  Imother2  /*(AO)*/                   
            /*43*/  Imother3                             
            /*44*/  Imandor1  /*(AQ)*/                   
            /*45*/  Imandor3  /*(AR)*/     /*A55-0235*/  
            /*46*/  Imother4                             
            /*47*/  Imandor2  /*(AT)*/                   
            /*48*/  Imother5                             
            /*49*/  Imattrate                            
            /*50*/  Imcarpri                             
            /*51*/  Imdealernam                          
            /*52*/  Imsalenam  /*ใส่รหัส Dealer Code */  
            /*53*/  Imcovcod                             
            /*54*/  Imvghgrp1                            
            /*55*/  Imvghgrp2                            
            /*56*/  Imdrivnam1                           
            /*57*/  Imdrivbir1                           
            /*58*/  Imidno1                              
            /*59*/  Imlicen1                             
            /*60*/  Imdrivnam2                           
            /*61*/  Imdrivbir2                           
            /*62*/  Imidno2                              
            /*63*/  Imlicen2                             
            /*64*/  Imcomdate                            
            /*65*/  Imexpdate                            
            /*66*/  Imvehuse1                            
            /*67*/  Imvehuse2                            
            /*68*/  Imvehuse3                            
            /*69*/  Imvehuse4                            
            /*70*/  Imvehuse5                            
            /*71*/  Imothvehuse                          
            /*72*/  Imcodecar                            
            /*73*/  Imdetrge1                            
            /*74*/  Imdetrge2                            
            /*75*/  Imbody1                              
            /*76*/  Imbody2                              
            /*77*/  Imbody3                              
            /*78*/  Imbody4                              
            /*79*/  Imothbody                            
            /*80*/  Imgarage1                            
            /*81*/  Imgarage2                            
            /*82*/  Imcodereb                            
            /*83*/  Imcomment                            
            /*84*/  Imseat                               
            /*85*/  ImVatCode     /*Vat Code*/     /*A56-0250*/   /*เดิมเป็น ImIcno ย้ายไปอยู่ช่อง 16*/                           
            /*86*/  ImFinint      /*Dealer Code*/  /*A56-0250*/ 
            /*87*/  ImRemark1     /*Remark 1*/     /*A56-0250*/ 
            /*88*/  ImRemark2.    /*Remark 2*/     /*A56-0250*/ 

        RUN PdChkData.
    END.
INPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BKPdImpRenew C-Win 
PROCEDURE BKPdImpRenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fiImpName).
    REPEAT:
        IMPORT DELIMITER ","
            Imtltno
            Imtltno1
            Imbancode
            Imcedpol
            Imrenpol
            Imcomnam
            Iminsnam
            Imbennam
            Imcomdate
            Imexpdate
            Imcomdat1
            Imexpdat1
            Imvehreg
            Imvehreg1
            Imsi
            Imnetprem
            Imnetcomp
            Impremtot
            Impolcomp
            Imstkno
            Imcodgrp
            Imdetail
            Imtltdat
            Imcomnam1
            Imopnpol
            Imbrand
            ImModel
            Imyrmanu
            Imcc
            Imengno
            Imchasno
            Imattrate
            Imcovcod
            Imbody1
            Imgarage1
            Imdrivnam1
            Imlicen1
            Imidno1
            Imdrivbir1
            Imdrivnam2
            Imlicen2
            Imidno2
            Imdrivbir2
            /*Imdeduct1
            Imdeduct2
            Imdeduct3*/
            Imdeductda 
            Imncb      
            Imdeductpd 
            Imother
            Imaddr
            Imicno
            Imiccomdat
            Imicexpdat
            Imtypaid.

        RUN PdChkRenew.
    END.
INPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK_PdChkData C-Win 
PROCEDURE BK_PdChkData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  /* comment by A60-0545 .....
    RUN PDChkBranch.
    /*--- cedpol ---*/
    IF Imcedpol <> " " THEN DO:
        /*--- Add A53-0111 Edit Vol.1 ---*/
        ASSIGN  
          nv_cedpol = " "
          nv_cedpol = Imcedpol.
        loop_chkcedpol:
        REPEAT:
            IF INDEX(nv_cedpol,"-") <> 0 THEN DO:
                nv_len    = LENGTH(nv_cedpol).
                nv_cedpol = TRIM(SUBSTRING(nv_cedpol,1,INDEX(nv_cedpol,"-") - 1)) +
                            TRIM(SUBSTRING(nv_cedpol,INDEX(nv_cedpol,"-") + 1, nv_len )) .
            END.
            ELSE LEAVE loop_chkcedpol.
        END.
        Imcedpol = nv_cedpol.
        /*--- End Add A53-0111 ---*/
    END.
    ELSE Imcedpol = Imcedpol.

    /*--- Policy Type ---*/
    /*IF Imstkno <> "" THEN nv_poltyp = "72". ELSE nv_poltyp = "70".*//*A53-0111*/
    /*nv_poltyp = "70".*//*Comment A54-0076*/
    /* Add A54-0076 Porn */
    IF deci(Imprem) = 0 AND deci(Imnetprem) = 0 THEN nv_poltyp = "72".
    ELSE nv_poltyp = "70".
    /* End Add A54-0076 */

    /*nv_policy = nv_poltyp + Imidno + "NB".*//*Comment A54-0076*/
    nv_policy = nv_poltyp + Imidno.

    /*---- vghgrp (drivnam) ---*/
    IF Imvghgrp2 = "TRUE" AND Imvghgrp1 = "FALSE" THEN nv_drivnam = "N" .
                                                  ELSE nv_drivnam = "Y" .

    /*----- Check และ/หรือ name2 ----*/
    nv_name2 = "".
    IF Imandor1 = "TRUE" AND Imandor2 = "TRUE" THEN DO:
        nv_name2 = "และ/หรือ" + " " + Imdealernam.
    END.
    /*--- Add A55-0235 ---*/
    ELSE DO:
        IF Imandor3 = "FALSE" THEN DO:
            nv_name2 = "และ/หรือ" + " " + "ธนาคาร ธนชาต จำกัด (มหาชน)".
        END.
    END.
    /*-- END ADD A55-0235 --*/
    /*ELSE nv_name2 = "".*//*Comment A55-0235*/

    nv_name70 = "".
    IF Imother2 = "TRUE"  AND Imandor1 = "FALSE" THEN nv_name70 = "ใบเสร็จออกในนามธนาคาร".   /*AO = "TRUE"    AQ = "FALSE"  TBlank/TGL แถม*/
    IF Imother2 = "FALSE" AND Imandor1 = "TRUE"  THEN nv_name70 = "ใบเสร็จออกในนามดีลเลอร์". /*AO = "FALSE"   AQ = "TRUE"  Delear แถม*/
    IF Imother2 = "FALSE" AND Imandor1 = "FALSE" THEN nv_name70 = "ใบเสร็จออกในนามลูกค้า".   /*AO = "FALSE"   AQ = "FALSE"*/ 

    nv_name72 = "".
    IF Imandor3 = "TRUE"  AND Imandor2 = "FALSE" THEN  nv_name72 = "ใบเสร็จออกในนามธนาคาร".   /*AR = "TRUE"    AT = "FALSE"  TBlank แถม พรบ.*/   
    IF Imandor3 = "FALSE" AND Imandor2 = "TRUE" THEN  nv_name72 = "ใบเสร็จออกในนามดีลเลอร์". /*AR = "FALSE"   AT = "TRUE"  พรบ. Dealer*/        
    IF Imandor3 = "FALSE" AND Imandor2 = "FALSE" THEN nv_name72 = "ใบเสร็จออกในนามลูกค้า".   /*AR = "FALSE"   AT = "FALSE"*/  

    /*----- Garage ดูจากช่องป้ายแดง ------*/
    /*-- Comment A53-0111 Renew --
    IF TRIM(Imgarage1) = "TRUE" AND 
       TRIM(Imgarage2) = "FALSE" 
       THEN Imgarage1 = "G". 
       ELSE Imgarage1 = " ".
       ---*/
    IF TRIM(Imdetrge1) = "TRUE" THEN Imgarage1 = "G". 
                                ELSE Imgarage1 = " ".

    /*----- vehuse ----*/
    IF TRIM(Imvehuse1) = "TRUE" THEN ASSIGN Imothvehuse = "1"
                                            n_vehuse = "10". ELSE
        IF TRIM(Imvehuse2) = "TRUE" THEN ASSIGN Imothvehuse = "2"
                                                n_vehuse = "20". ELSE
            IF TRIM(Imvehuse3) = "TRUE" THEN ASSIGN Imothvehuse = "3"
                                                    n_vehuse = "40". ELSE
                IF TRIM(Imvehuse4) = "TRUE" THEN ASSIGN Imothvehuse = "4"
                                                        n_vehuse = "30". ELSE
                    IF TRIM(Imvehuse5) = "TRUE" THEN ASSIGN Imothvehuse = "5"
                                                            n_vehuse = "10".

    /*---- Subclass ----*/
    /*-- Comment A53-0111 Renew --
    IF Imbody1 <> "TRUE" THEN DO:
        IF Imbody2 <> "TRUE" THEN DO:
            IF Imbody3 <> "TRUE" THEN DO:
                IF Imbody4 <> "TRUE" THEN DO:
                    n_body = "1".
                    /*MESSAGE "No body can't Generate" VIEW-AS ALERT-BOX.*/
                END.
                ELSE n_body = "4".
            END.
            ELSE n_body = "3".
        END.
        ELSE n_body = "2".
    END.
    ELSE n_body = "1".
    --- End Comment ---*/

    n_body = "1".
    IF TRIM(Imbody1) = "TRUE" THEN n_body = "1".
    IF TRIM(Imbody2) = "TRUE" THEN n_body = "3".
    IF TRIM(Imbody3) = "TRUE" THEN n_body = "2".
    IF TRIM(Imbody4) = "TRUE" THEN n_body = "1".

    /*IF TRIM(n_body) = "3" AND TRIM(n_vehuse) = "10" THEN n_body = "1". /*Add A53-0111 Edit Vol.1*/*/
   
    IF TRIM(Imbody2) = "TRUE" THEN Imcodecar = "320".
    ELSE Imcodecar = TRIM(n_body) + TRIM(n_vehuse). /*wdetail.subclass*/

    ASSIGN n_body = ""  n_vehuse = "".

    /*---- Address ----*/
    /*--- Add A55-0235 ---*/
    IF Imnfadd = "TRUE" THEN DO:
        FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
        IF AVAIL stat.Company THEN DO:
            ASSIGN Imiadd1  = stat.Company.Addr1
                   Imiadd2  = stat.Company.Addr2
                   Imiadd3  = stat.Company.Addr3
                   Imiadd4  = stat.Company.Addr4
                   Imbennam = stat.Company.NAME.
        END.
        ELSE DO:
            ASSIGN Imiadd1  = "900 อาคารต้นสน ทาวเวอร์"
                   Imiadd2  = "ถ.เพลินจิต แขวงลุมพินี"
                   Imiadd3  = "เขตปทุมวัน กรุงเทพฯ 10330"
                   Imbennam = "ธนาคาร ธนชาต จำกัด (มหาชน)".
        END.
    END.
    ELSE DO:
        IF Iminadd = "TRUE" THEN DO:
            IF Imiadd1 <> "" OR Imiadd2 <> "" THEN DO:
                ASSIGN Imiadd1 = Imiadd1
                       Imiadd2 = Imiadd2
                       Imiadd3 = "".
            END.
            ELSE DO:
                ASSIGN Imiadd1 = ""
                       Imiadd2 = ""
                       Imiadd3 = "".
            END.
        END.
    END.
    /*--- End Add A55-0235 ---*/
    /*--- Comment A55-0235 ---
    IF Iminadd = "TRUE" THEN DO:
        ASSIGN Imiadd1 = Imiadd1
               Imiadd2 = Imiadd2
               Imiadd3 = "".
    END.
    ELSE DO:
        FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
        IF AVAIL stat.Company THEN DO:
            ASSIGN Imiadd1  = stat.Company.Addr1
                   Imiadd2  = stat.Company.Addr2
                   Imiadd3  = stat.Company.Addr3
                   Imiadd4  = stat.Company.Addr4
                   Imbennam = stat.Company.NAME.
        END.
        ELSE DO:
            ASSIGN Imiadd1  = "900 อาคารต้นสน ทาวเวอร์"
                   Imiadd2  = "ถ.เพลินจิต แขวงลุมพินี"
                   Imiadd3  = "เขตปทุมวัน กรุงเทพฯ 10330"
                   Imbennam = "ธนาคาร ธนชาต จำกัด (มหาชน)".
        END.
        /*---
        ASSIGN Imiadd1 = "900 อาคารต้นสน ทาวเวอร์"
               Imiadd2 = "ถ.เพลินจิต แขวงลุมพินี"
               Imiadd3 = "เขตปทุมวัน กรุงเทพฯ 10330".
        ---*/       
    END.
    ----End Comment A55-0235 ----*/
    /*-- Add A53-0111 Edit Vol.1 ---*/
    IF Imiadd1 = "" AND Imiadd2 = "" AND Imiadd3 = "" THEN 
        ASSIGN Imiadd1  = "900 อาคารต้นสน ทาวเวอร์"
               Imiadd2  = "ถ.เพลินจิต แขวงลุมพินี"
               Imiadd3  = "เขตปทุมวัน กรุงเทพฯ 10330"
               Imbennam = "ธนาคาร ธนชาต จำกัด (มหาชน)".
    /*--- End Add A53-0111 ---*/

    /*--- Name ---*/
    nv_tinam = "".
    IF Iminsnam <> "" THEN RUN PdChkName.

    /*----- vehreg ----*/
    nv_carpro = "".
    IF Imdetrge1 <> "TRUE" THEN DO:
        nv_vehreg  = TRIM(Imvehreg).
        /*nv_vehreg1 = SUBSTRING(nv_vehreg,1,INDEX(nv_vehreg,"-") - 1).
        nv_vehreg  = TRIM(SUBSTRING(nv_vehreg,INDEX(nv_vehreg,"-") + 1,LENGTH(nv_vehreg))).
        nv_vehreg2 = SUBSTRING(nv_vehreg,1,INDEX(nv_vehreg," ") - 1).
        nv_vehreg  = TRIM(SUBSTRING(nv_vehreg,INDEX(nv_vehreg," ") + 1,LENGTH(nv_vehreg))).
        nv_carpro  = nv_vehreg.
        RUN PdChkProvi.*/ /*Comment A53-0111 Edit Vol. 1*/
        
        FOR EACH brstat.insure WHERE brstat.Insure.Compno = "999" NO-LOCK:
            IF INDEX(nv_vehreg,brstat.Insure.Fname) <> 0 THEN DO: 
                ASSIGN
                    nv_vehreg = brstat.insure.Lname
                    nv_carpro = brstat.insure.Fname. 
            END.
        END.
        nv_vehreg1 = SUBSTRING(Imvehreg,1,INDEX(Imvehreg,nv_carpro) - 1).
        IF INDEX(nv_vehreg1,"-") <> 0 THEN DO:
            nv_vehreg1 = SUBSTRING(nv_vehreg1,1,INDEX(nv_vehreg1,"-") - 1) + " "
                         + SUBSTRING(nv_vehreg1,INDEX(nv_vehreg1,"-") + 1,LENGTH(nv_vehreg1)).
        END.
        Imvehreg = nv_vehreg1 + nv_vehreg.
    END.
    ELSE ASSIGN 
            nv_vehreg = " "
            Imvehreg  = "/" + SUBSTRING(ImChasno,(LENGTH(ImChasno) - 9) + 1,LENGTH(ImChasno)). /*ป้ายแดง*/

    RUN PdChkDate.

    IF SUBSTRING(ImEngno,1,1) = "'" THEN ImEngno = SUBSTRING(ImEngno,2,LENGTH(ImEngno)).
                                    ELSE ImEngno = ImEngno.
    IF SUBSTRING(ImChasno,1,1) = "'" THEN ImChasno = SUBSTRING(ImChasno,2,LENGTH(ImChasno)).
                                     ELSE ImChasno = ImChasno.
    
    /*-- Comment A54-0076 Porn --
    FIND FIRST wImport WHERE wImport.Policy = nv_policy NO-ERROR NO-WAIT. 
    IF NOT AVAIL wImport THEN DO:
        CREATE wImport.
        ASSIGN               
            wImport.Poltyp    =  nv_poltyp    
            wImport.Policy    =  nv_policy 
            wImport.CedPol    =  Imcedpol  
            wImport.Renpol    =  ""  
            wImport.Compol    =  IF Imstkno <> "" THEN "Y" ELSE "N"  
            wImport.Comdat    =  Imcomdate  
            wImport.Expdat    =  ImExpdate  
            wImport.Tiname    =  nv_tinam  
            wImport.Insnam    =  ImInsnam  
            wImport.name2     =  nv_name2 
            wImport.iaddr1    =  Imiadd1  
            wImport.iaddr2    =  Imiadd2  
            wImport.iaddr3    =  Imiadd3   
            wImport.iaddr4    =  Imiadd4 
            wImport.Prempa    =  ""
            wImport.class     =  Imcodecar  
            wImport.Brand     =  ImBrand  
            wImport.Model     =  ImModel  
            wImport.CC        =  Imcc  
            wImport.Weight    =  ""  
            wImport.Seat      =  ""  
            wImport.Body      =  ""
            wImport.Vehreg    =  Imvehreg
            wImport.CarPro    =  nv_carpro
            wImport.Engno     =  ImEngno  
            wImport.Chano     =  ImChasno  
            wImport.yrmanu    =  Imyrmanu  
            wImport.Vehuse    =  Imothvehuse 
            wImport.garage    =  Imgarage1 
            wImport.stkno     =  Imstkno  
            wImport.covcod    =  Imcovcod  
            wImport.si        =  Imsi  
            wImport.Prem_t    =  ImPrem  /*ImNetPrem */ 
            wImport.Prem_c    =  Imcomp  /*ImNetComp*/  
            wImport.Prem_r    =  ImPremtot  
            wImport.Bennam    =  Imbennam  
            wImport.drivnam   =  nv_drivnam 
            wImport.drivnam1  =  Imdrivnam1 
            wImport.drivbir1  =  Imdrivbir1  
            wImport.drivage1  =  ""  
            wImport.drivnam2  =  Imdrivnam2  
            wImport.drivbir2  =  Imdrivbir2  
            wImport.drivage2  =  ""  
            wImport.Redbook   =  ""  
            wImport.opnpol    =  Imopnpol  
            wImport.bandet    =  Imbandet  
            wImport.tltdat    =  Imtltdat  
            wImport.attrate   =  Imattrate
            wImport.branch    =  Imbranch
            wImport.vatcode   =  Imcomment 
            wImport.Text1     =  Immadd1
            wImport.Text2     =  Immadd2
            wImport.finit     =  Imsalenam .

        /*--- Check Package ---*/
        IF wImport.Prempa = " " THEN DO:
             IF SUBSTRING(wImport.CedPol,6,1) = "U" THEN wImport.Prempa = "G".
             ELSE IF wImport.Brand = "TOYOTA" THEN wImport.Prempa = "X".
             ELSE IF wImport.Brand = "ISUZU" THEN wImport.Prempa = "V".
             ELSE wImport.Prempa = "Z".
        END.

        RUN PdChkRedBook.
        RUN PDChktext.
    END.
    --- End Add A54-0076 ---*/
    /*--- Add A54-0076 ---*/
    RUN PDCreateNew.
    IF nv_poltyp = "70" AND Imstkno <> "" THEN DO:
        nv_poltyp = "72".
        nv_policy = nv_poltyp + Imidno.
        RUN PdCreateNew.
    END.
    ELSE NEXT.
    /*--- End Add A54-0076 ---*/
    ... end A60-0545....*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY fiImpName ra_data fiExpName 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fiImpName ra_data fiExpName butFile buok buexit RECT-379 RECT-380 
         RECT-381 RECT-382 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDCheckPol C-Win 
PROCEDURE PDCheckPol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wImport.
    IF wImport.poltyp = "70" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
                  sicuw.uwm100.cedPol = wImport.cedpol AND
                  sicuw.uwm100.poltyp = "V" + wImport.poltyp  NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            ASSIGN
                wImport.policy = sicuw.uwm100.policy
                wImport.Compol = sicuw.uwm100.cr_2
                wImport.Renpol = sicuw.uwm100.cr_1. /*A60*0545*/
        END.
    END.
    ELSE IF wImport.poltyp = "72" THEN DO:
        FIND LAST sicuw.uwm100 USE-INDEX uwm10002 WHERE
                  sicuw.uwm100.cedpol = wImport.cedpol AND
                  sicuw.uwm100.poltyp = "V" + wImport.poltyp NO-LOCK NO-ERROR.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.cr_2 = "" THEN DO:
                ASSIGN
                    wImport.policy = sicuw.uwm100.cr_2
                    wImport.Compol = sicuw.uwm100.policy
                    wImport.Renpol = sicuw.uwm100.cr_1. /*A60-0545*/
            END.
            ELSE DO:
                ASSIGN
                    wImport.policy = ""
                    wImport.Compol = ""
                    wImport.poltyp = ""
                    wImport.Renpol = ""    /*A60-0545*/
                    wImport.name72 = wImport.name72.
            END.
        END.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkBranch C-Win 
PROCEDURE PDChkBranch :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_choice AS CHAR FORMAT "X(3)".
nv_Choice = "".
IF ra_data = 1 THEN DO:
    IF LENGTH(Imcedpol) = 17 THEN nv_choice = SUBSTRING(Imcedpol,16,2). /*TBSTYN10-04311-21*/
    ELSE IF LENGTH(Imcedpol) = 18 THEN nv_choice = SUBSTRING(Imcedpol,17,2) . /*TBSTYN10-004311-21*/ 
END.
ELSE DO:
    nv_choice = Imbancode.
END.
/*-- Comment A53-0111 Edit Vol.1 ---
IF nv_choice <> " " THEN DO:
    CASE nv_choice:    
        WHEN "21" THEN /* Yes */          
        DO: 
           Imbranch = "M".
        END.         
        WHEN "32" THEN
        DO:
            Imbranch = "2".
        END.
        WHEN "33" THEN
        DO:
            Imbranch = "H".
        END.
        WHEN "34" THEN
        DO:
            Imbranch = "S".
        END.
        WHEN "35" THEN
        DO:
            Imbranch = "3".
        END.
        WHEN "36" THEN
        DO:
            Imbranch = "6".
        END.
        WHEN "37" THEN
        DO:
            Imbranch = "5".
        END.
        WHEN "38" THEN
        DO:
            Imbranch = "8".
        END.
        WHEN "39" THEN
        DO:
            Imbranch = "7".
        END.
        WHEN "40" THEN
        DO:
            Imbranch = "4".
        END.
        WHEN "41" THEN
        DO:
            Imbranch = "J".
        END.
        WHEN "42" THEN
        DO:
            Imbranch = "1".
        END.
        WHEN "43" THEN
        DO:
            Imbranch = "34".
        END.
        WHEN "44" THEN
        DO:
            Imbranch = "N".
        END.
        WHEN "45" THEN
        DO:
            Imbranch = "U".
        END.
        WHEN "46" THEN
        DO:
            Imbranch = "K".
        END.
        WHEN "47" THEN
        DO:
            Imbranch = "P".
        END.
        OTHERWISE
            DO:
                Imbranch = "M".
            END.
    END CASE.
END.*/
/*---- Add A53-0111 Edit Vol.1 ---*/
FIND FIRST stat.Insure WHERE stat.Insure.Compno = "NB" AND
                             stat.Insure.Insno  = nv_choice NO-LOCK NO-ERROR.
IF AVAIL stat.Insure THEN DO:
    Imbranch = stat.Insure.Branch.
END.
ELSE Imbranch = "".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdChkData C-Win 
PROCEDURE PdChkData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
RUN PDChkBranch.
    /*--- cedpol ---*/
    IF Imcedpol <> " " THEN DO:
        /*--- Add A53-0111 Edit Vol.1 ---*/
        ASSIGN  
          nv_cedpol = " "
          nv_cedpol = Imcedpol.
        loop_chkcedpol:
        REPEAT:
            IF INDEX(nv_cedpol,"-") <> 0 THEN DO:
                nv_len    = LENGTH(nv_cedpol).
                nv_cedpol = TRIM(SUBSTRING(nv_cedpol,1,INDEX(nv_cedpol,"-") - 1)) +
                            TRIM(SUBSTRING(nv_cedpol,INDEX(nv_cedpol,"-") + 1, nv_len )) .
            END.
            ELSE LEAVE loop_chkcedpol.
        END.
        Imcedpol = nv_cedpol.
        /*--- End Add A53-0111 ---*/
    END.
    ELSE Imcedpol = Imcedpol.

    
    IF deci(Imprem) = 0 AND deci(Imnetprem) = 0 THEN nv_poltyp = "72".
    ELSE nv_poltyp = "70".
    nv_policy = nv_poltyp + Imidno.

    /*---- vghgrp (drivnam) ---*/
    IF trim(Imvghgrp1) = "ไม่ระบุ" THEN nv_drivnam = "N" .
    ELSE nv_drivnam = "Y" .
    /*--- Add A56-0250 ---*/
    IF nv_poltyp = "70" THEN DO:
        /** และ/หรือ Line 70 **/
        nv_name2 = "".
        nv_name70 = "" .
        IF      INDEX(Imother1,"Dealer") <> 0  THEN ASSIGN nv_name2  = "และ/หรือ" + " " + Imdealernam
                                                           nv_name70 = "ใบเสร็จออกในนามดีลเลอร์".
        ELSE IF INDEX(Imother1,"Tbank")  <> 0  THEN ASSIGN nv_name2  = "และ/หรือ" + " " + "ธนาคาร ธนชาต จำกัด (มหาชน)"
                                                           nv_name70 = "ใบเสร็จออกในนามธนาคาร". 
        ELSE IF INDEX(Imother1,"ไม่แถม") <> 0  THEN ASSIGN nv_name2  = " "
                                                           nv_name70 = "ใบเสร็จออกในนามลูกค้า".                                                 
        ELSE ASSIGN nv_name2 = ""   nv_name70 = "ใบเสร็จออกในนามลูกค้า".
    END.
    IF deci(Imcomp) <> 0 THEN DO:
        nv_name72 = "".
        IF      INDEX(Imother2,"Dealer")  <> 0  THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามดีลเลอร์".
        ELSE IF INDEX(Imother2,"Tbank")   <> 0  THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามธนาคาร". 
        ELSE IF INDEX(Imother2,"ไม่ซื้อ") <> 0  THEN ASSIGN nv_name72 =  "ใบเสร็จออกในนามลูกค้า". 
        ELSE ASSIGN nv_name72 = "ใบเสร็จออกในนามลูกค้า". 
    END.
    /*----- Garage ดูจากช่องป้ายแดง ------*/
    IF TRIM(Imdetrge1) = "ป้ายแดง" OR TRIM(Imdetrge1) = "New Car" THEN Imgarage1 = "G". 
    ELSE Imgarage1 = " ".

    /*----- vehuse ----*/
    IF      INDEX(Imvehuse1,"ส่วนบุคคล")       <> 0 THEN ASSIGN Imothvehuse = "1"  n_vehuse = "10". 
    ELSE IF INDEX(Imvehuse1,"เพื่อการพาณิชย์พิเศษ") <> 0 THEN ASSIGN Imothvehuse = "3"  n_vehuse = "40". 
    ELSE IF INDEX(Imvehuse1,"เพื่อการพาณิชย์") <> 0 THEN ASSIGN Imothvehuse = "2"  n_vehuse = "20". 
    ELSE IF INDEX(Imvehuse1,"รับจ้างสาธารณะ")  <> 0 THEN ASSIGN Imothvehuse = "4"  n_vehuse = "30". 
    ELSE IF INDEX(Imvehuse1,"อื่นๆ")           <> 0 THEN ASSIGN Imothvehuse = "5"  n_vehuse = "10".

    /*---- Subclass ----*/
    n_body = "1".
    IF INDEX(Imbody1,"เก๋ง")        <> 0  THEN n_body = "1".
    ELSE IF INDEX(Imbody1,"กระบะ")  <> 0  THEN n_body = "3".
    ELSE IF INDEX(Imbody1,"ตู้")    <> 0  THEN n_body = "2".
    ELSE IF INDEX(imbody1,"บรรทุก") <> 0  THEN n_body = "2".
    ELSE IF INDEX(Imbody1,"อื่นๆ")  <> 0  THEN n_body = "1".

    IF INDEX(Imbody1,"กระบะ") <> 0 THEN Imcodecar = "320".
    ELSE Imcodecar = TRIM(n_body) + TRIM(n_vehuse). /*wdetail.subclass*/

    ASSIGN n_body = ""  n_vehuse = "".

    /*---- Address ----*/
   IF trim(Imiadd1) = "" OR trim(Imiadd2) = "" THEN DO:
        FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
        IF AVAIL stat.Company THEN DO:
            ASSIGN Imiadd1  = stat.Company.Addr1
                   Imiadd2  = stat.Company.Addr2
                   Imiadd3  = stat.Company.Addr3
                   Imiadd4  = stat.Company.Addr4
                   Imbennam = stat.Company.NAME.
        END.
        ELSE DO:
            ASSIGN Imiadd1  = "444 อาคารเอ็มบีเคทาวเวอร์"
                   Imiadd2  = "ถนนพญาไท แขวงวังใหม่"
                   Imiadd3  = "เขตปทุมวัน  กรุงเทพฯ 10330"
                   Imbennam = "ธนาคาร ธนชาต จำกัด (มหาชน)".
        END.
    END.
    
    /*--- Name ---*/
    nv_tinam = "".
    IF Iminsnam <> "" THEN RUN PdChkName.

    /*----- vehreg ----*/
    nv_carpro = "".
    IF TRIM(Imdetrge1) <> "ป้ายแดง" OR TRIM(Imdetrge1) <> "New Car" THEN DO:
        nv_vehreg  = TRIM(Imvehreg).
        
        FOR EACH brstat.insure WHERE brstat.Insure.Compno = "999" NO-LOCK:
            IF INDEX(nv_vehreg,brstat.Insure.Fname) <> 0 THEN DO: 
                ASSIGN
                    nv_vehreg = brstat.insure.Lname
                    nv_carpro = brstat.insure.Fname. 
            END.
        END.
        nv_vehreg1 = SUBSTRING(Imvehreg,1,INDEX(Imvehreg,nv_carpro) - 1).
        IF INDEX(nv_vehreg1,"-") <> 0 THEN DO:
            nv_vehreg1 = SUBSTRING(nv_vehreg1,1,INDEX(nv_vehreg1,"-") - 1) + " "
                         + SUBSTRING(nv_vehreg1,INDEX(nv_vehreg1,"-") + 1,LENGTH(nv_vehreg1)).
        END.
        Imvehreg = nv_vehreg1 + nv_vehreg.
    END.
    ELSE ASSIGN nv_vehreg = " "
                Imvehreg  = IF length(imchasno) > 9 THEN "/" + trim(SUBSTRING(ImChasno,(LENGTH(ImChasno) - 9) + 1,LENGTH(ImChasno))) 
                            ELSE "/" + TRIM(ImChasno).  /*ป้ายแดง*/

    RUN PdChkDate.

    IF INDEX(ImEngno,"'")  <> 0  THEN ImEngno  = trim(REPLACE(ImEngno,"'","")).
    IF INDEX(ImChasno,"'") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"'","")).
    IF INDEX(ImChasno,"-") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"-","")).
    
    /*-- Check ICNO --*/
   IF INDEX(imICNo,"'") <> 0 THEN ImICNo = TRIM(REPLACE(ImICNo,"'","")).
   
    RUN PDCreateNew.

    IF  nv_poltyp = "70" AND Imstkno <> "" THEN DO:
        nv_poltyp = "72".
        nv_policy = nv_poltyp + Imidno.

        /*--- Add A56-0250 ---*/
        /** และ/หรือ Line 72 **/
        nv_name2 = "".
        nv_name2 = "".
        IF      INDEX(Imother2,"Dealer")  <> 0  THEN nv_name2 = "และ/หรือ" + " " + Imdealernam.
        ELSE IF INDEX(Imother2,"Tbank")   <> 0  THEN nv_name2 = "และ/หรือ" + " " + "ธนาคาร ธนชาต จำกัด (มหาชน)".
        ELSE IF INDEX(Imother2,"ไม่ซื้อ") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".

        /** Vat Code Line 72 **/
      /*  nv_vatcode = "".
        IF (Imandor3 = "FALSE" OR Imandor3 = "0") AND (Imandor2 = "FALSE" OR Imandor2 = "0")  THEN nv_vatcode = "".
        ELSE nv_vatcode = ImVatCode.*/
     
        RUN PdCreateNew.
    END.
    ELSE NEXT.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdChkDate C-Win 
PROCEDURE PdChkDate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_year AS INTE.
DEFINE VAR nv_day AS INTE.
DEFINE VAR nv_month AS INTE.

/*--- Comdate ---*/
nv_year   = (YEAR(DATE(Imcomdate)) - 543).
nv_day    = DAY(DATE(Imcomdate)).
nv_month  = MONTH(DATE(Imcomdate)).
Imcomdate = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*--- Expdate ---*/
nv_year   = (YEAR(DATE(Imexpdate)) - 543).
nv_day    = DAY(DATE(Imexpdate)).
nv_month  = MONTH(DATE(Imexpdate)).
Imexpdate = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*---- Add A54-0076 พรบ.---*/
/*--- Comdate1 ---*/
nv_year   = (YEAR(DATE(Imcomdat1)) - 543).
nv_day    = DAY(DATE(Imcomdat1)).
nv_month  = MONTH(DATE(Imcomdat1)).
Imcomdat1 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*--- Expdate1 ---*/
nv_year   = (YEAR(DATE(Imexpdat1)) - 543).
nv_day    = DAY(DATE(Imexpdat1)).
nv_month  = MONTH(DATE(Imexpdat1)).
Imexpdat1 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*--- End Add A54-0076 ----*/
/*--- A54-0112 ออกเป็น พ.ศ. ---*/
/*--- Driver Birth Date 1 ---*/
nv_year    = YEAR(DATE(Imdrivbir1)).
nv_day     = DAY(DATE(Imdrivbir1)).
nv_month   = MONTH(DATE(Imdrivbir1)).
Imdrivbir1 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*--- Driver Birth Date 2 ---*/
nv_year    = YEAR(DATE(Imdrivbir2)).
nv_day     = DAY(DATE(Imdrivbir2)).
nv_month   = MONTH(DATE(Imdrivbir2)).
Imdrivbir2 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*--- End A54-0112 ออกเป็น พ.ศ. ---*/
/*--- วันที่รับแจ้ง ---*/
IF ra_data <> 2 THEN DO:
    nv_year  = (YEAR(DATE(Imtltdat)) - 543).
    nv_day   = DAY(DATE(Imtltdat)).
    nv_month = MONTH(DATE(Imtltdat)).
    Imtltdat = STRING(nv_day) + "/" + STRING(nv_month) + "/" + STRING(nv_year).
END.

IF Imcomdate  = ? THEN Imcomdate  = "".
IF Imexpdate  = ? THEN Imexpdate  = "".
IF Imdrivbir1 = ? THEN Imdrivbir1 = "".
IF Imdrivbir2 = ? THEN Imdrivbir2 = "".
IF Imtltdat   = ? THEN Imtltdat   = "".
IF Imcomdat1  = ? THEN Imcomdat1  = "".
IF Imexpdat1  = ? THEN Imexpdat1  = "".

           
           
           
           

/*------ Comment A53-0111 Edit Vol.1 05/10/2010 ----*/
/*--- 10 อักษร ----
IF LENGTH(Imcomdate) = 10 THEN DO:
    Imcomdate = SUBSTRING(Imcomdate,1,2) + "/" + SUBSTRING(Imcomdate,4,2) + "/" + SUBSTRING(Imcomdate,7,4).
    nv_year = INTE(SUBSTRING(Imcomdate,7,4)) - 543. 
    Imcomdate = SUBSTRING(Imcomdate,1,2) + "/" + SUBSTRING(Imcomdate,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imexpdate) = 10 THEN DO:
    Imexpdate = SUBSTRING(Imexpdate,1,2) + "/" + SUBSTRING(Imexpdate,4,2) + "/" + SUBSTRING(Imexpdate,7,4).
    nv_year = INTE(SUBSTRING(Imexpdate,7,4)) - 543. 
    Imexpdate = SUBSTRING(Imexpdate,1,2) + "/" + SUBSTRING(Imexpdate,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imdrivbir1) = 10 THEN DO:
    Imdrivbir1 = SUBSTRING(Imdrivbir1,1,2) + "/" + SUBSTRING(Imdrivbir1,4,2) + "/" + SUBSTRING(Imdrivbir1,7,4).
    nv_year = INTE(SUBSTRING(Imdrivbir1,7,4)) - 543. 
    Imdrivbir1 = SUBSTRING(Imdrivbir1,1,2) + "/" + SUBSTRING(Imdrivbir1,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imdrivbir2) = 10 THEN DO:
    Imdrivbir2 = SUBSTRING(Imdrivbir2,1,2) + "/" + SUBSTRING(Imdrivbir2,4,2) + "/" + SUBSTRING(Imdrivbir2,7,4).
    nv_year = INTE(SUBSTRING(Imdrivbir2,7,4)) - 543. 
    Imdrivbir2 = SUBSTRING(Imdrivbir2,1,2) + "/" + SUBSTRING(Imdrivbir2,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imtltdat) = 10 AND ra_data <> 2 THEN DO:
    Imtltdat = SUBSTRING(Imtltdat,1,2) + "/" + SUBSTRING(Imtltdat,4,2) + "/" + SUBSTRING(Imtltdat,7,4).
    nv_year = INTE(SUBSTRING(Imtltdat,7,4)) - 543. 
    Imtltdat = SUBSTRING(Imtltdat,1,2) + "/" + SUBSTRING(Imtltdat,4,2) + "/" + STRING(nv_year).
END.
/*----*/

/*--- 8 ตัวอักษร ---*/
IF LENGTH(Imcomdate) = 8 THEN DO:
    Imcomdate = SUBSTRING(Imcomdate,1,2) + "/" + SUBSTRING(Imcomdate,4,2) + "/" + "25" + SUBSTRING(Imcomdate,7,2).
    nv_year = INTE(SUBSTRING(Imcomdate,7,4)) - 543. 
    Imcomdate = SUBSTRING(Imcomdate,1,2) + "/" + SUBSTRING(Imcomdate,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imexpdate) = 8 THEN DO:
    Imexpdate = SUBSTRING(Imexpdate,1,2) + "/" + SUBSTRING(Imexpdate,4,2) + "/" + "25" + SUBSTRING(Imexpdate,7,2).
    nv_year = INTE(SUBSTRING(Imexpdate,7,4)) - 543. 
    Imexpdate = SUBSTRING(Imexpdate,1,2) + "/" + SUBSTRING(Imexpdate,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imdrivbir1) = 8 THEN DO:
    Imdrivbir1 = SUBSTRING(Imdrivbir1,1,2) + "/" + SUBSTRING(Imdrivbir1,4,2) + "/" + "25" + SUBSTRING(Imdrivbir1,7,2).
    nv_year = INTE(SUBSTRING(Imdrivbir1,7,4)) - 543. 
    Imdrivbir1 = SUBSTRING(Imdrivbir1,1,2) + "/" + SUBSTRING(Imdrivbir1,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imdrivbir2) = 8 THEN DO:
    Imdrivbir2 = SUBSTRING(Imdrivbir2,1,2) + "/" + SUBSTRING(Imdrivbir2,4,2) + "/" + "25" + SUBSTRING(Imdrivbir2,7,2).
    nv_year = INTE(SUBSTRING(Imdrivbir2,7,4)) - 543. 
    Imdrivbir2 = SUBSTRING(Imdrivbir2,1,2) + "/" + SUBSTRING(Imdrivbir2,4,2) + "/" + STRING(nv_year).
END.
IF LENGTH(Imtltdat) = 8 THEN DO:
    Imtltdat = SUBSTRING(Imtltdat,1,2) + "/" + SUBSTRING(Imtltdat,4,2) + "/" + "25" + SUBSTRING(Imtltdat,7,2).
    nv_year = INTE(SUBSTRING(Imtltdat,7,4)) - 543. 
    Imtltdat = SUBSTRING(Imtltdat,1,2) + "/" + SUBSTRING(Imtltdat,4,2) + "/" + STRING(nv_year).
END.
-- End Comment A53-0111 ----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdChkName C-Win 
PROCEDURE PdChkName :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*-----
/*--- Check Title Name ----*/
IF SUBSTRING(Iminsnam,1,6) = "นางสาว" THEN DO:
    nv_tinam = SUBSTRING(Iminsnam,1,6).
    Iminsnam = TRIM(SUBSTRING(Iminsnam,7,60)).
END.
ELSE IF SUBSTRING(Iminsnam,1,4) = "Miss" OR
       SUBSTRING(Iminsnam,1,4) = "น.ส." OR
       SUBSTRING(Iminsnam,1,4) = "บจก." OR
       SUBSTRING(Iminsnam,1,4) = "หจก." OR
       SUBSTRING(Iminsnam,1,4) = "Mrs." THEN DO:
        nv_tinam = SUBSTRING(Iminsnam,1,4).
        Iminsnam = TRIM(SUBSTRING(Iminsnam,5,60)).
    END. ELSE IF SUBSTRING(Iminsnam,1,3) = "นาง" OR
                 SUBSTRING(Iminsnam,1,3) = "นาย" OR
                 SUBSTRING(Iminsnam,1,3) = "คุณ" OR
                 SUBSTRING(Iminsnam,1,3) = "นส." OR
                 SUBSTRING(Iminsnam,1,3) = "บจก" OR
                 SUBSTRING(Iminsnam,1,3) = "หจก" OR
                 SUBSTRING(Iminsnam,1,3) = "Mr." OR
                 SUBSTRING(Iminsnam,1,3) = "Mrs" THEN DO:
                  nv_tinam = SUBSTRING(Iminsnam,1,3).
                  Iminsnam = TRIM(SUBSTRING(Iminsnam,4,60)).
              END. ELSE IF SUBSTRING(Iminsnam,1,2) = "Mr" THEN DO:
                       nv_tinam = SUBSTRING(Iminsnam,1,2).
                       Iminsnam = TRIM(SUBSTRING(Iminsnam,3,60)).
                   END.

/*--- Check Name ----*/
IF INDEX(ImInsnam,"(") <> 0  THEN DO:
    ImInsnam = SUBSTRING(ImInsnam,1,INDEX(ImInsnam,"(") - 1).
END.
-----*/
DEFINE VAR nv_insname AS CHAR FORMAT "X(40)" INIT "".
/*--- Check Name ----*/
IF INDEX(ImInsnam,"(") <> 0  THEN DO:
    nv_insname = TRIM(SUBSTRING(Iminsnam,INDEX(ImInsnam,"("),40)).
    ImInsnam = SUBSTRING(ImInsnam,1,INDEX(ImInsnam,"(") - 1).
END.

nv_Tinam = "".
nv_Title1 = Iminsnam.

FIND FIRST brstat.msgcode WHERE 
           brstat.msgcode.compno = "999" AND
           INDEX(nv_insname,brstat.msgcode.msgdesc) <> 0 NO-LOCK NO-ERROR.
IF AVAIL brstat.msgcode THEN DO:
    nv_insname = "".
END.

FIND FIRST brstat.msgcode WHERE
           brstat.msgcode.compno = "999" AND
           INDEX(iminsnam,msgcode.msgdesc) <> 0 NO-LOCK NO-ERROR.
IF AVAIL brstat.msgcode THEN DO:
    nv_tinam = msgcode.branch.
    iminsnam = TRIM(SUBSTRING(Iminsnam,LENGTH(MsgCode.MsgDesc) + 1,LENGTH(Iminsnam)) + " " + nv_insname).
END.

/*--- Comment A54-0076 ---
nv_Tinam = "".
nv_Title1 = Iminsnam.
FOR EACH brstat.msgcode WHERE brstat.msgcode.Compno = "999" NO-LOCK:
    IF INDEX(ImInsnam,msgcode.MsgDesc) <> 0 THEN DO:
         ASSIGN nv_tinam = msgcode.Branch
                Iminsnam = TRIM(SUBSTRING(Iminsnam,LENGTH(MsgCode.MsgDesc) + 1,LENGTH(Iminsnam))).
    END.
END.
--- End Comment A54-0076 ---*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkOldPol C-Win 
PROCEDURE PDChkOldPol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_len AS INTE.
ASSIGN  
  nv_oldpol = " "
  nv_oldpol = imrenpol.
loop_chko1:
REPEAT:
    IF INDEX(nv_oldpol,"-") <> 0 THEN DO:
        nv_len    = LENGTH(nv_oldpol).
        nv_oldpol = TRIM(SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"-") - 1)) +
                    TRIM(SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"-") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko1.
END.
loop_chko2:
REPEAT:
    IF INDEX(nv_oldpol,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_oldpol).
        nv_oldpol = TRIM(SUBSTRING(nv_oldpol,1,INDEX(nv_oldpol,"/") - 1)) +
                    TRIM(SUBSTRING(nv_oldpol,INDEX(nv_oldpol,"/") + 1, nv_len )) .
    END.
    ELSE LEAVE loop_chko2.
END.

IF LENGTH(nv_oldpol) <> 12 THEN nv_oldpol = "".
ELSE /*nv_oldpol = nv_oldpol.*/
    IF Imcomnam <> "ประกันคุ้มภัย" THEN nv_oldpol = "".
                                   ELSE nv_oldpol = nv_oldpol.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdChkProvi C-Win 
PROCEDURE PdChkProvi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---- Comment A53-0111 Edit Vol.1 13/10/2010 --
/*1*/   IF nv_vehreg = "กระบี่"          THEN nv_vehreg = "กบ".
/*2*/   IF nv_vehreg = "กรุงเทพมหานคร" OR INDEX(nv_vehreg,"กรุงเทพ") <> 0 THEN nv_vehreg = "กท".
/*3*/   IF nv_vehreg = "กาญจนบุรี"       THEN nv_vehreg = "กจ".
/*4*/   IF nv_vehreg = "กาฬสินธุ์"       THEN nv_vehreg = "กส".
/*5*/   IF nv_vehreg = "กำแพงเพชร"       THEN nv_vehreg = "กพ".
/*6*/   IF nv_vehreg = "ขอนแก่น"         THEN nv_vehreg = "ขก".
/*7*/   IF nv_vehreg = "จันทบุรี"        THEN nv_vehreg = "จท".
/*8*/   IF nv_vehreg = "ฉะเชิงเทรา"      THEN nv_vehreg = "ฉท".
/*9*/   IF nv_vehreg = "ชลบุรี"          THEN nv_vehreg = "ชบ".
/*10*/  IF nv_vehreg = "ชัยนาท"          THEN nv_vehreg = "ชน".
/*11*/  IF nv_vehreg = "ชัยภูมิ"         THEN nv_vehreg = "ชย".
/*12*/  IF nv_vehreg = "ชุมพร"           THEN nv_vehreg = "ชพ".
/*13*/  IF nv_vehreg = "เชียงราย"        THEN nv_vehreg = "ชร".
/*14*/  IF nv_vehreg = "เชียงใหม่"       THEN nv_vehreg = "ชม".
/*15*/  IF nv_vehreg = "ตรัง"            THEN nv_vehreg = "ตง".
/*16*/  IF nv_vehreg = "ตราด"            THEN nv_vehreg = "ตร".
/*17*/  IF nv_vehreg = "ตาก"             THEN nv_vehreg = "ตก".
/*18*/  IF nv_vehreg = "นครนายก"         THEN nv_vehreg = "นย".
/*19*/  IF nv_vehreg = "นครปฐม"          THEN nv_vehreg = "นฐ".
/*20*/  IF nv_vehreg = "นครพนม"          THEN nv_vehreg = "นพ".
/*21*/  IF nv_vehreg = "นครราชสีมา"      THEN nv_vehreg = "นม".
/*22*/  IF nv_vehreg = "นครศรีธรรมราช"   THEN nv_vehreg = "นศ".
/*23*/  IF nv_vehreg = "นครสวรรค์"       THEN nv_vehreg = "นว".
/*24*/  IF nv_vehreg = "นนทบุรี"         THEN nv_vehreg = "นบ".
/*25*/  IF nv_vehreg = "นราธวาส"         THEN nv_vehreg = "นธ".
/*26*/  IF nv_vehreg = "น่าน"            THEN nv_vehreg = "นน".
/*27*/  IF nv_vehreg = "บุรีรัมย์"       THEN nv_vehreg = "บร".
/*28*/  IF nv_vehreg = "ปทุมธานี"        THEN nv_vehreg = "ปท".
/*29*/  IF nv_vehreg = "ประจวบคีรีขันธ์" THEN nv_vehreg = "ปข".
/*30*/  IF nv_vehreg = "ปราจีนบุรี"      THEN nv_vehreg = "ปจ".
/*31*/  IF nv_vehreg = "ปัตตานี"         THEN nv_vehreg = "ปน".
/*32*/  IF nv_vehreg = "พระนครศรีอยุธยา" OR nv_vehreg = "อยุธยา" THEN nv_vehreg = "อย".
/*33*/  IF nv_vehreg = "พะเยา"           THEN nv_vehreg = "พย".
/*34*/  IF nv_vehreg = "พังงา"           THEN nv_vehreg = "พง".
/*35*/  IF nv_vehreg = "พัทลุง"          THEN nv_vehreg = "พท".
/*36*/  IF nv_vehreg = "พิจิตร"          THEN nv_vehreg = "พจ".
/*37*/  IF nv_vehreg = "พิษณุโลก"        THEN nv_vehreg = "พล".
/*38*/  IF nv_vehreg = "เพชรบุรี"        THEN nv_vehreg = "พบ".
/*39*/  IF nv_vehreg = "เพชรบูรณ์"       THEN nv_vehreg = "พช".
/*40*/  IF nv_vehreg = "แพร่"            THEN nv_vehreg = "พร".
/*41*/  IF nv_vehreg = "ภูเก็ต"          THEN nv_vehreg = "ภก".
/*42*/  IF nv_vehreg = "มหาสารคาม"       THEN nv_vehreg = "มค".
/*43*/  IF nv_vehreg = "มุกดาหาร"        THEN nv_vehreg = "มห".
/*44*/  IF nv_vehreg = "แม่ฮ่องสอน"      THEN nv_vehreg = "มส".
/*45*/  IF nv_vehreg = "ยะลา"            THEN nv_vehreg = "ยล".
/*46*/  IF nv_vehreg = "ร้อยเอ็ด"        THEN nv_vehreg = "รอ".
/*47*/  IF nv_vehreg = "ระนอง"           THEN nv_vehreg = "รน".
/*48*/  IF nv_vehreg = "ระยอง"           THEN nv_vehreg = "รย".
/*49*/  IF nv_vehreg = "ราชบุรี"         THEN nv_vehreg = "รบ".
/*50*/  IF nv_vehreg = "ลพบุรี"          THEN nv_vehreg = "ลบ".
/*51*/  IF nv_vehreg = "ลำปาง"           THEN nv_vehreg = "ลป".
/*52*/  IF nv_vehreg = "ลำพูน"           THEN nv_vehreg = "ลพ".
/*53*/  IF nv_vehreg = "เลย"             THEN nv_vehreg = "ลย".
/*54*/  IF nv_vehreg = "ศรีสะเกษ"        THEN nv_vehreg = "ศก".
/*55*/  IF nv_vehreg = "สกลนคร"          THEN nv_vehreg = "สน".
/*56*/  IF nv_vehreg = "สงขลา"           THEN nv_vehreg = "สข".
/*57*/  IF nv_vehreg = "สระแก้ว"         THEN nv_vehreg = "สก".
/*58*/  IF nv_vehreg = "สระบุรี"         THEN nv_vehreg = "สบ".
/*59*/  IF nv_vehreg = "สิงห์บุรี"       THEN nv_vehreg = "สห".
/*60*/  IF nv_vehreg = "สุโขทัย"         THEN nv_vehreg = "สท".
/*61*/  IF nv_vehreg = "สุพรรณบุรี"      THEN nv_vehreg = "สพ".
/*62*/  IF nv_vehreg = "สุราษฎร์ธานี" OR INDEX(nv_vehreg,"สุราษ") <> 0 THEN nv_vehreg = "สฎ".
/*63*/  IF nv_vehreg = "สุรินทร์"        THEN nv_vehreg = "สร".
/*64*/  IF nv_vehreg = "หนองคาย"         THEN nv_vehreg = "นค".
/*65*/  IF nv_vehreg = "หนองบัวลำพู"     THEN nv_vehreg = "นล".
/*66*/  IF nv_vehreg = "อ่างทอง"         THEN nv_vehreg = "อท".
/*67*/  IF nv_vehreg = "อำนาจเจริญ"      THEN nv_vehreg = "อจ".
/*68*/  IF nv_vehreg = "อุดรธานี"        THEN nv_vehreg = "อด".
/*69*/  IF nv_vehreg = "อุตรดิตถ์"       THEN nv_vehreg = "อต".
/*70*/  IF nv_vehreg = "อุทัยธานี"       THEN nv_vehreg = "อท".
/*71*/  IF nv_vehreg = "อุบลราชธานี"     THEN nv_vehreg = "อบ".
/*72*/  IF nv_vehreg = "ยโสธร"           THEN nv_vehreg = "ยส".
/*73*/  IF nv_vehreg = "สตูล"            THEN nv_vehreg = "สต".
/*74*/  IF nv_vehreg = "สมุทรปราการ"     THEN nv_vehreg = "สป".
/*75*/  IF nv_vehreg = "สมุทรสงคราม"     THEN nv_vehreg = "สส".
/*76*/  IF nv_vehreg = "สมุทรสาคร"       THEN nv_vehreg = "สค".
-- End Comment A53-0111 Edit Vol.1 ----*/
                         
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdChkRedBook C-Win 
PROCEDURE PdChkRedBook :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*---- Comment A53-0111 Edit Vol. 1 ----
FIND FIRST stat.maktab_fil /*USE-INDEX maktab04*/ WHERE
           stat.maktab_fil.makdes = wImport.brand           AND
           INDEX(stat.maktab_fil.moddes,Immodel) <> 0       AND
           stat.maktab_fil.makyea = INTEGER(wImport.yrmanu) AND
           (stat.maktab_fil.engine = INTEGER(wImport.cc)    OR 
           stat.maktab_fil.engine > INTEGER(wImport.cc))    AND
           stat.maktab_fil.sclass = wImport.class           AND
           (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(Imsi) AND
            stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(Imsi))
           NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL stat.maktab_fil THEN DO:
    ASSIGN
        wImport.Redbook = stat.maktab_fil.modcod
        wImport.Weight  = STRING(stat.maktab_fil.tons)
        wImport.Seat    = STRING(stat.maktab_fil.seats)
        wImport.Body    = stat.maktab_fil.body.
END.
ELSE DO:
    ASSIGN
        wImport.Redbook = ""
        wImport.Weight  = ""
        wImport.Seat    = "7"
        wImport.Body    = "".
END. 
--- End Comment Edit Vol.1 -----*/ 

FIND FIRST stat.makdes31 WHERE stat.makdes31.makdes = "X" AND
                               stat.makdes31.moddes = wImport.Prempa + wImport.class
NO-LOCK NO-ERROR.    
IF AVAIL stat.makdes31 THEN DO:
   FIND FIRST stat.maktab_fil /*USE-INDEX maktab04*/ WHERE
              stat.maktab_fil.makdes = wImport.brand           AND
              INDEX(stat.maktab_fil.moddes,Immodel) <> 0       AND
              stat.maktab_fil.makyea = INTEGER(wImport.yrmanu) AND
              (stat.maktab_fil.engine = INTEGER(wImport.cc)    OR 
              stat.maktab_fil.engine > INTEGER(wImport.cc))    AND
              stat.maktab_fil.sclass = wImport.class           AND
              (stat.maktab_fil.si - (stat.maktab_fil.si * makdes31.si_theft_p / 100) LE INTE(Imsi) AND
               stat.maktab_fil.si + (stat.maktab_fil.si * makdes31.Load_p / 100) GE INTE(Imsi))
              NO-LOCK NO-ERROR NO-WAIT.
   IF AVAIL stat.maktab_fil THEN DO:
       ASSIGN
           wImport.Redbook = stat.maktab_fil.modcod
           wImport.Weight  = STRING(stat.maktab_fil.tons)
           wImport.Seat    = STRING(stat.maktab_fil.seats)
           wImport.Body    = stat.maktab_fil.body.
   END.
   ELSE DO:
       ASSIGN
           wImport.Redbook = ""
           wImport.Weight  = ""
           wImport.Seat    = "7"
           wImport.Body    = "".
   END.  
END.
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdChkRenew C-Win 
PROCEDURE PdChkRenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--- หาเลขทะเบียนรถ ---*/
IF Imvehreg <> "" AND Imvehreg1 <> "" THEN DO:
    nv_vehreg = Imvehreg1.
    /*RUN PdChkprovi.*//*Comment A53-0111 Edit Vol.1*/
    FOR EACH brstat.insure WHERE brstat.Insure.Compno = "999" NO-LOCK:
        IF INDEX(nv_vehreg,brstat.Insure.Fname) <> 0 THEN DO: 
            ASSIGN
                nv_vehreg = brstat.insure.Lname
                nv_carpro = brstat.insure.Fname. 
        END.
    END.

    Imvehreg  = Imvehreg + " " + nv_vehreg.
END.
/*--- Check Name ---*/
IF Iminsnam <> " " THEN DO:
    RUN PDChkname.
END.
/*----- Garage ------*/
IF TRIM(Imgarage1) = "ซ่อมห้าง" THEN Imgarage1 = "G". 
                                ELSE Imgarage1 = " ".

/*--- Add A54-0076 ---*/
nv_poltyp = "".
/*IF Imsi = "0" AND Imnetprem = 0 THEN nv_poltyp = "72".*/ /*a60-0545*/
IF Imsi = "0" AND deci(Imnetprem) = 0 THEN nv_poltyp = "72". /*a60-0545*/
ELSE nv_poltyp = "70".
/*--- End Add A54-0076 ---*/
/*--- Policy ----*/
/*nv_policy = "70" + Imcedpol.*//*Comment A54-0076*/
nv_i = nv_i + 1.
nv_policy = nv_poltyp + STRING(nv_i) + Imcedpol. /*Add A54-0076*/

IF INDEX(ImRenpol,"-") <> 0 OR INDEX(ImRenPol,"/") <> 0  THEN RUN PDChkOldPol.
ELSE nv_oldpol = ImRenpol.
IF LENGTH(nv_oldpol) <> 12 THEN DO:
    nv_oldpol = "".
END.
ELSE nv_oldpol = nv_oldpol.

/*---- ระบุผุ้ขับขี่ ---*/
IF Imdrivnam1 = "" THEN DO:
    IF Imdrivnam2 = "" THEN Imvghgrp1 = "N".
                       ELSE Imvghgrp1 = "Y".
END.
ELSE Imvghgrp1 = "Y".
/*--- Address ----*/
IF Imbennam <> "" THEN DO:
    FIND FIRST stat.company WHERE stat.company.compno = Imbennam NO-LOCK NO-ERROR.
    IF AVAIL stat.company THEN DO:
        ASSIGN Imiadd1 = stat.Company.addr1
               Imiadd2 = stat.Company.addr2
               Imiadd3 = stat.Company.addr3
               Imiadd4 = stat.Company.addr4
               Imbennam = stat.Company.Name .
    END.
    ELSE DO:
        ASSIGN Imiadd1 = SUBSTRING(Imaddr,1,35)
               Imiadd2 = SUBSTRING(Imaddr,36,35)
               Imiadd3 = SUBSTRING(Imaddr,71,LENGTH(Imaddr)).
    END.
    /*---
    IF Imbennam = "NB" THEN
        ASSIGN Imiadd1 = "900 อาคารต้นสนทาวเวอร์"
               Imiadd2 = "ถ.เพลินจิต แขวงลุมพินี"
               Imiadd3 = "เขตปทุมวัน กรุงเทพ 10330"
               Imbennam = "ธนาคาร ธนชาต จำกัด (มหาชน)".
    ELSE IF Imbennam = "NF" THEN
        ASSIGN Imiadd1 = "ชั้น10-12,12เอ อาคารเอ็มบีเค ทาวเวอร์"
               Imiadd2 = "440 ถ.พญาไท แขวงวังใหม่"
               Imiadd3 = "เขตปทุมวัน กรุงเทพฯ 10330"
               Imbennam = "บริษัท ทุนธนชาต จำกัด (มหาชน)".
    ELSE IF Imbennam = "NGL" THEN 
        ASSIGN Imiadd1 = "444 อาคารเอ็มบีเค ทาวเวอร์ ชั้น 11"
               Imiadd2 = "ถ.พญาไท แขวงวังใหม่"
               Imiadd3 = "เขตปทุมวัน กรุงเทพฯ 10330"
               Imbennam = "บริษัท ธนชาตกรุ๊ป ลิสซิ่ง จำกัด".
    ELSE ASSIGN Imiadd1 = SUBSTRING(Imaddr,1,35)
                Imiadd2 = SUBSTRING(Imaddr,36,35)
                Imiadd3 = SUBSTRING(Imaddr,71,LENGTH(Imaddr)).
    ----*/            
END.
/*---- Class And Branch -----*/
Imbranch  = "".
IF nv_oldpol <> "" THEN DO:
    IF SUBSTRING(nv_oldpol,1,1) = "D" OR SUBSTRING(nv_oldpol,1,1) = "I" THEN Imbranch = SUBSTRING(nv_oldpol,2,1).
    ELSE IF SUBSTRING(nv_oldpol,1,2) >= "10" AND SUBSTRING(nv_oldpol,1,2) <= "99" THEN Imbranch = SUBSTRING(nv_oldpol,1,2).
END.
ELSE DO:
    IF Imcovcod = "3" THEN Imbranch = "M".
                      ELSE RUN PDChkBranch.
END.

ASSIGN
    Imcodecar   = "" 
    Imothvehuse = "" 
    nv_prempa   = "".

/*----- Add A54-0076 -----*/
IF nv_oldpol = "" THEN DO:
    IF Imdetail <> "" THEN DO:
        IF SUBSTR(TRIM(Imdetail),2,3) = "110" THEN 
            ASSIGN
                Imcodecar = SUBSTR(TRIM(Imdetail),2,3)
                Imothvehuse = "1"
                nv_prempa = SUBSTR(TRIM(Imdetail),1,1). ELSE
        IF SUBSTR(TRIM(Imdetail),2,3) = "120" THEN 
            ASSIGN
                Imcodecar = SUBSTR(TRIM(Imdetail),2,3)
                Imothvehuse = "1"
                nv_prempa = SUBSTR(TRIM(Imdetail),1,1). ELSE
        IF SUBSTR(TRIM(Imdetail),2,3) = "210" THEN 
            ASSIGN
                Imcodecar = SUBSTR(TRIM(Imdetail),2,3)
                Imothvehuse = "2"
                nv_prempa = SUBSTR(TRIM(Imdetail),1,1). ELSE
        IF SUBSTR(TRIM(Imdetail),2,3) = "220" THEN 
            ASSIGN
                Imcodecar = SUBSTR(TRIM(Imdetail),2,3)
                Imothvehuse = "2"
                nv_prempa = SUBSTR(TRIM(Imdetail),1,1). ELSE
        IF SUBSTR(TRIM(Imdetail),2,3) = "320" THEN 
            ASSIGN
                Imcodecar = SUBSTR(TRIM(Imdetail),2,3)
                Imothvehuse = "3"
                nv_prempa = SUBSTR(TRIM(Imdetail),1,1). 
    END.
 
    IF Imcodecar = "" AND nv_prempa = "" THEN DO:
        /*IF Imcovcod = "1" OR Imcovcod = "2" THEN DO: 
            MESSAGE Imcedpol Imcovcod Imbranch "1" VIEW-AS ALERT-BOX.
            RUN PDChkBranch.
        END.
        ELSE IF Imcovcod = "3" THEN DO: 
            MESSAGE Imcedpol Imcovcod Imbranch "2" VIEW-AS ALERT-BOX.
            Imbranch = "M".
        END.*/
        nv_body = TRIM(Imbody1).
        CASE nv_body:    
            WHEN "เก๋ง" THEN           
            DO: 
               Imcodecar = "110".
               Imothvehuse = "1".
            END.         
            WHEN "เก๋ง 2 ตอน" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "นั่งสองตอนท้ายบรรทุก" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "นั่งสองส่วนบุคคล" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "นั่งสองตอนแวน" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "นั่งสามตอน" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "บุคคล (รย 1)" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "กะบะบรรทุก" THEN
            DO:
                Imcodecar = "320".
                Imothvehuse = "3".
            END.
            WHEN "บรรทุกส่วนบุคคล (รย 3)" THEN
            DO:
                Imcodecar = "320".
                Imothvehuse = "3".
            END.
            WHEN "ตู้นั่ง 4 ตอน" THEN
            DO:
                Imcodecar = "210".
                Imothvehuse = "2".
            END.
            OTHERWISE
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
        END CASE.
    
        IF Imcodecar = "" THEN 
            ASSIGN
                Imcodecar = "110".
                Imothvehuse = "1".

        IF Imcovcod = "1" OR Imcovcod = "2" THEN nv_prempa = "G".
                                            ELSE 
                                                ASSIGN
                                                    nv_prempa = "R"
                                                    ImbenNam  = "". /*--- งานต่ออายุจากที่อื่นคุ้มครอง 3 ไม่มี BenName --*/
    END.
END.
/*---- End Add A54-0076 ----*/
/*---- Comment A54-0076 เนื่องจาก เป็นกรมธรรม์ต่ออายุเดิมจากคุ้มภัยให้ดึงจาก Expiry ---
/*-- Check Package --*/
IF nv_oldpol <> "" THEN DO:
    IF Imcovcod = "1" OR Imcovcod = "2" THEN nv_prempa = "G".
                                        ELSE nv_prempa = "R".
END.
ELSE ASSIGN
         Imcodecar   = "110"
         Imothvehuse = "1"
         nv_prempa   = "F".
--- End Comment A54-0076 ----*/

nv_tltdat = Imtltdat.
IF nv_oldpol = "" THEN DO:
    ASSIGN
        Imbandet  = ""
        Imbandet  = "บริษัทประกันภัยเดิม : " + Imcomnam + " " + "เลขที่ : " + Imrenpol. 
END.
ELSE Imbandet  = "".

/*--- Check Date ---*/
IF Imcomdate = "//" OR Imcomdate = " " THEN Imcomdate = Imcomdat1.
IF Imexpdate = "//" OR Imexpdate = " " THEN Imexpdate = Imexpdat1.
IF Imcomdat1 = "//" OR Imcomdat1 = " " THEN Imcomdat1 = Imcomdate. /*A54-0076*/
IF Imexpdat1 = "//" OR Imexpdat1 = " " THEN Imexpdat1 = Imexpdate. /*A54-0076*/

RUN PDChkDate.

/*--- Add A54-0076 ---*/
RUN PdCreateReNew.

IF nv_poltyp = "70"  AND Imstkno <> "" THEN DO:
    nv_poltyp = "72".
    nv_policy = nv_poltyp + STRING(nv_i) + Imcedpol.
 
    RUN PdCreateReNew.

END.
ELSE NEXT.


ASSIGN
   Imiadd1  = ""
   Imiadd2  = ""
   Imiadd3  = ""
   Imbennam = ""
   nv_tinam = "".
   
RUN pdChktext.   

/*--- End Add A54-0076 ---*/
/*--- Comment A54-0076 ---
FIND FIRST wImport WHERE wImport.policy = nv_policy NO-ERROR NO-WAIT.
IF NOT AVAIL wImport THEN DO:
    CREATE wImport.
    ASSIGN               
       wImport.Poltyp    =  IF Imstkno <> "" AND ImNetPrem = 0 THEN "72" ELSE "70"     
       wImport.Policy    =  nv_policy + "NB"
       wImport.CedPol    =  Imcedpol   
       wImport.Renpol    =  nv_oldpol  
       wImport.Compol    =  IF Imstkno <> "" THEN "Y" ELSE "N"   
       wImport.Comdat    =  Imcomdate   
       wImport.Expdat    =  Imexpdate  
       wImport.Tiname    =  nv_tinam   
       wImport.Insnam    =  ImInsnam  
       wImport.name2     =  "" 
       wImport.iaddr1    =  Imiadd1  
       wImport.iaddr2    =  Imiadd2  
       wImport.iaddr3    =  Imiadd3   
       wImport.iaddr4    =  Imiadd4
       wImport.Prempa    =  nv_prempa /*IF Imcovcod = "1" OR Imcovcod = "2" THEN "G" ELSE "R"*/
       wImport.class     =  Imcodecar  
       wImport.Brand     =  ImBrand  
       wImport.Model     =  ImModel  
       wImport.CC        =  Imcc   
       wImport.Weight    =  ""  
       wImport.Seat      =  ""  
       wImport.Body      =  ""
       wImport.Vehreg    =  Imvehreg
       wImport.CarPro    =  Imvehreg1
       wImport.Engno     =  ImEngno  
       wImport.Chano     =  ImChasno   
       wImport.yrmanu    =  Imyrmanu  
       wImport.Vehuse    =  Imothvehuse  
       wImport.garage    =  Imgarage1  
       wImport.stkno     =  Imstkno  
       wImport.covcod    =  Imcovcod   
       wImport.si        =  Imsi  
       wImport.Prem_t    =  ImNetPrem 
       wImport.Prem_c    =  ImNetComp   
       wImport.Prem_r    =  ImPremtot  
       wImport.Bennam    =  ImbenNam  
       wImport.drivnam   =  Imvghgrp1  
       wImport.drivnam1  =  Imdrivnam1  
       wImport.drivbir1  =  Imdrivbir1   
       wImport.drivage1  =  ""  
       wImport.drivnam2  =  Imdrivnam2   
       wImport.drivbir2  =  Imdrivbir2    
       wImport.drivage2  =  ""  
       wImport.Redbook   =  ""  
       wImport.opnpol    =  Imopnpol + " " + "(" + "R" + Imcodgrp + ")"  
       wImport.bandet    =  Imbandet  
       wImport.tltdat    =  nv_tltdat  
       wImport.attrate   =  Imattrate
       wImport.branch    =  Imbranch
       wImport.vatcode   =  Imcomment 
       wImport.ICNO      =  Imicno
       wImport.Text1     =  Imtltno
       wImport.Text2     =  Imdetail
       wImport.finit     =  "".

       RUN PDChkRedbook.

       ASSIGN
           Imiadd1  = ""
           Imiadd2  = ""
           Imiadd3  = ""
           Imbennam = ""
           nv_tinam = "".

       RUN pdChktext.
END.
ELSE NEXT.
--- End Comment A54-0076 ---*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdChkText C-Win 
PROCEDURE PdChkText :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*----- Comment A53-0111 Edit Vol.1 --*/
/*-- ชื่อผู้เอาประกัน --*/
IF wImport.Insnam /*Iminsnam*/ = "" THEN DO:
    ASSIGN wImport.comment = "| ชื่อผู้เอาประกันเป็นค่าว่าง " 
           wImport.pass    = "N".
END.
/*-- เลขที่รับแจ้ง --
IF Imtltno = "" THEN DO:
    ASSIGN wImport.comment =  "| เลขที่รับแจ้งเป็นค่าว่าง กรุณาตรวจสอบข้อมูล " 
           wImport.pass    =  "N".
END.
---*/
/*-- วันที่เริ่มคุ้มครอง/วันที่สิ้นสุดความคุ้มครอง --*/
IF wImport.Comdat /*Imcomdate*/ = "" OR wImport.Expdat /*Imexpdate*/ = "" THEN DO:
    ASSIGN wImport.comment = "| วันที่เริ่มคุ้มครอง/วันที่สิ้นสุดความคุ้มครองเป็นค่าว่าง " 
           wImport.pass    = "N".
END.
/*-- ทุนประกันภัย --
IF /*Imsi*/ wImport.si = "0" OR /*Imsi*/ wImport.si = "" THEN DO:
    ASSIGN wImport.comment = "| ทุนประกันภัยเป็นศูนย์ "
           wImport.pass    = "N".
END.*/
/*-- ยี่ห้อรถ --*/
IF /*Imbrand*/ wImport.Brand = "" THEN DO:
    ASSIGN wImport.comment = "| ยี่ห้อรถเป็นค่าว่าง "
           wImport.pass    = "N".
END.
/*-- รุ่นรถ ---*/
IF /*Immodel*/ wImport.Model = "" THEN DO:
    ASSIGN wImport.comment = "| รุ่นรถเป็นค่าว่าง "
           wImport.pass    = "N".
END.
/*-- ปีที่ผลิต --*/
IF /*Imyrmanu*/ wImport.yrmanu = "" THEN DO:
    ASSIGN wImport.comment = "| ปีที่ผลิตเป็นค่าว่าง "
           wImport.pass    = "N".
END.
/*-- CC --*/
IF /*Imcc*/ wImport.CC = "" THEN DO:
    ASSIGN wImport.comment = "| CC เป็นค่าว่าง " 
           wImport.pass    = "N".
END.
/*-- เลขเครื่อง --*/
IF /*Imengno*/ wImport.Engno = "" THEN DO:
    ASSIGN wImport.comment = "| เลขเครื่องยนต์เป็นค่าว่าง " 
           wImport.pass    = "N" .
END.
/*-- เลขตัวถัง --*/
IF /*ImChasno*/ wImport.Chano = "" THEN DO:
    ASSIGN wImport.comment = "| เลขตัวถังเป็นค่าว่าง " 
           wImport.pass    = "N".
END.
/*-- Driver Name ---*/
IF wImport.drivnam = "Y" THEN DO:
    IF (wImport.drivnam1 = "" AND wImport.drivbir1 = "") THEN
        ASSIGN wImport.comment = "| ชื่อผู้ขับขี่และวันเกิดเป็นค่าว่าง " 
               wImport.pass    = "N".
END.
/*-- คำนำหน้าชื่อ --*/
IF wImport.Tiname = "" THEN DO:
    ASSIGN wImport.comment = "| คำนำหน้าชื่อเป็นค่าว่าง กรุณาตรวจสอบและเพิ่มคำนำหน้าชื่อ"
           wImport.pass    = "N".
END.
/*-- Branch --*/
IF wImport.Branch = "" THEN DO:
    ASSIGN wImport.comment = "| Branch เป็นค่าว่าง กรุณาตรวจสอบ Branch"
           wImport.pass    = "N".
END.
/*--- End Comment A53-0111 Edit Vol. 1 -----*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCreateNew C-Win 
PROCEDURE PdCreateNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wImport WHERE wImport.Policy = nv_policy NO-ERROR NO-WAIT. 
    IF NOT AVAIL wImport THEN DO:
        CREATE wImport.
        ASSIGN               
            wImport.Poltyp    =  nv_poltyp    
            wImport.Policy    =  nv_policy 
            wImport.CedPol    =  Imcedpol  
            wImport.Renpol    =  ""  
            wImport.Compol    =  IF Imstkno <> "" THEN "Y" ELSE "N"  
            wImport.Comdat    =  Imcomdate  
            wImport.Expdat    =  ImExpdate  
            wImport.Tiname    =  nv_tinam  
            wImport.Insnam    =  ImInsnam 
            wimport.name3     =  TRIM(imname2)  /*a60-0545*/
            wimport.dealer    =  TRIM(Imdealernam) /*a60-0545*/
            wImport.name2     =  nv_name2 
            wImport.name70    =  nv_name70
            wImport.name72    =  nv_name72
            wImport.iaddr1    =  Imiadd1  
            wImport.iaddr2    =  Imiadd2  
            wImport.iaddr3    =  Imiadd3   
            wImport.iaddr4    =  Imiadd4 
            wImport.Prempa    =  ""
            wImport.class     =  Imcodecar  
            wImport.Brand     =  ImBrand  
            wImport.Model     =  ImModel  
            wImport.CC        =  Imcc  
            wImport.Weight    =  ""  
            wImport.Seat      =  ""  
            wImport.Body      =  ""
             /*wImport.Vehreg    =  TRIM(Imvehreg) */ /*a60-0545*/
            wImport.Vehreg    =  IF TRIM(Imvehreg) = "" THEN "/" + SUBSTR(ImChasno,(LENGTH(ImChasno) - 9) + 1,LENGTH(ImChasno)) ELSE TRIM(Imvehreg)  /*a60-0545*/
            wImport.CarPro    =  nv_carpro
            wImport.Engno     =  ImEngno  
            wImport.Chano     =  ImChasno  
            wImport.yrmanu    =  Imyrmanu  
            wImport.Vehuse    =  Imothvehuse 
            wImport.garage    =  Imgarage1 
            wImport.stkno     =  Imstkno  
            wImport.covcod    =  Imcovcod  
            wImport.si        =  Imsi  
            /*wImport.Prem_t    =  ImPrem  /*ImNetPrem */ */ /*A60-0545*/
            /*wImport.Prem_c    =  Imcomp  /*ImNetComp*/  */ /*A60-0545*/
            /*wImport.Prem_r    =  ImPremtot              */ /*A60-0545*/
            wImport.Prem_t    =  deci(ImPrem)       /*A60-0545*/
            wImport.Prem_c    =  deci(Imcomp)       /*A60-0545*/
            wImport.Prem_r    =  deci(ImPremtot)    /*A60-0545*/
            wImport.Bennam    =  Imbennam  
            wImport.drivnam   =  nv_drivnam 
            wImport.drivnam1  =  Imdrivnam1 
            wImport.drivbir1  =  Imdrivbir1 
            wImport.drivic1   =  TRIM(Imidno1)    /*A60*0545*/
            wImport.drivid1   =  TRIM(Imlicen1)   /*A60*0545*/
            wImport.drivage1  =  ""  
            wImport.drivnam2  =  Imdrivnam2  
            wImport.drivbir2  =  Imdrivbir2 
            wImport.drivic2   =  TRIM(Imidno2)   /*A60*0545*/   
            wImport.drivid2   =  TRIM(Imlicen2)  /*A60*0545*/   
            wImport.drivage2  =  ""  
            wImport.Redbook   =  ""  
            wImport.opnpol    =  Imopnpol  
            wImport.bandet    =  Imbandet  
            wImport.tltdat    =  Imtltdat  
            wImport.attrate   =  Imattrate
            wImport.branch    =  Imbranch
            /*wImport.vatcode   =  Imcomment *//*Comment A56-0250*/
            wImport.vatcode   =  ImVatCode     /*A56-0250*/
            /*wImport.Text1     =  Immadd1
            wImport.Text2     =  Immadd2*/ /*Comment A56-0250*/
            wImport.Text1     =  Imcomment  /*A56-0250*/
            wImport.Text2     =  ImRemark1  /*A56-0250*/
            /*wImport.finit     =  Imsalenam*//*Comment A56-0250*/
            wImport.finit     =  ImFinint       /*A56-0250*/
            wImport.icno      =  Imicno   /*A55-0235*/
            wImport.Rebate    =  Imcodereb. /*A55-0235*/ 

        /*--- Check Package ---*/
        IF wImport.Prempa = " " THEN DO:
             /* comment by Ranu I. A60-0545 .......
             IF SUBSTRING(wImport.CedPol,6,1) = "U" THEN wImport.Prempa = "G".
             ELSE IF wImport.Brand = "TOYOTA" THEN wImport.Prempa = "X".
             ELSE IF wImport.Brand = "ISUZU" THEN wImport.Prempa = "V".
             ELSE wImport.Prempa = "Z".
             ......end A60-0545..*/
            /* create by A60-0545 */
             IF SUBSTRING(wImport.CedPol,6,1) = "U" THEN DO:
                 ASSIGN wImport.Prempa = "G"
                        wImport.garage = "".
             END.
             ELSE IF wImport.Brand = "FORD" THEN wImport.Prempa = "F".
             ELSE wImport.Prempa = "Z".
            /* end A60-0545 */
        END.
        RUN PdChkRedBook.
        RUN PDChktext.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdCreateRenew C-Win 
PROCEDURE PdCreateRenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wImport WHERE wImport.policy = nv_policy NO-ERROR NO-WAIT.
IF NOT AVAIL wImport THEN DO:
    CREATE wImport.
    ASSIGN               
       wImport.Poltyp    =  nv_poltyp /*IF Imstkno <> "" AND ImNetPrem = 0 THEN "72" ELSE "70"*/ /*A54-0079*/    
       wImport.Policy    =  nv_policy /*nv_policy + "NB"*//*A54-0076*/
       wImport.CedPol    =  Imcedpol   
       wImport.Renpol    =  nv_oldpol  
       wImport.Compol    =  IF Imstkno <> "" THEN "Y" ELSE "N"   
       wImport.Comdat    =  IF nv_poltyp = "70" THEN Imcomdate ELSE Imcomdat1 /*A54-0076 บ้างที comdate ไม่เหมือน 70*/ 
       wImport.Expdat    =  IF nv_poltyp = "70" THEN Imexpdate ELSE Imexpdat1 /*A54-0076 บ้างที expdate ไม่เหมือน 70*/ 
       wImport.Tiname    =  nv_tinam   
       wImport.Insnam    =  ImInsnam  
       wImport.name2     =  "" 
       wImport.iaddr1    =  Imiadd1  
       wImport.iaddr2    =  Imiadd2  
       wImport.iaddr3    =  Imiadd3   
       wImport.iaddr4    =  Imiadd4
       wImport.Prempa    =  nv_prempa /*IF Imcovcod = "1" OR Imcovcod = "2" THEN "G" ELSE "R"*/
       wImport.class     =  Imcodecar  
       wImport.Brand     =  ImBrand  
       wImport.Model     =  ImModel  
       wImport.CC        =  Imcc   
       wImport.Weight    =  ""  
       wImport.Seat      =  ""  
       wImport.Body      =  ""
       wImport.Vehreg    =  Imvehreg
       wImport.CarPro    =  Imvehreg1
       wImport.Engno     =  ImEngno  
       wImport.Chano     =  ImChasno   
       wImport.yrmanu    =  Imyrmanu  
       wImport.Vehuse    =  Imothvehuse  
       wImport.garage    =  Imgarage1  
       wImport.stkno     =  Imstkno  
       wImport.covcod    =  Imcovcod   
       wImport.si        =  Imsi  
       /*wImport.Prem_t    =  ImNetPrem */ /*A60-0545*/
       /*wImport.Prem_c    =  ImNetComp */ /*A60-0545*/  
       /*wImport.Prem_r    =  ImPremtot */ /*A60-0545*/
       wImport.Prem_t    =  deci(ImNetPrem)  /*A60-0545*/
       wImport.Prem_c    =  deci(ImNetComp)  /*A60-0545*/
       wImport.Prem_r    =  deci(ImPremtot)  /*A60-0545*/ 
       wImport.Bennam    =  ImbenNam  
       wImport.drivnam   =  Imvghgrp1  
       wImport.drivnam1  =  Imdrivnam1  
       wImport.drivbir1  =  Imdrivbir1
       wImport.drivic1   =  TRIM(Imidno1)    /*A60*0545*/
       wImport.drivid1   =  TRIM(Imlicen1)   /*A60*0545*/
       wImport.drivage1  =  ""  
       wImport.drivnam2  =  Imdrivnam2   
       wImport.drivbir2  =  Imdrivbir2 
       wImport.drivic2   =  TRIM(Imidno2)    /*A60*0545*/
       wImport.drivid2   =  TRIM(Imlicen2)   /*A60*0545*/
       wImport.drivage2  =  ""  
       wImport.Redbook   =  ""  
       wImport.opnpol    =  Imopnpol + " " + "(" + "R" + Imcodgrp + ")"  
       wImport.bandet    =  Imbandet  
       wImport.tltdat    =  nv_tltdat  
       wImport.attrate   =  Imattrate
       wImport.branch    =  Imbranch
       wImport.vatcode   =  Imcomment 
       wImport.ICNO      =  Imicno
       wImport.Text1     =  Imtltno
       wImport.Text2     =  Imdetail
       wImport.finit     =  ""
       wImport.Rebate    =  "". /*A55-0235*/

       RUN PDChkRedbook.

      /* ASSIGN
           Imiadd1  = ""
           Imiadd2  = ""
           Imiadd3  = ""
           Imbennam = ""
           nv_tinam = "".

       RUN pdChktext.*/
       
END.
ELSE NEXT.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdExport C-Win 
PROCEDURE PdExport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT TO VALUE (fiExpName) NO-ECHO APPEND.
        EXPORT DELIMITER "|"
            "Policy [V70]"
            "Policy [V72]"
            "เลขที่สัญญา"
            "Campaign"
            "Policy Type"
            "Com. Date"
            "Exp. Date"
            "Title Name"
            "Insure name"
            "และ/หรือ"
            "ชื่อกรรมการ "   /*A60-0545*/
            "ชื่อดีลเลอร์"   /*A60-0545*/
            "ใบเสร็จประกัน"
            "ใบเสร็จ พรบ."
            "Address1"
            "Address2"
            "Address3"
            "Address4"
            "Package"
            "Class"
            "Brand"
            "Model"
            "CC"
            "Weigth"
            "Seat" 
            "Body"
            "เลขทะเบียนรถ"
            "จังหวัด"
            "Engine No."
            "Chaiss No."
            "Car Year"
            "Veh.Use"
            "Garage"
            "Sticker"
            "Cover Code"
            "IS"
           /* "Premium Total"       */ /*A60-0545*/
           /* "Premium Compulsory"  */ /*A60-0545*/
            "Net Premium"        /*A60-0545*/  
            "Net Compulsory"    /*A60-0545*/  
            "Total"
            "Bennifit Name"
            "Driver Name [Y/N]"
            "Driver Name1"
            "Birthday1"
            "Driver Icno1"  /*a60-0545*/
            "DriverLicen1"  /*a60-0545*/
            "Age1"
            "Driver Name2"
            "Birthday2"
            "Driver Icno1"  /*a60-0545*/  
            "DriverLicen1"  /*a60-0545*/  
            "Age2"
            "Redbook No."
            "Opnpol"
            "Branch Market"
            "Date"
            "Att.Rate"
            "Branch"
            "Vat Code"
            "Text1"
            "Text2"
            "ICNO"
            "Finit Code"
            "Code Rebate".

        FOR EACH wImport WHERE wImport.poltyp <> "" NO-LOCK:
          EXPORT DELIMITER "|"     
              /*1*/   wImport.Policy        /*1. เลขที่กรมธรรม์ (70)*/                      
              /*2*/   wImport.Compol        /*2. เลขที่กรมธรรม์ (72)*/                       
              /*3*/   wImport.CedPol        /*3. เลขที่สัญญา (มาจากเลขที่รับแจ้ง)*/          
              /*4*/   wImport.Renpol        /*4. เลขที่กรมธรรม์ต่ออายุ*/                     
              /*5*/   wImport.Poltyp        /*5. Policy Type (70/72)*/                       
              /*6*/   wImport.Comdat        /*6. วันที่เริ่มคุ้มครอง*/                       
              /*7*/   wImport.Expdat        /*7. วันที่สิ้นสุดความคุ้มครอง*/                 
              /*8*/   wImport.Tiname        /*8. คำนำหน้าชื่อ*/                              
              /*9*/   wImport.Insnam        /*9. ชื่อผู้เอาประกันภัย*/                       
              /*10*/  wImport.name2         /*10. และ/หรือ*/  
              /*11*/  wimport.name3         /* ชื่อกรรมการ A60-0545*/
                      wimport.dealer        /* ชื่อดีลเลอร์ */
              /*12*/  wImport.name70        /*11. ใบเสร็จประกัน*/ 
              /*13*/  wImport.name72        /*12. ใบเสร็จ พรบ.*/
              /*14*/  wImport.iaddr1        /*13. ที่อยู่ 1*/                                
              /*15*/  wImport.iaddr2        /*14. ที่อยู่ 2*/                                
              /*16*/  wImport.iaddr3        /*15. ที่อยู่ 3*/                                
              /*17*/  wImport.iaddr4        /*16. ที่อยู่ 4*/                                
              /*18*/  wImport.Prempa        /*17. Premium Pack*/                             
              /*19*/  wImport.class         /*18. Class (110)*/                              
              /*20*/  wImport.Brand         /*19. ยี่ห้อรถ*/                                 
              /*21*/  wImport.Model         /*20. รุ่นรถ*/                                   
              /*22*/  wImport.CC            /*21. ขนาดเครื่องยนต์*/                          
              /*23*/  wImport.Weight        /*22. น้ำหนักรถ*/                                
              /*24*/  wImport.Seat          /*23. ที่นั่ง*/                                  
              /*25*/  wImport.Body          /*24. ตัวถัง*/                                   
              /*26*/  wImport.Vehreg        /*25. เลขทะเบียนรถ*/                             
              /*27*/  wImport.CarPro        /*26. จังหวัด*/                                  
              /*28*/  wImport.Engno         /*27. เลขเครื่องยนต์*/                           
              /*29*/  wImport.Chano         /*28. เลขตัวถัง*/                                
              /*30*/  wImport.yrmanu        /*29. ปีที่ผลิต*/                                
              /*31*/  wImport.Vehuse        /*30. ประเภท*/                                   
              /*32*/  wImport.garage        /*31. ซ่อมอู่ ห้าง(G)/ธรรมดา(H)*/                
              /*33*/  wImport.stkno         /*32. เลขสติกเกอร์*/                             
              /*34*/  wImport.covcod        /*33. ประเภทความคุ้มครอง*/                       
              /*35*/  wImport.si            /*34. ทุนประกันภัน*/                             
              /*36*/  wImport.Prem_t        /*35. เบี้ยสุทธิ*/                                 
              /*37*/  wImport.Prem_c        /*36. เบี้ย พรบ.สุทธิ*/                           
              /*38*/  wImport.Prem_r        /*37. เบี้ยรวม + พรบ.*/                            
              /*39*/  wImport.Bennam        /*38. ผู้รับผลประโยชน์*/                         
              /*40*/  wImport.drivnam       /*39. ระบุผุ้ขับขี่ (Y/N)*/                      
              /*41*/  wImport.drivnam1      /*40. ชื่อผุ้ขับขี่ 1*/                          
              /*42*/  wImport.drivbir1      /*41. วันเกิดผู้ขับขี่ 1*/ 
              /*43*/  wImport.drivic1       /*เลขบัตร ปปช.*/              /*A60-0545*/
              /*44*/  wImport.drivid1       /*เลขที่ใบขับขี่*/            /*A60-0545*/
              /*45*/  wImport.drivage1      /*42. อายุผู้ขับขี่ 1*/                          
              /*46*/  wImport.drivnam2      /*43. ชื่อผุ้ขับขี่ 2*/                          
              /*47*/  wImport.drivbir2      /*44. วันเกิดผู้ขับขี่ 2*/  
              /*48*/  wImport.drivic2       /*เลขบัตร ปปช.*/             /*A60-0545*/
              /*49*/  wImport.drivid2       /*เลขที่ใบขับขี่*/           /*A60-0545*/
              /*50*/  wImport.drivage2      /*45. อายุผู้ขับขี่ 2*/                          
              /*51*/  wImport.Redbook       /*46. รหัส redbook*/                             
              /*52*/  wImport.opnpol        /*47. ชื่อผุ้แจ้ง*/                              
              /*53*/  wImport.bandet        /*48. ตลาดสาขา*/                                 
              /*54*/  wImport.tltdat        /*49. วันที่รับแจ้ง*/                            
              /*55*/  wImport.attrate       /*50. Attrate*/                                  
              /*56*/  wImport.branch        /*51. Branch*/                                   
              /*57*/  wImport.vatcode       /*52. Vat Code*/                                 
              /*58*/  wImport.Text1         /*53. Text ถังแก๊ส*/                             
              /*59*/  wImport.Text2         /*54. Text ตรวจสภาพ*/                            
              /*60*/  wImport.icno          /*55. เลขที่บัตรประชาชน*/                        
              /*61*/  wImport.finit         /*56. ...*/                                      
              /*62*/  wImport.Rebate.        /*57. ...*/  
        END.
    OUTPUT CLOSE.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdImpNew C-Win 
PROCEDURE PdImpNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Edit A59-0070      
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fiImpName).
    REPEAT:
        IMPORT DELIMITER "|"
            /*comment by Ranu I. A60-0545 date 22/12/2017.........
            /*1*/  Imidno           /*id*/
            /*2*/  Imtltdat         /*วันที่รับแจ้ง*/
            /*3*/  Imcomcod         /*Code ประกันภัย*/
            /*4*/  Imstkno          /*เลขสติ๊กเกร์*/
            /*5*/  Imstkno1         /*ค้าแจ้งเลขสติ๊กเกอร์*/
            /*6*/  Imyrcomp         /*พรบ.ปี*/
            /*7*/  Impolcomp        /*กธ.พรบ.เลขที่*/
            /*8*/  Imcomnam         /*ชื่อประกันภัย*/
            /*9*/  Imcedpol         /*เลขที่รับแจ้ง*/
            /*10*/ Imbandet         /*ตลาดสาขา*/
            /*11*/ Imbancode        /*Code ตลาดสาขา*/
            /*12*/ Imopnpol         /*ผู้แจ้ง*/
            /*13*/ Imcodgrp         /*กลุ่ม*/
            /*14*/ Imtiname         /*ผู้รับแจ้ง*/
            /*15*/ Iminsnam         /*ชื่อผู้เอาประกันภัย*/
            /*16*/ ImICNo           /*บัตรประชาชน/เลขทะเบียนการค้า*/
            /*17*/ Imnfadd          /*ที่อยู่ NF*/
            /*18*/ Iminadd          /*ที่อยู่ลูกค้า*/
            /*19*/ Imdeadd          /*ที่อยู่ Dealer*/
            /*20*/ Imiadd1          /*รายละเอียดที่อยู่*/
            /*21*/ Imiadd2          /*รายละเอียดที่อยู่1*/
            /*22*/ Imiadd3          /*เบอร์โทร*/
            /*23*/ Immadd1          /*ที่อยู่เอกสาร*/
            /*24*/ Immadd2          /*ที่อยู่เอกสาร 1*/
            /*25*/ Immadd3          /*เบอร์โทร1*/
            /*26*/ Imsi             /*ทุนประกัน*/
            /*27*/ Imgrossi         /*วงเงินคุ้มครอง*/
            /*28*/ Imprem           /*เบี้ยประกันสุทธิ*/
            /*29*/ Imnetprem        /*เบี้ยประกันรวม*/
            /*30*/ Imcomp           /*เบี้ย พรบ. สุทธิ*/
            /*31*/ Imnetcomp        /*เบี้ย พรบ.รวม*/
            /*32*/ Impremtot        /*เบี้ยประกัน + พรบ.*/
            /*33*/ Imbrand          /*ยี่ห้อ*/
            /*34*/ Immodel          /*รุ่น*/
            /*35*/ Imyrmanu         /*ปี*/
            /*36*/ Imcarcol         /*สี*/
            /*37*/ Imvehreg         /*เลขทะเบียน*/
            /*38*/ Imcc             /*ขนาดเครื่องยนต์*/
            /*39*/ Imengno          /*เลขเครื่องยนต์*/
            /*40*/ Imchasno         /*เลขตัวถัง*/
            /*41*/ Imother1         /*ไม่แถม*/
            /*42*/ Imother2         /*TBank/TGL แถม*/
            /*43*/ Imother3         /*Delear ดำเนินการเอง*/
            /*44*/ Imandor1         /*Dealer แถม*/
            /*45*/ Imandor3         /*TBank แถมพรบ.*/
            /*46*/ Imother4         /*ไม่ซื้อ*/
            /*47*/ Imandor2         /*พรบ.Dealer*/
            /*48*/ Imother5         /*พรบ.ลูกค้า*/
            /*49*/ Imattrate        /*PATTERN RATE*/
            /*50*/ Imcarpri         /*ราคารถ*/
            /*51*/ Imdealernam      /*ชื่อ Dealer*/
            /*52*/ Imsalenam        /*ชื่อ Sale*/
            /*53*/ Imcovcod         /*ประเภทการประกันภัย*/
            /*54*/ Imvghgrp1        /*ระบุชื่อ*/
            /*55*/ Imvghgrp2        /*ไม่ระบุชื่อ*/
            /*56*/ Imdrivnam1       /*ชื่อ1*/
            /*57*/ Imdrivbir1       /*วันเดือนปี เกิด1*/
            /*58*/ Imidno1          /*เลขที่ ID1*/
            /*59*/ Imlicen1         /*ใบขับขี่ 1 เลขที่*/
            /*60*/ Imdrivnam2       /*ชื่อ2*/            
            /*61*/ Imdrivbir2       /*วันเดือนปี เกิด2*/  
            /*62*/ Imidno2          /*เลขที่ ID2*/        
            /*63*/ Imlicen2         /*ใบขับขี่ 2 เลขที่*/ 
            /*64*/ Imcomdate        /*วันที่คุ้มครอง*/
            /*65*/ Imexpdate        /*วันสิ้นสุดคุ้มครอง*/
            /*66*/ Imvehuse1        /*ส่วนบุคคล*/
            /*67*/ Imvehuse2        /*เพื่อการพาณิชย์*/
            /*68*/ Imvehuse3        /*เพื่อการพาณิชย์พิเศษ*/
            /*69*/ Imvehuse4        /*รับจ้างสาธารณะ*/
            /*70*/ Imvehuse5        /*อื่นๆ*/
            /*71*/ Imothvehuse      /*หมายเหตุอื่นๆ*/
            /*72*/ Imcodecar        /*รหัส*/
            /*73*/ Imdetrge1        /*ป้ายแดง*/
            /*74*/ Imdetrge2        /*USED CAR*/
            /*75*/ Imbody1          /*เก๋ง*/
            /*76*/ Imbody2          /*กระบะ*/
            /*77*/ Imbody3          /*ตู้*/
            /*78*/ Imbody4          /*อื่นๆ*/
            /*79*/ Imothbody        /*ประเภภทรถอื่นๆ*/
            /*80*/ Imgarage1        /*อู่ห้าง*/
            /*81*/ Imgarage2        /*อู่ธรรมดา*/
            /*82*/ Imcodereb        /*Code Rebate*/
            /*83*/ Imcomment        /*หมายเหตุ*/
            /*84*/ Imseat           /*จำนวนที่นั่ง*/
            /*85*/ Imdoctyp         /*ประเภทเอกสาร*/
            /*86*/ Imicno1          /*เลขประจำตัวผู้เสียภาษี*/
            /*87*/ Imdocdetail      /*จดทะเบียนภาษีมูลค่าเพิ่มหรือไม่*/
            /*88*/ Imbranins        /*สาขาที่*/
            /*89*/ Imbennam         /*ผู้รับผลประโยชน์*/
            /*90*/ ImVatCode        /*Vat Code*/
            /*91*/ ImFinint         /*Finnit Code*/
            /*92*/ ImRemark1        /*Remark1*/
            /*93*/ ImRemark2        /*Remark2*/ .
            ....end A60-0545.......*/
            /* create by : Ranu i. A60-0545 20/12/2017 */
            Imtltdat            /*วันที่รับแจ้ง         */                
            Imcomcod            /*Code ประกันภัย        */                
            Imstkno             /*เลขสติ๊กเกอร์         */                
            Impolcomp           /*กธ พรบ เลขที่         */                
            Imcomnam            /*ชื่อประกันภัย         */                
            Imcedpol            /*เลขที่รับแจ้ง         */                
            Imbandet            /*ตลาดสาขา              */                
            Imbancode           /*Code ตลาดสาขา         */                
            Imopnpol            /*ผู้แจ้ง               */                
            Imcodgrp            /*กลุ่ม                 */                
            Imtiname            /*ผู้รับแจ้ง            */                
            Iminsnam            /*ชื่อผู้เอาประกันภัย   */                
            ImICNo              /*เลขที่บัตร            */                
            Imiadd1             /*ที่อยุ่ปัจจุบัน/ภพ.20 */                
            Imiadd2             /*ที่อยุ่ปัจจุบัน/ภพ.20 */                
            Imiadd3             /*เบอร์โทร              */                
            Immadd1             /*ที่อยู่ส่งเอกสาร      */                
            Immadd2             /*ที่อยู่ส่งเอกสาร1     */                
            Immadd3             /*เบอร์โทร1             */                
            Imsi                /*ทุนประกัน             */                
            Imprem              /*เบี้ยประกันสุทธิ      */                
            Imnetprem           /*เบี้ยประกันรวม        */                
            Imcomp              /*เบี้ยพรบ สุทธิ        */                
            Imnetcomp           /*เบี้ยพรบ รวม          */                
            Impremtot           /*เบี้ยประกัน+พรบ       */                
            imnotino            /*เลขคุ้มครองชั่วคราว   */                
            Imbrand             /*ยี่ห้อ                */                
            Immodel             /*รุ่น                  */                
            Imyrmanu            /*ปี                    */                
            Imcarcol            /*สี                    */                
            Imvehreg            /*เลขทะเบียน            */                
            Imcc                /*ขนาดเครื่องยนต์       */                
            Imengno             /*เลขเครื่องยนต์        */                
            Imchasno            /*เลขตัวถัง             */                
            ImRemark1           /*เหตุผลกรณี เลขเครื่อง/เลขถังซ้ำ*/       
            Imother1            /*ภาคสมัครใจ แถม/ไม่แถม*/                 
            Imother2            /*ภาคบังคับ แถม/ไม่แถม */                 
            Imattrate           /*PATTERN RATE         */                 
            Imcarpri            /*ราคารถ               */                 
            Imgrossi            /*ราคากลาง             */                 
            Imdealernam         /*ชื่อ Dealer          */                 
            Imcovcod            /*ประเภทการประกันภัย   */                 
            Imvghgrp1           /*ผู้ขับขี่            */                 
            Imdrivnam1          /*ชื่อ 1               */                 
            Imdrivbir1          /*วัน/เดือน/ปีเกิด1    */                 
            Imidno1             /*เลขที่ ID1           */                 
            Imlicen1            /*ใบขับขี่ 1 เลขที่    */                 
            Imdrivnam2          /*ชื่อ 2               */                 
            Imdrivbir2          /*วัน/เดือน/ปีเกิด2    */                 
            Imidno2             /*เลขที่ ID2           */                 
            Imlicen2            /*ใบขับขี่ 2 เลขที่    */                 
            Imcomdate           /*วันที่คุ้มครอง       */                 
            Imexpdate           /*วันสิ้นสุดคุ้มครอง   */                 
            Imvehuse1           /*ประเภทการใช้รถ       */                 
            Imothvehuse         /*หมายเหตุอื่นๆ        */                 
            Imcodecar           /*รหัส                 */                 
            Imdetrge1           /*ชนิดรถ               */                 
            Imbody1             /*ประเภทรถ             */                 
            Imothbody           /*ประเภทรถอื่นๆ        */                 
            Imgarage1           /*ประเภทการซ่อม        */                 
            Imcodereb           /*Code Rebate          */                 
            Imcomment           /*หมายเหตุ             */                 
            Imseat              /*จำนวนที่นั่ง         */                 
            Imicno1             /*เลขประจำตัวผู้เสียภาษี */               
            imname2             /*ชื่อกรรมการบริษัท      */               
            Imdoctyp            /*ประเภทเอกสาร           */               
            Imdocdetail         /*จดทะเบียนภาษีมูลค่าเพิ่มหรือไม่*/       
            Imbranins           /*สาขาที่              */                 
            Imbennam            /*ผู้รับผลประโยชน์     */                 
            Imidno .            /*เลขที่ใบคำขอเช่าซื้อ */ 

        IF index(Imtltdat,"วันที่") <> 0  THEN NEXT.
        ELSE IF TRIM(Imtltdat) = ""  THEN NEXT.
        ELSE DO:
        /*-- end a60-0545 --*/
            RUN PdChkData.
        END.
    END.
INPUT CLOSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdImpRenew C-Win 
PROCEDURE PdImpRenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Edit A59-0070      
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fiImpName).
    REPEAT:
        IMPORT DELIMITER "|"
            Imtltno
            Imtltno1
            Imbancode
            Imcedpol
            Imrenpol
            Imcomnam
            Iminsnam
            Imbennam
            Imcomdate
            Imexpdate
            Imcomdat1
            Imexpdat1
            Imvehreg
            Imvehreg1
            Imsi
            Imnetprem
            Imnetcomp
            Impremtot
            Impolcomp
            Imstkno
            Imcodgrp
            Imdetail
            Imtltdat
            Imcomnam1
            Imopnpol
            Imbrand
            ImModel
            Imyrmanu
            Imcc
            Imengno
            Imchasno
            Imattrate
            Imcovcod
            Imbody1
            Imgarage1
            Imdrivnam1
            Imlicen1
            Imidno1
            Imdrivbir1
            Imdrivnam2
            Imlicen2
            Imidno2
            Imdrivbir2
            /*Imdeduct1
            Imdeduct2
            Imdeduct3*/
            Imdeductda 
            Imncb      
            Imdeductpd 
            Imother
            Imaddr
            Imicno
            Imiccomdat
            Imicexpdat
            Imtypaid.

        RUN PdChkRenew.
    END.
INPUT CLOSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDReports C-Win 
PROCEDURE PDReports :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR HEAD AS CHAR INIT "Y".
DEF VAR nv_row AS INTE INIT 1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.

FOR EACH wImport WHERE 
        wImport.PASS = "N" NO-LOCK:
        pass = pass + 1.
END.

IF pass > 0 THEN DO:
    OUTPUT TO VALUE (nv_ExpName) NO-ECHO APPEND.
        EXPORT DELIMITER "|"
            "Type of Policy"     
            "เลขที่กรมธรรม์"     
            "เลขที่สัญญา"     
            "เลขกรมธรรม์ต่ออายุ"     
            "Compulsory"     
            "วันที่เริ่มคุ้มครอง"     
            "วันที่สิ้นสุดความคุ้มครอง"     
            "คำนำหน้าชื่อ"     
            "ชื่อผู้เอาประกัน"     
            "และ/หรือ"      
            "ที่อยู่ 1"     
            "ที่อยู่ 2"     
            "ที่อยู่ 3"     
            "ที่อยู่ 4"     
            "Pack"     
            "Class"      
            "Brand"      
            "Model"      
            "CC"         
            "Weight"     
            "Seat"       
            "Body"       
            "ทะเบียนรถ"     
            "จังหวัด"     
            "เลขเครื่องยนต์"      
            "เลขตัวถัง"      
            "ปีที่ผลิต"     
            "ประเภทการใช้"     
            "ซ่อมอู่ห้าง/ธรรมดา"     
            "เลขที่สติกเกอร์"      
            "ประเภทความคุ้มครอง"     
            "ทุนประกันภัย"         
            "เบี้ยประกันรวม"     
            "เบี้ย พรบ. รวม"     
            "เบี้ยรวม + พรบ."     
            "ผู้รับผลประโยชน์"     
            "ระบุผู้ขับขี่"    
            "ชื่อผู้ขับขี่ 1"   
            "วัน/เดือน/ปีเกิด1" 
            "เลขที่บัตร1"         /*A60-0545*/
            "เลขที่ใบขับขี่1"     /*A60-0545*/
            "อายุ 1"   
            "ชื่อผู้ขับขี่ 2"   
            "วัน/เดือน/ปีเกิด2"   
            "เลขที่บัตร2"         /*A60-0545*/
            "เลขที่ใบขับขี่2"     /*A60-0545*/
            "อายุ 2"   
            "Redbook"    
            "ผู้แจ้ง"     
            "สาขาตลาด"     
            "วันที่รับแจ้ง"     
            "ATTERN RATE"
            "Branch"  
            "Vat Code"  
            "Text1" 
            "Text2" 
            /*"Comment"*/ /*A60-0545*/  
            "ICNO"  
            "Finit Code "
            "Code Rebate"
            "Agent    "
            "Producer "
            "Campaign " 
            "ชื่อกรรมการ".  /*A60-0545*/ 
    
        FOR EACH wImport WHERE wImport.pass = "N" NO-LOCK.
          EXPORT DELIMITER "|"
            Poltyp     /*1. Policy Type (70/72)*/    
            Policy     /*2. เลขที่กรมธรรม์ (70)*/ 
            CedPol     /*3. เลขที่สัญญา (มาจากเลขที่รับแจ้ง)*/
            Renpol     /*4. เลขที่กรมธรรม์ต่ออายุ*/
            Compol     /*5. Check (Y/N) พ่วง 72 หรือไม่*/
            Comdat     /*6. วันที่เริ่มคุ้มครอง*/
            Expdat     /*7. วันที่สิ้นสุดความคุ้มครอง*/
            Tiname     /*8. คำนำหน้าชื่อ*/ 
            Insnam     /*9. ชื่อผู้เอาประกันภัย*/
            name2      /*10. และ/หรือ*/
            iaddr1     /*11. ที่อยู่ 1*/
            iaddr2     /*12. ที่อยู่ 2*/
            iaddr3     /*13. ที่อยู่ 4*/
            iaddr4     /*14. ที่อยู่ 5*/
            Prempa     /*15. Premium Pack*/
            class      /*16. Class (110)*/
            Brand      /*17. ยี่ห้อรถ*/
            Model      /*18. รุ่นรถ*/
            CC         /*19. ขนาดเครื่องยนต์*/
            Weight     /*20. น้ำหนักรถ*/
            Seat       /*21. ที่นั่ง*/
            Body       /*22. */
            Vehreg     /*23. เลขทะเบียนรถ*/
            CarPro     /*24. จังหวัด*/
            Engno      /*25. เลขเครื่องยนต์*/
            Chano      /*26. เลขตัวถัง*/
            yrmanu     /*27. ปีที่ผลิต*/
            Vehuse     /*28. ประเภท*/
            garage     /*29. ซ่อมอู่ ห้าง(G)/ธรรมดา(H)*/
            stkno      /*30. เลขสติกเกอร์*/
            covcod     /*31. ประเภทความคุ้มครอง*/
            si         /*32. ทุนประกันภัน*/
            Prem_t     /*33. เบี้ยรวม*/
            Prem_c     /*34. เบี้ย พรบ. รวม*/
            Prem_r     /*35. เบี้ยรวม พรบ.*/  
            Bennam     /*36. ผู้รับผลประโยชน์*/
            drivnam    /*37. ระบุผุ้ขับขี่ (Y/N)*/
            drivnam1   /*38. ชื่อผุ้ขับขี่ 1*/
            drivbir1   /*39. วันเกิดผู้ขับขี่ 1*/
            drivic1    /* เลขบัตรปปช. */    /*A60*0545*/  
            drivid1    /* เลขบัตรขับขี่*/    /*A60*0545*/ 
            drivage1   /*40. อายุผู้ขับขี่ 1*/
            drivnam2   /*38. ชื่อผุ้ขับขี่ 2*/   
            drivbir2   /*39. วันเกิดผู้ขับขี่ 2*/
            drivic2    /* เลขบัตรปปช. */    /*A60*0545*/  
            drivid2    /* เลขบัตรขับขี่*/    /*A60*0545*/ 
            drivage2   /*40. อายุผู้ขับขี่ 2*/   
            Redbook    /*41. รหัส redbook*/
            opnpol     /*42. ชื่อผุ้แจ้ง*/
            bandet     /*43. ตลาดสาขา*/
            tltdat     /*44. วันที่รับแจ้ง*/
            attrate    /*45. Attrate*/
            branch     /*46. Branch*/
            vatcode    /*47. Vat Code*/
            text1      /*48. Text ถังแก๊ส*/
            text2      /*49. Text ตรวจสภาพ*/
            icno       /*50. เลขที่บัตรประชาชน*/ 
            finit     /* vatcode */
            Rebate    /* recode */
            name3 .   /* ชื่อกรรมการ */
        END.
    OUTPUT CLOSE.
END. /*pass > 0*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

