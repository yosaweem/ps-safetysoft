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
            : ��Ѻ��ô֧��Ң����ŷ�� Parameter     
            : Duplicate Form WUWTAIMP.W ---> WGWTAIMP.W
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A54-0076   15/03/2011
           : ��Ѻ��� Put File Excel ���͹���� GW ��� Put �͡��� 70 + 72 
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A55-0235  20/08/2012
           : ��Ѻ�ҹ new Thanachat ����������� "��Ҥ���"  
-------------------------------------------------------------------------
 Modify By : Porntiwa P. A54-0112  26/11/2012
           : ���·���¹ö�ҡ 10 �� 11 ��ѡ      
-------------------------------------------------------------------------
 Modify By : Porntiwa P.  A56-0250  05/08/2013
           : ��Ѻ�ҹ����Ңͧ Thanachat ���ͧ�ҡ���� Column IC No.
           : Check ���͹� ���/ ����  ���� �����駡���͡ Vat Code ����  
------------------------------------------------------------------------
 Modify By : Porntiwa P. A59-0070  29/03/2016
           : ��Ѻ��ù��������� Thanachat            
-------------------------------------------------------------------------
Modify by : Ranu I. A59-0471 Date: 04/10/2016
          : ����¹���͹䢡�� check �ú. �ҡʵ�����������¾ú. ᷹                                                                
------------------------------------------------------------------------
Modify by : Ranu I. A60-0545 Date: 20/12/2017
          : ����¹ format File �駧ҹ����ᴧ 
                                                                       
Modify by : Ranu I. A63-0174 date : 28/04/2020
          : ����¹ format File �駧ҹ����ᴧ��Ҥ������ attrate ����ö �͡ �����������                                                            
------------------------------------------------------------------------*/
/* Modify by : Ranu I. A64-0205 �������͹䢡�ô֧������ producer/Agent */
/* Modify by : Ranu I. A64-0278 �����͹䢡����� ���/����             */
/* Modify by : Kridtiya i. A66-0160 Date. 15/08/2023 Add color */  
/*----------------------------------------------------------------------*/
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
    FIELD name2      AS CHAR FORMAT "X(35)"               INIT ""
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
    FIELD Vehgrp     AS CHAR FORMAT "X(2)"                INIT "" /*A59-0070*/
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
    FIELD Rebate     AS CHAR INIT ""                                  /*A55-0235*/
    FIELD name3      AS CHAR FORMAT "X(75)"                INIT ""    /*A60-0545*/
    FIELD agent      AS CHAR FORMAT "X(10)"                INIT ""    /*A64-0205*/
    FIELD producer   AS CHAR FORMAT "X(10)"                INIT ""    /*A64-0205*/
    FIELD ncolor     AS CHAR FORMAT "X(50)"                INIT "".      /*A66-0160*/
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
DEFINE VAR nv_ExpName  AS CHAR FORMAT "X(60)".
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
DEFINE VAR nv_vatcode  AS CHAR FORMAT "X(10)".

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

DEFINE VARIABLE fiExpName AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 53.17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fiImpName AS CHARACTER FORMAT "X(500)":U 
     VIEW-AS FILL-IN 
     SIZE 50.17 BY 1
     BGCOLOR 15 FGCOLOR 0 FONT 2 NO-UNDO.

DEFINE VARIABLE fi_vatcode AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE ra_data AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "NEW", 1,
"RENEW", 2
     SIZE 46.33 BY 1.19
     BGCOLOR 3 FGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-379
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 74.33 BY 6.14
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
     fi_vatcode AT ROW 4.43 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fiImpName AT ROW 5.62 COL 19.33 COLON-ALIGNED NO-LABEL
     ra_data AT ROW 3.14 COL 27.33 NO-LABEL
     fiExpName AT ROW 6.86 COL 19.33 COLON-ALIGNED NO-LABEL
     butFile AT ROW 5.62 COL 71.67
     buok AT ROW 4.29 COL 78.83
     buexit AT ROW 6.62 COL 78.83
     " Export File Name :" VIEW-AS TEXT
          SIZE 18.5 BY .62 AT ROW 7 COL 3
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "Translation Excel File For Thanachat" VIEW-AS TEXT
          SIZE 49.17 BY 1.19 AT ROW 1.48 COL 22.67
          BGCOLOR 1 FGCOLOR 7 FONT 23
     " Check Vat Code :" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 4.62 COL 3 WIDGET-ID 4
          BGCOLOR 3 FGCOLOR 15 FONT 6
     "(.CSV)" VIEW-AS TEXT
          SIZE 6 BY .62 AT ROW 7.76 COL 13.5
          BGCOLOR 3 FGCOLOR 15 FONT 6
     " Import File Name :" VIEW-AS TEXT
          SIZE 18 BY .62 AT ROW 5.81 COL 3
          BGCOLOR 3 FGCOLOR 15 FONT 6
     RECT-379 AT ROW 2.95 COL 2.17
     RECT-380 AT ROW 1.24 COL 1.67
     RECT-381 AT ROW 3.86 COL 77.33
     RECT-382 AT ROW 6.19 COL 77.33
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 92.33 BY 8.52
         FGCOLOR 8 .


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
         HEIGHT             = 8.71
         WIDTH              = 92.67
         MAX-HEIGHT         = 46.1
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 46.1
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
  
    RUN PdExport.
    RUN PDReports.

    FOR EACH wImport:
        DELETE wImport.
    END.
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
         /* comment by A60-0545 ........
         cvtext = TRIM(SUBSTRING(cvData,INDEX(cvdata,"\") + 1,LENGTH(cvdata))).
         fiExpName = SUBSTRING(cvData,1,INDEX(cvdata,"\")) +
                     SUBSTRING(cvtext,1,INDEX(cvtext,"\")).
        ...........end A60-0545.........*/
         /*A60-0545*/
         no_add = STRING(MONTH(TODAY),"99")    + 
                  STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
         fiexpname = SUBSTR(fiImpName,1,R-INDEX(fiImpName,".") - 1 ) + "_Load" + NO_add. 
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


&Scoped-define SELF-NAME fi_vatcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vatcode C-Win
ON LEAVE OF fi_vatcode IN FRAME fr_main
DO:
    fi_vatcode = INPUT fi_vatcode .
    DISP fi_vatcode WITH FRAME fr_main.
  
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
  
  gv_prgid = "WGWTAIMP".
  IF gv_prgid  = "WGWTAIMP" THEN gv_prog  = "Translation Excel File For Thanachat".
  ELSE gv_prog  = "Translation Excel File For Thanachat".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
  RUN  WUT\WUTWICEN (c-win:HANDLE).
  SESSION:DATA-ENTRY-RETURN = YES.
  
  APPLY "ENTRY" TO fiImpname IN FRAME fr_main.
  ra_data = 1.
  ASSIGN fi_vatcode = "NB_CODE" . /*A64-0205*/
  DISP ra_data  fi_vatcode WITH FRAME fr_main. /*A64-0205*/
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK_PdChkData C-Win 
PROCEDURE BK_PdChkData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    /* comment by Ranu I. a60-0545 date:21/12/2017 .......................
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
    IF Imprem = 0 AND Imnetprem = 0 THEN nv_poltyp = "72".
    ELSE nv_poltyp = "70".
    /* End Add A54-0076 */

    /*nv_policy = nv_poltyp + Imidno + "NB".*//*Comment A54-0076*/
    nv_policy = nv_poltyp + Imidno.

    /*---- vghgrp (drivnam) ---*/
    IF (Imvghgrp2 = "TRUE"  OR Imvghgrp2 = "1") AND 
       (Imvghgrp1 = "FALSE" OR Imvghgrp1 = "0") THEN nv_drivnam = "N" .
                                                ELSE nv_drivnam = "Y" .
    /*---- Comment A56-0250 ----
    /*----- Check ���/���� name2 ----*/
    nv_name2 = "".
    IF Imandor1 = "TRUE" AND Imandor2 = "TRUE" THEN DO:
        nv_name2 = "���/����" + " " + Imdealernam.
    END.
    /*--- Add A55-0235 ---*/
    ELSE DO:
        IF Imandor3 = "FALSE" THEN DO:
            nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
        END.
    END.
    /*-- END ADD A55-0235 --*/
    /*ELSE nv_name2 = "".*//*Comment A55-0235*/
    ---- End Comment A56-0250 ---*/

    /*--- Add A56-0250 ---*/
    IF nv_poltyp = "70" THEN DO:
        /** ���/���� Line 70 **/
        nv_name2 = "".
        IF      (Imother2 = "FALSE" OR Imother2 = "0")  AND (Imandor1 = "TRUE"  OR Imandor1 = "1") THEN nv_name2 = "���/����" + " " + Imdealernam.
        ELSE IF (Imother2 = "TRUE"  OR Imother2 = "1")  AND (Imandor1 = "FALSE" OR Imandor1 = "0") THEN nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
        ELSE IF (Imother2 = "FALSE" OR Imother2 = "0")  AND (Imandor1 = "FALSE" OR Imandor1 = "0") THEN nv_name2 = " ".
        ELSE IF Imdealernam <> ""                          THEN nv_name2 = "���/����" + " " + Imdealernam.
        ELSE "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
    
        /** Vat Code Line 70 **/
        nv_vatcode = "".
        IF (Imother2 = "FALSE" OR Imother2 = "0") AND (Imandor1 = "FALSE" OR Imandor1 = "0")  THEN nv_vatcode = "".
        ELSE nv_vatcode = ImVatCode.
        /*IF      Imother2 = "FALSE" AND Imandor1 = "TRUE"   THEN nv_vatcode = ImVatCode.  /*FALSE + TRUE*/
        ELSE IF Imother2 = "TRUE"  AND Imandor1 = "FLASE"  THEN nv_vatcode = ImVatCode.  /*TRUE + FALSE*/
        ELSE IF Imother2 = "TRUE"  AND Imandor1 = "TRUE"   THEN nv_vatcode = ImVatCode.  /*TRUE + TRUE*/
        ELSE IF Imother2 = "FALSE" AND Imandor1 = "FALSE"  THEN nv_vatcode = "".         /*FALSE + FALSE*/
        ELSE nv_vatcode = "".*/
    END.
    ELSE IF nv_poltyp = "72" THEN DO:
        /** ���/���� Line 72 **/
        nv_name2 = "".
        IF      (Imandor3 = "FALSE" OR Imandor3 = "0") AND (Imandor2 = "TRUE"  OR Imandor2 = "1") THEN nv_name2 = "���/����" + " " + Imdealernam.
        ELSE IF (Imandor3 = "TRUE"  OR Imandor3 = "1") AND (Imandor2 = "FALSE" OR Imandor2 = "0") THEN nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
        ELSE IF (Imandor3 = "FALSE" OR Imandor3 = "0") AND (Imandor2 = "FALSE" OR Imandor2 = "0") THEN nv_name2 = " ".
        ELSE IF Imdealernam <> "" THEN nv_name2 = "���/����" + " " + Imdealernam.
        ELSE "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".

        /** Vat Code Line 72 **/
        nv_vatcode = "".
        IF (Imandor3 = "FALSE" OR Imandor3 = "0") AND (Imandor2 = "FALSE" OR Imandor2 = "0")  THEN nv_vatcode = "".
        ELSE nv_vatcode = ImVatCode.
        /*IF      Imandor3 = "FALSE" AND Imandor2 = "TRUE"   THEN nv_vatcode = ImVatCode.  /*FALSE + TRUE*/
        ELSE IF Imandor3 = "TRUE"  AND Imandor2 = "FLASE"  THEN nv_vatcode = ImVatCode.  /*TRUE + FALSE*/
        ELSE IF Imandor3 = "TRUE"  AND Imandor2 = "TRUE"   THEN nv_vatcode = ImVatCode.  /*TRUE + TRUE*/
        ELSE IF Imandor3 = "FALSE" AND Imandor2 = "FALSE"  THEN nv_vatcode = "".         /*FALSE + FALSE*/
        ELSE nv_vatcode = "".*/
    END.
    /*--- End Add A56-0250 ---*/

    /*----- Garage �٨ҡ��ͧ����ᴧ ------*/
    /*-- Comment A53-0111 Renew --
    IF TRIM(Imgarage1) = "TRUE" AND 
       TRIM(Imgarage2) = "FALSE" 
       THEN Imgarage1 = "G". 
       ELSE Imgarage1 = " ".
       ---*/
    IF TRIM(Imdetrge1) = "TRUE" OR TRIM(Imdetrge1) = "1" THEN Imgarage1 = "G". 
                                                         ELSE Imgarage1 = " ".

    /*----- vehuse ----*/
    IF TRIM(Imvehuse1) = "TRUE" OR TRIM(Imvehuse1) = "1" THEN ASSIGN Imothvehuse = "1"
                                                                     n_vehuse = "10". ELSE
        IF TRIM(Imvehuse2) = "TRUE" OR TRIM(Imvehuse2) = "1" THEN ASSIGN Imothvehuse = "2"
                                                                         n_vehuse = "20". ELSE
            IF TRIM(Imvehuse3) = "TRUE" OR TRIM(Imvehuse3) = "1" THEN ASSIGN Imothvehuse = "3"
                                                                             n_vehuse = "40". ELSE
                IF TRIM(Imvehuse4) = "TRUE" OR TRIM(Imvehuse4) = "1" THEN ASSIGN Imothvehuse = "4"
                                                                                 n_vehuse = "30". ELSE
                    IF TRIM(Imvehuse5) = "TRUE" OR TRIM(Imvehuse5) = "1" THEN ASSIGN Imothvehuse = "5"
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
    IF TRIM(Imbody1) = "TRUE" OR TRIM(Imbody1) = "1" THEN n_body = "1".
    IF TRIM(Imbody2) = "TRUE" OR TRIM(Imbody2) = "1" THEN n_body = "3".
    IF TRIM(Imbody3) = "TRUE" OR TRIM(Imbody3) = "1" THEN n_body = "2".
    IF TRIM(Imbody4) = "TRUE" OR TRIM(Imbody4) = "1" THEN n_body = "1".

    /*IF TRIM(n_body) = "3" AND TRIM(n_vehuse) = "10" THEN n_body = "1". /*Add A53-0111 Edit Vol.1*/*/
   
    IF TRIM(Imbody2) = "TRUE" OR TRIM(Imbody2) = "1" THEN Imcodecar = "320".
    ELSE Imcodecar = TRIM(n_body) + TRIM(n_vehuse). /*wdetail.subclass*/

    ASSIGN n_body = ""  n_vehuse = "".

    /*---- Address ----*/
    /*--- Add A55-0235 ---*/
    IF Imnfadd = "TRUE" OR Imnfadd = "1" THEN DO:
        FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
        IF AVAIL stat.Company THEN DO:
            ASSIGN Imiadd1  = stat.Company.Addr1
                   Imiadd2  = stat.Company.Addr2
                   Imiadd3  = stat.Company.Addr3
                   Imiadd4  = stat.Company.Addr4
                   Imbennam = stat.Company.NAME.
        END.
        ELSE DO:
            ASSIGN Imiadd1  = "900 �Ҥ�õ�ʹ ��������"
                   Imiadd2  = "�.��Թ�Ե �ǧ����Թ�"
                   Imiadd3  = "ࢵ�����ѹ ��ا෾� 10330"
                   Imbennam = "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
        END.
    END.
    ELSE DO:
        IF Iminadd = "TRUE" OR Iminadd = "1" THEN DO:
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
            ASSIGN Imiadd1  = "900 �Ҥ�õ�ʹ ��������"
                   Imiadd2  = "�.��Թ�Ե �ǧ����Թ�"
                   Imiadd3  = "ࢵ�����ѹ ��ا෾� 10330"
                   Imbennam = "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
        END.
        /*---
        ASSIGN Imiadd1 = "900 �Ҥ�õ�ʹ ��������"
               Imiadd2 = "�.��Թ�Ե �ǧ����Թ�"
               Imiadd3 = "ࢵ�����ѹ ��ا෾� 10330".
        ---*/       
    END.
    ----End Comment A55-0235 ----*/
    /*-- Add A53-0111 Edit Vol.1 ---*/
    IF Imiadd1 = "" AND Imiadd2 = "" AND Imiadd3 = "" THEN 
        ASSIGN Imiadd1  = "900 �Ҥ�õ�ʹ ��������"
               Imiadd2  = "�.��Թ�Ե �ǧ����Թ�"
               Imiadd3  = "ࢵ�����ѹ ��ا෾� 10330"
               Imbennam = "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
    /*--- End Add A53-0111 ---*/

    /*--- Name ---*/
    nv_tinam = "".
    IF Iminsnam <> "" THEN RUN PdChkName.

    /*----- vehreg ----*/
    nv_carpro = "".
    IF (Imdetrge1 <> "TRUE" OR Imdetrge1 <> "1") AND (Imdetrge1 = "FALSE" OR Imdetrge1 = "0") THEN DO:
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
            Imvehreg  = "/" + SUBSTRING(ImChasno,(LENGTH(ImChasno) - 9) + 1,LENGTH(ImChasno)). /*����ᴧ*/

    RUN PdChkDate.

    IF SUBSTRING(ImEngno,1,1) = "'" THEN ImEngno = SUBSTRING(ImEngno,2,LENGTH(ImEngno)).
                                    ELSE ImEngno = ImEngno.
    IF SUBSTRING(ImChasno,1,1) = "'" THEN ImChasno = SUBSTRING(ImChasno,2,LENGTH(ImChasno)).
                                     ELSE ImChasno = ImChasno.

    /*-- Check ICNO --*/
    IF SUBSTR(ImICNo,1,1) = "'" THEN DO: 
        ImICNo = SUBSTR(ImICNo,2,LENGTH(ImICNo)).
    END.
    
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

        /*--- Add A56-0250 ---*/
        /** ���/���� Line 72 **/
        nv_name2 = "".
        IF      (Imandor3 = "FALSE" OR Imandor3 = "0")  AND (Imandor2 = "TRUE"  OR Imandor2 = "1") THEN nv_name2 = "���/����" + " " + Imdealernam.
        ELSE IF (Imandor3 = "TRUE"  OR Imandor3 = "1")  AND (Imandor2 = "FALSE" OR Imandor2 = "0") THEN nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
        ELSE IF (Imandor3 = "FALSE" OR Imandor3 = "0")  AND (Imandor2 = "FALSE" OR Imandor2 = "0") THEN nv_name2 = " ".
        ELSE IF Imdealernam <> "" THEN nv_name2 = "���/����" + " " + Imdealernam.
        ELSE "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".

        /** Vat Code Line 72 **/
        nv_vatcode = "".
        IF (Imandor3 = "FALSE" OR Imandor3 = "0") AND (Imandor2 = "FALSE" OR Imandor2 = "0")  THEN nv_vatcode = "".
        ELSE nv_vatcode = ImVatCode.
        /*IF      Imandor3 = "FALSE" AND Imandor2 = "TRUE"   THEN nv_vatcode = ImVatCode.  /*FALSE + TRUE*/
        ELSE IF Imandor3 = "TRUE"  AND Imandor2 = "FLASE"  THEN nv_vatcode = ImVatCode.  /*TRUE + FALSE*/
        ELSE IF Imandor3 = "TRUE"  AND Imandor2 = "TRUE"   THEN nv_vatcode = ImVatCode.  /*TRUE + TRUE*/
        ELSE IF Imandor3 = "FALSE" AND Imandor2 = "FALSE"  THEN nv_vatcode = "".         /*FALSE + FALSE*/
        ELSE nv_vatcode = "".*/
        /*--- End Add A56-0250 ---*/

        RUN PdCreateNew.
    END.
    ELSE NEXT.
    /*--- End Add A54-0076 ---*/
    ......... end A60-0545......*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK_PDChkdata01 C-Win 
PROCEDURE BK_PDChkdata01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by : ranu A64-0278 30/06/2021....
DEF VAR nv_dname AS CHAR FORMAT "x(100)" INIT "" .
DO:
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
    /*nv_policy = nv_poltyp + Imidno.*/ /*a60-0545*/
    nv_policy = nv_poltyp + (substr(trim(Imcedpol),9,LENGTH(imcedpol))). /*a60-0545*/
    IF index(nv_policy,"-") <> 0 THEN nv_policy = REPLACE(nv_policy,"-","") . /*a60-0545*/

    /*---- vghgrp (drivnam) ---*/
    IF trim(Imvghgrp1) = "����к�" THEN nv_drivnam = "N" .
    ELSE nv_drivnam = "Y" .
    /*--- Add A56-0250 ---*/
    IF nv_poltyp = "70" THEN DO:
        /** ���/���� Line 70 **/
        nv_name2 = "".
        /*IF      INDEX(Imother1,"Dealer") <> 0  THEN nv_name2 = "���/����" + " " + Imdealernam.                  */ /*A64-0205*/
        /*ELSE IF INDEX(Imother1,"Tbank")  <> 0  THEN nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)". */ /*A64-0205*/

         /* add by : A64-0205 */
        ASSIGN nv_vatcode = ""   nv_dname = "" . 
        IF  INDEX(Imother1,"Dealer") <> 0  THEN DO: 

            nv_name2 = "���/����" + " " + Imdealernam. 

            IF INDEX(Imdealernam," ") <> 0 THEN nv_dname = REPLACE(Imdealernam," ","") .

            FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              (stat.insure.fNAME = Imdealernam  OR  
              stat.insure.fname  = nv_dname)    AND
              stat.insure.Addr3  = Imbancode    NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        ELSE IF INDEX(Imother1,"Tbank")  <> 0  THEN DO: 
            nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".

           FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              index(stat.insure.fNAME,"��Ҥ�ø��ҵ") <> 0   NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .

        END.
        /* end : A64-0205 */
        ELSE IF INDEX(Imother1,"�����") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".

       
    END.
    ELSE IF nv_poltyp = "72" THEN DO:
        /** ���/���� Line 72 **/
        nv_name2 = "".
        /*IF      INDEX(Imother2,"Dealer")  <> 0  THEN nv_name2 = "���/����" + " " + Imdealernam.                  */ /*A64-0205*/
        /*ELSE IF INDEX(Imother2,"Tbank")   <> 0  THEN nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)". */ /*A64-0205*/
         /* add by : A64-0205 */
        ASSIGN nv_vatcode = ""   nv_dname = "" . 
        IF  INDEX(Imother1,"Dealer") <> 0  THEN DO: 

            nv_name2 = "���/����" + " " + Imdealernam. 

            IF INDEX(Imdealernam," ") <> 0 THEN nv_dname = REPLACE(Imdealernam," ","") .

            FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              (stat.insure.fNAME = Imdealernam  OR  
              stat.insure.fname  = nv_dname)    AND
              stat.insure.Addr3  = Imbancode    NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        ELSE IF INDEX(Imother1,"Tbank")  <> 0  THEN DO: 
            nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".

           FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              index(stat.insure.fNAME,"��Ҥ�ø��ҵ") <> 0   NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        /* end : A64-0205 */
        ELSE IF INDEX(Imother2,"������") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".
    END.
    /*--- End Add A56-0250 ---*/

    /*----- Garage �٨ҡ��ͧ����ᴧ ------*/
    IF TRIM(Imdetrge1) = "����ᴧ" OR TRIM(Imdetrge1) = "New Car" THEN Imgarage1 = "G". 
    ELSE Imgarage1 = " ".

    /*----- vehuse ----*/
    IF      INDEX(Imvehuse1,"��ǹ�ؤ��")       <> 0 THEN ASSIGN Imothvehuse = "1"  n_vehuse = "10". 
    ELSE IF INDEX(Imvehuse1,"���͡�þҳԪ������") <> 0 THEN ASSIGN Imothvehuse = "3"  n_vehuse = "40". 
    ELSE IF INDEX(Imvehuse1,"���͡�þҳԪ��") <> 0 THEN ASSIGN Imothvehuse = "2"  n_vehuse = "20". 
    ELSE IF INDEX(Imvehuse1,"�Ѻ��ҧ�Ҹ�ó�")  <> 0 THEN ASSIGN Imothvehuse = "4"  n_vehuse = "30". 
    ELSE IF INDEX(Imvehuse1,"����")           <> 0 THEN ASSIGN Imothvehuse = "5"  n_vehuse = "10".

    /*---- Subclass ----*/
    n_body = "1".
    IF INDEX(Imbody1,"��")        <> 0  THEN n_body = "1".
    ELSE IF INDEX(Imbody1,"��к�")  <> 0  THEN n_body = "3".
    ELSE IF INDEX(Imbody1,"���")    <> 0  THEN n_body = "2".
    ELSE IF INDEX(imbody1,"��÷ء") <> 0  THEN n_body = "2".
    ELSE IF INDEX(Imbody1,"����")  <> 0  THEN n_body = "1".

    IF INDEX(Imbody1,"��к�") <> 0 THEN Imcodecar = "320".
    ELSE Imcodecar = TRIM(n_body) + TRIM(n_vehuse). /*wdetail.subclass*/

    ASSIGN n_body = ""  n_vehuse = "".

    /*---- Address ----*/
   /*IF trim(Imiadd1) = "" OR trim(Imiadd2) = "" THEN DO:*/ /*A63-0174*/
    IF trim(Imiadd1) <> "" AND trim(Imiadd2) <> "" THEN DO: /*A63-0174*/
    END.
    ELSE DO:
        IF TRIM(immadd1) = "" AND TRIM(immadd2) = ""  THEN DO: /*A63-0174 */
            FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
            IF AVAIL stat.Company THEN DO:
                ASSIGN Imiadd1  = stat.Company.Addr1
                       Imiadd2  = stat.Company.Addr2
                       Imiadd3  = stat.Company.Addr3
                       Imiadd4  = stat.Company.Addr4
                       Imbennam = stat.Company.NAME.
            END.
            ELSE DO:
                ASSIGN Imiadd1  = "444 �Ҥ��������ष�������"
                       Imiadd2  = "������� �ǧ�ѧ����"
                       Imiadd3  = "ࢵ�����ѹ  ��ا෾� 10330"
                       Imbennam = "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
            END.
        END.
        ELSE DO:
           /* add :  A63-0174*/
            ASSIGN Imiadd1  = TRIM(immadd1)
                   Imiadd2  = TRIM(immadd2)
                   Imiadd3  = TRIM(immadd3)
                   Imbennam = "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
           /* end A63-0174*/
        END.
    END.
    
    /*--- Name ---*/
    nv_tinam = "".
    IF Iminsnam <> "" THEN RUN PdChkName.

    /*----- vehreg ----*/
    nv_carpro = "".
    IF TRIM(Imdetrge1) <> "����ᴧ" AND TRIM(Imdetrge1) <> "New Car" THEN DO:
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
                            ELSE "/" + TRIM(ImChasno).  /*����ᴧ*/

    RUN PdChkDate.

    IF INDEX(ImEngno,"'")  <> 0  THEN ImEngno  = trim(REPLACE(ImEngno,"'","")).
    IF INDEX(ImChasno,"'") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"'","")).
    IF INDEX(ImChasno,"-") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"-","")).
    
    /*-- Check ICNO --*/
   IF INDEX(imICNo,"'") <> 0 THEN ImICNo = TRIM(REPLACE(ImICNo,"'","")).
   
    RUN PDCreateNew.

    IF  nv_poltyp = "70" AND Imstkno <> "" THEN DO:
        nv_poltyp = "72".
        /*nv_policy = nv_poltyp + Imidno.*/ /*A60-0545*/
        nv_policy = nv_poltyp + (substr(trim(Imcedpol),9,LENGTH(imcedpol))). /*a60-0545*/
        IF index(nv_policy,"-") <> 0 THEN nv_policy = REPLACE(nv_policy,"-","") . /*a60-0545*/

        /*--- Add A56-0250 ---*/
        /** ���/���� Line 72 **/
        nv_name2 = "".
        /*IF      INDEX(Imother2,"Dealer")  <> 0  THEN nv_name2 = "���/����" + " " + Imdealernam.                  */  /*A64-0205*/
        /*ELSE IF INDEX(Imother2,"Tbank")   <> 0  THEN nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)". */  /*A64-0205*/
         /* add by : A64-0205 */
        ASSIGN nv_vatcode = ""   nv_dname = "" . 
        IF  INDEX(Imother2,"Dealer") <> 0  THEN DO: 

            nv_name2 = "���/����" + " " + Imdealernam. 
            IF INDEX(Imdealernam," ") <> 0 THEN nv_dname = REPLACE(Imdealernam," ","") .

            FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              (stat.insure.fNAME = Imdealernam  OR  
              stat.insure.fname  = nv_dname)    AND
              stat.insure.Addr3  = Imbancode    NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        ELSE IF INDEX(Imother2,"Tbank")  <> 0  THEN DO: 
            nv_name2 = "���/����" + " " + "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".

           FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              index(stat.insure.fNAME,"��Ҥ�ø��ҵ") <> 0   NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        /* end : A64-0205 */
        ELSE IF INDEX(Imother2,"������") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".

        /** Vat Code Line 72 **/
      /*  nv_vatcode = "".
        IF (Imandor3 = "FALSE" OR Imandor3 = "0") AND (Imandor2 = "FALSE" OR Imandor2 = "0")  THEN nv_vatcode = "".
        ELSE nv_vatcode = ImVatCode.*/
     
        RUN PdCreateNew.
    END.
    ELSE NEXT.
    /*--- End Add A54-0076 ---*/
END.
..end ranu A64-0278 30/06/2021...*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE BK_PdImpNew C-Win 
PROCEDURE BK_PdImpNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*--
INPUT FROM VALUE (fiImpName).
    REPEAT:
        IMPORT DELIMITER ","
            /*1*/  Imidno        /*id*/
            /*2*/  Imtltdat      /*�ѹ����Ѻ��*/
            /*3*/  Imcomcod      /*Code ��Сѹ���*/
            /*4*/  Imstkno       /*�Ţʵ������*/
            /*5*/  Imstkno1      /*��ҧ���Ţ���ʵ������*/
            /*6*/  Imyrcomp      /*�ú ��*/
            /*7*/  Impolcomp     /*�� �ú �Ţ���*/
            /*8*/  Imcomnam      /*���ͻ�Сѹ���*/
            /*9*/  Imcedpol      /*�Ţ����Ѻ��*/
            /*10*/ Imbandet      /*��Ҵ�Ң�*/
            /*11*/ Imbancode     /*Code ��Ҵ�Ң�*/
            /*12*/ Imopnpol      /*�����*/
            /*13*/ Imcodgrp      /*�����*/
            /*14*/ Imtiname      /*����Ѻ��*/
            /*15*/ Iminsnam      /*���ͼ����һ�Сѹ���*/
            /*16*/ ImICNo        /*�Ţ����Шӵ��*/  /*A56-0250*/
            /*17*/ Imnfadd       /*������� NF*/
            /*18*/ Iminadd       /*��������١���*/
            /*19*/ Imdeadd       /*������� Dealer*/
            /*20*/ Imiadd1       /*�������մ·������*/
            /*21*/ Imiadd2       /*��������´������� 1*/
            /*22*/ Imiadd3       /*������*/
            /*23*/ Immadd1       /*����������͡���*/
            /*24*/ Immadd2       /*����������͡���1*/
            /*25*/ Immadd3       /*������1*/
            /*26*/ Imsi          /*�ع��Сѹ*/
            /*27*/ Imgrossi      /*ǧ�Թ������ͧ*/
            /*28*/ Imprem        /*���»�Сѹ�ط��*/
            /*29*/ Imnetprem     /*���»�Сѹ���*/
            /*30*/ Imcomp        /*���� �ú �ط��*/
            /*31*/ Imnetcomp     /*���� �ú ���*/
            /*32*/ Impremtot     /*���»�Сѹ + �ú*/
            /*33*/ Imbrand       /*������*/
            /*34*/ Immodel       /*���*/   
            /*35*/ Imyrmanu      /*��*/
            /*36*/ Imcarcol      /*��*/
            /*37*/ Imvehreg      /*�Ţ����¹*/
            /*38*/ Imcc          /*��Ҵ����ͧ¹��*/
            /*39*/ Imengno       /*�Ţ����ͧ¹��*/        
            /*40*/ Imchasno      /*�Ţ��Ƕѧ*/              
            /*41*/ Imother1      /*�����*/                 
            /*42*/ Imother2      /*TBank/TGL ��*/          
            /*43*/ Imother3      /*Dealer ���Թ����ͧ*/    
            /*44*/ Imandor1      /*Dealer ��*/             
            /*45*/ Imandor3      /*Tbank �� �ú.*/         
            /*46*/ Imother4      /*������*/  /*A55-0235*/  
            /*47*/ Imandor2      /*�ú Dealer*/
            /*48*/ Imother5      /*�ú �١���*/
            /*49*/ Imattrate     /*PATTREN RATE*/
            /*50*/ Imcarpri      /*�Ҥ�ö*/ 
            /*51*/ Imdealernam   /*���� Dealer*/
            /*52*/ Imsalenam     /*��� sale*/  /*������� Dealer Code */ 
            /*53*/ Imcovcod      /*��������û�Сѹ���*/
            /*54*/ Imvghgrp1     /*�кت���*/
            /*55*/ Imvghgrp2     /*����кت���*/
            /*56*/ Imdrivnam1    /*���� 1*/
            /*57*/ Imdrivbir1    /*�ѹ/��͹/���Դ1*/
            /*58*/ Imidno1       /*�Ţ��� ID 1*/
            /*59*/ Imlicen1      /*㺢Ѻ��� 1 �Ţ���*/
            /*60*/ Imdrivnam2    /*���� 2*/
            /*61*/ Imdrivbir2    /*�ѹ/��͹/���Դ2*/
            /*62*/ Imidno2       /*�Ţ��� ID 2*/
            /*63*/ Imlicen2      /*㺢Ѻ��� 2 �Ţ���*/
            /*64*/ Imcomdate     /*�ѹ��������ͧ*/
            /*65*/ Imexpdate     /*�ѹ����ش������ͧ*/
            /*66*/ Imvehuse1     /*��ǹ�ؤ��*/
            /*67*/ Imvehuse2     /*���͡�þҳԪ��*/
            /*68*/ Imvehuse3     /*���͡�þҳԪ������*/
            /*69*/ Imvehuse4     /*�Ѻ��ҧ�Ҹ�ó�*/
            /*70*/ Imvehuse5     /*����*/
            /*71*/ Imothvehuse   /*�����˵�����*/
            /*72*/ Imcodecar     /*����*/
            /*73*/ Imdetrge1     /*����ᴧ*/
            /*74*/ Imdetrge2     /*USED CAR*/
            /*75*/ Imbody1       /*��*/
            /*76*/ Imbody2       /*��к�*/
            /*77*/ Imbody3       /*���*/
            /*78*/ Imbody4       /*����*/
            /*79*/ Imothbody     /*������ö����*/
            /*80*/ Imgarage1     /*�����ҧ*/
            /*81*/ Imgarage2     /*��������*/
            /*82*/ Imcodereb     /*Code Rebate*/
            /*83*/ Imcomment     /*�����˵�*/ 
            /*84*/ Imseat        /*�ӹǹ�����*/ 
            /*85*/ ImVatCode     /*Vat Code*/     /*A56-0250*/
            /*86*/ ImFinint      /*Dealer Code*/  /*A56-0250*/
            /*87*/ ImRemark1     /*Remark 1*/     /*A56-0250*/
            /*88*/ ImRemark2.    /*Remark 2*/     /*A56-0250*/
    
        RUN PdChkData.
    END.
INPUT CLOSE.
---*/
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
  DISPLAY fi_vatcode fiImpName ra_data fiExpName 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE fi_vatcode fiImpName ra_data fiExpName butFile buok buexit RECT-379 
         RECT-380 RECT-381 RECT-382 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
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
    IF Imbancode <> "" THEN nv_choice = Imbancode.
    ELSE DO:
        IF LENGTH(Imcedpol) = 17 THEN nv_choice = SUBSTRING(Imcedpol,16,2). /*TBSTYN10-04311-21*/
        ELSE IF LENGTH(Imcedpol) = 18 THEN nv_choice = SUBSTRING(Imcedpol,17,2) . /*TBSTYN10-004311-21*/
    END.
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PDChkData C-Win 
PROCEDURE PDChkData :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Ranu A64-0278 30/06/2021      
------------------------------------------------------------------------------*/
DEF VAR nv_dname AS CHAR FORMAT "x(100)" INIT "" .
DO:
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
    /*nv_policy = nv_poltyp + Imidno.*/ /*a60-0545*/
    nv_policy = nv_poltyp + (substr(trim(Imcedpol),9,LENGTH(imcedpol))). /*a60-0545*/
    IF index(nv_policy,"-") <> 0 THEN nv_policy = REPLACE(nv_policy,"-","") . /*a60-0545*/

    /*---- vghgrp (drivnam) ---*/
    IF trim(Imvghgrp1) = "����к�" THEN nv_drivnam = "N" .
    ELSE nv_drivnam = "Y" .
    /*--- Add A56-0250 ---*/
    IF nv_poltyp = "70" THEN DO:
        /** ���/���� Line 70 **/
        nv_name2 = "".
        ASSIGN nv_vatcode = ""   nv_dname = "" . 
        IF (INDEX(Imother1,"Dealer") <> 0 OR INDEX(Imother1,"��������") <> 0 ) THEN DO: 
            nv_name2 = "���/����" + " " + Imdealernam. 
            IF INDEX(Imdealernam," ") <> 0 THEN nv_dname = REPLACE(Imdealernam," ","") .

            FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              (stat.insure.fNAME = Imdealernam  OR  
              stat.insure.fname  = nv_dname)    AND
              stat.insure.Addr3  = Imbancode    NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        ELSE IF (INDEX(Imother1,"Tbank")  <> 0  OR INDEX(Imother1,"TTB") <> 0 OR
                 INDEX(Imother1,"��Ҥ����") <> 0 ) THEN DO: 
            nv_name2 = "" .
            FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
                IF AVAIL stat.Company THEN DO:
                    ASSIGN nv_name2 = "���/����" + " " + stat.Company.NAME.
                END.

           FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              index(stat.insure.fNAME,"�����¸��ҵ") <> 0   NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        /* end : A64-0205 */
        ELSE IF INDEX(Imother1,"�����") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".
    END.
    ELSE IF nv_poltyp = "72" THEN DO:
        /** ���/���� Line 72 **/
        nv_name2 = "".
        ASSIGN nv_vatcode = ""   nv_dname = "" . 
        IF  (INDEX(Imother1,"Dealer") <> 0 OR INDEX(Imother1,"��������") <> 0 ) THEN DO: 
            nv_name2 = "���/����" + " " + Imdealernam. 
            IF INDEX(Imdealernam," ") <> 0 THEN nv_dname = REPLACE(Imdealernam," ","") .

            FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              (stat.insure.fNAME = Imdealernam  OR  
              stat.insure.fname  = nv_dname)    AND
              stat.insure.Addr3  = Imbancode    NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        ELSE IF (INDEX(Imother1,"Tbank")  <> 0  OR INDEX(Imother1,"TTB") <> 0 OR
                 INDEX(Imother1,"��Ҥ����") <> 0 ) THEN DO: 
            nv_name2 = "" .
            FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
                IF AVAIL stat.Company THEN DO:
                    ASSIGN nv_name2 = "���/����" + " " + stat.Company.NAME.
                END.

           FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              index(stat.insure.fNAME,"�����¸��ҵ") <> 0   NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        /* end : A64-0205 */
        ELSE IF INDEX(Imother2,"������") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".
    END.
    /*--- End Add A56-0250 ---*/

    /*----- Garage �٨ҡ��ͧ����ᴧ ------*/
    IF TRIM(Imdetrge1) = "����ᴧ" OR TRIM(Imdetrge1) = "New Car" THEN Imgarage1 = "G". 
    ELSE Imgarage1 = " ".

    /*----- vehuse ----*/
    IF      INDEX(Imvehuse1,"��ǹ�ؤ��")       <> 0 THEN ASSIGN Imothvehuse = "1"  n_vehuse = "10". 
    ELSE IF INDEX(Imvehuse1,"���͡�þҳԪ������") <> 0 THEN ASSIGN Imothvehuse = "3"  n_vehuse = "40". 
    ELSE IF INDEX(Imvehuse1,"���͡�þҳԪ��") <> 0 THEN ASSIGN Imothvehuse = "2"  n_vehuse = "20". 
    ELSE IF INDEX(Imvehuse1,"�Ѻ��ҧ�Ҹ�ó�")  <> 0 THEN ASSIGN Imothvehuse = "4"  n_vehuse = "30". 
    ELSE IF INDEX(Imvehuse1,"����")           <> 0 THEN ASSIGN Imothvehuse = "5"  n_vehuse = "10".

    /*---- Subclass ----*/
    n_body = "1".
    IF INDEX(Imbody1,"��")        <> 0  THEN n_body = "1".
    ELSE IF INDEX(Imbody1,"��к�")  <> 0  THEN n_body = "3".
    ELSE IF INDEX(Imbody1,"���")    <> 0  THEN n_body = "2".
    ELSE IF INDEX(imbody1,"��÷ء") <> 0  THEN n_body = "2".
    ELSE IF INDEX(Imbody1,"����")  <> 0  THEN n_body = "1".

    IF INDEX(Imbody1,"��к�") <> 0 THEN Imcodecar = "320".
    ELSE Imcodecar = TRIM(n_body) + TRIM(n_vehuse). /*wdetail.subclass*/

    ASSIGN n_body = ""  n_vehuse = "".

    /*---- Address ----*/
   /*IF trim(Imiadd1) = "" OR trim(Imiadd2) = "" THEN DO:*/ /*A63-0174*/
    IF trim(Imiadd1) <> "" AND trim(Imiadd2) <> "" THEN DO: /*A63-0174*/
    END.
    ELSE DO:
        IF TRIM(immadd1) = "" AND TRIM(immadd2) = ""  THEN DO: /*A63-0174 */
            FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
            IF AVAIL stat.Company THEN DO:
                ASSIGN Imiadd1  = stat.Company.Addr1
                       Imiadd2  = stat.Company.Addr2
                       Imiadd3  = stat.Company.Addr3
                       Imiadd4  = stat.Company.Addr4
                       Imbennam = stat.Company.NAME.
            END.
            ELSE DO:
                ASSIGN Imiadd1  = "900 �Ҥ�õ�ʹ ��������"
                       Imiadd2  = "�.��Թ�Ե �ǧ����Թ�"
                       Imiadd3  = "ࢵ�����ѹ ��ا෾� 10330"
                       Imbennam = "��Ҥ�÷����¸��ҵ �ӡѴ (��Ҫ�)".
            END.
        END.
        ELSE DO:
           /* add :  A63-0174*/
            ASSIGN Imiadd1  = TRIM(immadd1)
                   Imiadd2  = TRIM(immadd2)
                   Imiadd3  = TRIM(immadd3)
                   Imbennam = "��Ҥ�÷����¸��ҵ �ӡѴ (��Ҫ�)".
           /* end A63-0174*/
        END.
    END.
    
    /*--- Name ---*/
    nv_tinam = "".
    IF Iminsnam <> "" THEN RUN PdChkName.

    /*----- vehreg ----*/
    nv_carpro = "".
    IF TRIM(Imdetrge1) <> "����ᴧ" AND TRIM(Imdetrge1) <> "New Car" THEN DO:
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
                            ELSE "/" + TRIM(ImChasno).  /*����ᴧ*/

    RUN PdChkDate.

    IF INDEX(ImEngno,"'")  <> 0  THEN ImEngno  = trim(REPLACE(ImEngno,"'","")).
    IF INDEX(ImChasno,"'") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"'","")).
    IF INDEX(ImChasno,"-") <> 0  THEN ImChasno = trim(REPLACE(ImChasno,"-","")).
    
    /*-- Check ICNO --*/
   IF INDEX(imICNo,"'") <> 0 THEN ImICNo = TRIM(REPLACE(ImICNo,"'","")).
   
    RUN PDCreateNew.

    IF  nv_poltyp = "70" AND Imstkno <> "" THEN DO:
        nv_poltyp = "72".
        nv_policy = nv_poltyp + (substr(trim(Imcedpol),9,LENGTH(imcedpol))). /*a60-0545*/
        IF index(nv_policy,"-") <> 0 THEN nv_policy = REPLACE(nv_policy,"-","") . /*a60-0545*/
       
        /** ���/���� Line 72 **/
        nv_name2 = "".
        
         /* add by : A64-0205 */
        ASSIGN nv_vatcode = ""   nv_dname = "" . 
        IF  (INDEX(Imother2,"Dealer") <> 0 OR INDEX(Imother2,"��������") <> 0 ) THEN DO: 

            nv_name2 = "���/����" + " " + Imdealernam. 
            IF INDEX(Imdealernam," ") <> 0 THEN nv_dname = REPLACE(Imdealernam," ","") .

            FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              (stat.insure.fNAME = Imdealernam  OR  
              stat.insure.fname  = nv_dname)    AND
              stat.insure.Addr3  = Imbancode    NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        ELSE IF (INDEX(Imother2,"Tbank")  <> 0 OR INDEX(Imother2,"TTB")  <> 0 OR 
                 INDEX(Imother2,"��Ҥ����")  <> 0 ) THEN DO: 
            nv_name2 = "" .
            FIND FIRST stat.Company WHERE stat.Company.Compno = "NB" NO-LOCK NO-ERROR.
                IF AVAIL stat.Company THEN DO:
                    ASSIGN nv_name2 = "���/����" + " " + stat.Company.NAME.
                END.

            FIND LAST stat.insure USE-INDEX insure01 WHERE 
              stat.insure.comp   = fi_vatcode   AND 
              index(stat.insure.fNAME,"�����¸��ҵ") <> 0   NO-LOCK NO-ERROR.
                IF AVAIL stat.insure THEN ASSIGN nv_vatcode = stat.insure.vatcode .
                ELSE nv_vatcode = "" .
        END.
        /* end : A64-0205 */
        ELSE IF INDEX(Imother2,"������") <> 0  THEN nv_name2 = " ".
        ELSE nv_name2 = " ".

        /** Vat Code Line 72 **/
      /*  nv_vatcode = "".
        IF (Imandor3 = "FALSE" OR Imandor3 = "0") AND (Imandor2 = "FALSE" OR Imandor2 = "0")  THEN nv_vatcode = "".
        ELSE nv_vatcode = ImVatCode.*/
     
        RUN PdCreateNew.
    END.
    ELSE NEXT.
    /*--- End Add A54-0076 ---*/
END.

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
/*---- Add A54-0076 �ú.---*/
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
/*--- Driver Birth Date 1 ---*/
nv_year    = (YEAR(DATE(Imdrivbir1)) - 543).
nv_day     = DAY(DATE(Imdrivbir1)).
nv_month   = MONTH(DATE(Imdrivbir1)).
Imdrivbir1 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*--- Driver Birth Date 2 ---*/
nv_year    = (YEAR(DATE(Imdrivbir2)) - 543).
nv_day     = DAY(DATE(Imdrivbir2)).
nv_month   = MONTH(DATE(Imdrivbir2)).
Imdrivbir2 = STRING(nv_day,"99") + "/" + STRING(nv_month,"99") + "/" + STRING(nv_year,"9999").
/*--- �ѹ����Ѻ�� ---*/
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
/*--- 10 �ѡ�� ----
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

/*--- 8 ����ѡ�� ---*/
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
IF SUBSTRING(Iminsnam,1,6) = "�ҧ���" THEN DO:
    nv_tinam = SUBSTRING(Iminsnam,1,6).
    Iminsnam = TRIM(SUBSTRING(Iminsnam,7,60)).
END.
ELSE IF SUBSTRING(Iminsnam,1,4) = "Miss" OR
       SUBSTRING(Iminsnam,1,4) = "�.�." OR
       SUBSTRING(Iminsnam,1,4) = "���." OR
       SUBSTRING(Iminsnam,1,4) = "˨�." OR
       SUBSTRING(Iminsnam,1,4) = "Mrs." THEN DO:
        nv_tinam = SUBSTRING(Iminsnam,1,4).
        Iminsnam = TRIM(SUBSTRING(Iminsnam,5,60)).
    END. ELSE IF SUBSTRING(Iminsnam,1,3) = "�ҧ" OR
                 SUBSTRING(Iminsnam,1,3) = "���" OR
                 SUBSTRING(Iminsnam,1,3) = "�س" OR
                 SUBSTRING(Iminsnam,1,3) = "��." OR
                 SUBSTRING(Iminsnam,1,3) = "���" OR
                 SUBSTRING(Iminsnam,1,3) = "˨�" OR
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
    IF Imcomnam <> "��Сѹ�������" THEN nv_oldpol = "".
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
/*1*/   IF nv_vehreg = "��к��"          THEN nv_vehreg = "��".
/*2*/   IF nv_vehreg = "��ا෾��ҹ��" OR INDEX(nv_vehreg,"��ا෾") <> 0 THEN nv_vehreg = "��".
/*3*/   IF nv_vehreg = "�ҭ������"       THEN nv_vehreg = "��".
/*4*/   IF nv_vehreg = "����Թ���"       THEN nv_vehreg = "��".
/*5*/   IF nv_vehreg = "��ᾧྪ�"       THEN nv_vehreg = "��".
/*6*/   IF nv_vehreg = "�͹��"         THEN nv_vehreg = "��".
/*7*/   IF nv_vehreg = "�ѹ�����"        THEN nv_vehreg = "��".
/*8*/   IF nv_vehreg = "���ԧ���"      THEN nv_vehreg = "��".
/*9*/   IF nv_vehreg = "�ź���"          THEN nv_vehreg = "��".
/*10*/  IF nv_vehreg = "��¹ҷ"          THEN nv_vehreg = "��".
/*11*/  IF nv_vehreg = "�������"         THEN nv_vehreg = "��".
/*12*/  IF nv_vehreg = "�����"           THEN nv_vehreg = "��".
/*13*/  IF nv_vehreg = "��§���"        THEN nv_vehreg = "��".
/*14*/  IF nv_vehreg = "��§����"       THEN nv_vehreg = "��".
/*15*/  IF nv_vehreg = "��ѧ"            THEN nv_vehreg = "��".
/*16*/  IF nv_vehreg = "��Ҵ"            THEN nv_vehreg = "��".
/*17*/  IF nv_vehreg = "�ҡ"             THEN nv_vehreg = "��".
/*18*/  IF nv_vehreg = "��ù�¡"         THEN nv_vehreg = "��".
/*19*/  IF nv_vehreg = "��û��"          THEN nv_vehreg = "��".
/*20*/  IF nv_vehreg = "��þ��"          THEN nv_vehreg = "��".
/*21*/  IF nv_vehreg = "����Ҫ����"      THEN nv_vehreg = "��".
/*22*/  IF nv_vehreg = "�����ո����Ҫ"   THEN nv_vehreg = "��".
/*23*/  IF nv_vehreg = "������ä�"       THEN nv_vehreg = "��".
/*24*/  IF nv_vehreg = "�������"         THEN nv_vehreg = "��".
/*25*/  IF nv_vehreg = "��Ҹ���"         THEN nv_vehreg = "��".
/*26*/  IF nv_vehreg = "��ҹ"            THEN nv_vehreg = "��".
/*27*/  IF nv_vehreg = "���������"       THEN nv_vehreg = "��".
/*28*/  IF nv_vehreg = "�����ҹ�"        THEN nv_vehreg = "��".
/*29*/  IF nv_vehreg = "��ШǺ���բѹ��" THEN nv_vehreg = "��".
/*30*/  IF nv_vehreg = "��Ҩչ����"      THEN nv_vehreg = "��".
/*31*/  IF nv_vehreg = "�ѵ�ҹ�"         THEN nv_vehreg = "��".
/*32*/  IF nv_vehreg = "��й�������ظ��" OR nv_vehreg = "��ظ��" THEN nv_vehreg = "��".
/*33*/  IF nv_vehreg = "�����"           THEN nv_vehreg = "��".
/*34*/  IF nv_vehreg = "�ѧ��"           THEN nv_vehreg = "��".
/*35*/  IF nv_vehreg = "�ѷ�ا"          THEN nv_vehreg = "��".
/*36*/  IF nv_vehreg = "�ԨԵ�"          THEN nv_vehreg = "��".
/*37*/  IF nv_vehreg = "��ɳ��š"        THEN nv_vehreg = "��".
/*38*/  IF nv_vehreg = "ྪú���"        THEN nv_vehreg = "��".
/*39*/  IF nv_vehreg = "ྪú�ó�"       THEN nv_vehreg = "��".
/*40*/  IF nv_vehreg = "���"            THEN nv_vehreg = "��".
/*41*/  IF nv_vehreg = "����"          THEN nv_vehreg = "��".
/*42*/  IF nv_vehreg = "�����ä��"       THEN nv_vehreg = "��".
/*43*/  IF nv_vehreg = "�ء�����"        THEN nv_vehreg = "��".
/*44*/  IF nv_vehreg = "�����ͧ�͹"      THEN nv_vehreg = "��".
/*45*/  IF nv_vehreg = "����"            THEN nv_vehreg = "��".
/*46*/  IF nv_vehreg = "�������"        THEN nv_vehreg = "��".
/*47*/  IF nv_vehreg = "�йͧ"           THEN nv_vehreg = "ù".
/*48*/  IF nv_vehreg = "���ͧ"           THEN nv_vehreg = "��".
/*49*/  IF nv_vehreg = "�Ҫ����"         THEN nv_vehreg = "ú".
/*50*/  IF nv_vehreg = "ž����"          THEN nv_vehreg = "ź".
/*51*/  IF nv_vehreg = "�ӻҧ"           THEN nv_vehreg = "Ż".
/*52*/  IF nv_vehreg = "�Ӿٹ"           THEN nv_vehreg = "ž".
/*53*/  IF nv_vehreg = "���"             THEN nv_vehreg = "��".
/*54*/  IF nv_vehreg = "�������"        THEN nv_vehreg = "ȡ".
/*55*/  IF nv_vehreg = "ʡŹ��"          THEN nv_vehreg = "ʹ".
/*56*/  IF nv_vehreg = "ʧ���"           THEN nv_vehreg = "ʢ".
/*57*/  IF nv_vehreg = "������"         THEN nv_vehreg = "ʡ".
/*58*/  IF nv_vehreg = "��к���"         THEN nv_vehreg = "ʺ".
/*59*/  IF nv_vehreg = "�ԧ�����"       THEN nv_vehreg = "��".
/*60*/  IF nv_vehreg = "��⢷��"         THEN nv_vehreg = "ʷ".
/*61*/  IF nv_vehreg = "�ؾ�ó����"      THEN nv_vehreg = "ʾ".
/*62*/  IF nv_vehreg = "����ɮ��ҹ�" OR INDEX(nv_vehreg,"�����") <> 0 THEN nv_vehreg = "ʮ".
/*63*/  IF nv_vehreg = "���Թ���"        THEN nv_vehreg = "��".
/*64*/  IF nv_vehreg = "˹ͧ���"         THEN nv_vehreg = "��".
/*65*/  IF nv_vehreg = "˹ͧ����Ӿ�"     THEN nv_vehreg = "��".
/*66*/  IF nv_vehreg = "��ҧ�ͧ"         THEN nv_vehreg = "ͷ".
/*67*/  IF nv_vehreg = "�ӹҨ��ԭ"      THEN nv_vehreg = "ͨ".
/*68*/  IF nv_vehreg = "�شøҹ�"        THEN nv_vehreg = "ʹ".
/*69*/  IF nv_vehreg = "�صôԵ��"       THEN nv_vehreg = "͵".
/*70*/  IF nv_vehreg = "�ط�¸ҹ�"       THEN nv_vehreg = "ͷ".
/*71*/  IF nv_vehreg = "�غ��Ҫ�ҹ�"     THEN nv_vehreg = "ͺ".
/*72*/  IF nv_vehreg = "��ʸ�"           THEN nv_vehreg = "��".
/*73*/  IF nv_vehreg = "ʵ��"            THEN nv_vehreg = "ʵ".
/*74*/  IF nv_vehreg = "��طû�ҡ��"     THEN nv_vehreg = "ʻ".
/*75*/  IF nv_vehreg = "��ط�ʧ����"     THEN nv_vehreg = "��".
/*76*/  IF nv_vehreg = "��ط��Ҥ�"       THEN nv_vehreg = "ʤ".
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
DEFINE VAR nv_model  AS CHAR FORMAT "X(20)".
DEFINE VAR nv_model1 AS CHAR FORMAT "X(20)".

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
           wImport.Body    = stat.maktab_fil.body
           wImport.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
   END.
   ELSE DO:
       ASSIGN
           wImport.Redbook = ""
           wImport.Weight  = ""
           wImport.Seat    = "7"
           wImport.Body    = ""
           wImport.Vehgrp  = "".  /*A59-0070*/
   END.  
END.

IF wImport.Redbook = "" THEN DO:
    nv_model  = SUBSTR(Immodel,1,INDEX(Immodel," ")).
    nv_model1 = TRIM(SUBSTR(Immodel,LENGTH(nv_model) + 1,LENGTH(Immodel))).
    nv_model1 = SUBSTR(nv_model1,1,INDEX(nv_model1," ")).

    IF TRIM(nv_model) = "HILUX" THEN nv_model = TRIM(nv_model) + " " + TRIM(nv_model1).
    IF INDEX(Immodel,"D-MAX") <> 0 THEN nv_model = "D-MAX".
    IF INDEX(Immodel,"YARIS") <> 0 THEN nv_model = "YARIS".

    FOR EACH stat.maktab_fil WHERE
               stat.maktab_fil.makdes = wImport.brand      AND
         INDEX(stat.maktab_fil.moddes,TRIM(nv_model)) <> 0 AND
               stat.maktab_fil.makyea = INTEGER(wImport.yrmanu) AND
              (stat.maktab_fil.engine = INTEGER(wImport.cc)     OR 
               stat.maktab_fil.engine > INTEGER(wImport.cc))    AND
               stat.maktab_fil.sclass = wImport.CLASS AND
              (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(Imsi) AND
               stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(Imsi)) NO-LOCK:

        ASSIGN
           wImport.Redbook = stat.maktab_fil.modcod
           wImport.Weight  = STRING(stat.maktab_fil.tons)
           wImport.Seat    = STRING(stat.maktab_fil.seats)
           wImport.Body    = stat.maktab_fil.body
           wImport.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/

    END.

    IF wImport.Redbook = "" THEN DO:
        FOR EACH stat.maktab_fil WHERE
                   stat.maktab_fil.makdes = wImport.brand      AND
             INDEX(stat.maktab_fil.moddes,TRIM(nv_model1)) <> 0 AND
                   stat.maktab_fil.makyea = INTEGER(wImport.yrmanu) AND
                  (stat.maktab_fil.engine = INTEGER(wImport.cc)     OR 
                   stat.maktab_fil.engine > INTEGER(wImport.cc))    AND
                   stat.maktab_fil.sclass = wImport.CLASS AND
                  (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100) LE INTE(Imsi) AND
                   stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100) GE INTE(Imsi)) NO-LOCK:

            ASSIGN
               wImport.Redbook = stat.maktab_fil.modcod
               wImport.Weight  = STRING(stat.maktab_fil.tons)
               wImport.Seat    = STRING(stat.maktab_fil.seats)
               wImport.Body    = stat.maktab_fil.body
               wImport.Vehgrp  = stat.maktab_fil.prmpac.  /*A59-0070*/
        END.
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
/*--- ���Ţ����¹ö ---*/
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
IF TRIM(Imgarage1) = "������ҧ" THEN Imgarage1 = "G". 
                                ELSE Imgarage1 = " ".

/*--- Add A54-0076 ---*/
nv_poltyp = "".
/*IF Imsi = "0" AND Imnetprem = 0 THEN nv_poltyp = "72".*/ /*A60*0545*/
IF Imsi = "0" AND deci(Imnetprem) = 0 THEN nv_poltyp = "72". /*A60*0545*/
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

/*---- �кؼ��Ѻ��� ---*/
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
        /* comment by : A64-0278 ..
         ASSIGN 
                   Imiadd1 = SUBSTRING(Imaddr,1,35)
                   Imiadd2 = SUBSTRING(Imaddr,36,35)
                   Imiadd3 = SUBSTRING(Imaddr,71,LENGTH(Imaddr)).
        ..end A64-0278..*/ 
        /* add by : A64-0278 */
        IF LENGTH(imaddr) > 35 THEN DO:
           IF r-INDEX(imaddr,"���") <> 0  THEN DO:
               ASSIGN Imiadd4 = SUBSTR(imaddr,r-INDEX(imaddr,"���"))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"���") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"��ا෾") <> 0  THEN DO:
               ASSIGN Imiadd4 = SUBSTR(imaddr,r-INDEX(imaddr,"��ا෾"))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"��ا෾") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"�.") <> 0  THEN DO:
               ASSIGN Imiadd4 = SUBSTR(imaddr,r-INDEX(imaddr,"�."))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"�.") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"�ѧ��Ѵ") <> 0  THEN DO:
               ASSIGN Imiadd4 = SUBSTR(imaddr,r-INDEX(imaddr,"�ѧ��Ѵ"))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"�ѧ��Ѵ") - 1 ).
           END.
           /*Amper */
           IF r-INDEX(imaddr,"�.") <> 0  THEN DO:
               ASSIGN Imiadd3   = SUBSTR(imaddr,r-INDEX(imaddr,"�."))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"�.") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"��������") <> 0  THEN DO:
               ASSIGN Imiadd3 = SUBSTR(imaddr,r-INDEX(imaddr,"��������"))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"��������") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"�����") <> 0  THEN DO:
               ASSIGN Imiadd3 = SUBSTR(imaddr,r-INDEX(imaddr,"�����"))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"�����") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"ࢵ") <> 0  THEN DO:
               ASSIGN Imiadd3 = SUBSTR(imaddr,r-INDEX(imaddr,"ࢵ"))
                   imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"ࢵ") - 1 ).
           END.
           /*tambon*/
           IF r-INDEX(imaddr,"�.") <> 0  THEN DO:
               ASSIGN Imiadd2   = SUBSTR(imaddr,r-INDEX(imaddr,"�."))
                   imaddr   = SUBSTR(imaddr,1,r-INDEX(imaddr,"�.") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"�Ӻ�") <> 0  THEN DO:
               ASSIGN Imiadd2 = SUBSTR(imaddr,r-INDEX(imaddr,"�Ӻ�"))
                      imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"�Ӻ�") - 1 ).
           END.
           ELSE IF r-INDEX(imaddr,"�ǧ") <> 0  THEN DO:
               ASSIGN Imiadd2 = SUBSTR(imaddr,r-INDEX(imaddr,"�ǧ"))
                      imaddr  = SUBSTR(imaddr,1,r-INDEX(imaddr,"�ǧ") - 1 ).
           END.
           ASSIGN  Imiadd1 = TRIM(Imaddr) .
        END.
        ELSE DO:
            ASSIGN Imiadd1 = trim(Imaddr)
                   Imiadd2 = ""
                   Imiadd3 = "" .
        END.
        /* end A64-0278*/
    END.
    /*---
    IF Imbennam = "NB" THEN
        ASSIGN Imiadd1 = "900 �Ҥ�õ�ʹ��������"
               Imiadd2 = "�.��Թ�Ե �ǧ����Թ�"
               Imiadd3 = "ࢵ�����ѹ ��ا෾ 10330"
               Imbennam = "��Ҥ�� ���ҵ �ӡѴ (��Ҫ�)".
    ELSE IF Imbennam = "NF" THEN
        ASSIGN Imiadd1 = "���10-12,12�� �Ҥ��������� ��������"
               Imiadd2 = "440 �.���� �ǧ�ѧ����"
               Imiadd3 = "ࢵ�����ѹ ��ا෾� 10330"
               Imbennam = "����ѷ �ع���ҵ �ӡѴ (��Ҫ�)".
    ELSE IF Imbennam = "NGL" THEN 
        ASSIGN Imiadd1 = "444 �Ҥ��������� �������� ��� 11"
               Imiadd2 = "�.���� �ǧ�ѧ����"
               Imiadd3 = "ࢵ�����ѹ ��ا෾� 10330"
               Imbennam = "����ѷ ���ҵ���� ��ʫ�� �ӡѴ".
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
    /*-- Comment A59-0070 --*/
    IF Imcovcod = "3" AND nv_oldpol = ""  THEN Imbranch = "M".
                      ELSE RUN PDChkBranch.
    /*--- End Comment A59-0070 --*/  

   /* RUN PDChkBranch. */ /*A59-0070 ����ա��������������ҵ�� Parameter ����Ţ�Ѻ��*/
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
            WHEN "��" THEN           
            DO: 
               Imcodecar = "110".
               Imothvehuse = "1".
            END.         
            WHEN "�� 2 �͹" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "����ͧ�͹���º�÷ء" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "����ͧ��ǹ�ؤ��" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "����ͧ�͹�ǹ" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "�������͹" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "�ؤ�� (�� 1)" THEN
            DO:
                Imcodecar = "110".
                Imothvehuse = "1".
            END.
            WHEN "�кк�÷ء" THEN
            DO:
                Imcodecar = "320".
                Imothvehuse = "3".
            END.
            WHEN "��÷ء��ǹ�ؤ�� (�� 3)" THEN
            DO:
                Imcodecar = "320".
                Imothvehuse = "3".
            END.
            WHEN "����� 4 �͹" THEN
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
        ELSE ASSIGN nv_prempa = "R"   ImbenNam  = "". /*--- �ҹ������بҡ�����蹤�����ͧ 3 ����� BenName --*/
    END.
END.
/*---- End Add A54-0076 ----*/
/*---- Comment A54-0076 ���ͧ�ҡ �繡�����������������ҡ����������֧�ҡ Expiry ---
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
        Imbandet  = "����ѷ��Сѹ������ : " + Imcomnam + " " + "�Ţ��� : " + Imrenpol. 
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

/*IF nv_poltyp = "70"  AND Imstkno <> "" THEN DO:*/ /*A59-0471 */
IF nv_poltyp = "70"  AND deci(Imnetcomp) <> 0 THEN DO: /*A59-0471*/
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
/*-- ���ͼ����һ�Сѹ --*/
IF wImport.Insnam /*Iminsnam*/ = "" THEN DO:
    ASSIGN wImport.comment = "| ���ͼ����һ�Сѹ�繤����ҧ " 
           wImport.pass    = "N".
END.
/*-- �Ţ����Ѻ�� --
IF Imtltno = "" THEN DO:
    ASSIGN wImport.comment =  "| �Ţ����Ѻ���繤����ҧ ��سҵ�Ǩ�ͺ������ " 
           wImport.pass    =  "N".
END.
---*/
/*-- �ѹ��������������ͧ/�ѹ�������ش����������ͧ --*/
IF wImport.Comdat /*Imcomdate*/ = "" OR wImport.Expdat /*Imexpdate*/ = "" THEN DO:
    ASSIGN wImport.comment = "| �ѹ��������������ͧ/�ѹ�������ش����������ͧ�繤����ҧ " 
           wImport.pass    = "N".
END.
/*-- �ع��Сѹ��� --
IF /*Imsi*/ wImport.si = "0" OR /*Imsi*/ wImport.si = "" THEN DO:
    ASSIGN wImport.comment = "| �ع��Сѹ������ٹ�� "
           wImport.pass    = "N".
END.*/
/*-- ������ö --*/
IF /*Imbrand*/ wImport.Brand = "" THEN DO:
    ASSIGN wImport.comment = "| ������ö�繤����ҧ "
           wImport.pass    = "N".
END.
/*-- ���ö ---*/
IF /*Immodel*/ wImport.Model = "" THEN DO:
    ASSIGN wImport.comment = "| ���ö�繤����ҧ "
           wImport.pass    = "N".
END.
/*-- �շ���Ե --*/
IF /*Imyrmanu*/ wImport.yrmanu = "" THEN DO:
    ASSIGN wImport.comment = "| �շ���Ե�繤����ҧ "
           wImport.pass    = "N".
END.
/*-- CC --*/
IF /*Imcc*/ wImport.CC = "" THEN DO:
    ASSIGN wImport.comment = "| CC �繤����ҧ " 
           wImport.pass    = "N".
END.
/*-- �Ţ����ͧ --*/
IF /*Imengno*/ wImport.Engno = "" THEN DO:
    ASSIGN wImport.comment = "| �Ţ����ͧ¹���繤����ҧ " 
           wImport.pass    = "N" .
END.
/*-- �Ţ��Ƕѧ --*/
IF /*ImChasno*/ wImport.Chano = "" THEN DO:
    ASSIGN wImport.comment = "| �Ţ��Ƕѧ�繤����ҧ " 
           wImport.pass    = "N".
END.
/*-- Driver Name ---*/
IF wImport.drivnam = "Y" THEN DO:
    IF (wImport.drivnam1 = "" AND wImport.drivbir1 = "") THEN
        ASSIGN wImport.comment = "| ���ͼ��Ѻ�������ѹ�Դ�繤����ҧ " 
               wImport.pass    = "N".
END.
/*-- �ӹ�˹�Ҫ��� --*/
IF wImport.Tiname = "" THEN DO:
    ASSIGN wImport.comment = "| �ӹ�˹�Ҫ����繤����ҧ ��سҵ�Ǩ�ͺ��������ӹ�˹�Ҫ���"
           wImport.pass    = "N".
END.
/*-- Branch --*/
IF wImport.Branch = "" THEN DO:
    ASSIGN wImport.comment = "| Branch �繤����ҧ ��سҵ�Ǩ�ͺ Branch"
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
            wImport.Poltyp    =  trim(nv_poltyp)    
            wImport.Policy    =  trim(nv_policy) 
            wImport.CedPol    =  trim(Imcedpol) 
            wImport.Renpol    =  ""  
            wImport.Compol    =  IF Imstkno <> "" THEN "Y" ELSE "N"  
            wImport.Comdat    =  trim(Imcomdate)  
            wImport.Expdat    =  trim(ImExpdate)  
            wImport.Tiname    =  trim(nv_tinam) 
            wImport.Insnam    =  trim(ImInsnam) 
            wImport.name2     =  trim(nv_name2)
            wimport.name3     =  TRIM(imname2)  /*a60-0545*/
            wImport.iaddr1    =  trim(Imiadd1) 
            wImport.iaddr2    =  trim(Imiadd2) 
            wImport.iaddr3    =  trim(Imiadd3) 
            wImport.iaddr4    =  trim(Imiadd4) 
            wImport.Prempa    =  ""
            wImport.class     =  TRIM(Imcodecar)  
            wImport.Brand     =  TRIM(ImBrand)  
            wImport.Model     =  TRIM(ImModel)  
            wImport.CC        =  TRIM(Imcc)  
            wImport.Weight    =  ""  
            wImport.Seat      =  TRIM(ImSeat)  
            wImport.Body      =  ""
            /*wImport.Vehreg    =  TRIM(Imvehreg) */ /*a60-0545*/
            wImport.Vehreg    =  IF TRIM(Imvehreg) = "" THEN "/" + SUBSTR(ImChasno,(LENGTH(ImChasno) - 9) + 1,LENGTH(ImChasno)) ELSE TRIM(Imvehreg)  /*a60-0545*/
            wImport.CarPro    =  TRIM(nv_carpro)
            wImport.Engno     =  TRIM(ImEngno) 
            wImport.Chano     =  TRIM(ImChasno) 
            wImport.yrmanu    =  TRIM(Imyrmanu) 
            wImport.Vehuse    =  TRIM(Imothvehuse) 
            wImport.garage    =  trim(Imgarage1)
            wImport.stkno     =  TRIM(Imstkno) 
            wImport.covcod    =  TRIM(Imcovcod) 
            wImport.si        =  TRIM(Imsi) 
            /*wImport.Prem_t    =  ImPrem  /*ImNetPrem */ */ /*A60-0545*/
            /*wImport.Prem_c    =  Imcomp  /*ImNetComp*/  */ /*A60-0545*/
            /*wImport.Prem_r    =  ImPremtot              */ /*A60-0545*/
            wImport.Prem_t    =  deci(ImPrem)       /*A60-0545*/
            wImport.Prem_c    =  deci(Imcomp)       /*A60-0545*/
            wImport.Prem_r    =  deci(ImPremtot)    /*A60-0545*/
            wImport.Bennam    =  TRIM(Imbennam)
            wImport.drivnam   =  TRIM(nv_drivnam) 
            wImport.drivnam1  =  TRIM(Imdrivnam1) 
            wImport.drivbir1  =  TRIM(Imdrivbir1) 
            wImport.drivic1   =  TRIM(Imidno1)    /*A60*0545*/
            wImport.drivid1   =  TRIM(Imlicen1)   /*A60*0545*/
            wImport.drivage1  =  ""  
            wImport.drivnam2  =  TRIM(Imdrivnam2)  
            wImport.drivbir2  =  TRIM(Imdrivbir2)
            wImport.drivic2   =  TRIM(Imidno2)   /*A60*0545*/   
            wImport.drivid2   =  TRIM(Imlicen2)  /*A60*0545*/   
            wImport.drivage2  =  ""  
            wImport.Redbook   =  ""  
            wImport.opnpol    =  TRIM(Imopnpol)  
            wImport.bandet    =  TRIM(Imbandet)  
            wImport.tltdat    =  TRIM(Imtltdat)  
            wImport.attrate   =  TRIM(Imattrate)
            wImport.branch    =  TRIM(Imbranch)
            /*wImport.vatcode   =  Imcomment*/    
            wImport.vatcode   =  TRIM(nv_vatcode) /*A56-0250*/
            /*wImport.Text1     =  Immadd1*/      /*A56-0250*/
            wImport.Text1     =  TRIM(Imcomment)  
            wImport.Text2     =  TRIM(ImRemark1)  
            /*wImport.finit     =  Imsalenam*/    
            wImport.finit     =  TRIM(ImFinint)   /*A56-0250*/
            wImport.icno      =  TRIM(ImICno)     /*A55-0235*/
            wImport.Rebate    =  TRIM(Imcodereb)  /*A55-0235*/ 
            wImport.ncolor    =  trim(Imcarcol).  /*A66-0160*/
        /*--- Check Package ---*/
        IF wImport.Prempa = " " THEN DO:
            /* comment by Ranu I. A60-0545 .......
             IF SUBSTRING(wImport.CedPol,6,1) = "U" THEN wImport.Prempa = "G".
             ELSE IF wImport.Brand = "TOYOTA" THEN wImport.Prempa = "X".
             ELSE IF wImport.Brand = "ISUZU" THEN wImport.Prempa = "V".
             ELSE wImport.Prempa = "Z".
             ......end A60-0545..*/
            /* comment by A63-0174 ...
            /* create by A60-0545 */
             IF SUBSTRING(wImport.CedPol,6,1) = "U" THEN DO:
                 ASSIGN wImport.Prempa = "G"
                        wImport.garage = "".
             END.
             ELSE IF wImport.Brand = "FORD" THEN wImport.Prempa = "F".
             ELSE wImport.Prempa = "Z".
            /* end A60-0545 */
            ... end a63-0174 */
            ASSIGN wimport.prempa = "T" . /*A63-0174*/
        END.
        FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
                  brstat.tlt.cha_no       = trim(wImport.Chano)  AND 
                  brstat.tlt.eng_no       = TRIM(wImport.Engno)  AND 
                  brstat.tlt.genusr       = "THANACHAT"          AND 
                  brstat.tlt.nor_noti_tlt = TRIM(wImport.CedPol) AND 
                  brstat.tlt.flag         = "N"                  AND 
                  brstat.tlt.subins       = "V" + wImport.Poltyp       NO-ERROR NO-WAIT .
            IF AVAIL brstat.tlt THEN DO:
                    ASSIGN  wimport.producer =  brstat.tlt.comp_sub      
                            wimport.agent    =  brstat.tlt.comp_noti_ins .
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
FIND LAST wImport WHERE wImport.policy = nv_policy NO-ERROR NO-WAIT.
IF NOT AVAIL wImport THEN DO:
    CREATE wImport.
    ASSIGN               
       wImport.Poltyp    =  nv_poltyp /*IF Imstkno <> "" AND ImNetPrem = 0 THEN "72" ELSE "70"*/ /*A54-0079*/    
       wImport.Policy    =  nv_policy /*nv_policy + "NB"*//*A54-0076*/
       wImport.CedPol    =  Imcedpol   
       wImport.Renpol    =  nv_oldpol  
       /*wImport.Compol    =  IF Imstkno <> "" THEN "Y" ELSE "N" */ /*A59-0471 */
       wImport.Compol    =  IF deci(Imnetcomp) <> 0 THEN "Y" ELSE "N"  /*A59-0471 */
       wImport.Comdat    =  IF nv_poltyp = "70" THEN Imcomdate ELSE Imcomdat1 /*A54-0076 ��ҧ�� comdate �������͹ 70*/ 
       wImport.Expdat    =  IF nv_poltyp = "70" THEN Imexpdate ELSE Imexpdat1 /*A54-0076 ��ҧ�� expdate �������͹ 70*/ 
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

       FIND LAST brstat.tlt USE-INDEX tlt06  WHERE        
           brstat.tlt.cha_no       = trim(wImport.Chano)  AND 
           brstat.tlt.eng_no       = TRIM(wImport.Engno)  AND 
           brstat.tlt.genusr       = "THANACHAT"          AND 
           brstat.tlt.safe2        = TRIM(wImport.CedPol) AND 
           brstat.tlt.flag         = "R"                  AND 
           brstat.tlt.subins       = "V" + wImport.Poltyp        NO-ERROR NO-WAIT .
       IF AVAIL brstat.tlt THEN DO:
          ASSIGN  wimport.producer =  brstat.tlt.comp_sub      
                  wimport.agent    =  brstat.tlt.comp_noti_ins .
       END.
      
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
    /* create by Ranu I. A60-0545 */
        EXPORT DELIMITER "|"
            "Type of Policy"     
            "�Ţ����������"     
            "�Ţ����ѭ��"     
            "�Ţ��������������"     
            "Compulsory"     
            "�ѹ��������������ͧ"     
            "�ѹ�������ش����������ͧ"     
            "�ӹ�˹�Ҫ���"     
            "���ͼ����һ�Сѹ"     
            "���/����"      
            "������� 1"     
            "������� 2"     
            "������� 3"     
            "������� 4"     
            "Pack"     
            "Class"      
            "Brand"      
            "Model"      
            "CC"         
            "Weight"
            "Vehgrp"
            "Seat"       
            "Body"       
            "����¹ö"     
            "�ѧ��Ѵ"     
            "�Ţ����ͧ¹��"      
            "�Ţ��Ƕѧ"      
            "�շ���Ե"     
            "�����������"     
            "���������ҧ/������"     
            "�Ţ���ʵԡ����"      
            "����������������ͧ"     
            "�ع��Сѹ���"         
            "���»�Сѹ�ط��"     
            "���� �ú�ط��"     
            "������� + �ú."     
            "����Ѻ�Ż���ª��"     
            "�кؼ��Ѻ���"    
            "���ͼ��Ѻ��� 1"   
            "�ѹ/��͹/���Դ1" 
            "�Ţ���ѵ�1"         /*A60-0545*/
            "�Ţ���㺢Ѻ���1"     /*A60-0545*/
            "���� 1"   
            "���ͼ��Ѻ��� 2"   
            "�ѹ/��͹/���Դ2" 
            "�Ţ���ѵ�2"         /*A60-0545*/
            "�Ţ���㺢Ѻ���2"     /*A60-0545*/
            "���� 2"   
            "Redbook"    
            "�����"     
            "�Ңҵ�Ҵ"     
            "�ѹ����Ѻ��"     
            /*"ATTERN RATE"*/ /*A63-0174*/
            "������� " /*a63-0174*/
            "Branch"  
            "Vat Code"  
            "Text1" 
            "Text2" 
            "ICNO"  
            "Finit Code "
            "Code Rebate"
            "Agent    "
            "Producer "
            "Campaign " 
            "���͡������"   /*A60-0545*/
            "�Ţ����Ǩ��Ҿ"                  
            "��������è���"                   
            "�ѹ������"                          
            "�ѹ������������Թ�ú"    
            "occup"    
            "nCOLOR" .



        /* end A60-0545 */
        FOR EACH wImport WHERE wImport.pass <> "N" NO-LOCK:
          EXPORT DELIMITER "|"
            Poltyp     /*1. Policy Type (70/72)*/    
            Policy     /*2. �Ţ���������� (70)*/ 
            CedPol     /*3. �Ţ����ѭ�� (�Ҩҡ�Ţ����Ѻ��)*/
            Renpol     /*4. �Ţ����������������*/
            Compol     /*5. Check (Y/N) ��ǧ 72 �������*/
            Comdat     /*6. �ѹ��������������ͧ*/
            Expdat     /*7. �ѹ�������ش����������ͧ*/
            Tiname     /*8. �ӹ�˹�Ҫ���*/ 
            Insnam     /*9. ���ͼ����һ�Сѹ���*/
            name2      /*10. ���/����*/
            iaddr1     /*11. ������� 1*/
            iaddr2     /*12. ������� 2*/
            iaddr3     /*13. ������� 4*/
            iaddr4     /*14. ������� 5*/
            Prempa     /*15. Premium Pack*/
            class      /*16. Class (110)*/
            Brand      /*17. ������ö*/
            Model      /*18. ���ö*/
            CC         /*19. ��Ҵ����ͧ¹��*/
            Weight     /*20. ���˹ѡö*/
            vehgrp     /*A59-0070*/
            Seat       /*21. �����*/
            Body       /*22. */
            Vehreg     /*23. �Ţ����¹ö*/
            CarPro     /*24. �ѧ��Ѵ*/
            Engno      /*25. �Ţ����ͧ¹��*/
            Chano      /*26. �Ţ��Ƕѧ*/
            yrmanu     /*27. �շ���Ե*/
            Vehuse     /*28. ������*/
            garage     /*29. ������� ��ҧ(G)/������(H)*/
            stkno      /*30. �Ţʵԡ����*/
            covcod     /*31. ����������������ͧ*/
            si         /*32. �ع��Сѹ�ѹ*/
            Prem_t     /*33. �������*/
            Prem_c     /*34. ���� �ú. ���*/
            Prem_r     /*35. ������� �ú.*/  
            Bennam     /*36. ����Ѻ�Ż���ª��*/
            drivnam    /*37. �кؼ��Ѻ��� (Y/N)*/
            drivnam1   /*38. ���ͼ��Ѻ��� 1*/
            drivbir1   /*39. �ѹ�Դ���Ѻ��� 1*/
            drivic1    /*40    �Ţ�ѵû��. */    /*A60*0545*/
            drivid1    /*41    �Ţ�ѵâѺ���*/    /*A60*0545*/
            drivage1   /*42. ���ؼ��Ѻ��� 1*/
            drivnam2   /*43. ���ͼ��Ѻ��� 2*/   
            drivbir2   /*44. �ѹ�Դ���Ѻ��� 2*/
            drivic1    /*45. �Ţ�ѵû��. */       /*A60*0545*/ 
            drivid1    /*46. �Ţ�ѵâѺ���*/      /*A60*0545*/ 
            drivage2   /*47. ���ؼ��Ѻ��� 2*/   
            Redbook    /*48. ���� redbook*/
            opnpol     /*49. ���ͼ����*/
            bandet     /*50. ��Ҵ�Ң�*/
            tltdat     /*51. �ѹ����Ѻ��*/
            attrate    /*52. Attrate*/
            branch     /*53. Branch*/
            vatcode    /*54  Vat Code*/
            text1      /*55. Text �ѧ���*/
            text2      /*56 Text ��Ǩ��Ҿ*/
            icno       /*57 �Ţ���ѵû�ЪҪ�*/ 
            finit      /*58  Finit Code*/
            Rebate     /*59  Code Rebate*/   /*A55-0235*/
            agent      /*60  agent */        /*A60-0545*/ /*A64-0205*/
            Producer   /*61  producer */     /*A60-0545*/ /*A64-0205*/
            ""         /*62  campaign  */    /*A60-0545*/
            name3      /*63  ���͡������*/  /*A60-0545*/
            ""                
            ""                
            ""                    
            ""    
            ""    
            ncolor.









        END.
    OUTPUT CLOSE.
    MESSAGE "Output Complete" VIEW-AS ALERT-BOX.
/*DISP " " @ fiImpName WITH FRAME fr_main. 
DISP " " @ fiExpName WITH FRAME fr_main.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PdImpNew C-Win 
PROCEDURE PdImpNew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fiImpName).
    REPEAT:
        IMPORT DELIMITER "|"
            /* comment by Ranu I. A60-0545............
            /*1*/  Imidno           /*id*/
            /*2*/  Imtltdat         /*�ѹ����Ѻ��*/
            /*3*/  Imcomcod         /*Code ��Сѹ���*/
            /*4*/  Imstkno          /*�Ţʵ�����*/
            /*5*/  Imstkno1         /*������Ţʵ������*/
            /*6*/  Imyrcomp         /*�ú.��*/
            /*7*/  Impolcomp        /*��.�ú.�Ţ���*/
            /*8*/  Imcomnam         /*���ͻ�Сѹ���*/
            /*9*/  Imcedpol         /*�Ţ����Ѻ��*/
            /*10*/ Imbandet         /*��Ҵ�Ң�*/
            /*11*/ Imbancode        /*Code ��Ҵ�Ң�*/
            /*12*/ Imopnpol         /*�����*/
            /*13*/ Imcodgrp         /*�����*/
            /*14*/ Imtiname         /*����Ѻ��*/
            /*15*/ Iminsnam         /*���ͼ����һ�Сѹ���*/
            /*16*/ ImICNo           /*�ѵû�ЪҪ�/�Ţ����¹��ä��*/
            /*17*/ Imnfadd          /*������� NF*/
            /*18*/ Iminadd          /*��������١���*/
            /*19*/ Imdeadd          /*������� Dealer*/
            /*20*/ Imiadd1          /*��������´�������*/
            /*21*/ Imiadd2          /*��������´�������1*/
            /*22*/ Imiadd3          /*������*/
            /*23*/ Immadd1          /*��������͡���*/
            /*24*/ Immadd2          /*��������͡��� 1*/
            /*25*/ Immadd3          /*������1*/
            /*26*/ Imsi             /*�ع��Сѹ*/
            /*27*/ Imgrossi         /*ǧ�Թ������ͧ*/
            /*28*/ Imprem           /*���»�Сѹ�ط��*/
            /*29*/ Imnetprem        /*���»�Сѹ���*/
            /*30*/ Imcomp           /*���� �ú. �ط��*/
            /*31*/ Imnetcomp        /*���� �ú.���*/
            /*32*/ Impremtot        /*���»�Сѹ + �ú.*/
            /*33*/ Imbrand          /*������*/
            /*34*/ Immodel          /*���*/
            /*35*/ Imyrmanu         /*��*/
            /*36*/ Imcarcol         /*��*/
            /*37*/ Imvehreg         /*�Ţ����¹*/
            /*38*/ Imcc             /*��Ҵ����ͧ¹��*/
            /*39*/ Imengno          /*�Ţ����ͧ¹��*/
            /*40*/ Imchasno         /*�Ţ��Ƕѧ*/
            /*41*/ Imother1         /*�����*/
            /*42*/ Imother2         /*TBank/TGL ��*/
            /*43*/ Imother3         /*Delear ���Թ����ͧ*/
            /*44*/ Imandor1         /*Dealer ��*/
            /*45*/ Imandor3         /*TBank ���ú.*/
            /*46*/ Imother4         /*������*/
            /*47*/ Imandor2         /*�ú.Dealer*/
            /*48*/ Imother5         /*�ú.�١���*/
            /*49*/ Imattrate        /*PATTERN RATE*/
            /*50*/ Imcarpri         /*�Ҥ�ö*/
            /*51*/ Imdealernam      /*���� Dealer*/
            /*52*/ Imsalenam        /*���� Sale*/
            /*53*/ Imcovcod         /*��������û�Сѹ���*/
            /*54*/ Imvghgrp1        /*�кت���*/
            /*55*/ Imvghgrp2        /*����кت���*/
            /*56*/ Imdrivnam1       /*����1*/
            /*57*/ Imdrivbir1       /*�ѹ��͹�� �Դ1*/
            /*58*/ Imidno1          /*�Ţ��� ID1*/
            /*59*/ Imlicen1         /*㺢Ѻ��� 1 �Ţ���*/
            /*60*/ Imdrivnam2       /*����2*/            
            /*61*/ Imdrivbir2       /*�ѹ��͹�� �Դ2*/  
            /*62*/ Imidno2          /*�Ţ��� ID2*/        
            /*63*/ Imlicen2         /*㺢Ѻ��� 2 �Ţ���*/ 
            /*64*/ Imcomdate        /*�ѹ��������ͧ*/
            /*65*/ Imexpdate        /*�ѹ����ش������ͧ*/
            /*66*/ Imvehuse1        /*��ǹ�ؤ��*/
            /*67*/ Imvehuse2        /*���͡�þҳԪ��*/
            /*68*/ Imvehuse3        /*���͡�þҳԪ������*/
            /*69*/ Imvehuse4        /*�Ѻ��ҧ�Ҹ�ó�*/
            /*70*/ Imvehuse5        /*����*/
            /*71*/ Imothvehuse      /*�����˵�����*/
            /*72*/ Imcodecar        /*����*/
            /*73*/ Imdetrge1        /*����ᴧ*/
            /*74*/ Imdetrge2        /*USED CAR*/
            /*75*/ Imbody1          /*��*/
            /*76*/ Imbody2          /*��к�*/
            /*77*/ Imbody3          /*���*/
            /*78*/ Imbody4          /*����*/
            /*79*/ Imothbody        /*�������ö����*/
            /*80*/ Imgarage1        /*�����ҧ*/
            /*81*/ Imgarage2        /*��������*/
            /*82*/ Imcodereb        /*Code Rebate*/
            /*83*/ Imcomment        /*�����˵�*/
            /*84*/ Imseat           /*�ӹǹ�����*/
            /*85*/ Imdoctyp         /*�������͡���*/
            /*86*/ Imicno1          /*�Ţ��Шӵ�Ǽ����������*/
            /*87*/ Imdocdetail      /*������¹������Ť�������������*/
            /*88*/ Imbranins        /*�Ңҷ��*/
            /*89*/ Imbennam         /*����Ѻ�Ż���ª��*/
            /*90*/ ImVatCode        /*Vat Code*/
            /*91*/ ImFinint         /*Finnit Code*/
            /*92*/ ImRemark1        /*Remark1*/
            /*93*/ ImRemark2        /*Remark2*/ .
            ........end A60-0545.............*/
            /* create by : Ranu i. A60-0545 20/12/2017 */
            Imtltdat            /*�ѹ����Ѻ��         */                
            Imcomcod            /*Code ��Сѹ���        */                
            Imstkno             /*�Ţʵ������         */                
            Impolcomp           /*�� �ú �Ţ���         */                
            Imcomnam            /*���ͻ�Сѹ���         */                
            Imcedpol            /*�Ţ����Ѻ��         */                
            Imbandet            /*��Ҵ�Ң�              */                
            Imbancode           /*Code ��Ҵ�Ң�         */                
            Imopnpol            /*�����               */                
            Imcodgrp            /*�����                 */                
            Imtiname            /*����Ѻ��            */                
            Iminsnam            /*���ͼ����һ�Сѹ���   */                
            ImICNo              /*�Ţ���ѵ�            */                
            Imiadd1             /*�������Ѩ�غѹ/��.20 */                
            Imiadd2             /*�������Ѩ�غѹ/��.20 */                
            Imiadd3             /*������              */                
            Immadd1             /*����������͡���      */                
            Immadd2             /*����������͡���1     */                
            Immadd3             /*������1             */                
            Imsi                /*�ع��Сѹ             */                
            Imprem              /*���»�Сѹ�ط��      */                
            Imnetprem           /*���»�Сѹ���        */                
            Imcomp              /*���¾ú �ط��        */                
            Imnetcomp           /*���¾ú ���          */                
            Impremtot           /*���»�Сѹ+�ú       */                
            imnotino            /*�Ţ������ͧ���Ǥ���   */                
            Imbrand             /*������                */                
            Immodel             /*���                  */                
            Imyrmanu            /*��                    */                
            Imcarcol            /*��                    */                
            Imvehreg            /*�Ţ����¹            */                
            Imcc                /*��Ҵ����ͧ¹��       */                
            Imengno             /*�Ţ����ͧ¹��        */                
            Imchasno            /*�Ţ��Ƕѧ             */                
            ImRemark1           /*�˵ؼšó� �Ţ����ͧ/�Ţ�ѧ���*/       
            Imother1            /*�Ҥ��Ѥ�� ��/�����*/                 
            Imother2            /*�Ҥ�ѧ�Ѻ ��/����� */                 
            /*Imattrate   */        /*PATTERN RATE         */    /*a63-0174 */              
            Imcarpri            /*�Ҥ�ö               */                 
            Imgrossi            /*�Ҥҡ�ҧ             */                 
            Imdealernam         /*���� Dealer          */                 
            Imcovcod            /*��������û�Сѹ���   */                 
            Imvghgrp1           /*���Ѻ���            */                 
            Imdrivnam1          /*���� 1               */                 
            Imdrivbir1          /*�ѹ/��͹/���Դ1    */                 
            Imidno1             /*�Ţ��� ID1           */                 
            Imlicen1            /*㺢Ѻ��� 1 �Ţ���    */                 
            Imdrivnam2          /*���� 2               */                 
            Imdrivbir2          /*�ѹ/��͹/���Դ2    */                 
            Imidno2             /*�Ţ��� ID2           */                 
            Imlicen2            /*㺢Ѻ��� 2 �Ţ���    */                 
            Imcomdate           /*�ѹ��������ͧ       */                 
            Imexpdate           /*�ѹ����ش������ͧ   */                 
            Imvehuse1           /*�����������ö       */                 
            Imothvehuse         /*�����˵�����        */                 
            /*Imcodecar        */   /*����                 */  /*a63-0174*/               
            Imdetrge1           /*��Դö               */                 
            Imbody1             /*������ö             */                 
            Imothbody           /*������ö����        */                 
            Imgarage1           /*��������ë���        */                 
            Imcodereb           /*Code Rebate          */                 
            Imcomment           /*�����˵�             */                 
            Imseat              /*�ӹǹ�����         */                 
            Imicno1             /*�Ţ��Шӵ�Ǽ���������� */               
            imname2             /*���͡�����ú���ѷ      */               
            Imdoctyp            /*�������͡���           */               
            Imdocdetail         /*������¹������Ť�������������*/       
            Imbranins           /*�Ңҷ��              */                 
            Imbennam            /*����Ѻ�Ż���ª��     */                 
            Imidno              /*�Ţ���㺤Ӣ���ҫ��� */  
            Imattrate .         /* ������� */ /*A63-0174*/

        /* end A60-0545 */                                                
        IF index(Imtltdat,"�ѹ���") <> 0  THEN NEXT.
        ELSE IF TRIM(Imtltdat) = ""  THEN NEXT.
        ELSE DO:
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
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE (fiImpName).
    REPEAT:
        IMPORT DELIMITER "|"
            Imtltno         /*�Ţ����Ѻ������Ң�     */  
            Imtltno1        /*�Ţ����Ѻ��            */  
            Imbancode       /*�Ң�                     */  
            Imcedpol        /*�Ţ����ѭ��              */  
            Imrenpol        /*�Ţ�������������       */  
            Imcomnam        /*����ѷ��Сѹ���         */  
            Iminsnam        /*���ͼ����һ�Сѹ���      */  
            Imbennam        /*����Ѻ�Ż���ª��         */  
            Imcomdate       /*�ѹ��������������ͧ      */  
            Imexpdate       /*�ѹ�������ش������ͧ    */  
            Imcomdat1       /*�ѹ�������������ͧ�ú    */  
            Imexpdat1       /*�ѹ�������ش������ͧ�ú */  
            Imvehreg        /*�Ţ����¹               */  
            Imvehreg1       /*�ѧ��Ѵ                  */  
            Imsi            /*�ع��Сѹ                */  
            Imnetprem       /*���»�Сѹ���           */  
            Imnetcomp       /*���¾ú���              */  
            Impremtot       /*�������                 */  
            Impolcomp       /*�Ţ��������ú           */  
            Imstkno         /*�Ţ���ʵ������         */  
            Imcodgrp        /*���ʼ����              */  
            Imdetail        /*�����˵�                 */  
            Imtltdat        /*�ѹ����Ѻ��            */  
            Imcomnam1       /*���ͻ�Сѹ���            */  
            Imopnpol        /*�����                  */  
            Imbrand         /*������                   */  
            ImModel         /*���                     */  
            Imyrmanu        /*��                       */  
            Imcc            /*��Ҵ����ͧ              */  
            Imengno         /*�Ţ����ͧ               */  
            Imchasno        /*�Ţ�ѧ                   */  
            Imattrate       /*Pattern Rate             */  
            Imcovcod        /*��������Сѹ             */  
            Imbody1         /*������ö                 */  
            Imgarage1       /*ʶҹ������              */  
            Imdrivnam1      /*�кؼ��Ѻ���1           */  
            Imlicen1        /*�Ţ���㺢Ѻ���1          */  
            Imidno1         /*�Ţ���ѵû�ЪҪ�1       */  
            Imdrivbir1      /*�ѹ��͹���Դ1          */  
            Imdrivnam2      /*�кؼ��Ѻ���2           */  
            Imlicen2        /*�Ţ���㺢Ѻ���2          */  
            Imidno2         /*�Ţ���ѵû�ЪҪ�2       */  
            Imdrivbir2      /*�ѹ��͹���Դ2          */  
            /*Imdeduct1      
            Imdeduct2        
            Imdeduct3*/      
            Imdeductda      /*��ǹŴ����ѵ�����        */  
            Imncb           /*��ǹŴ�����              */  
            Imdeductpd      /*����ѵԴ�                */  
            Imother         /*��� �                   */  
            Imaddr          /*��������١���            */  
            Imicno          /*IDCARD                   */  
            Imiccomdat      /*DateCARD_S               */ 
            Imicexpdat      /*DateCARD_E               */ 
            Imtypaid.       /*Type_Paid_1              */ 
        IF index(Imtltno,"�Ţ����Ѻ��") <> 0 THEN NEXT.
        ELSE IF TRIM(imtltno) = "" THEN NEXT.
        ELSE  RUN PdChkRenew.
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
            "�Ţ����������"     
            "�Ţ����ѭ��"     
            "�Ţ��������������"     
            "Compulsory"     
            "�ѹ��������������ͧ"     
            "�ѹ�������ش����������ͧ"     
            "�ӹ�˹�Ҫ���"     
            "���ͼ����һ�Сѹ"     
            "���/����"      
            "������� 1"     
            "������� 2"     
            "������� 3"     
            "������� 4"     
            "Pack"     
            "Class"      
            "Brand"      
            "Model"      
            "CC"         
            "Weight"     
            "Seat"       
            "Body"       
            "����¹ö"     
            "�ѧ��Ѵ"     
            "�Ţ����ͧ¹��"      
            "�Ţ��Ƕѧ"      
            "�շ���Ե"     
            "�����������"     
            "���������ҧ/������"     
            "�Ţ���ʵԡ����"      
            "����������������ͧ"     
            "�ع��Сѹ���"         
            "���»�Сѹ���"     
            "���� �ú. ���"     
            "������� + �ú."     
            "����Ѻ�Ż���ª��"     
            "�кؼ��Ѻ���"    
            "���ͼ��Ѻ��� 1"   
            "�ѹ/��͹/���Դ1"   
            "���� 1"   
            "���ͼ��Ѻ��� 2"   
            "�ѹ/��͹/���Դ2"   
            "���� 2"   
            "Redbook"    
            "�����"     
            "�Ңҵ�Ҵ"     
            "�ѹ����Ѻ��"     
            /*"ATTERN RATE"*/ /*A63-0174*/
            "�������" /*A63-0174*/
            "Branch"  
            "Vat Code"  
            "Text1" 
            "Text2" 
            "Comment"  . 
    
        FOR EACH wImport WHERE wImport.pass = "N" NO-LOCK.
          EXPORT DELIMITER "|"
            Poltyp     /*1. Policy Type (70/72)*/    
            Policy     /*2. �Ţ���������� (70)*/ 
            CedPol     /*3. �Ţ����ѭ�� (�Ҩҡ�Ţ����Ѻ��)*/
            Renpol     /*4. �Ţ����������������*/
            Compol     /*5. Check (Y/N) ��ǧ 72 �������*/
            Comdat     /*6. �ѹ��������������ͧ*/
            Expdat     /*7. �ѹ�������ش����������ͧ*/
            Tiname     /*8. �ӹ�˹�Ҫ���*/ 
            Insnam     /*9. ���ͼ����һ�Сѹ���*/
            name2      /*10. ���/����*/
            iaddr1     /*11. ������� 1*/
            iaddr2     /*12. ������� 2*/
            iaddr3     /*13. ������� 4*/
            iaddr4     /*14. ������� 5*/
            Prempa     /*15. Premium Pack*/
            class      /*16. Class (110)*/
            Brand      /*17. ������ö*/
            Model      /*18. ���ö*/
            CC         /*19. ��Ҵ����ͧ¹��*/
            Weight     /*20. ���˹ѡö*/
            Seat       /*21. �����*/
            Body       /*22. */
            Vehreg     /*23. �Ţ����¹ö*/
            CarPro     /*24. �ѧ��Ѵ*/
            Engno      /*25. �Ţ����ͧ¹��*/
            Chano      /*26. �Ţ��Ƕѧ*/
            yrmanu     /*27. �շ���Ե*/
            Vehuse     /*28. ������*/
            garage     /*29. ������� ��ҧ(G)/������(H)*/
            stkno      /*30. �Ţʵԡ����*/
            covcod     /*31. ����������������ͧ*/
            si         /*32. �ع��Сѹ�ѹ*/
            Prem_t     /*33. �������*/
            Prem_c     /*34. ���� �ú. ���*/
            Prem_r     /*35. ������� �ú.*/  
            Bennam     /*36. ����Ѻ�Ż���ª��*/
            drivnam    /*37. �кؼ��Ѻ��� (Y/N)*/
            drivnam1   /*38. ���ͼ��Ѻ��� 1*/
            drivbir1   /*39. �ѹ�Դ���Ѻ��� 1*/
            drivage1   /*40. ���ؼ��Ѻ��� 1*/
            drivnam2   /*38. ���ͼ��Ѻ��� 2*/   
            drivbir2   /*39. �ѹ�Դ���Ѻ��� 2*/
            drivage2   /*40. ���ؼ��Ѻ��� 2*/   
            Redbook    /*41. ���� redbook*/
            opnpol     /*42. ���ͼ����*/
            bandet     /*43. ��Ҵ�Ң�*/
            tltdat     /*44. �ѹ����Ѻ��*/
            attrate    /*45. Attrate*/
            branch     /*46. Branch*/
            vatcode    /*47. Vat Code*/
            text1      /*48. Text �ѧ���*/
            text2      /*49. Text ��Ǩ��Ҿ*/
            icno       /*50. �Ţ���ѵû�ЪҪ�*/ 
            comment.
        END.
    OUTPUT CLOSE.
END. /*pass > 0*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

