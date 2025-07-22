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
/* wgwvtlkk2.w   Query Vehicle TLT KK                                                                     */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.           */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)                 */
/* CREATE BY    : Chaiyong W. A64-0135 21/06/2021                                */
/************************************************************************/  
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/
/* Modify by : Ranu I. A65-0288 เพิ่มช่องข้อมูล สีรถ และการตรวจสภาพ     */
/*Modify by : Ranu I. A67-0076 เพิ่มเงื่อนไขการเก็บข้อมูลรถไฟฟ้า */
/* ***************************  Definitions  ************************** */
/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */

def  input-output parameter nv_atyp        as char init "" no-undo.
def  input-output parameter nv_asubtyp     as char init "" no-undo.
def  input-output parameter nv_acarc       as char init "" no-undo.
def  input-output parameter nv_atypc       as char init "" no-undo.
def  input-output parameter nv_abrandcar   as char init "" no-undo.
def  input-output parameter nv_abrandcar-2 as char init "" no-undo.
def  input-output parameter nv_ascar       as char init "" no-undo.
def  input-output parameter nv_aveh        as char init "" no-undo.
def  input-output parameter nv_avehpro     as char init "" no-undo.
def  input-output parameter nv_achano      as char init "" no-undo.
def  input-output parameter nv_aengno      as char init "" no-undo.
def  input-output parameter nv_aengno-2    as char init "" no-undo.
def  input-output parameter nv_aton        as char init "" no-undo.
def  input-output parameter nv_acaryr      as char init "" no-undo.
def  input-output parameter nv_atons       as char init "" no-undo.
def  input-output parameter nv_amil        as char init "" no-undo.
def  input-output parameter nv_agarage     as char init "" no-undo.
def  input-output parameter nv_acar        as char init "" no-undo.
def  input-output parameter nv_adrilic     as char init "" no-undo.
def  input-output parameter nv_adrname     as char init "" no-undo.
def  input-output parameter nv_adob        as char init "" no-undo.
def  input-output parameter nv_adrilic-2   as char init "" no-undo.
def  input-output parameter nv_adrname-2   as char init "" no-undo.
def  input-output parameter nv_adob-2      as char init "" no-undo.
/* add by :A65-0288 */
def  input-output parameter nv_colors      as char init "" no-undo. 
def  input-output parameter nv_ispchk      as char init "" no-undo. 
def  input-output parameter nv_ispsts      as char init "" no-undo. 
def  input-output parameter nv_ispno       as char init "" no-undo. 
def  input-output parameter nv_ispappoit   as char init "" no-undo. 
def  input-output parameter nv_ispupdate   as char init "" no-undo. 
def  input-output parameter nv_isplocal    as char init "" no-undo. 
def  input-output parameter nv_ispclose    as char init "" no-undo. 
def  input-output parameter nv_ispresult   as char init "" no-undo. 
def  input-output parameter nv_ispdam      as char init "" no-undo. 
def  input-output parameter nv_ispacc      as char init "" no-undo.
/* end A65-0288 */
/* add by : A67-0076 */
DEF INPUT-OUTPUT PARAMETER nv_hp           as char init "" no-undo.
def input-output parameter nv_drititle1    as char init "" no-undo.     
def input-output parameter nv_drigender1   as char init "" no-undo.     
def input-output parameter nv_drioccup1    as char init "" no-undo.     
def input-output parameter nv_driToccup1   as char init "" no-undo.     
def input-output parameter nv_driTicono1   as char init "" no-undo.     
def input-output parameter nv_driICNo1     as char init "" no-undo.     
def input-output parameter nv_drilic2      as char init "" no-undo.     
def input-output parameter nv_drititle2    as char init "" no-undo.     
def input-output parameter nv_drigender2   as char init "" no-undo.     
def input-output parameter nv_drioccup2    as char init "" no-undo.     
def input-output parameter nv_driToccup2   as char init "" no-undo.     
def input-output parameter nv_driTicono2   as char init "" no-undo.     
def input-output parameter nv_driICNo2     as char init "" no-undo.     
def input-output parameter nv_drilic3      as char init "" no-undo.     
def input-output parameter nv_drititle3    as char init "" no-undo.     
def input-output parameter nv_driname3     as char init "" no-undo.     
def input-output parameter nv_drivno3      as char init "" no-undo.     
def input-output parameter nv_drigender3   as char init "" no-undo.     
def input-output parameter nv_drioccup3    as char init "" no-undo.     
def input-output parameter nv_driToccup3   as char init "" no-undo.     
def input-output parameter nv_driTicono3   as char init "" no-undo.     
def input-output parameter nv_driICNo3     as char init "" no-undo.     
def input-output parameter nv_drilic4      as char init "" no-undo.     
def input-output parameter nv_drititle4    as char init "" no-undo.     
def input-output parameter nv_driname4     as char init "" no-undo.     
def input-output parameter nv_drivno4      as char init "" no-undo.     
def input-output parameter nv_drigender4   as char init "" no-undo.     
def input-output parameter nv_drioccup4    as char init "" no-undo.     
def input-output parameter nv_driToccup4   as char init "" no-undo.     
def input-output parameter nv_driTicono4   as char init "" no-undo.     
def input-output parameter nv_driICNo4     as char init "" no-undo.     
def input-output parameter nv_drilic5      as char init "" no-undo.     
def input-output parameter nv_drititle5    as char init "" no-undo.     
def input-output parameter nv_driname5     as char init "" no-undo.     
def input-output parameter nv_drivno5      as char init "" no-undo.     
def input-output parameter nv_drigender5   as char init "" no-undo.     
def input-output parameter nv_drioccup5    as char init "" no-undo.     
def input-output parameter nv_driToccup5   as char init "" no-undo.     
def input-output parameter nv_driTicono5   as char init "" no-undo.     
def input-output parameter nv_driICNo5     as char init "" no-undo.     
def input-output parameter nv_dateregis    as char init "" no-undo.     
def input-output parameter nv_pay_option   as char init "" no-undo.     
def input-output parameter nv_battno       as char init "" no-undo.     
def input-output parameter nv_battyr       as char init "" no-undo.     
def input-output parameter nv_maksi        as char init "" no-undo.     
def input-output parameter nv_chargno      as char init "" no-undo.     
def input-output parameter nv_veh_key      as char init "" no-undo.
/* end : A67-0076 */
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
def  var nv_extref       as char.
DEF VAR nv_today         AS CHAR init "" .
DEF VAR nv_time          AS CHAR init "" .
DEF VAR nv_docno         AS CHAR FORMAT "x(25)".
DEF VAR nv_survey        AS CHAR FORMAT "x(25)".
DEF VAR nv_detail        AS CHAR FORMAT "x(30)".
DEF VAR nv_remark1       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark2       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark3       AS CHAR FORMAT "x(250)".
DEF VAR nv_remark4       AS CHAR FORMAT "x(250)".
DEF VAR nv_damlist       AS CHAR FORMAT "x(150)" INIT "" .
DEF VAR nv_damage        AS CHAR FORMAT "x(250)" INIT "" .
DEF VAR nv_totaldam      AS CHAR FORMAT "X(150)" .
DEF VAR nv_attfile       AS CHAR FORMAT "x(100)" INIT "" .
DEF VAR nv_device        AS CHAR FORMAT "x(500)" INIT "".
Def var nv_acc1          as char format "x(50)".   
Def var nv_acc2          as char format "x(50)".   
Def var nv_acc3          as char format "x(50)".   
Def var nv_acc4          as char format "x(50)".   
Def var nv_acc5          as char format "x(50)".   
Def var nv_acc6          as char format "x(50)".   
Def var nv_acc7          as char format "x(50)".   
Def var nv_acc8          as char format "x(50)".   
Def var nv_acc9          as char format "x(50)".   
Def var nv_acc10         as char format "x(50)".   
Def var nv_acc11         as char format "x(50)".   
Def var nv_acc12         as char format "x(50)".   
Def var nv_acctotal      as char format "x(100)".   
DEF VAR nv_surdata       AS CHAR FORMAT "x(250)".  
DEF VAR nv_date          AS CHAR FORMAT "x(15)" .
DEF VAR nv_damdetail     AS LONGCHAR .
DEF VAR nv_year          AS CHAR INIT "" .
DEF VAR n_list           AS INT init 0.
DEF VAR n_count          AS INT init 0.
DEF VAR n_repair         AS CHAR FORMAT "x(10)" init "".
DEF VAR n_dam            AS CHAR FORMAT "x(10)" init "".
DEF VAR n_deatil         AS CHAR FORMAT "x(60)" init "".
DEF VAR nv_damag         AS CHAR FORMAT "x(30)" init "".
DEF VAR nv_repair        AS CHAR FORMAT "x(30)" init "".
DEF VAR n_agent          AS CHAR FORMAT "x(10)" INIT "".
def var nv_chk           as char init ""    .
def var nv_commt         as char init ""    .
def var nv_appdate   as char init "" .
def var nv_apploc    as char init "" .
DEF VAR nv_chkname   AS CHAR INIT "" .
def var nv_chkdate   as char init "" .
def var nv_Dappoint  as CHAR init "" .
def var nv_Lappoint  as char init "" .
DEF VAR nv_comment   AS CHAR INIT "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_drititle bu_update fi_typ Btn_OK ~
Btn_Cancel fi_ispchk fi_drititle-2 fi_drititle-3 fi_drititle-4 ~
fi_drititle-5 RECT-81 RECT-84 RECT-85 
&Scoped-Define DISPLAYED-OBJECTS fi_drititle fi_typ fi_subtyp fi_carc ~
fi_typc fi_brandcar fi_brandcar-2 fi_scar fi_veh fi_vehpro fi_chano ~
fi_engno fi_caryr fi_engno-2 fi_ton fi_tons fi_mil fi_garage fi_car ~
fi_drilic fi_drname fi_dob fi_drilic-2 fi_drname-2 fi_dob-2 fi_colors ~
fi_ispchk fi_ispsts fi_ispno fi_ispresult fi_isplocal fi_ispupdate ~
fi_ispclose fi_ispdam fi_ispacc fi_ispappoit fi_HP fi_pay_option ~
fi_dateregis fi_battno fi_battyr fi_maksi fi_chargno fi_veh_key ~
fi_drititle-2 fi_gender fi_gender-2 fi_occup fi_occup-2 fi_bustyp ~
fi_bustyp-2 fi_cardtyp fi_cardtyp-2 fi_icno fi_icno-2 fi_drilic-3 ~
fi_drname-3 fi_dob-3 fi_drititle-3 fi_gender-3 fi_occup-3 fi_bustyp-3 ~
fi_cardtyp-3 fi_icno-3 fi_drilic-4 fi_drname-4 fi_dob-4 fi_drititle-4 ~
fi_gender-4 fi_occup-4 fi_bustyp-4 fi_cardtyp-4 fi_icno-4 fi_drilic-5 ~
fi_drname-5 fi_dob-5 fi_drititle-5 fi_gender-5 fi_occup-5 fi_bustyp-5 ~
fi_cardtyp-5 fi_icno-5 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel 
     LABEL "Cancel" 
     SIZE 12 BY 1.14
     BGCOLOR 6 .

DEFINE BUTTON Btn_OK 
     LABEL "OK" 
     SIZE 12.5 BY 1.14
     BGCOLOR 2 .

DEFINE BUTTON bu_update 
     LABEL "Update ISP" 
     SIZE 15.67 BY 1.14
     BGCOLOR 2 FGCOLOR 7 FONT 6.

DEFINE VARIABLE fi_battno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 31.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_battyr AS INT64 FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 9.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brandcar AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 22.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brandcar-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 37.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bustyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_bustyp-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bustyp-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bustyp-4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bustyp-5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_car AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_carc AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cardtyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_cardtyp-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cardtyp-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cardtyp-4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cardtyp-5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_caryr AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 9.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_chano AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_chargno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 42.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_colors AS CHARACTER FORMAT "X(60)":U 
     VIEW-AS FILL-IN 
     SIZE 26.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dateregis AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dob AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_dob-2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dob-3 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dob-4 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dob-5 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drilic AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_drilic-2 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_drilic-3 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_drilic-4 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_drilic-5 AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 19.83 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_drititle AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1
     FONT 1 NO-UNDO.

DEFINE VARIABLE fi_drititle-2 AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1 NO-UNDO.

DEFINE VARIABLE fi_drititle-3 AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1 NO-UNDO.

DEFINE VARIABLE fi_drititle-4 AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1 NO-UNDO.

DEFINE VARIABLE fi_drititle-5 AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 12.17 BY 1 NO-UNDO.

DEFINE VARIABLE fi_drname AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_drname-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drname-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drname-4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_drname-5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_engno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 41.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_engno-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_garage AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gender AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_gender-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gender-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gender-4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_gender-5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_HP AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_icno-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno-4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_icno-5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispacc AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 146.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispappoit AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispchk AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispclose AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispdam AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 146.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_isplocal AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 146.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispno AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 15 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispresult AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 112.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispsts AS CHARACTER FORMAT "X(5)":U 
     VIEW-AS FILL-IN 
     SIZE 5.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ispupdate AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_maksi AS DECIMAL FORMAT "->>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_mil AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 10.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1 FONT 1 NO-UNDO.

DEFINE VARIABLE fi_occup-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup-4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_occup-5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pay_option AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_scar AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_subtyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ton AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 7.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_tons AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 11.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_typ AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 22.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_typc AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_veh AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 14.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_vehpro AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_veh_key AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE RECTANGLE RECT-81
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 187.33 BY 24.71
     BGCOLOR 91 FGCOLOR 4 .

DEFINE RECTANGLE RECT-84
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 183.83 BY 6.67
     FGCOLOR 10 .

DEFINE RECTANGLE RECT-85
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 185.17 BY 14.76
     FGCOLOR 10 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     fi_drititle AT ROW 10.48 COL 23.83 COLON-ALIGNED NO-LABEL WIDGET-ID 764
     bu_update AT ROW 19.24 COL 167.5 WIDGET-ID 730
     fi_typ AT ROW 2.43 COL 21.17 COLON-ALIGNED NO-LABEL WIDGET-ID 564
     fi_subtyp AT ROW 2.43 COL 67.17 COLON-ALIGNED NO-LABEL WIDGET-ID 568
     fi_carc AT ROW 2.43 COL 104.17 COLON-ALIGNED NO-LABEL WIDGET-ID 572
     fi_typc AT ROW 2.38 COL 150.67 COLON-ALIGNED NO-LABEL WIDGET-ID 576
     fi_brandcar AT ROW 3.62 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 580
     fi_brandcar-2 AT ROW 3.57 COL 54.83 COLON-ALIGNED NO-LABEL WIDGET-ID 584
     fi_scar AT ROW 3.57 COL 108 COLON-ALIGNED NO-LABEL WIDGET-ID 592
     fi_veh AT ROW 3.57 COL 150.67 COLON-ALIGNED NO-LABEL WIDGET-ID 594
     fi_vehpro AT ROW 3.57 COL 165.67 COLON-ALIGNED NO-LABEL WIDGET-ID 600
     fi_chano AT ROW 4.81 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 602
     fi_engno AT ROW 4.76 COL 67.67 COLON-ALIGNED NO-LABEL WIDGET-ID 604
     fi_caryr AT ROW 4.71 COL 125 COLON-ALIGNED NO-LABEL WIDGET-ID 614
     fi_engno-2 AT ROW 4.67 COL 150.83 COLON-ALIGNED NO-LABEL WIDGET-ID 616
     fi_ton AT ROW 5.95 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 622
     fi_tons AT ROW 5.95 COL 81.17 COLON-ALIGNED NO-LABEL WIDGET-ID 626
     fi_mil AT ROW 6 COL 133.67 COLON-ALIGNED NO-LABEL WIDGET-ID 630
     fi_garage AT ROW 6 COL 165.83 COLON-ALIGNED NO-LABEL WIDGET-ID 634
     fi_car AT ROW 7.1 COL 20.83 COLON-ALIGNED NO-LABEL WIDGET-ID 636
     fi_drilic AT ROW 10.48 COL 3.67 COLON-ALIGNED NO-LABEL WIDGET-ID 642
     fi_drname AT ROW 10.48 COL 36.67 COLON-ALIGNED NO-LABEL WIDGET-ID 646
     fi_dob AT ROW 10.48 COL 74.17 COLON-ALIGNED NO-LABEL WIDGET-ID 650
     fi_drilic-2 AT ROW 11.62 COL 3.67 COLON-ALIGNED NO-LABEL WIDGET-ID 658
     fi_drname-2 AT ROW 11.62 COL 36.67 COLON-ALIGNED NO-LABEL WIDGET-ID 660
     fi_dob-2 AT ROW 11.62 COL 74.17 COLON-ALIGNED NO-LABEL WIDGET-ID 656
     Btn_OK AT ROW 24.43 COL 44.83
     Btn_Cancel AT ROW 24.43 COL 65.83
     fi_colors AT ROW 5.95 COL 35.83 COLON-ALIGNED NO-LABEL WIDGET-ID 666
     fi_ispchk AT ROW 18.1 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 686
     fi_ispsts AT ROW 18.1 COL 56.33 COLON-ALIGNED NO-LABEL WIDGET-ID 684
     fi_ispno AT ROW 18.05 COL 97.67 COLON-ALIGNED NO-LABEL WIDGET-ID 682
     fi_ispresult AT ROW 20.43 COL 51 COLON-ALIGNED NO-LABEL WIDGET-ID 678
     fi_isplocal AT ROW 19.29 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 680
     fi_ispupdate AT ROW 18.1 COL 165.5 COLON-ALIGNED NO-LABEL WIDGET-ID 704
     fi_ispclose AT ROW 20.43 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 716
     fi_ispdam AT ROW 21.57 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 720
     fi_ispacc AT ROW 22.71 COL 17 COLON-ALIGNED NO-LABEL WIDGET-ID 724
     fi_ispappoit AT ROW 18.1 COL 132.67 COLON-ALIGNED NO-LABEL WIDGET-ID 728
     fi_HP AT ROW 5.95 COL 108.5 COLON-ALIGNED NO-LABEL WIDGET-ID 732
     fi_pay_option AT ROW 7.1 COL 104.5 COLON-ALIGNED NO-LABEL WIDGET-ID 736
     fi_dateregis AT ROW 7.1 COL 68 COLON-ALIGNED NO-LABEL WIDGET-ID 740
     fi_battno AT ROW 7.1 COL 152.5 COLON-ALIGNED NO-LABEL WIDGET-ID 744
     fi_battyr AT ROW 8.19 COL 21 COLON-ALIGNED NO-LABEL WIDGET-ID 748
     fi_maksi AT ROW 8.24 COL 52 COLON-ALIGNED NO-LABEL WIDGET-ID 752
     fi_chargno AT ROW 8.24 COL 91 COLON-ALIGNED NO-LABEL WIDGET-ID 756
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     fi_veh_key AT ROW 8.24 COL 150 COLON-ALIGNED NO-LABEL WIDGET-ID 760
     fi_drititle-2 AT ROW 11.57 COL 23.83 COLON-ALIGNED NO-LABEL WIDGET-ID 768
     fi_gender AT ROW 10.48 COL 87 COLON-ALIGNED NO-LABEL WIDGET-ID 772
     fi_gender-2 AT ROW 11.62 COL 87 COLON-ALIGNED NO-LABEL WIDGET-ID 774
     fi_occup AT ROW 10.48 COL 93.5 COLON-ALIGNED NO-LABEL WIDGET-ID 778
     fi_occup-2 AT ROW 11.62 COL 93.5 COLON-ALIGNED NO-LABEL WIDGET-ID 780
     fi_bustyp AT ROW 10.52 COL 117 COLON-ALIGNED NO-LABEL WIDGET-ID 784
     fi_bustyp-2 AT ROW 11.67 COL 117 COLON-ALIGNED NO-LABEL WIDGET-ID 786
     fi_cardtyp AT ROW 10.48 COL 141.5 COLON-ALIGNED NO-LABEL WIDGET-ID 792
     fi_cardtyp-2 AT ROW 11.62 COL 141.5 COLON-ALIGNED NO-LABEL WIDGET-ID 794
     fi_icno AT ROW 10.48 COL 166 COLON-ALIGNED NO-LABEL WIDGET-ID 798
     fi_icno-2 AT ROW 11.62 COL 166 COLON-ALIGNED NO-LABEL WIDGET-ID 800
     fi_drilic-3 AT ROW 12.76 COL 3.67 COLON-ALIGNED NO-LABEL WIDGET-ID 810
     fi_drname-3 AT ROW 12.76 COL 36.67 COLON-ALIGNED NO-LABEL WIDGET-ID 814
     fi_dob-3 AT ROW 12.76 COL 74.17 COLON-ALIGNED NO-LABEL WIDGET-ID 808
     fi_drititle-3 AT ROW 12.71 COL 23.83 COLON-ALIGNED NO-LABEL WIDGET-ID 812
     fi_gender-3 AT ROW 12.76 COL 87 COLON-ALIGNED NO-LABEL WIDGET-ID 816
     fi_occup-3 AT ROW 12.76 COL 93.5 COLON-ALIGNED NO-LABEL WIDGET-ID 820
     fi_bustyp-3 AT ROW 12.81 COL 117 COLON-ALIGNED NO-LABEL WIDGET-ID 804
     fi_cardtyp-3 AT ROW 12.76 COL 141.5 COLON-ALIGNED NO-LABEL WIDGET-ID 806
     fi_icno-3 AT ROW 12.76 COL 166 COLON-ALIGNED NO-LABEL WIDGET-ID 818
     fi_drilic-4 AT ROW 13.91 COL 3.67 COLON-ALIGNED NO-LABEL WIDGET-ID 830
     fi_drname-4 AT ROW 13.91 COL 36.67 COLON-ALIGNED NO-LABEL WIDGET-ID 834
     fi_dob-4 AT ROW 13.91 COL 74.17 COLON-ALIGNED NO-LABEL WIDGET-ID 828
     fi_drititle-4 AT ROW 13.86 COL 23.83 COLON-ALIGNED NO-LABEL WIDGET-ID 832
     fi_gender-4 AT ROW 13.91 COL 87 COLON-ALIGNED NO-LABEL WIDGET-ID 836
     fi_occup-4 AT ROW 13.91 COL 93.5 COLON-ALIGNED NO-LABEL WIDGET-ID 840
     fi_bustyp-4 AT ROW 13.95 COL 117 COLON-ALIGNED NO-LABEL WIDGET-ID 824
     fi_cardtyp-4 AT ROW 13.91 COL 141.5 COLON-ALIGNED NO-LABEL WIDGET-ID 826
     fi_icno-4 AT ROW 13.91 COL 166 COLON-ALIGNED NO-LABEL WIDGET-ID 838
     fi_drilic-5 AT ROW 15 COL 3.5 COLON-ALIGNED NO-LABEL WIDGET-ID 850
     fi_drname-5 AT ROW 15 COL 36.5 COLON-ALIGNED NO-LABEL WIDGET-ID 854
     fi_dob-5 AT ROW 15 COL 74 COLON-ALIGNED NO-LABEL WIDGET-ID 848
     fi_drititle-5 AT ROW 14.95 COL 23.67 COLON-ALIGNED NO-LABEL WIDGET-ID 852
     fi_gender-5 AT ROW 15 COL 86.83 COLON-ALIGNED NO-LABEL WIDGET-ID 856
     fi_occup-5 AT ROW 15 COL 93.33 COLON-ALIGNED NO-LABEL WIDGET-ID 860
     fi_bustyp-5 AT ROW 15.05 COL 116.83 COLON-ALIGNED NO-LABEL WIDGET-ID 844
     fi_cardtyp-5 AT ROW 15 COL 141.33 COLON-ALIGNED NO-LABEL WIDGET-ID 846
     fi_icno-5 AT ROW 15 COL 165.83 COLON-ALIGNED NO-LABEL WIDGET-ID 858
     "2.":30 VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 11.57 COL 3.5 WIDGET-ID 662
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "วันที่ปิดเรื่อง:":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 20.43 COL 3.5 WIDGET-ID 718
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "สีรถ :":30 VIEW-AS TEXT
          SIZE 6 BY 1 AT ROW 6 COL 31.33 WIDGET-ID 668
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ส่งตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 15.17 BY 1 AT ROW 18.1 COL 3.67 WIDGET-ID 700
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "อุปกรณ์เสริม  :":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 22.71 COL 3.5 WIDGET-ID 726
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  ปีที่ผลิตรถ  :":30 VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 4.71 COL 113 WIDGET-ID 618
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " รุ่นรถ  :":30 VIEW-AS TEXT
          SIZE 9.33 BY 1 AT ROW 3.62 COL 47.17 WIDGET-ID 586
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันที่แก้ไขล่าสุด :":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 18.1 COL 152.17 WIDGET-ID 706
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  ยี่ห้อรถ  :":30 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 3.62 COL 3.83 WIDGET-ID 582
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "แรงม้า (Power) :":30 VIEW-AS TEXT
          SIZE 15.33 BY 1 AT ROW 5.95 COL 94.83 WIDGET-ID 734
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  รหัสรถ :":30 VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 2.43 COL 96.17 WIDGET-ID 574
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  เลขตัวถัง  :":30 VIEW-AS TEXT
          SIZE 18.67 BY 1 AT ROW 4.81 COL 3.83 WIDGET-ID 606
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Payment option :":30 VIEW-AS TEXT
          SIZE 17 BY 1 AT ROW 7.1 COL 89 WIDGET-ID 738
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันเกิด":30 VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 9.48 COL 76.33 WIDGET-ID 652
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "วันที่จดทะเบียนครั้งแรก :":30 VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 7.1 COL 47.5 WIDGET-ID 742
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ความเสียหาย :":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 21.57 COL 3.5 WIDGET-ID 722
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Battery Number :":30 VIEW-AS TEXT
          SIZE 17.5 BY 1 AT ROW 7.1 COL 136.5 WIDGET-ID 746
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Battery Year :":30 VIEW-AS TEXT
          SIZE 18.33 BY 1 AT ROW 8.19 COL 4.17 WIDGET-ID 750
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Market value price :":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 8.24 COL 33.83 WIDGET-ID 754
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Wall Charge Number :":30 VIEW-AS TEXT
          SIZE 22.5 BY 1 AT ROW 8.24 COL 70.17 WIDGET-ID 758
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "1.":30 VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 10.43 COL 3.5 WIDGET-ID 654
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Vehicle_Key  :":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 8.24 COL 136.5 WIDGET-ID 762
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  ประเภทรถ :":30 VIEW-AS TEXT
          SIZE 15 BY 1 AT ROW 2.38 COL 136.33 WIDGET-ID 578
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "คำนำหน้าชื่อ":30 VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 9.48 COL 26 WIDGET-ID 770
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "เพศ":30 VIEW-AS TEXT
          SIZE 5.83 BY .91 AT ROW 9.48 COL 89.17 WIDGET-ID 776
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "อาชีพ":30 VIEW-AS TEXT
          SIZE 22.83 BY .91 AT ROW 9.48 COL 95.67 WIDGET-ID 782
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  ประเภททรัพย์สิน :":30 VIEW-AS TEXT
          SIZE 18.67 BY 1 AT ROW 2.43 COL 3.83 WIDGET-ID 566
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  น้ำหนัก/ตัน :":30 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 6 COL 4 WIDGET-ID 624
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ชื่อผู้ขับขี่":30 VIEW-AS TEXT
          SIZE 36.67 BY .91 AT ROW 9.48 COL 38.83 WIDGET-ID 648
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ประเภทธุรกิจ":30 VIEW-AS TEXT
          SIZE 23.83 BY .91 AT ROW 9.52 COL 119.17 WIDGET-ID 788
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ประเภทบัตร":30 VIEW-AS TEXT
          SIZE 23.83 BY .91 AT ROW 9.48 COL 143.67 WIDGET-ID 796
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขบัตร/Passport":30 VIEW-AS TEXT
          SIZE 19 BY .91 AT ROW 9.48 COL 168 WIDGET-ID 802
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "3.":30 VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 12.71 COL 3.5 WIDGET-ID 822
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ข้อมูลตรวจสภาพ :" VIEW-AS TEXT
          SIZE 16.5 BY .62 AT ROW 17.14 COL 3.67 WIDGET-ID 676
          BGCOLOR 91 FGCOLOR 2 FONT 6
     "ผลตรวจสภาพ  :":30 VIEW-AS TEXT
          SIZE 15.5 BY 1 AT ROW 20.43 COL 37 WIDGET-ID 692
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "4.":30 VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 13.86 COL 3.5 WIDGET-ID 842
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "5.":30 VIEW-AS TEXT
          SIZE 2 BY 1 AT ROW 14.95 COL 3.33 WIDGET-ID 862
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ประเภทย่อยทรัพย์สิน :":30 VIEW-AS TEXT
          SIZE 21.33 BY 1 AT ROW 2.43 COL 47.17 WIDGET-ID 570
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  ประเภท รย.  :":30 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 7.1 COL 4 WIDGET-ID 640
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  ขนาดซีซีรถ :":30 VIEW-AS TEXT
          SIZE 13.17 BY 1 AT ROW 4.71 COL 138.33 WIDGET-ID 620
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ซีซีรถ/น้ำหนัก/ตัน :":30 VIEW-AS TEXT
          SIZE 17.67 BY 1 AT ROW 5.95 COL 65.17 WIDGET-ID 628
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  New/Used :":30 VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 3.57 COL 96 WIDGET-ID 596
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ข้อมูลรถ :" VIEW-AS TEXT
          SIZE 12.5 BY .62 AT ROW 1.52 COL 3 WIDGET-ID 670
          BGCOLOR 91 FGCOLOR 2 FONT 6
     "เลขที่กล่องตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 20.83 BY 1 AT ROW 18.05 COL 78.33 WIDGET-ID 694
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "N = ไม่ตรวจสภาพ" VIEW-AS TEXT
          SIZE 15.17 BY .62 AT ROW 18.57 COL 25 WIDGET-ID 708
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "วัน-เวลา ที่นัดหมาย :":30 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 18.1 COL 115.67 WIDGET-ID 696
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " เลขไมล์ (กม.) :":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 6 COL 121.5 WIDGET-ID 632
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "  สถานะปิดกล่อง :":30 VIEW-AS TEXT
          SIZE 16.67 BY 1 AT ROW 18.1 COL 41.33 WIDGET-ID 698
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  เลขเครื่องยนต์  :":30 VIEW-AS TEXT
          SIZE 16.17 BY 1 AT ROW 4.76 COL 52.33 WIDGET-ID 608
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  เลขทะเบียนรถ :":30 VIEW-AS TEXT
          SIZE 15.17 BY 1 AT ROW 3.57 COL 136.33 WIDGET-ID 598
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "สถานที่นัดหมาย :":30 VIEW-AS TEXT
          SIZE 15.17 BY 1 AT ROW 19.29 COL 3.67 WIDGET-ID 690
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "เลขใบขับขี่":30 VIEW-AS TEXT
          SIZE 19.83 BY .91 AT ROW 9.48 COL 5.67 WIDGET-ID 644
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Y = ตรวจสภาพ" VIEW-AS TEXT
          SIZE 15.17 BY .62 AT ROW 17.95 COL 25 WIDGET-ID 710
          BGCOLOR 19 FGCOLOR 6 FONT 1
     "N = ไม่ปิดกล่อง" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 18.57 COL 64.67 WIDGET-ID 712
          BGCOLOR 19 FGCOLOR 6 FONT 1
     " ประเภทการซ่อมบำรุง :":30 VIEW-AS TEXT
          SIZE 20.5 BY 1 AT ROW 6 COL 146.83 WIDGET-ID 638
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Y = ปิดกล่อง" VIEW-AS TEXT
          SIZE 13 BY .62 AT ROW 17.95 COL 64.67 WIDGET-ID 714
          BGCOLOR 19 FGCOLOR 6 FONT 1
     RECT-81 AT ROW 1.24 COL 1.5 WIDGET-ID 664
     RECT-84 AT ROW 17.33 COL 2.67 WIDGET-ID 702
     RECT-85 AT ROW 1.71 COL 2.83 WIDGET-ID 790
     SPACE(0.83) SKIP(10.33)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19 
         TITLE "Query & Review Vehicle" WIDGET-ID 100.


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

/* SETTINGS FOR FILL-IN fi_battno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_battyr IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brandcar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_brandcar-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bustyp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bustyp-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bustyp-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bustyp-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_bustyp-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_car IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_carc IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cardtyp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cardtyp-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cardtyp-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cardtyp-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cardtyp-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_caryr IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_chano IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_chargno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_colors IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dateregis IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dob-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dob-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dob-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dob-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drilic IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drilic-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drilic-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drilic-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drilic-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drname IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drname-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drname-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drname-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_drname-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_engno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_engno-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_garage IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_gender IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_gender-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_gender-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_gender-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_gender-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_HP IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_icno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_icno-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_icno-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_icno-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_icno-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispacc IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispappoit IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispclose IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispdam IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_isplocal IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispresult IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispsts IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ispupdate IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_maksi IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_mil IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_occup IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_occup-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_occup-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_occup-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_occup-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_pay_option IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_scar IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_subtyp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ton IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_tons IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_typc IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_veh IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_vehpro IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_veh_key IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /* Query  Review Vehicle */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_Cancel
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_Cancel Dialog-Frame
ON CHOOSE OF Btn_Cancel IN FRAME Dialog-Frame /* Cancel */
DO:
      APPLY "Close":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* OK */
DO:
  ASSIGN
   nv_atyp           = trim(input fi_typ          )
   nv_asubtyp        = trim(input fi_subtyp       )
   nv_acarc          = trim(input fi_carc         )
   nv_atypc          = trim(input fi_typc         )
   nv_abrandcar      = trim(input fi_brandcar     )
   nv_abrandcar-2    = trim(input fi_brandcar-2   )
   nv_ascar          = trim(input fi_scar         )
   nv_aveh           = trim(input fi_veh          )
   nv_avehpro        = trim(input fi_vehpro       )
   nv_achano         = trim(input fi_chano        )
   nv_aengno         = trim(input fi_engno        )
   nv_aengno-2       = trim(input fi_engno-2      )
   nv_aton           = trim(input fi_ton          )
   nv_acaryr         = trim(input fi_caryr        )
   nv_atons          = trim(input fi_tons         )
   nv_amil           = trim(input fi_mil          )
   nv_agarage        = trim(input fi_garage       )
   nv_acar           = trim(input fi_car          )
   nv_adrilic        = trim(input fi_drilic       )
   nv_adrname        = trim(input fi_drname       )
   nv_adob           = trim(input fi_dob          )
   nv_adrilic-2      = trim(input fi_drilic-2     )
   nv_adrname-2      = trim(input fi_drname-2     )
   nv_adob-2         = trim(input fi_dob-2        ) 
   /* add by : A65-0288 */
   nv_colors     = trim(input fi_colors)             
   nv_ispchk     = trim(input fi_ispchk)             
   nv_ispsts     = trim(input fi_ispsts)             
   nv_ispno      = trim(input fi_ispno )             
   nv_ispappoit  = IF input fi_ispappoit <> ? then string(input fi_ispappoit,"99/99/9999")  else "" 
   nv_ispupdate  = if input fi_ispupdate <> ? then string(input fi_ispupdate,"99/99/9999")  else "" 
   nv_isplocal   = trim(INPUT fi_isplocal) 
   nv_ispclose   = IF INPUT fi_ispclose <> ?  THEN STRING(INPUT fi_ispclose,"99/99/9999")  else "" 
   nv_ispresult  = trim(input fi_ispresult)   
   nv_ispdam     = trim(input fi_ispdam   )   
   nv_ispacc     = trim(input fi_ispacc   ) 
   /* end : A65-0288 */ 
   /* Add by : A67-0076 */
   nv_hp            = trim(input fi_HP      )      
   nv_drititle1     = trim(input fi_drititle)     
   nv_drigender1    = trim(input fi_gender  )     
   nv_drioccup1     = trim(input fi_occup   )     
   nv_driToccup1    = trim(input fi_bustyp  )     
   nv_driTicono1    = trim(input fi_cardtyp )     
   nv_driICNo1      = trim(input fi_icno    )     
   nv_drititle2     = trim(input fi_drititle-2)   
   nv_drigender2    = trim(input fi_gender-2  )   
   nv_drioccup2     = trim(input fi_occup-2   )   
   nv_driToccup2    = trim(input fi_bustyp-2  )   
   nv_driTicono2    = trim(input fi_cardtyp-2 )   
   nv_driICNo2      = trim(input fi_icno-2    )   
   nv_drilic3       = trim(input fi_drilic-3  )   
   nv_drititle3     = trim(input fi_drititle-3)   
   nv_driname3      = trim(input fi_drname-3  )   
   nv_drivno3       = trim(input fi_dob-3     )   
   nv_drigender3    = trim(input fi_gender-3  )   
   nv_drioccup3     = trim(input fi_occup-3   )   
   nv_driToccup3    = trim(input fi_bustyp-3  )   
   nv_driTicono3    = trim(input fi_cardtyp-3 )   
   nv_driICNo3      = trim(input fi_icno-3    )   
   nv_drilic4       = trim(input fi_drilic-4  )   
   nv_drititle4     = trim(input fi_drititle-4)   
   nv_driname4      = trim(input fi_drname-4  )   
   nv_drivno4       = trim(input fi_dob-4  ~  )   
   nv_drigender4    = trim(input fi_gender-4  )   
   nv_drioccup4     = trim(input fi_occup-4   )   
   nv_driToccup4    = trim(input fi_bustyp-4  )   
   nv_driTicono4    = trim(input fi_cardtyp-4 )   
   nv_driICNo4      = trim(input fi_icno-4    )   
   nv_drilic5       = trim(input fi_drilic-5  )   
   nv_drititle5     = trim(input fi_drititle-5)   
   nv_driname5      = trim(input fi_drname-5  )   
   nv_drivno5       = trim(input fi_dob-5     )   
   nv_drigender5    = trim(input fi_gender-5  )   
   nv_drioccup5     = trim(input fi_occup-5   )   
   nv_driToccup5    = trim(input fi_bustyp-5  )   
   nv_driTicono5    = trim(input fi_cardtyp-5 )   
   nv_driICNo5      = trim(input fi_icno-5    )   
   nv_dateregis     = STRING(INPUT fi_dateregis)   
   nv_pay_option    = trim(INPUT fi_pay_option)   
   nv_battno        = trim(INPUT fi_battno    )   
   nv_battyr        = STRING(INPUT fi_battyr )   
   nv_maksi         = STRING(INPUT fi_maksi  )   
   nv_chargno       = trim(INPUT fi_chargno   )   
   nv_veh_key       = trim(INPUT fi_veh_key   )  .
   /* end : A67-0076 */ 
    APPLY "Close":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_update
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_update Dialog-Frame
ON CHOOSE OF bu_update IN FRAME Dialog-Frame /* Update ISP */
DO:
    DEF VAR nv_styear AS CHAR INIT "". /*---add by Chaiyong W. A65-0288 05/01/2023*/
    ASSIGN  nv_year      = ""   nv_docno  = ""      nv_survey   = ""    nv_detail  = ""     nv_remark1 = ""     nv_remark2  = ""
            nv_damlist   = ""   nv_damage = ""      nv_totaldam = ""    nv_attfile = ""     nv_device  = ""     nv_acc1     = ""
            nv_acc2      = ""   nv_acc3   = ""      nv_acc4     = ""    nv_acc5    = ""     nv_acc6    = ""     nv_acc7     = ""
            nv_acc8      = ""   nv_acc9   = ""      nv_acc10    = ""    nv_acc11   = ""     nv_acc12   = ""     nv_acctotal = ""
            nv_surdata   = ""   nv_tmp    = ""      nv_date     = ""    n_list     = 0      n_agent    = ""     nv_remark3  = ""     
            nv_remark4   = ""   n_deatil    = ""    nv_chk      = ""    nv_apploc   = ""    nv_Dappoint = ""  
            nv_commt     = ""   nv_chkname  = ""    nv_Lappoint = ""    nv_appdate   = ""   nv_chkdate  = ""    nv_comment    = ""  
            nv_damdetail = ""   nv_damage   = ""    nv_damlist    = ""  n_count      = 0    nv_totaldam = ""    n_repair      = ""
            nv_damag     = ""   n_dam       = ""    nv_repair     = ""
            
            nv_year     = STRING(YEAR(TODAY),"9999")
            nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf".
    /*--------- Server Real ----------*/
    nv_server = "Safety_NotesServer/Safety".
    nv_tmp   = "safety\uw\" + nv_tmp .
   /*-------------------------------*/
    /*---------- Server test local ----------
    nv_server = "". 
    nv_tmp    = "D:\Lotus\Notes\Data\ranu\" + nv_tmp .
    ---------------------------------------*/
    /*---Begin by Chaiyong W. A65-0288 05/01/2023*/
    nv_styear = "Now YEAR".
    loop_updateisp:
    REPEAT:
        IF nv_styear = "Previous Year" THEN DO:
            RELEASE  OBJECT chitem          NO-ERROR.
            RELEASE  OBJECT chDocument      NO-ERROR.          
            RELEASE  OBJECT chNotesDataBase NO-ERROR.     
            RELEASE  OBJECT chNotesSession  NO-ERROR.
            ASSIGN
               nv_year     = STRING(YEAR(TODAY) - 1,"9999")
               nv_tmp      = "Inspect" + SUBSTR(nv_year,3,2) + ".nsf"
               nv_server   = "Safety_NotesServer/Safety"
               nv_tmp      = "safety\uw\" + nv_tmp .


        END.

    /*End by Chaiyong W. A65-0288 05/01/2023-----*/
        CREATE "Notes.NotesSession"  chNotesSession.
        chNotesDatabase  = chNotesSession:GetDatabase(nv_server,nv_tmp).
        
        IF  chNotesDatabase:IsOpen() = NO  THEN  DO:

             /*---Begin by Chaiyong W. A65-0288 05/01/2023*/
             IF nv_styear = "Previous Year" THEN DO:
                MESSAGE "Can not open database" SKIP  
                    "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
        
             END.
             /*End by Chaiyong W. A65-0288 05/01/2023-----*/

            /*--
         MESSAGE "Can not open database" SKIP  
                 "Please Check database and serve" VIEW-AS  ALERT-BOX ERROR.
                 comment by Chaiyong W. A65-0288 05/01/2023*/
        END.
        ELSE DO:
          chNotesView    = chNotesDatabase:GetView("chassis_no").
          chNavView      = chNotesView:CreateViewNavFromCategory(TRIM(fi_chano)).
          chViewEntry    = chNavView:GetLastDocument.
    
            IF chViewEntry <> 0 THEN DO: 
                chDocument = chViewEntry:Document.
                
                IF VALID-HANDLE(chDocument) = YES THEN DO:
                   RUN Proc_Getdatainsp.
                   IF nv_docno <> ""  THEN DO:
                       IF nv_survey <> "" THEN DO: /* ปิดเรื่องแล้ว */
                           IF nv_detail = "ติดปัญหา" THEN DO:
                               /* ASSIGN brstat.tlt.lotno         = "Y" 
                                      brstat.tlt.acno1         = nv_docno + " Close Date: " + nv_date   /*เลขที่ตรวจสภาพ  + วันที่ปิดเรื่อง*/  
                                      brstat.tlt.mobile        = nv_detail + " : " + nv_damage + " " + nv_damdetail /* ความเสียหาย */ /*รายการความเสียหาย */
                                      brstat.tlt.fax           = nv_device + " " + nv_acctotal. */       /*รายละเอียดอุปกรณ์เสริม  + ราคารวมอุปกรณ์ */ 
                               ASSIGN 
                               fi_ispsts     = "Y"
                               fi_ispno      = nv_docno
                               fi_ispappoit  = ?
                               fi_ispupdate  = ?
                               fi_isplocal   = ""
                               fi_ispclose   = DATE(nv_date)
                               fi_ispresult  = nv_detail
                               fi_ispdam     = nv_damage + " " + nv_damdetail 
                               fi_ispacc     = nv_device + " " + nv_acctotal /*17/11/2022*/ . 
                           END.
                           ELSE IF nv_detail = "มีความเสียหาย"  THEN DO:
                               /*ASSIGN brstat.tlt.lotno      = "Y"
                                      brstat.tlt.acno1      = nv_docno + " Close Date: " + nv_date   /*เลขที่ตรวจสภาพ  + วันที่ปิดเรื่อง*/                      
                                      brstat.tlt.mobile     = nv_detail + " : " + nv_damlist + nv_totaldam  + " " + nv_damdetail /* ความเสียหาย + รายการความเสียหาย */
                                      brstat.tlt.fax        = nv_device + " " + nv_acctotal. */      /*รายละเอียดอุปกรณ์เสริม */  
                               ASSIGN 
                               fi_ispsts     = "Y"
                               fi_ispno      = nv_docno
                               fi_ispappoit  = ?
                               fi_ispupdate  = ?
                               fi_isplocal   = ""
                               fi_ispclose   = DATE(nv_date)
                               fi_ispresult  = nv_detail
                               fi_ispdam     = nv_damlist /*+ nv_totaldam 17/11/2022*/  + " " +  nv_damdetail
                               fi_ispacc     = nv_device + " " + nv_acctotal /*17/11/2022*/. 
                           END.
                           ELSE DO:
                               /*ASSIGN brstat.tlt.lotno     = "Y" 
                                      brstat.tlt.acno1     = nv_docno +  " Close Date: " + nv_date   /*เลขที่ตรวจสภาพ  + วันที่ปิดเรื่อง*/  
                                      brstat.tlt.mobile    = nv_detail + " " + nv_damdetail /* ความเสียหาย */ /*รายการความเสียหาย */
                                      brstat.tlt.fax       = nv_device + " " + nv_acctotal.  */   /*รายละเอียดอุปกรณ์เสริม */  
                               ASSIGN 
                               fi_ispsts     = "Y"
                               fi_ispno      = nv_docno
                               fi_ispappoit  = ?
                               fi_ispupdate  = ?
                               fi_isplocal   = ""
                               fi_ispclose   = DATE(nv_date)
                               fi_ispresult  = nv_detail
                               fi_ispdam     = nv_damage + " " + nv_damdetail
                               fi_ispacc     = nv_device + " " + nv_acctotal /*17/11/2022*/. 
                           END.
                           IF nv_totaldam <> "" THEN fi_ispdam  = fi_ispdam + " " + nv_totaldam. /*---add by Chaiyong W. A65-0288 22/12/2022*/
    
    
                       END.
                       ELSE DO: /* ยังไม่ปิดเรื่อง */
                         /*ASSIGN brstat.tlt.lotno     =  "N" 
                                brstat.tlt.acno1     =  nv_docno + " Edit Date: " + nv_remark2    /*เลขที่ตรวจสภาพ  + วันที่ update กล่อง*/      
                                brstat.tlt.mobile    =  nv_remark3     /* วันที่นัดหมาย */            
                                brstat.tlt.fax       =  nv_remark4    /*สถานที่นัดหมาย */ 
                                brstat.tlt.note24    =  IF tlt.note24 <> "" THEN tlt.note24  + "," + nv_message + " เลขกล่อง : " + nv_docno
                                                        ELSE nv_message + " เลขกล่อง : " + nv_docno.*/
                           ASSIGN 
                               fi_ispsts     = "N"
                               fi_ispno      = nv_docno
                               fi_ispappoit  = if trim(nv_remark3) = "" THEN ? ELSE DATE(nv_remark3)
                               fi_ispupdate  = DATE(nv_remark2)
                               fi_isplocal   = nv_remark4
                               fi_ispclose   = ?
                               fi_ispresult  = ""
                               fi_ispdam     = ""
                               fi_ispacc     = "".
                       END.
              
                   END. /* end docno <> "" */
                   ELSE DO:
                       /*ASSIGN brstat.tlt.lotno     = "N"
                              brstat.tlt.acno1     = " Edit Date: " + nv_remark2    /*เลขที่ตรวจสภาพ  + วันที่ update กล่อง*/      
                              brstat.tlt.mobile    =  nv_remark3                    /* วันที่นัดหมาย */            
                              brstat.tlt.fax       =  nv_remark4                    /*สถานที่นัดหมาย */
                              brstat.tlt.note24    =  IF tlt.note24 <> "" THEN tlt.note24  + "," + nv_message ELSE nv_message.*/
                       ASSIGN 
                               fi_ispsts     = "N"
                               fi_ispno      = nv_docno
                               fi_ispappoit  = if trim(nv_remark3) = "" THEN ? ELSE DATE(nv_remark3)
                               fi_ispupdate  = DATE(nv_remark2) 
                               fi_isplocal   = nv_remark4
                               fi_ispclose   = ?
                               fi_ispresult  = ""
                               fi_ispdam     = ""
                               fi_ispacc     = "".
                   END.
            
                   RELEASE  OBJECT chitem          NO-ERROR.
                   RELEASE  OBJECT chDocument      NO-ERROR.          
                   RELEASE  OBJECT chNotesDataBase NO-ERROR.     
                   RELEASE  OBJECT chNotesSession  NO-ERROR.
                   LEAVE loop_updateisp. /*---Add by Chaiyong W. A65-0288 05/01/2023*/
                END.  /* end chDocument = yes */
            END.
        END.
    /*---Begin by Chaiyong W. A65-0288 05/01/2023*/
        IF nv_styear = "Now YEAR" THEN DO:
            nv_styear = "Previous Year".
        END.
        ELSE LEAVE loop_updateisp.

        
    END.
    /*End by Chaiyong W. A65-0288 05/01/2023-----*/
    DISP  fi_ispsts    
          fi_ispno     
          fi_ispappoit 
          fi_ispupdate 
          fi_isplocal  
          fi_ispclose  
          fi_ispresult 
          fi_ispdam    
          fi_ispacc  WITH FRAME Dialog-Frame . 

    MESSAGE " Check Data Inspection Complete " VIEW-AS ALERT-BOX.          
      /*--- end : A60-0118----*/
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_chano
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_chano Dialog-Frame
ON LEAVE OF fi_chano IN FRAME Dialog-Frame
DO:
    fi_chano = TRIM(CAPS(INPUT fi_chano)).
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
  DEF  VAR  gv_prgid   AS   CHAR.
  DEF  VAR  gv_prog    AS   CHAR.

  gv_prgid = "WGWVTLKK2.W".
  gv_prog  = "Query & Review Vehicle".
  RUN  WUT\WUTHEAD ({&WINDOW-NAME}:HANDLE,gv_prgid,gv_prog).
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
  DISPLAY fi_drititle fi_typ fi_subtyp fi_carc fi_typc fi_brandcar fi_brandcar-2 
          fi_scar fi_veh fi_vehpro fi_chano fi_engno fi_caryr fi_engno-2 fi_ton 
          fi_tons fi_mil fi_garage fi_car fi_drilic fi_drname fi_dob fi_drilic-2 
          fi_drname-2 fi_dob-2 fi_colors fi_ispchk fi_ispsts fi_ispno 
          fi_ispresult fi_isplocal fi_ispupdate fi_ispclose fi_ispdam fi_ispacc 
          fi_ispappoit fi_HP fi_pay_option fi_dateregis fi_battno fi_battyr 
          fi_maksi fi_chargno fi_veh_key fi_drititle-2 fi_gender fi_gender-2 
          fi_occup fi_occup-2 fi_bustyp fi_bustyp-2 fi_cardtyp fi_cardtyp-2 
          fi_icno fi_icno-2 fi_drilic-3 fi_drname-3 fi_dob-3 fi_drititle-3 
          fi_gender-3 fi_occup-3 fi_bustyp-3 fi_cardtyp-3 fi_icno-3 fi_drilic-4 
          fi_drname-4 fi_dob-4 fi_drititle-4 fi_gender-4 fi_occup-4 fi_bustyp-4 
          fi_cardtyp-4 fi_icno-4 fi_drilic-5 fi_drname-5 fi_dob-5 fi_drititle-5 
          fi_gender-5 fi_occup-5 fi_bustyp-5 fi_cardtyp-5 fi_icno-5 
      WITH FRAME Dialog-Frame.
  ENABLE fi_drititle bu_update fi_typ Btn_OK Btn_Cancel fi_ispchk fi_drititle-2 
         fi_drititle-3 fi_drititle-4 fi_drititle-5 RECT-81 RECT-84 RECT-85 
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
fi_typ           =   nv_atyp       
fi_subtyp        =   nv_asubtyp    
fi_carc          =   nv_acarc      
fi_typc          =   nv_atypc      
fi_brandcar      =   nv_abrandcar  
fi_brandcar-2    =   nv_abrandcar-2
fi_scar          =   nv_ascar      
fi_veh           =   nv_aveh       
fi_vehpro        =   nv_avehpro    
fi_chano         =   nv_achano     
fi_engno         =   nv_aengno     
fi_engno-2       =   nv_aengno-2   
fi_ton           =   nv_aton       
fi_caryr         =   nv_acaryr     
fi_tons          =   nv_atons      
fi_mil           =   nv_amil       
fi_garage        =   nv_agarage    
fi_car           =   nv_acar       
fi_drilic        =   nv_adrilic    
fi_drname        =   nv_adrname    
fi_dob           =   nv_adob       
fi_drilic-2      =   nv_adrilic-2  
fi_drname-2      =   nv_adrname-2  
fi_dob-2         =   nv_adob-2 
/* Add : A65-0288 */
fi_colors        =   nv_colors    
fi_ispchk        =   nv_ispchk    
fi_ispsts        =   nv_ispsts    
fi_ispno         =   nv_ispno     
fi_ispappoit     =   IF nv_ispappoit <> "" THEN DATE(nv_ispappoit) ELSE ?
fi_ispupdate     =   if nv_ispupdate <> "" then date(nv_ispupdate) else ? 
fi_isplocal      =   nv_isplocal  
fi_ispclose      =   IF nv_ispclose  <> "" THEN DATE(nv_ispclose)  ELSE ?
fi_ispresult     =   nv_ispresult 
fi_ispdam        =   nv_ispdam    
fi_ispacc        =   nv_ispacc    .
/* end : A65-0288 */
/* add by : A67-0076 */
ASSIGN 
fi_HP          =  nv_hp         
fi_drititle    =  nv_drititle1  
fi_gender      =  nv_drigender1 
fi_occup       =  nv_drioccup1  
fi_bustyp      =  nv_driToccup1 
fi_cardtyp     =  nv_driTicono1 
fi_icno        =  nv_driICNo1   
fi_drititle-2  =  nv_drititle2     
fi_gender-2    =  nv_drigender2   
fi_occup-2     =  nv_drioccup2    
fi_bustyp-2    =  nv_driToccup2   
fi_cardtyp-2   =  nv_driTicono2   
fi_icno-2      =  nv_driICNo2     
fi_drilic-3    =  nv_drilic3      
fi_drititle-3  =  nv_drititle3    
fi_drname-3    =  nv_driname3     
fi_dob-3       =  nv_drivno3      
fi_gender-3    =  nv_drigender3   
fi_occup-3     =  nv_drioccup3    
fi_bustyp-3    =  nv_driToccup3   
fi_cardtyp-3   =  nv_driTicono3   
fi_icno-3      =  nv_driICNo3     
fi_drilic-4    =  nv_drilic4      
fi_drititle-4  =  nv_drititle4    
fi_drname-4    =  nv_driname4     
fi_dob-4       =  nv_drivno4      
fi_gender-4    =  nv_drigender4   
fi_occup-4     =  nv_drioccup4    
fi_bustyp-4    =  nv_driToccup4   
fi_cardtyp-4   =  nv_driTicono4   
fi_icno-4      =  nv_driICNo4     
fi_drilic-5    =  nv_drilic5      
fi_drititle-5  =  nv_drititle5    
fi_drname-5    =  nv_driname5     
fi_dob-5       =  nv_drivno5      
fi_gender-5    =  nv_drigender5   
fi_occup-5     =  nv_drioccup5    
fi_bustyp-5    =  nv_driToccup5   
fi_cardtyp-5   =  nv_driTicono5   
fi_icno-5      =  nv_driICNo5    
fi_pay_option  =  nv_pay_option     
fi_dateregis   =  DATE(nv_dateregis)  
fi_battno      =  nv_battno       
fi_battyr      =  INTE(nv_battyr)       
fi_maksi       =  deci(nv_maksi)        
fi_chargno     =  nv_chargno      
fi_veh_key     =  nv_veh_key . 

DISPLAY fi_typ  fi_subtyp   fi_carc     /*fi_ty65pc*/     fi_brandcar fi_brandcar-2   fi_scar 
        fi_veh  fi_vehpro   fi_chano    fi_engno    fi_engno-2  fi_ton          fi_caryr    
        fi_tons fi_mil      fi_garage   fi_car      fi_drilic   fi_drname       fi_dob          
        fi_drilic-2         fi_drname-2 fi_dob-2 
        /* Add by : A65-0288 */
        fi_colors     fi_ispchk   fi_ispsts   fi_ispno    fi_ispappoit    fi_ispupdate
        fi_isplocal   fi_ispclose fi_ispresult fi_ispdam  fi_ispacc   
        /* end : A65-0288 */
        /* Add by : A67-0076 */
        fi_HP       fi_drititle     fi_gender     fi_occup      fi_bustyp     fi_cardtyp    
        fi_icno     fi_drititle-2   fi_gender-2   fi_occup-2    fi_bustyp-2   fi_cardtyp-2  
        fi_icno-2   fi_drilic-3     fi_drititle-3 fi_drname-3   fi_dob-3      fi_gender-3   
        fi_occup-3  fi_bustyp-3     fi_cardtyp-3  fi_icno-3     fi_drilic-4   fi_drititle-4 
        fi_drname-4 fi_dob-4        fi_gender-4   fi_occup-4    fi_bustyp-4   fi_cardtyp-4  
        fi_icno-4   fi_drilic-5     fi_drititle-5 fi_drname-5   fi_dob-5      fi_gender-5   
        fi_occup-5  fi_bustyp-5     fi_cardtyp-5  fi_icno-5     fi_pay_option fi_dateregis  
        fi_battno   fi_battyr       fi_maksi      fi_chargno    fi_veh_key
       /* end : A67-0076 */
      WITH FRAME Dialog-Frame.
IF nv_ispchk = "N" THEN DO:
    ENABLE fi_typ     fi_subtyp fi_carc     fi_typc     fi_brandcar fi_brandcar-2 fi_scar 
           fi_veh     fi_vehpro fi_chano    fi_engno    fi_engno-2  fi_ton        fi_caryr fi_tons 
           fi_mil     fi_garage fi_car      fi_drilic   fi_drname   fi_dob        fi_drilic-2 
           fi_drname-2 fi_dob-2 
          /* Add by : A67-0076 */
           fi_HP       fi_drititle     fi_gender     fi_occup      fi_bustyp     fi_cardtyp    
           fi_icno     fi_drititle-2   fi_gender-2   fi_occup-2    fi_bustyp-2   fi_cardtyp-2  
           fi_icno-2   fi_drilic-3     fi_drititle-3 fi_drname-3   fi_dob-3      fi_gender-3   
           fi_occup-3  fi_bustyp-3     fi_cardtyp-3  fi_icno-3     fi_drilic-4   fi_drititle-4 
           fi_drname-4 fi_dob-4        fi_gender-4   fi_occup-4    fi_bustyp-4   fi_cardtyp-4  
           fi_icno-4   fi_drilic-5     fi_drititle-5 fi_drname-5   fi_dob-5      fi_gender-5   
           fi_occup-5  fi_bustyp-5     fi_cardtyp-5  fi_icno-5     fi_pay_option fi_dateregis  
           fi_battno   fi_battyr       fi_maksi      fi_chargno    fi_veh_key
          /* end : A67-0076 */
           /* Add by : A65-0288 */
            fi_colors    fi_ispchk /*fi_ispsts   fi_ispno    fi_ispappoit    fi_ispupdate
            fi_isplocal  fi_ispclose fi_ispresult fi_ispdam  fi_ispacc */  
            /* end : A65-0288 */
          WITH FRAME Dialog-Frame.
END.
ELSE IF nv_ispsts = "Y" THEN DO:
    ENABLE fi_typ     fi_subtyp fi_carc     fi_typc     fi_brandcar fi_brandcar-2 fi_scar 
           fi_veh     fi_vehpro fi_chano    fi_engno    fi_engno-2  fi_ton        fi_caryr fi_tons 
           fi_mil     fi_garage fi_car      fi_drilic   fi_drname   fi_dob        fi_drilic-2 
           fi_drname-2 fi_dob-2 
            /* Add by : A67-0076 */
           fi_HP       fi_drititle     fi_gender     fi_occup      fi_bustyp     fi_cardtyp    
           fi_icno     fi_drititle-2   fi_gender-2   fi_occup-2    fi_bustyp-2   fi_cardtyp-2  
           fi_icno-2   fi_drilic-3     fi_drititle-3 fi_drname-3   fi_dob-3      fi_gender-3   
           fi_occup-3  fi_bustyp-3     fi_cardtyp-3  fi_icno-3     fi_drilic-4   fi_drititle-4 
           fi_drname-4 fi_dob-4        fi_gender-4   fi_occup-4    fi_bustyp-4   fi_cardtyp-4  
           fi_icno-4   fi_drilic-5     fi_drititle-5 fi_drname-5   fi_dob-5      fi_gender-5   
           fi_occup-5  fi_bustyp-5     fi_cardtyp-5  fi_icno-5     fi_pay_option fi_dateregis  
           fi_battno   fi_battyr       fi_maksi      fi_chargno    fi_veh_key
          /* end : A67-0076 */
           /* Add by : A65-0288 */
            fi_colors  fi_ispchk  fi_ispsts   fi_ispno    /*fi_ispappoit    fi_ispupdate
            fi_isplocal*/  fi_ispclose fi_ispresult fi_ispdam  fi_ispacc   
            /* end : A65-0288 */
          WITH FRAME Dialog-Frame.
END.
ELSE DO:
    ENABLE fi_typ     fi_subtyp fi_carc     fi_typc     fi_brandcar fi_brandcar-2 fi_scar 
           fi_veh     fi_vehpro fi_chano    fi_engno    fi_engno-2  fi_ton        fi_caryr fi_tons 
           fi_mil     fi_garage fi_car      fi_drilic   fi_drname   fi_dob        fi_drilic-2 
           fi_drname-2 fi_dob-2 
          /* Add by : A67-0076 */
           fi_HP       fi_drititle     fi_gender     fi_occup      fi_bustyp     fi_cardtyp    
           fi_icno     fi_drititle-2   fi_gender-2   fi_occup-2    fi_bustyp-2   fi_cardtyp-2  
           fi_icno-2   fi_drilic-3     fi_drititle-3 fi_drname-3   fi_dob-3      fi_gender-3   
           fi_occup-3  fi_bustyp-3     fi_cardtyp-3  fi_icno-3     fi_drilic-4   fi_drititle-4 
           fi_drname-4 fi_dob-4        fi_gender-4   fi_occup-4    fi_bustyp-4   fi_cardtyp-4  
           fi_icno-4   fi_drilic-5     fi_drititle-5 fi_drname-5   fi_dob-5      fi_gender-5   
           fi_occup-5  fi_bustyp-5     fi_cardtyp-5  fi_icno-5     fi_pay_option fi_dateregis  
           fi_battno   fi_battyr       fi_maksi      fi_chargno    fi_veh_key
          /* end : A67-0076 */
           /* Add by : A65-0288 */
            fi_colors  fi_ispchk  fi_ispsts   fi_ispno    fi_ispappoit    fi_ispupdate
            fi_isplocal  /*fi_ispclose fi_ispresult fi_ispdam  fi_ispacc */  
            /* end : A65-0288 */
          WITH FRAME Dialog-Frame.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_Getdatainsp Dialog-Frame 
PROCEDURE Proc_Getdatainsp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A65-0288    
------------------------------------------------------------------------------*/
DEF VAR n_list      AS INT init 0.
DEF VAR n_count     AS INT init 0.

DO:
      chitem       = chDocument:Getfirstitem("ConsiderDate").      /*วันที่ปิดเรื่อง*/
      IF chitem <> 0 THEN nv_date = chitem:TEXT. 
      ELSE nv_date = "".

      chitem       = chDocument:Getfirstitem("docno").      /*เลขตรวจสภาพ*/
      IF chitem <> 0 THEN nv_docno = chitem:TEXT. 
      ELSE nv_docno = "".
      
      chitem       = chDocument:Getfirstitem("SurveyClose").    /* สเตตัสปิดเรื่อง */
      IF chitem <> 0 THEN nv_survey  = chitem:TEXT. 
      ELSE nv_survey = "".

      IF nv_survey = "" THEN DO:
          chitem       = chDocument:Getfirstitem("sendby1").  /*รายละเอียดการตรวจ*/
          IF chitem <> 0 THEN  nv_remark1 = chitem:TEXT. 
          ELSE nv_remark1 = "".

          IF nv_remark1 <> "" THEN DO:
               ASSIGN  n_count = 1 .
               loop_comment:
               REPEAT:
                   IF n_count <= 7 THEN DO:
                       ASSIGN  nv_chk     = "sendby"  + STRING(n_count)  /*ชื่อเจ้าหน้าที่ update */
                               nv_commt   = "sendOn"  + STRING(n_count)    /*วันที่และเวลา update */
                               nv_appdate = "DateAppointment"   + STRING(n_count) /*+ "_C"*/     /*วันที่นัดหมาย */
                               nv_apploc  = "AppointmentLocate" + STRING(n_count) /*+ "_C"*/  .  /*สถานที่นัดหมาย */
                               /*nv_commt  = "commentIns" + STRING(n_count)   comment appointment */
          
                       chitem       = chDocument:Getfirstitem(nv_chk). 
                       IF chitem <> 0 THEN  nv_chkname  = chitem:TEXT. 
                       ELSE nv_chkname = "".  
          
                       chitem       = chDocument:Getfirstitem(nv_commt).
                       IF chitem <> 0 THEN  nv_chkdate = chitem:TEXT. 
                       ELSE nv_chkdate = "".

                       chitem       = chDocument:Getfirstitem(nv_appdate). 
                       IF chitem <> 0 THEN  nv_Dappoint  = chitem:TEXT. 
                       ELSE nv_Dappoint = ?.  
          
                       chitem       = chDocument:Getfirstitem(nv_apploc).
                       IF chitem <> 0 THEN  nv_Lappoint = chitem:TEXT. 
                       ELSE nv_Lappoint = "".

          
                       IF nv_chkname <> "" THEN DO: 
                           ASSIGN nv_remark2 = nv_chkdate   /* วันที่อัพเดท*/
                                  nv_remark3 = nv_Dappoint  /* วันที่นัดหมาย*/
                                  nv_remark4 = nv_Lappoint. /* สถานที่นัดหมาย*/
                       END.
          
                       n_count = n_count + 1.
                   END.
                   ELSE LEAVE loop_comment.
               END.
          END. /* end remark <> "" */
          ELSE DO:
            chitem       = chDocument:Getfirstitem("Chkby1").  /*ไม่มีนัดหมาย */
            IF chitem <> 0 THEN  nv_remark1 = chitem:TEXT. 
            ELSE nv_remark1 = "".
            IF nv_remark1 <> "" THEN DO:
                 ASSIGN  n_count = 1 .
                 loop_comment:
                 REPEAT:
                     IF n_count <= 7 THEN DO:
                         ASSIGN  nv_chk     = "Chkby"  + STRING(n_count)  /*ชื่อเจ้าหน้าที่ update */
                                 nv_appdate = "ChkOn"  + STRING(n_count)    /*วันที่และเวลา update */
                                 nv_apploc  = "ChksubjTo"  + STRING(n_count) /*+ "_C"*/    /*สถานที่นัดหมาย */
                                 nv_commt   = "commentIns" + STRING(n_count)  
            
                         chitem       = chDocument:Getfirstitem(nv_chk). 
                         IF chitem <> 0 THEN  nv_chkname  = chitem:TEXT. 
                         ELSE nv_chkname = "".  
            
                         /*chitem       = chDocument:Getfirstitem(nv_commt).
                         IF chitem <> 0 THEN  nv_chkdate = chitem:TEXT. 
                         ELSE nv_chkdate = "".*/
            
                         chitem       = chDocument:Getfirstitem(nv_appdate). 
                         IF chitem <> 0 THEN  nv_Dappoint  = chitem:TEXT. 
                         ELSE nv_Dappoint = ?.  
            
                         chitem       = chDocument:Getfirstitem(nv_apploc).
                         IF chitem <> 0 THEN  nv_Lappoint = chitem:TEXT. 
                         ELSE nv_Lappoint = "".

                         chitem       = chDocument:Getfirstitem(nv_commt).
                         IF chitem <> 0 THEN  nv_comment = chitem:TEXT. 
                         ELSE nv_comment = "".
            
                         IF nv_chkname <> "" THEN DO: 
                             ASSIGN nv_remark2 = nv_Dappoint   /* วันที่อัพเดท*/
                                    nv_remark3 = ""            /* วันที่นัดหมาย*/
                                    nv_remark4 = "ไม่มีนัดหมาย :" + nv_Lappoint + " " + nv_comment.  /* หัวข้อ + คอมเม้นส์ */
                         END.
                         n_count = n_count + 1.
                     END.
                     ELSE LEAVE loop_comment.
                 END. /* end repeat */
            END. /* end remark */
          END. /* end else */
      END. /* end nv_survey */

      chitem       = chDocument:Getfirstitem("SurveyResult").  /*ผลการตรวจ*/
      IF chitem <> 0 THEN  nv_detail = chitem:TEXT. 
      ELSE nv_detail = "".

      IF nv_detail = "ติดปัญหา" THEN DO:
          chitem       = chDocument:Getfirstitem("DamageC").    /*ข้อมูลการติดปัญหา */
          IF chitem <> 0 THEN nv_damage    = chitem:TEXT.
          ELSE nv_damage = "".
      END.
      IF nv_detail = "มีความเสียหาย"  THEN DO:
          chitem       = chDocument:Getfirstitem("DamageList").  /* รายการความเสียหาย */
          IF chitem <> 0 THEN nv_damlist  = chitem:TEXT.
          ELSE nv_damlist = "".
          chitem       = chDocument:Getfirstitem("TotalExpensive").  /* ราคาความเสียหาย */
          IF chitem <> 0 THEN nv_totaldam  = chitem:TEXT.
          ELSE nv_totaldam = "".

          IF nv_damlist <> "" THEN DO: 
              ASSIGN    n_list     = INT(nv_damlist) 
                        nv_damlist = "จำนวน " + nv_damlist + " รายการ " .
          END.
          IF nv_totaldam <> "" THEN ASSIGN nv_totaldam = "รวมความเสียหาย " + nv_totaldam + " บาท " . /*---
          ---17/11/2022 open comment by Chaiyong W. A65-0288 22/12/2022*/
          
          IF n_list > 0  THEN DO:
            ASSIGN  n_count = 1 .
            loop_damage:
            REPEAT:
                IF n_count <= n_list THEN DO:
                    ASSIGN  n_dam    = "List"   + STRING(n_count) 
                            n_repair = "Repair" + STRING(n_count)  .

                    chitem       = chDocument:Getfirstitem(n_dam).
                    IF chitem <> 0 THEN  nv_damag  = chitem:TEXT. 
                    ELSE nv_damag = "".

                    IF nv_damag <> "" THEN  
                        ASSIGN nv_damdetail = nv_damdetail + STRING(n_count) + "." + nv_damag  + " , " .
                        
                    n_count = n_count + 1.
                END.
                ELSE LEAVE loop_damage.
            END.
          END.
          /*--
          IF nv_damdetail <> "" THEN nv_damdetail = " รายการความเสียหาย " + nv_damdetail .
          comment by Chaiyong W. A65-0288 22/12/2022*/
      END.
      /*-- ข้อมูลอื่น ๆ ---*/
      chitem       = chDocument:Getfirstitem("SurveyData").
      IF chitem <> 0 THEN  nv_surdata = chitem:TEXT. 
      ELSE nv_surdata = "".
      IF trim(nv_surdata) <> "" THEN  nv_surdata = "ข้อมูลอื่นๆ :"  +  nv_surdata .
      /*
      chitem       = chDocument:Getfirstitem("agentCode").      /*agentCode*/
      IF chitem <> 0 THEN n_agent = chitem:TEXT. 
      ELSE n_agent = "".
      
      IF TRIM(n_agent) <> "" THEN ASSIGN nv_surdata = nv_surdata + " โค้ดตัวแทน: " + n_agent.*/

      /*-- อุปกรณ์เสริม --*/  
      chitem       = chDocument:Getfirstitem("device1").
      IF chitem <> 0 THEN  nv_device = chitem:TEXT. 
      ELSE nv_device = "".
      IF nv_device <> "" THEN DO:
          chitem       = chDocument:Getfirstitem("PricesTotal").  /* ราคารวมอุปกรณ์เสริม */
          IF chitem <> 0 THEN  nv_acctotal = chitem:TEXT. 
          ELSE nv_acctotal = "".
          chitem       = chDocument:Getfirstitem("DType1").
          IF chitem <> 0 THEN  nv_acc1 = chitem:TEXT. 
          ELSE nv_acc1 = "".
          chitem       = chDocument:Getfirstitem("DType2").
          IF chitem <> 0 THEN  nv_acc2 = chitem:TEXT. 
          ELSE nv_acc2 = "".
          chitem       = chDocument:Getfirstitem("DType3").
          IF chitem <> 0 THEN  nv_acc3 = chitem:TEXT. 
          ELSE nv_acc3 = "".
          chitem       = chDocument:Getfirstitem("DType4").
          IF chitem <> 0 THEN  nv_acc4 = chitem:TEXT. 
          ELSE nv_acc4 = "".
          chitem       = chDocument:Getfirstitem("DType5").
          IF chitem <> 0 THEN  nv_acc5 = chitem:TEXT. 
          ELSE nv_acc5 = "".
          chitem       = chDocument:Getfirstitem("DType6").
          IF chitem <> 0 THEN  nv_acc6 = chitem:TEXT. 
          ELSE nv_acc6 = "".
          chitem       = chDocument:Getfirstitem("DType7").
          IF chitem <> 0 THEN  nv_acc7 = chitem:TEXT. 
          ELSE nv_acc7 = "".
          chitem       = chDocument:Getfirstitem("DType8").
          IF chitem <> 0 THEN  nv_acc8 = chitem:TEXT. 
          ELSE nv_acc8 = "".
          chitem       = chDocument:Getfirstitem("DType9").
          IF chitem <> 0 THEN  nv_acc9 = chitem:TEXT. 
          ELSE nv_acc9 = "".
          chitem       = chDocument:Getfirstitem("DType10").
          IF chitem <> 0 THEN  nv_acc10 = chitem:TEXT. 
          ELSE nv_acc10 = "".
          chitem       = chDocument:Getfirstitem("DType11").
          IF chitem <> 0 THEN  nv_acc11 = chitem:TEXT. 
          ELSE nv_acc11 = "".
          chitem       = chDocument:Getfirstitem("DType12").
          IF chitem <> 0 THEN  nv_acc12 = chitem:TEXT. 
          ELSE nv_acc12 = "".
         
          nv_device = "" .
          IF TRIM(nv_acc1)  <> "" THEN nv_device = nv_device + TRIM(nv_acc1) .
          IF TRIM(nv_acc2)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc2)   .
          IF TRIM(nv_acc3)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc3)   .
          IF TRIM(nv_acc4)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc4)   .
          IF TRIM(nv_acc5)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc5)   .
          IF TRIM(nv_acc6)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc6)   .
          IF TRIM(nv_acc7)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc7)   .
          IF TRIM(nv_acc8)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc8)   .
          IF TRIM(nv_acc9)  <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc9)   .
          IF TRIM(nv_acc10) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc10)  .  
          IF TRIM(nv_acc11) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc11)  .  
          IF TRIM(nv_acc12) <> "" THEN nv_device = nv_device + " , " + TRIM(nv_acc12)  . 
          nv_acctotal = " ราคารวมอุปกรณ์เสริม " + nv_acctotal + " บาท " . /*17/11/2022*/
      END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

