&ANALYZE-SUSPEND _VERSION-NUMBER UIB_v9r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------
/* Connected Databases 
          sic_test         PROGRESS
*/
  File: 
  Description: 
  Input Parameters:
      <none>
  Output Parameters:
      <none>
  Author: 
  Created: 
------------------------------------------------------------------------*/
/*     This .W file was created with the Progress AppBuilder.      */
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
/*******************************/                                       
/* *******************************************************************************
programid    : wgwklgen.W                                               
programname  :  LOAD TEXT FILE MOTOR TO GW [K-Leasing บริษัท ลีสซิ่งกสิกรไทย จำกัด] 
Copyright    : Safety Insurance Public Company Limited                 
Dup. from    : wgwhcgen.w                                                                                 
Create by   : Suthida T. A52-00275           
                ปรับโปรแกรมให้สามารถนำเข้า LOAD TEXT FILE MOTOR TO GW system   
เพิ่มข้อมูลการแก้ไขที่ Proc_defination 
Modify by   : Ranu I. A64-0138 เพิ่มตัวแปรเก็บค่าการคำนวณเบี้ย  
modify by   : Kridtiya i. A65-0040 เพิ่มการรับรหัสลูกค้าจากกรมเดิม
/*Modify by   : Kridtiya i. A65-0035 comment message error premium not on file */
/*Modify by : Kridtiya i. A66-0108 Date. 12/06/2023 add color*/
/*Modify by : Kridtiya i. A66-0142 Date. 15/08/2023 campaign = Producer and gen ins */
************************************************************************************************/  
DEF SHARED VAR     n_user      AS CHAR .
DEF SHARED VAR     n_passwd    AS CHAR .
DEF NEW SHARED VAR nv_producer AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR nv_agent    AS CHAR FORMAT "x(7)".
DEF NEW SHARED VAR nv_riskno   LIKE  sicuw.uwm301.riskgp.
DEF NEW SHARED VAR nv_itemno   LIKE  sicuw.uwm301.itemno. 
DEF            VAR nv_row      AS INT  INIT  0.
DEF NEW SHARED VAR nv_polday   AS INTE      FORMAT ">>9".
DEF NEW SHARED VAR nv_uom6_u   AS CHAR.     
DEF NEW SHARED VAR nv_othcod   AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_othprm   AS DECI      FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_othvar1  AS CHAR      FORMAT "X(30)".
DEF NEW SHARED VAR nv_othvar2  AS CHAR      FORMAT "X(30)".
DEF NEW SHARED VAR nv_othvar   AS CHAR      FORMAT "X(60)".
DEF NEW SHARED VAR nv_sclass   AS CHAR      FORMAT "x(3)".
DEFINE         VAR n_sclass72  AS CHAR      FORMAT "x(4)".
DEFINE         VAR nv_newsck   AS CHAR FORMAT "x(15)" INIT " ".
DEF            VAR nv_uom1_v   AS INTE INIT 0.
DEF            VAR nv_uom2_v   AS INTE INIT 0.
DEF            VAR nv_uom5_v   AS INTE INIT 0.
DEF NEW SHARED VAR nv_tariff   LIKE sicuw.uwm301.tariff.
DEF NEW SHARED VAR nv_comdat   LIKE sicuw.uwm100.comdat.
DEF NEW SHARED VAR nv_covcod   LIKE sicuw.uwm301.covcod.
DEF NEW SHARED VAR nv_class    AS CHAR    FORMAT "X(4)".
DEF NEW SHARED VAR nv_key_b    AS DECIMAL FORMAT ">>>,>>>,>>>,>>9.99-" INITIAL 0 NO-UNDO.
DEF NEW SHARED VAR nv_drivno   AS INT       .
DEF NEW SHARED VAR nv_drivcod  AS CHARACTER FORMAT "X(4)".
DEF NEW SHARED VAR nv_drivprm  AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW SHARED VAR nv_drivvar1 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar2 AS CHAR  FORMAT "X(30)".
DEF NEW SHARED VAR nv_drivvar  AS CHAR  FORMAT "X(60)".
DEF            VAR nv_provi    AS CHAR INIT "".
DEF NEW SHARED VAR nv_engine   LIKE sicsyac.xmm102.engine.
DEF NEW SHARED VAR nv_tons     LIKE sicsyac.xmm102.tons.
DEF NEW SHARED VAR nv_seats    LIKE sicsyac.xmm102.seats.
DEF NEW SHARED VAR nv_vehuse   LIKE sicuw.uwm301.vehuse.                 
DEF NEW SHARED VAR nv_makdes   AS   CHAR.
DEF NEW SHARED VAR nv_moddes   AS   CHAR.
DEF            VAR nv_comacc   AS DECI INIT 0.
DEF            VAR nv_comper   AS DECI INIT 0.
DEF            VAR n_endcnt    LIKE sicuw.uwm100.endcnt INITIAL "".
DEF            VAR n_rencnt    LIKE sicuw.uwm100.rencnt INITIAL "".
DEF            VAR nv_dept     AS CHAR FORMAT  "X(1)".
DEF new shared VAR s_recid1    AS RECID .     /* uwm100  */     
DEF new shared VAR s_recid2    AS RECID .     /* uwm120  */     
DEF new shared VAR s_recid3    AS RECID .     /* uwm130  */     
DEF new shared VAR s_recid4    AS RECID .     /* uwm301  */     
DEF            VAR nv_daily    AS CHARACTER FORMAT "X(1024)"     INITIAL ""  NO-UNDO.
DEF            VAR nv_reccnt      AS INT  INIT  0.  /*all load record*/
DEF            VAR nv_completecnt AS INT  INIT  0.  /*complete record */
/*DEF NEW SHARED VAR chr_sticker    AS CHAR FORMAT "9999999999999" INIT "".  /*amparat c. a51-0253*/*/ /* suthida T. A52-0275 27-09-10 */
DEF NEW SHARED VAR chr_sticker    AS CHAR FORMAT "X(13)" INIT "".  /* suthida T. A52-0275 27-09-10 */
DEF NEW SHARED VAR nv_modulo      AS INT  FORMAT "9".
DEF            VAR s_riskgp       AS INTE FORMAT ">9".  
DEF            VAR s_riskno       AS INTE FORMAT "999".
DEF            VAR s_itemno       AS INTE FORMAT "999".
/*********** dsic ***********/    
DEF NEW  SHARED VAR nv_dss_cod    AS CHAR       FORMAT "X(4)".
DEF NEW  SHARED VAR nv_dss_per    AS DECIMAL    FORMAT ">9.99".
DEF NEW  SHARED VAR nv_dsspc      AS INTEGER    FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_dsspcvar1  AS CHAR       FORMAT "X(30)".
DEF New  SHARED VAR nv_dsspcvar2  AS CHAR       FORMAT "X(30)".
DEF NEW  SHARED VAR nv_dsspcvar   AS CHAR       FORMAT "X(60)".
DEF New  SHARED VAR nv_41cod1     AS CHARACTER  FORMAT "X(4)".
DEF NEW  SHARED VAR nv_41cod2     AS CHARACTER  FORMAT "X(4)".
DEF NEW  SHARED VAR nv_42cod      AS CHARACTER  FORMAT "X(4)".
DEF NEW  SHARED VAR nv_43cod      AS CHARACTER  FORMAT "X(4)".
DEF NEW  SHARED VAR nv_poltyp     AS CHAR       INIT   "".
DEF             VAR nv_uwm301trareg LIKE sic_bran.uwm301.cha_no INIT "".
DEFINE          VAR nv_maxdes AS CHAR.
DEFINE          VAR nv_mindes AS CHAR.
DEFINE          VAR nv_si     AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE          VAR nv_maxSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Maximum Sum Insure */
DEFINE          VAR nv_minSI  AS DECI FORMAT ">>,>>>,>>9.99-". /* Minimum Sum Insure */
DEF             VAR chkred    AS logi INIT NO.
DEF             VAR nv_modcod AS CHAR FORMAT "x(8)" INIT "" .
DEFINE          VAR nv_simat  AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEFINE          VAR nv_simat1 AS DECI FORMAT ">>>,>>>,>>>,>>9.99-".
DEF             VAR NO_CLASS  AS CHAR INIT "".
DEF             VAR nv_ncbyrs AS INTE.
DEF NEW  SHARED VAR nv_basecod AS CHAR        FORMAT "X(4)".
DEF NEW  SHARED VAR nv_usecod  AS CHARACTER   FORMAT "X(4)".
DEF New  SHARED VAR nv_ncb     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_ncbper  LIKE sicuw.uwm301.ncbper.
DEF NEW  SHARED VAR nv_engcod  AS CHAR FORMAT "x(4)".
DEF NEW  SHARED VAR nv_yrcod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_yrprm   AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_yrvar   AS CHAR  FORMAT "X(60)".
DEF NEW  SHARED VAR nv_sicod   AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_grpcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_bipcod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_biacod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_pdacod  AS CHARACTER FORMAT "X(4)".
DEF NEW  SHARED VAR nv_totsi   AS DECIMAL FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_compcod  AS CHAR   FORMAT "X(4)".
DEF NEW  SHARED VAR nv_compprm  AS DECI   FORMAT ">>>,>>9.99-".
DEF New  SHARED VAR nv_compvar1 AS CHAR   FORMAT "X(30)".
DEF NEW  SHARED VAR nv_compvar2 AS CHAR   FORMAT "X(30)".
DEF New  SHARED VAR nv_compvar  AS CHAR   FORMAT "X(60)".
DEF VAR             n_curbil    LIKE  sicuw.uwm100.curbil  NO-UNDO.
DEF NEW  SHARED VAR nv_baseprm  AS DECI   FORMAT ">>,>>>,>>9.99-". 
DEF NEW  SHARED VAR nv_gapprm   AS DECI   FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_pdprm    AS DECI   FORMAT ">>,>>>,>>9.99-"  INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_basevar1 AS CHAR   FORMAT "X(30)".
DEF NEW  SHARED VAR nv_basevar2 AS CHAR   FORMAT "X(30)".
DEF New  SHARED VAR nv_basevar  AS CHAR   FORMAT "X(60)".
DEF NEW  SHARED VAR nv_useprm   AS DECI   FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_usevar   AS CHAR   FORMAT "X(60)".
DEF NEW  SHARED VAR nv_grprm    AS DECI   FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_grpvar1  AS CHAR   FORMAT "X(30)".
DEF NEW  SHARED VAR nv_grpvar2  AS CHAR   FORMAT "X(30)".
DEF NEW  SHARED VAR nv_grpvar   AS CHAR   FORMAT "X(60)".
DEF NEW  SHARED VAR nv_siprm    AS DECI   FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_sivar    AS CHAR   FORMAT "X(60)".
DEF NEW  SHARED VAR nv_engprm   AS DECI   FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_engvar   AS CHAR   FORMAT "X(60)".
DEF NEW  SHARED VAR nv_bipprm   AS DECI   FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_bipvar   AS CHAR   FORMAT "X(60)".
DEF NEW  SHARED VAR nv_biaprm   AS DECI   FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_biavar   AS CHAR   FORMAT "X(60)".
DEF NEW  SHARED VAR nv_pdaprm   AS DECI   FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_pdavar   AS CHAR   FORMAT "X(60)".
DEF New  SHARED VAR nv_41       AS INTE   FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_411prm   AS DECI   FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_412prm   AS DECI   FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_411var   AS CHAR    FORMAT "X(60)".
DEF New  SHARED VAR nv_412var   AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_42       AS INTEGER FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_42prm    AS DECI    FORMAT ">,>>>,>>9.99".
DEF NEW  SHARED VAR nv_42var    AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_43       AS INTEGER FORMAT ">>>,>>>,>>9".
DEF New  SHARED VAR nv_43prm      AS DECI    FORMAT ">,>>>,>>9.99".
DEF New  SHARED VAR nv_43var      AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_campcod    AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_camprem    AS DECI    FORMAT ">>>9".
DEF New  SHARED VAR nv_campvar    AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_dedod1_cod AS CHAR    FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedod1_prm AS DECI    FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedod1var  AS CHAR    FORMAT "X(60)".  
DEF NEW  SHARED VAR nv_dedod2_cod AS CHAR    FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedod2_prm AS DECI    FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedod2var  AS CHAR    FORMAT "X(60)".                                                                              
DEF NEW  SHARED VAR nv_dedpd_cod  AS CHAR    FORMAT "X(4)".             
DEF NEW  SHARED VAR nv_dedpd_prm  AS DECI    FORMAT ">,>>>,>>9.99-".    
DEF NEW  SHARED VAR nv_dedpdvar   AS CHAR    FORMAT "X(60)".   
DEF NEW  SHARED VAR nv_flet_cod   AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_flet_per   AS DECIMAL FORMAT ">>9".
DEF New  SHARED VAR nv_flet       AS DECI    FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_fletvar    AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_ncb_cod    AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_ncbvar     AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_cl_cod     AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_cl_per     AS DECIMAL FORMAT ">9.99".
DEF New  SHARED VAR nv_lodclm     AS INTEGER FORMAT ">>>,>>9.99-".
DEF             VAR nv_lodclm1    AS INTEGER FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_clmvar     AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_stf_cod    AS CHAR    FORMAT "X(4)".
DEF NEW  SHARED VAR nv_stf_per    AS DECIMAL FORMAT ">9.99".
DEF New  SHARED VAR nv_stf_amt    AS INTEGER FORMAT ">>>,>>9.99-".
DEF NEW  SHARED VAR nv_stfvar     AS CHAR    FORMAT "X(60)".
DEF NEW  SHARED VAR nv_stfvar1    AS CHAR    FORMAT "X(60)". /* ----- suthida T. A54-0010 21-06-11 ---------  */
DEF NEW  SHARED VAR nv_stfvar2    AS CHAR    FORMAT "X(60)". /* ----- suthida T. A54-0010 21-06-11 ---------  */
DEFINE          VAR nv_basere     AS DECI    FORMAT ">>,>>>,>>9.99-" INIT 0. 
DEF NEW  SHARED VAR nv_prem1      AS DECIMAL FORMAT ">,>>>,>>9.99-" INITIAL 0  NO-UNDO.
DEF NEW  SHARED VAR nv_seat41     AS INTEGER FORMAT ">>9". 
DEF New  SHARED VAR nv_411var1    AS CHAR    FORMAT "X(30)".
DEF New  SHARED VAR nv_411var2    AS CHAR    FORMAT "X(30)".
DEF New  SHARED VAR nv_412var1    AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_412var2    AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_42var1     AS CHAR    FORMAT "X(30)".
DEF New  SHARED VAR nv_42var2     AS CHAR    FORMAT "X(30)".
DEF New  SHARED VAR nv_43var1     AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_43var2     AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_usevar1    AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_usevar2    AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_yrvar1     AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_yrvar2     AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_caryr      AS INTE    FORMAT ">>>9" .
DEF NEW  SHARED VAR nv_sivar1     AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_sivar2     AS CHAR    FORMAT "X(30)".
DEF NEW  SHARED VAR nv_uom6_c     AS CHAR.      /* Sum  si*/
DEF NEW  SHARED VAR nv_uom7_c     AS CHAR.      /* Fire/Theft*/
DEF NEW  SHARED VAR nv_bipvar1    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_bipvar2    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_biavar1    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_biavar2    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_pdavar1    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_pdavar2    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_odcod      AS CHAR  FORMAT "X(4)".
DEF NEW  SHARED VAR nv_prem       AS DECI  FORMAT ">,>>>,>>9.99-"   INITIAL 0  NO-UNDO.
DEF             VAR nv_chk        AS  logic.
DEF NEW  SHARED VAR nv_baseap     AS DECI  FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_ded1prm    AS INTE  FORMAT ">>>,>>9-"    INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_aded1prm   AS INTE  FORMAT ">>>,>>9-"    INITIAL 0  NO-UNDO. 
DEF New  SHARED VAR nv_ded2prm    AS INTE  FORMAT ">>>,>>9-"    INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_dedod1var1 AS CHAR  FORMAT "X(30)".       
DEF NEW  SHARED VAR nv_dedod1var2 AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_cons       AS CHAR  FORMAT "X(2)".       
DEF NEW  SHARED VAR nv_ded        AS INTE  FORMAT ">>,>>>,>>9"  INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_dedod2var1 AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_dedod2var2 AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_dedpdvar1  AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_dedpdvar2  AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_fletvar1   AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_fletvar2   AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_ncbvar1    AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_ncbvar2    AS CHAR  FORMAT "X(30)".      
DEF NEW  SHARED VAR nv_addprm     AS INTE  FORMAT ">>,>>>,>>9"  INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_engvar1    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_engvar2    AS CHAR  FORMAT "X(30)".
DEF NEW  SHARED VAR nv_prvprm     AS DECI     FORMAT ">>,>>>,>>9.99-".
DEF NEW  SHARED VAR nv_41prm      AS INTEGER  FORMAT ">,>>>,>>9"       INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_dedod      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO. 
DEF New  SHARED VAR nv_addod      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_dedpd      AS INTEGER  FORMAT ">>,>>>,>>9"      INITIAL 0  NO-UNDO. 
DEF NEW  SHARED VAR nv_totded     AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO. 
DEF New  SHARED VAR nv_totdis     AS INTEGER  FORMAT ">>,>>>,>>9-"     INITIAL 0  NO-UNDO. 
DEF             VAR nv_drivage1   AS INTE INIT 0.  
DEF             VAR nv_drivage2   AS INTE INIT 0.  
DEF             VAR nv_drivbir1   AS CHAR INIT "".  
DEF             VAR nv_drivbir2   AS CHAR INIT "".
DEF NEW  SHARED VAR no_baseprm    AS DECI FORMAT ">>,>>>,>>9.99-".  /*note add test Base Premium 25/09/2006*/
DEF NEW  SHARED VAR NO_basemsg    AS CHAR FORMAT "x(50)" .          /*Warning Error If Not in Range 25/09/2006 */
DEF             VAR nv_docno      AS CHAR FORMAT "9999999"    INIT " ".
DEF             VAR nv_lnumber    AS INTE INIT 0.
DEF             VAR nv_rec100     AS RECID .
DEF             VAR nv_rec120     AS RECID .
DEF             VAR nv_rec130     AS RECID .
DEF             VAR nv_rec301     AS RECID .
DEF             VAR nv_gap        AS DECIMAL NO-UNDO.
DEF             VAR nvffptr       AS RECID   NO-UNDO.
DEF             VAR s_130bp1      AS RECID   NO-UNDO.
DEF             VAR s_130fp1      AS RECID   NO-UNDO.
DEF             VAR n_rd132       AS RECID   NO-UNDO.
DEF             VAR nv_key_a      AS DECIMAL NO-UNDO INITIAL 0.
DEF             VAR nv_stm_per    AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF             VAR nv_tax_per    AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF             VAR nv_gap2       AS DECIMAL NO-UNDO.
DEF             VAR nv_prem2      AS DECIMAL NO-UNDO.
DEF             VAR nv_rstp       AS DECIMAL NO-UNDO.
DEF             VAR nv_rtax       AS DECIMAL NO-UNDO.
DEF             VAR nv_com1_per   AS DECIMAL FORMAT ">9.99" INITIAL 0 NO-UNDO.
DEF             VAR nv_com1_prm   AS DECIMAL FORMAT ">>>>>9.99-"      NO-UNDO.
/*A63-0162*/
DEF WORKFILE wcampaign NO-UNDO 
    FIELD  campno   AS CHAR FORMAT "x(20)"    INIT ""
    FIELD  id       AS CHAR FORMAT "x(5)"    INIT ""  
    FIELD  cover    AS CHAR FORMAT "x(3)"    INIT ""  
    FIELD  pack     AS CHAR FORMAT "x(3)"    INIT "" 
    FIELD  bi       AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd1      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  pd2      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n41      AS CHAR FORMAT "x(10)"   INIT "" 
    FIELD  n42      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  n43      AS CHAR FORMAT "x(10)"   INIT ""  
    FIELD  nname    AS CHAR FORMAT "x(25)"    INIT "" 
    FIELD  garage   AS CHAR FORMAT "x(2)"  INIT "" 
    FIELD assino    AS CHAR FORMAT "x(10)" INIT "" .
/* end A63-0162*/
/* ----- suthida T. A54-0010 21-06-11 --------- */
{wgw\Wgwklgen.i}      /*ประกาศตัวแปร*/
    DEF VAR dpd0        AS INTEGER.

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
&Scoped-define FIELDS-IN-QUERY-br_cam wcampaign.id wcampaign.pack wcampaign.cover wcampaign.garage wcampaign.assino wcampaign.nname wcampaign.bi wcampaign.pd1 wcampaign.pd2 wcampaign.n41 wcampaign.n42 wcampaign.n43   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_cam   
&Scoped-define SELF-NAME br_cam
&Scoped-define QUERY-STRING-br_cam FOR EACH wcampaign
&Scoped-define OPEN-QUERY-br_cam OPEN QUERY br_cam FOR EACH wcampaign .
&Scoped-define TABLES-IN-QUERY-br_cam wcampaign
&Scoped-define FIRST-TABLE-IN-QUERY-br_cam wcampaign


/* Definitions for BROWSE br_wdetail                                    */
&Scoped-define FIELDS-IN-QUERY-br_wdetail wdetail.producer wdetail.agent wdetail.poltyp wdetail.policy wdetail.name1 wdetail.comdat wdetail.expdat   
&Scoped-define ENABLED-FIELDS-IN-QUERY-br_wdetail   
&Scoped-define SELF-NAME br_wdetail
&Scoped-define QUERY-STRING-br_wdetail FOR EACH wdetail
&Scoped-define OPEN-QUERY-br_wdetail OPEN QUERY br_query FOR EACH wdetail.
&Scoped-define TABLES-IN-QUERY-br_wdetail wdetail
&Scoped-define FIRST-TABLE-IN-QUERY-br_wdetail wdetail


/* Definitions for FRAME fr_main                                        */
&Scoped-define OPEN-BROWSERS-IN-QUERY-fr_main ~
    ~{&OPEN-QUERY-br_cam}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS br_cam ra_typechk fi_loaddat fi_branch ~
fi_producer_nn fi_agent fi_prevbat fi_bchyr fi_filename bu_file fi_output1 ~
fi_output2 fi_bchno fi_output3 buok bu_exit br_wdetail bu_hpbrn ~
bu_hpacno_nn bu_hpagent fi_producer_benz bu_hpacno_benz fi_producer_08nn ~
bu_hpacno08nn fi_producer bu_hpacno_rw fi_producer_nu bu_hpacno_nu ~
fi_producer_12nn bu_hpacno12nn fi_process fi_pack fi_packnew RECT-370 ~
RECT-372 RECT-374 RECT-375 RECT-376 RECT-377 RECT-378 
&Scoped-Define DISPLAYED-OBJECTS ra_typechk fi_loaddat fi_branch ~
fi_producer_nn fi_agent fi_prevbat fi_bchyr fi_filename fi_output1 ~
fi_output2 fi_bchno fi_output3 fi_brndes fi_proname_NN fi_agtname ~
fi_producer_benz fi_proname_benz fi_producer_08nn fi_impcnt fi_proname_08nn ~
fi_producer fi_proname_rw fi_producer_nu fi_completecnt fi_premtot ~
fi_proname_nu fi_premsuc fi_producer_12nn fi_proname_12nn fi_process ~
fi_pack fi_packnew 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VAR C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON buok 
     LABEL "OK" 
     SIZE 14.5 BY 1.19.

DEFINE BUTTON bu_exit 
     LABEL "EXIT" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON bu_file 
     LABEL "..." 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno08nn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno12nn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno_benz 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno_nn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno_nu 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpacno_rw 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpagent 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE BUTTON bu_hpbrn 
     IMAGE-UP FILE "wimage/help.bmp":U
     LABEL "" 
     SIZE 4 BY .91.

DEFINE VARIABLE fi_agent AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_agtname AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_bchno AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 25 BY 1
     BGCOLOR 19 FGCOLOR 2  NO-UNDO.

DEFINE VARIABLE fi_bchyr AS INTEGER FORMAT "9999":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 8 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_branch AS CHARACTER FORMAT "X(2)":U 
     VIEW-AS FILL-IN 
     SIZE 5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_brndes AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_completecnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_filename AS CHARACTER FORMAT "X(100)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_impcnt AS INTEGER FORMAT ">,>>>,>>9":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 10 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_loaddat AS DATE FORMAT "99/99/9999":U 
     VIEW-AS FILL-IN 
     SIZE 18 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_output1 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output2 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_output3 AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .91
     BGCOLOR 15  NO-UNDO.

DEFINE VARIABLE fi_pack AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_packnew AS CHARACTER FORMAT "X(25)":U INITIAL "0" 
     VIEW-AS FILL-IN 
     SIZE 17.33 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_premsuc AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_premtot AS DECIMAL FORMAT "->,>>>,>>>,>>9.99":U INITIAL 0 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1.05
     BGCOLOR 19 FGCOLOR 1 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_prevbat AS CHARACTER FORMAT "X(25)":U 
     VIEW-AS FILL-IN 
     SIZE 22 BY .91
     BGCOLOR 15 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fi_process AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 60 BY .81
     BGCOLOR 8 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_producer AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer_08nn AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer_12nn AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer_benz AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer_nn AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_producer_nu AS CHARACTER FORMAT "X(15)":U 
     VIEW-AS FILL-IN 
     SIZE 14.5 BY .91
     BGCOLOR 15 FGCOLOR 0  NO-UNDO.

DEFINE VARIABLE fi_proname_08nn AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname_12nn AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname_benz AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname_NN AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname_nu AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE fi_proname_rw AS CHARACTER FORMAT "X(40)":U 
     VIEW-AS FILL-IN 
     SIZE 40.5 BY .91
     BGCOLOR 19 FGCOLOR 1  NO-UNDO.

DEFINE VARIABLE ra_typechk AS INTEGER 
     VIEW-AS RADIO-SET HORIZONTAL
     RADIO-BUTTONS 
          "Load", 1,
"Check Data", 2
     SIZE 26 BY .91 NO-UNDO.

DEFINE RECTANGLE RECT-370
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128 BY 1.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-372
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128 BY 13.52
     BGCOLOR 8 FGCOLOR 1 .

DEFINE RECTANGLE RECT-374
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 128 BY 3.57
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-375
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 121.5 BY 3.1
     BGCOLOR 19 .

DEFINE RECTANGLE RECT-376
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 119 BY 2.52
     BGCOLOR 8 .

DEFINE RECTANGLE RECT-377
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
     BGCOLOR 5 FGCOLOR 5 .

DEFINE RECTANGLE RECT-378
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 17 BY 1.67
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_cam C-Win _FREEFORM
  QUERY br_cam DISPLAY
      wcampaign.id    column-label "Old" format "x(3)"
wcampaign.pack  column-label "New"  format "x(4)"
wcampaign.cover column-label "Cover" format "x(3)"
wcampaign.garage COLUMN-LABEL "Garage" FORMAT "x(2)"
wcampaign.assino COLUMN-LABEL "Campaing" FORMAT "x(10)"
wcampaign.nname COLUMN-LABEL "Detail" FORMAT "x(20)"
wcampaign.bi    column-label "TP1 "  format "X(10)"
wcampaign.pd1   column-label "TP2 "  format "X(10)"
wcampaign.pd2   column-label "TP3 "  format "X(10)"
wcampaign.n41   column-label "41 "   format "X(10)"
wcampaign.n42   column-label "42 "   format "X(10)"
wcampaign.n43   column-label "43 "   format "X(10)"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 34 BY 5.24
         BGCOLOR 29 FONT 1 ROW-HEIGHT-CHARS .57 FIT-LAST-COLUMN.

DEFINE BROWSE br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS br_wdetail C-Win _FREEFORM
  QUERY br_wdetail DISPLAY
      wdetail.producer COLUMN-LABEL "Producer"
        wdetail.agent    COLUMN-LABEL "Agent"
        wdetail.poltyp   COLUMN-LABEL "Policy Type"
        wdetail.policy   COLUMN-LABEL "Policy"
        wdetail.name1    COLUMN-LABEL "Insured Name" 
        wdetail.comdat   COLUMN-LABEL "Comm Date"
        wdetail.expdat   COLUMN-LABEL "Expiry Date"
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 127.83 BY 4.81
         BGCOLOR 15 FGCOLOR 0 FONT 6 ROW-HEIGHT-CHARS .52.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME fr_main
     br_cam AT ROW 5.05 COL 95.67 WIDGET-ID 100
     ra_typechk AT ROW 10.43 COL 78 NO-LABEL WIDGET-ID 14
     fi_loaddat AT ROW 2.76 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_branch AT ROW 2.76 COL 61 COLON-ALIGNED NO-LABEL
     fi_producer_nn AT ROW 4.67 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_agent AT ROW 9.48 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_prevbat AT ROW 10.43 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchyr AT ROW 10.43 COL 67.5 COLON-ALIGNED NO-LABEL
     fi_filename AT ROW 11.43 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_file AT ROW 11.43 COL 95.17
     fi_output1 AT ROW 12.43 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_output2 AT ROW 13.38 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_bchno AT ROW 22.43 COL 16.33 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_output3 AT ROW 14.33 COL 32.5 COLON-ALIGNED NO-LABEL
     buok AT ROW 11.67 COL 101.5
     bu_exit AT ROW 13.52 COL 101.33
     fi_brndes AT ROW 2.76 COL 70.5 COLON-ALIGNED NO-LABEL
     br_wdetail AT ROW 16.19 COL 3.17
     bu_hpbrn AT ROW 2.76 COL 68.17
     bu_hpacno_nn AT ROW 4.67 COL 49.17
     bu_hpagent AT ROW 9.48 COL 49.17
     fi_proname_NN AT ROW 4.67 COL 52 COLON-ALIGNED NO-LABEL
     fi_agtname AT ROW 9.48 COL 52 COLON-ALIGNED NO-LABEL
     fi_producer_benz AT ROW 5.62 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_hpacno_benz AT ROW 5.62 COL 49.17
     fi_proname_benz AT ROW 5.62 COL 52 COLON-ALIGNED NO-LABEL
     fi_producer_08nn AT ROW 6.57 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_impcnt AT ROW 21.86 COL 61.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     bu_hpacno08nn AT ROW 6.57 COL 49.17
     fi_proname_08nn AT ROW 6.57 COL 52 COLON-ALIGNED NO-LABEL
     fi_producer AT ROW 8.48 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_hpacno_rw AT ROW 8.48 COL 49.17
     fi_proname_rw AT ROW 8.48 COL 52 COLON-ALIGNED NO-LABEL
     fi_producer_nu AT ROW 3.71 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_completecnt AT ROW 22.86 COL 61.83 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_premtot AT ROW 21.86 COL 98.17 NO-LABEL NO-TAB-STOP 
     bu_hpacno_nu AT ROW 3.71 COL 49.17
     fi_proname_nu AT ROW 3.71 COL 52 COLON-ALIGNED NO-LABEL
     fi_premsuc AT ROW 22.91 COL 96.17 COLON-ALIGNED NO-LABEL NO-TAB-STOP 
     fi_producer_12nn AT ROW 7.52 COL 32.5 COLON-ALIGNED NO-LABEL
     bu_hpacno12nn AT ROW 7.52 COL 49.17
     fi_proname_12nn AT ROW 7.52 COL 52 COLON-ALIGNED NO-LABEL
     fi_process AT ROW 15.29 COL 32.5 COLON-ALIGNED NO-LABEL
     fi_pack AT ROW 2.76 COL 109.67 COLON-ALIGNED NO-LABEL WIDGET-ID 2
     fi_packnew AT ROW 3.76 COL 109.67 COLON-ALIGNED NO-LABEL WIDGET-ID 6
     "Branch :" VIEW-AS TEXT
          SIZE 8.33 BY .91 AT ROW 2.76 COL 54.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     " LOAD TEXT FILE MOTOR TO GW [K-Leasing].................................." VIEW-AS TEXT
          SIZE 126 BY 1 AT ROW 1.24 COL 4
          BGCOLOR 2 FGCOLOR 7 FONT 6
     "Load Date :":35 VIEW-AS TEXT
          SIZE 12.33 BY .91 AT ROW 2.76 COL 21.33
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer  Code-RW :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 8.48 COL 13
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Previous Batch No.  :" VIEW-AS TEXT
          SIZE 21 BY .91 AT ROW 10.43 COL 11.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 22.86 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COL 1 ROW 1
         SIZE 133 BY 24
         BGCOLOR 3 FONT 6.

/* DEFINE FRAME statement is approaching 4K Bytes.  Breaking it up   */
DEFINE FRAME fr_main
     "Producer  Code-12_NN :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 7.52 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "PACK NEW :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 3.76 COL 110 RIGHT-ALIGNED WIDGET-ID 8
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "24/07/2023" VIEW-AS TEXT
          SIZE 14.5 BY .95 AT ROW 15.05 COL 100.5 WIDGET-ID 10
          BGCOLOR 8 FONT 2
     "Output Data Not Load :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 13.38 COL 10
          BGCOLOR 8 FGCOLOR 1 
     "Batch Year :" VIEW-AS TEXT
          SIZE 12 BY .91 AT ROW 10.43 COL 68.17 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch No. :" VIEW-AS TEXT
          SIZE 11.5 BY .95 AT ROW 22.43 COL 6.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Batch File Name :" VIEW-AS TEXT
          SIZE 17.5 BY .91 AT ROW 14.33 COL 15.33
          BGCOLOR 8 FGCOLOR 1 
     "Producer  Code-NN/BENZ :" VIEW-AS TEXT
          SIZE 26.5 BY .91 AT ROW 5.62 COL 6.67
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Agent Code  :" VIEW-AS TEXT
          SIZE 13 BY .91 AT ROW 9.48 COL 19.83
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer  Code-08_NN :" VIEW-AS TEXT
          SIZE 23 BY .91 AT ROW 6.57 COL 10
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Net Premium :" VIEW-AS TEXT
          SIZE 22.33 BY 1.05 AT ROW 22.86 COL 96 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Producer  Code-NU :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 3.71 COL 13
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "BHT.":60 VIEW-AS TEXT
          SIZE 6 BY 1.05 AT ROW 21.86 COL 117.17
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Success Record :" VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 22.86 COL 60.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Output Data Load :" VIEW-AS TEXT
          SIZE 18.5 BY .91 AT ROW 12.43 COL 14
          BGCOLOR 8 FGCOLOR 1 
     "Producer  Code-NN :" VIEW-AS TEXT
          SIZE 20 BY .91 AT ROW 4.67 COL 13
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "Input File Name Load :" VIEW-AS TEXT
          SIZE 22 BY .91 AT ROW 11.43 COL 10.5
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "   Total Net Premium  :" VIEW-AS TEXT
          SIZE 21.5 BY 1.05 AT ROW 21.86 COL 95.83 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "     Total Record :":60 VIEW-AS TEXT
          SIZE 17.5 BY 1.05 AT ROW 21.86 COL 60.33 RIGHT-ALIGNED
          BGCOLOR 8 FGCOLOR 1 FONT 6
     "PARAMETER :" VIEW-AS TEXT
          SIZE 14.5 BY .91 AT ROW 2.76 COL 109.5 RIGHT-ALIGNED WIDGET-ID 4
          BGCOLOR 8 FGCOLOR 1 FONT 6
     RECT-370 AT ROW 1 COL 3
     RECT-372 AT ROW 2.57 COL 3
     RECT-374 AT ROW 21.14 COL 3
     RECT-375 AT ROW 21.38 COL 4
     RECT-376 AT ROW 21.62 COL 5.5
     RECT-377 AT ROW 11.43 COL 100.17
     RECT-378 AT ROW 13.24 COL 100.17
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
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "LOAD TEXT FILE MOTOR TO GW (K-Leasing)"
         HEIGHT             = 23.95
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
/* BROWSE-TAB br_cam 1 fr_main */
/* BROWSE-TAB br_wdetail fi_brndes fr_main */
ASSIGN 
       br_cam:SEPARATOR-FGCOLOR IN FRAME fr_main      = 8.

ASSIGN 
       br_wdetail:COLUMN-RESIZABLE IN FRAME fr_main       = TRUE
       br_wdetail:SEPARATOR-FGCOLOR IN FRAME fr_main      = 0.

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
/* SETTINGS FOR FILL-IN fi_proname_08nn IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname_12nn IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname_benz IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname_NN IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname_nu IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fi_proname_rw IN FRAME fr_main
   NO-ENABLE                                                            */
/* SETTINGS FOR TEXT-LITERAL "PARAMETER :"
          SIZE 14.5 BY .91 AT ROW 2.76 COL 109.5 RIGHT-ALIGNED          */

/* SETTINGS FOR TEXT-LITERAL "PACK NEW :"
          SIZE 13 BY .91 AT ROW 3.76 COL 110 RIGHT-ALIGNED              */

/* SETTINGS FOR TEXT-LITERAL "Batch Year :"
          SIZE 12 BY .91 AT ROW 10.43 COL 68.17 RIGHT-ALIGNED           */

/* SETTINGS FOR TEXT-LITERAL "     Total Record :"
          SIZE 17.5 BY 1.05 AT ROW 21.86 COL 60.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "   Total Net Premium  :"
          SIZE 21.5 BY 1.05 AT ROW 21.86 COL 95.83 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Record :"
          SIZE 17.5 BY 1.05 AT ROW 22.86 COL 60.33 RIGHT-ALIGNED        */

/* SETTINGS FOR TEXT-LITERAL "Success Net Premium :"
          SIZE 22.33 BY 1.05 AT ROW 22.86 COL 96 RIGHT-ALIGNED          */

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

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
OPEN QUERY br_query FOR EACH wdetail.
     _END_FREEFORM
     _Query            is NOT OPENED
*/  /* BROWSE br_wdetail */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _QUERY-BLOCK FRAME fr_main
/* Query rebuild information for FRAME fr_main
     _Query            is NOT OPENED
*/  /* FRAME fr_main */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* LOAD TEXT FILE MOTOR TO GW (K-Leasing) */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* LOAD TEXT FILE MOTOR TO GW (K-Leasing) */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_wdetail
&Scoped-define SELF-NAME br_wdetail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL br_wdetail C-Win
ON ROW-DISPLAY OF br_wdetail IN FRAME fr_main
DO:
    DEF VAR z AS INTE  INIT 0.
    DEF VAR s AS INTE  INIT 0.
    s = 1.
    z = 26.
    IF WDETAIL.WARNING <> "" THEN DO:
        wdetail.producer  :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.agent     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.poltyp    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.policy    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.name1     :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.   
        wdetail.comdat    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR.
        wdetail.expdat    :BGCOLOR IN BROWSE BR_WDETAIL = z NO-ERROR. 

        
        wdetail.producer  :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.agent     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.    
        wdetail.poltyp    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.policy    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.name1     :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.comdat    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
        wdetail.expdat    :FGCOLOR IN BROWSE BR_WDETAIL = s NO-ERROR.  
          
          
          
  END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME buok
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL buok C-Win
ON CHOOSE OF buok IN FRAME fr_main /* OK */
DO:
    FOR EACH wdetail.
        DELETE wdetail.
    END.
    RUN proc_Clear.    /* ---- suthida T. A52-0275 27-09-10 ----- */
    RUN proc_Clear1.   /* ---- suthida T. A52-0275 27-09-10 ----- */
    ASSIGN
        fi_completecnt:FGCOLOR = 2
        fi_premsuc:FGCOLOR     = 2 
        fi_bchno:FGCOLOR       = 2
        fi_completecnt         = 0
        fi_premsuc             = 0
        fi_bchno               = ""
        fi_premtot             = 0
        fi_impcnt              = 0
        fi_process             = " LOAD TEXT FILE MOTOR TO GW [K-Leasing]....." .
    DISP fi_process  fi_impcnt fi_completecnt fi_premtot fi_premsuc fi_impcnt fi_premtot WITH FRAME fr_main.
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
    /*IF fi_usrcnt <= 0  THEN DO:
        MESSAGE "Policy Count can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrcnt.
        RETURN NO-APPLY.
    END.*/
    /*IF fi_usrprem <= 0  THEN DO:
        MESSAGE "Total Net Premium can't Be 0" VIEW-AS ALERT-BOX.
        APPLY "entry" to fi_usrprem.
        RETURN NO-APPLY.
    END.*/
    ASSIGN
        fi_output1 = INPUT fi_output1
        fi_output2 = INPUT fi_output2
        fi_output3 = INPUT fi_output3.
    IF fi_output1  = "" THEN DO:
        MESSAGE "Plese Input File Data Load...!!!"   VIEW-AS ALERT-BOX ERROR.
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
        /* ------------ suthida T. A52-0275 20-09-10 ---------------- 
        FIND LAST uzm700 USE-INDEX uzm70001
            WHERE uzm700.acno    = TRIM(fi_producer)  AND
                  uzm700.branch  = TRIM(nv_batbrn) AND
                  uzm700.bchyr = nv_batchyr
         ------------ suthida T. A52-0275 20-09-10 -----------------*/
        /* ------------ suthida T. A52-0275 20-09-10 ---------------- */
        FIND LAST uzm700 USE-INDEX uzm70001    WHERE
            uzm700.bchyr   = nv_batchyr        AND
            uzm700.branch  = TRIM(nv_batbrn)   AND
            uzm700.acno    = TRIM(fi_producer) NO-LOCK NO-ERROR .  /* -- suthida T. A52-0275 20-09-10  ---  */
        IF AVAIL uzm700 THEN DO: 
            ASSIGN nv_batrunno = uzm700.runno.
            FIND LAST uzm701 USE-INDEX uzm70102  WHERE
                uzm701.bchyr = nv_batchyr   AND
                uzm701.bchno = trim(fi_producer) + TRIM(nv_batbrn) + string(nv_batrunno,"9999") NO-LOCK NO-ERROR.
            IF AVAIL uzm701 THEN DO:
                ASSIGN nv_batcnt = uzm701.bchcnt 
                     nv_batrunno = nv_batrunno + 1.
            END.
        END.
        ELSE DO:  
            ASSIGN
                nv_batcnt = 1
                nv_batrunno = 1.
        END.
        ASSIGN nv_batchno = CAPS(fi_producer) + CAPS(nv_batbrn) + STRING(nv_batrunno,"9999").
    END.
    ELSE DO:  
        nv_batprev = INPUT fi_prevbat.
        FIND LAST uzm701 USE-INDEX uzm70102  WHERE uzm701.bchno = CAPS(nv_batprev) NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL uzm701 THEN DO:
            MESSAGE "Not found Batch File Master : " + CAPS (nv_batprev) + " on file uzm701" .
            APPLY "entry" TO fi_prevbat.
            RETURN NO-APPLY.
        END.
        IF AVAIL uzm701 THEN DO:
            nv_batcnt  = uzm701.bchcnt + 1.
            nv_batchno = CAPS(TRIM(nv_batprev)).
        END.
    END.
    ASSIGN
        fi_loaddat   = INPUT fi_loaddat     fi_branch       = INPUT fi_branch
        fi_producer  = INPUT fi_producer    fi_agent        = INPUT fi_agent 
        fi_bchyr     = INPUT fi_bchyr       fi_prevbat      = INPUT fi_prevbat
        /*fi_usrcnt    = INPUT fi_usrcnt */    /* fi_usrprem      = INPUT fi_usrprem*/
        /* nv_imppol    = fi_usrcnt*/          /*  nv_impprem      = fi_usrprem */
        nv_tmppolrun = 0                    nv_daily        = ""
        nv_reccnt    = 0                    nv_completecnt  = 0
        nv_netprm_t  = 0                    nv_netprm_s     = 0
        nv_batbrn    = fi_branch 
        nv_renew     = NO.   /* ------ suthida T. A54-0010 -21-06-11 ------  */
    FOR EACH  wdetail :
        DELETE  wdetail.
    END.
    nv_count = 0.
    RUN proc_import.   /* Import text create to workfile */
    IF ra_typechk = 2 THEN DO:
        RUN proc_Checkdatarenew.
        FOR EACH wdetail:
        
            ASSIGN
                nv_reccnt      =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + DECIMAL(wdetail.premt).
                
        END.
    
    END.
    ELSE DO:

    FOR EACH wdetail:
        IF SUBSTRING(wdetail.applino,1,2) = "RW" THEN nv_renew = YES.  /*------ suthida T. A54-0010 21-06-11 ----*/
        IF SUBSTRING(wdetail.applino,1,2) = "RW" OR  SUBSTRING(wdetail.applino,1,2) = "NB" THEN DO:
            ASSIGN
                nv_reccnt      =  nv_reccnt   + 1
                nv_netprm_t    =  nv_netprm_t + DECIMAL(wdetail.premt)
                wdetail.pass   =  "Y". 
        END.
        ELSE DELETE WDETAIL.
    END.
    OPEN QUERY br_wdetail FOR EACH wdetail WHERE 
    wdetail.policy <> "" AND 
    wdetail.pass = "y" .
    IF  nv_reccnt = 0 THEN DO: 
        MESSAGE "No Record Can Gen " VIEW-AS ALERT-BOX.       
        RETURN NO-APPLY.
    END.
    /*comment by Kridtiya i. A64-0138 Date. 05/11/2021  ......
    /*Add by Kridtiya i. A63-0472.*/
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
    end....comment by Kridtiya i. A64-0138 Date. 05/11/2021 */
    RUN wgw\wgwbatch.p    (INPUT            fi_loaddat ,     /* DATE  */
                           INPUT            nv_batchyr ,     /* INT   */
                           INPUT            fi_producer,     /* CHAR  */ 
                           INPUT            nv_batbrn  ,     /* CHAR  */
                           INPUT            fi_prevbat ,     /* CHAR  */ /*Previous Batch*/
                           INPUT            "WGWKLGEN" ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batchno ,     /* CHAR  */
                           INPUT-OUTPUT     nv_batcnt  ,     /* INT   */
                           INPUT            nv_imppol  ,     /* INT   */
                           INPUT            nv_impprem       /* DECI  */
                           ).
    ASSIGN fi_bchno = CAPS(nv_batchno + "." + STRING(nv_batcnt,"99")).
    DISP  fi_bchno   WITH FRAME fr_main.
    RUN proc_creatogw.    /* Create data first page in GW */

    END. /*ra_typechk*/

    ASSIGN
        nv_completecnt  = 0
        nv_netprm_s     = 0.
    FOR EACH wdetail WHERE wdetail.pass = "y" :
        ASSIGN
            nv_completecnt = nv_completecnt + 1
            nv_netprm_s    = nv_netprm_s +  DECIMAL(wdetail.premt). 
    END.

    ASSIGN 
        nv_rectot = nv_reccnt
        nv_recsuc = nv_completecnt. 

    ASSIGN
        fi_impcnt      = nv_rectot
        fi_premtot     = nv_netprm_t
        fi_completecnt = nv_recsuc
        fi_premsuc     = nv_netprm_s .

    IF nv_rectot <> nv_recsuc  THEN nv_txtmsg = " have record error..!! ".
    ELSE nv_txtmsg = "      have batch file error..!! ".

    IF nv_renew = YES AND nv_rectot = nv_recsuc THEN nv_batflg = YES.
    ELSE DO:
        /*--- Check Record ---*/
        IF  /*nv_imppol <> nv_rectot OR*/
            /*nv_imppol <> nv_recsuc OR*/
            nv_rectot <> nv_recsuc THEN
            nv_batflg = NO.
        ELSE   /*--- Check Premium ---*/
            IF /*nv_impprem  <> nv_netprm_t OR
            nv_impprem  <> nv_netprm_s OR*/
                nv_netprm_t <> nv_netprm_s THEN
                nv_batflg = NO.
            ELSE nv_batflg = YES.
    END.

    FIND LAST uzm701 USE-INDEX uzm70102  
        WHERE uzm701.bchyr   = nv_batchyr AND
              uzm701.bchno   = nv_batchno AND
              uzm701.bchcnt  = nv_batcnt  NO-ERROR.
    IF AVAIL uzm701 THEN DO:
        ASSIGN
            uzm701.recsuc      = nv_recsuc     
            uzm701.premsuc     = nv_netprm_s   
            uzm701.rectot      = nv_rectot     
            uzm701.premtot     = nv_netprm_t   
            uzm701.impflg      = nv_batflg    
            uzm701.cnfflg      = nv_batflg .   
    END.
    /* add by : A64-0138 */
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
     /*...end A64-0138...*/
    IF nv_batflg = NO THEN DO:  
        ASSIGN
            fi_completecnt:FGCOLOR = 6
            fi_premsuc    :FGCOLOR = 6 
            fi_bchno    :FGCOLOR = 6. 
        DISP fi_completecnt fi_premsuc WITH FRAME fr_main.
        MESSAGE "Batch Year  : " STRING(nv_batchyr)     SKIP
            "Batch No.   : " nv_batchno             SKIP
            "Batch Count : " STRING(nv_batcnt,"99") SKIP(1)
            TRIM(nv_txtmsg)                         SKIP
            "Please check Data again."      
            VIEW-AS ALERT-BOX ERROR TITLE "WARNING MESSAGE".        
    END.
    ELSE IF nv_batflg = YES THEN DO: 
        ASSIGN
            fi_completecnt:FGCOLOR = 2
            fi_premsuc:FGCOLOR     = 2 
            fi_bchno:FGCOLOR       = 2.
        MESSAGE "Process Complete" VIEW-AS ALERT-BOX INFORMATION TITLE "INFORMATION".
    END.
    
    RUN   proc_open.
    DISP  fi_impcnt fi_completecnt fi_premtot fi_premsuc WITH FRAME fr_main.
    RUN proc_report1 .
    RUN PROC_REPORT2 .
    RUN proc_screen  . 
    RUN proc_Clear1.   /* ---- suthida T. A52-0275 27-09-10 ----- */
    /* A64-0138  
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
    A64-0138 */ 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_exit C-Win
ON CHOOSE OF bu_exit IN FRAME fr_main /* EXIT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
      RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_file
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_file C-Win
ON CHOOSE OF bu_file IN FRAME fr_main /* ... */
DO:
    DEFINE VARIABLE cvData        AS CHARACTER NO-UNDO.
    DEFINE VARIABLE OKpressed AS LOGICAL INITIAL TRUE.

    DEF VAR no_add AS CHAR FORMAT "x(8)" . /*08/11/2006*/

   SYSTEM-DIALOG GET-FILE cvData
        TITLE      "Choose Data File to Import ..."
       
       FILTERS   /* "Text Files (*.txt)" "*.txt"*/  /*kridtiya i. A57-0244*/
                 "CSV (Comma Delimited)"   "*.csv"  /*kridtiya i. A57-0244*/
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


&Scoped-define SELF-NAME bu_hpacno08nn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno08nn C-Win
ON CHOOSE OF bu_hpacno08nn IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno,  
                     output  n_agent).
    If  n_acno  <>  ""  Then  fi_producer_08nn =  n_acno.
    disp  fi_producer_08nn  with frame  fr_main.
    Apply "Entry"  to  fi_producer_08nn.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno12nn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno12nn C-Win
ON CHOOSE OF bu_hpacno12nn IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno,  
                     output  n_agent).
    If  n_acno  <>  ""  Then  fi_producer_08nn =  n_acno.
    disp  fi_producer_08nn  with frame  fr_main.
    Apply "Entry"  to  fi_producer_08nn.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno_benz
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno_benz C-Win
ON CHOOSE OF bu_hpacno_benz IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno, 
                     output  n_agent).
    If  n_acno  <>  ""  Then  fi_producer_benz =  n_acno.
    disp  fi_producer_benz  with frame  fr_main.
    Apply "Entry"  to  fi_producer_benz.
    Return no-apply.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno_nn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno_nn C-Win
ON CHOOSE OF bu_hpacno_nn IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno, /*a490166 note modi*/ /*28/11/2006*/
                     output  n_agent).
    If  n_acno  <>  ""  Then  fi_producer_NN =  n_acno.
    disp  fi_producer_NN  with frame  fr_main.
    Apply "Entry"  to  fi_producer_NN.
    Return no-apply.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno_nu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno_nu C-Win
ON CHOOSE OF bu_hpacno_nu IN FRAME fr_main
DO:
    Def   var     n_acno       As  Char.
    Def   var     n_agent      As  Char.    
    Run whp\whpacno1(output  n_acno,      
                     output  n_agent).
    If  n_acno  <>  ""  Then  fi_producer_nu =  n_acno.
    disp  fi_producer_NU  with frame  fr_main.
    Apply "Entry"  to  fi_producer_NU.
    Return no-apply.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME bu_hpacno_rw
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpacno_rw C-Win
ON CHOOSE OF bu_hpacno_rw IN FRAME fr_main
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpagent C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL bu_hpbrn C-Win
ON CHOOSE OF bu_hpbrn IN FRAME fr_main
DO:
   Run  whp\whpbrn01(Input-output  fi_branch, /*a490166 note modi*/
                     Input-output   fi_brndes).
                                     
   Disp  fi_branch  fi_brndes  with frame  fr_main.                                     
   Apply "Entry"  To  fi_producer.
   Return no-apply.                            
                                        

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_agent
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_agent C-Win
ON LEAVE OF fi_agent IN FRAME fr_main
DO:
    fi_agent = INPUT fi_agent.
    IF fi_agent <> ""    THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_agent  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" 
                View-as alert-box.
            Apply "Entry" To  fi_agent  .
            RETURN NO-APPLY.  
        END.
        ELSE DO:  
            ASSIGN
                fi_agtname =  TRIM(sicsyac.xmm600.ntitle) + " "  + TRIM(sicsyac.xmm600.name)
                fi_agent   =  caps(INPUT  fi_agent)  
                nv_agent   =  fi_agent. 
        END.
    END.
    Disp  fi_agent  fi_agtname  WITH Frame  fr_main.                 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_bchyr
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_bchyr C-Win
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
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_branch C-Win
ON LEAVE OF fi_branch IN FRAME fr_main
DO:
  IF  Input fi_branch  =  ""  Then do:
       Message "กรุณาระบุ Branch Code ." View-as alert-box.
       Apply "Entry"  To  fi_branch.
  END.
  Else do:
  FIND sicsyac.xmm023  USE-INDEX xmm02301      WHERE
       sicsyac.xmm023.branch   =  Input  fi_branch 
       NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL  sicsyac.xmm023 THEN DO:
               Message  "Not on Description Master File xmm023" 
               View-as alert-box.
               Apply "Entry"  To  fi_branch.
               RETURN NO-APPLY.
        END.
  fi_branch  =  CAPS(Input fi_branch) .
  fi_brndes  =  sicsyac.xmm023.bdes.
  End. /*else do:*/

  Disp fi_branch  fi_brndes  With Frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_loaddat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_loaddat C-Win
ON LEAVE OF fi_loaddat IN FRAME fr_main
DO:
  fi_loaddat  =  Input  fi_loaddat.
  Disp  fi_loaddat  with  frame  fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_pack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_pack C-Win
ON LEAVE OF fi_pack IN FRAME fr_main
DO:
        fi_pack = INPUT fi_pack.
        DISP fi_pack WITH FRAME fr_main .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_packnew
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_packnew C-Win
ON LEAVE OF fi_packnew IN FRAME fr_main
DO:
        fi_packnew = INPUT fi_packnew.
        DISP fi_packnew WITH FRAME fr_main .

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_prevbat
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_prevbat C-Win
ON LEAVE OF fi_prevbat IN FRAME fr_main
DO:
    fi_prevbat = caps(INPUT fi_prevbat).
    nv_batprev = fi_prevbat.
    /*IF nv_batprev <> " "  THEN DO:
        IF LENGTH(nv_batprev) <> 13 THEN DO:
             MESSAGE "Length Of Batch no. Must Be 13 Character " SKIP
                     "Please Check Batch No. Again             " view-as alert-box.
             APPLY "entry" TO fi_prevbat.
             RETURN NO-APPLY.
        END.
    END. */ 
    DISPLAY fi_prevbat WITH FRAME fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer C-Win
ON LEAVE OF fi_producer IN FRAME fr_main
DO:
    fi_producer = INPUT fi_producer .
    IF  fi_producer <> " " THEN DO: 
        FIND sicsyac.xmm600 USE-INDEX xmm60001            WHERE
            sicsyac.xmm600.acno  =  Input fi_producer   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer .
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            ASSIGN
                fi_proname_rw  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer    =  caps(INPUT  fi_producer)  
                nv_producer    = fi_producer .             
        END.
    END.
    DISP  fi_producer  fi_proname_rw  WITH Frame  fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer_08nn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer_08nn C-Win
ON LEAVE OF fi_producer_08nn IN FRAME fr_main
DO:
    fi_producer_08nn = INPUT fi_producer_08nn.
    IF  fi_producer_08nn <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001        WHERE
            sicsyac.xmm600.acno  =  Input fi_producer_08nn NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600..."  View-as alert-box.
            Apply "Entry" To  fi_producer_08nn.
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            ASSIGN
                fi_proname_08nn  = TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer_08nn = caps(INPUT  fi_producer_08nn)  
                nv_producer      = fi_producer_08nn .                  
        END.
    END.
    DISP  fi_producer_08nn  fi_proname_08nn  WITH Frame  fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer_12nn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer_12nn C-Win
ON LEAVE OF fi_producer_12nn IN FRAME fr_main
DO:
    fi_producer_12nn = INPUT fi_producer_12nn.
    IF  fi_producer_12nn <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001        WHERE
            sicsyac.xmm600.acno  =  Input fi_producer_12nn NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600..."  View-as alert-box.
            Apply "Entry" To  fi_producer_12nn.
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            ASSIGN
                fi_proname_12nn  = TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer_12nn = caps(INPUT  fi_producer_12nn)  
                nv_producer      = fi_producer_12nn .                  
        END.
    END.
    DISP  fi_producer_12nn  fi_proname_12nn  WITH Frame  fr_main.   
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer_benz
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer_benz C-Win
ON LEAVE OF fi_producer_benz IN FRAME fr_main
DO:

    fi_producer_benz = INPUT fi_producer_benz .
    IF  fi_producer_benz <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  Input fi_producer_benz  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600" View-as alert-box.
            Apply "Entry" To  fi_producer_benz.
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            ASSIGN
                fi_proname_benz  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer_benz =  caps(INPUT fi_producer_benz) 
                nv_producer      =  fi_producer_benz .           
        END.
    END.
    DISP  fi_producer_benz  fi_proname_benz  WITH Frame  fr_main. 
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer_nn
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer_nn C-Win
ON LEAVE OF fi_producer_nn IN FRAME fr_main
DO:
    fi_producer_nn = INPUT fi_producer_nn .
    IF  fi_producer_nn <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001           WHERE
            sicsyac.xmm600.acno  =  Input fi_producer_nn  NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer_nn.
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            ASSIGN
                fi_proname_NN  =  TRIM(sicsyac.xmm600.ntitle) + "  "  + TRIM(sicsyac.xmm600.name)
                fi_producer_nn =  caps(INPUT  fi_producer_nn)  
                nv_producer    =  fi_producer_nn.            
        END.
    END.
    DISP  fi_producer_nn  fi_proname_NN  WITH Frame  fr_main.   
    
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fi_producer_nu
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fi_producer_nu C-Win
ON LEAVE OF fi_producer_nu IN FRAME fr_main
DO:
    fi_producer_nu = INPUT fi_producer_nu.
    IF  fi_producer_nu <> " " THEN DO:
        FIND sicsyac.xmm600 USE-INDEX xmm60001      WHERE
            sicsyac.xmm600.acno  =  fi_producer_nu   NO-LOCK NO-ERROR NO-WAIT.
        IF NOT AVAIL sicsyac.xmm600 THEN DO:
            Message  "Not on Name & Address Master File xmm600"  View-as alert-box.
            Apply "Entry" To  fi_producer_nu.
            RETURN NO-APPLY.  
        END.
        ELSE DO:
            ASSIGN
                fi_proname_nu  =  TRIM(sicsyac.xmm600.ntitle) + " "  + TRIM(sicsyac.xmm600.name)
                fi_producer_nu =  caps(INPUT  fi_producer_nu)    
                nv_producer    = fi_producer_nu .               
        END.
    END.
    DISP  fi_producer_nu  fi_proname_nu  WITH Frame  fr_main.  
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME ra_typechk
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL ra_typechk C-Win
ON VALUE-CHANGED OF ra_typechk IN FRAME fr_main
DO:
  ra_typechk = INPUT ra_typechk.
  DISP ra_typechk WITH FRAM fr_main.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME br_cam
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
  
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.


/********************  T I T L E   F O R  C - W I N  ****************/
  DEF  VAR  gv_prgid   AS   CHAR  FORMAT "X(8)"   NO-UNDO.
  DEF  VAR  gv_prog    AS   CHAR  FORMAT "X(40)" NO-UNDO.
  
  gv_prgid = "Wgwklgen".
  gv_prog  = "Load Text & Generate K-Leasing".
  fi_loaddat = TODAY.
  DISP fi_loaddat WITH FRAME fr_main.
 /* RUN  WUT\WUTHEAD (c-win:handle,gv_prgid,gv_prog). /*28/11/2006*/*/
  ASSIGN
      fi_pack     = "PACK RENEW" /*a63-0162*/
      fi_packnew  = "KL-PACK" /*A63-0162*/
      fi_branch   = "M"
      /*fi_producer = "A0M0068"        /*A57-0244*/
      fi_agent    = "B300303"*/        /*A57-0244*/
      /*/*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_producer_nu   = "A0M0032"     /*A57-0244*/
      fi_producer_nn   = "A0M0068"     /*A57-0244*/
      fi_producer_benz = "A0M0071"     /*A57-0244*/
      fi_producer_08nn = "A0M0127"     /*A57-0244*/
      fi_producer_12nn = "A0M0127"     /*A58-0184*/
      fi_producer      = "A0M0054"     /*A57-0244*/
      fi_agent         = "B3M0025"     /*A57-0244*/
      /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/*/
      fi_producer_nu   = "B3MLKL0101"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_producer_nn   = "B3MLKL0103"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_producer_benz = "B3MLKL0104"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_producer_08nn = "B3MLKL0105"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_producer_12nn = "B3MLKL0105"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_producer      = "B3MLKL0102"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
      fi_agent         = "B3MLKL0100"    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/  
      ra_typechk       = 1
      fi_bchyr         = YEAR(TODAY) .
  DISP  fi_branch  /*fi_producer fi_agent*/  fi_producer_nu   ra_typechk
      fi_producer_nn  fi_producer_benz fi_producer_08nn fi_producer_12nn  /*A58-0184*/
      fi_producer     fi_agent         fi_bchyr  fi_pack  fi_packnew /*a63-0162*/ WITH FRAME fr_main.
  RUN proc_creatpara. /*a63-0162*/
/*********************************************************************/  
  RUN  WUT\WUTWICEN (c-win:HANDLE).  
  SESSION:DATA-ENTRY-RETURN = YES.

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
  DISPLAY ra_typechk fi_loaddat fi_branch fi_producer_nn fi_agent fi_prevbat 
          fi_bchyr fi_filename fi_output1 fi_output2 fi_bchno fi_output3 
          fi_brndes fi_proname_NN fi_agtname fi_producer_benz fi_proname_benz 
          fi_producer_08nn fi_impcnt fi_proname_08nn fi_producer fi_proname_rw 
          fi_producer_nu fi_completecnt fi_premtot fi_proname_nu fi_premsuc 
          fi_producer_12nn fi_proname_12nn fi_process fi_pack fi_packnew 
      WITH FRAME fr_main IN WINDOW C-Win.
  ENABLE br_cam ra_typechk fi_loaddat fi_branch fi_producer_nn fi_agent 
         fi_prevbat fi_bchyr fi_filename bu_file fi_output1 fi_output2 fi_bchno 
         fi_output3 buok bu_exit br_wdetail bu_hpbrn bu_hpacno_nn bu_hpagent 
         fi_producer_benz bu_hpacno_benz fi_producer_08nn bu_hpacno08nn 
         fi_producer bu_hpacno_rw fi_producer_nu bu_hpacno_nu fi_producer_12nn 
         bu_hpacno12nn fi_process fi_pack fi_packnew RECT-370 RECT-372 RECT-374 
         RECT-375 RECT-376 RECT-377 RECT-378 
      WITH FRAME fr_main IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-fr_main}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE pd_mailtxtrenew C-Win 
PROCEDURE pd_mailtxtrenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH ws0m009 WHERE ws0m009.policy  = n_driver NO-LOCK .
            IF ws0m009.ltext  <>  ""  THEN DO:
               FIND LAST brstat.mailtxt_fil  USE-INDEX  mailtxt01    WHERE
                     brstat.mailtxt_fil.policy    = np_driver    AND
                     brstat.mailtxt_fil.bchyr     = nv_batchyr   AND                                               
                     brstat.mailtxt_fil.bchno     = nv_batchno   AND
                     brstat.mailtxt_fil.bchcnt    = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
                   IF NOT AVAIL brstat.mailtxt_fil THEN DO:  
                      FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                               brstat.mailtxt_fil.policy  = np_driver     AND
                               brstat.mailtxt_fil.lnumber = INTEGER(ws0m009.lnumber)  AND
                               brstat.mailtxt_fil.bchyr   = nv_batchyr    AND                                               
                               brstat.mailtxt_fil.bchno   = nv_batchno    AND
                               brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
                       IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
                        CREATE brstat.mailtxt_fil.
                        ASSIGN                                           
                               brstat.mailtxt_fil.policy   = np_driver
                               brstat.mailtxt_fil.lnumber  = INTEGER(ws0m009.lnumber)
                               brstat.mailtxt_fil.ltext    = ws0m009.ltext 
                               brstat.mailtxt_fil.ltext2   = ws0m009.ltext2
                               brstat.mailtxt_fil.bchyr    = nv_batchyr 
                               brstat.mailtxt_fil.bchno    = nv_batchno 
                               brstat.mailtxt_fil.bchcnt   = nv_batcnt.
                       END.
                   END.
                   ELSE DO:
                       CREATE brstat.mailtxt_fil.                                           
                       ASSIGN                                                               
                              brstat.mailtxt_fil.policy   = np_driver                       
                              brstat.mailtxt_fil.lnumber  = INTEGER(ws0m009.lnumber)        
                              brstat.mailtxt_fil.ltext    = ws0m009.ltext                   
                              brstat.mailtxt_fil.ltext2   = ws0m009.ltext2                  
                              brstat.mailtxt_fil.bchyr    = nv_batchyr                      
                              brstat.mailtxt_fil.bchno    = nv_batchno                      
                              brstat.mailtxt_fil.bchcnt   = nv_batcnt. 
               
                   END.
                 ASSIGN nv_drivno    = INTEGER(ws0m009.lnumber).
                        wdetail.drivnam  = "Y" .
            END.
            ELSE NEXT.
       END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_72 C-Win 
PROCEDURE proc_72 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk_sticker AS CHAR FORMAT "x(13)". /* ---- suthida t. A52-0275 27-09-10 ------- */
ASSIGN
    chr_sticker = ""
    nv_modulo   =  0.

/************** v72 comp y **********/
IF (wdetail.poltyp = "V72") OR (wdetail.poltyp = "V74")   THEN DO:
    IF wdetail.compul <> "y" THEN 
        ASSIGN /*a490166*/
            wdetail.comment = wdetail.comment + "| poltyp เป็น v72/V74 Compulsory ต้องเป็น y" 
            wdetail.pass    = "N"
            WDETAIL.OK_GEN  = "N".

    IF wdetail.stk  = "" THEN DO:
         IF SUBSTRING(wdetail.applino,1,2) = "RW" THEN DO: 
            wdetail.comment = wdetail.comment + "Generate Sticker No. ในระบบ Premium".
         END.
         ELSE DO:
            ASSIGN /*a490166*/
                wdetail.comment = wdetail.comment + "| poltyp เป็น v72/V74 ต้องมี Sticker No." 
                wdetail.pass    = "N"
                WDETAIL.OK_GEN  = "N". 
         END.

    END.
      
END.

IF wdetail.compul = "y" THEN DO:
    IF wdetail.stk <> "" OR wdetail.covcod = "T" THEN DO:   
        /* ------------ suthida T. A52-0275 27-09-10 ---------- 
        IF SUBSTRING(wdetail.stk,1,1) = "2"  THEN wdetail.stk = "0" + wdetail.stk.
        IF LENGTH(wdetail.stk) < 9 OR LENGTH(wdetail.stk) > 13 THEN DO:
            IF SUBSTRING(wdetail.applino,1,2) = "RW" THEN 
               wdetail.comment = wdetail.comment + "Generate Sticker No. ในระบบ Premium".
            
            ELSE
                ASSIGN 
                    wdetail.comment = wdetail.comment + "| เลข Sticker ต้องเป็น 11 หรือ 13 หลักเท่านั้น"
                    wdetail.pass    = "N"
                    WDETAIL.OK_GEN  = "N".
            
        END.
        ----------------- suthida T. A52-0275 27-09-10 ----------------- */

        /* ----------------- add suthida T. A52-0275 27-09-10 -----------------*/
        ASSIGN
            chr_sticker = ""
            nv_modulo   =  0.
        IF SUBSTRING(wdetail.applino,1,2) = "RW" THEN DO: 
           wdetail.comment = wdetail.comment + "Generate Sticker No. ในระบบ Premium".
        END.
        ELSE DO:
            /*IF SUBSTR(wdetail.stk,1,1) = "2" THEN chk_sticker = "0" + wdetail.stk.
            ELSE chk_sticker = wdetail.stk. -- A58-0372--*/
            IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
            chk_sticker = wdetail.stk.

            chr_sticker = chk_sticker.

            RUN wuz\wuzchmod. /* Check sticker */

            IF chk_sticker  <>  chr_sticker  THEN DO:
                ASSIGN
                  wdetail.pass    = "N"
                  wdetail.comment = wdetail.comment + "| Error1 : Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
            
            END.
        END. 
        /* ----------------- end suthida T. A52-0275 27-09-10 -----------------*/
    END.    
END.

/* ------------ Check  Error -------------- */
IF wdetail.endcnt = 0 THEN DO:  /* Check เฉพาะที่เป็นกรมธรรม์และต่ออายุ */
    IF wdetail.recnt LT 0 THEN 
       ASSIGN
         wdetail.pass    = "N"  
         wdetail.comment = wdetail.comment + "| Renewal Count error"
         WDETAIL.OK_GEN  = "N".

    IF wdetail.endcnt <> 0 THEN 
       ASSIGN
         wdetail.pass    = "N"  
         wdetail.comment = wdetail.comment + "| Endorsement Count error"
         WDETAIL.OK_GEN  = "N".

    IF wdetail.comdat  = ? OR wdetail.expdat = ? THEN
       ASSIGN
         wdetail.pass    = "N"  
         wdetail.comment = wdetail.comment + "| ComDate, ExpDate error"
         WDETAIL.OK_GEN  = "N".

    IF wdetail.poltyp = "" THEN 
        ASSIGN
          wdetail.pass    = "N"  
          wdetail.comment = wdetail.comment + "| Policy Type is blank"
          WDETAIL.OK_GEN  = "N".

    IF (wdetail.addrss1 + wdetail.addrss2 + wdetail.addrss3 + wdetail.addrss4) = "" THEN 
        ASSIGN
          wdetail.pass    = "N"  
          wdetail.comment = wdetail.comment + "| Address is blank"
          WDETAIL.OK_GEN  = "N".

END.  /* endcnt = 0 */
IF wdetail.cancel = "ca"  THEN  
    ASSIGN
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| cancel"
        WDETAIL.OK_GEN  = "N".

IF wdetail.name1 = " " THEN 
    ASSIGN
        wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
        wdetail.pass    = "N"     
        WDETAIL.OK_GEN  = "N".

/*---------- class --------------*/
FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  xmm016.class =   wdetail.class
    NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.xmm016 THEN 
    ASSIGN 
        wdetail.comment = wdetail.comment + "| ไม่พบ Class นี้ในระบบ"
        wdetail.pass    = "N"
        WDETAIL.OK_GEN  = "N".

/*------------- poltyp ------------*/
IF (wdetail.poltyp <> "V72") AND  (wdetail.poltyp <> "V74")  THEN DO:
    FIND  sicsyac.xmd031 USE-INDEX xmd03101 WHERE
        sicsyac.xmd031.poltyp = wdetail.poltyp  AND
        sicsyac.xmd031.class  = wdetail.class NO-LOCK NO-ERROR.
    IF NOT AVAIL sicsyac.xmd031 THEN 
        ASSIGN 
            wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| ไม่พบ Class ที่เป็นของ Policy Typeนี้"
            WDETAIL.OK_GEN  = "N".
END. 

/*---------- covcod ----------*/
wdetail.covcod = CAPS(wdetail.covcod).

FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U013"    AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN 
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| ไม่พบ Cover Type นี้ในระบบ"
        WDETAIL.OK_GEN  = "N".

FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
    sicsyac.xmm106.tariff  = wdetail.tariff   AND  sicsyac.xmm106.bencod  = "COMP"     AND
    sicsyac.xmm106.class   = wdetail.class /*"110" */ AND  sicsyac.xmm106.covcod  = wdetail.covcod   NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAILABLE sicsyac.xmm106 THEN 
    ASSIGN  
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Tariff or Compulsory or Class or Cover Type ในระบบ"
        WDETAIL.OK_GEN = "N".

/*--------- modcod --------------*/
chkred = NO.

/*-------- vehuse   --------------*/
FIND sicsyac.sym100 USE-INDEX sym10001 WHERE
    sicsyac.sym100.tabcod = "U014"    AND
    sicsyac.sym100.itmcod = wdetail.vehuse NO-LOCK NO-ERROR.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN     
        wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ไม่พบ Veh.Usage ในระบบ "
        WDETAIL.OK_GEN  = "N".
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
        
        ASSIGN /*a490166*/     
            wdetail.pass    = "N"  
            wdetail.comment = "Receipt is Dup. on uwm100 :" + STRING(sicuw.uwm100.policy,"x(16)") +
            STRING(sicuw.uwm100.rencnt,"99")  + "/" +
            STRING(sicuw.uwm100.endcnt,"999") + sicuw.uwm100.renno + uwm100.endno
            WDETAIL.OK_GEN  = "N".
    ELSE 
        nv_docno = wdetail.docno.
END.

/***--- Account Date ---***/
IF wdetail.accdat <> " "  THEN nv_accdat = DATE(wdetail.accdat).
ELSE nv_accdat = TODAY.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_722 C-Win 
PROCEDURE proc_722 :
/* ---------------------------------------------  U W M 1 3 0 -------------- */
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND
    sic_bran.uwm130.riskgp = s_riskgp               AND  /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND  /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND  /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND  /*26/10/2006 change field name */
    sic_bran.uwm130.bchno  = nv_batchno             AND  /*26/10/2006 change field name */ 
    sic_bran.uwm130.bchcnt = nv_batcnt                   /*26/10/2006 change field name */            
    NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm130 THEN DO:
    
    DO TRANSACTION:
    CREATE sic_bran.uwm130.
    ASSIGN
        sic_bran.uwm130.policy = sic_bran.uwm120.policy
        sic_bran.uwm130.rencnt = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
        sic_bran.uwm130.riskgp = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
        sic_bran.uwm130.itemno = s_itemno.

    ASSIGN    /*a490166*/
        sic_bran.uwm130.bchyr   = nv_batchyr         /* batch Year */
        sic_bran.uwm130.bchno   = nv_batchno         /* bchno      */
        sic_bran.uwm130.bchcnt  = nv_batcnt .      /* bchcnt     */

    ASSIGN
        sic_bran.uwm130.uom6_v   = 0
        sic_bran.uwm130.uom7_v   = 0
        sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0     /*Item Upper text*/
        sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0     /*Item Lower Text*/
        sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0     /*Cover & Premium*/
        sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0     /*Item Endt. Text*/
        sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0.    /*Item Endt. Clause*/

    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE  sicsyac.xmm016.class =   sic_bran.uwm120.class
        NO-LOCK NO-ERROR.
    IF AVAIL sicsyac.xmm016 THEN 
        ASSIGN  
            sic_bran.uwm130.uom8_c = sicsyac.xmm016.uom8
            sic_bran.uwm130.uom9_c = sicsyac.xmm016.uom9 
/*             nv_comper     = DECI(sicsyac.xmm016.si_d_t[8])  */
/*             nv_comacc     = DECI(sicsyac.xmm016.si_d_t[9])  */
            nv_comper     = sicsyac.xmm016.si_d_t[8]   /* ---- suthida T. A52-0275 27-09-10 ------ */
            nv_comacc     = sicsyac.xmm016.si_d_t[9]   /* ---- suthida T. A52-0275 27-09-10 ------ */
             sic_bran.uwm130.uom8_v   = nv_comper   
            sic_bran.uwm130.uom9_v   = nv_comacc  .  

    ASSIGN
        nv_riskno = 1
        nv_itemno = 1.

    IF wdetail.covcod = "1" THEN 
        RUN wgs/wgschsum(INPUT  wdetail.policy,         /*a490166 Note modi*/
                                nv_riskno,
                                nv_itemno).
    END. /*transaction*/
    ASSIGN
      s_recid3  = RECID(sic_bran.uwm130)
      nv_covcod =   wdetail.covcod
      nv_makdes  =  wdetail.brand
      nv_moddes  =  wdetail.model
      nv_newsck = " ".

    IF SUBSTR(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
    ELSE nv_newsck = wdetail.stk.
END.
/* ---------------------------------------------  U W M 3 0 1 --------------*/ 
    FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
        sic_bran.uwm301.policy = sic_bran.uwm100.policy  AND
        sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt  AND
        sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt  AND
        sic_bran.uwm301.riskgp = s_riskgp                AND
        sic_bran.uwm301.riskno = s_riskno                AND
        sic_bran.uwm301.itemno = s_itemno                AND
        sic_bran.uwm301.bchyr  = nv_batchyr              AND 
        sic_bran.uwm301.bchno  = nv_batchno              AND 
        sic_bran.uwm301.bchcnt = nv_batcnt                     
        NO-WAIT NO-ERROR.
    IF NOT AVAILABLE sic_bran.uwm301 THEN DO:
        DO TRANSACTION:
            CREATE sic_bran.uwm301.
       

    ASSIGN            /*a490166 ใช้ร่วมกัน*/
        sic_bran.uwm301.policy   = sic_bran.uwm120.policy                   
        sic_bran.uwm301.rencnt   = sic_bran.uwm120.rencnt
        sic_bran.uwm301.endcnt   = sic_bran.uwm120.endcnt
        sic_bran.uwm301.riskgp   = sic_bran.uwm120.riskgp
        sic_bran.uwm301.riskno   = sic_bran.uwm120.riskno
        sic_bran.uwm301.itemno   = s_itemno
        sic_bran.uwm301.tariff   = wdetail.tariff
        sic_bran.uwm301.covcod   = nv_covcod
        sic_bran.uwm301.trareg   = TRIM(wdetail.chasno) /*A62-0435*/
        sic_bran.uwm301.cha_no   = wdetail.chasno
        sic_bran.uwm301.eng_no   = wdetail.eng
        sic_bran.uwm301.Tons     = INTEGER(wdetail.weight)
        sic_bran.uwm301.engine   = INTEGER(wdetail.engcc)
        sic_bran.uwm301.yrmanu   = INTEGER(wdetail.caryear)
        sic_bran.uwm301.garage   = wdetail.garage
        sic_bran.uwm301.body     = wdetail.body
/*         sic_bran.uwm301.seats    = INTEGER(wdetail.seat)  */ /* ----- suthida T. A52-0275 27-09-10 ---- */
        sic_bran.uwm301.seats    = wdetail.seat41 /* ----- suthida T. A52-0275 27-09-10 ---- */
        sic_bran.uwm301.mv_ben83 = wdetail.benname
        sic_bran.uwm301.vehreg   = wdetail.vehreg + nv_provi
        sic_bran.uwm301.yrmanu   = INTE(wdetail.caryear)
        sic_bran.uwm301.vehuse   = wdetail.vehuse
        sic_bran.uwm301.moddes   = wdetail.model     
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
            brStat.Detaitem.serailno   = wdetail.stk  AND 
            brstat.detaitem.yearReg    = nv_batchyr   AND
            brstat.detaitem.seqno      = STRING(nv_batchno)  AND
            brstat.detaitem.seqno2     = STRING(nv_batcnt)   NO-ERROR NO-WAIT.
        IF NOT AVAIL brstat.Detaitem THEN DO:   
            CREATE brstat.Detaitem.
            /*--STR Amparat C. A51-0253---*/
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
            /*--END Amparat C. A51-0253---*/
        END.
    END.
    ELSE sic_bran.uwm301.drinam[9] = "".
    s_recid4  = RECID(sic_bran.uwm301).

    /***--- modi by note a490166 ---***/
    IF wdetail.redbook <> "" THEN DO:   /*กรณีที่มีการระบุ Code รถมา*/
        FIND sicsyac.xmm102 USE-INDEX xmm10201 WHERE
            sicsyac.xmm102.modcod = wdetail.redbook NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102 THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod         = sicsyac.xmm102.modcod
                SUBSTRING(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                SUBSTRING(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/
                sic_bran.uwm301.Tons         = sicsyac.xmm102.tons
                sic_bran.uwm301.engine       = sicsyac.xmm102.engine
                sic_bran.uwm301.moddes       = sicsyac.xmm102.modest
                sic_bran.uwm301.seats        = sicsyac.xmm102.seats
                sic_bran.uwm301.vehgrp       = sicsyac.xmm102.vehgrp
                wdetail.weight               = STRING(sicsyac.xmm102.tons)
                wdetail.engcc                = STRING(sicsyac.xmm102.engine)
                wdetail.seat41                 = sicsyac.xmm102.seats
                wdetail.redbook              = sicsyac.xmm102.modcod
                wdetail.brand                = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                wdetail.model                = SUBSTRING(xmm102.modest,19,22).  /*Thai*/
        END.
    END. /*IF wdetail.redbook <> ""*/
    ELSE DO:
        FIND LAST sicsyac.xmm102 WHERE 
            sicsyac.xmm102.modest = wdetail.brand + wdetail.model AND
            sicsyac.xmm102.engine = INTE(wdetail.engcc)           AND 
            sicsyac.xmm102.tons   = INTE(wdetail.weight)          AND
            sicsyac.xmm102.seats  = INTE(wdetail.seat41)          NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm102  THEN DO:
            ASSIGN
                sic_bran.uwm301.modcod      = sicsyac.xmm102.modcod
                Substring(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                Substring(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/
                sic_bran.uwm301.Tons        = sicsyac.xmm102.tons
                sic_bran.uwm301.engine      = sicsyac.xmm102.engine
                sic_bran.uwm301.moddes      = sicsyac.xmm102.modest
                sic_bran.uwm301.seats       = sicsyac.xmm102.seats
                sic_bran.uwm301.vehgrp      = sicsyac.xmm102.vehgrp
                wdetail.weight              = STRING(sicsyac.xmm102.tons)  
                wdetail.engcc               = STRING(sicsyac.xmm102.engine)
                wdetail.seat41                = sicsyac.xmm102.seats
                wdetail.redbook             = sicsyac.xmm102.modcod
                wdetail.brand               = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                wdetail.model               = SUBSTRING(xmm102.modest,19,22).  /*Thai*/
        END.
        IF wdetail.redbook  = ""  THEN DO:
            FIND LAST sicsyac.xmm102 WHERE 
                sicsyac.xmm102.moddes  = wdetail.brand NO-LOCK NO-ERROR.
            IF AVAIL sicsyac.xmm102  THEN DO:
                ASSIGN
                    sic_bran.uwm301.modcod      = sicsyac.xmm102.modcod
                    Substring(sic_bran.uwm301.moddes,1,18)   = SUBSTRING(xmm102.modest, 1,18)  /*Thai language*/  
                    Substring(sic_bran.uwm301.moddes,19,22)  = SUBSTRING(xmm102.modest,19,22)  /*Thai Language*/
                    sic_bran.uwm301.Tons        = sicsyac.xmm102.tons
                    sic_bran.uwm301.engine      = sicsyac.xmm102.engine
                    sic_bran.uwm301.moddes      = sicsyac.xmm102.modest
                    sic_bran.uwm301.seats       = sicsyac.xmm102.seats
                    sic_bran.uwm301.vehgrp      = sicsyac.xmm102.vehgrp
                    wdetail.weight              = STRING(sicsyac.xmm102.tons)  
                    wdetail.engcc               = STRING(sicsyac.xmm102.engine)
                    wdetail.seat41              = sicsyac.xmm102.seats
                    wdetail.redbook             = sicsyac.xmm102.modcod
                    wdetail.brand               = SUBSTRING(xmm102.modest, 1,18)   /*Thai*/
                    wdetail.model               = SUBSTRING(xmm102.modest,19,22).  /*Thai*/
            END.
        END.
    END.      /* else IF wdetail.redbook <> ""*/
        END.  /*transaction*/
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_723 C-Win 
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
ASSIGN nv_rec100 = s_recid1
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
        FIND sicsyac.xmd107  WHERE RECID(sicsyac.xmd107) = sicsyac.xmm107.fptr NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmd107 THEN DO:
            CREATE sic_bran.uwd132.
            FIND sicsyac.xmm016 USE-INDEX xmm01601    WHERE
                sicsyac.xmm016.class = wdetail.class  NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm016 THEN  
                ASSIGN sic_bran.uwd132.gap_ae = NO
                sic_bran.uwd132.pd_aep = "E".
            ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod   sic_bran.uwd132.policy = wdetail.policy
                sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt     sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp     sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                sic_bran.uwd132.bptr   = 0
                sic_bran.uwd132.fptr   = 0          
                nvffptr     = xmd107.fptr
                s_130bp1    = RECID(sic_bran.uwd132)
                s_130fp1    = RECID(sic_bran.uwd132)
                n_rd132     = RECID(sic_bran.uwd132)
                sic_bran.uwd132.bchyr   = nv_batchyr         /* batch Year */      
                sic_bran.uwd132.bchno   = nv_batchno         /* bchno    */      
                sic_bran.uwd132.bchcnt  = nv_batcnt .        /* bchcnt     */      
            FIND sicsyac.xmm105 USE-INDEX xmm10501       WHERE
                sicsyac.xmm105.tariff = wdetail.tariff   AND
                sicsyac.xmm105.bencod = sicsyac.xmd107.bencod NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
            ELSE MESSAGE "ไม่พบ Tariff  " wdetail.tariff   VIEW-AS ALERT-BOX.
            IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* -----suthida T. A52-0275 INTE() deci()------*/
                IF                wdetail.class      = "110" THEN nv_key_a = DECI(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = DECI(wdetail.seat41).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = DECI(wdetail.engcc).
                ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = DECI(wdetail.weight).
                nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601  WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND 
                    sicsyac.xmm106.bencod  = uwd132.bencod    AND 
                    sicsyac.xmm106.class   = wdetail.class    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND 
                    sicsyac.xmm106.key_a  >= nv_key_a         AND 
                    sicsyac.xmm106.key_b  >= nv_key_b         AND 
                    sicsyac.xmm106.effdat <= uwm100.comdat    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap.
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap.
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
                END.
                ELSE nv_message = "NOTFOUND".
            END.   /* IF wdetail.tariff = "Z" OR wdetail.tariff = "X" */
            ELSE DO:
                FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff   AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class AND
                    sicsyac.xmm106.covcod  = wdetail.covcod   AND
                    sicsyac.xmm106.key_a  >= 0                AND
                    sicsyac.xmm106.key_b  >= 0                AND
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
                FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                    sicsyac.xmm106.tariff  = wdetail.tariff      AND
                    sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                    sicsyac.xmm106.class   = wdetail.class    AND 
                    sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                    sicsyac.xmm106.key_a   = 0                   AND 
                    sicsyac.xmm106.key_b   = 0                   AND 
                    sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT. 
                IF AVAILABLE sicsyac.xmm106 THEN DO:
                    sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
                    RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
                                        RECID(sic_bran.uwd132),
                                        sic_bran.uwm301.tariff).
                    nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
                    nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
                END.
            END.  /* else IF wdetail.tariff = "Z" OR wdetail.tariff = "X"*/
            loop_def:
            REPEAT:
                IF nvffptr EQ 0 THEN LEAVE loop_def.
                FIND sicsyac.xmd107 WHERE RECID(sicsyac.xmd107) EQ nvffptr  NO-LOCK NO-ERROR NO-WAIT.
                nvffptr   = sicsyac.xmd107.fptr. 
                CREATE sic_bran.uwd132.
                ASSIGN sic_bran.uwd132.bencod = sicsyac.xmd107.bencod sic_bran.uwd132.policy = wdetail.policy
                    sic_bran.uwd132.rencnt = sic_bran.uwm130.rencnt   sic_bran.uwd132.endcnt = sic_bran.uwm130.endcnt
                    sic_bran.uwd132.riskgp = sic_bran.uwm130.riskgp   sic_bran.uwd132.riskno = sic_bran.uwm130.riskno
                    sic_bran.uwd132.itemno = sic_bran.uwm130.itemno
                    sic_bran.uwd132.fptr   = 0
               sic_bran.uwd132.bptr   = n_rd132
               sic_bran.uwd132.bchyr = nv_batchyr         /* batch Year */      
               sic_bran.uwd132.bchno = nv_batchno         /* bchno    */      
               sic_bran.uwd132.bchcnt  = nv_batcnt          /* bchcnt     */      
               n_rd132                 = RECID(sic_bran.uwd132). 
        FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE
             sicsyac.xmm016.class = wdetail.class NO-LOCK NO-ERROR.
        IF AVAIL sicsyac.xmm016 THEN DO:
          sic_bran.uwd132.gap_ae = NO.
          sic_bran.uwd132.pd_aep = "E".
        END.
        FIND sicsyac.xmm105 USE-INDEX xmm10501      WHERE
             sicsyac.xmm105.tariff = wdetail.tariff  AND
             sicsyac.xmm105.bencod = sicsyac.xmd107.bencod NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicsyac.xmm105 THEN sic_bran.uwd132.benvar = sicsyac.xmm105.vardef.
        ELSE  MESSAGE "ไม่พบ Tariff นี้ในระบบ กรุณาใส่ Tariff ใหม่" 
                      "Tariff" wdetail.tariff "Bencod"  xmd107.bencod VIEW-AS ALERT-BOX.

      IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:
         /* -----suthida T. A52-0275 INTE() deci()------*/
             IF           wdetail.class      = "110" THEN nv_key_a = DECI(wdetail.engcc).
        ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = DECI(wdetail.seat41).
        ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = DECI(wdetail.engcc).
        ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = DECI(wdetail.weight).
          nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
          FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                     sicsyac.xmm106.tariff  = wdetail.tariff   AND
                     sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                     sicsyac.xmm106.class   = wdetail.class    AND
                     sicsyac.xmm106.covcod  = wdetail.covcod   AND
                     sicsyac.xmm106.key_a  >= nv_key_a        AND
                     sicsyac.xmm106.key_b  >= nv_key_b        AND
                     sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE sicsyac.xmm106 THEN DO:
              ASSIGN  sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap
                    sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap
                    nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c
                    nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
          END.
      END. /*IF wdetail.tariff = "Z" OR wdetail.tariff = "X" */
      ELSE DO:
          FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601               WHERE
                     sicsyac.xmm106.tariff  = wdetail.tariff         AND
                     sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND
                     sicsyac.xmm106.class   = wdetail.class         AND
                     sicsyac.xmm106.covcod  = wdetail.covcod         AND
                     sicsyac.xmm106.key_a  >= 0                      AND
                     sicsyac.xmm106.key_b  >= 0                      AND
                     sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
          FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601               WHERE
                     sicsyac.xmm106.tariff  = wdetail.tariff         AND
                     sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND
                     sicsyac.xmm106.class   = wdetail.class          AND
                     sicsyac.xmm106.covcod  = wdetail.covcod         AND
                     sicsyac.xmm106.key_a   = 0                      AND
                     sicsyac.xmm106.key_b   = 0                      AND
                     sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
          IF AVAILABLE xmm106 THEN DO:
            sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
            RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
                                      RECID(sic_bran.uwd132),
                                      sic_bran.uwm301.tariff).
            nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
            nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
          END.
        END.   /* uwm301.tariff = "Z" */
        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ s_130bp1 NO-WAIT NO-ERROR.
        sic_bran.uwd132.fptr   = n_rd132.
        FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) EQ n_rd132 NO-WAIT NO-ERROR.
        s_130bp1      = RECID(sic_bran.uwd132).
        NEXT loop_def.
      END. /*IF wdetail.tariff = "Z" OR wdetail.tariff = "X"*/
     END.
  END.
  ELSE DO:    /*  Not Avail xmm107 */
    s_130fp1 = 0.
    s_130bp1 = 0.
    MESSAGE "ไม่พบ Class " wdetail.class " ใน Tariff  " wdetail.tariff  skip
                        "กรุณาใส่ Class หรือ Tariff ใหม่อีกครั้ง" VIEW-AS ALERT-BOX.
  END.
  ASSIGN sic_bran.uwm130.fptr03 = s_130fp1
         sic_bran.uwm130.bptr03 = s_130bp1.
END.
ELSE DO:                              /* uwm130.fptr03 <> 0 OR uwm130.fptr03 <> ? */
  s_130fp1 = sic_bran.uwm130.fptr03.
  DO WHILE s_130fp1 <> ? AND s_130fp1 <> 0:
    FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = s_130fp1 NO-ERROR NO-WAIT.
    IF AVAILABLE sic_bran.uwd132 THEN DO:
      s_130fp1 = sic_bran.uwd132.fptr.                          
      IF wdetail.tariff = "Z" OR wdetail.tariff = "X" THEN DO:  /* -----suthida T. A52-0275 INTE() deci()------*/
             IF           wdetail.class      = "110" THEN nv_key_a = DECI(wdetail.engcc).
        ELSE IF SUBSTRING(wdetail.class,1,3) = "120" THEN nv_key_a = DECI(wdetail.seat41).
        ELSE IF SUBSTRING(wdetail.class,1,3) = "130" THEN nv_key_a = DECI(wdetail.engcc).
        ELSE IF SUBSTRING(wdetail.class,1,3) = "140" THEN nv_key_a = DECI(wdetail.weight).
        nv_key_b = (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat) + 1.
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601               WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff         AND
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod AND
                   sicsyac.xmm106.class   = wdetail.class        AND
                   sicsyac.xmm106.covcod  = wdetail.covcod         AND
                   sicsyac.xmm106.key_a  >= nv_key_a               AND 
                   sicsyac.xmm106.key_b  >= nv_key_b               AND 
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE xmm106 THEN DO:
          sic_bran.uwd132.gap_c  = sicsyac.xmm106.baseap.
          sic_bran.uwd132.prem_c = sicsyac.xmm106.baseap.
          nv_gap                 = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem                = nv_prem + sic_bran.uwd132.prem_c.
        END.
        ELSE nv_message = "NOTFOUND".
      END.
      ELSE DO:
        FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601            WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff      AND 
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod       AND 
                   sicsyac.xmm106.class   = wdetail.class    AND 
                   sicsyac.xmm106.covcod  = wdetail.covcod      AND 
                   sicsyac.xmm106.key_a  >= 0                   AND 
                   sicsyac.xmm106.key_b  >= 0                   AND 
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
        FIND LAST  sicsyac.xmm106 USE-INDEX xmm10601        WHERE
                   sicsyac.xmm106.tariff  = wdetail.tariff   AND
                   sicsyac.xmm106.bencod  = sic_bran.uwd132.bencod   AND
                   sicsyac.xmm106.class   = wdetail.class    AND
                   sicsyac.xmm106.covcod  = wdetail.covcod   AND
                   sicsyac.xmm106.key_a   = 0               AND
                   sicsyac.xmm106.key_b   = 0               AND
                   sicsyac.xmm106.effdat <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR NO-WAIT.
        IF AVAILABLE sicsyac.xmm106 THEN DO:
          sic_bran.uwd132.gap_c     = sicsyac.xmm106.baseap.
          RUN wgw/wgw72013   (INPUT RECID(sic_bran.uwm100), /*a490166 note modi*/
                                    RECID(sic_bran.uwd132),
                                    sic_bran.uwm301.tariff).
          nv_gap        = nv_gap  + sic_bran.uwd132.gap_c.
          nv_prem       = nv_prem + sic_bran.uwd132.prem_c.
        END.
      END.
    END.
  END.
END.                                            /* End.  uwm130.fptr03 <> 0 OR uwm130.fptr03 <> ? */
nv_stm_per = 0.4.
nv_tax_per = 7.0.
FIND sicsyac.xmm020 USE-INDEX xmm02001     WHERE
     sicsyac.xmm020.branch = sic_bran.uwm100.branch AND
     sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri NO-LOCK NO-ERROR.
IF AVAIL sicsyac.xmm020 THEN ASSIGN nv_stm_per             = sicsyac.xmm020.rvstam
                                    nv_tax_per             = sicsyac.xmm020.rvtax
                                    sic_bran.uwm100.gstrat = sicsyac.xmm020.rvtax.
ELSE sic_bran.uwm100.gstrat = nv_tax_per.
ASSIGN
nv_gap2  = 0
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
         /*a490166*/                                             
         sic_bran.uwm120.bchyr = nv_batchyr            AND 
         sic_bran.uwm120.bchno = nv_batchno            AND 
         sic_bran.uwm120.bchcnt  = nv_batcnt             :
nv_gap  = 0.
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
      FIND sic_bran.uwd132 WHERE RECID(sic_bran.uwd132) = nv_fptr NO-LOCK NO-ERROR NO-WAIT.
      IF NOT AVAILABLE sic_bran.uwd132 THEN LEAVE.
         nv_fptr = sic_bran.uwd132.fptr.
         nv_gap  = nv_gap  + sic_bran.uwd132.gap_c.
         nv_prem = nv_prem + sic_bran.uwd132.prem_c.
    END. 
  END.
  sic_bran.uwm120.gap_r  =  nv_gap.
  sic_bran.uwm120.prem_r =  nv_prem.
  sic_bran.uwm120.rstp_r  =  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) +
                        (IF  TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 2) -
                             TRUNCATE(sic_bran.uwm120.prem_r * nv_stm_per / 100, 0) > 0
                        THEN 1 ELSE 0).
sic_bran.uwm120.rtax_r = ROUND((sic_bran.uwm120.prem_r + sic_bran.uwm120.rstp_r)  * nv_tax_per  / 100 ,2).
nv_gap2  = nv_gap2  + nv_gap.
  nv_prem2 = nv_prem2 + nv_prem.
  nv_rstp  = nv_rstp  + sic_bran.uwm120.rstp_r.
  nv_rtax  = nv_rtax  + sic_bran.uwm120.rtax_r.
IF sic_bran.uwm120.com1ae = NO THEN nv_com1_per = sic_bran.uwm120.com1p.
  IF nv_com1_per <> 0 THEN DO:
    sic_bran.uwm120.com1ae =  NO.
    sic_bran.uwm120.com1p  =  nv_com1_per.
    sic_bran.uwm120.com1_r =  (sic_bran.uwm120.prem_r * sic_bran.uwm120.com1p / 100) * 1-.
    nv_com1_prm = nv_com1_prm + sic_bran.uwm120.com1_r.
  END.
  ELSE DO:
    IF nv_com1_per   = 0  AND sic_bran.uwm120.com1ae = NO THEN DO:
      ASSIGN  sic_bran.uwm120.com1p  =  0
      sic_bran.uwm120.com1_r =  0
      sic_bran.uwm120.com1_r =  0
      nv_com1_prm            =  0.
    END.
END.
END.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = nv_rec130 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = nv_rec120 NO-WAIT NO-ERROR.
   ASSIGN sic_bran.uwm100.gap_p  =  nv_gap2
   sic_bran.uwm100.prem_t =  nv_prem2
   sic_bran.uwm100.rstp_t =  nv_rstp
   sic_bran.uwm100.rtax_t =  nv_rtax
   sic_bran.uwm100.com1_t =  nv_com1_prm.
/*RUN proc_chktest4.*/
   RUN proc_uwm120.
   END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_adduwd132prem C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign C-Win 
PROCEDURE proc_assign :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER bfwdetail FOR wdetail . /*a62-0435*/
DEFINE VAR nv_policy AS CHAR FORMAT "X(20)".
DEFINE VAR nv_len    AS INTE INIT 0.
DEF    VAR b_eng     AS DECI FORMAT  ">>>>9.99-".
DEF    VAR n_date    AS CHAR FORMAT  "x(10)".
DEF    VAR n_count   AS INTE INIT 0.
DEF    VAR n_body    AS CHAR FORMAT "x(30)".
FOR EACH wacctext.
    DELETE wacctext.
END.
    fi_process             = " Proc assign"   .
DISP fi_process    WITH FRAME fr_main.
ASSIGN n_count   = 0
  nv_len    = 0              /* ---- suthida T. A52-0275 27-09-10 ----- */
  b_eng     = 0              /* ---- suthida T. A52-0275 27-09-10 ----- */
  n_date    = ?              /* ---- suthida T. A52-0275 27-09-10 ----- */
  nv_policy =  " " 
  /*nv_policy = TRIM(SUBSTR(E2CV_poltyp,2,2)) + trim(SUBSTR(Eapplino,3,12)).  /*A58-0372*/*/ /*A62-0435*/
  nv_policy = TRIM(SUBSTR(E2CV_poltyp,2,2)) + trim(SUBSTR(Eapplino,3,LENGTH(Eapplino))).  /*A62-0435*/
   /* nv_policy = trim(E2text14) .   ------ A58-0372 ------*/
/*MESSAGE "1" TRIM(nv_policy)  trim(Eapplino)  VIEW-AS ALERT-BOX.*/
IF nv_policy <> "" THEN DO:
  loop_chk1:
  REPEAT:
    IF INDEX(nv_policy,"-") <> 0 THEN DO:
      nv_len    = LENGTH(nv_policy).
      nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"-") - 1) + SUBSTRING(nv_policy,INDEX(nv_policy,"-") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk1.
  END.
  loop_chk2:
  REPEAT:
    IF INDEX(nv_policy,"/") <> 0 THEN DO:
      nv_len    = LENGTH(nv_policy).
      nv_policy = SUBSTRING(nv_policy,1,INDEX(nv_policy,"/") - 1) + SUBSTRING(nv_policy,INDEX(nv_policy,"/") + 1, nv_len ) .
    END.
    ELSE LEAVE loop_chk2.
  END.
END.
ELSE IF TRIM(E2instype) = "T" THEN do:
  IF trim(Eapplino) <> "" THEN 
    ASSIGN nv_policy = IF      substr(trim(Eapplino),1,2) = "NB" THEN TRIM(E2instype) + substr(trim(Eapplino),3)    /*Policy V72 */
                       ELSE IF substr(trim(Eapplino),1,2) = "RW" THEN TRIM(E2instype) + substr(trim(Eapplino),3)
                       ELSE TRIM(E2instype) + trim(Eapplino).
END.
ELSE ASSIGN nv_policy = IF      substr(trim(Eapplino),1,2) = "NB" THEN TRIM(E2instype) + substr(trim(Eapplino),3)    /*Policy V72 */
                        ELSE IF substr(trim(Eapplino),1,2) = "RW" THEN TRIM(E2instype) + substr(trim(Eapplino),3)
                        ELSE TRIM(E2instype) + trim(Eapplino).
loop_chk3:
REPEAT:
  IF INDEX(E2CVMI,".") <> 0 THEN DO:
    nv_len = LENGTH(E2CVMI).
    E2CVMI = SUBSTRING(E2CVMI,1,INDEX(E2CVMI,".") - 1) + SUBSTRING(E2CVMI,INDEX(E2CVMI,".") + 1, nv_len ) .
  END.
  ELSE LEAVE loop_chk3.
END.
ASSIGN nv_count    = nv_count + 1 .
IF nv_count = 1 THEN 
  ASSIGN nv_datwork = ""
  nv_uswork  = ""
  nv_datwork =  trim(E2text14)
  nv_uswork  =  trim(E2oldpol).
/*IF nv_count = 1 THEN NEXT.*/
IF E2brach  = "สาขา" OR E2brach  = " " THEN NEXT.
IF E2poltype = "ENDORSE"               THEN NEXT.
ASSIGN n_count = 0.
loop_chkadd1:
REPEAT:
  IF length(trim(EAddress1)) > 35 THEN DO:
    IF (LENGTH(trim(SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," ")) + " " + trim(EAddress2)))) > 35   THEN DO:
      IF n_count = 0 THEN DO:
        ASSIGN EAddress3 =  trim(EAddress2) + " " + trim(EAddress3)
               EAddress2 =  trim(SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," ")))    
               EAddress1 =  trim(SUBSTR(trim(EAddress1),1,r-INDEX(trim(EAddress1)," "))). 
      END.
      ELSE DO:
        IF  LENGTH(SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," ")) + " " + trim(EAddress2)) <= 35 THEN
            ASSIGN EAddress2 =  SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," "))   + " " + trim(EAddress2)
                   EAddress1 =  trim(SUBSTR(trim(EAddress1),1,r-INDEX(trim(EAddress1)," "))).
        ELSE 
            ASSIGN EAddress3 =  substr(trim(EAddress2),R-INDEX(trim(EAddress2)," ")) + " " + trim(EAddress3)
                   EAddress2 =  trim(SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," "))) + " " + substr(trim(EAddress2),1,R-INDEX(trim(EAddress2)," "))    
                   EAddress1 =  trim(SUBSTR(trim(EAddress1),1,r-INDEX(trim(EAddress1)," "))). 
      END.
    END.
    ELSE DO:
      IF  LENGTH(SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," ")) + " " + trim(EAddress2)) <= 35 THEN
        ASSIGN  EAddress2 =  SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," "))   + " " + trim(EAddress2)
                EAddress1 =  trim(SUBSTR(trim(EAddress1),1,r-INDEX(trim(EAddress1)," "))).
      ELSE 
          ASSIGN EAddress3 =  substr(trim(EAddress2),R-INDEX(trim(EAddress2)," ")) + " " + trim(EAddress3)
                 EAddress2 =  trim(SUBSTR(trim(EAddress1),r-INDEX(trim(EAddress1)," "))) + " " + substr(trim(EAddress2),1,R-INDEX(trim(EAddress2)," "))    
                 EAddress1 =  trim(SUBSTR(trim(EAddress1),1,r-INDEX(trim(EAddress1)," "))). 
    END.
    ASSIGN n_count   =  n_count + 1.
  END.
  ELSE LEAVE loop_chkadd1.
END.
/*----- A59-0029-----------*/
ASSIGN n_body = "" .
IF trim(E2make) <> "" AND trim(E2model) <> "" THEN DO:
  FIND FIRST stat.maktab_fi WHERE stat.maktab_fil.makdes   =     trim(E2make)   AND                  
    INDEX(stat.maktab_fil.moddes,SUBSTRING(trim(E2model),1,INDEX(trim(E2model)," "))) <> 0 OR
    INDEX(stat.maktab_fil.moddes,SUBSTRING(trim(E2model),1,10)) <> 0 NO-LOCK NO-ERROR NO-WAIT.
  IF  AVAIL stat.maktab_fil  THEN ASSIGN n_body    =  stat.maktab_fil.body.
  ELSE ASSIGN n_body    =  "".
END.
/*----- A59-0029-----------*/
/*IF E2poltype = "RENEW"        THEN NEXT.*//* ---- suthida T. A54-0010 09-02-11 -----  */
FIND LAST wdetail WHERE wdetail.policy = TRIM(nv_policy) NO-ERROR .
IF NOT AVAIL wdetail  THEN DO:
  CREATE wdetail.
  ASSIGN  
    wdetail.policy      = TRIM(nv_policy)
    wdetail.applino     = trim(Eapplino)
    wdetail.recnt       = 0 
    wdetail.endcnt      = 0 
    wdetail.Insd        = " "
    wdetail.ntitle      = trim(ENnam)
    wdetail.name1       = trim(THnam)
    wdetail.occoup      = trim(E2occup)    /*A57-0244*/
    wdetail.idno        = trim(E2idno)     /*A57-0244*/  
    wdetail.addrss1     = trim(EAddress1) 
    wdetail.addrss2     = trim(EAddress2) 
    wdetail.addrss3     = trim(EAddress3) 
    wdetail.addrss4     = trim(EAddress4) 
    wdetail.billac      = " "
    wdetail.comdat      = DATE(Eeffecdat)
    wdetail.expdat      = DATE(Eexpirdat) 
    wdetail.trandat     = TODAY 
    wdetail.premt       = deci(Enetprm)
    wdetail.seat        = inte(TRIM(E2seat))
    wdetail.class       = trim(E2CVMI)
    wdetail.si          = deci(Esumins)
    wdetail.access      = E2access
    wdetail.accessd     = trim(E2aecsdes)
    wdetail.covcod      = trim(E2instype)
    /*wdetail.garage      = trim(E2Garage)*/                                     /* A57-0244 */
    wdetail.garage      = IF substr(trim(E2textco),39,1) = "1" THEN "G" ELSE ""  /* A57-0244 */
    wdetail.brand       = trim(E2make)
    wdetail.model       = trim(E2model)
    wdetail.chasno      = trim(E2chassis)
    /* wdetail.stk         = E2sticker */ /* ---- suthida T. A52-0275 27-09-10 ------ */
    wdetail.stk         = TRIM(E2sticker) /* ---- suthida T. A52-0275 27-09-10 ------ */
    wdetail.engcc       = trim(E2cc)
    wdetail.caryear     = trim(E2YEAR)
    wdetail.body        = n_body   /* เช่น PICKUP */  /*A59-0029*/
    /*wdetail.benname     = ""   /* ชื่อผู้รับผลประโยชน์*/     A59-0182*/
    wdetail.benname     = IF TRIM(E2CV_poltyp) = "V70" THEN trim(benefic)  ELSE ""   /*A59-0182*/
    wdetail.vehuse      = IF substr(trim(E2CVMI),2,3) = "320" THEN "2" ELSE "1"  /*รหัสลักษณะการใช้งานรถ เช่น ส่วนบุคคล*/
    wdetail.drivername1 = trim(E2drinam1)
    wdetail.age1        = INT(E2driage1)
    wdetail.dbirth1     = IF E2dribht1 <> "" THEN SUBSTRING(E2dribht1,1,6) + STRING(INT(SUBSTRING(E2dribht1,7,LENGTH(E2dribht1))) + 543)  /*วันเดือนปีเกิดผู้ขับขี่เป็น พ.ศ ความยาวของข้อความ = 10 */
                          ELSE ""
    wdetail.drivername2 = trim(E2drinam2)
    wdetail.age2        = INT(E2driage2)
    wdetail.dbirth2     = IF E2dribht2 <> "" THEN SUBSTRING(E2dribht2,1,6) + STRING(INT(SUBSTRING(E2dribht2,7,LENGTH(E2dribht2))) + 543) /*วันเดือนปีเกิดผู้ขับขี่เป็น พ.ศ ความยาวของข้อความ = 10 */
                          ELSE ""
    wdetail.weight      = trim(E2tonnage)
    wdetail.eng         = trim(E2engine) 
    wdetail.prepol      = trim(E2oldpol)
    wdetail.comment     = ""
    wdetail.uom1_v      = deci(trim(E2CV_perbi))   /*a57-0244*/
    wdetail.uom2_v      = deci(trim(E2CV_perac))   /*a57-0244*/
    wdetail.uom5_v      = deci(trim(E2CV_perpd))   /*a57-0244*/
    WDETAIL.no_41       = deci(trim(E2CV_41))      /*a57-0244*/   
    WDETAIL.no_42       = deci(trim(E2CV_42))      /*a57-0244*/
    WDETAIL.no_43       = deci(trim(E2CV_43))      /*a57-0244*/
    wdetail.agent       = trim(fi_agent)
    wdetail.vatcode     = TRIM(E2CV_vatcode)       /*A57-0244*/
    /* Comment by A59-0182.....
    wdetail.producer    = /*IF       index(E2textco,"12_NN") <> 0 THEN fi_producer_12nn  /*A58-0184 motorcycle */*/      /*A59-0029*/
              IF (wdetail.body = "MOTORCYCLE") OR index(E2textco,"12_NN") <> 0 THEN fi_producer_12nn         /*A59-0029*/
              /*ELSE IF  SUBSTR(TRIM(Eapplino),1,2) = "RW" THEN fi_producer  /*A58-0184 renew producer */*/  /*A59-0029*/
              ELSE IF  SUBSTR(TRIM(Eapplino),1,2) = "RW" AND wdetail.body <> "MOTORCYCLE" THEN fi_producer   /*A59-0029*/  
              ELSE if  index(E2textco,"_NU")   <> 0 THEN fi_producer_nu
              ELSE if  index(E2textco,"08_NN") <> 0 THEN fi_producer_08nn
              ELSE if (index(E2textco,"_NN")   <> 0) AND 
                      (INDEX(trim(E2make),"BENZ") <> 0 ) THEN fi_producer_benz
              ELSE if (index(E2textco,"_NN")  <> 0)      THEN fi_producer_nn
              ELSE  fi_producer
    .......end A59-0182...........*/                       
    wdetail.entdat      = STRING(TODAY)                /*entry date*/
    wdetail.enttim      = STRING (TIME, "HH:MM:SS")    /*entry time*/
    wdetail.trandat     = fi_loaddat                   /*tran date*/
    wdetail.trantim     = STRING (TIME, "HH:MM:SS")    /*tran time*/
    wdetail.nmember     = trim(E2text18)
    /*wdetail.uswork      = trim(nv_uswork)  */ /*A59-0182*/  
    /*wdetail.datwork     = trim(nv_datwork) */ /*A59-0182*/ 
    wdetail.uswork      = IF trim(E2poltype) = "RENEW" THEN trim(E2oldpol) ELSE trim(nv_uswork)      
    wdetail.datwork     = IF trim(E2poltype) = "RENEW" THEN trim(E2text14) ELSE trim(nv_datwork)                                      
    /*wdetail.poltyp      = IF trim(E2instype) = "1" THEN "V70" ELSE "V72"*/
    wdetail.poltyp      = trim(E2CV_poltyp)    /*Add kridtiya poltype   A57-0244 */
    wdetail.Tel         = trim(Etel) 
    wdetail.branch      = IF E2brach = " " THEN  "M" ELSE trim(E2brach)
    wdetail.ispno       = trim(E2CV_ispno)      /*A59-0029*/  
    wdetail.camp        = trim(E2CV_campaign)   /*A59-0182*/  
    wdetail.w_type      = trim(E2poltype)       /*A59-0029*/ 
    wdetail.payment     = TRIM(n_payment)       /*A59-0182*/
    wdetail.promo       = TRIM(n_promo)              /*A59-0182*/
    wdetail.insnamtyp   = n_insnamtyp
    wdetail.firstName   = n_firstName
    wdetail.lastName    = n_lastName
    wdetail.postcd      = trim(n_postcd)
    /*wdetail.icno      = trim(sicsyac.xmm600.icno)*/
    wdetail.codeocc     = n_codeocc           /*Add by Kridtiya i. A63-0472*/
    wdetail.codeaddr1   = n_codeaddr1         /*Add by Kridtiya i. A63-0472*/
    wdetail.codeaddr2   = n_codeaddr2         /*Add by Kridtiya i. A63-0472*/
    wdetail.codeaddr3   = n_codeaddr3         /*Add by Kridtiya i. A63-0472*/
    /*wdetail.br_insured  = "00000" */        /*Add by Kridtiya i. A63-0472*/
    wdetail.ncolor      =   nv_color .        /*A66-0108 */
    /*--A59-0182---*/
  IF wdetail.w_type = "Renew" THEN 
    ASSIGN wdetail.producer = n_producer
      wdetail.agent    = n_agent.
  ELSE DO:
    IF n_agent    <> "" THEN ASSIGN wdetail.agent    = n_agent    . /*A61-0269*/
    IF n_producer <> "" THEN ASSIGN wdetail.producer = n_producer . /*A61-0269*/
    ELSE  ASSIGN wdetail.producer    = IF index(E2textco,"12_NN") <> 0 THEN fi_producer_12nn     
        /* ELSE if  index(E2textco,"_NU")   <> 0 THEN fi_producer_nu   */    /*A61-0269*/
        /* ELSE if  index(E2textco,"08_NN") <> 0 THEN fi_producer_08nn */    /*A61-0269*/
                                       ELSE if (index(E2textco,"_NN")   <> 0) AND (INDEX(trim(E2make),"BENZ") <> 0 ) THEN fi_producer_benz
                                       ELSE if (index(E2textco,"_NN")  <> 0) AND trim(E2YEAR) = STRING(YEAR(TODAY),"9999") THEN fi_producer_nn
                                       ELSE  fi_producer .
  END.
  /*---end A59-0182---*/
  IF wdetail.policy = " " THEN  DO:  /*หาเลขกรมธรรม์ 72 และ งานต่ออายุ*/
    IF   E2oldpol    <> " " THEN wdetail.policy = "RW" + E2oldpol. /*หาเลขกรมธรรม์งานต่ออายุRW + กรมธรรม์เบอร์เดิม*/
    IF   wdetail.stk <> " " OR wdetail.covcod = "T" THEN  /*หาเลขกรมธรรม์ 72 ที่ความคุ้มครองเป็น T */
      ASSIGN  wdetail.policy = wdetail.applino.  /* 72 */
  END.
  /*----- garage : A59-0029 ----*/
  IF trim(E2poltype) = "Renew" AND wdetail.poltyp = "V70" THEN ASSIGN wdetail.garage = TRIM(E2Garage).
  /*----- A59-0029 ----*/ 
  /*ELSE  wdetail.policy = TRIM(nv_policy) .  /* ---- suthida T. A54-0010 09-03-11------ */ /* 70 */*/
  IF    wdetail.premt  = 0 THEN wdetail.premt = deci(E2prmp) .  /*premuim 72 */
  ELSE  wdetail.premt  = deci(Enetprm). /*premuim 70 */
  IF    E22lisen   = " "  THEN wdetail.vehreg = "/" + SUBSTRING(wdetail.chasno,LENGTH(wdetail.chasno) -  8,LENGTH(wdetail.chasno)).  /*ป้านแดง*/
  ELSE  wdetail.vehreg = trim(E22lisen)  .    /*ทะเบียนรถ*/
  IF    (wdetail.poltyp = "V72" ) OR (wdetail.poltyp = "V74")  THEN  wdetail.compul = "Y".
  ELSE  wdetail.compul = "N".
  IF    E2text16 = ""  THEN wdetail.name2 = "". 
    /*ELSE wdetail.name2 = "และ/หรือ" + E2text16. /*ชื่อที่ใช้ในการออกใบกำกับภาษี*/*/ /* ---- suthida T. A54-0010 20-01-11 ----- */
  ELSE wdetail.name2 = "และ/หรือ" + " " + E2text16.  /*ชื่อที่ใช้ในการออกใบกำกับภาษี*/ /* ---- suthida T. A54-0010 20-01-11 ----- */
  ASSIGN n_date = STRING(TODAY,"99/99/9999")
    b_eng  = ROUND((DECI(wdetail.engcc) / 1000),1)     /*format engcc */
    b_eng  = b_eng * 1000
    wdetail.engcc    = IF b_eng > 999 THEN STRING(b_eng) ELSE TRIM(wdetail.engcc)
    wdetail.tariff   = IF  (wdetail.poltyp = "V72" ) OR (wdetail.poltyp = "V74") THEN "9" ELSE "x" 
        /*wdetail.garage   = IF wdetail.poltyp = "V70" THEN "G" ELSE " "*/   .
    /* Comment by A59-0182...............
    IF (trim(E2CV_ispno) <> "" ) OR (trim(E2CV_campaign) <> "" ) THEN DO:  
        FIND LAST wacctext WHERE wacctext.n_policytxt = wdetail.policy NO-ERROR .
        IF NOT AVAIL wacctext  THEN DO:
            CREATE wacctext.
            ASSIGN 
                wacctext.n_policytxt = TRIM(nv_policy)
                wacctext.n_textacc1  = trim(E2CV_ispno)   
                wacctext.n_textacc2  = trim(E2CV_campaign).
        END.
    END.
    ...end A59-0182.....*/
    /* Create by A59-0182 */ 
  IF n_payment = "Unpaid" THEN DO:
      IF INDEX(n_track,"PMIB") <> 0 THEN ASSIGN wdetail.track  = "ยังไม่ชำระเบี้ยประกัน/ส่งกธ.+พรบ.กลับมาที่ PMIB ".
      IF TRIM(n_track) = "" THEN ASSIGN wdetail.track  = "ยังไม่ชำระเบี้ยประกัน/ส่งกธ.+พรบ.ลูกค้าตามที่อยู่". 
  END.
  ELSE IF n_payment = "Paid" THEN DO:
      IF INDEX(n_track,"PMIB") <> 0 THEN ASSIGN wdetail.track  = "ชำระเบี้ยประกันแล้ว/ส่งกธ.+พรบ.กลับมาที่ PMIB".
      IF INDEX(n_track,"ลูกค้า") <> 0 THEN ASSIGN wdetail.track  = "ชำระเบี้ยประกันแล้ว/ส่งกธ.+พรบ.ลูกค้าตามที่อยู่".
      IF TRIM(n_track) = "" THEN ASSIGN wdetail.track  = "ชำระเบี้ยประกันแล้ว/ส่งกธ.+พรบ.ลูกค้าตามที่อยู่". 
  END.
  ELSE ASSIGN wdetail.track  = TRIM(n_track).
  IF trim(E2poltype) = "new" THEN ASSIGN wdetail.track  = trim(n_track).

  /* end A59-0182 */
  IF wdetail.poltyp = "V70" AND DATE(wdetail.comdat) >= 04/01/2020 THEN ASSIGN wdetail.CLASS = "T" + SUBSTR(wdetail.CLASS,2,3) . /*a63-0162*/
  IF wdetail.camp <> ""  THEN DO:
    IF  wdetail.brand <> "ISUZU" THEN DO:
      FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
        /*trim(brstat.Insure.compno)  = "KL-PACK"             AND */ /*a63-0162*/
        trim(brstat.Insure.compno)  = TRIM(fi_packnew)      AND 
        trim(brstat.insure.text1)   = trim(wdetail.garage)  AND
        trim(brstat.insure.Text3)   = TRIM(wdetail.CLASS)   AND 
        TRIM(brstat.insure.text4)   = trim(wdetail.camp)    AND  
        trim(brstat.insure.vatcode) = trim(wdetail.covcod)  NO-LOCK  NO-ERROR.
      IF AVAIL brstat.insure THEN  
        ASSIGN wdetail.uom1_v   = if wdetail.uom1_v <> 0 then DECI(brstat.insure.lName) else wdetail.uom1_v                      
          wdetail.uom2_v   = if wdetail.uom2_v <> 0 then deci(brstat.insure.Addr1) else wdetail.uom2_v                
          wdetail.uom5_v   = if wdetail.uom5_v <> 0 then DECI(brstat.insure.Addr2) else wdetail.uom5_v               
          WDETAIL.no_41    = if WDETAIL.no_41  <> 0 then DECI(brstat.insure.Addr3) else WDETAIL.no_41                
          WDETAIL.no_42    = if WDETAIL.no_42  <> 0 then DECI(brstat.insure.Addr4) else WDETAIL.no_42                
          WDETAIL.no_43    = if WDETAIL.no_43  <> 0 then DECI(brstat.insure.telno) else WDETAIL.no_43 .
    END.
    ELSE DO:
      FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
        /*trim(brstat.Insure.compno)  = "KL-PACK"             AND */ /*a63-0162*/
        trim(brstat.Insure.compno)  = TRIM(fi_packnew)      AND      /*a63-0162*/
        trim(brstat.insure.text1)   = trim(wdetail.garage)  AND
        INDEX(wdetail.model,brstat.insure.text2) <> 0       AND  
        trim(brstat.insure.Text3)   = TRIM(wdetail.CLASS)   AND 
        TRIM(brstat.insure.text4)   = trim(wdetail.camp)    AND 
        trim(brstat.insure.vatcode) = trim(wdetail.covcod)  NO-LOCK  NO-ERROR.
      IF AVAIL brstat.insure THEN  
        ASSIGN wdetail.uom1_v   = if wdetail.uom1_v <> 0 then DECI(brstat.insure.lName) else wdetail.uom1_v                      
          wdetail.uom2_v   = if wdetail.uom2_v <> 0 then deci(brstat.insure.Addr1) else wdetail.uom2_v                
          wdetail.uom5_v   = if wdetail.uom5_v <> 0 then DECI(brstat.insure.Addr2) else wdetail.uom5_v               
          WDETAIL.no_41    = if WDETAIL.no_41  <> 0 then DECI(brstat.insure.Addr3) else WDETAIL.no_41                
          WDETAIL.no_42    = if WDETAIL.no_42  <> 0 then DECI(brstat.insure.Addr4) else WDETAIL.no_42                
          WDETAIL.no_43    = if WDETAIL.no_43  <> 0 then DECI(brstat.insure.telno) else WDETAIL.no_43 .
      ELSE DO:
      END.
    END.
  END.
END.
RUN proc_clear3.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assign2addr C-Win 
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
fi_process             = " Proc add222"   .
DISP fi_process    WITH FRAME fr_main.
ASSIGN 
    n_postcd        = ""
    np_tambon       = replace(np_tambon,"ต.","")      
    np_mail_amper   = replace(np_mail_amper,"อ.","")   
    np_mail_country = replace(np_mail_country,"จ.","") 
    np_tambon       = replace(np_tambon,"ตำบล","")      
    np_mail_amper   = replace(np_mail_amper,"อำเภอ","")   
    np_mail_country = replace(np_mail_country,"จังหวัด","")
    np_tambon       = replace(np_tambon,"แขวง","")      
    np_mail_amper   = replace(np_mail_amper,"เขต","")   .
fi_process             = " Proc add333"   .
DISP fi_process    WITH FRAME fr_main.

IF R-INDEX(np_mail_country," ") <> 0 THEN
    ASSIGN 
    n_postcd        = trim(SUBSTR(np_mail_country,R-INDEX(np_mail_country," "))) 
    np_mail_country = trim(SUBSTR(np_mail_country,1,R-INDEX(np_mail_country," "))) .
/*     EAddress4       = trim(REPLACE(EAddress4,n_postcd,"")). */
/*      EAddress4       =  REPLACE(EAddress4,n_postcd,""). */
IF index(np_mail_country,"กรุงเทพฯ") <> 0 THEN np_mail_country = "กรุงเทพมหานคร".

fi_process             = " Proc add444"   .
DISP fi_process    WITH FRAME fr_main.

FIND LAST sicuw.uwm500 USE-INDEX uwm50002 WHERE 
    sicuw.uwm500.prov_d = np_mail_country  NO-LOCK NO-ERROR NO-WAIT.  /*"กาญจนบุรี"*/   /*uwm100.codeaddr1*/
IF AVAIL sicuw.uwm500 THEN DO:  
    /*DISP sicuw.uwm500.prov_n .*/
    ASSIGN np_codeaddr1 = sicuw.uwm500.prov_n . 
    FIND LAST sicuw.uwm501 USE-INDEX uwm50102   WHERE 
        sicuw.uwm501.prov_n = sicuw.uwm500.prov_n  AND
        index(sicuw.uwm501.dist_d,np_mail_amper) <> 0        NO-LOCK NO-ERROR NO-WAIT. /*"พนมทวน"*/
    IF AVAIL sicuw.uwm501 THEN DO:  
        /*DISP
        sicuw.uwm501.prov_n  /* uwm100.codeaddr1 */
        sicuw.uwm501.dist_n  /* uwm100.codeaddr2 */ 
        . 
        */
        ASSIGN 
            np_codeaddr1 =  sicuw.uwm501.prov_n 
            np_codeaddr2 =  sicuw.uwm501.dist_n .
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew C-Win 
PROCEDURE proc_assignrenew :
/*------------------------------------------------------------------------------
  Purpose: CONNECTED Expiry
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_newbr AS CHAR .
DEF VAR n_countuser AS INTE INIT 0.
DEF VAR n_brrenewold AS CHAR.
ASSIGN n_newbr   = wdetail.branch
       np_comdat = ?        /*A59-0182*/
       np_vehuse = ""       /*A59-0182*/
       n_bennam1 = ""       /*A59-0182*/  
       n_prmtxt  = ""       /*A59-0182*/  
       n_driver  = ""      /*A59-0182*/
       n_promo   = ""      /*A61-0269*/
       nv_dss_per = 0 .    /*A63-0162*/
ASSIGN n_countuser = 0.
loop_chkexp:
REPEAT:
    ASSIGN n_countuser = n_countuser + 1.
    IF NOT CONNECTED("sic_exp")   THEN RUN proc_sic_exp2.
    ELSE LEAVE loop_chkexp.
    IF   n_countuser > 3 THEN  LEAVE loop_chkexp.
END.
IF  CONNECTED("sic_exp") THEN DO:
    /*RUN proc_klrenew (INPUT-OUTPUT wdetail.comdat,*/
    /*RUN wgw\wgwtklex (INPUT-OUTPUT wdetail.comdat,*/ /*A59-0182*/
    RUN wgw\wgwtklex (INPUT-OUTPUT np_comdat,       /*A59-0182*/
                      INPUT-OUTPUT wdetail.prepol,       
                      INPUT-OUTPUT n_brrenewold,   /*wdetail.branch,   */      
                      INPUT-OUTPUT n_firstdat,              
                      INPUT-OUTPUT wdetail.class,               
                      INPUT-OUTPUT wdetail.redbook,           
                      /*INPUT-OUTPUT wdetail.vehuse, */  /*A59-0182*/   
                      INPUT-OUTPUT np_vehuse,            /*A59-0182*/
                      INPUT-OUTPUT wdetail.covcod,          
                      INPUT-OUTPUT wdetail.seat41,                       
                      INPUT-OUTPUT nv_basere,                              
                      INPUT-OUTPUT dod1,                                
                      INPUT-OUTPUT dod2,                               
                      INPUT-OUTPUT dod0,                                  
                      INPUT-OUTPUT nv_flet_per,                        
                      INPUT-OUTPUT wdetail.NCB, 
                      INPUT-OUTPUT nv_dss_per,
                      INPUT-OUTPUT nv_cl_per,
                      INPUT-OUTPUT wdetail.si,
                      INPUT-OUTPUT WDETAIL.no_41,
                      INPUT-OUTPUT WDETAIL.no_42,
                      INPUT-OUTPUT WDETAIL.no_43,
                      INPUT-OUTPUT nv_stf_per,
                      INPUT-OUTPUT n_uom1_v,
                      INPUT-OUTPUT n_uom2_v,
                      INPUT-OUTPUT n_uom5_v,
                      INPUT-OUTPUT n_uom7_v,
                      INPUT-OUTPUT wdetail.premt,
                      INPUT-OUTPUT wdetail.engcc,
                      INPUT-OUTPUT wdetail.caryear, /* --suthida T. A54-0010 18-04-11 ---- */
                      INPUT-OUTPUT n_bennam1,  /*A59-0182*/ 
                      INPUT-OUTPUT n_prmtxt,   /*A59-0182*/
                      INPUT-OUTPUT n_driver,  /*A59-0182*/
                      INPUT-OUTPUT n_promo,
                      INPUT-OUTPUT nv_insref) . /*A61-0269*/
    nv_insref = "".   /*A66-0142 ไม่เอารหัสเดิม ต้องการ สร้างใหม่*/

    /* Comment by Ranu I. A59-0182 ...
    ASSIGN 
        wdetail.expdat = DATE(STRING(DAY(wdetail.comdat),"99")   + "/" + 
                              STRING(MONTH(wdetail.comdat),"99") + "/" + 
                              STRING(YEAR(wdetail.comdat) + 1 ,"9999"))
        wdetail.branch = trim(n_newbr)
        n_newbr = "" .
  ...End A59-0182.........*/
    /*-- Create by A59-0182 --*/
    IF wdetail.comdat  = ?     THEN ASSIGN wdetail.comdat = np_comdat.
    IF wdetail.expdat  = ?     THEN ASSIGN wdetail.expdat = DATE(STRING(DAY(wdetail.comdat),"99")   + "/" + 
                                                           STRING(MONTH(wdetail.comdat),"99") + "/" + 
                                                           STRING(YEAR(wdetail.comdat) + 1 ,"9999")).
    IF wdetail.vehuse  = " "   THEN ASSIGN wdetail.vehuse = np_vehuse .
    IF wdetail.branch  = " "   THEN ASSIGN wdetail.branch = trim(n_newbr).
    IF wdetail.covcod  = "1"   THEN ASSIGN n_uom7_v = wdetail.si.
    IF wdetail.accessd = " "   THEN ASSIGN wdetail.accessd = n_prmtxt.
    IF n_promo <> ""  THEN ASSIGN wdetail.promo = TRIM(n_promo) . /*A61-0269*/
    ASSIGN n_newbr = "".
    /*-- End A59-0182 --*/
    /* add by : A63-016 */
    IF DATE(wdetail.comdat) >= 04/01/2020 THEN DO: 
        FIND FIRST brstat.insure USE-INDEX insure01 WHERE 
           trim(brstat.Insure.compno)  = TRIM(fi_pack)  AND 
           trim(brstat.insure.vatcode) = SUBSTR(wdetail.class,1,1)   NO-ERROR.
        IF AVAIL brstat.insure THEN ASSIGN wdetail.CLASS = trim(brstat.insure.Text3) + TRIM(SUBSTR(wdetail.CLASS,2,3))   .
    END.
   /* end A63-0162 */ 
    
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_assignrenew2 C-Win 
PROCEDURE proc_assignrenew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*IF NOT CONNECTED("sic_exp") THEN DO:
    FORM
        gv_id  LABEL " User Id " colon 35 SKIP
        nv_pwd LABEL " Password" colon 35 BLANK
        WITH FRAME nf00 CENTERED ROW 10 SIDE-LABELS OVERLAY width 80
        TITLE   " Connect DB Expiry System"  . 
    
    STATUS INPUT OFF.
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
    
      IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
          
          CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd)  . 
          /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd)  .*/   /*db test. ann */
          CLEAR FRAME nf00.
          HIDE FRAME nf00.
    
          RETURN. 
      END. /*IF LASTKEY = KEYCODE("F1") */
    END. /* REPEAT */
END. /* IF NOT CONNECTED("sic_exp") */

IF  CONNECTED("sic_exp") THEN DO:
    
   /* FIND FIRST sic_bran.uwm100 WHERE 
               sic_bran.uwm100.policy <> wdetail.applino AND
               sic_bran.uwm100.cedpol  = wdetail.applino AND
               sic_bran.uwm100.poltyp  = "V70"           NO-LOCK NO-ERROR.
    IF AVAILABLE sic_bran.uwm100   THEN DO:
       ASSIGN 
           n_prepol = sic_bran.uwm100.prvpol.

    END.
    ELSE DO:



    END.*/
    IF SUBSTRING(wdetail.cr_2,1,2) = "RW" THEN
       n_prepol = SUBSTRING(wdetail.cr_2,3,LENGTH(wdetail.cr_2)). 
    ELSE DO:

       FIND FIRST sic_bran.uwm100 USE-INDEX uwm10001
            WHERE sic_bran.uwm100.policy = wdetail.cr_2 NO-LOCK NO-ERROR.
       IF AVAIL  sic_bran.uwm100 THEN n_prepol = sic_bran.uwm100.prvpol.
       ELSE
           ASSIGN
             wdetail.pass    = "N"  
             wdetail.comment = wdetail.comment + "| NOT AVAILABLE Previous Policy No. in Policy 70"
             WDETAIL.OK_GEN  = "N".

    END.

    RUN proc_klrenew2 (INPUT-OUTPUT wdetail.comdat,
                       INPUT        n_prepol). /* ------- suthida T. A54-0010 18-04-11 ----------- */
                      
    ASSIGN 
        wdetail.expdat = DATE(STRING(DAY(wdetail.comdat),"99")   + "/" + 
                              STRING(MONTH(wdetail.comdat),"99") + "/" + 
                              STRING(YEAR(wdetail.comdat) + 1 ,"9999")). 

END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_base2 C-Win 
PROCEDURE proc_base2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR chk     AS LOGICAL.
/*DEF VAR dod0        AS INTEGER.
DEF VAR dod1        AS INTEGER.
DEF VAR dod2        AS INTEGER.*/
/*DEF VAR dpd0        AS INTEGER.*/
DEFINE VAR NO_basemsg AS CHAR  FORMAT "x(50)" .          /*Warning Error If Not in Range 25/09/2006 */
/* ----- suthida T. A52-0275 27-09-10 ----- */
IF wdetail.prepol = ""  THEN ASSIGN  nv_dss_per  = 0 nv_baseprm  = 0 dod0 = 0 dod1 = 0 dod2 = 0 dpd0 = 0.
/* ----- suthida T. A52-0275 27-09-10 ----- */
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
IF wdetail.poltyp = "V70" THEN DO:
    ASSIGN NO_basemsg = " " .
    /*-----nv_drivcod---------------------*/
   IF wdetail.prepol = ""  THEN DO:
       nv_drivvar1 = wdetail.drivername1.
       nv_drivvar2 = wdetail.drivername2.
      IF wdetail.drivername1 <> ""   THEN  wdetail.drivnam  = "y".
      ELSE wdetail.drivnam  = "N".
      IF wdetail.drivername2 <> ""   THEN  nv_drivno = 2. 
      ELSE IF wdetail.drivername1 <> "" AND wdetail.drivername2 = "" THEN  nv_drivno = 1.  
      ELSE IF wdetail.drivername1 = ""  AND wdetail.drivername2 = "" THEN  nv_drivno = 0. 
   END.
   IF wdetail.drivnam  = "N"  THEN DO:
      ASSIGN nv_drivvar   = " "
          nv_drivcod   = "A000"
          nv_drivvar1  =  "     Unname Driver"
          nv_drivvar2  = "0"
          SUBSTR(nv_drivvar,1,30)   = nv_drivvar1
          SUBSTR(nv_drivvar,31,30)  = nv_drivvar2.
   END.
   ELSE DO: /*wdetail.drivnam  <> "N"*/
       IF  nv_drivno  > 2 THEN DO:
           /*MESSAGE " Driver'S NO. must not over 2. "  VIEW-AS ALERT-BOX.*/
           ASSIGN wdetail.pass    = "N"
               wdetail.comment = wdetail.comment +  "| Driver'S NO. must not over 2. ".  
       END.
       RUN proc_usdcod.
       ASSIGN    nv_drivvar = "" 
           nv_drivvar     = nv_drivcod
           nv_drivvar1    = "     Driver name person = "
           nv_drivvar2    = STRING(nv_drivno)
           SUBSTR(nv_drivvar,1,30)  = nv_drivvar1
           SUBSTR(nv_drivvar,31,30) = nv_drivvar2.
   END. /*else wdetail.drivnam  = "N"*/
   /*-------nv_baseprm----------*/
   /* ------------ suthida T. A52-0275 20-09-10 --------------------- */
   FIND LAST sicsyac.xmm106   WHERE
        sicsyac.xmm106.tariff =  nv_tariff  AND
        sicsyac.xmm106.bencod =  "BASE"     AND
        sicsyac.xmm106.class  =  nv_class   AND
        sicsyac.xmm106.covcod =  nv_covcod  AND
        sicsyac.xmm106.key_b  GE nv_key_b   AND
        sicsyac.xmm106.effdat LE nv_comdat NO-LOCK NO-ERROR NO-WAIT.
   /* ------------ suthida T. A52-0275 20-09-10 --------------------- */
   /* ------------ suthida T. A52-0275 20-09-10 --------------------- 
   FIND LAST sicsyac.xmm106 USE-INDEX xmm10601 WHERE
        sicsyac.xmm106.tariff =  nv_tariff  AND
        sicsyac.xmm106.bencod =  "BASE"     AND
        sicsyac.xmm106.covcod =  nv_covcod  AND
        sicsyac.xmm106.class  =  nv_class   AND
        sicsyac.xmm106.key_b  GE nv_key_b   AND
        sicsyac.xmm106.effdat LE nv_comdat NO-LOCK NO-ERROR NO-WAIT.
   ------------ suthida T. A52-0275 20-09-10 ---------------------  */
   IF AVAIL sicsyac.xmm106 THEN DO:
      IF   nv_drivcod = "A000" THEN nv_baseprm = sicsyac.xmm106.max_ap.
      ELSE nv_baseprm = sicsyac.xmm106.min_ap.
      IF wdetail.prepol <> "" THEN nv_baseprm = nv_basere. /* ----- suthida T. A54-0010 21-06-11 -----  */
   END.
   /* A61-0269*/
   IF (wdetail.covcod = "2.1") OR (wdetail.covcod = "3.1") OR (wdetail.covcod = "2.2") OR (wdetail.covcod = "3.2") THEN DO: 
       IF nv_baseprm = 0 THEN RUN wgs\wgsfbas.
   END.
   /* A61-0269*/
   ELSE DO:
      IF wdetail.prepol = "" THEN DO:
        IF substr(nv_class,2,3) = "320" AND wdetail.covcod = "1" THEN 
           ASSIGN   nv_dss_per =  15
           nv_baseprm = 14000.
        ELSE IF substr(nv_class,2,3) = "110"  THEN 
           ASSIGN 
           wdetail.ncb = "20"
           nv_dss_per  =  6.73
           nv_baseprm  = 7600 .
        /* ELSE IF substr(nv_class,2,3) = "610" THEN    /*A59-0182*/
           ASSIGN nv_baseprm = nv_basere.           /*A59-0182*/*/
      END.
   END.
   IF NO_basemsg <> " " THEN wdetail.WARNING = no_basemsg.
   IF nv_baseprm = 0  THEN 
      ASSIGN wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| Base Premium is Mandatory field. ". 
   ASSIGN   nv_basevar = ""
     nv_prem1    = nv_baseprm
     nv_basecod  = "BASE"
     nv_basevar1 = "     Base Premium = "
     nv_basevar2 = STRING(nv_baseprm)
     SUBSTRING(nv_basevar,1,30)   = nv_basevar1
     SUBSTRING(nv_basevar,31,30)  = nv_basevar2.
   /*-------nv_add perils----------*/
  ASSIGN
      nv_41 =  DECI(WDETAIL.no_41)
      nv_42 =  DECI(WDETAIL.no_42)
      nv_43 =  DECI(WDETAIL.no_43)
      nv_seat41 = INTEGER(wdetail.seat41).
  /*comment by : Kridtiya i. A64-0138... 
   RUN WGS\WGSOPER(INPUT nv_tariff,       
              nv_class,
              nv_key_b,
              nv_comdat). 
   ...end A64-0138....*/ 
   ASSIGN  nv_411var = ""  nv_412var = ""                                                    
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
     nv_42var   = " ".     /* -------fi_42---------*/
   ASSIGN   nv_42var = ""
     nv_42cod   = "42".
     nv_42var1  = "     Medical Expense = ".
     nv_42var2  = STRING(nv_42).
     SUBSTRING(nv_42var,1,30)   = nv_42var1.
     SUBSTRING(nv_42var,31,30)  = nv_42var2.
     nv_43var    = " ".     /*---------fi_43--------*/
   ASSIGN   nv_43var = ""
     nv_43prm   = nv_43
     nv_43cod   = "43"
     nv_43var1  = "     Airfrieght = "
     nv_43var2  =  STRING(nv_43)
     SUBSTRING(nv_43var,1,30)   = nv_43var1
     SUBSTRING(nv_43var,31,30)  = nv_43var2.
   /*comment by : Ranu I. A64-0138... 
   RUN WGS\WGSOPER(INPUT nv_tariff,   /*pass*/ /*a490166 note modi*/
              nv_class,
              nv_key_b,
              nv_comdat).      /*  RUN US\USOPER(INPUT nv_tariff,*/
   end...comment by : Ranu I. A64-0138...*/
   /*------nv_usecod------------*/
   ASSIGN nv_usevar = ""
     nv_usecod  = "USE" + TRIM(wdetail.vehuse)
     nv_usevar1 = "     Vehicle Use = "
     nv_usevar2 =  wdetail.vehuse
     SUBSTRING(nv_usevar,1,30)   = nv_usevar1
     SUBSTRING(nv_usevar,31,30) = nv_usevar2.
   /*-----nv_engcod-----------------*/
   ASSIGN nv_sclass =  substr(wdetail.class,2,3).       
   RUN wgs\wgsoeng.
   /*-----nv_yrcod----------------------------*/  
   ASSIGN  nv_yrvar = ""
      nv_caryr   = (YEAR(nv_comdat)) - INTEGER(wdetail.caryear) + 1
      nv_yrvar1  = "     Vehicle Year = "
      nv_yrvar2  =  wdetail.caryear
      nv_yrcod   = If nv_caryr <= 10 THEN "YR" + STRING(nv_caryr) ELSE "YR99"
      SUBSTR(nv_yrvar,1,30)    = nv_yrvar1
      SUBSTR(nv_yrvar,31,30)   = nv_yrvar2.  
   /*-----nv_sicod----------------------------*/  
   ASSIGN  nv_totsi     = 0     nv_sivar = ""
       nv_sicod     = "SI"
       nv_sivar1    = "     Own Damage = "
       nv_sivar2    =  STRING(wdetail.si)
       SUBSTRING(nv_sivar,1,30)  = nv_sivar1
       SUBSTRING(nv_sivar,31,30) = STRING(DECI(nv_sivar2))
       nv_totsi     =  DECI(wdetail.si).
   /*----------nv_grpcod--------------------*/
   ASSIGN nv_grpvar = ""
       nv_grpcod      = "GRP" + wdetail.cargrp
       nv_grpvar1     = "     Vehicle Group = "
       nv_grpvar2     = wdetail.cargrp
       SUBSTR(nv_grpvar,1,30)  = nv_grpvar1
       SUBSTR(nv_grpvar,31,30) = nv_grpvar2.
   /*-------------nv_bipcod--------------------*/
   ASSIGN nv_bipvar = ""
   nv_bipcod      = "BI1"
   nv_bipvar1     = "     BI per Person = "
   nv_bipvar2     = STRING(sic_bran.uwm130.uom1_v)
   SUBSTRING(nv_bipvar,1,30)   = nv_bipvar1
   SUBSTRING(nv_bipvar,31,30)  = nv_bipvar2.
   /*-------------nv_biacod--------------------*/
   ASSIGN nv_biavar = ""
   nv_biacod      = "BI2"
   nv_biavar1     = "     BI per Accident = "
   nv_biavar2     = STRING(sic_bran.uwm130.uom2_v)
   SUBSTRING(nv_biavar,1,30)  = nv_biavar1
   SUBSTRING(nv_biavar,31,30) = nv_biavar2.
   /*-------------nv_pdacod--------------------*/
   ASSIGN  nv_pdavar = ""
   nv_pdacod      = "PD"
   nv_pdavar1     = "     PD per Accident = "
   nv_pdavar2     =  STRING(sic_bran.uwm130.uom5_v) /*STRING(DECI(WDETAIL.deductpd))*/        /*A52-0172*/
   SUBSTRING(nv_pdavar,1,30)  = nv_pdavar1
   SUBSTRING(nv_pdavar,31,30) = nv_pdavar2.
   /*-------- A61-0269  2+ 3+ -----------*/
   IF wdetail.covcod = "2.1" OR wdetail.covcod = "2.2" OR wdetail.covcod = "3.1" OR wdetail.covcod = "3.2" THEN DO:
      IF      (wdetail.covcod = "2.1")   THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "21" .
       ELSE IF (wdetail.covcod = "2.2")  THEN nv_usecod3 = "U" + TRIM(nv_vehuse) + "22" .
       ELSE IF (wdetail.covcod = "3.1")  THEN  nv_usecod3 = "U" + TRIM(nv_vehuse) + "31" .
       ELSE nv_usecod3 = "U" + TRIM(nv_vehuse) + "32" .
       ASSIGN   
           nv_usevar4 = "     Vehicle Use = "
           nv_usevar5 =  wdetail.vehuse
           Substring(nv_usevar3,1,30)   = nv_usevar4
           Substring(nv_usevar3,31,30)  = nv_usevar5.
        ASSIGN  nv_basecod3 = IF      (wdetail.covcod = "2.1") THEN "BA21"
                              ELSE IF (wdetail.covcod = "2.2") THEN "BA22" 
                              ELSE IF (wdetail.covcod = "3.1") THEN "BA31"ELSE "BA32".
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
        ASSIGN  nv_sivar3 = "" 
           nv_sicod3    = IF      (wdetail.covcod = "2.1") THEN "SI21" 
                          ELSE IF (wdetail.covcod = "2.2") THEN "SI22" 
                          ELSE IF (wdetail.covcod = "3.1") THEN "SI31"  ELSE "SI32"     
           nv_sivar4    = "     Own Damage = "                                        
           nv_sivar5    =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  string(deci(wdetail.si)) ELSE string(deci(wdetail.si)) 
           wdetail.si   =  IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  wdetail.si ELSE  wdetail.si
           SUBSTRING(nv_sivar3,1,30)  = nv_sivar4
           SUBSTRING(nv_sivar3,31,30) = nv_sivar5 .
           nv_totsi     = IF wdetail.covcod = "2.1" OR wdetail.covcod = "3.1" THEN  deci(wdetail.si) ELSE  deci(wdetail.si).
   END.
   /*--------------- deduct ----------------*/
   /* caculate deduct OD  */
  /* IF dod0 > 3000 THEN DO:
      dod1 = 3000.
      dod2 = dod0 - dod1.
   END.*/
   ASSIGN
     nv_odcod    = "DC01"
     nv_prem     = dod1
     nv_sivar2   = "" . 
   RUN Wgs\Wgsmx024( nv_tariff,              
                 nv_odcod,
                 nv_class,
                 nv_key_b,
                 nv_comdat,
                 INPUT-OUTPUT nv_prem,
                 OUTPUT nv_chk ,
                 OUTPUT nv_baseap).
   IF NOT nv_chk THEN DO:
      MESSAGE  " DEDUCTIBLE EXCEED THE LIMIT " nv_baseap  View-as alert-box.
      ASSIGN
        wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| DEDUCTIBLE EXCEED THE LIMIT ".
   END.
   ASSIGN
     nv_ded1prm        = nv_prem
     nv_dedod1_prm     = nv_prem
     nv_dedod1_cod     = "DOD"
     nv_dedod1var1     = "     Deduct OD = "
     nv_dedod1var2     = STRING(dod1)
   SUBSTRING(nv_dedod1var,1,30)  = nv_dedod1var1
   SUBSTRING(nv_dedod1var,31,30) = nv_dedod1var2.
   /*add od*/
   ASSIGN 
     nv_dedod2var   = " "
     nv_cons  = "AD"
     nv_ded   = dod2.
/*comment by : kridtiya I. A64-0138...
   Run  Wgs\Wgsmx025(INPUT  nv_ded,  
                        nv_tariff,
                        nv_class,
                        nv_key_b,
                        nv_comdat,
                        nv_cons,
                 OUTPUT nv_prem). 
  end....comment by : kridtiya I. A64-0138...*/
   ASSIGN
     nv_aded1prm     = nv_prem
     nv_dedod2_cod   = "DOD2"
     nv_dedod2var1   = "     Add Ded.OD = "
     nv_dedod2var2   =  STRING(dod2)
     SUBSTRING(nv_dedod2var,1,30)  = nv_dedod2var1
     SUBSTRING(nv_dedod2var,31,30) = nv_dedod2var2
     nv_dedod2_prm   = nv_prem.
   /***** pd *******/
   ASSIGN
     nv_dedpdvar  = " "
     nv_cons  = "PD"
    /* nv_ded   = dpd0.*/ /*A61-0269*/
    nv_ded   = dod0. /*A61-0269*/
   /*comment by : kridtiya I. A64-0138...
   RUN  Wgs\Wgsmx025(INPUT  nv_ded, 
                        nv_tariff,
                        nv_class,
                        nv_key_b,
                        nv_comdat,
                        nv_cons,
                 OUTPUT nv_prem).
   nv_ded2prm    = nv_prem.
   end...comment by : Ranu I. A64-0138...*/
   ASSIGN
     nv_dedpd_cod   = "DPD"
     nv_dedpdvar1   = "     Deduct PD = "
     nv_dedpdvar2   =  STRING(nv_ded)
     SUBSTRING(nv_dedpdvar,1,30)    = nv_dedpdvar1
     SUBSTRING(nv_dedpdvar,31,30)   = nv_dedpdvar2.
   /*  nv_dedpd_prm  = nv_prem.  */ /*A64-0138*/
   /*---------- fleet -------------------*/
   /*nv_flet_per = INTE(wdetail.fleet). */ /*A61-0269*/
   IF nv_flet_per <> 0 AND  nv_flet_per <> 10 THEN DO:
      MESSAGE  " Fleet Percent must be 0 or 10. " VIEW-AS ALERT-BOX.
      ASSIGN
          wdetail.pass    = "N"
          wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. ".
   END.  
   IF nv_flet_per = 0 THEN DO:
      ASSIGN
          nv_flet     = 0
          nv_fletvar  = " ".
   END.
   /*comment by : A64-0138...
   RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                          nv_class,
                          nv_covcod,
                          nv_key_b,
                          nv_comdat,
                          nv_totsi,
                          uwm130.uom1_v,
                          uwm130.uom2_v,
                          uwm130.uom5_v).
   end. comment by : A64-0138...*/
   ASSIGN
     nv_fletvar     = " "
     nv_fletvar1    = "     Fleet % = "
     nv_fletvar2    =  STRING(nv_flet_per)
     SUBSTRING(nv_fletvar,1,30)     = nv_fletvar1
     SUBSTRING(nv_fletvar,31,30)    = nv_fletvar2.

   IF nv_flet   = 0  THEN nv_fletvar  = " ".
   /*---------------- NCB -------------------*/
   NV_NCBPER = INTE(WDETAIL.NCB).
   nv_ncbvar = " ".
   IF nv_ncbper  <> 0 THEN DO:
   FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 Where
       sicsyac.xmm104.tariff = nv_tariff          AND
       sicsyac.xmm104.class  = nv_class           AND 
       sicsyac.xmm104.covcod = nv_covcod          AND 
       sicsyac.xmm104.ncbper   = INTE(wdetail.ncb)
       NO-LOCK NO-ERROR NO-WAIT.
   IF NOT AVAIL  sicsyac.xmm104  THEN DO:
       MESSAGE " This NCB Step not on NCB Rates file xmm104. " VIEW-AS ALERT-BOX.
       ASSIGN
           wdetail.pass    = "N"
           wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. ".
   END.
   ASSIGN
       nv_ncbper = xmm104.ncbper   
       nv_ncbyrs = xmm104.ncbyrs.
   END.
   ELSE DO:  
   ASSIGN
       nv_ncbyrs  =   0
       nv_ncbper  =   0
       nv_ncb     =   0 .
   END. 
   /*comment by : A64-0138...
   RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                          nv_class,
                          nv_covcod,
                          nv_key_b,
                          nv_comdat,
                          nv_totsi,
                          uwm130.uom1_v,
                          uwm130.uom2_v,
                          uwm130.uom5_v).
   end...comment by : A64-0138...*/
   nv_ncbvar   = " ".
   IF  nv_ncb <> 0  THEN
   ASSIGN 
      nv_ncbvar1   = "     NCB % = "
      nv_ncbvar2   =  STRING(nv_ncbper)
      SUBSTRING(nv_ncbvar,1,30)    = nv_ncbvar1
      SUBSTRING(nv_ncbvar,31,30)   = nv_ncbvar2.
   /*comment by : A64-0138...
   RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/
                       nv_class,
                       nv_covcod,
                       nv_key_b,
                       nv_comdat,
                       nv_totsi,
                       nv_uom1_v ,       
                       nv_uom2_v ,       
                       nv_uom5_v ).
   end.comment by : A64-0138...*/
 /*------------------ dsspc ---------------*/
  nv_dsspcvar = "" . /*a63-0162*/
  IF  nv_dss_per   <> 0  THEN
       ASSIGN
          nv_dsspcvar1   = "     Discount Special % = "
          nv_dsspcvar2   =  STRING(nv_dss_per)
          SUBSTRING(nv_dsspcvar,1,30)    = nv_dsspcvar1
          SUBSTRING(nv_dsspcvar,31,30)   = nv_dsspcvar2. 
    /*A64-0138...
    RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/         
                              nv_class,
                              nv_covcod,
                              nv_key_b,
                              nv_comdat,
                              nv_totsi,
                              nv_uom1_v,       
                              nv_uom2_v,       
                              nv_uom5_v). 
    A64-0138...*/
   nv_stfvar = "" .
   IF  nv_stf_per   <> 0  THEN
       Assign
       nv_stfvar1   = "     Discount staff % = "
       nv_stfvar2   =  STRING(nv_stf_per)                 
       SUBSTRING(nv_stfvar,1,30)    = nv_stfvar1          
       SUBSTRING(nv_stfvar,31,30)   = nv_stfvar2.         
   /*--------------------------*/                         
   /*A64-0138...
   RUN WGS\WGSORPRM.P (INPUT  nv_tariff, /*pass*/         
                              nv_class,
                              nv_covcod,
                              nv_key_b,
                              nv_comdat,
                              nv_totsi,
                              nv_uom1_v,       
                              nv_uom2_v,       
                              nv_uom5_v). */
    /*--------- load claim -------------*/
   nv_clmvar  = " ".
   IF nv_cl_per  <> 0  THEN
      Assign 
      nv_clmvar1   = " Load Claim % = "
      nv_clmvar2   =  STRING(nv_cl_per)
      SUBSTRING(nv_clmvar,1,30)    = nv_clmvar1
      SUBSTRING(nv_clmvar,31,30)   = nv_clmvar2.
   /*A64-0138...
   RUN WGS\WGSORPRM.P (INPUT nv_tariff, /*pass*/
                            nv_class,
                            nv_covcod,
                            nv_key_b,
                            nv_comdat,
                            nv_totsi,
                            uwm130.uom1_v,
                            uwm130.uom2_v,
                            uwm130.uom5_v).*/
   
END. /*70*/ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_calpremt C-Win 
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
        /*nv_seat41  = 0 */         
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
        nv_class   = wdetail.CLASS  /*trim(wdetail.prempa) + trim(wdetail.subclass)   */                                      
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
        nv_seat41  = nv_seat41   
        nv_dedod   = deci(dod1)      
        nv_addod   = deci(dod2)                                
        nv_dedpd   = deci(dpd0)                                    
        nv_ncbp    = deci(wdetail.ncb)                                     
        nv_fletp   = deci(wdetail.fleet)                                  
        nv_dspcp   = deci(nv_dss_per)                                      
        nv_dstfp   = 0                                                     
        nv_clmp    = nv_cl_per  /*deci(wdetail.loadclm)*/
        /*nv_netprem  = TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) + 
                        (IF ((deci(wdetail.premt) * 100) / 107.43) - TRUNCATE(((deci(wdetail.premt) * 100 ) / 107.43 ),0 ) > 0 THEN 1 ELSE 0 )*/
        nv_netprem  =  wdetail.premt  /*DECI(wdetail.volprem)*/ /* เบี้ยสุทธิ */                                                
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
                nv_engine = DECI(sic_bran.uwm301.Tons).
        END.
        nv_engcst = nv_engine .
    END.
    IF nv_cstflg = "W" THEN ASSIGN sic_bran.uwm301.watt = nv_engine . /* add  */
    IF wdetail.redbook = ""  THEN DO:
        IF nv_cstflg <> "T" THEN DO:
            RUN wgw/wgwredbook  (input  wdetail.brand ,  
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
            RUN wgw/wgwredbook  (input  wdetail.brand ,  
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
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                WHERE  stat.maktab_fil.sclass = SUBSTRING(wdetail.class,2,3)      AND
                stat.maktab_fil.modcod = wdetail.redbook   NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL  stat.maktab_fil  THEN
                ASSIGN 
                sic_bran.uwm301.modcod =  stat.maktab_fil.modcod                                    
                wdetail.cargrp         =  stat.maktab_fil.prmpac
                nv_vehgrp              =  stat.maktab_fil.prmpac
                sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac.
        END.
        ELSE DO:
            ASSIGN
                wdetail.comment = wdetail.comment + "| " + "Redbook is Null !! "
                wdetail.WARNING = "Redbook เป็นค่าว่างไม่สามารถนำเข้ามูลเข้าได้ " 
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".
        END.
    END.
    FIND LAST stat.maktab_fil WHERE 
        maktab_fil.makdes   =  wdetail.brand AND 
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
    " CCTV "              nv_fcctv      VIEW-AS ALERT-BOX.     */

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
                       INPUT-OUTPUT nv_41prmt,  /* nv_41prmt */
                       INPUT-OUTPUT nv_42prmt,  /* nv_42prmt */
                       INPUT-OUTPUT nv_43prmt,  /* nv_43prmt */
                       INPUT-OUTPUT nv_seat41,  /* nv_seat41 */              
                       INPUT-OUTPUT nv_dedod,   
                       INPUT-OUTPUT nv_addod,    
                       INPUT-OUTPUT nv_dedpd,                  
                       INPUT-OUTPUT nv_ncbp,      
                       INPUT-OUTPUT nv_fletp,   
                       INPUT-OUTPUT nv_dspcp,   
                       INPUT-OUTPUT nv_dstfp,   
                       INPUT-OUTPUT nv_clmp,                  
                       INPUT-OUTPUT nv_baseprm ,  /* nv_baseprm  */
                       INPUT-OUTPUT nv_baseprm3,  /* nv_baseprm3 */
                       INPUT-OUTPUT nv_pdprem  ,  /* nv_pdprem   */
                       INPUT-OUTPUT nv_netprem,   /* nv_netprem  */
                       INPUT-OUTPUT nv_gapprm,  
                       INPUT-OUTPUT nv_flagprm,             
                       INPUT-OUTPUT nv_effdat,
                       INPUT-OUTPUT nv_ratatt, 
                       INPUT-OUTPUT nv_siatt ,
                       INPUT-OUTPUT nv_netatt,    
                       INPUT-OUTPUT nv_fltatt, 
                       INPUT-OUTPUT nv_ncbatt, 
                       INPUT-OUTPUT nv_dscatt,
                       INPUT-OUTPUT nv_fcctv ,  /* cctv = yes/no */
                       OUTPUT nv_uom1_c ,  
                       OUTPUT nv_uom2_c ,  
                       OUTPUT nv_uom5_c ,  
                       OUTPUT nv_uom6_c ,
                       OUTPUT nv_uom7_c ,
                       OUTPUT nv_status, 
                       OUTPUT nv_message). 

    /*IF nv_gapprm <> DECI(wdetail.volprem) THEN DO:*/
    /*IF nv_gapprm <> DECI(wdetail.premt) THEN DO:  */
    IF nv_status = "no" THEN DO:
      /*   MESSAGE "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + 
            string(wdetail.premt) + nv_message  VIEW-AS ALERT-BOX. 
         ASSIGN
                wdetail.comment = wdetail.comment + "| " + "เบี้ยจากระบบ ไม่เท่ากับเบี้ยในไฟล์ "
                wdetail.WARNING = "เบี้ยจากระบบ " + string(nv_gapprm,">>,>>>,>>9.99") + " ไม่เท่ากับเบี้ยในไฟล์ " + string(wdetail.premt)
             /*   wdetail.pass    = "Y"      
                wdetail.OK_GEN  = "N" */   .  
         *//*comment by Kridtiya i. A65-0035*/ 
        /*  by Kridtiya i. A65-0035*/
        IF index(nv_message,"NOT FOUND BENEFIT") <> 0  THEN ASSIGN wdetail.pass  = "N" . 
        ASSIGN
            wdetail.comment = wdetail.comment + "|" + nv_message
            wdetail.WARNING = wdetail.WARNING + "|" + nv_message .
         /*  by Kridtiya i. A65-0035*/
    END.
    /*  by Kridtiya i. A65-0035*/
    /* Check Date and Cover Day */
    nv_chkerror = "" .
    RUN wgw/wgwchkdate(input wdetail.comdat,
                       input wdetail.expdat,
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chassic C-Win 
PROCEDURE proc_chassic :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR nv_chanew AS CHAR.
DEFINE VAR nv_len AS INTE INIT 0.
/* ----- suthida T. A52-0275 27-09-10 ----- */
ASSIGN
   nv_chanew = ""
   nv_len    = 0.

ASSIGN nv_uwm301trareg = wdetail.chasno.
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
    ASSIGN wdetail.chasno = nv_uwm301trareg.
      
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Checkdatarenew C-Win 
PROCEDURE proc_Checkdatarenew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VAR n_countuser2  AS INTE INIT 0.
DEFINE VAR n_expdat      AS DATE FORMAT "99/99/9999". 
DEFINE VAR n_subclass    AS CHAR FORMAT "x(3)" .   
DEFINE VAR n_covcod      AS CHAR FORMAT "x(30)" . 
DEFINE VAR n_garage      AS CHAR FORMAT "x(30)" . 
DEFINE VAR nv_si         AS DECI FORMAT "->>,>>>,>>>,>>9.99"   INIT 0.
DEFINE VAR premt         AS DECI FORMAT ">,>>>,>>>,>>9.99-"    INIT 0.

FOR EACH wdetail:
    ASSIGN wdetail.PASS = "Y"  .

    IF  NOT CONNECTED("sic_exp") THEN DO:
        ASSIGN n_countuser2 = 0.
        loop_chkexp:
        REPEAT:
            ASSIGN n_countuser2 = n_countuser2 + 1.
            IF NOT CONNECTED("sic_exp")   THEN RUN proc_sic_exp2.
            ELSE LEAVE loop_chkexp.
            IF   n_countuser2 > 3 THEN  LEAVE loop_chkexp.
            END.
    END.
    IF  CONNECTED("sic_exp") THEN DO:
        IF wdetail.prepol <> "" THEN DO:
            
            
            RUN wgw\wgwtkle1  (INPUT-OUTPUT n_expdat     
                               ,INPUT-OUTPUT wdetail.prepol
                               ,INPUT-OUTPUT n_subclass   
                               ,INPUT-OUTPUT n_covcod   
                               ,INPUT-OUTPUT n_garage
                               ,INPUT-OUTPUT nv_si        
                               ,INPUT-OUTPUT premt) . 
            IF  wdetail.comdat <>  n_expdat THEN DO:
                IF  wdetail.comdat >  n_expdat THEN 
                    ASSIGN wdetail.comment = wdetail.comment + "|วันที่เริ่มต้นมากกว่าวันที่หมดอายุใบเตือน " +
                                         "file: " + string(wdetail.comdat,"99/99/9999") + 
                                         " expiry: " +   string(n_expdat,"99/99/9999").
                ELSE ASSIGN wdetail.comment = wdetail.comment + "|วันที่เริ่มต้นน้อยกว่าวันที่หมดอายุใบเตือน " +
                                         "file: " + string(wdetail.comdat,"99/99/9999") + 
                                         " expiry: " +   string(n_expdat,"99/99/9999").
                ASSIGN
                wdetail.pass    = "N"   
                WDETAIL.OK_GEN  = "N". 
            END.
            IF wdetail.CLASS <> n_subclass THEN
                ASSIGN wdetail.comment = wdetail.comment + "|รหัสไม่ตรง " + "file: " + wdetail.CLASS + " expiry:" + n_subclass
                wdetail.pass    = "N"   
                WDETAIL.OK_GEN  = "N". 
            IF  wdetail.covcod <> n_covcod  THEN
                ASSIGN wdetail.comment = wdetail.comment + "|ประเภทไม่ตรง " + "file: " + wdetail.covcod + " expiry:" + n_covcod
                wdetail.pass    = "N"   
                WDETAIL.OK_GEN  = "N". 
            IF wdetail.si <>  nv_si THEN
                ASSIGN wdetail.comment = wdetail.comment + "|ทุนไม่ตรง " + "file: " + string(wdetail.si,">>>,>>>,>>9.99") + " expiry:" + string(nv_si,">>>,>>>,>>9.99")
                wdetail.pass    = "N"   
                WDETAIL.OK_GEN  = "N".
            IF  wdetail.premt <> premt THEN
                ASSIGN wdetail.comment = wdetail.comment + "|เบี้ยสุทธิไม่ตรง " + "file: " + string(wdetail.premt,">>>,>>>,>>9.99") + " expiry:" + string(premt,">>>,>>>,>>9.99")
                wdetail.pass    = "N"   
                WDETAIL.OK_GEN  = "N".
            IF  wdetail.garage <> n_garage  THEN
                ASSIGN wdetail.comment = wdetail.comment + "|การซ่อมไม่ตรง " + "file: " + wdetail.garage + " expiry:" + n_garage
                wdetail.pass    = "N"   
                WDETAIL.OK_GEN  = "N". 
        END.
    END.
END.     /*for each*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkcode C-Win 
PROCEDURE proc_chkcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Add by : A64-0138 */ 
  nv_chkerror = "".
    RUN wgw\wgwchkagpd  (INPUT fi_agent ,           
                         INPUT fi_producer ,  
                         INPUT-OUTPUT nv_chkerror).
    IF nv_chkerror <> "" THEN DO:
        MESSAGE "Error Code Producer/Agent :" nv_chkerror  SKIP
        wdetail.producer SKIP
        wdetail.agent  VIEW-AS ALERT-BOX. 
        ASSIGN wdetail.comment = wdetail.comment + nv_chkerror 
               wdetail.pass    = "N" 
               wdetail.OK_GEN  = "N".
    END.
 
/* IF wdetail.n_delercode <> "" THEN DO:
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
 END.*/
 IF wdetail.financecd <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.financecd) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Finance " + wdetail.financecd + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
     ELSE DO:
      IF sicsyac.xmm600.closed <> ? AND sicsyac.xmm600.closed < TODAY THEN
       ASSIGN wdetail.comment = wdetail.comment + "| Code Finance " + wdetail.financecd + " Closed Date: " + STRING(sicsyac.xmm600.closed,"99/99/9999") 
              wdetail.pass    = "N" 
              wdetail.OK_GEN  = "N".
     END.
 END.
 /*
 IF wdetail.payercod <> "" THEN DO:
     FIND LAST sicsyac.xmm600 USE-INDEX xmm60001 WHERE sicsyac.xmm600.acno = TRIM(wdetail.payercod) NO-LOCK NO-ERROR.
     IF NOT AVAIL sicsyac.xmm600 THEN 
         ASSIGN wdetail.comment = wdetail.comment + "| Not found Code Payer " + wdetail.payercod + "(xmm600)" 
            wdetail.pass    = "N" 
            wdetail.OK_GEN  = "N".
 END.
 
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
 END.*/
 RELEASE sicsyac.xmm600.
  /* end : A64-0138 */ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chkdata C-Win 
PROCEDURE proc_chkdata :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN nv_modelred = "".   /* model */
IF      SUBSTRING(wdetail.class,2,3) = "110" THEN wdetail.seat = 7.
ELSE IF SUBSTRING(wdetail.class,2,3) = "210" THEN wdetail.seat = 12.
ELSE IF SUBSTRING(wdetail.class,2,3) = "320" THEN wdetail.seat = 3.
IF wdetail.vehreg = " " AND wdetail.prepol  = " " THEN DO: 
    ASSIGN wdetail.comment = wdetail.comment + "| Vehicle Register is mandatory field. "
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N". 
END.
ELSE DO:
    IF wdetail.prepol = " " THEN DO:     /*ถ้าเป็นงาน New ให้ Check ทะเบียนรถ*/
        DEF  VAR  nv_vehreg  AS   CHAR  INIT  " ".
        DEF  VAR  s_polno    LIKE sicuw.uwm100.policy   INIT " ".
        /* ---- suthida T. A52-0275 27-09-10 ----- */
        ASSIGN 
            nv_vehreg = ""
            s_polno   = "".
        FIND LAST sicuw.uwm301 USE-INDEX uwm30102  WHERE  
            sicuw.uwm301.vehreg = wdetail.vehreg   NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm301 THEN DO:
            IF  sicuw.uwm301.policy =  wdetail.policy AND          
                sicuw.uwm301.endcnt = 1  AND
                sicuw.uwm301.rencnt = 1  AND
                sicuw.uwm301.riskno = 1  AND
                sicuw.uwm301.itemno = 1  THEN  LEAVE.
            FIND FIRST sicuw.uwm100 USE-INDEX uwm10001     WHERE
                sicuw.uwm100.policy = sicuw.uwm301.policy  AND
                sicuw.uwm100.rencnt = sicuw.uwm301.rencnt  AND                         
                sicuw.uwm100.endcnt = sicuw.uwm301.endcnt  AND
                sicuw.uwm100.expdat > wdetail.comdat       NO-LOCK NO-ERROR NO-WAIT.
            If AVAIL sicuw.uwm100 THEN s_polno     =   sicuw.uwm100.policy.
        END.        /*avil 301*/
    END.            /*จบการ Check ทะเบียนรถ*/
END.                /*note end else*/   /*end note vehreg*/
/*-------------- ตรวจสอบ Error ----------------------*/
IF wdetail.endcnt = 0 THEN DO:  /* Check เฉพาะที่เป็นกรมธรรม์และต่ออายุ */
    IF wdetail.recnt LT 0 THEN 
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| Renewal Count error"
        WDETAIL.OK_GEN  = "N".
    IF wdetail.endcnt <> 0 THEN 
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| Endorsement Count error"
        WDETAIL.OK_GEN  = "N".
    IF wdetail.comdat  = ? OR wdetail.expdat = ? THEN
        ASSIGN  wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| ComDate, ExpDate error"
        WDETAIL.OK_GEN  = "N".
    IF wdetail.poltyp = "" THEN 
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| Policy Type is blank"
        WDETAIL.OK_GEN  = "N".
    IF (wdetail.addrss1 + wdetail.addrss2 + wdetail.addrss3 + wdetail.addrss4) = "" THEN 
        ASSIGN wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| Address is blank"
        WDETAIL.OK_GEN  = "N".
END.   /* endcnt = 0 */
IF wdetail.cancel = "ca"  THEN  
    ASSIGN wdetail.pass = "N"  
    wdetail.comment     = wdetail.comment + "| cancel"
    WDETAIL.OK_GEN      = "N".
IF wdetail.name1 = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| ชื่อผู้เอาประกันเป็นค่าว่างกรูณาใส่ชื่อผู้เอาประกัน"
    wdetail.pass           = "N"     
    WDETAIL.OK_GEN         = "N".
IF wdetail.drivnam = "y" AND wdetail.drivername1 =  " "   THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| มีการระบุว่ามีคนขับแต่ไม่มีชื่อคนขับ"
    wdetail.pass           = "N" 
    WDETAIL.OK_GEN         = "N".
IF wdetail.class = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| sub class เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    WDETAIL.OK_GEN  = "N".
IF wdetail.brand = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Brand เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"        
    WDETAIL.OK_GEN  = "N".
IF wdetail.model = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| model เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"   
    WDETAIL.OK_GEN  = "N".
IF wdetail.engcc    = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Engine CC เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"     
    WDETAIL.OK_GEN  = "N".
IF wdetail.caryear = " " THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| year manufacture เป็นค่าว่าง มีผลต่อการค้นหาข้อมูลใน Table Maktab_fil"
    wdetail.pass    = "N"  
    WDETAIL.OK_GEN  = "N".
ASSIGN
    nv_modcod = ""
    nv_maxsi  = 0
    nv_minsi  = 0
    nv_si     = 0
    nv_maxdes = ""
    nv_mindes = ""
    chkred    = NO.     
/*IF wdetail.redbook <> ""  THEN DO:*/ /* --- suthida T. A54-0012 13-03-11 */
IF wdetail.redbook <> "" AND SUBSTRING(wdetail.policy,1,2) <> "RW" THEN DO: /* --- suthida T. A54-0012 13-03-11 */
    FIND FIRST stat.maktab_fil USE-INDEX maktab01  WHERE 
        stat.maktab_fil.sclass = wdetail.class     AND 
        stat.maktab_fil.modcod = wdetail.redbook   NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAIL  stat.maktab_fil  THEN DO:
        ASSIGN
            nv_modcod       =  stat.maktab_fil.modcod                                    
            nv_moddes       =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
            wdetail.cargrp  =  stat.maktab_fil.prmpac
            chkred          =  YES                     /*note chk found redbook*/
            wdetail.brand   =  stat.maktab_fil.makdes
            wdetail.model   =  stat.maktab_fil.moddes
            wdetail.caryear =  STRING(stat.maktab_fil.makyea)
            wdetail.engcc   =  STRING(stat.maktab_fil.engine)
            wdetail.class   =  stat.maktab_fil.sclass 
            wdetail.weight  =  string(stat.maktab_fil.tons)
            wdetail.redbook =  stat.maktab_fil.modcod                                    
            wdetail.seat    =  stat.maktab_fil.seats
            nv_si           =  maktab_fil.si.
        IF wdetail.covcod = "1"  THEN DO:
            FIND FIRST stat.makdes31 WHERE 
                stat.makdes31.makdes = "X"  AND     /*Lock X*/
                stat.makdes31.moddes = wdetail.class    NO-LOCK NO-ERROR NO-WAIT.
            IF AVAILABLE makdes31 THEN 
                ASSIGN
                    nv_maxdes = "+" + STRING(stat.makdes31.si_theft_p) + "%"
                    nv_mindes = "-" + STRING(stat.makdes31.load_p) + "%"
                    nv_maxSI  = nv_si + (nv_si * (stat.makdes31.si_theft_p / 100))
                    nv_minSI  = nv_si - (nv_si * (stat.makdes31.load_p / 100)).
            ELSE 
                ASSIGN
                    nv_maxSI = nv_si
                    nv_minSI = nv_si.
            IF DECI(wdetail.si) > nv_maxSI OR DECI(wdetail.si) < nv_minSI THEN DO:
                IF nv_maxSI = nv_minSI THEN DO:
                    IF nv_maxSI = 0 AND nv_minSI = 0 THEN do:
                        ASSIGN
                            wdetail.comment = "Not Found Sum Insure in maktab_fil (Class:"
                            + wdetail.class + "   Make/Model:" + wdetail.model + " "
                            + wdetail.brand + " " + wdetail.model + "   Year:" + STRING(wdetail.caryear) + ")"
                            wdetail.pass    = "N"    
                            WDETAIL.OK_GEN  = "N".

                    END.
                    ELSE
                        ASSIGN
                            wdetail.comment = "Not Found Sum Insured Rates Maintenance in makdes31 (Tariff: X"
                            + "  Class:"  + wdetail.class + ")"
                            wdetail.pass    = "N"   
                            WDETAIL.OK_GEN  = "N".
                END.
                ELSE
                    ASSIGN
                        wdetail.comment = "Sum Insure must " + nv_mindes + " and " + nv_maxdes
                        + " of " + TRIM(STRING(nv_si,">>>,>>>,>>9"))
                        + " (" + TRIM(STRING(nv_minSI,">>>,>>>,>>9"))
                        + " - " + TRIM(STRING(nv_maxSI,">>>,>>>,>>9")) + ")"wdetail.pass    = "N"   
                        WDETAIL.OK_GEN  = "N".
            END. 
        END.  /***--- End Check Rate SI ---***/
    End.          
    ELSE nv_modcod = " ".
END. /*red book <> ""*/   
IF nv_modcod = "" THEN DO:
    ASSIGN nv_modelred =  IF INDEX(trim(wdetail.model)," ") <> 0 THEN trim(SUBSTR(wdetail.model,1,INDEX(wdetail.model," "))) 
                          ELSE trim(wdetail.model).
    IF INTEGER(wdetail.engcc) = 0 THEN DO:
        IF wdetail.seat  = 0 THEN DO:
            FIND FIRST stat.maktab_fil USE-INDEX   maktab04  WHERE
                stat.maktab_fil.makdes   =     wdetail.brand            AND                  
                INDEX(stat.maktab_fil.moddes,nv_modelred) <> 0          AND
                stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
                /*stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND*/
                stat.maktab_fil.sclass   =     SUBSTRING(wdetail.class,2,3)      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE wdetail.si   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE wdetail.si ) /*AND
                stat.maktab_fil.seats    =   wdetail.seat */    NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL stat.maktab_fil  THEN 
                ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.engcc    =  string(stat.maktab_fil.engine)
                wdetail.weight   =  string(stat.maktab_fil.tons) .
        END.
        ELSE DO:
            FIND FIRST stat.maktab_fil USE-INDEX   maktab04  WHERE
                stat.maktab_fil.makdes   =     wdetail.brand            AND                  
                INDEX(stat.maktab_fil.moddes,nv_modelred) <> 0          AND
                stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
                /*stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND*/
                stat.maktab_fil.sclass   =     SUBSTRING(wdetail.class,2,3)      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE wdetail.si   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE wdetail.si ) AND
                stat.maktab_fil.seats    =   wdetail.seat     NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL stat.maktab_fil  THEN 
                ASSIGN
                nv_modcod        =  stat.maktab_fil.modcod                                    
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.engcc    =  string(stat.maktab_fil.engine)
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.weight   =  string(stat.maktab_fil.tons).
        END.
    END.
    ELSE DO:
        IF wdetail.seat <> 0 THEN DO:   /*A59-0182*/
            FIND FIRST stat.maktab_fil USE-INDEX      maktab04         WHERE
                stat.maktab_fil.makdes   =     wdetail.brand            AND                  
                INDEX(stat.maktab_fil.moddes,nv_modelred) <> 0          AND
                stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
                stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     SUBSTRING(wdetail.class,2,3)      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE wdetail.si   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE wdetail.si ) AND
                stat.maktab_fil.seats    =   wdetail.seat     NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL stat.maktab_fil  THEN 
                ASSIGN
                nv_modcod        =  stat.maktab_fil.modcod                                    
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.engcc    =  string(stat.maktab_fil.engine)
                wdetail.weight   =  string(stat.maktab_fil.tons).
        END.
        /*-- Create by A59-0182--*/
        ELSE DO:
            FIND FIRST stat.maktab_fil USE-INDEX   maktab04  WHERE
                stat.maktab_fil.makdes   =     wdetail.brand            AND                  
                INDEX(stat.maktab_fil.moddes,nv_modelred) <> 0          AND
                stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
                stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     SUBSTRING(wdetail.class,2,3)      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE wdetail.si   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE wdetail.si ) /*AND
                stat.maktab_fil.seats    =   wdetail.seat */    NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL stat.maktab_fil  THEN 
                ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.redbook  =  stat.maktab_fil.modcod
                wdetail.engcc    =  string(stat.maktab_fil.engine)
                wdetail.weight   =  string(stat.maktab_fil.tons) .
        END.
       /*--End A59-0182--*/
    END.
    IF nv_modcod = ""  THEN  RUN proc_maktab.
END.   /*nv_modcod = blank*//*end note add &  modi*/
IF wdetail.class   <>  " " Then do:
    FIND FIRST  sicsyac.xmd031 USE-INDEX xmd03101   WHERE
        sicsyac.xmd031.poltyp =   wdetail.poltyp AND
        sicsyac.xmd031.class  =   wdetail.class   NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xmd031 THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| Not On Business Class xmd031" 
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
    FIND sicsyac.xmm016 USE-INDEX xmm01601 WHERE 
        sicsyac.xmm016.class =    wdetail.class  NO-LOCK NO-ERROR.
    IF NOT AVAILABLE sicsyac.xmm016 THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| Not on Business class on xmm016"
        wdetail.pass    = "N"    
        WDETAIL.OK_GEN  = "N".
    ELSE 
        ASSIGN wdetail.tariff  =  sicsyac.xmm016.tardef
            no_class           =  sicsyac.xmm016.class
            nv_sclass          =  SUBSTR(no_class,2,3).
END.
FIND sicsyac.sym100 USE-INDEX sym10001       WHERE
    sicsyac.sym100.tabcod = "u014"          AND 
    sicsyac.sym100.itmcod =  wdetail.vehuse NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Not on Vehicle Usage Codes table sym100 u014"
    wdetail.pass    = "N" 
    WDETAIL.OK_GEN  = "N".
FIND  sicsyac.sym100 USE-INDEX sym10001  WHERE
    sicsyac.sym100.tabcod = "u013"         AND
    sicsyac.sym100.itmcod = wdetail.covcod NO-LOCK NO-ERROR NO-WAIT.
IF NOT AVAIL sicsyac.sym100 THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Not on Motor Cover Type Codes table sym100 u013"
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N".
/*---------- fleet -------------------*/
IF INTE(wdetail.fleet) <> 0 AND INTE(wdetail.fleet) <> 10 THEN 
    ASSIGN wdetail.comment = wdetail.comment + "| Fleet Percent must be 0 or 10. "
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N".
/*----------  access -------------------*//*
If  wdetail.access  =  "y"  Then do:  
 If  nv_sclass  =  "320"  Or  nv_sclass  =  "340"  Or
     nv_sclass  =  "520"  Or  nv_sclass  =  "540"  
     Then  wdetail.access  =  "y".         
 Else do:
     Message "Class "  nv_sclass "ไม่รับอุปกรณ์เพิ่มพิเศษ"  View-as alert-box.
     ASSIGN
         wdetail2.comment = wdetail2.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ"
         wdetail2.pass    = "N"    
         WDETAIL2.OK_GEN  = "N".
 End.
END.   -------------A52-0172*/
/*----------  ncb -------------------*/
IF  (DECI(wdetail.ncb) = 0 )  OR (DECI(wdetail.ncb) = 20 ) OR
    (DECI(wdetail.ncb) = 30 ) OR (DECI(wdetail.ncb) = 40 ) OR
    (DECI(wdetail.ncb) = 50 )    THEN DO:

END.
ELSE 
    ASSIGN
        wdetail.comment = wdetail.comment + "| not on NCB Rates file xmm104."
        wdetail.pass    = "N"   
        WDETAIL.OK_GEN  = "N".
ASSIGN NV_NCBPER = INTE(WDETAIL.NCB).
If nv_ncbper  <> 0 Then do:
    FIND FIRST sicsyac.xmm104 USE-INDEX xmm10401 WHERE
        sicsyac.xmm104.tariff = wdetail.tariff  AND
        sicsyac.xmm104.class  = wdetail.class   AND
        sicsyac.xmm104.covcod = wdetail.covcod  AND
        sicsyac.xmm104.ncbper = INTE(wdetail.ncb) NO-LOCK NO-ERROR NO-WAIT.
    IF NOT AVAIL  sicsyac.xmm104  THEN 
        ASSIGN wdetail.comment = wdetail.comment + "| This NCB Step not on NCB Rates file xmm104. "
        wdetail.pass    = "N"     
        WDETAIL.OK_GEN  = "N".
END.   /*ncb <> 0*/
/******* drivernam **********/
ASSIGN  nv_sclass = wdetail.class. 
If  wdetail.drivnam = "y" AND SUBSTR(nv_sclass,2,1) = "2"   Then 
    ASSIGN wdetail.comment = wdetail.comment + "| CODE  nv_sclass Driver 's Name must be no. "
    wdetail.pass    = "N"    
    WDETAIL.OK_GEN  = "N".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chksum C-Win 
PROCEDURE proc_chksum :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:  Create by A59-0029     
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER n_policy LIKE sicuw.uwm130.policy.
DEFINE INPUT PARAMETER n_riskno LIKE sicuw.uwm130.riskno.
DEFINE INPUT PARAMETER n_itemno LIKE sicuw.uwm130.itemno.
DEFINE INPUT PARAMETER  nv_batchyr   AS INT    .
DEFINE INPUT PARAMETER  nv_batchno   AS CHARACTER .
DEFINE INPUT PARAMETER  nv_batcnt    AS INT          .

FIND LAST sic_bran.uwm130 USE-INDEX uwm13001 WHERE
          sic_bran.uwm130.policy = n_policy    AND
          sic_bran.uwm130.riskno = n_riskno    AND
          sic_bran.uwm130.itemno = n_itemno    AND
          sic_bran.uwm130.bchyr  = nv_batchyr  AND 
          sic_bran.uwm130.bchno  = nv_batchno  AND 
          sic_bran.uwm130.bchcnt = nv_batcnt    
    NO-LOCK NO-ERROR.
IF AVAIL  sic_bran.uwm130 THEN DO:
 IF sic_bran.uwm130.uom6_v <> sic_bran.uwm130.uom7_v THEN DO:
       MESSAGE "ONLY THEFT SUMINSURE not equal OTHER THAN THEFT SUMINSURE"
       View-as alert-box.
       Return.
  END.
END. 


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_chktons C-Win 
PROCEDURE proc_chktons :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO:
/* add by A63-0147 */
   ASSIGN sic_bran.uwm301.tons   = IF sic_bran.uwm301.tons = 0 THEN 0 ELSE IF sic_bran.uwm301.tons < 100 THEN (sic_bran.uwm301.tons * 1000) 
                                   ELSE sic_bran.uwm301.tons .

    IF sic_bran.uwm301.tons < 100  AND ( SUBSTR(wdetail.CLASS,2,1) = "3"   OR  
         SUBSTR(wdetail.CLASS,2,1) = "4"   OR  SUBSTR(wdetail.CLASS,2,1) = "5"  OR  
         SUBSTR(wdetail.CLASS,2,3) = "803" OR SUBSTR(wdetail.CLASS,2,3) = "804" OR  
         SUBSTR(wdetail.CLASS,2,3) = "805" ) THEN DO:

         MESSAGE  wdetail.CLASS + " ระบุน้ำหนักรถไม่ถูกต้อง " VIEW-AS ALERT-BOX.

           ASSIGN
                wdetail.comment = wdetail.comment + "| " + wdetail.CLASS + " ระบุน้ำหนักรถไม่ถูกต้อง "
                wdetail.pass    = "N"     
                wdetail.OK_GEN  = "N".

           ASSIGN wdetail.pass    = "N"  
        wdetail.comment = wdetail.comment + "| Renewal Count error"
        WDETAIL.OK_GEN  = "N".



   END.
   /* end A63-0147 */
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Clear C-Win 
PROCEDURE proc_Clear :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_dss_per   = 0     
    nv_dsspcvar1 = ""       nv_dsspcvar2 = ""
    nv_dsspcvar  = ""       nv_42cod     = ""
    nv_43cod     = ""       nv_41cod1    = ""
    nv_41cod2    = ""       nv_basecod   = ""
    nv_usecod    = ""       nv_engcod    = "" 
    nv_drivcod   = ""       nv_yrcod     = "" 
    nv_sicod     = ""       nv_grpcod    = "" 
    nv_bipcod    = ""       nv_biacod    = "" 
    nv_pdacod    = ""       nv_ncbyrs    = 0    
    nv_ncbper    = 0        nv_ncb       = 0
    nv_totsi     = 0        nv_basevar1  = ""        
    nv_basevar   = ""       nv_basevar2  = ""
    nv_baseprm   = 0        nv_gapprm    = 0
    nv_drivvar1  = ""       nv_drivvar2  = ""
    nv_drivvar   = ""       nv_caryr     = 0
    nv_yrvar1    = ""       nv_yrvar2    = ""
    nv_yrvar     = ""       
    nv_41        =  0       nv_42        = 0        
    nv_43        =  0       nv_seat41    = 0
    nv_411var1   = ""       nv_411var2   = ""  
    nv_411var    = ""       nv_412var1   = ""
    nv_412var2   = ""       nv_412var    = ""
    nv_411prm    = 0        nv_412prm    = 0
    nv_42var     = ""       nv_42var1    = "" 
    nv_42var2    = ""       nv_42var     = ""  
    nv_43var     = ""       nv_43prm     = 0 
    nv_43var1    = ""       nv_43var2    = "" 
    nv_43var     = ""       nv_sivar1    = ""       
    nv_sivar2    = ""       nv_sivar     = ""       
    nv_grpvar1   = ""       nv_grpvar2   = "" 
    nv_grpvar     = ""      nv_bipcod      = "" 
    nv_bipvar1    = ""      nv_bipvar2     = "" 
    nv_bipvar     = ""      nv_biacod      = "" 
    nv_biavar1    = ""      nv_biavar2     = "" 
    nv_biavar     = ""      nv_pdacod      = "" 
    nv_pdavar1    = ""      nv_pdavar2     = "" 
    nv_pdavar     = ""      nv_ded1prm     = 0
    nv_dedod1_prm = 0       nv_dedod1_cod  = ""
    nv_dedod1var1 = ""      nv_dedod1var2  = "" 
    nv_dedod1var  = ""      nv_dedpd_cod   = "" 
    nv_dedpdvar1  = ""      nv_dedpdvar2   = "" 
    nv_dedpdvar   = ""      nv_dedpd_prm   = 0 
    nv_flet_per   = 0       nv_flet        = 0
    nv_fletvar    = ""      nv_fletvar     = ""
    nv_fletvar1   = ""      nv_fletvar2    = "" 
    nv_fletvar    = ""      nv_ncbvar1     = ""
    nv_ncbvar2    = ""      nv_ncbvar      = "".
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clear1 C-Win 
PROCEDURE proc_clear1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_dss_per   = 0     
    nv_dsspcvar1 = ""       nv_dsspcvar2 = ""   nv_bipvar1    = ""      nv_bipvar2     = ""  
    nv_dsspcvar  = ""       nv_42cod     = ""   nv_bipvar     = ""      nv_biacod      = ""  
    nv_43cod     = ""       nv_41cod1    = ""   nv_biavar1    = ""      nv_biavar2     = ""  
    nv_41cod2    = ""       nv_basecod   = ""   nv_biavar     = ""      nv_pdacod      = ""  
    nv_usecod    = ""       nv_engcod    = ""   nv_pdavar1    = ""      nv_pdavar2     = ""  
    nv_drivcod   = ""       nv_yrcod     = ""   nv_pdavar     = ""      nv_ded1prm     = 0   
    nv_sicod     = ""       nv_grpcod    = ""   nv_dedod1_prm = 0       nv_dedod1_cod  = ""  
    nv_bipcod    = ""       nv_biacod    = ""   nv_dedod1var1 = ""      nv_dedod1var2  = ""  
    nv_pdacod    = ""       nv_ncbyrs    = 0    nv_dedod1var  = ""      nv_dedpd_cod   = ""  
    nv_ncbper    = 0        nv_ncb       = 0    nv_dedpdvar1  = ""      nv_dedpdvar2   = ""  
    nv_totsi     = 0        nv_basevar1  = ""   nv_dedpdvar   = ""      nv_dedpd_prm   = 0        
    nv_basevar   = ""       nv_basevar2  = ""   nv_flet_per   = 0       nv_flet        = 0   
    nv_baseprm   = 0        nv_gapprm    = 0    nv_fletvar    = ""      nv_fletvar     = ""  
    nv_drivvar1  = ""       nv_drivvar2  = ""   nv_fletvar1   = ""      nv_fletvar2    = ""  
    nv_drivvar   = ""       nv_caryr     = 0    nv_fletvar    = ""      nv_ncbvar1     = ""  
    nv_yrvar1    = ""       nv_yrvar2    = ""   nv_ncbvar2    = ""      nv_ncbvar      = ""
    nv_yrvar     = ""                           nv_43var      = ""      nv_43prm       = 0     
    nv_41        =  0       nv_42        = 0    nv_43var1     = ""      nv_43var2      = ""        
    nv_43        =  0       nv_seat41    = 0    nv_43var      = ""      nv_sivar1      = ""    
    nv_411var1   = ""       nv_411var2   = ""   nv_sivar2     = ""      nv_sivar       = ""    
    nv_411var    = ""       nv_412var1   = ""   nv_grpvar1    = ""      nv_grpvar2     = ""    
    nv_412var2   = ""       nv_412var    = ""   nv_grpvar     = ""      nv_bipcod      = ""  
    nv_411prm    = 0        nv_412prm    = 0    nv_42var2     = ""      nv_42var       = "" 
    nv_42var     = ""       nv_42var1    = "" .

ASSIGN 
   nv_batchyr  = 0    nv_batcnt = 0         nv_batrunno     = 0  
   nv_batrunno = 0    nv_imppol = 0         nv_imppol       = 0  
   Eapplino    = ""   E2driid2  = ""        nv_impprem      = 0  
   E2text14    = ""   Eeffecdat = ""        nv_batprev      = ""  
   E2sticker   = ""   Eexpirdat = ""        nv_tmppolrun    = 0  
   E2oldpol    = ""   E2make    = ""        nv_batbrn       = ""  
   E2instype   = ""   E2model   = ""        nv_tmppol       = ""  
   ENnam       = ""   E2YEAR    = ""        nv_rectot       = 0          
   THnam       = ""   E22lisen  = ""        nv_recsuc       = 0  
   E2text15    = ""   E2chassis = ""        nv_netprm_t     = 0  
   EAddress1   = ""   E2engine  = ""        nv_netprm_s     = 0  
   EAddress2   = ""   E2cc      = ""        nv_batflg       = NO  
   EAddress3   = ""   E2tonnage = ""        nv_txtmsg       = ""       
   EAddress4   = ""   E2seat    = ""        nv_accdat       = ? 
   E2text16    = ""   E2CVMI    = ""        nv_message      = ""
   E2drinam1   = ""   Esumins   = ""        nv_line1        = 0
   E2dribht1   = ""   Enetprm   = ""        nv_txt1         = "" 
   E2driage1   = ""   Egrossprm = ""        nv_txt2         = "" 
   E2dricr1    = ""   E2prmp    = ""        nv_txt3         = "" 
   E2driid1    = ""   E2totalp  = ""        nv_txt4         = "" 
   E2drinam2   = ""   E2Garage  = ""        nv_txt5         = "" 
   E2dribht2   = ""   E2access  = ""        nv_txt6         = "" 
   E2driage2   = ""   E2aecsdes = ""        nv_txt7         = "" 
   E2dricr2    = ""   E2text18  = ""        nv_txt8         = "" 
   nv_datwork  = ""   E2text17  = ""        nv_fptr         = 0 
   E2brach     = ""   E2poltype = ""        nv_bptr         = 0 
   ETel        = ""   nv_count  = 0         nv_undyr        = "" .
                                               
ASSIGN 
    nv_producer = ""    nv_engine       = 0     nv_41cod2       = ""        nv_compcod      = ""
    nv_agent    = ""    nv_tons         = 0     nv_42cod        = ""        nv_compprm      = 0
    nv_riskno   = 0     nv_seats        = 0     nv_43cod        = ""        nv_compvar1     = ""                    
    nv_itemno   = 0     nv_vehuse       = ""    nv_poltyp       = ""        nv_compvar2     = ""
    nv_row      = 0     nv_makdes       = ""    nv_uwm301trareg = ""        nv_compvar      = ""
    nv_polday   = 0     nv_moddes       = ""    nv_maxdes       = ""        n_curbil        = ""
    nv_uom6_u   = ""    nv_comacc       = 0     nv_mindes       = ""        nv_baseprm      = 0
    nv_othcod   = ""    nv_comper       = 0     nv_si           = 0         nv_gapprm       = 0
    nv_othprm   = 0     n_endcnt        = 0     nv_maxSI        = 0         nv_pdprm        = 0
    nv_othvar1  = ""    n_rencnt        = 0     nv_minSI        = 0         nv_basevar1     = ""
    nv_othvar2  = ""    nv_dept         = ""    chkred          = NO        nv_basevar2     = ""          
    nv_othvar   = ""    s_recid1        = 0     nv_modcod       = ""        nv_basevar      = ""       
    nv_sclass   = ""    s_recid2        = 0     nv_simat        = 0         nv_useprm       = 0       
    n_sclass72  = ""    s_recid3        = 0     nv_simat1       = 0         nv_usevar       = ""       
    nv_newsck   = ""    s_recid4        = 0     NO_CLASS        = ""        nv_grprm        = 0
    nv_uom1_v   = 0     nv_daily        = ""    nv_ncbyrs       = 0         nv_grpvar1      = ""
    nv_uom2_v   = 0     nv_reccnt       = 0     nv_basecod      = ""        nv_grpvar2      = ""
    nv_uom5_v   = 0     nv_completecnt  = 0     nv_usecod       = ""        nv_grpvar       = ""
    nv_tariff   = ""    chr_sticker     = ""    nv_ncb          = 0         nv_siprm        = 0
    nv_comdat   = ?     nv_modulo       = 0     nv_ncbper       = 0         nv_sivar        = ""
    nv_covcod   = ?     s_riskgp        = 0     nv_engcod       = ""        nv_engprm       = 0
    nv_class    = ""    s_riskno        = 0     nv_yrcod        = ""        nv_engvar       = ""
    nv_key_b    = 0     s_itemno        = 0     nv_yrprm        = 0         nv_bipprm       = 0
    nv_drivno   = 0     nv_dss_cod      = ""    nv_yrvar        = ""        nv_bipvar       = ""
    nv_drivcod  = ""    nv_dss_per      = 0     nv_sicod        = ""        nv_biaprm       = 0
    nv_drivprm  = 0     nv_dsspc        = 0     nv_grpcod       = ""        nv_biavar       = ""
    nv_drivvar1 = ""    nv_dsspcvar1    = ""    nv_bipcod       = ""        nv_pdaprm       = 0
    nv_drivvar2 = ""    nv_dsspcvar2    = ""    nv_biacod       = ""        nv_pdavar       = ""
    nv_drivvar  = ""    nv_dsspcvar     = ""    nv_pdacod       = ""        nv_41           = 0
    nv_provi    = ""    nv_41cod1       = ""    nv_totsi        = 0         nv_411prm       = 0.

ASSIGN
    nv_412prm       = 0      /*n_41          = 0 -- suthida t. A54-0010 -- */   nv_dedod2var1    = ""    nv_gap2       = 0 
    nv_411var       = ""     /*n_42          = 0 -- suthida t. A54-0010 -- */   nv_dedod2var2    = ""    nv_prem2      = 0 
    nv_412var       = ""     /*n_43          = 0 -- suthida t. A54-0010 -- */   nv_dedpdvar1     = ""    nv_rstp       = 0 
    nv_42           = 0      nv_seat41     = 0         nv_dedpdvar2     = ""    nv_rtax       = 0 
    nv_42prm        = 0      nv_411var1    = ""        nv_fletvar1      = ""    nv_com1_per   = 0 
    nv_42var        = ""     nv_411var2    = ""        nv_fletvar2      = ""    nv_com1_prm   = 0
    nv_43           = 0      nv_412var1    = ""        nv_ncbvar1       = ""                       
    nv_43prm        = 0      nv_412var2    = ""        nv_ncbvar2       = ""                                                   
    nv_43var        = ""     nv_42var1     = ""        nv_addprm        = 0                                                    
    nv_campcod      = ""     nv_42var2     = ""        nv_engvar1       = ""                                                    
    nv_camprem      = 0      nv_43var1     = ""        nv_engvar2       = ""                                                    
    nv_campvar      = ""     nv_43var2     = ""        nv_prvprm        = 0                         
    nv_dedod1_cod   = ""     nv_usevar1    = ""        nv_41prm         = 0                         
    nv_dedod1_prm   = 0      nv_usevar2    = ""        nv_dedod         = 0                         
    nv_dedod1var    = ""     nv_yrvar1     = ""        nv_addod         = 0                         
    nv_dedod2_cod   = ""     nv_yrvar2     = ""        nv_dedpd         = 0                         
    nv_dedod2_prm   = 0      nv_caryr      = 0         nv_totded        = 0                         
    nv_dedod2var    = ""     nv_sivar1     = ""        nv_totdis        = 0                         
    nv_dedpd_cod    = ""     nv_sivar2     = ""        nv_drivage1      = 0                         
    nv_dedpd_prm    = 0      nv_uom6_c     = ""        nv_drivage2      = 0                         
    nv_dedpdvar     = ""     nv_uom7_c     = ""        nv_drivbir1      = ""                        
    nv_flet_cod     = ""     nv_bipvar1    = ""        nv_drivbir2      = ""                        
    nv_flet_per     = 0      nv_bipvar2    = ""        no_baseprm       = 0                         
    nv_flet         = 0      nv_biavar1    = ""        NO_basemsg       = ""                        
    nv_fletvar      = ""     nv_biavar2    = ""        nv_docno         = ""                        
    nv_ncb_cod      = ""     nv_pdavar1    = ""        nv_lnumber       = 0                         
    nv_ncbvar       = ""     nv_pdavar2    = ""        nv_rec100        = 0                         
    nv_cl_cod       = ""     nv_odcod      = ""        nv_rec120        = 0                         
    nv_cl_per       = 0      nv_prem       = 0         nv_rec130        = 0                         
    nv_lodclm       = 0      nv_chk        = NO        nv_rec301        = 0                         
    nv_lodclm1      = 0      nv_baseap     = 0         nv_gap           = 0                         
    nv_clmvar       = ""     nv_ded1prm    = 0         nvffptr          = 0                         
    nv_stf_cod      = ""     nv_aded1prm   = 0         s_130bp1         = 0                         
    nv_stf_per      = 0      nv_ded2prm    = 0         s_130fp1         = 0                         
    nv_stf_amt      = 0      nv_dedod1var1 = ""        n_rd132          = 0                         
    nv_stfvar       = ""     nv_dedod1var2 = ""        nv_key_a         = 0                         
    nv_basere       = 0      nv_cons       = ""        nv_stm_per       = 0                         
    nv_prem1        = 0      nv_ded        = 0         nv_tax_per       = 0.                        
                                                                                                                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_clear3 C-Win 
PROCEDURE proc_clear3 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN 
    E2brach     = ""  /*สาขา                         */     /*1*/
    Eapplino    = ""  /*เลขที่ใบคำขอ                 */     /*2*/
    E2text14    = ""  /*เลขที่รับแจ้ง                */     /*3*/
    E2sticker   = ""  /*เลขที่สติ๊กเกอร์             */     /*4*/
    E2oldpol    = ""  /*เลขที่กรมธรรม์เดิม           */     /*5*/
    E2instype   = ""  /*ประเภทความคุ้มครอง           */     /*6*/
    E2poltype   = ""  /*ประเภทงานที่แจ้ง             */     /*7*/
    ENnam       = ""  /*คำนำหน้าชื่อผู้เอาประกันภัย  */     /*8*/
    THnam       = ""  /*ชื่อผู้เอาประกันภัย          */     /*9*/
    E2text15    = ""  /*รถประจำตำแหน่ง               */     /*10*/
    E2occup     = ""   
    E2idno      = ""   
    EAddress1   = ""  /*ที่อยู่                     */     /*11*/ 
    EAddress2   = ""  /*ที่อยู่                     */     /*12*/ 
    EAddress3   = ""  /*ที่อยู่                     */     /*13*/ 
    EAddress4   = ""  /*ที่อยู่                     */     /*14*/ 
    ETel        = ""  /*ที่อยู่                     */     /*15*/ 
    E2text16    = ""  /*ชื่อที่ออกใบกำกับภาษี        */     /*16*/ 
    E2text17    = ""  /*ที่อยู่ออกใบกำกับภาษี        */     /*17*/ 
    E2drinam1   = ""  /*ชื่อ/นามสกุล1                */     /*18*/ 
    E2dribht1   = ""  /*วัน/เดือน/ปีเกิด 1           */     /*19*/ 
    E2driage1   = ""  /*อายุ1                        */     /*20*/
    E2dricr1    = ""  /*เลขที่บัตรประชาชน 1          */     /*21*/
    E2driid1    = ""  /*เลขที่ใบขับขี่1              */     /*22*/
    E2drinam2   = ""  /*ชื่อ/นามสกุล 2               */     /*23*/
    E2dribht2   = ""  /*วัน/เดือน/ปีเกิด2            */     /*24*/
    E2driage2   = ""  /*อายุ2                        */     /*25*/
    E2dricr2    = ""  /*เลขที่บัตรประชาชน 2          */     /*26*/
    E2driid2    = ""  /*เลขที่ใบขับขี่2              */     /*27*/
    Eeffecdat   = ""  /*วันที่เริ่มคุ้มครอง"         */     /*28*/
    Eexpirdat   = ""  /*วันที่สิ้นสุด "              */     /*29*/
    E2make      = ""  /*ยี่ห้อ"                      */     /*30*/
    E2model     = ""  /*รุ่น"                        */     /*31*/ 
    E2YEAR      = ""  /*ปีที่จดทะเบียน"              */     /*32*/ 
    E22lisen    = ""  /*ทะเบียนรถ"                   */     /*33*/ 
    E2chassis   = ""  /*เลขตัวถัง"                   */     /*34*/ 
    E2engine    = ""  /*เลขเครื่องยนต์ "             */     /*35*/ 
    E2cc        = ""  /*ขนาดเครื่องยนต์"             */     /*36*/ 
    E2tonnage   = ""  /*น้ำหนัก"                     */     /*37*/ 
    E2seat      = ""  /*จำนวนที่นั่ง"                */     /*38*/ 
    E2CVMI      = ""  /*ลักษณะการใช้งาน"             */     /*39*/ 
    Esumins     = ""   /*ทุนประกัน "                  */     /*40*/ 
    Enetprm     = ""   /*"เบี้ยสุทธิ "                 */    /*41*/ 
    Egrossprm   = ""   /*"เบี้ยรวมภาษีอากร"            */    /*42*/ 
    E2prmp      = ""   /*"เบี้ยพรบ"                    */    /*43*/ 
    E2totalp    = ""   /*"เบี้ยรวมพรบ"                 */    /*44*/ 
    E2Garage    = ""   /*"ซ่อม(0:อู่ห้าง,1:อู่ในเครือ)" */   /*45*/ 
    E2access    = ""   /*"อุปกรณ์เสริม"                 */   /*46*/ 
    E2aecsdes   = ""   /*"รายละเอียดอุปกรณ์เสริม"       */   /*47*/ 
    E2text18    = ""   /*"หมายเหตุ"                     */  /*48*/ 
    E2CV_perbi  = ""   /*A57-0244*/ 
    E2CV_perac  = ""   /*A57-0244*/   
    E2CV_perpd  = ""   /*A57-0244*/
    E2CV_41     = ""    /*A57-0244*/
    E2CV_42     = ""    /*A57-0244*/   
    E2CV_43     = ""    /*A57-0244*/
    E2textco    = ""    /*A57-0244*/  
    E2CV_poltyp = ""   /* A57-0244 Add poltype */
    benefic     = ""    /*a59-0182*/
    n_producer  = ""    /*a59-0182*/
    n_agent     = ""    /*a59-0182*/
    n_payment   = ""    /*a59-0182*/
    n_track     = ""    /*a59-0182*/
    n_promo     = ""    /*a59-0182*/
    n_campaign_ov = ""  /*Add by Kridtiya i. A63-0472*/
    n_postcd    = ""    /*Add by Kridtiya i. A63-0472*/
    n_codeocc   = ""    /*Add by Kridtiya i. A63-0472*/
    n_codeaddr1 = ""    /*Add by Kridtiya i. A63-0472*/
    n_codeaddr2 = ""    /*Add by Kridtiya i. A63-0472*/
    n_codeaddr3 = ""    /*Add by Kridtiya i. A63-0472*/
    nv_color    = "".   /*A66-0108*/


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_colorcode C-Win 
PROCEDURE proc_colorcode :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR np_colorcode AS CHAR INIT "".
np_colorcode = "".

IF wdetail.ncolor <> "" THEN DO:
        FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
            sym100.tabcod = "U118"  AND 
            sym100.itmcod = trim(wdetail.ncolor)  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
        ELSE DO:
            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                sym100.tabcod = "U118"  AND 
                sym100.itmdes = trim(wdetail.ncolor) 
                NO-LOCK NO-ERROR NO-WAIT.
            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
            ELSE DO:
                FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                    sym100.tabcod = "U118"  AND 
                    index(sym100.itmdes,trim(wdetail.ncolor)) <> 0  
                    NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                ELSE DO:
                    FIND LAST sicsyac.sym100 USE-INDEX sym10001 WHERE 
                        sym100.tabcod = "U119"  AND 
                        sym100.itmcod = trim(wdetail.ncolor)  NO-LOCK NO-ERROR NO-WAIT.
                    IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                    ELSE DO:
                        FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                            sym100.tabcod = "U119"  AND 
                            sym100.itmdes = trim(wdetail.ncolor)  
                            NO-LOCK NO-ERROR NO-WAIT.
                        IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                        ELSE DO:
                            FIND FIRST sicsyac.sym100 USE-INDEX sym10002 WHERE 
                                sym100.tabcod = "U119"  AND 
                                index(sym100.itmdes,trim(wdetail.ncolor)) <> 0  
                                NO-LOCK NO-ERROR NO-WAIT.
                            IF AVAIL sym100 THEN ASSIGN np_colorcode = TRIM(sym100.itmcod).
                        END.
                    END.
                END.
            END.
        END.
END.
wdetail.ncolor = np_colorcode.


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_compprm C-Win 
PROCEDURE proc_compprm :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_recid1 NO-WAIT NO-ERROR.
FIND sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_recid2 NO-WAIT NO-ERROR.
FIND sic_bran.uwm130 WHERE RECID(sic_bran.uwm130) = s_recid3 NO-WAIT NO-ERROR.
FIND sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_recid4 NO-WAIT NO-ERROR.
ASSIGN 
     dod1 = 0   dod2 = 0     dpd0 = 0    /*add A64-0138*/
    nv_tariff    = sic_bran.uwm301.tariff
    nv_class     = wdetail.class 
    nv_comdat    = sic_bran.uwm100.comdat
    nv_key_b     = 0.00
    nv_engine    = DECI(wdetail.engcc)
    nv_tons      = DECI(wdetail.weight)
    nv_covcod    = wdetail.covcod
    nv_vehuse    = wdetail.vehuse
    nv_COMPER    = DECI(wdetail.comper) 
    nv_comacc    = DECI(wdetail.comacc) 
    nv_seats     = INTE(wdetail.seat)
    nv_tons      = DECI(wdetail.weight) .
/* RUN proc_Clear.  /*clear ตัวแปร*/ ----- suthida T. A54-0010 21-06-111 */
IF wdetail.compul = "y" THEN DO:
    ASSIGN
        nv_comper     = DECI(sicsyac.xmm016.si_d_t[8]) 
        nv_comacc     = DECI(sicsyac.xmm016.si_d_t[9])                                           
        sic_bran.uwm130.uom8_v   = nv_comper    /*600*/
        sic_bran.uwm130.uom9_v   = nv_comacc  
        nv_vehuse = "0" . 
    RUN wgs\wgscomp. 
    IF  nv_comper  =  0  THEN   nv_comacc =  0 . 
    ELSE DO:
        IF   nv_comacc  <> 0  THEN DO:
            ASSIGN
                nv_compcod      = "COMP"
                nv_compvar1     = "     Compulsory  =   "
                nv_compvar2     = STRING(nv_comacc)
                SUBSTR(nv_compvar,1,30)   = nv_compvar1
                SUBSTR(nv_compvar,31,30)  = nv_compvar2.
            IF n_curbil = "bht" THEN
                nv_comacc = TRUNCATE(nv_comacc, 0).
            ELSE 
                nv_comacc = nv_comacc. 
                ASSIGN
                    sic_bran.uwm130.uom8_c  = "D8"
                    sic_bran.uwm130.uom9_c  = "D9". 
        END.
        ELSE ASSIGN          nv_compprm     = 0
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
RUN proc_calpremt.      /*A64-0138*/
RUN proc_adduwd132prem. /*A64-0138*/

FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
    ASSIGN 
     sic_bran.uwm100.prem_t = nv_gapprm
     sic_bran.uwm100.sigr_p = INTE(wdetail.si)
     sic_bran.uwm100.gap_p  = nv_gapprm.
     /* ----
     IF wdetail.pass <> "N" THEN  /* Pass */
         ASSIGN
           sic_bran.uwm100.impusrid = n_user   
           sic_bran.uwm100.impdat   = TODAY
           sic_bran.uwm100.imptim   = STRING(TIME,"HH:MM:SS")
           sic_bran.uwm100.impflg   = NO
           sic_bran.uwm100.imperr   = wdetail.comment. 
     ELSE /* Error */
        ASSIGN                                                 
          sic_bran.uwm100.impusrid = n_user                    
          sic_bran.uwm100.impdat   = TODAY                     
          sic_bran.uwm100.imptim   = STRING(TIME,"HH:MM:SS")   
          sic_bran.uwm100.impflg   = YES                        
          sic_bran.uwm100.imperr   = wdetail.comment.  
     ---- */
END.
FIND LAST sic_bran.uwm120 WHERE RECID(sic_bran.uwm120) = s_RECID2  NO-ERROR.
IF AVAIL  sic_bran.uwm120 THEN 
     ASSIGN
     sic_bran.uwm120.gap_r  = nv_gapprm
     sic_bran.uwm120.prem_r = nv_pdprm
     sic_bran.uwm120.sigr   = INTE(wdetail.si).
 
FIND LAST sic_bran.uwm301 WHERE RECID(sic_bran.uwm301) = s_RECID4  NO-ERROR.
IF AVAIL  sic_bran.uwm301 THEN 
    ASSIGN   
        /*sic_bran.uwm301.ncbper   = nv_ncbper */ /* A64-0138*/ 
        /*sic_bran.uwm301.ncbyrs   = nv_ncbyrs */ /* A64-0138*/ 
        sic_bran.uwm301.mv41seat = wdetail.seat41.
/*  
RUN WGS\WGSTN132(INPUT S_RECID3, 
                 INPUT S_RECID4).*//* A64-0138*/ 
/* A61-0269 */
nv_pdprm0 = 0.
IF nv_drivno <> 0  THEN DO:
     RUN wgw\wgwORPR0 (INPUT  nv_tariff,
                         nv_class,
                         nv_covcod,
                         nv_key_b,
                         nv_comdat,
                         nv_totsi,
                         uwm130.uom1_v,
                         uwm130.uom2_v,
                         uwm130.uom5_v,
                  OUTPUT nv_pdprm0).
     ASSIGN uwm301.actprm = nv_pdprm0. 
END.
/* end A61-0269*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_create100 C-Win 
PROCEDURE proc_create100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

CREATE  sic_bran.uwm100.   /*Create ฝั่ง gateway*/    
ASSIGN                                              
       sic_bran.uwm100.policy =  wdetail.policy
       sic_bran.uwm100.rencnt =  n_rencnt             
       sic_bran.uwm100.renno  =  "" 
       sic_bran.uwm100.endcnt =  n_endcnt
       sic_bran.uwm100.bchyr  =  nv_batchyr 
       sic_bran.uwm100.bchno  =  nv_batchno 
       sic_bran.uwm100.bchcnt =  nv_batcnt     .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_creatogw C-Win 
PROCEDURE proc_creatogw :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
-----------------------------------------------------------------------------*/
RUN proc_var.
LOOP_WDETAIL:
FOR EACH wdetail:
    IF  wdetail.policy = ""  THEN NEXT.
    /*------------------  renew ---------------------*/
    RUN proc_cr_2.
    ASSIGN  n_rencnt   = 0        n_endcnt = 0    
             /* add by: A61-0269*/  
            n_driver   = ""      nv_drivno   = 0      dod1       = 0        dod2       = 0         
            dod0       = 0       nv_flet_per = 0      nv_dss_per = 0        nv_cl_per  = 0        
            nv_stf_per = 0       n_uom1_v    = 0      n_uom2_v   = 0        n_uom5_v   = 0      
            n_uom7_v   = 0       n_bennam1   = ""     n_prmtxt   = ""       n_driver   = ""     
            nv_basere  = 0       n_promo     = ""      /*A63-0162*/
            nv_insref  = "".     /*A65-0040*/
            /* end A61-0269*/
    /*comment by Kridtiya i. A66-0108
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    IF      wdetail.producer = "A0M0032"    THEN Assign wdetail.producer = "B3MLKL0101" wdetail.financecd = "FKL" wdetail.campaign_ov = "USED".       /*use car*/
    ELSE IF wdetail.producer = "A0M0054"    THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "RENEW".      /*ต่ออายุ*/  
    ELSE IF wdetail.producer = "A0M0054"    THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "TRANSF".     /*โอนย้าย*/ 
    ELSE IF wdetail.producer = "A0M0068"    THEN Assign wdetail.producer = "B3MLKL0103" wdetail.financecd = "FKL" wdetail.campaign_ov = "REDPLATE".   /*ป้ายแดง*/
    ELSE IF wdetail.producer = "A0M0071"    THEN Assign wdetail.producer = "B3MLKL0104" wdetail.financecd = "FKL" wdetail.campaign_ov = "MBREDPLATE".   /*ป้ายแดง*/ 
    ELSE IF wdetail.producer = "A0M0071"    THEN Assign wdetail.producer = "B3MLKL0104" wdetail.financecd = "FKL" wdetail.campaign_ov = "MBRENEW".    /*ต่ออายุ*/
    ELSE IF wdetail.producer = "A0M0127"    THEN Assign wdetail.producer = "B3MLKL0105" wdetail.financecd = "FKL" wdetail.campaign_ov = "BBREDPLATE".   /*ป้ายแดง*/ 
    ELSE IF wdetail.producer = "A0M0127"    THEN Assign wdetail.producer = "B3MLKL0105" wdetail.financecd = "FKL" wdetail.campaign_ov = "BBRENEW".    /*ต่ออายุ*/
    ELSE IF wdetail.producer = "A0M0134"    THEN Assign wdetail.producer = "B3MLKL0106" wdetail.financecd = "FKL" wdetail.campaign_ov = "ISREDPLATE".   /*ป้ายแดง*/ 
    ELSE IF wdetail.producer = "B3M0056"    THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "RENEW".      /*ต่ออายุ*/
    ELSE IF wdetail.producer = "B3M0056"    THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "TRANSF".     /*โอนย้าย*/
    ELSE IF wdetail.producer = "B3MLKL0101" THEN Assign wdetail.producer = "B3MLKL0101" wdetail.financecd = "FKL" wdetail.campaign_ov = "USED".       /*use car*/
    ELSE IF wdetail.producer = "B3MLKL0102" THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "RENEW".      /*ต่ออายุ*/  
    ELSE IF wdetail.producer = "B3MLKL0102" THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "TRANSF".     /*โอนย้าย*/ 
    ELSE IF wdetail.producer = "B3MLKL0103" THEN Assign wdetail.producer = "B3MLKL0103" wdetail.financecd = "FKL" wdetail.campaign_ov = "REDPLATE".   /*ป้ายแดง*/
    ELSE IF wdetail.producer = "B3MLKL0104" THEN Assign wdetail.producer = "B3MLKL0104" wdetail.financecd = "FKL" wdetail.campaign_ov = "MBREDPLATE".   /*ป้ายแดง*/ 
    ELSE IF wdetail.producer = "B3MLKL0104" THEN Assign wdetail.producer = "B3MLKL0104" wdetail.financecd = "FKL" wdetail.campaign_ov = "MBRENEW".    /*ต่ออายุ*/
    ELSE IF wdetail.producer = "B3MLKL0105" THEN Assign wdetail.producer = "B3MLKL0105" wdetail.financecd = "FKL" wdetail.campaign_ov = "BBREDPLATE".   /*ป้ายแดง*/ 
    ELSE IF wdetail.producer = "B3MLKL0105" THEN Assign wdetail.producer = "B3MLKL0105" wdetail.financecd = "FKL" wdetail.campaign_ov = "BBRENEW".    /*ต่ออายุ*/
    ELSE IF wdetail.producer = "B3MLKL0106" THEN Assign wdetail.producer = "B3MLKL0106" wdetail.financecd = "FKL" wdetail.campaign_ov = "ISREDPLATE".   /*ป้ายแดง*/ 
    ELSE IF wdetail.producer = "B3MLKL0201" THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "RENEW".      /*ต่ออายุ*/
    ELSE IF wdetail.producer = "B3MLKL0201" THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "TRANSF".     /*โอนย้าย*/
    IF      wdetail.agent = "B3M0025" THEN wdetail.agent = "B3MLKL0100".
    ELSE IF wdetail.agent = "B3M0056" THEN wdetail.agent = "B3MLKL0200".  end. comment by Kridtiya i. A66-0108*/
    wdetail.campaign_ov = wdetail.producer.
    wdetail.financecd   = "FKL".
    RUN proc_susspect.
    RUN proc_colorcode.
    /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
    /* IF TRIM(SUBSTRING(wdetail.policy,1,2))  = "RW" AND wdetail.prepol <> ""   THEN RUN proc_renew.          --- suthida T. A54-0010 ---- */
    /* IF wdetail.stk <> " " OR wdetail.covcod = "T" THEN DO: --------- suthida T. A54-0010 29-06-11 --------- */
    IF (wdetail.poltyp = "V72") OR (wdetail.poltyp = "V74") OR wdetail.covcod = "T" THEN DO:   /* --------- suthida T. A54-0010 29-06-11 --------- */
        RUN proc_72.
        RUN proc_policy.
        RUN proc_722.
        RUN proc_723 (INPUT  s_recid1,       
                      INPUT  s_recid2,
                      INPUT  s_recid3,
                      INPUT  s_recid4,
                      INPUT-OUTPUT nv_message).
        RUN Proc_flgerror.
        NEXT.
    END.
    ELSE DO:
        IF TRIM(SUBSTRING(wdetail.applino,1,2)) = "RW" AND wdetail.prepol <> ""   THEN RUN proc_renew.  /* --- suthida T. A54-0010 29-06-11 ----*/
        /*ELSE IF TRIM(SUBSTRING(wdetail.applino,1,2))  = "RW" AND wdetail.prepol  =  ""   THEN RUN proc_assignrenew2.*/  /* --- suthida T. A54-0010 28-06-11 ----*/
        RUN proc_chkdata. /*RUN proc_chktest0.*/
        /*IF wdetail.prepol  <> "" THEN DO:
            IF      wdetail.producer = "A0M0054"    THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "RENEW".   /*ต่ออายุ*/ 
            ELSE IF wdetail.producer = "A0M0071"    THEN Assign wdetail.producer = "B3MLKL0104" wdetail.financecd = "FKL" wdetail.campaign_ov = "MBRENEW". /*ต่ออายุ*/
            ELSE IF wdetail.producer = "A0M0127"    THEN Assign wdetail.producer = "B3MLKL0105" wdetail.financecd = "FKL" wdetail.campaign_ov = "BBRENEW". /*ต่ออายุ*/
            ELSE IF wdetail.producer = "B3M0056"    THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "RENEW".   /*ต่ออายุ*/
            ELSE IF wdetail.producer = "B3MLKL0102" THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "RENEW".   /*ต่ออายุ*/ 
            ELSE IF wdetail.producer = "B3MLKL0104" THEN Assign wdetail.producer = "B3MLKL0104" wdetail.financecd = "FKL" wdetail.campaign_ov = "MBRENEW". /*ต่ออายุ*/
            ELSE IF wdetail.producer = "B3MLKL0105" THEN Assign wdetail.producer = "B3MLKL0105" wdetail.financecd = "FKL" wdetail.campaign_ov = "BBRENEW". /*ต่ออายุ*/
            ELSE IF wdetail.producer = "B3MLKL0201" THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "RENEW".   /*ต่ออายุ*/
        END.                                                                                                                                        
        ELSE DO:                                                                                                                                    
            IF      wdetail.producer = "A0M0054"    THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "TRANSF".  /*โอนย้าย*/ 
            ELSE IF wdetail.producer = "B3M0056"    THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "TRANSF".  /*โอนย้าย*/
            ELSE IF wdetail.producer = "B3MLKL0102" THEN Assign wdetail.producer = "B3MLKL0102" wdetail.financecd = "FKL" wdetail.campaign_ov = "TRANSF".  /*โอนย้าย*/ 
            ELSE IF wdetail.producer = "B3MLKL0201" THEN Assign wdetail.producer = "B3MLKL0201" wdetail.financecd = "FKB" wdetail.campaign_ov = "TRANSF".  /*โอนย้าย*/
        END.*/
    END.
    RUN proc_chkcode. /* A64-0138*/
    RUN proc_policy.    /*  RUN proc_policy .  */
    RUN proc_uwm130.    /*  RUN proc_chktest2. */ 
    RUN proc_compprm.   /*  RUN proc_chktest3. */
    RUN proc_uwm120.    /*  RUN proc_chktest4. */
    RUN Proc_flgerror.  /*  Update flag Error Import*/   
    
END.     /*for each*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_creatpara C-Win 
PROCEDURE proc_creatpara :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FOR EACH wcampaign.   
    DELETE wcampaign.   
END.
FIND LAST wcampaign WHERE wcampaign.campno =  brstat.insure.insno  NO-ERROR NO-WAIT.
    IF NOT AVAIL wcampaign THEN DO:
        FOR EACH brstat.insure USE-INDEX insure02 WHERE brstat.insure.insno = trim(fi_packnew) AND 
                               brstat.insure.compno = TRIM(fi_packnew)  NO-LOCK BREAK BY brstat.insure.vatcode.
        CREATE wcampaign.
        ASSIGN
            wcampaign.campno = brstat.insure.insno 
            wcampaign.id     = brstat.insure.icaddr2        /*class*/
            wcampaign.cover  = brstat.insure.vatcode      /* cover */  
            wcampaign.pack   = brstat.insure.text3          /*pack */
            wcampaign.bi     = brstat.insure.Lname         /*tp1*/
            wcampaign.pd1    = brstat.insure.addr1         /*tp2*/
            wcampaign.pd2    = brstat.insure.addr2         /*tp3*/
            wcampaign.n41    = brstat.insure.addr3         /*n_41*/
            wcampaign.n42    = brstat.insure.addr4         /*n_42*/
            wcampaign.n43    = brstat.insure.telno         /*n_43*/
            wcampaign.garage = brstat.Insure.text1         /* garage */
            wcampaign.nname  = brstat.insure.text2       /* Detail */
            wcampaign.assino = brstat.insure.Text4 . 
        
    END.
    RELEASE brstat.insure.
END.

OPEN QUERY br_cam FOR EACH wcampaign .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_cr_2 C-Win 
PROCEDURE proc_cr_2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF BUFFER buwm100 FOR wdetail.

FOR EACH buwm100 WHERE 
         buwm100.poltyp <> wdetail.poltyp   AND 
         buwm100.chasno =  trim(wdetail.chasno) NO-LOCK . /*A62-0435*/
         /*buwm100.applino = wdetail.applino  NO-LOCK.*/ /*a62-0435*/
    ASSIGN
        wdetail.cr_2   = buwm100.policy.
    IF wdetail.poltyp = "V72" THEN wdetail.producer = trim(buwm100.producer) . /*a62-0435*/
    IF wdetail.branch = " " THEN wdetail.branch = SUBSTRING(buwm100.policy,2,1).             
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_defination C-Win 
PROCEDURE Proc_defination :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*MOdify By  : Suthida T. A52-0275  Date 20-09-10
             -> ปรับโปรแกรมเกรมเนื่องจากใช้งานแล้วช้าทำการตรวจสอบพบว่าใช้ INDEX ผิดค่               
MOdify By  : Suthida T. A52-0275  Date 27-09-10
             ->  Error Sticker 
             -> ** Value too large for integer. (78)
MOdify By  : Suthida T. A54-0010  Date 20-01-11
             ->  นิติบุคคลให้โค้ดเป็น MC_____ ดูเฉพาะชื่อผู้เอาประกันไม่ดูกรณีแถม และ/หรือ
             ->  กรณีแถม และ/หรือ เว้นวรรค ตามด้วยชื่อที่ออกใบกำกับภาษี
             ->  ส่วนของ Benificiary เพิ่ม บริษัท ลีสซิ่งกสิกรไทย จำกัด*/
/* Modify By : Narin L. ขยาย Format ระบุชื่อผู้ขับขี่ [A54-0396]  */ 
/*modify by : kridtiya i. A57-0244 ปรับแก้ไขproducer code         */
/* Modify By : Ranu I. A58-0372  30/09/2015                                                    */
/*             - แก้ไข  nv_policy = TRIM(SUBSTR(E2CV_poltyp,2,2)) + trim(Eapplino).            */
/*             - check Branch = "" ฟ้อม Message และรัน Proc_clear3                             */
/* Modify By : Ranu I. A59-0029  04/02/2016                                                    */
/*             - เพิ่มการเก็บข้อมูลอุปกรณ์เสริม ที่ Acc.text (F6)                              */ 
/*             - หากเป็นงานต่ออายุให้เลขสติ๊กเกอร์เป็นค่าว่าง                                  */ 
/*Modify by : Ranu I. A59-0182 Date 25/05/2016  เฉพาะงาน Renew (New form)                      
        - เพิ่มเติมช่อง BENEFICIARY(ผู้รับผลประโยชน์)
        - เก็บข้อมูลการจัดส่ง ใน (Memo Text หรือ Text F.8)    
        - เช็คสาขาจากเลขที่รับแจ้งตำแหน่งที่ 2,3 
        - ตรวจสอบเงื่อนไขการแสดงข้อมูล Pro-D ใน่ช่อง Promotion
        - เก็บข้อมูลในช่อง payment ไว้ที่ Product
        - เช็ค Garage = G  - เช็คการเก็บข้อมูลจากช่อง หมายเหตุ, ISP_NO , Campaign เนื่องจากเก็บข้อมูลไม่ครบ      */   
/*Modify by : Ranu I. A61-0269  date 25/06/2018 แก้ไขการ Check producer code งานใหม่ */ 
/*Modify by : Ranu I. A62-0435 date 20/09/2019 แก้ไขการเก็บข้อมูล nv_policy  */
/* Modify by : Ranu I. A63-0162 แก้ไข pack T และเช็คพารามิเตอร์ Pack งานต่ออายุ */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_flgerror C-Win 
PROCEDURE Proc_flgerror :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sic_bran.uwm100 WHERE RECID(sic_bran.uwm100) = s_RECID1 NO-ERROR.
IF AVAIL  sic_bran.uwm100 THEN DO:
   IF wdetail.pass = "N" THEN  /* Error */
       ASSIGN
         sic_bran.uwm100.impusrid = n_user   
         sic_bran.uwm100.impdat   = TODAY
         sic_bran.uwm100.imptim   = STRING(TIME,"HH:MM:SS")
         sic_bran.uwm100.impflg   = NO
         sic_bran.uwm100.imperr   = wdetail.comment. 
   ELSE /* Pass*/
      ASSIGN                                                 
        sic_bran.uwm100.impusrid = n_user                    
        sic_bran.uwm100.impdat   = TODAY                     
        sic_bran.uwm100.imptim   = STRING(TIME,"HH:MM:SS")   
        sic_bran.uwm100.impflg   = YES                        
        sic_bran.uwm100.imperr   = wdetail.comment.          
     
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_Import C-Win 
PROCEDURE proc_Import :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
INPUT FROM VALUE(fi_FileName).
REPEAT:
    IMPORT DELIMITER "|"
        E2brach           /*สาขา                       */     /*1*/
        Eapplino          /*เลขที่ใบคำขอ               */     /*2*/
        E2text14          /*เลขที่รับแจ้ง              */     /*3*/
        E2sticker         /*เลขที่สติ๊กเกอร์           */     /*4*/
        E2oldpol          /*เลขที่กรมธรรม์เดิม         */     /*5*/
        E2instype         /*ประเภทความคุ้มครอง         */     /*6*/
        E2poltype         /*ประเภทงานที่แจ้ง           */     /*7*/
        ENnam             /*คำนำหน้าชื่อผู้เอาประกันภัย*/     /*8*/
        THnam             /*ชื่อผู้เอาประกันภัย        */     /*9*/
        E2text15          /*รถประจำตำแหน่ง             */     /*10*/
        E2occup           /*A57-0244*/                 
        E2idno            /*A57-0244*/                 
        EAddress1         /*ที่อยู่                    */     /*11*/ 
        EAddress2         /*ที่อยู่                    */     /*12*/ 
        EAddress3         /*ที่อยู่                    */     /*13*/ 
        EAddress4         /*ที่อยู่                    */     /*14*/ 
        ETel              /*ที่อยู่                    */     /*15*/ 
        E2text16          /*ชื่อที่ออกใบกำกับภาษี      */     /*16*/ 
        E2text17          /*ที่อยู่ออกใบกำกับภาษี      */     /*17*/ 
        E2drinam1         /*ชื่อ/นามสกุล1              */     /*18*/ 
        E2dribht1         /*วัน/เดือน/ปีเกิด 1         */     /*19*/ 
        E2driage1         /*อายุ1                      */     /*20*/
        E2dricr1          /*เลขที่บัตรประชาชน 1        */     /*21*/
        E2driid1          /*เลขที่ใบขับขี่1            */     /*22*/
        E2drinam2         /*ชื่อ/นามสกุล 2             */     /*23*/
        E2dribht2         /*วัน/เดือน/ปีเกิด2          */     /*24*/
        E2driage2         /*อายุ2                      */     /*25*/
        E2dricr2          /*เลขที่บัตรประชาชน 2        */     /*26*/
        E2driid2          /*เลขที่ใบขับขี่2            */     /*27*/
        Eeffecdat         /*วันที่เริ่มคุ้มครอง"       */     /*28*/
        Eexpirdat         /*วันที่สิ้นสุด "            */     /*29*/
        E2make            /*ยี่ห้อ"                    */     /*30*/
        E2model           /*รุ่น"                      */     /*31*/ 
        E2YEAR            /*ปีที่จดทะเบียน"            */     /*32*/ 
        E22lisen          /*ทะเบียนรถ"                 */     /*33*/ 
        E2chassis         /*เลขตัวถัง"                 */     /*34*/ 
        E2engine          /*เลขเครื่องยนต์ "           */     /*35*/ 
        E2cc              /*ขนาดเครื่องยนต์"           */     /*36*/ 
        E2tonnage         /*น้ำหนัก"                   */     /*37*/ 
        E2seat            /*จำนวนที่นั่ง"              */     /*38*/ 
        /*E2CVMI          /*ลักษณะการใช้งาน"               */ /*39*/ */
        Esumins           /*ทุนประกัน "                    */ /*40*/ 
        Enetprm           /*"เบี้ยสุทธิ "                  */ /*41*/ 
        Egrossprm         /*"เบี้ยรวมภาษีอากร"             */ /*42*/ 
        E2prmp            /*"เบี้ยพรบ"                     */ /*43*/ 
        E2totalp          /*"เบี้ยรวมพรบ"                  */ /*44*/ 
        E2Garage          /*"ซ่อม(0:อู่ห้าง,1:อู่ในเครือ)" */ /*45*/ 
        E2access          /*"อุปกรณ์เสริม"                 */ /*46*/ 
        E2aecsdes         /*"รายละเอียดอุปกรณ์เสริม"       */ /*47*/ 
        E2text18          /*"หมายเหตุ"                     */ /*48*/ 
        E2textco                                              
        E2CVMI            /* A57-0244 ลักษณะการใช้งาน"     */ /*39*//*ลักษณะการใช้งาน*/  
        E2CV_poltyp       /* A57-0244 Add poltype          */ /*Pol_Type 70/72/74    */  
        E2CV_perbi        /* A57-0244 Per Person (BI)      */ /*Per Person (BI)      */  
        E2CV_perac        /* A57-0244 Per Accident         */ /*Per Accident         */  
        E2CV_perpd        /* A57-0244 Per Accident (PD)    */ /*Per Accident(PD)     */  
        E2CV_41           /* A57-0244 4.1 SI.              */ /*4.1 SI.              */  
        E2CV_42           /* A57-0244 4.2 Sum              */ /*4.2 Sum              */  
        E2CV_43           /* A57-0244 4.3 Sum              */ /*4.3 Sum              */  
        E2CV_vatcode      /* A57-0244                      */ /*VATCODE              */  
        E2CV_ispno        /* A57-0244                      */ /*ISP_NO               */  
        E2CV_campaign     /* A57-0244                      */ /*Campaign             */  
        benefic           /* A59-0182                      */ /*Beneficiary          */  
        n_producer        /* A59-0182                      */ /*Producer             */  
        n_agent           /* A59-0182                      */ /*Agent                */  
        n_payment         /* A59-0182                      */ /*Payment              */  
        n_track           /* A59-0182                      */ /*Tracking             */ 
        n_promo           /* A59-0182                      */
        nv_color      .   /* A66-0108 */
        
    IF      index(E2brach,"text") <> 0 THEN RUN proc_clear3.
    ELSE IF index(E2brach,"สาขา") <> 0 THEN RUN proc_clear3.
    ELSE IF       E2brach  = " "       THEN MESSAGE "เลขที่ใบคำขอ " Eapplino " ข้อมูลสาขาเป็นค่าว่าง !!" .  /*-- A58-0372 ---*/
    ELSE IF       E2brach  = " "       THEN RUN proc_clear3.  
    ELSE DO:
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        RUN proc_assign2addr (INPUT  EAddress2  
                             ,INPUT  EAddress3  
                             ,INPUT  EAddress4  
                             ,INPUT  E2occup         /* Occup./อาชีพ    ข้าราชการพลเรือน*/
                             ,OUTPUT n_codeocc   
                             ,OUTPUT n_codeaddr1 
                             ,OUTPUT n_codeaddr2 
                             ,OUTPUT n_codeaddr3). 
        IF n_postcd <> "" THEN DO: 
            IF      index(EAddress4,n_postcd) <> 0  THEN EAddress4 = REPLACE(EAddress4,n_postcd,"") .
            ELSE IF index(EAddress3,n_postcd) <> 0  THEN EAddress3 = REPLACE(EAddress3,n_postcd,"") .
            ELSE IF index(EAddress2,n_postcd) <> 0  THEN EAddress2 = REPLACE(EAddress2,n_postcd,"") .
            ELSE IF index(EAddress1,n_postcd) <> 0  THEN EAddress1 = REPLACE(EAddress1,n_postcd,"") .
        END.
        RUN proc_matchtypins (INPUT  trim(ENnam) 
                             ,INPUT  trim(THnam) 
                             ,OUTPUT n_insnamtyp
                             ,OUTPUT n_firstName
                             ,OUTPUT n_lastName). 
        /*Add by Kridtiya i. A63-0472 Date. 09/11/2020*/
        RUN proc_assign.                                        
    END.
END.           /*-Repeat-*/     
INPUT CLOSE.   /*close Import*/ 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnam C-Win 
PROCEDURE proc_insnam :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN  
    n_insref      = ""  
    nv_messagein  = ""
    nv_usrid      = ""
    nv_transfer   = NO
    n_check       = ""
    nv_insref     = ""
    putchr        = "" 
    putchr1       = ""
    nv_typ        = ""
    nv_usrid      = SUBSTRING(USERID(LDBNAME(1)),3,4) 
    nv_transfer   = YES.
fi_process             = " Proc name1. "    .
DISP fi_process    WITH FRAME fr_main.
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60002 WHERE
    sicsyac.xmm600.NAME     = trim(wdetail.name1)      AND 
    sicsyac.xmm600.homebr   = trim(wdetail.branch)     AND 
    sicsyac.xmm600.clicod   = "IN"  NO-ERROR NO-WAIT.    
IF NOT AVAILABLE sicsyac.xmm600 THEN DO: 
    IF LOCKED sicsyac.xmm600 THEN DO:   
        ASSIGN nv_transfer = NO 
            n_insref    = sicsyac.xmm600.acno.
        wdetail.comment = wdetail.comment + "|Running Code Insur = Lock!!!" . 
        RETURN.
    END.
    ELSE DO:
        ASSIGN  n_check   = "" 
            nv_insref = "".
        IF trim(wdetail.ntitle) <> " " THEN DO: 
            IF  R-INDEX(trim(wdetail.ntitle),"จก.")             <> 0  OR R-INDEX(trim(wdetail.ntitle),"จำกัด")           <> 0  OR  
                R-INDEX(trim(wdetail.ntitle),"(มหาชน)")         <> 0  OR R-INDEX(trim(wdetail.ntitle),"INC.")            <> 0  OR 
                R-INDEX(trim(wdetail.ntitle),"CO.")             <> 0  OR R-INDEX(trim(wdetail.ntitle),"LTD.")            <> 0  OR 
                R-INDEX(trim(wdetail.ntitle),"LIMITED")         <> 0  OR INDEX(trim(wdetail.ntitle),"บริษัท")            <> 0  OR 
                INDEX(trim(wdetail.ntitle),"บ.")                <> 0  OR INDEX(trim(wdetail.ntitle),"บจก.")              <> 0  OR 
                INDEX(trim(wdetail.ntitle),"หจก.")              <> 0  OR INDEX(trim(wdetail.ntitle),"หสน.")              <> 0  OR 
                INDEX(trim(wdetail.ntitle),"บรรษัท")            <> 0  OR INDEX(trim(wdetail.ntitle),"มูลนิธิ")           <> 0  OR 
                INDEX(trim(wdetail.ntitle),"ห้าง")              <> 0  OR INDEX(trim(wdetail.ntitle),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(trim(wdetail.ntitle),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(trim(wdetail.ntitle),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(trim(wdetail.ntitle),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".   /*0s= บุคคลธรรมดา Cs = นิติบุคคล*/
        END.
        ELSE DO:  /* ---- Check ด้วย name ---- */
            IF  R-INDEX(trim(wdetail.name1),"จก.")             <> 0  OR R-INDEX(trim(wdetail.name1),"จำกัด")           <> 0  OR  
                R-INDEX(trim(wdetail.name1),"(มหาชน)")         <> 0  OR R-INDEX(trim(wdetail.name1),"INC.")            <> 0  OR 
                R-INDEX(trim(wdetail.name1),"CO.")             <> 0  OR R-INDEX(trim(wdetail.name1),"LTD.")            <> 0  OR 
                R-INDEX(trim(wdetail.name1),"LIMITED")         <> 0  OR INDEX(trim(wdetail.name1),"บริษัท")            <> 0  OR 
                INDEX(trim(wdetail.name1),"บ.")                <> 0  OR INDEX(trim(wdetail.name1),"บจก.")              <> 0  OR 
                INDEX(trim(wdetail.name1),"หจก.")              <> 0  OR INDEX(trim(wdetail.name1),"หสน.")              <> 0  OR 
                INDEX(trim(wdetail.name1),"บรรษัท")            <> 0  OR INDEX(trim(wdetail.name1),"มูลนิธิ")           <> 0  OR 
                INDEX(trim(wdetail.name1),"ห้าง")              <> 0  OR INDEX(trim(wdetail.name1),"ห้างหุ้นส่วน")      <> 0  OR 
                INDEX(trim(wdetail.name1),"ห้างหุ้นส่วนจำกัด") <> 0  OR INDEX(trim(wdetail.name1),"ห้างหุ้นส่วนจำก")   <> 0  OR  
                INDEX(trim(wdetail.name1),"และ/หรือ")          <> 0  THEN nv_typ = "Cs".
            ELSE nv_typ = "0s".         /*0s= บุคคลธรรมดา Cs = นิติบุคคล  */
        END.
        RUN proc_insno. 
        IF n_check <> "" THEN DO: 
            ASSIGN nv_transfer = NO
                nv_insref   = "".
            wdetail.comment = wdetail.comment + "|1Running Code Insur :" + n_check . 
            RETURN.
        END.
        IF nv_insref <> "" THEN DO:
            loop_runningins:                /*Check Insured  */
            REPEAT:
                FIND sicsyac.xmm600 USE-INDEX xmm60001 WHERE
                    sicsyac.xmm600.acno = CAPS(nv_insref)  NO-LOCK NO-ERROR NO-WAIT.
                IF AVAIL sicsyac.xmm600 THEN DO:
                    RUN proc_insno .
                    IF n_check <> "" THEN DO: 
                        ASSIGN nv_transfer = NO
                            nv_insref   = "".
                        wdetail.comment = wdetail.comment + "|2Running Code Insur :" + n_check . 
                        RETURN.
                    END.
                END.
                ELSE LEAVE loop_runningins.
            END.
        END.
        IF nv_insref <> "" THEN CREATE sicsyac.xmm600.
        ELSE DO:
            ASSIGN wdetail.pass = "N"  
                wdetail.comment = wdetail.comment + "| รหัสลูกค้าเป็นค่าว่างไม่สามารถนำเข้าระบบได้ค่ะ" 
                WDETAIL.OK_GEN  = "N"
                nv_transfer = NO.
        END.    /**/
    END.
    n_insref = nv_insref.
    IF nv_typ = "Cs" THEN
        ASSIGN wdetail.firstName = TRIM(wdetail.name1)
        wdetail.lastName  = "".
    ELSE ASSIGN wdetail.firstName = substr(TRIM(wdetail.name1),1,R-INDEX(TRIM(wdetail.name1)," "))
        wdetail.lastName  = substr(TRIM(wdetail.name1),R-INDEX(TRIM(wdetail.name1)," ")).
END.
ELSE DO:
    IF sicsyac.xmm600.acno <> "" THEN DO:   /* กรณีพบ */
        IF SUBSTR(trim(sicsyac.xmm600.acno),2,1) = "C" OR SUBSTR(trim(sicsyac.xmm600.acno),3,1) = "C" THEN
            ASSIGN wdetail.firstName = TRIM(wdetail.name1)
            wdetail.lastName  = "".
        ELSE DO: 
            IF R-INDEX(TRIM(wdetail.name1)," ") <> 0 THEN
                ASSIGN wdetail.firstName = substr(TRIM(wdetail.name1),1,R-INDEX(TRIM(wdetail.name1)," "))
                wdetail.lastName  = substr(TRIM(wdetail.name1),R-INDEX(TRIM(wdetail.name1)," ")).
            ELSE ASSIGN wdetail.firstName = TRIM(wdetail.name1)
                wdetail.lastName  = "".
        END.
        ASSIGN
            nv_insref               = trim(sicsyac.xmm600.acno) 
            n_insref                = caps(trim(nv_insref)) 
            nv_transfer             = NO 
            sicsyac.xmm600.ntitle   = trim(wdetail.ntitle)      /*Title for Name Mr/Mrs/etc*/
            sicsyac.xmm600.fname    = ""                        /*First Name*/
            sicsyac.xmm600.name     = trim(wdetail.name1)       /*Name Line 1*/
            sicsyac.xmm600.abname   = trim(wdetail.name1)       /*Abbreviated Name*/
            sicsyac.xmm600.icno     = TRIM(wdetail.Idno)              /*IC No.*/           /*--Crate by Amparat C. A51-0071--*/
            sicsyac.xmm600.addr1    = trim(wdetail.addrss1)             /*Address line 1*/
            sicsyac.xmm600.addr2    = trim(wdetail.addrss2)                             /*Address line 2*/
            sicsyac.xmm600.addr3    = trim(wdetail.addrss3)                             /*Address line 3*/
            sicsyac.xmm600.addr4    = trim(wdetail.addrss4)                
            sicsyac.xmm600.homebr   = trim(wdetail.branch)     /*Home branch*/
            sicsyac.xmm600.opened   = TODAY
            sicsyac.xmm600.chgpol   = YES                       /*Allow N & A change on pol.Y/N*/
            sicsyac.xmm600.entdat   = TODAY                     /*Entry date*/
            sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")   /*Entry time*/
            sicsyac.xmm600.usrid    = nv_usrid 
            /* xmm600 *//*Add by Kridtiya i. A63-0472*/
            sicsyac.xmm600.acno_typ  = IF  SUBSTR(trim(sicsyac.xmm600.acno),2) = "C" OR SUBSTR(trim(sicsyac.xmm600.acno),3) = "C" THEN "CO" ELSE "PR"   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
            sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
            sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
            sicsyac.xmm600.postcd    = trim(wdetail.postcd)
            sicsyac.xmm600.icno      = trim(wdetail.idno)        
            sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)         
            sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)       
            sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)       
            sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)       
            /*sicsyac.xmm600.anlyc5    = wdetail.br_insured */     .    
            /*Add by Kridtiya i. A63-0472*/
           /* sicsyac.xmm600.dtyp20   = IF wdetail.birthdat = "" THEN "" ELSE "DOB"
            sicsyac.xmm600.dval20   = IF wdetail.birthdat = "" THEN ""
                                      ELSE substr(TRIM(wdetail.birthdat),1,6) +
                                      STRING(deci(substr(TRIM(wdetail.birthdat),7,4)) + 543 ) */     /*-- Add chutikarn A50-0072 --*/
            /*sicsyac.xmm600.anlyc5   =  ""                    /*Analysis Code 5*/ */          /*A57-0073*/
            /*sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(wdetail2.brdealer) ELSE ""*/ .  /*A57-0073*/
    END.
END.
IF nv_transfer = YES THEN DO:  
    ASSIGN  sicsyac.xmm600.acno = nv_insref                 /*Account no*/
        sicsyac.xmm600.gpstcs   = nv_insref                 /*Group A/C for statistics*/
        sicsyac.xmm600.gpage    = ""                        /*Group A/C for ageing*/
        sicsyac.xmm600.gpstmt   = ""                        /*Group A/C for Statement*/
        sicsyac.xmm600.or1ref   = ""                        /*OR Agent 1 Ref. No.*/
        sicsyac.xmm600.or2ref   = ""                        /*OR Agent 2 Ref. No.*/
        sicsyac.xmm600.or1com   = 0                         /*OR Agent 1 Comm. %*/
        sicsyac.xmm600.or2com   = 0                         /*OR Agent 2 Comm. %*/
        sicsyac.xmm600.or1gn    = "G"                       /*OR Agent 1 Gross/Net*/
        sicsyac.xmm600.or2gn    = "G"                       /*OR Agent 2 Gross/Net*/
        sicsyac.xmm600.ntitle   = trim(wdetail.ntitle)      /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                        /*First Name*/
        sicsyac.xmm600.name     = trim(wdetail.name1)       /*Name Line 1*/
        sicsyac.xmm600.abname   = trim(wdetail.name1)       /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.IdNO)        /*IC No.*/     /*--Crate by Amparat C. A51-0071--*/
        sicsyac.xmm600.addr1    = trim(wdetail.addrss1)     /*Address line 1*/
        sicsyac.xmm600.addr2    = trim(wdetail.addrss2)     /*Address line 2*/
        sicsyac.xmm600.addr3    = trim(wdetail.addrss3)     /*Address line 3*/
        sicsyac.xmm600.addr4    = trim(wdetail.addrss4)     /*Address line 4*/
        sicsyac.xmm600.postcd   = ""                        /*Postal Code*/
        sicsyac.xmm600.clicod   = "IN"                      /*Client Type Code*/
        sicsyac.xmm600.acccod   = "IN"                      /*Account type code*/
        sicsyac.xmm600.relate   = ""                        /*Related A/C for RI Claims*/
        sicsyac.xmm600.notes1   = ""                        /*Notes line 1*/
        sicsyac.xmm600.notes2   = ""                        /*Notes line 2*/
        sicsyac.xmm600.homebr   = trim(wdetail.branch)      /*Home branch*/
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
        /*sicsyac.xmm600.anlyc5   =  ""                    /*Analysis Code 5*/ */        /*A57-0073*/
        /*sicsyac.xmm600.anlyc5   = IF nv_typ = "Cs" THEN TRIM(wdetail2.brdealer) ELSE ""  /*A57-0073*/
        sicsyac.xmm600.dtyp20   = IF wdetail.birthdat = "" THEN "" ELSE "DOB"
        sicsyac.xmm600.dval20   = IF wdetail.birthdat = "" THEN ""
                                  ELSE substr(TRIM(wdetail.birthdat),1,6) + 
                                      STRING(deci(substr(TRIM(wdetail.birthdat),7,4)) + 543 )*/       /*string(wdetail.brithday).*/
        /* xmm600 *//*Add by Kridtiya i. A63-0472*/
        sicsyac.xmm600.acno_typ  = IF nv_typ = "Cs" THEN "CO" ELSE "PR"   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
        sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
        sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
        sicsyac.xmm600.postcd    = trim(wdetail.postcd)
        sicsyac.xmm600.icno      = trim(wdetail.idno)         
        sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)         
        sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)       
        sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)       
        sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)       
        /*sicsyac.xmm600.anlyc5    = wdetail.br_insured*/     .    
        /*Add by Kridtiya i. A63-0472*/
END.
fi_process             = " Proc name ene."  .
DISP fi_process    WITH FRAME fr_main.
IF sicsyac.xmm600.acno <> "" THEN DO:              /*A55-0268 add chk nv_insref = "" */
    ASSIGN nv_insref = trim(sicsyac.xmm600.acno)
        nv_transfer  = YES.
    FIND sicsyac.xtm600 WHERE sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
    IF NOT AVAILABLE sicsyac.xtm600 THEN DO:
        IF LOCKED sicsyac.xtm600 THEN DO:
            nv_transfer = NO.
            RETURN.
        END.
        ELSE DO:
            CREATE sicsyac.xtm600.
        END.
    END.
    IF nv_transfer = YES THEN DO:
        ASSIGN  sicsyac.xtm600.acno    = nv_insref                                          /*Account no.*/
            sicsyac.xtm600.name    = trim(wdetail.name1)                                /*Name of Insured Line 1*/
            sicsyac.xtm600.abname  = trim(wdetail.name1)                                /*Abbreviated Name*/
            sicsyac.xtm600.addr1   = trim(wdetail.addrss1)                             /*address line 1*/
            sicsyac.xtm600.addr2   = trim(wdetail.addrss2)                             /*address line 2*/
            sicsyac.xtm600.addr3   = trim(wdetail.addrss3)                             /*address line 3*/
            sicsyac.xtm600.addr4   = trim(wdetail.addrss4)                             /*address line 4*/
            sicsyac.xtm600.name2   = ""                                                 /*Name of Insured Line 2*/ 
            sicsyac.xtm600.ntitle  = trim(wdetail.ntitle)                              /*Title*/
            sicsyac.xtm600.name3   = ""                                                 /*Name of Insured Line 3*/
            sicsyac.xtm600.fname   = ""                                               /*First Name*/
            /* xtm600 *//*Add by Kridtiya i. A63-0472*/
            sicsyac.xtm600.postcd    = trim(wdetail.postcd)        /*Add by Kridtiya i. A63-0472*/
            sicsyac.xtm600.firstname = trim(wdetail.firstName)     /*Add by Kridtiya i. A63-0472*/
            sicsyac.xtm600.lastname  = trim(wdetail.lastName)  .   /*Add by Kridtiya i. A63-0472*/
            /*Add by Kridtiya i. A63-0472*/
    END.
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600.
RELEASE sicsyac.xzm056.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insnamRE C-Win 
PROCEDURE proc_insnamRE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*Case Renew have nv_insref */
FIND LAST sicsyac.xmm600 USE-INDEX  xmm60001 WHERE
    sicsyac.xmm600.acno     =  trim(nv_insref)    
    NO-ERROR NO-WAIT.    
IF   AVAILABLE sicsyac.xmm600 THEN DO: 
    /* กรณีพบ */
    IF SUBSTR(trim(sicsyac.xmm600.acno),2,1) = "C" OR SUBSTR(trim(sicsyac.xmm600.acno),3,1) = "C" THEN
        ASSIGN wdetail.firstName = TRIM(wdetail.name1)
               wdetail.lastName  = "".
    ELSE DO: 
        IF R-INDEX(TRIM(wdetail.name1)," ") <> 0 THEN
            ASSIGN 
            wdetail.firstName = substr(TRIM(wdetail.name1),1,R-INDEX(TRIM(wdetail.name1)," "))
            wdetail.lastName  = substr(TRIM(wdetail.name1),R-INDEX(TRIM(wdetail.name1)," ")).
        ELSE ASSIGN wdetail.firstName = TRIM(wdetail.name1)
                    wdetail.lastName  = "".
    END.
    ASSIGN
        nv_insref               = trim(sicsyac.xmm600.acno) 
        n_insref                = caps(trim(nv_insref)) 
        nv_transfer             = NO 
        sicsyac.xmm600.ntitle   = trim(wdetail.ntitle)     /*Title for Name Mr/Mrs/etc*/
        sicsyac.xmm600.fname    = ""                       /*First Name*/
        sicsyac.xmm600.name     = trim(wdetail.name1)      /*Name Line 1*/
        sicsyac.xmm600.abname   = trim(wdetail.name1)      /*Abbreviated Name*/
        sicsyac.xmm600.icno     = TRIM(wdetail.Idno)       /*IC No.*/          
        sicsyac.xmm600.addr1    = trim(wdetail.addrss1)    /*Address line 1*/
        sicsyac.xmm600.addr2    = trim(wdetail.addrss2)    /*Address line 2*/
        sicsyac.xmm600.addr3    = trim(wdetail.addrss3)    /*Address line 3*/
        sicsyac.xmm600.addr4    = trim(wdetail.addrss4)    
        sicsyac.xmm600.homebr   = trim(wdetail.branch)     /*Home branch*/
        sicsyac.xmm600.opened   = TODAY                    
        sicsyac.xmm600.chgpol   = YES                      /*Allow N & A change on pol.Y/N*/
        sicsyac.xmm600.entdat   = TODAY                    /*Entry date*/
        sicsyac.xmm600.enttim   = STRING(TIME,"HH:MM:SS")  /*Entry time*/
        sicsyac.xmm600.usrid    = nv_usrid 
        sicsyac.xmm600.acno_typ  = IF  SUBSTR(trim(sicsyac.xmm600.acno),2) = "C" OR SUBSTR(trim(sicsyac.xmm600.acno),3) = "C" THEN "CO" ELSE "PR"   /*ประเภทลูกค้า CO = นิติบุคคล  PR = บุคคล*/   
        sicsyac.xmm600.firstname = TRIM(wdetail.firstName)  
        sicsyac.xmm600.lastName  = TRIM(wdetail.lastName)   
        sicsyac.xmm600.postcd    = trim(wdetail.postcd)
        sicsyac.xmm600.icno      = trim(wdetail.idno)        
        sicsyac.xmm600.codeocc   = trim(wdetail.codeocc)         
        sicsyac.xmm600.codeaddr1 = TRIM(wdetail.codeaddr1)       
        sicsyac.xmm600.codeaddr2 = TRIM(wdetail.codeaddr2)       
        sicsyac.xmm600.codeaddr3 = trim(wdetail.codeaddr3)   .  
END.
FIND LAST sicsyac.xtm600 USE-INDEX xtm60001 WHERE 
    sicsyac.xtm600.acno  = nv_insref  NO-ERROR NO-WAIT.
IF  AVAILABLE sicsyac.xtm600 THEN DO:
    ASSIGN  sicsyac.xtm600.acno    = nv_insref                                          /*Account no.*/
        sicsyac.xtm600.name    = trim(wdetail.name1)                                /*Name of Insured Line 1*/
        sicsyac.xtm600.abname  = trim(wdetail.name1)                                /*Abbreviated Name*/
        sicsyac.xtm600.addr1   = trim(wdetail.addrss1)                             /*address line 1*/
        sicsyac.xtm600.addr2   = trim(wdetail.addrss2)                             /*address line 2*/
        sicsyac.xtm600.addr3   = trim(wdetail.addrss3)                             /*address line 3*/
        sicsyac.xtm600.addr4   = trim(wdetail.addrss4)                             /*address line 4*/
        sicsyac.xtm600.name2   = ""                                                 /*Name of Insured Line 2*/ 
        sicsyac.xtm600.ntitle  = trim(wdetail.ntitle)                              /*Title*/
        sicsyac.xtm600.name3   = ""                                                 /*Name of Insured Line 3*/
        sicsyac.xtm600.fname   = ""                                               /*First Name*/
        sicsyac.xtm600.postcd    = trim(wdetail.postcd)        
        sicsyac.xtm600.firstname = trim(wdetail.firstName)     
        sicsyac.xtm600.lastname  = trim(wdetail.lastName)  . 
END.
RELEASE sicsyac.xtm600.
RELEASE sicsyac.xmm600. 
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_insno C-Win 
PROCEDURE proc_insno :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_search   AS LOGICAL INIT YES .
DEF VAR nv_lastno  AS INT INIT 0. 
DEF VAR nv_seqno   AS INT INIT 0.  
ASSIGN  nv_insref = "" .
fi_process             = " Proc insno"  .
DISP fi_process    WITH FRAME fr_main.
FIND LAST sicsyac.xzm056 USE-INDEX xzm05601 WHERE 
    sicsyac.xzm056.seqtyp   =  nv_typ        AND
    sicsyac.xzm056.branch   =  trim(wdetail.branch)   NO-LOCK NO-ERROR .
IF NOT AVAIL xzm056 THEN DO :
    IF n_search = YES THEN DO:
        CREATE xzm056.
        ASSIGN sicsyac.xzm056.seqtyp =  nv_typ
            sicsyac.xzm056.branch    =  trim(wdetail.branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  1.                   
    END.
    ELSE DO:
        ASSIGN
            nv_insref = trim(wdetail.branch)  + String(1,"999999")
            nv_lastno = 1.
        RETURN.
    END.
END.
ASSIGN 
    nv_lastno = sicsyac.xzm056.lastno
    nv_seqno  = sicsyac.xzm056.seqno. 
IF n_check = "YES" THEN DO:   
    IF nv_typ = "0s" THEN DO: 
        IF LENGTH(trim(wdetail.branch)) = 2 THEN
            nv_insref = trim(wdetail.branch) + String(sicsyac.xzm056.lastno + 1 ,"99999999").
        ELSE DO:
            /*A56-0318....
            IF sicsyac.xzm056.lastno > 99999 THEN
                   nv_insref = "0" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno + 1 ,"99999999").
            ELSE   nv_insref =       trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno + 1 ,"999999").   A56-0318*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (trim(wdetail.branch) = "A") OR (trim(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (trim(wdetail.branch) = "A") OR (trim(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  trim(wdetail.branch)
            sicsyac.xzm056.des       =  "Personal/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno.   
    END.
    ELSE IF nv_typ = "Cs" THEN DO:
        IF LENGTH(trim(wdetail.branch)) = 2 THEN
            nv_insref = trim(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + trim(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"9999999").
            ELSE   nv_insref =       trim(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno + 1 ,"99999").
        END.   
        CREATE sicsyac.xzm056.
        ASSIGN
            sicsyac.xzm056.seqtyp    =  nv_typ
            sicsyac.xzm056.branch    =  trim(wdetail.branch)
            sicsyac.xzm056.des       =  "Company/Start"
            sicsyac.xzm056.lastno    =  nv_lastno + 1
            sicsyac.xzm056.seqno     =  nv_seqno. 
    END.
    n_check = "".
    
END.
ELSE DO:
    IF nv_typ = "0s" THEN DO:
        IF LENGTH(trim(wdetail.branch)) = 2 THEN
            nv_insref = trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
        ELSE DO: 
            /*IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            ELSE nv_insref =       trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").*/
            /*Add ... A56-0318*/
            IF sicsyac.xzm056.lastno > 99999 THEN DO:
                IF (trim(wdetail.branch) = "A") OR (trim(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref = "0" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
            END.
            ELSE DO:
                IF (trim(wdetail.branch) = "A") OR (trim(wdetail.branch) = "B") THEN DO:
                    nv_insref = "7" + trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"99999999").
                END.
                ELSE nv_insref =       trim(wdetail.branch) + STRING(sicsyac.xzm056.lastno,"999999").
            END.    /*add ...A56-0318*/
        END.
    END.
    ELSE DO:
        IF LENGTH(trim(wdetail.branch)) = 2 THEN
            nv_insref = trim(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
        ELSE DO:  
            IF sicsyac.xzm056.lastno > 99999 THEN
                nv_insref = "0" + trim(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"9999999").
            ELSE
                nv_insref =       trim(wdetail.branch) + "C" + String(sicsyac.xzm056.lastno,"99999").
        END.
    END.
     
END.
IF sicsyac.xzm056.lastno >  sicsyac.xzm056.seqno Then Do :
    /*MESSAGE  "Running Code = Last No. / Please, Update Insured Running Code." SKIP
        "รหัสลูกค้า ถึงหมายเลขสุดท้ายแล้ว / ยกเลิกการทำงานชั่วคราว"      SKIP
        "แล้วติดต่อผู้ตั้ง Code"  VIEW-AS ALERT-BOX. */
    n_check = "ERROR".
    wdetail.comment = wdetail.comment + "|Running Code Insur = Last No. / Please, Update Insured Running Code." . 
    RETURN. 
END.         /*lastno > seqno*/                       
ELSE DO :    /*lastno <= seqno */
    IF nv_typ = "0s" THEN DO:
        IF n_search = YES THEN DO:
            CREATE sicsyac.xzm056.
            ASSIGN
                sicsyac.xzm056.seqtyp    =  nv_typ
                sicsyac.xzm056.branch    =  trim(wdetail.branch)
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
                sicsyac.xzm056.branch    =  trim(wdetail.branch)
                sicsyac.xzm056.des       =  "Company/Start"
                sicsyac.xzm056.lastno    =  nv_lastno + 1
                sicsyac.xzm056.seqno     =  nv_seqno. 
        END.
    END.
   
END.        /*lastno <= seqno */  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_klrenew C-Win 
PROCEDURE proc_klrenew :
/*------------------------------------------------------------------------------
  Purpose:  Check data import with Expiry System    
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEFINE INPUT-OUTPUT  PARAMETER n_expdat     AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_prepol     AS CHAR FORMAT "x(15)" .
DEFINE INPUT-OUTPUT  PARAMETER n_branch     AS CHAR FORMAT "x(3)" .
DEFINE INPUT-OUTPUT  PARAMETER n_firstdat   AS DATE FORMAT "99/99/9999".
DEFINE INPUT-OUTPUT  PARAMETER n_subclass   AS CHAR FORMAT "x(3)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_redbook    AS CHAR FORMAT "x(10)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_vehuse     AS CHAR FORMAT "x(2)" .   
DEFINE INPUT-OUTPUT  PARAMETER n_covcod     AS CHAR FORMAT "x(30)" .  
DEFINE INPUT-OUTPUT  PARAMETER n_seat       AS INTE.
DEFINE INPUT-OUTPUT  PARAMETER nv_basere    AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_dedod     AS DECI.         
DEFINE INPUT-OUTPUT  PARAMETER nv_addod     AS DECI.        
DEFINE INPUT-OUTPUT  PARAMETER nv_dedpd     AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER nv_flet_per  AS DECI.  
DEFINE INPUT-OUTPUT  PARAMETER n_NCB        AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_dss_per   AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER nv_cl_per    AS DECI.  
DEFINE INPUT-OUTPUT  PARAMETER nv_si        AS DECI FORMAT "->>,>>>,>>>,>>9.99"   INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_41         AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER n_42         AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER n_43         AS DECI. 
DEFINE INPUT-OUTPUT  PARAMETER nv_stf_per   AS DECI.
DEFINE INPUT-OUTPUT  PARAMETER n_uom1_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0. 
DEFINE INPUT-OUTPUT  PARAMETER n_uom2_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.  
DEFINE INPUT-OUTPUT  PARAMETER n_uom5_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_uom7_v     AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER premt        AS DECI FORMAT ">,>>>,>>>,>>9.99-" INIT 0.
DEFINE INPUT-OUTPUT  PARAMETER n_engc       AS INTEGER.
DEFINE INPUT-OUTPUT  PARAMETER n_year       AS INTEGER.
DEF VAR number_sic AS INTE INIT 0.
IF NOT CONNECTED("sic_exp") THEN DO:
    loop_sic:
    REPEAT:
        number_sic = number_sic + 1 .
        RUN proc_assignrenew.
        IF  CONNECTED("sic_exp") THEN LEAVE loop_sic.
        ELSE IF number_sic > 3 THEN DO:
            MESSAGE "User not connect system Expiry !!! >>>" number_sic  VIEW-AS ALERT-BOX.
            LEAVE loop_sic.
        END.
    END.
END.
IF  CONNECTED("sic_exp") THEN DO:
    FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
              sic_exp.uwm100.policy = n_prepol  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_exp.uwm100 THEN DO:
        ASSIGN
         n_branch = sic_exp.uwm100.branch
         n_expdat = sic_exp.uwm100.expdat.

        FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001     WHERE
                    sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
                    sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
                    sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-ERROR NO-WAIT.
        IF AVAIL sic_exp.uwm120 THEN
            ASSIGN 
            n_firstdat = sic_exp.uwm100.fstdat
            n_subclass = sic_exp.uwm120.class.
           
        FIND FIRST  sic_exp.uwm130 USE-INDEX uwm13001     WHERE
                    sic_exp.uwm130.policy  = sic_exp.uwm120.policy  AND
                    sic_exp.uwm130.rencnt  = sic_exp.uwm120.rencnt  AND
                    sic_exp.uwm130.endcnt  = sic_exp.uwm120.endcnt  NO-LOCK NO-ERROR NO-WAIT.
        IF AVAIL sic_exp.uwm130 THEN
            ASSIGN 
               n_uom1_v  = 0 
               n_uom2_v  = 0
               n_uom5_v  = 0
               n_uom7_v  = 0
               n_uom1_v  = sic_exp.uwm130.uom1_v   
               n_uom2_v  = sic_exp.uwm130.uom2_v   
               n_uom5_v  = sic_exp.uwm130.uom5_v  
               nv_si     = sic_exp.uwm130.uom6_v    
               n_uom7_v  = sic_exp.uwm130.uom7_v .

        FIND LAST sic_exp.uwm301 USE-INDEX uwm30101      WHERE
                  sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
                  sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
                  sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-ERROR NO-WAIT.
        IF AVAIL uwm301 THEN
            ASSIGN  
              n_redbook     = ""
              n_vehuse      = ""
              n_covcod      = "" 
              n_seat        = 0 
              n_engc        = 0 
              n_year        = 0
              n_redbook     = sic_exp.uwm301.modcod          /* redbook  */                                            
              n_vehuse      = sic_exp.uwm301.vehuse                                                               
              n_covcod      = sic_exp.uwm301.covcod
              n_seat        = sic_exp.uwm301.seats
              n_engc        = sic_exp.uwm301.engine
              n_year        = sic_exp.uwm301.yrmanu
              nv_basere     = 0
              nv_dedod      = 0
              nv_addod      = 0
              nv_dedpd      = 0
              nv_flet_per   = 0
              n_NCB         = 0
              nv_dss_per    = 0
              nv_cl_per     = 0        /*จำนวนที่นั่ง*/  
              n_41          = 0   
              n_42          = 0   
              n_43          = 0   
              nv_stf_per    = 0  
              premt         = 0 .
         
         
        FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
                  sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
                  sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
                  sic_exp.uwd132.endcnt   = sic_exp.uwm301.endcnt  AND
                  sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
                  sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
             IF sic_exp.uwd132.bencod  = "base" THEN
                ASSIGN  nv_basere = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "DOD" THEN
                ASSIGN  nv_dedod  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "DOD2" THEN
                ASSIGN  nv_addod  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "DPD" THEN
                ASSIGN  nv_dedpd  = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF uwd132.bencod = "FLET"    THEN
                ASSIGN  nv_flet_per = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod    = "ncb" THEN
                ASSIGN   n_NCB = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod    = "dspc" THEN
                ASSIGN   nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF SUBSTR(uwd132.bencod,1,2)    = "CL" THEN
                ASSIGN  nv_cl_per            = DECIMAL(SUBSTRING(uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod                = "411" THEN
                ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่*/ 
                     n_41   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
            ELSE IF sic_exp.uwd132.bencod           = "42" THEN
                ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง*/   
                    n_42   =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod                = "43" THEN
                ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                    n_43   =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
            ELSE IF sic_exp.uwd132.bencod                = "DSTF" THEN
                ASSIGN nv_stf_per = DECIMAL(SUBSTRING(sic_exp.uwd132.benvar,31,30)).

            premt = premt + uwd132.prem_c.

        END.
    END.
END.*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_klrenew2 C-Win 
PROCEDURE proc_klrenew2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*
DEFINE INPUT-OUTPUT  PARAMETER n_expdat     AS DATE FORMAT "99/99/9999".
DEFINE INPUT         PARAMETER n_prepol     AS CHAR FORMAT "x(15)" .
DEF VAR number_sic AS INTE INIT 0.

IF NOT CONNECTED("sic_exp") THEN DO:
    loop_sic:
    REPEAT:
        number_sic = number_sic + 1.
        RUN proc_assignrenew2.
        IF  CONNECTED("sic_exp") THEN LEAVE loop_sic.
        ELSE IF number_sic > 3 THEN DO:
            MESSAGE "User not connect system Expiry !!! >>>" number_sic  VIEW-AS ALERT-BOX.
            LEAVE loop_sic.
        END.
    END.
END.
IF  CONNECTED("sic_exp") THEN DO:
    FIND LAST sic_exp.uwm100 USE-INDEX uwm10001 WHERE
              sic_exp.uwm100.policy = n_prepol  NO-LOCK NO-ERROR NO-WAIT.
    IF AVAILABLE sic_exp.uwm100 THEN DO:
        ASSIGN
         n_expdat   = sic_exp.uwm100.expdat
         n_firstdat = sic_exp.uwm100.fstdat.
       
    END.
END.
*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_mailtxt C-Win 
PROCEDURE proc_mailtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR no_policy AS CHAR FORMAT "x(20)" .            
DEF VAR no_rencnt AS CHAR FORMAT "99".                
DEF VAR no_endcnt AS CHAR FORMAT "999".               
                                                      
DEF VAR no_riskno AS CHAR FORMAT "999".               
DEF VAR no_itemno AS CHAR FORMAT "999".     
ASSIGN                                                
 no_policy = sic_bran.uwm301.policy                   
 no_rencnt = STRING(sic_bran.uwm301.rencnt,"99")      
 no_endcnt = STRING(sic_bran.uwm301.endcnt,"999")     
 no_riskno = "001"                                    
 no_itemno = "001"                                    
 nv_drivage1 = wdetail.age1                           
 nv_drivage2 = wdetail.age2.                          
IF  wdetail.drivnam = "Y" THEN DO :      /*note add 07/11/2005*/
    /*FIND LAST  brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE*/ /* ----- suthida T. A52-0275 20-09-10 ------ */
     FIND LAST brstat.mailtxt_fil WHERE  /* ----- suthida T. A52-0275 20-09-10 ------ */
               brstat.mailtxt_fil.policy = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno  AND
               brstat.mailtxt_fil.bchyr  = nv_batchyr   AND                                               
               brstat.mailtxt_fil.bchno  = nv_batchno   AND
               brstat.mailtxt_fil.bchcnt = nv_batcnt    NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil THEN  nv_lnumber =   1.                                      


    FIND FIRST   brstat.mailtxt_fil  USE-INDEX  mailtxt01  WHERE
                 brstat.mailtxt_fil.policy  = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno     AND
                 brstat.mailtxt_fil.lnumber = nv_lnumber    AND
                 brstat.mailtxt_fil.bchyr   = nv_batchyr    AND                                               
                 brstat.mailtxt_fil.bchno   = nv_batchno    AND
                 brstat.mailtxt_fil.bchcnt  = nv_batcnt     NO-LOCK  NO-ERROR  NO-WAIT.
    IF NOT AVAIL brstat.mailtxt_fil   THEN DO:
       CREATE brstat.mailtxt_fil.
       ASSIGN                                           
         brstat.mailtxt_fil.policy    = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
         brstat.mailtxt_fil.lnumber   = nv_lnumber.
         /*-- Comment by Narin A54-0396
         IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
              brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)) + "MALE". 
         ELSE brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)) + "FEMALE". 
         --*/
         /*--    Add by Narin A54-0396--*/
         IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
              brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",50 - LENGTH(wdetail.drivername1)) + "MALE". 
         ELSE brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",50 - LENGTH(wdetail.drivername1)) + "FEMALE".
         /*--End Add by Narin A54-0396--*/
         brstat.mailtxt_fil.ltext2     = wdetail.dbirth1 + "  " + STRING(nv_drivage1).
         nv_drivno                     = 1.

       ASSIGN /*a490166*/
         brstat.mailtxt_fil.bchyr = nv_batchyr 
         brstat.mailtxt_fil.bchno = nv_batchno 
         brstat.mailtxt_fil.bchcnt  = nv_batcnt 
         SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
       IF wdetail.drivername2 <> "" THEN DO:
           CREATE brstat.mailtxt_fil. 
           ASSIGN
             brstat.mailtxt_fil.policy   = no_policy + no_rencnt + no_endcnt +  no_riskno + no_itemno
             brstat.mailtxt_fil.lnumber  = nv_lnumber + 1.
             /*brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)).*/
             /*-- Comment by Narin A54-0396
             IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
                  brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)) + "MALE". 
             ELSE brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)) + "FEMALE". 
             --*/
             /*--    Add by Narin A54-0396--*/
             IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
                  brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",50 - LENGTH(wdetail.drivername2)) + "MALE". 
             ELSE brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",50 - LENGTH(wdetail.drivername2)) + "FEMALE". 
             /*--End Add by Narin A54-0396--*/
             brstat.mailtxt_fil.ltext2   = wdetail.dbirth2  + "  " + STRING(nv_drivage2). 
             nv_drivno                   = 2.

           ASSIGN /*a490166*/
             brstat.mailtxt_fil.bchyr = nv_batchyr 
             brstat.mailtxt_fil.bchno = nv_batchno 
             brstat.mailtxt_fil.bchcnt  = nv_batcnt 
             SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/    
       END.  /*drivnam2 <> " " */
    END. /*End Avail Brstat*/
    ELSE  DO:
          CREATE  brstat.mailtxt_fil.
          ASSIGN  
            brstat.mailtxt_fil.policy     = wdetail.policy + STRING(sic_bran.uwm100.rencnt) + STRING(sic_bran.uwm100.endcnt) + string(sic_bran.uwm301.riskno)  + string(sic_bran.uwm301.itemno)
            brstat.mailtxt_fil.lnumber    = nv_lnumber.
            /*brstat.mailtxt_fil.ltext      = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)). */
            /*-- Comment by Narin A54-0396
            IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
                 brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)) + "MALE". 
            ELSE brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",30 - LENGTH(wdetail.drivername1)) + "FEMALE". 
            --*/
            /*--    Add by Narin A54-0396--*/
            IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
                 brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",50 - LENGTH(wdetail.drivername1)) + "MALE". 
            ELSE brstat.mailtxt_fil.ltext = wdetail.drivername1 + FILL(" ",50 - LENGTH(wdetail.drivername1)) + "FEMALE". 
            /*--End Add by Narin A54-0396--*/
            brstat.mailtxt_fil.ltext2     = wdetail.dbirth1 + "  " +  TRIM(STRING(nv_drivage1)).

          IF wdetail.drivername2 <> "" THEN DO:
              CREATE  brstat.mailtxt_fil.
              ASSIGN
                  brstat.mailtxt_fil.policy   = wdetail.policy + STRING(uwm100.rencnt) + STRING(uwm100.endcnt) + string(uwm301.riskno)  + string(uwm301.itemno)
                  brstat.mailtxt_fil.lnumber  = nv_lnumber + 1.
                  /*brstat.mailtxt_fil.ltext    = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)). */
                  /*-- Comment by Narin A54-0396
                  IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
                       brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)) + "MALE". 
                  ELSE brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",30 - LENGTH(wdetail.drivername2)) + "FEMALE". 
                  --*/
                  /*--    Add by Narin A54-0396--*/
                  IF INDEX(wdetail.drivername1,"นาย") <> 0 THEN
                       brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",50 - LENGTH(wdetail.drivername2)) + "MALE". 
                  ELSE brstat.mailtxt_fil.ltext = wdetail.drivername2 + FILL(" ",50 - LENGTH(wdetail.drivername2)) + "FEMALE". 
                  /*--End Add by Narin A54-0396--*/
                  brstat.mailtxt_fil.ltext2   = wdetail.dbirth2 + "  " + TRIM(STRING(nv_drivage1)).


              ASSIGN /*a490166*/
                  brstat.mailtxt_fil.bchyr = nv_batchyr 
                  brstat.mailtxt_fil.bchno = nv_batchno 
                  brstat.mailtxt_fil.bchcnt  = nv_batcnt 
                  SUBSTRING(brstat.mailtxt_fil.ltext2,16,30) = "-"   . /*note add on 02/11/2006*/
          END. /*drivnam2 <> " " */
    END. /*Else DO*/
 END. /*note add for mailtxt 07/11/2005*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_maktab C-Win 
PROCEDURE proc_maktab :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
    nv_simat  = 0
    nv_simat1 = 0
    nv_simat  = DECI(wdetail.si) * 50 / 100 
    nv_simat1 = DECI(wdetail.si) + nv_simat .
 
FIND FIRST stat.maktab_fil USE-INDEX      maktab04          WHERE
    stat.maktab_fil.makdes   =     nv_makdes                AND                  
    INDEX(stat.maktab_fil.moddes,SUBSTRING(nv_moddes,1,INDEX(nv_moddes," "))) <> 0    AND
    stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
    stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND
    stat.maktab_fil.sclass   =     "****"                   AND
    (stat.maktab_fil.si      >=     nv_simat                OR
    stat.maktab_fil.si       <=     nv_simat1 )             AND  
    stat.maktab_fil.seats    =     INTEGER(wdetail.seat)    NO-LOCK NO-ERROR NO-WAIT.
IF  AVAIL stat.maktab_fil  THEN DO:
 
    ASSIGN
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp          =  stat.maktab_fil.prmpac
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.tons    =  stat.maktab_fil.tons
        sic_bran.uwm301.seats   =  stat.maktab_fil.seats.
END.
IF wdetail.redbook = "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX      maktab04         WHERE
        stat.maktab_fil.makdes   =     wdetail.brand             And                  
        INDEX(stat.maktab_fil.moddes,SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))) <> 0  AND
        stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
        stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND
        stat.maktab_fil.sclass   =     SUBSTRING(wdetail.class,2,3)      AND
       /* (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE wdetail.si   AND 
        stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE wdetail.si ) AND*/
        stat.maktab_fil.seats    =   INTE(wdetail.seat)     NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAIL stat.maktab_fil  THEN 
        ASSIGN nv_modcod =  stat.maktab_fil.modcod  
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.redbook  =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.seats   =  stat.maktab_fil.seats
        sic_bran.uwm301.tons    = IF sic_bran.uwm301.tons = 0 THEN stat.maktab_fil.tons ELSE sic_bran.uwm301.tons . /*A63-0162*/
END.
IF wdetail.redbook = "" THEN DO:
    FIND FIRST stat.maktab_fil USE-INDEX      maktab04         WHERE
        stat.maktab_fil.makdes   =     wdetail.brand             And                  
        INDEX(stat.maktab_fil.moddes,SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))) <> 0  AND
        stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
        /*stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND*/
        stat.maktab_fil.sclass   =     SUBSTRING(wdetail.class,2,3)      AND
       /* (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE wdetail.si   AND 
        stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE wdetail.si ) AND*/
        stat.maktab_fil.seats    =   INTE(wdetail.seat)     NO-LOCK NO-ERROR NO-WAIT.
    IF  AVAIL stat.maktab_fil  THEN 
        ASSIGN nv_modcod =  stat.maktab_fil.modcod  
        nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        wdetail.cargrp   =  stat.maktab_fil.prmpac
        wdetail.redbook  =  stat.maktab_fil.modcod
        sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
        sic_bran.uwm301.moddes  =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
        sic_bran.uwm301.vehgrp  =  stat.maktab_fil.prmpac
        sic_bran.uwm301.body    =  stat.maktab_fil.body
        sic_bran.uwm301.seats   =  stat.maktab_fil.seats
        sic_bran.uwm301.tons    = IF sic_bran.uwm301.tons = 0 THEN stat.maktab_fil.tons ELSE sic_bran.uwm301.tons . /*A63-0162*/
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_matchtypins C-Win 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_open C-Win 
PROCEDURE proc_open :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OPEN QUERY br_wdetail FOR EACH wdetail WHERE wdetail.pass = "y" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_policy C-Win 
PROCEDURE proc_policy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* DEF VAR chk_sticker AS CHAR FORMAT "x(15)". */ /* ---- suthida t. A52-0275 27-09-10 ----- */
DEF VAR chk_sticker AS CHAR FORMAT "x(13)".       /* ---- suthida t. A52-0275 27-09-10 ----- */
/*IF wdetail.policy <> "" THEN DO:*/ /* ---  suthida T. A54-0010 09-03-11 ---- */ 
/*FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE*/ /* ---------- suthida T. A52-0275 20-09-10 ------------ */
FIND LAST sicuw.uwm100  USE-INDEX uwm10002  WHERE    /* ---------- suthida T. A52-0275 20-09-10 ------------ */
    sicuw.uwm100.cedpol =  wdetail.applino  AND 
    sicuw.uwm100.poltyp =  wdetail.poltyp   NO-LOCK NO-ERROR NO-WAIT. 
IF AVAIL sicuw.uwm100 THEN DO:
    IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
        ASSIGN wdetail.pass    = "N"
        wdetail.comment = wdetail.comment + "| พบเลขรับแจ้งนี้ถูกใช้ในระบบ premuim" + sicuw.uwm100.poltyp.
END.
fi_process             = " Proc prolicy. " + wdetail.stk  .
DISP fi_process    WITH FRAME fr_main.
IF wdetail.stk  <>  ""  THEN DO: 
    IF SUBSTR(wdetail.stk,1,1) = "2" THEN chk_sticker  = "0" + wdetail.stk.
    ELSE chk_sticker = wdetail.stk.
    chr_sticker = chk_sticker.
    RUN wuz\wuzchmod. /* Check sticker */
    IF chk_sticker  <>  chr_sticker  THEN DO:
        ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| Error1 : Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".
    END.
    nv_newsck = " ".
    IF wdetail.w_type = "RENEW" THEN                  
        wdetail.comment = wdetail.comment + "| Generate Sticker No. ในระบบ Premium".
    ELSE DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE wdetail.stk = wdetail.stk.
        FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE
            stat.detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR.
        IF AVAIL stat.detaitem THEN 
            ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
            wdetail.WARNING = "Program Running Policy No. ให้ชั่วคราว".
    END.
    IF wdetail.policy = "" THEN DO:
        RUN proc_temppolicy.
        wdetail.policy  = nv_tmppol.
    END.
    RUN proc_create100.
END.        /*wdetail.stk  <>  ""*/
ELSE DO:   /*sticker = ""*/ 
    FIND FIRST sicuw.uwm100  USE-INDEX uwm10001 WHERE
        sicuw.uwm100.policy = wdetail.policy    /*AND
        sicuw.uwm100.rencnt >= 0                AND
        sicuw.uwm100.endcnt >= 0 */     NO-LOCK   NO-ERROR NO-WAIT.
    IF AVAIL sicuw.uwm100 THEN DO:
        IF sicuw.uwm100.name1  <>  "" OR sicuw.uwm100.comdat <> ? OR  sicuw.uwm100.releas = YES THEN 
            ASSIGN wdetail.pass    = "N"
            wdetail.comment = wdetail.comment + "| พบกรมธรรม์นี้ถูกใช้ในระบบ premuim".
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100. 
    END.     /*policy <> "" & stk = ""*/                 
    ELSE RUN proc_create100.  
END.
/* ------------- suthida T. A54-0010 09-03-11 ------------ 
END.
ELSE DO:  /*wdetail.policyno = ""*/
    IF wdetail.stk  <>  ""  THEN DO:
        IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
        ELSE chk_sticker = wdetail.stk.

        chr_sticker = chk_sticker.

        RUN wuz\wuzchmod. /* Check sticker */

        IF chk_sticker  <>  chr_sticker  THEN DO:
            ASSIGN
              wdetail.pass    = "N"
              wdetail.comment = wdetail.comment + "| Error1 : Sticker Number ใช้ Generate ไม่ได้ เนื่องจาก Module Error".

        END.

        FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE
            sicuw.uwm100.policy =  wdetail.policy NO-ERROR NO-WAIT.
        IF AVAIL sicuw.uwm100 THEN DO:
            IF sicuw.uwm100.name1 <> "" OR sicuw.uwm100.comdat <> ? OR sicuw.uwm100.releas = YES THEN 
                ASSIGN
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลขกรมธรรม์นี้ได้ถูกใช้ไปแล้ว "
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.   /*add kridtiya i..*/

        nv_newsck = " ".

        IF SUBSTRING(wdetail.applino,1,2) = "RW" THEN 
           wdetail.comment = wdetail.comment + "| Generate Sticker No. ในระบบ Premium".
        ELSE DO:
            IF SUBSTR(wdetail.stk,1,1) = "2" THEN wdetail.stk = "0" + wdetail.stk.
            ELSE wdetail.stk = wdetail.stk.
            FIND FIRST stat.detaitem USE-INDEX detaitem11 WHERE 
                stat.detaitem.serailno = wdetail.stk NO-LOCK NO-ERROR.
            IF AVAIL stat.detaitem THEN 
                ASSIGN                               
                wdetail.pass    = "N"
                wdetail.comment = wdetail.comment + "| หมายเลข Sticker เบอร์นี้ได้ถูกใช้ไปแล้ว"
                wdetail.warning = "Program Running Policy No. ให้ชั่วคราว".
        END.
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END. /*wdetail.stk  <>  ""*/
    ELSE DO:  /*policy = "" and comp_sck = ""  */       
        IF wdetail.policy = "" THEN DO:
            RUN proc_temppolicy.
            wdetail.policy  = nv_tmppol.
        END.
        RUN proc_create100.
    END.
END. ------------- suthida T. A54-0010 09-03-11 ------------ */
s_recid1  =  Recid(sic_bran.uwm100).
FIND sicsyac.xmm031 WHERE sicsyac.xmm031.poltyp = SUBSTRING(wdetail.poltyp,2,2) NO-LOCK NO-ERROR NO-WAIT. /*----- suthida T. A54-0010  07-04-11*/
IF AVAIL  sicsyac.xmm031 THEN DO:
    nv_dept = sicsyac.xmm031.dept.
END.
IF wdetail.poltyp = "V70"  AND wdetail.Docno <> ""  THEN  
    ASSIGN nv_docno  = wdetail.Docno
    nv_accdat = TODAY.
ELSE DO:
        IF wdetail.docno  = "" THEN nv_docno  = "".
        IF wdetail.accdat = "" THEN nv_accdat = TODAY.
END.
/* ASSIGN nv_insref = "" .  /*A57-0244 */ *//*A65-0040*/
IF nv_insref = ""  THEN RUN proc_insnam.        /*A57-0244 */                  /*A65-0040*/
ELSE RUN proc_insnamRE.    
IF nv_insref = ""  THEN                     /*A65-0040*/
    ASSIGN wdetail.pass    = "N"   /*A65-0040*/
           wdetail.comment = wdetail.comment + "| Error1 : insref not empty!!!".  /*A65-0040*/

/*IF wdetail.prepol = "" AND SUBSTRING(wdetail.policy,1,2) <> "RW" THEN n_firstdat = wdetail.comdat.  /* ----- suthida T. A54-0010 ----- */*/
IF wdetail.prepol = "" THEN n_firstdat = wdetail.comdat.   /* ----- suthida T. A54-0010 ----- */
RUN proc_chkcode .  /* A64-0138*/
DO TRANSACTION:
    ASSIGN
        sic_bran.uwm100.renno  = ""
        sic_bran.uwm100.endno  = ""
        sic_bran.uwm100.poltyp = caps(trim(wdetail.poltyp))
        sic_bran.uwm100.insref = trim(nv_insref)
        /*sic_bran.uwm100.opnpol = ""*/  /*A58-0183 add Promotion...*/
        /*sic_bran.uwm100.opnpol = IF trim(wdetail.brand) = "MG" THEN "MG" ELSE "" /*A58-0183 .*/*/ /*A61-0269*/
        sic_bran.uwm100.occupn = wdetail.occoup
        sic_bran.uwm100.anam2  = trim(wdetail.idno)    /*wdetail.Icno        ICNO  Cover Note A51-0071 Amparat */
        sic_bran.uwm100.ntitle = trim(wdetail.ntitle)            
        sic_bran.uwm100.name1  = trim(wdetail.name1)       
        sic_bran.uwm100.name2  = trim(wdetail.name2)               
        sic_bran.uwm100.name3  = ""                 
        sic_bran.uwm100.addr1  = trim(wdetail.addrss1)             
        sic_bran.uwm100.addr2  = trim(wdetail.addrss2)          
        sic_bran.uwm100.addr3  = trim(wdetail.addrss3)          
        sic_bran.uwm100.addr4  = trim(wdetail.addrss4)
        sic_bran.uwm100.postcd = "" 
        sic_bran.uwm100.undyr  = STRING(YEAR(TODAY),"9999")   /*   nv_undyr  */
        sic_bran.uwm100.branch = caps(trim(wdetail.branch))   /*wdetail2.n_branch *//* nv_branch  */                        
        sic_bran.uwm100.dept   = nv_dept
        sic_bran.uwm100.usrid  = USERID(LDBNAME(1))
        sic_bran.uwm100.fstdat = /*TODAY  */    n_firstdat   /* ----- suthida T. A54-0010 21-06-11 --- */             /*TODAY */
        sic_bran.uwm100.comdat = wdetail.comdat
        sic_bran.uwm100.expdat = wdetail.expdat
        sic_bran.uwm100.accdat = TODAY          /*nv_accdat */                   
        sic_bran.uwm100.tranty = "N"                          /*Transaction Type (N/R/E/C/T)*/
        sic_bran.uwm100.langug = "T"
        sic_bran.uwm100.acctim = "00:00"
        sic_bran.uwm100.trty11 = "M"      
        sic_bran.uwm100.docno1 =  " " /*STRING(nv_docno,"9999999")*/     
        sic_bran.uwm100.enttim = STRING(TIME,"HH:MM:SS")
        sic_bran.uwm100.entdat = TODAY
        sic_bran.uwm100.curbil = "BHT"
        sic_bran.uwm100.curate = 1
        sic_bran.uwm100.instot = 1
        sic_bran.uwm100.prog   = "wgwklgen"
        sic_bran.uwm100.cntry  = "TH"        /*Country where risk is situated*/
        sic_bran.uwm100.insddr = YES         /*Print Insd. Name on DrN       */
        sic_bran.uwm100.no_sch = 0           /*No. to print, Schedule        */
        sic_bran.uwm100.no_dr  = 1           /*No. to print, Dr/Cr Note      */
        sic_bran.uwm100.no_ri  = 0           /*No. to print, RI Appln        */
        sic_bran.uwm100.no_cer = 0           /*No. to print, Certificate     */
        sic_bran.uwm100.li_sch = YES         /*Print Later/Imm., Schedule    */
        sic_bran.uwm100.li_dr  = YES         /*Print Later/Imm., Dr/Cr Note  */
        sic_bran.uwm100.li_ri  = YES         /*Print Later/Imm., RI Appln,   */
        sic_bran.uwm100.li_cer = YES         /*Print Later/Imm., Certificate */
        sic_bran.uwm100.apptax = YES         /*Apply risk level tax (Y/N)    */
        sic_bran.uwm100.recip  = "N"         /*Reciprocal (Y/N/C)            */
        sic_bran.uwm100.short  = NO
        sic_bran.uwm100.acno1  = trim(wdetail.producer)    /*  nv_acno1 */      
        sic_bran.uwm100.agent  = trim(wdetail.agent)       /*nv_agent   */   
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
        sic_bran.uwm100.cr_2   = wdetail.cr_2
        sic_bran.uwm100.cr_1   = ""
        sic_bran.uwm100.bchyr  = nv_batchyr           /*Batch Year */  
        sic_bran.uwm100.bchno  = nv_batchno           /*Batch No.  */  
        sic_bran.uwm100.bchcnt = nv_batcnt            /*Batch Count*/  
        sic_bran.uwm100.prvpol = wdetail.prepol       /*A52-0172*/
        sic_bran.uwm100.cedpol = wdetail.applino      /*SUBSTR(wdetail.policy,3,11) */
        sic_bran.uwm100.finint = " "                  /*wdetail.n_delercode*/
        sic_bran.uwm100.bs_cd  = wdetail.vatcode
        sic_bran.uwm100.cr_1   = wdetail.payment     /*A59-0182*/ 
        sic_bran.uwm100.opnpol = wdetail.promo      /*A59-0182*/
        sic_bran.uwm100.firstName  = TRIM(wdetail.firstName)     /*Add by Kridtiya i. A63-0472*/    
        sic_bran.uwm100.lastName   = TRIM(wdetail.lastName)      /*Add by Kridtiya i. A63-0472*/    
        sic_bran.uwm100.icno       = trim(wdetail.idno)          /*Add by Kridtiya i. A63-0472*/    
        sic_bran.uwm100.postcd     = trim(wdetail.postcd)        /*Add by Kridtiya i. A63-0472*/    
        sic_bran.uwm100.codeocc    = trim(wdetail.codeocc)       /*Add by Kridtiya i. A63-0472*/    
        sic_bran.uwm100.codeaddr1  = TRIM(wdetail.codeaddr1)     /*Add by Kridtiya i. A63-0472*/    
        sic_bran.uwm100.codeaddr2  = TRIM(wdetail.codeaddr2)     /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.codeaddr3  = trim(wdetail.codeaddr3)     /*Add by Kridtiya i. A63-0472*/
        /*sic_bran.uwm100.br_insured = wdetail.br_insured        /*Add by Kridtiya i. A63-0472*/*/
        sic_bran.uwm100.campaign   = trim(wdetail.campaign_ov)   /*Add by Kridtiya i. A63-0472*/
        sic_bran.uwm100.dealer     = trim(wdetail.financecd) .   /*Add by Kridtiya i. A63-0472*/ 


      /*sic_bran.uwm100.bs_cd  = wdetail.typrequest */    /*add kridtiya i. A53-0027 เพิ่ม Vatcode*/
      /*sic_bran.uwm100.opnpol = wdetail.comrequest. */   
    IF wdetail.prepol <> " " THEN DO:
        IF (wdetail.poltyp <> "V70")  THEN sic_bran.uwm100.prvpol  = "".
        ELSE 
            ASSIGN sic_bran.uwm100.prvpol  = wdetail.prepol   /*ถ้าเป็นงาน Renew  ต้องไม่เป็นค่าว่าง */
                   sic_bran.uwm100.tranty  = "R".             /*Transaction Type (N/R/E/C/T)  */
                   
    END.
    IF sic_bran.uwm100.accdat > sic_bran.uwm100.comdat THEN 
        sic_bran.uwm100.accdat = sic_bran.uwm100.comdat.    
    IF wdetail.cancel = "ca" THEN
        sic_bran.uwm100.polsta = "CA" .
    ELSE  
        sic_bran.uwm100.polsta = "IF".
    IF fi_loaddat <> ? THEN
        sic_bran.uwm100.trndat = fi_loaddat.
    ELSE
        sic_bran.uwm100.trndat = TODAY.
    sic_bran.uwm100.issdat = sic_bran.uwm100.trndat.
    /* Suthida T. A54-0010  07-06-11 --- 
    nv_polday  =  IF  (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 365)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 366)  OR
                        (sic_bran.uwm100.expdat - sic_bran.uwm100.comdat = 367)  THEN  365 
                    ELSE sic_bran.uwm100.expdat - sic_bran.uwm100.comdat. 
       Suthida T. A54-0010 07-06-11 --*/ 
    IF ( DAY(sic_bran.uwm100.comdat)         =   DAY(sic_bran.uwm100.expdat)     AND 
         MONTH(sic_bran.uwm100.comdat)       = MONTH(sic_bran.uwm100.expdat)     AND 
         YEAR(sic_bran.uwm100.comdat) + 1    =  YEAR(sic_bran.uwm100.expdat) )   OR  
        ( DAY(sic_bran.uwm100.comdat)        =   29                              AND 
          MONTH(sic_bran.uwm100.comdat)      =   02                              AND 
          DAY(sic_bran.uwm100.expdat)        =   01                              AND 
          MONTH(sic_bran.uwm100.expdat)      =   03                              AND 
          YEAR(sic_bran.uwm100.comdat) + 1   =  YEAR(sic_bran.uwm100.expdat) )   THEN DO:
        nv_polday = 365.
    END.
    ELSE DO:
        nv_polday = (sic_bran.uwm100.expdat  - sic_bran.uwm100.comdat ) + 1 .     /*    =  366  ??? */
    END.

    FOR EACH temp-item USE-INDEX  lineno: 
        DELETE temp-item.                 
    END.
    RUN proc_uwd100.
    RUN proc_uwd102.
    FOR EACH temp-item USE-INDEX  lineno: 
        DELETE temp-item.                 
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
        RUN wgw/wgwad120 (INPUT sic_bran.uwm100.policy,   /***--- A490166 Note Modi ---***/
                          sic_bran.uwm100.rencnt,
                          sic_bran.uwm100.endcnt,
                          s_riskgp,
                          s_riskno,
                          OUTPUT  s_recid2).
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
            sic_bran.uwm120.bchyr  = nv_batchyr     /* batch Year */
            sic_bran.uwm120.bchno  = nv_batchno     /* bchno      */
            sic_bran.uwm120.bchcnt = nv_batcnt  .   /* bchcnt     */
        ASSIGN
            sic_bran.uwm120.class    = wdetail.class
            s_recid2                 = RECID(sic_bran.uwm120).
    END.
    
END.    /*transaction*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_prmtxt C-Win 
PROCEDURE proc_prmtxt :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
 ASSIGN 
         nv_acc6 = IF TRIM(wdetail.accessd) <> "" THEN trim(wdetail.accessd) ELSE ""
         nv_acc1 = ""
         nv_acc2 = ""
         nv_acc3 = ""
         nv_acc4 = ""
         nv_acc5 = "".
     loop_chk1:
     REPEAT:
         IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc1 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
             ASSIGN  nv_acc1 = trim(nv_acc1 + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
             nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
         ELSE LEAVE loop_chk1.
     END.
     IF nv_acc6 <> "" THEN
     loop_chk2:
     REPEAT:
         IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc2 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
             ASSIGN  nv_acc2 = trim(nv_acc2  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
             nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
         ELSE LEAVE loop_chk2.
     END.
     loop_chk3:
     REPEAT:
         IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc3 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
             ASSIGN  nv_acc3 = trim(nv_acc3  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
             nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
         ELSE LEAVE loop_chk3.
     END.
     loop_chk4:
     REPEAT:
         IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc4 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
             ASSIGN  nv_acc4 = trim(nv_acc4  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
             nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
         ELSE LEAVE loop_chk4.
     END.
     loop_chk5:
     REPEAT:
         IF (INDEX(nv_acc6," ") <> 0 ) AND LENGTH(nv_acc5 + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," ")))) <= 60 THEN 
             ASSIGN  nv_acc5 = trim(nv_acc5  + " " + TRIM(SUBSTR(nv_acc6,1,INDEX(nv_acc6," "))))
             nv_acc6 = TRIM(SUBSTR(nv_acc6,INDEX(nv_acc6," "))).
         ELSE LEAVE loop_chk5.
     END.
     IF      (nv_acc5 <> "") AND (length(nv_acc5 + " " + nv_acc6 ) <= 60 ) THEN 
         ASSIGN nv_acc5 = nv_acc5  + " " + nv_acc6
         nv_acc6 = "" .
     ELSE IF (nv_acc4 <> "") AND (length(nv_acc4 + " " + nv_acc6 ) <= 60 ) THEN 
         ASSIGN nv_acc4 = nv_acc4  + " " + nv_acc6 
         nv_acc6 = "" .
     ELSE IF (nv_acc3 <> "") AND (length(nv_acc3 + " " + nv_acc6 ) <= 60 ) THEN 
         ASSIGN nv_acc3 = nv_acc3  + " " + nv_acc6
         nv_acc6 = "" .
     ELSE IF (nv_acc2 <> "") AND (length(nv_acc2 + " " + nv_acc6 ) <= 60 ) THEN 
         ASSIGN nv_acc2 = nv_acc2  + " " + nv_acc6
         nv_acc6 = "" .
     ELSE IF (nv_acc1 <> "") AND (length(nv_acc1 + " " + nv_acc6 ) <= 60 ) THEN
         ASSIGN  nv_acc1 = nv_acc1  + " " + nv_acc6
         nv_acc6 = "" .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_recreate C-Win 
PROCEDURE proc_recreate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* --------------------- งานต่ออายุ --------------------------
FIND LAST sic_exp.uwm100  WHERE sic_exp.uwm100.policy = wdetail.prepol  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE sic_exp.uwm100 THEN DO:
    FIND FIRST  sic_exp.uwm120 USE-INDEX uwm12001     WHERE
                sic_exp.uwm120.policy  = sic_exp.uwm100.policy  AND
                sic_exp.uwm120.rencnt  = sic_exp.uwm100.rencnt  AND
                sic_exp.uwm120.endcnt  = sic_exp.uwm100.endcnt   NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL sic_exp.uwm120 THEN wdetail.class = sic_exp.uwm120.class.
    FIND LAST sic_exp.uwm301 USE-INDEX uwm30101      WHERE
              sic_exp.uwm301.policy = sic_exp.uwm100.policy    AND
              sic_exp.uwm301.rencnt = sic_exp.uwm100.rencnt    AND
              sic_exp.uwm301.endcnt = sic_exp.uwm100.endcnt    NO-LOCK NO-ERROR NO-WAIT.
    IF AVAIL uwm301 THEN
        ASSIGN 
            wdetail.model    = sic_exp.uwm301.moddes
            wdetail.redbook  = sic_exp.uwm301.modcod   /* redbook  */                                            
            wdetail.cargrp   = sic_exp.uwm301.vehgrp   /*กลุ่มรถยนต์*/                                       
            wdetail.chasno   = sic_exp.uwm301.cha_no   /*หมายเลขตัวถัง */    
            wdetail.eng      = sic_exp.uwm301.eng_no   /*หมายเลขเครื่อง*/                      
            wdetail.vehuse   = sic_exp.uwm301.vehuse                                                                   
            wdetail.caryear  = STRING(sic_exp.uwm301.yrmanu )   /*รุ่นปี*/
            wdetail.covcod   = sic_exp.uwm301.covcod                                                         
            wdetail.body     = sic_exp.uwm301.body            /*แบบตัวถัง*/                                       
            wdetail.seat     = sic_exp.uwm301.seats           /*จำนวนที่นั่ง*/  
            wdetail.engcc    = STRING(sic_exp.uwm301.engine).  /*ปริมาตรกระบอกสูบ*/                                     
    FOR EACH sic_exp.uwd132 USE-INDEX uwd13290  WHERE
        sic_exp.uwd132.policy   = sic_exp.uwm301.policy  AND
        sic_exp.uwd132.rencnt   = sic_exp.uwm301.rencnt  AND
        sic_exp.uwd132.riskno   = sic_exp.uwm301.riskno  AND
        sic_exp.uwd132.itemno   = sic_exp.uwm301.itemno  NO-LOCK .
        IF sic_exp.uwd132.bencod                = "411" THEN
            ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้ขับขี่*/ 
                 WDETAIL.no_41   = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).  
        ELSE IF sic_exp.uwd132.bencod           = "42" THEN
            ASSIGN   /*อุบัติเหตุส่วนบุคคลเสียชีวิตผู้โดยสารต่อครั้ง*/   
                WDETAIL.no_42   =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "43" THEN
            ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                WDETAIL.no_43   =  DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "base" THEN
            ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                nv_basere = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        ELSE IF sic_exp.uwd132.bencod                = "dspc" THEN
            ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                nv_dss_per = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).
        /*ELSE IF sic_exp.uwd132.bencod                = "ncb" THEN
            ASSIGN   /*การประกันตัวผู้ขับขี่*/ 
                n_NCB = DECI(SUBSTRING(sic_exp.uwd132.benvar,31,30)).*/
    END.
END.
--------------------- งานต่ออายุ --------------------------*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_renew C-Win 
PROCEDURE proc_renew :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
FIND LAST sicuw.uwm100  USE-INDEX uwm10001 WHERE 
    sicuw.uwm100.policy = wdetail.prepol   No-lock No-error no-wait.
IF AVAIL sicuw.uwm100  THEN DO:
    IF sicuw.uwm100.renpol <> " " THEN DO:
        MESSAGE "กรมธรรณ์มีการต่ออายุแล้ว" VIEW-AS ALERT-BOX .
        ASSIGN  
            /*wdetail.prvpol  = "Already Renew"        ทำให้รู้ว่าเป็นงานต่ออายุ*/
            wdetail.comment  = wdetail.comment + "| กรมธรรณ์มีการต่ออายุแล้ว" 
            /*WDETAIL.OK_GEN   = "N"*/
            wdetail.pass     = "N". 
    END.
    ELSE DO: 
        ASSIGN  
            wdetail.prepol = sicuw.uwm100.policy
            n_rencnt       = sicuw.uwm100.rencnt  +  1
            n_endcnt       = 0
            wdetail.pass   = "Y".
        RUN proc_assignrenew.            /*รับค่า ความคุ้มครองของเก่า */
    END.
END.   /*  avail  uwm100  */
ELSE DO:  
    ASSIGN
        n_rencnt  =  0  
        n_Endcnt  =  0
        wdetail.prepol   = ""
        wdetail.comment = wdetail.comment + "| เป็นกรมธรรม์ต่ออายุจากบริษัทอื่น  ".

END.   /*not  avail uwm100*/

IF wdetail.pass    = "Y" THEN wdetail.comment = "COMPLETE".


END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_report1 C-Win 
PROCEDURE proc_report1 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
nv_row  =  1.
DEF VAR a AS CHAR FORMAT "x(100)" INIT "".
DEF VAR b AS CHAR FORMAT "x(100)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR NOT_pass AS INTE INIT 0.
/* ----- suthida T. A52-0275 27-09-10 ---- */
ASSIGN
  a        = ""
  b        = ""
  c        = 0
  NOT_pass = 0.

FOR EACH wdetail WHERE wdetail.PASS <> "Y"  :
    NOT_pass = NOT_pass + 1.
END.
IF NOT_pass > 0 THEN DO:
    OUTPUT STREAM ns1 TO value(fi_output2).
    PUT STREAM ns1
                "เลขที่ใบคำขอ"                  ";"                
                "เลขที่รับแจ้ง"                 ";"         
                "RE/EN"                         ";"  
                "สาขา"                          ";"  
                "ชื่อผู้เอาประกันภัย "          ";"  
                "ที่อยู่ผู้เอาประกันภัย 1"      ";"
                "ที่อยู่ผู้เอาประกันภัย 2"      ";"
                "ที่อยู่ผู้เอาประกันภัย 3"      ";"
                "ที่อยู่ผู้เอาประกันภัย 4"      ";"
                "วันที่เริ่มคุ้มครอง"           ";"         
                "วันที่สินสุดการคุ้มครอง"       ";"         
                "Transection Date"              ";"  
                "Policy Type"                   ";"  
                "ประเภทความคุ้มครอง"            ";"
                "จำนวนเงินเอาประกันภัย"         ";" 
                "เบี้ยประกันภัย"                ";" 
                "Trariff"                       ";" 
                "Sticker NO."                   ";" 
                "Class"                         ";" 
                "MAKE"                          ";" 
                "Model"                         ";" 
                "comment     "                  ";"  
                "WARNING     "                  ";"  SKIP.                                          
    FOR EACH  wdetail WHERE 
              wdetail.PASS <> "Y"  AND                
              wdetail.policy <> "" :   
            PUT STREAM ns1                                               
                wdetail.policy                         ";" 
                wdetail.applino                        ";"
                STRING(wdetail.recnt) + "/" + 
                STRING(wdetail.endcnt)                 ";" 
                wdetail.branch                         ";"
                wdetail.Insd    + wdetail.name1        ";"
                wdetail.addrss1                        ";"
                wdetail.addrss2                        ";"
                wdetail.addrss3                        ";"
                wdetail.addrss4                        ";"
                wdetail.comdat                         ";"
                wdetail.expdat                         ";"
                wdetail.trandat                        ";"
                wdetail.poltyp                         ";"
                wdetail.covcod                         ";"
                wdetail.si                             ";"
                wdetail.premt                          ";"
                wdetail.tariff                         ";"
                wdetail.stk                            ";"
                wdetail.class                          ";"
                wdetail.brand                          ";"
                wdetail.model                          ";"
                wdetail.comment                        ";"
                wdetail.WARNING                        ";" SKIP.                 
    END.                      
    /*END.*/                      
END.                                                                                   
OUTPUT STREAM ns1 CLOSE.                                                
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE PROC_REPORT2 C-Win 
PROCEDURE PROC_REPORT2 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

DEF VAR HEAD AS CHAR INIT "Y".
nv_row  =  1.
DEF VAR a AS CHAR FORMAT "x(20)" INIT "".
DEF VAR b AS CHAR FORMAT "x(20)" INIT "".
DEF VAR c AS INTE INIT 0.
DEF VAR d AS INTE INIT 0.
DEF VAR f AS CHAR FORMAT "x(20)" INIT "".
DEF VAR pass AS INTE INIT 0.

/* ----- suthida T. A52-0275 27-09-10 ---- */
ASSIGN
  a    = ""
  b    = ""
  c    = 0
  d    = 0
  f    = ""
  pass = 0.

FOR EACH wdetail WHERE 
        wdetail.PASS = "Y"  :
        pass = pass + 1.
END.
IF pass > 0 THEN DO:
OUTPUT STREAM ns2 TO value(fi_output1).
          PUT STREAM NS2
              "เลขที่ใบคำขอ"                  ";"               
              "เลขที่รับแจ้ง"                 ";"        
              "RE/EN"                         ";" 
              "สาขา"                          ";" 
              "ชื่อผู้เอาประกันภัย "          ";" 
              "ที่อยู่ผู้เอาประกันภัย 1"      ";" 
              "ที่อยู่ผู้เอาประกันภัย 2"      ";" 
              "ที่อยู่ผู้เอาประกันภัย 3"      ";" 
              "ที่อยู่ผู้เอาประกันภัย 4"      ";"        
              "วันที่เริ่มคุ้มครอง"           ";"        
              "วันที่สินสุดการคุ้มครอง"       ";" 
              "Transection Date"              ";" 
              "Policy Type"                   ";" 
              "ประเภทความคุ้มครอง"            ";" 
              "จำนวนเงินเอาประกันภัย"         ";" 
              "เบี้ยประกันภัย"                ";" 
              "Trariff"                       ";" 
              "Sticker NO."                   ";" 
              "Class"                         ";" 
              "MAKE"                          ";" 
              "Model"                         ";" 
              "comment     "                  ";" 
              "WARNING     "                  ";" 
              
        SKIP.        
    FOR EACH  wdetail WHERE wdetail.PASS = "Y"  :
        PUT STREAM ns2
            wdetail.policy                         ";"  
            wdetail.applino                        ";"  
            STRING(wdetail.recnt) + "/" +  
            STRING(wdetail.endcnt)                 ";" 
            wdetail.branch                         ";"  
            wdetail.Insd    + wdetail.name1        ";"  
            wdetail.addrss1                        ";"  
            wdetail.addrss2                        ";"  
            wdetail.addrss3                        ";"  
            wdetail.addrss4                        ";"  
            wdetail.comdat                         ";"  
            wdetail.expdat                         ";"  
            wdetail.trandat                        ";"  
            wdetail.poltyp                         ";"  
            wdetail.covcod                         ";"  
            wdetail.si                             ";" 
            wdetail.premt                          ";" 
            wdetail.tariff                         ";"  
            wdetail.stk                            ";"  
            wdetail.class                          ";"  
            wdetail.brand                          ";"  
            wdetail.model                          ";"  
            wdetail.comment                        ";"  
            wdetail.WARNING                        ";"  
            
            
    SKIP.                                          
  END. 
OUTPUT STREAM ns2 CLOSE.                                                           
END. /*pass > 0*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_screen C-Win 
PROCEDURE proc_screen :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
OUTPUT STREAM ns3 TO value(fi_output3).
PUT STREAM NS3   
"IMPORT TEXT FILE K-Leasing " SKIP   
"             Loaddat : " fi_loaddat    SKIP
"              Branch : " fi_branch     + "          " + fi_brndes  FORMAT "X(50)" SKIP
"       Producer Code : " fi_producer   + "    " + fi_proname_rw    FORMAT "X(50)" SKIP
"          Agent Code : " fi_agent      + "    " + fi_agtname       FORMAT "X(50)" SKIP
"  Previous Batch No. : " fi_prevbat   " Batch Year : " fi_bchyr  SKIP
"Input File Name Load : " fi_filename   SKIP
"    Output Data Load : " fi_output1    SKIP
"Output Data Not Load : " fi_output2    SKIP
"     Batch File Name : " fi_output3    SKIP
/*" policy Import Total : " fi_usrcnt    "    Total Net Premium Imp : " fi_usrprem " BHT."*/   SKIP
SKIP
SKIP
SKIP
"                             Total Record : " fi_impcnt      "   Total Net Premium : " fi_premtot " BHT." SKIP
"Batch No. : " fi_bchno SKIP
"                           Success Record : " fi_completecnt " Success Net Premium : " fi_premsuc " BHT." .


OUTPUT STREAM ns3 CLOSE.    
                                                  
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_sic_exp2 C-Win 
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

  IF LASTKEY = KEYCODE("F1") OR LASTKEY = KEYCODE("ENTER") THEN DO:
       CONNECT expiry -H tmsth -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) . 
      /*CONNECT expiry -H alpha4 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd)  .*/            
      /*CONNECT expiry -H newapp -S expirytest -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd)  . */ /*db test.*/ 
       /*CONNECT  expiry   -ld sic_exp  -H 10.35.176.37 -S 9060 -N TCP -U value(gv_id) -P value(nv_pwd)  . */
      /*CONNECT expiry -H 18.10.100.5 -S expiry -ld sic_exp -N tcp -U value(gv_id) -P value(nv_pwd) */ .
      
      CLEAR FRAME nf00.
      HIDE FRAME nf00.

      RETURN. 
    
   END.

END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_susspect C-Win 
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
    nv_chanolist   = trim(wdetail.chasno)  
    nv_idnolist    = trim(wdetail.idno) .   
IF R-INDEX(trim(wdetail.name1)," ") <> 0 THEN  
    ASSIGN
    nn_namelist    = trim(SUBSTR(trim(wdetail.name1),1,R-INDEX(trim(wdetail.name1)," ")))
    nn_namelist2   = trim(SUBSTR(trim(wdetail.name1),R-INDEX(trim(wdetail.name1)," "))).
ELSE ASSIGN
    nn_namelist    = TRIM(trim(wdetail.name1)) 
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
        ASSIGN wdetail.comment = wdetail.comment + "|IDผู้เอาประกัน ติด suspect ID: " + nv_idnolist2 + " กรุณาติดต่อฝ่ายรับประกัน" 
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_TempPolicy C-Win 
PROCEDURE proc_TempPolicy :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN
nv_tmppol    = ""
nv_tmppolrun = nv_tmppolrun + 1
nv_tmppol    = nv_batchno + STRING(nv_tmppolrun, "999") .

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE Proc_usdcod C-Win 
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
/* ----- suthida T. A53-0275 27-09-10 ----- */
FIND FIRST ws0m009 WHERE 
    ws0m009.policy  = n_driver  AND
    ws0m009.lnumber = 1  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ws0m009 THEN  ASSIGN  nv_drivage1 =  inte(replace(trim(substr(ws0m009.ltext2,11,5)),"-","")).
/*ELSE nv_drivage1 = 0 .*/
FIND FIRST ws0m009 WHERE 
    ws0m009.policy  = n_driver  AND
    ws0m009.lnumber = 2  NO-LOCK NO-ERROR NO-WAIT.
IF AVAILABLE ws0m009 THEN  ASSIGN  nv_drivage2 =  inte(replace(trim(substr(ws0m009.ltext2,11,5)),"-","")).
/*ELSE nv_drivage2 = 0 .*/

ASSIGN
    nv_age1 = 0
    nv_age2 = 0
    nv_drivcod1 = ""
    nv_drivcod2 = ""
    nv_age1rate = 0
    nv_age2rate = 0.
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
    /*FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE*/ /* ------ suthida T. A52-0275 20-09-10 -------- */
    FIND FIRST sicsyac.xmm106 WHERE /* ------ suthida T. A52-0275 20-09-10 -------- */
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
         
    /*FIND FIRST sicsyac.xmm106 USE-INDEX xmm10601 WHERE*/ /* ------ suthida T. A52-0275 20-09-10 -------- */
    FIND FIRST sicsyac.xmm106 WHERE  /* ------ suthida T. A52-0275 20-09-10 -------- */
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

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd100 C-Win 
PROCEDURE proc_uwd100 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/*create  text (F17) for Query claim....*/
DEF BUFFER wf_uwd100 FOR sic_bran.uwd100.
DEF VAR nv_bptr      AS RECID.

nv_bptr = 0. /* ---- suthida T. A52-0275 27-09-10 ----*/

FOR EACH wuppertxt.
    DELETE wuppertxt.
END.
IF   wdetail.accessd <> "" THEN wdetail.accessd  = wdetail.accessd .
ELSE wdetail.accessd  = wdetail.accessd.
ASSIGN 
    nv_bptr  = 0
    nv_line1 = 1
    nv_txt1  = ""  
    nv_txt2  = ""
    nv_txt3  = ""
    /* --- suthida T. A54-0010 20-01-11 ---
    nv_txt4  = ""
    nv_txt5  = ""  
    nv_txt1  = "" 
    nv_txt2  = "วันที่คำขอ        : " + wdetail.datwork.
    nv_txt3  = "คนแจ้งงาน       : "   + wdetail.uswork . 
    nv_txt4  = "เลขที่รับแจ้ง       : " + wdetail.applino. 
    nv_txt5  = "".
    
    DO WHILE nv_line1 <= 5:
        CREATE wuppertxt.
        wuppertxt.line = nv_line1.
        IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
        IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
        IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
        IF nv_line1 = 4  THEN wuppertxt.txt = nv_txt4.
        IF nv_line1 = 5  THEN wuppertxt.txt = nv_txt5.
        nv_line1 = nv_line1 + 1.
    END.
      --- suthida T. A54-0010 20-01-11 --- */

 /* --- ADD suthida T. A54-0010 20-01-11 --- */
    nv_txt2  = "อุปกรณ์ตกแต่ง : " + wdetail.accessd .
    nv_txt3  = "".
DO WHILE nv_line1 <= 3:
    CREATE wuppertxt.
    wuppertxt.line = nv_line1.
    IF nv_line1 = 1  THEN wuppertxt.txt = nv_txt1.
    IF nv_line1 = 2  THEN wuppertxt.txt = nv_txt2.
    IF nv_line1 = 3  THEN wuppertxt.txt = nv_txt3.
    nv_line1 = nv_line1 + 1.
END.
 /* --- END suthida T. A54-0010 20-01-11 --- */

FIND sic_bran.uwm100 USE-INDEX uwm10001   WHERE 
     sic_bran.uwm100.policy  = wdetail.policy  AND
     sic_bran.uwm100.rencnt  = n_rencnt  AND
     sic_bran.uwm100.endcnt  = n_endcnt  AND
     sic_bran.uwm100.bchyr   = nv_batchyr    AND
     sic_bran.uwm100.bchno   = nv_batchno    AND
     sic_bran.uwm100.bchcnt  = nv_batcnt    
 NO-ERROR NO-WAIT.
IF AVAILABLE uwm100 THEN DO:
    ASSIGN nv_recid100 = RECID(uwm100).
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
END. /*uwm100*/
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwd102 C-Win 
PROCEDURE proc_uwd102 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEF VAR n_num1  AS INTE INIT 0.
DEF VAR n_num2  AS INTE INIT 0.
DEF VAR n_num3  AS INTE INIT 1.
DEF VAR i       AS INTE INIT 0.
DEF VAR nv_row  AS INTE Initial 1 . 
DEF VAR nv_nptr AS RECID.
/* ---- suthida T. A52-0275 27-09-10 ----- */
ASSIGN
  n_num1  = 0
  n_num2  = 0
  n_num3  = 1
  i       = 0
  nv_row  = 1
  nv_nptr = 0.

nv_fptr = 0.
nv_bptr = 0.
/*IF   wdetail.accessd <> "" THEN wdetail.accessd  = "อุปกรณ์ตกแต่ง : " + wdetail.accessd.
ELSE wdetail.accessd  = wdetail.accessd.*/ /*------- suthida T. A54-0010 20-01-11 ----------*/
IF   wdetail.nmember  <> "" THEN wdetail.nmember   = "หมายเหตุ        : " + wdetail.nmember.
ELSE wdetail.nmember = wdetail.nmember .

CREATE temp-item.
ASSIGN
  temp-item.ltext  = " "
  temp-item.lineNo = 1.


CREATE temp-item.
ASSIGN
  temp-item.ltext  = IF wdetail.w_type <> "RENEW" THEN  "วันที่คำขอ       : " + wdetail.datwork ELSE "เลขที่รับแจ้ง      : " + wdetail.datwork
  temp-item.lineNo = 2.                                                                         
                                                                                            
CREATE temp-item.                                                                               
ASSIGN                                                                                          
  temp-item.ltext  = IF wdetail.w_type <> "RENEW" THEN  "คนแจ้งงาน        : " + wdetail.uswork  ELSE "เลขที่กรมธรรม์เดิม  : " + wdetail.uswork
  temp-item.lineNo = 3.                                                                         
                                                                                            
CREATE temp-item.                                                                               
ASSIGN                                                                                          
  temp-item.ltext  = IF wdetail.w_type <> "RENEW" THEN "เลขที่รับแจ้ง     : " + wdetail.applino ELSE "เลขที่ใบคำขอ      : " +  wdetail.applino
  temp-item.lineNo = 4.

CREATE temp-item.
ASSIGN
  temp-item.ltext  = "เบอร์โทรศัพท์     : " + wdetail.Tel
  temp-item.lineNo = 5.

/* ------- suthida T. A54-0010 20-01-11 ----------
CREATE temp-item.
ASSIGN
  temp-item.ltext  = wdetail.accessd 
  temp-item.lineNo = 6.

CREATE temp-item.
ASSIGN
  temp-item.ltext  = wdetail.nmember.
  temp-item.lineNo = 7.
------- suthida T. A54-0010 20-01-11 ----------*/

/* ------- suthida T. A54-0010 20-01-11 ---------- */
CREATE temp-item.
ASSIGN
  temp-item.ltext  = wdetail.nmember.
  temp-item.lineNo = 6.
/* Comment by A59-0182......
FIND LAST wacctext WHERE wacctext.n_policytxt =  wdetail.policy NO-LOCK NO-ERROR .
    IF AVAIL wacctext THEN DO:
        CREATE temp-item.
        ASSIGN
            temp-item.ltext  = "ISP  : " + wacctext.n_textacc1 
            temp-item.lineNo = 7.

        CREATE temp-item.                
        ASSIGN                           
            temp-item.ltext  = "Campaign : " + wacctext.n_textacc2 
            temp-item.lineNo = 8.
    END.
.....end A59-0182....*/
 /* Create by A59-0182...*/
CREATE temp-item.
ASSIGN
    temp-item.ltext  = "ISP      : " + wdetail.ispno 
    temp-item.lineNo = 7.

CREATE temp-item.                
ASSIGN                           
    temp-item.ltext  = "Campaign : " + wdetail.camp 
    temp-item.lineNo = 8.

CREATE temp-item.                
ASSIGN                           
    temp-item.ltext  = "Tracking : " + wdetail.track 
    temp-item.lineNo = 9. 
/* end A59-0182 */
FOR EACH temp-item USE-INDEX  lineno:
   CREATE sic_bran.uwd102.
   ASSIGN
    sic_bran.uwd102.ltext   =  temp-item.ltext
    sic_bran.uwd102.policy  =  sic_bran.uwm100.policy
    sic_bran.uwd102.rencnt  =  sic_bran.uwm100.rencnt
    sic_bran.uwd102.endcnt  =  sic_bran.uwm100.endcnt
    nv_fptr        =  RECID(sic_bran.uwd102).
   IF  nv_bptr = 0  THEN DO:
     ASSIGN
        sic_bran.uwm100.fptr02 = RECID(sic_bran.uwd102)                   
        sic_bran.uwd102.fptr   = 0  
        sic_bran.uwd102.bptr   = 0                                  
        nv_fptr       = RECID(sic_bran.uwd102)
        nv_bptr       = RECID(sic_bran.uwd102).
   END.
   ELSE DO:
       FIND FIRST sic_bran.uwd102  WHERE RECID(sic_bran.uwd102) = nv_bptr NO-ERROR.
         IF AVAIL sic_bran.uwd102  THEN sic_bran.uwd102.fptr  = nv_fptr.

       FIND FIRST sic_bran.uwd102  WHERE RECID(sic_bran.uwd102) =  nv_fptr NO-ERROR.
         IF AVAIL sic_bran.uwd102 THEN DO:
            ASSIGN
             sic_bran.uwd102.bptr = nv_bptr
             sic_bran.uwd102.fptr = 0
             nv_bptr     = RECID(sic_bran.uwd102).             
         END.
   END.  
END.
sic_bran.uwm100.bptr02 = nv_bptr.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm120 C-Win 
PROCEDURE proc_uwm120 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:   /*  RUN proc_chktest4. */    
------------------------------------------------------------------------------*/
DEF VAR   n_sigr_r     LIKE sic_bran.uwm130.uom6_v.
DEF VAR   n_gap_r      LIKE sic_bran.uwd132.gap_c . 
DEF VAR   n_prem_r     LIKE sic_bran.uwd132.prem_c.
DEF VAR   nt_compprm   LIKE sic_bran.uwd132.prem_c.  
DEF VAR   n_gap_t      LIKE sic_bran.uwm100.gap_p.
DEF VAR   n_prem_t     LIKE sic_bran.uwm100.prem_t.
DEF VAR   n_sigr_t     LIKE sic_bran.uwm100.sigr_p.
DEF VAR   nv_policy    LIKE sic_bran.uwm100.policy.
DEF VAR   nv_rencnt    LIKE sic_bran.uwm100.rencnt.
DEF VAR   nv_endcnt    LIKE sic_bran.uwm100.endcnt.
DEF VAR   nv_com1_per  LIKE sicsyac.xmm031.comm1.
DEF VAR   nv_stamp_per LIKE sicsyac.xmm020.rvstam.
DEF VAR   nv_com2p        AS DECI INIT 0.00 .
DEF VAR   nv_com1p        AS DECI INIT 0.00 .
DEF VAR   nv_fi_netprm    AS DECI INIT 0.00.
DEF VAR   NV_fi_dup_trip  AS CHAR FORMAT  "X" INIT "".
DEF VAR   nv_fi_tax_per   AS DECI INIT 0.00.
DEF VAR   nv_fi_stamp_per AS DECI INIT 0.00.
/*DEF VAR   nv_fi_rstp_t    AS INTE INIT 0.*/ /* suthida T. A52-0275 27-09-10 */
DEF VAR   nv_fi_rstp_t    AS DECI INIT 0.     /* suthida T. A52-0275 27-09-10 */
DEF VAR   nv_fi_rtax_t    AS DECI INIT 0.00 .
DEF VAR   nv_fi_com1_t    AS DECI INIT 0.00.
DEF VAR   nv_fi_com2_t    AS DECI INIT 0.00.

/* ----- suthida T. A52-0275 27-09-10 ----- */
ASSIGN
  n_sigr_r      = 0        nv_com2p         = 0 
  n_gap_r       = 0        nv_com1p         = 0 
  n_prem_r      = 0        nv_fi_netprm     = 0 
  nt_compprm    = 0        NV_fi_dup_trip   = "" 
  n_gap_t       = 0        nv_fi_tax_per    = 0 
  n_prem_t      = 0        nv_fi_stamp_per  = 0 
  n_sigr_t      = 0        nv_fi_rstp_t     = 0 
  nv_policy     = ""       nv_fi_rtax_t     = 0 
  nv_rencnt     = 0        nv_fi_com1_t     = 0 
  nv_endcnt     = 0        nv_fi_com2_t     = 0 
  nv_com1_per   = 0        nv_stamp_per     = 0 .

FIND sic_bran.uwm100   WHERE RECID(sic_bran.uwm100)  = s_recid1 NO-ERROR NO-WAIT.
  IF  NOT AVAIL sic_bran.uwm100  THEN DO:
      /*Message "not found (uwm100./wuwrep02.p)" View-as alert-box.*/
      RETURN.
  END.
  ELSE  DO:
      ASSIGN 
            nv_policy  =  CAPS(sic_bran.uwm100.policy)
            nv_rencnt  =  sic_bran.uwm100.rencnt
            nv_endcnt  =  sic_bran.uwm100.endcnt.
            /*FOR EACH sic_bran.uwm120 USE-INDEX uwm12001 WHERE*/ /* ----------- suthida T. A53-0275 -------- */
            FOR EACH sic_bran.uwm120 WHERE /* ----------- suthida T. A53-0275 -------- */
                     sic_bran.uwm120.policy  = sic_bran.uwm100.policy AND
                     sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt AND
                     sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND
                     sic_bran.uwm120.bchyr   = nv_batchyr             AND 
                     sic_bran.uwm120.bchno   = nv_batchno             AND 
                     sic_bran.uwm120.bchcnt  = nv_batcnt         .
                     /*FOR EACH sic_bran.uwm130   USE-INDEX uwm13001 WHERE*/ /* ----------- suthida T. A53-0275 -------- */
                     FOR EACH sic_bran.uwm130   WHERE /* ----------- suthida T. A53-0275 -------- */
                              sic_bran.uwm130.policy  = sic_bran.uwm120.policy  AND 
                              sic_bran.uwm130.rencnt  = sic_bran.uwm120.rencnt  AND 
                              sic_bran.uwm130.endcnt  = sic_bran.uwm120.endcnt  AND 
                              sic_bran.uwm130.riskno  = sic_bran.uwm120.riskno  AND 
                              sic_bran.uwm130.bchyr   = nv_batchyr              AND 
                              sic_bran.uwm130.bchno   = nv_batchno              AND 
                              sic_bran.uwm130.bchcnt  = nv_batcnt               NO-LOCK.
                         n_sigr_r  = n_sigr_r + uwm130.uom6_v.
                         /*FOR EACH sic_bran.uwd132  USE-INDEX uwd13201 WHERE */ /* ----------- suthida T. A53-0275 -------- */
                         FOR EACH sic_bran.uwd132  WHERE  /* ----------- suthida T. A53-0275 -------- */
                                 sic_bran.uwd132.policy  = sic_bran.uwm130.policy  AND
                                 sic_bran.uwd132.rencnt  = sic_bran.uwm130.rencnt  AND
                                 sic_bran.uwd132.endcnt  = sic_bran.uwm130.endcnt  AND
                                 sic_bran.uwd132.riskno  = sic_bran.uwm130.riskno  AND
                                 sic_bran.uwd132.itemno  = sic_bran.uwm130.itemno  AND
                                 sic_bran.uwd132.bchyr   = nv_batchyr              AND 
                                 sic_bran.uwd132.bchno   = nv_batchno              AND 
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
  /*FIND LAST  sic_bran.uwm120  USE-INDEX uwm12001  WHERE  */ /* ----------- suthida T. A53-0275 -------- */
  FIND LAST  sic_bran.uwm120  WHERE /* ----------- suthida T. A53-0275 -------- */
             sic_bran.uwm120.policy  = sic_bran.uwm100.policy And
             sic_bran.uwm120.rencnt  = sic_bran.uwm100.rencnt And
             sic_bran.uwm120.endcnt  = sic_bran.uwm100.endcnt AND 
             sic_bran.uwm120.bchyr   = nv_batchyr             AND 
             sic_bran.uwm120.bchno   = nv_batchno             AND 
             sic_bran.uwm120.bchcnt  = nv_batcnt              NO-ERROR.
  FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
             sicsyac.xmm018.agent              = sic_bran.uwm100.acno1          AND               /*แยกงานตาม Code Producer*/  
             SUBSTR(sicsyac.xmm018.poltyp,1,5) = "CR" + sic_bran.uwm100.poltyp  AND               /*Shukiat T. modi on 25/04/2007*/
             SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch         AND               /*Shukiat T. add on 05/06/2007 A50-0144*/
             sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat         NO-LOCK NO-ERROR. /*Shukiat T. add on 25/04/2007*/
  IF AVAIL   sicsyac.xmm018 THEN 
            ASSIGN     /*nv_com1p = sicsyac.xmm018.commsp */    /*A59-0182*/
                       nv_com1p = IF wdetail.producer = "A0M0127" THEN 15.00 ELSE sicsyac.xmm018.commsp /*A59-0182*/
                       nv_com2p = 0.
  ELSE DO:
          FIND sicsyac.xmm031  USE-INDEX xmm03101  WHERE  
               sicsyac.xmm031.poltyp  = sic_bran.uwm100.poltyp NO-LOCK NO-ERROR NO-WAIT.
          IF NOT AVAIL sicsyac.xmm031 THEN 
            ASSIGN     nv_com1p = 0
                       nv_com2p = 0.
          ELSE  
            ASSIGN     /*nv_com1p = sicsyac.xmm031.comm1*/  /*A59-0182*/
                       nv_com1p = IF wdetail.producer = "A0M0127" THEN 15.00 ELSE sicsyac.xmm031.comm1  /*A59-0182*/
                       nv_com2p = 0 .
  END. /* Not Avail Xmm018 */

  /***--- Commmission Rate Line 72 ---***/
  IF wdetail.compul = "y" THEN DO:
      FIND LAST  sicsyac.xmm018 USE-INDEX xmm01801 WHERE
                 sicsyac.xmm018.agent              = sic_bran.uwm100.acno1  AND               
                 SUBSTR(sicsyac.xmm018.poltyp,1,5) = "CRV72"                AND               
                 SUBSTR(xmm018.poltyp,7,1)         = sic_bran.uwm100.branch AND               
                 sicsyac.xmm018.datest            <= sic_bran.uwm100.comdat NO-LOCK NO-ERROR. 
      IF AVAIL   sicsyac.xmm018 THEN 
                 /*nv_com2p = sicsyac.xmm018.commsp.*/  /*A59-0182*/
                   nv_com2p = IF wdetail.producer = "A0M0127" THEN 5.00 ELSE sicsyac.xmm018.commsp. /*A59-0182*/
      ELSE DO:
           FIND  sicsyac.xmm031  USE-INDEX xmm03101  WHERE  
                 sicsyac.xmm031.poltyp    = "V72" NO-LOCK NO-ERROR NO-WAIT.
                   /*nv_com2p = sicsyac.xmm031.comm1.*/     /*A59-0182*/
                   nv_com2p = IF wdetail.producer = "A0M0127" THEN 5.00 ELSE sicsyac.xmm031.comm1.  /*A59-0182*/
      END.
  END. /* Wdetail.Compul = "Y"*/

  /*--------- tax & stamp -----------*/
.
  FIND sicsyac.xmm020 USE-INDEX xmm02001        WHERE
       sicsyac.xmm020.branch = sic_bran.uwm100.branch   AND
       sicsyac.xmm020.dir_ri = sic_bran.uwm100.dir_ri   NO-LOCK NO-ERROR.
  IF AVAIL sicsyac.xmm020 THEN DO:
           nv_fi_stamp_per      = sicsyac.xmm020.rvstam. /* stamp */
       IF    sic_bran.uwm100.gstrat  <>  0  THEN  nv_fi_tax_per  =  sic_bran.uwm100.gstrat.
       ELSE  nv_fi_tax_per  =  sicsyac.xmm020.rvtax. /* TAX */
  END.

  /*----------- stamp ------------*/
  IF sic_bran.uwm120.stmpae  = YES THEN DO:                        /* STAMP */
     nv_fi_rstp_t  = TRUNCATE(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) +
                     (IF     (sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100)   -
                     TRUNCATE(sic_bran.uwm100.prem_t * nv_fi_stamp_per / 100,0) > 0
                     THEN 1 ELSE 0).
  END.

  /*--------- tax -----------*/
  sic_bran.uwm100.rstp_t = nv_fi_rstp_t.
  IF  sic_bran.uwm120.taxae   = YES   THEN DO:                        /* TAX */
      nv_fi_rtax_t  = (sic_bran.uwm100.prem_t + nv_fi_rstp_t + sic_bran.uwm100.pstp)
                       * nv_fi_tax_per  / 100.
       /* fi_taxae       = Yes.*/
  END.

  ASSIGN
    sic_bran.uwm100.rtax_t = nv_fi_rtax_t
    sic_bran.uwm120.com1ae = YES
    sic_bran.uwm120.com2ae = YES.

 
    /*--------- motor commission -----------------*/
    IF sic_bran.uwm120.com1ae   = YES THEN DO:                   /* MOTOR COMMISION */
       IF sic_bran.uwm120.com1p <> 0  THEN
             nv_com1p  = sic_bran.uwm120.com1p.
             nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.            
           /*fi_com1ae        =  YES.*/
    END.
    
    /*----------- comp comission ------------*/
    IF sic_bran.uwm120.com2ae   = YES  THEN DO:                   /* Comp.COMMISION */
        If sic_bran.uwm120.com2p <> 0  THEN nv_com2p  = sic_bran.uwm120.com2p.
             nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.              
           /*nv_fi_com2ae        =  YES.*/
    END.
  
  /*---- start : A59-0182----*/
  IF wdetail.producer = "A0M0127" THEN DO: /*A59-0182*/
      /*--------- motor commission -----------------*/
      IF sic_bran.uwm120.com1ae   = YES THEN DO:                   /* MOTOR COMMISION */
         IF sic_bran.uwm120.com1p <> 0  THEN 
               ASSIGN nv_com1p  = sic_bran.uwm120.com1p     
                      nv_com1p  = 15.00 . 
               nv_fi_com1_t   =  - (sic_bran.uwm100.prem_t - nt_compprm) * nv_com1p / 100.       
      END.
      
      /*----------- comp comission ------------*/
      IF sic_bran.uwm120.com2ae   = YES  THEN DO:                  
          If sic_bran.uwm120.com2p <> 0  THEN 
              assign 
               nv_com2p  = sic_bran.uwm120.com2p
               nv_com2p  = 5.00 .
               nv_fi_com2_t   =  - nt_compprm  *  nv_com2p / 100.         
      END.
  END.  
  /*---- end A59-0182-----*/

  IF sic_bran.uwm100.pstp <> 0 THEN DO:
     IF sic_bran.uwm100.no_sch  = 1 THEN NV_fi_dup_trip = "D".
     Else If sic_bran.uwm100.no_sch  = 2 THEN  NV_fi_dup_trip = "T".
  END.
  ELSE  NV_fi_dup_trip  =  "".

  nv_fi_netprm = sic_bran.uwm100.prem_t + sic_bran.uwm100.rtax_t
               + sic_bran.uwm100.rstp_t + sic_bran.uwm100.pstp.

  FIND     sic_bran.uwm100 WHERE  RECID(sic_bran.uwm100)  =  s_recid1.
  IF AVAIL sic_bran.uwm100 THEN 
      ASSIGN 
           sic_bran.uwm100.gap_p   = n_gap_t
           sic_bran.uwm100.prem_t  = n_prem_t
           sic_bran.uwm100.sigr_p  = n_sigr_t
           sic_bran.uwm100.instot  = uwm100.instot
           sic_bran.uwm100.com1_t  = nv_fi_com1_t
           sic_bran.uwm100.com2_t  = nv_fi_com2_t
           sic_bran.uwm100.pstp    = 0               /*note modified on 25/10/2006*/
           sic_bran.uwm100.rstp_t  = nv_fi_rstp_t
           sic_bran.uwm100.rtax_t  = nv_fi_rtax_t          
           sic_bran.uwm100.gstrat  = nv_fi_tax_per.

  IF (wdetail.poltyp = "V72") OR (wdetail.poltyp = "V74") THEN 
            ASSIGN  
           sic_bran.uwm100.com2_t  = 0 
           sic_bran.uwm100.com1_t  = nv_fi_com2_t.

  FIND     sic_bran.uwm120 WHERE  RECID(sic_bran.uwm120)   =  s_recid2.
  IF AVAIL sic_bran.uwm120 THEN DO:
       ASSIGN
          sic_bran.uwm120.gap_r    = n_gap_t   /*n_gap_r */
          sic_bran.uwm120.prem_r   = n_prem_t  /*n_prem_r */
          sic_bran.uwm120.sigr     = n_sigr_T  /* A490166 note modi from n_sigr_r to n_sigr_t 11/10/2006 */
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
             
       IF (wdetail.poltyp = "V72") OR (wdetail.poltyp = "V74") THEN 
          ASSIGN  
            sic_bran.uwm120.com2_r    = 0 
            sic_bran.uwm120.com1_r    = nv_fi_com2_t
            sic_bran.uwm120.com1p     = nv_com2p
            sic_bran.uwm120.com2p     = 0
            sic_bran.uwm120.rstp_r    = nv_fi_rstp_t 
            sic_bran.uwm120.rtax      = nv_fi_rtax_t.

  END. /*FIND     sic_bran.uwm120 */
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_uwm130 C-Win 
PROCEDURE proc_uwm130 :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
ASSIGN np_driver = "".
FIND sic_bran.uwm130 USE-INDEX uwm13001 WHERE
    sic_bran.uwm130.policy = sic_bran.uwm100.policy AND 
    sic_bran.uwm130.rencnt = sic_bran.uwm100.rencnt AND 
    sic_bran.uwm130.endcnt = sic_bran.uwm100.endcnt AND 
    sic_bran.uwm130.riskgp = s_riskgp               AND            /*0*/
    sic_bran.uwm130.riskno = s_riskno               AND            /*1*/
    sic_bran.uwm130.itemno = s_itemno               AND            /*1*/
    sic_bran.uwm130.bchyr  = nv_batchyr             AND 
    sic_bran.uwm130.bchno  = nv_batchno             AND 
    sic_bran.uwm130.bchcnt = nv_batcnt              NO-WAIT NO-ERROR.
IF NOT AVAILABLE uwm130 THEN DO:
    DO TRANSACTION:
        CREATE sic_bran.uwm130.
        ASSIGN sic_bran.uwm130.policy = sic_bran.uwm120.policy
            sic_bran.uwm130.rencnt    = sic_bran.uwm120.rencnt   sic_bran.uwm130.endcnt = sic_bran.uwm120.endcnt
            sic_bran.uwm130.riskgp    = sic_bran.uwm120.riskgp   sic_bran.uwm130.riskno = sic_bran.uwm120.riskno
            sic_bran.uwm130.itemno    = s_itemno
            sic_bran.uwm130.bchyr     = nv_batchyr       /* batch Year */
            sic_bran.uwm130.bchno     = nv_batchno       /* bchno      */
            sic_bran.uwm130.bchcnt    = nv_batcnt.       /* bchcnt     */
            np_driver = TRIM(sic_bran.uwm130.policy) +          /*A59-0182*/
                    STRING(sic_bran.uwm130.rencnt,"99" ) +      /*A59-0182*/
                    STRING(sic_bran.uwm130.endcnt,"999") +      /*A59-0182*/
                    STRING(sic_bran.uwm130.riskno,"999") +      /*A59-0182*/
                    STRING(sic_bran.uwm130.itemno,"999").       /*A59-0182*/
        IF wdetail.access = "1" THEN  nv_uom6_u =  "A".
        ELSE  
            ASSIGN nv_uom6_u  = ""      nv_othcod     = ""
                nv_othvar1    = ""      nv_othvar2    = ""
                SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        ASSIGN nv_sclass = SUBSTRING(wdetail.class,2,3).
        /* ------ Suthida T. A54-0010 02-03-11 ----------- 
        IF nv_uom6_u  =  "A"  THEN DO:
            IF  nv_sclass  =  "320"  OR  nv_sclass  =  "340"  OR
                nv_sclass  =  "520"  OR  nv_sclass  =  "540"  
                THEN  nv_uom6_u  =  "A".         
            ELSE
                ASSIGN wdetail.pass    = "N".
                    wdetail.comment = wdetail.comment + "| Classนี้ ไม่รับอุปกรณ์เพิ่มพิเศษ". 
        END. ------ Suthida T. A54-0010 02-03-11 -----------  */
        IF CAPS(nv_uom6_u) = "A"  THEN
            ASSIGN nv_uom6_u           = "A"
            nv_othcod                  = "OTH"
            nv_othvar1                 = "     Accessory  = "
            nv_othvar2                 = STRING(nv_uom6_u)
            SUBSTRING(nv_othvar,1,30)  = nv_othvar1
            SUBSTRING(nv_othvar,31,30) = nv_othvar2.
        ELSE
            ASSIGN  nv_uom6_u     = ""      nv_othcod         = ""
                nv_othvar1        = ""      nv_othvar2        = ""
                SUBSTRING(nv_othvar,1,30)  = nv_othvar1
                SUBSTRING(nv_othvar,31,30) = nv_othvar2.

        IF (wdetail.covcod = "1") OR (wdetail.covcod = "5")  THEN 
            ASSIGN
            /*             sic_bran.uwm130.uom6_v   = INTE(wdetail.si)  */
            /*             sic_bran.uwm130.uom7_v   = INTE(wdetail.si)  */
            sic_bran.uwm130.uom6_v   = wdetail.si /* ---- suthida t . a52-0275 27-09-10 ------ */
            sic_bran.uwm130.uom7_v   = wdetail.si /* ---- suthida t . a52-0275 27-09-10 ------ */
            sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
            sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
            sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
            sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
            sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        /* ---- suthida T. A54-0010 21-06-11 ----  */
        IF wdetail.prepol <>  "" THEN 
            ASSIGN sic_bran.uwm130.uom1_v = n_uom1_v
            sic_bran.uwm130.uom2_v        = n_uom2_v
            sic_bran.uwm130.uom5_v        = n_uom5_v
            wdetail.uom1_v                = n_uom1_v
            wdetail.uom2_v                = n_uom2_v
            wdetail.uom5_v                = n_uom5_v
            sic_bran.uwm130.uom6_v        = wdetail.si
            sic_bran.uwm130.uom7_v        = n_uom7_v.
         /*  ---- suthida T. A54-0010 21-06-11 ---- */
        IF wdetail.covcod = "2"  THEN 
            ASSIGN sic_bran.uwm130.uom6_v   = 0
           /*             sic_bran.uwm130.uom7_v   = INTE(wdetail.si) */
           sic_bran.uwm130.uom7_v   = wdetail.si  /* ---- suthida t . a52-0275 27-09-10 ------ */
           sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
           sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
           sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
           sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
           sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
           /*  ---- suthida T. A54-0010 21-06-11 ---- */
        IF wdetail.prepol <>  "" THEN 
            ASSIGN sic_bran.uwm130.uom6_v   = wdetail.si
                   sic_bran.uwm130.uom7_v   = n_uom7_v.
        /*  ---- suthida T. A54-0010 21-06-11 ---- */
        IF wdetail.covcod = "3"  THEN 
           ASSIGN sic_bran.uwm130.uom6_v   = 0
           sic_bran.uwm130.uom7_v   = 0
           sic_bran.uwm130.fptr01   = 0     sic_bran.uwm130.bptr01 = 0  /*Item Upper text*/
           sic_bran.uwm130.fptr02   = 0     sic_bran.uwm130.bptr02 = 0  /*Item Lower Text*/
           sic_bran.uwm130.fptr03   = 0     sic_bran.uwm130.bptr03 = 0  /*Cover & Premium*/
           sic_bran.uwm130.fptr04   = 0     sic_bran.uwm130.bptr04 = 0  /*Item Endt. Text*/
           sic_bran.uwm130.fptr05   = 0     sic_bran.uwm130.bptr05 = 0. /*Item Endt. Clause*/
        /*  ---- suthida T. A54-0010 21-06-11 ---- */
        IF wdetail.prepol <>  "" THEN 
            ASSIGN sic_bran.uwm130.uom6_v   = wdetail.si
                   sic_bran.uwm130.uom7_v   = n_uom7_v.
        /*  ---- suthida T. A54-0010 21-06-11 ---- */
        FIND FIRST stat.clastab_fil USE-INDEX clastab01 WHERE
            stat.clastab_fil.class   = wdetail.class    AND
            stat.clastab_fil.covcod  = wdetail.covcod   NO-LOCK  NO-ERROR NO-WAIT.
        IF AVAIL stat.clastab_fil THEN DO: 
            ASSIGN
                /* comment by A63-0162...
                sic_bran.uwm130.uom1_v     =  stat.clastab_fil.uom1_si
                sic_bran.uwm130.uom2_v     =  stat.clastab_fil.uom2_si
                sic_bran.uwm130.uom5_v     =  stat.clastab_fil.uom5_si
                .. end A63-0162..*/
                 /* add by A63-0162...*/
                sic_bran.uwm130.uom1_v     = if wdetail.uom1_v <> 0 then wdetail.uom1_v else stat.clastab_fil.uom1_si
                sic_bran.uwm130.uom2_v     = if wdetail.uom2_v <> 0 then wdetail.uom2_v else stat.clastab_fil.uom2_si
                sic_bran.uwm130.uom5_v     = if wdetail.uom5_v <> 0 then wdetail.uom5_v else stat.clastab_fil.uom5_si
                /*.. end A63-0162..*/
                sic_bran.uwm130.uom8_v     =  stat.clastab_fil.uom8_si                
                sic_bran.uwm130.uom9_v     =  stat.clastab_fil.uom9_si          
                sic_bran.uwm130.uom3_v     =  0
                sic_bran.uwm130.uom4_v     =  0
                wdetail.comper             =  STRING(stat.clastab_fil.uom8_si)                
                wdetail.comacc             =  STRING(stat.clastab_fil.uom9_si)
                nv_uom1_v                  =  sic_bran.uwm130.uom1_v   
                nv_uom2_v                  =  sic_bran.uwm130.uom2_v
                nv_uom5_v                  =  sic_bran.uwm130.uom5_v        
                sic_bran.uwm130.uom1_c  = "D1"
                sic_bran.uwm130.uom2_c  = "D2"
                sic_bran.uwm130.uom5_c  = "D5"
                sic_bran.uwm130.uom6_c  = "D6"
                sic_bran.uwm130.uom7_c  = "D7".
            /*IF SUBSTRING(wdetail.class,1,1) = "Z" then */ /*A59-0029*/
            IF SUBSTRING(wdetail.class,1,1) = "Z" THEN DO:
                ASSIGN  sic_bran.uwm130.uom1_v  = wdetail.uom1_v 
                    sic_bran.uwm130.uom2_v      = wdetail.uom2_v 
                    sic_bran.uwm130.uom5_v      = wdetail.uom5_v 
                    nv_uom1_v                   = wdetail.uom1_v 
                    nv_uom2_v                   = wdetail.uom2_v 
                    nv_uom5_v                   = wdetail.uom5_v  
                    WDETAIL.seat41              = WDETAIL.seat  .
            END.
            ELSE IF wdetail.prepol <>  "" THEN DO:  
                ASSIGN sic_bran.uwm130.uom1_v  = n_uom1_v
                    sic_bran.uwm130.uom2_v     = n_uom2_v
                    sic_bran.uwm130.uom5_v     = n_uom5_v.
                IF  wdetail.garage  =  "G"  THEN                                        
                    ASSIGN 
                    WDETAIL.no_41   =  WDETAIL.no_41 
                    WDETAIL.no_42   =  WDETAIL.no_42 
                    WDETAIL.no_43   =  WDETAIL.no_43 
                    WDETAIL.seat41  =  WDETAIL.seat41.
            END.
            ELSE DO: 
                /* update by A63-0162 ถ้ามีข้อมูลในไฟล์โหลดให้ใช้จากไฟล์ */
                IF  wdetail.garage  =  "G"  THEN                                        
                    ASSIGN WDETAIL.no_41 = if WDETAIL.no_41  <> 0 then WDETAIL.no_41  else stat.clastab_fil.si_41unp        
                    WDETAIL.no_42        = if WDETAIL.no_42  <> 0 then WDETAIL.no_42  else stat.clastab_fil.si_42                  
                    WDETAIL.no_43        = if WDETAIL.no_43  <> 0 then WDETAIL.no_43  else stat.clastab_fil.si_43                  
                    WDETAIL.seat41       = if WDETAIL.seat41 <> 0 then WDETAIL.seat41 else stat.clastab_fil.dri_41 + clastab_fil.pass_41. 
                ELSE 
                    Assign 
                        WDETAIL.no_41   =  if WDETAIL.no_41  <> 0 then WDETAIL.no_41  else stat.clastab_fil.si_41unp
                        WDETAIL.no_42   =  if WDETAIL.no_42  <> 0 then WDETAIL.no_42  else stat.clastab_fil.si_42
                        WDETAIL.no_43   =  if WDETAIL.no_43  <> 0 then WDETAIL.no_43  else stat.clastab_fil.si_43
                        WDETAIL.seat41   = if WDETAIL.seat41 <> 0 then WDETAIL.seat41 else stat.clastab_fil.dri_41 + stat.clastab_fil.pass_41.
            END.
        END.    /*stat.clastab_fil*/
    END.        /* end Do transaction*/
END.
/*---------- A59-0029------------------*/
IF wdetail.covcod = "1" THEN 
    RUN proc_chksum (INPUT wdetail.policy,                          
                     INPUT s_riskno,
                     INPUT s_itemno,
                     INPUT nv_batchyr,  
                     INPUT nv_batchno, 
                     INPUT nv_batcnt).
/*---------- A59-0029------------------*/
ASSIGN 
    s_recid3  = RECID(sic_bran.uwm130)
    nv_covcod =   wdetail.covcod
    nv_makdes  =  wdetail.brand
    nv_moddes  =  wdetail.model
    nv_newsck = " ".
RUN proc_chassic.

IF SUBSTRING(wdetail.stk,1,1) = "2" THEN nv_newsck = "0" + wdetail.stk.
ELSE nv_newsck =  wdetail.stk.

FIND sic_bran.uwm301 USE-INDEX uwm30101      WHERE
    sic_bran.uwm301.policy = sic_bran.uwm100.policy    AND
    sic_bran.uwm301.rencnt = sic_bran.uwm100.rencnt    AND
    sic_bran.uwm301.endcnt = sic_bran.uwm100.endcnt    AND
    sic_bran.uwm301.riskgp = s_riskgp                  AND
    sic_bran.uwm301.riskno = s_riskno                  AND
    sic_bran.uwm301.itemno = s_itemno                  AND
    sic_bran.uwm301.bchyr  = nv_batchyr                AND 
    sic_bran.uwm301.bchno  = nv_batchno                AND 
    sic_bran.uwm301.bchcnt = nv_batcnt     NO-WAIT NO-ERROR.
IF NOT AVAILABLE sic_bran.uwm301 THEN DO:                  
    DO TRANSACTION:
        CREATE sic_bran.uwm301.
        ASSIGN
            sic_bran.uwm301.policy    = sic_bran.uwm120.policy                 
            sic_bran.uwm301.rencnt    = sic_bran.uwm120.rencnt
            sic_bran.uwm301.endcnt    = sic_bran.uwm120.endcnt
            sic_bran.uwm301.riskgp    = sic_bran.uwm120.riskgp
            sic_bran.uwm301.riskno    = sic_bran.uwm120.riskno
            sic_bran.uwm301.itemno    = s_itemno
            sic_bran.uwm301.tariff    = wdetail.tariff 
            sic_bran.uwm301.covcod    = nv_covcod
            sic_bran.uwm301.cha_no    = wdetail.chasno
            /*sic_bran.uwm301.trareg    = " "  --- suthida t. A54-0010 18-04-11 ----------- */
            sic_bran.uwm301.trareg    =  wdetail.chasno /* --- suthida t. A54-0010 18-04-11 ----------- */
            sic_bran.uwm301.eng_no    = wdetail.eng
            sic_bran.uwm301.Tons      = INTEGER(wdetail.weight)
            sic_bran.uwm301.engine    = INTEGER(wdetail.engcc)
            sic_bran.uwm301.yrmanu    = INTEGER(wdetail.caryear)
            sic_bran.uwm301.garage    = wdetail.garage
            sic_bran.uwm301.body      = wdetail.body
            sic_bran.uwm301.seats     = INTEGER(wdetail.seat)
            sic_bran.uwm301.mv_ben83  = wdetail.benname
            sic_bran.uwm301.vehreg    = wdetail.vehreg 
            /*sic_bran.uwm301.yrmanu    = INTE(wdetail.caryear)  ------ suthida T. A54-0010 30-06-11 --------- */
            sic_bran.uwm301.vehuse    = wdetail.vehuse
            sic_bran.uwm301.moddes    = wdetail.brand + " " + wdetail.model   
            sic_bran.uwm301.sckno     = 0
            sic_bran.uwm301.itmdel    = NO
            sic_bran.uwm301.car_color = wdetail.ncolor                           /* A66-0108 */
            sic_bran.uwm301.logbok    = IF wdetail.ispno <> "" THEN "Y" ELSE ""  /* A66-0108 */
             /*sic_bran.uwm301.mv_ben83  =  "บริษัท ลีสซิ่งกสิกรไทย จำกัด"   /* ---- Suthida T. A54-0010 20-01-11 ---- */*/ /*A59-0182*/
            sic_bran.uwm301.mv_ben83  = IF wdetail.w_type = "RENEW" THEN wdetail.benname ELSE "บริษัท ลีสซิ่งกสิกรไทย จำกัด"  /*A59-0182*/
            wdetail.tariff            = sic_bran.uwm301.tariff.
        IF wdetail.compul = "y" THEN DO:
            sic_bran.uwm301.cert = "".
            IF LENGTH(wdetail.stk) = 11  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"99999999999"). 
            IF LENGTH(wdetail.stk) = 13  THEN sic_bran.uwm301.drinam[9] = "STKNO:" + STRING(wdetail.stk,"9999999999999").
            IF wdetail.stk = ""  THEN sic_bran.uwm301.drinam[9] = "".
            FIND FIRST brStat.Detaitem USE-INDEX detaitem11 WHERE
                brStat.Detaitem.serailno = wdetail.stk  NO-LOCK NO-ERROR .
            IF NOT AVAIL brstat.Detaitem THEN DO:     
                CREATE brstat.Detaitem.
                ASSIGN
                    brStat.Detaitem.Policy   = sic_bran.uwm301.Policy
                    brStat.Detaitem.RenCnt   = sic_bran.uwm301.RenCnt
                    brStat.Detaitem.EndCnt   = sic_bran.uwm301.Endcnt
                    brStat.Detaitem.RiskNo   = sic_bran.uwm301.RiskNo
                    brStat.Detaitem.ItemNo   = sic_bran.uwm301.ItemNo
                    brStat.Detaitem.serailno = wdetail.stk.  
            END.
        END.
        /*-------- A59-0029-----------*/
        IF wdetail.accessd <> "" THEN DO: 
                 RUN proc_prmtxt.
                 ASSIGN 
                     SUBSTRING(sic_bran.uwm301.prmtxt,1,60)   =  nv_acc1
                     SUBSTRING(sic_bran.uwm301.prmtxt,61,60)  =  nv_acc2
                     SUBSTRING(sic_bran.uwm301.prmtxt,121,60) =  nv_acc3
                     SUBSTRING(sic_bran.uwm301.prmtxt,181,60) =  nv_acc4
                     SUBSTRING(sic_bran.uwm301.prmtxt,241,60) =  nv_acc5
                     SUBSTRING(sic_bran.uwm301.prmtxt,301,60) =  nv_acc6. 
        END.
        /*-------- end A59-0029 ----------*/
        ASSIGN  sic_bran.uwm301.bchyr = nv_batchyr       /* batch Year */
            sic_bran.uwm301.bchno = nv_batchno       /* bchno      */
            sic_bran.uwm301.bchcnt  = nv_batcnt.      /* bchcnt     */
        IF wdetail.drivername1 <> "" THEN wdetail.drivnam = "Y".
        ELSE wdetail.drivnam = "N".
        IF  wdetail.drivnam = "Y" THEN RUN proc_mailtxt.
        /*A59-0182*/
        IF n_driver = ""  THEN ASSIGN nv_drivno = 0. /* driver name renew */
        ELSE RUN pd_mailtxtrenew.
        /*A59-0182*/
        s_recid4         = RECID(sic_bran.uwm301).
        IF wdetail.redbook <> "" /*AND chkred = YES*/ THEN DO:
            FIND FIRST stat.maktab_fil USE-INDEX maktab01 
                WHERE  stat.maktab_fil.sclass = SUBSTRING(wdetail.class,2,3)      AND
                       stat.maktab_fil.modcod = wdetail.redbook   NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL  stat.maktab_fil  THEN
                ASSIGN sic_bran.uwm301.modcod  =  stat.maktab_fil.modcod                                    
                sic_bran.uwm301.moddes =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes 
                wdetail.cargrp         =  maktab_fil.prmpac
                sic_bran.uwm301.vehgrp =  stat.maktab_fil.prmpac
                sic_bran.uwm301.body   =  stat.maktab_fil.body
                sic_bran.uwm301.tons   =  stat.maktab_fil.tons
                sic_bran.uwm301.seats  =  stat.maktab_fil.seats.
        END.
        ELSE DO:
            FIND FIRST stat.maktab_fil USE-INDEX      maktab04         WHERE
                stat.maktab_fil.makdes   =     wdetail.brand             And                  
                INDEX(stat.maktab_fil.moddes,SUBSTRING(wdetail.model,1,INDEX(wdetail.model," "))) <> 0  AND
                stat.maktab_fil.makyea   =     INTEGER(wdetail.caryear) AND
                stat.maktab_fil.engine   =     INTEGER(wdetail.engcc)   AND
                stat.maktab_fil.sclass   =     SUBSTRING(wdetail.class,2,3)      AND
                (stat.maktab_fil.si - (stat.maktab_fil.si * 20 / 100 ) LE wdetail.si   AND 
                 stat.maktab_fil.si + (stat.maktab_fil.si * 20 / 100 ) GE wdetail.si ) AND
                stat.maktab_fil.seats    =   INTE(wdetail.seat)     NO-LOCK NO-ERROR NO-WAIT.
            IF  AVAIL stat.maktab_fil  THEN 
                ASSIGN nv_modcod =  stat.maktab_fil.modcod                                    
                nv_moddes        =  stat.maktab_fil.makdes  +  " "  +  stat.maktab_fil.moddes
                wdetail.cargrp   =  stat.maktab_fil.prmpac
                wdetail.redbook  =  stat.maktab_fil.modcod
                sic_bran.uwm301.tons   = IF sic_bran.uwm301.tons = 0 THEN stat.maktab_fil.tons ELSE sic_bran.uwm301.tons . /*A63-0162*/
        END.
        IF sic_bran.uwm301.modcod = ""  THEN RUN proc_maktab.
    END.
    RUN proc_chktons. /*A63-0162*/

END.  /* 301 */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE proc_var C-Win 
PROCEDURE proc_var :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

ASSIGN
    s_riskgp   =   0                     s_riskno       =  1
    s_itemno   =   1                     nv_undyr       = STRING(YEAR(TODAY),"9999")   
    n_rencnt   =   0                     n_endcnt       =  0.
   
    
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

