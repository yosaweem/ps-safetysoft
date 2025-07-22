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
/*          This .W file was created with the Progress AppBuilder.      */
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
/* wgwtdls2.w  : Load Text file Isuzu siam city[renew]                      */
/* Copyright   : Safety Insurance Public Company Limited                    */
/*               บริษัท ประกันคุ้มภัย จำกัด (มหาชน)                         */
/* WRITE  BY   : Kridtiya i.A57-0464  16/12/2014                            */
/*             : ส่วนการค้นหาค่า งานต่ออายุเพื่อให้ค่า กรมธรรม์ต่ออายุใหม่  */
/* modify by   : Kridtiya i. A58-0069 ปรับให้ใช้ข้อมูล ลักษณะการใช้รถจากใบเตือน*/
/* modify by   : kridtiya i. A58-0166 รับข้อมูลรุนรถจากกรมธรรม์ เดิม        */
/* Modify by   : Kridtiya i. A58-0206 แก้ไขการให้ค่าเลขตัวถัง 
                 จากเดิม sic_bran.uwm301.trareg    = trim(wdetail.vehreg) 
                 เป็น    sic_bran.uwm301.trareg    = trim(nv_uwm301trareg)    */
/* Modify by   : Kridtiya i. A58-0334 date. 07/09/2015 add Transaction Type (N/R/E/C/T) */ 
/* Modify by  : Ranu I. A61-0094 Date: 21/02/2018  แก้ไขงาน พรบ. ให้ใช้โค้ดลูกค้าเดิม */
/*Modify By : Porntiwa T. A62-0105  Date : 18/07/2019
            : Change Host => TMSth*/
/* Modify by : Ranu I. a63-0122 แก้ไขกรมธรรม์ต่ออายุที่คุ้มครองตั้งแต่ 01/04/2020 
            ให้ใช้ Pack T */
/* Modify by : Ranu I. a63-0147 งานต่ออายุ Pack A เดิม  */
/*Modify by   : Kridtiya i. A63-0472 Date. 09/11/2020 add field firstname ,lastname.....*/
/*Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย */
/*ProcDif*/
/* -------------------------------------------------------------------------------------*/
/*******************************************************************************************/
{wgw\wgwtdls2.i}      /*ประกาศตัวแปร*/
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
DEFINE NEW SHARED VAR no_baseprm    AS DECI      FORMAT ">>,>>>,>>9.99-".  
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
DEFINE VAR            s_recid1      as RECID .     /* uwm100  */
DEFINE VAR            s_recid2      as recid .     /* uwm120  */
DEFINE VAR            s_recid3      as recid .     /* uwm130  */  
DEFINE VAR            s_recid4      as recid .     /* uwm301  */                                    
DEFINE New shared var nv_dspc       as deci.
DEFINE New shared var nv_mv1        as int .
DEFINE New shared var nv_mv1_s      as int . 
DEFINE New shared var nv_mv2        as int . 
DEFINE New shared var nv_mv3        as int . 
DEFINE New shared var nv_comprm     as int .  
DEFINE New shared var nv_model      as char.  
DEFINE VAR            nv_lnumber    AS INTE INIT 0.
DEFINE VAR            nv_provi      AS CHAR INIT "".
DEFINE VAR            n_rencnt      LIKE sicuw.uwm100.rencnt INITIAL "".
DEFINE VAR            nv_index      as   int  init  0. 
DEFINE VAR            n_endcnt      LIKE sicuw.uwm100.endcnt  INITIAL "".
DEFINE VAR            n_comdat      LIKE sicuw.uwm100.comdat  NO-UNDO.
DEFINE VAR            n_policy      LIKE sicuw.uwm100.policy  INITIAL "" .
DEFINE VAR            nv_daily      AS  CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEFINE VAR            nv_reccnt     AS  INT  INIT  0.           /*all load record*/
DEFINE VAR            nv_completecnt    AS   INT   INIT  0.     /*complete record */
DEFINE NEW SHARED VAR chr_sticker AS CHAR FORMAT "9999999999999" INIT "".   
DEFINE NEW SHARED var nv_modulo   as int  format "9".
DEFINE VAR            s_riskgp    AS INTE FORMAT ">9".
DEFINE VAR            s_riskno    AS INTE FORMAT "999".
DEFINE VAR            s_itemno    AS INTE FORMAT "999". 
DEFINE VAR            nv_drivage1 AS INTE INIT 0.
DEFINE VAR            nv_drivage2 AS INTE INIT 0.
DEFINE VAR            nv_drivbir1 AS CHAR INIT "".
DEFINE VAR            nv_drivbir2 AS CHAR INIT "".
DEFINE VAR            nv_dept     as char format  "X(1)".
DEFINE NEW SHARED var nv_branch   AS CHAR FORMAT "x(3)" .  
DEFINE VAR nv_undyr    as    char  init  ""    format   "X(4)".
DEFINE VAR n_newpol    Like  sicuw.uwm100.policy  init  "".
DEFINE VAR n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
DEFINE New shared  var      nv_makdes    as   char    .
DEFINE New shared  var      nv_moddes    as   char.
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
DEF VAR np_driver  AS CHAR INIT "".
DEF VAR nv_driver  AS CHAR INIT "" .
DEFINE NEW SHARED WORKFILE ws0m009 NO-UNDO
/*1*/  FIELD policy     AS CHARACTER    INITIAL ""  
/*2*/  FIELD lnumber    AS INTEGER   
       FIELD ltext      AS CHARACTER    INITIAL "" 
       FIELD ltext2     AS CHARACTER    INITIAL "" .

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME fr_main
&Scoped-define BROWSE-NAME br_wdetail

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES wdetail

/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.policy wdetail.cndat wdetail.comdat wdetail.expdat wdetail.covcod wdetail.garage wdetail.tiname wdetail.insnam wdetail.policy   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y"
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail WHERE wdetail.pass = "y".
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS fi_loaddat fi_branch fi_producer fi_agent ~
fi_prevbat fi_bchyr fi_filename bu_file fi_output1 buok bu_exit bu_hpacno1 ~
bu_hpagent bu_hpbrn fi_output2 fi_output3 fi_usrprem fi_usrcnt fi_process ~
br_wdetail fi_bchno RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 RECT-377 ~
RECT-378 
&Scoped-Define DISPLAYED-OBJECTS fi_loaddat fi_branch fi_producer fi_agent ~
fi_prevbat fi_bchyr fi_filename fi_output1 fi_proname fi_agtname fi_brndes ~
fi_output2 fi_output3 fi_usrprem fi_usrcnt fi_process fi_premtot fi_impcnt ~
fi_bchno fi_premsuc fi_completecnt 

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
     SIZE 3.5 BY .95.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 23 BY .91
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
     SIZE 32.67 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

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
     SIZE 17 BY .95
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

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 22.67 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 62 BY .95
     BGCOLOR 2 FGCOLOR 7  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(10)":U 
     VIEW-AS FILL-IN 
     SIZE 16 BY .95
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 50 BY .95
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_usrcnt AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 11.5 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_usrprem AS DECIMAL FORMAT "->,>>>,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 19 BY .95
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 1.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 13.43
     BGCOLOR 18 FGCOLOR 1 .

DEFINE RECTANGLE RECT-373
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 132.5 BY 5.76
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
DEFINE QUERY br_wdetail FOR 
      wdetail SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail c-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.policy        COLUMN-LABEL "Policy No."
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
    WITH NO-ROW-MARKERS SEPARATORS SIZE 130 BY 5
         BGCOLOR 15 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     fi_loaddat AT ROW 2.95 COL 24 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 4 COL 24 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 5.1 COL 24 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 6.14 COL 24 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 7.19 COL 24 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 7.19 COL 59.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 8.24 COL 24 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 8.24 COL 86.67
     fi_output1 AT ROW 9.29 COL 24 COLON-ALIGNED NO-LABEL
     buok AT ROW 9.1 COL 94.5
     bu_exit AT ROW 10.95 COL 94.67
     fi_proname AT ROW 5.1 COL 45.33 COLON-ALIGNED NO-LABEL
     bu_hpacno1 AT ROW 5.1 COL 42.83
     fi_agtname AT ROW 6.14 COL 45.33 COLON-ALIGNED NO-LABEL
     bu_hpagent AT ROW 6.14 COL 42.83
     fi_brndes AT ROW 4 COL 33.33 COLON-ALIGNED NO-LABEL
     bu_hpbrn AT ROW 4 COL 31.5
     fi_output2 AT ROW 10.33 COL 24 COLON-ALIGNED NO-LABEL
     fi_output3 AT ROW 11.38 COL 24 COLON-ALIGNED NO-LABEL
     fi_usrprem AT ROW 12.43 COL 63.17 NO-LABEL
     fi_usrcnt AT ROW 12.43 COL 24 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 13.57 COL 24 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.43 COL 2.17
     fi_premtot AT ROW 22.24 COL 96.17 NO-LABEL NO-TAB-STOP 
     fi_impcnt AT ROW 22.24 COL 58.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_bchno AT ROW 22.24 COL 16.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premsuc AT ROW 23.29 COL 94.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_completecnt AT ROW 23.29 COL 58.5 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     " Load Text & Generate อีซูซู สยามซิตี้(RENEW)...." VIEW-AS TEXT
          SIZE 130 BY .95 AT ROW 1.33 COL 2.33
          BGCOLOR 19 FGCOLOR 4 FONT 6
     "TieS 4 26/02/2024":60 VIEW-AS TEXT
          SIZE 19 BY .95 AT ROW 13.52 COL 93.33 WIDGET-ID 2
          BGCOLOR 18 FGCOLOR 1 FONT 6
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 10.33 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "BHT.":60 VIEW-AS TEXT
          SIZE 5 BY .95 AT ROW 12.43 COL 82.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 22.24 COL 115
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "                     Branch :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 4 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "                Load Date :":35 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 2.95 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " Input File Name Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 8.24 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 22.24 COL 59 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY .91 AT ROW 23.29 COL 115
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 23.29 COL 94.5 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .91 AT ROW 22.24 COL 7
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "Batch Year :" VIEW-AS TEXT
          SIZE 12 BY .95 AT ROW 7.19 COL 60.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Previous Batch No.:" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 7.19 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "          Producer Code :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 5.1 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Total Net Premium Imp  :":60 VIEW-AS TEXT
          SIZE 25 BY .95 AT ROW 12.43 COL 61.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "        Batch File Name :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 11.38 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "             Agent Code  :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 6.14 COL 2.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 23.29 COL 59 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 22.5 BY .91 AT ROW 22.24 COL 94.5 RIGHT-ALIGNED
          BGCOLOR 3 FGCOLOR 1 FONT 6
     "      Output Data Load :" VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 9.29 COL 2.5
          BGCOLOR 8 FGCOLOR 1 
     "     Policy Import Total :":60 VIEW-AS TEXT
          SIZE 22.5 BY .95 AT ROW 12.43 COL 24 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 1
     RECT-372 AT ROW 2.57 COL 1
     RECT-373 AT ROW 16.05 COL 1
     RECT-374 AT ROW 21.86 COL 1
     RECT-376 AT ROW 22 COL 4.5
     RECT-377 AT ROW 8.76 COL 92.83
     RECT-378 AT ROW 10.62 COL 93
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
         TITLE              = "Load Text & Generate งานป้ายแดงอีซูซู สยามซิตี้(NEW)"
         HEIGHT             = 23.95
         WIDTH              = 133
         MAX-HEIGHT         = 45.76
         MAX-WIDTH          = 213.33
         VIRTUAL-HEIGHT     = 45.76
         VIRTUAL-WIDTH      = 213.33
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
/* BROWSE-TAB br_wdetail fi_process fr_main */
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
/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12 BY .95 AT ROW 7.19 COL 60.17 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "     Policy Import Total :"
          SIZE 22.5 BY .95 AT ROW 12.43 COL 24 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Total Net Premium Imp  :"
          SIZE 25 BY .95 AT ROW 12.43 COL 61.83 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY .91 AT ROW 22.24 COL 59 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 22.5 BY .91 AT ROW 22.24 COL 94.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY .91 AT ROW 23.29 COL 59 RIGHT-ALIGNED            */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.5 BY .91 AT ROW 23.29 COL 94.5 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(c-Win)
THEN c-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

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
ON END-ERROR OF c-Win /* Load Text  Generate งานป้ายแดงอีซูซู สยามซิตี้(NEW) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL c-Win c-Win
ON WINDOW-CLOSE OF c-Win /* Load Text  Generate งานป้ายแดงอีซูซู สยามซิตี้(NEW) */
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
    ASSIGN
        nv_batprev  = INPUT fi_prevbat
        fi_process  = "Load Text & Generate อีซูซู สยามซิตี้(RENEW)"
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0.
    FOR EACH ws0m009.
        DELETE ws0m009.
    END.
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
    ASSIGN 
        fi_output1  = INPUT fi_output1
        fi_output2  = INPUT fi_output2
        fi_output3  = INPUT fi_output3.
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
                ASSIGN 
                nv_batcnt   = uzm701.bchcnt  
                nv_batrunno = nv_batrunno + 1 . 
        END.
        ELSE 
            ASSIGN nv_batcnt = 1
                nv_batrunno  = 1.
        ASSIGN nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        ASSIGN nv_batprev = INPUT fi_prevbat.
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
    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    /*FOR EACH wuwd132.
        DELETE wuwd132.
    END.*/
    /*IF      ra_fileload = 1 THEN RUN proc_assign_siam.
    ELSE IF ra_fileload = 2 THEN RUN proc_assign_maha.    */
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
    /* comment by : A64-0138..
    /*Add by Kridtiya i. A63-0472*/
    ELSE DO:
        nv_chkerror = "".
        FOR EACH wdetail :
            RUN wgw\wgwchkagpd  (INPUT wdetail.agent  
                                 ,INPUT wdetail.producer
                                 ,INPUT-OUTPUT nv_chkerror).
            IF nv_chkerror <> "" THEN 
                MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
                wdetail.producer SKIP
                wdetail.agent  
                VIEW-AS ALERT-BOX.     
        END.
        IF nv_chkerror <> ""  THEN DO: 
            nv_reccnt = 0.
            MESSAGE "Error Code Producer/Agent :" nv_chkerror VIEW-AS ALERT-BOX.       
            RETURN NO-APPLY.
        END.
    END.
    /*Add by Kridtiya i. A63-0472*/
    .. end A64-0138..*/
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,   /* DATE  */
                           INPUT            nv_batchyr ,   /* INT   */
                           INPUT            fi_producer,   /* CHAR  */ 
                           INPUT            nv_batbrn  ,   /* CHAR  */
                           INPUT            fi_prevbat ,   /* CHAR  *//*Previous Batch*/
                           INPUT            "WGWTDLS2" ,   /* CHAR  */
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
    ASSIGN 
        nv_rectot    = nv_reccnt       
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
         /***--- 08/11/2006 ---***/
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


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat c-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
    fi_loaddat  =  Input  fi_loaddat.
    Disp  fi_loaddat  with  frame  fr_main.
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
        IF LENGTH(nv_batprev) > 20 THEN DO:
            MESSAGE "Length Of Batch no. Must Be 20 Character " SKIP
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
      gv_prgid = "wgwtdls2.w"
      gv_prog  = "Load Text & Generate งานต่ออายุ ของอีซูซู สยามซิตี้(RENEW)"
      fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
  RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog).  
  ASSIGN
      fi_branch    = "19" 
      fi_producer    = "A019000012"
      fi_agent       = "B319000001"
      fi_bchyr       = YEAR(TODAY)
      fi_process   = "Load Text file งานป้ายแดง ของอีซูซู สยามซิตี้".
      /*fi_pack      = "T" */ . /*A63-0122 */ /* A63-00472 */
  
  DISP fi_process 
       fi_branch     
       fi_producer   
       fi_agent 
       fi_bchyr  /*fi_pack /*a63-0122 */*//* A63-00472 */
       WITH FRAME fr_main.
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
  DISPLAY fi_loaddat fi_branch fi_producer fi_agent fi_prevbat fi_bchyr 
          fi_filename fi_output1 fi_proname fi_agtname fi_brndes fi_output2 
          fi_output3 fi_usrprem fi_usrcnt fi_process fi_premtot fi_impcnt 
          fi_bchno fi_premsuc fi_completecnt 
      WITH FRAME fr_main IN WINDOW c-Win.
  ENABLE fi_loaddat fi_branch fi_producer fi_agent fi_prevbat fi_bchyr 
         fi_filename bu_file fi_output1 buok bu_exit bu_hpacno1 bu_hpagent 
         bu_hpbrn fi_output2 fi_output3 fi_usrprem fi_usrcnt fi_process 
         br_wdetail fi_bchno RECT-370 RECT-372 RECT-373 RECT-374 RECT-376 
         RECT-377 RECT-378 
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
ASSIGN classmat72  = wdetail.class   /* class 140A */
    wdetail.PASS   = "Y"
    wdetail.tariff = "9"
    wdetail.covcod = "T"
    wdetail.compul = "y"
    fi_process = "Process data Siam Carrent Group....compulsary "  + wdetail.policy .
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
IF      trim(wdetail.class) = "110E"      THEN classmat72 = "110E".
ELSE IF trim(wdetail.class) = "110"       THEN classmat72 = "110".
ELSE IF trim(wdetail.class) = "140A"      THEN classmat72 = "210".
ELSE IF substr(wdetail.class,1,3) = "120" THEN classmat72 = "320".
ELSE IF substr(wdetail.class,1,3) = "140" THEN classmat72 = "210".
ELSE DO:
    FIND FIRST sicsyac.xzmcom WHERE  
        sicsyac.xzmcom.comp_cod = substr(wdetail.class,1,1) + "." + substr(wdetail.class,2)   NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xzmcom  THEN 
        ASSIGN classmat72 = SUBSTR(sicsyac.xzmcom.class,2,3) .
    ELSE classmat72 = "".
END.
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
        /*stat.maktab_fil.sclass   =  SUBSTR(classmat72 ,2,3)                     AND*/
        stat.maktab_fil.sclass    =  classmat72                AND
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
            /*stat.maktab_fil.sclass   =  SUBSTR(classmat72 ,2,3)    */
            stat.maktab_fil.sclass   =   classmat72  
        /*   (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)   AND
            stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  AND  
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
        ELSE DO: 
            /*A67-0050*/
            Find FIRST stat.maktab_fil Use-index      maktab04         Where
                stat.maktab_fil.makdes   =     trim(wdetail.brand)     And                  
                index(stat.maktab_fil.moddes,wdetail.model) <> 0       And
                stat.maktab_fil.makyea   =   Integer(wdetail.caryear)  AND
                stat.maktab_fil.engine   =  deci(wdetail.engcc)        AND
                stat.maktab_fil.sclass   =   classmat72       No-lock no-error no-wait.
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
            /*A67-0050*/
        END.
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
IF NOT AVAILABLE sic_bran.uwm130 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm130.
        ASSIGN  sic_bran.uwm130.policy   = sic_bran.uwm120.policy
            sic_bran.uwm130.rencnt   = sic_bran.uwm120.rencnt   
            sic_bran.uwm130.endcnt   = sic_bran.uwm120.endcnt
            sic_bran.uwm130.riskgp   = sic_bran.uwm120.riskgp   
            sic_bran.uwm130.riskno   = sic_bran.uwm120.riskno
            sic_bran.uwm130.itemno   = s_itemno 
            sic_bran.uwm130.bchyr    = nv_batchyr     /* batch Year */
            sic_bran.uwm130.bchno    = nv_batchno     /* bchno      */
            sic_bran.uwm130.bchcnt   = nv_batcnt      /* bchcnt     */
            sic_bran.uwm130.uom6_v   = 0
            sic_bran.uwm130.uom7_v   = 0
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class  NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm016 THEN 
            ASSIGN  sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
            sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
            nv_comper              = deci(sicsyac.xmm016.si_d_t[8]) 
            nv_comacc              = deci(sicsyac.xmm016.si_d_t[9])                                           
            sic_bran.uwm130.uom8_v = nv_comper   
            sic_bran.uwm130.uom9_v = nv_comacc  .   
        ASSIGN nv_riskno = 1
            nv_itemno    = 1.
        IF wdetail.covcod = "1" Then 
            RUN wgs/wgschsum(INPUT  wdetail.policy,         
                             nv_riskno,
                             nv_itemno).
        /* ---------------------------------------------  U W M 3 0 1 --------------*/ 
        ASSIGN s_recid3  = RECID(sic_bran.uwm130) 
            nv_covcod    =   wdetail.covcod
            nv_makdes    =  wdetail.brand
            nv_moddes    =  wdetail.model
            nv_newsck    = " ".
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
                ASSIGN  sic_bran.uwm301.policy   = sic_bran.uwm120.policy                   
                    sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
                    sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
                    sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
                    sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
                    sic_bran.uwm301.itemno   = s_itemno
                    sic_bran.uwm301.tariff   = wdetail.tariff
                    sic_bran.uwm301.covcod   = nv_covcod
                    sic_bran.uwm301.cha_no   = wdetail.chassis
                    sic_bran.uwm301.eng_no   = wdetail.engno
                    /*sic_bran.uwm301.Tons     = INTEGER(wdetail.tonn)*/ /*A67-0050*/ 
                    sic_bran.uwm301.Tons     = IF      SUBSTR(wdetail.class,2,3) = "110" THEN 0  /*A67-0050*/
                                               ELSE IF SUBSTR(wdetail.class,2,3) = "210" THEN 0  /*A67-0050*/ 
                                               ELSE INTEGER(wdetail.tonn)
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
                    sic_bran.uwm301.bchcnt   = nv_batcnt         /* bchcnt     */  
                    s_recid4                 = RECID(sic_bran.uwm301).
                /*-----compul-----*/
                IF wdetail.compul = "y" THEN DO:
                    sic_bran.uwm301.cert = "".
                    IF LENGTH(wdetail.stk) = 11 THEN 
                        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
                    ELSE IF LENGTH(wdetail.stk) = 13  THEN  
                        sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
                    IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".  
                    ELSE DO:  /*--create detaitem--*/ 
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
                END.
                ELSE  sic_bran.uwm301.drinam[9] = "".
                IF wdetail.redbook = "" THEN DO:
                    FIND LAST sicsyac.xmm102   WHERE
                        INDEX(wdetail.model,trim(substr(sicsyac.xmm102.modest,INDEX(sicsyac.xmm102.modest," ") + 1 ))) <> 0   AND 
                        INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0  NO-LOCK   NO-ERROR.
                    IF AVAIL sicsyac.xmm102 THEN DO:
                        ASSIGN sic_bran.uwm301.modcod      = sicsyac.xmm102.modcod
                            /*sic_bran.uwm301.Tons           = sicsyac.xmm102.tons*/ /*A67-0050*/ 
                            sic_bran.uwm301.body           = sicsyac.xmm102.body     
                            sic_bran.uwm301.vehgrp         = sicsyac.xmm102.vehgrp
                            wdetail.redbook                = sicsyac.xmm102.modcod
                            wdetail.brand                  = IF LENGTH(xmm102.modest) >= 18 THEN SUBSTRING(xmm102.modest,1,18) ELSE xmm102.modest  .  
                    END.
                    ELSE  wdetail.redbook = "" .
                    IF   wdetail.redbook = "" THEN DO:  
                        FIND LAST sicsyac.xmm102   WHERE INDEX(sicsyac.xmm102.modest,wdetail.brand) <> 0  NO-LOCK   NO-ERROR.
                        IF AVAIL sicsyac.xmm102  THEN DO:
                            ASSIGN sic_bran.uwm301.modcod = sicsyac.xmm102.modcod
                                /*sic_bran.uwm301.Tons   = sicsyac.xmm102.tons*/ /*A67-0050*/ 
                                sic_bran.uwm301.body   = sicsyac.xmm102.body
                                sic_bran.uwm301.vehgrp = sicsyac.xmm102.vehgrp
                                sic_bran.uwm301.engine = sicsyac.xmm102.engine 
                                wdetail.tonn           = sicsyac.xmm102.tons  
                                wdetail.engcc          = string(sicsyac.xmm102.engine)
                                wdetail.redbook        = sicsyac.xmm102.modcod   .  
                        END.
                    END.
                END.
            END.    /*transaction*/  
        END. /*301 */ 
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
    END.  /*do transaction*/
END.
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
  Notes: add by A64-0138       
------------------------------------------------------------------------------*/
DEF BUFFER wf_uwd132 FOR sic_bran.uwd132.
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
    /*FOR EACH wuwd132.
        DELETE wuwd132.
    END.*/
    RUN proc_assinginit.
    INPUT FROM VALUE(fi_FileName).
    REPEAT:
        IMPORT DELIMITER "|" 
            nv_number                                                                         
            nv_brdealer           
            nv_codefint         
            nv_notimk           
            nv_telmk            
            nv_prepol           
            nv_name1 
            nv_addr1         
            nv_icno          
            nv_datbirth      
            nv_datbirthexp   
            nv_tel           
            nv_nbrand   
            nv_model          
            nv_ncaryear      
            nv_enging        
            nv_class70       
            nv_vehuse70      
            nv_nvehreg       
            nv_nchassis      
            nv_nengno        
            nv_SUMINSURED    
            nv_npremt        
            nv_npremtnet     
            nv_npremtcomp    
            nv_npremtcompnt  
            nv_policy70      
            nv_policy72
            nv_comdat70      
            nv_expdat70 
            nv_bennam        
            nv_memo  
            nv_textf51          
            nv_textf52          
            nv_textf53          
            nv_memof71          
            nv_memof72          
            nv_memof73          
            nv_accessoryf61 
            nv_accessoryf62 
            nv_accessoryf63 
            nv_accessoryf64 
            nv_accessoryf65  .    
            
        IF  (INDEX(nv_number,"แบบ")         <> 0 ) OR (INDEX(nv_number,"ชื่อ")     <> 0 ) OR  
            (INDEX(nv_number,"โทร")         <> 0 ) OR (INDEX(nv_number,"No")       <> 0 ) OR 
            (INDEX(nv_number,"เรียน")       <> 0 ) OR (INDEX(nv_number,"ดีลเลอร์") <> 0 ) OR
            (INDEX(nv_number,"ชื่อผู้แจ้ง") <> 0 ) OR (INDEX(nv_number,"ที่")      <> 0 ) OR
            (TRIM(nv_number)   = "" )     THEN RUN proc_assinginit. 
        ELSE IF (trim(nv_policy70) = "" ) AND (trim(nv_policy72) = "" )   THEN RUN proc_assinginit. 
        ELSE DO:
            FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno = "999" AND
                index(TRIM(nv_name1),trim(brstat.msgcode.MsgDesc)) <> 0   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.msgcode THEN 
                ASSIGN 
                nv_title  = TRIM(brstat.msgcode.branch)                                
                nv_name1  = IF LENGTH(trim(brstat.msgcode.MsgDesc)) <> 0 THEN 
                               SUBSTR(TRIM(nv_name1),LENGTH(trim(brstat.msgcode.MsgDesc)) + 1 ) 
                            ELSE TRIM(nv_name1)
                nv_name1  = IF INDEX(nv_name1," ") <> 0 THEN 
                               trim(SUBSTR(nv_name1,1,INDEX(nv_name1," "))) + " " +  trim(SUBSTR(nv_name1,INDEX(nv_name1," "))) 
                            ELSE TRIM(nv_name1) .
            /*Add by Kridtiya i. A63-0472*/
            ASSIGN 
                nv_firstName = ""
                nv_lastName  = "".
            RUN proc_assign2name  (INPUT  nv_title
                                  ,INPUT  nv_name1
                                  ,OUTPUT nv_insnamtyp
                                  ,OUTPUT nv_firstName
                                  ,OUTPUT nv_lastName). 
            ASSIGN nv_postcd = "".
            RUN proc_assign2addr  (INPUT  trim(nv_addr1)
                                  ,INPUT  ""
                                  ,INPUT  ""
                                  ,INPUT  trim(np_occupation) 
                                  ,OUTPUT nv_codeocc  
                                  ,OUTPUT nv_codeaddr1
                                  ,OUTPUT nv_codeaddr2
                                  ,OUTPUT nv_codeaddr3).
            /*Add by Kridtiya i. A63-0472*/
            IF TRIM(nv_addr1) <> "" THEN RUN proc_create70_addmat.
            /*Add by Kridtiya i. A63-0472*/
            IF nv_postcd <> "" THEN DO:
                IF       index(nv_addr4,nv_postcd) <> 0 THEN  nv_addr4   = REPLACE(nv_addr4,nv_postcd,"").
                ELSE IF  index(nv_addr3,nv_postcd) <> 0 THEN  nv_addr3   = REPLACE(nv_addr3,nv_postcd,"").
                ELSE IF  index(nv_addr2,nv_postcd) <> 0 THEN  nv_addr2   = REPLACE(nv_addr2,nv_postcd,"").
                ELSE IF  index(nv_addr1,nv_postcd) <> 0 THEN  nv_addr1   = REPLACE(nv_addr1,nv_postcd,"").
            END.
            /*Add by Kridtiya i. A63-0472*/
            IF trim(nv_policy70)  <> "" THEN RUN proc_create70_s.
            IF trim(nv_policy72) = "-"  THEN nv_policy72 = "".
            IF trim(nv_policy72)  <> "" THEN RUN proc_create72_s.
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

ASSIGN nv_address = trim(np_tambon + " " + np_mail_amper + " " + np_mail_country) .

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
IF      index(np_mail_country,"กรุงเทพ") <> 0 THEN np_mail_country = "กรุงเทพมหานคร".
ELSE IF index(np_mail_country,"กทม")     <> 0 THEN np_mail_country = "กรุงเทพมหานคร".

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
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
     /*DISP sicuw.uwm500.prov_n . */
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
         /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . */
         
        FIND LAST sicuw.uwm506 USE-INDEX uwm50601 WHERE 
            sicuw.uwm506.prov_n   = sicuw.uwm501.prov_n and
            sicuw.uwm506.dist_n   = sicuw.uwm501.dist_n and
            sicuw.uwm506.sdist_d  = np_tambon           NO-LOCK NO-ERROR NO-WAIT. /*"รางหวาย"*/
        IF AVAIL sicuw.uwm506 THEN  
            ASSIGN 
            np_codeaddr1 =  sicuw.uwm506.prov_n   /*= uwm100.codeaddr1 */
            np_codeaddr2 =  sicuw.uwm506.dist_n   /*= uwm100.codeaddr2 */
            np_codeaddr3 =  sicuw.uwm506.sdist_n  /*= uwm100.codeaddr3 */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2name c-Win 
PROCEDURE proc_assign2name :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT  PARAMETER  npp_title        as char init "".
DEFINE INPUT  PARAMETER  npp_flname       as char init "".
DEFINE OUTPUT PARAMETER  npp_insnamtyp    as char init "".
DEFINE OUTPUT PARAMETER  npp_firstname1   as char init "".
DEFINE OUTPUT PARAMETER  npp_lastname1    as char init "".
DEFINE VAR npp_textname  AS CHAR.
ASSIGN npp_textname = npp_title + npp_flname  .
IF  R-INDEX(TRIM(npp_textname),"จก.")             <> 0  OR              
    R-INDEX(TRIM(npp_textname),"จำกัด")           <> 0  OR  
    R-INDEX(TRIM(npp_textname),"(มหาชน)")         <> 0  OR  
    R-INDEX(TRIM(npp_textname),"INC.")            <> 0  OR 
    R-INDEX(TRIM(npp_textname),"CO.")             <> 0  OR 
    R-INDEX(TRIM(npp_textname),"LTD.")            <> 0  OR 
    R-INDEX(TRIM(npp_textname),"LIMITED")         <> 0  OR 
    INDEX(TRIM(npp_textname),"บริษัท")            <> 0  OR 
    INDEX(TRIM(npp_textname),"บ.")                <> 0  OR 
    INDEX(TRIM(npp_textname),"บจก.")              <> 0  OR 
    INDEX(TRIM(npp_textname),"หจก.")              <> 0  OR 
    INDEX(TRIM(npp_textname),"หสน.")              <> 0  OR 
    INDEX(TRIM(npp_textname),"บรรษัท")            <> 0  OR 
    INDEX(TRIM(npp_textname),"มูลนิธิ")           <> 0  OR 
    INDEX(TRIM(npp_textname),"ห้าง")              <> 0  OR 
    INDEX(TRIM(npp_textname),"ห้างหุ้นส่วน")      <> 0  OR 
    INDEX(TRIM(npp_textname),"ห้างหุ้นส่วนจำกัด") <> 0  OR
    INDEX(TRIM(npp_textname),"ห้างหุ้นส่วนจำก")   <> 0  OR  
    INDEX(TRIM(npp_textname),"และ/หรือ")          <> 0  THEN DO: 
    /*  Cs = นิติบุคคล */
    ASSIGN
        npp_insnamtyp = "CO"
        npp_firstname1 = TRIM(npp_flname)
        npp_lastname1  = "".
END.
ELSE DO:
    npp_insnamtyp = "PR".
    IF INDEX(trim(npp_flname)," ") <> 0 THEN
        ASSIGN
        npp_firstname1 = substr(TRIM(npp_flname),1,INDEX(trim(npp_flname)," ")) 
        npp_lastname1  = substr(TRIM(npp_flname),INDEX(trim(npp_flname)," ")) .
    ELSE ASSIGN
        npp_firstname1 = TRIM(npp_flname)
        npp_lastname1  = "".
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
/*
DEF VAR nseats AS INTE INIT 0.
DEF VAR nclas2 AS CHAR INIT "".
ASSIGN 
    nn_cr2       = ""
    nn_covcod    = ""
    nn_garage    = ""
    nn_redbook   = ""
    nn_brand     = ""
    nn_model     = ""
    nn_body      = ""
    nn_vehreg    = ""
    nn_eng       = ""
    nn_chasno    = ""
    nn_caryear   = ""
    nn_comdat    = ?
    nn_firstdat  = ?.
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwsaex1(INPUT-OUTPUT  np_prepol    AS CHAR FORMAT "x(16)" .                        
                     INPUT-OUTPUT  np_insref    AS CHAR FORMAT "x(10)".                         
                     INPUT-OUTPUT  np_title     AS CHAR FORMAT "x(20)" .                        
                     INPUT-OUTPUT  np_name1     AS CHAR FORMAT "x(60)" .                        
                     INPUT-OUTPUT  np_name2     AS CHAR FORMAT "x(60)"  .                       
                     INPUT-OUTPUT  np_name3     AS CHAR FORMAT "x(60)" .                        
                     INPUT-OUTPUT  np_addr1     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_addr2     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_addr3     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_addr4     AS CHAR FORMAT "x(35)" INIT "" .                
                     INPUT-OUTPUT  np_occupn    AS CHAR FORMAT "x(40)"  .                       
                     INPUT-OUTPUT  np_firstdat  AS DATE FORMAT "99/99/9999".                    
                     INPUT-OUTPUT  np_comdat    AS DATE FORMAT "99/99/9999".                    
                     INPUT-OUTPUT  np_expdat    AS DATE FORMAT "99/99/9999".                    
                     INPUT-OUTPUT  np_class     AS CHAR FORMAT "x(4)"      .                    
                     INPUT-OUTPUT  np_redbook    AS CHAR FORMAT "x(10)".                        
                     INPUT-OUTPUT  np_moddes    AS CHAR FORMAT "x(65)".                         
                     INPUT-OUTPUT  np_yrmanu    AS CHAR FORMAT "x(5)".                          
                     INPUT-OUTPUT  np_vehgrp    AS CHAR FORMAT "x"  .                           
                     INPUT-OUTPUT  np_body      AS CHAR FORMAT "x(20)".                         
                     INPUT-OUTPUT  np_engine    AS CHAR FORMAT "x(30)".                         
                     INPUT-OUTPUT  np_tons      AS CHAR FORMAT "x(5)"   INIT "" .               
                     INPUT-OUTPUT  np_seats     AS CHAR FORMAT "x(2)"   INIT "" .               
                     INPUT-OUTPUT  np_vehuse    AS CHAR FORMAT "x"      INIT "" .               
                     INPUT-OUTPUT  np_covcod    AS CHAR FORMAT "x"      INIT "" .               
                     INPUT-OUTPUT  np_garage    AS CHAR FORMAT "x"      INIT "" .               
                     INPUT-OUTPUT  np_vehreg    AS CHAR FORMAT "x(11)"  INIT "" .               
                     INPUT-OUTPUT  np_cha_no    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_eng_no    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_uom1_v    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_uom2_v    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_uom5_v    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_si        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_baseprm   AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_41        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_42        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_43        AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_seat41    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_dedod     AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_addod     AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_dedpd     AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_flet_per  AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_ncbper    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_dss_per   AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_stf_per   AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_cl_per    AS CHAR FORMAT "x(30)"  INIT "" .               
                     INPUT-OUTPUT  np_bennam1   AS CHAR FORMAT "x(60)"  INIT "" .      
                      
END.  */          
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew_pol c-Win 
PROCEDURE proc_assignrenew_pol :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfwdetail FOR wdetail.
def var n_addr1re as char init "" . /*A63-00472*/
def var n_addr2re as char init "" . /*A63-00472*/
def var n_addr3re as char init "" . /*A63-00472*/
def var n_addr4re as char init "" . /*A63-00472*/
DEF VAR nre_premt AS DECI INIT 0.
DEFINE VAR nv_cctvcode    AS CHAR INIT "" .
ASSIGN nv_cctvcode = "".

/*DEF VAR nseats AS INTE INIT 0.
DEF VAR nclas2 AS CHAR INIT "".*/
/*ASSIGN 
    /*nn_cr2       = ""*/
    /*nn_covcod    = ""*/
    /*nn_garage    = ""*/
    /*nn_redbook   = ""*/
    /*nn_brand     = ""*/
    /*nn_model     = ""*/
    /*nn_body      = ""*/
    /*nn_vehreg    = ""*/
    /*nn_eng       = ""*/
    /*nn_chasno    = ""*/
    /*nn_caryear   = ""*/
    /*nn_comdat    = ?*/
    nn_firstdat  = ?  .*/
RUN proc_assinginit.
IF NOT CONNECTED("sic_exp") THEN RUN proc_sic_exp2.
IF  CONNECTED("sic_exp") THEN DO:
    RUN wgw\wgwtdlex (INPUT-OUTPUT  wdetail.prepol,      
                     INPUT-OUTPUT  wdetail.inserf,                              
                     INPUT-OUTPUT  wdetail.tiname,                           
                     INPUT-OUTPUT  nv_name1,                              
                     INPUT-OUTPUT  n_addr1re,  /*wdetail.n_addr1,*/ /*A63-00472ใช้ที่อยู่ตามไฟล์*/                   
                     INPUT-OUTPUT  n_addr2re,  /*wdetail.n_addr2,*/ /*A63-00472ใช้ที่อยู่ตามไฟล์*/                      
                     INPUT-OUTPUT  n_addr3re,  /*wdetail.n_addr3,*/ /*A63-00472ใช้ที่อยู่ตามไฟล์*/                      
                     INPUT-OUTPUT  n_addr4re,  /*wdetail.n_addr4,*/ /*A63-00472ใช้ที่อยู่ตามไฟล์*/             
                     INPUT-OUTPUT  wdetail.fristdat,              
                     INPUT-OUTPUT  nv_comdat70,                    
                     INPUT-OUTPUT  nv_expdat70,             
                     INPUT-OUTPUT  nv_class70,                    
                     INPUT-OUTPUT  wdetail.redbook,                 
                     INPUT-OUTPUT  nv_nbrand,    
                     INPUT-OUTPUT  nv_model,
                     INPUT-OUTPUT  nv_ncaryear,                
                     INPUT-OUTPUT  wdetail.cargrp,               
                     INPUT-OUTPUT  wdetail.body,                      
                     INPUT-OUTPUT  nv_enging,                 
                     INPUT-OUTPUT  wdetail.Tonn,                       
                     INPUT-OUTPUT  wdetail.seat,                   
                     INPUT-OUTPUT  nv_vehuse70,                    
                     INPUT-OUTPUT  wdetail.covcod,                      
                     INPUT-OUTPUT  wdetail.garage,                  
                     INPUT-OUTPUT  nv_nvehreg,                      
                     INPUT-OUTPUT  nv_nchassis,                       
                     INPUT-OUTPUT  nv_nengno,                     
                     INPUT-OUTPUT  wdetail.uom1_v,                  
                     INPUT-OUTPUT  wdetail.uom2_v,       
                     INPUT-OUTPUT  wdetail.uom5_v,      
                     INPUT-OUTPUT  n_siins,         
                     INPUT-OUTPUT  wdetail.base,        
                     INPUT-OUTPUT  wdetail.nv_41,          
                     INPUT-OUTPUT  wdetail.nv_42,                       
                     INPUT-OUTPUT  wdetail.nv_43,                      
                     INPUT-OUTPUT  wdetail.seat41 , 
                     INPUT-OUTPUT  wdetail.benname,
                     INPUT-OUTPUT  nn_dedod,            
                     INPUT-OUTPUT  nn_addod,            
                     INPUT-OUTPUT  nn_dedpd,            
                     INPUT-OUTPUT  n_feet,           
                     INPUT-OUTPUT  n_ncb,            
                     INPUT-OUTPUT  n_dspc,                     
                     INPUT-OUTPUT  nv_stf_per,       /*nn_stf_per,  */     
                     INPUT-OUTPUT  nv_cl_per,        /*nn_cl_per,*/
                     INPUT-OUTPUT  nv_prm1,  
                     INPUT-OUTPUT  nv_prm2,  
                     INPUT-OUTPUT  nv_prm3,  
                     INPUT-OUTPUT  nv_prm4,  
                     INPUT-OUTPUT  nv_prm5,  
                     INPUT-OUTPUT  nv_prm6, 
                     INPUT-OUTPUT  nv_prm7, 
                     INPUT-OUTPUT  nv_prm8,  
                     INPUT-OUTPUT  nv_prm9, 
                     INPUT-OUTPUT  nv_prm10,
                     INPUT-OUTPUT  nv_driver,
                     INPUT-OUTPUT  nre_premt,
                     INPUT-OUTPUT  nv_cctvcode ). /*Add by Kridtiya i. A67-0050*/
    ASSIGN wdetail.premt = string(nre_premt)
           wdetail.cctvcode = trim(nv_cctvcode) .
    IF wdetail.insnam  = "" THEN ASSIGN wdetail.insnam = nv_name1  . 
    /*IF wdetail.n_addr1 = "" THEN  
        ASSIGN 
        wdetail.n_addr1 = nv_addr1   
        wdetail.n_addr2 = nv_addr2                        
        wdetail.n_addr3 = nv_addr3                        
        wdetail.n_addr4 = nv_addr4  . */
    IF wdetail.comdat  = "" THEN ASSIGN wdetail.comdat  = nv_comdat70.                  
    IF wdetail.expdat  = "" THEN ASSIGN wdetail.expdat  = nv_expdat70.  
    /* A58-0069 kridtiya i.
    IF wdetail.class   = "" THEN ASSIGN wdetail.class   = nv_class70 .  
    IF wdetail.brand   = "" THEN ASSIGN wdetail.brand   = nv_nbrand  .   
    IF wdetail.model   = "" THEN ASSIGN wdetail.model   = nv_model   . 
    IF wdetail.caryear = "" THEN ASSIGN wdetail.caryear = nv_ncaryear.  
    IF wdetail.engcc   = "" THEN ASSIGN wdetail.engcc   = nv_enging  .  
    IF wdetail.vehuse  = "" THEN ASSIGN wdetail.vehuse  = nv_vehuse70.     
    IF wdetail.vehreg  = "" THEN ASSIGN wdetail.vehreg  = nv_nvehreg .                       
    IF wdetail.chassis = "" THEN ASSIGN wdetail.chassis = nv_nchassis.                    
    IF wdetail.engno   = "" THEN ASSIGN wdetail.engno   = nv_nengno  .  
    end.... comment by kridtiya i. A58-0069*/                 
    IF ( wdetail.si = "" ) AND ( wdetail.fi = "" ) THEN 
        ASSIGN 
        wdetail.si = n_siins 
        wdetail.fi = n_siins. 
    /*kridtiya i. A58-0069*/
    IF wdetail.vehreg  = "" THEN ASSIGN wdetail.vehreg  = nv_nvehreg . 
    ASSIGN 
        wdetail.class   = nv_class70 
        wdetail.brand   = nv_nbrand      
        wdetail.model   = nv_model      
        wdetail.caryear = nv_ncaryear   
        wdetail.engcc   = nv_enging 
        wdetail.vehuse  = nv_vehuse70 
        wdetail.chassis = nv_nchassis
        wdetail.engno   = nv_nengno   
        wdetail.si      = n_siins 
        wdetail.fi      = n_siins. 
    /* add A63-0128 */
    /*IF DATE(wdetail.comdat) >= 04/01/2020 AND wdetail.CLASS <> "A" THEN DO:*/ /*A63-0147 */
    /*comment by Kridtiya i. A63-00472
    IF DATE(wdetail.comdat) >= 04/01/2020 AND SUBSTR(wdetail.CLASS,1,1) <> "A" THEN DO: /*A63-0147 */
        ASSIGN wdetail.CLASS = trim(fi_pack) + SUBSTR(wdetail.CLASS,2,3) .
    END.
    A63-00472 ...*/
    /* end A63-0128 */
    /*kridtiya i. A58-0069*/
    IF  nv_prm1    <> ""  OR nv_prm2    <> ""  OR nv_prm3   <> ""  OR
        nv_prm4    <> ""  OR nv_prm5    <> ""  OR nv_prm6   <> ""  OR
        nv_prm7    <> ""  OR nv_prm8    <> ""  OR nv_prm9   <> ""  OR nv_prm10   <> ""  THEN DO:
        FIND LAST wtextaccf6 WHERE wtextaccf6.n_policytxt = wdetail.policy   NO-ERROR NO-WAIT.
        IF NOT AVAIL wtextaccf6  THEN DO:
            CREATE wtextaccf6.
            ASSIGN           
                wtextaccf6.n_policytxt = trim(wdetail.policy)  
                wtextaccf6.n_textacc1  = trim(nv_prm1)        /* อุปกรณ์ตกแต่ง */        
                wtextaccf6.n_textacc2  = trim(nv_prm2)
                wtextaccf6.n_textacc3  = trim(nv_prm3)
                wtextaccf6.n_textacc4  = trim(nv_prm4)
                wtextaccf6.n_textacc5  = trim(nv_prm5)
                wtextaccf6.n_textacc6  = trim(nv_prm6)  
                wtextaccf6.n_textacc7  = trim(nv_prm7)  
                wtextaccf6.n_textacc8  = trim(nv_prm8)  
                wtextaccf6.n_textacc9  = trim(nv_prm9)  
                wtextaccf6.n_textacc10 = trim(nv_prm10).
        END.
        ELSE 
            ASSIGN           
                wtextaccf6.n_textacc1  = trim(nv_prm1)        /* อุปกรณ์ตกแต่ง */        
                wtextaccf6.n_textacc2  = trim(nv_prm2)
                wtextaccf6.n_textacc3  = trim(nv_prm3)
                wtextaccf6.n_textacc4  = trim(nv_prm4)
                wtextaccf6.n_textacc5  = trim(nv_prm5)
                wtextaccf6.n_textacc6  = trim(nv_prm6)  
                wtextaccf6.n_textacc7  = trim(nv_prm7)  
                wtextaccf6.n_textacc8  = trim(nv_prm8)  
                wtextaccf6.n_textacc9  = trim(nv_prm9)  
                wtextaccf6.n_textacc10 = trim(nv_prm10).
    END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign_maha c-Win 
PROCEDURE proc_assign_maha :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
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
    REPEAT:
        IMPORT DELIMITER "|" 
            nv_number       /*  1   No. */                                                                        
            nv_name1        /*  2   ชื่อผู้เอาประกันภัย */            
            nv_addr1        /*  3   รายละเอียดที่อยู่   */            
            nv_addr2 
            nv_addr3 
            nv_addr4 
            nv_icno         /*  4   เลขที่บัตร  */                    
            nv_nvehreg      /*  5   ทะเบียน */                        
            nv_ncaryear     /*  6   ปี  */                            
            nv_nbrand       /*  7   รุ่น    */                        
            nv_nmodel       /*  8       */                            
            nv_class70      /*  9   ประเภท  */                        
            nv_enging       /*  10  ขนาดเครื่องยนต์ */ 
            nv_nengno       /*  11  เลขตัวถัง   */                    
            nv_nchassis     /*  12  เลขเครื่องยนต์  */    
            nv_carpric      /*  13  ราคารถยนต์     */                
            nv_SUMINSURED   /*  14  ทุนประกัน  */                    
            nv_npremt       /*  15  เบี้ยประกันสุทธิ   */            
            nv_npremtnet    /*  16  เบี้ยประกันรวม VAT     */             
            nv_npremtcomp   /*  17  พรบสุทธิ   */           
            nv_policy70     /*  18  เลขกรมธรรม์ 70*/                   
            nv_policy72     /*  18  เลขกรมธรรม์ 72*/        
            nv_stkno        /*  19  เลขสติ๊กเกอร์   */    
            nv_comdat70     /*  20  วันที่เริ่มคุ้มครอง */            
            nv_expdat70     /*  21  วันที่สิ้นสุด   */                
            nv_bennam       /*  22  ผู้รับผลประโยชน์    */            
            nv_paybuy       /*  23  ผู้ชำระเบี้ย    */                
            nv_vatname      /*  24  ออกบิลในนาม */                    
            nv_memof71     /*  25  หมายเหตุ    */  
            nv_memof71  
            nv_memof72   
            nv_memof73  
            nv_memof74  
            nv_memof75.
        IF  (INDEX(nv_number,"ที่")   <> 0 ) OR (INDEX(nv_number,"ลำดับ")    <> 0 ) OR  
            (INDEX(nv_number,"No")    <> 0 ) OR (INDEX(nv_number,"แบบ")      <> 0 ) OR 
            (INDEX(nv_number,"เรียน") <> 0 ) OR (INDEX(nv_number,"ดีลเลอร์") <> 0 ) OR
            (INDEX(nv_number,"ชื่อผู้แจ้ง") <> 0 ) OR (TRIM(nv_number)   = "" )     THEN RUN proc_assinginit. 
        ELSE IF (trim(nv_policy70) = "" ) AND (trim(nv_policy72) = "" )  THEN RUN proc_assinginit. 
        ELSE DO:
            RUN proc_cutcharpol.  
            /*RUN proc_create70_addmat.*/
            FIND FIRST brstat.msgcode WHERE brstat.msgcode.compno = "999" AND
                index(TRIM(nv_name1),trim(brstat.msgcode.MsgDesc)) <> 0   NO-LOCK NO-WAIT NO-ERROR.
            IF AVAIL brstat.msgcode THEN 
                ASSIGN 
                nv_title  = TRIM(brstat.msgcode.branch)                                
                nv_name1  = IF LENGTH(trim(brstat.msgcode.MsgDesc)) <> 0 THEN 
                                 SUBSTR(TRIM(nv_name1),LENGTH(trim(brstat.msgcode.MsgDesc)) + 1 ) 
                            ELSE TRIM(nv_name1) 
                nv_name1  = IF INDEX(nv_name1," ") <> 0 THEN 
                            trim(SUBSTR(nv_name1,1,INDEX(nv_name1," "))) + " " +  trim(SUBSTR(nv_name1,INDEX(nv_name1," "))) 
                            ELSE TRIM(nv_name1)   .
            IF trim(nv_bennam) <> "" THEN DO:
                FIND FIRST stat.company USE-INDEX Company01 WHERE  
                    stat.company.CompNo = trim(nv_bennam)    NO-LOCK NO-WAIT NO-ERROR.
                IF AVAIL   stat.company  THEN 
                    ASSIGN nv_bennam  = trim(stat.company.NAME) .
            END.
            IF trim(nv_policy70)  <> "" THEN RUN proc_create70_maha.
            IF trim(nv_policy72)  <> "" THEN RUN proc_create72_maha.
            RUN proc_assinginit. 
        END.
    END.       /* repeat   */
END.*/
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
    nv_number       = ""    /*  No.     */
    nv_brdealer     = ""    /*  สาขา    */
    nv_codefint     = ""    /*  รหัสสาขา        */
    nv_notimk       = ""    /*  ชื่อผู้แจ้ง (Sale)      */
    nv_telmk        = ""    /*  เบอร์โทร        */
    nv_prepol       = ""    /*  เลขที่กรมธรรม์เดิม      */
    nv_insef        = ""    
    nv_title        = ""    
    nv_name1        = ""    /*  ชื่อ - สกุล ผู้เอาประกันภัย     */
    nv_addr1        = ""    /*  ที่อยู่ */
    nv_addr2        = ""  
    nv_addr3        = "" 
    nv_addr4        = ""  
    nv_icno         = ""    /*  เลขที่บัตรประชาชน       */
    nv_datbirth     = ""    /*  วัน/เดือน/ปีเกิด        */
    nv_datbirthexp  = ""    /* วันหมดอายุบัตร   */
    nv_tel          = ""    /*  เบอร์โทรศัพท์ลูกค้า     */
    nv_nbrand       = ""    /*  ยี่ห้อ  */
    nv_nmodel       = ""    /*  รุ่น    */
    nv_ncaryear     = ""    /*  ปี      */
    nv_enging       = ""    /*  ขนาดเครื่องยนต์ */
    nv_class70      = ""    /*  ประเภทรถยนต์    */
    nv_vehuse70     = ""    /*  ลักษณะการใช้รถ  */
    nv_nvehreg      = ""    /*  ทะเบียน */
    nv_nchassis     = ""    /*  เลขตัวถัง       */
    nv_nengno       = ""    /*  เลขเครื่องยนต์  */
    nv_SUMINSURED   = ""    /*  ทุนประกัน       */
    nv_npremt       = ""    /*  เบี้ยประกันสุทธิ ป.1    */
    nv_npremtnet    = ""        /*  เบี้ยประกันรวมภาษีอากร ป.1  */
    nv_npremtcomp   = ""        /*  เบี้ยสุทธิ พรบ.     */
    nv_npremtcompnt = ""        /*  เบี้ย พรบ.รวมภาษีอากร       */
    nv_policy70     = ""    /*  เลขกรมธรรม์ ป.1 */
    nv_policy72     = ""    /*  เลขกรมธรรม์ พรบ.        */
    nv_comdat70     = ""    /*  วันที่เริ่มคุ้มครอง     */
    nv_expdat70     = ""    /*  วันที่สิ้นสุด   */
    nv_bennam       = ""    /*  ผู้รับผลประโยชน์        */
    nv_memo          = ""   /*  หมายเหตุ        */
    nv_textf51       = ""   /*  F17_01  */
    nv_textf52       = ""   /*  F17_02  */
    nv_textf53       = ""   /*  F17_03  */
    nv_memof71       = ""   /*  F18_1   */
    nv_memof72       = ""   /*  F18_2   */
    nv_memof73       = ""   /*  F18_3   */
    nv_accessoryf61  = ""   /*  F6_01   */
    nv_accessoryf62  = ""   /*  F6_02   */
    nv_accessoryf63  = ""   /*  F6_03   */
    nv_accessoryf64  = ""   /*  F6_04   */
    nv_accessoryf65  = ""   /*  F6_05   */
    nv_model         = ""  
    n_siins          = "" 
    n_base           = ""    
    n_nv_41          = ""    
    n_nv_42          = ""    
    n_nv_43          = ""    
    n_seat1          = ""    
    nn_dedod         = "" 
    nn_addod         = ""    
    nn_dedpd         = ""    
    n_feet           = ""    
    n_ncb            = ""    
    n_dspc           = ""    
    nn_stf_per       = ""    
    nn_cl_per        = ""   
    n_benname        = "" 
    nv_prm1          = ""  
    nv_prm2          = ""  
    nv_prm3          = ""  
    nv_prm4          = ""  
    nv_prm5          = ""  
    nv_prm6          = ""  
    nv_prm7          = ""  
    nv_prm8          = ""  
    nv_prm9          = ""  
    nv_prm10         = ""  
    nv_driver        = ""
    nv_insnamtyp     = ""    /*Add by Kridtiya i. A63-0472*/
    np_campaign_ov   = ""    /*Add by Kridtiya i. A63-0472*/
    np_occupation    = "" .  /*Add by Kridtiya i. A63-0472*/


   /*Add by Kridtiya i. A63-0472*/       
   /*Add by Kridtiya i. A63-0472*/       
    /*nv_stkno        = ""*/
    /*nv_br           = ""*/
    /*nv_cover        = ""*/
    /*nv_promotion    = ""*/
    /*nv_name2        = ""*/
    /*nv_vatcode      = ""*/
    /*nv_cedpol       = ""*/
    /*nv_seat70       = ""*/
    /*nv_vehuse72     = ""*/
    /*nv_class72      = "" */     
    /*nv_seat72       = "" */     
    /*nv_TPBIPerson   = ""      
    nv_TPBIPerAcc     = ""      
    nv_TPPDPerAcc     = "" */     
    /*nv_carpric      = "" */
    /*nv_FITheft      = ""    */  
    /*nv_n41          = ""      
    nv_n42          = ""      
    nv_n43          = ""      
    nv_nncb         = ""       
    nv_nfeet        = ""      
    nv_ndspc        = ""  */ 
    /*nv_comdat72     = ""      
    nv_expdat72     = ""  */  
    /*nv_net70        = ""      
    nv_net72        = ""       
    nv_accessoryf61 = "" 
    nv_accessoryf62 = "" 
    nv_accessoryf63 = "" 
    nv_accessoryf64 = "" 
    nv_accessoryf65 = "" 
    nv_memof71      = ""      
    nv_memof72      = ""      
    nv_memof73      = ""      
    nv_memof74      = ""      
    nv_memof75      = ""      
    nv_textf51      = ""      
    nv_textf52      = ""      
    nv_textf53      = ""      
    nv_textf54       = ""      
    nv_textf55       = "" 
    nv_com70         = ""    
    nv_com72         = "" */
    /*nv_freeinsby     = "" */  
    /*nv_notifyby      = "" */
    /*nv_paybuy        = "" */  
    /*nv_vatname       = "" */
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
    ASSIGN fi_process = "Create data to base..." + wdetail.policy 
           dod1 =  deci(nn_dedod)      /*A64-0138*/
           dod2 =  deci(nn_addod)      /*A64-0138*/
           dod0 =  deci(nn_dedpd)      /*A64-0138*/
        /*nv_baseprm    = 0*/
        /*nv_baseprm    = DECI(wdetail.base)*/   .
    DISP fi_process WITH FRAM fr_main.
    /*IF ra_renewby = 2 THEN DO:
        IF fi_policymas <> ""  THEN DO:
            ASSIGN 
                nv_baseprm    = 0
                nv_41         = 0
                nv_42         = 0
                nv_43         = 0
                dod1          = 0
                dod2          = 0
                dod0          = 0
                wdetail.fleet = ""
                wdetail.ncb   = ""
                wdetail.dspc  = ""
                nv_stf_per    = 0
                nv_cl_per     = 0.
            FOR EACH sicuw.uwd132 USE-INDEX uwd13290  WHERE
                sicuw.uwd132.policy   = fi_policymas  NO-LOCK .
                IF      sicuw.uwd132.bencod = "base"         THEN ASSIGN nv_baseprm    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                ELSE IF sicuw.uwd132.bencod = "411"          THEN ASSIGN nv_41         = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).  
                ELSE IF sicuw.uwd132.bencod = "42"           THEN ASSIGN nv_42         = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                ELSE IF sicuw.uwd132.bencod = "43"           THEN ASSIGN nv_43         = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                ELSE IF sicuw.uwd132.bencod = "dod"          THEN ASSIGN dod1          = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                ELSE IF sicuw.uwd132.bencod = "dod2"         THEN ASSIGN dod2          = DECI(DECI(np_dedod)  +  DECI(SUBSTRING(sicuw.uwd132.benvar,31,30))).
                ELSE IF sicuw.uwd132.bencod = "dpd"          THEN ASSIGN dod0          = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                ELSE IF sicuw.uwd132.bencod = "flet"         THEN ASSIGN wdetail.fleet = SUBSTRING(sicuw.uwd132.benvar,31,30).
                ELSE IF sicuw.uwd132.bencod = "ncb"          THEN ASSIGN wdetail.ncb   = string(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                ELSE IF sicuw.uwd132.bencod = "dspc"         THEN ASSIGN wdetail.dspc  = string(SUBSTRING(sicuw.uwd132.benvar,31,30)).
                ELSE IF sicuw.uwd132.bencod = "dstf"         THEN ASSIGN nv_stf_per    = DECI(SUBSTRING(sicuw.uwd132.benvar,31,30)).     
                ELSE IF index(sicuw.uwd132.bencod,"cl") <> 0 THEN ASSIGN nv_cl_per     = deci(SUBSTRING(sicuw.uwd132.benvar,31,30)).
            END.    /*RUN proc_assign_polmas.*/
        END.
    END.
    ELSE DO: */
        /*RUN proc_base2_campign.*/
        IF (wdetail.base = "") OR ( deci(wdetail.base) = 0 )  THEN RUN wgs\wgsfbas.
        ELSE  ASSIGN nv_baseprm = deci(wdetail.base) .
    /*END.*/
    IF nv_baseprm = 0  THEN DO:  
        RUN wgs\wgsfbas .
       /* FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
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

    nv_drivvar = "" .
    If nv_drivno = 0   Then 
        Assign 
        wdetail.drivnam  = "N"
        nv_drivvar   = " "
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
        /*RUN proc_usdcod.*/
        RUN proc_usdcodrenew.
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
    ASSIGN  nv_basevar = ""
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
    /* comment by : A64-0138 ..
    RUN WGS\WGSOPER(INPUT nv_tariff,       
                          nv_class,
                          nv_key_b,
                          nv_comdat). 
   ... end A64-0138...*/
    ASSIGN nv_411var = ""       nv_412var  = ""
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
    ASSIGN nv_42var    = " "       /* -------fi_42---------*/
        nv_42cod   = "42" 
        nv_42var1  = "     Medical Expense = " 
        nv_42var2  = STRING(nv_42) 
        SUBSTRING(nv_42var,1,30)   = nv_42var1 
        SUBSTRING(nv_42var,31,30)  = nv_42var2 
        nv_43var    = " ".        /*---------fi_43--------*/
    ASSIGN nv_43var = ""
        nv_43prm   = nv_43
        nv_43cod   = "43"
        nv_43var1  = "     Airfrieght = "
        nv_43var2  =  STRING(nv_43)
        SUBSTRING(nv_43var,1,30)   = nv_43var1
        SUBSTRING(nv_43var,31,30)  = nv_43var2.
    /* comment by : A64-0138 ..
    RUN WGS\WGSOPER(INPUT nv_tariff,    /*pass*//*a490166 note modi*/
                          nv_class,     
                          nv_key_b,     
                          nv_comdat).   /*  RUN US\USOPER(INPUT nv_tariff,*/  
    ....end : A64-0138 ...*/
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
        nv_yrcod   = If nv_caryr <= 10 Then "YR" + String(nv_caryr) Else "YR99"
        Substr(nv_yrvar,1,30)    = nv_yrvar1
        Substr(nv_yrvar,31,30)   = nv_yrvar2.  
    /*-----nv_sicod----------------------------*/  
    Assign nv_sivar = "" 
        nv_totsi = 0
        nv_sicod     = "SI"
        nv_sivar1    = "     Own Damage = "
        nv_sivar2    =  wdetail.si
        SUBSTRING(nv_sivar,1,30)  = nv_sivar1
        SUBSTRING(nv_sivar,31,30) = string(deci(nv_sivar2))
        nv_totsi     =  DECI(wdetail.si).
    /*----------nv_grpcod--------------------*/
    ASSIGN nv_grpvar = ""
        nv_grpcod      = "GRP" + wdetail.cargrp
        nv_grpvar1     = "     Vehicle Group = "
        nv_grpvar2     = wdetail.cargrp
        Substr(nv_grpvar,1,30)  = nv_grpvar1
        Substr(nv_grpvar,31,30) = nv_grpvar2.
    /*-------------nv_bipcod--------------------*/
    ASSIGN nv_bipvar = ""
        nv_bipcod      = "BI1"
        nv_bipvar1     = "     BI per Person = "
        nv_bipvar2     =  string(wdetail.uom1_v)    /*STRING(uwm130.uom1_v)*/
        SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
        SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
    /*-------------nv_biacod--------------------*/
    Assign nv_biavar   = ""
        nv_biacod      = "BI2"
        nv_biavar1     = "     BI per Accident = "
        nv_biavar2     =  string(wdetail.uom2_v)     /* STRING(uwm130.uom2_v)*/
        SUBSTRING(nv_biavar,1,30)  = nv_biavar1
        SUBSTRING(nv_biavar,31,30) = nv_biavar2.
    /*-------------nv_pdacod--------------------*/
    ASSIGN nv_pdavar   = ""
        nv_pdacod      = "PD"
        nv_pdavar1     = "     PD per Accident = "
        nv_pdavar2     =  string(wdetail.uom5_v)         /*STRING(uwm130.uom5_v)*/
        SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
        SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
    /*--------------- deduct ----------------*/
    nv_dedod1var  = "" .
    nv_dedod2var  = "" .
    nv_dedpdvar   = "" .
    IF dod1 <> 0  THEN DO:
        ASSIGN nv_odcod = "DC01"
            nv_prem     =  dod1 .  
        /* comment by : A64-0138...
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
        ... end A64-0138..*/
        ASSIGN nv_ded1prm     = nv_prem
            nv_dedod1_prm     = nv_prem
            nv_dedod1_cod     = "DOD"
            nv_dedod1var1     = "     Deduct OD = "
            nv_dedod1var2     = STRING(dod1)
            SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
            SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
        /*add od*/
        Assign  
            nv_dedod2var   = " "
            nv_cons  = "AD"
            nv_ded   = dod2.
        /* comment by : A64-0138..
        Run  Wgs\Wgsmx025(INPUT  nv_ded,  /* a490166 note modi */
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem). 
        ... end A64-0138...*/ 
        Assign
            nv_aded1prm     = nv_prem
            nv_dedod2_cod   = "DOD2"
            nv_dedod2var1   = "     Add Ded.OD = "
            nv_dedod2var2   =  STRING(dod2)
            SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
            SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
            nv_dedod2_prm   = nv_prem.
        /***** pd *******/
        Assign
            nv_dedpdvar  = " "
            nv_cons  = "PD"
            nv_ded   = dpd0
            /*dod0 = 0*/    .
        /* comment by : A64-0138 ....
        Run  Wgs\Wgsmx025(INPUT  dod0,  
                                 nv_tariff,
                                 nv_class,
                                 nv_key_b,
                                 nv_comdat,
                                 nv_cons,
                          OUTPUT nv_prem).
        nv_ded2prm    = nv_prem.
        ...end A64-0138...*/
        ASSIGN
            nv_dedpd_cod   = "DPD"
            nv_dedpdvar1   = "     Deduct PD = "
            nv_dedpdvar2   =  STRING(dod0)
            SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
            SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2 .
            /*nv_dedpd_prm  = nv_prem.*/ /*A64-0138*/
    END.
    /*---------- fleet -------------------*/
    /*ASSIGN nv_flet_per = DECI(wdetail.fleet) .*/
    ASSIGN nv_flet_per = deci(n_feet) .
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
    /* comment by : A64-0138...
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                               nv_class,
                               nv_covcod,
                               nv_key_b,
                               nv_comdat,
                               nv_totsi,
                               uwm130.uom1_v,
                               uwm130.uom2_v,
                               uwm130.uom5_v).
    ... end A64-0138...*/
    IF nv_flet_per <> 0 THEN 
    ASSIGN
        nv_fletvar                  = " "
        nv_fletvar1                 = "     Fleet % = "
        nv_fletvar2                 =  STRING(nv_flet_per)
        SUBSTRING(nv_fletvar,1,30)  = nv_fletvar1
        SUBSTRING(nv_fletvar,31,30) = nv_fletvar2.
    IF nv_flet   = 0  THEN  nv_fletvar  = " ".
    /*---------------- NCB -------------------*/
    /*IF wdetail.covcod = "3" THEN WDETAIL.NCB = "30".*/
    ASSIGN
        WDETAIL.NCB = n_ncb
        NV_NCBPER   = DECI(n_ncb)
        nv_ncb      = DECI(n_ncb)
        nv_ncbvar   = " ".
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
    /* comment by : A64-0138 ...
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  /*pass*/
                              nv_class,
                              nv_covcod,
                              nv_key_b,
                              nv_comdat,
                              nv_totsi,
                              uwm130.uom1_v,
                              uwm130.uom2_v,
                              uwm130.uom5_v).
    .... end  A64-0138...*/
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
    /* commetn by A64-0138..
    RUN WGS\WGSORPRM.P (INPUT nv_tariff,  
                        nv_class,
                        nv_covcod,
                        nv_key_b,
                        nv_comdat,
                        nv_totsi,
                        uwm130.uom1_v,
                        uwm130.uom2_v,
                        uwm130.uom5_v).
    ... end A64-0138...*/
    /*------------------ dsspc ---------------*/
    ASSIGN nv_dsspcvar = ""
        wdetail.dspc = n_dspc
        nv_dss_per   = deci(wdetail.dspc) .
    /*IF wdetail.commission = 33 THEN 
        ASSIGN wdetail.commission = IF (33 - deci(wdetail.dspc)) > 18 THEN 18 ELSE (33 - deci(wdetail.dspc))  .*/
    IF  nv_dss_per   <> 0  THEN
        Assign
        nv_dsspcvar1   = "     Discount Special % = "
        nv_dsspcvar2   =  STRING(nv_dss_per)
        SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
        SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2.
    /*--------------------------*/
    /*comment by: A64-0138...
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
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
      /*nn_stf_per*/
      nv_stfvar   = " ".
      IF  nv_stf_per   <> 0  THEN
           Assign
                 nv_stfvar1   = "     Discount Staff"          
                 nv_stfvar2   =  STRING(nv_stf_per)           
                 SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1    
                 SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.   
                                                              
      /*--------------------------*/      
      /* comment by : A64-0138 ....
      RUN WGS\WGSORPRM.P (INPUT  nv_tariff,   /*pass*/
                                       nv_class,
                                       nv_covcod,
                                       nv_key_b,
                                       nv_comdat,
                                       nv_totsi,
                                       nv_uom1_v ,       
                                       nv_uom2_v ,       
                                       nv_uom5_v ).
      .... end A64-0138...*/
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
  Notes: Add by A64-0138      
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
         nv_class   = trim(wdetail.class)                                         
         nv_vehuse  = wdetail.vehuse                                    
        /*nv_cstflg  = "C"  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/ 
         nv_engcst  = 1900*/ /* ต้องใส่ค่าตาม nv_cstflg         
         nv_drivno  = 0  */                                      
         nv_driage1 = nv_drivage1                                
         nv_driage2 = nv_drivage2                                   
         nv_yrmanu  = int(wdetail.caryear)                         
         nv_totsi   = sic_bran.uwm130.uom6_v       
         nv_totfi   = sic_bran.uwm130.uom7_v
         nv_vehgrp  = wdetail.cargrp                                                     
         /*nv_access  = IF wdetail.prmtxt <> "" THEN "A" ELSE "" */                                            
         /*nv_supe    = NO*/                                              
         nv_tpbi1si = deci(wdetail.uom1_v)            
         nv_tpbi2si = deci(wdetail.uom2_v)            
         nv_tppdsi  = deci(wdetail.uom5_v)            
         nv_411si   = nv_41       
         nv_412si   = nv_41       
         nv_413si   = 0                       
         nv_414si   = 0                       
         nv_42si    = nv_42                 
         nv_43si    = nv_43                                         
         nv_seat41  = int(wdetail.seat41)                           
         nv_dedod   = dod1                                          
         nv_addod   = dod2                                          
         nv_dedpd   = dpd0                                          
         nv_ncbp    = deci(wdetail.ncb)                             
         nv_fletp   = deci(nv_flet_per)                             
         nv_dspcp   = deci(nv_dss_per)                              
         nv_dstfp   = nv_stf_per                                    
         nv_clmp    = nv_cl_per                                                     
         nv_netprem = DECI(wdetail.premt) /* เบี้ยสุทธิ */                                                
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
                    nv_engine = DECI(wdetail.tonn).
            END.
            nv_engcst = nv_engine .
        END.
    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  substr(wdetail.class,2,5),   
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
                               input  substr(wdetail.class,2,5),    
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
                sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
                nv_vehgrp              =  stat.maktab_fil.prmpac.
        END.
        ELSE DO:
         ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                wdetail.pass    = "N"     
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
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.   */  
  
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
                       OUTPUT nv_uom1_c,  
                       OUTPUT nv_uom2_c,  
                       OUTPUT nv_uom5_c,  
                       OUTPUT nv_uom6_c,
                       OUTPUT nv_uom7_c,
                       OUTPUT nv_status, 
                       OUTPUT nv_message).  
                        
    /*IF nv_gapprm <> DECI(wdetail.premt) THEN DO:*/
    IF nv_status = "no" THEN DO:
        /*MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt + 
        nv_message VIEW-AS ALERT-BOX. 
        ASSIGN  wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
            wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt 
                 wdetail.pass     = "Y"   
                wdetail.OK_GEN  = "N".*/  /*comment by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN  wdetail.comment = wdetail.comment + "|" + nv_message    /*  by Kridtiya i. A65-0035*/          
                wdetail.WARNING = wdetail.WARNING + "|" + nv_message .  /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035 */
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate (input DATE(wdetail.comdat),
                        input DATE(wdetail.expdat),
                        input wdetail.poltyp,
                        OUTPUT nv_chkerror ) .
    IF nv_chkerror <> ""  THEN 
        ASSIGN wdetail.comment = wdetail.comment + "|" + nv_chkerror 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt-01 c-Win 
PROCEDURE proc_calpremt-01 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes: Add by A64-0138      
------------------------------------------------------------------------------*/
/*DEF VAR chk     AS LOGICAL.
DEF VAR n_prem  AS DECI.
DEF VAR n_sclass AS CHAR FORMAT "x(5)" .
DEF VAR n_sumins AS DECI FORMAT ">>>>>>>>>>9.99-" .
DEF VAR n_fitp   AS DECI FORMAT ">>>>>>>>>>9.99-" .
DEF VAR nv_access AS CHAR FORMAT "x(1)" .

FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.

IF wdetail.poltyp = "v70" THEN DO:
    ASSIGN fi_process = "Create data to base..." + wdetail.policy .
    DISP fi_process WITH FRAM fr_main.
    ASSIGN  nv_polday  = 0       nv_411  = 0        nv_dstfp   = 0      nv_uom1_c  = ""
            nv_cstflg  = ""      nv_412  = 0        nv_clmp    = 0      nv_uom2_c  = ""
            nv_engine  = 0       nv_413  = 0        nv_netprem = 0      nv_uom5_c  = ""
            nv_gapprm  = 0       nv_414  = 0        nv_supe    = NO     nv_uom6_c  = ""
            nv_ratatt  = 0       nv_netatt  = 0     nv_fltatt  = 0      nv_uom7_c  = ""
            nv_ncbatt  = 0       nv_dscatt  = 0     nv_fcctv   = NO     n_sclass   = ""
            n_sumins   = 0       n_fitp     = 0     nv_access  = ""
            /*nv_access  = IF wdetail.accdata <> "" THEN "A" ELSE "" */
            n_sumins   = sic_bran.uwm130.uom6_v  /* si */       
            n_fitp     = sic_bran.uwm130.uom7_v  /* fi */
            n_sclass   = trim(wdetail.class)
            nv_411     = deci(nv_41)                                        
            nv_412     = deci(nv_41)      
            nv_netprem = DECI(wdetail.premt) /* เบี้ยสุทธิ */
            nv_flagprm = "N" . /* เบี้ยสุทธิ */

     FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
           clastab_fil.CLASS  = n_sclass     AND
           clastab_fil.covcod = wdetail.covcod    NO-LOCK NO-ERROR.
        IF AVAIL stat.clastab_fil THEN DO:
            IF clastab_fil.unit = "C" THEN DO:
                ASSIGN
                    nv_cstflg = IF SUBSTR(n_sclass,5,1) = "E" THEN "W" ELSE clastab_fil.unit
                    nv_engine = IF SUBSTR(n_sclass,5,1) = "E" THEN DECI(wdetail.engcc) ELSE INT(wdetail.engcc).
            END.
            ELSE IF clastab_fil.unit = "S" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = INT(wdetail.seat).
            END.
            ELSE IF clastab_fil.unit = "T" THEN DO:
                ASSIGN
                    nv_cstflg = clastab_fil.unit
                    nv_engine = DECI(wdetail.engcc).
            END.
        END.
    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook(input  wdetail.brand ,  
                               input  wdetail.model ,  
                               input  INT(wdetail.si) ,  
                               INPUT  wdetail.tariff,  
                               input  wdetail.class,   
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
                               input  wdetail.CLASS,   
                               input  wdetail.caryear, 
                               input  0  ,
                               input  nv_engine , 
                               INPUT-OUTPUT wdetail.redbook) .
        END.

        IF wdetail.redbook <> ""  THEN ASSIGN sic_bran.uwm301.modcod = wdetail.redbook .
        ELSE DO:
         ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                wdetail.pass     = "Y"     
                wdetail.OK_GEN  = "N".

        END.
    END.

    FIND LAST stat.maktab_fil WHERE maktab_fil.makdes   =  wdetail.brand AND 
                                    maktab_fil.sclass   =  trim(SUBSTR(n_sclass,2,4)) NO-LOCK NO-ERROR.
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
    " wdetail.covcod   "  wdetail.covcod      skip  
    " wdetail.class    "  wdetail.class       skip  
    " wdetail.vehuse   "  wdetail.vehuse      skip  
    " nv_cstflg        "  nv_cstflg           skip  /*C=CC ; S=Seat ; T=Tons ; W=Watts*/
    " nv_engine        "  nv_engine           skip  /* ต้องใส่ค่าตาม nv_cstflg  */
    " nv_drivno        "  nv_drivno           skip  
    " nv_drivage1      "  nv_drivage1         skip  
    " nv_drivage2      "  nv_drivage2         skip  
    " wdetail.caryear  "  wdetail.caryear     skip  
    " wdetail.si       "  wdetail.si          skip  
    " wdetail.cargrp   "  wdetail.cargrp      skip  
    " wdetail.prmtxt   "  wdetail.prmtxt      skip  
    " nv_supe          "  nv_supe             skip  /*  supercar = yes/no  */                  
    " wdetail.uom1_v   "  wdetail.uom1_v      skip  
    " wdetail.uom2_v   "  wdetail.uom2_v      skip  
    " wdetail.uom5_v   "  wdetail.uom5_v      skip  
    " nv_411           "  nv_411              skip  /*nv_411si */    
    " nv_412           "  nv_412              skip  /*nv_412si */    
    " nv_413           "  nv_413              skip  /*nv_413si */  
    " nv_414           "  nv_414              skip  /*nv_414si */ 
    " nv_42            "  nv_42               skip  
    " nv_43            "  nv_43               skip  
    " wdetail.seat41   "  wdetail.seat41      skip  
    " dod1             "  dod1                skip  /*nv_dedod */ 
    " dod2             "  dod2                skip  /*nv_addod */  
    " dod0             "  dod0                skip  /*nv_dedpd */                
    " wdetail.ncb      "  wdetail.ncb         skip  
    " wdetail.fleet    "  wdetail.fleet       skip  
    " wdetail.dspc     "  wdetail.dspc        skip  
    " nv_dstfp         "  nv_dstfp            skip  
    " nv_clmp          "  nv_clmp             skip  
    " nv_netprem       "  nv_netprem          skip  
    " nv_gapprm        "  nv_gapprm           skip  
    " nv_flagprm       "  nv_flagprm          skip  
    " wdetail.comdat   "  wdetail.comdat      VIEW-AS ALERT-BOX.     
*/

    RUN wuw\wuwpadp1 (INPUT sic_bran.uwm100.policy,
                     INPUT sic_bran.uwm100.rencnt,
                     INPUT sic_bran.uwm100.endcnt,
                     INPUT nv_riskno ,  
                     INPUT nv_batchyr, 
                     INPUT nv_batchno, 
                     INPUT nv_polday,
                     INPUT-OUTPUT wdetail.covcod,  
                     INPUT-OUTPUT n_sclass ,  
                     INPUT-OUTPUT wdetail.vehuse ,  
                     INPUT-OUTPUT nv_cstflg ,   /*C=CC ; S=Seat ; T=Tons ; W=Watts*/
                     INPUT-OUTPUT nv_engine ,  /* ต้องใส่ค่าตาม nv_cstflg  */
                     INPUT-OUTPUT nv_drivno ,
                     INPUT-OUTPUT nv_drivage1 ,
                     INPUT-OUTPUT nv_drivage2 ,
                     INPUT-OUTPUT nv_pdprm0 ,  /* เบี้ยส่วนลดผู้ขับขี่*/
                     INPUT-OUTPUT wdetail.caryear ,
                     INPUT-OUTPUT n_sumins  ,
                     INPUT-OUTPUT n_fitp   , 
                     INPUT-OUTPUT wdetail.cargrp,  
                     INPUT-OUTPUT nv_access,  
                     INPUT-OUTPUT nv_supe  ,      /*  supercar = yes/no  */                  
                     INPUT-OUTPUT wdetail.uom1_v , 
                     INPUT-OUTPUT wdetail.uom2_v , 
                     INPUT-OUTPUT wdetail.uom5_v ,                 
                     INPUT-OUTPUT nv_411, /*nv_411si */    
                     INPUT-OUTPUT nv_412, /*nv_412si */    
                     INPUT-OUTPUT nv_413,  /*nv_413si */  
                     INPUT-OUTPUT nv_414,  /*nv_414si */ 
                     INPUT-OUTPUT wdetail.nv_42,    
                     INPUT-OUTPUT wdetail.nv_43,    
                     INPUT-OUTPUT wdetail.seat41 ,                
                     INPUT-OUTPUT nn_dedod,   /*nv_dedod */ 
                     INPUT-OUTPUT nn_addod,   /*nv_addod */  
                     INPUT-OUTPUT nn_dedpd,   /*nv_dedpd */                
                     INPUT-OUTPUT n_ncb,                                                                   
                     INPUT-OUTPUT n_feet,                                        
                     INPUT-OUTPUT n_dspc,                                        
                     INPUT-OUTPUT nv_stf_per ,                                  
                     INPUT-OUTPUT nv_cl_per  ,                                 
                     INPUT-OUTPUT nv_netprem , /*เบี้ยสุทธิ*/                    
                     INPUT-OUTPUT nv_gapprm  ,  /*เบี้ยรวม*/                     
                     INPUT-OUTPUT nv_flagprm , /* N = เบี้ยสุทธิ, G = เบี้ยรวม */     
                     INPUT-OUTPUT wdetail.comdat, 
                     INPUT-OUTPUT nv_ratatt,  /* ความคุ้มครองวัตถุอันตราย*/ 
                     INPUT-OUTPUT nv_siatt ,  /* ความคุ้มครองวัตถุอันตราย*/ 
                     INPUT-OUTPUT nv_netatt,  /* ความคุ้มครองวัตถุอันตราย*/ 
                     INPUT-OUTPUT nv_fltatt,  /* ความคุ้มครองวัตถุอันตราย*/ 
                     INPUT-OUTPUT nv_ncbatt,  /* ความคุ้มครองวัตถุอันตราย*/ 
                     INPUT-OUTPUT nv_dscatt,
                     INPUT-OUTPUT nv_fcctv , /* cctv = yes/no */
                     OUTPUT nv_uom1_c,  
                     OUTPUT nv_uom2_c,  
                     OUTPUT nv_uom5_c,  
                     OUTPUT nv_uom6_c, 
                     OUTPUT nv_uom7_c ) . /* ความคุ้มครองวัตถุอันตราย*/

    
    IF nv_gapprm <> DECI(wdetail.premt) THEN DO:
        MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt VIEW-AS ALERT-BOX.
         ASSIGN
                wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + wdetail.premt
                wdetail.pass     = "Y"     
                wdetail.OK_GEN  = "N".
    END.

    ASSIGN 
        sic_bran.uwm130.uom1_c  = nv_uom1_c
        sic_bran.uwm130.uom2_c  = nv_uom2_c
        sic_bran.uwm130.uom5_c  = nv_uom5_c
        sic_bran.uwm130.uom6_c  = nv_uom6_c
        sic_bran.uwm130.uom7_c  = nv_uom7_c .
    
    IF nv_drivno <> 0  THEN ASSIGN sic_bran.uwm301.actprm = nv_pdprm0. 
    
END.*/
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
DO:
    nv_chkerror = "".
    RUN wgw\wgwchkagpd  (INPUT wdetail.agent            
                         ,INPUT wdetail.producer   
                         ,INPUT-OUTPUT nv_chkerror).
    IF nv_chkerror <> "" THEN DO:
        MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
        wdetail.producer SKIP
        wdetail.agent  VIEW-AS ALERT-BOX. 
        ASSIGN wdetail.comment = wdetail.comment + nv_chkerror 
               wdetail.pass    = "N" 
               wdetail.OK_GEN  = "N".
    END.
    
 IF wdetail.dealerno <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.dealerno) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Dealer " + wdetail.dealerno + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code Dealer " + wdetail.dealerno + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
                wdetail.pass    = "N" 
                wdetail.OK_GEN  = "N".
     END.
 END.
 IF wdetail.financecd <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.financecd) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Finance " + wdetail.financecd + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
      IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
       ASSIGN wdetail.comment = wdetail.comment + "| Code Finance " + wdetail.financecd + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
              wdetail.pass    = "N" 
              wdetail.OK_GEN  = "N".
     END.
 END.
 /*IF wdetail.payercod <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.payercod) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Payer " + wdetail.payercod + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
 END.*/
 IF wdetail.vatcode <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE xmm600.acno = TRIM(wdetail.vatcode) NO-LOCK NO-ERROR.
     IF NOT AVAIL xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Vat " + wdetail.vatcode + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
         IF xmm600.closed <> ? AND xmm600.closed < TODAY THEN
         ASSIGN wdetail.comment = wdetail.comment + "| Code VAT " + wdetail.vatcode + " Closed Date: " + STRING(xmm600.closed,"99/99/9999") 
             wdetail.pass    = "N" 
             wdetail.OK_GEN  = "N".
    END.
 END.
 RELEASE sicsyac.xmm600.

END.
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
/*IF wdetail.brand = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    wdetail.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"   
    wdetail.OK_GEN  = "N".*/
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
ASSIGN 
    nv_sclass = wdetail.class
    np_models = "" .            /* A58-0166 by kridtiya i. */

IF INDEX(wdetail.model," ") <> 0 THEN DO: 
    ASSIGN 
        np_models     = ""
        np_models     = wdetail.model
        wdetail.model = TRIM(SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))) .
END. 
ELSE np_models     = wdetail.model .  /* A58-0166 by kridtiya i. */

If  wdetail.drivnam = "y" AND substr(nv_sclass,2,1) = "2"   Then 
    ASSIGN  wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    wdetail.OK_GEN  = "N".
ASSIGN  
        nv_simat  = 0
        nv_simat1 = 0.
    FIND LAST stat.makdes31 USE-INDEX makdes31 WHERE 
        stat.makdes31.moddes =  trim(wdetail.class)  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL stat.makdes31  THEN
        ASSIGN nv_simat  = stat.makdes31.si_theft_p   
               nv_simat1 = stat.makdes31.load_p   .    
    ELSE ASSIGN  
        nv_simat  = 20
        nv_simat1 = 20.
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
    Find First stat.maktab_fil USE-INDEX maktab04    Where
        stat.maktab_fil.makdes   =  trim(wdetail.brand)                           And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0                          And
        stat.maktab_fil.makyea   =  Integer(wdetail.caryear)                      AND 
        stat.maktab_fil.engine   =  deci(wdetail.engcc)                           AND
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
        /*wdetail.brand    =  stat.maktab_fil.moddes*/  
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
END.
IF wdetail.redbook  = "" THEN DO:
    IF INDEX(np_models,"ALL NEW") <> 0 THEN ASSIGN  wdetail.model = trim(replace(np_models,"ALL NEW","")).
    
    Find FIRST stat.maktab_fil Use-index      maktab04         Where
        stat.maktab_fil.makdes   =     trim(wdetail.brand)     And                  
        index(stat.maktab_fil.moddes,wdetail.model) <> 0       And
        stat.maktab_fil.makyea   =   Integer(wdetail.caryear)  AND
        stat.maktab_fil.sclass   =   SUBSTR(wdetail.class,2,3) AND
        (stat.maktab_fil.si - (stat.maktab_fil.si * nv_simat  / 100 ) LE deci(wdetail.si)   AND
         stat.maktab_fil.si + (stat.maktab_fil.si * nv_simat1 / 100 ) GE deci(wdetail.si) )  /*AND  
        stat.maktab_fil.seats    >=    DECI(wdetail.seat) */      No-lock no-error no-wait.
    If  avail stat.maktab_fil  Then 
        ASSIGN 
        wdetail.redbook  =  stat.maktab_fil.modcod
        /*wdetail.brand    =  stat.maktab_fil.makdes  
        wdetail.model    =  stat.maktab_fil.moddes*/
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.body     =  stat.maktab_fil.body 
        wdetail.Tonn     =  stat.maktab_fil.tons
        wdetail.engcc    =  STRING(stat.maktab_fil.engine)
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.seat     =  IF wdetail.seat = "" THEN string(stat.maktab_fil.seats) ELSE wdetail.seat  .
    /*END.*/
END.
ASSIGN wdetail.model = np_models   .
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
    ASSIGN 
        nv_baseprm       = 0
        nv_41            = 0
        nv_42            = 0
        nv_43            = 0
        dod1             = 0
        dod2             = 0
        dod0             = 0
        nv_stf_per       = 0
        nv_cl_per        = 0 
        n_rencnt         = 0  
        n_Endcnt         = 0
        wdetail.n_rencnt = 0
        wdetail.n_endcnt = 0
        wdetail.pass     = "Y"
        np_driver = "" 
        nv_driver = "" .  /*A61-0094*/
    RUN proc_susspect.  /*Add by Kridtiya i. A63-0419 */
    RUN proc_chkcode . /* A64-0138*/
    IF wdetail.poltyp = "v72"  THEN DO:
        RUN proc_cr_2.
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
        sic_bran.uwm130.i_text = wdetail.cctvcode     /* A67-0050 Add Code CCTV*/
        np_driver = TRIM(sic_bran.uwm130.policy) +
                    STRING(sic_bran.uwm130.rencnt,"99" ) +
                    STRING(sic_bran.uwm130.endcnt,"999") +
                    STRING(sic_bran.uwm130.riskno,"999") +
                    STRING(sic_bran.uwm130.itemno,"999")
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
    /*IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN    */
    IF (wdetail.covcod = "1") OR (wdetail.covcod = "5") OR (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR
       (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2")  THEN 
        ASSIGN sic_bran.uwm130.uom1_v = deci(wdetail.uom1_v)  
        sic_bran.uwm130.uom2_v        = deci(wdetail.uom2_v)  
        sic_bran.uwm130.uom5_v        = deci(wdetail.uom5_v) 

        sic_bran.uwm130.uom6_v        = IF      wdetail.covcod = "2.1" THEN inte(wdetail.si)
                                        ELSE IF wdetail.covcod = "2.2" THEN inte(wdetail.si)
                                        ELSE IF wdetail.covcod = "3.1" THEN inte(wdetail.si)  
                                        ELSE IF wdetail.covcod = "3.2" THEN inte(wdetail.si)   
                                        ELSE inte(wdetail.si)
        sic_bran.uwm130.uom7_v        = IF      wdetail.covcod = "2.1" THEN inte(wdetail.fi)
                                        ELSE IF wdetail.covcod = "2.2" THEN inte(wdetail.fi)
                                        ELSE IF wdetail.covcod = "3.1" THEN 0 
                                        ELSE IF wdetail.covcod = "3.2" THEN 0   
                                        ELSE inte(wdetail.fi)
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
        IF wdetail.prepol <> "" THEN
            Assign 
            nv_41           =  wdetail.nv_41  
            nv_42           =  wdetail.nv_42  
            nv_43           =  wdetail.nv_43  
            nv_seat41       =  wdetail.seat41   .
        ELSE If  wdetail.garage  =  "G"  Then
            Assign 
            nv_41           =  deci(stat.clastab_fil.si_41unp)
            nv_42           =  deci(stat.clastab_fil.si_42)
            nv_43           =  deci(stat.clastab_fil.si_43)   
            /*nv_seat41       =  deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)/*A57-0186*/  
            wdetail.seat41  =  deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)*//*A57-0186*/    .   
        Else                          
            Assign 
                nv_41           =   deci(stat.clastab_fil.si_41pai)
                nv_42           =   deci(stat.clastab_fil.si_42    )
                nv_43           =   deci(stat.clastab_fil.impsi_43  )
                /*nv_seat41       =   deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41) /*A57-0186*/
                wdetail.seat41  =   deci(stat.clastab_fil.dri_41 + clastab_fil.pass_41)*/ /*A57-0186*/  .               
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
        /*sic_bran.uwm301.Tons      =  INTEGER(wdetail.Tonn) */ /*A67-0050*/
        sic_bran.uwm301.Tons      = IF      SUBSTR(wdetail.class,2,3) = "110" THEN 0  /*A67-0050*/
                                    ELSE IF SUBSTR(wdetail.class,2,3) = "210" THEN 0  /*A67-0050*/ 
                                    ELSE INTEGER(wdetail.Tonn)  /*A67-0050*/
        sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage    = trim(wdetail.garage)
        sic_bran.uwm301.body      = trim(wdetail.body)
        sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
        sic_bran.uwm301.mv41seat  = wdetail.seat41
        sic_bran.uwm301.mv_ben83  = IF wdetail.poltyp = "v70" THEN trim(wdetail.benname) ELSE ""
        /*sic_bran.uwm301.vehreg  = trim(wdetail.vehreg) */            /*A58-0206 */ 
        sic_bran.uwm301.vehreg    = substr(trim(wdetail.vehreg),1,11)  /*A58-0206 */ 
        sic_bran.uwm301.yrmanu    = inte(wdetail.caryear)
        sic_bran.uwm301.vehuse    = wdetail.vehuse
        sic_bran.uwm301.moddes    = trim(wdetail.brand) + " " + trim(wdetail.model) 
        sic_bran.uwm301.modcod    = wdetail.redbook                                    
        sic_bran.uwm301.vehgrp    = wdetail.cargrp
        sic_bran.uwm301.sckno     = 0
        sic_bran.uwm301.itmdel    = NO  
        wdetail.tariff            = sic_bran.uwm301.tariff  
        sic_bran.uwm301.prmtxt    = "" .
    FIND LAST wtextaccf6 WHERE wtextaccf6.n_policytxt = wdetail.policy   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL wtextaccf6  THEN DO:
        ASSIGN          
            SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  wtextaccf6.n_textacc1            
            SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  wtextaccf6.n_textacc2 
            SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  wtextaccf6.n_textacc3 
            SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  wtextaccf6.n_textacc4 
            SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  wtextaccf6.n_textacc5 
            SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  wtextaccf6.n_textacc6  
            SUBSTRING(sic_bran.uwm301.prmtxt,361,60) =  wtextaccf6.n_textacc7  
            SUBSTRING(sic_bran.uwm301.prmtxt,421,60) =  wtextaccf6.n_textacc8  
            SUBSTRING(sic_bran.uwm301.prmtxt,481,60) =  wtextaccf6.n_textacc9  
            SUBSTRING(sic_bran.uwm301.prmtxt,541,60) =  wtextaccf6.n_textacc10.
    END.
    /*IF wdetail.prmtxt = "" THEN DO:
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
    ELSE ASSIGN  sic_bran.uwm301.prmtxt = trim(wdetail.prmtxt).*/
    IF wdetail.compul = "y" THEN DO:
        sic_bran.uwm301.cert = "".
        IF LENGTH(wdetail.stk) = 11 THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
        IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
        IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
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
            ASSIGN brStat.Detaitem.Policy = sic_bran.uwm301.Policy
                brStat.Detaitem.RenCnt    = sic_bran.uwm301.RenCnt
                brStat.Detaitem.EndCnt    = sic_bran.uwm301.Endcnt
                brStat.Detaitem.RiskNo    = sic_bran.uwm301.RiskNo
                brStat.Detaitem.ItemNo    = sic_bran.uwm301.ItemNo
                brStat.Detaitem.serailno  = wdetail.stk 
                brstat.detaitem.yearReg  = sic_bran.uwm301.bchyr
                brstat.detaitem.seqno    = STRING(sic_bran.uwm301.bchno)     
                brstat.detaitem.seqno2   = STRING(sic_bran.uwm301.bchcnt).  
        END.
    END.
    ASSIGN 
        sic_bran.uwm301.bchyr  = nv_batchyr      /* batch Year */
        sic_bran.uwm301.bchno  = nv_batchno      /* bchno      */
        sic_bran.uwm301.bchcnt = nv_batcnt       /* bchcnt     */
        s_recid4         = RECID(sic_bran.uwm301) .
    IF nv_driver = ""   THEN ASSIGN nv_drivno = 0.
    ELSE DO:
        FOR EACH ws0m009 WHERE ws0m009.policy  = nv_driver NO-LOCK .
            CREATE brstat.mailtxt_fil.
            ASSIGN
                brstat.mailtxt_fil.policy  = np_driver    
                brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)
                brstat.mailtxt_fil.ltext   = ws0m009.ltext  
                brstat.mailtxt_fil.ltext2  = ws0m009.ltext2   
                brstat.mailtxt_fil.bchyr   = nv_batchyr 
                brstat.mailtxt_fil.bchno   = nv_batchno 
                brstat.mailtxt_fil.bchcnt  = nv_batcnt .
            ASSIGN nv_drivno = INTEGER(ws0m009.lnumber).
        END.
    END.
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
/*FIND LAST brstat.insure USE-INDEX Insure03  WHERE 
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
ELSE nv_baseprm      = 0.  */
     
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
ASSIGN dod1 = 0   dod2 = 0     dpd0 = 0    /*add A64-0138*/
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
RUN proc_base2.
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
ASSIGN fi_process = "Create data to uwm120 stamp tax ..." + wdetail.policy .
DISP fi_process WITH FRAM fr_main.
/*IF fi_policymas <> ""   THEN RUN proc_assign_polmas.*/
/*IF      ra_renewby = 1 THEN RUN proc_assign_polexp.
ELSE IF ra_renewby = 2 THEN RUN proc_assign_polmas.*/
/*IF ra_renewby = 2 THEN RUN proc_assign_polmas.*/

RUN proc_calpremt.        /*A64-0138*/
RUN proc_adduwd132prem .  /*A64-0138*/

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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create70 c-Win 
PROCEDURE proc_create70 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy70)  NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(nv_policy70)             
        wdetail.cr_2        = trim(nv_policy72) 
        wdetail.poltyp      = "V70"
        wdetail.n_branch    = trim(nv_br)           
        wdetail.covcod      = trim(nv_cover)  
        wdetail.inserf      = TRIM(nv_insef)  
        wdetail.promoti     = TRIM(nv_promotion)
        wdetail.tiname      = TRIM(nv_title)
        wdetail.insnam      = TRIM(nv_name1)
        wdetail.name2       = TRIM(nv_name2)
        wdetail.n_addr1     = TRIM(nv_addr1)
        wdetail.n_addr2     = TRIM(nv_addr2)
        wdetail.n_addr3     = TRIM(nv_addr3)
        wdetail.n_addr4     = TRIM(nv_addr4)
        wdetail.nv_icno     = TRIM(nv_icno)
        wdetail.datbirth    = TRIM(nv_datbirth)   
        wdetail.datbirthexp = TRIM(nv_datbirthexp)
        wdetail.vatcode     = TRIM(nv_vatcode)    
        wdetail.cedpol      = TRIM(nv_cedpol)   
        wdetail.vehuse      = trim(nv_vehuse70)
        wdetail.class       = trim(nv_class70)    
        wdetail.seat        = TRIM(nv_seat70)
        /*wdetail.uom1_v      = trim(nv_TPBIPerson)              
        wdetail.uom2_v      = trim(nv_TPBIPerAcc)        
        wdetail.uom5_v      = trim(nv_TPPDPerAcc) */       
        wdetail.si          = trim(nv_SUMINSURED)            
        wdetail.fi          = trim(nv_FITheft)
        /*wdetail.nv_41       = trim(nv_n41)                        
        wdetail.nv_42       = trim(nv_n42)                                 
        wdetail.nv_43       = trim(nv_n43) */
        wdetail.ncb         = trim(nv_nncb)   
        wdetail.fleet       = trim(nv_nfeet)  
        wdetail.dspc        = trim(nv_ndspc) 
        wdetail.base        = trim(nv_npremt) 
        wdetail.commission  = IF trim(nv_com70) = "" THEN 0 ELSE deci(trim(nv_com70))
        wdetail.vehreg      = trim(nv_nvehreg)              
        wdetail.brand       = trim(nv_nbrand)               
        wdetail.model       = trim(nv_nmodel)              
        wdetail.chassis     = trim(nv_nchassis)           
        wdetail.engno       = trim(nv_nengno)             
        wdetail.caryear     = trim(nv_ncaryear)  
        wdetail.fristdat    = trim(nv_comdat70) 
        wdetail.comdat      = trim(nv_comdat70)            
        wdetail.expdat      = trim(nv_expdat70)            
        wdetail.benname     = trim(nv_bennam) 
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)
        wdetail.n_rencnt    = 0 
        wdetail.n_endcnt    = 0 
        wdetail.drivnam     = "N"
        wdetail.tariff      = "X"
        wdetail.compul      = "n"
        wdetail.pass        = "y".
    /*IF ra_f6text = 2 THEN DO:
        IF fi_policymas <> "" THEN DO:  /* F6 by policy master...*/
            FIND FIRST sicuw.uwm301 USE-INDEX uwm30101 
                WHERE sicuw.uwm301.policy =  trim(fi_policymas) NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicuw.uwm301 THEN DO:
                CREATE wtextaccf6.
                ASSIGN           
                    wtextaccf6.n_policytxt = trim(sicuw.uwm301.policy) 
                    wtextaccf6.n_textacc1  = SUBSTRING(sicuw.uwm301.prmtxt,1,60)  
                    wtextaccf6.n_textacc2  = SUBSTRING(sicuw.uwm301.prmtxt,61,60) 
                    wtextaccf6.n_textacc3  = SUBSTRING(sicuw.uwm301.prmtxt,121,60)
                    wtextaccf6.n_textacc4  = SUBSTRING(sicuw.uwm301.prmtxt,181,60)
                    wtextaccf6.n_textacc5  = SUBSTRING(sicuw.uwm301.prmtxt,241,60).
            END.
        END.
    END.
    ELSE */
    IF  (trim(nv_accessoryf61) = "" ) AND  (trim(nv_accessoryf62) = "" ) AND 
             (trim(nv_accessoryf63) = "" ) AND  (trim(nv_accessoryf64) = "" ) AND
             (trim(nv_accessoryf65) = "" ) THEN 
        ASSIGN  nv_accessoryf61 = ""       
                nv_accessoryf62 = ""     
                nv_accessoryf63 = ""      
                nv_accessoryf64 = "" 
                nv_accessoryf65 = "".
    ELSE DO: 
        FIND LAST wtextaccf6 WHERE wtextaccf6.n_policytxt = trim(nv_policy70)   NO-ERROR NO-WAIT.
        IF NOT AVAIL wtextaccf6  THEN DO:
            CREATE wtextaccf6.
            ASSIGN           
                wtextaccf6.n_policytxt = trim(nv_policy70)  
                wtextaccf6.n_textacc1  = trim(nv_accessoryf61)  
                wtextaccf6.n_textacc2  = trim(nv_accessoryf62) 
                wtextaccf6.n_textacc3  = trim(nv_accessoryf63) 
                wtextaccf6.n_textacc4  = trim(nv_accessoryf64) 
                wtextaccf6.n_textacc5  = trim(nv_accessoryf65).
        END.
    END.
    IF  (TRIM(nv_memof71) = "" ) AND (TRIM(nv_memof72) = "" ) AND 
        (TRIM(nv_memof73) = "" ) AND (TRIM(nv_memof74) = "" ) AND 
        (TRIM(nv_memof75) = "" ) THEN 
        ASSIGN  nv_memof71 = ""       
                nv_memof72 = ""     
                nv_memof73 = ""      
                nv_memof74 = ""      
                nv_memof75 = "".
    ELSE DO:
        FIND LAST wtextf7 WHERE wtextf7.n_policytx = trim(nv_policy70)   NO-ERROR NO-WAIT.
        IF NOT AVAIL wtextf7  THEN DO:
            CREATE wtextf7.
            ASSIGN 
                wtextf7.n_policytxt = trim(nv_policy70)              
                wtextf7.nv_memof71  = trim(nv_memof71)  
                wtextf7.nv_memof72  = trim(nv_memof72)  
                wtextf7.nv_memof73  = trim(nv_memof73)  
                wtextf7.nv_memof74  = trim(nv_memof74)  
                wtextf7.nv_memof75  = trim(nv_memof75). 
        END.
    END.
    IF  (TRIM(nv_textf51) = "") AND (TRIM(nv_textf52) = "") AND 
        (TRIM(nv_textf53) = "") AND (TRIM(nv_textf54) = "") AND 
        (TRIM(nv_textf55) = "") THEN
        ASSIGN nv_textf51 = ""    
               nv_textf52 = ""    
               nv_textf53 = ""    
               nv_textf54 = ""    
               nv_textf55 = "".  
    ELSE DO:
        FIND LAST wtextf5  WHERE wtextf5.n_policytx = trim(nv_policy70)   NO-ERROR NO-WAIT.
        IF NOT AVAIL wtextf5  THEN DO:
            CREATE wtextf5.
            ASSIGN 
                wtextf5.n_policytx  = trim(nv_policy70)     
                wtextf5.nv_textf51  = trim(nv_textf51)      
                wtextf5.nv_textf52  = trim(nv_textf52)      
                wtextf5.nv_textf53  = trim(nv_textf53)      
                wtextf5.nv_textf54  = trim(nv_textf54)      
                wtextf5.nv_textf55  = trim(nv_textf55).
        END.
    END.
END.*/
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
  nv_addr1 no.
  nv_addr2 tampon
  nv_addr3 amper
  nv_addr4 city */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create70_s c-Win 
PROCEDURE proc_create70_s :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF LENGTH(nv_policy70) <> 12  THEN 
    MESSAGE "Length Policy over 12 !!! " nv_policy70  VIEW-AS ALERT-BOX.
ELSE DO:
        FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy70)  NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.policy      = trim(nv_policy70)  
                wdetail.prepol      = TRIM(nv_prepol)
                wdetail.cr_2        = IF length(trim(nv_policy72)) <> 12 THEN "" ELSE  trim(nv_policy72)
                wdetail.poltyp      = "V70"                          
                wdetail.n_branch    = IF index("123456789",substr(trim(nv_policy70),1,1)) <> 0   THEN  substr(trim(nv_policy70),1,2) 
                                      ELSE substr(trim(nv_policy70),2,1)  
                wdetail.covcod      = "1"                         
                wdetail.inserf      = ""                      
                wdetail.promoti     = TRIM(nv_notimk) 
                wdetail.dealerno    = TRIM(nv_codefint)
                wdetail.tiname      = IF trim(nv_title) = "" THEN  "คุณ"  ELSE trim(nv_title)   
                wdetail.insnam      = TRIM(nv_name1)                          
                /*wdetail.name2       = IF co_name2 = "" THEN "" ELSE TRIM(co_name2)  */                                   
                wdetail.n_addr1     = TRIM(nv_addr1)                            
                wdetail.n_addr2     = TRIM(nv_addr2)                         
                wdetail.n_addr3     = TRIM(nv_addr3)                         
                wdetail.n_addr4     = TRIM(nv_addr4)                 
                wdetail.nv_icno     = TRIM(nv_icno)                 
                wdetail.datbirth    = TRIM(nv_datbirth)             
                wdetail.datbirthexp = TRIM(nv_datbirthexp)          
                /*wdetail.vatcode     = IF TRIM(co_vatcode) = "" THEN "" ELSE trim(SUBSTR(TRIM(co_vatcode),1,10))  */             
                wdetail.cedpol      = TRIM(nv_brdealer)  
                wdetail.vehuse      = IF trim(nv_vehuse70) = "ส่วนบุคคล" THEN "1" ELSE "2" 
                /*wdetail.class       = "V" + trim(nv_class70)  */ /*a632-0128 */
                /*wdetail.garage      = "G"*/
                wdetail.seat        = IF trim(nv_class70) = "110" THEN "7" ELSE IF trim(nv_class70) = "210" THEN "5" ELSE "7"             
                wdetail.engcc       = trim(nv_enging)           
                /*wdetail.uom1_v      = fi_tpbip                   
                wdetail.uom2_v      = fi_tpbiac                  
                wdetail.uom5_v      = fi_tppda  */     
                wdetail.uom1_v      = 500000                  
                wdetail.uom2_v      = 10000000                
                wdetail.uom5_v      = 1000000
                wdetail.si          = trim(nv_SUMINSURED)      
                wdetail.fi          = trim(nv_SUMINSURED) 
                wdetail.premt       = TRIM(nv_npremt) /*A64-0138*/
                /*wdetail.nv_41       = fi_ap01                                       
                wdetail.nv_42       = fi_ap02                                              
                wdetail.nv_43       = fi_ap03 */                             
                wdetail.base        = IF trim(nv_class70) = "110" THEN "7600" ELSE "12000" 
                /*wdetail.commission  = fi_commision70 */
                wdetail.vehreg      = trim(nv_nvehreg)                     
                wdetail.brand       = trim(nv_nbrand)
                wdetail.model       = IF index(trim(nv_model)," ") <> 0 THEN trim(SUBSTR(trim(nv_model),index(trim(nv_model)," ")))   ELSE trim(nv_model)
                wdetail.chassis     = trim(nv_nchassis)      
                wdetail.engno       = trim(nv_nengno)                 
                wdetail.caryear     = trim(nv_ncaryear)      
                wdetail.fristdat    = trim(nv_comdat70) 
                wdetail.comdat      = trim(nv_comdat70)                
                wdetail.expdat      = trim(nv_expdat70)                
                /*wdetail.benname     = trim(nv_bennam) */ /*รับจาก Expiry เท่านั้น*/ 
                wdetail.commission  = 18   /*com 70*/
                wdetail.prmtxt      = ""
                wdetail.producer    = caps(trim(fi_producer))
                wdetail.agent       = caps(trim(fi_agent))                    
                wdetail.n_rencnt    = 0                                 
                wdetail.n_endcnt    = 0                                         
                wdetail.drivnam     = "N"
                wdetail.tariff      = "X"
                wdetail.compul      = "n"
                wdetail.pass        = "Y" 
                /*Add by Kridtiya i. A63-0472*/
                wdetail.firstName      = TRIM(nv_firstName)
                wdetail.lastName       = TRIM(nv_lastName)
                wdetail.postcd         = trim(nv_postcd) 
                wdetail.codeocc        = trim(nv_codeocc) 
                wdetail.codeaddr1      = TRIM(nv_codeaddr1)
                wdetail.codeaddr2      = TRIM(nv_codeaddr2)
                wdetail.codeaddr3      = trim(nv_codeaddr3)
                wdetail.br_insured     = "00000"
                wdetail.campaign_ov    = trim(np_campaign_ov)   
                wdetail.occup          = trim(np_occupation) .  
                /*Add by Kridtiya i. A63-0472*/
         /*commen by Kridtiya i. A63-00472
         /*a63-0128 */
        IF date(wdetail.comdat) >= 04/01/2020 THEN DO:
            ASSIGN   wdetail.class  =  TRIM(fi_pack) + TRIM(nv_class70).
        END.
        ELSE ASSIGN wdetail.CLASS = "V" + TRIM(nv_class70) .
        /* end A63-0128 */
        end....A63-00472*/

            IF  (trim(nv_accessoryf61) <> "" ) OR (trim(nv_accessoryf62) <> "" ) OR
                (trim(nv_accessoryf63) <> "" ) OR (trim(nv_accessoryf64) <> "" ) OR (trim(nv_accessoryf65) <> "" ) THEN DO:
                FIND LAST wtextaccf6 WHERE wtextaccf6.n_policytxt = trim(nv_policy70)   NO-ERROR NO-WAIT.
                IF NOT AVAIL wtextaccf6  THEN DO:
                    CREATE wtextaccf6.
                    ASSIGN           
                        wtextaccf6.n_policytxt = trim(nv_policy70)  
                        wtextaccf6.n_textacc1  = trim(nv_accessoryf61)      /*    อุปกรณ์ตกแต่ง   */        
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
            IF   (TRIM(nv_memof71) <>  "" ) OR (TRIM(nv_memof72) <>  "" ) OR (TRIM(nv_memof73) <>  "" ) THEN DO:
                FIND LAST wtextf7 WHERE wtextf7.n_policytx = trim(nv_policy70)   NO-ERROR NO-WAIT.
                IF NOT AVAIL wtextf7  THEN DO:
                    CREATE wtextf7.
                    ASSIGN 
                        wtextf7.n_policytxt =  trim(nv_policy70) 
                        wtextf7.nv_memof71  =  TRIM(nv_memof71)         /*  31  หมายเหตุ    */   
                        wtextf7.nv_memof72  =  TRIM(nv_memof72) 
                        wtextf7.nv_memof73  =  TRIM(nv_memof73)  .
                END.
            END.
            ELSE ASSIGN  
                nv_memof71  = ""  
                nv_memof72  = ""      
                nv_memof73  = "" .    
            IF  (TRIM(nv_textf51) = "") AND  (TRIM(nv_textf52) = "") AND  (TRIM(nv_textf53) = "")  THEN
                ASSIGN 
                nv_textf51 = ""    
                nv_textf52 = ""    
                nv_textf53 = ""  .
            ELSE DO:
                FIND LAST wtextf5  WHERE wtextf5.n_policytx = trim(nv_policy70)   NO-ERROR NO-WAIT.
                IF NOT AVAIL wtextf5  THEN DO:
                    CREATE wtextf5.
                    ASSIGN 
                        wtextf5.n_policytx  = trim(nv_policy70)     
                        wtextf5.nv_textf51  = trim(nv_memof71)         
                        wtextf5.nv_textf52  = trim(nv_memof72)               
                        wtextf5.nv_textf53  = trim(nv_memof73)      .   
                END.
            END.
        END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create72 c-Win 
PROCEDURE proc_create72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy72) NO-ERROR NO-WAIT.
IF NOT AVAIL wdetail THEN DO:
    CREATE wdetail.
    ASSIGN 
        wdetail.policy      = trim(nv_policy72) 
        wdetail.cr_2        = trim(nv_policy70) 
        wdetail.poltyp      = "V72"
        wdetail.n_branch    = IF (substr(trim(nv_policy70),1,2) >= "0" ) AND (substr(trim(nv_policy70),2,1) <= "99") THEN  substr(trim(nv_policy70),1,2) 
                              ELSE substr(trim(nv_policy70),2,1)        
        wdetail.covcod      = "T" 
        wdetail.inserf      = TRIM(nv_insef)  
        wdetail.promoti     = TRIM(nv_promotion)
        wdetail.tiname      = TRIM(nv_title)
        wdetail.insnam      = TRIM(nv_name1)
        wdetail.name2       = TRIM(nv_name2)
        wdetail.n_addr1     = TRIM(nv_addr1)
        wdetail.n_addr2     = TRIM(nv_addr2)
        wdetail.n_addr3     = TRIM(nv_addr3)
        wdetail.n_addr4     = TRIM(nv_addr4)
        wdetail.nv_icno     = TRIM(nv_icno)
        wdetail.datbirth    = TRIM(nv_datbirth)   
        wdetail.datbirthexp = TRIM(nv_datbirthexp)
        wdetail.vatcode     = TRIM(nv_vatcode)    
        wdetail.cedpol      = TRIM(nv_cedpol)   
        wdetail.vehuse      = trim(nv_vehuse72)
        wdetail.class       = trim(nv_class72)    
        wdetail.seat        = TRIM(nv_seat72)
        /*wdetail.uom1_v      = trim(nv_TPBIPerson)              
        wdetail.uom2_v      = trim(nv_TPBIPerAcc)        
        wdetail.uom5_v      = trim(nv_TPPDPerAcc)*/      
        wdetail.si          = trim(nv_SUMINSURED)            
        wdetail.fi          = trim(nv_FITheft)
        wdetail.commission  = IF trim(nv_com72) = "" THEN 0 ELSE deci(trim(nv_com70))

        /*wdetail.nv_41       = trim(nv_n41)                        
        wdetail.nv_42       = trim(nv_n42)                                 
        wdetail.nv_43       = trim(nv_n43) 
        wdetail.ncb         = trim(nv_nncb)   
        wdetail.fleet       = trim(nv_nfeet)  
        wdetail.dspc        = trim(nv_ndspc)
        wdetail.base        = trim(nv_npremt)*/                
        wdetail.vehreg      = trim(nv_nvehreg)              
        wdetail.brand       = trim(nv_nbrand)               
        wdetail.model       = trim(nv_nmodel)              
        wdetail.chassis     = trim(nv_nchassis)           
        wdetail.engno       = trim(nv_nengno)             
        wdetail.caryear     = trim(nv_ncaryear)  
        wdetail.fristdat    = trim(nv_comdat72) 
        wdetail.comdat      = trim(nv_comdat72)            
        wdetail.expdat      = trim(nv_expdat72) 
        wdetail.producer    = trim(fi_producer)
        wdetail.agent       = trim(fi_agent)
        wdetail.benname     = ""
        wdetail.prmtxt      = ""  
        wdetail.drivnam     = "N"
        wdetail.tariff      = "9"
        wdetail.compul      = "y"
        wdetail.pass        = "y".   
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create72_s c-Win 
PROCEDURE proc_create72_s :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
IF LENGTH(trim(nv_policy72)) <> 12 THEN
    MESSAGE "Length Policy 72 over 12 !!! " nv_policy72  VIEW-AS ALERT-BOX.
ELSE DO:
        FIND FIRST wdetail WHERE wdetail.policy = trim(nv_policy72)  NO-ERROR NO-WAIT.
        IF NOT AVAIL wdetail THEN DO:
            CREATE wdetail.
            ASSIGN 
                wdetail.policy      = trim(nv_policy72)                                                        
                wdetail.cr_2        = IF length(trim(nv_policy70)) <> 12 THEN "" ELSE  trim(nv_policy70)    
                /*wdetail.stk         = TRIM(nv_stkno)*/
                wdetail.poltyp      = "V72"                          
                wdetail.n_branch    = IF index("123456789",substr(trim(nv_policy72),1,1)) <> 0   THEN  substr(trim(nv_policy72),1,2) 
                                      ELSE substr(trim(nv_policy72),2,1)                                   
                wdetail.covcod      = "T"
                wdetail.inserf      = ""                       
                wdetail.promoti     = TRIM(nv_notimk) 
                wdetail.dealerno    = TRIM(nv_codefint)
                wdetail.tiname      = IF trim(nv_title) = "" THEN  "คุณ"  ELSE trim(nv_title)                        
                wdetail.insnam      = TRIM(nv_name1)                                     
                /*wdetail.name2       = IF co_name2 = "" THEN "" ELSE TRIM(co_name2)    */                                
                wdetail.n_addr1     = TRIM(nv_addr1)                    
                wdetail.n_addr2     = TRIM(nv_addr2)          
                wdetail.n_addr3     = TRIM(nv_addr3)          
                wdetail.n_addr4     = TRIM(nv_addr4)  
                wdetail.nv_icno     = TRIM(nv_icno)                     
                wdetail.datbirth    = TRIM(nv_datbirth)                 
                wdetail.datbirthexp = TRIM(nv_datbirthexp)    
                /*wdetail.vatcode     = IF TRIM(co_vatcode) = "" THEN "" ELSE trim(SUBSTR(TRIM(co_vatcode),1,10)) */  
                wdetail.cedpol      = TRIM(nv_brdealer)  
                wdetail.vehuse      = IF trim(nv_vehuse70) = "ส่วนบุคคล" THEN "1" ELSE "2" 
                wdetail.class       = IF      (TRIM(nv_npremtcomp) = "" OR TRIM(nv_npremtcomp) = "-" ) AND (trim(nv_class70) = "110") THEN "110" 
                                      ELSE IF (TRIM(nv_npremtcomp) = "" OR TRIM(nv_npremtcomp) = "-" ) AND (trim(nv_class70) = "210") THEN "140A" 
                                      ELSE IF DECI(nv_npremtcomp) = 0     THEN "V" + trim(nv_class70)   
                                      ELSE IF TRIM(nv_npremtcomp) = "-"   THEN "V" + trim(nv_class70) 
                                      ELSE IF DECI(nv_npremtcomp) = 600   THEN "110"
                                      ELSE IF DECI(nv_npremtcomp) = 900   THEN "140A"
                                      ELSE  "V" + trim(nv_class70) 
                wdetail.seat        = IF trim(nv_class70) = "110" THEN "7" ELSE "5"              
                wdetail.engcc       = trim(nv_enging)  
                wdetail.si          = trim(nv_SUMINSURED)      
                wdetail.fi          = trim(nv_SUMINSURED)                  
                /*wdetail.commission  = fi_commision72*/
                wdetail.vehreg      = trim(nv_nvehreg)                    
                wdetail.brand       = trim(nv_nbrand)
                wdetail.model       = IF index(trim(nv_model)," ") <> 0 THEN trim(SUBSTR(trim(nv_model),index(trim(nv_model)," ")))   ELSE trim(nv_model)
                wdetail.chassis     = trim(nv_nchassis)      
                wdetail.engno       = trim(nv_nengno)                
                wdetail.caryear     = trim(nv_ncaryear)      
                wdetail.fristdat    = trim(nv_comdat70) 
                wdetail.comdat      = trim(nv_comdat70)               
                wdetail.expdat      = trim(nv_expdat70)               
                wdetail.benname     = trim(nv_bennam)   
                wdetail.commission  = 12   /*com 72*/
                wdetail.producer    = caps(trim(fi_producer))   
                wdetail.agent       = caps(trim(fi_agent))                   
                wdetail.n_rencnt    = 0                                 
                wdetail.n_endcnt    = 0                                        
                wdetail.drivnam     = "N"
                wdetail.tariff      = "X"
                wdetail.compul      = "n"
                wdetail.pass        = "y"  
                /*Add by Kridtiya i. A63-0472*/
                wdetail.firstName      = TRIM(nv_firstName)
                wdetail.lastName       = TRIM(nv_lastName)
                wdetail.postcd         = trim(nv_postcd) 
                wdetail.codeocc        = trim(nv_codeocc) 
                wdetail.codeaddr1      = TRIM(nv_codeaddr1)
                wdetail.codeaddr2      = TRIM(nv_codeaddr2)
                wdetail.codeaddr3      = trim(nv_codeaddr3)
                wdetail.br_insured     = "00000"
                wdetail.campaign_ov    = trim(np_campaign_ov)   
                wdetail.occup          = trim(np_occupation) .  
                /*Add by Kridtiya i. A63-0472*/

             /* A61-0094 */
            IF nv_prepol <> ""  THEN DO:
                FIND LAST sicuw.uwm100 WHERE sicuw.uwm100.policy = TRIM(nv_prepol) NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicuw.uwm100 THEN
                    ASSIGN wdetail.inserf = sicuw.uwm100.insref.
            END.
            /* end A61-0094*/
        
        END.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 c-Win 
PROCEDURE proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER buwm100 FOR wdetail.
    FOR EACH buwm100 WHERE buwm100.cr_2 = wdetail.policy  NO-LOCK .  /*pol 72*/
        ASSIGN 
            wdetail.n_addr1 = buwm100.n_addr1
            wdetail.n_addr2 = buwm100.n_addr2
            wdetail.n_addr3 = buwm100.n_addr3
            wdetail.n_addr4 = buwm100.n_addr4.
    END.
    
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
IF trim(nv_policy70) <> ""  THEN DO:
    ASSIGN 
        nv_c = trim(nv_policy70)
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
    ASSIGN nv_policy70 = nv_c .
END. 
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
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_difinotion c-Win 
PROCEDURE proc_difinotion :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
/*Modify by   : Kridtiya i. A67-0050 Date. 22/02/2024 case 110 GWV= 0 */
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
        /* xmm600 */
        sicsyac.xmm600.acno_typ  = IF SUBSTR(sicsyac.xmm600.acno,2,1) = "C" OR SUBSTR(sicsyac.xmm600.acno,3,1) = "C"  THEN "CO" ELSE "PR"   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
        sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
        sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
        sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
        sicsyac.xmm600.icno      = trim(wdetail.nv_icno)       
        sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
        sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
        sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
        sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
        /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/   .   
        /*Add by Kridtiya i. A63-0472*/
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
        sicsyac.xmm600.telex    = ""                       /*Telex No.*/
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
        sicsyac.xmm600.dval20   = "" 
        /* xmm600 */
        sicsyac.xmm600.acno_typ  = IF nv_typ = "Cs" THEN "CO" ELSE "PR"   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
        sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
        sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
        sicsyac.xmm600.postcd    = trim(wdetail.postcd)     
        sicsyac.xmm600.icno      = trim(wdetail.nv_icno)       
        sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)    
        sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)  
        sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)  
        sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)  
        /*sicsyac.xmm600.anlyc5    = trim(wdetail.br_insured)*/   .   
        /*Add by Kridtiya i. A63-0472*/
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
            sicsyac.xtm600.fname   = ""                      /*First Name*/
            /* xtm600 */
            sicsyac.xtm600.postcd    = trim(wdetail.postcd)       /*Add by Kridtiya i. A63-0472*/
            sicsyac.xtm600.firstname = trim(wdetail.firstName)    /*Add by Kridtiya i. A63-0472*/
            sicsyac.xtm600.lastname  = trim(wdetail.lastName) .   /*Add by Kridtiya i. A63-0472*/
            /*Add by Kridtiya i. A63-0472*/
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
            nv_insref     =    wdetail.n_branch   + String(1,"999999")
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
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
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
                ELSE nv_insref=        wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
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
                ELSE nv_insref =       TRIM(wdetail.n_branch) + STRING(sicsyac.xzm056.lastno,"999999").
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
                ELSE nv_insref=        wdetail.n_branch + "C" + STRING(sicsyac.xzm056.lastno,"99999").
            END.  /*add by Kridtiya i. A56-0323....*/
        END.
    END.   
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    ASSIGN n_check = "ERROR".
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
        ELSE RUN proc_create100.    /*RUN proc_create100. */
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
IF wdetail.inserf = "" THEN RUN proc_insnam.
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
        sic_bran.uwm100.prog   = "wgwtdlsu"                  
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
        sic_bran.uwm100.finint =  TRIM(wdetail.dealerno)
        sic_bran.uwm100.dealer =  trim(wdetail.financecd)      /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.bs_cd  =  trim(wdetail.vatcode)
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)  /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)   /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)     /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.icno       = trim(wdetail.nv_icno)       /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)    /*Add by Kridtiya i. A63-0472*/ 
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)   /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)   /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)   /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.br_insured = trim(wdetail.br_insured)*/  /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov).  /*Add by Kridtiya i. A63-0472*/
    /*Add A58-0334*/
    IF wdetail.prepol <> " " THEN DO:
        IF wdetail.poltyp = "v72"  THEN 
            ASSIGN sic_bran.uwm100.prvpol = ""
                   sic_bran.uwm100.tranty = "R".  
        ELSE                              
            ASSIGN sic_bran.uwm100.prvpol = wdetail.prepol  /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง*/
                   sic_bran.uwm100.tranty = "R".            /*Transaction Type (N/R/E/C/T)*/
    END.
    /*add A58-0334*/
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
        RUN proc_assignrenew_pol.                                 /*A56-0151*/
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
DEF VAR pv_conpara AS CHAR INIT "".   /*A67-0050*/
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
  UPDATE gv_id nv_pwd GO-ON(F1 F4) WITH FRAME nf00
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
  /*A67-0050*/
  FIND FIRST sicsyac.dbtable WHERE sicsyac.dbtable.phyname = "expiry"
      NO-LOCK NO-ERROR NO-WAIT.
  IF AVAIL sicsyac.dbtable THEN pv_conpara = sicsyac.dbtable.unixpara.
  ELSE pv_conpara = "". 
  pv_conpara = pv_conpara +    " -U " + gv_id + " -P " + nv_pwd.   
  /*A67-0050*/

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
     /*CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */  /*HO*/
     /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   /*HO*/*//*Comment A62-0105*/
     /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR.   *//*Test*/
      /*CONNECT expiry -H 10.35.176.37 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) NO-ERROR. */
      CONNECT VALUE(pv_conpara) NO-ERROR. /*A67-0050*/
      
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_usdcodrenew c-Win 
PROCEDURE proc_usdcodrenew :
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
FIND FIRST ws0m009 WHERE 
    ws0m009.policy  = nv_driver  AND
    ws0m009.lnumber = 1  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ws0m009 THEN  ASSIGN  nv_drivage1 =  inte(replace(trim(substr(ws0m009.ltext2,11,5)),"-","")).
ELSE nv_drivage1 = 0 .
FIND FIRST ws0m009 WHERE 
    ws0m009.policy  = nv_driver  AND
    ws0m009.lnumber = 2  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ws0m009 THEN  ASSIGN  nv_drivage2 =  inte(replace(trim(substr(ws0m009.ltext2,11,5)),"-","")).
ELSE nv_drivage2 = 0 .
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
    DO WHILE nv_line1 <= 8 :
        CREATE wuppertxt3.                                                                                 
        wuppertxt3.line = nv_line1.     
        IF nv_line1 = 3  THEN wuppertxt3.txt = wtextf7.nv_memof71 .   
        IF nv_line1 = 4  THEN wuppertxt3.txt = wtextf7.nv_memof72 .                                           
        IF nv_line1 = 5  THEN wuppertxt3.txt = wtextf7.nv_memof73 .    
        IF nv_line1 = 6  THEN wuppertxt3.txt = wtextf7.nv_memof74 .                                          
        IF nv_line1 = 7  THEN wuppertxt3.txt = wtextf7.nv_memof75 .    
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
     /*sic_bran.uwm100.prem_t = nv_gapprm*/
     sic_bran.uwm100.prem_t = nv_pdprm
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
        /*comment by :A64-0138 ..
        sic_bran.uwm301.ncbper   = nv_ncbper
        sic_bran.uwm301.ncbyrs   = nv_ncbyrs
        ... end A64-0138..*/
        sic_bran.uwm301.mv41seat = wdetail.seat41
    /* add by A63-0128 */
        sic_bran.uwm301.tons     = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000) 
                                   ELSE sic_bran.uwm301.tons .

    IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(wdetail.CLASS,2,1) = "3"   OR  
         SUBSTR(wdetail.CLASS,2,1) = "4"   OR  SUBSTR(wdetail.CLASS,2,1) = "5"  OR  
         SUBSTR(wdetail.CLASS,2,3) = "803" OR SUBSTR(wdetail.CLASS,2,3) = "804" OR  
         SUBSTR(wdetail.CLASS,2,3) = "805" ) THEN DO:

         MESSAGE wdetail.policy + " " + wdetail.CLASS + " ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.

           ASSIGN
                wdetail.comment = wdetail.comment + "| " + wdetail.CLASS + " ระบุน้ำหนักรถไม่ถูกต้อง "
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
   END.
   /* end A63-0128 */
/* comment by : A64-0138 ...  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).
 ... end A64-0138...*/
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

