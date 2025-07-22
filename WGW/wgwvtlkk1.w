&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME CURRENT-WINDOW
&Scoped-define FRAME-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS Dialog-Frame 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: 

  Created: 
  
/************************************************************************/
/* wgwvtlkk1.w   Query Address TLT                                                                        */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.           */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)                 */
/* CREATE BY    : Chaiyong W. A64-0135 21/06/2021                                */
/************************************************************************/  
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */


DEF INPUT-OUTPUT PARAMETER nv_ahaddr1          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahaddr2          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahaddr3          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahaddr4          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahaddr5          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahno             as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahmoo            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahvil            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahfloor          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahroom           as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_asoi             as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_astreet          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_adistrict        as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahsubdis         as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahprov           as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahcountry        as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ahzip            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_acontact         as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_acontel          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_abentyp          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_abennam          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_apayper          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_asum             as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-2           as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-3           as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet             as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-4           as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-5           as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-7           as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-9           as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-10          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-8           as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-11          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-12          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-13          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-15          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-16          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-14          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-17          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-18          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_anet-19          as deci no-undo init 0.
DEF INPUT-OUTPUT PARAMETER nv_aremark          as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alpro            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_aloanc           as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alprod           as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alapp            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_albook           as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alcre            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alst             as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alamt            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_ali              as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alr              as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_alfd             as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_adeal            as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_anotno           as char no-undo init "".
DEF INPUT-OUTPUT PARAMETER nv_anotdat          AS DATE no-undo INIT ?.
DEF INPUT-OUTPUT PARAMETER nv_anottim          as char no-undo init "".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS Btn_OK Btn_Cancel 
&Scoped-Define DISPLAYED-OBJECTS fi_haddr1 fi_haddr2 fi_haddr3 fi_haddr4 ~
fi_haddr5 fi_hno fi_hmoo fi_hvil fi_hfloor fi_hroom fi_soi fi_street ~
fi_district fi_hsubdis fi_hprov fi_hcountry fi_hzip fi_contact fi_contel ~
fi_bentyp fi_bennam fi_payper fi_sum fi_net fi_net-2 fi_net-3 fi_net-4 ~
fi_net-5 fi_net-7 fi_net-8 fi_net-9 fi_net-10 fi_net-11 fi_net-12 fi_net-13 ~
fi_net-14 fi_net-15 fi_net-16 fi_net-17 fi_net-18 fi_net-19 fi_remark ~
fi_loanc fi_lprod fi_lpro fi_lapp fi_lbook fi_lcre fi_lst fi_lamt fi_li ~
fi_lr fi_lfd fi_deal fi_notno fi_notdat fi_nottim 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE BUTTON Btn_OK 
     LABEL "OK" 
     SIZE 15 BY 1.14
     BGCOLOR 8 .

DEFINE VARIABLE fi_bennam AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bentyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 48.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_contact AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 71.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_contel AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 42.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_deal AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 77.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_district AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_haddr1 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 53.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_haddr2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 49.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_haddr3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 64.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_haddr4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 49.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_haddr5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 64.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hcountry AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hfloor AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hmoo AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hprov AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hroom AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hsubdis AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hvil AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hzip AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lamt AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lapp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lbook AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lcre AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lfd AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_li AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 7.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_loanc AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lpro AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 54.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lprod AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lr AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 13.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_lst AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-10 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-11 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-12 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-13 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-14 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-15 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-16 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-17 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-18 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-19 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-2 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-3 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-4 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-5 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-7 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-8 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_net-9 AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_payper AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 97 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_soi AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_street AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_sum AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 28.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     fi_haddr1 AT ROW 1.95 COL 46.33 COLON-ALIGNED NO-LABEL WIDGET-ID 122
     fi_haddr2 AT ROW 3.38 COL 22.33 COLON-ALIGNED NO-LABEL WIDGET-ID 126
     fi_haddr3 AT ROW 3.38 COL 98.83 COLON-ALIGNED NO-LABEL WIDGET-ID 130
     fi_haddr4 AT ROW 4.57 COL 22.33 COLON-ALIGNED NO-LABEL WIDGET-ID 134
     fi_haddr5 AT ROW 4.57 COL 98.83 COLON-ALIGNED NO-LABEL WIDGET-ID 138
     fi_hno AT ROW 6.05 COL 24.17 COLON-ALIGNED NO-LABEL WIDGET-ID 212
     fi_hmoo AT ROW 6.05 COL 45.67 COLON-ALIGNED NO-LABEL WIDGET-ID 214
     fi_hvil AT ROW 6.05 COL 93.17 COLON-ALIGNED NO-LABEL WIDGET-ID 218
     fi_hfloor AT ROW 6 COL 123.17 COLON-ALIGNED NO-LABEL WIDGET-ID 222
     fi_hroom AT ROW 6 COL 146 COLON-ALIGNED NO-LABEL WIDGET-ID 226
     fi_soi AT ROW 7.24 COL 10.67 COLON-ALIGNED NO-LABEL WIDGET-ID 230
     fi_street AT ROW 7.24 COL 33.17 COLON-ALIGNED NO-LABEL WIDGET-ID 234
     fi_district AT ROW 7.24 COL 63.67 COLON-ALIGNED NO-LABEL WIDGET-ID 238
     fi_hsubdis AT ROW 7.24 COL 98.67 COLON-ALIGNED NO-LABEL WIDGET-ID 242
     fi_hprov AT ROW 7.24 COL 132.67 COLON-ALIGNED NO-LABEL WIDGET-ID 246
     fi_hcountry AT ROW 8.43 COL 10.67 COLON-ALIGNED NO-LABEL WIDGET-ID 250
     fi_hzip AT ROW 8.43 COL 43.17 COLON-ALIGNED NO-LABEL WIDGET-ID 254
     fi_contact AT ROW 9.57 COL 22 COLON-ALIGNED NO-LABEL WIDGET-ID 358
     fi_contel AT ROW 9.57 COL 117.5 COLON-ALIGNED NO-LABEL WIDGET-ID 362
     fi_bentyp AT ROW 11 COL 22.33 COLON-ALIGNED NO-LABEL WIDGET-ID 422
     fi_bennam AT ROW 11 COL 95.83 COLON-ALIGNED NO-LABEL WIDGET-ID 420
     fi_payper AT ROW 12.19 COL 22.33 COLON-ALIGNED NO-LABEL WIDGET-ID 426
     fi_sum AT ROW 12.19 COL 72 COLON-ALIGNED NO-LABEL WIDGET-ID 430
     fi_net AT ROW 14.57 COL 16.5 COLON-ALIGNED NO-LABEL WIDGET-ID 432
     fi_net-2 AT ROW 14.52 COL 44.67 COLON-ALIGNED NO-LABEL WIDGET-ID 436
     fi_net-3 AT ROW 14.52 COL 67.67 COLON-ALIGNED NO-LABEL WIDGET-ID 440
     fi_net-4 AT ROW 14.57 COL 92.5 COLON-ALIGNED NO-LABEL WIDGET-ID 444
     fi_net-5 AT ROW 14.57 COL 117.33 COLON-ALIGNED NO-LABEL WIDGET-ID 448
     fi_net-7 AT ROW 14.57 COL 145.33 COLON-ALIGNED NO-LABEL WIDGET-ID 456
     fi_net-8 AT ROW 17.19 COL 16.5 COLON-ALIGNED NO-LABEL WIDGET-ID 462
     fi_net-9 AT ROW 17.14 COL 44.67 COLON-ALIGNED NO-LABEL WIDGET-ID 464
     fi_net-10 AT ROW 17.14 COL 67.67 COLON-ALIGNED NO-LABEL WIDGET-ID 466
     fi_net-11 AT ROW 17.19 COL 92.5 COLON-ALIGNED NO-LABEL WIDGET-ID 468
     fi_net-12 AT ROW 17.19 COL 117.33 COLON-ALIGNED NO-LABEL WIDGET-ID 470
     fi_net-13 AT ROW 17.19 COL 145.33 COLON-ALIGNED NO-LABEL WIDGET-ID 472
     fi_net-14 AT ROW 19.81 COL 16 COLON-ALIGNED NO-LABEL WIDGET-ID 496
     fi_net-15 AT ROW 19.76 COL 44.17 COLON-ALIGNED NO-LABEL WIDGET-ID 498
     fi_net-16 AT ROW 19.76 COL 67.17 COLON-ALIGNED NO-LABEL WIDGET-ID 488
     fi_net-17 AT ROW 19.81 COL 92 COLON-ALIGNED NO-LABEL WIDGET-ID 490
     fi_net-18 AT ROW 19.81 COL 116.83 COLON-ALIGNED NO-LABEL WIDGET-ID 492
     fi_net-19 AT ROW 19.81 COL 144.83 COLON-ALIGNED NO-LABEL WIDGET-ID 494
     fi_remark AT ROW 21 COL 18.5 COLON-ALIGNED NO-LABEL WIDGET-ID 514
     fi_loanc AT ROW 22.19 COL 18.5 COLON-ALIGNED NO-LABEL WIDGET-ID 518
     fi_lprod AT ROW 22.19 COL 68 COLON-ALIGNED NO-LABEL WIDGET-ID 522
     fi_lpro AT ROW 22.14 COL 97.17 COLON-ALIGNED NO-LABEL WIDGET-ID 526
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     fi_lapp AT ROW 23.38 COL 18.5 COLON-ALIGNED NO-LABEL WIDGET-ID 528
     fi_lbook AT ROW 23.38 COL 68 COLON-ALIGNED NO-LABEL WIDGET-ID 532
     fi_lcre AT ROW 23.38 COL 116.33 COLON-ALIGNED NO-LABEL WIDGET-ID 536
     fi_lst AT ROW 24.57 COL 18.5 COLON-ALIGNED NO-LABEL WIDGET-ID 540
     fi_lamt AT ROW 24.57 COL 75 COLON-ALIGNED NO-LABEL WIDGET-ID 544
     fi_li AT ROW 24.57 COL 130.5 COLON-ALIGNED NO-LABEL WIDGET-ID 548
     fi_lr AT ROW 25.76 COL 19 COLON-ALIGNED NO-LABEL WIDGET-ID 552
     fi_lfd AT ROW 25.76 COL 54.5 COLON-ALIGNED NO-LABEL WIDGET-ID 556
     fi_deal AT ROW 25.76 COL 84.17 COLON-ALIGNED NO-LABEL WIDGET-ID 562
     fi_notno AT ROW 26.95 COL 19 COLON-ALIGNED NO-LABEL WIDGET-ID 564
     fi_notdat AT ROW 26.95 COL 84 COLON-ALIGNED NO-LABEL WIDGET-ID 568
     fi_nottim AT ROW 26.95 COL 111.83 COLON-ALIGNED NO-LABEL WIDGET-ID 572
     Btn_OK AT ROW 26.95 COL 133
     Btn_Cancel AT ROW 26.95 COL 150
     "  Remark :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 21 COL 1.5 WIDGET-ID 516
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " LoanInstallmentAMT :":30 VIEW-AS TEXT
          SIZE 23.33 BY 1 AT ROW 24.57 COL 51.17 WIDGET-ID 546
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " LoanInstallment":30 VIEW-AS TEXT
          SIZE 23.33 BY 1 AT ROW 24.57 COL 107 WIDGET-ID 550
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Village/Building :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 6.05 COL 71.67 WIDGET-ID 338
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Loan Rate :":30 VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 25.76 COL 1.67 WIDGET-ID 554
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Gross :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 17.19 COL 84.5 WIDGET-ID 480
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Amount :":30 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 19.81 COL 135.5 WIDGET-ID 510
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Address 1":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.95 COL 25 WIDGET-ID 124
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  LoanFirstDueDate":30 VIEW-AS TEXT
          SIZE 20 BY 1 AT ROW 25.76 COL 35.5 WIDGET-ID 558
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Street :":30 VIEW-AS TEXT
          SIZE 9 BY 1 AT ROW 7.24 COL 26.17 WIDGET-ID 346
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  WHT :":30 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 19.81 COL 109.5 WIDGET-ID 508
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Loan App. Date :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 23.38 COL 1.5 WIDGET-ID 530
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Amount :":30 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 14.57 COL 136 WIDGET-ID 458
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Payment Period :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 12.19 COL 1.5 WIDGET-ID 220
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Moo :":30 VIEW-AS TEXT
          SIZE 8 BY 1 AT ROW 6.05 COL 39.17 WIDGET-ID 336
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Floor :":30 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 6.05 COL 115.67 WIDGET-ID 340
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "  Yearly":30 VIEW-AS TEXT
          SIZE 20.17 BY 1 AT ROW 13.38 COL 1.83 WIDGET-ID 460
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "  Vat :":30 VIEW-AS TEXT
          SIZE 6.5 BY 1 AT ROW 14.52 COL 62.67 WIDGET-ID 442
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Net Premium :":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 14.57 COL 1.5 WIDGET-ID 434
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Net Premium :":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 17.19 COL 1.5 WIDGET-ID 474
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Contact Address :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 6 COL 1.5 WIDGET-ID 334
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Country :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 8.43 COL 2.67 WIDGET-ID 354
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Loan Credit Line :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 23.38 COL 99.33 WIDGET-ID 538
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Stamp :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 17.14 COL 36.67 WIDGET-ID 476
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Vat :":30 VIEW-AS TEXT
          SIZE 6.5 BY 1 AT ROW 17.14 COL 62.67 WIDGET-ID 478
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  First Installment":30 VIEW-AS TEXT
          SIZE 20.67 BY 1 AT ROW 16 COL 1.83 WIDGET-ID 486
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "  Next Installment":30 VIEW-AS TEXT
          SIZE 20.67 BY 1 AT ROW 18.62 COL 1.33 WIDGET-ID 512
          BGCOLOR 3 FGCOLOR 7 FONT 6
     "  Room :":30 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 6.05 COL 138.67 WIDGET-ID 342
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Address 5 :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 4.57 COL 77.67 WIDGET-ID 140
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Stamp :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 19.76 COL 36.17 WIDGET-ID 502
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Suminsured :":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 12.19 COL 55 WIDGET-ID 428
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Zip Code :":30 VIEW-AS TEXT
          SIZE 12.5 BY 1 AT ROW 8.43 COL 31.67 WIDGET-ID 256
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  House Registration :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.95 COL 1.83 WIDGET-ID 210
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Address 2 :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.38 COL 1.83 WIDGET-ID 128
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Beneficiary Name :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 11 COL 74.5 WIDGET-ID 216
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Gross :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 14.57 COL 84.5 WIDGET-ID 446
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Soi :":30 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 7.24 COL 2.67 WIDGET-ID 344
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Beneficiary Type :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 11 COL 1 WIDGET-ID 424
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Contact Tel :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 9.57 COL 96.5 WIDGET-ID 416
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "  วันและเวลาออกเลขที่รับแจ้ง/พรบ :":30 VIEW-AS TEXT
          SIZE 32.5 BY 1 AT ROW 26.95 COL 52.67 WIDGET-ID 570
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Vat :":30 VIEW-AS TEXT
          SIZE 6.5 BY 1 AT ROW 19.76 COL 62.17 WIDGET-ID 504
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Province  :":30 VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 7.24 COL 119.67 WIDGET-ID 352
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Net Premium :":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 19.81 COL 1 WIDGET-ID 500
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Address 4 :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 4.57 COL 1.83 WIDGET-ID 136
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Loan Status :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 24.57 COL 1.5 WIDGET-ID 542
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Gross :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 19.81 COL 84 WIDGET-ID 506
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Address 3 :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.38 COL 77.5 WIDGET-ID 132
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Amount :":30 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 17.19 COL 136 WIDGET-ID 484
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Loan Product :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 22.19 COL 51 WIDGET-ID 524
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  District  :":30 VIEW-AS TEXT
          SIZE 11.5 BY 1 AT ROW 7.24 COL 53.67 WIDGET-ID 240
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Loan Book Date :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 23.38 COL 51 WIDGET-ID 534
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Loan Contact :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 22.19 COL 1.5 WIDGET-ID 520
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  WHT :":30 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 14.57 COL 110 WIDGET-ID 450
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Contact Person :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 9.57 COL 1.33 WIDGET-ID 364
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  เลขที่รับแจ้ง :":30 VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 26.95 COL 1.5 WIDGET-ID 566
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Stamp :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 14.52 COL 36.67 WIDGET-ID 438
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  WHT :":30 VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 17.19 COL 110 WIDGET-ID 482
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Sub Distirct :":30 VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 7.24 COL 85 WIDGET-ID 350
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Dealer :":30 VIEW-AS TEXT
          SIZE 11 BY 1 AT ROW 25.76 COL 74.5 WIDGET-ID 560
          BGCOLOR 18 FGCOLOR 0 FONT 6
     SPACE(80.99) SKIP(2.33)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         TITLE "Query & Review Address TLT      "
         CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Dialog-Box
   Allow: Basic,Browse,DB-Fields,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR DIALOG-BOX Dialog-Frame
   FRAME-NAME Custom                                                    */
ASSIGN 
       FRAME Dialog-Frame:SCROLLABLE       = FALSE
       FRAME Dialog-Frame:HIDDEN           = TRUE.

/* SETTINGS FOR FILL-IN fi_bennam IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bentyp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_contact IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_contel IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_deal IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_district IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_haddr1 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_haddr2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_haddr3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_haddr4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_haddr5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hcountry IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hfloor IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hmoo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hprov IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hroom IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hsubdis IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hvil IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hzip IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lamt IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lapp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lbook IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lcre IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lfd IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_li IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_loanc IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lpro IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lprod IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lr IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_lst IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-10 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-11 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-12 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-13 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-14 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-15 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-16 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-17 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-18 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-19 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-7 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-8 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_net-9 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_nottim IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_payper IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_remark IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_soi IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_street IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_sum IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Query  Review Address TLT       */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
   ASSIGN 
nv_ahaddr1   =  trim( input fi_haddr1    )           
nv_ahaddr2   =  trim( input fi_haddr2    )           
nv_ahaddr3   =  trim( input fi_haddr3    )           
nv_ahaddr4   =  trim( input fi_haddr4    )           
nv_ahaddr5   =  trim( input fi_haddr5    )           
nv_ahno      =  trim( input fi_hno       )           
nv_ahmoo     =  trim( input fi_hmoo      )           
nv_ahvil     =  trim( input fi_hvil      )           
nv_ahfloor   =  trim( input fi_hfloor    )           
nv_ahroom    =  trim( input fi_hroom     )           
nv_asoi      =  trim( input fi_soi       )           
nv_astreet   =  trim( input fi_street    )           
nv_adistrict =  trim( input fi_district  )           
nv_ahsubdis  =  trim( input fi_hsubdis   )           
nv_ahprov    =  trim( input fi_hprov     )           
nv_ahcountry =  trim( input fi_hcountry  )           
nv_ahzip     =  trim( input fi_hzip      )           
nv_acontact  =  trim( input fi_contact   )           
nv_acontel   =  trim( input fi_contel    )           
nv_abentyp   =  trim( input fi_bentyp    )           
nv_abennam   =  trim( input fi_bennam    )           
nv_apayper   =  trim( input fi_payper    )           
nv_asum      = input  fi_sum      
nv_anet-2    = input  fi_net-2    
nv_anet-3    = input  fi_net-3    
nv_anet      = input  fi_net      
nv_anet-4    = input  fi_net-4    
nv_anet-5    = input  fi_net-5    
nv_anet-7    = input  fi_net-7    
nv_anet-9    = input  fi_net-9    
nv_anet-10   = input  fi_net-10   
nv_anet-8    = input  fi_net-8    
nv_anet-11   = input  fi_net-11   
nv_anet-12   = input  fi_net-12   
nv_anet-13   = input  fi_net-13   
nv_anet-15   = input  fi_net-15   
nv_anet-16   = input  fi_net-16   
nv_anet-14   = input  fi_net-14   
nv_anet-17   = input  fi_net-17   
nv_anet-18   = input  fi_net-18   
nv_anet-19   = input  fi_net-19            
nv_aremark   =   trim(input fi_remark    )           
nv_alpro     =   trim(input fi_lpro      )           
nv_aloanc    =   trim(input fi_loanc     )           
nv_alprod    =   trim(input fi_lprod     )           
nv_alapp     =   trim(input fi_lapp      )           
nv_albook    =   trim(input fi_lbook     )           
nv_alcre     =   trim(input fi_lcre      )           
nv_alst      =   trim(input fi_lst       )           
nv_alamt     =   trim(input fi_lamt      )           
nv_ali       =   trim(input fi_li        )           
nv_alr       =   trim(input fi_lr        )           
nv_alfd      =   trim(input fi_lfd       )           
nv_adeal     =   trim(input fi_deal      )           
nv_anotno    =   trim(input fi_notno     )           
nv_anotdat   = input  fi_notdat               
nv_anottim   =   trim(INPUT fi_nottim    )       .
APPLY "Close":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK Dialog-Frame 


/* ***************************  Main Block  *************************** */

/* Parent the dialog-box to the ACTIVE-WINDOW, if there is no parent.   */
IF VALID-HANDLE(ACTIVE-WINDOW) AND FRAME {&FRAME-NAME}:PARENT eq ?
THEN FRAME {&FRAME-NAME}:PARENT = ACTIVE-WINDOW.


/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
   RUN enable_UI.
   RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE).  
   SESSION:DATA-ENTRY-RETURN = YES. 
  RUN pd_disp.
  
  WAIT-FOR CLOSE OF FRAME {&FRAME-NAME}.
END.
RUN disable_UI.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI Dialog-Frame  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Hide all frames. */
  HIDE FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI Dialog-Frame  _DEFAULT-ENABLE
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
  DISPLAY fi_haddr1 fi_haddr2 fi_haddr3 fi_haddr4 fi_haddr5 fi_hno fi_hmoo 
          fi_hvil fi_hfloor fi_hroom fi_soi fi_street fi_district fi_hsubdis 
          fi_hprov fi_hcountry fi_hzip fi_contact fi_contel fi_bentyp fi_bennam 
          fi_payper fi_sum fi_net fi_net-2 fi_net-3 fi_net-4 fi_net-5 fi_net-7 
          fi_net-8 fi_net-9 fi_net-10 fi_net-11 fi_net-12 fi_net-13 fi_net-14 
          fi_net-15 fi_net-16 fi_net-17 fi_net-18 fi_net-19 fi_remark fi_loanc 
          fi_lprod fi_lpro fi_lapp fi_lbook fi_lcre fi_lst fi_lamt fi_li fi_lr 
          fi_lfd fi_deal fi_notno fi_notdat fi_nottim 
      WITH FRAME Dialog-Frame.
  ENABLE Btn_OK Btn_Cancel 
      WITH FRAME Dialog-Frame.
  VIEW FRAME Dialog-Frame.
  {&OPEN-BROWSERS-IN-QUERY-Dialog-Frame}
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_disp Dialog-Frame 
PROCEDURE pd_disp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
fi_haddr1            = nv_ahaddr1        
fi_haddr2            = nv_ahaddr2        
fi_haddr3            = nv_ahaddr3        
fi_haddr4            = nv_ahaddr4        
fi_haddr5            = nv_ahaddr5        
fi_hno               = nv_ahno           
fi_hmoo              = nv_ahmoo          
fi_hvil              = nv_ahvil          
fi_hfloor            = nv_ahfloor        
fi_hroom             = nv_ahroom         
fi_soi               = nv_asoi           
fi_street            = nv_astreet        
fi_district          = nv_adistrict      
fi_hsubdis           = nv_ahsubdis       
fi_hprov             = nv_ahprov         
fi_hcountry          = nv_ahcountry      
fi_hzip              = nv_ahzip          
fi_contact           = nv_acontact       
fi_contel            = nv_acontel        
fi_bentyp            = nv_abentyp        
fi_bennam            = nv_abennam        
fi_payper            = nv_apayper        
fi_sum               = nv_asum           
fi_net-2             = nv_anet-2         
fi_net-3             = nv_anet-3         
fi_net               = nv_anet           
fi_net-4             = nv_anet-4         
fi_net-5             = nv_anet-5         
fi_net-7             = nv_anet-7         
fi_net-9             = nv_anet-9         
fi_net-10            = nv_anet-10        
fi_net-8             = nv_anet-8         
fi_net-11            = nv_anet-11        
fi_net-12            = nv_anet-12        
fi_net-13            = nv_anet-13        
fi_net-15            = nv_anet-15        
fi_net-16            = nv_anet-16        
fi_net-14            = nv_anet-14        
fi_net-17            = nv_anet-17        
fi_net-18            = nv_anet-18        
fi_net-19            = nv_anet-19      
fi_remark            = nv_aremark        
fi_lpro              = nv_alpro          
fi_loanc             = nv_aloanc         
fi_lprod             = nv_alprod         
fi_lapp              = nv_alapp          
fi_lbook             = nv_albook         
fi_lcre              = nv_alcre          
fi_lst               = nv_alst           
fi_lamt              = nv_alamt          
fi_li                = nv_ali            
fi_lr                = nv_alr            
fi_lfd               = nv_alfd           
fi_deal              = nv_adeal          
fi_notno             = nv_anotno         
fi_notdat            = nv_anotdat        
fi_nottim            = nv_anottim    .
 DISPLAY fi_haddr1 fi_haddr2 fi_haddr3 fi_haddr4 fi_haddr5 fi_hfloor fi_hroom 
          fi_hno fi_hmoo fi_hvil fi_soi fi_street fi_district fi_hsubdis 
          fi_hprov fi_hcountry fi_hzip fi_contact fi_contel fi_bentyp fi_bennam 
          fi_payper fi_sum fi_net-2 fi_net-3 fi_net fi_net-4 fi_net-5 fi_net-7 
          fi_net-9 fi_net-10 fi_net-8 fi_net-11 fi_net-12 fi_net-13 fi_net-15 
          fi_net-16 fi_net-14 fi_net-17 fi_net-18 fi_net-19 fi_remark fi_lpro 
          fi_loanc fi_lprod fi_lapp fi_lbook fi_lcre fi_lst fi_lamt fi_li fi_lr 
          fi_lfd fi_deal fi_notno fi_notdat fi_nottim 
      WITH FRAME Dialog-Frame.
 ENABLE  fi_haddr1 fi_haddr2 fi_haddr3 fi_haddr4 fi_haddr5 fi_hfloor fi_hroom 
          fi_hno fi_hmoo fi_hvil fi_soi fi_street fi_district fi_hsubdis 
          fi_hprov fi_hcountry fi_hzip fi_contact fi_contel fi_bentyp fi_bennam 
          fi_payper fi_sum fi_net-2 fi_net-3 fi_net fi_net-4 fi_net-5 fi_net-7 
          fi_net-9 fi_net-10 fi_net-8 fi_net-11 fi_net-12 fi_net-13 fi_net-15 
          fi_net-16 fi_net-14 fi_net-17 fi_net-18 fi_net-19 fi_remark fi_lpro 
          fi_loanc fi_lprod fi_lapp fi_lbook fi_lcre fi_lst fi_lamt fi_li fi_lr 
          fi_lfd fi_deal fi_notno fi_notdat fi_nottim 
      WITH FRAME Dialog-Frame.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

