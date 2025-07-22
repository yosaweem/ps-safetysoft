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
/* wgwvtlkk0.w   Query Main TLT KK                                                                        */
/* Copyright    : Tokio Marine Safety Insurance (Thailand) PCL.           */
/*                        บริษัท คุ้มภัยโตเกียวมารีนประกันภัย (ประเทศไทย)                 */
/* CREATE BY    : Chaiyong W. A64-0135 21/06/2021                                */
/************************************************************************/    
------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.       */
/*----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
/* Modify by : Ranu I. A65-0288 20/10/2022 เพิ่มการเก็บข้อมูลสีรถ และข้อมูลการตรวจสภาพ */
/*Modify by : Ranu I. A67-0076 เพิ่มเงื่อนไขการเก็บข้อมูลรถไฟฟ้า */
/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

DEF INPUT PARAMETER nv_recidtlt AS RECID INIT ?.
def var nv_ahaddr1          as char no-undo init "".
def var nv_ahaddr2          as char no-undo init "".
def var nv_ahaddr3          as char no-undo init "".
def var nv_ahaddr4          as char no-undo init "".
def var nv_ahaddr5          as char no-undo init "".
def var nv_ahno             as char no-undo init "".
def var nv_ahmoo            as char no-undo init "".
def var nv_ahvil            as char no-undo init "".
def var nv_ahfloor          as char no-undo init "".
def var nv_ahroom           as char no-undo init "".
def var nv_asoi             as char no-undo init "".
def var nv_astreet          as char no-undo init "".
def var nv_adistrict        as char no-undo init "".
def var nv_ahsubdis         as char no-undo init "".
def var nv_ahprov           as char no-undo init "".
def var nv_ahcountry        as char no-undo init "".
def var nv_ahzip            as char no-undo init "".
def var nv_acontact         as char no-undo init "".
def var nv_acontel          as char no-undo init "".
def var nv_abentyp          as char no-undo init "".
def var nv_abennam          as char no-undo init "".
def var nv_apayper          as char no-undo init "".
def var nv_asum             as deci no-undo init 0.
def var nv_anet-2           as deci no-undo init 0.
def var nv_anet-3           as deci no-undo init 0.
def var nv_anet             as deci no-undo init 0.
def var nv_anet-4           as deci no-undo init 0.
def var nv_anet-5           as deci no-undo init 0.
def var nv_anet-7           as deci no-undo init 0.
def var nv_anet-9           as deci no-undo init 0.
def var nv_anet-10          as deci no-undo init 0.
def var nv_anet-8           as deci no-undo init 0.
def var nv_anet-11          as deci no-undo init 0.
def var nv_anet-12          as deci no-undo init 0.
def var nv_anet-13          as deci no-undo init 0.
def var nv_anet-15          as deci no-undo init 0.
def var nv_anet-16          as deci no-undo init 0.
def var nv_anet-14          as deci no-undo init 0.
def var nv_anet-17          as deci no-undo init 0.
def var nv_anet-18          as deci no-undo init 0.
def var nv_anet-19          as deci no-undo init 0.
def var nv_aremark          as char no-undo init "".
def var nv_alpro            as char no-undo init "".
def var nv_aloanc           as char no-undo init "".
def var nv_alprod           as char no-undo init "".
def var nv_alapp            as char no-undo init "".
def var nv_albook           as char no-undo init "".
def var nv_alcre            as char no-undo init "".
def var nv_alst             as char no-undo init "".
def var nv_alamt            as char no-undo init "".
def var nv_ali              as char no-undo init "".
def var nv_alr              as char no-undo init "".
def var nv_alfd             as char no-undo init "".
def var nv_adeal            as char no-undo init "".
def var nv_anotno           as char no-undo init "".
def var nv_anotdat          AS DATE no-undo INIT ?.
def var nv_anottim          as char no-undo init "".

def var  nv_atyp              as char no-undo init "".
def var  nv_asubtyp           as char no-undo init "".
def var  nv_acarc             as char no-undo init "".
def var  nv_atypc             as char no-undo init "".
def var  nv_abrandcar         as char no-undo init "".
def var  nv_abrandcar-2       as char no-undo init "".
def var  nv_ascar             as char no-undo init "".
def var  nv_aveh              as char no-undo init "".
def var  nv_avehpro           as char no-undo init "".
def var  nv_achano            as char no-undo init "".
def var  nv_aengno            as char no-undo init "".
def var  nv_aengno-2          as char no-undo init "".
def var  nv_aton              as char no-undo init "".
def var  nv_acaryr            as char no-undo init "".
def var  nv_atons             as char no-undo init "".
def var  nv_amil              as char no-undo init "".
def var  nv_agarage           as char no-undo init "".
def var  nv_acar              as char no-undo init "".
def var  nv_adrilic           as char no-undo init "".
def var  nv_adrname           as char no-undo init "".
def var  nv_adob              as char no-undo init "".
def var  nv_adrilic-2         as char no-undo init "".
def var  nv_adrname-2         as char no-undo init "".
def var  nv_adob-2            as char no-undo init "".
/* A65-0288 */
DEF VAR  nv_colors            AS CHAR no-undo init "".
def var  nv_ispchk            as char no-undo init "".
def var  nv_ispsts            as char no-undo init "".
def var  nv_ispno             as char no-undo init "".
def var  nv_ispappoit         as char no-undo init "".
def var  nv_ispupdate         as char no-undo init "".
def var  nv_isplocal          as char no-undo init "".
def var  nv_ispclose          as char no-undo init "".
def var  nv_ispresult         as char no-undo init "".
def var  nv_ispdam            as char no-undo init "".
def var  nv_ispacc            as char no-undo init "".
/* end : A65-0288 */
/* add by : A67-0076 */
DEF var nv_hp           as char init "" no-undo.
def var nv_drititle1    as char init "" no-undo.     
def var nv_drigender1   as char init "" no-undo.     
def var nv_drioccup1    as char init "" no-undo.     
def var nv_driToccup1   as char init "" no-undo.     
def var nv_driTicono1   as char init "" no-undo.     
def var nv_driICNo1     as char init "" no-undo.     
def var nv_drilic2      as char init "" no-undo.     
def var nv_drititle2    as char init "" no-undo.     
def var nv_drigender2   as char init "" no-undo.     
def var nv_drioccup2    as char init "" no-undo.     
def var nv_driToccup2   as char init "" no-undo.     
def var nv_driTicono2   as char init "" no-undo.     
def var nv_driICNo2     as char init "" no-undo.     
def var nv_drilic3      as char init "" no-undo.     
def var nv_drititle3    as char init "" no-undo.     
def var nv_driname3     as char init "" no-undo.     
def var nv_drivno3      as char init "" no-undo.     
def var nv_drigender3   as char init "" no-undo.     
def var nv_drioccup3    as char init "" no-undo.     
def var nv_driToccup3   as char init "" no-undo.     
def var nv_driTicono3   as char init "" no-undo.     
def var nv_driICNo3     as char init "" no-undo.     
def var nv_drilic4      as char init "" no-undo.     
def var nv_drititle4    as char init "" no-undo.     
def var nv_driname4     as char init "" no-undo.     
def var nv_drivno4      as char init "" no-undo.     
def var nv_drigender4   as char init "" no-undo.     
def var nv_drioccup4    as char init "" no-undo.     
def var nv_driToccup4   as char init "" no-undo.     
def var nv_driTicono4   as char init "" no-undo.     
def var nv_driICNo4     as char init "" no-undo.     
def var nv_drilic5      as char init "" no-undo.     
def var nv_drititle5    as char init "" no-undo.     
def var nv_driname5     as char init "" no-undo.     
def var nv_drivno5      as char init "" no-undo.     
def var nv_drigender5   as char init "" no-undo.     
def var nv_drioccup5    as char init "" no-undo.     
def var nv_driToccup5   as char init "" no-undo.     
def var nv_driTicono5   as char init "" no-undo.     
def var nv_driICNo5     as char init "" no-undo.     
def var nv_dateregis    as char init "" no-undo.     
def var nv_pay_option   as char init "" no-undo.     
def var nv_battno       as char init "" no-undo.     
def var nv_battyr       as char init "" no-undo.     
def var nv_maksi        as char init "" no-undo.     
def var nv_chargno      as char init "" no-undo.     
def var nv_veh_key      as char init "" no-undo.
/* end : A67-0076 */
Def  Var chNotesSession  As Com-Handle.
Def  Var chNotesDataBase As Com-Handle.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Dialog-Box
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME Dialog-Frame

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS bu_pg1 bu_pg3 Btn_OK Btn_Cancel fi_release ~
fi_client fi_agent fi_remark1 fi_policy fi_dprob fi_stprob fi_brancho ~
fi_dealero fi_cam fi_dprob-2 fi_isp RECT-369 RECT-370 RECT-371 RECT-372 ~
RECT-373 
&Scoped-Define DISPLAYED-OBJECTS fi_source fi_uniq fi_ins fi_kkapp fi_kkquo ~
fi_kkflag fi_new fi_trndat fi_appdat fi_effdat fi_expdat fi_insappno ~
fi_insquo fi_insquo-2 fi_mainapp fi_rider fi_prvkk fi_product fi_pcode ~
fi_pname fi_branchkk fi_burc fi_burc2 fi_payeridcard fi_payercard ~
fi_payertyp fi_paytitle fi_payername fi_project fi_Addr fi_Addr-2 fi_Addr-3 ~
fi_Addr-4 fi_Addr-5 fi_cifno fi_inscardtyp fi_inscardno fi_instyp ~
fi_institle fi_payername-2 fi_dob fi_Age fi_insgen fi_insnat fi_insmat ~
fi_instel fi_instel-2 fi_instel-3 fi_insem fi_insocc fi_insocc-2 fi_rem ~
fi_hold fi_trndat-2 fi_release fi_userid fi_prvpol fi_client fi_agent ~
fi_notdat fi_nottim fi_remark1 fi_policy fi_dprob fi_stprob fi_brancho ~
fi_dealero fi_cam fi_rem2 fi_dprob-2 fi_isp 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define a dialog box                                                  */

/* Definitions of the field level widgets                               */
DEFINE BUTTON Btn_Cancel AUTO-END-KEY 
     LABEL "Cancel" 
     SIZE 15 BY 1.14
     BGCOLOR 2 FONT 6.

DEFINE BUTTON Btn_OK 
     LABEL "Save" 
     SIZE 15 BY 1.14
     BGCOLOR 7 FONT 6.

DEFINE BUTTON bu_pg1 
     LABEL "Premium && Schedule" 
     SIZE 20.67 BY 1.14
     BGCOLOR 7 FGCOLOR 7 FONT 6.

DEFINE BUTTON bu_pg3 
     LABEL "Car Detail" 
     SIZE 13.5 BY 1.14
     BGCOLOR 7 FGCOLOR 7 FONT 6.

DEFINE VARIABLE fi_Addr AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 53.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Addr-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 57.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Addr-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 64.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Addr-4 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 57.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Addr-5 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 64.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_Age AS CHARACTER FORMAT "X(3)":U 
     VIEW-AS FILL-IN 
     SIZE 6.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 18.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_appdat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_branchkk AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_brancho AS CHARACTER FORMAT "x(100)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_burc AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 41.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_burc2 AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 54 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cam AS CHARACTER FORMAT "x(100)":U 
     VIEW-AS FILL-IN 
     SIZE 18.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_cifno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_client AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 17.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dealero AS CHARACTER FORMAT "x(100)":U 
     VIEW-AS FILL-IN 
     SIZE 21.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dob AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_dprob AS CHARACTER FORMAT "X(1000)":U 
     VIEW-AS FILL-IN 
     SIZE 85 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_dprob-2 AS CHARACTER FORMAT "X(1000)":U 
     VIEW-AS FILL-IN 
     SIZE 110.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_effdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_expdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 17.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_hold AS CHARACTER FORMAT "x":U 
     VIEW-AS FILL-IN 
     SIZE 6.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ins AS CHARACTER FORMAT "X(80)":U 
     VIEW-AS FILL-IN 
     SIZE 47.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insappno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_inscardno AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 29.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_inscardtyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insem AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 29.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insgen AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insmat AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 14.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insnat AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 12.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insocc AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 27.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insocc-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 41.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insquo AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_insquo-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_instel AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_instel-2 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 21.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_instel-3 AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_institle AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 25.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_instyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 22.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_isp AS CHARACTER FORMAT "x(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_kkapp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_kkflag AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 15.17 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_kkquo AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_mainapp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_new AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_notdat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_nottim AS CHARACTER FORMAT "X(12)":U 
     VIEW-AS FILL-IN 
     SIZE 8 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_payercard AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_payeridcard AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_payername AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 95.33 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_payername-2 AS CHARACTER FORMAT "X(120)":U 
     VIEW-AS FILL-IN 
     SIZE 75.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_payertyp AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_paytitle AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pcode AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 20.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_pname AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 73.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_policy AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 24.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_product AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_project AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prvkk AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 32.67 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_prvpol AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 20.5 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_release AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 6.83 BY 1 TOOLTIP "YES/NO/CA"
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rem AS CHARACTER FORMAT "X(1000)":U 
     VIEW-AS FILL-IN 
     SIZE 121 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rem2 AS CHARACTER FORMAT "X(1000)":U 
     VIEW-AS FILL-IN 
     SIZE 121 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_remark1 AS CHARACTER FORMAT "X(200)":U 
     VIEW-AS FILL-IN 
     SIZE 47 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_rider AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_source AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 31.5 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_stprob AS CHARACTER FORMAT "x":U 
     VIEW-AS FILL-IN 
     SIZE 6 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 35 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_trndat-2 AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 16.83 BY 1
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_uniq AS CHARACTER FORMAT "X(50)":U 
     VIEW-AS FILL-IN 
     SIZE 38.83 BY 1
     BGCOLOR 15 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_userid AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 9.67 BY 1
     BGCOLOR 4 FGCOLOR 7  NO-UNDO.

DEFINE RECTANGLE RECT-369
     EDGE-PIXELS 2 GRAPHIC-EDGE    ROUNDED 
     SIZE 186 BY 27.62
     BGCOLOR 91 FGCOLOR 4 .

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 27.5 BY 2.86
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-371
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18.5 BY 1.43
     BGCOLOR 3 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 18.5 BY 1.43
     BGCOLOR 12 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 38.33 BY 1.76
     BGCOLOR 2 FGCOLOR 7 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME Dialog-Frame
     fi_source AT ROW 1.62 COL 23.17 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_uniq AT ROW 1.62 COL 81.67 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     fi_ins AT ROW 1.71 COL 137.5 COLON-ALIGNED NO-LABEL WIDGET-ID 10
     fi_kkapp AT ROW 2.71 COL 23 COLON-ALIGNED NO-LABEL WIDGET-ID 16
     fi_kkquo AT ROW 2.71 COL 81.5 COLON-ALIGNED NO-LABEL WIDGET-ID 20
     fi_kkflag AT ROW 2.81 COL 134.17 COLON-ALIGNED NO-LABEL WIDGET-ID 24
     fi_new AT ROW 2.81 COL 165.5 COLON-ALIGNED NO-LABEL WIDGET-ID 28
     fi_trndat AT ROW 3.81 COL 23.17 COLON-ALIGNED NO-LABEL WIDGET-ID 32
     fi_appdat AT ROW 3.86 COL 82 COLON-ALIGNED NO-LABEL WIDGET-ID 36
     fi_effdat AT ROW 3.95 COL 120.67 COLON-ALIGNED NO-LABEL WIDGET-ID 40
     fi_expdat AT ROW 4 COL 160.17 COLON-ALIGNED NO-LABEL WIDGET-ID 44
     fi_insappno AT ROW 4.95 COL 23.17 COLON-ALIGNED NO-LABEL WIDGET-ID 50
     fi_insquo AT ROW 5.14 COL 82 COLON-ALIGNED NO-LABEL WIDGET-ID 54
     fi_insquo-2 AT ROW 5.1 COL 133.67 COLON-ALIGNED NO-LABEL WIDGET-ID 58
     fi_mainapp AT ROW 6.14 COL 23.17 COLON-ALIGNED NO-LABEL WIDGET-ID 66
     fi_rider AT ROW 6.24 COL 82 COLON-ALIGNED NO-LABEL WIDGET-ID 70
     fi_prvkk AT ROW 6.33 COL 136.83 COLON-ALIGNED NO-LABEL WIDGET-ID 74
     fi_product AT ROW 7.38 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 78
     fi_pcode AT ROW 7.43 COL 82.17 COLON-ALIGNED NO-LABEL WIDGET-ID 82
     fi_pname AT ROW 7.48 COL 104.5 COLON-ALIGNED NO-LABEL WIDGET-ID 86
     fi_branchkk AT ROW 8.57 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 88
     fi_burc AT ROW 8.52 COL 82.17 COLON-ALIGNED NO-LABEL WIDGET-ID 92
     fi_burc2 AT ROW 8.57 COL 124 COLON-ALIGNED NO-LABEL WIDGET-ID 96
     fi_payeridcard AT ROW 9.81 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 98
     fi_payercard AT ROW 9.76 COL 82.5 COLON-ALIGNED NO-LABEL WIDGET-ID 102
     fi_payertyp AT ROW 9.67 COL 142.5 COLON-ALIGNED NO-LABEL WIDGET-ID 106
     fi_paytitle AT ROW 11 COL 23.5 COLON-ALIGNED NO-LABEL WIDGET-ID 110
     fi_payername AT ROW 11 COL 82.67 COLON-ALIGNED NO-LABEL WIDGET-ID 114
     fi_project AT ROW 12.19 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 118
     fi_Addr AT ROW 12.19 COL 82.83 COLON-ALIGNED NO-LABEL WIDGET-ID 122
     fi_Addr-2 AT ROW 13.33 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 126
     fi_Addr-3 AT ROW 13.33 COL 105.5 COLON-ALIGNED NO-LABEL WIDGET-ID 130
     fi_Addr-4 AT ROW 14.48 COL 23.33 COLON-ALIGNED NO-LABEL WIDGET-ID 134
     fi_Addr-5 AT ROW 14.48 COL 105.67 COLON-ALIGNED NO-LABEL WIDGET-ID 138
     fi_cifno AT ROW 15.62 COL 23.17 COLON-ALIGNED NO-LABEL WIDGET-ID 142
     fi_inscardtyp AT ROW 15.67 COL 69.83 COLON-ALIGNED NO-LABEL WIDGET-ID 148
     fi_inscardno AT ROW 15.62 COL 116.33 COLON-ALIGNED NO-LABEL WIDGET-ID 146
     fi_instyp AT ROW 15.62 COL 162.5 COLON-ALIGNED NO-LABEL WIDGET-ID 156
     fi_institle AT ROW 16.76 COL 23.17 COLON-ALIGNED NO-LABEL WIDGET-ID 158
     fi_payername-2 AT ROW 16.81 COL 69.83 COLON-ALIGNED NO-LABEL WIDGET-ID 154
     fi_dob AT ROW 16.76 COL 165 COLON-ALIGNED NO-LABEL WIDGET-ID 166
     fi_Age AT ROW 17.91 COL 23 COLON-ALIGNED NO-LABEL WIDGET-ID 170
     fi_insgen AT ROW 17.95 COL 49.5 COLON-ALIGNED NO-LABEL WIDGET-ID 174
     fi_insnat AT ROW 17.95 COL 76.83 COLON-ALIGNED NO-LABEL WIDGET-ID 178
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19  WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     fi_insmat AT ROW 17.95 COL 112.83 COLON-ALIGNED NO-LABEL WIDGET-ID 182
     fi_instel AT ROW 17.95 COL 143.67 COLON-ALIGNED NO-LABEL WIDGET-ID 186
     fi_instel-2 AT ROW 19.05 COL 22.67 COLON-ALIGNED NO-LABEL WIDGET-ID 190
     fi_instel-3 AT ROW 19.1 COL 58.83 COLON-ALIGNED NO-LABEL WIDGET-ID 194
     fi_insem AT ROW 19.1 COL 97.17 COLON-ALIGNED NO-LABEL WIDGET-ID 198
     fi_insocc AT ROW 19.05 COL 143.5 COLON-ALIGNED NO-LABEL WIDGET-ID 202
     fi_insocc-2 AT ROW 20.19 COL 22.67 COLON-ALIGNED NO-LABEL WIDGET-ID 206
     bu_pg1 AT ROW 21.95 COL 149.5 WIDGET-ID 444
     bu_pg3 AT ROW 21.95 COL 171 WIDGET-ID 446
     fi_rem AT ROW 21.43 COL 22.67 COLON-ALIGNED NO-LABEL WIDGET-ID 420
     fi_hold AT ROW 23.62 COL 126.67 COLON-ALIGNED NO-LABEL WIDGET-ID 426
     fi_trndat-2 AT ROW 25.38 COL 145 COLON-ALIGNED NO-LABEL WIDGET-ID 436
     Btn_OK AT ROW 25.43 COL 169.33 WIDGET-ID 418
     Btn_Cancel AT ROW 27.05 COL 169.17
     fi_release AT ROW 26.43 COL 145 COLON-ALIGNED NO-LABEL WIDGET-ID 434
     fi_userid AT ROW 26.43 COL 152.33 COLON-ALIGNED NO-LABEL WIDGET-ID 438
     fi_prvpol AT ROW 23.62 COL 22.67 COLON-ALIGNED NO-LABEL WIDGET-ID 430
     fi_client AT ROW 20.19 COL 80.67 COLON-ALIGNED NO-LABEL WIDGET-ID 452
     fi_agent AT ROW 20.19 COL 108.83 COLON-ALIGNED NO-LABEL WIDGET-ID 450
     fi_notdat AT ROW 23.71 COL 152 COLON-ALIGNED NO-LABEL WIDGET-ID 458
     fi_nottim AT ROW 23.71 COL 176 COLON-ALIGNED NO-LABEL WIDGET-ID 460
     fi_remark1 AT ROW 23.62 COL 60.33 COLON-ALIGNED NO-LABEL WIDGET-ID 472
     fi_policy AT ROW 20.19 COL 149 COLON-ALIGNED NO-LABEL WIDGET-ID 474
     fi_dprob AT ROW 24.76 COL 22.5 COLON-ALIGNED NO-LABEL WIDGET-ID 482
     fi_stprob AT ROW 24.76 COL 126.83 COLON-ALIGNED NO-LABEL WIDGET-ID 486
     fi_brancho AT ROW 26.95 COL 22.5 COLON-ALIGNED NO-LABEL WIDGET-ID 490
     fi_dealero AT ROW 26.95 COL 60.17 COLON-ALIGNED NO-LABEL WIDGET-ID 494
     fi_cam AT ROW 26.95 COL 93.5 COLON-ALIGNED NO-LABEL WIDGET-ID 498
     fi_rem2 AT ROW 22.52 COL 22.67 COLON-ALIGNED NO-LABEL WIDGET-ID 502
     fi_dprob-2 AT ROW 25.86 COL 22.5 COLON-ALIGNED NO-LABEL WIDGET-ID 510
     fi_isp AT ROW 26.95 COL 126.33 COLON-ALIGNED NO-LABEL WIDGET-ID 514
     "Release:" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 26.43 COL 138 WIDGET-ID 442
          FGCOLOR 2 FONT 6
     " Address Receipt 2:":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 13.33 COL 3 WIDGET-ID 128
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Payer TitleName :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 11 COL 3.17 WIDGET-ID 112
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  CIF. No. :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 15.62 COL 3 WIDGET-ID 144
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Prev, Policy KK :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 6.33 COL 120.5 WIDGET-ID 76
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Campaign":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 26.95 COL 84.83 WIDGET-ID 500
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Expired Date :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 3.95 COL 142.67 WIDGET-ID 46
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19 
         CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "  Payer ID. Card Typ.:":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 9.81 COL 3 WIDGET-ID 100
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. Business Type :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 20.19 COL 2.83 WIDGET-ID 208
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Payer ID Card No. :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 9.81 COL 61.33 WIDGET-ID 104
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  KK Quotation No, :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 2.67 COL 61 WIDGET-ID 22
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Dealer":30 VIEW-AS TEXT
          SIZE 7.67 BY 1 AT ROW 26.95 COL 54 WIDGET-ID 496
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insured Occ.":30 VIEW-AS TEXT
          SIZE 14 BY 1 AT ROW 19.1 COL 131 WIDGET-ID 204
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Address Receipt 4:":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 14.48 COL 3 WIDGET-ID 136
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Remark 2:":30 VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 22.48 COL 3 WIDGET-ID 504
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "  KK Application No , :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 2.67 COL 3 WIDGET-ID 18
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insured Gender :":30 VIEW-AS TEXT
          SIZE 18.5 BY 1 AT ROW 17.91 COL 32.33 WIDGET-ID 176
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Uniq ID Source System :":30 VIEW-AS TEXT
          SIZE 25.67 BY 1 AT ROW 1.57 COL 57 WIDGET-ID 8
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insured Name :":30 VIEW-AS TEXT
          SIZE 19.17 BY 1 AT ROW 16.81 COL 51.83 WIDGET-ID 160
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Effective Date :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 3.91 COL 103 WIDGET-ID 42
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "ตรวจสภาพ :":30 VIEW-AS TEXT
          SIZE 12 BY 1 AT ROW 26.95 COL 115.83 WIDGET-ID 516
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Remark 1:":30 VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 21.38 COL 3 WIDGET-ID 424
          BGCOLOR 18 FGCOLOR 2 FONT 6
     " Status Problem :":30 VIEW-AS TEXT
          SIZE 18.17 BY 1 AT ROW 24.76 COL 110.33 WIDGET-ID 488
          BGCOLOR 18 FGCOLOR 7 FONT 6
     "NotiTime :":30 VIEW-AS TEXT
          SIZE 9.5 BY 1 AT ROW 23.71 COL 168 WIDGET-ID 464
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Application Date :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.81 COL 61.33 WIDGET-ID 38
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insured Email :":30 VIEW-AS TEXT
          SIZE 16 BY 1 AT ROW 19.1 COL 82.67 WIDGET-ID 200
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Main App. No. :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 6.14 COL 3 WIDGET-ID 68
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Producer :":30 VIEW-AS TEXT
          SIZE 10 BY 1 AT ROW 20.19 COL 71 WIDGET-ID 454
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insured Nation :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 18 COL 60.33 WIDGET-ID 180
          BGCOLOR 18 FGCOLOR 0 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19 
         CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "  Ins. ID Card No. :":30 VIEW-AS TEXT
          SIZE 19.17 BY 1 AT ROW 15.67 COL 98.5 WIDGET-ID 150
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Policy in System :":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 20.24 COL 131 WIDGET-ID 476
          BGCOLOR 18 FGCOLOR 7 FONT 6
     "Agent :":30 VIEW-AS TEXT
          SIZE 7.5 BY 1 AT ROW 20.19 COL 102.67 WIDGET-ID 456
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Branch KK :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 8.62 COL 3 WIDGET-ID 90
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. Age :":30 VIEW-AS TEXT
          SIZE 21 BY 1 AT ROW 17.91 COL 3.5 WIDGET-ID 172
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. ID Card Type:":30 VIEW-AS TEXT
          SIZE 19.5 BY 1 AT ROW 15.67 COL 51.67 WIDGET-ID 152
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Project Name :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 12.19 COL 3 WIDGET-ID 120
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Notified Date  :":30 VIEW-AS TEXT
          SIZE 16.17 BY 1 AT ROW 23.71 COL 137.33 WIDGET-ID 462
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. Birth Date :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 16.81 COL 148 WIDGET-ID 168
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Branch TMSTH":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 26.95 COL 2.67 WIDGET-ID 492
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Address Receipt 1 :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 12.19 COL 61.5 WIDGET-ID 124
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  BU/RC  :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 8.57 COL 61.5 WIDGET-ID 94
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insured Type :":30 VIEW-AS TEXT
          SIZE 15.5 BY 1 AT ROW 15.62 COL 148.33 WIDGET-ID 164
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " Address Receipt 5:":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 14.48 COL 84.83 WIDGET-ID 140
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Payer  Name :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 11 COL 61.33 WIDGET-ID 116
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Un Problem 1:":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 24.71 COL 2.67 WIDGET-ID 484
          BGCOLOR 18 FGCOLOR 2 FONT 6
     "  Hold Claim Flag :":30 VIEW-AS TEXT
          SIZE 18 BY 1 AT ROW 23.67 COL 110.33 WIDGET-ID 428
          BGCOLOR 18 FGCOLOR 7 FONT 6
     " Address Receipt 3:":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 13.33 COL 84.67 WIDGET-ID 132
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Previous Pol. Sys. :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 23.62 COL 2.67 WIDGET-ID 432
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " New/Renew :":30 VIEW-AS TEXT
          SIZE 14.5 BY 1 AT ROW 2.81 COL 152.5 WIDGET-ID 30
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  KK Offer Flag :":30 VIEW-AS TEXT
          SIZE 16.5 BY 1 AT ROW 2.81 COL 119.17 WIDGET-ID 26
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Un Problem 2:":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 25.81 COL 2.67 WIDGET-ID 512
          BGCOLOR 18 FGCOLOR 2 FONT 6
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19 
         CANCEL-BUTTON Btn_Cancel WIDGET-ID 100.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME Dialog-Frame
     "  Ins. Tel.1 :":30 VIEW-AS TEXT
          SIZE 13.83 BY 1 AT ROW 18 COL 131 WIDGET-ID 188
          BGCOLOR 18 FGCOLOR 0 FONT 6
     " ข้อมูลระบบKK :":30 VIEW-AS TEXT
          SIZE 15.67 BY 1 AT ROW 23.67 COL 46.33 WIDGET-ID 470
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "  Ins. Application No. :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 5 COL 3 WIDGET-ID 52
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Payer Type :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 9.71 COL 121.33 WIDGET-ID 108
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "    Source System :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 1.57 COL 3 WIDGET-ID 4
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. Marital Status :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 18 COL 92.83 WIDGET-ID 184
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Package  :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 7.38 COL 61.33 WIDGET-ID 84
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insurer Name :":30 VIEW-AS TEXT
          SIZE 15.83 BY 1 AT ROW 1.67 COL 122.83 WIDGET-ID 12
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "Trandat :" VIEW-AS TEXT
          SIZE 8.5 BY 1 AT ROW 25.38 COL 138 WIDGET-ID 440
          FGCOLOR 2 FONT 6
     "  Rider No.:":30 VIEW-AS TEXT
          SIZE 22 BY 1 AT ROW 6.24 COL 61 WIDGET-ID 72
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Transaction Date :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 3.81 COL 3 WIDGET-ID 34
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. Tel. 2 :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 19.05 COL 3 WIDGET-ID 192
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. Tel. 3 :":30 VIEW-AS TEXT
          SIZE 13.5 BY 1 AT ROW 19.1 COL 46.83 WIDGET-ID 196
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Policy Type :":30 VIEW-AS TEXT
          SIZE 14.17 BY 1 AT ROW 5.1 COL 120.33 WIDGET-ID 60
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Insured Title Name :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 16.81 COL 3.17 WIDGET-ID 162
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Ins. Quotation No. :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 5.14 COL 61.33 WIDGET-ID 56
          BGCOLOR 18 FGCOLOR 0 FONT 6
     "  Product Name :":30 VIEW-AS TEXT
          SIZE 21.5 BY 1 AT ROW 7.43 COL 3 WIDGET-ID 80
          BGCOLOR 18 FGCOLOR 0 FONT 6
     RECT-369 AT ROW 1.29 COL 1.83 WIDGET-ID 518
     RECT-370 AT ROW 25.05 COL 137 WIDGET-ID 520
     RECT-371 AT ROW 25.29 COL 167.5 WIDGET-ID 522
     RECT-372 AT ROW 26.91 COL 167.5 WIDGET-ID 524
     RECT-373 AT ROW 21.62 COL 147.83 WIDGET-ID 526
     SPACE(3.33) SKIP(5.56)
    WITH VIEW-AS DIALOG-BOX KEEP-TAB-ORDER 
         SIDE-LABELS NO-UNDERLINE THREE-D  SCROLLABLE 
         BGCOLOR 19 
         TITLE " Query & Review Main TLT KK"
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

/* SETTINGS FOR FILL-IN fi_Addr IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Addr-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Addr-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Addr-4 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Addr-5 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_Age IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_appdat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_branchkk IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_burc IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_burc2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_cifno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_dob IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_effdat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_expdat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_hold IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_ins IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insappno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_inscardno IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_inscardtyp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insem IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insgen IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insmat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insnat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insocc IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insocc-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insquo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_insquo-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_instel IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_instel-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_instel-3 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_institle IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_instyp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_kkapp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_kkflag IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_kkquo IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_mainapp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_new IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_notdat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_nottim IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_payercard IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_payeridcard IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_payername IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_payername-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_payertyp IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_paytitle IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_pcode IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_pname IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_product IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_project IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_prvkk IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_prvpol IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_rem IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_rem2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_rider IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_source IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trndat IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_trndat-2 IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_uniq IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_userid IN FRAME Dialog-Frame
   NO-ENABLE                                                            */
/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME Dialog-Frame
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Dialog-Frame Dialog-Frame
ON WINDOW-CLOSE OF FRAME Dialog-Frame /*  Query  Review Main TLT KK */
DO:
  APPLY "END-ERROR":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btn_OK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btn_OK Dialog-Frame
ON CHOOSE OF Btn_OK IN FRAME Dialog-Frame /* Save */
DO:

    IF INPUT fi_hold <> "Y" AND INPUT fi_hold <> "N" THEN DO:
        MESSAGE "  Hold Claim Flag Only Y or N " VIEW-AS ALERT-BOX INFORMATION.
        APPLY "entry" TO fi_hold.
             RETURN NO-APPLY.
    END.
    MESSAGE "Do you want SAVE  !!!!"        
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO     /*-CANCEL */    
        TITLE "" UPDATE choice AS LOGICAL.
    CASE choice:         
        WHEN TRUE THEN DO: 
            Find  tlt Where  Recid(tlt)  =  nv_recidtlt.
            If  avail  tlt Then do:
            ASSIGN     
             tlt.expotim           = trim(input   fi_kkapp       )      
             tlt.note3             = trim(input   fi_kkquo       )      
             tlt.note4             = trim(input   fi_kkflag      )      
             tlt.note5             = trim(input   fi_new         )      
             tlt.note26            = trim(input   fi_trndat      )      
             tlt.note6             = trim(input   fi_appdat      )      
             tlt.nor_effdat        = input   fi_effdat        
             tlt.expodat           = input   fi_expdat        
             tlt.note7             = trim(input   fi_insappno    )      
             tlt.note8             = trim(input   fi_insquo      )      
             tlt.note9             = trim(input   fi_insquo-2    )      
             tlt.note10            = trim(input   fi_mainapp     )      
             tlt.rider             = trim(input   fi_rider       )      
             tlt.nor_noti_ins      = trim(input   fi_prvkk       )      
             tlt.product           = trim(input   fi_product     )      
             tlt.pack              = trim(input   fi_pcode       )      
             tlt.covcod            = trim(input   fi_pname       )      
             tlt.nor_usr_tlt       = trim(input   fi_branchkk    )      
             tlt.comp_usr_tlt      = trim(input   fi_burc        )      
             tlt.buagent           = trim(input   fi_burc2       )      
             tlt.rec_typ           = trim(input   fi_payertyp    )      
             tlt.rec_icno          = trim(input   fi_payercard   )      
             tlt.rec_note1         = trim(input   fi_payeridcard )      
             tlt.rec_title         = trim(input   fi_paytitle    )      
             tlt.rec_name          = trim(input   fi_payername   )      
             tlt.projnme           = trim(input   fi_project     )      
             tlt.rec_addr1         = trim(input   fi_Addr        )      
             tlt.rec_addr2         = trim(input   fi_Addr-2      )      
             tlt.rec_addr3         = trim(input   fi_Addr-3      )      
             tlt.rec_addr4         = trim(input   fi_Addr-4      )      
             tlt.rec_addr5         = trim(input   fi_Addr-5      )      
             tlt.cifno             = trim(input   fi_cifno       )      
             tlt.safe2             = trim(input   fi_inscardtyp  )      
             tlt.ins_icno          = trim(input   fi_inscardno   )      
             tlt.ins_typ           = trim(input   fi_instyp      )      
             tlt.ins_title         = trim(input   fi_institle    )      
             tlt.ins_name          = trim(input   fi_payername-2 )     
             tlt.gendat            = input   fi_dob             
             tlt.note11            = trim(input  fi_Age   )         
             tlt.nationality       = trim(input  fi_insnat)      
             tlt.maritalsts        = trim(input  fi_insmat)      
             tlt.tel               = trim(input  fi_instel)      
             tlt.sex               = trim(input  fi_insgen)      
             tlt.tel2              = trim(input  fi_instel-2)      
             tlt.tel3              = trim(input  fi_instel-3)      
             tlt.email             = trim(input  fi_insem )      
             tlt.ins_occ           = trim(input  fi_insocc)   
             tlt.ins_bus           = trim(input  fi_insocc-2)
             /*tlt.note28            = trim(input   fi_dprob       )*/ /*A65-0288*/
             tlt.note28            = trim(trim(INPUT fi_dprob) + " " + trim(input fi_dprob-2))  /*A65-0288*/
             tlt.policy            = trim(input fi_policy)  
             tlt.note29            = trim(INPUT fi_stprob)              
             tlt.note25            = TRIM(INPUT fi_prvpol)  
                NO-ERROR. 
            tlt.note30 = TRIM(INPUT fi_brancho).
            tlt.note30 = tlt.note30 + FILL(" ",100 - LENGTH(tlt.note30)) + trim(INPUT fi_dealero).
            tlt.note30 = tlt.note30 + FILL(" ",200 - LENGTH(tlt.note30)) + trim(INPUT fi_cam).
                /*60*/
            ASSIGN
               tlt.comp_sub  =      input fi_client    
               tlt.recac     =      input fi_agent     
               tlt.releas    =      caps(TRIM(INPUT   fi_release))
               /*tlt.note24    =      input fi_rem */  /*A65-0288*/  
               tlt.note24    =     trim(TRIM(INPUT fi_rem) + " " + TRIM(INPUT fi_rem2))  /*A65-0288*/  
               tlt.usrsent   =     trim(INPUT fi_isp) /*A65-0288*/  NO-ERROR. 
        
            ASSIGN
            tlt.ins_addr1         =  nv_ahaddr1             
            tlt.ins_addr2         =  nv_ahaddr2             
            tlt.ins_addr3         =  nv_ahaddr3             
            tlt.ins_addr4         =  nv_ahaddr4             
            tlt.ins_addr5         =  nv_ahaddr5             
            tlt.hrg_no            =  nv_ahno                
            tlt.hrg_moo           =  nv_ahmoo               
            tlt.hrg_vill          =  nv_ahvil               
            tlt.hrg_floor         =  nv_ahfloor             
            tlt.hrg_room          =  nv_ahroom              
            tlt.hrg_soi           =  nv_asoi                
            tlt.hrg_street        =  nv_astreet             
            tlt.hrg_district      =  nv_adistrict           
            tlt.hrg_subdistrict   =  nv_ahsubdis            
            tlt.hrg_prov          =  nv_ahprov              
            tlt.hrg_cou           =  nv_ahcountry           
            tlt.hrg_postcd        =  nv_ahzip               
            tlt.hrg_cont          =  nv_acontact            
            tlt.hrg_tel           =  nv_acontel             
            tlt.bentyp            =  nv_abentyp             
            tlt.ben83             =  nv_abennam             
            tlt.period            =  nv_apayper             
            tlt.comp_coamt        =  nv_asum                    /*deci*/
            tlt.comp_grprm        =  nv_anet                    /*deci*/
            tlt.rstp              =  nv_anet-2                  /*deci*/
            tlt.rtax              =  nv_anet-3                  /*deci*/
            tlt.prem_amt          =  nv_anet-4                  /*deci*/
            tlt.tax_coporate      =  nv_anet-5                  /*deci*/
            tlt.prem_amttcop      =  nv_anet-7                  /*deci*/
            tlt.note12            =  string(nv_anet-8  )        /*string to deci*/  
            tlt.note13            =  string(nv_anet-9  )        /*string to deci*/  
            tlt.note14            =  string(nv_anet-10 )        /*string to deci*/  
            tlt.note15            =  string(nv_anet-11 )        /*string to deci*/  
            tlt.note16            =  string(nv_anet-12 )        /*string to deci*/  
            tlt.note17            =  string(nv_anet-13 )        /*string to deci*/  
            tlt.note18            =  string(nv_anet-15 )        /*string to deci*/  
            tlt.note19            =  string(nv_anet-16 )        /*string to deci*/  
            tlt.note20            =  string(nv_anet-14 )        /*string to deci*/  
            tlt.note21            =  string(nv_anet-17 )        /*string to deci*/  
            tlt.note22            =  string(nv_anet-18 )        /*string to deci*/  
            tlt.note23            =  string(nv_anet-19 )        /*string to deci*/  
            tlt.safe1             =  nv_aremark             
            tlt.ln_product        =  nv_alprod              
            tlt.nor_noti_tlt      =  nv_aloanc                 
            tlt.ln_pronme         =  nv_alpro               
            tlt.ln_app            =  nv_alapp               
            tlt.ln_book           =  nv_albook              
            tlt.ln_credit         =  nv_alcre               
            tlt.ln_st             =  nv_alst                
            tlt.ln_amt            =  nv_alamt               
            tlt.ln_ins            =  nv_ali                 
            tlt.ln_rate           =  nv_alr                 
            tlt.ln_fst            =  nv_alfd                
            tlt.usrid             =  nv_adeal               
            tlt.comp_noti_tlt     =  nv_anotno              
            tlt.datesent          =  nv_anotdat             
            tlt.gentim            =  nv_anottim               /*date*/  NO-ERROR.
        
            ASSIGN
             tlt.safe3           =     nv_atyp               
             tlt.note27          =     nv_asubtyp            
             tlt.subins          =     nv_acarc              
             tlt.vehuse          =     nv_atypc              
             tlt.brand           =     nv_abrandcar          
             tlt.model           =     nv_abrandcar-2        
             tlt.filler1         =     nv_ascar              
             tlt.lince1          =     nv_aveh               
             tlt.proveh          =     nv_avehpro            
             tlt.cha_no          =     nv_achano             
             tlt.eng_no          =     nv_aengno             
             tlt.lince2          =     nv_acaryr             
             tlt.cc_weight       =     deci(nv_aengno-2)
             tlt.colorcod        =     nv_aton               
             tlt.noteveh1        =     nv_atons              
             tlt.mileage         =     deci(nv_amil)
             tlt.stat            =     nv_agarage            
             tlt.filler2         =     nv_acar               
             tlt.dri_lic1        =     nv_adrilic            
             tlt.dri_name1       =     nv_adrname            
             tlt.dri_no1         =     nv_adob               
             tlt.dri_lic2        =     nv_adrilic-2          
             tlt.dri_name2       =     nv_adrname-2          
             tlt.dri_no2         =     nv_adob-2 
            /* add : A65-0288*/
             tlt.lince3          =     nv_colors  
             tlt.usrsent         =     nv_ispchk 
             tlt.lotno           =     nv_ispsts.
                /* add by : A67-0076 */
            ASSIGN 
             tlt.hp            = DECI(nv_hp)                
             tlt.dri_title1    = nv_drititle1         
             tlt.dri_gender1   = nv_drigender1        
             tlt.dir_occ1      = "OCCUP:" + nv_drioccup1 + " " +     
                                 "TOCC:"  + nv_driToccup1        
             tlt.dri_ic1       = "TIC:"   + nv_driTicono1 + " " +        
                                 "ICNO:"  + nv_driICNo1          
             tlt.dri_title2    = nv_drititle2         
             tlt.dri_gender2   = nv_drigender2        
             tlt.dri_occ2      = "OCCUP:" + nv_drioccup2  + " " +       
                                 "TOCC:"  + nv_driToccup2        
             tlt.dri_ic2       = "TIC:"   + nv_driTicono2 + " " +       
                                 "ICNO:"  + nv_driICNo2          
             tlt.dri_lic3      = nv_drilic3           
             tlt.dri_title3    = nv_drititle3         
             tlt.dri_name3     = nv_driname3          
             tlt.dri_no3       = nv_drivno3           
             tlt.dri_gender3   = nv_drigender3        
             tlt.dir_occ3      = "OCCUP:" + nv_drioccup3  + " " +       
                                 "TOCC:"  + nv_driToccup3        
             tlt.dri_ic3       = "TIC:"   + nv_driTicono3 + " " +       
                                 "ICNO:"  + nv_driICNo3          
             tlt.dri_lic4      = nv_drilic4           
             tlt.dri_title4    = nv_drititle4         
             tlt.dri_name4     = nv_driname4          
             tlt.dri_no4       = nv_drivno4           
             tlt.dri_gender4   = nv_drigender4        
             tlt.dri_occ4      = "OCCUP:" +  nv_drioccup4   + " " +      
                                 "TOCC:"  +  nv_driToccup4        
             tlt.dri_ic4       = "TIC:"   +  nv_driTicono4  + " " +      
                                 "ICNO:"  +  nv_driICNo4          
             tlt.dri_lic5      = nv_drilic5           
             tlt.dri_title5    = nv_drititle5         
             tlt.dri_name5     = nv_driname5          
             tlt.dri_no5       = nv_drivno5           
             tlt.dri_gender5   = nv_drigender5        
             tlt.dri_occ5      = "OCCUP:" +  nv_drioccup5 + " " +         
                                 "TOCC:"  +  nv_driToccup5        
             tlt.dri_ic5       = "TIC:"   +  nv_driTicono5 + " " +       
                                 "ICNO:"  +  nv_driICNo5          
             tlt.paydate1      = IF nv_dateregis  <> "" THEN DATE(nv_dateregis) ELSE ?        
             tlt.paytype       = nv_pay_option        
             tlt.battno        = nv_battno            
             tlt.battyr        = nv_battyr           
             tlt.maksi         = deci(nv_maksi)             
             tlt.chargno       = nv_chargno           
             tlt.noteveh2      = nv_veh_key  .
            /* end : A67-0087 */
            IF tlt.lotno = "Y"  THEN DO:
                ASSIGN 
                 tlt.acno1           = nv_ispno + " Close Date: " + nv_ispclose   /*เลขที่ตรวจสภาพ  + วันที่ปิดเรื่อง*/  
                 tlt.mobile          = nv_ispresult + IF nv_ispdam <> "" THEN " รายการความเสียหาย " + nv_ispdam  ELSE nv_ispdam /* ความเสียหาย */ /*รายการความเสียหาย */
                 tlt.fax             = nv_ispacc.        /*รายละเอียดอุปกรณ์เสริม */ 
            END.
            ELSE DO:
                ASSIGN         
                     brstat.tlt.acno1     =  IF nv_ispno <> "" OR nv_ispupdate <> "" THEN nv_ispno + " Edit Date: " + nv_ispupdate ELSE ""    /*เลขที่ตรวจสภาพ  + วันที่ update กล่อง*/      
                     brstat.tlt.mobile    =  nv_ispappoit    /* วันที่นัดหมาย */            
                     brstat.tlt.fax       =  nv_isplocal .   /*สถานที่นัดหมาย */ 
            END.
            /* end : A65-0288*/ 

            IF tlt.hclfg     <>      input fi_hold    THEN DO:
                tlt.hclfg     =      input fi_hold   .
                IF tlt.OLD_eng = "" AND  tlt.hclfg  = "Y" THEN tlt.OLD_eng         = "HOLD".
                ELSE IF tlt.OLD_eng = "" AND  tlt.hclfg  = "N"  THEN  tlt.OLD_eng         = "COVER".
                ELSE DO:
                    IF tlt.hclfg  = "Y" THEN DO: 
                        IF INDEX(tlt.OLD_eng,"CANCEL_HOLD") = 0 AND INDEX(tlt.OLD_eng,"HOLD") <> 0 THEN DO:
    
                        END.
                        ELSE tlt.OLD_eng         = "HOLD".
                    END.
                    ELSE DO:
                        IF INDEX(tlt.OLD_eng,"CANCEL_HOLD") <> 0 THEN DO:
                        END.
                        ELSE IF INDEX(tlt.OLD_eng,"HOLD") <> 0  THEN tlt.OLD_eng = "CANCEL_HOLD" .
                        ELSE tlt.OLD_eng = "COVER".
                        
                    END.
                END.
            END.
            ELSE IF tlt.OLD_eng <> INPUT fi_remark1 THEN DO:
                tlt.OLD_eng = TRIM(INPUT fi_remark1).
            END.

            END.

         END.
         WHEN FALSE THEN DO:
             APPLY "entry" TO fi_kkapp.
             RETURN NO-APPLY.
         END.
    END CASE.



  APPLY "Close":U TO SELF.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_pg1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_pg1 Dialog-Frame
ON CHOOSE OF bu_pg1 IN FRAME Dialog-Frame /* Premium  Schedule */
DO:
    RUN wgw\wgwvtlkk1( input-output nv_ahaddr1    ,    
                input-output nv_ahaddr2    ,    
                input-output nv_ahaddr3    ,    
                input-output nv_ahaddr4    ,    
                input-output nv_ahaddr5    ,    
                input-output nv_ahno       ,    
                input-output nv_ahmoo      ,    
                input-output nv_ahvil      ,    
                input-output nv_ahfloor    ,    
                input-output nv_ahroom     ,    
                input-output nv_asoi       ,    
                input-output nv_astreet    ,    
                input-output nv_adistrict  ,    
                input-output nv_ahsubdis   ,    
                input-output nv_ahprov     ,    
                input-output nv_ahcountry  ,    
                input-output nv_ahzip      ,    
                input-output nv_acontact   ,    
                input-output nv_acontel    ,    
                input-output nv_abentyp    ,    
                input-output nv_abennam    ,    
                input-output nv_apayper    ,    
                input-output nv_asum       ,    
                input-output nv_anet-2     ,    
                input-output nv_anet-3     ,    
                input-output nv_anet       ,    
                input-output nv_anet-4     ,    
                input-output nv_anet-5     ,    
                input-output nv_anet-7     ,    
                input-output nv_anet-9     ,    
                input-output nv_anet-10    ,    
                input-output nv_anet-8     ,    
                input-output nv_anet-11    ,    
                input-output nv_anet-12    ,    
                input-output nv_anet-13    ,    
                input-output nv_anet-15    ,    
                input-output nv_anet-16    ,    
                input-output nv_anet-14    ,    
                input-output nv_anet-17    ,    
                input-output nv_anet-18    ,    
                input-output nv_anet-19    ,    
                input-output nv_aremark    ,    
                input-output nv_alpro      ,    
                input-output nv_aloanc     ,    
                input-output nv_alprod     ,    
                input-output nv_alapp      ,    
                input-output nv_albook     ,    
                input-output nv_alcre      ,    
                input-output nv_alst       ,    
                input-output nv_alamt      ,    
                input-output nv_ali        ,    
                input-output nv_alr        ,    
                input-output nv_alfd       ,    
                input-output nv_adeal      ,    
                input-output nv_anotno     ,    
                input-output nv_anotdat    ,    
                input-output nv_anottim    ).

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_pg3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_pg3 Dialog-Frame
ON CHOOSE OF bu_pg3 IN FRAME Dialog-Frame /* Car Detail */
DO:
  RUN wgw\wgwvtlkk2( input-output nv_atyp       ,
              input-output nv_asubtyp    ,
              input-output nv_acarc      ,
              input-output nv_atypc      ,
              input-output nv_abrandcar  ,
              input-output nv_abrandcar-2,
              input-output nv_ascar      ,
              input-output nv_aveh       ,
              input-output nv_avehpro    ,
              input-output nv_achano     ,
              input-output nv_aengno     ,
              input-output nv_aengno-2   ,
              input-output nv_aton       ,
              input-output nv_acaryr     ,
              input-output nv_atons      ,
              input-output nv_amil       ,
              input-output nv_agarage    ,
              input-output nv_acar       ,
              input-output nv_adrilic    ,
              input-output nv_adrname    ,
              input-output nv_adob       ,
              input-output nv_adrilic-2  ,
              input-output nv_adrname-2  ,
              input-output nv_adob-2     ,
             /* add by : A65-0288 */
              input-output nv_colors     ,     
              input-output nv_ispchk     ,      
              input-output nv_ispsts     ,      
              input-output nv_ispno      ,      
              input-output nv_ispappoit  ,      
              input-output nv_ispupdate  ,      
              input-output nv_isplocal   ,      
              input-output nv_ispclose   ,      
              input-output nv_ispresult  ,      
              input-output nv_ispdam     ,      
              input-output nv_ispacc    ,
              /* end : A65-0288 */ 
              /* Add by : A67-0076 */
              input-output nv_hp         ,
              input-output nv_drititle1  ,
              input-output nv_drigender1 ,
              input-output nv_drioccup1  ,
              input-output nv_driToccup1 ,
              input-output nv_driTicono1 ,
              input-output nv_driICNo1   ,
              input-output nv_drilic2    ,
              input-output nv_drititle2  ,
              input-output nv_drigender2 ,
              input-output nv_drioccup2  ,
              input-output nv_driToccup2 ,
              input-output nv_driTicono2 ,
              input-output nv_driICNo2   ,
              input-output nv_drilic3    ,
              input-output nv_drititle3  ,
              input-output nv_driname3   ,
              input-output nv_drivno3    ,
              input-output nv_drigender3 ,
              input-output nv_drioccup3  ,
              input-output nv_driToccup3 ,
              input-output nv_driTicono3 ,
              input-output nv_driICNo3   ,
              input-output nv_drilic4    ,
              input-output nv_drititle4  ,
              input-output nv_driname4   ,  
              input-output nv_drivno4    ,
              input-output nv_drigender4 ,
              input-output nv_drioccup4  ,
              input-output nv_driToccup4 ,
              input-output nv_driTicono4 ,
              input-output nv_driICNo4   ,
              input-output nv_drilic5    ,
              input-output nv_drititle5  ,
              input-output nv_driname5   ,
              input-output nv_drivno5    ,
              input-output nv_drigender5 ,
              input-output nv_drioccup5  ,
              input-output nv_driToccup5 ,
              input-output nv_driTicono5 ,
              input-output nv_driICNo5   ,
              input-output nv_dateregis  ,
              input-output nv_pay_option ,
              input-output nv_battno     ,
              input-output nv_battyr     ,
              input-output nv_maksi      ,
              input-output nv_chargno    ,
              input-output nv_veh_key ).   
              /* end: A67-0076 */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent Dialog-Frame
ON LEAVE OF fi_agent IN FRAME Dialog-Frame
DO:
  fi_agent  = INPUT fi_agent.
  DISP fi_agent WITH FRAM Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_client
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_client Dialog-Frame
ON LEAVE OF fi_client IN FRAME Dialog-Frame
DO:
  fi_client  = INPUT fi_client.
  DISP fi_client WITH FRAM Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dprob
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dprob Dialog-Frame
ON LEAVE OF fi_dprob IN FRAME Dialog-Frame
DO:
  fi_dprob = trim(INPUT fi_dprob).
  DISP fi_dprob with frame  Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_dprob-2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_dprob-2 Dialog-Frame
ON LEAVE OF fi_dprob-2 IN FRAME Dialog-Frame
DO:
  fi_dprob-2 = trim(INPUT fi_dprob-2).
  DISP fi_dprob-2 with frame  Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_notdat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_notdat Dialog-Frame
ON LEAVE OF fi_notdat IN FRAME Dialog-Frame
DO:
    fi_notdat  = INPUT fi_notdat.
    DISP fi_notdat WITH FRAM Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_nottim
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_nottim Dialog-Frame
ON LEAVE OF fi_nottim IN FRAME Dialog-Frame
DO:
    fi_nottim  = INPUT fi_nottim.
    DISP fi_nottim WITH FRAM Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_policy
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_policy Dialog-Frame
ON LEAVE OF fi_policy IN FRAME Dialog-Frame
DO:
  fi_rem = trim(INPUT fi_rem).
  DISP fi_rem with frame  Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prvpol
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prvpol Dialog-Frame
ON LEAVE OF fi_prvpol IN FRAME Dialog-Frame
DO:
  fi_rem = trim(INPUT fi_rem).
  DISP fi_rem with frame  Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rem Dialog-Frame
ON LEAVE OF fi_rem IN FRAME Dialog-Frame
DO:
  fi_rem = trim(INPUT fi_rem).
  DISP fi_rem with frame  Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rem2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rem2 Dialog-Frame
ON LEAVE OF fi_rem2 IN FRAME Dialog-Frame
DO:
  fi_rem2 = trim(INPUT fi_rem2).
  DISP fi_rem2 with frame  Dialog-Frame.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_remark1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_remark1 Dialog-Frame
ON LEAVE OF fi_remark1 IN FRAME Dialog-Frame
DO:
  fi_rem = trim(INPUT fi_rem).
  DISP fi_rem with frame  Dialog-Frame.
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
 /* FIND FIRST tlt WHERE tlt.expotim = "00010321000041131" AND  tlt.genusr         = "kk"  NO-LOCK NO-ERROR.*/
    FIND tlt WHERE RECID(tlt) = nv_recidtlt NO-LOCK NO-ERROR.
  IF AVAIL tlt  THEN DO:
      
      RUN pd_disp.
  END.
  ELSE DO:
      MESSAGE "Not Found Data" VIEW-AS ALERT-BOX INFORMATION.
      APPLY "Close":U TO SELF.
      
  END.

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
  DISPLAY fi_source fi_uniq fi_ins fi_kkapp fi_kkquo fi_kkflag fi_new fi_trndat 
          fi_appdat fi_effdat fi_expdat fi_insappno fi_insquo fi_insquo-2 
          fi_mainapp fi_rider fi_prvkk fi_product fi_pcode fi_pname fi_branchkk 
          fi_burc fi_burc2 fi_payeridcard fi_payercard fi_payertyp fi_paytitle 
          fi_payername fi_project fi_Addr fi_Addr-2 fi_Addr-3 fi_Addr-4 
          fi_Addr-5 fi_cifno fi_inscardtyp fi_inscardno fi_instyp fi_institle 
          fi_payername-2 fi_dob fi_Age fi_insgen fi_insnat fi_insmat fi_instel 
          fi_instel-2 fi_instel-3 fi_insem fi_insocc fi_insocc-2 fi_rem fi_hold 
          fi_trndat-2 fi_release fi_userid fi_prvpol fi_client fi_agent 
          fi_notdat fi_nottim fi_remark1 fi_policy fi_dprob fi_stprob fi_brancho 
          fi_dealero fi_cam fi_rem2 fi_dprob-2 fi_isp 
      WITH FRAME Dialog-Frame.
  ENABLE bu_pg1 bu_pg3 Btn_OK Btn_Cancel fi_release fi_client fi_agent 
         fi_remark1 fi_policy fi_dprob fi_stprob fi_brancho fi_dealero fi_cam 
         fi_dprob-2 fi_isp RECT-369 RECT-370 RECT-371 RECT-372 RECT-373 
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
    fi_source           =  tlt.note1          
    fi_uniq             =  tlt.note2          
    fi_ins              =  tlt.nor_usr_ins    
    fi_kkapp            =  tlt.expotim        
    fi_kkquo            =  tlt.note3          
    fi_kkflag           =  tlt.note4          
    fi_new              =  tlt.note5          
    fi_trndat           =  tlt.note26           
    fi_appdat           =  tlt.note6       
    fi_effdat           =  tlt.nor_effdat   
    fi_expdat           =  tlt.expodat      
    fi_insappno         =  tlt.note7         
    fi_insquo           =  tlt.note8         
    fi_insquo-2         =  tlt.note9         
    fi_mainapp          =  tlt.note10        
    fi_rider            =  tlt.rider         
    fi_prvkk            =  tlt.nor_noti_ins  
    fi_product          =  tlt.product       
    fi_pcode            =  tlt.pack          
    fi_pname            =  tlt.covcod     
    fi_branchkk         =  tlt.nor_usr_tlt   
    fi_burc             =  tlt.comp_usr_tlt  
    fi_burc2            =  tlt.buagent       
    fi_payertyp         =  tlt.rec_typ    
    fi_payercard        =  tlt.rec_icno      
    fi_payeridcard      =  tlt.rec_note1       
    fi_paytitle         =  tlt.rec_title     
    fi_payername        =  tlt.rec_name      
    fi_project          =  tlt.projnme    
    fi_Addr             =  tlt.rec_addr1   
    fi_Addr-2           =  tlt.rec_addr2      
    fi_Addr-3           =  tlt.rec_addr3   
    fi_Addr-4           =  tlt.rec_addr4   
    fi_Addr-5           =  tlt.rec_addr5       
    fi_cifno            =  tlt.cifno    
    fi_inscardtyp       =  tlt.safe2      
    fi_inscardno        =  tlt.ins_icno             
    fi_instyp           =  tlt.ins_typ
    fi_institle         =  tlt.ins_title   
    fi_payername-2      =  tlt.ins_name         
    fi_dob              =  tlt.gendat 
    fi_Age              =  tlt.note11                      
    fi_insnat           =  tlt.nationality 
    fi_insmat           =  tlt.maritalsts  
    fi_instel           =  tlt.tel         
    fi_insgen           =  tlt.sex  
    fi_instel-2         =  tlt.tel2       
    fi_instel-3         =  tlt.tel3       
    fi_insem            =  tlt.email      
    fi_insocc           =  tlt.ins_occ    
    fi_insocc-2         =  tlt.ins_bus    
    /*fi_dprob            =  tlt.note28   */ /* A65-0288*/
    fi_dprob            =  if length(tlt.note28) >= 100 THEN SUBSTR(tlt.note28,1,100) ELSE tlt.note28  /* A65-0288*/
    fi_dprob-2          =  if length(tlt.note28) > 100  THEN SUBSTR(tlt.note28,101,length(tlt.note28)) ELSE ""   /* A65-0288*/
    fi_policy           =  tlt.policy.
        /*60*/
    ASSIGN
        fi_client    = tlt.comp_sub  
        fi_agent     = tlt.recac     
        fi_notdat    = tlt.datesent                                                                                        
        fi_nottim    = tlt.gentim     
        fi_hold      = tlt.hclfg 
        /*fi_rem       = tlt.note24*/ /* A65-0288 */
        fi_rem       = IF length(tlt.note24) >= 150 THEN SUBSTR(tlt.note24,1,150) ELSE tlt.note24 /* A65-0288 */
        fi_rem2     = IF length(tlt.note24) > 150 THEN SUBSTR(tlt.note24,151,length(tlt.note24)) ELSE "" /* A65-0288 */
        fi_trndat-2  = tlt.trndat  
        fi_release   = tlt.releas 
        fi_userid    = tlt.endno 
        fi_remark1   = tlt.OLD_eng  
        fi_stprob    = tlt.note29
        fi_prvpol    = tlt.note25
        fi_isp       = tlt.usrsent . /*A65-0288*/
    
    IF tlt.note30 <> "" THEN DO:
        ASSIGN
            fi_brancho = SUBSTR(tlt.note30,1,100)
            fi_dealero = SUBSTR(tlt.note30,101,100)
            fi_cam     =  SUBSTR(tlt.note30,201,100)  NO-ERROR.
    END.
    
    DISPLAY fi_stprob    fi_source    fi_uniq     fi_ins        fi_kkapp    fi_kkquo    fi_kkflag   fi_new      fi_trndat 
            fi_appdat    fi_effdat    fi_expdat   fi_insappno   fi_insquo-2 fi_insquo   fi_mainapp  fi_rider    fi_prvkk 
            fi_product   fi_pcode     fi_pname    fi_burc       fi_burc2    fi_branchkk fi_payertyp fi_payercard fi_payeridcard 
            fi_paytitle  fi_payername fi_project  fi_Addr       fi_Addr-2   fi_Addr-3   fi_Addr-4   fi_Addr-5   fi_cifno 
            fi_inscardno fi_inscardtyp fi_instyp  fi_institle   fi_dob      fi_Age      fi_payername-2          fi_insnat 
            fi_insmat    fi_instel    fi_insgen   fi_instel-2   fi_instel-3 fi_insem    fi_insocc   fi_insocc-2 
            fi_rem       fi_hold      fi_trndat-2 fi_release    fi_userid   fi_prvpol   fi_remark1  fi_dprob   fi_policy  
            fi_kkapp     fi_client    fi_notdat   fi_agent      fi_nottim   fi_brancho  fi_dealero  fi_cam
            fi_rem2     fi_dprob-2   fi_isp  /*A65-0288*/
          WITH FRAME Dialog-Frame.
    ENABLE  fi_new      fi_kkapp        fi_kkquo    fi_kkflag   fi_appdat   fi_effdat   fi_expdat   fi_insappno fi_insquo-2 
            fi_insquo   fi_mainapp      fi_rider    fi_prvkk    fi_product  fi_pcode    fi_pname    fi_burc     fi_burc2 
            fi_branchkk fi_payertyp     fi_payercard            fi_payeridcard          fi_paytitle fi_payername fi_project 
            fi_Addr     fi_Addr-2       fi_Addr-3   fi_Addr-4   fi_Addr-5   fi_cifno    fi_inscardno fi_inscardtyp fi_instyp 
            fi_institle fi_dob fi_Age   fi_payername-2          fi_insnat   fi_insmat   fi_instel   fi_insgen   fi_instel-2     
            fi_instel-3 fi_insem        fi_insocc   fi_insocc-2 fi_rem      fi_hold     fi_prvpol   fi_client   fi_agent  fi_remark1  
            fi_rem2  /*A65-0288*/       
        WITH FRAME Dialog-Frame.

 /* premium & Schedule */
 ASSIGN
    nv_ahaddr1      = tlt.ins_addr1
    nv_ahaddr2      = tlt.ins_addr2  
    nv_ahaddr3      = tlt.ins_addr3  
    nv_ahaddr4      = tlt.ins_addr4  
    nv_ahaddr5      = tlt.ins_addr5
    nv_ahno         = tlt.hrg_no          
    nv_ahmoo        = tlt.hrg_moo         
    nv_ahvil        = tlt.hrg_vill        
    nv_ahfloor      = tlt.hrg_floor       
    nv_ahroom       = tlt.hrg_room        
    nv_asoi         = tlt.hrg_soi         
    nv_astreet      = tlt.hrg_street      
    nv_adistrict    = tlt.hrg_district    
    nv_ahsubdis     = tlt.hrg_subdistrict 
    nv_ahprov       = tlt.hrg_prov        
    nv_ahcountry    = tlt.hrg_cou         
    nv_ahzip        = tlt.hrg_postcd      
    nv_acontact     = tlt.hrg_cont        
    nv_acontel      = tlt.hrg_tel         
    nv_abentyp      = tlt.bentyp          
    nv_abennam      = tlt.ben83           
    nv_apayper      = tlt.period          
    nv_asum         = tlt.comp_coamt      /*deci*/
    nv_anet         = tlt.comp_grprm      /*deci*/
    nv_anet-2       = tlt.rstp            /*deci*/
    nv_anet-3       = tlt.rtax            /*deci*/
    nv_anet-4       = tlt.prem_amt        /*deci*/
    nv_anet-5       = tlt.tax_coporate    /*deci*/
    nv_anet-7       = tlt.prem_amttcop    /*deci*/
    nv_anet-8       = deci(tlt.note12)         /*string to deci*/  
    nv_anet-9       = deci(tlt.note13)         /*string to deci*/  
    nv_anet-10      = deci(tlt.note14)         /*string to deci*/  
    nv_anet-11      = deci(tlt.note15)         /*string to deci*/  
    nv_anet-12      = deci(tlt.note16)         /*string to deci*/  
    nv_anet-13      = deci(tlt.note17)         /*string to deci*/  
    nv_anet-15      = deci(tlt.note18)         /*string to deci*/  
    nv_anet-16      = deci(tlt.note19)         /*string to deci*/  
    nv_anet-14      = deci(tlt.note20)         /*string to deci*/  
    nv_anet-17      = deci(tlt.note21)         /*string to deci*/  
    nv_anet-18      = deci(tlt.note22)         /*string to deci*/  
    nv_anet-19      = deci(tlt.note23)         /*string to deci*/  
    nv_aremark      = tlt.safe1            
    nv_alprod       = tlt.ln_product    
    nv_aloanc       = tlt.nor_noti_tlt        
    nv_alpro        = tlt.ln_pronme        
    nv_alapp        = tlt.ln_app           
    nv_albook       = tlt.ln_book          
    nv_alcre        = tlt.ln_credit        
    nv_alst         = tlt.ln_st            
    nv_alamt        = tlt.ln_amt           
    nv_ali          = tlt.ln_ins           
    nv_alr          = tlt.ln_rate          
    nv_alfd         = tlt.ln_fst           
    nv_adeal        = tlt.usrid            
    nv_anotno       = tlt.comp_noti_tlt    
    nv_anotdat      = tlt.datesent
    nv_anottim      = tlt.gentim NO-ERROR.   /*date*/

 /* car Detail */   
ASSIGN              
    nv_atyp         = tlt.safe3     
    nv_asubtyp      = tlt.note27   
    nv_acarc        = tlt.subins    
    nv_atypc        = tlt.vehuse    
    nv_abrandcar    = tlt.brand     
    nv_abrandcar-2  = tlt.model     
    nv_ascar        = tlt.filler1   
    nv_aveh         = tlt.lince1    
    nv_avehpro      = tlt.proveh    
    nv_achano       = tlt.cha_no    
    nv_aengno       = tlt.eng_no    
    nv_acaryr       = tlt.lince2    
    nv_aengno-2     = string(tlt.cc_weight)
    nv_aton         = tlt.colorcod  
    nv_atons        = tlt.noteveh1  
    nv_amil         = string(tlt.mileage )  
    nv_agarage      = tlt.stat      
    nv_acar         = tlt.filler2   
    nv_adrilic      = tlt.dri_lic1  
    nv_adrname      = tlt.dri_name1 
    nv_adob         = tlt.dri_no1   
    nv_adrilic-2    = tlt.dri_lic2  
    nv_adrname-2    = tlt.dri_name2 
    nv_adob-2       = tlt.dri_no2 
    /* add by : A67-0076 */
    nv_hp           =   STRING(tlt.hp)           
    nv_drititle1    =   tlt.dri_title1   
    nv_drigender1   =   tlt.dri_gender1  
    nv_drioccup1    =   trim(SUBSTR(tlt.dir_occ1,1,INDEX(tlt.dir_occ1,"TOCC:") - 2))
    nv_driToccup1   =   trim(substr(tlt.dir_occ1,R-INDEX(tlt.dir_occ1,"TOCC:")))   
    nv_driTicono1   =   trim(SUBSTR(tlt.dri_ic1,1,INDEX(tlt.dri_ic1,"ICNO:") - 2))       
    nv_driICNo1     =   trim(substr(tlt.dri_ic1,R-INDEX(tlt.dri_ic1,"ICNO:"))) 
    nv_drioccup1    =   trim(replace(nv_drioccup1,"OCCUP:","")) 
    nv_driToccup1   =   trim(replace(nv_driToccup1,"TOCC:","")) 
    nv_driTicono1   =   trim(replace(nv_driTicono1,"TIC:",""))  
    nv_driICNo1     =   trim(replace(nv_driICNo1,"ICNO:",""))
    nv_drititle2    =   tlt.dri_title2   
    nv_drigender2   =   tlt.dri_gender2  
    nv_drioccup2    =   trim(SUBSTR(tlt.dri_occ2,1,INDEX(tlt.dri_occ2,"TOCC:") - 2))     
    nv_driToccup2   =   trim(substr(tlt.dri_occ2,R-INDEX(tlt.dri_occ2,"TOCC:")))         
    nv_driTicono2   =   trim(SUBSTR(tlt.dri_ic2,1,INDEX(tlt.dri_ic2,"ICNO:") - 2))       
    nv_driICNo2     =   trim(substr(tlt.dri_ic2,R-INDEX(tlt.dri_ic2,"ICNO:"))) 
    nv_drioccup2    =   trim(replace(nv_drioccup2,"OCCUP:","")) 
    nv_driToccup2   =   trim(replace(nv_driToccup2,"TOCC:","")) 
    nv_driTicono2   =   trim(replace(nv_driTicono2,"TIC:",""))  
    nv_driICNo2     =   trim(replace(nv_driICNo2,"ICNO:",""))
    nv_drilic3      =   tlt.dri_lic3     
    nv_drititle3    =   tlt.dri_title3   
    nv_driname3     =   tlt.dri_name3    
    nv_drivno3      =   tlt.dri_no3      
    nv_drigender3   =   tlt.dri_gender3  
    nv_drioccup3    =   trim(SUBSTR(tlt.dir_occ3,1,INDEX(tlt.dir_occ3,"TOCC:") - 2))    
    nv_driToccup3   =   trim(substr(tlt.dir_occ3,R-INDEX(tlt.dir_occ3,"TOCC:")))        
    nv_driTicono3   =   trim(SUBSTR(tlt.dri_ic3,1,INDEX(tlt.dri_ic3,"ICNO:") - 2))      
    nv_driICNo3     =   trim(substr(tlt.dri_ic3,R-INDEX(tlt.dri_ic3,"ICNO:"))) 
    nv_drioccup3    =   trim(replace(nv_drioccup3,"OCCUP:","")) 
    nv_driToccup3   =   trim(replace(nv_driToccup3,"TOCC:","")) 
    nv_driTicono3   =   trim(replace(nv_driTicono3,"TIC:",""))  
    nv_driICNo3     =   trim(replace(nv_driICNo3,"ICNO:",""))
    nv_drilic4      =   tlt.dri_lic4     
    nv_drititle4    =   tlt.dri_title4   
    nv_driname4     =   tlt.dri_name4    
    nv_drivno4      =   tlt.dri_no4      
    nv_drigender4   =   tlt.dri_gender4  
    nv_drioccup4    =   trim(SUBSTR(tlt.dri_occ4,1,INDEX(tlt.dri_occ4,"TOCC:") - 2))   
    nv_driToccup4   =   trim(substr(tlt.dri_occ4,R-INDEX(tlt.dri_occ4,"TOCC:")))       
    nv_driTicono4   =   trim(SUBSTR(tlt.dri_ic4,1,INDEX(tlt.dri_ic4,"ICNO:") - 2))     
    nv_driICNo4     =   trim(substr(tlt.dri_ic4,R-INDEX(tlt.dri_ic4,"ICNO:")))
    nv_drioccup4    =   trim(replace(nv_drioccup4,"OCCUP:","")) 
    nv_driToccup4   =   trim(replace(nv_driToccup4,"TOCC:","")) 
    nv_driTicono4   =   trim(replace(nv_driTicono4,"TIC:",""))  
    nv_driICNo4     =   trim(replace(nv_driICNo4,"ICNO:",""))
    nv_drilic5      =   tlt.dri_lic5     
    nv_drititle5    =   tlt.dri_title5   
    nv_driname5     =   tlt.dri_name5    
    nv_drivno5      =   tlt.dri_no5      
    nv_drigender5   =   tlt.dri_gender5  
    nv_drioccup5    =   trim(SUBSTR(tlt.dri_occ5,1,INDEX(tlt.dri_occ5,"TOCC:") - 2))    
    nv_driToccup5   =   trim(substr(tlt.dri_occ5,R-INDEX(tlt.dri_occ5,"TOCC:")))        
    nv_driTicono5   =   trim(SUBSTR(tlt.dri_ic5,1,INDEX(tlt.dri_ic5,"ICNO:") - 2))      
    nv_driICNo5     =   trim(substr(tlt.dri_ic5,R-INDEX(tlt.dri_ic5,"ICNO:")))  
    nv_drioccup5    =   trim(replace(nv_drioccup5,"OCCUP:","")) 
    nv_driToccup5   =   trim(replace(nv_driToccup5,"TOCC:","")) 
    nv_driTicono5   =   trim(replace(nv_driTicono5,"TIC:",""))  
    nv_driICNo5     =   trim(replace(nv_driICNo5,"ICNO:",""))
    nv_dateregis    =   STRING(tlt.paydate1,"99/99/9999")     
    nv_pay_option   =   tlt.paytype      
    nv_battno       =   tlt.battno       
    nv_battyr       =   tlt.battyr       
    nv_maksi        =   string(tlt.maksi,">>>>>>>>9.99")        
    nv_chargno      =   tlt.chargno      
    nv_veh_key      =   tlt.noteveh2 
    /* end : A67-0076 */
    /* Add by : A65-0288 */
    nv_colors    = tlt.lince3 
    nv_ispchk    = tlt.usrsent
    nv_ispsts    = tlt.lotno  
    NO-ERROR.

    IF tlt.lotno = "Y" THEN DO:
        ASSIGN 
        nv_ispno     = trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  
        nv_ispclose  = trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Close Date:") + 12))
        nv_ispresult = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,1,index(tlt.mobile,"รายการความเสียหาย") - 2)) ELSE tlt.mobile
        nv_ispdam    = IF index(tlt.mobile,"รายการความเสียหาย") <> 0 THEN trim(substr(tlt.mobile,R-INDEX(tlt.mobile,"รายการความเสียหาย") + 17)) ELSE ""
        nv_ispacc    = brstat.tlt.fax  
        nv_ispappoit = ""    
        nv_ispupdate = ""    
        nv_isplocal  = ""  NO-ERROR.
    END.
    ELSE DO:
        ASSIGN 
        nv_ispno     = IF tlt.acno1 <> "" THEN trim(substr(tlt.acno1,1,INDEX(tlt.acno1," ")))  ELSE ""
        nv_ispupdate = IF tlt.acno1 <> "" THEN trim(SUBSTR(tlt.acno1,R-INDEX(tlt.acno1,"Edit Date:") + 10 )) ELSE "" 
        nv_ispupdate = IF index(nv_ispupdate," ") <> 0 THEN TRIM(SUBSTR(nv_ispupdate,1,R-INDEX(nv_ispupdate," "))) ELSE nv_ispupdate
        nv_ispappoit = tlt.mobile  
        nv_isplocal  = tlt.fax 
        nv_ispclose  = ""
        nv_ispresult = ""
        nv_ispdam    = ""
        nv_ispacc    = ""       NO-ERROR.

    END.
   
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

