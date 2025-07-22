&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS c-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
sic_test         PROGRESS  */
File: 
Description: 
Input Parameters:
<none>
Output Parameters:
<none>
Author: 
Created: 
------------------------------------------------------------------------*/
/*          This .W file was createvfd with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/
/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good DEFINEault which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */
CREATE WIDGET-POOL.
/* ***************************  DEFINEinitions  ************************** */
/* Parameters DEFINEinitions ---                                           */
/* Local Variable DEFINEinitions ---                                       */  
/*******************************/                                       
/*programid : wgwtamnh.w                                                           */ 
/*programname : load text file Amanh                                                 */ 
/*Copyright : Safety Insurance Public Company Limited                              */
/*            บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                                   */
/*create by : Kridtiya i. A59-0145  25-04/2016        
              ปรับโปรแกรมให้สามารถนำเข้า text file Amanh                           */
/*modify by : kridtiya i. A59-0183 add 41,42,43 name, address,vehreg               */
/*Modify by : Ranu I. A61-0386 Date 14/08/2018   เพิ่มการเก็บข้อมูลจากไฟล์โหลด      */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/*Modify by : Ranu I. A62-0445 date:04/10/2019 เพิ่มช่องผลการตรวจสภาพ  
              เพิ่มข้อมูลการตรวจสภาพในระบบพรีเมียม */
/*Modify by : Ranu I. A63-0168 แก้ไข Pack T และ Pack งานต่ออายุดึงตามพารามิเตอร์   */
/*Modify by : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname...*/
/*Modify by : Ranu I. A64-0150 แก้ไข commission ที่หน้าจอ และตัดช่อง prevpol ออกจากไฟล์โหลด */
/*Modify by : Ranu I. A64-0138 17/05/2021 ตัดช่อง prevpol ออกจากไฟล์ Match policy */
/*Modify by : Kridtiya i. A65-0035 comment message error premium not on file */
/*Modify by : Tontawan S. A66-0139 DATE: 29/06/2023
              - แก้ไข Default Agent Code ใหม่เป็น "B300316"
              - แก้ไขการ/Check กรณีโหลดงาน Class 320 ที่มีปัญหา ไม่สามารถโหลดเข้าระบบได้   
              - ช่อง Campaign ให้นำข้อมูล Producer Code มาใส่แทนข้อมูลเดิม                 */
/*******************************************************************************************/
{wgw\wgwtamnh.i}      /*ประกาศตัวแปร*/
DEFINE NEW SHARED VAR nv_riskno     Like  sicuw.uwm301.riskgp.
DEFINE NEW SHARED VAR nv_itemno     Like  sicuw.uwm301.itemno. 
DEFINE STREAM  ns1.                 
DEFINE STREAM  ns2.                 
DEFINE STREAM  ns3.                 
DEFINE VAR            nv_uom1_v     AS INTE INIT 0. 
DEFINE VAR            nv_uom2_v     AS INTE INIT 0. 
DEFINE VAR            nv_uom5_v     AS INTE INIT 0. 
DEFINE VAR            chkred        AS logi INIT NO.
DEFINE SHARED Var     n_User        As CHAR .
DEFINE SHARED Var     n_PassWd      As CHAR .    
DEFINE VAR            nv_comper     AS DECI INIT 0.                
DEFINE VAR            nv_comacc     AS DECI INIT 0.                
DEFINE NEW SHARED VAR nv_seat41     AS INTEGER   FORMAT ">>9".
DEFINE NEW SHARED VAR nv_totsi      AS DECIMAL   FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_polday     AS INTE      FORMAT ">>9".
DEFINE New SHARED VAR nv_uom6_u     as char.                
DEFINE VAR            nv_chk        as  logic.
DEFINE VAR            nv_ncbyrs     AS INTE.    
DEFINE NEW SHARED VAR nv_odcod      AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_cons       AS CHAR      FORMAT "X(2)".
/*DEFINE NEW SHARED VAR nv_baseprm    AS DECI      FORMAT ">>,>>>,>>9.99-".******/
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEFINE New shared VAR nv_prem       AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_baseap     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE New shared VAR nv_ded        AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_gapprm     AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_pdprm      AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_prvprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_41prm      AS INTEGER   FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_ded1prm    AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_aded1prm   AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_ded2prm    AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_dedod      AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_addod      AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_dedpd      AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_prem1      AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_addprm     AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_totded     AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_totdis     AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_41cod1     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_41cod2     AS CHARACTER FORMAT "X(4)".
DEFINE New SHARED VAR nv_41         AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE New SHARED VAR nv_411prm     AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR nv_412prm     AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE New SHARED VAR nv_411var1    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_411var2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_411var     AS CHAR      FORMAT "X(60)".
DEFINE New SHARED VAR nv_412var1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_412var2    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_412var     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_42cod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_42         AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE New SHARED VAR nv_42prm      AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR nv_42var1     AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_42var2     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_42var      AS CHAR      FORMAT "X(60)".
DEFINE New SHARED VAR nv_43cod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_43         AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE New SHARED VAR nv_43prm      AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE New SHARED VAR nv_43var1     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_43var2     AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_43var      AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_campcod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_camprem    AS DECI      FORMAT ">>>9".
DEFINE New SHARED VAR nv_campvar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_campvar2   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_campvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_compcod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_compprm    AS DECI      FORMAT ">>>,>>9.99-".
DEFINE New SHARED VAR nv_compvar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_compvar2   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_compvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_basecod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_baseprm    AS DECI      FORMAT ">>,>>>,>>9.99-". 
DEFINE New SHARED VAR nv_basevar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_basevar2   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_basevar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_cl_cod     AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_cl_per     AS DECIMAL   FORMAT ">9.99".
DEFINE New SHARED VAR nv_lodclm     AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE VAR            nv_lodclm1    AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE New SHARED VAR nv_clmvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_clmvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_clmvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_stf_cod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_stf_per    AS DECIMAL   FORMAT ">9.99".
DEFINE New SHARED VAR nv_stf_amt    AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_stfvar1    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_stfvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_stfvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_dss_cod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_dss_per    AS DECIMAL   FORMAT ">9.99".
DEFINE New SHARED VAR nv_dsspc      AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_dsspcvar1  AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_dsspcvar2  AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_dsspcvar   AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_ncb_cod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_ncbper     LIKE sicuw.uwm301.ncbper.
DEFINE New SHARED VAR nv_ncb        AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_ncbvar1    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_ncbvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_ncbvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_flet_cod   AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_flet_per   AS DECIMAL   FORMAT ">>9".
DEFINE New SHARED VAR nv_flet       AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_fletvar1   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_fletvar2   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_fletvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_vehuse     LIKE sicuw.uwm301.vehuse.                 
DEFINE NEW SHARED VAR nv_grpcod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_grprm      AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_grpvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_grpvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_grpvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_othcod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_othprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_othvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_othvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_othvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_dedod1_cod AS CHAR      FORMAT "X(4)".             
DEFINE NEW SHARED VAR nv_dedod1_prm AS DECI      FORMAT ">,>>>,>>9.99-".    
DEFINE NEW SHARED VAR nv_dedod1var1 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod1var2 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod1var  AS CHAR      FORMAT "X(60)".            
DEFINE NEW SHARED VAR nv_dedod2_cod AS CHAR      FORMAT "X(4)".             
DEFINE NEW SHARED VAR nv_dedod2_prm AS DECI      FORMAT ">,>>>,>>9.99-".    
DEFINE NEW SHARED VAR nv_dedod2var1 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod2var2 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod2var  AS CHAR      FORMAT "X(60)".            
DEFINE NEW SHARED VAR nv_dedpd_cod  AS CHAR      FORMAT "X(4)".             
DEFINE NEW SHARED VAR nv_dedpd_prm  AS DECI      FORMAT ">,>>>,>>9.99-".    
DEFINE NEW SHARED VAR nv_dedpdvar1  AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedpdvar2  AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedpdvar   AS CHAR      FORMAT "X(60)".            
DEFINE NEW SHARED VAR nv_tariff     LIKE sicuw.uwm301.tariff.
DEFINE NEW SHARED VAR nv_comdat     LIKE sicuw.uwm100.comdat.
DEFINE NEW SHARED VAR nv_covcod     LIKE sicuw.uwm301.covcod.
DEFINE NEW SHARED VAR nv_class      AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_key_b      AS DECIMAL   FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE NEW SHARED VAR nv_drivno     AS INT       .  
DEFINE NEW SHARED VAR nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_drivprm    AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_drivvar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_drivvar2   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_drivvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_usecod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_useprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_usevar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_usevar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_usevar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_sicod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_siprm      AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_sivar1     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_sivar2     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_sivar      AS CHAR      FORMAT "X(60)".
DEFINE New shared var nv_uom6_c     as char.     /* Sum  si*/
DEFINE New shared var nv_uom7_c     as char.     /* Fire/Theft*/
DEFINE NEW SHARED VAR nv_bipcod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_bipprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_bipvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_bipvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_bipvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_biacod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_biaprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_biavar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_biavar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_biavar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_pdacod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_pdaprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_pdavar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_pdavar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_pdavar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_engine     LIKE sicsyac.xmm102.engine.
DEFINE NEW SHARED VAR nv_tons       LIKE sicsyac.xmm102.tons.
DEFINE NEW SHARED VAR nv_seats      LIKE sicsyac.xmm102.seats.
DEFINE NEW SHARED VAR nv_sclass     AS CHAR      FORMAT "x(3)".
DEFINE NEW SHARED VAR nv_engcod     AS CHAR      FORMAT "x(4)".
DEFINE NEW SHARED VAR nv_engprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_engvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_engvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_engvar     AS CHAR      FORMAT "X(60)".
DEFINE VAR            NO_CLASS      AS CHAR      INIT   "".
DEFINE VAR            no_tariff     AS CHAR      INIT   "".
DEFINE New shared var nv_poltyp     as char      init   "".
DEFINE NEW SHARED VAR nv_yrcod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_yrprm      AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_yrvar1     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_yrvar2     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_yrvar      AS CHAR      FORMAT "X(60)".
DEFINE New shared VAR nv_caryr      AS INTE      FORMAT ">>>9" .
DEFINE NEW SHARED VAR s_recid1      as RECID .     /* uwm100  */
DEFINE NEW SHARED VAR s_recid2      as recid .     /* uwm120  */
DEFINE NEW SHARED VAR s_recid3      as recid .     /* uwm130  */  
DEFINE NEW SHARED VAR s_recid4      as recid .     /* uwm301  */                                    
DEFINE New shared var nv_dspc       as deci.
DEFINE New shared var nv_mv1        as int .
DEFINE New shared var nv_mv1_s      as int . 
DEFINE New shared var nv_mv2        as int . 
DEFINE New shared var nv_mv3        as int . 
DEFINE New shared var nv_comprm     as int .  
DEFINE New shared var nv_model      as char.  
DEFINE NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".   
DEFINE NEW SHARED var nv_modulo   as int  format "9".
DEFINE NEW SHARED var nv_branch   AS CHAR FORMAT "x(3)" .  
DEFINE New shared  var      nv_makdes    as   char    .
DEFINE New shared  var      nv_moddes    as   char.
/*A63-0169*/
DEF WORKFILE wcampaign NO-UNDO 
    FIELD  campno  AS CHAR FORMAT "x(20)"    INIT ""
    FIELD  id      AS CHAR FORMAT "x(5)"    INIT ""  
    FIELD  cover   AS CHAR FORMAT "x(3)"    INIT ""  
    FIELD  pack    AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD  bi      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd1     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd2     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n41      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n42      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  n43      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  nname    AS CHAR FORMAT "x(25)"    INIT "" 
    FIELD  garage   AS CHAR FORMAT "x(2)"  INIT "" .
/* end A63-0169*/

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_cam

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wcampaign wdetail

/* Definitions for BROWSE br_cam                                        */
&Scoped-define FIELDS-IN-QUERY-br_cam wcampaign.pack wcampaign.cover wcampaign.id wcampaign.garage wcampaign.bi wcampaign.pd1 wcampaign.pd2 wcampaign.n41 wcampaign.n42 wcampaign.n43   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_cam   
&Scoped-define SELF-NAME br_cam
&Scoped-define QUERY-STRING-br_cam FOR EACH wcampaign
&Scoped-define OPEN-QUERY-br_cam OPEN QUERY br_cam FOR EACH wcampaign .
&Scoped-define TABLES-IN-QUERY-br_cam wcampaign
&Scoped-define FIRST-TABLE-IN-QUERY-br_cam wcampaign


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.policy wdetail.cndat wdetail.comdat wdetail.expdat wdetail.covcod wdetail.garage wdetail.tiname wdetail.insnam wdetail.policy   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y"
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_cam}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_cam ra_typefile fi_loaddat fi_tpbip ~
fi_tpbiac fi_tppda fi_ap01 fi_ap02 fi_ap03 fi_producer fi_agent ~
fi_commision70 fi_commision72 fi_branch fi_prevbat fi_bchyr fi_filename ~
bu_file buok bu_exit bu_hpacno1 bu_hpagent br_wdetail bu_hpbrn fi_output1 ~
fi_output2 fi_output3 fi_usrprem fi_usrcnt fi_process fi_bchno fi_pack1 ~
fi_pack2 fi_pack3 fi_pack2plus fi_comcode fi_pack fi_rwpack RECT-370 ~
RECT-372 RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS ra_typefile fi_loaddat fi_tpbip fi_tpbiac ~
fi_tppda fi_ap01 fi_ap02 fi_ap03 fi_producer fi_agent fi_commision70 ~
fi_commision72 fi_branch fi_prevbat fi_bchyr fi_filename fi_proname ~
fi_agtname fi_brndes fi_output1 fi_output2 fi_output3 fi_usrprem fi_usrcnt ~
fi_process fi_premtot fi_impcnt fi_bchno fi_premsuc fi_completecnt fi_pack1 ~
fi_pack2 fi_pack3 fi_pack2plus fi_comcode fi_pack fi_rwpack 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR c-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 10 BY 1
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 3.5 BY .95.

DEFINE BUTTON bu_hpacno1 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 46.33 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_ap01 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ap02 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_ap03 AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .91
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 7 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 56.33 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_comcode AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 12.5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_commision70 AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_commision72 AS INTEGER FORMAT ">9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 5 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 13 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .95
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pack1 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pack2 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pack2plus AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_pack3 AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 3 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(16)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 46.33 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_rwpack AS CHARACTER FORMAT "X(30)":U 
     VIEW-AS FILL-IN 
     SIZE 16.33 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_tpbiac AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tpbip AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_tppda AS DECIMAL FORMAT "->>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 15 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE ra_typefile AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "  LOAD TEXT ", 1,
"MATCH FILE", 2
     SIZE 59.5 BY .95
     BGCOLOR 5  NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132 BY 15
     BGCOLOR 18 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 4
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 3
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 124.5 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.67
     BGCOLOR 1 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 13 BY 1.67
     BGCOLOR 6 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY br_cam FOR 
      wcampaign SCROLLING.

DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_cam
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_cam c-Win _FREEFORM
  QUERY br_cam DISPLAY
      wcampaign.pack  column-label "Pack"  format "x(1)"
wcampaign.cover column-label "Cover" format "x(3)"
wcampaign.id    column-label "Class" format "x(3)"
wcampaign.garage COLUMN-LABEL "Garage" FORMAT "x(2)"
wcampaign.bi    column-label "TP1 "  format "X(10)"
wcampaign.pd1   column-label "TP2 "  format "X(10)"
wcampaign.pd2   column-label "TP3 "  format "X(10)"
wcampaign.n41   column-label "41 "   format "X(10)"
wcampaign.n42   column-label "42 "   format "X(10)"
wcampaign.n43   column-label "43 "   format "X(10)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 38 BY 4.91
         BGCOLOR 21 FONT 1 ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.policy        COLUMN-LABEL "Policy No.  "
      wdetail.cndat         COLUMN-LABEL "CN date."
      wdetail.comdat        COLUMN-LABEL "comdate."   
      wdetail.expdat        COLUMN-LABEL "expidate." 
      wdetail.covcod        COLUMN-LABEL "covcod  "
      wdetail.garage        COLUMN-LABEL "garage  "
      wdetail.tiname        COLUMN-LABEL "tiname  "
      wdetail.insnam        COLUMN-LABEL "insnam  "
      wdetail.policy        COLUMN-LABEL "policyno2"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 3.52
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_cam AT ROW 7.05 COL 95 WIDGET-ID 100
     ra_typefile AT ROW 9.1 COL 26.5 NO-LABEL
     fi_loaddat AT ROW 2.76 COL 17 COLON-ALIGNED NO-LABEL
     fi_tpbip AT ROW 3.86 COL 7.83 COLON-ALIGNED NO-LABEL
     fi_tpbiac AT ROW 3.86 COL 31 COLON-ALIGNED NO-LABEL
     fi_tppda AT ROW 3.86 COL 54.33 COLON-ALIGNED NO-LABEL
     fi_ap01 AT ROW 3.86 COL 74.83 COLON-ALIGNED NO-LABEL
     fi_ap02 AT ROW 3.86 COL 95.33 COLON-ALIGNED NO-LABEL
     fi_ap03 AT ROW 3.86 COL 115.67 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 4.86 COL 17 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 5.91 COL 17 COLON-ALIGNED NO-LABEL
     fi_commision70 AT ROW 8.05 COL 17 COLON-ALIGNED NO-LABEL
     fi_commision72 AT ROW 8.05 COL 28.67 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 6.95 COL 17 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 10.14 COL 24.17 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 10.14 COL 63.67 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 11.19 COL 24 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 11.19 COL 86.67
     buok AT ROW 13.81 COL 93
     bu_exit AT ROW 15.67 COL 93.17
     fi_proname AT ROW 4.86 COL 38.17 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 4.86 COL 35.83
     fi_agtname AT ROW 5.91 COL 38.17 COLON-ALIGNED NO-LABEL
     bu_hpagent AT ROW 5.91 COL 35.83
     fi_brndes AT ROW 6.95 COL 28.17 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 18.05 COL 2.17
     bu_hpbrn AT ROW 6.95 COL 25.5
     fi_output1 AT ROW 12.24 COL 24 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 13.29 COL 24 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 14.33 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 15.38 COL 63.17 NO-LABEL
     fi_usrcnt AT ROW 15.38 COL 24 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 16.52 COL 24 COLON-ALIGNED NO-LABEL
     fi_premtot AT ROW 22.24 COL 96.17 NO-LABEL NO-TAB-STOP 
     fi_impcnt AT ROW 22.24 COL 59 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_bchno AT ROW 22.24 COL 15.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.29 COL 94.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_completecnt AT ROW 23.29 COL 59 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_pack1 AT ROW 2.76 COL 63.83 COLON-ALIGNED NO-LABEL
     fi_pack2 AT ROW 2.76 COL 75 COLON-ALIGNED NO-LABEL
     fi_pack3 AT ROW 2.76 COL 86.83 COLON-ALIGNED NO-LABEL
     fi_pack2plus AT ROW 2.76 COL 98.83 COLON-ALIGNED NO-LABEL
     fi_comcode AT ROW 2.76 COL 43.17 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 6 COL 108.67 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_rwpack AT ROW 4.95 COL 108.67 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     "TPB/P:" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 3.86 COL 2.5
     "TPP/A:" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 3.86 COL 48.67
     " Load Text & Generate Data Amanah" VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.33 COL 2.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 11.19 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 22.24 COL 94.5 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "PACK COVER :" VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 6 COL 95.5 WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 1 
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 23.29 COL 115
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "TPB/A:" VIEW-AS TEXT
          SIZE 7 BY .91 AT ROW 3.86 COL 25.5
     "       Load Date :":35 VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 2.76 COL 2.5
          BGCOLOR 8 FGCOLOR 2 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 22.24 COL 115
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Producer Code :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 4.86 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "/* ComA >= 33 - dspc*/" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 8.05 COL 57.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "AP3:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 3.86 COL 112.67
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 22.24 COL 59.5 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "      CommA 70 :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 8.05 COL 17.67 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "COMPANY:" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 2.76 COL 32.67
          BGCOLOR 8 FGCOLOR 1 
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 23.29 COL 59.5 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "     Previous Batch No.:" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 10.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "PARAMETER :" VIEW-AS TEXT
          SIZE 14.67 BY .95 AT ROW 4.95 COL 95.5 WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 1 
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 23.29 COL 94.5 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 12.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "AP1:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 3.86 COL 71.83
     "Batch Year :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 10.14 COL 63.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "    Agent Code  :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 5.91 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 14.33 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 15.38 COL 24 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 22.24 COL 5.33
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 15.38 COL 82.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "TieS 4 01/03/2022" VIEW-AS TEXT
          SIZE 18 BY 1.19 AT ROW 16 COL 113.5 WIDGET-ID 10
          BGCOLOR 18 
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 13.29 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "AP2:" VIEW-AS TEXT
          SIZE 4.5 BY .91 AT ROW 3.86 COL 92.33
     "           Branch :" VIEW-AS TEXT
          SIZE 16 BY .95 AT ROW 6.95 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Pack3:" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 2.76 COL 81.17
          BGCOLOR 8 FGCOLOR 1 
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 15.38 COL 61.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " 72 :" VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 8.05 COL 29 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Pack2:" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 2.76 COL 69.33
          BGCOLOR 8 FGCOLOR 1 
     "Pack1:" VIEW-AS TEXT
          SIZE 7 BY .95 AT ROW 2.76 COL 58.17
          BGCOLOR 8 FGCOLOR 1 
     "Pack2+:" VIEW-AS TEXT
          SIZE 7.5 BY .95 AT ROW 2.76 COL 92.83
          BGCOLOR 8 FGCOLOR 1 
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.67 COL 1.5
     RECT-373 AT ROW 17.76 COL 1
     RECT-374 AT ROW 21.81 COL 1
     RECT-376 AT ROW 22 COL 4.5
     RECT-377 AT ROW 13.48 COL 91.33
     RECT-378 AT ROW 15.33 COL 91.5
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.


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
  CREATE WINDOW c-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "Load Text & Generate  Amanah"
         HEIGHT             = 24
         WIDTH              = 133
         MAX-HEIGHT         = 33.91
         MAX-WIDTH          = 170.67
         VIRTUAL-HEIGHT     = 33.91
         VIRTUAL-WIDTH      = 170.67
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = 139
         FGCOLOR            = 133
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.

&IF '{&WINDOW-SYSTEM}' NE 'TTY' &THEN
IF NOT c-Win:LOAD-ICON("wimage/safety.ico":U) THEN
    MESSAGE "Unable to load icon: wimage/safety.ico"
            VIEW-AS ALERT-BOX WARNING BUTTONS OK.
&ENDIF
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW c-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME fr_main
   FRAME-NAME Custom                                                    */
/* BROWSE-TAB br_cam 1 fr_main */
/* BROWSE-TAB br_wdetail fi_brndes fr_main */
ASSIGN 
       br_cam:SEPARATOR-FGCOLOR IN FRAME fr_main      = 8.

ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE.

ASSIGN 
       bu_file:AUTO-RESIZE IN FRAME fr_main      = TRUE.

/* SETTINGS FOR FILL-IN fi_agtname IN FRAME fr_main
   NO-ENABLE                                                            */
ASSIGN 
       fi_bchno:READ-ONLY IN FRAME fr_main        = TRUE.

/* SETTINGS FOR FILL-IN fi_brndes IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_completecnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_impcnt IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premsuc IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_premtot IN FRAME fr_main
   NO-ENABLE ALIGN-L                                                    */
/* SETTINGS FOR FILL-IN fi_proname IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_usrprem IN FRAME fr_main
   ALIGN-L                                                              */
/* SETTINGS FOR TEXT-LITERAL "      CommA 70 :"
          SIZE 16 BY .95 AT ROW 8.05 COL 17.67 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL " 72 :"
          SIZE 5 BY .95 AT ROW 8.05 COL 29 RIGHT-ALIGNED                */

/* SETTINGS FOR TEXT-LITERAL "/* ComA >= 33 - dspc*/"
          SIZE 22.5 BY .95 AT ROW 8.05 COL 57.83 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12 BY .95 AT ROW 10.14 COL 63.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 22.5 BY .95 AT ROW 15.38 COL 24 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 25 BY .95 AT ROW 15.38 COL 61.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .91 AT ROW 22.24 COL 59.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 22.5 BY .91 AT ROW 22.24 COL 94.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .91 AT ROW 23.29 COL 59.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.5 BY .91 AT ROW 23.29 COL 94.5 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_cam
/* Query rebuild information for BROWSE br_cam
     _START_FREEFORM
OPEN QUERY br_cam FOR EACH wcampaign .
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE br_cam */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE br_wdetail
/* Query rebuild information for BROWSE br_wdetail
     _START_FREEFORM
OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME c-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON END-ERROR OF c-Win /* Load Text  Generate  Amanah */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text  Generate  Amanah */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail c-Win
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    IF WDETAIL.WARNING <> "" THEN DO:
        wdetail.policy       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.cndat        :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.comdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.expdat       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.covcod       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.garage       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.  
        wdetail.tiname       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.insnam       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        wdetail.policy       :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 
        
        wdetail.policy:FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.cndat        :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.comdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.expdat       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.covcod       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.garage       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.tiname       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.insnam       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
        wdetail.policy       :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR. 
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok c-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    IF ra_typefile = 2 THEN RUN proc_matchfilepol.
    ELSE DO:
        
    ASSIGN
        nv_batprev  = INPUT fi_prevbat
        fi_process  = "Load Text & Generate Amanh"
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0.
    DISP fi_process fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
    IF fi_branch = " " THEN DO: 
        MESSAGE "Branch Code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_branch.
        RETURN NO-APPLY.
    END.
    IF fi_producer = " " THEN DO:
        MESSAGE "Producer code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_producer.
        RETURN NO-APPLY.
    END.
    IF fi_agent = " " THEN DO:
        MESSAGE "Agent code is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" TO fi_Agent.
        RETURN NO-APPLY.
    END.
    IF fi_loaddat = ? THEN DO:
        MESSAGE "Load Date Is Mandatory" VIEW-AS ALERT-BOX .
        APPLY "entry" to fi_loaddat.
        RETURN NO-APPLY.
    END.
    IF fi_bchyr <= 0 THEN DO:
        MESSAGE "Batch Year Can't be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_bchyr.
        RETURN NO-APPLY.
    END.
    ASSIGN fi_output1 = INPUT fi_output1
        fi_output2    = INPUT fi_output2
        fi_output3    = INPUT fi_output3.
    IF fi_output1 = "" THEN DO:
        MESSAGE "Plese Input File Data Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output1.
        RETURN NO-APPLY.
    END.
    IF fi_output2 = "" THEN DO:
        MESSAGE "Plese Input File Data Not Load...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output2.
        RETURN NO-APPLY.
    END.
    IF fi_output3 = "" THEN DO:
        MESSAGE "Plese Input Batch File Name...!!!" VIEW-AS ALERT-BOX ERROR.
        APPLY "Entry" TO fi_output3.
        RETURN NO-APPLY.
    END.
    ASSIGN nv_batchyr = INPUT fi_bchyr.
    IF nv_batprev = "" THEN DO: 
        FIND LAST uzm700 USE-INDEX uzm70001    WHERE 
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.branch  = TRIM(nv_batbrn)   AND
            uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .
        IF AVAIL uzm700 THEN DO:  
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102 WHERE
                uzm701.bchyr  = nv_batchyr        AND
                uzm701.bchno  = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN  
                ASSIGN nv_batcnt   = uzm701.bchcnt  
                nv_batrunno = nv_batrunno + 1 . 
        END.
        ELSE 
            ASSIGN nv_batcnt = 1
                nv_batrunno  = 1.
        ASSIGN nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        ASSIGN 
            nv_batprev = INPUT fi_prevbat.
        FIND LAST uzm701 USE-INDEX uzm70102    WHERE
            uzm701.bchyr   = nv_batchyr        AND
            uzm701.bchno   = CAPS(nv_batprev)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev)
                + " on file uzm701" .
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        IF AVAIL uzm701 THEN  
            ASSIGN 
            nv_batcnt  = uzm701.bchcnt + 1 
            nv_batchno = CAPS(TRIM(nv_batprev)).
    END.
    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
        fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
        fi_usrcnt    = INPUT fi_usrcnt      fi_usrprem      = INPUT fi_usrprem
        nv_imppol    = fi_usrcnt            nv_impprem      = fi_usrprem 
        nv_tmppolrun = 0                    nv_daily        = ""
        nv_reccnt    = 0                    nv_completecnt  = 0
        nv_netprm_t  = 0                    nv_netprm_s     = 0
        nv_batbrn    = fi_branch .
    For each  wdetail :
        DELETE  wdetail.
    END.
    FOR EACH wuwd132.
        DELETE wuwd132.
    END.
    RUN proc_assign.
    FOR EACH wdetail :
        IF ( wdetail.poltyp    = "V70" )  OR ( wdetail.poltyp   = "V72" )  THEN DO:
            ASSIGN nv_reccnt   =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + decimal(wdetail.prem_r)
                wdetail.pass   = "Y". 
        END.
        ELSE DELETE WDETAIL.
    END.
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,   /* DATE  */
                           INPUT            nv_batchyr ,   /* INT   */
                           INPUT            fi_producer,   /* CHAR  */ 
                           INPUT            nv_batbrn  ,   /* CHAR  */
                           INPUT            fi_prevbat ,   /* CHAR  *//*Previous Batch*/
                           INPUT            "WGWTAMNH" ,   /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,   /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,   /* INT   */
                           INPUT            nv_imppol  ,   /* INT   */
                           INPUT            nv_impprem ).
    ASSIGN fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.

    RUN proc_chktest1.  

    FOR EACH wdetail WHERE wdetail.pass = "y"  NO-LOCK.
        ASSIGN 
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s    + decimal(wdetail.prem_r). 
    END.
    ASSIGN nv_rectot = nv_reccnt       
        nv_recsuc    = nv_completecnt. 
    IF nv_rectot <> nv_recsuc   THEN nv_batflg = NO.
    ELSE IF  nv_netprm_t <> nv_netprm_s THEN nv_batflg = NO.
    ELSE nv_batflg = YES.
    FIND LAST uzm701 USE-INDEX uzm70102 WHERE
        uzm701.bchyr   = nv_batchyr     AND
        uzm701.bchno   = nv_batchno     AND
        uzm701.bchcnt  = nv_batcnt      NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN uzm701.recsuc = nv_recsuc     
            uzm701.premsuc   = nv_netprm_s   
            uzm701.rectot    = nv_rectot     
            uzm701.premtot   = nv_netprm_t   
            uzm701.impflg    = nv_batflg    
            uzm701.cnfflg    = nv_batflg .  
    END.
    ASSIGN fi_impcnt   = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .
    IF (nv_rectot <> nv_recsuc)   THEN 
        nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".

    RELEASE uzm700.
    RELEASE uzm701.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm120.
    RELEASE sic_bran.uwm130.
    RELEASE sic_bran.uwm301.
    RELEASE brstat.detaitem.
    RELEASE sicsyac.xzm056.
    RELEASE sicsyac.xmm600.
    RELEASE sicsyac.xtm600.
    IF CONNECTED("sic_exp") THEN Disconnect  sic_exp.
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno      :FGCOLOR = 6. 
        DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE 
            "Batch Year  : " STRING(nv_batchyr)     SKIP
            "Batch No.   : " nv_batchno             SKIP
            "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
            TRIM(nv_txtmsg)                         SKIP
            "Please check Data again."      
            VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    RUN   proc_open.    
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .   
    RUN PROC_REPORT2 .
    RUN proc_screen  .  
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit c-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file c-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS    /* "Text Documents" "*.csv"*/
       "CSV (Comma Delimited)"   "*.csv"   /*,
                            "Data Files (*.dat)"     "*.dat",
                    "Text Files (*.txt)" "*.txt"*/
                    
                            
        MUST-EXIST
        USE-FILENAME
        UPDATE OKpressed.
      
    IF OKpressed = TRUE THEN DO:
         IF ra_typefile = 1 THEN DO: /*Load */
             ASSIGN 
                 no_add =           STRING(MONTH(TODAY),"99")    + 
                 STRING(DAY(TODAY),"99")      + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
             ASSIGN
                 fi_filename  = cvData
                 fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
                 fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
                 fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         END.
         ELSE DO:
             ASSIGN 
                 no_add =           STRING(MONTH(TODAY),"99")    + 
                 STRING(DAY(TODAY),"99")      + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                 SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .
             ASSIGN
                 fi_filename  = cvData
                 fi_output1   = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))   + no_add + "matpol.csv" /*.csv*/
                 fi_output2 = ""
                 fi_output3 = "".
         END.
         /*
         no_add =           STRING(MONTH(TODAY),"99")    + 
                            STRING(DAY(TODAY),"99")      + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),1,2) + 
                  SUBSTRING(STRING(TIME,"HH:MM:SS"),4,2) .

         /***---a490166 ---***/
         ASSIGN
            fi_filename  = cvData
            fi_output1 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SUCCESS" */ + no_add + ".fuw" /*.csv*/
            fi_output2 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_ERROR"   */ + no_add + ".err"
            fi_output3 = SUBSTRING(cvData,1,(LENGTH(fi_filename) - 4))  /* + "_SCREEN"  */ + no_add + ".sce". /*txt*/
         */

         DISP fi_filename fi_output1 fi_output2 fi_output3  WITH FRAME {&FRAME-NAME}. 
         APPLY "Entry" TO fi_output3.
         RETURN NO-APPLY.
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno1 c-Win
ON CHOOSE OF bu_hpacno1 IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                    output  n_agent).
                                          
     If  n_acno  <>  ""  Then  fi_producer =  n_acno.
     
     disp  fi_producer  with frame  fr_main.

     Apply "Entry"  to  fi_producer.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpagent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent c-Win
ON CHOOSE OF bu_hpagent IN FRAME fr_main
DO:
   Def   var     n_acno       As  Char.
   Def   var     n_agent      As  Char.    
     
   Run whp\whpacno1(output  n_acno,   /*a490166 note modi*/
                    output  n_agent). 
                                          
     If  n_acno  <>  ""  Then  fi_agent =  n_acno.
     
     disp  fi_agent  with frame  fr_main.

     Apply "Entry"  to  fi_agent.
     Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpbrn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn c-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
    Run  whp\whpbrn01(Input-output  fi_branch,   
                      Input-output  fi_brndes).
    Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
    Apply "Entry"  To  fi_producer.
    Return no-apply.                            
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent c-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600.."  View-as alert-box.
            Apply "Entry" To  fi_agent.
            RETURN NO-APPLY.  
        END.
        ELSE   
            ASSIGN  
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent) .   
    END.
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ap01
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ap01 c-Win
ON LEAVE OF fi_ap01 IN FRAME fr_main
DO:
    fi_tpbip = INPUT fi_tpbip.
    DISP fi_tpbip WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ap02
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ap02 c-Win
ON LEAVE OF fi_ap02 IN FRAME fr_main
DO:
    fi_tpbiac = INPUT fi_tpbiac.
    DISP fi_tpbiac WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_ap03
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_ap03 c-Win
ON LEAVE OF fi_ap03 IN FRAME fr_main
DO:
  fi_tppda = INPUT fi_tppda .
  DISP fi_tppda WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr c-Win
ON LEAVE OF fi_bchyr IN FRAME fr_main
DO:
        nv_batchyr = INPUT fi_bchyr.
        IF nv_batchyr <= 0 THEN DO:
           MESSAGE "Batch Year Error...!!!".
           APPLY "entry" TO fi_bchyr.
           RETURN NO-APPLY.
        END.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_branch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch c-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
    fi_branch = caps(INPUT fi_branch) .
    IF  Input fi_branch  =  ""  Then do:
        Message "กรุณาระบุ Branch Code ." View-as alert-box.
        Apply "Entry"  To  fi_branch.
    END.
    Else do:
        FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
            sicsyac.xmm023.branch   = TRIM(Input fi_branch)  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
            Message  "Not on Description Master File xmm023" View-as alert-box.
            Apply "Entry"  To  fi_branch.
            RETURN NO-APPLY.
        END.
        ELSE 
            ASSIGN fi_branch  =  CAPS(Input fi_branch) 
            fi_brndes  =  sicsyac.xmm023.bdes.
    END.    /*else do:*/
    Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_comcode
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_comcode c-Win
ON LEAVE OF fi_comcode IN FRAME fr_main
DO:
    fi_comcode = INPUT fi_comcode.
    DISP fi_comcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_commision70
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_commision70 c-Win
ON LEAVE OF fi_commision70 IN FRAME fr_main
DO:
    fi_commision70 = INPUT fi_commision70.
    DISP fi_commision70 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_commision72
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_commision72 c-Win
ON LEAVE OF fi_commision72 IN FRAME fr_main
DO:
    fi_commision72 = INPUT fi_commision72.
    DISP fi_commision72 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat c-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack c-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
    fi_pack = INPUT fi_pack.
    DISP fi_pack WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack1 c-Win
ON LEAVE OF fi_pack1 IN FRAME fr_main
DO:
    fi_pack1 = INPUT fi_pack1.
    DISP fi_pack1 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack2 c-Win
ON LEAVE OF fi_pack2 IN FRAME fr_main
DO:
    fi_pack2 = INPUT fi_pack2.
    DISP fi_pack2 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack2plus
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack2plus c-Win
ON LEAVE OF fi_pack2plus IN FRAME fr_main
DO:
    fi_pack2plus = INPUT fi_pack2plus.
    DISP fi_pack2plus WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack3
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack3 c-Win
ON LEAVE OF fi_pack3 IN FRAME fr_main
DO:
    fi_pack3 = INPUT fi_pack3.
    DISP fi_pack3 WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat c-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) > 16 THEN DO:
            MESSAGE "Length Of Batch no. Must Be 16 Character " SKIP
                    "Please Check Batch No. Again             " view-as alert-box.
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
    END.     /*nv_batprev <> " "*/
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer c-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer.
    IF  fi_producer <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001          WHERE
            sicsyac.xmm600.acno  =  Input fi_producer   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer.
            RETURN NO-APPLY.    /*note add on 10/11/2005*/
        END.
        ELSE 
            ASSIGN
                fi_proname  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer =  caps(INPUT  fi_producer)  /*note modi 08/11/05*/
                /*nv_producer = fi_producer*/    .       /*note add  08/11/05*/
         
    END.
    Disp  fi_producer  fi_proname  WITH Frame  fr_main.   
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_rwpack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_rwpack c-Win
ON LEAVE OF fi_rwpack IN FRAME fr_main
DO:
    fi_comcode = INPUT fi_comcode.
    DISP fi_comcode WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tpbiac
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tpbiac c-Win
ON LEAVE OF fi_tpbiac IN FRAME fr_main
DO:
    fi_tpbiac = INPUT fi_tpbiac.
    DISP fi_tpbiac WITH FRAM fr_main.
  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tpbip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tpbip c-Win
ON LEAVE OF fi_tpbip IN FRAME fr_main
DO:
    fi_tpbip = INPUT fi_tpbip.
    DISP fi_tpbip WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_tppda
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_tppda c-Win
ON LEAVE OF fi_tppda IN FRAME fr_main
DO:
  fi_tppda = INPUT fi_tppda .
  DISP fi_tppda WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrcnt
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrcnt c-Win
ON LEAVE OF fi_usrcnt IN FRAME fr_main
DO:
  fi_usrcnt = INPUT fi_usrcnt.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_usrprem
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_usrprem c-Win
ON LEAVE OF fi_usrprem IN FRAME fr_main
DO:
  fi_usrprem = INPUT fi_usrprem.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typefile
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typefile c-Win
ON VALUE-CHANGED OF ra_typefile IN FRAME fr_main
DO:
  ra_typefile = INPUT ra_typefile.
  DISP ra_typefile WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_cam
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK c-Win 


/* ***************************  Main Block  *************************** */
/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.
/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.
 
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
   RUN enable_UI.
/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)"  NO-UNDO.
  ASSIGN 
      gv_prgid = "wgwtamnh.w"
      gv_prog  = "Load Text & Generate AMNH "
      fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  
  ASSIGN
      fi_comcode   = "AMNH"
      /* a63-0168...
      fi_pack1     = "Z" 
      fi_pack2     = "Y" 
      fi_pack3     = "P" 
      fi_pack2plus = "C" 
      .. end A63-0168..*/
      /* a63-0168...*/
      fi_pack1     = "T" 
      fi_pack2     = "T" 
      fi_pack3     = "T" 
      fi_pack2plus = "T" 
      fi_pack      = "PACK_AMANAH" 
      fi_rwpack    = "PACK RENEW"
      /*.. end A63-0168..*/
      fi_branch    = "M" 
      ra_typefile  = 1
      fi_tpbip     = 1000000
      fi_tpbiac    = 10000000
      fi_tppda     = 2500000
      fi_ap01      = 100000
      fi_ap02      = 100000
      fi_ap03      = 200000
  
      /*fi_commision70   = 15 */ /*A64-0150*/
      fi_commision70   = 18      /*A64-0150*/
      fi_commision72   = 12     
      /*fi_vatcod    = "MC27230"*/
      /*fi_producer  = "A0M0123"*/ /*Add by Kridtiya i. A63-0472*/ 
      fi_producer  = "A0MLAMA102"  /*Add by Kridtiya i. A63-0472*/ 
      /*fi_agent     = "B300303"*/ /*A62-0445*/
      /*fi_agent     = "B3W0100"   /*A62-0445*/*//*Add by Kridtiya i. A63-0472*/
      /*fi_agent     = "B3W0100"   /*Add by Kridtiya i. A63-0472*/ -- Comment By Tontawan S . --*/
      fi_agent     = "B300316"     /*------------------ Add By Tontawan S A66-0139 29/06/2023 --*/
      fi_bchyr     = YEAR(TODAY)
      fi_process   = "Load Text & Generate AMNH " .
  DISP fi_pack1    fi_pack2    fi_pack3    fi_pack2plus    fi_comcode  ra_typefile
       fi_process  fi_branch   /*fi_vatcod*/  fi_commision70  fi_commision72  
       fi_tpbip    fi_tpbiac  fi_tppda  fi_ap01    fi_ap02    fi_ap03  fi_producer   
       fi_agent fi_bchyr   fi_pack fi_rwpack /*a63-0169*/
      WITH FRAME fr_main.
  RUN proc_packpara. /*a63-0169*/
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:handle).  
  Session:data-Entry-Return = Yes.
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI c-Win  _DEFAULT-DISABLE
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
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
  THEN DELETE WIDGET c-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI c-Win  _DEFAULT-ENABLE
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
  DISPLAY ra_typefile fi_loaddat fi_tpbip fi_tpbiac fi_tppda fi_ap01 fi_ap02 
          fi_ap03 fi_producer fi_agent fi_commision70 fi_commision72 fi_branch 
          fi_prevbat fi_bchyr fi_filename fi_proname fi_agtname fi_brndes 
          fi_output1 fi_output2 fi_output3 fi_usrprem fi_usrcnt fi_process 
          fi_premtot fi_impcnt fi_bchno fi_premsuc fi_completecnt fi_pack1 
          fi_pack2 fi_pack3 fi_pack2plus fi_comcode fi_pack fi_rwpack 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE br_cam ra_typefile fi_loaddat fi_tpbip fi_tpbiac fi_tppda fi_ap01 
         fi_ap02 fi_ap03 fi_producer fi_agent fi_commision70 fi_commision72 
         fi_branch fi_prevbat fi_bchyr fi_filename bu_file buok bu_exit 
         bu_hpacno1 bu_hpagent br_wdetail bu_hpbrn fi_output1 fi_output2 
         fi_output3 fi_usrprem fi_usrcnt fi_process fi_bchno fi_pack1 fi_pack2 
         fi_pack3 fi_pack2plus fi_comcode fi_pack fi_rwpack RECT-370 RECT-372 
         RECT-373 RECT-374 RECT-376 RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW c-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW c-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 c-Win 
PROCEDURE proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/************** v72 comp y **********/
DEF VAR np_models  AS CHAR FORMAT "x(55)"  INIT "" .
DEF VAR classmat72 AS CHAR FORMAT "x(3)"   INIT "" .
DEF VAR class72    AS CHAR FORMAT "x(3)"   INIT "" .
ASSIGN 
    classmat72     = substr(wdetail.class,2,3)   /* class 140A */
    wdetail.PASS   = "Y"
    wdetail.tariff = "9"
    wdetail.covcod = "T"
    wdetail.compul = "y"
    fi_process = "Process data Siam Carrent Group....compulsary "  + wdetail.policy .
IF      SUBSTR(wdetail.class,2,3) = "110" THEN ASSIGN wdetail.class = "110".
ELSE IF SUBSTR(wdetail.class,2,3) = "320" THEN ASSIGN wdetail.class = "140A".
ELSE IF SUBSTR(wdetail.class,2,3) = "210" THEN ASSIGN wdetail.class = "120A".
DISP fi_process WITH FRAM fr_main.
IF wdetail.vehreg = "" THEN wdetail.vehreg = IF SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8) <> "" THEN
                                             "/" +   SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8 ) 
                                             ELSE "".
IF wdetail.compul <> "y" THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| poltyp เป็น v72 Compulsory ต้องเป็น y" 
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N". 
IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" THEN DO:    
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN 
            ASSIGN 
            wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
            wdetail.pass    = ""
            wdetail.OK_GEN  = "N".
    END.
END.
IF wdetail.n_branch = ""  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| พบสาขาเป็นค่าว่าง "
    wdetail.OK_GEN  = "N".
/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  
    xmm016.class =   wdetail.class  NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
    wdetail.pass    = "N"
    wdetail.OK_GEN  = "N".
/*------------- poltyp ------------*/
FIND  sicsyac.xmd031 USE-INDEX xmd03101     WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.class   NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmd031 THEN 
    ASSIGN 
    wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
    wdetail.OK_GEN  = "N".
/*---------- covcod ----------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN wdetail.pass    = "N"
    wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
    wdetail.OK_GEN  = "N".
FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = "110" AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  
    wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
    wdetail.OK_GEN  = "N".
/*--------- modcod --------------*/
/*
IF      substr(wdetail.class,2,3) = "110" THEN classmat72 = "110".
ELSE IF wdetail.class = "140A"            THEN classmat72 = "V210".
ELSE IF substr(wdetail.class,2,3) = "320" THEN classmat72 = "320".
ELSE IF substr(wdetail.class,2,3) = "210" THEN classmat72 = "210".
ELSE DO:
    FIND FIRST sicsyac.xzmcom WHERE  
        sicsyac.xzmcom.comp_cod = substr(wdetail.class,1,1) + "." + substr(wdetail.class,2)   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xzmcom  THEN 
        ASSIGN classmat72 = SUBSTR(sicsyac.xzmcom.class,2,3) .
    ELSE classmat72 = "".
END.
*/
ASSIGN chkred = NO.
IF INDEX(wdetail.model," ") <> 0 THEN DO: 
    ASSIGN np_models  = ""
        np_models     = wdetail.model
        wdetail.model = TRIM(SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))) .
END.
/*
Find First stat.maktab_fil USE-INDEX maktab04    Where
    stat.maktab_fil.makdes   =     wdetail.brand            And                  
    index(stat.maktab_fil.moddes,wdetail.model) <> 0        And
    stat.maktab_fil.makyea   =     Integer(wdetail.caryear) AND 
    stat.maktab_fil.sclass   =     classmat72               No-lock no-error no-wait.
If  avail stat.maktab_fil  Then 
    ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        /*wdetail.engcc    =  STRING(stat.maktab_fil.engine)*/
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
ELSE wdetail.redbook = "".*/
FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  classmat72   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN nv_simat  = makdes31.si_theft_p   
               nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN  
        nv_simat  = 20
        nv_simat1 = 20.
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =  trim(wdetail.brand)                           And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0                          And
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)                      AND 
        stat.maktab_fil.engine   =  deci(wdetail.engcc)                           AND
        stat.maktab_fil.sclass   =  classmat72                   AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)   AND 
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  /*AND  
        stat.maktab_fil.seats    >=    DECI(wdetail.seat) */      No-lock no-error no-wait.
    If  avail stat.maktab_fil  THEN
        ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    ELSE wdetail.redbook  = "".
    /*A57-0186*/

IF wdetail.redbook  = "" THEN DO:
    IF INDEX(np_models,"ALL NEW") <> 0 THEN DO: 
        ASSIGN  wdetail.model = trim(replace(np_models,"ALL NEW","")).

        Find FIRST stat.maktab_fil Use-index      maktab04         Where
            stat.maktab_fil.makdes   =     trim(wdetail.brand)     And                  
            index(stat.maktab_fil.moddes,wdetail.model) <> 0       And
            stat.maktab_fil.makyea   =   Integer(wdetail.caryear)  AND
            stat.maktab_fil.engine   =  deci(wdetail.engcc)        AND
            stat.maktab_fil.sclass   =  classmat72     AND
           (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)   AND
            stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  /*AND  
        stat.maktab_fil.seats    >=    DECI(wdetail.seat) */      No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN 
            wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  stat.maktab_fil.body 
            wdetail.Tonn     =  stat.maktab_fil.tons
            wdetail.engcc    =  STRING(stat.maktab_fil.engine)
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    END.
END.
/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN     
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
        wdetail.OK_GEN  = "N".
ASSIGN
    nv_docno  = " "
    nv_accdat = TODAY.
/***--- Docno ---***/
IF wdetail.docno <> " " THEN DO:
    FIND FIRST sicuw.uwm100 USE-INDEX uwm10090 WHERE
        sicuw.uwm100.trty11 = "M" AND
        sicuw.uwm100.docno1 = STRING(wdetail.docno,"9999999")
        NO-LOCK NO-ERROR .
    IF (AVAILABLE sicuw.uwm100) AND (sicuw.uwm100.policy <> wdetail.policy) THEN 
        ASSIGN  
        wdetail.pass    = "N"  
        wdetail.comment = "Receipt is Dup. on uwm100 :" + string(sicuw.uwm100.policy,"x(16)") +
        STRING(sicuw.uwm100.rencnt,"99")  + "/" +
        STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
        wdetail.OK_GEN  = "N".
    ELSE  nv_docno = wdetail.docno.
END.
/***--- Account Date ---***/
IF wdetail.accdat <> " "  THEN nv_accdat = date(wdetail.accdat).
ELSE nv_accdat = TODAY.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 c-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
/* ---------------------------------------------  U W M 1 3 0 -------------- */
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND    
    sic_bran.uwm130.riskno = s_riskno               AND   
    sic_bran.uwm130.itemno = s_itemno               AND   
    sic_bran.uwm130.bchyr  = nv_batchyr             AND   
    sic_bran.uwm130.bchno  = nv_batchno             AND   
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.
    ASSIGN    
        sic_bran.uwm130.bchyr  = nv_batchyr     /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno     /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt .    /* bchcnt     */
    ASSIGN
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class  NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  
        sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
        sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
        nv_comper              = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc              = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v = nv_comper   
        sic_bran.uwm130.uom9_v = nv_comacc  .   
    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         
                                nv_riskno,
                                nv_itemno).
    END. /*do transaction*/
    /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
    ASSIGN s_recid3  = RECID(sic_bran.uwm130)
        nv_covcod =   wdetail.covcod
        nv_makdes  =  wdetail.brand
        nv_moddes  =  wdetail.model
        nv_newsck = " ".
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck = wdetail.stk.
    FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
        sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm301.riskgp = s_riskgp                AND
        sic_bran.uwm301.riskno = s_riskno                AND
        sic_bran.uwm301.itemno = s_itemno                AND
        sic_bran.uwm301.bchyr  = nv_batchyr              AND 
        sic_bran.uwm301.bchno  = nv_batchno              AND 
        sic_bran.uwm301.bchcnt = nv_batcnt       NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END.  /*transaction*/
    END.
    Assign             
        sic_bran.uwm301.policy   = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno   = s_itemno
        sic_bran.uwm301.tariff   = wdetail.tariff
        sic_bran.uwm301.covcod   = nv_covcod
        sic_bran.uwm301.cha_no   = wdetail.chassis
        sic_bran.uwm301.eng_no   = wdetail.engno
        sic_bran.uwm301.Tons     = INTEGER(wdetail.tonn)
        sic_bran.uwm301.vehgrp   = wdetail.cargrp
        sic_bran.uwm301.engine   = deci(wdetail.engcc)                    
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage   = wdetail.garage
        sic_bran.uwm301.body     = wdetail.body
        sic_bran.uwm301.seats    = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv_ben83 = ""
        sic_bran.uwm301.vehreg   = wdetail.vehreg 
        sic_bran.uwm301.yrmanu   = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.brand + " " + wdetail.model 
        sic_bran.uwm301.modcod   = wdetail.redbook 
        sic_bran.uwm301.sckno    = 0              
        sic_bran.uwm301.itmdel   = NO
        sic_bran.uwm301.bchyr    = nv_batchyr         /* batch Year */      
        sic_bran.uwm301.bchno    = nv_batchno         /* bchno    */      
        sic_bran.uwm301.bchcnt   = nv_batcnt .        /* bchcnt     */  
    /*-----compul-----*/
    IF wdetail.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(wdetail.stk) = 11 THEN DO:    
            sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
        END.
        IF LENGTH(wdetail.stk) = 13  THEN DO:
            sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
        END.  
        IF wdetail.stk = ""  THEN DO:
            sic_bran.uwm301.drinam[9] = "".
        END. 
        /*--create detaitem--*/
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
            brstat.detaitem.policy     = sic_bran.uwm301.policy AND
            brstat.Detaitem.rencnt     = sic_bran.uwm301.rencnt AND
            brstat.Detaitem.endcnt     = sic_bran.uwm301.endcnt AND
            brStat.Detaitem.serailno   = wdetail.stk            AND 
            brstat.detaitem.yearReg    = nv_batchyr             AND
            brstat.detaitem.seqno      = STRING(nv_batchno)     AND
            brstat.detaitem.seqno2     = STRING(nv_batcnt)      NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.Detaitem THEN DO:   
            CREATE brstat.Detaitem.
            ASSIGN                                                            
                brstat.detaitem.policy   = sic_bran.uwm301.policy                 
                brstat.Detaitem.rencnt   = sic_bran.uwm301.rencnt                 
                brstat.Detaitem.endcnt   = sic_bran.uwm301.endcnt                 
                brstat.Detaitem.riskno   = sic_bran.uwm301.riskno                 
                brstat.Detaitem.itemno   = sic_bran.uwm301.itemno                 
                brstat.detaitem.serailno = wdetail.stk
                brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
                brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
                brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt).  
        END.
    END.
    ELSE  sic_bran.uwm301.drinam[9] = "".
    ASSIGN  s_recid4   = RECID(sic_bran.uwm301).
    IF wdetail.redbook = "" THEN DO:
        FIND LAST sicsyac.xmm102   WHERE
            INDEX(wdetail.model,trim(substr(sicsyac.xmm102.modest,INDEX(sicsyac.xmm102.modest," ") + 1 ))) <> 0   AND 
            INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0  NO-LOCK   NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
                sic_bran.uwm301.Tons           = sicsyac.xmm102.tons
                sic_bran.uwm301.body           = sicsyac.xmm102.body     
                sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                wdetail.redbook                = sicsyac.xmm102.modcod
                wdetail.brand                  = IF LENGTH(xmm102.modest) >= 18 THEN SUBSTRING(xmm102.modest,1,18) ELSE xmm102.modest  .  
        END.
        ELSE  wdetail.redbook = "" .
        IF   wdetail.redbook = "" THEN DO:  
            FIND LAST sicsyac.xmm102   WHERE INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0  NO-LOCK   NO-ERROR.
            IF AVAIL sicsyac.xmm102  THEN DO:
                ASSIGN
                    sic_bran.uwm301.modcod = sicsyac.xmm102.modcod
                    sic_bran.uwm301.Tons   = sicsyac.xmm102.tons
                    sic_bran.uwm301.body   = sicsyac.xmm102.body
                    sic_bran.uwm301.vehgrp = sicsyac.xmm102.vehgrp
                    sic_bran.uwm301.engine = sicsyac.xmm102.engine 
                    wdetail.tonn           = sicsyac.xmm102.tons  
                    wdetail.engcc          = string(sicsyac.xmm102.engine)
                    wdetail.redbook        = sicsyac.xmm102.modcod   .  
            END.
        END.
    END.
    FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
         sic_bran.uwd132.policy = sic_bran.uwm100.policy AND
         sic_bran.uwd132.rencnt = sic_bran.uwm100.rencnt AND
         sic_bran.uwd132.endcnt = sic_bran.uwm100.endcnt AND
         sic_bran.uwd132.riskgp = s_riskgp               AND
         sic_bran.uwd132.riskno = s_riskno               AND
         sic_bran.uwd132.itemno = s_itemno               AND
         sic_bran.uwd132.bchyr  = nv_batchyr             AND
         sic_bran.uwd132.bchno  = nv_batchno             AND
         sic_bran.uwd132.bchcnt = nv_batcnt    NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
        IF LOCKED sic_bran.uwd132 THEN DO:
            MESSAGE "พบกำลังใช้งาน Insured (UWD132)" wdetail.policy
                "ไม่สามารถ Generage ข้อมูลได้".
            NEXT.
        END.
        CREATE sic_bran.uwd132.
    END.
    ASSIGN
      sic_bran.uwd132.bencod  = "COMP"                   /*Benefit Code*/
      sic_bran.uwd132.benvar  = ""                       /*Benefit Variable*/
      sic_bran.uwd132.rate    = 0                        /*Premium Rate %*/
      sic_bran.uwd132.gap_ae  = NO                       /*GAP A/E Code*/
      sic_bran.uwd132.gap_c   = 0    /*deci(wdetail.premt)  kridtiya i.*/      /*GAP, per Benefit per Item*/
      sic_bran.uwd132.dl1_c   = 0                        /*Disc./Load 1,p. Benefit p.Item*/
      sic_bran.uwd132.dl2_c   = 0                        /*Disc./Load 2,p. Benefit p.Item*/
      sic_bran.uwd132.dl3_c   = 0                        /*Disc./Load 3,p. Benefit p.Item*/
      sic_bran.uwd132.pd_aep  = "E"                      /*Premium Due A/E/P Code*/
      sic_bran.uwd132.prem_c  = 0   /*kridtiya i. deci(wdetail.premt) */     /*PD, per Benefit per Item*/
      sic_bran.uwd132.fptr    = 0                        /*Forward Pointer*/
      sic_bran.uwd132.bptr    = 0                        /*Backward Pointer*/
      sic_bran.uwd132.policy  = wdetail.policy           /*Policy No. - uwm130*/
      sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt   /*Renewal Count - uwm130*/
      sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt   /*Endorsement Count - uwm130*/
      sic_bran.uwd132.riskgp  = s_riskgp                 /*Risk Group - uwm130*/
      sic_bran.uwd132.riskno  = s_riskno                 /*Risk No. - uwm130*/
      sic_bran.uwd132.itemno  = s_itemno                 /*Insured Item No. - uwm130*/
      sic_bran.uwd132.rateae  = NO                       /*Premium Rate % A/E Code*/
      sic_bran.uwm130.fptr03  = RECID(sic_bran.uwd132)   /*First uwd132 Cover & Premium*/
      sic_bran.uwm130.bptr03  = RECID(sic_bran.uwd132)   /*Last  uwd132 Cover & Premium*/
      sic_bran.uwd132.bchyr   = nv_batchyr  
      sic_bran.uwd132.bchno   = nv_batchno  
      sic_bran.uwd132.bchcnt  = nv_batcnt .
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 c-Win 
PROCEDURE proc_723 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER  s_recid1   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid2   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid3   AS   RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  s_recid4   AS   RECID     NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER  nv_message AS   CHARACTER NO-UNDO.
ASSIGN 
    nv_rec100 = s_recid1
    nv_rec120 = s_recid2 
    nv_rec130 = s_recid3
    nv_rec301 = s_recid4
    nv_message = "" 
    nv_gap     = 0 
    nv_prem    = 0.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = nv_rec301 NO-WAIT NO-ERROR.
IF sic_bran.uwm130.fptr03 = 0 OR sic_bran.uwm130.fptr03 = ? THEN DO:
    FIND sicsyac.xmm107 USE-INDEX xmm10701      WHERE
        sicsyac.xmm107.class  = wdetail.class   AND
        sicsyac.xmm107.tariff = wdetail.tariff  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sicsyac.xmm107 THEN DO:
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                sicsyac.xmm016.class = wdetail.class  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm016 THEN 
                ASSIGN sic_bran.uwd132.gap_ae = NO
                sic_bran.uwd132.pd_aep = "E".
            ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   sic_bran.uwd132.policy = wdetail.policy
                sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt  sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp  sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                sic_bran.uwd132.bptr   = 0
                sic_bran.uwd132.fptr   = 0          
                nvffptr     = xmd107.fptr
                s_130bp1    = RECID(sic_bran.uwd132)
                s_130fp1    = RECID(sic_bran.uwd132)
                n_rd132     = RECID(sic_bran.uwd132)
                sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
                sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .        /* bchcnt     */ 
            FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                sicsyac.xmm105.tariff = wdetail.tariff  AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* Malaysia */
                IF           wdetail.class      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = inte(wdetail.tonn).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND
                    sicsyac.xmm106.class   = wdetail.class AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= nv_key_a         AND
                    sicsyac.xmm106.key_b  >= nv_key_b         AND
                    sicsyac.xmm106.effdat <= uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0                AND
                    sicsyac.xmm106.key_b   = 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
            loop_def:
            REPEAT:
                IF nvffptr EQ 0 THEN LEAVE loop_def.
                FIND sicsyac.xmd107 WHERE RECID(sicsyac.xmd107) EQ nvffptr
                    NO-LOCK NO-ERROR NO-WAIT.
                nvffptr   = sicsyac.xmd107.fptr.
                CREATE sic_bran.uwd132.
                ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod    sic_bran.uwd132.policy = wdetail.policy
                    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt   sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp   sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                    sic_bran.uwd132.fptr   = 0
                    sic_bran.uwd132.bptr   = n_rd132
                    sic_bran.uwd132.bchyr = nv_batchyr      /* batch Year */      
                    sic_bran.uwd132.bchno = nv_batchno      /* bchno    */      
                    sic_bran.uwd132.bchcnt  = nv_batcnt     /* bchcnt     */      
                    n_rd132                 = RECID(sic_bran.uwd132).
                FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
                    sicsyac.xmm016.class = wdetail.class
                    NO-LOCK NO-ERROR.
                IF AVAIL sicsyac.xmm016 THEN 
                    ASSIGN sic_bran.uwd132.gap_ae = NO
                    sic_bran.uwd132.pd_aep = "E".
                FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
                    sicsyac.xmm105.tariff = wdetail.tariff  AND
                    sicsyac.xmm105.bencod = sicsyac.xmd107.bencod
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
                ELSE   MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                    "Tariff" wdetail.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.
                IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                    IF           wdetail.class      = "110" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                    ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                    ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = inte(wdetail.tonn).
                    nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff   AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.class    AND
                        sicsyac.xmm106.covcod  = wdetail.covcod   AND
                        sicsyac.xmm106.key_a  >= nv_key_a        AND
                        sicsyac.xmm106.key_b  >= nv_key_b        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE sicsyac.xmm106 THEN 
                        ASSIGN
                            sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                            sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                            nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                            nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                END.
                ELSE DO:
                    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                 WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff           AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                        sicsyac.xmm106.class   = wdetail.class            AND
                        sicsyac.xmm106.covcod  = wdetail.covcod           AND
                        sicsyac.xmm106.key_a  >= 0                        AND
                        sicsyac.xmm106.key_b  >= 0                        AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601                  WHERE
                        sicsyac.xmm106.tariff  = wdetail.tariff            AND
                        sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod    AND
                        sicsyac.xmm106.class   = wdetail.class             AND
                        sicsyac.xmm106.covcod  = wdetail.covcod            AND
                        sicsyac.xmm106.key_a   = 0                         AND
                        sicsyac.xmm106.key_b   = 0                         AND
                        sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                        NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAILABLE xmm106 THEN DO:
                        sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                        RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                            RECID(sic_bran.uwd132),
                                            sic_bran.uwm301.tariff).
                        nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                        nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                    END.
                END.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ s_130bp1 NO-WAIT NO-ERROR.
                sic_bran.uwd132.fptr   = n_rd132.
                FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ n_rd132 NO-WAIT NO-ERROR.
                s_130bp1      = RECID(sic_bran.uwd132).
                NEXT loop_def.
            END.
        END.
    END.
    ELSE DO:   
        ASSIGN s_130fp1 = 0
        s_130bp1 = 0.
        MESSAGE "ไม่พบ Class " wdetail.class " ใน Tariff  " wdetail.tariff  skip
                        "กรุณาใส่ Class หรือ Tariff ใหม่อีกครั้ง" VIEW-AS ALERT-BOX.
    END.
    ASSIGN sic_bran.uwm130.fptr03 = s_130fp1
        sic_bran.uwm130.bptr03 = s_130bp1.
END.
ELSE DO:                              
    s_130fp1 = sic_bran.uwm130.fptr03.
    DO WHILE s_130fp1 <> ? AND s_130fp1 <> 0:
        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = s_130fp1 NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwd132 THEN DO:
            s_130fp1 = sic_bran.uwd132.fptr.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
                IF           wdetail.class      = "110" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = inte(wdetail.seat).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = inte(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = inte(wdetail.tonn).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601                WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff          AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod  AND
                    sicsyac.xmm106.class   = wdetail.class        AND
                    sicsyac.xmm106.covcod  = wdetail.covcod          AND
                    sicsyac.xmm106.key_a  >= nv_key_a                AND 
                    sicsyac.xmm106.key_b  >= nv_key_b                AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE xmm106 THEN 
                    ASSIGN sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                ELSE  nv_message = "NOTFOUND".
            END.
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601            WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff      AND 
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                    sicsyac.xmm106.class   = wdetail.class    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                    sicsyac.xmm106.key_a  >= 0                   AND 
                    sicsyac.xmm106.key_b  >= 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class    AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a   = 0               AND
                    sicsyac.xmm106.key_b   = 0               AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN proc_wgw72013   (INPUT RECID(sic_bran.uwm100), 
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.
        END.
    END.
END.
/*
IF fi_policymas72 <> ""  THEN DO:
    ASSIGN         
        nv_gapprm = 0
        nv_pdprm  = 0.
    FOR EACH sicuw.uwd132 WHERE 
        sicuw.uwd132.policy = fi_policymas72   NO-LOCK  .
        ASSIGN 
            nv_gapprm                = nv_gapprm + sicuw.uwd132.gap_c  
            nv_pdprm                 = nv_pdprm  + sicuw.uwd132.prem_c .
        FIND LAST  sic_bran.uwd132  USE-INDEX uwd13201  WHERE /*a490116 note change index from uwd13290 to uwd13201*/
            sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
            sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
            sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
            sic_bran.uwd132.bencod  = sicuw.uwd132.bencod     AND 
            sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
            sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
            sic_bran.uwd132.bchyr   = sic_bran.uwm130.bchyr   AND
            sic_bran.uwd132.bchno   = sic_bran.uwm130.bchno   AND
            sic_bran.uwd132.bchcnt  = sic_bran.uwm130.bchcnt  NO-ERROR    .
        IF AVAIL sic_bran.uwd132 THEN  
            ASSIGN  
            sic_bran.uwd132.bencod   = sicuw.uwd132.bencod   
            sic_bran.uwd132.benvar   = sicuw.uwd132.benvar
            sic_bran.uwd132.gap_c    = sicuw.uwd132.gap_c   
            sic_bran.uwd132.prem_c   = sicuw.uwd132.prem_c
            nv_gapprm =   sicuw.uwd132.gap_c   
            nv_pdprm  =  sicuw.uwd132.prem_c .
            
    END.
END.*/
RUN proc_7231.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_7231 c-Win 
PROCEDURE proc_7231 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_stm_per = 0.4
    nv_tax_per = 7.0.
FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
    sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
    sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri
    NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN ASSIGN nv_stm_per             = sicsyac.xmm020.rvstam
    nv_tax_per             = sicsyac.xmm020.rvtax
    sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.
ASSIGN  nv_gap2  = 0
    nv_prem2 = 0
    nv_rstp  = 0
    nv_rtax  = 0
    nv_com1_per = 0
    nv_com1_prm = 0.
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sicsyac.xmm031 THEN nv_com1_per = sicsyac.xmm031.comm1.
FOR EACH sic_bran.uwm120 WHERE
    sic_bran.uwm120.policy = wdetail.policy         AND
    sic_bran.uwm120.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm120.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm120.bchyr = nv_batchyr              AND 
    sic_bran.uwm120.bchno = nv_batchno              AND 
    sic_bran.uwm120.bchcnt  = nv_batcnt             :
    ASSIGN nv_gap  = 0
        nv_prem = 0.
    FOR EACH sic_bran.uwm130 WHERE
        sic_bran.uwm130.policy = wdetail.policy AND
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp AND
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno AND
        sic_bran.uwm130.bchyr = nv_batchyr            AND 
        sic_bran.uwm130.bchno = nv_batchno            AND 
        sic_bran.uwm130.bchcnt  = nv_batcnt             NO-LOCK:
        nv_fptr = sic_bran.uwm130.fptr03.
        DO WHILE nv_fptr <> 0 AND nv_fptr <> ? :
            FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr
                NO-LOCK NO-ERROR NO-WAIT.
            IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
            nv_fptr = sic_bran.uwd132.fptr.
            nv_gap  = nv_gap  + sic_bran.uwd132.gap_c.
            nv_prem = nv_prem + sic_bran.uwd132.prem_c.
        END.
    END.
    sic_bran.uwm120.gap_r   =  nv_gap.
    sic_bran.uwm120.prem_r  =  nv_prem.
    sic_bran.uwm120.rstp_r  =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
        (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
         TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0  THEN 1 ELSE 0).
    sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2).
    nv_gap2  = nv_gap2  + nv_gap.
    nv_prem2 = nv_prem2 + nv_prem.
    nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r.
    nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.
    IF sic_bran.uwm120.com1ae = NO THEN
        nv_com1_per            = sic_bran.uwm120.com1p.
    IF nv_com1_per <> 0 THEN 
        ASSIGN sic_bran.uwm120.com1ae =  NO
        sic_bran.uwm120.com1p  =  nv_com1_per
        sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-
        nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
    ELSE DO:
        IF nv_com1_per   = 0  AND sic_bran.uwm120.com1ae = NO THEN 
            ASSIGN
            sic_bran.uwm120.com1p  =  0
            sic_bran.uwm120.com1_r =  0
            sic_bran.uwm120.com1_r =  0
            nv_com1_prm            =  0.
    END.
END.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
ASSIGN
    sic_bran.uwm100.gap_p  =  nv_gap2
    sic_bran.uwm100.prem_t =  nv_prem2
    sic_bran.uwm100.rstp_t =  nv_rstp
    sic_bran.uwm100.rtax_t =  nv_rtax
    sic_bran.uwm100.com1_t =  nv_com1_prm.

RUN proc_chktest4.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem c-Win 
PROCEDURE proc_adduwd132prem :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
DEF VAR nv_ncbyrs AS INT INIT 0.
DO:
    FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
    FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.

    ASSIGN nv_bptr = 0      nv_gapprm   = 0     nv_pdprm    = 0 .
     FOR EACH stat.pmuwd132 USE-INDEX pmuwd13201 WHERE 
              stat.pmuwd132.campcd    = sic_bran.uwm100.policy AND
              stat.pmuwd132.policy    = sic_bran.uwm100.policy AND
              stat.pmuwd132.rencnt    = sic_bran.uwm100.rencnt AND
              stat.pmuwd132.endcnt    = sic_bran.uwm100.endcnt AND
              stat.pmuwd132.txt1      = STRING(nv_batchyr,"9999") AND
              stat.pmuwd132.txt2      = nv_batchno             .
        FIND sic_bran.uwd132  USE-INDEX uwd13201 WHERE
             sic_bran.uwd132.policy  = sic_bran.uwm100.policy AND
             sic_bran.uwd132.rencnt  = sic_bran.uwm100.rencnt AND
             sic_bran.uwd132.endcnt  = sic_bran.uwm100.endcnt AND
             sic_bran.uwd132.riskgp  = sic_bran.uwm130.riskgp AND
             sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno AND
             sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno AND
             sic_bran.uwd132.bchyr   = nv_batchyr             AND
             sic_bran.uwd132.bchno   = nv_batchno             AND
             sic_bran.uwd132.bchcnt  = nv_batcnt              AND 
             sic_bran.uwd132.bencod  = stat.pmuwd132.bencod    NO-ERROR NO-WAIT.

            IF NOT AVAILABLE sic_bran.uwd132 THEN DO:
                CREATE sic_bran.uwd132.

               ASSIGN fi_process = "Create data to sic_bran.uwd132  ..." + wdetail.policy .
               DISP fi_process WITH FRAM fr_main. 
               ASSIGN
                  sic_bran.uwd132.bencod  =  stat.pmuwd132.bencod 
                  sic_bran.uwd132.benvar  =  stat.pmuwd132.benvar 
                  sic_bran.uwd132.rate    =  stat.pmuwd132.rate                     
                  sic_bran.uwd132.gap_ae  =  stat.pmuwd132.gap_ae                   
                  sic_bran.uwd132.gap_c   =  stat.pmuwd132.gap_c                    
                  sic_bran.uwd132.dl1_c   =  stat.pmuwd132.dl1_c                    
                  sic_bran.uwd132.dl2_c   =  stat.pmuwd132.dl2_c                    
                  sic_bran.uwd132.dl3_c   =  stat.pmuwd132.dl3_c                    
                  sic_bran.uwd132.pd_aep  =  stat.pmuwd132.pd_aep                   
                  sic_bran.uwd132.prem_c  =  stat.pmuwd132.prem_c                  
                  sic_bran.uwd132.fptr    =  0                   
                  sic_bran.uwd132.bptr    =  nv_bptr                   
                  sic_bran.uwd132.policy  =  sic_bran.uwm100.policy 
                  sic_bran.uwd132.rencnt  =  sic_bran.uwm100.rencnt                    
                  sic_bran.uwd132.endcnt  =  sic_bran.uwm100.endcnt                    
                  sic_bran.uwd132.riskgp  =  sic_bran.uwm130.riskgp                 
                  sic_bran.uwd132.riskno  =  sic_bran.uwm130.riskno                 
                  sic_bran.uwd132.itemno  =  sic_bran.uwm130.itemno                 
                  sic_bran.uwd132.rateae  =  stat.pmuwd132.rateae                  
                  sic_bran.uwd132.bchyr   =  nv_batchyr                   
                  sic_bran.uwd132.bchno   =  nv_batchno 
                  sic_bran.uwd132.bchcnt  =  nv_batcnt.

                  nv_gapprm = nv_gapprm + stat.pmuwd132.gap_c .
                  nv_pdprm  = nv_pdprm  + stat.pmuwd132.prem_C.
              
               
               IF SUBSTR(sic_bran.uwd132.bencod,1,3) = "GRP" AND wdetail.cargrp <> "" THEN DO:
                   ASSIGN   sic_bran.uwd132.bencod = nv_grpcod
                            sic_bran.uwd132.benvar = nv_grpvar .
               END.
               IF sic_bran.uwd132.bencod = "NCB" THEN ASSIGN nv_ncbper   = DECI(SUBSTRING(sic_bran.uwd132.benvar,31,30)). 

               IF nv_bptr <> 0 THEN DO:
                   FIND wf_uwd132 WHERE RECID(wf_uwd132) = nv_bptr.
                       wf_uwd132.fptr = RECID(sic_bran.uwd132).
               END.
               IF nv_bptr = 0 THEN sic_bran.uwm130.fptr03  =  RECID(sic_bran.uwd132).
               nv_bptr = RECID(sic_bran.uwd132).

            END. /* end uwd132*/
            /* add : A64-0138*/
            If nv_ncbper  <> 0 Then do:
               Find LAST sicsyac.xmm104 Use-index xmm10401 Where
                   sicsyac.xmm104.tariff = nv_tariff           AND
                   sicsyac.xmm104.class  = nv_class            AND 
                   sicsyac.xmm104.covcod = nv_covcod           AND 
                   sicsyac.xmm104.ncbper   = INTE(nv_ncbper) No-lock no-error no-wait.
               IF not avail  sicsyac.xmm104  Then do:
                   Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
                   ASSIGN wdetail.pass    = "N"
                          wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
               END.
               ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                           nv_ncbyrs = xmm104.ncbyrs.
            END.
            Else do:  
               ASSIGN nv_ncbyrs    =   0
                      nv_ncbper    =   0
                      nv_ncb       =   0.
            END.
            ASSIGN   
                sic_bran.uwm301.ncbper   = nv_ncbper
                sic_bran.uwm301.ncbyrs   = nv_ncbyrs .
            
           /* DELETE stat.pmuwd132 .*/  /* end A64-0138 */
    END. /* end pmuwd132 */
    sic_bran.uwm130.bptr03  =  nv_bptr. 
    RELEASE stat.pmuwd132.
    RELEASE sic_bran.uwd132.
    RELEASE sic_bran.uwm100.
    RELEASE sic_bran.uwm130.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign c-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    For each  wdetail :
        DELETE  wdetail.
    END.
    FOR EACH  wtextaccf6. 
        DELETE wtextaccf6.   
    END.
    FOR EACH  wtextf7.     
        DELETE wtextf7.      
    END.
    FOR EACH  wtextf5.    
        DELETE wtextf5.   
    END.
    FOR EACH wuwd132.
        DELETE wuwd132.
    END.
    RUN proc_assinginit.
    INPUT FROM VALUE(fi_FileName).
    loop_imp:
    REPEAT:
        IMPORT DELIMITER "|" 
            nv_number          /*  ลำดับที่     */
            nv_senddate       /* วันที่แจ้ง     */
            /*nv_policy  */        /* เลขรับแจ้งงาน */  /*A61-0386*/
            nv_cedpol           /* เลขรับแจ้งงาน */     /*A61-0386*/
            /*nv_prepol70         /* เลขกรมเดิม */  */       /*A61-0386*//*A64-0150*/
            nv_comname         /*  รหัสบรษัท    */
            nv_sendby          /*  ชื่อผู้แจ้ง  */
            nv_brname          /*  สาขา */
            nv_cover           /*  ประเภทความคุ้มครอง */
            nv_covertypecar    /*  ประเภทรถ        */
            nv_covercar        /*  ประเภทประกัน */
            nv_coverfree       /*  ประกัน แถม/ไม่แถม  */
            nv_compfree        /*  พรบ.   แถม/ไม่แถม  */
            nv_comdat70        /*  วันเริ่มคุ้มครอง   */
            nv_expdat70        /*  วันสิ้นสุดความคุ้มครอง       */
            nv_title           /*  คำนำหน้าชื่อ */
            nv_name1           /*  ชื่อผู้เอาประกัน     */
            nv_icno            /*  เลขที่บัตรประชาชน    */
            nv_datbirth        /*  วันเกิด      */
            nv_datbirthexp     /*  วันที่บัตรหมดอายุ    */
            nv_occup           /*  อาชีพ        */
            nv_name2           /*  ชื่อกรรมการ  */
            nv_addr1           /*  บ้านเลขที่   */
            nv_addr2           /*  ตำบล/แขวง    */
            nv_addr3           /*  อำเภอ/เขต    */
            nv_addr4           /*  จังหวัด      */
            nv_post            /*  รหัสไปรษณีย์ */
            nv_phone           /*  เบอร์โทรศัพท์        */
            nv_driverno        /*  ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่       */
            nv_driname1        /*  ผู้ขับขี่คนที่1      */
            nv_driname1gen     /*  เพศ  */
            nv_driname1birth   /*  วันเกิด      */
            nv_driname1occup   /*  อาชัพ        */
            nv_driname1number  /*  เลขที่ใบขับขี่       */
            nv_driname2        /*  ผู้ขับขี่คนที่2      */
            nv_driname2gen     /*  เพศ  */
            nv_driname2birth   /*  วันเกิด      */
            nv_driname2occup   /*  อาชัพ        */
            nv_driname2number  /*  เลขที่ใบขับขี่       */
            nv_nbrand          /*  ชื่อยี่ห้อรถ */
            nv_nmodel          /*  รุ่นรถ       */
            nv_nengno          /*  เลขเครื่องยนต์       */
            nv_nchassis        /*  เลขตัวถัง    */
            nv_nengcc          /*  ซีซี */
            nv_ncaryear        /*  ปีรถยนต์     */
            nv_nvehreg         /*  เลขทะเบียน   */
            nv_nvehreg2        /*  จังหวัดที่จดทะเบียน  */
            nv_garage          /*  การซ่อม      */
            nv_SUMINSURED      /*  ทุนประกัน    */
            nv_npremt          /*  เบี้ยสุทธิ   */
            nv_npremtnet       /*  เบี้ยประกัน  */
            nv_npremtcomp      /*  เบี้ยพรบ.    */
            nv_npremtotle      /*  เบี้ยรวม พรบ.        */
            nv_stkno           /*  เลขสติ๊กเกอร์        */
            nv_vatname         /*  ออกใบเสร็จในนาม      */
            nv_bennam          /*  ผู้รับผลประโยชน์     */
            nv_remak           /*  หมายเหตุ             */
            /*nv_prepol70 */   /*A61-0386*/
            nv_ispno           
            nv_ckclass         /*a61-0386*/
            nv_producer        /*A61-0386 */
            nv_agent           /*A61-0386 */
            nv_result    .      /*A62-445  */
            

        /* add A62-0445 */
        IF INDEX(nv_number,"Remark") <> 0  THEN DO: 
            MESSAGE "File Load ไม่ถูกต้อง " VIEW-AS ALERT-BOX.
            LEAVE loop_imp .
        END.
        /* end A62-0445 */
        IF  (INDEX(nv_number,"ที่")         <> 0 ) OR (INDEX(nv_number,"ลำดับที่") <> 0 ) OR  
            (INDEX(nv_number,"No")          <> 0 ) OR (INDEX(nv_number,"แบบ")      <> 0 ) OR 
            (INDEX(nv_number,"เรียน")       <> 0 ) OR (INDEX(nv_number,"ดีลเลอร์") <> 0 ) OR
            (INDEX(nv_number,"ชื่อผู้แจ้ง") <> 0 ) OR (TRIM(nv_number)   = "" )  OR
            (INDEX(nv_number,"ลำดับที่")    <> 0 )     THEN RUN proc_assinginit. 
        ELSE DO:
            /*RUN proc_cutcharpol.*/
            IF trim(nv_nchassis) <> ""  THEN DO:
                IF LENGTH(nv_nchassis) < 8  THEN 
                    ASSIGN nv_policy =  "0AMA" + trim(nv_nchassis).
                ELSE 
                    ASSIGN nv_policy =  "0AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) .
            END.
            IF trim(nv_policy)  <> "" THEN RUN proc_assign70.
            RUN proc_assinginit. 
        END.
    END.       /* repeat   */
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2addr c-Win 
PROCEDURE proc_assign2addr :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER  np_tambon        as char init "".
DEFINE INPUT  PARAMETER  np_mail_amper    as char init "".
DEFINE INPUT  PARAMETER  np_mail_country  as char init "".
DEFINE INPUT  PARAMETER  np_occupation    as char init "".
DEFINE OUTPUT PARAMETER  np_codeocc       as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr1     as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr2     as char init "".
DEFINE OUTPUT PARAMETER  np_codeaddr3     as char init "".
DEFINE VAR nv_address AS CHAR INIT  "".

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country)  
       nv_postcd  = "".

IF      R-INDEX(nv_address,"จ.")       <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จ.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จ.")       - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด.") <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด.")   + 8 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด.") - 1 )). 
ELSE IF R-INDEX(nv_address,"จังหวัด")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"จังหวัด")    + 7 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"จังหวัด")  - 1 )). 
ELSE IF R-INDEX(nv_address,"กรุงเทพ")  <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"กรุงเทพ"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"กรุงเทพ")  - 1 )).
ELSE IF R-INDEX(nv_address,"กทม")      <> 0 THEN ASSIGN np_mail_country = trim(SUBSTR(nv_address,R-INDEX(nv_address,"กทม"))) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"กทม")  - 1 )).

IF index(np_mail_country," ") <> 0  THEN 
    ASSIGN 
    nv_postcd       = trim(SUBSTR(np_mail_country,index(np_mail_country," "))) 
    np_mail_country = trim(SUBSTR(np_mail_country,1,index(np_mail_country," ") - 1 )) .
IF      index(np_mail_country,"กรุงเทพ") <> 0  THEN np_mail_country = "กรุงเทพมหานคร".
ELSE IF index(np_mail_country,"กทม")     <> 0  THEN np_mail_country = "กรุงเทพมหานคร".

IF      R-INDEX(nv_address,"อำเภอ.")   <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อำเภอ.")     + 6 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อำเภอ.")   - 1 )). 
ELSE IF R-INDEX(nv_address,"อำเภอ")    <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อำเภอ")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อำเภอ")    - 1 )).
ELSE IF R-INDEX(nv_address,"อ.")       <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"อ.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"อ.")       - 1 )).
ELSE IF R-INDEX(nv_address,"เขต.")     <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"เขต.")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"เขต.")     - 1 )).
ELSE IF R-INDEX(nv_address,"เขต")      <> 0 THEN ASSIGN np_mail_amper   = trim(SUBSTR(nv_address,R-INDEX(nv_address,"เขต")        + 3 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"เขต")      - 1 )). 

IF      R-INDEX(nv_address,"ต.")       <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ต.")         + 2 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ต.")       - 1 )).
ELSE IF R-INDEX(nv_address,"ตำบล.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ตำบล.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ตำบล.")    - 1 )).
ELSE IF R-INDEX(nv_address,"ตำบล")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"ตำบล")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"ตำบล")     - 1 )).

ELSE IF R-INDEX(nv_address,"แขวง.")    <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"แขวง.")      + 5 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"แขวง.")    - 1 )). 
ELSE IF R-INDEX(nv_address,"แขวง")     <> 0 THEN ASSIGN np_tambon       = trim(SUBSTR(nv_address,R-INDEX(nv_address,"แขวง")       + 4 )) 
                                                        nv_address      = trim(SUBSTR(nv_address,1,R-INDEX(nv_address,"แขวง")     - 1 )). 

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    (sicuw.uwm500.prov_d = np_mail_country OR 
    INDEX(sicuw.uwm500.prov_d,np_mail_country) <> 0 ) /*A64-0150*/
    NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
     ASSIGN np_codeaddr1 =  sicuw.uwm500.prov_n .   /*= uwm100.codeaddr1 */ /*A64-0150*/
     
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0  NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:
         ASSIGN np_codeaddr2 =  sicuw.uwm501.dist_n .  /*= uwm100.codeaddr2 */ /*A64-0150*/

        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
            sicuw.uwm506.prov_n   = sicuw.uwm501.prov_n and
            sicuw.uwm506.dist_n   = sicuw.uwm501.dist_n and
            (sicuw.uwm506.sdist_d  = np_tambon           OR 
            INDEX(sicuw.uwm506.sdist_d,np_tambon) <> 0   ) /*A64-0150*/
            NO-LOCK NO-ERROR NO-WAIT. /*"รางหวาย"*/
        IF AVAIL sicuw.uwm506 THEN  
            ASSIGN 
            /* np_codeaddr1 =  sicuw.uwm506.prov_n   /*= uwm100.codeaddr1 */ */ /*A64-0150*/
            /* np_codeaddr2 =  sicuw.uwm506.dist_n   /*= uwm100.codeaddr2 */ */ /*A64-0150*/
            np_codeaddr3 =  sicuw.uwm506.sdist_n   /*= uwm100.codeaddr3 */
            .  
    END.
END. 
/*occup */
IF np_occupation = "" THEN np_codeocc  = "9999".
ELSE DO:
    FIND FIRST stat.occupdet WHERE 
        stat.occupdet.desocct = np_occupation   /*Thai*/
        NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.occupdet THEN DO:
        ASSIGN np_codeocc = stat.occupdet.codeocc .
    END.
    ELSE DO:
        FIND FIRST stat.occupdet WHERE 
            stat.occupdet.desocce = np_occupation   /*Eng*/
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL stat.occupdet THEN DO:
            ASSIGN np_codeocc = stat.occupdet.codeocc .
        END.
        ELSE np_codeocc  = "9999".
    END.
END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign70 c-Win 
PROCEDURE proc_assign70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_name01 AS CHAR INIT "".  /*A59-0163*/
DEF VAR nv_name02 AS CHAR INIT "".  /*A59-0163*/
DEF VAR nv_nvehreg1 AS CHAR INIT "" FORMAT "x(30)". /*A59-0163*/  
/*DEF VAR nv_nvehreg2 AS CHAR INIT "" FORMAT "x(30)". *//*A59-0163*/  /*A62-0445*/

ASSIGN 
    nv_name01  = ""  /*A59-0163*/
    nv_name02  = ""  /*A59-0163*/
    nv_ckcover = ""
    nv_chkbase = 0
    nv_chkNCB  = 0
    nv_egcc    = 0
    nv_egcc    = IF ROUND(DECI(nv_nengcc) / 100 , 2 ) - Truncate(DECI(nv_nengcc) / 100 , 0 ) > 0 
                 THEN (Truncate(DECI(nv_nengcc) / 100 , 0 ) + 1 ) * 100  
                 ELSE Truncate(DECI(nv_nengcc) / 100  , 0 ) * 100 
    nv_ckcover = ""
    nv_branch  = ""                /*A61-0386*/
    nv_branch  = trim(nv_brname)  /*A61-0386*/
    nv_insnamtyp = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    nv_firstName = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    nv_lastName  = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/                                                                       
    nv_postcd    = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
    nv_codeocc   = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/        
    nv_codeaddr1 = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/         
    nv_codeaddr2 = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/         
    nv_codeaddr3 = ""  /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
    nv_chkerr    = "" . /*Ranu : A64-0150 */
                 
RUN proc_matcomdat.                                                             
RUN proc_mataddress.  
/*A59-0163*/
IF INDEX(trim(nv_name1)," ") <> 0 THEN DO:
    ASSIGN 
    nv_name01  = trim(SUBSTR(trim(nv_name1),1,INDEX(trim(nv_name1)," ")))
    nv_name02  = trim(SUBSTR(trim(nv_name1),INDEX(trim(nv_name1)," ")))
    nv_name1   = trim(nv_name01 + " " + nv_name02).
END.

/*IF R-INDEX(nv_nvehreg," ") <> 0  THEN DO: */ /*A62-0445*/
IF R-INDEX(nv_nvehreg," ") <> 0  AND nv_nvehreg2 = " " THEN DO:  /*A62-0445*/
    ASSIGN 
        nv_nvehreg1 =  trim(SUBSTR(nv_nvehreg,R-INDEX(nv_nvehreg," ")))
        nv_nvehreg2 =  trim(SUBSTR(nv_nvehreg,1,R-INDEX(nv_nvehreg," "))).
    FIND FIRST brstat.insure USE-INDEX Insure03   WHERE   /*use-index fname */
        brstat.insure.compno = "999"    AND 
        Insure.fName         = trim(nv_nvehreg1) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN nv_nvehreg = nv_nvehreg2 + " " + trim(Insure.LName) .
    END.
END.
/* add A62-0445*/
ELSE DO:
    FIND FIRST brstat.insure USE-INDEX Insure03   WHERE   /*use-index fname */
        brstat.insure.compno = "999"    AND 
        Insure.fName         = trim(nv_nvehreg2) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN nv_nvehreg = nv_nvehreg + " " + trim(Insure.LName) .
    END.
END.
/* end A62-0445*/

IF nv_ckclass = "" THEN DO:
    IF      index(TRIM(nv_covercar),"เก๋ง")  <> 0 THEN   nv_ckclass = "110".
    ELSE IF index(TRIM(nv_covercar),"กระบะ") <> 0 THEN   nv_ckclass = "320".
    ELSE IF index(TRIM(nv_covercar),"ตู้")   <> 0 THEN   nv_ckclass = "210".
    /* add A62-0445*/
    ELSE IF index(TRIM(nv_covercar),"1") <> 0 THEN   nv_ckclass = "110".
    ELSE IF index(TRIM(nv_covercar),"3") <> 0 THEN   nv_ckclass = "320".
    ELSE IF index(TRIM(nv_covercar),"2") <> 0 THEN   nv_ckclass = "210".
    /* end A62-0445*/
    ELSE nv_ckclass = "110".
END.

IF             TRIM(nv_cover) = "ประเภท1"   THEN nv_ckcover = "1" . 
ELSE IF        TRIM(nv_cover) = "ประเภท 1"  THEN nv_ckcover = "1" . 
ELSE IF        TRIM(nv_cover) = "ประเภท 3"  THEN nv_ckcover = "3" . 
ELSE IF        TRIM(nv_cover) = "ประเภท3"   THEN nv_ckcover = "3" . 
ELSE IF        TRIM(nv_cover) = "ประเภท 2"  THEN nv_ckcover = "2" . 
ELSE IF        TRIM(nv_cover) = "ประเภท2"   THEN nv_ckcover = "2" .
/*ELSE IF        TRIM(nv_cover) = "ประเภท 2+" THEN nv_ckcover = "2.1" . */ /*A64-0150*/
/*ELSE IF        TRIM(nv_cover) = "ประเภท2+"  THEN nv_ckcover = "2.1" . */ /*A64-0150*/
ELSE IF        TRIM(nv_cover) = "ประเภท 2+" THEN nv_ckcover = "2.2" .  /*A64-0150*/
ELSE IF        TRIM(nv_cover) = "ประเภท2+"  THEN nv_ckcover = "2.2" .  /*A64-0150*/
ELSE IF        TRIM(nv_cover) = "2.1"       THEN nv_ckcover = "2.1" . 
ELSE IF        TRIM(nv_cover) = "2.2"       THEN nv_ckcover = "2.2" .
ELSE IF        TRIM(nv_cover) = "3.1"       THEN nv_ckcover = "3.1" . 
ELSE IF        TRIM(nv_cover) = "3.2"       THEN nv_ckcover = "3.2" .
ELSE nv_ckcover = "" .

IF nv_ckcover = "1" OR nv_ckcover = "2" THEN DO:
    IF      index(nv_ckclass,"110") <> 0  THEN ASSIGN nv_chkbase =  7600  nv_chkNCB = 20.
    ELSE IF index(nv_ckclass,"210") <> 0  THEN ASSIGN nv_chkbase = 12000  nv_chkNCB = 20.
    ELSE IF index(nv_ckclass,"320") <> 0  THEN ASSIGN nv_chkbase = 13000  nv_chkNCB = 20.
END.
ELSE IF nv_ckcover = "3" THEN DO:
    IF      index(nv_ckclass,"110") <> 0  THEN ASSIGN nv_chkbase =  2200  nv_chkNCB = 20.
    ELSE IF index(nv_ckclass,"210") <> 0  THEN ASSIGN nv_chkbase =  3000  nv_chkNCB = 20.
    ELSE IF index(nv_ckclass,"320") <> 0  THEN ASSIGN nv_chkbase =  3500  nv_chkNCB = 20.
END.
FIND FIRST brstat.msgcode WHERE 
    brstat.msgcode.compno  = "999" AND
    brstat.msgcode.MsgDesc = trim(nv_title)   NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.msgcode THEN  
    ASSIGN  nv_title  =   trim(brstat.msgcode.branch).

FIND FIRST stat.insure USE-INDEX insure01 WHERE 
    stat.insure.compno = "AMNH" AND
    stat.insure.lname  = TRIM(nv_brname)  NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL stat.insure THEN  
    ASSIGN nv_brname = trim(stat.insure.branch) .
ELSE  ASSIGN nv_brname = "". 

IF nv_prepol70 <> ""  THEN RUN proc_cutrenpol.

FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(nv_policy)       /*  22   เลขกรมธรรม์ ป.1    */                                                   
        wdetail.poltyp      = "V70" 
        wdetail.prepol      = trim(nv_prepol70)
        wdetail.n_branch    = TRIM(nv_brname) 
        wdetail.covcod      = TRIM(nv_ckcover)
        wdetail.fristdat    = trim(nv_comdat70)
        wdetail.comdat      = trim(nv_comdat70)                
        wdetail.expdat      = trim(nv_expdat70) 
        wdetail.tiname      = IF trim(nv_title) = "" THEN  "คุณ"  ELSE trim(nv_title)                        
        wdetail.insnam      = TRIM(nv_name1) 
        wdetail.nv_icno     = TRIM(nv_icno) 
        wdetail.occup       = TRIM(nv_occup)
        wdetail.datbirth    = TRIM(nv_datbirth)             
        wdetail.datbirthexp = TRIM(nv_datbirthexp) 
        wdetail.phone       = TRIM(nv_phone)
        wdetail.inserf      = ""   
        wdetail.name2       = TRIM(nv_name2)
        wdetail.n_addr1     = TRIM(nv_addr1)                            
        wdetail.n_addr2     = TRIM(nv_addr2)                         
        wdetail.n_addr3     = TRIM(nv_addr3)                         
        /*wdetail.n_addr4     = trim(TRIM(nv_addr4) + " " + trim(nv_post))*/ /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/     
        wdetail.n_addr4     = TRIM(nv_addr4)                            /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/    
        wdetail.brand       = TRIM(nv_nbrand)        /*  9   ยี่ห้อ - รุ่น   */             
        wdetail.model       = TRIM(nv_nmodel)  
        wdetail.engno       = trim(nv_nengno)
        wdetail.chassis     = trim(nv_nchassis)
        wdetail.engcc       = STRING(nv_egcc)
        wdetail.caryear     = trim(nv_ncaryear) 
        wdetail.vehreg      = trim(nv_nvehreg)
        /*wdetail.garage      = IF TRIM(nv_garage) = "อู่" THEN "" ELSE "G"*/ /*A62-0445*/
        wdetail.garage      = IF TRIM(nv_garage) = "ห้าง" THEN "G" ELSE IF INDEX(nv_garage,"อะไหล่แท้") <> 0 THEN "P" ELSE "" /*A62-0445*/
        wdetail.si          = if index(nv_SUMINSURED,"ป") <> 0 then "0" else trim(nv_suminsured)      
        /*wdetail.fi          = if index(nv_SUMINSURED,"ป") <> 0 then "0" else trim(nv_suminsured) */ /*A62-0445*/
        wdetail.fi          = IF INDEX(nv_suminsured,"3+") <> 0 THEN "0" ELSE IF index(nv_SUMINSURED,"ป") <> 0 then "0" else trim(nv_suminsured)  /*A62-0445*/
        wdetail.benname     = trim(nv_bennam) 
        wdetail.vatcode     = ""
        wdetail.cedpol      = CAPS(TRIM(nv_cedpol))    /*A61-0386*/     
        wdetail.vehuse      = "1"   
        wdetail.CLASS       = TRIM(nv_ckclass)
        wdetail.seat        = IF      index(nv_ckclass,"110") <> 0 THEN "7" 
                              ELSE IF index(nv_ckclass,"210") <> 0 THEN "12"
                              ELSE IF index(nv_ckclass,"320") <> 0 THEN "3" 
                              ELSE "7" 
        wdetail.base        = STRING(nv_chkbase)
        wdetail.ncb        =  string(nv_chkNCB) 
        wdetail.commission  = fi_commision70 
        wdetail.prmtxt      = ""
        wdetail.producer    = trim(nv_producer)
        wdetail.agent       = trim(nv_agent)                    
        wdetail.n_rencnt    = 0                                 
        wdetail.n_endcnt    = 0                                         
        wdetail.drivnam     = IF trim(nv_driverno) = "ระบุผู้ขับขี่" THEN "Y" ELSE "N"        /*  ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่       */
        wdetail.drivnam1    = trim(nv_driname1)  /*  ผู้ขับขี่คนที่1      */
        wdetail.sexdriv1    = trim(nv_driname1gen)  /*  เพศ  */
        wdetail.bdatedri1   = trim(nv_driname1birth)  /*  วันเกิด      */
        wdetail.occupdri1   = trim(nv_driname1occup)  /*  อาชัพ        */
        wdetail.driveno1    = trim(nv_driname1number)  /*  เลขที่ใบขับขี่       */
        wdetail.drivnam2    = trim(nv_driname2)  /*ผู้ขับขี่คนที่2      */
        wdetail.sexdriv2    = trim(nv_driname2gen) /*  เพศ  */
        wdetail.bdatedri2   = trim(nv_driname2birth)  /*  วันเกิด      */
        wdetail.occupdri2   = trim(nv_driname2occup)  /*  อาชัพ        */
        wdetail.driveno2    = trim(nv_driname2number)  /*  เลขที่ใบขับขี่       */
        wdetail.tariff      = "X"
        wdetail.compul      = "n"
        wdetail.pass        = "Y"
        wdetail.n_import    = IF TRIM(nv_ispno) <> "" THEN "Y" ELSE ""  /*A62-0445*/
        wdetail.insnamtyp   = TRIM(nv_insnamtyp)   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.firstName   = trim(nv_firstName)   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.lastName    = trim(nv_lastName)    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.postcd      = trim(nv_post)        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeocc     = nv_codeocc           /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeaddr1   = nv_codeaddr1         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeaddr2   = nv_codeaddr2         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.codeaddr3   = nv_codeaddr3         /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.br_insured  = "00000"              /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/ 
        wdetail.premt       = nv_npremt .

    IF      INDEX(nv_sendby,"นาย")    <> 0 THEN ASSIGN wdetail.promoti = SUBSTR(nv_sendby,R-INDEX(nv_sendby,"นาย") + 3 ) .
    ELSE IF INDEX(nv_sendby,"นางสาว") <> 0 THEN ASSIGN wdetail.promoti = SUBSTR(nv_sendby,R-INDEX(nv_sendby,"นางสาว") + 6 ) .
    ELSE IF INDEX(nv_sendby,"นาง")    <> 0 THEN ASSIGN wdetail.promoti = SUBSTR(nv_sendby,R-INDEX(nv_sendby,"นาง") + 3 ) .
    ELSE IF INDEX(nv_sendby,"น.ส.")   <> 0 THEN ASSIGN wdetail.promoti = SUBSTR(nv_sendby,R-INDEX(nv_sendby,"น.ส.") + 4 ) .

    FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
        /*brstat.insure.compno   = "PACK_AMANAH" AND*/  /* A63-0169*/
        brstat.insure.compno   = TRIM(fi_pack)  AND     /* A63-0169*/
        brstat.insure.vatcode  = TRIM(wdetail.covcod) AND
        brstat.insure.text1    = TRIM(wdetail.garage) AND
        index(nv_ckclass,brstat.insure.text4) <> 0 NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN  DO:
        ASSIGN wdetail.uom1_v      = deci(brstat.insure.Lname)
               wdetail.uom2_v      = deci(brstat.insure.addr1)
               wdetail.uom5_v      = deci(brstat.insure.addr2)
               wdetail.nv_41       = deci(brstat.insure.addr3)
               wdetail.nv_42       = deci(brstat.insure.addr4)
               wdetail.nv_43       = deci(brstat.insure.telno)
               wdetail.CLASS       = IF wdetail.CLASS = "" THEN TRIM(brstat.insure.text3) + TRIM(brstat.insure.text4) ELSE wdetail.CLASS
               wdetail.campaign    = TRIM(brstat.insure.text2) .
    END.
    ELSE DO:
        ASSIGN 
            wdetail.uom1_v      = fi_tpbip                   
            wdetail.uom2_v      = fi_tpbiac                  
            wdetail.uom5_v      = fi_tppda 
            wdetail.nv_41       = fi_ap01                                       
            wdetail.nv_42       = fi_ap02                                              
            wdetail.nv_43       = fi_ap03 
            wdetail.campaign    = "" .
    END.
  
    FIND LAST wtextf7 WHERE wtextf7.n_policytx = trim(nv_policy)    NO-ERROR NO-WAIT.
    IF NOT AVAIL wtextf7  THEN DO:
        CREATE wtextf7.
        ASSIGN 
            wtextf7.n_policytxt =  trim(nv_policy) 
            wtextf7.nv_memof71  =  "วันที่แจ้งงาน : " + TRIM(nv_senddate) 
            wtextf7.nv_memof72  =  "เลขรับแจ้ง : "    + CAPS(TRIM(nv_cedpol)) 
            wtextf7.nv_memof73  =  "ผู้แจ้ง : " + TRIM(nv_sendby)
            wtextf7.nv_memof74  =  "สาขา : "    + TRIM(nv_branch) 
            wtextf7.nv_memof75  =  "ประเภท : "  + TRIM(nv_cover) 
            wtextf7.nv_memof76  =  "ประกัน : "  + TRIM(nv_coverfree) 
            wtextf7.nv_memof77  =  "พรบ. : "    + TRIM(nv_compfree)
            wtextf7.nv_memof78  =  "เลขกรมธรรม์เดิม : " + TRIM(nv_prepol70) 
            wtextf7.nv_memof79  =  "เลขตรวจสภาพรถ : " + TRIM(nv_ispno) 
            /* add by A62-0445*/
            wtextf7.nv_memof710 =  "ผลตรวจสภาพ : " + TRIM(nv_result) 
            wtextf7.nv_memof711 =  "เบอร์ลูกค้า : "   + TRIM(nv_phone) 
            wtextf7.nv_memof712 =  "หมายเหตุ อ้างอิง แคมเปญ/ เลข Q... " + TRIM(nv_remak) + " " + wdetail.campaign .
           /* end A62-0445 */
           /* comment by A62-0445...
            wtextf7.nv_memof710 =  "เบอร์ลูกค้า : "   + TRIM(nv_phone) 
            wtextf7.nv_memof711 =  "หมายเหตุ อ้างอิง แคมเปญ/ เลข Q... " + TRIM(nv_remak) + " " + wdetail.campaign .
            wtextf7.nv_memof712 =  "" */ .
    END.    
    
END.

IF (INDEX(TRIM(nv_npremtcomp),"ไม่เอาพรบ") = 0 ) AND (TRIM(nv_npremtcomp) <> "0" ) THEN DO: 
   IF trim(nv_nchassis) <> ""  THEN DO:
        IF LENGTH(nv_nchassis) < 8  THEN 
            ASSIGN wdetail.cr_2 =  "1AMA" + trim(nv_nchassis).
        ELSE 
            ASSIGN wdetail.cr_2 =  "1AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) .
    END.
    RUN proc_assign72.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign70-bp c-Win 
PROCEDURE proc_assign70-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/*
DEF VAR nv_ckclass AS CHAR INIT "".  /* match class */
DEF VAR nv_ckcover AS CHAR INIT "".  /* match cover 1 2 3 2+ 3+ compulsary */
DEF VAR nv_chkbase AS DECI INIT 0.
DEF VAR nv_chkNCB  AS DECI INIT 0.
DEF VAR nv_egcc AS DECI INIT 0.
*/
DEF VAR nv_name01 AS CHAR INIT "".  /*A59-0163*/
DEF VAR nv_name02 AS CHAR INIT "".  /*A59-0163*/
DEF VAR nv_nvehreg1 AS CHAR INIT "" FORMAT "x(30)". /*A59-0163*/  
DEF VAR nv_nvehreg2 AS CHAR INIT "" FORMAT "x(30)". /*A59-0163*/  


ASSIGN 
    nv_name01  = ""  /*A59-0163*/
    nv_name02  = ""  /*A59-0163*/
    nv_ckclass = ""
    nv_ckcover = ""
    nv_chkbase = 0
    nv_chkNCB  = 0
    nv_egcc    = 0
    nv_egcc    = IF ROUND(DECI(nv_nengcc) / 100 , 2 ) - Truncate(DECI(nv_nengcc) / 100 , 0 ) > 0 
                 THEN (Truncate(DECI(nv_nengcc) / 100 , 0 ) + 1 ) * 100  
                 ELSE Truncate(DECI(nv_nengcc) / 100  , 0 ) * 100 
    nv_ckclass = ""
    nv_ckcover = "".
RUN proc_matcomdat.
RUN proc_mataddress.
/*A59-0163*/
IF INDEX(trim(nv_name1)," ") <> 0 THEN DO:
    ASSIGN 
    nv_name01  = trim(SUBSTR(trim(nv_name1),1,INDEX(trim(nv_name1)," ")))
    nv_name02  = trim(SUBSTR(trim(nv_name1),INDEX(trim(nv_name1)," ")))
    nv_name1   = trim(nv_name01 + " " + nv_name02).
END.
IF R-INDEX(nv_nvehreg," ") <> 0 THEN DO: 
    ASSIGN 
        nv_nvehreg1 =  trim(SUBSTR(nv_nvehreg,R-INDEX(nv_nvehreg," ")))
        nv_nvehreg2 =  trim(SUBSTR(nv_nvehreg,1,R-INDEX(nv_nvehreg," "))).
    FIND FIRST brstat.insure USE-INDEX Insure03   WHERE   /*use-index fname */
        brstat.insure.compno = "999"    AND 
        Insure.fName         = trim(nv_nvehreg1) NO-LOCK NO-WAIT NO-ERROR.
    IF AVAIL brstat.insure THEN DO:
        ASSIGN nv_nvehreg = nv_nvehreg2 + " " + trim(Insure.LName) .
    END.
END.
/*A59-0163*/
IF      index(TRIM(nv_covercar),"เก๋ง")  <> 0 THEN   nv_ckclass = "110".
ELSE IF index(TRIM(nv_covercar),"กระบะ") <> 0 THEN   nv_ckclass = "320".
ELSE IF index(TRIM(nv_covercar),"ตู้")   <> 0 THEN   nv_ckclass = "210".
ELSE nv_ckclass = "110".
/*IF      substr(TRIM(nv_policy),3,2) <> "70" THEN nv_ckcover = "T" .  /* compulsary */*/
IF             TRIM(nv_cover) = "ประเภท1"   THEN nv_ckcover = "1" . 
ELSE IF        TRIM(nv_cover) = "ประเภท 1"  THEN nv_ckcover = "1" . 
ELSE IF        TRIM(nv_cover) = "ประเภท 3"  THEN nv_ckcover = "3" . 
ELSE IF        TRIM(nv_cover) = "ประเภท3"   THEN nv_ckcover = "3" . 
ELSE IF        TRIM(nv_cover) = "ประเภท 2"  THEN nv_ckcover = "2" . 
ELSE IF        TRIM(nv_cover) = "ประเภท2"   THEN nv_ckcover = "2" .
ELSE IF        TRIM(nv_cover) = "ประเภท 2+" THEN nv_ckcover = "2.1" . 
ELSE IF        TRIM(nv_cover) = "ประเภท2+"  THEN nv_ckcover = "2.1" .
ELSE IF        TRIM(nv_cover) = "2.1"       THEN nv_ckcover = "2.1" . 
ELSE IF        TRIM(nv_cover) = "2.2"       THEN nv_ckcover = "2.2" .
ELSE IF        TRIM(nv_cover) = "3.1"       THEN nv_ckcover = "3.1" . 
ELSE IF        TRIM(nv_cover) = "3.2"       THEN nv_ckcover = "3.2" .
ELSE nv_ckcover = "" .
IF nv_ckcover = "1" OR nv_ckcover = "2" THEN DO:
    IF      nv_ckclass = "110"  THEN ASSIGN nv_chkbase =  7600  nv_chkNCB = 20.
    ELSE IF nv_ckclass = "210"  THEN ASSIGN nv_chkbase = 12000  nv_chkNCB = 20.
    ELSE IF nv_ckclass = "320"  THEN ASSIGN nv_chkbase = 13000  nv_chkNCB = 20.
END.
ELSE IF nv_ckcover = "3" THEN DO:
    IF      nv_ckclass = "110"  THEN ASSIGN nv_chkbase =  2200  nv_chkNCB = 20.
    ELSE IF nv_ckclass = "210"  THEN ASSIGN nv_chkbase =  3000  nv_chkNCB = 20.
    ELSE IF nv_ckclass = "320"  THEN ASSIGN nv_chkbase =  3500  nv_chkNCB = 20.
END.
FIND FIRST brstat.msgcode WHERE 
    brstat.msgcode.compno  = "999" AND
    brstat.msgcode.MsgDesc = trim(nv_title)   NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL brstat.msgcode THEN  
    ASSIGN  nv_title  =   trim(brstat.msgcode.branch).

FIND FIRST stat.insure USE-INDEX insure01 WHERE 
    stat.insure.compno = "AMNH" AND
    stat.insure.lname  = TRIM(nv_brname)  NO-LOCK NO-WAIT NO-ERROR.
IF AVAIL stat.insure THEN  
    ASSIGN nv_brname = trim(stat.insure.branch) .
ELSE  ASSIGN nv_brname = "". 
IF nv_prepol70 <> ""  THEN RUN proc_cutrenpol.

FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(nv_policy)       /*  22   เลขกรมธรรม์ ป.1    */                                                   
        /*wdetail.cr_2        = trim(nv_policy72)       /*  23  เลขกรมธรรม์ พรบ.    */    */                 
        /*wdetail.poltyp      = IF SUBSTR(trim(nv_policy),3,2) = "70" THEN "V70" ELSE "V" +   SUBSTR(trim(nv_policy),3,2)   */
        wdetail.poltyp      = "V70" 
        wdetail.prepol      = trim(nv_prepol70)
            
        wdetail.n_branch    = TRIM(nv_brname) 
        wdetail.covcod      = TRIM(nv_ckcover)
        wdetail.fristdat    = trim(nv_comdat70)
        wdetail.comdat      = trim(nv_comdat70)                
        wdetail.expdat      = trim(nv_expdat70) 
        wdetail.tiname      = IF trim(nv_title) = "" THEN  "คุณ"  ELSE trim(nv_title)                        
        wdetail.insnam      = TRIM(nv_name1) 
        wdetail.nv_icno     = TRIM(nv_icno)  

        wdetail.datbirth    = TRIM(nv_datbirth)             
        wdetail.datbirthexp = TRIM(nv_datbirthexp) 
        
        wdetail.inserf      = ""                      
       /* wdetail.promoti     = ""   */ /*A61-0386*/
        /*wdetail.dealerno    = ""*/
        wdetail.name2       = TRIM(nv_name2)   

        wdetail.n_addr1     = TRIM(nv_addr1)                            
        wdetail.n_addr2     = TRIM(nv_addr2)                         
        wdetail.n_addr3     = TRIM(nv_addr3)                         
        wdetail.n_addr4     = trim(TRIM(nv_addr4) + " " + trim(nv_post))
        wdetail.brand       = TRIM(nv_nbrand)        /*  9   ยี่ห้อ - รุ่น   */             
        wdetail.model       = TRIM(nv_nmodel)  
        wdetail.engno       = trim(nv_nengno)
        wdetail.chassis     = trim(nv_nchassis)
        wdetail.engcc       = STRING(nv_egcc)
        wdetail.caryear     = trim(nv_ncaryear) 
        wdetail.vehreg      = trim(nv_nvehreg)
        wdetail.garage      = IF TRIM(nv_garage) = "อู่" THEN "" ELSE "G"
        wdetail.si          = trim(nv_SUMINSURED)      
        wdetail.fi          = trim(nv_SUMINSURED) 
        wdetail.benname     = trim(nv_bennam)   
            
        /*wdetail.vatcode     = IF TRIM(co_vatcode) = "" THEN "" ELSE trim(SUBSTR(TRIM(co_vatcode),1,10))               */
        wdetail.cedpol      = CAPS(TRIM(nv_cedpol))    /*A61-0386*/     
        wdetail.vehuse      = "1"    
        wdetail.class       = IF      TRIM(nv_ckcover) = "T"   THEN nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "1"   THEN fi_pack1 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2"   THEN fi_pack2 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3"   THEN fi_pack3 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2.1" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2.2" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3.1" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3.2" THEN fi_pack2plus + nv_ckclass
                              ELSE ""
        wdetail.seat        = IF      trim(nv_ckclass) = "110" THEN "7" 
                              ELSE IF trim(nv_ckclass) = "210" THEN "12"
                              ELSE IF trim(nv_ckclass) = "320" THEN "3" 
                              ELSE "7" 
        wdetail.uom1_v      = fi_tpbip                   
        wdetail.uom2_v      = fi_tpbiac                  
        wdetail.uom5_v      = fi_tppda 
        wdetail.nv_41       = fi_ap01                                       
        wdetail.nv_42       = fi_ap02                                              
        wdetail.nv_43       = fi_ap03  
        wdetail.base        = STRING(nv_chkbase)
        wdetail.ncb        =  string(nv_chkNCB) 
        wdetail.commission  = fi_commision70  
             
        wdetail.prmtxt      = ""
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)                    
        wdetail.n_rencnt    = 0                                 
        wdetail.n_endcnt    = 0                                         
        wdetail.drivnam     = "N"
        wdetail.tariff      = "X"
        wdetail.compul      = "n"
        wdetail.pass        = "Y".

    /*
    IF   (trim(nv_accessoryf61 ) <> "" ) OR
         (trim(nv_accessoryf62 ) <> "" ) OR
         (trim(nv_accessoryf63 ) <> "" ) OR
         (trim(nv_accessoryf64 ) <> "" ) OR
         (trim(nv_accessoryf65 ) <> "" ) THEN DO:
        FIND LAST wtextaccf6 WHERE wtextaccf6.n_policytxt = trim(nv_policy)   NO-ERROR NO-WAIT.
        IF NOT AVAIL wtextaccf6  THEN DO:
            CREATE wtextaccf6.
            ASSIGN           
                wtextaccf6.n_policytxt = trim(nv_policy)  
                wtextaccf6.n_textacc1  = trim(nv_accessoryf61)      /*  28  อุปกรณ์ตกแต่ง   */        
                wtextaccf6.n_textacc2  = trim(nv_accessoryf62)
                wtextaccf6.n_textacc3  = trim(nv_accessoryf63)
                wtextaccf6.n_textacc4  = trim(nv_accessoryf64)
                wtextaccf6.n_textacc5  = trim(nv_accessoryf65) .
        END.
    END.
    ELSE ASSIGN  
        nv_accessoryf61 = "" 
        nv_accessoryf62 = "" 
        nv_accessoryf63 = "" 
        nv_accessoryf64 = "" 
        nv_accessoryf65 = ""  .
    */

    /*IF  (TRIM(nv_memof71) <>  "" ) OR
        (TRIM(nv_memof72) <>  "" ) OR
        (TRIM(nv_memof73) <>  "" ) OR
        (TRIM(nv_memof74) <>  "" ) OR
        (TRIM(nv_memof75) <>  "" ) THEN DO:*/

    IF  TRIM(nv_sendby)   <> ""   OR 
        TRIM(nv_compfree) <> ""   OR 
        TRIM(nv_remak)    <> ""   OR 
        trim(nv_ispno)    <> ""   THEN DO:
        FIND LAST wtextf7 WHERE wtextf7.n_policytx = trim(nv_policy)    NO-ERROR NO-WAIT.
        IF NOT AVAIL wtextf7  THEN DO:
            CREATE wtextf7.
            ASSIGN 
                wtextf7.n_policytxt =  trim(nv_policy) 
                wtextf7.nv_memof71  =  "ผู้แจ้ง : "            + TRIM(nv_sendby)          
                wtextf7.nv_memof72  =  "พรบ.   แถม/ไม่แถม : "  + TRIM(nv_compfree)
                wtextf7.nv_memof73  =  "เลขตรวจสภาพรถ ISPXX/..: " + TRIM(nv_ispno)  
                wtextf7.nv_memof74  =  "หมายเหตุ อ้างอิง แคมเปญ/ เลข Q... " + TRIM(nv_remak)
                wtextf7.nv_memof75  =  "" .
        END.
    END.
    ELSE ASSIGN  
        nv_memof71  = ""  
        nv_memof72  = ""      
        nv_memof73  = ""     
        nv_memof74  = ""     
        nv_memof75  = ""  . 
    
    
END.
IF (INDEX(TRIM(nv_npremtcomp),"ไม่เอาพรบ") = 0 ) AND ( TRIM(nv_npremtcomp) <> "0" ) THEN DO:
    IF trim(nv_nchassis) <> ""  THEN DO:
        IF LENGTH(nv_nchassis) < 8  THEN 
            ASSIGN wdetail.cr_2 =  "1AMA" + trim(nv_nchassis).
        ELSE 
            ASSIGN wdetail.cr_2 =  "1AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) .
    END.
    RUN proc_assign72.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign72 c-Win 
PROCEDURE proc_assign72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    nv_ckclass  = ""
    nv_policy72 = ""  .
IF trim(nv_nchassis) <> ""  THEN DO:
    IF LENGTH(nv_nchassis) < 8  THEN 
        ASSIGN nv_policy72 =  "1AMA" + trim(nv_nchassis).
    ELSE 
        ASSIGN nv_policy72 =  "1AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) .
END.

IF deci(nv_npremtcomp) = 645.21 THEN nv_ckclass  = "110".
ELSE IF deci(nv_npremtcomp) = 967.28 THEN nv_ckclass  = "140A".
ELSE IF deci(nv_npremtcomp) = 1182.35 THEN nv_ckclass  = "120A".

FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy72)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(nv_policy72)                                                      
        wdetail.cr_2        = IF LENGTH(nv_nchassis) < 8  THEN "0AMA" + trim(nv_nchassis)
                              ELSE   "0AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) 
        wdetail.poltyp      = "V72" 
        wdetail.prepol      = ""
        wdetail.n_branch    =  TRIM(nv_brname) 
        wdetail.covcod      = "T"                   /*compulsary*/
        wdetail.fristdat    = trim(nv_comdat70)
        wdetail.comdat      = trim(nv_comdat70)                
        wdetail.expdat      = trim(nv_expdat70) 
        wdetail.tiname      = IF trim(nv_title) = "" THEN  "คุณ"  ELSE trim(nv_title)                        
        wdetail.insnam      = TRIM(nv_name1) 
        wdetail.nv_icno     = TRIM(nv_icno) 
        wdetail.occup       = TRIM(nv_occup)
        wdetail.datbirth    = TRIM(nv_datbirth)             
        wdetail.datbirthexp = TRIM(nv_datbirthexp) 
        wdetail.phone       = TRIM(nv_phone)
        wdetail.inserf      = ""                      
        wdetail.promoti     = ""    
        wdetail.name2       = TRIM(nv_name2)  
        wdetail.n_addr1     = TRIM(nv_addr1)                            
        wdetail.n_addr2     = TRIM(nv_addr2)                         
        wdetail.n_addr3     = TRIM(nv_addr3)                         
        wdetail.n_addr4     = trim(TRIM(nv_addr4) + " " + trim(nv_post))
        wdetail.brand       = TRIM(nv_nbrand)        /*  9   ยี่ห้อ - รุ่น   */             
        wdetail.model       = TRIM(nv_nmodel)  
        wdetail.engno       = trim(nv_nengno)
        wdetail.chassis     = trim(nv_nchassis)
        wdetail.engcc       = STRING(nv_egcc)
        wdetail.caryear     = trim(nv_ncaryear) 
        wdetail.vehreg      = trim(nv_nvehreg)
        wdetail.garage      = ""
        wdetail.si          = trim(nv_SUMINSURED)      
        wdetail.fi          = trim(nv_SUMINSURED) 
        wdetail.benname     = ""   
        wdetail.vehuse      = "1"            
        wdetail.class       = trim(nv_ckclass)
        wdetail.seat        = IF      index(nv_ckclass,"110") <> 0  THEN "7" 
                              ELSE IF index(nv_ckclass,"120") <> 0  THEN "12"
                              ELSE IF index(nv_ckclass,"140") <> 0  THEN "3" 
                              ELSE "7"  
        wdetail.commission  = fi_commision72  
        wdetail.prmtxt      = ""
        wdetail.producer    = if trim(nv_producer) <> "" then trim(nv_producer) ELSE TRIM(fi_producer)
        wdetail.agent       = if trim(nv_agent)    <> "" then trim(nv_agent)  ELSE TRIM(fi_agent)               
        wdetail.n_rencnt    = 0                                 
        wdetail.n_endcnt    = 0                                         
        wdetail.drivnam     = "N"
        wdetail.tariff      = "X"
        wdetail.compul      = "y"
        wdetail.pass        = "Y"
        wdetail.cedpol      = CAPS(TRIM(nv_cedpol))    /*A62-0445*/  .

    IF      INDEX(nv_sendby,"นาย")    <> 0  THEN ASSIGN wdetail.promoti = trim(SUBSTR(nv_sendby,R-INDEX(nv_sendby,"นาย") + 3 )) .
    ELSE IF INDEX(nv_sendby,"นางสาว") <> 0  THEN ASSIGN wdetail.promoti = trim(SUBSTR(nv_sendby,R-INDEX(nv_sendby,"นางสาว") + 6 )) .
    ELSE IF INDEX(nv_sendby,"นาง")    <> 0  THEN ASSIGN wdetail.promoti = trim(SUBSTR(nv_sendby,R-INDEX(nv_sendby,"นาง") + 3 )) .
    ELSE IF INDEX(nv_sendby,"น.ส.")   <> 0  THEN ASSIGN wdetail.promoti = trim(SUBSTR(nv_sendby,R-INDEX(nv_sendby,"น.ส.") + 4 )) .

    FIND LAST wtextf7 WHERE wtextf7.n_policytx = trim(nv_policy72)    NO-ERROR NO-WAIT.
    IF NOT AVAIL wtextf7  THEN DO:
        CREATE wtextf7.
        ASSIGN 
            wtextf7.n_policytxt =  trim(nv_policy72) 
            wtextf7.nv_memof71  =  "วันที่แจ้งงาน : " + TRIM(nv_senddate) 
            wtextf7.nv_memof72  =  "เลขรับแจ้ง : "    + CAPS(TRIM(nv_cedpol)) 
            wtextf7.nv_memof73  =  "ผู้แจ้ง : " + TRIM(nv_sendby)
            wtextf7.nv_memof74  =  "สาขา : "    + TRIM(nv_branch) 
            wtextf7.nv_memof75  =  "ประเภท : "  + TRIM(nv_cover) 
            wtextf7.nv_memof76  =  "ประกัน : "  + TRIM(nv_coverfree) 
            wtextf7.nv_memof77  =  "พรบ. : "    + TRIM(nv_compfree)
            wtextf7.nv_memof78  =  "เลขกรมธรรม์เดิม : " + TRIM(nv_prepol70) 
            wtextf7.nv_memof79  =  "เลขตรวจสภาพรถ : " + TRIM(nv_ispno) 
            /* add by A62-0445*/
            wtextf7.nv_memof710 =  "ผลตรวจสภาพ : " + TRIM(nv_result) 
            wtextf7.nv_memof711 =  "เบอร์ลูกค้า : "   + TRIM(nv_phone) 
            wtextf7.nv_memof712 =  "หมายเหตุ อ้างอิง แคมเปญ/ เลข Q... " + TRIM(nv_remak) + " " + wdetail.campaign .
            /* comment by A62-0445...
            wtextf7.nv_memof710 =  "เบอร์ลูกค้า : "   + TRIM(nv_phone) 
            wtextf7.nv_memof711 =  "หมายเหตุ อ้างอิง แคมเปญ/ เลข Q... " + TRIM(nv_remak) + " " + wdetail.campaign 
            wtextf7.nv_memof712 =  "" 
            end a62-0445...*/
    END.  

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign72-bp c-Win 
PROCEDURE proc_assign72-bp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*ASSIGN 
    nv_policy72 = ""  .
IF trim(nv_nchassis) <> ""  THEN DO:
    IF LENGTH(nv_nchassis) < 8  THEN 
        ASSIGN nv_policy72 =  "1AMA" + trim(nv_nchassis).
    ELSE 
        ASSIGN nv_policy72 =  "1AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) .
END.
FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy72)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(nv_policy72)                                                      
        wdetail.cr_2        = IF LENGTH(nv_nchassis) < 8  THEN "0AMA" + trim(nv_nchassis)
                              ELSE   "0AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) 
        wdetail.poltyp      = "V72" 
        wdetail.prepol      = ""
        wdetail.n_branch    =  TRIM(nv_brname) 
        wdetail.covcod      = "T"                   /*compulsary*/
        wdetail.fristdat    = trim(nv_comdat70)
        wdetail.comdat      = trim(nv_comdat70)                
        wdetail.expdat      = trim(nv_expdat70) 
        wdetail.tiname      = IF trim(nv_title) = "" THEN  "คุณ"  ELSE trim(nv_title)                        
        wdetail.insnam      = TRIM(nv_name1) 
        wdetail.nv_icno     = TRIM(nv_icno) 
        wdetail.datbirth    = TRIM(nv_datbirth)             
        wdetail.datbirthexp = TRIM(nv_datbirthexp) 
        
        wdetail.inserf      = ""                      
        wdetail.promoti     = ""    
        /*wdetail.dealerno    = ""*/
        wdetail.name2       = TRIM(nv_name2)  
        wdetail.n_addr1     = TRIM(nv_addr1)                            
        wdetail.n_addr2     = TRIM(nv_addr2)                         
        wdetail.n_addr3     = TRIM(nv_addr3)                         
        wdetail.n_addr4     = trim(TRIM(nv_addr4) + " " + trim(nv_post))
        wdetail.brand       = TRIM(nv_nbrand)        /*  9   ยี่ห้อ - รุ่น   */             
        wdetail.model       = TRIM(nv_nmodel)  
        wdetail.engno       = trim(nv_nengno)
        wdetail.chassis     = trim(nv_nchassis)
        wdetail.engcc       = STRING(nv_egcc)
        wdetail.caryear     = trim(nv_ncaryear) 
        wdetail.vehreg      = trim(nv_nvehreg)
        wdetail.garage      = ""
        wdetail.si          = trim(nv_SUMINSURED)      
        wdetail.fi          = trim(nv_SUMINSURED) 
        wdetail.benname     = ""   
        wdetail.vehuse      = "1"            
        wdetail.class       = IF      TRIM(nv_ckcover) = "1"   THEN fi_pack1 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2"   THEN fi_pack2 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3"   THEN fi_pack3 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2.1" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2.2" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3.1" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3.2" THEN fi_pack2plus + nv_ckclass
                              ELSE ""
        wdetail.seat        = IF      trim(nv_ckclass) = "110" THEN "7" 
                              ELSE IF trim(nv_ckclass) = "210" THEN "12"
                              ELSE IF trim(nv_ckclass) = "320" THEN "3" 
                              ELSE "7"  
        wdetail.uom1_v      = fi_tpbip                   
        wdetail.uom2_v      = fi_tpbiac                  
        wdetail.uom5_v      = fi_tppda 
        wdetail.nv_41       = fi_ap01                                       
        wdetail.nv_42       = fi_ap02                                              
        wdetail.nv_43       = fi_ap03                              
        wdetail.base        = "0"
        wdetail.ncb         = "0"
        wdetail.commission  = fi_commision72  
             
        wdetail.prmtxt      = ""
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)                    
        wdetail.n_rencnt    = 0                                 
        wdetail.n_endcnt    = 0                                         
        wdetail.drivnam     = "N"
        wdetail.tariff      = "X"
        wdetail.compul      = "y"
        wdetail.pass        = "Y".
END.*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignmatpol c-Win 
PROCEDURE proc_assignmatpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND FIRST wdetail2 WHERE wdetail2.wk_policy = trim(nv_policy)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail2 THEN DO:
    CREATE wdetail2.
    ASSIGN 
            wdetail2.wk_number         =   nv_number          /*  ลำดับที่     */
            wdetail2.wk_senddate       =   nv_senddate        /* วันที่แจ้ง     */
            wdetail2.wk_policy         =   nv_policy          /* เลขรับแจ้งงาน */
            wdetail2.wk_prepol70       =   nv_prepol70        /*A61-0386*/
            wdetail2.wk_comname        =   nv_comname         /*  รหัสบรษัท    */
            wdetail2.wk_sendby         =   nv_sendby          /*  ชื่อผู้แจ้ง  */
            wdetail2.wk_brname         =   nv_brname          /*  สาขา */
            wdetail2.wk_covercar       =   nv_covercar        /*  ประเภทประกัน */
            wdetail2.wk_covertypecar   =   nv_covertypecar    /*       ประเภทรถ        */
            wdetail2.wk_cover          =   nv_cover           /*       ประเภทความคุ้มครอง      */
            wdetail2.wk_coverfree      =   nv_coverfree       /*       ประกัน แถม/ไม่แถม       */
            wdetail2.wk_compfree       =   nv_compfree        /*       พรบ.   แถม/ไม่แถม       */
            wdetail2.wk_comdat70       =   nv_comdat70        /*       วันเริ่มคุ้มครอง        */
            wdetail2.wk_expdat70       =   nv_expdat70        /*  วันสิ้นสุดความคุ้มครอง       */
            wdetail2.wk_title          =   nv_title           /*  คำนำหน้าชื่อ */
            wdetail2.wk_name1          =   nv_name1           /*  ชื่อผู้เอาประกัน     */
            wdetail2.wk_icno           =   nv_icno            /*  เลขที่บัตรประชาชน    */
            wdetail2.wk_datbirth       =   nv_datbirth        /*  วันเกิด      */
            wdetail2.wk_datbirthexp    =   nv_datbirthexp     /*  วันที่บัตรหมดอายุ    */
            wdetail2.wk_occup          =   nv_occup           /*  อาชีพ        */
            wdetail2.wk_name2          =   nv_name2           /*  ชื่อกรรมการ  */
            wdetail2.wk_addr1          =   nv_addr1           /*  บ้านเลขที่   */
            wdetail2.wk_addr2          =   nv_addr2           /*  ตำบล/แขวง    */
            wdetail2.wk_addr3          =   nv_addr3           /*  อำเภอ/เขต    */
            wdetail2.wk_addr4          =   nv_addr4           /*  จังหวัด      */
            wdetail2.wk_post           =   nv_post            /*  รหัสไปรษณีย์ */
            wdetail2.wk_phone          =   nv_phone           /*  เบอร์โทรศัพท์        */
            wdetail2.wk_driverno       =   nv_driverno        /*  ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่       */
            wdetail2.wk_driname1       =   nv_driname1        /*  ผู้ขับขี่คนที่1      */
            wdetail2.wk_driname1gen    =   nv_driname1gen     /*  เพศ  */
            wdetail2.wk_driname1birth  =   nv_driname1birth   /*  วันเกิด      */
            wdetail2.wk_driname1occup  =   nv_driname1occup   /*  อาชัพ        */
            wdetail2.wk_driname1number =   nv_driname1number  /*  เลขที่ใบขับขี่       */
            wdetail2.wk_driname2       =   nv_driname2        /*  ผู้ขับขี่คนที่2      */
            wdetail2.wk_driname2gen    =   nv_driname2gen     /*  เพศ  */
            wdetail2.wk_driname2birth  =   nv_driname2birth   /*  วันเกิด      */
            wdetail2.wk_driname2occup  =   nv_driname2occup   /*  อาชัพ        */
            wdetail2.wk_driname2number =   nv_driname2number  /*  เลขที่ใบขับขี่       */
            wdetail2.wk_nbrand         =   nv_nbrand          /*  ชื่อยี่ห้อรถ */
            wdetail2.wk_nmodel         =   nv_nmodel          /*  รุ่นรถ       */
            wdetail2.wk_nengno         =   nv_nengno          /*  เลขเครื่องยนต์       */
            wdetail2.wk_nchassis       =   nv_nchassis        /*  เลขตัวถัง    */
            wdetail2.wk_nengcc         =   nv_nengcc          /*  ซีซี */
            wdetail2.wk_ncaryear       =   nv_ncaryear        /*  ปีรถยนต์     */
            wdetail2.wk_nvehreg        =   nv_nvehreg         /*  เลขทะเบียน   */
            wdetail2.wk_nvehreg2       =   nv_nvehreg2        /*  จังหวัดที่จดทะเบียน  */
            wdetail2.wk_garage         =   nv_garage          /*  การซ่อม      */
            wdetail2.wk_SUMINSURED     =   nv_SUMINSURED      /*  ทุนประกัน    */
            wdetail2.wk_npremt         =   nv_npremt          /*  เบี้ยสุทธิ   */
            wdetail2.wk_npremtnet      =   nv_npremtnet       /*  เบี้ยประกัน  */
            wdetail2.wk_npremtcomp     =   nv_npremtcomp      /*  เบี้ยพรบ.    */
            wdetail2.wk_npremtotle     =   nv_npremtotle      /*  เบี้ยรวม พรบ.        */
            wdetail2.wk_stkno          =   nv_stkno           /*  เลขสติ๊กเกอร์        */
            wdetail2.wk_vatname        =   nv_vatname         /*  ออกใบเสร็จในนาม      */
            wdetail2.wk_bennam         =   nv_bennam          /*  ผู้รับผลประโยชน์     */
            wdetail2.wk_remak          =   nv_remak           /*  หมายเหตุ             */
            /*wdetail2.wk_prepol70       =   nv_prepol70  */ /*A61-0386*/
            wdetail2.wk_ispno          =   nv_ispno  
            wdetail2.wk_class          =   nv_ckclass   /*a61-0386*/
            wdetail2.wk_producer       =   nv_producer  /*a61-0386*/
            wdetail2.wk_agent          =   nv_agent    /*a61-0386*/
            wdetail2.wk_result         =   nv_result . /*A62-0445*/
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew c-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR nseats AS INTE INIT 0.
DEF VAR nclas2 AS CHAR INIT "".
DEF VAR nbrold AS CHAR INIT "".
DEFINE VAR  nre_premt        AS DECI FORMAT ">>>,>>>,>>9.99". /*A64-0138*/

ASSIGN 
    nv_41         = 0
    nv_42         = 0
    nv_43         = 0
    dod1          = 0
    dod2          = 0
    nv_ded        = 0
    nv_flet_per   = 0
    nv_ncbper     = 0  
    nv_dss_per    = 0  
    nv_cl_per     = 0 
    nv_stf_per    = 0   .
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwtamex (INPUT-OUTPUT wdetail.prepol,   
                     INPUT-OUTPUT nbrold,            /*wdetail.n_branch,*//*A63-00472*/
                     INPUT-OUTPUT wdetail.producer,  
                     INPUT-OUTPUT wdetail.agent,    
                     INPUT-OUTPUT wdetail.fristdat , 
                     INPUT-OUTPUT wdetail.inserf,
                     INPUT-OUTPUT wdetail.tiname,
                     INPUT-OUTPUT wdetail.name2,
                     INPUT-OUTPUT wdetail.name3,
                     INPUT-OUTPUT wdetail.n_addr1,
                     INPUT-OUTPUT wdetail.n_addr2,
                     INPUT-OUTPUT wdetail.n_addr3,
                     INPUT-OUTPUT wdetail.n_addr4,
                     INPUT-OUTPUT wdetail.class,   
                     INPUT-OUTPUT wdetail.redbook,   
                     INPUT-OUTPUT wdetail.brand,   
                     INPUT-OUTPUT wdetail.model, 
                     INPUT-OUTPUT wdetail.caryear,   
                     INPUT-OUTPUT wdetail.cargrp,     
                     INPUT-OUTPUT wdetail.body, 
                     INPUT-OUTPUT wdetail.engcc,       
                     INPUT-OUTPUT wdetail.Tonn,   
                     INPUT-OUTPUT wdetail.seat,     
                     INPUT-OUTPUT wdetail.vehuse,   
                     INPUT-OUTPUT wdetail.covcod,   
                     INPUT-OUTPUT wdetail.garage, 
                     INPUT-OUTPUT wdetail.benname,
                     INPUT-OUTPUT wdetail.vehreg,   
                     INPUT-OUTPUT wdetail.uom1_v, 
                     INPUT-OUTPUT wdetail.uom2_v, 
                     INPUT-OUTPUT wdetail.uom5_v,
                     INPUT-OUTPUT wdetail.si,
                     INPUT-OUTPUT wdetail.fi,
                     INPUT-OUTPUT wdetail.base,
                     INPUT-OUTPUT nv_41,              
                     INPUT-OUTPUT nv_42,              
                     INPUT-OUTPUT nv_43,   
                     INPUT-OUTPUT wdetail.seat41,  
                     INPUT-OUTPUT dod1,              
                     INPUT-OUTPUT dod2,             
                     INPUT-OUTPUT nv_ded, 
                     INPUT-OUTPUT nv_flet_per,
                     INPUT-OUTPUT nv_ncbper,
                     INPUT-OUTPUT nv_dss_per, 
                     INPUT-OUTPUT nv_stf_per,
                     INPUT-OUTPUT nv_cl_per,
                     INPUT-OUTPUT nre_premt).   /*A64-0138*/ 

                       
END.    
ASSIGN 
    wdetail.premt  = string(nre_premt)
    wdetail.ncb    = string(nv_ncbper) 
    wdetail.fleet  = STRING(nv_flet_per) 
    wdetail.dspc   = string(nv_dss_per) .


/* A63-0168 */
 IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO:
      FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
        trim(brstat.Insure.compno)  = TRIM(fi_rwpack)  AND 
        trim(brstat.insure.vatcode) = TRIM(SUBSTR(wdetail.class,1,1))    NO-ERROR.
     IF AVAIL brstat.insure THEN ASSIGN wdetail.class = TRIM(brstat.insure.Text3) + TRIM(SUBSTR(wdetail.class,2,3)) .

  END.
/* end A63-0168*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assinginit c-Win 
PROCEDURE proc_assinginit :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
---------------------------------------------------------------------------*/

ASSIGN 
   nv_number          = ""
   nv_senddate        = ""
   nv_policy          = ""
   nv_comname         = ""
   nv_sendby          = ""
   nv_brname          = ""
   nv_covercar        = ""
   nv_covertypecar    = ""
   nv_cover           = ""
   nv_coverfree       = ""
   nv_compfree        = ""
   nv_comdat70        = "" 
   nv_expdat70        = "" 
   nv_title           = "" 
   nv_name1           = "" 
   nv_icno            = ""
   nv_datbirth        = ""
   nv_datbirthexp     = ""
   nv_occup           = ""
   nv_name2           = ""
   nv_addr1           = ""
   nv_addr2           = ""
   nv_addr3           = ""
   nv_addr4           = ""
   nv_post            = ""      
   nv_phone           = ""      
   nv_driverno        = ""      
   nv_driname1        = ""      
   nv_driname1gen     = ""      
   nv_driname1birth   = ""
   nv_driname1occup   = ""      
   nv_driname1number  = ""      
   nv_driname2        = ""      
   nv_driname2gen     = ""      
   nv_driname2birth   = ""      
   nv_driname2occup   = ""       
   nv_driname2number  = ""      
   nv_nbrand          = ""      
   nv_nmodel          = ""      
   nv_nengno          = ""      
   nv_nchassis        = ""      
   nv_nengcc          = ""      
   nv_ncaryear        = ""      
   nv_nvehreg         = ""      
   nv_nvehreg2        = ""      
   nv_garage          = ""      
   nv_SUMINSURED      = ""      
   nv_npremt          = ""      
   nv_npremtnet       = ""      
   nv_npremtcomp      = ""      
   nv_npremtotle      = ""      
   nv_stkno           = ""      
   nv_vatname         = "" 
   nv_bennam          = "" 
   nv_remak           = "" 
   nv_prepol70        = ""
   nv_ckclass         = ""   /*a61-0386*/
   nv_cedpol          = ""   /*A61-0386*/
   nv_producer        = ""   /*A61-0386 */
   nv_agent           = ""   /*A61-0386 */
   nv_result          = ""   /*A62-0445*/
   nv_campaign_ov     = ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
   nv_codeocc         = ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
   nv_codeaddr1       = ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
   nv_codeaddr2       = ""   /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
   nv_codeaddr3       = "" . /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 c-Win 
PROCEDURE proc_base2 :
/*------------------------------------------------------------------------------
  Purpose:                                                                      
  Parameters:  <none>                                                           
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN 
        fi_process = "Create data to base..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
    IF (wdetail.base = "") OR ( deci(wdetail.base) = 0 )  THEN RUN wgs\wgsfbas.
    ELSE  
        ASSIGN nv_baseprm = deci(wdetail.base) .

    IF nv_baseprm = 0  THEN DO:  
        RUN wgs\wgsfbas .
        /*FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
            sicsyac.xmm106.tariff =  nv_tariff  AND
            sicsyac.xmm106.bencod =  "base"     AND
            sicsyac.xmm106.covcod =  nv_covcod  AND
            sicsyac.xmm106.class  =  nv_class   AND
            sicsyac.xmm106.key_b  GE nv_key_b   AND
            sicsyac.xmm106.effdat LE nv_comdat
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm106 THEN DO:
            IF nv_drivcod = "A000" THEN
                MESSAGE "2" nv_baseprm  deci(wdetail.base) sicsyac.xmm106.max_ap VIEW-AS ALERT-BOX.
            ELSE
                MESSAGE "3" nv_baseprm  deci(wdetail.base) sicsyac.xmm106.min_ap VIEW-AS ALERT-BOX.
        END.*/
    END.
    ASSIGN chk = NO
        NO_basemsg = " " .
    If wdetail.drivnam  = "N"  Then 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass = "N"
                wdetail.comment  = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    /*-------nv_baseprm----------*/
    IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| Base Premium is Mandatory field. ".  
    ASSIGN  
        nv_prem1    = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    /*-------nv_add perils----------*/
    /*IF wdetail.prepol <> "" THEN  ASSIGN  nv_41 = n_41  /*ต่ออายุ*/
    nv_42 = n_42
    nv_43 = n_43 .*/
    ASSIGN 
        /*nv_41 = 200000  /*deci(wdetail.no_41)*/ 
        nv_42 = 200000         /*deci(wdetail.no_42)*/
        nv_43 = 200000    /*deci(wdetail.no_43)*/       
        wdetail.seat = "16"
        nv_seats = 16*/
        nv_seat41 =  wdetail.seat41  
        nv_class  =  wdetail.class  .
    /*...end A64-0138...
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                    nv_class,
                    nv_key_b,
                    nv_comdat). ...end A64-0138...*/
    ASSIGN nv_411var = " " nv_412var = " "
        nv_41cod1 = "411"
        nv_411var1   = "     PA Driver = "
        nv_411var2   =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
    Assign
        nv_42var    = " "       /* -------fi_42---------*/
        nv_42cod   = "42" 
        nv_42var1  = "     Medical Expense = " 
        nv_42var2  = STRING(nv_42) 
        SUBSTRING(nv_42var,1,30)   = nv_42var1 
        SUBSTRING(nv_42var,31,30)  = nv_42var2 
        nv_43var    = " ".        /*---------fi_43--------*/
    Assign  nv_43var = " " 
        nv_43prm   = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /* A64-0138... 
    RUN WGS\WGSOPER(INPUT nv_tariff,    /*pass*//*a490166 note modi*/
                    nv_class,     
                    nv_key_b,     
                    nv_comdat).   /*  RUN US\USOPER(INPUT nv_tariff,*/  
    ...end A64-0138...*/
    /*------nv_usecod------------*/
    Assign  nv_usevar = " "
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30)  = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  SUBSTR(wdetail.class,2,3). 
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    Assign  nv_yrvar = " "
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
        /*-----nv_sicod----------------------------*/  
    Assign  nv_sivar = " "
        nv_totsi = 0
        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  wdetail.si
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
        nv_totsi     =  DECI(wdetail.si).
    /*----------nv_grpcod--------------------*/
    ASSIGN nv_grpvar = " " 
        nv_grpcod      = "GRP" + wdetail.cargrp
        nv_grpvar1     = "     Vehicle Group = "
        nv_grpvar2     = wdetail.cargrp
        Substr(nv_grpvar,1,30)  = nv_grpvar1
        Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
    ASSIGN nv_bipvar = " "
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     =  string(wdetail.uom1_v)    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign nv_biavar  = " " 
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  string(wdetail.uom2_v)     /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    Assign  nv_pdavar = " "
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  string(wdetail.uom5_v)         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*--------------- deduct ----------------*/
    IF dod1 <> 0 THEN DO:  /* A64-0150 */
        ASSIGN nv_odcod = "DC01"
            /*nv_prem     =  dod1 .   */      
            nv_prem     =  dod1 .            
        RUN Wgs\Wgsmx024( nv_tariff,                     /*a490166 note modi*/
                          nv_odcod,
                          nv_class,
                          nv_key_b,
                          nv_comdat,
                          INPUT-OUTPUT nv_prem,
                          OUTPUT nv_chk ,
                          OUTPUT nv_baseap).
        IF NOT nv_chk THEN DO:
            MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
            /*NEXT.*/
        END.
        ASSIGN nv_dedod1var = " " 
            nv_ded1prm     = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
    END.
    /*add od*/
    IF dod2 <> 0 THEN DO:  /* A64-0150 */
        Assign  
            nv_dedod2var = " "
            nv_cons      = "AD"
            dpd0         = 0
            dpd0         = nv_ded
            nv_ded       = dod2.
        /* A64-0138... 
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */           
                          nv_tariff,                                 
                          nv_class,                                  
                          nv_key_b,
                          nv_comdat,
                          nv_cons,
                          OUTPUT nv_prem).  
        ...end A64-0138...*/
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
            nv_dedod2_prm   = nv_prem.
    END.
    /***** pd *******/
    IF dpd0 <> 0 THEN DO: /*A64-0150*/
        Assign
            nv_dedpdvar  = " "
            nv_cons      = "PD"
            /*nv_ded     = dpd0*/
            nv_ded       = dpd0
            /*dod0       = 0*/    .
        /* ...A64-0138... 
        Run  Wgs\Wgsmx025(INPUT  nv_ded,             /*  dod0,  */   
                          nv_tariff,                          
                          nv_class,                           
                          nv_key_b,
                          nv_comdat,
                          nv_cons,
                          OUTPUT nv_prem).
        ...end A64-0138.......*/
        nv_ded2prm    = nv_prem.
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            /*nv_dedpdvar2   =  STRING(dod0)*/
            nv_dedpdvar2   =  STRING(dpd0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
            nv_dedpd_prm  = nv_prem.
    END.
    /*---------- fleet -------------------*/
    IF deci(wdetail.fleet) <> 0 THEN DO: /* A64-0150 */
        ASSIGN nv_flet_per = DECI(wdetail.fleet) .
        IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
            Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
            ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
        END.
        IF nv_flet_per = 0 Then do:
            ASSIGN nv_flet     = 0
                nv_fletvar  = " ".
        END.
        /*...end A64-0138... 
        RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                            nv_class,
                            nv_covcod,
                            nv_key_b,
                            nv_comdat,
                            nv_totsi,
                            uwm130.uom1_v,
                            uwm130.uom2_v,
                            uwm130.uom5_v).
        ...end A64-0138...*/
        ELSE 
            ASSIGN
            nv_fletvar                  = " "
            nv_fletvar1                 = "     Fleet % = "
            nv_fletvar2                 =  STRING(nv_flet_per)
            SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
            SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
        IF nv_flet   = 0  THEN  nv_fletvar  = " ".
    END.
    /*---------------- NCB -------------------*/
    /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
    ASSIGN 
        NV_NCBPER  = DECI(wdetail.ncb)
        nv_ncb     = DECI(wdetail.ncb)
        nv_ncbvar  = " ".
    If nv_ncbper  <> 0 Then do:
        Find first sicsyac.xmm104 Use-index xmm10401 Where
            sicsyac.xmm104.tariff = nv_tariff        AND
            sicsyac.xmm104.class  = nv_class         AND 
            sicsyac.xmm104.covcod = nv_covcod        AND 
            sicsyac.xmm104.ncbper = NV_NCBPER        No-lock no-error no-wait.
        IF not avail  sicsyac.xmm104  Then do:
            Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
        END.
        ELSE ASSIGN nv_ncbper = xmm104.ncbper   
            nv_ncbyrs = xmm104.ncbyrs.
    END.
    Else DO: 
        Assign
            nv_ncbyrs  =   0
            nv_ncbper  =   0
            nv_ncb     =   0.
    END.
    /* A64-0138... 
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  /*pass*/
                        nv_class,
                        nv_covcod,
                        nv_key_b,
                        nv_comdat,
                        nv_totsi,
                        uwm130.uom1_v,
                        uwm130.uom2_v,
                        uwm130.uom5_v).
    ...end A64-0138...*/
    nv_ncbvar   = " ".
    IF  nv_ncb <> 0  THEN
        ASSIGN 
        nv_ncbvar1   = "     NCB % = "
        nv_ncbvar2   =  STRING(nv_ncbper)
        SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
        SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
    /*-------------- load claim ---------------------*/
    /*nv_cl_per  = 0.*/
    nv_clmvar  = " ".
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    /* A64-0138... 
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  
                        nv_class,
                        nv_covcod,
                        nv_key_b,
                        nv_comdat,
                        nv_totsi,
                        uwm130.uom1_v,
                        uwm130.uom2_v,
                        uwm130.uom5_v).
    ...end A64-0138...*/
    /*------------------ dsspc ---------------*/
    ASSIGN nv_dss_per = deci(wdetail.dspc).
    /*/*A63-00472*/
    IF wdetail.commission = 33 THEN 
        ASSIGN wdetail.commission = IF (33 - deci(wdetail.dspc)) > 18 THEN 18 ELSE (33 - deci(wdetail.dspc))  .
    *//*A63-00472*/
    IF  nv_dss_per   <> 0  THEN
        Assign  nv_dsspcvar = " "
        nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    /*----- A64-0138... 
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                        nv_class,
                        nv_covcod,
                        nv_key_b,
                        nv_comdat,
                        nv_totsi,
                        nv_uom1_v ,       
                        nv_uom2_v ,       
                        nv_uom5_v ). ...end A64-0138...*/
    /*------------------ stf ---------------*/
    nv_stfvar   = " ".
    IF  nv_stf_per   <> 0  THEN
        Assign
        nv_stfvar1   = "     Discount Staff"          
        nv_stfvar2   =  STRING(nv_stf_per)           
        SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
        SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.   
    /*-----...end A64-0138..                    
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff,   /*pass*/
                        nv_class,
                        nv_covcod,
                        nv_key_b,
                        nv_comdat,
                        nv_totsi,
                        nv_uom1_v ,       
                        nv_uom2_v ,       
                        nv_uom5_v ).
    ...end A64-0138...*/
    ASSIGN fi_process = "out base" + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2plus c-Win 
PROCEDURE proc_base2plus :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A63-0169      
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + wdetail.policy 
           nv_baseprm    = 0.
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
       (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO: 
            RUN wgs\wgsfbas.
    END.
    DISP fi_process WITH FRAM fr_main.
    IF nv_baseprm = 0  THEN DO: 
        RUN wgs\wgsfbas.
    END.
    ASSIGN chk = NO
        NO_basemsg = " " .
    If wdetail.drivnam  = "N"  Then 
        Assign nv_drivvar   = " "
        nv_drivcod   = "A000"
        nv_drivvar1  =  "     Unname Driver"
        nv_drivvar2  = "0"
        Substr(nv_drivvar,1,30)   = nv_drivvar1
        Substr(nv_drivvar,31,30)  = nv_drivvar2.
    ELSE DO:
        IF  nv_drivno  > 2  Then do:
            Message " Driver'S NO. must not over 2. "  View-as alert-box.
            ASSIGN  wdetail.pass = "N"
                wdetail.comment  = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
        END.
        RUN proc_usdcod.
        ASSIGN  nv_drivvar = nv_drivcod
            nv_drivvar1    = "     Driver name person = "
            nv_drivvar2    = String(nv_drivno)
            Substr(nv_drivvar,1,30)  = nv_drivvar1
            Substr(nv_drivvar,31,30) = nv_drivvar2.
    END.
    /*-------nv_baseprm----------*/
    nv_basevar = "" .
   IF NO_basemsg <> " " THEN  wdetail.WARNING = no_basemsg.
    IF nv_baseprm = 0  Then 
        ASSIGN  wdetail.pass = "N"
        wdetail.comment      = wdetail.comment + "| Base Premium is Mandatory field. ".  
        ASSIGN  nv_prem1 = nv_baseprm
        nv_basecod  = "BASE"
        nv_basevar1 = "     Base Premium = "
        nv_basevar2 = STRING(nv_baseprm)
        SUBSTRING(nv_basevar,1,30)   = nv_basevar1
        SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
    
     /*-------nv_add perils----------*/
     ASSIGN 
        nv_seat41 =  wdetail.seat41  
        nv_class  =  wdetail.class  .
/*A64-0138.. 
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat). 
                          ...end A64-0138...*/
    Assign nv_411var = ""   nv_412var = ""   
        nv_41cod1   = "411"
        nv_411var1  = "     PA Driver = "
        nv_411var2  =  STRING(nv_41)
        SUBSTRING(nv_411var,1,30)    = nv_411var1
        SUBSTRING(nv_411var,31,30)   = nv_411var2
        nv_41cod2   = "412"
        nv_412var1  = "     PA Passengers = "
        nv_412var2  =  STRING(nv_41)
        SUBSTRING(nv_412var,1,30)   = nv_412var1
        SUBSTRING(nv_412var,31,30)  = nv_412var2
        nv_411prm  = nv_41
        nv_412prm  = nv_41.
        nv_42var    = " ".     /* -------fi_42---------*/
    ASSIGN nv_42var = "" 
        nv_42cod   = "42".
        nv_42var1  = "     Medical Expense = ".
        nv_42var2  = STRING(nv_42).
        SUBSTRING(nv_42var,1,30)   = nv_42var1.
        SUBSTRING(nv_42var,31,30)  = nv_42var2.
        nv_43var    = " ".     /*---------fi_43--------*/
    ASSIGN nv_43var = ""
        nv_43prm = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /* A64-0138... 
    RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
                    nv_class,
                    nv_key_b,
                    nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/     
    ...end A64-0138...*/
    /*------nv_usecod------------*/
    ASSIGN nv_usevar = ""
        nv_usecod  = "USE" + TRIM(wdetail.vehuse)
        nv_usevar1 = "     Vehicle Use = "
        nv_usevar2 =  wdetail.vehuse
        Substring(nv_usevar,1,30)   = nv_usevar1
        Substring(nv_usevar,31,30)  = nv_usevar2.
    /*-----nv_engcod-----------------*/
    ASSIGN nv_sclass =  SUBSTR(wdetail.class,2,3). 
    RUN wgs\wgsoeng.   
    /*-----nv_yrcod----------------------------*/  
    ASSIGN nv_yrvar = ""
        nv_caryr   = (Year(nv_comdat)) - integer(wdetail.caryear) + 1
        nv_yrvar1  = "     Vehicle Year = "
        nv_yrvar2  =  wdetail.caryear
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) ELSE "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
    /*-----nv_sicod----------------------------*/  
    Assign  nv_sivar = ""   nv_totsi = 0
        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  wdetail.si
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
        nv_totsi     =  DECI(wdetail.si).
    /*----------nv_grpcod--------------------*/
    Assign  nv_grpvar = ""
        nv_grpcod      = "GRP" + wdetail.cargrp
        nv_grpvar1     = "     Vehicle Group = "
        nv_grpvar2     = wdetail.cargrp
        Substr(nv_grpvar,1,30)  = nv_grpvar1
        Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
    ASSIGN  nv_bipvar  = ""
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     =  STRING(wdetail.uom1_v)    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign nv_biavar   = ""
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  STRING(wdetail.uom2_v)    /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    
    IF      (wdetail.covcod = "2.1")   THEN assign nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
    ELSE IF (wdetail.covcod = "2.2")   THEN assign nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
    ELSE IF (wdetail.covcod = "3.1")   THEN assign nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
    ELSE ASSIGN nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .
    ASSIGN   nv_usevar3 = "" 
        nv_usevar4 = "     Vehicle Use = "
        nv_usevar5 =  wdetail.vehuse
        Substring(nv_usevar3,1,30)   = nv_usevar4
        Substring(nv_usevar3,31,30)  = nv_usevar5.

     ASSIGN  nv_basecod3 = IF      (wdetail.covcod = "2.1") THEN "BA21"
                           ELSE IF (wdetail.covcod = "2.2") THEN "BA22" 
                           ELSE IF (wdetail.covcod = "3.1") THEN "BA31" ELSE "BA32".
     FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
         sicsyac.xmm106.tariff = nv_tariff   AND
         sicsyac.xmm106.bencod = nv_basecod3 AND
         sicsyac.xmm106.covcod = nv_covcod   AND
         sicsyac.xmm106.class  = nv_class    AND
         sicsyac.xmm106.key_b  GE nv_key_b   AND
         sicsyac.xmm106.effdat LE nv_comdat  NO-LOCK NO-ERROR NO-WAIT.
     IF AVAIL xmm106 THEN  nv_baseprm3 = xmm106.min_ap.
     ELSE  nv_baseprm3 = 0.
     ASSIGN nv_basevar3 = ""
         nv_basevar4 = "     Base Premium3 = "
         nv_basevar5 = STRING(nv_baseprm3)
         SUBSTRING(nv_basevar3,1,30)   = nv_basevar4
         SUBSTRING(nv_basevar3,31,30)  = nv_basevar5.  
     ASSIGN nv_sivar3 = ""
        nv_sicod3    = IF      (wdetail.covcod = "2.1") THEN "SI21" 
                       ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                       ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32"     
        nv_sivar4    = "     Own Damage = "                                        
        nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  string(deci(wdetail.si)) ELSE string(deci(wdetail.si)) 
        wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  wdetail.si ELSE  wdetail.si
        SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
        SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
        nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  deci(wdetail.si) ELSE  deci(wdetail.si).
        /*nv_siprm3    = IF wdetail.covcod = "2.1" THEN  deci(wdetail.fi) ELSE DECI(wdetail.si)  .*/ 
    /**/
    /*-------------nv_pdacod--------------------*/
    Assign  nv_pdavar = ""
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  STRING(wdetail.uom5_v)         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    RUN WGS\WGSORPR1.P (INPUT   nv_tariff,  
                                nv_class,
                                nv_covcod,
                                nv_key_b,
                                nv_comdat,
                                deci(wdetail.si),
                                deci(wdetail.uom1_v),
                                deci(wdetail.uom2_v),
                                deci(wdetail.uom5_v)).   /*kridtiya i.*/
    /*--------------- deduct ----------------*/
    /*DEF VAR dod0 AS INTEGER.                                        
    DEF VAR dod1 AS INTEGER.                                        
    DEF VAR dod2 AS INTEGER.                                        
    DEF VAR dpd0 AS INTEGER.*/
    IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1")  THEN ASSIGN dod1  = 2000 .   /*A57-0126*/
    ELSE DO:
        IF dod0 > 3000 THEN DO:
            dod1 = 3000.
            dod2 = dod0 - dod1.
        END.
    END.
    IF dod1 <> 0 THEN DO: /*A64-0150*/
        ASSIGN nv_odcod = "DC01"
            nv_prem     =  dod1 .        
        RUN Wgs\Wgsmx024( nv_tariff,                    /*a490166 note modi*/
                          nv_odcod,
                          nv_class,
                          nv_key_b,
                          nv_comdat,
                          INPUT-OUTPUT nv_prem,
                          OUTPUT nv_chk ,
                          OUTPUT nv_baseap).
        IF NOT nv_chk THEN DO:
            MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
            /*NEXT.*/
        END.
        ASSIGN nv_dedod1var = ""
            nv_ded1prm     = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
    END.

    /*add od*/
    IF dod2 <> 0 THEN DO: /*A64-0150*/
        Assign  
            nv_dedod2var   = " "
            nv_cons  = "AD"
            nv_ded   = dod2.
        /* A64-0138.. 
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).  
        ...end A64-0138...*/
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
            nv_dedod2_prm   = nv_prem.
    END.
    /***** pd *******/
    IF dpd0 <> 0 THEN DO: /*A64-0150*/
        Assign
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dpd0
            /*dod0 = 0*/    .
        /* A64-0138... 
        Run  Wgs\Wgsmx025(INPUT  dod0,  
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
        ...end A64-0138...*/
        nv_ded2prm    = nv_prem.
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(dod0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2
            nv_dedpd_prm  = nv_prem.
    END.
    /*---------- fleet -------------------*/
    ASSIGN nv_flet_per = DECI(wdetail.fleet) .
    IF nv_flet_per <> 0 AND  nv_flet_per <> 10 Then do:
        Message  " Fleet Percent must be 0 or 10. " View-as alert-box.
        ASSIGN
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
    END.
    IF nv_flet_per = 0 Then do:
        ASSIGN nv_flet     = 0
            nv_fletvar  = " ".
    END.
    /*..  A64-0138.. 
    RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*kridtiya i. 23/07/2015*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    DECI(wdetail.si),
                    uwm130.uom1_v,
                    uwm130.uom2_v,
                    uwm130.uom5_v).
    ...end A64-0138...*/
    ELSE 
    ASSIGN
        nv_fletvar                  = " "
        nv_fletvar1                 = "     Fleet % = "
        nv_fletvar2                 =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
    IF nv_flet   = 0  THEN  nv_fletvar  = " ".
    /*---------------- NCB -------------------*/
   /* IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
    ASSIGN 
        NV_NCBPER  = DECI(wdetail.ncb)
        nv_ncb     = DECI(wdetail.ncb)
        nv_ncbvar = " ".
    If nv_ncbper  <> 0 Then do:
        Find first sicsyac.xmm104 Use-index xmm10401 Where
            sicsyac.xmm104.tariff = nv_tariff        AND
            sicsyac.xmm104.class  = nv_class         AND 
            sicsyac.xmm104.covcod = nv_covcod        AND 
            sicsyac.xmm104.ncbper = NV_NCBPER        No-lock no-error no-wait.
        IF not avail  sicsyac.xmm104  Then do:
            Message " This NCB Step not on NCB Rates file xmm104. " View-as alert-box.
            ASSIGN  wdetail.pass    = "N"
                    wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
        END.
        ELSE ASSIGN nv_ncbper = xmm104.ncbper   
                    nv_ncbyrs = xmm104.ncbyrs.
    END.
    Else DO: 
        Assign
            nv_ncbyrs  =   0
            nv_ncbper  =   0
            nv_ncb     =   0.
    END.
    /* A64-0138... 
    RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    DECI(wdetail.si),
                    uwm130.uom1_v,
                    uwm130.uom2_v,
                    uwm130.uom5_v).
    ...end A64-0138...*/
    nv_ncbvar   = " ".
    IF  nv_ncb <> 0  THEN
        ASSIGN 
        nv_ncbvar1   = "     NCB % = "
        nv_ncbvar2   =  STRING(nv_ncbper)
        SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
        SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
    /*-------------- load claim ---------------------*/
    /*nv_cl_per  = 0.*/
    nv_clmvar  = " ".
    nv_cl_per  = DECI(nv_cl_per). /*A60-0150*/
    IF nv_cl_per  <> 0  THEN
        Assign 
        nv_clmvar1   = " Load Claim % = "
        nv_clmvar2   =  STRING(nv_cl_per)
        SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
        SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
    /*.. A64-0138... 
    RUN WGS\WGSORPR1.P  (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    uwm130.uom1_v,
                    uwm130.uom2_v,
                    uwm130.uom5_v).
    ...end A64-0138...*/
    /*------------------ dsspc ---------------*/
     nv_dsspcvar = "" .
    ASSIGN nv_dss_per = deci(nv_dss_per).
    IF  nv_dss_per   <> 0  THEN
        ASSIGN nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    /*--------------------------*/
    /* A64-0138... 
    RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
    ...end A64-0138...*/
    /*------------------ stf ---------------*/
          nv_stfvar   = " ".
          nv_stf_per     = DECI(nv_stf_per). /*A60-0150*/
      IF  nv_stf_per   <> 0  THEN
           ASSIGN nv_stfvar1   = "     Discount Staff"          
                 nv_stfvar2   =  STRING(nv_stf_per)           
                 SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
                 SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2. 
        /*--------------------------*/   
     /* A64-0138... 
     RUN WGS\WGSORPR1.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
     ...end A64-0138...*/

    ASSIGN fi_process = "out base" + wdetail.policy.
    DISP fi_process WITH FRAM fr_main.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt c-Win 
PROCEDURE proc_calpremt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wdetail.poltyp = "V70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
    ASSIGN 
         nv_polday  = 0 
         nv_covcod  = ""  
         nv_class   = ""  
         nv_vehuse  = ""  
         nv_cstflg  = ""  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/    
         nv_engcst  = 0   /* ต้องใส่ค่าตาม nv_cstflg  */         
         /*nv_drivno  = 0*/
         nv_driage1 = 0
         nv_driage2 = 0
         nv_pdprm0  = 0  /*เบี้ยส่วนลดผู้ขับขี่*/
         nv_yrmanu  = 0
         nv_totsi   = 0
         nv_totfi   = 0
         nv_vehgrp  = ""
         nv_access  = ""
         nv_supe    = NO
         nv_tpbi1si = 0
         nv_tpbi2si = 0
         nv_tppdsi  = 0   
         nv_411si   = 0
         nv_412si   = 0
         nv_413si   = 0
         nv_414si   = 0  
         nv_42si    = 0
         nv_43si    = 0
         nv_seat41  = 0          
         nv_dedod   = 0
         nv_addod   = 0
         nv_dedpd   = 0        
         nv_ncbp    = 0
         nv_fletp   = 0
         nv_dspcp   = 0
         nv_dstfp   = 0
         nv_clmp    = 0
         nv_netprem = 0     /*เบี้ยสุทธิ */
         nv_gapprm  = 0     /*เบี้ยรวม */
         nv_flagprm = "N"   /* N = เบี้ยสุทธิ, G = เบี้ยรวม */
         nv_effdat  = ?
         nv_ratatt  = 0 
         nv_siatt   = 0 
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = NO
         nv_uom1_c  = "" 
         nv_uom2_c  = "" 
         nv_uom5_c  = "" 
         nv_uom6_c  = "" 
         nv_uom7_c  = "" .

    ASSIGN               
         nv_covcod  = wdetail.covcod                                              
         nv_class   =  trim(wdetail.class)                                         
         nv_vehuse  = wdetail.vehuse                                    
       /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
         nv_drivno  = 0   */                                     
         nv_driage1 = nv_drivage1                                 
         nv_driage2 = nv_drivage2                                    
         nv_yrmanu  = INT(wdetail.caryear)                         
         nv_totsi   = sic_bran.uwm130.uom6_v       
         nv_totfi   = sic_bran.uwm130.uom7_v
         nv_vehgrp  = wdetail.cargrp                                                     
         nv_access  = nv_uom6_u                                             
       /*nv_supe    = NO*/                                              
         nv_tpbi1si = nv_uom1_v             
         nv_tpbi2si = nv_uom2_v             
         nv_tppdsi  = nv_uom5_v             
         nv_411si   = nv_41        
         nv_412si   = nv_41        
         nv_413si   = 0                        
         nv_414si   = 0                       
         nv_42si    = nv_42                
         nv_43si    = nv_43                
         nv_seat41  = wdetail.seat41  
         nv_dedod   = deci(dod1)      
         nv_addod   = deci(dod2)                                
         nv_dedpd   = deci(dpd0)                                    
         nv_ncbp    = deci(wdetail.ncb)                                     
         nv_fletp   = deci(wdetail.fleet)                                  
         nv_dspcp   = deci(nv_dss_per)                                      
         nv_dstfp   = 0                                                     
         /*nv_clmp    = deci(wdetail.loadclm)*/
         /*nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
        
         nv_netprem  = deci(wdetail.premt) /* เบี้ยสุทธิ */                                                
         nv_gapprm  = 0                                                       
         nv_flagprm = "N"                 /* N = เบี้ยสุทธิ, G = เบี้ยรวม */                                    
         nv_effdat  = sic_bran.uwm100.comdat                             
         nv_ratatt  = 0                    
         nv_siatt   = 0                                                   
         nv_netatt  = 0 
         nv_fltatt  = 0 
         nv_ncbatt  = 0 
         nv_dscatt  = 0 
         /*nv_status  = "" */
         nv_fcctv   = NO . 

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = nv_class     AND
           clastab_fil.covcod = wdetail.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(nv_class,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(nv_class,5,1) = "E" THEN DECI(wdetail.engcc) ELSE INT(wdetail.engcc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(wdetail.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = IF DECI(sic_bran.uwm301.Tons) = 0 THEN nv_engine ELSE DECI(sic_bran.uwm301.Tons) .
            END.
            nv_engcst = nv_engine .
        END.

    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */

    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  nv_engine  ,
                               input  0 , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        ELSE DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  SUBSTR(nv_class,2,5),   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.
        IF wdetail.redbook <> ""  THEN DO: 
            Find FIRST stat.maktab_fil Use-index      maktab01        Where
            stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3) And   
            stat.maktab_fil.modcod   =  trim(wdetail.redbook)     No-lock no-error no-wait.
            If  avail stat.maktab_fil  Then 
            ASSIGN 
                wdetail.tonn              = stat.maktab_fil.tons    /*-- Add By Tontawan S. A66-0139 --*/
                sic_bran.uwm301.tons      = stat.maktab_fil.tons    /*-- Add By Tontawan S. A66-0139 --*/
                sic_bran.uwm301.modcod    = stat.maktab_fil.modcod                                    
                sic_bran.uwm301.vehgrp    = stat.maktab_fil.prmpac
                 nv_vehgrp                = stat.maktab_fil.prmpac
                wdetail.cargrp            = stat.maktab_fil.prmpac.
        END.
        ELSE DO:
         ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                wdetail.pass     = "Y"     
                wdetail.OK_GEN  = "N".

        END.
    END.

    FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wdetail.brand AND 
                                    maktab_fil.sclass   =  trim(SUBSTR(nv_class,2,4)) NO-LOCK NO-ERROR.
        IF AVAIL stat.maktab_fil THEN nv_supe = maktab_fil.impchg.

    IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
        IF ( DAY(sic_bran.uwm100.comdat)     =  DAY(sic_bran.uwm100.expdat)     AND
           MONTH(sic_bran.uwm100.comdat)     =  MONTH(sic_bran.uwm100.expdat)   AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
           ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
           MONTH(sic_bran.uwm100.comdat)     =   02                             AND
             DAY(sic_bran.uwm100.expdat)     =   01                             AND
           MONTH(sic_bran.uwm100.expdat)     =   03                             AND
            YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
        THEN DO:
          nv_polday = 365.
        END.
        ELSE DO:
          nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
        END.
    END.
    /* 
    MESSAGE 
    " wdetail.covcod   "  nv_covcod     skip  
    " wdetail.class    "  nv_class      skip  
    " wdetail.vehuse   "  nv_vehuse     skip  
    " nv_cstflg        "  nv_cstflg     skip  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/
    " nv_engine        "  nv_engcst     skip  /* ต้องใส่ค่าตาม nv_cstflg  */
    " nv_drivno        "  nv_drivno     skip  
    " nv_drivage1      "  nv_driage1    skip  
    " nv_drivage2      "  nv_driage2    skip
    " wdetail.caryear  "  nv_yrmanu     skip
    " wdetail.si       "  nv_totsi      skip  
    " wdetail.fi       "  nv_totfi      skip  
    " wdetail.cargrp   "  nv_vehgrp     skip  
    " wdetail.prmtxt   "  nv_access     skip  
    " nv_supe          "  nv_supe       skip  /*  supercar = yes/no  */                  
    " wdetail.uom1_v   "  nv_tpbi1si    skip  
    " wdetail.uom2_v   "  nv_tpbi2si    skip  
    " wdetail.uom5_v   "  nv_tppdsi     skip  
    " nv_411           "  nv_411si      skip  /*nv_411si */    
    " nv_412           "  nv_412si      skip  /*nv_412si */    
    " nv_413           "  nv_413si      skip  /*nv_413si */  
    " nv_414           "  nv_414si      skip  /*nv_414si */ 
    " nv_42            "  nv_42si       skip  
    " nv_43            "  nv_43si       skip  
    " wdetail.seat41   "  nv_seat41     skip  
    " dod1             "  nv_dedod      skip  /*nv_dedod */ 
    " dod2             "  nv_addod      skip  /*nv_addod */  
    " dod0             "  nv_dedpd      skip  /*nv_dedpd */                
    " wdetail.ncb      "  nv_ncbp       skip  
    " wdetail.fleet    "  nv_fletp      skip  
    " wdetail.dspc     "  nv_dspcp      skip  
    " nv_dstfp         "  nv_dstfp      skip  
    " nv_clmp          "  nv_clmp       skip  
    " nv_netprem       "  nv_netprem    skip  
    " nv_gapprm        "  nv_gapprem    skip  
    " nv_flagprm       "  nv_flagprm    skip  
    " wdetail.comdat   "  nv_effdat     skip 
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.  */   
 
    RUN WUW\WUWPADP2.P(INPUT sic_bran.uwm100.policy,
                       INPUT sic_bran.uwm100.rencnt,
                       INPUT sic_bran.uwm100.endcnt,
                       INPUT nv_riskno ,  
                       INPUT nv_batchyr, 
                       INPUT nv_batchno, 
                       INPUT nv_polday,
                       INPUT-OUTPUT nv_covcod ,
                       INPUT-OUTPUT nv_class  ,
                       INPUT-OUTPUT nv_vehuse ,
                       INPUT-OUTPUT nv_cstflg ,
                       INPUT-OUTPUT nv_engcst ,
                       INPUT-OUTPUT nv_drivno ,
                       INPUT-OUTPUT nv_driage1,
                       INPUT-OUTPUT nv_driage2,
                       INPUT-OUTPUT nv_pdprm0 , 
                       INPUT-OUTPUT nv_yrmanu ,
                       INPUT-OUTPUT nv_totsi  ,
/*                        INPUT-OUTPUT nv_totfi  , */
                       INPUT-OUTPUT nv_vehgrp,  
                       INPUT-OUTPUT nv_access,  
                       INPUT-OUTPUT nv_supe,                       
                       INPUT-OUTPUT nv_tpbi1si, 
                       INPUT-OUTPUT nv_tpbi2si, 
                       INPUT-OUTPUT nv_tppdsi,                 
                       INPUT-OUTPUT nv_411si,   
                       INPUT-OUTPUT nv_412si,   
                       INPUT-OUTPUT nv_413si,   
                       INPUT-OUTPUT nv_414si,   
                       INPUT-OUTPUT nv_42si,    
                       INPUT-OUTPUT nv_43si,    
                       INPUT-OUTPUT nv_41prmt, /* nv_41prmt */
                       INPUT-OUTPUT nv_42prmt, /* nv_42prmt */
                       INPUT-OUTPUT nv_43prmt, /* nv_43prmt */
                       INPUT-OUTPUT nv_seat41, /* nv_seat41 */             
                       INPUT-OUTPUT nv_dedod,   
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,                  
                       INPUT-OUTPUT nv_ncbp,      
                       INPUT-OUTPUT nv_fletp,   
                       INPUT-OUTPUT nv_dspcp,   
                       INPUT-OUTPUT nv_dstfp,   
                       INPUT-OUTPUT nv_clmp,                  
                       INPUT-OUTPUT nv_baseprm , /* nv_baseprm  */
                       INPUT-OUTPUT nv_baseprm3, /* nv_baseprm3 */
                       INPUT-OUTPUT nv_pdprem  , /* nv_pdprem   */
                       INPUT-OUTPUT nv_netprem,  /* nv_netprem  */
                       INPUT-OUTPUT nv_gapprm,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       INPUT-OUTPUT nv_fcctv , /* cctv = yes/no */
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       OUTPUT nv_status, 
                       OUTPUT nv_message ).
    /*IF nv_gapprm <> DECI(wdetail.premt) THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt + 
            nv_message VIEW-AS ALERT-BOX.
        ASSIGN wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt.
            wdetail.pass     = "Y"   
            wdetail.OK_GEN  = "N".*/  /*comment by Kridtiya i. A65-0035*/ 
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN  wdetail.comment = wdetail.comment + "|" + nv_message   /*  by Kridtiya i. A65-0035*/
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message . /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035*/
    /* Check Date and Cover Day */
    nv_chkerr = "" .
    RUN wgw/wgwchkdate (input DATE(wdetail.comdat),
                        input DATE(wdetail.expdat),
                        input wdetail.poltyp,
                        OUTPUT nv_chkerr ) .
    IF nv_chkerr <> ""  THEN 
        ASSIGN wdetail.comment = wdetail.comment + "|" + nv_chkerr
               wdetail.pass    = "N"
               wdetail.OK_GEN  = "N".
    /* end : A65-0035 */
    ASSIGN 
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic c-Win 
PROCEDURE proc_chassic :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.
ASSIGN nv_uwm301trareg = wdetail.chassis.
loop_chk1:
REPEAT:
    IF INDEX(nv_uwm301trareg,"-") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"-") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"-") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk1.
END.
loop_chk2:
REPEAT:
    IF INDEX(nv_uwm301trareg,"/") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"/") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"/") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk2.
END.
loop_chk3:
REPEAT:
    IF INDEX(nv_uwm301trareg,";") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,";") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,";") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk3.
END.
loop_chk4:
REPEAT:
    IF INDEX(nv_uwm301trareg,".") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,".") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,".") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk4.
END.
loop_chk5:
REPEAT:
    IF INDEX(nv_uwm301trareg,",") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,",") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,",") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk5.
END.
loop_chk6:
REPEAT:
    IF INDEX(nv_uwm301trareg," ") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg," ") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg," ") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk6.
END.
loop_chk7:
REPEAT:
    IF INDEX(nv_uwm301trareg,"\") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"\") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"\") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk7.
END.
loop_chk8:
REPEAT:
    IF INDEX(nv_uwm301trareg,":") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,":") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,":") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk8.
END.
loop_chk9:
REPEAT:
    IF INDEX(nv_uwm301trareg,"|") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"|") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"|") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk9.
END.
loop_chk10:
REPEAT:
    IF INDEX(nv_uwm301trareg,"+") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"+") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk10.
END.
loop_chk11:
REPEAT:
    IF INDEX(nv_uwm301trareg,"#") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"#") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"#") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk11.
END.
loop_chk12:
REPEAT:
    IF INDEX(nv_uwm301trareg,"[") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"[") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"[") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk12.
END.
loop_chk13:
REPEAT:
    IF INDEX(nv_uwm301trareg,"]") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"]") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"]") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk13.
END.
loop_chk14:
REPEAT:
    IF INDEX(nv_uwm301trareg,"'") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"'") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"+") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk14.
END.
loop_chk15:
REPEAT:
    IF INDEX(nv_uwm301trareg,"(") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"(") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"(") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk15.
END.
loop_chk16:
REPEAT:
    IF INDEX(nv_uwm301trareg,"_") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"_") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"_") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk16.
END.
loop_chk17:
REPEAT:
    IF INDEX(nv_uwm301trareg,"*") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"*") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"*") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk17.
END.
loop_chk18:
REPEAT:
    IF INDEX(nv_uwm301trareg,")") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,")") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,")") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk18.
END.
loop_chk19:
REPEAT:
    IF INDEX(nv_uwm301trareg,"=") <> 0 THEN DO:
        nv_len = LENGTH(nv_uwm301trareg).
        nv_uwm301trareg = SUBSTRING(nv_uwm301trareg,1,INDEX(nv_uwm301trareg,"=") - 1) +
            SUBSTRING(nv_uwm301trareg,INDEX(nv_uwm301trareg,"=") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk19.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode c-Win 
PROCEDURE proc_chkcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Add by : A64-0138 */ 
  nv_chkerr = "".
    RUN wgw\wgwchkagpd  (INPUT wdetail.agent ,           
                         INPUT wdetail.producer ,  
                         INPUT-OUTPUT nv_chkerr).
    IF nv_chkerr <> "" THEN DO:
        MESSAGE "Error Code Producer/Agent :" nv_chkerr  SKIP
        wdetail.producer SKIP
        wdetail.agent  VIEW-AS ALERT-BOX. 
        ASSIGN wdetail.comment = wdetail.comment + nv_chkerr 
               wdetail.pass    = "N" 
               wdetail.OK_GEN  = "N".
    END.
    
 
 /*IF wdetail.n_delercode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.n_delercode) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.n_delercode + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.n_delercode + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
                wdetail.pass    = "N" 
                wdetail.OK_GEN  = "N".
     END.
 END.
 IF wdetail.fincode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.fincode) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Finance " + wdetail.fincode + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
      IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
       ASSIGN wdetail.comment = wdetail.comment + "| Code Finance " + wdetail.fincode + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
              wdetail.pass    = "N" 
              wdetail.OK_GEN  = "N".
     END.
 END.
 IF wdetail.payercod <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.payercod) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Payer " + wdetail.payercod + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
 END.*/
 IF wdetail.vatcode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.vatcode) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Vat " + wdetail.vatcode + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code VAT " + wdetail.vatcode + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
             wdetail.pass    = "N" 
             wdetail.OK_GEN  = "N".
    END.
 END.
 RELEASE sicsyac.xmm600.
  /* end : A64-0138 */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest0 c-Win 
PROCEDURE proc_chktest0 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_models  AS CHAR FORMAT "x(55)"  INIT "" .
DEF VAR nv_tariff  AS CHAR INIT "" .

IF wdetail.chassis = "" THEN DO:
    ASSIGN 
    wdetail.comment = wdetail.comment + "| Chassis no. is mandatory field. "
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N". 
END.
ELSE DO:
     IF wdetail.poltyp = "V70"  THEN ASSIGN nv_tariff = "X".
     ELSE ASSIGN nv_tariff = "9" .

     FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE (sicuw.uwm301.cha_no = TRIM(wdetail.chassis)) AND 
                                                     sicuw.uwm301.tariff = nv_tariff NO-LOCK  NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm301 THEN DO:
            FIND LAST sicuw.uwm100 USE-INDEX uwm10001 WHERE 
                sicuw.uwm100.policy = sicuw.uwm301.policy AND
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  AND
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt NO-LOCK NO-ERROR .
            IF AVAIL sicuw.uwm100 THEN
                IF sicuw.uwm100.comdat = DATE(wdetail.comdat) THEN DO:
                   ASSIGN 
                   wdetail.comment = wdetail.comment + "| เลขตัวถังนี้การออกงานแล้ว " + sicuw.uwm100.policy 
                   wdetail.pass    = "N"   
                   wdetail.OK_GEN  = "N".
                END.
        END.

        RELEASE sicuw.uwm301.
        RELEASE sicuw.uwm100.
END.

IF wdetail.vehreg = "" THEN wdetail.vehreg = IF SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8) <> "" THEN
                                            "/" +   SUBSTR(wdetail.chassis,LENGTH(wdetail.chassis) - 8 ) 
                                            ELSE "".
IF wdetail.vehreg = " " THEN 
    ASSIGN wdetail.vehreg = "/" + SUBSTRING(trim(wdetail.chassis),LENGTH(trim(wdetail.chassis))  - 8 ) 
    wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N". 
/*ELSE DO:
        DEF  var  nv_vehreg  as char  init  " ".
        Def  var  s_polno       like sicuw.uwm100.policy   init " ".
        Find LAST sicuw.uwm301 Use-index uwm30102   Where  
            sicuw.uwm301.vehreg = wdetail.vehreg    No-lock no-error no-wait.
        IF AVAIL sicuw.uwm301 THEN DO:
            If  sicuw.uwm301.policy =  wdetail.policy     and          
                sicuw.uwm301.endcnt = 1  and
                sicuw.uwm301.rencnt = 1  and
                sicuw.uwm301.riskno = 1  and
                sicuw.uwm301.itemno = 1  Then  Leave.
            Find first sicuw.uwm100 Use-index uwm10001      Where
                sicuw.uwm100.policy = sicuw.uwm301.policy   and
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt   and                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt   and 
                sicuw.uwm100.expdat > date(wdetail.comdat)  No-lock no-error no-wait.
            If avail sicuw.uwm100 Then  s_polno     =   sicuw.uwm100.policy.
        END.    /*avil 301*/
END.            /*note end else*/   /*end note vehreg*/   */
IF wdetail.n_branch = ""  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| พบสาขาเป็นค่าว่าง "
    wdetail.OK_GEN  = "N".

IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass    = "N"  
    wdetail.comment = wdetail.comment + "| cancel"
    wdetail.OK_GEN  = "N".
IF wdetail.insnam = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass    = "N"     
    wdetail.OK_GEN  = "N".
IF wdetail.class = " " THEN  
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
IF wdetail.producer = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Producer code เป็นค่าว่าง "
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.agent = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Agent code เป็นค่าว่าง "
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    wdetail.OK_GEN  = "N".
ASSIGN NO_CLASS  = trim(wdetail.class) 
       nv_poltyp = trim(wdetail.poltyp).
If no_class  <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp =   nv_poltyp       AND
        sicsyac.xmd031.class  =   no_class        NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
        wdetail.pass    = "N"   
        wdetail.OK_GEN  = "N".
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
        sicsyac.xmm016.class =    no_class  NO-LOCK NO-ERROR.
    IF NOT AVAILABLE sicsyac.xmm016 THEN 
        ASSIGN  wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
        wdetail.pass    = "N"    
        wdetail.OK_GEN  = "N".
    ELSE 
        ASSIGN  wdetail.tariff = sicsyac.xmm016.tardef
            no_class           = sicsyac.xmm016.class
            nv_sclass          = Substr(no_class,2,3).
END.
Find sicsyac.sym100 Use-index sym10001       Where
    sicsyac.sym100.tabcod = "u014"           AND 
    sicsyac.sym100.itmcod =  wdetail.vehuse  No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".
Find  sicsyac.sym100 Use-index sym10001    Where
    sicsyac.sym100.tabcod = "u013"         And
    sicsyac.sym100.itmcod = wdetail.covcod No-lock no-error no-wait.
IF not avail sicsyac.sym100 Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
    wdetail.pass    = "N" 
    wdetail.OK_GEN  = "N".
/*---------- fleet -------------------*/
IF inte(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 Then 
    ASSIGN wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
/******* drivernam **********/
ASSIGN nv_sclass = wdetail.class.
IF INDEX(wdetail.model," ") <> 0 THEN DO: 
    ASSIGN np_models  = ""
        np_models     = wdetail.model
        wdetail.model = TRIM(SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))) .
END.
If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
IF wdetail.prepol = "" THEN DO:
    /*comment by Kridtiya i. A57-0186.....
    Find FIRST stat.maktab_fil Use-index      maktab04         Where
        stat.maktab_fil.makdes   =     trim(wdetail.brand)     And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0       And
        stat.maktab_fil.makyea   =   Integer(wdetail.caryear)  AND
        stat.maktab_fil.sclass   =   SUBSTR(wdetail.class,2,3) No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    end....comment by Kridtiya i. A57-0186.....*/
    /*A57-0186*/
    FIND FIRST stat.makdes31 USE-INDEX makdes31 WHERE 
        makdes31.moddes =  wdetail.class  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL makdes31  THEN
        ASSIGN nv_simat  = makdes31.si_theft_p   
               nv_simat1 = makdes31.load_p   .    
    ELSE ASSIGN  
        nv_simat  = 20
        nv_simat1 = 20.
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =  trim(wdetail.brand)                           And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0                          And
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)                      AND 
        /*stat.maktab_fil.engine  =  deci(wdetail.engcc)                          AND -- Comment By Tontawan S. A66-0139 --*/
        stat.maktab_fil.engine  >=  deci(wdetail.engcc)                           AND /*---- Add By Tontawan S. A66-0139 --*/
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3)                     AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)   AND
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  /*AND  
        stat.maktab_fil.seats    >=    DECI(wdetail.seat) */      No-lock no-error no-wait.
    If  avail stat.maktab_fil  THEN
        ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    /*A57-0186*/
END.
ELSE DO:
    Find FIRST stat.maktab_fil Use-index      maktab01        Where
        stat.maktab_fil.sclass   =  SUBSTR(wdetail.class,2,3) And   
        stat.maktab_fil.modcod   =  trim(wdetail.redbook)     No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook  =  stat.maktab_fil.modcod
        wdetail.brand    =  stat.maktab_fil.moddes  
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
END.
IF wdetail.redbook  = "" THEN DO:
    IF INDEX(np_models,"ALL NEW") <> 0 THEN DO: 
        ASSIGN  wdetail.model = trim(replace(np_models,"ALL NEW","")).
        Find FIRST stat.maktab_fil Use-index      maktab04         Where
        stat.maktab_fil.makdes   =     trim(wdetail.brand)     And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0       And
        stat.maktab_fil.makyea   =   Integer(wdetail.caryear)  AND
        stat.maktab_fil.sclass   =   SUBSTR(wdetail.class,2,3) AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)   AND
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  /*AND  
        stat.maktab_fil.seats    >=    DECI(wdetail.seat) */      No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  stat.maktab_fil.body 
            wdetail.Tonn     =  stat.maktab_fil.tons
            wdetail.engcc    =  STRING(stat.maktab_fil.engine)
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    END.
    ELSE DO:
        Find LAST stat.maktab_fil Use-index      maktab04         Where
        stat.maktab_fil.makdes   =     trim(wdetail.brand)     And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0       And
        stat.maktab_fil.makyea   =   Integer(wdetail.caryear)  AND
        stat.maktab_fil.sclass   =   SUBSTR(wdetail.class,2,3) AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)   AND
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  /*AND  
        stat.maktab_fil.seats    >=    DECI(wdetail.seat) */      No-lock no-error no-wait.
        If  avail stat.maktab_fil  Then 
            ASSIGN wdetail.redbook  =  stat.maktab_fil.modcod
            wdetail.brand    =  stat.maktab_fil.makdes  
            wdetail.model    =  stat.maktab_fil.moddes
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.body     =  stat.maktab_fil.body 
            wdetail.Tonn     =  stat.maktab_fil.tons
            wdetail.engcc    =  STRING(stat.maktab_fil.engine)
            wdetail.cargrp   =  stat.maktab_fil.prmpac
            wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .

    END.
    
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest1 c-Win 
PROCEDURE proc_chktest1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-------------------------------------  new --------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail :
    ASSIGN nv_baseprm = 0
    nv_41             = 0
    nv_42             = 0
    nv_43             = 0
    dod1              = 0
    dod2              = 0
    dod0              = 0
    nv_stf_per        = 0
    nv_cl_per         = 0 
    n_rencnt          = 0  
    n_Endcnt          = 0
    wdetail.n_rencnt  = 0
    wdetail.n_endcnt  = 0
    nv_drivno         = 0    /*A61-0386*/
    wdetail.pass      = "Y"
    nv_chkerr         = "" .
    /*Add by Kridtiya i. A63-0472*/ 
    /*IF      wdetail.producer = "A0M0122" AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer = "B3MLAMA101" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0M0122"                          THEN ASSIGN wdetail.producer = "B3MLAMA101" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "A0M0123"                          THEN ASSIGN wdetail.producer = "B3MLAMA102" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "A0M0124" AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer = "B3MLAMA103" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0M0124"                          THEN ASSIGN wdetail.producer = "B3MLAMA103" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "A0M0125" AND wdetail.prepol <> "" THEN ASSIGN wdetail.producer = "B3MLAMA104" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0M0125"                          THEN ASSIGN wdetail.producer = "B3MLAMA104" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF".     
    ELSE IF wdetail.producer = "B3MLAMA101" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "B3MLAMA101"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "B3MLAMA102"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "B3MLAMA103" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "B3MLAMA103"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "B3MLAMA104" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "B3MLAMA104"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    IF wdetail.agent = "B3W0100" THEN wdetail.agent = "B3MLAMA100". */
    IF      wdetail.producer = "A0M0122" AND wdetail.prepol <> ""    THEN ASSIGN wdetail.producer = "A0MLAMA101" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0M0122"                             THEN ASSIGN wdetail.producer = "A0MLAMA101" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "A0M0123"                             THEN ASSIGN wdetail.producer = "A0MLAMA102" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "A0M0124" AND wdetail.prepol <> ""    THEN ASSIGN wdetail.producer = "A0MLAMA103" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0M0124"                             THEN ASSIGN wdetail.producer = "A0MLAMA103" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "A0M0125" AND wdetail.prepol <> ""    THEN ASSIGN wdetail.producer = "A0MLAMA104" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0M0125"                             THEN ASSIGN wdetail.producer = "A0MLAMA104" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF".     
    ELSE IF wdetail.producer = "A0MLAMA101" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0MLAMA101"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "A0MLAMA102"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "USED".
    ELSE IF wdetail.producer = "A0MLAMA103" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0MLAMA103"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    ELSE IF wdetail.producer = "A0MLAMA104" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
    ELSE IF wdetail.producer = "A0MLAMA104"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
    /*wdetail.agent = "B3W0100" .*/ /*A63-00472*/
    /*wdetail.agent = "A0MLAMA100" .  /*A63-00472*/*/ /* A64-0150*/
    /* Ranu : A64-0150 */
    /*
    RUN wgw/wgwchkagpd( INPUT wdetail.agent,
                       INPUT wdetail.producer,
                       INPUT-OUTPUT nv_chkerr) .
    */
    IF nv_chkerr <> "" THEN DO:
        MESSAGE nv_chkerr VIEW-AS ALERT-BOX.
        ASSIGN wdetail.pass  = "N"
               wdetail.comment = wdetail.comment + " |" + nv_chkerr .
    END.
    /* end A64-0150 */

    RUN proc_susspect.
    RUN proc_chkcode . /*A64-0138*/
    /*Add by Kridtiya i. A63-0472*/ 
    IF wdetail.poltyp = "v72"  THEN DO:
        RUN proc_72.
        RUN proc_policy. 
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message).
        NEXT.
    END.
    ELSE DO:
        IF wdetail.prepol <> "" THEN  RUN Proc_renew70.   /*new policy*/ 
        /*Add by Kridtiya i. A63-0472*/ 
        IF      wdetail.producer = "A0M0122" AND wdetail.prepol <> ""    THEN ASSIGN wdetail.producer = "A0MLAMA101" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer = "A0M0122"                             THEN ASSIGN wdetail.producer = "A0MLAMA101" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
        ELSE IF wdetail.producer = "A0M0123"                             THEN ASSIGN wdetail.producer = "A0MLAMA102" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "USED".
        ELSE IF wdetail.producer = "A0M0124" AND wdetail.prepol <> ""    THEN ASSIGN wdetail.producer = "A0MLAMA103" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer = "A0M0124"                             THEN ASSIGN wdetail.producer = "A0MLAMA103" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
        ELSE IF wdetail.producer = "A0M0125" AND wdetail.prepol <> ""    THEN ASSIGN wdetail.producer = "A0MLAMA104" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer = "A0M0125"                             THEN ASSIGN wdetail.producer = "A0MLAMA104" wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF".      
        ELSE IF wdetail.producer = "A0MLAMA101" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer = "A0MLAMA101"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
        ELSE IF wdetail.producer = "A0MLAMA102"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "USED".
        ELSE IF wdetail.producer = "A0MLAMA103" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer = "A0MLAMA103"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF". 
        ELSE IF wdetail.producer = "A0MLAMA104" AND wdetail.prepol <> "" THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "RENEW".
        ELSE IF wdetail.producer = "A0MLAMA104"                          THEN ASSIGN  wdetail.financecd = "FAMANAH" wdetail.campaign_ov = "TRANSF".     

        /*Add by Kridtiya i. A63-0472*/ 
        RUN proc_chktest0.
        RUN proc_policy . 
        RUN proc_chktest2. 
        RUN proc_chktest3.      
        RUN proc_chktest4. 
    END.
END.   /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2 c-Win 
PROCEDURE proc_chktest2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN fi_process = "Create data to uwm130..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
RUN proc_chktest2_camp.
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND  /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND  /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND  /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND 
    sic_bran.uwm130.bchno  = nv_batchno             AND 
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN 
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm100.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt  
        sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   
        sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno
        sic_bran.uwm130.bchyr  = nv_batchyr    /* batch Year */
        sic_bran.uwm130.bchno  = nv_batchno    /* bchno      */
        sic_bran.uwm130.bchcnt = nv_batcnt     /* bchcnt     */
        nv_sclass              = substr(wdetail.class,2,3) .
    IF nv_uom6_u  =  "A"  THEN DO:
        IF  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
            nv_sclass  =  "520"  Or  nv_sclass  =  "540"  Then  nv_uom6_u  =  "A".         
        Else 
            ASSIGN wdetail.pass = "N"
                wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
    END.
    IF  CAPS(nv_uom6_u) = "A"  Then
        Assign  nv_uom6_u          = "A"
        nv_othcod                  = "OTH"
        nv_othvar1                 = "     Accessory  = "
        nv_othvar2                 =  STRING(nv_uom6_u)
        SUBSTRING(nv_othvar,1,30)  = nv_othvar1
        SUBSTRING(nv_othvar,31,30) = nv_othvar2.
    ELSE                           
        ASSIGN  nv_uom6_u              = ""
            nv_othcod                  = ""
            nv_othvar1                 = ""
            nv_othvar2                 = ""
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.

    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR 
       INDEX(wdetail.covcod,"2.") <> 0 OR INDEX(wdetail.covcod,"3.") <> 0  THEN  /*A62-0445*/     
        ASSIGN sic_bran.uwm130.uom1_v = deci(wdetail.uom1_v)  
        sic_bran.uwm130.uom2_v        = deci(wdetail.uom2_v)  
        sic_bran.uwm130.uom5_v        = deci(wdetail.uom5_v) 
        sic_bran.uwm130.uom6_v        = inte(wdetail.si)
        sic_bran.uwm130.uom7_v        = inte(wdetail.fi)
        sic_bran.uwm130.fptr01        = 0     sic_bran.uwm130.bptr01 = 0   /*Item Upper text*/
        sic_bran.uwm130.fptr02        = 0     sic_bran.uwm130.bptr02 = 0   /*Item Lower Text*/
        sic_bran.uwm130.fptr03        = 0     sic_bran.uwm130.bptr03 = 0   /*Cover & Premium*/
        sic_bran.uwm130.fptr04        = 0     sic_bran.uwm130.bptr04 = 0   /*Item Endt. Text*/
        sic_bran.uwm130.fptr05        = 0     sic_bran.uwm130.bptr05 = 0.  /*Item Endt. Clause*/
    IF wdetail.covcod = "2"  THEN 
        ASSIGN sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = inte(wdetail.si)
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
    IF wdetail.covcod = "3"  THEN 
        ASSIGN sic_bran.uwm130.uom1_v = deci(wdetail.uom1_v)  
        sic_bran.uwm130.uom2_v    = deci(wdetail.uom2_v)  
        sic_bran.uwm130.uom5_v    = deci(wdetail.uom5_v)  
        sic_bran.uwm130.uom6_v    = 0   
        sic_bran.uwm130.uom7_v    = 0
        sic_bran.uwm130.fptr01    = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
        sic_bran.uwm130.fptr02    = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
        sic_bran.uwm130.fptr03    = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
        sic_bran.uwm130.fptr04    = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
        sic_bran.uwm130.fptr05    = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/



    FIND FIRST stat.clastab_fil Use-index clastab01 Where
        stat.clastab_fil.class   = wdetail.class    And
        stat.clastab_fil.covcod  = wdetail.covcod   No-lock  No-error No-wait.
    IF avail stat.clastab_fil Then do:
        Assign sic_bran.uwm130.uom1_v  =  deci(wdetail.uom1_v)     /*stat.clastab_fil.uom1_si  1000000  */  
            sic_bran.uwm130.uom2_v     =  deci(wdetail.uom2_v)     /*stat.clastab_fil.uom2_si  10000000 */  
            sic_bran.uwm130.uom5_v     =  deci(wdetail.uom5_v)     /*stat.clastab_fil.uom5_si  2500000  */ 
            nv_uom1_v                  =  deci(wdetail.uom1_v)     /*deci(wdetail2.tp_bi)   */ 
            nv_uom2_v                  =  deci(wdetail.uom2_v)     /*deci(wdetail2.tp_bi2) */  
            nv_uom5_v                  =  deci(wdetail.uom5_v)     /*deci(wdetail2.tp_bi3) */ 
            /*wdetail.deductpd           =  string(sic_bran.uwm130.uom5_v)*/
            sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
            sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
            sic_bran.uwm130.uom3_v     =  0
            sic_bran.uwm130.uom4_v     =  0
            wdetail.comper             =  string(stat.clastab_fil.uom8_si)                
            wdetail.comacc             =  string(stat.clastab_fil.uom9_si)
            sic_bran.uwm130.uom1_c  = "D1"
            sic_bran.uwm130.uom2_c  = "D2"
            sic_bran.uwm130.uom5_c  = "D5"
            sic_bran.uwm130.uom6_c  = "D6"
            sic_bran.uwm130.uom7_c  = "D7".
        IF wdetail.prepol = "" THEN DO:
            IF SUBSTR(wdetail.class,1,1) <> "Z" THEN DO:
                /* comment A63-0169..
                If  wdetail.garage  =  "G"  Then
                    Assign 
                    nv_41           =  deci(stat.clastab_fil.si_41unp)
                    nv_42           =  deci(stat.clastab_fil.si_42)
                    nv_43           =  deci(stat.clastab_fil.si_43)   
                    /*nv_seat41       =  deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)/*A57-0186*/  */
                    wdetail.seat41  =  deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)  /*A57-0186*/    .   
                Else                          
                    Assign 
                        nv_41           =   deci(stat.clastab_fil.si_41pai)
                        nv_42           =   deci(stat.clastab_fil.si_42    )
                        nv_43           =   deci(stat.clastab_fil.impsi_43  )
                        /*nv_seat41       =   deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41) /*A57-0186*/*/
                        wdetail.seat41  =   deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)  /*A57-0186*/  . 
                 ..end A63-0169..*/ 
                /* add A63-0169..*/
                If  wdetail.garage  =  "G"  Then
                    Assign 
                    nv_41           = if deci(wdetail.nv_41) <> 0 then deci(wdetail.nv_41) else deci(stat.clastab_fil.si_41unp)
                    nv_42           = if deci(wdetail.nv_42) <> 0 then deci(wdetail.nv_42) else deci(stat.clastab_fil.si_42)
                    nv_43           = if deci(wdetail.nv_43) <> 0 then deci(wdetail.nv_43) else deci(stat.clastab_fil.si_43)   
                    wdetail.seat41  =  deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)     .   
                Else                          
                    Assign 
                        nv_41           =  if deci(wdetail.nv_41) <> 0 then deci(wdetail.nv_41) else deci(stat.clastab_fil.si_41pai)
                        nv_42           =  if deci(wdetail.nv_42) <> 0 then deci(wdetail.nv_42) else deci(stat.clastab_fil.si_42    )
                        nv_43           =  if deci(wdetail.nv_43) <> 0 then deci(wdetail.nv_43) else deci(stat.clastab_fil.impsi_43  )
                        wdetail.seat41  =   deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)    . 
                 /*..end A63-0169..*/  
            END.
            ELSE 
                Assign                       
                    nv_41           = deci(wdetail.nv_41)
                    nv_42           = deci(wdetail.nv_42)
                    nv_43           = deci(wdetail.nv_43)
                    wdetail.seat41  = IF wdetail.seat41 = 0 THEN INTE(wdetail.seat)    ELSE wdetail.seat41.
        END.
                
    END.
    ASSIGN  nv_riskno = 1
        nv_itemno = 1.
    IF wdetail.covcod = "1" Then 
        RUN wgs/wgschsum(INPUT  wdetail.policy, 
                         nv_riskno,
                         nv_itemno).
    END.   /* end Do transaction*/
    ASSIGN  s_recid3  = RECID(sic_bran.uwm130)
        nv_covcod =   wdetail.covcod
        nv_newsck  = " ".
    RUN proc_chassic.
    IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck =  wdetail.stk.
    FIND sic_bran.uwm301 USE-INDEX uwm30101       WHERE
        sic_bran.uwm301.policy = sic_bran.uwm100.policy    AND
        sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt    AND
        sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt    AND
        sic_bran.uwm301.riskgp = s_riskgp                  AND
        sic_bran.uwm301.riskno = s_riskno                  AND
        sic_bran.uwm301.itemno = s_itemno                  AND
        sic_bran.uwm301.bchyr  = nv_batchyr                AND 
        sic_bran.uwm301.bchno  = nv_batchno                AND 
        sic_bran.uwm301.bchcnt = nv_batcnt                 NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
        END.
    END.
    ASSIGN 
        sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
        sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno    = s_itemno
        sic_bran.uwm301.tariff    = wdetail.tariff    
        sic_bran.uwm301.covcod    = TRIM(wdetail.covcod)
        sic_bran.uwm301.cha_no    = trim(wdetail.chassis)
      /*sic_bran.uwm301.trareg    = trim(wdetail.vehreg)*/ /*A58-0206 */
        sic_bran.uwm301.trareg    = trim(nv_uwm301trareg)  /*A58-0206 */
        sic_bran.uwm301.eng_no    = trim(wdetail.engno)
        sic_bran.uwm301.Tons      = INTEGER(wdetail.Tonn)
        sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage    = trim(wdetail.garage)
        sic_bran.uwm301.body      = trim(wdetail.body)
        sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv41seat  = IF wdetail.seat41 = 0 THEN INTEGER(wdetail.seat) ELSE wdetail.seat41
        sic_bran.uwm301.mv_ben83  = IF wdetail.poltyp = "v70" THEN trim(wdetail.benname) ELSE ""
        /*sic_bran.uwm301.vehreg    = trim(wdetail.vehreg) */          /*A58-0206 */ 
        sic_bran.uwm301.vehreg    = substr(trim(wdetail.vehreg),1,11)  /*A58-0206 */
        sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse    = wdetail.vehuse
        sic_bran.uwm301.moddes    = IF wdetail.prepol = "" THEN trim(wdetail.brand) + " " + trim(wdetail.model) 
                                    ELSE trim(wdetail.brand)
        sic_bran.uwm301.modcod    = wdetail.redbook                                    
        sic_bran.uwm301.vehgrp    = wdetail.cargrp
        sic_bran.uwm301.sckno     = 0
        sic_bran.uwm301.itmdel    = NO  
        sic_bran.uwm301.logbok    = IF wdetail.n_import = "" THEN "" ELSE "Y"  /*a62-0445*/
        wdetail.tariff            = sic_bran.uwm301.tariff .
        
    IF wdetail.prmtxt = "" THEN DO:
        FIND FIRST wtextaccf6 WHERE wtextaccf6.n_policytxt =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL wtextaccf6 THEN
            ASSIGN 
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   = wtextaccf6.n_textacc1
            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  = wtextaccf6.n_textacc2
            SUBSTRING(sic_bran.uwm301.prmtxt,121,60) = wtextaccf6.n_textacc3
            SUBSTRING(sic_bran.uwm301.prmtxt,181,60) = wtextaccf6.n_textacc4
            SUBSTRING(sic_bran.uwm301.prmtxt,241,60) = wtextaccf6.n_textacc5.
        ELSE sic_bran.uwm301.prmtxt = "". 
    END.
    ELSE ASSIGN  sic_bran.uwm301.prmtxt = trim(wdetail.prmtxt).

    IF wdetail.drivnam = "Y"  THEN RUN proc_driver.

    IF wdetail.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
        IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
        IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
        FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
            brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
        IF NOT AVAIL brstat.Detaitem THEN DO:     
            CREATE brstat.Detaitem.
            ASSIGN brStat.Detaitem.Policy = sic_bran.uwm301.Policy
                brStat.Detaitem.RenCnt    = sic_bran.uwm301.RenCnt
                brStat.Detaitem.EndCnt    = sic_bran.uwm301.Endcnt
                brStat.Detaitem.RiskNo    = sic_bran.uwm301.RiskNo
                brStat.Detaitem.ItemNo    = sic_bran.uwm301.ItemNo
                brStat.Detaitem.serailno  = wdetail.stk.  
        END.
    END.
    ASSIGN 
        sic_bran.uwm301.bchyr  = nv_batchyr      /* batch Year */
        sic_bran.uwm301.bchno  = nv_batchno      /* bchno      */
        sic_bran.uwm301.bchcnt = nv_batcnt       /* bchcnt     */
        s_recid4         = RECID(sic_bran.uwm301) .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest2_camp c-Win 
PROCEDURE proc_chktest2_camp :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
    brstat.insure.compno     = fi_camisuzu          AND 
    brstat.insure.Text3      = wdetail.class        AND  
    brstat.insure.vatcode    = wdetail.covcod       AND 
    brstat.insure.Text1      = trim(wdetail.brand)  AND  
    index(trim(wdetail.model),trim(brstat.insure.Text2)) <> 0   AND 
    deci(brstat.insure.Text4) = DECI(wdetail.si)      NO-LOCK  NO-ERROR NO-WAIT.
IF  AVAIL brstat.insure THEN  
    ASSIGN 
    wdetail.uom1_v   = deci(brstat.Insure.LName)  
    wdetail.uom2_v   = deci(brstat.Insure.Addr1)  
    wdetail.uom5_v   = deci(brstat.Insure.Addr2)  
    nv_uom1_v        = deci(brstat.Insure.LName)         
    nv_uom2_v        = deci(brstat.Insure.Addr1)        
    nv_uom5_v        = deci(brstat.Insure.Addr2)        
    nv_41            = deci(brstat.Insure.Addr3)           
    nv_42            = deci(brstat.Insure.Addr4)           
    nv_43            = deci(brstat.Insure.TelNo)    
    nv_baseprm       = deci(brstat.insure.Text5)   
    wdetail.base     = brstat.insure.Text5   
    WDETAIL.NCB      = string(brstat.insure.Deci1) 
    wdetail.dspc     = string(brstat.insure.Deci2) 
    nv_dss_per       = deci(brstat.insure.Deci2) 
    nv_seat41        = deci(brstat.insure.ICAddr1) 
    wdetail.seat41   = deci(brstat.insure.ICAddr1)
    wdetail.seat     = brstat.insure.ICAddr3   .
ELSE nv_baseprm      = 0.  
     */
     
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest3 c-Win 
PROCEDURE proc_chktest3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN  dod1 = 0   dod2 = 0     dpd0 = 0    /*add A64-0138*/
    nv_tariff = sic_bran.uwm301.tariff             
    nv_class  = trim(wdetail.class)        
    nv_comdat = sic_bran.uwm100.comdat               
    nv_engine = DECI(wdetail.engcc)                   
    nv_tons   = deci(wdetail.tonn)                     
    nv_covcod = wdetail.covcod                        
    nv_vehuse = wdetail.vehuse                       
    nv_COMPER = deci(wdetail.comper)                 
    nv_comacc = deci(wdetail.comacc)               
    nv_seats  = INTE(wdetail.seat)                 
    /*nv_tons   = DECI(wdetail.Tonn) */             
    /*nv_dss_per = 0  */                           
    nv_dsspcvar1 = ""                            
    nv_dsspcvar2 = ""                           
    nv_dsspcvar  = ""                             
    nv_42cod     = ""                                
    nv_43cod     = ""                                
    nv_41cod1    = ""                                 
    nv_41cod2    = ""                               
    nv_basecod   = ""                                    
    nv_usecod    = ""                                
    nv_engcod    = ""                                  
    nv_drivcod   = ""                                          
    nv_yrcod     = ""                                          
    nv_sicod     = ""                                          
    nv_grpcod    = ""                                    
    nv_bipcod    = ""                                           
    nv_biacod    = ""                                     
    nv_pdacod    = ""                               
    nv_ncbyrs    = 0                                     
    nv_ncbper    = 0                                  
    /*nv_ncb     =   0*/                                  
    nv_totsi     =  0 .  
IF wdetail.compul = "y" THEN DO:
    ASSIGN nv_comper  = deci(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = deci(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = nv_comper   
        sic_bran.uwm130.uom9_v   = nv_comacc  
        nv_vehuse = "0" . 
    RUN wgs\wgscomp. 
    If  nv_comper  =  0  Then   nv_comacc =  0 . 
    Else do:
        IF   nv_comacc  <> 0  Then do:
            ASSIGN
                nv_compcod      = "COMP"
                nv_compvar1     = "     Compulsory  =   "
                nv_compvar2     = STRING(nv_comacc)
                Substr(nv_compvar,1,30)   = nv_compvar1
                Substr(nv_compvar,31,30)  = nv_compvar2.
            IF n_curbil = "bht" THEN
                nv_comacc = Truncate(nv_comacc, 0).
            ELSE 
                nv_comacc = nv_comacc. 
                ASSIGN
                    sic_bran.uwm130.uom8_c  = "D8"
                    sic_bran.uwm130.uom9_c  = "D9". 
        End.
        Else assign          nv_compprm     = 0
            nv_compcod     = " "
            nv_compvar1    = " "
            nv_compvar2    = " "
            nv_compvar     = " ".
        
        If  nv_compprm  =  0  THEN DO:
            ASSIGN nv_vehuse = "0".     /*A52-0172 ให้ค่า0 เนื่องจากต้องการส่งค่าให้ key.b = 0 */
            RUN wgs\wgscomp.       
        END.
        nv_comacc  = nv_comacc .                  
    End.  /* else do */
    If  nv_comper  =  0 and nv_comacc  =  0 Then  nv_compprm  =  0. 
END. /*compul y*/
ELSE 
    ASSIGN
        nv_compprm     = 0
        nv_compcod     = " "
        nv_compvar1    = " "
        nv_compvar2    = " "
        nv_compvar     = " "
        nv_COMPER      = 0
        nv_comacc      = 0
        sic_bran.uwm130.uom8_v  =  0               
        sic_bran.uwm130.uom9_v  =  0.
/* A63-0169 */
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR 
   (wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" )  THEN RUN proc_base2plus.  
/* end A63-0169 */
ELSE RUN proc_base2.

IF wdetail.poltyp = "v72" THEN DO:
    ASSIGN  nv_baseprm = 0   
      nv_usecod  = "" 
      nv_engcod  = "" 
      nv_drivcod = ""
      nv_yrcod   = "" 
      nv_sicod   = "" 
      nv_grpcod  = "" 
      nv_bipcod  = "" 
      nv_biacod  = "" 
      nv_pdacod   = "" 
      /*nv_class = SUBSTRING(nv_class,2,3)*/   .
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                    nv_class,
                    nv_covcod,
                    nv_key_b,
                    nv_comdat,
                    nv_totsi,
                    nv_uom1_v ,       
                    nv_uom2_v ,       
                    nv_uom5_v ).
END.
ELSE DO:
    RUN proc_calpremt.
    RUN proc_adduwd132prem.
END.



ASSIGN fi_process = "Create data to uwm120 stamp tax ..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
/*IF fi_policymas <> ""   THEN RUN proc_assign_polmas.*/
/*IF      ra_renewby = 1 THEN RUN proc_assign_polexp.
ELSE IF ra_renewby = 2 THEN RUN proc_assign_polmas.*/
/*IF ra_renewby = 2 THEN RUN proc_assign_polmas.*/
RUN proc_uwm100.
RUN proc_uwm120.
RUN proc_uwm301.



END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktest4 c-Win 
PROCEDURE proc_chktest4 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:     
  wdetail.nv_com1p     = nv_com1p70    
 wdetail.n_taxae      = nv_taxae70    
 wdetail.n_stmpae     = nv_stmpae70   
 wdetail.n_com2ae     = nv_com2ae70   
 wdetail.n_com1ae     = nv_com1ae70   
 wdetail.nv_fi_rstp_t = nv_fi_rstp_t70
 wdetail.nv_fi_rtax_t = nv_fi_rtax_t70  
------------------------------------------------------------------------------*/
DEF VAR   n_sigr_r     like sic_bran.uwm130.uom6_v.
DEF VAR   n_gap_r      Like sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r     Like sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm   like sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t      Like sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t     Like sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t     Like sic_bran.uwm100.sigr_p.
DEF VAR   nv_policy    like sic_bran.uwm100.policy.
DEF VAR   nv_rencnt    like sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt    like sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per  like sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per like sicsyac.xmm020.rvstam.
DEF VAR nv_com2p        AS DECI INIT 0.00 .
DEF VAR nv_com1p        AS DECI INIT 0.00 .
DEF VAR nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR nv_fi_stamp_per AS DECI INIT 0.00.
DEF VAR nv_fi_rstp_t    AS INTE INIT 0.
DEF VAR nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR nv_fi_com2_t    AS DECI INIT 0.00.
 ASSIGN fi_process = "Updat to uwm120 stamp tax ..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
FIND sic_bran.uwm100   Where Recid(sic_bran.uwm100)  = s_recid1 no-error no-wait.
  If  not avail sic_bran.uwm100  Then do:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      Return.
  End.
  Else  do:
      Assign 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy  AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt  AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt  AND
                     sic_bran.uwm120.bchyr = nv_batchyr               AND 
                     sic_bran.uwm120.bchno = nv_batchno               AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                     FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND
                              sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                              sic_bran.uwm130.bchno   = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r                = n_sigr_r + uwm130.uom6_v.
                              FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE 
                                       sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                       sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                       sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                       sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                       sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                       sic_bran.uwd132.bchyr = nv_batchyr              AND 
                                       sic_bran.uwd132.bchno = nv_batchno              AND 
                                       sic_bran.uwd132.bchcnt  = nv_batcnt               NO-LOCK.
                                        IF  sic_bran.uwd132.bencod  = "COMP"   THEN
                                             nt_compprm     = nt_compprm + sic_bran.uwd132.prem_c.
                                         n_gap_r  = sic_bran.uwd132.gap_c  + n_gap_r.
                                         n_prem_r = sic_bran.uwd132.prem_c + n_prem_r.
                                 END.  /* uwd132 */
                          END.  /*uwm130 */
                          ASSIGN
                          n_gap_t      = n_gap_t   + n_gap_r
                          n_prem_t     = n_prem_t  + n_prem_r
                          n_sigr_t     = n_sigr_t  + n_sigr_r
                          n_gap_r      = 0 
                          n_prem_r     = 0  
                          n_sigr_r     = 0.
           END.    /* end uwm120 */
  End.  /*  avail  100   */
  /*-------------------- calprem ---------------------*/
  Find LAST  sic_bran.uwm120  Use-index uwm12001  WHERE          
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy   And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt   And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt   AND 
             sic_bran.uwm120.bchyr = nv_batchyr               AND 
             sic_bran.uwm120.bchno = nv_batchno               AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt                No-error.
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             substr(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN 
            Assign     nv_com1p = sicsyac.xmm018.commsp  
                       nv_com2p = 0.
  ELSE DO:
          Find sicsyac.xmm031  Use-index xmm03101  Where  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp
          No-lock no-error no-wait.
          IF not  avail sicsyac.xmm031 Then 
            Assign     nv_com1p = 0
                       nv_com2p = 0.
          Else  
            Assign     nv_com1p = sicsyac.xmm031.comm1
                       nv_com2p = 0 .
  END. 
  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      ASSIGN nv_com2p = 0 
          nv_com2p = DECI(wdetail.commission).
  END. /* Wdetail.Compul = "Y"*/
  /*--------- tax -----------*/
  Find sicsyac.xmm020 Use-index xmm02001        Where
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   And
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   No-lock no-error.
  IF avail sicsyac.xmm020 Then do:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam.
       If    sic_bran.uwm100.gstrat  <>  0  Then  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       Else  nv_fi_tax_per  =  sicsyac.xmm020.rvtax.
  End.
  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = Yes Then do: 
       /* STAMP */ 
                  nv_fi_rstp_t  = Truncate(sic_bran.uwm120.prem_r * nv_fi_stamp_per / 100,0) +
                      (IF     (sic_bran.uwm120.prem_r * nv_fi_stamp_per / 100)   -
                     Truncate(sic_bran.uwm120.prem_r  * nv_fi_stamp_per / 100,0) > 0
                     Then 1 Else 0).
    
  End.
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
     
  IF  sic_bran.uwm120.taxae   = Yes   Then do:                       /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm120.prem_r + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
     /* MESSAGE "sic_bran.uwm120.prem_r  "  sic_bran.uwm120.prem_r
              "nv_fi_rstp_t + "          nv_fi_rstp_t         
              "sic_bran.uwm100.pstp  "    sic_bran.uwm100.pstp  
              "nv_fi_tax_per  "          nv_fi_tax_per     VIEW-AS ALERT-BOX.    */
       /* fi_taxae       = Yes.*/
  End.
  sic_bran.uwm100.rtax_t = nv_fi_rtax_t.
  sic_bran.uwm120.com1ae = YES.
  sic_bran.uwm120.com2ae = YES.
  /*--------- motor commission -----------------*/
 
  IF sic_bran.uwm120.com1ae   = Yes  Then do:                   /* MOTOR COMMISION */
     If sic_bran.uwm120.com1p <> 0  Then nv_com1p  = sic_bran.uwm120.com1p.
     ASSIGN 
         nv_com1p = wdetail.commission     /*  ให้ค่า  com1A = wdetail.commission */
         nv_com1p = DECI(wdetail.commission).

     nv_fi_com1_t   =  - (sic_bran.uwm120.prem_r - nt_compprm) * nv_com1p / 100.            
         /*fi_com1ae        =  YES.*/
  End.
  /*----------- comp comission ------------*/
  IF sic_bran.uwm120.com2ae   = Yes  Then do:                   /* Comp.COMMISION */
      If sic_bran.uwm120.com2p <> 0  Then nv_com2p  = 0.00.
         /* nv_com2p  = sic_bran.uwm120.com2p.*/
           nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              
         /*nv_fi_com2ae        =  YES.*/
  End.
  IF sic_bran.uwm100.pstp <> 0 Then do:
     IF sic_bran.uwm100.no_sch  = 1 Then NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 Then  NV_fi_dup_trip = "T".
  End.
  Else  NV_fi_dup_trip  =  "".
  nv_fi_netprm = sic_bran.uwm120.prem_r + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.
  Find     sic_bran.uwm100 Where  Recid(sic_bran.uwm100)  =  s_recid1.
  If avail sic_bran.uwm100 Then 
      Assign 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  =  nv_fi_com1_t
           sic_bran.uwm100.com2_t  =  nv_fi_com2_t
           sic_bran.uwm100.pstp    =  0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  =  nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  =  nv_fi_rtax_t          
           sic_bran.uwm100.gstrat  =  nv_fi_tax_per.
  IF wdetail.poltyp = "v72" THEN 
            ASSIGN  
           sic_bran.uwm100.com2_t  = 0 
           sic_bran.uwm100.com1_t  = nv_fi_com2_t.
  Find     sic_bran.uwm120 Where  Recid(sic_bran.uwm120)   =  s_recid2   .
  IF avail sic_bran.uwm120 Then do:
       Assign
           sic_bran.uwm120.gap_r    = n_gap_t    /*n_gap_r */
           sic_bran.uwm120.prem_r   = n_prem_t   /*n_prem_r */
           sic_bran.uwm120.sigr     = n_sigr_T   /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
           sic_bran.uwm120.rtax     = nv_fi_rtax_t
           sic_bran.uwm120.taxae    = YES
           sic_bran.uwm120.stmpae   = YES
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t            
           sic_bran.uwm120.com1ae   = YES
           sic_bran.uwm120.com1p    = nv_com1p
           sic_bran.uwm120.com1_r   = nv_fi_com1_t
           sic_bran.uwm120.com2ae   = YES
           sic_bran.uwm120.com2p    = nv_com2p
           sic_bran.uwm120.com2_r   = nv_fi_com2_t.
        IF wdetail.poltyp = "v72" THEN 
           ASSIGN  
           sic_bran.uwm120.com2_r    = 0 
           sic_bran.uwm120.com1_r    = nv_fi_com2_t
           sic_bran.uwm120.com1p     = nv_com2p
           sic_bran.uwm120.com2p     = 0
           sic_bran.uwm120.rstp_r   = nv_fi_rstp_t 
           sic_bran.uwm120.rtax     = nv_fi_rtax_t.
  End.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 c-Win 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
Create  sic_bran.uwm100.    /*Create ฝั่ง gateway*/    
ASSIGN                                              
       sic_bran.uwm100.policy =  wdetail.policy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
       sic_bran.uwm100.rencnt =  n_rencnt   
       sic_bran.uwm100.renno  =  ""       
       sic_bran.uwm100.endcnt =  n_Endcnt
       sic_bran.uwm100.bchyr  =  nv_batchyr 
       sic_bran.uwm100.bchno  =  nv_batchno 
       sic_bran.uwm100.bchcnt =  nv_batcnt     .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create70_addmat c-Win 
PROCEDURE proc_create70_addmat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*nv_addr1
  nv_addr1 
  nv_addr2 
  nv_addr3 
  nv_addr4 */
  IF nv_addr1 <> "" THEN DO:
      /*city */
      IF r-INDEX(nv_addr1,"กรุงเทพ")  <> 0 THEN DO:
          ASSIGN nv_addr4  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"กรุงเทพ"))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"กรุงเทพ") - 1 )).
      END.
      ELSE IF R-INDEX(nv_addr1,"กทม") <> 0 THEN DO:
          ASSIGN nv_addr4  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"กทม"))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"กทม") - 1 )).
      END.
      ELSE IF R-INDEX(nv_addr1,"จ.")  <> 0 THEN DO:
          ASSIGN nv_addr4  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"จ."))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"จ.") - 1 )).
      END.
      ELSE IF R-INDEX(nv_addr1,"จังหวัด")  <> 0 THEN DO:
          ASSIGN nv_addr4  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"จังหวัด"))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"จังหวัด") - 1 )).
      END.
      /*อำเภอ*/
      IF R-INDEX(nv_addr1,"เขต")  <> 0 THEN DO:
          ASSIGN nv_addr3  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"เขต"))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"เขต") - 1 )).
      END.
      ELSE IF R-INDEX(nv_addr1,"อำเภอ") <> 0 THEN DO:
          ASSIGN nv_addr3  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"อำเภอ"))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"อำเภอ") - 1 )).
      END.
      ELSE IF R-INDEX(nv_addr1,"อ.")  <> 0 THEN DO:
          ASSIGN nv_addr3  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"อ."))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"อ.") - 1 )).
      END.
      /*ตำบล*/
      IF R-INDEX(nv_addr1,"แขวง")  <> 0 THEN DO:
          ASSIGN nv_addr2  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"แขวง"))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"แขวง") - 1 )).
      END.
      ELSE IF R-INDEX(nv_addr1,"ตำบล") <> 0 THEN DO:
          ASSIGN nv_addr2  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"ตำบล"))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"ตำบล") - 1 )).
      END.
      ELSE IF R-INDEX(nv_addr1,"ต.")  <> 0 THEN DO:
          ASSIGN nv_addr2  = trim(SUBSTR(nv_addr1,R-INDEX(nv_addr1,"ต."))) 
                 nv_addr1  = trim(SUBSTR(nv_addr1,1,R-INDEX(nv_addr1,"ต.") - 1 )).
      END.
      IF LENGTH(nv_addr1) > 35 THEN DO:
          IF r-INDEX(nv_addr1," ") <> 0 THEN DO:
              IF LENGTH(substr(nv_addr1,r-INDEX(nv_addr1," ")) + " " +  nv_addr2) <= 35   THEN
                  ASSIGN  
                  nv_addr2 = trim(substr(nv_addr1,r-INDEX(nv_addr1," "))) + " " +  nv_addr2
                  nv_addr1 = trim(substr(nv_addr1,1,r-INDEX(nv_addr1," "))).
              ELSE ASSIGN 
                  nv_addr4 = trim(nv_addr3 + " " + nv_addr4)
                  nv_addr3 = nv_addr2 
                  nv_addr2 = trim(substr(nv_addr1,r-INDEX(nv_addr1," "))) 
                  nv_addr1 = trim(substr(nv_addr1,1,r-INDEX(nv_addr1," ")))  .

          END.
      END.
      ELSE IF LENGTH(nv_addr2 + " " + nv_addr3) <= 35 THEN 
          ASSIGN nv_addr2 = trim(nv_addr2 + " " + nv_addr3)
                 nv_addr3 = nv_addr4 
                 nv_addr4 = "".
      ELSE IF LENGTH(nv_addr3 + " " + nv_addr4) <= 35 THEN 
          ASSIGN nv_addr3 = trim(nv_addr3 + " " + nv_addr4)
                 nv_addr4 = "".
      /*MESSAGE 
        LENGTH(nv_addr1)    nv_addr1  SKIP
        LENGTH(nv_addr2)    nv_addr2  SKIP
        LENGTH(nv_addr3)    nv_addr3  SKIP
        LENGTH(nv_addr4)    nv_addr4  SKIP VIEW-AS ALERT-BOX.*/

      
  END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create72_amanh c-Win 
PROCEDURE proc_create72_amanh :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* comment by A63-0168...
ASSIGN 
    nv_policy72 = ""
    nv_policy72 =  "0AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 ) .

FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy72)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(nv_policy72)                                                      
        wdetail.cr_2        = "1AMA" + SUBSTRING(trim(nv_nchassis),LENGTH(trim(nv_nchassis))  - 8 )                 
        wdetail.poltyp      = "V72" 
        wdetail.prepol      = ""
        wdetail.n_branch    =  TRIM(nv_brname) 
        wdetail.covcod      = "T"                   /*compulsary*/
        wdetail.fristdat    = trim(nv_comdat70)
        wdetail.comdat      = trim(nv_comdat70)                
        wdetail.expdat      = trim(nv_expdat70) 
        wdetail.tiname      = IF trim(nv_title) = "" THEN  "คุณ"  ELSE trim(nv_title)                        
        wdetail.insnam      = TRIM(nv_name1) 
        wdetail.nv_icno     = TRIM(nv_icno) 
        wdetail.datbirth    = TRIM(nv_datbirth)             
        wdetail.datbirthexp = TRIM(nv_datbirthexp) 
        
        wdetail.inserf      = ""                      
        wdetail.promoti     = ""    
        /*wdetail.dealerno    = ""*/
        wdetail.name2       = TRIM(nv_name2)  
        wdetail.n_addr1     = TRIM(nv_addr1)                            
        wdetail.n_addr2     = TRIM(nv_addr2)                         
        wdetail.n_addr3     = TRIM(nv_addr3)                         
        wdetail.n_addr4     = trim(TRIM(nv_addr4) + " " + trim(nv_post))
        wdetail.brand       = TRIM(nv_nbrand)        /*  9   ยี่ห้อ - รุ่น   */             
        wdetail.model       = TRIM(nv_nmodel)  
        wdetail.engno       = trim(nv_nengno)
        wdetail.chassis     = trim(nv_nchassis)
        wdetail.engcc       = STRING(nv_egcc)
        wdetail.caryear     = trim(nv_ncaryear) 
        wdetail.vehreg      = trim(nv_nvehreg)
        wdetail.garage      = ""
        wdetail.si          = trim(nv_SUMINSURED)      
        wdetail.fi          = trim(nv_SUMINSURED) 
        wdetail.benname     = ""   
        wdetail.vehuse      = "1"            
        wdetail.class       = IF      TRIM(nv_ckcover) = "1"   THEN fi_pack1 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2"   THEN fi_pack2 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3"   THEN fi_pack3 + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2.1" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "2.2" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3.1" THEN fi_pack2plus + nv_ckclass
                              ELSE IF TRIM(nv_ckcover) = "3.2" THEN fi_pack2plus + nv_ckclass
                              ELSE ""
        wdetail.seat        = IF      trim(nv_ckclass) = "110" THEN "7" 
                              ELSE IF trim(nv_ckclass) = "210" THEN "12"
                              ELSE IF trim(nv_ckclass) = "320" THEN "3" 
                              ELSE "7"  
        wdetail.uom1_v      = fi_tpbip                   
        wdetail.uom2_v      = fi_tpbiac                  
        wdetail.uom5_v      = fi_tppda 
        wdetail.nv_41       = fi_ap01                                       
        wdetail.nv_42       = fi_ap02                                              
        wdetail.nv_43       = fi_ap03                              
        wdetail.base        = "0"
        wdetail.ncb         = "0"
        wdetail.commission  = fi_commision72  
             
        wdetail.prmtxt      = ""
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)                    
        wdetail.n_rencnt    = 0                                 
        wdetail.n_endcnt    = 0                                         
        wdetail.drivnam     = "N"
        wdetail.tariff      = "X"
        wdetail.compul      = "y"
        wdetail.pass        = "Y".
END.
..end A63-0168..*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutcharpol c-Win 
PROCEDURE proc_cutcharpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
IF trim(nv_policy) <> ""  THEN DO:
    ASSIGN 
        nv_c = trim(nv_policy)
        nv_i = 0
        nv_l = LENGTH(nv_c).
    DO WHILE nv_i <= nv_l:
        ind = 0.
        ind = INDEX(nv_c,"/").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"\").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"-").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c," ").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        nv_i = nv_i + 1.
    END.
    ASSIGN nv_policy = nv_c .
END. 
/*
IF trim(nv_policy72) <> ""  THEN DO:
    ASSIGN 
        nv_c = trim(nv_policy72)
        nv_i = 0
        nv_l = LENGTH(nv_c).
    DO WHILE nv_i <= nv_l:
        ind = 0.
        ind = INDEX(nv_c,"/").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"\").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"-").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c," ").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        nv_i = nv_i + 1.
    END.
    ASSIGN nv_policy72 = nv_c .
END. 
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cutrenpol c-Win 
PROCEDURE proc_cutrenpol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_i AS INT.
DEF VAR nv_c AS CHAR.
DEF VAR nv_l AS INT.
DEF VAR nv_p AS CHAR.
DEF VAR ind AS INT.
IF trim(nv_prepol70) <> ""  THEN DO:
    ASSIGN 
        nv_c = trim(nv_prepol70)
        nv_i = 0
        nv_l = LENGTH(nv_c).
    DO WHILE nv_i <= nv_l:
        ind = 0.
        ind = INDEX(nv_c,"/").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"\").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"-").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c," ").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        nv_i = nv_i + 1.
    END.
    ASSIGN nv_prepol70 = nv_c .
END. 
/*
IF trim(nv_prepol7072) <> ""  THEN DO:
    ASSIGN 
        nv_c = trim(nv_prepol7072)
        nv_i = 0
        nv_l = LENGTH(nv_c).
    DO WHILE nv_i <= nv_l:
        ind = 0.
        ind = INDEX(nv_c,"/").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"\").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c,"-").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        ind = INDEX(nv_c," ").
        IF ind <> 0 THEN DO:
            nv_c = TRIM (SUBSTRING(nv_c,1,ind - 1) + SUBSTRING(nv_c,ind + 1, nv_l)).
        END.
        nv_i = nv_i + 1.
    END.
    ASSIGN nv_prepol7072 = nv_c .
END. 
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_definitionbk c-Win 
PROCEDURE proc_definitionbk :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*comment by  Kridtiya i. A63-0472 Date. 09/11/2020  เก็บ ของเดิมไว้ดังนี้
{wgw\wgwtamnh.i}      /*ประกาศตัวแปร*/
DEFINE NEW SHARED VAR nv_riskno     Like  sicuw.uwm301.riskgp.
DEFINE NEW SHARED VAR nv_itemno     Like  sicuw.uwm301.itemno. 
DEFINE STREAM  ns1.                 
DEFINE STREAM  ns2.                 
DEFINE STREAM  ns3.                 
DEFINE VAR            nv_uom1_v     AS INTE INIT 0. 
DEFINE VAR            nv_uom2_v     AS INTE INIT 0. 
DEFINE VAR            nv_uom5_v     AS INTE INIT 0. 
DEFINE VAR            chkred        AS logi INIT NO.
DEFINE SHARED Var     n_User        As CHAR .
DEFINE SHARED Var     n_PassWd      As CHAR .    
DEFINE VAR            nv_comper     AS DECI INIT 0.                
DEFINE VAR            nv_comacc     AS DECI INIT 0.                
DEFINE NEW SHARED VAR nv_seat41     AS INTEGER   FORMAT ">>9".
DEFINE NEW SHARED VAR nv_totsi      AS DECIMAL   FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_polday     AS INTE      FORMAT ">>9".
DEFINE New SHARED VAR nv_uom6_u     as char.                
DEFINE VAR            nv_chk        as  logic.
DEFINE VAR            nv_ncbyrs     AS INTE.    
DEFINE NEW SHARED VAR nv_odcod      AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_cons       AS CHAR      FORMAT "X(2)".
/*DEFINE NEW SHARED VAR nv_baseprm    AS DECI      FORMAT ">>,>>>,>>9.99-".******/
DEFINE NEW SHARED VAR no_baseprm AS DECI  FORMAT ">>,>>>,>>9.99-".  
DEFINE New shared VAR nv_prem       AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_baseap     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE New shared VAR nv_ded        AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_gapprm     AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_pdprm      AS DECI      FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_prvprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_41prm      AS INTEGER   FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_ded1prm    AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_aded1prm   AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_ded2prm    AS INTEGER   FORMAT ">>>,>>9-"        INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_dedod      AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_addod      AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_dedpd      AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_prem1      AS DECIMAL   FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_addprm     AS INTEGER   FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO.
DEFINE NEW SHARED VAR nv_totded     AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_totdis     AS INTEGER   FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO.
DEFINE New SHARED VAR nv_41cod1     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_41cod2     AS CHARACTER FORMAT "X(4)".
DEFINE New SHARED VAR nv_41         AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE New SHARED VAR nv_411prm     AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR nv_412prm     AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE New SHARED VAR nv_411var1    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_411var2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_411var     AS CHAR      FORMAT "X(60)".
DEFINE New SHARED VAR nv_412var1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_412var2    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_412var     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_42cod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_42         AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE New SHARED VAR nv_42prm      AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE NEW SHARED VAR nv_42var1     AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_42var2     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_42var      AS CHAR      FORMAT "X(60)".
DEFINE New SHARED VAR nv_43cod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_43         AS INTEGER   FORMAT ">>>,>>>,>>9".
DEFINE New SHARED VAR nv_43prm      AS DECI      FORMAT ">,>>>,>>9.99".
DEFINE New SHARED VAR nv_43var1     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_43var2     AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_43var      AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_campcod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_camprem    AS DECI      FORMAT ">>>9".
DEFINE New SHARED VAR nv_campvar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_campvar2   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_campvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_compcod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_compprm    AS DECI      FORMAT ">>>,>>9.99-".
DEFINE New SHARED VAR nv_compvar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_compvar2   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_compvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_basecod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_baseprm    AS DECI      FORMAT ">>,>>>,>>9.99-". 
DEFINE New SHARED VAR nv_basevar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_basevar2   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_basevar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_cl_cod     AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_cl_per     AS DECIMAL   FORMAT ">9.99".
DEFINE New SHARED VAR nv_lodclm     AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE VAR            nv_lodclm1    AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE New SHARED VAR nv_clmvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_clmvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_clmvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_stf_cod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_stf_per    AS DECIMAL   FORMAT ">9.99".
DEFINE New SHARED VAR nv_stf_amt    AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_stfvar1    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_stfvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_stfvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_dss_cod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_dss_per    AS DECIMAL   FORMAT ">9.99".
DEFINE New SHARED VAR nv_dsspc      AS INTEGER   FORMAT ">>>,>>9.99-".
DEFINE NEW SHARED VAR nv_dsspcvar1  AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_dsspcvar2  AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_dsspcvar   AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_ncb_cod    AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_ncbper     LIKE sicuw.uwm301.ncbper.
DEFINE New SHARED VAR nv_ncb        AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_ncbvar1    AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_ncbvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_ncbvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_flet_cod   AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_flet_per   AS DECIMAL   FORMAT ">>9".
DEFINE New SHARED VAR nv_flet       AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_fletvar1   AS CHAR      FORMAT "X(30)".
DEFINE New SHARED VAR nv_fletvar2   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_fletvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_vehuse     LIKE sicuw.uwm301.vehuse.                 
DEFINE NEW SHARED VAR nv_grpcod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_grprm      AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_grpvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_grpvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_grpvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_othcod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_othprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_othvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_othvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_othvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_dedod1_cod AS CHAR      FORMAT "X(4)".             
DEFINE NEW SHARED VAR nv_dedod1_prm AS DECI      FORMAT ">,>>>,>>9.99-".    
DEFINE NEW SHARED VAR nv_dedod1var1 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod1var2 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod1var  AS CHAR      FORMAT "X(60)".            
DEFINE NEW SHARED VAR nv_dedod2_cod AS CHAR      FORMAT "X(4)".             
DEFINE NEW SHARED VAR nv_dedod2_prm AS DECI      FORMAT ">,>>>,>>9.99-".    
DEFINE NEW SHARED VAR nv_dedod2var1 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod2var2 AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedod2var  AS CHAR      FORMAT "X(60)".            
DEFINE NEW SHARED VAR nv_dedpd_cod  AS CHAR      FORMAT "X(4)".             
DEFINE NEW SHARED VAR nv_dedpd_prm  AS DECI      FORMAT ">,>>>,>>9.99-".    
DEFINE NEW SHARED VAR nv_dedpdvar1  AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedpdvar2  AS CHAR      FORMAT "X(30)".            
DEFINE NEW SHARED VAR nv_dedpdvar   AS CHAR      FORMAT "X(60)".            
DEFINE NEW SHARED VAR nv_tariff     LIKE sicuw.uwm301.tariff.
DEFINE NEW SHARED VAR nv_comdat     LIKE sicuw.uwm100.comdat.
DEFINE NEW SHARED VAR nv_covcod     LIKE sicuw.uwm301.covcod.
DEFINE NEW SHARED VAR nv_class      AS CHAR      FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_key_b      AS DECIMAL   FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEFINE NEW SHARED VAR nv_drivno     AS INT       .  
DEFINE NEW SHARED VAR nv_drivcod    AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_drivprm    AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_drivvar1   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_drivvar2   AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_drivvar    AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_usecod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_useprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_usevar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_usevar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_usevar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_sicod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_siprm      AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_sivar1     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_sivar2     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_sivar      AS CHAR      FORMAT "X(60)".
DEFINE New shared var nv_uom6_c     as char.     /* Sum  si*/
DEFINE New shared var nv_uom7_c     as char.     /* Fire/Theft*/
DEFINE NEW SHARED VAR nv_bipcod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_bipprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_bipvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_bipvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_bipvar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_biacod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_biaprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_biavar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_biavar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_biavar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_pdacod     AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_pdaprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_pdavar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_pdavar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_pdavar     AS CHAR      FORMAT "X(60)".
DEFINE NEW SHARED VAR nv_engine     LIKE sicsyac.xmm102.engine.
DEFINE NEW SHARED VAR nv_tons       LIKE sicsyac.xmm102.tons.
DEFINE NEW SHARED VAR nv_seats      LIKE sicsyac.xmm102.seats.
DEFINE NEW SHARED VAR nv_sclass     AS CHAR      FORMAT "x(3)".
DEFINE NEW SHARED VAR nv_engcod     AS CHAR      FORMAT "x(4)".
DEFINE NEW SHARED VAR nv_engprm     AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_engvar1    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_engvar2    AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_engvar     AS CHAR      FORMAT "X(60)".
DEFINE VAR            NO_CLASS      AS CHAR      INIT   "".
DEFINE VAR            no_tariff     AS CHAR      INIT   "".
DEFINE New shared var nv_poltyp     as char      init   "".
DEFINE NEW SHARED VAR nv_yrcod      AS CHARACTER FORMAT "X(4)".
DEFINE NEW SHARED VAR nv_yrprm      AS DECI      FORMAT ">>,>>>,>>9.99-".
DEFINE NEW SHARED VAR nv_yrvar1     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_yrvar2     AS CHAR      FORMAT "X(30)".
DEFINE NEW SHARED VAR nv_yrvar      AS CHAR      FORMAT "X(60)".
DEFINE New shared VAR nv_caryr      AS INTE      FORMAT ">>>9" .
DEFINE NEW SHARED VAR s_recid1      as RECID .     /* uwm100  */
DEFINE NEW SHARED VAR s_recid2      as recid .     /* uwm120  */
DEFINE NEW SHARED VAR s_recid3      as recid .     /* uwm130  */  
DEFINE NEW SHARED VAR s_recid4      as recid .     /* uwm301  */                                    
DEFINE New shared var nv_dspc       as deci.
DEFINE New shared var nv_mv1        as int .
DEFINE New shared var nv_mv1_s      as int . 
DEFINE New shared var nv_mv2        as int . 
DEFINE New shared var nv_mv3        as int . 
DEFINE New shared var nv_comprm     as int .  
DEFINE New shared var nv_model      as char.  
/*DEFINE VAR            nv_lnumber    AS INTE INIT 0. 
DEFINE VAR            nv_provi      AS CHAR INIT "".
DEFINE VAR            n_rencnt      LIKE sicuw.uwm100.rencnt INITIAL "".
DEFINE VAR            nv_index      as   int  init  0. 
DEFINE VAR            n_endcnt      LIKE sicuw.uwm100.endcnt  INITIAL "".
DEFINE VAR            n_comdat      LIKE sicuw.uwm100.comdat  NO-UNDO.
DEFINE VAR            n_policy      LIKE sicuw.uwm100.policy  INITIAL "" .
DEFINE VAR            nv_daily      AS  CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR            nv_reccnt     AS  INT  INIT  0.           /*all load record*/
DEFINE VAR            nv_completecnt    AS   INT   INIT  0.     /*complete record */*/
DEFINE NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".   
DEFINE NEW SHARED var nv_modulo   as int  format "9".
/*
DEFINE VAR            s_riskgp    AS INTE FORMAT ">9".
DEFINE VAR            s_riskno    AS INTE FORMAT "999".
DEFINE VAR            s_itemno    AS INTE FORMAT "999". 
DEFINE VAR            nv_drivage1 AS INTE INIT 0.
DEFINE VAR            nv_drivage2 AS INTE INIT 0.
DEFINE VAR            nv_drivbir1 AS CHAR INIT "".
DEFINE VAR            nv_drivbir2 AS CHAR INIT "".
DEFINE VAR            nv_dept     as char format  "X(1)".*/
DEFINE NEW SHARED var nv_branch   AS CHAR FORMAT "x(3)" .  
/*
DEFINE VAR nv_undyr    as    char  init  ""    format   "X(4)".
DEFINE VAR n_newpol    Like  sicuw.uwm100.policy  init  "".
DEFINE VAR n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.*/
DEFINE New shared  var      nv_makdes    as   char    .
DEFINE New shared  var      nv_moddes    as   char.
/*
DEFINE VAR nv_lastno   As       Int.
DEFINE VAR nv_seqno    As       Int.
DEFINE VAR sv_xmm600   AS       RECID.
DEFINE VAR nv_stm_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_tax_per  AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_com1_per AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEFINE VAR nv_com1_prm AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
DEFINE VAR s_130bp1    AS RECID                            NO-UNDO.
DEFINE VAR s_130fp1    AS RECID                            NO-UNDO.
DEFINE VAR nvffptr     AS RECID                            NO-UNDO.
DEFINE VAR n_rd132     AS RECID                            NO-UNDO.
DEFINE VAR nv_gap      AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_fptr     AS RECID.
DEFINE VAR nv_bptr     AS RECID.
DEFINE VAR nv_nptr     AS RECID.
DEFINE VAR nv_gap2     AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_prem2    AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_rstp     AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_rtax     AS DECIMAL                          NO-UNDO.
DEFINE VAR nv_key_a    AS DECIMAL INITIAL 0                NO-UNDO.
DEFINE VAR nv_rec100   AS RECID .
DEFINE VAR nv_rec120   AS RECID .
DEFINE VAR nv_rec130   AS RECID .
DEFINE VAR nv_rec301   AS RECID .
DEF VAR nv_simat   AS DECI.    /* A57-0186 */
DEF VAR nv_simat1  AS DECI.    /* A57-0186 */
DEF VAR nv_result  AS CHAR FORMAT "x(255)" . /*A62-0445*/
*/
/*A63-0169*/
DEF WORKFILE wcampaign NO-UNDO 
    FIELD  campno  AS CHAR FORMAT "x(20)"    INIT ""
    FIELD  id      AS CHAR FORMAT "x(5)"    INIT ""  
    FIELD  cover   AS CHAR FORMAT "x(3)"    INIT ""  
    FIELD  pack    AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD  bi      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd1     AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd2     AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n41      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n42      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  n43      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  nname    AS CHAR FORMAT "x(25)"    INIT "" 
    FIELD  garage   AS CHAR FORMAT "x(2)"  INIT "" .
/* end A63-0169*/

end comment by  Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname...*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_driver c-Win 
PROCEDURE proc_driver :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF  TRIM(wdetail.drivnam) = "Y"  THEN DO :      /*note add 07/11/2005*/
 DEF VAR nv_drivbir1 AS CHAR FORMAT "9999".
 DEF VAR nv_drivbir2 AS CHAR FORMAT "9999".
 
 DEF VAR no_policy AS CHAR FORMAT "x(20)" .
 DEF VAR no_rencnt AS CHAR FORMAT "99".
 DEF VAR no_endcnt AS CHAR FORMAT "999".
 
 DEF VAR no_riskno AS CHAR FORMAT "999".
 DEF VAR no_itemno AS CHAR FORMAT "999".

  no_policy = sic_bran.uwm301.policy .
  no_rencnt = STRING(sic_bran.uwm301.rencnt,"99") .
  no_endcnt = STRING(sic_bran.uwm301.endcnt,"999") .

  no_riskno = "001".
  no_itemno = "001".
  wdetail.bdatedri1  = string(date(wdetail.bdatedri1),"99/99/9999") .
  wdetail.bdatedri2  = string(date(wdetail.bdatedri2),"99/99/9999") .
  
  nv_drivage1 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.bdatedri1,7,4)) - 543) .
  nv_drivage2 =  YEAR(TODAY) - (INT(SUBSTR(wdetail.bdatedri2,7,4)) - 543) .
 
  IF wdetail.bdatedri1 <> " "  AND wdetail.drivnam1 <> " " THEN DO: /*note add & modified*/
     nv_drivbir1       = STRING(INT(SUBSTR(bdatedri1,7,4))).
     wdetail.bdatedri1 = SUBSTR(bdatedri1,1,6) + nv_drivbir1.
  END.

  IF wdetail.bdatedri2 <>  " " AND wdetail.drivnam2 <> " " THEN DO: /*note add & modified */
     nv_drivbir2      = STRING(INT(SUBSTR(wdetail.bdatedri2,7,4))).
     wdetail.bdatedri2 = SUBSTR(wdetail.bdatedri2,1,6) + nv_drivbir2.
  END.
  
  FIND  LAST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
               brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
               brstat.mailtxt_fil.bchyr   = nv_batchyr   AND                                               
               brstat.mailtxt_fil.bchno   = nv_batchno   AND
               brstat.mailtxt_fil.bchcnt  = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
        IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                                      


        FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                     brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
                     brstat.mailtxt_fil.lnumber = nv_lnumber    AND
                     brstat.mailtxt_fil.bchyr = nv_batchyr    AND                                               
                     brstat.mailtxt_fil.bchno = nv_batchno    AND
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
                     
        IF NOT AVAIL brstat.mailtxt_fil   THEN DO:

              CREATE brstat.mailtxt_fil.
              ASSIGN                                           
                     brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                     brstat.mailtxt_fil.lnumber   = nv_lnumber.
                     brstat.mailtxt_fil.ltext     = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)). 
                     brstat.mailtxt_fil.ltext2    = wdetail.bdatedri1 + "  " 
                                                  + string(nv_drivage1).
                     nv_drivno                    = 1.
                     ASSIGN /*a490166*/
                     brstat.mailtxt_fil.bchyr = nv_batchyr 
                     brstat.mailtxt_fil.bchno = nv_batchno 
                     brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                     SUBSTRING(brstat.mailtxt_fil.ltext,51,6)    = TRIM(wdetail.sexdriv1)
                     SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri1)
                     SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno1) /*เลขบัตร ปชช. */
                     SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".

              IF wdetail.drivnam2 <> "" THEN DO:
                    CREATE brstat.mailtxt_fil. 
                    ASSIGN
                        brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
                        brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                        brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)) 
                        brstat.mailtxt_fil.ltext2   = wdetail.bdatedri2 + "  "
                                                    + string(nv_drivage2) 
                        nv_drivno                   = 2.
                        ASSIGN /*a490166*/
                        brstat.mailtxt_fil.bchyr = nv_batchyr 
                        brstat.mailtxt_fil.bchno = nv_batchno 
                        brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                        SUBSTRING(brstat.mailtxt_fil.ltext,51,6)    = TRIM(wdetail.sexdriv2)
                        SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri2)
                        SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno2) /*เลขบัตร ปชช. */
                        SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".  
              END.  /*drivnam2 <> " " */
        END. /*End Avail Brstat*/
        ELSE  DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN  brstat.mailtxt_fil.policy     = wdetail.policy + string(sic_bran.uwm100.rencnt) + string(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
                      brstat.mailtxt_fil.lnumber    = nv_lnumber
                      brstat.mailtxt_fil.ltext      = wdetail.drivnam1 + FILL(" ",30 - LENGTH(wdetail.drivnam1)) 
                      brstat.mailtxt_fil.ltext2     = wdetail.bdatedri1 + "  " 
                                                    +  TRIM(string(nv_drivage1)).
                       ASSIGN 
                       brstat.mailtxt_fil.bchyr = nv_batchyr 
                       brstat.mailtxt_fil.bchno = nv_batchno 
                       brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                       SUBSTRING(brstat.mailtxt_fil.ltext,51,6)    = TRIM(wdetail.sexdriv1)
                       SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri1)
                       SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno1) /*เลขบัตร ปชช. */
                       SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".


                      IF wdetail.drivnam2 <> "" THEN DO:
                            CREATE  brstat.mailtxt_fil.
                                ASSIGN
                                brstat.mailtxt_fil.policy   = wdetail.policy + string(uwm100.rencnt) + string(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                                brstat.mailtxt_fil.lnumber  = nv_lnumber + 1
                                brstat.mailtxt_fil.ltext    = wdetail.drivnam2 + FILL(" ",30 - LENGTH(wdetail.drivnam2)) 
                                brstat.mailtxt_fil.ltext2   = wdetail.bdatedri2 + "  "
                                                            + TRIM(string(nv_drivage2)).
                                ASSIGN /*a490166*/
                                brstat.mailtxt_fil.bchyr = nv_batchyr 
                                brstat.mailtxt_fil.bchno = nv_batchno 
                                brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                                SUBSTRING(brstat.mailtxt_fil.ltext,51,6)   = TRIM(wdetail.sexdriv1)
                               SUBSTRING(brstat.mailtxt_fil.ltext2,16,40)  = TRIM(wdetail.occupdri1)
                               SUBSTRING(brstat.mailtxt_fil.ltext2,101,50) = TRIM(wdetail.driveno1) /*เลขบัตร ปชช. */
                               SUBSTRING(brstat.mailtxt_fil.ltext2,151,50) = "".
                      END. /*drivnam2 <> " " */
        END. /*Else DO*/
 END. /*note add for mailtxt 07/11/2005*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam c-Win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  
    /*wdetail.datbirth     = replace(wdetail.datbirth,"/","")    
    wdetail.datbirthexp  = replace(wdetail.datbirthexp,"/","")  */
    n_insref    = ""  
    nv_usrid    = ""
    nv_transfer = NO
    n_check     = ""
    nv_insref   = ""
    nv_typ      = ""
    nv_usrid    = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer = YES.
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME   = TRIM(wdetail.insnam)    AND 
    sicsyac.xmm600.homebr = TRIM(wdetail.n_branch)  AND
    sicsyac.xmm600.clicod = "IN"                    NO-ERROR  .  
IF NOT AVAILABLE sicsyac.xmm600 THEN DO:                            
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO
            n_insref = sicsyac.xmm600.acno.
        RETURN.
    END.
    ELSE DO:
        ASSIGN n_check = "" 
            nv_insref  = "".
        IF TRIM(wdetail.tiname) <> " " THEN DO: 
            IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
        END.
        ELSE DO:  /* ---- Check ด้วย name ---- */
            IF  R-INDEX(TRIM(wdetail.tiname),"จก.")             <> 0  OR              
                R-INDEX(TRIM(wdetail.tiname),"จำกัด")           <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"(มหาชน)")         <> 0  OR  
                R-INDEX(TRIM(wdetail.tiname),"INC.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"CO.")             <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LTD.")            <> 0  OR 
                R-INDEX(TRIM(wdetail.tiname),"LIMITED")         <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บริษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บ.")                <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หจก.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"หสน.")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"บรรษัท")            <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"มูลนิธิ")           <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้าง")              <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
                INDEX(TRIM(wdetail.tiname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(TRIM(wdetail.tiname),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".  /*0s= บุคคลธรรมดา Cs = นิติบุคคล */
        END.
        RUN proc_insno. 
        IF n_check <> "" THEN DO:
            ASSIGN  nv_transfer = NO
                nv_insref   = "".
            RETURN.
        END.
        loop_runningins:  /* Check Insured  */
        REPEAT:
            FIND sicsyac.xmm600 USE-INDEX xmm60001    WHERE
                sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm600 THEN DO:
                RUN proc_insno .
                IF  n_check <> ""  THEN DO:   
                    ASSIGN nv_transfer = NO
                        nv_insref   = "".
                    RETURN.
                END.
            END.
            ELSE LEAVE loop_runningins.
        END.
        IF nv_insref <> "" THEN CREATE sicsyac.xmm600.   
    END.
    ASSIGN n_insref = nv_insref.
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:
        ASSIGN
        wdetail.inserf          = caps(TRIM(sicsyac.xmm600.acno))
        nv_insref               = sicsyac.xmm600.acno 
        n_insref                = nv_insref 
        nv_transfer             = NO 
        sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.nv_icno)     /*IC No.*//*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.n_addr1)     /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.n_addr2)     /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.n_addr3)     /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.n_addr4)     
        sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch)    /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid 
        sicsyac.xmm600.telex    = trim(wdetail.phone) .      /*Telex No.*/        /*a61-0386*/
        
        /*wdetail.datbirth    = TRIM(nv_datbirth)   
        wdetail.datbirthexp = TRIM(nv_datbirthexp)*/
    IF wdetail.datbirth    <> "" THEN DO: 
        IF wdetail.datbirthexp <> "" THEN 
             ASSIGN sicsyac.xmm600.dval20  = "DOB" + wdetail.datbirth  +    "|EXP" + wdetail.datbirthexp.
        ELSE ASSIGN sicsyac.xmm600.dval20  = "DOB" + wdetail.datbirth .
    END.
    ELSE  IF wdetail.datbirthexp <> "" THEN  ASSIGN sicsyac.xmm600.dval20    = "EXP" + wdetail.datbirthexp.
    ELSE  ASSIGN sicsyac.xmm600.dval20  = "".
    END.
END.
IF nv_transfer = YES THEN DO:
    IF nv_insref  <> "" THEN  DO:
     
        ASSIGN 
        wdetail.inserf          = caps(TRIM(nv_insref))
        sicsyac.xmm600.acno     = nv_insref                 /*Account no*/
        sicsyac.xmm600.gpstcs   = nv_insref                 /*Group A/C for statistics*/
        sicsyac.xmm600.gpage    = ""                        /*Group A/C for ageing*/
        sicsyac.xmm600.gpstmt   = ""                        /*Group A/C for Statement*/
        sicsyac.xmm600.or1ref   = ""                        /*OR Agent 1 Ref. No.*/
        sicsyac.xmm600.or2ref   = ""                        /*OR Agent 2 Ref. No.*/
        sicsyac.xmm600.or1com   = 0                         /*OR Agent 1 Comm. %*/
        sicsyac.xmm600.or2com   = 0                         /*OR Agent 2 Comm. %*/
        sicsyac.xmm600.or1gn    = "G"                       /*OR Agent 1 Gross/Net*/
        sicsyac.xmm600.or2gn    = "G"                       /*OR Agent 2 Gross/Net*/
        sicsyac.xmm600.ntitle   = TRIM(wdetail.tiname)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = TRIM(wdetail.insnam)      /*Name Line 1*/
        sicsyac.xmm600.abname   = TRIM(wdetail.insnam)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.nv_icno)      /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = TRIM(wdetail.n_addr1)      /*Address line 1*/
        sicsyac.xmm600.addr2    = TRIM(wdetail.n_addr2)      /*Address line 2*/
        sicsyac.xmm600.addr3    = TRIM(wdetail.n_addr3)      /*Address line 3*/
        sicsyac.xmm600.addr4    = TRIM(wdetail.n_addr4)      /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = TRIM(wdetail.n_branch)      /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                     /*Date A/C opened*/
        sicsyac.xmm600.prindr   = 1                         /*No. to print Dr/Cr N., default*/
        sicsyac.xmm600.langug   = ""                        /*Language Code*/
        sicsyac.xmm600.cshdat   = ?                         /*Cash terms wef date*/
        sicsyac.xmm600.legal    = ""                        /*Legal action pending/closed*/
        sicsyac.xmm600.stattp   = "I"                       /*Statement type I/B/N*/
        sicsyac.xmm600.autoap   = NO                        /*Automatic cash matching*/
        sicsyac.xmm600.ltcurr   = "BHT"                     /*Credit limit currency*/
        sicsyac.xmm600.ltamt    = 0                         /*Credit limit amount*/
        sicsyac.xmm600.exec     = ""                        /*Executive responsible*/
        sicsyac.xmm600.cntry    = "TH"                      /*Country code*/
        sicsyac.xmm600.phone    = ""                        /*Phone no.*/
        sicsyac.xmm600.closed   = ?                         /*Date A/C closed*/
        sicsyac.xmm600.crper    = 0                         /*Credit period*/
        sicsyac.xmm600.pvfeq    = 0                         /*PV frequency/Type code*/
        sicsyac.xmm600.comtab   = 1                         /*Commission table no*/
        sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid                 /*Userid*/
        sicsyac.xmm600.regagt   = ""                       /*Registered agent code*/
        sicsyac.xmm600.agtreg   = ""                       /*Agents Registration/Licence No*/
        sicsyac.xmm600.debtyn   = YES                      /*Permit debtor trans Y/N*/
        sicsyac.xmm600.crcon    = NO                       /*Credit Control Report*/
        sicsyac.xmm600.muldeb   = NO                       /*Multiple Debtors Acc.*/
        sicsyac.xmm600.styp20   = ""                       /*Statistic Type Codes (4 x 20)*/
        sicsyac.xmm600.sval20   = ""                       /*Statistic Value Codes (4 x 20)*/
        sicsyac.xmm600.dtyp20   = ""                       /*Type of Date Codes (2 X 20)*/
        sicsyac.xmm600.dval20   = ""                       /*Date Values (8 X 20)*/
        sicsyac.xmm600.iblack   = ""                       /*Insured Black List Code*/
        sicsyac.xmm600.oldic    = ""                       /*Old IC No.*/
        sicsyac.xmm600.cardno   = ""                       /*Credit Card Account No.*/
        sicsyac.xmm600.cshcrd   = ""                       /*Cash(C)/Credit(R) Agent*/
        sicsyac.xmm600.naddr1   = ""                       /*New address line 1*/
        sicsyac.xmm600.gstreg   = ""                       /*GST Registration No.*/
        sicsyac.xmm600.naddr2   = ""                       /*New address line 2*/
        sicsyac.xmm600.fax      = ""                       /*Fax No.*/
        sicsyac.xmm600.naddr3   = ""                       /*New address line 3*/
        /*sicsyac.xmm600.telex    = ""                        /*Telex No.*/ */  /*a61-0386*/
        sicsyac.xmm600.telex    = trim(wdetail.phone)      /*Telex No.*/        /*a61-0386*/
        sicsyac.xmm600.naddr4   = ""                       /*New address line 4*/
        sicsyac.xmm600.name2    = ""                       /*Name Line 2*/
        sicsyac.xmm600.npostcd  = ""                       /*New postal code*/
        sicsyac.xmm600.name3    = ""                       /*Name Line 3*/
        sicsyac.xmm600.nphone   = ""                       /*New phone no.*/    
        sicsyac.xmm600.nachg    = YES                      /*Change N&A on Renewal/Endt*/
        sicsyac.xmm600.regdate  = ?                        /*Agents registration Date*/
        sicsyac.xmm600.alevel   = 0                        /*Agency Level*/
        sicsyac.xmm600.taxno    = ""                       /*Agent tax no.*/
        sicsyac.xmm600.anlyc1   = ""                       /*Analysis Code 1*/
        sicsyac.xmm600.taxdate  = ?                        /*Agent tax date*/
        sicsyac.xmm600.anlyc5   =  ""                      /*Analysis Code 5*/
        sicsyac.xmm600.dtyp20   = ""
        sicsyac.xmm600.dval20   = "" .

    IF wdetail.datbirth    <> "" THEN DO: 
        IF wdetail.datbirthexp <> "" THEN 
             ASSIGN sicsyac.xmm600.dval20  = "DOB" + wdetail.datbirth  +    "|EXP" + wdetail.datbirthexp.
        ELSE ASSIGN sicsyac.xmm600.dval20  = "DOB" + wdetail.datbirth .
    END.
    ELSE  IF wdetail.datbirthexp <> "" THEN  ASSIGN sicsyac.xmm600.dval20    = "EXP" + wdetail.datbirthexp.
    ELSE  ASSIGN sicsyac.xmm600.dval20  = "".
    END.
END.
IF sicsyac.xmm600.acno <> ""  THEN DO:
    ASSIGN nv_insref   = sicsyac.xmm600.acno
        wdetail.inserf = caps(TRIM(nv_insref)).
    nv_transfer = YES.
    FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
        IF LOCKED sicsyac.xtm600 THEN DO:
            nv_transfer = NO.
            RETURN.
        END.
        ELSE DO:
            IF nv_insref <> "" THEN  CREATE sicsyac.xtm600.
        END.
    END.
    IF nv_transfer = YES THEN DO:
        IF nv_insref <> "" THEN  
            ASSIGN
            wdetail.inserf         = caps(TRIM(nv_insref))
            sicsyac.xtm600.acno    = nv_insref               /*Account no.*/
            sicsyac.xtm600.name    = TRIM(wdetail.insnam)    /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = TRIM(wdetail.insnam)    /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = TRIM(wdetail.n_addr1)   /*address line 1*/
            sicsyac.xtm600.addr2   = TRIM(wdetail.n_addr2)   /*address line 2*/
            sicsyac.xtm600.addr3   = TRIM(wdetail.n_addr3)   /*address line 3*/
            sicsyac.xtm600.addr4   = TRIM(wdetail.n_addr4)   /*address line 4*/
            sicsyac.xtm600.name2   = ""                      /*Name of Insured Line 2*/
            sicsyac.xtm600.ntitle  = TRIM(wdetail.tiname)    /*Title*/
            sicsyac.xtm600.name3   = ""                      /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = ""  .                   /*First Name*/
            
    END.
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
RETURN.
HIDE MESSAGE NO-PAUSE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam2 c-Win 
PROCEDURE proc_insnam2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Add by Kridtiya i. A63-0472*/
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  nv_insref  NO-ERROR NO-WAIT.  
IF AVAIL sicsyac.xmm600 THEN
    ASSIGN
    sicsyac.xmm600.acno_typ  = trim(wdetail.insnamtyp)   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
    sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
    sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
    sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
    sicsyac.xmm600.icno      = trim(wdetail.nv_icno)       
    sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
    sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
    sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
    sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
    /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/   .  
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN
    ASSIGN 
    sicsyac.xtm600.postcd    = trim(wdetail.postcd)        
    sicsyac.xtm600.firstname = trim(wdetail.firstName)     
    sicsyac.xtm600.lastname  = trim(wdetail.lastName)  .   
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xtm600.
/*Add by Kridtiya i. A63-0472*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno c-Win 
PROCEDURE proc_insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_search   AS LOGICAL INIT YES .
DEF VAR nv_lastno  AS INT. 
DEF VAR nv_seqno   AS INT.  
ASSIGN nv_insref = "" .

FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ          AND
    sicsyac.xzm056.branch   =  wdetail.n_branch  NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp   =  nv_typ
            sicsyac.xzm056.branch   =  wdetail.n_branch
            sicsyac.xzm056.des      =  "Personal/Start"
            sicsyac.xzm056.lastno   =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref     =    wdetail.n_branch   + String(1,"999999999") /*String(1,"999999")*/ /*A64-0150*/
            nv_lastno  =    1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:   
            /*comment by Kridtiya i. A56-0323....
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + wdetail.n_branch + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       wdetail.n_branch + STRING(sicsyac.xzm056.lastno + 1 ,"999999").
            end....comment by Kridtiya i. A56-0323....*/
            /*add by Kridtiya i. A56-0323....*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                     nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999999") /*STRING(sicsyac.xzm056.lastno,"999999")*/ /*A64-0150*/.
            END. 
            /*add by Kridtiya i. A56-0323....*/
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  wdetail.n_branch
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").*/
            /*kridtiya i. A56-0323*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (wdetail.n_branch = "A") OR (wdetail.n_branch = "B") THEN DO:
                    nv_insref  = "7" + wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (wdetail.n_branch = "A") OR (wdetail.n_branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref =        wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999999"). /*STRING(sicsyac.xzm056.lastno,"99999").*/ /*A64-0150*/
            END.   /*kridtiya i. A56-0323*/
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  wdetail.n_branch
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.n_branch + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       wdetail.n_branch + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*add by Kridtiya i. A56-0323....*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END. 
            ELSE DO:
                IF (TRIM(wdetail.n_branch) = "A") OR (TRIM(wdetail.n_branch) = "B") THEN DO:
                    nv_insref = "7" + TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999999"). /*STRING(sicsyac.xzm056.lastno,"999999").*/ /*a64-0150*/
            END.   
            /*add by Kridtiya i. A56-0323....*/
        END.
    END.
    ELSE DO:
        IF LENGTH(wdetail.n_branch) = 2 THEN
            nv_insref = wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            /* IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       wdetail.n_branch + "C" + String(sicsyac.xzm056.lastno,"99999").*/
            /*add by Kridtiya i. A56-0323....*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (wdetail.n_branch = "A") OR (wdetail.n_branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref = "0" + wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
            END.
            ELSE DO:
                IF (wdetail.n_branch = "A") OR (wdetail.n_branch = "B") THEN DO:
                     nv_insref = "7" + wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"9999999").
                END.
                ELSE nv_insref=        wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999999"). /*STRING(sicsyac.xzm056.lastno,"99999").*/ /*A64-0150*/
            END.  /*add by Kridtiya i. A56-0323....*/
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    ASSIGN  wdetail.pass     = "N"                                                                         /* A64-0150*/
            wdetail.comment  = wdetail.comment + "| รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว/ติดต่อผู้ตั้ง Code"   /* A64-0150*/
            n_check = "ERROR".
    RETURN. 
END.         /*lastno > seqno*/                       
ELSE DO :    /*lastno <= seqno */
    IF nv_typ = "0s" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  wdetail.n_branch
                sicsyac.xzm056.des       =  "Personal/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno.   
        END.
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  wdetail.n_branch
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
END.        /*lastno <= seqno */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mataddress c-Win 
PROCEDURE proc_mataddress :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
nv_addr1           /*  บ้านเลขที่   */
nv_addr2           /*  ตำบล/แขวง    */
nv_addr3           /*  อำเภอ/เขต    */
nv_addr4           /*  จังหวัด      */
nv_post            /*  รหัสไปรษณีย์ */
*/
/*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
RUN proc_assign2addr (INPUT  nv_addr2   
                     ,INPUT  nv_addr3  
                     ,INPUT  nv_addr4 
                     ,INPUT  nv_occup  
                     ,OUTPUT nv_codeocc   
                     ,OUTPUT nv_codeaddr1 
                     ,OUTPUT nv_codeaddr2 
                     ,OUTPUT nv_codeaddr3 ).
RUN proc_matchtypins (INPUT  nv_title
                     ,INPUT  nv_name1
                     ,OUTPUT nv_insnamtyp
                     ,OUTPUT nv_firstName 
                     ,OUTPUT nv_lastName).
/*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/

IF INDEX(trim(nv_addr4),"กทม")  <> 0 OR 
   INDEX(trim(nv_addr4),"กรุงเทพ")  <> 0  THEN DO:
    ASSIGN nv_addr2  = "แขวง" +  trim(nv_addr2)
           nv_addr3  = "เขต"  +  trim(nv_addr3)
           nv_addr4  =           trim(nv_addr4) .
END.
ELSE DO:
   /* comment by Ranu : A61-0386...
    ASSIGN nv_addr2  = "ตำบล"     +  trim(nv_addr2)
           nv_addr3  = "อำเภอ"    +  trim(nv_addr3)
           nv_addr4  = "จังหวัด"  +  trim(nv_addr4) .
   ... end A61-0386....*/
     ASSIGN nv_addr2  = "ต." +  trim(nv_addr2)
            nv_addr3  = "อ." +  trim(nv_addr3)
            nv_addr4  = "จ." +  trim(nv_addr4) .
END.

IF INDEX(nv_addr1,"หมู่ที่")  <> 0 THEN nv_addr1 = trim(REPLACE(nv_addr1,"หมู่ที่","ม.")) .
IF INDEX(nv_addr1,"หมู่บ้าน") <> 0 THEN nv_addr1 = trim(REPLACE(nv_addr1,"หมู่บ้าน","มบ.")) .
IF INDEX(nv_addr1,"ซอย")      <> 0 THEN nv_addr1 = trim(REPLACE(nv_addr1,"ซอย","ซ.")) .
IF INDEX(nv_addr1,"ถนน")      <> 0 THEN nv_addr1 = trim(REPLACE(nv_addr1,"ถนน","ถ.")) .

loop_chk1:
REPEAT:
    IF LENGTH(TRIM(nv_addr1)) > 35  THEN DO:
        IF r-INDEX(nv_addr1," ") <> 0 THEN 
            ASSIGN  
            nv_addr2 = trim(substr(nv_addr1,r-INDEX(nv_addr1," "))) + " " +  nv_addr2
            nv_addr1 = trim(substr(nv_addr1,1,r-INDEX(nv_addr1," "))).
        ELSE  LEAVE loop_chk1.
    END.  /*loop_chk1:*/
    ELSE  LEAVE loop_chk1.
END.

loop_chk2:
REPEAT:
    IF LENGTH(TRIM(nv_addr2)) > 35  THEN DO:
        IF r-INDEX(nv_addr2," ") <> 0 THEN 
            ASSIGN  
            nv_addr3 = trim(substr(nv_addr2,r-INDEX(nv_addr2," "))) + " " +  nv_addr3
            nv_addr2 = trim(substr(nv_addr2,1,r-INDEX(nv_addr2," "))).
        ELSE  LEAVE loop_chk2.
    END.
    ELSE  LEAVE loop_chk2.
END.

loop_chk3:
REPEAT:
    IF LENGTH(TRIM(nv_addr3)) > 35  THEN DO:
        IF r-INDEX(nv_addr3," ") <> 0 THEN 
            ASSIGN  
            nv_addr4 = trim(substr(nv_addr3,r-INDEX(nv_addr3," "))) + " " +  nv_addr4
            nv_addr3 = trim(substr(nv_addr3,1,r-INDEX(nv_addr3," "))).
        ELSE  LEAVE loop_chk3.
    END.  /*loop_chk1:*/
    ELSE  LEAVE loop_chk3.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchfilepol c-Win 
PROCEDURE proc_matchfilepol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
    For each  wdetail2 :
        DELETE  wdetail2.
    END.
    RUN proc_assinginit.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            nv_number          /*  ลำดับที่     */
            nv_senddate        /* วันที่แจ้ง     */
            nv_policy          /* เลขรับแจ้งงาน */
            /*nv_prepol70        /*A61-0386*/*/ /*A64-0138*/
            nv_comname         /*  รหัสบรษัท    */
            nv_sendby          /*  ชื่อผู้แจ้ง  */
            nv_brname          /*  สาขา */
            nv_covercar        /*  ประเภทประกัน */
            nv_covertypecar    /*       ประเภทรถ        */
            nv_cover           /*       ประเภทความคุ้มครอง      */
            nv_coverfree       /*       ประกัน แถม/ไม่แถม       */
            nv_compfree        /*       พรบ.   แถม/ไม่แถม       */
            nv_comdat70        /*       วันเริ่มคุ้มครอง        */
            nv_expdat70        /*  วันสิ้นสุดความคุ้มครอง       */
            nv_title           /*  คำนำหน้าชื่อ */
            nv_name1           /*  ชื่อผู้เอาประกัน     */
            nv_icno            /*  เลขที่บัตรประชาชน    */
            nv_datbirth        /*  วันเกิด      */
            nv_datbirthexp     /*  วันที่บัตรหมดอายุ    */
            nv_occup           /*  อาชีพ        */
            nv_name2           /*  ชื่อกรรมการ  */
            nv_addr1           /*  บ้านเลขที่   */
            nv_addr2           /*  ตำบล/แขวง    */
            nv_addr3           /*  อำเภอ/เขต    */
            nv_addr4           /*  จังหวัด      */
            nv_post            /*  รหัสไปรษณีย์ */
            nv_phone           /*  เบอร์โทรศัพท์        */
            nv_driverno        /*  ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่       */
            nv_driname1        /*  ผู้ขับขี่คนที่1      */
            nv_driname1gen     /*  เพศ  */
            nv_driname1birth   /*  วันเกิด      */
            nv_driname1occup   /*  อาชัพ        */
            nv_driname1number  /*  เลขที่ใบขับขี่       */
            nv_driname2        /*  ผู้ขับขี่คนที่2      */
            nv_driname2gen     /*  เพศ  */
            nv_driname2birth   /*  วันเกิด      */
            nv_driname2occup   /*  อาชัพ        */
            nv_driname2number  /*  เลขที่ใบขับขี่       */
            nv_nbrand          /*  ชื่อยี่ห้อรถ */
            nv_nmodel          /*  รุ่นรถ       */
            nv_nengno          /*  เลขเครื่องยนต์       */
            nv_nchassis        /*  เลขตัวถัง    */
            nv_nengcc          /*  ซีซี */
            nv_ncaryear        /*  ปีรถยนต์     */
            nv_nvehreg         /*  เลขทะเบียน   */
            nv_nvehreg2        /*  จังหวัดที่จดทะเบียน  */
            nv_garage          /*  การซ่อม      */
            nv_SUMINSURED      /*  ทุนประกัน    */
            nv_npremt          /*  เบี้ยสุทธิ   */
            nv_npremtnet       /*  เบี้ยประกัน  */
            nv_npremtcomp      /*  เบี้ยพรบ.    */
            nv_npremtotle      /*  เบี้ยรวม พรบ.        */
            nv_stkno           /*  เลขสติ๊กเกอร์        */
            nv_vatname         /*  ออกใบเสร็จในนาม      */
            nv_bennam          /*  ผู้รับผลประโยชน์     */
            nv_remak           /*  หมายเหตุ             */
            /*nv_prepol70 */ /*A61-0389*/
            nv_ispno  
            nv_ckclass       /*a61-0386*/
            nv_producer      /*a61-0386*/
            nv_agent         /*a61-0386*/
            nv_result     .  /*A62-0445*/

        IF  (INDEX(nv_number,"ที่")         <> 0 ) OR (INDEX(nv_number,"ลำดับที่") <> 0 ) OR  
            (INDEX(nv_number,"No")          <> 0 ) OR (INDEX(nv_number,"แบบ")      <> 0 ) OR 
            (INDEX(nv_number,"เรียน")       <> 0 ) OR (INDEX(nv_number,"ดีลเลอร์") <> 0 ) OR
            (INDEX(nv_number,"ชื่อผู้แจ้ง") <> 0 ) OR (TRIM(nv_number)   = "" )  OR
            (INDEX(nv_number,"ลำดับที่")    <> 0 )     THEN RUN proc_assinginit. 
        ELSE RUN proc_assignmatpol.
        
        RUN proc_assinginit. 
       
    END.       /* repeat   */
    RUN proc_outputfile.
END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchtypins c-Win 
PROCEDURE proc_matchtypins :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER  np_title      as char init "".
DEFINE INPUT  PARAMETER  np_name1      as char init "".
DEFINE OUTPUT PARAMETER  np_insnamtyp  as char init "".
DEFINE OUTPUT PARAMETER  np_firstName  as char init "".
DEFINE OUTPUT PARAMETER  np_lastName   as char init "".
DEFINE VAR               np_textname   AS CHAR INIT "".
ASSIGN np_textname = TRIM(np_title) + TRIM(np_name1).

IF  R-INDEX(TRIM(np_textname),"จก.")             <> 0  OR              
    R-INDEX(TRIM(np_textname),"จำกัด")           <> 0  OR  
    R-INDEX(TRIM(np_textname),"(มหาชน)")         <> 0  OR  
    R-INDEX(TRIM(np_textname),"INC.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"CO.")             <> 0  OR 
    R-INDEX(TRIM(np_textname),"LTD.")            <> 0  OR 
    R-INDEX(TRIM(np_textname),"LIMITED")         <> 0  OR 
    INDEX(TRIM(np_textname),"บริษัท")            <> 0  OR 
    INDEX(TRIM(np_textname),"บ.")                <> 0  OR 
    INDEX(TRIM(np_textname),"บจก.")              <> 0  OR 
    INDEX(TRIM(np_textname),"หจก.")              <> 0  OR 
    INDEX(TRIM(np_textname),"หสน.")              <> 0  OR 
    INDEX(TRIM(np_textname),"บรรษัท")            <> 0  OR 
    INDEX(TRIM(np_textname),"มูลนิธิ")           <> 0  OR 
    INDEX(TRIM(np_textname),"ห้าง")              <> 0  OR 
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วน")      <> 0  OR 
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
    INDEX(TRIM(np_textname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
    INDEX(TRIM(np_textname),"และ/หรือ")          <> 0  THEN DO: 
    /*  Cs = นิติบุคคล */
    ASSIGN
    np_insnamtyp   = "CO"
    np_firstName   = TRIM(np_name1)
    np_lastName    = "".
     
END.
ELSE DO:
    np_insnamtyp   = "PR".
    IF INDEX(trim(np_name1)," ") <> 0 THEN
        ASSIGN
        np_firstName  = substr(TRIM(np_name1),1,INDEX(trim(np_name1)," ")) 
        np_lastName   = substr(TRIM(np_name1),INDEX(trim(np_name1)," ")) .
    ELSE ASSIGN       
        np_firstName  = TRIM(np_name1)
        np_lastName   = "".          

END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matcomdat c-Win 
PROCEDURE proc_matcomdat :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_chkcomdat AS CHAR INIT "" .
DEF VAR nv_chkexpdat AS CHAR INIT "" .
DEF VAR nv_year2     AS INTE INIT 0 .

ASSIGN 
    nv_chkcomdat = ""
    nv_chkexpdat = ""
    nv_year2     = inte(substr(string(YEAR(TODAY)),3,2))
    nv_chkcomdat = trim(nv_comdat70)    
    nv_chkexpdat = trim(nv_expdat70)   .

IF nv_chkcomdat <> "" THEN DO:
    ASSIGN nv_chkcomdat = Trim(SUBSTR(nv_chkcomdat,R-INDEX(nv_chkcomdat,"/") + 1)).
    IF LENGTH(nv_chkcomdat) = 2 THEN DO:
        IF      (DECI(nv_chkcomdat) - nv_year2 ) = 43 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 43 ),"99"). 
        ELSE IF (DECI(nv_chkcomdat) - nv_year2 ) = 42 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 43 ),"99"). 
        ELSE IF (DECI(nv_chkcomdat) - nv_year2 ) = 41 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 43 ),"99"). 
        ELSE IF (DECI(nv_chkcomdat) - nv_year2 ) = 44 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 43 ),"99"). 
        ASSIGN nv_chkcomdat = string(inte(substr(string(YEAR(TODAY)),1,2)),"99") + nv_chkcomdat.


    END. 
    ELSE DO: /*length 4*/
        IF      (DECI(nv_chkcomdat) - YEAR(TODAY)) = 543 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 543 ),"9999"). 
        ELSE IF (DECI(nv_chkcomdat) - YEAR(TODAY)) = 542 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 543 ),"9999"). 
        ELSE IF (DECI(nv_chkcomdat) - YEAR(TODAY)) = 541 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 543 ),"9999"). 
        ELSE IF (DECI(nv_chkcomdat) - YEAR(TODAY)) = 544 THEN ASSIGN nv_chkcomdat = STRING((DECI(nv_chkcomdat) - 543 ),"9999"). 
    END.
    ASSIGN nv_comdat70 = Trim(SUBSTR(nv_comdat70,1,R-INDEX(nv_comdat70,"/"))) + nv_chkcomdat.
END.
IF nv_chkexpdat <> "" THEN DO:

    ASSIGN nv_chkexpdat = Trim(SUBSTR(nv_chkexpdat,R-INDEX(nv_chkexpdat,"/") + 1)).

    IF LENGTH(nv_chkexpdat) = 2 THEN DO:
        IF      (DECI(nv_chkexpdat) - nv_year2 ) = 43 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 43 ),"99"). 
        ELSE IF (DECI(nv_chkexpdat) - nv_year2 ) = 42 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 43 ),"99"). 
        ELSE IF (DECI(nv_chkexpdat) - nv_year2 ) = 41 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 43 ),"99"). 
        ELSE IF (DECI(nv_chkexpdat) - nv_year2 ) = 44 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 43 ),"99"). 
        ASSIGN nv_chkexpdat = string(inte(substr(string(YEAR(TODAY)),1,2)),"99") + nv_chkexpdat.


    END. 
    ELSE DO: /*length 4*/

        IF      (DECI(nv_chkexpdat) - YEAR(TODAY)) = 543 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 543 ),"9999"). 
        ELSE IF (DECI(nv_chkexpdat) - YEAR(TODAY)) = 542 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 543 ),"9999"). 
        ELSE IF (DECI(nv_chkexpdat) - YEAR(TODAY)) = 541 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 543 ),"9999"). 
        ELSE IF (DECI(nv_chkexpdat) - YEAR(TODAY)) = 544 THEN ASSIGN nv_chkexpdat = STRING((DECI(nv_chkexpdat) - 543 ),"9999"). 
    END.
    ASSIGN nv_expdat70 = Trim(SUBSTR(nv_expdat70,1,R-INDEX(nv_expdat70,"/"))) + nv_chkexpdat.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open c-Win 
PROCEDURE proc_open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y".

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_outputfile c-Win 
PROCEDURE proc_outputfile :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
def var nv_cnt        as int    init 0.
def var nv_row        as int    init 0.
DEF VAR np_polnew     AS CHAR  FORMAT "x(16)"  INIT "".
DEF VAR np_polnew72   AS CHAR  FORMAT "x(16)" INIT "".
DEF VAR np_comdat     AS CHAR  FORMAT "x(15)"  INIT "" .
If  substr(fi_output1,length(fi_output1) - 3,4) <> ".slk" THEN fi_output1 =  Trim(fi_output1) + ".slk"  .
nv_cnt   =   0.
nv_row  =  1.
OUTPUT STREAM ns2 TO VALUE(fi_output1).
PUT STREAM ns2 "ID;PND" SKIP.

PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'    "ลำดับที่"                          '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'    "วันที่แจ้ง"                        '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'    "เลขกรมธรรม์70"                     '"' SKIP.
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'    "เลขกรมธรรม์72"                     '"' SKIP.
/*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'    "เลขที่กรมธรรม์เดิม"                '"' SKIP. */  /*A64-0138*/
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'    "รหัสบรษัท"                         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'    "ชื่อผู้แจ้ง"                       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'    "สาขา"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'    "ประเภทประกัน"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'    "ประเภทรถ"                          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'    "ประเภทความคุ้มครอง"                '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'    "ประกัน แถม/ไม่แถม"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'    "พรบ.   แถม/ไม่แถม"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'    "วันเริ่มคุ้มครอง"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'    "วันสิ้นสุดความคุ้มครอง"            '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'    "คำนำหน้าชื่อ"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'    "ชื่อผู้เอาประกัน"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'    "เลขที่บัตรประชาชน"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'    "วันเกิด"                           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'    "วันที่บัตรหมดอายุ"                 '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'    "อาชีพ"                             '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'    "ชื่อกรรมการ"                       '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'    "บ้านเลขที่"                        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'    "ตำบล/แขวง"                         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'    "อำเภอ/เขต"                         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'    "จังหวัด"                           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'    "รหัสไปรษณีย์"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'    "เบอร์โทรศัพท์"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'    "ระบุผู้ขับขี่/ไม่ระบุผู้ขับขี่"    '"' SKIP.  
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'    "ผู้ขับขี่คนที่1"                   '"' SKIP.       
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'    "เพศ"                               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'    "วันเกิด"                           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'    "อาชัพ"                             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'    "เลขที่ใบขับขี่"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'    "ผู้ขับขี่คนที่2"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'    "เพศ"                               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'    "วันเกิด"                           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'    "อาชัพ"                             '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'    "เลขที่ใบขับขี่"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'    "ชื่อยี่ห้อรถ"                      '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'    "รุ่นรถ"                            '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'    "เลขเครื่องยนต์"                    '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'    "เลขตัวถัง"                         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'    "ซีซี"                              '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'    "ปีรถยนต์"                          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'    "เลขทะเบียน"                        '"' SKIP.   
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'    "จังหวัดที่จดทะเบียน"               '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'    "การซ่อม"                           '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'    "ทุนประกัน"                         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'    "เบี้ยสุทธิ"                        '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'    "เบี้ยประกัน"                       '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'    "เบี้ยพรบ."                         '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'    "เบี้ยรวม พรบ."                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'    "เลขสติ๊กเกอร์"                     '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'    "ออกใบเสร็จในนาม"                   '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'    "ผู้รับผลประโยชน์"                  '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'    "หมายเหตุ"                          '"' SKIP. 
PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'    "เลขตรวจสภาพ"                       '"' SKIP.  
                                    
FOR EACH wdetail2  NO-LOCK.                      
    ASSIGN 
        np_comdat   = ""    /*A61-0386*/
        np_polnew   = ""    /*A61-0386*/
        np_polnew72 = ""    /*A61-0386*/
        nv_cnt      =  nv_cnt + 1 
        nv_row      =  nv_row + 1  .
   /* comment by : Ranu I. A61-0386 date 14/08/2018....
   IF wdetail2.wk_nchassis <> "" THEN DO:
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
          sicuw.uwm301.cha_no  =  wdetail2.wk_nchassis   AND 
            SUBSTR(sicuw.uwm301.policy,3,2) = "70"         NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL sicuw.uwm301 THEN DO: 
             
             FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL sicuw.uwm100 THEN DO:
                 IF sicuw.uwm100.expdat > TODAY THEN np_polnew =  sicuw.uwm100.policy.
             END.
        END.
        ELSE np_polnew = "".
        FIND LAST sicuw.uwm301 USE-INDEX uwm30121 WHERE
          sicuw.uwm301.cha_no  =  wdetail2.wk_nchassis   AND 
            SUBSTR(sicuw.uwm301.policy,3,2) = "72"         NO-LOCK NO-ERROR NO-WAIT .
        IF AVAIL sicuw.uwm301 THEN DO: 
             
             FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = sicuw.uwm301.policy NO-LOCK NO-ERROR NO-WAIT.
             IF AVAIL sicuw.uwm100 THEN DO:
                 IF sicuw.uwm100.expdat > TODAY THEN np_polnew72 =  sicuw.uwm100.policy.
             END.
        END.
        ELSE np_polnew72 = "".
        
    END.
    .... end A61-0386....*/

    IF wdetail2.wk_policy <> ""  THEN DO:
        
         FIND LAST  sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                    sicuw.uwm100.cedpol = TRIM(wdetail2.wk_policy) AND 
                    sicuw.uwm100.poltyp = "V70"  NO-LOCK NO-ERROR .
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN  np_comdat = ""                                           
                        np_comdat = STRING(sicuw.uwm100.comdat,"99/99/9999").
            
                IF DATE(np_comdat) = DATE(wdetail2.wk_comdat70) THEN DO: 
                    ASSIGN np_polnew = sicuw.uwm100.policy
                           np_polnew72 = sicuw.uwm100.cr_2.
                END.
                ELSE ASSIGN np_polnew = "".
            END.
         IF index(wdetail2.wk_npremtcomp,"ไม่เอาพรบ") = 0 AND np_polnew72 = "" THEN DO:

             FIND LAST  sicuw.uwm100 USE-INDEX uwm10002 WHERE 
                    sicuw.uwm100.cedpol = TRIM(wdetail2.wk_policy) AND 
                    sicuw.uwm100.poltyp = "V72"  NO-LOCK NO-ERROR .
            IF AVAIL sicuw.uwm100 THEN DO:
                ASSIGN  np_comdat = ""                                           
                        np_comdat = STRING(sicuw.uwm100.comdat,"99/99/9999").
            
                IF DATE(np_comdat) = DATE(wdetail2.wk_comdat70) THEN ASSIGN np_polnew72 = sicuw.uwm100.policy.                      
                ELSE ASSIGN np_polnew72 = "".
            
            END.
         END.

     FIND LAST brstat.tlt USE-INDEX tlt06  WHERE         /*add A55-0267*/
                brstat.tlt.cha_no       = trim(wdetail2.wk_nchassis)   AND
                brstat.tlt.eng_no       = TRIM(wdetail2.wk_nengno)    AND
                brstat.tlt.genusr       = "Amanah"                NO-ERROR NO-WAIT .
        IF AVAIL brstat.tlt THEN DO:
           ASSIGN 
                  brstat.tlt.nor_noti_ins =   np_polnew    /*เบอร์ใหม่ */            
                  brstat.tlt.comp_pol     =   np_polnew72  /*เบอร์ พรบ.  */  
                  brstat.tlt.dat_ins_noti =   TODAY        /*วันที่ออกงาน */
                  brstat.tlt.releas       =   IF brstat.tlt.releas = "NO" THEN "YES" ELSE REPLACE(brstat.tlt.releas,"NO","YES").   
        END.
    END.

    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X1;K"  '"'  wdetail2.wk_number           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X2;K"  '"'  wdetail2.wk_senddate         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X3;K"  '"'  np_polnew                    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X4;K"  '"'  np_polnew72                  '"' SKIP.
    /*PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail2.wk_prepol           '"' SKIP.*/ /*A64-0138*/
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X5;K"  '"'  wdetail2.wk_comname          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X6;K"  '"'  wdetail2.wk_sendby           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X7;K"  '"'  wdetail2.wk_brname           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X8;K"  '"'  wdetail2.wk_covercar         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X9;K"  '"'  wdetail2.wk_covertypecar     '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X10;K" '"'  wdetail2.wk_cover            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X11;K" '"'  wdetail2.wk_coverfree        '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X12;K" '"'  wdetail2.wk_compfree         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X13;K" '"'  wdetail2.wk_comdat70         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X14;K" '"'  wdetail2.wk_expdat70         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X15;K" '"'  wdetail2.wk_title            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X16;K" '"'  wdetail2.wk_name1            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X17;K" '"'  wdetail2.wk_icno             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X18;K" '"'  wdetail2.wk_datbirth         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X19;K" '"'  wdetail2.wk_datbirthexp      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X20;K" '"'  wdetail2.wk_occup            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X21;K" '"'  wdetail2.wk_name2            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X22;K" '"'  wdetail2.wk_addr1            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X23;K" '"'  wdetail2.wk_addr2            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X24;K" '"'  wdetail2.wk_addr3            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X25;K" '"'  wdetail2.wk_addr4            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X26;K" '"'  wdetail2.wk_post             '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X27;K" '"'  wdetail2.wk_phone            '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X28;K" '"'  wdetail2.wk_driverno         '"' SKIP.   
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X29;K" '"'  wdetail2.wk_driname1         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X30;K" '"'  wdetail2.wk_driname1gen      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X31;K" '"'  wdetail2.wk_driname1birth    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X32;K" '"'  wdetail2.wk_driname1occup    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X33;K" '"'  wdetail2.wk_driname1number   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X34;K" '"'  wdetail2.wk_driname2         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X35;K" '"'  wdetail2.wk_driname2gen      '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X36;K" '"'  wdetail2.wk_driname2birth    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X37;K" '"'  wdetail2.wk_driname2occup    '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X38;K" '"'  wdetail2.wk_driname2number   '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X39;K" '"'  wdetail2.wk_nbrand           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X40;K" '"'  wdetail2.wk_nmodel           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X41;K" '"'  wdetail2.wk_nengno           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X42;K" '"'  wdetail2.wk_nchassis         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X43;K" '"'  wdetail2.wk_nengcc           '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X44;K" '"'  wdetail2.wk_ncaryear         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X45;K" '"'  wdetail2.wk_nvehreg          '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X46;K" '"'  wdetail2.wk_nvehreg2         '"' SKIP.
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X47;K" '"'  wdetail2.wk_garage           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X48;K" '"'  wdetail2.wk_SUMINSURED       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X49;K" '"'  wdetail2.wk_npremt           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X50;K" '"'  wdetail2.wk_npremtnet        '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X51;K" '"'  wdetail2.wk_npremtcomp       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X52;K" '"'  wdetail2.wk_npremtotle       '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X53;K" '"'  wdetail2.wk_stkno            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X54;K" '"'  wdetail2.wk_vatname          '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X55;K" '"'  wdetail2.wk_bennam           '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X56;K" '"'  wdetail2.wk_remak            '"' SKIP.  
    PUT STREAM ns2 "C;Y" STRING(nv_row) ";X57;K" '"'  wdetail2.wk_ispno            '"' SKIP. 
                                       
End.   

PUT STREAM ns2 "E".
OUTPUT STREAM ns2 CLOSE.

message "Export File Match Policy  Complete"  view-as alert-box.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_packpara c-Win 
PROCEDURE proc_packpara :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  A63-0169      
------------------------------------------------------------------------------*/
FOR EACH wcampaign.   
    DELETE wcampaign.   
END.
FIND LAST wcampaign WHERE wcampaign.campno =  brstat.insure.insno  NO-ERROR NO-WAIT.
    IF NOT AVAIL wcampaign THEN DO:
        FOR EACH brstat.insure USE-INDEX insure02 WHERE brstat.insure.insno = fi_pack AND 
                               brstat.insure.compno = fi_pack  NO-LOCK.
        CREATE wcampaign.
        ASSIGN
            wcampaign.campno = brstat.insure.insno 
            wcampaign.id     = brstat.insure.Text4        /*class*/
            wcampaign.cover  = brstat.insure.vatcode      /* cover */  
            wcampaign.pack   = brstat.insure.text3          /*pack */
            wcampaign.bi     = brstat.insure.Lname         /*tp1*/
            wcampaign.pd1    = brstat.insure.addr1         /*tp2*/
            wcampaign.pd2    = brstat.insure.addr2         /*tp3*/
            wcampaign.n41    = brstat.insure.addr3         /*n_41*/
            wcampaign.n42    = brstat.insure.addr4         /*n_42*/
            wcampaign.n43    = brstat.insure.telno         /*n_43*/
            wcampaign.garage = brstat.Insure.text1         /* garage */
            wcampaign.nname  = brstat.insure.compno.
        
    END.
    RELEASE brstat.insure.
END.

OPEN QUERY br_cam FOR EACH wcampaign .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy c-Win 
PROCEDURE proc_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(15)".
ASSIGN fi_process = "Create data to uwm100..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
IF wdetail.policy <> "" THEN DO:
    /*IF wdetail.poltyp = "V70" THEN ASSIGN wdetail.stk = "".*/
    IF wdetail.stk  <>  ""  THEN DO: 
        ASSIGN stklen = 0
            stklen = INDEX(trim(wdetail.stk)," ") - 1.
        IF (SUBSTRING(wdetail.stk,1,1) = "2") AND (wdetail.poltyp = "v72") THEN DO: 
            IF stklen > 1 THEN wdetail.stk = "0" + substr(wdetail.stk,1,stklen).
            ELSE wdetail.stk = "0" + substr(wdetail.stk,1,LENGTH(wdetail.stk)).
        END.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass = "N"
            wdetail.comment      = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001  WHERE
            sicuw.uwm100.policy =  wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN wdetail.pass = "N"
                wdetail.comment     = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning     = "Program Running Policy No. ให้ชั่วคราว".
        END.
        ASSIGN nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk   NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        ELSE RUN proc_create100.
    END.   /*wdetail.stk  <>  ""*/
    ELSE DO:  /*sticker = ""*/ 
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy = wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
            IF wdetail.policy = "" THEN DO:
                RUN proc_temppolicy.
                wdetail.policy  = nv_tmppol.
            END.
            ELSE RUN proc_create100. 
        END.
        RUN proc_create100.    /*RUN proc_create100. */
    END. 
END. 
ELSE DO:     /*wdetail.policy = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN chr_sticker = "0" + wdetail.stk.
        ELSE chr_sticker = wdetail.stk.
        chk_sticker = chr_sticker.
        RUN wuz\wuzchmod.
        IF chk_sticker  <>  chr_sticker  Then 
            ASSIGN  wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN  wdetail.pass = "N"
                wdetail.comment      = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
        END.
        nv_newsck = " ".
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
            stat.detaitem.serailno = wdetail.stk      NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN  wdetail.pass = "N"
            wdetail.comment      = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.warning      = "Program Running Policy No. ให้ชั่วคราว".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.       /*wdetail.stk  <>  ""*/
    ELSE DO:  /*policy = "" and comp_sck = ""  */       
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.
END.
s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = wdetail.poltyp  NO-LOCK NO-ERROR NO-WAIT.
IF AVAIL  sicsyac.xmm031 THEN DO:
    nv_dept = sicsyac.xmm031.dept.
END.
IF wdetail.poltyp = "V70"  AND wdetail.Docno <> ""  THEN 
    ASSIGN nv_docno = wdetail.Docno
    nv_accdat       = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
/*IF wdetail.inserf = "" THEN RUN proc_insnam.*/
RUN proc_insnam . /*a61-0386*/
RUN proc_insnam2 . /*Add by Kridtiya i. A63-0472*/
DO TRANSACTION:  
    ASSIGN                                                                             
        sic_bran.uwm100.renno  = ""                                                      
        sic_bran.uwm100.endno  = ""                                                      
        sic_bran.uwm100.poltyp = trim(wdetail.poltyp)                                          
        sic_bran.uwm100.insref = caps(TRIM(wdetail.inserf))                                             
        sic_bran.uwm100.opnpol = TRIM(wdetail.promoti)                  /*promotion */
        sic_bran.uwm100.anam2  = trim(wdetail.nv_icno)              
        sic_bran.uwm100.ntitle = trim(wdetail.tiname)        
        sic_bran.uwm100.name1  = trim(wdetail.insnam)        
        sic_bran.uwm100.name2  = trim(wdetail.name2)                                      
        /*sic_bran.uwm100.name3  = trim(wdetail.name3) */       
        sic_bran.uwm100.addr1  = trim(wdetail.n_addr1)             
        sic_bran.uwm100.addr2  = trim(wdetail.n_addr2)       
        sic_bran.uwm100.addr3  = trim(wdetail.n_addr3)       
        sic_bran.uwm100.addr4  = trim(wdetail.n_addr4)       
        sic_bran.uwm100.postcd = ""              
        sic_bran.uwm100.occupn  = TRIM(wdetail.occup)        /*a61-0386*/
        sic_bran.uwm100.undyr  = String(Year(today),"9999")    /* nv_undyr */
        sic_bran.uwm100.branch = caps(trim(wdetail.n_branch))  /*trim(wdetail.n_branch)*//* nv_branch */                        
        sic_bran.uwm100.dept   = nv_dept                     
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))          
        sic_bran.uwm100.fstdat = dATE(wdetail.fristdat)        /*DATE(wdetail.comdat) ให้ firstdate*/
        sic_bran.uwm100.comdat = DATE(wdetail.comdat)        
        sic_bran.uwm100.expdat = DATE(wdetail.expdat)        
        sic_bran.uwm100.accdat = nv_accdat                   
        sic_bran.uwm100.tranty = "N"                           /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.langug = "T"                         
        sic_bran.uwm100.acctim = "00:00"                     
        sic_bran.uwm100.trty11 = "M"                         
        sic_bran.uwm100.docno1 = STRING(nv_docno,"9999999")  
        sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")     
        sic_bran.uwm100.entdat = TODAY                       
        sic_bran.uwm100.curbil = "BHT"                       
        sic_bran.uwm100.curate = 1                           
        sic_bran.uwm100.instot = 1                           
        sic_bran.uwm100.prog   = "wgwtamnh"                  
        sic_bran.uwm100.cntry  = "TH"                        /*Country where risk is situated*/
        sic_bran.uwm100.insddr = YES                         /*Print Insd. Name on DrN       */
        sic_bran.uwm100.no_sch = 0                           /*No. to print, Schedule        */
        sic_bran.uwm100.no_dr  = 1                           /*No. to print, Dr/Cr Note      */
        sic_bran.uwm100.no_ri  = 0                           /*No. to print, RI Appln        */
        sic_bran.uwm100.no_cer = 0                           /*No. to print, Certificate     */
        sic_bran.uwm100.li_sch = YES                         /*Print Later/Imm., Schedule    */
        sic_bran.uwm100.li_dr  = YES                         /*Print Later/Imm., Dr/Cr Note  */
        sic_bran.uwm100.li_ri  = YES                         /*Print Later/Imm., RI Appln,   */
        sic_bran.uwm100.li_cer = YES                         /*Print Later/Imm., Certificate */
        sic_bran.uwm100.apptax = YES                         /*Apply risk level tax (Y/N)    */
        sic_bran.uwm100.recip  = "N"                         /*Reciprocal (Y/N/C)            */
        sic_bran.uwm100.short  = NO                          
        sic_bran.uwm100.acno1  = trim(wdetail.producer)      /*nv_acno1 */
        sic_bran.uwm100.agent  = trim(wdetail.agent)         /*nv_agent */
        sic_bran.uwm100.insddr = NO
        sic_bran.uwm100.coins  = NO
        sic_bran.uwm100.billco = ""
        sic_bran.uwm100.fptr01 = 0        sic_bran.uwm100.bptr01 = 0
        sic_bran.uwm100.fptr02 = 0        sic_bran.uwm100.bptr02 = 0
        sic_bran.uwm100.fptr03 = 0        sic_bran.uwm100.bptr03 = 0
        sic_bran.uwm100.fptr04 = 0        sic_bran.uwm100.bptr04 = 0
        sic_bran.uwm100.fptr05 = 0        sic_bran.uwm100.bptr05 = 0
        sic_bran.uwm100.fptr06 = 0        sic_bran.uwm100.bptr06 = 0  
        sic_bran.uwm100.styp20 = "NORM"
        sic_bran.uwm100.dir_ri =   YES
        sic_bran.uwm100.drn_p  =  NO
        sic_bran.uwm100.sch_p  =  NO
        sic_bran.uwm100.cr_2   =  trim(wdetail.cr_2)
        sic_bran.uwm100.bchyr  =  nv_batchyr              /*Batch Year */  
        sic_bran.uwm100.bchno  =  nv_batchno              /*Batch No.  */  
        sic_bran.uwm100.bchcnt =  nv_batcnt               /*Batch Count*/  
        sic_bran.uwm100.prvpol =  trim(wdetail.prepol)   
        sic_bran.uwm100.cedpol =  trim(wdetail.cedpol) 
        /*sic_bran.uwm100.finint =  TRIM(wdetail.dealerno)*/
        sic_bran.uwm100.bs_cd  =  trim(wdetail.vatcode) 
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)     /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       = trim(wdetail.nv_icno)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)    /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)    /*Add by Kridtiya i. A63-0472*/
       /* sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/   /*Add by Kridtiya i. A63-0472*/
      /*sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)  /*Add by Kridtiya i. A63-0472*/ -- Comment By Tontawan S. A66-0139 10/08/2023 --*/
        sic_bran.uwm100.campaign   = TRIM(wdetail.producer)  /*--------------------------------------- Add By Tontawan S. A66-0139 10/08/2023 --*/
        sic_bran.uwm100.dealer     = TRIM(wdetail.financecd).   /*Add by Kridtiya i. A63-0472*/ 
        
    IF wdetail.pass = "Y" THEN  sic_bran.uwm100.impflg  = YES.
    ELSE sic_bran.uwm100.impflg  = NO.
    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN  sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
    IF wdetail.cancel = "ca" THEN sic_bran.uwm100.polsta = "CA" .
    ELSE  sic_bran.uwm100.polsta = "IF".
    IF fi_loaddat <> ? THEN sic_bran.uwm100.trndat = fi_loaddat.
    ELSE sic_bran.uwm100.trndat = TODAY.
    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
    nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                      (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                  ELSE (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1 .   
END.     /*transaction*//**/
IF wdetail.poltyp = "v70" THEN DO:
     RUN proc_uwd100_1.
     RUN proc_uwd102_1.
    
END.
ELSE RUN proc_uwd102_1.

/* --------------------U W M 1 2 0 -------------- */
FIND sic_bran.uwm120 USE-INDEX uwm12001      WHERE
    sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND 
    sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND 
    sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
    sic_bran.uwm120.riskgp  = s_riskgp               AND 
    sic_bran.uwm120.riskno  = s_riskno               AND       
    sic_bran.uwm120.bchyr   = nv_batchyr             AND 
    sic_bran.uwm120.bchno   = nv_batchno             AND
    sic_bran.uwm120.bchcnt  = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm120 THEN DO:
    RUN wgw/wgwad120 (INPUT  sic_bran.uwm100.policy,   
                             sic_bran.uwm100.rencnt,
                             sic_bran.uwm100.endcnt,
                             s_riskgp,
                             s_riskno,
                      OUTPUT s_recid2).
    FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
END.   /* end not avail  uwm120 */
IF AVAILABLE sic_bran.uwm120 THEN DO:  
    ASSIGN
        sic_bran.uwm120.sicurr = "BHT"
        sic_bran.uwm120.siexch = 1  /*not sure*/
        sic_bran.uwm120.fptr01 = 0               
        sic_bran.uwm120.fptr02 = 0               
        sic_bran.uwm120.fptr03 = 0               
        sic_bran.uwm120.fptr04 = 0               
        sic_bran.uwm120.fptr08 = 0               
        sic_bran.uwm120.fptr09 = 0          
        sic_bran.uwm120.com1ae = YES
        sic_bran.uwm120.stmpae = YES
        sic_bran.uwm120.feeae  = YES
        sic_bran.uwm120.taxae  = YES
        sic_bran.uwm120.bptr01 = 0 
        sic_bran.uwm120.bptr02 = 0 
        sic_bran.uwm120.bptr03 = 0 
        sic_bran.uwm120.bptr04 = 0 
        sic_bran.uwm120.bptr08 = 0 
        sic_bran.uwm120.bptr09 = 0 
        sic_bran.uwm120.bchyr  = nv_batchyr         /* batch Year */
        sic_bran.uwm120.bchno  = nv_batchno         /* bchno    */
        sic_bran.uwm120.bchcnt = nv_batcnt .      /* bchcnt     */
    ASSIGN
        sic_bran.uwm120.class  = wdetail.class 
        s_recid2     = RECID(sic_bran.uwm120).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_renew70 c-Win 
PROCEDURE Proc_renew70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100  Use-index uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN 
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
    ELSE DO: 
        ASSIGN   
            wdetail.prepol   = sicuw.uwm100.policy
            n_rencnt         = sicuw.uwm100.rencnt  +  1
            n_endcnt         = 0   
            wdetail.n_rencnt = sicuw.uwm100.rencnt  +  1    
            wdetail.n_endcnt = 0   .                         
        /*IF      ra_renewby = 1 THEN  RUN proc_assignrenew_pol.  /*A56-0151*/     
        ELSE   RUN proc_assignrenew_mas. */                       /*A56-0151*/
        RUN proc_assignrenew .                                 /*A56-0151*/
    END.
END.
Else do:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0 .
END. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 c-Win 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.
FOR EACH wdetail  WHERE wdetail.PASS <> "Y"  NO-LOCK :
        NOT_pass = NOT_pass + 1.
    
END.
IF NOT_pass > 0 THEN DO:
OUTPUT STREAM ns1 TO value(fi_output2).
PUT STREAM ns1
    "Redbook"     ","
    "Branch    "     "," 
    "Delercode "     "," 
    "vatcode   "     "," 
    "policyno  "      ","  
    "cndat     "      ","  
    "appenno   "      ","  
    "comdat    "      ","  
    "expdat    "      ","  
    "comcode   "      ","  
    "cartyp    "      ","  
    "saletyp   "      ","  
    "campen    "      ","  
    "freeamonth"      ","  
    "covcod    "      ","  
    "typcom    "      ","  
    "garage    "      ","  
    "bysave    "      ","  
    "tiname    "      ","  
    "insnam    "      ","  
    "name2     "      ","  
    "name3     "      ","  
    "addr      "      ","  
    "road     "       ","  
    "tambon   "       ","  
    "amper    "       ","  
    "country  "       ","  
    "post     "       ","  
    "occup    "       ","  
    "birthdat "       ","  
    "icno     "       ","  
    "driverno "       ","  
    "brand    "       ","  
    "cargrp   "       ","  
    "chasno   "       ","  
    "eng      "       ","  
    "model    "       ","  
    "caryear  "       ","  
    "carcode  "       ","  
    "body     "       ","  
    "carno    "       ","  
    "vehuse   "       ","  
    "seat      "      ","  
    "engcc     "      ","  
    "colorcar  "      ","  
    "vehreg    "      ","  
    "re_country"      ","  
    "re_year   "      ","  
    "nmember   "      ","   
    "si        "      ","   
    "premt     "      ","   
    "rstp_t    "      ","   
    "rtax_t    "      ","   
    "prem_r    "      ","   
    "gap       "      ","   
    "ncb       "      ","   
    "ncbprem   "      ","   
    "stk       "      ","
    "prepol    "      ","
    "flagname  "      "," 
    "flagno    "      "," 
    "ntitle1    "     "," 
    "drivername1"     "," 
    "dname1     "     "," 
    "dname2     "     "," 
    "docoup     "     "," 
    "dbirth     "     "," 
    "dicno      "     "," 
    "ddriveno   "     "," 
    "ntitle2    "     "," 
    "drivername2"     "," 
    "ddname1    "     "," 
    "ddname2    "     "," 
    "ddocoup    "     "," 
    "ddbirth    "     "," 
    "ddicno     "     "," 
    "dddriveno  "     "," 
    "benname    "     "," 
    "comper     "     "," 
    "comacc     "     "," 
    "deductpd   "     "," 
    "tp2        "     "," 
    "deductda   "     "," 
    "deduct     "     "," 
    "tpfire     "     "," 
    "compul     "     "," 
    "pass       "     "," 
    "NO_41      "     "," 
    "ac2        "     "," 
    "NO_42      "     "," 
    "ac4        "     "," 
    "ac5        "     "," 
    "ac6        "     "," 
    "ac7        "     "," 
    "NO_43      "     "," 
    "nstatus    "     "," 
    "typrequest "     "," 
    "comrequest "     "," 
    "brrequest  "     "," 
    "salename    "    "," 
    "comcar      "    "," 
    "brcar       "    "," 
    "projectno   "    "," 
    "caryear     "    "," 
    "special1    "    "," 
    "specialprem1"    "," 
    "special2    "    "," 
    "specialprem2"    "," 
    "special3    "    ","
    "specialprem3"    ","
    "special4    "    ","
    "specialprem4"    ","
    "special5    "    ","
    "specialprem5"    ","
    "comment     "    "," 
    "WARNING     "    
            SKIP.                                                   
FOR EACH  wdetail  WHERE wdetail.PASS <> "Y" NO-LOCK:   
    PUT STREAM ns1 wdetail.redbook     "," 
        wdetail.n_branch     "," 
        wdetail.policy       ","
        wdetail.cndat         ","
        wdetail.comdat        ","
        wdetail.expdat        ","
        wdetail.covcod        ","
        wdetail.garage        "," 
        wdetail.tiname        ","
        wdetail.insnam        ","
        wdetail.brand         ","               
        wdetail.cargrp        ","               
        wdetail.chassis        ","               
        wdetail.engno           ","               
        wdetail.model         "," 
        wdetail.caryear       "," 
        wdetail.body          "," 
        wdetail.vehuse        "," 
        wdetail.seat          "," 
        wdetail.engcc         "," 
        wdetail.vehreg        "," 
        wdetail.si            "," 
        wdetail.premt         "," 
        /*wdetail.rstp_t        "," 
        wdetail.rtax_t        "," */
        wdetail.prem_r        "," 
        wdetail.ncb           "," 
        /*wdetail.ncbprem       "," */
        wdetail.stk           ","
         
        /*wdetail.ntitle1       ","
        wdetail.drivername1   ","   
        wdetail.dname1        ","   
        wdetail.dname2        ","   
        wdetail.docoup        ","   
        wdetail.dbirth        ","   
        wdetail.dicno         ","   
        wdetail.ddriveno      ","   
        wdetail.ntitle2       ","   
        wdetail.drivername2   ","   
        wdetail.ddname1       ","   
        wdetail.ddname2       ","   
        wdetail.ddocoup       ","   
        wdetail.ddbirth       ","   
        wdetail.ddicno        ","   
        wdetail.dddriveno     "," */  
        wdetail.benname       ","   
        wdetail.comper        ","   
        wdetail.comacc        ","   
         
        /*wdetail.tp2           ","  */ 
        /*wdetail.deductda      ","  */ 
        /*wdetail.deduct        ","   */
        /*wdetail.tpfire        ","  */ 
        wdetail.compul        ","   
        wdetail.pass          ","     
        wdetail.nv_41         ","   
        wdetail.nv_42         ","   
        wdetail.nv_43         ","   
        wdetail.caryear       ","   
        wdetail.comment       ","
        wdetail.WARNING         
        SKIP.  
    
    END.
END.                                                                                    
OUTPUT STREAM ns1 CLOSE.                                                       
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 c-Win 
PROCEDURE PROC_REPORT2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR HEAD AS CHAR INIT "Y".
/*nv_row  =  1.*/
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        pass = pass + 1.
END.

IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
PUT STREAM NS2
    "redbook "  ","
    "n_branch"  ","   
    "policyno"  ","   
    "cndat   "  "," 
    "comdat  "  ","  
    "expdat  "  ","  
    "covcod  "  ","  
    "garage  "  ","  
    "tiname  "  ","  
    "insnam  "  ","  
    "brand   "  ","  
    "cargrp  "  ","  
    "chasno  "  ","  
    "eng     "  ","  
    "model   "  ","  
    "caryear "  ","  
    "body    "  ","  
    "vehuse  "  ","  
    "seat    "  ","  
    "engcc   "  ","  
    "vehreg  "  ","  
    "si      "  ","  
    "premt   "  ","  
    "rstp_t  "  ","  
    "rtax_t  "  ","  
    "prem_r  "  ","  
    "ncb     "  ","  
    "stk     "  ","  
    "prepol  "  ","  
    "benname "  ","  
    "comper  "  ","  
    "comacc  "  ","  
    "deductpd"  ","  
    "deduct  "  ","  
    "compul  "  ","  
    "pass    "  ","  
    "NO_41   "  ","  
    "ac2     "  ","  
    "NO_42   "  ","  
    "NO_43   "  ","  
    "caryear "  ","  
    "comment "  ","  
    "WARNING "  SKIP.        
FOR EACH  wdetail  WHERE wdetail.PASS = "Y"  NO-LOCK:
        PUT STREAM ns2
            wdetail.redbook    ","   
            wdetail.n_branch   ","   
            wdetail.policy     ","
            wdetail.cndat      ","
            wdetail.comdat     ","
            wdetail.expdat     ","
            wdetail.covcod     ","
            wdetail.garage     "," 
            wdetail.tiname     ","
            wdetail.insnam     ","
            wdetail.brand      ","               
            wdetail.cargrp     ","               
            wdetail.chassis    ","               
            wdetail.engno      ","               
            wdetail.model      "," 
            wdetail.caryear    "," 
            wdetail.body       "," 
            wdetail.vehuse     "," 
            wdetail.seat       "," 
            wdetail.engcc      "," 
            wdetail.vehreg     "," 
            wdetail.si         "," 
            wdetail.premt      "," 
            /*wdetail.rstp_t     "," 
            wdetail.rtax_t     "," */
            wdetail.prem_r     "," 
            wdetail.ncb        "," 
            wdetail.stk        ","
            /*wdetail.prepol     ","*/
            wdetail.benname    ","   
            wdetail.comper     ","   
            wdetail.comacc     ","   
            /*wdetail.deductpd   ","   
            wdetail.deduct     "," */ 
            wdetail.compul     ","   
            wdetail.pass       ","     
            wdetail.nv_41      ","   
            wdetail.nv_42      ","   
            wdetail.nv_43      ","   
            wdetail.caryear    ","   
            wdetail.comment    ","
            wdetail.WARNING    SKIP.  
  
  END.
OUTPUT STREAM ns2 CLOSE.                                                           
END. /*pass > 0*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen c-Win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
"IMPORT TEXT FILE TISCO " SKIP
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     SKIP
"       Producer Code : " fi_producer   SKIP
"          Agent Code : " fi_agent      SKIP
"  Previous Batch No. : " fi_prevbat   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"    Output Data Load : " fi_output1    SKIP
"Output Data Not Load : " fi_output1    SKIP
"     Batch File Name : " fi_output1    SKIP
" policy Import Total : " fi_usrcnt    "Total Net Premium Imp : " fi_usrprem " BHT." SKIP
SKIP
SKIP
SKIP
"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP
"Batch No. : " fi_bchno  SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.                                                           
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 c-Win 
PROCEDURE proc_sic_exp2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FORM
    gv_id  LABEL " User Id " colon 35 SKIP
    nv_pwd LABEL " Password" colon 35 BLANK
    WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
    TITLE   " Connect DB Expiry System"  . 
/*HIDE ALL NO-PAUSE.*//*note block*/
STATUS INPUT OFF.
/*
{s0/s0sf1.i}
*/
gv_prgid = "GWNEXP02".

REPEAT:
  pause 0.
  STATUS DEFAULT "F4=EXIT".
  ASSIGN
  gv_id     = ""
  n_user    = "".
  UPDATE 
      gv_id   FORMAT "x(15)"      
      nv_pwd  FORMAT "x(15)"      
      GO-ON(F1 F4) WITH FRAME nf00
  EDITING:
    READKEY.
    IF FRAME-FIELD = "gv_id" AND 
       LASTKEY = KEYCODE("ENTER") OR 
       LASTKEY = KEYCODE("f1") THEN DO:
       
       IF INPUT gv_id = "" THEN DO:
          MESSAGE "User ID. IS NOT BLANK".
          NEXT-PROMPT gv_id WITH FRAME nf00.
          NEXT.
       END.
       gv_id = INPUT gv_id.

    END.
    IF FRAME-FIELD = "nv_pwd" AND 
       LASTKEY = KEYCODE("ENTER") OR 
       LASTKEY = KEYCODE("f1") THEN DO:
       
       nv_pwd = INPUT nv_pwd.
    END.      
    APPLY LASTKEY.
  END.
  ASSIGN n_user = gv_id.

  IF LASTKEY = KEYCODE("ENTER") THEN DO:
    CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*HO*/ 
   /*CONNECT expiry     -ld sic_exp    -H 10.35.176.37         -S 9060         -N TCP  -U value(gv_id) -P value(nv_pwd) NO-ERROR. -- TEST --*/
   /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.    /*HO*/*//*Comment A62-0105*/
   /*CONNECT expiry -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. *//*Test*/
   
    CLEAR FRAME nf00.
    HIDE FRAME nf00.
    RETURN. 
  
  END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_susspect c-Win 
PROCEDURE proc_susspect :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_msgstatus  as char.
DEF VAR nn_vehreglist as char.
DEF VAR nn_namelist   as char.
DEF VAR nn_namelist2  as char.
DEF VAR nv_chanolist  as char.
DEF VAR nv_idnolist   as char.
DEF VAR nv_CheckLog   as LOGICAL.   
DEF VAR nv_idnolist2  AS CHAR.
ASSIGN 
    nv_msgstatus   = ""
    nn_vehreglist  = ""
    nn_namelist    = ""
    nn_namelist2   = "" 
    nv_chanolist   = "" 
    nv_idnolist    = "" 
    nv_CheckLog    = YES
    nn_vehreglist  = trim(wdetail.vehreg)  
    nv_chanolist   = trim(wdetail.chassis)
    nv_idnolist    = trim(wdetail.nv_icno)  .

IF R-INDEX(wdetail.insnam," ") <> 0 THEN  
    ASSIGN
    nn_namelist    = trim(SUBSTR(wdetail.insnam,1,R-INDEX(wdetail.insnam," ")))
    nn_namelist2   = trim(SUBSTR(wdetail.insnam,R-INDEX(wdetail.insnam," "))).
ELSE ASSIGN
    nn_namelist    = TRIM(wdetail.insnam) 
    nn_namelist2   = "".


IF wdetail.vehreg <> "" THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp01    WHERE 
        sicuw.uzsusp.vehreg = nn_vehreglist    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail.comment = wdetail.comment + "|รถผู้เอาประกัน ติด suspect ทะเบียน " + nn_vehreglist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"                    
            wdetail.OK_GEN  = "N".                
    END.
END.
IF (nv_msgstatus = "") AND (nn_namelist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
        sicuw.uzsusp.fname = nn_namelist           AND 
        sicuw.uzsusp.lname = nn_namelist2          NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail.comment = wdetail.comment + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"                     
            wdetail.OK_GEN  = "N".                
    END.
    ELSE DO:
        FIND LAST sicuw.uzsusp USE-INDEX uzsusp03   WHERE 
            sicuw.uzsusp.fname = Trim(nn_namelist  + " " + nn_namelist2)        
            NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wdetail.comment = wdetail.comment + "|ชื่อผู้เอาประกัน ติด suspect คุณ" + nn_namelist + " " + nn_namelist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wdetail.pass    = "N"                     
                wdetail.OK_GEN  = "N".                
        END.
    END.
END.

IF (nv_msgstatus = "") AND (nv_chanolist <> "") THEN DO:
    FIND LAST sicuw.uzsusp USE-INDEX uzsusp05   WHERE 
        uzsusp.cha_no =  nv_chanolist         NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail.comment = wdetail.comment + "|รถผู้เอาประกัน ติด suspect เลขตัวถัง " + nv_chanolist + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"                     
            wdetail.OK_GEN  = "N".                
    END.
END.
IF (nv_msgstatus = "") AND (nv_idnolist <> "") THEN DO:

    FIND LAST sicuw.uzsusp USE-INDEX uzsusp08    WHERE 
        sicuw.uzsusp.notes = nv_idnolist   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uzsusp  THEN DO:
        ASSIGN 
            wdetail.comment = wdetail.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
            wdetail.pass    = "N"                     
            wdetail.OK_GEN  = "N".                
    END.
    IF nv_msgstatus = "" THEN DO:
        ASSIGN 
            nv_idnolist2 = ""
            nv_idnolist  = REPLACE(nv_idnolist,"-","")
            nv_idnolist  = REPLACE(nv_idnolist," ","")
            nv_idnolist2 = substr(nv_idnolist,1,1)  + "-" +
                           substr(nv_idnolist,2,4)  + "-" +
                           substr(nv_idnolist,6,5)  + "-" +
                           substr(nv_idnolist,11,2) + "-" +
                           substr(nv_idnolist,13)   .

        FIND LAST sicuw.uzsusp USE-INDEX uzsusp08  WHERE 
            sicuw.uzsusp.notes = nv_idnolist2         NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uzsusp  THEN DO:
            ASSIGN 
                wdetail.comment = wdetail.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
                wdetail.pass    = "N"                     
                wdetail.OK_GEN  = "N".                
        END.
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy c-Win 
PROCEDURE proc_TempPolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
nv_tmppol    = ""
nv_tmppolrun = nv_tmppolrun + 1
nv_tmppol    = nv_batchno + string(nv_tmppolrun, "999") .
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_usdcod c-Win 
PROCEDURE Proc_usdcod :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR nv_age1 AS INT INIT 0.
DEF VAR nv_age2 AS INT INIT 0.
DEFINE  VAR   nv_drivcod1 AS CHARACTER FORMAT "X(4)".
DEFINE  VAR   nv_drivcod2 AS CHARACTER FORMAT "X(4)".
DEF VAR nv_age1rate  LIKE  sicsyac.xmm106.appinc.
DEF VAR nv_age2rate  LIKE  sicsyac.xmm106.appinc.
ASSIGN
  nv_age1  = INTEGER(nv_drivage1)
  nv_age2  = INTEGER(nv_drivage2).
nv_drivcod = "A" + STRING(nv_drivno,"9").
  IF nv_drivno = 1 THEN DO:
    IF nv_age1 LE 50 THEN DO:
      IF nv_age1 LE 35 THEN DO:
        IF nv_age1 LE 24 THEN DO:
          nv_drivcod = nv_drivcod + "24".
        END.
        ELSE nv_drivcod = nv_drivcod + "35".
      END.
      ELSE nv_drivcod = nv_drivcod + "50".
    END.
    ELSE nv_drivcod = nv_drivcod + "99".
  END.
  IF  nv_drivno  = 2  THEN DO:
    IF nv_age1 LE 50 THEN DO:
      IF nv_age1 LE 35 THEN DO:
        IF nv_age1 LE 24 THEN DO:
          nv_drivcod1 = nv_drivcod + "24".
        END.
        ELSE nv_drivcod1 = nv_drivcod + "35".
      END.
      ELSE nv_drivcod1 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod1 = nv_drivcod + "99".
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
               sicsyac.xmm106.tariff = nv_tariff   AND
               sicsyac.xmm106.bencod = nv_drivcod1 AND
               sicsyac.xmm106.class  = nv_class    AND
               sicsyac.xmm106.covcod = nv_covcod   AND
               sicsyac.xmm106.key_b  GE nv_key_b   AND
               sicsyac.xmm106.effdat LE nv_comdat
    NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN
       nv_age1rate = sicsyac.xmm106.appinc.
    IF nv_age2 LE 50 THEN DO:
      IF nv_age2 LE 35 THEN DO:
        IF nv_age2 LE 24 THEN DO:
          nv_drivcod2 = nv_drivcod + "24".
        END.
        ELSE nv_drivcod2 = nv_drivcod + "35".
      END.
      ELSE nv_drivcod2 = nv_drivcod + "50".
    END.
    ELSE nv_drivcod2 = nv_drivcod + "99".
         
    FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
           sicsyac.xmm106.tariff = nv_tariff   AND
           sicsyac.xmm106.bencod = nv_drivcod2 AND
           sicsyac.xmm106.class  = nv_class    AND
           sicsyac.xmm106.covcod = nv_covcod   AND
           sicsyac.xmm106.key_b  GE nv_key_b   AND
           sicsyac.xmm106.effdat LE nv_comdat
           NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm106 THEN
       nv_age2rate = sicsyac.xmm106.appinc.
    IF   nv_age2rate > nv_age1rate  THEN
         nv_drivcod  = nv_drivcod2.
    ELSE nv_drivcod  = nv_drivcod1.
  END.
  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 c-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/*create  text (F17) by policy master...*/
DEFINE  VAR sv_fptr AS RECID no-undo.
DEFINE  VAR sv_bptr AS RECID no-undo.
DEFINE VAR nvw_bptr        AS RECID.
DEFINE VAR nvw_fptr        AS RECID.
DEFINE VAR nvw_index       AS INTEGER.
DEFINE VAR nvw_dl          AS INTEGER INITIAL[70].    
DEFINE VAR nvw_prev        AS RECID INITIAL[0].
DEFINE VAR nvw_next        AS RECID INITIAL[0].
DEFINE VAR nvw_list        AS LOGICAL INITIAL[YES].
DEF BUFFER wf_uwd100  FOR sic_bran.uwd100.
DEF VAR nv_bptr       AS RECID.
FOR EACH   wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    /*nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = ""  
    nv_txt1  = " " 
    nv_txt2  = " " 
    nv_txt3  = " "  
    nv_txt4  = " "  
    nv_txt5  = ""*/   . 
ASSIGN  nv_line1 = 0.
IF trim(fi_policymas) <> "" THEN DO:

FIND LAST sicuw.uwm100  USE-INDEX uwm10001  WHERE sicuw.uwm100.policy = trim(fi_policymas)  NO-LOCK NO-ERROR.
IF AVAILABLE sicuw.uwm100 THEN DO :
    ASSIGN sv_fptr = sicuw.uwm100.fptr01
           sv_bptr = sicuw.uwm100.bptr01.
    IF sv_fptr <> 0  AND sv_fptr <> ? THEN DO:
        IF sv_fptr <> 0 THEN  nvw_fptr = sv_fptr.
        REPEAT nvw_index = 1 TO nvw_dl
            WHILE nvw_fptr <> 0:
            FIND sicuw.uwd100 WHERE RECID(sicuw.uwd100) = nvw_fptr NO-LOCK NO-ERROR.
            CREATE wuppertxt.
            ASSIGN wuppertxt.line = nv_line1 + 1
                wuppertxt.txt =  sicuw.uwd100.ltext .
            IF nvw_index = 1 THEN
                nvw_prev = uwd100.bptr.
            ELSE IF nvw_index = nvw_dl THEN DO:
                nvw_next = sicuw.uwd100.fptr.
                LEAVE.
            END.
            nvw_fptr = sicuw.uwd100.fptr.
            DOWN 1 WITH FRAME nf1.
        END.
        nvw_list = NO.
        FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
            sic_bran.uwm100.policy  = wdetail.policy    AND
            sic_bran.uwm100.rencnt  = wdetail.n_rencnt  AND
            sic_bran.uwm100.endcnt  = wdetail.n_endcnt  AND
            sic_bran.uwm100.bchyr   = nv_batchyr        AND
            sic_bran.uwm100.bchno   = nv_batchno        AND
            sic_bran.uwm100.bchcnt  = nv_batcnt         NO-ERROR NO-WAIT.
        IF AVAILABLE sic_bran.uwm100 THEN DO:
            FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
                CREATE sic_bran.uwd100.
                ASSIGN
                    sic_bran.uwd100.bptr    = nv_bptr
                    sic_bran.uwd100.fptr    = 0
                    sic_bran.uwd100.policy  = wdetail.policy
                    sic_bran.uwd100.rencnt  = wdetail.n_rencnt
                    sic_bran.uwd100.endcnt  = wdetail.n_endcnt
                    sic_bran.uwd100.ltext   = wuppertxt.txt.
                IF nv_bptr <> 0 THEN DO:
                    FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                    wf_uwd100.fptr = RECID(sic_bran.uwd100).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(sic_bran.uwd100).
                nv_bptr = RECID(sic_bran.uwd100).
            END. 
        END.  /*uwm100*/ 
    END.
END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100_1 c-Win 
PROCEDURE proc_uwd100_1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create  text (F17) by File Load ..*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.
FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    /*nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""  
    nv_txt4  = ""
    nv_txt5  = ""  
    nv_txt1  = ""
    nv_txt2  = ""
    nv_txt3  = ""
    nv_txt4  = ""
    nv_txt5  = "" */  . 
FIND LAST wtextf5 WHERE wtextf5.n_policytx = trim(wdetail.policy)  NO-LOCK NO-ERROR NO-WAIT.
IF  AVAIL wtextf5  THEN DO: 
    DO WHILE nv_line1 <= 9:
        CREATE wuppertxt.
        wuppertxt.line = nv_line1.
        IF nv_line1 = 4  THEN wuppertxt.txt = wtextf5.nv_textf51. 
        IF nv_line1 = 5  THEN wuppertxt.txt = wtextf5.nv_textf52. 
        IF nv_line1 = 6  THEN wuppertxt.txt = wtextf5.nv_textf53. 
        IF nv_line1 = 7  THEN wuppertxt.txt = wtextf5.nv_textf54. 
        IF nv_line1 = 8  THEN wuppertxt.txt = wtextf5.nv_textf55. 
        nv_line1 = nv_line1 + 1.
    END.
    FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
        sic_bran.uwm100.policy  = wdetail.policy  AND
        sic_bran.uwm100.rencnt  = n_rencnt        AND
        sic_bran.uwm100.endcnt  = n_endcnt        AND
        sic_bran.uwm100.bchyr   = nv_batchyr      AND
        sic_bran.uwm100.bchno   = nv_batchno      AND
        sic_bran.uwm100.bchcnt  = nv_batcnt       NO-ERROR NO-WAIT.
    IF AVAILABLE uwm100 THEN DO:
        FOR EACH wuppertxt NO-LOCK BREAK BY wuppertxt.line:
            CREATE sic_bran.uwd100.
            ASSIGN
                sic_bran.uwd100.bptr    = nv_bptr
                sic_bran.uwd100.fptr    = 0
                sic_bran.uwd100.policy  = wdetail.policy
                sic_bran.uwd100.rencnt  = n_rencnt
                sic_bran.uwd100.endcnt  = n_endcnt
                sic_bran.uwd100.ltext   = wuppertxt.txt.
            IF nv_bptr <> 0 THEN DO:
                FIND wf_uwd100 WHERE RECID(wf_uwd100) = nv_bptr.
                wf_uwd100.fptr = RECID(uwd100).
            END.
            IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr01 = RECID(uwd100).
            nv_bptr = RECID(uwd100).
        END.
    END.
END.  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 c-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
/*F18 memmo */
DEFINE VAR sv_fptr    AS RECID no-undo.
DEFINE VAR sv_bptr    AS RECID no-undo.     /* DEFINE VAR nvw_bptr        AS RECID.   */
DEFINE VAR nvw_fptr   AS RECID.                   
DEFINE VAR nvw_index  AS INTEGER.                 
DEFINE VAR nvw_dl     AS INTEGER INITIAL[14].     
DEFINE VAR nvw_prev   AS RECID INITIAL[0].       
DEFINE VAR nvw_next   AS RECID INITIAL[0].       
DEFINE VAR nvw_list   AS LOGICAL INITIAL[YES].
DEF VAR n_num1        AS INTE INIT 0.
DEF VAR n_num2        AS INTE INIT 0.
DEF VAR n_num3        AS INTE INIT 1.
DEF VAR i             AS INTE INIT 0.
DEF VAR n_text1       AS CHAR FORMAT "x(255)".
DEF VAR n_numtxt      AS INTE INIT 0.
ASSIGN 
    nv_fptr  = 0
    nv_bptr  = 0
    nv_nptr  = 0
    nv_line1 = 0
    n_numtxt = 0.
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
IF trim(fi_policymas)  <> ""  THEN DO:
    
FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE uwm100.policy =  trim(fi_policymas)   NO-LOCK NO-ERROR.
IF AVAILABLE uwm100 THEN DO :
    ASSIGN sv_fptr = uwm100.fptr02 
    sv_bptr = uwm100.bptr02.
    IF sv_fptr <> 0  AND sv_fptr <> ? THEN DO:
        IF sv_fptr <> 0 THEN DO:
            VIEW FRAME nf1.
            nvw_fptr = sv_fptr.
        END.
        REPEAT nvw_index = 1 TO nvw_dl
            WHILE nvw_fptr <> 0:
            FIND sicuw.uwd102 WHERE RECID(uwd102) = nvw_fptr NO-LOCK NO-ERROR.
            IF AVAIL sicuw.uwd102  THEN DO:
                n_numtxt = n_numtxt + 1.
                CREATE wuppertxt3.
                ASSIGN wuppertxt3.line = nv_line1 + 1 
                    wuppertxt3.txt = sicuw.uwd102.ltext .
                IF nvw_index = 1 THEN
                    nvw_prev = uwd102.bptr.
                ELSE IF nvw_index = nvw_dl THEN DO:
                    nvw_next = uwd102.fptr.
                    LEAVE.
                END.
            END.
            nvw_fptr = uwd102.fptr.
            DOWN 1 WITH FRAME nf1.
        END.
        Assign
            nvw_list = NO
            nv_fptr = 0 
            nv_bptr = 0  
            nv_nptr = 0 . 
        IF n_numtxt > 0 THEN DO:
            FOR EACH wuppertxt3 NO-LOCK BREAK BY wuppertxt3.line:
                CREATE sic_bran.uwd102.
                ASSIGN
                    sic_bran.uwd102.policy        = sic_bran.uwm100.policy        
                    sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
                    sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt        
                    sic_bran.uwd102.ltext         = wuppertxt3.txt
                    nv_nptr        =     Recid(sic_bran.uwd102).
                If  nv_fptr  = 0  And  nv_bptr = 0 Then      
                    Assign        
                    sic_bran.uwm100.fptr02  = Recid(sic_bran.uwd102)                   
                    sic_bran.uwd102.fptr    = 0  
                    sic_bran.uwd102.bptr    = 0                                  
                    nv_nptr        =  Recid(sic_bran.uwd102)
                    nv_bptr        =  Recid(sic_bran.uwd102).
                ELSE DO:
                    Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_bptr No-Error. 
                    If  Avail  sic_bran.uwd102   Then    sic_bran.uwd102.fptr   =  nv_nptr.
                    Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_nptr No-Error.
                    If Avail sic_bran.uwd102 Then Do :
                        sic_bran.uwd102.bptr  =      nv_bptr.
                        nv_bptr      =      Recid(sic_bran.uwd102).             
                    END.
               END.
            END. 
            sic_bran.uwm100.bptr02         =       Recid(sic_bran.uwd102).
            sic_bran.uwd102.fptr           =      0.  
            IF nv_bptr = 0 THEN sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
            nv_bptr = RECID(sic_bran.uwd102).
            ASSIGN 
                sic_bran.uwm100.bptr02 = nv_bptr 
                n_numtxt = 0.
        END.
    END.
END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102_1 c-Win 
PROCEDURE proc_uwd102_1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*F18 memmo */
DEF VAR n_num1 AS INTE INIT 0.
DEF VAR n_num2 AS INTE INIT 0.
DEF VAR n_num3 AS INTE INIT 1.
DEF VAR i AS INTE INIT 0.
DEF VAR n_text1 AS CHAR FORMAT "x(255)".
ASSIGN nv_fptr = 0
       nv_bptr = 0
       nv_nptr = 0
       nv_line1 = 1  .
FOR EACH wuppertxt3.
    DELETE wuppertxt3.
END.
FIND LAST wtextf7  WHERE wtextf7.n_policytxt = trim(wdetail.policy)   NO-LOCK NO-ERROR NO-WAIT.
IF  AVAIL wtextf7  THEN DO: 
    /*DO WHILE nv_line1 <= 8 :*/ /* A61-0386*/
    DO WHILE nv_line1 <= 15 : /* A61-0386*/
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 3  THEN wuppertxt3.txt = wtextf7.nv_memof71 .   
        IF nv_line1 = 4  THEN wuppertxt3.txt = wtextf7.nv_memof72 .                                           
        IF nv_line1 = 5  THEN wuppertxt3.txt = wtextf7.nv_memof73 .    
        IF nv_line1 = 6  THEN wuppertxt3.txt = wtextf7.nv_memof74 .                                          
        IF nv_line1 = 7  THEN wuppertxt3.txt = wtextf7.nv_memof75 . 
        IF nv_line1 = 8  THEN wuppertxt3.txt = wtextf7.nv_memof76 .   /*A61-0386*/                                       
        IF nv_line1 = 9  THEN wuppertxt3.txt = wtextf7.nv_memof77 .   /*A61-0386*/
        IF nv_line1 = 10  THEN wuppertxt3.txt = wtextf7.nv_memof78 .  /*A61-0386*/                                        
        IF nv_line1 = 11  THEN wuppertxt3.txt = wtextf7.nv_memof79 .  /*A61-0386*/
        IF nv_line1 = 12  THEN wuppertxt3.txt = wtextf7.nv_memof710 . /*A61-0386*/                                         
        IF nv_line1 = 13  THEN wuppertxt3.txt = wtextf7.nv_memof711 . /*A61-0386*/
        IF nv_line1 = 14  THEN wuppertxt3.txt = wtextf7.nv_memof712 . /*A61-0386*/
        nv_line1 = nv_line1 + 1.                                                                            
    END.
    IF nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? THEN DO:
        DO WHILE nv_fptr <> 0 AND sic_bran.uwm100.fptr02 <> ? :
            FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_fptr  NO-ERROR NO-WAIT.
            IF AVAILABLE sic_bran.uwd102 THEN DO:  
                nv_fptr = sic_bran.uwd102.fptr.
                CREATE sic_bran.uwd102.
                ASSIGN
                    sic_bran.uwd102.policy        = sic_bran.uwm100.policy      
                    sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt
                    sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt      
                    sic_bran.uwd102.bptr          = nv_bptr
                    sic_bran.uwd102.fptr          = 0
                    uwd102.ltext                  = sic_bran.uwd102.ltext.  
                IF nv_bptr <> 0 THEN DO:
                    FIND sic_bran.uwd102 WHERE RECID(sic_bran.uwd102) = nv_bptr NO-ERROR NO-WAIT.
                    sic_bran.uwd102.fptr = RECID(uwd102).
                END.
                IF nv_bptr = 0 THEN  sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102).
                nv_bptr = RECID(sic_bran.uwd102).
            END.
            ELSE DO:    
                HIDE MESSAGE NO-PAUSE.
                MESSAGE "not found " sic_bran.uwd102.policy sic_bran.uwd102.rencnt "/"
                    sic_bran.uwd102.endcnt "on file sic_bran.uwd102".
                LEAVE.
            END.
        END.
    END.
    ELSE DO:
        Assign            
            nv_fptr = 0 
            nv_bptr = 0  
            nv_nptr = 0. 
        FOR EACH wuppertxt3 NO-LOCK BREAK BY wuppertxt3.line:
            CREATE sic_bran.uwd102.
            ASSIGN
                sic_bran.uwd102.policy        = sic_bran.uwm100.policy        
                sic_bran.uwd102.rencnt        = sic_bran.uwm100.rencnt 
                sic_bran.uwd102.endcnt        = sic_bran.uwm100.endcnt        
                sic_bran.uwd102.ltext         = wuppertxt3.txt
                nv_nptr        =     Recid(sic_bran.uwd102).
            If  nv_fptr  = 0  And  nv_bptr = 0 Then      
                Assign        
                sic_bran.uwm100.fptr02  = Recid(sic_bran.uwd102)                   
                sic_bran.uwd102.fptr    = 0  
                sic_bran.uwd102.bptr    = 0                                  
                nv_nptr        =  Recid(sic_bran.uwd102)
                nv_bptr        =  Recid(sic_bran.uwd102).
            ELSE DO:
                Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_bptr No-Error. 
                If  Avail  sic_bran.uwd102   Then    sic_bran.uwd102.fptr   =  nv_nptr.
                Find  First sic_bran.uwd102  Where  Recid(sic_bran.uwd102)  =  nv_nptr No-Error.
                If Avail sic_bran.uwd102 Then Do :
                    sic_bran.uwd102.bptr  =      nv_bptr.
                    nv_bptr      =      Recid(sic_bran.uwd102).             
                END.
            END.
        END.
        sic_bran.uwm100.bptr02         =       Recid(uwd102).
        sic_bran.uwd102.fptr           =      0.  
        IF nv_bptr = 0 THEN  
            sic_bran.uwm100.fptr02 = RECID(uwd102).
        nv_bptr = RECID(uwd102).
    END.
    sic_bran.uwm100.bptr02 = nv_bptr.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd132 c-Win 
PROCEDURE proc_uwd132 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm100 c-Win 
PROCEDURE proc_uwm100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
     ASSIGN 
     sic_bran.uwm100.prem_t = nv_gapprm
     sic_bran.uwm100.sigr_p = inte(wdetail.si)
     sic_bran.uwm100.gap_p  = nv_gapprm.
     IF wdetail.pass <> "Y" THEN 
         ASSIGN
         sic_bran.uwm100.impflg = NO
         sic_bran.uwm100.imperr = wdetail.comment.    
     
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm120 c-Win 
PROCEDURE proc_uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
     sic_bran.uwm120.gap_r  = nv_gapprm
     sic_bran.uwm120.prem_r = nv_pdprm
     sic_bran.uwm120.sigr   = inte(wdetail.si).


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm301 c-Win 
PROCEDURE proc_uwm301 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
      /*  sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs*/
        sic_bran.uwm301.mv41seat = wdetail.seat41.
/* Add by A63-0169 */
sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN sic_bran.uwm301.tons * 1000 
                          ELSE sic_bran.uwm301.tons .

IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(wdetail.class,2,1) = "3"   OR  
   SUBSTR(wdetail.class,2,1) = "4"   OR  SUBSTR(wdetail.class,2,1) = "5"  OR  
   SUBSTR(wdetail.class,2,3) = "803" OR SUBSTR(wdetail.class,2,3) = "804" OR  
   SUBSTR(wdetail.class,2,3) = "805" ) THEN DO:

     MESSAGE wdetail.policy + " " + wdetail.class + " ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.

    ASSIGN
        wdetail.comment = wdetail.comment + "| " + wdetail.class + " ระบุน้ำหนักรถไม่ถูกต้อง "
        wdetail.pass    = "N"     
        wdetail.OK_GEN  = "N".
END.
/*
IF (wdetail.covcod = "2.1" ) OR (wdetail.covcod = "3.1" ) OR
(wdetail.covcod = "2.2" ) OR (wdetail.covcod = "3.2" ) THEN DO:     
RUN WGS\WGSTP132(INPUT S_RECID3,   
                 INPUT S_RECID4).
END.
ELSE   
/* end A63-0169 */
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
*/

/* A61-0386*/
nv_pdprm0 = 0.
IF nv_drivno <> 0  THEN DO:
     RUN wgw\wgwORPR0 (INPUT  nv_tariff,
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         sic_bran.uwm130.uom1_v,
                         sic_bran.uwm130.uom2_v,
                         sic_bran.uwm130.uom5_v,
                  OUTPUT nv_pdprm0).
     ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
END.
/* end A61-0386*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var c-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    /* nv_camptyp =  "NORM"*/
    s_riskgp   =   0                     s_riskno       =  1
    s_itemno   =   1                     nv_undyr       =    String(Year(today),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_wgw72013 c-Win 
PROCEDURE proc_wgw72013 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT        PARAMETER  nv_rec100  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nv_red132  AS RECID     NO-UNDO.
DEFINE INPUT        PARAMETER  nvtariff   AS CHARACTER NO-UNDO.
DEF            VAR n_dcover   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_dyear    AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR nvyear     AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_day1     AS   INT FORMAT "99"    INITIAL[31].
DEF            VAR n_mon1     AS   INT FORMAT "99"    INITIAL[12].
DEF            VAR n_ddyr     AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_ddyr1    AS   INT FORMAT "9999"  INITIAL[0].
DEF            VAR n_dmonth   AS   INT FORMAT "99999" INITIAL[0].
DEF            VAR n_orgnap   LIKE sic_bran.uwd132.gap_c  NO-UNDO.
DEF            VAR s_curbil   LIKE sic_bran.uwm100.curbil NO-UNDO.
def              var  n_total   as deci  no-undo.
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) EQ nv_rec100 NO-WAIT NO-ERROR.
FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ nv_red132 NO-WAIT NO-ERROR.
s_curbil = sic_bran.uwm100.curbil.
n_orgnap = sic_bran.uwd132.gap_c.
IF sic_bran.uwm100.expdat EQ ? OR  sic_bran.uwm100.comdat EQ ? THEN sic_bran.uwd132.prem_c = n_orgnap.
IF nvtariff = "Z" OR nvtariff = "X" THEN DO:
   sic_bran.uwd132.prem_c = n_orgnap.
END.
ELSE DO:
  IF sic_bran.uwm100.expdat NE ? AND sic_bran.uwm100.comdat NE ? THEN DO:
    ASSIGN n_dcover = 0
           n_dyear  = 0
           nvyear   = 0
           n_dmonth = 0.
                IF ( DAY(sic_bran.uwm100.comdat)     =   DAY(sic_bran.uwm100.expdat)    AND
                   MONTH(sic_bran.uwm100.comdat)     = MONTH(sic_bran.uwm100.expdat)    AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )  OR
                   ( DAY(sic_bran.uwm100.comdat)     =   29                             AND
                   MONTH(sic_bran.uwm100.comdat)     =   02                             AND
                     DAY(sic_bran.uwm100.expdat)     =   01                             AND
                   MONTH(sic_bran.uwm100.expdat)     =   03                             AND
                    YEAR(sic_bran.uwm100.comdat) + 1 =  YEAR(sic_bran.uwm100.expdat) )
                THEN DO:
                  n_dcover = 365.
                END.
                ELSE DO:
                  n_dcover = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  วัน */
                END.
    FIND sicsyac.xmm031 USE-INDEX xmm03101 WHERE
         sicsyac.xmm031.poltyp EQ sic_bran.uwm100.poltyp
    NO-LOCK NO-ERROR.
    IF AVAILABLE sicsyac.xmm031 THEN DO:
       IF n_dcover = 365  THEN   
      n_ddyr   = YEAR(TODAY).
      n_ddyr1  = n_ddyr + 1.
      n_dyear  = 365.   
      FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
           sicsyac.xmm105.tariff EQ nvtariff      AND
           sicsyac.xmm105.bencod EQ sic_bran.uwd132.bencod
      NO-LOCK NO-ERROR.
      IF  sic_bran.uwm100.short = NO OR sicsyac.xmm105.shorta = NO THEN DO:
          sic_bran.uwd132.prem_c = (n_orgnap * n_dcover) / n_dyear .  
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701     WHERE
                   sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                   sicsyac.xmm127.daymth =  YES                    AND
                   sicsyac.xmm127.nodays GE n_dcover
        NO-LOCK NO-ERROR.
        IF AVAILABLE sicsyac.xmm127 THEN DO:
           sic_bran.uwd132.prem_c =  (n_orgnap * sicsyac.xmm127.short) / 100 .
        END.
        ELSE DO:
          IF YEAR(sic_bran.uwm100.expdat) <> YEAR(sic_bran.uwm100.comdat) THEN DO:
            nvyear = YEAR(sic_bran.uwm100.expdat) - YEAR(sic_bran.uwm100.comdat).
            IF nvyear > 1 THEN
               n_dmonth = (12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1) + ((nvyear - 1) * 12).
            ELSE
               n_dmonth =  12 - MONTH(sic_bran.uwm100.comdat) +
                                MONTH(sic_bran.uwm100.expdat) + 1.
          END.
          ELSE n_dmonth = MONTH(sic_bran.uwm100.expdat) - MONTH(sic_bran.uwm100.comdat) + 1.
          FIND FIRST sicsyac.xmm127 USE-INDEX xmm12701      WHERE
                     sicsyac.xmm127.poltyp =  sic_bran.uwm100.poltyp AND
                     sicsyac.xmm127.daymth =  NO            AND
                     sicsyac.xmm127.nodays GE n_dmonth
          NO-LOCK NO-ERROR.
          IF AVAILABLE xmm127 THEN DO:
             sic_bran.uwd132.prem_c = (n_orgnap * sicsyac.xmm127.short) / 100.
             HIDE MESSAGE NO-PAUSE.
             PAUSE.
          END.
          ELSE DO:
             sic_bran.uwd132.prem_c =  (n_orgnap * n_dcover) / n_dyear.
          END.

        END.
      END.
      IF s_curbil = "BHT" THEN  sic_bran.uwd132.prem_c = sic_bran.uwd132.prem_c.
    END.
  END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

