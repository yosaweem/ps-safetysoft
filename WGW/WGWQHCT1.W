&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v8r12 GUI
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
/*          This .W file was created with the Progress UIB.             */
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
/*++++++++++++++++++++++++++++++++++++++++++++++
  WGWQHCT1.w :  Quey & Update data notify Add in table  tlt  
  Create  by    : Kridtiya I. A64-0414 Date 27/11/2021
  Connect :  gw_stat ld brstat , gw_safe ld sic_bran ,sic_test ld sicuw sicsyac :not connect stat
+++++++++++++++++++++++++++++++++++++++++++++++*/
Def  Input  parameter  nv_recidtlt  as  recid  .
Def  var nv_index  as int  init 0.
DEF  VAR nv_chaidrep AS CHAR .  
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.
Def  Var chDocument      As Com-Handle.
Def  Var chNotesView     As Com-Handle .
Def  Var chNavView       As Com-Handle .
Def  Var chViewEntry     As Com-Handle .
Def  Var chItem          As Com-Handle .
Def  Var chData          As Com-Handle .
Def  Var nv_server       As Char.
Def  Var nv_tmp          As char .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_detail2 bu_save bu_exit bu_detail1 ~
fi_covcod fi_covtype fi_garage fi_crateby fi_insnamef fi_insnamem fi_addrno ~
fi_road fi_tambon fi_amper fi_occup fi_brithday fi_sumins fi_premt fi_stamp ~
fi_ncbper fi_ncbamt fi_prepol fi_flagnodri fi_dri1title fi_dri1icno ~
fi_saletype fi_campaigntype fi_notifyno fi_province fi_brand fi_group ~
fi_cha_no fi_caryear fi_model fi_carnametype fi_vehuse fi_seat fi_tons ~
fi_vehreg2 fi_vehreg fi_regisyear fi_companycd fi_cartype fi_trandat ~
fi_user fi_time fi_contractdat fi_comdat fi_userup fi_contract fi_payment ~
fi_title fi_dri1licen fi_expdat fi_insnamel fi_post fi_icno fi_licenno ~
fi_eng_no fi_body fi_cartypecd fi_color fi_remark fi_tax fi_nettotle ~
fi_sumtotle fi_stkno fi_flagdri fi_dri1fname fi_dri1mname fi_dri1lname ~
fi_dri1occup fi_dri1brithday fi_dri2title fi_dri2fname fi_dri2mname ~
fi_dri2lname fi_dri2occup fi_dri2brithday fi_dri2icno fi_dri2licen fi_ben ~
bu_detail-3 RECT-462 RECT-464 RECT-465 RECT-502 
&Scoped-Define DISPLAYED-OBJECTS fi_covcod fi_covtype fi_garage fi_crateby ~
fi_insnamef fi_insnamem fi_addrno fi_road fi_tambon fi_amper fi_occup ~
fi_brithday fi_sumins fi_premt fi_stamp fi_ncbper fi_ncbamt fi_prepol ~
fi_flagnodri fi_dri1title fi_dri1icno fi_saletype fi_campaigntype ~
fi_notifyno fi_province fi_brand fi_group fi_cha_no fi_caryear fi_model ~
fi_carnametype fi_vehuse fi_seat fi_tons fi_vehreg2 fi_vehreg fi_regisyear ~
fi_companycd fi_cartype fi_trandat fi_user fi_time fi_contractdat fi_comdat ~
fi_userup fi_contract fi_payment fi_title fi_dri1licen fi_expdat ~
fi_insnamel fi_post fi_icno fi_licenno fi_eng_no fi_body fi_cartypecd ~
fi_color fi_remark fi_tax fi_nettotle fi_sumtotle fi_stkno fi_flagdri ~
fi_dri1fname fi_dri1mname fi_dri1lname fi_dri1occup fi_dri1brithday ~
fi_dri2title fi_dri2fname fi_dri2mname fi_dri2lname fi_dri2occup ~
fi_dri2brithday fi_dri2icno fi_dri2licen fi_ben 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON bu_detail-3 
     LABEL "หน้า3" 
     SIZE 12 BY 1.52
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_detail1 
     LABEL "หน้า1" 
     SIZE 12 BY 1.52
     BGCOLOR 7 FGCOLOR 2 FONT 6.

DEFINE BUTTON bu_detail2 
     LABEL "หน้า2" 
     SIZE 12 BY 1.52
     BGCOLOR 10 FGCOLOR 1 FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "Exit" 
     SIZE 8 BY 1
     BGCOLOR 6 FONT 6.

DEFINE BUTTON bu_save 
     LABEL "Save" 
     SIZE 7.83 BY 1
     BGCOLOR 2 FGCOLOR 15 FONT 6.

DEFINE VARIABLE fi_addrno AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_amper AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ben AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 109.5 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_body AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brand AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brithday AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_campaigntype AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_carnametype AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cartype AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cartypecd AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_caryear AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_cha_no AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_color AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_comdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_companycd AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_contract AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_contractdat AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_covcod AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_covtype AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_crateby AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 53 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dri1brithday AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri1fname AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri1icno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri1licen AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri1lname AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 34 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri1mname AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri1occup AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri1title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2brithday AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2fname AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2icno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 22.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2licen AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2lname AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2mname AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2occup AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_dri2title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_eng_no AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_flagdri AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.67 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_flagnodri AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_group AS CHARACTER FORMAT "X(1)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insnamef AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insnamel AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_insnamem AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_licenno AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_model AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_ncbamt AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ncbper AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_nettotle AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_notifyno AS CHARACTER FORMAT "X(35)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15 FGCOLOR 2 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_payment AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_post AS CHARACTER FORMAT "X(5)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_premt AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_prepol AS CHARACTER FORMAT "X(32)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_province AS CHARACTER FORMAT "X(30)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_regisyear AS CHARACTER FORMAT "X(4)":U 
     VIEW-AS FILL-IN 
     SIZE 5.33 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark AS CHARACTER FORMAT "X(512)":U 
     VIEW-AS FILL-IN 
     SIZE 117.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_road AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_saletype AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 4 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_seat AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_stamp AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_stkno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_sumins AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_sumtotle AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tambon AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tax AS CHARACTER FORMAT "X(14)":U 
     VIEW-AS FILL-IN 
     SIZE 15.5 BY 1
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_time AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .91
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_title AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tons AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_trandat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .91
     BGCOLOR 8 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_user AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY .91
     BGCOLOR 8 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_userup AS CHARACTER FORMAT "X(13)":U 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_vehreg AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_vehreg2 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 11.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_vehuse AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE RECTANGLE RECT-462
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 131.5 BY 22
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-464
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130 BY 9.19
     BGCOLOR 19 FGCOLOR 12 .

DEFINE RECTANGLE RECT-465
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 130 BY 8.52
     BGCOLOR 19 FGCOLOR 12 .

DEFINE RECTANGLE RECT-502
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 21 BY 1.52
     BGCOLOR 21 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     bu_detail2 AT ROW 1.14 COL 13.67
     bu_save AT ROW 1.38 COL 113.67
     bu_exit AT ROW 1.38 COL 122.83
     bu_detail1 AT ROW 1.14 COL 1.5
     fi_covcod AT ROW 5.05 COL 17.83 COLON-ALIGNED NO-LABEL
     fi_covtype AT ROW 5.05 COL 35.5 COLON-ALIGNED NO-LABEL
     fi_garage AT ROW 5.05 COL 59.33 COLON-ALIGNED NO-LABEL
     fi_crateby AT ROW 5.05 COL 76.33 COLON-ALIGNED NO-LABEL
     fi_insnamef AT ROW 6.95 COL 36.83 COLON-ALIGNED NO-LABEL
     fi_insnamem AT ROW 6.95 COL 69.33 COLON-ALIGNED NO-LABEL
     fi_addrno AT ROW 8.05 COL 12 COLON-ALIGNED NO-LABEL
     fi_road AT ROW 8.05 COL 37.83 COLON-ALIGNED NO-LABEL
     fi_tambon AT ROW 8.05 COL 58 COLON-ALIGNED NO-LABEL
     fi_amper AT ROW 8.05 COL 81.33 COLON-ALIGNED NO-LABEL
     fi_occup AT ROW 9.14 COL 12 COLON-ALIGNED NO-LABEL
     fi_brithday AT ROW 9.14 COL 46.33 COLON-ALIGNED NO-LABEL
     fi_sumins AT ROW 15.24 COL 15 COLON-ALIGNED NO-LABEL
     fi_premt AT ROW 15.24 COL 40.83 COLON-ALIGNED NO-LABEL
     fi_stamp AT ROW 15.24 COL 62 COLON-ALIGNED NO-LABEL
     fi_ncbper AT ROW 16.33 COL 52.5 COLON-ALIGNED NO-LABEL
     fi_ncbamt AT ROW 16.33 COL 81.83 COLON-ALIGNED NO-LABEL
     fi_prepol AT ROW 17.43 COL 19.5 COLON-ALIGNED NO-LABEL
     fi_flagnodri AT ROW 17.48 COL 72 COLON-ALIGNED NO-LABEL
     fi_dri1title AT ROW 18.52 COL 19.5 COLON-ALIGNED NO-LABEL
     fi_dri1icno AT ROW 19.67 COL 78 COLON-ALIGNED NO-LABEL
     fi_saletype AT ROW 3.95 COL 50.17 COLON-ALIGNED NO-LABEL
     fi_campaigntype AT ROW 3.95 COL 71.5 COLON-ALIGNED NO-LABEL
     fi_notifyno AT ROW 2.81 COL 65.5 COLON-ALIGNED NO-LABEL
     fi_province AT ROW 8.05 COL 105.67 COLON-ALIGNED NO-LABEL
     fi_brand AT ROW 10.24 COL 12 COLON-ALIGNED NO-LABEL
     fi_group AT ROW 10.24 COL 42.83 COLON-ALIGNED NO-LABEL
     fi_cha_no AT ROW 10.24 COL 61.67 COLON-ALIGNED NO-LABEL
     fi_caryear AT ROW 11.33 COL 42.83 COLON-ALIGNED NO-LABEL
     fi_model AT ROW 11.33 COL 12 COLON-ALIGNED NO-LABEL
     fi_carnametype AT ROW 11.33 COL 61.83 COLON-ALIGNED NO-LABEL
     fi_vehuse AT ROW 12.43 COL 12 COLON-ALIGNED NO-LABEL
     fi_seat AT ROW 12.43 COL 25.33 COLON-ALIGNED NO-LABEL
     fi_tons AT ROW 12.43 COL 44.17 COLON-ALIGNED NO-LABEL
     fi_vehreg2 AT ROW 12.43 COL 110.33 COLON-ALIGNED NO-LABEL
     fi_vehreg AT ROW 12.43 COL 95.33 COLON-ALIGNED NO-LABEL
     fi_regisyear AT ROW 12.43 COL 124.33 COLON-ALIGNED NO-LABEL
     fi_companycd AT ROW 3.95 COL 12 COLON-ALIGNED NO-LABEL
     fi_cartype AT ROW 3.95 COL 30.5 COLON-ALIGNED NO-LABEL
     fi_trandat AT ROW 1.38 COL 48.17 COLON-ALIGNED NO-LABEL
     fi_user AT ROW 1.38 COL 81.5 COLON-ALIGNED NO-LABEL
     fi_time AT ROW 1.38 COL 66 COLON-ALIGNED NO-LABEL
     fi_contractdat AT ROW 2.81 COL 41.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_comdat AT ROW 2.81 COL 94.33 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_userup AT ROW 1.38 COL 99.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_contract AT ROW 2.81 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 14
     fi_payment AT ROW 3.95 COL 111.33 COLON-ALIGNED NO-LABEL WIDGET-ID 18
     fi_title AT ROW 6.95 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_dri1licen AT ROW 19.57 COL 109 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_expdat AT ROW 2.81 COL 116.33 COLON-ALIGNED NO-LABEL WIDGET-ID 32
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     fi_insnamel AT ROW 6.95 COL 94.67 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_post AT ROW 8.05 COL 122.67 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_icno AT ROW 9.14 COL 76.83 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_licenno AT ROW 9.14 COL 106.67 COLON-ALIGNED NO-LABEL WIDGET-ID 48
     fi_eng_no AT ROW 10.24 COL 106.67 COLON-ALIGNED NO-LABEL WIDGET-ID 52
     fi_body AT ROW 11.33 COL 87.17 COLON-ALIGNED NO-LABEL WIDGET-ID 56
     fi_cartypecd AT ROW 11.33 COL 125.67 COLON-ALIGNED NO-LABEL WIDGET-ID 60
     fi_color AT ROW 12.43 COL 57.5 COLON-ALIGNED NO-LABEL WIDGET-ID 64
     fi_remark AT ROW 13.57 COL 12 COLON-ALIGNED NO-LABEL WIDGET-ID 68
     fi_tax AT ROW 15.24 COL 83.17 COLON-ALIGNED NO-LABEL WIDGET-ID 72
     fi_nettotle AT ROW 15.24 COL 114.17 COLON-ALIGNED NO-LABEL WIDGET-ID 76
     fi_sumtotle AT ROW 16.33 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 80
     fi_stkno AT ROW 16.33 COL 109.67 COLON-ALIGNED NO-LABEL WIDGET-ID 84
     fi_flagdri AT ROW 17.43 COL 52 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_dri1fname AT ROW 18.52 COL 33 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     fi_dri1mname AT ROW 18.52 COL 68 COLON-ALIGNED NO-LABEL WIDGET-ID 96
     fi_dri1lname AT ROW 18.52 COL 95.67 COLON-ALIGNED NO-LABEL WIDGET-ID 100
     fi_dri1occup AT ROW 19.62 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 104
     fi_dri1brithday AT ROW 19.67 COL 53 COLON-ALIGNED NO-LABEL WIDGET-ID 108
     fi_dri2title AT ROW 20.76 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 112
     fi_dri2fname AT ROW 20.76 COL 33 COLON-ALIGNED NO-LABEL WIDGET-ID 116
     fi_dri2mname AT ROW 20.76 COL 68 COLON-ALIGNED NO-LABEL WIDGET-ID 120
     fi_dri2lname AT ROW 20.76 COL 96.5 COLON-ALIGNED NO-LABEL WIDGET-ID 124
     fi_dri2occup AT ROW 21.86 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 128
     fi_dri2brithday AT ROW 21.86 COL 52.5 COLON-ALIGNED NO-LABEL WIDGET-ID 132
     fi_dri2icno AT ROW 21.86 COL 78 COLON-ALIGNED NO-LABEL WIDGET-ID 136
     fi_dri2licen AT ROW 21.86 COL 109 COLON-ALIGNED NO-LABEL WIDGET-ID 140
     fi_ben AT ROW 22.95 COL 19.5 COLON-ALIGNED NO-LABEL WIDGET-ID 144
     bu_detail-3 AT ROW 1.14 COL 26 WIDGET-ID 152
     "จำนวนที่นั่ง" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 12.43 COL 17.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "คำนำหน้า" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 6.95 COL 3.5 WIDGET-ID 26
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ที่อยู่" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 8.05 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "Comdate:" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 2.81 COL 88 WIDGET-ID 8
          BGCOLOR 18 FGCOLOR 7 FONT 1
     "ชื่อกลาง" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 20.76 COL 61 WIDGET-ID 122
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อลูกค้า" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 6.95 COL 32
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ถนน" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 8.05 COL 35.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "จังหวัด" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 12.43 COL 106.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ประเภทความคุ้มครอง" VIEW-AS TEXT
          SIZE 17 BY .91 AT ROW 5.05 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยประกัน" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 15.24 COL 33.33
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ปี" VIEW-AS TEXT
          SIZE 1.5 BY .91 AT ROW 12.43 COL 124.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อากร" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 15.24 COL 59.17
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "คำนำหน้า" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 18.52 COL 12.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เวลา:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 1.38 COL 63.5
          FGCOLOR 7 FONT 1
     "ใบขับขี่" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 19.62 COL 103.67 WIDGET-ID 30
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "วันเกิด" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 9.14 COL 41.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่รับแจ้ง" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 2.81 COL 56.83
          BGCOLOR 18 FGCOLOR 7 
     "ผู้บันทึก" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 5.05 COL 70.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "นามสกุล" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 20.76 COL 89 WIDGET-ID 126
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "Update :" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 1.38 COL 92.67 WIDGET-ID 12
          FGCOLOR 15 FONT 6
     "ชื่อกลาง" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 6.95 COL 64.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "วันที่ใบคำขอ" VIEW-AS TEXT
          SIZE 10.17 BY .91 AT ROW 2.81 COL 32.5 WIDGET-ID 4
          BGCOLOR 18 FGCOLOR 7 FONT 1
     "User:" VIEW-AS TEXT
          SIZE 5.33 BY .91 AT ROW 1.38 COL 78
          FGCOLOR 7 FONT 6
     "วงเงินทุนประกัน" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 15.24 COL 3.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เลขที่บัตร" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 19.67 COL 71.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ประเภทประกัน" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 5.05 COL 24.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ปริมาตรกระบอกสูบ" VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 12.43 COL 30.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ผู้รับผลประโยชน์" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 22.76 COL 6.5 WIDGET-ID 146
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "รหัสการใช้" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 12.43 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อประเภทรถ" VIEW-AS TEXT
          SIZE 10.5 BY .91 AT ROW 11.33 COL 51.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทรถ" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 3.95 COL 22.83
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Expdate:" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 2.81 COL 109.83 WIDGET-ID 34
          BGCOLOR 18 FGCOLOR 7 FONT 1
     "อาชีพ" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 21.86 COL 15 WIDGET-ID 130
          BGCOLOR 19 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "ทะเบียน" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 12.43 COL 90.17
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ส่วนลดประวัติดี" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 16.33 COL 71
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ประเภทการขาย" VIEW-AS TEXT
          SIZE 13.5 BY .91 AT ROW 3.95 COL 38
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "นามสกุล" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 6.95 COL 89.17 WIDGET-ID 38
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่บัตรประชาชน" VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 9.14 COL 63.17 WIDGET-ID 46
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่ใบขับขี่" VIEW-AS TEXT
          SIZE 9.5 BY .91 AT ROW 9.14 COL 97.83 WIDGET-ID 50
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ชื่อรุ่นรถ" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 11.33 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "หมายเลขเครื่อง" VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 10.24 COL 94.83 WIDGET-ID 54
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "แบบตัวถัง" VIEW-AS TEXT
          SIZE 8 BY .91 AT ROW 11.33 COL 80.67 WIDGET-ID 58
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทการซ่อม" VIEW-AS TEXT
          SIZE 12.5 BY .91 AT ROW 5.05 COL 48.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสประเภทรถ" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 11.33 COL 115 WIDGET-ID 62
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่ใบคำขอ" VIEW-AS TEXT
          SIZE 11 BY .91 AT ROW 2.81 COL 2.5 WIDGET-ID 16
          BGCOLOR 18 FGCOLOR 7 FONT 1
     "ชื่อสีรถ" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 12.43 COL 53.67 WIDGET-ID 66
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "หมายเหตุ" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 13.62 COL 3.5 WIDGET-ID 70
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัสบริษัท" VIEW-AS TEXT
          SIZE 10.83 BY .91 AT ROW 3.95 COL 2.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "วันเกิด" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 21.86 COL 47.5 WIDGET-ID 134
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ภาษี" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 15.24 COL 80.67 WIDGET-ID 74
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "กลุ่มรถยนต์" VIEW-AS TEXT
          SIZE 9 BY .91 AT ROW 10.24 COL 34.83
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อาชีพ" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 9.14 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เบี้ยประกันรวม" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 15.24 COL 103.5 WIDGET-ID 78
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เบี้ยประกันรวมทั้งหมด" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 16.33 COL 3.5 WIDGET-ID 82
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เลขสติ๊กเกอร์" VIEW-AS TEXT
          SIZE 11.17 BY .91 AT ROW 16.33 COL 100 WIDGET-ID 86
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "  ข้อมูลลูกค้า" VIEW-AS TEXT
          SIZE 12.17 BY .91 AT ROW 6.05 COL 5.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "Flag ระบุชื่อ" VIEW-AS TEXT
          SIZE 10 BY .91 AT ROW 17.48 COL 42.5 WIDGET-ID 90
          BGCOLOR 19 FGCOLOR 0 FONT 1
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 31 FGCOLOR 2 .

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Flag ไม่ระบุชื่อ" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 17.52 COL 59.5
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อ" VIEW-AS TEXT
          SIZE 2.5 BY .91 AT ROW 18.52 COL 32.17 WIDGET-ID 94
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อกลาง" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 18.52 COL 63 WIDGET-ID 98
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ยี่ห้อรถ" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 10.24 COL 3.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "นามสกุล" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 18.52 COL 89.33 WIDGET-ID 102
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "อาชีพ" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 19.48 COL 15.5 WIDGET-ID 106
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ชื่อ" VIEW-AS TEXT
          SIZE 3 BY .91 AT ROW 20.76 COL 31.67 WIDGET-ID 118
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "เลขที่บัตร" VIEW-AS TEXT
          SIZE 7.5 BY .91 AT ROW 21.86 COL 71 WIDGET-ID 138
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "วันเกิด" VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 19.67 COL 48 WIDGET-ID 110
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "จำนวนเงินที่เรียกเก็บ" VIEW-AS TEXT
          SIZE 18 BY .91 AT ROW 3.95 COL 94.33 WIDGET-ID 20
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "คำนำหน้า" VIEW-AS TEXT
          SIZE 8.5 BY .91 AT ROW 20.76 COL 12.5 WIDGET-ID 114
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "จังหวัด" VIEW-AS TEXT
          SIZE 5.5 BY .91 AT ROW 8.05 COL 101.67 WIDGET-ID 148
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "รหัส" VIEW-AS TEXT
          SIZE 3.5 BY .91 AT ROW 8.05 COL 121 WIDGET-ID 150
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ใบขับขี่" VIEW-AS TEXT
          SIZE 6.5 BY .91 AT ROW 21.86 COL 103.5 WIDGET-ID 142
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "วันที่โหลดงาน:" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 1.38 COL 38.33
          FGCOLOR 7 FONT 1
     "รุ่นปี" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 11.33 COL 39.67
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "ประเภทแคมเปญ" VIEW-AS TEXT
          SIZE 14 BY .91 AT ROW 3.95 COL 57.5
          BGCOLOR 19 FGCOLOR 2 FONT 6
     "หมายเลขตัวถัง" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 10.24 COL 51.5
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "เลขที่กรมธรรมเดิม" VIEW-AS TEXT
          SIZE 15 BY .91 AT ROW 17.57 COL 4
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "อัตราส่วนลดประวัติดี" VIEW-AS TEXT
          SIZE 16 BY .91 AT ROW 16.33 COL 37.83
          BGCOLOR 19 FGCOLOR 0 FONT 1
     "ตำบล" VIEW-AS TEXT
          SIZE 4 BY .91 AT ROW 8.05 COL 55.33
          BGCOLOR 19 FGCOLOR 2 FONT 1
     "อำเภอ" VIEW-AS TEXT
          SIZE 5 BY .91 AT ROW 8.05 COL 78
          BGCOLOR 19 FGCOLOR 2 FONT 1
     RECT-462 AT ROW 2.57 COL 1.5
     RECT-464 AT ROW 15 COL 2.5
     RECT-465 AT ROW 6.33 COL 2.5
     RECT-502 AT ROW 1 COL 111.83 WIDGET-ID 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1.17 ROW 1.05
         SIZE 133 BY 24
         BGCOLOR 31 FGCOLOR 2 .


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
         TITLE              = "Update Data Notify HCT"
         HEIGHT             = 24.14
         WIDTH              = 133.17
         MAX-HEIGHT         = 29.05
         MAX-WIDTH          = 151.17
         VIRTUAL-HEIGHT     = 29.05
         VIRTUAL-WIDTH      = 151.17
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
IF NOT C-Win:LOAD-ICON("wimage\safety":U) THEN
    MESSAGE "Unable to load icon: wimage\safety"
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
ASSIGN 
       fi_comdat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_contract:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_expdat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_payment:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_time:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_trandat:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_user:READ-ONLY IN FRAME fr_main        = TRUE.

ASSIGN 
       fi_userup:READ-ONLY IN FRAME fr_main        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* Update Data Notify HCT */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* Update Data Notify HCT */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_detail-3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail-3 C-Win
ON CHOOSE OF bu_detail-3 IN FRAME fr_main /* หน้า3 */
DO:
    /*Get Current br_tlt.*/
        nv_recidtlt  =  Recid(tlt).

        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\WGWQHCT3(Input  nv_recidtlt).
        Apply "Close"  To this-procedure.
        RETURN NO-APPLY.
        
        {&WINDOW-NAME}:hidden  =  No. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_detail2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_detail2 C-Win
ON CHOOSE OF bu_detail2 IN FRAME fr_main /* หน้า2 */
DO:
    /*Get Current br_tlt.*/
        nv_recidtlt  =  Recid(tlt).

        {&WINDOW-NAME}:hidden  =  Yes. 
        
        Run  wgw\WGWQHCT2(Input  nv_recidtlt).
        Apply "Close"  To this-procedure.
        RETURN NO-APPLY.
        
        {&WINDOW-NAME}:hidden  =  No. 
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* Exit */
DO:
  Apply "Close"  To this-procedure.
  Return no-apply.
 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_save
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_save C-Win
ON CHOOSE OF bu_save IN FRAME fr_main /* Save */
DO:
    /*
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN /* Yes */ 
            DO: 
            Find  brstat.tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  brstat.tlt Then do:
                ASSIGN 
                    brstat.tlt.policy        = trim(input fi_polno)      /*เบอร์กรม */       
                    brstat.tlt.recac         = trim(input fi_agent)      /*Agent code */
                    brstat.tlt.subins        = trim(input fi_producer)   /*Producer */
                    brstat.tlt.nor_noti_ins  = trim(input fi_refno)      /*เลขอ้างอิง*/
                    brstat.tlt.nor_usr_ins   = trim(input fi_custcode)   /*รหัสลูกค้า */
                    brstat.tlt.lotno         = "InsCode:" + trim(fi_comcod)  + " " +    /*รหัสบริษัทประกันภัย */                                             
                                              /* "InsName:" + trim(fi_comnam)  + " " + */   /*ชื่อบริษัทประกันภัย */                                             
                                               "CamCode:" + trim(fi_camp)    + " " +    /*รหัสแคมเปญ    */                                                   
                                               "CamName:" + trim(fi_campnam)            /*ชื่อแคมเปญ    */                                                   
                    brstat.tlt.usrsent       = /*"ProCode:" + trim(fi_produc) + " " + */    /*รหัสผลิตภัณฑ์ */                                                  
                                               "ProName:" + trim(fi_producnam) + " " +   /*ชื่อผลิตภัณฑ์ */                                                  
                                               /*"PackNam:" + trim(fi_pacgnam) + " " +  */  /*ชื่อแพคเกจ    */                                                  
                                              "PackCod:" + trim(fi_produc)        /*รหัสแพคเกจ    */                                                  
                    brstat.tlt.imp           = /*"TYP:" + TRIM(fi_custtyp) + " " + */       /*ประเภท        */ 
                                               "Pol:" + TRIM(fi_oldpol)                 /*เบอร์เดิม */
                    brstat.tlt.ins_name      = "NameTha:" + trim(fi_nameth)  + " "      /*ชื่อผู้เอาประกัน  */                                               
                                                          + trim(fi_surth)              /*นามสกุลผู้เอาประกัน */                                               
                                              /* "NameEng:" + trim(fi_nameeng) + " "      /*ชื่อภาษา อังกฤษ   */                                         
                                                          + trim(fi_sureng)    */         /*นามสกุลภาษา อังกฤษ*/                                         
                    brstat.tlt.rec_addr5     = "ICNo:"  + trim(fi_icno)  + " " +        /*เลขที่บัตรประชาชน/เลขที่ผูเสียภาษี   */                           
                                               "Sex:"   + trim(fi_sex)   + " " +        /*เพศ                          */                                   
                                               "Birth:" + trim(STRING(fi_polbdate),"99/99/9999")    /*วันเดือนปีเกิด ( DD/MM/YYYY) */                                   
                                               /*"Occup:" + trim(fi_polocc)   */             /*อาชีพ  */                                   
                    brstat.tlt.ins_addr5     = "Phone:" + TRIM(fi_poltel)         /*เบอร์โทร */
                                              /* "Email:" + TRIM(fi_mail)   + " " +        /*email   */                                    
                                               "Linid:" + TRIM(fi_line)  */                /*Line_ID */                                    
                   /* brstat.tlt.ins_addr1     = trim(fi_poladdr1)                         /*ที่อยูลูกค้า*/                                                   
                    brstat.tlt.ins_addr2     = trim(fi_poladdr2)  */                                             
                    brstat.tlt.ins_addr3     = trim(fi_senaddr1)                         /*ที่อยูจัดส่ง*/ 
                    brstat.tlt.ins_addr4     = trim(fi_senaddr2)                         
                    /*brstat.tlt.exp           = "PayTyp:" + TRIM(fi_paytyp) + " " +       /*ประเภท ผู้จ่ายเงิน*/                       
                                               "Branch:" + TRIM(fi_branch) */              /*สาขา*/                                        
                    brstat.tlt.rec_name      = trim(fi_paynam) + " " + trim(fi_paysur)   /* ชื่อ - สกุล ผู้จ่ายเงิน*/   
                    brstat.tlt.comp_sub      = trim(fi_payic)                            /* เลขบัตร ปปช. ผู้จ่ายเงิน*/  
                    brstat.tlt.rec_addr1     = trim(fi_payaddr1)                         /*ที่อยู่ออกใบเสร็จ */                                            
                    brstat.tlt.rec_addr2     = trim(fi_payaddr2)                         
                    brstat.tlt.safe1         = trim(fi_bennam)                           /*ชื่อ - สกุล ผู้รับผลประโยชน์*/ 
                    brstat.tlt.safe2         = /*"PaymentMD:"   + trim(fi_paymcod) + " " +*/  /*รหัสประเภทการชำระเบี้ยประกัน*/                                      
                                               "PaymentMDTy:" + TRIM(fi_paymtyp) + " " + /*ประเภทการชำระเบี้ยประกัน    */                                   
                                               /*"PaymentTyCd:" + trim(fi_payway)  + " " +*/ /*รหัสช่องทางที่ชำระเบี้ย*/                                        
                                               "Paymentty:"   + trim(fi_waytyp)          /*ช่องทางที่ชำระค่าเบี้ย */                                        
                    /*brstat.tlt.safe3         = TRIM(fi_bank)    */                         /*ธนาคารที่ชำระเบี้ย*/                                                
                    /*brstat.tlt.rec_addr4     = "Paydat:" + trim(string(fi_paydat),"99/99/9999") + " " +       /*วันที่ชำระค่าเบี้ย*/                                                
                                               "PaySts:" + trim(fi_paysts )  + " " +    /*สถานะการชำระเบี้ย */                                                
                                               "Paid:"   + trim(fi_paidsts) */            /*สถานะการจ่ายเงิน*/                                                  
                    brstat.tlt.datesent      = date(fi_saledat)                         /*วันที่ขาย       */                                                  
                    brstat.tlt.dat_ins_noti  = date(fi_payin)                          /*วันที่รับชำระเงิน */                                                
                    brstat.tlt.endcnt        = INT(fi_driver)                           /*การระบุชื่อผู้ขับ */                                                     
                    brstat.tlt.dri_name1     = "Drinam1:" + trim(input fi_drinam1)  + " " +   /*ชื่อผู้ขับขี่ 1 */                                            
                                                            trim(input fi_drisur1) + " " +    /*นามสกุล ผู้ขับขี่ 1   */                                       
                                               "DriId1:"  + trim(input fi_driid1)             /*เลขที่บัตรผู้ขับขี่ 1 */                                     
                    brstat.tlt.dri_no1       = "DriOcc1:" + trim(input fi_driocc1) + " " +    /*Driver1Occupation  */                                            
                                               "DriSex1:" + TRIM(input fi_drisex1) + " " +  /*เพศ ผู้ขับขี่ 1 */                                          
                                               "DriBir1:" + trim(STRING(fi_dridate1),"99/99/9999")     /*วันเดือนปีเกิดผู้ขับขี่ 1 */                        
                    brstat.tlt.dri_name2     = "Drinam2:" + trim(input fi_drinam2)  + " " +   /*ชื่อผู้ขับขี่2    */                                         
                                                            trim(input fi_drisur2) + " " +    /*นามสกุล ผู้ขับขี่ 2*/                                          
                                               "DriId2:"  + trim(input fi_driid2)             /*เลขที่บัตรผู้ขับขี่2 */                                      
                    brstat.tlt.dri_no2       = "DriOcc2:" + trim(input fi_driocc2) + " " +    /*Driver2Occupation  */                                            
                                               "DriSex2:" + TRIM(input fi_drisex2)   + " " +  /*เพศ ผู้ขับขี่2    */                                      
                                               "DriBir2:" + trim(STRING(fi_dridate2),"99/99/9999")     /*วันเดือนปีเกิดผู้ขับขี่ 2 */ 
                    brstat.tlt.usrid         = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/")) + USERID(LDBNAME(1)) 
                                               ELSE brstat.tlt.usrid + "/" + USERID(LDBNAME(1)) .
                    
                   
            END.                                                    
            Apply "Close" to this-procedure.
            Return no-apply.
            /* APPLY "entry" TO fi_branch.
            RETURN NO-APPLY. */
        END.
        WHEN FALSE THEN /* No */          
            DO:   
            APPLY "entry" TO fi_polno.
            RETURN NO-APPLY.
        END.
        /*OTHERWISE /* Cancel */             
        STOP.*/
        END CASE.
Disp  fi_polno with  frame  fr_main.
RELEASE brstat.tlt.
*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_amper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_amper C-Win
ON LEAVE OF fi_amper IN FRAME fr_main
DO:
   /* fi_poltel = INPUT fi_poltel .
    DISP fi_poltel WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ben
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ben C-Win
ON LEAVE OF fi_ben IN FRAME fr_main
DO:
   /* fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_body
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_body C-Win
ON LEAVE OF fi_body IN FRAME fr_main
DO:
    /*fi_dridate1 = INPUT fi_dridate1 .
    DISP fi_dridate1 WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brand
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brand C-Win
ON LEAVE OF fi_brand IN FRAME fr_main
DO:
  /*  fi_drinam1 = INPUT fi_drinam1 .
    DISP fi_drinam1 WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_brithday
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_brithday C-Win
ON LEAVE OF fi_brithday IN FRAME fr_main
DO:
   /* fi_senaddr2 = INPUT fi_senaddr2 .
    DISP fi_senaddr2 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_campaigntype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_campaigntype C-Win
ON LEAVE OF fi_campaigntype IN FRAME fr_main
DO:
    /*
    fi_custcode = INPUT fi_custcode .
    DISP fi_custcode WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_carnametype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_carnametype C-Win
ON LEAVE OF fi_carnametype IN FRAME fr_main
DO:
   /* fi_dridate1 = INPUT fi_dridate1 .
    DISP fi_dridate1 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cartype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cartype C-Win
ON LEAVE OF fi_cartype IN FRAME fr_main
DO:
   /* fi_agent = INPUT fi_agent .
    DISP fi_agent WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cartypecd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cartypecd C-Win
ON LEAVE OF fi_cartypecd IN FRAME fr_main
DO:
    /*
    fi_dridate1 = INPUT fi_dridate1 .
    DISP fi_dridate1 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_caryear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_caryear C-Win
ON LEAVE OF fi_caryear IN FRAME fr_main
DO:
  /*  fi_drisex1 = INPUT fi_drisex1 .
    DISP fi_drisex1 WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_cha_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_cha_no C-Win
ON LEAVE OF fi_cha_no IN FRAME fr_main
DO:
  /*  fi_driid1 = INPUT fi_driid1 .
    DISP fi_driid1 WITH FRAME fr_main.
    */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_color
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_color C-Win
ON LEAVE OF fi_color IN FRAME fr_main
DO:
 /*   fi_driid2 = INPUT fi_driid2 .
    DISP fi_driid2 WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_companycd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_companycd C-Win
ON LEAVE OF fi_companycd IN FRAME fr_main
DO:
  /*  fi_producer = INPUT fi_producer .
    DISP fi_producer WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_contract
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contract C-Win
ON LEAVE OF fi_contract IN FRAME fr_main
DO:
    fi_contract = INPUT fi_contract .
    DISP fi_contract WITH FRAME fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_contractdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_contractdat C-Win
ON LEAVE OF fi_contractdat IN FRAME fr_main
DO:
    /*
    fi_oldpol = INPUT fi_oldpol .
    DISP fi_oldpol WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covcod
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covcod C-Win
ON LEAVE OF fi_covcod IN FRAME fr_main
DO:
    /*
    fi_comcod = INPUT fi_comcod .
    DISP fi_comcod WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_covtype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_covtype C-Win
ON LEAVE OF fi_covtype IN FRAME fr_main
DO:
    /*
    fi_camp = INPUT fi_camp .
    DISP fi_camp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_crateby
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_crateby C-Win
ON LEAVE OF fi_crateby IN FRAME fr_main
DO:
    /*
    fi_producnam = INPUT fi_producnam .
    DISP fi_producnam WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1brithday
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1brithday C-Win
ON LEAVE OF fi_dri1brithday IN FRAME fr_main
DO:
    /*
    fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1fname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1fname C-Win
ON LEAVE OF fi_dri1fname IN FRAME fr_main
DO:
    /*
    fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1icno C-Win
ON LEAVE OF fi_dri1icno IN FRAME fr_main
DO:
    /*fi_saledat = INPUT fi_saledat .
    DISP fi_saledat WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1licen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1licen C-Win
ON LEAVE OF fi_dri1licen IN FRAME fr_main
DO:
    /*
    fi_payin = INPUT fi_payin .
    DISP fi_payin WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1lname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1lname C-Win
ON LEAVE OF fi_dri1lname IN FRAME fr_main
DO:
   /* fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1mname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1mname C-Win
ON LEAVE OF fi_dri1mname IN FRAME fr_main
DO:
    /*
    fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1occup C-Win
ON LEAVE OF fi_dri1occup IN FRAME fr_main
DO:
    
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri1title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri1title C-Win
ON LEAVE OF fi_dri1title IN FRAME fr_main
DO:
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2brithday
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2brithday C-Win
ON LEAVE OF fi_dri2brithday IN FRAME fr_main
DO:
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2fname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2fname C-Win
ON LEAVE OF fi_dri2fname IN FRAME fr_main
DO:
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2icno C-Win
ON LEAVE OF fi_dri2icno IN FRAME fr_main
DO:
    /*fi_saledat = INPUT fi_saledat .
    DISP fi_saledat WITH FRAME fr_main.
  */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2licen
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2licen C-Win
ON LEAVE OF fi_dri2licen IN FRAME fr_main
DO:
    /*fi_payin = INPUT fi_payin .
    DISP fi_payin WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2lname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2lname C-Win
ON LEAVE OF fi_dri2lname IN FRAME fr_main
DO:
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2mname
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2mname C-Win
ON LEAVE OF fi_dri2mname IN FRAME fr_main
DO:
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2occup C-Win
ON LEAVE OF fi_dri2occup IN FRAME fr_main
DO:
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dri2title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dri2title C-Win
ON LEAVE OF fi_dri2title IN FRAME fr_main
DO:
    
    /*fi_waytyp = INPUT fi_waytyp .
    DISP fi_waytyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_eng_no
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_eng_no C-Win
ON LEAVE OF fi_eng_no IN FRAME fr_main
DO:
    /*fi_driid1 = INPUT fi_driid1 .
    DISP fi_driid1 WITH FRAME fr_main.
    */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_flagdri
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_flagdri C-Win
ON LEAVE OF fi_flagdri IN FRAME fr_main
DO:
    /*
    fi_paymtyp = INPUT fi_paymtyp .
    DISP fi_paymtyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_flagnodri
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_flagnodri C-Win
ON LEAVE OF fi_flagnodri IN FRAME fr_main
DO:
    /*fi_paymtyp = INPUT fi_paymtyp .
    DISP fi_paymtyp WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_garage
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_garage C-Win
ON LEAVE OF fi_garage IN FRAME fr_main
DO:
    /*fi_campnam = INPUT fi_campnam .
    DISP fi_campnam WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_group
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_group C-Win
ON LEAVE OF fi_group IN FRAME fr_main
DO:
    /*fi_drisur1 = INPUT fi_drisur1 .
    DISP fi_drisur1 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_icno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_icno C-Win
ON LEAVE OF fi_icno IN FRAME fr_main
DO:
    /*fi_senaddr2 = INPUT fi_senaddr2 .
    DISP fi_senaddr2 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insnamef
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insnamef C-Win
ON LEAVE OF fi_insnamef IN FRAME fr_main
DO:
    /*fi_nameth = INPUT fi_nameth .
    DISP fi_nameth WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insnamel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insnamel C-Win
ON LEAVE OF fi_insnamel IN FRAME fr_main
DO:
    /*fi_surth = INPUT fi_surth .
    DISP fi_surth WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_insnamem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_insnamem C-Win
ON LEAVE OF fi_insnamem IN FRAME fr_main
DO:
    /*fi_surth = INPUT fi_surth .
    DISP fi_surth WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_licenno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_licenno C-Win
ON LEAVE OF fi_licenno IN FRAME fr_main
DO:
    /*fi_senaddr2 = INPUT fi_senaddr2 .
    DISP fi_senaddr2 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_model
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_model C-Win
ON LEAVE OF fi_model IN FRAME fr_main
DO:
    /*fi_driocc1 = INPUT fi_driocc1 .
    DISP fi_driocc1 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ncbamt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncbamt C-Win
ON LEAVE OF fi_ncbamt IN FRAME fr_main
DO:
    /*fi_payaddr2 = INPUT fi_payaddr2 .
    DISP fi_payaddr2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ncbper
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ncbper C-Win
ON LEAVE OF fi_ncbper IN FRAME fr_main
DO:
    /*fi_payaddr1 = INPUT fi_payaddr1 .
    DISP fi_payaddr1 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nettotle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nettotle C-Win
ON LEAVE OF fi_nettotle IN FRAME fr_main
DO:
    /*fi_payic = INPUT fi_payic .
    DISP fi_payic WITH FRAME fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notifyno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notifyno C-Win
ON LEAVE OF fi_notifyno IN FRAME fr_main
DO:
    /*fi_polno = INPUT fi_polno .
    DISP fi_polno WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_occup
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_occup C-Win
ON LEAVE OF fi_occup IN FRAME fr_main
DO:
    /*fi_senaddr1 = INPUT fi_senaddr1 .
    DISP fi_senaddr1 WITH FRAME fr_main.
    */
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_payment
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_payment C-Win
ON LEAVE OF fi_payment IN FRAME fr_main
DO:
    /*fi_bray = INPUT fi_bray .
    DISP fi_bray WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_post
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_post C-Win
ON LEAVE OF fi_post IN FRAME fr_main
DO:
   /* fi_driver = INPUT fi_driver .
    DISP fi_driver WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_premt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_premt C-Win
ON LEAVE OF fi_premt IN FRAME fr_main
DO:
   /* fi_paysur = INPUT fi_paysur .
    DISP fi_paysur WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prepol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prepol C-Win
ON LEAVE OF fi_prepol IN FRAME fr_main
DO:
   /* fi_bennam = INPUT fi_bennam .
    DISP fi_bennam WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_province
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_province C-Win
ON LEAVE OF fi_province IN FRAME fr_main
DO:
    /*fi_driver = INPUT fi_driver .
    DISP fi_driver WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_regisyear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_regisyear C-Win
ON LEAVE OF fi_regisyear IN FRAME fr_main
DO:
    /*fi_dridate2 = INPUT fi_dridate2 .
    DISP fi_dridate2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark C-Win
ON LEAVE OF fi_remark IN FRAME fr_main
DO:
    /*fi_dridate2 = INPUT fi_dridate2 .
    DISP fi_dridate2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_saletype
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_saletype C-Win
ON LEAVE OF fi_saletype IN FRAME fr_main
DO:
    /*fi_refno = INPUT fi_refno .
    DISP fi_refno WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_seat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_seat C-Win
ON LEAVE OF fi_seat IN FRAME fr_main
DO:
    /*fi_drisur2 = INPUT fi_drisur2 .
    DISP fi_drisur2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stamp
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stamp C-Win
ON LEAVE OF fi_stamp IN FRAME fr_main
DO:
    /*fi_payic = INPUT fi_payic .
    DISP fi_payic WITH FRAME fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_stkno
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_stkno C-Win
ON LEAVE OF fi_stkno IN FRAME fr_main
DO:
   /* fi_payaddr2 = INPUT fi_payaddr2 .
    DISP fi_payaddr2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumins
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumins C-Win
ON LEAVE OF fi_sumins IN FRAME fr_main
DO:
   /* fi_paynam = INPUT fi_paynam .
    DISP fi_paynam WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_sumtotle
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_sumtotle C-Win
ON LEAVE OF fi_sumtotle IN FRAME fr_main
DO:
    /*fi_payic = INPUT fi_payic .
    DISP fi_payic WITH FRAME fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tambon
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tambon C-Win
ON LEAVE OF fi_tambon IN FRAME fr_main
DO:
   /* fi_polbdate = INPUT fi_polbdate .
    DISP fi_polbdate WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tax
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tax C-Win
ON LEAVE OF fi_tax IN FRAME fr_main
DO:
    /*fi_payic = INPUT fi_payic .
    DISP fi_payic WITH FRAME fr_main.*/
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_title
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_title C-Win
ON LEAVE OF fi_title IN FRAME fr_main
DO:
    /*fi_produc = INPUT fi_produc .
    DISP fi_produc WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tons
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tons C-Win
ON LEAVE OF fi_tons IN FRAME fr_main
DO:
   /* fi_driid2 = INPUT fi_driid2 .
    DISP fi_driid2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehreg
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehreg C-Win
ON LEAVE OF fi_vehreg IN FRAME fr_main
DO:
   /* fi_driocc2 = INPUT fi_driocc2 .
    DISP fi_driocc2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehreg2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehreg2 C-Win
ON LEAVE OF fi_vehreg2 IN FRAME fr_main
DO:
    /*fi_drisex2 = INPUT fi_drisex2 .
    DISP fi_drisex2 WITH FRAME fr_main.*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_vehuse
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_vehuse C-Win
ON LEAVE OF fi_vehuse IN FRAME fr_main
DO:
   /* fi_drinam2 = INPUT fi_drinam2 .
    DISP fi_drinam2 WITH FRAME fr_main.*/
  
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
  
    
     /********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.
  
  gv_prgid = "WGWQHCT1".
  gv_prog  = "Query & Update Notify (HCT) ".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:handle,gv_prgid,gv_prog).

/*********************************************************************/ 
 /*  RUN Wut\WutwiCen ({&WINDOW-NAME}:HANDLE). */ 
  /*CURRENT-WINDOW:WINDOW-STATE = WINDOW-MAXIMIZED.*/
  SESSION:DATA-ENTRY-RETURN = YES.
  
 /* Rect-336:Move-to-top().*/
/*  Rect-337:Move-to-top().
  
  /*Hide    fi_difprm  in frame  {&FRAME-NAME}.*/*/

  Find  brstat.tlt  Where   Recid(tlt)  =  nv_recidtlt NO-LOCK NO-ERROR NO-WAIT .
  If  avail  tlt  Then do:
      RUN Proc_assignfi.
      RUN proc_assignfi2.

      DISP fi_contract fi_contractdat fi_notifyno     fi_comdat    fi_expdat    fi_companycd     
          fi_cartype   fi_saletype    fi_campaigntype fi_payment   fi_covcod    fi_covtype       
          fi_garage    fi_crateby     fi_title        fi_insnamef  fi_insnamem  
          fi_insnamel  fi_addrno      fi_road         fi_tambon    fi_amper     
          fi_province  fi_post        fi_occup        fi_brithday  fi_icno      
          fi_licenno   fi_brand       fi_group        fi_cha_no    fi_eng_no    
          fi_model     fi_caryear     fi_carnametype                            
          fi_body      fi_cartypecd   fi_vehuse       fi_seat      fi_tons      fi_color        
          fi_vehreg    fi_vehreg2     fi_regisyear    fi_remark    fi_sumins    fi_premt        
          fi_stamp     fi_tax         fi_nettotle     fi_sumtotle  fi_ncbper    fi_ncbamt       
          fi_stkno     fi_prepol      fi_flagdri      fi_flagnodri              
          fi_dri1title fi_dri1fname   fi_dri1mname    fi_dri1lname fi_dri1occup fi_dri1brithday
          fi_dri1icno  fi_dri1licen   fi_dri2title    fi_dri2fname fi_dri2mname 
          fi_dri2lname fi_dri2occup   fi_dri2brithday fi_dri2icno  fi_dri2licen fi_ben  
          fi_trandat   fi_time        fi_user    

    bu_detail1  bu_detail2  bU_save     
    bu_exit WITH FRAME fr_main.
    bu_detail1:BGCOLOR = 19.
    bu_detail1:FGCOLOR = 6. 
   /* DISABLE bu_detail1 WITH FRAME fr_main.*/
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
  DISPLAY fi_covcod fi_covtype fi_garage fi_crateby fi_insnamef fi_insnamem 
          fi_addrno fi_road fi_tambon fi_amper fi_occup fi_brithday fi_sumins 
          fi_premt fi_stamp fi_ncbper fi_ncbamt fi_prepol fi_flagnodri 
          fi_dri1title fi_dri1icno fi_saletype fi_campaigntype fi_notifyno 
          fi_province fi_brand fi_group fi_cha_no fi_caryear fi_model 
          fi_carnametype fi_vehuse fi_seat fi_tons fi_vehreg2 fi_vehreg 
          fi_regisyear fi_companycd fi_cartype fi_trandat fi_user fi_time 
          fi_contractdat fi_comdat fi_userup fi_contract fi_payment fi_title 
          fi_dri1licen fi_expdat fi_insnamel fi_post fi_icno fi_licenno 
          fi_eng_no fi_body fi_cartypecd fi_color fi_remark fi_tax fi_nettotle 
          fi_sumtotle fi_stkno fi_flagdri fi_dri1fname fi_dri1mname fi_dri1lname 
          fi_dri1occup fi_dri1brithday fi_dri2title fi_dri2fname fi_dri2mname 
          fi_dri2lname fi_dri2occup fi_dri2brithday fi_dri2icno fi_dri2licen 
          fi_ben 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE bu_detail2 bu_save bu_exit bu_detail1 fi_covcod fi_covtype fi_garage 
         fi_crateby fi_insnamef fi_insnamem fi_addrno fi_road fi_tambon 
         fi_amper fi_occup fi_brithday fi_sumins fi_premt fi_stamp fi_ncbper 
         fi_ncbamt fi_prepol fi_flagnodri fi_dri1title fi_dri1icno fi_saletype 
         fi_campaigntype fi_notifyno fi_province fi_brand fi_group fi_cha_no 
         fi_caryear fi_model fi_carnametype fi_vehuse fi_seat fi_tons 
         fi_vehreg2 fi_vehreg fi_regisyear fi_companycd fi_cartype fi_trandat 
         fi_user fi_time fi_contractdat fi_comdat fi_userup fi_contract 
         fi_payment fi_title fi_dri1licen fi_expdat fi_insnamel fi_post fi_icno 
         fi_licenno fi_eng_no fi_body fi_cartypecd fi_color fi_remark fi_tax 
         fi_nettotle fi_sumtotle fi_stkno fi_flagdri fi_dri1fname fi_dri1mname 
         fi_dri1lname fi_dri1occup fi_dri1brithday fi_dri2title fi_dri2fname 
         fi_dri2mname fi_dri2lname fi_dri2occup fi_dri2brithday fi_dri2icno 
         fi_dri2licen fi_ben bu_detail-3 RECT-462 RECT-464 RECT-465 RECT-502 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi C-Win 
PROCEDURE proc_assignfi :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    DEF VAR n_bdate AS CHAR INIT "".
     ASSIGN 
      fi_contract     =   brstat.tlt.comp_noti_ins     
      fi_contractdat  =   brstat.tlt.comp_noti_tlt     
      fi_notifyno     =   brstat.tlt.comp_pol          
      fi_comdat       =   brstat.tlt.nor_effdat        
      fi_expdat       =   brstat.tlt.comp_effdat       
      fi_companycd    =   brstat.tlt.comp_sub          
      fi_cartype      =   brstat.tlt.cifno             
      fi_saletype     =   brstat.tlt.nationality       
      fi_campaigntype =   brstat.tlt.nor_noti_ins      
      fi_payment      =   brstat.tlt.nor_noti_tlt      
      fi_covcod       =   brstat.tlt.nor_usr_ins       
      fi_covtype      =   brstat.tlt.covcod            
      fi_garage       =   brstat.tlt.nor_usr_tlt       
      fi_crateby      =   brstat.tlt.comp_usr_ins      
      fi_title        =   brstat.tlt.ins_title         
      fi_insnamef     =   brstat.tlt.ins_name          
      fi_insnamem     =   brstat.tlt.ins_firstname     
      fi_insnamel     =   brstat.tlt.ins_lastname      
      fi_addrno       =   brstat.tlt.ins_addr          
      fi_road         =   brstat.tlt.ins_addr1         
      fi_tambon       =   brstat.tlt.ins_addr2         
      fi_amper        =   brstat.tlt.ins_addr3         
      fi_province     =   brstat.tlt.lince2            
      fi_post         =   brstat.tlt.ins_addr5         
      fi_occup        =   brstat.tlt.dir_occ1          
      fi_brithday     =   brstat.tlt.note28            
      fi_icno         =   brstat.tlt.dri_ic1           
      fi_licenno      =   brstat.tlt.dri_lic1          
      fi_brand        =   brstat.tlt.brand             
      fi_group        =   brstat.tlt.note10            
      fi_cha_no       =   brstat.tlt.cha_no            
      fi_eng_no       =   brstat.tlt.eng_no           
      fi_model        =   brstat.tlt.model             
      fi_caryear      =   brstat.tlt.note11            
      fi_carnametype  =   brstat.tlt.note12            
      fi_body         =   brstat.tlt.note13            
      fi_cartypecd    =   brstat.tlt.note14            
      fi_vehuse       =   brstat.tlt.vehuse         
      fi_seat         =   brstat.tlt.seqno          
      fi_tons         =   brstat.tlt.cc_weight      
      fi_color        =   brstat.tlt.colorcod       
      fi_vehreg       =   brstat.tlt.lince1      
      fi_vehreg2      =   brstat.tlt.ins_addr4      
      fi_regisyear    =   brstat.tlt.note15         
      fi_remark       =   brstat.tlt.note16         
      fi_sumins       =   brstat.tlt.note17         
      fi_premt        =   brstat.tlt.note18         
      fi_stamp        =   brstat.tlt.note19         
      fi_tax          =   brstat.tlt.note2          
      fi_nettotle     =   brstat.tlt.note20         
      fi_sumtotle     =   brstat.tlt.note21         
      fi_ncbper       =   brstat.tlt.note22         
      fi_ncbamt       =   brstat.tlt.note23         
      fi_stkno        =   brstat.tlt.comp_sck       
      fi_prepol       =   brstat.tlt.note24         
      fi_flagdri      =   brstat.tlt.dri_no1        
      fi_flagnodri    =   brstat.tlt.dri_no2        
      fi_dri1title    =   brstat.tlt.note25         
      fi_dri1fname    =   brstat.tlt.dri_name1      
      fi_dri1mname    =   brstat.tlt.note26         
      fi_dri1lname    =   brstat.tlt.note27         
      fi_dri1occup    =   brstat.tlt.dri_occ2       
      fi_dri1brithday =   brstat.tlt.note4          
      fi_dri1icno     =   brstat.tlt.dri_ic2        
      fi_dri1licen    =   brstat.tlt.dri_lic2       
      fi_dri2title    =   brstat.tlt.note29         
      fi_dri2fname    =   brstat.tlt.dri_name2      
      fi_dri2mname    =   brstat.tlt.note3          
      fi_dri2lname    =   brstat.tlt.note30         
      fi_dri2occup    =   brstat.tlt.ins_occ        
      fi_dri2brithday =   brstat.tlt.birthdate      
      fi_dri2icno     =   brstat.tlt.ins_icno       
      fi_dri2licen    =   brstat.tlt.note1          
      fi_ben          =   brstat.tlt.ben83 
      fi_trandat      =   brstat.tlt.entdat      
      fi_time         =   brstat.tlt.enttim 
      fi_user         = brstat.tlt.comp_usr_tlt 
       .        
     

        
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi-bp C-Win 
PROCEDURE proc_assignfi-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    DEF VAR n_bdate AS CHAR INIT "".
    ASSIGN 
        fi_polno     = brstat.tlt.policy
        fi_poltyp    = brstat.tlt.flag
        fi_trandat   = brstat.tlt.entdat
        fi_notdat    = brstat.tlt.trndat
        fi_time      = brstat.tlt.enttim
        fi_user      = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,1,INDEX(tlt.usrid,"/") - 1) ELSE brstat.tlt.usrid
        fi_userup    = IF index(brstat.tlt.usrid,"/") <> 0 THEN SUBSTR(brstat.tlt.usrid,r-INDEX(tlt.usrid,"/") + 1) ELSE ""
        fi_agent     = brstat.tlt.recac
        fi_producer  = brstat.tlt.subins
        fi_refno     = brstat.tlt.nor_noti_ins
        fi_custcode  = brstat.tlt.nor_usr_ins
        fi_contract  = IF trim(brstat.tlt.colorcod) = "" THEN "" ELSE SUBSTR(brstat.tlt.colorcod,5,INDEX(brstat.tlt.colorcod,"BR:") - 5)
        fi_bray      = IF trim(brstat.tlt.colorcod) = "" THEN "" ELSE SUBSTR(brstat.tlt.colorcod,R-INDEX(brstat.tlt.colorcod,"BR:") + 3)   
        /*- campaign product packge ----*/
        fi_campnam   = trim(substr(brstat.tlt.lotno,R-INDEX(tlt.lotno,"CamName:") + 8 ))     /*ชื่อแคมเปญ*/
        n_char       = trim(SUBSTR(brstat.tlt.lotno,1,R-INDEX(tlt.lotno,"CamName:") - 2 ))
        fi_camp      = trim(substr(n_char,R-INDEX(n_char,"CamCode:") + 8))                   /*รหัสแคมเปญ*/
        n_char       = trim(SUBSTR(n_char,1,R-INDEX(n_char,"CamCode:") - 2))
        fi_comnam    = trim(substr(n_char,R-INDEX(n_char,"insname:") + 8))                   /*ชื่อบริษัท */
        n_char       = trim(SUBSTR(n_char,1,R-INDEX(n_char,"insname:") - 2))
        fi_comcod    = trim(substr(n_char,R-INDEX(n_char,"InsCode:") + 8))                   /*รหัสบริษัท*/

        fi_pacg      = TRIM(SUBSTR(brstat.tlt.usrsent,R-INDEX(brstat.tlt.usrsent,"packcod:") + 8))   /*รหัสแพคเกจ    */ 
        n_char       = TRIM(SUBSTR(brstat.tlt.usrsent,1,R-INDEX(tlt.usrsent,"packcod:") - 2))
        fi_pacgnam   = trim(substr(n_char,R-INDEX(n_char,"packnam:") + 8))    /*ชื่อแพคเกจ    */ 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"packnam:") - 2))
        fi_producnam = trim(substr(n_char,R-INDEX(n_char,"proname:") + 8))    /*ชื่อผลิตภัณฑ์ */ 
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"proname:") - 2))
        fi_produc    = trim(substr(n_char,R-INDEX(n_char,"procode:") + 8))     /*รหัสผลิตภัณฑ์ */ 
        fi_custtyp   = trim(substr(brstat.tlt.imp,5,INDEX(brstat.tlt.imp,"Pol:") - 4))     /*ประเภท        */ 
        fi_oldpol    = TRIM(SUBSTR(brstat.tlt.imp,R-INDEX(brstat.tlt.imp,"Pol:") + 4))     /*เบอร์กรมเดิม */
        fi_custdes   = IF index(brstat.tlt.imp,"TYP:P") = 0 THEN "นิติบุคคล" ELSE "บุลคลธรรมดา"
        /*-- ชื่อสกุลลูกค้า ---*/
        n_char       = trim(SUBSTR(brstat.tlt.ins_name,R-INDEX(tlt.ins_name,"nameeng:") + 8 ))
        fi_sureng    = IF n_char <> " " AND index(brstat.tlt.imp,"TYP:P") <> 0 then trim(SUBSTR(n_char,R-INDEX(n_char," ")))  else ""
        fi_nameeng   = IF n_char <> " " then trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) else "" 
        n_char       = trim(SUBSTR(tlt.ins_name,1,R-INDEX(tlt.ins_name,"nameeng:") - 2))
        fi_surth     = IF trim(n_char) <> "NameTha:" AND index(brstat.tlt.imp,"TYP:P") <> 0 THEN trim(SUBSTR(n_char,R-INDEX(n_char," ")))  ELSE ""
        n_char       = SUBSTR(n_char,1,LENGTH(n_char) - LENGTH(fi_surth))
        fi_nameth    = IF trim(n_char) <> "NameTha:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Nametha:") + 8)) ELSE "" 
        /*-- เลขบัตร วันเกิด เพศ อาขีพ --*/
        fi_polocc    = trim(SUBSTR(brstat.tlt.rec_addr5,R-INDEX(tlt.rec_addr5,"occup:") + 6 ))
        n_char       = TRIM(SUBSTR(brstat.tlt.rec_addr5,1,R-INDEX(tlt.rec_addr5,"Occup:") - 2 ))
        n_bdate      = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Birth:") + 6 ))
        fi_polbdate  = DATE(n_bdate)
        n_char       = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"Birth:") - 2 ))
        fi_sex       = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Sex:") + 4 ))
        fi_icno      = TRIM(SUBSTR(n_char,6,R-INDEX(n_char,"Sex:") - 6 )) 
        /*-- เบอร์โทร เมล์ ไลน์ ---*/
        fi_line     = trim(SUBSTR(brstat.tlt.ins_addr5,R-INDEX(brstat.tlt.ins_addr5,"Linid:") + 6 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.ins_addr5,1,R-INDEX(brstat.tlt.ins_addr5,"Linid:") - 2 ))
        fi_mail     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Email:") + 6 ))
        fi_poltel   = TRIM(SUBSTR(n_char,7,R-INDEX(n_char,"Email:") - 7 )) 
        fi_poladdr1 = trim(brstat.tlt.ins_addr1)
        fi_poladdr2 = trim(brstat.tlt.ins_addr2)
        fi_senaddr1 = trim(brstat.tlt.ins_addr3)
        fi_senaddr2 = trim(brstat.tlt.ins_addr4).
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi2 C-Win 
PROCEDURE proc_assignfi2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    DEF VAR n_bdate AS CHAR INIT "".
 /*   ASSIGN 
        /*--ผู้ขับขี่ ---*/
        fi_driver   = brstat.tlt.endcnt 
        fi_driid1   = TRIM(substr(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") + 7 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_name1,1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") - 2 ))
        fi_drisur1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""
        n_char      = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char
        fi_drinam1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Drinam1:") + 8)) ELSE "" 
        n_bdate     = TRIM(SUBSTR(brstat.tlt.dri_no1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") + 8 ))
        fi_dridate1 = DATE(n_bdate)
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_no1,1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") - 2))
        fi_drisex1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex1:") + 8 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex1:") - 2))
        fi_driocc1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc1:") + 8))
        fi_driid2   = TRIM(substr(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"DriID2:") + 7 ))     
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_name2,1,R-INDEX(brstat.tlt.dri_name2,"DriID2:") - 2 ))   
        fi_drisur2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""        
        n_char      = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char 
        fi_drinam2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,9,R-INDEX(n_char,"Drinam2:") + 8)) ELSE ""  
        n_bdate     = TRIM(SUBSTR(brstat.tlt.dri_no2,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") + 8))
        fi_dridate2 = DATE(n_bdate)
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_no2,1,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") - 2))
        fi_drisex2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex2:") + 8 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex2:") - 2 ))
        fi_driocc2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc2:") + 8 ))
        /*--การชำระเงิน --*/
        /*fi_paytyp   = trim(substr(brstat.tlt.EXP,index(brstat.tlt.EXP,"Paytyp:") + 7,R-INDEX(brstat.tlt.EXP,"Branch:") - 9)) 
        fi_branch   = TRIM(SUBSTR(brstat.tlt.EXP,R-INDEX(brstat.tlt.EXP,"Branch:") + 7 ))*/
        fi_paysur   = TRIM(substr(brstat.tlt.rec_name,R-INDEX(brstat.tlt.rec_name," ")))
        fi_paynam   = trim(substr(brstat.tlt.rec_name,1,LENGTH(brstat.tlt.rec_name) - LENGTH(fi_paysur)))
        fi_payic    = trim(brstat.tlt.comp_sub)
        fi_payaddr1 = trim(brstat.tlt.rec_addr1)
        fi_payaddr2 = trim(brstat.tlt.rec_addr2)
        fi_bennam   = trim(brstat.tlt.safe1) 
        fi_waytyp   = trim(substr(brstat.tlt.safe2,R-INDEX(brstat.tlt.safe2,"Paymentty:") + 10 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.safe2,1,R-INDEX(brstat.tlt.safe2,"Paymentty:") - 2 ))
        /*fi_payway   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentTyCd:") + 12 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentTyCd:") - 2 ))*/
        fi_paymtyp  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMDTy:") + 12 ))
       /* n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentMDTy:") - 2 ))
        fi_paymcod  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMD:") + 10 ))
        fi_bank     = TRIM(brstat.tlt.safe3) */
        /*fi_paidsts  = TRIM(SUBSTR(brstat.tlt.rec_addr4,R-INDEX(brstat.tlt.rec_addr4,"Paid:") + 5 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.rec_addr4,1,R-INDEX(brstat.tlt.rec_addr4,"Paid:") - 2 ))
        fi_paysts   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"paysts:") + 7 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"paysts:") - 2 ))
        n_bdate     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Paydat:") + 7 ))
        fi_paydat   = DATE(n_bdate)*/
        fi_saledat  = brstat.tlt.datesent 
        fi_payin    = brstat.tlt.dat_ins_noti . */
END. 

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignfi2-bp C-Win 
PROCEDURE proc_assignfi2-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*DO:
    DEF VAR n_leng AS INT INIT 0.
    DEF VAR n_char AS CHAR FORMAT "x(250)" INIT "" .
    DEF VAR n_bdate AS CHAR INIT "".
    ASSIGN 
        /*--ผู้ขับขี่ ---*/
        fi_driver   = brstat.tlt.endcnt 
        fi_driid1   = TRIM(substr(brstat.tlt.dri_name1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") + 7 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_name1,1,R-INDEX(brstat.tlt.dri_name1,"DriID1:") - 2 ))
        fi_drisur1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""
        n_char      = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char
        fi_drinam1  = IF TRIM(n_char) <> "Drinam1:" THEN trim(SUBSTR(n_char,R-INDEX(n_char,"Drinam1:") + 8)) ELSE "" 
        n_bdate     = TRIM(SUBSTR(brstat.tlt.dri_no1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") + 8 ))
        fi_dridate1 = DATE(n_bdate)
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_no1,1,R-INDEX(brstat.tlt.dri_no1,"Dribir1:") - 2))
        fi_drisex1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex1:") + 8 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex1:") - 2))
        fi_driocc1  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc1:") + 8))
        fi_driid2   = TRIM(substr(brstat.tlt.dri_name2,R-INDEX(brstat.tlt.dri_name2,"DriID2:") + 7 ))     
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_name2,1,R-INDEX(brstat.tlt.dri_name2,"DriID2:") - 2 ))   
        fi_drisur2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,R-INDEX(n_char," "))) ELSE ""        
        n_char      = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,1,R-INDEX(n_char," "))) ELSE n_char 
        fi_drinam2  = IF TRIM(n_char) <> "Drinam2:" THEN trim(SUBSTR(n_char,9,R-INDEX(n_char,"Drinam2:") + 8)) ELSE ""  
        n_bdate     = TRIM(SUBSTR(brstat.tlt.dri_no2,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") + 8))
        fi_dridate2 = DATE(n_bdate)
        n_char      = TRIM(SUBSTR(brstat.tlt.dri_no2,1,R-INDEX(brstat.tlt.dri_no2,"Dribir2:") - 2))
        fi_drisex2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"drisex2:") + 8 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"drisex2:") - 2 ))
        fi_driocc2  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"DriOcc2:") + 8 ))
        /*--การชำระเงิน --*/
        fi_paytyp   = trim(substr(brstat.tlt.EXP,index(brstat.tlt.EXP,"Paytyp:") + 7,R-INDEX(brstat.tlt.EXP,"Branch:") - 9)) 
        fi_branch   = TRIM(SUBSTR(brstat.tlt.EXP,R-INDEX(brstat.tlt.EXP,"Branch:") + 7 ))
        fi_paysur   = TRIM(substr(brstat.tlt.rec_name,R-INDEX(brstat.tlt.rec_name," ")))
        fi_paynam   = trim(substr(brstat.tlt.rec_name,1,LENGTH(brstat.tlt.rec_name) - LENGTH(fi_paysur)))
        fi_payic    = trim(brstat.tlt.comp_sub)
        fi_payaddr1 = trim(brstat.tlt.rec_addr1)
        fi_payaddr2 = trim(brstat.tlt.rec_addr2)
        fi_bennam   = trim(brstat.tlt.safe1) 
        fi_waytyp   = trim(substr(brstat.tlt.safe2,R-INDEX(brstat.tlt.safe2,"Paymentty:") + 10 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.safe2,1,R-INDEX(brstat.tlt.safe2,"Paymentty:") - 2 ))
        fi_payway   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentTyCd:") + 12 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentTyCd:") - 2 ))
        fi_paymtyp  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMDTy:") + 12 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"PaymentMDTy:") - 2 ))
        fi_paymcod  = TRIM(SUBSTR(n_char,R-INDEX(n_char,"PaymentMD:") + 10 ))
        fi_bank     = TRIM(brstat.tlt.safe3) 
        fi_paidsts  = TRIM(SUBSTR(brstat.tlt.rec_addr4,R-INDEX(brstat.tlt.rec_addr4,"Paid:") + 5 ))
        n_char      = TRIM(SUBSTR(brstat.tlt.rec_addr4,1,R-INDEX(brstat.tlt.rec_addr4,"Paid:") - 2 ))
        fi_paysts   = TRIM(SUBSTR(n_char,R-INDEX(n_char,"paysts:") + 7 ))
        n_char      = TRIM(SUBSTR(n_char,1,R-INDEX(n_char,"paysts:") - 2 ))
        n_bdate     = TRIM(SUBSTR(n_char,R-INDEX(n_char,"Paydat:") + 7 ))
        fi_paydat   = DATE(n_bdate)
        fi_saledat  = brstat.tlt.datesent
        fi_payin    = brstat.tlt.dat_ins_noti . 
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

